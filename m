Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A82C635ADF
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 12:01:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236729AbiKWLAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 06:00:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237222AbiKWLAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 06:00:15 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E04CF11607F;
        Wed, 23 Nov 2022 02:54:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669200854; x=1700736854;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=uDAVTOEt2Yr6bF41uMtBqnDhdX/0XRjYoiQGkjerU4M=;
  b=NqejR+09hj2TkjfMWSATRu5PeeT6u3fkhufE2wPyveDJevYx85/g4LPM
   1cflyVs1S1hEwk/Cx+2znChj2+uvZAO03gJA7E5qdp2m+P4k1RdOeTyQC
   AnJo/a5PoJKbeXU1Yk38oUJ6QKvMLSBbQImyXUeciqQDHMA/bu9/WwmcR
   RXJ7+GSfOqR3aPpntKMbRjk2aD3VWBg3l4x6tF2l8FvXIH+5qfQa0fovG
   Kmp5gxHEFIun8b7ylHCZltxNkDIfOZt6xF89zx34wYfIKpQpGhsRn3B7B
   9K8bx/XwvavPdVtcTclJbn33AxzkUG26KjbDssgkbs24XDLOMj4p6krSB
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="400332857"
X-IronPort-AV: E=Sophos;i="5.96,187,1665471600"; 
   d="scan'208";a="400332857"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2022 02:54:14 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="710549067"
X-IronPort-AV: E=Sophos;i="5.96,187,1665471600"; 
   d="scan'208";a="710549067"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.48.46])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2022 02:54:12 -0800
Message-ID: <5bf820c6-8b07-cf0c-438b-a411815c202c@intel.com>
Date:   Wed, 23 Nov 2022 12:54:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.5.0
Subject: Re: [PATCH] mmc: mmc_test: fix missing assignment of 'file' when
 register debugfs file
To:     Ye Bin <yebin@huaweicloud.com>, ulf.hansson@linaro.org,
        wsa+renesas@sang-engineering.com, kvalo@kernel.org,
        linux-mmc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, yebin10@huawei.com
References: <20221123095506.1965691-1-yebin@huaweicloud.com>
Content-Language: en-US
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20221123095506.1965691-1-yebin@huaweicloud.com>
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

On 23/11/22 11:55, Ye Bin wrote:
> From: Ye Bin <yebin10@huawei.com>
> 
> Now, 'file' is always NULL. obviously, 'file' is used to store return value of
> 'debugfs_create_file()'.

'file' is used to remove debugfs files when the mmc_test module is removed.

> 
> Fixes: a04c50aaa916 ("mmc: core: no need to check return value of debugfs_create functions")
> Signed-off-by: Ye Bin <yebin10@huawei.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/core/mmc_test.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/core/mmc_test.c b/drivers/mmc/core/mmc_test.c
> index 6cd6f8a94a71..156d34b2ed4d 100644
> --- a/drivers/mmc/core/mmc_test.c
> +++ b/drivers/mmc/core/mmc_test.c
> @@ -3174,7 +3174,8 @@ static int __mmc_test_register_dbgfs_file(struct mmc_card *card,
>  	struct mmc_test_dbgfs_file *df;
>  
>  	if (card->debugfs_root)
> -		debugfs_create_file(name, mode, card->debugfs_root, card, fops);
> +		file = debugfs_create_file(name, mode, card->debugfs_root,
> +					   card, fops);
>  
>  	df = kmalloc(sizeof(*df), GFP_KERNEL);
>  	if (!df) {

