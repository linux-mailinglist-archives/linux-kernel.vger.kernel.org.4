Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1FC2659344
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 00:35:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234318AbiL2Xfh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 18:35:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234287AbiL2XfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 18:35:15 -0500
Received: from sonic310-31.consmr.mail.ne1.yahoo.com (sonic310-31.consmr.mail.ne1.yahoo.com [66.163.186.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15A821743A
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 15:35:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1672356912; bh=qFFxEtuz8a8J8LhylVuJUet5WZ/AIBJeqrF6DdEsivY=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=j+E7ZkcM27O1QCtHcMr8Tec3AkM6Tv89wPakP7hoWjA2WfGPG5YHDs8ncveRw3K8mYgLXHojuoBHtDJ1/1R+QPQh9/LHePzhMRPumSC9b7iVxxyBcKNtJcSSKg814HOAdmVw5FfSbNnruA9niFi1SAU59Pnm1OeJQBc/yXwQY4d5WUkiuS+UGS9Qobptbmk0r2HEuZCUnwseaAEPn+cYorDf17hwIxGMGL6Ih13pdlDaLBJhYKeXH1WYiFLP9zB3X4DmN3nOrQqw/YZqpkEjjYZJPZi2kvDgZuHJ8LQ3+eS7la1kU1UbbkABio0+o+tzZ8pHQo+bcWId0EJ6doJr7Q==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1672356912; bh=sq99rR1srJmjvmbuU0gmzal5ursakDxjp3eVlvLIcGh=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=nO4pectbb+0RsPRgtBmXfAD60GCFfj54qqaD5SyyfiOckiO/w1fdYK3VYOetJZVMKvteKEIbMWQFthEOT8JVSXoOhMo000dYynyYIcqbBRlarLb2RCnlig7FwauaIOJE98cEbiUlVguGZAkmlJVAcNkugeYRoov8ZAipYK8w059RqYSBwq74hIPSTiHl0dvjXBGY1r4GfLDpZTmxTsnzUp1LDyuWK/ilcy6AYgFZNH6SrLrsBHPWa21zl783H4OXsuOm76SJnxy4hsJSwM60h5Q19L8I+R4UA+ho4VhwUidVfw0Q9YW2p5DyF0sE80yoXrxs8bh74GDYxJ/R5ZQB7Q==
X-YMail-OSG: 9Qcyj5QVM1kmMDjkHPAjl6wdIBSEeZsAZsj7AZDnGnU0eGc90a.8gVVpT_4PlsL
 wb1HKHtfzkfg5_7acCkN9bPHyKMuYg.x7UqzdxQS5Pt3LGfcTkzXLpjLZwaeKiNvTvu.YEgAEEfi
 11C4MmpJizimxXJMj4mv6FnXeRiUg6Q7fX5atuWBTIbea_npHI_8UXNa4GrWZgh9aMh08zTGNKQx
 8alERNd40Ehw91L0BeRuFOfu9GwYw.f63skv9i1SsQxabbWpfeU3FlT4.Es36n3Jq9T9rWwBkUGU
 xsUKGHDX3I3y_leJIqwa.bcaoxMQ7UQk6tZvetBEU1aYP154RExBV.a7qWt8clPOGCxzKXRTswSv
 vXaHXzxGO6xwsjeCvXGrkbaaNHXhXQxUqizQRT91D6nHn1Pgusafl4ebmBTHDWXXn2c6dLRw_A.I
 Rf0r7AMwxws3I37JzOoS673zrEdWYeto9OqsEzeZ3s95JDfMdlVvJApxXCRjYuPzS89Z4qQG3cBd
 YVaua9MnycC1IBMNMd6RghXvIYxP7o5O1zfvz_jNSfVk7MMMDTswzfpUJejqeihVrQXL_3JIaeer
 kZJTcE7LwJTxFVGLAbC6DC1eOmjFR.BRtYE5xP00iAuzA8Q1KJFmzCZPXmaD4FRa3c80V_WC.NXl
 1gdlr.ofTrT7ibUJyJQ6ETeJu_K92e_k5y_lf8RW1kgmVI2XSpqIFynZ_wXoRPIpRdedjcrh93Po
 N5B1I0EMKetT55Ks8krFGMiMF9RNTpkRCwv5oq3c.X91pOuLSq9E73j4qokTDKAV1zkch2JJfW5k
 APC73KpPhuKc0Qvz.G5JUC1FpANisIoqChUk529jD5JaWJM43IdvCJhkkhX2zU.3f9YvBx3ColST
 6hcA_VA6405TEYlIyvWjWMrs9Ha4bPjk_qoHIpBgFqGL7i.4tbgfHnp5gcwCZNHYWA9FDzpU0sbZ
 40qjgxjut0QWLyMedyArsUvbchezQwmwA_z_LuPLzfxxgwOHD570m8vIPfc1ZOSp3vzn1hFnOBox
 WTyg2ocDJ8DrF1JXzg_h6FxnRGui4rrnMF0B2drU27xTZ7P31l4raBQTc3fUbsPpoXRxxp9YmtHX
 UJHB5TSIi0PO_P6X8hsnxMyuTQt98E7iARx7D75bA1mB1Z7Do9HD0gIFDdriew3Euy9uE53cnRzs
 MVo0tpkqbWeQwtfyW8BtKqtPbBuiDrvIMHNBHA4DEAbgflQQS3E.8L9pi3kIkKPCMHpsr0jF.NGK
 6GNyh8tnxD6iyyR85v2fMLa3JDQbX2SZqbvWGMkxO_daXciPzgb.LLXAttwysPmrOXwotEKRMdbu
 D.5vI69JHpnQ2ytuiamx0z1gDSO4sIbLMafsLMeyB07nHAk_iPClq19O48R8qznSTr6J8EINN75r
 tPJ0.JfDR_qqASW3.SPkaByGC52xoBvpNgL4GJVqTcJd.HKn4z5k8dKcKgC1KF8EOG5c0YFWL7Wl
 tBynJG91d1Nw506dr1zYRr8l0jhc0Eo2wLQ9lulyVvd9Ml6KLFYwZdExlyA.26Ru9xXRgOW2zxle
 N6T2C3gTJ4W1MDbUD_uCl_2cAgzqijJi54Io6JzHijgw8O83liyZuebN8ePQIW7LznXTehEGp5Rf
 St3o9Rw36DWsHFMWs4qPAWgaHrHOiT2jcyYqg2ai0PnnTv8XqluXJ_D0uIJqVidLNCpVzf602RzT
 em4IZh_n1fzi2cPhBFpmpm3uOXxPw4gFpzFmfb.SfPgwF72QXWeWRbjKuyY9X18_iZSZlVFGs9hg
 q4YGwkfldA__gBvF8T6TAs6R8SZYy4BEe2oe1fTCdrzT3DQnrsvOqyn4k5gunBLbkWJiEGCVe42u
 k2ZkghhoMfFlNi_PRlmb3xy3maeZL6JVsHJ39icV0GYko1gRU9ivtMHDKX2lGh8VXT2Zlo7iP.MS
 RjqS5cnP.lXJHKy6_4_J0GgX1gv69wXpmtkogF4YwVLWgXZXPYCmppdd9lByLb0rEXoJquYQ5f4f
 zDzCsXHma_cphFrP4Pmtop9YiL6SSZAUQHp2w5ocTUceiOEwOYP3EIBkxJpk6P5_AE1KeYnNeTXn
 DA_NhcvHQHxR4bEnkx3QtaqvA1FJ5vT0M1KtTVB5AVD495Az12n_O.9BBQXjqMJJK5PHtPrk000o
 qlb1mp1qtbgydRwlCweek8xL1lpJsDXox_o1s7hendwumatzO54d_UIMOSRERJZs4HB3nw_yhpiN
 ILwJnafrZYQJTCh79QUtDm9.Dd9CEfAkiHQb0a00EgY3WzsfAyu6PDj9vvjl9RZ9uSe4XryvOorT
 hACUZaN_ag1tFZUoA1g--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ne1.yahoo.com with HTTP; Thu, 29 Dec 2022 23:35:12 +0000
Received: by hermes--production-gq1-d898c4779-9jfqr (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 6aa36badf2bf5369937c84807e956853;
          Thu, 29 Dec 2022 23:35:06 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     casey@schaufler-ca.com, jmorris@namei.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net
Subject: [PATCH v4 2/8] LSM: Maintain a table of LSM attribute data
Date:   Thu, 29 Dec 2022 15:34:48 -0800
Message-Id: <20221229233454.43880-3-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221229233454.43880-1-casey@schaufler-ca.com>
References: <20221229233454.43880-1-casey@schaufler-ca.com>
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

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/security.h | 18 ++++++++++++++++++
 security/security.c      | 18 ++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/include/linux/security.h b/include/linux/security.h
index 5b67f208f7de..e70d546acf3d 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -139,6 +139,24 @@ enum lockdown_reason {
 
 extern const char *const lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1];
 
+/* The capability module is accounted for by CONFIG_SECURITY */
+#define LSMID_ENTRIES ( \
+	(IS_ENABLED(CONFIG_SECURITY) ? 1 : 0) + \
+	(IS_ENABLED(CONFIG_SECURITY_SELINUX) ? 1 : 0) + \
+	(IS_ENABLED(CONFIG_SECURITY_SMACK) ? 1 : 0) + \
+	(IS_ENABLED(CONFIG_SECURITY_TOMOYO) ? 1 : 0) + \
+	(IS_ENABLED(CONFIG_SECURITY_IMA) ? 1 : 0) + \
+	(IS_ENABLED(CONFIG_SECURITY_APPARMOR) ? 1 : 0) + \
+	(IS_ENABLED(CONFIG_SECURITY_YAMA) ? 1 : 0) + \
+	(IS_ENABLED(CONFIG_SECURITY_LOADPIN) ? 1 : 0) + \
+	(IS_ENABLED(CONFIG_SECURITY_SAFESETID) ? 1 : 0) + \
+	(IS_ENABLED(CONFIG_SECURITY_LOCKDOWN) ? 1 : 0) + \
+	(IS_ENABLED(CONFIG_BPF_LSM) ? 1 : 0) + \
+	(IS_ENABLED(CONFIG_SECURITY_LANDLOCK) ? 1 : 0))
+
+extern u32 lsm_active_cnt;
+extern struct lsm_id *lsm_idlist[];
+
 /* These functions are in security/commoncap.c */
 extern int cap_capable(const struct cred *cred, struct user_namespace *ns,
 		       int cap, unsigned int opts);
diff --git a/security/security.c b/security/security.c
index 07a8fe7f92bf..4acb14500bc3 100644
--- a/security/security.c
+++ b/security/security.c
@@ -28,6 +28,7 @@
 #include <linux/backing-dev.h>
 #include <linux/string.h>
 #include <linux/msg.h>
+#include <uapi/linux/lsm.h>
 #include <net/flow.h>
 
 #define MAX_LSM_EVM_XATTR	2
@@ -341,6 +342,12 @@ static void __init report_lsm_order(void)
 	pr_cont("\n");
 }
 
+/*
+ * Current index to use while initializing the lsm id list.
+ */
+u32 lsm_active_cnt __lsm_ro_after_init;
+struct lsm_id *lsm_idlist[LSMID_ENTRIES] __lsm_ro_after_init;
+
 static void __init ordered_lsm_init(void)
 {
 	struct lsm_info **lsm;
@@ -388,6 +395,7 @@ static void __init ordered_lsm_init(void)
 	for (lsm = ordered_lsms; *lsm; lsm++)
 		initialize_lsm(*lsm);
 
+	init_debug("lsm count            = %d\n", lsm_active_cnt);
 	kfree(ordered_lsms);
 }
 
@@ -513,6 +521,16 @@ void __init security_add_hooks(struct security_hook_list *hooks, int count,
 {
 	int i;
 
+	/*
+	 * A security module may call security_add_hooks() more
+	 * than once. Landlock is one such case.
+	 */
+	if (lsm_active_cnt == 0 || lsm_idlist[lsm_active_cnt -1] != lsmid)
+		lsm_idlist[lsm_active_cnt++] = lsmid;
+
+	if (lsm_active_cnt > LSMID_ENTRIES)
+		panic("%s Too many LSMs registered.\n", __func__);
+
 	for (i = 0; i < count; i++) {
 		hooks[i].lsmid = lsmid;
 		hlist_add_tail_rcu(&hooks[i].list, hooks[i].head);
-- 
2.38.1

