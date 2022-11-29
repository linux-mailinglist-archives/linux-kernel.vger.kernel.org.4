Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C883763BB35
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 09:05:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbiK2IFA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 03:05:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbiK2IE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 03:04:58 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF49A3056C;
        Tue, 29 Nov 2022 00:04:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669709097; x=1701245097;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=F5ck3m2Z6Ymc6e3F8aWHj8A97GRThgnLiem/CNiq1iU=;
  b=d+zLyDixQUQpi93Th72E1iw7WsJuAQ3nF0Mq2cTgr3Epw8OD+AWez9/w
   apM+/YK+I4wJST40dogHMmAjqoFwiqWlZOeignrLAbdpTL//gIrB09k89
   K/lHTADtZOFfaYW87XZDCd44OBS/4fILUk8fzBwsnifiZWV1hHXx1aE9A
   F0Q0ABCdY+NMkZ8U21+VVIyBV48iihN3bN0zjkhTrudbv3dr/INyE7W6w
   In1+EKCB2fL3IChZwQp3/INMPbTzprmns8Uw/8kxbjpEwqqzfIa3F5s/9
   uGsmQUMMC9SdrUxynU3+x7rLqteYGj23bb9U9/RgB/SSDR8hRgHQVTjnN
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="302638485"
X-IronPort-AV: E=Sophos;i="5.96,202,1665471600"; 
   d="scan'208";a="302638485"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2022 00:04:57 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="749735586"
X-IronPort-AV: E=Sophos;i="5.96,202,1665471600"; 
   d="scan'208";a="749735586"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.34.177])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2022 00:04:55 -0800
Message-ID: <52030ce1-5781-cd62-e0bc-b70a011a024b@intel.com>
Date:   Tue, 29 Nov 2022 10:04:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.5.0
Subject: Re: [PATCH] mmc: sdhci-of-esdhc: limit the SDHC clock frequency
Content-Language: en-US
To:     andy.tang@nxp.com, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221124064608.42019-1-andy.tang@nxp.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20221124064608.42019-1-andy.tang@nxp.com>
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

On 24/11/22 08:46, andy.tang@nxp.com wrote:
> From: Yuantian Tang <andy.tang@nxp.com>
> 
> The highest clock frequency for eMMC HS200 mode on ls1043a
> is 116.7Mhz according to its specification.
> So add the limit to gate the frequency.
> 
> Signed-off-by: Andy Tang <andy.tang@nxp.com>

It is probably nicer to use a consistent email name.  checkpatch gives this warning:

WARNING: From:/Signed-off-by: email name mismatch: 'From: Yuantian Tang <andy.tang@nxp.com>' != 'Signed-off-by: Andy Tang <andy.tang@nxp.com>'

> ---
>  drivers/mmc/host/sdhci-of-esdhc.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
> index 00542dd74c07..1fd4ae10862d 100644
> --- a/drivers/mmc/host/sdhci-of-esdhc.c
> +++ b/drivers/mmc/host/sdhci-of-esdhc.c
> @@ -43,6 +43,12 @@ static const struct esdhc_clk_fixup ls1021a_esdhc_clk = {
>  	.max_clk[MMC_TIMING_SD_HS] = 46500000,
>  };
>  
> +static const struct esdhc_clk_fixup ls1043a_esdhc_clk = {
> +	.sd_dflt_max_clk = 25000000,
> +	.max_clk[MMC_TIMING_UHS_SDR104] = 116700000,
> +	.max_clk[MMC_TIMING_MMC_HS200] = 116700000,
> +};

ls1043a_esdhc_clk seems the same as ls1046a_esdhc_clk
Should they be shared? e.g. called ls104xx_esdhc_clk

> +
>  static const struct esdhc_clk_fixup ls1046a_esdhc_clk = {
>  	.sd_dflt_max_clk = 25000000,
>  	.max_clk[MMC_TIMING_UHS_SDR104] = 167000000,
> @@ -64,6 +70,7 @@ static const struct esdhc_clk_fixup p1010_esdhc_clk = {
>  
>  static const struct of_device_id sdhci_esdhc_of_match[] = {
>  	{ .compatible = "fsl,ls1021a-esdhc", .data = &ls1021a_esdhc_clk},
> +	{ .compatible = "fsl,ls1043a-esdhc", .data = &ls1043a_esdhc_clk},
>  	{ .compatible = "fsl,ls1046a-esdhc", .data = &ls1046a_esdhc_clk},
>  	{ .compatible = "fsl,ls1012a-esdhc", .data = &ls1012a_esdhc_clk},
>  	{ .compatible = "fsl,p1010-esdhc",   .data = &p1010_esdhc_clk},

