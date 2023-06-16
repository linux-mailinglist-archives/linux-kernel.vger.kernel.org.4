Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6812F7336D9
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 18:56:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbjFPQ4v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 12:56:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345975AbjFPQ4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 12:56:12 -0400
Received: from sonic303-27.consmr.mail.ne1.yahoo.com (sonic303-27.consmr.mail.ne1.yahoo.com [66.163.188.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA8EF4C10
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 09:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1686934463; bh=lB5ScsLeZipeYbWB53q9EtR+VBviso3GISiFZDLC1tU=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=Xc8Ij6KPmF9jWIsBgq3+QfXQj0p5jf4b6ZZHhfb02QcHpfEGg+BULOK/M9onKNWl127x2EAPNWDX7J8Vy8w+ExbcA2bvSD/Pk9RdqHXvoWo3hek2T3P8jrJvObF8BW6S39gr9EiT41LnTmonJL2AZGq/Bb7cEH/JmZId3aQMlbF+/wnRWVNNFyt7F+aS9z4LY+KlaJNffXapOGWXvKcO92VpqGJmkRBovtXiELoZOA0cimtSnbvxLrsoj7RLyuxsS57YsRt5uy9uQpD7hNR8tLzoLmTHQvr9gFtdbvd5Lgdq2qCFUaT5yFdwQ1QAorgyCJ/eTifRi34u0vVGaJOvow==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1686934463; bh=rye4agGzn22BYoEahjru6FROdJ8+68lU84OHhqMDXwX=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=DhYUznzxVRbE0LGJGDrt7jfEZGFPY+2BUczrREuZnIEEZFmLohXVKQfVCY0DTM+wDFh18XFsSYIA/ZDx5oqR5ixSsJV2sUS9T9/tGPKTXchYiMRAH0aaD2veE5yBO9oWQtnwruW8hRfrZbr3TnPecHwChiilVI51tniVuuDYlCdhhPmgGvbC/oJi5Ovql0A9dgEDIDIPAQavYpW+jhqMU/Dl6dgfK4BpHFOQC0IdUFm233TdoNbJxVAcFGWKg6TSb6AJM2+cLPvC7yIro378jwbh49rv39cSooLmxmxEzLBkKw3N9Ba56YLDUlCAp5vwlUU7K8ySY9OonFWDadpPSQ==
X-YMail-OSG: mH8G8lYVM1lPnJg.BFfuhwVX.VP4fqPx.bhhIfvt1wBIxfm50aHTIU9hmEiigRx
 uM2SEFATfUFcbV5vA84NuytvsOILOTP0DWobo72g8o6fK3JZ1pWn1kT54gK8okWzP7_NJyMehPPO
 0UDsthRdCE1QJQh0UYvukH2XkejwK20Q3UcECbP41uH7URIR5wK9uQITUWVou8dIIOrqcrpcg0oE
 JSpYXyMHRWOv9sxjwUl9P_IBsTlZsP1RQLqevE4aLnBbVJmluxBtyLJ6xIPGLrCpSzIS4NRBT8yj
 PXSyiZ8b3hLnBrhJC_5lXag0ilUenJ4Go8WA.EsNibq4R5pYJhgHxT53bcRLfKtK4YGr4z4f_3Rm
 8YnfVETeP8q0J14Erhi5CNtaaLluRB2n.ys5GQXHPL5OBSs3ObkBXDIg5J82HmVfAQOrridVgusw
 6PvG7U6ya49bGUsbfA23quscwj5NhvBXSpxXlW6xDlY26huAPgfxrZLl3YMl0Bl6W5rT9vNKO8en
 _sJhvpUmgpKuVF4fEh9aTyPVZRh7v0SqplOx16Zd1iBftfkgvip18ZfY.6GzWXUITaHi1rTpH12A
 jSNcrAPObVUEP8IdhiXfdlSQukBtIkURaSuJYs2Q28xrGYjxenVqospyYmTAMu1voCbrYE1lP5P0
 0FAzQpBQ5fzZKE6aQc7PUfs.GroHPRrSFuzEyRTC8QFA8K5qnBmDNX4YId.ry4fUgOfsvlSZ7Sbj
 _qxpx0aAU5M3AjWfIMLsuveuTObaCyd3p0o4yO4JDsnGvbwvQJvdWQpsVsb.3RmocL1hmwMgQY2i
 3CfII172om592CKY4W22aIxD2Y8OXhQxmt9MblYWqbwcfJyQuJqgCC6c1hex0_G6OF57HJkwhPSr
 nA8X8G59RY.WFtVcNihfGAw.FnWC0_w9NxYj88vT0pPlDKQzgxjjNLrIbSsgkTAW3RCWaQhSMHJw
 6xv_p5Mib3_DJyXog7Wq8j83WycDHewMr0kaK1LlOtC7yEofiTkPGo35njAY8FSL2vEKN0JtBwiB
 DzIlkUdNHkZYin20sXxiJrnRs21Vta3LI1RNrnvQvu5G5F_CrJAxTNrKIjeNmE5WTl8c7.5NwPNc
 94L4k2lsohNAdAc7UIGBTNZr1o7fAV0k65Yd6ajUxGYtBlZGvuXRQA6Hk569QSpGxNZdd6uqns5q
 _EkvH3aAOZBzCAVzPanV_EyAKvsPB8pTBpUWX_MDOZTbPAMA8ENy9pJaqpeWWgURhzUfTejK.KPE
 Ffs_JgXhxS3t3DHbkbjC6vsRJUzFNxfVh010W9.t7t3eGuHnzlzY_F5zEbJkI7.iq2xOa9plYjUE
 aTuLETo10zWgTRVTAG3hDQYQV43.dByL7TcjNVohg0DtfZHKvGklWQxToFzSYfyWqWwiHu3HQV9y
 8qiIEPAuiF_AgmoMlbwaw3bP2f6AF5lXlyXrMwtkJIL_pQB7Z86W7NbGiJ3xXRh7CZVWIczOf6wX
 2qYR_U1LzLQgO21IdBsz8kfkwvVPMSAonUjrjcAlQbB4oNfn1h.0_zVv6GblQimOzpjp_BuWZVM4
 YU4LkNjjM9WXOqpYGzGwsb8M0AMnzTo5BKFCdQqeM.58rSzTjIZUlGKnrG5pWjLbNf55qA5qTsTm
 yy.3per2UeK828SObYck4pKCE6wXLl8R51MzANmAtSJloTepBNgFPYwdDLF_jRDrPDiU9n9VKT.3
 6aGde_nF6blEpIAuG2GhGnLhrQZoqgXYmf.UFSS1JHSSRf3Mad.NIk3F4cIZrtieDlr.vNyEyRau
 flzHO39LeL6Z7NTWY7eqfmU6FPw2jl2FlVAL_ucC7pqKY9KINQNk_GHl9zGA1Bfi9eYAvHitQY3H
 TqtShnERgOUXn.j2qExTW3jkq6U6f0fpjDhd.UtG.yPdu3ZX_qz0uvYmobLr0X9B3Z7tiicTWNKr
 k7wnYlKE3QvZlYpyob8NaOLUyt7cP3hHIDW7K4DHMNiQ1JUv9W9QQ0aGxgzy.oXJ4HQ.Go9T67Vs
 6b1sMS7ZTbL.ETr9qABJCkOnL822_eLfALydX_h9rj5t4v7MPQ2sbYSXeylUMR0Lxzcv7EtWXYHg
 n4kZavFBL5S9FrB7pEKfxudC63RiQldRXHTql2yjvN2v1xT7XglEY.bpHs8jO4g_rq2WAzh9iXKB
 NFU30QNNe5eGIIUItHR0dvoX3XpFNCGz5LYMm9n_nTJ31V_rSxTVh0peCJgwTGaHK9M7Eb83fw8z
 DqYJyaSNqJOqpLm8tpZD9ERDkL2qsuSZtu33g4Kf_a1RF9Dc3rk6MU_S_c.XAQhJy_hy5eRQlXNT
 0FJFfQtD6kudIVC.lpRnXDA--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 50f3c41d-dee8-4955-98c3-b1eb4c687315
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.ne1.yahoo.com with HTTP; Fri, 16 Jun 2023 16:54:23 +0000
Received: by hermes--production-bf1-54475bbfff-xmg9w (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 5d8e982db405aaa142ed4c0fa62627c5;
          Fri, 16 Jun 2023 16:54:17 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey@schaufler-ca.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net
Subject: [PATCH v11 08/11] Smack: implement setselfattr and getselfattr hooks
Date:   Fri, 16 Jun 2023 09:50:52 -0700
Message-Id: <20230616165055.4705-9-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230616165055.4705-1-casey@schaufler-ca.com>
References: <20230616165055.4705-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
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

