Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6F486F1F96
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 22:39:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346664AbjD1UjS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 16:39:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbjD1UjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 16:39:15 -0400
Received: from sonic305-28.consmr.mail.ne1.yahoo.com (sonic305-28.consmr.mail.ne1.yahoo.com [66.163.185.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE16E2703
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 13:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1682714352; bh=dk6nPx7KI0B1wBtWvhroENMmWyqVzdGGKnyis/dzhBg=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=QPrkQ/USPqIEa2AdPgfojFzATG0Mlul8DJUlXTq/pXn2xGWsgVvWT60JXAlzEJLij4WjYbF2o9P5Bab02qGlTV2OnHTaqIm+N5/+ZgQVAyM9GUlKDhwRTOwYwkYfwvY8C8nyaq/YQ+YycrvePsmnN10y9hliuTOrwSF0xaGk4prXKi498Xb7vIFHwNdONniDk2p9sRTq8RYmywMWJQ659VFtKmfW9pQvrMpe5157xC2oW2ua0FD5jTDzefePlqJlV+YLMxXwKJPEt53u0RgEdry7Qb8mcXglZ2Zq2A68uzVy9WKSkRNjLetUxGdbolQ/jdpDQkfmfzre1C3D6vbpwA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1682714352; bh=tTQ40JbD3iLZfr9Yuei9ZDAV8Zlq+lPRYigpKnhP83P=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=qSLAOvRbHftbubbqcbTalmThuamcQD3VTpT0RlGKlkftqUF7eeF9UfbVv1XBltP7QK53qTkhgLCLgbkUC7SUbcxApleQmNi0bpGPHbIgm+YHtYWelOxwEFXmGdW/kvdeL0A1/0lwKk8ZCOkDEMNtWyms5rTNP+vPMPCyQU8I+ok2kcoUluKVmS+ubL7CBfk5tm35UkN5hfQa1tJZQ/7C39E19sANlNdBvOcVlPOnNPKZVWkp8lO5NYmnVXz/0sSrlnG9NZrBor1DgX4IvwpPZyZATF46noBMVWOUiyqJ94FAFBPfPtQHeQf0DzbfbcdDwqDLW3mdWf4OiwUddPCYRw==
X-YMail-OSG: M88q05kVM1lo22HKu9MDCxz6FXEhgKSEkzNPPCRxUw1p2SihmatKAGHepkxu.Ln
 Z27tRqvyXjPvciM4UELSl60DUbziz9P8G4cQz8WqZM42F8nXiK5kOg8iwTby_qe1AgOm7dAwhNQC
 XE5FzCNeUm5r0LI756AMueAYUPI5lCAnTih.ph4bGQjpE_zcmvcDT6xwZhsnuQJxdYE6bQk2oTPU
 jTftpgYTz_ZgCd3iA4BSvZ0QOUOajvRusOU1U.6xIGiUV1VAnNRtD9u30TwKNNwMuNHf3nMYGg85
 Wo0ESSvRx61zYDD9cFlLUlnoTtUVxvhW08P.aw45dzH4_.in6gvhs2XIld75szT6yw8UzIetu_oD
 UQ8T8RGiHCxxL3S8Duxy5oJJl3fBpH_toxkCGPE6W3bNx8pxa6YvxwQSCpdlBN8QR41kmKVHUYcE
 eGNVSvCDRcLKYUFD.cjIogy_yWKD4tO3zHfdXUmX2TWs_lM_gI_BFBBV7g3rAeI181Jdy69uif3w
 czczrPEa3t0LFARbK0yRt2LyF1ZHHqxYc8GEZlAK_8_Uq_B.u1qSFSRTTSTXqyDVZY97l9pt1WX.
 Z6Kj94pJdpwVSUgnG9Fz0UHhO2hzrNaCnfX6blx.FyDwj1B1TOC3jejieW_SsCpJJYuYJvUclxIE
 _URSwd9ZyyHamIrDiFCzB6kd2y_Vah5AlNY4JFCnJbj1O6M6Gh7WT.En57N1rBWL346BFI8sQFkA
 ArJ8jPg48iJvzr9yH6F.DIcOsWZbahy0gCsk1_gucLnUBUPrjR5IwK92KACbUNDAGCm6Bb7MnqSb
 KUvG0S4gACcwQlHgV6ubQOKi9cKnG78lGH5jt5Nys3p5Utd3MYGzXJFAHHSo2g1LXI0Azqcs8ghP
 ZT5_XORpJ2uJv0xZxhhBljLNHdtzkluPeaw.wlvFW1sXlhsmFHdjC0pjLkb8RRjDJE5YbCNjz0y_
 BvAOsDhf4fmxyyvazrxNoTKqokn7URiXbYprM5mr1vRetAqE84agBvA9j_F9QIr9HhzGEyaX0Yy9
 HnQCrB5WYf6v6O2uh3YbgyNOEUX0VsHyu5ZQJ7iJ28Mdl_hTMxOPVkXr82t6Ic8BsioMhsy4eeQR
 2TS8co_e8hyrT61Ykf3vUHQ4AFz1Xd0ZYgbTrVkdsUcisqz.BOaIKNQNNuXtmKNzTyIbApvbzRW3
 iqt9kN5wVASVvqgrAA0rO9KDXtSG.LQtaWYanVkfCDfraWV0UzVh10vk3kdUYG4KRqwf6jrjyP23
 9ElqHuKm3QnaGPJLJzG.GQ9jPrm4LYb6FmNYKjFDCj9JbPa73EUexPbNl6r3f8yWIjHhxywv3w5W
 O_3qDSvTfKemtg9xusviqRLaLXVQZ6v3WGlT0wn4dxqAnU6Ssg9VEkd9rE5Ug8dIkwbHTjyaivgb
 LOozOwVUIObEY5_fp5fTlcpxdZd4If_hdb3MVisYc2EL7hjgUjSIFTm.Qb8doW3dWeBHhy8qJOlu
 fpEMCSq0cyOX0xYbKPTelYPaOgzCuy58m2gqKBocI1RbWnnugEU7xSbx9HlzkXiqaSunGsh9V29y
 23CDh5iQro_hVR6MeBpDU84ViF8_0ifQZtIYgEyKJ86N0Szon0lU8IZfYXl4GH.O4lxf3au4hMz8
 11ave0wOl4h5GzTjKhleKNCUd3CJsN_U4LCIL80nXjpuT6vaEcyNqwzU73jQgBx671OLW7I.XfYt
 W6uIA5fG6GqhN9imbHDPnU3D82oa.JKcfmU7M4LPDqioz1mJGSB1z9YRmbmVEvLVDnDvp2awNe3O
 Dzocy3hXdixLGZbolypAlo074twZbpto54LmNlCu53zwX9Wv.Ny5T_eoxbxhpjZ4DST37ciP4oqt
 QeRq_sjPGlDoqHZYtJWu3SV0Qo8v_jbgTsKMrhoc4A1x6S_f2BkilU5tDN.siTGrCFo1Tk0IZwl1
 LJc2JvAHkhuFQmJbJO87TR64sq.MbAkuq3LnJ_cwTtnK8n4jTqzHx44itYLmQy7l6NIUOEfKpXsA
 d4q0D3CPpz3dFCSywshMkk3ahQ7sI2p0c1DO0_q57OE0ZIQzbFo8I.GHLVo8nvOMntKuPFkElpww
 cnqtTcFjo7eWWreVVhHsu7wuQuw1N64JiH3t0WG1hLdhWBPYFzI5.kLPoCxrOx_ash2EXDIZlBc2
 GoQV48f.ZQCy03_Zb8Yk85qs25J8cc8EgqEtdgfzKXq4E1UQGeXDf5DqSVH8twhKu0Q.rrM7Qs84
 mK_S4Dvx6coZn.nlqdx2kObg1GmqCRYuhdlP.z36eL20eGVuiSCs.J39Ti1WyJsX2SanLUdGpxXX
 ueE.K9RSPul0lNFj7fwKaU5eXt.6h.w--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: aeb9c94c-1fad-4ece-866b-a9200b180153
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.ne1.yahoo.com with HTTP; Fri, 28 Apr 2023 20:39:12 +0000
Received: by hermes--production-bf1-5f9df5c5c4-wvm2h (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 7872f02abf9ba03acc5bf1902aa8c755;
          Fri, 28 Apr 2023 20:39:08 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey@schaufler-ca.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     jmorris@namei.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net
Subject: [PATCH v10 09/11] AppArmor: Add selfattr hooks
Date:   Fri, 28 Apr 2023 13:34:15 -0700
Message-Id: <20230428203417.159874-10-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230428203417.159874-1-casey@schaufler-ca.com>
References: <20230428203417.159874-1-casey@schaufler-ca.com>
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

