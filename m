Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B919262DE0A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 15:26:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239935AbiKQO0n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 09:26:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240401AbiKQO0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 09:26:35 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 933D8DF57;
        Thu, 17 Nov 2022 06:26:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668695194; x=1700231194;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=5zDt62jKaPmUxNOHlqS/4inY9i4lNmmKkepcagEkf6g=;
  b=fGo0UaYmc27rsmN5AAbJTYx6DQwt3QZdRsgMOAd7t/EpAFLm+8zHEW1j
   ikBZ+qO238MMqhNMIEJIoIepsQ1aasQCpv+4KLL6kWyBtp8s1dqMv0Q8c
   c6HS6kKObD8z+Cz7bPuTL3RE/zK9u9AjGqJP5Sjd5VfCpoH+jMsMjY/+1
   f3NwWGmeOlktYOcgV8N0bFula87Yj45Mhsia8iGGckSnmVrGMP2xZug6X
   3T8mRWrYjXZzniBvQ5scmRGbwSfbaqivYngx0SVKCjneqqyr9OltyhQyy
   DtdIgICDrN2N7kIHyLSevepdqmYGvq2NYE8/xpg3MVY4ZasPv7IQ0a8yo
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="314010475"
X-IronPort-AV: E=Sophos;i="5.96,171,1665471600"; 
   d="scan'208";a="314010475"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2022 06:26:34 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="703350915"
X-IronPort-AV: E=Sophos;i="5.96,171,1665471600"; 
   d="scan'208";a="703350915"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.35.99])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2022 06:26:32 -0800
Message-ID: <ce741337-4d28-b008-b645-b3cdede09557@intel.com>
Date:   Thu, 17 Nov 2022 16:26:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.5.0
Subject: Re: [PATCH] mmc: core: Fix ambiguous TRIM and DISCARD arg
Content-Language: en-US
To:     =?UTF-8?Q?Christian_L=c3=b6hle?= <CLoehle@hyperstone.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <6373cfb97ef24ccfb5236c721f263f1b@hyperstone.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <6373cfb97ef24ccfb5236c721f263f1b@hyperstone.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/11/22 12:51, Christian Löhle wrote:
> Clean up the MMC_TRIM_ARGS define that became ambiguous with
> DISCARD introduction.
> While at it fix one usage where MMC_TRIM_ARGS falsely included
> DISCARD, too.
> 
> Fixes: b3bf915308ca ("mmc: core: new discard feature support at eMMC v4.5")
> 

A blank line is unusual here

> Signed-off-by: Christian Loehle <cloehle@hyperstone.com>

One nitpick below otherwise:

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
> Previously submitted as mmc: core: Do not require secure trim for discard
>  drivers/mmc/core/core.c | 10 ++++++++--
>  include/linux/mmc/mmc.h |  2 +-
>  2 files changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 95fa8fb1d45f..7ce26dbd5879 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -1478,6 +1478,11 @@ void mmc_init_erase(struct mmc_card *card)
>  		card->pref_erase = 0;
>  }
>  
> +static bool is_trim_arg(unsigned int arg)
> +{
> +	return (arg & MMC_TRIM_OR_DISCARD_ARGS) && arg != MMC_DISCARD_ARG;
> +}
> +
>  static unsigned int mmc_mmc_erase_timeout(struct mmc_card *card,
>  				          unsigned int arg, unsigned int qty)
>  {
> @@ -1760,7 +1765,7 @@ int mmc_erase(struct mmc_card *card, unsigned int from, unsigned int nr,
>  	    !(card->ext_csd.sec_feature_support & EXT_CSD_SEC_ER_EN))
>  		return -EOPNOTSUPP;
>  
> -	if (mmc_card_mmc(card) && (arg & MMC_TRIM_ARGS) &&
> +	if (mmc_card_mmc(card) && is_trim_arg(arg) &&
>  	    !(card->ext_csd.sec_feature_support & EXT_CSD_SEC_GB_CL_EN))
>  		return -EOPNOTSUPP;
>  
> @@ -1790,7 +1795,8 @@ int mmc_erase(struct mmc_card *card, unsigned int from, unsigned int nr,
>  	 * identified by the card->eg_boundary flag.
>  	 */
>  	rem = card->erase_size - (from % card->erase_size);
> -	if ((arg & MMC_TRIM_ARGS) && (card->eg_boundary) && (nr > rem)) {
> +	if ((arg & MMC_TRIM_OR_DISCARD_ARGS) && (card->eg_boundary) &&
> +	    (nr > rem)) {

Parenthesis are not needed around "card->eg_boundary)" nor "nr > rem"
If you take them out, then the line doesn't need wrapping either.

>  		err = mmc_do_erase(card, from, from + rem - 1, arg);
>  		from += rem;
>  		if ((err) || (to <= from))
> diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
> index 9c50bc40f8ff..6f7993803ee7 100644
> --- a/include/linux/mmc/mmc.h
> +++ b/include/linux/mmc/mmc.h
> @@ -451,7 +451,7 @@ static inline bool mmc_ready_for_data(u32 status)
>  #define MMC_SECURE_TRIM1_ARG		0x80000001
>  #define MMC_SECURE_TRIM2_ARG		0x80008000
>  #define MMC_SECURE_ARGS			0x80000000
> -#define MMC_TRIM_ARGS			0x00008001
> +#define MMC_TRIM_OR_DISCARD_ARGS	0x00008003
>  
>  #define mmc_driver_type_mask(n)		(1 << (n))
>  

