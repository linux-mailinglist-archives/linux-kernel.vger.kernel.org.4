Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABBA8716ECD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 22:32:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231690AbjE3Ucj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 16:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233509AbjE3UcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 16:32:16 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4A831AE;
        Tue, 30 May 2023 13:31:56 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id AB9E13200920;
        Tue, 30 May 2023 16:31:54 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 30 May 2023 16:31:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        invisiblethingslab.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1685478714; x=1685565114; bh=G/PZMKR5fM
        icHWYQT0GxcmUHbUsQVYWUtsZvrUHCJuU=; b=Fx+b8PAh3kQful+76g25YMRpI5
        OX2hyNg04HQUYaN44eHLXL/rFm2SALtFR0112VOAhcyu7Q2sJwY1i66PmyE2SnTT
        GQ8zTaVT5pxBlG08qTCZ+FS3117iMs4IgwF+YZnRQsIjYuCt9Q9EcokEF1/w2QFv
        Twymq+8VxvVG/76A/z0fBAsNeDIatL11QxQzfwr7rrvR/Yezfnoab4FX2SdDIO8+
        3Z09WdrcZcDTQYfG4wiLLpb2iXwlJVjKAN2ocz+agmZSrrgePipjWehEJVX2cKu6
        l8BXqqbyb62oQpkjHAq0YFkp+2SFAkTxICtIqKbr7Q7NzkLJZ8C4XaiyGSzQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1685478714; x=
        1685565114; bh=G/PZMKR5fMicHWYQT0GxcmUHbUsQVYWUtsZvrUHCJuU=; b=s
        iYr85F64Hkrtm1e26WXimQt3qTnsJz10WHrpr4PvU8EdZ5UO6Qfqj67YBBt2BbFO
        PUipDPJEr6g34YqFLy8Hwa01eC3ltU7TdIquoCIcGBTWPS2otA5rs1uHUbwazjjK
        Ww7dGsxlG99lt+yj4HNnXShCkklC9RuO2GIiKVVdrv7njlCf5lZcH+cU8FlYF758
        DVOQ5dzfsR+WfY5BDpMPF7W7vjmlnSsmy/B0Ll5i1cVddn1sbTTYzNIoUN9Ql6Ib
        XM5XK8sKDq8W6Feu9Fioasb6HgQXeG3lzMjwIN3YEC91VleFfGumhwAmWhtxq+H3
        0DWvG8HfoOsaY0EOEduGg==
X-ME-Sender: <xms:Ol12ZHST1-c4k5KKrHyghT_SmLOvnhcOlxPM6knJUcdFSSMnKQtFgw>
    <xme:Ol12ZIwcKjQD2dhY7Tm1JfUHCs4wW7eWePj7sclDGhOohdK0Bpc9HoCUKopY4HuW6
    Omi1tU7shxtXi8>
X-ME-Received: <xmr:Ol12ZM1HBLxQQ-mpsHM-gJJjxe3fPxbQ4hzuZhukt82LYO3FlpWjCV3MlxhC1oc0-HaUvadSyZ4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeekjedgudeglecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeffvghm
    ihcuofgrrhhivgcuqfgsvghnohhurhcuoeguvghmihesihhnvhhishhisghlvghthhhinh
    hgshhlrggsrdgtohhmqeenucggtffrrghtthgvrhhnpeejffejgffgueegudevvdejkefg
    hefghffhffejteekleeufeffteffhfdtudehteenucevlhhushhtvghrufhiiigvpedune
    curfgrrhgrmhepmhgrihhlfhhrohhmpeguvghmihesihhnvhhishhisghlvghthhhinhhg
    shhlrggsrdgtohhm
X-ME-Proxy: <xmx:Ol12ZHAsNCJ4xwHw3TFK0t2zyMBNNsPy9Dr81PQ22kZ7mCjbE41uQg>
    <xmx:Ol12ZAhQp8O9m53jnJ2eMxtNDDK9k7jf5ZgN-p6xpX_aauv4Y_HIWA>
    <xmx:Ol12ZLrfatiJMsqo7x237vzd8RsIphoVGB0E4NWrLk38Q__DBUChJA>
    <xmx:Ol12ZMjhw_S6m1JhqMfd8QC_X-9xO459WsXWCWlW770znOftyAZ8TA>
Feedback-ID: iac594737:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 May 2023 16:31:53 -0400 (EDT)
From:   Demi Marie Obenour <demi@invisiblethingslab.com>
To:     Jens Axboe <axboe@kernel.dk>,
        =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com
Cc:     Demi Marie Obenour <demi@invisiblethingslab.com>,
        =?UTF-8?q?Marek=20Marczykowski-G=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org
Subject: [PATCH v2 07/16] device-mapper: Allow userspace to opt-in to strict parameter checks
Date:   Tue, 30 May 2023 16:31:07 -0400
Message-Id: <20230530203116.2008-8-demi@invisiblethingslab.com>
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

Currently, device-mapper ioctls ignore unknown flags.  This makes
adding new flags to a given ioctl risky, as it could potentially break
old userspace.

To solve this problem, allow userspace to pass 5 as the major version to
any ioctl.  This causes the kernel to reject any flags that are not
supported by the ioctl, as well as nonzero padding and names and UUIDs
that are not NUL-terminated.  New flags will only be recognized if major
version 5 is used.  Kernels without this patch return -EINVAL if the
major version is 5, so this is backwards compatible.

Signed-off-by: Demi Marie Obenour <demi@invisiblethingslab.com>
---
 drivers/md/dm-ioctl.c         | 301 ++++++++++++++++++++++++++--------
 include/uapi/linux/dm-ioctl.h |  30 +++-
 2 files changed, 260 insertions(+), 71 deletions(-)

diff --git a/drivers/md/dm-ioctl.c b/drivers/md/dm-ioctl.c
index 20f452b6c61c1c4d20259fd0fc5443977e4454a0..cf752e72ef6a2d8f8230e5bd6d1a6dc817a4f597 100644
--- a/drivers/md/dm-ioctl.c
+++ b/drivers/md/dm-ioctl.c
@@ -64,7 +64,8 @@ struct vers_iter {
 static struct rb_root name_rb_tree = RB_ROOT;
 static struct rb_root uuid_rb_tree = RB_ROOT;
 
-static void dm_hash_remove_all(bool keep_open_devices, bool mark_deferred, bool only_deferred);
+static void dm_hash_remove_all(bool keep_open_devices, bool mark_deferred, bool only_deferred,
+			       struct dm_ioctl *param);
 
 /*
  * Guards access to both hash tables.
@@ -78,7 +79,7 @@ static DEFINE_MUTEX(dm_hash_cells_mutex);
 
 static void dm_hash_exit(void)
 {
-	dm_hash_remove_all(false, false, false);
+	dm_hash_remove_all(false, false, false, NULL);
 }
 
 /*
@@ -333,7 +334,8 @@ static struct dm_table *__hash_remove(struct hash_cell *hc)
 	return table;
 }
 
-static void dm_hash_remove_all(bool keep_open_devices, bool mark_deferred, bool only_deferred)
+static void dm_hash_remove_all(bool keep_open_devices, bool mark_deferred, bool only_deferred,
+			       struct dm_ioctl *param)
 {
 	int dev_skipped;
 	struct rb_node *n;
@@ -367,6 +369,8 @@ static void dm_hash_remove_all(bool keep_open_devices, bool mark_deferred, bool
 			dm_table_destroy(t);
 		}
 		dm_ima_measure_on_device_remove(md, true);
+		if (param != NULL && !dm_kobject_uevent(md, KOBJ_REMOVE, param->event_nr, false))
+			param->flags |= DM_UEVENT_GENERATED_FLAG;
 		dm_put(md);
 		if (likely(keep_open_devices))
 			dm_destroy(md);
@@ -513,7 +517,7 @@ static struct mapped_device *dm_hash_rename(struct dm_ioctl *param,
 
 void dm_deferred_remove(void)
 {
-	dm_hash_remove_all(true, false, true);
+	dm_hash_remove_all(true, false, true, NULL);
 }
 
 /*
@@ -529,7 +533,7 @@ typedef int (*ioctl_fn)(struct file *filp, struct dm_ioctl *param, size_t param_
 
 static int remove_all(struct file *filp, struct dm_ioctl *param, size_t param_size)
 {
-	dm_hash_remove_all(true, !!(param->flags & DM_DEFERRED_REMOVE), false);
+	dm_hash_remove_all(true, !!(param->flags & DM_DEFERRED_REMOVE), false, param);
 	param->data_size = 0;
 	return 0;
 }
@@ -892,8 +896,6 @@ static int dev_create(struct file *filp, struct dm_ioctl *param, size_t param_si
 		return r;
 	}
 
-	param->flags &= ~DM_INACTIVE_PRESENT_FLAG;
-
 	__dev_status(md, param);
 
 	dm_put(md);
@@ -947,8 +949,6 @@ static struct hash_cell *__find_device_hash_cell(struct dm_ioctl *param)
 
 	if (hc->new_map)
 		param->flags |= DM_INACTIVE_PRESENT_FLAG;
-	else
-		param->flags &= ~DM_INACTIVE_PRESENT_FLAG;
 
 	return hc;
 }
@@ -1161,7 +1161,6 @@ static int do_resume(struct dm_ioctl *param)
 
 	new_map = hc->new_map;
 	hc->new_map = NULL;
-	param->flags &= ~DM_INACTIVE_PRESENT_FLAG;
 
 	up_write(&_hash_lock);
 
@@ -1426,6 +1425,32 @@ static int next_target(struct dm_target_spec *last, uint32_t next, const char *e
 	return 0;
 }
 
+static inline bool sloppy_checks(const struct dm_ioctl *param)
+{
+	return param->version[0] < DM_VERSION_MAJOR_STRICT;
+}
+
+static bool no_non_nul_after_nul(const char *untrusted_str, size_t size,
+				 unsigned int cmd, const char *msg)
+{
+	const char *cursor;
+	const char *endp = untrusted_str + size;
+	const char *nul_terminator = memchr(untrusted_str, '\0', size);
+
+	if (nul_terminator == NULL) {
+		DMERR("%s not NUL-terminated, cmd(%u)", msg, cmd);
+		return false;
+	}
+	for (cursor = nul_terminator; cursor < endp; cursor++) {
+		if (*cursor != 0) {
+			DMERR("%s has non-NUL byte at %zd after NUL byte at %zd, cmd(%u)",
+			      msg, cursor - untrusted_str, nul_terminator - untrusted_str, cmd);
+			return false;
+		}
+	}
+	return true;
+}
+
 static int populate_table(struct dm_table *table,
 			  struct dm_ioctl *param, size_t param_size)
 {
@@ -1436,12 +1461,19 @@ static int populate_table(struct dm_table *table,
 	const char *const end = (const char *) param + param_size;
 	char *target_params;
 	size_t min_size = sizeof(struct dm_ioctl);
+	bool const strict = !sloppy_checks(param);
 
 	if (!param->target_count) {
 		DMERR("%s: no targets specified", __func__);
 		return -EINVAL;
 	}
 
+	if (strict && param_size % 8 != 0) {
+		DMERR("%s: parameter size %zu not multiple of 8",
+		      __func__, param_size);
+		return -EINVAL;
+	}
+
 	for (i = 0; i < param->target_count; i++) {
 		const char *nul_terminator;
 
@@ -1466,6 +1498,18 @@ static int populate_table(struct dm_table *table,
 		/* Add 1 for NUL terminator */
 		min_size = (nul_terminator - (const char *)spec) + 1;
 
+		if (strict) {
+			if (!no_non_nul_after_nul(spec->target_type, sizeof(spec->target_type),
+						  DM_TABLE_LOAD_CMD, "target type"))
+				return -EINVAL;
+
+			if (spec->status) {
+				DMERR("%s: status in target spec must be zero, not %u",
+				      __func__, spec->status);
+				return -EINVAL;
+			}
+		}
+
 		r = dm_table_add_target(table, spec->target_type,
 					(sector_t) spec->sector_start,
 					(sector_t) spec->length,
@@ -1476,6 +1520,32 @@ static int populate_table(struct dm_table *table,
 		}
 
 		next = spec->next;
+
+		if (strict) {
+			uint64_t zero = 0;
+			/*
+			 * param_size is a multiple of 8 so this is still in
+			 * bounds (or 1 past the end).
+			 */
+			size_t expected_next = round_up(min_size, 8);
+
+			if (expected_next != next) {
+				DMERR("%s: in strict mode, expected next to be %zu but it was %u",
+				      __func__, expected_next, next);
+				return -EINVAL;
+			}
+
+			if (memcmp(&zero, nul_terminator, next - min_size + 1) != 0) {
+				DMERR("%s: in strict mode, padding must be zeroed", __func__);
+				return -EINVAL;
+			}
+		}
+	}
+
+	if (strict && next != (size_t)(end - (const char *)spec)) {
+		DMERR("%s: last target size is %u, but %zd bytes remaining in target spec",
+		      __func__, next, end - (const char *)spec);
+		return -EINVAL;
 	}
 
 	return dm_table_complete(table);
@@ -1823,48 +1893,67 @@ static int target_message(struct file *filp, struct dm_ioctl *param, size_t para
  * the ioctl.
  */
 #define IOCTL_FLAGS_NO_PARAMS		1
-#define IOCTL_FLAGS_ISSUE_GLOBAL_EVENT	2
+#define IOCTL_FLAGS_TAKES_EVENT_NR      2
+#define IOCTL_FLAGS_ISSUE_GLOBAL_EVENT	(IOCTL_FLAGS_TAKES_EVENT_NR | 4)
 
 /*
  *---------------------------------------------------------------
  * Implementation of open/close/ioctl on the special char device.
  *---------------------------------------------------------------
  */
-static ioctl_fn lookup_ioctl(unsigned int cmd, int *ioctl_flags)
+static ioctl_fn lookup_ioctl(unsigned int cmd, int *ioctl_flags, uint32_t *supported_flags)
 {
 	static const struct {
 		int cmd;
 		int flags;
 		ioctl_fn fn;
+		uint32_t supported_flags;
 	} _ioctls[] = {
-		{DM_VERSION_CMD, 0, NULL}, /* version is dealt with elsewhere */
-		{DM_REMOVE_ALL_CMD, IOCTL_FLAGS_NO_PARAMS | IOCTL_FLAGS_ISSUE_GLOBAL_EVENT, remove_all},
-		{DM_LIST_DEVICES_CMD, 0, list_devices},
+		/* Macro to make the structure initializers somewhat readable */
+#define I(cmd, flags, fn, supported_flags) {							\
+	(cmd),											\
+	(flags),										\
+	(fn),											\
+	/*											\
+	 * Supported flags in sloppy mode must not include anything in DM_STRICT_ONLY_FLAGS.	\
+	 * Use BUILD_BUG_ON_ZERO to check for that.						\
+	 */											\
+	(supported_flags) | BUILD_BUG_ON_ZERO((supported_flags) & DM_STRICT_ONLY_FLAGS),	\
+}
+		I(DM_VERSION_CMD, 0, NULL, 0), /* version is dealt with elsewhere */
+		I(DM_REMOVE_ALL_CMD, IOCTL_FLAGS_NO_PARAMS | IOCTL_FLAGS_ISSUE_GLOBAL_EVENT, remove_all,
+		 DM_DEFERRED_REMOVE),
+		I(DM_LIST_DEVICES_CMD, 0, list_devices, DM_UUID_FLAG),
+		I(DM_DEV_CREATE_CMD, IOCTL_FLAGS_NO_PARAMS | IOCTL_FLAGS_ISSUE_GLOBAL_EVENT, dev_create,
+		 DM_PERSISTENT_DEV_FLAG),
+		I(DM_DEV_REMOVE_CMD, IOCTL_FLAGS_NO_PARAMS | IOCTL_FLAGS_ISSUE_GLOBAL_EVENT, dev_remove,
+		 DM_DEFERRED_REMOVE),
+		I(DM_DEV_RENAME_CMD, IOCTL_FLAGS_ISSUE_GLOBAL_EVENT, dev_rename,
+		 DM_QUERY_INACTIVE_TABLE_FLAG | DM_UUID_FLAG),
+		I(DM_DEV_SUSPEND_CMD, IOCTL_FLAGS_NO_PARAMS, dev_suspend,
+		 DM_QUERY_INACTIVE_TABLE_FLAG | DM_SUSPEND_FLAG | DM_SKIP_LOCKFS_FLAG | DM_NOFLUSH_FLAG),
+		I(DM_DEV_STATUS_CMD, IOCTL_FLAGS_NO_PARAMS, dev_status, DM_QUERY_INACTIVE_TABLE_FLAG),
+		I(DM_DEV_WAIT_CMD, IOCTL_FLAGS_TAKES_EVENT_NR, dev_wait,
+		 DM_QUERY_INACTIVE_TABLE_FLAG | DM_STATUS_TABLE_FLAG | DM_NOFLUSH_FLAG),
+		I(DM_TABLE_LOAD_CMD, 0, table_load, DM_QUERY_INACTIVE_TABLE_FLAG | DM_READONLY_FLAG),
+		I(DM_TABLE_CLEAR_CMD, IOCTL_FLAGS_NO_PARAMS, table_clear, DM_QUERY_INACTIVE_TABLE_FLAG),
+		I(DM_TABLE_DEPS_CMD, 0, table_deps, DM_QUERY_INACTIVE_TABLE_FLAG),
+		I(DM_TABLE_STATUS_CMD, 0, table_status,
+		 DM_QUERY_INACTIVE_TABLE_FLAG | DM_STATUS_TABLE_FLAG | DM_NOFLUSH_FLAG),
 
-		{DM_DEV_CREATE_CMD, IOCTL_FLAGS_NO_PARAMS | IOCTL_FLAGS_ISSUE_GLOBAL_EVENT, dev_create},
-		{DM_DEV_REMOVE_CMD, IOCTL_FLAGS_NO_PARAMS | IOCTL_FLAGS_ISSUE_GLOBAL_EVENT, dev_remove},
-		{DM_DEV_RENAME_CMD, IOCTL_FLAGS_ISSUE_GLOBAL_EVENT, dev_rename},
-		{DM_DEV_SUSPEND_CMD, IOCTL_FLAGS_NO_PARAMS, dev_suspend},
-		{DM_DEV_STATUS_CMD, IOCTL_FLAGS_NO_PARAMS, dev_status},
-		{DM_DEV_WAIT_CMD, 0, dev_wait},
+		I(DM_LIST_VERSIONS_CMD, 0, list_versions, 0),
 
-		{DM_TABLE_LOAD_CMD, 0, table_load},
-		{DM_TABLE_CLEAR_CMD, IOCTL_FLAGS_NO_PARAMS, table_clear},
-		{DM_TABLE_DEPS_CMD, 0, table_deps},
-		{DM_TABLE_STATUS_CMD, 0, table_status},
-
-		{DM_LIST_VERSIONS_CMD, 0, list_versions},
-
-		{DM_TARGET_MSG_CMD, 0, target_message},
-		{DM_DEV_SET_GEOMETRY_CMD, 0, dev_set_geometry},
-		{DM_DEV_ARM_POLL_CMD, IOCTL_FLAGS_NO_PARAMS, dev_arm_poll},
-		{DM_GET_TARGET_VERSION_CMD, 0, get_target_version},
+		I(DM_TARGET_MSG_CMD, 0, target_message, DM_QUERY_INACTIVE_TABLE_FLAG),
+		I(DM_DEV_SET_GEOMETRY_CMD, 0, dev_set_geometry, 0),
+		I(DM_DEV_ARM_POLL_CMD, IOCTL_FLAGS_NO_PARAMS, dev_arm_poll, 0),
+		I(DM_GET_TARGET_VERSION_CMD, 0, get_target_version, 0),
 	};
 
 	if (unlikely(cmd >= ARRAY_SIZE(_ioctls)))
 		return NULL;
 
 	cmd = array_index_nospec(cmd, ARRAY_SIZE(_ioctls));
+	*supported_flags = _ioctls[cmd].supported_flags;
 	*ioctl_flags = _ioctls[cmd].flags;
 	return _ioctls[cmd].fn;
 }
@@ -1877,27 +1966,34 @@ static int check_version(unsigned int cmd, struct dm_ioctl __user *user,
 			 struct dm_ioctl *kernel_params)
 {
 	int r = 0;
-	uint32_t *version = kernel_params->version;
+	uint32_t expected_major_version = DM_VERSION_MAJOR;
 
-	if (copy_from_user(version, user->version, sizeof(user->version)))
+	if (copy_from_user(kernel_params->version, user->version, sizeof(kernel_params->version)))
 		return -EFAULT;
 
-	if ((version[0] != DM_VERSION_MAJOR) ||
-	    (version[1] > DM_VERSION_MINOR)) {
+	if (kernel_params->version[0] >= DM_VERSION_MAJOR_STRICT)
+		expected_major_version = DM_VERSION_MAJOR_STRICT;
+
+	if ((kernel_params->version[0] != expected_major_version) ||
+	    (kernel_params->version[1] > DM_VERSION_MINOR)) {
 		DMERR("ioctl interface mismatch: kernel(%u.%u.%u), user(%u.%u.%u), cmd(%d)",
-		      DM_VERSION_MAJOR, DM_VERSION_MINOR,
+		      expected_major_version,
+		      DM_VERSION_MINOR,
 		      DM_VERSION_PATCHLEVEL,
-		      version[0], version[1], version[2], cmd);
+		      kernel_params->version[0],
+		      kernel_params->version[1],
+		      kernel_params->version[2],
+		      cmd);
 		r = -EINVAL;
 	}
 
 	/*
 	 * Fill in the kernel version.
 	 */
-	version[0] = DM_VERSION_MAJOR;
-	version[1] = DM_VERSION_MINOR;
-	version[2] = DM_VERSION_PATCHLEVEL;
-	if (copy_to_user(user->version, version, sizeof(version)))
+	kernel_params->version[0] = expected_major_version;
+	kernel_params->version[1] = DM_VERSION_MINOR;
+	kernel_params->version[2] = DM_VERSION_PATCHLEVEL;
+	if (copy_to_user(user->version, kernel_params->version, sizeof(kernel_params->version)))
 		return -EFAULT;
 
 	return r;
@@ -1920,9 +2016,12 @@ static int copy_params(struct dm_ioctl __user *user, struct dm_ioctl *param_kern
 {
 	struct dm_ioctl *dmi;
 	int secure_data;
-	const size_t minimum_data_size = offsetof(struct dm_ioctl, data);
+	const size_t minimum_data_size = sloppy_checks(param_kernel) ?
+		offsetof(struct dm_ioctl, data) : sizeof(struct dm_ioctl);
 	unsigned int noio_flag;
 
+	static_assert(offsetof(struct dm_ioctl, data_size) == sizeof(param_kernel->version));
+	static_assert(offsetof(struct dm_ioctl, data_size) == 12);
 	/* Version has been copied from userspace already, avoid TOCTOU */
 	if (copy_from_user((char *)param_kernel + sizeof(param_kernel->version),
 			   (char __user *)user + sizeof(param_kernel->version),
@@ -1930,12 +2029,13 @@ static int copy_params(struct dm_ioctl __user *user, struct dm_ioctl *param_kern
 		return -EFAULT;
 
 	if (param_kernel->data_size < minimum_data_size) {
-		DMERR("Invalid data size in the ioctl structure: %u",
-		      param_kernel->data_size);
+		DMERR("Invalid data size in the ioctl structure: %u (minimum %zu)",
+		      param_kernel->data_size, minimum_data_size);
 		return -EINVAL;
 	}
 
 	secure_data = param_kernel->flags & DM_SECURE_DATA_FLAG;
+	param_kernel->flags &= ~DM_SECURE_DATA_FLAG;
 
 	*param_flags = secure_data ? DM_WIPE_BUFFER : 0;
 
@@ -1966,7 +2066,8 @@ static int copy_params(struct dm_ioctl __user *user, struct dm_ioctl *param_kern
 	/* Copy from param_kernel (which was already copied from user) */
 	memcpy(dmi, param_kernel, minimum_data_size);
 
-	if (copy_from_user(&dmi->data, (char __user *)user + minimum_data_size,
+	if (copy_from_user((char *)dmi + minimum_data_size,
+			   (char __user *)user + minimum_data_size,
 			   param_kernel->data_size - minimum_data_size))
 		goto bad;
 data_copied:
@@ -1983,33 +2084,86 @@ static int copy_params(struct dm_ioctl __user *user, struct dm_ioctl *param_kern
 	return -EFAULT;
 }
 
-static int validate_params(uint cmd, struct dm_ioctl *param)
+static int validate_params(uint cmd, struct dm_ioctl *param,
+			   uint32_t ioctl_flags, uint32_t supported_flags)
 {
-	/* Always clear this flag */
-	param->flags &= ~DM_BUFFER_FULL_FLAG;
-	param->flags &= ~DM_UEVENT_GENERATED_FLAG;
-	param->flags &= ~DM_SECURE_DATA_FLAG;
-	param->flags &= ~DM_DATA_OUT_FLAG;
-
-	/* Ignores parameters */
-	if (cmd == DM_REMOVE_ALL_CMD ||
-	    cmd == DM_LIST_DEVICES_CMD ||
-	    cmd == DM_LIST_VERSIONS_CMD)
-		return 0;
+	static_assert(__same_type(param->flags, supported_flags));
+	u64 zero = 0;
 
 	if (cmd == DM_DEV_CREATE_CMD) {
 		if (!*param->name) {
 			DMERR("name not supplied when creating device");
 			return -EINVAL;
 		}
-	} else if (*param->uuid && *param->name) {
-		DMERR("only supply one of name or uuid, cmd(%u)", cmd);
+	} else {
+		if (*param->uuid && *param->name) {
+			DMERR("only supply one of name or uuid, cmd(%u)", cmd);
+			return -EINVAL;
+		}
+	}
+
+	if (sloppy_checks(param)) {
+		/* Ensure strings are terminated */
+		param->name[DM_NAME_LEN - 1] = '\0';
+		param->uuid[DM_UUID_LEN - 1] = '\0';
+		/* Mask off bits that could confuse other code */
+		param->flags &= ~DM_STRICT_ONLY_FLAGS;
+		/* Skip strict checks */
+		return 0;
+	}
+
+	/* Check that strings are terminated */
+	if (!no_non_nul_after_nul(param->name, DM_NAME_LEN, cmd, "Name") ||
+	    !no_non_nul_after_nul(param->uuid, DM_UUID_LEN, cmd, "UUID")) {
 		return -EINVAL;
 	}
 
-	/* Ensure strings are terminated */
-	param->name[DM_NAME_LEN - 1] = '\0';
-	param->uuid[DM_UUID_LEN - 1] = '\0';
+	if (memcmp(param->data, &zero, sizeof(param->data)) != 0) {
+		DMERR("second padding field not zeroed in strict mode (cmd %u)", cmd);
+		return -EINVAL;
+	}
+
+	if (param->flags & ~supported_flags) {
+		DMERR("unsupported flags 0x%x specified, cmd(%u)",
+		      param->flags & ~supported_flags, cmd);
+		return -EINVAL;
+	}
+
+	if (param->padding) {
+		DMERR("padding not zeroed in strict mode (got %u, cmd %u)",
+		      param->padding, cmd);
+		return -EINVAL;
+	}
+
+	if (param->open_count != 0) {
+		DMERR("open_count not zeroed in strict mode (got %d, cmd %u)",
+		      param->open_count, cmd);
+		return -EINVAL;
+	}
+
+	if (param->event_nr != 0 && (ioctl_flags & IOCTL_FLAGS_TAKES_EVENT_NR) == 0) {
+		DMERR("Event number not zeroed for command that does not take one (got %u, cmd %u)",
+		      param->event_nr, cmd);
+		return -EINVAL;
+	}
+
+	if (ioctl_flags & IOCTL_FLAGS_NO_PARAMS) {
+		/* Ignores parameters */
+		if (param->data_size != sizeof(struct dm_ioctl)) {
+			DMERR("command %u must not have parameters", cmd);
+			return -EINVAL;
+		}
+
+		if (param->target_count != 0) {
+			DMERR("command %u must have zero target_count", cmd);
+			return -EINVAL;
+		}
+
+		if (param->data_start) {
+			DMERR("command %u must have zero data_start", cmd);
+			return -EINVAL;
+		}
+	}
 
 	return 0;
 }
@@ -2024,6 +2178,7 @@ static int ctl_ioctl(struct file *file, uint command, struct dm_ioctl __user *us
 	ioctl_fn fn = NULL;
 	size_t input_param_size;
 	struct dm_ioctl param_kernel;
+	uint32_t supported_flags, old_flags;
 
 	/* only root can play with this */
 	if (!capable(CAP_SYS_ADMIN))
@@ -2039,7 +2194,7 @@ static int ctl_ioctl(struct file *file, uint command, struct dm_ioctl __user *us
 	 * writes out the kernel's interface version.
 	 */
 	r = check_version(cmd, user, &param_kernel);
-	if (r)
+	if (r != 0)
 		return r;
 
 	/*
@@ -2048,7 +2203,7 @@ static int ctl_ioctl(struct file *file, uint command, struct dm_ioctl __user *us
 	if (cmd == DM_VERSION_CMD)
 		return 0;
 
-	fn = lookup_ioctl(cmd, &ioctl_flags);
+	fn = lookup_ioctl(cmd, &ioctl_flags, &supported_flags);
 	if (!fn) {
 		DMERR("dm_ctl_ioctl: unknown command 0x%x", command);
 		return -ENOTTY;
@@ -2063,11 +2218,20 @@ static int ctl_ioctl(struct file *file, uint command, struct dm_ioctl __user *us
 		return r;
 
 	input_param_size = param->data_size;
-	r = validate_params(cmd, param);
+
+	/*
+	 * In sloppy mode, validate_params will clear some
+	 * flags to ensure other code does not get confused.
+	 * Save the original flags here.
+	 */
+	old_flags = param->flags;
+	r = validate_params(cmd, param, ioctl_flags, supported_flags);
 	if (r)
 		goto out;
+	/* This XOR keeps only the flags validate_params has changed. */
+	old_flags ^= param->flags;
 
-	param->data_size = offsetof(struct dm_ioctl, data);
+	param->data_size = sloppy_checks(param) ? offsetof(struct dm_ioctl, data) : sizeof(struct dm_ioctl);
 	r = fn(file, param, input_param_size);
 
 	if (unlikely(param->flags & DM_BUFFER_FULL_FLAG) &&
@@ -2077,6 +2241,9 @@ static int ctl_ioctl(struct file *file, uint command, struct dm_ioctl __user *us
 	if (!r && ioctl_flags & IOCTL_FLAGS_ISSUE_GLOBAL_EVENT)
 		dm_issue_global_event();
 
+	/* Resture the flags that validate_params cleared */
+	param->flags |= old_flags;
+
 	/*
 	 * Copy the results back to userland.
 	 */
diff --git a/include/uapi/linux/dm-ioctl.h b/include/uapi/linux/dm-ioctl.h
index 1990b5700f6948243def314cec22f380926aca2e..81103e1dcdac3015204e9c05d73037191e965d59 100644
--- a/include/uapi/linux/dm-ioctl.h
+++ b/include/uapi/linux/dm-ioctl.h
@@ -171,8 +171,11 @@ struct dm_target_spec {
 
 	/*
 	 * Parameter string starts immediately after this object.
-	 * Be careful to add padding after string to ensure correct
-	 * alignment of subsequent dm_target_spec.
+	 * Be careful to add padding after string to ensure 8-byte
+	 * alignment of subsequent dm_target_spec.  If the major version
+	 * is DM_VERSION_MAJOR_STRICT, the padding must be at most 7 bytes,
+	 * (not including the terminating NULt that ends the string) and
+	 * must be zeroed.
 	 */
 };
 
@@ -285,14 +288,25 @@ enum {
 #define DM_TARGET_MSG	 _IOWR(DM_IOCTL, DM_TARGET_MSG_CMD, struct dm_ioctl)
 #define DM_DEV_SET_GEOMETRY	_IOWR(DM_IOCTL, DM_DEV_SET_GEOMETRY_CMD, struct dm_ioctl)
 
+/* Legacy major version */
 #define DM_VERSION_MAJOR	4
-#define DM_VERSION_MINOR	48
+/*
+ * New major version.  Enforces strict parameter checks and is required for
+ * using some new features, such as new flags.  Should be used by all new code.
+ *
+ * If one uses DM_VERSION_MAJOR_STRICT, it is possible for the behavior of
+ * ioctls to depend on the minor version passed by userspace.  Userspace must
+ * not pass a minor version greater than the version it was designed for.
+ */
+#define DM_VERSION_MAJOR_STRICT 5
+#define DM_VERSION_MINOR	49
 #define DM_VERSION_PATCHLEVEL	0
 #define DM_VERSION_EXTRA	"-ioctl (2023-03-01)"
 
 /* Status bits */
 #define DM_READONLY_FLAG	(1 << 0) /* In/Out */
 #define DM_SUSPEND_FLAG		(1 << 1) /* In/Out */
+#define DM_EXISTS_FLAG		(1 << 2) /* Not used by kernel, reserved for libdevmapper in userland */
 #define DM_PERSISTENT_DEV_FLAG	(1 << 3) /* In */
 
 /*
@@ -315,7 +329,8 @@ enum {
 #define DM_BUFFER_FULL_FLAG	(1 << 8) /* Out */
 
 /*
- * This flag is now ignored.
+ * This flag is now ignored if DM_VERSION_MAJOR is used, and causes
+ * -EINVAL if DM_VERSION_MAJOR_STRICT is used.
  */
 #define DM_SKIP_BDGET_FLAG	(1 << 9) /* In */
 
@@ -382,4 +397,11 @@ enum {
  */
 #define DM_IMA_MEASUREMENT_FLAG	(1 << 19) /* In */
 
+/*
+ * If DM_VERSION_MAJOR is used, these flags are ignored by the kernel.
+ * If DM_VERSION_MAJOR_STRICT is used, these flags are reserved and
+ * must be zeroed.
+ */
+#define DM_STRICT_ONLY_FLAGS ((__u32)0xFFF00004)
+
 #endif				/* _LINUX_DM_IOCTL_H */
-- 
Sincerely,
Demi Marie Obenour (she/her/hers)
Invisible Things Lab

