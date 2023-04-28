Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 441AA6F1F8B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 22:38:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346615AbjD1Uh4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 16:37:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346313AbjD1Uhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 16:37:52 -0400
Received: from sonic317-38.consmr.mail.ne1.yahoo.com (sonic317-38.consmr.mail.ne1.yahoo.com [66.163.184.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 205D2359C
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 13:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1682714256; bh=mXOixrgll6cVOviBFIZW1CU4gIjyQkuFml+qMEmEM8g=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=Os1y3YNbbYyes1TwX4CiW/XjwaLmLq2iTfnZqdI5UbIMI/0zcCFBHupr5MlMZ9XrzeK4vOny/ZRojXDa3begAM+62YXDas6jA0369SDr9BHv7ox6WdYwuJklZelixynZt0DREv5rDKhIQ0poEN9342MCRrd4nVQRAsKGO2y/W/oZRODInU3rk1Je/zOFDHoon6X6snMYn4SdX5gI/e8ZiA0bD2qJvyCTbQoUZexAUH3TQ0UACGo+CGld3uhXXqcVUZNR7uhmVA12wpOnvNK3MFEx+YQMkT1bjutG387f97HKTEf36Wm5iRwwMTkpJjjTuVQ/gDRNbBKdBYqcqREBZQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1682714256; bh=12THlL59PQApAVxbXbrCN0b8JyuxoERBJ55b6/WdQUo=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=OuLhUWH3ndmuWRaTG9/BjWfJ59fVuxpLTzf2dc0vLfIvY2+hvQkdp+gLnz8YyLUC8brZN+/Vq/fCL+O+Lji0L6vNZKq7feuI1FWeSWx2Z1X71As/Ql0OG2c/CZgUkd0DxreQBOzOrchOaQ9ipI6xV80JDFptIccLT5HScUDWL8tXfwEXUBxr2nFl1vuy0kRBJGISMwCc3AidpxyH/0l1Ey9QMv2XhcTnd9PAV3L6WDH1RqzDPjGTSbte8WrZ514YhpTPFPErVud/MhuUvjhS7KgZKq0N35xqN8W885jqyHtPSGWoS+OQiUmT4Af7tWmDaWSWeh21kU48CEM88eFvag==
X-YMail-OSG: iouBPhEVM1n785SaJOH_M69cT2wMv43zfY6HejHyzt5VhOnSjkHuO8ILA2aTmyb
 0QsNvapXs_0uvhnHfUR06YteJeEgHHSeq8ezgP2d3AgJKZl5QHvNURPgNkDXVgLnWDN7aqgOwCcP
 zWuk7wFRHqwd4YKuB.vlcGeqosn.I8ahV_MuFerTdRcJKeUieL3rEdIHwtM5AkJ38myLDfu3EnKz
 0n5vLrc51RclMjnUYoJA2bw0g2MpMN9bjY095h57zDURzuSHnpO9YnbOCM4_4UFy1gIG2f28.F_Z
 QfFzZvwm89FW3MA9g21GIkRYMiKR32EC8xbUEiwMFAHS3HIeLhMQ.lNDny5jHUYuUmLf8DF7cLPV
 AKbJIOt1XL.hT2sVEd6qE601_.2mi62NvG1D_9eitSS_Y2DQyUDj9pB3Bl5WiP0z94Yokwv9NBiv
 T.qrHDIj5OYwQ_EXMvZNbY1zeKcXhzWc19mtVFTB2cNe0MmKhyuWJVCZN_0kXDHD9EyRhHFdWgOx
 bzXiCLo97RpDMoBmV4qpKKbPKQ4AV4pPlWsUZx8AzchqsUYjjE_Y7j1yjm1dvRPuCcuAiKuvzSGV
 DqAtVB6Z4mr57Kd2329nTjU5eLkD18_bUPzXCW43_XKEzT9kp7Gr5OYj4Dj5oyXCATuxAv6Izw5s
 XzFhiRfOQYOIqC9w4an485aeI7cPY3nhoIEQw7Y8733T8clJ_63tjiXF3tamGYy.l9Q5KtBRJSOh
 R9UR3MUUv.VDERq4xPG15nSSJxAnNuQ7OnsW5NStqljBTgSF_fhMgPOyu0XZxCnEUbGnor7PoNPZ
 r.U9X4vQmRgysei4KmpRk1F0yyw9VLUKXAclKA27oktNHoGSrATITu2HBfZqHf6T7rzFq27ylV6A
 3ZV0KmjM0fyS.cLGbYxnfDp0pooMHK2HtTDu62rBznCK10RXFZIo3m_y6nGh31iic2w54Fk1cNZs
 ZctL.VKzVTZ1nWFU39sz4H9jhxt35oc5GL5OlyFcUhD1aq99fAUpvOA6.9s7_DAMJl2E7R7jgXH9
 f.2tQ_LE7ZXtY6fWm8ChJddisA6wGl3rXGWpYkqLs.wr5ti7iFQB2vxA8ats8aRb7iU.2Yqb.61q
 Y7dP4E8SqBj.xwISYJ_Q5ZcPjsU_H_LguuJUn9JGR8jltPbUMQvHOByRK9ALGcPyqlAfS0PkQHUO
 T_vlSFis.NChkFRqep2jQQlECDLssCrbQPRBVVzsjsdhToM._6lFPQKz.x49A4P2UiipevfR8hii
 vBCW5gaNILeeejx1zuoHIHNal1HbendOMutz2knB87FwGmuyOBua0DPlKO4BrB6DLzopCy6GDJRK
 TJsFO_imdTx8g.ZOtLAZvfC.ldg1cvrmNLcyovmXs5WK67Uk3piD8src0zoYkHMjIamBUPjgwdnl
 Kcu.NEm0cwiOP4HTPLUrWOzuIPKyGWPr3I7eitjCjpBy.3lhSJSm5YlTf_v81i7yD_dLwxtpVAAO
 YD0EGd_j.Yg2fneyYnBYYpMS_wfUCCIXvbQgLVOvbGDDz9oVpXCjkbJkDAorobE8Z_pwHEHNyieK
 GTOqUoEYmzVB.5MgWNH_tkd.OiHZWv9ZYqN.nO7OTVolYCophSpMXG_p531cTkn6pMF3wd.SOFUf
 okT4f_VH93oDa7A7kOTY2I13CwXCCxan6MExC.5EdfFROm2h_xoRL7Vb56D5.UIiUWVzb4kAw9jH
 P.ggwXIE8IOJj2lwvKci0S_1w74d3cZqHrgHutH8N.VBr5hrM0vsyLicE4z7Q4ce4HRwh5hylybv
 ypnMcfFgLYB0wWfOJaU9Mi_bPx9EqwdOR1qULDSIFgGO8sS1SA.ATn6gCczpLY3YGczbJOB81WYC
 4qYsa9.b9HLPOMdLjytsPHHDoVBN2GfRiLHv8Kz_IoZMHkJ49EixPc9wU49eT75VdlGnIVd68dVg
 UfnwtU.v4TLuud7J6zB4K2EFduWBpvW0LwjB_WLic4GSvtYWmRFJDcPHPsIlMBi6NeNZGvm.yasO
 RcFuJM_ovtXbNN7T9sbLPHj2JEhTBLDZbxAwQciF8MDqFjWUGOMHLxjiutmVk2d.g7vK4wbd2KYD
 CR6jmWN61CCjRfe4Yc1IyVJlbVcW7bBIdbrah1HxZLZ5GP2NaSD22kna1rrYHVnTEnpbJ5Roqg7S
 F8oK6ofpSyMUDsXL6cn_qp40Hjx7AA8gsWaygDNk1EjCFB5uf53pimSk.2Xz6Bu8KqFJxNLYuEXw
 juAOCLMrbLVskv13AFIrOjpIoZzwIGKKV0OasyE652U91SwnixD.m8DU8SJl3qar8DFHk_4KC_bH
 pFpEcUCTjxL0UiBY3i45PjbiRa2y9Z28-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 4d870f10-17db-4c7a-9f90-3f8f3bb0fe94
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Fri, 28 Apr 2023 20:37:36 +0000
Received: by hermes--production-ne1-7dbd98dd99-vd22t (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 7d01bdce50daaea0f4f6c5183b4a656e;
          Fri, 28 Apr 2023 20:37:32 +0000 (UTC)
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
Date:   Fri, 28 Apr 2023 13:34:12 -0700
Message-Id: <20230428203417.159874-7-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230428203417.159874-1-casey@schaufler-ca.com>
References: <20230428203417.159874-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
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

