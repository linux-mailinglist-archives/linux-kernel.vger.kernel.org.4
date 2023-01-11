Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 292546655BA
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 09:08:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbjAKIIu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 03:08:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231332AbjAKIIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 03:08:34 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC5CBBEE;
        Wed, 11 Jan 2023 00:08:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673424512; x=1704960512;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=MBdMtDHtzHcShA2uCyuuiIPc0Vfm3GFaBBE0lvtFfmU=;
  b=NBiD2ffwv38nveE8wirgd/tgEiauSlVJ0BH5p8x7KbwW8wyTQvVK+dqE
   az3wLijaEyxxqXXp6onoVgaDojc6togoccgMcgND6GWWIYcTKD9q2//d6
   074WDsadYfN6XS55QW1w1TQ8cQhp0FWZWSORD8r2vO70puioSx03Tfe8L
   CxrnvW4ciN37sufs3CrwETj2EJ3KrgOEgIW2ordBmcPcL/FJ0otLYL20z
   QistGLriBguEmLqEeCuZzPR+GJ73EmFylqkXo5KUwMcyptfE02iq255G7
   aD90UP3h/jg/ivCHLupB+S1gQAyL7mJpciPb9fiItoNiSazbRqyNfI9AA
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="323418509"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="323418509"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2023 00:08:32 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="725833820"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="725833820"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.37.49])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2023 00:08:29 -0800
Message-ID: <4edc44f2-005e-803d-942c-171abd787252@intel.com>
Date:   Wed, 11 Jan 2023 10:08:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.1
Subject: Re: [PATCH 4/5] drivers: mmc: sdhci: Add option to configure sdhci
 timeout
Content-Language: en-US
To:     Piyush Malgujar <pmalgujar@marvell.com>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, ulf.hansson@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        yamada.masahiro@socionext.com, devicetree@vger.kernel.org
Cc:     jannadurai@marvell.com, cchavva@marvell.com
References: <20221219142418.27949-1-pmalgujar@marvell.com>
 <20221219142418.27949-5-pmalgujar@marvell.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20221219142418.27949-5-pmalgujar@marvell.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/12/22 16:24, Piyush Malgujar wrote:
> From: Jayanthi Annadurai <jannadurai@marvell.com>
> 
> Add config option to choose the sdhci timeout in seconds.

This approach is not ok, but why is the change wanted?

> 
> Signed-off-by: Jayanthi Annadurai <jannadurai@marvell.com>
> Signed-off-by: Piyush Malgujar <pmalgujar@marvell.com>
> ---
>  drivers/mmc/host/Kconfig | 8 ++++++++
>  drivers/mmc/host/sdhci.c | 3 ++-
>  2 files changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index b5b2ae0bb4625bdb9d17acdbb1887c9caa3a1f32..ab48f2bc4cff73d1aad8d7da542d761cf0346d9f 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -1132,3 +1132,11 @@ config MMC_LITEX
>  	  module will be called litex_mmc.
>  
>  	  If unsure, say N.
> +
> +config MMC_SDHCI_TIMEOUT
> +	int
> +	default 1 if MMC_SDHCI_CADENCE
> +	default 10
> +	depends on MMC_SDHCI
> +	help
> +	  Default timeout value for command and data.
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index f3af1bd0f7b955272fbd8b034ecb591860b89aed..e9bc24258746834ec9c8f13fe24456587a2b758d 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1707,7 +1707,8 @@ static bool sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
>  	else if (!cmd->data && cmd->busy_timeout > 9000)
>  		timeout += DIV_ROUND_UP(cmd->busy_timeout, 1000) * HZ + HZ;
>  	else
> -		timeout += 10 * HZ;
> +		timeout += CONFIG_MMC_SDHCI_TIMEOUT * HZ;
> +
>  	sdhci_mod_timer(host, cmd->mrq, timeout);
>  
>  	if (host->use_external_dma)

