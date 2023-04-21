Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F423C6EB0FE
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 19:45:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233398AbjDURpF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 13:45:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233014AbjDURox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 13:44:53 -0400
Received: from sonic310-30.consmr.mail.ne1.yahoo.com (sonic310-30.consmr.mail.ne1.yahoo.com [66.163.186.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AA921736
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 10:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1682099090; bh=3v7lBuHVRUwibxvH5mLiErD4AXKr7tuIDSYHszYedZU=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=s6d6Yuo20HPBE6kefENgt6bLBONIwxcHIre+AVVqIqkMzMdV5u2P3VgcE5JkVHNljgjlELmkugGMoF/AaBZEix9gaq7VXXQ/bmkYGUzJuyd6ZnEBMTj1AWfbH9v+5AP8ZDzj+Cjx+TP4tc+b3FpXtRREHcBhKikkY1y0Q8ziGyp3KH0sEmjIspOUxjvtCOMSqDxPJbgsvxXO3eb64uIZH6U3fTC1gLZh9JArGs2/4aXuYNRqFTDvZifgChQx0VVA70v6BzYPsfE4hFt8vG0gMaqyNCVpGAqw3Y5efmgR5flJ7TAYTeI2GSeq4oj4+ARzUXiK5AJoQ6by123tj8H9Fg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1682099090; bh=2tF9p/IhfNDJQ7ebznMuWAkMP92fJvfCmKSayg8ao48=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=AdAYu+CupQ0aRV9bYmDsVet+njl2OTvkL2XiXgpnPK9oDWGdTTDu96Ahk0d/5u3Wb4RLU3g9l/dpp5KCQo+v8ZB/zhQ2hTL/QpsXrZHKffn/EUVNHDpvUPjzQdsmN2qpUsMK7fEBaF8gA4IMrqcnB23elebnfDtojvPK+mkCItxnCf4k9EOuRNcDfRgXEyV7IBmtdkWl4e9nQ1MZuU5bvxYnxodsxKHwxhjB2N2ztse8Z2xtiFizMLpZdu40CH2NI74iw+FkPyrtJfNEZqxEoWm6NGZsS/6hJsmQDDy66yOWmo8U9toUg/RBiy5jKOAl0LRGvHEiKn2xMt/Hcgklkg==
X-YMail-OSG: 33M9y60VM1l2Drqyq8X73SThlhVk9wAquFX8AeLxHc1B45ZeOr1Lef4db8wxes5
 gf7hbgVBYbH3sgxilvva33Lgki5k1RM8oKpKz4MbzbtI0VsRk0PYLr9iKkWTAFQM.R0YZPTEbvbf
 9VCLPlMyhCEvoh334y11GgkOo_BK6D2JMxxHhHjXbrQIyOf4sUljWcbOGG214vnPNU1oadnZ1E5b
 8mkMikKCr4O.LL5vEwCiyxhOEfTwlGEMi4_tjnIJ8_R_c._SMorn6alIrkQVH2AuImTKI3CZhaQk
 zwraq2dzfSgEljcovA5stzoXjl6D4Yyk6Y0OgeNMoDxjP9ohBhedCTDlCs1rcK4w7umiXAWoWNDU
 xPJzzsrbGHsAU1gHpUAD1wWuzWNWxbNQ0MhAIbm7InrKIzluARfbNF5CN1z5I.I96z3Y688eM0Ua
 qGJmdKKtt.z_Q5.f0H0IJHDI4hn2haq3CATMLaArZLbo5Pin11iro07iwBlyGOYS4Ywx57Kn5_.k
 H1Mf3DKrHbAeh7z3mQmkF8cRrs3InSBmq.tijRBveA6piPMVmZ3xDBOITQvT3pmw2iz2QR.pFTyx
 Hp5XraEWpDn4eILf.r6jHunPoUzY839PBsZFZbnj7TOzcxFpd.FwyUnApy7NdSfi3P43ZIFRgHrB
 7nJCJmCGb2KIKj6AAPcsiKyM1wVyYD_TxrgDI0.JU9n37NubGcAiFvD5f.ts1gZmsgcxy.2nwCge
 dMlR_lEqeiAmgVKzmqQsPjcz3CCE2pVca6enPD08AK7tq1n50GZ5FnCgYL32eWrRkUBLLErULMYE
 YunSDrR56kAuRtCt4WmXj9UN953sNba0DbD_Z_tGfk8Zaqyisns.Ap7AuMwA.lcCtxofSIS4NpKa
 tfGLBh3CxbdERI6VFhN1CMrVNkSQUNUk3I0EJ06qPEiku0XNR8StmpoivKvw6Fh2EvMnkVks2tPe
 25MKZMhrUim68sTTXRk7usdUW_fHesDNGPRJkRAXBcui2WjhCoyiIp9OgYwLpVO5OWp2y3q0s.2T
 c1YqSMCXUHmUuSKZw7BPBZnCLFTOg3paGIucA01GhoRC2OTYoqcMLwiBqk_SoCBGJqNjhgF0O0x8
 57g_GYqh7jUZVWVwaZRtCkvcfFF_B6sY0dM4Vz.RzkmhI_Dq.Mn1qEoGdBSjrxB8HO.VLnZu_h7.
 EJLYbQt_SYcNFTgvYbhFImayG1q2z6DD23_OpHdgjDiRb6qMyIIUx.qdw1tfDTz8b5H2g7he3.xp
 JnuPCuzJG8hHpDwA8kmUeJM9ir9wflwJA8KzTp.1G.0.bmmtpp7bNPxchTYEyrSVa_RlqB3VeJH1
 nPLxVQCGzmQTlEOSZGb9kJffuVzT5KbmDwkXbErPdYtNLmXJ06_yGbgRd.ivF68x9EkegQfVHI6D
 6kyplwa.rsaf1d8pU8fQJBUg82ZaVNz2wdzy5cGqbxNdjD_oqS7eiAd2_VrN1CBdzPEAV0ZbdYnO
 CkfeZ9Mp39lhRZT1mRRLM.sQ.c9Sa9_YSiF7hOH2cfM8SzgWu_9ru.rnm.x50uG8HUs.JukJOubj
 qk6b1Cz6XICjSLPobn8J9oo5tHG5EnUaKVzXXUCyxQlwSEWyMYYisE5EMoD1VSWEuU2PdoKuACdw
 aIZNURj6wB_FYd1DOgiUgC.LSa4..7xTXcuL5lM2TkywSyizII3NOY30djZMGR8KBRarEZ5GEDny
 hyNgWxl6W9DA8pr8Vr655cQ.Doz0yDuIuPGZDNOJAMV2Hu02Ejnuh9CUqNjpZpPhvXyXzTcPYSxK
 _dtLOhxnyXLYFkfesbKvz5S1ppdKkXF8rn9G4Zh3fcrElOJ_9rPnZ2w1eWTih6s334lYFch_u0Y0
 HDc1j.I2jGNYX15XEXJvcJ8QavNfZp9IAPTVo6tA.Ntua9fUsWfEs5QWCcVilGulSebXXcZByO0E
 k6BuAeaQcD_IIIMZ9.ayGtL7in7sQMBTOxi.Y7l2xma8aPFOsbBJE89kUixQ.4qLM8uoQdk6Cf_g
 aJAeXqjeanK5kl4kPLdBGElNZ9qgJA70YiZ.k887gOciSh9ZZidMg0yFzt5QBrFvfBb8r7xgVUnA
 nTdGNKgxzK1LlQ_S8iZAqtbvt57AT4bVhS3.0CUJnDmCqqVsziXqdTAf89H9qNtOsyb.Jmtnr4Hd
 qPXedE9tlc84QcYDbv0f4pqZ3nEYC8oodL5m8qTKoA.sGG7pTtG3CB.ppP8ot9o3QwaHehxoGh9U
 v3MoABYgsWrsJLv5jvxogQkFb1suAFox4AJ.Lglkujmw39vadKvG_Kj0cwStYdGz1EiV9bBLofgE
 BgroOBUiof5_Y7JE4yQpZ
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: f46573c0-aed4-49d4-ab05-41a2c7e21678
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ne1.yahoo.com with HTTP; Fri, 21 Apr 2023 17:44:50 +0000
Received: by hermes--production-bf1-5f9df5c5c4-8dccp (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID d2bcaa4718843a282c96eeaa4751b090;
          Fri, 21 Apr 2023 17:44:45 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey@schaufler-ca.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     jmorris@namei.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net
Subject: [PATCH v9 04/11] LSM: syscalls for current process attributes
Date:   Fri, 21 Apr 2023 10:42:52 -0700
Message-Id: <20230421174259.2458-5-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230421174259.2458-1-casey@schaufler-ca.com>
References: <20230421174259.2458-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create a system call lsm_get_self_attr() to provide the security
module maintained attributes of the current process.
Create a system call lsm_set_self_attr() to set a security
module maintained attribute of the current process.
Historically these attributes have been exposed to user space via
entries in procfs under /proc/self/attr.

The attribute value is provided in a lsm_ctx structure. The structure
identifies the size of the attribute, and the attribute value. The format
of the attribute value is defined by the security module. A flags field
is included for LSM specific information. It is currently unused and must
be 0. The total size of the data, including the lsm_ctx structure and any
padding, is maintained as well.

struct lsm_ctx {
        __u64 id;
        __u64 flags;
        __u64 len;
        __u64 ctx_len;
        __u8 ctx[];
};

Two new LSM hooks are used to interface with the LSMs.
security_getselfattr() collects the lsm_ctx values from the
LSMs that support the hook, accounting for space requirements.
security_setselfattr() identifies which LSM the attribute is
intended for and passes it along.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 Documentation/userspace-api/lsm.rst |  15 ++++
 include/linux/lsm_hook_defs.h       |   4 +
 include/linux/lsm_hooks.h           |   9 +++
 include/linux/security.h            |  19 +++++
 include/linux/syscalls.h            |   5 ++
 include/uapi/linux/lsm.h            |  36 +++++++++
 kernel/sys_ni.c                     |   4 +
 security/Makefile                   |   1 +
 security/lsm_syscalls.c             |  55 ++++++++++++++
 security/security.c                 | 110 ++++++++++++++++++++++++++++
 10 files changed, 258 insertions(+)
 create mode 100644 security/lsm_syscalls.c

diff --git a/Documentation/userspace-api/lsm.rst b/Documentation/userspace-api/lsm.rst
index 6ddf5506110b..b45e402302b3 100644
--- a/Documentation/userspace-api/lsm.rst
+++ b/Documentation/userspace-api/lsm.rst
@@ -48,6 +48,21 @@ creating socket objects.
 The proc filesystem provides this value in ``/proc/self/attr/sockcreate``.
 This is supported by the SELinux security module.
 
+Kernel interface
+================
+
+Set a security attribute of the current process
+--------------------------------------------------
+
+.. kernel-doc:: security/lsm_syscalls.c
+    :identifiers: sys_lsm_set_self_attr
+
+Get the specified security attributes of the current process
+--------------------------------------------------
+
+.. kernel-doc:: security/lsm_syscalls.c
+    :identifiers: sys_lsm_get_self_attr
+
 Additional documentation
 ========================
 
diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 094b76dc7164..7177d9554f4a 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -261,6 +261,10 @@ LSM_HOOK(int, 0, sem_semop, struct kern_ipc_perm *perm, struct sembuf *sops,
 LSM_HOOK(int, 0, netlink_send, struct sock *sk, struct sk_buff *skb)
 LSM_HOOK(void, LSM_RET_VOID, d_instantiate, struct dentry *dentry,
 	 struct inode *inode)
+LSM_HOOK(int, -EOPNOTSUPP, getselfattr, unsigned int __user attr,
+	 struct lsm_ctx __user *ctx, size_t *size, u32 __user flags)
+LSM_HOOK(int, -EOPNOTSUPP, setselfattr, unsigned int __user attr,
+	 struct lsm_ctx __user *ctx, size_t size, u32 __user flags)
 LSM_HOOK(int, -EINVAL, getprocattr, struct task_struct *p, const char *name,
 	 char **value)
 LSM_HOOK(int, -EINVAL, setprocattr, const char *name, void *value, size_t size)
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 8e6ba0a9896e..ed38ad5eb444 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -25,6 +25,7 @@
 #ifndef __LINUX_LSM_HOOKS_H
 #define __LINUX_LSM_HOOKS_H
 
+#include <uapi/linux/lsm.h>
 #include <linux/security.h>
 #include <linux/init.h>
 #include <linux/rculist.h>
@@ -503,6 +504,14 @@
  *	and writing the xattrs as this hook is merely a filter.
  * @d_instantiate:
  *	Fill in @inode security information for a @dentry if allowed.
+ * @getselfattr:
+ *	Read attribute @attr for the current process and store it into @ctx.
+ *	Return 0 on success, -EOPNOTSUPP if the attribute is not supported,
+ *	or another negative value otherwise.
+ * @setselfattr:
+ *	Set attribute @attr for the current process.
+ *	Return 0 on success, -EOPNOTSUPP if the attribute is not supported,
+ *	or another negative value otherwise.
  * @getprocattr:
  *	Read attribute @name for process @p and store it into @value if allowed.
  *	Return the length of @value on success, a negative value otherwise.
diff --git a/include/linux/security.h b/include/linux/security.h
index 8faed81fc3b4..f7292890b6a2 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -60,6 +60,7 @@ struct fs_parameter;
 enum fs_value_type;
 struct watch;
 struct watch_notification;
+struct lsm_ctx;
 
 /* Default (no) options for the capable function */
 #define CAP_OPT_NONE 0x0
@@ -473,6 +474,10 @@ int security_sem_semctl(struct kern_ipc_perm *sma, int cmd);
 int security_sem_semop(struct kern_ipc_perm *sma, struct sembuf *sops,
 			unsigned nsops, int alter);
 void security_d_instantiate(struct dentry *dentry, struct inode *inode);
+int security_getselfattr(unsigned int __user attr, struct lsm_ctx __user *ctx,
+			 size_t __user *size, u32 __user flags);
+int security_setselfattr(unsigned int __user attr, struct lsm_ctx __user *ctx,
+			 size_t __user size, u32 __user flags);
 int security_getprocattr(struct task_struct *p, int lsmid, const char *name,
 			 char **value);
 int security_setprocattr(int lsmid, const char *name, void *value, size_t size);
@@ -1343,6 +1348,20 @@ static inline void security_d_instantiate(struct dentry *dentry,
 					  struct inode *inode)
 { }
 
+static inline int security_getselfattr(unsigned int __user attr,
+				       struct lsm_ctx __user *ctx,
+				       size_t __user *size, u32 __user flags)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int security_setselfattr(unsigned int __user attr,
+				       struct lsm_ctx __user *ctx,
+				       size_t __user size, u32 __user flags)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline int security_getprocattr(struct task_struct *p, int lsmid,
 				       const char *name, char **value)
 {
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 33a0ee3bcb2e..9a94c31bf6b6 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -71,6 +71,7 @@ struct clone_args;
 struct open_how;
 struct mount_attr;
 struct landlock_ruleset_attr;
+struct lsm_ctx;
 enum landlock_rule_type;
 
 #include <linux/types.h>
@@ -1058,6 +1059,10 @@ asmlinkage long sys_memfd_secret(unsigned int flags);
 asmlinkage long sys_set_mempolicy_home_node(unsigned long start, unsigned long len,
 					    unsigned long home_node,
 					    unsigned long flags);
+asmlinkage long sys_lsm_get_self_attr(unsigned int attr, struct lsm_ctx *ctx,
+				      size_t *size, __u32 flags);
+asmlinkage long sys_lsm_set_self_attr(unsigned int attr, struct lsm_ctx *ctx,
+				      size_t size, __u32 flags);
 
 /*
  * Architecture-specific system calls
diff --git a/include/uapi/linux/lsm.h b/include/uapi/linux/lsm.h
index f27c9a9cc376..eeda59a77c02 100644
--- a/include/uapi/linux/lsm.h
+++ b/include/uapi/linux/lsm.h
@@ -9,6 +9,36 @@
 #ifndef _UAPI_LINUX_LSM_H
 #define _UAPI_LINUX_LSM_H
 
+#include <linux/types.h>
+#include <linux/unistd.h>
+
+/**
+ * struct lsm_ctx - LSM context information
+ * @id: the LSM id number, see LSM_ID_XXX
+ * @flags: LSM specific flags
+ * @len: length of the lsm_ctx struct, @ctx and any other data or padding
+ * @ctx_len: the size of @ctx
+ * @ctx: the LSM context value
+ *
+ * The @len field MUST be equal to the size of the lsm_ctx struct
+ * plus any additional padding and/or data placed after @ctx.
+ *
+ * In all cases @ctx_len MUST be equal to the length of @ctx.
+ * If @ctx is a string value it should be nul terminated with
+ * @ctx_len equal to `strlen(@ctx) + 1`.  Binary values are
+ * supported.
+ *
+ * The @flags and @ctx fields SHOULD only be interpreted by the
+ * LSM specified by @id; they MUST be set to zero/0 when not used.
+ */
+struct lsm_ctx {
+	__u64 id;
+	__u64 flags;
+	__u64 len;
+	__u64 ctx_len;
+	__u8 ctx[];
+};
+
 /*
  * ID tokens to identify Linux Security Modules (LSMs)
  *
@@ -51,4 +81,10 @@
 #define LSM_ATTR_PREV		104
 #define LSM_ATTR_SOCKCREATE	105
 
+/*
+ * LSM_FLAG_XXX definitions identify special handling instructions
+ * for the API.
+ */
+#define LSM_FLAG_SINGLE	0x0001
+
 #endif /* _UAPI_LINUX_LSM_H */
diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index 860b2dcf3ac4..d03c78ef1562 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -262,6 +262,10 @@ COND_SYSCALL_COMPAT(recvmsg);
 /* mm/nommu.c, also with MMU */
 COND_SYSCALL(mremap);
 
+/* security/lsm_syscalls.c */
+COND_SYSCALL(lsm_get_self_attr);
+COND_SYSCALL(lsm_set_self_attr);
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
index 000000000000..feee31600219
--- /dev/null
+++ b/security/lsm_syscalls.c
@@ -0,0 +1,55 @@
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
+/**
+ * sys_lsm_set_self_attr - Set current task's security module attribute
+ * @attr: which attribute to set
+ * @ctx: the LSM contexts
+ * @size: size of @ctx
+ * @flags: reserved for future use
+ *
+ * Sets the calling task's LSM context. On success this function
+ * returns 0. If the attribute specified cannot be set a negative
+ * value indicating the reason for the error is returned.
+ */
+SYSCALL_DEFINE4(lsm_set_self_attr, unsigned int, attr, struct lsm_ctx __user *,
+		ctx, size_t __user, size, u32, flags)
+{
+	return security_setselfattr(attr, ctx, size, flags);
+}
+
+/**
+ * sys_lsm_get_self_attr - Return current task's security module attributes
+ * @attr: which attribute to set
+ * @ctx: the LSM contexts
+ * @size: size of @ctx, updated on return
+ * @flags: reserved for future use
+ *
+ * Returns the calling task's LSM contexts. On success this
+ * function returns the number of @ctx array elements. This value
+ * may be zero if there are no LSM contexts assigned. If @size is
+ * insufficient to contain the return data -E2BIG is returned and
+ * @size is set to the minimum required size. In all other cases
+ * a negative value indicating the error is returned.
+ */
+SYSCALL_DEFINE4(lsm_get_self_attr, unsigned int, attr, struct lsm_ctx __user *,
+		ctx, size_t __user *, size, u32, flags)
+{
+	return security_getselfattr(attr, ctx, size, flags);
+}
diff --git a/security/security.c b/security/security.c
index 38ca0e646cac..bc3f166b4bff 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2167,6 +2167,116 @@ void security_d_instantiate(struct dentry *dentry, struct inode *inode)
 }
 EXPORT_SYMBOL(security_d_instantiate);
 
+/**
+ * security_getselfattr - Read an LSM attribute of the current process.
+ * @attr: which attribute to return
+ * @ctx: the user-space destination for the information, or NULL
+ * @size: the size of space available to receive the data
+ * @flags: special handling options. LSM_FLAG_SINGLE indicates that only
+ * attributes associated with the LSM identified in the passed @ctx be
+ * reported
+ *
+ * Returns the number of attributes found on success, negative value
+ * on error. @size is reset to the total size of the data.
+ * If @size is insufficient to contain the data -E2BIG is returned.
+ */
+int security_getselfattr(unsigned int __user attr, struct lsm_ctx __user *ctx,
+			 size_t __user *size, u32 __user flags)
+{
+	struct security_hook_list *hp;
+	struct lsm_ctx lctx = { .id = LSM_ID_UNDEF, };
+	u8 __user *base = (u8 __user *)ctx;
+	size_t total = 0;
+	size_t entrysize;
+	size_t left;
+	bool toobig = false;
+	int count = 0;
+	int rc;
+
+	if (attr == 0)
+		return -EINVAL;
+	if (size == NULL)
+		return -EINVAL;
+	if (get_user(left, size))
+		return -EFAULT;
+
+	if ((flags & LSM_FLAG_SINGLE) == LSM_FLAG_SINGLE) {
+		if (copy_from_user(&lctx, ctx, sizeof(*ctx)))
+			return -EFAULT;
+		if (lctx.id == LSM_ID_UNDEF)
+			return -EINVAL;
+	} else if (flags) {
+		return -EINVAL;
+	}
+
+	hlist_for_each_entry(hp, &security_hook_heads.getselfattr, list) {
+		if (lctx.id != LSM_ID_UNDEF && lctx.id != hp->lsmid->id)
+			continue;
+		entrysize = left;
+		if (base)
+			ctx = (struct lsm_ctx __user *)(base + total);
+		rc = hp->hook.getselfattr(attr, ctx, &entrysize, flags);
+		if (rc == -EOPNOTSUPP) {
+			rc = 0;
+			continue;
+		}
+		if (rc == -E2BIG) {
+			toobig = true;
+			left = 0;
+			continue;
+		}
+		if (rc < 0)
+			return rc;
+
+		left -= entrysize;
+		total += entrysize;
+		count += rc;
+	}
+	if (put_user(total, size))
+		return -EFAULT;
+	if (toobig)
+		return -E2BIG;
+	if (count == 0)
+		return LSM_RET_DEFAULT(getselfattr);
+	return count;
+}
+
+/**
+ * security_setselfattr - Set an LSM attribute on the current process.
+ * @attr: which attribute to set
+ * @ctx: the user-space source for the information
+ * @size: the size of the data
+ * @flags: reserved for future use, must be 0
+ *
+ * Set an LSM attribute for the current process. The LSM, attribute
+ * and new value are included in @ctx.
+ *
+ * Returns 0 on success, -EINVAL if the input is inconsistent, -EFAULT
+ * if the user buffer is inaccessible or an LSM specific failure.
+ */
+int security_setselfattr(unsigned int __user attr, struct lsm_ctx __user *ctx,
+			 size_t __user size, u32 __user flags)
+{
+	struct security_hook_list *hp;
+	struct lsm_ctx lctx;
+
+	if (flags)
+		return -EINVAL;
+	if (size < sizeof(*ctx))
+		return -EINVAL;
+	if (copy_from_user(&lctx, ctx, sizeof(*ctx)))
+		return -EFAULT;
+	if (size < lctx.len || size < lctx.ctx_len + sizeof(ctx) ||
+	    lctx.len < lctx.ctx_len + sizeof(ctx))
+		return -EINVAL;
+
+	hlist_for_each_entry(hp, &security_hook_heads.setselfattr, list)
+		if ((hp->lsmid->id) == lctx.id)
+			return hp->hook.setselfattr(attr, ctx, size, flags);
+
+	return LSM_RET_DEFAULT(setselfattr);
+}
+
 int security_getprocattr(struct task_struct *p, int lsmid, const char *name,
 			 char **value)
 {
-- 
2.39.2

