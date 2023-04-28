Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1D746F1F8F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 22:38:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346708AbjD1UiE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 16:38:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346524AbjD1Uhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 16:37:53 -0400
Received: from sonic317-38.consmr.mail.ne1.yahoo.com (sonic317-38.consmr.mail.ne1.yahoo.com [66.163.184.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FF75358D
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 13:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1682714256; bh=LTS1pTx08eLAAQC7xjCKlQuLiNjDTRWf5GssFiZ3X3Y=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=dXmCcDcZlpul7oDWsaUE4GxMNOLHFh8giIOStCCnhJ2WQglmiHNzJ6mg1tD9/82G0nxITAdKMc+dQYg98H46/Mzm86rCVpxHCd9oll7EKufah4SpECPw4Xa+PGofK+jLTeMLGidXhCcXhO4EPHReXNmfD5scSEVa4reCyjElzlbkIWp0H70cjQdO0uAnF2rYso1/gLzz2ONtyaR6F+v72YTI3q5g8M4N6KcaZmL75xCZPrywTAYnTkdwH0BdqtoSM8YWFwHiCZCo10Fe6HPPAXCgqKO+9Cur2zGpN0jM0pCitCyX0lb08/Yu+fsP9sg/P0g/9XSUqxAsiWF0WSs/0Q==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1682714256; bh=070TMdjvPQoI38f46t+p440WNDJpZ+/IkWhCfQnXmPY=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=WapIk/yBjiL2I6JHvLTgmXcpd04+6ti4guy2Obd/79In336PiVrvLwaXwgMNsWc3v6LM3F3s8CRWg88J/4XVFLRfZravDG1dwgFIaJ+FEk7YCS06kNLhAG+fNkX1MUSOl5VH3h8BPNdB+S23CE7sJ9YxjPgWTndb8y63kzgavEPkf/dVmIRmc2cGY4JHxaQOwU2Mnzb8u2gvmKkV2TXE/0bsuHoVocl1M3tAfQEzobRPPbLOc0A2DEwahChfHQN3sUpsRPcwJncBZblAursVzBTuYlYYW14HBgUzsAVqPsm0DzFCr3uqmJJjywxlz+NcLoGIEZt6/nS5ca3K2DabEw==
X-YMail-OSG: KdlNMCMVM1kFzMPptQ_TfMAB2kgg58ysBlmoW_Snia4jc6.W8D3YP2Ub3Nh4mtz
 IYJpy8b0T2DE8BsMr4iRbCn2C6wpt4XBQqgXnYP1uYuQrg.0VQdjxSOeLjkrUF7Wo9SB2ROY2m28
 BLb.DnALQJktzsbwfRZQiVBeLI7jMLKpi8bynejkJ3etHUoC2nlrNJcA9cHTNtMBae4IdOaAVk1m
 J7nRLDEsoWFAcx1l8vxXEbuokM84Sy0VAjKglgOUcGuIJcctOp3PPV.QFPxHILwvXvl24Sex5kQk
 TGLLVnDzrYlxIf2JKs1a7Oensam9e7W_REQdlbxrBPdSii6Mhd8ebAJF6nDXocMBci6fKZE4ABjg
 IEzaqg5lIFvtHmgG_ntOxBdoVLVWJnB8AQ.vmgtfm5K_JJKfe0lmVj3fWGHHNHcMNHDSC52_Ewvi
 HydA0d_zoz3d6yWtllYDjyfuZyPfdTm85wWkj1yjniL076.NsFX5_4.SeT5.GLIo6YrapBVUAyaL
 MDjfWsOkQMSdqoywjDGbvcuM3VmleVPYx0nCmy2hF6n7mt1dD8b7nkgPtIgX_CVkU4pTYgH1ScWQ
 ok8eTMdXiaYo24XkSi1OtKnRfzsMKmJUK7oN0P5P_W3wYOEtMeSWLuDWZfIodIG0qvEmnuH5mm.w
 y08OquRK8L6gUlc9gfSmb596FK4DPWX4kXyMZLPKr8nS98zkiAoKsqoE8vWx25D0fbcfvqUri7r5
 UY9bHEh_3gBcxWCQ7AK9XjoVWzotIge7zUVSG0EjU7cPY8le9O.O5zcjN14caZK1lEewP.lkdkP.
 fwwMLZySetViKCRujCiTYO0F.vqk2GnFXD4HKxXWkDnE4t2TzAvLKd09XV6mK9qkR32lK9ZCYIYj
 S8bX.LpL.71MT__YKKvaqDwtfwl3C8aJBsx1v.1qU7eo5AwLiJab2f3O7hxaCTebQKde2sgSNsck
 kjCDu4Ymdhrjc7aQTc7oi5AyDmaEqx6xbyWnMLt2meZgoAYcUb0OTLD8rsheZOmEqhxE9JuBEhWS
 baF2c8631RgGcxzQMCoUWgxr13sZZwLocZvQ.6zStGwHzndeyL3g.YK8o.KXPau845Y_X3SMJIMI
 eUWXTrMmKnC31rCY3wirl0hmi1uUQ.8gfKDD2wF7xmbpX__0AulixZStsTX9xFbTL60GBfp9hY9F
 PzPQJXFqRrGyP7vCgx07jUGtfCuOs0teg8B5YXog_g7HYMWvCNhTR9C0HYoxhnM3CRS17mE4hg3o
 h7R06e0FaqrpBlvgO0O1_Z3A2CVS3M2kuwQqp0jDNHP9nVpGGcfTE4yuGXv_gKEZ_zHEnm7r4Gyn
 HN6kdkLOUmq70B9HEXe.xOOTanCp_j5RlPNLZyOOD1Vqy4oyWxlspU5nobr7P5ZcVT9RdU3NADoU
 5tWnvm.6lNOPP93CXwVqK_YkkYHznQ6cc9IW5ta8YasIt_ZRdqfRsHVpiG1BMHzp96_eCYP.rNKz
 64iRp1OxKaDAnSpAY7LCcTtczcTn8epu8mpCsczplSLdow4.s_00f0QpHcS18AcZpyUFmi5.9P7n
 QutR_DWoqThQmvASRMASuLvAittey9GG_sg_E4XQXTwFCI2FEKMvJ_xioDNQjwXzxemUE31mQoci
 GwtragiHVI5O1sRRa4xB7GgWhPHV70XZaV2bRSBL5fAqRBQ2InGUcGmCpMYM5y.SdfDPgg3PpHL_
 keh0tuyxt0.uC0NdgFPzz1gxt4oCJqfMV654xh19KUVk3oADbKOFYkZEpr7TcS4yValP1r4n2nWX
 JTVYuDxmI7IKA8DlbCSaTKA.7o2qD_uIR3kPqGN9sHArswoD2YoPVMZXlJ.Y2RkBv5PvrKNdB6dn
 9nDCE8gQiWEtJoIjUOHWiRpx04ACIlD94c6kv3yAEmz799QOpjMA7My184vni_gh9gD8Ulx_qKmf
 AcS04pZ98irKL9.fNCJz56zeNRU0xi79EVDxvI992KJkSM_DTz08BKj.mU3s6DtXvsMzU8XYY.rC
 69wK04TpDQoVNVQEMNOuTOpkmhQfOCDYDM9rr0UTklEJKePjQy6wIF6DhSDxiG91F1Qz4J22zU7d
 aln2JcwU1hPJj5.e5CONw7ML53LEOWNNxJcEluIYwo58cNVATag79jeRWc8ijAeB5U1I9eZ6X6y.
 TVN3_IGpxybtU9NvFXy2JqHubt5ChfIv5.Hpf5oii0ujWKVD0NUaKlifw1lzdT7P5GU9JCtG11o9
 rFihe_WKTFiAVmXlb5WTiIGnKIvxJis0lLEu3MiYYKpb0fiKy0AGNaJgZReUtNlNeKa3P0rpRz_n
 OEgcfCC06jcuUepX_gc7rNwP.PXhdgg--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 5606c013-a946-48c9-9074-0d9fcbce0f96
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Fri, 28 Apr 2023 20:37:36 +0000
Received: by hermes--production-ne1-7dbd98dd99-vd22t (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 7d01bdce50daaea0f4f6c5183b4a656e;
          Fri, 28 Apr 2023 20:37:34 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey@schaufler-ca.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     jmorris@namei.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net
Subject: [PATCH v10 08/11] Smack: implement setselfattr and getselfattr hooks
Date:   Fri, 28 Apr 2023 13:34:14 -0700
Message-Id: <20230428203417.159874-9-casey@schaufler-ca.com>
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

