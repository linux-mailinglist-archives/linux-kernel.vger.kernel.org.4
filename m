Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4BA5688916
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 22:37:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232771AbjBBVhs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 16:37:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbjBBVhq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 16:37:46 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 236387BE55
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 13:37:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BE6DAB8289F
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 21:37:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F681C433EF;
        Thu,  2 Feb 2023 21:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675373862;
        bh=4cVW0pF3Gfk6OF+q0A6GKMQlL2THp6YtVURHn69CPBU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SRsvuq55hfL03VYVA9S9YE+VfRBHLpk2CfF9wKACPRpKF3tQ+frwMMXoEaIK5hnVu
         kew2anHFrK4Xgze4s2QqKHXwWJmrCQ1bs8RTUrkY6t9uzAXabw/ckrBJDll7UILIQY
         JEBZ3tyeAf3gpduFriQoepjZ8mJ4f25+hMKG409AI04byx77gXCmBLDqRRzxrykhfM
         gTTgSyqTQjAVcdwRYqNfIkAo9ozHsyKJi5DwpSDAzVqVG2+bHzCFAjdYQYti4k1GzZ
         qPQedKQgS7z8mn9SXtiMN+xMPkUNKRfgYm+p5GrBlCQ9n/HreLcn1jTufmfu0YKFr6
         ccDmZM93qXC9Q==
Date:   Thu, 2 Feb 2023 13:37:40 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH -next] f2fs: Remove unneeded semicolon
Message-ID: <Y9wtJLVjx9jmBxzZ@google.com>
References: <20230202010111.69078-1-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230202010111.69078-1-yang.lee@linux.alibaba.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, but applied the fix in the original patch.

On 02/02, Yang Li wrote:
> ./fs/f2fs/checkpoint.c:1485:55-56: Unneeded semicolon
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=3925
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  fs/f2fs/checkpoint.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> index b1b39c17f2d8..b7ef8cd10b10 100644
> --- a/fs/f2fs/checkpoint.c
> +++ b/fs/f2fs/checkpoint.c
> @@ -1482,7 +1482,7 @@ static int do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
>  	for (i = 0; i < NR_CURSEG_DATA_TYPE; i++) {
>  		struct curseg_info *curseg = CURSEG_I(sbi, i + CURSEG_HOT_DATA);
>  
> -		ckpt->cur_data_segno[i] = cpu_to_le32(curseg->segno);;
> +		ckpt->cur_data_segno[i] = cpu_to_le32(curseg->segno);
>  		ckpt->cur_data_blkoff[i] = cpu_to_le16(curseg->next_blkoff);
>  		ckpt->alloc_type[i + CURSEG_HOT_DATA] = curseg->alloc_type;
>  	}
> -- 
> 2.20.1.7.g153144c
