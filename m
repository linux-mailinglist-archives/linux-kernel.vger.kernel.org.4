Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADA79605C88
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 12:37:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbiJTKhW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 06:37:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbiJTKhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 06:37:19 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 594041BB964
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 03:37:18 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id q10-20020a17090a304a00b0020b1d5f6975so2677448pjl.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 03:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=z+za2fWWq/FJfBBcjb1tNCF1EGnC+USIRnJnBiSfyRA=;
        b=RJQT7TgwV++5Ot4Nh7q0NzY/MddbMV6I3iMYmbOTLicsiPprYBf9SXEASdusOc3JD9
         Bq8ZWEdg/ieIwC1dJIxWxMSbqbRlC16StndYYYmVcmAzAaqzLkvrXHT+nSsV1wZEdQ5g
         T9rUoBuHv5pYYIkH8lJHrW96XDeumj3gP+5tbj8KW7l0TPEr3ZAWy50QTbxZ+woONXdv
         BBu5ZOBXWB68uj0jDc82zuSpzmmynLszsY71I/FKZzrVkFeg2r2kFSa3QSKpNWCtUGyP
         e4Ngk7mY9DLO2GucHKo78zGi0r7Fy0beDm3nr+3mERMZQ6C95iZnul83ZYlhZJArV7LF
         3aEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z+za2fWWq/FJfBBcjb1tNCF1EGnC+USIRnJnBiSfyRA=;
        b=V4OqK3ZID/Z1ZyKQTKEeblqjVxbRUR8ioqoYKYdz9RS9s+IHpGLslkdNtfJbMqrTSz
         iWcd97JMWfVErqSgbDjzeoYDiMSGqg9n/9KI3fZKDHaLoqTqiyNZ9GQZiYwY1MyeC/u3
         vOHFDqQ5Dgh6QgUvIVyVPetxb5KlsdvXT2ZBmy/jjk19EzuWwpu4ASAiNmgjKE+kbCjA
         OgwXSeoLgNpG179TKYsiw5+6rkpIW6kZHDsMuFrEXkGsCuP9EeO6zQAE/DH8aU1KFvVf
         4Z4/E23FAGISAeQheVx0l+NLDkO2DlYoJq3NDDGe2H703wC/4/2V+cvDxBnpxuk5E3Ca
         t/vw==
X-Gm-Message-State: ACrzQf1CMusR0fJi/TDNL3FF6CtZwaO8lpM2tzBgb6abMCzYDn/M6gEv
        F4zQGZFlknuQJp9Mz6PECgBbHnUACX6VqaS0QR/hDwZcptA=
X-Google-Smtp-Source: AMsMyM4vJmc5X/03l+yCR183PiNOSqzELcttxJqqAeZ/GGB1DpS6wVWm/BZ366OVPUfHGbfq64PodwhC/laJR//QTP4=
X-Received: by 2002:a17:903:246:b0:179:96b5:1ad2 with SMTP id
 j6-20020a170903024600b0017996b51ad2mr13160960plh.37.1666262237829; Thu, 20
 Oct 2022 03:37:17 -0700 (PDT)
MIME-Version: 1.0
References: <20221019144119.3848027-1-arnd@kernel.org> <20221019150410.3851944-1-arnd@kernel.org>
 <20221019150410.3851944-3-arnd@kernel.org>
In-Reply-To: <20221019150410.3851944-3-arnd@kernel.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 20 Oct 2022 12:36:40 +0200
Message-ID: <CAPDyKFr67mHzKG9GmSzLrgidjvXw_aHTx8aRfher4-wZzBr1hA@mail.gmail.com>
Subject: Re: [PATCH 03/17] mmc: remove cns3xxx driver
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Krzysztof Halasa <khalasa@piap.pl>, linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Oct 2022 at 17:06, Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> The cns3xxx platform is gone, so this driver is now orphaned.
>
> Cc: Krzysztof Halasa <khalasa@piap.pl>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  drivers/mmc/host/Kconfig         |  11 ---
>  drivers/mmc/host/Makefile        |   1 -
>  drivers/mmc/host/sdhci-cns3xxx.c | 113 -------------------------------
>  3 files changed, 125 deletions(-)
>  delete mode 100644 drivers/mmc/host/sdhci-cns3xxx.c
>
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index f324daadaf70..1c5b1c48a230 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -253,17 +253,6 @@ config MMC_SDHCI_CADENCE
>
>           If unsure, say N.
>
> -config MMC_SDHCI_CNS3XXX
> -       tristate "SDHCI support on the Cavium Networks CNS3xxx SoC"
> -       depends on ARCH_CNS3XXX || COMPILE_TEST
> -       depends on MMC_SDHCI_PLTFM
> -       help
> -         This selects the SDHCI support for CNS3xxx System-on-Chip devices.
> -
> -         If you have a controller with this interface, say Y or M here.
> -
> -         If unsure, say N.
> -
>  config MMC_SDHCI_ESDHC_MCF
>         tristate "SDHCI support for the Freescale eSDHC ColdFire controller"
>         depends on M5441x
> diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
> index 4e4ceb32c4b4..7bea77c28b7e 100644
> --- a/drivers/mmc/host/Makefile
> +++ b/drivers/mmc/host/Makefile
> @@ -77,7 +77,6 @@ obj-$(CONFIG_MMC_REALTEK_USB) += rtsx_usb_sdmmc.o
>
>  obj-$(CONFIG_MMC_SDHCI_PLTFM)          += sdhci-pltfm.o
>  obj-$(CONFIG_MMC_SDHCI_CADENCE)                += sdhci-cadence.o
> -obj-$(CONFIG_MMC_SDHCI_CNS3XXX)                += sdhci-cns3xxx.o
>  obj-$(CONFIG_MMC_SDHCI_ESDHC_MCF)       += sdhci-esdhc-mcf.o
>  obj-$(CONFIG_MMC_SDHCI_ESDHC_IMX)      += sdhci-esdhc-imx.o
>  obj-$(CONFIG_MMC_SDHCI_DOVE)           += sdhci-dove.o
> diff --git a/drivers/mmc/host/sdhci-cns3xxx.c b/drivers/mmc/host/sdhci-cns3xxx.c
> deleted file mode 100644
> index 2a29c7a4f308..000000000000
> --- a/drivers/mmc/host/sdhci-cns3xxx.c
> +++ /dev/null
> @@ -1,113 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-only
> -/*
> - * SDHCI support for CNS3xxx SoC
> - *
> - * Copyright 2008 Cavium Networks
> - * Copyright 2010 MontaVista Software, LLC.
> - *
> - * Authors: Scott Shu
> - *         Anton Vorontsov <avorontsov@mvista.com>
> - */
> -
> -#include <linux/delay.h>
> -#include <linux/device.h>
> -#include <linux/mmc/host.h>
> -#include <linux/module.h>
> -#include "sdhci-pltfm.h"
> -
> -static unsigned int sdhci_cns3xxx_get_max_clk(struct sdhci_host *host)
> -{
> -       return 150000000;
> -}
> -
> -static void sdhci_cns3xxx_set_clock(struct sdhci_host *host, unsigned int clock)
> -{
> -       struct device *dev = mmc_dev(host->mmc);
> -       int div = 1;
> -       u16 clk;
> -       unsigned long timeout;
> -
> -       host->mmc->actual_clock = 0;
> -
> -       sdhci_writew(host, 0, SDHCI_CLOCK_CONTROL);
> -
> -       if (clock == 0)
> -               return;
> -
> -       while (host->max_clk / div > clock) {
> -               /*
> -                * On CNS3xxx divider grows linearly up to 4, and then
> -                * exponentially up to 256.
> -                */
> -               if (div < 4)
> -                       div += 1;
> -               else if (div < 256)
> -                       div *= 2;
> -               else
> -                       break;
> -       }
> -
> -       dev_dbg(dev, "desired SD clock: %d, actual: %d\n",
> -               clock, host->max_clk / div);
> -
> -       /* Divide by 3 is special. */
> -       if (div != 3)
> -               div >>= 1;
> -
> -       clk = div << SDHCI_DIVIDER_SHIFT;
> -       clk |= SDHCI_CLOCK_INT_EN;
> -       sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
> -
> -       timeout = 20;
> -       while (!((clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL))
> -                       & SDHCI_CLOCK_INT_STABLE)) {
> -               if (timeout == 0) {
> -                       dev_warn(dev, "clock is unstable");
> -                       break;
> -               }
> -               timeout--;
> -               mdelay(1);
> -       }
> -
> -       clk |= SDHCI_CLOCK_CARD_EN;
> -       sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
> -}
> -
> -static const struct sdhci_ops sdhci_cns3xxx_ops = {
> -       .get_max_clock  = sdhci_cns3xxx_get_max_clk,
> -       .set_clock      = sdhci_cns3xxx_set_clock,
> -       .set_bus_width  = sdhci_set_bus_width,
> -       .reset          = sdhci_reset,
> -       .set_uhs_signaling = sdhci_set_uhs_signaling,
> -};
> -
> -static const struct sdhci_pltfm_data sdhci_cns3xxx_pdata = {
> -       .ops = &sdhci_cns3xxx_ops,
> -       .quirks = SDHCI_QUIRK_BROKEN_DMA |
> -                 SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK |
> -                 SDHCI_QUIRK_INVERTED_WRITE_PROTECT |
> -                 SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN |
> -                 SDHCI_QUIRK_BROKEN_TIMEOUT_VAL,
> -};
> -
> -static int sdhci_cns3xxx_probe(struct platform_device *pdev)
> -{
> -       return sdhci_pltfm_register(pdev, &sdhci_cns3xxx_pdata, 0);
> -}
> -
> -static struct platform_driver sdhci_cns3xxx_driver = {
> -       .driver         = {
> -               .name   = "sdhci-cns3xxx",
> -               .probe_type = PROBE_PREFER_ASYNCHRONOUS,
> -               .pm     = &sdhci_pltfm_pmops,
> -       },
> -       .probe          = sdhci_cns3xxx_probe,
> -       .remove         = sdhci_pltfm_unregister,
> -};
> -
> -module_platform_driver(sdhci_cns3xxx_driver);
> -
> -MODULE_DESCRIPTION("SDHCI driver for CNS3xxx");
> -MODULE_AUTHOR("Scott Shu, "
> -             "Anton Vorontsov <avorontsov@mvista.com>");
> -MODULE_LICENSE("GPL v2");
> --
> 2.29.2
>
