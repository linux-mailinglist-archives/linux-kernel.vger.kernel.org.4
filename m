Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A37B263A426
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 10:06:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230300AbiK1JGm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 04:06:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230285AbiK1JGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 04:06:33 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B295C140BF
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 01:06:27 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id q12so5735886pfn.10
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 01:06:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=93lUf2Yl5jzTi/ZpIQt/d66du6Z7M3MI5N1pwAOidPY=;
        b=cvRduKxQBd+dQX00FcUDlva9HxIMi7VXrDhju+OzmsUksxd1+QVOsiRPhFgy1T9nk/
         5ey7nbpakRWL4y+EWdA67WIm0iQ4B701ccG8U1TBVOKA0IutNu4Pyp0WMOvf2gAk6kF1
         ua6qCIR1QsIUTkNFdhQl0UgwEofc8ZeeyTzo3aI804XeaaqcrYlDhGZgrZrW0zDkwMyx
         X5mFupdqjR6Oxo2uEnyMGhLvS6vLzohHdbDTZUT+4kegvUzNR/Dnvo9vcResfKIV9dXu
         +DZ65C2fLgesKA/EZ+PLJGH03NNezkjyjLWhjBFL4KewSBH35r7BSAKRFwj0H6OcJQrG
         ZjTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=93lUf2Yl5jzTi/ZpIQt/d66du6Z7M3MI5N1pwAOidPY=;
        b=akKqGig94ESVmofQKWFNoLVA1LGFLBrFwOINo3eATyJTF/rLf1bXdrX/5TJxNH/qlO
         mSDG6VmMuudEpgFk0Z68S+/EvaomLM4wIttzWnL6HFtNLzZOR3MKaZc7XYdobeohb70w
         Wbf3CWAP1ECEHsE/RBusAoQ1JsgOtlV3xvLfNBsTC6542Thc6SBz986ymlVWWqrJpQjT
         y1xV2jn2VJEfizgsHIQJdSoPssUvtPrNmrH7GqEuiGpDVGGuPfTDfE+IoAbxQgY8a1L6
         TTM72VphH/yGd+Lympouptc5+8wQjaXkvq1Nh/rvcPU1BaTwspsR4KmkvE0T2E0gCRg+
         Kp1A==
X-Gm-Message-State: ANoB5pmkBhKZVZZzpksk88Z87mq1xwkZ6YaMFy44AlVrZpnC2SxX5TEq
        fCbzIbNiFH1fht2ysBe3t7o=
X-Google-Smtp-Source: AA0mqf5bLNRGY5ORIClJVRaDOve5sCdxWODL5frMN+BPd5GYHAnQP2HovicHAy+X8YBzInCO7+2cBA==
X-Received: by 2002:aa7:9045:0:b0:56c:a321:eecb with SMTP id n5-20020aa79045000000b0056ca321eecbmr52091885pfo.19.1669626387218;
        Mon, 28 Nov 2022 01:06:27 -0800 (PST)
Received: from mi-HP-ProDesk-680-G4-MT.mioffice.cn ([43.224.245.252])
        by smtp.gmail.com with ESMTPSA id s17-20020a170902ea1100b001811a197797sm8269268plg.194.2022.11.28.01.06.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Nov 2022 01:06:26 -0800 (PST)
From:   qixiaoyu1 <qxy65535@gmail.com>
X-Google-Original-From: qixiaoyu1 <qixiaoyu1@xiaomi.com>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        qixiaoyu1 <qixiaoyu1@xiaomi.com>,
        xiongping1 <xiongping1@xiaomi.com>
Subject: [PATCH 3/5] f2fs: add age_extent_cache mount option
Date:   Mon, 28 Nov 2022 16:58:57 +0800
Message-Id: <20221128085859.5295-4-qixiaoyu1@xiaomi.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20221128085859.5295-1-qixiaoyu1@xiaomi.com>
References: <20221128085859.5295-1-qixiaoyu1@xiaomi.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: xiongping1 <xiongping1@xiaomi.com>

enable data block seperation feature only when
age_extent_cache mount option is on

Signed-off-by: xiongping1 <xiongping1@xiaomi.com>
Signed-off-by: qixiaoyu1 <qixiaoyu1@xiaomi.com>
---
 Documentation/filesystems/f2fs.rst |  4 ++++
 fs/f2fs/block_age.c                |  3 +++
 fs/f2fs/f2fs.h                     |  1 +
 fs/f2fs/super.c                    | 27 +++++++++++++++++++++++++++
 4 files changed, 35 insertions(+)

diff --git a/Documentation/filesystems/f2fs.rst b/Documentation/filesystems/f2fs.rst
index 17df9a02ccff..f4e8943f649d 100644
--- a/Documentation/filesystems/f2fs.rst
+++ b/Documentation/filesystems/f2fs.rst
@@ -340,6 +340,10 @@ memory=%s		 Control memory mode. This supports "normal" and "low" modes.
 			 Because of the nature of low memory devices, in this mode, f2fs
 			 will try to save memory sometimes by sacrificing performance.
 			 "normal" mode is the default mode and same as before.
+age_extent_cache	 Enable an age extent cache based on rb-tree, it can record
+			 data block update frequency of the extent per inode, in
+			 order to indicate better temperature info for data block
+			 allocation.
 ======================== ============================================================
 
 Debugfs Entries
diff --git a/fs/f2fs/block_age.c b/fs/f2fs/block_age.c
index c8e8fbe51d8e..bc009616adfb 100644
--- a/fs/f2fs/block_age.c
+++ b/fs/f2fs/block_age.c
@@ -37,6 +37,9 @@ static inline bool f2fs_may_age_extent_tree(struct inode *inode)
 	if (list_empty(&sbi->s_list))
 		return false;
 
+	if (!test_opt(sbi, AGE_EXTENT_CACHE))
+		return false;
+
 	/* don't cache block age info for cold file */
 	if (is_inode_flag_set(inode, FI_COMPRESSED_FILE) ||
 			file_is_cold(inode))
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 5cc516228407..428cc560b721 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -106,6 +106,7 @@ extern const char *f2fs_fault_name[FAULT_MAX];
 #define F2FS_MOUNT_MERGE_CHECKPOINT	0x10000000
 #define	F2FS_MOUNT_GC_MERGE		0x20000000
 #define F2FS_MOUNT_COMPRESS_CACHE	0x40000000
+#define F2FS_MOUNT_AGE_EXTENT_CACHE	0x80000000
 
 #define F2FS_OPTION(sbi)	((sbi)->mount_opt)
 #define clear_opt(sbi, option)	(F2FS_OPTION(sbi).opt &= ~F2FS_MOUNT_##option)
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 91d3c9d0425d..dcb5905c7264 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -161,6 +161,9 @@ enum {
 	Opt_nogc_merge,
 	Opt_discard_unit,
 	Opt_memory_mode,
+#ifdef CONFIG_F2FS_FS_DATA_SEPARATION
+	Opt_age_extent_cache,
+#endif
 	Opt_err,
 };
 
@@ -238,6 +241,9 @@ static match_table_t f2fs_tokens = {
 	{Opt_nogc_merge, "nogc_merge"},
 	{Opt_discard_unit, "discard_unit=%s"},
 	{Opt_memory_mode, "memory=%s"},
+#ifdef CONFIG_F2FS_FS_DATA_SEPARATION
+	{Opt_age_extent_cache, "age_extent_cache"},
+#endif
 	{Opt_err, NULL},
 };
 
@@ -1253,6 +1259,11 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
 			}
 			kfree(name);
 			break;
+#ifdef CONFIG_F2FS_FS_DATA_SEPARATION
+		case Opt_age_extent_cache:
+			set_opt(sbi, AGE_EXTENT_CACHE);
+			break;
+#endif
 		default:
 			f2fs_err(sbi, "Unrecognized mount option \"%s\" or missing value",
 				 p);
@@ -2035,6 +2046,10 @@ static int f2fs_show_options(struct seq_file *seq, struct dentry *root)
 	else if (F2FS_OPTION(sbi).memory_mode == MEMORY_MODE_LOW)
 		seq_printf(seq, ",memory=%s", "low");
 
+#ifdef CONFIG_F2FS_FS_DATA_SEPARATION
+	if (test_opt(sbi, AGE_EXTENT_CACHE))
+		seq_puts(seq, ",age_extent_cache");
+#endif
 	return 0;
 }
 
@@ -2206,6 +2221,9 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 	bool need_restart_discard = false, need_stop_discard = false;
 	bool no_extent_cache = !test_opt(sbi, EXTENT_CACHE);
 	bool enable_checkpoint = !test_opt(sbi, DISABLE_CHECKPOINT);
+#ifdef CONFIG_F2FS_FS_DATA_SEPARATION
+	bool no_age_extent_cache = !test_opt(sbi, AGE_EXTENT_CACHE);
+#endif
 	bool no_io_align = !F2FS_IO_ALIGNED(sbi);
 	bool no_atgc = !test_opt(sbi, ATGC);
 	bool no_discard = !test_opt(sbi, DISCARD);
@@ -2300,6 +2318,15 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 		goto restore_opts;
 	}
 
+#ifdef CONFIG_F2FS_FS_DATA_SEPARATION
+	/* disallow enable/disable age extent_cache dynamically */
+	if (no_age_extent_cache == !!test_opt(sbi, AGE_EXTENT_CACHE)) {
+		err = -EINVAL;
+		f2fs_warn(sbi, "switch age_extent_cache option is not allowed");
+		goto restore_opts;
+	}
+#endif
+
 	if (no_io_align == !!F2FS_IO_ALIGNED(sbi)) {
 		err = -EINVAL;
 		f2fs_warn(sbi, "switch io_bits option is not allowed");
-- 
2.36.1

