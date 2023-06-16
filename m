Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6971733694
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 18:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345833AbjFPQv1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 12:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344993AbjFPQvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 12:51:13 -0400
Received: from sonic313-14.consmr.mail.ne1.yahoo.com (sonic313-14.consmr.mail.ne1.yahoo.com [66.163.185.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B660F3593
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 09:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1686934264; bh=hommsA3BOKWH8JPrcSGmlsvcDXkkKM3xWdtpA/dVKf4=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=Pn/vnY0+uG5t9Ag4oOmqOIhBpc6yq4/6RmCcUqgLRFOCfipDcosS6dMp4sVX8t14v0B1hf3BnJHrVqrOovRE5svCuXI25qNRoUxW+egTaGcEdR2xO+aVOpkp/PAm6uUvTSFoAHMvF5nzVVgliVyuD4faDekkH0nYjxCSA7GMc3RQ+kb1NE355O7MlDkrszq0OqgCWMi0puEAgdFl49FT9m9+UKsvDchVTSXu7EGiQYiVoWpCL0ZlEAodsILeUVs7W+5I4Tatg5Nj14bwbuBGnoH7qMwqSKhMjduz7H0fMwEvyqF5FPA0jVFm6xERjgHn7ORu0y00VK/2aC22oG95Mw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1686934264; bh=hhCwww0P+VUEB7CgtXYOeaqiKmrYtJmfDukbl2sYzhX=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=qK0itaXv8pUws/vHzImGZhUp3mg0cw2rV2TcVLnQICFFy79JYalAZi6vt3vW8/8BdCsXeaKPntzdwO+zKAfltGdXD6S7IVbprx+VdszGdvidojFbBUIXcAvmfW+vy1I+X8iTrgNYH38gAqF5ONvwvj2OprAmqCGHVbKWYqTBZu2tFQxeF7T6s95VdSJqKJJ5LMYQEf+lmmhWB8uLzkjPr3Mz894ybZxZAckdmdMlhH8JvP2qHKnPdP164hFxxJ7s4v2GCnngLRKeDDszrrUC8yNAXpZpKsZsuAsfLj6m0LJ4Kx6ZzSv8DkJLuLDwoxkrYSbQ5p0SN7u0fBPoLE+Fyg==
X-YMail-OSG: aFLgZj8VM1lE.dZ6WhidqFrc84AZbm_cJZloUYl7MKO8cvfnq9qhXCHos8.VEoD
 fW8f39IxPeChYkuSsUrcmY695InR66xBHYsyeJ1pd5cdLKSnSzbAVHphfxxyARVxpQVnV5_Y3HQo
 bW8PV7czqMNhW4EKMvqeEcvcqDgSySxTywDIDhXt.YZj9aSF66lVDrAJ4xiJX4mwCNw3O9Cn.59x
 udzkMPOTh7pYBC1bfIyCgjgw2kKXRCD2qHi9WEpdXJGGz6Dg20oBUvP5tmxXWslylxSkQEiwGbHN
 Uo7Cdkk7Po6vh.F56VQofTUc6LoHLObLKTsHUYyffpKjQqOo7grQ2nBKEh6IyYltmHL9EpP4CPp3
 hOTsKmuKkwtga6sY4axcdA6CAL.3SUFVa0jFlCnJhDIz8HpatKbiECR.EgvCTLr5CPLNIPHmklGS
 BKBnARfUg.NsdzlPzgEBIA1m_kI7.fwql_HFnAfsep0DmVxTYSDhsM7kXVLoTKi_pzbySU2tly6r
 cv_k05cWl4Gg3xIr96xuC7G5YNB.IICyzVg8fGXTY4JLTt0fH6.EmmjopcwMBae7fHInyx2s2sS2
 pJtaYpoHm5YhwGEPKKhB0yPMdv8QNMjvKt66TQAfcrEReOsgLmdLw41mb5xDeXiMGf3PM5YPaTby
 Y.ekys8NdQghGgEX84azwlOIiylcQYe5_dGponi9YqMVX_8AclehselNArTv3o_htXWpJv2xQIO8
 128grGf6sRLpSeGcSgRvtWLZ4Z.e008PX7rxP1YfMo1Qkh8S1zmjKZ4e0WphoDdfmUO0VkWEa3z1
 RQAgEl3LG7jtjR6cSBaik5FZ9DuGirvYP3nrO1D_cNVH_2wQ4QNtzWABB8qbRQRZnNvK5zyMgEBJ
 _ydALLTuX_B02pzpgAhSRCwkT08qXhtX5n3W.VUzPuUgtbh4hZpJI_Y5QIfCls6CJAsoOmEJDN6N
 kikRiG_smML5SikdlfVyDotFdyuX0ou0gAhIoFav0rPRSAS8Cy1pQHEKL3ZiTMfY3i.7kTQXufbn
 e9_6vkTMk62BwLSTqEYqXqDWkr1iRrxPBuWi94lwcbvzQm9J8zb0.979JwLYhx6aFBAt12RHUwUP
 bI2e9kEIrMJomX1chQPvjbMFk8Bo0m_xmZPkNZyvdCgH3MLdxx3.3t7M4FPsMCVmfrrquPMB2vDN
 e5CJfCvgnHMmV3Kz2G9wYK1IQmSXsuyjCyvLQC_6pNaXTQf2LPMzYOkp3kMFr197wMTRo26jpNJg
 vmT5dDJGPWtf_DzAI8.OgUaCMGSapyPr_V_uyUi5EiD5ZlPS7jkB0wrHwEGoO9btXrLFzVrA53i6
 UhK5ZsGVvD.JnR.mkFXXiDdponD3BUQsYIE3ti20tY7lZ6Z.CLkO2HPZd288HHpY6WlCocYXHpjV
 LoQRQeWof7yFZ8OyrG1E51mj.kYWmQ4PlSef_.9elguEw6_ZcB6TTM7asR0e2auEu1_9EhqGj7Kg
 l9znGOT2L7JdG_o926haPEfN4PvJ7wibkuIMNI3rf.wVYNweRKCqIsgAuqFNZHxSlaYghxEnNQzd
 b.jNfo8UHqJ9JW3GmDD2wtwAt29dUyJ.vcQmB8Gzbd07r34QguW2r.MxDUS.nUBUvzcWgMoAMViI
 3iNBusfwwE4pDcHZf.TXr2wtz_5fn3KRBj_C7Qui12KYRxk6VHn1Y1aDvkFm9ucSvOnA1OCPuFol
 a3pvMtglXi1P7jdWmAudP.9sOZng6.Fab5poFhnP5gFB4VltHHRaEKpD7qHgjvEh9Wmf7pt0uDr1
 gbpqhCnD6ksBXomLYhS4vFjvF2Tzvv1lhqk.Qz3pJTUBGhsDs4zsSGOgaw_G2ehZ76ynCPb_ZYXG
 X9OMQibtVi03gOer77GG0uHnHnFGT3wV2dsJ4oSlFKiNdQ5oRp8nhzeV8AXijdfhG_JfrUp3pvBd
 mwbOulhIqtMjH.wHDvM0rMf1912YLSGQPRd0ZWuawEKZS_m1JlzCQd4tnMoc3dByNl_pjZMYKeTJ
 W0VPa.ulFVWSByCXc9YWxdRT.7zzOWpG5TpB7O.SyJWPNTcyxAcZEjT3cS8_j3uc8WWzv.7W7rfo
 Gl1KmFI1nYPeSBH8mSwhQCG5WTFBBNIFsQq9KcrL93begJ2z4kX37RNrhHVqhGjElvb4i6DManse
 U9rjEp0lrXUDFGefPFPLhw10j4FIYgmNgOpR3kQykgAfbFlD4rlL5YuV5wTdX2KgS6B5wwjaBbd0
 NRL6c9EX3W.4a_9dpDkingO4NOuu2VgV1hXxDvdg46iXLEpoGI9kQQnWpJkpy3fJiq8lhMvK4HfQ
 NE066TeL7QuUBhio-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 6763a677-41eb-4da2-9e44-5040b023e185
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Fri, 16 Jun 2023 16:51:04 +0000
Received: by hermes--production-ne1-574d4b7954-tvjss (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID b70d58d7ec5b436008cc3a1dab4c00b9;
          Fri, 16 Jun 2023 16:51:01 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey@schaufler-ca.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net
Subject: [PATCH v11 02/11] LSM: Maintain a table of LSM attribute data
Date:   Fri, 16 Jun 2023 09:50:46 -0700
Message-Id: <20230616165055.4705-3-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230616165055.4705-1-casey@schaufler-ca.com>
References: <20230616165055.4705-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As LSMs are registered add their lsm_id pointers to a table.
This will be used later for attribute reporting.

Determine the number of possible security modules based on
their respective CONFIG options. This allows the number to be
known at build time. This allows data structures and tables
to use the constant.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Serge Hallyn <serge@hallyn.com>
---
 include/linux/security.h |  2 ++
 security/security.c      | 36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/include/linux/security.h b/include/linux/security.h
index e2734e9e44d5..569b1d8ab002 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -138,6 +138,8 @@ enum lockdown_reason {
 };
 
 extern const char *const lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1];
+extern u32 lsm_active_cnt;
+extern struct lsm_id *lsm_idlist[];
 
 /* These functions are in security/commoncap.c */
 extern int cap_capable(const struct cred *cred, struct user_namespace *ns,
diff --git a/security/security.c b/security/security.c
index e56714ef045a..39c5225603cf 100644
--- a/security/security.c
+++ b/security/security.c
@@ -36,6 +36,25 @@
 /* How many LSMs were built into the kernel? */
 #define LSM_COUNT (__end_lsm_info - __start_lsm_info)
 
+/*
+ * How many LSMs are built into the kernel as determined at
+ * build time. Used to determine fixed array sizes.
+ * The capability module is accounted for by CONFIG_SECURITY
+ */
+#define LSM_CONFIG_COUNT ( \
+	(IS_ENABLED(CONFIG_SECURITY) ? 1 : 0) + \
+	(IS_ENABLED(CONFIG_SECURITY_SELINUX) ? 1 : 0) + \
+	(IS_ENABLED(CONFIG_SECURITY_SMACK) ? 1 : 0) + \
+	(IS_ENABLED(CONFIG_SECURITY_TOMOYO) ? 1 : 0) + \
+	(IS_ENABLED(CONFIG_IMA) ? 1 : 0) + \
+	(IS_ENABLED(CONFIG_SECURITY_APPARMOR) ? 1 : 0) + \
+	(IS_ENABLED(CONFIG_SECURITY_YAMA) ? 1 : 0) + \
+	(IS_ENABLED(CONFIG_SECURITY_LOADPIN) ? 1 : 0) + \
+	(IS_ENABLED(CONFIG_SECURITY_SAFESETID) ? 1 : 0) + \
+	(IS_ENABLED(CONFIG_SECURITY_LOCKDOWN_LSM) ? 1 : 0) + \
+	(IS_ENABLED(CONFIG_BPF_LSM) ? 1 : 0) + \
+	(IS_ENABLED(CONFIG_SECURITY_LANDLOCK) ? 1 : 0))
+
 /*
  * These are descriptions of the reasons that can be passed to the
  * security_locked_down() LSM hook. Placing this array here allows
@@ -245,6 +264,12 @@ static void __init initialize_lsm(struct lsm_info *lsm)
 	}
 }
 
+/*
+ * Current index to use while initializing the lsm id list.
+ */
+u32 lsm_active_cnt __ro_after_init;
+struct lsm_id *lsm_idlist[LSM_CONFIG_COUNT] __ro_after_init;
+
 /* Populate ordered LSMs list from comma-separated LSM name list. */
 static void __init ordered_lsm_parse(const char *order, const char *origin)
 {
@@ -521,6 +546,17 @@ void __init security_add_hooks(struct security_hook_list *hooks, int count,
 {
 	int i;
 
+	if (lsm_active_cnt >= LSM_CONFIG_COUNT)
+		panic("%s Too many LSMs registered.\n", __func__);
+	/*
+	 * A security module may call security_add_hooks() more
+	 * than once during initialization, and LSM initialization
+	 * is serialized. Landlock is one such case.
+	 * Look at the previous entry, if there is one, for duplication.
+	 */
+	if (lsm_active_cnt == 0 || lsm_idlist[lsm_active_cnt - 1] != lsmid)
+		lsm_idlist[lsm_active_cnt++] = lsmid;
+
 	for (i = 0; i < count; i++) {
 		hooks[i].lsmid = lsmid;
 		hlist_add_tail_rcu(&hooks[i].list, hooks[i].head);
-- 
2.40.1

