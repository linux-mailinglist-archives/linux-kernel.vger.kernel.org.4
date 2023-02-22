Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B92369FCD7
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 21:12:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232358AbjBVUM3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 15:12:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230406AbjBVUMZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 15:12:25 -0500
Received: from sonic310-30.consmr.mail.ne1.yahoo.com (sonic310-30.consmr.mail.ne1.yahoo.com [66.163.186.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 167CA457E5
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 12:12:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1677096727; bh=fthiYvLncNlVuBP+yA6Q96UdSkL4BSkWn6sXm412xjg=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=neAVVCSOCkpAsaEzGqU+1mbl2uWVgZYpeb1VKAozNaaR2jWnOeiLluQ48mqTgRl9DCVSeBQQlM0gLSaHoffOcig6+Lfw37cV5Eb0zPhgiOTBqM7UnVZ+GmINeFF/p3wmA8a88rraAsEkS5unFa32dm9pVRX/cz7+SeukbpPIPsf+eygq0V8GsF2MGE8Ymw+yGQ1tybz5yAtWX/GsIYhkRViwQHqJ3qoaprmxt0QsXns3qjehxcTkeo6ENVOOJfL3gpuNCINE4ewGrhDGZQT6Mox/Y9GemG0S/iEWu1srlv7OFYlEMiJf2GrTwUwTU3pa3Ip+H7li3b/SBHXA8JllEQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1677096727; bh=GmD5paehzcpdsx0FBd3/qIFT8uCUQOOlAVlCBVSGjfw=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=tA1U2MTJOIMhaHHzE551LGiW/gQUmlxmvaLYqUmOugwTaVUIOEZ6etF7mrSaqsqlRGT3NQNTRnjDpV2AQ+BaS9CfPIsBviy7SecFaL14v7nTek7yKsPjuzN2sfJKVapA2bCFnmiTKWSqqC6XUOVGCeCvdoHaekDhRJKKrkCm7UppQnDj4SnE4L4rGJhMQOQNGZALkV1YmGbkyYhrukenZ4HXHfKt0B1qxrf+d/BE+uDWeVA1ffTJMxoPmuNpIdpS+kC83bCNGYy0aneLHJqhSepbGBEi7IHcHP+QFcykVKVts0loxVtLP2PL7nLnRm9fFNaePuj1gTjlH3mrek1vuQ==
X-YMail-OSG: LUllRFcVM1lYw74ni8BIfyzClfM6G5qx.kx6jVk_BIG7wNV3ME2Boqk8fnJbvox
 iaFTNdCettjPq.R0BrUDZ8dwiRPEvfz9eb7S9cXnjAMe34zn7yaBFRnDYEumArB9KLENJgR_5kJo
 RCgC2f401GsKfwmRkBsFBz10B0nkZ5donE_DEM2tpclZEoEuuNt7LLUOmzz4AIfR9z9b_Hlx8vBU
 PD_RuA2HxNczrRplSoa4jBk488ISEk0C0PRM.vdEg5Ldz07U4RjpQBLpz5X4qKZI9EThPPSjH6kd
 Hu4UDXdh_XpA2k1s8EUQ5_IDXzrWqM1YFsqZKFpW0cRY5iVu9FUhW_qW6aqRLjIekvlGotLqnTk9
 LSOYp0RZPXy8QPfE1Bu0HOY2s1Vv5pBn.Mi2gTv5.MpaVBr.LjNEfjFaR0psFt1TP_J2jihOqrJ6
 OarBx.D1u7hZFpR4ED8yvgvoCn9JoXQoAQ_vcgZJxX5JFuUfykNqMfiSIKsPI2tRA0as8ZXQ56rg
 tc9RP.8yTPs2yV_lBD4.PZyQl0XqmUj8CHecIxmIesaQDVRnKRZJC_3kWKeYcl0BoEMDvQRntdaY
 LPkFtnxLRc9ttn2RQ9Qo2zc7ib6lKWbcGxsR5DL_E.Ud60VLX8Q7ZdSlUycgW21WEopQAM63hqz1
 7Qv3reoiaat7nKlWgernQeOJ0tIikXGcJ3bYuTzTZpkXQgU7wL2Ko7q0.4GkW9qYoYuYHDosoawc
 qb.PcLsAz7zUAV7plmmE32AKbWw0FtMjFJC8HeRiKxqcQ0IruqSJ0ylAHlgVn1ZEznb4or46Q5m1
 mFV2pw8YNuOVLLBnC.qgywzKUi34a1k5QIWZeoBQ8qR7mN9u6i8t90J1qTmDY.JK6ri.DEQ4Ojhk
 cwaZc7hF3LtItOkSVcElPDlBI1xjC9WxciVG_PFbFpQFTHyk4eUt_CxVKQ6AC4ybzFh3j5wDYZNC
 MUyZEFdgdrhWAP.bSiR6BhPIUG.NPrRbo1.ljrxWTSQAwi29xmuBRpywZIpyqE_3wVUnrdJ0G.Pv
 ertTD0ZL1074nF7KBBB1hIsxPGG7VdwzU2xhy9ofabA3sIlLDhZ5Tnh.oqJI9diDqg9Qlt4CX.sT
 UYZ9fyUUfcNAY4QyQrhXSX0WSRLQeLuUw.vN8PtiTJ2SVeWmotXVZ3q10GXEFqn96VKxfW4W8EZy
 aTw2RjUpmbseqF7UVSnb9H7OKHy_vsJyTWR8u9BI9l.Rl_xPqIRgBUGGOckV9EoPJtV5iMol0r_I
 kEpHPJugWcQRbIC2Rv78lSxoeLG6e6wOjItP5W6xQg9riZVddNF6pVeRA8PkijRRXLvBkYGIdV0O
 Cm5YFkq_eYrtQ867JU2apfNOHpACLEUHIH1.Vn3jj.Wn3BhlCkrCJBEBYG5T8Fz73V.z5qzeRpky
 YqIbo2Ub3ZCfjFxvYqG7sRPGyRJBEb6hV3Aj9zhU1N5klTryWK67bmOvs27T4wIyYWiC953x6M2n
 crk2sUZISMcaF2oA3ViDp4YWXG50ck.tSCWdqFo.wXpJguzIDO12WMzLIyyeObV42tjpXk1Zm8Xp
 X8aJ6k3_n2y3QUinEzT8D6Sdj6xoodOVOyZdkXeKeCatSKozJTuvztmJy.JeKE9lQfWEabg14dLH
 hUS9uE4VEOeWiAyTDQLRDBdAJ7gqsl7OUM_hlFzoujZ5wMWwQD7m2.IoG0_Lre9rfKj5up5_TrSg
 AtfOHNzqtBPe_Yol2iF0KEA4TWvBzRLuP2GN5C9lOTAf6.WoBkytjHGcC23jLzbknMqp44dB4EKc
 9U12PzezLd_FmKXZhdh2XcQ.rZB9OwQMqwEeilWrJ2_82r1k2uUSw4lPCl9ZPnM2QFKYCYhLRWpm
 DtmkxFpg18wtbypPAooqrLUQzpi43H4cfL6l_8wEwb796aDu41nK73eTAyW6QywxLaG7FJiJ.Sic
 hrx5yuWukldLeE7lPBbOk_cpzAlVBZ.PmMe8EJ2JBo03FwdAPmZTFhcuxfVNPr3_Z5f7zuf1QTN_
 CX9c0Wjmlho5ATpqkKvbjEMraC.NAwZ6eZc0mWnBnJXWn5iPvPFrL90KKki2te4rXCzT._ZCOavk
 ynjMWCrxQXgGs.geJd4IRYInpwHiT7xlWzbXvNxoKuQPkDYju1NgVba6lGsqanEyoBNwUAfgEU2y
 N_WjfXnn3tiMlnJ5Mpsz8t7hhHBPTxrHwmhZzaju6awoj7VmgvpUYJCxzb80KSmqOCFKpFJpe.p1
 bs0YqWrjmGo9wU._Ho7JhC2qRu9bPwTqwRcCA_LuVdatpHLIl1zBpYLAhgLyRj73tI9jA3DgSJfg
 uH9cS7wjms0xU1m62kZT2sA--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ne1.yahoo.com with HTTP; Wed, 22 Feb 2023 20:12:07 +0000
Received: by hermes--production-gq1-655ddccc9-czwwz (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID c7ef53d340a8069498e39800c60f4cda;
          Wed, 22 Feb 2023 20:12:02 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey@schaufler-ca.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     jmorris@namei.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net
Subject: [PATCH v6 07/11] LSM: Helpers for attribute names and filling an lsm_ctx
Date:   Wed, 22 Feb 2023 12:08:34 -0800
Message-Id: <20230222200838.8149-8-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230222200838.8149-1-casey@schaufler-ca.com>
References: <20230222200838.8149-1-casey@schaufler-ca.com>
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

Add lsm_name_to_attr(), which translates a text string to a
LSM_ATTR value if one is available.

Add lsm_fill_user_ctx(), which fills a struct lsm_ctx, including
the trailing attribute value.

Both are used in module specific components of LSM system calls.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/security.h | 13 +++++++++++++
 security/security.c      | 31 +++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+)

diff --git a/include/linux/security.h b/include/linux/security.h
index 21971a635b6a..bf615981b147 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -264,6 +264,7 @@ int unregister_blocking_lsm_notifier(struct notifier_block *nb);
 /* prototypes */
 extern int security_init(void);
 extern int early_security_init(void);
+extern u64 lsm_name_to_attr(const char *name);
 
 /* Security operations */
 int security_binder_set_context_mgr(const struct cred *mgr);
@@ -493,6 +494,8 @@ int security_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen);
 int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen);
 int security_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen);
 int security_locked_down(enum lockdown_reason what);
+int lsm_fill_user_ctx(struct lsm_ctx __user *ctx, void *context,
+		      size_t context_size, u64 id, u64 flags);
 #else /* CONFIG_SECURITY */
 
 static inline int call_blocking_lsm_notifier(enum lsm_event event, void *data)
@@ -510,6 +513,11 @@ static inline  int unregister_blocking_lsm_notifier(struct notifier_block *nb)
 	return 0;
 }
 
+static inline u64 lsm_name_to_attr(const char *name)
+{
+	return 0;
+}
+
 static inline void security_free_mnt_opts(void **mnt_opts)
 {
 }
@@ -1422,6 +1430,11 @@ static inline int security_locked_down(enum lockdown_reason what)
 {
 	return 0;
 }
+static inline int lsm_fill_user_ctx(struct lsm_ctx __user *ctx, void *context,
+				    size_t context_size, u64 id, u64 flags)
+{
+	return 0;
+}
 #endif	/* CONFIG_SECURITY */
 
 #if defined(CONFIG_SECURITY) && defined(CONFIG_WATCH_QUEUE)
diff --git a/security/security.c b/security/security.c
index 6823a6cb32a9..48c883c8d340 100644
--- a/security/security.c
+++ b/security/security.c
@@ -753,6 +753,37 @@ static int lsm_superblock_alloc(struct super_block *sb)
 	return 0;
 }
 
+/**
+ * lsm_fill_user_ctx - Fill a user space lsm_ctx structure
+ * @ctx: an LSM context to be filled
+ * @context: the new context value
+ * @context_size: the size of the new context value
+ * @id: LSM id
+ * @flags: LSM defined flags
+ *
+ * Fill all of the fields in a user space lsm_ctx structure.
+ * Caller is assumed to have verified that @ctx has enough space
+ * for @context.
+ * Returns 0 on success, -EFAULT on a copyout error.
+ */
+int lsm_fill_user_ctx(struct lsm_ctx __user *ctx, void *context,
+		      size_t context_size, u64 id, u64 flags)
+{
+	struct lsm_ctx local;
+	void __user *vc = ctx;
+
+	local.id = id;
+	local.flags = flags;
+	local.ctx_len = context_size;
+	local.len = context_size + sizeof(local);
+	vc += sizeof(local);
+	if (copy_to_user(ctx, &local, sizeof(local)))
+		return -EFAULT;
+	if (context_size > 0 && copy_to_user(vc, context, context_size))
+		return -EFAULT;
+	return 0;
+}
+
 /*
  * The default value of the LSM hook is defined in linux/lsm_hook_defs.h and
  * can be accessed with:
-- 
2.39.0

