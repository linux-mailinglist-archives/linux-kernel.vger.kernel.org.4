Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3EE46F1F6C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 22:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346644AbjD1Uco (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 16:32:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346612AbjD1Ucl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 16:32:41 -0400
Received: from sonic305-28.consmr.mail.ne1.yahoo.com (sonic305-28.consmr.mail.ne1.yahoo.com [66.163.185.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BC1D5FD3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 13:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1682713906; bh=dk6nPx7KI0B1wBtWvhroENMmWyqVzdGGKnyis/dzhBg=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=PtSQtJCynqmoW1dol6eTria09gSA/FnJ8i/d1LL2un1x9L4tGAsxm5da8kb99JoRatvq/NP0pjXf4BrgANnke6YF7zPkSZB+4l5vr6hK6rsqMVNJ/tSdZoVu7yJey9avf6HcLi3d5qlwmiPE0kJHT2w7aSgL4TYm9TO7yo8rehnAz8y5mrxQjl1gscfGlW08pwMJ1JTccU8CIPhcobPSS5pfnySRaGHGX68h+yJU9169/B8736NwnTpkztPDqMHPQLJ8A/N+eCTWGNH6cL6poj1xXt+PUWvGsQuw8e+vZ5li9N8ivbgo9/sf6y539RAgYlLYTRY4GFB1Hw5qDovI4w==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1682713906; bh=aUZsnU74a0h3SsUmSxGAXkCwegxowrckFUVXcGW/J6a=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=krHcElWzIJlogd10VleMNhUwYauFH2yJ0HjFp0DS9JYQiYYaNb4ZQIyecRDUh3xk3/iwN8btgXngLpqsI3PdPg8iTxw2rPnI0f/I09ZH06SR9s/79YY4Uq5smEja1VYIMC5YsWfWI9DfroDZuvFnnZ7BjCNrKAIlpi8kqJaU1rXEmm14T0o/UtLJyh1Rb0Lko+PqDAMOAHgPMyXu9/cBhV4j7UpAjBICuMOPC5KHdghpG2q7Nw/bDdqBqA9GSR9So1g+5qWbhtCP8QLgQ7b9Cc8bEhMKEu6P7lQYseWq8h4A2sxweqT0699IfGep/Ltkp54BeGK5oiqnHgV//VPEVQ==
X-YMail-OSG: OWe0goQVM1mS95TTs0fOT4QL.hBSBawWqOCVczMEGWZGnUEXDT2CAAWJtXh_4_i
 iCHpevh0mG8cwnZe3wufN4H7hEYSiZtM.10szA2UJsrb.zgMDwI0lEbrkpJ8KL0OBsS42KhTcGI8
 3qcL817Si0DX5h92QuIUw.2NJdv.s0vXJxvtk__I.lj4x0UFaKNaBEyT5753t6hrPS6bgEm3DpMV
 b1j4tiNlMzwBrA0RAs_BjljJ56L_EHD.yFaLkfxDDLduL3I3eWDDWjWXYC5Yp63RPiE4Imh.YhDD
 muym5RbRvhF0kG1pb9qnN2rRcfbdFsuQd0OSJyK.7kNvlcsIac5qFXJKyls8aJaNS..mhBHgbGpP
 TsofPoZpPIVGva3wjmCsUHlMCCg9pq341ONa0LUMTwuoTirP9epXBDWEoJ7uzDRhtg1ovlkaQWOq
 nPMs0BS2HVX2Vt1EPG_7df5YnO7Jm.P0Y6oL2WHlNe4qZmPXUwIF.XDS1MtnQDal81lyfpPYD9GR
 _NR_T_faSFf8MNQSxPpMtpFIiJWbQ7GbpCuQLDzXbNholO_4ooCpGEINFhOJIPNsm09vC3Zd4U62
 nAWBLFvgsT.BplFXSi1VJUJh3dJhdnM_uh8WtVT737DF30t0jLFJa3BE8rXZ8Ez81lqHEwnnMGKn
 WLcs25Cymk4aXtKuy__AX7UPhKnN1KEF1KoTmiZaOOFEgCy.cQ0Q.KwcAm15MzetiXASx_t77Bqs
 hN6mWvRlNlTOp1m8cz2b1yl0Acxyv6rycxlNyu3ib0pp7uvIifVLNtgR4jmYVcIIgwVvs.RluF.f
 b_vKNIYY6ajhdW5xPmWTSEwJCPOAH7ByeVYPN5TvwrKbTqNUg5Q6IErTgrcBIwkdWZsEptF.nNFs
 Hwk33.2kmzEOtJ1C2lD0KM1eUpPOD3TWuvAZRIlbZaIhxD4HrvVL8YkbKg2SghjfcO99vJCO0nRD
 mOhjhkyBiEDnDUNSU7_2_OrZ7n2lk5a63w64JmRpgWNIJqp9qLvEIh3PcbtLOw8fOIDzZOFRKxDP
 a0.ReAQfOE1j3C3_5GsueGQbMe9d3p_nNHbG7uCXv669hVrkBVsPL0o9d9FeUTRsGuNIwVwLInLn
 j7clBCmKM1P94jP18glEcZAo.Qa5neJ5Q8liTSrNMPd25JinUXOcM7WneOVEMbDORNPvJQefKKJm
 AIkC88SonPPVxU4hpc5.SS5iaPanOAqemeSLLD7xT4TE_z9JO3pE.yF5Yl13OsjA2JIRNS8LQq_5
 h.5eKiN7PPr.6zmuQ2mFb8uv87F5ew7DcXibPGRf.LE_Kr5oq1LZe6GkouYULZod9kvy3Vjv8A2S
 7Qbr2wPo5ddpn_YghnCzYicqD9iCYi8t8.tR7UhDgzgiR4Buijx0q5Rxj0J3ReSDqod.9v8MUF09
 YlILmuVGyNjM_oM1F.t0gum8NSDb0sKbRg2zVVxg9DUTGv3UCAf434jMUb3BX_0qhy.NRtFJW4tz
 KjeHMTABzWOYhhYZFp3yhGg6aWvEHd3owhMHVQ1dC8wa4Undzcold5.kQZmjcyHl2i4jZb_H1KCD
 YkvpJ6K_VvD_vpyEKBDhKwVoUGPp95MalxQH7sIMY_Khe9I.lOd5k_4MNWMsdqN8AjeoCUQMqn2y
 XbZ_sQ.HdFglR80Hx4_GxymU5GDPnH9qbHaEf2euQ8YzjWLOJQ9imnly3mSnzHPAR3tlT5O0jBQb
 FVVbWVI74hX7pYjRbFQk5L3VHoRCnnNa6GnvKlFyZGWyftfaJHS0xl8b8YGu.bXRbUQa4UhdZAbD
 yGXR4Wu2PLF7k7beTRj9N_wbr9oIxmUdcqntZjhU3lvqE7OivVGUru9_ovIQembAWhmhRpUtd2oJ
 FsYgDvNlnZQZMvVPsVKCtWUw9oFnhj7sKWqwXW5LdEgnSvKg4Ivism9yFiQi4fyph09D0ppvfJUe
 HKoKdJeBsqOvO7Hmnig1hnH5bddMpOKniuIADuy7UDQWcS9JyBpwxjZTfdsreymAIHt1PvNKC.G2
 UMQI6BaZWTlpxJWwLbX5aYJhIajBixR52nlEdnWqc.QJtX9j1dvyUR9r435yKkuCFFM..qVfPZim
 wseO47uzEJ8YmTdibzQos_fkukmUTl2jWez9kikqY4FNe5ZIlI2egdAAyjOeerHySYYkG2WUu_UF
 gRQFXcoTLUvamN6nJ19JeWHgX9Je9qIt0yZJep8j7dQYKYteMgwfxyU7a3oKCizi7gIYdQqW0Ak5
 ISMg5pD.7ezUkdjagCuzwI7AIqEx1Rh8fJvuUMm245dFnpgkSVYF3G8BI9i1eZ2N3ZftkBOBHlDd
 M5izpT9GLGnM_T6CixvuR
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: e3a094f6-275f-4cc0-8cfd-3da99a302218
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.ne1.yahoo.com with HTTP; Fri, 28 Apr 2023 20:31:46 +0000
Received: by hermes--production-ne1-7dbd98dd99-nn8pc (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 8cc315084576b185b2e2f1400cc9c961;
          Fri, 28 Apr 2023 20:31:44 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey@schaufler-ca.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     jmorris@namei.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net
Subject: [PATCH v10 09/11] AppArmor: Add selfattr hooks
Date:   Fri, 28 Apr 2023 13:26:49 -0700
Message-Id: <20230428202651.159828-10-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230428202651.159828-1-casey@schaufler-ca.com>
References: <20230428202651.159828-1-casey@schaufler-ca.com>
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
index d7f22b0cf03f..6e77e885e167 100644
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
@@ -1253,6 +1341,8 @@ static struct security_hook_list apparmor_hooks[] __lsm_ro_after_init = {
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
2.39.2

