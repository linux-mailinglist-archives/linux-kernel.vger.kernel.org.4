Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12CEF6EB107
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 19:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233121AbjDURqo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 13:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjDURql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 13:46:41 -0400
Received: from sonic307-15.consmr.mail.ne1.yahoo.com (sonic307-15.consmr.mail.ne1.yahoo.com [66.163.190.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C56AE65AF
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 10:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1682099184; bh=n+nfYo19BWLbmagFYV+BUdXi84gdWWt8aRqNcziYgZQ=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=uPRCO5bPDNXyUsah7QmCcd6JFAmUhac8fTOp4GQkTm8CYxpIYVidp5VfW5ST+oh8YZZUzVDJVTgVBuOG5OliTq1OC868zFDxJPuxxPjDIXn2Wf/yO6Nsi5KcOaq6UChVJa92CauxM1U1RGKSQn/+nH7mGlJD6itXaeL2bGiSaFHo7M2ISRggJY/xEH5ZXYx+xpNubW52DOoLltrUKk3OIGRGLq0yNtOhBOndSmpp2OJJi6jLzoasURz2mkI4NJKJ92R8SGcT/VHR32caDmC61tWMcQG69T1cNDW4PzJrVsJGjd2mM51psnMkmOqml/2ic0lE1RUWFCDpAv+2C2YZCw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1682099184; bh=sTY7xGhgROzZn8D9dLi2gcDrY3j2GKkMPklWt0mltdU=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=Fw1Tv4n5p1qqKycsceEiFG4c1gP21GE5uvsVXuCdjzWS4RpN8OCJuGkPHs5HACmzTW48wsGVEvC1AB8y405IMzlxmm1rdxhrMSwyBjahBKcVsv9Arg2xZdfqR3A6wrVp9a9wARNgIPFs09vY9RMupKXi/3A8Zt8EOXpLCPXNz6sQSJXkbzGctd8Otm9kbjPlcZ2NtxCVteRUDEyY5cGn3W3II/0xJe+QAzN61Ntwbhyt0v/xNnee0to/vfkBIkwlIrhmdZhCe1scXgTUDhC1b2BPJUPCEd7mY7AD3JCdNuF18bpIzGG11iMU+E8vECZmUrb8rrcbCiE9SApNDj08BA==
X-YMail-OSG: E2uosOsVM1kktzR0FpJfagqPDfFsjP6aS90VBCHYf.7Y2i52d3JZb0h45GJV.21
 pNUdv81sfLzfgnoetUgE8kabzVvxhFnhuAVN_sj7AS6TgNkt5Ws2MdcoPkcpIRnN8lBxPu7_vI8E
 6b8otqDAgyI.Oy0YCEXp.aULQlUyv27i68wdKpQANxFj4rveS_uj0pH3jlJut0xVF3padqHtJSi0
 piHELi98pfpw5UBrDxGyUt4914jSO5TbzGd.min7h50HN9ISXV6WHO6Wq4qsONn4Jhiv36tkGTD_
 s3cuUMS7CXotmwPe12eXRJ5MlhvRJlOlb5fJpylcCkd6TipT5TkaInnSW6k.3PBlI3uUH43qFiuF
 fRykX8QyNV_Ty12_WP9efim7gxdVMLbKJY9zQiBaFwD0v_.LK5vuvD_1O_21l1jXdljMJJTb0lwg
 .3ngIQ2863P67pV_C26PcM3Ga_WibjoqwMaapHVW.VZBysk9UWTlhGVIOiQeUBrJI8BgYlLLy9Pg
 l_QsH4HruAGg80rp3o6DrFZQ_3RLZmU80RrPifNzyeaZd.hm2EN3_.LDSlJcnWBR9CRsk0QuOjSN
 4VmNhbzvrF7l5Cca5IbvCLZ7IXlVbRE_Nov74m_dPnw.qcJ7ZDkKpADSrmWYANLOaUD8g7B6_Esp
 VefkN.iB9xhy_NIsDsD3vAfxCi3jyXCbVg0h5DHdbon6tob6EWdc.z8k8D2KlNZH7vpXm_QMTHKX
 Awi9IoVVUMYqIaqc5iw3xxbdUK1.McaywDBvu.hb44oAU6GJoTGbFuDUPh1VE72y7ByTGm93PCzj
 LcUYeGqt2HZjGIew5OWO94hQqmx8RWnUUfHD7q2I86U5X.4aRWaMJIJAZ0dMQHv0bHGVOyLJFHJA
 aDar5bZdbASuBpOgJIPIBdpZU257yRy9SvQaw8N8iH_xCoX5yXxJfTpI8k3OtV9xgXI0zm.9uXLN
 6C_FGELHHf51eb7YQJ9s19B030HeYCcq5ubCITft6LfidUEZWzfJSvH3coMupNdgDO6S_Qos98H4
 ynn_aejf1qSTp70RwWkIc0_XlX1XCqDeiDb2T7GoSjWtZXGWe3jpesP2Ac5rdDGoWTL6OxWESgt8
 LxGMVBqMF3YFWMLQdC0202bw_Iu8wxciqsrWfHScq4_MePzJJ_RIULherz55.3U1gdgbcFx9oEJG
 TzOFy6kRdQ_QQfs7XSG4BBXNqd7BT.rkXjpThv0HS9Dj6PHCkRoC_Srv.etlYmBpZx9EXoi8xCcZ
 ByAsvcoPI1aSpQR900nKyy8wKzqY.NedPKhNiZqQXZnrA_NgqTvtINVeXIZHkG_nbQyBloZsTZBs
 mQI8dk4XCQtvdXgQfikBDxhuGbvQ3GuWMblOxkMJAiJGv1YEVYutjkJXN8awUPd4PIcVtSBhRI4V
 WSEDA9X3GAWZDGw.jxpuGXbOe9bTT4hAJgxE6mxnfosi46KavWLHqEzA7PTZlrk_pBK5u27gKDmK
 t1cweMmgwKzrsbIfx_FJhG6F1rNU2Vw3s3zex3U3IjvP.QhR54nvaRDnzE4viGMhuObJpel2lOBN
 6wbVXKrepBoGMSD.DN_JAAn_HZiPnIC5270w.Z2Oa8cAPEztNUjNWR37NiNNTQ6N.eCQhJ58vEf0
 .DqanbFVMQNe1t9UiyieNaloDU6IYrhkXP_zDQU71JvpMGuMiAQkmX8OTPIOiD2tYqvdYBaWBaV1
 a.s45QhKjeprs9gTgaqlH3YY1ID25KHLDogJm8H5eTPhr90EthPS9u2RUhnmcPCvjmKsfa9UCfn3
 RgpUDLBvPa_tf8.eDwsstSBdr3YE6tZWe5GFibuFShajDqtPVZAu.HWrad98tebV42IqH.wNCa9e
 0CHybYyOzS9vVtJNmIoTOjmr0JdzIwz_WsfePU.ttoVh4zXqStUqtnk03hz.E9ofAEKrcXulVWbl
 rgfttzxSSSRRxcMp2zKMLZcMYOjpGVxCy7cU5S8Qf9ULP6DR44JTgGhXWEp_aq3Kve2sKQf4EQuO
 nt8tESgoUzplcRHqVvbKLiL.2Ufasyzv0CGZs3wFF7yp10CrcDIO13rkRTvIG5LcMxxXaPhqPDW4
 TJeezbnQlvyxyc_CEankZ5.QRzi76Lsj6HEuOzfJ9UPbQXLg6XT1D9plsQa_skMzNPiT4yMxWzD.
 AyZoQSVyp_XUZe917uI71iJcNhXfjwteOulk2QJHxY7pOr_JIQ3_EBi5U41P0sC8FG7z50fiHn00
 Qrl5z1fCrkf5BUFqm2Ow3QuwAyHf0lhDYo.UXKV9q98rLwY5WqK5zSe4QC.uAyxs0kU5qGsoYYqF
 7AEAWQ0Eo4bcpXhJHQzoD
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 098ad97d-015e-4ab4-99d9-61e7bbc05687
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.ne1.yahoo.com with HTTP; Fri, 21 Apr 2023 17:46:24 +0000
Received: by hermes--production-gq1-546798879c-l2qgj (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID b7487fe0c5844b066c0cbb2b5e828d88;
          Fri, 21 Apr 2023 17:46:22 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey@schaufler-ca.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     jmorris@namei.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v9 06/11] LSM: wireup Linux Security Module syscalls
Date:   Fri, 21 Apr 2023 10:42:54 -0700
Message-Id: <20230421174259.2458-7-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230421174259.2458-1-casey@schaufler-ca.com>
References: <20230421174259.2458-1-casey@schaufler-ca.com>
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

