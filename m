Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD22B714A3C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 15:24:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbjE2NY1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 09:24:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjE2NYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 09:24:20 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A8EDB7;
        Mon, 29 May 2023 06:24:18 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QVGT967V1z4f454c;
        Mon, 29 May 2023 21:24:13 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgAHvbB9p3RkWVPoKQ--.23397S5;
        Mon, 29 May 2023 21:24:14 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     guoqing.jiang@linux.dev, agk@redhat.com, snitzer@kernel.org,
        dm-devel@redhat.com, song@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH -next v2 1/6] Revert "md: unlock mddev before reap sync_thread in action_store"
Date:   Mon, 29 May 2023 21:20:32 +0800
Message-Id: <20230529132037.2124527-2-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230529132037.2124527-1-yukuai1@huaweicloud.com>
References: <20230529132037.2124527-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAHvbB9p3RkWVPoKQ--.23397S5
X-Coremail-Antispam: 1UD129KBjvJXoWxWr1ftF18AF45XF15ZF18Krg_yoWrKr43p3
        yfJF9xJrWUArW3ZrWUJa4DXay5Zw1jq3yqyrWfW34fJw1fKr43G345uFyUZFyDJas5Zw4a
        qayrJFWrZFW09r7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPY14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
        x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
        A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
        0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
        IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
        Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
        xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v2
        6r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2
        Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_
        Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr
        1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUTHqxU
        UUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        MAY_BE_FORGED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

This reverts commit 9dfbdafda3b34e262e43e786077bab8e476a89d1.

Because it will introduce a defect that sync_thread can be running while
MD_RECOVERY_RUNNING is cleared, which will cause some unexpected problems,
for example:

list_add corruption. prev->next should be next (ffff0001ac1daba0), but was ffff0000ce1a02a0. (prev=ffff0000ce1a02a0).
Call trace:
 __list_add_valid+0xfc/0x140
 insert_work+0x78/0x1a0
 __queue_work+0x500/0xcf4
 queue_work_on+0xe8/0x12c
 md_check_recovery+0xa34/0xf30
 raid10d+0xb8/0x900 [raid10]
 md_thread+0x16c/0x2cc
 kthread+0x1a4/0x1ec
 ret_from_fork+0x10/0x18

This is because work is requeued while it's still inside workqueue:

t1:			t2:
action_store
 mddev_lock
  if (mddev->sync_thread)
   mddev_unlock
   md_unregister_thread
   // first sync_thread is done
			md_check_recovery
			 mddev_try_lock
			 /*
			  * once MD_RECOVERY_DONE is set, new sync_thread
			  * can start.
			  */
			 set_bit(MD_RECOVERY_RUNNING, &mddev->recovery)
			 INIT_WORK(&mddev->del_work, md_start_sync)
			 queue_work(md_misc_wq, &mddev->del_work)
			  test_and_set_bit(WORK_STRUCT_PENDING_BIT, ...)
			  // set pending bit
			  insert_work
			   list_add_tail
			 mddev_unlock
   mddev_lock_nointr
   md_reap_sync_thread
   // MD_RECOVERY_RUNNING is cleared
 mddev_unlock

t3:

// before queued work started from t2
md_check_recovery
 // MD_RECOVERY_RUNNING is not set, a new sync_thread can be started
 INIT_WORK(&mddev->del_work, md_start_sync)
  work->data = 0
  // work pending bit is cleared
 queue_work(md_misc_wq, &mddev->del_work)
  insert_work
   list_add_tail
   // list is corrupted

The above commit is reverted to fix the problem, the deadlock this
commit tries to fix will be fixed in following patches.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/dm-raid.c |  1 -
 drivers/md/md.c      | 19 ++-----------------
 2 files changed, 2 insertions(+), 18 deletions(-)

diff --git a/drivers/md/dm-raid.c b/drivers/md/dm-raid.c
index 8846bf510a35..1f22bef27841 100644
--- a/drivers/md/dm-raid.c
+++ b/drivers/md/dm-raid.c
@@ -3725,7 +3725,6 @@ static int raid_message(struct dm_target *ti, unsigned int argc, char **argv,
 	if (!strcasecmp(argv[0], "idle") || !strcasecmp(argv[0], "frozen")) {
 		if (mddev->sync_thread) {
 			set_bit(MD_RECOVERY_INTR, &mddev->recovery);
-			md_unregister_thread(&mddev->sync_thread);
 			md_reap_sync_thread(mddev);
 		}
 	} else if (decipher_sync_action(mddev, mddev->recovery) != st_idle)
diff --git a/drivers/md/md.c b/drivers/md/md.c
index a5a7af2f4e59..9b97731e1fe4 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -4772,19 +4772,6 @@ action_store(struct mddev *mddev, const char *page, size_t len)
 			if (work_pending(&mddev->del_work))
 				flush_workqueue(md_misc_wq);
 			if (mddev->sync_thread) {
-				sector_t save_rp = mddev->reshape_position;
-
-				mddev_unlock(mddev);
-				set_bit(MD_RECOVERY_INTR, &mddev->recovery);
-				md_unregister_thread(&mddev->sync_thread);
-				mddev_lock_nointr(mddev);
-				/*
-				 * set RECOVERY_INTR again and restore reshape
-				 * position in case others changed them after
-				 * got lock, eg, reshape_position_store and
-				 * md_check_recovery.
-				 */
-				mddev->reshape_position = save_rp;
 				set_bit(MD_RECOVERY_INTR, &mddev->recovery);
 				md_reap_sync_thread(mddev);
 			}
@@ -6184,7 +6171,6 @@ static void __md_stop_writes(struct mddev *mddev)
 		flush_workqueue(md_misc_wq);
 	if (mddev->sync_thread) {
 		set_bit(MD_RECOVERY_INTR, &mddev->recovery);
-		md_unregister_thread(&mddev->sync_thread);
 		md_reap_sync_thread(mddev);
 	}
 
@@ -9336,7 +9322,6 @@ void md_check_recovery(struct mddev *mddev)
 			 * ->spare_active and clear saved_raid_disk
 			 */
 			set_bit(MD_RECOVERY_INTR, &mddev->recovery);
-			md_unregister_thread(&mddev->sync_thread);
 			md_reap_sync_thread(mddev);
 			clear_bit(MD_RECOVERY_RECOVER, &mddev->recovery);
 			clear_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
@@ -9372,7 +9357,6 @@ void md_check_recovery(struct mddev *mddev)
 			goto unlock;
 		}
 		if (mddev->sync_thread) {
-			md_unregister_thread(&mddev->sync_thread);
 			md_reap_sync_thread(mddev);
 			goto unlock;
 		}
@@ -9452,7 +9436,8 @@ void md_reap_sync_thread(struct mddev *mddev)
 	sector_t old_dev_sectors = mddev->dev_sectors;
 	bool is_reshaped = false;
 
-	/* sync_thread should be unregistered, collect result */
+	/* resync has finished, collect result */
+	md_unregister_thread(&mddev->sync_thread);
 	if (!test_bit(MD_RECOVERY_INTR, &mddev->recovery) &&
 	    !test_bit(MD_RECOVERY_REQUESTED, &mddev->recovery) &&
 	    mddev->degraded != mddev->raid_disks) {
-- 
2.39.2

