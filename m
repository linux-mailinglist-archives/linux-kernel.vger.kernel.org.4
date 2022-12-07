Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6097D645B43
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 14:47:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbiLGNrl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 08:47:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbiLGNrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 08:47:31 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 427A55B582;
        Wed,  7 Dec 2022 05:47:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670420849; x=1701956849;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=aHVcx5z4X6dmBc1V2l5HJGVIoO8fhDJR9OvEAm5YvL4=;
  b=HvXGC2j8rr9rNXPKWjAqv1UeVGlGHOH1pxwn+c8ZlaQ5vDRgX8EtIM/D
   pPK6YBThwKMKBwAOS0kkT/y4xlG4H6UW0rhwJfy73PP3zn8/NoEvbluG4
   WKztj0qwDyokJr7/oP17q1beXjY7pQs51yTjYXkiH6TuT1F1QWe+UwNKb
   jP+cT4dyIaUUP5FN/F7bmVNN/c/mORH8NnZhWzMxSoJxjjknqd7KMiCWm
   WfMG9q95ZaSV5QxdnoQaeVT/45Oleuma6wrHAJ/CTbNAg6AfGs7E8GGqS
   aGS0oGND1zwCQG3zlWovio42/Vq41dzWK5mmZLr35G5c35LLOlrfMbZdL
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10553"; a="304523666"
X-IronPort-AV: E=Sophos;i="5.96,225,1665471600"; 
   d="scan'208";a="304523666"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2022 05:47:20 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10553"; a="891805041"
X-IronPort-AV: E=Sophos;i="5.96,225,1665471600"; 
   d="scan'208";a="891805041"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.38.130])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2022 05:47:15 -0800
Message-ID: <137f93ed-4e3c-90b5-52fa-e3fc22a0ab6b@intel.com>
Date:   Wed, 7 Dec 2022 15:47:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.5.1
Subject: Re: [PATCH v2 2/2] mmc: sdhci-npcm: Add NPCM SDHCI driver
Content-Language: en-US
To:     Tomer Maimon <tmaimon77@gmail.com>, ulf.hansson@linaro.org,
        avifishman70@gmail.com, tali.perry1@gmail.com, joel@jms.id.au,
        venture@google.com, yuenn@google.com, benjaminfair@google.com,
        skhan@linuxfoundation.org, davidgow@google.com,
        pbrobinson@gmail.com, gsomlo@gmail.com, briannorris@chromium.org,
        arnd@arndb.de, krakoczy@antmicro.com, andy.shevchenko@gmail.com
Cc:     openbmc@lists.ozlabs.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221205085351.27566-1-tmaimon77@gmail.com>
 <20221205085351.27566-3-tmaimon77@gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20221205085351.27566-3-tmaimon77@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/12/22 10:53, Tomer Maimon wrote:
> Add Nuvoton NPCM BMC sdhci-pltfm controller driver.
> 
> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/Kconfig      |  8 ++++
>  drivers/mmc/host/Makefile     |  1 +
>  drivers/mmc/host/sdhci-npcm.c | 84 +++++++++++++++++++++++++++++++++++
>  3 files changed, 93 insertions(+)
>  create mode 100644 drivers/mmc/host/sdhci-npcm.c
> 
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index fb1062a6394c..82ab6fc25dca 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -415,6 +415,14 @@ config MMC_SDHCI_MILBEAUT
>  
>  	  If unsure, say N.
>  
> +config MMC_SDHCI_NPCM
> +	tristate "Secure Digital Host Controller Interface support for NPCM"
> +	depends on ARCH_NPCM || COMPILE_TEST
> +	depends on MMC_SDHCI_PLTFM
> +	help
> +	  This provides support for the SD/eMMC controller found in
> +	  NPCM BMC family SoCs.
> +
>  config MMC_SDHCI_IPROC
>  	tristate "SDHCI support for the BCM2835 & iProc SD/MMC Controller"
>  	depends on ARCH_BCM2835 || ARCH_BCM_IPROC || ARCH_BRCMSTB || COMPILE_TEST
> diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
> index 4e4ceb32c4b4..a101f87a5f19 100644
> --- a/drivers/mmc/host/Makefile
> +++ b/drivers/mmc/host/Makefile
> @@ -97,6 +97,7 @@ obj-$(CONFIG_MMC_SDHCI_MICROCHIP_PIC32)	+= sdhci-pic32.o
>  obj-$(CONFIG_MMC_SDHCI_BRCMSTB)		+= sdhci-brcmstb.o
>  obj-$(CONFIG_MMC_SDHCI_OMAP)		+= sdhci-omap.o
>  obj-$(CONFIG_MMC_SDHCI_SPRD)		+= sdhci-sprd.o
> +obj-$(CONFIG_MMC_SDHCI_NPCM)		+= sdhci-npcm.o
>  obj-$(CONFIG_MMC_CQHCI)			+= cqhci.o
>  cqhci-y					+= cqhci-core.o
>  cqhci-$(CONFIG_MMC_CRYPTO)		+= cqhci-crypto.o
> diff --git a/drivers/mmc/host/sdhci-npcm.c b/drivers/mmc/host/sdhci-npcm.c
> new file mode 100644
> index 000000000000..beace15b6c00
> --- /dev/null
> +++ b/drivers/mmc/host/sdhci-npcm.c
> @@ -0,0 +1,84 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * NPCM SDHC MMC host controller driver.
> + *
> + * Copyright (c) 2020 Nuvoton Technology corporation.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/mmc/host.h>
> +#include <linux/mmc/mmc.h>
> +#include <linux/module.h>
> +
> +#include "sdhci-pltfm.h"
> +
> +static const struct sdhci_pltfm_data npcm_sdhci_pdata = {
> +	.quirks  = SDHCI_QUIRK_DELAY_AFTER_POWER,
> +	.quirks2 = SDHCI_QUIRK2_STOP_WITH_TC |
> +		   SDHCI_QUIRK2_NO_1_8_V,
> +};
> +
> +static int npcm_sdhci_probe(struct platform_device *pdev)
> +{
> +	struct sdhci_pltfm_host *pltfm_host;
> +	struct sdhci_host *host;
> +	u32 caps;
> +	int ret;
> +
> +	host = sdhci_pltfm_init(pdev, &npcm_sdhci_pdata, 0);
> +	if (IS_ERR(host))
> +		return PTR_ERR(host);
> +
> +	pltfm_host = sdhci_priv(host);
> +
> +	pltfm_host->clk = devm_clk_get_optional(&pdev->dev, NULL);
> +	if (IS_ERR(pltfm_host->clk))
> +		return PTR_ERR(pltfm_host->clk);
> +
> +	ret = clk_prepare_enable(pltfm_host->clk);
> +	if (ret)
> +		return ret;
> +
> +	caps = sdhci_readl(host, SDHCI_CAPABILITIES);
> +	if (caps & SDHCI_CAN_DO_8BIT)
> +		host->mmc->caps |= MMC_CAP_8_BIT_DATA;
> +
> +	ret = mmc_of_parse(host->mmc);
> +	if (ret)
> +		goto err_sdhci_add;
> +
> +	ret = sdhci_add_host(host);
> +	if (ret)
> +		goto err_sdhci_add;
> +
> +	return 0;
> +
> +err_sdhci_add:
> +	clk_disable_unprepare(pltfm_host->clk);
> +	sdhci_pltfm_free(pdev);
> +	return ret;
> +}
> +
> +static const struct of_device_id npcm_sdhci_of_match[] = {
> +	{ .compatible = "nuvoton,npcm750-sdhci" },
> +	{ .compatible = "nuvoton,npcm845-sdhci" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, npcm_sdhci_of_match);
> +
> +static struct platform_driver npcm_sdhci_driver = {
> +	.driver = {
> +		.name	= "npcm-sdhci",
> +		.of_match_table = npcm_sdhci_of_match,
> +		.pm	= &sdhci_pltfm_pmops,
> +	},
> +	.probe		= npcm_sdhci_probe,
> +	.remove		= sdhci_pltfm_unregister,
> +};
> +module_platform_driver(npcm_sdhci_driver);
> +
> +MODULE_DESCRIPTION("NPCM Secure Digital Host Controller Interface driver");
> +MODULE_AUTHOR("Tomer Maimon <tomer.maimon@nuvoton.com>");
> +MODULE_LICENSE("GPL");

