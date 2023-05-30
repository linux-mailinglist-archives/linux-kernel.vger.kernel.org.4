Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21B45716ED1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 22:33:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233518AbjE3UdA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 16:33:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233486AbjE3Ucm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 16:32:42 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C22C7135;
        Tue, 30 May 2023 13:32:06 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 279DD320091D;
        Tue, 30 May 2023 16:32:01 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 30 May 2023 16:32:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        invisiblethingslab.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1685478720; x=1685565120; bh=aAfoA6tajO
        I3DdZbN+5gNp3o1Bf92v6/idOtFVwuqiE=; b=XYryrGSs9af08o9XzJZlWkP7YS
        JLLfR1m5fe8QVd3QR+6WCZdGftB4WKelk4w73RWFcsldPXK/6kET4skLGHEjfyR9
        9raZlXBEqMOY3lcfb3RKOIXooZ6bPv1MTjeKMBqsKjXscnwDbIJTiVZqWxMgeHZ+
        X0fukMQ6rp3BZHVQA/h3abeEGZylMMkQPtqmNC1qKQK7FYeXv1VabGc/J9HKQHj5
        hNwxe11yXZPnYOujIsBfr07INd/FWOq3WMM/AhxJFTOsJjo3mZCX0BTyTGB+HOpO
        sm9nG/rSIhh+fS7BiI2cZ7Vx1W96+WzIAyAKIkO+GaPZ1WnP1yjbU6VnCMAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1685478720; x=
        1685565120; bh=aAfoA6tajOI3DdZbN+5gNp3o1Bf92v6/idOtFVwuqiE=; b=B
        LBapeZTHOetv6cE0GTwPpL73JQDH4RfekajwyobPYL6NNCpVV58gVIFMYzREQE9O
        cIOpGoxbNrxHuDPmwJ6eVXN4MozN4uVBcS2b7Rl5bxt7Fp/e93CHX+VipbnxUY/t
        0eVrwRVlPeCVOVUbuTwecqzI4e02b7wsokNIEUeINpoAmY9Qqcvt0HGvOuTlydim
        /NVfmnLxWbVFFibA08/xffwRWQU38ugjH9Qo+9YaNfAmM4rJErVXAHQBctyESQ2V
        8rewIK4P5DUD8YH+0lVTRQv+lSSc80A0ROaBPwCP1s7qkVpwdFzgyTOMjWxqbCIt
        0TXQT4E0HMZaYYSRHSDSw==
X-ME-Sender: <xms:QF12ZCZ3oN8GVGLxftsLzb7XF7JQDy-dZnoVAYHi3TcO_u7VLXpd_Q>
    <xme:QF12ZFb7XHXylUzDBAPLQa0q-p3-Ao2i09qxVCvoD0sTRms-BG9QgAizX9_o8qqV2
    iM1k7MO_51MwnI>
X-ME-Received: <xmr:QF12ZM-fDsGeeKGFdvmuUUj-AlmSJ1erOTgu1vjCIr1jWGzS9apxH44jdLDCboDUu013w4EWm-I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeekjedgudeglecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeffvghm
    ihcuofgrrhhivgcuqfgsvghnohhurhcuoeguvghmihesihhnvhhishhisghlvghthhhinh
    hgshhlrggsrdgtohhmqeenucggtffrrghtthgvrhhnpeejffejgffgueegudevvdejkefg
    hefghffhffejteekleeufeffteffhfdtudehteenucevlhhushhtvghrufhiiigvpedvne
    curfgrrhgrmhepmhgrihhlfhhrohhmpeguvghmihesihhnvhhishhisghlvghthhhinhhg
    shhlrggsrdgtohhm
X-ME-Proxy: <xmx:QF12ZEpxhXCT_a9X11L5ybiledCrn_Stwvppk-WVV9haaHIhJIyoFQ>
    <xmx:QF12ZNp8FaVGTlYstv3J-F2wor1oiUHQNKPgVVt7cDxeN5uMp-AYMQ>
    <xmx:QF12ZCShMD5AgQCCI_Hjg0W23jI2_49FuGbpq_XVAqLelcfljtcm1w>
    <xmx:QF12ZBIH9JvcUfeg7VUQdt1FC4VXptH2JLx0XUrDRrulFOdEuGr79A>
Feedback-ID: iac594737:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 May 2023 16:31:59 -0400 (EDT)
From:   Demi Marie Obenour <demi@invisiblethingslab.com>
To:     Jens Axboe <axboe@kernel.dk>,
        =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com
Cc:     Demi Marie Obenour <demi@invisiblethingslab.com>,
        =?UTF-8?q?Marek=20Marczykowski-G=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org
Subject: [PATCH v2 09/16] device-mapper: Allow userspace to suppress uevent generation
Date:   Tue, 30 May 2023 16:31:09 -0400
Message-Id: <20230530203116.2008-10-demi@invisiblethingslab.com>
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

Userspace can use this to avoid spamming udev with events that udev
should ignore.

Signed-off-by: Demi Marie Obenour <demi@invisiblethingslab.com>
---
 drivers/md/dm-core.h          |  2 +
 drivers/md/dm-ioctl.c         | 78 ++++++++++++++++++-----------------
 drivers/md/dm.c               |  5 ++-
 include/linux/device-mapper.h |  2 +-
 include/uapi/linux/dm-ioctl.h | 14 +++++--
 5 files changed, 57 insertions(+), 44 deletions(-)

diff --git a/drivers/md/dm-core.h b/drivers/md/dm-core.h
index aecab0c0720f77ae2a0ab048304ea3d1023f9959..a033f85d1a9d9b3d8ec893efd6552fb48d2b3541 100644
--- a/drivers/md/dm-core.h
+++ b/drivers/md/dm-core.h
@@ -115,6 +115,8 @@ struct mapped_device {
 
 	/* for blk-mq request-based DM support */
 	bool init_tio_pdu:1;
+	/* If set, do not emit any uevents. */
+	bool disable_uevents:1;
 	struct blk_mq_tag_set *tag_set;
 
 	struct dm_stats stats;
diff --git a/drivers/md/dm-ioctl.c b/drivers/md/dm-ioctl.c
index 01cdf57bcafbf7f3e1b8304eec28792c6b24642d..52aa5505d23b2f3d9c0faf6e8a91b74cd7845581 100644
--- a/drivers/md/dm-ioctl.c
+++ b/drivers/md/dm-ioctl.c
@@ -814,6 +814,11 @@ static struct dm_table *dm_get_live_or_inactive_table(struct mapped_device *md,
 		dm_get_inactive_table(md, srcu_idx) : dm_get_live_table(md, srcu_idx);
 }
 
+static inline bool sloppy_checks(const struct dm_ioctl *param)
+{
+	return param->version[0] < DM_VERSION_MAJOR_STRICT;
+}
+
 /*
  * Fills in a dm_ioctl structure, ready for sending back to
  * userland.
@@ -872,7 +877,7 @@ static void __dev_status(struct mapped_device *md, struct dm_ioctl *param)
 		dm_put_live_table(md, srcu_idx);
 	}
 
-	if (param->version[0] >= DM_VERSION_MAJOR_STRICT)
+	if (!sloppy_checks(param))
 		dm_set_diskseq(param, disk->diskseq);
 }
 
@@ -888,7 +893,7 @@ static int dev_create(struct file *filp, struct dm_ioctl *param, size_t param_si
 	if (param->flags & DM_PERSISTENT_DEV_FLAG)
 		m = MINOR(huge_decode_dev(param->dev));
 
-	r = dm_create(m, &md);
+	r = dm_create(m, &md, param->flags & DM_DISABLE_UEVENTS_FLAG);
 	if (r)
 		return r;
 
@@ -1452,11 +1457,6 @@ static int next_target(struct dm_target_spec *last, uint32_t next, const char *e
 	return 0;
 }
 
-static inline bool sloppy_checks(const struct dm_ioctl *param)
-{
-	return param->version[0] < DM_VERSION_MAJOR_STRICT;
-}
-
 static bool no_non_nul_after_nul(const char *untrusted_str, size_t size,
 				 unsigned int cmd, const char *msg)
 {
@@ -1928,59 +1928,61 @@ static int target_message(struct file *filp, struct dm_ioctl *param, size_t para
  * Implementation of open/close/ioctl on the special char device.
  *---------------------------------------------------------------
  */
-static ioctl_fn lookup_ioctl(unsigned int cmd, int *ioctl_flags, uint32_t *supported_flags)
+static ioctl_fn lookup_ioctl(unsigned int cmd, bool strict, int *ioctl_flags, uint32_t *supported_flags)
 {
 	static const struct {
 		int cmd;
 		int flags;
 		ioctl_fn fn;
 		uint32_t supported_flags;
+		uint32_t strict_flags;
 	} _ioctls[] = {
 		/* Macro to make the structure initializers somewhat readable */
-#define I(cmd, flags, fn, supported_flags) {							\
-	(cmd),											\
-	(flags),										\
-	(fn),											\
-	/*											\
-	 * Supported flags in sloppy mode must not include anything in DM_STRICT_ONLY_FLAGS.	\
-	 * Use BUILD_BUG_ON_ZERO to check for that.						\
-	 */											\
-	(supported_flags) | BUILD_BUG_ON_ZERO((supported_flags) & DM_STRICT_ONLY_FLAGS),	\
+#define I(cmd, flags, fn, supported_flags, strict_flags) {						\
+	(cmd),												\
+	(flags),											\
+	(fn),												\
+	/*												\
+	 * Supported flags in sloppy mode must not include anything in DM_STRICT_ONLY_FLAGS.		\
+	 * Use BUILD_BUG_ON_ZERO to check for that.							\
+	 */												\
+	(supported_flags) | BUILD_BUG_ON_ZERO((supported_flags) & DM_STRICT_ONLY_FLAGS),		\
+	(strict_flags) | (supported_flags) | BUILD_BUG_ON_ZERO((supported_flags) & (strict_flags)),	\
 }
-		I(DM_VERSION_CMD, 0, NULL, 0), /* version is dealt with elsewhere */
+		I(DM_VERSION_CMD, 0, NULL, 0, 0), /* version is dealt with elsewhere */
 		I(DM_REMOVE_ALL_CMD, IOCTL_FLAGS_NO_PARAMS | IOCTL_FLAGS_ISSUE_GLOBAL_EVENT, remove_all,
-		 DM_DEFERRED_REMOVE),
-		I(DM_LIST_DEVICES_CMD, 0, list_devices, DM_UUID_FLAG),
+		 DM_DEFERRED_REMOVE, 0),
+		I(DM_LIST_DEVICES_CMD, 0, list_devices, DM_UUID_FLAG, 0),
 		I(DM_DEV_CREATE_CMD, IOCTL_FLAGS_NO_PARAMS | IOCTL_FLAGS_ISSUE_GLOBAL_EVENT, dev_create,
-		 DM_PERSISTENT_DEV_FLAG),
+		 DM_PERSISTENT_DEV_FLAG, DM_DISABLE_UEVENTS_FLAG),
 		I(DM_DEV_REMOVE_CMD, IOCTL_FLAGS_NO_PARAMS | IOCTL_FLAGS_ISSUE_GLOBAL_EVENT, dev_remove,
-		 DM_DEFERRED_REMOVE),
+		 DM_DEFERRED_REMOVE, 0),
 		I(DM_DEV_RENAME_CMD, IOCTL_FLAGS_ISSUE_GLOBAL_EVENT, dev_rename,
-		 DM_QUERY_INACTIVE_TABLE_FLAG | DM_UUID_FLAG),
+		 DM_QUERY_INACTIVE_TABLE_FLAG | DM_UUID_FLAG, 0),
 		I(DM_DEV_SUSPEND_CMD, IOCTL_FLAGS_NO_PARAMS, dev_suspend,
-		 DM_QUERY_INACTIVE_TABLE_FLAG | DM_SUSPEND_FLAG | DM_SKIP_LOCKFS_FLAG | DM_NOFLUSH_FLAG),
-		I(DM_DEV_STATUS_CMD, IOCTL_FLAGS_NO_PARAMS, dev_status, DM_QUERY_INACTIVE_TABLE_FLAG),
+		 DM_QUERY_INACTIVE_TABLE_FLAG | DM_SUSPEND_FLAG | DM_SKIP_LOCKFS_FLAG | DM_NOFLUSH_FLAG, 0),
+		I(DM_DEV_STATUS_CMD, IOCTL_FLAGS_NO_PARAMS, dev_status, DM_QUERY_INACTIVE_TABLE_FLAG, 0),
 		I(DM_DEV_WAIT_CMD, IOCTL_FLAGS_TAKES_EVENT_NR, dev_wait,
-		 DM_QUERY_INACTIVE_TABLE_FLAG | DM_STATUS_TABLE_FLAG | DM_NOFLUSH_FLAG),
-		I(DM_TABLE_LOAD_CMD, 0, table_load, DM_QUERY_INACTIVE_TABLE_FLAG | DM_READONLY_FLAG),
-		I(DM_TABLE_CLEAR_CMD, IOCTL_FLAGS_NO_PARAMS, table_clear, DM_QUERY_INACTIVE_TABLE_FLAG),
-		I(DM_TABLE_DEPS_CMD, 0, table_deps, DM_QUERY_INACTIVE_TABLE_FLAG),
+		 DM_QUERY_INACTIVE_TABLE_FLAG | DM_STATUS_TABLE_FLAG | DM_NOFLUSH_FLAG, 0),
+		I(DM_TABLE_LOAD_CMD, 0, table_load, DM_QUERY_INACTIVE_TABLE_FLAG | DM_READONLY_FLAG, 0),
+		I(DM_TABLE_CLEAR_CMD, IOCTL_FLAGS_NO_PARAMS, table_clear, DM_QUERY_INACTIVE_TABLE_FLAG, 0),
+		I(DM_TABLE_DEPS_CMD, 0, table_deps, DM_QUERY_INACTIVE_TABLE_FLAG, 0),
 		I(DM_TABLE_STATUS_CMD, 0, table_status,
-		 DM_QUERY_INACTIVE_TABLE_FLAG | DM_STATUS_TABLE_FLAG | DM_NOFLUSH_FLAG),
+		 DM_QUERY_INACTIVE_TABLE_FLAG | DM_STATUS_TABLE_FLAG | DM_NOFLUSH_FLAG, 0),
 
-		I(DM_LIST_VERSIONS_CMD, 0, list_versions, 0),
+		I(DM_LIST_VERSIONS_CMD, 0, list_versions, 0, 0),
 
-		I(DM_TARGET_MSG_CMD, 0, target_message, DM_QUERY_INACTIVE_TABLE_FLAG),
-		I(DM_DEV_SET_GEOMETRY_CMD, 0, dev_set_geometry, 0),
-		I(DM_DEV_ARM_POLL_CMD, IOCTL_FLAGS_NO_PARAMS, dev_arm_poll, 0),
-		I(DM_GET_TARGET_VERSION_CMD, 0, get_target_version, 0),
+		I(DM_TARGET_MSG_CMD, 0, target_message, DM_QUERY_INACTIVE_TABLE_FLAG, 0),
+		I(DM_DEV_SET_GEOMETRY_CMD, 0, dev_set_geometry, 0, 0),
+		I(DM_DEV_ARM_POLL_CMD, IOCTL_FLAGS_NO_PARAMS, dev_arm_poll, 0, 0),
+		I(DM_GET_TARGET_VERSION_CMD, 0, get_target_version, 0, 0),
 	};
 
 	if (unlikely(cmd >= ARRAY_SIZE(_ioctls)))
 		return NULL;
 
 	cmd = array_index_nospec(cmd, ARRAY_SIZE(_ioctls));
-	*supported_flags = _ioctls[cmd].supported_flags;
+	*supported_flags = strict ? _ioctls[cmd].strict_flags : _ioctls[cmd].supported_flags;
 	*ioctl_flags = _ioctls[cmd].flags;
 	return _ioctls[cmd].fn;
 }
@@ -2233,7 +2235,7 @@ static int ctl_ioctl(struct file *file, uint command, struct dm_ioctl __user *us
 	if (cmd == DM_VERSION_CMD)
 		return 0;
 
-	fn = lookup_ioctl(cmd, &ioctl_flags, &supported_flags);
+	fn = lookup_ioctl(cmd, !sloppy_checks(&param_kernel), &ioctl_flags, &supported_flags);
 	if (!fn) {
 		DMERR("dm_ctl_ioctl: unknown command 0x%x", command);
 		return -ENOTTY;
@@ -2451,7 +2453,7 @@ int __init dm_early_create(struct dm_ioctl *dmi,
 		m = MINOR(huge_decode_dev(dmi->dev));
 
 	/* alloc dm device */
-	r = dm_create(m, &md);
+	r = dm_create(m, &md, false);
 	if (r)
 		return r;
 
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 3b694ba3a106e68d4c0d5e64cd9136cf7abce237..efdf70a331cb681a88490f45d26259c29ddac850 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -2276,13 +2276,14 @@ static struct dm_table *__unbind(struct mapped_device *md)
 /*
  * Constructor for a new device.
  */
-int dm_create(int minor, struct mapped_device **result)
+int dm_create(int minor, struct mapped_device **result, bool disable_uevents)
 {
 	struct mapped_device *md;
 
 	md = alloc_dev(minor);
 	if (!md)
 		return -ENXIO;
+	md->disable_uevents = disable_uevents;
 
 	dm_ima_reset_data(md);
 
@@ -2999,6 +3000,8 @@ int dm_kobject_uevent(struct mapped_device *md, enum kobject_action action,
 	char udev_cookie[DM_COOKIE_LENGTH];
 	char *envp[3] = { NULL, NULL, NULL };
 	char **envpp = envp;
+	if (md->disable_uevents)
+		return 0;
 	if (cookie) {
 		snprintf(udev_cookie, DM_COOKIE_LENGTH, "%s=%u",
 			 DM_COOKIE_ENV_VAR_NAME, cookie);
diff --git a/include/linux/device-mapper.h b/include/linux/device-mapper.h
index a52d2b9a68460ac7951ad6ebe76d9a1cfccf7afb..7c8d7a7e8798d20e517e2264c06772ecd8b41ef3 100644
--- a/include/linux/device-mapper.h
+++ b/include/linux/device-mapper.h
@@ -463,7 +463,7 @@ void dm_consume_args(struct dm_arg_set *as, unsigned int num_args);
  * DM_ANY_MINOR chooses the next available minor number.
  */
 #define DM_ANY_MINOR (-1)
-int dm_create(int minor, struct mapped_device **md);
+int dm_create(int minor, struct mapped_device **md, bool disable_uevents);
 
 /*
  * Reference counting for md.
diff --git a/include/uapi/linux/dm-ioctl.h b/include/uapi/linux/dm-ioctl.h
index 5647b218f24b626f5c1cefe8bec18dc04373c3d0..07cc5bbb6944ebaa42ddfec6fd5e0413c535e7ff 100644
--- a/include/uapi/linux/dm-ioctl.h
+++ b/include/uapi/linux/dm-ioctl.h
@@ -356,8 +356,16 @@ enum {
 #define DM_BUFFER_FULL_FLAG	(1 << 8) /* Out */
 
 /*
- * This flag is now ignored if DM_VERSION_MAJOR is used, and causes
- * -EINVAL if DM_VERSION_MAJOR_STRICT is used.
+ * This flag is only recognized when DM_VERSION_MAJOR_STRICT is used.
+ * It tells the kernel to not generate any uevents for the newly-created
+ * device.  Using it outside of DM_DEV_CREATE results in -EINVAL.  When
+ * DM_VERSION_MAJOR is used this flag is ignored.
+ */
+#define DM_DISABLE_UEVENTS_FLAG	(1 << 9) /* In */
+
+/*
+ * This flag is now ignored if DM_VERSION_MAJOR is used.  When
+ * DM_VERSION_MAJOR_STRICT is used it is an alias for DM_DISABLE_UEVENT_FLAG.
  */
 #define DM_SKIP_BDGET_FLAG	(1 << 9) /* In */
 
@@ -426,8 +434,6 @@ enum {
 
 /*
  * If DM_VERSION_MAJOR is used, these flags are ignored by the kernel.
- * If DM_VERSION_MAJOR_STRICT is used, these flags are reserved and
- * must be zeroed.
  */
 #define DM_STRICT_ONLY_FLAGS ((__u32)(~((1UL << 19) - 1) | 1 << 9 | 1 << 7))
 
-- 
Sincerely,
Demi Marie Obenour (she/her/hers)
Invisible Things Lab

