Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FE2B5E5A07
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 06:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbiIVEHl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 00:07:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230189AbiIVEHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 00:07:14 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B48DEABD77
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 21:05:36 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id t70so7952567pgc.5
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 21:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=XhOwyVVMRCbfgpK6qtWRAyqEHRysH3fGOYv6wPseWjU=;
        b=jWKKePSEMkYvyh8863LYhQsokIm+ztdmvNUycu3rKi3jt+6v5DB8YyjtHQZLw71AkP
         NLdy9WO3bSsdIh8yEwnRu0ELxf3Qn9/gymEZSS/CkUeeItzgPsPAJJNwgjkgZCgyiIyu
         jURaAdXClCxv5aeCSDoYQuZD6OrZplokC40hYfOfe0kPgJTWnU8D+OCzzl0ZBK9xzi2S
         w/kA8HxFEF/fZmIg9RgTDaxruGebO/Yx2jhKKY1XDTA8ao72ToLDh74SoyJZrFsTB1P9
         I+0AifWUdZvb0FAteSQu+ovhGXASY/eo0ykMFZl/ou+gfQhNZQnsvitOPXpREZHiIpx9
         K5Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=XhOwyVVMRCbfgpK6qtWRAyqEHRysH3fGOYv6wPseWjU=;
        b=NvFFuALtTqL4OVUGbSDgy/gBjTTKB3KaRy5YeCcP5f6TRUX84ysVB/bMwd5Gr8wCCL
         a+Zf2gPWKIJrchOFcNzw6cKRstkEiiVVmFvLQxA97xn9nDH6A4Z11JgZ/FaUj9LkbTEe
         ex0HpdkCpz7hESmRreLhiHuLvAKIxuEX2GkoTTd7E+qC8HGHoLixnVoXKvtcgwNk3r+/
         Cbtywc2hadIrt/ySMB++wgpNu7KNNSZfDoE19Pn9GM1UgnoEgRooS21uW0pDGVBGYp/2
         95KYf8Zi2GeYexHhNobLSRIZtdSNs6hcXtvmaBJNBmSXpDDf9Cad5547+nPuSQUjwOT7
         5ecA==
X-Gm-Message-State: ACrzQf0O+AR58tEObbPmLgGnO2Bm9JV72aeJkAnwdetCa0ICdnZ9CKUB
        ZV5JtaJiMbV0UsLjzXxZ10g=
X-Google-Smtp-Source: AMsMyM5QBJytm+iGkJOoz017IDybixSK2zVwHFQnYgCLGJ/0gSlOZMlQwfLt+QvPDQQ6r+58uONlEw==
X-Received: by 2002:a05:6a00:b41:b0:52f:59dc:75 with SMTP id p1-20020a056a000b4100b0052f59dc0075mr1419855pfo.33.1663819489054;
        Wed, 21 Sep 2022 21:04:49 -0700 (PDT)
Received: from localhost.localdomain (l3b2w1.cn. [159.138.1.25])
        by smtp.gmail.com with ESMTPSA id 207-20020a6215d8000000b00537a6b81bb7sm3114606pfv.148.2022.09.21.21.04.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 21:04:48 -0700 (PDT)
From:   Binglei Wang <l3b2w1@gmail.com>
X-Google-Original-From: Binglei Wang
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, naveen.n.rao@linux.ibm.com,
        anil.s.keshavamurthy@intel.com, davem@davemloft.net,
        hiramat@kernel.org
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Binglei Wang <l3b2w1@gmail.com>
Subject: [PATCH] rethook: add riscv rethook implementation.
Date:   Thu, 22 Sep 2022 12:04:43 +0800
Message-Id: <20220922040443.605175-1-l3b2w1@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Binglei Wang <l3b2w1@gmail.com>

Implement the kretprobes on riscv arch by using rethook machenism
which abstracts general kretprobe info into a struct rethook_node
to be embedded in the struct kretprobe_instance.

Signed-off-by: Binglei Wang <l3b2w1@gmail.com>
---
 arch/riscv/Kconfig                            |  1 +
 arch/riscv/kernel/probes/Makefile             |  1 +
 arch/riscv/kernel/probes/kprobes.c            |  8 --
 arch/riscv/kernel/probes/kprobes_trampoline.S | 73 +----------------
 arch/riscv/kernel/probes/kprobes_trampoline.h | 79 +++++++++++++++++++
 arch/riscv/kernel/probes/rethook.c            | 26 ++++++
 arch/riscv/kernel/probes/rethook_trampoline.S | 22 ++++++
 include/linux/kprobes.h                       | 18 ++++-
 8 files changed, 146 insertions(+), 82 deletions(-)
 create mode 100644 arch/riscv/kernel/probes/kprobes_trampoline.h
 create mode 100644 arch/riscv/kernel/probes/rethook.c
 create mode 100644 arch/riscv/kernel/probes/rethook_trampoline.S

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index ed66c31e4..c5cae0825 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -97,6 +97,7 @@ config RISCV
 	select HAVE_KPROBES if !XIP_KERNEL
 	select HAVE_KPROBES_ON_FTRACE if !XIP_KERNEL
 	select HAVE_KRETPROBES if !XIP_KERNEL
+	select HAVE_RETHOOK if !XIP_KERNEL
 	select HAVE_MOVE_PMD
 	select HAVE_MOVE_PUD
 	select HAVE_PCI
diff --git a/arch/riscv/kernel/probes/Makefile b/arch/riscv/kernel/probes/Makefile
index 7f0840dcc..ee345e7e9 100644
--- a/arch/riscv/kernel/probes/Makefile
+++ b/arch/riscv/kernel/probes/Makefile
@@ -3,4 +3,5 @@ obj-$(CONFIG_KPROBES)		+= kprobes.o decode-insn.o simulate-insn.o
 obj-$(CONFIG_KPROBES)		+= kprobes_trampoline.o
 obj-$(CONFIG_KPROBES_ON_FTRACE)	+= ftrace.o
 obj-$(CONFIG_UPROBES)		+= uprobes.o decode-insn.o simulate-insn.o
+obj-$(CONFIG_RETHOOK) 		+= rethook.o rethook_trampoline.o
 CFLAGS_REMOVE_simulate-insn.o = $(CC_FLAGS_FTRACE)
diff --git a/arch/riscv/kernel/probes/kprobes.c b/arch/riscv/kernel/probes/kprobes.c
index e6e950b7c..04911cc42 100644
--- a/arch/riscv/kernel/probes/kprobes.c
+++ b/arch/riscv/kernel/probes/kprobes.c
@@ -350,14 +350,6 @@ void __kprobes __used *trampoline_probe_handler(struct pt_regs *regs)
 	return (void *)kretprobe_trampoline_handler(regs, NULL);
 }
 
-void __kprobes arch_prepare_kretprobe(struct kretprobe_instance *ri,
-				      struct pt_regs *regs)
-{
-	ri->ret_addr = (kprobe_opcode_t *)regs->ra;
-	ri->fp = NULL;
-	regs->ra = (unsigned long) &__kretprobe_trampoline;
-}
-
 int __kprobes arch_trampoline_kprobe(struct kprobe *p)
 {
 	return 0;
diff --git a/arch/riscv/kernel/probes/kprobes_trampoline.S b/arch/riscv/kernel/probes/kprobes_trampoline.S
index 7bdb09ded..54937f342 100644
--- a/arch/riscv/kernel/probes/kprobes_trampoline.S
+++ b/arch/riscv/kernel/probes/kprobes_trampoline.S
@@ -2,78 +2,7 @@
 /*
  * Author: Patrick Stählin <me@packi.ch>
  */
-#include <linux/linkage.h>
-
-#include <asm/asm.h>
-#include <asm/asm-offsets.h>
-
-	.text
-	.altmacro
-
-	.macro save_all_base_regs
-	REG_S x1,  PT_RA(sp)
-	REG_S x3,  PT_GP(sp)
-	REG_S x4,  PT_TP(sp)
-	REG_S x5,  PT_T0(sp)
-	REG_S x6,  PT_T1(sp)
-	REG_S x7,  PT_T2(sp)
-	REG_S x8,  PT_S0(sp)
-	REG_S x9,  PT_S1(sp)
-	REG_S x10, PT_A0(sp)
-	REG_S x11, PT_A1(sp)
-	REG_S x12, PT_A2(sp)
-	REG_S x13, PT_A3(sp)
-	REG_S x14, PT_A4(sp)
-	REG_S x15, PT_A5(sp)
-	REG_S x16, PT_A6(sp)
-	REG_S x17, PT_A7(sp)
-	REG_S x18, PT_S2(sp)
-	REG_S x19, PT_S3(sp)
-	REG_S x20, PT_S4(sp)
-	REG_S x21, PT_S5(sp)
-	REG_S x22, PT_S6(sp)
-	REG_S x23, PT_S7(sp)
-	REG_S x24, PT_S8(sp)
-	REG_S x25, PT_S9(sp)
-	REG_S x26, PT_S10(sp)
-	REG_S x27, PT_S11(sp)
-	REG_S x28, PT_T3(sp)
-	REG_S x29, PT_T4(sp)
-	REG_S x30, PT_T5(sp)
-	REG_S x31, PT_T6(sp)
-	.endm
-
-	.macro restore_all_base_regs
-	REG_L x3,  PT_GP(sp)
-	REG_L x4,  PT_TP(sp)
-	REG_L x5,  PT_T0(sp)
-	REG_L x6,  PT_T1(sp)
-	REG_L x7,  PT_T2(sp)
-	REG_L x8,  PT_S0(sp)
-	REG_L x9,  PT_S1(sp)
-	REG_L x10, PT_A0(sp)
-	REG_L x11, PT_A1(sp)
-	REG_L x12, PT_A2(sp)
-	REG_L x13, PT_A3(sp)
-	REG_L x14, PT_A4(sp)
-	REG_L x15, PT_A5(sp)
-	REG_L x16, PT_A6(sp)
-	REG_L x17, PT_A7(sp)
-	REG_L x18, PT_S2(sp)
-	REG_L x19, PT_S3(sp)
-	REG_L x20, PT_S4(sp)
-	REG_L x21, PT_S5(sp)
-	REG_L x22, PT_S6(sp)
-	REG_L x23, PT_S7(sp)
-	REG_L x24, PT_S8(sp)
-	REG_L x25, PT_S9(sp)
-	REG_L x26, PT_S10(sp)
-	REG_L x27, PT_S11(sp)
-	REG_L x28, PT_T3(sp)
-	REG_L x29, PT_T4(sp)
-	REG_L x30, PT_T5(sp)
-	REG_L x31, PT_T6(sp)
-	.endm
+#include "kprobes_trampoline.h"
 
 ENTRY(__kretprobe_trampoline)
 	addi sp, sp, -(PT_SIZE_ON_STACK)
diff --git a/arch/riscv/kernel/probes/kprobes_trampoline.h b/arch/riscv/kernel/probes/kprobes_trampoline.h
new file mode 100644
index 000000000..48895a5e3
--- /dev/null
+++ b/arch/riscv/kernel/probes/kprobes_trampoline.h
@@ -0,0 +1,79 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+#ifndef _KPROBES_TRAMPOLINE_H
+#define _KPROBES_TRAMPOLINE_H
+/*
+ * Author: Patrick Stählin <me@packi.ch>
+ */
+#include <linux/linkage.h>
+
+#include <asm/asm.h>
+#include <asm/asm-offsets.h>
+
+	.text
+	.altmacro
+
+	.macro save_all_base_regs
+	REG_S x1,  PT_RA(sp)
+	REG_S x3,  PT_GP(sp)
+	REG_S x4,  PT_TP(sp)
+	REG_S x5,  PT_T0(sp)
+	REG_S x6,  PT_T1(sp)
+	REG_S x7,  PT_T2(sp)
+	REG_S x8,  PT_S0(sp)
+	REG_S x9,  PT_S1(sp)
+	REG_S x10, PT_A0(sp)
+	REG_S x11, PT_A1(sp)
+	REG_S x12, PT_A2(sp)
+	REG_S x13, PT_A3(sp)
+	REG_S x14, PT_A4(sp)
+	REG_S x15, PT_A5(sp)
+	REG_S x16, PT_A6(sp)
+	REG_S x17, PT_A7(sp)
+	REG_S x18, PT_S2(sp)
+	REG_S x19, PT_S3(sp)
+	REG_S x20, PT_S4(sp)
+	REG_S x21, PT_S5(sp)
+	REG_S x22, PT_S6(sp)
+	REG_S x23, PT_S7(sp)
+	REG_S x24, PT_S8(sp)
+	REG_S x25, PT_S9(sp)
+	REG_S x26, PT_S10(sp)
+	REG_S x27, PT_S11(sp)
+	REG_S x28, PT_T3(sp)
+	REG_S x29, PT_T4(sp)
+	REG_S x30, PT_T5(sp)
+	REG_S x31, PT_T6(sp)
+	.endm
+
+	.macro restore_all_base_regs
+	REG_L x3,  PT_GP(sp)
+	REG_L x4,  PT_TP(sp)
+	REG_L x5,  PT_T0(sp)
+	REG_L x6,  PT_T1(sp)
+	REG_L x7,  PT_T2(sp)
+	REG_L x8,  PT_S0(sp)
+	REG_L x9,  PT_S1(sp)
+	REG_L x10, PT_A0(sp)
+	REG_L x11, PT_A1(sp)
+	REG_L x12, PT_A2(sp)
+	REG_L x13, PT_A3(sp)
+	REG_L x14, PT_A4(sp)
+	REG_L x15, PT_A5(sp)
+	REG_L x16, PT_A6(sp)
+	REG_L x17, PT_A7(sp)
+	REG_L x18, PT_S2(sp)
+	REG_L x19, PT_S3(sp)
+	REG_L x20, PT_S4(sp)
+	REG_L x21, PT_S5(sp)
+	REG_L x22, PT_S6(sp)
+	REG_L x23, PT_S7(sp)
+	REG_L x24, PT_S8(sp)
+	REG_L x25, PT_S9(sp)
+	REG_L x26, PT_S10(sp)
+	REG_L x27, PT_S11(sp)
+	REG_L x28, PT_T3(sp)
+	REG_L x29, PT_T4(sp)
+	REG_L x30, PT_T5(sp)
+	REG_L x31, PT_T6(sp)
+	.endm
+#endif
diff --git a/arch/riscv/kernel/probes/rethook.c b/arch/riscv/kernel/probes/rethook.c
new file mode 100644
index 000000000..4a41d5eb6
--- /dev/null
+++ b/arch/riscv/kernel/probes/rethook.c
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Generic return hook for riscv.
+ */
+
+#include <linux/kprobes.h>
+#include <linux/rethook.h>
+
+/* This is called from arch_rethook_trampoline() */
+unsigned long __used arch_rethook_trampoline_callback(struct pt_regs *regs)
+{
+	return rethook_trampoline_handler(regs, regs->s0);
+}
+NOKPROBE_SYMBOL(arch_rethook_trampoline_callback);
+
+
+void arch_rethook_prepare(struct rethook_node *rhn, struct pt_regs *regs, bool mcount)
+{
+	rhn->ret_addr = regs->ra;
+	rhn->frame = regs->s0;
+
+	/* replace return addr with trampoline */
+	regs->ra = (u64)arch_rethook_trampoline;
+}
+NOKPROBE_SYMBOL(arch_rethook_prepare);
+
diff --git a/arch/riscv/kernel/probes/rethook_trampoline.S b/arch/riscv/kernel/probes/rethook_trampoline.S
new file mode 100644
index 000000000..e81c3d4e0
--- /dev/null
+++ b/arch/riscv/kernel/probes/rethook_trampoline.S
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Author: Patrick Stählin <me@packi.ch>
+ */
+#include "kprobes_trampoline.h"
+
+ENTRY(arch_rethook_trampoline)
+	addi sp, sp, -(PT_SIZE_ON_STACK)
+	save_all_base_regs
+
+	move a0, sp /* pt_regs */
+
+	call arch_rethook_trampoline_callback
+
+	/* use the result as the return-address */
+	move ra, a0
+
+	restore_all_base_regs
+	addi sp, sp, PT_SIZE_ON_STACK
+
+	ret
+ENDPROC(arch_rethook_trampoline)
diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
index 55041d2f8..a21562c11 100644
--- a/include/linux/kprobes.h
+++ b/include/linux/kprobes.h
@@ -210,9 +210,23 @@ static nokprobe_inline unsigned long get_kretprobe_retaddr(struct kretprobe_inst
 {
 	return ri->node.ret_addr;
 }
+
+static nokprobe_inline
+unsigned long kretprobe_trampoline_handler(struct pt_regs *regs,
+					   void *frame_pointer)
+{
+	return 0;
+}
+
 #else
-extern void arch_prepare_kretprobe(struct kretprobe_instance *ri,
-				   struct pt_regs *regs);
+static nokprobe_inline void arch_prepare_kretprobe(struct kretprobe_instance *ri,
+				      struct pt_regs *regs)
+{
+	ri->ret_addr = (kprobe_opcode_t *)regs->ra;
+	ri->fp = NULL;
+	regs->ra = (unsigned long) &__kretprobe_trampoline;
+}
+
 void arch_kretprobe_fixup_return(struct pt_regs *regs,
 				 kprobe_opcode_t *correct_ret_addr);
 
-- 
2.27.0

