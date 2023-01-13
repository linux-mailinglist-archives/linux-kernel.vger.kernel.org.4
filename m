Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDD6466981D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 14:12:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241062AbjAMNMJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 08:12:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241254AbjAMNLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 08:11:30 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3E293D1D7
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 04:59:27 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id d3so23339775plr.10
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 04:59:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b2GF+E99ye3xLBw4zeGrDxAlN/CsQQRneamSV4aiYR4=;
        b=BsnEKympesLjhjKzcF7dnJQ9q6uo10MBwf3i43l25qQ8YIWtuAk4/nHk/Uc5+cP/MI
         Q5QSCh/0CWd/HvNVuLdpo9sp+LP8Briac8tQKiewm2Da5zfHtsIzY3xQVmSNU/T5cq94
         D+j3MnHg4mbEoaG+ylBBC0axJzMFjotSKtw6cH5esqiUxGICyIkNLVRSTUVZUVFFfGtf
         yptK0YSr3OJBRe/2MMtci6dqdGCHKY4449sjx35MGu1bd6GcIISgD98X9ehLvVvtdB3o
         Q4MtPcN1CdbOamcR8eCARC1DEmD1dcOh+znxTkcbIed2nCGgS18IKWAFTpRz5grQ4vhC
         JZgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b2GF+E99ye3xLBw4zeGrDxAlN/CsQQRneamSV4aiYR4=;
        b=v4/QziDycReGxn427LUCIs5QqwJXNfJigSAG/qr+m/U7MgKtly2Px12SyibA3tV+4d
         +CbW8dhOl1okeurclYDg5mUtNVPaaaoBV+jXDh51pZll+MDALBgQq3/CfDwbnzmj5fyW
         Kwe7hQTjWqjhj8Jc7134XDlMG3xqAVoRmsuvgEH5VA6iQbJ6u/7HFMq6WtzueMIoMxga
         OZuyuY29V11zspI9Am+wM57HYV7w152vmiQZOOEDXJ6Uz7LgwwARh/bU/XvvOTczz8Xv
         yyMkecFTrbe0+g4b5oEhD8Hg12gPxzuAQdcE/0BmnqaC6gtjA7fHiEh582q0DhtXnZLG
         30bw==
X-Gm-Message-State: AFqh2ko/v+cT91GuteyEFTF4EZUXdwQqg9te7F2rogOQN9Rv2FpaaWln
        vIPpP2rRpuzOVyOUNRtAkxc=
X-Google-Smtp-Source: AMrXdXuo4ba/iGhBairsFpgRykdngEw56L219YrKDMjOuHM8gKF2vVZjhDGnuzCJrHhCv3Y+hXb7fA==
X-Received: by 2002:a17:902:a70c:b0:189:dcc3:e4a1 with SMTP id w12-20020a170902a70c00b00189dcc3e4a1mr78888035plq.9.1673614767155;
        Fri, 13 Jan 2023 04:59:27 -0800 (PST)
Received: from mi-HP-ProDesk-680-G4-MT.mioffice.cn ([43.224.245.252])
        by smtp.gmail.com with ESMTPSA id j3-20020a170903028300b001944bf0b57asm5453820plr.204.2023.01.13.04.59.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Jan 2023 04:59:26 -0800 (PST)
From:   qixiaoyu1 <qxy65535@gmail.com>
X-Google-Original-From: qixiaoyu1 <qixiaoyu1@xiaomi.com>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, xiongping1@xiaomi.com,
        qixiaoyu1 <qixiaoyu1@xiaomi.com>
Subject: [PATCH 2/2] f2fs: add sysfs nodes to set last_age_weight
Date:   Fri, 13 Jan 2023 20:58:59 +0800
Message-Id: <20230113125859.15651-2-qixiaoyu1@xiaomi.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20230113125859.15651-1-qixiaoyu1@xiaomi.com>
References: <20230113125859.15651-1-qixiaoyu1@xiaomi.com>
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
---
 Documentation/ABI/testing/sysfs-fs-f2fs |  5 +++++
 fs/f2fs/extent_cache.c                  | 11 +++++++----
 fs/f2fs/f2fs.h                          |  1 +
 fs/f2fs/sysfs.c                         | 11 +++++++++++
 4 files changed, 24 insertions(+), 4 deletions(-)

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
index 93a1ab186517..47222a899385 100644
--- a/fs/f2fs/extent_cache.c
+++ b/fs/f2fs/extent_cache.c
@@ -871,10 +871,12 @@ void f2fs_update_read_extent_tree_range_compressed(struct inode *inode,
 }
 #endif
 
-static unsigned long long __calculate_block_age(unsigned long long new,
-						unsigned long long old)
+static unsigned long long __calculate_block_age(struct f2fs_sb_info *sbi,
+						unsigned long long new, unsigned long long old)
 {
-	return new - new / 100 * LAST_AGE_WEIGHT + old / 100 * LAST_AGE_WEIGHT;
+	unsigned int weight = sbi->last_age_weight;
+
+	return new - new / 100 * weight + old / 100 * weight;
 }
 
 /* This returns a new age and allocated blocks in ei */
@@ -906,7 +908,7 @@ static int __get_new_block_age(struct inode *inode, struct extent_info *ei,
 			cur_age = ULLONG_MAX - tei.last_blocks + cur_blocks;
 
 		if (tei.age)
-			ei->age = __calculate_block_age(cur_age, tei.age);
+			ei->age = __calculate_block_age(sbi, cur_age, tei.age);
 		else
 			ei->age = cur_age;
 		ei->last_blocks = cur_blocks;
@@ -1222,6 +1224,7 @@ void f2fs_init_extent_cache_info(struct f2fs_sb_info *sbi)
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

