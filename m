Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6533C69FCE6
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 21:14:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232365AbjBVUOC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 15:14:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232300AbjBVUN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 15:13:56 -0500
Received: from sonic307-15.consmr.mail.ne1.yahoo.com (sonic307-15.consmr.mail.ne1.yahoo.com [66.163.190.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8766218A97
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 12:13:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1677096822; bh=lJyVgPk32lT9oIbOIjScWjIYoZ0R+o/EuqdAuivGGTE=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=hIGaGXJIwdDjvRvi0J6sW84TTLzT1CFUUhRBUmgbIXA7VerjwkLRM8hSO95JoIAgSjiPa1OWIPjfh7PpDAMBTLvdpcimmzRjgH/UWT8C9pCM6sttD2887vjbyIpn49pp6FDjr/5vlaBB5Bo395n62+XOq41HJ9bWDJOFtGle2PfmP8iXiwS4++YxaSmWSESc1phO/xG0jrclGLwLqq2TPfvMFIKiAuh9mG/ggIQ7rADn6lE0AKnFPv7iX8OFl1tDIj1YfPhnwts4qjo+Ub7IEbrvK2vTxeVm0fdNDod83JN4BGjqW7S+StC8V+BAHkoXGC+SLcpIBT04A2RVvuoplA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1677096822; bh=Gx99V2Hhsvp9kW5lrZJ7PAr7uxJqc4kjaErTlxPh9uT=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=BLMIXUGhGB6rZRS9Wx8vwdH2QBXpV86kyyZfAqH+F70128Wr/5vThmJfQtd/WPuhK1lwDclBuGAhBNWauUSSbX6roxQ6lTe/azcs+gZozb4tZwbnETcmRZ2XfRJeZic5FGnPs7aQHlZL6fUYk2D59d9QSVt8X7P7mqddydyCd4eG1Gb44WP0o0KbalJNpav0fW7Aqp8hwAGP+dblf3WLITIjEOVi8TiO71w1Tl75V2w0EEznwq6kI6VPDSpRUue1XTFz5Obe45CIK9KbJdyBCIEz36UZEUvL5hStYCuh9D4vXftl1kD//oDv86fS4jFmSxBW4VzJf7L4MJVRRpI6zA==
X-YMail-OSG: 4sN5RKgVM1nVFnyLtwdSS8ENBBlSJ1i0U02JCo978Socz6rjImomwzSi4WuC.xz
 R1BW2qn3e53tDHPV7x1cLwpXWbOJItios7wF9E5kJufhXWmHjiXztfIJYKiXmN5nfJdKdez7iLOF
 umu5x_INQbN5hXfpTor32onPP1xwmwS6.U.NVKBj5jAEOp.2OB0x1IyJ09AKI2fKG2SPii9J7z.A
 Xwx23DObDPPzXcAMUtqOeSrugptqK6mP.ZQPHS9oa5AjNPiLIbwnI6KciWLrv..tuiCt9dC.4wmq
 8Q93UQM.slP0UFmLAKkWXTlcsCRvmXEmfeQtuFN2zRyAWrKjbzL2HJo_KqZ4qXaDBt__c2SW7lp1
 2.MuyEnThXE7iOpdU3jY_qTXVFLHKeQqpnqbJv5CC9fm_Zk_roPF_ZIIPbMPCAmzt_F998dDCy4h
 LDRR5_J29Y52BGU4CN6bRR4lbyo9oNBmSczOxya2fEPsZX9JHVm8yXWhYvooBQ9VDaP6TurwXmCZ
 Twxl7_c5fhZ.QIyXBaPIqoiWmLS5l18hJliMNPQek4My5aDoWVUQr2zrbpxQz5PS1PjI7Py69qw6
 MDcLzg3RH09LHAwKWo5IkWu9XMU232HmbM7vxLam5CG2WZag.ydUrPTPeNtajg5Z7M0f3fC_nQ1G
 4liMV1HWzK0FJjLlp9oIMQe.LMTY6baoaHOfAp0aCQTgaGmDSzgb_2Pmud6iBVuUxAiQzJqDKHN1
 HkkIuprC5o7HuCRRrxYeOrP0g7nxlHhAeGSfWpqoLunwzTmyQO99.JSm6vY4Sv6HKQedcQpTVdlt
 3eh1_yrujyysZBQe3es7jHDVc7cI4_NLI_UU3BgjBZfMXWc67xTRAXQFFOFGCC1apog_z3gvadiF
 5k2PmCpEnFcueJ38y2fj1ZQAAGGX3cpToPkEgnNexPEXfikCvzf_pIh3MCA9MXZcEUhZZBc.1hbW
 .biXljhCkU9zDiHYi.JvbtwkRvZl3LdDauuR4kL2EkVdkpT45ZT26rdkBYlcusRuPRxAe2OiLyBc
 SfiKSga.AN5qVJswaQDS7Fy6VzTZWRnNLFBYydrexEm36Qp.MwY6zVuxwCRlnicl0GWvGuN_XX58
 zWZzyyBsvEEhopaK29ZQWPnssIDggjLuLWJlw0DPclYSn1zyyj4zj4xhEgZcVPTQfTridJ0gsgkU
 _sfJkHqjw6tuLdwXnlzprbHN_LZGuhtt4nRTHgaLuqLjuMKnoWkav1QZH2mn5imiv9eD2HIWTn6u
 pCfQ7AuqaELHUyfAAD07R6vMTMXd6xfdNJ5ECcHNmAs4W_mhimIfUqnRus1Ms9t_eViFxOk16fuT
 0kYW7u4Z_6MUc7QtPyZ.YoLHGNdvzm3vr8HQGdDL_3j7l1kJuFJj.Q1AOn8IGgmfdFiEiMxax1cf
 E3C_gbzgQdaDew4Rwb3NwLD3amQsOcak.oi1.8pE49b8Xpb0aFV6GOa0VSyEd5KkogolCMro694k
 Lvuti77Pr_P2TRThEvXS.XKjq9kQ2mQ7DXgbGKuPC.6_m3aXbkTL9T3ePqBNgw4Tn2ii387WtsAa
 YgYRg.xdij72I_6YfgNvOr.gi2NPPEU0aPns_b1h97kyQhu8bnRWPXRDU1w2EjcvafMaUKDPagS.
 woArQAdgJZV8.T9mvRQO_BXExhYsOhXciHQeIJRLFUdu1VksBiJx7kfzumfnUz.DSXU6qNu_OCtd
 L9MWrNKAM93QSoPWJxT_NnZyDOLzk3jV6v6Eli2dPwhgc4GQDRU5wQWyamg0o1TDgYTI6YE1Xg41
 TaoQ25phqGWn15h7dO.g6LAMjFPm2BhPNNm67ViB_n8InFIPgOnS8ej0Ii.SHHiYe7ZUVim4LnwY
 dsGWiTyhiNLWjsLSRgW3E.JbBCbJwd5NJYUuWsozt_yl5vBuhjRI2ttVWBXp5Q15kQg4g5gDBvj6
 GE6DvCQ20gyh5wwM0QNxv6o_yhikDPEIC.YHl5Z9Vv4fVjrmv4uTH1lqNDY1C9CZOfDJ.G_OBhaP
 nkFPQaWT8uk4kufzMQX7nCEiLH_WMQabgv8SW1CT8TKXB5oMmvE8zherFGjeotJctFINP3WLtqMM
 gjhIj05V.FgwVFQOj1FOLfcEgzUEwR4EKRvjEQEtkWupvC2fGWjMWkOq1TMjHdCE4PQstWMz80gz
 xpjpQGqDM9vPrlyXDZDvnHdGA2gZtXDeCRjHbYJjgsyFZi.RgjI9qevYDvqVaXxTlKIrbkB_93De
 9Qy45fk8bi88m7XznSoPlZIam74x.fMdSIeA.xyjx4qiMTup0
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.ne1.yahoo.com with HTTP; Wed, 22 Feb 2023 20:13:42 +0000
Received: by hermes--production-bf1-57c96c66f6-7l94f (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 79c399884146b9399d6b4aa8aeb66e6a;
          Wed, 22 Feb 2023 20:13:41 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey@schaufler-ca.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     jmorris@namei.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net
Subject: [PATCH v6 10/11] SELinux: Add selfattr hooks
Date:   Wed, 22 Feb 2023 12:08:37 -0800
Message-Id: <20230222200838.8149-11-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230222200838.8149-1-casey@schaufler-ca.com>
References: <20230222200838.8149-1-casey@schaufler-ca.com>
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
---
 security/selinux/hooks.c | 143 +++++++++++++++++++++++++++++++--------
 1 file changed, 114 insertions(+), 29 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 5cb09986a2dc..b95bbd7bb662 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6348,8 +6348,7 @@ static void selinux_d_instantiate(struct dentry *dentry, struct inode *inode)
 		inode_doinit_with_dentry(inode, dentry);
 }
 
-static int selinux_getprocattr(struct task_struct *p,
-			       const char *name, char **value)
+static int do_getattr(u64 attr, struct task_struct *p, char **value)
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
+		break;
+	default:
 		error = -EINVAL;
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
@@ -6542,6 +6558,73 @@ static int selinux_setprocattr(const char *name, void *value, size_t size)
 	return error;
 }
 
+static int selinux_getselfattr(u64 __user attr, struct lsm_ctx __user *ctx,
+			       size_t *size)
+{
+	char *value;
+	int total_len;
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
+static int selinux_setselfattr(u64 __user attr, struct lsm_ctx __user *ctx,
+			       size_t __user size)
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
+	u64 attr = lsm_name_to_attr(name);
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
@@ -7185,6 +7268,8 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
 
 	LSM_HOOK_INIT(d_instantiate, selinux_d_instantiate),
 
+	LSM_HOOK_INIT(getselfattr, selinux_getselfattr),
+	LSM_HOOK_INIT(setselfattr, selinux_setselfattr),
 	LSM_HOOK_INIT(getprocattr, selinux_getprocattr),
 	LSM_HOOK_INIT(setprocattr, selinux_setprocattr),
 
-- 
2.39.0

