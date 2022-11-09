Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC706622BF5
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 13:56:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbiKIM4O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 07:56:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiKIM4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 07:56:12 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C41B4175A9
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 04:56:11 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id f5-20020a17090a4a8500b002131bb59d61so3401616pjh.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 04:56:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GTNiukvdmVEX624Zmnyr26/MIM/udwcsY8n5lP0GEyY=;
        b=W2sAs668yAZHQON+sGrMew9Ga87XXr6Rfgy6++hbXvoG906krQL+2ho0gF9x/VhqHf
         7ndUlQWKpI1br3LkAg7LPMdBxPfonmBv1Ln3EFj7Ux9xq1qtzODnhzOyg1BGb1N8vGo4
         l1mJrZ5B+h4dbGBw8dA5suc/XKVKA3XlDkyVZdJktaXJZJAshS9wy7cZzWCJhgcbiQlH
         Q21hZY/SdNXVZT31gmtCy7kpUP24Q4uErIQDO4eASPuBzqhMud89EHOGbD/l6D9CNsku
         rFuH7WQaG8G0FXCoP72ToAWwCbDFhovb62C5kO6ZwvuOZ8dRYtpPwZ1dUdLMflChHfNQ
         93DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GTNiukvdmVEX624Zmnyr26/MIM/udwcsY8n5lP0GEyY=;
        b=Cu/hkeL7XPXfaLyBj/zXoU2/twku+h7NA8DwKnPz85mi5uFxKVE1sEotLtJ98b9ZV8
         Uq3fZEdJSIgsUQXbct8biTJfO51q0nvQDNAbQfnIlnz2YRPrMd55VpWbNtvor26Fuzi/
         kPf9HRBk0klIM1OWvys58ywd5NIMsaqAUuRyGqT1pEILg02cnnEX1ZesOcWaFwEHBkP7
         tqRGMyIg0lUDbjFAVdzkCuF4Yk015T4wkIQyzNUabCioQD2eawzP6rqFMO6oJlE3rG0S
         tyDxGxE+Zw7+GpP/QjE3ZpdaswctXipwzLA+7aTRFA61iphaJjvdNecg7gPMAymUqbr/
         GdYg==
X-Gm-Message-State: ACrzQf2tHBrXYEUXKhEB2etORBQgTuUBf0BEPxz8KfChZlTlXP57lIbu
        ZNR+J1nY4Ut2CQfgMolaO1M=
X-Google-Smtp-Source: AMsMyM53eSqqtxRqKKLKWJCtxP9QXYalWZH/XOh+/IkKGbyOf1NZXGDn3zLRV3CrVvL0I2gjsHEgww==
X-Received: by 2002:a17:90b:1d4d:b0:213:98e7:3b3 with SMTP id ok13-20020a17090b1d4d00b0021398e703b3mr61204947pjb.197.1667998571292;
        Wed, 09 Nov 2022 04:56:11 -0800 (PST)
Received: from mi-HP-ProDesk-680-G4-MT ([43.224.245.252])
        by smtp.gmail.com with ESMTPSA id a19-20020aa794b3000000b0056c2e497ad6sm8503866pfl.93.2022.11.09.04.56.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Nov 2022 04:56:10 -0800 (PST)
Date:   Wed, 9 Nov 2022 20:56:05 +0800
From:   qixiaoyu <qxy65535@gmail.com>
To:     Chao Yu <chao@kernel.org>
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        qixiaoyu1 <qixiaoyu1@xiaomi.com>
Subject: Re: [PATCH] f2fs: separate IPU policy for fdatasync from
 F2FS_IPU_FSYNC
Message-ID: <20221109125605.GD22857@mi-HP-ProDesk-680-G4-MT>
References: <20221021023136.22863-1-qixiaoyu1@xiaomi.com>
 <af41e68c-4f78-0934-1041-974e44bd3825@kernel.org>
 <20221102122518.GB22857@mi-HP-ProDesk-680-G4-MT>
 <3d2b1141-995a-4bfb-4bf0-5227be25105a@kernel.org>
 <20221108123218.GC22857@mi-HP-ProDesk-680-G4-MT>
 <8368702c-ae33-b810-a6c3-ac8fa29998df@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8368702c-ae33-b810-a6c3-ac8fa29998df@kernel.org>
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

On Tue, Nov 08, 2022 at 10:30:13PM +0800, Chao Yu wrote:
> On 2022/11/8 20:32, qixiaoyu wrote:
> >On Sun, Nov 06, 2022 at 09:54:59PM +0800, Chao Yu wrote:
> >>On 2022/11/2 20:25, qixiaoyu wrote:
> >>>Hi Chao,
> >>>
> >>>fdatasync do in-place-update to avoid additional node writes, but currently
> >>>it only do that with F2FS_IPU_FSYNC as:
> >>>
> >>>f2fs_do_sync_file:
> >>>	if (datasync || get_dirty_pages(inode) <= SM_I(sbi)->min_fsync_blocks)
> >>>  		set_inode_flag(inode, FI_NEED_IPU);
> >>>
> >>>check_inplace_update_policy:
> >>>	/* this is only set during fdatasync */
> >>>	if (policy & (0x1 << F2FS_IPU_FSYNC) &&
> >>>			is_inode_flag_set(inode, FI_NEED_IPU))
> >>>		return true;
> >>>
> >>>So this patch separate in-place-update of fdatasync from F2FS_IPU_FSYNC to
> >>>apply it to all IPU policy.
> >>>
> >>>BTW, we found small performance improvement with this patch on AndroBench app
> >>>using F2FS_IPU_SSR_UTIL on our product:
> >>
> >>How this patch affects performance when F2FS_IPU_SSR_UTIL is on?
> >>
> >>Thanks,
> >>
> >
> >SQLite test in AndroBench app use fdatasync to sync file to the disk.
> >When switch to F2FS_IPU_SSR_UTIL ipu_policy, it will use out-of-place-update
> >even though SQLite calls fdatasync, which will introduce extra meta data write.
> 
> Why not using F2FS_IPU_SSR_UTIL | F2FS_IPU_FSYNC, I guess these two flags
> cover different scenarios, F2FS_IPU_SSR_UTIL for ssr case, and F2FS_IPU_FSYNC
> for f{data,}sync case.
> 
> Thanks,
> 

As fsync(2) says:
fdatasync() is similar to fsync(), but does not flush modified metadata unless that
metadata is needed in order to allow a subsequent data retrieval to be correctly handled.

I think fdatasync should try to perform in-place-update to avoid unnecessary metadata
update whatever the ipu_policy is, and F2FS_IPU_FSYNC is used for fsync independently.

Thanks

> >
> >Thanks.
> >
> >>>
> >>>                 F2FS_IPU_FSYNC  F2FS_IPU_SSR_UTIL   F2FS_IPU_SSR_UTIL(with patch)
> >>>SQLite Insert(QPS)  6818.08     6327.09(-7.20%)     6757.72
> >>>SQLite Update(QPS)  6528.81     6336.57(-2.94%)     6490.77
> >>>SQLite Delete(QPS)  9724.68     9378.37(-3.56%)     9622.27
> >>>
> >>>Thanks
> >>>
> >>>On Tue, Nov 01, 2022 at 11:14:55PM +0800, Chao Yu wrote:
> >>>>On 2022/10/21 10:31, qixiaoyu1 wrote:
> >>>>>Currently IPU policy for fdatasync is coupled with F2FS_IPU_FSYNC.
> >>>>>Fix to apply it to all IPU policy.
> >>>>
> >>>>Xiaoyu,
> >>>>
> >>>>Sorry for the delay.
> >>>>
> >>>>I didn't get the point, can you please explain more about the
> >>>>issue?
> >>>>
> >>>>Thanks,
> >>>>
> >>>>>
> >>>>>Signed-off-by: qixiaoyu1 <qixiaoyu1@xiaomi.com>
> >>>>>---
> >>>>>  fs/f2fs/data.c | 8 +++-----
> >>>>>  fs/f2fs/file.c | 4 +++-
> >>>>>  2 files changed, 6 insertions(+), 6 deletions(-)
> >>>>>
> >>>>>diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> >>>>>index a71e818cd67b..fec8e15fe820 100644
> >>>>>--- a/fs/f2fs/data.c
> >>>>>+++ b/fs/f2fs/data.c
> >>>>>@@ -2518,6 +2518,9 @@ static inline bool check_inplace_update_policy(struct inode *inode,
> >>>>>  	if (policy & (0x1 << F2FS_IPU_HONOR_OPU_WRITE) &&
> >>>>>  			is_inode_flag_set(inode, FI_OPU_WRITE))
> >>>>>  		return false;
> >>>>>+	/* this is set by fdatasync or F2FS_IPU_FSYNC policy */
> >>>>>+	if (is_inode_flag_set(inode, FI_NEED_IPU))
> >>>>>+		return true;
> >>>>>  	if (policy & (0x1 << F2FS_IPU_FORCE))
> >>>>>  		return true;
> >>>>>  	if (policy & (0x1 << F2FS_IPU_SSR) && f2fs_need_SSR(sbi))
> >>>>>@@ -2538,11 +2541,6 @@ static inline bool check_inplace_update_policy(struct inode *inode,
> >>>>>  			!IS_ENCRYPTED(inode))
> >>>>>  		return true;
> >>>>>-	/* this is only set during fdatasync */
> >>>>>-	if (policy & (0x1 << F2FS_IPU_FSYNC) &&
> >>>>>-			is_inode_flag_set(inode, FI_NEED_IPU))
> >>>>>-		return true;
> >>>>>-
> >>>>>  	if (unlikely(fio && is_sbi_flag_set(sbi, SBI_CP_DISABLED) &&
> >>>>>  			!f2fs_is_checkpointed_data(sbi, fio->old_blkaddr)))
> >>>>>  		return true;
> >>>>>diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> >>>>>index 82cda1258227..08091550cdf2 100644
> >>>>>--- a/fs/f2fs/file.c
> >>>>>+++ b/fs/f2fs/file.c
> >>>>>@@ -270,8 +270,10 @@ static int f2fs_do_sync_file(struct file *file, loff_t start, loff_t end,
> >>>>>  		goto go_write;
> >>>>>  	/* if fdatasync is triggered, let's do in-place-update */
> >>>>>-	if (datasync || get_dirty_pages(inode) <= SM_I(sbi)->min_fsync_blocks)
> >>>>>+	if (datasync || (SM_I(sbi)->ipu_policy & (0x1 << F2FS_IPU_FSYNC) &&
> >>>>>+			get_dirty_pages(inode) <= SM_I(sbi)->min_fsync_blocks))
> >>>>>  		set_inode_flag(inode, FI_NEED_IPU);
> >>>>>+
> >>>>>  	ret = file_write_and_wait_range(file, start, end);
> >>>>>  	clear_inode_flag(inode, FI_NEED_IPU);
