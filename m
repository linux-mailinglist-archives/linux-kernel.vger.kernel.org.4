Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2540461347C
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 12:28:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbiJaL2A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 07:28:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiJaL1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 07:27:55 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FC751E4
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 04:27:53 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id 192so10416129pfx.5
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 04:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TKPI5yRxVTKFtgumlu/CUnO4v6ROaa6qGM+N7FESgvY=;
        b=LT39UhB5T9y5tPam8V/nJCDvqs/c5nXKUv0RbG04WnsSKOsRpmnua6u8vyEs1AJ2DE
         9j9bssNQQRQKwAeydagctfVjiHGtK8naWVz/3f9x7aQdKc/09i+R7py/lvY2DsfbmIwC
         gCD8fxgVyp/nhEtgQhAV2i8U51eKV2lCXjKsjIHlSnOkfnr/GEZdgY5GfieQgkSoev3Z
         KZDfF1ApFms1kJluJqqdMZMuZZCyqCmGmFMJfVamZJFcqNz3k5YtbTBlOHwwUiBkcxZw
         XJYrLBLbD4a987FY3CHDW1rhKkq75VHra7UFvv+vSmDRkgfXrsCrfQjXv57EJgMballd
         VPow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TKPI5yRxVTKFtgumlu/CUnO4v6ROaa6qGM+N7FESgvY=;
        b=YxItkDNKudcOHToGGC4aR2iVqkIfgy2qMXeBWnFRwkWoa4hSZRX0gfFbXraE0jHgZ9
         +KM4J7vOoCwrmLbY/4nqZ9HZpN6tEa0lR5enMxDiCiH7M/a4HUlr1xd8ZElBbj2qfz9y
         qx1VXOu7038tGq7UHzhvplZimTZ64n1bnktG1B7gML78ATKvLKOiR2oIz6CZ055uJIxd
         F/Rkr/+S9s7CXBb65y5y6I6WmARyIgJ+Ia7ku9eKKhpjewmo9smWqS2rVavf0Mzi8mnJ
         Fv1lSop+0bU68SyN+LimG7PyQJinh3uCvNDR3rw3iWCch/QXZ0vcak7qvsaFtTb2zvga
         cxug==
X-Gm-Message-State: ACrzQf0o1Cn/hlzvXp6cgCyKdmgKL/5nitAsFLJZIWC5TI3MxVfNMUAl
        VJTQXrjnRsum4yXwB93DiUs=
X-Google-Smtp-Source: AMsMyM4YLfIkdzMz+5bQQP5GgFUPAyaEGJK/wwQds5AmW2XQcMtAh1zCSaNxV/nyY6zka22bFq7/vA==
X-Received: by 2002:a63:e158:0:b0:464:8d6:8b91 with SMTP id h24-20020a63e158000000b0046408d68b91mr11898674pgk.124.1667215673550;
        Mon, 31 Oct 2022 04:27:53 -0700 (PDT)
Received: from mi-HP-ProDesk-680-G4-MT ([43.224.245.252])
        by smtp.gmail.com with ESMTPSA id m10-20020a17090a3f8a00b002008d0e5cb5sm3946564pjc.47.2022.10.31.04.27.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 31 Oct 2022 04:27:52 -0700 (PDT)
Date:   Mon, 31 Oct 2022 19:27:47 +0800
From:   qixiaoyu <qxy65535@gmail.com>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        qixiaoyu1 <qixiaoyu1@xiaomi.com>
Subject: Re: [PATCH] f2fs: separate IPU policy for fdatasync from
 F2FS_IPU_FSYNC
Message-ID: <20221031112747.GA22857@mi-HP-ProDesk-680-G4-MT>
References: <20221021023136.22863-1-qixiaoyu1@xiaomi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221021023136.22863-1-qixiaoyu1@xiaomi.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Friendly ping...

On Fri, Oct 21, 2022 at 10:31:36AM +0800, qixiaoyu1 wrote:
> Currently IPU policy for fdatasync is coupled with F2FS_IPU_FSYNC.
> Fix to apply it to all IPU policy.
> 
> Signed-off-by: qixiaoyu1 <qixiaoyu1@xiaomi.com>
> ---
>  fs/f2fs/data.c | 8 +++-----
>  fs/f2fs/file.c | 4 +++-
>  2 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index a71e818cd67b..fec8e15fe820 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -2518,6 +2518,9 @@ static inline bool check_inplace_update_policy(struct inode *inode,
>  	if (policy & (0x1 << F2FS_IPU_HONOR_OPU_WRITE) &&
>  			is_inode_flag_set(inode, FI_OPU_WRITE))
>  		return false;
> +	/* this is set by fdatasync or F2FS_IPU_FSYNC policy */
> +	if (is_inode_flag_set(inode, FI_NEED_IPU))
> +		return true;
>  	if (policy & (0x1 << F2FS_IPU_FORCE))
>  		return true;
>  	if (policy & (0x1 << F2FS_IPU_SSR) && f2fs_need_SSR(sbi))
> @@ -2538,11 +2541,6 @@ static inline bool check_inplace_update_policy(struct inode *inode,
>  			!IS_ENCRYPTED(inode))
>  		return true;
>  
> -	/* this is only set during fdatasync */
> -	if (policy & (0x1 << F2FS_IPU_FSYNC) &&
> -			is_inode_flag_set(inode, FI_NEED_IPU))
> -		return true;
> -
>  	if (unlikely(fio && is_sbi_flag_set(sbi, SBI_CP_DISABLED) &&
>  			!f2fs_is_checkpointed_data(sbi, fio->old_blkaddr)))
>  		return true;
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 82cda1258227..08091550cdf2 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -270,8 +270,10 @@ static int f2fs_do_sync_file(struct file *file, loff_t start, loff_t end,
>  		goto go_write;
>  
>  	/* if fdatasync is triggered, let's do in-place-update */
> -	if (datasync || get_dirty_pages(inode) <= SM_I(sbi)->min_fsync_blocks)
> +	if (datasync || (SM_I(sbi)->ipu_policy & (0x1 << F2FS_IPU_FSYNC) &&
> +			get_dirty_pages(inode) <= SM_I(sbi)->min_fsync_blocks))
>  		set_inode_flag(inode, FI_NEED_IPU);
> +
>  	ret = file_write_and_wait_range(file, start, end);
>  	clear_inode_flag(inode, FI_NEED_IPU);
>  
> -- 
> 2.36.1
> 
