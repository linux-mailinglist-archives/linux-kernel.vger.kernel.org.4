Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FE7E5ECE1B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 22:14:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232883AbiI0UOF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 16:14:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233017AbiI0UNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 16:13:17 -0400
Received: from sonic302-28.consmr.mail.ne1.yahoo.com (sonic302-28.consmr.mail.ne1.yahoo.com [66.163.186.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BD051EAD68
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 13:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1664309547; bh=T0E+UFRQrcA1QKsW6qs9h7Wvvr9EMKuLo4zA/XijVtA=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=dONweSBtuFbiuP4aHpROblUDLdhWIq4qqpPM3u3kMdERCFFq9tvW9u65Clw0IkLuYClZx8/FB++15aq6spuLqEpHdtbjrT0jBkPkIYkgYrmh7vGo1kSadnlbYWN4rChSTzdrwHSgXN1fNOCYl7W/StkpDn0cK0CZa/WdreL3O+acjVf5H+ZQ0X5mCO5VB4UgAT2vYs02tpBUpNQa88VZKf9ulFLdjVvNXumCsRHqCg0qnIrcPC2nnWdqVKGRTpB4Ejryh3KZyOpgb+K6hPYqQmzy0Be6gNvBxSIDFE3frOh+M9YWDGMUl/kzA4oG+f/l2P/VUYHMrFDm2MtsTeedgg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1664309547; bh=GIQpcfsF3JbEQ9m2yt59Bvv8zj7/OX/JdjxEAfeQUZV=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=c5qBcqoIN108V5RO1EkD2vv2hZjNTvYSd+fALM1wZw1EFiwQhKrr/meIRv0kaBWT0rGZgpoq0p/H5vZimcQC46uwyBvBPoROnXaZC97os2J78jkNQRIGmMY/CDTxaxQTStiyK966BIQU3F+efoyHuc/zvqWVekUiz2WqJA4w+YPkDoU2pBrPIhvim521W9Bx8GpIIHt6NM1HnQb4ysA56j4xsWFMSwPxevtjxZVOE3vrPrgTteteC8CY+X1BFadEYoH0a/MQxBo+MD8+GKZPYKzz7D5BOHUbyX0yOrTNMoa/SiWtUuq9AmEVOa+SMXNXsQ1j/h58HuUe9U9vorc5IQ==
X-YMail-OSG: D1kw7foVM1lONcrQdrjrhsLeXMpBgiu5KoFcpHyOcTEZhM2__uzGDDisDu5at47
 LXB5bsR33WsRz46k.FIKdZo6.vwm6UVqe3A5pB6zCRBf8mnpIhrM3wMKjidf9uY4ppr2zU3t4DcK
 R.kq1znBhsp.JZuWkVUDiwyqhSNmoFSeNprXCgcM9Gu6J0N_ESLqRsdgWW_7uJmUVZlKU0.L7Wm.
 MTYZva0u6GASxpu0bxQc99CG1AJPNkR2AMjVkHN8VDml5se34UAfcMG6ruzLrIYwyHI5ubuGXCKy
 Y1BoBzUFOcxZPHyHjBPYq_GbYCOgjA54RmvvivkwKWOw30n41aHbGmOaJ2RhiV.DtiP2Aij45c2B
 8oL5jYNrAql2m.Qz909LHwwZVPNEa10vvcHhkNqAuOc.a7.Sc1s7XQlbkthUZLMlPUVJVf21B68B
 g3zN7pjiQebfKHH_4FOFQjEbEMrvbY2pIOWeO5vhXtjk.3gGMV3LZ4o7NeL6sAzSIsCgVrIdU4q1
 BshWjibd4V3tmiH7W30_m_5I0sKmdhl9HyU.4C6DTyWDCxPF9qoD3JNDB80xHA5i4ar5xQOgTuLr
 yYHxMGbITToRxpk7vuSOfrHogwkdhQwzgFfDi2x3bpQ6JS0U56lOEY9LYGG3W6.HzYb2_FxlHoKY
 KfRuVv7U6ux.Pe3ntCXqo8gQhS5IZArP0.9fLCfWTnAElCiXls0I0SYZLlDclBmb_qNqt0skjcLR
 0iKXmRUwg4TAs3GSZ38.PMQ_AHkhdiPbe7UBuwUSpHapqtwDQtsAKaj7k3kOlmQ6P.ILCvf0PHoV
 1iYvX5R.u15WL.0ksV4JBC02hSzEz7b0GTTY551izHuxgZvLH_LSK8PvOa_P8zyDloJmY85.iRex
 Xgo_sIQ6pcRRDp3HECfKNc43e2ZSS88EcWki_mu7FPPRSUZ6i6q2hhSskxPTm9db_uUYMe4hgnM.
 Eichun98jNyHBoRI_32LkUptuGuSQ..Qms2T94cgyi0hVnxRz3_QtNLdbfy5h3w0pcgUAzlFP.F_
 n22IrMhSbZ3Rip52ERWEXaHuEaDnIduodPZ38wB0WIXKmbjqI_Fq1O7UxgdJCprELWgICT.GYu5v
 JTAZZmYD4WiPKr4_hQMdBBlex7CKngU3oL_YYjhHx4VNDkrWwRddTrAspyeUgL6tn9Kd9VrNPT6C
 .JOIMU7nf9XN1ct02E5qOlJ93hJ0yj8NigY.duFovjkd4e9wbu6OjORFjYWDIeXJpj2sgn4WtF6o
 qQCjS5m2Tnx1.Rs4F3VHx4DLxk3dFd6VHFJtS8gP7qsDzFPGMo_j2Y0hWU2BayhRv.aen.xCJ7MX
 YsytAb6uKIh4zO8A_1xpTZQI6u6rrOUV_HeGLxv1GTnXdmAS_1z4ORe1wqCmFMsFxJHBPpfe1XKP
 ZSubzG3_skNxJA2BdoIs1Xtwh1H6mOl4whKcyb0Z4NzHVylgwztgAj69BVXVQcj64tAq8CokXotO
 V.fb5PSoORzmvgxymHaKr0DgPz529yQB7PMT61zzzso1tX2SP680Bb0AMcCnLbqeiDJiHO7d8Yxb
 Ei5T2pQpFOzmJPYsloWJGhvUP4lsfOrf2WT6AunnxqrtvrV1OANDOq2UcH6IF.DJopzlOQFWqU99
 smFXl7bkNYfsoF.hrLTyFiw.88BnGdJT9yiOLHzv5zp_OyvjVl0hPDPgJn2NsWFVvdIDvTRv5dYF
 DND.cUbKbxnivHFcFyT1sjYCFenS4A5SpaieNKn36XyOIdpVD3DLJSABessO4iEqYZlbA.12c.D9
 l9DJgCZO5sQWChbJmY8tLJSes83vtqWKT1VsT_MeAH7oipwajvqaZpaqrSR6a5CUO9EXSQeYrSpU
 _So5qzSFd8p03rJhyDYrwo9VkVsTMAhVCnmTRof4QWeI5CbCM6MtdJk2mL0qfLUU3eMxNvUij4Pa
 .el1iaBe6fhzN6LRGZMP9o9ZhUHYyxeawcDzz99FQMdAr1C28ClcqJyYirnRIOEH0Jvczn9Z4qZw
 XRVJPfvWhdSZlD0clxSmr_pOJIfFpqTUBevQOPnILFQ0e4oHpWQHTvEdbxO18ho3LivqPcj1rmLk
 OI9HAm.e8j4A9LqwlWqefkArtBoVd7NSC5jHeMMvX0OkE7sEN29PVh7EZ5uuk.Do2jgOuzX_ku_x
 cvcxLO73T_qEMrLgmk0jP5tB0ijmmYU5opFoF7nx_sdMxhrfQS18ut36BfROkxZ1bThcIEWGwx3Y
 N.ffRp_IvcR._dZ87CuISaJYKOhZyADezvEZbuTWh22T7N7iQzkRp1B2jUSqYsbJNR376LTY3_Mv
 a72VLKapO2X5hOIbEK4uFUwetFviqroUNcQF0
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.ne1.yahoo.com with HTTP; Tue, 27 Sep 2022 20:12:27 +0000
Received: by hermes--production-gq1-7dfd88c84d-nfz27 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 1d976fe2ee917226e6d7cc50e923ce4f;
          Tue, 27 Sep 2022 20:12:23 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com, jmorris@namei.org,
        selinux@vger.kernel.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH v38 33/39] Audit: Add record for multiple task security contexts
Date:   Tue, 27 Sep 2022 12:54:15 -0700
Message-Id: <20220927195421.14713-34-casey@schaufler-ca.com>
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

Create a new audit record AUDIT_MAC_TASK_CONTEXTS.
An example of the MAC_TASK_CONTEXTS (1420) record is:

    type=MAC_TASK_CONTEXTS[1420]
    msg=audit(1600880931.832:113)
    subj_apparmor=unconfined
    subj_smack=_

When an audit event includes a AUDIT_MAC_TASK_CONTEXTS record
the "subj=" field in other records in the event will be "subj=?".
An AUDIT_MAC_TASK_CONTEXTS record is supplied when the system has
multiple security modules that may make access decisions based
on a subject security context.

Acked-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/uapi/linux/audit.h |  1 +
 kernel/audit.c             | 42 +++++++++++++++++++++++++++++++-------
 2 files changed, 36 insertions(+), 7 deletions(-)

diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
index 7c1dc818b1d5..7a5966b46f38 100644
--- a/include/uapi/linux/audit.h
+++ b/include/uapi/linux/audit.h
@@ -143,6 +143,7 @@
 #define AUDIT_MAC_UNLBL_STCDEL	1417	/* NetLabel: del a static label */
 #define AUDIT_MAC_CALIPSO_ADD	1418	/* NetLabel: add CALIPSO DOI entry */
 #define AUDIT_MAC_CALIPSO_DEL	1419	/* NetLabel: del CALIPSO DOI entry */
+#define AUDIT_MAC_TASK_CONTEXTS	1420	/* Multiple LSM task contexts */
 
 #define AUDIT_FIRST_KERN_ANOM_MSG   1700
 #define AUDIT_LAST_KERN_ANOM_MSG    1799
diff --git a/kernel/audit.c b/kernel/audit.c
index ef6b2d38e38d..fb182f7e9d18 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -2228,6 +2228,7 @@ static void audit_buffer_aux_end(struct audit_buffer *ab)
 
 int audit_log_task_context(struct audit_buffer *ab)
 {
+	int i;
 	int error;
 	struct lsmblob blob;
 	struct lsmcontext context;
@@ -2236,16 +2237,43 @@ int audit_log_task_context(struct audit_buffer *ab)
 	if (!lsmblob_is_set(&blob))
 		return 0;
 
-	error = security_secid_to_secctx(&blob, &context, LSMBLOB_FIRST);
-
-	if (error) {
-		if (error != -EINVAL)
+	if (!lsm_multiple_contexts()) {
+		error = security_secid_to_secctx(&blob, &context,
+						 LSMBLOB_FIRST);
+		if (error) {
+			if (error != -EINVAL)
+				goto error_path;
+			return 0;
+		}
+		audit_log_format(ab, " subj=%s", context.context);
+		security_release_secctx(&context);
+	} else {
+		/* Multiple LSMs provide contexts. Include an aux record. */
+		audit_log_format(ab, " subj=?");
+		error = audit_buffer_aux_new(ab, AUDIT_MAC_TASK_CONTEXTS);
+		if (error)
 			goto error_path;
-		return 0;
+		for (i = 0; i < LSMBLOB_ENTRIES; i++) {
+			if (blob.secid[i] == 0)
+				continue;
+			error = security_secid_to_secctx(&blob, &context, i);
+			if (error) {
+				audit_log_format(ab, "%ssubj_%s=?",
+						 i ? " " : "",
+						 lsm_slot_to_name(i));
+				if (error != -EINVAL)
+					audit_panic("error in audit_log_task_context");
+			} else {
+				audit_log_format(ab, "%ssubj_%s=%s",
+						 i ? " " : "",
+						 lsm_slot_to_name(i),
+						 context.context);
+				security_release_secctx(&context);
+			}
+		}
+		audit_buffer_aux_end(ab);
 	}
 
-	audit_log_format(ab, " subj=%s", context.context);
-	security_release_secctx(&context);
 	return 0;
 
 error_path:
-- 
2.37.3

