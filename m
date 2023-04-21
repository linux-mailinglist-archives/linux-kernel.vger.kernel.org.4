Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B3C16EB0F6
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 19:44:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233488AbjDURn4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 13:43:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232640AbjDURnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 13:43:31 -0400
Received: from sonic311-30.consmr.mail.ne1.yahoo.com (sonic311-30.consmr.mail.ne1.yahoo.com [66.163.188.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 428F6C651
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 10:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1682098993; bh=gX2htUbJVQu70tjeZK7/GhWqFSnOffI4/UYVqiCQJFs=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=R7ydlCEEx6CM7dtOXsam2JlaThsSHnX1rsFYPwXMd2cXlvyvlrzHqJxMrJA5VHWMZxNgKJqOWj/ZWZ1Z5bTGLBbXNeQi4EGoqxdgNOVo/Fjw3C/qRySXl+AcXIb6agwN2U64Vp+r7f/0Fhb+lXjlZXqpARyBV45391Pb3mOhrwezXq5j1b/YO18z/pLpN0bWZDwC3nRgYBfIdY0YTaW605vWK2YXgviBB8LJMsFDgznziXBvUm+6zoixviwRAt5qaOuTBrcY6wa8KgxkxpTmlGGG+KjHzvbHlYaK4oeRVaBOL+Td1EBtH9XMrTnJK4qIXgCYZIYRECH/9NH0PZQtDw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1682098993; bh=9cegTpNC2DI5vxHFeL40UZn8stmDWZXeNUPOIOAGwOn=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=WmZUAgb2e8B/oGLJBEebo7/NupAh4xnuRMIXXur69RRF+89YAwzORfzITZpBk79j2j96CYzqPi8uPxUbgbjLrPn3eU1a0WHSzhjgA0SNQP1k/gaZGNcbZUt9MQeRN4NMHTTWAd5NGqrBLztA/ToHA7PvlPeq7qiXmY2Pjp46QZ8P8Y8c4up6WqMai4rUA39FZDJqQGWTL4lqYnkDvVBWDtqN/U7LuTKz+6XCEkEH4Gz/jCl3zVp4G4nZlLGLg85vMPspmzKrQgn9RV6ZNUsB6mgTaIibiukocZMA2nguoULpnWPM0PSp/XV9THQWdIXeNrMssWkvbIj7L9fgJG/QrQ==
X-YMail-OSG: SgK1QbEVM1n3WYrFxFBNheIT62hQIZOwNPxGaqJLWLTQYx6v3s3nx9PVI4n065D
 urVaxwx1XOJekMu1Gjo0gKCp0MX185yWvlHvKa466eVmR203r0WeHg63i2hI6e7zNkKR59Ntc_TM
 lEO9YUweY4u0p3JXRFYOgto9hYuuQl3tgM5qPbO2kqIQ1TUcWJ3gagzYLI7.gr7ggUy9nHffk0zJ
 TPxrJ1Bx1BQgM8CY_iieMjwylsHVunHOqKHBe6G8hdSA523MScHv3lVbQZY84zNlgdNGvOmu9ZXG
 pKjZGMgnoagiJqVHij.JEdGYcDt7JNtH.ZN17djx.5H0EzGDxloSq3SsMWB_5MOgCJxaCM8eB7eC
 mDUby6lOyBkpJF3V.bgIUwMx7oYNk980UH1YXKKCvWuEMeO9D5QpxQQtKM9Bj745rpI7bd3146nx
 7S5A_K5_2DS_BMWSc.EGg7QNWz1IYCc8w5rKDkP8AFkfKdr0B9V2gs00YR2d_WCy2bysbKKyVGyd
 wm_fS26fahR_7GkMe9vYoA7Lgrml2AioSXLfDVWl3pUz4GekMpXbl3WyxZFWRYvdqZnqCjslEHh4
 3hV04dlgj3x86iWEsmOJjOdCs.gysDdhdNNtgB0QNNmK9O_P4AnCfP_Pf8TWqXUwJT0L0fGnOIcs
 5KyfusjjDaFQXS7l_AYDj64ytBbBouQdvRTMCsvAIsGgAZ_jybK.MVdSmUmMOJl7Mhve_atwdZRf
 Xf64kBIhPCqn6_rp4eKLSTX3BDCYscKvQN8hzrc6LBzO3Y7sd9_ojEOBatcMfedqe3ZX0yLiGv9P
 G5Q33st5JW8jtUCXUmbu33OnObgjLIuN2jm4azQLUbN1O0hUN27emN8_OOzqbdXMBtVe9LqGTF3x
 6xNzVdhNNROjbxBY_2bYZINueWDSJzXW0ZkXLe_JeT0fzyDh2s5q3DbBKiZajdyC5tLvtT_3J2nZ
 JZUWxHjNRDCQa0I1wkgPwgCcuR0D5pVNdnp8BgBbeqpE4vJUTwul0EMalbZFE.0yCab1s1VDed6w
 bOJhErBhLnGMHnxdfMEOEC4WFKIhe_aBMW_psPsO26X.ptQGCMLks94CzkOetvzMYQS2EJtxWf3d
 ftxJF51WGyWJCoEBI1tuBIq_y6O7eO_LaNzIRM.Zxf8I8ers03GAcIAtTIZQPXjDB3cE0QtkRMNe
 p8axSUnQ_kRYr0WRRJxM4XLydDqriflE2z_L0VC6Tm.wTnzV16XtqzCWIVQ2GkTNcIAhoZ.mKH7E
 G78XhZ9473FFxRqiw9JUtkT5DPb3_QS7IK0XhRuFai_w_6npYoBw8DCNkQRVlU21lsLsdk355EDS
 XTuL_Kh3Px3gCCDCruspSOsR9SfFNVyShtMjXiLcUQ.6SWo2h2Cvqno3TGnKjPvXyIQeB7G40SlT
 P6fS9z0xDAuduLVM7v4Ic.F0K0cGU36CFOXtkQZ2.oOvnsU.Is5VROFToS360ZS.8DxcYsNG_lMe
 oZEtpZAw554w7V0kM_NFQcbnEM0tLiHdUnOy_varGYeX4lWgMGuzayd7LBV_znPcSH8jdTEPtHOd
 6P1g4kGd6vQshlcC76t_B8hR2m1Bwu3dcSRSz4itZan8jdnDG0qKljpCp3WczyAfxeKtCUromfBq
 BJs9flvSGD5qh_DPNuq07Fb3KI5irKwrgEFDoZ4Rgd6vbNzTFyQdmtxn.FKiE00J0avv1oB7bYdl
 5OTm8HmY_irDs8b83zMWw4Apw1yVRNU99BZoeKcL4G8L61aIeL4zeiE.Mku2boCTMR4WvM_1Df_v
 6W3X2fR08WrbtdHQNOQWl3PLLrc1Eel8bsmUsHg55QmlkEwANzW9dYz3u5ziMZqdWybaGO7wSRsz
 ErW.LJVNDG2VA7attsiHuiSOFth7JfqFBZXyt6zS5fhIdtEj8XOC3UMcWjDGheWoj.01rRFF_or7
 bHY_0MJBEFrW4yjFaMsp2IW6xy62gtgiOltxlCEmk9hSDcdvy7Lt4KiaZWcE0MLxtFftf2TSU0lT
 nLFpQQGt6UoAYkhfi21wQo5nxBlHcPvo3Uxoo1yMwkzMdFGlMrcHPI_ARcDy450KkGzb8V9YRJBM
 qFCb103hteWOyn9ZeWUzBqRRk0CXabMRdJWmtJQOszCPvrxI8QyvfjWkY4QRoq5A1vWoAOi2ZSdi
 z.Ork3H1OpzS14G7dWmmMmWQZOghOYi1IUYTg_9cjHsU6AbidCItWRwdaKY3rtWRxSQf2BlK2Jlo
 JI7qTACbssfI3V2ztTPQvw3iWq7B7hSO_b9ZMMoivMBgBvqXB9pQ2IIohp_M929nWQwo6bkq9nSX
 LeYGDs1P3Pa_VFYjQwA--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 8a8996cf-9b01-4390-b593-dc6e7ed6ad3f
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Fri, 21 Apr 2023 17:43:13 +0000
Received: by hermes--production-gq1-546798879c-qx24x (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 347f67eb1ff988d02ff1c10aa50548d0;
          Fri, 21 Apr 2023 17:43:07 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey@schaufler-ca.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     jmorris@namei.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net
Subject: [PATCH v9 02/11] LSM: Maintain a table of LSM attribute data
Date:   Fri, 21 Apr 2023 10:42:50 -0700
Message-Id: <20230421174259.2458-3-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230421174259.2458-1-casey@schaufler-ca.com>
References: <20230421174259.2458-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
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
---
 include/linux/security.h |  2 ++
 security/security.c      | 43 ++++++++++++++++++++++++++++++++--------
 2 files changed, 37 insertions(+), 8 deletions(-)

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
index 58828a326024..3f98e5171176 100644
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
+static __initdata struct lsm_info *ordered_lsms[LSM_COUNT + 1];
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
@@ -513,6 +531,15 @@ void __init security_add_hooks(struct security_hook_list *hooks, int count,
 {
 	int i;
 
+	if (lsm_active_cnt >= LSM_COUNT)
+		panic("%s Too many LSMs registered.\n", __func__);
+	/*
+	 * A security module may call security_add_hooks() more
+	 * than once. Landlock is one such case.
+	 */
+	if (lsm_active_cnt == 0 || lsm_idlist[lsm_active_cnt - 1] != lsmid)
+		lsm_idlist[lsm_active_cnt++] = lsmid;
+
 	for (i = 0; i < count; i++) {
 		hooks[i].lsmid = lsmid;
 		hlist_add_tail_rcu(&hooks[i].list, hooks[i].head);
-- 
2.39.2

