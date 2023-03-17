Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A38AE6BEAE0
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 15:16:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbjCQOQm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 10:16:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbjCQOQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 10:16:38 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0384261525;
        Fri, 17 Mar 2023 07:16:36 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id h5so2795178ile.13;
        Fri, 17 Mar 2023 07:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679062596;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7ckr4N9Sg6yKbc6efTCWtcAHsD7HxkVk0i05mjYu31s=;
        b=WNJy2ZnBkM8Tkwd+KJi7m787VnBx0swkocx+gbV662DuU/V4GLdrU9OZnb8ykE9cia
         P6oSqNRA7TabRBdENL0v0ncOdiUwVj9nL2v/paZBi227Z1J8qmzcmqfGSeUzSRwnU+5b
         XNchW5m717XFXc/SzHNiWbfjC00B1BpdZ4N4CODgvMjLbCYzcxCbBhRfW4xbj+5Bmcf1
         Ugv3LC8U//tpgnxEMRM0RoGCpQ4sEb2gsLcqLroCL8r1C5SOAY+pdjcxeyQn8Gc4kjkT
         hSEGYJxWlqYJu+F7VSZ7BIFpic0+1HDJKTkf3xBF7aw3iZRE9Abfuh8sb8IxB6vrdw9b
         sOYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679062596;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7ckr4N9Sg6yKbc6efTCWtcAHsD7HxkVk0i05mjYu31s=;
        b=sM0MIcmYSRCgkpre+yJlvjdwGGgxOY6gc210BTVl3YoGnOOobEafS2ZfXQSG6ij6/O
         j/xENgBi1Mm87q7eCzir4ecxCSS2faiJfrR46dB0zYWzqgwsE5y1g1h79NcdZ8ZRyz7+
         v2/uJMbbNVm4rfXOldgEZxK9zJU3cG5N+278HeibDjiiqm/u9uDYYSkPw0LZu/HkYscW
         4MwzyrfiY2vN5hXpe03IFYBGxuPpVLaJtCsMpFc3jiPL8JMq6qY+5K2k2IUV2IraVNeC
         nesyQz1rkNJTLlnSe0uikMtuKQpWMKo/NdK4Han3hwX1sLiB5/R6xY/roHkZnknR2mPU
         ukMw==
X-Gm-Message-State: AO0yUKUByRrSwpmfeou/d/GbXhPPT7yxiLUdbSDBCBBU8ApF/0mSBh7J
        Z8F1sQXeSf8Mr4eDzS2Bx6o=
X-Google-Smtp-Source: AK7set9SLmJwK/CZFRPZV2uNhmXoOUlXDKKRGv8Vge8H2EEO6FUoFm4c2gVXXbQYUQGPsz8OALi7UA==
X-Received: by 2002:a92:6a0c:0:b0:317:9c8b:c0a7 with SMTP id f12-20020a926a0c000000b003179c8bc0a7mr9056018ilc.11.1679062596257;
        Fri, 17 Mar 2023 07:16:36 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s29-20020a02b15d000000b004061ba59f18sm706712jah.120.2023.03.17.07.16.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 07:16:35 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 17 Mar 2023 07:16:33 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Tomer Maimon <tmaimon77@gmail.com>
Cc:     ulf.hansson@linaro.org, avifishman70@gmail.com,
        tali.perry1@gmail.com, joel@jms.id.au, venture@google.com,
        yuenn@google.com, benjaminfair@google.com, adrian.hunter@intel.com,
        skhan@linuxfoundation.org, davidgow@google.com,
        pbrobinson@gmail.com, gsomlo@gmail.com, briannorris@chromium.org,
        arnd@arndb.de, krakoczy@antmicro.com, andy.shevchenko@gmail.com,
        openbmc@lists.ozlabs.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] mmc: sdhci-npcm: Add NPCM SDHCI driver
Message-ID: <f28c7c34-077c-4c7e-afd8-c4180718d403@roeck-us.net>
References: <20221205085351.27566-1-tmaimon77@gmail.com>
 <20221205085351.27566-3-tmaimon77@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221205085351.27566-3-tmaimon77@gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 05, 2022 at 10:53:51AM +0200, Tomer Maimon wrote:
> Add Nuvoton NPCM BMC sdhci-pltfm controller driver.
> 
> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>

I still don't see this driver in the upstream kernel, or in linux-next.

Couple of comments:

- devm ordering does not really matter here. The devm resource
  is the clock, it does not depend on local data, and it will be
  released last, so that is ok.
- sdhci_pltfm_unregister() calls clk_disable_unprepare(),
  so there is no enabled clock floating around on driver removal.
  Unfortunately, that also means that the more convenient
  devm_clk_get_optional_enabled() can not be used.

Real problem inline below.

Guenter

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

The two functions above should not return but goto the call
to sdhci_pltfm_free() to avoid a memory leak on error.

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
> -- 
> 2.33.0
> 
