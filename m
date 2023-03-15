Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2A616BC001
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 23:47:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232481AbjCOWrV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 18:47:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230467AbjCOWrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 18:47:16 -0400
Received: from sonic309-27.consmr.mail.ne1.yahoo.com (sonic309-27.consmr.mail.ne1.yahoo.com [66.163.184.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BD6E1CAE6
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 15:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1678920431; bh=/2Zaeol0Iwtqz9/tpey1RWc75JtXtsn2fpgSNdIqNQA=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=NFbl1xxKOyLrCN4zovN3yckiRFtVY2GhrDVEWGjEPhA/3OluAjezmPo/HjsW/CZ98KKRqXEyDUd0nd2M98NP2a34FzwGOPsojfZuKKuKtIH2+Pz7TPek6tkXn96t2/+IFiQXMEWNSZaemNw7H1MCsKwNBOEqBsnvDjX5e94sYjlwTabbRiqHYLOc145fAoQVG81oiBZOqV9rB4kfGzeYPHbDNCdNPOLwUCwYX3XrNSTqnkRCnNXREfZlFX6V2wIlYqITwC/fyvzkXuokLV9lguF3nOG4QNCZG6JIcuPNwSriXf1UhOFxXADs2/mqrptw07HH3jAxWJF6JcwxBfYT3g==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1678920431; bh=J6vSfVr/MTJi5KhH/Y3rVysZMb6/3fwsPG7N3l21tCv=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=DPXXs5gqqJRbRRwo9f9CkEYlV2YTaoXwF0RW7v6JyYdhhA7Qxr322dm801l93RssXfsqmuMISPs5X28ZlFRBSBRdsBZfHa6gwRk690H40loBY4W6mhYlDDZdQvT605iEdralL8bEVbEuNJXAHtYGBo6G6ruVf10poRCZhF/O/92D2H0I5oPnJoEGMNBTT+kiZnU/FfBDlvNLrQJNbAlaP+Lq8R+r9tggz3sq7o1baSEVAYOCgAm4x40BsfR+0YWimb3VSb0vowMGYytVymQQ0aji/s+PoUKiwgswDO52MGhSuRTZ7bZqFeorezd15G9xlaVvQHY7vu0auPh82gS6ng==
X-YMail-OSG: sk1nTLEVM1llPfrptzFLedbwuJf82y1ZUKjnUrhN8r5iyXXQffH8Kg2A6hGPZcT
 coTGplhQpTAhpY6IfyeGYXi1SdpXNTnWP93S1zHuTbl12oicQ_qUNGOHJhuKe6.FAGipY7Dnyy1G
 cp2JhPf.gs16YQejDRjYKrzRqBhPvuJww.ra5GVV0sBoLpDJWjfSHVMy_UmhSLxh.CvP2_xSGe3F
 SeuUC0meugq.F0LwJ13Fxbs.uyppeUZ4tKjpz37e9BsfNN7DsTTjCQIBAjUXaW_iMx1MD7tPMPSU
 apB_OYfCB7jkrXcpYHKMis8YYdPPElFOPU9JsJGppw4NzkVlqfHewyz7uuWh_b80pDrQNgH46hTm
 T4M4o3g4Nsp1GXQe6te.ZWTe0KMLeB95JeSJpadEWGutwiS3qJYl30je4V.1QLAaKXTR3rfviloo
 x_Tj76uCx4qPU4A8qb0CEsOG3il8JPPgLQieHTT31YY_Gykg6VsulJ3Y1uBoLcjIWTcwqLrvrFMe
 P1dvs8LIz.FMlzYhw3uIEvvkorpMk8HGUxqJwdyTWjycvQXVsufXyD4j5_JUjR4G.d3vIRnbvhbx
 S_mlvnI4vrl3mWAJ8.JRyP34JwX19NDqhF1MNMA2ZD5vfVCtjdPo_r8wCTmButSHwtRVqNyZOA4C
 F16G6F6xp1FGuIu4ispj09QyEgNUvuWFAfa_stiQoYHVANG2EVGk4TZYKFIsp94szY0J7._aeL2b
 2JWxXUKfomK6frcVcX9jxRnFmYFlT6iCk7QLXYeeuYeCdMHSlvitSUpk9.wTIffmCIfg4_97vR3c
 .pciW.3wXVpPf_fDGxS5vNZgG6XuUq0m49pwrkhnKMfzsnxBEQYw1U2mdHf2WCUqwlDOO8M7MStx
 Cmqrx5k4sHA2oTBhWJufSd2JJCLV9KIX8D_JglStjMksIH7h2bkU04VljQ57S7Hoop5DsEwd7wkv
 jNNfX6HFKOibogOrFGQUJMIGYUJP9G9CQHcsd.kBuUCV_wucMtCu6OadJxu_TLdwCQBkEk7daFgt
 GzFe4O_6dwP1ghmA8hGrYWvLVpLj.9uvvmSLLkvaz45k5mk.BX2WYSh8M7er5upQBfPlwY1mKuqX
 2.Eu5pSLLjD4MY_TotnTa7ZqQllNA71e9NhyGKFhAS.qMWXWGzexNAEvZFuq4CU_BLB7yRM9bg.b
 ei6AKNJRKBDfhFekTZtQ4uA7RXQlB9EYWG97PbZXcGKv9Yyd._NDez2fsjd.Y.vY.7a3DjJ2_OaX
 X9k6zWRRZDzOU4GISZj7O0SmrVW1Sgb3Mow74NqbZ6MWKCtb3XqmIpfVVuMOGydhu2JgXYMGHUha
 oStRqChDTezvuuI2lZdrg2doQZ4lcw08st0kyx3vbdwI5eVMD6abwvcW3zMfTKhF_Lwg9zavPKvk
 2MHX1H44JIZnQXYM1QIb8JNYnNwJTeI8zVcEU_Gyx35iCfrkkrzBLlAybp_rGnWzcOxU20EjVgl7
 4O_1uWx7OeGGlRS6jS3608pl3d2U6tZvKI0UzDql2WDG6EyBpmOTHrougEID4QFcoy_ke2ImNq9.
 DwAXrzriqZb2gXE3_kgFb2jn8b6E212LJlKDY3CpKaMq3f6u5SVLIBX.rF9S9gN4pALnQ71Efozw
 mworCNMOZoiibjDVr_G_eMtmHB5GxPvajnRwSgcjnglK7fAmm5tba9wbM1wtBoNTlVDTArfFQT45
 cJnGsaRta55vyKFI8JRaLorsABim7MXkiBjjQK9tI3a4s120kJcrwWPMSjTbFIvyB9Ir2DNRRimw
 1ti.cJpqZhBSkPjXs2191J65FDeTDRk59xovInUFT.40fcuaK8xJqq7Zq1GjaOva2WqGeTfsIvGI
 .nvS_u3QV.ZXxYOYExIKKwf2MBl6Tca5Bo8SOvXgc8xqfJhsroZhUxhg7npXz_FyTIuc3dJZiXts
 4TLR4Uy45a..tE.AziNn8bwxcW9ouCa2OTNbjlmpv0essUvusZMneY_Asf99p_.c34V.aqDXi_IT
 OSMDsvIsSObpKKM1snubZNSkdAEwkkWANb5Oy9OFUulRpmYWvS_SK3x8ZDTVVUs63PMoG4zIthWf
 y_S2bPQvAgrGKOtIHHJVM3pYHTTAetIkGIjqybBNmk7S30giOYqGVtSuPjMfo2zHhFoIz6whvImd
 uOc2pTj6LlAlbCwIzwAOMkxIlg0JYARumqMlRrduqHbjBgRFmhiky.MK070vQp7Xe8RQIfOT1TaV
 35ZrqcbamRVTgoo23e9uoxzfOv_EUjQo03VqrOlf263sjOyZNUwtog7BEvHQ1s5QLSRPqRmFbw5b
 63P6pf3D3SU.FRrdc
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: e2c54d68-96e3-4789-9ebf-6f68938f13ff
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Wed, 15 Mar 2023 22:47:11 +0000
Received: by hermes--production-ne1-759c9b8c64-7lgm5 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID a598a9259311ec92faa24ca803c3eea5;
          Wed, 15 Mar 2023 22:47:09 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey@schaufler-ca.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     jmorris@namei.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net
Subject: [PATCH v7 02/11] LSM: Maintain a table of LSM attribute data
Date:   Wed, 15 Mar 2023 15:46:55 -0700
Message-Id: <20230315224704.2672-3-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230315224704.2672-1-casey@schaufler-ca.com>
References: <20230315224704.2672-1-casey@schaufler-ca.com>
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

As LSMs are registered add their lsm_id pointers to a table.
This will be used later for attribute reporting.

Determine the number of possible security modules based on
their respective CONFIG options. This allows the number to be
known at build time. This allows data structures and tables
to use the constant.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/security.h |  2 ++
 security/security.c      | 44 ++++++++++++++++++++++++++++++++--------
 2 files changed, 38 insertions(+), 8 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index 5984d0d550b4..e70fc863b04a 100644
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
index 58828a326024..aa84b1cf4253 100644
--- a/security/security.c
+++ b/security/security.c
@@ -28,12 +28,29 @@
 #include <linux/backing-dev.h>
 #include <linux/string.h>
 #include <linux/msg.h>
+#include <uapi/linux/lsm.h>
 #include <net/flow.h>
 
 #define MAX_LSM_EVM_XATTR	2
 
-/* How many LSMs were built into the kernel? */
-#define LSM_COUNT (__end_lsm_info - __start_lsm_info)
+/*
+ * How many LSMs are built into the kernel as determined at
+ * build time. Used to determine fixed array sizes.
+ * The capability module is accounted for by CONFIG_SECURITY
+ */
+#define LSM_COUNT ( \
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
 
 /*
  * These are descriptions of the reasons that can be passed to the
@@ -90,7 +107,7 @@ static __initdata const char *chosen_major_lsm;
 static __initconst const char * const builtin_lsm_order = CONFIG_LSM;
 
 /* Ordered list of LSMs to initialize. */
-static __initdata struct lsm_info **ordered_lsms;
+static __initdata struct lsm_info *ordered_lsms[LSM_COUNT];
 static __initdata struct lsm_info *exclusive;
 
 static __initdata bool debug;
@@ -341,13 +358,16 @@ static void __init report_lsm_order(void)
 	pr_cont("\n");
 }
 
+/*
+ * Current index to use while initializing the lsm id list.
+ */
+u32 lsm_active_cnt __lsm_ro_after_init;
+struct lsm_id *lsm_idlist[LSM_COUNT] __lsm_ro_after_init;
+
 static void __init ordered_lsm_init(void)
 {
 	struct lsm_info **lsm;
 
-	ordered_lsms = kcalloc(LSM_COUNT + 1, sizeof(*ordered_lsms),
-				GFP_KERNEL);
-
 	if (chosen_lsm_order) {
 		if (chosen_major_lsm) {
 			pr_warn("security=%s is ignored because it is superseded by lsm=%s\n",
@@ -387,8 +407,6 @@ static void __init ordered_lsm_init(void)
 	lsm_early_task(current);
 	for (lsm = ordered_lsms; *lsm; lsm++)
 		initialize_lsm(*lsm);
-
-	kfree(ordered_lsms);
 }
 
 int __init early_security_init(void)
@@ -513,6 +531,16 @@ void __init security_add_hooks(struct security_hook_list *hooks, int count,
 {
 	int i;
 
+	/*
+	 * A security module may call security_add_hooks() more
+	 * than once. Landlock is one such case.
+	 */
+	if (lsm_active_cnt == 0 || lsm_idlist[lsm_active_cnt - 1] != lsmid)
+		lsm_idlist[lsm_active_cnt++] = lsmid;
+
+	if (lsm_active_cnt > LSM_COUNT)
+		panic("%s Too many LSMs registered.\n", __func__);
+
 	for (i = 0; i < count; i++) {
 		hooks[i].lsmid = lsmid;
 		hlist_add_tail_rcu(&hooks[i].list, hooks[i].head);
-- 
2.39.2

