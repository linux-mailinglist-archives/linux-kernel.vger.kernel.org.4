Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 127017336D6
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 18:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346041AbjFPQ4e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 12:56:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345913AbjFPQ4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 12:56:06 -0400
Received: from sonic313-14.consmr.mail.ne1.yahoo.com (sonic313-14.consmr.mail.ne1.yahoo.com [66.163.185.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF1D749F6
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 09:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1686934459; bh=hkkICAMFOno7zoAkCOb8c92hBVZqHMjIHuFkSovWfEs=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=AD8JUZakTlHp0laJVuze9Ur5+xKR8xJm6iowsiHPoODOZO9ULuUYzhAUWc4Q0lPZ7VktMdTGUS2FiSUroUYv4/mY9J/H8NMrUlumA0aZjDjcwVadDma/F0hsKTpDulTwtPylYM8sXFwzXd6e8IExqjcoFm4TeDSmAAf1wX4JNrIJsc1SrEhYmKH93vb31ZHR1R34N0kon0f/W+09NCsTwqkmTX6jV89ruuACISwguED/S+PxOipAH4f2s1Qj1T6RO8jnjKToTgcmRSwq9Jzp+7OL5HDDF0kJsZJ83a0iuZV3kXeDpsfPhD6rpDXeGAHEuzAc+BAl05gT+/YC8LFzww==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1686934459; bh=J3JgBdXEw2MVf5zcfstPG+gAsFEEyV6mUjQMBrbNJwL=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=NtiCARAFSa3S2Md3+mz8+6+5xE3imvaBiOx7BzOfGWJNJ5Du2DrMbprO+NJKaAWNdkcAbSIMEyY3ND+85xwiisyGFn4o5aXI+ZLouBKT62XVPRvHEM/bXblaITjdx7cqiWdb6pS9GqX8KMjWLy/exDKUIyb1Pj5WPNW4QNZ37bjXqfgqRNXplFAmYzm0xCbkzkVo3sXy0CihLQ3w0+YSEE8r7Y+6mM1b4gxCCtgLrYy+g+WHa/7aU1EIFFTnU/L5G9k6MtSKAZ7TcbmQuFq8dfHmVZc7+64DIWFFuZ5X0M1ELRZZh0ijaW4mZKa+XmAYqvmy4sQMMoXElLeN81irHA==
X-YMail-OSG: x_wBpOoVM1mebXjvuSUbgGv52H1lXeDB0Ox8ZvrpMWPMWHLxKsK2CjcGiya07YH
 cRA9v1NViw.Y49X63wUUr5rLmLS4ql_bGNsw70YMgveyqH8IWjDNr6OLE3IGtXguVzYwCmPrLnCS
 ngH5IbfJ5ZcBBydfe5j59Ncv_.rDAST_wew6RRmFFegUGkEaJHTpc_afruKCn57t42Vwz_nnByg.
 mb_HnFMM7DWfFh._nhVLYChdmsfyL8wraxmOJAazZh7unk7kDLmPCh0_RI9DgdD.fBdLATji_5ka
 8ka2WjBol5xbD.iT58SYiNsCy0JM3FoZzXkkbXfzH2NUyrkVfB1GNBfFb5I0MFkaW4yhYSbI_ZDH
 PjzgqrKrA4AzvHU3AR6ehaCjlxfUvb9A80gXUbyGQwC443yb.AZhCa9J7L2x5gSz3vdYDr_eYmsi
 w93XqnDfHhoylHJ_jGomiKquOBoGXg2YaZcmwyXNmtqb1h1lbSNUBrQr4YzVR_E8_sxEYl6l0icl
 wDNInR2SA4SUvoKuwQSKcz9GeFfiDAoNdCZVo8N__y6ZMK.VQVqnKzCOvqa7ip20z58PlSGx6nxR
 02.NEKWodTRlnoJMXKjYt1rmnUUPSdHcQ20PUWxhCQoqT8D5JuKZRBviZsLnfS10T755BHeRTTRI
 qGLfUCKsS5NjtQ5FtX_tBLUGRkhz0yNE784zJnQHmLrdQNzoGkw6OekZPHBj27OGKwIc7jEwBw8P
 bWAL43UAadkVOPhP4NC3hc2nGSYMByxQ8fA3XVfvMeckqp7ZQlPQsOS9DXup0ucmc5JztF8Xpqkz
 Ir.FetICdcosTtr8XG4DnjLGvDycOFZUwGVvZ_0G2xtNUnVKh7C6NJSktHWBWteGkx92t_TD5lz2
 V5PN0Bn8UFX8lCfX6SO_EUaeZjR4ruRvogMT6TNz7ddz7yEx.rq65cKhymOtCcMydC5y1yIRAy5V
 KcbRTLidxlKahnBtynMLfX6uDBjoxPcIDD43LwQA9SJHnbCNmKVABlA1v.F24GSoNcgEvVwDjXqF
 CbjOxLMkdvf7Gf7EN4H5AuYp2zQIIDp0jlnNj2cvTC93ohBx4OXNI0j_AtrgHDOv2PWDRPIt7Zwi
 wUwHqryqQWqx8hd_XPRXUWiEe203qhwhvYefGch.8uL93bVzjTmYdNwCdd64RJGmOvPHprPjZHGf
 r2jTOrS9RryWfhJVg0qbaP5ZthyfFK6J4dzOFgN5nVKDuHyNfGhKBmWtMaEkDhLpT9JXZKcgTuGe
 U627a7JULXsuXBVD1l9Btjk715Die4Cv6YnjV4vkQ0.xt4IsuDFd.ipq11qskDAUoUc1.RXutWh2
 DzrupQioxVWrcGWH2m4.2WfoYTos6XeUJm9M3AxEzmo5.OoAlRCjtj0Fn5L_5fmQIixh6.W0V5Um
 rMJs0Je9LUxYCODajVenJJsK2A0gW..eTkYIceFAHnHn8p9ZIAsMg2yzhZkMuWOI.5tuu9XIdbR5
 2u5kp5eEDrhKeqa_iMjnOFaYIc_8iA_IfjQYgoDZjMdm.4Un9zv88Wf.kbGqC186Pr_qaNBmAUqH
 8MyspH3NeYuFQT_eNVVlWOXkQBrsdzsSajiF664lvWIoMjbEPXgaGm7rWK2TpYO72lpnvRv_OewD
 YiX6j9_TyLbECEux2ej6aPDQrXweY7B8HpuX_S_xVEAyIKd9R.B_nAazCVmBbLa0KD.369BIH2hd
 GEA8Tp8leU0aFnaYCE6nI6Ri9lrg6N_vpkkYGix3a7PIx_5PJds.IdqkwJJIVQoqq7PZcBaIzXeL
 fWqblTm7P.lbZLwHnFPiTdzqpizbtTd7JMQx0kquxU84HRwd2i4SbJvwOkMr9AsINgnBJNCQQpgp
 xNfUEbRN3NJecMmSJbTmlV5pt8SS08wTd5if34wnxB2vb6c1Us25Pcu4lLBzKvVGqxf3c3Ey9FHT
 FoKxP4uAuhJY1XWtCZWOZzVKL.CTrIlDPJ_1IYI7LFDXOSYHhAhmxb_K4XqrgXu7k.kdCS9sOosz
 qXDnlBIsSXLNL.P.TCRbmSYSwm6ep.BNwjpjZjDfAdhT3PUDp0yZCSLB1qjnHW3uDdeoGCsZoVn4
 pH0g.KtQcXBq.fXc9kjnE1K9bkxTgzLZmegjwPnXW7rplItUDZE51kZLEkPt33O.w_WTJx_wF2Wv
 tx1yqT5rrT3XPHr02Hfmho2hJibi1BhrR1DCq3xGvVHYkMoKllUI2NN0lCWy9IDJXVCcFORr5n4E
 cAlAMqijw8scPVIRR8MnXHAyR77fmz7c_alRAF969RD0_Q44pMN27wRJgwyoi7CSXa43DrSVMEpr
 eru0cdP2WQAv7X_MSAv8Y
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: d358cff8-b066-4f37-be52-f5d74aed472e
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Fri, 16 Jun 2023 16:54:19 +0000
Received: by hermes--production-bf1-54475bbfff-xmg9w (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 5d8e982db405aaa142ed4c0fa62627c5;
          Fri, 16 Jun 2023 16:54:15 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey@schaufler-ca.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net
Subject: [PATCH v11 07/11] LSM: Helpers for attribute names and filling lsm_ctx
Date:   Fri, 16 Jun 2023 09:50:51 -0700
Message-Id: <20230616165055.4705-8-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230616165055.4705-1-casey@schaufler-ca.com>
References: <20230616165055.4705-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add lsm_name_to_attr(), which translates a text string to a
LSM_ATTR value if one is available.

Add lsm_fill_user_ctx(), which fills a struct lsm_ctx, including
the trailing attribute value.

All are used in module specific components of LSM system calls.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Reviewed-by: Serge Hallyn <serge@hallyn.com>
---
 include/linux/security.h | 14 +++++++++++++
 security/lsm_syscalls.c  | 24 ++++++++++++++++++++++
 security/security.c      | 44 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 82 insertions(+)

diff --git a/include/linux/security.h b/include/linux/security.h
index 475d0abfebda..75ac91223c2d 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -32,6 +32,7 @@
 #include <linux/string.h>
 #include <linux/mm.h>
 #include <linux/sockptr.h>
+#include <uapi/linux/lsm.h>
 
 struct linux_binprm;
 struct cred;
@@ -263,6 +264,7 @@ int unregister_blocking_lsm_notifier(struct notifier_block *nb);
 /* prototypes */
 extern int security_init(void);
 extern int early_security_init(void);
+extern u64 lsm_name_to_attr(const char *name);
 
 /* Security operations */
 int security_binder_set_context_mgr(const struct cred *mgr);
@@ -488,6 +490,8 @@ int security_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen);
 int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen);
 int security_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen);
 int security_locked_down(enum lockdown_reason what);
+int lsm_fill_user_ctx(struct lsm_ctx __user *ctx, void *context,
+		      size_t context_size, u64 id, u64 flags);
 #else /* CONFIG_SECURITY */
 
 static inline int call_blocking_lsm_notifier(enum lsm_event event, void *data)
@@ -505,6 +509,11 @@ static inline  int unregister_blocking_lsm_notifier(struct notifier_block *nb)
 	return 0;
 }
 
+static inline u64 lsm_name_to_attr(const char *name)
+{
+	return LSM_ATTR_UNDEF;
+}
+
 static inline void security_free_mnt_opts(void **mnt_opts)
 {
 }
@@ -1408,6 +1417,11 @@ static inline int security_locked_down(enum lockdown_reason what)
 {
 	return 0;
 }
+static inline int lsm_fill_user_ctx(struct lsm_ctx __user *ctx, void *context,
+				    size_t context_size, u64 id, u64 flags)
+{
+	return -EOPNOTSUPP;
+}
 #endif	/* CONFIG_SECURITY */
 
 #if defined(CONFIG_SECURITY) && defined(CONFIG_WATCH_QUEUE)
diff --git a/security/lsm_syscalls.c b/security/lsm_syscalls.c
index f03f2d17ab49..bc22f05e2d8c 100644
--- a/security/lsm_syscalls.c
+++ b/security/lsm_syscalls.c
@@ -17,6 +17,30 @@
 #include <linux/lsm_hooks.h>
 #include <uapi/linux/lsm.h>
 
+/**
+ * lsm_name_to_attr - map an LSM attribute name to its ID
+ * @name: name of the attribute
+ *
+ * Returns the LSM attribute value associated with @name, or 0 if
+ * there is no mapping.
+ */
+u64 lsm_name_to_attr(const char *name)
+{
+	if (!strcmp(name, "current"))
+		return LSM_ATTR_CURRENT;
+	if (!strcmp(name, "exec"))
+		return LSM_ATTR_EXEC;
+	if (!strcmp(name, "fscreate"))
+		return LSM_ATTR_FSCREATE;
+	if (!strcmp(name, "keycreate"))
+		return LSM_ATTR_KEYCREATE;
+	if (!strcmp(name, "prev"))
+		return LSM_ATTR_PREV;
+	if (!strcmp(name, "sockcreate"))
+		return LSM_ATTR_SOCKCREATE;
+	return LSM_ATTR_UNDEF;
+}
+
 /**
  * sys_lsm_set_self_attr - Set current task's security module attribute
  * @attr: which attribute to set
diff --git a/security/security.c b/security/security.c
index ca196b585996..3d8c3c3a6d92 100644
--- a/security/security.c
+++ b/security/security.c
@@ -769,6 +769,50 @@ static int lsm_superblock_alloc(struct super_block *sb)
 	return 0;
 }
 
+/**
+ * lsm_fill_user_ctx - Fill a user space lsm_ctx structure
+ * @ctx: an LSM context to be filled
+ * @context: the new context value
+ * @context_size: the size of the new context value
+ * @id: LSM id
+ * @flags: LSM defined flags
+ *
+ * Fill all of the fields in a user space lsm_ctx structure.
+ * Caller is assumed to have verified that @ctx has enough space
+ * for @context.
+ *
+ * The total length is padded to a multiple of 64 bits to
+ * accomodate possible alignment issues.
+ *
+ * Returns 0 on success, -EFAULT on a copyout error, -ENOMEM
+ * if memory can't be allocated.
+ */
+int lsm_fill_user_ctx(struct lsm_ctx __user *ctx, void *context,
+		      size_t context_size, u64 id, u64 flags)
+{
+	struct lsm_ctx *lctx;
+	size_t locallen = struct_size(lctx, ctx, context_size);
+	int rc = 0;
+
+	lctx = kzalloc(locallen, GFP_KERNEL);
+	if (lctx == NULL)
+		return -ENOMEM;
+
+	lctx->id = id;
+	lctx->flags = flags;
+	lctx->ctx_len = context_size;
+	lctx->len = locallen;
+
+	memcpy(lctx->ctx, context, context_size);
+
+	if (copy_to_user(ctx, lctx, locallen))
+		rc = -EFAULT;
+
+	kfree(lctx);
+
+	return rc;
+}
+
 /*
  * The default value of the LSM hook is defined in linux/lsm_hook_defs.h and
  * can be accessed with:
-- 
2.40.1

