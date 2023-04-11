Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF0146DE048
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 18:01:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230428AbjDKQBj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 12:01:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230199AbjDKQBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 12:01:19 -0400
Received: from sonic317-38.consmr.mail.ne1.yahoo.com (sonic317-38.consmr.mail.ne1.yahoo.com [66.163.184.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62B0759F3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 09:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1681228870; bh=Jl6rq02bdphKTQdFm7Ar/p8AmQJ98WaQ5YycmxGnzYo=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=hnmPLbctBquKwe/uSbPP8RPCBMeviEgyXZc7daTpu7B3s4UZi/UYynmubbMTL/Lam7f1UQWUgAJQg+PdTp6RuItAkHwLkraH/CP/Jzzgz1n1LLRU05rDix/u3C23Gqyk36ci0HjIV0YPIbFw4XZwoHDgGjdhNQem0OH2CiXzS3+VrBKDdXIc/XAj7D77kZBd7L1u1JtoDiKgVTBmWSmkXciwGD5sy8Xz3cxypWv+N72Y0eTCXzWJ4Kaw7gKofGvN/2lfsYKyNVePN0s+4GLodTXb3lOo/iZLdhuDDxGZXf9hPF9HzB6H9/42TodZ+j6rmpAz86raQzI2HGDpmMYg/g==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1681228870; bh=06352eLYNGkTB/9jIMqSccyGtUgOKJzASWRziGvKa24=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=kU24K4XKHxHS6LyQbyvK4F8u09E8FeSZneRrHDMWlVH7KGmUWnkhCcJD2bkZ8AKlmcr+5IaGAVH9BTQwFmwCN3Wc3BO1dxCEfOfaBwN7pdQd3St7nRry8cHJE8KnHVbX5D5sUwIgosUpIXLq6RP5MA9AtaiHDwtZG40oH4ikNvT0i19cqmbcbtJKvHyOf79xLuDf7BTqQHnRSuG37WHiQbHDgUqzYidBNF8Cs6UZKFes0nCZj0UHvQJ3LmO7n3yobWBVaqHinlJ+/Th2Lay8mH1JktBfjGFDo6bywjPiNppAu04S7WHeIEFlBxrVfbeZbcKmXMFOKj3MK87Bjwpj9g==
X-YMail-OSG: rYAsnVEVM1ka9oFWhpe7doBIrXMCrumtBo3TOAdobDZkzFtl.tBdHpiI.iwQ1My
 ma_Rj_CnaANjVr0x_..M7ESbk7pjBl.tDaDFPBQX1dAnUZlyzO6z4EJf12Fb5onSJywfpGsRARjf
 Ur9Ss0adkBVxtT2W_U4lENcH900ELt1TqlsxY6zhogUjn_Vxd57UQsRSv1UsCp7yq9IP8vRUzK6r
 bAAxr2B25g0MDgJpcIPP5EPRNaquthoZHC7Xwi.ihh3O7bhpOzRj1mrHaozm.Ic3uiRGTAhSwmQl
 Y5ehroEiMhes1AOOrca1U5JXO6QcUOpLRAM6qmbtj._613_i8xL87pKkjxtkcl.Pf48fZdm04KP0
 va.MHKK4Bmfwcc1Mb8A9BwfJNJWXeScoJK6_Imyvn0iAwIrkaQlpvxzjlwxv8Zdz91QYqFgemr.W
 WaD51QSFFrVvcDHmXn4LqQNfc64VPhNAsBpQQxbNEZxLdsD.yxOUWjftAUNTDQwv9TsyWeAOOFpM
 U435IyFEmFTW1mJV7XeSJYmykkDqW7PajGZOrYTV2EeFWEZuTGYjEezUKg0rfV_yqh_O_8B9.dWi
 P4tfeoL6koljwP64r4tEJSLlHU7bjYA78WvPWgjtuWA1jR5z26rVSyYljqDsBhNOEXQiDEHprM_D
 raoYU9yDNSDszV1F694sjxLqVn_whgd1XOeEVYHOUsFwAqlX.48aNbGF60bkz_EU0xhdjtry2Xxa
 JPprX7RhS7hzFT2xOcHJnF1uKd4NkkhCk2ecs0O6Gwx.H2nlORhOlEsjc_TYaznY3oeI7K5yW6Xz
 W4KnSDpfJ3G4NJxhRFi9GgPvtieVjWd7AjXKntMIS54hWpUDDo_M7vyv3XlJPZuwkvZu1c7lI7QF
 wQSYb_SMn_YDVRPAKMbHZUH7tal1.qL4.y_148_Bd_2n40SY_NdBDidQhpIYpA9zxUjy92WA6_aT
 rK8v5cOj5yMMnedQaw1Jnohn.bNZUmdtQm4v7nraLf7VUKT0tgkKkMqCzo3G2X8b_Pc2VyWydFSc
 3A9DUYYRPQn3hv17cQA4sOBFL6upYQ..XXznw84LHt.NM2em_rT0KHru14XwZkKBI2Muvjqfih.N
 kJ.CmSQbhz47NLluWTJs_8dwnt1ddCPrNqjeAYtSE70L7fH1LwOGbbMAxfmnsr4CXbaMiLRS.lHm
 odIEN4U.ihuRBPjt2wrjcDp1D_HkO3JBMvkPcjqhLbAH7_vEbFQKWk1P3p5Ni7TPy_GqpSAUEBfM
 9V9ruEgTN0SIJkA5ibSN3IfgVAq_RG65GfOgLUp5ZIhuEiXXEUst8HgHdshZka0KKZ2.LaCF17Qo
 BR_rEz40DN7_xCDAgrkgCF5ScoYvUgsTAWmvR0ECzTZtDPKRUlbXpUqIxQ49E5GWzElX6y1kTJ5k
 ytLq..XOh17JKqdhY8pT3Ut9n3uZK0eqEHyDqMH8sfs9WUnURXHs6tjRrKiMqvV6N_wbpfmF4ux9
 4vSZaAsV1lMQaXXaD.sA0DIWHlV.lM.AiOjRU1GE0YAGp67cuX3JynBZM93p6NfXy_JS4P_qGJIf
 WkE8OIZ_fWrACCkcOcRbb4uHdegAccLFrmtRaJwqiFZBqRAQ_Sd5LrimDP2b1s4q9OJnSOBwmJf_
 OfRGXY742Sbi4rLkvzmiK4oHf31_EgGVxv9xuMGJzktAsI3k37nT2L38gOooVz2945ioAh5RVp8I
 MKKZ00WFmOQQjeK4wzuiW5XQwRlOgs8AGB9JDmuaS8HU4PmhzNt9I.imbRHTQAhPalfHCoSmQmdv
 TCjdmzO_Im16vUIMx13Ue880_x13wEPTsN5bCPZCaMULisFznRPj7PXUNxDfK_h6RDsyY9LV58KK
 5E9mhI1yqvnvJVNIGJrAWE70l3jJhw6B4XUBG7lhkIfw8Bp0zmcd_LUQdcV5yzTHjFBD4Hy_v2D6
 n9yfbv5dba0BO3nk5lqrEQHE.obaaykgiyhsNhgfaJuUWBt7YBcARDkKAC7y38O4F5.kHOjtwgwH
 zm3C0paTB8LPj5On9m68LM.fnK68UoJ4pUStyueO5qDiWf3VxmXldiX9Z2oCDpb_PBTUtfsuO06g
 GOQweNCXlYAvf4MA37_cKDkgnMppx0vvtD8bApOEFYCXC8sEOYKbdhwv7vf3K14ixQRx2pLfkg0O
 UVFTbmkxlu6giXCusIPzi4Gx4vze4yeGrWUPTcU.E.eAqcsQ5CVgnv3eMMmy7sIdxfhetLHUtrMc
 2BcAm8fZCRHZdBRO2FqxKWfDUe_B7CFwZD_sOeG4By2mlrxDxL6gEN0XZoKWoHVtjwa0UdwayUvl
 AD84YiWRDPUmTnnswzH_u
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: fc2cdb44-b8ab-4ef3-b9ef-4e92dfa26b3f
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Tue, 11 Apr 2023 16:01:10 +0000
Received: by hermes--production-gq1-546798879c-7rgpc (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 8b8bac55a2979a45d5da198554da66f8;
          Tue, 11 Apr 2023 16:01:06 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey@schaufler-ca.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     jmorris@namei.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net
Subject: [PATCH v8 04/11] LSM: syscalls for current process attributes
Date:   Tue, 11 Apr 2023 08:59:14 -0700
Message-Id: <20230411155921.14716-5-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230411155921.14716-1-casey@schaufler-ca.com>
References: <20230411155921.14716-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
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
 include/uapi/linux/lsm.h            | 30 +++++++++
 kernel/sys_ni.c                     |  4 ++
 security/Makefile                   |  1 +
 security/lsm_syscalls.c             | 55 ++++++++++++++++
 security/security.c                 | 98 +++++++++++++++++++++++++++++
 10 files changed, 240 insertions(+)
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
index 33a0ee3bcb2e..97487d66dca9 100644
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
+				      __u32 flags);
 
 /*
  * Architecture-specific system calls
diff --git a/include/uapi/linux/lsm.h b/include/uapi/linux/lsm.h
index f27c9a9cc376..b10dfab8a4d9 100644
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
+	__u64	id;
+	__u64	flags;
+	__u64	len;
+	__u64	ctx_len;
+	__u8	ctx[];
+};
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
index 38ca0e646cac..bfe9a1a426b2 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2167,6 +2167,104 @@ void security_d_instantiate(struct dentry *dentry, struct inode *inode)
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
+	if (flags)
+		return -EINVAL;
+	if (size == NULL)
+		return -EINVAL;
+	if (get_user(left, size))
+		return -EFAULT;
+
+	hlist_for_each_entry(hp, &security_hook_heads.getselfattr, list) {
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
+			break;
+		}
+		if (rc < 0)
+			return rc;
+
+		left -= entrysize;
+		total += entrysize;
+		count += rc;
+	}
+	if (count == 0)
+		return LSM_RET_DEFAULT(getselfattr);
+	if (put_user(total, size))
+		return -EFAULT;
+	if (toobig)
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

