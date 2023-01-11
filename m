Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EFB2665615
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 09:29:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231947AbjAKI3n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 03:29:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbjAKI3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 03:29:32 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99D0B2017;
        Wed, 11 Jan 2023 00:29:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673425771; x=1704961771;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=uBFuYOIFelXp3Czc6m1RT/eC6rDQTkmly1w/VKCVTlo=;
  b=jN8Z0QgAzYTWPrnk21vg8psXEQNBXBM/BIBZnhvoaS3PgOR/P41JsZUe
   uo1xs/6xOybWLnWRf8aZ7Fz37EREa8LTH8BALh42ShYO93TeHDSoqnDAG
   Ttg6VnRyU3wOQgP2F9IOvM0XjE2QOyemx/ta6hu0FyFQ6NjxYe0MpL56M
   89jvHpIwgoL80PFKQDiVRGaR+7+Ds4XL/luJ4slzCsEvZKC/wDlyTfcnV
   oiWWeAYu4mOb/af8k/o+xlR7fyIe0u8HiflK5gOZ8E6xnQVGa9ooNvnS6
   Ux19HKELNixobc/Ncvg9mneaajbNONdddcXbmeq+8ScewIchxgB/hw+FL
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="306878077"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="306878077"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2023 00:29:31 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="986071805"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="986071805"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.37.49])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2023 00:29:27 -0800
Message-ID: <48ac6ea0-7cd0-aae5-ff83-cdd278057708@intel.com>
Date:   Wed, 11 Jan 2023 10:29:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.1
Subject: Re: [PATCH 5/5] drivers: mmc: sdhci-cadence: Add debug option for
 sdhci-cadence driver.
Content-Language: en-US
To:     Piyush Malgujar <pmalgujar@marvell.com>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, ulf.hansson@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        yamada.masahiro@socionext.com, devicetree@vger.kernel.org
Cc:     jannadurai@marvell.com, cchavva@marvell.com
References: <20221219142418.27949-1-pmalgujar@marvell.com>
 <20221219142418.27949-6-pmalgujar@marvell.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20221219142418.27949-6-pmalgujar@marvell.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/12/22 16:24, Piyush Malgujar wrote:
> From: Jayanthi Annadurai <jannadurai@marvell.com>
> 
> Use Kernel config CONFIG_MMC_DEBUG to support dumping PHY and host
> controller register configuration for debug.
> 
> Signed-off-by: Jayanthi Annadurai <jannadurai@marvell.com>
> Signed-off-by: Piyush Malgujar <pmalgujar@marvell.com>
> ---
>  drivers/mmc/host/sdhci-cadence.c | 100 +++++++++++++++++++++++++++++++
>  1 file changed, 100 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-cadence.c b/drivers/mmc/host/sdhci-cadence.c
> index 6bf703f15bc5be7e3be4cb1144b78ec3585ec540..75363aabce9228755c4abed08fe17e57d1a44b23 100644
> --- a/drivers/mmc/host/sdhci-cadence.c
> +++ b/drivers/mmc/host/sdhci-cadence.c
> @@ -15,6 +15,10 @@
>  
>  #include "sdhci-pltfm.h"
>  
> +#ifdef CONFIG_MMC_DEBUG
> +#define DEBUG_DRV	pr_info

Not sure what the point of that is

> +#endif
> +
>  #define SDMCLK_MAX_FREQ		200000000
>  
>  #define DEFAULT_CMD_DELAY		16
> @@ -115,6 +119,10 @@
>  #define	SDHCI_CDNS_SD6_PHY_DLL_SLAVE_CLK_WR_DELAY		GENMASK(15, 8)
>  #define	SDHCI_CDNS_SD6_PHY_DLL_SLAVE_READ_DQS_DELAY		GENMASK(7, 0)
>  
> +#define SDHCI_CDNS_SD6_PHY_DLL_OBS_REG0				0x201C
> +#define SDHCI_CDNS_SD6_PHY_DLL_OBS_REG1				0x2020
> +#define SDHCI_CDNS_SD6_PHY_DLL_OBS_REG2				0x2024
> +
>  #define SDHCI_CDNS_SD6_PHY_CTRL					0x2080
>  #define	SDHCI_CDNS_SD6_PHY_CTRL_PHONY_DQS_TIMING		GENMASK(9, 4)
>  
> @@ -969,6 +977,94 @@ static void sdhci_cdns_sd6_calc_phy(struct sdhci_cdns_sd6_phy *phy)
>  	}
>  }
>  
> +#ifdef CONFIG_MMC_DEBUG

Put the DEBUG_DRV definition here instead of above i.e.

#define DEBUG_DRV	pr_info

> +static void sdhci_cdns_sd6_phy_dump(struct sdhci_cdns_sd6_phy *phy)
> +{
> +	DEBUG_DRV("PHY Timings\n");
> +	DEBUG_DRV("mode %d t_sdclk %d\n", phy->mode, phy->t_sdclk);
> +
> +	DEBUG_DRV("cp_clk_wr_delay %d\n", phy->settings.cp_clk_wr_delay);
> +	DEBUG_DRV("cp_clk_wrdqs_delay %d\n", phy->settings.cp_clk_wrdqs_delay);
> +	DEBUG_DRV("cp_data_select_oe_end %d\n", phy->settings.cp_data_select_oe_end);
> +	DEBUG_DRV("cp_dll_bypass_mode %d\n", phy->settings.cp_dll_bypass_mode);
> +	DEBUG_DRV("cp_dll_locked_mode %d\n", phy->settings.cp_dll_locked_mode);
> +	DEBUG_DRV("cp_dll_start_point %d\n", phy->settings.cp_dll_start_point);
> +	DEBUG_DRV("cp_io_mask_always_on %d\n", phy->settings.cp_io_mask_always_on);
> +	DEBUG_DRV("cp_io_mask_end %d\n", phy->settings.cp_io_mask_end);
> +	DEBUG_DRV("cp_io_mask_start %d\n", phy->settings.cp_io_mask_start);
> +	DEBUG_DRV("cp_rd_del_sel %d\n", phy->settings.cp_rd_del_sel);
> +	DEBUG_DRV("cp_read_dqs_cmd_delay %d\n", phy->settings.cp_read_dqs_cmd_delay);
> +	DEBUG_DRV("cp_read_dqs_delay %d\n", phy->settings.cp_read_dqs_delay);
> +	DEBUG_DRV("cp_sw_half_cycle_shift %d\n", phy->settings.cp_sw_half_cycle_shift);
> +	DEBUG_DRV("cp_sync_method %d\n", phy->settings.cp_sync_method);
> +	DEBUG_DRV("cp_use_ext_lpbk_dqs %d\n", phy->settings.cp_use_ext_lpbk_dqs);
> +	DEBUG_DRV("cp_use_lpbk_dqs %d\n", phy->settings.cp_use_lpbk_dqs);
> +	DEBUG_DRV("cp_use_phony_dqs %d\n", phy->settings.cp_use_phony_dqs);
> +	DEBUG_DRV("cp_use_phony_dqs_cmd %d\n", phy->settings.cp_use_phony_dqs_cmd);
> +	DEBUG_DRV("sdhc_extended_rd_mode %d\n", phy->settings.sdhc_extended_rd_mode);
> +	DEBUG_DRV("sdhc_extended_wr_mode %d\n", phy->settings.sdhc_extended_wr_mode);
> +
> +	DEBUG_DRV("sdhc_hcsdclkadj %d\n", phy->settings.sdhc_hcsdclkadj);
> +	DEBUG_DRV("sdhc_idelay_val %d\n", phy->settings.sdhc_idelay_val);
> +	DEBUG_DRV("sdhc_rdcmd_en %d\n", phy->settings.sdhc_rdcmd_en);
> +	DEBUG_DRV("sdhc_rddata_en %d\n", phy->settings.sdhc_rddata_en);
> +	DEBUG_DRV("sdhc_rw_compensate %d\n", phy->settings.sdhc_rw_compensate);
> +	DEBUG_DRV("sdhc_sdcfsh %d\n", phy->settings.sdhc_sdcfsh);
> +	DEBUG_DRV("sdhc_sdcfsl %d\n", phy->settings.sdhc_sdcfsl);
> +	DEBUG_DRV("sdhc_wrcmd0_dly %d %d\n",
> +		  phy->settings.sdhc_wrcmd0_dly, phy->settings.sdhc_wrcmd0_sdclk_dly);
> +	DEBUG_DRV("sdhc_wrcmd1_dly %d %d\n",
> +		  phy->settings.sdhc_wrcmd1_dly, phy->settings.sdhc_wrcmd1_sdclk_dly);
> +	DEBUG_DRV("sdhc_wrdata0_dly %d %d\n",
> +		  phy->settings.sdhc_wrdata0_dly, phy->settings.sdhc_wrdata0_sdclk_dly);
> +
> +	DEBUG_DRV("sdhc_wrdata1_dly %d %d\n",
> +		  phy->settings.sdhc_wrdata1_dly, phy->settings.sdhc_wrdata1_sdclk_dly);
> +	DEBUG_DRV("hs200_tune_val %d\n", phy->settings.hs200_tune_val);
> +}
> +
> +void sdhci_cdns_sd6_dump(struct sdhci_cdns_priv *priv)

static

> +{
> +	struct sdhci_cdns_sd6_phy *phy = priv->phy;
> +	int id;
> +
> +	sdhci_cdns_sd6_phy_dump(phy);
> +
> +	DEBUG_DRV("Host controller Register Dump\n");
> +	for (id = 0; id < 14; id++)
> +		DEBUG_DRV("HRS%d 0x%x\n", id, readl(priv->hrs_addr + (id * 4)));
> +
> +	id = 29;
> +	DEBUG_DRV("HRS%d 0x%x\n", id, readl(priv->hrs_addr + (id * 4)));
> +	id = 30;
> +	DEBUG_DRV("HRS%d 0x%x\n", id, readl(priv->hrs_addr + (id * 4)));
> +
> +	for (id = 0; id < 27; id++)
> +		DEBUG_DRV("SRS%d 0x%x\n", id, readl(priv->hrs_addr + 0x200 + (id * 4)));
> +
> +	DEBUG_DRV("SDHCI_CDNS_SD6_PHY_DQS_TIMING 0x%x\n",
> +		  sdhci_cdns_sd6_read_phy_reg(priv, SDHCI_CDNS_SD6_PHY_DQS_TIMING));
> +	DEBUG_DRV("SDHCI_CDNS_SD6_PHY_GATE_LPBK 0x%x\n",
> +		  sdhci_cdns_sd6_read_phy_reg(priv, SDHCI_CDNS_SD6_PHY_GATE_LPBK));
> +	DEBUG_DRV("SDHCI_CDNS_SD6_PHY_DLL_MASTER 0x%x\n",
> +		  sdhci_cdns_sd6_read_phy_reg(priv, SDHCI_CDNS_SD6_PHY_DLL_MASTER));
> +	DEBUG_DRV("SDHCI_CDNS_SD6_PHY_DLL_SLAVE 0x%x\n",
> +		  sdhci_cdns_sd6_read_phy_reg(priv, SDHCI_CDNS_SD6_PHY_DLL_SLAVE));
> +	DEBUG_DRV("SDHCI_CDNS_SD6_PHY_CTRL 0x%x\n",
> +		  sdhci_cdns_sd6_read_phy_reg(priv, SDHCI_CDNS_SD6_PHY_CTRL));
> +	DEBUG_DRV("SDHCI_CDNS_SD6_PHY_GPIO_CTRL0 0x%x\n",
> +		  sdhci_cdns_sd6_read_phy_reg(priv, SDHCI_CDNS_SD6_PHY_GPIO_CTRL0));
> +	DEBUG_DRV("SDHCI_CDNS_SD6_PHY_DQ_TIMING 0x%x\n",
> +		  sdhci_cdns_sd6_read_phy_reg(priv, SDHCI_CDNS_SD6_PHY_DQ_TIMING));
> +	DEBUG_DRV("SDHCI_CDNS_SD6_PHY_DLL_OBS_REG0 0x%x\n",
> +		  sdhci_cdns_sd6_read_phy_reg(priv, SDHCI_CDNS_SD6_PHY_DLL_OBS_REG0));
> +	DEBUG_DRV("SDHCI_CDNS_SD6_PHY_DLL_OBS_REG1 0x%x\n",
> +		  sdhci_cdns_sd6_read_phy_reg(priv, SDHCI_CDNS_SD6_PHY_DLL_OBS_REG1));
> +	DEBUG_DRV("SDHCI_CDNS_SD6_PHY_DLL_OBS_REG2 0x%x\n",
> +		  sdhci_cdns_sd6_read_phy_reg(priv, SDHCI_CDNS_SD6_PHY_DLL_OBS_REG2));
> +}

Make a stub for sdhci_cdns_sd6_dump() i.e.

#else

static inline void sdhci_cdns_sd6_dump(struct sdhci_cdns_priv *priv)
{
}

> +#endif
> +
>  static int sdhci_cdns_sd6_get_delay_params(struct device *dev, struct sdhci_cdns_priv *priv)
>  {
>  	struct sdhci_cdns_sd6_phy *phy = priv->phy;
> @@ -1373,6 +1469,10 @@ static void sdhci_cdns_sd6_set_clock(struct sdhci_host *host,
>  		pr_debug("%s: phy init failed\n", __func__);
>  
>  	sdhci_set_clock(host, clock);
> +
> +#ifdef CONFIG_MMC_DEBUG
> +	sdhci_cdns_sd6_dump(priv);
> +#endif

With the stub above, #ifdef CONFIG_MMC_DEBUG / #endif
is no longer needed here.

>  }
>  
>  static int sdhci_cdns_sd4_phy_probe(struct platform_device *pdev,

