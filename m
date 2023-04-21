Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F7896EB115
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 19:48:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233204AbjDURsi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 13:48:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233252AbjDURsg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 13:48:36 -0400
Received: from sonic317-38.consmr.mail.ne1.yahoo.com (sonic317-38.consmr.mail.ne1.yahoo.com [66.163.184.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A769549C9
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 10:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1682099284; bh=RkRD1JYtRg+oCyUrqsUJWJ2Htp5ud/nlxUPBaRuJolo=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=Eoc19vLvO4MK8spJEkOR5OXYG1noSIAn1OcXQHdl0DVjuxgr1FanOBH4mjZ53OpzF+AJA5C6+YT0XaXb8va6tqZ1GNPJHs7pwbRDkt4dg8KWBpSenhwUkMD+sNq6OMorVW9a6F/DeGnSM7GQ2q42z53liZTNGoFiaIcnTNvgYXyX821c4ErzJM0fwOWwxS3ZFoEpu8h6aCM7P8JX7mf3DcRde6b6vq52GfRmeBMuq/sLhJCQBmV0HjyvLnrpiV0d++FBH8/BlhSBTnRSR49qv0sO5F5Zf3xy9W6f8yLquhrjA0rCX3YhGQ+RWiTbptNftcwJodSDjv3M8jJZ3Xo2xg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1682099284; bh=iXQeyjSX6Z+Qrcxmv5Jr5xE24KmE4SL+R8O4LFJ/3rC=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=Hoiur020a0iuPfeVE7J729ceXCiJXlqBX9vW12dl4Asn92H+I+Po+pMR3bkyacOpZsNHtD/kMMFWddmqb+zd5r4IsrrbRtpsUnanZrs036xzPHCjk+ozeX5o46d5sMUGXgR4o5z9S2nrZ2XQ0IiUB3pqlcHfPZIDEjW5U3m3IxKXZrQHes2BGkTHrq/c8ELhuV0mJzXUpipYndoEcKzwX1RjHyggXSPLrd6v0TUM8SZwS58VT4YnyNSzUYzB3+ff96kE1A5+Dpj8hl3OxPRWx5pn1VK3SSLPgQC/4PjrmownpkD/4kNNDnmDCxcTkKfYvoxRWKka9OjeHpCmuTe3ZQ==
X-YMail-OSG: _qwkgZ0VM1k60zC4hrPdMtgvfEx3WYQhHc.oQ7nyi5esLJrrUTSKhoB4eQoiyh6
 H0gxzv4ZPGjN7WBBvatZcTFMGCqFnIvMOAsABofsqFU.egEgT5d6iU1mHor.LusmJpxbbqrtkNGJ
 6YQL09CI1J7_GHZiVckhV13RCUO3Zz5v8kIsTq9ft1OY824lBm7fERPJAz0JXyWeMhEDUH38HiXt
 sacASKIatWgjnsDPUwD_.B713Xz8GPcrxNZ9wA5_.dXQGhgYXNxV.LAS0qH8aPTxz23kSt8d7EAF
 liELIjd6u06E9u0udN7pPm87caP7NX0ZPFaTKxBJfom9p9V9mrm0sMD7EMoh6vb6JOtniWdYhCUs
 Gxc.PEl7qOIQGUdDqo4HzQsX3POjzhSbiA2.oPHfLl3se9Fo4eoop0pjWLQoCxtH.BeDrewSTjg7
 EMJ..6kztEizIwB9jqYvXVrwzDL9e2jrkIKxuHADXM3ZJ6.VJ0gi6HIuiRB9HyegQRDHyvF0z3xX
 .44YP5QL49sLOzCVpwwD7nyT6NTzY3yLL_A2C5c4A6KIu3EWHkijJsHc0jj9ZV9r24nB2UjZ6QkA
 j3oIbk6dubDFz7vVpEgEaZ_lnBGPYHUyKy3K9JCEGLjpVo9eZMe7SQQxustdEau2Oj6BoBbnsQ4V
 jFgPptIGY34tKWnvLtIvZ8lBxm2i_W5elOwdg7YA8fEuMIvlwTf.noMQHkYOsMA2ilU6sLH7lV3X
 SRUwPjnhE7qo0veZ9eMGmvm3J8wIjtPTHfCpiH_KsY75XIuEXO8kBLOVFAcH952mMp4lyaRXdoxI
 2_oGvESBGGSvtp80qMf5KEWA3a23SGzJwLs96Jzaee54weIF61u7pF_wyOmV9O89BwF2gvox.Cm2
 nheo.B8sNMmBjUGE_KuuZ4TNOvcMYcoH3UEXpJHdlGagRalil1aw5.8sBhXEe47i7w41U0EFdL9U
 4Y0ZJ87rjOgv6gIR6gk8dyBxic3woFJKxiQsDjDp2q1Fmof0eF95iapR19qSUImFaplZr9xBKVr8
 nBB27Ma2hjb.rOax6oIsG6KGg_7ojzq06wPBJoO_T.I4OGo63DeSmWcwZezmObF2BpRLqArZXIRX
 N8nS5y3IqHxglO8nDLhmB5VK2ky0tr8sGEjSKSlUs8WJVHoT4ZvnNbCm.oPK_GLasUNUGoSVC2Yr
 SVtOH7CvYvihGosIrrHXROC9kS4ALiqbaX1h6JFECuMzynGd9MyVt.XAlKdOpPbWCt30qvIR7IUC
 YNRVO3aybVAm0epNoHKRVZwA89KvQYmM4NdyjZINbAO.IZMO9swoI8q_1.p5q6IDifZcQwMjP1Tm
 75EBjiumQO2NO70sz1GtKYw3HIqHvUCWh_JK_11Rg0mmg3uDaWi8Ylj7JAskibPf4ZZLJ5wRiKR3
 pb9X_w.G1bfyOTD_dssBiACZYLPelvvd_oAkPk5XId76ORiWpB_uNW0AxBQ4Dj2l27vmyeIzdIh0
 sGBPjigquIaiO05NIVVz6efi90QnQSElLJBTB69Yb5OlXQWY.ybADFBdlSK6LDMe4vaiJS7rougG
 i6vXfX8DiogQTBo0zj1OablTyHFywvdOzjwfjtffEl5X92ZxmQm7LKXA9VziUK8SQbHyP1om0IFd
 Md6.YMtasUYgnfu9oYsmdbyqX3ODMe7NAjh8lwPcltkRyvDKZHMnYCb.r23VFG.x9CDfr4phvzm4
 gvziYa126ihrui791N1Bo7YvTant.qaKhGAsNdawlvsmoc4rZPHKMPuWuPsp1wJ8zUn0YlOS4_EE
 JCjguG.pttuOmt85GxvWEc1kuKwG47ooyBe_nj8xzF8LTufCqUmRNqntN5GteOgKJcJQ1ULz7QHI
 Sa.bOjU3LEOUJMvvprnBKbFnqM9lY2UrJ1HK_RJrgnsHa8wMbagfF6IEDZY9qFqfUuALhwVgon9C
 GGIT14SRyzLeoEVB_IEt2AKs2E1FcRLjMM.TrDprVky4.CisaXyBDlbIYl2BUHOI6uar2s16JWKX
 1DV4UIwysICczpov9URue_w4uCTU6X2Pk7iHj0iYr8xaErp8nJziRK2H8BlpGNpfGmoZo3AP3ZG0
 dt.YuZ5aHUKgV5Qdsfjthg9fL5xjgK2Vm4lOs9hcuhBrQlXhJdji8GW3M8tf.1Usyv_Lc8whPH.B
 4DFLYQhNNJAhlN42m161AiKm7XcYpFVUnamKaIJ2BHeFO_VLRgadizHSkgAF2TypvGXkTbbFnpkD
 VVCH3K2tFLVRWPikA.bxlTfN2_KxfpZZ8kxkG5zA8RPzD6nsRnefAOsY84AtxDWRsje5nUTej9VT
 lo9OZaKdKvg3TcOuBxry3iMuxBv4Yr8g-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: b883d241-2c65-4fd6-a7fe-229fd28703a2
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Fri, 21 Apr 2023 17:48:04 +0000
Received: by hermes--production-bf1-5f9df5c5c4-qlh82 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 091c2dfb80bceefc0923e7e11c81b629;
          Fri, 21 Apr 2023 17:48:02 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey@schaufler-ca.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     jmorris@namei.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net, selinux@vger.kernel.org
Subject: [PATCH v9 10/11] SELinux: Add selfattr hooks
Date:   Fri, 21 Apr 2023 10:42:58 -0700
Message-Id: <20230421174259.2458-11-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230421174259.2458-1-casey@schaufler-ca.com>
References: <20230421174259.2458-1-casey@schaufler-ca.com>
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
 security/selinux/hooks.c | 153 +++++++++++++++++++++++++++++++--------
 1 file changed, 123 insertions(+), 30 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 9403aee75981..9bc6206fb1ef 100644
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
@@ -6542,6 +6559,80 @@ static int selinux_setprocattr(const char *name, void *value, size_t size)
 	return error;
 }
 
+static int selinux_getselfattr(unsigned int __user attr,
+			       struct lsm_ctx __user *ctx, size_t *size,
+			       u32 __user flags)
+{
+	char *value;
+	size_t total_len;
+	int len;
+	int rc = 1;
+
+	len = selinux_lsm_getattr(attr, current, &value);
+	if (len < 0)
+		return len;
+
+	total_len = ALIGN(len + sizeof(*ctx), 8);
+
+	if (total_len > *size)
+		rc = -E2BIG;
+	else
+		lsm_fill_user_ctx(ctx, value, len, LSM_ID_SELINUX, 0);
+
+	*size = total_len;
+	return rc;
+}
+
+static int selinux_setselfattr(unsigned int __user attr,
+			       struct lsm_ctx __user *ctx, size_t __user size,
+			       u32 __user flags)
+{
+	struct lsm_ctx *lctx;
+	void *context;
+	int rc;
+
+	context = kmalloc(size, GFP_KERNEL);
+	if (context == NULL)
+		return -ENOMEM;
+
+	lctx = (struct lsm_ctx *)context;
+	if (copy_from_user(context, ctx, size))
+		rc = -EFAULT;
+	else if (lctx->ctx_len > size)
+		rc = -EINVAL;
+	else
+		rc = selinux_lsm_setattr(attr, lctx + 1, lctx->ctx_len);
+
+	kfree(context);
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
@@ -7183,6 +7274,8 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
 
 	LSM_HOOK_INIT(d_instantiate, selinux_d_instantiate),
 
+	LSM_HOOK_INIT(getselfattr, selinux_getselfattr),
+	LSM_HOOK_INIT(setselfattr, selinux_setselfattr),
 	LSM_HOOK_INIT(getprocattr, selinux_getprocattr),
 	LSM_HOOK_INIT(setprocattr, selinux_setprocattr),
 
-- 
2.39.2

