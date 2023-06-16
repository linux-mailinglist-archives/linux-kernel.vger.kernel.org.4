Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65FD17336C5
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 18:54:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345904AbjFPQyb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 12:54:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345860AbjFPQyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 12:54:11 -0400
Received: from sonic311-30.consmr.mail.ne1.yahoo.com (sonic311-30.consmr.mail.ne1.yahoo.com [66.163.188.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D15C4C0F
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 09:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1686934357; bh=SISrEF7dfcQb5ImkQtt8tiV4gey3h75Xjoz2C6oe6hM=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=OJ2Bx+RmydJI0TqR0K/xONp78I5h6OmXE45j7MVzr07i0VM6saLk0D1gZsLPO9EInfKDqMc2cqLvqdT4MCvZH/CwT8ZTkqiIliHuZb/jo4q4ErpVzlc3tr6+Q9SLMJubwkE8kf+bBt0I3pQ/yj0zhv01CBoho8z/PNVM0JS/QAv4B0rJKo7GbV9nUfPnl5PnQPAbdJjEunpbH5k0sn9SVhPzoTcXFeteegDeykmn5RMUe26jMyP36ckHhjn7gWmFoUaZjztG9V2LwZpPmV4Yot2I0NJZmzMpLaSO5Wd85i6eVb1ckjMP2ReMuNPd+bs8dJAaPQrofDz/DQHXKwKbCQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1686934357; bh=qjdVfySiO1qX7pIe1auJ2poOSJWyKuIgteX6gA00gaV=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=QCXfwP7CEjrDnWT7V7zTCgp6AaCDpUCic5N1N7MGbOAr8iujMW5qn5l2C0RBoPiR/7Sin/vib5c/UykZVhwDKOLJ2H43x0MTyM2qQ8vIFwFDmp5uiiiRKCcWfGX8ARta4Th3w3bdqU0Ma9D+qE4AlEvM0HSwTSWgIeeRKLq4jP8PCkuOM5d7qelUxSFKLFRxsb3lL2FhnFr1oJlcMApJ3N9HEJ8rW4N4njN4V/eiDX1UtKXF/lEhZrgTi+Fy69U5uDGArehNF0k1/sGEAf/Wu+wLPyRZgSSMbNFZ2vn1cA4znb4oWwlNTyyZ+imZpXQopbLjyCkas2T8SzyiZNhcjA==
X-YMail-OSG: EUEKHwEVM1lhdL5_Sp868_6aJV4c8dEQvL.mHSTr_BV6S2OEatiCBKH5KEtDh.Z
 q6dGTilVWclWy8LvGZbs4EbFGmZEfLjuOp0t34x9WFo5fO7EfubLUT9ty7CRgiB3McJFWYlfvOuT
 muEcNPvv.xbpEWCRfMGVwyeCkUX7vRUmbahiuMHapJ.KyWU3mjC9R_m2Hz0panVmx8j.bIwTJwmu
 PPO37G_Dcd9aSwyQBSyUkF8ndM01hR6XWSN5zY._H5lILfquok0jajtR3KUyEqS8Mw6TokhOs2Y.
 ixgxIan3MOoB6Uchg7Ng4X9VcAEhyv_pjynUEaiCUA0o81I6sX9yY0dmfgnTQuNO0rq60Szs_q9n
 EYT3ZCvDuQvNzz_LP_g6WN71eBzlQVEI2TgzpRlxCj.kjt5g5mllVbPW2bFdb0EaUEq6OeF_1aOC
 rufmRErRos7CGEgr9rsNWe6pkzFbFGF81e3a8Dg542SCE.YfASRpMzDY3THru90dHm7lh2fuMdnN
 oFRQouxZ9ZhOnEkz94LF8bm6qLfo6t3srQckP_Zw3qQvNtM.GiSicY4LU65L1T5RhXkrrdf3EtYN
 o6eckJvi3RCpu5OqaHrktLoCJgLTxjb_dyccnyLGwBX2PQqORqsY00T3hRCl57A.LBbJIstfWXTI
 wbJgXaLuZL.KOayKd5.2wqxbJUtrDLJDx.QiJJ5P5UJvk8SxPmK.wfszVukVJbpsDE7zjrN7QTCk
 XZMgLD0UV6Fr4REme6bC9PdV2XNOVYF4.gN31Jiqy17.NBbkGf19xPe4yszLPANTUBkUeMXSs7XP
 FooXlqIABJYFUhKus0sENkh7K1g1olMr83X2dxzsWvbgIp7FPC_VeBSzaBGcI9QX.jC7hAJgNqXt
 6CzWt_5PnondqNdExUu6vwE9wu7JdzAykCikz2MQdO3K2jTUs_t5jyEU2iBIYAtduHOnjd8Z8cHi
 f95tzA9pb.t_2lST.js0FxYzXMLi6x7PdFUcmoDvj9dJKl2B1XKps5aqk0w8QCUoQ0mf9vOxQPYP
 RDpxLWRUd.1vM61zIwFPHUBsnb23Tw3vCm5ZvHmySBYnjocmlsiBye.10XmDUt3an7r9jKOMywG4
 bB4SmT5mQY_MJaoHl9zLZOBq8HNpkwjrnqqJODpcSphdkHWxaUQ6eJJd3ghKOAWv2AKzUVm3m8LC
 FghOHJh0STuGwHZfCqkTsqwdn68j0sKFJT8.E.eNoJ4JLUsCKMUuCX7ekpBJviVUWuBUq8FlNEb7
 d8W6gqedNVF5ok8fy2.upN02RvXC.adNVrPlwSIFPpYDDe.XfBeafcBeEQ.zI3DQgW47OMDsrpQQ
 eeOfVXX_K2rbyeGENtJrYvSQCue89an7sNvm4KSJPkOcEax6MQyVxWqbazC6yTqk5D_9lEL.gMzE
 JHteEAD1srPU0hHppQEuMM6I.NabCNXCviHO0LWvIvC7B5PubB869SeUMfX.lj0nWEnDTiX192.X
 V4iiWdT9_k8gYmJQJsBjTpWdhmS58Y5MPYRzbsSgTloyc1OcOL4lmkapMe6cF.JgS7iUIqP6Tzwt
 21jUFum1WaGwRrHle07xVriallE6RdY_EiSifEvlpRNYWkPjN10R8bHM_YXhzjrK0xMzNW.NiFhV
 HSLTnKRS_Uf6OR2.Kv3SVMsYK95fFqr9ehTPYWDoPsQRoiO5aii_IXEMm7zUfmdRgteRFBdUqdSH
 k5TjU44GrRZlA9AYDzZRHpquhv35xiLZige71yIDY7Sd_z4l2tLcBWCmoA8QqHlqyTL2bLxuFIjC
 BPmWZwJj6BYPf47RroeoKcJEW_aMRpxievmXPTvTu9WUsfXe4cqz3oBCXARLHr9A92q6oPFiMQMW
 iR1h_ASzTIetJ7jjT6VrHMBlByHOBUE5K5RKn2l6Ln3T73rFM39vCB3oQW2sMRmE9pUK0_p4US4A
 LjdtEV0NME4skS.JKLxp1UKSmXD7DLODnX3.cqbjw5139isaSxZf78UH5UoGm96dYxLZ_6ao4nJ7
 O8A4oZbDp.CA960hQAeZ9oL1YmGAAMGwOlLBVa6SLR_Z356FukSyvTHy03BydK21w4FrqeG5pHRL
 ymg57.BMIBWzhkjjfCeDo3NEt9TWVLDBnsG_3GRfzl_hM9JvxlKIMZ5fqL.TPCBXsYnyvuZRrzgS
 6rzQNpLtNWnS5du7IvvORtx49mqaUVlRlzvKuzyYZUHOoGMW8wRo2WThzHCAqYd1ipbKuext7S3c
 cUjai0Kd._PIyttzGDfE5C36XUJ79gyLsZfTfbBZDG70QI77NMRX7iVu0Ch9Lvzp4pKNiXtn2EFh
 l_B19VGPxfopPP0WZ
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: f593fcb2-e8e0-4032-805a-72024d8172b9
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Fri, 16 Jun 2023 16:52:37 +0000
Received: by hermes--production-ne1-574d4b7954-r69wt (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 46e5733d7b6da7b60f76f64d6170c2d9;
          Fri, 16 Jun 2023 16:52:35 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey@schaufler-ca.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net
Subject: [PATCH v11 04/11] LSM: syscalls for current process attributes
Date:   Fri, 16 Jun 2023 09:50:48 -0700
Message-Id: <20230616165055.4705-5-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230616165055.4705-1-casey@schaufler-ca.com>
References: <20230616165055.4705-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
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
Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Serge Hallyn <serge@hallyn.com>
---
 Documentation/userspace-api/lsm.rst |  15 ++++
 include/linux/lsm_hook_defs.h       |   4 +
 include/linux/lsm_hooks.h           |   1 +
 include/linux/security.h            |  19 +++++
 include/linux/syscalls.h            |   5 ++
 include/uapi/linux/lsm.h            |  36 +++++++++
 kernel/sys_ni.c                     |   4 +
 security/Makefile                   |   1 +
 security/lsm_syscalls.c             |  55 ++++++++++++++
 security/security.c                 | 112 ++++++++++++++++++++++++++++
 10 files changed, 252 insertions(+)
 create mode 100644 security/lsm_syscalls.c

diff --git a/Documentation/userspace-api/lsm.rst b/Documentation/userspace-api/lsm.rst
index 6ddf5506110b..e6c3f262addc 100644
--- a/Documentation/userspace-api/lsm.rst
+++ b/Documentation/userspace-api/lsm.rst
@@ -48,6 +48,21 @@ creating socket objects.
 The proc filesystem provides this value in ``/proc/self/attr/sockcreate``.
 This is supported by the SELinux security module.
 
+Kernel interface
+================
+
+Set a security attribute of the current process
+-----------------------------------------------
+
+.. kernel-doc:: security/lsm_syscalls.c
+    :identifiers: sys_lsm_set_self_attr
+
+Get the specified security attributes of the current process
+------------------------------------------------------------
+
+.. kernel-doc:: security/lsm_syscalls.c
+    :identifiers: sys_lsm_get_self_attr
+
 Additional documentation
 ========================
 
diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 6bb55e61e8e8..f69a7863dbe2 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -261,6 +261,10 @@ LSM_HOOK(int, 0, sem_semop, struct kern_ipc_perm *perm, struct sembuf *sops,
 LSM_HOOK(int, 0, netlink_send, struct sock *sk, struct sk_buff *skb)
 LSM_HOOK(void, LSM_RET_VOID, d_instantiate, struct dentry *dentry,
 	 struct inode *inode)
+LSM_HOOK(int, -EOPNOTSUPP, getselfattr, unsigned int attr,
+	 struct lsm_ctx __user *ctx, size_t *size, u32 flags)
+LSM_HOOK(int, -EOPNOTSUPP, setselfattr, unsigned int attr,
+	 struct lsm_ctx __user *ctx, size_t size, u32 flags)
 LSM_HOOK(int, -EINVAL, getprocattr, struct task_struct *p, const char *name,
 	 char **value)
 LSM_HOOK(int, -EINVAL, setprocattr, const char *name, void *value, size_t size)
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index fba8881d2bb5..9a3ae6b33d7b 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -25,6 +25,7 @@
 #ifndef __LINUX_LSM_HOOKS_H
 #define __LINUX_LSM_HOOKS_H
 
+#include <uapi/linux/lsm.h>
 #include <linux/security.h>
 #include <linux/init.h>
 #include <linux/rculist.h>
diff --git a/include/linux/security.h b/include/linux/security.h
index 945101b0d404..475d0abfebda 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -60,6 +60,7 @@ struct fs_parameter;
 enum fs_value_type;
 struct watch;
 struct watch_notification;
+struct lsm_ctx;
 
 /* Default (no) options for the capable function */
 #define CAP_OPT_NONE 0x0
@@ -470,6 +471,10 @@ int security_sem_semctl(struct kern_ipc_perm *sma, int cmd);
 int security_sem_semop(struct kern_ipc_perm *sma, struct sembuf *sops,
 			unsigned nsops, int alter);
 void security_d_instantiate(struct dentry *dentry, struct inode *inode);
+int security_getselfattr(unsigned int attr, struct lsm_ctx __user *ctx,
+			 size_t __user *size, u32 flags);
+int security_setselfattr(unsigned int attr, struct lsm_ctx __user *ctx,
+			 size_t size, u32 flags);
 int security_getprocattr(struct task_struct *p, int lsmid, const char *name,
 			 char **value);
 int security_setprocattr(int lsmid, const char *name, void *value, size_t size);
@@ -1331,6 +1336,20 @@ static inline void security_d_instantiate(struct dentry *dentry,
 					  struct inode *inode)
 { }
 
+static inline int security_getselfattr(unsigned int attr,
+				       struct lsm_ctx __user *ctx,
+				       size_t __user *size, u32 flags)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int security_setselfattr(unsigned int attr,
+				       struct lsm_ctx __user *ctx,
+				       size_t size, u32 flags)
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
index 000000000000..ee3881159241
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
+		ctx, size_t, size, u32, flags)
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
index 501c0884ec03..ca196b585996 100644
--- a/security/security.c
+++ b/security/security.c
@@ -3797,6 +3797,118 @@ void security_d_instantiate(struct dentry *dentry, struct inode *inode)
 }
 EXPORT_SYMBOL(security_d_instantiate);
 
+/**
+ * security_getselfattr - Read an LSM attribute of the current process.
+ * @attr: which attribute to return
+ * @ctx: the user-space destination for the information, or NULL
+ * @size: pointer to the size of space available to receive the data
+ * @flags: special handling options. LSM_FLAG_SINGLE indicates that only
+ * attributes associated with the LSM identified in the passed @ctx be
+ * reported
+ *
+ * Returns the number of attributes found on success, negative value
+ * on error. @size is reset to the total size of the data.
+ * If @size is insufficient to contain the data -E2BIG is returned.
+ */
+int security_getselfattr(unsigned int attr, struct lsm_ctx __user *ctx,
+			 size_t __user *size, u32 flags)
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
+	if (attr == LSM_ATTR_UNDEF)
+		return -EINVAL;
+	if (size == NULL)
+		return -EINVAL;
+	if (get_user(left, size))
+		return -EFAULT;
+
+	if ((flags & LSM_FLAG_SINGLE) == LSM_FLAG_SINGLE) {
+		if (!ctx)
+			return -EINVAL;
+		if (copy_struct_from_user(&lctx, sizeof(lctx), ctx, left))
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
+int security_setselfattr(unsigned int attr, struct lsm_ctx __user *ctx,
+			 size_t size, u32 flags)
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
 /**
  * security_getprocattr() - Read an attribute for a task
  * @p: the task
-- 
2.40.1

