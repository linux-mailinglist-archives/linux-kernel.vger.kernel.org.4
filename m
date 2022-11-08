Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 027126210C5
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 13:32:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233968AbiKHMcd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 07:32:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233779AbiKHMc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 07:32:28 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01DF613D41
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 04:32:28 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id z26so13701678pff.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 04:32:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NUYr0uhtmz7Dnti/gb7hA0lVz/+IZFhOgHoWke9hpfs=;
        b=F7h+vxYM4kEVjHFPpIHkcsuYTRyOIVUzvQBGMfVBRv7odRG+nvbVDUDuRp1SxCZ/iC
         OcsLOFXbBvC0CwcwJam2glhUuHm8ztg1LIinrYBA1ZrEVbZTFHS1lngrVmjrRNZfHH9Q
         wzWflT9JUUAaj7Stx/wpvCaqftVmke81do6wQ1aM0GghN46MpTyCNKjRtCz+ZNm4XlFA
         3G/g7LCQRwoHAainoBituog/tIa36Y51izwIwcVIWSqmRqT9543zPkPsQRDyGc6HsVED
         2wIcgBt/67hzTn8fYpG3OAxKzUk/aEYap9sfNKrcoWOlWa5wKI17s+W4oFHkWWMFgSHM
         eJsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NUYr0uhtmz7Dnti/gb7hA0lVz/+IZFhOgHoWke9hpfs=;
        b=7qe7O70XnL57yFs2OUE8Yqwq8+Ou7oxW4TgU1zZUsmChVZvpTj0QxzTS5M7mmU9k5U
         weMrsUojShzbjwfESjMvUOU3N4AhLwGFJAXAsZc95wyJfj72tvO5wW5hVnZ2y4I/QU5z
         xLdYwxOR1+CDAgE0XM0wAeGI8itE3BBgeoW80rKVQDOmBN8bCHuq0lMr4kEbxr/eY4HD
         UfJSTdnSe115QRtutw1sdKVek2zWGIJQCZV0af6pGj+zsNn/vVMe9tZzlarKxNPJavta
         12jZmU2bJYQMohKaaDOE65IJljc3gPvD/jLhTtMkXjM4T5LWZxbydQNVkVx/Hsv6jn03
         C5Ng==
X-Gm-Message-State: ACrzQf2rQXSBQtaVxvHRhU9DN5NycJs662C96Er9aptRR26TOVJyRs2V
        zSy7Q6iF7c6OTpgMn+8h3qCFxen2TSk=
X-Google-Smtp-Source: AMsMyM44ldktGKrkRUR3+OvKbUI/a+XMYvRAljtU/1tdXrkuIdYaWw5oOC/eCkfzxYgRCuP9m8yekQ==
X-Received: by 2002:a63:e218:0:b0:448:5163:478f with SMTP id q24-20020a63e218000000b004485163478fmr48617512pgh.415.1667910747451;
        Tue, 08 Nov 2022 04:32:27 -0800 (PST)
Received: from mi-HP-ProDesk-680-G4-MT ([43.224.245.252])
        by smtp.gmail.com with ESMTPSA id m2-20020a170902768200b0017f72a430adsm6772212pll.71.2022.11.08.04.32.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Nov 2022 04:32:25 -0800 (PST)
Date:   Tue, 8 Nov 2022 20:32:18 +0800
From:   qixiaoyu <qxy65535@gmail.com>
To:     Chao Yu <chao@kernel.org>
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        qixiaoyu1 <qixiaoyu1@xiaomi.com>
Subject: Re: [PATCH] f2fs: separate IPU policy for fdatasync from
 F2FS_IPU_FSYNC
Message-ID: <20221108123218.GC22857@mi-HP-ProDesk-680-G4-MT>
References: <20221021023136.22863-1-qixiaoyu1@xiaomi.com>
 <af41e68c-4f78-0934-1041-974e44bd3825@kernel.org>
 <20221102122518.GB22857@mi-HP-ProDesk-680-G4-MT>
 <3d2b1141-995a-4bfb-4bf0-5227be25105a@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d2b1141-995a-4bfb-4bf0-5227be25105a@kernel.org>
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

On Sun, Nov 06, 2022 at 09:54:59PM +0800, Chao Yu wrote:
> On 2022/11/2 20:25, qixiaoyu wrote:
> >Hi Chao,
> >
> >fdatasync do in-place-update to avoid additional node writes, but currently
> >it only do that with F2FS_IPU_FSYNC as:
> >
> >f2fs_do_sync_file:
> >	if (datasync || get_dirty_pages(inode) <= SM_I(sbi)->min_fsync_blocks)
> >  		set_inode_flag(inode, FI_NEED_IPU);
> >
> >check_inplace_update_policy:
> >	/* this is only set during fdatasync */
> >	if (policy & (0x1 << F2FS_IPU_FSYNC) &&
> >			is_inode_flag_set(inode, FI_NEED_IPU))
> >		return true;
> >
> >So this patch separate in-place-update of fdatasync from F2FS_IPU_FSYNC to
> >apply it to all IPU policy.
> >
> >BTW, we found small performance improvement with this patch on AndroBench app
> >using F2FS_IPU_SSR_UTIL on our product:
> 
> How this patch affects performance when F2FS_IPU_SSR_UTIL is on?
> 
> Thanks,
> 

SQLite test in AndroBench app use fdatasync to sync file to the disk.
When switch to F2FS_IPU_SSR_UTIL ipu_policy, it will use out-of-place-update
even though SQLite calls fdatasync, which will introduce extra meta data write.

Thanks.

> >
> >                 F2FS_IPU_FSYNC  F2FS_IPU_SSR_UTIL   F2FS_IPU_SSR_UTIL(with patch)
> >SQLite Insert(QPS)  6818.08     6327.09(-7.20%)     6757.72
> >SQLite Update(QPS)  6528.81     6336.57(-2.94%)     6490.77
> >SQLite Delete(QPS)  9724.68     9378.37(-3.56%)     9622.27
> >
> >Thanks
> >
> >On Tue, Nov 01, 2022 at 11:14:55PM +0800, Chao Yu wrote:
> >>On 2022/10/21 10:31, qixiaoyu1 wrote:
> >>>Currently IPU policy for fdatasync is coupled with F2FS_IPU_FSYNC.
> >>>Fix to apply it to all IPU policy.
> >>
> >>Xiaoyu,
> >>
> >>Sorry for the delay.
> >>
> >>I didn't get the point, can you please explain more about the
> >>issue?
> >>
> >>Thanks,
> >>
> >>>
> >>>Signed-off-by: qixiaoyu1 <qixiaoyu1@xiaomi.com>
> >>>---
> >>>  fs/f2fs/data.c | 8 +++-----
> >>>  fs/f2fs/file.c | 4 +++-
> >>>  2 files changed, 6 insertions(+), 6 deletions(-)
> >>>
> >>>diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> >>>index a71e818cd67b..fec8e15fe820 100644
> >>>--- a/fs/f2fs/data.c
> >>>+++ b/fs/f2fs/data.c
> >>>@@ -2518,6 +2518,9 @@ static inline bool check_inplace_update_policy(struct inode *inode,
> >>>  	if (policy & (0x1 << F2FS_IPU_HONOR_OPU_WRITE) &&
> >>>  			is_inode_flag_set(inode, FI_OPU_WRITE))
> >>>  		return false;
> >>>+	/* this is set by fdatasync or F2FS_IPU_FSYNC policy */
> >>>+	if (is_inode_flag_set(inode, FI_NEED_IPU))
> >>>+		return true;
> >>>  	if (policy & (0x1 << F2FS_IPU_FORCE))
> >>>  		return true;
> >>>  	if (policy & (0x1 << F2FS_IPU_SSR) && f2fs_need_SSR(sbi))
> >>>@@ -2538,11 +2541,6 @@ static inline bool check_inplace_update_policy(struct inode *inode,
> >>>  			!IS_ENCRYPTED(inode))
> >>>  		return true;
> >>>-	/* this is only set during fdatasync */
> >>>-	if (policy & (0x1 << F2FS_IPU_FSYNC) &&
> >>>-			is_inode_flag_set(inode, FI_NEED_IPU))
> >>>-		return true;
> >>>-
> >>>  	if (unlikely(fio && is_sbi_flag_set(sbi, SBI_CP_DISABLED) &&
> >>>  			!f2fs_is_checkpointed_data(sbi, fio->old_blkaddr)))
> >>>  		return true;
> >>>diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> >>>index 82cda1258227..08091550cdf2 100644
> >>>--- a/fs/f2fs/file.c
> >>>+++ b/fs/f2fs/file.c
> >>>@@ -270,8 +270,10 @@ static int f2fs_do_sync_file(struct file *file, loff_t start, loff_t end,
> >>>  		goto go_write;
> >>>  	/* if fdatasync is triggered, let's do in-place-update */
> >>>-	if (datasync || get_dirty_pages(inode) <= SM_I(sbi)->min_fsync_blocks)
> >>>+	if (datasync || (SM_I(sbi)->ipu_policy & (0x1 << F2FS_IPU_FSYNC) &&
> >>>+			get_dirty_pages(inode) <= SM_I(sbi)->min_fsync_blocks))
> >>>  		set_inode_flag(inode, FI_NEED_IPU);
> >>>+
> >>>  	ret = file_write_and_wait_range(file, start, end);
> >>>  	clear_inode_flag(inode, FI_NEED_IPU);
