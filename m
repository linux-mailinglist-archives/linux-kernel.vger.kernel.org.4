Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80D72716ED9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 22:33:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231665AbjE3Udf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 16:33:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233484AbjE3UdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 16:33:16 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B48CBE49;
        Tue, 30 May 2023 13:32:45 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 6EF803200934;
        Tue, 30 May 2023 16:32:12 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 30 May 2023 16:32:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        invisiblethingslab.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1685478732; x=1685565132; bh=KqvPH9pDDf
        rZerL/j1Q0a8RK2jTSm93zECezjcEfZ7Y=; b=CeUdXfyO67/whbrhgac9/avXLW
        eru7QHUZqMx94QYfPMlVXU+ui+tRFdwVPN9xlP9gICmNJdQalLaUVoS7Zc943wjC
        sJFZiHqqQBqawmzSq2uS5sj0kejzU2ucPIFyOcLtjPgoyrOKSyZ8v6CejqHwIIVf
        QhSSQhpepZN1qfTatTXNiFRN45qghiX/endy/GoXyAo4OF5DvAqSC+R4tvUZql/g
        Twf7nZVK/OZ+O5hzh/GEO/K+xp6lZGqfRa1L4ridR6SwKojehZihM4jei6a9/TkB
        0NXGvH2/Oo567MZ7sqO1hRGDy2T5AnJVIsGfHDdoKrXfptumV12qVDqo43kA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1685478732; x=
        1685565132; bh=KqvPH9pDDfrZerL/j1Q0a8RK2jTSm93zECezjcEfZ7Y=; b=x
        1E+gfj51gX0i5a8eh20dla4FZptdVnV/3RIPZB3nB5jAIbu455IAdaMdcicMgN6O
        4SBqvYe9KR4Kej10pm88BwhRbA3HJRbxH//tVjialFMNZJrovhqgY1UDyRu1wJcw
        QHLv45kgxPU7huWf9ipWhx6WsGloc+WqNO4rAhShCMykuP4wA6usnjDEyY/0gRna
        EhIOGzw6Zx9L9zjSbhcDkSFqBm1jjKHdeYRfdE5UB3scu3hnpjdt5yJterqlZrbv
        J5cY6BQYk5xcpeviB3QRy1CADT22E0N/XTiASKCzbXfOkz55iiiWUGOl+t2QGjsf
        0fnwF/t6q5vZO+QP/5VMg==
X-ME-Sender: <xms:S112ZFgm3IeHFi6lKr5FpH5jvpfxwO-emQ2czS7Pq9uDlsy9Fog8-Q>
    <xme:S112ZKB_RZTgfN8gOc3Qt1yLL0BLazY40yQ4kW6JyaHmpwYd6le27kfuoY0HNPe8q
    Bg1QVfpKaNzuu4>
X-ME-Received: <xmr:S112ZFFvIfFBGsSNVsyzjW3e8trWKGolRY9j-x5oH_a7oB_rpZIly3L0KUdHGO_X5tEjIbl3Z-4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeekjedgudeglecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeffvghm
    ihcuofgrrhhivgcuqfgsvghnohhurhcuoeguvghmihesihhnvhhishhisghlvghthhhinh
    hgshhlrggsrdgtohhmqeenucggtffrrghtthgvrhhnpeejffejgffgueegudevvdejkefg
    hefghffhffejteekleeufeffteffhfdtudehteenucevlhhushhtvghrufhiiigvpedvne
    curfgrrhgrmhepmhgrihhlfhhrohhmpeguvghmihesihhnvhhishhisghlvghthhhinhhg
    shhlrggsrdgtohhm
X-ME-Proxy: <xmx:S112ZKSXztYWhNh1MQVCl3fCY8DiKab0iHLF3aayTdVK2LoubaYlsA>
    <xmx:S112ZCytp1E3O_qW43L1mXgjApcSM6g_XRGwrav4Xg9SVmX7n86Qkw>
    <xmx:S112ZA7gcLfxJIeXwgaFf_QMQGleyKUVRN_r2UoxT_a0-RDhxoexxg>
    <xmx:TF12ZNwxjvc_-0yaKFm8hnvtR3BECga_Ld9X_kRH4r-5lLJDCs-ZAw>
Feedback-ID: iac594737:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 May 2023 16:32:11 -0400 (EDT)
From:   Demi Marie Obenour <demi@invisiblethingslab.com>
To:     Jens Axboe <axboe@kernel.dk>,
        =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com
Cc:     Demi Marie Obenour <demi@invisiblethingslab.com>,
        =?UTF-8?q?Marek=20Marczykowski-G=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org
Subject: [PATCH v2 13/16] xen-blkback: Implement diskseq checks
Date:   Tue, 30 May 2023 16:31:13 -0400
Message-Id: <20230530203116.2008-14-demi@invisiblethingslab.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230530203116.2008-1-demi@invisiblethingslab.com>
References: <20230530203116.2008-1-demi@invisiblethingslab.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows specifying a disk sequence number in XenStore.  If it does
not match the disk sequence number of the underlying device, the device
will not be exported and a warning will be logged.  Userspace can use
this to eliminate race conditions due to major/minor number reuse.
Old kernels do not support the new syntax, but a later patch will allow
userspace to discover that the new syntax is supported.

Signed-off-by: Demi Marie Obenour <demi@invisiblethingslab.com>
---
 drivers/block/xen-blkback/xenbus.c | 112 +++++++++++++++++++++++------
 1 file changed, 89 insertions(+), 23 deletions(-)

diff --git a/drivers/block/xen-blkback/xenbus.c b/drivers/block/xen-blkback/xenbus.c
index 4807af1d58059394d7a992335dabaf2bc3901721..9c3eb148fbd802c74e626c3d7bcd69dcb09bd921 100644
--- a/drivers/block/xen-blkback/xenbus.c
+++ b/drivers/block/xen-blkback/xenbus.c
@@ -24,6 +24,7 @@ struct backend_info {
 	struct xenbus_watch	backend_watch;
 	unsigned		major;
 	unsigned		minor;
+	unsigned long long	diskseq;
 	char			*mode;
 };
 
@@ -479,7 +480,7 @@ static void xen_vbd_free(struct xen_vbd *vbd)
 
 static int xen_vbd_create(struct xen_blkif *blkif, blkif_vdev_t handle,
 			  unsigned major, unsigned minor, int readonly,
-			  int cdrom)
+			  bool cdrom, u64 diskseq)
 {
 	struct xen_vbd *vbd;
 	struct block_device *bdev;
@@ -507,6 +508,26 @@ static int xen_vbd_create(struct xen_blkif *blkif, blkif_vdev_t handle,
 		xen_vbd_free(vbd);
 		return -ENOENT;
 	}
+
+	if (diskseq) {
+		struct gendisk *disk = bdev->bd_disk;
+
+		if (unlikely(disk == NULL)) {
+			pr_err("%s: device %08x has no gendisk\n",
+			       __func__, vbd->pdevice);
+			xen_vbd_free(vbd);
+			return -EFAULT;
+		}
+
+		if (unlikely(disk->diskseq != diskseq)) {
+			pr_warn("%s: device %08x has incorrect sequence "
+				"number 0x%llx (expected 0x%llx)\n",
+				__func__, vbd->pdevice, disk->diskseq, diskseq);
+			xen_vbd_free(vbd);
+			return -ENODEV;
+		}
+	}
+
 	vbd->size = vbd_sz(vbd);
 
 	if (cdrom || disk_to_cdi(vbd->bdev->bd_disk))
@@ -707,6 +728,9 @@ static void backend_changed(struct xenbus_watch *watch,
 	int cdrom = 0;
 	unsigned long handle;
 	char *device_type;
+	char *diskseq_str = NULL;
+	int diskseq_len;
+	unsigned long long diskseq;
 
 	pr_debug("%s %p %d\n", __func__, dev, dev->otherend_id);
 
@@ -725,10 +749,46 @@ static void backend_changed(struct xenbus_watch *watch,
 		return;
 	}
 
-	if (be->major | be->minor) {
-		if (be->major != major || be->minor != minor)
-			pr_warn("changing physical device (from %x:%x to %x:%x) not supported.\n",
-				be->major, be->minor, major, minor);
+	diskseq_str = xenbus_read(XBT_NIL, dev->nodename, "diskseq", &diskseq_len);
+	if (IS_ERR(diskseq_str)) {
+		int err = PTR_ERR(diskseq_str);
+		diskseq_str = NULL;
+
+		/*
+		 * If this does not exist, it means legacy userspace that does not
+		 * support diskseq.
+		 */
+		if (unlikely(!XENBUS_EXIST_ERR(err))) {
+			xenbus_dev_fatal(dev, err, "reading diskseq");
+			return;
+		}
+		diskseq = 0;
+	} else if (diskseq_len <= 0) {
+		xenbus_dev_fatal(dev, -EFAULT, "diskseq must not be empty");
+		goto fail;
+	} else if (diskseq_len > 16) {
+		xenbus_dev_fatal(dev, -ERANGE, "diskseq too long: got %d but limit is 16",
+				 diskseq_len);
+		goto fail;
+	} else if (diskseq_str[0] == '0') {
+		xenbus_dev_fatal(dev, -ERANGE, "diskseq must not start with '0'");
+		goto fail;
+	} else {
+		char *diskseq_end;
+		diskseq = simple_strtoull(diskseq_str, &diskseq_end, 16);
+		if (diskseq_end != diskseq_str + diskseq_len) {
+			xenbus_dev_fatal(dev, -EINVAL, "invalid diskseq");
+			goto fail;
+		}
+		kfree(diskseq_str);
+		diskseq_str = NULL;
+	}
+
+	if (be->major | be->minor | be->diskseq) {
+		if (be->major != major || be->minor != minor || be->diskseq != diskseq)
+			pr_warn("changing physical device (from %x:%x:%llx to %x:%x:%llx)"
+				" not supported.\n",
+				be->major, be->minor, be->diskseq, major, minor, diskseq);
 		return;
 	}
 
@@ -756,29 +816,35 @@ static void backend_changed(struct xenbus_watch *watch,
 
 	be->major = major;
 	be->minor = minor;
+	be->diskseq = diskseq;
 
 	err = xen_vbd_create(be->blkif, handle, major, minor,
-			     !strchr(be->mode, 'w'), cdrom);
-
-	if (err)
-		xenbus_dev_fatal(dev, err, "creating vbd structure");
-	else {
-		err = xenvbd_sysfs_addif(dev);
-		if (err) {
-			xen_vbd_free(&be->blkif->vbd);
-			xenbus_dev_fatal(dev, err, "creating sysfs entries");
-		}
-	}
+			     !strchr(be->mode, 'w'), cdrom, diskseq);
 
 	if (err) {
-		kfree(be->mode);
-		be->mode = NULL;
-		be->major = 0;
-		be->minor = 0;
-	} else {
-		/* We're potentially connected now */
-		xen_update_blkif_status(be->blkif);
+		xenbus_dev_fatal(dev, err, "creating vbd structure");
+		goto fail;
 	}
+
+	err = xenvbd_sysfs_addif(dev);
+	if (err) {
+		xenbus_dev_fatal(dev, err, "creating sysfs entries");
+		goto free_vbd;
+	}
+
+	/* We're potentially connected now */
+	xen_update_blkif_status(be->blkif);
+	return;
+
+free_vbd:
+	xen_vbd_free(&be->blkif->vbd);
+fail:
+	kfree(diskseq_str);
+	kfree(be->mode);
+	be->mode = NULL;
+	be->major = 0;
+	be->minor = 0;
+	be->diskseq = 0;
 }
 
 /*
-- 
Sincerely,
Demi Marie Obenour (she/her/hers)
Invisible Things Lab

