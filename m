Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78589742DF0
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 22:01:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232371AbjF2T7U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 15:59:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232324AbjF2T7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 15:59:02 -0400
Received: from sonic313-15.consmr.mail.ne1.yahoo.com (sonic313-15.consmr.mail.ne1.yahoo.com [66.163.185.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEE152D66
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 12:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1688068740; bh=lB5ScsLeZipeYbWB53q9EtR+VBviso3GISiFZDLC1tU=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=kKYcAq42/GvzhValfB64otUu/gJo/+yHfhd1vV5djelghBiPA8taSojf7CMPDX/qtd4XrF3I05h2AxcI/xiFxbZqZ2mePtF+BizNGzCHti0PoIXs2uPBx8Gri359jABn62Oa6BgwM963rR50X1bpo7IZsYQR26oO3AbLFOfKIamzLtsXxjFegPlAGELuUDY1euUZG1afkq8YB/P1qebv0DNEeM3g6hpizc1muQg9jX+vroJ6Ej8ls0VPm/p55icTaEOC4kiIZnlTdF6CLB6RASSwdZBXbkTKXkjBsKxS0dl46hi3MAMVHOEjqhj3FgmBtKZTWUyHIK0HRm6iW9H+kQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1688068740; bh=FbFR4UK41Jj1PS6b4T8YimEPCcktJJVZdza2S1b9tl8=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=CvSWk1f1dQVefWBkmLsJicqjPhrSbZ7oLoFfGxunXtCa7i65E0MAltmCRQq+qDRus58/iuiCKFZMFbBLduywK7ROntgKDEEhfx3qLYdTJKXfBJF3NE3FX7mO/qRhKqdbFhXuxUcPwg17o6V91iDELRPQ97wDQZiPtxeg5Z/QdqkUZ+AYkITJpXBOdRreSYxUIA1QvmdP7eJrxFfX/9C3brAywGW6NhVzst5vC2frh3U2uWl9wftRdiYX0Hb65nFrKiNQrPUuheVZFLmLosFuLbzQQLl7Sg5NWczL7Wud6jBfENRl628l7uOKT2HvRbwlA9hGMh/s1vOmhgAbklRn+g==
X-YMail-OSG: QiyV49wVM1n0EJDPbuAUYW3calWZdB8dYjaIyZHLN.fDIf8DDqoMN2RexbuNTSU
 f1qAv1k0qTEl01fJxyfjSS9KcaBMgAH5HVboVF_bSwJv4ylJnOug9F9XhLAcPjOiTKZYS71KDcIi
 A29noVuA3bOjys9S7X0Bk.2cusOkdtpHipfZkcLZW07y0pYnQVf2h57dr7bOWy5PPFpjff.IVxRk
 Gkkpwhsgl6NvvfTnUF8DK9UwM0jsNlm3o1137DUoK0h72EuM_.s.cgE1wlpMC1DQnYpyHJkhT0M1
 qxpfF7HBjB6PJcTetfPxNC3mZHx.3eFDVD1UmcwQfysxC.F.qkoajRCTRClSOsiI3y7hSHoOc7s8
 s_RCLod5cLZT9Nb47JI8SFbgdxwDHveCFQPSHaCgdx1F3jQ1EZpJg1LNu1cGfnBJiQSSVjqtty30
 5AMkYL8wvMqNl6VOV97lLdKjipXShZS0doyHVq4EK4usj70u3eogETWHfB49bOPWZPfvKckVmm1w
 rz3Fkm9R89XQKQk2JBLBdHx7baLdDVvM4vdSbWO_qjVxn1uFFfWT406OtbT_MbKYEYGkf0U3dVa7
 5C_ARnL1UCW50i1kbm5AXxNHogNQPArawqckUoCBvHjs.yUwh2QwxLhiz_UCPjo4SP2ol2ReKdON
 suGbQqKi__POjWu9lzhHqza88gKFQV_omHRmGjyt5VoRO.8i_d6E2EyMpQ8Q70KmfosJk5kblTbI
 Yxj.4oQ9INNMR0wICOzW19qZrpym_6PdX00e6nmmI6dPlNFvwvwHMk0rphf7M6zuYrRm5lsmOZG6
 1GJksWlG5VU2M2D3RNVIpnW3y.aPvC8.BQAoLI5qM4CQdi32t.5XkO0vjrOeSzMHQ4iwzZf_ufyF
 cH.uVaGCf7VboA4O7A_u5lMM4M9dVIjqzK7YYIRq13Tx5H6dWTuIpLqBco5HCFMsl4fROmjcRjZW
 u03lAgqtZpmwyb6apV2r1ILZ6rXBMGa6rPUnHhKYCOO3_O_sLsAQWRVDCBcuF4s9GEPM_BgPD1tq
 0_01mLQya2VbYRYao3WD4QkT7SC2JwYPsscjXSp89ulTl7UPPGOd8u0GfQf9TPkBdrKImP8qRiaL
 l0SDJIDWtUOkCmO0x8XezQF9N6iUFZbOhIi0G8tIR13a1_664Bycg9v3irW6FqFmtoKzzKzPrYqD
 _cuClTmRIDKdK41pOyTGykJOmb4lb7iXmRRIn5zd9S4RQv9qP7Z8BvBQG_mye109s11aeNgGYY5A
 amjDiUmjg8oA.kStuUqyGCzlS0H9W8mI3kkpOyemxMFUXxYiEL9xdpTrH0hFp2hnxjR0PgDmgCGs
 Bfptt7jzDH9rSWs.DY_jnuGFwswpLs18effcQx_FO_VVHkxIOcuVQAFpWtrb3YYp8We3DyrS9JVc
 K0DT7x62ez10fxNv1OKoAOsK.foYlK..Lt.J2LCknIacgmF2fAi9W.AudkbQVd.__qU9_WLSHnQy
 yl.c7A2Ql_c2vuulnJoD2yV4N27HES46PM9QSLZbuzoxNrEY3h5tCAHw8HT.uC1eg_cVh9wC.guV
 yWuMHGiqe0YkK5lCcG06JoViRtdkeO_xTcZl1HQ3vBwRoJ.beUx7qt1DSTQqbGB73O.s.dKCsz0h
 eDBsRnLrn1GLr_aV7VlTWNQKN8q22dVLJWhM4HzH1eeyzaBE05MIOkNOmNaEyeJX.y3YsL_RUgRz
 7jzUceRv7Y1qM0FsSkeNKKmDys4xI_6EdxKJUKqRx8sc4XTHU7pJnZlLrCv73V7Ug90GoitISR66
 mTEvqXvwRSGkN3QJ5pSDrLCdJ.Dx_1RRkt0W3xDST5MyXKmIJ.6nFQ2gbbY5p0qLpy9ZMm_vc4Wr
 8O0o9RApsUH26pDv4qwrGBup_sW4dV_k5JpZTYmE4igSKWqko2EaYIKyXov9tasayX93S2UspxAa
 HjSP6lq6FxJ8ARwI07YBrlXHfdDMjzDF3DtuE.yZQ_ErBfE3qmxFmgXXeVZflpcjfesJGi8oU762
 wNH31nBpXI7WfMeo21xa5ml5faVgtrcG6ygs9VJl5NA0Mf30cBj6RvV8N7Os8kaUnZkr6YlgJxjH
 MHscOs9Dht9R85ICKhjbpMeeFel2z4_.AgKShKLWPHbnEtZ6DR1oQvh0w3fDBv2Kff5M7rAory.i
 jWLMk9g_DLtUZJbKpR_5hrKEID1WEA89w4sPiClUdQ4ceiIeiWH0Mvi4FKogOTp44DQZWdJTlgrE
 lpVR91JeWih_.puLsa6Uu0nbUf7nK57sgekx2mXd1tYO4m2M8.Aa7VfQnZjOx_MWzbhh1jUDGwPl
 vtho01fqvlwSfdq3nRw--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: be22d627-ac22-4559-9992-2bc50d686d2d
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Thu, 29 Jun 2023 19:59:00 +0000
Received: by hermes--production-bf1-5d96b4b9f-dbx7v (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 179208bf33e8d1ee67f1c353255c48d0;
          Thu, 29 Jun 2023 19:58:57 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey@schaufler-ca.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net
Subject: [PATCH v12 08/11] Smack: implement setselfattr and getselfattr hooks
Date:   Thu, 29 Jun 2023 12:55:32 -0700
Message-Id: <20230629195535.2590-9-casey@schaufler-ca.com>
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

Implement Smack support for security_[gs]etselfattr.
Refactor the setprocattr hook to avoid code duplication.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 security/smack/smack_lsm.c | 106 +++++++++++++++++++++++++++++++++++--
 1 file changed, 101 insertions(+), 5 deletions(-)

diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index cf847cfe5ed8..4a84639e9db9 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -3536,6 +3536,45 @@ static void smack_d_instantiate(struct dentry *opt_dentry, struct inode *inode)
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
+static int smack_getselfattr(unsigned int attr, struct lsm_ctx __user *ctx,
+			     size_t *size, u32 flags)
+{
+	struct smack_known *skp = smk_of_current();
+	int total;
+	int slen;
+	int rc;
+
+	if (attr != LSM_ATTR_CURRENT)
+		return -EOPNOTSUPP;
+
+	slen = strlen(skp->smk_known) + 1;
+	total = ALIGN(slen + sizeof(*ctx), 8);
+	if (total > *size)
+		rc = -E2BIG;
+	else if (ctx)
+		rc = lsm_fill_user_ctx(ctx, skp->smk_known, slen, LSM_ID_SMACK,
+				       0);
+	else
+		rc = 1;
+
+	*size = total;
+	if (rc >= 0)
+		return 1;
+	return rc;
+}
+
 /**
  * smack_getprocattr - Smack process attribute access
  * @p: the object task
@@ -3565,8 +3604,8 @@ static int smack_getprocattr(struct task_struct *p, const char *name, char **val
 }
 
 /**
- * smack_setprocattr - Smack process attribute setting
- * @name: the name of the attribute in /proc/.../attr
+ * do_setattr - Smack process attribute setting
+ * @attr: the ID of the attribute
  * @value: the value to set
  * @size: the size of the value
  *
@@ -3575,7 +3614,7 @@ static int smack_getprocattr(struct task_struct *p, const char *name, char **val
  *
  * Returns the length of the smack label or an error code
  */
-static int smack_setprocattr(const char *name, void *value, size_t size)
+static int do_setattr(u64 attr, void *value, size_t size)
 {
 	struct task_smack *tsp = smack_cred(current_cred());
 	struct cred *new;
@@ -3589,8 +3628,8 @@ static int smack_setprocattr(const char *name, void *value, size_t size)
 	if (value == NULL || size == 0 || size >= SMK_LONGLABEL)
 		return -EINVAL;
 
-	if (strcmp(name, "current") != 0)
-		return -EINVAL;
+	if (attr != LSM_ATTR_CURRENT)
+		return -EOPNOTSUPP;
 
 	skp = smk_import_entry(value, size);
 	if (IS_ERR(skp))
@@ -3629,6 +3668,61 @@ static int smack_setprocattr(const char *name, void *value, size_t size)
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
+static int smack_setselfattr(unsigned int attr, struct lsm_ctx __user *ctx,
+			     size_t size, u32 flags)
+{
+	struct lsm_ctx *lctx;
+	int rc;
+
+	lctx = kmalloc(size, GFP_KERNEL);
+	if (lctx == NULL)
+		return -ENOMEM;
+
+	if (copy_from_user(lctx, ctx, size))
+		rc = -EFAULT;
+	else if (lctx->ctx_len > size)
+		rc = -E2BIG;
+	else
+		rc = do_setattr(attr, lctx->ctx, lctx->ctx_len);
+
+	kfree(lctx);
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
+	if (attr == LSM_ATTR_UNDEF)
+		return do_setattr(attr, value, size);
+	return -EINVAL;
+}
+
 /**
  * smack_unix_stream_connect - Smack access on UDS
  * @sock: one sock
@@ -4939,6 +5033,8 @@ static struct security_hook_list smack_hooks[] __ro_after_init = {
 
 	LSM_HOOK_INIT(d_instantiate, smack_d_instantiate),
 
+	LSM_HOOK_INIT(getselfattr, smack_getselfattr),
+	LSM_HOOK_INIT(setselfattr, smack_setselfattr),
 	LSM_HOOK_INIT(getprocattr, smack_getprocattr),
 	LSM_HOOK_INIT(setprocattr, smack_setprocattr),
 
-- 
2.40.1

