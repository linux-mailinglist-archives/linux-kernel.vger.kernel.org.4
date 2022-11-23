Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45F1B636AA9
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 21:16:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235827AbiKWUQT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 15:16:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235668AbiKWUQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 15:16:10 -0500
Received: from sonic311-30.consmr.mail.ne1.yahoo.com (sonic311-30.consmr.mail.ne1.yahoo.com [66.163.188.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07BFA6A75E
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 12:16:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1669234566; bh=lR1WPTQsYCs027PfXFxcPYUIMClhN9K8rmJdoIAAV1I=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=q0Y4g+rVKwvhiH8pzbVyGGS+VUX9ONa9LjJqvF3l108wK/hduExEFcLdAnbCf4Z8RWymtQy7cxhzVF/k8Pls2yLsAbYjtD8NP1BPO1ZvUiZ+mAPCZ0UwyPEPFeNPrXsMRQXgJQ8L7FpS42i24dcNxaDKPAIWsMgPdEOFSTKjufn8EmsaV7CAyopBR6RlG+yhSUBAPvmKEsUYttWDhZVZzR/jylWYPa68PymdGk+RCqkufhNY8dMP3MDr+jubpPcfjRtpgwnKZxD5l9ewhsl80oHdzBRbUb1xUmPfh2poLAF5qc+Ju1LE6TDpL3G9B29znnqf3xbKUAn4IbEOu8DB1A==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1669234566; bh=KxaLg5bAWvTLVjWoFA563a2lfKYa+745pCsc8yUbTj+=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=FVZkYuRPF3I3wnzwKHjUcMooWDu6ePDAgXtYWAj6z9p0MgNiTPE06BD8J3OVPufCscF3IcLUTOMiy9BmW1wW8hKbsgqdVgaECu+2nYc+n8jL9541ca3MwzXw2aO3daLth8IEG5pUlZwht6/E2S+4T8eJTnuOQPBfMAjO3qCNq1MNqvVvn2eO8EKK3F6bf3dGN3CnibjhAoQ6Gz1WA/JHNwE80Mt7pyIfbB1LywrUAs3kyhF8lEonLr4/QaDXy9GM/pdcYyrgvtV/DSYt5hQlTffFsLsPvKbs19H0KqVyMixRPWp3wB19mkLl6lM/fiBEkHkoZbYfV09v+dS5DTcgaA==
X-YMail-OSG: _g6N3U8VM1mnSDtXkEv8Dj3Om1dPPbnMiMsrzHbYXEKStEX6tvkCdGOt7HqaFdr
 B0I2HQvmmvYfc6l2CWiOCpgyrZsIP4xXRvmlKexRqdKjn9Yo2GfJvd0hroQ3WCWQiEyMiP9_xFAh
 POe.dyf4QNq1emoYmAJ07O3WHr9pii1ydvq1TBPzB.ET5LeB2CCOMb5r.RVhl5E_r6.amtavHa0W
 snDg1QDmgcv82hBUI4vVcPIXJCtjHrLdnvVNFlfyXfTJLQwaNCJHtlBVEBeK4_sOG2D3zGDnyMYj
 eFgKU6whXEcc1CltYwJdcWCteXiGtFRSZR4gBMj82tLhsMdG1DmZsvhQ2lYzyaSYcZXPqysdxV8Y
 tsEl.EMs1DzuXkFdp09O_0aE_bb8pcM32JvpfRI5sUi.CJpymEcNOzdeHo_QQZLSYveXITGZWRWW
 4BzFyf8zF_recGot2qo78lmnoezPODZkRjZ760TzLEC2GlJRuJWqwFGvKQMwU_3x2fd2y1l6aCYY
 q7sE7T86jElWFLgBz6WSzTWl3ceqvOiOIqbmmpiVSYympcoZ5aiD08OJHB0WkKCrBDJhaXDn3yFz
 b9pqyG24kCSO17KaG8a1YcT8XkCLgtrwcawYe_ypQ5GmKqAX3udnXEHtPAjqsbjcrqbWkcoPNAQa
 ejJUlHZt0YBgny1yMv2NhE38UpiQ3EpyrVKBI02YdBkn5338WTXoOa2MKI6Ls1X8HvrKNZl2rlFs
 KXvgbnivRpOxWYTmsfOeOus5kEXPTMrPhclYT9Y8CSEoKLzQdt60ccKvgLdBQa781LPYoDX_hlmj
 LmExWNqpmIzUewrfcuLlAJ49nTWWv5hUIcE6n_SHnIWkfJeZhzjK5keL.DcKm0CflFFBREDkQ47d
 2iMeCMgCotgOSBTIAIVi2HtHi5qZv6mjlti7jcn4qcyokmg8v4vmgP35fq9TBe8p1IwepF3_ojHS
 VQwafIBhMioSirFlSMNgzrqlxtxIhTPrA7P6m.eWGTKZenhSKHYvLiBgsyXkXrrMmkBwQVXyVdeI
 KmoxFVkkUSmLT2L_pyRw5d2vfM566pUYDDG2wlPwOvjWjNkGAMcduRdC.qz8faw9tvKdbW.13XLs
 IWL5_8RFzWkg8HNjR5APwvYjdSdjMb5xla__PKf0GdGsutEurYV46B81uiCUQEwQimD.QDCQNX61
 thx6CZ5BeNf8rIlIGVa8GqcJNNmEl3TR7UXk6.ykChPgvwYG2QE975L3hgcCkc85nZUQSx5BZTxP
 bY8YZvi5F5D0Cc7ilMWl7TC7aVL9mjSEwxkW5Hl8wxoN4wTKDmdvI0LCYeO.enKfARdVneQTvBjq
 bD_58E0K2wFUBeJRIMjpTKpaUjUuSTG2ByU7u25a1IFgujplqjVV.MH3vou2nIRHY0lm3Ky6AmR8
 ML3lG.RpntY9k7JXBl54Crt6jPPwOyYPoKnnlmG8irmsgxQgtfjwVuqtj1gKPCjPnI5vFrm2whOG
 oxriBPhWLbKOkj5R2EqXYI9O4Ux6gHJ16YiRFYKb6bo2hMqa80e_jc67bksitOSujYsTmrQjLdJQ
 dcOzC3m9pxNePUWSuR5TRzCHaIl21CS0FHiUbKZ8c.0c1OQjkZNnc0c2IM9BTTCEeNHd2xlG1.B.
 CSmwSUENmDTM.qvuI6JLldVrvHJV7jfyuk2ROowMcaMlhbTe_.mH4oTwP7njLCtEsQkbtHUMR4WS
 XszTb8XgUmyKLfxGzuhB97K2mIGLmVbNhVWzcTvr0Q1aR3LErzCbL7k6FQenLiwQ74ozozprGLo9
 ewkD40pk3U0X6iuUwZYy69rcdJI2WS.s3oA73L56B5k0CNaZU.aOoGHHT62SfFoLkQTLaqezYmyN
 YOmF52SalLOvtwLPLqtHISERV5pMdLpTWuo7f7qVIzJk8UZ.0PhMNuevOX3VD6feDnb_oMTn5mLN
 IBCRneI2HH6vp_loxVDdsL4uZ5pB_aOxhl5LPVahdYDKVzQUssrMjYwIK3dykzNL8dTwu80f22rT
 JX5Ly7rOvj920HLycQCK30NRpNF3zLsvYDNJf5GpbeMWRn_IdpJX7WdWErk3oYKwNYDg0aGAkENP
 pNVusx3eDMntIYmnfdc3BQHJiizYdga_YsRwcdgav4CuiWNl0IM2siqdp7ErwdZaVEui7YJaZc0F
 V25Bye6hC9uxWgPSGySouNXhWXgExVvj8ErbSmYJhy89EW1vvl62eXvU0Z5GwwZHk12TyTJP8jCm
 ZovDUdjlIvW74W16exzwSxMV34Um1GgBmLxLcRyYVWk0Z2u7TexWDgRC5jWMI9KfkJybW7GFE88J
 XLjmHzEyD2it1KDYiRaIwgT5IwH8-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Wed, 23 Nov 2022 20:16:06 +0000
Received: by hermes--production-bf1-5878955b5f-686fw (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 1f948ceb8dae6e5827701d3d40d1a9c3;
          Wed, 23 Nov 2022 20:16:00 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     casey@schaufler-ca.com, jmorris@namei.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net
Subject: [PATCH v3 1/9] LSM: Identify modules by more than name
Date:   Wed, 23 Nov 2022 12:15:44 -0800
Message-Id: <20221123201552.7865-2-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221123201552.7865-1-casey@schaufler-ca.com>
References: <20221123201552.7865-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create a struct lsm_id to contain identifying information
about Linux Security Modules (LSMs). At inception this contains
the name of the module and an identifier associated with the
security module. Change the security_add_hooks() interface to
use this structure. Change the individual modules to maintain
their own struct lsm_id and pass it to security_add_hooks().

The values are for LSM identifiers are defined in a new UAPI
header file linux/lsm.h. Each existing LSM has been updated to
include it's LSMID in the lsm_id.

The LSM ID values are sequential, with the oldest module
LSM_ID_CAPABILITY being the lowest value and the existing modules
numbered in the order they were included in the main line kernel.
This is an arbitrary convention for assigning the values, but
none better presents itself. The value 0 is defined as being invalid.
The values 1-99 are reserved for any special case uses which may
arise in the future.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/lsm_hooks.h    | 16 ++++++++++++++--
 include/uapi/linux/lsm.h     | 32 ++++++++++++++++++++++++++++++++
 security/apparmor/lsm.c      |  8 +++++++-
 security/bpf/hooks.c         | 13 ++++++++++++-
 security/commoncap.c         |  8 +++++++-
 security/landlock/cred.c     |  2 +-
 security/landlock/fs.c       |  2 +-
 security/landlock/ptrace.c   |  2 +-
 security/landlock/setup.c    |  6 ++++++
 security/landlock/setup.h    |  1 +
 security/loadpin/loadpin.c   |  9 ++++++++-
 security/lockdown/lockdown.c |  8 +++++++-
 security/safesetid/lsm.c     |  9 ++++++++-
 security/security.c          | 12 ++++++------
 security/selinux/hooks.c     |  9 ++++++++-
 security/smack/smack_lsm.c   |  8 +++++++-
 security/tomoyo/tomoyo.c     |  9 ++++++++-
 security/yama/yama_lsm.c     |  8 +++++++-
 18 files changed, 141 insertions(+), 21 deletions(-)
 create mode 100644 include/uapi/linux/lsm.h

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 4ec80b96c22e..d306db1044d1 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1602,6 +1602,18 @@ struct security_hook_heads {
 	#undef LSM_HOOK
 } __randomize_layout;
 
+/**
+ * struct lsm_id - identify a Linux Security Module.
+ * @lsm: Name of the LSM. Must be approved by the LSM maintainers.
+ * @id: LSM ID number from uapi/linux/lsm.h
+ *
+ * Contains the information that identifies the LSM.
+ */
+struct lsm_id {
+	const u8	*lsm;
+	u32		id;
+};
+
 /*
  * Security module hook list structure.
  * For use with generic list macros for common operations.
@@ -1610,7 +1622,7 @@ struct security_hook_list {
 	struct hlist_node		list;
 	struct hlist_head		*head;
 	union security_list_options	hook;
-	const char			*lsm;
+	struct lsm_id			*lsmid;
 } __randomize_layout;
 
 /*
@@ -1645,7 +1657,7 @@ extern struct security_hook_heads security_hook_heads;
 extern char *lsm_names;
 
 extern void security_add_hooks(struct security_hook_list *hooks, int count,
-				const char *lsm);
+			       struct lsm_id *lsmid);
 
 #define LSM_FLAG_LEGACY_MAJOR	BIT(0)
 #define LSM_FLAG_EXCLUSIVE	BIT(1)
diff --git a/include/uapi/linux/lsm.h b/include/uapi/linux/lsm.h
new file mode 100644
index 000000000000..47791c330cbf
--- /dev/null
+++ b/include/uapi/linux/lsm.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * Linux Security Modules (LSM) - User space API
+ *
+ * Copyright (C) 2022 Casey Schaufler <casey@schaufler-ca.com>
+ * Copyright (C) 2022 Intel Corporation
+ */
+
+#ifndef _UAPI_LINUX_LSM_H
+#define _UAPI_LINUX_LSM_H
+
+/*
+ * ID values to identify security modules.
+ * A system may use more than one security module.
+ *
+ * Values 1-99 are reserved for future use in special cases.
+ */
+#define LSM_ID_INVALID		0
+#define LSM_ID_CAPABILITY	100
+#define LSM_ID_SELINUX		101
+#define LSM_ID_SMACK		102
+#define LSM_ID_TOMOYO		103
+#define LSM_ID_IMA		104
+#define LSM_ID_APPARMOR		105
+#define LSM_ID_YAMA		106
+#define LSM_ID_LOADPIN		107
+#define LSM_ID_SAFESETID	108
+#define LSM_ID_LOCKDOWN		109
+#define LSM_ID_BPF		110
+#define LSM_ID_LANDLOCK		111
+
+#endif /* _UAPI_LINUX_LSM_H */
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index f56070270c69..b859b1af6c75 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -24,6 +24,7 @@
 #include <linux/zlib.h>
 #include <net/sock.h>
 #include <uapi/linux/mount.h>
+#include <uapi/linux/lsm.h>
 
 #include "include/apparmor.h"
 #include "include/apparmorfs.h"
@@ -1202,6 +1203,11 @@ struct lsm_blob_sizes apparmor_blob_sizes __lsm_ro_after_init = {
 	.lbs_task = sizeof(struct aa_task_ctx),
 };
 
+static struct lsm_id apparmor_lsmid __lsm_ro_after_init = {
+	.lsm = "apparmor",
+	.id = LSM_ID_APPARMOR,
+};
+
 static struct security_hook_list apparmor_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(ptrace_access_check, apparmor_ptrace_access_check),
 	LSM_HOOK_INIT(ptrace_traceme, apparmor_ptrace_traceme),
@@ -1897,7 +1903,7 @@ static int __init apparmor_init(void)
 		goto buffers_out;
 	}
 	security_add_hooks(apparmor_hooks, ARRAY_SIZE(apparmor_hooks),
-				"apparmor");
+				&apparmor_lsmid);
 
 	/* Report that AppArmor successfully initialized */
 	apparmor_initialized = 1;
diff --git a/security/bpf/hooks.c b/security/bpf/hooks.c
index e5971fa74fd7..20983ae8d31f 100644
--- a/security/bpf/hooks.c
+++ b/security/bpf/hooks.c
@@ -5,6 +5,7 @@
  */
 #include <linux/lsm_hooks.h>
 #include <linux/bpf_lsm.h>
+#include <uapi/linux/lsm.h>
 
 static struct security_hook_list bpf_lsm_hooks[] __lsm_ro_after_init = {
 	#define LSM_HOOK(RET, DEFAULT, NAME, ...) \
@@ -15,9 +16,19 @@ static struct security_hook_list bpf_lsm_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(task_free, bpf_task_storage_free),
 };
 
+/*
+ * slot has to be LSMBLOB_NEEDED because some of the hooks
+ * supplied by this module require a slot.
+ */
+struct lsm_id bpf_lsmid __lsm_ro_after_init = {
+	.lsm = "bpf",
+	.id = LSM_ID_BPF,
+};
+
 static int __init bpf_lsm_init(void)
 {
-	security_add_hooks(bpf_lsm_hooks, ARRAY_SIZE(bpf_lsm_hooks), "bpf");
+	security_add_hooks(bpf_lsm_hooks, ARRAY_SIZE(bpf_lsm_hooks),
+			   &bpf_lsmid);
 	pr_info("LSM support for eBPF active\n");
 	return 0;
 }
diff --git a/security/commoncap.c b/security/commoncap.c
index bc751fa5adad..f6d50b69f43d 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -25,6 +25,7 @@
 #include <linux/binfmts.h>
 #include <linux/personality.h>
 #include <linux/mnt_idmapping.h>
+#include <uapi/linux/lsm.h>
 
 /*
  * If a non-root user executes a setuid-root binary in
@@ -1448,6 +1449,11 @@ int cap_mmap_file(struct file *file, unsigned long reqprot,
 
 #ifdef CONFIG_SECURITY
 
+static struct lsm_id capability_lsmid __lsm_ro_after_init = {
+	.lsm = "capability",
+	.id = LSM_ID_CAPABILITY,
+};
+
 static struct security_hook_list capability_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(capable, cap_capable),
 	LSM_HOOK_INIT(settime, cap_settime),
@@ -1472,7 +1478,7 @@ static struct security_hook_list capability_hooks[] __lsm_ro_after_init = {
 static int __init capability_init(void)
 {
 	security_add_hooks(capability_hooks, ARRAY_SIZE(capability_hooks),
-				"capability");
+			   &capability_lsmid);
 	return 0;
 }
 
diff --git a/security/landlock/cred.c b/security/landlock/cred.c
index ec6c37f04a19..2eb1d65f10d6 100644
--- a/security/landlock/cred.c
+++ b/security/landlock/cred.c
@@ -42,5 +42,5 @@ static struct security_hook_list landlock_hooks[] __lsm_ro_after_init = {
 __init void landlock_add_cred_hooks(void)
 {
 	security_add_hooks(landlock_hooks, ARRAY_SIZE(landlock_hooks),
-			   LANDLOCK_NAME);
+			   &landlock_lsmid);
 }
diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index 64ed7665455f..486ff50d54a1 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -1201,5 +1201,5 @@ static struct security_hook_list landlock_hooks[] __lsm_ro_after_init = {
 __init void landlock_add_fs_hooks(void)
 {
 	security_add_hooks(landlock_hooks, ARRAY_SIZE(landlock_hooks),
-			   LANDLOCK_NAME);
+			   &landlock_lsmid);
 }
diff --git a/security/landlock/ptrace.c b/security/landlock/ptrace.c
index 4c5b9cd71286..eab35808f395 100644
--- a/security/landlock/ptrace.c
+++ b/security/landlock/ptrace.c
@@ -116,5 +116,5 @@ static struct security_hook_list landlock_hooks[] __lsm_ro_after_init = {
 __init void landlock_add_ptrace_hooks(void)
 {
 	security_add_hooks(landlock_hooks, ARRAY_SIZE(landlock_hooks),
-			   LANDLOCK_NAME);
+			   &landlock_lsmid);
 }
diff --git a/security/landlock/setup.c b/security/landlock/setup.c
index f8e8e980454c..5b32c087e34b 100644
--- a/security/landlock/setup.c
+++ b/security/landlock/setup.c
@@ -8,6 +8,7 @@
 
 #include <linux/init.h>
 #include <linux/lsm_hooks.h>
+#include <uapi/linux/lsm.h>
 
 #include "common.h"
 #include "cred.h"
@@ -23,6 +24,11 @@ struct lsm_blob_sizes landlock_blob_sizes __lsm_ro_after_init = {
 	.lbs_superblock = sizeof(struct landlock_superblock_security),
 };
 
+struct lsm_id landlock_lsmid __lsm_ro_after_init = {
+	.lsm = LANDLOCK_NAME,
+	.id = LSM_ID_LANDLOCK,
+};
+
 static int __init landlock_init(void)
 {
 	landlock_add_cred_hooks();
diff --git a/security/landlock/setup.h b/security/landlock/setup.h
index 1daffab1ab4b..38bce5b172dc 100644
--- a/security/landlock/setup.h
+++ b/security/landlock/setup.h
@@ -14,5 +14,6 @@
 extern bool landlock_initialized;
 
 extern struct lsm_blob_sizes landlock_blob_sizes;
+extern struct lsm_id landlock_lsmid;
 
 #endif /* _SECURITY_LANDLOCK_SETUP_H */
diff --git a/security/loadpin/loadpin.c b/security/loadpin/loadpin.c
index de41621f4998..32bdf7294a6f 100644
--- a/security/loadpin/loadpin.c
+++ b/security/loadpin/loadpin.c
@@ -20,6 +20,7 @@
 #include <linux/string_helpers.h>
 #include <linux/dm-verity-loadpin.h>
 #include <uapi/linux/loadpin.h>
+#include <uapi/linux/lsm.h>
 
 #define VERITY_DIGEST_FILE_HEADER "# LOADPIN_TRUSTED_VERITY_ROOT_DIGESTS"
 
@@ -197,6 +198,11 @@ static int loadpin_load_data(enum kernel_load_data_id id, bool contents)
 	return loadpin_read_file(NULL, (enum kernel_read_file_id) id, contents);
 }
 
+static struct lsm_id loadpin_lsmid __lsm_ro_after_init = {
+	.lsm = "loadpin",
+	.id = LSM_ID_LOADPIN,
+};
+
 static struct security_hook_list loadpin_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(sb_free_security, loadpin_sb_free_security),
 	LSM_HOOK_INIT(kernel_read_file, loadpin_read_file),
@@ -244,7 +250,8 @@ static int __init loadpin_init(void)
 	pr_info("ready to pin (currently %senforcing)\n",
 		enforce ? "" : "not ");
 	parse_exclude();
-	security_add_hooks(loadpin_hooks, ARRAY_SIZE(loadpin_hooks), "loadpin");
+	security_add_hooks(loadpin_hooks, ARRAY_SIZE(loadpin_hooks),
+			   &loadpin_lsmid);
 
 	return 0;
 }
diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
index a79b985e917e..e8c41a0caf7d 100644
--- a/security/lockdown/lockdown.c
+++ b/security/lockdown/lockdown.c
@@ -13,6 +13,7 @@
 #include <linux/security.h>
 #include <linux/export.h>
 #include <linux/lsm_hooks.h>
+#include <uapi/linux/lsm.h>
 
 static enum lockdown_reason kernel_locked_down;
 
@@ -75,6 +76,11 @@ static struct security_hook_list lockdown_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(locked_down, lockdown_is_locked_down),
 };
 
+static struct lsm_id lockdown_lsmid __lsm_ro_after_init = {
+	.lsm = "lockdown",
+	.id = LSM_ID_LOCKDOWN,
+};
+
 static int __init lockdown_lsm_init(void)
 {
 #if defined(CONFIG_LOCK_DOWN_KERNEL_FORCE_INTEGRITY)
@@ -83,7 +89,7 @@ static int __init lockdown_lsm_init(void)
 	lock_kernel_down("Kernel configuration", LOCKDOWN_CONFIDENTIALITY_MAX);
 #endif
 	security_add_hooks(lockdown_hooks, ARRAY_SIZE(lockdown_hooks),
-			   "lockdown");
+			   &lockdown_lsmid);
 	return 0;
 }
 
diff --git a/security/safesetid/lsm.c b/security/safesetid/lsm.c
index e806739f7868..8d0742ba045d 100644
--- a/security/safesetid/lsm.c
+++ b/security/safesetid/lsm.c
@@ -19,6 +19,7 @@
 #include <linux/ptrace.h>
 #include <linux/sched/task_stack.h>
 #include <linux/security.h>
+#include <uapi/linux/lsm.h>
 #include "lsm.h"
 
 /* Flag indicating whether initialization completed */
@@ -261,6 +262,11 @@ static int safesetid_task_fix_setgroups(struct cred *new, const struct cred *old
 	return 0;
 }
 
+static struct lsm_id safesetid_lsmid __lsm_ro_after_init = {
+	.lsm = "safesetid",
+	.id = LSM_ID_SAFESETID,
+};
+
 static struct security_hook_list safesetid_security_hooks[] = {
 	LSM_HOOK_INIT(task_fix_setuid, safesetid_task_fix_setuid),
 	LSM_HOOK_INIT(task_fix_setgid, safesetid_task_fix_setgid),
@@ -271,7 +277,8 @@ static struct security_hook_list safesetid_security_hooks[] = {
 static int __init safesetid_security_init(void)
 {
 	security_add_hooks(safesetid_security_hooks,
-			   ARRAY_SIZE(safesetid_security_hooks), "safesetid");
+			   ARRAY_SIZE(safesetid_security_hooks),
+			   &safesetid_lsmid);
 
 	/* Report that SafeSetID successfully initialized */
 	safesetid_initialized = 1;
diff --git a/security/security.c b/security/security.c
index 79d82cb6e469..b2eb0ccd954b 100644
--- a/security/security.c
+++ b/security/security.c
@@ -476,17 +476,17 @@ static int lsm_append(const char *new, char **result)
  * security_add_hooks - Add a modules hooks to the hook lists.
  * @hooks: the hooks to add
  * @count: the number of hooks to add
- * @lsm: the name of the security module
+ * @lsmid: the identification information for the security module
  *
  * Each LSM has to register its hooks with the infrastructure.
  */
 void __init security_add_hooks(struct security_hook_list *hooks, int count,
-				const char *lsm)
+			       struct lsm_id *lsmid)
 {
 	int i;
 
 	for (i = 0; i < count; i++) {
-		hooks[i].lsm = lsm;
+		hooks[i].lsmid = lsmid;
 		hlist_add_tail_rcu(&hooks[i].list, hooks[i].head);
 	}
 
@@ -495,7 +495,7 @@ void __init security_add_hooks(struct security_hook_list *hooks, int count,
 	 * and fix this up afterwards.
 	 */
 	if (slab_is_available()) {
-		if (lsm_append(lsm, &lsm_names) < 0)
+		if (lsm_append(lsmid->lsm, &lsm_names) < 0)
 			panic("%s - Cannot get early memory.\n", __func__);
 	}
 }
@@ -2070,7 +2070,7 @@ int security_getprocattr(struct task_struct *p, const char *lsm,
 	struct security_hook_list *hp;
 
 	hlist_for_each_entry(hp, &security_hook_heads.getprocattr, list) {
-		if (lsm != NULL && strcmp(lsm, hp->lsm))
+		if (lsm != NULL && strcmp(lsm, hp->lsmid->lsm))
 			continue;
 		return hp->hook.getprocattr(p, name, value);
 	}
@@ -2083,7 +2083,7 @@ int security_setprocattr(const char *lsm, const char *name, void *value,
 	struct security_hook_list *hp;
 
 	hlist_for_each_entry(hp, &security_hook_heads.setprocattr, list) {
-		if (lsm != NULL && strcmp(lsm, hp->lsm))
+		if (lsm != NULL && strcmp(lsm, hp->lsmid->lsm))
 			continue;
 		return hp->hook.setprocattr(name, value, size);
 	}
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index f553c370397e..5fcce36267bd 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -92,6 +92,7 @@
 #include <linux/fsnotify.h>
 #include <linux/fanotify.h>
 #include <linux/io_uring.h>
+#include <uapi/linux/lsm.h>
 
 #include "avc.h"
 #include "objsec.h"
@@ -7014,6 +7015,11 @@ static int selinux_uring_cmd(struct io_uring_cmd *ioucmd)
 }
 #endif /* CONFIG_IO_URING */
 
+static struct lsm_id selinux_lsmid __lsm_ro_after_init = {
+	.lsm = "selinux",
+	.id = LSM_ID_SELINUX,
+};
+
 /*
  * IMPORTANT NOTE: When adding new hooks, please be careful to keep this order:
  * 1. any hooks that don't belong to (2.) or (3.) below,
@@ -7334,7 +7340,8 @@ static __init int selinux_init(void)
 
 	hashtab_cache_init();
 
-	security_add_hooks(selinux_hooks, ARRAY_SIZE(selinux_hooks), "selinux");
+	security_add_hooks(selinux_hooks, ARRAY_SIZE(selinux_hooks),
+			   &selinux_lsmid);
 
 	if (avc_add_callback(selinux_netcache_avc_callback, AVC_CALLBACK_RESET))
 		panic("SELinux: Unable to register AVC netcache callback\n");
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index b6306d71c908..c7ba80e20b8d 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -43,6 +43,7 @@
 #include <linux/fs_parser.h>
 #include <linux/watch_queue.h>
 #include <linux/io_uring.h>
+#include <uapi/linux/lsm.h>
 #include "smack.h"
 
 #define TRANS_TRUE	"TRUE"
@@ -4787,6 +4788,11 @@ struct lsm_blob_sizes smack_blob_sizes __lsm_ro_after_init = {
 	.lbs_superblock = sizeof(struct superblock_smack),
 };
 
+static struct lsm_id smack_lsmid __lsm_ro_after_init = {
+	.lsm = "smack",
+	.id = LSM_ID_SMACK,
+};
+
 static struct security_hook_list smack_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(ptrace_access_check, smack_ptrace_access_check),
 	LSM_HOOK_INIT(ptrace_traceme, smack_ptrace_traceme),
@@ -4990,7 +4996,7 @@ static __init int smack_init(void)
 	/*
 	 * Register with LSM
 	 */
-	security_add_hooks(smack_hooks, ARRAY_SIZE(smack_hooks), "smack");
+	security_add_hooks(smack_hooks, ARRAY_SIZE(smack_hooks), &smack_lsmid);
 	smack_enabled = 1;
 
 	pr_info("Smack:  Initializing.\n");
diff --git a/security/tomoyo/tomoyo.c b/security/tomoyo/tomoyo.c
index 71e82d855ebf..1916eb6216f7 100644
--- a/security/tomoyo/tomoyo.c
+++ b/security/tomoyo/tomoyo.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/lsm_hooks.h>
+#include <uapi/linux/lsm.h>
 #include "common.h"
 
 /**
@@ -530,6 +531,11 @@ static void tomoyo_task_free(struct task_struct *task)
 	}
 }
 
+static struct lsm_id tomoyo_lsmid __lsm_ro_after_init = {
+	.lsm = "tomoyo",
+	.id = LSM_ID_TOMOYO,
+};
+
 /*
  * tomoyo_security_ops is a "struct security_operations" which is used for
  * registering TOMOYO.
@@ -582,7 +588,8 @@ static int __init tomoyo_init(void)
 	struct tomoyo_task *s = tomoyo_task(current);
 
 	/* register ourselves with the security framework */
-	security_add_hooks(tomoyo_hooks, ARRAY_SIZE(tomoyo_hooks), "tomoyo");
+	security_add_hooks(tomoyo_hooks, ARRAY_SIZE(tomoyo_hooks),
+			   &tomoyo_lsmid);
 	pr_info("TOMOYO Linux initialized\n");
 	s->domain_info = &tomoyo_kernel_domain;
 	atomic_inc(&tomoyo_kernel_domain.users);
diff --git a/security/yama/yama_lsm.c b/security/yama/yama_lsm.c
index 06e226166aab..2487b8f847f3 100644
--- a/security/yama/yama_lsm.c
+++ b/security/yama/yama_lsm.c
@@ -18,6 +18,7 @@
 #include <linux/task_work.h>
 #include <linux/sched.h>
 #include <linux/spinlock.h>
+#include <uapi/linux/lsm.h>
 
 #define YAMA_SCOPE_DISABLED	0
 #define YAMA_SCOPE_RELATIONAL	1
@@ -421,6 +422,11 @@ static int yama_ptrace_traceme(struct task_struct *parent)
 	return rc;
 }
 
+static struct lsm_id yama_lsmid __lsm_ro_after_init = {
+	.lsm = "yama",
+	.id = LSM_ID_YAMA,
+};
+
 static struct security_hook_list yama_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(ptrace_access_check, yama_ptrace_access_check),
 	LSM_HOOK_INIT(ptrace_traceme, yama_ptrace_traceme),
@@ -477,7 +483,7 @@ static inline void yama_init_sysctl(void) { }
 static int __init yama_init(void)
 {
 	pr_info("Yama: becoming mindful.\n");
-	security_add_hooks(yama_hooks, ARRAY_SIZE(yama_hooks), "yama");
+	security_add_hooks(yama_hooks, ARRAY_SIZE(yama_hooks), &yama_lsmid);
 	yama_init_sysctl();
 	return 0;
 }
-- 
2.38.1

