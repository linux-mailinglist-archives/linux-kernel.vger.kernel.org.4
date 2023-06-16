Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF4E17336E4
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 18:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346061AbjFPQ6E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 12:58:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343977AbjFPQ5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 12:57:43 -0400
Received: from sonic314-26.consmr.mail.ne1.yahoo.com (sonic314-26.consmr.mail.ne1.yahoo.com [66.163.189.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C66504686
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 09:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1686934557; bh=FecLkrXox/1UtDMuj0YVSfxHtwMaEWW93HEIoUhvMVY=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=mmcZRF9YZI5VEGmyO+WaQtwlK2OyGjkLIM26SassX5sxpO+zIysBnWJsBcuSYNsDU5t3rim6GporegVy+qJE6P0QhU0i6wMK51jN+0+UO54ulOolL6j0MPNVhUrlpxZYpCK8zvW59a69yFvOk9HxITUMdVvoqy9+k9YixAyb0VHY9kE3aT70tXS+sOr0fAZZmNVFeD7ugtxk0tfH3eu3JXJ1e8CHtT5UAq/72ia3VnNAO6W5vY/G+1SSR82CjIo02ChYA85TMuIZcXN1W4z5zYnGN5AFfu0K3BY85PbL2J70VPosUvTaNrpduquSmjHR1tOXlkyWPj35rglEgUSe8Q==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1686934557; bh=6Nx1q2xRMO4tClgtvSWM7k/rLC7lQYxo8ewBA6OtKZa=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=GHN3JEjOi9UkqQpjF9PRqVzd+1M0++c6yMIfLp62iLZXlA4AkoRuEpbsL/00O//x4SNAfuDSFZNeO7E9kcNeRTKwSbVs+MshKQbhXQUXn/qzPBvWtZKzlRmbJctA1KI12vKWdga2dHTIVRmkAKfCOUqRO7o+DFA/rkwti6VGkRLZDmWyIsXEOLe7S+3bBQrHNk9PRKAf0luviqRXgc4Mpwy0t51IX2ueAJcA8uQt0n8e3FGT6NKjH8Qm3rnzSBcvkQr0V50vV+kdQyl6ihUueX9zXEj853ykLloWr/GIulojUt7hh2C7qQWWeQirZrmuQ4OXjkWlFAFRWafgjQUk8w==
X-YMail-OSG: vYKTuTwVM1lL2xcygy9G9Z2GOhN_5cGkZ6.mumUfAr.yTfF.yx5XXY70jlb3Otg
 vjgocsbEkU7BxbWhh1abOLpCPmQhACN4NbyIcLYaFHX.AXHTbLkojBcr1lu6zaElqiOBmlkJlJpp
 qSu6S0fn_2rBo8TgsyT30ejZQfOXXygj2.yMXrzMUPPj3u7l0VUjJyRkfNhFcrSAQ1exLrjhZ_wv
 EIzIuVMChUtq_RB5_.aphwjGUeAyJaQIHLki5r3jQ1AkbVrpszJ8KXMRpa24iMRu48NfH82C2sAO
 nOh8SdKA7EgKznBRFKJr_IgKBGG0FsRuF7EqbYWW4KeWy4g5B76w2.1AW0FRYrX.0Af7k2WqLQg7
 g6X_gSJoC9YoMEbUcnpt70i0K7rsTTia4dZSMurwSEQRRVzo6tqIbbF6xcHoCldkUBj7g47bFa2F
 R7xgcXgRNJjI05eXtWmPBnYZn2a8atTOtJVY7X_LZDVGplF1zTJz7GdNjo.398GIJhwEzeq8LDm.
 qicX949XJyjZTwIbjUz_khiFw0cm9yCXHDkqDEKDdnVGqIsa0gsfV6snsWxnDLuScXLEHOxT0WpC
 6tYhDLIdW4QUrvE8a8.5ojHwLTVtGzLPcxv6py5Vg8SoKfQTHyv7X1pWMTO3Ko3rwGyxK9wqkFwh
 rnh6eMtJu4McopSic5aUD3RlFFL_sYD3NSxwCpJkR21tgD2SfeSyiWzX9eR0JTBU3VSbYI98f_Rc
 adBGNIzaHPlYTu1yeZjTTG8MXSRhyqSwlKlg1J5.pZMqCGTmrieTv3WWz0id0QyI1yixtwhNNjhm
 v3vUemyKLBTmxhMilQQNsF_LTiWCC.Afzeo1QBRc.IRet.CVguXWhvWFHcdiM_5T86.wAjxnc1TX
 aoPi.c_LEUOF1k43HfJnbjpLSoU2pj11leb7bZwSPbXWddqTtEhMdIFVbZl4R2pzmfFkvGVPS5Py
 L8k5LcrSzZqrDQfcQm77hmvClBIxkM19KX1sXmfIGsmbIaVqzFvAdxAlW2oA.2e_3JiW2PBsXMXc
 fuMG_Bp_p7ryYfQftfcirt1.61mKGgv9uzy_n4BG9xvPPBnTVBPYRFHyCV7yETe960kB9HSW6Z24
 ajq8oolhokBPzxYU8O0UpsNb.vH0x5ncBrBb4prvFw7sl7drVW7dn2H6.cfWQZIl5aMV9d4HnMKe
 vvNN_aq.mk0bS7VK0uXmARykMi9MKPXnHlaaDDewOddQrLM1sRD6LLoGowTrZOhr_MEKVtTYHa9P
 Hwyx7O0VGrd720QeRcpO7TQ4tQrgzhRKf8dWZjTFQSPkRdKNrW3VfGEk6WDJQ4apBPsV4JCJtrv1
 lwfo.jHW4wfLja.4YwagGzFnAPMpEnAANfPOQ_d7rJ8IYtNAZrvb0TmwNxJD9q4FMSZa9Op61xU.
 13Q5hMTXfxoSXyA.cdFBodTpy4G84lf7JipeHO6DrhdzIKvZFnnqnc3swRQFtZ4lVdVdfseH7WLZ
 0M_2aka7kUX5soxOqanZXuUIpVC_Osd7mxm4dbw3rQsbPp_3khSNDX2n7LveeUIQ.r7t74La3cgp
 rRrXDnW2w.b6tkAUUIDESpZMsmUeMZo2nxWpc0JpSHdkA3l0ko7A4Ur9MxIZzDEQv.jUyu7T39Wv
 MS_mwu7Eg8O2GDS3zVsE4r9TcJGloucsGufpDXxk79Cf7ULqpv33e_XfpKCRS5N.rjyS_AOgv9d8
 zoKabaEkypFhmQQ7cB8s2Xaz3_U4rDQwVVrIeDAEZMZFHJpnFkQRm3I_rL1_V8aDFzUn.6t_d70A
 LqjOfLc29yaaz5hKL3qRmnFs0nawaaX74mJSdbZ2M2tBFg3uNhpydd1HE3n0fKx4Eggl9JiHnaFq
 MhZ1ljwf0D4AoHWecphe5DXDTiSjFHe3sWsL3Fxxoe.VjLOyoqcA1v0JkEFcabvntfv8c3i8W_GV
 2GuwuOs._T4Wj53mT8nUWyXqNuo70mNR.QR_X8PASFQb2aGBojwLqeyA6NdIY09k.eiPmtEvzsCI
 JTWa52dtKt.g_fJSr8WP1dITBEr1hO49WA5q2miMN99QG0MMiJEq3iQp1eIWjh6ZJsdecE2PzyC1
 W01qX1Rc2Moom_JJinfgE6YMjeXO7leM2dYASSRZIc7q0FFrycPWxTFbNuUwzsYEefdicyENZtwO
 vVrLZRRCQ6PNNMl7n4t_eGeGsa5rsbv_lN_KXQHs.Ogmvzg01J22Ob0ycEaC8Dzh38BQV9cV164I
 bydt8zOU6B40Op8yjGQeoV1CW2Yx96EA7m3KtkAQDpsEnDO1Hzm_ksxoKZCl.DVGzEqaE5qlxSeA
 NM5aX_WMtkG7JUr_3sqvcTBOqtg--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 01e9bdaa-6fbc-4341-9811-8352d54af609
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.ne1.yahoo.com with HTTP; Fri, 16 Jun 2023 16:55:57 +0000
Received: by hermes--production-ne1-574d4b7954-tvjss (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 8aab4ebac04292db835fd6d81244177c;
          Fri, 16 Jun 2023 16:55:52 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey@schaufler-ca.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net
Subject: [PATCH v11 09/11] AppArmor: Add selfattr hooks
Date:   Fri, 16 Jun 2023 09:50:53 -0700
Message-Id: <20230616165055.4705-10-casey@schaufler-ca.com>
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

