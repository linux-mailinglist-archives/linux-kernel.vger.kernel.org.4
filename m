Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8B586BC021
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 23:51:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231701AbjCOWvs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 18:51:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjCOWv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 18:51:29 -0400
Received: from sonic310-31.consmr.mail.ne1.yahoo.com (sonic310-31.consmr.mail.ne1.yahoo.com [66.163.186.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D41BB2313F
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 15:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1678920629; bh=ylaVWORBqgwPnX0cgeH09/nXwfkOMqqqp/PkB18uv1U=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=bDT0NCTmkwaabsc+dcWygREluI023CSk+HKwrCy6iF88QGmWlBGIDBcjKhwEESscZtxe8a3B3Ljo5F0G2CbMQrZcyyTkma5YcaKFLHhjG6QG/C1fn/UvTqS/WBiRm31dfImMk/Kb8ajtZ6q4d3K2arYF5OiHUV8jtgRGsgLcpunwfZXUc2z8m5TDesFbs755wMIiykeIkpxsIhT1t+irZ8V1BFzJm4MHckzWagM93RZLMSArnTbcWkXwGo/lqXERSA4JiIzPP0NkL11tYvcFMu2n0lEB41Ywv7w4NxIgi4lMiKTKB61th4F9fQ90fIYZZM5309LAEMzamN4tgoJRNQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1678920629; bh=9tL6T/4ms/E8+fo52yhFKb4PRZOxTyEzM+nwd1U4NCb=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=tOYEB8Gmbh959qP0LI7I/+eZD/eHi4U44GhVlpaeTXhGaI4wEqJ1+rtimEVHpxh7DAL6Ff9Z30/dN2Cf2Q9+CDSPHWX32x+Qot7o8HLVnG6lYpN46y1maGmtjV4gTaZA/SiwtxHxbO1WypJJ0cv6cQSmhtoEX99yW5yJnYeUeS6IQZfQbW06Xr9VZZICO9JRg+lM8WoStp0NTnco/lN4m7cR2TkmRRAyuqYiiEHyIubW5PMiSHBG+Iw3wWdCDaxtlsuYr92QaJQ0BSksLEr3pfLXEvSYf8aBXKcEqT07IEPMQDWExkv9zkBzPtvdi+7/L8YyHLSLFRbqOFfL/xpBMQ==
X-YMail-OSG: uk.YOLsVM1lzVQLKKkeK6BAIE8kK_x4GHzQoGCYf8UtdwcttCYQO0PK1y0JJ5TU
 GeP_.F_PYtpjQmnqAlMccArqQskswFZsyOQlNJZFU400J0LamIJFotg7dP5I3IKcmqTfVO1wtb61
 GzJ89iUTlOfOYt0EwDryzY8YHpCREa9tMgB1N0Cs1N0q7iDN77rA.mX9XrpUOf6sEmsYIRszIgyv
 N_w8HYF6koZPNaXUgJS4VdGZtipolgOY1DZ_Efv00QqnPFvnkXQJ0KBg_JsHi47J5OVoGTYG53NB
 birwG2TS10DY5.6qAvfrQtCM3NXRxIdWWs_4Xj2uQ7yxxPEgIQcFRS8WCqWoBNeJzwbfbXEsKK8.
 b744MJfRRcX94iKklDHLMmTBsx11WLW9EoercTFXOIfinU8agMjmdrF6PeLx7TW3sPjqQIyFJWNF
 SX2oXNGPpLuQ1D.XrLBMzSf.JDnVut9OhpEIXONJ_RyKMJKFY9tDVYfxIxGEwTxW9SIfqsg09gtF
 ZEaGxM6rpX63o8M8I2RD7zB0ZSzCT4AM8KNQFD9blh21MF6bXuDN5z3vvD.qiOu2N2L8ccU0Th9s
 sp_m7UlILEgZ3SJToQSiG6UrvPT.jXSiW0wrwExGpjUs7JCWa9ob7i79wCrsvmJmomfhsM8qEiVk
 iXe4YNdKrxCe4s89GRJQDiIcMU9uqBUssbPcDs8Ci03hyCNPrJa0t9HuM9odfPOaJ.kaLE.2U3p7
 3cedVdEwhglrJda8wS4lHSlSQQaaSH94__sIalGoQasmnb2ZjoofgJddBFoDBvlCfY7RXkiswd4V
 EO3WBjvmq3MF9djqDDeJdiu1t2120dxV5dUQaW3IrrfHhYA3fC8frdDa9eU1GP11IyMFY.dhaHnS
 JdP4ZoOQ7mHHrhDGLJToOWEkG7Gt5DllIvpFeqprQjBXCB1QaBcsh6YnLFkO9VTlxAWeiC23cLQ8
 KihYklfg2ARlKh.5WIBrcIROn5XFkhYBfacvY_7luEBmIkly2zWlidY1iMGM7WV67vQEefvELLV9
 eeZFpr17mMr4BzzFQcgSXyOMMe0ayZXzAUlVMHl4ZHnINds6oTQcrMXzO_mCaFkUYO.tij_FJKt6
 H0bQUMasm1lmov2b6cvR9sjN8hNQCbg9UuCgPqfVpu7xwBuMbAd7Lml.HADNcabpHUClE_ojB2yr
 Aj_X4IC.xk0JVNEeRKilJKxQ7BGNdXWYoIVLvI2sdOS83e56IR.am41_ItGr8gb.eXPpQyoWN6lW
 HYmTvsRgbnDPrYisRzkjcyQQAOv5i2FihgyKc0Re_PGUw9hyhJe4NkTOGxZLZ16wUkHEphTdfzR2
 aAzWbE.XSen0nSbJZEr.Bu5FwT.bz4RyXk9cxTXfLcrYEnZTTX3I0EtZq6S7eKMz35sJDA0VVeYm
 apJMYY5NTqfsNWDIJnEN7Rpmxp1Bvd7EghQDYtgeKj_zzSO35d2lM3bhK7p_3pSTdF7wbuXWPOHI
 C4Lx4GZFrk3Ik.cl7VMesexL_dF0bTMO83NCVnp4MgV_QBAmXuXLdKW5m7oGtX2d6zeCklHJkuVt
 LmsldkoQopwIyusKwMTDrLz66A2bc8MjgrvPSReBVlKUYNJKRCa7DJOr95ID9BJfkTttPTxfE_h.
 GIdsmFc_FH2xu2K5D_Uk3H8EhgXP0nOf99a6._RQDIGU5rl__WQTKeUaXlt4H8wc618QRP9r5gg0
 LIZyA3SxMUL2QIuOBcUKPwTTtz5XB0kiwp9YKGs2WYwh68xj9T6xmTd_PFhsMlsOPE658IwIegq5
 u2qsuDwoffIvphLqwLBrH0scVO2gk7VgaKYstf5.tSBpFKy9Vk92a2yGSzB9U8JFVs32KaTLEofY
 hlNV78fm2btY7QPynKTQ78btQhn5rHyPk4k4HadyBd3FY9VA6OTEvVkyidg7j_4vDMLtaDaGwJ2u
 tZkd2azNdPIchNi5WkJPMtXj18QVZjx8VbTkRmnqP0sIqmQl9dB6u3bV7Uc2DmFactby2vroBO3x
 hm9fi_YhoHj3sbrAQxcLKg7DNnPpDPeDkJfMC0R.EBL.Xo0jpwfvhVxhO.XzKLzTXnLPKkA3yGQe
 9chE1bSh0MY2vkCLucT3FCVhZ6a6Qy1XAidApfEY34sfn6JIJrpUEZ4CtOy7sow33AShsPW5UL6V
 cIMbLEWGiFXt0c3mPD6V8fqDv.xrZt7_6GJSFdfN1wBbMqKMcx6a1qVEgOvYvXoCKDclgaFPLad6
 9Yu4tNr6DP3Mm6PYrHib9ppw64qPDncLrouE84h6FEll.iQQhbbpOBNBKgNTC8s9TQL8U5Cbog3P
 9KnS2Wemh9CQDeLiktYM-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 10223a3d-1f1d-4cf4-bc64-10581ecf481b
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ne1.yahoo.com with HTTP; Wed, 15 Mar 2023 22:50:29 +0000
Received: by hermes--production-bf1-777648578f-mpdrm (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 50e2f089a68eaebcc40c76391bc13d32;
          Wed, 15 Mar 2023 22:50:24 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey@schaufler-ca.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     jmorris@namei.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net
Subject: [PATCH v7 08/11] Smack: implement setselfattr and getselfattr hooks
Date:   Wed, 15 Mar 2023 15:47:01 -0700
Message-Id: <20230315224704.2672-9-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230315224704.2672-1-casey@schaufler-ca.com>
References: <20230315224704.2672-1-casey@schaufler-ca.com>
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
 security/smack/smack_lsm.c | 105 +++++++++++++++++++++++++++++++++++--
 1 file changed, 100 insertions(+), 5 deletions(-)

diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 3cf862fcbe08..b3e72b82ced9 100644
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
+ * Returns 0 on success, an error code otherwise.
+ */
+static int smack_getselfattr(unsigned int __user attr,
+			     struct lsm_ctx __user *ctx, size_t *size,
+			     u32 __user flags)
+{
+	struct smack_known *skp = smk_of_current();
+	int total;
+	int slen;
+	int rc = 0;
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

