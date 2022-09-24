Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13E4A5E89DF
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 10:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233348AbiIXIKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 04:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233717AbiIXIJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 04:09:59 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4B6D1C40D
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 01:06:56 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id c7so2203308pgt.11
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 01:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=ZztJ2RGkf9ik/kfcI8VkuRW9/ykfq0N2nmjBskO6I8w=;
        b=SGq4Zme50pYM7isGaE/N31OIWHa5k0uVFTKAgpg/9O8CML5leXwj2ZEyvbDxV2F4uF
         IWodg3gAZZAzSEv+f3cN2tm2KQG7Y0v4CCVdL/uXnGvJRWL9c49VlToMC6Z7pA+zToPN
         uZEEmCxYjY0Zp/56dnMor4JoktLdh7UNDJTbx2Hj+HhDco16O0sE1mLbKG2J515/8HzX
         o3W1QUu/WWG4jefG9uI5RoLYCVdEpSqPMqetLJiiz7cxP86/CrIAyCZC6NGQOjIB5LUx
         1K7d87opbpnyPnurthQCqK+YtVDMlzLMUkyWtZdz+Nml2f/2rRPNo6r5l/FiipQBRwGx
         j/OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=ZztJ2RGkf9ik/kfcI8VkuRW9/ykfq0N2nmjBskO6I8w=;
        b=yWLmEfSLcGAaK8d0lYKxHYEHQz3q9UeoT5AFoTM/66S7a2/Kd1J2aSNaHRnmX0hGe8
         TU2kLif3sOLV5o9vm/op7B4aiBoH2DQZYN/o5LihoEolnREkHtKNbaIdFAmw4IL5zJ0p
         ERDpjL3KzCqasN9pnAmH1Wa+nxlV6zwlfPi4x8DwwFeIcuXZq+5Aq9Mm6u4Y1ICkMYSQ
         Sl6i3I7j7iNzERGnmaPQxsWzPcKU1DXtLpOtKOOjtbj6xoe42JiTr3+H3WBNLXkVuk/3
         +F7I8jAhViLYS6LC6jYRpUafYir+PXSkZCr7cPJKuej5gBjkI8zrlWUgNJDSC34u6ptH
         OpqA==
X-Gm-Message-State: ACrzQf0P1JbOLSCnrCqxVWhCTugp8SpA1/vEAK0+Y+sfVbYwCAbl78Gc
        EGrHskrX0jwEG+zWycSW+vYyzwZxSZ/Mhg==
X-Google-Smtp-Source: AMsMyM79PDE8lCrPHW7J+AGVCnODIMu4673UEDL4yPjrHi1hB+nJPGkfwQ6GvJ76bmEA2Z/y5+9tKA==
X-Received: by 2002:a05:6a00:170b:b0:547:3e11:914f with SMTP id h11-20020a056a00170b00b005473e11914fmr13054823pfc.34.1664006800907;
        Sat, 24 Sep 2022 01:06:40 -0700 (PDT)
Received: from localhost.localdomain (l3b2w1.cn. [159.138.1.25])
        by smtp.gmail.com with ESMTPSA id w3-20020aa79543000000b0052e6c058bccsm7730087pfq.61.2022.09.24.01.06.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Sep 2022 01:06:40 -0700 (PDT)
From:   Binglei Wang <l3b2w1@gmail.com>
X-Google-Original-From: Binglei Wang
To:     conor@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, naveen.n.rao@linux.ibm.com,
        anil.s.keshavamurthy@intel.com, davem@davemloft.net,
        mhiramat@kernel.org
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Binglei Wang <l3b2w1@gmail.com>
Subject: [PATCH v5] rethook: add riscv rethook implementation.
Date:   Sat, 24 Sep 2022 16:06:35 +0800
Message-Id: <20220924080635.617881-1-l3b2w1@gmail.com>
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

Implement the kretprobes on riscv arch by using rethook mechanism
which abstracts general kretprobe info into a struct rethook_node
to be embedded in the struct kretprobe_instance.

1. replace __kretprobe_trampoline with
	arch_hook_trampoline
2. replace kretprobe_trampoline_handler with
	rethook_trampoline_handler

Signed-off-by: Binglei Wang <l3b2w1@gmail.com>
---
 arch/riscv/Kconfig                            |  1 +
 arch/riscv/kernel/probes/Makefile             |  1 +
 arch/riscv/kernel/probes/kprobes.c            |  8 --
 arch/riscv/kernel/probes/kprobes_trampoline.S | 73 +----------------
 arch/riscv/kernel/probes/kprobes_trampoline.h | 79 +++++++++++++++++++
 arch/riscv/kernel/probes/rethook.c            | 27 +++++++
 arch/riscv/kernel/probes/rethook.h            |  8 ++
 arch/riscv/kernel/probes/rethook_trampoline.S | 22 ++++++
 include/linux/kprobes.h                       |  6 ++
 9 files changed, 145 insertions(+), 80 deletions(-)
 create mode 100644 arch/riscv/kernel/probes/kprobes_trampoline.h
 create mode 100644 arch/riscv/kernel/probes/rethook.c
 create mode 100644 arch/riscv/kernel/probes/rethook.h
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
index 000000000..70fa063fe
--- /dev/null
+++ b/arch/riscv/kernel/probes/rethook.c
@@ -0,0 +1,27 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Generic return hook for riscv.
+ */
+
+#include <linux/kprobes.h>
+#include <linux/rethook.h>
+#include "rethook.h"
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
diff --git a/arch/riscv/kernel/probes/rethook.h b/arch/riscv/kernel/probes/rethook.h
new file mode 100644
index 000000000..cc573d701
--- /dev/null
+++ b/arch/riscv/kernel/probes/rethook.h
@@ -0,0 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#ifndef __RISCV_RETHOOK_H
+#define __RISCV_RETHOOK_H
+
+unsigned long arch_rethook_trampoline_callback(struct pt_regs *regs);
+void arch_rethook_prepare(struct rethook_node *rhn, struct pt_regs *regs, bool mcount);
+
+#endif
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
index 55041d2f8..a3805b5b2 100644
--- a/include/linux/kprobes.h
+++ b/include/linux/kprobes.h
@@ -210,6 +210,12 @@ static nokprobe_inline unsigned long get_kretprobe_retaddr(struct kretprobe_inst
 {
 	return ri->node.ret_addr;
 }
+static nokprobe_inline
+unsigned long kretprobe_trampoline_handler(struct pt_regs *regs,
+					   void *frame_pointer)
+{
+	return 0;
+}
 #else
 extern void arch_prepare_kretprobe(struct kretprobe_instance *ri,
 				   struct pt_regs *regs);
-- 
2.27.0

