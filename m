Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4847C742DDA
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 21:57:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232242AbjF2Tz5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 15:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232206AbjF2Tzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 15:55:47 -0400
Received: from sonic314-27.consmr.mail.ne1.yahoo.com (sonic314-27.consmr.mail.ne1.yahoo.com [66.163.189.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D369C212C
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 12:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1688068546; bh=NYp4azd3Uz7RQOxZaDyrAnb61SrqOWxbcsrJ/D0nyuU=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=jnj+dvAp7M/3+2FTdPS6Wz3sUaKVn8wz6QyNKWmGC81fXIn3rZE6iz8mF0sr+ksL1JW5PPeDZNhsq+Qzdvl5lCfSQlJFDmgHXvwlTCcOB3bYvc7woNebiSZsRg8QljmMzKmSdyGaVTeNbtvKaDKItKKeR/Dp2ZeNB6Zo0dlRc54/3XCqjL7VJBWZPdRp0n9WPgi9MY63AEPlT6D3HjQF9TC8hEnItTzlEcuC7uPCkPockrE4Yap4RFkxTweBiCLFYjohFcNmAzHg1XNtCZBLpwIS2t4BU7ptJS2EQSwoXdfYW1MvRDv9xSwOfd1fS9gctfbtJD9t7MQq6UcQX/9nDQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1688068546; bh=rO1uwvRyEHFp4nda4SHOYsZpbhVoSAuE5S6xv1cMITb=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=MSAt1pyiQFJ8PKcO9PC3QSv6BHa+7fXb0m/kqFglNoztIT2aJJ5oAlOmMBvoHqilxnJrSNen229J7V5EHaTRTe6FPZTh8nm46ka4QtFMPKBXZhoGdLTRJ68g77T3RBt5AB1+kvp9XgFz91fw3KcAEjsukhlOnG3quL5PzAufg6BrR0suJG4V4b810rmlaFyL91pOVCPWkUfJq3F0z9/HzEBcWlnZu0sU6xqJVwAKqOxlUr0GjpqOSyXd/yYar4nqVCuot3WpBAVTWpYIOhfTAdGB5NiyeSJWONSeR5LIievwl9grDnQ/H9JVE1/ZDdmf0fwjW7vcWlRs++Gw+mAOog==
X-YMail-OSG: GGAN998VM1lMT3iB0nykBV9EbZyFY23Nqmb4cgsty1rkSgnXJjo9yBVi0cVtt_0
 aSa_qXrWkK1j2PLY4mv_vuIVkKvaptgsrN3FAKgZSqjjlOJMFBjg5Z.ndZzCYsqsayPxlshNbyLU
 cTRXl4Y7wdhhgaqkB3_O4cKdFknivMQb1EbYbhKk_pomTxby55SHRnIOmdlpxgGRL4_mCjKgwKNj
 F6Gz1STkrsW38Hgi5CnE6qTG1i7Hh9dGp7HsCGAGsjwUz2lwaNmPJMy31tQZFVzdxJa4O6wbjcj9
 5ghLhqdrTVm2WWdSyBZfCOpvlLGWq36L6aNMKh6Fd_T_hr2T_fi_99EZ11KUVbT7KGDBuzJiCeWl
 CDsr_pyI.eqUl7vLzK.O2rt2nzRnPok2RE1MjxGZngv70wj1V2ej2pqhcR5VYY.LqxvxfsVNLEha
 7pdgeetm5tK0wxKuEf61_GBEUDXzvE8EnnQ_CILQqGCevZ1zGIKEgNos4MLK7.tBW6Mb2nZZdQ0G
 T3npq25oBcocpyg6HVBnvwM3JOuE2feOPsZgdqz8b92D8be26bFqhVIjcr8W85CQMitBJ50a0b88
 i_v6oUMdTLkuxeF7iZwVgI8KKF9sXPi7b1lgeWmJBKYmLSpMA0dXU7yFAiZYMZk1mI4fmKY5dBGu
 0HYDFi5GtFHx.bcvfNckiAvjFEeCBOJT96SnKfmTg1jMWjJP11.0slI3Kn.fC_2Tz7DwwDUb07b8
 jrJ4ugDchKw5gs052NChizOV8lemONx8_G5Yo6nlJBi4fZzkVxPqwOGIPeQx.TPEvFFUaukUUoEp
 IfnMAYw4ke4boFBUJ5vyl7zpSTddAkU96g28ouN_LhvXctAvNn417rE9WcGL3A1T7JitI3eXMwEL
 057y7iwRUwjsZvGm2r31hiddZUh8sWLwGFu1LI4MzI56SJvi8wo7T00u8xafERgG2ikyOLbY0gTt
 6317w4oY9pRYvTfgQsHEuntDD5gOJHwdby5_PR4ENdtrE782uF8Si1HuO8lgJ0DKoundUfjfKVRo
 AXV4CfKvZsmJObX00q0JT6WLOKqM0xNO_jZ58_GsUFlEGN1.l9rTIaBPEZZuP5t6N.JV1U7QDtno
 lJPVk4PKe2KPtxESnMgW8n8lyoWC4dhdxK9kf_oxmtyoBz6Ch0Rbpvu_RlR3eJqynFgYC5nysMyi
 8YPRAjcBCK80TIyU46.vRcnAPyQJo3YJnV22H2T8crEB9SLLS3ZtDk0QAVZfzLaeBfbYh3oMy2v_
 7lZgj26OztB5C4rRfRjkAQZODz54CE0cWWO4sOgo9hcZd8fStC7oku3smjl_n31nryNSIu1SXoMA
 d2XuEAo2CZB2PbJuJD.kw_ZzISWtcZSYXXnjlG5ygUUfoh1NRCDbwnQaWb0e0wqtjD0nZoUbrdZV
 vBu_xXTtxAmuGtyKv8URrD8D2wkoP43a_eUZar6Qwpn2omdmHAnSbkW7RN9egDvrhJmaOcSvfkHA
 OcCg7brcCSj2uJNoAnjeNq0h4tmvw5g1xi8lOXGXQik6HAIqemODNK8xtj3R7cfKCZm28aURgz_p
 adeGlPttnIgs_PsMCWL0FZda0.5zY7zIJAY.y4pXBlQtRNRTw9kuwOfnpTSTgIp2ZEP.rno5dcxU
 Q1IoLSU3C9Em1qywwo1BB37PYYzX7Fjk8UzOAtetABjd2JtpI4h3tWhIFVLtWDyv8_dt9qvTjvDb
 ttM6OfsmiHW9kVh.xYbYM2r84roqPOApd1k.3s6gA.ivsbUU86Yl2TlMCoQfH_2C.N82yTwmXaap
 v.0UMUMrJy2X2uR_jg6rnioO_XtYjxzKN389rdb_QUfSBwd0qTyT5rhHJBaUgppusOSnot_7NnJ.
 TO1FKC35uSF_exMb.SAKpt3il5A_BAAItiH1GQVn0SExCC.GQeR2Eoq8D8H3B5kL6hIcyXv6jzxA
 cIBh71RTBUaP4Y_5LyC1pleoH09t6twfmxqZ9ZHGHgoKloA5TgnRp3wvqm10q4HE.313ty1DN0fo
 OUIvtI.r6ueS3qouGSc0iIhWY1JLpEGYDeRGDyZuaJL2g9jvnGNjcjWe8VrkLMldLvGAMXKzAW4W
 NOteCSUgwPyoHvN3a_suu22J3Gm_iQQPRU4MvS6.KfGVfOPBeYNGiVfALZMZxDlf2Hq5dA.sBhep
 oisa1rjjsZzCzDj3i_Ia1LqtqKk.KlQNt.oTbAOIPzboWkyCrlKDA2lFDYIv1Uiwq1alR1wz__4z
 pCYNgdON9JCT3K6sbTIpY_EtPxEiJ_eUtUYwSKMt0jnHJYsD_FXCDkU0LLzoHKFYLLDJhEwKjD5H
 _.N2rXUSJOOdN8HCdJQ--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 321971ba-191d-4943-9b4a-875b6893b00f
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.ne1.yahoo.com with HTTP; Thu, 29 Jun 2023 19:55:46 +0000
Received: by hermes--production-gq1-5748b5bccb-dgd7m (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 8413d56f5114fad294c4c94233ef2643;
          Thu, 29 Jun 2023 19:55:41 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey@schaufler-ca.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net
Subject: [PATCH v12 02/11] LSM: Maintain a table of LSM attribute data
Date:   Thu, 29 Jun 2023 12:55:26 -0700
Message-Id: <20230629195535.2590-3-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230629195535.2590-1-casey@schaufler-ca.com>
References: <20230629195535.2590-1-casey@schaufler-ca.com>
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
 security/security.c      | 37 +++++++++++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+)

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
index e56714ef045a..5a699e47478b 100644
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
@@ -521,6 +546,18 @@ void __init security_add_hooks(struct security_hook_list *hooks, int count,
 {
 	int i;
 
+	/*
+	 * A security module may call security_add_hooks() more
+	 * than once during initialization, and LSM initialization
+	 * is serialized. Landlock is one such case.
+	 * Look at the previous entry, if there is one, for duplication.
+	 */
+	if (lsm_active_cnt == 0 || lsm_idlist[lsm_active_cnt - 1] != lsmid) {
+		if (lsm_active_cnt >= LSM_CONFIG_COUNT)
+			panic("%s Too many LSMs registered.\n", __func__);
+		lsm_idlist[lsm_active_cnt++] = lsmid;
+	}
+
 	for (i = 0; i < count; i++) {
 		hooks[i].lsmid = lsmid;
 		hlist_add_tail_rcu(&hooks[i].list, hooks[i].head);
-- 
2.40.1

