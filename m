Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFAEA6F1F90
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 22:38:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346694AbjD1UiG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 16:38:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346543AbjD1Uhy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 16:37:54 -0400
Received: from sonic307-15.consmr.mail.ne1.yahoo.com (sonic307-15.consmr.mail.ne1.yahoo.com [66.163.190.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EC7E2D45
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 13:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1682714256; bh=lQV4qS4iAA6JHAaUPQfN8v1+i+4alOLehWL92wPtJI8=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=nh6ET2+Z3QWo0eKhqPUajv4qc1BlJjdmmndr8Wr9QByuLvxdomlYutGSjVLfUdB3IDPFVDcFyFoUUJWuoBobmOuFYutdHf/hTFajOI3ecbJhj11ulyt89hrN5TaUNjjsK9BLo9E8OS0UlvhZbIeVZ84ERGwQ1a4vUHzhckjxrG2lzNxGvgo/Xrlua//wTb1jXjCWCW/V2an4JSu7cEKk21nCkdi0HbKlHxkHyEP6LB4l04ML1kUmS7EDL4/0K9tiOPdbrQLpLy9UHtCbYbq4c9YRwKnn9+pFaodZMf9JtoxA4B7kvrj0/1vwCdhTHzhc2GSSaUocAsz46huMoPhigg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1682714256; bh=0bZGVNHEpelPbcy9q8/ySw86NZlcoU9ywmACJ4SdTo3=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=D+fuHVikdk4/nvabeRburQ59/O7Rz/Y5Q8/a8Rp0RZb0GM+Gn6yV8IsjJ5l+PyTRxl7LlQ7t7ekbM+kGk6MgOovJIrYTWbJWRmo4+DfcFPXM2sS/miTOmqZiI9hnKEqGv4bF5wsKgFvoOQNvy9cBdBHT/VsQXo8/ZM5dBeuIB5SkoLCFVVyIt7ODpC7Xfnhuj3gqrl/MAPXqwEmenuKIiaazlu5FUk6osIAYAvZ7fqdSXcQ3fc91dspjRZp/lFADv8Gxn5W8a+H4iiEF34iptziuW+CEM0SEeYCVMucnPzZohr1OhPIQkK7HZKntxM/d5afpkOaI1iG9CURS1prfyQ==
X-YMail-OSG: zNodHMAVM1lSS0jBZ_tvQ_3JATjgb6CStAJrEOrrRZdSVPrtz_H8cvx6WUQNtnH
 Dpd9XLvKY2Cg.WV22ptotbzCZZPDvt9DKjg9qxUqxGCm6mu4lk.zXX.4iLwUOsD5VENQxaKY28ar
 pyRL33M9i2GS9nJEqNfUulpWMIR68N2u2j1IFVjhlmjOvWCBtjdXJFtEFHOMVsbZJYBqWkf_Vvb0
 k2U.KQvoIabZNuzOeODhtMJbt7BjVIH5FTlxtmy6.2Hro.wxA_UxR6NexKdxHgPk_qRb4rVGB65S
 lMMr0NJ0i3UWQmf9nCITVs7zwBsCM06MCDrOMf.aCa6Au6bGf_0.kewDQZPh8IjW8YLX2SytARs1
 K3eMpY27Dh4XuuW_dptiYx0_hp5QL74e1lMSZhomOhukUTMu2Jp1WWFtKx6AcoiI4RI14NX4jR3O
 LeNdagAAr1IR0RA0AtFcviVg0T6mQAu_idZvMjmWHAQf3p5cuk1pK6gVWWoRP4hm.wPb87Jj73IP
 Wwm6UB_MtdfmSUqeeWZ5TWnUr8SowYb.aCtfzkfxOfc0EcVyBFV_I.pOtXTWh0KC26BwjGeosOr4
 x_2b34lBJry8_R2KQIvKAmRZAqDKdKkIXe0ZsDj.IK.eIyOqQmwxXrc47kqOnFFinwWN8aNpKq29
 QQXuxKgN_aq31pOes_mwL7nsUtRWwcudnETqYiiWvYKA78B3Ka1BDyEjq0WoWMhduMvJP8OiDUhc
 glSubL2BxiT0jkHo0E_ae6YaNkmApTWZ9nomWFAkl8kd5YKZN1SrLkgYZsOky0P0ADIvzTWnNHmF
 ilcrhsoZ4YdtbcmV56Ahxb7kLkY5.FtiOHEZ3nKKlNglSpqYiRRrpX7fPfVqY8otJGWbE_AENhi5
 yYP716VmNSeIEu1YARictitLQyOI79A2774COZzz.9OtxgQiFaOKps_nQl7ZiUyGx7AUAaiMM_AI
 LrqVOE3jjyyLCK8NMr8WyQjCcULUc1.tJ7lj1KM7ruzYFKciG7LqcIKHh3R8zY7pfQFW6mXw6P1L
 _M02bjth0cxojCXOVQDVOO.vkO8KeW_fzz9VKwFs5PY2I5O9wayQ05_eqqQgEhRyBKPnQDIEw3Od
 xvgeouQmkbCx7Efv9BLUCGWCppZBdGfhmsk10MgfwSMnOtbTs9Az_bU8gS1Nw22PKLysORRoppgh
 qGVyBjJJ5eMJob.lV1imxSmB1mNl6aPECDy4hNYs3_O45Jg0QjsdtyD4bEFWAfOxfSUp_o6SFmhO
 i4bMMp_o7483.LFsCcgQ8FYkGJ_LDzNcbzfX3faeVEe0DNq0zmDFo5jFlzTjBEJ0pl4_TCsNgmIG
 0YG5l9VnkW3dbG8BmEVrFmUiVsz4qhFSs5_4tUI_83kbmg_wFZhRWdIqieQVbfQ.n5FA1.b4rTye
 3_DpeczYIFn9TYabQx8liSCe8SOgRKR9lmOk6gjZef1oq_eEmDgO5h0_x_J5nBu57.O9HKw69BtL
 uwCoDXUwQIpsoFhKVsZ2QiOvkwFBUqTQfJ6r1lfrSLSrHgQw9e2zs9ZX_fJ6V6hs.MyersF59Amm
 2uEbtvZdee3wI_Xqh8ynGwZWdXHyvefc0nCeX4InbXgp5_cStSjJVnMxfp.7G9cHKUeaJiNnu96B
 M_w5gE0BI92Moa0rXylApo1aKgo7vcj08Z7esGZ6GRK7LwC6mpRW8eV2cFmNsekhtkx6FIPd6xc1
 2bHKeNyXSHQN7GD.i_YQhRdz_haUZPCPmNHiXt93LceUFfrv2Z0jVvaLZChK_Z8S3_lZsvpP3Czj
 BpADh8MuuMOpDK9h.hTN20yZqtRFX2u4GiebZZJpvAEwZ1Xwo381BLnC18sDBGjQ_iJFaokRfaEZ
 _LlfPctTB3.7R.eRx5Rfak57nWp9bNXgFB62hPLk5.3hdG7yftFTAHITI9KLJp5op5JFHmPpVfdP
 m0afKVc5LEDwcuBqEGIZDFRcoXhvLXmF4ihPzF5KuR3._KBvlrpg1bTtDBdaYQcgvxOVFC7IYvqC
 pG3JwvW0bOf6ZaA302Q1sPCx6Td8haUseI6mBHZY9KzBVdFc3GxjsW9uhBro5QxULk7gqGu0Of3g
 _ikX9OE5JQu8p7km.laSVUHDCiZkdZu7ADEH8CVUqvEpe0RBqnP_1y6AeqMZW66zWspSqkC8O6JM
 tgchAH1usTHpDzDk8nusLxQ3Vh5pwXqM.BpTccjJHrCtz1van8fV6x48w3v5akYu_7mYBQoVKOSS
 3w3Hmaxe3OHDSujS.JqBYCvV1GMHH_lsTRxFcYQ7yeGmNoQdKpjJTwoonQDC9XgXvJFoaJDP6MCp
 jD9AmMLwe8ROwNwzdI.rrNAukDL1low--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: d9e9296a-feab-4253-ad57-7ec3ba70b136
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.ne1.yahoo.com with HTTP; Fri, 28 Apr 2023 20:37:36 +0000
Received: by hermes--production-ne1-7dbd98dd99-vd22t (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 7d01bdce50daaea0f4f6c5183b4a656e;
          Fri, 28 Apr 2023 20:37:33 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey@schaufler-ca.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     jmorris@namei.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net
Subject: [PATCH v10 07/11] LSM: Helpers for attribute names and filling lsm_ctx
Date:   Fri, 28 Apr 2023 13:34:13 -0700
Message-Id: <20230428203417.159874-8-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230428203417.159874-1-casey@schaufler-ca.com>
References: <20230428203417.159874-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add lsm_name_to_attr(), which translates a text string to a
LSM_ATTR value if one is available.

Add lsm_fill_user_ctx(), which fills a struct lsm_ctx, including
the trailing attribute value. The .len value is padded to a multiple
of 64 bits for alignment.

All are used in module specific components of LSM system calls.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/security.h | 13 ++++++++++++
 security/lsm_syscalls.c  | 24 ++++++++++++++++++++++
 security/security.c      | 44 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 81 insertions(+)

diff --git a/include/linux/security.h b/include/linux/security.h
index 806bff425af9..36ace59f9171 100644
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
+	return LSM_ATTR_UNDEF;
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
+	return -EOPNOTSUPP;
+}
 #endif	/* CONFIG_SECURITY */
 
 #if defined(CONFIG_SECURITY) && defined(CONFIG_WATCH_QUEUE)
diff --git a/security/lsm_syscalls.c b/security/lsm_syscalls.c
index b89cccb2f123..0b225adfe5f7 100644
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
index 94b78bfd06b9..8c877d639cae 100644
--- a/security/security.c
+++ b/security/security.c
@@ -761,6 +761,50 @@ static int lsm_superblock_alloc(struct super_block *sb)
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
+	size_t locallen = ALIGN(struct_size(lctx, ctx, context_size), 8);
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
2.39.2

