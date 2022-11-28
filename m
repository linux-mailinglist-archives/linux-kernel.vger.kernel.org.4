Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CC5863A42C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 10:06:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbiK1JG4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 04:06:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230289AbiK1JGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 04:06:36 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8E8F1839D
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 01:06:31 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id 82so1897937pgc.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 01:06:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ycZaznc+xC+6/FUK+5zwqZvTJkK+CKo/Qas+UmyGYJA=;
        b=KXr9mkIABUKR23sDpx3J4fNYP0/DhMiVooAUH26XjKNyzrAOgpeNrWG0wdIl/X4SFb
         HkU1RDGt9qEPz8nVJfhbpbjAqjnsB0zvKkE7VgVGTjBaxBEd/o31Yd5es62ZAXQlX/Mx
         w3bgAW3VB+uZBxpy2qM/gdaokCHBC4IFVeHCwcwT/OUYq8kz/akUmUzFjxkmuzxBwBhO
         4cAJCQ5ASANz4N0mzLeELq6PbwvskDJNjSBtCyWTOkEqCw5mdZTf17H67HFFr/CEqung
         g47oNHwN/orzx/86GzTOz0/wwxlMSkGuhKy/IeO+lhObh08Xy98UzMJHIm/9/xPpBz/T
         4LYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ycZaznc+xC+6/FUK+5zwqZvTJkK+CKo/Qas+UmyGYJA=;
        b=piTn30n7fgALdwmWjg0CRFItWcaV/G3/l0nZvTHl4wu4Q+3Wv+JUCUlzmxQZ01AI2E
         Q6gUpLQstOLcY+CN+G5MOlS555y3dAWCMVdEI4oMHbOJBzTFTvsOUW1NDSs4eRygcCLW
         KiMGTKugISG+zrJ3Fylu+wP5jSIZ1nCEkRFI2Akj6/x0HCnkBghPQ1Jd1PJPZ79OlmF1
         yKYvrCUteLDn4Mc4sLmEggBqsErGwrnUgiepnOa3wwOyDTE8/4q0ImSwZVh56P6PIAbc
         4dMzjxeC3l2sln5iScpY/HVwh+aL150xitfDu4cfNEcC63OBLe16QF7pmgGM2ifOv/io
         O19Q==
X-Gm-Message-State: ANoB5pm176pnJYcrs0nnuqsCGmXS22MZiOtROoqaeWkA9EGJGq430j/S
        Dj3iAuixZP/Ju3KXnYytKISsNWj5hMsmUA==
X-Google-Smtp-Source: AA0mqf5//mr6NPOabTc2FkugvftXUYKc4FVT4sC5DIdFfkV7KaXLjupZcgbIk6Og0jc4Z1o28cgdiQ==
X-Received: by 2002:a63:1055:0:b0:46e:f011:9548 with SMTP id 21-20020a631055000000b0046ef0119548mr26085763pgq.553.1669626391178;
        Mon, 28 Nov 2022 01:06:31 -0800 (PST)
Received: from mi-HP-ProDesk-680-G4-MT.mioffice.cn ([43.224.245.252])
        by smtp.gmail.com with ESMTPSA id s17-20020a170902ea1100b001811a197797sm8269268plg.194.2022.11.28.01.06.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Nov 2022 01:06:30 -0800 (PST)
From:   qixiaoyu1 <qxy65535@gmail.com>
X-Google-Original-From: qixiaoyu1 <qixiaoyu1@xiaomi.com>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        qixiaoyu1 <qixiaoyu1@xiaomi.com>,
        xiongping1 <xiongping1@xiaomi.com>
Subject: [PATCH 4/5] f2fs: update block age info during out of place update
Date:   Mon, 28 Nov 2022 16:58:58 +0800
Message-Id: <20221128085859.5295-5-qixiaoyu1@xiaomi.com>
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

Signed-off-by: qixiaoyu1 <qixiaoyu1@xiaomi.com>
Signed-off-by: xiongping1 <xiongping1@xiaomi.com>
---
 fs/f2fs/block_age.c | 89 ++++++++++++++++++++++++++++++++++++++++++++-
 fs/f2fs/f2fs.h      |  1 +
 fs/f2fs/segment.c   |  4 ++
 3 files changed, 92 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/block_age.c b/fs/f2fs/block_age.c
index bc009616adfb..488461b3f4bf 100644
--- a/fs/f2fs/block_age.c
+++ b/fs/f2fs/block_age.c
@@ -9,9 +9,14 @@
 #include <linux/f2fs_fs.h>
 
 #include "f2fs.h"
+#include "node.h"
 #include "segment.h"
 #include <trace/events/f2fs.h>
 
+
+#define LAST_AGE_WEIGHT		30
+#define SAME_AGE_REGION		1024
+
 static struct kmem_cache *age_extent_tree_slab;
 static struct kmem_cache *age_extent_node_slab;
 
@@ -264,8 +269,8 @@ static inline bool __is_age_extent_mergeable(struct age_extent_info *back,
 						struct age_extent_info *front)
 {
 	return (back->fofs + back->len == front->fofs &&
-			back->age == front->age &&
-			back->last_blocks == front->last_blocks);
+			abs(back->age - front->age) <= SAME_AGE_REGION &&
+			abs(back->last_blocks - front->last_blocks) <= SAME_AGE_REGION);
 }
 
 static inline bool __is_back_age_ext_mergeable(struct age_extent_info *cur,
@@ -497,6 +502,86 @@ void f2fs_truncate_age_extent_cache(struct inode *inode, pgoff_t fofs, unsigned
 	f2fs_update_age_extent_cache(inode, fofs, len, 0, 0);
 }
 
+unsigned long long f2fs_get_cur_dblock_allocated(struct f2fs_sb_info *sbi)
+{
+	return atomic64_read(&sbi->total_data_alloc);
+}
+
+static unsigned long long calculate_block_age(unsigned long long new,
+							unsigned long long old)
+{
+	if (new >= old)
+		return new - (new - old) * LAST_AGE_WEIGHT / 100;
+	else
+		return new + (old - new) * LAST_AGE_WEIGHT / 100;
+}
+
+void f2fs_update_data_block_age(struct dnode_of_data *dn)
+{
+	struct f2fs_sb_info *sbi = F2FS_I_SB(dn->inode);
+	unsigned long long cur_total_blk_alloced = f2fs_get_cur_dblock_allocated(sbi);
+	pgoff_t fofs;
+	unsigned long long cur_age, new_age;
+	struct age_extent_info ei;
+	bool find;
+	loff_t f_size = i_size_read(dn->inode);
+
+	if (!f2fs_may_age_extent_tree(dn->inode))
+		return;
+
+	fofs = f2fs_start_bidx_of_node(ofs_of_node(dn->node_page), dn->inode) +
+								dn->ofs_in_node;
+
+
+	/* When I/O is not aligned to a PAGE_SIZE, update will happen to the last
+	 * file block even in seq write. So don't record age for newly last file
+	 * block here.
+	 */
+	if ((f_size >> PAGE_SHIFT) == fofs && f_size & (PAGE_SIZE - 1) &&
+			dn->data_blkaddr == NEW_ADDR)
+		return;
+
+	find = f2fs_lookup_age_extent_cache(dn->inode, fofs, &ei);
+	if (find) {
+		if (cur_total_blk_alloced >= ei.last_blocks)
+			cur_age = cur_total_blk_alloced - ei.last_blocks;
+		else
+			/* total_data_alloc overflow */
+			cur_age = ULLONG_MAX - ei.last_blocks + cur_total_blk_alloced;
+
+		if (ei.age)
+			new_age = calculate_block_age(cur_age, ei.age);
+		else
+			new_age = cur_age;
+
+		WARN(new_age > cur_total_blk_alloced,
+				"inode block(%lu: %lu) age changed from: %llu to %llu",
+				dn->inode->i_ino, fofs, ei.age, new_age);
+	} else {
+		f2fs_bug_on(sbi, dn->data_blkaddr == NULL_ADDR);
+
+		if (dn->data_blkaddr == NEW_ADDR)
+			/* the data block was allocated for the first time */
+			new_age = 0;
+		else {
+			if (__is_valid_data_blkaddr(dn->data_blkaddr) &&
+					!f2fs_is_valid_blkaddr(sbi, dn->data_blkaddr,
+								DATA_GENERIC_ENHANCE)) {
+				f2fs_bug_on(sbi, 1);
+				return;
+			}
+
+			/*
+			 * init block age with zero, this can happen when the block age extent
+			 * was reclaimed due to memory constraint or system reboot
+			 */
+			new_age = 0;
+		}
+	}
+
+	f2fs_update_age_extent_cache(dn->inode, fofs, 1, new_age, cur_total_blk_alloced);
+}
+
 void f2fs_destroy_age_extent_tree(struct inode *inode)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 428cc560b721..23516498b6d0 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -4238,6 +4238,7 @@ bool f2fs_lookup_age_extent_cache(struct inode *inode, pgoff_t pgofs,
 void f2fs_update_age_extent_cache(struct inode *inode, pgoff_t fofs,
 					unsigned int len, u64 age,
 					unsigned long long cur_blk_alloced);
+void f2fs_update_data_block_age(struct dnode_of_data *dn);
 void f2fs_truncate_age_extent_cache(struct inode *inode, pgoff_t fofs,
 					unsigned int len);
 int __init f2fs_create_age_extent_cache(void);
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index b105d8418f77..d4c338f332fa 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -3417,6 +3417,10 @@ void f2fs_outplace_write_data(struct dnode_of_data *dn,
 	struct f2fs_summary sum;
 
 	f2fs_bug_on(sbi, dn->data_blkaddr == NULL_ADDR);
+#ifdef CONFIG_F2FS_FS_DATA_SEPARATION
+	if (fio->io_type == FS_DATA_IO || fio->io_type == FS_CP_DATA_IO)
+		f2fs_update_data_block_age(dn);
+#endif
 	set_summary(&sum, dn->nid, dn->ofs_in_node, fio->version);
 	do_write_page(&sum, fio);
 	f2fs_update_data_blkaddr(dn, fio->new_blkaddr);
-- 
2.36.1

