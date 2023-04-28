Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AED9A6F1F66
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 22:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346637AbjD1Ubf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 16:31:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346048AbjD1UbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 16:31:19 -0400
Received: from sonic317-38.consmr.mail.ne1.yahoo.com (sonic317-38.consmr.mail.ne1.yahoo.com [66.163.184.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9FA5559D
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 13:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1682713815; bh=LTS1pTx08eLAAQC7xjCKlQuLiNjDTRWf5GssFiZ3X3Y=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=B2l2KvKED23h1dGN5KkZcK1ENA7EQKwUY5TOhrOmzFH1UFKRwVPaO8qzujIB8x19ysQMZ8d/VfG01ET/sMLCHfmRiDKtV3jfV/yoVQ6CuGTGEOk3pb2XCE56l3uk4jdQKLUJ6+Vekike6iAq2Fd26bVVnESFiXPRBBgeKLoovg+C/mpOsK47TmC0Z2Or6c8Cyl6sdofifJitHA/sreIewJddy6kv2iFkY+V3quKfy7ueDuVOL52zf2OB9O0I6c88YE5Dk5FjE8i00JQzLPVcRHR1X0UOgoXh6fk/cbzcRIVmAErvWoD050Lep7xOYShRUvke4aHaGOYbSoas0nI8eQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1682713815; bh=K61qB05ASNUS0KyA1Z1+zqg4oqP7sCx8gOGw5i68jQG=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=I0alicrrq3SSI3Z2JbFPwcwO2iYRFYWkAqEsVXDIwFTqRHEsnAH+ecsgv/Cw8rXgvNOba7mxzRYd3tiqEPx2zVLvsVILQXmljLqQ5bYhp9jRGIu2msoJyREDAl86t4hSUwnd1SnzCBr+M7gFso6N/vg0sdwnVlHoKn65oTK/bSAS1Bc3HFGha94emez4m9kUtHW6jueX1ZOdjfJHIb/xh4qgNNPYR7PnKwzwHWOeH7Hu0MDqYaWUTgqXT8LPyK7cxOv5gMYEue5oqO5YO9F91mqz68t8CCQIAQh6A6XrGbKppygtlSZSIE90dEqMmI7pGiGTSoVDV9uub+nVT0rPBQ==
X-YMail-OSG: 8WeFgoMVM1ld2d25xpdHurK5moefSlZ349_QumoqrSTfWTJcbyRfR2dPADkFiaP
 fWsbM91mJqKJ2L.sBKiSPCWB6FKcXVy2jj_RaEQc14lSl4G0SqifTCkTjYLiI.ZXKayHSrooheIg
 HuQaHMfjBq8ZmgxxTET4x71EDhOEkyEZ4.q89IUhfTNvROVamN08f_It9J0D16_ok3s87Myh6FMT
 Un7WS0I_QSYQQfqsxCKy0TNntnMyT6tXB9PssOzmsWnoJvmm5jAVc2.01XrRY2c0KZ86e8ETav4Y
 znnrXQmzAtsJA1sRipt5cT1PUPNWTSUU_R9vi86aCsnRxoCDUqhPCOfD9JqHPol5t9hsnWXdi2UL
 pCTEfAFsOzsaqRUvhm2REhsMqlSeXY_w_kPBfu1ECHKKEUd.HYUgsyYEqcWxr0XIfXZsDQD28R9J
 kMMVgf70TQHk1WQe.obrevqXBJYeBJ8C9Hi0jJha_xiYWrZ3VfBvVfkY2.EBjuTL2Opeugm76M3U
 7c6JNtkDf6hOspE13M1dg251AnRzFU1c.75caqfSEfEuiGOjY.xeE1yXjFyxq.p1IT5u00Mpt1gi
 DqZiHxD7ZteqMdx5D9hA9w4X31mrJ5k.wm2ogSMfIQ0Lw0n6nhwAucQqo8kUkccaa0W_thBp79tm
 uRW7KQFxwb.jbKf8zd0L3AY2GRwolQ8DKiB.RgXh7Iq3eKTBxctf3PoWisk19jJ3gDIZSv1AK5j8
 wAAcUwEO.pGa4o7Ij75vOIfBztWWYguuxa2aV4uohk6sTxUSrqUwnr42scmj3ytHPPaY8LrR9zhx
 tU6d1BMnjDnEMrkEVheKovSILoji9UY.cA0Y0j3FRa1eOFv8OSIK1LUv7nbPFR7tTMkyeVB0yVwi
 H7tEPzLKApsowjACg8INMzUIj0HFUVqrxcbr8okFxd6dBXuUhRsUxiyMyNe36V0RCZxzaybkYqmV
 9RtmYelGDyg9Z_PITnsvkXs2OVWLbnJTwo.4EPMw9g0fp.CYh2p_nFdQbdxV0L3EutJth8zs7CSe
 pa4r_ffE26q2vKUC8c6PUdkGuW2649Yk27tyAnx1q8QK.81mCxiqHit6TTSFZFlarMB.LO1P7RKy
 .epGs_THVV8yxHtznNTeCHe4x0nWDDsQXkv0lyGCfdac8qad7j1PiGkSbGIn.JpvSOLoeEqiJq45
 S0IRDrJmnXPuSnwGQBmfKM920_X6MAKUjR_r8Rnuv_OF8uprOO9twgtX7v72HeYBqPefTVk1LTfX
 B9FETLz57EUMlpfpa3i8Gg765WS_HRoiwUC.XACpt2xpZtgKAxJzVUDpe1z.rTRRT21iCeDgC_XK
 wrv2pRmEJSu_gdj5s3jMV5f9ww13OlkYr7TaEo_IVOloYZJNbIX9ERrzX7QusidJqoW__D8OprR3
 yLqtaDfZNjaZfZd2_fE5vTvOfJIkEorZ98674ljbPMIN0sZbYkssrdx7M6IkrobSXGGc8QQoKCT6
 rsWTOiK6oPuN4EmT198WYJ0j8SmZdTziZP0XhTqJBckXbZEyBZFt92F_N9K.ljz7RPQpccqX2CDC
 Hwj_A.dKhkSBRrQlsXLDPKcAg.PW386Qk7w2Lu0Y78WPLBNzgLHvOPT72MGpwOogPlx31.Cne2rK
 wmnLZcX3B9Bj1bpRxL_.7z4ji5sucldhVBLi8cODYklfbjaQAaOouRFiOchdQB86KImIu7rQ440e
 BDPDydcOy0Rlvhl1V2kcM.LHx7ejRgm96uASMgZZHtWEaGjC0VkvTyk693xhBS4y9JSowvAnqfV9
 4deynFYKI3MSUy2ZHaJ6ury0T8dknHB85fNgMguh7uIm5tInIu0Yj_QRkQQ1.Dw4FHLcDhUs5fGa
 JsdHzXl.xVcu7Ijkn0IGsWHLWR.spLzpxR4IcwsxZI3q95prjbaz4tSq_nMstQCuik5R5bI6kern
 lSSpN1kEFBr3lBG9.RIf3OevPf.Kva3OpT.B9tyA5eexctsfRoOCd3OnVPt6tIDSZn3c3uGLAlG8
 iC_NOte1aMHGvl6EKvtAZqFTWyJPZS8n0TX7VgTWf4XZVk3eBnbUWwINHmzrxcTZY23Di_gr9OCB
 L2j1w4EReHTBh.w68QB34VyT5p5uYGHWyPNYxWe_6TQdm.eKk0xYklo4defx8.wMfBNwbUJ2v89s
 lpFo8yAldKKuf5.f5UdnyqAU05pDfNASUEvkrVDaCxrpKW_k5nn2vICa7VDZpnsKLYAKox5M2Km3
 hWty8KhOwv5iim8xSgVEz6WkF.9pRPw56KF4oGc9VbaK398uYccnZhtftvtRWT9pGIRYDn5HjxEy
 UbJdRhqZso.k0979JOdiG
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: d4cd15a6-7c45-477d-b4de-b268498cda4a
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Fri, 28 Apr 2023 20:30:15 +0000
Received: by hermes--production-ne1-7dbd98dd99-84p8v (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 16afe408a2c159011f8a869d3993f797;
          Fri, 28 Apr 2023 20:30:11 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey@schaufler-ca.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     jmorris@namei.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net
Subject: [PATCH v10 08/11] Smack: implement setselfattr and getselfattr hooks
Date:   Fri, 28 Apr 2023 13:26:48 -0700
Message-Id: <20230428202651.159828-9-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230428202651.159828-1-casey@schaufler-ca.com>
References: <20230428202651.159828-1-casey@schaufler-ca.com>
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

Implement Smack support for security_[gs]etselfattr.
Refactor the setprocattr hook to avoid code duplication.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 security/smack/smack_lsm.c | 106 +++++++++++++++++++++++++++++++++++--
 1 file changed, 101 insertions(+), 5 deletions(-)

diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 0b466d3b31b7..def13357156a 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -3552,6 +3552,45 @@ static void smack_d_instantiate(struct dentry *opt_dentry, struct inode *inode)
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
@@ -3581,8 +3620,8 @@ static int smack_getprocattr(struct task_struct *p, const char *name, char **val
 }
 
 /**
- * smack_setprocattr - Smack process attribute setting
- * @name: the name of the attribute in /proc/.../attr
+ * do_setattr - Smack process attribute setting
+ * @attr: the ID of the attribute
  * @value: the value to set
  * @size: the size of the value
  *
@@ -3591,7 +3630,7 @@ static int smack_getprocattr(struct task_struct *p, const char *name, char **val
  *
  * Returns the length of the smack label or an error code
  */
-static int smack_setprocattr(const char *name, void *value, size_t size)
+static int do_setattr(u64 attr, void *value, size_t size)
 {
 	struct task_smack *tsp = smack_cred(current_cred());
 	struct cred *new;
@@ -3605,8 +3644,8 @@ static int smack_setprocattr(const char *name, void *value, size_t size)
 	if (value == NULL || size == 0 || size >= SMK_LONGLABEL)
 		return -EINVAL;
 
-	if (strcmp(name, "current") != 0)
-		return -EINVAL;
+	if (attr != LSM_ATTR_CURRENT)
+		return -EOPNOTSUPP;
 
 	skp = smk_import_entry(value, size);
 	if (IS_ERR(skp))
@@ -3645,6 +3684,61 @@ static int smack_setprocattr(const char *name, void *value, size_t size)
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
+		rc = -EINVAL;
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
+	if (attr)
+		return do_setattr(attr, value, size);
+	return -EINVAL;
+}
+
 /**
  * smack_unix_stream_connect - Smack access on UDS
  * @sock: one sock
@@ -4955,6 +5049,8 @@ static struct security_hook_list smack_hooks[] __lsm_ro_after_init = {
 
 	LSM_HOOK_INIT(d_instantiate, smack_d_instantiate),
 
+	LSM_HOOK_INIT(getselfattr, smack_getselfattr),
+	LSM_HOOK_INIT(setselfattr, smack_setselfattr),
 	LSM_HOOK_INIT(getprocattr, smack_getprocattr),
 	LSM_HOOK_INIT(setprocattr, smack_setprocattr),
 
-- 
2.39.2

