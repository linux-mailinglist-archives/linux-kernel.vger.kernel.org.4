Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 247F1636A62
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 21:02:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239665AbiKWUA1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 15:00:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239652AbiKWUAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 15:00:04 -0500
Received: from sonic310-30.consmr.mail.ne1.yahoo.com (sonic310-30.consmr.mail.ne1.yahoo.com [66.163.186.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25A37C4B69
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 11:59:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1669233567; bh=Df7bQuU86RtfRmA6zmLEew+17FaTUT67EczNgrIKLuU=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=LzWZDEsZMPkS7FqzStXus3cZZA+cuoZjbdRpPzsLTuQiOnb8noEIaZi3cjnkPUvesOQvcTypEd1EAuSfVsOwFnS3FfipF9jiAUsMLf/U4ONERj7rHxVVmizEMwGXHXlZh9JPj6RF+Ww8RH9VPLv3wtvRe96jJFpF7PL1CurluTd03IeqtpQYnXnhnxZm66SVsljZb8LhG4XTnwTLJbZAI1RCaT7jw7spjrYHP8lxq4NNeKJbh3pvrOkA2x31+vLOlVXS5obQkv5k+SSE6ycBFBlvc17/K/RFpmWc2QwKwgLWQ65PslKWa/H0t6dKFxsg8zaUgwZCQbhzwFHCluvikw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1669233567; bh=PcYfVldnlRVfXklkhXsEGLlRFrEOkvSZ7kAJn8UJy8z=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=RdFqovRiRlX19w/5iUWOE4qI4P/Yn5mULXHt7rLZP7LbRn+4btE1xNIbfI1LXPUhkkY2f9S0OtSsatlrCMx218Hg5uOt2v5T0HTeq6jJ1s2+Ps0twi+ggHfKZNgSUgDUjdM4DLamMJN7CGTQYBGJpIZRNs8qHQUSZ1nMNe+dx9aJhc5fKDgysSvYjQ2EubLCI6RnS1bl8baptrQR+OgI6M94S0+W0TVB9UWiPqoOwy/FT/yu3enytmjwYT/eVxNfTENCgnj7HRi5mPV1G5hTj31z7pja6447du9Grw8M+ynUJiw9iC9Sgq/Ycp/HFaNvhdoVaAPTJjdakbT3Ov/e8w==
X-YMail-OSG: OMxEdecVM1nJG2RDrjNhkFW2Gtc68YR6lTogWPW3mpQ_H9jBX3zwM.xd_pdnxEP
 Y.Vr8EgB47ahts4hs4nqxIW4e5lgRvk0ecOLfPehR046.AOcxRuMwqN2Fq15WCeuMUFDeeJa0UB4
 vnng5PEgh0XJx4yvdDvOhQPdfs2sHfxnm234rlm5GS57Khu8yfEyi0LCAAcNtLi6Z1k2DWCggECJ
 PCAz0Y3LKwsZ841Tv0OXGYgK9yPKWHyiVMqcZD5yCexLaKy4hBRt3.mdgVf1wu5zqvKx7ugsgxT3
 gdp5GiV1RCgwjdkDWL8oJuXlNASSxkQ1ey71CoERkrVSp8XIo1Lx0qz7XE7jeRfvTyRm8NxPNDuX
 dbs2uHCto3i1av7NtAw5Vq5gV.fs8xDF5PkFyaiDOHUPTzmXFcEtTHrDKpKejdArPfdxWJ4HPx2J
 J3nH7Svqiy8SIgx70tFHyh1TlzlfTEfJ3Yo1vxogcj67argZDoKJGlFoF16l8AmhvpSosqtTS0UC
 jiP8H3DY79wI_SLMtMYZZ.oDH8c7F6oKcBM9rU71DcB9MmrkDVIsPpAn7jaLmKspTDWrkPq_xPtO
 Zoh2BXak5.XNaqBRa0nxz4x6rfV9A1rEdhwIyYtQN7cxUFWUb2Q51BikpP1W9nhTPuWR3x3sDz1B
 xujI.4j5BQotIhFkfU_1hghH26zy9lFET.ezXJLRVG00J0ET_E19gEbPUzd9DKmJy7.pwOKr6KWN
 LpUudqjtY5P0z4smnxy3Pm8DmhUHKz398OrkXDwqy29Vrl4vwCK89eIsyNDv8Dw2V2c83Q710xSH
 NmmfQfD_Gk3VxTgiWudQ3dwtruB2MRpC0bgTk6ZylVzuccyba1iDIlordSYSTSE4b_wQ8BgZm68v
 dv9kzH4gnLxr4eAzBbDhEaLgAXW4m5fP2H2UhtiQGPV8wL0oMq4bbctSB62.MAo_dvUOObKoDMJr
 .JyIT9ZbUS.CTD.CAaWc9HMu.81_IB37QJYJdcyudwE9kKLbJF9bFD4FdLLQtxzVO_ysar1l0GwD
 PISf0LPMRk_eseyOJtlu0gqzPGNcs8zvD_b9IF0fJcSUMBVrCiNa1.ulmEBaIv5YO3Zc_QwYo989
 8Nq7MGXUfHgGy_2sWWY3vhsCoPN4yyR.ro89pqQPiFvS9I6w2lXNhTI_rCdGEAO.AuAPcKc2vK7a
 VdGMxChvJQ1qL.OmwhytPB6gUd6FmWHSD6FmRDin7.SShstcENCBUN84Rk0uRZPpRm6MZI4YUUXi
 iS8py.n05f9ylpmFtw3QS3FV1Fgv0rE6xyg3fSoNOsNvLAubYA_LVL2J.f8vZZ6kXCGfwfEuYRgt
 VYcma80lh.PbUC1eISj832ZhhQd6tICZzL51cWhIM0gHIHOT3InJw.3EfxeN5_8FnM1.uN.hu6vn
 jrSdjpOyaSCLiuv_eXkXUooT3VvjGEnBmg2gZx1hDXzfK1irR7EwynzJCyP_hhtdB9p2goTgKXDb
 Dl5KRoD8xfXbfSP6ct2nMY4ZJtDpBmhNrm27a_bJ.0ugTgSrdPgYM4mAffapMnuPLj.EAzjKDGe4
 fprcaYQn8XsPok7Z.FEk9OU.OQF1QAZ8x_0oMsx9_RYCSyiA4_0dTzkv6HQxzuIBPWWgDAOaudU3
 e2oTMILJJumgLIt9EJbVPa4Vi2_qBB2SLGQ26H5W_oiha.BYyejwAWh1Ul4xszeZKz4SZrC5ecCS
 RReo7eUSaZh.bFOeWTv0N3S6ldWpqIs4QyrP0JLGVPxVSGYutDxNrbDs1JHHcKjNfdcp1EvgHt3a
 7oSnOT6Nz2bJzUKzoB2hiykHs6gJtSKxk.21T3bP89Kz7uqZarO56I_IpzRIY.nW6VCv2qxurvmO
 npp9WL1TE8yV8Q7uqUolDSsGQGkla2lwakJ3BixPvreWDIkKUq.3lXH0VTQAuAjFbEccZWg6iCGL
 ihS78xjrC25iK.s2syR4JUK2ugpRaPX1XOj3gJ__Db5iJUfZZ7xmLC61kvBnZ4gU7fonDWRb9NXJ
 6wS8fo_jprJ_gFbwOVKSo9wYekaDzleB_eymAe5ahMdYR8.8AhvGloO3tM1Q32Fes.XJ3eWtgrRI
 2Oqf.P3vpRbNh7tJXjZS2e.FoY2C21x6bcbfUmrUW0ZS7ZShFFLIqTvdOZ18sEm.VVmNam7TTGJl
 hOgSNPADIYbI9uFDvQqoEEhHpn360ALu25XTWuzms1NLoJ9lphotlAS59BFVmsr6nxAZdrkiE8VF
 N2h3.eJoh1k6.hgZ7qbRtSoC0ye3Zbf0PZY8W4W8-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ne1.yahoo.com with HTTP; Wed, 23 Nov 2022 19:59:27 +0000
Received: by hermes--production-ne1-6bcfb7fb87-kkrkf (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 3db3b97863d7dcf681a7c4ed78d526dc;
          Wed, 23 Nov 2022 19:59:25 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     casey@schaufler-ca.com, jmorris@namei.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net
Subject: [PATCH v1 4/8] LSM: Maintain a table of LSM attribute data
Date:   Wed, 23 Nov 2022 11:57:39 -0800
Message-Id: <20221123195744.7738-5-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221123195744.7738-1-casey@schaufler-ca.com>
References: <20221123195744.7738-1-casey@schaufler-ca.com>
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

As LSMs are registered add their lsm_id pointers to a table.
This will be used later for attribute reporting.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/security.h | 17 +++++++++++++++++
 security/security.c      | 18 ++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/include/linux/security.h b/include/linux/security.h
index ca1b7109c0db..e1678594d983 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -138,6 +138,23 @@ enum lockdown_reason {
 
 extern const char *const lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1];
 
+#define LSMID_ENTRIES ( \
+	1 + /* capabilities */ \
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
+extern int lsm_id;
+extern struct lsm_id *lsm_idlist[];
+
 /* These functions are in security/commoncap.c */
 extern int cap_capable(const struct cred *cred, struct user_namespace *ns,
 		       int cap, unsigned int opts);
diff --git a/security/security.c b/security/security.c
index b2eb0ccd954b..bf206996a2af 100644
--- a/security/security.c
+++ b/security/security.c
@@ -28,6 +28,7 @@
 #include <linux/backing-dev.h>
 #include <linux/string.h>
 #include <linux/msg.h>
+#include <uapi/linux/lsm.h>
 #include <net/flow.h>
 
 #define MAX_LSM_EVM_XATTR	2
@@ -320,6 +321,12 @@ static void __init lsm_early_task(struct task_struct *task);
 
 static int lsm_append(const char *new, char **result);
 
+/*
+ * Current index to use while initializing the lsm id list.
+ */
+int lsm_id __lsm_ro_after_init;
+struct lsm_id *lsm_idlist[LSMID_ENTRIES] __lsm_ro_after_init;
+
 static void __init ordered_lsm_init(void)
 {
 	struct lsm_info **lsm;
@@ -364,6 +371,7 @@ static void __init ordered_lsm_init(void)
 	for (lsm = ordered_lsms; *lsm; lsm++)
 		initialize_lsm(*lsm);
 
+	init_debug("lsm count            = %d\n", lsm_id);
 	kfree(ordered_lsms);
 }
 
@@ -485,6 +493,16 @@ void __init security_add_hooks(struct security_hook_list *hooks, int count,
 {
 	int i;
 
+	/*
+	 * A security module may call security_add_hooks() more
+	 * than once. Landlock is one such case.
+	 */
+	if (lsm_id == 0 || lsm_idlist[lsm_id - 1] != lsmid)
+		lsm_idlist[lsm_id++] = lsmid;
+
+	if (lsm_id > LSMID_ENTRIES)
+		panic("%s Too many LSMs registered.\n", __func__);
+
 	for (i = 0; i < count; i++) {
 		hooks[i].lsmid = lsmid;
 		hlist_add_tail_rcu(&hooks[i].list, hooks[i].head);
-- 
2.37.3

