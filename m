Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C3306A19B5
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 11:12:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbjBXKL6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 05:11:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbjBXKLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 05:11:31 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5AB1316897
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 02:10:57 -0800 (PST)
Received: from loongson.cn (unknown [111.9.175.10])
        by gateway (Coremail) with SMTP id _____8AxYeUwjfhjuaQEAA--.3679S3;
        Fri, 24 Feb 2023 18:10:56 +0800 (CST)
Received: from localhost.localdomain (unknown [111.9.175.10])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8AxX+QjjfhjNH86AA--.6368S8;
        Fri, 24 Feb 2023 18:10:55 +0800 (CST)
From:   Jinyang He <hejinyang@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>
Cc:     Xi Ruoyao <xry111@xry111.site>,
        Youling Tang <tangyouling@loongson.cn>,
        loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] LoongArch: Clean up la_abs macro
Date:   Fri, 24 Feb 2023 18:10:13 +0800
Message-Id: <20230224101013.26971-7-hejinyang@loongson.cn>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230224101013.26971-1-hejinyang@loongson.cn>
References: <20230224101013.26971-1-hejinyang@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxX+QjjfhjNH86AA--.6368S8
X-CM-SenderInfo: pkhmx0p1dqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBjvJXoWxKryDGFWUXr1xtw13tF4rGrg_yoW3JrWDpF
        nxZrn7JayrWrn3Za4Dta4DurZ8JwsFg342ganIkFy8u3W7ZF18ZrykA3s7ZFykKay8Xw4I
        gFyrJws2qF4UJwUanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        b28YFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1l
        e2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4xG64xvF2
        IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE14v26r4j6F4U
        McvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x0EwIxGrwCFx2
        IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v2
        6r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67
        AKxVW5JVW7JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IY
        s7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr
        0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07josjUUUUUU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
 arch/loongarch/kernel/entry.S           |  4 ++--
 arch/loongarch/kernel/genex.S           |  6 +++---
 arch/loongarch/kernel/relocate.c        | 28 -------------------------
 arch/loongarch/kernel/vmlinux.lds.S     |  9 --------
 arch/loongarch/mm/tlbex.S               | 14 ++++++-------
 8 files changed, 13 insertions(+), 74 deletions(-)

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
index ca4651f91e73..4de6b31dc3bf 100644
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
@@ -65,7 +65,7 @@ SYM_FUNC_START(handle_sys)
 	and		tp, tp, sp
 
 	move	a0, sp
-	la_abs	ra, do_syscall
+	la.pcrel	ra, do_syscall
 	jirl	ra, ra, 0
 
 	RESTORE_ALL_AND_RET
diff --git a/arch/loongarch/kernel/genex.S b/arch/loongarch/kernel/genex.S
index 8705a7661ce9..b6a74246d1c4 100644
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
@@ -45,7 +45,7 @@ SYM_FUNC_START(handle_vint\idx)
 	LONG_S	t0, sp, PT_ERA
 1:	move	a0, sp
 	move	a1, sp
-	la_abs	t0, do_vint
+	la.pcrel	t0, do_vint
 	jirl	ra, t0, 0
 	RESTORE_ALL_AND_RET
 SYM_FUNC_END(handle_vint\idx)
@@ -76,7 +76,7 @@ SYM_FUNC_START(handle_\exception)
 	SAVE_ALL
 	build_prep_\prep
 	move	a0, sp
-	la_abs	t0, do_\handler
+	la.pcrel	t0, do_\handler
 	jirl	ra, t0, 0
 	UNW_NEED_RESET
 	RESTORE_ALL_AND_RET
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
index 53321d3447a2..196d9bc870c5 100644
--- a/arch/loongarch/mm/tlbex.S
+++ b/arch/loongarch/mm/tlbex.S
@@ -41,7 +41,7 @@ SYM_FUNC_START(handle_tlb_protect\idx)
 	move		a1, zero
 	csrrd		a2, LOONGARCH_CSR_BADV
 	REG_S		a2, sp, PT_BVADDR
-	la_abs		t0, do_page_fault
+	la.pcrel	t0, do_page_fault
 	jirl		ra, t0, 0
 	RESTORE_ALL_AND_RET
 SYM_FUNC_END(handle_tlb_protect\idx)
@@ -119,7 +119,7 @@ SYM_FUNC_START(handle_tlb_load\idx)
 
 #ifdef CONFIG_64BIT
 3: /* vmalloc_load: */
-	la_abs		t1, swapper_pg_dir
+	la.pcrel	t1, swapper_pg_dir
 	b		1b
 #endif
 
@@ -190,7 +190,7 @@ SYM_FUNC_START(handle_tlb_load\idx)
 5: /* nopage_tlb_load: */
 	dbar		0
 	csrrd		ra, EXCEPTION_KS2
-	la_abs		t0, tlb_do_page_fault_0
+	la.pcrel	t0, tlb_do_page_fault_0
 	jr		t0
 SYM_FUNC_END(handle_tlb_load\idx)
 	.endm
@@ -268,7 +268,7 @@ smp_pgtable_change_store:
 
 #ifdef CONFIG_64BIT
 vmalloc_store:
-	la_abs		t1, swapper_pg_dir
+	la.pcrel	t1, swapper_pg_dir
 	b		vmalloc_done_store
 #endif
 
@@ -341,7 +341,7 @@ tlb_huge_update_store:
 nopage_tlb_store:
 	dbar		0
 	csrrd		ra, EXCEPTION_KS2
-	la_abs		t0, tlb_do_page_fault_1
+	la.pcrel	t0, tlb_do_page_fault_1
 	jr		t0
 SYM_FUNC_END(handle_tlb_store)
 	.endm
@@ -418,7 +418,7 @@ smp_pgtable_change_modify:
 
 #ifdef CONFIG_64BIT
 vmalloc_modify:
-	la_abs		t1, swapper_pg_dir
+	la.pcrel	t1, swapper_pg_dir
 	b		vmalloc_done_modify
 #endif
 
@@ -490,7 +490,7 @@ tlb_huge_update_modify:
 nopage_tlb_modify:
 	dbar		0
 	csrrd		ra, EXCEPTION_KS2
-	la_abs		t0, tlb_do_page_fault_1
+	la.pcrel	t0, tlb_do_page_fault_1
 	jr		t0
 SYM_FUNC_END(handle_tlb_modify)
 	.endm
-- 
2.34.3

