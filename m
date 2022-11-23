Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A45E636A6D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 21:02:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235539AbiKWUBt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 15:01:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239426AbiKWUBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 15:01:07 -0500
Received: from sonic316-27.consmr.mail.ne1.yahoo.com (sonic316-27.consmr.mail.ne1.yahoo.com [66.163.187.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEBCC74CDE
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 12:01:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1669233665; bh=MYVnYQAqwebDz0miOy37feqwOXhB7i3YuIaSkuEhvQQ=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=r40hvdhp6WCtWguOqW7j+yhszoe6jY7FnD78DfSRVrZEqAqzAkyIDgSjyllNXS9CrFqhoyzSB90BelcZcCm+3cX4MNlObs3e1RhqytsIL4E6RPsZtEXrG0nyYBzWgHxQ2uMUJpgwpdXEXUV7KkSS/CDdu2kOmVdcivJ1e1+6I9pnwC8xhiMsT9rNs4Pdb6SameLLeR8plZfBP0x5AoDI6klacyl0VG4LP7tkSxQZPD6s75Tif2tTwy2K5Ggj0wspGxjKTdkyig6DfWzbqO2gJgXqybBCzvXTCMlHxJ+xk/vVXk5HytzjApOs3J4DGoALslfrkbNe7lmlRBzKADr9Ig==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1669233665; bh=uJRcIs0wS7WKQryyP/5iN/cKRQ0qhpCtcZRvfuNCMOl=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=kjN2/QQyF8dXUx/Vvj8l3PIjW3KzszgB7ExUYM49xW4lOO2q7u7NKRv89OdmVGCXXqCqTjdW2yDUtsIAWs75hsJ8dyZDV4mEQaMOkKO7BfVmC2WgVL/SQVNIFSsL5un3MLe+T2p048QpnEW8Yu9LxGp0KHNaM1VXao0UEzUREn6nETHPJsb6pEGRobRyG09F+PJkPOlyD/2qdZforr7HTExEt28JNMSKunBuaJfOU7UzoZlcyrRXmhJdmI49TWY4ZAHu+HLJkUASeLb8AafYYoYL4Oj7Q01Fz98YWPNDCO+zeKqtxjz21ez+H5x+m2+05dX9KMCUVYYiZyPR7GTlYA==
X-YMail-OSG: ZgFRZYUVM1kKPdVfrCe_hWXnLYyaAdlWs1pH3j5QROHXgZh29KnbUm4Q.nw5262
 GocPidcNaptijRG9T3C70iFjZh8kCktIK6A8YlJhVxIDflqBQcdvlUAvBLweHtBTyJ1oxAYICvhE
 cnmp4U5ndlf9FWw3Hww3L2Y6kuYXRWZqXBelIswii.VE2N_dZVY5TTHC9ojUxMtFkbg4dICARVHO
 j0r7KxVFSa99ColaYQJJw12tNZ09JMv7sSYRbCzDN.j.d0lLOi.RScLa2aF4LdpKQ8WF_FDEGU_I
 AfZPBv_NMeK2tLPslDgxUjojwGUdVi7FEwMjFQB4n230oW7HKAnhNirChAyEhdrA4tjdUkvhCXVT
 tcS7q1OBKxe_2SpU7fWxZ_96ba6rgV.V6GXILa5tgBDVAEzCJ5kP7IcmcHUUrYwC2f.wX1avakiB
 c1QH9huB5HoE6_o60X4BzoL94kgvCQ5NXdITnSjMAHJ3.0SZUITwncfb7f4PRKE7y3JWLpoU_xI2
 l5btAQ.buzd2e.T3u73Hhdp77UgsJXIV.d7BDu8qw3AH6rvcZgBBuFi18g4MoW2fR8vFjTLAGqUa
 EtW5hX408tIkb_6CiD16QvKO8yzTpWOqP3Ht9vSITUWTtIBFaKvnf.x51QBK_ie2oW7bYXR95kqq
 yajncql2bMxeMx165TGdoS.9psOa32y0_MeiO2KR.S3mBFmkagrua8sMMUjj.58A7Cvs_E2z5xxS
 eXZOkQ1we0KBb0xgVd3wEg2_akzM5fENnxgQc2bxPwYrOn9x__D.u36uEVuLd2dolIx207inJMy6
 6zMs2A9Ef.c7NV_EPvy.vntHL39jQJFvlZ.QdwNnSIJIan5jmxR5GrMFCjnDTDadDFC30ckFjA9I
 7QvwQU56BWwsUNZqRSAA6_c0Hz5GFaO0vke19AhgiqV7pj7MIqYWL2LM3YcGqeuip6lLr9Jkzkhp
 WrblRiWi_mkamSXHHehcWFmWJf7t.EEB89HmkBUs7Id1Q4ztcmCijBKAxt_wRrr0mWfimzzT1B1H
 21W6LkGySWQ6gH6pZ9vuTJ1Xq.l2SttdXD67CFNwGx3jgITAxOCffXLsqsN.MPRIdrTShUqcuM8J
 vQ_rB_UNNnq6sfkZ8DOi0_zoDY0cUgzFmVYb4aXqX3HY_62oiIL5MclnOzNJfeYHWa4gJnRtREp3
 _lDGA0Ie8TcjMXzQ7ebvjRsCmS1egbdxIyXkaVy2qIYESFTYehuWyAq_0zhog.kzPuXOncvzWQoc
 ww26ic.negTN7_KNKOEAfxScD5stjtg78EI3.YWzYtwBWaKnqF2azto56voS8lIq.jA3KL6RvC3W
 YILwv1dOmoSsSGyIEuBA66n9wQ4ZTIqms7EStYAFqXVPi_EvTK5ONvmxYbul_AngZUiQlXo_L3Jg
 DVCOKTY8ToPyUftnMeXiUsxNUEqTyXUR.vGRnID82yPf9DBLz.pIOPGfsHcOTtV3J7uitP1HUgqs
 hC0Nkp0me1uzATCPUMV9YoMkaptO6x2g5NR1_pPuWFvrs7iYChr_poYP3QLI0GNZzUuK7ZE_xa7F
 q6lEzOSNQ.H00wMgFU5E.LNoRjjLXyS_JvhkZgYYnkSsdH5Bu.jZ29OzMBGN90swqvTVaupd.w2.
 s5xE5hE8.jqWtYkLi2s9K6MXpWkGMcpwbCn8CByNuxe6s6UAwq3.KLBvG8K83BL4EIVhGgkTLy4g
 U2rdr8sb1lX7P7_YYyIos9q2xx78wvAzTmOsBz.fJ4Dmy40iwXmST2_Zz7_6fIr1E.t5oWYMAkPA
 ns8N6ZnCZGW2GMY1RcIO.e4J4tlZuOCcJ0CLdJgPsALTH2dE8K46Q9kwNVjDPHbqmQUjqtMLxbfo
 hFC860kao_4VuI.sZ3e13AvNlHkjjoz.8DyoM1TrFSFJEM56pbPfHzdmM_kLGBa9xPw8Qm_JW1rN
 _oyqoAjc2pvrAeRRZ2HcTUWFML1idmJzTpdvAfneJBr.7VXKk9MNcQ_h.RqSqafoGVGX_U7MhuKT
 MV5lfROTFYmgdPhTNEZKptY7DH1zAojsI9q1g3JeweVh2KLZCM.bXvTAG5AylukAZ6i_n1ER7xRc
 6ZDyB9eOTyGQHe3RcVDWLGk.NVsbcqttygN87qyuwx_oQtJ0Y7AARGi3SrmjAT0PwITDdd6D2p8K
 _ZRrDRV6avHrYA2V_eFl8C1tgeb6KXXB3HLDUcUUEkUD0iBXnw8MhotXJuvyuaRWTkEWNlGnucJU
 .FNwu315ssMX4gLzOLPW.mYHnzR1XRQkg2Ovkcc8bJuE-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.ne1.yahoo.com with HTTP; Wed, 23 Nov 2022 20:01:05 +0000
Received: by hermes--production-ne1-6bcfb7fb87-2hzbf (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 9a2b4e210b8fb0ce0242a6033d9f3e20;
          Wed, 23 Nov 2022 20:00:59 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     casey@schaufler-ca.com, jmorris@namei.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net
Subject: [PATCH v1 6/8] LSM: lsm_self_attr syscall for LSM self attributes
Date:   Wed, 23 Nov 2022 11:57:41 -0800
Message-Id: <20221123195744.7738-7-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221123195744.7738-1-casey@schaufler-ca.com>
References: <20221123195744.7738-1-casey@schaufler-ca.com>
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

