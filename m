Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D231069FCDA
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 21:12:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232500AbjBVUMh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 15:12:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232127AbjBVUMZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 15:12:25 -0500
Received: from sonic310-30.consmr.mail.ne1.yahoo.com (sonic310-30.consmr.mail.ne1.yahoo.com [66.163.186.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16A1C457E6
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 12:12:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1677096727; bh=hLBaZjUXwmhUYgtYRVIYEfvWuAN4OPHpAcavTV07HcY=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=dLAafU7NGMwgcFnxyi8vueUU7UWmJ3oyu5RF65XeqEUF3Ed+bN6/iVDZEACW10Y/DoyIDOPt0Gb8UMUZhEsav5XLOxXXDWHDWKda6I2yYT9I3tvVFepJ1KJg0fbQxgOF3K/Q91a3eA5SYutNb6E5WIn8oGQfdL3N6H5UpE4VmlgQoiZwUX67dS3Oi3RIux2NOI63iauCPQL7gNBqa1xbNHKVYnkvTO06dEVEDRehMCbBLRpA4isO+34IdFf27j7cEqnPrfc1PJ2vCUKQ5EFGqZNsXxCz0QGbJMWdNnCbezpuYEAGrUKfGAotx5Zlbk/rrxtlNN00fhQOkLt8cMSSlg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1677096727; bh=JPCTIuQgL4QQQVor2O4I1hayx1ILlhI6y9e3HfkcmaD=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=XGVdI6wfhc61KOTVUsyo6LMDebmL0tlmsi58bowh1qdOjK652onCvrxFar9r4Jdo3NGIpm2mU9ZA2W119Dfk9zoMBP5YhFQ2xSDSRse6+gHYoGyYzI9dZYbfkJZhmeLSn5o6YGgz62012jXZvFbYQTtEJXLM9AfyiF+MLIeAxUrnEc1iRIMDA/RY36k8Io6RorZd4RMOh8xcM9qGBSisIGiI7f3tc+GZwyMlmUvgzEtmBOsZg7GbLikihAzCpw2Tq15NG7eccSZyfe4JQ6t3YpbgDx5f9+uRh15J38qkQefJgqHA0cwXTb8kZINx1QJxBlMId8LpWKLikbtWD+dH0g==
X-YMail-OSG: aBXDzS8VM1kgzWECH82Ia5IDwcIAB4G6knIF3eB2OrUOYOfGfcuSYih_GAZVeIE
 hqUJ41UekEFHhbEQut5KgdCrDnmZi3G_AC7H3zle.26o5C.IxIfI5i_x9YZHncADZeaO0_iVX5H0
 flQBhqD5EjUukkXgJkkKcbSMpFhvaYVLgVa0rCPpBj0oTxg7yc5B79XDM98dyHzNM7n_rnGPOY6Z
 jeQWvxedFVoe3d18H.FymB.u2jtr1Pp_P5Utb8N3B58Lp9gBie8HBA_Xu3WX5iKforYCAnjTQ7DN
 m8C4lo4xgCSJB7vwi2b5kebB3PQTrr.D57oCpdVxlaE0YahovE0enN4otbx23slyNQCkygkgeFJb
 jSfy0cuZKOnBiMbx3kTO5.yjtZnF4zrYQ_4pev..aByE8j43Q6VViKY1RJaLRlDkPVClrGUKIaPl
 27saDQfWJTzplo2qEStUJnwhMmnbgu.AlUQRb.PPUl4U5u0zNLGfJ1U7vI_3eaogcXAtR1utlwCZ
 1_YNIFIepgVMDCaLze7cQ7pZ2uNzw2OWHhUAkWJMev4_dI.BkQu8Bl5FcEeT0fzlERc.3Zhi8vtS
 BZdcrYGoBbjslv5tK.FHxW3mGNYslXgNAFpDbr0x10P9EflsM0LQV2QMIu043XV2aVj8waOZiQf6
 desHq0OYHADp_geBOaQCs48oDbU5O.sLbutefBqV5ieeRL04QBqDq28fxrDrS1x0eeuljESzlio_
 dlrusfVL50lgHStho7sy4.e9ndEUmadyuAng8WfQLy2bIw.sp16IsmDMRM.pkByw0AVIqURjFr9j
 wQyKCpl5vSx6XcbwtZgvsSNsr8dtcln9Dn4OINtk8b13eapRhsRwiXlI8S0mSlZBeu.zsbQO_7b2
 j193fgSnDU.MdRbgv.1Itsgrar0Kk.viesZH2.VZMQxyHTjSuqv4O2znXDlBWig0OnQES8t5mRE_
 KlKfnamDQ0MZ2uIPbCCJoSnuADHopVkSpaON44wh7GQZ1Ufl8grb86UyxupIwo3k6vY7lwtdPXJu
 Ml9ZPF6.eOd8FRRYXueWQGtFQYJyGMPz0aP7g1pYMF28kvBc.kioordz608bK_g4xqT8OnPAgcJX
 EDQfSFKKJuVboYTbsruPgA9IkDEne3iCiH9UoigGxKPOCfTlLzh54y1HDijpnz3deMW.RtfoQkB1
 0ncXN8JXTnakO8NzLJt632gmnBFYPZjnu5gJEzBsWHwmw3f5T9HnBODIFEimZcNC_vx_pQ2VEhCp
 qMhGXP4nEnEX9Tx_4E9V73qA8YfVzoWfnEqsiaQDfLlAbtsP9OTixdGPBHoxq22bt6w7Hx0JMgmG
 HZdkGIHBKwHm0xzS5hpr3QQgdanMnLz.JwLwoH4HAxP1iVsOOTbK0KKtTk8k0AW_qkc6MmjoUjGU
 WPjgFpTYgLEtpyhViROd6vrIUG8ZI9aASbwHMBoMbD2etAcWyOkY_GBiMi710NPRQUVALbLMcXhL
 yVXuZOyGKXtkKvSF8NOmnj.Hw.N7t9lkSg_HQTjQEHhUqVvNObTrX_Dwl0N17wWrjziWyCmjRwT.
 cfZwsuGuyPJRpaFz4p8yUmyNJx3uzn4QOFqoARm9UgmvFR6aYRUNOP7srOpBXlbOcDbrTjxpCCQJ
 J9LTtPnL1V36WPD_9jTvOGE_J1LDphpulrFpm6DLEsg8hJnommFznbNlpby0BUymVMbrkLPamth8
 sHVUm.Qin_gWHr.lD2YtoJNTQxmpF0Lmj.xr3.h59yINa3fvlMcYsoJHyZoLJCDKF.XqcnB1tkiE
 TxppSeUGHD5Ou1Q3xvr7mYMlpuXI9tH3uWDnEhY2WJQj6JUOqmy0rS6u3UXhS._M5.5Qm9A9g3N2
 n7G4k9ZX2oZc3WyiGBGvBfVSamq5qYxePusyZnvlkQpOih0u4dOVlrmGOe_l8uwlhuPbD1_jQHVf
 BAMTjiydMkrsA3WA5.QWRfiOSWlTJdbCKtwf33wR.1z9okM14RVdvLPAdxgZiroQQbVmElYWx8MJ
 c3vTUAfMeGF8mCGIx3RwlEG6ua31KMIjmsmPPe.a3XJAiqJ45e9rgPXaf5jSZ3BmHcmiTgwH_PoJ
 Z9vvLmiWarMNYuZ99MmdTakh2wVkRgj7VQre5MmScJSF8isK60a0nW5Vh4RdrOq.IhalA.gqrlxX
 ADFtSHFscY0.1pvQlEh_ZfZVWeqsMbnLBCdUINqxyL7jzJen44u8UoEkwCiQCPUz_FJd6uAu155Q
 fOdQpbU5z1LJKGETewbgi18CfqnEeOVa.DwuzAumeJ06jBNcs99TfHG3V1XDHAEqS_FcpSI69V3b
 GXcJN_11hH4.LETafhSZNcg--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ne1.yahoo.com with HTTP; Wed, 22 Feb 2023 20:12:07 +0000
Received: by hermes--production-gq1-655ddccc9-czwwz (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID c7ef53d340a8069498e39800c60f4cda;
          Wed, 22 Feb 2023 20:12:04 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey@schaufler-ca.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     jmorris@namei.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net
Subject: [PATCH v6 08/11] Smack: implement setselfattr and getselfattr hooks
Date:   Wed, 22 Feb 2023 12:08:35 -0800
Message-Id: <20230222200838.8149-9-casey@schaufler-ca.com>
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

Implement Smack support for security_[gs]etselfattr.
Refactor the setprocattr hook to avoid code duplication.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 security/smack/smack_lsm.c | 87 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 83 insertions(+), 4 deletions(-)

diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index a27157910fe7..b4cadc7244ab 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -3552,6 +3552,38 @@ static void smack_d_instantiate(struct dentry *opt_dentry, struct inode *inode)
 	return;
 }
 
+/**
+ * smack_getselfattr - Smack current process attribute
+ * @p: the object task
+ * @name: the name of the attribute in /proc/.../attr
+ * @value: where to put the result
+ *
+ * Places a copy of the task Smack into value
+ *
+ * Returns the length of the smack label or an error code
+ */
+static int smack_getselfattr(u64 __user attr, struct lsm_ctx __user *ctx,
+			     size_t *size)
+{
+	struct smack_known *skp = smk_of_current();
+	int total;
+	int slen;
+	int rc = 0;
+
+	if (attr != LSM_ATTR_CURRENT)
+		return -EINVAL;
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
@@ -3581,8 +3613,8 @@ static int smack_getprocattr(struct task_struct *p, const char *name, char **val
 }
 
 /**
- * smack_setprocattr - Smack process attribute setting
- * @name: the name of the attribute in /proc/.../attr
+ * do_setattr - Smack process attribute setting
+ * @attr: the ID of the attribute
  * @value: the value to set
  * @size: the size of the value
  *
@@ -3591,7 +3623,7 @@ static int smack_getprocattr(struct task_struct *p, const char *name, char **val
  *
  * Returns the length of the smack label or an error code
  */
-static int smack_setprocattr(const char *name, void *value, size_t size)
+static int do_setattr(u64 attr, void *value, size_t size)
 {
 	struct task_smack *tsp = smack_cred(current_cred());
 	struct cred *new;
@@ -3605,7 +3637,7 @@ static int smack_setprocattr(const char *name, void *value, size_t size)
 	if (value == NULL || size == 0 || size >= SMK_LONGLABEL)
 		return -EINVAL;
 
-	if (strcmp(name, "current") != 0)
+	if (attr != LSM_ATTR_CURRENT)
 		return -EINVAL;
 
 	skp = smk_import_entry(value, size);
@@ -3645,6 +3677,51 @@ static int smack_setprocattr(const char *name, void *value, size_t size)
 	return size;
 }
 
+static int smack_setselfattr(u64 __user attr, struct lsm_ctx __user *ctx,
+			     size_t __user size)
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
@@ -4956,6 +5033,8 @@ static struct security_hook_list smack_hooks[] __lsm_ro_after_init = {
 
 	LSM_HOOK_INIT(d_instantiate, smack_d_instantiate),
 
+	LSM_HOOK_INIT(getselfattr, smack_getselfattr),
+	LSM_HOOK_INIT(setselfattr, smack_setselfattr),
 	LSM_HOOK_INIT(getprocattr, smack_getprocattr),
 	LSM_HOOK_INIT(setprocattr, smack_setprocattr),
 
-- 
2.39.0

