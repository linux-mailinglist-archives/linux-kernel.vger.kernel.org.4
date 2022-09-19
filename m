Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3428C5BD32B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 19:05:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbiISRFS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 13:05:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230492AbiISREg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 13:04:36 -0400
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8482040E26
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 10:03:48 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4MWWDr5RWXz9sl2;
        Mon, 19 Sep 2022 19:02:04 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Ykl9t8mHspGn; Mon, 19 Sep 2022 19:02:04 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4MWWDr4VQJz9sjb;
        Mon, 19 Sep 2022 19:02:04 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 7CC988B783;
        Mon, 19 Sep 2022 19:02:04 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id nYapW7gLXxlS; Mon, 19 Sep 2022 19:02:04 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.232.8])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 48CC18B76E;
        Mon, 19 Sep 2022 19:02:04 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 28JH1xri1549637
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Mon, 19 Sep 2022 19:01:59 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 28JH1xgM1549636;
        Mon, 19 Sep 2022 19:01:59 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 15/19] powerpc: Remove CONFIG_PPC_BOOK3E_MMU
Date:   Mon, 19 Sep 2022 19:01:39 +0200
Message-Id: <c5549cd59a131204ff94ab909cad2e2dad4ddf2f.1663606876.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <828f6a64eeb51ce9abfa1d4e84c521a02fecebb8.1663606875.git.christophe.leroy@csgroup.eu>
References: <828f6a64eeb51ce9abfa1d4e84c521a02fecebb8.1663606875.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1663606899; l=7287; s=20211009; h=from:subject:message-id; bh=fglMNwb9ZiTrG/In6Xy+k4f2DXnfnFluk74gsP3+QVY=; b=2nTbLx1HZK2qV2DSSZNyxkKeuv9FSYDzBQwzCXKI/YfXjPJ6EBjE0usAuhDcY/z52lLqzjc4eWPh vjmUMDSqDEXuQNbfS2mq/67aPyA/j4OrYegzp3TtN+YkU5GwVPyo
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_PPC_BOOK3E_MMU is redundant with CONFIG_PPC_E500.

Remove it.

Also rename mmu-book3e.h to mmu-e500.h

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 .../include/asm/nohash/{mmu-book3e.h => mmu-e500.h}       | 0
 arch/powerpc/include/asm/nohash/mmu.h                     | 4 ++--
 arch/powerpc/kernel/cpu_setup_e500.S                      | 2 +-
 arch/powerpc/kernel/entry_32.S                            | 2 +-
 arch/powerpc/kernel/head_booke.h                          | 4 ++--
 arch/powerpc/kernel/kvm.c                                 | 8 ++++----
 arch/powerpc/kvm/e500.h                                   | 2 +-
 arch/powerpc/mm/nohash/tlb.c                              | 4 ++--
 arch/powerpc/mm/ptdump/Makefile                           | 2 +-
 arch/powerpc/platforms/Kconfig.cputype                    | 4 ----
 10 files changed, 14 insertions(+), 18 deletions(-)
 rename arch/powerpc/include/asm/nohash/{mmu-book3e.h => mmu-e500.h} (100%)

diff --git a/arch/powerpc/include/asm/nohash/mmu-book3e.h b/arch/powerpc/include/asm/nohash/mmu-e500.h
similarity index 100%
rename from arch/powerpc/include/asm/nohash/mmu-book3e.h
rename to arch/powerpc/include/asm/nohash/mmu-e500.h
diff --git a/arch/powerpc/include/asm/nohash/mmu.h b/arch/powerpc/include/asm/nohash/mmu.h
index edc793e5f08f..e264be219fdb 100644
--- a/arch/powerpc/include/asm/nohash/mmu.h
+++ b/arch/powerpc/include/asm/nohash/mmu.h
@@ -8,9 +8,9 @@
 #elif defined(CONFIG_44x)
 /* 44x-style software loaded TLB */
 #include <asm/nohash/32/mmu-44x.h>
-#elif defined(CONFIG_PPC_BOOK3E_MMU)
+#elif defined(CONFIG_PPC_E500)
 /* Freescale Book-E software loaded TLB or Book-3e (ISA 2.06+) MMU */
-#include <asm/nohash/mmu-book3e.h>
+#include <asm/nohash/mmu-e500.h>
 #elif defined (CONFIG_PPC_8xx)
 /* Motorola/Freescale 8xx software loaded TLB */
 #include <asm/nohash/32/mmu-8xx.h>
diff --git a/arch/powerpc/kernel/cpu_setup_e500.S b/arch/powerpc/kernel/cpu_setup_e500.S
index 058336079069..2ab25161b0ad 100644
--- a/arch/powerpc/kernel/cpu_setup_e500.S
+++ b/arch/powerpc/kernel/cpu_setup_e500.S
@@ -12,7 +12,7 @@
 #include <asm/processor.h>
 #include <asm/cputable.h>
 #include <asm/ppc_asm.h>
-#include <asm/nohash/mmu-book3e.h>
+#include <asm/nohash/mmu-e500.h>
 #include <asm/asm-offsets.h>
 #include <asm/mpc85xx.h>
 
diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
index e6d5fe3a8585..2b5b0677d36c 100644
--- a/arch/powerpc/kernel/entry_32.S
+++ b/arch/powerpc/kernel/entry_32.S
@@ -488,7 +488,7 @@ _ASM_NOKPROBE_SYMBOL(interrupt_return)
 	mtspr	SPRN_##exc_lvl_srr0,r9;					\
 	mtspr	SPRN_##exc_lvl_srr1,r10;
 
-#if defined(CONFIG_PPC_BOOK3E_MMU)
+#if defined(CONFIG_PPC_E500)
 #ifdef CONFIG_PHYS_64BIT
 #define	RESTORE_MAS7							\
 	lwz	r11,MAS7(r1);						\
diff --git a/arch/powerpc/kernel/head_booke.h b/arch/powerpc/kernel/head_booke.h
index 1047dc053b47..1cb9d0f7cbf2 100644
--- a/arch/powerpc/kernel/head_booke.h
+++ b/arch/powerpc/kernel/head_booke.h
@@ -242,7 +242,7 @@ ALT_FTR_SECTION_END_IFSET(CPU_FTR_EMB_HV)
 
 
 .macro SAVE_MMU_REGS
-#ifdef CONFIG_PPC_BOOK3E_MMU
+#ifdef CONFIG_PPC_E500
 	mfspr	r0,SPRN_MAS0
 	stw	r0,MAS0(r1)
 	mfspr	r0,SPRN_MAS1
@@ -257,7 +257,7 @@ ALT_FTR_SECTION_END_IFSET(CPU_FTR_EMB_HV)
 	mfspr	r0,SPRN_MAS7
 	stw	r0,MAS7(r1)
 #endif /* CONFIG_PHYS_64BIT */
-#endif /* CONFIG_PPC_BOOK3E_MMU */
+#endif /* CONFIG_PPC_E500 */
 #ifdef CONFIG_44x
 	mfspr	r0,SPRN_MMUCR
 	stw	r0,MMUCR(r1)
diff --git a/arch/powerpc/kernel/kvm.c b/arch/powerpc/kernel/kvm.c
index 6568823cf306..5b3c093611ba 100644
--- a/arch/powerpc/kernel/kvm.c
+++ b/arch/powerpc/kernel/kvm.c
@@ -455,7 +455,7 @@ static void __init kvm_check_ins(u32 *inst, u32 features)
 		kvm_patch_ins_lwz(inst, magic_var(dsisr), inst_rt);
 		break;
 
-#ifdef CONFIG_PPC_BOOK3E_MMU
+#ifdef CONFIG_PPC_E500
 	case KVM_INST_MFSPR(SPRN_MAS0):
 		if (features & KVM_MAGIC_FEAT_MAS0_TO_SPRG7)
 			kvm_patch_ins_lwz(inst, magic_var(mas0), inst_rt);
@@ -484,7 +484,7 @@ static void __init kvm_check_ins(u32 *inst, u32 features)
 		if (features & KVM_MAGIC_FEAT_MAS0_TO_SPRG7)
 			kvm_patch_ins_lwz(inst, magic_var(mas7_3), inst_rt);
 		break;
-#endif /* CONFIG_PPC_BOOK3E_MMU */
+#endif /* CONFIG_PPC_E500 */
 
 	case KVM_INST_MFSPR(SPRN_SPRG4):
 #ifdef CONFIG_BOOKE
@@ -557,7 +557,7 @@ static void __init kvm_check_ins(u32 *inst, u32 features)
 	case KVM_INST_MTSPR(SPRN_DSISR):
 		kvm_patch_ins_stw(inst, magic_var(dsisr), inst_rt);
 		break;
-#ifdef CONFIG_PPC_BOOK3E_MMU
+#ifdef CONFIG_PPC_E500
 	case KVM_INST_MTSPR(SPRN_MAS0):
 		if (features & KVM_MAGIC_FEAT_MAS0_TO_SPRG7)
 			kvm_patch_ins_stw(inst, magic_var(mas0), inst_rt);
@@ -586,7 +586,7 @@ static void __init kvm_check_ins(u32 *inst, u32 features)
 		if (features & KVM_MAGIC_FEAT_MAS0_TO_SPRG7)
 			kvm_patch_ins_stw(inst, magic_var(mas7_3), inst_rt);
 		break;
-#endif /* CONFIG_PPC_BOOK3E_MMU */
+#endif /* CONFIG_PPC_E500 */
 
 	case KVM_INST_MTSPR(SPRN_SPRG4):
 		if (features & KVM_MAGIC_FEAT_MAS0_TO_SPRG7)
diff --git a/arch/powerpc/kvm/e500.h b/arch/powerpc/kvm/e500.h
index c3ef751465fb..6d0d329cbb35 100644
--- a/arch/powerpc/kvm/e500.h
+++ b/arch/powerpc/kvm/e500.h
@@ -17,7 +17,7 @@
 #define KVM_E500_H
 
 #include <linux/kvm_host.h>
-#include <asm/nohash/mmu-book3e.h>
+#include <asm/nohash/mmu-e500.h>
 #include <asm/tlb.h>
 #include <asm/cputhreads.h>
 
diff --git a/arch/powerpc/mm/nohash/tlb.c b/arch/powerpc/mm/nohash/tlb.c
index fcb1e5ae5c55..fac59fbd475a 100644
--- a/arch/powerpc/mm/nohash/tlb.c
+++ b/arch/powerpc/mm/nohash/tlb.c
@@ -49,7 +49,7 @@
  * other sizes not listed here.   The .ind field is only used on MMUs that have
  * indirect page table entries.
  */
-#if defined(CONFIG_PPC_BOOK3E_MMU) || defined(CONFIG_PPC_8xx)
+#if defined(CONFIG_PPC_E500) || defined(CONFIG_PPC_8xx)
 #ifdef CONFIG_PPC_E500
 struct mmu_psize_def mmu_psize_defs[MMU_PAGE_COUNT] = {
 	[MMU_PAGE_4K] = {
@@ -142,7 +142,7 @@ static inline int mmu_get_tsize(int psize)
 	/* This isn't used on !Book3E for now */
 	return 0;
 }
-#endif /* CONFIG_PPC_BOOK3E_MMU */
+#endif /* CONFIG_PPC_E500 */
 
 /* The variables below are currently only used on 64-bit Book3E
  * though this will probably be made common with other nohash
diff --git a/arch/powerpc/mm/ptdump/Makefile b/arch/powerpc/mm/ptdump/Makefile
index b533caaf0910..dc896d2874f3 100644
--- a/arch/powerpc/mm/ptdump/Makefile
+++ b/arch/powerpc/mm/ptdump/Makefile
@@ -4,7 +4,7 @@ obj-y	+= ptdump.o
 
 obj-$(CONFIG_4xx)		+= shared.o
 obj-$(CONFIG_PPC_8xx)		+= 8xx.o
-obj-$(CONFIG_PPC_BOOK3E_MMU)	+= shared.o
+obj-$(CONFIG_PPC_E500)		+= shared.o
 obj-$(CONFIG_PPC_BOOK3S_32)	+= shared.o
 obj-$(CONFIG_PPC_BOOK3S_64)	+= book3s64.o
 
diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index 32c60ad8f45d..1746d19d058f 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -466,10 +466,6 @@ config PPC_MMU_NOHASH
 	def_bool y
 	depends on !PPC_BOOK3S
 
-config PPC_BOOK3E_MMU
-	def_bool y
-	depends on PPC_85xx || PPC_BOOK3E_64
-
 config PPC_HAVE_PMU_SUPPORT
 	bool
 
-- 
2.37.1

