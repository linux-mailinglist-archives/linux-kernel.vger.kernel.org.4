Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E065B695B56
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 08:55:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231410AbjBNHzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 02:55:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231520AbjBNHyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 02:54:44 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61F8F65B9
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 23:54:41 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id n33so4344159wms.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 23:54:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ky4IArkX/VTj06BJAbEHiBvqIBUqg7D25fHmKbBw4Ug=;
        b=abPdPD4gq8j6v8G9X0+OFl++7S+w+qXiqdok7QA7DqpPWfiVpEIcw3OzGQj5IPbMqN
         /cGvij4aGTKVOpYx0ZZqJOm1h/HREvmxQT6lnKiCgKAEibteyBwQ2nW2TTPbUc5XnKOt
         dVjldpGSat9WFv+TuibizNHAlKXdPo/de/vJ9OScNnNZyey2gfLk2kWHL3VEqBea3C/V
         6MyHK2rQQkQQc3uPcrGCUE/TgacMBJjRpLfs9hqwvGhjHvPSE1Tmp9PtHDxRaTZaSiAt
         I32+eOCwGixmNjtGzm4e3lj1reyo6hnINX/NAS7rIY2AQVMxkZd1AqyQASz8tHwJK/R7
         Bd0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ky4IArkX/VTj06BJAbEHiBvqIBUqg7D25fHmKbBw4Ug=;
        b=ehgQTG1Mw+UpQOjzTvrJcEVebHXrBgIB+VORsDzJfYQqlgenSgHPGW9c7MuRrAdG25
         mWhLgV3Gf3RpoWqa7oP4cQJIRlAqFNS/ZHOPYxXGUJqYf1zcmoIthfpyao+F3+tMs5Cd
         erHW3F7jyi5K/+fGaXirgIcy71qrL3EgqVPqzPgptAdKvrhMFlIch8IH1y94Qlqd6QPM
         bkAHsJWZ9qbtQhABpAsW6NBQvGU8qZh4qAIUeCzHQHD9ZMlUcXT5Ln3m5Lxr/PLtasQV
         cInRxz3Ri1A4cwpoz1XKQp/Oc19Fd2hl8y0rx/ZBSho5d2QX55TZaFahyXh2NqPhWJam
         KP5w==
X-Gm-Message-State: AO0yUKV6J5fli9xW55BCEyC21TuOlOOi7k892vFcaZmEXDdt6j05pd/M
        +SG/MWx192HEcB7vdgU3fjU=
X-Google-Smtp-Source: AK7set99QiPd4AoSGLK4TObn/WKe0rWgoCMAkLr0ytbKRGOasnrxH1oI4McWR8HWGuX349Vgp+NmIg==
X-Received: by 2002:a05:600c:a698:b0:3db:bc5:b2ae with SMTP id ip24-20020a05600ca69800b003db0bc5b2aemr1023112wmb.41.1676361279814;
        Mon, 13 Feb 2023 23:54:39 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id q13-20020adff94d000000b002be099f78c0sm12160611wrr.69.2023.02.13.23.54.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 23:54:39 -0800 (PST)
Date:   Tue, 14 Feb 2023 10:54:24 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     oe-kbuild@lists.linux.dev, Mason Huo <mason.huo@starfivetech.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Mason Huo <mason.huo@starfivetech.com>,
        Ley Foon Tan <leyfoon.tan@starfivetech.com>,
        Sia Jee Heng <jeeheng.sia@starfivetech.com>
Subject: Re: [PATCH v3] irqchip/irq-sifive-plic: Add syscore callbacks for
 hibernation
Message-ID: <202302140709.CdkxgtPi-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230210100122.80255-1-mason.huo@starfivetech.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mason,

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Mason-Huo/irqchip-irq-sifive-plic-Add-syscore-callbacks-for-hibernation/20230210-180324
patch link:    https://lore.kernel.org/r/20230210100122.80255-1-mason.huo%40starfivetech.com
patch subject: [PATCH v3] irqchip/irq-sifive-plic: Add syscore callbacks for hibernation
config: riscv-randconfig-m031-20230212 (https://download.01.org/0day-ci/archive/20230214/202302140709.CdkxgtPi-lkp@intel.com/config)
compiler: riscv32-linux-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <error27@gmail.com>
| Link: https://lore.kernel.org/r/202302140709.CdkxgtPi-lkp@intel.com/

smatch warnings:
drivers/irqchip/irq-sifive-plic.c:521 __plic_init() warn: double check that we're allocating correct size: 4 vs 32

vim +521 drivers/irqchip/irq-sifive-plic.c

dd46337ca69662 Lad Prabhakar     2022-06-30  409  static int __init __plic_init(struct device_node *node,
dd46337ca69662 Lad Prabhakar     2022-06-30  410  			      struct device_node *parent,
dd46337ca69662 Lad Prabhakar     2022-06-30  411  			      unsigned long plic_quirks)
8237f8bc4f6eb7 Christoph Hellwig 2018-07-26  412  {
6adfe8d2f5b353 Anup Patel        2019-02-12  413  	int error = 0, nr_contexts, nr_handlers = 0, i;
8237f8bc4f6eb7 Christoph Hellwig 2018-07-26  414  	u32 nr_irqs;
f1ad1133b18f2a Atish Patra       2020-03-02  415  	struct plic_priv *priv;
2234ae846ccb9e Anup Patel        2020-05-18  416  	struct plic_handler *handler;
2858a4d6b620ef Mason Huo         2023-02-10  417  	unsigned int cpu;
8237f8bc4f6eb7 Christoph Hellwig 2018-07-26  418  
f1ad1133b18f2a Atish Patra       2020-03-02  419  	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
f1ad1133b18f2a Atish Patra       2020-03-02  420  	if (!priv)
f1ad1133b18f2a Atish Patra       2020-03-02  421  		return -ENOMEM;
8237f8bc4f6eb7 Christoph Hellwig 2018-07-26  422  
dd46337ca69662 Lad Prabhakar     2022-06-30  423  	priv->plic_quirks = plic_quirks;
dd46337ca69662 Lad Prabhakar     2022-06-30  424  
f1ad1133b18f2a Atish Patra       2020-03-02  425  	priv->regs = of_iomap(node, 0);
f1ad1133b18f2a Atish Patra       2020-03-02  426  	if (WARN_ON(!priv->regs)) {
f1ad1133b18f2a Atish Patra       2020-03-02  427  		error = -EIO;
f1ad1133b18f2a Atish Patra       2020-03-02  428  		goto out_free_priv;
f1ad1133b18f2a Atish Patra       2020-03-02  429  	}
8237f8bc4f6eb7 Christoph Hellwig 2018-07-26  430  
8237f8bc4f6eb7 Christoph Hellwig 2018-07-26  431  	error = -EINVAL;
8237f8bc4f6eb7 Christoph Hellwig 2018-07-26  432  	of_property_read_u32(node, "riscv,ndev", &nr_irqs);
8237f8bc4f6eb7 Christoph Hellwig 2018-07-26  433  	if (WARN_ON(!nr_irqs))
8237f8bc4f6eb7 Christoph Hellwig 2018-07-26  434  		goto out_iounmap;
8237f8bc4f6eb7 Christoph Hellwig 2018-07-26  435  
2858a4d6b620ef Mason Huo         2023-02-10  436  	priv->nr_irqs = nr_irqs;
2858a4d6b620ef Mason Huo         2023-02-10  437  
2858a4d6b620ef Mason Huo         2023-02-10  438  	priv->prio_save = bitmap_alloc(nr_irqs, GFP_KERNEL);
2858a4d6b620ef Mason Huo         2023-02-10  439  	if (!priv->prio_save)
2858a4d6b620ef Mason Huo         2023-02-10  440  		goto out_free_priority_reg;
2858a4d6b620ef Mason Huo         2023-02-10  441  
6adfe8d2f5b353 Anup Patel        2019-02-12  442  	nr_contexts = of_irq_count(node);
6adfe8d2f5b353 Anup Patel        2019-02-12  443  	if (WARN_ON(!nr_contexts))
2858a4d6b620ef Mason Huo         2023-02-10  444  		goto out_free_priority_reg;
8237f8bc4f6eb7 Christoph Hellwig 2018-07-26  445  
8237f8bc4f6eb7 Christoph Hellwig 2018-07-26  446  	error = -ENOMEM;
f1ad1133b18f2a Atish Patra       2020-03-02  447  	priv->irqdomain = irq_domain_add_linear(node, nr_irqs + 1,
f1ad1133b18f2a Atish Patra       2020-03-02  448  			&plic_irqdomain_ops, priv);
f1ad1133b18f2a Atish Patra       2020-03-02  449  	if (WARN_ON(!priv->irqdomain))
2858a4d6b620ef Mason Huo         2023-02-10  450  		goto out_free_priority_reg;
8237f8bc4f6eb7 Christoph Hellwig 2018-07-26  451  
6adfe8d2f5b353 Anup Patel        2019-02-12  452  	for (i = 0; i < nr_contexts; i++) {
8237f8bc4f6eb7 Christoph Hellwig 2018-07-26  453  		struct of_phandle_args parent;
8237f8bc4f6eb7 Christoph Hellwig 2018-07-26  454  		irq_hw_number_t hwirq;
ad635e723e1737 Sunil V L         2022-05-27  455  		int cpu;
ad635e723e1737 Sunil V L         2022-05-27  456  		unsigned long hartid;
8237f8bc4f6eb7 Christoph Hellwig 2018-07-26  457  
8237f8bc4f6eb7 Christoph Hellwig 2018-07-26  458  		if (of_irq_parse_one(node, i, &parent)) {
8237f8bc4f6eb7 Christoph Hellwig 2018-07-26  459  			pr_err("failed to parse parent for context %d.\n", i);
8237f8bc4f6eb7 Christoph Hellwig 2018-07-26  460  			continue;
8237f8bc4f6eb7 Christoph Hellwig 2018-07-26  461  		}
8237f8bc4f6eb7 Christoph Hellwig 2018-07-26  462  
a4c3733d32a72f Christoph Hellwig 2019-10-28  463  		/*
a4c3733d32a72f Christoph Hellwig 2019-10-28  464  		 * Skip contexts other than external interrupts for our
a4c3733d32a72f Christoph Hellwig 2019-10-28  465  		 * privilege level.
a4c3733d32a72f Christoph Hellwig 2019-10-28  466  		 */
098fdbc3531f06 Niklas Cassel     2022-03-02  467  		if (parent.args[0] != RV_IRQ_EXT) {
098fdbc3531f06 Niklas Cassel     2022-03-02  468  			/* Disable S-mode enable bits if running in M-mode. */
098fdbc3531f06 Niklas Cassel     2022-03-02  469  			if (IS_ENABLED(CONFIG_RISCV_M_MODE)) {
098fdbc3531f06 Niklas Cassel     2022-03-02  470  				void __iomem *enable_base = priv->regs +
098fdbc3531f06 Niklas Cassel     2022-03-02  471  					CONTEXT_ENABLE_BASE +
098fdbc3531f06 Niklas Cassel     2022-03-02  472  					i * CONTEXT_ENABLE_SIZE;
098fdbc3531f06 Niklas Cassel     2022-03-02  473  
098fdbc3531f06 Niklas Cassel     2022-03-02  474  				for (hwirq = 1; hwirq <= nr_irqs; hwirq++)
098fdbc3531f06 Niklas Cassel     2022-03-02  475  					__plic_toggle(enable_base, hwirq, 0);
098fdbc3531f06 Niklas Cassel     2022-03-02  476  			}
8237f8bc4f6eb7 Christoph Hellwig 2018-07-26  477  			continue;
098fdbc3531f06 Niklas Cassel     2022-03-02  478  		}
8237f8bc4f6eb7 Christoph Hellwig 2018-07-26  479  
ad635e723e1737 Sunil V L         2022-05-27  480  		error = riscv_of_parent_hartid(parent.np, &hartid);
ad635e723e1737 Sunil V L         2022-05-27  481  		if (error < 0) {
8237f8bc4f6eb7 Christoph Hellwig 2018-07-26  482  			pr_warn("failed to parse hart ID for context %d.\n", i);
8237f8bc4f6eb7 Christoph Hellwig 2018-07-26  483  			continue;
8237f8bc4f6eb7 Christoph Hellwig 2018-07-26  484  		}
8237f8bc4f6eb7 Christoph Hellwig 2018-07-26  485  
f99fb607fb2bc0 Atish Patra       2018-10-02  486  		cpu = riscv_hartid_to_cpuid(hartid);
fc03acaeab358c Atish Patra       2019-02-12  487  		if (cpu < 0) {
fc03acaeab358c Atish Patra       2019-02-12  488  			pr_warn("Invalid cpuid for context %d\n", i);
fc03acaeab358c Atish Patra       2019-02-12  489  			continue;
fc03acaeab358c Atish Patra       2019-02-12  490  		}
fc03acaeab358c Atish Patra       2019-02-12  491  
6b7ce8927b5a4d Anup Patel        2020-06-01  492  		/* Find parent domain and register chained handler */
6b7ce8927b5a4d Anup Patel        2020-06-01  493  		if (!plic_parent_irq && irq_find_host(parent.np)) {
6b7ce8927b5a4d Anup Patel        2020-06-01  494  			plic_parent_irq = irq_of_parse_and_map(node, i);
6b7ce8927b5a4d Anup Patel        2020-06-01  495  			if (plic_parent_irq)
6b7ce8927b5a4d Anup Patel        2020-06-01  496  				irq_set_chained_handler(plic_parent_irq,
6b7ce8927b5a4d Anup Patel        2020-06-01  497  							plic_handle_irq);
6b7ce8927b5a4d Anup Patel        2020-06-01  498  		}
6b7ce8927b5a4d Anup Patel        2020-06-01  499  
9ce06497c2722a Christoph Hellwig 2019-09-03  500  		/*
9ce06497c2722a Christoph Hellwig 2019-09-03  501  		 * When running in M-mode we need to ignore the S-mode handler.
9ce06497c2722a Christoph Hellwig 2019-09-03  502  		 * Here we assume it always comes later, but that might be a
9ce06497c2722a Christoph Hellwig 2019-09-03  503  		 * little fragile.
9ce06497c2722a Christoph Hellwig 2019-09-03  504  		 */
8237f8bc4f6eb7 Christoph Hellwig 2018-07-26  505  		handler = per_cpu_ptr(&plic_handlers, cpu);
3fecb5aac28888 Anup Patel        2019-02-12  506  		if (handler->present) {
3fecb5aac28888 Anup Patel        2019-02-12  507  			pr_warn("handler already present for context %d.\n", i);
ccbe80bad571c2 Atish Patra       2020-03-02  508  			plic_set_threshold(handler, PLIC_DISABLE_THRESHOLD);
9ce06497c2722a Christoph Hellwig 2019-09-03  509  			goto done;
3fecb5aac28888 Anup Patel        2019-02-12  510  		}
3fecb5aac28888 Anup Patel        2019-02-12  511  
f1ad1133b18f2a Atish Patra       2020-03-02  512  		cpumask_set_cpu(cpu, &priv->lmask);
8237f8bc4f6eb7 Christoph Hellwig 2018-07-26  513  		handler->present = true;
0d3616bbd03cdf Niklas Cassel     2022-03-02  514  		handler->hart_base = priv->regs + CONTEXT_BASE +
0d3616bbd03cdf Niklas Cassel     2022-03-02  515  			i * CONTEXT_SIZE;
86c7cbf1e8d1d4 Anup Patel        2019-02-12  516  		raw_spin_lock_init(&handler->enable_lock);
0d3616bbd03cdf Niklas Cassel     2022-03-02  517  		handler->enable_base = priv->regs + CONTEXT_ENABLE_BASE +
0d3616bbd03cdf Niklas Cassel     2022-03-02  518  			i * CONTEXT_ENABLE_SIZE;
f1ad1133b18f2a Atish Patra       2020-03-02  519  		handler->priv = priv;
2858a4d6b620ef Mason Huo         2023-02-10  520  
2858a4d6b620ef Mason Huo         2023-02-10 @521  		handler->enable_save =  kcalloc(DIV_ROUND_UP(nr_irqs, 32),
2858a4d6b620ef Mason Huo         2023-02-10  522  						32, GFP_KERNEL);

Smatch is correct that this should be allocating
sizeof(*handler->enable_save) which is 4 bytes instead of 32 bytes.
I looked at the code, and this is a bits vs bytes bug.

2858a4d6b620ef Mason Huo         2023-02-10  523  		if (!handler->enable_save)
2858a4d6b620ef Mason Huo         2023-02-10  524  			goto out_free_enable_reg;
9ce06497c2722a Christoph Hellwig 2019-09-03  525  done:
a1706a1c5062e0 Samuel Holland    2022-07-01  526  		for (hwirq = 1; hwirq <= nr_irqs; hwirq++) {
86c7cbf1e8d1d4 Anup Patel        2019-02-12  527  			plic_toggle(handler, hwirq, 0);
a1706a1c5062e0 Samuel Holland    2022-07-01  528  			writel(1, priv->regs + PRIORITY_BASE +
a1706a1c5062e0 Samuel Holland    2022-07-01  529  				  hwirq * PRIORITY_PER_ID);
a1706a1c5062e0 Samuel Holland    2022-07-01  530  		}
6adfe8d2f5b353 Anup Patel        2019-02-12  531  		nr_handlers++;
8237f8bc4f6eb7 Christoph Hellwig 2018-07-26  532  	}
8237f8bc4f6eb7 Christoph Hellwig 2018-07-26  533  
2234ae846ccb9e Anup Patel        2020-05-18  534  	/*
2234ae846ccb9e Anup Patel        2020-05-18  535  	 * We can have multiple PLIC instances so setup cpuhp state only
2234ae846ccb9e Anup Patel        2020-05-18  536  	 * when context handler for current/boot CPU is present.
2234ae846ccb9e Anup Patel        2020-05-18  537  	 */
2234ae846ccb9e Anup Patel        2020-05-18  538  	handler = this_cpu_ptr(&plic_handlers);
2234ae846ccb9e Anup Patel        2020-05-18  539  	if (handler->present && !plic_cpuhp_setup_done) {
ccbe80bad571c2 Atish Patra       2020-03-02  540  		cpuhp_setup_state(CPUHP_AP_IRQ_SIFIVE_PLIC_STARTING,
ccbe80bad571c2 Atish Patra       2020-03-02  541  				  "irqchip/sifive/plic:starting",
ccbe80bad571c2 Atish Patra       2020-03-02  542  				  plic_starting_cpu, plic_dying_cpu);
2234ae846ccb9e Anup Patel        2020-05-18  543  		plic_cpuhp_setup_done = true;
2234ae846ccb9e Anup Patel        2020-05-18  544  	}
2858a4d6b620ef Mason Huo         2023-02-10  545  	register_syscore_ops(&plic_irq_syscore_ops);
2234ae846ccb9e Anup Patel        2020-05-18  546  
0e375f51017bcc Anup Patel        2020-05-18  547  	pr_info("%pOFP: mapped %d interrupts with %d handlers for"
0e375f51017bcc Anup Patel        2020-05-18  548  		" %d contexts.\n", node, nr_irqs, nr_handlers, nr_contexts);
8237f8bc4f6eb7 Christoph Hellwig 2018-07-26  549  	return 0;
8237f8bc4f6eb7 Christoph Hellwig 2018-07-26  550  
2858a4d6b620ef Mason Huo         2023-02-10  551  out_free_enable_reg:
2858a4d6b620ef Mason Huo         2023-02-10  552  	for_each_cpu(cpu, cpu_present_mask) {
2858a4d6b620ef Mason Huo         2023-02-10  553  		handler = per_cpu_ptr(&plic_handlers, cpu);
2858a4d6b620ef Mason Huo         2023-02-10  554  		kfree(handler->enable_save);
2858a4d6b620ef Mason Huo         2023-02-10  555  	}
2858a4d6b620ef Mason Huo         2023-02-10  556  out_free_priority_reg:
2858a4d6b620ef Mason Huo         2023-02-10  557  	kfree(priv->prio_save);
8237f8bc4f6eb7 Christoph Hellwig 2018-07-26  558  out_iounmap:
f1ad1133b18f2a Atish Patra       2020-03-02  559  	iounmap(priv->regs);
f1ad1133b18f2a Atish Patra       2020-03-02  560  out_free_priv:
f1ad1133b18f2a Atish Patra       2020-03-02  561  	kfree(priv);
8237f8bc4f6eb7 Christoph Hellwig 2018-07-26  562  	return error;
8237f8bc4f6eb7 Christoph Hellwig 2018-07-26  563  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests

