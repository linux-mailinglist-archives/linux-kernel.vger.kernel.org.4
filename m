Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BAD167C39C
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 04:34:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236458AbjAZDeZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 22:34:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236339AbjAZDeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 22:34:17 -0500
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05A91577CB
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 19:34:12 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 443E25C05B6;
        Wed, 25 Jan 2023 22:34:12 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 25 Jan 2023 22:34:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        invisiblethingslab.com; h=cc:cc:content-transfer-encoding:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm3; t=
        1674704052; x=1674790452; bh=daYdDSxsQizEcNPbMbpsOlpi5qeRBNOt+Bq
        Qaw5kD0w=; b=Gz2/2XbquxSEsRBwW3i8K6QksQx0hV7tWzYjhpzeocxqrFIM6wh
        zdx8cHua8jpdXCnntgZk9zP1FpKjVVuxcTDVAAaIPY7uX1HET1rnYyBE/OUveR/a
        yGltG4jXyOnqQ3XVG9O0oOamWRMfH3jkWh9CTsX8tZPb+D00NjEubF8/Tt1oKf0T
        JZ5GQO0SLUiYtvCIPUFuvUIvYreccKY7X9UApl1p+dTZHOXZX79hcLfihRLQvAnU
        L2LTLLdKL1eSL+Y3znx8Cu2IMujQ9I10DgzMdzuqLJO7T/MDOGnT80u2FU12KGEv
        qRtd/wPKUG+HAcJ8mr/1iDlcnqC4Fitaq+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1674704052; x=1674790452; bh=daYdDSxsQizEc
        NPbMbpsOlpi5qeRBNOt+BqQaw5kD0w=; b=NutHK5vzuBp6vHCz5b862NQHzoAk2
        QPkv41LPJqzDVYP/LpUDEPi9xtlw73q09xZRZiPm8QzFFgdDD69UZ0AQIvD6Iyin
        85LXriSm4s570MdKkyAUDRygNHx6uNmuyWaozpY90SnPKK/peQWaQr71aWbms5PT
        ag17AqsLTL9bUI5y9LRTfpZfB8o9LGxhaklz2PXkKYLw5hhUv7mhxObZ64ZayGhw
        XtUcsfqkhf+tG8itv9TK6QGxQPMDn4XfaCF3jRe5rvChK1DlDDmx+VOtO7lTXCnD
        L81I4VkrBnt7l1Rd6zkgQuOxrWiivMc9yxG8JFCUu2gqLnxg5gvv01PTw==
X-ME-Sender: <xms:tPTRYzwH5BuEHmVC0eMdTGBBHZMvxt9uWC_rqOGS_ycgsaVj53vQiQ>
    <xme:tPTRY7QY3bnvHhI3rshGztUECyV2lnxUGYKP3bTTB1P8CT0b0uLuAcpcxQKuARE_B
    AJKSl9rZB4DZCM>
X-ME-Received: <xmr:tPTRY9WUpZzy3Z8Ck8htOkPkbtAbgBnETUbKfLGw8gZ6vwGJ1SKYiq7n2texQZKLlDNbwtPj-NZx>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddvfedgheelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepffgvmhhi
    ucforghrihgvucfqsggvnhhouhhruceouggvmhhisehinhhvihhsihgslhgvthhhihhngh
    hslhgrsgdrtghomheqnecuggftrfgrthhtvghrnhepjeffjefggfeugeduvedvjeekgfeh
    gffhhfffjeetkeelueefffetfffhtdduheetnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepuggvmhhisehinhhvihhsihgslhgvthhhihhnghhs
    lhgrsgdrtghomh
X-ME-Proxy: <xmx:tPTRY9god6WZldkNb6zQxaW-zL3SwrJWz_pk8nteivz3n9Mg372ewQ>
    <xmx:tPTRY1A40rWLm24WxN8wSZLeSpKTRKkmbS2avRGDKXaJ1MessXz1jw>
    <xmx:tPTRY2J2wBOPbzFSk35mgosVTMij5PfJyCoi7AEB9vGO0sW2kh1BBQ>
    <xmx:tPTRY0OGKPUER8o2RS25jDcq9Ina-GirRmaBNRGjT7lspzBd9a80CA>
Feedback-ID: iac594737:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Jan 2023 22:34:11 -0500 (EST)
From:   Demi Marie Obenour <demi@invisiblethingslab.com>
To:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com
Cc:     Demi Marie Obenour <demi@invisiblethingslab.com>,
        =?UTF-8?q?Marek=20Marczykowski-G=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 2/7] Allow userspace to get an FD to a newly-created DM device
Date:   Wed, 25 Jan 2023 22:33:54 -0500
Message-Id: <20230126033358.1880-3-demi@invisiblethingslab.com>
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

This allows creating a device-mapper device, opening it, and setting it
to be deleted when unused in a single atomic operation.

Signed-off-by: Demi Marie Obenour <demi@invisiblethingslab.com>
---
 drivers/md/dm-ioctl.c         | 67 +++++++++++++++++++++++++++++------
 include/uapi/linux/dm-ioctl.h | 16 ++++++++-
 2 files changed, 72 insertions(+), 11 deletions(-)

diff --git a/drivers/md/dm-ioctl.c b/drivers/md/dm-ioctl.c
index 36fc6ae4737a05ab53ab67a8ccee525cb5fda082..05438dedcd17b7cac470fcc5a9721d67daad4bfb 100644
--- a/drivers/md/dm-ioctl.c
+++ b/drivers/md/dm-ioctl.c
@@ -853,9 +853,21 @@ static void __dev_status(struct mapped_device *md, struct dm_ioctl *param)
 
 static int dev_create(struct file *filp, struct dm_ioctl *param, size_t param_size)
 {
-	int r, m = DM_ANY_MINOR;
+	int r, m = DM_ANY_MINOR, fd;
 	struct mapped_device *md;
 
+	/* Do not allow unknown flags */
+	if (param->flags > (2 * DM_FILE_DESCRIPTOR_FLAG - 1))
+		return -EINVAL;
+
+	/*
+	 * Do not allow creating a device that would just be destroyed
+	 * before the ioctl returns.
+	 */
+	if ((param->flags & DM_DEFERRED_REMOVE) &&
+	    !(param->flags & DM_FILE_DESCRIPTOR_FLAG))
+		return -EINVAL;
+
 	r = check_name(param->name);
 	if (r)
 		return r;
@@ -867,20 +879,55 @@ static int dev_create(struct file *filp, struct dm_ioctl *param, size_t param_si
 	if (r)
 		return r;
 
-	r = dm_hash_insert(param->name, *param->uuid ? param->uuid : NULL, md);
-	if (r) {
-		dm_put(md);
-		dm_destroy(md);
-		return r;
-	}
-
 	param->flags &= ~DM_INACTIVE_PRESENT_FLAG;
 
+	r = dm_hash_insert(param->name, *param->uuid ? param->uuid : NULL, md);
+	if (r)
+		goto out_put;
+
+	if (param->flags & DM_FILE_DESCRIPTOR_FLAG) {
+		struct block_device *bdev = dm_disk(md)->part0;
+		struct file *file;
+
+		fd = get_unused_fd_flags(O_RDWR | O_CLOEXEC);
+		if (fd < 0) {
+			r = fd;
+			goto out_put;
+		}
+
+		file = blkdev_get_file(bdev, O_RDWR|O_CLOEXEC, NULL);
+		if (IS_ERR(file)) {
+			r = PTR_ERR(file);
+			goto out_put_fd;
+		}
+
+		/*
+		 * Simulate opening the device.  The other checks in
+		 * dm_blk_open() are not necessary becuase we have a reference
+		 * to the `struct md`.
+		 */
+		atomic_inc(&md->open_count);
+		fd_install(fd, file);
+		param->file_descriptor = fd;
+	}
+
+	/*
+	 * If userspace requests it, automatically delete the device
+	 * when it is no longer used
+	 */
+	if (param->flags & DM_DEFERRED_REMOVE)
+		set_bit(DMF_DEFERRED_REMOVE, &md->flags);
+
 	__dev_status(md, param);
-
 	dm_put(md);
-
 	return 0;
+
+out_put_fd:
+	put_unused_fd(fd);
+out_put:
+	dm_put(md);
+	dm_destroy(md);
+	return r;
 }
 
 /*
diff --git a/include/uapi/linux/dm-ioctl.h b/include/uapi/linux/dm-ioctl.h
index 7edf335778bae1cb206f6dd4d44e9cf7fb9da35c..30a6260ed7e06ff71fad1675dd4e7f9325d752a6 100644
--- a/include/uapi/linux/dm-ioctl.h
+++ b/include/uapi/linux/dm-ioctl.h
@@ -136,7 +136,13 @@ struct dm_ioctl {
 	 * For output, the ioctls return the event number, not the cookie.
 	 */
 	__u32 event_nr;      	/* in/out */
-	__u32 padding;
+
+	union {
+		/* Padding for named devices */
+		__u32 padding;
+		/* For anonymous devices, this is a file descriptor. */
+		__u32 file_descriptor;
+	};
 
 	__u64 dev;		/* in/out */
 
@@ -382,4 +388,12 @@ enum {
  */
 #define DM_IMA_MEASUREMENT_FLAG	(1 << 19) /* In */
 
+/*
+ * If set in a DM_DEV_CREATE ioctl(), sets the file_descriptor field
+ * to a valid file descriptor.  This can be combined with DM_DEFERRED_REMOVE
+ * to cause the device to be destroyed when the file descriptor is closed
+ * and is otherwise unused.
+ */
+#define DM_FILE_DESCRIPTOR_FLAG		(1 << 20) /* In */
+
 #endif				/* _LINUX_DM_IOCTL_H */
-- 
Sincerely,
Demi Marie Obenour (she/her/hers)
Invisible Things Lab
