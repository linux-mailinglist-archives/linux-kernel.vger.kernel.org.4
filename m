Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87838742E08
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 22:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232489AbjF2UBL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 16:01:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232434AbjF2UAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 16:00:39 -0400
Received: from sonic311-30.consmr.mail.ne1.yahoo.com (sonic311-30.consmr.mail.ne1.yahoo.com [66.163.188.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A2FA35B0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 13:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1688068834; bh=FecLkrXox/1UtDMuj0YVSfxHtwMaEWW93HEIoUhvMVY=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=eXo+5TKvNKfwg1J3yxpHvu7BjkAs8LVtruGj65k7/BFH8A4GnorEiz7Njw0qcX50MXgrjahRrMKEt2LXiiZXSNLhSdIoEqn4VcsxuW6UvB5W7N+c3IQd2hZwJiLCQXC/GQqbG+TBo0do4GWjvM6hozJ2zTXwRhgVi8HtwmUE/03/w0vmblpgsv7Y/UKSqaDrULysEM/hnw+pfIbIu+aFyq3MaIfBxMfwZl5jNdAnj2Gm1fyNGvMiixNeFJ/upyaaJavTX4mhJMhf1oCgtmdQqiwUFqCe/BPP8O3mgBa6+ZRQoDxp7cpYBBcy4SQPo4Zy6oHYUoip/BK5wS2GeqjECg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1688068834; bh=/FIFpSsqOuo/7DEPmlLjOR/69mZ7RdgDOzIvF9vNnNK=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=AfzthcwYn6W8PjDJZn3SanCleE2R2EQ+LWBVSolfucgvYgBIAr4BPSVhKgblCSuTgPIptRkP4NkXKZL1bLJUp6v7IIkd4I9QGyzSfF5jypngy8gh8dGhLtAqE67YecYFj0RkX6JpRePA2zPnb09M18C1MzV43QHaOi+9RrTuxt/2LTWyI3ABZzNyAvy9bAFLszuJcE/3ho04d1ZO/m0LGPn6exwxBtadntaDw0uKZMY9oH3gEgVOuPBdmmaM5hlgld7tUIUQquhM/u4HLvHTzw+kpDyoYBDJXuziO4J8FyTnmjk9MVJbHEJaOkR0sFTWCkdMrnuzhz+gUAEABS3jaw==
X-YMail-OSG: 6_.qGKsVM1nL8omVAgVL1yFNQlFJ4MGY17DWjYpuQCGqkNcO9rm9kCM3QnfZQo7
 OiPQSnJXKnplZaoLrdvx42Vm3yi2qF_aE_2Csf99I23bRYQY5ALrtqehudIAIINM8_Av2aMVLhhO
 gDU66UXWky3SomeG9.PnE4AHuq5jX42M8Q1GFC.7IkJNoH8ef9aAtDyhdow.vzC.sKUvB5JM6JYC
 hW2TcbjLGN2lchzJwGdkZJFQFhjSxIgJIzHtHXZ6lpySh6bOYBdhwTCXIjPgYmPdnCf7Sh2P8eNu
 WxtJQGr02bB_RAGO2LS9d_v48jSBY.Nd72AQVdBA_.uByNMM3OTpArDbAOjeyrUQ48XHVBa0t4Yl
 LfbSJkNG8b14d9QDTKqXi_OJXy_xwxvukCP.LL0nGfRY8Afd5G6rtiv94zj1NTgeWLCp_OtZ7O8h
 dfPe3CgjPn_7stsBWAbuzv3CwDhbm1_QKIx4CAw0gqK39pks5oxIqHYH6sn6xL3M8wqmmLVQb1.I
 8a_V1nnqLEX1bM79zLxHdBN26yOwvkJuFiZqScM_PLK75vsSDKN426wKokfg_Zf_cE8FH5BLbdc3
 RoeCeyw8YDg0FlGMBu0jajg2vlbfolRGy9iJqalttW0yUy87FGEKAygl0x_FHYoWj4e.bCgxHML.
 bA5EZFtehyKwxk6JNfXsEG9sKf6ppDLP3lNL6hY63qp..d1DlM.k.nOO0JA4rYuXUIHAmj68HaAr
 LqQxBwr2vnxMTCthV_U.s1rb1qxKtXcxtYfszKi6.ARuICbvkqTD5NN8JZF_gYMrs5yBGYy_eiZ1
 HTPr5dCyxeOisnzYC_uR8p2R.wY.qQwvmoTEMOvrQV4N3V0Dm41rzcODyP88zTlhm9kK4AJzlSDB
 OLjJ6Voq2Q_8.kZn6wv4dzvOMJhNGqWW4GNgAlAfysdsjh5v3XKTteKAHywfki3dKz6tKxxfvxSX
 YtjAYGjOHsk0oW90PDxC1jLatlmfY27JY.SwT3L2Ubm1xFOsdS9pNPJc4_ei7.vFpUm2ldNZRUHK
 iWVZtxQrgZSZKwnQNGhLcy6Mk50fb65drauu2WuAlmQlItn5NOf3A9XROy8RkMujNM4lfBHFWxne
 RSdR33VTATYkUveRF.RYvahvaqYWE1HtHMQ9UG2AevqH3A9I45l94xBh0hmJydAhHTd9ItDgHypy
 A9uctYH0gLk1T7lTWsEhE7wzYi8cRNg5JgmTSApPfnu_MvgucMe5H3QBdvp39HBhfyPUoN_xnAfp
 NviOgR5qS0hAxBEerAygy3JRqVFVhh_ddWU5Et1e3TqcFTSegXu0UCUnXBSEBRG1G36hLppXiVFC
 9Orumh8a7M0osOUDSS6D.baS1lx6J0Jc66kMSA09V23lcnb7whmIWM8KCV6ROto.Fm9.KFU0U1gx
 UkWC_2PWFhQTVk6QhEeuE5luyimmckKxlQTCaRE6ZQxF9r.2Gr2hI3jwY0Ovr3T0bzg2eRUOytY_
 1_6Wnb1D_xIOVlsEsctr7zfhLjiw60V9.W5ji_1qll95tvS3yn2SKseIyWncYodB5LEXauglSnSM
 eTwv03QzVZAvaqEZI42YjgLGtcTk9P_rSNaO6s.B.pluWUo.cpEBzi6xKz6_kRLEDAe1xOGXDWhH
 BGDXlEF15k6MKaiF51QgNoqDB7HcvJ6UQCX4YYYZTpSIXyYVLvS7Yi6DUVoPoEZUjtp8xjg185Pj
 Tr4XALtQFgcPf7FqN_nMf9NVCqzoafDHApsEN4U27IFTSRgdXZirJWF5H3GdrT8cgRizQtLamAb7
 V24OAeTSLHzB65BHNvdSLS8Dhgb.j9dKLWWvHR6ZmqlGqnDMOZuNLzS5KdoCbFM7viekVOStSt.a
 so9Gey.UnTJe31lwyR_JIf_1SxLmI8z97E_aeroRlB5zX5F0R3JyfBIicz4D6iS2MJP__wz0YdWS
 EpOAfqlDXHDDLYnnFW.DuLzxG2jlrjb6ISY0T3VwmgIH7J82PJ4GQpYmt880HPJkp3ocNQOGICcj
 RK12vFDXl0kw0lw5UfoDQ_F7Pp1nspmjYFxtKmStwizX0PCp4JV0yZssl0LJ5tlHaomBdMqYJZJN
 wVQSN9QN0YENj3IStNlr7a8fv54QcM.tNNU8suFzOcNDYXtIxzZ2epmfyW9kYC3Q02lRqWVBpAo7
 BA1uDj1gudMS2UrrofywxZQ55Gx1W69xS91IuEetqdkWPdohnBIBbNsjJAQttbPOQoK_HQIn6M3m
 y.ly4ellfHtFOGvHgnNu4ED7ZmogWvoFa2xT_JXb1TlTPDYtB3e5_..3rW0LqcAIUuw5YKiQFJo6
 nx3F6hRBmevnT6P0V05follZpLYQ-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: a34986ca-e6ee-49fb-a32b-5d35c826c077
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Thu, 29 Jun 2023 20:00:34 +0000
Received: by hermes--production-ne1-6d679867d5-5vpxd (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 3de0d904516dfd44a291f116baddfae9;
          Thu, 29 Jun 2023 20:00:30 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey@schaufler-ca.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net
Subject: [PATCH v12 09/11] AppArmor: Add selfattr hooks
Date:   Thu, 29 Jun 2023 12:55:33 -0700
Message-Id: <20230629195535.2590-10-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230629195535.2590-1-casey@schaufler-ca.com>
References: <20230629195535.2590-1-casey@schaufler-ca.com>
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
Cc: John Johansen <john.johansen@canonical.com>
---
 security/apparmor/include/procattr.h |   2 +-
 security/apparmor/lsm.c              | 102 +++++++++++++++++++++++++--
 security/apparmor/procattr.c         |  10 +--
 3 files changed, 103 insertions(+), 11 deletions(-)

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
index 308cb3a281c3..7d99d5be4c12 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -630,6 +630,54 @@ static int apparmor_sb_pivotroot(const struct path *old_path,
 	return error;
 }
 
+static int apparmor_getselfattr(unsigned int attr, struct lsm_ctx __user *lx,
+				size_t *size, u32 flags)
+{
+	int error = -ENOENT;
+	struct aa_task_ctx *ctx = task_ctx(current);
+	struct aa_label *label = NULL;
+	size_t total_len = 0;
+	char *value;
+
+	switch (attr) {
+	case LSM_ATTR_CURRENT:
+		label = aa_get_newest_label(cred_label(current_cred()));
+		break;
+	case LSM_ATTR_PREV:
+		if (ctx->previous)
+			label = aa_get_newest_label(ctx->previous);
+		break;
+	case LSM_ATTR_EXEC:
+		if (ctx->onexec)
+			label = aa_get_newest_label(ctx->onexec);
+		break;
+	default:
+		error = -EOPNOTSUPP;
+		break;
+	}
+
+	if (label) {
+		error = aa_getprocattr(label, &value, false);
+		if (error > 0) {
+			total_len = ALIGN(struct_size(lx, ctx, error), 8);
+			if (total_len > *size)
+				error = -E2BIG;
+			else if (lx)
+				error = lsm_fill_user_ctx(lx, value, error,
+							  LSM_ID_APPARMOR, 0);
+			else
+				error = 1;
+		}
+	}
+
+	aa_put_label(label);
+
+	*size = total_len;
+	if (error < 0)
+		return error;
+	return 1;
+}
+
 static int apparmor_getprocattr(struct task_struct *task, const char *name,
 				char **value)
 {
@@ -649,7 +697,7 @@ static int apparmor_getprocattr(struct task_struct *task, const char *name,
 		error = -EINVAL;
 
 	if (label)
-		error = aa_getprocattr(label, value);
+		error = aa_getprocattr(label, value, true);
 
 	aa_put_label(label);
 	put_cred(cred);
@@ -657,8 +705,7 @@ static int apparmor_getprocattr(struct task_struct *task, const char *name,
 	return error;
 }
 
-static int apparmor_setprocattr(const char *name, void *value,
-				size_t size)
+static int do_setattr(u64 attr, void *value, size_t size)
 {
 	char *command, *largs = NULL, *args = value;
 	size_t arg_size;
@@ -689,7 +736,7 @@ static int apparmor_setprocattr(const char *name, void *value,
 		goto out;
 
 	arg_size = size - (args - (largs ? largs : (char *) value));
-	if (strcmp(name, "current") == 0) {
+	if (attr == LSM_ATTR_CURRENT) {
 		if (strcmp(command, "changehat") == 0) {
 			error = aa_setprocattr_changehat(args, arg_size,
 							 AA_CHANGE_NOFLAGS);
@@ -704,7 +751,7 @@ static int apparmor_setprocattr(const char *name, void *value,
 			error = aa_change_profile(args, AA_CHANGE_STACK);
 		} else
 			goto fail;
-	} else if (strcmp(name, "exec") == 0) {
+	} else if (attr == LSM_ATTR_EXEC) {
 		if (strcmp(command, "exec") == 0)
 			error = aa_change_profile(args, AA_CHANGE_ONEXEC);
 		else if (strcmp(command, "stack") == 0)
@@ -724,13 +771,54 @@ static int apparmor_setprocattr(const char *name, void *value,
 
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
 
+static int apparmor_setselfattr(unsigned int attr, struct lsm_ctx __user *ctx,
+				size_t size, u32 flags)
+{
+	struct lsm_ctx *lctx;
+	int rc;
+
+	if (attr != LSM_ATTR_CURRENT && attr != LSM_ATTR_EXEC)
+		return -EOPNOTSUPP;
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
+		rc = do_setattr(attr, lctx->ctx, lctx->ctx_len);
+
+	kfree(lctx);
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
@@ -1253,6 +1341,8 @@ static struct security_hook_list apparmor_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(file_lock, apparmor_file_lock),
 	LSM_HOOK_INIT(file_truncate, apparmor_file_truncate),
 
+	LSM_HOOK_INIT(getselfattr, apparmor_getselfattr),
+	LSM_HOOK_INIT(setselfattr, apparmor_setselfattr),
 	LSM_HOOK_INIT(getprocattr, apparmor_getprocattr),
 	LSM_HOOK_INIT(setprocattr, apparmor_setprocattr),
 
diff --git a/security/apparmor/procattr.c b/security/apparmor/procattr.c
index 197d41f9c32b..e3857e3d7c6c 100644
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
@@ -57,11 +58,12 @@ int aa_getprocattr(struct aa_label *label, char **string)
 		return len;
 	}
 
-	(*string)[len] = '\n';
-	(*string)[len + 1] = 0;
+	if (newline)
+		(*string)[len++] = '\n';
+	(*string)[len] = 0;
 
 	aa_put_ns(current_ns);
-	return len + 1;
+	return len;
 }
 
 /**
-- 
2.40.1

