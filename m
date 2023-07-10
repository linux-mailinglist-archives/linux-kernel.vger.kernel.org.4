Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DFED74DD68
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 20:35:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232938AbjGJSfz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 14:35:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232425AbjGJSfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 14:35:52 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD953AB
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 11:35:50 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-573a92296c7so45721827b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 11:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689014150; x=1691606150;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JfuHjbGr9PeJ0PR5WLnTESMLUU2NVQbFj+yFH1gqRF8=;
        b=mfJmD/FVxdps7T5hJgcEwE8ThNbmRX23y5+EPxfWQlxj6UzddODlWvVoSL6wC7wQRF
         7XAhpM5lbDJKg8TKuoGB1c1ue1+UMDBnHKcnrWz8EKF/iuOpk8L1mVDJpZq89pYBqhpg
         dJxY6yG5Hu9cekfrYhwzL7ozTUlwtvElo14dPK7U8ueUvqwY93fFiORY2RIGwjr2de52
         4IdpdZBJc1AcpSC8qxgX+Td/y6IyIUqYG7m8AvU3WpDk4lhmLnoOxwesVjgCxSHltEaC
         hxJxlgkH1y7pNyDb9DldBddfDFXrpa3X9yMIdkBe7XuSHYH1BiSExntrPr9ZdQGIM3lG
         y7Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689014150; x=1691606150;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JfuHjbGr9PeJ0PR5WLnTESMLUU2NVQbFj+yFH1gqRF8=;
        b=NecEi9xGi6HV/IhgAjBBrBX2wH96L9NK+ZyvkGzpkfQ+yuIegDPGfPfdH066p+OGTE
         qr1XHqXUPh/NfXqCtb/OsHAJAFdFGjaR/mw5GfUMMqpXHhpbr1pbvrdhqUM6oH//ajLr
         Dah02aYjo4xAOolkSwgvKejIT6l7ohdqkeGYbQpatLs+7UaDC/CUuGtbEBavG15AeCjV
         S5K9JKy/s/OxxlRz22k23KiG+nkyQqAD9V+Oi7KtcF34Q0/rkOGjRZEi2RUqm81ygouK
         1k6vQfnntrdO+6w40zn1+xWIlOiGvwGIhpfirXL+QZUO7T47QpyOWU9zHvLEu9DcPzKU
         941w==
X-Gm-Message-State: ABy/qLZ4iv6zW+Slp42v6oTASwwneAvsGcUE2f79c7GA1yhqF2x2EMOi
        ZVEFDuDp8RLBboaoRqyepDnukvfvY2fElTilmtI=
X-Google-Smtp-Source: APBJJlEUb5UKL1MoSsyogYSLs7WHlDzV7fhet/hBVyc5/uQaybIB1vy1s68RPBBiLePBq9ferUaZYZvQPVwzmK3DUbY=
X-Received: from samitolvanen.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:4f92])
 (user=samitolvanen job=sendgmr) by 2002:a81:ac47:0:b0:56c:e2da:f440 with SMTP
 id z7-20020a81ac47000000b0056ce2daf440mr91792ywj.0.1689014149963; Mon, 10 Jul
 2023 11:35:49 -0700 (PDT)
Date:   Mon, 10 Jul 2023 18:35:46 +0000
In-Reply-To: <20230710183544.999540-8-samitolvanen@google.com>
Mime-Version: 1.0
References: <20230710183544.999540-8-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=8809; i=samitolvanen@google.com;
 h=from:subject; bh=7+cMm1pNGnHHsX43z/oJuDPuAORNOaBoot6v/Dk88QA=;
 b=owEB7QES/pANAwAKAUy19oSLvFbuAcsmYgBkrE+AWvBzRqwMc4no+3K7g72jpT5CxxsH8+M57
 5Pfxcns1zGJAbMEAAEKAB0WIQQ1zPtjsoPW0663g5RMtfaEi7xW7gUCZKxPgAAKCRBMtfaEi7xW
 7klBC/9woGxzCUzYKiDh4bV8sfcQRvfqQcNafvzua53LYJu8Dhb5EZI7ZgbdCtX0uFHmX85kpj0
 zb80cpbqN0YKtlVtlK2bneO0lRb23IA4K56CkSIbkJ/PNTf6szlM6WSgiAkRBur5AcBrhZghQAE
 hKR6k/TkktuSLXvR48ACKZ83MqBceKQuAw/pXViv7IjyGfZhMp9yH9E0HzmABzQaAJWj2IB3cEs
 BthBLLw4VeeUf/5YNbXwuEInwCpRi5sXiYjILikglUyym+cYd9Fs4xgorzJtuDs3eOqp5/WuS3o
 3LriBrlnEyA92fiA+eg/tkzqQ020dz5y5v2xQwWFm/zK8Rfcve3BWxl4LwKHPOUPy2q0aj1bn8J
 tqnf5BBS/pyj0W2SNjKIELmWzeGqRKO3XfEngeuffy4yKSQJ490huNwXXEm+UhOVahsyumOSne7 5nCRwwKiII8ocld8d1+UqeN+5TJyFtO635ztUB2mSkScfansrXAjy3jafaGBEIdL1z6tY=
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230710183544.999540-9-samitolvanen@google.com>
Subject: [PATCH v2 1/6] riscv: Implement syscall wrappers
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Kees Cook <keescook@chromium.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        linux-riscv@lists.infradead.org, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit f0bddf50586d ("riscv: entry: Convert to generic entry") moved
syscall handling to C code, which exposed function pointer type
mismatches that trip fine-grained forward-edge Control-Flow Integrity
(CFI) checks as syscall handlers are all called through the same
syscall_t pointer type. To fix the type mismatches, implement pt_regs
based syscall wrappers similarly to x86 and arm64.

This patch is based on arm64 syscall wrappers added in commit
4378a7d4be30 ("arm64: implement syscall wrappers"), where the main goal
was to minimize the risk of userspace-controlled values being used
under speculation. This may be a concern for riscv in future as well.

Following other architectures, the syscall wrappers generate three
functions for each syscall; __riscv_<compat_>sys_<name> takes a pt_regs
pointer and extracts arguments from registers, __se_<compat_>sys_<name>
is a sign-extension wrapper that casts the long arguments to the
correct types for the real syscall implementation, which is named
__do_<compat_>sys_<name>.

Reviewed-by: Kees Cook <keescook@chromium.org>
Tested-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 arch/riscv/Kconfig                       |  1 +
 arch/riscv/include/asm/syscall.h         |  5 +-
 arch/riscv/include/asm/syscall_wrapper.h | 87 ++++++++++++++++++++++++
 arch/riscv/kernel/compat_syscall_table.c |  8 ++-
 arch/riscv/kernel/sys_riscv.c            |  6 ++
 arch/riscv/kernel/syscall_table.c        |  8 ++-
 6 files changed, 108 insertions(+), 7 deletions(-)
 create mode 100644 arch/riscv/include/asm/syscall_wrapper.h

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 4c07b9189c86..a475ef1a0c1c 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -35,6 +35,7 @@ config RISCV
 	select ARCH_HAS_SET_MEMORY if MMU
 	select ARCH_HAS_STRICT_KERNEL_RWX if MMU && !XIP_KERNEL
 	select ARCH_HAS_STRICT_MODULE_RWX if MMU && !XIP_KERNEL
+	select ARCH_HAS_SYSCALL_WRAPPER
 	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
 	select ARCH_HAS_UBSAN_SANITIZE_ALL
 	select ARCH_HAS_VDSO_DATA
diff --git a/arch/riscv/include/asm/syscall.h b/arch/riscv/include/asm/syscall.h
index 0148c6bd9675..121fff429dce 100644
--- a/arch/riscv/include/asm/syscall.h
+++ b/arch/riscv/include/asm/syscall.h
@@ -75,7 +75,7 @@ static inline int syscall_get_arch(struct task_struct *task)
 #endif
 }
 
-typedef long (*syscall_t)(ulong, ulong, ulong, ulong, ulong, ulong, ulong);
+typedef long (*syscall_t)(const struct pt_regs *);
 static inline void syscall_handler(struct pt_regs *regs, ulong syscall)
 {
 	syscall_t fn;
@@ -87,8 +87,7 @@ static inline void syscall_handler(struct pt_regs *regs, ulong syscall)
 #endif
 		fn = sys_call_table[syscall];
 
-	regs->a0 = fn(regs->orig_a0, regs->a1, regs->a2,
-		      regs->a3, regs->a4, regs->a5, regs->a6);
+	regs->a0 = fn(regs);
 }
 
 static inline bool arch_syscall_is_vdso_sigreturn(struct pt_regs *regs)
diff --git a/arch/riscv/include/asm/syscall_wrapper.h b/arch/riscv/include/asm/syscall_wrapper.h
new file mode 100644
index 000000000000..1d7942c8a6cb
--- /dev/null
+++ b/arch/riscv/include/asm/syscall_wrapper.h
@@ -0,0 +1,87 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * syscall_wrapper.h - riscv specific wrappers to syscall definitions
+ *
+ * Based on arch/arm64/include/syscall_wrapper.h
+ */
+
+#ifndef __ASM_SYSCALL_WRAPPER_H
+#define __ASM_SYSCALL_WRAPPER_H
+
+#include <asm/ptrace.h>
+
+asmlinkage long __riscv_sys_ni_syscall(const struct pt_regs *);
+
+#define SC_RISCV_REGS_TO_ARGS(x, ...)				\
+	__MAP(x,__SC_ARGS					\
+	      ,,regs->orig_a0,,regs->a1,,regs->a2		\
+	      ,,regs->a3,,regs->a4,,regs->a5,,regs->a6)
+
+#ifdef CONFIG_COMPAT
+
+#define COMPAT_SYSCALL_DEFINEx(x, name, ...)						\
+	asmlinkage long __riscv_compat_sys##name(const struct pt_regs *regs);		\
+	ALLOW_ERROR_INJECTION(__riscv_compat_sys##name, ERRNO);				\
+	static long __se_compat_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__));		\
+	static inline long __do_compat_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__));	\
+	asmlinkage long __riscv_compat_sys##name(const struct pt_regs *regs)		\
+	{										\
+		return __se_compat_sys##name(SC_RISCV_REGS_TO_ARGS(x,__VA_ARGS__));	\
+	}										\
+	static long __se_compat_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__))		\
+	{										\
+		return __do_compat_sys##name(__MAP(x,__SC_DELOUSE,__VA_ARGS__));	\
+	}										\
+	static inline long __do_compat_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))
+
+#define COMPAT_SYSCALL_DEFINE0(sname)							\
+	asmlinkage long __riscv_compat_sys_##sname(const struct pt_regs *__unused);	\
+	ALLOW_ERROR_INJECTION(__riscv_compat_sys_##sname, ERRNO);			\
+	asmlinkage long __riscv_compat_sys_##sname(const struct pt_regs *__unused)
+
+#define COND_SYSCALL_COMPAT(name) 							\
+	asmlinkage long __weak __riscv_compat_sys_##name(const struct pt_regs *regs);	\
+	asmlinkage long __weak __riscv_compat_sys_##name(const struct pt_regs *regs)	\
+	{										\
+		return sys_ni_syscall();						\
+	}
+
+#define COMPAT_SYS_NI(name) \
+	SYSCALL_ALIAS(__riscv_compat_sys_##name, sys_ni_posix_timers);
+
+#endif /* CONFIG_COMPAT */
+
+#define __SYSCALL_DEFINEx(x, name, ...)						\
+	asmlinkage long __riscv_sys##name(const struct pt_regs *regs);		\
+	ALLOW_ERROR_INJECTION(__riscv_sys##name, ERRNO);			\
+	static long __se_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__));		\
+	static inline long __do_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__));	\
+	asmlinkage long __riscv_sys##name(const struct pt_regs *regs)		\
+	{									\
+		return __se_sys##name(SC_RISCV_REGS_TO_ARGS(x,__VA_ARGS__));	\
+	}									\
+	static long __se_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__))		\
+	{									\
+		long ret = __do_sys##name(__MAP(x,__SC_CAST,__VA_ARGS__));	\
+		__MAP(x,__SC_TEST,__VA_ARGS__);					\
+		__PROTECT(x, ret,__MAP(x,__SC_ARGS,__VA_ARGS__));		\
+		return ret;							\
+	}									\
+	static inline long __do_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))
+
+#define SYSCALL_DEFINE0(sname)							\
+	SYSCALL_METADATA(_##sname, 0);						\
+	asmlinkage long __riscv_sys_##sname(const struct pt_regs *__unused);	\
+	ALLOW_ERROR_INJECTION(__riscv_sys_##sname, ERRNO);			\
+	asmlinkage long __riscv_sys_##sname(const struct pt_regs *__unused)
+
+#define COND_SYSCALL(name)							\
+	asmlinkage long __weak __riscv_sys_##name(const struct pt_regs *regs);	\
+	asmlinkage long __weak __riscv_sys_##name(const struct pt_regs *regs)	\
+	{									\
+		return sys_ni_syscall();					\
+	}
+
+#define SYS_NI(name) SYSCALL_ALIAS(__riscv_sys_##name, sys_ni_posix_timers);
+
+#endif /* __ASM_SYSCALL_WRAPPER_H */
diff --git a/arch/riscv/kernel/compat_syscall_table.c b/arch/riscv/kernel/compat_syscall_table.c
index 651f2b009c28..ad7f2d712f5f 100644
--- a/arch/riscv/kernel/compat_syscall_table.c
+++ b/arch/riscv/kernel/compat_syscall_table.c
@@ -9,11 +9,15 @@
 #include <asm/syscall.h>
 
 #undef __SYSCALL
-#define __SYSCALL(nr, call)      [nr] = (call),
+#define __SYSCALL(nr, call)	asmlinkage long __riscv_##call(const struct pt_regs *);
+#include <asm/unistd.h>
+
+#undef __SYSCALL
+#define __SYSCALL(nr, call)      [nr] = __riscv_##call,
 
 asmlinkage long compat_sys_rt_sigreturn(void);
 
 void * const compat_sys_call_table[__NR_syscalls] = {
-	[0 ... __NR_syscalls - 1] = sys_ni_syscall,
+	[0 ... __NR_syscalls - 1] = __riscv_sys_ni_syscall,
 #include <asm/unistd.h>
 };
diff --git a/arch/riscv/kernel/sys_riscv.c b/arch/riscv/kernel/sys_riscv.c
index 26ef5526bfb4..473159b5f303 100644
--- a/arch/riscv/kernel/sys_riscv.c
+++ b/arch/riscv/kernel/sys_riscv.c
@@ -335,3 +335,9 @@ SYSCALL_DEFINE5(riscv_hwprobe, struct riscv_hwprobe __user *, pairs,
 	return do_riscv_hwprobe(pairs, pair_count, cpu_count,
 				cpus, flags);
 }
+
+/* Not defined using SYSCALL_DEFINE0 to avoid error injection */
+asmlinkage long __riscv_sys_ni_syscall(const struct pt_regs *__unused)
+{
+	return -ENOSYS;
+}
diff --git a/arch/riscv/kernel/syscall_table.c b/arch/riscv/kernel/syscall_table.c
index 44b1420a2270..dda913764903 100644
--- a/arch/riscv/kernel/syscall_table.c
+++ b/arch/riscv/kernel/syscall_table.c
@@ -10,9 +10,13 @@
 #include <asm/syscall.h>
 
 #undef __SYSCALL
-#define __SYSCALL(nr, call)	[nr] = (call),
+#define __SYSCALL(nr, call)	asmlinkage long __riscv_##call(const struct pt_regs *);
+#include <asm/unistd.h>
+
+#undef __SYSCALL
+#define __SYSCALL(nr, call)	[nr] = __riscv_##call,
 
 void * const sys_call_table[__NR_syscalls] = {
-	[0 ... __NR_syscalls - 1] = sys_ni_syscall,
+	[0 ... __NR_syscalls - 1] = __riscv_sys_ni_syscall,
 #include <asm/unistd.h>
 };
-- 
2.41.0.255.g8b1d071c50-goog

