Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 582425E9C39
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 10:41:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234316AbiIZIlu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 04:41:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234475AbiIZIlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 04:41:44 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A83B357E1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 01:41:42 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id o99-20020a17090a0a6c00b002039c4fce53so11697965pjo.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 01:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=FYzdZmUmmMUqXz0qE+VCSL03kM7vgqb2W0v35eWjsyY=;
        b=W6lmNljPFemZSjHB5ju4/ZAQxb22Ii1tf9xc+LeOKfM78GZ4vXJ3Xt0arw+DAlXJYH
         Rhpg4tdhuoDytK/Qa71Jzr0q4pdZkUl0mdOA89EW0gsh993eZBPmwgbWu3MAQEROKqgO
         wb+9s5NhFarnq7o87+0O0q/SgVmJ7tKqdQ8B806s00PbYZ7OZtat0eWcszf4CAjy7l6T
         kfzeCRwyg++1xIxQNCvGQhzhPQ3Y6eGgakR09oGc/XJqSD0lQr2vR0eKIvQakFFX0Gg1
         3tJLdI45eAVo7MPray38nKbt96nKAZbA0zEWMIyi9Wj0JgNLc9zWDw+2WqMoTPCAIrB9
         l59g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=FYzdZmUmmMUqXz0qE+VCSL03kM7vgqb2W0v35eWjsyY=;
        b=muOzeJbhZDVA2sXO+H/dwoWZUsusZXRyTs1FTt/3BfmKFjGeyKML+eyJb6CEYLQ8UD
         uwmgAPcH8C78sWlG968TwVqTgenpT5x9Z6/+RmYArBkKfTRPJhXVp6saIA6ggRfAGx5B
         0sRc1W0l84TlcgAc3xwhVSofPBbEba91pAKi/EYAyVWBpbUPQcParyCyuCgS7wLNOFNS
         0rfKfJiCNJp+/IUXP2477+3dyq5Q2tbWQPzkktrVFsQMP7vjeu7HWErE7htJxdnWMfJ3
         1tBN1uJ5SVqi63KWDjEFw8uFIFceh874jSzFu+KftDsSQ3zeIiweZVaCv+BpLhLMt4Xs
         DuSQ==
X-Gm-Message-State: ACrzQf2AfJ53GVmoakyw7FCVBp3TTnX5wgG6vjEXezwYqY2CESE70Rmg
        9Y58xmDbdBrme3OhwqbLang=
X-Google-Smtp-Source: AMsMyM5lqqjLNQNGCmO/6r2mRk5p6L8uXj56iFcijF7GCfK26oh/SQJN25yD/cu1oyzyG7D9tgR4mA==
X-Received: by 2002:a17:90b:3a84:b0:203:6911:52c with SMTP id om4-20020a17090b3a8400b002036911052cmr36350771pjb.73.1664181701936;
        Mon, 26 Sep 2022 01:41:41 -0700 (PDT)
Received: from localhost.localdomain (l3b2w1.cn. [159.138.1.25])
        by smtp.gmail.com with ESMTPSA id p14-20020a17090a284e00b001fd9c63e56bsm5925550pjf.32.2022.09.26.01.41.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 01:41:41 -0700 (PDT)
From:   Binglei Wang <l3b2w1@gmail.com>
X-Google-Original-From: Binglei Wang
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, naveen.n.rao@linux.ibm.com,
        anil.s.keshavamurthy@intel.com, davem@davemloft.net,
        mhiramat@kernel.org
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Binglei Wang <l3b2w1@gmail.com>
Subject: [PATCH v6] rethook: add riscv rethook implementation.
Date:   Mon, 26 Sep 2022 16:41:36 +0800
Message-Id: <20220926084136.629638-1-l3b2w1@gmail.com>
X-Mailer: git-send-email 2.27.0
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

Implement the kretprobes on riscv arch by using rethook mechanism
which abstracts general kretprobe info into a struct rethook_node
to be embedded in the struct kretprobe_instance.

1. remove arch dependent kretprobe implementation
2. replace __kretprobe_trampoline with arch_hook_trampoline

Signed-off-by: Binglei Wang <l3b2w1@gmail.com>
---
 arch/riscv/Kconfig                            |  1 +
 arch/riscv/kernel/probes/Makefile             |  2 +-
 arch/riscv/kernel/probes/kprobes.c            | 13 ----------
 arch/riscv/kernel/probes/rethook.c            | 26 +++++++++++++++++++
 arch/riscv/kernel/probes/rethook.h            |  8 ++++++
 ...obes_trampoline.S => rethook_trampoline.S} |  0
 6 files changed, 36 insertions(+), 14 deletions(-)
 create mode 100644 arch/riscv/kernel/probes/rethook.c
 create mode 100644 arch/riscv/kernel/probes/rethook.h
 rename arch/riscv/kernel/probes/{kprobes_trampoline.S => rethook_trampoline.S} (100%)

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
index 7f0840dcc..9a96a7038 100644
--- a/arch/riscv/kernel/probes/Makefile
+++ b/arch/riscv/kernel/probes/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_KPROBES)		+= kprobes.o decode-insn.o simulate-insn.o
-obj-$(CONFIG_KPROBES)		+= kprobes_trampoline.o
 obj-$(CONFIG_KPROBES_ON_FTRACE)	+= ftrace.o
 obj-$(CONFIG_UPROBES)		+= uprobes.o decode-insn.o simulate-insn.o
+obj-$(CONFIG_KPROBES)		+= rethook.o rethook_trampoline.o
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
index 000000000..edfeaa256
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
diff --git a/arch/riscv/kernel/probes/kprobes_trampoline.S b/arch/riscv/kernel/probes/rethook_trampoline.S
similarity index 100%
rename from arch/riscv/kernel/probes/kprobes_trampoline.S
rename to arch/riscv/kernel/probes/rethook_trampoline.S
-- 
2.27.0

