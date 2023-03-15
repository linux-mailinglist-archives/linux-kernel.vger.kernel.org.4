Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBD6C6BC01B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 23:51:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232464AbjCOWv0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 18:51:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjCOWvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 18:51:21 -0400
Received: from sonic313-15.consmr.mail.ne1.yahoo.com (sonic313-15.consmr.mail.ne1.yahoo.com [66.163.185.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 757B51026F
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 15:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1678920622; bh=n+nfYo19BWLbmagFYV+BUdXi84gdWWt8aRqNcziYgZQ=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=egmmBtT2yz/kdx0X8OgEnTQNUjF7fXkWtBG7iOZRi7bw0+XqqipRlQzNVjuiEmWOurXVKdlCyQm4QjZWVWxVJeMAVjc6jpzRl5TebP1cAOkm4b6+VXXym9ABpz0FeaCVUu106oluaGu0pQhoO8wW4uRY4WRfPt/26hbnMuJ8oOK/KRkxIIkDCzwCVTk4fV6yrZcyklzVu5/kBRzhO3r96aNgVN1BylksLi+m4TJB6KKQCMPy668NK6sIdg1Fsd4clEYJ8dUb0P7ILkJ9/XaaUeBqXyCnvvVzVg6X54zaHh9WHXDeCWnglOaL8HFeDhbhktsOb7EMytWkkTW+bmOPTQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1678920622; bh=Q5zAFTRI4+/aVqaGOT4ZwUmJoz9mFlEYQ5NvGAgvllz=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=FJLE1nylCYt9yfQexJrHIrLB+Ja/Wq36nkkq1X/Qy79ydFytalkyvwlYWQSOi6Jgb+2+sMReojwZT2akTmN9LJiNkcwG5+yVb7orIwO40X4kaHzDWVo+CfuUHPSj1vexL1OODH9Wwo17hc5MXbwctdHL5Pd1JTqjns6wMFFKpT9NIfqDVY4oGbkilHKecVjHjlWr7UrW7XBB7PK3uMNQFMzItoSX2B25S+2OKeFPsX+9T9lI0bKd9+SjF9Tljz95VLfYiJ3FsUTUek0qeV3OMijqpJfRC4V7qAM6dYXkEmHPI7e0YPPl5p0bmJVcB5gmXzfs76qn08QM9mPqZLZUXQ==
X-YMail-OSG: ZT4h6OwVM1m2kMLXg8MIv6mFy1XCXYZVJZUh.ELZirjE12ObZyDAi1xM7PhKoXF
 _M08YoP0a_gNZ.aqS37jxDmaF_wEhjMJeAUTtPuf7WnBP7pHfhvoM8kljx1NS_kOPq__gm_e5kTT
 6yZ4HnGCECfPQEt9qX9PYBjWYuTTzEcW6aWI6guGPL6eK7X8jvz0XHayYZOfBS1YBjZhfgARGXQ0
 WBglutjKMDXdZpexDeXeAsLnJ.L7CvUhIjCukXB234VdpTITSIw5McOYNfvs3L_Wqfk8ZeAn4coX
 xGmqyYtR2v7XX7bwXGxq7NQ3lEvZtk5pgY0b0qANzt9uocWWjgt_pcHOA.0fPG3PWHx.Kd8MKDR3
 oLl.L9ftoztIxcjq7K43CiR8EpVA7MQSibhSeJfzvgei53g7FJTH00xdEMgfvWaid9jLBPGrRzIe
 Irr1ohShoIimRwmJXZt2g1Cahd1bMU1e267t3K4046GIohsQsIO4oqsLIyq.nvU4h3ExhwmglJzo
 Bdagj9ge3CFv0T.CR9FKIh3Q5EH7Pulp3Pa6Nv49AGZYTeCuVkzgKsaFbUDxE8hEBjEizPe6tYrf
 NA55TtsFVFZZzvICiAY68VvRP1mrjVCAVigZvKwJtsPSH6JmzELfiI3ncN0o56D4dknPBU1wR_L_
 QPvKvSER8cSqIFb1ck92qxLr4vRKwyfbvQCFPockVZ9oI.vh3TOi018foZjA1wnaMsqIqKesK4T2
 Ez9NLZZgCZQJdOBMC_CBcVZB5kJKS.u61.lwsh.r6i78kNm5BdE6CNT5q.v43PbAFCnDRBiFZXI7
 ZRqqJ4GjVBO1Fr8Yg.r2xQh2bZLvcblDL0wPhTI2Xtg1XdiSOXyDtiZbEnaGYFpkz0TWPk42DmN.
 .Nz.F9uTvXIjDcYH_k.1Fy.VCqDiTa2h3rDievSsEfOUqzLJ47rcLkV3spkdDCAia9TVSBVqaP0R
 M_pN5Dk.aQtf8jHJ8pctLPFzoam9s5RKCLIVETMx_bunexV3EtiHHEfIL5WHlZg34TAInhvTtnw3
 NFzXktcY9HDSwl.ddYdEZXjxBkM5PSxwWRbttr3WV8C0xYbnSjwvxxI0VaoWcryqtaAGjD_Dk2YI
 1GE3k84aj5dSYULJIVA.A4JEvC8CwVL7i_TojeK6V1s4FAjjFKc6jy35Zg.pSdUzCp3ev3OuZFSn
 uE4qlFpgw_BZYt7y9_x6oIgIsHe2PtGsfUaxJn0zgnXuN4uaS50DztEplf6yXCJXA4HWtYjqkKeC
 dXfBxEicrsYjaO.jZsENcm7JruIjdxBQ2ofiiXBZobl3Req0e5bDzI48FnvbJY.cQ1g_zKrXRJR0
 hPM4zvQCfUWlElxnagEfhBMw.saC_D_R.Z5entakbSUtkRjzRACyrRaaoop9TjDB5lWB_0Rg7UK2
 IVgQoehj90CI9IUKnGkj3BSpOD77eSEQO6OuUIgOEdybdd_z0v.H5.uRm9v0feXf3_chLIS69l0q
 f9qVmoSCsnxnQAopGKVSKKh7EjJUYmI9rXfttqqRWI2T1sDclJJ6TJwsjIZ6QprGLZ.kc.sLcVYl
 up7K.jodydl1h_zF3ZokDvH36LUOqq1b57PAQWssc.1nofZeG3WOg2ajHwiG478ZSy0CGwIvN_5c
 JafcgGdPliWWtUOeCBX9h3MLREzzJzeiKeY5LuVPCW05ONdInZ5KyIR2je_NW1PfONSfO3.dWzhQ
 7v.MHbxqeiSOBuGRMER3d0Lv25gwv5DLWj76zImBtaXzgGE2ACjDxfGn9jFFqZghntmzgd10Dcug
 ML_iuu8SUalvO44_SZq5xM6ba30B_ixCCuMxxA9dPtlSBVSuZH3tO_Qw2sVGk4nYaKJlXJwqzoQU
 dnpyX2CJHypomwlN.EoaFIkg6CNLDkwx.F4GZ2BN1YhgMXLKb4vM7e8fjak.R4TRwvkLcSEt7N.D
 ufseYOILEmIQAqEhPJKzAadrieUqBtg1koojwNJeDeJVe7BA49FKtyQLT9WWCQicidOMbwMhPwbR
 WzZUK_V5TrOeWolulhd7AtjSRfsy5kpzSoDoJgfnG7YGJ2fon_nBpFWANzRFpLwf84S7_SiKH_Jh
 P0J4kuZVveUyRZfyoKQpVi4rmq9heNGm1y38p1C_a0uWMRlNOr9GE1sYD19MRuUqEqUDIa0LJlhs
 0FFwVHaKzQRpZYJEQ5dkG5hz_hfaRQ_O.yyGApkaqUq4wsevPqrcN.dpT67diqQTK4GM_MPJ4eTH
 6RvMElNbcv19CqkJSUoRID4JQSRouMpBV7At2v1gZMw--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 5a72994a-c379-4955-b00a-975ddc2f73f1
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Wed, 15 Mar 2023 22:50:22 +0000
Received: by hermes--production-bf1-777648578f-mpdrm (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 50e2f089a68eaebcc40c76391bc13d32;
          Wed, 15 Mar 2023 22:50:19 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey@schaufler-ca.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     jmorris@namei.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v7 06/11] LSM: wireup Linux Security Module syscalls
Date:   Wed, 15 Mar 2023 15:46:59 -0700
Message-Id: <20230315224704.2672-7-casey@schaufler-ca.com>
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

Wireup lsm_get_self_attr, lsm_set_self_attr and lsm_list_modules
system calls.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Arnd Bergmann <arnd@arndb.de>
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
index 8ebacf37a8cf..178e2792c251 100644
--- a/arch/alpha/kernel/syscalls/syscall.tbl
+++ b/arch/alpha/kernel/syscalls/syscall.tbl
@@ -490,3 +490,6 @@
 558	common	process_mrelease		sys_process_mrelease
 559	common  futex_waitv                     sys_futex_waitv
 560	common	set_mempolicy_home_node		sys_ni_syscall
+561	common	lsm_get_self_attr		sys_lsm_get_self_attr
+562	common	lsm_list_modules		sys_lsm_list_modules
+563	common	lsm_set_self_attr		sys_lsm_set_self_attr
diff --git a/arch/arm/tools/syscall.tbl b/arch/arm/tools/syscall.tbl
index ac964612d8b0..9cda144f9631 100644
--- a/arch/arm/tools/syscall.tbl
+++ b/arch/arm/tools/syscall.tbl
@@ -464,3 +464,6 @@
 448	common	process_mrelease		sys_process_mrelease
 449	common	futex_waitv			sys_futex_waitv
 450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
+451	common	lsm_get_self_attr		sys_lsm_get_self_attr
+452	common	lsm_list_modules		sys_lsm_list_modules
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
index 604a2053d006..72022ffd5faa 100644
--- a/arch/arm64/include/asm/unistd32.h
+++ b/arch/arm64/include/asm/unistd32.h
@@ -907,6 +907,12 @@ __SYSCALL(__NR_process_mrelease, sys_process_mrelease)
 __SYSCALL(__NR_futex_waitv, sys_futex_waitv)
 #define __NR_set_mempolicy_home_node 450
 __SYSCALL(__NR_set_mempolicy_home_node, sys_set_mempolicy_home_node)
+#define __NR_lsm_get_self_attr 451
+__SYSCALL(__NR_lsm_get_self_attr, sys_lsm_get_self_attr)
+#define __NR_lsm_list_modules 452
+__SYSCALL(__NR_lsm_list_modules, sys_lsm_list_modules)
+#define __NR_lsm_set_self_attr 453
+__SYSCALL(__NR_lsm_set_self_attr, sys_lsm_set_self_attr)
 
 /*
  * Please add new compat syscalls above this comment and update
diff --git a/arch/ia64/kernel/syscalls/syscall.tbl b/arch/ia64/kernel/syscalls/syscall.tbl
index 72c929d9902b..c52e9d87f47d 100644
--- a/arch/ia64/kernel/syscalls/syscall.tbl
+++ b/arch/ia64/kernel/syscalls/syscall.tbl
@@ -371,3 +371,6 @@
 448	common	process_mrelease		sys_process_mrelease
 449	common  futex_waitv                     sys_futex_waitv
 450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
+451	common	lsm_get_self_attr		sys_lsm_get_self_attr
+452	common	lsm_list_modules		sys_lsm_list_modules
+453	common	lsm_set_self_attr		sys_lsm_set_self_attr
diff --git a/arch/m68k/kernel/syscalls/syscall.tbl b/arch/m68k/kernel/syscalls/syscall.tbl
index b1f3940bc298..31eac3c99d84 100644
--- a/arch/m68k/kernel/syscalls/syscall.tbl
+++ b/arch/m68k/kernel/syscalls/syscall.tbl
@@ -450,3 +450,6 @@
 448	common	process_mrelease		sys_process_mrelease
 449	common  futex_waitv                     sys_futex_waitv
 450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
+451	common	lsm_get_self_attr		sys_lsm_get_self_attr
+452	common	lsm_list_modules		sys_lsm_list_modules
+453	common	lsm_set_self_attr		sys_lsm_set_self_attr
diff --git a/arch/microblaze/kernel/syscalls/syscall.tbl b/arch/microblaze/kernel/syscalls/syscall.tbl
index 820145e47350..5037fa1f74b8 100644
--- a/arch/microblaze/kernel/syscalls/syscall.tbl
+++ b/arch/microblaze/kernel/syscalls/syscall.tbl
@@ -456,3 +456,6 @@
 448	common	process_mrelease		sys_process_mrelease
 449	common  futex_waitv                     sys_futex_waitv
 450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
+451	common	lsm_get_self_attr		sys_lsm_get_self_attr
+452	common	lsm_list_modules		sys_lsm_list_modules
+453	common	lsm_set_self_attr		sys_lsm_set_self_attr
diff --git a/arch/mips/kernel/syscalls/syscall_n32.tbl b/arch/mips/kernel/syscalls/syscall_n32.tbl
index 253ff994ed2e..29545b3ec587 100644
--- a/arch/mips/kernel/syscalls/syscall_n32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n32.tbl
@@ -389,3 +389,6 @@
 448	n32	process_mrelease		sys_process_mrelease
 449	n32	futex_waitv			sys_futex_waitv
 450	n32	set_mempolicy_home_node		sys_set_mempolicy_home_node
+451	n32	lsm_get_self_attr		sys_lsm_get_self_attr
+452	n32	lsm_list_modules		sys_lsm_list_modules
+453	n32	lsm_set_self_attr		sys_lsm_set_self_attr
diff --git a/arch/mips/kernel/syscalls/syscall_n64.tbl b/arch/mips/kernel/syscalls/syscall_n64.tbl
index 3f1886ad9d80..8492aa4a771f 100644
--- a/arch/mips/kernel/syscalls/syscall_n64.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n64.tbl
@@ -365,3 +365,6 @@
 448	n64	process_mrelease		sys_process_mrelease
 449	n64	futex_waitv			sys_futex_waitv
 450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
+451	n64	lsm_get_self_attr		sys_lsm_get_self_attr
+452	n64	lsm_list_modules		sys_lsm_list_modules
+453	n64	lsm_set_self_attr		sys_lsm_set_self_attr
diff --git a/arch/mips/kernel/syscalls/syscall_o32.tbl b/arch/mips/kernel/syscalls/syscall_o32.tbl
index 8f243e35a7b2..d74fd86de2a2 100644
--- a/arch/mips/kernel/syscalls/syscall_o32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_o32.tbl
@@ -438,3 +438,6 @@
 448	o32	process_mrelease		sys_process_mrelease
 449	o32	futex_waitv			sys_futex_waitv
 450	o32	set_mempolicy_home_node		sys_set_mempolicy_home_node
+451	o32	lsm_get_self_attr		sys_lsm_get_self_attr
+452	o32	lsm_list_modules		sys_lsm_list_modules
+453	032	lsm_set_self_attr		sys_lsm_set_self_attr
diff --git a/arch/parisc/kernel/syscalls/syscall.tbl b/arch/parisc/kernel/syscalls/syscall.tbl
index 0e42fceb2d5e..d1a5f3120d6c 100644
--- a/arch/parisc/kernel/syscalls/syscall.tbl
+++ b/arch/parisc/kernel/syscalls/syscall.tbl
@@ -448,3 +448,6 @@
 448	common	process_mrelease		sys_process_mrelease
 449	common	futex_waitv			sys_futex_waitv
 450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
+451	common	lsm_get_self_attr		sys_lsm_get_self_attr
+452	common	lsm_list_modules		sys_lsm_list_modules
+453	common	lsm_set_self_attr		sys_lsm_set_self_attr
diff --git a/arch/powerpc/kernel/syscalls/syscall.tbl b/arch/powerpc/kernel/syscalls/syscall.tbl
index a0be127475b1..a414fe8c069b 100644
--- a/arch/powerpc/kernel/syscalls/syscall.tbl
+++ b/arch/powerpc/kernel/syscalls/syscall.tbl
@@ -537,3 +537,6 @@
 448	common	process_mrelease		sys_process_mrelease
 449	common  futex_waitv                     sys_futex_waitv
 450 	nospu	set_mempolicy_home_node		sys_set_mempolicy_home_node
+451	common	lsm_get_self_attr		sys_lsm_get_self_attr
+452	common	lsm_list_modules		sys_lsm_list_modules
+453	common	lsm_set_self_attr		sys_lsm_set_self_attr
diff --git a/arch/s390/kernel/syscalls/syscall.tbl b/arch/s390/kernel/syscalls/syscall.tbl
index 799147658dee..96b7e6b72747 100644
--- a/arch/s390/kernel/syscalls/syscall.tbl
+++ b/arch/s390/kernel/syscalls/syscall.tbl
@@ -453,3 +453,6 @@
 448  common	process_mrelease	sys_process_mrelease		sys_process_mrelease
 449  common	futex_waitv		sys_futex_waitv			sys_futex_waitv
 450  common	set_mempolicy_home_node	sys_set_mempolicy_home_node	sys_set_mempolicy_home_node
+451  common	lsm_get_self_attr	sys_lsm_get_self_attr		sys_lsm_get_self_attr
+452  common	lsm_list_modules	sys_lsm_list_modules		sys_lsm_list_modules
+453  common	lsm_set_self_attr	sys_lsm_set_self_attr		sys_lsm_set_self_attr
diff --git a/arch/sh/kernel/syscalls/syscall.tbl b/arch/sh/kernel/syscalls/syscall.tbl
index 2de85c977f54..1a75a599bb55 100644
--- a/arch/sh/kernel/syscalls/syscall.tbl
+++ b/arch/sh/kernel/syscalls/syscall.tbl
@@ -453,3 +453,6 @@
 448	common	process_mrelease		sys_process_mrelease
 449	common  futex_waitv                     sys_futex_waitv
 450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
+451	common	lsm_get_self_attr		sys_lsm_get_self_attr
+452	common	lsm_list_modules		sys_lsm_list_modules
+453	common	lsm_set_self_attr		sys_lsm_set_self_attr
diff --git a/arch/sparc/kernel/syscalls/syscall.tbl b/arch/sparc/kernel/syscalls/syscall.tbl
index 4398cc6fb68d..80b165091f6f 100644
--- a/arch/sparc/kernel/syscalls/syscall.tbl
+++ b/arch/sparc/kernel/syscalls/syscall.tbl
@@ -496,3 +496,6 @@
 448	common	process_mrelease		sys_process_mrelease
 449	common  futex_waitv                     sys_futex_waitv
 450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
+451	common	lsm_get_self_attr		sys_lsm_get_self_attr
+452	common	lsm_list_modules		sys_lsm_list_modules
+453	common	lsm_set_self_attr		sys_lsm_set_self_attr
diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index 320480a8db4f..130f9feb9eb9 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -455,3 +455,6 @@
 448	i386	process_mrelease	sys_process_mrelease
 449	i386	futex_waitv		sys_futex_waitv
 450	i386	set_mempolicy_home_node		sys_set_mempolicy_home_node
+451	i386	lsm_get_self_attr	sys_lsm_get_self_attr
+452	i386	lsm_list_modules	sys_lsm_list_modules
+453	i386	lsm_set_self_attr	sys_lsm_set_self_attr
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index c84d12608cd2..96dd45bc5988 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -372,6 +372,9 @@
 448	common	process_mrelease	sys_process_mrelease
 449	common	futex_waitv		sys_futex_waitv
 450	common	set_mempolicy_home_node	sys_set_mempolicy_home_node
+451	common	lsm_get_self_attr	sys_lsm_get_self_attr
+452	common	lsm_list_modules	sys_lsm_list_modules
+453	common	lsm_set_self_attr	sys_lsm_set_self_attr
 
 #
 # Due to a historical design error, certain syscalls are numbered differently
diff --git a/arch/xtensa/kernel/syscalls/syscall.tbl b/arch/xtensa/kernel/syscalls/syscall.tbl
index 52c94ab5c205..2610aba19802 100644
--- a/arch/xtensa/kernel/syscalls/syscall.tbl
+++ b/arch/xtensa/kernel/syscalls/syscall.tbl
@@ -421,3 +421,6 @@
 448	common	process_mrelease		sys_process_mrelease
 449	common  futex_waitv                     sys_futex_waitv
 450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
+451	common	lsm_get_self_attr		sys_lsm_get_self_attr
+452	common	lsm_list_modules		sys_lsm_list_modules
+453	common	lsm_set_self_attr		sys_lsm_set_self_attr
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index 45fa180cc56a..93f89fb06ef5 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -886,8 +886,17 @@ __SYSCALL(__NR_futex_waitv, sys_futex_waitv)
 #define __NR_set_mempolicy_home_node 450
 __SYSCALL(__NR_set_mempolicy_home_node, sys_set_mempolicy_home_node)
 
+#define __NR_lsm_get_self_attr 451
+__SYSCALL(__NR_lsm_get_self_attr, sys_lsm_get_self_attr)
+
+#define __NR_lsm_list_modules 452
+__SYSCALL(__NR_lsm_list_modules, sys_lsm_list_modules)
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
index 3f1886ad9d80..8492aa4a771f 100644
--- a/tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl
+++ b/tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl
@@ -365,3 +365,6 @@
 448	n64	process_mrelease		sys_process_mrelease
 449	n64	futex_waitv			sys_futex_waitv
 450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
+451	n64	lsm_get_self_attr		sys_lsm_get_self_attr
+452	n64	lsm_list_modules		sys_lsm_list_modules
+453	n64	lsm_set_self_attr		sys_lsm_set_self_attr
diff --git a/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl b/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl
index a0be127475b1..a414fe8c069b 100644
--- a/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl
+++ b/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl
@@ -537,3 +537,6 @@
 448	common	process_mrelease		sys_process_mrelease
 449	common  futex_waitv                     sys_futex_waitv
 450 	nospu	set_mempolicy_home_node		sys_set_mempolicy_home_node
+451	common	lsm_get_self_attr		sys_lsm_get_self_attr
+452	common	lsm_list_modules		sys_lsm_list_modules
+453	common	lsm_set_self_attr		sys_lsm_set_self_attr
diff --git a/tools/perf/arch/s390/entry/syscalls/syscall.tbl b/tools/perf/arch/s390/entry/syscalls/syscall.tbl
index 799147658dee..f9257e040109 100644
--- a/tools/perf/arch/s390/entry/syscalls/syscall.tbl
+++ b/tools/perf/arch/s390/entry/syscalls/syscall.tbl
@@ -453,3 +453,6 @@
 448  common	process_mrelease	sys_process_mrelease		sys_process_mrelease
 449  common	futex_waitv		sys_futex_waitv			sys_futex_waitv
 450  common	set_mempolicy_home_node	sys_set_mempolicy_home_node	sys_set_mempolicy_home_node
+451  common	lsm_get_self_attr	sys_lsm_get_self_attr	sys_lsm_get_self_attr
+452  common	lsm_list_modules	sys_lsm_list_modules	sys_lsm_list_modules
+453  common	lsm_set_self_attr	sys_lsm_set_self_attr	sys_lsm_set_self_attr
diff --git a/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl b/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
index c84d12608cd2..96dd45bc5988 100644
--- a/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
@@ -372,6 +372,9 @@
 448	common	process_mrelease	sys_process_mrelease
 449	common	futex_waitv		sys_futex_waitv
 450	common	set_mempolicy_home_node	sys_set_mempolicy_home_node
+451	common	lsm_get_self_attr	sys_lsm_get_self_attr
+452	common	lsm_list_modules	sys_lsm_list_modules
+453	common	lsm_set_self_attr	sys_lsm_set_self_attr
 
 #
 # Due to a historical design error, certain syscalls are numbered differently
-- 
2.39.2

