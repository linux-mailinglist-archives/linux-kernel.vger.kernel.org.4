Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E5DF636ABF
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 21:19:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236797AbiKWUSv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 15:18:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239876AbiKWURs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 15:17:48 -0500
Received: from sonic311-30.consmr.mail.ne1.yahoo.com (sonic311-30.consmr.mail.ne1.yahoo.com [66.163.188.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11C1445ED3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 12:17:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1669234666; bh=YdB7BgVRtE1M+y+ieY1Nzu+9wxVYg2PUdxD+5M52C6g=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=Q2bIT9VPUt4zIN1k3kRIENUHkRsXqGJLqlIjtOqTliwGy45XttGtge0h2fofc+RU/tdLibHu2T2SCPh6qVLNCFxJAGnccXmzUmShAVQlhhGrMveuVaC6cuTMYW05JvBtP6gcViv5X7greLpEWQzIRMt7/LW2An/ZwdYHFYs6M6V6UCAzMlWZ54szRZLT90JLFfLF9kkpzsuhV0pI0bqD2SkfVcFGFUTfbobjr1Pcd4MUgiyjA1+tXmBJaDlcOP+spapmPtTf2AmdedpY1OOZKMgQudJjQfV0DYdo2yJixboEuBQ6vieMcFBIsLTGX4+jqwVzfYA/Lm4mjDzzFS4etw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1669234666; bh=Uhl6uDkhiO1THX1yrKs9jusY3cH9pVdGu93Sg8+Jmy6=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=GyEmCzc0Br+9xad9LaTqL5vquOMnq/JwYGw75t5O+GHQEn072a7Tj88IwjQviRIPEfGchs0NiQvakQmxDRu/6BdMw3CeEX/WnBHyL0xudGmgoRV0pkWH64RPukMyW3sdoicL3/JlMxidSeWPbSFLr2YgimvZChP+g8S6I46PSTWtbCIxdvb7xT2r7o1Bj6ApJ/fMV+gVo7g/LVN1Q3PqpdZyzsj+YN6as/hKZ/D4Dy3WD+NS5ykzQXDAf2706CTvnnRZt+lYrCg1vwxDOCl8RW1UzxRtWS/12g4Tbo0VnrH7aJtZDKYkKVV7Jhj6/12hKmzsFBB8oY+xwDcrAx4uvA==
X-YMail-OSG: BM775HcVM1k71PyGQY4.Og9cZkVQNB4vnNFqFRnr_ym8uffWzqiBfzOnA_JqkjX
 w6NGaZOBW.N4v5x9TyZ0cR89ncroz9H6NSf7pD4TYAS_.YyWd3TU9VQILI6iUJLcTxppw1BqrqhX
 sXPcclG59Lq36d1tGKELvbd795CNdrwzSU6rrAttK2DlwTAgAYe2a8sN6o9XBrtptRwY_F.YRzZO
 3V3NBKMm5boWBmjdPl9CD0cfgIeVCvK2f3tbkkX9ykInp_lerktewMGdS8L9J9Incj2umj3JueHb
 BAOZozjeVU6bYP8lVicgkHkNsahUFz5NOFptdS_TjY4OQjIb1v5xyHJK94oWB1ZRdN.LmsjkbMAZ
 U8yt3z0AjkAFFz.V7xkMei1bqgiKvpkvWT8HP3cyMoxxjKkTZZTpiIbDqjwH9OHrvqRbwbJK8hS.
 h8mXdSYmboa_u9up2CH_739Job5gs8W4qZH__aLX1bScswbcXebPhkVYnXFfiQNNBkwDVuucW860
 Al7tdxohfyYPEEQ1R.s47a.NXQx8H1vQcha4RcMcaPa6GPEg1wSDR2LFUCoOOD0GT2fy1504HQpn
 TGDG3QwJSSz1P_HMsT31AcTcNx9ZAw_ZsTq0.u7mB1_08gGi2xdrBcl8MUwR7vvNf40GasPRo1F_
 fFoY5nCtOpfW00aPURcCasvabd1hqtIX_94ZrLjkVy3mnLMoTv.OQhsF_kUhfnTpqzFEZCa3IPjh
 cFGjFg0JJiZeM29ymRb9Zi1LT_n2HJbtzbMzP5inRZAtErX48byXzbZh1NBJZKV48j6Lr15b1pns
 OZAOtTWFlzL6BW_SDXE6D5DHzhlsxARhBFcmSrXE7x5pnU.D4dkDC5dbiZw4Wpr5vdnzni3E2rPW
 YYy7m9CPK8gT64wDijjSlMKRuKcn4RW6vVT1H.AnRGorpWrmqCutcC6qROKiACl9tmTRasixaIGZ
 0.etGhK.wT_hgch4.FgqKYMTsj2M7A0onfYjeixlNmpYx3AAFBS0yvfp.hBmhlHHVCCmhSHJiMEW
 BKbXUnE5RKx5PYzoTaT18MLZSAA47n5RmLIAeEXApM6KtK0x6B9sOhs.7w3Wr30xZrVaIWHI5JjW
 rb6HQJcgTCRmSQZZzUhoVVFpp6A6KXuBjyzR5P6qZMZBpiBJ39brfP2cmkhYuKOP_K7dPNUwcoz_
 fXxd9FsNKnNnf4LgnrqYB5ifdp2l0F8r1LKmxccN.JeuoQJ3XkTVcnqpp9QZYKMvWrqQT266WMrz
 XfyNYQSN41kfm9tzZ_JaSQb7suuN9C1NgTwqSd_x2ZGn83AOepREB91AkGZJnI8O6a56__6AnGr0
 J36w4c6gGwqywBoG.V8.m0VnDQIWITqSiYoXBmvF7pktMDyr60HxOzDSToXqp3z2KoeNAJKudm9K
 caexYVIRp.GcylKPdTgogpGeetqug4usUYA1aO3GowCETo62IG_SHjQMz9oEtntgRBcqSc6EYDCK
 0rg94tvGG2_YD89Liz2NI940e4Fqy9dsX0K7AgJB4JMKtBg41Um_FHg6XBMfiaj_WlrrqtasEKxJ
 HToMCQn0m0O_65KrJi6RiSD4laZfMuK5fgJPC8eo7MBUTgPimusFAg.HvmzHzZj3_HZZ4M1wQ5B7
 fyi6AQ85ZXq86u1JmBkOrATXE61Z6PkqIbkvbyNK_Qifw.A5IFtohtKhGopbSHbsGe8hlzXA5EZV
 SuavXtshT5XwPOnoYX0o9mQQuhF6dis2hHRbKs4YC.J30._jQOLut3VCM7m7lHFo2LihgciYrg72
 wc2VMUbMwKT5TfUdbRQ9nUgcHEXDfzTQ.oogrKtGg2bROB_HRCmfptC223d4mRD8CKyhKVNbcale
 2MWmBvGnqeUG7mvUiswGPd86hbGz.fIN1A0b4aHjUhGl7z73chE29AOI2udxZqEjQ2E836R2iz8U
 gk4Q.GH0zFhu1eiJJksHskHdyIcIGNxidT6sCQzlRFKZFAPn4W5ZlNWxHPE._tMRurR5AtxARXyw
 JKGdVPgTRTKpP6LTi9mldfmI5uk806NaTevIhMydqhKb1PvrAbDUqEOgHVJlUDXBBhH9sWEfatov
 pTCVUyNnoRlX1Qg2SCDKWye.AO.j.7hJdsZyu73lMbG6Sf9uQ9V.fj1ymWU.cN45my95zoN1OMr2
 d1SDtlh4niX6Kiad.pupFkkj6SdgJvVLVGNWKDq14hq2rqoDXY8qou_6rI.jv2nFGBfIeuCbCdQZ
 I5LZlZRPzZ9KeTYVkGitVtpamxbgawsiGTzuqNoOtcOgRODL5kcxPP__Th.zS6A8T4sgXvB7gf8V
 dc4PYjskBGtJz3K4xBeaeUBB6AQ--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Wed, 23 Nov 2022 20:17:46 +0000
Received: by hermes--production-ne1-6bcfb7fb87-5nqxg (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID c337f88fc64cf6889317bc459f114f1a;
          Wed, 23 Nov 2022 20:17:40 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     casey@schaufler-ca.com, jmorris@namei.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net
Subject: [PATCH v3 5/9] LSM: lsm_get_self_attr syscall for LSM self attributes
Date:   Wed, 23 Nov 2022 12:15:48 -0800
Message-Id: <20221123201552.7865-6-casey@schaufler-ca.com>
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

Create a system call lsm_get_self_attr() to provide the security
module maintained attributes of the current process. Historically
these attributes have been exposed to user space via entries in
procfs under /proc/self/attr.

Attributes are provided as a collection of lsm_ctx structures
which are placed into a user supplied buffer. Each structure
identifys the size of the attribute, and the attribute value.
The format of the attribute value is defined by the security
module, but will always be \0 terminated. The ctx_len value
will always be strlen(ctx)+1.

        ---------------------------
        | __u32 id                |
        ---------------------------
        | __u64 flags             |
        ---------------------------
        | __kernel_size_t ctx_len |
        ---------------------------
        | __u8 ctx[ctx_len]       |
        ---------------------------
        | __u32 id                |
        ---------------------------
        | __u64 flags             |
        ---------------------------
        | __kernel_size_t ctx_len |
        ---------------------------
        | __u8 ctx[ctx_len]       |
        ---------------------------

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 Documentation/userspace-api/lsm.rst |   9 ++
 include/linux/syscalls.h            |   3 +
 include/uapi/linux/lsm.h            |  21 ++++
 kernel/sys_ni.c                     |   3 +
 security/Makefile                   |   1 +
 security/lsm_syscalls.c             | 182 ++++++++++++++++++++++++++++
 6 files changed, 219 insertions(+)
 create mode 100644 security/lsm_syscalls.c

diff --git a/Documentation/userspace-api/lsm.rst b/Documentation/userspace-api/lsm.rst
index 6ddf5506110b..98a0c191b499 100644
--- a/Documentation/userspace-api/lsm.rst
+++ b/Documentation/userspace-api/lsm.rst
@@ -48,6 +48,15 @@ creating socket objects.
 The proc filesystem provides this value in ``/proc/self/attr/sockcreate``.
 This is supported by the SELinux security module.
 
+Kernel interface
+================
+
+Get the security attributes of the current process
+--------------------------------------------------
+
+.. kernel-doc:: security/lsm_syscalls.c
+    :identifiers: sys_lsm_get_self_attr
+
 Additional documentation
 ========================
 
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index a34b0f9a9972..2f2434adec4a 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -71,6 +71,7 @@ struct clone_args;
 struct open_how;
 struct mount_attr;
 struct landlock_ruleset_attr;
+struct lsm_cxt;
 enum landlock_rule_type;
 
 #include <linux/types.h>
@@ -1056,6 +1057,8 @@ asmlinkage long sys_memfd_secret(unsigned int flags);
 asmlinkage long sys_set_mempolicy_home_node(unsigned long start, unsigned long len,
 					    unsigned long home_node,
 					    unsigned long flags);
+asmlinkage long sys_lsm_get_self_attr(struct lsm_ctx *ctx, size_t *size,
+				      int flags);
 
 /*
  * Architecture-specific system calls
diff --git a/include/uapi/linux/lsm.h b/include/uapi/linux/lsm.h
index 8e9124bf622c..a400ae056d22 100644
--- a/include/uapi/linux/lsm.h
+++ b/include/uapi/linux/lsm.h
@@ -9,6 +9,27 @@
 #ifndef _UAPI_LINUX_LSM_H
 #define _UAPI_LINUX_LSM_H
 
+#include <linux/types.h>
+#include <linux/unistd.h>
+
+/**
+ * struct lsm_ctx - LSM context
+ * @id: the LSM id number, see LSM_ID_XXX
+ * @flags: context specifier and LSM specific flags
+ * @ctx_len: the size of @ctx
+ * @ctx: the LSM context, a nul terminated string
+ *
+ * @ctx in a nul terminated string.
+ *	(strlen(@ctx) < @ctx_len) is always true.
+ *	(strlen(@ctx) == @ctx_len + 1) is not guaranteed.
+ */
+struct lsm_ctx {
+	__u32		id;
+	__u64		flags;
+	__kernel_size_t	ctx_len;
+	__u8		ctx[];
+};
+
 /*
  * ID values to identify security modules.
  * A system may use more than one security module.
diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index 860b2dcf3ac4..7b2513d5605d 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -262,6 +262,9 @@ COND_SYSCALL_COMPAT(recvmsg);
 /* mm/nommu.c, also with MMU */
 COND_SYSCALL(mremap);
 
+/* security/lsm_syscalls.c */
+COND_SYSCALL(lsm_get_self_attr);
+
 /* security/keys/keyctl.c */
 COND_SYSCALL(add_key);
 COND_SYSCALL(request_key);
diff --git a/security/Makefile b/security/Makefile
index 18121f8f85cd..59f238490665 100644
--- a/security/Makefile
+++ b/security/Makefile
@@ -7,6 +7,7 @@ obj-$(CONFIG_KEYS)			+= keys/
 
 # always enable default capabilities
 obj-y					+= commoncap.o
+obj-$(CONFIG_SECURITY) 			+= lsm_syscalls.o
 obj-$(CONFIG_MMU)			+= min_addr.o
 
 # Object file lists
diff --git a/security/lsm_syscalls.c b/security/lsm_syscalls.c
new file mode 100644
index 000000000000..c109a0dc18fe
--- /dev/null
+++ b/security/lsm_syscalls.c
@@ -0,0 +1,182 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * System calls implementing the Linux Security Module API.
+ *
+ *  Copyright (C) 2022 Casey Schaufler <casey@schaufler-ca.com>
+ *  Copyright (C) 2022 Intel Corporation
+ */
+
+#include <asm/current.h>
+#include <linux/compiler_types.h>
+#include <linux/err.h>
+#include <linux/errno.h>
+#include <linux/security.h>
+#include <linux/stddef.h>
+#include <linux/syscalls.h>
+#include <linux/types.h>
+#include <linux/lsm_hooks.h>
+#include <uapi/linux/lsm.h>
+
+struct attrs_used_map {
+	char *name;
+	int attrs_used;
+};
+
+static const struct attrs_used_map lsm_attr_names[] = {
+	{ .name = "current",	.attrs_used = LSM_ATTR_CURRENT, },
+	{ .name = "exec",	.attrs_used = LSM_ATTR_EXEC, },
+	{ .name = "fscreate",	.attrs_used = LSM_ATTR_FSCREATE, },
+	{ .name = "keycreate",	.attrs_used = LSM_ATTR_KEYCREATE, },
+	{ .name = "prev",	.attrs_used = LSM_ATTR_PREV, },
+	{ .name = "sockcreate",	.attrs_used = LSM_ATTR_SOCKCREATE, },
+};
+
+static int attr_used_index(u32 flags)
+{
+	int i;
+
+	if (flags == 0)
+		return -EINVAL;
+
+	for (i = 0; i < ARRAY_SIZE(lsm_attr_names); i++)
+		if ((lsm_attr_names[i].attrs_used & flags) == flags)
+			return i;
+
+	return -EINVAL;
+}
+
+/**
+ * sys_lsm_get_self_attr - Return current task's security module attributes
+ * @ctx: the LSM contexts
+ * @size: size of @ctx, updated on return
+ * @flags: which attribute to return
+ *
+ * Returns the calling task's LSM contexts. On success this
+ * function returns the number of @ctx array elements. This value
+ * may be zero if there are no LSM contexts assigned. If @size is
+ * insufficient to contain the return data -E2BIG is returned and
+ * @size is set to the minimum required size. In all other cases
+ * a negative value indicating the error is returned.
+ */
+SYSCALL_DEFINE3(lsm_get_self_attr,
+		struct lsm_ctx __user *, ctx,
+		__kernel_size_t __user *, size,
+		__u32, flags)
+{
+	int i;
+	int rc = 0;
+	int len;
+	int attr;
+	int count = 0;
+	void *curr;
+	char *cp;
+	char *np;
+	char **interum_ctx;
+	size_t total_size = 0;
+	struct lsm_ctx *ip;
+	struct lsm_ctx *interum;
+	struct lsm_ctx *final = NULL;
+
+	attr = attr_used_index(flags);
+	if (attr < 0)
+		return attr;
+
+	interum = kzalloc(ARRAY_SIZE(lsm_attr_names) * lsm_active_cnt *
+			  sizeof(*interum), GFP_KERNEL);
+	if (interum == NULL)
+		return -ENOMEM;
+	ip = interum;
+
+	interum_ctx = kzalloc(ARRAY_SIZE(lsm_attr_names) * lsm_active_cnt *
+			      sizeof(*interum_ctx), GFP_KERNEL);
+	if (interum_ctx == NULL) {
+		kfree(interum);
+		return -ENOMEM;
+	}
+
+	for (i = 0; i < lsm_active_cnt; i++) {
+		if ((lsm_idlist[i]->attrs_used &
+		     lsm_attr_names[attr].attrs_used) == 0)
+			continue;
+
+		len = security_getprocattr(current, lsm_idlist[i]->id,
+					   lsm_attr_names[attr].name,
+					   &cp);
+		if (len <= 0)
+			continue;
+
+		ip->id = lsm_idlist[i]->id;
+		ip->flags = lsm_attr_names[attr].attrs_used;
+		interum_ctx[count] = cp;
+
+		/*
+		 * A security module that returns a binary attribute
+		 * will need to identify itself to prevent string
+		 * processing.
+		 *
+		 * At least one security module adds a \n at the
+		 * end of a context to make it look nicer. Change
+		 * that to a \0 so that user space doesn't have to
+		 * work around it.
+		 *
+		 * Security modules have been inconsistent about
+		 * including the \0 terminator in the size. If it's
+		 * not there make space for it.
+		 *
+		 * The length returned will reflect the length of
+		 * the string provided by the security module, which
+		 * may not match what getprocattr returned.
+		 */
+		np = strnchr(cp, len, '\n');
+		if (np != NULL)
+			*np = '\0';
+		ip->ctx_len = strnlen(cp, len) + 1;
+		total_size += sizeof(*interum) + ip->ctx_len;
+		ip++;
+		count++;
+	}
+
+	if (count == 0)
+		goto free_out;
+
+	final = kzalloc(total_size, GFP_KERNEL);
+	if (final == NULL) {
+		rc = -ENOMEM;
+		goto free_out;
+	}
+
+	curr = final;
+	ip = interum;
+	for (i = 0; i < count; i++) {
+		memcpy(curr, ip, sizeof(*interum));
+		curr += sizeof(*interum);
+		if (ip->ctx_len > 1)
+			memcpy(curr, interum_ctx[i], ip->ctx_len - 1);
+		curr += ip->ctx_len;
+		ip++;
+	}
+
+	if (get_user(len, size)) {
+		rc = -EFAULT;
+		goto free_out;
+	}
+	if (total_size > len) {
+		rc = -ERANGE;
+		if (put_user(total_size, size) != 0)
+			rc = -EFAULT;
+		goto free_out;
+	}
+	if (copy_to_user(ctx, final, total_size) != 0 ||
+	    put_user(total_size, size) != 0)
+		rc = -EFAULT;
+	else
+		rc = count;
+
+free_out:
+	for (i = 0; i < count; i++)
+		kfree(interum_ctx[i]);
+	kfree(interum_ctx);
+	kfree(interum);
+	kfree(final);
+	return rc;
+}
-- 
2.38.1

