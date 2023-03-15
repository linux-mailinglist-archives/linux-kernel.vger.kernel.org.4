Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50FA06BC02D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 23:52:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232734AbjCOWwz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 18:52:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232638AbjCOWwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 18:52:51 -0400
Received: from sonic307-16.consmr.mail.ne1.yahoo.com (sonic307-16.consmr.mail.ne1.yahoo.com [66.163.190.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6785B5B5D2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 15:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1678920724; bh=if+hZ2DN4xtsEpQ7eGOO9abOIZ8e6G3kT7BOtEafrW4=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=JDUCL2ydGoT4nop6+kyL/hf41xPMge8Y84ksxst+iE1XhxAuDI5ma6Lu3G3cFv1UKtvWovhfAerMoPbyHs4B9FFPFF4sl0jJ79s0H5GCu3uzBI2WL7GlrwT0GIvJL/xw22A8GdOPihpoHOt6si39mxZW0+QxPoCMgALpLepaLOGG4mSGX6WYzwPyaM3NtLehenjfzPUR8VA2zN6e6tSVTC1RfYZXjE4/oNosdaq/d4a3QhfM8T83k7XWHAlLgf5Wc2j7p6kGa1r5fFWN2XLySQnpMcICejWpkuUu8hbL863ZZT8V16rBywQ3PyrywQna/xsFXvL3d2ds7svgNiyj8Q==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1678920725; bh=jVEP8q4W5vwO1zMf7ZzeN6CGJWILPyziyt71bfVfhq+=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=ocLjPv+GDU3yt2Go4mBLmZB6o/v69VJ8dSJBKiWnPMAbP7nYv15kXccXTJ3gZMrU5uSd+VEyGLTHSF65gpQnce49xbFbmB9AWUz3N3DRD0JrZ9Br3fxfpLkiK/3CnB0Yp2L5RSGklF+wdXG/2Dfz/duCmOZtENgXXZOdFB4fBKTnudqbtZQDoFzoZvxTJ8yFfLdlgpQgRiKWp6ardk3cpi8Z9VpSe+tXgoIfwiHgEpSohs0iLZK+Yv6aGmGdmtL30Ex9ikawlMk0qkQxlacz7zr7RzWdRUEfva/dCJSU0V+ltX3fpqcwXUZHRBN4WSlmIgY29dUpm1OVEX3UawdoAg==
X-YMail-OSG: Ww5itYoVM1njYCJfDWxNLthinP6bHmqq4Jg4TYHRdiusab_QwW8ShWhTqod0qUp
 P1LmovhADG7PWk0lujbtGm1CfddF1Vab_v1CHwEo6xOrq6tILHA00VjsNxd5bNh1785oa91Z9TET
 z9SgcjJSki.khfoW01GdpKrCq2P7F8kRn9hKts_uRy.qeqHJD8_wAFRBIaLLWo1.trUOEQjHCMrF
 yKbGQq1nR8.kptzAmimTvnWRakchvfE3EyolzQTWbUaLJ.vdtLL.jjRXAS.YM7zJMKG_oYdFeb2i
 NKeFXW6ZWYnIWZeN6ZhG2dJStnH8ovhitRgPaNDOwt.qJeQ1kE_zSlCP.Q.oHX9WG8CIDUY3pb06
 sfIjuawDTIPF0AaFEO.WEzIeB37tAqO0MwrrwcG.jVDECH_Jv497UAFmO6kfuI1ZTTR3GV.aEO31
 tFQ3YS9WwLKQsuFD19VbQ0f8NEsLlRgabRyXdw8ECFt.kz5kkaAmfVTN7yrU8kDloCL0xpcBbHvX
 DFCDz6pA7_cgVcpDLS6dhGEUILNmw84xULfg8aNlNaSa8ZT6FMsaf8Pq4KqDrbnQ6pzSOxsHHOVy
 KN6lpvP3sSimOJC8AMi2YnLsm3oMiLZKKv9EYq5msoSP4S38lxSpqsHFnpXrHa9PKzYlUNK4sR5b
 H.58j22H2N6ykIYLU57qhcXhSU2rrIFvZ3w3wJ6kuNNkBX8Fg6_gT_jJ5ixhJ3HlgHDR_EUWkHC1
 YMarN2.DNH2m0jd.o1iS6caeEwQaiFwPeF9brHNocAT7kuNMiUqe61GvMp1wZbCHIFTdrjRBM9NY
 tA6ngUdfxD5_pSBpV3_rLo3584H0k9wm4hCi_pFWs6PV14StaTv12b6.p9SD3nYDJRW5yWCIP4Jc
 tu_2Z1Y8aPu2uJuaBDR0bQHkOs1CrdYPeid0trQ2t26hU3cBMY0Sm.l52PmNomTCUz2FRYea7fYf
 ylylGgar7eJtqA6uGTKcFvN8fMFd6bGuFvwc5En0BjDU6Xy.MeecIxifmxGDG.qf2Ar3dKkZ7w5q
 xtXjw3ZaBui_qMKuOd7I0m2GIoz3h9Cxg0TActP7wvi.iaDOWWWjURsKfIRXsH3XqrZI8.yGj5z8
 nLhpdssWdrrENTjPkWiroMEX.SkkkTKQtwQHfkoHgpFP5NXQpG7SkcNj51UvycPMb.8sXj7Be48e
 YG4k3.xeGzukR6y2S1FBPS29oKl5wQZQ5G59VwEJiCQd69cBAiCHa9lDBTQcogMF5e8uGgofHbtX
 x6hjvhc9Iy2ikK9g77nrDc8eM106W.AEewdwm7KyP.Sqs_ulXdi_g9KiZkZbO9pJmJqYNoaWT923
 f4PhXYeW17KApkfB1Zlh9DydaqaaruUBjnKoBGHgq1Lc5MZA20F7nFXz1pr.icBWkn7HvD9wgK0P
 JJDLkIAEYK7eli8JOkHCgPpmfJTEuyHYZfcIq517CJ29_GcF8p5N.cQeMS7detv4Gq0r.Wv5tbBC
 b6gH1Jeh4dLO0igr6v45gtV4QvFAfkiJv1s_0w4HPj8jsgS7hb_gcs.QNjW9LbbW7gOLeTxZCeds
 0Hu6SnWtyD9xJfeEdG5YtDuqdPDh4Ut_TBPX3UkXYQBV0RWvGJSBktE9n6ks8J.8Hk9NZm9SzGaN
 8jN12s5U5Ic7mEdD8kr13KYY6x5qBZ6S4E7Oh0l3KC1ONF8Gt4giKSJSL4.9QyWqgjIVwDvaSxn_
 o4rR1nwQEgKIm6OR52JP_3MiK0uqE64wIkYjmn.zboXL960gDBFixUxCBuAEM_RFUf7fuCVOkEGO
 zX6Ii8wULhkU0hX.izLGH79WaDvILBdDomra56bRu9FzObgfWcq_wIXgnMOsy7t4aGBU192hDg0X
 ck9Qzgdz8yeTHz7Nr_zxI_ygsRCG5r3_h.Xdq6n85.bX1zWeJgv93YtSPyF2BVZr.htuhpNz63Za
 1iQx46ewcT9ADeiRj7hEWviCzUDT5.oKSs.5Ro3KU9C7FMgNzMrkO.A8ssQXqSkNLyAWIyy.v1W0
 c0w586Yv3clh49KD0llIbh66yOeVnkgItdv.8IKzunMaL7NmeiLdD931Xw8CTg0OQtyuwcBQ.IID
 ybxSZLrV2VpLTVGbo4EXOJYuo.4gvHToW9cbvFuL7w0b0HnXv2jJArgLQxz80ke8lBxKh5LXPhxx
 X.cbUNbOjrtwAVWTWr_i1Q.5p9R.Tus8Q5N74xlbjrZPX3UUe7QbKntfSiLPa5inRny6n3kW_Mus
 _oAaAxgxF0YXmzkEyH9vUKlUFgT9oOUq2V3YEIzbFOoV6EEMZ5kEaO3VGGXuJSIzTdGidIJFiYUe
 ZOs70fKqTffdYjSbWT3HEOxcnXKwr
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 1a0fd68d-3764-4dd3-932e-1a4ff284b6ab
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.ne1.yahoo.com with HTTP; Wed, 15 Mar 2023 22:52:04 +0000
Received: by hermes--production-ne1-759c9b8c64-2fnfh (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 3519737f64e89c1a78f5fee6524d3fd8;
          Wed, 15 Mar 2023 22:52:00 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey@schaufler-ca.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     jmorris@namei.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net, selinux@vger.kernel.org
Subject: [PATCH v7 10/11] SELinux: Add selfattr hooks
Date:   Wed, 15 Mar 2023 15:47:03 -0700
Message-Id: <20230315224704.2672-11-casey@schaufler-ca.com>
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

Add hooks for setselfattr and getselfattr. These hooks are not very
different from their setprocattr and getprocattr equivalents, and
much of the code is shared.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Cc: selinux@vger.kernel.org
Cc: Paul Moore <paul@paul-moore.com>
---
 security/selinux/hooks.c | 147 +++++++++++++++++++++++++++++++--------
 1 file changed, 117 insertions(+), 30 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 9403aee75981..8896edf80aa9 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6348,8 +6348,7 @@ static void selinux_d_instantiate(struct dentry *dentry, struct inode *inode)
 		inode_doinit_with_dentry(inode, dentry);
 }
 
-static int selinux_getprocattr(struct task_struct *p,
-			       const char *name, char **value)
+static int do_getattr(unsigned int attr, struct task_struct *p, char **value)
 {
 	const struct task_security_struct *__tsec;
 	u32 sid;
@@ -6367,20 +6366,27 @@ static int selinux_getprocattr(struct task_struct *p,
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
@@ -6398,7 +6404,7 @@ static int selinux_getprocattr(struct task_struct *p,
 	return error;
 }
 
-static int selinux_setprocattr(const char *name, void *value, size_t size)
+static int do_setattr(u64 attr, void *value, size_t size)
 {
 	struct task_security_struct *tsec;
 	struct cred *new;
@@ -6409,28 +6415,36 @@ static int selinux_setprocattr(const char *name, void *value, size_t size)
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
 
@@ -6442,13 +6456,14 @@ static int selinux_setprocattr(const char *name, void *value, size_t size)
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
@@ -6459,7 +6474,8 @@ static int selinux_setprocattr(const char *name, void *value, size_t size)
 				if (!ab)
 					return error;
 				audit_log_format(ab, "op=fscreate invalid_context=");
-				audit_log_n_untrustedstring(ab, value, audit_size);
+				audit_log_n_untrustedstring(ab, value,
+							    audit_size);
 				audit_log_end(ab);
 
 				return error;
@@ -6483,11 +6499,11 @@ static int selinux_setprocattr(const char *name, void *value, size_t size)
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
@@ -6495,9 +6511,9 @@ static int selinux_setprocattr(const char *name, void *value, size_t size)
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
@@ -6542,6 +6558,75 @@ static int selinux_setprocattr(const char *name, void *value, size_t size)
 	return error;
 }
 
+static int selinux_getselfattr(unsigned int __user attr,
+			       struct lsm_ctx __user *ctx, size_t *size,
+			       u32 __user flags)
+{
+	char *value;
+	size_t total_len;
+	int len;
+	int rc = 0;
+
+	len = do_getattr(attr, current, &value);
+	if (len < 0)
+		return len;
+
+	total_len = len + sizeof(*ctx);
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
+		rc = do_setattr(attr, lctx + 1, lctx->ctx_len);
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
+
+	if (attr)
+		return do_getattr(attr, p, value);
+	return -EINVAL;
+}
+
+static int selinux_setprocattr(const char *name, void *value, size_t size)
+{
+	int attr = lsm_name_to_attr(name);
+
+	if (attr)
+		return do_setattr(attr, value, size);
+	return -EINVAL;
+}
+
 static int selinux_ismaclabel(const char *name)
 {
 	return (strcmp(name, XATTR_SELINUX_SUFFIX) == 0);
@@ -7183,6 +7268,8 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
 
 	LSM_HOOK_INIT(d_instantiate, selinux_d_instantiate),
 
+	LSM_HOOK_INIT(getselfattr, selinux_getselfattr),
+	LSM_HOOK_INIT(setselfattr, selinux_setselfattr),
 	LSM_HOOK_INIT(getprocattr, selinux_getprocattr),
 	LSM_HOOK_INIT(setprocattr, selinux_setprocattr),
 
-- 
2.39.2

