Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4FD05ECD99
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 22:02:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232114AbiI0UCP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 16:02:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232304AbiI0UBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 16:01:47 -0400
Received: from sonic304-28.consmr.mail.ne1.yahoo.com (sonic304-28.consmr.mail.ne1.yahoo.com [66.163.191.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53E9C1C481B
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 13:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1664308864; bh=iJXai5q9dalmXXi6jXeuepX499fS5F1sBHhYPhBACCs=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=LlM7ILAqAEgUCbv52faxiN+M49f9ZzubbpwvaRyF0XuvaE/+x7Xf1ilX4KyWmNl2SllC9m+Ex28jopGBgVKZJVpFV7gB7BRpp0gMLWEEUvj4WlbT3yR/6LsCdGJMQ5COm4A8aJ8KQsih/qB84BmGZPDXbtYn7ziC065wn0Q5beg1OvhZ9FM3cixLg8iLbetDV60sV21/jgl4T6JHkDfEU2mS3thHcPnpoS+XVzn4lAcG0xLMk7XuAgHasmWqsOjngBKbaFmq7G1siFgAN2+es4WgDGDzj/aBMo+fJdKMg1zyijXZKJbktlx50UkY3Zeftm9ZqUl5tbBjjAim7PP43Q==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1664308864; bh=x5Z9FfLLtinY7KzMegfg3yJcNgw8jwNuDJ1VqgI6FMq=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=L2VZ/HrEvFZhE6USI9QuaWqEY8zR/ZwK5R33AEwoa4I7TUadFlyJ5lPETw+GZ93GS52Dz/DMfp3DzoZLkFKp/1DyryA3UYFyUrMiAwQMf4yEqk53MJ7KnaA5cXw0ZJJdciG4tahHKYjNlqojR34AmqZYLQaO63TNa0weuGd9hBowa3as2HYDgtM+F0BbepSCdE9yYJWmYc9keiV2htAytXRLqg/ihOBJGGIvtnlh6bLzkZPmVqoWzE+juD052J9SMYRIb/jm+OfO2zJuxA7ap/LHh5ol+FeEuOz+EInh+cpNUs+plmn3ThovjKWIAqbYqBQ+VJ5tBycLd5qX6PJPog==
X-YMail-OSG: z4qjmXQVM1ls6AiD8nLR33asUF6HbJdilcqXCZqK1IjlNrUrUTTMuMUU8r0ssYC
 28Fy5uVXohd_haMLCCB6sMuYKUmHkyy3VKQ6AnruOMlsEGFQaFchZ4V6eSfYf.1BLwfzXeiRC5I8
 i18IcLw9gaFWFe_bEnDstcAw3wGdSrtQBpXockSJVSARWJVR2T4W0oqqeXysm3_.20Hh37NgdfLX
 twlJLZOymqBctkYknOD66uRGTgOvxsqOd0FJVP3vErtjiIvJUn7bokm6uITJPUOyBc6CXu45.dP.
 7ChhalwMw5l3Eb4I7yV7ylu.4IHPdZJka3iIzPmgO1OkrYdxUdh5A4y9bYkvBJysjPwvMj.GC85P
 NEH68hhPAFMTnARRrkP1VJd4UyhbI25ctJH0m0fcCzQ6xK4mdxC7OZgVvm0H6my0Ja._OjdpDtTS
 3l9PI52TcLu.qP7xuj8dXcguodRKm3NINFWg2LBMItsguXnsabz5vBbiDotrIqX_On0zHOqD.vad
 Z9whLBuT4gewI9N60u5pUlsiMKK92QfyI6Hl7uO39U_5v1M1uB7xA6rrT8iIPIT1R1v47_9R6_9V
 x8UUpnNhjRlE66ONbXDZvwgyTWUeg1mGOGQklWkoA93wiIc5UcFuMILQxekwQspymywLQEuSC9hD
 cemr0u5HQwr1jagXSrpL5bvh1g.jB9ecYWY01kzMSxXKCWOMhl2fuI.ObP11.J8y8DdgHm_Yg1n6
 O8GK26it6y51cfuc_3.rXcQ3GgFlpaZ9JmhoVsJa8fm_xaITqkhIjYsyCMBEORISsn9UotRPZ0K6
 4Cj4b0YC5WNlUvbfHlLHrRDZASMMiuDh6hAfohEW2PHU3cYXpqS2AQbdcdGbSb7hpwtpP9ZfhBNU
 48D9pXMesFDSK10iRkNkFW2k.xeW.RoXotkMj4Y4DH3T1mED8Tp2fBvz74F7nWPWtRFwTVvq8O2j
 i.P9.iis_yQV1jZx_QJTB6j.t3d5HBHYSSn6_zltaQJ44cfAuBVJc4WxQrLdlhZpS.DEEkGJjROy
 T.WZe7d6a8XepJOHLxCyh_VKuncXCPYkRh1rzLsxf9WAja5JALlHPVk6aXj3qmVj0Dd5rq5IbpwJ
 aKApqBA85xLny6tMQxRKC9Eu2PBtCoe9_LLVf4eDuFAraQO3_smoFi3JKgCdzmElUoHLzfFa.yE0
 0QNcut1IIaRciK1zu94VEpT6GLN5PlUPte7DrkLDUiPnOjbcI_UsDBDhs8uArpneWGywk63ZsNgO
 9DRm993QYRNyCFY42CjgRzdaPwDQLa4uVO8PNH1Rc_5c_IqkhmqbYQz.687CLQ4DmMb1P5Ngi9fC
 xhfJo7Nq_cEMYvQ9auyNG5X3Q9W2EPbtGGXM2jAYfo0JbFdx4vg0CaZvCw.fN8TRYQcFa7DabAQL
 Qnu4FDYjkx03QjPRV.XqOt1hRdDxfxRqkYMVa3nvKb82Saanw2k311zJIe.YHOyOsr9jNyeTnI3l
 8.ZzgHIAMaAAXHA3VIyFqfmYwVQONdr_vj8c4kUIJ_Uc28ykhpaj8jIPj6ofBmMtYO6KVa.mXak5
 MeteL.FRpG0TtleavT2M23y_QJEdt9HuY1AQc4cNMlrB0.701q62dEU35hljN9z9UFFoH.HCld_l
 Mpm7pguLJQTqlEWjurQzK.6pWt9qmFB.UvtonoEcA5_T_A0x9fd2ayzWsqrNKhVcblnYaE07_PLp
 D_NT0UgXihzf0beXIHi.d7tffWoGxtPEaV0esJBsHhN.HwmTGlRedSQm.hli560hpQ9jVR5621zu
 nryPc9ywgZkoYnEF0KDRtXDu2aPCd5px7CCuIJKNmJfCigiFLZdmIAc3i4XGl2pVLCyop6M6ypyi
 Pisfl04zD6Il38RyKuli4tEW8bgYGotVea4kwhwC6SUykiRoCrvuTrlIOZ9he88zIa6a.4MFGXWA
 24K0nAhlec71GIuUndqteeEoy5SqmDCy0pPOtqVDvKWeKL7dRTXXEB5SqQcTWDk45vFdLaLAEv2_
 HwIVHp03pudG8PA5r3Csm3MGLBhtB14Oj9GfmaRzXyIOdJeWtRJX3P0TZM8YwRxhyK6hA3Gn64Qh
 6GNmC3W1f2anczTMU6HiwR2aXW8HxkE8EmIzS.2DEGH5tr75MjG_Jx20usR8tg26zQbXYX_0Z8Lb
 MPf7DLGOPV_fHyS7HrCmnf61Dsprd4l1NJN_Et3QXlKO9GdNH4hKo220C1tVolXV1B.2.TLJ7.oN
 shgUySy7EuW36DR1l90CG4aN3Uy1ONT9yllc7s3DN9AJVgi7WlGwT.ENYyYmI
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ne1.yahoo.com with HTTP; Tue, 27 Sep 2022 20:01:04 +0000
Received: by hermes--production-bf1-759bcdd488-mc79z (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 6e213c213e954b1fa721ede3259fc3d6;
          Tue, 27 Sep 2022 20:01:01 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com, jmorris@namei.org,
        selinux@vger.kernel.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH v38 12/39] LSM: Use lsmblob in security_audit_rule_match
Date:   Tue, 27 Sep 2022 12:53:54 -0700
Message-Id: <20220927195421.14713-13-casey@schaufler-ca.com>
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

Change the secid parameter of security_audit_rule_match
to a lsmblob structure pointer. Pass the entry from the
lsmblob structure for the approprite slot to the LSM hook.

Change the users of security_audit_rule_match to use the
lsmblob instead of a u32. The scaffolding function lsmblob_init()
fills the blob with the value of the old secid, ensuring that
it is available to the appropriate module hook. The sources of
the secid, security_task_getsecid() and security_inode_getsecid(),
will be converted to use the blob structure later in the series.
At the point the use of lsmblob_init() is dropped.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Acked-by: Paul Moore <paul@paul-moore.com>
Reviewed-by: John Johansen <john.johansen@canonical.com>
Cc: linux-audit@redhat.com
---
 include/linux/security.h |  5 +++--
 kernel/auditfilter.c     |  6 ++++--
 kernel/auditsc.c         | 16 +++++++++++-----
 security/security.c      |  5 +++--
 4 files changed, 21 insertions(+), 11 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index 6ee00f3a10a7..3fe04958f7fb 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -1982,7 +1982,7 @@ static inline int security_key_getsecurity(struct key *key, char **_buffer)
 int security_audit_rule_init(u32 field, u32 op, char *rulestr,
 			     struct audit_lsm_rules *lsmrules);
 int security_audit_rule_known(struct audit_krule *krule);
-int security_audit_rule_match(u32 secid, u32 field, u32 op,
+int security_audit_rule_match(struct lsmblob *blob, u32 field, u32 op,
 			      struct audit_lsm_rules *lsmrules);
 void security_audit_rule_free(struct audit_lsm_rules *lsmrules);
 
@@ -1999,7 +1999,8 @@ static inline int security_audit_rule_known(struct audit_krule *krule)
 	return 0;
 }
 
-static inline int security_audit_rule_match(u32 secid, u32 field, u32 op,
+static inline int security_audit_rule_match(struct lsmblob *blob,
+					    u32 field, u32 op,
 					    struct audit_lsm_rules *lsmrules)
 {
 	return 0;
diff --git a/kernel/auditfilter.c b/kernel/auditfilter.c
index de75bd6ad866..15cd4fe35e9c 100644
--- a/kernel/auditfilter.c
+++ b/kernel/auditfilter.c
@@ -1337,6 +1337,7 @@ int audit_filter(int msgtype, unsigned int listtype)
 
 		for (i = 0; i < e->rule.field_count; i++) {
 			struct audit_field *f = &e->rule.fields[i];
+			struct lsmblob blob;
 			pid_t pid;
 			u32 sid;
 
@@ -1369,8 +1370,9 @@ int audit_filter(int msgtype, unsigned int listtype)
 			case AUDIT_SUBJ_CLR:
 				if (f->lsm_str) {
 					security_current_getsecid_subj(&sid);
-					result = security_audit_rule_match(sid,
-						   f->type, f->op,
+					lsmblob_init(&blob, sid);
+					result = security_audit_rule_match(
+						   &blob, f->type, f->op,
 						   &f->lsm_rules);
 				}
 				break;
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 482805f6ea68..5fab2367bfd0 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -468,6 +468,7 @@ static int audit_filter_rules(struct task_struct *tsk,
 	const struct cred *cred;
 	int i, need_sid = 1;
 	u32 sid;
+	struct lsmblob blob;
 	unsigned int sessionid;
 
 	if (ctx && rule->prio <= ctx->prio)
@@ -678,8 +679,10 @@ static int audit_filter_rules(struct task_struct *tsk,
 					security_current_getsecid_subj(&sid);
 					need_sid = 0;
 				}
-				result = security_audit_rule_match(sid, f->type,
-							f->op, &f->lsm_rules);
+				lsmblob_init(&blob, sid);
+				result = security_audit_rule_match(&blob,
+							f->type, f->op,
+							&f->lsm_rules);
 			}
 			break;
 		case AUDIT_OBJ_USER:
@@ -692,15 +695,17 @@ static int audit_filter_rules(struct task_struct *tsk,
 			if (f->lsm_str) {
 				/* Find files that match */
 				if (name) {
+					lsmblob_init(&blob, name->osid);
 					result = security_audit_rule_match(
-								name->osid,
+								&blob,
 								f->type,
 								f->op,
 								&f->lsm_rules);
 				} else if (ctx) {
 					list_for_each_entry(n, &ctx->names_list, list) {
+						lsmblob_init(&blob, n->osid);
 						if (security_audit_rule_match(
-							n->osid, f->type, f->op,
+							&blob, f->type, f->op,
 							&f->lsm_rules)) {
 							++result;
 							break;
@@ -710,7 +715,8 @@ static int audit_filter_rules(struct task_struct *tsk,
 				/* Find ipc objects that match */
 				if (!ctx || ctx->type != AUDIT_IPC)
 					break;
-				if (security_audit_rule_match(ctx->ipc.osid,
+				lsmblob_init(&blob, ctx->ipc.osid);
+				if (security_audit_rule_match(&blob,
 							      f->type, f->op,
 							      &f->lsm_rules))
 					++result;
diff --git a/security/security.c b/security/security.c
index b74debe82d82..96faeff2c73b 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2720,7 +2720,7 @@ void security_audit_rule_free(struct audit_lsm_rules *lsmrules)
 	}
 }
 
-int security_audit_rule_match(u32 secid, u32 field, u32 op,
+int security_audit_rule_match(struct lsmblob *blob, u32 field, u32 op,
 			      struct audit_lsm_rules *lsmrules)
 {
 	struct security_hook_list *hp;
@@ -2731,7 +2731,8 @@ int security_audit_rule_match(u32 secid, u32 field, u32 op,
 			continue;
 		if (lsmrules->rule[hp->lsmid->slot] == NULL)
 			continue;
-		rc = hp->hook.audit_rule_match(secid, field, op,
+		rc = hp->hook.audit_rule_match(blob->secid[hp->lsmid->slot],
+					field, op,
 					&lsmrules->rule[hp->lsmid->slot]);
 		if (rc)
 			return rc;
-- 
2.37.3

