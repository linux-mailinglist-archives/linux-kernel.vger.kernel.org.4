Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63F7269FCBD
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 21:09:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231386AbjBVUJJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 15:09:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231500AbjBVUI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 15:08:59 -0500
Received: from sonic310-30.consmr.mail.ne1.yahoo.com (sonic310-30.consmr.mail.ne1.yahoo.com [66.163.186.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4DBD1A490
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 12:08:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1677096532; bh=SfaO9YNX2ggCyqh2Ryd/ehKKDPY2SHSxQhS09vx2DrE=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=I1GJgPCABsraOo8Dn4/ofn8WzmKVt7Dl+2lBZ9E3cOJKeWtOckap1zRdeonNnrG0O/SixlXlpdL9RAuwc257fX1BMVgyF2e47xA4fKvaUpunlEh3BmJQOE3QbTYizXnscS+2iCEh/ceESKqsjNwZIue63GSYQRzxDCOn2wFP39whl+hnKUR1ZpV9eRiEt8rNw8N2Aa5SraNeCPS74x4fgjB8fO7s3wfqS/URwtaI9vDGX10e4b6CyzUZAOrZeClbWY/yhx1ctDEc7dp83qgHYDzvYTIQzV/5Yne+W0Qy6lXm7ne0yZGJIk2ydvV/MypvHuY2LSsVeRKRxa/X90BWBg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1677096532; bh=nTrhMU7KjMsspPITVNZQx6DAfX1D4fu7wEUSY12U12c=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=jVR+techqqeB4b4pMYa0VX+WTrDSNZfs5x5POZV8XsCP/NBFMSGwVLHUNXOQfqcjRGhuU1ykVnGTChzDX27RFFqNwZSBgHIddIfpvehnKWpPNOlF1muu4zV/XFe3RcCsWQQ3XuRmAi1ncbMng3Rfxgt2ewY992+6sRp3ABaJn8JGBoRl4RqXGkaclG1RSH+CzLGohq5Lj/VJArA7eO/Uiulo6TM7Q4owjInqsVAl4A/E6YtijmrnIFTHCq/H31xdu44x29jOMCDA3kxl+dwnFC6HZnKg19DkusIMaVdlIX3ymC/nrdSRyiyR+3AB4txHN1Fa9xQJl+nIYwkQrH9rFQ==
X-YMail-OSG: EX8mdDkVM1k8pKw.ioimmG8G7gkIkK63ATUH6.8JR9Blk.FrRUaSo4w7AXEauJx
 X_9emoyaJOioHAVFMP.VzOrZponoUPvZOguN1agUpWsUPwkE1AfuF8uU.tNcPc2cbfU5QE8kpedI
 KoBiEujc5Lzn5IHteLeDTFShTdje7qFg3qVvCaV7pg3WPicl0hqPtk7CQ4WoAgf9xHCt6odbxf8b
 azuJsbMnHSM3sutoBmG49cIb5YzKkhQW.qjG9JchENOQGBBr6qHcfj87FfyAa_FykckDms32zxSB
 HgKtAkDKdAMAoDVio6meRimNyIQ82v7k6xrO_wQqEeTRP4eU6F.sQ4s28A7rz1HtybzH6ZH2Yw7g
 z92odHxFVzTBr7DKTIwwamOeTIQ2R5TqeJxhBaCXPHzJw4LlvZqY7WhHR5eYuSPIC_vk_W8KeqZC
 SPm3IoPZVtq.faYfGqVcug8iqy85sn2kodMG8DXvOCfQpDiPNWbSeYwUFVrHShvJwvNoN8u6zma3
 fNGLcq1dFhqxUU9m9RAhtKTwHAWDgUbcW_J45ZNB9k8SLlq9bvliiq0jdkaPRd4MXO_2H9ZwpOem
 r51ngSmZZTh8ja8SkrjWzDBuXF_yzHevssP0_5aqtMzrCQUoKc0588UyadsfUmGb5_hqQgJG2fr.
 tGlUjYXrFOGxXebOz1K7C03VLQaG8XCmUtSnceJRdHVOh9SxCnZdwlMfUT3f2_3LAhzTDzNefWJl
 B8YzNQB94WC7VuYRmGMlB8eojSfPJD5kfVSa84mL__iufq5zYdwriq_yVPMGtFPUSheh_sCMxbTY
 Mge0HVIxk1A06VYMOalcxTdEIcKpYm1yCBCClTDFKkWseBZEyCo8fHvdvZThn0TCpNeYNriD2TTO
 6WCNOLG8PbbrtTkKMYRzU8d8Df.0PP5SMGDwziJCKb2sKpo2oD.mvO4dfT_X2lRhHtVDet62Ojtd
 HXajGRIBbTabMoUJxC.Xt.llTtGt.6PonvtnFImY7KgRnbkyxyUlH5AB9AE7mZk.Bj1mYHZLqL72
 Qx09n2VN7D2dJQxZInDC7Wx8yU1t0E6vDQKfjXgMaFh4l16XP2lj01xelZE9WCR_wLtNbzUhDDc_
 vfFb7gLo.Ls7s0KL7Ef7YZ3JN2u8eEjeBPyJ2Utjt6d9tNd78Gld7MqBoU5jXcQUOt2M0HO6ExI6
 F7Dkjq7hMG08RmnkH0WQJNzZF8Nq4tHna3eprHjGvIzZJrFcD291bPt6XvMF9pnksP0IN1.nBGra
 vMPSEMQ702DA1tH4DedqqfATbNQ2q_3Ur3ntEdyYD_f38EUw4Y26i0DuqTgbpF3p7j9ywl8P2aFo
 I0RH_xjk5Zqin0qHzSsAw9UnoYDYQGlWWkycoiT6VtZkaT_80xOQepynlTErVqG3ZCJ341VDgeso
 lko.mpXRnFsWQlwJph0AmUo5ob9TB_hOYif2waLF3A3cT6_m8rrbdOmtStsJ05if2skooPH_Rqyw
 il5mHOQha1moYohgjexObzQvaXE8X4BW59DCmv8K_K3_lsaplP5_0X_qZlkXSrOvz8ooIT0TqyZo
 Fbh46MNoj6_9pdug41dJycQYfyFREr4E3PwgJnr_TJ8LIJsM5z3krFBEOacuP_zFZSMrtIOGYt2X
 Y._j4pBTQ6xYXTkwuKBLgqyQps.w8QtTa2Id70pNwYQL.LKfaKnbiULCBDjWPBKewjwVwcEfvoaE
 pdE21n57cbvE_9sYOZVjgJshVAIfz_UFila74dCYAhJ4F862Qip4lK8Wj0ANQg2Dr044dyIpBUkM
 Sx_cl5bBB1jWdK0e1JeCHfW3woXX1xhSulPJvrkyH9UN3E.ayvEVlDKsrJ59G5Ok7VFrgcOve02G
 krTBmSu_kqUjgG.YQShGESyH9jxOXXGGMji5S9VNBDxRJN395nNRcRHCo4PwgQJDyjcGMdbV4k_k
 sitUyhXzUmYhlALosh3T38rZ5IaAchCBGZSWdEqbcyVnJ6dGGl6ZrZ8KXWhK9e22hAqpvHD_mWE4
 axeY7YHY3cfH9dWYGS6jc5qSgrhVucuvG1OWv1qpSczuvWY89HKcn30DA7jyGdobJ_Z92SmsIB0S
 7x4aIUpFWJ.nc29LpcR7RGN4XVhLuypRc375qLGGPSQw3pZ.vuiXemsiqmbQGDZCWVC8f7mvLCzo
 JrCmYALBTDWNnfMzNTOQ4MQt8YUuCXmq9y2rF_7JSzXW1Ki2OraQK7Aa2lVLVdkUMzwMf_KCxRHC
 8U0ksndi7UN.PYtWvzuhzBJO2jJYLV.qHfhQ89LH.YMOKpqH5L_TZgbx_M9NvpgnoXNux3YQk9qY
 sD2HAe44zhOjRjV6GQTc-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ne1.yahoo.com with HTTP; Wed, 22 Feb 2023 20:08:52 +0000
Received: by hermes--production-ne1-746bc6c6c4-z5pmw (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 38997703594d64a58154546cd21056fe;
          Wed, 22 Feb 2023 20:08:51 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey@schaufler-ca.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     jmorris@namei.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net
Subject: [PATCH v6 02/11] LSM: Maintain a table of LSM attribute data
Date:   Wed, 22 Feb 2023 12:08:29 -0800
Message-Id: <20230222200838.8149-3-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230222200838.8149-1-casey@schaufler-ca.com>
References: <20230222200838.8149-1-casey@schaufler-ca.com>
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
index 5b67f208f7de..33ed1860b96f 100644
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
index 07a8fe7f92bf..4b81734ae9bd 100644
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
+	(IS_ENABLED(CONFIG_SECURITY_IMA) ? 1 : 0) + \
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
2.39.0

