Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A08276EB104
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 19:45:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233499AbjDURpU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 13:45:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233409AbjDURpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 13:45:13 -0400
Received: from sonic307-15.consmr.mail.ne1.yahoo.com (sonic307-15.consmr.mail.ne1.yahoo.com [66.163.190.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D30982710
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 10:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1682099094; bh=sXMFocGT4IU3oQGqbQmjegFkHA30O982nX2Of4eeqSs=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=MQSjcBcQGVQ/b7CitAhGXQ3EcrwE8zsqrLNt0kGevGxVFyHjFbvw3TL7wuFEFmJn/P5EfojEhT5EGRD4r+AYsSjc1HgYgy7IOnN0yQ4XTxiFgHBSwtxu/s25LTZ4Y9UydBZ2pras49l8YAEFpmm72pD/IAdJnDcSj9XHq9wVFwjNtc5fjQNukKhyLZzf/NAly3q5fQXbhDU1xzyD6xsh6ULukW3zkd6wqnCIY5p1bfSmvrYDzhCnEMy4GmAmqJKxshwhEEGGTZIuaU20L0S6fAVLjbro9QaXDA98ZSSgQ4k4HpZBSKtfSajP1OJXk1J6ZOZETtsVapNnwQGMJjwStQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1682099094; bh=i/j2jesteEMBR7l6UFdy5zmzcX9E0xc9Yo+6QNDFp3L=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=KBBewXBYMMj8VNXwWG+Q17ralokzCQSt5vzBg4mYO7Burv94ORDEx5mn/DjOWSZfpDBc1Zk6hM75ITbYdUo4W/VsmGUoz9wGf9YdfDve0JA3I0wvmsLDnez7Jole1yE2c1Mp4QGxVQJl6B259wtYn0KDFz2M6nQS+2hpwTw207wdPVHAG4JkaTetZiIjoQpPWhAUOvhAUlfwRKo3OZb+wymPFIru3T2Moa1O8mq5sLIRvppwZnVzD5w/XzpQBTvMomWEzNViyg89uoIL6O0WyRCpmSFQtxKBB6r1Ho8LixUv/dJHpUkNU5wz0SvhopWSKZ38TV+8M5ImR17hRgwmYQ==
X-YMail-OSG: 0zuD74AVM1kWxVhTUwTNt1iSFlsBoQQdcDiRDUHnbsR0xS5x582avZcW9dXntLe
 mw20bqv7lk7T48irRoSq_eoVpEbuE8E2tcWfAfs8cFak5LPDmLmyC2n_5KIJux8CP_cm9Y88BM7I
 GqqWt11bk2iFdjFN9EkE4wekcgMncjrZ9.XeMxcEXrqcw4ltmr6JkI8jQ3jtWytlK2wmfKw5xyro
 4R0kJV0Xmswt37Jlu5hIUWUrDDqhat47sk8fIoHy5yhqjnce..Necq_z187HTTVTvbVY7j0OQFF7
 fLRewaYUda2ilMh9i0uQCcom2zxmmmyz2tRblfKgvIugv.CWCcKhZtY4s3CO2q4Lfsa_cDd0oTnj
 9mJE.pW2XjC5GmZpQujwUkHYcqn4x26GGWNQT55OWq6w0NDb5Uzeu.Q.FD7XJmRLwOzMAN3G_l9M
 fjtJ6SsTlc4A8aPTVnrAEmKIQM_IaBRQ8rYQbqehUr0nVvXWRM10Ag47f9UTYg1nUJVqtS_1wGZX
 0EX_EEABRsHaZuYiqMovlXjkreFKGdHu6JikxWT.25sJDzc9BP5kxASlFvcD0WmXpVqWuiGBPdpj
 FDMqigjxIjc6va4sUt7DRQ9HEqW3dTs4MKlUzrJXMAY76m1JOMEMbLTfOICW7ASLZPo7XqQibU0a
 jBtSEV1QX4SQfdkETAiuvEZ7l5FvLZDx3bRJDWwNvjK0HM33Q9c_wZEr1kvt5okMLE2sq5KIQWKt
 y0EBGudIKQ9PKBEAcR.TfwXeBK6VQu7Gih1fXaBG4fPFXUisZU00vMZjUH6HFEcR748XC4C6Zuga
 PDtR2KHekNKs1mnQcfpeBgNVz9QzWGnPQ1Dh5Y_ecFTEFjSHSBoyfywDQZx6eC.WbmORm6OLJsdF
 .vynGAtYv.bnZ2OYhZBM0Hd8HNPhiByoJ8HQZBbnDGHPbr7Bqd3HgObtvFa8iH0WXLa.Omq__jx.
 J1Z__.n32Vy1Ypjca5GIhGsXs5asxRK5TMrkyZTpaSLhrBuDaDy8OSzejyRZvum5JMbO6YP2i45Q
 DV0ARVMNFwf_eGVOEnmfykPxvbLEGu0AudzMPIKnr5AkaZwQc.k1loImB8jEKlZPMe7_E6AnXg4Q
 y1T06d5JAav7MKfwdlscl4tEE728s0AYrfFStcGnLUBQe.3PYxZOmuJWptCByqXbo9iOb9NVAEFm
 OqYR5ZaRWC.WSDkooPkuUcgr.KfLy1AaBb5UvbCTwT2UYfzlz2kUkTR2CwPJzP36kIRiE1Dmzezi
 CXI6EGJ3anz.sPmuwywhKfgNV3t9_jzjsbYtGGgTtBCN_Dor7Z58_WumJHrPG27d.e7v62mLW_HB
 ZbggQroOoDQqS9tWtorGMh29Iidp8EHYj2FqIC3MWjuC6DZ1qtIL3I8q54OfK3AmhIuCIHyBaSki
 r5VRsnLKtyUzuNNe2xrQ5JsI_V0yQf6rmvrSK3eL4AspvE7q72eQum29OXPCUC4hVI8VNHOONb.V
 FcsY4iEX7gXdbzJzzm_gPOQefd3CSVMW3VUQniIM5ttZiHiKCwraGxJJ0Klx26Lmw._Fv6mDYq0r
 wQs7.hxpTS2tZyxtjpGnxRCyVAUvD5y_6iP6KN67guHveIROxm3EIuK0zNHulMHqckiV5FwsBm93
 pCwcPxRJIK1mhzuVju7BNbLPeAwctlPZTfSyZPMHK4pEkdrcRkeDQCGzLrXXpu1A8T84N.NrYnpD
 PKUVuOhgQIRqYKXcZw_1XYBnG0leupB.sTird0afNrSGlqa9xtZiTTUjUlxJh095ZGnLxi_9Xbya
 j31Q6Nn8Xr.IbS9uiUi8DcIP_LOzepCF2J2polgYEJx5C_uY2riDHWFe9JS5vQSwDRS2d9D9K09C
 o1bV3GUXRjY6ZEAXNarxlU1yWE6dIonb3wPfzpsuyXPit6c2BrKjeYmBpQQjK8tI3HUnmgjwJXcT
 EuK5aL0kiwut7F2AN1Utjk5sld2jZaK4Nc7jCMCo8UQLtfIiEvF2GO5LTqtwVMuqooruwHvdLy4M
 ndu611dGzAKVPXKb.mOxFB0G3gNd6WE95qF3KtRfjL2mR6kLsUNYlAaaKy.GpBrTneommrUflWIe
 rT9O1kdoYYosmRCbzzbjJp4y1PxfO3eks9Rk9uIKPVHciD5KPhIqmm2JaQRBD.yfDzS_340gwEw1
 vK_FMvbtIx90PHmGRiEcIHn40ZyreRGVSZh1._NetqiSeEUArKg8nQy7J3v2IrLbCXH0OosEoXrd
 vM1U4RWYmIsU1hCnsT5jnL_sdzRddH0zpoxvp3NeaZd_L99Jz.HbvCmr9_LwbvFuDmZjYifA.WIn
 q0AwZXByWoeOmgEtzwQ--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 4cef924d-03a3-4980-b663-70bedecedfb3
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.ne1.yahoo.com with HTTP; Fri, 21 Apr 2023 17:44:54 +0000
Received: by hermes--production-bf1-5f9df5c5c4-8dccp (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID d2bcaa4718843a282c96eeaa4751b090;
          Fri, 21 Apr 2023 17:44:48 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey@schaufler-ca.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     jmorris@namei.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net
Subject: [PATCH v9 05/11] LSM: Create lsm_list_modules system call
Date:   Fri, 21 Apr 2023 10:42:53 -0700
Message-Id: <20230421174259.2458-6-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230421174259.2458-1-casey@schaufler-ca.com>
References: <20230421174259.2458-1-casey@schaufler-ca.com>
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
index 9a94c31bf6b6..ddbcc333f3c3 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -1063,6 +1063,7 @@ asmlinkage long sys_lsm_get_self_attr(unsigned int attr, struct lsm_ctx *ctx,
 				      size_t *size, __u32 flags);
 asmlinkage long sys_lsm_set_self_attr(unsigned int attr, struct lsm_ctx *ctx,
 				      size_t size, __u32 flags);
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

