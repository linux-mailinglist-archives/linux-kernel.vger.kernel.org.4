Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BA5D729E84
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 17:30:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241505AbjFIPag (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 11:30:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236150AbjFIPac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 11:30:32 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88FE01BC6
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 08:30:30 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-653436fcc1bso1622290b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 08:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686324630; x=1688916630;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7UugMGksjZWRD0rlu0b/qOjgpa5w4C4cHJBLIFM0Pic=;
        b=rfvX3V1rVbP5zXCFO1yVF99gOC9xdF4RoJeWxoxxSbmMTvjYsiMGIWTblXGU2zUSUr
         ba3bRt6eV0xw8sqe/+B3NBWkjx+OqE/KbvROdBLk/lisebUHXxJRUyH3hmDGbK9eHHCs
         zDhR1yTOC1J85ceFeU8IdIW9VVwX9/tnw0hBOovaPMKdPeWbBnZOz64D9tg62+sjat5P
         z3CJzcN3oLWN5SOVpTJgaTeLg3ulHqJMynAzY3w8VWm/88AOZ6rnp3ayrHhdhS/xuvPC
         ewPu3qPRm3QjaGkoxxhFGTg5vlCGE0VLkyuyLRfqeYpPYtE/bB+A/J3Z0RS4h+PiLeyF
         Pxjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686324630; x=1688916630;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7UugMGksjZWRD0rlu0b/qOjgpa5w4C4cHJBLIFM0Pic=;
        b=leECubOCEDZ0xAQ6em6laWnzU7uLjSoC1uP3HHBX4q/wQer9x23399e7a6m3oQtbBL
         RCtR/EpWnwq4Y0521Wo4vJcuu45iKZRka4eqkvvQMyZ5NHkCqA/r//xcmqBlLZEsLozc
         5urctg/I0Ps/y7BXlxh9AEMxOpBF0mJ9qj3ykszSYbYy5qVbuaauLJu2S04wnttoHWKz
         VMCov9Bk0IpTVjAJI679fUizvjZj7D3z9JYsF2QaRtGbDctPW16/Xgj0Jy6JIUPDtjCO
         po9xFIvII7MKH3N78Ngj18FTe9xz2GVT0pLyZ1/1QrHDQWSFkDezBeXPYWiSUr0V+ZbY
         58QQ==
X-Gm-Message-State: AC+VfDxSHA1uBJSlaycPKTTPJoUwN6lN7a5DSW7Qis4MLlbZ61i0lh32
        K0hgpCwoPv3NGfKmuoTyC2Bw4GRJAAA=
X-Google-Smtp-Source: ACHHUZ7ONfS7xv3ABS9pHDvhBNl1OxikPzOqxHCZG32O6Ito5N1Bzzgz+SaPpDVTfa2lxdbNBumwcQ==
X-Received: by 2002:a17:90a:741:b0:259:3e7d:3b79 with SMTP id s1-20020a17090a074100b002593e7d3b79mr1176138pje.43.1686324629560;
        Fri, 09 Jun 2023 08:30:29 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net ([2601:641:401:1d20:1bc3:5645:d3d:e4be])
        by smtp.gmail.com with ESMTPSA id 14-20020a17090a190e00b00259b729eea9sm3265997pjg.8.2023.06.09.08.30.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 08:30:28 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH v2] xtensa: add asm-prototypes.h
Date:   Fri,  9 Jun 2023 08:30:21 -0700
Message-Id: <20230609153021.1911455-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_LOCAL_NOVOWEL,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move assembly source prototypes from xtensa_ksyms.c to
asm/asm-prototypes.h, move corresponding EXPORT_SYMBOLs to the assembly
sources and enable HAVE_ASM_MODVERSIONS for xtensa.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
Changes v1->v2:
- move EXPORT_SYMBOLs from xtensa_ksyms.c to the assembly source files

 arch/xtensa/Kconfig                      |  1 +
 arch/xtensa/include/asm/asm-prototypes.h | 29 ++++++++
 arch/xtensa/include/asm/asmmacro.h       |  1 +
 arch/xtensa/kernel/mcount.S              |  1 +
 arch/xtensa/kernel/xtensa_ksyms.c        | 92 +-----------------------
 arch/xtensa/lib/ashldi3.S                |  1 +
 arch/xtensa/lib/ashrdi3.S                |  1 +
 arch/xtensa/lib/bswapdi2.S               |  1 +
 arch/xtensa/lib/bswapsi2.S               |  1 +
 arch/xtensa/lib/checksum.S               |  2 +
 arch/xtensa/lib/divsi3.S                 |  1 +
 arch/xtensa/lib/lshrdi3.S                |  1 +
 arch/xtensa/lib/memcopy.S                |  4 ++
 arch/xtensa/lib/memset.S                 |  2 +
 arch/xtensa/lib/modsi3.S                 |  1 +
 arch/xtensa/lib/mulsi3.S                 |  1 +
 arch/xtensa/lib/strncpy_user.S           |  1 +
 arch/xtensa/lib/strnlen_user.S           |  1 +
 arch/xtensa/lib/udivsi3.S                |  1 +
 arch/xtensa/lib/umodsi3.S                |  1 +
 arch/xtensa/lib/umulsidi3.S              |  1 +
 arch/xtensa/lib/usercopy.S               |  1 +
 arch/xtensa/mm/misc.S                    |  5 ++
 23 files changed, 60 insertions(+), 91 deletions(-)
 create mode 100644 arch/xtensa/include/asm/asm-prototypes.h

diff --git a/arch/xtensa/Kconfig b/arch/xtensa/Kconfig
index 3c6e5471f025..46051edc5ed3 100644
--- a/arch/xtensa/Kconfig
+++ b/arch/xtensa/Kconfig
@@ -35,6 +35,7 @@ config XTENSA
 	select HAVE_ARCH_KCSAN
 	select HAVE_ARCH_SECCOMP_FILTER
 	select HAVE_ARCH_TRACEHOOK
+	select HAVE_ASM_MODVERSIONS
 	select HAVE_CONTEXT_TRACKING_USER
 	select HAVE_DEBUG_KMEMLEAK
 	select HAVE_DMA_CONTIGUOUS
diff --git a/arch/xtensa/include/asm/asm-prototypes.h b/arch/xtensa/include/asm/asm-prototypes.h
new file mode 100644
index 000000000000..b0da61812b85
--- /dev/null
+++ b/arch/xtensa/include/asm/asm-prototypes.h
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ASM_PROTOTYPES_H
+#define __ASM_PROTOTYPES_H
+
+#include <asm/cacheflush.h>
+#include <asm/checksum.h>
+#include <asm/ftrace.h>
+#include <asm/page.h>
+#include <asm/string.h>
+#include <asm/uaccess.h>
+
+#include <asm-generic/asm-prototypes.h>
+
+/*
+ * gcc internal math functions
+ */
+long long __ashrdi3(long long, int);
+long long __ashldi3(long long, int);
+long long __bswapdi2(long long);
+int __bswapsi2(int);
+long long __lshrdi3(long long, int);
+int __divsi3(int, int);
+int __modsi3(int, int);
+int __mulsi3(int, int);
+unsigned int __udivsi3(unsigned int, unsigned int);
+unsigned int __umodsi3(unsigned int, unsigned int);
+unsigned long long __umulsidi3(unsigned int, unsigned int);
+
+#endif /* __ASM_PROTOTYPES_H */
diff --git a/arch/xtensa/include/asm/asmmacro.h b/arch/xtensa/include/asm/asmmacro.h
index e3474ca411ff..01bf7d9dbb19 100644
--- a/arch/xtensa/include/asm/asmmacro.h
+++ b/arch/xtensa/include/asm/asmmacro.h
@@ -11,6 +11,7 @@
 #ifndef _XTENSA_ASMMACRO_H
 #define _XTENSA_ASMMACRO_H
 
+#include <asm-generic/export.h>
 #include <asm/core.h>
 
 /*
diff --git a/arch/xtensa/kernel/mcount.S b/arch/xtensa/kernel/mcount.S
index 51daaf4e0b82..309b3298258f 100644
--- a/arch/xtensa/kernel/mcount.S
+++ b/arch/xtensa/kernel/mcount.S
@@ -78,6 +78,7 @@ ENTRY(_mcount)
 #error Unsupported Xtensa ABI
 #endif
 ENDPROC(_mcount)
+EXPORT_SYMBOL(_mcount)
 
 ENTRY(ftrace_stub)
 	abi_entry_default
diff --git a/arch/xtensa/kernel/xtensa_ksyms.c b/arch/xtensa/kernel/xtensa_ksyms.c
index a9aa90c995cd..62d81e76e18e 100644
--- a/arch/xtensa/kernel/xtensa_ksyms.c
+++ b/arch/xtensa/kernel/xtensa_ksyms.c
@@ -13,71 +13,10 @@
  */
 
 #include <linux/module.h>
-#include <linux/string.h>
-#include <linux/mm.h>
-#include <linux/interrupt.h>
-#include <asm/irq.h>
-#include <linux/in6.h>
-
-#include <linux/uaccess.h>
-#include <asm/cacheflush.h>
-#include <asm/checksum.h>
-#include <asm/dma.h>
-#include <asm/io.h>
-#include <asm/page.h>
-#include <asm/ftrace.h>
-#ifdef CONFIG_BLK_DEV_FD
-#include <asm/floppy.h>
-#endif
-#ifdef CONFIG_NET
-#include <net/checksum.h>
-#endif /* CONFIG_NET */
-
-
-/*
- * String functions
- */
-EXPORT_SYMBOL(memset);
-EXPORT_SYMBOL(memcpy);
-EXPORT_SYMBOL(memmove);
-EXPORT_SYMBOL(__memset);
-EXPORT_SYMBOL(__memcpy);
-EXPORT_SYMBOL(__memmove);
-#ifdef CONFIG_ARCH_HAS_STRNCPY_FROM_USER
-EXPORT_SYMBOL(__strncpy_user);
-#endif
-EXPORT_SYMBOL(clear_page);
-EXPORT_SYMBOL(copy_page);
+#include <asm/pgtable.h>
 
 EXPORT_SYMBOL(empty_zero_page);
 
-/*
- * gcc internal math functions
- */
-extern long long __ashrdi3(long long, int);
-extern long long __ashldi3(long long, int);
-extern long long __bswapdi2(long long);
-extern int __bswapsi2(int);
-extern long long __lshrdi3(long long, int);
-extern int __divsi3(int, int);
-extern int __modsi3(int, int);
-extern int __mulsi3(int, int);
-extern unsigned int __udivsi3(unsigned int, unsigned int);
-extern unsigned int __umodsi3(unsigned int, unsigned int);
-extern unsigned long long __umulsidi3(unsigned int, unsigned int);
-
-EXPORT_SYMBOL(__ashldi3);
-EXPORT_SYMBOL(__ashrdi3);
-EXPORT_SYMBOL(__bswapdi2);
-EXPORT_SYMBOL(__bswapsi2);
-EXPORT_SYMBOL(__lshrdi3);
-EXPORT_SYMBOL(__divsi3);
-EXPORT_SYMBOL(__modsi3);
-EXPORT_SYMBOL(__mulsi3);
-EXPORT_SYMBOL(__udivsi3);
-EXPORT_SYMBOL(__umodsi3);
-EXPORT_SYMBOL(__umulsidi3);
-
 unsigned int __sync_fetch_and_and_4(volatile void *p, unsigned int v)
 {
 	BUG();
@@ -89,32 +28,3 @@ unsigned int __sync_fetch_and_or_4(volatile void *p, unsigned int v)
 	BUG();
 }
 EXPORT_SYMBOL(__sync_fetch_and_or_4);
-
-/*
- * Networking support
- */
-EXPORT_SYMBOL(csum_partial);
-EXPORT_SYMBOL(csum_partial_copy_generic);
-
-/*
- * Architecture-specific symbols
- */
-EXPORT_SYMBOL(__xtensa_copy_user);
-EXPORT_SYMBOL(__invalidate_icache_range);
-
-/*
- * Kernel hacking ...
- */
-
-#if defined(CONFIG_VGA_CONSOLE) || defined(CONFIG_DUMMY_CONSOLE)
-// FIXME EXPORT_SYMBOL(screen_info);
-#endif
-
-#ifdef CONFIG_FUNCTION_TRACER
-EXPORT_SYMBOL(_mcount);
-#endif
-
-EXPORT_SYMBOL(__invalidate_dcache_range);
-#if XCHAL_DCACHE_IS_WRITEBACK
-EXPORT_SYMBOL(__flush_dcache_range);
-#endif
diff --git a/arch/xtensa/lib/ashldi3.S b/arch/xtensa/lib/ashldi3.S
index 67fb0da9e432..cd6b731215d3 100644
--- a/arch/xtensa/lib/ashldi3.S
+++ b/arch/xtensa/lib/ashldi3.S
@@ -26,3 +26,4 @@ ENTRY(__ashldi3)
 	abi_ret_default
 
 ENDPROC(__ashldi3)
+EXPORT_SYMBOL(__ashldi3)
diff --git a/arch/xtensa/lib/ashrdi3.S b/arch/xtensa/lib/ashrdi3.S
index cbf052c512cc..07bc6e758020 100644
--- a/arch/xtensa/lib/ashrdi3.S
+++ b/arch/xtensa/lib/ashrdi3.S
@@ -26,3 +26,4 @@ ENTRY(__ashrdi3)
 	abi_ret_default
 
 ENDPROC(__ashrdi3)
+EXPORT_SYMBOL(__ashrdi3)
diff --git a/arch/xtensa/lib/bswapdi2.S b/arch/xtensa/lib/bswapdi2.S
index d8e52e05eba6..5d94a9352887 100644
--- a/arch/xtensa/lib/bswapdi2.S
+++ b/arch/xtensa/lib/bswapdi2.S
@@ -19,3 +19,4 @@ ENTRY(__bswapdi2)
 	abi_ret_default
 
 ENDPROC(__bswapdi2)
+EXPORT_SYMBOL(__bswapdi2)
diff --git a/arch/xtensa/lib/bswapsi2.S b/arch/xtensa/lib/bswapsi2.S
index 9c1de1344f79..fbfb8613d410 100644
--- a/arch/xtensa/lib/bswapsi2.S
+++ b/arch/xtensa/lib/bswapsi2.S
@@ -14,3 +14,4 @@ ENTRY(__bswapsi2)
 	abi_ret_default
 
 ENDPROC(__bswapsi2)
+EXPORT_SYMBOL(__bswapsi2)
diff --git a/arch/xtensa/lib/checksum.S b/arch/xtensa/lib/checksum.S
index cf1bed1a5bd6..ffee6f94c8f8 100644
--- a/arch/xtensa/lib/checksum.S
+++ b/arch/xtensa/lib/checksum.S
@@ -169,6 +169,7 @@ ENTRY(csum_partial)
 	j	5b		/* branch to handle the remaining byte */
 
 ENDPROC(csum_partial)
+EXPORT_SYMBOL(csum_partial)
 
 /*
  * Copy from ds while checksumming, otherwise like csum_partial
@@ -346,6 +347,7 @@ EX(10f)	s8i	a8, a3, 1
 	j	4b		/* process the possible trailing odd byte */
 
 ENDPROC(csum_partial_copy_generic)
+EXPORT_SYMBOL(csum_partial_copy_generic)
 
 
 # Exception handler:
diff --git a/arch/xtensa/lib/divsi3.S b/arch/xtensa/lib/divsi3.S
index b044b4744a8b..edb3c4ad971b 100644
--- a/arch/xtensa/lib/divsi3.S
+++ b/arch/xtensa/lib/divsi3.S
@@ -72,3 +72,4 @@ ENTRY(__divsi3)
 	abi_ret_default
 
 ENDPROC(__divsi3)
+EXPORT_SYMBOL(__divsi3)
diff --git a/arch/xtensa/lib/lshrdi3.S b/arch/xtensa/lib/lshrdi3.S
index 129ef8d1725b..e432e1a40702 100644
--- a/arch/xtensa/lib/lshrdi3.S
+++ b/arch/xtensa/lib/lshrdi3.S
@@ -26,3 +26,4 @@ ENTRY(__lshrdi3)
 	abi_ret_default
 
 ENDPROC(__lshrdi3)
+EXPORT_SYMBOL(__lshrdi3)
diff --git a/arch/xtensa/lib/memcopy.S b/arch/xtensa/lib/memcopy.S
index 98c3662bed8c..f60760396cee 100644
--- a/arch/xtensa/lib/memcopy.S
+++ b/arch/xtensa/lib/memcopy.S
@@ -273,6 +273,8 @@ WEAK(memcpy)
 	abi_ret_default
 
 ENDPROC(__memcpy)
+EXPORT_SYMBOL(__memcpy)
+EXPORT_SYMBOL(memcpy)
 
 /*
  * void *memmove(void *dst, const void *src, size_t len);
@@ -536,3 +538,5 @@ WEAK(memmove)
 	abi_ret_default
 
 ENDPROC(__memmove)
+EXPORT_SYMBOL(__memmove)
+EXPORT_SYMBOL(memmove)
diff --git a/arch/xtensa/lib/memset.S b/arch/xtensa/lib/memset.S
index 59b1524fd601..262c3f39f945 100644
--- a/arch/xtensa/lib/memset.S
+++ b/arch/xtensa/lib/memset.S
@@ -142,6 +142,8 @@ EX(10f) s8i	a3, a5, 0
 	abi_ret_default
 
 ENDPROC(__memset)
+EXPORT_SYMBOL(__memset)
+EXPORT_SYMBOL(memset)
 
 	.section .fixup, "ax"
 	.align	4
diff --git a/arch/xtensa/lib/modsi3.S b/arch/xtensa/lib/modsi3.S
index d00e77181e20..c5f4295c6868 100644
--- a/arch/xtensa/lib/modsi3.S
+++ b/arch/xtensa/lib/modsi3.S
@@ -60,6 +60,7 @@ ENTRY(__modsi3)
 	abi_ret_default
 
 ENDPROC(__modsi3)
+EXPORT_SYMBOL(__modsi3)
 
 #if !XCHAL_HAVE_NSA
 	.section .rodata
diff --git a/arch/xtensa/lib/mulsi3.S b/arch/xtensa/lib/mulsi3.S
index 91a9d7c62f96..c6b4fd46bfa9 100644
--- a/arch/xtensa/lib/mulsi3.S
+++ b/arch/xtensa/lib/mulsi3.S
@@ -131,3 +131,4 @@ ENTRY(__mulsi3)
 	abi_ret_default
 
 ENDPROC(__mulsi3)
+EXPORT_SYMBOL(__mulsi3)
diff --git a/arch/xtensa/lib/strncpy_user.S b/arch/xtensa/lib/strncpy_user.S
index 0731912227d3..9841d1694cdf 100644
--- a/arch/xtensa/lib/strncpy_user.S
+++ b/arch/xtensa/lib/strncpy_user.S
@@ -201,6 +201,7 @@ EX(10f)	s8i	a9, a11, 0
 	abi_ret_default
 
 ENDPROC(__strncpy_user)
+EXPORT_SYMBOL(__strncpy_user)
 
 	.section .fixup, "ax"
 	.align	4
diff --git a/arch/xtensa/lib/strnlen_user.S b/arch/xtensa/lib/strnlen_user.S
index 3d391dca3efb..cdcf57474164 100644
--- a/arch/xtensa/lib/strnlen_user.S
+++ b/arch/xtensa/lib/strnlen_user.S
@@ -133,6 +133,7 @@ EX(10f)	l32i	a9, a4, 0	# get word with first two bytes of string
 	abi_ret_default
 
 ENDPROC(__strnlen_user)
+EXPORT_SYMBOL(__strnlen_user)
 
 	.section .fixup, "ax"
 	.align	4
diff --git a/arch/xtensa/lib/udivsi3.S b/arch/xtensa/lib/udivsi3.S
index d2477e0786cf..59ea2dfc3f72 100644
--- a/arch/xtensa/lib/udivsi3.S
+++ b/arch/xtensa/lib/udivsi3.S
@@ -66,3 +66,4 @@ ENTRY(__udivsi3)
 	abi_ret_default
 
 ENDPROC(__udivsi3)
+EXPORT_SYMBOL(__udivsi3)
diff --git a/arch/xtensa/lib/umodsi3.S b/arch/xtensa/lib/umodsi3.S
index 5f031bfa0354..d39a7e56a971 100644
--- a/arch/xtensa/lib/umodsi3.S
+++ b/arch/xtensa/lib/umodsi3.S
@@ -55,3 +55,4 @@ ENTRY(__umodsi3)
 	abi_ret_default
 
 ENDPROC(__umodsi3)
+EXPORT_SYMBOL(__umodsi3)
diff --git a/arch/xtensa/lib/umulsidi3.S b/arch/xtensa/lib/umulsidi3.S
index 136081647942..8c7a94a0c5d0 100644
--- a/arch/xtensa/lib/umulsidi3.S
+++ b/arch/xtensa/lib/umulsidi3.S
@@ -228,3 +228,4 @@ ENTRY(__umulsidi3)
 #endif /* XCHAL_NO_MUL */
 
 ENDPROC(__umulsidi3)
+EXPORT_SYMBOL(__umulsidi3)
diff --git a/arch/xtensa/lib/usercopy.S b/arch/xtensa/lib/usercopy.S
index 16128c094c62..2c665c0b408e 100644
--- a/arch/xtensa/lib/usercopy.S
+++ b/arch/xtensa/lib/usercopy.S
@@ -283,6 +283,7 @@ EX(10f)	s8i	a6, a5,  0
 	abi_ret(STACK_SIZE)
 
 ENDPROC(__xtensa_copy_user)
+EXPORT_SYMBOL(__xtensa_copy_user)
 
 	.section .fixup, "ax"
 	.align	4
diff --git a/arch/xtensa/mm/misc.S b/arch/xtensa/mm/misc.S
index 0527bf6e3211..ec36f73c4765 100644
--- a/arch/xtensa/mm/misc.S
+++ b/arch/xtensa/mm/misc.S
@@ -47,6 +47,7 @@ ENTRY(clear_page)
 	abi_ret_default
 
 ENDPROC(clear_page)
+EXPORT_SYMBOL(clear_page)
 
 /*
  * copy_page and copy_user_page are the same for non-cache-aliased configs.
@@ -89,6 +90,7 @@ ENTRY(copy_page)
 	abi_ret_default
 
 ENDPROC(copy_page)
+EXPORT_SYMBOL(copy_page)
 
 #ifdef CONFIG_MMU
 /*
@@ -367,6 +369,7 @@ ENTRY(__invalidate_icache_range)
 	abi_ret_default
 
 ENDPROC(__invalidate_icache_range)
+EXPORT_SYMBOL(__invalidate_icache_range)
 
 /*
  * void __flush_invalidate_dcache_range(ulong start, ulong size)
@@ -397,6 +400,7 @@ ENTRY(__flush_dcache_range)
 	abi_ret_default
 
 ENDPROC(__flush_dcache_range)
+EXPORT_SYMBOL(__flush_dcache_range)
 
 /*
  * void _invalidate_dcache_range(ulong start, ulong size)
@@ -411,6 +415,7 @@ ENTRY(__invalidate_dcache_range)
 	abi_ret_default
 
 ENDPROC(__invalidate_dcache_range)
+EXPORT_SYMBOL(__invalidate_dcache_range)
 
 /*
  * void _invalidate_icache_all(void)
-- 
2.30.2

