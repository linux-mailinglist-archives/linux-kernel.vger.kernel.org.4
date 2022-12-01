Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18B0163F547
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 17:28:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230480AbiLAQ2J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 11:28:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbiLAQ2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 11:28:06 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 943E224F37;
        Thu,  1 Dec 2022 08:28:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669912085; x=1701448085;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Uwa5GE+MsAvzWb87j0kaLbVFsNzYxhRQYhZoxGjszZo=;
  b=TM+zHOVXbln7b49hgvfWzBq9Vi9CSKkSottlU+XOWSMRYdyg5sEXhBUf
   XCZvYsejXJBeL/jblrN9lQXQ5gf9vzq2Af678sM1q8Q8fMeVVr0EgSsx9
   IFGa1YtbEQAogO4qcvf9VVJXgJIFuQVXgtEaq+LcMzOh1rS0I00AMtnnE
   jHzvislHhOm3CTq4uyEHyU6ZgXrjKbGPM4SeCL5BM2kUyIKg2z19NJxsb
   Xc0gcivGMTQVXnm9jrxGOubiBqgadXC3jxv9FqjGVU0TBsMK84uU3OyGv
   XHSRJ3qACBenQRSMZpA2V5EPq13JlAO+NhiDJmr8XFyX5ZOJfaDTzRDcT
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="296085397"
X-IronPort-AV: E=Sophos;i="5.96,209,1665471600"; 
   d="scan'208";a="296085397"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2022 08:28:04 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="889795226"
X-IronPort-AV: E=Sophos;i="5.96,209,1665471600"; 
   d="scan'208";a="889795226"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.34.240])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2022 08:27:59 -0800
Message-ID: <0b5df859-a662-a677-aaa0-cbf68c029ab9@intel.com>
Date:   Thu, 1 Dec 2022 18:27:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.5.0
Subject: Re: [PATCH v1 2/2] mmc: sdhci-npcm: Add NPCM SDHCI driver
Content-Language: en-US
To:     Tomer Maimon <tmaimon77@gmail.com>, ulf.hansson@linaro.org,
        avifishman70@gmail.com, tali.perry1@gmail.com, joel@jms.id.au,
        venture@google.com, yuenn@google.com, benjaminfair@google.com,
        skhan@linuxfoundation.org, davidgow@google.com,
        pbrobinson@gmail.com, gsomlo@gmail.com, briannorris@chromium.org,
        arnd@arndb.de, krakoczy@antmicro.com, andy.shevchenko@gmail.com
Cc:     openbmc@lists.ozlabs.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221130150857.67113-1-tmaimon77@gmail.com>
 <20221130150857.67113-3-tmaimon77@gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20221130150857.67113-3-tmaimon77@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/11/22 17:08, Tomer Maimon wrote:
> Add Nuvoton NPCM BMC sdhci-pltfm controller driver.
> 
> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
> ---
>  drivers/mmc/host/Kconfig      |  8 ++++
>  drivers/mmc/host/Makefile     |  1 +
>  drivers/mmc/host/sdhci-npcm.c | 81 +++++++++++++++++++++++++++++++++++
>  3 files changed, 90 insertions(+)
>  create mode 100644 drivers/mmc/host/sdhci-npcm.c
> 
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index fb1062a6394c..4b2d9ce4308c 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -709,6 +709,14 @@ config MMC_TMIO
>  	  This provides support for the SD/MMC cell found in TC6393XB,
>  	  T7L66XB and also HTC ASIC3
>  
> +config MMC_SDHCI_NPCM
> +	tristate "Secure Digital Host Controller Interface support for NPCM"
> +	depends on ARCH_NPCM || COMPILE_TEST
> +	depends on MMC_SDHCI_PLTFM
> +	help
> +	  This provides support for the SD/eMMC controller found in
> +	  NPCM BMC family SoCs.
> +
>  config MMC_SDHI
>  	tristate "Renesas SDHI SD/SDIO controller support"
>  	depends on SUPERH || ARCH_RENESAS || COMPILE_TEST
> diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
> index 4e4ceb32c4b4..801086613d7f 100644
> --- a/drivers/mmc/host/Makefile
> +++ b/drivers/mmc/host/Makefile
> @@ -37,6 +37,7 @@ obj-$(CONFIG_MMC_SPI)		+= of_mmc_spi.o
>  obj-$(CONFIG_MMC_S3C)   	+= s3cmci.o
>  obj-$(CONFIG_MMC_SDRICOH_CS)	+= sdricoh_cs.o
>  obj-$(CONFIG_MMC_TMIO)		+= tmio_mmc.o
> +obj-$(CONFIG_MMC_SDHCI_NPCM)	+= sdhci-npcm.o
>  obj-$(CONFIG_MMC_TMIO_CORE)	+= tmio_mmc_core.o
>  obj-$(CONFIG_MMC_SDHI)		+= renesas_sdhi_core.o
>  obj-$(CONFIG_MMC_SDHI_SYS_DMAC)		+= renesas_sdhi_sys_dmac.o
> diff --git a/drivers/mmc/host/sdhci-npcm.c b/drivers/mmc/host/sdhci-npcm.c
> new file mode 100644
> index 000000000000..298c5f3e7c2b
> --- /dev/null
> +++ b/drivers/mmc/host/sdhci-npcm.c
> @@ -0,0 +1,81 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * NPCM SDHC MMC host controller driver.
> + *
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/mmc/host.h>
> +#include <linux/mmc/mmc.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
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
> +	pltfm_host->clk = devm_clk_get(&pdev->dev, NULL);

For an optional clock, something like:

	pltfm_host->clk = devm_clk_get_optional(&pdev->dev, NULL);
	if (IS_ERR(pltfm_host->clk))
		return PTR_ERR(pltfm_host->clk);

will handle -EPROBE_DEFER

> +
> +	if (!IS_ERR(pltfm_host->clk))
> +		clk_prepare_enable(pltfm_host->clk);
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
> +
> +module_platform_driver(npcm_sdhci_driver);
> +
> +MODULE_DESCRIPTION("NPCM Secure Digital Host Controller Interface driver");
> +MODULE_AUTHOR("Tomer Maimon <tomer.maimon@nuvoton.com>");
> +MODULE_LICENSE("GPL v2");

WARNING: Prefer "GPL" over "GPL v2" - see commit bf7fbeeae6db ("module: Cure the MODULE_LICENSE "GPL" vs. "GPL v2" bogosity")
#133: FILE: drivers/mmc/host/sdhci-npcm.c:81:
+MODULE_LICENSE("GPL v2");


