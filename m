Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F3CA6E4C03
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 16:55:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231216AbjDQOzW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 10:55:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230525AbjDQOzQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 10:55:16 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF4039EC3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 07:54:57 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-54fe82d8bf5so106522347b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 07:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681743297; x=1684335297;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6utNr78oQkmqREZVkBpGPV9CtufNDYJJ9bNoCZEVsds=;
        b=ky4B47OKmAyFx5L4ii50XpiGHHyTG7kihi72ceBvfzEFkb89sVIa/d4ZrBNF5tlzWW
         dTP7ad0r+MeynKKgX+2FdjoxoS/0vKXmCh+vj1x+aR7WHTuiKWIEXK72QjDU0n6wnYI6
         JKPebUBHjmISuZlhuz5nQVjKMSUZLBjyuO9KqdocnGaCP1rbrLRvHTszgOKeieOCVipo
         W7X1InP10rpSA7GvVWXliFcFPersnA6kIw1Hdd5DFig6CcwNiW4oYKObR8y3R6w5jyFj
         iraTKdq+/MZftfzN98DIPRR1tgnFTRoIkkZrqvayxlbUGiCsg5EChWREClFIB2EXtSan
         mDIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681743297; x=1684335297;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6utNr78oQkmqREZVkBpGPV9CtufNDYJJ9bNoCZEVsds=;
        b=RE46JLfktAu54SWAe5wwn8q4AsOZHFsoRLlX9LaVq9smorfGxzjVb8IodW9/OOJPwX
         P/rQNeacJkw4aNCtQ/XGkWAMpOXQBBSOKb/XP4Sn08HcmHInciEpyESxgHHGxQwev5rS
         MHMbbuV2IUyYjMLq1vdRqclFNxF5mfl0pyGKZTV7kdvnB+49Wlyb0LTt3IPhr54UPRhv
         FjkQ1M9xBhh6hqJ9C6vkLi+zlVJcD2rulimkk5tl+USFOryeT3VPwMyYQHCUgGvCLPkF
         i/KyluyCBHNRMC4t/6KLwp7TNxLTIiEEgpuMvWFt3gAGkhbJaO2umV1Tur0fHllb7e9l
         CXig==
X-Gm-Message-State: AAQBX9cabvB4njX1YuFJRfqZFUgNCtH6SxNeGgVP/NcfM1UsQ6GgRn0O
        e46zoX40Lg36FsU/VvOWlOZon9FucEAhLlNswwd6tw==
X-Google-Smtp-Source: AKy350ajnN2NDsl4n62JPIuA9QqO/CvKKfYqxAXssnSLo3aCYRArQxgpnoUOhmAlReRuUt+9IIi21cLJf4oFpRCRL3k=
X-Received: by 2002:a81:af1e:0:b0:52e:e095:d840 with SMTP id
 n30-20020a81af1e000000b0052ee095d840mr9538535ywh.0.1681743296863; Mon, 17 Apr
 2023 07:54:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230410184526.15990-1-blarson@amd.com> <20230410184526.15990-14-blarson@amd.com>
In-Reply-To: <20230410184526.15990-14-blarson@amd.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 17 Apr 2023 16:54:20 +0200
Message-ID: <CAPDyKFqDrKR1N0+CBf4mPLPqO8VxToj2eJF87afhauYUPduGNw@mail.gmail.com>
Subject: Re: [PATCH v13 13/15] mmc: sdhci-cadence: Add AMD Pensando Elba SoC support
To:     Brad Larson <blarson@amd.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-spi@vger.kernel.org,
        adrian.hunter@intel.com, alcooperx@gmail.com,
        andy.shevchenko@gmail.com, arnd@arndb.de,
        brendan.higgins@linux.dev, briannorris@chromium.org,
        brijeshkumar.singh@amd.com, catalin.marinas@arm.com,
        davidgow@google.com, gsomlo@gmail.com, gerg@linux-m68k.org,
        krzk@kernel.org, krzysztof.kozlowski+dt@linaro.org, lee@kernel.org,
        lee.jones@linaro.org, broonie@kernel.org,
        yamada.masahiro@socionext.com, p.zabel@pengutronix.de,
        piotrs@cadence.com, p.yadav@ti.com, rdunlap@infradead.org,
        robh+dt@kernel.org, samuel@sholland.org, fancer.lancer@gmail.com,
        skhan@linuxfoundation.org, suravee.suthikulpanit@amd.com,
        thomas.lendacky@amd.com, tonyhuang.sunplus@gmail.com,
        vaishnav.a@ti.com, will@kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Apr 2023 at 20:47, Brad Larson <blarson@amd.com> wrote:
>
> Add support for AMD Pensando Elba SoC which explicitly
> controls byte-lane enables on writes.
>
> Select MMC_SDHCI_IO_ACCESSORS for MMC_SDHCI_CADENCE which
> allows Elba SoC sdhci_elba_ops to overwrite the SDHCI
> IO memory accessors
>
> Signed-off-by: Brad Larson <blarson@amd.com>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>
> v13 changes:
> - Use GENMASK(7, 3) in elba_priv_writel() to set all byte enables
> - Add a variable 'shift' with GENMASK(1, 0) in elba_write_w() and
>   elba_write_b() to set the byte enable variable.
>
> v11 changes:
> - Remove elba-drv_init() call to platform_get_resource() since that
>   check is done inside devm_platform_ioremap_resource()
> - Move spin_lock_init() before error check
> - Remove extra parentheses
>
> v10 changes:
> - Add Elba specific support into this 3rd patch.  This builds on the private
>   writel() enabled in patch 1 followed by platform specific init() in patch 2.
> - Specify when first used the reason for the spinlock use to order byte-enable
>   prior to write data.
>
> ---
>  drivers/mmc/host/Kconfig         |  1 +
>  drivers/mmc/host/sdhci-cadence.c | 98 ++++++++++++++++++++++++++++++++
>  2 files changed, 99 insertions(+)
>
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 4745fe217ade..9f793892123c 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -255,6 +255,7 @@ config MMC_SDHCI_CADENCE
>         tristate "SDHCI support for the Cadence SD/SDIO/eMMC controller"
>         depends on MMC_SDHCI_PLTFM
>         depends on OF
> +       select MMC_SDHCI_IO_ACCESSORS
>         help
>           This selects the Cadence SD/SDIO/eMMC driver.
>
> diff --git a/drivers/mmc/host/sdhci-cadence.c b/drivers/mmc/host/sdhci-cadence.c
> index c528a25f48b8..5d1e9cef74f5 100644
> --- a/drivers/mmc/host/sdhci-cadence.c
> +++ b/drivers/mmc/host/sdhci-cadence.c
> @@ -66,6 +66,8 @@ struct sdhci_cdns_phy_param {
>
>  struct sdhci_cdns_priv {
>         void __iomem *hrs_addr;
> +       void __iomem *ctl_addr; /* write control */
> +       spinlock_t wrlock;      /* write lock */
>         bool enhanced_strobe;
>         void (*priv_writel)(struct sdhci_cdns_priv *priv, u32 val, void __iomem *reg);
>         unsigned int nr_phy_params;
> @@ -321,6 +323,91 @@ static void sdhci_cdns_set_uhs_signaling(struct sdhci_host *host,
>                 sdhci_set_uhs_signaling(host, timing);
>  }
>
> +/* Elba control register bits [6:3] are byte-lane enables */
> +#define ELBA_BYTE_ENABLE_MASK(x)       ((x) << 3)
> +
> +/*
> + * The Pensando Elba SoC explicitly controls byte-lane enabling on writes
> + * which includes writes to the HRS registers.  The write lock (wrlock)
> + * is used to ensure byte-lane enable, using write control (ctl_addr),
> + * occurs before the data write.
> + */
> +static void elba_priv_writel(struct sdhci_cdns_priv *priv, u32 val,
> +                            void __iomem *reg)
> +{
> +       unsigned long flags;
> +
> +       spin_lock_irqsave(&priv->wrlock, flags);
> +       writel(GENMASK(7, 3), priv->ctl_addr);
> +       writel(val, reg);
> +       spin_unlock_irqrestore(&priv->wrlock, flags);
> +}
> +
> +static void elba_write_l(struct sdhci_host *host, u32 val, int reg)
> +{
> +       elba_priv_writel(sdhci_cdns_priv(host), val, host->ioaddr + reg);
> +}
> +
> +static void elba_write_w(struct sdhci_host *host, u16 val, int reg)
> +{
> +       struct sdhci_cdns_priv *priv = sdhci_cdns_priv(host);
> +       u32 shift = reg & GENMASK(1, 0);
> +       unsigned long flags;
> +       u32 byte_enables;
> +
> +       byte_enables = GENMASK(1, 0) << shift;
> +       spin_lock_irqsave(&priv->wrlock, flags);
> +       writel(ELBA_BYTE_ENABLE_MASK(byte_enables), priv->ctl_addr);
> +       writew(val, host->ioaddr + reg);
> +       spin_unlock_irqrestore(&priv->wrlock, flags);
> +}
> +
> +static void elba_write_b(struct sdhci_host *host, u8 val, int reg)
> +{
> +       struct sdhci_cdns_priv *priv = sdhci_cdns_priv(host);
> +       u32 shift = reg & GENMASK(1, 0);
> +       unsigned long flags;
> +       u32 byte_enables;
> +
> +       byte_enables = BIT(0) << shift;
> +       spin_lock_irqsave(&priv->wrlock, flags);
> +       writel(ELBA_BYTE_ENABLE_MASK(byte_enables), priv->ctl_addr);
> +       writeb(val, host->ioaddr + reg);
> +       spin_unlock_irqrestore(&priv->wrlock, flags);
> +}
> +
> +static const struct sdhci_ops sdhci_elba_ops = {
> +       .write_l = elba_write_l,
> +       .write_w = elba_write_w,
> +       .write_b = elba_write_b,
> +       .set_clock = sdhci_set_clock,
> +       .get_timeout_clock = sdhci_cdns_get_timeout_clock,
> +       .set_bus_width = sdhci_set_bus_width,
> +       .reset = sdhci_reset,
> +       .set_uhs_signaling = sdhci_cdns_set_uhs_signaling,
> +};
> +
> +static int elba_drv_init(struct platform_device *pdev)
> +{
> +       struct sdhci_host *host = platform_get_drvdata(pdev);
> +       struct sdhci_cdns_priv *priv = sdhci_cdns_priv(host);
> +       void __iomem *ioaddr;
> +
> +       host->mmc->caps |= MMC_CAP_1_8V_DDR | MMC_CAP_8_BIT_DATA;
> +       spin_lock_init(&priv->wrlock);
> +
> +       /* Byte-lane control register */
> +       ioaddr = devm_platform_ioremap_resource(pdev, 1);
> +       if (IS_ERR(ioaddr))
> +               return PTR_ERR(ioaddr);
> +
> +       priv->ctl_addr = ioaddr;
> +       priv->priv_writel = elba_priv_writel;
> +       writel(ELBA_BYTE_ENABLE_MASK(0xf), priv->ctl_addr);
> +
> +       return 0;
> +}
> +
>  static const struct sdhci_ops sdhci_cdns_ops = {
>         .set_clock = sdhci_set_clock,
>         .get_timeout_clock = sdhci_cdns_get_timeout_clock,
> @@ -337,6 +424,13 @@ static const struct sdhci_cdns_drv_data sdhci_cdns_uniphier_drv_data = {
>         },
>  };
>
> +static const struct sdhci_cdns_drv_data sdhci_elba_drv_data = {
> +       .init = elba_drv_init,
> +       .pltfm_data = {
> +               .ops = &sdhci_elba_ops,
> +       },
> +};
> +
>  static const struct sdhci_cdns_drv_data sdhci_cdns_drv_data = {
>         .pltfm_data = {
>                 .ops = &sdhci_cdns_ops,
> @@ -477,6 +571,10 @@ static const struct of_device_id sdhci_cdns_match[] = {
>                 .compatible = "socionext,uniphier-sd4hc",
>                 .data = &sdhci_cdns_uniphier_drv_data,
>         },
> +       {
> +               .compatible = "amd,pensando-elba-sd4hc",
> +               .data = &sdhci_elba_drv_data,
> +       },
>         { .compatible = "cdns,sd4hc" },
>         { /* sentinel */ }
>  };
> --
> 2.17.1
>
