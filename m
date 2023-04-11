Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3E796DE062
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 18:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230141AbjDKQDK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 12:03:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbjDKQCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 12:02:53 -0400
Received: from sonic307-15.consmr.mail.ne1.yahoo.com (sonic307-15.consmr.mail.ne1.yahoo.com [66.163.190.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72B465B8F
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 09:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1681228967; bh=eVJCxni8t17GQw5ZIij4Oj+s+3OY2bEqnDuxl2+sidc=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=pt1HehdKWtsmzyalhzLfpEYh7OEw90jubYS1SAKcXbLEL+7Bpv8qXlmow8JXfQoBpa8eDyegGUBxG9sVDTHp5AVVnV3In7JPByfcXyTM8ZKOynEJt1laOTbuocmeRmAZ1ev6M8W0sJH0AjIsp/qfsMMRktlgULH9wrVG9g6RmkZd2w6Tm0QvWG3f36fYM4nq0FFem8YN1o8Dc+Ctu9O2p8niVCzOCt7Bpgvk8Dhbs4fv+tjntjpplYdzqTihHt15Ks3w23CeTAs2pSexgH7bMqsbTimL1oKx7k1dxm1kOdjDFmOAq+vpn4jGcKAQQv7n2KTwKLBauIUZSiUY76IJvg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1681228967; bh=ni6MZigs777zJf57zSD3kUps4dyE9EeDqrYym54MiBx=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=Pat711mieyQa49gyxkDR8b/F9FiV+LFgGxiIi3TZfVYrhkIkRz3FiT1upB0wM2VPuHPjlFPAoiKt/F8ol7JSHEaCnBqSQuebWz1CMCIBo26+jLYbYu3dYsRS2DO0qB6NFwDxmOjQ1O5TmNigleVDY2DLNygWL3xsth/UVPbvkRttpZFsOnOEtVOXU0kj9If6n52s8xsCu8aUgBs0jXH4YUmPe3OhEiL0DwT3B7culK9n7BOz3/q1hBSsW+4JJYDuH7/bjnoTVfPO4VTf5qoDhidhiua6XLiuqsgfASkXLeFYr+5AesYe/ZWbvFpdCVkfaHeh+1ljN+pMAQZKF1KTng==
X-YMail-OSG: nLJG26YVM1lpusnXHY6JuS9mk3T2z4DkJbZBvVN5W4.X7Fe7qayZ5IlKC6zfcpp
 gjGj_r_dDFVd3NYlPa2VHcRrxsKf5.DqLxCvzr51jDmwrVQVRAqNTVI_D8UPrtDzRumZ1jItX7Zb
 HK0nDBoQbl2TjeBB9FMkuiZi9ctqQpZXRVzQT.b529Rbx6kvq80QWwFpgqPUwDMRfF2IPNcC8PqC
 ZhpjnzNq4EKz4ZXOto6eKkyVgz726PFCsl8nPzbEtZhvhQo5TBg_NiU4anPnuY1m3b6Heh6c2B6q
 QEO6ZWiKDC0FYJlKio7xPkRTaJzHTkzofGb4dFzhaPBabFuWe7vS7fslGWKuMu7GIndqpDF0fmy5
 UGGPijDGLCDBCC.Icgs9o2B.xkCbgQVGNWr7oDzjgsOnaAOtI3WmVvfLiqiX_U6.nxTgOSr6H0yy
 26B9eUxoK_VHazoBuuoRiQYW9UijXLYUMM1uwtkKkyBxlEflfL_OTXDLmUCrP1pQz5adX8bi0O1w
 UXmIyg3q2sX5kcam1..7TWej4AAYATEKlAEDpVACXliTWG16kOTdFZG9EK1gE3IXFB_UhdxEHwqk
 W1EY_40P90wuQk2D4ndWa98rOwVHk9LFV1l.J3_k9C.vyeHwqRdt8PEpzFDSJRWUJepOJhjkMZpp
 nGvbmDtM6KEvmgsnkfYQ9mWn4gF0RBfFZ6tgIwbuKZavLsceukd_0kiO.0I2Ip2Cz5q.3fVe1Jnh
 qZ8.Ve52cupxswopxjoHfpv_5ZpF.WgN_MKNtLZDMrHWelgHWb4mAJ1OqNN4B9FCx_kaEotuGAEI
 Mvn7XQU6KR88u9LyNjCbIn6eK5EuUZLr8T317Gate0UWDnmxLNjgYj2i9K8lf8e0nHB50ZoO4aD6
 WMa2VN0nfEAtD77YFN8m71Rhnmgv1uqx.S0rO383SKHMIuho0xT_LkdoyFBbpBC5vXxTJlhPPc8_
 Q5YNhpD4CwdQg5gC85_8Dy7H_REQW4QdMZMgDl1qOU9EjKrKcB1NTR2ayGLl3qdK2LG25GPH7RlT
 B.ByO0rGWleY_DY1QdEJ_lq4s0Mmj7cEz.uujX_keXpf66PGY6wYYiVSQsQ3ubcPZuuN3bBlIUaB
 9Y7TDCWyQpVX709IPPd7kSodJ5Hro1Z1_HLaJvjtZCIdfdzygpN7MtDJIWQfED1_oJra7HbdBVpP
 kHx9y38ZR8TYrXJ4vFtlAKf8OiIQxN9hITn_iDItCI1VVPHwRjfNmh1trAmdl4FVCcprvR.TNiZj
 3s3GBauNhPH1Q8nvc4uKixXyWnl2KCAP_tgdVgt5J73Qv5jajvr.N9ktjq16fA1UAP7pPTWTCCUQ
 04ph0zfY2k0iVJwDQhGvOS1qyDqNpVrfYmcNxh73Dk5JEqGdKbGq29Kn3QaPq4zpJ7xhtco2tj3.
 DLMgJVevZpiWhaZFkjEWJDkWfRWnRc6gU0rmpCoDvnup.o4Q6TU_p1D8t74fGUS19.PElVv9RGb_
 FsYQjObHu75LA9my.1bFp9mortGFCNiCnFm.RdCSSMGGFXkTKCqunx_YxxwECfa5T3PBwAxQWC5H
 mbISjvn0raNfYmwiCH6v_y9_yvYRK3dgp49zMdPHojBvSLMx4_17BSZBrFSOIkOrJO78CNjmJznx
 bJz5ARt8znsDbfHUUwQSrs66ZdNp1yrzfw7pY7iUOgYFd3PIKzbS.vrDMWCa4h0J1JeU.2eMZAf5
 kJ105CGz6G304rjG4BpmIAm5Cj3vFnxijB6eG5NkIX0rMOYW4pS3wOktKqRbUEN0zW8VZCL5gO3i
 92vE_flR7MBnCDC_UTsR07JUcuOkR4iXSFnrrf42NuIOTRdKApm6L1pyOBiO6_tOCwRHMko7Sw_x
 t5CZYnH3rSm6H2hHLBfzY7QNGbczfOJH14e.pXcE6w_Krx4w7QBqpNcKo31e4UyXQT4Vg_vSAmMS
 AghGnetXvY2GIknt.G2NFecXyPwdgpJHUV9oQyYdE48SlMn9u2W2K1e8RKWOltLlo75be.fSkFVw
 Tm0tiiPol4gvlpTtz_UniK7TbX_oh0gF_7H83RC4qqVuYUyzTN.g2sadR4ZvtRhhNM1LS9t9H2IN
 s58Dxcd5MDaYVfgD4334QMQedOOc_7apOdmgghfnHQnxub6LxlD2J7DE4_38bFF1gL2NTnAoutxm
 4H4zOK0Yhb_GUbdfDtzyQyZ7gdlXRmO6ViphLqdHuCOmo0i8Ndt8eju9a4kL8KjrkouH3x4G8jA2
 OiRtQ6qgJflMOBw1Lj2CVBw6ENN39oaf3bllQGT3HMt53amb.ShKKE7Sn0es4fIn.WhEd_99YdPk
 MpwbHfgeGGei40PP6pnCj
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: a332e174-cf4f-4f4b-a698-63b22f1da40a
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.ne1.yahoo.com with HTTP; Tue, 11 Apr 2023 16:02:47 +0000
Received: by hermes--production-gq1-546798879c-8jjxz (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID db610f21750abb164e44e985bdddbdbc;
          Tue, 11 Apr 2023 16:02:44 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey@schaufler-ca.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     jmorris@namei.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net
Subject: [PATCH v8 07/11] LSM: Helpers for attribute names and filling an lsm_ctx
Date:   Tue, 11 Apr 2023 08:59:17 -0700
Message-Id: <20230411155921.14716-8-casey@schaufler-ca.com>
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

Add lsm_name_to_attr(), which translates a text string to a
LSM_ATTR value if one is available.

Add lsm_fill_user_ctx(), which fills a struct lsm_ctx, including
the trailing attribute value. The .len value is padded to a multiple
of the size of the structure for alignment.

All are used in module specific components of LSM system calls.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/security.h | 13 +++++++++++
 security/lsm_syscalls.c  | 24 ++++++++++++++++++++
 security/security.c      | 48 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 85 insertions(+)

diff --git a/include/linux/security.h b/include/linux/security.h
index f7292890b6a2..c96fb56159e3 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -263,6 +263,7 @@ int unregister_blocking_lsm_notifier(struct notifier_block *nb);
 /* prototypes */
 extern int security_init(void);
 extern int early_security_init(void);
+extern u64 lsm_name_to_attr(const char *name);
 
 /* Security operations */
 int security_binder_set_context_mgr(const struct cred *mgr);
@@ -491,6 +492,8 @@ int security_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen);
 int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen);
 int security_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen);
 int security_locked_down(enum lockdown_reason what);
+int lsm_fill_user_ctx(struct lsm_ctx __user *ctx, void *context,
+		      size_t context_size, u64 id, u64 flags);
 #else /* CONFIG_SECURITY */
 
 static inline int call_blocking_lsm_notifier(enum lsm_event event, void *data)
@@ -508,6 +511,11 @@ static inline  int unregister_blocking_lsm_notifier(struct notifier_block *nb)
 	return 0;
 }
 
+static inline u64 lsm_name_to_attr(const char *name)
+{
+	return 0;
+}
+
 static inline void security_free_mnt_opts(void **mnt_opts)
 {
 }
@@ -1420,6 +1428,11 @@ static inline int security_locked_down(enum lockdown_reason what)
 {
 	return 0;
 }
+static inline int lsm_fill_user_ctx(struct lsm_ctx __user *ctx, void *context,
+				    size_t context_size, u64 id, u64 flags)
+{
+	return 0;
+}
 #endif	/* CONFIG_SECURITY */
 
 #if defined(CONFIG_SECURITY) && defined(CONFIG_WATCH_QUEUE)
diff --git a/security/lsm_syscalls.c b/security/lsm_syscalls.c
index 6efbe244d304..67106f642422 100644
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
+	return 0;
+}
+
 /**
  * sys_lsm_set_self_attr - Set current task's security module attribute
  * @attr: which attribute to set
diff --git a/security/security.c b/security/security.c
index bfe9a1a426b2..453f3ff591ec 100644
--- a/security/security.c
+++ b/security/security.c
@@ -752,6 +752,54 @@ static int lsm_superblock_alloc(struct super_block *sb)
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
+ * The total length is padded to an integral number of lsm_ctx.
+ *
+ * Returns 0 on success, -EFAULT on a copyout error.
+ */
+int lsm_fill_user_ctx(struct lsm_ctx __user *ctx, void *context,
+		      size_t context_size, u64 id, u64 flags)
+{
+	struct lsm_ctx *lctx;
+	size_t locallen;
+	u8 *composite;
+	int rc = 0;
+
+	locallen = sizeof(*ctx);
+	if (context_size)
+		locallen += sizeof(*ctx) * ((context_size / sizeof(*ctx)) + 1);
+
+	composite = kzalloc(locallen, GFP_KERNEL);
+	if (composite == NULL)
+		return -ENOMEM;
+
+	lctx = (struct lsm_ctx *)composite;
+	lctx->id = id;
+	lctx->flags = flags;
+	lctx->ctx_len = context_size;
+	lctx->len = locallen;
+
+	memcpy(composite + sizeof(*lctx), context, context_size);
+
+	if (copy_to_user(ctx, composite, locallen))
+		rc = -EFAULT;
+
+	kfree(composite);
+
+	return rc;
+}
+
 /*
  * The default value of the LSM hook is defined in linux/lsm_hook_defs.h and
  * can be accessed with:
-- 
2.39.2

