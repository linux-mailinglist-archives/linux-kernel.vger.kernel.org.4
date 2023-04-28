Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8452B6F1F81
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 22:36:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346493AbjD1UgF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 16:36:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230365AbjD1UgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 16:36:03 -0400
Received: from sonic317-38.consmr.mail.ne1.yahoo.com (sonic317-38.consmr.mail.ne1.yahoo.com [66.163.184.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4122BA
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 13:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1682714161; bh=GgOjzkePkJSoFsz+QJcl7OzqBzn70cGDoNq07autlSU=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=Q2bR/Gdg5Vy8ku3I5mFK009WgVw+KY7x2R/cjrt2tuBirtTJCAcakifdvLIzv4zjANZsc52G3/9Jxozkcdi54uDaBZ2Fupnws7/hynffA5X98CJrFzoLCS6u2ggWFBCC2S+HX3zwej0bzxvv5BnPhg4RrndJBNM4iJh91K728IN9qNesMmVIB/PV0gBjTkoVGGy4geWeXatJdKPZq/yoRWamBTtB5pRmKZxRiwRPJSuuJng+96yC7fSey4nCicuBMTtdRsGmUZAuvOwGlXdcBLUT0Ve/5hmdtp5C0GccEFl9ch2c17wxUqyyA/AGRYA2vpGPrfxdz3bbsBiOjdUy+Q==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1682714161; bh=0nLF2t6v0nL/luVom3AJCn3htlGZwbScXkFZkn15Skh=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=VS/x5ExUb+wRIzYWm9jj08ScHJRRZ1MjHYfbxFM5UQFuteyjLmB+lMY9Iyx3PHkZqj75Fswm9tnUG91TFC9wPGq7HFQtHgOfqaUtlZGqLmm2nlR9PLtgh6/bbXwI/73x+TmP1ZzZ68qpxMwRcBzXtFgBlv/O+zEdvC9ypKaRpNRSUsgQhTDz+6fvTCv332sYuC1mRiNUpkSIIjDJ9uYMxctXdE9NTqmSv9bJfPq4JanK2Qd0vqqrjOyjxi94SsWqJ2ZJ1Efep4GXqetO7k7AD02fOYBvsXxVelGwJp7rFI5HKe2u/KBp+qiu96cB7Z9GXsbj77Mmoto8C9zH1di0Ew==
X-YMail-OSG: EYDxFlgVM1kVVUZnhBENJW0T4pTGDwN5jWFR8bL.G70kN2x881dyvQhpmXkveWW
 eH9KSU53tFpNvDvOb3LPa3WhDUR3A.Xi.h7sDMZhhZSnHRB1DUfC9Beb2vjyiPJXAWSXipJIj6iw
 RaKgnJC4AP6a_mh_SH5O2enp6leKD0HHLztc0Jyb0KG1nztJltTSuptrZ479ZvUulQzpTbkr5SOL
 fLKkkW1ImnHJFsPU0D23DcWMhkC1q0Ev4qOLLKJeuycgWWylreaPHHoDJ72KSmQuN721bOtvcdA4
 1nKgG5HsG_k.6d4p2VTSWIB7lq4m6NLTmkzo9Qj2TC1_yeqCQ2Ke9KNcvsuMZPN34dYpSixQoV9k
 Wu2NHak1qjk1nuFF18a45Bcymf58D2YF1hnGE6HGSieC1lir63FeUadSaD6RmznCzsWBYUnb0Zbd
 Sj.8KilIwrM27rBcAdTdVW4hXXX9aFSrrDCF.f_0ALOgi6JCD8ilk3UqwzmKbf9cFpKtPZDs3Sd1
 qVwfNRweiGuVkEuyDkRGRyw4oduTgnWR28vFDC.9GBCEnSEIE0ypLM5IaS5Krg6qcKLYPFcgtLG5
 z276KdoVWFCXl5JruDZB0tDt..a.HOdmIbWrChgpknabePdeq77zZ946.2e7EV175cYsTyU4DzVc
 jziRHCeZEYOJrDn74_GSvRfbfrEMyxG.RTYguAvYwVkHqwWB0DGbLcPsAvYsiXNU1UgpykMoT3qa
 ClHDG6o0L20JPaK1bvsbZJ0mZIPCmgtGcEDwCMDs63kberwLJRLezCLsad9Isvbz1wE3xGwvt9md
 PvBjiwLGBmfhlk7dIi6iA4JBiTUdakbulY4A96LiNHDud6EFodwb5rSegufeytFrat50Oc27nRrJ
 iQIj1iT_dT6aJxbyn2LBU2unDzmduFLbbDnQI8uW.jz39UCkFYa4FnxTIl547gn3aZq_pi6_bT8X
 NHytVECLdWrvVqHq9eB2CjBsfwXs8B5hGtG6A6L478PJG.H.LwVuZAGwCqpOqDpVXEnlZx4b4uM0
 7dRSzBG4eeVpfBqPEObrjzHz9iZDunsQiqmrzpxnUhfxrLHZ5GsOVvg5Uo2nT07YtTs0gxwRad4W
 8ogC6MV1XTYbXYQt75b6IhdRVLc2l97R7dm9jmXy.t0MhOAC0vaSuyKgznQECmgj7a6k.8y3wFmf
 s4FglC2N92OT37FRxXZRFH0lLggNWJQTtSXu_htWa5CHAEITReOW9ZE_ckVcTFIE_ZxXdqRZDTYl
 eaemnidHHo3eTpR_dj5axmgQ9DmQWej7oTUw7U9K46tJielxldMgnLzvFVGJvRzWTcawTVRhHIeO
 zvQM7ZwzdizOdtEGZyXfkhaKN_ra3ZHlAhP8JmcU0TN5Wk4vOwn3Zt38EYDbdSdJlcqDmI25m.PR
 g_4qo0dpN3H.fejEJxSd.8C0XPl9Jpbrfe3bB59PtWJ.xF3igMK9hD6vwF_xUiIpFyY8x.I6werF
 Q4lgO3ukgNUgGrg96oquuI.mIQn_gBlh5yje9XXq7h5fl1lnVMcHkE6Xvh0DrNP1Umkuyi6QAvWG
 kNxhbwewk0M2ISsA2cpUj_bXh7sJgk0fhFqyRUWVd_GotOgN7Y_mJx9SHVzNSolVg9ASd3ZPhPE0
 KRA53QCZkKFNSgUNeCNS8p5VSd3gy54oUTaFleKyeoMUW.Grru.7qMfLpC6MS5AjICgQnlFvRtvA
 VPIxHd2EU0d98EH0OZaxOnv27kdOFDn8.RspZ3RWFgnMvwcLMgL8uilm8rVbgyzFG1d5AwxSZCue
 4goG3oPDwaTBItTWd_K.94JzBQoeRavEOkUsQ2zrqbyPuwtA7IzNIgpA4QamQ2WtJqh7jvYniGD8
 COjsiq98MaIMKjdR0hhCQ8yFzyQ4jwwTlrDfz8xGHBsN0SDHQaSCE_z26eLl2Ynr5bk43TAfkixG
 h72EI3a7Yle4.HFoLPnDuOWJq0ERTiz8gWDuj9KHxXA8FIgIr..38GcIusbVaJEsYp3O9Yc1GS2G
 YPtrlLnrwxVinEAH6YPIpb6K7A.3U6nhqoF8PI5obB_GqBeCqokUXjQ6CfiVSsX2BQZ9L886AwXB
 RMjyq4yBLsCzNYrKeZ6V0Ce4xX6EbWs_Vf44QPkyVfaQkANK.hGtnhOijtfa36ds.XFrQI2Wee4I
 jT7liUSi3qu_XxWaCDuUzQtYNQSWti.1Rf7AH0tOGOrqoLO9BUUFbYdeS70VKPoEV2zLfo96NLT9
 4LhIlu__ob1XAvwLuFu9qRgFxxfui_u_riE.02zuBqvMcRYLW_IcGEnG1ytP156bZ9BpJSAEH5.5
 shISw359SUttJpA2Y0qYI8TD5zDaHRg--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 0e9b0f9f-953e-4d03-ab00-9acc615085a4
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Fri, 28 Apr 2023 20:36:01 +0000
Received: by hermes--production-gq1-546798879c-mpgfb (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID ba26e713cb439f1ca91afc1b8b946229;
          Fri, 28 Apr 2023 20:35:57 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey@schaufler-ca.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     jmorris@namei.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net
Subject: [PATCH v10 04/11] LSM: syscalls for current process attributes
Date:   Fri, 28 Apr 2023 13:34:10 -0700
Message-Id: <20230428203417.159874-5-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230428203417.159874-1-casey@schaufler-ca.com>
References: <20230428203417.159874-1-casey@schaufler-ca.com>
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
Reviewed-by: Kees Cook <keescook@chromium.org>
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
 security/security.c                 | 112 ++++++++++++++++++++++++++++
 10 files changed, 260 insertions(+)
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
index 094b76dc7164..32104ff61999 100644
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
index c1f00d09033e..457ff953e331 100644
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
index 8faed81fc3b4..806bff425af9 100644
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
+int security_getselfattr(unsigned int attr, struct lsm_ctx __user *ctx,
+			 size_t __user *size, u32 flags);
+int security_setselfattr(unsigned int attr, struct lsm_ctx __user *ctx,
+			 size_t size, u32 flags);
 int security_getprocattr(struct task_struct *p, int lsmid, const char *name,
 			 char **value);
 int security_setprocattr(int lsmid, const char *name, void *value, size_t size);
@@ -1343,6 +1348,20 @@ static inline void security_d_instantiate(struct dentry *dentry,
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
index 5a48b1b539e5..94b78bfd06b9 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2176,6 +2176,118 @@ void security_d_instantiate(struct dentry *dentry, struct inode *inode)
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
+	if (attr == 0)
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
 int security_getprocattr(struct task_struct *p, int lsmid, const char *name,
 			 char **value)
 {
-- 
2.39.2

