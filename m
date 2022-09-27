Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D68C65ECE1F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 22:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232363AbiI0UOH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 16:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232793AbiI0UNV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 16:13:21 -0400
Received: from sonic308-15.consmr.mail.ne1.yahoo.com (sonic308-15.consmr.mail.ne1.yahoo.com [66.163.187.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C1B21EB1A8
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 13:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1664309550; bh=UYDyxtXyn1jWiUQBWNOgV+yhovP/R1UN1sLH5PBu454=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=rS1o0GVGPCMGGFbHU5DdmmtiE794uw6g/2+MN8hvM6XaxS/d4lFcFuaVvx0zZgfeHrG7cJ/5pabHvvoBNoRqq2fzjztYRU9kzn/uRBfmmdoc9vUMcaUDg55MGqE+z6cuBpwPHvg1GgxVco2HPS99bnN7sH2Y3VJu+1B7ZjgHdv2SI3Lvj2zXfD/i0JKuiTjEWqG7kBMkGieGVbsHk1kbzKyoMFNLvOGWeFLLO/A2rUu1fJbmf63k6gicbpC+IB/3/Itbxbkpq2gGSvLldt2rDL6kMf9fHHa/NQQZLJM2XHX3PqBttipgb1MP8MMMa+ygQ7rbtRYASKbLi5E1yc6X9g==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1664309550; bh=a1w5OutSo3FwVQZ0kDH+xS9MswMkWAOFIOjlX22ySuj=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=Rj5P3gms9YdCEND7e6bSo6sFdx+qQ5PbNL/qJ6JQcKGLPA3Esw1GhIbUUobKmBAjqcJiFzWB9A/jTnXsG5ueFPTfyGvKQZTGDEDKu47pV7XlvKNuu/dX61xtoyMaMa6N8BKDZYarRDhl7iE3J47dMfwUh/gVyivV910dmgUGItQrhIphFFWP39YcfhTQH7Vys6W5Tj60jP3eKjndJ9d2oIkJ81pkGaA206l/LZpygSfMcKGKMbYVVUHYe+DMtw++54sZ1MBXYBzctNWMjnOMkYNGMkVEH4Pjw9LedRPmY0jXKvkyFPD8c2uLlgqbjb7zOPCqDb6LuOJUZPc/28jlZw==
X-YMail-OSG: EkGpCjMVM1k.UuLmA8oPw9s6uYzUMDwpqevoXd4uPa_OQETsr.JjaQz0f8ucr25
 SFbkhC0b2E2VR8B4ZqIkKTMHBzRT2d7eDb7SAmMx07YB2_1BGQEVmP3dPndBuyfVau3qWgokWAir
 eq7QaIF05S4jHCTKpnczavRzpMOIv_1eKkUwtVO4fNtC.H9lyWcSSK4ls2UUHk4DKWX3UU5RdhhR
 47pw0FPiUzUDchYZ6PNnnXs_FTdiVxm6R4OZQrfxPMzHVaTtFS9O_UbhM38NTPgI0j0QWfIzMFNT
 S1wYiL4iJNm2LQV1cUfD2C1BSaz3VFX0Ydhwtj6J7WY8mPCDzi05zZthWX3AqWdOI0QlgKCJFJcc
 qVxqPfkVxfXtFWd4cm20hOu4IOcSXlUkMdN2ZtgaXPgAuFOZqtN36F8.OVCA.q7.Ra_c.XYP0HA3
 bbBmkBzti2djlD3dwFpDhGdYkHP7VXSM0yy0mTivfKTDXiWHPnEXM5P3h7VU_sM.QvueJ0zBXLnp
 2oMsBOgvL2AcHEWdNUIJxl4VqmohI31pvzn1.HVTNjPKg0N_Lkdu.1HXbsGhFHE5lYugf2menZ.G
 D5h7Fus0b6hsC_Vr0KuVcnP1G2DHDutPEToq1GhcFsXUSg_SENRN41zI8b3ErZ4vuM30Gc1FgE2R
 2IwDazr4kSPNjgqmKYBhOw7gUdmAkRvF45jaZh7SnMqbVfvD3UI0MP0RyDg_aCHNZLWXQReK4OR1
 c5vA3VjpI1Axao5KBlDL9CmoPQ0U4a31jQwEY0F2FwwERHcZpp7JkpB.rwFcjLbCh6ATjL9zND87
 W32yHzm0Z3ahfTSpcYlkTdd22AYKYUovMhUSxMPS4j6C.g8yHvHQbZgvdhlfAOY81S2OKhzpcQeN
 1ZuIGL62Tn.f7qxdI._5EuRSNWm3.4ZalYTz72GS0BD5cm4vcDzBmQ8mB53zjsFqhOCwsEJgn.Uj
 88oGKeu65LHJ81CGNQS2gh19Lg7XgqhRh45ZMDmwF1IPGyjZ7n8vuXS8IpqizM56Mn7yg5DYIJ_5
 Pa958sx.g_bZfQtZo3wWvCOUlFUQjw_BoMYHAy8wbUhDoAv5MSA_QWg3YBm2Qo27mJiGrQaz4Gp2
 FfOkv1LLmaKQzCRjy6N1WD9O6ksaSohCNd5g7taueHjsfvSSDK.UUaDhx2c51YLEe6cgGOOSzhvi
 K_KCx9pJACwWQ6jQjPexvRnuGgD_lxrlZP2v.c2f1iFzMM_pN0KurfFYVqo.yOW9nkJGLpDUXj61
 8TxlY6wb2DPnK40UCHJGEUrU2fUpf14PmtRpWijXZ.YXK9QcuAM0U9GvVdCJctZrdlCkm3hnS2MA
 vURFh2BGLSLpTAJHC.QAq.0_QZdYcIIZkQBQUv2_W89SbejdDmLsNBRYdIWL.HDgiEHWYWG_opOV
 ZC8tifveVcrUSWosH6HbUAvaRPHNPnMuWfPpzRFBJfZ2EFIo9MOUnTRsWBX0_oy7Vo5XDoCCCNwa
 BRJ8nfudlZI4pouKVjxDM9AexL9qkcuV4X9EDWjSvO.XeUjAG25Mw2yKnGSwoggpInpeu6tVR_fI
 NKeGkEBwzsfQzHFOwOhh6kwB4E.IidhgZBP.9SRvqBW6onpRvWUkKWsnq69ZAu3L7tLM4jKSoizR
 bkHa4ojGN5P_VISnvzKi025B5vBPoNJGaITPmJ1TAfqNyawrVA8x3dUVVUJMaxH6WG9LHL_V.szA
 hZRVC0JJBSE401lbMYEoj6UWkKK6z4kgbLlyqqLFbhIOP3StZv5vPvL39zHuRr9egcmJb6.QvmLM
 Gcf.NCCaxJBKkqtIhjm0asi6wB3WGjFGlyLdz4h9xuDB2Mstf8PgA7kVI74rWYqqnb0V0N4t_YgQ
 kchVGALJEsCUcH54ZtJ.ZUIs34gGJGFpxu3u5OcIq8B5k6ZGNVs4pVOezxtnlEF5NV5yFwHlRTOa
 a2ihzBLoRKBTH4VWKjRNcFVSSViYMx.EW5WUsBqpZ8XZCdy2Prnrg1gccGxoNjqKltb9O0VEkCb0
 Gig2kufgFJb9ycUgqaDZTlY2oYSVvZZENrxCU8PclKdFTTzgFsSjaGenFWMYGPL7W6rVEIJHJnYK
 6RYz.XyAfN3LGX6qxjyWBaTibRAEYIEmJ124.DWCG8E_2UicDpAnBMUl5PQarxHpF8xra1jsHI3Q
 9OG3tlkvWGTD07GxC2O6TmxaJu16ScqN3rphv44imAwIpFYpAmbbEzFnKewzkkQtbUD.ykvsMtfz
 x.0slFsfKAoztp3mhJpXG4smlU5RWMlR7iPv3GFLZQNxZ_LftzSVAIcAggCSuGZ7Czoq_oKH38Wv
 ic6M9Poiq5H3k6FyYagrGBkbn_TSzldmMY9z0eCw-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ne1.yahoo.com with HTTP; Tue, 27 Sep 2022 20:12:30 +0000
Received: by hermes--production-gq1-7dfd88c84d-nfz27 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 1d976fe2ee917226e6d7cc50e923ce4f;
          Tue, 27 Sep 2022 20:12:25 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com, jmorris@namei.org,
        selinux@vger.kernel.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH v38 34/39] audit: multiple subject lsm values for netlabel
Date:   Tue, 27 Sep 2022 12:54:16 -0700
Message-Id: <20220927195421.14713-35-casey@schaufler-ca.com>
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

Refactor audit_log_task_context(), creating a new
audit_log_subject_context(). This is used in netlabel auditing
to provide multiple subject security contexts as necessary.

Acked-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/audit.h        |  7 +++++++
 kernel/audit.c               | 26 ++++++++++++++++----------
 net/netlabel/netlabel_user.c |  7 +------
 3 files changed, 24 insertions(+), 16 deletions(-)

diff --git a/include/linux/audit.h b/include/linux/audit.h
index edb919722448..87ba6fe7f1a2 100644
--- a/include/linux/audit.h
+++ b/include/linux/audit.h
@@ -188,6 +188,8 @@ extern void		    audit_log_path_denied(int type,
 						  const char *operation);
 extern void		    audit_log_lost(const char *message);
 
+extern int audit_log_subject_context(struct audit_buffer *ab,
+				     struct lsmblob *blob);
 extern int audit_log_task_context(struct audit_buffer *ab);
 extern void audit_log_task_info(struct audit_buffer *ab);
 
@@ -248,6 +250,11 @@ static inline void audit_log_key(struct audit_buffer *ab, char *key)
 { }
 static inline void audit_log_path_denied(int type, const char *operation)
 { }
+static inline int audit_log_subject_context(struct audit_buffer *ab,
+					    struct lsmblob *blob)
+{
+	return 0;
+}
 static inline int audit_log_task_context(struct audit_buffer *ab)
 {
 	return 0;
diff --git a/kernel/audit.c b/kernel/audit.c
index fb182f7e9d18..a611130f83cb 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -2226,20 +2226,17 @@ static void audit_buffer_aux_end(struct audit_buffer *ab)
 	ab->skb = skb_peek(&ab->skb_list);
 }
 
-int audit_log_task_context(struct audit_buffer *ab)
+int audit_log_subject_context(struct audit_buffer *ab, struct lsmblob *blob)
 {
 	int i;
 	int error;
-	struct lsmblob blob;
 	struct lsmcontext context;
 
-	security_current_getsecid_subj(&blob);
-	if (!lsmblob_is_set(&blob))
+	if (!lsmblob_is_set(blob))
 		return 0;
 
 	if (!lsm_multiple_contexts()) {
-		error = security_secid_to_secctx(&blob, &context,
-						 LSMBLOB_FIRST);
+		error = security_secid_to_secctx(blob, &context, LSMBLOB_FIRST);
 		if (error) {
 			if (error != -EINVAL)
 				goto error_path;
@@ -2254,15 +2251,15 @@ int audit_log_task_context(struct audit_buffer *ab)
 		if (error)
 			goto error_path;
 		for (i = 0; i < LSMBLOB_ENTRIES; i++) {
-			if (blob.secid[i] == 0)
+			if (blob->secid[i] == 0)
 				continue;
-			error = security_secid_to_secctx(&blob, &context, i);
+			error = security_secid_to_secctx(blob, &context, i);
 			if (error) {
 				audit_log_format(ab, "%ssubj_%s=?",
 						 i ? " " : "",
 						 lsm_slot_to_name(i));
 				if (error != -EINVAL)
-					audit_panic("error in audit_log_task_context");
+					audit_panic("error in audit_log_subject_context");
 			} else {
 				audit_log_format(ab, "%ssubj_%s=%s",
 						 i ? " " : "",
@@ -2277,9 +2274,18 @@ int audit_log_task_context(struct audit_buffer *ab)
 	return 0;
 
 error_path:
-	audit_panic("error in audit_log_task_context");
+	audit_panic("error in audit_log_subject_context");
 	return error;
 }
+EXPORT_SYMBOL(audit_log_subject_context);
+
+int audit_log_task_context(struct audit_buffer *ab)
+{
+	struct lsmblob blob;
+
+	security_current_getsecid_subj(&blob);
+	return audit_log_subject_context(ab, &blob);
+}
 EXPORT_SYMBOL(audit_log_task_context);
 
 void audit_log_d_path_exe(struct audit_buffer *ab,
diff --git a/net/netlabel/netlabel_user.c b/net/netlabel/netlabel_user.c
index 1941877fd16f..42812bdfc31a 100644
--- a/net/netlabel/netlabel_user.c
+++ b/net/netlabel/netlabel_user.c
@@ -84,7 +84,6 @@ struct audit_buffer *netlbl_audit_start_common(int type,
 					       struct netlbl_audit *audit_info)
 {
 	struct audit_buffer *audit_buf;
-	struct lsmcontext context;
 	struct lsmblob blob;
 
 	if (audit_enabled == AUDIT_OFF)
@@ -99,11 +98,7 @@ struct audit_buffer *netlbl_audit_start_common(int type,
 			 audit_info->sessionid);
 
 	lsmblob_init(&blob, audit_info->secid);
-	if (audit_info->secid != 0 &&
-	    security_secid_to_secctx(&blob, &context, LSMBLOB_FIRST) == 0) {
-		audit_log_format(audit_buf, " subj=%s", context.context);
-		security_release_secctx(&context);
-	}
+	audit_log_subject_context(audit_buf, &blob);
 
 	return audit_buf;
 }
-- 
2.37.3

