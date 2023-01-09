Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5723F662E2B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 19:09:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237386AbjAISJM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 13:09:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237661AbjAISIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 13:08:34 -0500
Received: from sonic317-38.consmr.mail.ne1.yahoo.com (sonic317-38.consmr.mail.ne1.yahoo.com [66.163.184.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD9EF564C8
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 10:07:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1673287649; bh=VAdoOW0TEXJpnEZ2JjSo0tS3XBJHEDUWL+fQB6SILsY=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=EXU0PbSGktWp86N9l6ohI6GaxpEDr1HbVUmY8tXErqH3k1ktRrTj1mFtwjBH2P6lFyUGAXOrLDiBF8odUpggX5b8G058cTwMPUCgkuhUv+mDpPbd0vhnfU2yXBO0d67wil6aroXNlyX/vFcKjl7wL/Qg6kzSBrQ8opFwYYcqUcqMeNuMxN6FBplIBjQB7QW+7/ZK3H4gg78Ln49rC4vl2jHTMCwuxNrX5Lj8CD+Ar8sKqtcz4GkWChPXxflP3K9+0VTbB62SjKltF4xgrqizn32szQRx5EB2f5Oom6piJXYIiI3KIU9PwBDTLk8iOGZ9UVXsr6m/ebAGe+GCEAz3ng==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1673287649; bh=rcE75AFLFtGYePXooNUPkhSdIU7LLdjt9iCvCuRJr6l=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=TqaPPG4TK3aW0bPBs3D1ea8utbi6Hwo6W/FaTQz3bXRkGydqEM0XQ7dpBaiPNmixEA/DhORPuQ5Kb36cmO5+iWFRbI4rfeR2D8/Gq9Yv/PFG7VUHm/aTvbryHb7KBz5H6TLP8ciTml3NlRcTEQ2dV0mQ8USVv15MZYol1ovIpeq20wsHdJrhhOtOM2T9XkyMtd4NRw0RrT4fXQONFc0qOYHVb/VJsk+7+HENb4mL7vpuSzhTL5SVb2DhePHrGzlDBzFBEfya2+3nxRTL/n9T97pfgh4Dfg+FCRbocHkzaQnIQ7zdCe18JyVuWwECX2l8Gso4CmUmiYp7EOKBCAMg8A==
X-YMail-OSG: rO9f2J4VM1k0JzVNDNEFCBI0bxSgKdEL8Vq9k.YSKo62FggfhIeRWQ8zrAg90Sp
 Gt6bwGqBOKGn7ApGiZnR8thn0WMjLgxBcmsDWjDFM6NsnNIvmijjnZzKfP8gqu22qL4DMPcLiBrU
 036n6j2YazzvZSY15KIl825QAazjzmtvTnK_w9moH4PRs.wH1FPrLrap7QXG0MAP9H5SwrWRBzxY
 YPapR0B8vcp7Oxgd7AslNRHo3rWj.lbwiNS9sYP6RVwoXTkkcqLGVsNaeLQiKJEJG7g8wKd_TpfV
 tR8rWsBhAxE.5mWQMwcmQceVXnb92oABNbW_Mp6YV9q8r5lKDldf0Z.1CMDIMbuW9o8kYH35h.4S
 Xa9NvLYEzJYkJQhdmjs3dS9iMUc_CTE2KeKce.p0zH6eBIna4cK.k41GlI8LOCMGYXMRTV8FLkLG
 7MRQsWDgselkEDgqC8SjqPUqRdxd.N6uvPtya9y9zNeON6FY1jr70DYaDiubYeDwVmL2w7H5dvgZ
 VPtzKs5zgXEJxlEZ2YLRzwRQZP_yMZ8LkUI365Cq4j.FFKf17X0x.B0VPoFLjwZlRjjvDeR4ZUc4
 zlEtaTL9e6MyuBNw4p373WSXz9rHy3ElK3kHraSErQ0pWIyDDEp6ruZUdCtC.3jwINWWguejNxQv
 w1nIP.Ne646GGysOalq2NHl_1YblUSPTYEaQgF_un5HmtPBEyL_UUpm6btZWwUfITibwmU6ztDwP
 oby6lmE39rnK2dwfVObPVOtovSGsa1tqUYRItZ5O_iQJjRHqDqTNsKStyslvU8emXQeaxkpzUU9p
 7UDf84JCDEnoki6LUxFbTTU4sq5eNzIOIMpqgmRL8PiEtj0_zo40ICgmCNd3CXND8gzmtsO29lVl
 JdVKY5B44ig3ht8iSU_6IMdWEQjuAiHaqb5duy2Rr5lrJFk_9VZCyL474qpht_EabYPENhsqDBmT
 Cna61bwaUKxEBHJTbZk8NuYtDMpFQEa9uGUoKFCNWKOl_Kr7nGqJlus_3VHBcX9jPgyksxAtjwnk
 4J4hT566g7fKWmFfNCuuBNWWpT2i5nRR89muGAR4eIVbYOX_HChH80cqkm5wdZcptruH78IvZe.x
 S6IlzZUDVZH2tzWw1w8ttZR3LebEIaVhsPtU28JcKcmlwVeKDYQVWrmD_QKZ4NJG6eeeQ1caw36m
 cR0DMQ.EFRlNGv2ePbxeA7uQBSziyVBamHxph_3IEk9VtzQG5w3pW8NWco_K2ri55IJr3.pPDBGY
 HrSDBfcsLcA5mZ3VxD7FNk4xYbNye982AGS2vnj0AxZBode0T.1_YuooQd0gyv13jz0DbIyw3CV1
 _0W3PK7e73hBzmJPlDJXVbywPpMsy8YJ_BKF2Z0vggXDKY5x8NVGf_bBBZdYW2gRf2fJl29TW1e3
 ByfU1z5TPztnb4W51y3OSNcFfd1GaSQUDgj80Ut07pINgXydvEfuhNOzHxEM4cz.eSXUQShnwEGN
 3VEXmYMH2XwlEHBb7qhiYlaUg7LNBB4wQ5s05D.CUM6c00O3S9woP.r.Zuab67yKrPFxMBKAdRR3
 jdGlM_RRiS6Cu_CW5zmO9h98zHDcaW6kCtS.jITN3t4y4ERdT4FZ7WwvPxC6YcdXj8Q61LXo2Ac5
 Y58WSLXi90RaCb4O_p1w2qkQ534Nwz8TgUXk.vgKgurJ.C8YaXbA7lDpFzJRk7e0EghJ1sqS1Qgy
 vhSbsbek9p7FwhuQ1aWhH6.XEL.wMWAWGkF45bE9hV7nUFcxQv_3eC0ksXkgLJ30HNZVikbYGHFE
 52MpwmIJKqS995sSukZfVgR1TmZ4Z7Y6Wa7da.wDLci2cVXd7i6tbFFg_pxtHCi3raX4opvImee.
 Fzn0.KJQwfFUyycUTRq6Ffh0wsqntreBRX1rIThyEEyWvKb.dcsZNwnQJ2X5Xp4J0GvK5LuRd7aF
 8rdbILAPHNPRo42DKHZr0XTty6TLvgYA_7Tb1YDWIImEAIfAHCRH6nghMAv6rJGliZ8a12pKxrtj
 oGLQ25VX2LinD6cmh3eDDbAUVVvubWP5mUGmZeyMr7JqQVi98_CWKYQ5_LBYtkTg9STlspYLGfbT
 pva42h3FJV2Dv6qZeb15Z6J5JwCi4g0uPWmv8zlf6s52w2Xb7t8xJ7d1gbvF0Ejws1mWGK_m1N2s
 ps9I9m84.2ESxsZWVJkU6I3krGARmR.wrUhW8B6W3fr5Mttd.qWpqHZwIzId70Huq8yNVRQ3otX2
 oZaUpvJXbWQdWMbwYsFJJVAgozEe0d62YAwYmt1I6
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Mon, 9 Jan 2023 18:07:29 +0000
Received: by hermes--production-bf1-5458f64d4-46wzk (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID aae4f9f8595ff7b5b642ca19e86fc157;
          Mon, 09 Jan 2023 18:07:28 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     casey@schaufler-ca.com, jmorris@namei.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net
Subject: [PATCH v5 2/8] LSM: Maintain a table of LSM attribute data
Date:   Mon,  9 Jan 2023 10:07:11 -0800
Message-Id: <20230109180717.58855-3-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230109180717.58855-1-casey@schaufler-ca.com>
References: <20230109180717.58855-1-casey@schaufler-ca.com>
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
 security/security.c      | 44 +++++++++++++++++++++++++++++++++-------
 2 files changed, 39 insertions(+), 7 deletions(-)

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
index 07a8fe7f92bf..a590fa98ddd6 100644
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
@@ -388,7 +408,7 @@ static void __init ordered_lsm_init(void)
 	for (lsm = ordered_lsms; *lsm; lsm++)
 		initialize_lsm(*lsm);
 
-	kfree(ordered_lsms);
+	init_debug("lsm count            = %d\n", lsm_active_cnt);
 }
 
 int __init early_security_init(void)
@@ -513,6 +533,16 @@ void __init security_add_hooks(struct security_hook_list *hooks, int count,
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

