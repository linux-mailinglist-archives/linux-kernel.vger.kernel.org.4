Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD41466B5E4
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 04:12:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231586AbjAPDMH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 22:12:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231673AbjAPDME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 22:12:04 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83FB34C17
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 19:12:03 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id p24so28953617plw.11
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 19:12:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=70wWPTTRf45yo4TsZOfmJlWbWf/vWiaM4qlj+SV+zPg=;
        b=jdJ20l8M/RfczWorTmdZeOFh4qbp8AttwUMlGoseZpFA99uR1fLBekTrptX9mXE2Pe
         dUj2C5MLSdTl043rgpqSZyRqfYpkGBjy07xu1uR2Vo7t0tFgh1nD3O/nu2XMpirVmdp5
         TnfEUG/dPp+NMjAOyTBb8y7B5qUeDJcV4SX22jaPX6bf9G+mFM9dtLuyAYnkKMhWvL9B
         tT/7c0kd5n4fZ+1iqdo3+iN/2H7cZ16orrtA7/Tao4s9FK/UD3n+w7U/9pas5tWu36kM
         To7nmCu/P8U5UMPeAYZC4573/dQmc8vqlWnlWyQmTCb8AS08cGwGWvXNcVC0adJ+5m8f
         bNfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=70wWPTTRf45yo4TsZOfmJlWbWf/vWiaM4qlj+SV+zPg=;
        b=m2o1CLowDdmxR7WpoQRkm5VZhvTGAGVvY5UItm1vIQ5yFohIe8oerTMX4iTAy36mhM
         07QyaR8ZcX/Ai9o6DrtUqjc01bY8Lejd+SIK6bnJHeKPL4FQe3GO2VLCoMyWJEflEagO
         s8t/E2+g2XSzBRBrI0yNQ9/YqdUpqXHSKOZ/pUpTSDdeB5r4GRHfO1E+Tgq1W5qBvx8s
         crOO0kE6JjhqMEb9b5ywxmT7iiFyJs2E5vd54WwAk/F/RKFJJXxysTqWxwSlq2AWAsoq
         /0xeHxDF02XReq84johrcMV3H9qMymxp2sH5m5N1WEc4GgLc3+pyJXgavt4aUkN8r+4L
         zp9g==
X-Gm-Message-State: AFqh2kpvZrC9h1kFYPYVCHFt/zeu5IgehKjlHxuoJvXpFyPlnfe0uWGm
        FwsYSgt8oSkjF/gYDUh9phQ=
X-Google-Smtp-Source: AMrXdXvA54E+I6eaQGmDNC76CiN85SNIgGPjufJgIykCbBHVbvEqcj0PxpI9DLtqU6sOD6x4wddI1Q==
X-Received: by 2002:a17:902:9303:b0:194:8bd7:3236 with SMTP id bc3-20020a170902930300b001948bd73236mr4145106plb.45.1673838722991;
        Sun, 15 Jan 2023 19:12:02 -0800 (PST)
Received: from mi-HP-ProDesk-680-G4-MT.mioffice.cn ([43.224.245.252])
        by smtp.gmail.com with ESMTPSA id m3-20020a170902db0300b0018980f14ecfsm15326458plx.115.2023.01.15.19.12.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 15 Jan 2023 19:12:02 -0800 (PST)
From:   qixiaoyu1 <qxy65535@gmail.com>
X-Google-Original-From: qixiaoyu1 <qixiaoyu1@xiaomi.com>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, qixiaoyu1@xiaomi.com,
        xiongping1@xiaomi.com
Subject: [PATCH 2/2 v2] f2fs: add sysfs nodes to set last_age_weight
Date:   Mon, 16 Jan 2023 11:08:50 +0800
Message-Id: <20230116030850.20260-2-qixiaoyu1@xiaomi.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20230116030850.20260-1-qixiaoyu1@xiaomi.com>
References: <20230113125859.15651-1-qixiaoyu1@xiaomi.com>
 <20230116030850.20260-1-qixiaoyu1@xiaomi.com>
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
 Documentation/ABI/testing/sysfs-fs-f2fs |  5 +++++
 fs/f2fs/extent_cache.c                  | 12 +++++++-----
 fs/f2fs/f2fs.h                          |  1 +
 fs/f2fs/sysfs.c                         | 11 +++++++++++
 4 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
index 9e3756625a81..11af7dbb6bc9 100644
--- a/Documentation/ABI/testing/sysfs-fs-f2fs
+++ b/Documentation/ABI/testing/sysfs-fs-f2fs
@@ -669,3 +669,8 @@ Contact:	"Ping Xiong" <xiongping1@xiaomi.com>
 Description:	When DATA SEPARATION is on, it controls the age threshold to indicate
 		the data blocks as warm. By default it was initialized as 2621440 blocks
 		(equals to 10GB).
+
+What:           /sys/fs/f2fs/<disk>/last_age_weight
+Date:           January 2023
+Contact:        "Ping Xiong" <xiongping1@xiaomi.com>
+Description:    When DATA SEPARATION is on, it controls the weight of last data block age.
diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
index ad5533f178fd..f081f4edae78 100644
--- a/fs/f2fs/extent_cache.c
+++ b/fs/f2fs/extent_cache.c
@@ -871,11 +871,12 @@ void f2fs_update_read_extent_tree_range_compressed(struct inode *inode,
 }
 #endif
 
-static unsigned long long __calculate_block_age(unsigned long long new,
-						unsigned long long old)
+static unsigned long long __calculate_block_age(struct f2fs_sb_info *sbi,
+						unsigned long long new, unsigned long long old)
 {
-	return div_u64(new, 100) * (100 - LAST_AGE_WEIGHT)
-		+ div_u64(old, 100) * LAST_AGE_WEIGHT;
+	unsigned int weight = sbi->last_age_weight;
+
+	return div_u64(new, 100) * (100 - weight) + div_u64(old, 100) * weight;
 }
 
 /* This returns a new age and allocated blocks in ei */
@@ -907,7 +908,7 @@ static int __get_new_block_age(struct inode *inode, struct extent_info *ei,
 			cur_age = ULLONG_MAX - tei.last_blocks + cur_blocks;
 
 		if (tei.age)
-			ei->age = __calculate_block_age(cur_age, tei.age);
+			ei->age = __calculate_block_age(sbi, cur_age, tei.age);
 		else
 			ei->age = cur_age;
 		ei->last_blocks = cur_blocks;
@@ -1223,6 +1224,7 @@ void f2fs_init_extent_cache_info(struct f2fs_sb_info *sbi)
 	atomic64_set(&sbi->allocated_data_blocks, 0);
 	sbi->hot_data_age_threshold = DEF_HOT_DATA_AGE_THRESHOLD;
 	sbi->warm_data_age_threshold = DEF_WARM_DATA_AGE_THRESHOLD;
+	sbi->last_age_weight = LAST_AGE_WEIGHT;
 }
 
 int __init f2fs_create_extent_cache(void)
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index e8953c3dc81a..c3609cbc28c7 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1679,6 +1679,7 @@ struct f2fs_sb_info {
 	/* The threshold used for hot and warm data seperation*/
 	unsigned int hot_data_age_threshold;
 	unsigned int warm_data_age_threshold;
+	unsigned int last_age_weight;
 
 	/* basic filesystem units */
 	unsigned int log_sectors_per_block;	/* log2 sectors per block */
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index 83a366f3ee80..a70cf674d8e7 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -686,6 +686,15 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
 		return count;
 	}
 
+	if (!strcmp(a->attr.name, "last_age_weight")) {
+		if (t <= 0 || t >= 100)
+			return -EINVAL;
+		if (t == *ui)
+			return count;
+		*ui = (unsigned int)t;
+		return count;
+	}
+
 	*ui = (unsigned int)t;
 
 	return count;
@@ -944,6 +953,7 @@ F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, revoked_atomic_block, revoked_atomic_block)
 /* For block age extent cache */
 F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, hot_data_age_threshold, hot_data_age_threshold);
 F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, warm_data_age_threshold, warm_data_age_threshold);
+F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, last_age_weight, last_age_weight);
 
 #define ATTR_LIST(name) (&f2fs_attr_##name.attr)
 static struct attribute *f2fs_attrs[] = {
@@ -1042,6 +1052,7 @@ static struct attribute *f2fs_attrs[] = {
 	ATTR_LIST(revoked_atomic_block),
 	ATTR_LIST(hot_data_age_threshold),
 	ATTR_LIST(warm_data_age_threshold),
+	ATTR_LIST(last_age_weight),
 	NULL,
 };
 ATTRIBUTE_GROUPS(f2fs);
-- 
2.36.1

