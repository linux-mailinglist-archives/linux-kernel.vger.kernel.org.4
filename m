Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2EB95ECDFC
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 22:11:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232978AbiI0ULG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 16:11:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232880AbiI0UK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 16:10:27 -0400
Received: from sonic302-28.consmr.mail.ne1.yahoo.com (sonic302-28.consmr.mail.ne1.yahoo.com [66.163.186.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E2B71E459A
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 13:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1664309357; bh=Z8k6KNfxmofAulBiJEk844o4bSszlNFVmtrbKWlkLuM=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=sZEX/6YMb/63KSBUzzGgu0L16tLj3IxS2/5SKuR+qKQUvl3fZD2J3NPUhcNUyJiNNiSfb53n+DzES7KY5YsHS5Q1TDRbA/hS1YpJENHvpOAtFqIYH32Wmnado1yIN44444+RB/R6filq7bgLYgNv1hEHnU4jOBe9s0JVUbinhDPfB6iSCqLY3G11Yu4RR1g3LIQO3KNrPPfxTde6TGNWgwY01kvVLaViB+1BgqLT14anL3LyzSeKwzMnXvys1/k9+qciaK6EgdsPexTl1dsAeOVccnKrx8IQLjb3svZbWHlUBXGJpreXv/MnT7yWxL+AO951ID4ebvQ3EdnEidt/jg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1664309357; bh=bho2X12oNS19WM5/1W3KAWaCNq34D62T/6fZvoQaCmd=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=sLQgZFH4XhMVxWLEUa1l9wD5HnrXJEtv84Nf92dmxHn8PNLVUR1akBgeFwDWoLoWUYY7MPbzxCOszGrLDg9z1/7DnEYFhuuWbFL6vgtlOCF+jd1LkBdn4eEpr32VmXtkLlShCcc4VEwUDsMCuJTw+IyPgbtA2jwBTkUYynIxKL33fXOa3Mng7ue2SQZyZ2mcrspjIBsExSfDc0ZfbgyqMNAu5mRTYpbAvAIjlsJ3KXDmpee6NWh74cVsACW57WLJaWWK/j2RSa8qnvFIULW+JcBGFYcp1UyTVM/RtHKmNzMBV4n8PHb5iP1egJR/VLcBu7s2uzteKDdOx7HusVkX2Q==
X-YMail-OSG: epppJwEVM1mZ0L.s5YTCarJ4gFo_xdBozrarhW5yrNFJWVy6ap4pLmGO5lmXIiz
 _1Gfw0zzWRWoMLKDWr7AWHzho_BwnQ06ZYleH3Hm0CQvKax4ZTSVAcg_ICXRTuSk8K713ARIIhYz
 BCkA4VtWN6SEFitQnJ4ali2HD.BPfwt7ori80uWQOAna1JXohxEa3Ibnp3AFF6Q2AavgJOTVA8iN
 5zIf_37rViwIj0RSk80UpKCbLCa8HxfKAymnUmU9uzZZ4wDF_J7OPJ4aMMtPgu9TjZTK6VCw2eLC
 M77zvDZBGljjoXrxc2RW2hJz.WrBngXZRtGdYKTjdYLQr5eZlpStC46Jj_ttRbVWZYcb5k7NbFb9
 FkU9l82qae_PqxwyAbZPaMOBraavyDG6MT0BJTNakDwYV21v3p8mKWeBxM1LDxAjXmWP3sEPyY8m
 r6iPQtd9t4jrHffIG0GhEKIKwU5gZNqi6D7t_WyxH9OGOQ.CfscGs8A5hSt.ClXv6VRWRHWROhXw
 mFjAMPaDJfCZQkjTBK3cFUVM0ZxfKitmf2xxnAwH8zwJpBtnG4mD7eOWXH0y0iPw1LHzJnl7c1qn
 .31m8sNnlEOgq1I7qqDynfilAkjpZpAIaLBZqyP7GGiTi6eTejyyFLqSK8uoQBTXjWpbnvgCn997
 N36GSd1CUj69YSku20LB9ve8x1bEwwp.s889hwKC9TgUJX851IW_eBIm9dgp0coz1XV8GLn95Lu0
 K3zgTvRtJVabwNqD0jf3izzacMcfNGf4fsMQLCIj4MCv7.QqfpVOVqq.yuI_79ZlaN7tkL0Dgtoq
 ImL9JRxU2ytkEEUywki93WrsAcE0apFmCOsGALlHbm5qE9g3jAXV9EYnG8Rr_XZp6kmLZVB2Iu31
 wKAKnkIMOo.F63wPQGDc_.TSYLNeBVTmUf41_DKykrKkAr0bP.DZENFc49kyPTi_oKF2o6tdWM7N
 7SxuLwXwFrcYK6YP5CKbno4GH6HOrXsrawpI4.nBT.ei.7lsy7wD.GqhOzuFz189MJMPve6okLXI
 7VN.o2dMKrl2iC5OI7VBSMqe9TIF7lsEy_O2_0OcVvRvncgftSZQqQt8naLHPFVEpdhsjJ0pvdgq
 YrASYfyrZOE0ouZV_dnTDNyGr8yWOu5jGJQh7uUnUl5AZKBv1dnQKYumfovgrasiaTUgRgjMrrCF
 YIEKQUe7Ly940BgDLm9Jss_T4dFRIdDfJKND_OPrJUuzN.8sp.SDjtRgdSvIDMVzswpwsk.J1uby
 vIYqFxMGHC4WMJ0gsB98vMxwRo85ZXVTVU7os8vFeu1umc8jNMXxidDzfcFhLq.wzBLkAcBH9Q6Q
 W0WMzC8ZZWWS3wwu0C9ZSgs9g6LlGkxVTzmmHdY16wdJKhJHxJHy28v0HRIuEJYkCG.GhBgSv6Ww
 2Irmw0WEgjtsaJjUB4oaChvJr5yh8uZH4Ch6WnXPKluCmrYcg2Pfm5U8ZO9PODPorb9fsTtOyt3E
 FUZi12R2QkmZ9RhPr.TZtDOdC4x.voa5EF7xQdVgSdKRHeb0Frf8XZX5E70yyLvjF49xCItdDc1Y
 00IT2NRKh6XOtMdCfCDuqxP6cbRz40yC8U8LICWghwt1sTmbWKtsMSUd8eq7DVcCSZWMnefuIEx.
 _JwW91nfECfQOb4L_yiF2hNXjbB3izJFEl2yVTaSa7bpoxdc2JqJ7KL63aj1m0mzRAzESRvJI4Q1
 4ke_oHnGSgH2fCv5RMiNJFxpOnXTvcb9ew4yuJZ2Fbxv0XdXj2lFI3MnIHjrS5uadl9ytCO5C.l.
 QoH_O_R6_PE4Nu6lvKYJe18r9qVeN.2DkXXRWvJ6ddRxCbZMP86QR3xNPWq3lQ3m2q4tmlnrh13O
 3SMB.66.GgnvRUvGdBGYZATeMMozesqXpwjneWnEwigih.zhA54gvJ7XurRhAAP6pC2Ad4nc3p7Z
 qW72F2KGeJdKjA5KuYcAgGi0kIOWUZbNLTS7PGNf0JJkvarQbd37cARipnAb81_HERR90XrI6Mp9
 spewcB4bo1mTbFWgvzuyvfBD_9p1.hd0fJ.Ay9WH8r133EajF6VwkOgvwzgDRzK9MtvP8tu9YnwN
 ORCViLhjEAL3DglrsfKqFM7qURFQGsI.0gEmFkuGkh2jnlNvN7vL8O7PS3pEBPDqsv.OmRnnAr4z
 aLsCyvEXTDj_GxeXZ5AZwp60TYOg8a4.iAfSWIb1wf2Py9yin9DwDC1hagwjr9OurwMbbTeE2PN3
 GQ5cOvH35qakKtpXyVWe6jU.i32zUGzKet36_bdtgciQpVYC9O4eXJWcS6x8vGJ5IC_5GjS2Ntsd
 6cROSt_ws6aJUZAA8ahiJhrB5Hf_dIMVPfE7QQA--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.ne1.yahoo.com with HTTP; Tue, 27 Sep 2022 20:09:17 +0000
Received: by hermes--production-ne1-6dd4f99767-x2f2n (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 962ba498c220faeab9c55c1f2e7ba390;
          Tue, 27 Sep 2022 20:09:12 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com, jmorris@namei.org,
        selinux@vger.kernel.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH v38 29/39] Audit: Keep multiple LSM data in audit_names
Date:   Tue, 27 Sep 2022 12:54:11 -0700
Message-Id: <20220927195421.14713-30-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220927195421.14713-1-casey@schaufler-ca.com>
References: <20220927195421.14713-1-casey@schaufler-ca.com>
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

Replace the osid field in the audit_names structure
with a lsmblob structure. This accommodates the use
of an lsmblob in security_audit_rule_match() and
security_inode_getsecid().

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Acked-by: Paul Moore <paul@paul-moore.com>
---
 kernel/audit.h   |  2 +-
 kernel/auditsc.c | 22 ++++++++--------------
 2 files changed, 9 insertions(+), 15 deletions(-)

diff --git a/kernel/audit.h b/kernel/audit.h
index 316fac62d5f7..4af63e7dde17 100644
--- a/kernel/audit.h
+++ b/kernel/audit.h
@@ -82,7 +82,7 @@ struct audit_names {
 	kuid_t			uid;
 	kgid_t			gid;
 	dev_t			rdev;
-	u32			osid;
+	struct lsmblob		lsmblob;
 	struct audit_cap_data	fcap;
 	unsigned int		fcap_ver;
 	unsigned char		type;		/* record type */
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index ca00187b4864..e8f632736d2b 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -700,17 +700,16 @@ static int audit_filter_rules(struct task_struct *tsk,
 					 * lsmblob, which happens later in
 					 * this patch set.
 					 */
-					lsmblob_init(&blob, name->osid);
 					result = security_audit_rule_match(
-								&blob,
+								&name->lsmblob,
 								f->type,
 								f->op,
 								&f->lsm_rules);
 				} else if (ctx) {
 					list_for_each_entry(n, &ctx->names_list, list) {
-						lsmblob_init(&blob, n->osid);
 						if (security_audit_rule_match(
-							&blob, f->type, f->op,
+							&n->lsmblob,
+							f->type, f->op,
 							&f->lsm_rules)) {
 							++result;
 							break;
@@ -1564,13 +1563,12 @@ static void audit_log_name(struct audit_context *context, struct audit_names *n,
 				 from_kgid(&init_user_ns, n->gid),
 				 MAJOR(n->rdev),
 				 MINOR(n->rdev));
-	if (n->osid != 0) {
-		struct lsmblob blob;
+	if (lsmblob_is_set(&n->lsmblob)) {
 		struct lsmcontext lsmctx;
 
-		lsmblob_init(&blob, n->osid);
-		if (security_secid_to_secctx(&blob, &lsmctx, LSMBLOB_FIRST)) {
-			audit_log_format(ab, " osid=%u", n->osid);
+		if (security_secid_to_secctx(&n->lsmblob, &lsmctx,
+					     LSMBLOB_FIRST)) {
+			audit_log_format(ab, " osid=?");
 			if (call_panic)
 				*call_panic = 2;
 		} else {
@@ -2278,17 +2276,13 @@ static void audit_copy_inode(struct audit_names *name,
 			     const struct dentry *dentry,
 			     struct inode *inode, unsigned int flags)
 {
-	struct lsmblob blob;
-
 	name->ino   = inode->i_ino;
 	name->dev   = inode->i_sb->s_dev;
 	name->mode  = inode->i_mode;
 	name->uid   = inode->i_uid;
 	name->gid   = inode->i_gid;
 	name->rdev  = inode->i_rdev;
-	security_inode_getsecid(inode, &blob);
-	/* scaffolding until osid is updated */
-	name->osid = lsmblob_first(&blob);
+	security_inode_getsecid(inode, &name->lsmblob);
 	if (flags & AUDIT_INODE_NOEVAL) {
 		name->fcap_ver = -1;
 		return;
-- 
2.37.3

