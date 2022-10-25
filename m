Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41A8B60D3F1
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 20:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232903AbiJYSsm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 14:48:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232883AbiJYSsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 14:48:39 -0400
Received: from sonic306-27.consmr.mail.ne1.yahoo.com (sonic306-27.consmr.mail.ne1.yahoo.com [66.163.189.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09E399259F
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 11:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1666723717; bh=MYVnYQAqwebDz0miOy37feqwOXhB7i3YuIaSkuEhvQQ=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=R3MbgXa9a7X5Rej2ENquCjuJsOG2+PIsigRKcSlqmEjW6utoqjqA0XNMc26csdPNqnRwbqvkETVbddjjUKoyG8Vv5fiej/YmMSWuYcssXA9Rv2bKbDJmzcCjFx8V0pH1h3CiijV6ttfFoeKKbqwmtw/llathBU1iBIV+axI9Qn8I5/eTq/rSkxRd0BsmZuY9/9bylCam1fGrZcs2F65dieiI3fU0uQrfh5SVEwiBPAmxpzcr/nMiwhz4iqDJLySqpli0AG5heZa29g97LAAvFaGbh0sNyTINLgybrc3aC8pZzyEHL4xxxE7RpFLsNm3VLBdVE9m3WI+bxgr8nKfb1w==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1666723717; bh=bfDso65oLufcEC/GuN5piWYMA5uc+VKD0DGLMdT1oh6=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=GcdW0LCLbl+u8+yQmA7fHlIn9QVA4N6JJF7glHTW36wTlN3MY1ZIpi9otFvw2802yyotzyWQ9/oROh9XsZW2qXL/dqPN3B1KJOR+mZhDRSCtxvqefwPPDTsqC4+2VOJa6SZkoTcYJxh8yi3RmPihaboBLSt09QA2xVNZZpxdkJkvv2pAkMJloZxZrlJ1KUY2DIjoBrx0k9YKw7NRQVoYknafuXThM1OGcBTZGYwCWGSHKUEpMCCH+rmEtVNVlj8xih8W2uhmk/XtsU5nla3GSfY+dA1v+VZhfszkmHfnBl9bFS6NYtaOEpDKIpXy3S1XM+cz+mJ/lAwFy0zsmKX6Xg==
X-YMail-OSG: ky_okX8VM1ksw4jZDlIHOUZtpA4Clqv3czk3YRh6Nj9aJDBV0xWDRJ3yTEnJ6Bh
 _dDtu4mptJqHsRJaDjsUZh7wTSPCIBji6vSxF7HX8UXKPfEx4rNde2ziCU.g9yT5Bdi7QgQ1_FxQ
 vRpuAWDrqJDzrfE1W7v7Rpac2K5ZDFn4Xe73wcDp6SgyU5jjHJM3eZ19Fki9yFs2vScQxdLsTk43
 pLzIpW03kGd0Gz6fhmOVlD.enWscqW3K6SnXjjht_ih2aTFQMGNNhL4G2jeY1k8oKT4RAVd3TrzX
 SfhDOHgbC_3QBIUxMLcYmpNmWT6yM.MlK1LeYcFdeSnBLc6Iza55XD7chYBKTZ0xqlC.1uFq3uNV
 pX7..0zGrV3brUvQO1KKWTdaXFPBQ8yenQNaACkCsWQBIqZBrlyNeFhQMCT8lMOfLaCy3yxIMz8B
 v4drcA2093UMPrPawTH0EbcCZeYHOfoLKtAHhraEVeW9wpx_8ez7tnaQB_txj6yoX8Mxf8PeHEvm
 9lJe.y5yO2ALcA21Je24Ycujl7tcBSN4_k3P2EkAz3G2jY6ch0B2hQxzHfCRnqNN1gNHJe9Pc9o3
 Zb8D5SnZ1ao5v8MPjDCnvLW_T2gHfdY6uGFdkbSaxWSPn1ypLRFI.TvpB1CMC0vIM89NTErOqH0P
 T307_fltDI9iidb1I5HiItngPg24JanqZy29yq7o3KCypuGjinCP7CF1aipUmxHaLePSnn0gPMDJ
 6lC7qJKrHiIURtCzWwWVEoeOgRoxDWwhAg__PO3fvLtQEbRlJXlf0U99G4U.8wJ.xdaBoeyQPPth
 ezYlhmM231Q5aeu7WbiT2MWwMPLREUrT5_VmJfW_dDB8rloK3tlNI568GS3XXsS4Xq.soZISkY9R
 5UsX8l.Q39j0mGJMcwsf_TkbyEwspHYgaRH3G6B0RScpcAVcYyEsMxME.52vjU_1vrcS2lf8T4Mt
 RdzvQ2tSzLxiSkcZnCBB.Jg1BI4KONciI6ykjOplHDRNUoeHDWmfNWSXGpNlY0ughln02aGKTQHS
 Hww_FErrD_H4Rw11siMGC176F4si86V5A2Z71ZMiRJrtl3hXpksqinFeKnph1Rcos16r8539r0p7
 iLwqdkWiJeRg03NjEIfw.5iQLjV8xJu0tkp.EYp6GPILNXFTZz5Tb4kHk3D2LfKAjtjlldgE82Qq
 5hwIyv1rpk.VxLgJtiFYU6ihUMDpLQW1re4zXFm4ebDxWOy32XZRshRSb0jM_BTqicjzJmzrD2Xl
 N4oHbOL1v2bd1B.zFAuw9MmHTKYv0sIj1rwF2vS73opR9t8mtLx8qo6a_vcpCQQbXcyVGF1ypZ56
 woXU6_..hLVCO9KO1skG8jplZiJ6Bo7M6.5fKG_bzgIneX.4BquA24yDr6wVoD8TEPwoIM5PyfWA
 7Fn.qqoONF9DOJEHbbXn.w_1kdvxPLt7ki8gNO0eC8Ipdno_bdBKBSvgeSs8weccLj1gRtsVv9f6
 _mcLRWcyMdF6e17.rgW25OgViJp7kOmF72zslxpjv.4.zgFbeH5SVMiYNPD7slyolgD62y.sG_em
 3D1V12E8drQ4xchBn9IrNLjnxYHz8alUbFqJPCXqV1OQLkgQKciBgQwguMavPcVXH3bcMYq1Sc3c
 LRH9uHDNG8Fs_aq0gMGq4dDpOpd_w9_ktm_CXysyKw5YuisFxDwwZTGU7t_Dh47.uagUDh5fUjPF
 PKQ9gUU6XXDC.mnlWYO6jSbcVE_ruWENwhvVgEWLR0XjUOqtf4NmhYc7wu0_8UN0Ovg7h3CUkkMD
 5SO8kCrTx0AuxwrTaULajJdobaH2qJ33b00q7Pv2Kkh2xHdgExDfuP5DX4iUHGq.01bkMex6T3VH
 ZVOr1XpCaMako898geW4dj3TMUBpskAsklpCExBpTtMkCzoM2bVo1QBboCdxGXiopgWpdg6Z48FC
 Xoom3NZ2o58gxNlFaHdYqmONw9q0VuQiVf9ux5vn3FykzGG5LGlGNw3LFAmCrqSo2kdD8IRWaKZW
 0D4WjQUhW1fCre4n3RLrvBB.8fBO5O_FPuyvVk351v5TQ9GKZ4ce1V54vNh7SEaEWZgBEkpCbEJQ
 248v16w627hndPZWLijItPs1VZ5Or7v_.vslOO7toBzbdpzYsmMOwWbMLnX3M.0.kUqsccY7QkD5
 LZnuxt4Krza6Hobxf.ULSuhL4vqthpoLyLqiljuvv5tshCAywIGFU7HNEj5LbxhkW8Qs2wW21D.v
 5fsIqLBzvQmmek5h0O27hDMnjrX92XF.Gej.McEr4s1AkiDJCCcXbcE98G7FvvbPTfqaSEDlF_qW
 TMmcHOoyQd.ZLGD1VJ6uGRjH3EQ--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Tue, 25 Oct 2022 18:48:37 +0000
Received: by hermes--production-gq1-754cb59848-jkt9q (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID d383105834ed78a52d504d4d360854e7;
          Tue, 25 Oct 2022 18:48:35 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     casey@schaufler-ca.com, jmorris@namei.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net
Subject: [PATCH v1 6/8] LSM: lsm_self_attr syscall for LSM self attributes
Date:   Tue, 25 Oct 2022 11:45:17 -0700
Message-Id: <20221025184519.13231-7-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221025184519.13231-1-casey@schaufler-ca.com>
References: <20221025184519.13231-1-casey@schaufler-ca.com>
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

Create a system call lsm_self_attr() to provide the security
module maintained attributes of the current process. Historically
these attributes have been exposed to user space via entries in
procfs under /proc/self/attr.

Attributes are provided as a collection of lsm_ctx structures
which are placed into a user supplied buffer. Each structure
identifys the security module providing the attribute, which
of the possible attributes is provided, the size of the
attribute, and finally the attribute value. The format of the
attribute value is defined by the security module, but will
always be \0 terminated. The ctx_len value will be larger than
strlen(ctx).

        ------------------------------
        | unsigned int id            |
        ------------------------------
        | unsigned int flags         |
        ------------------------------
        | __kernel_size_t ctx_len    |
        ------------------------------
        | unsigned char ctx[ctx_len] |
        ------------------------------
        | unsigned int id            |
        ------------------------------
        | unsigned int flags         |
        ------------------------------
        | __kernel_size_t ctx_len    |
        ------------------------------
        | unsigned char ctx[ctx_len] |
        ------------------------------

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/syscalls.h |   2 +
 include/uapi/linux/lsm.h |  21 ++++++
 kernel/sys_ni.c          |   3 +
 security/Makefile        |   1 +
 security/lsm_syscalls.c  | 156 +++++++++++++++++++++++++++++++++++++++
 5 files changed, 183 insertions(+)
 create mode 100644 security/lsm_syscalls.c

diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index a34b0f9a9972..2d9033e9e5a0 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -71,6 +71,7 @@ struct clone_args;
 struct open_how;
 struct mount_attr;
 struct landlock_ruleset_attr;
+struct lsm_cxt;
 enum landlock_rule_type;
 
 #include <linux/types.h>
@@ -1056,6 +1057,7 @@ asmlinkage long sys_memfd_secret(unsigned int flags);
 asmlinkage long sys_set_mempolicy_home_node(unsigned long start, unsigned long len,
 					    unsigned long home_node,
 					    unsigned long flags);
+asmlinkage long sys_lsm_self_attr(struct lsm_ctx *ctx, size_t *size, int flags);
 
 /*
  * Architecture-specific system calls
diff --git a/include/uapi/linux/lsm.h b/include/uapi/linux/lsm.h
index 61e13b1b9ece..1d27fb5b7746 100644
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
+	unsigned int		id;
+	unsigned int		flags;
+	__kernel_size_t		ctx_len;
+	unsigned char		ctx[];
+};
+
 /*
  * ID values to identify security modules.
  * A system may use more than one security module.
diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index 860b2dcf3ac4..0fdb0341251d 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -262,6 +262,9 @@ COND_SYSCALL_COMPAT(recvmsg);
 /* mm/nommu.c, also with MMU */
 COND_SYSCALL(mremap);
 
+/* security/lsm_syscalls.c */
+COND_SYSCALL(lsm_self_attr);
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
index 000000000000..da0fab7065e2
--- /dev/null
+++ b/security/lsm_syscalls.c
@@ -0,0 +1,156 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * System calls implementing the Linux Security Module API.
+ *
+ *  Copyright (C) 2022 Casey Schaufler <casey@schaufler-ca.com>
+ *  Copyright (C) Intel Corporation
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
+struct feature_map {
+	char *name;
+	int feature;
+};
+
+static const struct feature_map lsm_attr_names[] = {
+	{ .name = "current",	.feature = LSM_ATTR_CURRENT, },
+	{ .name = "exec",	.feature = LSM_ATTR_EXEC, },
+	{ .name = "fscreate",	.feature = LSM_ATTR_FSCREATE, },
+	{ .name = "keycreate",	.feature = LSM_ATTR_KEYCREATE, },
+	{ .name = "prev",	.feature = LSM_ATTR_PREV, },
+	{ .name = "sockcreate",	.feature = LSM_ATTR_SOCKCREATE, },
+};
+
+/**
+ * lsm_self_attr - Return current task's security module attributes
+ * @ctx: the LSM contexts
+ * @size: size of @ctx, updated on return
+ * @flags: reserved for future use, must be zero
+ *
+ * Returns the calling task's LSM contexts. On success this
+ * function returns the number of @ctx array elements. This value
+ * may be zero if there are no LSM contexts assigned. If @size is
+ * insufficient to contain the return data -E2BIG is returned and
+ * @size is set to the minimum required size. In all other cases
+ * a negative value indicating the error is returned.
+ */
+SYSCALL_DEFINE3(lsm_self_attr,
+	       struct lsm_ctx __user *, ctx,
+	       size_t __user *, size,
+	       int, flags)
+{
+	struct lsm_ctx *final = NULL;
+	struct lsm_ctx *interum;
+	struct lsm_ctx *ip;
+	void *curr;
+	char **interum_ctx;
+	char *cp;
+	size_t total_size = 0;
+	int count = 0;
+	int attr;
+	int len;
+	int rc = 0;
+	int i;
+
+	interum = kzalloc(ARRAY_SIZE(lsm_attr_names) * lsm_id *
+			  sizeof(*interum), GFP_KERNEL);
+	if (interum == NULL)
+		return -ENOMEM;
+	ip = interum;
+
+	interum_ctx = kzalloc(ARRAY_SIZE(lsm_attr_names) * lsm_id *
+			      sizeof(*interum_ctx), GFP_KERNEL);
+	if (interum_ctx == NULL) {
+		kfree(interum);
+		return -ENOMEM;
+	}
+
+	for (attr = 0; attr < ARRAY_SIZE(lsm_attr_names); attr++) {
+		for (i = 0; i < lsm_id; i++) {
+			if ((lsm_idlist[i]->features &
+			     lsm_attr_names[attr].feature) == 0)
+				continue;
+
+			len = security_getprocattr(current, lsm_idlist[i]->id,
+						   lsm_attr_names[attr].name,
+						   &cp);
+			if (len <= 0)
+				continue;
+
+			ip->id = lsm_idlist[i]->id;
+			ip->flags = lsm_attr_names[attr].feature;
+			/* space for terminating \0 is allocated below */
+			ip->ctx_len = len + 1;
+			interum_ctx[count] = cp;
+			/*
+			 * Security modules have been inconsistent about
+			 * including the \0 terminator in the size. The
+			 * context len has been adjusted to ensure there
+			 * is one.
+			 * At least one security module adds a \n at the
+			 * end of a context to make it look nicer. Change
+			 * that to a \0 so that user space doesn't have to
+			 * work around it. Because of this meddling it is
+			 * safe to assume that lsm_ctx.name is terminated
+			 * and that strlen(lsm_ctx.name) < lsm.ctx_len.
+			 */
+			total_size += sizeof(*interum) + ip->ctx_len;
+			cp = strnchr(cp, len, '\n');
+			if (cp != NULL)
+				*cp = '\0';
+			ip++;
+			count++;
+		}
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
+		memcpy(curr, interum_ctx[i], ip->ctx_len);
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
2.37.3

