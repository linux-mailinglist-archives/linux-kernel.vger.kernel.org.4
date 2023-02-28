Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 377CF6A5416
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 09:05:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbjB1IEk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 03:04:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230258AbjB1IEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 03:04:13 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5B00D21948
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 00:03:49 -0800 (PST)
Received: from loongson.cn (unknown [111.9.175.10])
        by gateway (Coremail) with SMTP id _____8DxE4Ritf1jGWYGAA--.6445S3;
        Tue, 28 Feb 2023 16:03:46 +0800 (CST)
Received: from localhost.localdomain (unknown [111.9.175.10])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxB707tf1jb3tAAA--.49681S8;
        Tue, 28 Feb 2023 16:03:42 +0800 (CST)
From:   Jinyang He <hejinyang@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>
Cc:     Xi Ruoyao <xry111@xry111.site>,
        Youling Tang <tangyouling@loongson.cn>,
        loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/6] LoongArch: Clean up la_abs macro
Date:   Tue, 28 Feb 2023 16:02:57 +0800
Message-Id: <20230228080257.28807-7-hejinyang@loongson.cn>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230228080257.28807-1-hejinyang@loongson.cn>
References: <20230228080257.28807-1-hejinyang@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxB707tf1jb3tAAA--.49681S8
X-CM-SenderInfo: pkhmx0p1dqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBjvJXoWxKryDGFWUXr1xtw13tF4rGrg_yoW3JF1kpr
        nxZrn7Ja1rWrn3Za4Dta4DurZ8AwnFg342ganIkFyru3W7ZF18XrykA3s7ZF97Kay8XF4I
        gF1ftws2qF4UJwUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        b7kYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr1j6rxdM2AI
        xVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I8CrVACY4xI64
        kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5McIj6I8E87Iv67AKxVW8JVWxJwAm
        72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64vIr41l4I8I3I
        0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWU
        GVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI
        0_Xr0_Ar1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0
        rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r
        4UJbIYCTnIWIevJa73UjIFyTuYvjxUcCD7UUUUU
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,RCVD_IN_SBL_CSS,
        SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now we can replace la_abs with la.pcrel. Clean up the la_abs macro.

Signed-off-by: Jinyang He <hejinyang@loongson.cn>
---
 arch/loongarch/include/asm/asmmacro.h   | 17 ---------------
 arch/loongarch/include/asm/setup.h      |  7 -------
 arch/loongarch/include/asm/stackframe.h |  2 +-
 arch/loongarch/kernel/entry.S           |  5 ++---
 arch/loongarch/kernel/genex.S           |  8 +++----
 arch/loongarch/kernel/relocate.c        | 28 -------------------------
 arch/loongarch/kernel/vmlinux.lds.S     |  9 --------
 arch/loongarch/mm/tlbex.S               | 18 +++++++---------
 8 files changed, 13 insertions(+), 81 deletions(-)

diff --git a/arch/loongarch/include/asm/asmmacro.h b/arch/loongarch/include/asm/asmmacro.h
index 79e1d53fea89..328bb956f241 100644
--- a/arch/loongarch/include/asm/asmmacro.h
+++ b/arch/loongarch/include/asm/asmmacro.h
@@ -667,21 +667,4 @@
 	nor	\dst, \src, zero
 .endm
 
-.macro la_abs reg, sym
-#ifndef CONFIG_RELOCATABLE
-	la.abs	\reg, \sym
-#else
-	766:
-	lu12i.w	\reg, 0
-	ori	\reg, \reg, 0
-	lu32i.d	\reg, 0
-	lu52i.d	\reg, \reg, 0
-	.pushsection ".la_abs", "aw", %progbits
-	768:
-	.dword	768b-766b
-	.dword	\sym
-	.popsection
-#endif
-.endm
-
 #endif /* _ASM_ASMMACRO_H */
diff --git a/arch/loongarch/include/asm/setup.h b/arch/loongarch/include/asm/setup.h
index 4074225339ec..84d131f29e0c 100644
--- a/arch/loongarch/include/asm/setup.h
+++ b/arch/loongarch/include/asm/setup.h
@@ -16,13 +16,6 @@ extern void per_cpu_trap_init(int cpu);
 
 #ifdef CONFIG_RELOCATABLE
 
-struct rela_la_abs {
-	long offset;
-	long symvalue;
-};
-
-extern long __la_abs_begin;
-extern long __la_abs_end;
 extern long __rela_dyn_begin;
 extern long __rela_dyn_end;
 
diff --git a/arch/loongarch/include/asm/stackframe.h b/arch/loongarch/include/asm/stackframe.h
index bb5e0e2bd3a9..fff4a0ce7750 100644
--- a/arch/loongarch/include/asm/stackframe.h
+++ b/arch/loongarch/include/asm/stackframe.h
@@ -86,7 +86,7 @@
  * new value in sp.
  */
 	.macro	get_saved_sp docfi=0
-	la_abs	  t1, kernelsp
+	la.pcrel  t1, kernelsp
 #ifdef CONFIG_SMP
 	csrrd	  t0, PERCPU_BASE_KS
 	LONG_ADD  t1, t1, t0
diff --git a/arch/loongarch/kernel/entry.S b/arch/loongarch/kernel/entry.S
index ca4651f91e73..87b620a0aa13 100644
--- a/arch/loongarch/kernel/entry.S
+++ b/arch/loongarch/kernel/entry.S
@@ -22,7 +22,7 @@
 	.align	5
 SYM_FUNC_START(handle_sys)
 	csrrd		t0, PERCPU_BASE_KS
-	la_abs		t1, kernelsp
+	la.pcrel	t1, kernelsp
 	add.d		t1, t1, t0
 	move		t2, sp
 	ld.d		sp, t1, 0
@@ -65,8 +65,7 @@ SYM_FUNC_START(handle_sys)
 	and		tp, tp, sp
 
 	move	a0, sp
-	la_abs	ra, do_syscall
-	jirl	ra, ra, 0
+	bl	do_syscall
 
 	RESTORE_ALL_AND_RET
 SYM_FUNC_END(handle_sys)
diff --git a/arch/loongarch/kernel/genex.S b/arch/loongarch/kernel/genex.S
index 8705a7661ce9..061727164ec2 100644
--- a/arch/loongarch/kernel/genex.S
+++ b/arch/loongarch/kernel/genex.S
@@ -36,7 +36,7 @@ SYM_FUNC_END(__arch_cpu_idle)
 SYM_FUNC_START(handle_vint\idx)
 	BACKUP_T0T1
 	SAVE_ALL
-	la_abs	t1, __arch_cpu_idle
+	la.pcrel	t1, __arch_cpu_idle
 	LONG_L	t0, sp, PT_ERA
 	/* 32 byte rollback region */
 	ori	t0, t0, 0x1f
@@ -45,8 +45,7 @@ SYM_FUNC_START(handle_vint\idx)
 	LONG_S	t0, sp, PT_ERA
 1:	move	a0, sp
 	move	a1, sp
-	la_abs	t0, do_vint
-	jirl	ra, t0, 0
+	bl	do_vint
 	RESTORE_ALL_AND_RET
 SYM_FUNC_END(handle_vint\idx)
 	.endm
@@ -76,8 +75,7 @@ SYM_FUNC_START(handle_\exception)
 	SAVE_ALL
 	build_prep_\prep
 	move	a0, sp
-	la_abs	t0, do_\handler
-	jirl	ra, t0, 0
+	bl	do_\handler
 	UNW_NEED_RESET
 	RESTORE_ALL_AND_RET
 SYM_FUNC_END(handle_\exception)
diff --git a/arch/loongarch/kernel/relocate.c b/arch/loongarch/kernel/relocate.c
index 070b9fb87ebc..5ecfd7791268 100644
--- a/arch/loongarch/kernel/relocate.c
+++ b/arch/loongarch/kernel/relocate.c
@@ -12,7 +12,6 @@
 #include <linux/start_kernel.h>
 #include <asm/bootinfo.h>
 #include <asm/early_ioremap.h>
-#include <asm/inst.h>
 #include <asm/sections.h>
 #include <asm/setup.h>
 
@@ -41,31 +40,6 @@ static inline __init void relocate_relative(void)
 	}
 }
 
-static inline void __init relocate_la_abs(long random_offset)
-{
-	void *begin, *end;
-	struct rela_la_abs *p;
-
-	begin = RELOCATED_KASLR(&__la_abs_begin);
-	end   = RELOCATED_KASLR(&__la_abs_end);
-
-	for (p = begin; (void *)p < end; p++) {
-		long v = p->symvalue;
-		uint32_t lu12iw, ori, lu32id, lu52id;
-		union loongarch_instruction *insn = (void *)p - p->offset;
-
-		lu12iw = (v >> 12) & 0xfffff;
-		ori    = v & 0xfff;
-		lu32id = (v >> 32) & 0xfffff;
-		lu52id = v >> 52;
-
-		insn[0].reg1i20_format.immediate = lu12iw;
-		insn[1].reg2i12_format.immediate = ori;
-		insn[2].reg1i20_format.immediate = lu32id;
-		insn[3].reg2i12_format.immediate = lu52id;
-	}
-}
-
 #ifdef CONFIG_RANDOMIZE_BASE
 static inline __init unsigned long rotate_xor(unsigned long hash,
 					      const void *area, size_t size)
@@ -202,8 +176,6 @@ void * __init relocate_kernel(void)
 	if (reloc_offset)
 		relocate_relative();
 
-	relocate_la_abs(random_offset);
-
 	return kernel_entry;
 }
 
diff --git a/arch/loongarch/kernel/vmlinux.lds.S b/arch/loongarch/kernel/vmlinux.lds.S
index 00f1f9061961..8ae5f245eb2f 100644
--- a/arch/loongarch/kernel/vmlinux.lds.S
+++ b/arch/loongarch/kernel/vmlinux.lds.S
@@ -91,15 +91,6 @@ SECTIONS
 		__alt_instructions_end = .;
 	}
 
-#ifdef CONFIG_RELOCATABLE
-	. = ALIGN(8);
-	.la_abs : AT(ADDR(.la_abs) - LOAD_OFFSET) {
-		__la_abs_begin = .;
-		*(.la_abs)
-		__la_abs_end = .;
-	}
-#endif
-
 	.got : ALIGN(16) { *(.got) }
 	.plt : ALIGN(16) { *(.plt) }
 	.got.plt : ALIGN(16) { *(.got.plt) }
diff --git a/arch/loongarch/mm/tlbex.S b/arch/loongarch/mm/tlbex.S
index 53321d3447a2..3ee16fc61788 100644
--- a/arch/loongarch/mm/tlbex.S
+++ b/arch/loongarch/mm/tlbex.S
@@ -41,8 +41,7 @@ SYM_FUNC_START(handle_tlb_protect\idx)
 	move		a1, zero
 	csrrd		a2, LOONGARCH_CSR_BADV
 	REG_S		a2, sp, PT_BVADDR
-	la_abs		t0, do_page_fault
-	jirl		ra, t0, 0
+	bl		do_page_fault
 	RESTORE_ALL_AND_RET
 SYM_FUNC_END(handle_tlb_protect\idx)
 	.endm
@@ -119,7 +118,7 @@ SYM_FUNC_START(handle_tlb_load\idx)
 
 #ifdef CONFIG_64BIT
 3: /* vmalloc_load: */
-	la_abs		t1, swapper_pg_dir
+	la.pcrel	t1, swapper_pg_dir
 	b		1b
 #endif
 
@@ -190,8 +189,7 @@ SYM_FUNC_START(handle_tlb_load\idx)
 5: /* nopage_tlb_load: */
 	dbar		0
 	csrrd		ra, EXCEPTION_KS2
-	la_abs		t0, tlb_do_page_fault_0
-	jr		t0
+	b		tlb_do_page_fault_0
 SYM_FUNC_END(handle_tlb_load\idx)
 	.endm
 
@@ -268,7 +266,7 @@ smp_pgtable_change_store:
 
 #ifdef CONFIG_64BIT
 vmalloc_store:
-	la_abs		t1, swapper_pg_dir
+	la.pcrel	t1, swapper_pg_dir
 	b		vmalloc_done_store
 #endif
 
@@ -341,8 +339,7 @@ tlb_huge_update_store:
 nopage_tlb_store:
 	dbar		0
 	csrrd		ra, EXCEPTION_KS2
-	la_abs		t0, tlb_do_page_fault_1
-	jr		t0
+	b		tlb_do_page_fault_1
 SYM_FUNC_END(handle_tlb_store)
 	.endm
 
@@ -418,7 +415,7 @@ smp_pgtable_change_modify:
 
 #ifdef CONFIG_64BIT
 vmalloc_modify:
-	la_abs		t1, swapper_pg_dir
+	la.pcrel	t1, swapper_pg_dir
 	b		vmalloc_done_modify
 #endif
 
@@ -490,8 +487,7 @@ tlb_huge_update_modify:
 nopage_tlb_modify:
 	dbar		0
 	csrrd		ra, EXCEPTION_KS2
-	la_abs		t0, tlb_do_page_fault_1
-	jr		t0
+	b		tlb_do_page_fault_1
 SYM_FUNC_END(handle_tlb_modify)
 	.endm
 
-- 
2.34.3

