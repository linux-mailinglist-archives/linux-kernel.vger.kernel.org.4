Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3598F69CBEC
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 14:20:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231826AbjBTNUU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 08:20:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbjBTNUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 08:20:18 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C45E21A646
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 05:20:15 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id f13so4061952edz.6
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 05:20:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=0PxskhvK+iZuPDe7GBidgkCIv6SVnsvhuirmrZ+KuAw=;
        b=GCdpLdmDwyocJ3W74JeoUWJrSEvD93j0k8oNVbf0OM6WmdMErSj1zFdE1/uwaUJ2Vr
         IkoGZKccWH7KViI6zK8tyCSUw/vIJHB+cAIhEuvw6BQMfoDNwv0tcsyGLtfnfbnZnjrh
         d9NIFBxGWZ1cCMYEKzM8NIbySbs2zfNCURM+PTEZXOeXCCY/xmTe2fwuXHr1TCbLOh/v
         YvGiEx/eN8RHF/wYv49xc9fwlcmfWx7OW7uPS/wBnVXgmvxUhdcy4wSCP/YvFxpZ5IIF
         oW465zeol2RoqykWqckSM5RdjIhr6+VQW7nnOHlNAZEwllPfw5GhRlRZF+mjdVx6SZQ5
         q6nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0PxskhvK+iZuPDe7GBidgkCIv6SVnsvhuirmrZ+KuAw=;
        b=YR1xsSZSqjDBcT56U+0zn0OQebHBm4ikZhbEhOaREFqxFEchGkCio80p2Am5V3mhIx
         nOOKNvYJQ33ve2HyG22/k0GPhhMG2WJbk1tEPaNqzNWoLbvaqCnawL9msLQrv8osirP1
         LGrVtBa8Vkln+RE7ZPhvYgTJ2P1g7LlaZeXVpdFAUiNRANnxtCxQd0X3kcLX/AnCgzlG
         SyWqgQMst0THNoTixi/knAi9PJwTB6kVG40h7v2FYicB5ZVhdEmAbDm2v/VMHHFtLEu5
         Yc4t6S5HVeCUtz9rNKR7mDB1w9l+GQT+CJD/Fr8FuKWmHoq+Rjqe3JZFFn2TGcIWhK4Z
         DY+Q==
X-Gm-Message-State: AO0yUKWk8UC9qn4WS0veYHP+Uvc9Rd6IlOMPZrihesEQtZKFw7+9gqFo
        f6MrnohxLiO7eY0HKIum0k4=
X-Google-Smtp-Source: AK7set+i4AH6zmEYIqdBdezq5gdggW2nryTQPKgvSl2Q8GfBOS8dp4wQ6qqg2PyGChsteVGaUUcsWA==
X-Received: by 2002:a17:906:e13:b0:8b1:2614:fbf2 with SMTP id l19-20020a1709060e1300b008b12614fbf2mr7371760eji.70.1676899214228;
        Mon, 20 Feb 2023 05:20:14 -0800 (PST)
Received: from gmail.com (1F2EF163.nat.pool.telekom.hu. [31.46.241.99])
        by smtp.gmail.com with ESMTPSA id fx15-20020a170906b74f00b008b14ba6c954sm5788826ejb.194.2023.02.20.05.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 05:20:13 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Mon, 20 Feb 2023 14:20:11 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] x86/core changes for v6.3
Message-ID: <Y/Nzi6aRDKNcvv1a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86/core git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-core-2023-02-20

   # HEAD: ce3ba2af9695e4bd64d797e0026321e5dca29dd3 x86: Suppress KMSAN reports in arch_within_stack_frames()

Changes in this cycle:

 - Clean up the signal frame layout tests

 - Suppress KMSAN false positive reports in arch_within_stack_frames()

 Thanks,

	Ingo

------------------>
Alexander Potapenko (1):
      x86: Suppress KMSAN reports in arch_within_stack_frames()

Brian Gerst (2):
      x86/signal: Move siginfo field tests
      x86/signal/compat: Move sigaction_compat_abi() to signal_64.c


 arch/x86/include/asm/thread_info.h |   5 +
 arch/x86/kernel/Makefile           |   1 -
 arch/x86/kernel/signal_32.c        | 127 ++++++++++++++++++++++++
 arch/x86/kernel/signal_64.c        | 127 ++++++++++++++++++++++++
 arch/x86/kernel/signal_compat.c    | 191 -------------------------------------
 5 files changed, 259 insertions(+), 192 deletions(-)
 delete mode 100644 arch/x86/kernel/signal_compat.c

diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/thread_info.h
index f0cb881c1d69..f1cccba52eb9 100644
--- a/arch/x86/include/asm/thread_info.h
+++ b/arch/x86/include/asm/thread_info.h
@@ -163,7 +163,12 @@ struct thread_info {
  *	GOOD_FRAME	if within a frame
  *	BAD_STACK	if placed across a frame boundary (or outside stack)
  *	NOT_STACK	unable to determine (no frame pointers, etc)
+ *
+ * This function reads pointers from the stack and dereferences them. The
+ * pointers may not have their KMSAN shadow set up properly, which may result
+ * in false positive reports. Disable instrumentation to avoid those.
  */
+__no_kmsan_checks
 static inline int arch_within_stack_frames(const void * const stack,
 					   const void * const stackend,
 					   const void *obj, unsigned long len)
diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 96d51bbc2bd4..dd61752f4c96 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -45,7 +45,6 @@ obj-y			+= head$(BITS).o
 obj-y			+= ebda.o
 obj-y			+= platform-quirks.o
 obj-y			+= process_$(BITS).o signal.o signal_$(BITS).o
-obj-$(CONFIG_COMPAT)	+= signal_compat.o
 obj-y			+= traps.o idt.o irq.o irq_$(BITS).o dumpstack_$(BITS).o
 obj-y			+= time.o ioport.o dumpstack.o nmi.o
 obj-$(CONFIG_MODIFY_LDT_SYSCALL)	+= ldt.o
diff --git a/arch/x86/kernel/signal_32.c b/arch/x86/kernel/signal_32.c
index 2553136cf39b..f042dcdf1f16 100644
--- a/arch/x86/kernel/signal_32.c
+++ b/arch/x86/kernel/signal_32.c
@@ -54,12 +54,14 @@ static inline void reload_segments(struct sigcontext_32 *sc)
 }
 
 #define sigset32_t			compat_sigset_t
+#define siginfo32_t			compat_siginfo_t
 #define restore_altstack32		compat_restore_altstack
 #define unsafe_save_altstack32		unsafe_compat_save_altstack
 
 #else
 
 #define sigset32_t			sigset_t
+#define siginfo32_t			siginfo_t
 #define __NR_ia32_sigreturn		__NR_sigreturn
 #define __NR_ia32_rt_sigreturn		__NR_rt_sigreturn
 #define restore_altstack32		restore_altstack
@@ -377,3 +379,128 @@ int ia32_setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs)
 	user_access_end();
 	return -EFAULT;
 }
+
+/*
+ * The siginfo_t structure and handing code is very easy
+ * to break in several ways.  It must always be updated when new
+ * updates are made to the main siginfo_t, and
+ * copy_siginfo_to_user32() must be updated when the
+ * (arch-independent) copy_siginfo_to_user() is updated.
+ *
+ * It is also easy to put a new member in the siginfo_t
+ * which has implicit alignment which can move internal structure
+ * alignment around breaking the ABI.  This can happen if you,
+ * for instance, put a plain 64-bit value in there.
+ */
+
+/*
+* If adding a new si_code, there is probably new data in
+* the siginfo.  Make sure folks bumping the si_code
+* limits also have to look at this code.  Make sure any
+* new fields are handled in copy_siginfo_to_user32()!
+*/
+static_assert(NSIGILL  == 11);
+static_assert(NSIGFPE  == 15);
+static_assert(NSIGSEGV == 9);
+static_assert(NSIGBUS  == 5);
+static_assert(NSIGTRAP == 6);
+static_assert(NSIGCHLD == 6);
+static_assert(NSIGSYS  == 2);
+
+/* This is part of the ABI and can never change in size: */
+static_assert(sizeof(siginfo32_t) == 128);
+
+/* This is a part of the ABI and can never change in alignment */
+static_assert(__alignof__(siginfo32_t) == 4);
+
+/*
+* The offsets of all the (unioned) si_fields are fixed
+* in the ABI, of course.  Make sure none of them ever
+* move and are always at the beginning:
+*/
+static_assert(offsetof(siginfo32_t, _sifields) == 3 * sizeof(int));
+
+static_assert(offsetof(siginfo32_t, si_signo) == 0);
+static_assert(offsetof(siginfo32_t, si_errno) == 4);
+static_assert(offsetof(siginfo32_t, si_code)  == 8);
+
+/*
+* Ensure that the size of each si_field never changes.
+* If it does, it is a sign that the
+* copy_siginfo_to_user32() code below needs to updated
+* along with the size in the CHECK_SI_SIZE().
+*
+* We repeat this check for both the generic and compat
+* siginfos.
+*
+* Note: it is OK for these to grow as long as the whole
+* structure stays within the padding size (checked
+* above).
+*/
+
+#define CHECK_SI_OFFSET(name)						\
+	static_assert(offsetof(siginfo32_t, _sifields) ==		\
+		      offsetof(siginfo32_t, _sifields.name))
+
+#define CHECK_SI_SIZE(name, size)					\
+	static_assert(sizeof_field(siginfo32_t, _sifields.name) == size)
+
+CHECK_SI_OFFSET(_kill);
+CHECK_SI_SIZE  (_kill, 2*sizeof(int));
+static_assert(offsetof(siginfo32_t, si_pid) == 0xC);
+static_assert(offsetof(siginfo32_t, si_uid) == 0x10);
+
+CHECK_SI_OFFSET(_timer);
+#ifdef CONFIG_COMPAT
+/* compat_siginfo_t doesn't have si_sys_private */
+CHECK_SI_SIZE  (_timer, 3*sizeof(int));
+#else
+CHECK_SI_SIZE  (_timer, 4*sizeof(int));
+#endif
+static_assert(offsetof(siginfo32_t, si_tid)     == 0x0C);
+static_assert(offsetof(siginfo32_t, si_overrun) == 0x10);
+static_assert(offsetof(siginfo32_t, si_value)   == 0x14);
+
+CHECK_SI_OFFSET(_rt);
+CHECK_SI_SIZE  (_rt, 3*sizeof(int));
+static_assert(offsetof(siginfo32_t, si_pid)   == 0x0C);
+static_assert(offsetof(siginfo32_t, si_uid)   == 0x10);
+static_assert(offsetof(siginfo32_t, si_value) == 0x14);
+
+CHECK_SI_OFFSET(_sigchld);
+CHECK_SI_SIZE  (_sigchld, 5*sizeof(int));
+static_assert(offsetof(siginfo32_t, si_pid)    == 0x0C);
+static_assert(offsetof(siginfo32_t, si_uid)    == 0x10);
+static_assert(offsetof(siginfo32_t, si_status) == 0x14);
+static_assert(offsetof(siginfo32_t, si_utime)  == 0x18);
+static_assert(offsetof(siginfo32_t, si_stime)  == 0x1C);
+
+CHECK_SI_OFFSET(_sigfault);
+CHECK_SI_SIZE  (_sigfault, 4*sizeof(int));
+static_assert(offsetof(siginfo32_t, si_addr) == 0x0C);
+
+static_assert(offsetof(siginfo32_t, si_trapno) == 0x10);
+
+static_assert(offsetof(siginfo32_t, si_addr_lsb) == 0x10);
+
+static_assert(offsetof(siginfo32_t, si_lower) == 0x14);
+static_assert(offsetof(siginfo32_t, si_upper) == 0x18);
+
+static_assert(offsetof(siginfo32_t, si_pkey) == 0x14);
+
+static_assert(offsetof(siginfo32_t, si_perf_data) == 0x10);
+static_assert(offsetof(siginfo32_t, si_perf_type) == 0x14);
+static_assert(offsetof(siginfo32_t, si_perf_flags) == 0x18);
+
+CHECK_SI_OFFSET(_sigpoll);
+CHECK_SI_SIZE  (_sigpoll, 2*sizeof(int));
+static_assert(offsetof(siginfo32_t, si_band) == 0x0C);
+static_assert(offsetof(siginfo32_t, si_fd)   == 0x10);
+
+CHECK_SI_OFFSET(_sigsys);
+CHECK_SI_SIZE  (_sigsys, 3*sizeof(int));
+static_assert(offsetof(siginfo32_t, si_call_addr) == 0x0C);
+static_assert(offsetof(siginfo32_t, si_syscall)   == 0x10);
+static_assert(offsetof(siginfo32_t, si_arch)      == 0x14);
+
+/* any new si_fields should be added here */
diff --git a/arch/x86/kernel/signal_64.c b/arch/x86/kernel/signal_64.c
index ff9c55064223..13a1e6083837 100644
--- a/arch/x86/kernel/signal_64.c
+++ b/arch/x86/kernel/signal_64.c
@@ -381,3 +381,130 @@ COMPAT_SYSCALL_DEFINE0(x32_rt_sigreturn)
 	return 0;
 }
 #endif /* CONFIG_X86_X32_ABI */
+
+#ifdef CONFIG_COMPAT
+void sigaction_compat_abi(struct k_sigaction *act, struct k_sigaction *oact)
+{
+	if (!act)
+		return;
+
+	if (in_ia32_syscall())
+		act->sa.sa_flags |= SA_IA32_ABI;
+	if (in_x32_syscall())
+		act->sa.sa_flags |= SA_X32_ABI;
+}
+#endif /* CONFIG_COMPAT */
+
+/*
+* If adding a new si_code, there is probably new data in
+* the siginfo.  Make sure folks bumping the si_code
+* limits also have to look at this code.  Make sure any
+* new fields are handled in copy_siginfo_to_user32()!
+*/
+static_assert(NSIGILL  == 11);
+static_assert(NSIGFPE  == 15);
+static_assert(NSIGSEGV == 9);
+static_assert(NSIGBUS  == 5);
+static_assert(NSIGTRAP == 6);
+static_assert(NSIGCHLD == 6);
+static_assert(NSIGSYS  == 2);
+
+/* This is part of the ABI and can never change in size: */
+static_assert(sizeof(siginfo_t) == 128);
+
+/* This is a part of the ABI and can never change in alignment */
+static_assert(__alignof__(siginfo_t) == 8);
+
+/*
+* The offsets of all the (unioned) si_fields are fixed
+* in the ABI, of course.  Make sure none of them ever
+* move and are always at the beginning:
+*/
+static_assert(offsetof(siginfo_t, si_signo) == 0);
+static_assert(offsetof(siginfo_t, si_errno) == 4);
+static_assert(offsetof(siginfo_t, si_code)  == 8);
+
+/*
+* Ensure that the size of each si_field never changes.
+* If it does, it is a sign that the
+* copy_siginfo_to_user32() code below needs to updated
+* along with the size in the CHECK_SI_SIZE().
+*
+* We repeat this check for both the generic and compat
+* siginfos.
+*
+* Note: it is OK for these to grow as long as the whole
+* structure stays within the padding size (checked
+* above).
+*/
+
+#define CHECK_SI_OFFSET(name)						\
+	static_assert(offsetof(siginfo_t, _sifields) == 		\
+		      offsetof(siginfo_t, _sifields.name))
+#define CHECK_SI_SIZE(name, size)					\
+	static_assert(sizeof_field(siginfo_t, _sifields.name) == size)
+
+CHECK_SI_OFFSET(_kill);
+CHECK_SI_SIZE  (_kill, 2*sizeof(int));
+static_assert(offsetof(siginfo_t, si_pid) == 0x10);
+static_assert(offsetof(siginfo_t, si_uid) == 0x14);
+
+CHECK_SI_OFFSET(_timer);
+CHECK_SI_SIZE  (_timer, 6*sizeof(int));
+static_assert(offsetof(siginfo_t, si_tid)     == 0x10);
+static_assert(offsetof(siginfo_t, si_overrun) == 0x14);
+static_assert(offsetof(siginfo_t, si_value)   == 0x18);
+
+CHECK_SI_OFFSET(_rt);
+CHECK_SI_SIZE  (_rt, 4*sizeof(int));
+static_assert(offsetof(siginfo_t, si_pid)   == 0x10);
+static_assert(offsetof(siginfo_t, si_uid)   == 0x14);
+static_assert(offsetof(siginfo_t, si_value) == 0x18);
+
+CHECK_SI_OFFSET(_sigchld);
+CHECK_SI_SIZE  (_sigchld, 8*sizeof(int));
+static_assert(offsetof(siginfo_t, si_pid)    == 0x10);
+static_assert(offsetof(siginfo_t, si_uid)    == 0x14);
+static_assert(offsetof(siginfo_t, si_status) == 0x18);
+static_assert(offsetof(siginfo_t, si_utime)  == 0x20);
+static_assert(offsetof(siginfo_t, si_stime)  == 0x28);
+
+#ifdef CONFIG_X86_X32_ABI
+/* no _sigchld_x32 in the generic siginfo_t */
+static_assert(sizeof_field(compat_siginfo_t, _sifields._sigchld_x32) ==
+	      7*sizeof(int));
+static_assert(offsetof(compat_siginfo_t, _sifields) ==
+	      offsetof(compat_siginfo_t, _sifields._sigchld_x32));
+static_assert(offsetof(compat_siginfo_t, _sifields._sigchld_x32._utime)  == 0x18);
+static_assert(offsetof(compat_siginfo_t, _sifields._sigchld_x32._stime)  == 0x20);
+#endif
+
+CHECK_SI_OFFSET(_sigfault);
+CHECK_SI_SIZE  (_sigfault, 8*sizeof(int));
+static_assert(offsetof(siginfo_t, si_addr)	== 0x10);
+
+static_assert(offsetof(siginfo_t, si_trapno)	== 0x18);
+
+static_assert(offsetof(siginfo_t, si_addr_lsb)	== 0x18);
+
+static_assert(offsetof(siginfo_t, si_lower)	== 0x20);
+static_assert(offsetof(siginfo_t, si_upper)	== 0x28);
+
+static_assert(offsetof(siginfo_t, si_pkey)	== 0x20);
+
+static_assert(offsetof(siginfo_t, si_perf_data)	 == 0x18);
+static_assert(offsetof(siginfo_t, si_perf_type)	 == 0x20);
+static_assert(offsetof(siginfo_t, si_perf_flags) == 0x24);
+
+CHECK_SI_OFFSET(_sigpoll);
+CHECK_SI_SIZE  (_sigpoll, 4*sizeof(int));
+static_assert(offsetof(siginfo_t, si_band) == 0x10);
+static_assert(offsetof(siginfo_t, si_fd)   == 0x18);
+
+CHECK_SI_OFFSET(_sigsys);
+CHECK_SI_SIZE  (_sigsys, 4*sizeof(int));
+static_assert(offsetof(siginfo_t, si_call_addr) == 0x10);
+static_assert(offsetof(siginfo_t, si_syscall)   == 0x18);
+static_assert(offsetof(siginfo_t, si_arch)      == 0x1C);
+
+/* any new si_fields should be added here */
diff --git a/arch/x86/kernel/signal_compat.c b/arch/x86/kernel/signal_compat.c
deleted file mode 100644
index 879ef8c72f5c..000000000000
--- a/arch/x86/kernel/signal_compat.c
+++ /dev/null
@@ -1,191 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <linux/compat.h>
-#include <linux/uaccess.h>
-#include <linux/ptrace.h>
-
-/*
- * The compat_siginfo_t structure and handing code is very easy
- * to break in several ways.  It must always be updated when new
- * updates are made to the main siginfo_t, and
- * copy_siginfo_to_user32() must be updated when the
- * (arch-independent) copy_siginfo_to_user() is updated.
- *
- * It is also easy to put a new member in the compat_siginfo_t
- * which has implicit alignment which can move internal structure
- * alignment around breaking the ABI.  This can happen if you,
- * for instance, put a plain 64-bit value in there.
- */
-static inline void signal_compat_build_tests(void)
-{
-	int _sifields_offset = offsetof(compat_siginfo_t, _sifields);
-
-	/*
-	 * If adding a new si_code, there is probably new data in
-	 * the siginfo.  Make sure folks bumping the si_code
-	 * limits also have to look at this code.  Make sure any
-	 * new fields are handled in copy_siginfo_to_user32()!
-	 */
-	BUILD_BUG_ON(NSIGILL  != 11);
-	BUILD_BUG_ON(NSIGFPE  != 15);
-	BUILD_BUG_ON(NSIGSEGV != 9);
-	BUILD_BUG_ON(NSIGBUS  != 5);
-	BUILD_BUG_ON(NSIGTRAP != 6);
-	BUILD_BUG_ON(NSIGCHLD != 6);
-	BUILD_BUG_ON(NSIGSYS  != 2);
-
-	/* This is part of the ABI and can never change in size: */
-	BUILD_BUG_ON(sizeof(siginfo_t) != 128);
-	BUILD_BUG_ON(sizeof(compat_siginfo_t) != 128);
-
-	/* This is a part of the ABI and can never change in alignment */
-	BUILD_BUG_ON(__alignof__(siginfo_t) != 8);
-	BUILD_BUG_ON(__alignof__(compat_siginfo_t) != 4);
-
-	/*
-	 * The offsets of all the (unioned) si_fields are fixed
-	 * in the ABI, of course.  Make sure none of them ever
-	 * move and are always at the beginning:
-	 */
-	BUILD_BUG_ON(offsetof(compat_siginfo_t, _sifields) != 3 * sizeof(int));
-#define CHECK_CSI_OFFSET(name)	  BUILD_BUG_ON(_sifields_offset != offsetof(compat_siginfo_t, _sifields.name))
-
-	BUILD_BUG_ON(offsetof(siginfo_t, si_signo) != 0);
-	BUILD_BUG_ON(offsetof(siginfo_t, si_errno) != 4);
-	BUILD_BUG_ON(offsetof(siginfo_t, si_code)  != 8);
-
-	BUILD_BUG_ON(offsetof(compat_siginfo_t, si_signo) != 0);
-	BUILD_BUG_ON(offsetof(compat_siginfo_t, si_errno) != 4);
-	BUILD_BUG_ON(offsetof(compat_siginfo_t, si_code)  != 8);
-	 /*
-	 * Ensure that the size of each si_field never changes.
-	 * If it does, it is a sign that the
-	 * copy_siginfo_to_user32() code below needs to updated
-	 * along with the size in the CHECK_SI_SIZE().
-	 *
-	 * We repeat this check for both the generic and compat
-	 * siginfos.
-	 *
-	 * Note: it is OK for these to grow as long as the whole
-	 * structure stays within the padding size (checked
-	 * above).
-	 */
-#define CHECK_CSI_SIZE(name, size) BUILD_BUG_ON(size != sizeof(((compat_siginfo_t *)0)->_sifields.name))
-#define CHECK_SI_SIZE(name, size) BUILD_BUG_ON(size != sizeof(((siginfo_t *)0)->_sifields.name))
-
-	CHECK_CSI_OFFSET(_kill);
-	CHECK_CSI_SIZE  (_kill, 2*sizeof(int));
-	CHECK_SI_SIZE   (_kill, 2*sizeof(int));
-
-	BUILD_BUG_ON(offsetof(siginfo_t, si_pid) != 0x10);
-	BUILD_BUG_ON(offsetof(siginfo_t, si_uid) != 0x14);
-	BUILD_BUG_ON(offsetof(compat_siginfo_t, si_pid) != 0xC);
-	BUILD_BUG_ON(offsetof(compat_siginfo_t, si_uid) != 0x10);
-
-	CHECK_CSI_OFFSET(_timer);
-	CHECK_CSI_SIZE  (_timer, 3*sizeof(int));
-	CHECK_SI_SIZE   (_timer, 6*sizeof(int));
-
-	BUILD_BUG_ON(offsetof(siginfo_t, si_tid)     != 0x10);
-	BUILD_BUG_ON(offsetof(siginfo_t, si_overrun) != 0x14);
-	BUILD_BUG_ON(offsetof(siginfo_t, si_value)   != 0x18);
-	BUILD_BUG_ON(offsetof(compat_siginfo_t, si_tid)     != 0x0C);
-	BUILD_BUG_ON(offsetof(compat_siginfo_t, si_overrun) != 0x10);
-	BUILD_BUG_ON(offsetof(compat_siginfo_t, si_value)   != 0x14);
-
-	CHECK_CSI_OFFSET(_rt);
-	CHECK_CSI_SIZE  (_rt, 3*sizeof(int));
-	CHECK_SI_SIZE   (_rt, 4*sizeof(int));
-
-	BUILD_BUG_ON(offsetof(siginfo_t, si_pid)   != 0x10);
-	BUILD_BUG_ON(offsetof(siginfo_t, si_uid)   != 0x14);
-	BUILD_BUG_ON(offsetof(siginfo_t, si_value) != 0x18);
-	BUILD_BUG_ON(offsetof(compat_siginfo_t, si_pid)   != 0x0C);
-	BUILD_BUG_ON(offsetof(compat_siginfo_t, si_uid)   != 0x10);
-	BUILD_BUG_ON(offsetof(compat_siginfo_t, si_value) != 0x14);
-
-	CHECK_CSI_OFFSET(_sigchld);
-	CHECK_CSI_SIZE  (_sigchld, 5*sizeof(int));
-	CHECK_SI_SIZE   (_sigchld, 8*sizeof(int));
-
-	BUILD_BUG_ON(offsetof(siginfo_t, si_pid)    != 0x10);
-	BUILD_BUG_ON(offsetof(siginfo_t, si_uid)    != 0x14);
-	BUILD_BUG_ON(offsetof(siginfo_t, si_status) != 0x18);
-	BUILD_BUG_ON(offsetof(siginfo_t, si_utime)  != 0x20);
-	BUILD_BUG_ON(offsetof(siginfo_t, si_stime)  != 0x28);
-	BUILD_BUG_ON(offsetof(compat_siginfo_t, si_pid)    != 0x0C);
-	BUILD_BUG_ON(offsetof(compat_siginfo_t, si_uid)    != 0x10);
-	BUILD_BUG_ON(offsetof(compat_siginfo_t, si_status) != 0x14);
-	BUILD_BUG_ON(offsetof(compat_siginfo_t, si_utime)  != 0x18);
-	BUILD_BUG_ON(offsetof(compat_siginfo_t, si_stime)  != 0x1C);
-
-#ifdef CONFIG_X86_X32_ABI
-	CHECK_CSI_OFFSET(_sigchld_x32);
-	CHECK_CSI_SIZE  (_sigchld_x32, 7*sizeof(int));
-	/* no _sigchld_x32 in the generic siginfo_t */
-	BUILD_BUG_ON(offsetof(compat_siginfo_t, _sifields._sigchld_x32._utime)  != 0x18);
-	BUILD_BUG_ON(offsetof(compat_siginfo_t, _sifields._sigchld_x32._stime)  != 0x20);
-#endif
-
-	CHECK_CSI_OFFSET(_sigfault);
-	CHECK_CSI_SIZE  (_sigfault, 4*sizeof(int));
-	CHECK_SI_SIZE   (_sigfault, 8*sizeof(int));
-
-	BUILD_BUG_ON(offsetof(siginfo_t, si_addr) != 0x10);
-	BUILD_BUG_ON(offsetof(compat_siginfo_t, si_addr) != 0x0C);
-
-	BUILD_BUG_ON(offsetof(siginfo_t, si_trapno) != 0x18);
-	BUILD_BUG_ON(offsetof(compat_siginfo_t, si_trapno) != 0x10);
-
-	BUILD_BUG_ON(offsetof(siginfo_t, si_addr_lsb) != 0x18);
-	BUILD_BUG_ON(offsetof(compat_siginfo_t, si_addr_lsb) != 0x10);
-
-	BUILD_BUG_ON(offsetof(siginfo_t, si_lower) != 0x20);
-	BUILD_BUG_ON(offsetof(siginfo_t, si_upper) != 0x28);
-	BUILD_BUG_ON(offsetof(compat_siginfo_t, si_lower) != 0x14);
-	BUILD_BUG_ON(offsetof(compat_siginfo_t, si_upper) != 0x18);
-
-	BUILD_BUG_ON(offsetof(siginfo_t, si_pkey) != 0x20);
-	BUILD_BUG_ON(offsetof(compat_siginfo_t, si_pkey) != 0x14);
-
-	BUILD_BUG_ON(offsetof(siginfo_t, si_perf_data) != 0x18);
-	BUILD_BUG_ON(offsetof(siginfo_t, si_perf_type) != 0x20);
-	BUILD_BUG_ON(offsetof(siginfo_t, si_perf_flags) != 0x24);
-	BUILD_BUG_ON(offsetof(compat_siginfo_t, si_perf_data) != 0x10);
-	BUILD_BUG_ON(offsetof(compat_siginfo_t, si_perf_type) != 0x14);
-	BUILD_BUG_ON(offsetof(compat_siginfo_t, si_perf_flags) != 0x18);
-
-	CHECK_CSI_OFFSET(_sigpoll);
-	CHECK_CSI_SIZE  (_sigpoll, 2*sizeof(int));
-	CHECK_SI_SIZE   (_sigpoll, 4*sizeof(int));
-
-	BUILD_BUG_ON(offsetof(siginfo_t, si_band)   != 0x10);
-	BUILD_BUG_ON(offsetof(siginfo_t, si_fd)     != 0x18);
-	BUILD_BUG_ON(offsetof(compat_siginfo_t, si_band) != 0x0C);
-	BUILD_BUG_ON(offsetof(compat_siginfo_t, si_fd)   != 0x10);
-
-	CHECK_CSI_OFFSET(_sigsys);
-	CHECK_CSI_SIZE  (_sigsys, 3*sizeof(int));
-	CHECK_SI_SIZE   (_sigsys, 4*sizeof(int));
-
-	BUILD_BUG_ON(offsetof(siginfo_t, si_call_addr) != 0x10);
-	BUILD_BUG_ON(offsetof(siginfo_t, si_syscall)   != 0x18);
-	BUILD_BUG_ON(offsetof(siginfo_t, si_arch)      != 0x1C);
-	BUILD_BUG_ON(offsetof(compat_siginfo_t, si_call_addr) != 0x0C);
-	BUILD_BUG_ON(offsetof(compat_siginfo_t, si_syscall)   != 0x10);
-	BUILD_BUG_ON(offsetof(compat_siginfo_t, si_arch)      != 0x14);
-
-	/* any new si_fields should be added here */
-}
-
-void sigaction_compat_abi(struct k_sigaction *act, struct k_sigaction *oact)
-{
-	signal_compat_build_tests();
-
-	if (!act)
-		return;
-
-	if (in_ia32_syscall())
-		act->sa.sa_flags |= SA_IA32_ABI;
-	if (in_x32_syscall())
-		act->sa.sa_flags |= SA_X32_ABI;
-}
