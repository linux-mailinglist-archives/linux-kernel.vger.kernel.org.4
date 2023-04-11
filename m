Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 589D46DE06F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 18:05:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbjDKQFJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 12:05:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230306AbjDKQEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 12:04:55 -0400
Received: from sonic311-30.consmr.mail.ne1.yahoo.com (sonic311-30.consmr.mail.ne1.yahoo.com [66.163.188.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5277E5FD5
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 09:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1681229064; bh=OYEWbDwa77VV0DiFMy0qZhXisBYPcCl+ZGFYdH9xhkc=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=UlDQ3pu702b7bOpZIvsUOHFXznb41BLn0I7Cb0vDehmXcH4KtfQ8HMCAHvSZ9lc+72kcbqmt2/a6alLua62kTM38rgLSPPtXMwcZdjwwC5jRDYH/iLqqdwYtHG5I8/HEHZYcWMg278L2QMlL3aCX7DeAFGdukZYXsSIhqjnf31JKdazThNPS+5+cgZkKDswfalAxUEJpjysNGU7Q30ghmwsmMScU1EtTC+Fwis5u64BusZnx7TtXqOZzvPupGsgU6DapQG81RhsXp8QG6Q7VKpQETkIUwcW8oXn+G9xQzKWFAM1cMeIf9x0Jv8w2aZ3lF4OrU/6pmNkH63SMvcwIJA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1681229064; bh=vZDCAhC9dZGtVF7ZkCq94Kee49SBy7LMLbJgH07fY02=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=RGNJ6fpg5tb2ug9FSinsRsbd6Ase5CQsYAvIZy9G7JFq9rEQUKhlvhXLshsohRCBnt7FQNDkT4yGzVqvvKgtkh4UzOV2UB4DTTLs5GEU2aRD+ikk8GuULhO3IMbjgvn7pZRGHeLh7HdR+fgMDY9PpAIYxq4h42NIkRpmmdAXXiFeHm/sX+ti2BeolkUqDuu5hOPqtjDsftyHKkMafIhRfsfT2Jg1qyO4u4TkcFYTXiXTesGcyNdGIwdvMDaYLa3UWWh5rM1g9GWHSzNmX9/o9CNRcEG4yrRPiPeuWDkpRvOE2xqBlebbfWshtflDmS3JmwwONOQf9ZlW21PHePLg6A==
X-YMail-OSG: 0h.h4wkVM1lvSPwhV5Om0rovAGtXqSKlHLPvc2TTKJe262wNkRqjSEihoHIVWMj
 CejoAStPMwr0Ucs_d_ZVCclb6xI0ywtvp5lY7UMkypzpnk8ZUkdvXBhMzPS4Fp9eeXLKSnUXPgVR
 Wa8R0rx91qHFXx0C8iFrhdSuuxVU.6mtkf_diXAAb5fzDc2rMLFtihuxWsbXURRHnlfquvr7Dqy.
 Ndw7A82wjuf6VJGf_vMTHFZ5zt3OH5G8rS13YzXLUY5xfFsGJmiigGS7uHdLC4PHEELJaicEZGhM
 jdlYkAM7COFOIPFDXJ1oaMDX67VPM4NQh5ZTqjATp3d8ppP3lXWKysScZR3TfHzlcSjL26nKynrV
 lOp7xEH4pbEH_tiddrYxT9miaAbMDgzWPGOLkNjcmJlxs.YSl8ojdeiqRZ7F2d03TV0..9ls4XG5
 .fQDuvqu9D3pmSp64Bv78xt2BYYMQRmaSHL8DCcOfhGFFz0JZ45N2ty34SlBJVsC2miwMbTYMUcs
 RGK66CHVgbL7wPuJyP3swTRkzR_oiHcIX7HsOVAWHqFxNDCDx2bOVLWK6o7vhXzCcsUBo_YhY2zJ
 iLaoxjvfZr1aqICZCTApnkipx50lkeg1a_RiQcTwrj2IKxNIl2lvFn_fXn5_fevmOSDkmf2J.43s
 _rwwlOe1l0gFnqqz90nplfyUChJDdE7xpdB.31tb8.NS09NvNc6ya6ySnJIr_oS5qQqmvnb9SqN6
 yfKyD1bEoqrqOoGs74NwHiGGcTDzA5gu2ZBVZ1bFA8quAtdQ_dCoO.it9PMnGSH6o2Bp2MQ8mMrU
 wrSyRRbfPMSH9ISnea_DqzfhOgW5vw62LxslKLsoHYbmOkkpTosDwBTS7xt42AdHUme2OnghWEbB
 DeczXGoALK83UJkFMadUvGcGDafRrPBgELrkeIsyN4jmOzGt0pvHTMjtr1AQRLsgLvPlEmjaMzUv
 63bsXfvKoXPs5ubJEK1OyEQ3YiaT5EfCvKkxT_j_5_zGBKnNpS0RnROZ7gcHujDA5YskgjMsn932
 o7OSf8J6sLC2FddsWHvwU5dGgor7AUd0MBZGKCpvg6VTBn0o1kJ35kPaIxaNkmd9cawNyqdVYuAu
 iw.OL7gHtv62a6b7SqQQzOU1zPGE55P3T5a49PIWO9g2w4QUL3lBNg00cecTgWjLFHDx0IhwyG1O
 Znsk.QVZsteJTcU0EnPIPduUKmWbuNgDKmmP.pbN3oWThhTI3F3WaTDiG7n20Lnnr8wjdjw1ZP7g
 n2onyVBAij470uCzeS9Lh.PqEMSThTmjn.Uhwx3RCOWvpQJRtm4pKiIX4OfmAAIpdFjoaHqng2Fr
 Axj4Y8h.2Oc60x_CYkKF.bT48RU0jNs.Yf2C8YaDY4YIAy5ERW7CfRFvBEJtRRFP3Vrkiimq6mM5
 9S3XtH32t3WWQByw29N8VETdtu7wd4OoPcNiMJuZjCp_P2oA5GNy28Pp9XiBs.lYXbg1NGxqCBIL
 sTlHV5lTtLszrS8N9IwXTQsDVkF1IR90r0UwIXVpI0E3O.xK5GI.NsYy1JbEEY37tiQXxr2dxnjo
 wIPyjVgj0GwDD5r8psW44R.GLsj3lc3mY6RQZtvLb3gkc.k.nimGRv2lOjLSOOVXjES0n4MTlva0
 zVSUiNpY94iYkJONgsoFjN3qFuXcP3V3l8TxDW4vYMzBM.w7kZZQPNOWHsvhk._fWEkIjZaOgGNu
 6lYx0VYWuqpt4cNgXn.9_wIFYdYpTdMYgUdnS9xdfLisOWXU8FMSzN6uGDpD32ZMuLMdelz_lQGv
 80mBcruR4gQ7ZTXemupuhLAdkKD1j5nKfVU2PwZIQW7UOufPWb5E2.KFFML.HLAs0B0lU11oQDXR
 K_zp4UtbA8_QSQtRzridGzfEF9RWcxm_O9ktGZJAx9BWVceLZfDWntjIj61RAUxzXXD.Np2g9s3N
 8f59giouS61tILEea4qt3PtJI5nHqTCHvqbBJ7PYXN1kWbi78WZk_YJAsZTNOdYbPavE.ZMX9L96
 2iE99OLyTJnknvcAww3wH4sFb5TNFCzcIiiLN8OpAC03iQWWsnSxqn8ofP1BK4k19.kNs1zejWcL
 FhloSCXKi.dghri5.w4q691BrvhJ9AYjkZX6MloliIZtCktAos9_QWIqqiYLq7yFdUgUoTTi9GHY
 oogW_uWVuWQG.z86ov.lJEbiGHsvvqgRgjFPfEYoLXVr9.uKZiyUokclknf7snHwutkol1Ux2o4n
 tA8XcSzE0Yj_uP0bVAlfXNBi65vN08F3NxC_lBjTceRZS0n0uRlcKc_uRO9hpOrNNRSeXduPwMaB
 oILtTyTJu3yg0LM6.FNIsWdv5G3URVCM-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 1b92b82b-97f7-4c6f-b54a-ad58e6a66573
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Tue, 11 Apr 2023 16:04:24 +0000
Received: by hermes--production-ne1-7dbd98dd99-vd22t (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 8ad5be559bf25ba1172230271ff09c70;
          Tue, 11 Apr 2023 16:04:20 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey@schaufler-ca.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     jmorris@namei.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net, selinux@vger.kernel.org
Subject: [PATCH v8 10/11] SELinux: Add selfattr hooks
Date:   Tue, 11 Apr 2023 08:59:20 -0700
Message-Id: <20230411155921.14716-11-casey@schaufler-ca.com>
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
index 9403aee75981..beb1d6f5e000 100644
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

