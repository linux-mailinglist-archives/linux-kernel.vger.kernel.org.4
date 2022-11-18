Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD0262F35F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 12:10:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241935AbiKRLKI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 06:10:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241819AbiKRLJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 06:09:38 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 238149A5E0;
        Fri, 18 Nov 2022 03:09:34 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4NDDZJ2FGCz4f3jZ3;
        Fri, 18 Nov 2022 19:09:28 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP1 (Coremail) with SMTP id cCh0CgBXTq3pZ3djfEnGAg--.30577S4;
        Fri, 18 Nov 2022 19:09:31 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     ming.lei@redhat.com, jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com
Subject: [PATCH RFC] scsi: core: remove unsed 'restarts' from scsi_device
Date:   Fri, 18 Nov 2022 19:30:52 +0800
Message-Id: <20221118113052.1324140-1-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgBXTq3pZ3djfEnGAg--.30577S4
X-Coremail-Antispam: 1UD129KBjvJXoWxCF1xZrW3tFykAF45WFy5XFb_yoW5ZFWfp3
        9IqanIyrWfWr48W3s5Xr4UXF1Yg3yj9345WFWxK34rWasFkryrAw1ktr15XFy8JrWvyF1D
        AFsrZFWkWr4qqrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUym14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
        6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
        0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
        jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
        1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxAIw28IcxkI7VAKI48J
        MxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwV
        AFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv2
        0xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4
        v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E
        14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0JUdHUDUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

During code review, I found that 'restarts' is not useful anymore after
the following commits:

1) commit ab3cee3762e5 ("blk-mq: In blk_mq_dispatch_rq_list() "no budget"
is a reason to kick")
2) commit d3b38596875d ("blk-mq: run queue no matter whether the request
is the last request")
3) commit 673235f91531 ("scsi: core: Fix race between handling STS_RESOURCE
and completion")

Now that if get budget ever failed, block layer will make sure to
trigger new run queue for the hctx. Hence there is no need to run queue
from scsi layer in this case.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/scsi/scsi_lib.c    | 35 -----------------------------------
 include/scsi/scsi_device.h |  1 -
 2 files changed, 36 deletions(-)

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 56f641ba1261..f6325a0f80fb 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -507,24 +507,6 @@ static void scsi_run_queue_async(struct scsi_device *sdev)
 	if (scsi_target(sdev)->single_lun ||
 	    !list_empty(&sdev->host->starved_list)) {
 		kblockd_schedule_work(&sdev->requeue_work);
-	} else {
-		/*
-		 * smp_mb() present in sbitmap_queue_clear() or implied in
-		 * .end_io is for ordering writing .device_busy in
-		 * scsi_device_unbusy() and reading sdev->restarts.
-		 */
-		int old = atomic_read(&sdev->restarts);
-
-		/*
-		 * ->restarts has to be kept as non-zero if new budget
-		 *  contention occurs.
-		 *
-		 *  No need to run queue when either another re-run
-		 *  queue wins in updating ->restarts or a new budget
-		 *  contention occurs.
-		 */
-		if (old && atomic_cmpxchg(&sdev->restarts, old, 0) == old)
-			blk_mq_run_hw_queues(sdev->request_queue, true);
 	}
 }
 
@@ -1666,23 +1648,6 @@ static int scsi_mq_get_budget(struct request_queue *q)
 	if (token >= 0)
 		return token;
 
-	atomic_inc(&sdev->restarts);
-
-	/*
-	 * Orders atomic_inc(&sdev->restarts) and atomic_read(&sdev->device_busy).
-	 * .restarts must be incremented before .device_busy is read because the
-	 * code in scsi_run_queue_async() depends on the order of these operations.
-	 */
-	smp_mb__after_atomic();
-
-	/*
-	 * If all in-flight requests originated from this LUN are completed
-	 * before reading .device_busy, sdev->device_busy will be observed as
-	 * zero, then blk_mq_delay_run_hw_queues() will dispatch this request
-	 * soon. Otherwise, completion of one of these requests will observe
-	 * the .restarts flag, and the request queue will be run for handling
-	 * this request, see scsi_end_request().
-	 */
 	if (unlikely(scsi_device_busy(sdev) == 0 &&
 				!scsi_device_blocked(sdev)))
 		blk_mq_delay_run_hw_queues(sdev->request_queue, SCSI_QUEUE_DELAY);
diff --git a/include/scsi/scsi_device.h b/include/scsi/scsi_device.h
index 24bdbf7999ab..66345de80897 100644
--- a/include/scsi/scsi_device.h
+++ b/include/scsi/scsi_device.h
@@ -115,7 +115,6 @@ struct scsi_device {
 	struct sbitmap budget_map;
 	atomic_t device_blocked;	/* Device returned QUEUE_FULL. */
 
-	atomic_t restarts;
 	spinlock_t list_lock;
 	struct list_head starved_entry;
 	unsigned short queue_depth;	/* How deep of a queue we want */
-- 
2.31.1

