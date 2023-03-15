Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 233016BC00B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 23:49:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232616AbjCOWtA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 18:49:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229976AbjCOWsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 18:48:52 -0400
Received: from sonic313-15.consmr.mail.ne1.yahoo.com (sonic313-15.consmr.mail.ne1.yahoo.com [66.163.185.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE66F2F7B9
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 15:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1678920527; bh=JFySRqQrJL7h9xbnsNV+/zhW0Q6Tup4sDm7okJzv8pM=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=REUpUd3L3AS+6yFDeO6UthCBpOD9J2bG7rf8MHUElwV4SHIu5VNyra4D/XBINKDwRFUe9p5MWyS3t8Y7L8e5SXTM0f3aM6jEy+es/fwF+2J/wylEEIiCtjV/8E/fRsyPKnOyKvNGr+AoDLxQuykMfRItAklgR21ni9cu9XVNYpgDqnVe+YfWeFRyVyJ64IFloJuJtwUlRdyvfdlCyYw4hwC/yd0iW8YEUMsuixxOn5Wt1ZEkyM9NAjnRjhCO6i92/I/lovS4B/jNUJPt1ekma0yrsT56UNmSLMQRXRb3i62aDuLAOwIlf1l3Zrq6BagGd1sVmttS6di2hW0ZkJk2uA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1678920527; bh=5glQw0N2+V0YHjBbPWBx/B0LYIlRLxZp8G8GesbokXF=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=pNM379B3+k0wrxJ0JsaZjpozY5I4M9JJsqM2f2wcq3zH59ZMzPOOKUyS7Wh8bqCKSa9BwB5om2IA+1LZV6f+Z1oS8GXN5iqxPhvYJf5ZC3OnNjTy5yP5c+VJuFjZbY9NMLqj5iNWSu92WpJ6JT5dN+51gcEeF9VKeSPsPrheNC+gKZLdliLsJo2KyrU8Z9cMvUOnLBBCBJFQ2rSAyCxuq8Dn1R0hLm3MLgepqA1ESj19ThUA190vTAlNvzVY0px7yecNQ5sKDPMSOMzXwHvJNeaCrI0nvFjXDGSFg/3um6u0GF6YM1poD5K7aA5a9ZRyf/LAlavIkVuuHQ5Rn0OKWw==
X-YMail-OSG: EXzz8Q4VM1lLrQKzhWXy2RrDEHrJ99VSdQvuYPWUAZjfx8g4FZ6.Zcpi2B9CZ93
 vReq_FJdHKm3C.uuCSRNjs7Gc5JLpLyPfyH_6E0Addxn0_HS64Z9.Ndr7Jin0.kRo1oOKj_7GGav
 neBl4FRt8MrU7vdz8BJp9qqRwB_J3shIVggC3qo6t66qMaBy2H.pGw4sOaUPW9BOY5QiLpt90wPY
 pMQcTr3QHjuGWEwnmdjYJpzqWAwJGJ2Vp99O5lNBTRXhhPufnrrwWuh.jw3g6reyXjNBB7_jAW6D
 DfES9K52Yzvp5VPSkLs.Xp2_Xki8_11yAhRs1h8qMVokpaIcood68yv1lCYrYBjG3s08U39JmWU1
 3bNqramsSqUnStscIY6M3MllvZK6Xzq3mFY4oUI4uWCl_PZvGnN8IRfeq7ahZ_R.FQW06qGeVa_C
 Opvs9FmkZKkJ1QmJSlCkCgUi2xY40qoSOvYqTVJJANOGeBYmB8MdROX6h5K0hX9wtWgt9K5zg4zt
 m3R6N7r5lNUBLHSJq_KIIWrWBdLicCTR8Sz9BPvRajUnDAHEoDv2jT6NpV3RMTJRE9iuUp37YKms
 O9uC2FXVrcsAAZka7ZZSBiqd6bd7kmmUTcmZKZEkA0r1lF5rv8q7hQelg2kzrJTUNxX1UqBPyQeV
 tJHHuITH9G1GYDIemTngKlsoQo3Y65JqdPVXDlbeJ3SNMvtxn9EjVohC3lx3Ay4OMV8VQAvd4Mw9
 H8tahsvbJLrWiA800NQCdCbKxXklJNvPPuto24J1Ua.oXw57g9cmpk3gmcCzNgXAdxDxY.2h.5TR
 _qGU9f.JGoTOigCJsqTt8d0Fhyk9tx1Rw0wgdnw2XYxQhYQQWNiWeKF8nHW3dgNN6R2MnBjTZNpu
 .OQ0OeqO2jXfbZZC2qRHlIp_IfubKbCx5wUdRBD1f5vDJaXGJ8fdvqVdVmTH7ALTi2gyuto6rssw
 LQGQ68XW.Iy1TIr_S83HgKWfiOlOxWTirGeJGSloLDDr9I1gDdqLuOqXQlTy0Pdk6dK1f3tbQBUR
 UvuxJ_7DchgcB2MweHGxlMI2zHlj2La9B0flQ94lv1CmzLBkzvQ2Yz89.DWb5_BSlhDKUPic4a2v
 cHpdms8qcSiYwtXhyjG.rtSDE65dGhhvue4LBtgRRLzMJuIgNuLGbTqjofWVVXYowq40_eZZ.YMX
 AwiqOBVqxpf6RqaXarITVFU6yADTskAuHYPDcTw8xwe38Gue57Qgc5IwJCNaJFQFpT.opp6u6DNt
 fxlFrqZhGfGq_jZzb6yJrN7FBdVqq0eXd186M3iA_he_gBW7KjxIUTfDjM.Wrg1CI.N.MgJArKU7
 0LPdu.b1unNzGmXR7cr1dAXPmYwzTN5NL5svDUGKfJvm0rM3Txab87H537Oll9R67OxNMsBP5.Lc
 GXGSTraJ6omNPY6cx0L0WvXk.31k8Udmr1ntb8lpF7NAL7e5KSOQuwU8NNbD3VE9cgJrJFag67vw
 qmB6yqbYOqPLE2STbnoOVW9h3wBGdnGtc0GSfC1Cjf15Ow5mov_SE20aMl0AF7KVG.OKigp_CjaZ
 5JjAJ6mGnZYpDn3WUEI4Z9OYljp1KSkjEmpT065.mGmKqU6o54sXUNiz5IDlCJiWWz9VV2MIJVQZ
 BIdJtyiVib_5jDS2SFrVPTEMrKnEX288OADoXp9Yy6PDGn_rsqZGjUzex36DCMUR5.pPwDLczvgh
 coy0TGVtrbASPiwhJj5t9AVvqLBsDkbq4TE.9SzaJlIgqF2DybQt9jMRBBj9Md8PqlqptDicsSuy
 NpU3BZM4ZKLU3kG6P2gkwNzSAA5oJVTUVMZi8ftJefcwQvXSpMmjlM3JFCXisEIZM19zwgK2MagH
 fwy4OuQJtmxkXP8wpqjO4r6QfRQt.7Kew2FUx5.KU5DBrLkCjhuKfBAU6qsoCf3y6JDIGAHhJvAr
 UmJ8QeOrb.FHGLVk7augAz4HWUg8B9HeZcWbSFfQ16UdvKjNhm.ubWVYrlhG81Nl3VbWfbCv1rXT
 umWXB42DaDGaei4iaQ3JCey0j6P56top0y.aDzmPnCm.HmjmkkjnUeLUH_ECbJsJb6zSAKT5_DW5
 qTeqBe75IfMT1t1VYqCtksICR3uuuEK9U.cAVbl1SGXlToQDzajrpo8Pkp8Q2XTFolZgDQvrVDSv
 RTIY6742rOyxXiogay5NTmo4aBovEB4l5qQA.B6FK6xdZkWKomXJKJt0qjuTuYt3NCPTZcwB0R4g
 RWWy_Yv7_P4auHtkvgsc8UuKGMeh1R.kLBzvhYUBg
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: d138cd13-5a04-4596-9d2a-112633e510bd
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Wed, 15 Mar 2023 22:48:47 +0000
Received: by hermes--production-gq1-6cf7749bc8-pgxdl (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 85e66b2f7435f9f3ba08ad33962dc8cf;
          Wed, 15 Mar 2023 22:48:43 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey@schaufler-ca.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     jmorris@namei.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net
Subject: [PATCH v7 04/11] LSM: syscalls for current process attributes
Date:   Wed, 15 Mar 2023 15:46:57 -0700
Message-Id: <20230315224704.2672-5-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230315224704.2672-1-casey@schaufler-ca.com>
References: <20230315224704.2672-1-casey@schaufler-ca.com>
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
module maintained attributes of the current process.
Create a system call lsm_set_self_attr() to set a security
module maintained attribute of the current process.
Historically these attributes have been exposed to user space via
entries in procfs under /proc/self/attr.

The attribute value is provided in a lsm_ctx structure. The structure
identifys the size of the attribute, and the attribute value. The format
of the attribute value is defined by the security module. A flags field
is included for LSM specific information. It is currently unused and must
be 0. The total size of the data, including the lsm_ctx structure and any
padding, is maintained as well.

struct lsm_ctx {
        __u64   id;
        __u64   flags;
        __u64   len;
        __u64   ctx_len;
        __u8    ctx[];
};

Two new LSM hooks are used to interface with the LSMs.
security_getselfattr() collects the lsm_ctx values from the
LSMs that support the hook, accounting for space requirements.
security_setselfattr() identifies which LSM the attribute is
intended for and passes it along.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 Documentation/userspace-api/lsm.rst | 15 +++++
 include/linux/lsm_hook_defs.h       |  4 ++
 include/linux/lsm_hooks.h           |  9 +++
 include/linux/security.h            | 19 ++++++
 include/linux/syscalls.h            |  5 ++
 include/uapi/linux/lsm.h            | 33 ++++++++++
 kernel/sys_ni.c                     |  4 ++
 security/Makefile                   |  1 +
 security/lsm_syscalls.c             | 55 ++++++++++++++++
 security/security.c                 | 97 +++++++++++++++++++++++++++++
 10 files changed, 242 insertions(+)
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
index 32285ce65419..3c2c4916bd53 100644
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
index 8faed81fc3b4..329cd9d2be50 100644
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
+	return -EINVAL;
+}
+
+static inline int security_setselfattr(unsigned int __user attr,
+				       struct lsm_ctx __user *ctx,
+				       size_t __user size, u32 __user flags)
+{
+	return -EINVAL;
+}
+
 static inline int security_getprocattr(struct task_struct *p, int lsmid,
 				       const char *name, char **value)
 {
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 33a0ee3bcb2e..3feca00cb0c1 100644
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
+				      size_t *size, __u64 flags);
+asmlinkage long sys_lsm_set_self_attr(unsigned int attr, struct lsm_ctx *ctx,
+				      __u64 flags);
 
 /*
  * Architecture-specific system calls
diff --git a/include/uapi/linux/lsm.h b/include/uapi/linux/lsm.h
index aa3e01867739..adfb55dce2fd 100644
--- a/include/uapi/linux/lsm.h
+++ b/include/uapi/linux/lsm.h
@@ -9,6 +9,39 @@
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
+	__u64	id;
+	__u64	flags;
+	__u64	len;
+	__u64	ctx_len;
+	__u8	ctx[];
+};
+
+#include <linux/types.h>
+#include <linux/unistd.h>
+
 /*
  * ID tokens to identify Linux Security Modules (LSMs)
  *
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
index 87c8796c3c46..2c57fe28c4f7 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2168,6 +2168,103 @@ void security_d_instantiate(struct dentry *dentry, struct inode *inode)
 }
 EXPORT_SYMBOL(security_d_instantiate);
 
+/**
+ * security_getselfattr - Read an LSM attribute of the current process.
+ * @attr: which attribute to return
+ * @ctx: the user-space destination for the information, or NULL
+ * @size: the size of space available to receive the data
+ * @flags: reserved for future use, must be 0
+ *
+ * Returns the number of attributes found on success, negative value
+ * on error. @size is reset to the total size of the data.
+ * If @size is insufficient to contain the data -E2BIG is returned.
+ */
+int security_getselfattr(unsigned int __user attr, struct lsm_ctx __user *ctx,
+			 size_t __user *size, u32 __user flags)
+{
+	struct security_hook_list *hp;
+	void __user *base = (void *)ctx;
+	size_t total = 0;
+	size_t this;
+	size_t left;
+	bool istoobig = false;
+	int count = 0;
+	int rc;
+
+	if (attr == 0)
+		return -EINVAL;
+	if (flags != 0)
+		return -EINVAL;
+	if (size == NULL)
+		return -EINVAL;
+	if (get_user(left, size))
+		return -EFAULT;
+
+	hlist_for_each_entry(hp, &security_hook_heads.getselfattr, list) {
+		this = left;
+		if (base)
+			ctx = (struct lsm_ctx __user *)(base + total);
+		rc = hp->hook.getselfattr(attr, ctx, &this, flags);
+		switch (rc) {
+		case -EOPNOTSUPP:
+			rc = 0;
+			continue;
+		case -E2BIG:
+			istoobig = true;
+			left = 0;
+			break;
+		case 0:
+			left -= this;
+			break;
+		default:
+			return rc;
+		}
+		total += this;
+		count++;
+	}
+	if (count == 0)
+		return LSM_RET_DEFAULT(getselfattr);
+	if (put_user(total, size))
+		return -EFAULT;
+	if (rc)
+		return rc;
+	if (istoobig)
+		return -E2BIG;
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
+ * Returns 0 on success, an LSM specific value on failure.
+ */
+int security_setselfattr(unsigned int __user attr, struct lsm_ctx __user *ctx,
+			 size_t __user size, u32 __user flags)
+{
+	struct security_hook_list *hp;
+	struct lsm_ctx lctx;
+
+	if (flags != 0)
+		return -EINVAL;
+	if (size < sizeof(*ctx))
+		return -EINVAL;
+	if (copy_from_user(&lctx, ctx, sizeof(*ctx)))
+		return -EFAULT;
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

