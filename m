Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FE6D636B09
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 21:25:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239896AbiKWUYH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 15:24:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235267AbiKWUX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 15:23:28 -0500
Received: from sonic311-30.consmr.mail.ne1.yahoo.com (sonic311-30.consmr.mail.ne1.yahoo.com [66.163.188.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1099D2293
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 12:19:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1669234761; bh=eGNezGUqI6qnOQo0OwR0DL3q3SV2ptpP4mwAC4YsFkE=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=c2aV1ZjFz9s5PcO4qkjcd84r58MzTISFVhciBwHdJW3Xiv68WRhGOUqPYU6sHC7Ykq3j+ZgjduVubZGpE8720NDjBEnc9mW0Q8re+ERSIUHznhFTsdWEH9/sbuEJsUuQVldjtlm0r4M4BMLQRXBxgw4Xn6gzFq7UAKXam9MEjSlCysBy7kFhiYs/aICmvkiGF3s8ENrw5meBSiH+/e7O/QfYx6scWylMmimzx5cI0pQizvqA+w09Z8y/Xo1fluY/k8ffXfeCzeK7Hr22My/nnF67VZeJZ+nt3K/2ckwF4SytrFDS4qCe0jcPiSU+d6AQ5xCiQLwteXStwg1rxuD8tQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1669234761; bh=X62usNcZLL42sm75slojSWB1U5Z7RUP+/U6Hd/ra/Tc=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=dTlAg4CJTd92wPv/fdwX4Otmd+0fou5FHSBJP/KVGIqZtyh/Xm5p2HZgyqWqFcZir/XZ2V5wyK+xzeVLeLXdfYPPW4vny12LP7r/0aEwgWKklDA7VDQnNfID5jb4Iv/kVCufpMZDCnMjd8HCiVyw7F6hEbepgClp+z5ioEfsIlV6BnkhUlK6KQ1OOod8AjslYJAC6STxpcweB6vSDwjVhnj6IiCRK1EfJN6EBYHdAxvwETVpQrD0T4ZQOAxI6qMd4WkFuFc5WcgZmo4s/s6AS4wEo0G+QCBXtZj6iG+5IysKEN19NzVS0Pi3SJlKHhvaCNg+TrF7STzdaPdtkPEPKQ==
X-YMail-OSG: 6eH1owAVM1lrTndoJ3O4gG90bJWzAkN2tJgdveFgqSRo16zs13i_6M92IOlgLxc
 yr2Bf0AhhV2LQPM_fPTXNuEKnrvULjHUTujEDpNgOPyw6fcUIgZGpXdXbHpUugDHHDEJf.ENV6C7
 85CkApoMEyq9gHy2GGBfEovuttUkQ1f9Mb_YNuoQDrqhN8u523XJu8G325z3x_pkgqki6uNZeGIK
 0R5pc5tLUv3Sqvdmz2cyZjusJTdG7saWxGTC7QIiH7w6UBmLb.xCzjJ_1Dl8RLFbVWD8MnIbK7Jm
 cOPeYGgq4x5ENjuL7JwpRHDLpnvCUlPkB5Bs5.c8NYsHY6_StvoKQXMgfvpb2sRTocxm8pbm2A6I
 3XrLWAy952yZihYLTm4_N0h37f4920N3Jz4Xieez__cIK_lJPYu1PeVRBUrJXHGqMh0gs9Fw10o0
 O1Pbo6qTUJqqDt7QbouJiGPqY_NkDUUDq2v23ZB4kP.cE38F1S0LFdUiphgOoazpnsnVQySuC86W
 VOeVtly0Z98OkmpSxSXZ1oxaYuJ1VFxFoRZKwdbSNQPfChqnwJ89GnqKn4JLXf9clYcg9S4DOJ26
 1wlJvAkeYRumxPL0ooEqsUGvl_iq_4yxfq2p768pZv.wSxHpdGcIMtAFG4OYbtsZ0KID_ePv9RuS
 GDIMLpgQECMLJwgboJhi3Ppsc4HiAuF7qxC0nXgYvXpar1jdio5NssC8bOEZZwGPxN58xn7oG0CP
 Iktn0ZC4OoWsislgKEi1_5X4KO29VUAP9RZv23MqgByz0wBFi1B0jrRK5SR.WiRUN9BiUxKUrHTV
 WXAH9zOBlUDJrYf2RnmnV68i6TO8KIMZBtExU2iJGs3mIxO7BBnglLEvhPL59Jpjej7_KrXxg9Ws
 kugIwmxIgX3JS6.ZsNyqq9TM2dv_KEzJHNl.1eW8ShSeB0ptsvnpChSeyZZ5u_w_sCYMS0vh6Gr2
 KlI0h0Bhvw1YKcPoaj2TKc9Tm93nH7FMM6B7I.NP8WZVT4Au71xr2P42YxUaN6NJH8OaYenQWnr7
 ajqMx1FJfqUiWV54gsjU6mcHDCZNh92kuYvoEHNaE2xL6uLVGdp9il3ZY5egQscC2XbW95m9ohPh
 .Av35V9cx0UGgE1Kji57Qb9rz7_noWbV4yEvxMx8ilbuMXcdCBQ4dL52et3jueMcOJ41XSDWiYpN
 X.4tIVrWrSYqykMPM2.puh6Pmq2akkbZ1fbfDJYvXnCfszVKfFtrutzxdwGrhzLvbpFs0lITjFhW
 o_RwdoHsI8NzP4aH6bStnbSUq8yHEmm281PBJOwgzDIu4rwVxFhAlvXj0W.khDoi79eeCVU1g8Ct
 jUinchkiSsDVYYAXfRr86M2hYTxcJzPBlplLpr7qMd8ETOAA7LnFcp92SVUXj2kJWsWUzd7P56Af
 Ey9DaMNtA55jCgIEde.mtdPJZ4YRwqAhYv.i5lcGsTwZARqLV6ER4rpeHvrbZlq_ab.LOjjFZoBH
 OjXgmJWrTgi0lDQsyF9YnOm6ZatQ5dA_29IXg4GXXyBJdDdsJYfn9jiIvBq.PFeMpu5OG98opNfj
 IZj_vDZPXjrWHiqCMxJRAegR460fVeR_VyX1rXx2mvLiIDISKlwW1DvQwmV12PMRQuiA_exkqvhQ
 RGcc0NVTCrD9KcvcSpDbysQjvKj83EbOhZq9IQQUCNw9nG7FrvbcbJIzPmLR0wHEdttu2hQhK1zO
 zzHmR6NYI9rpgDCfHwS8pTEIJAN4nT2WFY7NwgaKovWb_mEGDA.DjzkIscGCuEwGBRezzzFhioWX
 cIFfNyKQ9cmQ60V1g.YkdGVAEFhHL5aBjq0gjmfa9W37gAkYoBIzxi4.eikbDOTj6T7ZtYGaBWjL
 65_QruCLbl6HEKWxT.pK.BJzZ.HvHhZTOPX774W6PzNP1xayzLW..j1mO9JuWLPcnXMfax7mxoiO
 qwdVS6_sdXPdBm7E60f2i5f5xtCtfDcIzIoKMs2C0t2xZ4cX5vPS3098eMH8KNFNM28dkptgBBOe
 YUMFXg69jxjdioYUcKV.d9Wr14mPQfGQO7272nBziZPQeFGyUBDioWMuXk.sDq4ez.z0xud73_B2
 lduFNmLi7C5ViNryeEQm8qbtT80Ww1M9dM2wZPg.VRJ2bT4STCaLNFAt51.60rGtAO5Im_9OYidc
 zKCLP4tHFA7maQkIyf5xdYTQjAilUobqMZK3Rv3T5EPFzV4S5GP_zd.xwNYNeicsY.BK6cLK9y2C
 yVuCobtbi8gwQu7EqjupOQOnhUT_j4h833aurnUFhaT_tOfk-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Wed, 23 Nov 2022 20:19:21 +0000
Received: by hermes--production-gq1-579bc4bddd-b8ql8 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 38c80e614aa0809f99b59395af46cd39;
          Wed, 23 Nov 2022 20:19:16 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     casey@schaufler-ca.com, jmorris@namei.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net
Subject: [PATCH v3 8/9] LSM: wireup Linux Security Module syscalls
Date:   Wed, 23 Nov 2022 12:15:51 -0800
Message-Id: <20221123201552.7865-9-casey@schaufler-ca.com>
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

Wireup lsm_get_self_attr, lsm_set_self_attr and lsm_module_list
system calls.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 arch/alpha/kernel/syscalls/syscall.tbl              |  3 +++
 arch/arm/tools/syscall.tbl                          |  3 +++
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
 22 files changed, 76 insertions(+), 1 deletion(-)

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
index 8a99c998da9b..ea5ca5f70cbe 100644
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
index e9e0df4f9a61..bdedea2aa778 100644
--- a/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl
+++ b/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl
@@ -534,3 +534,6 @@
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
2.38.1

