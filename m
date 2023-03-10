Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 227DC6B3D5B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 12:11:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbjCJLLj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 06:11:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230016AbjCJLL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 06:11:27 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4DCC10868C;
        Fri, 10 Mar 2023 03:11:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678446670; x=1709982670;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=npGaCRGx/7ECVukeEjEPCoJm+CZAwl1/MIelsOcJNDI=;
  b=WdS1tPJi459Cc0wm4UiTWk5yXb7wUFBY43FYApsBNhleHGwOtNzTy9dU
   X4RTew+HN+cZA5fsTLqyIwrp8YOn7vw8hESd/HOlniHhY+6Erzcb3WJLv
   2I/gunvEVteNlWyax63e3Md5NHLFlBbTVrwE7l5q2g5TQmav4TSY2ODaX
   xttcVFU2Kh2f8XBczTetmZgFM5j53LvBd04kglllLqaJhvZADpgjyfSKH
   CIqYs9J9UX7ui9X8Bfjx6yFdprWKopQvdm+/l9gCS8H1x+X0Qv80X6me0
   IaSS/WXLW8FQbI5oidJUPXubd2WYLUsX9hij2lstGlQnpFbXDkR7xvTuL
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="336723214"
X-IronPort-AV: E=Sophos;i="5.98,249,1673942400"; 
   d="scan'208";a="336723214"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2023 03:11:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="707974172"
X-IronPort-AV: E=Sophos;i="5.98,249,1673942400"; 
   d="scan'208";a="707974172"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.60.222])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2023 03:11:00 -0800
Message-ID: <94a7eba7-3e6c-348f-d208-0fc218d8d032@intel.com>
Date:   Fri, 10 Mar 2023 13:10:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.8.0
Subject: Re: [PATCH v10 13/15] mmc: sdhci-cadence: Add AMD Pensando Elba SoC
 support
Content-Language: en-US
To:     Brad Larson <blarson@amd.com>, linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-spi@vger.kernel.org, alcooperx@gmail.com,
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
        ulf.hansson@linaro.org, vaishnav.a@ti.com, will@kernel.org,
        devicetree@vger.kernel.org
References: <20230306040739.51488-1-blarson@amd.com>
 <20230306040739.51488-14-blarson@amd.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20230306040739.51488-14-blarson@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/03/23 06:07, Brad Larson wrote:
> Add support for AMD Pensando Elba SoC which explicitly
> controls byte-lane enables on writes.
> 
> Select MMC_SDHCI_IO_ACCESSORS for MMC_SDHCI_CADENCE which
> allows Elba SoC sdhci_elba_ops to overwrite the SDHCI
> IO memory accessors.
> 
> Signed-off-by: Brad Larson <blarson@amd.com>

Minor comments below.  Fix those and you can add:

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
> 
> v10 changes:
> - Add Elba specific support into this 3rd patch.  This builds on the private
>   writel() enabled in patch 1 followed by platform specific init() in patch 2.
> - Specify when first used the reason for the spinlock use to order byte-enable
>   prior to write data.
> 
> ---
>  drivers/mmc/host/Kconfig         |   1 +
>  drivers/mmc/host/sdhci-cadence.c | 101 +++++++++++++++++++++++++++++++
>  2 files changed, 102 insertions(+)
> 
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 4745fe217ade..9f793892123c 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -255,6 +255,7 @@ config MMC_SDHCI_CADENCE
>  	tristate "SDHCI support for the Cadence SD/SDIO/eMMC controller"
>  	depends on MMC_SDHCI_PLTFM
>  	depends on OF
> +	select MMC_SDHCI_IO_ACCESSORS
>  	help
>  	  This selects the Cadence SD/SDIO/eMMC driver.
>  
> diff --git a/drivers/mmc/host/sdhci-cadence.c b/drivers/mmc/host/sdhci-cadence.c
> index c528a25f48b8..31c77d32aa7d 100644
> --- a/drivers/mmc/host/sdhci-cadence.c
> +++ b/drivers/mmc/host/sdhci-cadence.c
> @@ -66,6 +66,8 @@ struct sdhci_cdns_phy_param {
>  
>  struct sdhci_cdns_priv {
>  	void __iomem *hrs_addr;
> +	void __iomem *ctl_addr;	/* write control */
> +	spinlock_t wrlock;	/* write lock */
>  	bool enhanced_strobe;
>  	void (*priv_writel)(struct sdhci_cdns_priv *priv, u32 val, void __iomem *reg);
>  	unsigned int nr_phy_params;
> @@ -321,6 +323,94 @@ static void sdhci_cdns_set_uhs_signaling(struct sdhci_host *host,
>  		sdhci_set_uhs_signaling(host, timing);
>  }
>  
> +/* Elba control register bits [6:3] are byte-lane enables */
> +#define ELBA_BYTE_ENABLE_MASK(x)	((x) << 3)
> +
> +/*
> + * The Pensando Elba SoC explicitly controls byte-lane enabling on writes
> + * which includes writes to the HRS registers.  The write lock (wrlock)
> + * is used to ensure byte-lane enable, using write control (ctl_addr),
> + * occurs before the data write.
> + */
> +static void elba_priv_writel(struct sdhci_cdns_priv *priv, u32 val,
> +			     void __iomem *reg)
> +{
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&priv->wrlock, flags);
> +	writel(ELBA_BYTE_ENABLE_MASK(0xf), priv->ctl_addr);
> +	writel(val, reg);
> +	spin_unlock_irqrestore(&priv->wrlock, flags);
> +}
> +
> +static void elba_write_l(struct sdhci_host *host, u32 val, int reg)
> +{
> +	elba_priv_writel(sdhci_cdns_priv(host), val, host->ioaddr + reg);
> +}
> +
> +static void elba_write_w(struct sdhci_host *host, u16 val, int reg)
> +{
> +	struct sdhci_cdns_priv *priv = sdhci_cdns_priv(host);
> +	u32 byte_enables;
> +	unsigned long flags;
> +
> +	byte_enables = GENMASK(1, 0) << (reg & 0x3);
> +	spin_lock_irqsave(&priv->wrlock, flags);
> +	writel(ELBA_BYTE_ENABLE_MASK(byte_enables), priv->ctl_addr);
> +	writew(val, host->ioaddr + reg);
> +	spin_unlock_irqrestore(&priv->wrlock, flags);
> +}
> +
> +static void elba_write_b(struct sdhci_host *host, u8 val, int reg)
> +{
> +	struct sdhci_cdns_priv *priv = sdhci_cdns_priv(host);
> +	u32 byte_enables;
> +	unsigned long flags;
> +
> +	byte_enables = BIT(0) << (reg & 0x3);
> +	spin_lock_irqsave(&priv->wrlock, flags);
> +	writel(ELBA_BYTE_ENABLE_MASK(byte_enables), priv->ctl_addr);
> +	writeb(val, host->ioaddr + reg);
> +	spin_unlock_irqrestore(&priv->wrlock, flags);
> +}
> +
> +static const struct sdhci_ops sdhci_elba_ops = {
> +	.write_l = elba_write_l,
> +	.write_w = elba_write_w,
> +	.write_b = elba_write_b,
> +	.set_clock = sdhci_set_clock,
> +	.get_timeout_clock = sdhci_cdns_get_timeout_clock,
> +	.set_bus_width = sdhci_set_bus_width,
> +	.reset = sdhci_reset,
> +	.set_uhs_signaling = sdhci_cdns_set_uhs_signaling,
> +};
> +
> +static int elba_drv_init(struct platform_device *pdev)
> +{
> +	struct sdhci_host *host = platform_get_drvdata(pdev);
> +	struct sdhci_cdns_priv *priv = sdhci_cdns_priv(host);
> +	struct resource *iomem;
> +	void __iomem *ioaddr;
> +
> +	host->mmc->caps |= (MMC_CAP_1_8V_DDR | MMC_CAP_8_BIT_DATA);

Unnecessary parentheses

> +
> +	iomem = platform_get_resource(pdev, IORESOURCE_MEM, 1);

Looks like devm_platform_ioremap_resource() does that also
and will return an error if need be, so platform_get_resource()
is not needed here.

> +	if (!iomem)
> +		return -ENOMEM;
> +
> +	/* Byte-lane control register */
> +	ioaddr = devm_platform_ioremap_resource(pdev, 1);
> +	if (IS_ERR(ioaddr))
> +		return PTR_ERR(ioaddr);
> +
> +	priv->ctl_addr = ioaddr;
> +	priv->priv_writel = elba_priv_writel;
> +	spin_lock_init(&priv->wrlock);

Please move the spin_lock_init() so it happens always.

> +	writel(ELBA_BYTE_ENABLE_MASK(0xf), priv->ctl_addr);
> +
> +	return 0;
> +}
> +
>  static const struct sdhci_ops sdhci_cdns_ops = {
>  	.set_clock = sdhci_set_clock,
>  	.get_timeout_clock = sdhci_cdns_get_timeout_clock,
> @@ -337,6 +427,13 @@ static const struct sdhci_cdns_drv_data sdhci_cdns_uniphier_drv_data = {
>  	},
>  };
>  
> +static const struct sdhci_cdns_drv_data sdhci_elba_drv_data = {
> +	.init = elba_drv_init,
> +	.pltfm_data = {
> +		.ops = &sdhci_elba_ops,
> +	},
> +};
> +
>  static const struct sdhci_cdns_drv_data sdhci_cdns_drv_data = {
>  	.pltfm_data = {
>  		.ops = &sdhci_cdns_ops,
> @@ -477,6 +574,10 @@ static const struct of_device_id sdhci_cdns_match[] = {
>  		.compatible = "socionext,uniphier-sd4hc",
>  		.data = &sdhci_cdns_uniphier_drv_data,
>  	},
> +	{
> +		.compatible = "amd,pensando-elba-sd4hc",
> +		.data = &sdhci_elba_drv_data,
> +	},
>  	{ .compatible = "cdns,sd4hc" },
>  	{ /* sentinel */ }
>  };

