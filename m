Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D78D69FCE2
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 21:14:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232445AbjBVUN6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 15:13:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232083AbjBVUNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 15:13:54 -0500
Received: from sonic311-30.consmr.mail.ne1.yahoo.com (sonic311-30.consmr.mail.ne1.yahoo.com [66.163.188.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 550FB11665
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 12:13:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1677096821; bh=Wgj5Sp6u+Y6W+BvkFLWWh2yamvz1LXAbvb5Al4WnpS8=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=VLr33BIL6OweOIl5Bdy3e9uvXHnxKk4FWC47Y1QNbnTvL6iV3f0BWQHGdSLLGVbVi/B78GiVDZXQLD/gjFpyfHZazapIUegaAi2h4YAVA4LF13ZsPSyqLoqf3WslpnwYoFdjwCDL7TcmY87pM8Q1r/rE4OMpUk+UaJCByMgvSyHSywnJ9TmZruda4XxDZiEWS+T00U4pHNJNFKa+5A/m46hUUDimm0jaA4S+Ci5xpLBKySEw4AbanhkxpmGnKoD3U4IDJvFIeHTjXfKnNjw3eVxxYc1uThLsxtzGTB4bCb8zIf+Zh6XbKmy4xEgsqs5CegIeNACA+0ucwnpzduJLcQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1677096821; bh=de+9KgLNyifh2atvF39PQxDQhK0cOxoyN+jVLnC0y3j=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=KxVBOHcWD0IxeOIELCe0WXjwdGWqNp0YhtxkP5b9llfrA7JVyJ3iNbdLXKd1ZwPwlDeX58TvEmDDj3DgqDQ1eTpEqWnB62MZExhCR3YBKECFE36TwfgluJ1YolwELm3zkWQ4tDW0/SmIoEcSvGZ9NIyLVJdo4kwbQSKAXKDapoYgWi2JQx6TkXEFjK/CgGdzTkOgOq/sDzy/fwXe5LWJMHV3MqdrbPB0/LXNCcealjxbbfxGr4lIMZmtmbb4wyo3JVByBiMkLIqXl55NqmKcYK9OIooR8cD289CiSaSyX5mOSa3YLTEc/xaeR8I6JbhEWSB1JcdQaVsk4VgoSaLMjQ==
X-YMail-OSG: _S3I2vgVM1mgT9csDFMIqDIgbDDMHawfddMdTBSl2HlgeU.oW9Ai7fiytqt2hUK
 IbIq3xcgsNAq5Bz4HBWI3M3Zybxg2VGTlyGrx1RJajJr45hrvZh7MpX72hNqdk.hDyoA4YVW1Nvb
 8zU42ZzYtG8QCO101Mz4outNni3UtuCslCBAnX2tgiJQtu2soHwDpdZh81FMgO1VigCRjhKky5Cs
 afFKkVTGBp2Cn.9LytgXgjvW4qwn..umvfPgGV9B5wmk02pfq7sKBPtsc5IQtI0szAihDy0JHMMC
 5XPVw6CIbqwP8dJkwZtx4PDxumZRF0.OOPRA_0rQqnIxggqHkTxCaLG.p1HVF3BXslk1BsnjwAwP
 C.HHlm7cPCz..SdXLSowRepQPo94KZTrYsumTpugwjv_bSXgoS5f6BLb2Bm1WM9R_x5PdTXMNCw0
 oRQyZqQd4ILd2jOHEr02vcJL1TmMEAJ_aAZeW2LkSv9LDcyb_ykcBiuflBEdeeNQ7YkgXrtjWHo5
 CzcBIXv.B9MhraQc28SN_NebGvRbPP1eDSc8sKquqSqIf5QuaicCqwbqTJFBcyNg6WNN1hc4bsUq
 o7DHRNwdy9RwTZxKfJ5QJ24zVEAR74uX864AbLaf1BhojXUVhEe4V_lu07KBZRRC6RKUOpbpXBUw
 YpRrPDoHbm9hIeq_aDbyaRIIjp0BJLegjlnwPzGw766JjWf1ctA5vNUXHjInAOzSp_r51ZuTIIlb
 cp_7f4j2l34gGV7GLOfegfEaULco_jQRU5YLzoRBYTSNvGo5F5SYQ_bXr0WWt9yY.cSDWJqZWXXT
 rUU.msKFIJt03VWmAaSkDED.hoK8xEAZ0d5ur1v872ZPsb9JqtLiSQPut.WwChHt4uwkKJwKceBK
 3LseVJC77UytjSw7BRhbGDIwJNicKF7Wm6Hc4LEMNPKTKDbcdJvN2BuPHAAD3yS_cIRO1IJdqxpP
 pVZdnuCOMGa1Vgkgw42Z.DWo0WfauO7iuvp8xkRJ9UOuqtYt_H24fyq5BQ8kICb7FA26CsDL4as4
 LvIzkAAaIwhAQsE68R7zJ2Dty0bGiYNY_sWbOA8tiGS.smV0BzFDRhDKHooGuY5kb0VTryrdLO8L
 7D17rE.XQ4JMlV0KvrJsOP6D7tpQ6yMK8kBgambLQRZoDmbVp_6AAYZzEeYa7LPQEoTisyMfPsHj
 OoYaSp3dybOINhQULfpiMe48UTAz9vFMChrl4DULU2JahOCjkxhkn3qY..kQB3sklrmNx9eHFTVg
 CRchoNOrnPt1uwbkoqQIQ.lZcY6hLpYWN38vQonBFDv4pPxpwpRpK0v0rz589pPDGkFv4qOUzhC_
 kHxxKXgfuuFHDkicOZj3rgTWLz21p_cCb7pdAeJcfxPA3h.u26GAxZljkMCi4m593jJRqSd_909T
 dIAAjZ.V_1HGadYdVYmLy3sw.sdQfDDLRijow3B_ep._DoAuipM_IQwqRbX_iS4byFF1HncUiEql
 8CMTMlMoU9S1sM2l8tLVMfNfcuLeWh6YKh1OHOeKdPzGnqBPb8_3NQNwk8XiailBCRHFRABouNFD
 oAoMK3xz5ps.AEgKsuAREwVC.ZJ0Ythr.niAIwLCaNcNuOeJe_bGYg197xb_Qiyv0ZJur_zU603y
 KOF3mYgm_a_4pjPOwH63Dx3AarpDjG_coR8LNnW0Jfa2pq2oNG6FIplx5Y55_vEJet7LLdX3W4AF
 BuEoo4wlw9g0T42O_rL_mMhs4BLzksrKzgObIsa7rF8g.Z4CpexAfE6m0XLOwSAtl7IlmXdP1pVx
 v6eSduTj48CGm6W4f4lWMK.ThBf8mZC5bsyVtRPlfBq_HonV4E0yE24Cm1K2r6g3I0tI83NA_855
 mq2VOCLRv_P9vOiOqMjUTdIzHzZBMNhr8lIa5sqQCx4AIzvA_W8SvmYHKv7LfKXQuGrcU5SUa4zx
 WYsl34hszW_y9PkID2V07myIEVZ3eVPS5wQQtOcZyX4wK2TPni4UJE431rdG.YYQuR12DgLdab.g
 XTK7_bSHYTXDEe21FOLz6hx8N8pD4yemUk2QrBHAlrj5vj2.a2inwSUIgmlGPGv3g5QPZGj8J6w8
 VsTrU_uPHQp6gARztzI_rVIipxmO5W8jhJn6D3HGuJf66eiz6GFfXRvfxoQ245BdPamRjtgzNmsA
 NyC96T_BItuBkvrjCQ3ANyMKZmmMFHaWbJAIuaB34rXKXw38NOSr.GyBV6zZNWOmdu0cuINABTkr
 CFeTz6WhaX6sePiYG0L0OBCjxCUbeSdDd5GnjjV7AADn31FZc
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Wed, 22 Feb 2023 20:13:41 +0000
Received: by hermes--production-bf1-57c96c66f6-7l94f (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 79c399884146b9399d6b4aa8aeb66e6a;
          Wed, 22 Feb 2023 20:13:39 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey@schaufler-ca.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     jmorris@namei.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net
Subject: [PATCH v6 09/11] AppArmor: Add selfattr hooks
Date:   Wed, 22 Feb 2023 12:08:36 -0800
Message-Id: <20230222200838.8149-10-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230222200838.8149-1-casey@schaufler-ca.com>
References: <20230222200838.8149-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
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
---
 security/apparmor/include/procattr.h |  2 +-
 security/apparmor/lsm.c              | 91 ++++++++++++++++++++++++++--
 security/apparmor/procattr.c         | 11 +++-
 3 files changed, 94 insertions(+), 10 deletions(-)

diff --git a/security/apparmor/include/procattr.h b/security/apparmor/include/procattr.h
index 31689437e0e1..03dbfdb2f2c0 100644
--- a/security/apparmor/include/procattr.h
+++ b/security/apparmor/include/procattr.h
@@ -11,7 +11,7 @@
 #ifndef __AA_PROCATTR_H
 #define __AA_PROCATTR_H
 
-int aa_getprocattr(struct aa_label *label, char **string);
+int aa_getprocattr(struct aa_label *label, char **string, bool newline);
 int aa_setprocattr_changehat(char *args, size_t size, int flags);
 
 #endif /* __AA_PROCATTR_H */
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index 0c2f4d47af42..165fffff095a 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -632,6 +632,44 @@ static int apparmor_sb_pivotroot(const struct path *old_path,
 	return error;
 }
 
+static int apparmor_getselfattr(u64 __user attr, struct lsm_ctx __user *lx,
+				size_t *size)
+{
+	int error = -ENOENT;
+	struct aa_task_ctx *ctx = task_ctx(current);
+	struct aa_label *label = NULL;
+	size_t total_len;
+	char *value;
+
+	if (attr == LSM_ATTR_CURRENT)
+		label = aa_get_newest_label(cred_label(current_cred()));
+	else if (attr == LSM_ATTR_PREV && ctx->previous)
+		label = aa_get_newest_label(ctx->previous);
+	else if (attr == LSM_ATTR_EXEC && ctx->onexec)
+		label = aa_get_newest_label(ctx->onexec);
+	else
+		error = -EOPNOTSUPP;
+
+	if (label) {
+		error = aa_getprocattr(label, &value, false);
+		if (error > 0) {
+			total_len = error + sizeof(*ctx);
+			if (total_len > *size)
+				error = -E2BIG;
+			else
+				lsm_fill_user_ctx(lx, value, error,
+						  LSM_ID_APPARMOR, 0);
+		}
+	}
+
+	aa_put_label(label);
+
+	*size = total_len;
+	if (error > 0)
+		return 0;
+	return error;
+}
+
 static int apparmor_getprocattr(struct task_struct *task, const char *name,
 				char **value)
 {
@@ -651,7 +689,7 @@ static int apparmor_getprocattr(struct task_struct *task, const char *name,
 		error = -EINVAL;
 
 	if (label)
-		error = aa_getprocattr(label, value);
+		error = aa_getprocattr(label, value, true);
 
 	aa_put_label(label);
 	put_cred(cred);
@@ -659,8 +697,7 @@ static int apparmor_getprocattr(struct task_struct *task, const char *name,
 	return error;
 }
 
-static int apparmor_setprocattr(const char *name, void *value,
-				size_t size)
+static int do_setattr(u64 attr, void *value, size_t size)
 {
 	char *command, *largs = NULL, *args = value;
 	size_t arg_size;
@@ -691,7 +728,7 @@ static int apparmor_setprocattr(const char *name, void *value,
 		goto out;
 
 	arg_size = size - (args - (largs ? largs : (char *) value));
-	if (strcmp(name, "current") == 0) {
+	if (attr == LSM_ATTR_CURRENT) {
 		if (strcmp(command, "changehat") == 0) {
 			error = aa_setprocattr_changehat(args, arg_size,
 							 AA_CHANGE_NOFLAGS);
@@ -706,7 +743,7 @@ static int apparmor_setprocattr(const char *name, void *value,
 			error = aa_change_profile(args, AA_CHANGE_STACK);
 		} else
 			goto fail;
-	} else if (strcmp(name, "exec") == 0) {
+	} else if (attr == LSM_ATTR_EXEC) {
 		if (strcmp(command, "exec") == 0)
 			error = aa_change_profile(args, AA_CHANGE_ONEXEC);
 		else if (strcmp(command, "stack") == 0)
@@ -726,13 +763,53 @@ static int apparmor_setprocattr(const char *name, void *value,
 
 fail:
 	aad(&sa)->label = begin_current_label_crit_section();
-	aad(&sa)->info = name;
+	if (attr == LSM_ATTR_CURRENT)
+		aad(&sa)->info = "current";
+	else if (attr == LSM_ATTR_EXEC)
+		aad(&sa)->info = "exec";
+	else
+		aad(&sa)->info = "invalid";
 	aad(&sa)->error = error = -EINVAL;
 	aa_audit_msg(AUDIT_APPARMOR_DENIED, &sa, NULL);
 	end_current_label_crit_section(aad(&sa)->label);
 	goto out;
 }
 
+static int apparmor_setselfattr(u64 __user attr, struct lsm_ctx __user *ctx,
+				size_t __user size)
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
+static int apparmor_setprocattr(const char *name, void *value,
+				size_t size)
+{
+	int attr = lsm_name_to_attr(name);
+
+	if (attr)
+		return do_setattr(attr, value, size);
+	return -EINVAL;
+}
+
 /**
  * apparmor_bprm_committing_creds - do task cleanup on committing new creds
  * @bprm: binprm for the exec  (NOT NULL)
@@ -1256,6 +1333,8 @@ static struct security_hook_list apparmor_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(file_lock, apparmor_file_lock),
 	LSM_HOOK_INIT(file_truncate, apparmor_file_truncate),
 
+	LSM_HOOK_INIT(getselfattr, apparmor_getselfattr),
+	LSM_HOOK_INIT(setselfattr, apparmor_setselfattr),
 	LSM_HOOK_INIT(getprocattr, apparmor_getprocattr),
 	LSM_HOOK_INIT(setprocattr, apparmor_setprocattr),
 
diff --git a/security/apparmor/procattr.c b/security/apparmor/procattr.c
index 197d41f9c32b..196f319aa3b2 100644
--- a/security/apparmor/procattr.c
+++ b/security/apparmor/procattr.c
@@ -20,6 +20,7 @@
  * aa_getprocattr - Return the label information for @label
  * @label: the label to print label info about  (NOT NULL)
  * @string: Returns - string containing the label info (NOT NULL)
+ * @newline: indicates that a newline should be added
  *
  * Requires: label != NULL && string != NULL
  *
@@ -27,7 +28,7 @@
  *
  * Returns: size of string placed in @string else error code on failure
  */
-int aa_getprocattr(struct aa_label *label, char **string)
+int aa_getprocattr(struct aa_label *label, char **string, bool newline)
 {
 	struct aa_ns *ns = labels_ns(label);
 	struct aa_ns *current_ns = aa_get_current_ns();
@@ -57,10 +58,14 @@ int aa_getprocattr(struct aa_label *label, char **string)
 		return len;
 	}
 
-	(*string)[len] = '\n';
-	(*string)[len + 1] = 0;
+	if (newline)
+		(*string)[len++] = '\n';
+	(*string)[len] = 0;
 
 	aa_put_ns(current_ns);
+
+	if (newline)
+		return len;
 	return len + 1;
 }
 
-- 
2.39.0

