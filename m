Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 218356DE06B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 18:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbjDKQFE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 12:05:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbjDKQEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 12:04:54 -0400
Received: from sonic310-30.consmr.mail.ne1.yahoo.com (sonic310-30.consmr.mail.ne1.yahoo.com [66.163.186.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED4875BBA
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 09:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1681229062; bh=5cndsL/h+/3U/Q0ql7j5W14e1wNptrEJlKAKU6QpGOQ=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=ReddnUZFXbAZGwEs9jeiU17PnxbeQsF03lIAXgqTXOIy+Q6M1gGEKdRpBx3sSwFDVCLgGzjvDxik//iQQSzqKH1cVQC8Z3tr3C8eUBDPKVqj9yA4DiMPL542BTN+se5KDJih5tWpH0d74rw6VQu/qP4aAiAq5yYcxBaQ1/6BcuYoYJjUkxPwe47q5wUSDLF/XDAzXgnR4IAKyLT8gx4zQ5QNGEOBZxdFGXz2USKs37yPVneLDELrw1Rt9wGyOBz6mC2p1uQS+ACdvPolGvuSHJmVTD0r2lTuzXAdmOixFNQENVrvk4qlPmbnezfah9YuSxjHt2e+Y61XYjc470HxZw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1681229062; bh=RxdOnSSu18EZ+TNyMdTtQOxhQ3YiHM0M3ddio2NPqU8=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=hC6hrFr/3RG0ODtlpl/W4GWMVdVJ04oMTVnUb5HXF5fT1u198mFxy+q5O7LJ/olPB6BFoemNTSlQDR2IN28+CUUp2yhn9sfz70ZQ7k6wcrPPLpzzHvJwhVMLqgpKh2pjJpT4w3Hv4l0jZQy0jw2LM3fe0Me+vFesJ7V5P7BmkN12wekBvgVN7r5obn00KkdKGxi3jC4zBvH7xDBq+OLNN/XhAzL4JkwWudyF9iwOs3mwDGwO9cC9jAymcQKK521eYsMXP+ykzKZbmmC427mi3gKanEFMV2pEHFfYzbIpm6XyQxWlUb3C7YlC4+62QBg6qffAq+BhI50ILHLZOag/Rw==
X-YMail-OSG: tmqrSYYVM1lx4t0u5d9IHUjZqmDBPBaYB6l80LbAQvCeUM4.oY.6DefbqY9zArS
 kfHpw73rVDkWqhntSKUoHXUy1xzNas6Ufs0ppVohGgfy6G48b3ggOeDt9mXpm6ZlU9EJ_zRYz9Jz
 hs5yHRcOc2veGbd0eDTKN0PiNRZ_oInK4R4He8xDWdJlS4WPgklPIF2xn5rBVTFXdEHWuU6YDiNF
 o1DPOo1YsRCvYLB.2dsbjyiI2xcWa9qU729rYPAnwqUVLqnonXMuNhh.LZO2M9Dc0vclbZs_5gQ_
 pUEbRSSbTCCE4qjRus_V11CKgGSXEyy1byeISNpPvPKn6UPlGKwEHc.0zdpD5D0GBcqvsVxKBm2u
 NDwGwf2qkVIKZgRXi59j8p7d_ZnkhVWi38GeNpa8TSMKTeomiFX7_fIVuupgoHafy2RXkzz3E8Ob
 cyk3heE123Hlxe7J4Ql2gLT8b.JICgpInEoZB_e6xnsBD4TxSzK8tsav8lBL7hA_2jh32cSqZoFZ
 Tzb7NMCt4aYlWQKe0DZetF8g7vcjL56ThJ9Yitohc6iMMw2YRbX7PYuUFMonx74sWXhyJ2Dc3jHE
 ZammvTwIjHsGwL3qRb55xZfEbEUcAarE3f_k3KSM.BQmZaWfBMxLrTFx42R.DOmJFc3A9FI98W0E
 Pfc6DGn4bas0tOnuda4X3.XWWaOWSGqoNvgh8N7uRJ.Dg1MyecWQE5ixfnGfHHdWp.Fqq1yunw0v
 v.gtMkEKNkMEY9GAgB0S4QVoIpIWP8.fRrEWFwh_duIy4fiB0yPgi4qKa.vsWHiHuNlgwiB9J5MO
 jTYWjmMVsL3gJIJGSaS4nKN1asVs471Po_7QCXddfflkmyLL6n4SE.Cifg_6QGOL4DxS17Mn7qjC
 NDiAkhoofkciW2C29wkkhOJz7suk.RQF3T6zclMWfqjp10WFG5UA1bZAYWkj59RhaETP12gC7TzY
 qH5XAh_fAL2Qmkgja78XgBIH7RAscWoTHrwZQsUbsfwuSmxNyajduiyaKEIYOjS.CQwa7Epevewo
 Xd_maEvWPrwOBTh7Ert5atAG4gGmkSbTe3sjBhqpc6ZpZ8oDDMaF6A319MuVTW0ZvB9tN1VqUyuE
 8lxFPLaf3bl9apv5580s5pkU9X3C39sqbbzKTZKVGHY9iuP.R4fwKTPPTphUhbWwxHOpCHvNoyIq
 xGbVdYsOzng2xSeLPJakRJvpC2LGym_6MLENy0Z2GHzSxUOkTGRQwHoIQhz5HUvepNB5u0DDF8Mp
 hsJ2XjXLNgvxG2LvIf5..aN2JwHO2ZT0mLva1V80D2DBRYR7VfK7u4qmTEFjSpY6HjEyM5wMF_1B
 TcvQj6NCuFIhefz5J350ole9v2yVuV6N4r5OJOtK01gjTePb2EBhylNd.xo6vHWlFEtdcbvrBhfB
 M9VFlPbpxbx2GdoYWujpY66pcXZH1LXqMyL72QZbpvlWy8K3TIExebzjBKIfS_5J4dz6UHYN8pKl
 bvGKvyKRDj3k6BDZNp1M6WOfIGJqFX_fAUrNHjbhCJYKAvRcY6TWB5JDu_V5ZBslMQreH8OXdU4d
 8Z5HxfPOvu8tO_eQr88A5qOQVA8nVMF8e7fS4pvm.2Jz0UJ0X_9mRZdn16MZ57696WncLkbzFr4L
 Fd4H0pHvducFWnQA65z9NFKBehnqsNOOcBq7zlCAWE.yP1tKVks89bNc1_BiaqVBcbs4Dazjmqu2
 p.oNedRb2l2IsSpaiobfXPiSqaRM5Ev6OebEFk62stUSQ_91jjAJpTgKvGoKYt6P.IQQYrGxsk8s
 sCkJjidDvBza62nnH.I0Hw.WrhJ54YYMH53b7MDbYRvsUBNxCNqtHl9DxIl9OU4h.QNId.WcAti3
 lHNvgfxrzMctGwuoSqGTltcOGUQkToQ57ENBaosM_3FNRqYzJ8qO5zid3wIP1PSWO4ySH3iQ5mOJ
 8S5SqKhXg5sdG2H.kJ_.6ao.5qSkggCoZI0QuTAGXtuZRGQDfrDq_0kNRDqC8NDWGojy1oxOjiKx
 9l9XGVPQSgWqjiDFEL0.aZeWCgsjG4KcXUvuT.b3lKcSUXZx9nh1L6HkRJF6SabMx8EcjPKxrGXH
 38uJX8KEJdINqE3WdMwlm0kXcbE7cK3m0PipG01TVCjTTMuoy.ZycOE7DzplnGHo6k2XfW6f_v17
 dcNWcTX6dPJ4C9sovCY6.q1cppSSPC6N6jYst90OOEIGVvTg2Y64fJQu5s05RzxDlUROTO4ZPRJL
 QiL6oIbf.t8P.SqBq0JYoWpCzUxWuq0DYKbV.1R6LKPMSMJiJBhUhGzwaUlOz_UcyY82ZAaz1Hzx
 aLZ3IEl7dmXrI1yReM_fR
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 9d5435b2-197f-4d3f-ac90-8c1e432da217
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ne1.yahoo.com with HTTP; Tue, 11 Apr 2023 16:04:22 +0000
Received: by hermes--production-ne1-7dbd98dd99-vd22t (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 8ad5be559bf25ba1172230271ff09c70;
          Tue, 11 Apr 2023 16:04:18 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey@schaufler-ca.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     jmorris@namei.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net
Subject: [PATCH v8 09/11] AppArmor: Add selfattr hooks
Date:   Tue, 11 Apr 2023 08:59:19 -0700
Message-Id: <20230411155921.14716-10-casey@schaufler-ca.com>
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
Cc: John Johansen <john.johansen@canonical.com>
---
 security/apparmor/include/procattr.h |  2 +-
 security/apparmor/lsm.c              | 96 ++++++++++++++++++++++++++--
 security/apparmor/procattr.c         | 11 +++-
 3 files changed, 99 insertions(+), 10 deletions(-)

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
index ce6ccb7e06ec..16ae61cec26a 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -630,6 +630,45 @@ static int apparmor_sb_pivotroot(const struct path *old_path,
 	return error;
 }
 
+static int apparmor_getselfattr(unsigned int __user attr,
+				struct lsm_ctx __user *lx, size_t *size,
+				u32 __user flags)
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
+		return 1;
+	return error;
+}
+
 static int apparmor_getprocattr(struct task_struct *task, const char *name,
 				char **value)
 {
@@ -649,7 +688,7 @@ static int apparmor_getprocattr(struct task_struct *task, const char *name,
 		error = -EINVAL;
 
 	if (label)
-		error = aa_getprocattr(label, value);
+		error = aa_getprocattr(label, value, true);
 
 	aa_put_label(label);
 	put_cred(cred);
@@ -657,8 +696,7 @@ static int apparmor_getprocattr(struct task_struct *task, const char *name,
 	return error;
 }
 
-static int apparmor_setprocattr(const char *name, void *value,
-				size_t size)
+static int do_setattr(u64 attr, void *value, size_t size)
 {
 	char *command, *largs = NULL, *args = value;
 	size_t arg_size;
@@ -689,7 +727,7 @@ static int apparmor_setprocattr(const char *name, void *value,
 		goto out;
 
 	arg_size = size - (args - (largs ? largs : (char *) value));
-	if (strcmp(name, "current") == 0) {
+	if (attr == LSM_ATTR_CURRENT) {
 		if (strcmp(command, "changehat") == 0) {
 			error = aa_setprocattr_changehat(args, arg_size,
 							 AA_CHANGE_NOFLAGS);
@@ -704,7 +742,7 @@ static int apparmor_setprocattr(const char *name, void *value,
 			error = aa_change_profile(args, AA_CHANGE_STACK);
 		} else
 			goto fail;
-	} else if (strcmp(name, "exec") == 0) {
+	} else if (attr == LSM_ATTR_EXEC) {
 		if (strcmp(command, "exec") == 0)
 			error = aa_change_profile(args, AA_CHANGE_ONEXEC);
 		else if (strcmp(command, "stack") == 0)
@@ -724,13 +762,57 @@ static int apparmor_setprocattr(const char *name, void *value,
 
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
 
+static int apparmor_setselfattr(unsigned int __user attr,
+				struct lsm_ctx __user *ctx, size_t __user size,
+				u32 __user flags)
+{
+	struct lsm_ctx *lctx;
+	void *context;
+	int rc;
+
+	if (attr != LSM_ATTR_CURRENT && attr != LSM_ATTR_EXEC)
+		return -EOPNOTSUPP;
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
@@ -1253,6 +1335,8 @@ static struct security_hook_list apparmor_hooks[] __lsm_ro_after_init = {
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
2.39.2

