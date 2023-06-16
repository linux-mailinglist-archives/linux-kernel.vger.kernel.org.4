Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CD6C7336C6
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 18:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345999AbjFPQyg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 12:54:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345716AbjFPQyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 12:54:11 -0400
Received: from sonic309-27.consmr.mail.ne1.yahoo.com (sonic309-27.consmr.mail.ne1.yahoo.com [66.163.184.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 429CA4C18
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 09:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1686934358; bh=a7U5kwce0MDhdLD5TI5KgXeRpWWUTH9I4CiTtqUWD1k=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=fpSYqntLMg0lBxTkPVPQ1X5G4agkRaH5m5OrHkWgLETYPNhYYbjgdw0Rf81+35xnVSK6YaPtxUNmBMoP2eUzhOtZVDmXaENnrceVVOjZuUEeElZPJvbmBiUaD97x9kTWwkgW+i97D1wXknX+9A3AfB2B37agz+8Q4nxxLmVYGgGs8fyXL+gaQqV/enuvezWD6sov1gNyCR4GqkZaMH1KWkaplWQRcYEP5aZT/w2Dsg4iY/2tAgfdOmEmIVk6iz+uugIy4J2W7VaCqgR/yPrpXwiAhe3i4S7bTV/frgxDKrq1w4zfurNBN0K+kJZ2raaaaxI1VwdVH8WhmNiwp4+OkA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1686934358; bh=YphU5KR5Hg8e4cmicgkZI/+gnwKjtnhUYJ//Uc/kmSA=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=rcf86PE7uNwCh6hW4a4RQ8Rhspl7haxb+DPecG7y2QBf1v3aG3nOLt5Vv0OyX+3RliaTdOuxmRBSRNOqMpb3CUEzN7+9DjZdKuWM1j8FFeewnfeNX7wRpJoL5YndB5YLBQop/u/yhvK5+CdcWxRBITpEUq5w3vCGZI8dMGSUZK1YaIZjZGpjCbxSGQgO/kgLQw2pdt/QqSO/3efFl6sLKoctHYKRy2yF7x5RAz6jo8U7pjXBa4zceTHChkUhmhTbcK0qO4WbbrhLIz17x4mmydNb0zAEPcr/0rxG2otuaA4s805Y/qp5HtncyAxH4oqWs0GcbQ8V9qh3QwI9HqGJ8A==
X-YMail-OSG: ER.NFd0VM1lfe39OZ2bRl2TvE0CUIuiYYvKfbn19dtYMDjWGRnx89avom.jE6.p
 5OiDQ3CLwHX4ZdjHOvD0PGJDvd_n7lyre4f.WNo2NDJnoDNnIvDlGtHMsjhcwLy_Xx8Ry7al8gaA
 vblVUviYLeK4pi472o5jThANHutacM6Nl7M6WUw7Jxnhl0muvK_TvKM461pyGM76IvVEa70tr.qY
 PJ9EXDEO1uJD1bHPOxm8zfFYUv3L5lh3KIRmQ6krqphDlKo9HYysGEJrPUzHyKxsm0I_YOI53Xee
 BEfB.xEr3ffShd.cbxoA0jXKdkIZg3s031rv1KPJ6Lz2QVafASR..hIwtOOujnqH4KqqTgSE3PDs
 jJcHgus.HZ7KlRcmSoG1b5SWsO1wQPmQc9OMMDYiqiX83ni_IgoHcJpKspzB3ukvUuz0lmvnsE6I
 XRKkSl.b9vCjJDMp0NdyQMDjJfdadTNH_KLGB_yEhzpPwto9rFLptWty2WFypJmQzfKw4YcusAnM
 1wmhMojdtYkeL4kWFHj1LPU8B4vHy1J6YpXzdMvA7Mz6B.NgR8_I9IY3Pw.J1ObG.U6VpnzLtAzo
 ht1PCB4UBGShCSU8qHjdE28syKw35i2s4P8yf9sSWcUd64bMICHORKEzRuX4l1wKG06V5PqphV.N
 umegDy2ibunl4H_PvNHoCsuDd2EbW2z1tnpFjne.LL7uy9ROyWNAKWyNskMlYsYT3J_B4oo8fgyY
 Vpma86Nunb56BrxJ4CzMa9vWVLmUhDv2LB41oi8sJJOZXLuNrBa9cYoAmAQF_JUSh6iwv8boOUKT
 vFBo5xyapY9NFkd4lu5LLDph.LNuZ8twhom71BnpzyFeQsQgyW7bHIvJOepPbmWYZKty7MqgNCBG
 W9f4Rg.ceRikRvmcVY5rc9YkyPesHmA7cITC57zwMsbOpAn9SrYsJBYqKrT3Y.Jv5BxrK7zazgRB
 ndU7UyUOfFyCgpAGI52bWSC1ztHKiAfA_qDa2rOK.Z1FiyrXi4.HfmouFdNdjVMPsNk7RFWvuGX1
 IfrdhrRX9vZxOU75DBiCUnNI4bYdUuIwLBisLNsTSw6L65mcnuNuMAKureIAqrGb_fXNhVtR63nJ
 3xEcmQey.sPTgUSVBO7vRP8M.eknmYSEeA.rf8ni8Gw7JpKwSZgB7946WdO3VzSe7bmJOfvPuiES
 pZBYIXgnxeGSWJl1qngL3XcJYG_g5RZD7njsXU.Q8TuSrGfA604lFm5dwr6RqMUXw2YqFhT7ZXQA
 eKoEtf2giyq2zeaqgdyn_nu2JA8DvQebMeO_K3kSJkBW.ieJ6PavIHGxd.1TFiSy1jws3bCmfPRu
 IaLaNXNcf3vX8mEd3Lf8HjxR0MPKc6IwDJZXH0xZYImsjUvPOfAtPPfrtJZGUYRWpOp_k.rL4._e
 5v3f8Z.RQDv59BnNm9o0irqhWE7w9YQposmwOrrkmwt_IVkRndhCgcmG83GgTkWE6MKcYQJ9viaX
 ..rM556yhsbrp4ZWbuRMjc2R3aLOpexzfwr.BwNP9RVJbPgtUG32Dnx4cZ.cUnzZFb3zygkf4vzg
 2byWUE241w8ZSVdUIIVykpdeRV5GtERfajFcSmGLP0Z3LUetFkJCI16CWogb3dxvBrCL_zNkCVch
 4ranVeCyWHHo5zkTYt4Jbs1N9CTaook7RvNYBSShMwBJFjBko_yYjr9J1gtB7deLnHm6vOfCdU7l
 6YnZHTEJmCd9fMPV1GWRwPfi5Ydsq_Pa9GWY7KZoGhYCK51hRhtxvPee3uiZtqyyz0QBiEZy3sCG
 l93FCbKazQWajJHYIfI_MRGnHsbkKke5Z43etBS7CVocUqXpowBIOLh8fC2MuMIyhTAJCBhdkwDr
 bxfB6a_JhZ.gerYk09GTWaPZVVihibiq06UgZ18f4BR6nTPuAZ.53kMDF9XVQj2Nv8b.ZnNoBhRo
 xiLYJJr2tBHoP1kTV6HSD2yJw_unsNIwpxnJl73M95GBq2utzTlB8w27wOwexANDXsaIOPh2YB0d
 TX_5Q7GPxO30Z4JpFD.LyPR3.8h.1voGJF4h9oVmeqcxlfRmZVxCCTsMf1xzHMQ1y6VkCJwr.Tyw
 ODGMeXwhthmGj6dzCfum2lkJ62GSNB5LpBIt3Yt9UOObqEslND.UCT6belEiqoVc2kFhESdTijCo
 4z3t1VE47F7FedsmI9iaGvprf.gIyo7zyQzC.hWA2.cqaEUQolhHjYDA.dRq5cKpkLdYyx2nsHOX
 W.7uz6LFcoihAm24kUQKLS7l6CnLYi2WjhUXcys4-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: af51e64a-94d9-4f38-9baf-a8101001c30e
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Fri, 16 Jun 2023 16:52:38 +0000
Received: by hermes--production-ne1-574d4b7954-r69wt (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 46e5733d7b6da7b60f76f64d6170c2d9;
          Fri, 16 Jun 2023 16:52:36 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey@schaufler-ca.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net
Subject: [PATCH v11 05/11] LSM: Create lsm_list_modules system call
Date:   Fri, 16 Jun 2023 09:50:49 -0700
Message-Id: <20230616165055.4705-6-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230616165055.4705-1-casey@schaufler-ca.com>
References: <20230616165055.4705-1-casey@schaufler-ca.com>
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

Create a system call to report the list of Linux Security Modules
that are active on the system. The list is provided as an array
of LSM ID numbers.

The calling application can use this list determine what LSM
specific actions it might take. That might include choosing an
output format, determining required privilege or bypassing
security module specific behavior.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Serge Hallyn <serge@hallyn.com>
---
 Documentation/userspace-api/lsm.rst |  3 +++
 include/linux/syscalls.h            |  1 +
 kernel/sys_ni.c                     |  1 +
 security/lsm_syscalls.c             | 39 +++++++++++++++++++++++++++++
 4 files changed, 44 insertions(+)

diff --git a/Documentation/userspace-api/lsm.rst b/Documentation/userspace-api/lsm.rst
index e6c3f262addc..9edae18a2688 100644
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
index ee3881159241..f03f2d17ab49 100644
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
+ * @size: pointer to size of @ids, updated on return
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
2.40.1

