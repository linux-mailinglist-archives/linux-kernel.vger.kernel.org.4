Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE98B67C39E
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 04:34:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236485AbjAZDeb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 22:34:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236337AbjAZDeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 22:34:20 -0500
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72E4665EF0;
        Wed, 25 Jan 2023 19:34:14 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id CE38E5C05B8;
        Wed, 25 Jan 2023 22:34:13 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 25 Jan 2023 22:34:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        invisiblethingslab.com; h=cc:cc:content-transfer-encoding:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm3; t=
        1674704053; x=1674790453; bh=sHxeYo7zgfjFccvxCuuph95svfpElxK2vn8
        +J41Up4A=; b=adUQaXp/oYs3g7OS0f7kpq6+GmWpux+QVtFXmFgtDpZ+2VjYKeP
        9TItVn12LYJcNB5LUo9myKpUTXtUrub4Cu3SZHp9B+8vNaXlQInbcta8Jgb5Rdm3
        GDMdlpRs9T01yZ8uWOdhyDKShEL87ywJ2VNVgFYUH1bDwbHFK2dO0qr3yq0cvVFy
        3eoUWxCkpQavHyEfCY5wDHOBniqwVCTrJuMQ2SieXTo8oPvzh6pG7gmtGRGPdCnT
        tedZ2CBSXoGlenczbkKFo4+j/OkQjZR3Py3rH3eqHWaVVP0NndZ+GzPKlFzxNqkO
        myxdVg9hbn03ZDe/5l/5s9z/r+Y8ZAjNyBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1674704053; x=1674790453; bh=sHxeYo7zgfjFc
        cvxCuuph95svfpElxK2vn8+J41Up4A=; b=XIQCpZ3lX4/2fvGEl+smR04IQxUTp
        YuK64iAV32C+MVzzlelSu8NtBFy3/erKTDaWxxRgFI9OYqQVuQ/DJz9Tv+hoFKOm
        4FxRc/bDupPlBYUU4UYdCHegdxMEunUBGzNtYiKm9AtHfexmQpZVGpBIxAahaA1T
        fvGb/rfnrO7ezrUMGViTPOF1DjPNXbqTAxFzq3hW9JBb0TLR8dNXWzO1JOmt26Eb
        tvOejPXmncG8791tijP4bM4Kd9ujFo1RIPbMn81uxM3JiB5xsMiPNiHHrpZi1QYx
        Yea9SHaJ1U7hOEBIAMxH2y4mx1MZa2AwwK0EUaeLP30w2vkPrVQp9AZWw==
X-ME-Sender: <xms:tfTRY6RAol72fj1u1ITTzffjf13SuYDGvZJW2kpYz2bGieIW_GJMDg>
    <xme:tfTRY_z5TiiBtt-0BX8vAhX0ddJaRfaz7MQoewPgHdks3DUCcV7DWixXEkMi6HfQg
    yaK_fc4IaFHbzw>
X-ME-Received: <xmr:tfTRY30w6RETlzCYZ2lEM_tWt6QmFeDgVkMAK_hrqJo3fjZxERsl3au4LUOn--qRx7btPnOYLcmD>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddvfedgheelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepffgvmhhi
    ucforghrihgvucfqsggvnhhouhhruceouggvmhhisehinhhvihhsihgslhgvthhhihhngh
    hslhgrsgdrtghomheqnecuggftrfgrthhtvghrnhepjeffjefggfeugeduvedvjeekgfeh
    gffhhfffjeetkeelueefffetfffhtdduheetnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepuggvmhhisehinhhvihhsihgslhgvthhhihhnghhs
    lhgrsgdrtghomh
X-ME-Proxy: <xmx:tfTRY2Bf-X_3FCTLk3Szue3EOF95aEtMIVdgXBWa31wVr91cDPl6RA>
    <xmx:tfTRYzigofFurxcrjTtFYCetZEOw1dSBgitqG3wjwcRhN6oaNQe4VQ>
    <xmx:tfTRYyokStzJCyD_7oSZHto9b08SZEox4pnzEh5ptU9hKuHtd9tSqw>
    <xmx:tfTRY-UWccG3HaEP6VIIgwpptXZDMU3fICCe6fG84ssRJodWhMRKNg>
Feedback-ID: iac594737:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Jan 2023 22:34:13 -0500 (EST)
From:   Demi Marie Obenour <demi@invisiblethingslab.com>
To:     =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
        Juergen Gross <jgross@suse.com>, Jens Axboe <axboe@kernel.dk>
Cc:     Demi Marie Obenour <demiobenour@gmail.com>,
        =?UTF-8?q?Marek=20Marczykowski-G=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>, xen-devel@lists.xenproject.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Demi Marie Obenour <demi@invisiblethingslab.com>
Subject: [RFC PATCH 3/7] Implement diskseq checks in blkback
Date:   Wed, 25 Jan 2023 22:33:55 -0500
Message-Id: <20230126033358.1880-4-demi@invisiblethingslab.com>
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

From: Demi Marie Obenour <demiobenour@gmail.com>

This allows specifying a disk sequence number in XenStore.  If it does
not match the disk sequence number of the underlying device, the device
will not be exported and a warning will be logged.  Userspace can use
this to eliminate race conditions due to major/minor number reuse.
Older kernels will ignore this, so it is safe for userspace to set it
unconditionally.

This also makes physical-device parsing stricter.  I do not believe this
will break any extant userspace tools.

Signed-off-by: Demi Marie Obenour <demi@invisiblethingslab.com>
---
 drivers/block/xen-blkback/xenbus.c | 137 +++++++++++++++++++++--------
 1 file changed, 100 insertions(+), 37 deletions(-)

diff --git a/drivers/block/xen-blkback/xenbus.c b/drivers/block/xen-blkback/xenbus.c
index 4807af1d58059394d7a992335dabaf2bc3901721..2c43bfc7ab5ba6954f11d4b949a5668660dbd290 100644
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
@@ -507,6 +508,25 @@ static int xen_vbd_create(struct xen_blkif *blkif, blkif_vdev_t handle,
 		xen_vbd_free(vbd);
 		return -ENOENT;
 	}
+
+	if (diskseq) {
+		struct gendisk *disk = bdev->bd_disk;
+		if (unlikely(disk == NULL)) {
+			pr_err("xen_vbd_create: device %08x has no gendisk\n",
+			       vbd->pdevice);
+			xen_vbd_free(vbd);
+			return -EFAULT;
+		}
+
+		if (unlikely(disk->diskseq != diskseq)) {
+			pr_warn("xen_vbd_create: device %08x has incorrect sequence "
+				"number 0x%llx (expected 0x%llx)\n",
+				vbd->pdevice, disk->diskseq, diskseq);
+			xen_vbd_free(vbd);
+			return -ENODEV;
+		}
+	}
+
 	vbd->size = vbd_sz(vbd);
 
 	if (cdrom || disk_to_cdi(vbd->bdev->bd_disk))
@@ -690,6 +710,55 @@ static int xen_blkbk_probe(struct xenbus_device *dev,
 	return err;
 }
 
+static bool read_physical_device(struct xenbus_device *dev,
+				 unsigned long long *diskseq,
+				 unsigned *major, unsigned *minor)
+{
+	char *physical_device, *problem;
+	int i, physical_device_length;
+	char junk;
+
+	physical_device = xenbus_read(XBT_NIL, dev->nodename, "physical-device",
+				      &physical_device_length);
+
+	if (IS_ERR(physical_device)) {
+		int err = PTR_ERR(physical_device);
+		/*
+		 * Since this watch will fire once immediately after it is
+		 * registered, we expect "does not exist" errors.  Ignore
+		 * them and wait for the hotplug scripts.
+		 */
+		if (unlikely(!XENBUS_EXIST_ERR(err)))
+			xenbus_dev_fatal(dev, err, "reading physical-device");
+		return false;
+	}
+
+	for (i = 0; i < physical_device_length; ++i)
+		if (unlikely(physical_device[i] <= 0x20 || physical_device[i] >= 0x7F)) {
+			problem = "bad byte in physical-device";
+			goto fail;
+		}
+
+	if (sscanf(physical_device, "%16llx@%8x:%8x%c",
+		   diskseq, major, minor, &junk) == 3) {
+		if (*diskseq == 0) {
+			problem = "diskseq 0 is invalid";
+			goto fail;
+		}
+	} else if (sscanf(physical_device, "%8x:%8x%c", major, minor, &junk) == 2) {
+		*diskseq = 0;
+	} else {
+		problem = "invalid physical-device";
+		goto fail;
+	}
+	kfree(physical_device);
+	return true;
+fail:
+	kfree(physical_device);
+	xenbus_dev_fatal(dev, -EINVAL, problem);
+	return false;
+}
+
 /*
  * Callback received when the hotplug scripts have placed the physical-device
  * node.  Read it and the mode node, and create a vbd.  If the frontend is
@@ -707,28 +776,17 @@ static void backend_changed(struct xenbus_watch *watch,
 	int cdrom = 0;
 	unsigned long handle;
 	char *device_type;
+	unsigned long long diskseq;
 
 	pr_debug("%s %p %d\n", __func__, dev, dev->otherend_id);
-
-	err = xenbus_scanf(XBT_NIL, dev->nodename, "physical-device", "%x:%x",
-			   &major, &minor);
-	if (XENBUS_EXIST_ERR(err)) {
-		/*
-		 * Since this watch will fire once immediately after it is
-		 * registered, we expect this.  Ignore it, and wait for the
-		 * hotplug scripts.
-		 */
+	if (!read_physical_device(dev, &diskseq, &major, &minor))
 		return;
-	}
-	if (err != 2) {
-		xenbus_dev_fatal(dev, err, "reading physical-device");
-		return;
-	}
 
-	if (be->major | be->minor) {
-		if (be->major != major || be->minor != minor)
-			pr_warn("changing physical device (from %x:%x to %x:%x) not supported.\n",
-				be->major, be->minor, major, minor);
+	if (be->major | be->minor | be->diskseq) {
+		if (be->major != major || be->minor != minor || be->diskseq != diskseq)
+			pr_warn("changing physical device (from %x:%x:%llx to %x:%x:%llx)"
+				" not supported.\n",
+				be->major, be->minor, be->diskseq, major, minor, diskseq);
 		return;
 	}
 
@@ -756,29 +814,34 @@ static void backend_changed(struct xenbus_watch *watch,
 
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
