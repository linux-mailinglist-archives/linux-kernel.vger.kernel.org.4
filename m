Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE836EB11C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 19:49:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233459AbjDURsr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 13:48:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233265AbjDURsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 13:48:38 -0400
Received: from sonic307-15.consmr.mail.ne1.yahoo.com (sonic307-15.consmr.mail.ne1.yahoo.com [66.163.190.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E686149F4
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 10:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1682099284; bh=KMOzWG/bqXp9n4/eGVrKOVZpR9IkQ7uUdoGQbFvv8Ik=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=udMXp8GP7mmHvA2Eb6E9iu2hynZCKHmRgS515k5sMBMLQafLwehTY/NjN105+Mi1UQBO/oS+Q26yuvMRVAEGmDPz9dveRaLbcl7qBI26FcYzFEzpvvy2AgLFsoVAiCnaOb4m22dIVt2SNuDHbVtzPClKtWI7VTbQ9eAKVc+sDchKgW5a+XCPEiIJhN0151cJJj7OPakPxTUHiHvdLCklxFg+pZWC2JK1C6vLQaAvDH0cdtDZkxci2N8x0rEjm6h1hbjQyW1gPhY8DN6JPD1cpofrUYN0E3ZRHzHLnUzdzT9Kp9w/Jg+gxsumXizoySwCJVu/vtYNn41rqYYmt5W2/Q==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1682099284; bh=aLQR0ujlGxqCeoxSVa2tPSpYF+YQP4IYmTp5DYLrMBC=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=LbMWR2aKHjb5weqlnB5z2Q/VVBCBLUWA7bh0/4NDv2EBgkAoOAMaWjY43fDj/SdrJoJT6HjwSAVejKMZt0TVPdaHAIxyK0/ihrp8w7qJKcTKDC5dnMpvc0eylsNIbXHPf1Xqeio4OVaTwXewdMeOktqVnnNz6Me0VWX57MdGuOiz7TDQ6z19oPbMl9b0fUInyw87T+Q55vSyoOdExNwLzJAsNLoOpPTwWzH249pA/mAyD9sxtiw4+JnLf1FqadG58zM+p4mznUPfBv0jZ6NiOckiHKlHCAj+Z+HNtHUjlW2hCnhAxLOQ6NPfwQeNisZ9BV1uOZvqYcGCnmUHVo7Gsg==
X-YMail-OSG: TrbbvdsVM1nqZD2VCrgKCmLaD9KctojvCpmQLRIOEzR3KCUTzu9dnBRMDY0J4xk
 9cTBjosEug17oZHA7h2xT8f7OjUxVLiRYNbe3EcHRL56iJhE.IjWGF0LXSb7Yp8Tcy1Uo2N8mowJ
 wc0AFYMg0FTtSxG54Ubx1UuX0k51pC2Ck8wpAfhwcOhmELWggphXvGUB67k_Outj.Y0NNUy0LM8H
 qK9M6nbWyZdnUpTwVbsLlQFOcqfV91G2G5cl.3b2OlZ488VFI8iNbfom3YRV7MWgIySxJlQc.4SL
 bZBIKGAGIORBRKpnooWFzELFnqSGRqBSq2vRIocYLrNv7RhnyKfmOFneRbShgd..jShBQnr3XeCA
 jzUAw68e4tgsj7.YfFHBv9TcmoRkakVKCCWhq13460VCarGknG5dPZphntYcjpGa9AulLz7tHgUO
 f2D5aOqlgFrXWOpzrQjwwlkzTriLPKSR2__JsC1ymmmVtzKnCmkbHk96tI0ZQi91vfjJKaO.qGEY
 TqwsOtMbj1jl7Lln.IPC7JzpafE78Y0F64pXQ5f7vTb9pEUwkM1Hg_Y0l_8H3wuHsj5xLcVko.Ay
 39jjPPniGPDBcYGeUeOTRBq7HjySUStTlV1We9NPdfpXtBhHOEt1yVf6fHZo8V.12JQ.uD7bvmMb
 EvRFsS5eZ9uClzhiH1UNbaYkkqRRNQqtga7Kyt4BKoKJ3irMrZqwO0PSlYUvizXTc.HQbKs8dYs_
 PWRvOrr1w9JVMF3FU_Dzb5EHc8CLrtjNKvth78t99MJB0lVw6L2MjDR.SzhPbXwTaohZH5J72VhE
 g7Y7EhjOtPG6.rSOn80HdJt1TN6qeo8SSNReok5AozhvfvZd8XP5SxgX5VMrCvaZj63IF7xIPS1N
 4IGPhuUu9KRK48Rd13EOlrmLjGj53nsdG6m_62.X3lAXALKm3mix9b1HJMR1PYtUHpf1njyrT9Ko
 le0jKTC3pHoKB1PX28bo9KI9p8KYPHF3LCxBxDnK3fjOnu32.I7MGwsVnvSepbDQhxtH_8Qe9c8M
 sb0zbAtqtedyt2lZrVm7FDxrJBSpMA.IzFQ8GnGLBWzxohGCcPCNfZbvyd5L2AwkUIUxRonydRSd
 ItiS5WcBiL1ny_8tVdsmdQtyUhmYmcbVgo8O5Q.hwp88rQX8p4Gdc8vhW5EpMrkWz4v63q7fYOOv
 8cpj2Hi9KjAUwkOIR0UToysB2il_QkTVBS.vIbjc4XL1Cz.wB6Bo_dSm14cVYQwSFzUpZ6HneE0w
 MKFBak34QCEoQ.uNqAblWuUf.p8WjxmwuMA2BYnjotI20TDcJR.f1MW_0CtpR9WgaTo.xgCHz29S
 7rc3qKCqI63juMSn1llRHeuhdwOVFXGGqenyZi8fvi5gyLKS4iuO.wW9pBsv9ur2PX_pPf.DDLvR
 rgCHdklDxBwQY2DZuT8Ymd36mrt756yHkAbZRIqNBXjmTDC8KKAtLiUKAWtzSgyWbWANhuR.jVfB
 S3bGsl.jvq6XOiIvSrl4rANoUuyEWxH9yb36gZ.C1jk5LXxsHa8nVqqoVR3gsWWOMbfy6KC1BiT8
 gGCbcZHclJ.EW6BzegCg2TaTyuhuTuujRSO.IOpofKzTKLVJJrfYFLdgKsfDVMSPuMyiO6bUrfjP
 FirQc0nCG03otfOP8jMu8T2ZU6vsoFOnBAxOHtFxpby5fVktGGnLAoLtctW8OceBMolBtUjaGtQH
 ZKts48fgcp120OhdxYV6naeoZl0_54a_.s9xdbf2N0WM0b1gGJ5noVHCiGWsIxc1yC0r.8Ksh.Ql
 UvYzEXciuJqP70ErFvaPb4FZaAzZ7GvXBoMWeSVoJBfwTd7VNpULfDWsmIL0TFgtsPweQTWxcgKD
 MfAKwqeaXuaaCRMNhmmaahJV3xBHDLKoayLrPp3dW2x8RGkxcCQyvVlR3HljcC3vBPIHta0eme_Z
 rdtJEpV4nw9JCqdlIYgsEufL8fycERiUKYLTmw395QVis7QNRwOrFWgZHPz6hNx4GPqSjJpwu3C5
 4FcMQi9MObd6TU_m7LZ5e4mxil8PBuZVm.ErYNyYCql991hmut.t4OzJV3KkIRnxnmBpCskcKAh0
 WL4BhE9hIcDIWqOQ2FVDwFCVaCqGSoIva5jwYC7Gqa_Few1fan.jv7ayyo2v.RWFcEqROqNa3YM_
 UIaI2yHsJE0gyvjxxDZJn7jIy3DQzIK3REKWiaOfomOMEf8gCi6aHY0q6l.4xBzmgqGEdH1fsrut
 KlqLUziIBjjg.wGF0yhHpTYZmsZIMXLpiptfhqQebrnfIjHJi48Ds.w5N6gAZknsYznvJXs2Z5rh
 RahGJbwDTpGyNMdhIEV8-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: e1cbc5f2-9dd0-48df-983b-6f1d6ca72e88
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.ne1.yahoo.com with HTTP; Fri, 21 Apr 2023 17:48:04 +0000
Received: by hermes--production-bf1-5f9df5c5c4-qlh82 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 091c2dfb80bceefc0923e7e11c81b629;
          Fri, 21 Apr 2023 17:47:59 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey@schaufler-ca.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     jmorris@namei.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net
Subject: [PATCH v9 09/11] AppArmor: Add selfattr hooks
Date:   Fri, 21 Apr 2023 10:42:57 -0700
Message-Id: <20230421174259.2458-10-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230421174259.2458-1-casey@schaufler-ca.com>
References: <20230421174259.2458-1-casey@schaufler-ca.com>
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
index ce6ccb7e06ec..bdaa8bac0404 100644
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
+			total_len = ALIGN(error + sizeof(*ctx), 8);
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

