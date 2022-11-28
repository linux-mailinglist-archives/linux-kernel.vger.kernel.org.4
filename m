Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E3C463A42F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 10:07:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbiK1JHA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 04:07:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbiK1JGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 04:06:40 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F248415724
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 01:06:34 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id q1so9351369pgl.11
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 01:06:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BLKXiYJYrg2dlB187g+CWrgI5UTddt8FYxHfk/bEX8w=;
        b=ToLYrPdB/98crZI29wTwpCgtIfl/tinLjbghq0UsSmXB2VSNQysz1AWDV7ZjS+w92q
         j3bHP+azMDr6JM7C5wovgdSnbiIozqyUkx3DXGF35KYw5g1fkY77vcpHzlF/A1G84z16
         82FKGw5VhYdmolDeXmI9yADrFBQCtML6NTVcIOO4n+1Vtz3VR3IlwVsuNogkg9TQ6+p0
         1z3N0hQJ9yswmrLj8J+ZuEzK6gYew9JzvDN0DQmhcWeqxXkLhcpwMCF0zJnxbhhjgM9X
         7WuN+5ry+F+ieUwp10pUrAAgtjh4FeCzFfujT4koheU5sT9t6RgapnDHQ2i+bcRiD1eD
         z2Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BLKXiYJYrg2dlB187g+CWrgI5UTddt8FYxHfk/bEX8w=;
        b=Y09KbQWddTP41yPsoaOi2QIEiH9eSNAWEjdLuNNJY2Om7CDbFGPrczmy4WZdQHhmEQ
         WrPuwtLRiDgBvsyqvTjUvjb2KvISMaq57uJlwIZCERkaeoWZK1fChZUDOPMiW21u4V3D
         AeydXurVhCLy6OePLB85gEW+tzIqPYTY01PDz4gS5J6frFibJnSTI4cWZlnTlpPLBBsh
         /tqFDqUHHtz5vCRZE54zn7oQRbLC7EeT9fKLF1m9r53vRO4sZb+NOeneS0hRvKuHlGVO
         vuUZ/lejWkClo9YqxrWqMaepIVNBqLrHX9UIzixWzWldnH5n2HtTCpQzYgaZUukvenKx
         Ym6A==
X-Gm-Message-State: ANoB5pnRRvid0IaQWwSdJCT+11xONGjG8qSJJ5q+ZCsSYL90Dt0SPD3A
        jpQHDLKmUvfQ1J7zKwTQJAw=
X-Google-Smtp-Source: AA0mqf6ccGEnOo/fA5QHWcUNY0QKAjGbgqC9jPuTZJv65ymypf+K5I5b6WsUjtvDcm8GUh0Kh7ps5w==
X-Received: by 2002:a05:6a00:4009:b0:563:2ada:30a3 with SMTP id by9-20020a056a00400900b005632ada30a3mr32385650pfb.27.1669626394381;
        Mon, 28 Nov 2022 01:06:34 -0800 (PST)
Received: from mi-HP-ProDesk-680-G4-MT.mioffice.cn ([43.224.245.252])
        by smtp.gmail.com with ESMTPSA id s17-20020a170902ea1100b001811a197797sm8269268plg.194.2022.11.28.01.06.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Nov 2022 01:06:33 -0800 (PST)
From:   qixiaoyu1 <qxy65535@gmail.com>
X-Google-Original-From: qixiaoyu1 <qixiaoyu1@xiaomi.com>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        qixiaoyu1 <qixiaoyu1@xiaomi.com>,
        xiongping1 <xiongping1@xiaomi.com>
Subject: [PATCH 5/5] f2fs: implement data block seperation with block update frequency
Date:   Mon, 28 Nov 2022 16:58:59 +0800
Message-Id: <20221128085859.5295-6-qixiaoyu1@xiaomi.com>
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
 Documentation/ABI/testing/sysfs-fs-f2fs | 14 ++++++++++++
 fs/f2fs/block_age.c                     | 29 +++++++++++++++++++++++++
 fs/f2fs/f2fs.h                          |  4 ++++
 fs/f2fs/segment.c                       |  9 ++++++++
 fs/f2fs/sysfs.c                         | 28 ++++++++++++++++++++++++
 include/trace/events/f2fs.h             |  2 +-
 6 files changed, 85 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
index 483639fb727b..34952666b2fe 100644
--- a/Documentation/ABI/testing/sysfs-fs-f2fs
+++ b/Documentation/ABI/testing/sysfs-fs-f2fs
@@ -634,3 +634,17 @@ Date:		July 2022
 Contact:	"Daeho Jeong" <daehojeong@google.com>
 Description:	Show the accumulated total revoked atomic write block count after boot.
 		If you write "0" here, you can initialize to "0".
+
+What:		/sys/fs/f2fs/<disk>/hot_data_age_threshold
+Date:		November 2022
+Contact:	"Ping Xiong" <xiongping1@xiaomi.com>
+Description:	When DATA SEPARATION is on, it controls the age threshold to indicate
+		the data blocks as hot. By default it was initialized as 262144 blocks
+		(equals to 1GB).
+
+What:		/sys/fs/f2fs/<disk>/warm_data_age_threshold
+Date:		November 2022
+Contact:	"Ping Xiong" <xiongping1@xiaomi.com>
+Description:	When DATA SEPARATION is on, it controls the age threshold to indicate
+		the data blocks as warm. By default it was initialized as 2621440 blocks
+		(equals to 10GB).
diff --git a/fs/f2fs/block_age.c b/fs/f2fs/block_age.c
index 488461b3f4bf..d0b578544df7 100644
--- a/fs/f2fs/block_age.c
+++ b/fs/f2fs/block_age.c
@@ -17,6 +17,13 @@
 #define LAST_AGE_WEIGHT		30
 #define SAME_AGE_REGION		1024
 
+/*
+ * Define data block with age less than 1GB as hot data
+ * define data block with age less than 10GB but more than 1GB as warm data
+ */
+#define DEF_HOT_DATA_AGE_THRESHOLD	262144
+#define DEF_WARM_DATA_AGE_THRESHOLD	2621440
+
 static struct kmem_cache *age_extent_tree_slab;
 static struct kmem_cache *age_extent_node_slab;
 
@@ -29,6 +36,9 @@ static inline void f2fs_inc_data_block_alloc(struct f2fs_sb_info *sbi)
 static void f2fs_init_block_age_info(struct f2fs_sb_info *sbi)
 {
 	atomic64_set(&sbi->total_data_alloc, 0);
+
+	sbi->hot_data_age_threshold = DEF_HOT_DATA_AGE_THRESHOLD;
+	sbi->warm_data_age_threshold = DEF_WARM_DATA_AGE_THRESHOLD;
 }
 
 static inline bool f2fs_may_age_extent_tree(struct inode *inode)
@@ -697,6 +707,25 @@ unsigned long f2fs_count_age_extent_cache(struct f2fs_sb_info *sbi)
 				atomic_read(&sbi->total_age_ext_node);
 }
 
+int f2fs_get_data_segment_type(struct inode *inode, pgoff_t pgofs)
+{
+	struct age_extent_info ei;
+	struct f2fs_sb_info *sbi =  F2FS_I_SB(inode);
+
+	if (f2fs_lookup_age_extent_cache(inode, pgofs, &ei)) {
+		if (ei.age != 0) {
+			if (ei.age <= sbi->hot_data_age_threshold)
+				return CURSEG_HOT_DATA;
+			else if (ei.age <= sbi->warm_data_age_threshold)
+				return CURSEG_WARM_DATA;
+			else
+				return CURSEG_COLD_DATA;
+		}
+	}
+
+	return NO_CHECK_TYPE;
+}
+
 void f2fs_destroy_age_extent_cache(void)
 {
 	kmem_cache_destroy(age_extent_node_slab);
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 23516498b6d0..50f6f21b23bf 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1854,6 +1854,9 @@ struct f2fs_sb_info {
 
 #ifdef CONFIG_F2FS_FS_DATA_SEPARATION
 	atomic64_t total_data_alloc;
+	/* The threshold used for hot and warm data seperation*/
+	unsigned int hot_data_age_threshold;
+	unsigned int warm_data_age_threshold;
 #endif
 
 	/* Reference to checksum algorithm driver via cryptoapi */
@@ -4241,6 +4244,7 @@ void f2fs_update_age_extent_cache(struct inode *inode, pgoff_t fofs,
 void f2fs_update_data_block_age(struct dnode_of_data *dn);
 void f2fs_truncate_age_extent_cache(struct inode *inode, pgoff_t fofs,
 					unsigned int len);
+int f2fs_get_data_segment_type(struct inode *inode, pgoff_t pgofs);
 int __init f2fs_create_age_extent_cache(void);
 void f2fs_destroy_age_extent_cache(void);
 #endif
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index d4c338f332fa..2fa5b22119ac 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -3163,6 +3163,9 @@ static int __get_segment_type_6(struct f2fs_io_info *fio)
 	if (fio->type == DATA) {
 		struct inode *inode = fio->page->mapping->host;
 
+#ifdef CONFIG_F2FS_FS_DATA_SEPARATION
+		int type;
+#endif
 		if (is_inode_flag_set(inode, FI_ALIGNED_WRITE))
 			return CURSEG_COLD_DATA_PINNED;
 
@@ -3176,6 +3179,12 @@ static int __get_segment_type_6(struct f2fs_io_info *fio)
 		}
 		if (file_is_cold(inode) || f2fs_need_compress_data(inode))
 			return CURSEG_COLD_DATA;
+
+#ifdef CONFIG_F2FS_FS_DATA_SEPARATION
+		type = f2fs_get_data_segment_type(inode, fio->page->index);
+		if (type != NO_CHECK_TYPE)
+			return type;
+#endif
 		if (file_is_hot(inode) ||
 				is_inode_flag_set(inode, FI_HOT_DATA) ||
 				f2fs_is_cow_file(inode))
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index df27afd71ef4..68ba8c1c2cb3 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -648,6 +648,25 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
 		sbi->revoked_atomic_block = 0;
 		return count;
 	}
+#ifdef CONFIG_F2FS_FS_DATA_SEPARATION
+	if (!strcmp(a->attr.name, "hot_data_age_threshold")) {
+		if (t == 0 || t >= sbi->warm_data_age_threshold)
+			return -EINVAL;
+		if (t == *ui)
+			return count;
+		*ui = (unsigned int)t;
+		return count;
+	}
+
+	if (!strcmp(a->attr.name, "warm_data_age_threshold")) {
+		if (t == 0 || t <= sbi->hot_data_age_threshold)
+			return -EINVAL;
+		if (t == *ui)
+			return count;
+		*ui = (unsigned int)t;
+		return count;
+	}
+#endif
 
 	*ui = (unsigned int)t;
 
@@ -902,6 +921,11 @@ F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, peak_atomic_write, peak_atomic_write);
 F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, committed_atomic_block, committed_atomic_block);
 F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, revoked_atomic_block, revoked_atomic_block);
 
+#ifdef CONFIG_F2FS_FS_DATA_SEPARATION
+F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, hot_data_age_threshold, hot_data_age_threshold);
+F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, warm_data_age_threshold, warm_data_age_threshold);
+#endif
+
 #define ATTR_LIST(name) (&f2fs_attr_##name.attr)
 static struct attribute *f2fs_attrs[] = {
 	ATTR_LIST(gc_urgent_sleep_time),
@@ -995,6 +1019,10 @@ static struct attribute *f2fs_attrs[] = {
 	ATTR_LIST(peak_atomic_write),
 	ATTR_LIST(committed_atomic_block),
 	ATTR_LIST(revoked_atomic_block),
+#ifdef CONFIG_F2FS_FS_DATA_SEPARATION
+	ATTR_LIST(hot_data_age_threshold),
+	ATTR_LIST(warm_data_age_threshold),
+#endif
 	NULL,
 };
 ATTRIBUTE_GROUPS(f2fs);
diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
index b19c057ff801..0adb26397e68 100644
--- a/include/trace/events/f2fs.h
+++ b/include/trace/events/f2fs.h
@@ -1692,7 +1692,7 @@ DECLARE_EVENT_CLASS(f2fs_add_age_extent_node,
 		__entry->blocks = ei->last_blocks;
 	),
 
-	TP_printk("dev = (%d,%d), ino = %lu, node_cnt = %lu, "
+	TP_printk("dev = (%d,%d), ino = %lu, node_cnt = %u, "
 		"age_ext_info(fofs: %u, len: %u, age: %llu, blocks: %llu)",
 		show_dev_ino(__entry),
 		__entry->cnt,
-- 
2.36.1

