Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC1A4662E80
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 19:15:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237553AbjAISOZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 13:14:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237389AbjAISNV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 13:13:21 -0500
Received: from sonic302-28.consmr.mail.ne1.yahoo.com (sonic302-28.consmr.mail.ne1.yahoo.com [66.163.186.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D12F71484
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 10:10:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1673287842; bh=jAyOzaeZKkMIznekU8PEdLn+tbPrgLQ7vd2ljII3D98=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=V+2XYv6FzP1dwgtXdNFm8vWhAfNrqoaDupV5YVsQLatqizY5cL0/2OqFgfF9JHrzMk7bof0QADSIMIbXFG4r3l3Dn15mzCtvqfR4Pj9QQ4ESK5TgynzL1+bHXN2aqTRpY+zjfoI8CGrUwVFs1qNyty7hIRNHmwgcAt0YsLaLJQS/XPaNz6aE+3Q+5VtAEgpjzsPVBO5VFt46H37qErzdLQAXyQyxlQAbOhYSUknQDWgPhFGPG9EJdJ/PhZtucthr9GMrtGCGvh2IkMUeDn0ojgBe9jMml+7rbJPtV6mS4d+5/c8rY2+cwzdq41TSalhAPvqOqhwLWcroPb9oAjTqJg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1673287842; bh=0jrYtMXg4/4YNgqXNZZvmk9RMHekkEnkH/tJ3TqE0VM=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=GdbLGjilScaJXTlb4luajgqpeb1BADekqI9f2yxV4d0rOOLsYeo6eCKd1jcUAUaEhX0SQAztL3jbe5eQZMPP9cXHLDgP7k5UQJsZxYbGbvWjVBlNiwc1PZGFGYLagGIqHr9jBlSZ/4nkqzynaZeXXVQpRGfR3B88gpwEZ1m2exChth+EZXrFDG8ZaCsFuKLjCgsLZ27JU5rffeEOckpI1ONOL0nRBFyK3jP4hPvAcW+JzDEIRP0knK99DQO2eC84ve+2xRDP+EPuMBcaf7AqTeKwQnJ5NNAu6SRrTZUlwhVAsskBMUxL3wj9qgVKG/uj/Ap5zj+pLIYO24XEBKl3iw==
X-YMail-OSG: uMvvBhkVM1l9CqDFt_siogaXJEJCbXI5xVoVfZiIvQU9MQsprK763qnVXBtNJ0M
 71dimb6Xdjb9Nr81.c2WGMpF7qDVGl7qzkX6GRlsU3qrzZt7jypoWt9.9zzRkUTkos8cij8ggbLe
 hAt0pC2A8d78CccWK_s7pJXgr6iELWgVsSQazP3sJ8kErX5KADC1rumIMBayqek9ZQJV6Dr6C4lk
 QUJ53EoJltUDDIc.4dbKpn6groFvq4e4atcjgPdazS.AqAXBMmBsXCfRrzcRAN6x0bhRLeCy_3C9
 M6lOY3u3y.Q2QCcHCm1RD44i6QxGppZTFT35uW1.DVBBYTSwOZHVj7alS6wTydAYe6j.JlKXSXs3
 FlMzTXuFUCm3bFiTNUV5N7kpdQjGYRdZolos5cAomdMAREF72xzFJ.V3l5Wz_ILHDjmvtOrdS_BF
 L9YsoH1Bj7_IkJqW6j1jasjVKiTF5TLbSU5jCvnhSZnljH1qWET_rdsxxamrArPqVd_c7DN7XbiA
 .EtByxKjG6JeCv1ZC6Rm6c3KryanFS1lz8L2_jrSFFlpyX_AQgMN5d9WqPeDijy3170fbaHzkToh
 GCGrcCejy563.FT.iMsfmhBrYBDrRfqv2MwEj1omeJkZZ5.x3ysuldSp6V0DeRWMqoRAqAW7zbO_
 OCNeAAp6JIHGJgNpOcftSnxGuw_SbC7Fo1ipYCmFaaWRa5cypaCilnT9vL6uWr2Tp2HxYL_WAvJU
 L5dzQ1MjvBdYAvnw2slPmD5HCeEgko0TBPzLR6CsfblDNVfEjW7C9N.Drsx_BEuT3dH.SXEZnSZ6
 l5yGDCGZomXI7WbdLjkggQAc8jcivPu6YFXwbAQOczI5HfxuSDBjfrh7C27P0QgXXhufBRDjMGzU
 S6PuelaF9pgOZdunPIlksfUDbs.wFyTYefElBlF_W1d57tpS9KgvWxI76ZWUexVvnvzQ.vVdX1s7
 RRvsWQ2amn42aHrm5P2X329O6cpWQ1Yw5cFmsScTDgPth9ixc05LgwTPX.WaTT7sS7GamR4f8X3p
 _Aa9JNpNFzegUAdWp9aa4FJSMc66GdkHtDbVighDnEPQG4_IbvXhH5wSnd4F27cnwvInwpQT7ViI
 oV9.X6Hy.NnYKOvfvrqTw5ySoPXgJ5Kuu7w0qNCAIrCR6zZi.69CVl3uIlCP1nUOHusXm7MkYf4A
 dwlrVer7yBAyGnfz.yCBDFIxEA9uF_bf9pe1gGRS51.m.UthkggllBfUaR_Vye8GXC2fbeUcwhS3
 3BcM.NyTQZD4HyPWkuhjO3Vn_1VIdci9jBgxCDq0ndmQ5c_cBzjIqUvzh1uuKKe4Ce5qcsd1I60T
 FHXdnd0d158R20OWlkrYDingk0SktT1jpw160pWVGZM2w0sHVt7XSXHI1sJkXf29RxSmC4tsPVWL
 EeruGWxjpEPwOH9PVGDY0nlSpDyV4CWhUj7k4LbHz0xaabcykAZmBpkMMJUqoI7ywjGot9lHDYWP
 T_qsZU.I8n4xauCTp8AJRaB1BZ3rjiU0j_dWuQsMLP54eCEKLWloOoxhLWUUOpLP_cLKa5dS0CV.
 iUNPyEc3YnpXZv0luS_6Ar2VH5UE3h15HPSH4k7fYhk1nmkNwR09ynPrTnMc2PwduSzBg0J7Kfz2
 Im5NbFBK1Z76wBTr75TTl_B5baHbPkXrqF4aXcN9wOCqt22sh646VILrcnYTqb2n0jF2DN3ZpHOv
 ZWiE.SpCS1JtQbQbH4E3lIbnSqB5ot6NN8LU5ckHDuwUGhhzK.4e8_W.gtADQX_lJgt.8YMrdWtp
 0MrWpnTiRbcjzKhsL2hiZ7Xf_CJn6CVqIpWFxVxAOaPU88yl1P.bumTXiZb4_ocVJ6SWLr1HqC9n
 2ZjDdBPeVoPpdIfKBLHUza8C9l1G6Qt5gJ47HZOvJ3awMu3lflFyq3BbgaBFWAHmLLFVJIQ29Y5i
 WhLaGDNq1874a9IN_BWZF6f1kpVhLGWF5cZkS_k02SMP_3Fq.lX0yoyS7s9hpyLyj6nmotEt.GvV
 GDz0Rm1rhEVCkpfVmGYEe2nMh_GukiJj4Ne12qKYMyLdJFVfEFvrpylWsxdSNjRruXDp.mdsNNfb
 JcodjSjbFP1tGEYiQJawm79M9T80ksu5ht3tAX3pPZ8qH9yMX_WVdOuDWpVtX_IKTo8wKO_eGTFg
 Vj6sZcE.7y.kuTS8M28XMIZJD1wAqnF9fAOmcqBN0aL.7Z8HG3aKI8jTzNF12xgK7Vo5V3RQXyQX
 MG5BTfnHAXuCI4TcY8oFfeRxMF1wo1dKaQYFF2W70duBj
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.ne1.yahoo.com with HTTP; Mon, 9 Jan 2023 18:10:42 +0000
Received: by hermes--production-ne1-7b69748c4d-drrwg (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID d39a5b2fbd300476a1ee2f5b9fcd175a;
          Mon, 09 Jan 2023 18:10:40 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     casey@schaufler-ca.com, jmorris@namei.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net
Subject: [PATCH v5 7/8] LSM: wireup Linux Security Module syscalls
Date:   Mon,  9 Jan 2023 10:07:16 -0800
Message-Id: <20230109180717.58855-8-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230109180717.58855-1-casey@schaufler-ca.com>
References: <20230109180717.58855-1-casey@schaufler-ca.com>
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

