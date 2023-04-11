Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A41F6DE063
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 18:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbjDKQDN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 12:03:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbjDKQCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 12:02:54 -0400
Received: from sonic311-30.consmr.mail.ne1.yahoo.com (sonic311-30.consmr.mail.ne1.yahoo.com [66.163.188.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C427B5BA9
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 09:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1681228969; bh=DzhA7/LUTIBJEs4B2XsOB0fLmfe0l7h4ZsRz2ZAhV5Q=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=SfP5GCfwZYi9AMjrqfna4YtY+41+VRRyX1rSrt5Xq8PdlZNfTZabp6tEBDqpnWGdiPvxvq1LkGoQ/bJI8NqNzRJ6x3lGIrFEqW3WaWA4otesYIWKkz+wL8dGL++NG1u1uErrEbWDEmijAKs12VFhlBKIJIfP668R0r7oUiis9yYF+DzsZQ5nfuXYAKLwGbBX6meEHa4hfD9Aon6MGqRoq+80X63KtJ7Ok/RxYsuHdZ3bk/VkhIkeNB6BSKmZZnB3G376lJyHnYRrioD2UtWvsJdTsFIGK9pHSGCM66GMURN4pSLMk514+xOJUgH7j8hfjpYOpAwjRuBIXD1WZkMdhQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1681228969; bh=AcRKlhpQZh0gmQK+a2fNEbbz8BL4JHI7u4Owxp9tZ2v=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=J0fc1mC1Z7AclRy2Fwdg5bAX9mS54PmbJI41NDWQjiQRZoIg6oZU6S3FAJia5z/PvnVXpFAbRoq5VWtH3WuQAzWMq0PK/S75DXwcaRPAVcIjDZtN2K/MXUfSl+NReJY/Sb6OmC9p6zdCiv43WABRr5givuvvZGoZt3RcxozO69g695kx08YnJ03nSbBbHMzsy80xfyynhRs7C+OiJ5F0fv2jv28w3bJjoQYejQehxm37Zbd4e6SbVIOOg4OPo/JPaUxeX9pUkdBnf8seGwEJi+Zb4jTInTHWi6lpVqA+lehYKRwVoXRdkB5L4MHJ0/Ai1t1E+vniJaSjO+kesURT7w==
X-YMail-OSG: HIGiL5oVM1mQgWU7ENlymT.LAIh_2slGH4QqwYIK8EK_I9j25dGgmGAc67xF6pC
 2xwImZc0qacliySaA.UeJEcgPxwGj_llfh8ckozX1QPGDno2CPd721YR_OwpfifU9fwavnZ1WXvQ
 BRlpMwaiSg5N49wGg15PfgKFEUOpLKcSqkJPz7VCcpUHiPbO53oboCxqsBAjguhPVKppW.vgW1jn
 UkBOT2eYEzaQV_F5Qpx0c.wJGFPDuq9qlFQHt1yFEmffz_TX0G.Ce_jACk1HHCykh1s8Wd8oHEfS
 57fowSf_.i2.jjO5AC7SAUoL.Te7vIrWmLevo7PP0jdD86afhNyoXaV_LTYUeShmfnXJkWDSboqu
 2uwI.UWtLC8EYBdNeRTmKmX8cyYif8zei9HP3bGlnKayjkpHPaosCfxmA3If60gM3HNmlgqYssz5
 XIF2HKYqYq9ux.9UZJpFVIA0So4KmK4DkX0qZHNPoiditWWWXuwTGAOmru6erfGDcrCCr1m0zB3h
 L_e3dxfAwBnTJX0JxJxDK6bS.iXzGBlB2.CqfrboY7agAK5F0DzsyynqyhlZn1HEXVMT_2wzoeoy
 YbNpqLtf6NzdIN3BD8zIPZTmTRZpy0FABev0jTXiuoOUuuhJgCET2WHqko9aH4Q8dryfPhf2M56i
 ABaHwMI9RSj1kn2t..Oawnf.2MuoWrUFaZPBYV3LnFcvyXCN11wP.nnQa4rLZTYlVcVWgU6UtBhv
 g5_gsN5WzvjunqXXwW_VFw0VlqNkdSExkmuETtBKwS4WikpC_dqYDAip.codZk3n9t1B5UejiC0q
 mr8JGPbtDOPWqXo6cIioL6UVTvgRbPk1lW6.1S80ZfCUWzxEi4xmk4jCKwZCPtwZ2CAi8b9h3Vts
 jm8QQ5JW9rJrvNzZBntzG9SwSF9_47k9w_lovV5WFpmcS48cB7anh7ztnu7AwoOew7.s1aegxxH7
 rB_kWNaBdN5CcC7fYs869DxKd7XwMsepc_pZjfnQywc7i2f5clFNGrSdaHlkNOoR3v0jAbx9dKFP
 2M_YCceQJLl5OpEY_jP2g.jTl9mYRT.YVNbrvgMzKH50SwnGyrusaaGt.vyxYYkoa0rJmbvNuBkx
 Z9GSbvgt.rw7rI0om1gqwI.LjcJyUIKuG9HX57Hh0h_XdmnNZLxCyNxMpYwD_1ZqQIZYRrFprFVI
 h6KNHWkShBoAa1VTt74v_QY1gWO9yLLXBVAaM0vHvwtzzbB5g14i2Yh_9rWeeBod9nCWuu9tt.Uw
 YoNmnkw7pQYf_xv8YHc1T4KdUMGSNNoAZ2m9CVNP6dhIPa03LF0ORDBTcSsmHLbK41Lf7xO.D8HO
 ysSr.5E9e1O357M0LrwrovwLJtpaIka0E7HXgcUGENCoRBPAY4I5N0tvPxNeV77WvKTkGdTFhfLq
 zyKXekPSTecb0C0De79v2it7mUWVzbK1txyEoFnuTcy5lvZABgAzSGAlK4OhDxc8Ixg8q8pZdDr_
 8DcEannpGgKzYeSWfYAvwaxsZenIqtQAmSpDFFcjY_N_1GG3cioDO6wOQ4oB3asYub9J2dJ6TYmu
 jc07q54xpVTOs1QagKs6NsI8n5Nta0e_OKcjoGl9xYnA5feQOITQ1xZLqgRr2ZfP009TgDnxamn6
 XLdFuJIajh73uy0EFsmpCIrQrzUQuYLWtR29zR_8k5Td.gusAWrJ5TRTibO2yGnKLRzPQcqW3_lV
 3.vTSvlCG8bbCIRuaoH3Ra6anVcU4RfuDpIoPOCdEHpOON22TXaVp9K1fVA0xEpoB9Ybj6TsB5mo
 txJeqV7uVTeht.5fjrAqaawNQBBh1u.8VFiKH.dgZMhR0.kCT2jT9KpTaqb_khk_B3k_E31Dd0gS
 bGBz3DDEH_hfr1X8.D2dVebJSsBshKym7D32h9.Q.KYXz18hA1p9CoJLbBFhA61o2neQTeuyB1f.
 Bj8oWfhOvG63Pxyf6t.Ggw5dO8MH2RtzM2EXbuVQF1b6pf6Llj.iUWgfsKk02ghN0XRzRHHivCZC
 PhwDRdDMjZyxv0_Q4xpbKK7ispUo9uJGqk0zs.BhnUJjbzSU4ukdu7qJJOFZE3amMBPdA.0VNJfe
 9_YMhvD8nZ2MQpyNwld5RmccPHBEQdjkZAiE6c2939fARFFiytyCfKISRnBE00RIREml6z4QRp30
 nC7AWvHSubwSSPE07fcHbYZUbOF0PXa4dp5Nidvu_Da7nemSqMsK84CfWxXABWr8438zNR9Xd2wM
 Q98vmY0HZtKVUxTc9RfitWBlMzQbQ8pq0fGFaas6wCQOfjTgLoyeV4qI_haMgforg0BvvLLMnr1z
 qOglq8Da6OozrYF5tasZm
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: c2c4dbb1-733a-490c-8408-9f9137a53af5
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Tue, 11 Apr 2023 16:02:49 +0000
Received: by hermes--production-gq1-546798879c-8jjxz (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID db610f21750abb164e44e985bdddbdbc;
          Tue, 11 Apr 2023 16:02:45 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey@schaufler-ca.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     jmorris@namei.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net
Subject: [PATCH v8 08/11] Smack: implement setselfattr and getselfattr hooks
Date:   Tue, 11 Apr 2023 08:59:18 -0700
Message-Id: <20230411155921.14716-9-casey@schaufler-ca.com>
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

Implement Smack support for security_[gs]etselfattr.
Refactor the setprocattr hook to avoid code duplication.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 security/smack/smack_lsm.c | 105 +++++++++++++++++++++++++++++++++++--
 1 file changed, 100 insertions(+), 5 deletions(-)

diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 3cf862fcbe08..0068bab21f64 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -3552,6 +3552,41 @@ static void smack_d_instantiate(struct dentry *opt_dentry, struct inode *inode)
 	return;
 }
 
+/**
+ * smack_getselfattr - Smack current process attribute
+ * @attr: which attribute to fetch
+ * @ctx: buffer to receive the result
+ * @size: available size in, actual size out
+ * @flags: unused
+ *
+ * Fill the passed user space @ctx with the details of the requested
+ * attribute.
+ *
+ * Returns 1, the number of attributes, on success, an error code otherwise.
+ */
+static int smack_getselfattr(unsigned int __user attr,
+			     struct lsm_ctx __user *ctx, size_t *size,
+			     u32 __user flags)
+{
+	struct smack_known *skp = smk_of_current();
+	int total;
+	int slen;
+	int rc = 1;
+
+	if (attr != LSM_ATTR_CURRENT)
+		return -EOPNOTSUPP;
+
+	slen = strlen(skp->smk_known) + 1;
+	total = slen + sizeof(*ctx);
+	if (total > *size)
+		rc = -E2BIG;
+	else
+		lsm_fill_user_ctx(ctx, skp->smk_known, slen, LSM_ID_SMACK, 0);
+
+	*size = total;
+	return rc;
+}
+
 /**
  * smack_getprocattr - Smack process attribute access
  * @p: the object task
@@ -3581,8 +3616,8 @@ static int smack_getprocattr(struct task_struct *p, const char *name, char **val
 }
 
 /**
- * smack_setprocattr - Smack process attribute setting
- * @name: the name of the attribute in /proc/.../attr
+ * do_setattr - Smack process attribute setting
+ * @attr: the ID of the attribute
  * @value: the value to set
  * @size: the size of the value
  *
@@ -3591,7 +3626,7 @@ static int smack_getprocattr(struct task_struct *p, const char *name, char **val
  *
  * Returns the length of the smack label or an error code
  */
-static int smack_setprocattr(const char *name, void *value, size_t size)
+static int do_setattr(u64 attr, void *value, size_t size)
 {
 	struct task_smack *tsp = smack_cred(current_cred());
 	struct cred *new;
@@ -3605,8 +3640,8 @@ static int smack_setprocattr(const char *name, void *value, size_t size)
 	if (value == NULL || size == 0 || size >= SMK_LONGLABEL)
 		return -EINVAL;
 
-	if (strcmp(name, "current") != 0)
-		return -EINVAL;
+	if (attr != LSM_ATTR_CURRENT)
+		return -EOPNOTSUPP;
 
 	skp = smk_import_entry(value, size);
 	if (IS_ERR(skp))
@@ -3645,6 +3680,64 @@ static int smack_setprocattr(const char *name, void *value, size_t size)
 	return size;
 }
 
+/**
+ * smack_setselfattr - Set a Smack process attribute
+ * @attr: which attribute to set
+ * @ctx: buffer containing the data
+ * @size: size of @ctx
+ * @flags: unused
+ *
+ * Fill the passed user space @ctx with the details of the requested
+ * attribute.
+ *
+ * Returns 0 on success, an error code otherwise.
+ */
+static int smack_setselfattr(unsigned int __user attr,
+			     struct lsm_ctx __user *ctx, size_t __user size,
+			     u32 __user flags)
+{
+	struct lsm_ctx *lctx;
+	void *context;
+	int rc;
+
+	context = kmalloc(size, GFP_KERNEL);
+	if (context == NULL)
+		return -ENOMEM;
+
+	lctx = (struct lsm_ctx *)context;
+	if (copy_from_user(context, ctx, size))
+		rc = -EFAULT;
+	else if (lctx->ctx_len > size)
+		rc = -EINVAL;
+	else
+		rc = do_setattr(attr, lctx + 1, lctx->ctx_len);
+
+	kfree(context);
+	if (rc > 0)
+		return 0;
+	return rc;
+}
+
+/**
+ * smack_setprocattr - Smack process attribute setting
+ * @name: the name of the attribute in /proc/.../attr
+ * @value: the value to set
+ * @size: the size of the value
+ *
+ * Sets the Smack value of the task. Only setting self
+ * is permitted and only with privilege
+ *
+ * Returns the length of the smack label or an error code
+ */
+static int smack_setprocattr(const char *name, void *value, size_t size)
+{
+	int attr = lsm_name_to_attr(name);
+
+	if (attr)
+		return do_setattr(attr, value, size);
+	return -EINVAL;
+}
+
 /**
  * smack_unix_stream_connect - Smack access on UDS
  * @sock: one sock
@@ -4955,6 +5048,8 @@ static struct security_hook_list smack_hooks[] __lsm_ro_after_init = {
 
 	LSM_HOOK_INIT(d_instantiate, smack_d_instantiate),
 
+	LSM_HOOK_INIT(getselfattr, smack_getselfattr),
+	LSM_HOOK_INIT(setselfattr, smack_setselfattr),
 	LSM_HOOK_INIT(getprocattr, smack_getprocattr),
 	LSM_HOOK_INIT(setprocattr, smack_setprocattr),
 
-- 
2.39.2

