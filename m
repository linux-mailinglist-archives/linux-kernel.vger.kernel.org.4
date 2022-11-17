Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D58462D3E3
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 08:16:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234570AbiKQHQK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 02:16:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233963AbiKQHQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 02:16:08 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B2816F35A;
        Wed, 16 Nov 2022 23:16:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668669366; x=1700205366;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=OZR+MyWLgP8HkrZB6F3ZwjvvPglgkpwXgGMdnYgokHc=;
  b=eHl9Ds18wekUjKrR2j+IFgYswVUB3iXAAhx6iTSBnNsave5wPW2vmh3G
   D/BoeGbRv2WGHmP7fXo4c63BCY8h3s13IEFYx6MwQkk3cJS6Dl77jAc7T
   as6SBo36j6dYXLRC9S4rA4ISf1FeBVefP41i20YdEb+SFA357LJGlKV6h
   47YYOmLjO2KHebmMilHuTCwX7cCvxbT7wIZKU2Uw9YMfPZGSG96alk2MQ
   zfubzgoJtcby2zohNeSoY8pJPbogjP1J2oOFVLUC1UNitaMo5ER7VgYip
   4H8zPktztPXmefUTHOblgxOFc+OvOLmjzn30JP8EXicqE2guopgvOlAk4
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="311483256"
X-IronPort-AV: E=Sophos;i="5.96,171,1665471600"; 
   d="scan'208";a="311483256"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2022 23:16:05 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="590511493"
X-IronPort-AV: E=Sophos;i="5.96,171,1665471600"; 
   d="scan'208";a="590511493"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.35.99])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2022 23:16:02 -0800
Message-ID: <c67001f8-8f25-2633-fc37-892d74bdf07e@intel.com>
Date:   Thu, 17 Nov 2022 09:15:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.5.0
Subject: Re: [PATCH V3 1/1] mmc: sdhci: Fix the SD tuning issue that the
 SDHCI_TRANSFER_MODE is cleared incorrectly
Content-Language: en-US
To:     Charl Liu <charl.liu@bayhubtech.com>, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     shaper.liu@bayhubtech.com, chevron.li@bayhubtech.com,
        thomas.hu@bayhubtech.com, xiaoguang.yu@bayhubtech.com,
        shirley.her@bayhubtech.com
References: <20221111122314.307-1-charl.liu@bayhubtech.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20221111122314.307-1-charl.liu@bayhubtech.com>
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

On 11/11/22 14:23, Charl Liu wrote:
> When cmd->opcode == MMC_SEND_TUNING_BLOCK, the SDHCI_TRANSFER_MODE
> should also be kept
> 
> Signed-off-by: Charl Liu <charl.liu@bayhubtech.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>


> ---
> change in V1:
> Keeping the SDHCI_TRANSFER_MODE when cmd->opcode == MMC_END_TUNING_BLOCK
> 
> change in V2:
> add the mmc_op_tuning interface to judge if the opcode is tuning CMD
> 
> change in V3:
> cancel the redundant code
> ---
>  drivers/mmc/host/sdhci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index fef03de85b99..98ee688de50d 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1465,7 +1465,7 @@ static void sdhci_set_transfer_mode(struct sdhci_host *host,
>  		if (host->quirks2 &
>  			SDHCI_QUIRK2_CLEAR_TRANSFERMODE_REG_BEFORE_CMD) {
>  			/* must not clear SDHCI_TRANSFER_MODE when tuning */
> -			if (cmd->opcode != MMC_SEND_TUNING_BLOCK_HS200)
> +			if (!mmc_op_tuning(cmd->opcode))
>  				sdhci_writew(host, 0x0, SDHCI_TRANSFER_MODE);
>  		} else {
>  		/* clear Auto CMD settings for no data CMDs */

