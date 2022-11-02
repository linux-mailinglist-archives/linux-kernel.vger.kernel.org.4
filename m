Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4FD76162A7
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 13:25:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbiKBMZ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 08:25:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiKBMZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 08:25:24 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1601424945
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 05:25:24 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id 130so16268158pfu.8
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 05:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=58xx+sO8s1GI8UUL6eW+tUVtsY0dtFpd6rNJ4ZqiKsk=;
        b=R3u5jPUEbUOekWvq1vSz7ZHwVB36Qo9KCC8ixptsUYlqsi73HdjZtpBcQ23zXe2ZcD
         UgDGlPbm4x2p37sPIe+4JMDKgp1rt1QKp2J1dlQMaQ24zM7sWmLPNmnQdaIYO0B65ug6
         gTYWJEIYof555SGpkQZybMhLIMglpY7K+TACduyqaD7Q/Lama0DQbahobHN0EzyUyBxd
         AoL/0BrWfclbbmmOrcPN8BpLVd4wdUcZn9a9yKPTrp2RPwarNqv1oMdWuOtjv1bMmmGS
         6BNwmLloqDMPljtLr4YSaw3bVeD/xK9qYEAt1WVCyeZ68ZX40AGgjofb7/TM79u2fgnk
         6JnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=58xx+sO8s1GI8UUL6eW+tUVtsY0dtFpd6rNJ4ZqiKsk=;
        b=mjss1wFwNSHXM8MdCYasTBBw74V65H31CdACKvK/NgsXstZAvpIGCorghMgONr/omt
         M7ZY9fa0Mt+KQbs1ccMGgVFWU+D3zdVJ9RTgPjOq9pa3eK7YH8ZdRuj9h+lBE30fxBIJ
         41YyvNJ7cKc3CuD+zp8FbV0u1x8CaqVLkRhxTI8dJomA4hWbEdJJwGZqsT9mQ+DpPkCc
         BxUQAeryUFwKeKh98X6DN5X8pDTduTrkhbigizm9Q6iKK1a4ChGLdaXhi5qRJM5v6iB8
         6uhLUEG3OhoUGYITvZeeIQvUcx+1znNNZpOisXqs5D5UMXaghVTOioJanAcxnzsWDSgm
         Sy6g==
X-Gm-Message-State: ACrzQf2S06YEeaQuisIjweKQhWrAhAJvLeo1SJ7o9SJ5hHjQw4xLRkSl
        S34NItH3D3Sxh+JWnCOF0NK6DLbDn09dWA==
X-Google-Smtp-Source: AMsMyM6kamT90lEHu9yVNtu8a+fbcxQNr1HuzllJxFJlLy4f4XU94L/OYmF/OOA5+/jSK1N8KGuwIA==
X-Received: by 2002:a63:ed58:0:b0:439:b3a:4f01 with SMTP id m24-20020a63ed58000000b004390b3a4f01mr21467335pgk.327.1667391923529;
        Wed, 02 Nov 2022 05:25:23 -0700 (PDT)
Received: from mi-HP-ProDesk-680-G4-MT ([43.224.245.252])
        by smtp.gmail.com with ESMTPSA id j19-20020a17090ae61300b00212e5068e17sm1328821pjy.40.2022.11.02.05.25.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Nov 2022 05:25:22 -0700 (PDT)
Date:   Wed, 2 Nov 2022 20:25:18 +0800
From:   qixiaoyu <qxy65535@gmail.com>
To:     Chao Yu <chao@kernel.org>
Cc:     qixiaoyu1 <qixiaoyu1@xiaomi.com>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH] f2fs: separate IPU policy for fdatasync from
 F2FS_IPU_FSYNC
Message-ID: <20221102122518.GB22857@mi-HP-ProDesk-680-G4-MT>
References: <20221021023136.22863-1-qixiaoyu1@xiaomi.com>
 <af41e68c-4f78-0934-1041-974e44bd3825@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af41e68c-4f78-0934-1041-974e44bd3825@kernel.org>
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

Hi Chao,

fdatasync do in-place-update to avoid additional node writes, but currently
it only do that with F2FS_IPU_FSYNC as:

f2fs_do_sync_file:
	if (datasync || get_dirty_pages(inode) <= SM_I(sbi)->min_fsync_blocks)
 		set_inode_flag(inode, FI_NEED_IPU);

check_inplace_update_policy:
	/* this is only set during fdatasync */
	if (policy & (0x1 << F2FS_IPU_FSYNC) &&
			is_inode_flag_set(inode, FI_NEED_IPU))
		return true;

So this patch separate in-place-update of fdatasync from F2FS_IPU_FSYNC to
apply it to all IPU policy.

BTW, we found small performance improvement with this patch on AndroBench app
using F2FS_IPU_SSR_UTIL on our product:

                F2FS_IPU_FSYNC  F2FS_IPU_SSR_UTIL   F2FS_IPU_SSR_UTIL(with patch)
SQLite Insert(QPS)  6818.08     6327.09(-7.20%)     6757.72
SQLite Update(QPS)  6528.81     6336.57(-2.94%)     6490.77
SQLite Delete(QPS)  9724.68     9378.37(-3.56%)     9622.27

Thanks

On Tue, Nov 01, 2022 at 11:14:55PM +0800, Chao Yu wrote:
> On 2022/10/21 10:31, qixiaoyu1 wrote:
> >Currently IPU policy for fdatasync is coupled with F2FS_IPU_FSYNC.
> >Fix to apply it to all IPU policy.
> 
> Xiaoyu,
> 
> Sorry for the delay.
> 
> I didn't get the point, can you please explain more about the
> issue?
> 
> Thanks,
> 
> >
> >Signed-off-by: qixiaoyu1 <qixiaoyu1@xiaomi.com>
> >---
> >  fs/f2fs/data.c | 8 +++-----
> >  fs/f2fs/file.c | 4 +++-
> >  2 files changed, 6 insertions(+), 6 deletions(-)
> >
> >diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> >index a71e818cd67b..fec8e15fe820 100644
> >--- a/fs/f2fs/data.c
> >+++ b/fs/f2fs/data.c
> >@@ -2518,6 +2518,9 @@ static inline bool check_inplace_update_policy(struct inode *inode,
> >  	if (policy & (0x1 << F2FS_IPU_HONOR_OPU_WRITE) &&
> >  			is_inode_flag_set(inode, FI_OPU_WRITE))
> >  		return false;
> >+	/* this is set by fdatasync or F2FS_IPU_FSYNC policy */
> >+	if (is_inode_flag_set(inode, FI_NEED_IPU))
> >+		return true;
> >  	if (policy & (0x1 << F2FS_IPU_FORCE))
> >  		return true;
> >  	if (policy & (0x1 << F2FS_IPU_SSR) && f2fs_need_SSR(sbi))
> >@@ -2538,11 +2541,6 @@ static inline bool check_inplace_update_policy(struct inode *inode,
> >  			!IS_ENCRYPTED(inode))
> >  		return true;
> >-	/* this is only set during fdatasync */
> >-	if (policy & (0x1 << F2FS_IPU_FSYNC) &&
> >-			is_inode_flag_set(inode, FI_NEED_IPU))
> >-		return true;
> >-
> >  	if (unlikely(fio && is_sbi_flag_set(sbi, SBI_CP_DISABLED) &&
> >  			!f2fs_is_checkpointed_data(sbi, fio->old_blkaddr)))
> >  		return true;
> >diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> >index 82cda1258227..08091550cdf2 100644
> >--- a/fs/f2fs/file.c
> >+++ b/fs/f2fs/file.c
> >@@ -270,8 +270,10 @@ static int f2fs_do_sync_file(struct file *file, loff_t start, loff_t end,
> >  		goto go_write;
> >  	/* if fdatasync is triggered, let's do in-place-update */
> >-	if (datasync || get_dirty_pages(inode) <= SM_I(sbi)->min_fsync_blocks)
> >+	if (datasync || (SM_I(sbi)->ipu_policy & (0x1 << F2FS_IPU_FSYNC) &&
> >+			get_dirty_pages(inode) <= SM_I(sbi)->min_fsync_blocks))
> >  		set_inode_flag(inode, FI_NEED_IPU);
> >+
> >  	ret = file_write_and_wait_range(file, start, end);
> >  	clear_inode_flag(inode, FI_NEED_IPU);
