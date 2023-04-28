Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06B7D6F1F64
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 22:31:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346662AbjD1Ubc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 16:31:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346592AbjD1UbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 16:31:18 -0400
Received: from sonic310-30.consmr.mail.ne1.yahoo.com (sonic310-30.consmr.mail.ne1.yahoo.com [66.163.186.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8103B5B90
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 13:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1682713810; bh=mXOixrgll6cVOviBFIZW1CU4gIjyQkuFml+qMEmEM8g=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=hW5Vtq945MXKTTX9F/uE5fAEJaqGZf2/LsKEamAZHckO5NGn/31DcU5Tv3Ag8AUB5Lc0g4PpUSFXR+YE9V0kasVSNJc5pTVmeqM9fNSYlpGO86yvY629bT9A61BlIevnjg7yQn6wrL0WNGtEqc4GxWJAcQ2LF6mCZ7litQ69hRCa1u38395LxMqcpt2QjGA3SlrojuHh8TblI0a49gRsHsXzLWoxvYnER6w0z+zPE+6VqW4x1O8HM846VU8HMBeaza8XZl2/SfOsbkJWA/vamtBRDr/At/e5yeXgq0FalPK8Tmf4BUfdudUal1rCW8EPddSmy9PW4NDioC+w2hmgkw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1682713810; bh=CarAmnqGuybMqmlhIO/v80Juu8fULu6h88aUUxIuQFf=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=bWjSI6etmqkZqVpYUGrDSUbSKR9veagZmZPSiLX2OudGarDL014gP6BZrESUXaIhSlahvN8NYnDBB1Wy9fqe2fECioNxtgcvEjQgx7t6B0DS53aKuUhrQ0NRrhLc9v2i+7Hm3f4hWkJlGKNd4l8aqLleVWHsf2NJpcqZt+aSU2adOnsFlmrWK3znM3swv3dA5XGtth+56z3qAZsvQuBJT1rZFuwQDuy9JAU+voyn8Zpb5iuheDynS/Hh7YmwkmftigRagQFq5bh3rOGC1RKeT6/c4fotr6q5grSe3yPRBVTpW3KzzHTFXn/KsmRf0nWs64sLTKOgAFQlHT3u8jqVdA==
X-YMail-OSG: SodbxGIVM1lP9VgDjPEMWopMFT3BGMLqWZ0emSoJUDJcceOoajL1G.JIjuxnz0T
 YnU7mut2Zh.I8MDjOV5TdmrASTXcVr27KkKDi_oAkhoEjO48WZo.HfDpWhMoeb6aUYm_ls4yVzdr
 cilpUsoxsYt18gxKdgGL7ZuiIQKh3JdoYKQqzU7TtCmRpF2_dTHgmfNkMnyuRd4RW95Pw0O3wqf0
 bP05fXhMSUuM3oTPP8yhvd7eAbwtKveMS.Lp6Z0thyiEH59.Wq8IVgrgDkW0cbUxEPHFcnujFO5V
 qBtDOwcPMgc0DDHridtMzmqBjiB8KModlReNXXaGXEKQYT8Ixah.8Mlsk0GDqElWJq7b0W0B3LzQ
 vp7PsUlfZRnW0FLLh.6uFvWoU8EZt40tKpCWdA.U9Asg0bwCHqhL4vjPGpaIkyssJrIYORtPCFJe
 tg2zVYbPyP9Z6nH788OwZGTLxnSRJTmUxSG2wPjK7FnbbzJ4q7orALWkEWv.xkorvIMom2ouBWaO
 PgMKAQB_YQP1Ho1M3B2nEjS9GLM59cssgu1J3oPintrbRu3hUcK0PpFuLnAtN70QZzLXYWAs3s3r
 jgo_t_xAXRS.UpMqPGPppFobmb1EaYqyybgZAQC4ypn4gK8SymZV_ONLhwzEJzyL1BQcCInbOIm6
 miEITBXkEJ3Jou83rexry2qvKANa27mSrYwRUwEOSQdILLGM_er1j9EqneqVzgTgwIaWt4Q8aEcS
 YQHDPqmXSqAQ74wN_SNoJgJphK7eLGAd0ZNnFAIjl7Ri4JgkmuSWDBOXIQGPRFuMKPDvhshHZsNR
 m4o0ozh0_Yc7NHKJjhi6LBBGcQiOrxzp4DMSaWRqM5tOIpSGORdSCuZv.4Kt5AkQJf37RdfNo_cl
 HDLDZOBzkOoEdYfw8zkDwwepH1PUmxcHgiUegScFiYZa_SJhMHRODUcXXpxTPdjwX5Fv_OUpKQSF
 ExuJte8G_LXAsN059MWV672_Bq71amK_QEd4gs5xS5IVtaWfELNf9FrWjJCbeBv.wbOtb_kr_HH8
 MsIAEJHls0z641Zl6HY2Jcv5biUPPwYH2LBpxHx1iM3Pl6qmU6T6AFl3R0RreyuVCyyxmq.OunlZ
 fP.z0wzNWviWswihLoqXo_1WZ1cFU5kH9BeG.sApF0pq5NOo6OQ6gBTmv0oDvcKMCpS5nVaOhXjo
 9VHHImboy14HxDaratMuPpPxSLw7CpcFV5FmaLrHNHx0HZB9k_L39XU0cLJthlLlYr1YLAMalGNK
 trrItRyblB5M8xwRiwwxQ1_kLoutcy2xIGNZC5X2N6Cq0Hj.ejlvNK6gwYiG7yn4iTdVktRSJ439
 fYR3GW9Zv.DZY4aWJEp4TNJ4Sbvg0PS.bP_QYjmSygbOmhQnTQ906vz6sBk5.HOISChG02uoFty0
 Cdeney.fyOoqs0FBRXzLeK1r9dyP2lX2qoo0SvA6oc3uUk_ZpT_whEzbQ.J1rpXBhOsLXftx9pDO
 5IPhwrz_AncVdTuuwetjuLjzEEBkEPb4FobI.3JwR6uDhToNf1hk9XB2SRIIagLGZSN6jfRLNESf
 ZVq6Ege4lMnE_ZKhrN.dVfHYqCPIKRuAkGgdhMqfYapN5Zm_IWenisy2g2nRsQjCDtkhYc1vGu2v
 1XPCCLkqh6ANoTR0HuJCz4GOH74LDDBCqatAHkdvgiwY_gYEZMMDGG5VvQwlYgIWHBndC0210Np4
 9xSf4SMtrEvuD8LU3SLWv_3yr.y_e1uZV3TaLwu1nCmR79HhcWtULoCLOWQJLxHozqgUn_a6FWBl
 yoUMQai09hzxO1ZjLhAGCG28245GB9RCwpftD2G6AvkH9oF2FHFR5Tk9krzjDns8WWZ.UqGCnksY
 6K9TL_rrmxe2OZyFTZNSJnis0CA24aB8JSO92g8lMlJgMnKJ5SjCLnyuKjpxhPK0W7n9FdfGu16P
 wsrLPAFKJpv6am6QJTWGgULks65hVB9SW9AjivQMHGoDoGaufmn32bB4jQbnZ9ZTUCdlynLjK.My
 g7nPEx0t0Fjj2sGx2N5Cq9MP8.nujuz_vPItarwtrZL69SYr_nMYwlTkMmNO97dbWCDnUJxRoAsY
 Q.H2R2b_.4VLRt9o6FIzmwmQMFxZncp2EjHFJNBavZfLkKAygJ6w9Vdr6IIJyKnmC2y_0Y8nDndC
 YnBw2kBsQUNHXC0va_4jmCMA4sDCdsiYAnYrpanEfPndvTcJf4_BA8EWWcSIV2SSXNqkx9sepxQ2
 C0YvtPXckCCArD98b.pftXZ72CnxYGAyYyp_IOGIFeOHzO3m7rhAQyQOX9gbHqmajC0Z4fyKo2XT
 FlEf.egaifbquGcqBDzgZ
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: cf1f23a9-b714-46f7-a0b5-f26a9314e2fd
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ne1.yahoo.com with HTTP; Fri, 28 Apr 2023 20:30:10 +0000
Received: by hermes--production-ne1-7dbd98dd99-84p8v (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 16afe408a2c159011f8a869d3993f797;
          Fri, 28 Apr 2023 20:30:08 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey@schaufler-ca.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     jmorris@namei.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v10 06/11] LSM: wireup Linux Security Module syscalls
Date:   Fri, 28 Apr 2023 13:26:46 -0700
Message-Id: <20230428202651.159828-7-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230428202651.159828-1-casey@schaufler-ca.com>
References: <20230428202651.159828-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wireup lsm_get_self_attr, lsm_set_self_attr and lsm_list_modules
system calls.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
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

