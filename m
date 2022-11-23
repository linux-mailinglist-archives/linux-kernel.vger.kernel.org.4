Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 860C1636B0D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 21:25:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238753AbiKWUXl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 15:23:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237516AbiKWUWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 15:22:53 -0500
Received: from sonic311-30.consmr.mail.ne1.yahoo.com (sonic311-30.consmr.mail.ne1.yahoo.com [66.163.188.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 868F4D0DD5
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 12:19:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1669234756; bh=rYli4IiwIzjJa6Ogek16TJclF9LuaigC5LiyN6c36JU=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=d+37kx9g0t08oaqldgFVuMjItCO995Iw4pf0+hK6KV4j0q+bhVPi0jXua8dOxnvsp8VhlvBFHaX2s+yPOt2AKyAYRDIi/G97QQwDrTul3by6hi/45lzEe0qgVdh4J2aKMqLgdPYYP+daFp9HaE/PlaunpPRI2zIXLwTUDRbH7Cm2P9Vry5bpnHc45Om4DaeW6XWCZhP0TxQN8oMrVqwfVIcyi1W5QeEbscvdmZ7rkxbkRKfCzlImxLEIjT0EckEylUsrXhGZvsLm2v9lkuPZcmZcyxCPKbxp5GOQruF6bdm+PaAAPtxwJZ3rEkqThbC4d0jMSwpa5+IIiDzkcQYjHw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1669234756; bh=PEVyjk1mjUdMgp2ecW2RNt9Wth4VFiQRv8kI9yaHvRR=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=I8amNO0KKrBVUNnnXSVOD1wx9agtDlvMaA+x5uI8LFRerLk57d9UG8DubmU/i8GQ4Jg8zXrdz1sc6Nbl4Hl4Agqf05sLp07qDA2n06MtuV71PGjAiENqJtuOuJpC7fefqj36J6vVk0uu7QdW/khxuMKq1lEVi+GqHpvHSSb1F9V3w+4sHfkygmSwUuYH2y4IkWSs/O6j46StbSjy1p8Y81+ViZ8gB4FR7pyOZLPhugcmvLHeiW6oqxmDKRkc75/yT683aqk4J6Qfmn9h6cw0QY9UJ4RSzNBt8F6XIBhx3bGpHl1Is7baPkYZt5Dbe+a44LuwaGD1ptsbf4pOL9n2FA==
X-YMail-OSG: QwpYOo8VM1mCk2slxbhaHI7T17svcQNUJCgWMudQ1UpHe7JsaMPt79Llz6ynbwz
 MV_nDubcipn0scHEQ.SphucXJswiZa9TetTp9Ln_nFd5KdCRaysOF2fLnmKzzz9_MxCeqmIY2ntq
 JZ4fuq_PCNlKg1lcgWCF3b_6KpZokjcAsKs9kbl4KcMsP7qOSfOlgITiRg9dR191BOdgXQrRgW_t
 ze29j9Hoj_ss7EmqKL_t3ZFs20fxTqENgTLov5WGqv_6ROWSfoiJMHPoW05wImo64LGVIEYHMTOl
 UPc3pky4._WXwh0uOcTr5ASKup7smK8y4yffj4W7gV6.lFMl_hCUEOKD0jdPQfGyPUqOqVTDp2qt
 o2GEpY_i7jZ0FfDVEN6SKViut2XlZrIfN76R8sz9iTHBqBj.LV13_0awApiulndCJ8ulESjCiGls
 aL5paGHlJBIwr9ikLK4LGY3nkMnR2c_K55KvE_PW6G9ZbhvceaTLsIuu40A0ngYNtI5LpUJbcfln
 3kYciLXKoycEPj.E5nzxSpZZldndE_QypCbSJ_jb3CdqZv8M_LFb4TMs0Bp3UMzXXXIndtPHig.W
 _YPlEEYKhRtyGgGK39CKPkx2lkRaFHMBDq40nBLHIuRAqZPK0bl0p1Lc7VDSBk3Y2OWA6vRKHQey
 _o7CR.KWj9zb6lcd0VBE8ojuY6nsGaPzKYeRd0mrduTkVWG8Pb053rchdDLYybv.g3m2fRb.fpjC
 anYPVmI_r7_mYgywO96nN4N8NadhNj_ZTtcZi5KrCdWwuF8_AmQbNIVrLeS1UcwkADmMnu40p4.W
 QoXTkPivwSVq5FpSo6NtIGGDfpWG71HEopqP3nwsFGZlhKFaq1k49CoASzZZb83l7WNwrFSUIy.s
 CA.iwY9QfXPCLj2Sg6s1icxvZT2.OJ6RDs0u119Qw5ErRq7RZrB7ICR9e9sRYSpruTPpyjnJ2UOA
 Az4VJJyj44ezn6TYUnWk1Dz_jjRTBd5Ie.6ODXBRlKX9eOFCjyQIPy15klERYl80UVNrUQnR3Lfx
 XwIdLeDvDCqNIuAbzCW3tX9VLth8RbN_FxaFKAMhuicOfdj3OBlkoFL6ndB0Xzw7g5oUBQbyViJb
 .IpDYWgVq5xtLKZG5VqwLKb6vqqsGGdwbGPy.rOq_3n4h8SZ0r5uDahuUW15ii1JtVGcz2tLMy9m
 y6P54VP8M3p3sMN9ZqA2YZCHd8GpMccClT.Aa1NhIpyl26nEuBGNRJHGm_mHP2bk20wi9CD7TCaJ
 bdPPhZLxW.pCInbNrhlQyLtlpK1846UD3qYkxLJYKeFpDu_4sNPkKYGaoEnNtcrfgPqBE75h_8gG
 jRTSft01nESIx57ksvsc1qInZo9x6iPD0NJePYf5j77UH5rJ0bj0_QY6qM4OmoWGN9L7h33Zx1ET
 APGEd5IaT.vDI_mHRBDLuxarBh6Jyk_ZXNTjPDq5CO2cNQwJExFODXXfs.Phb6W0mosh2sHIy2yK
 wufch3FL.AtCztxZZVXBdhCFHywQM3wMXEmRvaM5bbxCbqdgF0GpYT9KpDHwuwp9toqUr96q6rPL
 xtBEOqQRuAPi8a0yVYSPvkTbHT6mwglkviCSROsUs91P46nLVyaA5b14_4.mm9Se4OhDymBk9.Cv
 LGrSb1GQNHhWbKYBYVGyggrlZBW1au7sHRoilamqx257x1smWeJNtoziRinUySDcqH1OOXs5ScXw
 CQMuMcAuv6fLGof082pUZOjYfl8eTm7TuFR4KAvb5.oaR7Aiu4GVk1fe6Zwr2iXU5f3ngkgMjKRz
 5Inc4f_2BYBNPvjuvN3LxzEqbtEubx9x_bfhFYQyO1QsR_ANa0wdShBBVs6uMIRk5c8HwGja4MNa
 Hk4bkldnyINxKC.ppSE2u1HwfJ2G9BQ9GW9YHzUD8DWFYoisbuwK0MtFUBctt3t7WBik5fLeABdY
 .IKCJ97thX7sAK1eMx3_iPjmCGzFSbVZ8g4Eg7S9Q7v.d8msYMXfWWKmIDsuftQi8VuVejVWYb5Z
 8dHDHw49IMXe4soy36T8hSf_zHNuB_9ZN9szfJjz0UMVGv6WzAszdFFdREga8ylN_2E2ZNTYd8UO
 m8QCgQDjQmpplKHn6fA_26BJBBMh9ZyTtE6sdSGrmR9jYXDiHj.KPe5OUtUh6XT7.GoXIe59v6_D
 k5Mfep3NhOOT_XRpmZBn51XJVz1qlTZ2qEp1CGBuGMuasq1NNj8r9G57O_vCxjCCcRlil_U3RObZ
 RZX3HcSiAHPVVRleIt5oMCixEVXUIQPVtvALc_yxtHhEX_kY-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Wed, 23 Nov 2022 20:19:16 +0000
Received: by hermes--production-gq1-579bc4bddd-b8ql8 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 38c80e614aa0809f99b59395af46cd39;
          Wed, 23 Nov 2022 20:19:13 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     casey@schaufler-ca.com, jmorris@namei.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net
Subject: [PATCH v3 6/9] LSM: Create lsm_module_list system call
Date:   Wed, 23 Nov 2022 12:15:49 -0800
Message-Id: <20221123201552.7865-7-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221123201552.7865-1-casey@schaufler-ca.com>
References: <20221123201552.7865-1-casey@schaufler-ca.com>
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
 security/lsm_syscalls.c             | 41 +++++++++++++++++++++++++++++
 4 files changed, 46 insertions(+)

diff --git a/Documentation/userspace-api/lsm.rst b/Documentation/userspace-api/lsm.rst
index 98a0c191b499..e342d75b99ab 100644
--- a/Documentation/userspace-api/lsm.rst
+++ b/Documentation/userspace-api/lsm.rst
@@ -57,6 +57,9 @@ Get the security attributes of the current process
 .. kernel-doc:: security/lsm_syscalls.c
     :identifiers: sys_lsm_get_self_attr
 
+.. kernel-doc:: security/lsm_syscalls.c
+    :identifiers: sys_lsm_module_list
+
 Additional documentation
 ========================
 
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 2f2434adec4a..2411b4043752 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -1059,6 +1059,7 @@ asmlinkage long sys_set_mempolicy_home_node(unsigned long start, unsigned long l
 					    unsigned long flags);
 asmlinkage long sys_lsm_get_self_attr(struct lsm_ctx *ctx, size_t *size,
 				      int flags);
+asmlinkage long sys_lsm_module_list(u32 *ids, size_t *size, int flags);
 
 /*
  * Architecture-specific system calls
diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index 7b2513d5605d..af1fd28c0420 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -264,6 +264,7 @@ COND_SYSCALL(mremap);
 
 /* security/lsm_syscalls.c */
 COND_SYSCALL(lsm_get_self_attr);
+COND_SYSCALL(lsm_module_list);
 
 /* security/keys/keyctl.c */
 COND_SYSCALL(add_key);
diff --git a/security/lsm_syscalls.c b/security/lsm_syscalls.c
index c109a0dc18fe..3838cdf66310 100644
--- a/security/lsm_syscalls.c
+++ b/security/lsm_syscalls.c
@@ -180,3 +180,44 @@ SYSCALL_DEFINE3(lsm_get_self_attr,
 	kfree(final);
 	return rc;
 }
+
+/**
+ * sys_lsm_module_list - Return a list of the active security modules
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
+		__u32 __user *, ids,
+		size_t __user *, size,
+		__u64, flags)
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
2.38.1

