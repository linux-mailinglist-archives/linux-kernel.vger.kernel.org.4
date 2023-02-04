Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4396268A738
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Feb 2023 01:25:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232470AbjBDAZQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 19:25:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230042AbjBDAZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 19:25:14 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 992EC8E6A5;
        Fri,  3 Feb 2023 16:25:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=0fRDbcUOHAqzyac5DoAoZnuHrvEv/9NAEeX2n3MClOU=; b=1jQLO6DgR1v7KlnN7Tskpmv6lO
        vDqanwJjFa7pi8SFbJFiLRwH4NJNEyA42MJRQnsXqetXUHB479aMrudF65rHrAwy4Otr/nE1XAYFZ
        8+83zn84UwbFYno40lSCVYLVAja3rntf63dJ0MtN4An/IUnppy7/58YZnKX+JY+nnGY7G/+uHJW3G
        mk0CXGM1GzMQIsmOFaP0ouGt227BZonc/Wx3zDMalvQeNg+gvnQ38lrVN6FVY57iX+yhC9Zi+7OLX
        fdmrLCnVC4kyylc4EVwdb3jeO5g2NNk78eoZK+LmIJEOZVTYVTg5EMllO+HT21VLm/AFWb7wjstPY
        yLX9MOsQ==;
Received: from [2601:1c2:d00:6a60::9526] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pO6Mf-004784-OR; Sat, 04 Feb 2023 00:25:10 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Arnd Bergmann <arnd@arndb.de>, Rich Felker <dalias@libc.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        linux-sh@vger.kernel.org
Subject: [PATCH] sh: remove sh5/sh64 last fragments
Date:   Fri,  3 Feb 2023 16:25:08 -0800
Message-Id: <20230204002508.18800-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A previous patch removed most of the sh5 (sh64) support from the
kernel tree. Now remove the last stragglers.

Fixes: 37744feebc08 ("sh: remove sh5 support")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Rich Felker <dalias@libc.org>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: linux-sh@vger.kernel.org
---
 Documentation/kbuild/kbuild.rst                           |    1 -
 Documentation/scheduler/sched-arch.rst                    |    2 --
 Documentation/translations/zh_CN/scheduler/sched-arch.rst |    2 --
 scripts/checkstack.pl                                     |    7 -------
 tools/perf/arch/common.c                                  |    2 --
 tools/scripts/Makefile.arch                               |    5 -----
 tools/testing/selftests/mm/Makefile                       |    2 +-
 tools/testing/selftests/mm/run_vmtests.sh                 |    2 +-
 8 files changed, 2 insertions(+), 21 deletions(-)

diff -- a/Documentation/kbuild/kbuild.rst b/Documentation/kbuild/kbuild.rst
--- a/Documentation/kbuild/kbuild.rst
+++ b/Documentation/kbuild/kbuild.rst
@@ -160,7 +160,6 @@ directory name found in the arch/ direct
 But some architectures such as x86 and sparc have aliases.
 
 - x86: i386 for 32 bit, x86_64 for 64 bit
-- sh: sh for 32 bit, sh64 for 64 bit
 - sparc: sparc32 for 32 bit, sparc64 for 64 bit
 
 CROSS_COMPILE
diff -- a/Documentation/scheduler/sched-arch.rst b/Documentation/scheduler/sched-arch.rst
--- a/Documentation/scheduler/sched-arch.rst
+++ b/Documentation/scheduler/sched-arch.rst
@@ -70,7 +70,5 @@ Possible arch problems I found (and eith
 
 ia64 - is safe_halt call racy vs interrupts? (does it sleep?) (See #4a)
 
-sh64 - Is sleeping racy vs interrupts? (See #4a)
-
 sparc - IRQs on at this point(?), change local_irq_save to _disable.
       - TODO: needs secondary CPUs to disable preempt (See #1)
diff -- a/Documentation/translations/zh_CN/scheduler/sched-arch.rst b/Documentation/translations/zh_CN/scheduler/sched-arch.rst
--- a/Documentation/translations/zh_CN/scheduler/sched-arch.rst
+++ b/Documentation/translations/zh_CN/scheduler/sched-arch.rst
@@ -70,7 +70,5 @@ 我发现的可能的arch问题（并试
 
 ia64 - safe_halt的调用与中断相比，是否很荒谬？ (它睡眠了吗) (参考 #4a)
 
-sh64 - 睡眠与中断相比，是否很荒谬？ (参考 #4a)
-
 sparc - 在这一点上，IRQ是开着的（？），把local_irq_save改为_disable。
       - 待办事项: 需要第二个CPU来禁用抢占 (参考 #1)
diff -- a/scripts/checkstack.pl b/scripts/checkstack.pl
--- a/scripts/checkstack.pl
+++ b/scripts/checkstack.pl
@@ -10,7 +10,6 @@
 #	Mips port by Juan Quintela <quintela@mandrakesoft.com>
 #	IA64 port via Andreas Dilger
 #	Arm port by Holger Schurig
-#	sh64 port by Paul Mundt
 #	Random bits by Matt Mackall <mpm@selenic.com>
 #	M68k port by Geert Uytterhoeven and Andreas Schwab
 #	AArch64, PARISC ports by Kyle McMartin
@@ -100,12 +99,6 @@ my (@stack, $re, $dre, $sub, $x, $xs, $f
 		#  100092:	 e3 f0 ff c8 ff 71	 lay	 %r15,-56(%r15)
 		$re = qr/.*(?:lay|ag?hi).*\%r15,-(([0-9]{2}|[3-9])[0-9]{2})
 		      (?:\(\%r15\))?$/ox;
-	} elsif ($arch =~ /^sh64$/) {
-		#XXX: we only check for the immediate case presently,
-		#     though we will want to check for the movi/sub
-		#     pair for larger users. -- PFM.
-		#a00048e0:       d4fc40f0        addi.l  r15,-240,r15
-		$re = qr/.*addi\.l.*r15,-(([0-9]{2}|[3-9])[0-9]{2}),r15/o;
 	} elsif ($arch eq 'sparc' || $arch eq 'sparc64') {
 		# f0019d10:       9d e3 bf 90     save  %sp, -112, %sp
 		$re = qr/.*save.*%sp, -(([0-9]{2}|[3-9])[0-9]{2}), %sp/o;
diff -- a/tools/perf/arch/common.c b/tools/perf/arch/common.c
--- a/tools/perf/arch/common.c
+++ b/tools/perf/arch/common.c
@@ -51,9 +51,7 @@ const char *const s390_triplets[] = {
 
 const char *const sh_triplets[] = {
 	"sh-unknown-linux-gnu-",
-	"sh64-unknown-linux-gnu-",
 	"sh-linux-gnu-",
-	"sh64-linux-gnu-",
 	NULL
 };
 
diff -- a/tools/scripts/Makefile.arch b/tools/scripts/Makefile.arch
--- a/tools/scripts/Makefile.arch
+++ b/tools/scripts/Makefile.arch
@@ -29,11 +29,6 @@ ifeq ($(ARCH),sparc64)
        SRCARCH := sparc
 endif
 
-# Additional ARCH settings for sh
-ifeq ($(ARCH),sh64)
-       SRCARCH := sh
-endif
-
 LP64 := $(shell echo __LP64__ | ${CC} ${CFLAGS} -E -x c - | tail -n 1)
 ifeq ($(LP64), 1)
   IS_64_BIT := 1
diff -- a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
--- a/tools/testing/selftests/mm/Makefile
+++ b/tools/testing/selftests/mm/Makefile
@@ -90,7 +90,7 @@ endif
 
 endif
 
-ifneq (,$(filter $(MACHINE),arm64 ia64 mips64 parisc64 ppc64 riscv64 s390x sh64 sparc64 x86_64))
+ifneq (,$(filter $(MACHINE),arm64 ia64 mips64 parisc64 ppc64 riscv64 s390x sparc64 x86_64))
 TEST_GEN_FILES += va_128TBswitch
 TEST_GEN_FILES += virtual_address_range
 TEST_GEN_FILES += write_to_hugetlbfs
diff -- a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/selftests/mm/run_vmtests.sh
--- a/tools/testing/selftests/mm/run_vmtests.sh
+++ b/tools/testing/selftests/mm/run_vmtests.sh
@@ -132,7 +132,7 @@ else
 fi
 
 # filter 64bit architectures
-ARCH64STR="arm64 ia64 mips64 parisc64 ppc64 ppc64le riscv64 s390x sh64 sparc64 x86_64"
+ARCH64STR="arm64 ia64 mips64 parisc64 ppc64 ppc64le riscv64 s390x sparc64 x86_64"
 if [ -z "$ARCH" ]; then
 	ARCH=$(uname -m 2>/dev/null | sed -e 's/aarch64.*/arm64/')
 fi
