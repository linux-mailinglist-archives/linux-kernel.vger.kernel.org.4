Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C8226EB10C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 19:47:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233438AbjDURq5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 13:46:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232766AbjDURqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 13:46:51 -0400
Received: from sonic305-27.consmr.mail.ne1.yahoo.com (sonic305-27.consmr.mail.ne1.yahoo.com [66.163.185.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B485E2710
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 10:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1682099189; bh=0NTUeNzMGaXMn+H8CGAQVpJ+M1ACmhxnQPQXiZxaLKk=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=DqH7U5fl4CeogDUUHgW55FUZXpevXO3CnGZgqABKWWn5ZcD0HVkvSwoLnO1xmoKLgCCgtG5Ohd8QMb0i+9Muu1d0DPwhN31voRPtBoXDvGLu0vhQIjfI0mM2Vq2IYHyoIL/3Eo5gk+PVSpfBPxkHchdeiDiTP/AZg5q3yodye3qZJCzgcDzSPyrnli/THnP2iwcdTB+JzzHhwMqqid9rG2MdMXTfIzLsSBeuL+IPqHmKlTjpmF2z4/QbmLlK3S+bz7qwmVYqj/2h/6WzIpuZtGNjEgOdZDdYnacoviWcQG74TkmfXtQ/fAR0EYS1qCg8TuMOlopPrpNJgnooHvg5BQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1682099189; bh=zckhMpWAb7uWXxb+Q4g4n5H2g7mq7zOTpE1lSUOWw6I=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=dnS+R80fd1lcTmc7DBndB8efuxCojTSPql9B7MfPFij/jOZf9xParjxhr0KW9OTLeZmo/ncF2BLhmH4AV043HM5WgNQcycVHD37tmLH0t9X4q5r8GVvVEzR19t+mHtQmqnkQr0ZvdcYIUS7yjXDXbPIq5Lt4Ylyk3/i2PjpsGWZHPxoeeJTKMyeJciRrAXQqNG7MKpJOLU4WW8PxePxXXCTMJkNRkVrFUI9CXwkC2j22IljqM9MFIxibBILs3t2Ract0CxnPaiob5XHBSw0sDuGGKUz/CE1+BtAA6S6/WHz3Zvoh7jJvl/YAzjs0qxiUMfnJEH2RGRKqZ5aRIgB+/g==
X-YMail-OSG: CGfVMAgVM1mCUOCBfsrPKYVw.90hEbo2ERHkYrjrvqPzC2UNStpSbMRLmBw2gU.
 lPmz3SPwb3Vq5pajo00J1YHBqifIuDFl.VkYG2FsjvAD5GFW73WVKOhWxUkli2fQHZwsAJFSLYfk
 LGdfM4_Bwe8GRDC3WvOGG4BAcPExmW2qdQ0_lFJbH7la1gG.guFXfy95gsJR_Z17j_w9QBL.rkkf
 _6EL3t6rXZr_df5Tw82rBjZcnEPfpYIlmg23IQ0MVdj95jFa38jVgGUWhWF2IqRp17Au2HFO9eSp
 tnwxbXpPgZLlm4M1a74_8A6h3zctcpyMABflmtxGv8yk2ixvYU2NkFVxbadiMnxG0nxTsQagJDVQ
 eNnLAGQoesVdW.HtUEC4lVmtXjDvvqeP73FwKFkbbWmNYDBpmNofmRrJGVMg_p0oI3YcsmV2sODG
 zz1_59kxXsdVM02xSAg0hQr2ZHG.g3TBMyFYQ8grop77.oV2Dv.tecVFOCDQsPmX2iIHi3EBBSRC
 pjDxuJGsz_PFfjfFWaH6TMLkK25FVyZ37ntg7Fra9mYJ0etKwgwUJc8rYRGtW3mOTiXYMVpZvR0V
 fZN_T4BJnp7OnxORNuXMGyp8v.JIyiEB93A4qzrbpqHtOSFCaQk_M5lQkIe6f7HaN_PZsE56VEms
 XgoNoopeYNAk9FgNCJKahg3fV6rDYZon6WBaOqciDjvWkwiTAK3_sdkLbLH6grF_w5RVhEbFT3QY
 Msm8ZOVQcEcdtQKXLCbxboTAGXIYJBr4bfiuLsP_vqHe5MFtuugvJc1JSt7LleMyVDdWyiIJcLsM
 JTni_WZ3itSgqRKOPZapOGdHSBMf4znnewUKFoKczihCgVtZyuawE1q0tfJesQCdgTaCpiTOqLF3
 lZnWsl2fajYxMXHpKf0Fc8_pbAhp73kvlmW4eScwRpzmzHUNFqeWsSY0KBcycD1e7GFeDIiu3duo
 5ML3_Qjs_AVmjgFhLYQ1D.algTEx7ADRwV6INvsjbfczlSWmzmHYw1uG0WDaUTO0sbgmpi6X0I8c
 5RrtUYPbCtaK0PDWNq.kBg_UarM5vuQe0PUa9ANb6JsZlb_3XnDnWww4zcKRHMVaqO3ltiMxArIw
 toAJnGz86A9ycR0tIqxWXgeVpjDaQDJE7gxfd040ZT3zfew9SjBPO3h7kgw8SA4FoIzhxz_2q7xQ
 y9DEmhiFLrgH7HTRP5FCppAz0KG9yLEg31Fm50emvkdApZVWk8VZRM2mnPl5Cu2Wi6VTjGo5Mb0k
 p6cHN2Xp9CT4CuwjbZbWoWTWbe8FEhhTD8JpWAlFq8DQbjY1GOra0GTS0yLI0gBNoYNNstpxQXT_
 3OFHu2oWo9sS.YnwcCJpnHGer8XT4Las6T01ZpmHf3PwMeixtC4xo.G.c.cmeBZI1YR_xNUIq6k0
 DK2wjUyhcNcu9Z07b8zCbOr2OL3BUUnTMKqVN8cIVedRtYpFACndbisZ2dXqIjOry.sUVNWZZUE8
 O2KCQkDQmnmmW8Pgf9L6onvDGo73oPaevc2upVV9kEzNIxBB6Sxz7u5SiEEtuGW3CbcG32rzx8G5
 ZZA1yxDmzbvOoYcw7NmnHLDTuDbnYdjMRlBq5AaxsOaBbLlp10saaop624.UuNJlJFR4iI38joZY
 QrWBLrkmHy2rl5hevUcju5_UKCS2XANLk3bGylNWNs5ggzm8l6Ki3hIlLfkrHD14iu6uB6tDlyEj
 4owsDDg1adbElFEq092ebcA6qgnYYEqtGL9etEH9CwbvM9j11QgZhrndaz7jJ3BRmhwmCCwiCvya
 ehEV_OEdSJsDHCzzU151LEqsNPD1eokvFwrtU4GH6nvtdo6GASOzphUJhfgtjy9aPxDRql2Kc.KB
 TczOnQGdbh7O1SksjPXMct4YXhTFmJGQURmu84g_HyksPPSGj4RUkJmEK4Sl7UJF2JwTfkfZ49h8
 qAi0kS66hEzzC0KiRnrc050qZ_D0YHP4JQl_D3iwVocalJjqMlJ8_FWHxlVJXp.SMhuTJ95R0H6h
 gH5p6_5OduvnGzSYua7qG.MoM6pLu_vIrV9Q0ahKpA1dVCjFUFMMs77ReRGQUqMx7QURokyk8K9W
 8XvtLT6oFl7EudOJjDNGLYnbo0AoMQEdkw.5BOT_inu033XzSZJQStXcJKXaNi1pBSqAfttPc3J4
 cNiWc1Y4K6MfhBunrN3zk.FFL.Gxv1_I496eWUXU0SjyWuabeX.wPs0OBsMGI0AtTjQOPz1lHPuQ
 aMbgpbOt.tQEPK64m.BdZsN13wna0YbKmbCG65AqmpNi.FJwDtAc2_kfG8ZqkHsAYcCweaaN7ZLl
 YDSVDjld6z1AYeAovVsSs
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 5b4ad7b4-8deb-4b10-ab81-eb15e54dd0bb
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.ne1.yahoo.com with HTTP; Fri, 21 Apr 2023 17:46:29 +0000
Received: by hermes--production-gq1-546798879c-l2qgj (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID b7487fe0c5844b066c0cbb2b5e828d88;
          Fri, 21 Apr 2023 17:46:24 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey@schaufler-ca.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     jmorris@namei.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net
Subject: [PATCH v9 08/11] Smack: implement setselfattr and getselfattr hooks
Date:   Fri, 21 Apr 2023 10:42:56 -0700
Message-Id: <20230421174259.2458-9-casey@schaufler-ca.com>
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

Implement Smack support for security_[gs]etselfattr.
Refactor the setprocattr hook to avoid code duplication.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 security/smack/smack_lsm.c | 105 +++++++++++++++++++++++++++++++++++--
 1 file changed, 100 insertions(+), 5 deletions(-)

diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 3cf862fcbe08..902b39c187bf 100644
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
+	total = ALIGN(slen + sizeof(*ctx), 8);
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

