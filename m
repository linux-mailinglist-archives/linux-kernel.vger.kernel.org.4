Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F0BF60BB78
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 23:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232043AbiJXVBx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 17:01:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbiJXVBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 17:01:21 -0400
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D8772B7689
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 12:06:58 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id a2so8789457vsc.13
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 12:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TWY8G2KdEwD82A7w5TBmH74pr/Rs6CUZ3AsJUTFV20k=;
        b=f5lMAAhJjKRua9xY9Hw2j4Qp50h71sGfgOxL1f1k3kkDkUdaePIyxdNQShDl2MNGM6
         YRASHpGqESiRL6qw/dbghbD23wpQEgEvgWlhO8/vg7fz0h5bH5Hwu4QGS30o/DRFqxBP
         E3u9td6kGnZP6DSggpqE59pRt8svAzxQhhiOQqacGc2EEM+9eyAFqGtubOaDuydVvJH4
         6dyYikOPoNOTAnCs7yyrPTPv7UG4gGJIJiUixd/avoFnxbwteStEhwNMxKK1xTU+qLQX
         itrrp0061L3IsJVvK1J6JznYAwkaOPJHuQVkMRmqqhzRMDKGid2DZdbtuciLjPchf65B
         7MGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TWY8G2KdEwD82A7w5TBmH74pr/Rs6CUZ3AsJUTFV20k=;
        b=CPBk3+8nNdd2AaE8Uq4teoKqeNWeLptBo1LBMNAP5zlOHQ/gMTu9/f/ey8hv3bC5ij
         RXHBOa9je4dzfVdb7u3A3so4mHlxsRgfKrRwF8AmDcSAF5Lk04wfNRutBRDf5R+KDVOX
         G+n4bdrQap/CmKS0pQYIWyR+GAIQR31+6PGTGvDf6Ch9cd4s7sWyfscqP+woJgxDyx5k
         qn9c5x3YYR0XgzfmqRzoEFqv7fH7dGodrItqt57Qk2wnBEJllKn86iF2SCt4k/5YfjI0
         e0psYkgpX9+25beP2iI8Bto70MrkTp+fQIUyp8c1MJWc5oGUBuRXZeNopCoS1aYonxgJ
         QdOA==
X-Gm-Message-State: ACrzQf1AdD30gitHRpYrSxC/1u5TD347cWBTOZrN2iwUrKHyXTydNGk4
        QmPwBEWa0bOTRmJrVmwaRXvyvgFK6CqcrKUj
X-Google-Smtp-Source: AMsMyM7RcohJJEwuuJiPlQoWYIFMtAr+NAanMmP0Bh/3P9FrIE/x4TKnFv+dqdW6XV6GQF43UNdj0w==
X-Received: by 2002:a17:902:dacf:b0:186:1269:9292 with SMTP id q15-20020a170902dacf00b0018612699292mr35755902plx.129.1666628285918;
        Mon, 24 Oct 2022 09:18:05 -0700 (PDT)
Received: from localhost.localdomain ([199.255.98.161])
        by smtp.gmail.com with ESMTPSA id y17-20020a1709027c9100b0016cf3f124e1sm19476116pll.234.2022.10.24.09.18.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 09:18:05 -0700 (PDT)
From:   Binglei Wang <l3b2w1@gmail.com>
X-Google-Original-From: Binglei Wang
To:     mhiramat@kernel.org, conor@kernel.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu,
        naveen.n.rao@linux.ibm.com, anil.s.keshavamurthy@intel.com,
        davem@davemloft.net
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Binglei Wang <l3b2w1@gmail.com>
Subject: [PATCH v9] riscv: add riscv rethook implementation
Date:   Tue, 25 Oct 2022 00:17:49 +0800
Message-Id: <20221024161749.69717-1-l3b2w1@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
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

Notes:
    v9: fix checkpatch.pl warnings
    v8: Add the omitted rethook.h
    v7: Add the changelog.
    v6: Remove the kretprobes trampoline.
    v5: Trt to fix robot compiling error and warnings.
    v4: Add patch version number.
    v3: Trt to fix robot compiling error and warnings.
    v2: Add comit log to explain reasons behind changes.
        Use my personal email instead of work email
            to avoid the attachments of company informaton.
        Make the kprobes_trampoline.S code to be shared.
    v1: Add riscv rethook implementation.

 arch/riscv/Kconfig                            |  1 +
 arch/riscv/include/asm/kprobes.h              |  2 --
 arch/riscv/kernel/probes/Makefile             |  2 +-
 arch/riscv/kernel/probes/kprobes.c            | 13 ---------
 arch/riscv/kernel/probes/rethook.c            | 27 +++++++++++++++++++
 arch/riscv/kernel/probes/rethook.h            |  8 ++++++
 ...obes_trampoline.S => rethook_trampoline.S} |  6 ++---
 7 files changed, 40 insertions(+), 19 deletions(-)
 create mode 100644 arch/riscv/kernel/probes/rethook.c
 create mode 100644 arch/riscv/kernel/probes/rethook.h
 rename arch/riscv/kernel/probes/{kprobes_trampoline.S => rethook_trampoline.S} (94%)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 59d18881f..bfb66cdc5 100644
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
diff --git a/arch/riscv/include/asm/kprobes.h b/arch/riscv/include/asm/kprobes.h
index 217ef89f2..e7882ccb0 100644
--- a/arch/riscv/include/asm/kprobes.h
+++ b/arch/riscv/include/asm/kprobes.h
@@ -40,8 +40,6 @@ void arch_remove_kprobe(struct kprobe *p);
 int kprobe_fault_handler(struct pt_regs *regs, unsigned int trapnr);
 bool kprobe_breakpoint_handler(struct pt_regs *regs);
 bool kprobe_single_step_handler(struct pt_regs *regs);
-void __kretprobe_trampoline(void);
-void __kprobes *trampoline_probe_handler(struct pt_regs *regs);
 
 #endif /* CONFIG_KPROBES */
 #endif /* _ASM_RISCV_KPROBES_H */
diff --git a/arch/riscv/kernel/probes/Makefile b/arch/riscv/kernel/probes/Makefile
index 7f0840dcc..c40139e9c 100644
--- a/arch/riscv/kernel/probes/Makefile
+++ b/arch/riscv/kernel/probes/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_KPROBES)		+= kprobes.o decode-insn.o simulate-insn.o
-obj-$(CONFIG_KPROBES)		+= kprobes_trampoline.o
+obj-$(CONFIG_RETHOOK)		+= rethook.o rethook_trampoline.o
 obj-$(CONFIG_KPROBES_ON_FTRACE)	+= ftrace.o
 obj-$(CONFIG_UPROBES)		+= uprobes.o decode-insn.o simulate-insn.o
 CFLAGS_REMOVE_simulate-insn.o = $(CC_FLAGS_FTRACE)
diff --git a/arch/riscv/kernel/probes/kprobes.c b/arch/riscv/kernel/probes/kprobes.c
index e6e950b7c..f21592d20 100644
--- a/arch/riscv/kernel/probes/kprobes.c
+++ b/arch/riscv/kernel/probes/kprobes.c
@@ -345,19 +345,6 @@ int __init arch_populate_kprobe_blacklist(void)
 	return ret;
 }
 
-void __kprobes __used *trampoline_probe_handler(struct pt_regs *regs)
-{
-	return (void *)kretprobe_trampoline_handler(regs, NULL);
-}
-
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
diff --git a/arch/riscv/kernel/probes/rethook.c b/arch/riscv/kernel/probes/rethook.c
new file mode 100644
index 000000000..5c27c1f50
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
+
+NOKPROBE_SYMBOL(arch_rethook_trampoline_callback);
+
+void arch_rethook_prepare(struct rethook_node *rhn, struct pt_regs *regs, bool mcount)
+{
+	rhn->ret_addr = regs->ra;
+	rhn->frame = regs->s0;
+
+	/* replace return addr with trampoline */
+	regs->ra = (unsigned long)arch_rethook_trampoline;
+}
+
+NOKPROBE_SYMBOL(arch_rethook_prepare);
diff --git a/arch/riscv/kernel/probes/rethook.h b/arch/riscv/kernel/probes/rethook.h
new file mode 100644
index 000000000..4758f7e3c
--- /dev/null
+++ b/arch/riscv/kernel/probes/rethook.h
@@ -0,0 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef __RISCV_RETHOOK_H
+#define __RISCV_RETHOOK_H
+
+unsigned long arch_rethook_trampoline_callback(struct pt_regs *regs);
+void arch_rethook_prepare(struct rethook_node *rhn, struct pt_regs *regs, bool mcount);
+
+#endif
diff --git a/arch/riscv/kernel/probes/kprobes_trampoline.S b/arch/riscv/kernel/probes/rethook_trampoline.S
similarity index 94%
rename from arch/riscv/kernel/probes/kprobes_trampoline.S
rename to arch/riscv/kernel/probes/rethook_trampoline.S
index 7bdb09ded..21bac92a1 100644
--- a/arch/riscv/kernel/probes/kprobes_trampoline.S
+++ b/arch/riscv/kernel/probes/rethook_trampoline.S
@@ -75,13 +75,13 @@
 	REG_L x31, PT_T6(sp)
 	.endm
 
-ENTRY(__kretprobe_trampoline)
+ENTRY(arch_rethook_trampoline)
 	addi sp, sp, -(PT_SIZE_ON_STACK)
 	save_all_base_regs
 
 	move a0, sp /* pt_regs */
 
-	call trampoline_probe_handler
+	call arch_rethook_trampoline_callback
 
 	/* use the result as the return-address */
 	move ra, a0
@@ -90,4 +90,4 @@ ENTRY(__kretprobe_trampoline)
 	addi sp, sp, PT_SIZE_ON_STACK
 
 	ret
-ENDPROC(__kretprobe_trampoline)
+ENDPROC(arch_rethook_trampoline)
-- 
2.25.1

