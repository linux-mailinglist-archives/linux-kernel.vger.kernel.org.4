Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7E20708629
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 18:43:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbjERQnj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 12:43:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjERQnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 12:43:37 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC9EBD1;
        Thu, 18 May 2023 09:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684428216; x=1715964216;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=kegxpnfkaQJ/nP+d2s5eNw9UacalFzi2yPWpbyh024o=;
  b=VFIAplx81+Z0mvwYVj++SJeMecb5Libgq8EnKe8MI2DL6+6qcDCmr91h
   4mJj3mZIQmLFRMwRYOLKna4/Utz3uZgiThkFlnAkyFf5Bd1OEQDJshvLo
   cHnwhhhYfH2jC+hBW5+/yntuWobAHhmGOkysxxoKJt5BBINqd8/B5xw49
   kMT9bN5T64UrjJWzy8SibbZKP21cvI1bnZwG7K2r5zhqOGk58GvshU7Sn
   5I3F/Zyldgc3xJnhxZQMckSQJiEn163ZmG4Y44qcS1CxhvflYf3NBbmip
   zhdrsUl4AiepswNqLJ79K7GBPrWoFbTg4mGxyBd8RT6R72PfWOkc5AQol
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="415572079"
X-IronPort-AV: E=Sophos;i="6.00,285,1681196400"; 
   d="scan'208";a="415572079"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2023 09:43:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="767276995"
X-IronPort-AV: E=Sophos;i="6.00,285,1681196400"; 
   d="scan'208";a="767276995"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.251.221.202])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2023 09:43:31 -0700
Message-ID: <e471c66e-83ca-d568-0ac1-42f1576ced6f@intel.com>
Date:   Thu, 18 May 2023 19:43:28 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [PATCH] mmc: core: Remove unnecessary error checks and change
 return type
To:     Yeqi Fu <asuk4.q@gmail.com>, ulf.hansson@linaro.org,
        CLoehle@hyperstone.com, avri.altman@wdc.com, axboe@kernel.dk
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <36e805fa-338d-a945-2621-75c5077572fc@intel.com>
 <20230518101216.369970-1-asuk4.q@gmail.com>
Content-Language: en-US
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20230518101216.369970-1-asuk4.q@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/05/23 13:12, Yeqi Fu wrote:
> The error checks in mmc_blk_add_debugfs() and mmc_blk_remove_debugfs()
> are extraneous. Therefore, this patch removes all error checks from
> both functions.
> Additionally, mmc_blk_add_debugfs() has been changed to return void
> instead of an integer value that was never used. This simplifies the
> function and improves its clarity.
> 
> Signed-off-by: Yeqi Fu <asuk4.q@gmail.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/core/block.c | 25 +++++++------------------
>  1 file changed, 7 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index 00c33edb9fb9..81f33200b893 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -2894,12 +2894,12 @@ static const struct file_operations mmc_dbg_ext_csd_fops = {
>  	.llseek		= default_llseek,
>  };
>  
> -static int mmc_blk_add_debugfs(struct mmc_card *card, struct mmc_blk_data *md)
> +static void mmc_blk_add_debugfs(struct mmc_card *card, struct mmc_blk_data *md)
>  {
>  	struct dentry *root;
>  
>  	if (!card->debugfs_root)
> -		return 0;
> +		return;
>  
>  	root = card->debugfs_root;
>  
> @@ -2908,19 +2908,13 @@ static int mmc_blk_add_debugfs(struct mmc_card *card, struct mmc_blk_data *md)
>  			debugfs_create_file_unsafe("status", 0400, root,
>  						   card,
>  						   &mmc_dbg_card_status_fops);
> -		if (!md->status_dentry)
> -			return -EIO;
>  	}
>  
>  	if (mmc_card_mmc(card)) {
>  		md->ext_csd_dentry =
>  			debugfs_create_file("ext_csd", S_IRUSR, root, card,
>  					    &mmc_dbg_ext_csd_fops);
> -		if (!md->ext_csd_dentry)
> -			return -EIO;
>  	}
> -
> -	return 0;
>  }
>  
>  static void mmc_blk_remove_debugfs(struct mmc_card *card,
> @@ -2929,22 +2923,17 @@ static void mmc_blk_remove_debugfs(struct mmc_card *card,
>  	if (!card->debugfs_root)
>  		return;
>  
> -	if (!IS_ERR_OR_NULL(md->status_dentry)) {
> -		debugfs_remove(md->status_dentry);
> -		md->status_dentry = NULL;
> -	}
> +	debugfs_remove(md->status_dentry);
> +	md->status_dentry = NULL;
>  
> -	if (!IS_ERR_OR_NULL(md->ext_csd_dentry)) {
> -		debugfs_remove(md->ext_csd_dentry);
> -		md->ext_csd_dentry = NULL;
> -	}
> +	debugfs_remove(md->ext_csd_dentry);
> +	md->ext_csd_dentry = NULL;
>  }
>  
>  #else
>  
> -static int mmc_blk_add_debugfs(struct mmc_card *card, struct mmc_blk_data *md)
> +static void mmc_blk_add_debugfs(struct mmc_card *card, struct mmc_blk_data *md)
>  {
> -	return 0;
>  }
>  
>  static void mmc_blk_remove_debugfs(struct mmc_card *card,

