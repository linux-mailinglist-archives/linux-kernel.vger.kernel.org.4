Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FC8869FCC9
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 21:10:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232133AbjBVUKg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 15:10:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231820AbjBVUKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 15:10:30 -0500
Received: from sonic310-30.consmr.mail.ne1.yahoo.com (sonic310-30.consmr.mail.ne1.yahoo.com [66.163.186.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0CE742BCC
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 12:10:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1677096627; bh=ac2DH240ccP70tJ7aTNlZ4rvLLgiO47GgOWabCeHZ/E=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=YQR/zqeHerEekl3NalfENeRNV+4+u3Y9Kx5aAH4oIUpJsiedSMopPCanDh5vwiYy5oAvwXteDj3Ml4NNHnzRKAb3jTgQ+j9cxdV7PGPqv/qOQA07yHBD3Q/IN++ho/cUp6T3grRa3aUiZ9N7o780n2unFHtY06dinXKRG6Vj69ubfts2KrK7bDrRVilJROhHGpvcONTAhT78n15TK0cgWe5KqtHW1j8x3iVsWtFNNy7k+YM/weWYJkClpb8OFAOUoOGcHbWuPhpPycgKUQ5aaRMsRapM61W+q4o9t0p7HqT5X4lsWuyuuYWibBaF1InPpXXdWCNClfS0eje9ybnVYA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1677096627; bh=sInyFTdkVO659IWKuYXw81DE8LPZDH6qzGqQKVVtyC5=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=mff6revjclh/UE2DdIvO+pUauC+YfGavDAdK1S7SDbOkoLoq3MYvPsbEp6Jiqiw29rlHl6Ieo0cZSyMwfjtehzhgm9ZVaDrEtgjWZhqTnqEFoS6pAzKjtnBKaoRVmUwoaK1XegXZn+YFm+p25yPh3n6JoKI3aMQXR+B6x0QWwpWoOdBgfUfDV1HWqHnbqTGcWrCejiHtECTd38N4go9wKEaOhRfDREZo6Le25/nO+n4cCtnmqI1UBXlBK4HHHtMCOykgw+p+JqA+OpeZRGZEp+gUEiil613aNBTiG+bgn3393eYkM4qAwM2m9RdSkZgvgu6vYzmZbwrxL4xAQ2/9WA==
X-YMail-OSG: 0fhnapoVM1nroGpJ3ONILGNDUI84hYbikw5LbgqyMWu3zCSDdqMnfVZFGidIjig
 54T9tDADywPyjfgHomUxqgPXFu3.cZ.E9DOA8t9ret_eWe8HkMAz0pz2hr3ZbPD8ljwUFh2hTvlK
 kN.cpv6lBHDuBYd7OaTlb90.vfnwvPTqTb8yFFyAg7BU_RfZl3xEjuN7b8HcDflXihP_EAemRc7P
 eIvcytf47szCnggV4r3o.YtmyXQytavFMaUfGiKFQP4dwVPmOUPgi8nES.s_mQ1v8r3xFgqq2Dpt
 ZBPKYwU4D0MIzM7d2girzixdGiYRmplhNl8wnmnDtl_FIgYnAjZ4mSAkAmtSQ46qMrbUBDRBJwId
 X4W.mF.RWZ11_7eJB_ns0B3A9RC6llwqa.V_uqFxtAYOHavCN5Pg6YMArXCFxYC7v7WBuKDdE9dK
 DKTLZ1Kycc3E9r3SEdi7DMncm62.zH6Lz1SAdG5c69tOdQZdIbxXj5byTLYrDJ8TkRpllMSsHfIR
 HFIkK7xCVUBhDwOZZqDU7N98svlwId1fYOVCnLOE_ujo6Jo.C10mR3N2WEokS_r4B87Pxdw1B2g5
 F81p0ZpqJExtTRdsLOq84ySlp2ksTg_m_QUCF_8mGh2rgskNRkWgTrHFj0FJaUZJ5KxWonpRpjmR
 1HRsizE8d0NbKzO3TMDuaxX5jSa80UNfjykTcRmo8x5kg_wKMbnt97lIPOOT0wuIsXsIz3EIfhnD
 yltuXuf0adiUBbrln5pSzkJYX8DVjhUk_9f21lpO1X_mZH4XWp3f0YA_Qo36CZR9.njeUMrINL7I
 hpm7Mn4GfY3WKjJ4rYSNd3sIe_FzYQj1Qggf5V9oVx9RaVHCdcVFFOs5zzSgFlMCOwMV0oRqR7_z
 j0xP2z2cbXKtSPSUQN3IEpHcG5Dd5OatiJ5qAY_AhdDD.TJOsY7SVylVRblo0mTOlk5jjD6TG2b8
 x.KGCr7YYJfrEMhKGYuDfjedZV1pUHoL.zOHj_qPOxSLXaSG4bRTwlpeoshWsgJlfo6lXWUMCT6Q
 QHjWcoovDz8JvJ9OHKCMfQ97bmZboEOQUa7sQHoMcLor02oGZg5p9rkOrFv43rNk8W74sPrwKAr5
 qpDLUIW0z..t2ZAM4Y6mvNspV7xpbPOBD6NdfGR3xEfISNc7rFtbaUOUT4xKXOupLVP8AQMKOEZ0
 Qp1EJyKtkqU1lCZfA1PtWMwEnirZwrmaRWIP65VixlGlMGlRKPquEKg.2RZ6LQIhcRX.gReahzah
 F3Gov9sUJz5iPa05XXWf6HbIR37sjuVA6oBI8OjTkiqV8ut2rVUk4n_EAlL9SFMRC.sf1K.7FxKP
 xZwHIKKGmZ_LgnSfwh9O_c7FcytYt29KoYoUzTSYcGbyZRqB62qG3xPhtqGXNjASdS2b3U4ZHSMV
 yE0k5lCeDsEMQFUZNZgKk_E7wQ36.OFtpDn6oPFmnmplFHxkyBECpXhnyhy0TO_gzcAp447aKblF
 zgmKvfJLDj7YWlruiG0gou.5DIoC_TqmnLO.UNxo0Mmk97vEXfwd4L_Cq5SYHJS8UPXpUhO2TdcS
 nNhqrgWlJWjt0eGwMOMTBi5hIgBGffjq_EJ_FEn06YtgiHmczHU.WBgAhlDQeznpfUrA4gIu4bNJ
 ckT1TA7kK9nZThIB7JR2M5Dvi.Yve_ieSepnvvSL5a_XQimeLiq7042nAhetRQXxQTKmw.6hnPxg
 Uz.m7Di51bxjL5BZfk1oWxjOmCglRejUc8BaytRAOPIDcCz_0vYqEeMzlG1wq_wutnvMXbaChcEI
 EsbgqoKXsc9nuF8w2f4tyj4.OeA9lHLK6wO3YqwP29ZLBQhxpDQDeKDWUL.OLhZuAUcL9KCYyzKr
 HolepMM2_3Rlw_KLCnyXwr3qcw0jp3gM2V_jM9NaOLCYlAsGhw9PB8rALVGgUcgUF6ihmrcF1qrW
 wjGrDSi94_KHpaAAYetaJNPK6wK4wlBto2kYlCoB9jJGzv86ORueTI5eUcEqXKzAxFpSBiCd1b2j
 1hg0eqOeW2wDYC2qbWCY3foCCtb7uXZWcBus5Ly9X426XpH0sOoQ_R_52o9JG.v5vSWHB.FEC8ms
 Bq5VKPwmbHp_95gBGiBJQlDOGTy3Lww7R.9FIzyfbHQAOrJH7FuFgjlSBsRowPsAnNjyC3YWs29D
 iUDWoT5605D14tWrkK_Nwhn30ofUBH0tGYtPUQ0X_pHZNcUhzcdb47R0Fc8Nv6Tm1P9EtDgBB7Bi
 ZYaLVP0Tz3r1bZNycw7Sl7gJMpadF30zaSumxJQ7hAw--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ne1.yahoo.com with HTTP; Wed, 22 Feb 2023 20:10:27 +0000
Received: by hermes--production-ne1-746bc6c6c4-sslbc (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 54abe124e3c28d3626a364ed2359f9f6;
          Wed, 22 Feb 2023 20:10:26 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey@schaufler-ca.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     jmorris@namei.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net
Subject: [PATCH v6 04/11] LSM: syscalls for current process attributes
Date:   Wed, 22 Feb 2023 12:08:31 -0800
Message-Id: <20230222200838.8149-5-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230222200838.8149-1-casey@schaufler-ca.com>
References: <20230222200838.8149-1-casey@schaufler-ca.com>
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
 Documentation/userspace-api/lsm.rst |  15 ++++
 include/linux/lsm_hook_defs.h       |   4 ++
 include/linux/lsm_hooks.h           |   9 +++
 include/linux/security.h            |  19 +++++
 include/linux/syscalls.h            |   4 ++
 include/uapi/linux/lsm.h            |  33 +++++++++
 kernel/sys_ni.c                     |   4 ++
 security/Makefile                   |   1 +
 security/lsm_syscalls.c             | 104 ++++++++++++++++++++++++++++
 security/security.c                 |  82 ++++++++++++++++++++++
 10 files changed, 275 insertions(+)
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
index ed6cb2ac55fa..a834bc2311bf 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -261,6 +261,10 @@ LSM_HOOK(int, 0, sem_semop, struct kern_ipc_perm *perm, struct sembuf *sops,
 LSM_HOOK(int, 0, netlink_send, struct sock *sk, struct sk_buff *skb)
 LSM_HOOK(void, LSM_RET_VOID, d_instantiate, struct dentry *dentry,
 	 struct inode *inode)
+LSM_HOOK(int, -EOPNOTSUPP, getselfattr, u64 __user attr,
+	 struct lsm_ctx __user *ctx, size_t *size)
+LSM_HOOK(int, -EOPNOTSUPP, setselfattr, u64 __user attr,
+	 struct lsm_ctx __user *ctx, size_t size)
 LSM_HOOK(int, -EINVAL, getprocattr, struct task_struct *p, const char *name,
 	 char **value)
 LSM_HOOK(int, -EINVAL, setprocattr, const char *name, void *value, size_t size)
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 98acafc60f47..36cd1692b82b 100644
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
index 2d09e818a7d1..21971a635b6a 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -60,6 +60,7 @@ struct fs_parameter;
 enum fs_value_type;
 struct watch;
 struct watch_notification;
+struct lsm_ctx;
 
 /* Default (no) options for the capable function */
 #define CAP_OPT_NONE 0x0
@@ -475,6 +476,10 @@ int security_sem_semctl(struct kern_ipc_perm *sma, int cmd);
 int security_sem_semop(struct kern_ipc_perm *sma, struct sembuf *sops,
 			unsigned nsops, int alter);
 void security_d_instantiate(struct dentry *dentry, struct inode *inode);
+int security_getselfattr(u64 __user attr, struct lsm_ctx __user *ctx,
+			 size_t __user *size);
+int security_setselfattr(u64 __user attr, struct lsm_ctx __user *ctx,
+			 size_t __user size);
 int security_getprocattr(struct task_struct *p, int lsmid, const char *name,
 			 char **value);
 int security_setprocattr(int lsmid, const char *name, void *value, size_t size);
@@ -1345,6 +1350,20 @@ static inline void security_d_instantiate(struct dentry *dentry,
 					  struct inode *inode)
 { }
 
+static inline int security_getselfattr(u64 __user attr,
+				       struct lsm_ctx __user *ctx,
+				       size_t __user *size);
+{
+	return -EINVAL;
+}
+
+static inline int security_setselfattr(u64 __user attr,
+				       struct lsm_ctx __user *ctx,
+				       size_t __user size);
+{
+	return -EINVAL;
+}
+
 static inline int security_getprocattr(struct task_struct *p, int lsmid,
 				       const char *name, char **value)
 {
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 33a0ee3bcb2e..1ef2a3de8ae0 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -71,6 +71,7 @@ struct clone_args;
 struct open_how;
 struct mount_attr;
 struct landlock_ruleset_attr;
+struct lsm_ctx;
 enum landlock_rule_type;
 
 #include <linux/types.h>
@@ -1058,6 +1059,9 @@ asmlinkage long sys_memfd_secret(unsigned int flags);
 asmlinkage long sys_set_mempolicy_home_node(unsigned long start, unsigned long len,
 					    unsigned long home_node,
 					    unsigned long flags);
+asmlinkage long sys_lsm_get_self_attr(struct lsm_ctx *ctx, size_t *size,
+				      __u64 flags);
+asmlinkage long sys_lsm_set_self_attr(struct lsm_ctx *ctx, __u64 flags);
 
 /*
  * Architecture-specific system calls
diff --git a/include/uapi/linux/lsm.h b/include/uapi/linux/lsm.h
index 523748cae615..7850fed28998 100644
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
index 000000000000..b89c4e7d009e
--- /dev/null
+++ b/security/lsm_syscalls.c
@@ -0,0 +1,104 @@
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
+struct attrs_map {
+	char *name;
+	int attrs;
+};
+
+static const struct attrs_map lsm_attr_names[] = {
+	{
+		.name = "current",
+		.attrs = LSM_ATTR_CURRENT,
+	},
+	{
+		.name = "exec",
+		.attrs = LSM_ATTR_EXEC,
+	},
+	{
+		.name = "fscreate",
+		.attrs = LSM_ATTR_FSCREATE,
+	},
+	{
+		.name = "keycreate",
+		.attrs = LSM_ATTR_KEYCREATE,
+	},
+	{
+		.name = "prev",
+		.attrs = LSM_ATTR_PREV,
+	},
+	{
+		.name = "sockcreate",
+		.attrs = LSM_ATTR_SOCKCREATE,
+	},
+};
+
+/**
+ * lsm_name_to_attr - map an LSM attribute name to its ID
+ * @name: name of the attribute
+ *
+ * Look the given @name up in the table of know attribute names.
+ *
+ * Returns the LSM attribute value associated with @name, or 0 if
+ * there is no mapping.
+ */
+u64 lsm_name_to_attr(const char *name)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(lsm_attr_names); i++)
+		if (!strcmp(name, lsm_attr_names[i].name))
+			return lsm_attr_names[i].attrs;
+	return 0;
+}
+
+/**
+ * sys_lsm_set_self_attr - Set current task's security module attribute
+ * @ctx: the LSM contexts
+ * @size: size of @ctx
+ * @flags: which attribute to set
+ *
+ * Sets the calling task's LSM context. On success this function
+ * returns 0. If the attribute specified cannot be set a negative
+ * value indicating the reason for the error is returned.
+ */
+SYSCALL_DEFINE3(lsm_set_self_attr, struct lsm_ctx __user *, ctx, size_t __user,
+		size, u64, flags)
+{
+	return security_setselfattr(flags, ctx, size);
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
+SYSCALL_DEFINE3(lsm_get_self_attr, struct lsm_ctx __user *, ctx,
+		size_t __user *, size, u64, flags)
+{
+	return security_getselfattr(flags, ctx, size);
+}
diff --git a/security/security.c b/security/security.c
index 3308d7c8a20b..6823a6cb32a9 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2167,6 +2167,88 @@ void security_d_instantiate(struct dentry *dentry, struct inode *inode)
 }
 EXPORT_SYMBOL(security_d_instantiate);
 
+/**
+ * security_getselfattr - Read an LSM attribute of the current process.
+ * @attr: which attribute to return
+ * @ctx: the user-space destination for the information, or NULL
+ * @size: the size of space available to receive the data
+ *
+ * Returns the number of attributes found on success, negative value
+ * on error. @size is reset to the total size of the data.
+ * If @size is insufficient to contain the data -E2BIG is returned.
+ */
+int security_getselfattr(u64 __user attr, struct lsm_ctx __user *ctx,
+			 size_t __user *size)
+{
+	struct security_hook_list *hp;
+	void __user *base = (void *)ctx;
+	size_t total = 0;
+	size_t this;
+	size_t left;
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
+	hlist_for_each_entry(hp, &security_hook_heads.getselfattr, list) {
+		if ((hp->lsmid->attrs & attr) != attr)
+			continue;
+		this = left;
+		if (base)
+			ctx = (struct lsm_ctx __user *)(base + total);
+		rc = hp->hook.getselfattr(attr, ctx, &this);
+		if (rc == -E2BIG)
+			left = 0;
+		else if (rc == 0)
+			left -= this;
+		else
+			return rc;
+		total += this;
+		count++;
+	}
+	if (count == 0)
+		return LSM_RET_DEFAULT(getselfattr);
+	if (put_user(total, size))
+		return -EFAULT;
+	if (rc)
+		return rc;
+	return count;
+}
+
+/**
+ * security_setselfattr - Set an LSM attribute on the current process.
+ * @attr: which attribute to return
+ * @ctx: the user-space source for the information
+ * @size: the size of the data
+ *
+ * Set an LSM attribute for the current process. The LSM, attribute
+ * and new value are included in @ctx.
+ *
+ * Returns 0 on seccess, an LSM specific value on failure.
+ */
+int security_setselfattr(u64 __user attr, struct lsm_ctx __user *ctx,
+			 size_t __user size)
+{
+	struct security_hook_list *hp;
+	struct lsm_ctx lctx;
+
+	if (size < sizeof(*ctx))
+		return -EINVAL;
+	if (copy_from_user(&lctx, ctx, sizeof(*ctx)))
+		return -EFAULT;
+
+	hlist_for_each_entry(hp, &security_hook_heads.setselfattr, list)
+		if ((hp->lsmid->id) == lctx.id)
+			return hp->hook.setselfattr(attr, ctx, size);
+
+	return LSM_RET_DEFAULT(setselfattr);
+}
+
 int security_getprocattr(struct task_struct *p, int lsmid, const char *name,
 			 char **value)
 {
-- 
2.39.0

