Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8C7573CD63
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 01:10:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbjFXXKT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 19:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbjFXXKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 19:10:08 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D6571728
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jun 2023 16:10:07 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 84A5A320030E;
        Sat, 24 Jun 2023 19:10:06 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Sat, 24 Jun 2023 19:10:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        invisiblethingslab.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1687648206; x=1687734606; bh=X8tYiCb8sz
        g3+Xxn3rsxiUTgoJEwnGxILvg2gFNhDDg=; b=ByhHz5032gM2WomxFDBMNHa+mV
        elp7zMhYBf+7iyxuaCUNkmGg92Pm98hAhh/f9LmOJXC+eeOj9VRgC7tsaXW/XLhg
        7VE6tk674ZSc4OodBFx74DIgZzSVSzkXdG+9Ke0ktuParoJZISBNcY12gDdKYAzm
        1J8crS4W8irzW4cW1qHOYZMjQQR+L9EZcYnoblBpJ/MdgcuziKEFCMpg9x77hsCp
        wPfpkGvfdlrfIoD28gOycFguZwWmfhA0zDi7StGRpNRc4weA1ccmocnVcEv0OijY
        bH6/vcA9PhR0xQZ33FXVbV7zcmFqoChKnlrfByw5azUklpUS5xnvEbytHt0A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1687648206; x=
        1687734606; bh=X8tYiCb8szg3+Xxn3rsxiUTgoJEwnGxILvg2gFNhDDg=; b=f
        hAeaXS/hBayxg5AyWpb96boL/j9XvDnhiJgL0pCRd4BTvzYnxh4phBwrWGCp0gJ2
        fh0TtdT/bVPfNDHvrGKyNc074+uWeIhF9rkgU1nQqTtzRU893WxacF7P6Q3Ezo2q
        XsDkFvuEPstPsb6KK6FcDQ2Sz/Hd3aXG6ZMFkScTtUEnFmYkT5vIJsW14DAPt+Cq
        J+z6ntNCzXjRKtNt5lPyZvxmQPSv6ByNk9Ao6o6wKAxFZXmENdGF2VFWyj/lR8OB
        UWvixP97kfOlgat2Bm6Bfc1M6JkA4tiI1ZbVc0jfAZb9Jfs0V//yPAzCchKVIcuW
        tzSeqYHNbmK6G67jw2KgQ==
X-ME-Sender: <xms:zneXZMgjvPO9N1C3GG9O5RBN7PE_LXoGfhgPihNyuS9_83-v0VkUow>
    <xme:zneXZFAIl4Mr7GTqwNFAXO5QqzA1lGw6piATQtXWuVD2L_pbr1OeF6AgvausJelIU
    g5Np40RYBcEjRo>
X-ME-Received: <xmr:zneXZEHC5rlPsNiLyNNCQhRF5M3ZyrHi6jFcMkJQejHYuIK2KfoNT7ydRthazFGo6d8xT6CMKnM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgeegkedgudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepffgvmhhi
    ucforghrihgvucfqsggvnhhouhhruceouggvmhhisehinhhvihhsihgslhgvthhhihhngh
    hslhgrsgdrtghomheqnecuggftrfgrthhtvghrnhepjeffjefggfeugeduvedvjeekgfeh
    gffhhfffjeetkeelueefffetfffhtdduheetnecuvehluhhsthgvrhfuihiivgepudenuc
    frrghrrghmpehmrghilhhfrhhomhepuggvmhhisehinhhvihhsihgslhgvthhhihhnghhs
    lhgrsgdrtghomh
X-ME-Proxy: <xmx:zneXZNSHljC4vZs-FTCYagGITIoFIchc5m_Gjq4VwAMgPZMUN6-CsQ>
    <xmx:zneXZJwR1DldrekA5ZxilQVcjZjJ1FqcnCxjSz2vLmzYpSPwyrlajw>
    <xmx:zneXZL5D1CtcrvVdqsTxmZd63larBrRLukyKPLEsLVsUcM_je-tQvA>
    <xmx:zneXZE82nVdiYLHrvFM4grcyVcYJsc51JkbEFjbMCTSujJgBr3siwg>
Feedback-ID: iac594737:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 24 Jun 2023 19:10:05 -0400 (EDT)
From:   Demi Marie Obenour <demi@invisiblethingslab.com>
To:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com
Cc:     Demi Marie Obenour <demi@invisiblethingslab.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/4] dm ioctl: inform caller about already-existing device
Date:   Sat, 24 Jun 2023 19:09:47 -0400
Message-ID: <20230624230950.2272-5-demi@invisiblethingslab.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230624230950.2272-1-demi@invisiblethingslab.com>
References: <20230624230950.2272-1-demi@invisiblethingslab.com>
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

Not only is this helpful for debugging, it also saves the caller an
ioctl in the case where a device should be used if it exists or created
otherwise.  To ensure existing userspace is not broken, this feature is
only enabled in strict mode.

Signed-off-by: Demi Marie Obenour <demi@invisiblethingslab.com>
---
 drivers/md/dm-ioctl.c         | 31 +++++++++++++++++++++++++------
 include/uapi/linux/dm-ioctl.h |  4 ++--
 2 files changed, 27 insertions(+), 8 deletions(-)

diff --git a/drivers/md/dm-ioctl.c b/drivers/md/dm-ioctl.c
index 7eab9a8c77ff3286346a1c44581d3b6370a731eb..4eb3eda2fe169f64259458dd678833f444d76ce0 100644
--- a/drivers/md/dm-ioctl.c
+++ b/drivers/md/dm-ioctl.c
@@ -259,11 +259,14 @@ static void free_cell(struct hash_cell *hc)
 	}
 }
 
+static void __dev_status(struct mapped_device *md, struct dm_ioctl *param);
+
 /*
  * The kdev_t and uuid of a device can never change once it is
  * initially inserted.
  */
-static int dm_hash_insert(const char *name, const char *uuid, struct mapped_device *md)
+static int dm_hash_insert(const char *name, const char *uuid, struct mapped_device *md,
+			  struct dm_ioctl *param)
 {
 	struct hash_cell *cell, *hc;
 
@@ -280,6 +283,8 @@ static int dm_hash_insert(const char *name, const char *uuid, struct mapped_devi
 	down_write(&_hash_lock);
 	hc = __get_name_cell(name);
 	if (hc) {
+		if (param)
+			__dev_status(hc->md, param);
 		dm_put(hc->md);
 		goto bad;
 	}
@@ -290,6 +295,8 @@ static int dm_hash_insert(const char *name, const char *uuid, struct mapped_devi
 		hc = __get_uuid_cell(uuid);
 		if (hc) {
 			__unlink_name(cell);
+			if (param)
+				__dev_status(hc->md, param);
 			dm_put(hc->md);
 			goto bad;
 		}
@@ -901,10 +908,12 @@ static int dev_create(struct file *filp, struct dm_ioctl *param, size_t param_si
 		m = MINOR(huge_decode_dev(param->dev));
 
 	r = dm_create(m, &md, param->flags & DM_DISABLE_UEVENTS_FLAG);
-	if (r)
+	if (r) {
+		DMERR("Could not create device-mapper device");
 		return r;
+	}
 
-	r = dm_hash_insert(param->name, *param->uuid ? param->uuid : NULL, md);
+	r = dm_hash_insert(param->name, *param->uuid ? param->uuid : NULL, md, param);
 	if (r) {
 		dm_put(md);
 		dm_destroy(md);
@@ -2234,6 +2243,7 @@ static int ctl_ioctl(struct file *file, uint command, struct dm_ioctl __user *us
 	int ioctl_flags;
 	int param_flags;
 	unsigned int cmd;
+	bool do_copy;
 	struct dm_ioctl *param;
 	ioctl_fn fn = NULL;
 	size_t input_param_size;
@@ -2307,9 +2317,18 @@ static int ctl_ioctl(struct file *file, uint command, struct dm_ioctl __user *us
 	param->flags |= old_flags;
 
 	/*
-	 * Copy the results back to userland.
+	 * Copy the results back to userland if either:
+	 *
+	 * - The ioctl succeeded.
+	 * - The ioctl is DM_DEV_CREATE, the return value is -EBUSY,
+	 *   and strict parameter checking is enabled.
 	 */
-	if (!r && copy_to_user(user, param, param->data_size))
+	do_copy = r == 0;
+	if (r == -EBUSY && !sloppy_checks(param) && cmd == DM_DEV_CREATE_CMD) {
+		param->flags |= DM_EXISTS_FLAG;
+		do_copy = true;
+	}
+	if (do_copy && copy_to_user(user, param, param->data_size))
 		r = -EFAULT;
 
 out:
@@ -2488,7 +2507,7 @@ int __init dm_early_create(struct dm_ioctl *dmi,
 		return r;
 
 	/* hash insert */
-	r = dm_hash_insert(dmi->name, *dmi->uuid ? dmi->uuid : NULL, md);
+	r = dm_hash_insert(dmi->name, *dmi->uuid ? dmi->uuid : NULL, md, NULL);
 	if (r)
 		goto err_destroy_dm;
 
diff --git a/include/uapi/linux/dm-ioctl.h b/include/uapi/linux/dm-ioctl.h
index b338a4f9a299acda9430995d63fbb490e70c8cd8..195d60be4aba4f20b7220b900c87d6d3a86014a2 100644
--- a/include/uapi/linux/dm-ioctl.h
+++ b/include/uapi/linux/dm-ioctl.h
@@ -344,8 +344,8 @@ enum {
 /* Status bits */
 #define DM_READONLY_FLAG	(1 << 0) /* In/Out */
 #define DM_SUSPEND_FLAG		(1 << 1) /* In/Out */
-#define DM_EXISTS_FLAG		(1 << 2) /* Not used by kernel, reserved for
-					  * libdevmapper in userland
+#define DM_EXISTS_FLAG		(1 << 2) /* Set when trying to create a
+					  * device that already exists
 					  */
 #define DM_PERSISTENT_DEV_FLAG	(1 << 3) /* In */
 
-- 
Sincerely,
Demi Marie Obenour (she/her/hers)
Invisible Things Lab

