Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 964B769F5F9
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 14:57:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230466AbjBVN5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 08:57:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjBVN5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 08:57:22 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FDD63754D
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 05:57:20 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id bo30so7258228wrb.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 05:57:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jAFB9lxCsQKbsKAu+na58e3iDY0+4dAenNg2pp8fhaA=;
        b=mi00TfF4MqC+QLmiHZviVufeYR/HqpywIDqK/j4VhRJTyhdi/Oa07ejsbJ/DXxvfS2
         fI/1bO+VOTN1M3rqwA6wgvzUWDnFodjgmDikp0XaCT6oeX/OA7j0+5xY5uRjn7zKm+Pq
         WaHFITaOcv1CeldfJChxA9bUE9dHarwy/GkaSfUX57NS+tbDRTqeX0B5DsPMXgcTsF5K
         jPBHyc93xfxpzm5OkG3npDPXXpV38TycS1sS1VjwDddrX/Kjgto+PaZGyJcDswVZPxe7
         +fvAcM3rYSt494SBpoaJ0jd6PvThxXj+t1bec/YPHLdDBS/O9v3F1GBjS5nrwC1lmrS8
         1UKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jAFB9lxCsQKbsKAu+na58e3iDY0+4dAenNg2pp8fhaA=;
        b=VQD7MNlZbgxJoeqRShPNUehfYM6AMmhwiC5RX98P/avRVOxCysGD6yRGjpvBZsPJyD
         Vldra+hAfmbLNAUAVn7dcIi7woUVYfQlKI6oqe8Zt9qgb1TmirEy6VkGTiVqT2j/vUtK
         i8cnHFY4VaX0LdveCSo74t6y2wuodeOVDBgNrKt9o9bW66i7clEiJQ4tW52Yyp7iEC0t
         mC/Xi3VzIs8lk+KPAjVUUSl3526ZC9eAcZ2IqAJ35gyOmUiqJM5PYEmhqxycl59GVpRM
         hUye5It7Cv7bzYyjoAhYFppcWoDvg1aaqtHzAQBEuvBSgy2NMChe0lAyvHmVcs+hXhIF
         tKpA==
X-Gm-Message-State: AO0yUKXq6xl3FPCyAITk7Uu/nBYb0FXgR1dWOoz2FqXa5ZSaqvxbpeHK
        6i9JgFOWTaCuTLNnalM4cxM=
X-Google-Smtp-Source: AK7set/xrsabHAmL/Exb0lDGLJ8jIay91OsxEMf3GT4yqgExMQxYCub+hcEE8YpqUNqRp7z9CGLTZw==
X-Received: by 2002:a5d:49d0:0:b0:2c6:e744:cf71 with SMTP id t16-20020a5d49d0000000b002c6e744cf71mr7685237wrs.52.1677074238978;
        Wed, 22 Feb 2023 05:57:18 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id t4-20020adff044000000b002c5694aef92sm7221995wro.21.2023.02.22.05.57.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 05:57:18 -0800 (PST)
Date:   Wed, 22 Feb 2023 16:57:15 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     oe-kbuild@lists.linux.dev, Sean Anderson <seanga2@gmail.com>
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>
Subject: drivers/net/ethernet/sun/sunhme.c:2961 happy_meal_pci_probe() warn:
 missing error code 'err'
Message-ID: <202302191530.YKNv9kNx-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   925cf0457d7e62ce08878ffb789189ac08ca8677
commit: 5b3dc6dda6b1af8a6117d99394a6db81ec9be3d5 sunhme: Regularize probe errors
config: s390-randconfig-m031-20230219 (https://download.01.org/0day-ci/archive/20230219/202302191530.YKNv9kNx-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <error27@gmail.com>
| Link: https://lore.kernel.org/r/202302191530.YKNv9kNx-lkp@intel.com/

smatch warnings:
drivers/net/ethernet/sun/sunhme.c:2961 happy_meal_pci_probe() warn: missing error code 'err'

vim +/err +2961 drivers/net/ethernet/sun/sunhme.c

^1da177e4c3f41 drivers/net/sunhme.c              Linus Torvalds   2005-04-16  2943  
acb3f35f920b53 drivers/net/ethernet/sun/sunhme.c Rolf Eike Beer   2022-09-23  2944  	err = pci_enable_device(pdev);
acb3f35f920b53 drivers/net/ethernet/sun/sunhme.c Rolf Eike Beer   2022-09-23  2945  	if (err)
ef9467f8f08038 drivers/net/sunhme.c              Jurij Smakov     2006-12-03  2946  		goto err_out;
ef9467f8f08038 drivers/net/sunhme.c              Jurij Smakov     2006-12-03  2947  	pci_set_master(pdev);
ef9467f8f08038 drivers/net/sunhme.c              Jurij Smakov     2006-12-03  2948  
^1da177e4c3f41 drivers/net/sunhme.c              Linus Torvalds   2005-04-16  2949  	if (!strcmp(prom_name, "SUNW,qfe") || !strcmp(prom_name, "qfe")) {
^1da177e4c3f41 drivers/net/sunhme.c              Linus Torvalds   2005-04-16  2950  		qp = quattro_pci_find(pdev);
d6f1e89bdbb873 drivers/net/ethernet/sun/sunhme.c Sean Anderson    2022-09-23  2951  		if (IS_ERR(qp)) {
d6f1e89bdbb873 drivers/net/ethernet/sun/sunhme.c Sean Anderson    2022-09-23  2952  			err = PTR_ERR(qp);
^1da177e4c3f41 drivers/net/sunhme.c              Linus Torvalds   2005-04-16  2953  			goto err_out;
d6f1e89bdbb873 drivers/net/ethernet/sun/sunhme.c Sean Anderson    2022-09-23  2954  		}
d6f1e89bdbb873 drivers/net/ethernet/sun/sunhme.c Sean Anderson    2022-09-23  2955  
^1da177e4c3f41 drivers/net/sunhme.c              Linus Torvalds   2005-04-16  2956  		for (qfe_slot = 0; qfe_slot < 4; qfe_slot++)
d6f1e89bdbb873 drivers/net/ethernet/sun/sunhme.c Sean Anderson    2022-09-23  2957  			if (!qp->happy_meals[qfe_slot])
^1da177e4c3f41 drivers/net/sunhme.c              Linus Torvalds   2005-04-16  2958  				break;
d6f1e89bdbb873 drivers/net/ethernet/sun/sunhme.c Sean Anderson    2022-09-23  2959  
^1da177e4c3f41 drivers/net/sunhme.c              Linus Torvalds   2005-04-16  2960  		if (qfe_slot == 4)
^1da177e4c3f41 drivers/net/sunhme.c              Linus Torvalds   2005-04-16 @2961  			goto err_out;

This looks like an error path...

^1da177e4c3f41 drivers/net/sunhme.c              Linus Torvalds   2005-04-16  2962  	}
^1da177e4c3f41 drivers/net/sunhme.c              Linus Torvalds   2005-04-16  2963  
^1da177e4c3f41 drivers/net/sunhme.c              Linus Torvalds   2005-04-16  2964  	dev = alloc_etherdev(sizeof(struct happy_meal));
5b3dc6dda6b1af drivers/net/ethernet/sun/sunhme.c Sean Anderson    2022-09-23  2965  	if (!dev) {
^1da177e4c3f41 drivers/net/sunhme.c              Linus Torvalds   2005-04-16  2966  		err = -ENOMEM;
^1da177e4c3f41 drivers/net/sunhme.c              Linus Torvalds   2005-04-16  2967  		goto err_out;
5b3dc6dda6b1af drivers/net/ethernet/sun/sunhme.c Sean Anderson    2022-09-23  2968  	}
^1da177e4c3f41 drivers/net/sunhme.c              Linus Torvalds   2005-04-16  2969  	SET_NETDEV_DEV(dev, &pdev->dev);
^1da177e4c3f41 drivers/net/sunhme.c              Linus Torvalds   2005-04-16  2970  
8f15ea42b64941 drivers/net/sunhme.c              Wang Chen        2008-11-12  2971  	hp = netdev_priv(dev);
^1da177e4c3f41 drivers/net/sunhme.c              Linus Torvalds   2005-04-16  2972  
^1da177e4c3f41 drivers/net/sunhme.c              Linus Torvalds   2005-04-16  2973  	hp->happy_dev = pdev;
db1a8611c87337 drivers/net/sunhme.c              David S. Miller  2008-08-29  2974  	hp->dma_dev = &pdev->dev;
^1da177e4c3f41 drivers/net/sunhme.c              Linus Torvalds   2005-04-16  2975  
^1da177e4c3f41 drivers/net/sunhme.c              Linus Torvalds   2005-04-16  2976  	spin_lock_init(&hp->happy_lock);
^1da177e4c3f41 drivers/net/sunhme.c              Linus Torvalds   2005-04-16  2977  
^1da177e4c3f41 drivers/net/sunhme.c              Linus Torvalds   2005-04-16  2978  	if (qp != NULL) {
^1da177e4c3f41 drivers/net/sunhme.c              Linus Torvalds   2005-04-16  2979  		hp->qfe_parent = qp;
^1da177e4c3f41 drivers/net/sunhme.c              Linus Torvalds   2005-04-16  2980  		hp->qfe_ent = qfe_slot;
^1da177e4c3f41 drivers/net/sunhme.c              Linus Torvalds   2005-04-16  2981  		qp->happy_meals[qfe_slot] = dev;
^1da177e4c3f41 drivers/net/sunhme.c              Linus Torvalds   2005-04-16  2982  	}
^1da177e4c3f41 drivers/net/sunhme.c              Linus Torvalds   2005-04-16  2983  
^1da177e4c3f41 drivers/net/sunhme.c              Linus Torvalds   2005-04-16  2984  	hpreg_res = pci_resource_start(pdev, 0);
5b3dc6dda6b1af drivers/net/ethernet/sun/sunhme.c Sean Anderson    2022-09-23  2985  	err = -EINVAL;
^1da177e4c3f41 drivers/net/sunhme.c              Linus Torvalds   2005-04-16  2986  	if ((pci_resource_flags(pdev, 0) & IORESOURCE_IO) != 0) {
^1da177e4c3f41 drivers/net/sunhme.c              Linus Torvalds   2005-04-16  2987  		printk(KERN_ERR "happymeal(PCI): Cannot find proper PCI device base address.\n");
^1da177e4c3f41 drivers/net/sunhme.c              Linus Torvalds   2005-04-16  2988  		goto err_out_clear_quattro;
^1da177e4c3f41 drivers/net/sunhme.c              Linus Torvalds   2005-04-16  2989  	}
5b3dc6dda6b1af drivers/net/ethernet/sun/sunhme.c Sean Anderson    2022-09-23  2990  
5b3dc6dda6b1af drivers/net/ethernet/sun/sunhme.c Sean Anderson    2022-09-23  2991  	err = pci_request_regions(pdev, DRV_NAME);
5b3dc6dda6b1af drivers/net/ethernet/sun/sunhme.c Sean Anderson    2022-09-23  2992  	if (err) {
^1da177e4c3f41 drivers/net/sunhme.c              Linus Torvalds   2005-04-16  2993  		printk(KERN_ERR "happymeal(PCI): Cannot obtain PCI resources, "
^1da177e4c3f41 drivers/net/sunhme.c              Linus Torvalds   2005-04-16  2994  		       "aborting.\n");
^1da177e4c3f41 drivers/net/sunhme.c              Linus Torvalds   2005-04-16  2995  		goto err_out_clear_quattro;
^1da177e4c3f41 drivers/net/sunhme.c              Linus Torvalds   2005-04-16  2996  	}
^1da177e4c3f41 drivers/net/sunhme.c              Linus Torvalds   2005-04-16  2997  
5b3dc6dda6b1af drivers/net/ethernet/sun/sunhme.c Sean Anderson    2022-09-23  2998  	hpreg_base = ioremap(hpreg_res, 0x8000);
5b3dc6dda6b1af drivers/net/ethernet/sun/sunhme.c Sean Anderson    2022-09-23  2999  	if (!hpreg_base) {
5b3dc6dda6b1af drivers/net/ethernet/sun/sunhme.c Sean Anderson    2022-09-23  3000  		err = -ENOMEM;
^1da177e4c3f41 drivers/net/sunhme.c              Linus Torvalds   2005-04-16  3001  		printk(KERN_ERR "happymeal(PCI): Unable to remap card memory.\n");
^1da177e4c3f41 drivers/net/sunhme.c              Linus Torvalds   2005-04-16  3002  		goto err_out_free_res;
^1da177e4c3f41 drivers/net/sunhme.c              Linus Torvalds   2005-04-16  3003  	}
^1da177e4c3f41 drivers/net/sunhme.c              Linus Torvalds   2005-04-16  3004  
^1da177e4c3f41 drivers/net/sunhme.c              Linus Torvalds   2005-04-16  3005  	for (i = 0; i < 6; i++) {
^1da177e4c3f41 drivers/net/sunhme.c              Linus Torvalds   2005-04-16  3006  		if (macaddr[i] != 0)
^1da177e4c3f41 drivers/net/sunhme.c              Linus Torvalds   2005-04-16  3007  			break;
^1da177e4c3f41 drivers/net/sunhme.c              Linus Torvalds   2005-04-16  3008  	}
^1da177e4c3f41 drivers/net/sunhme.c              Linus Torvalds   2005-04-16  3009  	if (i < 6) { /* a mac address was given */
^1da177e4c3f41 drivers/net/sunhme.c              Linus Torvalds   2005-04-16  3010  		for (i = 0; i < 6; i++)
a7639279c93c1e drivers/net/ethernet/sun/sunhme.c Jakub Kicinski   2021-10-08  3011  			addr[i] = macaddr[i];
a7639279c93c1e drivers/net/ethernet/sun/sunhme.c Jakub Kicinski   2021-10-08  3012  		eth_hw_addr_set(dev, addr);
^1da177e4c3f41 drivers/net/sunhme.c              Linus Torvalds   2005-04-16  3013  		macaddr[5]++;
^1da177e4c3f41 drivers/net/sunhme.c              Linus Torvalds   2005-04-16  3014  	} else {
9e326acf567b60 drivers/net/sunhme.c              David S. Miller  2006-06-23  3015  #ifdef CONFIG_SPARC
ccf0dec6fcadb4 drivers/net/sunhme.c              Stephen Rothwell 2007-03-29  3016  		const unsigned char *addr;
de8d28b16f5614 drivers/net/sunhme.c              David S. Miller  2006-06-22  3017  		int len;
de8d28b16f5614 drivers/net/sunhme.c              David S. Miller  2006-06-22  3018  
^1da177e4c3f41 drivers/net/sunhme.c              Linus Torvalds   2005-04-16  3019  		if (qfe_slot != -1 &&
8e95a2026f3b43 drivers/net/sunhme.c              Joe Perches      2009-12-03  3020  		    (addr = of_get_property(dp, "local-mac-address", &len))
8e95a2026f3b43 drivers/net/sunhme.c              Joe Perches      2009-12-03  3021  			!= NULL &&
8e95a2026f3b43 drivers/net/sunhme.c              Joe Perches      2009-12-03  3022  		    len == 6) {
a96d317fb1a30b drivers/net/ethernet/sun/sunhme.c Jakub Kicinski   2021-10-01  3023  			eth_hw_addr_set(dev, addr);
^1da177e4c3f41 drivers/net/sunhme.c              Linus Torvalds   2005-04-16  3024  		} else {
a96d317fb1a30b drivers/net/ethernet/sun/sunhme.c Jakub Kicinski   2021-10-01  3025  			eth_hw_addr_set(dev, idprom->id_ethaddr);
^1da177e4c3f41 drivers/net/sunhme.c              Linus Torvalds   2005-04-16  3026  		}
^1da177e4c3f41 drivers/net/sunhme.c              Linus Torvalds   2005-04-16  3027  #else
a7639279c93c1e drivers/net/ethernet/sun/sunhme.c Jakub Kicinski   2021-10-08  3028  		u8 addr[ETH_ALEN];
a7639279c93c1e drivers/net/ethernet/sun/sunhme.c Jakub Kicinski   2021-10-08  3029  
a7639279c93c1e drivers/net/ethernet/sun/sunhme.c Jakub Kicinski   2021-10-08  3030  		get_hme_mac_nonsparc(pdev, addr);
a7639279c93c1e drivers/net/ethernet/sun/sunhme.c Jakub Kicinski   2021-10-08  3031  		eth_hw_addr_set(dev, addr);
^1da177e4c3f41 drivers/net/sunhme.c              Linus Torvalds   2005-04-16  3032  #endif
^1da177e4c3f41 drivers/net/sunhme.c              Linus Torvalds   2005-04-16  3033  	}
^1da177e4c3f41 drivers/net/sunhme.c              Linus Torvalds   2005-04-16  3034  
^1da177e4c3f41 drivers/net/sunhme.c              Linus Torvalds   2005-04-16  3035  	/* Layout registers. */
^1da177e4c3f41 drivers/net/sunhme.c              Linus Torvalds   2005-04-16  3036  	hp->gregs      = (hpreg_base + 0x0000UL);
^1da177e4c3f41 drivers/net/sunhme.c              Linus Torvalds   2005-04-16  3037  	hp->etxregs    = (hpreg_base + 0x2000UL);
^1da177e4c3f41 drivers/net/sunhme.c              Linus Torvalds   2005-04-16  3038  	hp->erxregs    = (hpreg_base + 0x4000UL);
^1da177e4c3f41 drivers/net/sunhme.c              Linus Torvalds   2005-04-16  3039  	hp->bigmacregs = (hpreg_base + 0x6000UL);
^1da177e4c3f41 drivers/net/sunhme.c              Linus Torvalds   2005-04-16  3040  	hp->tcvregs    = (hpreg_base + 0x7000UL);
^1da177e4c3f41 drivers/net/sunhme.c              Linus Torvalds   2005-04-16  3041  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests

