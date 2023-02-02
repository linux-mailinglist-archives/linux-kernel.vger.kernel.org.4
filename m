Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A1466886EE
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 19:44:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232735AbjBBSoG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 13:44:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232677AbjBBSnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 13:43:51 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAD736D05F;
        Thu,  2 Feb 2023 10:43:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675363404; x=1706899404;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=++ASRvotZB1UEAtRLT9zmbE4W31Xp8NyYecizXotwAE=;
  b=MCTGtiPcPeictYTiOHEAVAUW4dfBBtrc3khCAHwO02dorKeDgqKZs4W/
   8bP4KTGydeu2dYhCZCtP6EvNXvWMFe//BmEy4/atIDfq0y1pQEV+XpfLu
   gb44BY+R1CGWPiyA0nJraLVmuvTbS3lAAY8VWGPyGVcMxxRlStPsTQXDB
   b5Kgn0/c867qCePbkhCZYhMeLQOGfNsNmMPPAm4ef8wG5evpY4qUVbaAG
   mclCf9mhh4FlTZOYn5VLVjhOR7HI7ZythVUnYqf0he+0YQb8LhI05jU4S
   MsSYLQvc0ZZmvregErxCmZmNKxJsLOxt8BERgoj0EGZf8JblBXmFjo/Pn
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10609"; a="326233073"
X-IronPort-AV: E=Sophos;i="5.97,268,1669104000"; 
   d="scan'208";a="326233073"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2023 10:42:42 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10609"; a="697779630"
X-IronPort-AV: E=Sophos;i="5.97,268,1669104000"; 
   d="scan'208";a="697779630"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.249.35.116])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2023 10:42:37 -0800
Message-ID: <d08a1fc5-727c-7845-7aeb-729c5aa68189@intel.com>
Date:   Thu, 2 Feb 2023 20:42:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.7.1
Subject: Re: [PATCH v2 1/5] drivers: mmc: sdhci-cadence: Reformat the code
Content-Language: en-US
To:     Piyush Malgujar <pmalgujar@marvell.com>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, ulf.hansson@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        yamada.masahiro@socionext.com, devicetree@vger.kernel.org,
        Brad Larson <blarson@amd.com>
Cc:     jannadurai@marvell.com, cchavva@marvell.com,
        Dhananjay Kangude <dkangude@cadence.com>
References: <20230123192735.21136-1-pmalgujar@marvell.com>
 <20230123192735.21136-2-pmalgujar@marvell.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20230123192735.21136-2-pmalgujar@marvell.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/01/23 21:27, Piyush Malgujar wrote:
> From: Dhananjay Kangude <dkangude@cadence.com>
> 
> Reformat the code so that further SD6 changes could be
> added and it could be isolated from SD4 related code.
> Also renamed functions accordingly.

It is good to have the renaming and white space changes
in a separate patch, but there is also some restructuring
in this patch that needs to be in 1 or more separate patches.

There are also still some white space changes in the next
patch.

> 
> Signed-off-by: Dhananjay Kangude <dkangude@cadence.com>
> Co-developed-by: Jayanthi Annadurai <jannadurai@marvell.com>
> Signed-off-by: Jayanthi Annadurai <jannadurai@marvell.com>
> Signed-off-by: Piyush Malgujar <pmalgujar@marvell.com>
> ---
>  drivers/mmc/host/sdhci-cadence.c | 165 ++++++++++++++++++++-----------
>  1 file changed, 110 insertions(+), 55 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-cadence.c b/drivers/mmc/host/sdhci-cadence.c
> index 6f2de54a598773879bf339aae8450f63e1251509..cb108ff9abda32767b356bb572abdf8626746cd6 100644
> --- a/drivers/mmc/host/sdhci-cadence.c
> +++ b/drivers/mmc/host/sdhci-cadence.c
> @@ -15,14 +15,14 @@
>  
>  #include "sdhci-pltfm.h"
>  
> -/* HRS - Host Register Set (specific to Cadence) */
> +/* SD 4.0 Controller HRS - Host Register Set (specific to Cadence) */
>  #define SDHCI_CDNS_HRS04		0x10		/* PHY access port */
> -#define   SDHCI_CDNS_HRS04_ACK			BIT(26)
> -#define   SDHCI_CDNS_HRS04_RD			BIT(25)
> -#define   SDHCI_CDNS_HRS04_WR			BIT(24)
> -#define   SDHCI_CDNS_HRS04_RDATA		GENMASK(23, 16)
> -#define   SDHCI_CDNS_HRS04_WDATA		GENMASK(15, 8)
> -#define   SDHCI_CDNS_HRS04_ADDR			GENMASK(5, 0)
> +#define SDHCI_CDNS_SD4_HRS04_ACK		BIT(26)
> +#define SDHCI_CDNS_SD4_HRS04_RD			BIT(25)
> +#define SDHCI_CDNS_SD4_HRS04_WR			BIT(24)
> +#define SDHCI_CDNS_SD4_HRS04_RDATA		GENMASK(23, 16)
> +#define SDHCI_CDNS_SD4_HRS04_WDATA		GENMASK(15, 8)
> +#define SDHCI_CDNS_SD4_HRS04_ADDR		GENMASK(5, 0)
>  
>  #define SDHCI_CDNS_HRS06		0x18		/* eMMC control */
>  #define   SDHCI_CDNS_HRS06_TUNE_UP		BIT(15)
> @@ -38,7 +38,7 @@
>  /* SRS - Slot Register Set (SDHCI-compatible) */
>  #define SDHCI_CDNS_SRS_BASE		0x200
>  
> -/* PHY */
> +/* PHY registers for SD4 controller */
>  #define SDHCI_CDNS_PHY_DLY_SD_HS	0x00
>  #define SDHCI_CDNS_PHY_DLY_SD_DEFAULT	0x01
>  #define SDHCI_CDNS_PHY_DLY_UHS_SDR12	0x02
> @@ -59,24 +59,43 @@
>   */
>  #define SDHCI_CDNS_MAX_TUNING_LOOP	40
>  
> -struct sdhci_cdns_phy_param {
> +struct sdhci_cdns_priv;
> +
> +struct sdhci_cdns_sd4_phy_param {
>  	u8 addr;
>  	u8 data;
>  };
>  
> +struct sdhci_cdns_data {
> +	int (*phy_init)(struct sdhci_cdns_priv *priv);
> +	int (*set_tune_val)(struct sdhci_host *host, unsigned int val);
> +};
> +
> +struct sdhci_cdns_sd4_phy {
> +	unsigned int nr_phy_params;
> +	struct sdhci_cdns_sd4_phy_param phy_params[];
> +};
> +
>  struct sdhci_cdns_priv {
>  	void __iomem *hrs_addr;
>  	bool enhanced_strobe;
> -	unsigned int nr_phy_params;
> -	struct sdhci_cdns_phy_param phy_params[];
> +	const struct sdhci_cdns_data *cdns_data;
> +	void *phy;
>  };
>  
> -struct sdhci_cdns_phy_cfg {
> +struct sdhci_cdns_sd4_phy_cfg {
>  	const char *property;
>  	u8 addr;
>  };
>  
> -static const struct sdhci_cdns_phy_cfg sdhci_cdns_phy_cfgs[] = {
> +struct sdhci_cdns_of_data {
> +	const struct sdhci_pltfm_data *pltfm_data;
> +	const struct sdhci_cdns_data *cdns_data;
> +	int (*phy_probe)(struct platform_device *pdev,
> +			 struct sdhci_cdns_priv *priv);
> +};
> +
> +static const struct sdhci_cdns_sd4_phy_cfg sdhci_cdns_sd4_phy_cfgs[] = {
>  	{ "cdns,phy-input-delay-sd-highspeed", SDHCI_CDNS_PHY_DLY_SD_HS, },
>  	{ "cdns,phy-input-delay-legacy", SDHCI_CDNS_PHY_DLY_SD_DEFAULT, },
>  	{ "cdns,phy-input-delay-sd-uhs-sdr12", SDHCI_CDNS_PHY_DLY_UHS_SDR12, },
> @@ -90,80 +109,80 @@ static const struct sdhci_cdns_phy_cfg sdhci_cdns_phy_cfgs[] = {
>  	{ "cdns,phy-dll-delay-strobe", SDHCI_CDNS_PHY_DLY_STROBE, },
>  };
>  
> -static int sdhci_cdns_write_phy_reg(struct sdhci_cdns_priv *priv,
> -				    u8 addr, u8 data)
> +static int sdhci_cdns_sd4_write_phy_reg(struct sdhci_cdns_priv *priv,
> +					u8 addr, u8 data)
>  {
>  	void __iomem *reg = priv->hrs_addr + SDHCI_CDNS_HRS04;
>  	u32 tmp;
>  	int ret;
>  
> -	ret = readl_poll_timeout(reg, tmp, !(tmp & SDHCI_CDNS_HRS04_ACK),
> +	ret = readl_poll_timeout(reg, tmp, !(tmp & SDHCI_CDNS_SD4_HRS04_ACK),
>  				 0, 10);
>  	if (ret)
>  		return ret;
>  
> -	tmp = FIELD_PREP(SDHCI_CDNS_HRS04_WDATA, data) |
> -	      FIELD_PREP(SDHCI_CDNS_HRS04_ADDR, addr);
> +	tmp = FIELD_PREP(SDHCI_CDNS_SD4_HRS04_WDATA, data) |
> +	      FIELD_PREP(SDHCI_CDNS_SD4_HRS04_ADDR, addr);
>  	writel(tmp, reg);
>  
> -	tmp |= SDHCI_CDNS_HRS04_WR;
> +	tmp |= SDHCI_CDNS_SD4_HRS04_WR;
>  	writel(tmp, reg);
>  
> -	ret = readl_poll_timeout(reg, tmp, tmp & SDHCI_CDNS_HRS04_ACK, 0, 10);
> +	ret = readl_poll_timeout(reg, tmp, tmp & SDHCI_CDNS_SD4_HRS04_ACK, 0, 10);
>  	if (ret)
>  		return ret;
>  
> -	tmp &= ~SDHCI_CDNS_HRS04_WR;
> +	tmp &= ~SDHCI_CDNS_SD4_HRS04_WR;
>  	writel(tmp, reg);
>  
> -	ret = readl_poll_timeout(reg, tmp, !(tmp & SDHCI_CDNS_HRS04_ACK),
> +	ret = readl_poll_timeout(reg, tmp, !(tmp & SDHCI_CDNS_SD4_HRS04_ACK),
>  				 0, 10);
>  
>  	return ret;
>  }
>  
> -static unsigned int sdhci_cdns_phy_param_count(struct device_node *np)
> +static unsigned int sdhci_cdns_sd4_phy_param_count(struct device_node *np)
>  {
>  	unsigned int count = 0;
>  	int i;
>  
> -	for (i = 0; i < ARRAY_SIZE(sdhci_cdns_phy_cfgs); i++)
> -		if (of_property_read_bool(np, sdhci_cdns_phy_cfgs[i].property))
> +	for (i = 0; i < ARRAY_SIZE(sdhci_cdns_sd4_phy_cfgs); i++)
> +		if (of_property_read_bool(np, sdhci_cdns_sd4_phy_cfgs[i].property))
>  			count++;
>  
>  	return count;
>  }
>  
> -static void sdhci_cdns_phy_param_parse(struct device_node *np,
> -				       struct sdhci_cdns_priv *priv)
> +static void sdhci_cdns_sd4_phy_param_parse(struct device_node *np,
> +					   struct sdhci_cdns_sd4_phy *phy)
>  {
> -	struct sdhci_cdns_phy_param *p = priv->phy_params;
> +	struct sdhci_cdns_sd4_phy_param *p = phy->phy_params;
>  	u32 val;
>  	int ret, i;
>  
> -	for (i = 0; i < ARRAY_SIZE(sdhci_cdns_phy_cfgs); i++) {
> -		ret = of_property_read_u32(np, sdhci_cdns_phy_cfgs[i].property,
> +	for (i = 0; i < ARRAY_SIZE(sdhci_cdns_sd4_phy_cfgs); i++) {
> +		ret = of_property_read_u32(np, sdhci_cdns_sd4_phy_cfgs[i].property,
>  					   &val);
>  		if (ret)
>  			continue;
>  
> -		p->addr = sdhci_cdns_phy_cfgs[i].addr;
> +		p->addr = sdhci_cdns_sd4_phy_cfgs[i].addr;
>  		p->data = val;
>  		p++;
>  	}
>  }
>  
> -static int sdhci_cdns_phy_init(struct sdhci_cdns_priv *priv)
> +static int sdhci_cdns_sd4_phy_init(struct sdhci_cdns_priv *priv)
>  {
>  	int ret, i;
> +	struct sdhci_cdns_sd4_phy *phy = priv->phy;
>  
> -	for (i = 0; i < priv->nr_phy_params; i++) {
> -		ret = sdhci_cdns_write_phy_reg(priv, priv->phy_params[i].addr,
> -					       priv->phy_params[i].data);
> +	for (i = 0; i < phy->nr_phy_params; i++) {
> +		ret = sdhci_cdns_sd4_write_phy_reg(priv, phy->phy_params[i].addr,
> +						   phy->phy_params[i].data);
>  		if (ret)
>  			return ret;
>  	}
> -
>  	return 0;
>  }
>  
> @@ -202,7 +221,28 @@ static u32 sdhci_cdns_get_emmc_mode(struct sdhci_cdns_priv *priv)
>  	return FIELD_GET(SDHCI_CDNS_HRS06_MODE, tmp);
>  }
>  
> -static int sdhci_cdns_set_tune_val(struct sdhci_host *host, unsigned int val)
> +static int sdhci_cdns_sd4_phy_probe(struct platform_device *pdev,
> +				    struct sdhci_cdns_priv *priv)
> +{
> +	unsigned int nr_phy_params;
> +	struct sdhci_cdns_sd4_phy *phy;
> +	struct device *dev = &pdev->dev;
> +
> +	nr_phy_params = sdhci_cdns_sd4_phy_param_count(dev->of_node);
> +	phy = devm_kzalloc(dev, struct_size(phy, phy_params, nr_phy_params),
> +			   GFP_KERNEL);
> +	if (!phy)
> +		return -ENOMEM;
> +
> +	phy->nr_phy_params = nr_phy_params;
> +
> +	sdhci_cdns_sd4_phy_param_parse(dev->of_node, phy);
> +	priv->phy = phy;
> +
> +	return 0;
> +}
> +
> +static int sdhci_cdns_sd4_set_tune_val(struct sdhci_host *host, unsigned int val)
>  {
>  	struct sdhci_cdns_priv *priv = sdhci_cdns_priv(host);
>  	void __iomem *reg = priv->hrs_addr + SDHCI_CDNS_HRS06;
> @@ -255,7 +295,7 @@ static int sdhci_cdns_execute_tuning(struct sdhci_host *host, u32 opcode)
>  		return 0;
>  
>  	for (i = 0; i < SDHCI_CDNS_MAX_TUNING_LOOP; i++) {
> -		if (sdhci_cdns_set_tune_val(host, i) ||
> +		if (sdhci_cdns_sd4_set_tune_val(host, i) ||
>  		    mmc_send_tuning(host->mmc, opcode, NULL)) { /* bad */
>  			cur_streak = 0;
>  		} else { /* good */
> @@ -272,7 +312,7 @@ static int sdhci_cdns_execute_tuning(struct sdhci_host *host, u32 opcode)
>  		return -EIO;
>  	}
>  
> -	return sdhci_cdns_set_tune_val(host, end_of_streak - max_streak / 2);
> +	return sdhci_cdns_sd4_set_tune_val(host, end_of_streak - max_streak / 2);
>  }
>  
>  static void sdhci_cdns_set_uhs_signaling(struct sdhci_host *host,
> @@ -309,7 +349,7 @@ static void sdhci_cdns_set_uhs_signaling(struct sdhci_host *host,
>  		sdhci_set_uhs_signaling(host, timing);
>  }
>  
> -static const struct sdhci_ops sdhci_cdns_ops = {
> +static const struct sdhci_ops sdhci_cdns_sd4_ops = {
>  	.set_clock = sdhci_set_clock,
>  	.get_timeout_clock = sdhci_cdns_get_timeout_clock,
>  	.set_bus_width = sdhci_set_bus_width,
> @@ -319,12 +359,23 @@ static const struct sdhci_ops sdhci_cdns_ops = {
>  };
>  
>  static const struct sdhci_pltfm_data sdhci_cdns_uniphier_pltfm_data = {
> -	.ops = &sdhci_cdns_ops,
> +	.ops = &sdhci_cdns_sd4_ops,
>  	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
>  };
>  
> -static const struct sdhci_pltfm_data sdhci_cdns_pltfm_data = {
> -	.ops = &sdhci_cdns_ops,
> +static const struct sdhci_pltfm_data sdhci_cdns_sd4_pltfm_data = {
> +	.ops = &sdhci_cdns_sd4_ops,
> +};
> +
> +static const struct sdhci_cdns_data sdhci_cdns_sd4_data = {
> +	.phy_init = sdhci_cdns_sd4_phy_init,
> +	.set_tune_val = sdhci_cdns_sd4_set_tune_val,
> +};
> +
> +static const struct sdhci_cdns_of_data sdhci_cdns_sd4_of_data = {
> +	.pltfm_data = &sdhci_cdns_sd4_pltfm_data,
> +	.cdns_data = &sdhci_cdns_sd4_data,
> +	.phy_probe = sdhci_cdns_sd4_phy_probe,
>  };
>  
>  static void sdhci_cdns_hs400_enhanced_strobe(struct mmc_host *mmc,
> @@ -350,11 +401,10 @@ static void sdhci_cdns_hs400_enhanced_strobe(struct mmc_host *mmc,
>  static int sdhci_cdns_probe(struct platform_device *pdev)
>  {
>  	struct sdhci_host *host;
> -	const struct sdhci_pltfm_data *data;
> +	const struct sdhci_cdns_of_data *data;
>  	struct sdhci_pltfm_host *pltfm_host;
>  	struct sdhci_cdns_priv *priv;
>  	struct clk *clk;
> -	unsigned int nr_phy_params;
>  	int ret;
>  	struct device *dev = &pdev->dev;
>  	static const u16 version = SDHCI_SPEC_400 << SDHCI_SPEC_VER_SHIFT;
> @@ -368,12 +418,12 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
>  		return ret;
>  
>  	data = of_device_get_match_data(dev);
> -	if (!data)
> -		data = &sdhci_cdns_pltfm_data;
> +	if (!data) {
> +		return PTR_ERR(clk);
> +		goto disable_clk;

'return' followed by 'goto'

Please review patches before submitting.

> +	}
>  
> -	nr_phy_params = sdhci_cdns_phy_param_count(dev->of_node);
> -	host = sdhci_pltfm_init(pdev, data,
> -				struct_size(priv, phy_params, nr_phy_params));
> +	host = sdhci_pltfm_init(pdev, data->pltfm_data, sizeof(*priv));
>  	if (IS_ERR(host)) {
>  		ret = PTR_ERR(host);
>  		goto disable_clk;
> @@ -383,9 +433,9 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
>  	pltfm_host->clk = clk;
>  
>  	priv = sdhci_pltfm_priv(pltfm_host);
> -	priv->nr_phy_params = nr_phy_params;
>  	priv->hrs_addr = host->ioaddr;
>  	priv->enhanced_strobe = false;
> +	priv->cdns_data = data->cdns_data;
>  	host->ioaddr += SDHCI_CDNS_SRS_BASE;
>  	host->mmc_host_ops.hs400_enhanced_strobe =
>  				sdhci_cdns_hs400_enhanced_strobe;
> @@ -398,9 +448,11 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto free;
>  
> -	sdhci_cdns_phy_param_parse(dev->of_node, priv);
> +	ret = data->phy_probe(pdev, priv);
> +	if (ret)
> +		goto free;
>  
> -	ret = sdhci_cdns_phy_init(priv);
> +	ret = priv->cdns_data->phy_init(priv);
>  	if (ret)
>  		goto free;
>  
> @@ -429,7 +481,7 @@ static int sdhci_cdns_resume(struct device *dev)
>  	if (ret)
>  		return ret;
>  
> -	ret = sdhci_cdns_phy_init(priv);
> +	ret = priv->cdns_data->phy_init(priv);
>  	if (ret)
>  		goto disable_clk;
>  
> @@ -455,7 +507,10 @@ static const struct of_device_id sdhci_cdns_match[] = {
>  		.compatible = "socionext,uniphier-sd4hc",
>  		.data = &sdhci_cdns_uniphier_pltfm_data,
>  	},
> -	{ .compatible = "cdns,sd4hc" },
> +	{
> +		.compatible = "cdns,sd4hc",
> +		.data = &sdhci_cdns_sd4_of_data,

sdhci_cdns_uniphier_pltfm_data is a pointer to a struct sdhci_pltfm_data, but
sdhci_cdns_sd4_of_data is a pointer to a struct sdhci_cdns_of_data.
That is error prone.  For example, you dereference data->cdns_data
unconditionally even though it does not exist for sdhci_cdns_uniphier_pltfm_data.

Also this patch is in conflict with the approach taken by:

https://lore.kernel.org/linux-mmc/20230119035136.21603-14-blarson@amd.com/

> +	},
>  	{ /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(of, sdhci_cdns_match);

