Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 411DC6DE04A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 18:01:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbjDKQBn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 12:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230449AbjDKQBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 12:01:21 -0400
Received: from sonic307-15.consmr.mail.ne1.yahoo.com (sonic307-15.consmr.mail.ne1.yahoo.com [66.163.190.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BDFC59D6
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 09:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1681228872; bh=WWKn71lrpv08tQFC3mFllZTwYCHaZAApwvOSNdmKIP0=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=kmXCCjWXxAgPgnSYBrmJw1VKxSeQhbExt02NPShwmWLIfwfQX7FoJ/oHa7JBCI8AqjYwPWmG2TviCfX4ewzdiBDynDwdZEGjEOVnU/Pt/xNEbgBvkzypRQVY1B8UiAi+rekgQizu1F4Tq1/EIhv0+uTuPXewU26wIIVAjARWJwYTyMM7r+a4CbP7FviTn8jaWxSryH70aYfsoqand6lPBSiHq0ZO5D/oBn8K3/QXviM91lhoY1rUMd9T0yx+5LAKYMv/w92th8xlbf8d3JivdnRQk0xFxBGiUmS6EpEM7JL8VBfy8YVAYznNJ20PoldD2WVPHw0TOvCrRcH+p2C0aA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1681228872; bh=kZ6Y5O5nW9K2etas3eFy+njSD+OGSaNSE0PtLyy1AvC=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=H4rGROfAvT6dH4WJhaKYkEy7YKgOz6W6T8CidJWPC2hR3JWmLrPJ8D6/BdEX1WnJdIikrEOwI2qXrf5D1rzkpXBnxcBRQFFcEvkfHlC0qwcJ78Qi7MVNPfmzqXYjx8i4gayYb3Lz2uVCvHATSK4qX75uGVEKkim25IdDrE7dVwwztgG9b6JPJQNsOFlgUlJtGpRL6zUzb1clF2OuF6AThcbuKrukbHaiid/mBqn4NN+arhbOBYtou1X9Htv2r9oDmFVCkJJUvupJt9AIGLryiEdDfTwpFB1XXOlhTJpyNakoJzxJn1Dy9kPriHa2JpW7IfLUFRI0cTUvRUqy+BqYtA==
X-YMail-OSG: KXP0MigVM1lG0a1i7D3qtSMY7A1_FdV.yzsjRwyw_bBQ8_.Ag4CuC52iPA4wKh3
 yz6nW0oQWbYNk3HLnikqsjsXpSBedRk772TpxvWRkM_gJxNM626__mvmnJA1fJf0PmoQ5AUvvLh6
 zYOLIEPvOgNxVxPMMaLr82bsXxUOq7tL0a_BK6bCp6jeFy1oV70RQlF4uyNKOBlS_K0aLm5ef7Gh
 ecm5ddE5KpHjKzdS1srwM_uoC3qDng78.bIxty6vI5v8R5U0WR1fFYHsUjE2mz8SEvP_b_Kd8GV7
 SR55HTy78KFtpASQIqErWTypKCeNi_D7Uql8F4MCSiGAJ_6p.eswvy4yKLyQ1jHNoezluawifmg0
 4BUZEJgcXUXiwcos2uLFflto7o4of67IQkcjwzu.g0FE8lzyK1JF1lD_7W8xnjG5YGvPGvEZJ.AX
 1aPchRu_UttOMbJ62xc2Ma7mo.wz50lsFeX..RTr.RvSfIBFs7Kv7JR082vCmzIY7V69ueEy1LTe
 hGEcZpjz0v0euz3cCL8xJidEDAaU6SZqKJnFgdM1qcWeynobm2ydot7KClT.19H_M3G5L7imFFVx
 VI66rTfm0SeX7BFP2B_rZ0c2G6GRQOiOt8qha7jrKYu0ULWn9Ip0xKVN35m9_H72a25Zad20JXkA
 cnPIkOrXhSGtbons6PqJJBnZ9kXN5iibKvi5WzR5MtYCN.Jqx2U0.belFDsQkxyLtCiyEEcQqc8L
 Hk1S5tA5Jq1yQ8wY2Rq.Y6sY1fAuKzWSvJu2susUz8BOdK5lXUpLzYuAQDUCRgqP4Jg0AMSyeUr6
 Ja8WYc01F2B444d.y0jhEZ6IRhUHH5DBH7sT7pzMcej9ZDa2NImU5E3U4sL51ymDVZVIEhYqPBsl
 bApgQfE1XNUpdchic7LZ7kOFW.TI0Ka9.66k4Wl5brlzYQrzxwMfl4nEkdcW00JCOTYyXmJDAEqt
 i_xoARaJMBqSbm4SLaiGStqm8p60d0DdHFd9L3VzMmB0VSM7V.grh9YTUqAMLKUKSUa023JUO.CK
 tk5bXiwPjNcCBCQdIJtXMNJYk2Ib1e3B84a9Xzo5Fbozg_5rBfuhcfW7rHynezpsW9e5Nrw_bbMe
 RCpqxiWBSVDMn8oHGFklUobUKPmmBgLqPXXP12pMrXyItgtqsDitUN9k9R0D329qCRk2ZM.ueBwZ
 ygK7cGyutgv3ysaVaqm0QOCAKpXtZkrOMYY5ikSWj8Lawk4sy_O98PoJN.xmsy7dFpAYSYxZ2EhK
 5plL7JBFVxyks8nVb3scwVnLfXJ_wooIEhuGnDNLKGcjxRl9Ju2xhKjA5fS5lPoZ3aLePNi.0UZx
 QONmGbioM6yUnfjUmzLwrJVNwt.2WeBrrgH4qnMKFlHwzEyuhe9VtyRS1IDHTfF34acV6OKRzGro
 g3Cq6fH3Q2ZF9cut1JhZiWue738LJ6WpFKjuVw.Vf.GrBh1j8Y7lNzSWO.oGZVz8ogh.k6MqqLLU
 qZvK5d5x71E3IvDJt0SvrBKLGB..fwJOfb911qgGmHz764LgJiv1kp1x9RA2Oe1MNAwNAqEVJvME
 kQkyKadJ25y5k1jWH3ORZBqb0BfyibqH4pfgJQ3eTxbjnCXFQJTnmp6_bTi4wkqpT91VFv44Sjx2
 I16a6342sK9kM1i1fMWlxcvNxrxQd3EyLhrzmGSiNBkIvj3T3TGJ_iP2uwAJolBfxeAFN1U0DiNt
 jHE69nrFT32yblLwHMjtR9U6EbHMTMAtQU7fpHJQ7ljC6a7IPLS05DtV4HTHurQpNIuOUvGgjQK0
 D1jbg0_3rtkHm4EcSXe.ZDxVixh9_YUlFIBGTCh6fKI6CX1KZODNjgeTw8Cfo.4lUcg0yNknpkhL
 TLDwLPOZ1SBltT2mTZlfGdiqm38hQVXIrpEbjo_cBYh.c4q3Feqc5RPxotS9juNJP5AejqEpr__q
 EjvYI9Egip12T4Nhfa6uNouVrDp9rFZYp1BEZfw9HkViabZ81iAdykZpNJzmJt79crM3.Xe9fDbC
 wZhhEjPRJaNzWBwlC2XqzDP9A7eazRC6hCgsbU9c47kD94FG85m27zv5tdIdHAXBCEDknrZXRjqf
 u13I0FCRh.Wqi7_K4M6pfRCrzL.wb7mjRduwvhf8Oic6gEHIZZ.n703Kmo4ZcZ6Zv3ZFI3Q8ikYC
 FDY3.VF119NMOcOtkkRMqZEZUgPIdlMnlAjLc9LWPNLQtxJ.2UIlU7Ac2aLJRrwomZN2gD_WfVTf
 5pEjoArOPZgMbA5OU3LgQdbrjgPBRl1mgfZIdETlcsCfNqQp9ealPd_N63PojXOrZ2Mqrk_WfOCT
 f_2HeJer6QVzhbPn2jw--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: a41358ba-f0f1-4e3f-8679-9a601b73b58c
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.ne1.yahoo.com with HTTP; Tue, 11 Apr 2023 16:01:12 +0000
Received: by hermes--production-gq1-546798879c-7rgpc (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 8b8bac55a2979a45d5da198554da66f8;
          Tue, 11 Apr 2023 16:01:08 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey@schaufler-ca.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     jmorris@namei.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net
Subject: [PATCH v8 05/11] LSM: Create lsm_list_modules system call
Date:   Tue, 11 Apr 2023 08:59:15 -0700
Message-Id: <20230411155921.14716-6-casey@schaufler-ca.com>
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

Create a system call to report the list of Linux Security Modules
that are active on the system. The list is provided as an array
of LSM ID numbers.

The calling application can use this list determine what LSM
specific actions it might take. That might include choosing an
output format, determining required privilege or bypassing
security module specific behavior.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 Documentation/userspace-api/lsm.rst |  3 +++
 include/linux/syscalls.h            |  1 +
 kernel/sys_ni.c                     |  1 +
 security/lsm_syscalls.c             | 39 +++++++++++++++++++++++++++++
 4 files changed, 44 insertions(+)

diff --git a/Documentation/userspace-api/lsm.rst b/Documentation/userspace-api/lsm.rst
index b45e402302b3..a86e3817f062 100644
--- a/Documentation/userspace-api/lsm.rst
+++ b/Documentation/userspace-api/lsm.rst
@@ -63,6 +63,9 @@ Get the specified security attributes of the current process
 .. kernel-doc:: security/lsm_syscalls.c
     :identifiers: sys_lsm_get_self_attr
 
+.. kernel-doc:: security/lsm_syscalls.c
+    :identifiers: sys_lsm_list_modules
+
 Additional documentation
 ========================
 
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 97487d66dca9..6f6525364288 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -1063,6 +1063,7 @@ asmlinkage long sys_lsm_get_self_attr(unsigned int attr, struct lsm_ctx *ctx,
 				      size_t *size, __u32 flags);
 asmlinkage long sys_lsm_set_self_attr(unsigned int attr, struct lsm_ctx *ctx,
 				      __u32 flags);
+asmlinkage long sys_lsm_list_modules(u64 *ids, size_t *size, u32 flags);
 
 /*
  * Architecture-specific system calls
diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index d03c78ef1562..ceb3d21a62d0 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -265,6 +265,7 @@ COND_SYSCALL(mremap);
 /* security/lsm_syscalls.c */
 COND_SYSCALL(lsm_get_self_attr);
 COND_SYSCALL(lsm_set_self_attr);
+COND_SYSCALL(lsm_list_modules);
 
 /* security/keys/keyctl.c */
 COND_SYSCALL(add_key);
diff --git a/security/lsm_syscalls.c b/security/lsm_syscalls.c
index feee31600219..6efbe244d304 100644
--- a/security/lsm_syscalls.c
+++ b/security/lsm_syscalls.c
@@ -53,3 +53,42 @@ SYSCALL_DEFINE4(lsm_get_self_attr, unsigned int, attr, struct lsm_ctx __user *,
 {
 	return security_getselfattr(attr, ctx, size, flags);
 }
+
+/**
+ * sys_lsm_list_modules - Return a list of the active security modules
+ * @ids: the LSM module ids
+ * @size: size of @ids, updated on return
+ * @flags: reserved for future use, must be zero
+ *
+ * Returns a list of the active LSM ids. On success this function
+ * returns the number of @ids array elements. This value may be zero
+ * if there are no LSMs active. If @size is insufficient to contain
+ * the return data -E2BIG is returned and @size is set to the minimum
+ * required size. In all other cases a negative value indicating the
+ * error is returned.
+ */
+SYSCALL_DEFINE3(lsm_list_modules, u64 __user *, ids, size_t __user *, size,
+		u32, flags)
+{
+	size_t total_size = lsm_active_cnt * sizeof(*ids);
+	size_t usize;
+	int i;
+
+	if (flags)
+		return -EINVAL;
+
+	if (get_user(usize, size))
+		return -EFAULT;
+
+	if (put_user(total_size, size) != 0)
+		return -EFAULT;
+
+	if (usize < total_size)
+		return -E2BIG;
+
+	for (i = 0; i < lsm_active_cnt; i++)
+		if (put_user(lsm_idlist[i]->id, ids++))
+			return -EFAULT;
+
+	return lsm_active_cnt;
+}
-- 
2.39.2

