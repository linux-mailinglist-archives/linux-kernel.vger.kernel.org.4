Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5103636A66
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 21:02:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239684AbiKWUBy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 15:01:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239605AbiKWUBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 15:01:08 -0500
Received: from sonic317-38.consmr.mail.ne1.yahoo.com (sonic317-38.consmr.mail.ne1.yahoo.com [66.163.184.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E404786E3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 12:01:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1669233665; bh=JPTHbEtDzTcWk/IoC5WyCw9rcLntJ6rErxAyipdRKeU=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=dmlqS0kQe0djrKrBjuA4d/aPak5GSNPoY248dyly+15I9bkgIgrGGEGD9cp89txM18a0actTWL3YVeBh2FT3Vc0Or+2iCgoOTO9lofd88WJmmRr2KiDxM9yeGLnD7hdF8yZ8HdbuILkIPiDQavzGu/Pq+lgIg+y6zSmbu//Nmy6eNmhAmhHxecd7DBOdgE8ejBSwm4JKJfSQFZjJOuWLx8NHDl+DrcPDtgjdDgoDOPzPKUAoCyIAYRtp3TgrsamZANMVbAzQUDY7PgQqMgf7oqjbaZPVVEFN5nZ4dOg0EJKofj6zMFRgLAN7qfsq2YdwVgN49lwUrSBumUuZYLRZIA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1669233665; bh=PHe9JGXXmYmYKz5fYYMpAJ2eUDMB8vhTKugusDKKUDG=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=tGnP6o4qDqZMCCdl4CwaWHw8kfpMEAnbj3vT6EA3+e6qw9yBSaH2RoNlWASrt91KTJuT03Pu9I+s1G8JklfZBlyw1R/ODgyWzRh3z8jneSz6//P52AnUOL5PCHExnPubUJ4EUABMbsAJKhZ2/cm5CKboNCtYqyR0/RKdoJf9xjhRNiFgs1RyiVey6WWYmI8ZmbSKS/HcnzqAxvebavP5fv3pnR9MQ8/BTKXOYRL3wiSvKeY83xnmfAE8kqPY/1esp4lRfjdDXHB59Y7tbehyOhK5qyLSFS8RHbGNfujCUSZus6bwclhy0W9q+cWhBxNsY7ASYTS5bwkwjMshiMwk0g==
X-YMail-OSG: ZDRlpNEVM1mxbtCeaB6IkBuiVi4BBsfRZEiJdTdv2qzlcU5eSEzs0YZHkjDKgnP
 HJrQgX_1fElyT_9hYOQjwm5pimk9ae82_8DdkBsUw.vtYdUbFTeRfL6K0TA0R4SeqSsFOTRdsaEg
 L0qYdQjuXE_s_I3cVbwIQH_2boWMMssQvpI3.oYqP_qwo.y1gUm7nr6URe6fm2BS1.8TRf7efFBs
 pDfghPDOkj37W3jA5YBN.8PV4tJ6BsBWMd3UJNYuOA9DbS6PnNoInagQ9joR.7ze4MvkOXvosR83
 FcCPsoxh6LMg51oIS2gI_jA4fGTsVg8D_gZPDVAIKvi94YSyZpJxKprMe5L7sSLYOsFJfq2_KSup
 KUzTR6pxlXxIDDW8fvK0eSXlxUagFSFGpcnGFUDcYc1b0xc05b6lco.bPoSvIrBBtIuiyLj2cVhU
 xUsS3nWHHFHXYNEWeL1H.6qrbyhfFaXTy2dyNALZO9kO2q43qEOyfbe4TmCdnK5AJxh7iwq9LLri
 m8MR3ZBMyEIfLCW_Le4HTN0hRNqANbMZLbXerYPcbZxuHC1b5E6C_QKEYQTFP23G2YDrKbtdOXpG
 kkgTz8H_a1WWYhJwvFBEqW.PYjpSiqq.VgPJARRMvBKihccAq7JXtMLfWsHwxYztiskw6L8ooFJo
 OgGWJcN18QF0Kg1522b7ShlKJIbpXaB4rAjjWec1P0bIpvWxg094KtycRur4xDPROLoI4JfEfw96
 XyFHWgvkqSMdf4kIhn29e9KKiLdR2MxbVAJLxiJWn8uQKp4P8VwjeWdYi4clgbn9LjO76FTUWbx9
 PovECGY2plVLatWnaG6jgK.an6VyyFIgwc0wyX6gqwdiFNsTHs3Y6lJcT9ra1VrIsFMveY1gwIGS
 dx4vk6BRtBlRihRriAwBDx.rlNVEK.uB2YP1sZnUD.xlzq91ZZn2T91ypkDPfUB_XyGcKpRZWfpA
 usPiwfj3XdbLiWGflQWMNEsM6aTSfDMW7DVvkcB9Ld0kubRx5t0ZgW9mXEMhXdYMxsV_RlGmPPgZ
 H6_EAaS0vnsmlEq3bozhZaBDhyBKRzGkHF6oJOWGqRNNN22bFs8kozZnP09N.W7uDDM7iCMbTLWZ
 3v3Vs05ldiRlOvl3S7.lTdb7GNtbJhVFSerndwqAEThOEJC.3FyV_CnHsrQiQ5aLzTo07nJObNp1
 DvhjR9iubt1skYoZzeg_7cfTl9ZCV.kgV1S5vRUqysF7pGlHd4KF9HNRdtQ.fZiZaE7tB0tNa4P_
 k1Rl1QQsPNtoMv7dNoxf9gt6M3ELjeitEXT2f3Sb53UmIFWK.webgPRzitOWaLjLV12tYGowz6sS
 XUMwcIcBROGXIwjLUxbWj0y.cxv7gM1bz55SWVGh4UCpl33Gqkeyo6iWid9IOcttuvPH3KuHUfh5
 hFOwp2CCGeC7yK3e4TggHnOMbshXzGGTwg6ohLTHD5saOvg_eI1heQfe96pNt3Ug2xl6LUvvmERO
 SIYqmNcHnCJm9Rfpss.KKo1rhOwa6lAoqf3rMURd07vJ3_cHI6zW9b5zQME9ROpzJdBiMIiPtbW6
 xgtm9NubMiIUZCaMOykEZguJGWgZ1D5RLkwX7cksxzhKf83fw18Zysj5S4h2ki2Zj3ztfu3n2hgS
 tWxq0UYM_FVYNL_XHgVuhFbXgxEQ0NCEi3wmapjkbLj3SrJ07aMrN6tiFuITkzKILAXMW4y12vQV
 sry09oXG8BHA2s2C5bJy0eROTBnBa.C3Xjl5PzMA4UwRh3haK3N0Sx6VMliM2osll.4F5_NqVh1V
 wGw2nH.gV8pizLoMFSMkZwsT9hmUYCxkGosx3MTcVxRwgY1FfjpkJKHZaNEz1XXtfk1uGihREBLY
 X1aEyT17hobR_0zfGF657imnqCf7CNltNVA2IpJvVGPviTZJbcJ0cC87ZnUHxUGoj2rI1WxaJrJX
 0Y0wQvDGf9OLBdge1eWgcPy6Tdc8VofDvmqMz3oNiJt2XRyGnjoP5sx4yLvJcrK4GY6hzjvIagf7
 y9a7dcrVxAd27eRKTxlx3gog3F3phD51QTa4rLnlcLTeAUQ0gQ4.TPpmqgTVqqXEaEOwnsb7M.rX
 lC4BBg5du1hQcYYbig5AsIf1hW8i3NfOWnSKEpc3zaQ5X50IhYE0w.CChuk275Gwo2WRF.6eZ0gO
 H3EB_tLakB2sgSLooQk.OLxNDfKUtxtXEcm_bNC1XkyXxgKQAk35.1q.YDYwOhHoc04FiTG9LSMV
 E9DhK.sYUM8jS3X2xLw2.0gzPfDS06ZD2yzD6GVAmh0jw0td1.9H.d194r_zRxXQIS6XdzD.GmwS
 LKoiCmnVpRcnWtueRGPrt
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Wed, 23 Nov 2022 20:01:05 +0000
Received: by hermes--production-ne1-6bcfb7fb87-2hzbf (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 9a2b4e210b8fb0ce0242a6033d9f3e20;
          Wed, 23 Nov 2022 20:01:01 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     casey@schaufler-ca.com, jmorris@namei.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net
Subject: [PATCH v1 7/8] LSM: Create lsm_module_list system call
Date:   Wed, 23 Nov 2022 11:57:42 -0800
Message-Id: <20221123195744.7738-8-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221123195744.7738-1-casey@schaufler-ca.com>
References: <20221123195744.7738-1-casey@schaufler-ca.com>
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

Create a system call to report the list of Linux Security Modules
that are active on the system. The list is provided as an array
of LSM ID numbers.

The calling application can use this list determine what LSM
specific actions it might take. That might include chosing an
output format, determining required privilege or bypassing
security module specific behavior.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/syscalls.h |  1 +
 kernel/sys_ni.c          |  1 +
 security/lsm_syscalls.c  | 38 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 40 insertions(+)

diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 2d9033e9e5a0..02bb82142e24 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -1058,6 +1058,7 @@ asmlinkage long sys_set_mempolicy_home_node(unsigned long start, unsigned long l
 					    unsigned long home_node,
 					    unsigned long flags);
 asmlinkage long sys_lsm_self_attr(struct lsm_ctx *ctx, size_t *size, int flags);
+asmlinkage long sys_lsm_module_list(unsigned int *ids, size_t *size, int flags);
 
 /*
  * Architecture-specific system calls
diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index 0fdb0341251d..bde9e74a3473 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -264,6 +264,7 @@ COND_SYSCALL(mremap);
 
 /* security/lsm_syscalls.c */
 COND_SYSCALL(lsm_self_attr);
+COND_SYSCALL(lsm_module_list);
 
 /* security/keys/keyctl.c */
 COND_SYSCALL(add_key);
diff --git a/security/lsm_syscalls.c b/security/lsm_syscalls.c
index da0fab7065e2..cd5db370b974 100644
--- a/security/lsm_syscalls.c
+++ b/security/lsm_syscalls.c
@@ -154,3 +154,41 @@ SYSCALL_DEFINE3(lsm_self_attr,
 	kfree(final);
 	return rc;
 }
+
+/**
+ * lsm_module_list - Return a list of the active security modules
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
+SYSCALL_DEFINE3(lsm_module_list,
+		unsigned int __user *, ids,
+		size_t __user *, size,
+		unsigned int, flags)
+{
+	size_t total_size = lsm_id * sizeof(*ids);
+	size_t usize;
+	int i;
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
+	for (i = 0; i < lsm_id; i++)
+		if (put_user(lsm_idlist[i]->id, ids++))
+			return -EFAULT;
+
+	return lsm_id;
+}
-- 
2.37.3

