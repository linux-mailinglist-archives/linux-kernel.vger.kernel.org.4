Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6E126EB10D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 19:47:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232934AbjDURqy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 13:46:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233329AbjDURqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 13:46:50 -0400
Received: from sonic310-30.consmr.mail.ne1.yahoo.com (sonic310-30.consmr.mail.ne1.yahoo.com [66.163.186.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF69E5BA5
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 10:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1682099186; bh=H0UZJJs0RhJqWRRr8yj43CS9JmZV6EBd4q2EA7t9ugQ=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=KnVgwLAiBEZ4PuIhHLkDN+vRc4pyZ4YqWwhyivC9KBqCCSvMY6g9XFspKcxMpOnFLsDe8u3uIL2oK8PuuYVHqq83xIAagLCQu56YKnwCGMIEsjqdIR/Yo1Z8N0W6qhEdZ3Th8/tzL4DIHHGbUy8hN+W7kbpFIDPF9sNddMr01rdbtvW5LODkoYE0E22ViYoT+grxYE6/Wny8y5yoV1apoXF4yZ0Pk/mfBI+WemY1vMcG7Ye4zGFwAe3HMnIEnhY6twSi/WmikFqfZMGrnNiL5w0Q/C8YoiXefORACRbysNyO5Y3ld0JHrzYuyY9aOcWLjPdZqjXQ0yrTPT51ut4RjQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1682099186; bh=YJ+o0cHI6vKUVtCzRaXKWcTlHCvCvBHs+GV0MIFEl2H=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=TfORwZEsUcNcJFeeJIHSLGXsBEFcVHtDBwHBO/ywkJ6KkEwv+jS5sK38kQPFT9j2mpzsy8QbjRX+4QlD57QeTN3lF0pwr8a+ct21NKt327ZvvrXVdk45teXf2ZcERMySRk/AQJizJVY0A3zMCTpl57rI4UvpbH6JRAO3I/wgCswuqrlZxM3x9/ZH4RAFWjG1P0AmNdyuDOsCuRizItBgYemJvAJo6ia98t7f+rn7wRIs0dZQuPfcc43WP0THgK7LqKBCG+iCnWXl3o51V5HprG7uiGAVggaVJ1buYIrhZtGGTLfBAx5R7Wq3jWSYXlMjLxro74Ero0/n5F2jJDMyag==
X-YMail-OSG: GowP0d0VM1nBFxpUp03PHC415_6Lr9vYqZof1.UA7_f42hlkl.uRwfRQuBD6XrQ
 qYDWxjW8xQCywedqsDMNUaSqiRFa7q0oa._fGnsHtxa2s1YmrPmLBzm6dfVlDfBUfy0gpPeFh3kw
 WdDmr51Caq4NPSYkC64w29uVyd2DkbVztRmwH06_ppYQfJdPTETOeDqUk2c8Gt6FTXJpfoey0neJ
 1ut9TVCCiq2MO6hHr_YffF4o39k60uZI12pDhLzsKBtIkxM.6PhOLBHFIGg.Vg7_peqskA8n5aFk
 E_jV7UrRZ7KWVlNn2jHlFKuHE3jSkIqQsmvc8WAxsGHP04zxUoR0fOM2WQpC5L.tf_UMl8O5s7Yl
 JSjSFge_EpQTMPDFuNPr3PqlaaPlOaj36YEozHehkVH5f6ezQjO6j1wMAzOo0uVcXLGxA9QYu45f
 OKk54LhxsEeA9uKYL.gEG2HvxAZ0Poi_UmXP2Ba5Hl88mneyTdCHr1XExMs_sDWAWkpfiQBF1j0f
 NLvP9b2O8ox_PlGDso0qxN3iiTtyP2GYouIjLync73NJNS5zoeHyLvWVPe_JeBI6SV6mscQ123OP
 iIUJ1Yl6.l8hUOVmIkLGY.mlUHsRi48hq_6meFmPh8ifLzcKtzO.Xp.Da0OmUYokgJAig7fka1XC
 Vsa_L0I_myfZCmJb5g7FxSC3FCFXIkLGSktSYk3hG8Dhc_KFtCMC8b.VF3FCGoCT_mzq8xgE8QBJ
 f_USqL_OqlP1VN.vfgQKCxssoAFhSmaXVKSkxL1NYkn2hKNENm2Oj7Gc6E7SXEiLB5Xl5G89ZmVd
 bAgc5GS_DqJOBn7CsKYWBu0hEQFz3XzLsD9XXTBbW9S0Z43J80AVANuS7TKlGxrJUa9DarzODCrz
 5EQlHfu095BV4.pr4xUbiJykmGCk3J0Ao7gJ_zn1mx2IBsLvkmxp9sb11XuxxD.m1ye6FB4pb397
 RvXtDcTJEPWgDQ5tVl4wTPivhrWorIMuTyQQHICfA8yjPYzZWoatpHJK.oLO.OLiNj57uFiSNCaQ
 VAM6SLrxPa3rqOlq5f9doMQUycdod3HRlJgkOlwgvaU_k_JDQsPF9YD0JIxDzkNQLhTd7O6Wn_Nq
 d0DM77fEgoXzs04rCLtibZu6un_fQ4L2JmxBrtBBTDZg_Cztu2AcoZ.vBgqdz9FZQOrkveaysNJy
 srGzW6Z5nJYA1ALKT_rHkz5w1ysQS9oSuzjBHmL51b2JU3.aKBphTXIQJWlZ5u8WQLVGsMn00swf
 Tsvos2BeUubrE4esyPX4S0kt.wqedY0G3MUPd77BRNvKkfFlhxB311Jjq8ZvILbFr2E_D._LzpFA
 BikDFytEnaMTOXmBG17mTz.oOWxlW0Y_5FFk5pTfPlTp3UVyD8889p09obxU559hmBuvZKBMuQp0
 yVLSK4CXGT8l7F6H.8o5ixLOR4LpFJieiS9._dpHM1iqDqfYTo_XoD0nu_TCEVtYl5Cm8VvTfl_s
 SZhIxHF0KR.sDp4gswC7anNykr7flh5OO_JCjRNDUyiYyrO_uzhsl5kpzMEkdu31rhWdVh6bIbxl
 CqNTkx5uP4FzxbLMrZ5.Rh.FRrWhuwoClDgs0JkfitlMWc0I0lm7eJ_H1ugYHyO7hekF8.lm5sy6
 msHpB0X1MzR2NpPesl.6ra4HXL2fJArRpHcEkPanwazT6JtE_PFzBAXUHXadEbM.8PJVk5pNm4NT
 x6k5f6joHM7ssfJXwYi4QJ_26r6Eab3soJBKI4ZtuLcskZ0uzYScVt0sodXgwQ3E0KWvWVkSzGWv
 05KNHE2x6si5g6wzzR5cq8dwtsRZllZ7lAKF3Pk8hE2QMI_Ds_w_OrisPRvBowQOJCO9gmNbcYnz
 WaINsmOMJ0NeJuzCCMnOS8FHDP_S_bb8KFTitIW9ecj9nm7hw8x7UJNSNG7T_nQytPRebR7W6Aau
 UnyZbLaDtHZtcD.YfbWvdYaTqRgWcqNSJM5fJnVyeWKCGPdN.LVjgb8c758rX2O.Cg33COMqqEWz
 Wq.7p9kaJUeiX3ul2wLXWYt_nE4vQcXi2dHPUqdtyVosPFdRPoblRtymMTlve4_RXUtzofqGgxQb
 H0SEC1EQfuqhhQn6vVTjB.k8TP66.4F.f4SOy3jof3xaLuTfezyyJM8pUGl_XcC0BPzBX8JT13xE
 7Lx08IP.9Ox19eBSk5b5I5IMxdNttrQayaVBAPwaYv6w7NdJIBVL0992bHYvgZXImlipTMxTeWPq
 l53Jr.gfmEKDQ8b7BDXX7wTvyozKcJublO_vl6vr6KTx7ONHnYBCBfAgZaSZuoKiE0Iq2X_M6dmm
 9qjH.J5Z078ab4vNy1bg-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: b956c6e2-f3ef-40fc-8a19-60948a735995
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ne1.yahoo.com with HTTP; Fri, 21 Apr 2023 17:46:26 +0000
Received: by hermes--production-gq1-546798879c-l2qgj (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID b7487fe0c5844b066c0cbb2b5e828d88;
          Fri, 21 Apr 2023 17:46:23 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey@schaufler-ca.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     jmorris@namei.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net
Subject: [PATCH v9 07/11] LSM: Helpers for attribute names and filling an lsm_ctx
Date:   Fri, 21 Apr 2023 10:42:55 -0700
Message-Id: <20230421174259.2458-8-casey@schaufler-ca.com>
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

Add lsm_name_to_attr(), which translates a text string to a
LSM_ATTR value if one is available.

Add lsm_fill_user_ctx(), which fills a struct lsm_ctx, including
the trailing attribute value. The .len value is padded to a multiple
of 64 bits

All are used in module specific components of LSM system calls.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/security.h | 13 ++++++++++++
 security/lsm_syscalls.c  | 24 ++++++++++++++++++++++
 security/security.c      | 43 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 80 insertions(+)

diff --git a/include/linux/security.h b/include/linux/security.h
index f7292890b6a2..c96fb56159e3 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -263,6 +263,7 @@ int unregister_blocking_lsm_notifier(struct notifier_block *nb);
 /* prototypes */
 extern int security_init(void);
 extern int early_security_init(void);
+extern u64 lsm_name_to_attr(const char *name);
 
 /* Security operations */
 int security_binder_set_context_mgr(const struct cred *mgr);
@@ -491,6 +492,8 @@ int security_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen);
 int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen);
 int security_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen);
 int security_locked_down(enum lockdown_reason what);
+int lsm_fill_user_ctx(struct lsm_ctx __user *ctx, void *context,
+		      size_t context_size, u64 id, u64 flags);
 #else /* CONFIG_SECURITY */
 
 static inline int call_blocking_lsm_notifier(enum lsm_event event, void *data)
@@ -508,6 +511,11 @@ static inline  int unregister_blocking_lsm_notifier(struct notifier_block *nb)
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
@@ -1420,6 +1428,11 @@ static inline int security_locked_down(enum lockdown_reason what)
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
diff --git a/security/lsm_syscalls.c b/security/lsm_syscalls.c
index 6efbe244d304..67106f642422 100644
--- a/security/lsm_syscalls.c
+++ b/security/lsm_syscalls.c
@@ -17,6 +17,30 @@
 #include <linux/lsm_hooks.h>
 #include <uapi/linux/lsm.h>
 
+/**
+ * lsm_name_to_attr - map an LSM attribute name to its ID
+ * @name: name of the attribute
+ *
+ * Returns the LSM attribute value associated with @name, or 0 if
+ * there is no mapping.
+ */
+u64 lsm_name_to_attr(const char *name)
+{
+	if (!strcmp(name, "current"))
+		return LSM_ATTR_CURRENT;
+	if (!strcmp(name, "exec"))
+		return LSM_ATTR_EXEC;
+	if (!strcmp(name, "fscreate"))
+		return LSM_ATTR_FSCREATE;
+	if (!strcmp(name, "keycreate"))
+		return LSM_ATTR_KEYCREATE;
+	if (!strcmp(name, "prev"))
+		return LSM_ATTR_PREV;
+	if (!strcmp(name, "sockcreate"))
+		return LSM_ATTR_SOCKCREATE;
+	return 0;
+}
+
 /**
  * sys_lsm_set_self_attr - Set current task's security module attribute
  * @attr: which attribute to set
diff --git a/security/security.c b/security/security.c
index bc3f166b4bff..759f3d977d2e 100644
--- a/security/security.c
+++ b/security/security.c
@@ -752,6 +752,49 @@ static int lsm_superblock_alloc(struct super_block *sb)
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
+ *
+ * The total length is padded to a multiple of 64 bits.
+ *
+ * Returns 0 on success, -EFAULT on a copyout error, -ENOMEM
+ * if memory can't be allocated.
+ */
+int lsm_fill_user_ctx(struct lsm_ctx __user *ctx, void *context,
+		      size_t context_size, u64 id, u64 flags)
+{
+	struct lsm_ctx *lctx;
+	size_t locallen = ALIGN(context_size + sizeof(*lctx), 8);
+	int rc = 0;
+
+	lctx = kzalloc(locallen, GFP_KERNEL);
+	if (lctx == NULL)
+		return -ENOMEM;
+
+	lctx->id = id;
+	lctx->flags = flags;
+	lctx->ctx_len = context_size;
+	lctx->len = locallen;
+
+	memcpy(&lctx[1], context, context_size);
+
+	if (copy_to_user(ctx, lctx, locallen))
+		rc = -EFAULT;
+
+	kfree(lctx);
+
+	return rc;
+}
+
 /*
  * The default value of the LSM hook is defined in linux/lsm_hook_defs.h and
  * can be accessed with:
-- 
2.39.2

