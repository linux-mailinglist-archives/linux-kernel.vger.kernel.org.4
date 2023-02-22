Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE9D869FCD6
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 21:12:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232201AbjBVUM1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 15:12:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbjBVUMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 15:12:24 -0500
Received: from sonic311-30.consmr.mail.ne1.yahoo.com (sonic311-30.consmr.mail.ne1.yahoo.com [66.163.188.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4837536FC8
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 12:12:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1677096726; bh=jAyOzaeZKkMIznekU8PEdLn+tbPrgLQ7vd2ljII3D98=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=XwQ7NHMUw9KzSPAlrHhy8s2uLTGqvVaT8e6eM2VYR9ICuZK83IbPWa0G9jBgYZCv+OMRss/wpg7kz6Rz7sDOQfR9uFoVI4BR8f/hOzzRxmNSQAOrsBlAAZRkN2c+iPAU6iR7r3KjsbM8D3L55m17F3bmUEGvrpfYAm0Kzc59uT1uZX1E6QCSzyhnzUuDFplhH+m7lfrUmoTfbm2JgVJMkMTzE77/vsBnt0w/hlKQINcVKGCq4aJfo+C3Q7DgfGdD5AiumPwBttYn/Evv2b6EhhDjj/SnH8QeKtXxJzHEZ+bjC5S5c1z19jrVQEMCM6eOtyiPqNHLZ9J9NllegoFWPA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1677096726; bh=LIemH4qSZn95DrwGgnHnHVWuHkNyjijIhzQ28bSKDuv=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=BtG11a2CTmJZwz4fo2XMwN253tHxjHcCWrKFweieZhMl2fIsO2Ee9oHqCNkdMKtXFObx6KpW1UBnZ6fP6eKNjPalAIh2x5U6MxwuRx/Zh+uVtO9Scy9TPIMYtTK7pnb0zk6NSvfho80Sgqk3ZhUdvz8E8VGiCpuB9mZrYFC2G7zgJp0PsHmGmoTWnl6mj+9JKUMWfChHmMc0WtI6YH9FI4SK2XxISj4uFZGQ0sDvlwyK1XS79arituk0ND4CG9gp0UZ7CSvHR9zfVGYw8DltX4fpP4FKIb+MdirMsKJ/79cDLq5aloHmOrl6QwbfZrEEB72i3svwC0xBpnNmLX/qUw==
X-YMail-OSG: CPSjKm0VM1nNCra6CyeNCqRwKZVcydZ.3TY0Az_ekN3Rnq_SDlesljAgoOsC0mX
 UawyGxaUSuw0CkY7ODpD15xmEpOkHGFVoLzEwTNP6fT7Lln40QYZpVIVg3fSHk._k.cEBl1Y66Mx
 DrY3cTl0GcMPnOb5sc5b0jhmL2N_1lsDb5Tu82w4Vezwtuc9uBBbiRcWasnkBgKoDcvT77fRvFqN
 ueEaGGhRrlhzY03GmoPV3GWxKhBzUlobkSbIWrRIszqCTBU5sZ3RKqJx7g6rVIvc7uGkMdjDBA1.
 l3jIV5s9NSzWMKdZUkPT23tKL0BI6YrPvfn7lffCKeuQRJ9mRHA3K6_QCJD_iZLULj6gHeYX1yE8
 hDh9oqvGgERRgQG2I5VrFE8W3hOkah6Ys9LdpJBd3A8640bToBQof6IjF4eWi9dR86zlDysBsGM6
 oLVfutXc2UbOw.Hqg3F1jzMFNh1wLQaKcX5xIQRWETzGtYYSkNXOZGMjf6Eu5FMLZ5I5yJQRLnWn
 IzzNucOEXHwXp_IWzwSrAfX4Zv.Q.7P4NmlFKvc.YAlmk5.bF2W0qQdxAWGjfhHy1gRYmXFt3IhK
 gJkh4vE5508Oi_JYgxiSzybWHZhUcVkU.paXu.ngI_V9SDHLHqRdyRvPoBK1jxzV.ieT9MF3ZsZ3
 EKhC8boxdiEopqQkYYkt6R3sJKPyqajbvXfdFUefH28St9SQIcz63r1Jk9j05P5PtkMo.5zviIT.
 9PyUoQDTEg.vM9NqS4wwzefOQRTmJvbOxyUBW4UMiOYBVSeapGEyQ5aSaCDDhl0qPoVAqdPywRSE
 GOmQ.K8K5FyFVeYaAwCing6NYs_twtPzlEGk3QhDTln1uX7YAnLpHppRT31Haz1r6HXrIPkdakAA
 8f3.GdmCt4EeDGNHJLahZ9RRrpgEohGF0VSJhUq69lu2_Vthn86vbdTz7zS8Kp6CNJrHojVLtjl1
 FcOqFZwD4SvVR8E2HOZ9nJ3xxNMotOu6AyAHrCKGEaj1AXRIq5YRzvXSypZsffj7cdrEj2N.vaMi
 7K77n35BuNtXZT5t.m8KXFuBdeZb85uoR98L5Yi2hwYLYWSS5oUiADh7ccIphLvJHtxYiM3hf4H1
 mFD4.RJFZldhxf3wt1R.C2mdf.fyNdh2NIGkQ3w8S8B5Km64MfbTpJ8AJz9hi87rLw0QV7OACpVH
 kI.zKrvc9m0XFsSGhdTeSvx1LsjxZ_fVy95N0pvz7xpQr7hPzXmOtsWZgMDQARSA6I4Sn5CItSUo
 SAwGeDhMrdtBes3T8qK7jPO6P6sMgXDF.P3U3i6PKyVjhDMWQkTLvT.8r3qn.NHr1cup_BEPM6Xs
 npAOejPvzMMrbXGWa3ekv.UV0rams9._kVrY7fWzGfYYjuPXj5qmU7g7zrQzJaHSjjjnaG7ghVj4
 _vAtZT9ZHw0mgJWgS0o3316QwtD2XXboqlTzJAqwOGM_82T7hN3uIDK8sn07_SwUIsejelzv2x58
 4oZ7r5qjBrAAPw62dBLQBERh7oofZlQbtnD0sZPJlC6.oS3igJqjo08aIojY3bGGRVt76xUOSVTR
 HNiHoYuk4BGso1qyI7EkHfIBTUhvUZtQUO.l_XVzc0VBpXM_ujM8VzyHLD.mAn2EH_7cKo6sBzrC
 tHuOSRNcZtYnhpA6mFoCyxhuPEYELp0EoHVPKklgONrlLNyfQaNkaRLVI8Z642MXUqqIOO2Rfsrh
 wFmG5y6f2X2g7N4YP55uTANBZ4nVADx2nEQZ.V9kyed7Kp7wFpZiYRWBiWx5agiFtqs2As50aNgk
 krPVQTb13RYkQyFkmYNMTRSbOXTQ4Mlo469Ydj0o9aX5uaIAfIPT4gnO56.abl6qRk8I0gnL03GW
 1iY6B69yq9pIxRGRzakzeiJq8WShDQ5HeSWyyt4YU6I_aPTSOQYsj7e5Mb_I0NUbLS9.r_vavmAO
 sYKbThhk4eEu4sb1cXUt1OS0psEVPxoe0pw0Ma7TcH4MVCtRedGp0676aCzqd7FbhCIuYy.H_tiS
 vJA2OmbrzZq.kF8O3OMPt8puE2tV2AHQ8ZXivsHZ7XbzTMR7KL0NsjYCt4MTRRGyZoPbkD7b5oOt
 kb0DOcdbSR1QrnLnHk6OJdqgf6KTf1ndr9TcdJ064v13OSt_7aVqRhvjrZrw4lkSKz52cLzFcaSh
 ohKTkH7cbde2bWewRyLnxOhHGpafzkEdUoHx0m8.wpZ9LW6gycYmEyfDjLNRRs0pH_7pNothikIO
 qn8s5Ah1_Nj_ist90.8yjNg_vw3QD9y2VNcLP.8U6MsraJ4gV54iYGvj150nuXb1vpW0ArmjhU0T
 bwu6iyEV6CvQtrBS8Ctbr
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Wed, 22 Feb 2023 20:12:06 +0000
Received: by hermes--production-gq1-655ddccc9-czwwz (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID c7ef53d340a8069498e39800c60f4cda;
          Wed, 22 Feb 2023 20:12:01 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey@schaufler-ca.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     jmorris@namei.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net
Subject: [PATCH v6 06/11] LSM: wireup Linux Security Module syscalls
Date:   Wed, 22 Feb 2023 12:08:33 -0800
Message-Id: <20230222200838.8149-7-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230222200838.8149-1-casey@schaufler-ca.com>
References: <20230222200838.8149-1-casey@schaufler-ca.com>
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

Wireup lsm_get_self_attr, lsm_set_self_attr and lsm_module_list
system calls.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Cc: linux-api@vger.kernel.org
---
 arch/alpha/kernel/syscalls/syscall.tbl              |  3 +++
 arch/arm/tools/syscall.tbl                          |  3 +++
 arch/arm64/include/asm/unistd.h                     |  2 +-
 arch/arm64/include/asm/unistd32.h                   |  6 ++++++
 arch/ia64/kernel/syscalls/syscall.tbl               |  3 +++
 arch/m68k/kernel/syscalls/syscall.tbl               |  3 +++
 arch/microblaze/kernel/syscalls/syscall.tbl         |  3 +++
 arch/mips/kernel/syscalls/syscall_n32.tbl           |  3 +++
 arch/mips/kernel/syscalls/syscall_n64.tbl           |  3 +++
 arch/mips/kernel/syscalls/syscall_o32.tbl           |  3 +++
 arch/parisc/kernel/syscalls/syscall.tbl             |  3 +++
 arch/powerpc/kernel/syscalls/syscall.tbl            |  3 +++
 arch/s390/kernel/syscalls/syscall.tbl               |  3 +++
 arch/sh/kernel/syscalls/syscall.tbl                 |  3 +++
 arch/sparc/kernel/syscalls/syscall.tbl              |  3 +++
 arch/x86/entry/syscalls/syscall_32.tbl              |  3 +++
 arch/x86/entry/syscalls/syscall_64.tbl              |  3 +++
 arch/xtensa/kernel/syscalls/syscall.tbl             |  3 +++
 include/uapi/asm-generic/unistd.h                   | 11 ++++++++++-
 tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl |  3 +++
 tools/perf/arch/powerpc/entry/syscalls/syscall.tbl  |  3 +++
 tools/perf/arch/s390/entry/syscalls/syscall.tbl     |  3 +++
 tools/perf/arch/x86/entry/syscalls/syscall_64.tbl   |  3 +++
 23 files changed, 77 insertions(+), 2 deletions(-)

diff --git a/arch/alpha/kernel/syscalls/syscall.tbl b/arch/alpha/kernel/syscalls/syscall.tbl
index 8ebacf37a8cf..002e6a39fcb1 100644
--- a/arch/alpha/kernel/syscalls/syscall.tbl
+++ b/arch/alpha/kernel/syscalls/syscall.tbl
@@ -490,3 +490,6 @@
 558	common	process_mrelease		sys_process_mrelease
 559	common  futex_waitv                     sys_futex_waitv
 560	common	set_mempolicy_home_node		sys_ni_syscall
+561	common	lsm_get_self_attr		sys_lsm_get_self_attr
+562	common	lsm_module_list			sys_lsm_module_list
+563	common	lsm_set_self_attr		sys_lsm_set_self_attr
diff --git a/arch/arm/tools/syscall.tbl b/arch/arm/tools/syscall.tbl
index ac964612d8b0..dca80a2d3927 100644
--- a/arch/arm/tools/syscall.tbl
+++ b/arch/arm/tools/syscall.tbl
@@ -464,3 +464,6 @@
 448	common	process_mrelease		sys_process_mrelease
 449	common	futex_waitv			sys_futex_waitv
 450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
+451	common	lsm_get_self_attr		sys_lsm_get_self_attr
+452	common	lsm_module_list			sys_lsm_module_list
+453	common	lsm_set_self_attr		sys_lsm_set_self_attr
diff --git a/arch/arm64/include/asm/unistd.h b/arch/arm64/include/asm/unistd.h
index 037feba03a51..6a28fb91b85d 100644
--- a/arch/arm64/include/asm/unistd.h
+++ b/arch/arm64/include/asm/unistd.h
@@ -39,7 +39,7 @@
 #define __ARM_NR_compat_set_tls		(__ARM_NR_COMPAT_BASE + 5)
 #define __ARM_NR_COMPAT_END		(__ARM_NR_COMPAT_BASE + 0x800)
 
-#define __NR_compat_syscalls		451
+#define __NR_compat_syscalls		454
 #endif
 
 #define __ARCH_WANT_SYS_CLONE
diff --git a/arch/arm64/include/asm/unistd32.h b/arch/arm64/include/asm/unistd32.h
index 604a2053d006..cb4b3149024d 100644
--- a/arch/arm64/include/asm/unistd32.h
+++ b/arch/arm64/include/asm/unistd32.h
@@ -907,6 +907,12 @@ __SYSCALL(__NR_process_mrelease, sys_process_mrelease)
 __SYSCALL(__NR_futex_waitv, sys_futex_waitv)
 #define __NR_set_mempolicy_home_node 450
 __SYSCALL(__NR_set_mempolicy_home_node, sys_set_mempolicy_home_node)
+#define __NR_lsm_get_self_attr 451
+__SYSCALL(__NR_lsm_get_self_attr, sys_lsm_get_self_attr)
+#define __NR_lsm_module_list 452
+__SYSCALL(__NR_lsm_module_list, sys_module_list)
+#define __NR_lsm_set_self_attr 453
+__SYSCALL(__NR_lsm_set_self_attr, sys_lsm_set_self_attr)
 
 /*
  * Please add new compat syscalls above this comment and update
diff --git a/arch/ia64/kernel/syscalls/syscall.tbl b/arch/ia64/kernel/syscalls/syscall.tbl
index 72c929d9902b..1a5d560a1317 100644
--- a/arch/ia64/kernel/syscalls/syscall.tbl
+++ b/arch/ia64/kernel/syscalls/syscall.tbl
@@ -371,3 +371,6 @@
 448	common	process_mrelease		sys_process_mrelease
 449	common  futex_waitv                     sys_futex_waitv
 450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
+451	common	lsm_get_self_attr		sys_lsm_get_self_attr
+452	common	lsm_module_list			sys_lsm_module_list
+453	common	lsm_set_self_attr		sys_lsm_set_self_attr
diff --git a/arch/m68k/kernel/syscalls/syscall.tbl b/arch/m68k/kernel/syscalls/syscall.tbl
index b1f3940bc298..0b7b01c90315 100644
--- a/arch/m68k/kernel/syscalls/syscall.tbl
+++ b/arch/m68k/kernel/syscalls/syscall.tbl
@@ -450,3 +450,6 @@
 448	common	process_mrelease		sys_process_mrelease
 449	common  futex_waitv                     sys_futex_waitv
 450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
+451	common	lsm_get_self_attr		sys_lsm_get_self_attr
+452	common	lsm_module_list			sys_lsm_module_list
+453	common	lsm_set_self_attr		sys_lsm_set_self_attr
diff --git a/arch/microblaze/kernel/syscalls/syscall.tbl b/arch/microblaze/kernel/syscalls/syscall.tbl
index 820145e47350..b69d57014c7b 100644
--- a/arch/microblaze/kernel/syscalls/syscall.tbl
+++ b/arch/microblaze/kernel/syscalls/syscall.tbl
@@ -456,3 +456,6 @@
 448	common	process_mrelease		sys_process_mrelease
 449	common  futex_waitv                     sys_futex_waitv
 450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
+451	common	lsm_get_self_attr		sys_lsm_get_self_attr
+452	common	lsm_module_list			sys_lsm_module_list
+453	common	lsm_set_self_attr		sys_lsm_set_self_attr
diff --git a/arch/mips/kernel/syscalls/syscall_n32.tbl b/arch/mips/kernel/syscalls/syscall_n32.tbl
index 253ff994ed2e..7c1ca6241b90 100644
--- a/arch/mips/kernel/syscalls/syscall_n32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n32.tbl
@@ -389,3 +389,6 @@
 448	n32	process_mrelease		sys_process_mrelease
 449	n32	futex_waitv			sys_futex_waitv
 450	n32	set_mempolicy_home_node		sys_set_mempolicy_home_node
+451	n32	lsm_get_self_attr		sys_lsm_get_self_attr
+452	n32	lsm_module_list			sys_lsm_module_list
+453	n32	lsm_set_self_attr		sys_lsm_set_self_attr
diff --git a/arch/mips/kernel/syscalls/syscall_n64.tbl b/arch/mips/kernel/syscalls/syscall_n64.tbl
index 3f1886ad9d80..99453966d179 100644
--- a/arch/mips/kernel/syscalls/syscall_n64.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n64.tbl
@@ -365,3 +365,6 @@
 448	n64	process_mrelease		sys_process_mrelease
 449	n64	futex_waitv			sys_futex_waitv
 450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
+451	n64	lsm_get_self_attr		sys_lsm_get_self_attr
+452	n64	lsm_module_list			sys_lsm_module_list
+453	n64	lsm_set_self_attr		sys_lsm_set_self_attr
diff --git a/arch/mips/kernel/syscalls/syscall_o32.tbl b/arch/mips/kernel/syscalls/syscall_o32.tbl
index 8f243e35a7b2..4ddb0ff66793 100644
--- a/arch/mips/kernel/syscalls/syscall_o32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_o32.tbl
@@ -438,3 +438,6 @@
 448	o32	process_mrelease		sys_process_mrelease
 449	o32	futex_waitv			sys_futex_waitv
 450	o32	set_mempolicy_home_node		sys_set_mempolicy_home_node
+451	o32	lsm_get_self_attr		sys_lsm_get_self_attr
+452	o32	lsm_module_list			sys_lsm_module_list
+453	032	lsm_set_self_attr		sys_lsm_set_self_attr
diff --git a/arch/parisc/kernel/syscalls/syscall.tbl b/arch/parisc/kernel/syscalls/syscall.tbl
index 0e42fceb2d5e..5ab1a5b22d8e 100644
--- a/arch/parisc/kernel/syscalls/syscall.tbl
+++ b/arch/parisc/kernel/syscalls/syscall.tbl
@@ -448,3 +448,6 @@
 448	common	process_mrelease		sys_process_mrelease
 449	common	futex_waitv			sys_futex_waitv
 450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
+451	common	lsm_get_self_attr		sys_lsm_get_self_attr
+452	common	lsm_module_list			sys_lsm_module_list
+453	common	lsm_set_self_attr		sys_lsm_set_self_attr
diff --git a/arch/powerpc/kernel/syscalls/syscall.tbl b/arch/powerpc/kernel/syscalls/syscall.tbl
index a0be127475b1..8d31bb83d6a2 100644
--- a/arch/powerpc/kernel/syscalls/syscall.tbl
+++ b/arch/powerpc/kernel/syscalls/syscall.tbl
@@ -537,3 +537,6 @@
 448	common	process_mrelease		sys_process_mrelease
 449	common  futex_waitv                     sys_futex_waitv
 450 	nospu	set_mempolicy_home_node		sys_set_mempolicy_home_node
+451	common	lsm_get_self_attr		sys_lsm_get_self_attr
+452	common	lsm_module_list			sys_lsm_module_list
+453	common	lsm_set_self_attr		sys_lsm_set_self_attr
diff --git a/arch/s390/kernel/syscalls/syscall.tbl b/arch/s390/kernel/syscalls/syscall.tbl
index 799147658dee..bb7597be2e4f 100644
--- a/arch/s390/kernel/syscalls/syscall.tbl
+++ b/arch/s390/kernel/syscalls/syscall.tbl
@@ -453,3 +453,6 @@
 448  common	process_mrelease	sys_process_mrelease		sys_process_mrelease
 449  common	futex_waitv		sys_futex_waitv			sys_futex_waitv
 450  common	set_mempolicy_home_node	sys_set_mempolicy_home_node	sys_set_mempolicy_home_node
+451  common	lsm_get_self_attr	sys_lsm_get_self_attr		sys_lsm_get_self_attr
+452  common	lsm_module_list		sys_lsm_module_list		sys_lsm_module_list
+453  common	lsm_set_self_attr	sys_lsm_set_self_attr		sys_lsm_set_self_attr
diff --git a/arch/sh/kernel/syscalls/syscall.tbl b/arch/sh/kernel/syscalls/syscall.tbl
index 2de85c977f54..43d468742916 100644
--- a/arch/sh/kernel/syscalls/syscall.tbl
+++ b/arch/sh/kernel/syscalls/syscall.tbl
@@ -453,3 +453,6 @@
 448	common	process_mrelease		sys_process_mrelease
 449	common  futex_waitv                     sys_futex_waitv
 450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
+451	common	lsm_get_self_attr		sys_lsm_get_self_attr
+452	common	lsm_module_list			sys_lsm_module_list
+453	common	lsm_set_self_attr		sys_lsm_set_self_attr
diff --git a/arch/sparc/kernel/syscalls/syscall.tbl b/arch/sparc/kernel/syscalls/syscall.tbl
index 4398cc6fb68d..c7791c7bdde4 100644
--- a/arch/sparc/kernel/syscalls/syscall.tbl
+++ b/arch/sparc/kernel/syscalls/syscall.tbl
@@ -496,3 +496,6 @@
 448	common	process_mrelease		sys_process_mrelease
 449	common  futex_waitv                     sys_futex_waitv
 450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
+451	common	lsm_get_self_attr		sys_lsm_get_self_attr
+452	common	lsm_module_list			sys_lsm_module_list
+453	common	lsm_set_self_attr		sys_lsm_set_self_attr
diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index 320480a8db4f..4f2e6577466e 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -455,3 +455,6 @@
 448	i386	process_mrelease	sys_process_mrelease
 449	i386	futex_waitv		sys_futex_waitv
 450	i386	set_mempolicy_home_node		sys_set_mempolicy_home_node
+451	i386	lsm_get_self_attr	sys_lsm_get_self_attr
+452	i386	lsm_module_list		sys_lsm_module_list
+453	i386	lsm_set_self_attr	sys_lsm_set_self_attr
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index c84d12608cd2..3a7866f72042 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -372,6 +372,9 @@
 448	common	process_mrelease	sys_process_mrelease
 449	common	futex_waitv		sys_futex_waitv
 450	common	set_mempolicy_home_node	sys_set_mempolicy_home_node
+451	common	lsm_get_self_attr	sys_lsm_get_self_attr
+452	common	lsm_module_list		sys_lsm_module_list
+453	common	lsm_set_self_attr	sys_lsm_set_self_attr
 
 #
 # Due to a historical design error, certain syscalls are numbered differently
diff --git a/arch/xtensa/kernel/syscalls/syscall.tbl b/arch/xtensa/kernel/syscalls/syscall.tbl
index 52c94ab5c205..e0a5b61c1f1a 100644
--- a/arch/xtensa/kernel/syscalls/syscall.tbl
+++ b/arch/xtensa/kernel/syscalls/syscall.tbl
@@ -421,3 +421,6 @@
 448	common	process_mrelease		sys_process_mrelease
 449	common  futex_waitv                     sys_futex_waitv
 450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
+451	common	lsm_get_self_attr		sys_lsm_get_self_attr
+452	common	lsm_module_list			sys_lsm_module_list
+453	common	lsm_set_self_attr		sys_lsm_set_self_attr
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index 45fa180cc56a..3659b2b02f5a 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -886,8 +886,17 @@ __SYSCALL(__NR_futex_waitv, sys_futex_waitv)
 #define __NR_set_mempolicy_home_node 450
 __SYSCALL(__NR_set_mempolicy_home_node, sys_set_mempolicy_home_node)
 
+#define __NR_lsm_get_self_attr 451
+__SYSCALL(__NR_lsm_get_self_attr, sys_lsm_get_self_attr)
+
+#define __NR_lsm_module_list 452
+__SYSCALL(__NR_lsm_module_list, sys_lsm_module_list)
+
+#define __NR_lsm_set_self_attr 453
+__SYSCALL(__NR_lsm_set_self_attr, sys_lsm_set_self_attr)
+
 #undef __NR_syscalls
-#define __NR_syscalls 451
+#define __NR_syscalls 454
 
 /*
  * 32 bit systems traditionally used different
diff --git a/tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl b/tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl
index 3f1886ad9d80..99453966d179 100644
--- a/tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl
+++ b/tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl
@@ -365,3 +365,6 @@
 448	n64	process_mrelease		sys_process_mrelease
 449	n64	futex_waitv			sys_futex_waitv
 450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
+451	n64	lsm_get_self_attr		sys_lsm_get_self_attr
+452	n64	lsm_module_list			sys_lsm_module_list
+453	n64	lsm_set_self_attr		sys_lsm_set_self_attr
diff --git a/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl b/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl
index a0be127475b1..8d31bb83d6a2 100644
--- a/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl
+++ b/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl
@@ -537,3 +537,6 @@
 448	common	process_mrelease		sys_process_mrelease
 449	common  futex_waitv                     sys_futex_waitv
 450 	nospu	set_mempolicy_home_node		sys_set_mempolicy_home_node
+451	common	lsm_get_self_attr		sys_lsm_get_self_attr
+452	common	lsm_module_list			sys_lsm_module_list
+453	common	lsm_set_self_attr		sys_lsm_set_self_attr
diff --git a/tools/perf/arch/s390/entry/syscalls/syscall.tbl b/tools/perf/arch/s390/entry/syscalls/syscall.tbl
index 799147658dee..d69bd5550b46 100644
--- a/tools/perf/arch/s390/entry/syscalls/syscall.tbl
+++ b/tools/perf/arch/s390/entry/syscalls/syscall.tbl
@@ -453,3 +453,6 @@
 448  common	process_mrelease	sys_process_mrelease		sys_process_mrelease
 449  common	futex_waitv		sys_futex_waitv			sys_futex_waitv
 450  common	set_mempolicy_home_node	sys_set_mempolicy_home_node	sys_set_mempolicy_home_node
+451  common	lsm_get_self_attr	sys_lsm_get_self_attr	sys_lsm_get_self_attr
+452  common	lsm_module_list		sys_lsm_module_list	sys_lsm_module_list
+453  common	lsm_set_self_attr	sys_lsm_set_self_attr	sys_lsm_set_self_attr
diff --git a/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl b/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
index c84d12608cd2..3a7866f72042 100644
--- a/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
@@ -372,6 +372,9 @@
 448	common	process_mrelease	sys_process_mrelease
 449	common	futex_waitv		sys_futex_waitv
 450	common	set_mempolicy_home_node	sys_set_mempolicy_home_node
+451	common	lsm_get_self_attr	sys_lsm_get_self_attr
+452	common	lsm_module_list		sys_lsm_module_list
+453	common	lsm_set_self_attr	sys_lsm_set_self_attr
 
 #
 # Due to a historical design error, certain syscalls are numbered differently
-- 
2.39.0

