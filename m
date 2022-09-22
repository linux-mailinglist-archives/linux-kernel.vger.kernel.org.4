Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14F0E5E6178
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 13:42:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231642AbiIVLmt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 07:42:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231544AbiIVLmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 07:42:40 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58ADE9B85E;
        Thu, 22 Sep 2022 04:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663846951; x=1695382951;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=V13C94xekIQZ8YQVuEe807wmoeTFJXbUhciBFGunQ78=;
  b=OOjezHmT45MbcXUtDzuS5VwO8tCL6YrPdlS2CzOUsTKzAvDAW46GfCFv
   PhJYikeqiNNHXKyW31OlFCfzDkT9NSgRawE40qZ9VGqzq8NpyzecIc5g1
   ey4PXgpmdp8h7jKEEpUknrCE6NERXND2kIOWdF8Q2t1Ax4AOQHXIfJU4w
   cdmEnxu+giSxF0Yst0msXUrha707ovylqjoCBvAFDRMKXGNBtkkD7CxL4
   swOBflx0Yf9WJ29l3pmO1quox0MmHirafLke3AkTjPF/KvhmvI+nCWRuZ
   3LBVH5npLwmJICu4lBLryl33mDf0SZLbww/qR4eC4+dGC5DImZizZumVU
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10477"; a="301120150"
X-IronPort-AV: E=Sophos;i="5.93,335,1654585200"; 
   d="scan'208";a="301120150"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 04:42:30 -0700
X-IronPort-AV: E=Sophos;i="5.93,335,1654585200"; 
   d="scan'208";a="652935976"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.59.41])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 04:42:27 -0700
Message-ID: <abac9b14-ca2f-210e-5a09-3c4f56846a9b@intel.com>
Date:   Thu, 22 Sep 2022 14:42:23 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v3 1/4] mmc: sdhci-tegra: Separate Tegra194 and Tegra234
 SoC data
Content-Language: en-US
To:     Prathamesh Shete <pshete@nvidia.com>, ulf.hansson@linaro.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        p.zabel@pengutronix.de, linux-mmc@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     anrao@nvidia.com, smangipudi@nvidia.com, kyarlagadda@nvidia.com
References: <20220920123752.21027-1-pshete@nvidia.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20220920123752.21027-1-pshete@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/09/22 15:37, Prathamesh Shete wrote:
> Create new SoC data structure for Tegra234 platforms.
> Additional features, tap value configurations are added/
> updated for Tegra234 platform hence separate Tegra194 and
> Tegra234 SoC data.
> 
> Signed-off-by: Aniruddha Tvs Rao <anrao@nvidia.com>
> Signed-off-by: Prathamesh Shete <pshete@nvidia.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-tegra.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
> index 2d2d8260c681..a6c5bbae77b4 100644
> --- a/drivers/mmc/host/sdhci-tegra.c
> +++ b/drivers/mmc/host/sdhci-tegra.c
> @@ -1556,7 +1556,21 @@ static const struct sdhci_tegra_soc_data soc_data_tegra194 = {
>  	.max_tap_delay = 139,
>  };
>  
> +static const struct sdhci_tegra_soc_data soc_data_tegra234 = {
> +	.pdata = &sdhci_tegra186_pdata,
> +	.dma_mask = DMA_BIT_MASK(39),
> +	.nvquirks = NVQUIRK_NEEDS_PAD_CONTROL |
> +		    NVQUIRK_HAS_PADCALIB |
> +		    NVQUIRK_DIS_CARD_CLK_CONFIG_TAP |
> +		    NVQUIRK_ENABLE_SDR50 |
> +		    NVQUIRK_ENABLE_SDR104 |
> +		    NVQUIRK_HAS_TMCLK,
> +	.min_tap_delay = 95,
> +	.max_tap_delay = 111,
> +};
> +
>  static const struct of_device_id sdhci_tegra_dt_match[] = {
> +	{ .compatible = "nvidia,tegra234-sdhci", .data = &soc_data_tegra234 },
>  	{ .compatible = "nvidia,tegra194-sdhci", .data = &soc_data_tegra194 },
>  	{ .compatible = "nvidia,tegra186-sdhci", .data = &soc_data_tegra186 },
>  	{ .compatible = "nvidia,tegra210-sdhci", .data = &soc_data_tegra210 },

