Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AB81742DF3
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 22:01:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbjF2UBQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 16:01:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232490AbjF2UAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 16:00:42 -0400
Received: from sonic314-27.consmr.mail.ne1.yahoo.com (sonic314-27.consmr.mail.ne1.yahoo.com [66.163.189.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46ECD35BF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 13:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1688068836; bh=3KfYzQZSdHbYQjB0V2Ilq3MFhzyKnWJ15K+bVlsg+sU=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=XDzQndu0bp2CWwC4HpE4SCi//nKD5Kos4/Z9vAkXNON329uBDeRamYCy9Nut3lYZULOVMUAeS5G4TKeGVe5C+pNN7ZYeHRgasW/7Ml5GxJy780XiM11/x5JONp73tpH+eARk0rTuiJhGhaDPkOltVcdHW6SoAKe2hHJH4FkeHvJDZNaBnaGavDjRyww1cwo5BqV3AStX0uHNRGR6k6Z4nl8biGhnFWpHoeVSIcY0cTKWnIkmkBJMilnO/oDAH9ydFjIhDLp+hG9HvoEMRdVn0ls6QnTXDzG0Hz0AJggaBXQ4PVch2YssYfZFhubrt77te7EQHfBuH8ngEimyl3s+MA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1688068836; bh=Mr0R1ALZp1488b6yrqlnLm8iUD2MhEmnFV4c90EdltV=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=PdSbe0MExPsn2r3McRu7u6eH75svq2WrJLQvnDJN4VRaBTe2u+ZiBXB7qqMVnVYeS66EqqlehPpt+h1o72v6x75Z6cfua4lUAy0mSpEfr0Xl+qWikfYMAAQxMQWsobzF3C4yJsl/Upbef0Il6QB8nweTBcoOZzR9Sd2wC5khOWQ9Hp3tZPpgs3QVW9EkEHuMLfQQ5/wUk76JasRr+9hZwRYCDNlYzp6yGxVUknG5HUwqAAAhk0MVtwXAGQmJrLYIECJae2Ypgo9eNuiWxfk/+OmVbCfxUb1RUq7RXAe3NhnSjQR2kgPGDSSh0yDSu4zwDH1XlJL0DHKofz6mfHswFw==
X-YMail-OSG: tlu69aQVM1mZwufp.7msBK1qmeW9uzgJA2ewmWjSySWiaDoWWzPpF9LfOwjJ4Yi
 JrOjEKVDhvQARdZcm4q2TZyg2VWaFeDRYDt6cQjsf4ZUdF7Zsw9Wgf5UgTCIDXxPnWgeaOUHxaXb
 NL7jdSPU75FkENOeRz__UOtNxdM9ogHedDc5YierDWVWn.BJyqUM2RYLoVRqtyPhLAu7PK6SZiCh
 rgRH6mOHZtNFfb8BwQwY.fqRYvZLl_ZhcLhBma3GjIFmDPZw.UC4pkmiyiA4qHRqUGUFADx83yWM
 1swLL0bZH.lm8icp1ZNN2WDVMaaDzDdfzKHdbNd6VznMymTBXYXaNaq7g7V8gHITjSiaGIqj9xQY
 nrInsgjFVyEF0EsFdain4eDqxNL1X263EIkERWpgAqG8xngFMg3IVfHvl66RMpNH7NORPLIn9D3j
 HhmAY6H9_LbUEHw7TXgFjSHvk.dJ.kKeaeW4mGI4Qap0QxlWwnGVZsoeoq_vvlcfk0rPM6MOCksY
 r4RrxhdkIAQorBw1B2tJKYrOvHvmHANMC_n908PyiRY29FZcSX0snqZcxotEiWKpidlj_Z5qH.jm
 fJqXV09xpqYMiQX3Yst4KsQIygDn.3UMC7FDBWhLOUwvNVXcu37pj48p2xVl9aIYDYxvQRsGRbM0
 yyhgb1rjb.hDWXzIFtH7LraY.2WXsdjvUn_gv71zVFlmYAN8PyUvj5UwulWNUnDz4ZOp1bZjRl47
 XFwba5fkE0LCN0W21RIRWgu5gMm5rV3NvZm2dg_TenMNXmragnZYWCYJhevCM_AAmkGQ6kgGSiLl
 89SyELIf.wgJz9bcROVuveNXnWQf0RU5W2rEzpIftgcQEBib4JUK0RIETadj4yIby4v8XQbIEos2
 cUB5WoQleTnusTgTh3.ZLCFaT8JeCcHE9Uttm61J.F4vCOHiqiKs8.vtP9Uz0v.AITS37KXFsYai
 hY5yIv7Yc8BqA3c0wYkYb8pHjgBqdBtdFlklxCgS_InCToSy3IQ..uDZxWqmsBH0wk161n3RZ3ga
 _s3JG.vYAGYvxp9LCYAM6pxiVeRqJaud_odpS4w5mxtSRQyif6UT4QSkWUM3zji5siS4ZcR99IZ5
 09YiNJ6iKLyH0vdKrBlO.Ru6pK1Fb0HQOE0n9.o983Oh7uMuB7BOhBNKTZfE.TOG35p5RoTTvECV
 rAHcNNV9B0XVMEaGgS_UzflDP9jEpJtfv8CCgJuEInFGWrgWF3oue9G6qJsN9jhckE9BcrBs0qpX
 FJaDgwYZnw7zSnf1RdoYaDSreqC9v3QL6ijLe76Qr7WI8afpshTdB9a.lHs.0yehgQskpVbKz_cs
 m8C72Bzm0OkHSnA.x5d5qb0OpwDgjX_FsWY4EoYeKl3TwT_.2JvqivRGI3d.65KE0F05Q_xfZ3wU
 A.Izdi0LgTG0IjIQ9oCp8hbTtPwZ7ZdEms1TWFowRqygLPgKR2VYrk._do.7TN7cQbDAmeLwBjoB
 FswGolqvBFkoOooor7_RpT_0HR6.tDnpDYmyA_SS8d7QfXo.dai8hFxRN6253ggIZ6eggGr1Gs_L
 cy8gNLBR_CUYVWb992iLIrDWGhG9ggngg5SU0s.n54r6tlmWc2.8tco7kPKwMV1tmqPD6_31w4HP
 YjMihrXo0basjMUOHcfxO.CHOMGFiYTAqe08qWVwlrfPumxxMwV3JNbF.WG2ag03agjYqZukmIOI
 qTZlg60bmKFBkN2EQrrJN.mzL8E7.1Wlq0oSJYW7LhvUvPboirZhl1zz6nWjTZOvkILOpXV.2wRb
 _L_x9ZuRKz_kt_xIMZVe_dO1CsIXVCcVwrs5ILet3_o_GbpyOH99ZiA19FamouEJ4Q_VkKU0i8ua
 C_NakNNVuPCt0xNsjVtQk..vFiwypV4krLRcV_RsXoboYbt5YyUwlFl2cf.uFZkZ41lIaVj.b9Qo
 8hrDZrV8qZglQDiO3vXksZ1XLYdGaKvQZGZ2YeVzZTW4fHRCPNVPw46AqsRnwQkFaZk9Pk_5NTQi
 BULwy0LenZqUZtRnsr9FU5MlBhvNzfqQ8pajcU4.a.XLCy3o7aBaIm34qhQtZjUMibEdNcyV30mP
 C0AOfXqARcdFJ8HLdc5G0JRmAIoe7RzwfqLGetxpZzf_FwRgi3qYBxFJaSKfuSb7Q8kLIuK86faR
 rGi52AgneQwwXTkazWJSpUseenW9xLjSD.AHuET_I5lng6DhPIJ5vhL.6qksb2T6wHdYNSaf1qwt
 gRWD.lz3_XRypSk2lFcSfW5u9lxaF0gjKDz8oK2pqXDye3m5N7vpDV2CSpkhCOuzJd5sJQ2HJRr3
 WXEg7RYsSfTOZCrDiLpueMZ7o.OgwaDQ-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 89ca7050-aac3-4c82-be97-7d994c83ee28
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.ne1.yahoo.com with HTTP; Thu, 29 Jun 2023 20:00:36 +0000
Received: by hermes--production-ne1-6d679867d5-5vpxd (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 3de0d904516dfd44a291f116baddfae9;
          Thu, 29 Jun 2023 20:00:32 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey@schaufler-ca.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net, selinux@vger.kernel.org
Subject: [PATCH v12 10/11] SELinux: Add selfattr hooks
Date:   Thu, 29 Jun 2023 12:55:34 -0700
Message-Id: <20230629195535.2590-11-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230629195535.2590-1-casey@schaufler-ca.com>
References: <20230629195535.2590-1-casey@schaufler-ca.com>
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

