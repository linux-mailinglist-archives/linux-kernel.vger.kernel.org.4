Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 100386F1F6F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 22:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346649AbjD1Ucy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 16:32:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346081AbjD1Ucq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 16:32:46 -0400
Received: from sonic310-30.consmr.mail.ne1.yahoo.com (sonic310-30.consmr.mail.ne1.yahoo.com [66.163.186.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 546152717
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 13:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1682713910; bh=R0jF7owPjAofxGFVfe8NSr+6LkFf6NiHHVKy2FUlHAY=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=nGMSbTcqFl5zSsJh4MgZd1fgNeWFpOGPiR4zFGZdb6dWu045pA+xDw6Ypa0hwxIqCmXgjfQPQdmfERG4HN6Sq7/bKAE2jrPg0M5Oesnq+XvYkSLTCMQhnoi9CW+k2uJONrFmWMjUJdtVJbxgfI3o8EUMAttO68ZkpM9JKhYrAF5Qxqx3rh9ejb7X/OF+r9yCmvIVNtquwJXRLu5cuK5ihwDdTGI4p9C3AOkz7NqTd1AJrxJ9MrRarGuYrVyeyBjqO/luNmy+ckez6KPUR7pPQonH8fuvmb+p1YWSrN8wrPsvAq4zzGQRi/3bwp/qoqyYS77eHFFKjaxZtWt8/aE1MQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1682713910; bh=AhK7sysCFIFVAC2X6jmBddfKxX1NutK81rZNdMKD6Fx=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=ipI5UYea1fBGxZdek3aWSC440rJnnDn+rs/ShgiR301twqYtB+Yw0caR2+LR0QmVnXDNH+r9ZMlaHRbKZq+cgf61IIN2w0G2w8aWx2o9I8Pq5U8EEhOIiexVpKbJYb7cNRAYxOELOCy09eipFYkdV0EAH0eXBCWGeMYV2LAcvUG4tAXbxZcTA9xWW4TUlkfwyzP6/33uKJ8y6WRkO290mrK+tmGmfmGSGJQHT0jfFsqJEkQCGr00jPUQrU/Rp3u3OU04NUQDFc3Dp5JmDBnOPe46Q686UYg+W2IQmlGvGmvaWiWZXEDbusWmhcaa1DHdI0hxnx1uc2ahjX+QXLMjrQ==
X-YMail-OSG: BHF2xMUVM1kihIn0qM2v.GZ0khvVUBxK32Q9ecmPsBDgzMIbTO0vk8qQQfJxgkC
 JddKBsjYMmsg0a4FbS6Aw27OjT_JDuXpVgIVvIwbd9OaCqhc9XIVGXrXp6faTHS8F1Dgyw_v3hX8
 uaXdUYOe6aN8TAyTtEQty6x.FK91cEHDM3NITByWD3H8oJqXcnGpvqfr0o0FmZcoz3Zu_F.pCGcr
 Vs4S_BWVKq.ErOeR1xX6xZ9r9HF9Q.nVYlx4I_z.T2OR19RVxtIZH3ckKIhyczE0SU6YC2eSJk4p
 VXpjwm8890qyP3cxwOJORhiMHc_U9X9Cfxk.qImIpMX.4TJeycU4gMPF7CnEZlNVLBUuVhREBYCZ
 WGuQsgdO8UFNGJkH3IZq4PeiamVG7siMi3JBvK76E9Dmhdxjac8rrHsCvMKXUJ2d77p4dVOYMjTb
 94CB1uDss7nh7WsH3LgdnKJZIsUcFyKcSq9sBIRE5bgy0NTf9oJ4.2zV017Olbc_8NpXtvY9NceO
 jxICSol8lrjOenk7ZvWXoG4VH9xtRMPmE.6YIIYlpmgtV.S7MgR7ZC7LgzZNw_CJn7XCZiZGTQxH
 Yay5tKANDiyszRd1mPNfzsZBZPKKF8tugk_LJn1DxL.sTKltQUUflM6glRseEpBuUywTh_cOE4P6
 K0zAuApXjWN2KX21exeHYKJDtt_cn9pkgs5iy6Gy5QNETc829szIlstQkcck2yG5UUbkjaucFJ0R
 pG99KcimM3q8LRGimAhTmWctuU6L1vOYn6aJ7IvZ3c_FAYCGDcY8tvSBKYiWCrpITkvefGLkY5Fp
 fxz5uQ2Er1A2ewynYT3Q4HRoqhiMceG7H90Bu6dEa7s9CF9.RwG.h01K_EUzfY7pdmPO6L2LkZlp
 ADpNWr7ffjMhBOHPtu8FlmO1vAMJbit7GX3lbex6TbHzwI7rHhwCQzYVOYPnxN4uoC_Dkfcbv44b
 58TcrI0F9ufVpRHmqNbpa9mpG_PYSqiCIQvwLH20FJCJ.jAyitKk0oZPhRtCKoTV9H6eup99mOl_
 lAb2pRBCkeWon5lyLwS_RHXgcajAdmo2hQc6yBEcXOOndtM48p7_jbZMO0fDlzCOLbnK4t2SMYd9
 qmdQwt8oF08fdkJym_9He9ZMcOHG2vytD1XAxTurfQrmemwoQrmdxwgX6eUWoSoIgKRwf.JZTKF0
 ca7B00fQeqb3QEourePVgmy2R08CMXBSRMhWLZGvFqnJMRojuOsDx5VMGtNricxtDOz.5IVjr0ak
 vJic.h5PkH5NZs51uOhpz1z88WdRQqhzxDibx8gnoaBlCDmF1Hei6a0ZTawB573H6LPPp57YBi7Q
 zHqyl2raa962L9MCLNTsCHhnrF2rmsKx3YKA0Z2yy9QLV6EFtzzXZ9T_7Lt.IkHs9pmXS0aITLP0
 T.GX2tq3rNSe2QisZKrVnIoN5FyB73ItVVWyBo_X0_CYHM4djw6TyaEjRGgkthpQs5ClK81JlLwL
 WBuNU_nirggYoJeJTbS8drD4sJQkaKZtcdN7t9r2dngKwOX4upuaVznzkKMMsDutr_L0bjKn3u53
 h5FrzSUOZQeE4n2B0OjfUaLQw0LcmPmnG_T5mV11dzHMbrdsiOJlurikycZH4jdhmWSjubL7I7z7
 d536yImHyOPB3FweT_sW_8RAqyQvT7sX0e1faYRKWzBXwGbjc.ZoCBjKGPbfsSGniMRpXynpLYTd
 xAmLCGbKR9JCZD9YwFcFj5G0iv4Nqvn27lCmQgNVm1FKDUmyWrBqrnk559bgNEL2C6FCzV5YBplz
 6_HxX0tPPN0yv4_GwpZw_pb7AkxYX0dv1RwVrmihB241Ssi5gKG9OcspruRGbjM0A_f.0FkMODpJ
 24qXcwnP3YEIdEFSToGp0FWio7YEZrlku2eKxpRdESJlrox2spM0eErmG9Zo6SpGmmzGZB6kOsfQ
 j2UFZtK9IUQ0C65Fq4082kbbSDfLWJLxLxS3WISBGDSf5rOZw9ISBw4Hg2CfP6OAIbqM0TtKT1fP
 VhMg4fHRt8zz1AiThDbh_7CD6r8fAtxUVwg5cnqWIa8sS2a7dcELszZJhDiYGq04MW5rN4SufBgN
 TzJ2cUHv6D_dFa2Ec9X5hmieH.uAhUqsKFiqTh8FBFlZD9NdIokGTB9nxRQXKNBBpa.lHQp3WvLK
 hDr.i9dop.pR4VS88V8ZQHW6BaxvIQmW4djSgaDdn3z1FY61hqRnFQUbIdSzsqJAA7rvazXu3xoM
 ZLJ.9BCZoPFtARgSQCj6vK0FaX1cN4ATR43UhJtbNsLvoGXkfxGZwM_WUOtHnL_R6g0xyGFvDEWg
 wkJQvkdwCBO43F8_PRJzkLuRi6w29yw--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: d8b9a78b-dfc2-4a2e-a9fc-a2d46a0fef96
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ne1.yahoo.com with HTTP; Fri, 28 Apr 2023 20:31:50 +0000
Received: by hermes--production-ne1-7dbd98dd99-nn8pc (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 8cc315084576b185b2e2f1400cc9c961;
          Fri, 28 Apr 2023 20:31:45 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey@schaufler-ca.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     jmorris@namei.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net, selinux@vger.kernel.org
Subject: [PATCH v10 10/11] SELinux: Add selfattr hooks
Date:   Fri, 28 Apr 2023 13:26:50 -0700
Message-Id: <20230428202651.159828-11-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230428202651.159828-1-casey@schaufler-ca.com>
References: <20230428202651.159828-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add hooks for setselfattr and getselfattr. These hooks are not very
different from their setprocattr and getprocattr equivalents, and
much of the code is shared.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Cc: selinux@vger.kernel.org
Cc: Paul Moore <paul@paul-moore.com>
---
 security/selinux/hooks.c | 154 +++++++++++++++++++++++++++++++--------
 1 file changed, 124 insertions(+), 30 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 2ee92d3fb79d..e78b955e04f8 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6348,8 +6348,8 @@ static void selinux_d_instantiate(struct dentry *dentry, struct inode *inode)
 		inode_doinit_with_dentry(inode, dentry);
 }
 
-static int selinux_getprocattr(struct task_struct *p,
-			       const char *name, char **value)
+static int selinux_lsm_getattr(unsigned int attr, struct task_struct *p,
+			       char **value)
 {
 	const struct task_security_struct *__tsec;
 	u32 sid;
@@ -6367,20 +6367,27 @@ static int selinux_getprocattr(struct task_struct *p,
 			goto bad;
 	}
 
-	if (!strcmp(name, "current"))
+	switch (attr) {
+	case LSM_ATTR_CURRENT:
 		sid = __tsec->sid;
-	else if (!strcmp(name, "prev"))
+		break;
+	case LSM_ATTR_PREV:
 		sid = __tsec->osid;
-	else if (!strcmp(name, "exec"))
+		break;
+	case LSM_ATTR_EXEC:
 		sid = __tsec->exec_sid;
-	else if (!strcmp(name, "fscreate"))
+		break;
+	case LSM_ATTR_FSCREATE:
 		sid = __tsec->create_sid;
-	else if (!strcmp(name, "keycreate"))
+		break;
+	case LSM_ATTR_KEYCREATE:
 		sid = __tsec->keycreate_sid;
-	else if (!strcmp(name, "sockcreate"))
+		break;
+	case LSM_ATTR_SOCKCREATE:
 		sid = __tsec->sockcreate_sid;
-	else {
-		error = -EINVAL;
+		break;
+	default:
+		error = -EOPNOTSUPP;
 		goto bad;
 	}
 	rcu_read_unlock();
@@ -6398,7 +6405,7 @@ static int selinux_getprocattr(struct task_struct *p,
 	return error;
 }
 
-static int selinux_setprocattr(const char *name, void *value, size_t size)
+static int selinux_lsm_setattr(u64 attr, void *value, size_t size)
 {
 	struct task_security_struct *tsec;
 	struct cred *new;
@@ -6409,28 +6416,36 @@ static int selinux_setprocattr(const char *name, void *value, size_t size)
 	/*
 	 * Basic control over ability to set these attributes at all.
 	 */
-	if (!strcmp(name, "exec"))
+	switch (attr) {
+	case LSM_ATTR_CURRENT:
+		error = avc_has_perm(&selinux_state,
+				     mysid, mysid, SECCLASS_PROCESS,
+				     PROCESS__SETCURRENT, NULL);
+		break;
+	case LSM_ATTR_EXEC:
 		error = avc_has_perm(&selinux_state,
 				     mysid, mysid, SECCLASS_PROCESS,
 				     PROCESS__SETEXEC, NULL);
-	else if (!strcmp(name, "fscreate"))
+		break;
+	case LSM_ATTR_FSCREATE:
 		error = avc_has_perm(&selinux_state,
 				     mysid, mysid, SECCLASS_PROCESS,
 				     PROCESS__SETFSCREATE, NULL);
-	else if (!strcmp(name, "keycreate"))
+		break;
+	case LSM_ATTR_KEYCREATE:
 		error = avc_has_perm(&selinux_state,
 				     mysid, mysid, SECCLASS_PROCESS,
 				     PROCESS__SETKEYCREATE, NULL);
-	else if (!strcmp(name, "sockcreate"))
+		break;
+	case LSM_ATTR_SOCKCREATE:
 		error = avc_has_perm(&selinux_state,
 				     mysid, mysid, SECCLASS_PROCESS,
 				     PROCESS__SETSOCKCREATE, NULL);
-	else if (!strcmp(name, "current"))
-		error = avc_has_perm(&selinux_state,
-				     mysid, mysid, SECCLASS_PROCESS,
-				     PROCESS__SETCURRENT, NULL);
-	else
-		error = -EINVAL;
+		break;
+	default:
+		error = -EOPNOTSUPP;
+		break;
+	}
 	if (error)
 		return error;
 
@@ -6442,13 +6457,14 @@ static int selinux_setprocattr(const char *name, void *value, size_t size)
 		}
 		error = security_context_to_sid(&selinux_state, value, size,
 						&sid, GFP_KERNEL);
-		if (error == -EINVAL && !strcmp(name, "fscreate")) {
+		if (error == -EINVAL && attr == LSM_ATTR_FSCREATE) {
 			if (!has_cap_mac_admin(true)) {
 				struct audit_buffer *ab;
 				size_t audit_size;
 
-				/* We strip a nul only if it is at the end, otherwise the
-				 * context contains a nul and we should audit that */
+				/* We strip a nul only if it is at the end,
+				 * otherwise the context contains a nul and
+				 * we should audit that */
 				if (str[size - 1] == '\0')
 					audit_size = size - 1;
 				else
@@ -6459,7 +6475,8 @@ static int selinux_setprocattr(const char *name, void *value, size_t size)
 				if (!ab)
 					return error;
 				audit_log_format(ab, "op=fscreate invalid_context=");
-				audit_log_n_untrustedstring(ab, value, audit_size);
+				audit_log_n_untrustedstring(ab, value,
+							    audit_size);
 				audit_log_end(ab);
 
 				return error;
@@ -6483,11 +6500,11 @@ static int selinux_setprocattr(const char *name, void *value, size_t size)
 	   checks and may_create for the file creation checks. The
 	   operation will then fail if the context is not permitted. */
 	tsec = selinux_cred(new);
-	if (!strcmp(name, "exec")) {
+	if (attr == LSM_ATTR_EXEC) {
 		tsec->exec_sid = sid;
-	} else if (!strcmp(name, "fscreate")) {
+	} else if (attr == LSM_ATTR_FSCREATE) {
 		tsec->create_sid = sid;
-	} else if (!strcmp(name, "keycreate")) {
+	} else if (attr == LSM_ATTR_KEYCREATE) {
 		if (sid) {
 			error = avc_has_perm(&selinux_state, mysid, sid,
 					     SECCLASS_KEY, KEY__CREATE, NULL);
@@ -6495,9 +6512,9 @@ static int selinux_setprocattr(const char *name, void *value, size_t size)
 				goto abort_change;
 		}
 		tsec->keycreate_sid = sid;
-	} else if (!strcmp(name, "sockcreate")) {
+	} else if (attr == LSM_ATTR_SOCKCREATE) {
 		tsec->sockcreate_sid = sid;
-	} else if (!strcmp(name, "current")) {
+	} else if (attr == LSM_ATTR_CURRENT) {
 		error = -EINVAL;
 		if (sid == 0)
 			goto abort_change;
@@ -6542,6 +6559,81 @@ static int selinux_setprocattr(const char *name, void *value, size_t size)
 	return error;
 }
 
+static int selinux_getselfattr(unsigned int attr, struct lsm_ctx __user *ctx,
+			       size_t *size, u32 flags)
+{
+	char *value;
+	size_t total_len;
+	int len;
+	int rc;
+
+	len = selinux_lsm_getattr(attr, current, &value);
+	if (len < 0)
+		return len;
+
+	total_len = ALIGN(struct_size(ctx, ctx, len), 8);
+
+	if (total_len > *size)
+		rc = -E2BIG;
+	else if (ctx)
+		rc = lsm_fill_user_ctx(ctx, value, len, LSM_ID_SELINUX, 0);
+	else
+		rc = 1;
+
+	*size = total_len;
+	if (rc < 0)
+		return rc;
+	return 1;
+}
+
+static int selinux_setselfattr(unsigned int __user attr,
+			       struct lsm_ctx __user *ctx, size_t __user size,
+			       u32 __user flags)
+{
+	struct lsm_ctx *lctx;
+	int rc;
+
+	lctx = kmalloc(size, GFP_KERNEL);
+	if (lctx == NULL)
+		return -ENOMEM;
+
+	if (copy_from_user(lctx, ctx, size))
+		rc = -EFAULT;
+	else if (lctx->ctx_len > size)
+		rc = -EINVAL;
+	else
+		rc = selinux_lsm_setattr(attr, lctx->ctx, lctx->ctx_len);
+
+	kfree(lctx);
+	if (rc > 0)
+		return 0;
+	return rc;
+}
+
+static int selinux_getprocattr(struct task_struct *p,
+			       const char *name, char **value)
+{
+	unsigned int attr = lsm_name_to_attr(name);
+	int rc;
+
+	if (attr) {
+		rc = selinux_lsm_getattr(attr, p, value);
+		if (rc != -EOPNOTSUPP)
+			return rc;
+	}
+
+	return -EINVAL;
+}
+
+static int selinux_setprocattr(const char *name, void *value, size_t size)
+{
+	int attr = lsm_name_to_attr(name);
+
+	if (attr)
+		return selinux_lsm_setattr(attr, value, size);
+	return -EINVAL;
+}
+
 static int selinux_ismaclabel(const char *name)
 {
 	return (strcmp(name, XATTR_SELINUX_SUFFIX) == 0);
@@ -7183,6 +7275,8 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
 
 	LSM_HOOK_INIT(d_instantiate, selinux_d_instantiate),
 
+	LSM_HOOK_INIT(getselfattr, selinux_getselfattr),
+	LSM_HOOK_INIT(setselfattr, selinux_setselfattr),
 	LSM_HOOK_INIT(getprocattr, selinux_getprocattr),
 	LSM_HOOK_INIT(setprocattr, selinux_setprocattr),
 
-- 
2.39.2

