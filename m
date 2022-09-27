Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DB155ECD8A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 22:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232628AbiI0UAW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 16:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232460AbiI0T71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 15:59:27 -0400
Received: from sonic304-28.consmr.mail.ne1.yahoo.com (sonic304-28.consmr.mail.ne1.yahoo.com [66.163.191.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28F541C99EC
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 12:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1664308764; bh=2j7UGsHSPPjcEMmHo/E5FZypythEF36CkYKghcSQIOY=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=AchZhV+6/3MseuCzWe0BNGeoYxxcQJySKhEpx8q7d950qrRvt2GWodJ9ZfidcNl1eklRpVTn/VeK5PcRbPuOBiHHXJF453syvBBVjXs+YeacJ1xudatMWWUm12AwTnVn2laVdWs68tyYa387J4N0lC5bwtt8DgRTFR5/8Gb8mZ10vpbEax21ImrGSQQHr/WcS0GeNLSzgxX8yiDsngB8VkVmWnjkty4Z+Mk2Hk/Nq4v8iaWVfq7MSb2X5D0Sy6aWxb4AXr7YbXijhyNtn9j4m1tFqpDkETicaQKUXbdGsHLaT2Jvjt5wh50K3IGKNyURmugPuJfUS1bO2b/4/rGsUQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1664308764; bh=QBT+onn7uNeVxQOWktK4h/Nv7HxWTGhie9FXdjaSILc=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=k81jdACAPPGBqi7gGCBjiltVdR3w8uDqM8Doavws0mpiOGoUD9s/oSX3o/nRyn6RGa+WLhSrfCNmIdyhIxoMp68ye62d+V57ONOQdIhZgCeBJgi3f3GI8SSyRDtbwUyY4CDhR/JqPSCBulzSksnm9Kxuw8HDH0NFPcHDKKJU3h3Cx+uYEiuHxHb2bgqsAFK3mld01zRMBJRJx9sp3yj4Yz0SE6Ef8YejUdI554WuYoCNDVAHyVwyDyPCfdOjdO2LKG1VEHvTxUPKmoDN1vWclmy1Dr+CcyzcqAzzkW5GCW+pX52wcn00vVcflMDA/GCYE1PhDKrHpmvqWbAq94y8fQ==
X-YMail-OSG: byT.nXMVM1lDnmL6FHyYZFpZ5OjI0bITTuDa5TXpMMSOsZW2RKD_xen1VPhPeA1
 H7RExSlkUvnntj6C7jFGZRVARSR6YoKKEhudfsodvzk8qSbIUXOKtZE_IRLRChHE07BUUL5T96Hw
 AhnjbkpophrTKCVfusz2UVr5hSooLR2rBS3P1JLBlVcRpju9Vs.M4IB_XgY529FZTbRRsLcFXKNm
 j.kBu3A.ZIg0ZfOq5noEkgC1nfK1JLEM76aSYidOh_GjIbRrIegq8VgWcr0b_VJsd5YyOQqqja2W
 6fLuYPYIBGjh5.J4uygog1TJmS8zVwuw6jsEo.4S9lJFIx4d.mJqg1FNdr5..ulNW0nE2MO.dYtn
 BrsKQ0Q59IsSE0cU877PS6jPzBO34QgGduUzgsjFiK601mVbxe_CafroyUZY0CmK3_BLKxXIlcYE
 Ik7Q3O7eeDppn3neeLpHedcrq3AlWlqdlJGMFT38kExLc4413PNFsWk6xmbmSXzrSqy9vuawtWEv
 SSXDCiEJojMtEddPKIdORkrlfxnz6Ijprlm9yqvDzHgKN_HnfmCWmO5DlCpNgUu1_DC6J4kqkOYz
 bFRycgF1JO6ZpwU6oiJhHeErcTV3LrdFPcHGs_g1g_uRSp5y0cXWs__F3tZ_zmJ6V8l0DyM6kKj2
 yFdnZ1EAg.OrK3FKZjLxXXCSYDpRBYuXnlYDksX1eLSYey3.dOQVceqiAmRv.xRnuxQSoJEr4eY.
 ZZiD7sy5z862BrKWDhKyfWqwjbDtB4Hs20WrHUvjTkt5Uy.cGA8iQUhbZa3YHOSe66Tx7TRrboi6
 J5HZEUUFWNWrx7Unz6SoMRzEOwxCGqd.uepCnozQqOhknkQ_MPYuVIHEsIZdn8ywOYX9Q90sIbzs
 .7.lKBZ2l5ogvzDcARneMT1_wPZw6PxbeyBCjxnw53KuNlAW6bGT2_RZHgNiJ5PPJOLDL72OJQ2o
 BrR89IYON9yGv1kttXcrZkzZm22EbPCds06Dp4__Y0bJbAL4kkMVmKJ0NYYb_ojuSCc6DI_fOQWh
 NBstJ0wHhZYB9IVAdjfZYo1JnkZgQoa70y2ZeCgdG4I6Q.L5_MA5PqirF1oBC6IB8IVEAJUZyGK1
 sY9ik2_F2kl1GEl4ZiCDfB1MSl9wHKK7c63Udbq15u.wsuX1pWYpS2VU.bren4ocHXulI1Y.vzpY
 jBfJ2E71KEpDu_1mPpet9QDQNM7HRev.K5lOMSnlceDgVIogFJTIMWrHtYwel6I6T5keWSapDjDQ
 Ue8ERGbstojhpaa23rGwHYgMQ12YAab_Krl2eXwfhwSk.sNKcHr4qdxwwtviuJiDV5xyT7P7qO2g
 c24gNevzucJf_aQKhkUtQJNVmn6.7PHqaIjE6mrRm7TvwGc.Tb9urPI9QBSBEirQtheUqxxHLgqK
 U2ik2sbWcZuSko6zQqu7MYe.QrC4UYvstwebOmpGj1EtKwV0BZPoA.evLU9HL9KYoJrkAxHfDMSU
 HZcx5SwnAf1sWQ78ultxw3w94PL_KZxbrmmdhtCHP2srjkX9JhQ1UoUKWkaQA_w7HAiVy4bUpCoO
 gaJYBC2U4jtr.AYdj5KprBPS9ynFJZ.EUcm4Cq7xFuZ1yp7GgzPKST24FW3dbmxIFSgVVFpWkDpG
 38MB8253oBSgGXgyd9sDk4Bpj7pKo63Zyc0vdxp96bufUBwR4YTX4t5yU__lc280ImneT70ayEqj
 f7FiuwArREKU8Vtx8JZOpHH9AGZIRs9g.ymRZCQlUSfxlNDKXMWYqL4XOGZNjHzXpKeFw.LE3ny.
 c4a4Kjlepfv1u5AFJkRx47lJve9EopNrUOStKLiheCZHWT2iUoqEbqtZiB4VWdyXpjq6LxcWIGMs
 9iW7xoJs7RIcVYHeWjlmMCA1PI_IsSSkCywAIgRevgDxF40nRRoTiDtRvAY09yr7qDeVK57Hun2q
 6IYRmo_DCIiKQd6fVJvI7Dts1Kr3wzPgq0nbYpSy29oewHKiBkSO4XdixiaFDJoddnQmgb1OWGZk
 xxBI8kpN4qj77o0zD.nyTsd4H9kQyia_VbptDI9zDFQFXaWP1tYpO8zHKxgT3jMEs0cuE2P7uUDL
 1EUAWD_tP2kOOc2eHQUq_fLthETgfSBDE1CCkyZPCaNqlpla1I5ILskH9ma5nRitSQ_EzmbAd_Ox
 CpOCTj5zB2lnpaYL8VEqPZdRByInGVsaYZVzJKCF54PPbp.SRVZvmEfqUYdI.7r0xVxh.LcUU0MD
 gjExBZt2xTRGuDjwKOPkBeuwXw2iMj3ulh5W7PHwgGA0NOr_pN_f9tLD6Mp6b
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ne1.yahoo.com with HTTP; Tue, 27 Sep 2022 19:59:24 +0000
Received: by hermes--production-gq1-7dfd88c84d-mgq76 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID a8608bb7fdb0322afb9a5fe3db2c5570;
          Tue, 27 Sep 2022 19:59:22 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com, jmorris@namei.org,
        selinux@vger.kernel.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH v38 09/39] LSM: Add the lsmblob data structure.
Date:   Tue, 27 Sep 2022 12:53:51 -0700
Message-Id: <20220927195421.14713-10-casey@schaufler-ca.com>
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

When more than one security module is exporting data to
audit and networking sub-systems a single 32 bit integer
is no longer sufficient to represent the data. Add a
structure to be used instead.

The lsmblob structure is currently an array of
u32 "secids". There is an entry for each of the security
modules built into the system that would use secids if
active. The system assigns the module a "slot" when it
registers hooks. If modules are compiled in but not
registered there will be unused slots. The slot number
is added to the lsm_id structure.

The audit rules data is expanded to use an array of
security module data rather than a single instance.
A new structure audit_lsm_rules is defined to avoid the
confusion which commonly accompanies the use of
void ** parameters.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/audit.h        |  9 ++++-
 include/linux/lsm_hooks.h    |  1 +
 include/linux/security.h     | 75 +++++++++++++++++++++++++++++++++---
 kernel/auditfilter.c         | 23 +++++------
 kernel/auditsc.c             | 17 ++++----
 security/apparmor/lsm.c      |  1 +
 security/bpf/hooks.c         |  1 +
 security/commoncap.c         |  1 +
 security/landlock/setup.c    |  1 +
 security/loadpin/loadpin.c   |  1 +
 security/lockdown/lockdown.c |  1 +
 security/safesetid/lsm.c     |  1 +
 security/security.c          | 70 ++++++++++++++++++++++++++++++---
 security/selinux/hooks.c     |  1 +
 security/smack/smack_lsm.c   |  1 +
 security/tomoyo/tomoyo.c     |  1 +
 security/yama/yama_lsm.c     |  1 +
 17 files changed, 171 insertions(+), 35 deletions(-)

diff --git a/include/linux/audit.h b/include/linux/audit.h
index 3608992848d3..edb919722448 100644
--- a/include/linux/audit.h
+++ b/include/linux/audit.h
@@ -11,6 +11,7 @@
 
 #include <linux/sched.h>
 #include <linux/ptrace.h>
+#include <linux/security.h>
 #include <linux/audit_arch.h>
 #include <uapi/linux/audit.h>
 #include <uapi/linux/netfilter/nf_tables.h>
@@ -59,6 +60,10 @@ struct audit_krule {
 /* Flag to indicate legacy AUDIT_LOGINUID unset usage */
 #define AUDIT_LOGINUID_LEGACY		0x1
 
+struct audit_lsm_rules {
+	void	*rule[LSMBLOB_ENTRIES];
+};
+
 struct audit_field {
 	u32				type;
 	union {
@@ -66,8 +71,8 @@ struct audit_field {
 		kuid_t			uid;
 		kgid_t			gid;
 		struct {
-			char		*lsm_str;
-			void		*lsm_rule;
+			char			*lsm_str;
+			struct audit_lsm_rules	lsm_rules;
 		};
 	};
 	u32				op;
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index b266d0826278..db251a51d4cb 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1605,6 +1605,7 @@ struct lsm_id {
 	const char	*lsm;		/* Name of the LSM */
 	int		id;		/* LSM ID */
 	int		features;	/* Set of LSM features */
+	int		slot;		/* Slot in lsmblob if allocated */
 };
 
 /*
diff --git a/include/linux/security.h b/include/linux/security.h
index fe3273a6498f..c1f8b33e7c27 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -39,6 +39,7 @@ struct kernel_siginfo;
 struct sembuf;
 struct kern_ipc_perm;
 struct audit_context;
+struct audit_lsm_rules;
 struct super_block;
 struct inode;
 struct dentry;
@@ -153,6 +154,66 @@ extern const char *const lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1];
 extern int lsm_id;
 extern struct lsm_id *lsm_idlist[];
 
+/*
+ * Data exported by the security modules
+ *
+ * Any LSM that provides secid or secctx based hooks must be included.
+ */
+#define LSMBLOB_ENTRIES ( \
+	(IS_ENABLED(CONFIG_SECURITY_SELINUX) ? 1 : 0) + \
+	(IS_ENABLED(CONFIG_SECURITY_SMACK) ? 1 : 0) + \
+	(IS_ENABLED(CONFIG_SECURITY_APPARMOR) ? 1 : 0) + \
+	(IS_ENABLED(CONFIG_BPF_LSM) ? 1 : 0))
+
+struct lsmblob {
+	u32     secid[LSMBLOB_ENTRIES];
+};
+
+#define LSMBLOB_INVALID		-1	/* Not a valid LSM slot number */
+#define LSMBLOB_NEEDED		-2	/* Slot requested on initialization */
+#define LSMBLOB_NOT_NEEDED	-3	/* Slot not requested */
+
+/**
+ * lsmblob_init - initialize a lsmblob structure
+ * @blob: Pointer to the data to initialize
+ * @secid: The initial secid value
+ *
+ * Set all secid for all modules to the specified value.
+ */
+static inline void lsmblob_init(struct lsmblob *blob, u32 secid)
+{
+	int i;
+
+	for (i = 0; i < LSMBLOB_ENTRIES; i++)
+		blob->secid[i] = secid;
+}
+
+/**
+ * lsmblob_is_set - report if there is a value in the lsmblob
+ * @blob: Pointer to the exported LSM data
+ *
+ * Returns true if there is a secid set, false otherwise
+ */
+static inline bool lsmblob_is_set(struct lsmblob *blob)
+{
+	const struct lsmblob empty = {};
+
+	return !!memcmp(blob, &empty, sizeof(*blob));
+}
+
+/**
+ * lsmblob_equal - report if the two lsmblob's are equal
+ * @bloba: Pointer to one LSM data
+ * @blobb: Pointer to the other LSM data
+ *
+ * Returns true if all entries in the two are equal, false otherwise
+ */
+static inline bool lsmblob_equal(const struct lsmblob *bloba,
+				 const struct lsmblob *blobb)
+{
+	return !memcmp(bloba, blobb, sizeof(*bloba));
+}
+
 /* These functions are in security/commoncap.c */
 extern int cap_capable(const struct cred *cred, struct user_namespace *ns,
 		       int cap, unsigned int opts);
@@ -1914,15 +1975,17 @@ static inline int security_key_getsecurity(struct key *key, char **_buffer)
 
 #ifdef CONFIG_AUDIT
 #ifdef CONFIG_SECURITY
-int security_audit_rule_init(u32 field, u32 op, char *rulestr, void **lsmrule);
+int security_audit_rule_init(u32 field, u32 op, char *rulestr,
+			     struct audit_lsm_rules *lsmrules);
 int security_audit_rule_known(struct audit_krule *krule);
-int security_audit_rule_match(u32 secid, u32 field, u32 op, void *lsmrule);
-void security_audit_rule_free(void *lsmrule);
+int security_audit_rule_match(u32 secid, u32 field, u32 op,
+			      struct audit_lsm_rules *lsmrules);
+void security_audit_rule_free(struct audit_lsm_rules *lsmrules);
 
 #else
 
 static inline int security_audit_rule_init(u32 field, u32 op, char *rulestr,
-					   void **lsmrule)
+					   struct audit_lsm_rules *lsmrules)
 {
 	return 0;
 }
@@ -1933,12 +1996,12 @@ static inline int security_audit_rule_known(struct audit_krule *krule)
 }
 
 static inline int security_audit_rule_match(u32 secid, u32 field, u32 op,
-					    void *lsmrule)
+					    struct audit_lsm_rules *lsmrules)
 {
 	return 0;
 }
 
-static inline void security_audit_rule_free(void *lsmrule)
+static inline void security_audit_rule_free(struct audit_lsm_rules *lsmrules)
 { }
 
 #endif /* CONFIG_SECURITY */
diff --git a/kernel/auditfilter.c b/kernel/auditfilter.c
index 42d99896e7a6..de75bd6ad866 100644
--- a/kernel/auditfilter.c
+++ b/kernel/auditfilter.c
@@ -76,7 +76,7 @@ static void audit_free_lsm_field(struct audit_field *f)
 	case AUDIT_OBJ_LEV_LOW:
 	case AUDIT_OBJ_LEV_HIGH:
 		kfree(f->lsm_str);
-		security_audit_rule_free(f->lsm_rule);
+		security_audit_rule_free(&f->lsm_rules);
 	}
 }
 
@@ -529,7 +529,7 @@ static struct audit_entry *audit_data_to_entry(struct audit_rule_data *data,
 			entry->rule.buflen += f_val;
 			f->lsm_str = str;
 			err = security_audit_rule_init(f->type, f->op, str,
-						       (void **)&f->lsm_rule);
+						       &f->lsm_rules);
 			/* Keep currently invalid fields around in case they
 			 * become valid after a policy reload. */
 			if (err == -EINVAL) {
@@ -782,7 +782,7 @@ static int audit_compare_rule(struct audit_krule *a, struct audit_krule *b)
 	return 0;
 }
 
-/* Duplicate LSM field information.  The lsm_rule is opaque, so must be
+/* Duplicate LSM field information.  The lsm_rules is opaque, so must be
  * re-initialized. */
 static inline int audit_dupe_lsm_field(struct audit_field *df,
 					   struct audit_field *sf)
@@ -796,9 +796,9 @@ static inline int audit_dupe_lsm_field(struct audit_field *df,
 		return -ENOMEM;
 	df->lsm_str = lsm_str;
 
-	/* our own (refreshed) copy of lsm_rule */
+	/* our own (refreshed) copy of lsm_rules */
 	ret = security_audit_rule_init(df->type, df->op, df->lsm_str,
-				       (void **)&df->lsm_rule);
+				       &df->lsm_rules);
 	/* Keep currently invalid fields around in case they
 	 * become valid after a policy reload. */
 	if (ret == -EINVAL) {
@@ -850,7 +850,7 @@ struct audit_entry *audit_dupe_rule(struct audit_krule *old)
 	new->tree = old->tree;
 	memcpy(new->fields, old->fields, sizeof(struct audit_field) * fcount);
 
-	/* deep copy this information, updating the lsm_rule fields, because
+	/* deep copy this information, updating the lsm_rules fields, because
 	 * the originals will all be freed when the old rule is freed. */
 	for (i = 0; i < fcount; i++) {
 		switch (new->fields[i].type) {
@@ -1367,10 +1367,11 @@ int audit_filter(int msgtype, unsigned int listtype)
 			case AUDIT_SUBJ_TYPE:
 			case AUDIT_SUBJ_SEN:
 			case AUDIT_SUBJ_CLR:
-				if (f->lsm_rule) {
+				if (f->lsm_str) {
 					security_current_getsecid_subj(&sid);
 					result = security_audit_rule_match(sid,
-						   f->type, f->op, f->lsm_rule);
+						   f->type, f->op,
+						   &f->lsm_rules);
 				}
 				break;
 			case AUDIT_EXE:
@@ -1397,7 +1398,7 @@ int audit_filter(int msgtype, unsigned int listtype)
 	return ret;
 }
 
-static int update_lsm_rule(struct audit_krule *r)
+static int update_lsm_rules(struct audit_krule *r)
 {
 	struct audit_entry *entry = container_of(r, struct audit_entry, rule);
 	struct audit_entry *nentry;
@@ -1429,7 +1430,7 @@ static int update_lsm_rule(struct audit_krule *r)
 	return err;
 }
 
-/* This function will re-initialize the lsm_rule field of all applicable rules.
+/* This function will re-initialize the lsm_rules field of all applicable rules.
  * It will traverse the filter lists serarching for rules that contain LSM
  * specific filter fields.  When such a rule is found, it is copied, the
  * LSM field is re-initialized, and the old rule is replaced with the
@@ -1444,7 +1445,7 @@ int audit_update_lsm_rules(void)
 
 	for (i = 0; i < AUDIT_NR_FILTERS; i++) {
 		list_for_each_entry_safe(r, n, &audit_rules_list[i], list) {
-			int res = update_lsm_rule(r);
+			int res = update_lsm_rules(r);
 			if (!err)
 				err = res;
 		}
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 79a5da1bc5bb..482805f6ea68 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -664,7 +664,7 @@ static int audit_filter_rules(struct task_struct *tsk,
 			   match for now to avoid losing information that
 			   may be wanted.   An error message will also be
 			   logged upon error */
-			if (f->lsm_rule) {
+			if (f->lsm_str) {
 				if (need_sid) {
 					/* @tsk should always be equal to
 					 * @current with the exception of
@@ -679,8 +679,7 @@ static int audit_filter_rules(struct task_struct *tsk,
 					need_sid = 0;
 				}
 				result = security_audit_rule_match(sid, f->type,
-								   f->op,
-								   f->lsm_rule);
+							f->op, &f->lsm_rules);
 			}
 			break;
 		case AUDIT_OBJ_USER:
@@ -690,21 +689,19 @@ static int audit_filter_rules(struct task_struct *tsk,
 		case AUDIT_OBJ_LEV_HIGH:
 			/* The above note for AUDIT_SUBJ_USER...AUDIT_SUBJ_CLR
 			   also applies here */
-			if (f->lsm_rule) {
+			if (f->lsm_str) {
 				/* Find files that match */
 				if (name) {
 					result = security_audit_rule_match(
 								name->osid,
 								f->type,
 								f->op,
-								f->lsm_rule);
+								&f->lsm_rules);
 				} else if (ctx) {
 					list_for_each_entry(n, &ctx->names_list, list) {
 						if (security_audit_rule_match(
-								n->osid,
-								f->type,
-								f->op,
-								f->lsm_rule)) {
+							n->osid, f->type, f->op,
+							&f->lsm_rules)) {
 							++result;
 							break;
 						}
@@ -715,7 +712,7 @@ static int audit_filter_rules(struct task_struct *tsk,
 					break;
 				if (security_audit_rule_match(ctx->ipc.osid,
 							      f->type, f->op,
-							      f->lsm_rule))
+							      &f->lsm_rules))
 					++result;
 			}
 			break;
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index caad42a0c913..25423a3aa572 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -1190,6 +1190,7 @@ static struct lsm_id apparmor_lsmid __lsm_ro_after_init = {
 	.lsm      = "apparmor",
 	.id       = LSM_ID_APPARMOR,
 	.features = LSM_ATTR_CURRENT | LSM_ATTR_PREV | LSM_ATTR_EXEC,
+	.slot     = LSMBLOB_NEEDED,
 };
 
 static struct security_hook_list apparmor_hooks[] __lsm_ro_after_init = {
diff --git a/security/bpf/hooks.c b/security/bpf/hooks.c
index c462fc41dd57..d92a21ca3d1b 100644
--- a/security/bpf/hooks.c
+++ b/security/bpf/hooks.c
@@ -23,6 +23,7 @@ static struct security_hook_list bpf_lsm_hooks[] __lsm_ro_after_init = {
 struct lsm_id bpf_lsmid __lsm_ro_after_init = {
 	.lsm      = "bpf",
 	.id       = LSM_ID_BPF,
+	.slot     = LSMBLOB_NEEDED,
 };
 
 static int __init bpf_lsm_init(void)
diff --git a/security/commoncap.c b/security/commoncap.c
index 4e9b140159d8..29c7642a9fb5 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -1450,6 +1450,7 @@ int cap_mmap_file(struct file *file, unsigned long reqprot,
 static struct lsm_id capability_lsmid __lsm_ro_after_init = {
 	.lsm      = "capability",
 	.id       = LSM_ID_CAPABILITY,
+	.slot     = LSMBLOB_NOT_NEEDED,
 };
 
 static struct security_hook_list capability_hooks[] __lsm_ro_after_init = {
diff --git a/security/landlock/setup.c b/security/landlock/setup.c
index 1242c61c9de4..adbe941370f3 100644
--- a/security/landlock/setup.c
+++ b/security/landlock/setup.c
@@ -27,6 +27,7 @@ struct lsm_blob_sizes landlock_blob_sizes __lsm_ro_after_init = {
 struct lsm_id landlock_lsmid __lsm_ro_after_init = {
 	.lsm      = LANDLOCK_NAME,
 	.id       = LSM_ID_LANDLOCK,
+	.slot     = LSMBLOB_NOT_NEEDED,
 };
 
 static int __init landlock_init(void)
diff --git a/security/loadpin/loadpin.c b/security/loadpin/loadpin.c
index 276c8a7cd6fe..c3f5678b92c4 100644
--- a/security/loadpin/loadpin.c
+++ b/security/loadpin/loadpin.c
@@ -199,6 +199,7 @@ static int loadpin_load_data(enum kernel_load_data_id id, bool contents)
 static struct lsm_id loadpin_lsmid __lsm_ro_after_init = {
 	.lsm      = "loadpin",
 	.id       = LSM_ID_LOADPIN,
+	.slot     = LSMBLOB_NOT_NEEDED,
 };
 
 static struct security_hook_list loadpin_hooks[] __lsm_ro_after_init = {
diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
index 3d3347f3dbd1..1f87e8d43387 100644
--- a/security/lockdown/lockdown.c
+++ b/security/lockdown/lockdown.c
@@ -79,6 +79,7 @@ static struct security_hook_list lockdown_hooks[] __lsm_ro_after_init = {
 static struct lsm_id lockdown_lsmid __lsm_ro_after_init = {
 	.lsm      = "lockdown",
 	.id       = LSM_ID_LOCKDOWN,
+	.slot     = LSMBLOB_NOT_NEEDED,
 };
 
 static int __init lockdown_lsm_init(void)
diff --git a/security/safesetid/lsm.c b/security/safesetid/lsm.c
index 88002731e603..bddf9a28c270 100644
--- a/security/safesetid/lsm.c
+++ b/security/safesetid/lsm.c
@@ -265,6 +265,7 @@ static int safesetid_task_fix_setgroups(struct cred *new, const struct cred *old
 static struct lsm_id safesetid_lsmid __lsm_ro_after_init = {
 	.lsm      = "safesetid",
 	.id       = LSM_ID_SAFESETID,
+	.slot     = LSMBLOB_NOT_NEEDED,
 };
 
 static struct security_hook_list safesetid_security_hooks[] = {
diff --git a/security/security.c b/security/security.c
index 7a604a74716a..b837500cb3dc 100644
--- a/security/security.c
+++ b/security/security.c
@@ -354,6 +354,7 @@ static void __init ordered_lsm_init(void)
 	init_debug("sock blob size       = %d\n", blob_sizes.lbs_sock);
 	init_debug("superblock blob size = %d\n", blob_sizes.lbs_superblock);
 	init_debug("task blob size       = %d\n", blob_sizes.lbs_task);
+	init_debug("lsmblob size         = %zu\n", sizeof(struct lsmblob));
 
 	/*
 	 * Create any kmem_caches needed for blobs
@@ -481,6 +482,11 @@ static int lsm_append(const char *new, char **result)
 	return 0;
 }
 
+/*
+ * Current index to use while initializing the lsmblob secid list.
+ */
+static int lsm_slot __lsm_ro_after_init;
+
 /**
  * security_add_hooks - Add a modules hooks to the hook lists.
  * @hooks: the hooks to add
@@ -488,6 +494,8 @@ static int lsm_append(const char *new, char **result)
  * @lsmid: the identification information for the security module
  *
  * Each LSM has to register its hooks with the infrastructure.
+ * If the LSM is using hooks that export secids allocate a slot
+ * for it in the lsmblob.
  */
 void __init security_add_hooks(struct security_hook_list *hooks, int count,
 			       struct lsm_id *lsmid)
@@ -504,6 +512,16 @@ void __init security_add_hooks(struct security_hook_list *hooks, int count,
 	if (lsm_id > LSMID_ENTRIES)
 		panic("%s Too many LSMs registered.\n", __func__);
 
+	WARN_ON(!lsmid->slot || !lsmid->id);
+
+	if (lsmid->slot == LSMBLOB_NEEDED) {
+		if (lsm_slot >= LSMBLOB_ENTRIES)
+			panic("%s Too many LSMs registered.\n", __func__);
+		lsmid->slot = lsm_slot++;
+		init_debug("%s assigned lsmblob slot %d\n", lsmid->lsm,
+			   lsmid->slot);
+	}
+
 	for (i = 0; i < count; i++) {
 		hooks[i].lsmid = lsmid;
 		hlist_add_tail_rcu(&hooks[i].list, hooks[i].head);
@@ -2616,9 +2634,27 @@ int security_key_getsecurity(struct key *key, char **_buffer)
 
 #ifdef CONFIG_AUDIT
 
-int security_audit_rule_init(u32 field, u32 op, char *rulestr, void **lsmrule)
+int security_audit_rule_init(u32 field, u32 op, char *rulestr,
+			     struct audit_lsm_rules *lsmrules)
 {
-	return call_int_hook(audit_rule_init, 0, field, op, rulestr, lsmrule);
+	struct security_hook_list *hp;
+	bool one_is_good = false;
+	int rc = 0;
+	int trc;
+
+	hlist_for_each_entry(hp, &security_hook_heads.audit_rule_init, list) {
+		if (WARN_ON(hp->lsmid->slot < 0 || hp->lsmid->slot >= lsm_slot))
+			continue;
+		trc = hp->hook.audit_rule_init(field, op, rulestr,
+					&lsmrules->rule[hp->lsmid->slot]);
+		if (trc == 0)
+			one_is_good = true;
+		else
+			rc = trc;
+	}
+	if (one_is_good)
+		return 0;
+	return rc;
 }
 
 int security_audit_rule_known(struct audit_krule *krule)
@@ -2626,14 +2662,36 @@ int security_audit_rule_known(struct audit_krule *krule)
 	return call_int_hook(audit_rule_known, 0, krule);
 }
 
-void security_audit_rule_free(void *lsmrule)
+void security_audit_rule_free(struct audit_lsm_rules *lsmrules)
 {
-	call_void_hook(audit_rule_free, lsmrule);
+	struct security_hook_list *hp;
+
+	hlist_for_each_entry(hp, &security_hook_heads.audit_rule_free, list) {
+		if (WARN_ON(hp->lsmid->slot < 0 || hp->lsmid->slot >= lsm_slot))
+			continue;
+		if (lsmrules->rule[hp->lsmid->slot] == NULL)
+			continue;
+		hp->hook.audit_rule_free(lsmrules->rule[hp->lsmid->slot]);
+	}
 }
 
-int security_audit_rule_match(u32 secid, u32 field, u32 op, void *lsmrule)
+int security_audit_rule_match(u32 secid, u32 field, u32 op,
+			      struct audit_lsm_rules *lsmrules)
 {
-	return call_int_hook(audit_rule_match, 0, secid, field, op, lsmrule);
+	struct security_hook_list *hp;
+	int rc;
+
+	hlist_for_each_entry(hp, &security_hook_heads.audit_rule_match, list) {
+		if (WARN_ON(hp->lsmid->slot < 0 || hp->lsmid->slot >= lsm_slot))
+			continue;
+		if (lsmrules->rule[hp->lsmid->slot] == NULL)
+			continue;
+		rc = hp->hook.audit_rule_match(secid, field, op,
+					&lsmrules->rule[hp->lsmid->slot]);
+		if (rc)
+			return rc;
+	}
+	return 0;
 }
 #endif /* CONFIG_AUDIT */
 
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 25cc17bdd33c..cf89ccaa018d 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -7014,6 +7014,7 @@ static struct lsm_id selinux_lsmid __lsm_ro_after_init = {
 	.id       = LSM_ID_SELINUX,
 	.features = LSM_ATTR_CURRENT | LSM_ATTR_EXEC | LSM_ATTR_FSCREATE |
 		    LSM_ATTR_KEYCREATE | LSM_ATTR_PREV | LSM_ATTR_SOCKCREATE,
+	.slot     = LSMBLOB_NEEDED,
 };
 
 /*
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index c399ed799ceb..fbcf20ef1394 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -4773,6 +4773,7 @@ static struct lsm_id smack_lsmid __lsm_ro_after_init = {
 	.lsm      = "smack",
 	.id       = LSM_ID_SMACK,
 	.features = LSM_ATTR_CURRENT,
+	.slot     = LSMBLOB_NEEDED,
 };
 
 static struct security_hook_list smack_hooks[] __lsm_ro_after_init = {
diff --git a/security/tomoyo/tomoyo.c b/security/tomoyo/tomoyo.c
index 71eab206ba6e..78b11332eb5b 100644
--- a/security/tomoyo/tomoyo.c
+++ b/security/tomoyo/tomoyo.c
@@ -534,6 +534,7 @@ static void tomoyo_task_free(struct task_struct *task)
 static struct lsm_id tomoyo_lsmid __lsm_ro_after_init = {
 	.lsm      = "tomoyo",
 	.id       = LSM_ID_TOMOYO,
+	.slot     = LSMBLOB_NOT_NEEDED,
 };
 
 /*
diff --git a/security/yama/yama_lsm.c b/security/yama/yama_lsm.c
index b178d74bb00b..e11dd71553f4 100644
--- a/security/yama/yama_lsm.c
+++ b/security/yama/yama_lsm.c
@@ -425,6 +425,7 @@ static int yama_ptrace_traceme(struct task_struct *parent)
 static struct lsm_id yama_lsmid __lsm_ro_after_init = {
 	.lsm      = "yama",
 	.id       = LSM_ID_YAMA,
+	.slot     = LSMBLOB_NOT_NEEDED,
 };
 
 static struct security_hook_list yama_hooks[] __lsm_ro_after_init = {
-- 
2.37.3

