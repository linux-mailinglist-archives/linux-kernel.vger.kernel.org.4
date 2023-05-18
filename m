Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CB4A70845F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 16:56:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231925AbjERO4M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 10:56:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231775AbjEROzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 10:55:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E1A41B6
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 07:55:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 759DC64FE5
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 14:55:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBB40C433EF;
        Thu, 18 May 2023 14:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684421728;
        bh=EWN17qREk8YC1MUcrW1F8VdO7n3Z0vTPmJeNoge1tUA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ScZ40A5phZasEfCLED6HhhkALpH9L+xuVprOBPzn9Si1l/WHV68LMnUeesVPV0nqr
         cSJEPlPHATJ26cRs93xcE+Gp8eLTGeyqvd93aX9d0oiqz5rBAWa8sdwOjVCmQcEP6X
         +1Z7HRKRDinrHbZowmtomCDpETrNCBoQx5L37Jb57llZiThSTz9SWk/cJZ/sIgoR/C
         RLKL11ri69PUOvVbpywNCH6jrp2nT0TWS718VwR6pBvD1uoW7jxxsackhnotT17XRK
         NHPecVSKMWH7vSHiYbVd6lvna8NNp2Jl3F3ZPl/cQaTkYCCQnKBXSv78M818PZhD2X
         jJ8iaUmmjSunA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 2BF9BCE198C; Thu, 18 May 2023 07:55:23 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     gwml@vger.gnuweeb.org, kernel-team@meta.com, w@lwt.eu,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Willy Tarreau <w@1wt.eu>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH v2 nolibc 11/15] tools/nolibc: use C89 comment syntax
Date:   Thu, 18 May 2023 07:55:17 -0700
Message-Id: <20230518145521.3806117-11-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <4817a4dc-69e6-4937-84d5-f2f630ff646c@paulmck-laptop>
References: <4817a4dc-69e6-4937-84d5-f2f630ff646c@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Weißschuh <linux@weissschuh.net>

Most of nolibc is already using C89 comments.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
Signed-off-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/include/nolibc/arch-aarch64.h          | 32 +++++------
 tools/include/nolibc/arch-arm.h              | 44 +++++++--------
 tools/include/nolibc/arch-i386.h             | 40 +++++++-------
 tools/include/nolibc/arch-loongarch.h        | 38 ++++++-------
 tools/include/nolibc/arch-mips.h             | 56 ++++++++++----------
 tools/include/nolibc/arch-riscv.h            | 40 +++++++-------
 tools/include/nolibc/arch-s390.h             |  2 +-
 tools/include/nolibc/arch-x86_64.h           | 34 ++++++------
 tools/include/nolibc/stackprotector.h        |  4 +-
 tools/include/nolibc/sys.h                   |  8 +--
 tools/testing/selftests/nolibc/nolibc-test.c | 12 ++---
 11 files changed, 155 insertions(+), 155 deletions(-)

diff --git a/tools/include/nolibc/arch-aarch64.h b/tools/include/nolibc/arch-aarch64.h
index 383baddef701..76ef26520c85 100644
--- a/tools/include/nolibc/arch-aarch64.h
+++ b/tools/include/nolibc/arch-aarch64.h
@@ -176,24 +176,24 @@ const unsigned long *_auxv __attribute__((weak));
 void __attribute__((weak,noreturn,optimize("omit-frame-pointer"))) _start(void)
 {
 	__asm__ volatile (
-		"ldr x0, [sp]\n"     // argc (x0) was in the stack
-		"add x1, sp, 8\n"    // argv (x1) = sp
-		"lsl x2, x0, 3\n"    // envp (x2) = 8*argc ...
-		"add x2, x2, 8\n"    //           + 8 (skip null)
-		"add x2, x2, x1\n"   //           + argv
-		"adrp x3, environ\n"          // x3 = &environ (high bits)
-		"str x2, [x3, #:lo12:environ]\n" // store envp into environ
-		"mov x4, x2\n"       // search for auxv (follows NULL after last env)
+		"ldr x0, [sp]\n"     /* argc (x0) was in the stack                          */
+		"add x1, sp, 8\n"    /* argv (x1) = sp                                      */
+		"lsl x2, x0, 3\n"    /* envp (x2) = 8*argc ...                              */
+		"add x2, x2, 8\n"    /*           + 8 (skip null)                           */
+		"add x2, x2, x1\n"   /*           + argv                                    */
+		"adrp x3, environ\n"          /* x3 = &environ (high bits)                  */
+		"str x2, [x3, #:lo12:environ]\n" /* store envp into environ                 */
+		"mov x4, x2\n"       /* search for auxv (follows NULL after last env)       */
 		"0:\n"
-		"ldr x5, [x4], 8\n"  // x5 = *x4; x4 += 8
-		"cbnz x5, 0b\n"      // and stop at NULL after last env
-		"adrp x3, _auxv\n"   // x3 = &_auxv (high bits)
-		"str x4, [x3, #:lo12:_auxv]\n" // store x4 into _auxv
-		"and sp, x1, -16\n"  // sp must be 16-byte aligned in the callee
-		"bl main\n"          // main() returns the status code, we'll exit with it.
-		"mov x8, 93\n"       // NR_exit == 93
+		"ldr x5, [x4], 8\n"  /* x5 = *x4; x4 += 8                                   */
+		"cbnz x5, 0b\n"      /* and stop at NULL after last env                     */
+		"adrp x3, _auxv\n"   /* x3 = &_auxv (high bits)                             */
+		"str x4, [x3, #:lo12:_auxv]\n" /* store x4 into _auxv                       */
+		"and sp, x1, -16\n"  /* sp must be 16-byte aligned in the callee            */
+		"bl main\n"          /* main() returns the status code, we'll exit with it. */
+		"mov x8, 93\n"       /* NR_exit == 93                                       */
 		"svc #0\n"
 	);
 	__builtin_unreachable();
 }
-#endif // _NOLIBC_ARCH_AARCH64_H
+#endif /* _NOLIBC_ARCH_AARCH64_H */
diff --git a/tools/include/nolibc/arch-arm.h b/tools/include/nolibc/arch-arm.h
index 42499f23e73c..2eab1aef321b 100644
--- a/tools/include/nolibc/arch-arm.h
+++ b/tools/include/nolibc/arch-arm.h
@@ -203,34 +203,34 @@ const unsigned long *_auxv __attribute__((weak));
 void __attribute__((weak,noreturn,optimize("omit-frame-pointer"))) _start(void)
 {
 	__asm__ volatile (
-		"pop {%r0}\n"                 // argc was in the stack
-		"mov %r1, %sp\n"              // argv = sp
+		"pop {%r0}\n"                 /* argc was in the stack                               */
+		"mov %r1, %sp\n"              /* argv = sp                                           */
 
-		"add %r2, %r0, $1\n"          // envp = (argc + 1) ...
-		"lsl %r2, %r2, $2\n"          //        * 4        ...
-		"add %r2, %r2, %r1\n"         //        + argv
-		"ldr %r3, 1f\n"               // r3 = &environ (see below)
-		"str %r2, [r3]\n"             // store envp into environ
+		"add %r2, %r0, $1\n"          /* envp = (argc + 1) ...                               */
+		"lsl %r2, %r2, $2\n"          /*        * 4        ...                               */
+		"add %r2, %r2, %r1\n"         /*        + argv                                       */
+		"ldr %r3, 1f\n"               /* r3 = &environ (see below)                           */
+		"str %r2, [r3]\n"             /* store envp into environ                             */
 
-		"mov r4, r2\n"                // search for auxv (follows NULL after last env)
+		"mov r4, r2\n"                /* search for auxv (follows NULL after last env)       */
 		"0:\n"
-		"mov r5, r4\n"                // r5 = r4
-		"add r4, r4, #4\n"            // r4 += 4
-		"ldr r5,[r5]\n"               // r5 = *r5 = *(r4-4)
-		"cmp r5, #0\n"                // and stop at NULL after last env
+		"mov r5, r4\n"                /* r5 = r4                                             */
+		"add r4, r4, #4\n"            /* r4 += 4                                             */
+		"ldr r5,[r5]\n"               /* r5 = *r5 = *(r4-4)                                  */
+		"cmp r5, #0\n"                /* and stop at NULL after last env                     */
 		"bne 0b\n"
-		"ldr %r3, 2f\n"               // r3 = &_auxv (low bits)
-		"str r4, [r3]\n"              // store r4 into _auxv
+		"ldr %r3, 2f\n"               /* r3 = &_auxv (low bits)                              */
+		"str r4, [r3]\n"              /* store r4 into _auxv                                 */
 
-		"mov %r3, $8\n"               // AAPCS : sp must be 8-byte aligned in the
-		"neg %r3, %r3\n"              //         callee, and bl doesn't push (lr=pc)
-		"and %r3, %r3, %r1\n"         // so we do sp = r1(=sp) & r3(=-8);
-		"mov %sp, %r3\n"              //
+		"mov %r3, $8\n"               /* AAPCS : sp must be 8-byte aligned in the            */
+		"neg %r3, %r3\n"              /*         callee, and bl doesn't push (lr=pc)         */
+		"and %r3, %r3, %r1\n"         /* so we do sp = r1(=sp) & r3(=-8);                    */
+		"mov %sp, %r3\n"
 
-		"bl main\n"                   // main() returns the status code, we'll exit with it.
-		"movs r7, $1\n"               // NR_exit == 1
+		"bl main\n"                   /* main() returns the status code, we'll exit with it. */
+		"movs r7, $1\n"               /* NR_exit == 1                                        */
 		"svc $0x00\n"
-		".align 2\n"                  // below are the pointers to a few variables
+		".align 2\n"                  /* below are the pointers to a few variables           */
 		"1:\n"
 		".word environ\n"
 		"2:\n"
@@ -239,4 +239,4 @@ void __attribute__((weak,noreturn,optimize("omit-frame-pointer"))) _start(void)
 	__builtin_unreachable();
 }
 
-#endif // _NOLIBC_ARCH_ARM_H
+#endif /* _NOLIBC_ARCH_ARM_H */
diff --git a/tools/include/nolibc/arch-i386.h b/tools/include/nolibc/arch-i386.h
index 2d98d78fd3f3..7c41897a08ce 100644
--- a/tools/include/nolibc/arch-i386.h
+++ b/tools/include/nolibc/arch-i386.h
@@ -194,31 +194,31 @@ void __attribute__((weak,noreturn,optimize("omit-frame-pointer"),no_stack_protec
 {
 	__asm__ volatile (
 #ifdef NOLIBC_STACKPROTECTOR
-		"call __stack_chk_init\n"   // initialize stack protector
+		"call __stack_chk_init\n"   /* initialize stack protector                    */
 #endif
-		"pop %eax\n"                // argc   (first arg, %eax)
-		"mov %esp, %ebx\n"          // argv[] (second arg, %ebx)
-		"lea 4(%ebx,%eax,4),%ecx\n" // then a NULL then envp (third arg, %ecx)
-		"mov %ecx, environ\n"       // save environ
-		"xor %ebp, %ebp\n"          // zero the stack frame
-		"mov %ecx, %edx\n"          // search for auxv (follows NULL after last env)
+		"pop %eax\n"                /* argc   (first arg, %eax)                      */
+		"mov %esp, %ebx\n"          /* argv[] (second arg, %ebx)                     */
+		"lea 4(%ebx,%eax,4),%ecx\n" /* then a NULL then envp (third arg, %ecx)       */
+		"mov %ecx, environ\n"       /* save environ                                  */
+		"xor %ebp, %ebp\n"          /* zero the stack frame                          */
+		"mov %ecx, %edx\n"          /* search for auxv (follows NULL after last env) */
 		"0:\n"
-		"add $4, %edx\n"            // search for auxv using edx, it follows the
-		"cmp -4(%edx), %ebp\n"      // ... NULL after last env (ebp is zero here)
+		"add $4, %edx\n"            /* search for auxv using edx, it follows the     */
+		"cmp -4(%edx), %ebp\n"      /* ... NULL after last env (ebp is zero here)    */
 		"jnz 0b\n"
-		"mov %edx, _auxv\n"         // save it into _auxv
-		"and $-16, %esp\n"          // x86 ABI : esp must be 16-byte aligned before
-		"sub $4, %esp\n"            // the call instruction (args are aligned)
-		"push %ecx\n"               // push all registers on the stack so that we
-		"push %ebx\n"               // support both regparm and plain stack modes
+		"mov %edx, _auxv\n"         /* save it into _auxv                            */
+		"and $-16, %esp\n"          /* x86 ABI : esp must be 16-byte aligned before  */
+		"sub $4, %esp\n"            /* the call instruction (args are aligned)       */
+		"push %ecx\n"               /* push all registers on the stack so that we    */
+		"push %ebx\n"               /* support both regparm and plain stack modes    */
 		"push %eax\n"
-		"call main\n"               // main() returns the status code in %eax
-		"mov %eax, %ebx\n"          // retrieve exit code (32-bit int)
-		"movl $1, %eax\n"           // NR_exit == 1
-		"int $0x80\n"               // exit now
-		"hlt\n"                     // ensure it does not
+		"call main\n"               /* main() returns the status code in %eax        */
+		"mov %eax, %ebx\n"          /* retrieve exit code (32-bit int)               */
+		"movl $1, %eax\n"           /* NR_exit == 1                                  */
+		"int $0x80\n"               /* exit now                                      */
+		"hlt\n"                     /* ensure it does not                            */
 	);
 	__builtin_unreachable();
 }
 
-#endif // _NOLIBC_ARCH_I386_H
+#endif /* _NOLIBC_ARCH_I386_H */
diff --git a/tools/include/nolibc/arch-loongarch.h b/tools/include/nolibc/arch-loongarch.h
index 029ee3cd6baf..ec3b46a991a9 100644
--- a/tools/include/nolibc/arch-loongarch.h
+++ b/tools/include/nolibc/arch-loongarch.h
@@ -158,7 +158,7 @@ const unsigned long *_auxv __attribute__((weak));
 #define LONG_ADDI    "addi.w"
 #define LONG_SLL     "slli.w"
 #define LONG_BSTRINS "bstrins.w"
-#else // __loongarch_grlen == 64
+#else /* __loongarch_grlen == 64 */
 #define LONGLOG      "3"
 #define SZREG        "8"
 #define REG_L        "ld.d"
@@ -173,28 +173,28 @@ const unsigned long *_auxv __attribute__((weak));
 void __attribute__((weak,noreturn,optimize("omit-frame-pointer"))) _start(void)
 {
 	__asm__ volatile (
-		REG_L        " $a0, $sp, 0\n"         // argc (a0) was in the stack
-		LONG_ADDI    " $a1, $sp, "SZREG"\n"   // argv (a1) = sp + SZREG
-		LONG_SLL     " $a2, $a0, "LONGLOG"\n" // envp (a2) = SZREG*argc ...
-		LONG_ADDI    " $a2, $a2, "SZREG"\n"   //             + SZREG (skip null)
-		LONG_ADD     " $a2, $a2, $a1\n"       //             + argv
+		REG_L        " $a0, $sp, 0\n"         /* argc (a0) was in the stack                          */
+		LONG_ADDI    " $a1, $sp, "SZREG"\n"   /* argv (a1) = sp + SZREG                              */
+		LONG_SLL     " $a2, $a0, "LONGLOG"\n" /* envp (a2) = SZREG*argc ...                          */
+		LONG_ADDI    " $a2, $a2, "SZREG"\n"   /*             + SZREG (skip null)                     */
+		LONG_ADD     " $a2, $a2, $a1\n"       /*             + argv                                  */
 
-		"move          $a3, $a2\n"            // iterate a3 over envp to find auxv (after NULL)
-		"0:\n"                                // do {
-		REG_L        " $a4, $a3, 0\n"         //   a4 = *a3;
-		LONG_ADDI    " $a3, $a3, "SZREG"\n"   //   a3 += sizeof(void*);
-		"bne           $a4, $zero, 0b\n"      // } while (a4);
-		"la.pcrel      $a4, _auxv\n"          // a4 = &_auxv
-		LONG_S       " $a3, $a4, 0\n"         // store a3 into _auxv
+		"move          $a3, $a2\n"            /* iterate a3 over envp to find auxv (after NULL)      */
+		"0:\n"                                /* do {                                                */
+		REG_L        " $a4, $a3, 0\n"         /*   a4 = *a3;                                         */
+		LONG_ADDI    " $a3, $a3, "SZREG"\n"   /*   a3 += sizeof(void*);                              */
+		"bne           $a4, $zero, 0b\n"      /* } while (a4);                                       */
+		"la.pcrel      $a4, _auxv\n"          /* a4 = &_auxv                                         */
+		LONG_S       " $a3, $a4, 0\n"         /* store a3 into _auxv                                 */
 
-		"la.pcrel      $a3, environ\n"        // a3 = &environ
-		LONG_S       " $a2, $a3, 0\n"         // store envp(a2) into environ
-		LONG_BSTRINS " $sp, $zero, 3, 0\n"    // sp must be 16-byte aligned
-		"bl            main\n"                // main() returns the status code, we'll exit with it.
-		"li.w          $a7, 93\n"             // NR_exit == 93
+		"la.pcrel      $a3, environ\n"        /* a3 = &environ                                       */
+		LONG_S       " $a2, $a3, 0\n"         /* store envp(a2) into environ                         */
+		LONG_BSTRINS " $sp, $zero, 3, 0\n"    /* sp must be 16-byte aligned                          */
+		"bl            main\n"                /* main() returns the status code, we'll exit with it. */
+		"li.w          $a7, 93\n"             /* NR_exit == 93                                       */
 		"syscall       0\n"
 	);
 	__builtin_unreachable();
 }
 
-#endif // _NOLIBC_ARCH_LOONGARCH_H
+#endif /* _NOLIBC_ARCH_LOONGARCH_H */
diff --git a/tools/include/nolibc/arch-mips.h b/tools/include/nolibc/arch-mips.h
index bf83432d23ed..8822f150e72f 100644
--- a/tools/include/nolibc/arch-mips.h
+++ b/tools/include/nolibc/arch-mips.h
@@ -183,42 +183,42 @@ const unsigned long *_auxv __attribute__((weak));
 void __attribute__((weak,noreturn,optimize("omit-frame-pointer"))) __start(void)
 {
 	__asm__ volatile (
-		//".set nomips16\n"
+		/*".set nomips16\n"*/
 		".set push\n"
 		".set    noreorder\n"
 		".option pic0\n"
-		//".ent __start\n"
-		//"__start:\n"
-		"lw $a0,($sp)\n"        // argc was in the stack
-		"addiu  $a1, $sp, 4\n"  // argv = sp + 4
-		"sll $a2, $a0, 2\n"     // a2 = argc * 4
-		"add   $a2, $a2, $a1\n" // envp = argv + 4*argc ...
-		"addiu $a2, $a2, 4\n"   //        ... + 4
-		"lui $a3, %hi(environ)\n"     // load environ into a3 (hi)
-		"addiu $a3, %lo(environ)\n"   // load environ into a3 (lo)
-		"sw $a2,($a3)\n"              // store envp(a2) into environ
-
-		"move $t0, $a2\n"             // iterate t0 over envp, look for NULL
-		"0:"                          // do {
-		"lw $a3, ($t0)\n"             //   a3=*(t0);
-		"bne $a3, $0, 0b\n"           // } while (a3);
-		"addiu $t0, $t0, 4\n"         // delayed slot: t0+=4;
-		"lui $a3, %hi(_auxv)\n"       // load _auxv into a3 (hi)
-		"addiu $a3, %lo(_auxv)\n"     // load _auxv into a3 (lo)
-		"sw $t0, ($a3)\n"             // store t0 into _auxv
+		/*".ent __start\n"*/
+		/*"__start:\n"*/
+		"lw $a0,($sp)\n"        /* argc was in the stack                               */
+		"addiu  $a1, $sp, 4\n"  /* argv = sp + 4                                       */
+		"sll $a2, $a0, 2\n"     /* a2 = argc * 4                                       */
+		"add   $a2, $a2, $a1\n" /* envp = argv + 4*argc ...                            */
+		"addiu $a2, $a2, 4\n"   /*        ... + 4                                      */
+		"lui $a3, %hi(environ)\n"     /* load environ into a3 (hi)                     */
+		"addiu $a3, %lo(environ)\n"   /* load environ into a3 (lo)                     */
+		"sw $a2,($a3)\n"              /* store envp(a2) into environ                   */
+
+		"move $t0, $a2\n"             /* iterate t0 over envp, look for NULL           */
+		"0:"                          /* do {                                          */
+		"lw $a3, ($t0)\n"             /*   a3=*(t0);                                   */
+		"bne $a3, $0, 0b\n"           /* } while (a3);                                 */
+		"addiu $t0, $t0, 4\n"         /* delayed slot: t0+=4;                          */
+		"lui $a3, %hi(_auxv)\n"       /* load _auxv into a3 (hi)                       */
+		"addiu $a3, %lo(_auxv)\n"     /* load _auxv into a3 (lo)                       */
+		"sw $t0, ($a3)\n"             /* store t0 into _auxv                           */
 
 		"li $t0, -8\n"
-		"and $sp, $sp, $t0\n"   // sp must be 8-byte aligned
-		"addiu $sp,$sp,-16\n"   // the callee expects to save a0..a3 there!
-		"jal main\n"            // main() returns the status code, we'll exit with it.
-		"nop\n"                 // delayed slot
-		"move $a0, $v0\n"       // retrieve 32-bit exit code from v0
-		"li $v0, 4001\n"        // NR_exit == 4001
+		"and $sp, $sp, $t0\n"   /* sp must be 8-byte aligned                           */
+		"addiu $sp,$sp,-16\n"   /* the callee expects to save a0..a3 there!            */
+		"jal main\n"            /* main() returns the status code, we'll exit with it. */
+		"nop\n"                 /* delayed slot                                        */
+		"move $a0, $v0\n"       /* retrieve 32-bit exit code from v0                   */
+		"li $v0, 4001\n"        /* NR_exit == 4001                                     */
 		"syscall\n"
-		//".end __start\n"
+		/*".end __start\n"*/
 		".set pop\n"
 	);
 	__builtin_unreachable();
 }
 
-#endif // _NOLIBC_ARCH_MIPS_H
+#endif /* _NOLIBC_ARCH_MIPS_H */
diff --git a/tools/include/nolibc/arch-riscv.h b/tools/include/nolibc/arch-riscv.h
index e197fcb10ac0..0d5f15fdedc4 100644
--- a/tools/include/nolibc/arch-riscv.h
+++ b/tools/include/nolibc/arch-riscv.h
@@ -181,28 +181,28 @@ void __attribute__((weak,noreturn,optimize("omit-frame-pointer"))) _start(void)
 		".option norelax\n"
 		"lla   gp, __global_pointer$\n"
 		".option pop\n"
-		"lw    a0, 0(sp)\n"          // argc (a0) was in the stack
-		"add   a1, sp, "SZREG"\n"    // argv (a1) = sp
-		"slli  a2, a0, "PTRLOG"\n"   // envp (a2) = SZREG*argc ...
-		"add   a2, a2, "SZREG"\n"    //             + SZREG (skip null)
-		"add   a2,a2,a1\n"           //             + argv
-
-		"add   a3, a2, zero\n"       // iterate a3 over envp to find auxv (after NULL)
-		"0:\n"                       // do {
-		"ld    a4, 0(a3)\n"          //   a4 = *a3;
-		"add   a3, a3, "SZREG"\n"    //   a3 += sizeof(void*);
-		"bne   a4, zero, 0b\n"       // } while (a4);
-		"lui   a4, %hi(_auxv)\n"     // a4 = &_auxv (high bits)
-		"sd    a3, %lo(_auxv)(a4)\n" // store a3 into _auxv
-
-		"lui a3, %hi(environ)\n"     // a3 = &environ (high bits)
-		"sd a2,%lo(environ)(a3)\n"   // store envp(a2) into environ
-		"andi  sp,a1,-16\n"          // sp must be 16-byte aligned
-		"call  main\n"               // main() returns the status code, we'll exit with it.
-		"li a7, 93\n"                // NR_exit == 93
+		"lw    a0, 0(sp)\n"          /* argc (a0) was in the stack                          */
+		"add   a1, sp, "SZREG"\n"    /* argv (a1) = sp                                      */
+		"slli  a2, a0, "PTRLOG"\n"   /* envp (a2) = SZREG*argc ...                          */
+		"add   a2, a2, "SZREG"\n"    /*             + SZREG (skip null)                     */
+		"add   a2,a2,a1\n"           /*             + argv                                  */
+
+		"add   a3, a2, zero\n"       /* iterate a3 over envp to find auxv (after NULL)      */
+		"0:\n"                       /* do {                                                */
+		"ld    a4, 0(a3)\n"          /*   a4 = *a3;                                         */
+		"add   a3, a3, "SZREG"\n"    /*   a3 += sizeof(void*);                              */
+		"bne   a4, zero, 0b\n"       /* } while (a4);                                       */
+		"lui   a4, %hi(_auxv)\n"     /* a4 = &_auxv (high bits)                             */
+		"sd    a3, %lo(_auxv)(a4)\n" /* store a3 into _auxv                                 */
+
+		"lui a3, %hi(environ)\n"     /* a3 = &environ (high bits)                           */
+		"sd a2,%lo(environ)(a3)\n"   /* store envp(a2) into environ                         */
+		"andi  sp,a1,-16\n"          /* sp must be 16-byte aligned                          */
+		"call  main\n"               /* main() returns the status code, we'll exit with it. */
+		"li a7, 93\n"                /* NR_exit == 93                                       */
 		"ecall\n"
 	);
 	__builtin_unreachable();
 }
 
-#endif // _NOLIBC_ARCH_RISCV_H
+#endif /* _NOLIBC_ARCH_RISCV_H */
diff --git a/tools/include/nolibc/arch-s390.h b/tools/include/nolibc/arch-s390.h
index 6b0e54ed543d..c62ee2472407 100644
--- a/tools/include/nolibc/arch-s390.h
+++ b/tools/include/nolibc/arch-s390.h
@@ -223,4 +223,4 @@ void *sys_mmap(void *addr, size_t length, int prot, int flags, int fd,
 	return (void *)my_syscall1(__NR_mmap, &args);
 }
 #define sys_mmap sys_mmap
-#endif // _NOLIBC_ARCH_S390_H
+#endif /* _NOLIBC_ARCH_S390_H */
diff --git a/tools/include/nolibc/arch-x86_64.h b/tools/include/nolibc/arch-x86_64.h
index f7f2a11d4c3b..d98f6c89d143 100644
--- a/tools/include/nolibc/arch-x86_64.h
+++ b/tools/include/nolibc/arch-x86_64.h
@@ -194,27 +194,27 @@ void __attribute__((weak,noreturn,optimize("omit-frame-pointer"))) _start(void)
 {
 	__asm__ volatile (
 #ifdef NOLIBC_STACKPROTECTOR
-		"call __stack_chk_init\n"   // initialize stack protector
+		"call __stack_chk_init\n"   /* initialize stack protector                          */
 #endif
-		"pop %rdi\n"                // argc   (first arg, %rdi)
-		"mov %rsp, %rsi\n"          // argv[] (second arg, %rsi)
-		"lea 8(%rsi,%rdi,8),%rdx\n" // then a NULL then envp (third arg, %rdx)
-		"mov %rdx, environ\n"       // save environ
-		"xor %ebp, %ebp\n"          // zero the stack frame
-		"mov %rdx, %rax\n"          // search for auxv (follows NULL after last env)
+		"pop %rdi\n"                /* argc   (first arg, %rdi)                            */
+		"mov %rsp, %rsi\n"          /* argv[] (second arg, %rsi)                           */
+		"lea 8(%rsi,%rdi,8),%rdx\n" /* then a NULL then envp (third arg, %rdx)             */
+		"mov %rdx, environ\n"       /* save environ                                        */
+		"xor %ebp, %ebp\n"          /* zero the stack frame                                */
+		"mov %rdx, %rax\n"          /* search for auxv (follows NULL after last env)       */
 		"0:\n"
-		"add $8, %rax\n"            // search for auxv using rax, it follows the
-		"cmp -8(%rax), %rbp\n"      // ... NULL after last env (rbp is zero here)
+		"add $8, %rax\n"            /* search for auxv using rax, it follows the           */
+		"cmp -8(%rax), %rbp\n"      /* ... NULL after last env (rbp is zero here)          */
 		"jnz 0b\n"
-		"mov %rax, _auxv\n"         // save it into _auxv
-		"and $-16, %rsp\n"          // x86 ABI : esp must be 16-byte aligned before call
-		"call main\n"               // main() returns the status code, we'll exit with it.
-		"mov %eax, %edi\n"          // retrieve exit code (32 bit)
-		"mov $60, %eax\n"           // NR_exit == 60
-		"syscall\n"                 // really exit
-		"hlt\n"                     // ensure it does not return
+		"mov %rax, _auxv\n"         /* save it into _auxv                                  */
+		"and $-16, %rsp\n"          /* x86 ABI : esp must be 16-byte aligned before call   */
+		"call main\n"               /* main() returns the status code, we'll exit with it. */
+		"mov %eax, %edi\n"          /* retrieve exit code (32 bit)                         */
+		"mov $60, %eax\n"           /* NR_exit == 60                                       */
+		"syscall\n"                 /* really exit                                         */
+		"hlt\n"                     /* ensure it does not return                           */
 	);
 	__builtin_unreachable();
 }
 
-#endif // _NOLIBC_ARCH_X86_64_H
+#endif /* _NOLIBC_ARCH_X86_64_H */
diff --git a/tools/include/nolibc/stackprotector.h b/tools/include/nolibc/stackprotector.h
index d119cbbbc256..77e5251c4490 100644
--- a/tools/include/nolibc/stackprotector.h
+++ b/tools/include/nolibc/stackprotector.h
@@ -48,6 +48,6 @@ void __stack_chk_init(void)
 	/* a bit more randomness in case getrandom() fails */
 	__stack_chk_guard ^= (uintptr_t) &__stack_chk_guard;
 }
-#endif // defined(NOLIBC_STACKPROTECTOR)
+#endif /* defined(NOLIBC_STACKPROTECTOR) */
 
-#endif // _NOLIBC_STACKPROTECTOR_H
+#endif /* _NOLIBC_STACKPROTECTOR_H */
diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
index bea9760dbd16..1b9b91cd8b57 100644
--- a/tools/include/nolibc/sys.h
+++ b/tools/include/nolibc/sys.h
@@ -12,15 +12,15 @@
 
 /* system includes */
 #include <asm/unistd.h>
-#include <asm/signal.h>  // for SIGCHLD
+#include <asm/signal.h>  /* for SIGCHLD */
 #include <asm/ioctls.h>
 #include <asm/mman.h>
 #include <linux/fs.h>
 #include <linux/loop.h>
 #include <linux/time.h>
 #include <linux/auxvec.h>
-#include <linux/fcntl.h> // for O_* and AT_*
-#include <linux/stat.h>  // for statx()
+#include <linux/fcntl.h> /* for O_* and AT_* */
+#include <linux/stat.h>  /* for statx() */
 
 #include "arch.h"
 #include "errno.h"
@@ -322,7 +322,7 @@ static __attribute__((noreturn,unused))
 void sys_exit(int status)
 {
 	my_syscall1(__NR_exit, status & 255);
-	while(1); // shut the "noreturn" warnings.
+	while(1); /* shut the "noreturn" warnings. */
 }
 
 static __attribute__((noreturn,unused))
diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index e692be98973a..f06b38cfe38a 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 
 #define _GNU_SOURCE
 
@@ -46,8 +46,8 @@ char **environ;
 
 /* definition of a series of tests */
 struct test {
-	const char *name;              // test name
-	int (*func)(int min, int max); // handler
+	const char *name;              /* test name */
+	int (*func)(int min, int max); /* handler */
 };
 
 #ifndef _NOLIBC_STDLIB_H
@@ -494,7 +494,7 @@ int run_syscall(int min, int max)
 	euid0 = geteuid() == 0;
 
 	for (test = min; test >= 0 && test <= max; test++) {
-		int llen = 0; // line length
+		int llen = 0; /* line length */
 
 		/* avoid leaving empty lines below, this will insert holes into
 		 * test numbers.
@@ -584,7 +584,7 @@ int run_stdlib(int min, int max)
 	void *p1, *p2;
 
 	for (test = min; test >= 0 && test <= max; test++) {
-		int llen = 0; // line length
+		int llen = 0; /* line length */
 
 		/* avoid leaving empty lines below, this will insert holes into
 		 * test numbers.
@@ -731,7 +731,7 @@ static int run_vfprintf(int min, int max)
 	void *p1, *p2;
 
 	for (test = min; test >= 0 && test <= max; test++) {
-		int llen = 0; // line length
+		int llen = 0; /* line length */
 
 		/* avoid leaving empty lines below, this will insert holes into
 		 * test numbers.
-- 
2.40.1

