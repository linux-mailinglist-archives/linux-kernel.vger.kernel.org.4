Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 232CF6D8288
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 17:49:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239096AbjDEPta (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 11:49:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239045AbjDEPtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 11:49:25 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B256F4C20
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 08:49:01 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id r29so36643704wra.13
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 08:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1680709729;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bEilYgmHZ7l/bQLzCewoCvoPGpsrJtc/Cg02p3y6vwY=;
        b=Ii4Yh1EZdQ+aZCFlOdXALbTzJ1og9QLtlkYzPUC/jenIpbvCTAT0yz5svZia5Dsl1w
         mGkKFXAUN0KzkkryuKYnwJ6p3L6Z+qsljm01JFxeE7zmIjwX5cLHYn8zBvpgLlFuMuav
         8jxkSKuZH9BAdTMcA2X8UUu0G6oYMk6Lr12Ae6qn/IPyDpTnSfY2TxlOw/mYokArg6+w
         dnZdHco7kHmKFs4gJLTE/AG1qnsUKkgXLocGdcrsfiP1S/xSx/bLc4Ymz6gVsdzsjpg+
         eVaWKpeTl0R2tu3cAhkiEmGWlV62XMGm2jA++kxMNn/QtnvyzDPFk0IzPFn8j0T74gki
         kTFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680709729;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bEilYgmHZ7l/bQLzCewoCvoPGpsrJtc/Cg02p3y6vwY=;
        b=uaWiYV3J230z5ZejoAVvh5p5F2gsWMi7qAL/Wk2ldHdjYuXZPzDzBev97OvKEYPGuU
         wfZry9acOG3Xfz6mL5MrVcbpuLbI+rMqnAd1dFcjRh2qiHbI/+0MTfVNwOwbwVHWBbx/
         4AUGbem0gY+77WOgndC8F8QEHNz73p3wpcM0inbay7TjCkRSPL8s44g5yM7ILzIgOGqj
         LaX5dT3tZqsQviBV+ze3I7U+jLTDkdu5/RrtHqWmrpJnubB4YATYUt6+/h/l6TgZKSyp
         +r4fHPij5CXHrQ6Lt9H57DIouhWrG//zc5IGqm7m1cG4KVoKQr0ctHG0vS1ttRudECQO
         75ug==
X-Gm-Message-State: AAQBX9cakYZXYcmMbzykWJIdzRwC/xCMMHaUwJktndkxryy6Anx+7n9S
        0S2yB39QS21cy0qySy4i82DBPQ==
X-Google-Smtp-Source: AKy350a/4RpDuNaKeLXizakCjVT0nJJ/3/P77NUAVFXOsWcY6UUfArIEbAgLCUIHrv9hqeDQ0bOQAw==
X-Received: by 2002:adf:d0ce:0:b0:2ce:ab0a:81fe with SMTP id z14-20020adfd0ce000000b002ceab0a81femr3890449wrh.62.1680709728645;
        Wed, 05 Apr 2023 08:48:48 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id y16-20020adfe6d0000000b002df7c38dc3esm15375973wrm.87.2023.04.05.08.48.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 08:48:48 -0700 (PDT)
Date:   Wed, 5 Apr 2023 17:48:47 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Sunil V L <sunilvl@ventanamicro.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
        linux-crypto@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        llvm@lists.linux.dev, Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Len Brown <lenb@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Weili Qian <qianweili@huawei.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Marc Zyngier <maz@kernel.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH V4 15/23] irqchip/riscv-intc: Add ACPI support
Message-ID: <qxftlofleo2bpyqa5lyshiluc5cd37u4hljn4bh7noxv7g5pno@ldvh6gkyrlzu>
References: <20230404182037.863533-1-sunilvl@ventanamicro.com>
 <20230404182037.863533-16-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230404182037.863533-16-sunilvl@ventanamicro.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 04, 2023 at 11:50:29PM +0530, Sunil V L wrote:
> Add support for initializing the RISC-V INTC driver on ACPI
> platforms.
> 
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  drivers/irqchip/irq-riscv-intc.c | 74 ++++++++++++++++++++++++++------
>  1 file changed, 61 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-riscv-intc.c b/drivers/irqchip/irq-riscv-intc.c
> index f229e3e66387..6b476fa356c0 100644
> --- a/drivers/irqchip/irq-riscv-intc.c
> +++ b/drivers/irqchip/irq-riscv-intc.c
> @@ -6,6 +6,7 @@
>   */
>  
>  #define pr_fmt(fmt) "riscv-intc: " fmt
> +#include <linux/acpi.h>
>  #include <linux/atomic.h>
>  #include <linux/bits.h>
>  #include <linux/cpu.h>
> @@ -112,6 +113,30 @@ static struct fwnode_handle *riscv_intc_hwnode(void)
>  	return intc_domain->fwnode;
>  }
>  
> +static int __init riscv_intc_init_common(struct fwnode_handle *fn)
> +{
> +	int rc;
> +
> +	intc_domain = irq_domain_create_linear(fn, BITS_PER_LONG,
> +					       &riscv_intc_domain_ops, NULL);
> +	if (!intc_domain) {
> +		pr_err("unable to add IRQ domain\n");
> +		return -ENXIO;
> +	}
> +
> +	rc = set_handle_irq(&riscv_intc_irq);
> +	if (rc) {
> +		pr_err("failed to set irq handler\n");
> +		return rc;
> +	}
> +
> +	riscv_set_intc_hwnode_fn(riscv_intc_hwnode);
> +
> +	pr_info("%d local interrupts mapped\n", BITS_PER_LONG);
> +
> +	return 0;
> +}
> +
>  static int __init riscv_intc_init(struct device_node *node,
>  				  struct device_node *parent)
>  {
> @@ -133,24 +158,47 @@ static int __init riscv_intc_init(struct device_node *node,
>  	if (riscv_hartid_to_cpuid(hartid) != smp_processor_id())
>  		return 0;
>  
> -	intc_domain = irq_domain_add_linear(node, BITS_PER_LONG,
> -					    &riscv_intc_domain_ops, NULL);
> -	if (!intc_domain) {
> -		pr_err("unable to add IRQ domain\n");
> -		return -ENXIO;
> -	}
> -
> -	rc = set_handle_irq(&riscv_intc_irq);
> +	rc = riscv_intc_init_common(of_node_to_fwnode(node));
>  	if (rc) {
> -		pr_err("failed to set irq handler\n");
> +		pr_err("failed to initialize INTC\n");

The ACPI version doesn't output this error when riscv_intc_init_common()
fails. It should probably be consistent. Either removing it here, if the
errors output within riscv_intc_init_common() are sufficient, or adding
it to the ACPI version.

>  		return rc;
>  	}
>  
> -	riscv_set_intc_hwnode_fn(riscv_intc_hwnode);
> -
> -	pr_info("%d local interrupts mapped\n", BITS_PER_LONG);
> -
>  	return 0;
>  }
>  
>  IRQCHIP_DECLARE(riscv, "riscv,cpu-intc", riscv_intc_init);
> +
> +#ifdef CONFIG_ACPI
> +
> +static int __init riscv_intc_acpi_init(union acpi_subtable_headers *header,
> +				       const unsigned long end)
> +{
> +	int rc;
> +	struct fwnode_handle *fn;
> +	struct acpi_madt_rintc *rintc;
> +
> +	rintc = (struct acpi_madt_rintc *)header;
> +
> +	/*
> +	 * The ACPI MADT will have one INTC for each CPU (or HART)
> +	 * so riscv_intc_acpi_init() function will be called once
> +	 * for each INTC. We only do INTC initialization
> +	 * for the INTC belonging to the boot CPU (or boot HART).
> +	 */
> +	if (riscv_hartid_to_cpuid(rintc->hart_id) != smp_processor_id())
> +		return 0;
> +
> +	fn = irq_domain_alloc_named_fwnode("RISCV-INTC");
> +	if (!fn) {
> +		pr_err("unable to allocate INTC FW node\n");
> +		return -ENOMEM;
> +	}
> +
> +	rc = riscv_intc_init_common(fn);
> +	return rc;

nit: If we don't add the error message here, then rc can be removed and we
can just do

  return riscv_intc_init_common(fn);

And, if we remove the error above, then we reduce the return there too.

> +}
> +
> +IRQCHIP_ACPI_DECLARE(riscv_intc, ACPI_MADT_TYPE_RINTC, NULL,
> +		     ACPI_MADT_RINTC_VERSION_V1, riscv_intc_acpi_init);
> +#endif
> -- 
> 2.34.1
> 

Thanks,
drew
