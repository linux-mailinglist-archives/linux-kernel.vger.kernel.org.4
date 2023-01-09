Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2CD2662E4E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 19:11:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236536AbjAISLA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 13:11:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237428AbjAISJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 13:09:43 -0500
Received: from sonic310-30.consmr.mail.ne1.yahoo.com (sonic310-30.consmr.mail.ne1.yahoo.com [66.163.186.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE89613D68
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 10:09:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1673287749; bh=UBknTJ5AK+8ibzgjqpdN5Pyy2eZ6OEF4EO5PatESuek=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=DfByM41fmvEA7yAHybBgMe2o8SKJ57dXOHxCV6hDe8p1sqypJnuF2fEqwIJ89HUmKIVadB8QygYPduw2dB/rqS3o7QzZCj2bIBz5NFCa4Qcb8mayoR0ci5yaa8fErkAgcaihnuoVU36elCPPZlSN+86ZeJU8/fuleuIvQiIMrgiVymHX8WwlU9azU1XaWjLs1JCIk+3v3Zn/rRV1lhMu3jQHCaapvABzLqBoVWFcI7MTkG6giyRDXUJD5P+RH7keJU5jHVnPUqyoFR2Q2YwmXpA4uMBaZ0MQr/1bHRZH1r8dDQz47EsFmqTkaDC4YATTIV4dv9gzwTQIJerx3m9O5g==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1673287749; bh=4qqI7rhC/nebP38HB3U/gZfWNnaDfbZTPFeL34H19K+=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=CRJ+sGP+mWQPm4CQOHj5OUlTOcpU3wCkgLtfOkT6Bc67ocglouhiH5lxLLQsreSSvBak0qyohBczuuFJ0AEYSTMiTKUk9gJmYV/7VXAKT06ziVYQTcY3siJhOg8bp2qiKv/4fyzuhv//avharsmVtZGxr85VYkXRpwjqq7oNgF5eWbfi1k9btRCNOBCuQ9xq+OporicOeH/1FqGfa2+MnlNzeUkJix0hkuD3mB8Rqc1FlMcjj50lOJ1Qjik97UDLNq5yUsOg/BRHGOg9jvlIFUZXjpvKHuspjCTt463e/ttyvk8RuZ3ACQQ3XicYOuGYLzmgfOqj3G6lZDfteEkVwA==
X-YMail-OSG: 3DBtMP8VM1kdXlwuUwT2CZ.P8.UnM3dGO00k_f.zL7jntUkaFYmruyIITd1F1VK
 Bit2sfG.SJZlkf3dTWGCG0dGeLJw_E96yusRDDBhTiFP7fr8_bX6YSD1_czQW7s.MDSz7yBqrgPD
 Zjnr_EAJ2OfXm4CaJVt5dc75Id5axvdBSfCn1tWb9LTLnzwS1Lx9iej7dqrTV3DIQcLPXS3Uhwa3
 ZhOrIU9RkgNTq0ByBujqREq_2TrrLpBH_ZEBR6pCz1qpEzSo0M.KNFzCcPn8TD.Hfv4ZCv2sXXQl
 XRuTvhq0Jal25ekNit0czWzgW89ZISJjSdEiwdjymQ6n34SKJ2nKuvODbjB.Mly7AU0ogkTahmKd
 RQ2OvxezkWzg14JSVUa07tKpFEkxn6EoRpCQQigju.VAwEJa6YjauHE0f6l_6u3g7hGYWSdqwp0I
 crxBRs_lnr8I9j2h4eEnIcHbVDqJSxp1gzUjZAD7xK.5CFCDnOjxNIhbbGJd9o8Qu616JBMTEPHU
 _YxlBQHHEozCaAMzAs68Yp.eI0zAhs9g6M4aDWAiu7RDepCW_NPiuP0.LTYBEWHAtzZzDUe4a_VA
 VnQeTPkj5ZM.lqpxc9jOkGOt8if4Pu0vAQ8b7Tou5c8prubRhRwqGXpgorVFeCCmuS5SKrG3aeKw
 tw5SkGF77iYcii.egdeABh8C8IlEzMvg4.SLjgcK.fQ5USJEpt0fMW26z5kM_kawZxDx3PHhRCL3
 32zzuE_af45Y.0VldvZ5ctbjqNLRTIcMqwQUQ2RXAgvpViSWOPPCjbDoeUlfNDsDIT86Um84ie3t
 HmZ5ZmRtA.vTfe1WXX9evXCQMyhytTSmuNibDktMjiNO.9RFilY76ovO0yTK6ts7K7wtboRpI0Y5
 7KQzezK19J3OjatzRT2Y6HLFz0EN6H3lYHK_bVnuYDlucQsNlryxYWBZhzuX6meq0XltkbEd7.Dg
 EWPJOqMydDcjOg2iFIuw0IQsV_5YD06OhwwCRreOwKnJTnuiMC2XDPmoTEOkaZgOMX97PQ.znR4C
 ZL0J9oAofCpAX8U3XCCUWvSr2O_sSDUhkkk4VY.JzU_e9GLKkPyo7V0k0Atio6Tm4tl4fWzGz4zE
 k_8UDjKX944ytNgXOZE_DvloNbOXUg60lh3pZ8g.Yx8CYor.xSNAVh44tRsb1rQkuE_c.mqrDzvR
 Q4n2DwImAllbRgPK71W7jPxC30v1zrKUp01FDkUraZSSdJa8Km1TlpyD.gluHBw2Tuj83oSFRmTa
 rYVJbz7gNRVhUxL1R3kfvWzqGHezoRYpXjJ4Ud2kFdKZ0WFKX9lUDkMAivOJg61JyYO8gYsDz7.M
 17MrakG5fbJ67qm5ULpBMxPVcYv_mYbGPZYuH0RET7OCTwPgFUMm6sZuwrRQ.sDVQcqFTiMt9PVI
 9qNMhkxjJMFc2r9OnzrTRmjBFKcdUOe1z4pfSmc3pDfRUNBDRz9WfpypdumG.uGmrhKrw_kFrAMX
 wCY64WbDr3L6QnmzeK2imbA6WQCBkMK_eM9TcswqWdqM4b6OI85fokFlr0s3C.bpLzD6AZs.LAH6
 6LATwlIEN9Zxb_gd95ai7QErI7BOM2k1U5DNeHTGQ4qKyz97zwWxsBYFKT9phi5_Oiefpl9Wtp85
 Q7UhMDU0cio1ECxAxqSYgLlDklKQoMQcKka8c4nTxlLsn.9mOnCpy04oI5__qRDv6Ss8drfFC7bc
 JBRR3ETJ5Lbb8MZj1AgoauhPNc0xDyHzkkuuWs4f3Ti5B902RhQkar3WR5gUIIlNkx9g.C1ZA.0f
 XpVUcmsRunZ9.Y.Q3dkzm3R9Ea7eW.HyT5.cMybnCVriJ3liFQ_NIkDdt8H2gznqfnciAxaTmjdM
 _KGHGtQSkTMvN9MZme0GcAUHvz7bAn4.WDUx0nElhpe99JrtzVsi.63wVBkZoHxg_v7zZO21KozT
 y3jn1yaf7VxuuO50HvHrIHF4DfS31grfKBv3SyB8UAuwZmDFTRnpf_yImygpyNTeo8WGzjTPU.Yt
 GFAShQmxU4ADL90l_eWBZRWkqS_f1PZvvqddW4q07Y7kj6c1YdZ1JvQHVIN0aN0zylMCcodgM9og
 5Bk0YZ_lnJhpaywd.mOyt1zx6gpTpVKpFAn41ciF3ys9WLt1nOo3pEskSFzT3JQxSsxK.WEpUqdp
 QTFCG8_f_UYTmFHWySA8N4vru2bkrG0nbEoonCB2zo1YzB8Ac.Jt2zk6.JenEmNfpHnP3JMStCUx
 ghVqPzlkQLQYkSYgXFITlUUrjTshU5uUWmt372cvj3UdQBWlz90EjUS8ULSLcdNyX5.NsXdRCcSh
 FdE3jt.CIJCpZY1QlvV0bgvE-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ne1.yahoo.com with HTTP; Mon, 9 Jan 2023 18:09:09 +0000
Received: by hermes--production-ne1-7b69748c4d-474lb (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 3be57d1d3a3d9a781b586d3784815f58;
          Mon, 09 Jan 2023 18:09:03 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     casey@schaufler-ca.com, jmorris@namei.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net
Subject: [PATCH v5 4/8] LSM: lsm_get_self_attr syscall for LSM self attributes
Date:   Mon,  9 Jan 2023 10:07:13 -0800
Message-Id: <20230109180717.58855-5-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230109180717.58855-1-casey@schaufler-ca.com>
References: <20230109180717.58855-1-casey@schaufler-ca.com>
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
index 000000000000..55e8bf61ac8a
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
+		size_t __user *, size,
+		u32, flags)
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
2.39.0

