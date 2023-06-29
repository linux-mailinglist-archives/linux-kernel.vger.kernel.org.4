Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C9EB742E0A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 22:01:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232377AbjF2T7J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 15:59:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232201AbjF2T7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 15:59:01 -0400
Received: from sonic309-27.consmr.mail.ne1.yahoo.com (sonic309-27.consmr.mail.ne1.yahoo.com [66.163.184.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 293DD2D5B
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 12:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1688068739; bh=VDC7nSb24+TiQjjwtfbSyQDZ6atY+2bn2kkmV6iO130=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=X6utnhH2CbigCO/704tZ8do7uKV7H7fEsx73z+2iwiXzeDWsMDi6m5k25n76XuBhRKlG50MTYUUVT/xpabMR6/MVbCMQW/pb89CGrpAv+SRUApmCDt7hybtevj16qgJZMQDkn1vMFe83wHgvpxK0qZx8iiQjd/k/XoxSwzHGmCzcbuH0jOuQCL41+6PGuhniVAgwrHJ/YEn6htOm19l6UfoEDytRDQjD8Oof5t8/sBvM4oPg04+uJX26CD8CZmDUuIZ1x2MotzgQYHLgyopvwOVtYO1a9sKRRoYDN8V/F+HaMd7f6DUoaiNUPmyfGyYfSnP0eHhOdYBgeKl4V3pWFA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1688068739; bh=1DFK0hdy92/LnwyeY33pVbqXS24sXmzmoyFQ3Hl8eJF=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=IK1+wbfEXQ5n6/xIz0KHo8u1A4lGVMemlMepIgFg6/znIQYFjnrjEzmrbe9tczqzGqKVfyiBAELjY94nXjK/p6kp/83fgAlAfA/QyJkyEOhrdE1LXDI2OQOqa8ToMhm47uTaZYFbl4PyZJzSqt9CnzMYu9qZcfdF+SUeGbWUo1n3Ghoo8gT6BhCjsOcernXRTbKkMJlToaATOxOYyYja1hVxo6M/pEVNZLJ1SNpm8WJhNluomoDtEISHM+9AzJ+TgWHp//x2h2oq923jDNTeMTYlIkGk4ttjPZjZC4wlCHPzTYGgSLEqlgFzwgOfwI3cawWCOJdcxbZdQPv99QB5uA==
X-YMail-OSG: VCkSsXEVM1m3jPoY8hzMJ68cN_lvbI3F11sMDI3tVndrKr5xuwypN1peuaEL8Cp
 7XCK3HPrtqD6.GJXRo6k7H3jbD3QXmClNiPh3Kd2wIIN6M09EVZA1Ffo9_b7nNHLgTSU947H0Hbd
 0uoq147.KBreXPE9ew87ognWPGocO_MT98.rrYWytgxAVnN8xmQrafXyao1lxB2HGcdIl3hPuU8d
 W5L2X2xKyZaS0AW4otrrcZjxBGEat7WAl2Vcd.U02CDLNSyy27cXTAT_caKsCWMaYMJU82Ir46lS
 MJxO8KfzzQ6kuvoyu3YHFs6xajpV_IF.6Zu3aLkiWpG15o0_4J1Rmb6F2KxCnbHU3JYk4Ofof2hd
 Xeu4voUyrPFlYMU02bRCQTSPqyTOFYwf4Qr0fGKiV6bldXjmWvZzw6.6r_34K2JZZIJqatLi.WbA
 yl8XMEsA32iLHhbiPmfNHPQLHHH8oiwUh9nySid_65an1OjOjV.RHhu3jZwcd3GV4dZ53wc03Cgd
 wmrv3jassDzg6HX4nh_rkZMrPzTrDPOgblEZL7LtIlu7todMVyh3BaPD2kYNE8In.uLxnUG33equ
 .D9cUTTnMuxQ0e84OL4OgPTgEmfwzvSnSA3j8ae4E1rTZnT4W7Fp_fbvDC0GR6fE44M0qoCO4ml3
 KA_M6EDBQLmNs9Ng3SvFZaAb3uZkUApl2EXoDBhzHlwQU3iQc7_JZt_7ES97B4wfbi7X2pLHvqY.
 YD4gyzojqx17DWvmR22.PRz9C_lxvXIl9YvxXNPwaKBCt8CRpjWZR_wUCw99zqLlxE1rhLQm26xk
 f4B4o.ga8erfJV62smbl7EFtTJctyR4pKaHN0kAXEMhsIp.nDkPcDXFEUJtGuoKOCEaGoYWbQvvT
 OzSIPGDOF.39NmLAJ2tPkenNTz6XB_zgmDPc_edbUIW5p1xK1mtVTPcA4K7k6u5v6ZwPDFKhrd0u
 4KMg7yArGrJz45WAsvQ0lXTVtY_rZzlYKsA3akVfP42Gzwc32BF_5R0E1ZZ7grMUDk_u0VidXmFi
 iZOhg7rqZG.sHic6WxsPQaN6kGPabG0lb05lei_8Uw9ytpjJMNaMmVqWcdzmBtv0Af1tCETfUIvd
 OuAJXS5zwNtIWZfuSVpkt9cELpc2Y14LXmkasHMIRyEcKT.VLGg6fr5BfQHyWFwH6a_6bzaY9hcj
 zFeooLXZDtH0UWuVLHS0tJevTYv4I9Jg8zMPTIw27Uwdwjdi4OsC1s7OPN89UicyN18Yzpju2SJO
 iRLW1dpQ6SphxFg.BGloYU7zfQQSBTf_5esgKLn36DWgVrbdGuuEjHmcxQY_Ojc2BxYTF8b9QJaC
 6I3g4aFwrP2SFIUmuW7a9zzkeXeybv2J7ggFJilPHxMvJprbzVS5Zoup3t6C0etvxXrQQXqi6tSZ
 YzwaO2HqKA1bAFfFTx6O5iCIeWk7.CuxLDin0ZtH8GNiw1PA1FgNRqZcCse6Gima1fSGxB.OPIEx
 dlAFOh8Lp_2sE_R_5iu4hOIXkgBbd9VLM670BIyiogdSRo4hx8AE6Dsn5UFA6FKryDALkLcC.lMR
 dwo6yFOshdTkiW2R0p7sXAww5A7V75k7Rr84tBRjfV5ecVPXBQV4FM0vi3LBPEGzQDEamMQ7mVbv
 PAWw3Dc9EQmw7f9kIm69rIUkxT00XVRNPhUqZ5fTTwHMhVqZ1DFw8jTX4evfXhSGI.3pluB28RHl
 XXLQpBHNSp74LYLRZ8DjwLr1fBSPaiXisnrRiG30uTqVkt9aALvv3qo7.ofi34E8pV6TGmCGl13A
 sGMyQTGsd3VpdrLTxWXatjWpr4qI5J_D70RTG7aI69f8B6PL2ndOpw.saR4sV1M6m0L7_iTUZSjI
 NGSBYrVcMfEtLWF3Xg3LFt7IZm5bptrWq2WfS2OM5x8DTu5c8y6l7Ui_mG.nAX7CkbPns8mqfGS3
 6786LjQCo8sC6PuRKPV.kRgCRycX8ToxjbIFCGCI_AcXyMu.L3gAsVkfpWDJ6I7yMkT4exOHSA1v
 6cJOy.fVcJB.45XxddlCNEM_baLC0c81w.3DL4vrW3jb7OeRDg4hi3jiWU.SRXcWK7iCARQsj5TJ
 Jg_KsrLglld7qEgajyZilEhNe8N0WRvjtOvgI7x9OrG6BljPba1Whd20FIL10CFt6aj5xv3FWJaV
 A2ZwkZ9zl.5T.Ld.e0coZ5iewHhn4o52IGlJ4R4ZgHGFTZjwBRPIxRY1HzoRWuz1qoht8QLziWbW
 XMBrO36oGMtkr5B1.BJr2_Wm9v_oGfc4Qlem5rDYQfEb4ggM7BCuL1nbbbgJqcwzVOOvV1iVP6PQ
 AqvbanouOvacBWKmVwws-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: a913fd76-249a-4faa-b59d-caf7740e2ff0
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Thu, 29 Jun 2023 19:58:59 +0000
Received: by hermes--production-bf1-5d96b4b9f-dbx7v (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 179208bf33e8d1ee67f1c353255c48d0;
          Thu, 29 Jun 2023 19:58:54 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey@schaufler-ca.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net
Subject: [PATCH v12 07/11] LSM: Helpers for attribute names and filling lsm_ctx
Date:   Thu, 29 Jun 2023 12:55:31 -0700
Message-Id: <20230629195535.2590-8-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230629195535.2590-1-casey@schaufler-ca.com>
References: <20230629195535.2590-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add lsm_name_to_attr(), which translates a text string to a
LSM_ATTR value if one is available.

Add lsm_fill_user_ctx(), which fills a struct lsm_ctx, including
the trailing attribute value.

All are used in module specific components of LSM system calls.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Reviewed-by: Serge Hallyn <serge@hallyn.com>
---
 include/linux/security.h | 14 +++++++++++++
 security/lsm_syscalls.c  | 24 ++++++++++++++++++++++
 security/security.c      | 44 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 82 insertions(+)

diff --git a/include/linux/security.h b/include/linux/security.h
index 475d0abfebda..75ac91223c2d 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -32,6 +32,7 @@
 #include <linux/string.h>
 #include <linux/mm.h>
 #include <linux/sockptr.h>
+#include <uapi/linux/lsm.h>
 
 struct linux_binprm;
 struct cred;
@@ -263,6 +264,7 @@ int unregister_blocking_lsm_notifier(struct notifier_block *nb);
 /* prototypes */
 extern int security_init(void);
 extern int early_security_init(void);
+extern u64 lsm_name_to_attr(const char *name);
 
 /* Security operations */
 int security_binder_set_context_mgr(const struct cred *mgr);
@@ -488,6 +490,8 @@ int security_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen);
 int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen);
 int security_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen);
 int security_locked_down(enum lockdown_reason what);
+int lsm_fill_user_ctx(struct lsm_ctx __user *ctx, void *context,
+		      size_t context_size, u64 id, u64 flags);
 #else /* CONFIG_SECURITY */
 
 static inline int call_blocking_lsm_notifier(enum lsm_event event, void *data)
@@ -505,6 +509,11 @@ static inline  int unregister_blocking_lsm_notifier(struct notifier_block *nb)
 	return 0;
 }
 
+static inline u64 lsm_name_to_attr(const char *name)
+{
+	return LSM_ATTR_UNDEF;
+}
+
 static inline void security_free_mnt_opts(void **mnt_opts)
 {
 }
@@ -1408,6 +1417,11 @@ static inline int security_locked_down(enum lockdown_reason what)
 {
 	return 0;
 }
+static inline int lsm_fill_user_ctx(struct lsm_ctx __user *ctx, void *context,
+				    size_t context_size, u64 id, u64 flags)
+{
+	return -EOPNOTSUPP;
+}
 #endif	/* CONFIG_SECURITY */
 
 #if defined(CONFIG_SECURITY) && defined(CONFIG_WATCH_QUEUE)
diff --git a/security/lsm_syscalls.c b/security/lsm_syscalls.c
index f03f2d17ab49..bc22f05e2d8c 100644
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
+	return LSM_ATTR_UNDEF;
+}
+
 /**
  * sys_lsm_set_self_attr - Set current task's security module attribute
  * @attr: which attribute to set
diff --git a/security/security.c b/security/security.c
index 199db23581f1..72ad7197b2c9 100644
--- a/security/security.c
+++ b/security/security.c
@@ -770,6 +770,50 @@ static int lsm_superblock_alloc(struct super_block *sb)
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
+ * The total length is padded to a multiple of 64 bits to
+ * accomodate possible alignment issues.
+ *
+ * Returns 0 on success, -EFAULT on a copyout error, -ENOMEM
+ * if memory can't be allocated.
+ */
+int lsm_fill_user_ctx(struct lsm_ctx __user *ctx, void *context,
+		      size_t context_size, u64 id, u64 flags)
+{
+	struct lsm_ctx *lctx;
+	size_t locallen = struct_size(lctx, ctx, context_size);
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
+	memcpy(lctx->ctx, context, context_size);
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
2.40.1

