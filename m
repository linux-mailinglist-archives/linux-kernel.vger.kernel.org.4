Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB01B67C39B
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 04:34:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229457AbjAZDeX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 22:34:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236248AbjAZDeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 22:34:15 -0500
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D27E46D42;
        Wed, 25 Jan 2023 19:34:10 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id EBFE75C05BC;
        Wed, 25 Jan 2023 22:34:09 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Wed, 25 Jan 2023 22:34:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        invisiblethingslab.com; h=cc:cc:content-transfer-encoding:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm3; t=
        1674704049; x=1674790449; bh=x0BohMGPEmmAQv3ZigspASmDgPSDsM1UcU2
        Bewuui3w=; b=shU7A7QoonmUIxllylGbEv6EGhkh3ywZhyPtFTIJi9Cge9Hx9Ls
        UhlSQF2iUaG6BwKSu3h0FPwfliYXD4a8HP87jwCImKMcJA14E7ZDcDYPkNl6ZG2T
        /n75zWlQAsBnaIMRX/7uFYTPNKL20RcmCeuHCmZaPUBtaECY4I/yt2PIIU0+hiE+
        XxtdD4XKor0xsD6NrdHklI+NDC27+/E/sX3Pc0+1ApGiqOr3HZnFYwEarK1lFlhq
        1nqTlZH8mg/y2IpjNYDyDg+S3hSVjG39PXN8RAwpHOkFJeE5lzlBXn4J0NlNDdnD
        P8ewJ4cUaysdFp2K0nPW3ddIUwVz4Zu99xQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1674704049; x=1674790449; bh=x0BohMGPEmmAQ
        v3ZigspASmDgPSDsM1UcU2Bewuui3w=; b=dSggqvsLBPqOQbwC+RWEeOIhmcoRT
        4MX2VBxayPzSZP0MIgy/eWWdbnXC+gSo9R/9PI/YLYBrhhcQliJtRtIySnOt+szp
        3I+23QWpvJiqcCRmVtPLAIQA2zCEfK7GJQlsKg5UVFpHP/m1TliE4zdxLHC3ZXD/
        xdg80sFRzQW4wnari/b4m7NUE3ooE2PzI0DAEw/3jL4c6LEPbGLWO1Qh9nINu0Nc
        EzCJlclWFJMEIJKvp2dK0bI6Cy50yQYYGrkLSOa1nTVxE+khbACOxhpJwAoFGoKR
        jPlKDmMugkqE32uOvxf2i519UuBqPi16f8y75Q4+pTT3+IvUyop08xzSA==
X-ME-Sender: <xms:sfTRY9qpfS4unN-oG_sfX_RvAodQGAKVhiSMY08k39M5J-dC_5XI1A>
    <xme:sfTRY_pJCZvLBMCfuhQDJfaMuCwkRI1B8N1YH7K8K641Tc_6CON6hd9bBD0DVhArj
    KesfMoRAoHkdJA>
X-ME-Received: <xmr:sfTRY6NzQ1HB2TzHCukYtzQq3pUswSiDndmEdvF1HlhxoKDPqEu9YMk2UqRa-IgDiYzrpARbSXMx>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddvfedgheekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepffgvmhhi
    ucforghrihgvucfqsggvnhhouhhruceouggvmhhisehinhhvihhsihgslhgvthhhihhngh
    hslhgrsgdrtghomheqnecuggftrfgrthhtvghrnhepjeffjefggfeugeduvedvjeekgfeh
    gffhhfffjeetkeelueefffetfffhtdduheetnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepuggvmhhisehinhhvihhsihgslhgvthhhihhnghhs
    lhgrsgdrtghomh
X-ME-Proxy: <xmx:sfTRY44axGy_vEpaydEMvuJv3aAmNQb4RtCr1eiezO13Zn9a5JkHbA>
    <xmx:sfTRY86mhlp4thAtALntivo-41VIJ_MchsA-zeQY63SQ-FbUPbDD4A>
    <xmx:sfTRYwi2AHClU9M9JEQY-WwJ45LWgJ0r-DjiTgzovyKW-asw3OE1hA>
    <xmx:sfTRY8F_hhevGgA7c7I2BthT8CbLWC_HDk0LQ1hxvzObsOWYkEupng>
Feedback-ID: iac594737:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Jan 2023 22:34:09 -0500 (EST)
From:   Demi Marie Obenour <demi@invisiblethingslab.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Demi Marie Obenour <demi@invisiblethingslab.com>,
        =?UTF-8?q?Marek=20Marczykowski-G=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/7] block: Support creating a struct file from a block device
Date:   Wed, 25 Jan 2023 22:33:53 -0500
Message-Id: <20230126033358.1880-2-demi@invisiblethingslab.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230126033358.1880-1-demi@invisiblethingslab.com>
References: <20230126033358.1880-1-demi@invisiblethingslab.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The newly added blkdev_get_file() function allows kernel code to create
a struct file for any block device.  The main use-case is for the
struct file to be exposed to userspace as a file descriptor.  A future
patch will modify the DM_DEV_CREATE_CREATE ioctl to allow userspace to
get a file descriptor to the newly created block device, avoiding nasty
race conditions.

Signed-off-by: Demi Marie Obenour <demi@invisiblethingslab.com>
---
 block/bdev.c           | 77 +++++++++++++++++++++++++++++++++++-------
 include/linux/blkdev.h |  5 +++
 2 files changed, 70 insertions(+), 12 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index edc110d90df4041e7d337976951bd0d17525f1f7..09cb5ef900ca9ad5b21250bb63e64cc2a79f9289 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -459,10 +459,33 @@ static struct file_system_type bd_type = {
 struct super_block *blockdev_superblock __read_mostly;
 EXPORT_SYMBOL_GPL(blockdev_superblock);
 
+static struct vfsmount *bd_mnt __read_mostly;
+
+struct file *
+blkdev_get_file(struct block_device *bdev, fmode_t flags, void *holder)
+{
+	struct inode *inode;
+	struct file *filp;
+	int ret;
+
+	ret = blkdev_do_open(bdev, flags, holder);
+	if (ret)
+		return ERR_PTR(ret);
+	inode = bdev->bd_inode;
+	filp = alloc_file_pseudo(inode, bd_mnt, "[block]", flags | O_CLOEXEC, &def_blk_fops);
+	if (IS_ERR(filp)) {
+		blkdev_put(bdev, flags);
+	} else {
+		filp->f_mapping = inode->i_mapping;
+		filp->f_wb_err = filemap_sample_wb_err(filp->f_mapping);
+	}
+	return filp;
+}
+EXPORT_SYMBOL(blkdev_get_file);
+
 void __init bdev_cache_init(void)
 {
 	int err;
-	static struct vfsmount *bd_mnt;
 
 	bdev_cachep = kmem_cache_create("bdev_cache", sizeof(struct bdev_inode),
 			0, (SLAB_HWCACHE_ALIGN|SLAB_RECLAIM_ACCOUNT|
@@ -775,7 +798,7 @@ void blkdev_put_no_open(struct block_device *bdev)
  *
  * Use this interface ONLY if you really do not have anything better - i.e. when
  * you are behind a truly sucky interface and all you are given is a device
- * number.  Everything else should use blkdev_get_by_path().
+ * number.  Everything else should use blkdev_get_by_path() or blkdev_do_open().
  *
  * CONTEXT:
  * Might sleep.
@@ -785,9 +808,7 @@ void blkdev_put_no_open(struct block_device *bdev)
  */
 struct block_device *blkdev_get_by_dev(dev_t dev, fmode_t mode, void *holder)
 {
-	bool unblock_events = true;
 	struct block_device *bdev;
-	struct gendisk *disk;
 	int ret;
 
 	ret = devcgroup_check_permission(DEVCG_DEV_BLOCK,
@@ -800,18 +821,52 @@ struct block_device *blkdev_get_by_dev(dev_t dev, fmode_t mode, void *holder)
 	bdev = blkdev_get_no_open(dev);
 	if (!bdev)
 		return ERR_PTR(-ENXIO);
-	disk = bdev->bd_disk;
+
+	ret = blkdev_do_open(bdev, mode, holder);
+	if (ret) {
+		blkdev_put_no_open(bdev);
+		return ERR_PTR(ret);
+	}
+
+	return bdev;
+}
+EXPORT_SYMBOL(blkdev_get_by_dev);
+
+/**
+ * blkdev_do_open - open a block device by device pointer
+ * @bdev: pointer to the device to open
+ * @mode: FMODE_* mask
+ * @holder: exclusive holder identifier
+ *
+ * Open the block device pointed to by @bdev. If @mode includes
+ * %FMODE_EXCL, the block device is opened with exclusive access.  Specifying
+ * %FMODE_EXCL with a %NULL @holder is invalid.  Exclusive opens may nest for
+ * the same @holder.
+ *
+ * Unlike blkdev_get_by_dev() and bldev_get_by_path(), this function does not
+ * do any permission checks.  The most common use-case is where the device
+ * was freshly created by userspace.
+ *
+ * CONTEXT:
+ * Might sleep.
+ *
+ * RETURNS:
+ * Reference 0 on success, -errno on failure.
+ */
+int blkdev_do_open(struct block_device *bdev, fmode_t mode, void *holder) {
+	struct gendisk *disk = bdev->bd_disk;
+	int ret = -ENXIO;
+	bool unblock_events = true;
 
 	if (mode & FMODE_EXCL) {
 		ret = bd_prepare_to_claim(bdev, holder);
 		if (ret)
-			goto put_blkdev;
+			return ret;
 	}
 
 	disk_block_events(disk);
 
 	mutex_lock(&disk->open_mutex);
-	ret = -ENXIO;
 	if (!disk_live(disk))
 		goto abort_claiming;
 	if (!try_module_get(disk->fops->owner))
@@ -842,7 +897,7 @@ struct block_device *blkdev_get_by_dev(dev_t dev, fmode_t mode, void *holder)
 
 	if (unblock_events)
 		disk_unblock_events(disk);
-	return bdev;
+	return 0;
 put_module:
 	module_put(disk->fops->owner);
 abort_claiming:
@@ -850,11 +905,9 @@ struct block_device *blkdev_get_by_dev(dev_t dev, fmode_t mode, void *holder)
 		bd_abort_claiming(bdev, holder);
 	mutex_unlock(&disk->open_mutex);
 	disk_unblock_events(disk);
-put_blkdev:
-	blkdev_put_no_open(bdev);
-	return ERR_PTR(ret);
+	return ret;
 }
-EXPORT_SYMBOL(blkdev_get_by_dev);
+EXPORT_SYMBOL(blkdev_do_open);
 
 /**
  * blkdev_get_by_path - open a block device by name
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 43d4e073b1115e4628a001081fbf08b296d342df..04635cb5ee29d22394a34c65eb34bea4e7847d8d 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -325,6 +325,11 @@ typedef int (*report_zones_cb)(struct blk_zone *zone, unsigned int idx,
 
 void disk_set_zoned(struct gendisk *disk, enum blk_zoned_model model);
 
+struct file *
+blkdev_get_file(struct block_device *bdev, fmode_t flags, void *holder);
+
+int blkdev_do_open(struct block_device *bdev, fmode_t flags, void *holder);
+
 #ifdef CONFIG_BLK_DEV_ZONED
 
 #define BLK_ALL_ZONES  ((unsigned int)-1)
-- 
Sincerely,
Demi Marie Obenour (she/her/hers)
Invisible Things Lab
