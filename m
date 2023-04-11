Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B2766DE03F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 18:00:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbjDKP76 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 11:59:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231215AbjDKP7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 11:59:47 -0400
Received: from sonic305-27.consmr.mail.ne1.yahoo.com (sonic305-27.consmr.mail.ne1.yahoo.com [66.163.185.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E635B4C1D
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 08:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1681228776; bh=gX2htUbJVQu70tjeZK7/GhWqFSnOffI4/UYVqiCQJFs=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=Ue2NVC7KffB9z5iV3j554EVJlVB0/9qe1bPpUoFomjAcJyXMCAGvDe+DpzPhql/fLcvy3RJUljAQPYy3PFamsxhw4F5zZxpMOS2FQKJZmrpMG8F5tI3uGy2xFbHSeHGHB3r8UdkeIYw/y4cUcDWnZ93im69ISefUZpTRGPiRKKIU3IpM1afMs76ri/pMa0Em0Z02XifPkEQzkVQAWnZZ/Bp5AUKMA6E3YCOE75HL6sjzFp3HoCjqC4tpvBu4E99d1GTCQEB+Ue9kBBqaOql14CLaGZ77e/u+uf85Rk0e6kI5jcj9zRkFlYGkX8P0XBY5bLqB2GN3ULK5zwnDKlXG+A==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1681228776; bh=ONirwGak/GEi45uod0w1iuYoDXABE08JVrQWgjmETtj=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=m/cQ34un0rx+JC6BjPu/XLk+v2JxYp1VbxFCxC7G+jDDJ69Fb8P2T0rqfry2EVLb5ZmwDw6uO7g/XAolzNYUBXfqVlAdGsmQK5VJHyZZVBQBcMh7jyR7VDX1oiK5+4AvDhTupvnj53/EMeZ+Zilna8yJ8HK2fTCtZFASaLm1QIJYLjCm+OuFDLYSP2gFuQ5aKoSNJM4eM7Svr8YdW5yx3ZwE5fZYLJUtYIwYcqr6YWvLnsitQpXYd7nfaYiOjYgZgB74JN0/6m+EySDT4mD6aZmPwiLfMJpqbsGxhW+A6+GiacSNMXoz4G6LZZJXbEFEFACL403bIxvpev7uXLPRcg==
X-YMail-OSG: mE6zsHcVM1ksw8BrjaAQ.js3WKJQ6X7MxmAVF7iq4YRjlJ59JBeH4vejlB2_4du
 1E8aQy8jS0z0XFTPYY.GpzNzCXy3Uy03g1X45ksH62DpL.f8960jOdaoqa7_tY95anAIuNhcJm5y
 Zn4L3LFE2jSTs6jb_omA_juxlfaB1c3GiwMx9OdHlMpFt87r9gOlQcDQUtcHPyUxb.SusShwZS7t
 VLYaGFgNNkYYTqKvoqfcfBlBgNCMxOYRkK.k9mkfjfBVW3mm8YX6AKIxh9YfuK_p.9Yxztb3wNLX
 oJqJAhdxJ.1USJzv22WJefaT8PaeEVVPqZ_M_fjRwZ11Lw3oJdNWN0C.eYwR2sU4Zis1AX_W13FV
 dsZGySADE4mycEU8rtCahCF7o7iQBew2WLWkjtE5c0vr8uZKgeqSib9Dfj0zsTP8GRiAaYcz9xYW
 TxQRv7CRmG47Ux3iVm7UyjrYB2O56KFQ.4Ns9wRwLK1tGfaJRhIJ2ZAZ7htFQhHGFroZqYxmRkZ.
 j6ois.UqxpXsAaa1crxdTVOndKusYQn6EUtFAFrknRI8eZ086QMn1F05DpdpQh.Xk1eBsWyPpx4A
 7amzgFvMMRf5ocREo9r4XXrYWhWPu_MCu8.FOC.xIHZtRE1u18l4GKUdXaLE4U9DxJHNOeEFflOw
 yHtFcXmx2sBwuJmNBSHNQfQY9b3YA4uF6SKwsIeWMrlVyNBBcCHlV1zDcKLHpFh82D7LiCIodsSa
 THjrWm2WufLkWfR2wuggcwd0iRUmzwvEP0RiXpEXxv1EC.Zk.zF1oguDs9ztRvdlObVG8U8DvVzg
 o4xwsX2ad.6Kbd7gX.xql7wyCOLCIDVKSwGogjm7w6BMAT1sFdGouofXWlW8k2sWdvB8ba2eCu0k
 uwWt80L.utJSPmWkOb9XKCJWh3P1n4p2CQYi4woI9s1YTozRb9oRU1vF8KneWLCkMLdZXy6DdAf9
 ETuA0Md58waUa2XYeVSXqrfz3uFpgua6hp01E1ZfotGsxfwnpMNO7.AfjOwuf6E9eL6Am.Z2Su4X
 nWQQxZyDWQD0hR5wkRzo8UMFv4o3pc6y2xVCv7KoCokSafwomtYxU7G.CUNt8a8eIj0ZLGnA3CRC
 JQ8IhwrKYEbttlNpovLeDf1AMQryZJRDw5Hwar.xgy4D1m2B_gg9AjdDBKg7g6gGymfI8psMMQqV
 0HcmfKMT9fJZmgYe3XR4xP39L5TgJV1LbnjBePQKHUhSDIQziqdcAKF38CVoDIVsngyKkqPc32w5
 4aZp6VRoD6hCWYcKrudAh4a50_eUbzEVmC8ffu2MgMYWkKrdxHOUxShL4riLBR7LLZNp.EGyidXN
 Nl8qDXdS8AzyUyibqyt6C4teX.t2IIS_voMQa7nhC64nLRS6OAcV31ZOseo.z6UNW1stCwx_VH8J
 3sGgQlPiC.6d36p.8YnDRgc3hs4G_nwLNjhAh_bwYE.nTvyiNx7yP.JufTZ_4S8NKJUFlNJfRVp.
 inua7.wRvjuIJgK3ySzPxvEk0FOrAWGqMYtA73BI7BPLoeGGJ2vQQ7ys7W9BRhQMr.UKOzPypuGB
 g7.PtTVIzh2yylEjRsqHaj3vEWHsRQt48fwyxVvCFC32_O6Im7D9JFiov6LXpoJJb4iMshsURqx8
 OqI.pzKltv1nRCnWcjXkgCFtfSslGMo9hzz5iLqz.z33e9Ap160ZaiODQNthsAsNQh4GOgapljUY
 938F9yzIysKUzVc9UM.fUNYotBet8bS2WWCKuM5q_oRREJVyTZwiDh44wPznU.OylHs2RnpDVQOJ
 t6KJshLVqqP7_zp5M1_zv6Yha6uBvPSjvgyW9byadTaiO_jp12J1O3JtrbtJWDy5XjlvMMjUFwPc
 jNEmjIwUkLpk03BRxS9WA0P0JhFXPjzrVsL.nWqaZYqopE2DCQWXdMZ_6nHj7Tsk3K4ZPA.DvZl7
 ET_AKNl3HNuJkdRMrnOFvfJh8DSnwojHLWshHzxN9R_O9nY3GQfUfQW2Dhy7Sl5qSMHFjx2KxwJQ
 Fr2MCxY19cOr1qwc4MpgM8o0blI7DCan3g6Al6C2ySRbRnJnIEh7VAOjtZBXhsoyKT6gUv2.fbJ3
 _VAh0eu9AS2cYzIduweuHC52K9tcevBcpgwxNGaC9vu6EpMcclzEmR7IM_32yBE4jVMtQU.kL_1E
 3efKBUZFWsrMS.0T8b0fLkJzIBPWFHIen9AkyHkh.uSmIslTdsiJw177ybQRJ3Eymvfz4KRv8ipb
 EO6P_TOpnZPBXjv1ZoKuSJDkkWMUJmjav44Z_W6c-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: c44af405-3986-4b1f-84e8-fe4ddbf60659
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.ne1.yahoo.com with HTTP; Tue, 11 Apr 2023 15:59:36 +0000
Received: by hermes--production-bf1-5f9df5c5c4-84ds6 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID bb1a3f7a7b49e6371e007077b829a9fe;
          Tue, 11 Apr 2023 15:59:31 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey@schaufler-ca.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     jmorris@namei.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net
Subject: [PATCH v8 02/11] LSM: Maintain a table of LSM attribute data
Date:   Tue, 11 Apr 2023 08:59:12 -0700
Message-Id: <20230411155921.14716-3-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230411155921.14716-1-casey@schaufler-ca.com>
References: <20230411155921.14716-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
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

