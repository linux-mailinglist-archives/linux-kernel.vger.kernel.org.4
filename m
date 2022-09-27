Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89B355ECE1E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 22:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbiI0UON (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 16:14:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232836AbiI0UNW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 16:13:22 -0400
Received: from sonic306-27.consmr.mail.ne1.yahoo.com (sonic306-27.consmr.mail.ne1.yahoo.com [66.163.189.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 106C61EC1DE
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 13:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1664309551; bh=aZJM8WmfsZdDKTx7uGoS+DGJ0MlOqOkeMU/mije9rvY=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=ZkR4aVZ690kkOunMOg3Et2u0DV1Oj/nSXTSnxS0KE2xudZksOFsYTZ5bfbwdGrk5KvM6HkjGYzMZhV0Unm0HJQMe+zxXvD1t56a9083zPQwEt+IaxLUECqOn8xGBNvgbFB2CjkfS70Y0V28x8yz+lBDwzbkfFNICdCWuiD0XvtvMAMAt2IQqngFHBZQi11Joefl1+wRAWtP1acfZNeEI0WhLzVjMa/FAQka+m+j5ahOdT41TLnQSIr1m4HJj1qwbaXJdD0bi7UD/i27Q0K6dUUNgcNmWtK2HERYTDbXsiYP7dM7aYcsnSiH33dpir3kPRCcTyfSNVDbIzYnuQaqLsw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1664309551; bh=pl1Gh4uIxRC7hNMCvd9w9Zsip/ZOdh9RaWWoT+8FUCO=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=IPht/0EpIBuxprwPg6/0ysMiLL3PNCNEkr3KRenrkxtbSjHla/M1bh/EpzoQnc9fk2B0bbQsBiX8vibhwhCcMHbTKdQLuWx8Z/GXV7HDma+6Z0xAR0eEMHSX2DvHJ9m//gpAcHt7Twd3pEYgLRoZGeeFMnsSJ4Zao4JCsIpro1UzQypmhkTkzZOjXYT9dWj6QPl/+ggtoI7YArO/5Jc47rqHy4944vbF2JpXmhyAubX9Z5X3T6fx1kNC2FSBW2M5wcoQZRbspURe1/6qzGCMHHs4moyujHpQsdOHN2mvImpDV6EBdQrTBdCKZWoOdQvchJ+YAiF/H/axsqYlA1Z32w==
X-YMail-OSG: e3v8OPMVM1kFHlkT.RUFd1.wsFQBEcYPJfzD59jmuzgCIleg0pCoU74dM1.WbbB
 o5RbXmdaOLQgcmaICgh719UR4QYso7rVVtgwCbzxeImaw.KUOO_QEWUJZTW_1rU1qxQV67ocgLyd
 BJvKCVvjjiK0ThslYoRjYYkztgx66zh1RhgL16lfWK5bzAW7JWsz2ngst.SmrfAgv5f2TiEvtTFX
 15Xg5G8gA.FKOxpNoq9tWBjfYlFJuA8pCNqEY9eYNamOeswmV3XLNCSMtX0mEGZ4AETr3ETLmG9P
 JAyBGTELZ6p6ofPXPmzBw98JTuuCn70SjfTrgfX.Uy9Ib_wdb0E18lvafe6rNt8APta0WZr7ugZ8
 v5cPcZ4cSulKJr_bNrTCornFjuEcDIpOT3nsxmjJzzrWEn_qEMusVshotY5nZvzVb6IxByYmiuRO
 yoVy0OWn12yP0oDc2Q6VBk40knU2FJpnGR5OuVboliJsDgv31KaUUR4TJvSAuVc.shN_VOHzI83e
 5oghTLE63Pnp9ibSczvAzBpgPw1uqIh2X5tZX5hSbDycWhKj7Ki9fF2USdYOzBm7GZA7W5ECw597
 z1p34XKIFLBQOyOA3hd563X1G8_TPyBJAKjagp3uCM9.Mu5aGxc7uqiS97ljeEaEV1skpND.AyLY
 ee..XifVG17HG0DZz6sfIXOYWnkRnwBkMqIW5FFzh8rFJ_yfqRPYRVIbgly6h.VKf5qPQH1UUve6
 AsOhtRbvU.7FkxEAhOmh68Ky25uktrNXXmC7EuvV6nlkLhDf3H2ZoXciI00ebg2QXTC8e48MDGfE
 snTMLZDAwKGrRd8OTXLt6tfOaoDrZ3Qu1ppUyPMMtJIygiervoI4SNqcJ2fRSS5E4jcTFgClTe6x
 cGQ_EGmMkPuJXj0u9jWbzEavARqzlv7zpvD77H8UmHm.au6NLcyKeVmKDbmXXQbi_31HpgMwki5G
 UoAdUOc_z44ZiY4elfp7akOYgeRF98iLYd3sKrvlnqvW9Noy9f6fAp2iYQRLKB3zYoNaslZtOKr2
 _GKy5LDJDJU90RrJVojVx6x9vxdPwMz750VAQl6SqNwvgleaAHoc6PMOeDoetK92.htow1TjAfyx
 BuNEZ8FhT21GSDD6aQogsZwOScbxRXlyWkB9p1r3awUPZzxVz47i2N29PZmiWRSaRv7La2DNK2i5
 _vRWUMbrB.YMMbMcHu7jxQarxSf.cD7ulT8ltjr4Enf9yQdZk54PbaCjhnWP4YvkLQIm1EoXkhDH
 DeKHfqjYCMA2qdBpiNO_qnHu4Oi4GI.kiOH78QCF9Yb.NfvWVZnYwcd8J8_N67UfWIgLRLBNEmqb
 SDbRs9bXybvAQVKeVrgLpSsrZxLo5esf3Z3azX3WclWif6wH3f4sEsl0ewOxMnKyGESNguv8Lekp
 eMteIA18S17FIiOOUBsSzs4vX8rwnePpvt8V41RQxRwSo1lH5R7NJqK0iWCNLT4rSk_SyXPfRTl0
 y0bgWGFo9XrAtk1qdRnrKw_GWLBbh90KZh6zDFXHmrLWs017.9xrdOyIBW9TBn2pOFDZVOeCA7gB
 8gr9VLvKn9rhSq0DzK6ivqYrjiVia5C9KEtLL6ph3tV8BmDnSbqdCgTnC1dgnS4fgq4r.orVPsYh
 LTzc28dLiIcA3jLmo9wcFRMmcZ0oMtx8_P6CpzNObo_KwXJehgk6JgRCdVn0gNhM52RGvgrZhhQi
 M6uFNj2uBzHn8_deFl20c65uGKfRUeDOCAIoP1cPx.y1j2eV.CE5Ni_sywu5bLNpEVfF0ioPDkbZ
 j1stkNXPoZUCDO9JTK0rer8zZKvZ5vZRqd2mQM4l0iLvy2.8ccyc1IDrLzAB_Rl2Gs0U3IDKZls2
 HzAqsSXVzX0zRJCOvcofxa7huWUTXExd.JTEVo5zCOkKynSE5_IIMpOhd2.lqESY2yn97OpDpm8O
 IRtTMRlZFWML0oqcfBPqT8yLwsvFxhXczD0hzTN5R.ovxhrxqmVOp.XJCVZOB1SKMsi_gZlrqCpr
 ctBPtG9xNCJ7FFvdrrKdO9yuj.iSUlvDn_G7W5.NdUdswDoNrm3M0G9lL2Ig09X7U4tPDNo2cFDs
 i4_be4aW6xs763wJ_ahVSvLKerHLAfFxM6gkEYp3wYa2TDD9FpRjVcbeQfV3S1O.UjjASKC4j.L.
 _UvH_XI9GdM_YeulJmIk1.NNgZM6xfxdH8WFj9e2GsdGmOLpTi_dgjf5XQ7k6yrtLI_7polNWjMr
 9hfAMAuHOA4skx2SeUwNjfQuTAY2Rtnaed2w7PaTDB9D9esK7a4KTGb1M.g7FWw--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Tue, 27 Sep 2022 20:12:31 +0000
Received: by hermes--production-gq1-7dfd88c84d-nfz27 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 1d976fe2ee917226e6d7cc50e923ce4f;
          Tue, 27 Sep 2022 20:12:26 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com, jmorris@namei.org,
        selinux@vger.kernel.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH v38 35/39] Audit: Add record for multiple object contexts
Date:   Tue, 27 Sep 2022 12:54:17 -0700
Message-Id: <20220927195421.14713-36-casey@schaufler-ca.com>
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

Create a new audit record AUDIT_MAC_OBJ_CONTEXTS.
An example of the MAC_OBJ_CONTEXTS (1421) record is:

    type=MAC_OBJ_CONTEXTS[1421]
    msg=audit(1601152467.009:1050):
    obj_selinux=unconfined_u:object_r:user_home_t:s0

When an audit event includes a AUDIT_MAC_OBJ_CONTEXTS record
the "obj=" field in other records in the event will be "obj=?".
An AUDIT_MAC_OBJ_CONTEXTS record is supplied when the system has
multiple security modules that may make access decisions based
on an object security context.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Acked-by: Paul Moore <paul@paul-moore.com>
---
 include/linux/audit.h      |  5 +++
 include/uapi/linux/audit.h |  1 +
 kernel/audit.c             | 49 ++++++++++++++++++++++-
 kernel/auditsc.c           | 79 ++++++++++++--------------------------
 4 files changed, 78 insertions(+), 56 deletions(-)

diff --git a/include/linux/audit.h b/include/linux/audit.h
index 87ba6fe7f1a2..ce3f034e0c04 100644
--- a/include/linux/audit.h
+++ b/include/linux/audit.h
@@ -188,6 +188,8 @@ extern void		    audit_log_path_denied(int type,
 						  const char *operation);
 extern void		    audit_log_lost(const char *message);
 
+extern void audit_log_object_context(struct audit_buffer *ab,
+				     struct lsmblob *blob);
 extern int audit_log_subject_context(struct audit_buffer *ab,
 				     struct lsmblob *blob);
 extern int audit_log_task_context(struct audit_buffer *ab);
@@ -250,6 +252,9 @@ static inline void audit_log_key(struct audit_buffer *ab, char *key)
 { }
 static inline void audit_log_path_denied(int type, const char *operation)
 { }
+static inline  void audit_log_object_context(struct audit_buffer *ab,
+					     struct lsmblob *blob)
+{ }
 static inline int audit_log_subject_context(struct audit_buffer *ab,
 					    struct lsmblob *blob)
 {
diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
index 7a5966b46f38..e5fae08982ca 100644
--- a/include/uapi/linux/audit.h
+++ b/include/uapi/linux/audit.h
@@ -144,6 +144,7 @@
 #define AUDIT_MAC_CALIPSO_ADD	1418	/* NetLabel: add CALIPSO DOI entry */
 #define AUDIT_MAC_CALIPSO_DEL	1419	/* NetLabel: del CALIPSO DOI entry */
 #define AUDIT_MAC_TASK_CONTEXTS	1420	/* Multiple LSM task contexts */
+#define AUDIT_MAC_OBJ_CONTEXTS	1421	/* Multiple LSM objext contexts */
 
 #define AUDIT_FIRST_KERN_ANOM_MSG   1700
 #define AUDIT_LAST_KERN_ANOM_MSG    1799
diff --git a/kernel/audit.c b/kernel/audit.c
index a611130f83cb..a1679bac7944 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -1107,7 +1107,6 @@ static int is_audit_feature_set(int i)
 	return af.features & AUDIT_FEATURE_TO_MASK(i);
 }
 
-
 static int audit_get_feature(struct sk_buff *skb)
 {
 	u32 seq;
@@ -2288,6 +2287,54 @@ int audit_log_task_context(struct audit_buffer *ab)
 }
 EXPORT_SYMBOL(audit_log_task_context);
 
+void audit_log_object_context(struct audit_buffer *ab, struct lsmblob *blob)
+{
+	int i;
+	int error;
+	struct lsmcontext context;
+
+	if (!lsm_multiple_contexts()) {
+		error = security_secid_to_secctx(blob, &context, LSMBLOB_FIRST);
+		if (error) {
+			if (error != -EINVAL)
+				goto error_path;
+			return;
+		}
+		audit_log_format(ab, " obj=%s", context.context);
+		security_release_secctx(&context);
+	} else {
+		audit_log_format(ab, " obj=?");
+		error = audit_buffer_aux_new(ab, AUDIT_MAC_OBJ_CONTEXTS);
+		if (error)
+			goto error_path;
+
+		for (i = 0; i < LSMBLOB_ENTRIES; i++) {
+			if (blob->secid[i] == 0)
+				continue;
+			error = security_secid_to_secctx(blob, &context, i);
+			if (error) {
+				audit_log_format(ab, "%sobj_%s=?",
+						 i ? " " : "",
+						 lsm_slot_to_name(i));
+				if (error != -EINVAL)
+					audit_panic("error in audit_log_object_context");
+			} else {
+				audit_log_format(ab, "%sobj_%s=%s",
+						 i ? " " : "",
+						 lsm_slot_to_name(i),
+						 context.context);
+				security_release_secctx(&context);
+			}
+		}
+
+		audit_buffer_aux_end(ab);
+	}
+	return;
+
+error_path:
+	audit_panic("error in audit_log_object_context");
+}
+
 void audit_log_d_path_exe(struct audit_buffer *ab,
 			  struct mm_struct *mm)
 {
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index bc0621282a9a..f62605d994fa 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -1089,36 +1089,25 @@ static inline void audit_free_context(struct audit_context *context)
 	kfree(context);
 }
 
-static int audit_log_pid_context(struct audit_context *context, pid_t pid,
-				 kuid_t auid, kuid_t uid,
-				 unsigned int sessionid,
-				 struct lsmblob *blob, char *comm)
+static void audit_log_pid_context(struct audit_context *context, pid_t pid,
+				  kuid_t auid, kuid_t uid,
+				  unsigned int sessionid,
+				  struct lsmblob *blob, char *comm)
 {
 	struct audit_buffer *ab;
-	struct lsmcontext lsmctx;
-	int rc = 0;
 
 	ab = audit_log_start(context, GFP_KERNEL, AUDIT_OBJ_PID);
 	if (!ab)
-		return rc;
+		return;
 
 	audit_log_format(ab, "opid=%d oauid=%d ouid=%d oses=%d", pid,
 			 from_kuid(&init_user_ns, auid),
 			 from_kuid(&init_user_ns, uid), sessionid);
-	if (lsmblob_is_set(blob)) {
-		if (security_secid_to_secctx(blob, &lsmctx, LSMBLOB_FIRST)) {
-			audit_log_format(ab, " obj=(none)");
-			rc = 1;
-		} else {
-			audit_log_format(ab, " obj=%s", lsmctx.context);
-			security_release_secctx(&lsmctx);
-		}
-	}
+	if (lsmblob_is_set(blob))
+		audit_log_object_context(ab, blob);
 	audit_log_format(ab, " ocomm=");
 	audit_log_untrustedstring(ab, comm);
 	audit_log_end(ab);
-
-	return rc;
 }
 
 static void audit_log_execve_info(struct audit_context *context,
@@ -1395,18 +1384,10 @@ static void show_special(struct audit_context *context, int *call_panic)
 				 from_kgid(&init_user_ns, context->ipc.gid),
 				 context->ipc.mode);
 		if (osid) {
-			struct lsmcontext lsmcxt;
 			struct lsmblob blob;
 
 			lsmblob_init(&blob, osid);
-			if (security_secid_to_secctx(&blob, &lsmcxt,
-						     LSMBLOB_FIRST)) {
-				audit_log_format(ab, " osid=%u", osid);
-				*call_panic = 1;
-			} else {
-				audit_log_format(ab, " obj=%s", lsmcxt.context);
-				security_release_secctx(&lsmcxt);
-			}
+			audit_log_object_context(ab, &blob);
 		}
 		if (context->ipc.has_perm) {
 			audit_log_end(ab);
@@ -1563,19 +1544,8 @@ static void audit_log_name(struct audit_context *context, struct audit_names *n,
 				 from_kgid(&init_user_ns, n->gid),
 				 MAJOR(n->rdev),
 				 MINOR(n->rdev));
-	if (lsmblob_is_set(&n->lsmblob)) {
-		struct lsmcontext lsmctx;
-
-		if (security_secid_to_secctx(&n->lsmblob, &lsmctx,
-					     LSMBLOB_FIRST)) {
-			audit_log_format(ab, " osid=?");
-			if (call_panic)
-				*call_panic = 2;
-		} else {
-			audit_log_format(ab, " obj=%s", lsmctx.context);
-			security_release_secctx(&lsmctx);
-		}
-	}
+	if (lsmblob_is_set(&n->lsmblob))
+		audit_log_object_context(ab, &n->lsmblob);
 
 	/* log the audit_names record type */
 	switch (n->type) {
@@ -1780,21 +1750,20 @@ static void audit_log_exit(void)
 		struct audit_aux_data_pids *axs = (void *)aux;
 
 		for (i = 0; i < axs->pid_count; i++)
-			if (audit_log_pid_context(context, axs->target_pid[i],
-						  axs->target_auid[i],
-						  axs->target_uid[i],
-						  axs->target_sessionid[i],
-						  &axs->target_lsm[i],
-						  axs->target_comm[i]))
-				call_panic = 1;
-	}
-
-	if (context->target_pid &&
-	    audit_log_pid_context(context, context->target_pid,
-				  context->target_auid, context->target_uid,
-				  context->target_sessionid,
-				  &context->target_lsm, context->target_comm))
-			call_panic = 1;
+			audit_log_pid_context(context, axs->target_pid[i],
+					      axs->target_auid[i],
+					      axs->target_uid[i],
+					      axs->target_sessionid[i],
+					      &axs->target_lsm[i],
+					      axs->target_comm[i]);
+	}
+
+	if (context->target_pid)
+		audit_log_pid_context(context, context->target_pid,
+				      context->target_auid, context->target_uid,
+				      context->target_sessionid,
+				      &context->target_lsm,
+				      context->target_comm);
 
 	if (context->pwd.dentry && context->pwd.mnt) {
 		ab = audit_log_start(context, GFP_KERNEL, AUDIT_CWD);
-- 
2.37.3

