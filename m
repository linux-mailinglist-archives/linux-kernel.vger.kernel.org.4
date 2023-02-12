Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BACB6936A4
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Feb 2023 10:03:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbjBLJDP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 04:03:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjBLJDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 04:03:06 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2FE41285E;
        Sun, 12 Feb 2023 01:03:02 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4PF1hd1FHvz4f3jLp;
        Sun, 12 Feb 2023 17:02:57 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP3 (Coremail) with SMTP id _Ch0CgCHgR9Bq+hjpfqtDA--.47546S5;
        Sun, 12 Feb 2023 17:02:59 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     hch@infradead.org, jack@suse.cz, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH -next RFC 1/3] block: Revert "block: Do not reread partition table on exclusively open device"
Date:   Sun, 12 Feb 2023 17:26:39 +0800
Message-Id: <20230212092641.2394146-2-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230212092641.2394146-1-yukuai1@huaweicloud.com>
References: <20230212092641.2394146-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgCHgR9Bq+hjpfqtDA--.47546S5
X-Coremail-Antispam: 1UD129KBjvJXoWxWr13GF15KFyUCw4UAFykGrg_yoWrXw15pF
        y5AFZ0yrWUGrZ2gFy0ya1kZw1ftwsrt3yxArWxG34SqF9xAr9FkF9Yk3yUZryrJrZ7XF47
        Zr15Xry0kFyxAFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9v14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
        x26xkF7I0E14v26r1I6r4UM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UM2
        8EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AI
        xVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20x
        vE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xv
        r2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxAIw28IcxkI7VAKI48JMxC20s
        026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_
        JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14
        v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xva
        j40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JV
        W8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbec_DUUUUU==
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

This reverts commit 36369f46e91785688a5f39d7a5590e3f07981316.

This patch can't fix the problem in a corner case that device can be
opened exclusively after the checking and before blkdev_get_by_dev().
We'll use a new solution to fix the problem in following patches, and
the new solution doesn't need to change apis.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk.h   |  2 +-
 block/genhd.c |  7 ++-----
 block/ioctl.c | 13 ++++++-------
 3 files changed, 9 insertions(+), 13 deletions(-)

diff --git a/block/blk.h b/block/blk.h
index 8900001946c7..a8ac9803fcb3 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -426,7 +426,7 @@ int bio_add_hw_page(struct request_queue *q, struct bio *bio,
 
 struct request_queue *blk_alloc_queue(int node_id);
 
-int disk_scan_partitions(struct gendisk *disk, fmode_t mode, void *owner);
+int disk_scan_partitions(struct gendisk *disk, fmode_t mode);
 
 int disk_alloc_events(struct gendisk *disk);
 void disk_add_events(struct gendisk *disk);
diff --git a/block/genhd.c b/block/genhd.c
index 52d71a94a809..075d8da284f5 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -356,7 +356,7 @@ void disk_uevent(struct gendisk *disk, enum kobject_action action)
 }
 EXPORT_SYMBOL_GPL(disk_uevent);
 
-int disk_scan_partitions(struct gendisk *disk, fmode_t mode, void *owner)
+int disk_scan_partitions(struct gendisk *disk, fmode_t mode)
 {
 	struct block_device *bdev;
 
@@ -366,9 +366,6 @@ int disk_scan_partitions(struct gendisk *disk, fmode_t mode, void *owner)
 		return -EINVAL;
 	if (disk->open_partitions)
 		return -EBUSY;
-	/* Someone else has bdev exclusively open? */
-	if (disk->part0->bd_holder && disk->part0->bd_holder != owner)
-		return -EBUSY;
 
 	set_bit(GD_NEED_PART_SCAN, &disk->state);
 	bdev = blkdev_get_by_dev(disk_devt(disk), mode, NULL);
@@ -498,7 +495,7 @@ int __must_check device_add_disk(struct device *parent, struct gendisk *disk,
 
 		bdev_add(disk->part0, ddev->devt);
 		if (get_capacity(disk))
-			disk_scan_partitions(disk, FMODE_READ, NULL);
+			disk_scan_partitions(disk, FMODE_READ);
 
 		/*
 		 * Announce the disk and partitions after all partitions are
diff --git a/block/ioctl.c b/block/ioctl.c
index 96617512982e..6dd49d877584 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -467,10 +467,10 @@ static int blkdev_bszset(struct block_device *bdev, fmode_t mode,
  * user space. Note the separate arg/argp parameters that are needed
  * to deal with the compat_ptr() conversion.
  */
-static int blkdev_common_ioctl(struct file *file, fmode_t mode, unsigned cmd,
-			       unsigned long arg, void __user *argp)
+static int blkdev_common_ioctl(struct block_device *bdev, fmode_t mode,
+			       unsigned int cmd, unsigned long arg,
+			       void __user *argp)
 {
-	struct block_device *bdev = I_BDEV(file->f_mapping->host);
 	unsigned int max_sectors;
 
 	switch (cmd) {
@@ -528,8 +528,7 @@ static int blkdev_common_ioctl(struct file *file, fmode_t mode, unsigned cmd,
 			return -EACCES;
 		if (bdev_is_partition(bdev))
 			return -EINVAL;
-		return disk_scan_partitions(bdev->bd_disk, mode & ~FMODE_EXCL,
-					    file);
+		return disk_scan_partitions(bdev->bd_disk, mode & ~FMODE_EXCL);
 	case BLKTRACESTART:
 	case BLKTRACESTOP:
 	case BLKTRACETEARDOWN:
@@ -607,7 +606,7 @@ long blkdev_ioctl(struct file *file, unsigned cmd, unsigned long arg)
 		break;
 	}
 
-	ret = blkdev_common_ioctl(file, mode, cmd, arg, argp);
+	ret = blkdev_common_ioctl(bdev, mode, cmd, arg, argp);
 	if (ret != -ENOIOCTLCMD)
 		return ret;
 
@@ -676,7 +675,7 @@ long compat_blkdev_ioctl(struct file *file, unsigned cmd, unsigned long arg)
 		break;
 	}
 
-	ret = blkdev_common_ioctl(file, mode, cmd, arg, argp);
+	ret = blkdev_common_ioctl(bdev, mode, cmd, arg, argp);
 	if (ret == -ENOIOCTLCMD && disk->fops->compat_ioctl)
 		ret = disk->fops->compat_ioctl(bdev, mode, cmd, arg);
 
-- 
2.31.1

