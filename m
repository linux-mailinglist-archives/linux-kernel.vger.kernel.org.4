Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB5576B6A8B
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 20:11:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbjCLTLB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 15:11:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbjCLTK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 15:10:59 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BBB5303DB;
        Sun, 12 Mar 2023 12:10:49 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 9E524320046E;
        Sun, 12 Mar 2023 15:10:47 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Sun, 12 Mar 2023 15:10:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alyssa.is; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:message-id:mime-version:reply-to
        :sender:subject:subject:to:to; s=fm1; t=1678648247; x=
        1678734647; bh=Cvh4ZiacG5VE6kcR8Gk7s5+fYYDWMIvbwr/3VYeaQZ4=; b=k
        X+AnLqLq4MLdXHy+t+2is0PlLlD7ud3YWETgaLWAP5nQ5kVuhBCdwSpTx/S62NbI
        7+HRx3jRkN8Y9B20bCvyDPtTtw90qRFZN/yYrGoOqmHJAFBf/vH98xKQ67lmAw/u
        KjxdDaVXs/16cCRKyOo2k2YsI8uaS7OIHVHl07X+RFw5ioITxeDzYHDI1qPpC3OX
        y+s/fD+64p6BgPXxh8an5lGc1fxOQnah4SCsxpkZ1qR9o/NYnBsN6eMnXFPQmZWv
        1fE9DzScWIgzbgLGEzid6asztQno2ltg5GchMSRfbOR1tDKe+1if8zHxsC1WMBZg
        0KFocWKYPbS3ghXDRGTHA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:message-id:mime-version:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; t=1678648247; x=1678734647; bh=C
        vh4ZiacG5VE6kcR8Gk7s5+fYYDWMIvbwr/3VYeaQZ4=; b=vRA11/tAGCHarmsIR
        s2nKwyc0GCeCAKvbfF/ZhBJjEU9Ip+gCnurM6Q6qsHCjpfzv4P3zgeNGgrymWjP3
        zdZhqeAQ74Nw7uYu/YDthOvq5OU4T7MZnOo6aqLgXNQbxGWX6RWQcoyR9Ph+dZ55
        ikt7jS71lk2v99aigtZJPV5SBDKrM7USbnWnd/30jyiAOiqDoGMuPErUiANvXYWg
        z4Yhn5qlMQsqxSb1pFpivhpZrpSdptpfTINywVNShyBf/uf72k+8T49MyBPVNmlJ
        vO/2m892Am6rNSeqbV/5f5uNLXAbSoitMz88bjl870TnV0M1WHokeBraj1EnO8ep
        FFl2g==
X-ME-Sender: <xms:tiMOZLZNPbBlvpD6EebseWHHRnEqRjmlf5aiOIBqu63oPF5vzTQmOQ>
    <xme:tiMOZKa2qd2vmYwvG563FWj-7y6bbJLguiPcVQWrDxfgPApc4DNXkUf3Z1Of2hbl8
    EyWwfpGfK82CBnWig>
X-ME-Received: <xmr:tiMOZN9AxCea0RtN7VS-V5g9W_lhgHtqZ4Z7MASgGYYz32B6Anonfxs_mZBL_t0PR3bV6SdyaN1NP50c_GJhgGz1wO4YZpuRNQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvddvvddguddvtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvfevufffkffogggtgfesthekredtredtjeenucfhrhhomheptehlhihs
    shgrucftohhsshcuoehhihesrghlhihsshgrrdhisheqnecuggftrfgrthhtvghrnhepve
    evgfehledtieelffegvdegveeukeevhfdtteeggeejvdduveegvefftefgueffnecuffho
    mhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehhihesrghlhihsshgrrdhish
X-ME-Proxy: <xmx:tiMOZBplT7Ushm42rQUl_PyR8nzY1xxCu5d4WQoxjE2P6scdIaPo2A>
    <xmx:tiMOZGos34MSyNMXe1A5gz_SZ37XCx9Oiwvn2QIp7qW4qclqABcjuQ>
    <xmx:tiMOZHTBiwYW4eJunuRWqjo6hKX36y0tBYRLz3aB2sR8olTWfbUc1g>
    <xmx:tyMOZN2cd5oNEs6W7sGqAtYnM0uOJhcwEfv26X93_i8j8BFExTswrw>
Feedback-ID: i12284293:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 12 Mar 2023 15:10:46 -0400 (EDT)
Received: by x220.qyliss.net (Postfix, from userid 1000)
        id 3B3C423881; Sun, 12 Mar 2023 19:10:39 +0000 (UTC)
From:   Alyssa Ross <hi@alyssa.is>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-kernel@vger.kernel.org, Alyssa Ross <hi@alyssa.is>,
        Martijn Coenen <maco@android.com>, linux-block@vger.kernel.org
Subject: [PATCH v2] loop: LOOP_CONFIGURE: send uevents for partitions
Date:   Sun, 12 Mar 2023 19:10:31 +0000
Message-Id: <20230312191031.551204-1-hi@alyssa.is>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LOOP_CONFIGURE is, as far as I understand it, supposed to be a way to
combine LOOP_SET_FD and LOOP_SET_STATUS64 into a single syscall.  When
using LOOP_SET_FD+LOOP_SET_STATUS64, a single uevent would be sent for
each partition found on the loop device after the second ioctl(), but
when using LOOP_CONFIGURE, no such uevent was being sent.

In the old setup, uevents are disabled for LOOP_SET_FD, but not for
LOOP_SET_STATUS64.  This makes sense, as it prevents uevents being
sent for a partially configured device during LOOP_SET_FD — they're
only sent at the end of LOOP_SET_STATUS64.  But for LOOP_CONFIGURE,
uevents were disabled for the entire operation, so that final
notification was never issued.  To fix this, I've moved the
loop_reread_partitions() call, which causes the uevents to be issued,
to after uevents are re-enabled, matching the behaviour of the
LOOP_SET_FD+LOOP_SET_STATUS64 combination.

I noticed this because Busybox's losetup program recently changed from
using LOOP_SET_FD+LOOP_SET_STATUS64 to LOOP_CONFIGURE, and this broke
my setup, for which I want a notification from the kernel any time a
new partition becomes available.

Signed-off-by: Alyssa Ross <hi@alyssa.is>
Fixes: 3448914e8cc5 ("loop: Add LOOP_CONFIGURE ioctl")
---

v1: https://lore.kernel.org/linux-block/20230221222847.607096-1-hi@alyssa.is/

v1 was an RFC, because I was looking for advice on how to handle
distinguishing between LOOP_SET_FD with non-zero max_part (in which
case partscan will be true, but a uevent should not be emitted), and
LOOP_CONFIGURE (where a uevent should be emitted).  I didn't hear
anything, but I did some experimentation of my own, and adding a
partscan_uevent parameter to distinguish between LOOP_SET_FD and
LOOP_CONFIGURE feels like the least bad solution to me.

 drivers/block/loop.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 839373451c2b..f00a0209b522 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -992,7 +992,8 @@ loop_set_status_from_info(struct loop_device *lo,
 
 static int loop_configure(struct loop_device *lo, fmode_t mode,
 			  struct block_device *bdev,
-			  const struct loop_config *config)
+			  const struct loop_config *config,
+			  bool partscan_uevent)
 {
 	struct file *file = fget(config->fd);
 	struct inode *inode;
@@ -1110,15 +1111,21 @@ static int loop_configure(struct loop_device *lo, fmode_t mode,
 		clear_bit(GD_SUPPRESS_PART_SCAN, &lo->lo_disk->state);
 
 	loop_global_unlock(lo, is_loop);
-	if (partscan)
-		loop_reread_partitions(lo);
 	if (!(mode & FMODE_EXCL))
 		bd_abort_claiming(bdev, loop_configure);
 
+	/*
+	 * Now that we are done, reread the partitions with uevent
+	 * re-enabled if appropriate to let userspace know about the
+	 * changes.
+	 */
+	dev_set_uevent_suppress(disk_to_dev(lo->lo_disk), !partscan_uevent);
+	if (partscan)
+		loop_reread_partitions(lo);
+	dev_set_uevent_suppress(disk_to_dev(lo->lo_disk), 0);
+
 	error = 0;
 done:
-	/* enable and uncork uevent now that we are done */
-	dev_set_uevent_suppress(disk_to_dev(lo->lo_disk), 0);
 	return error;
 
 out_unlock:
@@ -1130,6 +1136,7 @@ static int loop_configure(struct loop_device *lo, fmode_t mode,
 	fput(file);
 	/* This is safe: open() is still holding a reference. */
 	module_put(THIS_MODULE);
+	dev_set_uevent_suppress(disk_to_dev(lo->lo_disk), 0);
 	goto done;
 }
 
@@ -1547,7 +1554,7 @@ static int lo_ioctl(struct block_device *bdev, fmode_t mode,
 		memset(&config, 0, sizeof(config));
 		config.fd = arg;
 
-		return loop_configure(lo, mode, bdev, &config);
+		return loop_configure(lo, mode, bdev, &config, false);
 	}
 	case LOOP_CONFIGURE: {
 		struct loop_config config;
@@ -1555,7 +1562,7 @@ static int lo_ioctl(struct block_device *bdev, fmode_t mode,
 		if (copy_from_user(&config, argp, sizeof(config)))
 			return -EFAULT;
 
-		return loop_configure(lo, mode, bdev, &config);
+		return loop_configure(lo, mode, bdev, &config, true);
 	}
 	case LOOP_CHANGE_FD:
 		return loop_change_fd(lo, bdev, arg);
-- 
2.37.1

