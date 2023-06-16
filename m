Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C03A37336E9
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 18:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345987AbjFPQ6N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 12:58:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345966AbjFPQ5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 12:57:44 -0400
Received: from sonic311-30.consmr.mail.ne1.yahoo.com (sonic311-30.consmr.mail.ne1.yahoo.com [66.163.188.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A551468E
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 09:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1686934557; bh=3KfYzQZSdHbYQjB0V2Ilq3MFhzyKnWJ15K+bVlsg+sU=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=pW3koTkDB55Q7fKjgheLlFOImcUnn6twslQTVxnLBv0ijl9Fmk1ih2S/k9PTdQ8xNRUPTC5SEVnlhW6UiUHcebtHjIoSJrSjSuMhQKvyn2suPEyrw4z80gG7yDeiIlCjaL/kiUZ+ygunsblU1YcS46mX2WmCAdYGizfvX/SG98KrajOky/VU7cyQnZF/EMVNVVh+s6RvvZRHCROHLJ7j+8QxFo9WuWfL9LdKUCISlsBGsIPa9igEs0lK8R9plYXFLboxviF+1ZRBwrUWjfT6EMuJBDcuFcaFsEQwnxhSbqp+4RoKVOPf71Ev/ePXd11qkJzHy0SnQ0PqKZ9M1SVMrw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1686934557; bh=LYVqupBZG03jat7NE2oFGCjbV2g/Jb3wL5M/XTDh/FO=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=QQ4iZrcVJeJxR8BYDVnyGJixw+NvsSyqu5c0/lyfRSlLCM5qhzP7pAV1XJwQ2o2/xf2C0aix3/gohLjV+aQLF3jU03oECl48CrMPsrclX9vBDzyMyF6NSBjEe+rSwMfPs2BUyUMBeOkqAFPDgI0fjB1rDGfkB8TWC5FD22smNYt7aXqks3XsFB/CLLMgtDhlezB2ob1vPoRqXZdh0BcOFEg1aMdc5ifhLU+9p3LBjrMv3154JgaWsTS2Rf5Ww01kEZ6bVxjbgfumgKjCz9cnpwTCBkcgiVRCo/vFjtZOQoVZdT4/YCZQojqbVzdF9avLgeAJvocY+5/GS5EsDGWXIQ==
X-YMail-OSG: iividokVM1m8tpceTRFA9lrwKdf1XkSt6oFM3b.y33AT3vVnUIlxzWjk1MTJQ.H
 cRSn9yDVEWGezLn_beWFtuK.xnpaahRoaaYRcztSjk9TKr9ROJiL14fQ9v1JuEVhPHW9bpiSbeyD
 9_rtGOw_l.mCtppm5NRa_6Gg9W9Lo43tfJKIGKO.6G_LSr6_E.VL781yr8mEk1Ad0YhCdLd1U_Ff
 Hf2oNxIR8SXwVMH7ioofKByX46HNGtmPhQfoEYhW8LV3Prq.NVpFrsbvOcpiKG_G9vkiINwlZTDR
 JW8pNyBbhq0A7Vyks9ZNd7i6s.NWY1cx65k9BLd1jQbjfIq6Jfgisml80K3hnX1SYICbv.4rw6Ds
 .RusM_0mDaDQFQT7CBgPmFcUbOvECV4KyFzyOQFNiMfdUPfX8H.bK09NDHDlXhpKxOHLwemExHVg
 2nNHKdIU0UtdMn6XOKrfRns.L4EArQaaaga_yICphvAW5mBHlYg5zFuuReGCdPMM2E8JKS36WmWK
 lLk2AnQYviDbeedA1861.AQuYFg1O8lAhtp71ZVL2xqk2Ymw5_D7lS5wNYoYUfBlGyTUEWUl1I2d
 1r1LqV12UEGFZRvq6KOrjut3XVuZneeTsldphcaAzvZ6iNgYwmMgJDlhPGGx7xxvr7a2wb3VKdXb
 rIIXKPu.4CXZiGhYnom6doA6lAu4414sXmRIoCPBJlFksskXDBPtEARBZB2ZPhvFyXtD52x96BDa
 Wr_dBA_6vOKfUGhkneybjRgfaIVcWoop20ozJfInZLpTrBF43F0hXnoKOpc_bpi2tYe4sV_AWknG
 A.o9TOVbi6VW1CtpLzpsExMAZmdj9jVCQUMpy_CDDS3nlQt_CBAwWM_EJbIT5g9VrAF0xfmRa_9W
 o6CxARBE3dQAVBxvfnNJZ55NVjdlD0KUzH6UqyjGgOYadVhwysDZ7SD.xFDKg2UJ8xD1I5t3nO58
 uRykReaey4OfjU43mXcIQWTS1dxaLmTm6v_dVhZ1w1O4bGkrX8W7BQqozirXasufUVbNVVTqxfJZ
 bQF8ULWQrTls8awWKD9MKsEtC3j8N23uH.7iPuHWyAHV.sg8lLcqVzQh3_Q1CDeSuyUAege5SsL3
 Co7VQUY6IY4mxy3.jQE_tlQwKE14KwnGeun0dvWcoKwkM2tB2VsI7rIuTlJVxo9TKP5bbhA0L3Gf
 21izp_HQulyUlUZi0L9IQrFovyeOcl7tVxgxsIZzjwHLkEmCAU6rQvD2jbHxiU0viIIn7DdIz9ab
 9OYT2pzzCfweSRzfBoJpPlPxnGvkUXqWENRyrIrdg7uj9XshIuujJQXmJsUN8nJiwDtrpQ958Gq4
 ZOHiyghly3jkXwtDlx4QyAFAM7qG_CwGS4YbfJigYUySEXwYQgoQ3Gr5BP.W6dgolFH6HSQalD2s
 B1SdycDQtrG0vmS6mD98McYIMdb1CV9Eym6qSPzNG0Zeig4O1fiR1eV3PXTujQCM5V2dJr2fgvBI
 hcYefkerPzBIu5vZ9YwPPKUy1Oo4CKaI_JiVZ.p41Gm1bMB8yWGDNyIwmJkoXyhv7kF0kGmiXwcA
 XRTxDOy6gZbSt7ly1h_UY3_o70MKkF1Pd6oDNcvsngH4Zy9Y_GstDXc3fw8hT0Lr8sdzSmlhLtSk
 DDJnapfGGMbcbYf5_MbogXMsIPvQXa2HfKzASIvyIr.4dSnAlAjnCS6SDMFFXKarpzTcwF0Hzyuc
 t3CEvbssiOfQMkJgmi6IVaq_ZSvkn0ryL1yKaYSBvg_IThAhw9A6i60j2ZnHH32MB1FAmDS6tiRR
 ZhEFYiMPIjokzzAPW2EmWpnVPvDaX7YRH9MgQWZ9yd3LmdlJHvuPz95mS2vYVFkYYMDfwx_2ZYYL
 fH0T1aTdlkHTHvIaGOg5qHlJx2WwXvjrQ47TTacXVFgOszKHBXNkuuwRhKlD4WieLc_ajqN7Ksw0
 h_JnEwhwECQm.x_Qp9uXOnwOAvmWunrifI3CTczC1nm6az26b_i0iONpFrSK38q3JPISHTVjt.jj
 .E8cFZ.PvnO_GoVW0xrI.teSkpe.DZ76AyBRcIkUtuVkUoz2NgLE01WQLJKt86Vr9SafyvLPhOPl
 GEJNfy44QtVTTR9RkhfxSbqSGoeQEBa9HuTPk94XKF0qMlcZ1LZu91_1yxeO3a0F0iO59CZ7DymZ
 onoCYT92SGwYZmbPmtHIAqKD26S5NMBLgeDtCwrR2nCuno8ZM.TINVjCC_Q_rlFohyRdAsH0cxRU
 NtHb4C46BsjNabdGg5j2wVYujvYdSr0TwGK2Wdln.3L1pLtwhJXemWaKwvgSmVB2HkAUU1Bn3Hol
 A1ogFVctPbQ82qvny.Q0TU1PDqC3C
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 6ca35e08-3069-48c7-89e1-9e4c8c84f532
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Fri, 16 Jun 2023 16:55:57 +0000
Received: by hermes--production-ne1-574d4b7954-tvjss (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 8aab4ebac04292db835fd6d81244177c;
          Fri, 16 Jun 2023 16:55:53 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey@schaufler-ca.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net, selinux@vger.kernel.org
Subject: [PATCH v11 10/11] SELinux: Add selfattr hooks
Date:   Fri, 16 Jun 2023 09:50:54 -0700
Message-Id: <20230616165055.4705-11-casey@schaufler-ca.com>
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

Add hooks for setselfattr and getselfattr. These hooks are not very
different from their setprocattr and getprocattr equivalents, and
much of the code is shared.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Cc: selinux@vger.kernel.org
Cc: Paul Moore <paul@paul-moore.com>
---
 security/selinux/hooks.c | 148 ++++++++++++++++++++++++++++++++-------
 1 file changed, 121 insertions(+), 27 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 49ec74bc006c..a4a536552717 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6226,8 +6226,8 @@ static void selinux_d_instantiate(struct dentry *dentry, struct inode *inode)
 		inode_doinit_with_dentry(inode, dentry);
 }
 
-static int selinux_getprocattr(struct task_struct *p,
-			       const char *name, char **value)
+static int selinux_lsm_getattr(unsigned int attr, struct task_struct *p,
+			       char **value)
 {
 	const struct task_security_struct *__tsec;
 	u32 sid;
@@ -6244,20 +6244,27 @@ static int selinux_getprocattr(struct task_struct *p,
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
@@ -6275,7 +6282,7 @@ static int selinux_getprocattr(struct task_struct *p,
 	return error;
 }
 
-static int selinux_setprocattr(const char *name, void *value, size_t size)
+static int selinux_lsm_setattr(u64 attr, void *value, size_t size)
 {
 	struct task_security_struct *tsec;
 	struct cred *new;
@@ -6286,23 +6293,31 @@ static int selinux_setprocattr(const char *name, void *value, size_t size)
 	/*
 	 * Basic control over ability to set these attributes at all.
 	 */
-	if (!strcmp(name, "exec"))
+	switch (attr) {
+	case LSM_ATTR_EXEC:
 		error = avc_has_perm(mysid, mysid, SECCLASS_PROCESS,
 				     PROCESS__SETEXEC, NULL);
-	else if (!strcmp(name, "fscreate"))
+		break;
+	case LSM_ATTR_FSCREATE:
 		error = avc_has_perm(mysid, mysid, SECCLASS_PROCESS,
 				     PROCESS__SETFSCREATE, NULL);
-	else if (!strcmp(name, "keycreate"))
+		break;
+	case LSM_ATTR_KEYCREATE:
 		error = avc_has_perm(mysid, mysid, SECCLASS_PROCESS,
 				     PROCESS__SETKEYCREATE, NULL);
-	else if (!strcmp(name, "sockcreate"))
+		break;
+	case LSM_ATTR_SOCKCREATE:
 		error = avc_has_perm(mysid, mysid, SECCLASS_PROCESS,
 				     PROCESS__SETSOCKCREATE, NULL);
-	else if (!strcmp(name, "current"))
+		break;
+	case LSM_ATTR_CURRENT:
 		error = avc_has_perm(mysid, mysid, SECCLASS_PROCESS,
 				     PROCESS__SETCURRENT, NULL);
-	else
-		error = -EINVAL;
+		break;
+	default:
+		error = -EOPNOTSUPP;
+		break;
+	}
 	if (error)
 		return error;
 
@@ -6314,13 +6329,14 @@ static int selinux_setprocattr(const char *name, void *value, size_t size)
 		}
 		error = security_context_to_sid(value, size,
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
@@ -6331,7 +6347,8 @@ static int selinux_setprocattr(const char *name, void *value, size_t size)
 				if (!ab)
 					return error;
 				audit_log_format(ab, "op=fscreate invalid_context=");
-				audit_log_n_untrustedstring(ab, value, audit_size);
+				audit_log_n_untrustedstring(ab, value,
+							    audit_size);
 				audit_log_end(ab);
 
 				return error;
@@ -6354,11 +6371,11 @@ static int selinux_setprocattr(const char *name, void *value, size_t size)
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
 			error = avc_has_perm(mysid, sid,
 					     SECCLASS_KEY, KEY__CREATE, NULL);
@@ -6366,9 +6383,9 @@ static int selinux_setprocattr(const char *name, void *value, size_t size)
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
@@ -6410,6 +6427,81 @@ static int selinux_setprocattr(const char *name, void *value, size_t size)
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
@@ -7041,6 +7133,8 @@ static struct security_hook_list selinux_hooks[] __ro_after_init = {
 
 	LSM_HOOK_INIT(d_instantiate, selinux_d_instantiate),
 
+	LSM_HOOK_INIT(getselfattr, selinux_getselfattr),
+	LSM_HOOK_INIT(setselfattr, selinux_setselfattr),
 	LSM_HOOK_INIT(getprocattr, selinux_getprocattr),
 	LSM_HOOK_INIT(setprocattr, selinux_setprocattr),
 
-- 
2.40.1

