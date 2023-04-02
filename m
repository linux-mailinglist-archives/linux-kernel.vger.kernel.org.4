Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEDC56D35AB
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Apr 2023 07:51:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbjDBFvg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 01:51:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230217AbjDBFvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 01:51:35 -0400
Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A861210A89
        for <linux-kernel@vger.kernel.org>; Sat,  1 Apr 2023 22:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1680414684;
        bh=+2VkKad1zNOp7RZJOwjGql3kO2qtYFT1yF6Q/Ss6mQE=;
        h=From:To:Cc:Subject:Date;
        b=VFy39jpsX3I38WWA919YSCNN3KzlUr8PfiL0WtokrdP/03yrCTZ2m9zdcSO8p0pJ6
         uQW7mFTGrFrS+S9vIe0z4TYnWf4b3UQ5VT2urRxtEpapaNJFpFY/+PYggw3p+KRWFp
         x7pcyyu5/jy4mMtNjkeY1sfQqSuYnmB+t4dqfhmo=
Received: from localhost.localdomain ([163.125.248.140])
        by newxmesmtplogicsvrszc1-0.qq.com (NewEsmtp) with SMTP
        id C5D8EAE7; Sun, 02 Apr 2023 13:49:29 +0800
X-QQ-mid: xmsmtpt1680414569tl06qa9fa
Message-ID: <tencent_A8A256967B654625AEE1DB222514B0613B07@qq.com>
X-QQ-XMAILINFO: MA8XoCze+OMloc3LJ+j56qNc+lsKyf/4UpnGIfTEPgjOND6jaukEetN7ZHqPD4
         KxSSHKu+IhGf+zZvsfePwUmrnT31NNE50WZ0Xz6nGnMnvt8C63rcFmFQ7ijNmzQnTDNvp82zvL01
         lz8qVtT55u0hX0Tu0xDUCKA5wWrQ5aw1LKMHQGz9llI9D8yat+lKYetb24CgnL6/bjIYr9Ys6GfI
         osdHpXqzAdn0xV8LD2nOvAZ+dRG16FBFjYveunnETepKrreptvWScC9OmOOXjDLPVfNzK+MlydSj
         mSQ1g7LILlNediNfSJcx+RgStqVEHoUahC5LjbyEy4HsG5xJpZJ2ujIFQdUskiERzPP5zPAbpq8E
         1dF+eu4lhGvW8vxocm6ourFISdL5M5mgv+RbJ2VEqi4DkTnAcwOcDbXYQOb2hFjt5c8qhuDxjaz0
         ZO8nBNA26Fa3ZFFw8APMsOjd4Q4HxpezuDejKTexWo3rxK7w69WN2YmpaJNnishqiw4Qz/TaB5M0
         COSy6H3knZtc0d26OO4DCqrMdCSjbFwcB/GJYN5NfqRLDHML+Rb7iaYAayv8lN4vwZaDM5Z1NhPJ
         C16N7zg7qAzaWRzdaFwdyEPqxGgTWtngv/TSkMi4N9mjLYYrl/zjPiCherr7bPH4gACR7Xwl+Qrt
         +hncktAlk/6H0OF50h8Sq46pZAlQwCOru/4WFAjb6tbMoKCclqX/VHe8/TU5HVG+M/bYqr5gEibq
         wBdtKeCn2BE56DLdL0zxUQs5My9byicDAstrpBDP/d0SF2myVSqpzfgd9Ozn1HRYHuRv5PGWcwFO
         0TuTPbxdlVUyZUvHEEivQbIzB6b0WEonDU+IDbmb/v2FPITBdylj4urbx4UY5uSX5v1JeWbZyP1y
         zBdDeRgUeq8w47yRYK/k8I5IqET05hKBELFLzUZWa8S/ViLF2SFTnilE3f8GerVqt7rBptY/vsFb
         5it4cro2MBaZljxDxXK7F3cPCRiOmSfS3URZGi2ZeMdUrVXO8/4H7gtn9KBeDYDhWMsTCYYhvmo1
         0EfagEoWm6eiG7uFZKsqcBVe349PeuldOQhz/cRQ==
From:   forrestniu@foxmail.com
To:     peterz@infradead.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     falcon@tinylab.org, forrestniu@foxmail.com, suagrfillet@gmail.com,
        bmeng@tinylab.org, wangliming@walimis.org, jpoimboe@kernel.org,
        christophe.leroy@csgroup.eu
Subject: [RFC PATCH] riscv: Add static call implementation
Date:   Sun,  2 Apr 2023 13:49:27 +0800
X-OQ-MSGID: <20230402054927.138259-1-forrestniu@foxmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=3.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HELO_DYNAMIC_IPADDR,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ForrestNiu <forrestniu@foxmail.com>

Add the riscv static call implementation. For each key, a permanent 
trampoline is created which is the destination for all static calls 
for the given key.  

The trampoline has a direct jump which gets patched by static_call_update() 
when the destination function changes.

The "inline" version is under development.

Signed-off-by: Falcon <falcon@tinylab.org>
Signed-off-by: ForrestNiu <forrestniu@foxmail.com>
---
 arch/riscv/Kconfig                   |   1 +
 arch/riscv/include/asm/static_call.h |  30 +++++++
 arch/riscv/kernel/Makefile           |   1 +
 arch/riscv/kernel/static_call.c      | 117 +++++++++++++++++++++++++++
 arch/riscv/kernel/vmlinux.lds.S      |   1 +
 5 files changed, 150 insertions(+)
 create mode 100644 arch/riscv/include/asm/static_call.h
 create mode 100644 arch/riscv/kernel/static_call.c

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 5b182d1c196c..06f541c6d824 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -115,6 +115,7 @@ config RISCV
 	select HAVE_REGS_AND_STACK_ACCESS_API
 	select HAVE_RSEQ
 	select HAVE_STACKPROTECTOR
+	select HAVE_STATIC_CALL
 	select HAVE_SYSCALL_TRACEPOINTS
 	select IRQ_DOMAIN
 	select IRQ_FORCED_THREADING
diff --git a/arch/riscv/include/asm/static_call.h b/arch/riscv/include/asm/static_call.h
new file mode 100644
index 000000000000..617c00adf45c
--- /dev/null
+++ b/arch/riscv/include/asm/static_call.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_STATIC_CALL_H
+#define _ASM_STATIC_CALL_H
+#include <linux/ftrace.h>
+
+#define __ARCH_DEFINE_STATIC_CALL_TRAMP(name,insns)			\
+	asm(".pushsection .static_call.text, \"ax\"		\n"	\
+	    ".globl " STATIC_CALL_TRAMP_STR(name) "		\n"	\
+	    STATIC_CALL_TRAMP_STR(name) ":			\n"	\
+		insns "						\n"	\
+	    ".type " STATIC_CALL_TRAMP_STR(name) ", @function	\n"	\
+	    ".size " STATIC_CALL_TRAMP_STR(name) ", . - " STATIC_CALL_TRAMP_STR(name) " \n" \
+	    ".popsection								\n")
+
+#define ARCH_DEFINE_STATIC_CALL_TRAMP(name, func)			\
+	__ARCH_DEFINE_STATIC_CALL_TRAMP(name,"la t0,"#func";jalr t1,0(t0);")
+
+#define ARCH_DEFINE_STATIC_CALL_NULL_TRAMP(name)			\
+	__ARCH_DEFINE_STATIC_CALL_TRAMP(name,"ret;")
+
+#define ARCH_DEFINE_STATIC_CALL_RET0_TRAMP(name)			\
+	ARCH_DEFINE_STATIC_CALL_TRAMP(name,__static_call_return0;)
+
+#define ARCH_ADD_TRAMP_KEY(name)					\
+	asm(".pushsection .static_call_tramp_key, \"a\"		\n"	\
+	    ".long " STATIC_CALL_TRAMP_STR(name) " - .		\n"	\
+	    ".long " STATIC_CALL_KEY_STR(name) " - .		\n"	\
+	    ".popsection					\n")
+
+#endif /* _ASM_STATIC_CALL_H */
diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
index 4cf303a779ab..3d86edfedb7e 100644
--- a/arch/riscv/kernel/Makefile
+++ b/arch/riscv/kernel/Makefile
@@ -44,6 +44,7 @@ obj-y	+= setup.o
 obj-y	+= signal.o
 obj-y	+= syscall_table.o
 obj-y	+= sys_riscv.o
+obj-y	+= static_call.o
 obj-y	+= time.o
 obj-y	+= traps.o
 obj-y	+= riscv_ksyms.o
diff --git a/arch/riscv/kernel/static_call.c b/arch/riscv/kernel/static_call.c
new file mode 100644
index 000000000000..58bf86f0ac00
--- /dev/null
+++ b/arch/riscv/kernel/static_call.c
@@ -0,0 +1,117 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/static_call.h>
+#include <linux/memory.h>
+#include <linux/bug.h>
+#include <asm/patch.h>
+#include <linux/ftrace.h>
+
+#define RISCV_INSN_JALR 0x00000067U
+#define RISCV_INSN_ADDI 0x00000013U
+#define RISCV_INSN_AUIPC 0x00000017U
+#define AUIPC_T0_MASK	0x00000280U
+#define JALR_T1_T0_MASK	0x00028300U
+
+enum insn_type {
+	CALL = 0, /* site call */
+	NOP = 1,  /* site cond-call */
+	JMP = 2,  /* tramp / site tail-call */
+	RET = 3,  /* tramp / site cond-tail-call */
+};
+
+static void __ref __static_call_transform(void *insn, enum insn_type type, void *func,bool modinit)
+{
+	u32 call[2]={0};
+	u32 jump_code = (*(u32*)(insn+sizeof(call[0])) & GENMASK(6,0));
+
+	switch (type) {
+	case CALL:
+		break;
+	case NOP:
+		break;
+	case JMP:
+		if(jump_code == RISCV_INSN_ADDI )
+		{
+			/*
+			 * When the trampoland is initialized, three instructions are as follows:
+			 * "auipc t0,imm20"
+			 * "addi t0,imm12"
+			 * "jalr t1,0(t0)"
+			 * First, use the "jalr t1,imm12(t0)" replace the "addi t0,imm12"
+			 * To ensure that two instructions are caused in the case of multiple nuclear
+			 * conditions to lead to unknown errors.
+			*/
+			make_call_t0(insn, func, call);
+			patch_text_nosync(insn+sizeof(call[0]), &call[1], sizeof(call[1]));
+
+			/*
+			 * After the last dynamic adjustment, the instructions are as follows:
+			 * "auipc t0,imm20"
+			 * "jalr t1,imm12(t0)"
+			 * "jalr t1,0(t0)"
+			 * The first two instructions have guaranteed that the third instruction will
+			 * not be ordered, so the third instruction can be updated.After the update is completed,
+			 * the second instruction can update to make the third jump instruction take effect.
+			 * Use the "auipc t0,imm20" replace "jalr t0,imm12",the third jump instruction will take effect
+			*/
+			make_call_t0(insn+sizeof(call[0]), func, call);
+
+			patch_text_nosync(insn+sizeof(call), &call[1], sizeof(call[1]));
+			patch_text_nosync(insn+sizeof(call[0]), &call[0], sizeof(call[0]));
+		}
+		else if( jump_code == RISCV_INSN_AUIPC )
+		{
+			/*
+			 * After the last dynamic adjustment, the instructions are as follows:
+			 * "auipc t0,imm20"
+			 * "auipc t0,imm20"
+			 * "jalr t1,imm12(t0)"
+			 * The first auipc instruction will not take effect and can be updated easily.
+			 * After updating the first auipc instruction, update the second auipc instruction
+			 * to the jalr instruction.
+			 */
+			make_call_t0(insn, func, call);
+			patch_text_nosync(insn, &call[0], sizeof(call[0]));
+			patch_text_nosync(insn+sizeof(call[0]), &call[1], sizeof(call[1]));
+		}
+		else if( jump_code == RISCV_INSN_JALR )
+		{
+			/*
+			 * After the last dynamic adjustment, the instructions are as follows:
+			 * "auipc t0,imm20"
+			 * "jalr t1,imm12(t0)"
+			 * "jalr t1,imm12(t0)"
+			 * This looks like "jump_code == RISCV_INSN_ADDI".
+			 */
+			make_call_t0(insn+sizeof(call[0]), func, call);
+
+			patch_text_nosync(insn+sizeof(call), &call[1], sizeof(call[1]));
+			patch_text_nosync(insn+sizeof(call[0]), &call[0], sizeof(call[0]));
+		}
+		break;
+	case RET://If func is NULL, the upgrade is not performed
+		break;
+	}
+}
+
+static inline enum insn_type __sc_insn(bool null, bool tail)
+{
+	/*
+	 * Encode the following table without branches:
+	 *
+	 *	tail	null	insn
+	 *	-----+-------+------
+	 *	  0  |   0   |  CALL
+	 *	  0  |   1   |  NOP
+	 *	  1  |   0   |  JMP
+	 *	  1  |   1   |  RET
+	 */
+	return 2*tail + null;
+}
+
+void arch_static_call_transform(void *site, void *tramp, void *func, bool tail)
+{
+	mutex_lock(&text_mutex);
+	__static_call_transform(tramp, __sc_insn(!func, true), func,false);
+	mutex_unlock(&text_mutex);
+}
+EXPORT_SYMBOL_GPL(arch_static_call_transform);
diff --git a/arch/riscv/kernel/vmlinux.lds.S b/arch/riscv/kernel/vmlinux.lds.S
index 53a8ad65b255..1b06ac1a511d 100644
--- a/arch/riscv/kernel/vmlinux.lds.S
+++ b/arch/riscv/kernel/vmlinux.lds.S
@@ -48,6 +48,7 @@ SECTIONS
 		ENTRY_TEXT
 		IRQENTRY_TEXT
 		SOFTIRQENTRY_TEXT
+		STATIC_CALL_TEXT
 		_etext = .;
 	}
 
-- 
2.39.2

