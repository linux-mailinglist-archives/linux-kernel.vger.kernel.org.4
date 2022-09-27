Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47A675ECD91
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 22:01:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232672AbiI0UAu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 16:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232524AbiI0T7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 15:59:39 -0400
Received: from sonic302-28.consmr.mail.ne1.yahoo.com (sonic302-28.consmr.mail.ne1.yahoo.com [66.163.186.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB33038BF
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 12:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1664308770; bh=ORaYOhRvZVRmEaTvt8sTTfQRzM6HVhX8fYUV95qzKzE=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=FjAsHnGQjMbFlonZlOkGtY4Dsl7v605VNTvTkyb5Sh4Sa9k9qi3W05caBZAySQSae8/8kg4I5vTFUzy4QB/HQbmi1OFoffq8raDnI0k31hyQtEBVy9ObhLxBrix7IBMwwPsx/Y5DCYeU+xhPGh4MZRfpQydb7ztDQvM1idgWhnA9Bl0UoS4VKZHZvqiRscIqt+GtbUDsv0OVFcDNWIAEEdR2iG+rMTeSfQuZNpBkLjMgS3oa7lR2Q7zlFu89yK1o+RCiccw3lQ31hoBFc87g7E8SI6CuHpF3bZLnEoPN0ebuCoxW94Omtj9U/GFGpCJOa5UgMoRhjLNv3mvrqCeT4g==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1664308770; bh=kzrtR24KtKo0IcBHHd7vOac1eosaSL5Sp0C81klB5uj=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=oXYVteczvl72PZCOniH8QCcI/ch8UBZt9fIxsaz+sFXcroc3B/EIl/nmc+hUDVqy4i42jmd646DDp6WnZon4Oi9hE74zkvDwiMZlHxS9RfgCBsQK66Y7Q2b97GWwQkZnLtf714/CGGmpPtc+2dl9Qy41e4u7FPhT64zRpiSBPbpphP/L5oZyqNsO7N3A3D695x1pLF5n73n6ProNS/rUqNdt0RYklw+sHgTpiHdzOAuXvF/rttL6JdaQ9PQuM6qhO50EW21SUbF6j4mEBqMTodef4doXl5RQ5RqsfNGp7SOkPLXW6ZpTwdrA2FeYK5JU5a/aHU2f1b3uV7FQhPXiBA==
X-YMail-OSG: fgxBw8QVM1kePPcUmbbnMVA_2S2Cbs_yWcPG91fFwh_LPJC79hSlBG3MZ3XrpmS
 3R6Msosdh4Avh8OGPVRisM.iXb6fWvJ4qHprCrphTODo_oVTID_tgEYKdXe3TdSiG6.Wj1UCOLUt
 T7Pl5_5Ei_mf2IyuSjvJTuoRlr2rur1syJqt0pOUbMt4hVBG9bVxPrQrUq6l9oQPfCOBnoHd4Su.
 D1s8KCvItrC16Sp6t0uR7fiXNZP0GF7F5.ZZbaqd6tPoAli2oFo49PodnGPTqVvML1zeIl638fI5
 Okyj9W2hllKty0W0ITw2rEuHGQSvN.BIapsav3Jml9i38dZAH1RXuRrZ9FBpEDpcmhUS9W2R7OTd
 lJK3NtIjg8E3.Q4PEtWHRUPPKwPkMvu7MGY1gcB0CwyxmY1J8tTSSfhRNC.3cok83HCNfTYJ8ZXQ
 jCQtoQabvaqoE3yQ6kQDeyDjQSH0T9x18CCoN9zCe.Xew.sgdcbYzEswVL4d68M_0ji5olKFwMMv
 iMCJzL_yVyOt6AI_k9_G1wWAmNog3yuvpfGqJcV6.W5nCIDH7APVREj1wouk2uLOJUvrxb0cRasr
 Y4uSkWeRQE6aeJtBVCBsfvDcQog_lyHoUG6SmYAaAI7mF0sA9VeO2i7YvzzjkOyKUkeuN2P69s2q
 rkSB7FjsRy0G7GNOGmHlcaCnNd9zVG4tr13Y9h6hN1RJ4zwEfGZ4_BfQdp7Wm12I.J_ywL6H1fAr
 QbI3yI4yzK4Zk5rA_cDJatvAd0IXxhJyuBIh2XH6V__OoiIF2UB3kR33nz9VtV6F0Xf4.4l5taVm
 jSUPk0IHtiqLplSYqeo3KgwyQldfMVnCIwIUzEjjKNsUp1ZhVF3rs3T2tWQMnlwJTTKXEdcDKICy
 _Zvg2B0Ntx2SnGCnSZc0YaGHwQEOJDHI1JEctvUxQG9R0tAmtFXmm2c0pqllpTlo5Dpqm82lSIms
 oglPBJTkffSgoeFTkKEvfevWltuu25m.S6ikRZT6cmyLRZMvoB5khLruY0Bcd2S4umGkRQ9IgrZV
 CcW.A7TpUju5BrPxLaNiYejhuJCTKdMiZpC4IwjJTTSx2JK8dslOQbQnKQU.Or6ucLHi2opP79WT
 FYLTtHlt0sgv3plnJ_Zd0o.AC8oLKi3ysm_KdCaRPewdcGaaMv8fwwIKe1BU.8wNOnDC0CF0pSB1
 96N_P.bijV4D9nT5UBeUnKNrF_K1aTnnBr652JK2oiWpvoPOSDevxqiq7CAmv12PxAGqqvNWkIJ5
 NVyGzU0okHxlezTjpatL8ADqXvQeqUkiCMA0qS42vvBb.4EpZHGI12OSi1LGKfepci67iAFgMMee
 54OP9_T1Q9tZ1HcxcIj0b3kbUIVJz1p.GXKk14WK8I6xBrq2ZsRRi._wO9whZTtvOW0ijX3HivSi
 xXvYx8drsB0VgG4BQRR3rDn_Hn9tRTIbELhYp0kuSCa.iqXy9N2R3rVXQzZt11hYs44uHg_TJ3bE
 MvUTmvF_TQt.0eBUOYqqsy5w7SSDmd2cdxM40ZOlp1W.vdKpySuJHrNYRbKMUW1YhQRNT7F5cvpg
 eEr39dj3jja1OH0P6mJOXBYASM7eNTTo92yaqo0qMXLpoQj17HwxCQRBDMX7yFmYvmVKBppsIQ2h
 Af38Hw76ZIoaN5fVIJkpYZZoSx042.xxsGwIVOPHt0wOQN3rVb6OyN.YsncRDVdeKe2sLMawJKf9
 .XSfj6mJPI04nhiwucB7aHaYU8ehVrAAfq0ZCcF8g4IWr6vGOxBdoVFUu5HiMlis8iAzUd5MBGFO
 E1aon8NWw75PNCPnQ7jZC23mMUZecszwu5YGO.7eVdVuorC_w1QC4cIH6nIGDAFaaausVMACiRLI
 _GYlL2UPXVOLv6mXlsJEByfSqZrx2brk1IW9ry6wvKTN8HKfIAkLXApCnOIexffvxhxCVWVNYaZq
 EmhiSepI6rY19f5nhAgy7nnIJ_jP3SDCc3K3wqByiNi0uBC8_uZVFISWK9WPb2.70UAWIpMWT.8x
 SOxKVHrORKB3HALJBAHKIjp8FO7z1wnppAhCGsTAxO9WXAkPC71O.z2r.eYN5ol0GzvyY7kk0Ff4
 q3amb8kOMn9Q5iY5WeBddvz2sAGO7q4fL2.XObfQnm6lpp0gXlDLIxtMRN8_szmjKv9icJvzeGWw
 8YDP6wtx4bpJZOlVJ5u8Pg_.XTtYS1XJlgYLFczgrMsDwwHuhdOJ5e6xTN3m5swZfBC4l_Kuh.QB
 _Q0MOvfVbWntoOIe0.c.LBXFlr7ywncN8d7Bf4rOtUTWZ12.VjmrFVGKf.UDdNY5nkKjK6HkCosx
 eVExXWadJ3yQTIug2vwlTxczI4kqtyXD1xqXgQb_nyNjsKzMmsRmwHq8BhBlMmRcn
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.ne1.yahoo.com with HTTP; Tue, 27 Sep 2022 19:59:30 +0000
Received: by hermes--production-gq1-7dfd88c84d-mgq76 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID a8608bb7fdb0322afb9a5fe3db2c5570;
          Tue, 27 Sep 2022 19:59:25 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com, jmorris@namei.org,
        selinux@vger.kernel.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH v38 11/39] IMA: avoid label collisions with stacked LSMs
Date:   Tue, 27 Sep 2022 12:53:53 -0700
Message-Id: <20220927195421.14713-12-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220927195421.14713-1-casey@schaufler-ca.com>
References: <20220927195421.14713-1-casey@schaufler-ca.com>
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

Integrity measurement may filter on security module information
and needs to be clear in the case of multiple active security
modules which applies. Provide a boot option ima_rules_lsm= to
allow the user to specify an active security module to apply
filters to. If not specified, use the first registered module
that supports the audit_rule_match() LSM hook. Allow the user
to specify in the IMA policy an lsm= option to specify the
security module to use for a particular rule.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
To: Mimi Zohar <zohar@linux.ibm.com>
To: linux-integrity@vger.kernel.org
---
 Documentation/ABI/testing/ima_policy |  8 +++-
 include/linux/security.h             | 14 +++---
 security/integrity/ima/ima_policy.c  | 70 +++++++++++++++++++++++++---
 security/security.c                  | 35 +++++++++++---
 4 files changed, 108 insertions(+), 19 deletions(-)

diff --git a/Documentation/ABI/testing/ima_policy b/Documentation/ABI/testing/ima_policy
index db17fc8a0c9f..bac75acc24ba 100644
--- a/Documentation/ABI/testing/ima_policy
+++ b/Documentation/ABI/testing/ima_policy
@@ -26,7 +26,7 @@ Description:
 				[uid=] [euid=] [gid=] [egid=]
 				[fowner=] [fgroup=]]
 			lsm:	[[subj_user=] [subj_role=] [subj_type=]
-				 [obj_user=] [obj_role=] [obj_type=]]
+				 [obj_user=] [obj_role=] [obj_type=] [lsm=]]
 			option:	[digest_type=] [template=] [permit_directio]
 				[appraise_type=] [appraise_flag=]
 				[appraise_algos=] [keyrings=]
@@ -138,6 +138,12 @@ Description:
 
 			measure subj_user=_ func=FILE_CHECK mask=MAY_READ
 
+		It is possible to explicitly specify which security
+		module a rule applies to using lsm=.  If the security
+		module specified is not active on the system the rule
+		will be rejected.  If lsm= is not specified the first
+		security module registered on the system will be assumed.
+
 		Example of measure rules using alternate PCRs::
 
 			measure func=KEXEC_KERNEL_CHECK pcr=4
diff --git a/include/linux/security.h b/include/linux/security.h
index 0f0fb2077f41..6ee00f3a10a7 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -2012,25 +2012,27 @@ static inline void security_audit_rule_free(struct audit_lsm_rules *lsmrules)
 #endif /* CONFIG_AUDIT */
 
 #if defined(CONFIG_IMA_LSM_RULES) && defined(CONFIG_SECURITY)
-int ima_filter_rule_init(u32 field, u32 op, char *rulestr, void **lsmrule);
-int ima_filter_rule_match(u32 secid, u32 field, u32 op, void *lsmrule);
-void ima_filter_rule_free(void *lsmrule);
+int ima_filter_rule_init(u32 field, u32 op, char *rulestr, void **lsmrule,
+			 int lsmslot);
+int ima_filter_rule_match(u32 secid, u32 field, u32 op, void *lsmrule,
+			  int lsmslot);
+void ima_filter_rule_free(void *lsmrule, int lsmslot);
 
 #else
 
 static inline int ima_filter_rule_init(u32 field, u32 op, char *rulestr,
-					   void **lsmrule)
+				       void **lsmrule, int lsmslot)
 {
 	return 0;
 }
 
 static inline int ima_filter_rule_match(u32 secid, u32 field, u32 op,
-					    void *lsmrule)
+					void *lsmrule, int lsmslot)
 {
 	return 0;
 }
 
-static inline void ima_filter_rule_free(void *lsmrule)
+static inline void ima_filter_rule_free(void *lsmrule, int lsmslot)
 { }
 
 #endif /* defined(CONFIG_IMA_LSM_RULES) && defined(CONFIG_SECURITY) */
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index a8802b8da946..3ca046129ff0 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -93,6 +93,8 @@ struct ima_rule_entry {
 		void *rule;	/* LSM file metadata specific */
 		char *args_p;	/* audit value */
 		int type;	/* audit type */
+		int rules_lsm;	/* which LSM rule applies to */
+		bool lsm_specific;	/* true if lsm is specified */
 	} lsm[MAX_LSM_RULES];
 	char *fsname;
 	struct ima_rule_opt_list *keyrings; /* Measure keys added to these keyrings */
@@ -285,6 +287,30 @@ static int __init default_appraise_policy_setup(char *str)
 }
 __setup("ima_appraise_tcb", default_appraise_policy_setup);
 
+static int default_rules_lsm __ro_after_init = LSMBLOB_INVALID;
+
+static int __init ima_rules_lsm_init(char *str)
+{
+	const char *oldstr;
+	int newdrl;
+
+	newdrl = lsm_name_to_slot(str);
+	if (newdrl >= 0) {
+		default_rules_lsm = newdrl;
+		return 1;
+	}
+
+	oldstr = lsm_slot_to_name(default_rules_lsm);
+	if (oldstr) {
+		pr_err("default ima rule lsm \"%s\" not registered, continue using \"%s\"",
+		str, oldstr);
+		return 1;
+	}
+
+	return 1;
+}
+__setup("ima_rules_lsm=", ima_rules_lsm_init);
+
 static struct ima_rule_opt_list *ima_alloc_rule_opt_list(const substring_t *src)
 {
 	struct ima_rule_opt_list *opt_list;
@@ -356,7 +382,8 @@ static void ima_lsm_free_rule(struct ima_rule_entry *entry)
 	int i;
 
 	for (i = 0; i < MAX_LSM_RULES; i++) {
-		ima_filter_rule_free(entry->lsm[i].rule);
+		ima_filter_rule_free(entry->lsm[i].rule,
+				     entry->lsm[i].rules_lsm);
 		kfree(entry->lsm[i].args_p);
 	}
 }
@@ -407,7 +434,8 @@ static struct ima_rule_entry *ima_lsm_copy_rule(struct ima_rule_entry *entry)
 
 		ima_filter_rule_init(nentry->lsm[i].type, Audit_equal,
 				     nentry->lsm[i].args_p,
-				     &nentry->lsm[i].rule);
+				     &nentry->lsm[i].rule,
+				     entry->lsm[i].rules_lsm);
 		if (!nentry->lsm[i].rule)
 			pr_warn("rule for LSM \'%s\' is undefined\n",
 				nentry->lsm[i].args_p);
@@ -623,14 +651,16 @@ static bool ima_match_rules(struct ima_rule_entry *rule,
 			security_inode_getsecid(inode, &osid);
 			rc = ima_filter_rule_match(osid, rule->lsm[i].type,
 						   Audit_equal,
-						   rule->lsm[i].rule);
+						   rule->lsm[i].rule,
+						   rule->lsm[i].rules_lsm);
 			break;
 		case LSM_SUBJ_USER:
 		case LSM_SUBJ_ROLE:
 		case LSM_SUBJ_TYPE:
 			rc = ima_filter_rule_match(secid, rule->lsm[i].type,
 						   Audit_equal,
-						   rule->lsm[i].rule);
+						   rule->lsm[i].rule,
+						   rule->lsm[i].rules_lsm);
 			break;
 		default:
 			break;
@@ -1026,7 +1056,7 @@ enum policy_opt {
 	Opt_digest_type,
 	Opt_appraise_type, Opt_appraise_flag, Opt_appraise_algos,
 	Opt_permit_directio, Opt_pcr, Opt_template, Opt_keyrings,
-	Opt_label, Opt_err
+	Opt_lsm, Opt_label, Opt_err
 };
 
 static const match_table_t policy_tokens = {
@@ -1074,6 +1104,7 @@ static const match_table_t policy_tokens = {
 	{Opt_pcr, "pcr=%s"},
 	{Opt_template, "template=%s"},
 	{Opt_keyrings, "keyrings=%s"},
+	{Opt_lsm, "lsm=%s"},
 	{Opt_label, "label=%s"},
 	{Opt_err, NULL}
 };
@@ -1093,7 +1124,8 @@ static int ima_lsm_rule_init(struct ima_rule_entry *entry,
 	entry->lsm[lsm_rule].type = audit_type;
 	result = ima_filter_rule_init(entry->lsm[lsm_rule].type, Audit_equal,
 				      entry->lsm[lsm_rule].args_p,
-				      &entry->lsm[lsm_rule].rule);
+				      &entry->lsm[lsm_rule].rule,
+				      entry->lsm[lsm_rule].rules_lsm);
 	if (!entry->lsm[lsm_rule].rule) {
 		pr_warn("rule for LSM \'%s\' is undefined\n",
 			entry->lsm[lsm_rule].args_p);
@@ -1833,6 +1865,23 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 						 &(template_desc->num_fields));
 			entry->template = template_desc;
 			break;
+		case Opt_lsm: {
+			int i;
+
+			result = lsm_name_to_slot(args[0].from);
+			if (result < 0) {
+				for (i = 0; i < MAX_LSM_RULES; i++)
+					entry->lsm[i].args_p = NULL;
+				result = -EINVAL;
+				break;
+			}
+			for (i = 0; i < MAX_LSM_RULES; i++) {
+				entry->lsm[i].rules_lsm = result;
+				entry->lsm[i].lsm_specific = true;
+			}
+			result = 0;
+			break;
+			}
 		case Opt_err:
 			ima_log_string(ab, "UNKNOWN", p);
 			result = -EINVAL;
@@ -1878,6 +1927,7 @@ ssize_t ima_parse_add_rule(char *rule)
 	struct ima_rule_entry *entry;
 	ssize_t result, len;
 	int audit_info = 0;
+	int i;
 
 	p = strsep(&rule, "\n");
 	len = strlen(p) + 1;
@@ -1895,6 +1945,11 @@ ssize_t ima_parse_add_rule(char *rule)
 
 	INIT_LIST_HEAD(&entry->list);
 
+	for (i = 0; i < MAX_LSM_RULES; i++) {
+		entry->lsm[i].rules_lsm = default_rules_lsm;
+		entry->lsm[i].lsm_specific = false;
+	}
+
 	result = ima_parse_rule(p, entry);
 	if (result) {
 		ima_free_rule(entry);
@@ -2205,6 +2260,9 @@ int ima_policy_show(struct seq_file *m, void *v)
 					   entry->lsm[i].args_p);
 				break;
 			}
+			if (entry->lsm[i].lsm_specific)
+				seq_printf(m, pt(Opt_lsm),
+				    lsm_slot_to_name(entry->lsm[i].rules_lsm));
 			seq_puts(m, " ");
 		}
 	}
diff --git a/security/security.c b/security/security.c
index 2c197c25746c..b74debe82d82 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2745,19 +2745,42 @@ int security_audit_rule_match(u32 secid, u32 field, u32 op,
  * The integrity subsystem uses the same hooks as
  * the audit subsystem.
  */
-int ima_filter_rule_init(u32 field, u32 op, char *rulestr, void **lsmrule)
+int ima_filter_rule_init(u32 field, u32 op, char *rulestr, void **lsmrule,
+			 int lsmslot)
 {
-	return call_int_hook(audit_rule_init, 0, field, op, rulestr, lsmrule);
+	struct security_hook_list *hp;
+
+	hlist_for_each_entry(hp, &security_hook_heads.audit_rule_init, list)
+		if (hp->lsmid->slot == lsmslot)
+			return hp->hook.audit_rule_init(field, op, rulestr,
+							lsmrule);
+
+	return 0;
 }
 
-void ima_filter_rule_free(void *lsmrule)
+void ima_filter_rule_free(void *lsmrule, int lsmslot)
 {
-	call_void_hook(audit_rule_free, lsmrule);
+	struct security_hook_list *hp;
+
+	hlist_for_each_entry(hp, &security_hook_heads.audit_rule_free, list) {
+		if (hp->lsmid->slot == lsmslot) {
+			hp->hook.audit_rule_free(lsmrule);
+			return;
+		}
+	}
 }
 
-int ima_filter_rule_match(u32 secid, u32 field, u32 op, void *lsmrule)
+int ima_filter_rule_match(u32 secid, u32 field, u32 op, void *lsmrule,
+			  int lsmslot)
 {
-	return call_int_hook(audit_rule_match, 0, secid, field, op, lsmrule);
+	struct security_hook_list *hp;
+
+	hlist_for_each_entry(hp, &security_hook_heads.audit_rule_match, list)
+		if (hp->lsmid->slot == lsmslot)
+			return hp->hook.audit_rule_match(secid, field, op,
+							 lsmrule);
+
+	return 0;
 }
 #endif /* CONFIG_IMA_LSM_RULES */
 
-- 
2.37.3

