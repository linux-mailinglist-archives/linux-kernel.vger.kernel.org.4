Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FF0974DD6B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 20:36:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232921AbjGJSgF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 14:36:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233188AbjGJSf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 14:35:58 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5600319A
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 11:35:56 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-c704df12425so3919443276.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 11:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689014155; x=1691606155;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eswTZL14/0lbniOzURaNQN7FEq6zurstCyikDF3vkhM=;
        b=mHXw4bXuQ7mteNju7x5RettqxmsL3nzNMvjatyU7cakrchbgnqgeh/uJDWKgLamt4x
         C4Xzhq4sjaYfzMLKVoynFKRvTwC+TjyVeUSMj6dF8hY3fuLx0WbL3+OOle9Tfo44WV62
         uC16FFSOSmucbJUO5rm3e6k7swahcwOmIwsHGY/x2v88h6NoXbSMuDbDMx0AkoIQpJaA
         lpZ22oonYN//0xTzIYB9VViMUKAUoRlSe7xhrk7BJ+4+bA3tRjw+edYdsytGn7S6ZQTj
         ng9khanqFWbetv8vwXovZTsSSQ9QUGK4ZJn5Npl1DKQciIy5/MskFNwXJgk1TFpB/wIv
         //IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689014155; x=1691606155;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eswTZL14/0lbniOzURaNQN7FEq6zurstCyikDF3vkhM=;
        b=HlDk4MtuAvLYb24fftLzOrDB5WEaoTsNIvnalPtsotgB2JkEKOBwGyyDxGz9bz1kG3
         zsKm3ZJFOLtgGJw4TZ9URBri8a+DIJr4OBdRorpMWpOR2XIYzf6jD7euvrc3WcfyRKzC
         Ep8UAp99t8RJhZ6yWVUWSSuf5aiqFUq7i4LKJsWaRlgZPznWSKwWmU+ZUsGn5KT+3zpC
         YCSawiXVUJLchQ/K7CLrqjxm5ajXlyGUqYtpxuuZBD5nQgKce4m89rjMeJ3fThN0qMB7
         w8Oc2p56Yy+63yo0sWhkotVZDBkfQz0vSw0WvG/WqamtM9CL2B+T0roAl4C58d+fWIy4
         vniA==
X-Gm-Message-State: ABy/qLY+wKh/KWc3erh2sy5lI5yU9KdEoRbmQSO99HdAMLJYLzrtdRyW
        QliiNCHxzA5Jgobf6bm0YCSqBu+AY3VcaLQYToY=
X-Google-Smtp-Source: APBJJlFQIZF+igmluOU2bMS5mr8gBJbp/xeb3V0KPaxzgO0oO8YmIRMtUSVCKW3jEDd2PO1KFSRPD2K5B4tN3umd5nw=
X-Received: from samitolvanen.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:4f92])
 (user=samitolvanen job=sendgmr) by 2002:a5b:54b:0:b0:c4e:27df:1a0f with SMTP
 id r11-20020a5b054b000000b00c4e27df1a0fmr99818ybp.13.1689014155420; Mon, 10
 Jul 2023 11:35:55 -0700 (PDT)
Date:   Mon, 10 Jul 2023 18:35:49 +0000
In-Reply-To: <20230710183544.999540-8-samitolvanen@google.com>
Mime-Version: 1.0
References: <20230710183544.999540-8-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=9602; i=samitolvanen@google.com;
 h=from:subject; bh=IA2WgXxwoWMBmayegrcrafXII/0/7DYZosX7v/GLBck=;
 b=owEB7QES/pANAwAKAUy19oSLvFbuAcsmYgBkrE+AzDEYUQi8BUsweEAdZIzultO1gPrFhWnsI
 jtkRlq4AveJAbMEAAEKAB0WIQQ1zPtjsoPW0663g5RMtfaEi7xW7gUCZKxPgAAKCRBMtfaEi7xW
 7ta1C/9wVoJcIYEMVHSgyqgnPHp4livqoTH2BLIv0xCc+oPtCaZ0eaH7XVR4T6q3lQycYnczBk4
 1mR2GTxEkGzihjmY9K2GmbjFNVcg7LOfnEnxsmijLPOvDqY0gszNdNjdmhi8WxHWUwJFM9haa8l
 Yi1XnlYhUxJv3gfg4FxvLzxcg79nus3gQFVJ+IUm4elFPQi6fcoESs67OuWdDxfeQaQ1+x1ayz6
 4HH80CFSL07N5Ey9CbNAqHpXEOOfIhZjRpe0J3rRRmJfKysc8TPeP7Dea5/7dlxcw6Wi7vXrAHb
 AURq+fs9/5rZ7vdTBg8ZEnI+gaoQoBp9jiCSN32evpWtkzj0bySSVSiREaDLYbTIVhDBTEsn/F4
 AFyJRq1R0M+IGVwmydqsXPbL3KEyy+31A1uqXk+l2rWNVdEYCzH3/7gDzHVteYnzu8p3/JJPHVG xUPUsbc8EqzDDllkEN4v42pH4ZCayK8K2GXX/Qc8JCSPI7VitZX0JC9akH9JxgGau1lws=
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230710183544.999540-12-samitolvanen@google.com>
Subject: [PATCH v2 4/6] riscv: Add CFI error handling
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
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With CONFIG_CFI_CLANG, the compiler injects a type preamble immediately
before each function and a check to validate the target function type
before indirect calls:

  ; type preamble
    .word <id>
  function:
    ...
  ; indirect call check
    lw      t1, -4(a0)
    lui     t2, <hi20>
    addiw   t2, t2, <lo12>
    beq     t1, t2, .Ltmp0
    ebreak
  .Ltmp0:
    jarl    a0

Implement error handling code for the ebreak traps emitted for the
checks. This produces the following oops on a CFI failure (generated
using lkdtm):

[   21.177245] CFI failure at lkdtm_indirect_call+0x22/0x32 [lkdtm]
(target: lkdtm_increment_int+0x0/0x18 [lkdtm]; expected type: 0x3ad55aca)
[   21.178483] Kernel BUG [#1]
[   21.178671] Modules linked in: lkdtm
[   21.179037] CPU: 1 PID: 104 Comm: sh Not tainted
6.3.0-rc6-00037-g37d5ec6297ab #1
[   21.179511] Hardware name: riscv-virtio,qemu (DT)
[   21.179818] epc : lkdtm_indirect_call+0x22/0x32 [lkdtm]
[   21.180106]  ra : lkdtm_CFI_FORWARD_PROTO+0x48/0x7c [lkdtm]
[   21.180426] epc : ffffffff01387092 ra : ffffffff01386f14 sp : ff20000000=
453cf0
[   21.180792]  gp : ffffffff81308c38 tp : ff6000000243f080 t0 : ff20000000=
453b78
[   21.181157]  t1 : 000000003ad55aca t2 : 000000007e0c52a5 s0 : ff20000000=
453d00
[   21.181506]  s1 : 0000000000000001 a0 : ffffffff0138d170 a1 : ffffffff01=
3870bc
[   21.181819]  a2 : b5fea48dd89aa700 a3 : 0000000000000001 a4 : 0000000000=
000fff
[   21.182169]  a5 : 0000000000000004 a6 : 00000000000000b7 a7 : 0000000000=
000000
[   21.182591]  s2 : ff20000000453e78 s3 : ffffffffffffffea s4 : 0000000000=
000012
[   21.183001]  s5 : ff600000023c7000 s6 : 0000000000000006 s7 : ffffffff01=
3882a0
[   21.183653]  s8 : 0000000000000008 s9 : 0000000000000002 s10: ffffffff01=
38d878
[   21.184245]  s11: ffffffff0138d878 t3 : 0000000000000003 t4 : 0000000000=
000000
[   21.184591]  t5 : ffffffff8133df08 t6 : ffffffff8133df07
[   21.184858] status: 0000000000000120 badaddr: 0000000000000000
cause: 0000000000000003
[   21.185415] [<ffffffff01387092>] lkdtm_indirect_call+0x22/0x32 [lkdtm]
[   21.185772] [<ffffffff01386f14>] lkdtm_CFI_FORWARD_PROTO+0x48/0x7c [lkdt=
m]
[   21.186093] [<ffffffff01383552>] lkdtm_do_action+0x22/0x34 [lkdtm]
[   21.186445] [<ffffffff0138350c>] direct_entry+0x128/0x13a [lkdtm]
[   21.186817] [<ffffffff8033ed8c>] full_proxy_write+0x58/0xb2
[   21.187352] [<ffffffff801d4fe8>] vfs_write+0x14c/0x33a
[   21.187644] [<ffffffff801d5328>] ksys_write+0x64/0xd4
[   21.187832] [<ffffffff801d53a6>] sys_write+0xe/0x1a
[   21.188171] [<ffffffff80003996>] ret_from_syscall+0x0/0x2
[   21.188595] Code: 0513 0f65 a303 ffc5 53b7 7e0c 839b 2a53 0363 0073 (900=
2) 9582
[   21.189178] ---[ end trace 0000000000000000 ]---
[   21.189590] Kernel panic - not syncing: Fatal exception

Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com> # ISA bits
Tested-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 arch/riscv/Kconfig            |  1 +
 arch/riscv/include/asm/cfi.h  | 22 ++++++++++
 arch/riscv/include/asm/insn.h | 10 +++++
 arch/riscv/kernel/Makefile    |  2 +
 arch/riscv/kernel/cfi.c       | 77 +++++++++++++++++++++++++++++++++++
 arch/riscv/kernel/traps.c     |  4 +-
 6 files changed, 115 insertions(+), 1 deletion(-)
 create mode 100644 arch/riscv/include/asm/cfi.h
 create mode 100644 arch/riscv/kernel/cfi.c

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index a475ef1a0c1c..29fdba9d8514 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -49,6 +49,7 @@ config RISCV
 	select ARCH_SUPPORTS_PER_VMA_LOCK if MMU
 	select ARCH_USE_MEMTEST
 	select ARCH_USE_QUEUED_RWLOCKS
+	select ARCH_USES_CFI_TRAPS if CFI_CLANG
 	select ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT if MMU
 	select ARCH_WANT_FRAME_POINTERS
 	select ARCH_WANT_GENERAL_HUGETLB if !RISCV_ISA_SVNAPOT
diff --git a/arch/riscv/include/asm/cfi.h b/arch/riscv/include/asm/cfi.h
new file mode 100644
index 000000000000..56bf9d69d5e3
--- /dev/null
+++ b/arch/riscv/include/asm/cfi.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_RISCV_CFI_H
+#define _ASM_RISCV_CFI_H
+
+/*
+ * Clang Control Flow Integrity (CFI) support.
+ *
+ * Copyright (C) 2023 Google LLC
+ */
+
+#include <linux/cfi.h>
+
+#ifdef CONFIG_CFI_CLANG
+enum bug_trap_type handle_cfi_failure(struct pt_regs *regs);
+#else
+static inline enum bug_trap_type handle_cfi_failure(struct pt_regs *regs)
+{
+	return BUG_TRAP_TYPE_NONE;
+}
+#endif /* CONFIG_CFI_CLANG */
+
+#endif /* _ASM_RISCV_CFI_H */
diff --git a/arch/riscv/include/asm/insn.h b/arch/riscv/include/asm/insn.h
index 4e1505cef8aa..9c23f598434c 100644
--- a/arch/riscv/include/asm/insn.h
+++ b/arch/riscv/include/asm/insn.h
@@ -63,6 +63,7 @@
 #define RVG_RS1_OPOFF		15
 #define RVG_RS2_OPOFF		20
 #define RVG_RD_OPOFF		7
+#define RVG_RS1_MASK		GENMASK(4, 0)
 #define RVG_RD_MASK		GENMASK(4, 0)
=20
 /* The bit field of immediate value in RVC J instruction */
@@ -129,6 +130,7 @@
 #define RVC_C2_RS1_OPOFF	7
 #define RVC_C2_RS2_OPOFF	2
 #define RVC_C2_RD_OPOFF		7
+#define RVC_C2_RS1_MASK		GENMASK(4, 0)
=20
 /* parts of opcode for RVG*/
 #define RVG_OPCODE_FENCE	0x0f
@@ -278,6 +280,10 @@ static __always_inline bool riscv_insn_is_branch(u32 c=
ode)
 #define RV_X(X, s, mask)  (((X) >> (s)) & (mask))
 #define RVC_X(X, s, mask) RV_X(X, s, mask)
=20
+#define RV_EXTRACT_RS1_REG(x) \
+	({typeof(x) x_ =3D (x); \
+	(RV_X(x_, RVG_RS1_OPOFF, RVG_RS1_MASK)); })
+
 #define RV_EXTRACT_RD_REG(x) \
 	({typeof(x) x_ =3D (x); \
 	(RV_X(x_, RVG_RD_OPOFF, RVG_RD_MASK)); })
@@ -305,6 +311,10 @@ static __always_inline bool riscv_insn_is_branch(u32 c=
ode)
 	(RV_X(x_, RV_B_IMM_11_OPOFF, RV_B_IMM_11_MASK) << RV_B_IMM_11_OFF) | \
 	(RV_IMM_SIGN(x_) << RV_B_IMM_SIGN_OFF); })
=20
+#define RVC_EXTRACT_C2_RS1_REG(x) \
+	({typeof(x) x_ =3D (x); \
+	(RV_X(x_, RVC_C2_RS1_OPOFF, RVC_C2_RS1_MASK)); })
+
 #define RVC_EXTRACT_JTYPE_IMM(x) \
 	({typeof(x) x_ =3D (x); \
 	(RVC_X(x_, RVC_J_IMM_3_1_OPOFF, RVC_J_IMM_3_1_MASK) << RVC_J_IMM_3_1_OFF)=
 | \
diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
index 506cc4a9a45a..6ac56af42f4a 100644
--- a/arch/riscv/kernel/Makefile
+++ b/arch/riscv/kernel/Makefile
@@ -91,6 +91,8 @@ obj-$(CONFIG_CRASH_CORE)	+=3D crash_core.o
=20
 obj-$(CONFIG_JUMP_LABEL)	+=3D jump_label.o
=20
+obj-$(CONFIG_CFI_CLANG)		+=3D cfi.o
+
 obj-$(CONFIG_EFI)		+=3D efi.o
 obj-$(CONFIG_COMPAT)		+=3D compat_syscall_table.o
 obj-$(CONFIG_COMPAT)		+=3D compat_signal.o
diff --git a/arch/riscv/kernel/cfi.c b/arch/riscv/kernel/cfi.c
new file mode 100644
index 000000000000..820158d7a291
--- /dev/null
+++ b/arch/riscv/kernel/cfi.c
@@ -0,0 +1,77 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Clang Control Flow Integrity (CFI) support.
+ *
+ * Copyright (C) 2023 Google LLC
+ */
+#include <asm/cfi.h>
+#include <asm/insn.h>
+
+/*
+ * Returns the target address and the expected type when regs->epc points
+ * to a compiler-generated CFI trap.
+ */
+static bool decode_cfi_insn(struct pt_regs *regs, unsigned long *target,
+			    u32 *type)
+{
+	unsigned long *regs_ptr =3D (unsigned long *)regs;
+	int rs1_num;
+	u32 insn;
+
+	*target =3D *type =3D 0;
+
+	/*
+	 * The compiler generates the following instruction sequence
+	 * for indirect call checks:
+	 *
+	 * =C2=A0 lw      t1, -4(<reg>)
+	 *   lui     t2, <hi20>
+	 *   addiw   t2, t2, <lo12>
+	 *   beq     t1, t2, .Ltmp1
+	 *   ebreak  ; <- regs->epc
+	 *   .Ltmp1:
+	 *   jalr    <reg>
+	 *
+	 * We can read the expected type and the target address from the
+	 * registers passed to the beq/jalr instructions.
+	 */
+	if (get_kernel_nofault(insn, (void *)regs->epc - 4))
+		return false;
+	if (!riscv_insn_is_beq(insn))
+		return false;
+
+	*type =3D (u32)regs_ptr[RV_EXTRACT_RS1_REG(insn)];
+
+	if (get_kernel_nofault(insn, (void *)regs->epc) ||
+	    get_kernel_nofault(insn, (void *)regs->epc + GET_INSN_LENGTH(insn)))
+		return false;
+
+	if (riscv_insn_is_jalr(insn))
+		rs1_num =3D RV_EXTRACT_RS1_REG(insn);
+	else if (riscv_insn_is_c_jalr(insn))
+		rs1_num =3D RVC_EXTRACT_C2_RS1_REG(insn);
+	else
+		return false;
+
+	*target =3D regs_ptr[rs1_num];
+
+	return true;
+}
+
+/*
+ * Checks if the ebreak trap is because of a CFI failure, and handles the =
trap
+ * if needed. Returns a bug_trap_type value similarly to report_bug.
+ */
+enum bug_trap_type handle_cfi_failure(struct pt_regs *regs)
+{
+	unsigned long target;
+	u32 type;
+
+	if (!is_cfi_trap(regs->epc))
+		return BUG_TRAP_TYPE_NONE;
+
+	if (!decode_cfi_insn(regs, &target, &type))
+		return report_cfi_failure_noaddr(regs, regs->epc);
+
+	return report_cfi_failure(regs, regs->epc, &target, type);
+}
diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
index f910dfccbf5d..212dc20631fb 100644
--- a/arch/riscv/kernel/traps.c
+++ b/arch/riscv/kernel/traps.c
@@ -21,6 +21,7 @@
=20
 #include <asm/asm-prototypes.h>
 #include <asm/bug.h>
+#include <asm/cfi.h>
 #include <asm/csr.h>
 #include <asm/processor.h>
 #include <asm/ptrace.h>
@@ -271,7 +272,8 @@ void handle_break(struct pt_regs *regs)
 								=3D=3D NOTIFY_STOP)
 		return;
 #endif
-	else if (report_bug(regs->epc, regs) =3D=3D BUG_TRAP_TYPE_WARN)
+	else if (report_bug(regs->epc, regs) =3D=3D BUG_TRAP_TYPE_WARN ||
+		 handle_cfi_failure(regs) =3D=3D BUG_TRAP_TYPE_WARN)
 		regs->epc +=3D get_break_insn_length(regs->epc);
 	else
 		die(regs, "Kernel BUG");
--=20
2.41.0.255.g8b1d071c50-goog

