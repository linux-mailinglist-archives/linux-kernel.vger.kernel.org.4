Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06C8460D3FB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 20:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233043AbiJYSs7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 14:48:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232925AbiJYSsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 14:48:53 -0400
Received: from sonic308-15.consmr.mail.ne1.yahoo.com (sonic308-15.consmr.mail.ne1.yahoo.com [66.163.187.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F364112A8E
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 11:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1666723722; bh=JPTHbEtDzTcWk/IoC5WyCw9rcLntJ6rErxAyipdRKeU=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=lSggReZTz5kDfnICBhX8FyrtzBVmDIoW3/WiqiNrl/gUkCSZTE8iO2qzIyLJHU7DCAnx8mgay2IFLPqXOFrOsMVAkgSPPBLOqWeoEvVZut07UnTkhqaobdW7aKJeXumO4OQJYE1Po1oMIvBc0sxJfSIBtarC9hgnQr4pknOnkxKmCKhozHbLmb78o3ZZZowuWkAtJYgtpkhT+seJmJok9vnV8be/z+Sz86KeZ677KF4epus7NqBIRv3TMK6vnZ6PW/N8GVaGtr2piRAAmO6XbI1Vq6Nov+IaHyi07l4saDVJH2YGujoMzWvaiqbWlissFG8fFxfJunywHJjWBUpteQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1666723722; bh=ZEOoJatGzl2RbmJboUKjJf/CVMhYAtR/7Y6CjIuIpbA=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=ZTWyNylBgWI3m1eTa65aQrNE4a9vuBPh9kFaAkcTkdri97hQFQ81TXvI82pCqFELYB/3xvjMJWhIwvYW8R8tOcqAO3zv0lQdwmzzYJO2fXTX3gsfnkS/dNuRslqnz4zfRzxkKM/IoifgSq16loMNulnn/223JboqBQwEn2VYKo6s4xh3Ym+Yslqv9yGRlEinmU4aHAoaBq5FGtniNkQpvKoL9QbreVd02b4V/A9MPY85jWD0gR8LhJWrgaqVJ5LDB7uXlyRVT1IomAb89MRcTcms72XZ8ErATQy/M7DOqbGuI48Sr7ze2uZq412SC8FV2vQixAI08iAOR99UZHZ6Lg==
X-YMail-OSG: Y9r3dB4VM1na2Unf9Sof7gjYoY83BIozuKcju44Sfh0vDdj1zt03DxJapCNZ4Dw
 zPDyjYvcX3IlaV60a3bY6x2pcOACBQcPrycGa82.uSUfzPPGLEg6CjDJzdY7llf5iwXLgtUhRjkR
 ZOOJbt6NFH9bvgGSHhsypxm170ffTBCxCSVkzhz9f.lc4D6Sb4hmgI6zJx8BjUqQUbz5ohYvA9MX
 nyE2g_YbLsCbz11N5jTGd38z280daBrTw80ZL97hamPWKdmuYrOiAnRSUA57gKeYWlGcI6O3ZJwH
 BHPaT78L1tNH8ugsYW83JuTAETUToO2.gf9mikRz.Gt3PaMJVj96Ze7S7uPDTpEG.SYZHyoCMEuo
 HpEl6PpMNXJ__10pR0TeK9t6ceBXKGvOLVZtcPbF9Jz8_ua1jfxVO90jPIuCYPMLReQBh_aQuXO4
 BLIqfYyxk_YzT.Ndn73CgMDDCO.r48wg6.aRRoJhexMVVm0O_igHYLxbvzk9YyvEm_kyJ1D5bz9g
 G35nstvzEB3onviouwo_CF9LPtMcGkRxH2Gv2jdaRcEccdynJCC4HpClrjqzTIVDD74hqFhOWFTH
 8gQPkiE3gxoNGdr0JhfoXpCUO2sBI.w1Q76_lsnDKenjhfJrH0VrzxoOn_Z5oxGrrF7ibwr6kKQg
 XAjKEPlktJ.jBvhZHSFfNia.KMQ.7H8Fv7z51QfPrsAcXNpno.TN6J3Hcz_20HlaPF8Hl_6RorGP
 ZBG2X69Aap7J4Cwi5S.ccH6xSyOaUftJLVbl0ZLeigi5upNN71K8YFe7HKY2zf9JNCpT.6hyf7ml
 uLSPBsxoN.QVk4h_qSuD__0gg9TwlP0klUsIio7FzUvJlF6PYBZCAf0fAgSD0wZoraXdiYgL2ogu
 mQ6llf6Ov7OT8HUHz_Ewx6Tt1AHIu79L.MKdzg5yRdVZ.Ji93AZLv.oEyjm1Ur_jpGvvU7PXpSPo
 1BH7nGefDJrPtQXjei8B_4xIXUrH_OwToBCra6gipH.80UY9mMxOVF2reuzE8pKecsYowdkusKvx
 aRVGQ2XkClJANxY2gwjqKFbN99_ME_RbG0NB1pV8DLP0zLno7uzaESMUHruXYszG5jDNKvCA4pKh
 HOpJtWuapBLwAKDSaQiSGb9HKoZ_8zJ2YwOmjJkujzzTfMi8KN4T_ycgi13K43n_40Qp9yZwOm7_
 wH9sj9aZsjf9DtQP1FaFAE0hKzMFAcMKB9XrnUZV.4S0qiddB3fiFT7zF4lfF4ZQb6dVbyDw7c8A
 tjfXyty7MbIfdOHSxRVNwUkBCCIZUQjS8vFchTFYPjCh5lTKarec9qE8BcvMceJX.IUvh21vJsxv
 VRoaV2S7e7Y2Nc_beMh_NizAAXz8AeXhMMq3Dkm53sqVikkrOlhyHpv2O3FR8f.psLc1HA2Rr1eb
 qz2Iy97PZSYIg7UpB95bGTBpZEESV0wkBB_kK5K7f7r9uEWsMS4MNHIhJYuPAe5NzagavDw3dDRF
 dkdtJBGUVayDnnlGc92icd5VAx2AMafgFVl76Ei67vBYCpnSGIGLzhomDszVvlzD6RIizKuqyUoK
 dvQVSbtQLb3zxbzWs0gog2sgDf.uk1Zn9CZrDnxkbPdTgTkMnaILYRE3Q7yeo7FwMFeA48K5fJH_
 zBOjuW6LwGdZZVEzKy3s9eWLAkPgdBBOdHFBOTj751VvSnCMETc1zWxoF5eeUGYM4qQyblbytGEb
 EMKRW_r4yDfY8PXaEXKXfjnO5wsOmXl7O0bZiPANSLiPHwxXAx2_3ur7W2eghLBufCJDuHgkxK9o
 qvfcc8S1brHF87BMaPVrM2YeU0pviogJrRhTn5dONPpCq4WtNb9UyHmWS9TPHPkLcShll75S7_vV
 Kg14Zt2z2Qu0jhoI9nPv72aqBLCJqjfeWrDFBw7KjhJCaDlWr8PzsOjLDLLkULgtQXaNUSDzqMcM
 6jv4qlXD4qWf61o0Rp0r6JVX8k2gDlS.2eo5J5JJ3QEl75VnKpuwo1_wF9Xq9y9OV8nzSZKUys_2
 gGJ6ZFrx50CVt10vigX9WNcheP0x.bLkOd9Fup1KT3cvz2yE8jXJ1mZJmeZ6tXv52G2C_XT1vtr3
 kWLaAzOXUOy3YgBYzBUlggiDPdfN.yZBXAqOmNxXdB3OCApSTRDsf_JHFq5Sjl6uMmh5xz1XC2pe
 56dpKmfo4MN33GfdSEi.DULsN6Gx.ih1RqrzgNRyUayAaGIiDPq65fi16DLfW6AkJZM2RZhZBhvb
 AeRnMjEHltXZv3EeaG8QrQuSPFHe_lmgOoOMuZr2gBDQ8Rg--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ne1.yahoo.com with HTTP; Tue, 25 Oct 2022 18:48:42 +0000
Received: by hermes--production-gq1-754cb59848-jkt9q (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID d383105834ed78a52d504d4d360854e7;
          Tue, 25 Oct 2022 18:48:37 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     casey@schaufler-ca.com, jmorris@namei.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net
Subject: [PATCH v1 7/8] LSM: Create lsm_module_list system call
Date:   Tue, 25 Oct 2022 11:45:18 -0700
Message-Id: <20221025184519.13231-8-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221025184519.13231-1-casey@schaufler-ca.com>
References: <20221025184519.13231-1-casey@schaufler-ca.com>
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

