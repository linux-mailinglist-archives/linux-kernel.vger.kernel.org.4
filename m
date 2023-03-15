Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EF186BC010
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 23:49:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232564AbjCOWtN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 18:49:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232468AbjCOWsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 18:48:53 -0400
Received: from sonic314-27.consmr.mail.ne1.yahoo.com (sonic314-27.consmr.mail.ne1.yahoo.com [66.163.189.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF77B5C12B
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 15:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1678920530; bh=y2ulZX5HPWLjVTnkJKznPL5ti+mZPGs/63iAPQjgXrE=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=Q641/elMvTEptBImUUm0sObbu+6xJ1Xd5HJEmWyfyFCJSjWUhDaR2+11MvNwmuGiAB9bdELnGJ0EIkLFbwwTYuRIsRLHB642xoagCf4WM4D06E1KXE3rTrhDRvbfy1lmfB3HQJrf/mE7NSg91rZ5xK/NH/BTmzi4Fq1YuJmUGRKis9Ul4nK1bQrjZ/dbWF/o5DcT5sA5UhwCsQH7hU+q7fqpeDBO3yPIDHedCgzUd6hZ+IJTyTi168EBNqQ/WkI6QauSxsVSLuuVs7qnkI1V4utoA3TbaHBrAOIzJJGp3oD8XjRtw6XgwkeTGd3JLsjjS1wU6AbMbaNZs6DSHkx2yA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1678920530; bh=dsiqecXhFfYD/DCDjn/KlQk2FvftMUN5mUrKLqDj6G0=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=tcJNPIB7Qfd93CdWiojth54lmoAH5qVwa73mwsb/WT3urDtMAyS1kN6Dw+irLkEHtfHfJ8+rvYgnImVpJCfJ3VkZrJ+QHw2tJeq/g+oaPzAPERcVsqjLHPKUxqq6GtggwSanaczc9JWOcE/6+D+kKfonyaVUEVKjnYHIjegiU0aSO97NYHxLzBKSEnyCRAsPeW94BAJKfTSEY3clLpkbM+thTREqX62/1pfpTUe7AVmsALEMwRHsTNgNxw5GviVDWzHiSenLlmuRJxVnsv27G8icHW9a8/zXg9RapOq/cGVf/h974LhWze3bpT/lk4kxX+qYsciwGs2F4pf64xHkIg==
X-YMail-OSG: Kuw3dOsVM1moKQ4kFti9zwy2CqiE5mEJtgcmzrKHqD8xMvtKrT5n3J_E1G.PeCm
 kUD8neMqQdv1bM7trGEcgZL7bNMSImCRGv_Md3ZiryVLQsvd.F4_eizcYiHm_YtToYBdJqncz1AL
 lhg4RrQ7qzwA1HdbtMzuMZQE5M1ST.97OGtVh1GEUcIOcZfBLcwE37up9uwyc8L2kFT2gLy1Z1oj
 7sDALXq9ken7PErHCDrf54vlfIXQAM_089r29GgUdB7HVXTGPuElQ23Q3GxdDu..wtPhTKSlHqZT
 LR4eOkGAgcn2ialTSi0vRtMdTLCmZGg7JoEsFoRtW38u61ummuo4UM.5R2fkf2k3CfoZUitP5FZ_
 SyCXsvWrc23vHzSDK4VXArTgmoIpdR2m3Vafi5Erd1_QI2cV6uLpJmT92PeH1hEblXbQ1R4Y00vG
 Oc4Otr_Klhq7VtWW8We3pbJapen1JYTRNtP5DAK4cPbshq9cc9zyb54CzkwuKWG0nwNxSU8JiVEh
 5XxePT_1FvznHReTasHIb4tln_EfiqMUcpBmLbF1x2vuyC9vLACRearxYx8KN9LsPdlJHYjOCYIQ
 ksDe6562dn1a60ByaHMxcyWFloI2qslOHUEupsYTpgUrk05e4Ku0mfmzRxXa1jWMADnz0PZYriwP
 63P5RSBLEWBwAwoXetlLOCwhJ0Nm2wxogn3vUV7bGZni.gHBzeWJMmz9iVuMehmLZd6ZCcTrUJXm
 l0i6D_5KtBXeVNAKCweYpSWTZPuvzDyNhjEXGfBzflHuCLsgFzBpmtgBeKEgntlXezWapsQrMYdb
 BAlVI5.ZiW2JhBr8X6_euneqkRZoekJu3OTFjRuoXlnJDsUQPG7tlcgqHhYD6DhqXiLrmhrs3gdI
 AQTVws_IpR1kUSD45l66N.M7OC1fsx_22QtZXAqVw09YClskgPJIbP5ppMiT1msLlucufRXaT1be
 LQKDRn57CrweNRq566kEhNuTWMFGhbcpcWCYG1b_SvtHv2o874_xwvA0xjpQQSy.YvIq_4cMxPzg
 w9Wkf09MsljcAT_KgylLjuwuxMWz3RtvGzdnTtPKIQIF8Mjc09oLP87kZ9S9rKdnYcD3DAvszOIQ
 YUEQtlp.h2XtqDeHNQa2nBE30vma2OMPxsO.mLnceihK4l5m8YUCPDQ1TZwR1fobbdVHAMPCj6RS
 nQ2axZhTzqpIN1._NOLp_nnnpyQHjMMFr5BomG0D7c6Y4c6ll1_.7C6IDboowJYHY4KjpYzV.95X
 l5mEndAQHN4WlAN.7vj8IpdwJ0iIW2qxokIBZWMtML1DVTPTftcLmNNvcjjiowLPL4OANfZCj6Ck
 XOtTj411vmDP3vesI7Pzxb4MCDcBsIQNg.Ivvza1ol6fn5QFloGJjbs_DSYXaZz4GDD6nacNUCAk
 7Z6jXdiZvtq0eS580zEI4J9GquZZ6GmKlEZYPNZKimUJmCSwBgseDQrRZgUQ4SEmW5sPb.ClFSI1
 9ikRVm43Ew6iYY39JpxabW6H20vG5WCwSA_KGZWcpOXV6.IgmXS9b.AxC5ylaWYtOC3fjQIIOUNe
 mOCSK4jWbWwlyEqdQ6KoJdVHz529XMaIrWEZI_dcvelILRuKy3zTZAritMHeg7z8HtCp4rgw1iHT
 Sl6GsYpANlbJRN.6EnuRNlrogN74taxouo06SVXfZ9EqwhQvQ7TRAAEDAN5auRgz2vufzIM95HJI
 Qt9hD4uhz3hVFyhyujR2ROXVyu9RYi71O5jQZIaB4e4jzrKvk0o06BaVad4iC1L7n_9RYYUA8DMl
 9G5KTy_s4iI.HOHX4xoqL7F5Nx_JXMfW_D4UPYw8nZ4J6sCVzy2FNoSfbZ5WF3oFnl1hI_P3q.Oz
 qcbsjMm_qRnK32317RQaSV9b4D.zcMkB.GCeafW8aNyohZVoLv1etGQZ.DrnadCLiJ5F07uGsa4n
 1WLo_SKyqgD6m23Kxj7Tn7jLuC.MUbz8.UCyYr25X3hyctLrOdkmD7ocNFOU6RpIVw.iEyoq7o0i
 Ue8X5mTdMeu4BUB1NGYcVoWUiwfhDlskyoGvx26cvon9wmwARsMj1NtV9r7Ely1ObXT8CxRf0rmm
 Dy7rdM2Ub15twU2P.CmsqgcC58qewTLwWnqtIrcrjbASvht57Sh1Tx29u2VOcA56JjUj_Nu7xlTl
 PjUADHubJ..Sa2DlWGH66fVGo09OD_W5gpWPnwA.07r3qVfw3MZlbatKavYxCdPaHMxj8mIhkNq1
 i0.P9Bsbu5RZoVY6yRYCMxcdYF6kLcXG2DzST6uHErHIpRnyAFC.440T5ad_VJqE3HDg4iprZXGg
 VpHm0heiDei.Pbp53jQ--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 3e96d903-ca0c-45fd-afcc-dd77f5cffd57
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.ne1.yahoo.com with HTTP; Wed, 15 Mar 2023 22:48:50 +0000
Received: by hermes--production-gq1-6cf7749bc8-pgxdl (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 85e66b2f7435f9f3ba08ad33962dc8cf;
          Wed, 15 Mar 2023 22:48:45 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey@schaufler-ca.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     jmorris@namei.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net
Subject: [PATCH v7 05/11] LSM: Create lsm_list_modules system call
Date:   Wed, 15 Mar 2023 15:46:58 -0700
Message-Id: <20230315224704.2672-6-casey@schaufler-ca.com>
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

Create a system call to report the list of Linux Security Modules
that are active on the system. The list is provided as an array
of LSM ID numbers.

The calling application can use this list determine what LSM
specific actions it might take. That might include chosing an
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
index 3feca00cb0c1..f755c583f949 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -1063,6 +1063,7 @@ asmlinkage long sys_lsm_get_self_attr(unsigned int attr, struct lsm_ctx *ctx,
 				      size_t *size, __u64 flags);
 asmlinkage long sys_lsm_set_self_attr(unsigned int attr, struct lsm_ctx *ctx,
 				      __u64 flags);
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

