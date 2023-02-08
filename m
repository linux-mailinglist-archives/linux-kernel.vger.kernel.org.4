Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85FDE68ECAE
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 11:19:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231354AbjBHKTJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 05:19:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231339AbjBHKS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 05:18:57 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE7C62107
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 02:18:22 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id e19so10802759plc.9
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 02:18:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xibiFF/V1JSfx4FVu1IvjMxukDbBPo1ygOI1aB6E6KY=;
        b=gSoxX+30ZSN6YSvyVhGHh5k8oyw3bzp6LoGsX2Gs0fsCxXs7o9uIjw3O7BwfunuWld
         7htP47QFQiNfIpYKhmmtSCUj1sW3a/NQjfobHI6APZIR/CRB7qWSKn8zLOGdheQtIBsv
         D4YaMgo/0ojsU/zNsukIQQZ7BzAJQvS5LRgZ5CU1ltglIU+Ob8Z4kqvmNAqzFTNI8v7r
         zhUU+2afbl3kpUrttpvT2rizWdZuPstYYpWUe996ca/QkPGVyDBb5ednsy7Nfic9+9Fw
         siuxdVuV6LdK1eDQ5zuZai+/O8eMXIaF2vD0r6/Rm8RWvyT/hrJjBLxYlu77UIEjZQsi
         WrJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xibiFF/V1JSfx4FVu1IvjMxukDbBPo1ygOI1aB6E6KY=;
        b=7Hk63kpYGfY13TRZzSYxsL4byWOeMHH5yeR0DciJzOCmpIBIr9+aG9ldmY0X6StZhm
         /oa1pudPE5nOgh8shRGHVG1wZ3qeDNL3rHxds5iHr1AZ6uUPOQcG9m07Pr8BpdgZw3oe
         ziRvDYz7MTSWe7EtmtLiWktf+7mioLW6mlMyPY9jAe2SFpppGY0SuVWlw4Nw0cvdSCcS
         K07SKY05BAmeYNWyvlRlVea5xJwm4qzbTOEGwUXAFuNOFVjW1aN6KZ2TqPYn56ITupjG
         S0Ectz+bd/si6H5PTvl8sCZdeb0RgWcPqDZPJHJ6/jFzTIwcgCzH07z+nJLvkRPxGkLo
         v9Yw==
X-Gm-Message-State: AO0yUKVr/YpSJgHs6qZeEZ9Om4XS3dx6bdPJSYbjO7K1mZtqXEUoOFmv
        08gznZkw3Vjc5Qj1DpLUaTibPKrNkaUNoNkW
X-Google-Smtp-Source: AK7set9Ks3yZd0yyC/474w5+TGEaOf1SO3vfQ8OWO36WLq/w13+2yLtao/mvB4dpPeIrlwfB6EtHYQ==
X-Received: by 2002:a17:902:aa93:b0:197:35fc:6a4a with SMTP id d19-20020a170902aa9300b0019735fc6a4amr5950062plr.22.1675851499764;
        Wed, 08 Feb 2023 02:18:19 -0800 (PST)
Received: from localhost.localdomain ([112.20.108.204])
        by smtp.gmail.com with ESMTPSA id v23-20020a1709028d9700b0019926c7757asm3991058plo.289.2023.02.08.02.18.15
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 08 Feb 2023 02:18:19 -0800 (PST)
From:   chris.chenfeiyang@gmail.com
X-Google-Original-From: chenfeiyang@loongson.cn
To:     w@1wt.eu, paulmck@kernel.org
Cc:     Feiyang Chen <chenfeiyang@loongson.cn>, arnd@arndb.de,
        chenhuacai@kernel.org, jiaxun.yang@flygoat.com,
        chris.chenfeiyang@gmail.com, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/5] tools/nolibc: Add support for LoongArch
Date:   Wed,  8 Feb 2023 18:17:52 +0800
Message-Id: <26f03f1be0cd687f0d5099060362b2c8bc06c855.1675851111.git.chenfeiyang@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1675851111.git.chenfeiyang@loongson.cn>
References: <cover.1675851111.git.chenfeiyang@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Feiyang Chen <chenfeiyang@loongson.cn>

Add support for LoongArch (32 and 64 bit) to nolibc.

Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
---
 tools/include/nolibc/arch-loongarch.h | 200 ++++++++++++++++++++++++++
 tools/include/nolibc/arch.h           |   2 +
 2 files changed, 202 insertions(+)
 create mode 100644 tools/include/nolibc/arch-loongarch.h

diff --git a/tools/include/nolibc/arch-loongarch.h b/tools/include/nolibc/arch-loongarch.h
new file mode 100644
index 000000000000..029ee3cd6baf
--- /dev/null
+++ b/tools/include/nolibc/arch-loongarch.h
@@ -0,0 +1,200 @@
+/* SPDX-License-Identifier: LGPL-2.1 OR MIT */
+/*
+ * LoongArch specific definitions for NOLIBC
+ * Copyright (C) 2023 Loongson Technology Corporation Limited
+ */
+
+#ifndef _NOLIBC_ARCH_LOONGARCH_H
+#define _NOLIBC_ARCH_LOONGARCH_H
+
+/* Syscalls for LoongArch :
+ *   - stack is 16-byte aligned
+ *   - syscall number is passed in a7
+ *   - arguments are in a0, a1, a2, a3, a4, a5
+ *   - the system call is performed by calling "syscall 0"
+ *   - syscall return comes in a0
+ *   - the arguments are cast to long and assigned into the target
+ *     registers which are then simply passed as registers to the asm code,
+ *     so that we don't have to experience issues with register constraints.
+ *
+ * On LoongArch, select() is not implemented so we have to use pselect6().
+ */
+#define __ARCH_WANT_SYS_PSELECT6
+
+#define my_syscall0(num)                                                      \
+({                                                                            \
+	register long _num  __asm__ ("a7") = (num);                           \
+	register long _arg1 __asm__ ("a0");                                   \
+									      \
+	__asm__  volatile (                                                   \
+		"syscall 0\n"                                                 \
+		: "=r"(_arg1)                                                 \
+		: "r"(_num)                                                   \
+		: "memory", "$t0", "$t1", "$t2", "$t3",                       \
+		  "$t4", "$t5", "$t6", "$t7", "$t8"                           \
+	);                                                                    \
+	_arg1;                                                                \
+})
+
+#define my_syscall1(num, arg1)                                                \
+({                                                                            \
+	register long _num  __asm__ ("a7") = (num);                           \
+	register long _arg1 __asm__ ("a0") = (long)(arg1);		      \
+									      \
+	__asm__  volatile (                                                   \
+		"syscall 0\n"                                                 \
+		: "+r"(_arg1)                                                 \
+		: "r"(_num)                                                   \
+		: "memory", "$t0", "$t1", "$t2", "$t3",                       \
+		  "$t4", "$t5", "$t6", "$t7", "$t8"                           \
+	);                                                                    \
+	_arg1;                                                                \
+})
+
+#define my_syscall2(num, arg1, arg2)                                          \
+({                                                                            \
+	register long _num  __asm__ ("a7") = (num);                           \
+	register long _arg1 __asm__ ("a0") = (long)(arg1);                    \
+	register long _arg2 __asm__ ("a1") = (long)(arg2);                    \
+									      \
+	__asm__  volatile (                                                   \
+		"syscall 0\n"                                                 \
+		: "+r"(_arg1)                                                 \
+		: "r"(_arg2),                                                 \
+		  "r"(_num)                                                   \
+		: "memory", "$t0", "$t1", "$t2", "$t3",                       \
+		  "$t4", "$t5", "$t6", "$t7", "$t8"                           \
+	);                                                                    \
+	_arg1;                                                                \
+})
+
+#define my_syscall3(num, arg1, arg2, arg3)                                    \
+({                                                                            \
+	register long _num  __asm__ ("a7") = (num);                           \
+	register long _arg1 __asm__ ("a0") = (long)(arg1);                    \
+	register long _arg2 __asm__ ("a1") = (long)(arg2);                    \
+	register long _arg3 __asm__ ("a2") = (long)(arg3);                    \
+									      \
+	__asm__  volatile (                                                   \
+		"syscall 0\n"                                                 \
+		: "+r"(_arg1)                                                 \
+		: "r"(_arg2), "r"(_arg3),                                     \
+		  "r"(_num)                                                   \
+		: "memory", "$t0", "$t1", "$t2", "$t3",                       \
+		  "$t4", "$t5", "$t6", "$t7", "$t8"                           \
+	);                                                                    \
+	_arg1;                                                                \
+})
+
+#define my_syscall4(num, arg1, arg2, arg3, arg4)                              \
+({                                                                            \
+	register long _num  __asm__ ("a7") = (num);                           \
+	register long _arg1 __asm__ ("a0") = (long)(arg1);                    \
+	register long _arg2 __asm__ ("a1") = (long)(arg2);                    \
+	register long _arg3 __asm__ ("a2") = (long)(arg3);                    \
+	register long _arg4 __asm__ ("a3") = (long)(arg4);                    \
+									      \
+	__asm__  volatile (                                                   \
+		"syscall 0\n"                                                 \
+		: "+r"(_arg1)                                                 \
+		: "r"(_arg2), "r"(_arg3), "r"(_arg4),                         \
+		  "r"(_num)                                                   \
+		: "memory", "$t0", "$t1", "$t2", "$t3",                       \
+		  "$t4", "$t5", "$t6", "$t7", "$t8"                           \
+	);                                                                    \
+	_arg1;                                                                \
+})
+
+#define my_syscall5(num, arg1, arg2, arg3, arg4, arg5)                        \
+({                                                                            \
+	register long _num  __asm__ ("a7") = (num);                           \
+	register long _arg1 __asm__ ("a0") = (long)(arg1);                    \
+	register long _arg2 __asm__ ("a1") = (long)(arg2);                    \
+	register long _arg3 __asm__ ("a2") = (long)(arg3);                    \
+	register long _arg4 __asm__ ("a3") = (long)(arg4);                    \
+	register long _arg5 __asm__ ("a4") = (long)(arg5);                    \
+									      \
+	__asm__  volatile (                                                   \
+		"syscall 0\n"                                                 \
+		: "+r"(_arg1)                                                 \
+		: "r"(_arg2), "r"(_arg3), "r"(_arg4), "r"(_arg5),             \
+		  "r"(_num)                                                   \
+		: "memory", "$t0", "$t1", "$t2", "$t3",                       \
+		  "$t4", "$t5", "$t6", "$t7", "$t8"                           \
+	);                                                                    \
+	_arg1;                                                                \
+})
+
+#define my_syscall6(num, arg1, arg2, arg3, arg4, arg5, arg6)                  \
+({                                                                            \
+	register long _num  __asm__ ("a7") = (num);                           \
+	register long _arg1 __asm__ ("a0") = (long)(arg1);                    \
+	register long _arg2 __asm__ ("a1") = (long)(arg2);                    \
+	register long _arg3 __asm__ ("a2") = (long)(arg3);                    \
+	register long _arg4 __asm__ ("a3") = (long)(arg4);                    \
+	register long _arg5 __asm__ ("a4") = (long)(arg5);                    \
+	register long _arg6 __asm__ ("a5") = (long)(arg6);                    \
+									      \
+	__asm__  volatile (                                                   \
+		"syscall 0\n"                                                 \
+		: "+r"(_arg1)                                                 \
+		: "r"(_arg2), "r"(_arg3), "r"(_arg4), "r"(_arg5), "r"(_arg6), \
+		  "r"(_num)                                                   \
+		: "memory", "$t0", "$t1", "$t2", "$t3",                       \
+		  "$t4", "$t5", "$t6", "$t7", "$t8"                           \
+	);                                                                    \
+	_arg1;                                                                \
+})
+
+char **environ __attribute__((weak));
+const unsigned long *_auxv __attribute__((weak));
+
+#if __loongarch_grlen == 32
+#define LONGLOG      "2"
+#define SZREG        "4"
+#define REG_L        "ld.w"
+#define LONG_S       "st.w"
+#define LONG_ADD     "add.w"
+#define LONG_ADDI    "addi.w"
+#define LONG_SLL     "slli.w"
+#define LONG_BSTRINS "bstrins.w"
+#else // __loongarch_grlen == 64
+#define LONGLOG      "3"
+#define SZREG        "8"
+#define REG_L        "ld.d"
+#define LONG_S       "st.d"
+#define LONG_ADD     "add.d"
+#define LONG_ADDI    "addi.d"
+#define LONG_SLL     "slli.d"
+#define LONG_BSTRINS "bstrins.d"
+#endif
+
+/* startup code */
+void __attribute__((weak,noreturn,optimize("omit-frame-pointer"))) _start(void)
+{
+	__asm__ volatile (
+		REG_L        " $a0, $sp, 0\n"         // argc (a0) was in the stack
+		LONG_ADDI    " $a1, $sp, "SZREG"\n"   // argv (a1) = sp + SZREG
+		LONG_SLL     " $a2, $a0, "LONGLOG"\n" // envp (a2) = SZREG*argc ...
+		LONG_ADDI    " $a2, $a2, "SZREG"\n"   //             + SZREG (skip null)
+		LONG_ADD     " $a2, $a2, $a1\n"       //             + argv
+
+		"move          $a3, $a2\n"            // iterate a3 over envp to find auxv (after NULL)
+		"0:\n"                                // do {
+		REG_L        " $a4, $a3, 0\n"         //   a4 = *a3;
+		LONG_ADDI    " $a3, $a3, "SZREG"\n"   //   a3 += sizeof(void*);
+		"bne           $a4, $zero, 0b\n"      // } while (a4);
+		"la.pcrel      $a4, _auxv\n"          // a4 = &_auxv
+		LONG_S       " $a3, $a4, 0\n"         // store a3 into _auxv
+
+		"la.pcrel      $a3, environ\n"        // a3 = &environ
+		LONG_S       " $a2, $a3, 0\n"         // store envp(a2) into environ
+		LONG_BSTRINS " $sp, $zero, 3, 0\n"    // sp must be 16-byte aligned
+		"bl            main\n"                // main() returns the status code, we'll exit with it.
+		"li.w          $a7, 93\n"             // NR_exit == 93
+		"syscall       0\n"
+	);
+	__builtin_unreachable();
+}
+
+#endif // _NOLIBC_ARCH_LOONGARCH_H
diff --git a/tools/include/nolibc/arch.h b/tools/include/nolibc/arch.h
index 78b067a4fa47..2d5386a8d6aa 100644
--- a/tools/include/nolibc/arch.h
+++ b/tools/include/nolibc/arch.h
@@ -29,6 +29,8 @@
 #include "arch-riscv.h"
 #elif defined(__s390x__)
 #include "arch-s390.h"
+#elif defined(__loongarch__)
+#include "arch-loongarch.h"
 #endif
 
 #endif /* _NOLIBC_ARCH_H */
-- 
2.39.0

