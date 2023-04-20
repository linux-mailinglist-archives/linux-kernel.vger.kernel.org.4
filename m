Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 005A16E92C7
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 13:32:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234679AbjDTLb6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 07:31:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233978AbjDTLbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 07:31:44 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FACBE75;
        Thu, 20 Apr 2023 04:31:20 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Q2Fpn1d4tz4f3mLX;
        Thu, 20 Apr 2023 19:31:13 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgCnD7OAIkFkVY8hHw--.17021S6;
        Thu, 20 Apr 2023 19:31:14 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     song@kernel.org, neilb@suse.de, akpm@osdl.org
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH -next 2/8] md/raid1-10: rename raid1-10.c to raid1-10.h
Date:   Thu, 20 Apr 2023 19:29:40 +0800
Message-Id: <20230420112946.2869956-3-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230420112946.2869956-1-yukuai1@huaweicloud.com>
References: <20230420112946.2869956-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgCnD7OAIkFkVY8hHw--.17021S6
X-Coremail-Antispam: 1UD129KBjvJXoWxAw1DXw1UJFWUKrW3GryxAFb_yoW5tFWDpa
        1DJry3Z3yUGayUua4DX34UuFy3C3Z8K3yUCFykuws5ZFy3XFW0qa1Utay5WF1DZF4rGFy7
        tryDKw4UCF1FqFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9m14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
        x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
        A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
        0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
        IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
        Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20xvY0x0EwIxGrwCFx2
        IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v2
        6r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67
        AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IY
        s7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr
        0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUc6pPUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        MAY_BE_FORGED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

raid1-10.c contains definitions that are used both for raid1 and raid10,
it's werid to use ".c" suffix.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/{raid1-10.c => raid1-10.h} | 10 +++++++---
 drivers/md/raid1.c                    |  2 --
 drivers/md/raid1.h                    |  2 ++
 drivers/md/raid10.c                   |  2 --
 drivers/md/raid10.h                   |  2 ++
 5 files changed, 11 insertions(+), 7 deletions(-)
 rename drivers/md/{raid1-10.c => raid1-10.h} (92%)

diff --git a/drivers/md/raid1-10.c b/drivers/md/raid1-10.h
similarity index 92%
rename from drivers/md/raid1-10.c
rename to drivers/md/raid1-10.h
index e61f6cad4e08..04beef35142d 100644
--- a/drivers/md/raid1-10.c
+++ b/drivers/md/raid1-10.h
@@ -1,4 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
+#ifndef _RAID1_10_H
+#define _RAID1_10_H
+
 /* Maximum size of each resync request */
 #define RESYNC_BLOCK_SIZE (64*1024)
 #define RESYNC_PAGES ((RESYNC_BLOCK_SIZE + PAGE_SIZE-1) / PAGE_SIZE)
@@ -33,7 +36,7 @@ struct raid1_plug_cb {
 	struct bio_list		pending;
 };
 
-static void rbio_pool_free(void *rbio, void *data)
+static inline void rbio_pool_free(void *rbio, void *data)
 {
 	kfree(rbio);
 }
@@ -91,8 +94,8 @@ static inline struct resync_pages *get_resync_pages(struct bio *bio)
 }
 
 /* generally called after bio_reset() for reseting bvec */
-static void md_bio_reset_resync_pages(struct bio *bio, struct resync_pages *rp,
-			       int size)
+static inline void md_bio_reset_resync_pages(struct bio *bio,
+					     struct resync_pages *rp, int size)
 {
 	int idx = 0;
 
@@ -109,3 +112,4 @@ static void md_bio_reset_resync_pages(struct bio *bio, struct resync_pages *rp,
 		size -= len;
 	} while (idx++ < RESYNC_PAGES && size > 0);
 }
+#endif
diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index 2f1011ffdf09..84724b9b20b8 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -49,8 +49,6 @@ static void lower_barrier(struct r1conf *conf, sector_t sector_nr);
 #define raid1_log(md, fmt, args...)				\
 	do { if ((md)->queue) blk_add_trace_msg((md)->queue, "raid1 " fmt, ##args); } while (0)
 
-#include "raid1-10.c"
-
 #define START(node) ((node)->start)
 #define LAST(node) ((node)->last)
 INTERVAL_TREE_DEFINE(struct serial_info, node, sector_t, _subtree_last,
diff --git a/drivers/md/raid1.h b/drivers/md/raid1.h
index 468f189da7a0..80de4d66f010 100644
--- a/drivers/md/raid1.h
+++ b/drivers/md/raid1.h
@@ -2,6 +2,8 @@
 #ifndef _RAID1_H
 #define _RAID1_H
 
+#include "raid1-10.h"
+
 /*
  * each barrier unit size is 64MB fow now
  * note: it must be larger than RESYNC_DEPTH
diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index a116b7c9d9f3..50d56b6af42f 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -77,8 +77,6 @@ static void end_reshape(struct r10conf *conf);
 #define raid10_log(md, fmt, args...)				\
 	do { if ((md)->queue) blk_add_trace_msg((md)->queue, "raid10 " fmt, ##args); } while (0)
 
-#include "raid1-10.c"
-
 #define NULL_CMD
 #define cmd_before(conf, cmd) \
 	do { \
diff --git a/drivers/md/raid10.h b/drivers/md/raid10.h
index 63e48b11b552..63e88dd774f7 100644
--- a/drivers/md/raid10.h
+++ b/drivers/md/raid10.h
@@ -2,6 +2,8 @@
 #ifndef _RAID10_H
 #define _RAID10_H
 
+#include "raid1-10.h"
+
 /* Note: raid10_info.rdev can be set to NULL asynchronously by
  * raid10_remove_disk.
  * There are three safe ways to access raid10_info.rdev.
-- 
2.39.2

