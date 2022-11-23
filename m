Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E25E636A5B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 21:02:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235566AbiKWUBo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 15:01:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235580AbiKWUBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 15:01:07 -0500
Received: from sonic316-27.consmr.mail.ne1.yahoo.com (sonic316-27.consmr.mail.ne1.yahoo.com [66.163.187.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDFA374A95
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 12:01:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1669233665; bh=ol1pIH4ci4A8s6ujxzI53vrv6ZOj4gMh0L/Sc5n98Gc=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=homAlqzyHMlmBnJTRy5fJ28AoP2Ge9CO5wt4gkPubhOqxoVGWcpWGnDHjrc0xbaYVv2WRbXJwfjjkZKmLn8M0WuXt1c4nyreKUqlMMohNYLZs84wEma5HhAf04zyphZNjZFsbpzy6sND5Yj7JHRMvxJAoMqn94ZIgHHYZZfb0KJ+p9LtvM3TgHv5FmxpfLqHIH3tG7/CEfbd+CSd+5pSH1PTqwve7ZEEW2vaE2wE8yZlcirg46EZOCOJxGd80t5lDohpgMWTi/gLR4VmaIODE8CqEVZv5FqygB76AdEmxFFsMBg4x/trNn7PWVoWbnFr1l7qfpHQWUUCXmAd91Sy2A==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1669233665; bh=a4I7uhLFHgnKwA45BtF/hIbgG4/aXt+GAGd+A1t2ZK/=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=ksJby16U4yIn5D0hFkwCSukx4GGXP411hXkLam71z4eGKgcXs/qpIW3uQQUBI7YnKux7XcgmvlfsBGVVK+HP8jHHW9XkR06oI6EnA72k9WlNPfrFnQKXdSfUv/vuY0sJG0NVh7ZikZXtHBdZcJzvPEefYae/J0aLdareH5AD+ODU9299nA74Pln2oCH1QypgIrRrdvUv8vb7XdrTtP/xGgxGbbVMFMGVzoHvsV7A6CEMpH9FsDXc8Pa3H1Q4TLPZYc0Ix0GIYPRgQBzqnJt1k5jI5rM5tRdjsEKzadgmP+C1to9Ac2AhtGjtF08t/lyaH3c4aCANEXdQvdV1WpLTfA==
X-YMail-OSG: .TOhnwsVM1k4Q58yUKij.Y3TsB3XOxqr8uowS6H0WAzLEhNQF3PFn83SwYwPWJe
 dm3TuUiTWxNpCKMYaUvL7UNBenidwm.a8Y8ri.guZXaC5kQL8UN5KsUzWARiVOJru0hgu1VGZbcA
 hwZANrLBSS9WfdlScY8OjYYrXXkbmYPXMQMaP3RASP2iI9ogBHdKIFZ79JchT0qgz9CKZ5Gh1.oE
 0oxM20wN7y5pspWDix15PkkhcZuWVRS3C9QahFyLzThaR1NLqb5ipf5UYwJBdBmgp3k2YyNgv1M_
 tA5CUjrIKBzLTwqpTGalprrAuqrs4jJ0Mxq9WVuTXbywLKhU0QztNSLTERHle9EeOsxtwbPBhG9Y
 faMFWunw22YCyjfyQo2F81cHnbqsTf2SDcPEo3_jxHjGr.kkVfW2Yg8iEtMi8TU0EfLr9GARfGKV
 VC4.nWYHvQ.nEJrdBzJ8BfTNS2gO1_d.8lL0FQclm9WfCzeMq0l6mwqOlyzHbJBQFh6Gk3kvL.X1
 V7SUputSXr9zEJm_hVOJUAo2hol1qesktZGvK9SK82TgzeJGq5kMMwWIRZvHmvwRRxbtechVntgw
 s1sY1Pw4lEMiRaou8ufa_G1fQj7mIy_shWQuIW94RuxXF1lMsl4vW_BT_jSbYePfsiWvaAi6l_Ri
 XpAUGy9yC1gzOCouT.K9mVOhL3vX6_Fx.lS3oADPVUvpq5zWTljcY2zvoOFt77NVYs3_Aaxz.sSx
 H9yT3tMvtZFgr3GiDlmCNM4O720csIz4lLcOFNRMYfHuVlYBA_koRGJ6HWvUe5jSYzdyZmzwzhXn
 cO9cSi6iqRvNXMZE3mOCRUPnG6drmKnIUVm.cQK660.o_QbID70vaPc6_2YIMTgjBUZ2gPV3EN4H
 HFP2PvzikSP6endxexeZ8Rr2suZ11t0X712Z8hXyaB.3.OKa3A_RJeFYUoALezUkhhTsgnJAkTE1
 BfEnWLjn9uY9Cmk21KYebW8dygFDdC7NfO5p4.Yt5qktKz_gBW94xuqVwCH5MJlVuf2vlIN9Oide
 Taz188vVV2g3IksbohipgShS1UjRetbsyCOB3w7XcEKb_0cW3CV40J00DrzTaWcl0KSGwvzfz0jK
 VajnJIvf8QpcdnE0_4nUS9DKW5VR63nQuH.WLnQIAeTSw_RGf3P0EFW0hzvv.r65kyFus0I0m8H8
 7OBjeBERhcrNrmV3JTQPCkPaguJgPGvTNsN.zLIHxW4HrNkZp6yIQzYwn7xq_t2usSLXorgD.SUD
 64IPvo6OcOUncdJ56CPaqzZsNdB4ePXloMth5kv2NkH3h1ueSTBUHWlqlJbP6PhywyLeouUVLTt0
 GmOaLORoZiIdkpAsgOednLl3TXlkzpwwqi6FuziB_yCErvaeWK7EMXKXdLfC56_hrSdsYhMHs3Te
 AwCh9XkOTr3kNWy3N..AwoHJQW45_3mY3K7vGbOgo3UdfiO44K0JirD.ByDNtOacGMafMAvrIDfd
 dOeHIYh3RRczUKkHJfIxalMaKJLN23A4fJd1Unv9DVp7cvmxdK_vp92vULSwLiUVlCefNlgf3koB
 Oga.zdVTPkTeKuwjpXAtiLTZ06lHIJ7Q4zCebCtzJSzhTk0Jz7B0NQQndkzKTDmYYC9UUHJH2UPG
 12iF3MfEu38IHpzmiqxIeGsPS8Euqo5WLXL3k7Et_Vr2_wmxkF1lR5syBuKhLSi9kgC6VmrHXSQ.
 k4Xvv4iSO6sBuOi15zW2BeIIbM4oXtygHVYU4rG08e.wf3R3o1wWcbq2PKPFqLjig6nASLYaVv6i
 1_ULcmgLCFn5FGRcsLh1iyNg0.aYrmbbTUARdi37mgjbAmTzcGiLoI6iYdNGn5nYh5cmZ52UNMN9
 gcxecyaggYW4bweuFslT_B_eWjwSnGjz5YXx76f9M9sHKN.zlnlHPdLsmw3WTvOI8Pssmj5LFxo8
 N5HCDVaJaZRPhBV71ermOP7OPw3KytbBTKq7AjRJUcUwBTbunv9Lf9aNJUJq5L2YCmHB8w3m0V.R
 NBeciAaDFRuhHAxH28KWTn.gHjfxC8zEc1p53eUb9yyS_eRWqn6ZOO3cwR3xEZVTVTvwExglNt9u
 OINsijenHVxjK97x0YF8ArQlNOfskRQJ0bJ37nZUMwgfTdwEZMjyQSZCC_3ldxSRqYuESJnyvbxn
 ZQXTIascR3GsaviaCjtO6P74xGBmj0P_wMSpeXtL8TS1Ub_bfIHK8evY.OwKjAWZoHAkxp6spney
 kYWGAl96V36u_6eDx7_KvJJ18NiZeKF6gOQWw.q8it7cETAE7U1t5Yw32jQA_2d4tAk5bp_h5YH_
 WwW0DDqZX5pse.7Odfrxo8A--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.ne1.yahoo.com with HTTP; Wed, 23 Nov 2022 20:01:05 +0000
Received: by hermes--production-ne1-6bcfb7fb87-2hzbf (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 9a2b4e210b8fb0ce0242a6033d9f3e20;
          Wed, 23 Nov 2022 20:01:02 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     casey@schaufler-ca.com, jmorris@namei.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net
Subject: [PATCH v1 8/8] lsm: wireup syscalls lsm_self_attr and lsm_module_list
Date:   Wed, 23 Nov 2022 11:57:43 -0800
Message-Id: <20221123195744.7738-9-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221123195744.7738-1-casey@schaufler-ca.com>
References: <20221123195744.7738-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wireup two syscalls for Linux Security Modules.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 arch/alpha/kernel/syscalls/syscall.tbl              | 2 ++
 arch/arm/tools/syscall.tbl                          | 2 ++
 arch/arm64/include/asm/unistd32.h                   | 2 ++
 arch/ia64/kernel/syscalls/syscall.tbl               | 2 ++
 arch/m68k/kernel/syscalls/syscall.tbl               | 2 ++
 arch/microblaze/kernel/syscalls/syscall.tbl         | 2 ++
 arch/mips/kernel/syscalls/syscall_n32.tbl           | 2 ++
 arch/mips/kernel/syscalls/syscall_n64.tbl           | 2 ++
 arch/mips/kernel/syscalls/syscall_o32.tbl           | 2 ++
 arch/parisc/kernel/syscalls/syscall.tbl             | 2 ++
 arch/powerpc/kernel/syscalls/syscall.tbl            | 2 ++
 arch/s390/kernel/syscalls/syscall.tbl               | 2 ++
 arch/sh/kernel/syscalls/syscall.tbl                 | 2 ++
 arch/sparc/kernel/syscalls/syscall.tbl              | 2 ++
 arch/x86/entry/syscalls/syscall_32.tbl              | 2 ++
 arch/x86/entry/syscalls/syscall_64.tbl              | 2 ++
 arch/xtensa/kernel/syscalls/syscall.tbl             | 2 ++
 include/uapi/asm-generic/unistd.h                   | 5 ++++-
 tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl | 2 ++
 tools/perf/arch/powerpc/entry/syscalls/syscall.tbl  | 2 ++
 tools/perf/arch/s390/entry/syscalls/syscall.tbl     | 2 ++
 tools/perf/arch/x86/entry/syscalls/syscall_64.tbl   | 2 ++
 22 files changed, 46 insertions(+), 1 deletion(-)

diff --git a/arch/alpha/kernel/syscalls/syscall.tbl b/arch/alpha/kernel/syscalls/syscall.tbl
index 8ebacf37a8cf..41e4f3704ccf 100644
--- a/arch/alpha/kernel/syscalls/syscall.tbl
+++ b/arch/alpha/kernel/syscalls/syscall.tbl
@@ -490,3 +490,5 @@
 558	common	process_mrelease		sys_process_mrelease
 559	common  futex_waitv                     sys_futex_waitv
 560	common	set_mempolicy_home_node		sys_ni_syscall
+561	common	lsm_self_attr			sys_lsm_self_attr
+562	common	lsm_module_list			sys_lsm_module_list
diff --git a/arch/arm/tools/syscall.tbl b/arch/arm/tools/syscall.tbl
index ac964612d8b0..20d551be0b67 100644
--- a/arch/arm/tools/syscall.tbl
+++ b/arch/arm/tools/syscall.tbl
@@ -464,3 +464,5 @@
 448	common	process_mrelease		sys_process_mrelease
 449	common	futex_waitv			sys_futex_waitv
 450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
+451	common	lsm_self_attr			sys_lsm_self_attr
+452	common	lsm_module_list			sys_lsm_module_list
diff --git a/arch/arm64/include/asm/unistd32.h b/arch/arm64/include/asm/unistd32.h
index 604a2053d006..366451dc8307 100644
--- a/arch/arm64/include/asm/unistd32.h
+++ b/arch/arm64/include/asm/unistd32.h
@@ -907,6 +907,8 @@ __SYSCALL(__NR_process_mrelease, sys_process_mrelease)
 __SYSCALL(__NR_futex_waitv, sys_futex_waitv)
 #define __NR_set_mempolicy_home_node 450
 __SYSCALL(__NR_set_mempolicy_home_node, sys_set_mempolicy_home_node)
+#define __NR_lsm_attr_set 451
+__SYSCALL(__NR_lsm_attr_set, sys_lsm_attr_set)
 
 /*
  * Please add new compat syscalls above this comment and update
diff --git a/arch/ia64/kernel/syscalls/syscall.tbl b/arch/ia64/kernel/syscalls/syscall.tbl
index 72c929d9902b..a2ccef8e1eb1 100644
--- a/arch/ia64/kernel/syscalls/syscall.tbl
+++ b/arch/ia64/kernel/syscalls/syscall.tbl
@@ -371,3 +371,5 @@
 448	common	process_mrelease		sys_process_mrelease
 449	common  futex_waitv                     sys_futex_waitv
 450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
+451	common	lsm_self_attr			sys_lsm_self_attr
+452	common	lsm_module_list			sys_lsm_module_list
diff --git a/arch/m68k/kernel/syscalls/syscall.tbl b/arch/m68k/kernel/syscalls/syscall.tbl
index b1f3940bc298..59b977b3fa04 100644
--- a/arch/m68k/kernel/syscalls/syscall.tbl
+++ b/arch/m68k/kernel/syscalls/syscall.tbl
@@ -450,3 +450,5 @@
 448	common	process_mrelease		sys_process_mrelease
 449	common  futex_waitv                     sys_futex_waitv
 450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
+451	common	lsm_self_attr			sys_lsm_self_attr
+452	common	lsm_module_list			sys_lsm_module_list
diff --git a/arch/microblaze/kernel/syscalls/syscall.tbl b/arch/microblaze/kernel/syscalls/syscall.tbl
index 820145e47350..82c39a22e38b 100644
--- a/arch/microblaze/kernel/syscalls/syscall.tbl
+++ b/arch/microblaze/kernel/syscalls/syscall.tbl
@@ -456,3 +456,5 @@
 448	common	process_mrelease		sys_process_mrelease
 449	common  futex_waitv                     sys_futex_waitv
 450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
+451	common	lsm_self_attr			sys_lsm_self_attr
+452	common	lsm_module_list			sys_lsm_module_list
diff --git a/arch/mips/kernel/syscalls/syscall_n32.tbl b/arch/mips/kernel/syscalls/syscall_n32.tbl
index 253ff994ed2e..f973b69e7dbe 100644
--- a/arch/mips/kernel/syscalls/syscall_n32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n32.tbl
@@ -389,3 +389,5 @@
 448	n32	process_mrelease		sys_process_mrelease
 449	n32	futex_waitv			sys_futex_waitv
 450	n32	set_mempolicy_home_node		sys_set_mempolicy_home_node
+451	n32	lsm_self_attr			sys_lsm_self_attr
+452	n32	lsm_module_list			sys_lsm_module_list
diff --git a/arch/mips/kernel/syscalls/syscall_n64.tbl b/arch/mips/kernel/syscalls/syscall_n64.tbl
index 3f1886ad9d80..567035293634 100644
--- a/arch/mips/kernel/syscalls/syscall_n64.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n64.tbl
@@ -365,3 +365,5 @@
 448	n64	process_mrelease		sys_process_mrelease
 449	n64	futex_waitv			sys_futex_waitv
 450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
+451	n64	lsm_self_attr			sys_lsm_self_attr
+452	n64	lsm_module_list			sys_lsm_module_list
diff --git a/arch/mips/kernel/syscalls/syscall_o32.tbl b/arch/mips/kernel/syscalls/syscall_o32.tbl
index 8f243e35a7b2..22019aa08696 100644
--- a/arch/mips/kernel/syscalls/syscall_o32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_o32.tbl
@@ -438,3 +438,5 @@
 448	o32	process_mrelease		sys_process_mrelease
 449	o32	futex_waitv			sys_futex_waitv
 450	o32	set_mempolicy_home_node		sys_set_mempolicy_home_node
+451	o32	lsm_self_attr			sys_lsm_self_attr
+452	o32	lsm_module_list			sys_lsm_module_list
diff --git a/arch/parisc/kernel/syscalls/syscall.tbl b/arch/parisc/kernel/syscalls/syscall.tbl
index 8a99c998da9b..e52c292923f6 100644
--- a/arch/parisc/kernel/syscalls/syscall.tbl
+++ b/arch/parisc/kernel/syscalls/syscall.tbl
@@ -448,3 +448,5 @@
 448	common	process_mrelease		sys_process_mrelease
 449	common	futex_waitv			sys_futex_waitv
 450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
+451	common	lsm_self_attr			sys_lsm_self_attr
+452	common	lsm_module_list			sys_lsm_module_list
diff --git a/arch/powerpc/kernel/syscalls/syscall.tbl b/arch/powerpc/kernel/syscalls/syscall.tbl
index e9e0df4f9a61..099489ee5c45 100644
--- a/arch/powerpc/kernel/syscalls/syscall.tbl
+++ b/arch/powerpc/kernel/syscalls/syscall.tbl
@@ -534,3 +534,5 @@
 448	common	process_mrelease		sys_process_mrelease
 449	common  futex_waitv                     sys_futex_waitv
 450 	nospu	set_mempolicy_home_node		sys_set_mempolicy_home_node
+451	common	lsm_self_attr			sys_lsm_self_attr
+452	common	lsm_module_list			sys_lsm_module_list
diff --git a/arch/s390/kernel/syscalls/syscall.tbl b/arch/s390/kernel/syscalls/syscall.tbl
index 799147658dee..eaba1ed5654e 100644
--- a/arch/s390/kernel/syscalls/syscall.tbl
+++ b/arch/s390/kernel/syscalls/syscall.tbl
@@ -453,3 +453,5 @@
 448  common	process_mrelease	sys_process_mrelease		sys_process_mrelease
 449  common	futex_waitv		sys_futex_waitv			sys_futex_waitv
 450  common	set_mempolicy_home_node	sys_set_mempolicy_home_node	sys_set_mempolicy_home_node
+451  common	lsm_self_attr		sys_lsm_self_attr	sys_lsm_self_attr
+452  common	lsm_module_list		sys_lsm_module_list	sys_lsm_module_list
diff --git a/arch/sh/kernel/syscalls/syscall.tbl b/arch/sh/kernel/syscalls/syscall.tbl
index 2de85c977f54..b84c60d96f78 100644
--- a/arch/sh/kernel/syscalls/syscall.tbl
+++ b/arch/sh/kernel/syscalls/syscall.tbl
@@ -453,3 +453,5 @@
 448	common	process_mrelease		sys_process_mrelease
 449	common  futex_waitv                     sys_futex_waitv
 450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
+451	common	lsm_self_attr			sys_lsm_self_attr
+452	common	lsm_module_list			sys_lsm_module_list
diff --git a/arch/sparc/kernel/syscalls/syscall.tbl b/arch/sparc/kernel/syscalls/syscall.tbl
index 4398cc6fb68d..f0831bf811e3 100644
--- a/arch/sparc/kernel/syscalls/syscall.tbl
+++ b/arch/sparc/kernel/syscalls/syscall.tbl
@@ -496,3 +496,5 @@
 448	common	process_mrelease		sys_process_mrelease
 449	common  futex_waitv                     sys_futex_waitv
 450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
+451	common	lsm_self_attr			sys_lsm_self_attr
+452	common	lsm_module_list			sys_lsm_module_list
diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index 320480a8db4f..259509a0e23d 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -455,3 +455,5 @@
 448	i386	process_mrelease	sys_process_mrelease
 449	i386	futex_waitv		sys_futex_waitv
 450	i386	set_mempolicy_home_node		sys_set_mempolicy_home_node
+451	i386	lsm_self_attr		sys_lsm_self_attr
+452	i386	lsm_module_list		sys_lsm_module_list
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index c84d12608cd2..40b35e7069a7 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -372,6 +372,8 @@
 448	common	process_mrelease	sys_process_mrelease
 449	common	futex_waitv		sys_futex_waitv
 450	common	set_mempolicy_home_node	sys_set_mempolicy_home_node
+451	common	lsm_self_attr		sys_lsm_self_attr
+452	common	lsm_module_list		sys_lsm_module_list
 
 #
 # Due to a historical design error, certain syscalls are numbered differently
diff --git a/arch/xtensa/kernel/syscalls/syscall.tbl b/arch/xtensa/kernel/syscalls/syscall.tbl
index 52c94ab5c205..f0c76d05b768 100644
--- a/arch/xtensa/kernel/syscalls/syscall.tbl
+++ b/arch/xtensa/kernel/syscalls/syscall.tbl
@@ -421,3 +421,5 @@
 448	common	process_mrelease		sys_process_mrelease
 449	common  futex_waitv                     sys_futex_waitv
 450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
+451	common	lsm_self_attr			sys_lsm_self_attr
+452	common	lsm_module_list			sys_lsm_module_list
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index 45fa180cc56a..aa66718e1b48 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -886,8 +886,11 @@ __SYSCALL(__NR_futex_waitv, sys_futex_waitv)
 #define __NR_set_mempolicy_home_node 450
 __SYSCALL(__NR_set_mempolicy_home_node, sys_set_mempolicy_home_node)
 
+#define __NR_lsm_self_attr 451
+__SYSCALL(__NR_lsm_self_attr, sys_lsm_self_attr)
+
 #undef __NR_syscalls
-#define __NR_syscalls 451
+#define __NR_syscalls 452
 
 /*
  * 32 bit systems traditionally used different
diff --git a/tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl b/tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl
index 3f1886ad9d80..567035293634 100644
--- a/tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl
+++ b/tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl
@@ -365,3 +365,5 @@
 448	n64	process_mrelease		sys_process_mrelease
 449	n64	futex_waitv			sys_futex_waitv
 450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
+451	n64	lsm_self_attr			sys_lsm_self_attr
+452	n64	lsm_module_list			sys_lsm_module_list
diff --git a/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl b/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl
index 2bca64f96164..7b779080acbe 100644
--- a/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl
+++ b/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl
@@ -530,3 +530,5 @@
 448	common	process_mrelease		sys_process_mrelease
 449	common  futex_waitv                     sys_futex_waitv
 450 	nospu	set_mempolicy_home_node		sys_set_mempolicy_home_node
+451	common	lsm_self_attr			sys_lsm_self_attr
+452	common	lsm_module_list			sys_lsm_module_list
diff --git a/tools/perf/arch/s390/entry/syscalls/syscall.tbl b/tools/perf/arch/s390/entry/syscalls/syscall.tbl
index 799147658dee..eaba1ed5654e 100644
--- a/tools/perf/arch/s390/entry/syscalls/syscall.tbl
+++ b/tools/perf/arch/s390/entry/syscalls/syscall.tbl
@@ -453,3 +453,5 @@
 448  common	process_mrelease	sys_process_mrelease		sys_process_mrelease
 449  common	futex_waitv		sys_futex_waitv			sys_futex_waitv
 450  common	set_mempolicy_home_node	sys_set_mempolicy_home_node	sys_set_mempolicy_home_node
+451  common	lsm_self_attr		sys_lsm_self_attr	sys_lsm_self_attr
+452  common	lsm_module_list		sys_lsm_module_list	sys_lsm_module_list
diff --git a/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl b/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
index c84d12608cd2..40b35e7069a7 100644
--- a/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
@@ -372,6 +372,8 @@
 448	common	process_mrelease	sys_process_mrelease
 449	common	futex_waitv		sys_futex_waitv
 450	common	set_mempolicy_home_node	sys_set_mempolicy_home_node
+451	common	lsm_self_attr		sys_lsm_self_attr
+452	common	lsm_module_list		sys_lsm_module_list
 
 #
 # Due to a historical design error, certain syscalls are numbered differently
-- 
2.37.3

