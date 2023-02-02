Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B35A5687955
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 10:45:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232552AbjBBJpI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 04:45:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232593AbjBBJo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 04:44:56 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8437279CA5;
        Thu,  2 Feb 2023 01:44:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675331062; x=1706867062;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=b6fqOVaLWwB9KMvwWppiCRuTFLkK8iUi9lZJH4767T0=;
  b=lCxckssTZnbaatw+uY0Lz0MNHyBCtFvxaOlGeVRU+JujB/XJaE0sLOO8
   SjQmu1kv2r3G2U2uRUxD20pasEJLw64EA4oEHRfpJzbL5bP7VmtgesD1u
   wlmHg5RHLwG3Apa7RkCamxJj7fnrGi2+4CAQAVDbZRXoAyvdLu4XUqQt2
   9RifdJFMwAQ9AxoJKnWBmqd1cM5J5t8vvmina2xF3K/pMDu3UN2HGXQ5+
   orXR1686VkhV97o0VE2+8rEZwwVqDfBxb3phTQD+icTEKkLtRIYP27QkV
   2AVYUX4G5RS9BOUysjH6ki8ZijNWRE5Sukn0xHZoFlvKNHzZNr+fVjhF8
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="316402446"
X-IronPort-AV: E=Sophos;i="5.97,267,1669104000"; 
   d="scan'208";a="316402446"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2023 01:43:30 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="807909658"
X-IronPort-AV: E=Sophos;i="5.97,267,1669104000"; 
   d="scan'208";a="807909658"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.60.179])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2023 01:43:21 -0800
Message-ID: <4c52c455-f09b-1f36-bf36-dce780de4d37@intel.com>
Date:   Thu, 2 Feb 2023 11:43:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.7.1
Subject: Re: [PATCH v9 13/15] mmc: sdhci-cadence: Add AMD Pensando Elba SoC
 support
Content-Language: en-US
To:     Brad Larson <blarson@amd.com>, linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-spi@vger.kernel.org, alcooperx@gmail.com,
        andy.shevchenko@gmail.com, arnd@arndb.de, brad@pensando.io,
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
References: <20230119035136.21603-1-blarson@amd.com>
 <20230119035136.21603-14-blarson@amd.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20230119035136.21603-14-blarson@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/01/23 05:51, Brad Larson wrote:
> Add support for AMD Pensando Elba SoC which explicitly
> controls byte-lane enables on writes.
> 
> Select MMC_SDHCI_IO_ACCESSORS for MMC_SDHCI_CADENCE which
> allows Elba SoC sdhci_elba_ops to overwrite the SDHCI
> IO memory accessors.
> 
> Signed-off-by: Brad Larson <blarson@amd.com>
> ---
> 
> Changes since v6:
> - Previously patch 16/17
> 
> ---
>  drivers/mmc/host/Kconfig         |   1 +
>  drivers/mmc/host/sdhci-cadence.c | 131 ++++++++++++++++++++++++++++---
>  2 files changed, 123 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 5e19a961c34d..9e41115cc753 100644
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
> index 708d4297f241..e92aa79a8be2 100644
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
> @@ -77,6 +79,11 @@ struct sdhci_cdns_phy_cfg {
>  	u8 addr;
>  };
>  
> +struct sdhci_cdns_drv_data {
> +	int (*init)(struct platform_device *pdev);
> +	const struct sdhci_pltfm_data pltfm_data;
> +};

The change to introduce struct sdhci_cdns_drv_data
and sdhci_cdns_uniphier_pltfm_data -> sdhci_cdns_uniphier_drv_data
etc, could be a separate patch.

> +
>  static const struct sdhci_cdns_phy_cfg sdhci_cdns_phy_cfgs[] = {
>  	{ "cdns,phy-input-delay-sd-highspeed", SDHCI_CDNS_PHY_DLY_SD_HS, },
>  	{ "cdns,phy-input-delay-legacy", SDHCI_CDNS_PHY_DLY_SD_DEFAULT, },
> @@ -316,6 +323,92 @@ static void sdhci_cdns_set_uhs_signaling(struct sdhci_host *host,
>  		sdhci_set_uhs_signaling(host, timing);
>  }
>  
> +/* Elba control register bits [6:3] are byte-lane enables */
> +#define ELBA_BYTE_ENABLE_MASK(x)	((x) << 3)
> +
> +/*
> + * The Pensando Elba SoC explicitly controls byte-lane enabling on writes
> + * which includes writes to the HRS registers.
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

Here are below there is an assumption that there is ordering
between successive writel to different registers, and ordering
between them and the spinlock.

If that is the case, then a comment would be good to explain
that.

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
> +
> +	iomem = platform_get_resource(pdev, IORESOURCE_MEM, 1);
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
> +	writel(ELBA_BYTE_ENABLE_MASK(0xf), priv->ctl_addr);
> +
> +	return 0;
> +}
> +
>  static const struct sdhci_ops sdhci_cdns_ops = {
>  	.set_clock = sdhci_set_clock,
>  	.get_timeout_clock = sdhci_cdns_get_timeout_clock,
> @@ -325,13 +418,24 @@ static const struct sdhci_ops sdhci_cdns_ops = {
>  	.set_uhs_signaling = sdhci_cdns_set_uhs_signaling,
>  };
>  
> -static const struct sdhci_pltfm_data sdhci_cdns_uniphier_pltfm_data = {
> -	.ops = &sdhci_cdns_ops,
> -	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
> +static const struct sdhci_cdns_drv_data sdhci_cdns_uniphier_drv_data = {
> +	.pltfm_data = {
> +		.ops = &sdhci_cdns_ops,
> +		.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
> +	},
>  };
>  
> -static const struct sdhci_pltfm_data sdhci_cdns_pltfm_data = {
> -	.ops = &sdhci_cdns_ops,
> +static const struct sdhci_cdns_drv_data sdhci_elba_drv_data = {
> +	.init = elba_drv_init,
> +	.pltfm_data = {
> +		.ops = &sdhci_elba_ops,
> +	},
> +};
> +
> +static const struct sdhci_cdns_drv_data sdhci_cdns_drv_data = {
> +	.pltfm_data = {
> +		.ops = &sdhci_cdns_ops,
> +	},
>  };
>  
>  static void sdhci_cdns_hs400_enhanced_strobe(struct mmc_host *mmc,
> @@ -357,7 +461,7 @@ static void sdhci_cdns_hs400_enhanced_strobe(struct mmc_host *mmc,
>  static int sdhci_cdns_probe(struct platform_device *pdev)
>  {
>  	struct sdhci_host *host;
> -	const struct sdhci_pltfm_data *data;
> +	const struct sdhci_cdns_drv_data *data;
>  	struct sdhci_pltfm_host *pltfm_host;
>  	struct sdhci_cdns_priv *priv;
>  	struct clk *clk;
> @@ -376,10 +480,10 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
>  
>  	data = of_device_get_match_data(dev);
>  	if (!data)
> -		data = &sdhci_cdns_pltfm_data;
> +		data = &sdhci_cdns_drv_data;
>  
>  	nr_phy_params = sdhci_cdns_phy_param_count(dev->of_node);
> -	host = sdhci_pltfm_init(pdev, data,
> +	host = sdhci_pltfm_init(pdev, &data->pltfm_data,
>  				struct_size(priv, phy_params, nr_phy_params));
>  	if (IS_ERR(host)) {
>  		ret = PTR_ERR(host);
> @@ -397,6 +501,11 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
>  	host->ioaddr += SDHCI_CDNS_SRS_BASE;
>  	host->mmc_host_ops.hs400_enhanced_strobe =
>  				sdhci_cdns_hs400_enhanced_strobe;
> +	if (data->init) {
> +		ret = data->init(pdev);
> +		if (ret)
> +			goto free;
> +	}
>  	sdhci_enable_v4_mode(host);
>  	__sdhci_read_caps(host, &version, NULL, NULL);
>  
> @@ -461,7 +570,11 @@ static const struct dev_pm_ops sdhci_cdns_pm_ops = {
>  static const struct of_device_id sdhci_cdns_match[] = {
>  	{
>  		.compatible = "socionext,uniphier-sd4hc",
> -		.data = &sdhci_cdns_uniphier_pltfm_data,
> +		.data = &sdhci_cdns_uniphier_drv_data,
> +	},
> +	{
> +		.compatible = "amd,pensando-elba-sd4hc",
> +		.data = &sdhci_elba_drv_data,
>  	},
>  	{ .compatible = "cdns,sd4hc" },
>  	{ /* sentinel */ }

