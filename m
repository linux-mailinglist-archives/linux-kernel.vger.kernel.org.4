Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5D766BC02C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 23:52:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232511AbjCOWwv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 18:52:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232481AbjCOWwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 18:52:49 -0400
Received: from sonic309-27.consmr.mail.ne1.yahoo.com (sonic309-27.consmr.mail.ne1.yahoo.com [66.163.184.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C38505AB74
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 15:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1678920722; bh=B09EiwchNV6YTvmCE/oHLsdbUhYDjx8mM9x6SbeTmaM=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=j8vj3AF1gHG4J2T7ssj6QyOSPAw58701NwOD5ZWRIrk7xTqjj7+tz7ubVxY9Dsw6iAM0a9uGGynpEDvz42B+LHt8JkKdAijGiXCz+f5HWwaQz8QRmqAqxiS/yfi1WrE2uEQTeU6E7wRteUJ9FTuZQQLb0HZ4XNIwxFYWwPUTrrJocFG84GLh7Mr8qszmQHx3/kwcwJkmw537EkiXUk2Wu5lCUvUx8g3YkFol1dIoWKJUQ/02dkyiDbUy3dmTHpa6hDhQPogklGMY0QvCDa++FBUcgOGVqIVR268wsrTF2Wx8Xj+Nubfh6YgLoD/q5RkO316Y85T+cdRqRAGCGY608Q==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1678920722; bh=fkLHABuAEr6vfNfQj2iRo1PVZfmesthOjcey3a+tbQ7=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=kA9lvIX2P4nQzmQJ+UwuHqGUkWSVJ9elCy4nMIV15r7h0Wke/hGv2y4fgpyz7lg+ar2TBcZAb9gmIPkqf+QQydXlDNLDUVOv0niRTVND2hNvbo95hSw1oeYE4nFCsb8wMlHllKJ/4DYP9Dq1czHjjVdZ6BnInZCZHRYSeq1lUDE0EZMzfQE2ir0l+oQAqyfee3QhvuuthXOM956PoAuJnhew5TiSBnO7rS91MVDcpqi0Gq0hQO8sNdI12kfRAizpfUhOWOhzqUGJPMUtJ/NQ3JLMGX6os7bQgqgVGHoQb0O27Ws64gWTEFtuZGz00hqOLf7yDJhOIk5OEWZgFo6RQA==
X-YMail-OSG: QkdYhKsVM1lKZrkUB8fRzKn7nLZicpkauiJjfCTPNcLJMdAmfqlEhmg5r1Qfvn.
 CCSG9BBL3nt8zvU.AqepJDsBYR33zcB5Tk5USfeTxvL8lgONvRA_HDDSpwUv5BepVHlJLUKpMdiS
 qE.6xGxIeU6oUykk_WYYwu.l8xsUQj68mRnCI92k8rHkF1meY9CpLZgT4GZ21M6Bc3.dTpyuf2dh
 tDkDlf_X2.zZ1_yAkn6SegE_77YRvikTySWm04zRukOdy1Nfixgw3fPRcdg96ZNxUwXM5WxCh6jD
 RiwqryNieuIXFrXWLAPSVoO4QS6pm5bb4_7z9GARFIvRRuTCUqjocSQdZprT_Xi3rySmILFS70HV
 lPkhrBqYwWgn_otzH8PNRU1pelNLjHE4w8EMze5xaMxz5stMYarBwESvLhywVxeqbeo7D7ODHyqh
 8wDww5nhNX.Ry3jBhYzk07q6MkUfaxzfZiTnRUH92FOvrlY.3htrGXm4BdQZV0BWLQy5XGGpChI6
 phuMHTg4aB09jpMaRNguC6c6UoiVIyqfHSzSQERc2L412pwj4Eafu75T7NuZqjW._fz4itBOfBsT
 Yj8f4Jd9CUq0sPgwrYhcIq8_Ek8p1x7nD10gQHOQvtHx7DBwG.2.JUfd_vsFL_bCePqvTbT3XJGQ
 M8Ch7vlsDDljPZMsUyNWCEZ9Uq5hTQZBzR5Sp8rYiGMY9Ig31HjPs8GIbs_pIfoMJh53ChWrP9xn
 BofE0sI_ct7LZMroAKN7fDce4uT2u.4rl.MrdT9Kk8XgkZ3gZPMYMEgueoseZ2g8TQRNAZC2umPd
 NFmSkuL.UdmrpkFDFAaP.gi7AT1Jy1TKLekWkM4Ud3R9AKhwYNFOJr4aZxzSODJVhN21xDmrk6By
 NOdsxeFj5lct6uY3nCCW6FWaYWvkboCPyLM.dxI91tzEpvT7e0mTsMMbGkd4rUO5Ee8Cx3PagPc3
 sZc3H5DgVON3VKf0NJsfETZfDGz3COe5m639ZDMT.URr3HA0cJQuTkkynlLrUaULc0QhRTouhGS4
 .JPd6hHaaoK1HxzaU0GYwvNq63kNgyH1pzZf.t4WofZyzG18dMGxWpzsrbkul2jcOhIJhnEwSSN9
 hEcwVRIaGoEpXZai60Vbh2Sag7.Im9u2ni3U_.1mMDLW6HdqcMaPTAJlhR9anGZgju.XxDUldJ0C
 EmJTBgMC55HLQ.i08FAXS7d9UI4ygwX_XO_0lkfIRCm5f1c3F1E9TgoxnWL4cjaFLMtD1DBGwsng
 CpSdHQ8voF7cwLOT_TVTKx5aTo0tUhTTEy2iDNbw5utjpLt2KLJomKrlVSrLlp60k_2.AkCPCR1y
 Hs8miTzS0efJn.It8OOC0VuONOAui4tfEeNV1QgyUCC3wlvESutYHVbizdQNl03jZLf8D8TUax_0
 jfkv5Es6vHBmMXp7gS85fI0oNzU._lmyAcPdIzzkKEU6B7ztDUyMLquN46nxf4NgZwhQZk9QIqoW
 YYBUJQwHtq5W10PkgIiAqulofIvGP69MTfxjmQWjoXHQ1XOwHsd_aKSKAxly7akA0Hpvl8T6L8__
 r3.QcfIcAIAfNMwkpTAO8tpGKpAihzv3U7kM3EEIPYCDryS9g8bp4h18EQQ0oVz2lxDA5gvAIFxF
 l8f7iILxUqp.a9M_gEHm0fGIJ57Rid6BN9bF8lysRSIyLwfYdgFi9fF.d3chPuSjztLM7_dZnw1B
 eFJ_9IjcrRnfYnHnoGYGZo8kFpRx6AGfGQ1ztXe6o_5d.GeZ8s9.n26nYo0jlt6GCB7px4UBqjLQ
 tw7TxO1.iLExi_Wlyky4wYuHPh1mqjCtEWjr01BZ7wQ.P03G9JbG0nWLGRzsBxzpLsU2En4GB97L
 JQN1AYfJgaoS6LZXF7kmifTtKVewoV6gJi4fE8iUq6E2JhqJoVRFkEBDgpQbt7O_0cJ05JemQwh5
 0dGRpahh64kLLkZpAdoFuU3.cTp8o0lDGCrr.CROuz5pP0dXRNfMiArdwaaj_VbtOVc9PEIi2Pmm
 XnZarHSgmJpFlHYSnT1FZYRR4G82UZhUeQwmop9hfA.m4vfoDm_LRLejEzYIJsEuZyiobYzNNtuN
 6vQmrug21QVm0dBrlQibFyfC9trUfTn.2I3.H_FL5q9.FRG4.j6aXFTZ_Rtbi4gEgTvCVucXFOvW
 XNixdRpE_WMYw6Qeb6v9OVw5Pr_lgpDMRnhuiIOUCsL8HGSLfnaee8hXn6uB0_8cLPJdM9_LueGJ
 M7GzpIeHPSYjkG6LzWpXFz9mRw9OFBMCcjilGw72ce0ca5yNZ9v3cnQGXbwLVYEWDlLn9RbF2oOC
 ZURFzuozZpD6e_kMNuZU-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: b01352bf-ca7c-4695-9c4b-10a0b96c7307
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Wed, 15 Mar 2023 22:52:02 +0000
Received: by hermes--production-ne1-759c9b8c64-2fnfh (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 3519737f64e89c1a78f5fee6524d3fd8;
          Wed, 15 Mar 2023 22:51:59 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey@schaufler-ca.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     jmorris@namei.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net
Subject: [PATCH v7 09/11] AppArmor: Add selfattr hooks
Date:   Wed, 15 Mar 2023 15:47:02 -0700
Message-Id: <20230315224704.2672-10-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230315224704.2672-1-casey@schaufler-ca.com>
References: <20230315224704.2672-1-casey@schaufler-ca.com>
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
index ce6ccb7e06ec..89ee9d71791c 100644
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
+		return 0;
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

