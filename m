Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AB9865934C
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 00:37:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234323AbiL2Xg7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 18:36:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234306AbiL2Xgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 18:36:53 -0500
Received: from sonic314-27.consmr.mail.ne1.yahoo.com (sonic314-27.consmr.mail.ne1.yahoo.com [66.163.189.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA21F17580
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 15:36:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1672357010; bh=yIZDL+loWhQ91i9wAobBmT2TNK2xy2hYrhpQg0egCv8=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=GBjaJ5qKnutn15t3Oeb220VDuWziVT3qHpR7OvWg8Yxo3L+JOUc1UtGZIUQDLGnUxz7nscFqBbivXOIa4mvGumlDLTdoUij2VT2zNNdLN0iET26D5H6omAt+X7GBkFMoRd3wPhoNAONgXfzZ2xqXk9WweMPufgTQSa3tYXn8BfBmEJ4mPn6UtB6DbpZFNfzx/VbjQA9GPraB4E2tHq3DY9Aw8vvuh36jhJj90TrsZuSQz5jDaxC4FgLV7vBjkInXxv0QZ67OHF4X0SjIhj0NzyPl6Zesz9+MOxkdpNY23QYoAQrtgJ9DKSmPtswgTwhcPl98Tuv0PQJf4TelmZGghg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1672357010; bh=LeGO85OMFRKdRZudytXKPrHuvkqLsJnj/M5v99SEm04=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=NOfyEA3sgd+P7syRDzplL6suA+NOXjXRspS/DYx3I8RgKYuuuc+7eG50O2XvjOTIw0DpsMAr0+Z0P0VKkauuZRB9KDi1zXigxiTSXBWcQ54AnU/7mzudUPPPQDO1j4yR6J6GB+cDAh/Yn0HV7g+5+Z1WPlKEVxkFcpIq9JjXIIcFHotUq9mlvJgte37n+8MObYJ2BXdkjW+5sFJMiM9OArrB1pA3pEpwNyDM+7/Sr+yk68OMVfBawLvtsGYZNXie5qxOLDVxr+FR6+qQuTZ8QIrVeOv3CNd5BTZq8qk5tH+37+rfMtXOiBX4gLqlVGYm4D8QQ1hiD35WbCBeH0tKNQ==
X-YMail-OSG: bHwmwTQVM1nAqqtx6vuNUi2HelT4W55Wqx4n.WaEDa9KYcUBHF5u5ZQnODwWQEQ
 4O8u7qTuYdmKik0sHaBbEIEXEzfQG9MREaqzhB21TXuL1ia6CbV9ICgDx12RsTxy05BtqRfSYriu
 1UqjcUAEj8eGy0oBwNm4NeQr9kMtELE42USwpFRSATpq5q9EtEzU_3RR_qCrgMGV_qaLt76Rjxg7
 ikoSJacbtMJYmxIV9k7_Xrq.xreRwZPl_jXmFpeg8jgtkxsjffbOLYO8WAlDrhAjcnDsoC1Q3WTD
 mv9TGm01X9mTGl7.AaOhOmtOBv0TAv1YIK0VMj9iSJrDEQAS1q90JCPaZ_fG3RptI3ujlZ_CfZj5
 TmQrYIC502Ka..cPnD63u.EYMSc_UNQUxQRyHbaD.717AeZ9xE6KgdjuW10boYT7M1Ly4Su_.QLS
 Er0_268NF0pdeZQ7WX7ruREPYCMmEDw8YOtx8R6yyNiHHn_87xAPEpZ1h2GfoSfyaizFfMP56nbh
 I4Vk.CbaRjPJQPR0ODlH8468Tv7ETrdVqVimMbqcv2TZRmJyswDLc1FjhSRDX_t2oWk.WRp4hDwg
 1.5oQHAeJrjH0mdURrhkYcJpuqZqySCLTg3ErU1o9rzGFjXxkGREvxmbHTyCwm58VALN605c3REI
 .iDDHZqRLQewOrNAfwO2DAdNaaZ5DLDC8HxTGi5Ql_Y0TNQ.UqaWZ2YLVXTyLAMJsK7j7ClV8u4U
 gvZ325pKKxyqRB2CuTin0RyNL6QTfmiH5W3UzQWj91fYkSkHBqabFkuD1slm_gB3oLWEMSHNlnV7
 mf5uX070MohtTMYsnCcFkAg5OHMWaRjoh80W.3fj2Qk8DdXGs3AwFJ0Nj.ht9_g6HhRY9NYg19A.
 RCFX09Se8oBS3biY5x37sC6i0gS2FZjrEQml2RuSoxln2BX09Z.A6y6Rc05a3j_sapXijxUu4Pej
 11uZyEDKzmbssyAPvSZXitrsGNnP3ogG0YK9Azufv8Pn_WCzug8vYjdXA6IeJRVazsN2V57x1DPe
 lmN2krvXzDjGJG1MN6RnGm8NzjTHqtdXe3ewNZ02YXH7e1mwXH4MPrxK_imXUPUlaOgrtn.WwhX1
 VqF917tVzylwOrOa1q5Si.ptdyac4BPYrSFeDn6AO1IFCh2ZL0ewltpWGgxTCf.pqbrfcvKpqjxT
 PkMeJQBdHXZ1HbG7bhwGKtPIvEhWyRCaZAz3WArgk9my_QPAxqNqh2AI2HUEMRQIgZ88WiM1bkk5
 .fMMc1KnJlh_Ay2BlyGxUbXhnR7j9dt_xwYLRM6QBAruO24jPViRak4j6_hOrjEhrVYu5dMc6D7Z
 UNRqcoFTp.pOlXRsbbwCgh7xLdgoR.H4KFAHMhMevFHAOlM4Xyibmsgcw8gKUU1z8OyG211gXM4F
 vW_sm1Y4chK4dZ2AXoqgEL7KQ3HeFKa.LxEe9MTv4XMYzj1iCrQxwCNLccPi7UKD00a31q8gF8k9
 UE43J9F4ezlohrF8NAvrdrgc8QCAroSkbxR8FbsIz7OLQ0R9EJGKUgKfXDNrbl1NBQE9hR8E18eD
 tlb_Ehy5ETFlCjxoJKQ0jG1L4t3cy5lp0LQXPrnWqoxJ.mgYETptRRhivuRn8Lcq1c30_rNdwvj4
 a2aX.atiY30Ut0yPH6tH4kF.PPQLEOW3ef7eWnsszc5g16gk_gcYSBVl0Azc7vPX2e49uAQxC.bI
 hrwG7rEZ5MEGWo57AKnBWDqgtsuNFURjcXPAXeAcMeEGbid3zDRPlNENffeIn7D2jeR0Mh9hlp5m
 RwPi7spMKL1ag35.cKWZgZOpJn15QlrFxoWjChAJ_PRoxifCAYjsaW9I.F0KZf6E71e1L923RkLy
 gaU7tTrjVqSz1H2xxu5RaPaNqkwxZv52GntcP1l7ZpYZ45U8hIhkXdqs5GXHEJr7i99_775fndCK
 j6PNJPBH_h9TipL6YS_8.4_RPv0hneX_KCwU2xYOnUOGQsc65..dHu.0.bkRaofdYTlncDI4uZMy
 PIP1QPKbUgFRlklujSgtSKkJLAllvCabG0TQ3M05tCGj1E_RjG26Fx8ijAcyG4EsiUc58pqTWWP2
 N0dRXnXMMYlnoz56jMoPHOvbcLSyboRvEdSrvBzY78v.1LBwdYPgkMV88K8xROpzp453X2VJ3mAz
 UZUVxt6hO0xFQVVSIuQG57rCrBXvm1Tw_Fc3X9uYj4inddLCNZjcL8Vjv2gM.zxV9Z1l8CVYkcLS
 5bh_OC9bBBgB.M1M_F48X8seui2uhUT.JR3b0vV_u
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.ne1.yahoo.com with HTTP; Thu, 29 Dec 2022 23:36:50 +0000
Received: by hermes--production-bf1-5458f64d4-x4bxm (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 2c9ed6e23ac4176228a90f5214b07a1b;
          Thu, 29 Dec 2022 23:36:45 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     casey@schaufler-ca.com, jmorris@namei.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net
Subject: [PATCH v4 4/8] LSM: lsm_get_self_attr syscall for LSM self attributes
Date:   Thu, 29 Dec 2022 15:34:50 -0800
Message-Id: <20221229233454.43880-5-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221229233454.43880-1-casey@schaufler-ca.com>
References: <20221229233454.43880-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
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
index 33a0ee3bcb2e..a89205c70ffa 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -71,6 +71,7 @@ struct clone_args;
 struct open_how;
 struct mount_attr;
 struct landlock_ruleset_attr;
+struct lsm_ctx;
 enum landlock_rule_type;
 
 #include <linux/types.h>
@@ -1058,6 +1059,8 @@ asmlinkage long sys_memfd_secret(unsigned int flags);
 asmlinkage long sys_set_mempolicy_home_node(unsigned long start, unsigned long len,
 					    unsigned long home_node,
 					    unsigned long flags);
+asmlinkage long sys_lsm_get_self_attr(struct lsm_ctx *ctx, size_t *size,
+				      int flags);
 
 /*
  * Architecture-specific system calls
diff --git a/include/uapi/linux/lsm.h b/include/uapi/linux/lsm.h
index 61a91b7d946f..8674d8c6b326 100644
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

