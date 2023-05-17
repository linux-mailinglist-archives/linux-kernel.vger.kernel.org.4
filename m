Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 146FA706782
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 14:05:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231196AbjEQMFk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 08:05:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231128AbjEQMFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 08:05:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8E7DA5D1;
        Wed, 17 May 2023 05:03:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0D13B6462F;
        Wed, 17 May 2023 12:02:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 263F4C433A0;
        Wed, 17 May 2023 12:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684324976;
        bh=38FU9x2oyMe1/FptV5vHQFf0Cc1pRRNwz4N2IiSU1Y4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lJ0llVGPKYHJNZ+ThVqmTxvs7XIButWRFJ0DUHigIfhW97T1S/U40mRADi+ZS+ieH
         gBw80KP1Da8KuisFtyI6yaPjbcEkR/ZKTXUPXF2tSQWJKOyDRIo+zFNvyaL/h+Ibc/
         KNgcRrcDuDmr/oiBK63BGvJiT/apMVrQgf5N/pWg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.2.16
Date:   Wed, 17 May 2023 14:02:40 +0200
Message-Id: <2023051745-residue-bagel-bd18@gregkh>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <2023051744-drainable-footwear-49bd@gregkh>
References: <2023051744-drainable-footwear-49bd@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

diff --git a/Makefile b/Makefile
index 9f535df81b03..e00c12240191 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 2
-SUBLEVEL = 15
+SUBLEVEL = 16
 EXTRAVERSION =
 NAME = Hurr durr I'ma ninja sloth
 
diff --git a/arch/arm/boot/dts/aspeed-bmc-asrock-e3c246d4i.dts b/arch/arm/boot/dts/aspeed-bmc-asrock-e3c246d4i.dts
index 9b4cf5ebe6d5..c62aff908ab4 100644
--- a/arch/arm/boot/dts/aspeed-bmc-asrock-e3c246d4i.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-asrock-e3c246d4i.dts
@@ -63,7 +63,7 @@ flash@0 {
 		status = "okay";
 		m25p,fast-read;
 		label = "bmc";
-		spi-max-frequency = <100000000>; /* 100 MHz */
+		spi-max-frequency = <50000000>; /* 50 MHz */
 #include "openbmc-flash-layout.dtsi"
 	};
 };
diff --git a/arch/arm/boot/dts/aspeed-bmc-asrock-romed8hm3.dts b/arch/arm/boot/dts/aspeed-bmc-asrock-romed8hm3.dts
index ff4c07c69af1..4554abf0c7cd 100644
--- a/arch/arm/boot/dts/aspeed-bmc-asrock-romed8hm3.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-asrock-romed8hm3.dts
@@ -31,7 +31,7 @@ heartbeat {
 		};
 
 		system-fault {
-			gpios = <&gpio ASPEED_GPIO(Z, 2) GPIO_ACTIVE_LOW>;
+			gpios = <&gpio ASPEED_GPIO(Z, 2) GPIO_ACTIVE_HIGH>;
 			panic-indicator;
 		};
 	};
@@ -51,7 +51,7 @@ flash@0 {
 		status = "okay";
 		m25p,fast-read;
 		label = "bmc";
-		spi-max-frequency = <100000000>; /* 100 MHz */
+		spi-max-frequency = <50000000>; /* 50 MHz */
 #include "openbmc-flash-layout-64.dtsi"
 	};
 };
diff --git a/arch/arm/boot/dts/exynos4412-itop-elite.dts b/arch/arm/boot/dts/exynos4412-itop-elite.dts
index 202ab0fee3b7..bfc79490e2e2 100644
--- a/arch/arm/boot/dts/exynos4412-itop-elite.dts
+++ b/arch/arm/boot/dts/exynos4412-itop-elite.dts
@@ -182,7 +182,7 @@ codec: audio-codec@1a {
 		compatible = "wlf,wm8960";
 		reg = <0x1a>;
 		clocks = <&pmu_system_controller 0>;
-		clock-names = "MCLK1";
+		clock-names = "mclk";
 		wlf,shared-lrclk;
 		#sound-dai-cells = <0>;
 	};
diff --git a/arch/arm/boot/dts/s5pv210.dtsi b/arch/arm/boot/dts/s5pv210.dtsi
index 12e90a1cc6a1..1a9e4a96b2ff 100644
--- a/arch/arm/boot/dts/s5pv210.dtsi
+++ b/arch/arm/boot/dts/s5pv210.dtsi
@@ -566,7 +566,7 @@ csis0: csis@fa600000 {
 				interrupts = <29>;
 				clocks = <&clocks CLK_CSIS>,
 						<&clocks SCLK_CSIS>;
-				clock-names = "clk_csis",
+				clock-names = "csis",
 						"sclk_csis";
 				bus-width = <4>;
 				status = "disabled";
diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
index 4cf303a779ab..8d02b9d05738 100644
--- a/arch/riscv/kernel/Makefile
+++ b/arch/riscv/kernel/Makefile
@@ -9,6 +9,7 @@ CFLAGS_REMOVE_patch.o	= $(CC_FLAGS_FTRACE)
 CFLAGS_REMOVE_sbi.o	= $(CC_FLAGS_FTRACE)
 endif
 CFLAGS_syscall_table.o	+= $(call cc-option,-Wno-override-init,)
+CFLAGS_compat_syscall_table.o += $(call cc-option,-Wno-override-init,)
 
 ifdef CONFIG_KEXEC
 AFLAGS_kexec_relocate.o := -mcmodel=medany $(call cc-option,-mno-relax)
diff --git a/arch/riscv/mm/pageattr.c b/arch/riscv/mm/pageattr.c
index 86c56616e5de..ea3d61de065b 100644
--- a/arch/riscv/mm/pageattr.c
+++ b/arch/riscv/mm/pageattr.c
@@ -217,18 +217,26 @@ bool kernel_page_present(struct page *page)
 	pgd = pgd_offset_k(addr);
 	if (!pgd_present(*pgd))
 		return false;
+	if (pgd_leaf(*pgd))
+		return true;
 
 	p4d = p4d_offset(pgd, addr);
 	if (!p4d_present(*p4d))
 		return false;
+	if (p4d_leaf(*p4d))
+		return true;
 
 	pud = pud_offset(p4d, addr);
 	if (!pud_present(*pud))
 		return false;
+	if (pud_leaf(*pud))
+		return true;
 
 	pmd = pmd_offset(pud, addr);
 	if (!pmd_present(*pmd))
 		return false;
+	if (pmd_leaf(*pmd))
+		return true;
 
 	pte = pte_offset_kernel(pmd, addr);
 	return pte_present(*pte);
diff --git a/arch/s390/kernel/uv.c b/arch/s390/kernel/uv.c
index 9f18a4af9c13..cb2ee06df286 100644
--- a/arch/s390/kernel/uv.c
+++ b/arch/s390/kernel/uv.c
@@ -192,21 +192,10 @@ static int expected_page_refs(struct page *page)
 	return res;
 }
 
-static int make_secure_pte(pte_t *ptep, unsigned long addr,
-			   struct page *exp_page, struct uv_cb_header *uvcb)
+static int make_page_secure(struct page *page, struct uv_cb_header *uvcb)
 {
-	pte_t entry = READ_ONCE(*ptep);
-	struct page *page;
 	int expected, cc = 0;
 
-	if (!pte_present(entry))
-		return -ENXIO;
-	if (pte_val(entry) & _PAGE_INVALID)
-		return -ENXIO;
-
-	page = pte_page(entry);
-	if (page != exp_page)
-		return -ENXIO;
 	if (PageWriteback(page))
 		return -EAGAIN;
 	expected = expected_page_refs(page);
@@ -304,17 +293,18 @@ int gmap_make_secure(struct gmap *gmap, unsigned long gaddr, void *uvcb)
 		goto out;
 
 	rc = -ENXIO;
-	page = follow_page(vma, uaddr, FOLL_WRITE);
-	if (IS_ERR_OR_NULL(page))
-		goto out;
-
-	lock_page(page);
 	ptep = get_locked_pte(gmap->mm, uaddr, &ptelock);
-	if (should_export_before_import(uvcb, gmap->mm))
-		uv_convert_from_secure(page_to_phys(page));
-	rc = make_secure_pte(ptep, uaddr, page, uvcb);
+	if (pte_present(*ptep) && !(pte_val(*ptep) & _PAGE_INVALID) && pte_write(*ptep)) {
+		page = pte_page(*ptep);
+		rc = -EAGAIN;
+		if (trylock_page(page)) {
+			if (should_export_before_import(uvcb, gmap->mm))
+				uv_convert_from_secure(page_to_phys(page));
+			rc = make_page_secure(page, uvcb);
+			unlock_page(page);
+		}
+	}
 	pte_unmap_unlock(ptep, ptelock);
-	unlock_page(page);
 out:
 	mmap_read_unlock(gmap->mm);
 
diff --git a/arch/s390/kvm/pv.c b/arch/s390/kvm/pv.c
index e032ebbf51b9..3ce5f4351156 100644
--- a/arch/s390/kvm/pv.c
+++ b/arch/s390/kvm/pv.c
@@ -314,6 +314,11 @@ int kvm_s390_pv_set_aside(struct kvm *kvm, u16 *rc, u16 *rrc)
 	 */
 	if (kvm->arch.pv.set_aside)
 		return -EINVAL;
+
+	/* Guest with segment type ASCE, refuse to destroy asynchronously */
+	if ((kvm->arch.gmap->asce & _ASCE_TYPE_MASK) == _ASCE_TYPE_SEGMENT)
+		return -EINVAL;
+
 	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
index 74e1d873dce0..784fc6cbddb1 100644
--- a/arch/s390/mm/gmap.c
+++ b/arch/s390/mm/gmap.c
@@ -2830,6 +2830,9 @@ EXPORT_SYMBOL_GPL(s390_unlist_old_asce);
  * s390_replace_asce - Try to replace the current ASCE of a gmap with a copy
  * @gmap: the gmap whose ASCE needs to be replaced
  *
+ * If the ASCE is a SEGMENT type then this function will return -EINVAL,
+ * otherwise the pointers in the host_to_guest radix tree will keep pointing
+ * to the wrong pages, causing use-after-free and memory corruption.
  * If the allocation of the new top level page table fails, the ASCE is not
  * replaced.
  * In any case, the old ASCE is always removed from the gmap CRST list.
@@ -2844,6 +2847,10 @@ int s390_replace_asce(struct gmap *gmap)
 
 	s390_unlist_old_asce(gmap);
 
+	/* Replacing segment type ASCEs would cause serious issues */
+	if ((gmap->asce & _ASCE_TYPE_MASK) == _ASCE_TYPE_SEGMENT)
+		return -EINVAL;
+
 	page = alloc_pages(GFP_KERNEL_ACCOUNT, CRST_ALLOC_ORDER);
 	if (!page)
 		return -ENOMEM;
diff --git a/arch/sh/Kconfig.debug b/arch/sh/Kconfig.debug
index 10290e5c1f43..c449e7c1b20f 100644
--- a/arch/sh/Kconfig.debug
+++ b/arch/sh/Kconfig.debug
@@ -15,7 +15,7 @@ config SH_STANDARD_BIOS
 
 config STACK_DEBUG
 	bool "Check for stack overflows"
-	depends on DEBUG_KERNEL
+	depends on DEBUG_KERNEL && PRINTK
 	help
 	  This option will cause messages to be printed if free stack space
 	  drops below a certain limit. Saying Y here will add overhead to
diff --git a/arch/sh/kernel/head_32.S b/arch/sh/kernel/head_32.S
index 4adbd4ade319..b603b7968b38 100644
--- a/arch/sh/kernel/head_32.S
+++ b/arch/sh/kernel/head_32.S
@@ -64,7 +64,7 @@ ENTRY(_stext)
 	ldc	r0, r6_bank
 #endif
 
-#ifdef CONFIG_OF_FLATTREE
+#ifdef CONFIG_OF_EARLY_FLATTREE
 	mov	r4, r12		! Store device tree blob pointer in r12
 #endif
 	
@@ -315,7 +315,7 @@ ENTRY(_stext)
 10:		
 #endif
 
-#ifdef CONFIG_OF_FLATTREE
+#ifdef CONFIG_OF_EARLY_FLATTREE
 	mov.l	8f, r0		! Make flat device tree available early.
 	jsr	@r0
 	 mov	r12, r4
@@ -346,7 +346,7 @@ ENTRY(stack_start)
 5:	.long	start_kernel
 6:	.long	cpu_init
 7:	.long	init_thread_union
-#if defined(CONFIG_OF_FLATTREE)
+#if defined(CONFIG_OF_EARLY_FLATTREE)
 8:	.long	sh_fdt_init
 #endif
 
diff --git a/arch/sh/kernel/nmi_debug.c b/arch/sh/kernel/nmi_debug.c
index 11777867c6f5..a212b645b4cf 100644
--- a/arch/sh/kernel/nmi_debug.c
+++ b/arch/sh/kernel/nmi_debug.c
@@ -49,7 +49,7 @@ static int __init nmi_debug_setup(char *str)
 	register_die_notifier(&nmi_debug_nb);
 
 	if (*str != '=')
-		return 0;
+		return 1;
 
 	for (p = str + 1; *p; p = sep + 1) {
 		sep = strchr(p, ',');
@@ -70,6 +70,6 @@ static int __init nmi_debug_setup(char *str)
 			break;
 	}
 
-	return 0;
+	return 1;
 }
 __setup("nmi_debug", nmi_debug_setup);
diff --git a/arch/sh/kernel/setup.c b/arch/sh/kernel/setup.c
index 1fcb6659822a..af977ec4ca5e 100644
--- a/arch/sh/kernel/setup.c
+++ b/arch/sh/kernel/setup.c
@@ -244,7 +244,7 @@ void __init __weak plat_early_device_setup(void)
 {
 }
 
-#ifdef CONFIG_OF_FLATTREE
+#ifdef CONFIG_OF_EARLY_FLATTREE
 void __ref sh_fdt_init(phys_addr_t dt_phys)
 {
 	static int done = 0;
@@ -326,7 +326,7 @@ void __init setup_arch(char **cmdline_p)
 	/* Let earlyprintk output early console messages */
 	sh_early_platform_driver_probe("earlyprintk", 1, 1);
 
-#ifdef CONFIG_OF_FLATTREE
+#ifdef CONFIG_OF_EARLY_FLATTREE
 #ifdef CONFIG_USE_BUILTIN_DTB
 	unflatten_and_copy_device_tree();
 #else
diff --git a/arch/sh/math-emu/sfp-util.h b/arch/sh/math-emu/sfp-util.h
index 784f541344f3..bda50762b3d3 100644
--- a/arch/sh/math-emu/sfp-util.h
+++ b/arch/sh/math-emu/sfp-util.h
@@ -67,7 +67,3 @@
   } while (0)
 
 #define abort()	return 0
-
-#define __BYTE_ORDER __LITTLE_ENDIAN
-
-
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 24480b4f1c57..adc3149c833a 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1342,21 +1342,12 @@ struct kvm_arch {
 	struct task_struct *nx_huge_page_recovery_thread;
 
 #ifdef CONFIG_X86_64
-	/*
-	 * Whether the TDP MMU is enabled for this VM. This contains a
-	 * snapshot of the TDP MMU module parameter from when the VM was
-	 * created and remains unchanged for the life of the VM. If this is
-	 * true, TDP MMU handler functions will run for various MMU
-	 * operations.
-	 */
-	bool tdp_mmu_enabled;
-
 	/* The number of TDP MMU pages across all roots. */
 	atomic64_t tdp_mmu_pages;
 
 	/*
-	 * List of kvm_mmu_page structs being used as roots.
-	 * All kvm_mmu_page structs in the list should have
+	 * List of struct kvm_mmu_pages being used as roots.
+	 * All struct kvm_mmu_pages in the list should have
 	 * tdp_mmu_page set.
 	 *
 	 * For reads, this list is protected by:
diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
index 4266b64631a4..7e331e8f3692 100644
--- a/arch/x86/kernel/amd_nb.c
+++ b/arch/x86/kernel/amd_nb.c
@@ -36,6 +36,7 @@
 #define PCI_DEVICE_ID_AMD_19H_M50H_DF_F4 0x166e
 #define PCI_DEVICE_ID_AMD_19H_M60H_DF_F4 0x14e4
 #define PCI_DEVICE_ID_AMD_19H_M70H_DF_F4 0x14f4
+#define PCI_DEVICE_ID_AMD_19H_M78H_DF_F4 0x12fc
 
 /* Protect the PCI config register pairs used for SMN. */
 static DEFINE_MUTEX(smn_mutex);
@@ -79,6 +80,7 @@ static const struct pci_device_id amd_nb_misc_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M50H_DF_F3) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M60H_DF_F3) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M70H_DF_F3) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M78H_DF_F3) },
 	{}
 };
 
diff --git a/arch/x86/kvm/kvm_cache_regs.h b/arch/x86/kvm/kvm_cache_regs.h
index c09174f73a34..451697a96cf3 100644
--- a/arch/x86/kvm/kvm_cache_regs.h
+++ b/arch/x86/kvm/kvm_cache_regs.h
@@ -4,7 +4,7 @@
 
 #include <linux/kvm_host.h>
 
-#define KVM_POSSIBLE_CR0_GUEST_BITS X86_CR0_TS
+#define KVM_POSSIBLE_CR0_GUEST_BITS	(X86_CR0_TS | X86_CR0_WP)
 #define KVM_POSSIBLE_CR4_GUEST_BITS				  \
 	(X86_CR4_PVI | X86_CR4_DE | X86_CR4_PCE | X86_CR4_OSFXSR  \
 	 | X86_CR4_OSXMMEXCPT | X86_CR4_PGE | X86_CR4_TSD | X86_CR4_FSGSBASE)
diff --git a/arch/x86/kvm/mmu.h b/arch/x86/kvm/mmu.h
index 6bdaacb6faa0..0f38b78ab04b 100644
--- a/arch/x86/kvm/mmu.h
+++ b/arch/x86/kvm/mmu.h
@@ -113,6 +113,8 @@ void kvm_init_shadow_ept_mmu(struct kvm_vcpu *vcpu, bool execonly,
 bool kvm_can_do_async_pf(struct kvm_vcpu *vcpu);
 int kvm_handle_page_fault(struct kvm_vcpu *vcpu, u64 error_code,
 				u64 fault_address, char *insn, int insn_len);
+void __kvm_mmu_refresh_passthrough_bits(struct kvm_vcpu *vcpu,
+					struct kvm_mmu *mmu);
 
 int kvm_mmu_load(struct kvm_vcpu *vcpu);
 void kvm_mmu_unload(struct kvm_vcpu *vcpu);
@@ -153,6 +155,24 @@ static inline void kvm_mmu_load_pgd(struct kvm_vcpu *vcpu)
 					  vcpu->arch.mmu->root_role.level);
 }
 
+static inline void kvm_mmu_refresh_passthrough_bits(struct kvm_vcpu *vcpu,
+						    struct kvm_mmu *mmu)
+{
+	/*
+	 * When EPT is enabled, KVM may passthrough CR0.WP to the guest, i.e.
+	 * @mmu's snapshot of CR0.WP and thus all related paging metadata may
+	 * be stale.  Refresh CR0.WP and the metadata on-demand when checking
+	 * for permission faults.  Exempt nested MMUs, i.e. MMUs for shadowing
+	 * nEPT and nNPT, as CR0.WP is ignored in both cases.  Note, KVM does
+	 * need to refresh nested_mmu, a.k.a. the walker used to translate L2
+	 * GVAs to GPAs, as that "MMU" needs to honor L2's CR0.WP.
+	 */
+	if (!tdp_enabled || mmu == &vcpu->arch.guest_mmu)
+		return;
+
+	__kvm_mmu_refresh_passthrough_bits(vcpu, mmu);
+}
+
 /*
  * Check if a given access (described through the I/D, W/R and U/S bits of a
  * page fault error code pfec) causes a permission fault with the given PTE
@@ -184,8 +204,12 @@ static inline u8 permission_fault(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu,
 	u64 implicit_access = access & PFERR_IMPLICIT_ACCESS;
 	bool not_smap = ((rflags & X86_EFLAGS_AC) | implicit_access) == X86_EFLAGS_AC;
 	int index = (pfec + (not_smap << PFERR_RSVD_BIT)) >> 1;
-	bool fault = (mmu->permissions[index] >> pte_access) & 1;
 	u32 errcode = PFERR_PRESENT_MASK;
+	bool fault;
+
+	kvm_mmu_refresh_passthrough_bits(vcpu, mmu);
+
+	fault = (mmu->permissions[index] >> pte_access) & 1;
 
 	WARN_ON(pfec & (PFERR_PK_MASK | PFERR_RSVD_MASK));
 	if (unlikely(mmu->pkru_mask)) {
@@ -230,14 +254,14 @@ static inline bool kvm_shadow_root_allocated(struct kvm *kvm)
 }
 
 #ifdef CONFIG_X86_64
-static inline bool is_tdp_mmu_enabled(struct kvm *kvm) { return kvm->arch.tdp_mmu_enabled; }
+extern bool tdp_mmu_enabled;
 #else
-static inline bool is_tdp_mmu_enabled(struct kvm *kvm) { return false; }
+#define tdp_mmu_enabled false
 #endif
 
 static inline bool kvm_memslots_have_rmaps(struct kvm *kvm)
 {
-	return !is_tdp_mmu_enabled(kvm) || kvm_shadow_root_allocated(kvm);
+	return !tdp_mmu_enabled || kvm_shadow_root_allocated(kvm);
 }
 
 static inline gfn_t gfn_to_index(gfn_t gfn, gfn_t base_gfn, int level)
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 835426254e76..dcca08a08bd0 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -99,6 +99,13 @@ module_param_named(flush_on_reuse, force_flush_and_sync_on_reuse, bool, 0644);
  */
 bool tdp_enabled = false;
 
+bool __ro_after_init tdp_mmu_allowed;
+
+#ifdef CONFIG_X86_64
+bool __read_mostly tdp_mmu_enabled = true;
+module_param_named(tdp_mmu, tdp_mmu_enabled, bool, 0444);
+#endif
+
 static int max_huge_page_level __read_mostly;
 static int tdp_root_level __read_mostly;
 static int max_tdp_level __read_mostly;
@@ -233,6 +240,20 @@ static struct kvm_mmu_role_regs vcpu_to_role_regs(struct kvm_vcpu *vcpu)
 	return regs;
 }
 
+static unsigned long get_guest_cr3(struct kvm_vcpu *vcpu)
+{
+	return kvm_read_cr3(vcpu);
+}
+
+static inline unsigned long kvm_mmu_get_guest_pgd(struct kvm_vcpu *vcpu,
+						  struct kvm_mmu *mmu)
+{
+	if (IS_ENABLED(CONFIG_RETPOLINE) && mmu->get_guest_pgd == get_guest_cr3)
+		return kvm_read_cr3(vcpu);
+
+	return mmu->get_guest_pgd(vcpu);
+}
+
 static inline bool kvm_available_flush_tlb_with_range(void)
 {
 	return kvm_x86_ops.tlb_remote_flush_with_range;
@@ -1279,7 +1300,7 @@ static void kvm_mmu_write_protect_pt_masked(struct kvm *kvm,
 {
 	struct kvm_rmap_head *rmap_head;
 
-	if (is_tdp_mmu_enabled(kvm))
+	if (tdp_mmu_enabled)
 		kvm_tdp_mmu_clear_dirty_pt_masked(kvm, slot,
 				slot->base_gfn + gfn_offset, mask, true);
 
@@ -1312,7 +1333,7 @@ static void kvm_mmu_clear_dirty_pt_masked(struct kvm *kvm,
 {
 	struct kvm_rmap_head *rmap_head;
 
-	if (is_tdp_mmu_enabled(kvm))
+	if (tdp_mmu_enabled)
 		kvm_tdp_mmu_clear_dirty_pt_masked(kvm, slot,
 				slot->base_gfn + gfn_offset, mask, false);
 
@@ -1395,7 +1416,7 @@ bool kvm_mmu_slot_gfn_write_protect(struct kvm *kvm,
 		}
 	}
 
-	if (is_tdp_mmu_enabled(kvm))
+	if (tdp_mmu_enabled)
 		write_protected |=
 			kvm_tdp_mmu_write_protect_gfn(kvm, slot, gfn, min_level);
 
@@ -1558,7 +1579,7 @@ bool kvm_unmap_gfn_range(struct kvm *kvm, struct kvm_gfn_range *range)
 	if (kvm_memslots_have_rmaps(kvm))
 		flush = kvm_handle_gfn_range(kvm, range, kvm_zap_rmap);
 
-	if (is_tdp_mmu_enabled(kvm))
+	if (tdp_mmu_enabled)
 		flush = kvm_tdp_mmu_unmap_gfn_range(kvm, range, flush);
 
 	return flush;
@@ -1571,7 +1592,7 @@ bool kvm_set_spte_gfn(struct kvm *kvm, struct kvm_gfn_range *range)
 	if (kvm_memslots_have_rmaps(kvm))
 		flush = kvm_handle_gfn_range(kvm, range, kvm_set_pte_rmap);
 
-	if (is_tdp_mmu_enabled(kvm))
+	if (tdp_mmu_enabled)
 		flush |= kvm_tdp_mmu_set_spte_gfn(kvm, range);
 
 	return flush;
@@ -1646,7 +1667,7 @@ bool kvm_age_gfn(struct kvm *kvm, struct kvm_gfn_range *range)
 	if (kvm_memslots_have_rmaps(kvm))
 		young = kvm_handle_gfn_range(kvm, range, kvm_age_rmap);
 
-	if (is_tdp_mmu_enabled(kvm))
+	if (tdp_mmu_enabled)
 		young |= kvm_tdp_mmu_age_gfn_range(kvm, range);
 
 	return young;
@@ -1659,7 +1680,7 @@ bool kvm_test_age_gfn(struct kvm *kvm, struct kvm_gfn_range *range)
 	if (kvm_memslots_have_rmaps(kvm))
 		young = kvm_handle_gfn_range(kvm, range, kvm_test_age_rmap);
 
-	if (is_tdp_mmu_enabled(kvm))
+	if (tdp_mmu_enabled)
 		young |= kvm_tdp_mmu_test_age_gfn(kvm, range);
 
 	return young;
@@ -1921,7 +1942,7 @@ static bool is_obsolete_sp(struct kvm *kvm, struct kvm_mmu_page *sp)
 		return true;
 
 	/* TDP MMU pages do not use the MMU generation. */
-	return !sp->tdp_mmu_page &&
+	return !is_tdp_mmu_page(sp) &&
 	       unlikely(sp->mmu_valid_gen != kvm->arch.mmu_valid_gen);
 }
 
@@ -3596,7 +3617,7 @@ static int mmu_alloc_direct_roots(struct kvm_vcpu *vcpu)
 	if (r < 0)
 		goto out_unlock;
 
-	if (is_tdp_mmu_enabled(vcpu->kvm)) {
+	if (tdp_mmu_enabled) {
 		root = kvm_tdp_mmu_get_vcpu_root_hpa(vcpu);
 		mmu->root.hpa = root;
 	} else if (shadow_root_level >= PT64_ROOT_4LEVEL) {
@@ -3699,7 +3720,7 @@ static int mmu_alloc_shadow_roots(struct kvm_vcpu *vcpu)
 	int quadrant, i, r;
 	hpa_t root;
 
-	root_pgd = mmu->get_guest_pgd(vcpu);
+	root_pgd = kvm_mmu_get_guest_pgd(vcpu, mmu);
 	root_gfn = root_pgd >> PAGE_SHIFT;
 
 	if (mmu_check_root(vcpu, root_gfn))
@@ -4149,7 +4170,7 @@ static bool kvm_arch_setup_async_pf(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
 	arch.token = alloc_apf_token(vcpu);
 	arch.gfn = gfn;
 	arch.direct_map = vcpu->arch.mmu->root_role.direct;
-	arch.cr3 = vcpu->arch.mmu->get_guest_pgd(vcpu);
+	arch.cr3 = kvm_mmu_get_guest_pgd(vcpu, vcpu->arch.mmu);
 
 	return kvm_setup_async_pf(vcpu, cr2_or_gpa,
 				  kvm_vcpu_gfn_to_hva(vcpu, gfn), &arch);
@@ -4168,7 +4189,7 @@ void kvm_arch_async_page_ready(struct kvm_vcpu *vcpu, struct kvm_async_pf *work)
 		return;
 
 	if (!vcpu->arch.mmu->root_role.direct &&
-	      work->arch.cr3 != vcpu->arch.mmu->get_guest_pgd(vcpu))
+	      work->arch.cr3 != kvm_mmu_get_guest_pgd(vcpu, vcpu->arch.mmu))
 		return;
 
 	kvm_mmu_do_page_fault(vcpu, work->cr2_or_gpa, 0, true);
@@ -4530,11 +4551,6 @@ void kvm_mmu_new_pgd(struct kvm_vcpu *vcpu, gpa_t new_pgd)
 }
 EXPORT_SYMBOL_GPL(kvm_mmu_new_pgd);
 
-static unsigned long get_cr3(struct kvm_vcpu *vcpu)
-{
-	return kvm_read_cr3(vcpu);
-}
-
 static bool sync_mmio_spte(struct kvm_vcpu *vcpu, u64 *sptep, gfn_t gfn,
 			   unsigned int access)
 {
@@ -5038,6 +5054,21 @@ kvm_calc_cpu_role(struct kvm_vcpu *vcpu, const struct kvm_mmu_role_regs *regs)
 	return role;
 }
 
+void __kvm_mmu_refresh_passthrough_bits(struct kvm_vcpu *vcpu,
+					struct kvm_mmu *mmu)
+{
+	const bool cr0_wp = !!kvm_read_cr0_bits(vcpu, X86_CR0_WP);
+
+	BUILD_BUG_ON((KVM_MMU_CR0_ROLE_BITS & KVM_POSSIBLE_CR0_GUEST_BITS) != X86_CR0_WP);
+	BUILD_BUG_ON((KVM_MMU_CR4_ROLE_BITS & KVM_POSSIBLE_CR4_GUEST_BITS));
+
+	if (is_cr0_wp(mmu) == cr0_wp)
+		return;
+
+	mmu->cpu_role.base.cr0_wp = cr0_wp;
+	reset_guest_paging_metadata(vcpu, mmu);
+}
+
 static inline int kvm_mmu_get_tdp_level(struct kvm_vcpu *vcpu)
 {
 	/* tdp_root_level is architecture forced level, use it if nonzero */
@@ -5085,7 +5116,7 @@ static void init_kvm_tdp_mmu(struct kvm_vcpu *vcpu,
 	context->page_fault = kvm_tdp_page_fault;
 	context->sync_page = nonpaging_sync_page;
 	context->invlpg = NULL;
-	context->get_guest_pgd = get_cr3;
+	context->get_guest_pgd = get_guest_cr3;
 	context->get_pdptr = kvm_pdptr_read;
 	context->inject_page_fault = kvm_inject_page_fault;
 
@@ -5235,7 +5266,7 @@ static void init_kvm_softmmu(struct kvm_vcpu *vcpu,
 
 	kvm_init_shadow_mmu(vcpu, cpu_role);
 
-	context->get_guest_pgd     = get_cr3;
+	context->get_guest_pgd     = get_guest_cr3;
 	context->get_pdptr         = kvm_pdptr_read;
 	context->inject_page_fault = kvm_inject_page_fault;
 }
@@ -5249,7 +5280,7 @@ static void init_kvm_nested_mmu(struct kvm_vcpu *vcpu,
 		return;
 
 	g_context->cpu_role.as_u64   = new_mode.as_u64;
-	g_context->get_guest_pgd     = get_cr3;
+	g_context->get_guest_pgd     = get_guest_cr3;
 	g_context->get_pdptr         = kvm_pdptr_read;
 	g_context->inject_page_fault = kvm_inject_page_fault;
 
@@ -5719,6 +5750,9 @@ void kvm_configure_mmu(bool enable_tdp, int tdp_forced_root_level,
 	tdp_root_level = tdp_forced_root_level;
 	max_tdp_level = tdp_max_root_level;
 
+#ifdef CONFIG_X86_64
+	tdp_mmu_enabled = tdp_mmu_allowed && tdp_enabled;
+#endif
 	/*
 	 * max_huge_page_level reflects KVM's MMU capabilities irrespective
 	 * of kernel support, e.g. KVM may be capable of using 1GB pages when
@@ -5966,7 +6000,7 @@ static void kvm_mmu_zap_all_fast(struct kvm *kvm)
 	 * write and in the same critical section as making the reload request,
 	 * e.g. before kvm_zap_obsolete_pages() could drop mmu_lock and yield.
 	 */
-	if (is_tdp_mmu_enabled(kvm))
+	if (tdp_mmu_enabled)
 		kvm_tdp_mmu_invalidate_all_roots(kvm);
 
 	/*
@@ -5991,7 +6025,7 @@ static void kvm_mmu_zap_all_fast(struct kvm *kvm)
 	 * Deferring the zap until the final reference to the root is put would
 	 * lead to use-after-free.
 	 */
-	if (is_tdp_mmu_enabled(kvm))
+	if (tdp_mmu_enabled)
 		kvm_tdp_mmu_zap_invalidated_roots(kvm);
 }
 
@@ -6017,9 +6051,11 @@ int kvm_mmu_init_vm(struct kvm *kvm)
 	INIT_LIST_HEAD(&kvm->arch.possible_nx_huge_pages);
 	spin_lock_init(&kvm->arch.mmu_unsync_pages_lock);
 
-	r = kvm_mmu_init_tdp_mmu(kvm);
-	if (r < 0)
-		return r;
+	if (tdp_mmu_enabled) {
+		r = kvm_mmu_init_tdp_mmu(kvm);
+		if (r < 0)
+			return r;
+	}
 
 	node->track_write = kvm_mmu_pte_write;
 	node->track_flush_slot = kvm_mmu_invalidate_zap_pages_in_memslot;
@@ -6049,7 +6085,8 @@ void kvm_mmu_uninit_vm(struct kvm *kvm)
 
 	kvm_page_track_unregister_notifier(kvm, node);
 
-	kvm_mmu_uninit_tdp_mmu(kvm);
+	if (tdp_mmu_enabled)
+		kvm_mmu_uninit_tdp_mmu(kvm);
 
 	mmu_free_vm_memory_caches(kvm);
 }
@@ -6103,7 +6140,7 @@ void kvm_zap_gfn_range(struct kvm *kvm, gfn_t gfn_start, gfn_t gfn_end)
 
 	flush = kvm_rmap_zap_gfn_range(kvm, gfn_start, gfn_end);
 
-	if (is_tdp_mmu_enabled(kvm)) {
+	if (tdp_mmu_enabled) {
 		for (i = 0; i < KVM_ADDRESS_SPACE_NUM; i++)
 			flush = kvm_tdp_mmu_zap_leafs(kvm, i, gfn_start,
 						      gfn_end, true, flush);
@@ -6136,7 +6173,7 @@ void kvm_mmu_slot_remove_write_access(struct kvm *kvm,
 		write_unlock(&kvm->mmu_lock);
 	}
 
-	if (is_tdp_mmu_enabled(kvm)) {
+	if (tdp_mmu_enabled) {
 		read_lock(&kvm->mmu_lock);
 		kvm_tdp_mmu_wrprot_slot(kvm, memslot, start_level);
 		read_unlock(&kvm->mmu_lock);
@@ -6379,7 +6416,7 @@ void kvm_mmu_try_split_huge_pages(struct kvm *kvm,
 				   u64 start, u64 end,
 				   int target_level)
 {
-	if (!is_tdp_mmu_enabled(kvm))
+	if (!tdp_mmu_enabled)
 		return;
 
 	if (kvm_memslots_have_rmaps(kvm))
@@ -6400,7 +6437,7 @@ void kvm_mmu_slot_try_split_huge_pages(struct kvm *kvm,
 	u64 start = memslot->base_gfn;
 	u64 end = start + memslot->npages;
 
-	if (!is_tdp_mmu_enabled(kvm))
+	if (!tdp_mmu_enabled)
 		return;
 
 	if (kvm_memslots_have_rmaps(kvm)) {
@@ -6483,7 +6520,7 @@ void kvm_mmu_zap_collapsible_sptes(struct kvm *kvm,
 		write_unlock(&kvm->mmu_lock);
 	}
 
-	if (is_tdp_mmu_enabled(kvm)) {
+	if (tdp_mmu_enabled) {
 		read_lock(&kvm->mmu_lock);
 		kvm_tdp_mmu_zap_collapsible_sptes(kvm, slot);
 		read_unlock(&kvm->mmu_lock);
@@ -6518,7 +6555,7 @@ void kvm_mmu_slot_leaf_clear_dirty(struct kvm *kvm,
 		write_unlock(&kvm->mmu_lock);
 	}
 
-	if (is_tdp_mmu_enabled(kvm)) {
+	if (tdp_mmu_enabled) {
 		read_lock(&kvm->mmu_lock);
 		kvm_tdp_mmu_clear_dirty_slot(kvm, memslot);
 		read_unlock(&kvm->mmu_lock);
@@ -6553,7 +6590,7 @@ void kvm_mmu_zap_all(struct kvm *kvm)
 
 	kvm_mmu_commit_zap_page(kvm, &invalid_list);
 
-	if (is_tdp_mmu_enabled(kvm))
+	if (tdp_mmu_enabled)
 		kvm_tdp_mmu_zap_all(kvm);
 
 	write_unlock(&kvm->mmu_lock);
@@ -6718,6 +6755,13 @@ void __init kvm_mmu_x86_module_init(void)
 	if (nx_huge_pages == -1)
 		__set_nx_huge_pages(get_nx_auto_mode());
 
+	/*
+	 * Snapshot userspace's desire to enable the TDP MMU. Whether or not the
+	 * TDP MMU is actually enabled is determined in kvm_configure_mmu()
+	 * when the vendor module is loaded.
+	 */
+	tdp_mmu_allowed = tdp_mmu_enabled;
+
 	kvm_mmu_spte_module_init();
 }
 
diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
index 0f6455072055..89b19b7ef4f9 100644
--- a/arch/x86/kvm/mmu/paging_tmpl.h
+++ b/arch/x86/kvm/mmu/paging_tmpl.h
@@ -324,7 +324,7 @@ static int FNAME(walk_addr_generic)(struct guest_walker *walker,
 	trace_kvm_mmu_pagetable_walk(addr, access);
 retry_walk:
 	walker->level = mmu->cpu_role.base.level;
-	pte           = mmu->get_guest_pgd(vcpu);
+	pte           = kvm_mmu_get_guest_pgd(vcpu, mmu);
 	have_ad       = PT_HAVE_ACCESSED_DIRTY(mmu);
 
 #if PTTYPE == 64
diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index d6df38d371a0..c649a333792b 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -10,23 +10,15 @@
 #include <asm/cmpxchg.h>
 #include <trace/events/kvm.h>
 
-static bool __read_mostly tdp_mmu_enabled = true;
-module_param_named(tdp_mmu, tdp_mmu_enabled, bool, 0644);
-
 /* Initializes the TDP MMU for the VM, if enabled. */
 int kvm_mmu_init_tdp_mmu(struct kvm *kvm)
 {
 	struct workqueue_struct *wq;
 
-	if (!tdp_enabled || !READ_ONCE(tdp_mmu_enabled))
-		return 0;
-
 	wq = alloc_workqueue("kvm", WQ_UNBOUND|WQ_MEM_RECLAIM|WQ_CPU_INTENSIVE, 0);
 	if (!wq)
 		return -ENOMEM;
 
-	/* This should not be changed for the lifetime of the VM. */
-	kvm->arch.tdp_mmu_enabled = true;
 	INIT_LIST_HEAD(&kvm->arch.tdp_mmu_roots);
 	spin_lock_init(&kvm->arch.tdp_mmu_pages_lock);
 	kvm->arch.tdp_mmu_zap_wq = wq;
@@ -47,10 +39,17 @@ static __always_inline bool kvm_lockdep_assert_mmu_lock_held(struct kvm *kvm,
 
 void kvm_mmu_uninit_tdp_mmu(struct kvm *kvm)
 {
-	if (!kvm->arch.tdp_mmu_enabled)
-		return;
+	/*
+	 * Invalidate all roots, which besides the obvious, schedules all roots
+	 * for zapping and thus puts the TDP MMU's reference to each root, i.e.
+	 * ultimately frees all roots.
+	 */
+	kvm_tdp_mmu_invalidate_all_roots(kvm);
 
-	/* Also waits for any queued work items.  */
+	/*
+	 * Destroying a workqueue also first flushes the workqueue, i.e. no
+	 * need to invoke kvm_tdp_mmu_zap_invalidated_roots().
+	 */
 	destroy_workqueue(kvm->arch.tdp_mmu_zap_wq);
 
 	WARN_ON(atomic64_read(&kvm->arch.tdp_mmu_pages));
@@ -126,16 +125,6 @@ static void tdp_mmu_schedule_zap_root(struct kvm *kvm, struct kvm_mmu_page *root
 	queue_work(kvm->arch.tdp_mmu_zap_wq, &root->tdp_mmu_async_work);
 }
 
-static inline bool kvm_tdp_root_mark_invalid(struct kvm_mmu_page *page)
-{
-	union kvm_mmu_page_role role = page->role;
-	role.invalid = true;
-
-	/* No need to use cmpxchg, only the invalid bit can change.  */
-	role.word = xchg(&page->role.word, role.word);
-	return role.invalid;
-}
-
 void kvm_tdp_mmu_put_root(struct kvm *kvm, struct kvm_mmu_page *root,
 			  bool shared)
 {
@@ -144,45 +133,12 @@ void kvm_tdp_mmu_put_root(struct kvm *kvm, struct kvm_mmu_page *root,
 	if (!refcount_dec_and_test(&root->tdp_mmu_root_count))
 		return;
 
-	WARN_ON(!root->tdp_mmu_page);
-
 	/*
-	 * The root now has refcount=0.  It is valid, but readers already
-	 * cannot acquire a reference to it because kvm_tdp_mmu_get_root()
-	 * rejects it.  This remains true for the rest of the execution
-	 * of this function, because readers visit valid roots only
-	 * (except for tdp_mmu_zap_root_work(), which however
-	 * does not acquire any reference itself).
-	 *
-	 * Even though there are flows that need to visit all roots for
-	 * correctness, they all take mmu_lock for write, so they cannot yet
-	 * run concurrently. The same is true after kvm_tdp_root_mark_invalid,
-	 * since the root still has refcount=0.
-	 *
-	 * However, tdp_mmu_zap_root can yield, and writers do not expect to
-	 * see refcount=0 (see for example kvm_tdp_mmu_invalidate_all_roots()).
-	 * So the root temporarily gets an extra reference, going to refcount=1
-	 * while staying invalid.  Readers still cannot acquire any reference;
-	 * but writers are now allowed to run if tdp_mmu_zap_root yields and
-	 * they might take an extra reference if they themselves yield.
-	 * Therefore, when the reference is given back by the worker,
-	 * there is no guarantee that the refcount is still 1.  If not, whoever
-	 * puts the last reference will free the page, but they will not have to
-	 * zap the root because a root cannot go from invalid to valid.
+	 * The TDP MMU itself holds a reference to each root until the root is
+	 * explicitly invalidated, i.e. the final reference should be never be
+	 * put for a valid root.
 	 */
-	if (!kvm_tdp_root_mark_invalid(root)) {
-		refcount_set(&root->tdp_mmu_root_count, 1);
-
-		/*
-		 * Zapping the root in a worker is not just "nice to have";
-		 * it is required because kvm_tdp_mmu_invalidate_all_roots()
-		 * skips already-invalid roots.  If kvm_tdp_mmu_put_root() did
-		 * not add the root to the workqueue, kvm_tdp_mmu_zap_all_fast()
-		 * might return with some roots not zapped yet.
-		 */
-		tdp_mmu_schedule_zap_root(kvm, root);
-		return;
-	}
+	KVM_BUG_ON(!is_tdp_mmu_page(root) || !root->role.invalid, kvm);
 
 	spin_lock(&kvm->arch.tdp_mmu_pages_lock);
 	list_del_rcu(&root->link);
@@ -330,7 +286,14 @@ hpa_t kvm_tdp_mmu_get_vcpu_root_hpa(struct kvm_vcpu *vcpu)
 	root = tdp_mmu_alloc_sp(vcpu);
 	tdp_mmu_init_sp(root, NULL, 0, role);
 
-	refcount_set(&root->tdp_mmu_root_count, 1);
+	/*
+	 * TDP MMU roots are kept until they are explicitly invalidated, either
+	 * by a memslot update or by the destruction of the VM.  Initialize the
+	 * refcount to two; one reference for the vCPU, and one reference for
+	 * the TDP MMU itself, which is held until the root is invalidated and
+	 * is ultimately put by tdp_mmu_zap_root_work().
+	 */
+	refcount_set(&root->tdp_mmu_root_count, 2);
 
 	spin_lock(&kvm->arch.tdp_mmu_pages_lock);
 	list_add_rcu(&root->link, &kvm->arch.tdp_mmu_roots);
@@ -1033,32 +996,49 @@ void kvm_tdp_mmu_zap_invalidated_roots(struct kvm *kvm)
 /*
  * Mark each TDP MMU root as invalid to prevent vCPUs from reusing a root that
  * is about to be zapped, e.g. in response to a memslots update.  The actual
- * zapping is performed asynchronously, so a reference is taken on all roots.
- * Using a separate workqueue makes it easy to ensure that the destruction is
- * performed before the "fast zap" completes, without keeping a separate list
- * of invalidated roots; the list is effectively the list of work items in
- * the workqueue.
- *
- * Get a reference even if the root is already invalid, the asynchronous worker
- * assumes it was gifted a reference to the root it processes.  Because mmu_lock
- * is held for write, it should be impossible to observe a root with zero refcount,
- * i.e. the list of roots cannot be stale.
+ * zapping is performed asynchronously.  Using a separate workqueue makes it
+ * easy to ensure that the destruction is performed before the "fast zap"
+ * completes, without keeping a separate list of invalidated roots; the list is
+ * effectively the list of work items in the workqueue.
  *
- * This has essentially the same effect for the TDP MMU
- * as updating mmu_valid_gen does for the shadow MMU.
+ * Note, the asynchronous worker is gifted the TDP MMU's reference.
+ * See kvm_tdp_mmu_get_vcpu_root_hpa().
  */
 void kvm_tdp_mmu_invalidate_all_roots(struct kvm *kvm)
 {
 	struct kvm_mmu_page *root;
 
-	lockdep_assert_held_write(&kvm->mmu_lock);
-	list_for_each_entry(root, &kvm->arch.tdp_mmu_roots, link) {
-		if (!root->role.invalid &&
-		    !WARN_ON_ONCE(!kvm_tdp_mmu_get_root(root))) {
+	/*
+	 * mmu_lock must be held for write to ensure that a root doesn't become
+	 * invalid while there are active readers (invalidating a root while
+	 * there are active readers may or may not be problematic in practice,
+	 * but it's uncharted territory and not supported).
+	 *
+	 * Waive the assertion if there are no users of @kvm, i.e. the VM is
+	 * being destroyed after all references have been put, or if no vCPUs
+	 * have been created (which means there are no roots), i.e. the VM is
+	 * being destroyed in an error path of KVM_CREATE_VM.
+	 */
+	if (IS_ENABLED(CONFIG_PROVE_LOCKING) &&
+	    refcount_read(&kvm->users_count) && kvm->created_vcpus)
+		lockdep_assert_held_write(&kvm->mmu_lock);
+
+	/*
+	 * As above, mmu_lock isn't held when destroying the VM!  There can't
+	 * be other references to @kvm, i.e. nothing else can invalidate roots
+	 * or be consuming roots, but walking the list of roots does need to be
+	 * guarded against roots being deleted by the asynchronous zap worker.
+	 */
+	rcu_read_lock();
+
+	list_for_each_entry_rcu(root, &kvm->arch.tdp_mmu_roots, link) {
+		if (!root->role.invalid) {
 			root->role.invalid = true;
 			tdp_mmu_schedule_zap_root(kvm, root);
 		}
 	}
+
+	rcu_read_unlock();
 }
 
 /*
diff --git a/arch/x86/kvm/mmu/tdp_mmu.h b/arch/x86/kvm/mmu/tdp_mmu.h
index d3714200b932..e4ab2dac269d 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.h
+++ b/arch/x86/kvm/mmu/tdp_mmu.h
@@ -7,6 +7,9 @@
 
 #include "spte.h"
 
+int kvm_mmu_init_tdp_mmu(struct kvm *kvm);
+void kvm_mmu_uninit_tdp_mmu(struct kvm *kvm);
+
 hpa_t kvm_tdp_mmu_get_vcpu_root_hpa(struct kvm_vcpu *vcpu);
 
 __must_check static inline bool kvm_tdp_mmu_get_root(struct kvm_mmu_page *root)
@@ -68,8 +71,6 @@ u64 *kvm_tdp_mmu_fast_pf_get_last_sptep(struct kvm_vcpu *vcpu, u64 addr,
 					u64 *spte);
 
 #ifdef CONFIG_X86_64
-int kvm_mmu_init_tdp_mmu(struct kvm *kvm);
-void kvm_mmu_uninit_tdp_mmu(struct kvm *kvm);
 static inline bool is_tdp_mmu_page(struct kvm_mmu_page *sp) { return sp->tdp_mmu_page; }
 
 static inline bool is_tdp_mmu(struct kvm_mmu *mmu)
@@ -89,8 +90,6 @@ static inline bool is_tdp_mmu(struct kvm_mmu *mmu)
 	return sp && is_tdp_mmu_page(sp) && sp->root_count;
 }
 #else
-static inline int kvm_mmu_init_tdp_mmu(struct kvm *kvm) { return 0; }
-static inline void kvm_mmu_uninit_tdp_mmu(struct kvm *kvm) {}
 static inline bool is_tdp_mmu_page(struct kvm_mmu_page *sp) { return false; }
 static inline bool is_tdp_mmu(struct kvm_mmu *mmu) { return false; }
 #endif
diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index eb594620dd75..8be583a05de7 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -438,9 +438,9 @@ int kvm_pmu_rdpmc(struct kvm_vcpu *vcpu, unsigned idx, u64 *data)
 	if (!pmc)
 		return 1;
 
-	if (!(kvm_read_cr4(vcpu) & X86_CR4_PCE) &&
+	if (!(kvm_read_cr4_bits(vcpu, X86_CR4_PCE)) &&
 	    (static_call(kvm_x86_get_cpl)(vcpu) != 0) &&
-	    (kvm_read_cr0(vcpu) & X86_CR0_PE))
+	    (kvm_read_cr0_bits(vcpu, X86_CR0_PE)))
 		return 1;
 
 	*data = pmc_read_counter(pmc) & mask;
diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index b7f2e59d50ee..579ceaf75dde 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -4488,7 +4488,7 @@ static void load_vmcs12_host_state(struct kvm_vcpu *vcpu,
 	 * CR0_GUEST_HOST_MASK is already set in the original vmcs01
 	 * (KVM doesn't change it);
 	 */
-	vcpu->arch.cr0_guest_owned_bits = KVM_POSSIBLE_CR0_GUEST_BITS;
+	vcpu->arch.cr0_guest_owned_bits = vmx_l1_guest_owned_cr0_bits();
 	vmx_set_cr0(vcpu, vmcs12->host_cr0);
 
 	/* Same as above - no reason to call set_cr4_guest_host_mask().  */
@@ -4639,7 +4639,7 @@ static void nested_vmx_restore_host_state(struct kvm_vcpu *vcpu)
 	 */
 	vmx_set_efer(vcpu, nested_vmx_get_vmcs01_guest_efer(vmx));
 
-	vcpu->arch.cr0_guest_owned_bits = KVM_POSSIBLE_CR0_GUEST_BITS;
+	vcpu->arch.cr0_guest_owned_bits = vmx_l1_guest_owned_cr0_bits();
 	vmx_set_cr0(vcpu, vmcs_readl(CR0_READ_SHADOW));
 
 	vcpu->arch.cr4_guest_owned_bits = ~vmcs_readl(CR4_GUEST_HOST_MASK);
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 53034045cb6e..57a73954980a 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -4728,7 +4728,7 @@ static void init_vmcs(struct vcpu_vmx *vmx)
 	/* 22.2.1, 20.8.1 */
 	vm_entry_controls_set(vmx, vmx_vmentry_ctrl());
 
-	vmx->vcpu.arch.cr0_guest_owned_bits = KVM_POSSIBLE_CR0_GUEST_BITS;
+	vmx->vcpu.arch.cr0_guest_owned_bits = vmx_l1_guest_owned_cr0_bits();
 	vmcs_writel(CR0_GUEST_HOST_MASK, ~vmx->vcpu.arch.cr0_guest_owned_bits);
 
 	set_cr4_guest_host_mask(vmx);
@@ -5450,7 +5450,7 @@ static int handle_cr(struct kvm_vcpu *vcpu)
 		break;
 	case 3: /* lmsw */
 		val = (exit_qualification >> LMSW_SOURCE_DATA_SHIFT) & 0x0f;
-		trace_kvm_cr_write(0, (kvm_read_cr0(vcpu) & ~0xful) | val);
+		trace_kvm_cr_write(0, (kvm_read_cr0_bits(vcpu, ~0xful) | val));
 		kvm_lmsw(vcpu, val);
 
 		return kvm_skip_emulated_instruction(vcpu);
@@ -7531,7 +7531,7 @@ static u8 vmx_get_mt_mask(struct kvm_vcpu *vcpu, gfn_t gfn, bool is_mmio)
 	if (!kvm_arch_has_noncoherent_dma(vcpu->kvm))
 		return (MTRR_TYPE_WRBACK << VMX_EPT_MT_EPTE_SHIFT) | VMX_EPT_IPAT_BIT;
 
-	if (kvm_read_cr0(vcpu) & X86_CR0_CD) {
+	if (kvm_read_cr0_bits(vcpu, X86_CR0_CD)) {
 		if (kvm_check_has_quirk(vcpu->kvm, KVM_X86_QUIRK_CD_NW_CLEARED))
 			cache = MTRR_TYPE_WRBACK;
 		else
diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
index a3da84f4ea45..e2b04f4c0fef 100644
--- a/arch/x86/kvm/vmx/vmx.h
+++ b/arch/x86/kvm/vmx/vmx.h
@@ -640,6 +640,24 @@ BUILD_CONTROLS_SHADOW(tertiary_exec, TERTIARY_VM_EXEC_CONTROL, 64)
 				(1 << VCPU_EXREG_EXIT_INFO_1) | \
 				(1 << VCPU_EXREG_EXIT_INFO_2))
 
+static inline unsigned long vmx_l1_guest_owned_cr0_bits(void)
+{
+	unsigned long bits = KVM_POSSIBLE_CR0_GUEST_BITS;
+
+	/*
+	 * CR0.WP needs to be intercepted when KVM is shadowing legacy paging
+	 * in order to construct shadow PTEs with the correct protections.
+	 * Note!  CR0.WP technically can be passed through to the guest if
+	 * paging is disabled, but checking CR0.PG would generate a cyclical
+	 * dependency of sorts due to forcing the caller to ensure CR0 holds
+	 * the correct value prior to determining which CR0 bits can be owned
+	 * by L1.  Keep it simple and limit the optimization to EPT.
+	 */
+	if (!enable_ept)
+		bits &= ~X86_CR0_WP;
+	return bits;
+}
+
 static inline struct kvm_vmx *to_kvm_vmx(struct kvm *kvm)
 {
 	return container_of(kvm, struct kvm_vmx, kvm);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 2d76c254582b..35cd87a326ac 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -904,6 +904,18 @@ EXPORT_SYMBOL_GPL(load_pdptrs);
 
 void kvm_post_set_cr0(struct kvm_vcpu *vcpu, unsigned long old_cr0, unsigned long cr0)
 {
+	/*
+	 * CR0.WP is incorporated into the MMU role, but only for non-nested,
+	 * indirect shadow MMUs.  If TDP is enabled, the MMU's metadata needs
+	 * to be updated, e.g. so that emulating guest translations does the
+	 * right thing, but there's no need to unload the root as CR0.WP
+	 * doesn't affect SPTEs.
+	 */
+	if (tdp_enabled && (cr0 ^ old_cr0) == X86_CR0_WP) {
+		kvm_init_mmu(vcpu);
+		return;
+	}
+
 	if ((cr0 ^ old_cr0) & X86_CR0_PG) {
 		kvm_clear_async_pf_completion_queue(vcpu);
 		kvm_async_pf_hash_reset(vcpu);
diff --git a/arch/x86/lib/clear_page_64.S b/arch/x86/lib/clear_page_64.S
index ecbfb4dd3b01..faa4cdc747a3 100644
--- a/arch/x86/lib/clear_page_64.S
+++ b/arch/x86/lib/clear_page_64.S
@@ -142,8 +142,8 @@ SYM_FUNC_START(clear_user_rep_good)
 	and $7, %edx
 	jz .Lrep_good_exit
 
-.Lrep_good_bytes:
 	mov %edx, %ecx
+.Lrep_good_bytes:
 	rep stosb
 
 .Lrep_good_exit:
diff --git a/arch/x86/lib/retpoline.S b/arch/x86/lib/retpoline.S
index 5f61c65322be..22fc313c6500 100644
--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -144,8 +144,8 @@ SYM_CODE_END(__x86_indirect_jump_thunk_array)
  */
 	.align 64
 	.skip 63, 0xcc
-SYM_FUNC_START_NOALIGN(zen_untrain_ret);
-
+SYM_START(zen_untrain_ret, SYM_L_GLOBAL, SYM_A_NONE)
+	ANNOTATE_NOENDBR
 	/*
 	 * As executed from zen_untrain_ret, this is:
 	 *
diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 9ac1efb053e0..2d8a28e4e22f 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -501,6 +501,9 @@ static void blkg_destroy_all(struct gendisk *disk)
 	list_for_each_entry_safe(blkg, n, &q->blkg_list, q_node) {
 		struct blkcg *blkcg = blkg->blkcg;
 
+		if (hlist_unhashed(&blkg->blkcg_node))
+			continue;
+
 		spin_lock(&blkcg->lock);
 		blkg_destroy(blkg);
 		spin_unlock(&blkcg->lock);
diff --git a/crypto/algapi.c b/crypto/algapi.c
index 9de0677b3643..60b98d2c400e 100644
--- a/crypto/algapi.c
+++ b/crypto/algapi.c
@@ -963,6 +963,9 @@ EXPORT_SYMBOL_GPL(crypto_enqueue_request);
 void crypto_enqueue_request_head(struct crypto_queue *queue,
 				 struct crypto_async_request *request)
 {
+	if (unlikely(queue->qlen >= queue->max_qlen))
+		queue->backlog = queue->backlog->prev;
+
 	queue->qlen++;
 	list_add(&request->list, &queue->list);
 }
diff --git a/crypto/crypto_engine.c b/crypto/crypto_engine.c
index bb8e77077f02..50bac2ab55f1 100644
--- a/crypto/crypto_engine.c
+++ b/crypto/crypto_engine.c
@@ -54,7 +54,7 @@ static void crypto_finalize_request(struct crypto_engine *engine,
 		}
 	}
 	lockdep_assert_in_softirq();
-	req->complete(req, err);
+	crypto_request_complete(req, err);
 
 	kthread_queue_work(engine->kworker, &engine->pump_requests);
 }
@@ -129,9 +129,6 @@ static void crypto_pump_requests(struct crypto_engine *engine,
 	if (!engine->retry_support)
 		engine->cur_req = async_req;
 
-	if (backlog)
-		backlog->complete(backlog, -EINPROGRESS);
-
 	if (engine->busy)
 		was_busy = true;
 	else
@@ -214,9 +211,12 @@ static void crypto_pump_requests(struct crypto_engine *engine,
 	}
 
 req_err_2:
-	async_req->complete(async_req, ret);
+	crypto_request_complete(async_req, ret);
 
 retry:
+	if (backlog)
+		crypto_request_complete(backlog, -EINPROGRESS);
+
 	/* If retry mechanism is supported, send new requests to engine */
 	if (engine->retry_support) {
 		spin_lock_irqsave(&engine->queue_lock, flags);
diff --git a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-cipher.c b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-cipher.c
index 902f6be057ec..e97fb203690a 100644
--- a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-cipher.c
+++ b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-cipher.c
@@ -151,7 +151,7 @@ static int sun8i_ss_setup_ivs(struct skcipher_request *areq)
 		}
 		rctx->p_iv[i] = a;
 		/* we need to setup all others IVs only in the decrypt way */
-		if (rctx->op_dir & SS_ENCRYPTION)
+		if (rctx->op_dir == SS_ENCRYPTION)
 			return 0;
 		todo = min(len, sg_dma_len(sg));
 		len -= todo;
diff --git a/drivers/crypto/ccp/psp-dev.c b/drivers/crypto/ccp/psp-dev.c
index c9c741ac8442..949a3fa0b94a 100644
--- a/drivers/crypto/ccp/psp-dev.c
+++ b/drivers/crypto/ccp/psp-dev.c
@@ -42,6 +42,9 @@ static irqreturn_t psp_irq_handler(int irq, void *data)
 	/* Read the interrupt status: */
 	status = ioread32(psp->io_regs + psp->vdata->intsts_reg);
 
+	/* Clear the interrupt status by writing the same value we read. */
+	iowrite32(status, psp->io_regs + psp->vdata->intsts_reg);
+
 	/* invoke subdevice interrupt handlers */
 	if (status) {
 		if (psp->sev_irq_handler)
@@ -51,9 +54,6 @@ static irqreturn_t psp_irq_handler(int irq, void *data)
 			psp->tee_irq_handler(irq, psp->tee_irq_data, status);
 	}
 
-	/* Clear the interrupt status by writing the same value we read. */
-	iowrite32(status, psp->io_regs + psp->vdata->intsts_reg);
-
 	return IRQ_HANDLED;
 }
 
diff --git a/drivers/edac/qcom_edac.c b/drivers/edac/qcom_edac.c
index c45519f59dc1..2c91ceff8a9c 100644
--- a/drivers/edac/qcom_edac.c
+++ b/drivers/edac/qcom_edac.c
@@ -76,6 +76,8 @@
 #define DRP0_INTERRUPT_ENABLE           BIT(6)
 #define SB_DB_DRP_INTERRUPT_ENABLE      0x3
 
+#define ECC_POLL_MSEC			5000
+
 enum {
 	LLCC_DRAM_CE = 0,
 	LLCC_DRAM_UE,
@@ -285,8 +287,7 @@ dump_syn_reg(struct edac_device_ctl_info *edev_ctl, int err_type, u32 bank)
 	return ret;
 }
 
-static irqreturn_t
-llcc_ecc_irq_handler(int irq, void *edev_ctl)
+static irqreturn_t llcc_ecc_irq_handler(int irq, void *edev_ctl)
 {
 	struct edac_device_ctl_info *edac_dev_ctl = edev_ctl;
 	struct llcc_drv_data *drv = edac_dev_ctl->dev->platform_data;
@@ -332,6 +333,11 @@ llcc_ecc_irq_handler(int irq, void *edev_ctl)
 	return irq_rc;
 }
 
+static void llcc_ecc_check(struct edac_device_ctl_info *edev_ctl)
+{
+	llcc_ecc_irq_handler(0, edev_ctl);
+}
+
 static int qcom_llcc_edac_probe(struct platform_device *pdev)
 {
 	struct llcc_drv_data *llcc_driv_data = pdev->dev.platform_data;
@@ -359,29 +365,31 @@ static int qcom_llcc_edac_probe(struct platform_device *pdev)
 	edev_ctl->ctl_name = "llcc";
 	edev_ctl->panic_on_ue = LLCC_ERP_PANIC_ON_UE;
 
-	rc = edac_device_add_device(edev_ctl);
-	if (rc)
-		goto out_mem;
-
-	platform_set_drvdata(pdev, edev_ctl);
-
-	/* Request for ecc irq */
+	/* Check if LLCC driver has passed ECC IRQ */
 	ecc_irq = llcc_driv_data->ecc_irq;
-	if (ecc_irq < 0) {
-		rc = -ENODEV;
-		goto out_dev;
-	}
-	rc = devm_request_irq(dev, ecc_irq, llcc_ecc_irq_handler,
+	if (ecc_irq > 0) {
+		/* Use interrupt mode if IRQ is available */
+		rc = devm_request_irq(dev, ecc_irq, llcc_ecc_irq_handler,
 			      IRQF_TRIGGER_HIGH, "llcc_ecc", edev_ctl);
-	if (rc)
-		goto out_dev;
+		if (!rc) {
+			edac_op_state = EDAC_OPSTATE_INT;
+			goto irq_done;
+		}
+	}
 
-	return rc;
+	/* Fall back to polling mode otherwise */
+	edev_ctl->poll_msec = ECC_POLL_MSEC;
+	edev_ctl->edac_check = llcc_ecc_check;
+	edac_op_state = EDAC_OPSTATE_POLL;
 
-out_dev:
-	edac_device_del_device(edev_ctl->dev);
-out_mem:
-	edac_device_free_ctl_info(edev_ctl);
+irq_done:
+	rc = edac_device_add_device(edev_ctl);
+	if (rc) {
+		edac_device_free_ctl_info(edev_ctl);
+		return rc;
+	}
+
+	platform_set_drvdata(pdev, edev_ctl);
 
 	return rc;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 7af3041ccd0e..40e8da85f04f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -1274,7 +1274,7 @@ static int amdgpu_cs_submit(struct amdgpu_cs_parser *p,
 		r = drm_sched_job_add_dependency(&leader->base, fence);
 		if (r) {
 			dma_fence_put(fence);
-			goto error_cleanup;
+			return r;
 		}
 	}
 
@@ -1301,7 +1301,8 @@ static int amdgpu_cs_submit(struct amdgpu_cs_parser *p,
 	}
 	if (r) {
 		r = -EAGAIN;
-		goto error_unlock;
+		mutex_unlock(&p->adev->notifier_lock);
+		return r;
 	}
 
 	p->fence = dma_fence_get(&leader->base.s_fence->finished);
@@ -1348,14 +1349,6 @@ static int amdgpu_cs_submit(struct amdgpu_cs_parser *p,
 	mutex_unlock(&p->adev->notifier_lock);
 	mutex_unlock(&p->bo_list->bo_list_mutex);
 	return 0;
-
-error_unlock:
-	mutex_unlock(&p->adev->notifier_lock);
-
-error_cleanup:
-	for (i = 0; i < p->gang_size; ++i)
-		drm_sched_job_cleanup(&p->jobs[i]->base);
-	return r;
 }
 
 /* Cleanup the parser structure */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 533263d44265..8a14202f8613 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4503,7 +4503,11 @@ static int amdgpu_device_recover_vram(struct amdgpu_device *adev)
 	dev_info(adev->dev, "recover vram bo from shadow start\n");
 	mutex_lock(&adev->shadow_list_lock);
 	list_for_each_entry(vmbo, &adev->shadow_list, shadow_list) {
-		shadow = &vmbo->bo;
+		/* If vm is compute context or adev is APU, shadow will be NULL */
+		if (!vmbo->shadow)
+			continue;
+		shadow = vmbo->shadow;
+
 		/* No need to recover an evicted BO */
 		if (shadow->tbo.resource->mem_type != TTM_PL_TT ||
 		    shadow->tbo.resource->start == AMDGPU_BO_INVALID_OFFSET ||
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index 0c546245793b..82e27bd4f038 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -21,6 +21,8 @@
  *
  */
 
+#include <linux/firmware.h>
+
 #include "amdgpu_mes.h"
 #include "amdgpu.h"
 #include "soc15_common.h"
@@ -1423,3 +1425,60 @@ int amdgpu_mes_self_test(struct amdgpu_device *adev)
 	kfree(vm);
 	return 0;
 }
+
+int amdgpu_mes_init_microcode(struct amdgpu_device *adev, int pipe)
+{
+	const struct mes_firmware_header_v1_0 *mes_hdr;
+	struct amdgpu_firmware_info *info;
+	char ucode_prefix[30];
+	char fw_name[40];
+	int r;
+
+	amdgpu_ucode_ip_version_decode(adev, GC_HWIP, ucode_prefix, sizeof(ucode_prefix));
+	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mes%s.bin",
+		ucode_prefix,
+		pipe == AMDGPU_MES_SCHED_PIPE ? "" : "1");
+	r = amdgpu_ucode_request(adev, &adev->mes.fw[pipe], fw_name);
+	if (r)
+		goto out;
+
+	mes_hdr = (const struct mes_firmware_header_v1_0 *)
+		adev->mes.fw[pipe]->data;
+	adev->mes.uc_start_addr[pipe] =
+		le32_to_cpu(mes_hdr->mes_uc_start_addr_lo) |
+		((uint64_t)(le32_to_cpu(mes_hdr->mes_uc_start_addr_hi)) << 32);
+	adev->mes.data_start_addr[pipe] =
+		le32_to_cpu(mes_hdr->mes_data_start_addr_lo) |
+		((uint64_t)(le32_to_cpu(mes_hdr->mes_data_start_addr_hi)) << 32);
+
+	if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
+		int ucode, ucode_data;
+
+		if (pipe == AMDGPU_MES_SCHED_PIPE) {
+			ucode = AMDGPU_UCODE_ID_CP_MES;
+			ucode_data = AMDGPU_UCODE_ID_CP_MES_DATA;
+		} else {
+			ucode = AMDGPU_UCODE_ID_CP_MES1;
+			ucode_data = AMDGPU_UCODE_ID_CP_MES1_DATA;
+		}
+
+		info = &adev->firmware.ucode[ucode];
+		info->ucode_id = ucode;
+		info->fw = adev->mes.fw[pipe];
+		adev->firmware.fw_size +=
+			ALIGN(le32_to_cpu(mes_hdr->mes_ucode_size_bytes),
+			      PAGE_SIZE);
+
+		info = &adev->firmware.ucode[ucode_data];
+		info->ucode_id = ucode_data;
+		info->fw = adev->mes.fw[pipe];
+		adev->firmware.fw_size +=
+			ALIGN(le32_to_cpu(mes_hdr->mes_ucode_data_size_bytes),
+			      PAGE_SIZE);
+	}
+
+	return 0;
+out:
+	amdgpu_ucode_release(&adev->mes.fw[pipe]);
+	return r;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
index 97c05d08a551..547ec35691fa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -306,6 +306,7 @@ struct amdgpu_mes_funcs {
 
 int amdgpu_mes_ctx_get_offs(struct amdgpu_ring *ring, unsigned int id_offs);
 
+int amdgpu_mes_init_microcode(struct amdgpu_device *adev, int pipe);
 int amdgpu_mes_init(struct amdgpu_device *adev);
 void amdgpu_mes_fini(struct amdgpu_device *adev);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c
index e9b45089a28a..863b2a34b2d6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c
@@ -38,6 +38,7 @@ static int amdgpu_sched_process_priority_override(struct amdgpu_device *adev,
 {
 	struct fd f = fdget(fd);
 	struct amdgpu_fpriv *fpriv;
+	struct amdgpu_ctx_mgr *mgr;
 	struct amdgpu_ctx *ctx;
 	uint32_t id;
 	int r;
@@ -51,8 +52,11 @@ static int amdgpu_sched_process_priority_override(struct amdgpu_device *adev,
 		return r;
 	}
 
-	idr_for_each_entry(&fpriv->ctx_mgr.ctx_handles, ctx, id)
+	mgr = &fpriv->ctx_mgr;
+	mutex_lock(&mgr->lock);
+	idr_for_each_entry(&mgr->ctx_handles, ctx, id)
 		amdgpu_ctx_priority_override(ctx, priority);
+	mutex_unlock(&mgr->lock);
 
 	fdput(f);
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
index 5cb62e6249c2..6e7058a2d1c8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
@@ -1091,3 +1091,39 @@ void amdgpu_ucode_ip_version_decode(struct amdgpu_device *adev, int block_type,
 
 	snprintf(ucode_prefix, len, "%s_%d_%d_%d", ip_name, maj, min, rev);
 }
+
+/*
+ * amdgpu_ucode_request - Fetch and validate amdgpu microcode
+ *
+ * @adev: amdgpu device
+ * @fw: pointer to load firmware to
+ * @fw_name: firmware to load
+ *
+ * This is a helper that will use request_firmware and amdgpu_ucode_validate
+ * to load and run basic validation on firmware. If the load fails, remap
+ * the error code to -ENODEV, so that early_init functions will fail to load.
+ */
+int amdgpu_ucode_request(struct amdgpu_device *adev, const struct firmware **fw,
+			 const char *fw_name)
+{
+	int err = request_firmware(fw, fw_name, adev->dev);
+
+	if (err)
+		return -ENODEV;
+	err = amdgpu_ucode_validate(*fw);
+	if (err)
+		dev_dbg(adev->dev, "\"%s\" failed to validate\n", fw_name);
+
+	return err;
+}
+
+/*
+ * amdgpu_ucode_release - Release firmware microcode
+ *
+ * @fw: pointer to firmware to release
+ */
+void amdgpu_ucode_release(const struct firmware **fw)
+{
+	release_firmware(*fw);
+	*fw = NULL;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
index 552e06929229..848579d4988b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
@@ -544,6 +544,9 @@ void amdgpu_ucode_print_sdma_hdr(const struct common_firmware_header *hdr);
 void amdgpu_ucode_print_psp_hdr(const struct common_firmware_header *hdr);
 void amdgpu_ucode_print_gpu_info_hdr(const struct common_firmware_header *hdr);
 int amdgpu_ucode_validate(const struct firmware *fw);
+int amdgpu_ucode_request(struct amdgpu_device *adev, const struct firmware **fw,
+			 const char *fw_name);
+void amdgpu_ucode_release(const struct firmware **fw);
 bool amdgpu_ucode_hdr_version(union amdgpu_firmware_header *hdr,
 				uint16_t hdr_major, uint16_t hdr_minor);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 5dde6f82a1ca..849a2cb191b4 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -3845,7 +3845,8 @@ static int gfx_v9_0_hw_fini(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
-	amdgpu_irq_put(adev, &adev->gfx.cp_ecc_error_irq, 0);
+	if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__GFX))
+		amdgpu_irq_put(adev, &adev->gfx.cp_ecc_error_irq, 0);
 	amdgpu_irq_put(adev, &adev->gfx.priv_reg_irq, 0);
 	amdgpu_irq_put(adev, &adev->gfx.priv_inst_irq, 0);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 21e46817d82d..d8cb92a8cef8 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -1145,7 +1145,6 @@ static int gmc_v10_0_hw_fini(void *handle)
 		return 0;
 	}
 
-	amdgpu_irq_put(adev, &adev->gmc.ecc_irq, 0);
 	amdgpu_irq_put(adev, &adev->gmc.vm_fault, 0);
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index 4326078689cd..9760d7becde2 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -941,7 +941,6 @@ static int gmc_v11_0_hw_fini(void *handle)
 		return 0;
 	}
 
-	amdgpu_irq_put(adev, &adev->gmc.ecc_irq, 0);
 	amdgpu_irq_put(adev, &adev->gmc.vm_fault, 0);
 	gmc_v11_0_gart_disable(adev);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 08d6cf79fb15..c9948f78b2ba 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1963,7 +1963,6 @@ static int gmc_v9_0_hw_fini(void *handle)
 	if (adev->mmhub.funcs->update_power_gating)
 		adev->mmhub.funcs->update_power_gating(adev, false);
 
-	amdgpu_irq_put(adev, &adev->gmc.ecc_irq, 0);
 	amdgpu_irq_put(adev, &adev->gmc.vm_fault, 0);
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
index a1b751d9ac06..323d68b2124f 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
@@ -54,6 +54,7 @@ static int jpeg_v3_0_early_init(void *handle)
 
 	switch (adev->ip_versions[UVD_HWIP][0]) {
 	case IP_VERSION(3, 1, 1):
+	case IP_VERSION(3, 1, 2):
 		break;
 	default:
 		harvest = RREG32_SOC15(JPEG, 0, mmCC_UVD_HARVESTING);
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c b/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
index 614394118a53..7848b9de79ce 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
@@ -379,89 +379,6 @@ static const struct amdgpu_mes_funcs mes_v10_1_funcs = {
 	.resume_gang = mes_v10_1_resume_gang,
 };
 
-static int mes_v10_1_init_microcode(struct amdgpu_device *adev,
-				    enum admgpu_mes_pipe pipe)
-{
-	const char *chip_name;
-	char fw_name[30];
-	int err;
-	const struct mes_firmware_header_v1_0 *mes_hdr;
-	struct amdgpu_firmware_info *info;
-
-	switch (adev->ip_versions[GC_HWIP][0]) {
-	case IP_VERSION(10, 1, 10):
-		chip_name = "navi10";
-		break;
-	case IP_VERSION(10, 3, 0):
-		chip_name = "sienna_cichlid";
-		break;
-	default:
-		BUG();
-	}
-
-	if (pipe == AMDGPU_MES_SCHED_PIPE)
-		snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mes.bin",
-			 chip_name);
-	else
-		snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mes1.bin",
-			 chip_name);
-
-	err = request_firmware(&adev->mes.fw[pipe], fw_name, adev->dev);
-	if (err)
-		return err;
-
-	err = amdgpu_ucode_validate(adev->mes.fw[pipe]);
-	if (err) {
-		release_firmware(adev->mes.fw[pipe]);
-		adev->mes.fw[pipe] = NULL;
-		return err;
-	}
-
-	mes_hdr = (const struct mes_firmware_header_v1_0 *)
-		adev->mes.fw[pipe]->data;
-	adev->mes.uc_start_addr[pipe] =
-		le32_to_cpu(mes_hdr->mes_uc_start_addr_lo) |
-		((uint64_t)(le32_to_cpu(mes_hdr->mes_uc_start_addr_hi)) << 32);
-	adev->mes.data_start_addr[pipe] =
-		le32_to_cpu(mes_hdr->mes_data_start_addr_lo) |
-		((uint64_t)(le32_to_cpu(mes_hdr->mes_data_start_addr_hi)) << 32);
-
-	if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
-		int ucode, ucode_data;
-
-		if (pipe == AMDGPU_MES_SCHED_PIPE) {
-			ucode = AMDGPU_UCODE_ID_CP_MES;
-			ucode_data = AMDGPU_UCODE_ID_CP_MES_DATA;
-		} else {
-			ucode = AMDGPU_UCODE_ID_CP_MES1;
-			ucode_data = AMDGPU_UCODE_ID_CP_MES1_DATA;
-		}
-
-		info = &adev->firmware.ucode[ucode];
-		info->ucode_id = ucode;
-		info->fw = adev->mes.fw[pipe];
-		adev->firmware.fw_size +=
-			ALIGN(le32_to_cpu(mes_hdr->mes_ucode_size_bytes),
-			      PAGE_SIZE);
-
-		info = &adev->firmware.ucode[ucode_data];
-		info->ucode_id = ucode_data;
-		info->fw = adev->mes.fw[pipe];
-		adev->firmware.fw_size +=
-			ALIGN(le32_to_cpu(mes_hdr->mes_ucode_data_size_bytes),
-			      PAGE_SIZE);
-	}
-
-	return 0;
-}
-
-static void mes_v10_1_free_microcode(struct amdgpu_device *adev,
-				     enum admgpu_mes_pipe pipe)
-{
-	release_firmware(adev->mes.fw[pipe]);
-	adev->mes.fw[pipe] = NULL;
-}
-
 static int mes_v10_1_allocate_ucode_buffer(struct amdgpu_device *adev,
 					   enum admgpu_mes_pipe pipe)
 {
@@ -1019,10 +936,6 @@ static int mes_v10_1_sw_init(void *handle)
 		if (!adev->enable_mes_kiq && pipe == AMDGPU_MES_KIQ_PIPE)
 			continue;
 
-		r = mes_v10_1_init_microcode(adev, pipe);
-		if (r)
-			return r;
-
 		r = mes_v10_1_allocate_eop_buf(adev, pipe);
 		if (r)
 			return r;
@@ -1059,8 +972,7 @@ static int mes_v10_1_sw_fini(void *handle)
 		amdgpu_bo_free_kernel(&adev->mes.eop_gpu_obj[pipe],
 				      &adev->mes.eop_gpu_addr[pipe],
 				      NULL);
-
-		mes_v10_1_free_microcode(adev, pipe);
+		amdgpu_ucode_release(&adev->mes.fw[pipe]);
 	}
 
 	amdgpu_bo_free_kernel(&adev->gfx.kiq.ring.mqd_obj,
@@ -1229,6 +1141,22 @@ static int mes_v10_1_resume(void *handle)
 	return amdgpu_mes_resume(adev);
 }
 
+static int mes_v10_0_early_init(void *handle)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	int pipe, r;
+
+	for (pipe = 0; pipe < AMDGPU_MAX_MES_PIPES; pipe++) {
+		if (!adev->enable_mes_kiq && pipe == AMDGPU_MES_KIQ_PIPE)
+			continue;
+		r = amdgpu_mes_init_microcode(adev, pipe);
+		if (r)
+			return r;
+	}
+
+	return 0;
+}
+
 static int mes_v10_0_late_init(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
@@ -1241,6 +1169,7 @@ static int mes_v10_0_late_init(void *handle)
 
 static const struct amd_ip_funcs mes_v10_1_ip_funcs = {
 	.name = "mes_v10_1",
+	.early_init = mes_v10_0_early_init,
 	.late_init = mes_v10_0_late_init,
 	.sw_init = mes_v10_1_sw_init,
 	.sw_fini = mes_v10_1_sw_fini,
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index 1c4787000a5f..03844a82462f 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -460,80 +460,6 @@ static const struct amdgpu_mes_funcs mes_v11_0_funcs = {
 	.misc_op = mes_v11_0_misc_op,
 };
 
-static int mes_v11_0_init_microcode(struct amdgpu_device *adev,
-				    enum admgpu_mes_pipe pipe)
-{
-	char fw_name[30];
-	char ucode_prefix[30];
-	int err;
-	const struct mes_firmware_header_v1_0 *mes_hdr;
-	struct amdgpu_firmware_info *info;
-
-	amdgpu_ucode_ip_version_decode(adev, GC_HWIP, ucode_prefix, sizeof(ucode_prefix));
-
-	if (pipe == AMDGPU_MES_SCHED_PIPE)
-		snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mes.bin",
-			 ucode_prefix);
-	else
-		snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mes1.bin",
-			 ucode_prefix);
-
-	err = request_firmware(&adev->mes.fw[pipe], fw_name, adev->dev);
-	if (err)
-		return err;
-
-	err = amdgpu_ucode_validate(adev->mes.fw[pipe]);
-	if (err) {
-		release_firmware(adev->mes.fw[pipe]);
-		adev->mes.fw[pipe] = NULL;
-		return err;
-	}
-
-	mes_hdr = (const struct mes_firmware_header_v1_0 *)
-		adev->mes.fw[pipe]->data;
-	adev->mes.uc_start_addr[pipe] =
-		le32_to_cpu(mes_hdr->mes_uc_start_addr_lo) |
-		((uint64_t)(le32_to_cpu(mes_hdr->mes_uc_start_addr_hi)) << 32);
-	adev->mes.data_start_addr[pipe] =
-		le32_to_cpu(mes_hdr->mes_data_start_addr_lo) |
-		((uint64_t)(le32_to_cpu(mes_hdr->mes_data_start_addr_hi)) << 32);
-
-	if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
-		int ucode, ucode_data;
-
-		if (pipe == AMDGPU_MES_SCHED_PIPE) {
-			ucode = AMDGPU_UCODE_ID_CP_MES;
-			ucode_data = AMDGPU_UCODE_ID_CP_MES_DATA;
-		} else {
-			ucode = AMDGPU_UCODE_ID_CP_MES1;
-			ucode_data = AMDGPU_UCODE_ID_CP_MES1_DATA;
-		}
-
-		info = &adev->firmware.ucode[ucode];
-		info->ucode_id = ucode;
-		info->fw = adev->mes.fw[pipe];
-		adev->firmware.fw_size +=
-			ALIGN(le32_to_cpu(mes_hdr->mes_ucode_size_bytes),
-			      PAGE_SIZE);
-
-		info = &adev->firmware.ucode[ucode_data];
-		info->ucode_id = ucode_data;
-		info->fw = adev->mes.fw[pipe];
-		adev->firmware.fw_size +=
-			ALIGN(le32_to_cpu(mes_hdr->mes_ucode_data_size_bytes),
-			      PAGE_SIZE);
-	}
-
-	return 0;
-}
-
-static void mes_v11_0_free_microcode(struct amdgpu_device *adev,
-				     enum admgpu_mes_pipe pipe)
-{
-	release_firmware(adev->mes.fw[pipe]);
-	adev->mes.fw[pipe] = NULL;
-}
-
 static int mes_v11_0_allocate_ucode_buffer(struct amdgpu_device *adev,
 					   enum admgpu_mes_pipe pipe)
 {
@@ -1101,10 +1027,6 @@ static int mes_v11_0_sw_init(void *handle)
 		if (!adev->enable_mes_kiq && pipe == AMDGPU_MES_KIQ_PIPE)
 			continue;
 
-		r = mes_v11_0_init_microcode(adev, pipe);
-		if (r)
-			return r;
-
 		r = mes_v11_0_allocate_eop_buf(adev, pipe);
 		if (r)
 			return r;
@@ -1141,8 +1063,7 @@ static int mes_v11_0_sw_fini(void *handle)
 		amdgpu_bo_free_kernel(&adev->mes.eop_gpu_obj[pipe],
 				      &adev->mes.eop_gpu_addr[pipe],
 				      NULL);
-
-		mes_v11_0_free_microcode(adev, pipe);
+		amdgpu_ucode_release(&adev->mes.fw[pipe]);
 	}
 
 	amdgpu_bo_free_kernel(&adev->gfx.kiq.ring.mqd_obj,
@@ -1339,6 +1260,22 @@ static int mes_v11_0_resume(void *handle)
 	return amdgpu_mes_resume(adev);
 }
 
+static int mes_v11_0_early_init(void *handle)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	int pipe, r;
+
+	for (pipe = 0; pipe < AMDGPU_MAX_MES_PIPES; pipe++) {
+		if (!adev->enable_mes_kiq && pipe == AMDGPU_MES_KIQ_PIPE)
+			continue;
+		r = amdgpu_mes_init_microcode(adev, pipe);
+		if (r)
+			return r;
+	}
+
+	return 0;
+}
+
 static int mes_v11_0_late_init(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
@@ -1353,6 +1290,7 @@ static int mes_v11_0_late_init(void *handle)
 
 static const struct amd_ip_funcs mes_v11_0_ip_funcs = {
 	.name = "mes_v11_0",
+	.early_init = mes_v11_0_early_init,
 	.late_init = mes_v11_0_late_init,
 	.sw_init = mes_v11_0_sw_init,
 	.sw_fini = mes_v11_0_sw_fini,
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index 4d780e4430e7..77d5a6f30409 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -1941,9 +1941,11 @@ static int sdma_v4_0_hw_fini(void *handle)
 		return 0;
 	}
 
-	for (i = 0; i < adev->sdma.num_instances; i++) {
-		amdgpu_irq_put(adev, &adev->sdma.ecc_irq,
-			       AMDGPU_SDMA_IRQ_INSTANCE0 + i);
+	if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__SDMA)) {
+		for (i = 0; i < adev->sdma.num_instances; i++) {
+			amdgpu_irq_put(adev, &adev->sdma.ecc_irq,
+				       AMDGPU_SDMA_IRQ_INSTANCE0 + i);
+		}
 	}
 
 	sdma_v4_0_ctx_switch_enable(adev, false);
diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index 9eedc1a1494c..4bf9d8cc8132 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -777,7 +777,7 @@ static int soc21_common_early_init(void *handle)
 			AMD_PG_SUPPORT_VCN_DPG |
 			AMD_PG_SUPPORT_GFX_PG |
 			AMD_PG_SUPPORT_JPEG;
-		adev->external_rev_id = adev->rev_id + 0x1;
+		adev->external_rev_id = adev->rev_id + 0x80;
 		break;
 
 	default:
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 422909d1f352..abac86514328 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -39,6 +39,7 @@
 #include "dc/dc_edid_parser.h"
 #include "dc/dc_stat.h"
 #include "amdgpu_dm_trace.h"
+#include "dc/inc/dc_link_ddc.h"
 
 #include "vid.h"
 #include "amdgpu.h"
@@ -2262,6 +2263,14 @@ static void s3_handle_mst(struct drm_device *dev, bool suspend)
 		if (suspend) {
 			drm_dp_mst_topology_mgr_suspend(mgr);
 		} else {
+			/* if extended timeout is supported in hardware,
+			 * default to LTTPR timeout (3.2ms) first as a W/A for DP link layer
+			 * CTS 4.2.1.1 regression introduced by CTS specs requirement update.
+			 */
+			dc_link_aux_try_to_configure_timeout(aconnector->dc_link->ddc, LINK_AUX_DEFAULT_LTTPR_TIMEOUT_PERIOD);
+			if (!dp_is_lttpr_present(aconnector->dc_link))
+				dc_link_aux_try_to_configure_timeout(aconnector->dc_link->ddc, LINK_AUX_DEFAULT_TIMEOUT_PERIOD);
+
 			ret = drm_dp_mst_topology_mgr_resume(mgr, true);
 			if (ret < 0) {
 				dm_helpers_dp_mst_stop_top_mgr(aconnector->dc_link->ctx,
@@ -7694,6 +7703,13 @@ static void amdgpu_dm_commit_cursors(struct drm_atomic_state *state)
 			handle_cursor_update(plane, old_plane_state);
 }
 
+static inline uint32_t get_mem_type(struct drm_framebuffer *fb)
+{
+	struct amdgpu_bo *abo = gem_to_amdgpu_bo(fb->obj[0]);
+
+	return abo->tbo.resource ? abo->tbo.resource->mem_type : 0;
+}
+
 static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 				    struct dc_state *dc_state,
 				    struct drm_device *dev,
@@ -7767,6 +7783,8 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 			continue;
 
 		dc_plane = dm_new_plane_state->dc_state;
+		if (!dc_plane)
+			continue;
 
 		bundle->surface_updates[planes_count].surface = dc_plane;
 		if (new_pcrtc_state->color_mgmt_changed) {
@@ -7811,11 +7829,13 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 
 		/*
 		 * Only allow immediate flips for fast updates that don't
-		 * change FB pitch, DCC state, rotation or mirroing.
+		 * change memory domain, FB pitch, DCC state, rotation or
+		 * mirroring.
 		 */
 		bundle->flip_addrs[planes_count].flip_immediate =
 			crtc->state->async_flip &&
-			acrtc_state->update_type == UPDATE_TYPE_FAST;
+			acrtc_state->update_type == UPDATE_TYPE_FAST &&
+			get_mem_type(old_plane_state->fb) == get_mem_type(fb);
 
 		timestamp_ns = ktime_get_ns();
 		bundle->flip_addrs[planes_count].flip_timestamp_in_us = div_u64(timestamp_ns, 1000);
@@ -9312,8 +9332,9 @@ static int dm_update_plane_state(struct dc *dc,
 			return -EINVAL;
 		}
 
+		if (dm_old_plane_state->dc_state)
+			dc_plane_state_release(dm_old_plane_state->dc_state);
 
-		dc_plane_state_release(dm_old_plane_state->dc_state);
 		dm_new_plane_state->dc_state = NULL;
 
 		*lock_and_validation_needed = true;
@@ -9850,6 +9871,7 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
 		ret = compute_mst_dsc_configs_for_state(state, dm_state->context, vars);
 		if (ret) {
 			DRM_DEBUG_DRIVER("compute_mst_dsc_configs_for_state() failed\n");
+			ret = -EINVAL;
 			goto fail;
 		}
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index 60dd88666437..994a37003217 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -1375,6 +1375,7 @@ int pre_validate_dsc(struct drm_atomic_state *state,
 	ret = pre_compute_mst_dsc_configs_for_state(state, local_dc_state, vars);
 	if (ret != 0) {
 		DRM_INFO_ONCE("pre_compute_mst_dsc_configs_for_state() failed\n");
+		ret = -EINVAL;
 		goto clean_exit;
 	}
 
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
index 200fcec19186..1859b2e4a98a 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
@@ -719,6 +719,8 @@ void dcn32_clk_mgr_construct(
 		struct pp_smu_funcs *pp_smu,
 		struct dccg *dccg)
 {
+	struct clk_log_info log_info = {0};
+
 	clk_mgr->base.ctx = ctx;
 	clk_mgr->base.funcs = &dcn32_funcs;
 	if (ASICREV_IS_GC_11_0_2(clk_mgr->base.ctx->asic_id.hw_internal_rev)) {
@@ -752,6 +754,7 @@ void dcn32_clk_mgr_construct(
 			clk_mgr->base.clks.ref_dtbclk_khz = 268750;
 	}
 
+
 	/* integer part is now VCO frequency in kHz */
 	clk_mgr->base.dentist_vco_freq_khz = dcn32_get_vco_frequency_from_reg(clk_mgr);
 
@@ -759,6 +762,8 @@ void dcn32_clk_mgr_construct(
 	if (clk_mgr->base.dentist_vco_freq_khz == 0)
 		clk_mgr->base.dentist_vco_freq_khz = 4300000; /* Updated as per HW docs */
 
+	dcn32_dump_clk_registers(&clk_mgr->base.boot_snapshot, &clk_mgr->base, &log_info);
+
 	if (ctx->dc->debug.disable_dtb_ref_clk_switch &&
 			clk_mgr->base.clks.ref_dtbclk_khz != clk_mgr->base.boot_snapshot.dtbclk) {
 		clk_mgr->base.clks.ref_dtbclk_khz = clk_mgr->base.boot_snapshot.dtbclk;
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index da164685547d..21e9c86665f1 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -1707,6 +1707,9 @@ bool dc_remove_plane_from_context(
 	struct dc_stream_status *stream_status = NULL;
 	struct resource_pool *pool = dc->res_pool;
 
+	if (!plane_state)
+		return true;
+
 	for (i = 0; i < context->stream_count; i++)
 		if (context->streams[i] == stream) {
 			stream_status = &context->stream_status[i];
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 37998dc0fc14..b519602c054b 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -796,6 +796,7 @@ struct dc_debug_options {
 	unsigned int force_odm_combine; //bit vector based on otg inst
 	unsigned int seamless_boot_odm_combine;
 	unsigned int force_odm_combine_4to1; //bit vector based on otg inst
+	int minimum_z8_residency_time;
 	bool disable_z9_mpc;
 	unsigned int force_fclk_khz;
 	bool enable_tri_buf;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index 8f894c1d1d1e..7af210bbc592 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -728,11 +728,15 @@ void dcn10_hubp_pg_control(
 	}
 }
 
-static void power_on_plane(
+static void power_on_plane_resources(
 	struct dce_hwseq *hws,
 	int plane_id)
 {
 	DC_LOGGER_INIT(hws->ctx->logger);
+
+	if (hws->funcs.dpp_root_clock_control)
+		hws->funcs.dpp_root_clock_control(hws, plane_id, true);
+
 	if (REG(DC_IP_REQUEST_CNTL)) {
 		REG_SET(DC_IP_REQUEST_CNTL, 0,
 				IP_REQUEST_EN, 1);
@@ -1239,11 +1243,15 @@ void dcn10_plane_atomic_power_down(struct dc *dc,
 			hws->funcs.hubp_pg_control(hws, hubp->inst, false);
 
 		dpp->funcs->dpp_reset(dpp);
+
 		REG_SET(DC_IP_REQUEST_CNTL, 0,
 				IP_REQUEST_EN, 0);
 		DC_LOG_DEBUG(
 				"Power gated front end %d\n", hubp->inst);
 	}
+
+	if (hws->funcs.dpp_root_clock_control)
+		hws->funcs.dpp_root_clock_control(hws, dpp->inst, false);
 }
 
 /* disable HW used by plane.
@@ -2464,7 +2472,7 @@ static void dcn10_enable_plane(
 
 	undo_DEGVIDCN10_253_wa(dc);
 
-	power_on_plane(dc->hwseq,
+	power_on_plane_resources(dc->hwseq,
 		pipe_ctx->plane_res.hubp->inst);
 
 	/* enable DCFCLK current DCHUB */
@@ -3383,7 +3391,9 @@ static bool dcn10_can_pipe_disable_cursor(struct pipe_ctx *pipe_ctx)
 	for (test_pipe = pipe_ctx->top_pipe; test_pipe;
 	     test_pipe = test_pipe->top_pipe) {
 		// Skip invisible layer and pipe-split plane on same layer
-		if (!test_pipe->plane_state->visible || test_pipe->plane_state->layer_index == cur_layer)
+		if (!test_pipe->plane_state ||
+		    !test_pipe->plane_state->visible ||
+		    test_pipe->plane_state->layer_index == cur_layer)
 			continue;
 
 		r2 = test_pipe->plane_res.scl_data.recout;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index 6291a241158a..7e36ba4df89f 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -1110,11 +1110,15 @@ void dcn20_blank_pixel_data(
 }
 
 
-static void dcn20_power_on_plane(
+static void dcn20_power_on_plane_resources(
 	struct dce_hwseq *hws,
 	struct pipe_ctx *pipe_ctx)
 {
 	DC_LOGGER_INIT(hws->ctx->logger);
+
+	if (hws->funcs.dpp_root_clock_control)
+		hws->funcs.dpp_root_clock_control(hws, pipe_ctx->plane_res.dpp->inst, true);
+
 	if (REG(DC_IP_REQUEST_CNTL)) {
 		REG_SET(DC_IP_REQUEST_CNTL, 0,
 				IP_REQUEST_EN, 1);
@@ -1138,7 +1142,7 @@ static void dcn20_enable_plane(struct dc *dc, struct pipe_ctx *pipe_ctx,
 	//if (dc->debug.sanity_checks) {
 	//	dcn10_verify_allow_pstate_change_high(dc);
 	//}
-	dcn20_power_on_plane(dc->hwseq, pipe_ctx);
+	dcn20_power_on_plane_resources(dc->hwseq, pipe_ctx);
 
 	/* enable DCFCLK current DCHUB */
 	pipe_ctx->plane_res.hubp->funcs->hubp_clk_cntl(pipe_ctx->plane_res.hubp, true);
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.c
index 7f34418e6308..7d2b982506fd 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.c
@@ -66,17 +66,8 @@ void dccg31_update_dpp_dto(struct dccg *dccg, int dpp_inst, int req_dppclk)
 		REG_UPDATE(DPPCLK_DTO_CTRL,
 				DPPCLK_DTO_ENABLE[dpp_inst], 1);
 	} else {
-		//DTO must be enabled to generate a 0Hz clock output
-		if (dccg->ctx->dc->debug.root_clock_optimization.bits.dpp) {
-			REG_UPDATE(DPPCLK_DTO_CTRL,
-					DPPCLK_DTO_ENABLE[dpp_inst], 1);
-			REG_SET_2(DPPCLK_DTO_PARAM[dpp_inst], 0,
-					DPPCLK0_DTO_PHASE, 0,
-					DPPCLK0_DTO_MODULO, 1);
-		} else {
-			REG_UPDATE(DPPCLK_DTO_CTRL,
-					DPPCLK_DTO_ENABLE[dpp_inst], 0);
-		}
+		REG_UPDATE(DPPCLK_DTO_CTRL,
+				DPPCLK_DTO_ENABLE[dpp_inst], 0);
 	}
 	dccg->pipe_dppclk_khz[dpp_inst] = req_dppclk;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dccg.c b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dccg.c
index 0b769ee71405..081ce168f621 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dccg.c
@@ -289,8 +289,31 @@ static void dccg314_set_valid_pixel_rate(
 	dccg314_set_dtbclk_dto(dccg, &dto_params);
 }
 
+static void dccg314_dpp_root_clock_control(
+		struct dccg *dccg,
+		unsigned int dpp_inst,
+		bool clock_on)
+{
+	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
+
+	if (clock_on) {
+		/* turn off the DTO and leave phase/modulo at max */
+		REG_UPDATE(DPPCLK_DTO_CTRL, DPPCLK_DTO_ENABLE[dpp_inst], 0);
+		REG_SET_2(DPPCLK_DTO_PARAM[dpp_inst], 0,
+			  DPPCLK0_DTO_PHASE, 0xFF,
+			  DPPCLK0_DTO_MODULO, 0xFF);
+	} else {
+		/* turn on the DTO to generate a 0hz clock */
+		REG_UPDATE(DPPCLK_DTO_CTRL, DPPCLK_DTO_ENABLE[dpp_inst], 1);
+		REG_SET_2(DPPCLK_DTO_PARAM[dpp_inst], 0,
+			  DPPCLK0_DTO_PHASE, 0,
+			  DPPCLK0_DTO_MODULO, 1);
+	}
+}
+
 static const struct dccg_funcs dccg314_funcs = {
 	.update_dpp_dto = dccg31_update_dpp_dto,
+	.dpp_root_clock_control = dccg314_dpp_root_clock_control,
 	.get_dccg_ref_freq = dccg31_get_dccg_ref_freq,
 	.dccg_init = dccg31_init,
 	.set_dpstreamclk = dccg314_set_dpstreamclk,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.c
index 8e824dc81ded..414d7358a075 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.c
@@ -392,6 +392,16 @@ void dcn314_set_pixels_per_cycle(struct pipe_ctx *pipe_ctx)
 				pix_per_cycle);
 }
 
+void dcn314_dpp_root_clock_control(struct dce_hwseq *hws, unsigned int dpp_inst, bool clock_on)
+{
+	if (!hws->ctx->dc->debug.root_clock_optimization.bits.dpp)
+		return;
+
+	if (hws->ctx->dc->res_pool->dccg->funcs->dpp_root_clock_control)
+		hws->ctx->dc->res_pool->dccg->funcs->dpp_root_clock_control(
+			hws->ctx->dc->res_pool->dccg, dpp_inst, clock_on);
+}
+
 void dcn314_hubp_pg_control(struct dce_hwseq *hws, unsigned int hubp_inst, bool power_on)
 {
 	struct dc_context *ctx = hws->ctx;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.h b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.h
index c419d3dbdfee..c786d5e6a428 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.h
@@ -43,4 +43,6 @@ void dcn314_set_pixels_per_cycle(struct pipe_ctx *pipe_ctx);
 
 void dcn314_hubp_pg_control(struct dce_hwseq *hws, unsigned int hubp_inst, bool power_on);
 
+void dcn314_dpp_root_clock_control(struct dce_hwseq *hws, unsigned int dpp_inst, bool clock_on);
+
 #endif /* __DC_HWSS_DCN314_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_init.c b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_init.c
index 25f345ff6c8f..93de284e5465 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_init.c
@@ -137,6 +137,7 @@ static const struct hwseq_private_funcs dcn314_private_funcs = {
 	.plane_atomic_disable = dcn20_plane_atomic_disable,
 	.plane_atomic_power_down = dcn10_plane_atomic_power_down,
 	.enable_power_gating_plane = dcn314_enable_power_gating_plane,
+	.dpp_root_clock_control = dcn314_dpp_root_clock_control,
 	.hubp_pg_control = dcn314_hubp_pg_control,
 	.program_all_writeback_pipes_in_tree = dcn30_program_all_writeback_pipes_in_tree,
 	.update_odm = dcn314_update_odm,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
index 9ffba4c6fe55..30129fb9c27a 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
@@ -887,6 +887,7 @@ static const struct dc_plane_cap plane_cap = {
 static const struct dc_debug_options debug_defaults_drv = {
 	.disable_z10 = false,
 	.enable_z9_disable_interface = true,
+	.minimum_z8_residency_time = 2000,
 	.psr_skip_crtc_disable = true,
 	.disable_dmcu = true,
 	.force_abm_enable = false,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
index 30d15a94f720..578a715040ac 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
@@ -992,6 +992,7 @@ void dcn32_init_hw(struct dc *dc)
 	if (dc->ctx->dmub_srv) {
 		dc_dmub_srv_query_caps_cmd(dc->ctx->dmub_srv->dmub);
 		dc->caps.dmub_caps.psr = dc->ctx->dmub_srv->dmub->feature_caps.psr;
+		dc->caps.dmub_caps.mclk_sw = dc->ctx->dmub_srv->dmub->feature_caps.fw_assisted_mclk_switch;
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
index 6187aba1362b..a473f10b5327 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
@@ -2021,7 +2021,7 @@ int dcn32_populate_dml_pipes_from_context(
 	// In general cases we want to keep the dram clock change requirement
 	// (prefer configs that support MCLK switch). Only override to false
 	// for SubVP
-	if (subvp_in_use)
+	if (context->bw_ctx.bw.dcn.clk.fw_based_mclk_switching || subvp_in_use)
 		context->bw_ctx.dml.soc.dram_clock_change_requirement_final = false;
 	else
 		context->bw_ctx.dml.soc.dram_clock_change_requirement_final = true;
@@ -2077,6 +2077,14 @@ static struct resource_funcs dcn32_res_pool_funcs = {
 	.restore_mall_state = dcn32_restore_mall_state,
 };
 
+static uint32_t read_pipe_fuses(struct dc_context *ctx)
+{
+	uint32_t value = REG_READ(CC_DC_PIPE_DIS);
+	/* DCN32 support max 4 pipes */
+	value = value & 0xf;
+	return value;
+}
+
 
 static bool dcn32_resource_construct(
 	uint8_t num_virtual_links,
@@ -2119,7 +2127,7 @@ static bool dcn32_resource_construct(
 	pool->base.res_cap = &res_cap_dcn32;
 	/* max number of pipes for ASIC before checking for pipe fuses */
 	num_pipes  = pool->base.res_cap->num_timing_generator;
-	pipe_fuses = REG_READ(CC_DC_PIPE_DIS);
+	pipe_fuses = read_pipe_fuses(ctx);
 
 	for (i = 0; i < pool->base.res_cap->num_timing_generator; i++)
 		if (pipe_fuses & 1 << i)
diff --git a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
index 1709b6edb89c..bb36da5cc6c5 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
@@ -1626,6 +1626,14 @@ static struct resource_funcs dcn321_res_pool_funcs = {
 	.restore_mall_state = dcn32_restore_mall_state,
 };
 
+static uint32_t read_pipe_fuses(struct dc_context *ctx)
+{
+	uint32_t value = REG_READ(CC_DC_PIPE_DIS);
+	/* DCN321 support max 4 pipes */
+	value = value & 0xf;
+	return value;
+}
+
 
 static bool dcn321_resource_construct(
 	uint8_t num_virtual_links,
@@ -1668,7 +1676,7 @@ static bool dcn321_resource_construct(
 	pool->base.res_cap = &res_cap_dcn321;
 	/* max number of pipes for ASIC before checking for pipe fuses */
 	num_pipes  = pool->base.res_cap->num_timing_generator;
-	pipe_fuses = REG_READ(CC_DC_PIPE_DIS);
+	pipe_fuses = read_pipe_fuses(ctx);
 
 	for (i = 0; i < pool->base.res_cap->num_timing_generator; i++)
 		if (pipe_fuses & 1 << i)
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
index c26da3bb2892..b6b8be74ee0e 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
@@ -949,7 +949,6 @@ static enum dcn_zstate_support_state  decide_zstate_support(struct dc *dc, struc
 	int plane_count;
 	int i;
 	unsigned int optimized_min_dst_y_next_start_us;
-	bool allow_z8 = context->bw_ctx.dml.vba.StutterPeriod > 1000.0;
 
 	plane_count = 0;
 	optimized_min_dst_y_next_start_us = 0;
@@ -974,6 +973,9 @@ static enum dcn_zstate_support_state  decide_zstate_support(struct dc *dc, struc
 	else if (context->stream_count == 1 &&  context->streams[0]->signal == SIGNAL_TYPE_EDP) {
 		struct dc_link *link = context->streams[0]->sink->link;
 		struct dc_stream_status *stream_status = &context->stream_status[0];
+		int minmum_z8_residency = dc->debug.minimum_z8_residency_time > 0 ? dc->debug.minimum_z8_residency_time : 1000;
+		bool allow_z8 = context->bw_ctx.dml.vba.StutterPeriod > (double)minmum_z8_residency;
+		bool is_pwrseq0 = link->link_index == 0;
 
 		if (dc_extended_blank_supported(dc)) {
 			for (i = 0; i < dc->res_pool->pipe_count; i++) {
@@ -986,18 +988,17 @@ static enum dcn_zstate_support_state  decide_zstate_support(struct dc *dc, struc
 				}
 			}
 		}
-		/* zstate only supported on PWRSEQ0  and when there's <2 planes*/
-		if (link->link_index != 0 || stream_status->plane_count > 1)
+
+		/* Don't support multi-plane configurations */
+		if (stream_status->plane_count > 1)
 			return DCN_ZSTATE_SUPPORT_DISALLOW;
 
-		if (context->bw_ctx.dml.vba.StutterPeriod > 5000.0 || optimized_min_dst_y_next_start_us > 5000)
+		if (is_pwrseq0 && (context->bw_ctx.dml.vba.StutterPeriod > 5000.0 || optimized_min_dst_y_next_start_us > 5000))
 			return DCN_ZSTATE_SUPPORT_ALLOW;
-		else if (link->psr_settings.psr_version == DC_PSR_VERSION_1 && !link->panel_config.psr.disable_psr)
+		else if (is_pwrseq0 && link->psr_settings.psr_version == DC_PSR_VERSION_1 && !link->panel_config.psr.disable_psr)
 			return allow_z8 ? DCN_ZSTATE_SUPPORT_ALLOW_Z8_Z10_ONLY : DCN_ZSTATE_SUPPORT_ALLOW_Z10_ONLY;
 		else
 			return allow_z8 ? DCN_ZSTATE_SUPPORT_ALLOW_Z8_ONLY : DCN_ZSTATE_SUPPORT_DISALLOW;
-	} else if (allow_z8) {
-		return DCN_ZSTATE_SUPPORT_ALLOW_Z8_ONLY;
 	} else {
 		return DCN_ZSTATE_SUPPORT_DISALLOW;
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c
index 4fa636364793..fdfb19337ea6 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c
@@ -368,7 +368,9 @@ void dcn30_fpu_update_soc_for_wm_a(struct dc *dc, struct dc_state *context)
 	dc_assert_fp_enabled();
 
 	if (dc->clk_mgr->bw_params->wm_table.nv_entries[WM_A].valid) {
-		context->bw_ctx.dml.soc.dram_clock_change_latency_us = dc->clk_mgr->bw_params->wm_table.nv_entries[WM_A].dml_input.pstate_latency_us;
+		if (!context->bw_ctx.bw.dcn.clk.fw_based_mclk_switching ||
+				context->bw_ctx.dml.soc.dram_clock_change_latency_us == 0)
+			context->bw_ctx.dml.soc.dram_clock_change_latency_us = dc->clk_mgr->bw_params->wm_table.nv_entries[WM_A].dml_input.pstate_latency_us;
 		context->bw_ctx.dml.soc.sr_enter_plus_exit_time_us = dc->clk_mgr->bw_params->wm_table.nv_entries[WM_A].dml_input.sr_enter_plus_exit_time_us;
 		context->bw_ctx.dml.soc.sr_exit_time_us = dc->clk_mgr->bw_params->wm_table.nv_entries[WM_A].dml_input.sr_exit_time_us;
 	}
@@ -520,6 +522,20 @@ void dcn30_fpu_calculate_wm_and_dlg(
 		pipe_idx++;
 	}
 
+	// WA: restrict FPO to use first non-strobe mode (NV24 BW issue)
+	if (context->bw_ctx.bw.dcn.clk.fw_based_mclk_switching &&
+			dc->dml.soc.num_chans <= 4 &&
+			context->bw_ctx.dml.vba.DRAMSpeed <= 1700 &&
+			context->bw_ctx.dml.vba.DRAMSpeed >= 1500) {
+
+		for (i = 0; i < dc->dml.soc.num_states; i++) {
+			if (dc->dml.soc.clock_limits[i].dram_speed_mts > 1700) {
+				context->bw_ctx.dml.vba.DRAMSpeed = dc->dml.soc.clock_limits[i].dram_speed_mts;
+				break;
+			}
+		}
+	}
+
 	dcn20_calculate_dlg_params(dc, context, pipes, pipe_cnt, vlevel);
 
 	if (!pstate_en)
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c
index 6a1cf6adea77..db06f3b9e637 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c
@@ -149,8 +149,8 @@ struct _vcs_dpi_soc_bounding_box_st dcn3_14_soc = {
 	.num_states = 5,
 	.sr_exit_time_us = 16.5,
 	.sr_enter_plus_exit_time_us = 18.5,
-	.sr_exit_z8_time_us = 280.0,
-	.sr_enter_plus_exit_z8_time_us = 350.0,
+	.sr_exit_z8_time_us = 268.0,
+	.sr_enter_plus_exit_z8_time_us = 393.0,
 	.writeback_latency_us = 12.0,
 	.dram_channel_width_bytes = 4,
 	.round_trip_ping_latency_dcfclk_cycles = 106,
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
index 4b8f5fa0f0ad..ec72b3c24b79 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
@@ -807,7 +807,8 @@ static void DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerforman
 					v->SwathHeightY[k],
 					v->SwathHeightC[k],
 					TWait,
-					v->DRAMSpeedPerState[mode_lib->vba.VoltageLevel] <= MEM_STROBE_FREQ_MHZ ?
+					(v->DRAMSpeedPerState[mode_lib->vba.VoltageLevel] <= MEM_STROBE_FREQ_MHZ ||
+						v->DCFCLKPerState[mode_lib->vba.VoltageLevel] <= MIN_DCFCLK_FREQ_MHZ) ?
 							mode_lib->vba.ip.min_prefetch_in_strobe_us : 0,
 					/* Output */
 					&v->DSTXAfterScaler[k],
@@ -3289,7 +3290,7 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 							v->swath_width_chroma_ub_this_state[k],
 							v->SwathHeightYThisState[k],
 							v->SwathHeightCThisState[k], v->TWait,
-							v->DRAMSpeedPerState[i] <= MEM_STROBE_FREQ_MHZ ?
+							(v->DRAMSpeedPerState[i] <= MEM_STROBE_FREQ_MHZ || v->DCFCLKState[i][j] <= MIN_DCFCLK_FREQ_MHZ) ?
 									mode_lib->vba.ip.min_prefetch_in_strobe_us : 0,
 
 							/* Output */
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.h b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.h
index c8b28c83ddf4..e92eee2c664d 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.h
@@ -52,6 +52,7 @@
 #define BPP_BLENDED_PIPE 0xffffffff
 
 #define MEM_STROBE_FREQ_MHZ 1600
+#define MIN_DCFCLK_FREQ_MHZ 200
 #define MEM_STROBE_MAX_DELIVERY_TIME_US 60.0
 
 struct display_mode_lib;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn321/dcn321_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn321/dcn321_fpu.c
index b80cef70fa60..383a409a3f54 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn321/dcn321_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn321/dcn321_fpu.c
@@ -106,16 +106,16 @@ struct _vcs_dpi_soc_bounding_box_st dcn3_21_soc = {
 	.clock_limits = {
 		{
 			.state = 0,
-			.dcfclk_mhz = 1564.0,
-			.fabricclk_mhz = 400.0,
-			.dispclk_mhz = 2150.0,
-			.dppclk_mhz = 2150.0,
+			.dcfclk_mhz = 1434.0,
+			.fabricclk_mhz = 2250.0,
+			.dispclk_mhz = 1720.0,
+			.dppclk_mhz = 1720.0,
 			.phyclk_mhz = 810.0,
 			.phyclk_d18_mhz = 667.0,
-			.phyclk_d32_mhz = 625.0,
+			.phyclk_d32_mhz = 313.0,
 			.socclk_mhz = 1200.0,
-			.dscclk_mhz = 716.667,
-			.dram_speed_mts = 1600.0,
+			.dscclk_mhz = 573.333,
+			.dram_speed_mts = 16000.0,
 			.dtbclk_mhz = 1564.0,
 		},
 	},
@@ -125,14 +125,14 @@ struct _vcs_dpi_soc_bounding_box_st dcn3_21_soc = {
 	.sr_exit_z8_time_us = 285.0,
 	.sr_enter_plus_exit_z8_time_us = 320,
 	.writeback_latency_us = 12.0,
-	.round_trip_ping_latency_dcfclk_cycles = 263,
+	.round_trip_ping_latency_dcfclk_cycles = 207,
 	.urgent_latency_pixel_data_only_us = 4,
 	.urgent_latency_pixel_mixed_with_vm_data_us = 4,
 	.urgent_latency_vm_data_only_us = 4,
-	.fclk_change_latency_us = 20,
-	.usr_retraining_latency_us = 2,
-	.smn_latency_us = 2,
-	.mall_allocated_for_dcn_mbytes = 64,
+	.fclk_change_latency_us = 7,
+	.usr_retraining_latency_us = 0,
+	.smn_latency_us = 0,
+	.mall_allocated_for_dcn_mbytes = 32,
 	.urgent_out_of_order_return_per_channel_pixel_only_bytes = 4096,
 	.urgent_out_of_order_return_per_channel_pixel_and_vm_bytes = 4096,
 	.urgent_out_of_order_return_per_channel_vm_only_bytes = 4096,
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h b/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h
index ce006762f257..ad6acd1b34e1 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h
@@ -148,18 +148,21 @@ struct dccg_funcs {
 		struct dccg *dccg,
 		int inst);
 
-void (*set_pixel_rate_div)(
-        struct dccg *dccg,
-        uint32_t otg_inst,
-        enum pixel_rate_div k1,
-        enum pixel_rate_div k2);
-
-void (*set_valid_pixel_rate)(
-        struct dccg *dccg,
-	int ref_dtbclk_khz,
-        int otg_inst,
-        int pixclk_khz);
+	void (*set_pixel_rate_div)(struct dccg *dccg,
+			uint32_t otg_inst,
+			enum pixel_rate_div k1,
+			enum pixel_rate_div k2);
 
+	void (*set_valid_pixel_rate)(
+			struct dccg *dccg,
+			int ref_dtbclk_khz,
+			int otg_inst,
+			int pixclk_khz);
+
+	void (*dpp_root_clock_control)(
+			struct dccg *dccg,
+			unsigned int dpp_inst,
+			bool clock_on);
 };
 
 #endif //__DAL_DCCG_H__
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer_private.h b/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer_private.h
index a4d61bb724b6..39bd53b79020 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer_private.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer_private.h
@@ -115,6 +115,10 @@ struct hwseq_private_funcs {
 	void (*plane_atomic_disable)(struct dc *dc, struct pipe_ctx *pipe_ctx);
 	void (*enable_power_gating_plane)(struct dce_hwseq *hws,
 		bool enable);
+	void (*dpp_root_clock_control)(
+			struct dce_hwseq *hws,
+			unsigned int dpp_inst,
+			bool clock_on);
 	void (*dpp_pg_control)(struct dce_hwseq *hws,
 			unsigned int dpp_inst,
 			bool power_on);
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn32.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn32.c
index a76da0131add..9c20516be066 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn32.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn32.c
@@ -130,12 +130,13 @@ void dmub_dcn32_reset(struct dmub_srv *dmub)
 	REG_WRITE(DMCUB_INBOX1_WPTR, 0);
 	REG_WRITE(DMCUB_OUTBOX1_RPTR, 0);
 	REG_WRITE(DMCUB_OUTBOX1_WPTR, 0);
+	REG_WRITE(DMCUB_OUTBOX0_RPTR, 0);
+	REG_WRITE(DMCUB_OUTBOX0_WPTR, 0);
 	REG_WRITE(DMCUB_SCRATCH0, 0);
 }
 
 void dmub_dcn32_reset_release(struct dmub_srv *dmub)
 {
-	REG_WRITE(DMCUB_GPINT_DATAIN1, 0);
 	REG_UPDATE(MMHUBBUB_SOFT_RESET, DMUIF_SOFT_RESET, 0);
 	REG_WRITE(DMCUB_SCRATCH15, dmub->psp_version & 0x001100FF);
 	REG_UPDATE_2(DMCUB_CNTL, DMCUB_ENABLE, 1, DMCUB_TRACEPORT_EN, 1);
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index 1b300c569faf..69b51612c39a 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -36,6 +36,8 @@
 #define amdgpu_dpm_enable_bapm(adev, e) \
 		((adev)->powerplay.pp_funcs->enable_bapm((adev)->powerplay.pp_handle, (e)))
 
+#define amdgpu_dpm_is_legacy_dpm(adev) ((adev)->powerplay.pp_handle == (adev))
+
 int amdgpu_dpm_get_sclk(struct amdgpu_device *adev, bool low)
 {
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
@@ -1414,15 +1416,24 @@ int amdgpu_dpm_get_smu_prv_buf_details(struct amdgpu_device *adev,
 
 int amdgpu_dpm_is_overdrive_supported(struct amdgpu_device *adev)
 {
-	struct pp_hwmgr *hwmgr = adev->powerplay.pp_handle;
-	struct smu_context *smu = adev->powerplay.pp_handle;
+	if (is_support_sw_smu(adev)) {
+		struct smu_context *smu = adev->powerplay.pp_handle;
 
-	if ((is_support_sw_smu(adev) && smu->od_enabled) ||
-	    (is_support_sw_smu(adev) && smu->is_apu) ||
-		(!is_support_sw_smu(adev) && hwmgr->od_enabled))
-		return true;
+		return (smu->od_enabled || smu->is_apu);
+	} else {
+		struct pp_hwmgr *hwmgr;
 
-	return false;
+		/*
+		 * dpm on some legacy asics don't carry od_enabled member
+		 * as its pp_handle is casted directly from adev.
+		 */
+		if (amdgpu_dpm_is_legacy_dpm(adev))
+			return false;
+
+		hwmgr = (struct pp_hwmgr *)adev->powerplay.pp_handle;
+
+		return hwmgr->od_enabled;
+	}
 }
 
 int amdgpu_dpm_set_pp_table(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/bridge/lontium-lt8912b.c b/drivers/gpu/drm/bridge/lontium-lt8912b.c
index 1b74a913f1b8..5e419934d2a3 100644
--- a/drivers/gpu/drm/bridge/lontium-lt8912b.c
+++ b/drivers/gpu/drm/bridge/lontium-lt8912b.c
@@ -504,7 +504,6 @@ static int lt8912_attach_dsi(struct lt8912 *lt)
 	dsi->format = MIPI_DSI_FMT_RGB888;
 
 	dsi->mode_flags = MIPI_DSI_MODE_VIDEO |
-			  MIPI_DSI_MODE_VIDEO_BURST |
 			  MIPI_DSI_MODE_LPM |
 			  MIPI_DSI_MODE_NO_EOT_PACKET;
 
diff --git a/drivers/gpu/drm/i915/display/icl_dsi.c b/drivers/gpu/drm/i915/display/icl_dsi.c
index c62bb9e2c174..4d34a24ee7b0 100644
--- a/drivers/gpu/drm/i915/display/icl_dsi.c
+++ b/drivers/gpu/drm/i915/display/icl_dsi.c
@@ -1211,7 +1211,7 @@ static void gen11_dsi_powerup_panel(struct intel_encoder *encoder)
 
 	/* panel power on related mipi dsi vbt sequences */
 	intel_dsi_vbt_exec_sequence(intel_dsi, MIPI_SEQ_POWER_ON);
-	intel_dsi_msleep(intel_dsi, intel_dsi->panel_on_delay);
+	msleep(intel_dsi->panel_on_delay);
 	intel_dsi_vbt_exec_sequence(intel_dsi, MIPI_SEQ_DEASSERT_RESET);
 	intel_dsi_vbt_exec_sequence(intel_dsi, MIPI_SEQ_INIT_OTP);
 	intel_dsi_vbt_exec_sequence(intel_dsi, MIPI_SEQ_DISPLAY_ON);
diff --git a/drivers/gpu/drm/i915/display/intel_dsi_vbt.c b/drivers/gpu/drm/i915/display/intel_dsi_vbt.c
index 2cbc1292ab38..f102c13cb959 100644
--- a/drivers/gpu/drm/i915/display/intel_dsi_vbt.c
+++ b/drivers/gpu/drm/i915/display/intel_dsi_vbt.c
@@ -762,17 +762,6 @@ void intel_dsi_vbt_exec_sequence(struct intel_dsi *intel_dsi,
 		gpiod_set_value_cansleep(intel_dsi->gpio_backlight, 0);
 }
 
-void intel_dsi_msleep(struct intel_dsi *intel_dsi, int msec)
-{
-	struct intel_connector *connector = intel_dsi->attached_connector;
-
-	/* For v3 VBTs in vid-mode the delays are part of the VBT sequences */
-	if (is_vid_mode(intel_dsi) && connector->panel.vbt.dsi.seq_version >= 3)
-		return;
-
-	msleep(msec);
-}
-
 void intel_dsi_log_params(struct intel_dsi *intel_dsi)
 {
 	struct drm_i915_private *i915 = to_i915(intel_dsi->base.base.dev);
diff --git a/drivers/gpu/drm/i915/display/intel_dsi_vbt.h b/drivers/gpu/drm/i915/display/intel_dsi_vbt.h
index dc642c1fe7ef..468d873fab1a 100644
--- a/drivers/gpu/drm/i915/display/intel_dsi_vbt.h
+++ b/drivers/gpu/drm/i915/display/intel_dsi_vbt.h
@@ -16,7 +16,6 @@ void intel_dsi_vbt_gpio_init(struct intel_dsi *intel_dsi, bool panel_is_on);
 void intel_dsi_vbt_gpio_cleanup(struct intel_dsi *intel_dsi);
 void intel_dsi_vbt_exec_sequence(struct intel_dsi *intel_dsi,
 				 enum mipi_seq seq_id);
-void intel_dsi_msleep(struct intel_dsi *intel_dsi, int msec);
 void intel_dsi_log_params(struct intel_dsi *intel_dsi);
 
 #endif /* __INTEL_DSI_VBT_H__ */
diff --git a/drivers/gpu/drm/i915/display/skl_scaler.c b/drivers/gpu/drm/i915/display/skl_scaler.c
index d7390067b7d4..fe5c47672580 100644
--- a/drivers/gpu/drm/i915/display/skl_scaler.c
+++ b/drivers/gpu/drm/i915/display/skl_scaler.c
@@ -87,6 +87,10 @@ static u16 skl_scaler_calc_phase(int sub, int scale, bool chroma_cosited)
 #define ICL_MAX_SRC_H 4096
 #define ICL_MAX_DST_W 5120
 #define ICL_MAX_DST_H 4096
+#define MTL_MAX_SRC_W 4096
+#define MTL_MAX_SRC_H 8192
+#define MTL_MAX_DST_W 8192
+#define MTL_MAX_DST_H 8192
 #define SKL_MIN_YUV_420_SRC_W 16
 #define SKL_MIN_YUV_420_SRC_H 16
 
@@ -103,6 +107,10 @@ skl_update_scaler(struct intel_crtc_state *crtc_state, bool force_detach,
 	struct drm_i915_private *dev_priv = to_i915(crtc->base.dev);
 	const struct drm_display_mode *adjusted_mode =
 		&crtc_state->hw.adjusted_mode;
+	int pipe_src_w = drm_rect_width(&crtc_state->pipe_src);
+	int pipe_src_h = drm_rect_height(&crtc_state->pipe_src);
+	int min_src_w, min_src_h, min_dst_w, min_dst_h;
+	int max_src_w, max_src_h, max_dst_w, max_dst_h;
 
 	/*
 	 * Src coordinates are already rotated by 270 degrees for
@@ -157,15 +165,33 @@ skl_update_scaler(struct intel_crtc_state *crtc_state, bool force_detach,
 		return -EINVAL;
 	}
 
+	min_src_w = SKL_MIN_SRC_W;
+	min_src_h = SKL_MIN_SRC_H;
+	min_dst_w = SKL_MIN_DST_W;
+	min_dst_h = SKL_MIN_DST_H;
+
+	if (DISPLAY_VER(dev_priv) < 11) {
+		max_src_w = SKL_MAX_SRC_W;
+		max_src_h = SKL_MAX_SRC_H;
+		max_dst_w = SKL_MAX_DST_W;
+		max_dst_h = SKL_MAX_DST_H;
+	} else if (DISPLAY_VER(dev_priv) < 14) {
+		max_src_w = ICL_MAX_SRC_W;
+		max_src_h = ICL_MAX_SRC_H;
+		max_dst_w = ICL_MAX_DST_W;
+		max_dst_h = ICL_MAX_DST_H;
+	} else {
+		max_src_w = MTL_MAX_SRC_W;
+		max_src_h = MTL_MAX_SRC_H;
+		max_dst_w = MTL_MAX_DST_W;
+		max_dst_h = MTL_MAX_DST_H;
+	}
+
 	/* range checks */
-	if (src_w < SKL_MIN_SRC_W || src_h < SKL_MIN_SRC_H ||
-	    dst_w < SKL_MIN_DST_W || dst_h < SKL_MIN_DST_H ||
-	    (DISPLAY_VER(dev_priv) >= 11 &&
-	     (src_w > ICL_MAX_SRC_W || src_h > ICL_MAX_SRC_H ||
-	      dst_w > ICL_MAX_DST_W || dst_h > ICL_MAX_DST_H)) ||
-	    (DISPLAY_VER(dev_priv) < 11 &&
-	     (src_w > SKL_MAX_SRC_W || src_h > SKL_MAX_SRC_H ||
-	      dst_w > SKL_MAX_DST_W || dst_h > SKL_MAX_DST_H)))	{
+	if (src_w < min_src_w || src_h < min_src_h ||
+	    dst_w < min_dst_w || dst_h < min_dst_h ||
+	    src_w > max_src_w || src_h > max_src_h ||
+	    dst_w > max_dst_w || dst_h > max_dst_h) {
 		drm_dbg_kms(&dev_priv->drm,
 			    "scaler_user index %u.%u: src %ux%u dst %ux%u "
 			    "size is out of scaler range\n",
@@ -174,6 +200,21 @@ skl_update_scaler(struct intel_crtc_state *crtc_state, bool force_detach,
 		return -EINVAL;
 	}
 
+	/*
+	 * The pipe scaler does not use all the bits of PIPESRC, at least
+	 * on the earlier platforms. So even when we're scaling a plane
+	 * the *pipe* source size must not be too large. For simplicity
+	 * we assume the limits match the scaler source size limits. Might
+	 * not be 100% accurate on all platforms, but good enough for now.
+	 */
+	if (pipe_src_w > max_src_w || pipe_src_h > max_src_h) {
+		drm_dbg_kms(&dev_priv->drm,
+			    "scaler_user index %u.%u: pipe src size %ux%u "
+			    "is out of scaler range\n",
+			    crtc->pipe, scaler_user, pipe_src_w, pipe_src_h);
+		return -EINVAL;
+	}
+
 	/* mark this plane as a scaler user in crtc_state */
 	scaler_state->scaler_users |= (1 << scaler_user);
 	drm_dbg_kms(&dev_priv->drm, "scaler_user index %u.%u: "
diff --git a/drivers/gpu/drm/i915/display/vlv_dsi.c b/drivers/gpu/drm/i915/display/vlv_dsi.c
index 662bdb656aa3..c7270aa58bae 100644
--- a/drivers/gpu/drm/i915/display/vlv_dsi.c
+++ b/drivers/gpu/drm/i915/display/vlv_dsi.c
@@ -783,7 +783,6 @@ static void intel_dsi_pre_enable(struct intel_atomic_state *state,
 {
 	struct intel_dsi *intel_dsi = enc_to_intel_dsi(encoder);
 	struct intel_crtc *crtc = to_intel_crtc(pipe_config->uapi.crtc);
-	struct intel_connector *connector = to_intel_connector(conn_state->connector);
 	struct drm_i915_private *dev_priv = to_i915(crtc->base.dev);
 	enum pipe pipe = crtc->pipe;
 	enum port port;
@@ -831,21 +830,10 @@ static void intel_dsi_pre_enable(struct intel_atomic_state *state,
 	if (!IS_GEMINILAKE(dev_priv))
 		intel_dsi_prepare(encoder, pipe_config);
 
+	/* Give the panel time to power-on and then deassert its reset */
 	intel_dsi_vbt_exec_sequence(intel_dsi, MIPI_SEQ_POWER_ON);
-
-	/*
-	 * Give the panel time to power-on and then deassert its reset.
-	 * Depending on the VBT MIPI sequences version the deassert-seq
-	 * may contain the necessary delay, intel_dsi_msleep() will skip
-	 * the delay in that case. If there is no deassert-seq, then an
-	 * unconditional msleep is used to give the panel time to power-on.
-	 */
-	if (connector->panel.vbt.dsi.sequence[MIPI_SEQ_DEASSERT_RESET]) {
-		intel_dsi_msleep(intel_dsi, intel_dsi->panel_on_delay);
-		intel_dsi_vbt_exec_sequence(intel_dsi, MIPI_SEQ_DEASSERT_RESET);
-	} else {
-		msleep(intel_dsi->panel_on_delay);
-	}
+	msleep(intel_dsi->panel_on_delay);
+	intel_dsi_vbt_exec_sequence(intel_dsi, MIPI_SEQ_DEASSERT_RESET);
 
 	if (IS_GEMINILAKE(dev_priv)) {
 		glk_cold_boot = glk_dsi_enable_io(encoder);
@@ -879,7 +867,7 @@ static void intel_dsi_pre_enable(struct intel_atomic_state *state,
 		msleep(20); /* XXX */
 		for_each_dsi_port(port, intel_dsi->ports)
 			dpi_send_cmd(intel_dsi, TURN_ON, false, port);
-		intel_dsi_msleep(intel_dsi, 100);
+		msleep(100);
 
 		intel_dsi_vbt_exec_sequence(intel_dsi, MIPI_SEQ_DISPLAY_ON);
 
@@ -1007,7 +995,7 @@ static void intel_dsi_post_disable(struct intel_atomic_state *state,
 	/* Assert reset */
 	intel_dsi_vbt_exec_sequence(intel_dsi, MIPI_SEQ_ASSERT_RESET);
 
-	intel_dsi_msleep(intel_dsi, intel_dsi->panel_off_delay);
+	msleep(intel_dsi->panel_off_delay);
 	intel_dsi_vbt_exec_sequence(intel_dsi, MIPI_SEQ_POWER_OFF);
 
 	intel_dsi->panel_power_off_time = ktime_get_boottime();
diff --git a/drivers/gpu/drm/i915/gt/intel_gt_regs.h b/drivers/gpu/drm/i915/gt/intel_gt_regs.h
index 9758b0b63560..1d96c36f9efc 100644
--- a/drivers/gpu/drm/i915/gt/intel_gt_regs.h
+++ b/drivers/gpu/drm/i915/gt/intel_gt_regs.h
@@ -1135,6 +1135,8 @@
 #define   ENABLE_SMALLPL			REG_BIT(15)
 #define   SC_DISABLE_POWER_OPTIMIZATION_EBB	REG_BIT(9)
 #define   GEN11_SAMPLER_ENABLE_HEADLESS_MSG	REG_BIT(5)
+#define   MTL_DISABLE_SAMPLER_SC_OOO		REG_BIT(3)
+#define   GEN11_INDIRECT_STATE_BASE_ADDR_OVERRIDE	REG_BIT(0)
 
 #define GEN9_HALF_SLICE_CHICKEN7		MCR_REG(0xe194)
 #define   DG2_DISABLE_ROUND_ENABLE_ALLOW_FOR_SSLA	REG_BIT(15)
@@ -1161,7 +1163,9 @@
 #define   THREAD_EX_ARB_MODE_RR_AFTER_DEP	REG_FIELD_PREP(THREAD_EX_ARB_MODE, 0x2)
 
 #define HSW_ROW_CHICKEN3			_MMIO(0xe49c)
+#define GEN9_ROW_CHICKEN3			MCR_REG(0xe49c)
 #define   HSW_ROW_CHICKEN3_L3_GLOBAL_ATOMICS_DISABLE	(1 << 6)
+#define   MTL_DISABLE_FIX_FOR_EOT_FLUSH		REG_BIT(9)
 
 #define GEN8_ROW_CHICKEN			MCR_REG(0xe4f0)
 #define   FLOW_CONTROL_ENABLE			REG_BIT(15)
diff --git a/drivers/gpu/drm/i915/gt/intel_workarounds.c b/drivers/gpu/drm/i915/gt/intel_workarounds.c
index e13052c5dae1..620071efb2fc 100644
--- a/drivers/gpu/drm/i915/gt/intel_workarounds.c
+++ b/drivers/gpu/drm/i915/gt/intel_workarounds.c
@@ -3035,6 +3035,39 @@ general_render_compute_wa_init(struct intel_engine_cs *engine, struct i915_wa_li
 
 	add_render_compute_tuning_settings(i915, wal);
 
+	if (GRAPHICS_VER(i915) >= 11) {
+		/* This is not a Wa (although referred to as
+		 * WaSetInidrectStateOverride in places), this allows
+		 * applications that reference sampler states through
+		 * the BindlessSamplerStateBaseAddress to have their
+		 * border color relative to DynamicStateBaseAddress
+		 * rather than BindlessSamplerStateBaseAddress.
+		 *
+		 * Otherwise SAMPLER_STATE border colors have to be
+		 * copied in multiple heaps (DynamicStateBaseAddress &
+		 * BindlessSamplerStateBaseAddress)
+		 *
+		 * BSpec: 46052
+		 */
+		wa_mcr_masked_en(wal,
+				 GEN10_SAMPLER_MODE,
+				 GEN11_INDIRECT_STATE_BASE_ADDR_OVERRIDE);
+	}
+
+	if (IS_MTL_GRAPHICS_STEP(i915, M, STEP_B0, STEP_FOREVER) ||
+	    IS_MTL_GRAPHICS_STEP(i915, P, STEP_B0, STEP_FOREVER))
+		/* Wa_14017856879 */
+		wa_mcr_masked_en(wal, GEN9_ROW_CHICKEN3, MTL_DISABLE_FIX_FOR_EOT_FLUSH);
+
+	if (IS_MTL_GRAPHICS_STEP(i915, M, STEP_A0, STEP_B0) ||
+	    IS_MTL_GRAPHICS_STEP(i915, P, STEP_A0, STEP_B0))
+		/*
+		 * Wa_14017066071
+		 * Wa_14017654203
+		 */
+		wa_mcr_masked_en(wal, GEN10_SAMPLER_MODE,
+				 MTL_DISABLE_SAMPLER_SC_OOO);
+
 	if (IS_MTL_GRAPHICS_STEP(i915, M, STEP_A0, STEP_B0) ||
 	    IS_MTL_GRAPHICS_STEP(i915, P, STEP_A0, STEP_B0) ||
 	    IS_PONTEVECCHIO(i915) ||
diff --git a/drivers/gpu/drm/i915/i915_pci.c b/drivers/gpu/drm/i915/i915_pci.c
index 4fada7ebe8d8..36cc4fc87c48 100644
--- a/drivers/gpu/drm/i915/i915_pci.c
+++ b/drivers/gpu/drm/i915/i915_pci.c
@@ -1133,6 +1133,8 @@ static const struct intel_gt_definition xelpmp_extra_gt[] = {
 static const struct intel_device_info mtl_info = {
 	XE_HP_FEATURES,
 	XE_LPDP_FEATURES,
+	.__runtime.cpu_transcoder_mask = BIT(TRANSCODER_A) | BIT(TRANSCODER_B) |
+			       BIT(TRANSCODER_C) | BIT(TRANSCODER_D),
 	/*
 	 * Real graphics IP version will be obtained from hardware GMD_ID
 	 * register.  Value provided here is just for sanity checking.
diff --git a/drivers/gpu/drm/i915/i915_reg.h b/drivers/gpu/drm/i915/i915_reg.h
index 4f84cda3f9b5..bbbbeb3f4781 100644
--- a/drivers/gpu/drm/i915/i915_reg.h
+++ b/drivers/gpu/drm/i915/i915_reg.h
@@ -7612,8 +7612,8 @@ enum skl_power_gate {
 
 #define _PLANE_CSC_RY_GY_1(pipe)	_PIPE(pipe, _PLANE_CSC_RY_GY_1_A, \
 					      _PLANE_CSC_RY_GY_1_B)
-#define _PLANE_CSC_RY_GY_2(pipe)	_PIPE(pipe, _PLANE_INPUT_CSC_RY_GY_2_A, \
-					      _PLANE_INPUT_CSC_RY_GY_2_B)
+#define _PLANE_CSC_RY_GY_2(pipe)	_PIPE(pipe, _PLANE_CSC_RY_GY_2_A, \
+					      _PLANE_CSC_RY_GY_2_B)
 #define PLANE_CSC_COEFF(pipe, plane, index)	_MMIO_PLANE(plane, \
 							    _PLANE_CSC_RY_GY_1(pipe) +  (index) * 4, \
 							    _PLANE_CSC_RY_GY_2(pipe) + (index) * 4)
diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/drm/msm/adreno/adreno_device.c
index cd009d56d35d..ed1e0c650bb1 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_device.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
@@ -440,20 +440,21 @@ struct msm_gpu *adreno_load_gpu(struct drm_device *dev)
 
 	ret = pm_runtime_get_sync(&pdev->dev);
 	if (ret < 0) {
-		pm_runtime_put_sync(&pdev->dev);
+		pm_runtime_put_noidle(&pdev->dev);
 		DRM_DEV_ERROR(dev->dev, "Couldn't power up the GPU: %d\n", ret);
-		return NULL;
+		goto err_disable_rpm;
 	}
 
 	mutex_lock(&gpu->lock);
 	ret = msm_gpu_hw_init(gpu);
 	mutex_unlock(&gpu->lock);
-	pm_runtime_put_autosuspend(&pdev->dev);
 	if (ret) {
 		DRM_DEV_ERROR(dev->dev, "gpu hw init failed: %d\n", ret);
-		return NULL;
+		goto err_put_rpm;
 	}
 
+	pm_runtime_put_autosuspend(&pdev->dev);
+
 #ifdef CONFIG_DEBUG_FS
 	if (gpu->funcs->debugfs_init) {
 		gpu->funcs->debugfs_init(gpu, dev->primary);
@@ -462,6 +463,13 @@ struct msm_gpu *adreno_load_gpu(struct drm_device *dev)
 #endif
 
 	return gpu;
+
+err_put_rpm:
+	pm_runtime_put_sync_suspend(&pdev->dev);
+err_disable_rpm:
+	pm_runtime_disable(&pdev->dev);
+
+	return NULL;
 }
 
 static int find_chipid(struct device *dev, struct adreno_rev *rev)
diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
index ee2f60b6f09b..0987ea1af8b4 100644
--- a/drivers/gpu/drm/msm/msm_drv.c
+++ b/drivers/gpu/drm/msm/msm_drv.c
@@ -50,6 +50,8 @@
 #define MSM_VERSION_MINOR	9
 #define MSM_VERSION_PATCHLEVEL	0
 
+static void msm_deinit_vram(struct drm_device *ddev);
+
 static const struct drm_mode_config_funcs mode_config_funcs = {
 	.fb_create = msm_framebuffer_create,
 	.output_poll_changed = drm_fb_helper_output_poll_changed,
@@ -241,7 +243,8 @@ static int msm_drm_uninit(struct device *dev)
 		msm_fbdev_free(ddev);
 #endif
 
-	msm_disp_snapshot_destroy(ddev);
+	if (kms)
+		msm_disp_snapshot_destroy(ddev);
 
 	drm_mode_config_cleanup(ddev);
 
@@ -249,19 +252,16 @@ static int msm_drm_uninit(struct device *dev)
 		drm_bridge_remove(priv->bridges[i]);
 	priv->num_bridges = 0;
 
-	pm_runtime_get_sync(dev);
-	msm_irq_uninstall(ddev);
-	pm_runtime_put_sync(dev);
+	if (kms) {
+		pm_runtime_get_sync(dev);
+		msm_irq_uninstall(ddev);
+		pm_runtime_put_sync(dev);
+	}
 
 	if (kms && kms->funcs)
 		kms->funcs->destroy(kms);
 
-	if (priv->vram.paddr) {
-		unsigned long attrs = DMA_ATTR_NO_KERNEL_MAPPING;
-		drm_mm_takedown(&priv->vram.mm);
-		dma_free_attrs(dev, priv->vram.size, NULL,
-			       priv->vram.paddr, attrs);
-	}
+	msm_deinit_vram(ddev);
 
 	component_unbind_all(dev, ddev);
 
@@ -399,6 +399,19 @@ static int msm_init_vram(struct drm_device *dev)
 	return ret;
 }
 
+static void msm_deinit_vram(struct drm_device *ddev)
+{
+	struct msm_drm_private *priv = ddev->dev_private;
+	unsigned long attrs = DMA_ATTR_NO_KERNEL_MAPPING;
+
+	if (!priv->vram.paddr)
+		return;
+
+	drm_mm_takedown(&priv->vram.mm);
+	dma_free_attrs(ddev->dev, priv->vram.size, NULL, priv->vram.paddr,
+			attrs);
+}
+
 static int msm_drm_init(struct device *dev, const struct drm_driver *drv)
 {
 	struct msm_drm_private *priv = dev_get_drvdata(dev);
@@ -418,6 +431,10 @@ static int msm_drm_init(struct device *dev, const struct drm_driver *drv)
 	priv->dev = ddev;
 
 	priv->wq = alloc_ordered_workqueue("msm", 0);
+	if (!priv->wq) {
+		ret = -ENOMEM;
+		goto err_put_dev;
+	}
 
 	INIT_LIST_HEAD(&priv->objects);
 	mutex_init(&priv->obj_lock);
@@ -440,12 +457,12 @@ static int msm_drm_init(struct device *dev, const struct drm_driver *drv)
 
 	ret = msm_init_vram(ddev);
 	if (ret)
-		return ret;
+		goto err_cleanup_mode_config;
 
 	/* Bind all our sub-components: */
 	ret = component_bind_all(dev, ddev);
 	if (ret)
-		return ret;
+		goto err_deinit_vram;
 
 	dma_set_max_seg_size(dev, UINT_MAX);
 
@@ -540,6 +557,17 @@ static int msm_drm_init(struct device *dev, const struct drm_driver *drv)
 
 err_msm_uninit:
 	msm_drm_uninit(dev);
+
+	return ret;
+
+err_deinit_vram:
+	msm_deinit_vram(ddev);
+err_cleanup_mode_config:
+	drm_mode_config_cleanup(ddev);
+	destroy_workqueue(priv->wq);
+err_put_dev:
+	drm_dev_put(ddev);
+
 	return ret;
 }
 
diff --git a/drivers/gpu/drm/panel/panel-orisetech-otm8009a.c b/drivers/gpu/drm/panel/panel-orisetech-otm8009a.c
index b4729a94c34a..898b892f1143 100644
--- a/drivers/gpu/drm/panel/panel-orisetech-otm8009a.c
+++ b/drivers/gpu/drm/panel/panel-orisetech-otm8009a.c
@@ -471,7 +471,7 @@ static int otm8009a_probe(struct mipi_dsi_device *dsi)
 		       DRM_MODE_CONNECTOR_DSI);
 
 	ctx->bl_dev = devm_backlight_device_register(dev, dev_name(dev),
-						     dsi->host->dev, ctx,
+						     dev, ctx,
 						     &otm8009a_backlight_ops,
 						     NULL);
 	if (IS_ERR(ctx->bl_dev)) {
diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index 9312d611db8e..0c6a82c665c1 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -1308,6 +1308,9 @@ static void wacom_intuos_pro2_bt_pen(struct wacom_wac *wacom)
 
 	struct input_dev *pen_input = wacom->pen_input;
 	unsigned char *data = wacom->data;
+	int number_of_valid_frames = 0;
+	int time_interval = 15000000;
+	ktime_t time_packet_received = ktime_get();
 	int i;
 
 	if (wacom->features.type == INTUOSP2_BT ||
@@ -1328,12 +1331,30 @@ static void wacom_intuos_pro2_bt_pen(struct wacom_wac *wacom)
 		wacom->id[0] |= (wacom->serial[0] >> 32) & 0xFFFFF;
 	}
 
+	/* number of valid frames */
 	for (i = 0; i < pen_frames; i++) {
 		unsigned char *frame = &data[i*pen_frame_len + 1];
 		bool valid = frame[0] & 0x80;
+
+		if (valid)
+			number_of_valid_frames++;
+	}
+
+	if (number_of_valid_frames) {
+		if (wacom->hid_data.time_delayed)
+			time_interval = ktime_get() - wacom->hid_data.time_delayed;
+		time_interval /= number_of_valid_frames;
+		wacom->hid_data.time_delayed = time_packet_received;
+	}
+
+	for (i = 0; i < number_of_valid_frames; i++) {
+		unsigned char *frame = &data[i*pen_frame_len + 1];
+		bool valid = frame[0] & 0x80;
 		bool prox = frame[0] & 0x40;
 		bool range = frame[0] & 0x20;
 		bool invert = frame[0] & 0x10;
+		int frames_number_reversed = number_of_valid_frames - i - 1;
+		int event_timestamp = time_packet_received - frames_number_reversed * time_interval;
 
 		if (!valid)
 			continue;
@@ -1346,6 +1367,7 @@ static void wacom_intuos_pro2_bt_pen(struct wacom_wac *wacom)
 			wacom->tool[0] = 0;
 			wacom->id[0] = 0;
 			wacom->serial[0] = 0;
+			wacom->hid_data.time_delayed = 0;
 			return;
 		}
 
@@ -1382,6 +1404,7 @@ static void wacom_intuos_pro2_bt_pen(struct wacom_wac *wacom)
 						 get_unaligned_le16(&frame[11]));
 			}
 		}
+
 		if (wacom->tool[0]) {
 			input_report_abs(pen_input, ABS_PRESSURE, get_unaligned_le16(&frame[5]));
 			if (wacom->features.type == INTUOSP2_BT ||
@@ -1405,6 +1428,9 @@ static void wacom_intuos_pro2_bt_pen(struct wacom_wac *wacom)
 
 		wacom->shared->stylus_in_proximity = prox;
 
+		/* add timestamp to unpack the frames */
+		input_set_timestamp(pen_input, event_timestamp);
+
 		input_sync(pen_input);
 	}
 }
@@ -1895,6 +1921,7 @@ static void wacom_map_usage(struct input_dev *input, struct hid_usage *usage,
 	int fmax = field->logical_maximum;
 	unsigned int equivalent_usage = wacom_equivalent_usage(usage->hid);
 	int resolution_code = code;
+	int resolution = hidinput_calc_abs_res(field, resolution_code);
 
 	if (equivalent_usage == HID_DG_TWIST) {
 		resolution_code = ABS_RZ;
@@ -1915,8 +1942,15 @@ static void wacom_map_usage(struct input_dev *input, struct hid_usage *usage,
 	switch (type) {
 	case EV_ABS:
 		input_set_abs_params(input, code, fmin, fmax, fuzz, 0);
-		input_abs_set_res(input, code,
-				  hidinput_calc_abs_res(field, resolution_code));
+
+		/* older tablet may miss physical usage */
+		if ((code == ABS_X || code == ABS_Y) && !resolution) {
+			resolution = WACOM_INTUOS_RES;
+			hid_warn(input,
+				 "Wacom usage (%d) missing resolution \n",
+				 code);
+		}
+		input_abs_set_res(input, code, resolution);
 		break;
 	case EV_KEY:
 	case EV_MSC:
diff --git a/drivers/hid/wacom_wac.h b/drivers/hid/wacom_wac.h
index 16f221388563..1a40bb8c5810 100644
--- a/drivers/hid/wacom_wac.h
+++ b/drivers/hid/wacom_wac.h
@@ -324,6 +324,7 @@ struct hid_data {
 	int ps_connected;
 	bool pad_input_event_flag;
 	unsigned short sequence_number;
+	int time_delayed;
 };
 
 struct wacom_remote_data {
diff --git a/drivers/i2c/busses/i2c-tegra.c b/drivers/i2c/busses/i2c-tegra.c
index 6aab84c8d22b..157066f06a32 100644
--- a/drivers/i2c/busses/i2c-tegra.c
+++ b/drivers/i2c/busses/i2c-tegra.c
@@ -242,9 +242,10 @@ struct tegra_i2c_hw_feature {
  * @is_dvc: identifies the DVC I2C controller, has a different register layout
  * @is_vi: identifies the VI I2C controller, has a different register layout
  * @msg_complete: transfer completion notifier
+ * @msg_buf_remaining: size of unsent data in the message buffer
+ * @msg_len: length of message in current transfer
  * @msg_err: error code for completed message
  * @msg_buf: pointer to current message data
- * @msg_buf_remaining: size of unsent data in the message buffer
  * @msg_read: indicates that the transfer is a read access
  * @timings: i2c timings information like bus frequency
  * @multimaster_mode: indicates that I2C controller is in multi-master mode
@@ -277,6 +278,7 @@ struct tegra_i2c_dev {
 
 	struct completion msg_complete;
 	size_t msg_buf_remaining;
+	unsigned int msg_len;
 	int msg_err;
 	u8 *msg_buf;
 
@@ -1169,7 +1171,7 @@ static void tegra_i2c_push_packet_header(struct tegra_i2c_dev *i2c_dev,
 	else
 		i2c_writel(i2c_dev, packet_header, I2C_TX_FIFO);
 
-	packet_header = msg->len - 1;
+	packet_header = i2c_dev->msg_len - 1;
 
 	if (i2c_dev->dma_mode && !i2c_dev->msg_read)
 		*dma_buf++ = packet_header;
@@ -1242,20 +1244,32 @@ static int tegra_i2c_xfer_msg(struct tegra_i2c_dev *i2c_dev,
 		return err;
 
 	i2c_dev->msg_buf = msg->buf;
+	i2c_dev->msg_len = msg->len;
 
-	/* The condition true implies smbus block read and len is already read */
-	if (msg->flags & I2C_M_RECV_LEN && end_state != MSG_END_CONTINUE)
-		i2c_dev->msg_buf = msg->buf + 1;
-
-	i2c_dev->msg_buf_remaining = msg->len;
 	i2c_dev->msg_err = I2C_ERR_NONE;
 	i2c_dev->msg_read = !!(msg->flags & I2C_M_RD);
 	reinit_completion(&i2c_dev->msg_complete);
 
+	/*
+	 * For SMBUS block read command, read only 1 byte in the first transfer.
+	 * Adjust that 1 byte for the next transfer in the msg buffer and msg
+	 * length.
+	 */
+	if (msg->flags & I2C_M_RECV_LEN) {
+		if (end_state == MSG_END_CONTINUE) {
+			i2c_dev->msg_len = 1;
+		} else {
+			i2c_dev->msg_buf += 1;
+			i2c_dev->msg_len -= 1;
+		}
+	}
+
+	i2c_dev->msg_buf_remaining = i2c_dev->msg_len;
+
 	if (i2c_dev->msg_read)
-		xfer_size = msg->len;
+		xfer_size = i2c_dev->msg_len;
 	else
-		xfer_size = msg->len + I2C_PACKET_HEADER_SIZE;
+		xfer_size = i2c_dev->msg_len + I2C_PACKET_HEADER_SIZE;
 
 	xfer_size = ALIGN(xfer_size, BYTES_PER_FIFO_WORD);
 
@@ -1295,7 +1309,7 @@ static int tegra_i2c_xfer_msg(struct tegra_i2c_dev *i2c_dev,
 	if (!i2c_dev->msg_read) {
 		if (i2c_dev->dma_mode) {
 			memcpy(i2c_dev->dma_buf + I2C_PACKET_HEADER_SIZE,
-			       msg->buf, msg->len);
+			       msg->buf, i2c_dev->msg_len);
 
 			dma_sync_single_for_device(i2c_dev->dma_dev,
 						   i2c_dev->dma_phys,
@@ -1352,7 +1366,7 @@ static int tegra_i2c_xfer_msg(struct tegra_i2c_dev *i2c_dev,
 						i2c_dev->dma_phys,
 						xfer_size, DMA_FROM_DEVICE);
 
-			memcpy(i2c_dev->msg_buf, i2c_dev->dma_buf, msg->len);
+			memcpy(i2c_dev->msg_buf, i2c_dev->dma_buf, i2c_dev->msg_len);
 		}
 	}
 
@@ -1408,8 +1422,8 @@ static int tegra_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[],
 			ret = tegra_i2c_xfer_msg(i2c_dev, &msgs[i], MSG_END_CONTINUE);
 			if (ret)
 				break;
-			/* Set the read byte as msg len */
-			msgs[i].len = msgs[i].buf[0];
+			/* Set the msg length from first byte */
+			msgs[i].len += msgs[i].buf[0];
 			dev_dbg(i2c_dev->dev, "reading %d bytes\n", msgs[i].len);
 		}
 		ret = tegra_i2c_xfer_msg(i2c_dev, &msgs[i], end_type);
diff --git a/drivers/infiniband/sw/rxe/rxe.c b/drivers/infiniband/sw/rxe/rxe.c
index a3f05fdd9fac..7a7e713de52d 100644
--- a/drivers/infiniband/sw/rxe/rxe.c
+++ b/drivers/infiniband/sw/rxe/rxe.c
@@ -160,6 +160,8 @@ void rxe_set_mtu(struct rxe_dev *rxe, unsigned int ndev_mtu)
 
 	port->attr.active_mtu = mtu;
 	port->mtu_cap = ib_mtu_enum_to_int(mtu);
+
+	rxe_info_dev(rxe, "Set mtu to %d", port->mtu_cap);
 }
 
 /* called by ifc layer to create new rxe device.
@@ -179,7 +181,7 @@ static int rxe_newlink(const char *ibdev_name, struct net_device *ndev)
 	int err = 0;
 
 	if (is_vlan_dev(ndev)) {
-		pr_err("rxe creation allowed on top of a real device only\n");
+		rxe_err("rxe creation allowed on top of a real device only");
 		err = -EPERM;
 		goto err;
 	}
@@ -187,14 +189,14 @@ static int rxe_newlink(const char *ibdev_name, struct net_device *ndev)
 	rxe = rxe_get_dev_from_net(ndev);
 	if (rxe) {
 		ib_device_put(&rxe->ib_dev);
-		rxe_dbg(rxe, "already configured on %s\n", ndev->name);
+		rxe_err_dev(rxe, "already configured on %s", ndev->name);
 		err = -EEXIST;
 		goto err;
 	}
 
 	err = rxe_net_add(ibdev_name, ndev);
 	if (err) {
-		pr_debug("failed to add %s\n", ndev->name);
+		rxe_err("failed to add %s\n", ndev->name);
 		goto err;
 	}
 err:
diff --git a/drivers/infiniband/sw/rxe/rxe.h b/drivers/infiniband/sw/rxe/rxe.h
index 2415f3704f57..bd8a8ea4ea8f 100644
--- a/drivers/infiniband/sw/rxe/rxe.h
+++ b/drivers/infiniband/sw/rxe/rxe.h
@@ -38,7 +38,8 @@
 
 #define RXE_ROCE_V2_SPORT		(0xc000)
 
-#define rxe_dbg(rxe, fmt, ...) ibdev_dbg(&(rxe)->ib_dev,		\
+#define rxe_dbg(fmt, ...) pr_debug("%s: " fmt "\n", __func__, ##__VA_ARGS__)
+#define rxe_dbg_dev(rxe, fmt, ...) ibdev_dbg(&(rxe)->ib_dev,		\
 		"%s: " fmt, __func__, ##__VA_ARGS__)
 #define rxe_dbg_uc(uc, fmt, ...) ibdev_dbg((uc)->ibuc.device,		\
 		"uc#%d %s: " fmt, (uc)->elem.index, __func__, ##__VA_ARGS__)
@@ -57,6 +58,48 @@
 #define rxe_dbg_mw(mw, fmt, ...) ibdev_dbg((mw)->ibmw.device,		\
 		"mw#%d %s:  " fmt, (mw)->elem.index, __func__, ##__VA_ARGS__)
 
+#define rxe_err(fmt, ...) pr_err_ratelimited("%s: " fmt "\n", __func__, \
+					##__VA_ARGS__)
+#define rxe_err_dev(rxe, fmt, ...) ibdev_err_ratelimited(&(rxe)->ib_dev, \
+		"%s: " fmt, __func__, ##__VA_ARGS__)
+#define rxe_err_uc(uc, fmt, ...) ibdev_err_ratelimited((uc)->ibuc.device, \
+		"uc#%d %s: " fmt, (uc)->elem.index, __func__, ##__VA_ARGS__)
+#define rxe_err_pd(pd, fmt, ...) ibdev_err_ratelimited((pd)->ibpd.device, \
+		"pd#%d %s: " fmt, (pd)->elem.index, __func__, ##__VA_ARGS__)
+#define rxe_err_ah(ah, fmt, ...) ibdev_err_ratelimited((ah)->ibah.device, \
+		"ah#%d %s: " fmt, (ah)->elem.index, __func__, ##__VA_ARGS__)
+#define rxe_err_srq(srq, fmt, ...) ibdev_err_ratelimited((srq)->ibsrq.device, \
+		"srq#%d %s: " fmt, (srq)->elem.index, __func__, ##__VA_ARGS__)
+#define rxe_err_qp(qp, fmt, ...) ibdev_err_ratelimited((qp)->ibqp.device, \
+		"qp#%d %s: " fmt, (qp)->elem.index, __func__, ##__VA_ARGS__)
+#define rxe_err_cq(cq, fmt, ...) ibdev_err_ratelimited((cq)->ibcq.device, \
+		"cq#%d %s: " fmt, (cq)->elem.index, __func__, ##__VA_ARGS__)
+#define rxe_err_mr(mr, fmt, ...) ibdev_err_ratelimited((mr)->ibmr.device, \
+		"mr#%d %s:  " fmt, (mr)->elem.index, __func__, ##__VA_ARGS__)
+#define rxe_err_mw(mw, fmt, ...) ibdev_err_ratelimited((mw)->ibmw.device, \
+		"mw#%d %s:  " fmt, (mw)->elem.index, __func__, ##__VA_ARGS__)
+
+#define rxe_info(fmt, ...) pr_info_ratelimited("%s: " fmt "\n", __func__, \
+					##__VA_ARGS__)
+#define rxe_info_dev(rxe, fmt, ...) ibdev_info_ratelimited(&(rxe)->ib_dev, \
+		"%s: " fmt, __func__, ##__VA_ARGS__)
+#define rxe_info_uc(uc, fmt, ...) ibdev_info_ratelimited((uc)->ibuc.device, \
+		"uc#%d %s: " fmt, (uc)->elem.index, __func__, ##__VA_ARGS__)
+#define rxe_info_pd(pd, fmt, ...) ibdev_info_ratelimited((pd)->ibpd.device, \
+		"pd#%d %s: " fmt, (pd)->elem.index, __func__, ##__VA_ARGS__)
+#define rxe_info_ah(ah, fmt, ...) ibdev_info_ratelimited((ah)->ibah.device, \
+		"ah#%d %s: " fmt, (ah)->elem.index, __func__, ##__VA_ARGS__)
+#define rxe_info_srq(srq, fmt, ...) ibdev_info_ratelimited((srq)->ibsrq.device, \
+		"srq#%d %s: " fmt, (srq)->elem.index, __func__, ##__VA_ARGS__)
+#define rxe_info_qp(qp, fmt, ...) ibdev_info_ratelimited((qp)->ibqp.device, \
+		"qp#%d %s: " fmt, (qp)->elem.index, __func__, ##__VA_ARGS__)
+#define rxe_info_cq(cq, fmt, ...) ibdev_info_ratelimited((cq)->ibcq.device, \
+		"cq#%d %s: " fmt, (cq)->elem.index, __func__, ##__VA_ARGS__)
+#define rxe_info_mr(mr, fmt, ...) ibdev_info_ratelimited((mr)->ibmr.device, \
+		"mr#%d %s:  " fmt, (mr)->elem.index, __func__, ##__VA_ARGS__)
+#define rxe_info_mw(mw, fmt, ...) ibdev_info_ratelimited((mw)->ibmw.device, \
+		"mw#%d %s:  " fmt, (mw)->elem.index, __func__, ##__VA_ARGS__)
+
 /* responder states */
 enum resp_states {
 	RESPST_NONE,
diff --git a/drivers/infiniband/sw/rxe/rxe_cq.c b/drivers/infiniband/sw/rxe/rxe_cq.c
index faf49c50bbab..519ddec29b4b 100644
--- a/drivers/infiniband/sw/rxe/rxe_cq.c
+++ b/drivers/infiniband/sw/rxe/rxe_cq.c
@@ -14,12 +14,12 @@ int rxe_cq_chk_attr(struct rxe_dev *rxe, struct rxe_cq *cq,
 	int count;
 
 	if (cqe <= 0) {
-		rxe_dbg(rxe, "cqe(%d) <= 0\n", cqe);
+		rxe_dbg_dev(rxe, "cqe(%d) <= 0\n", cqe);
 		goto err1;
 	}
 
 	if (cqe > rxe->attr.max_cqe) {
-		rxe_dbg(rxe, "cqe(%d) > max_cqe(%d)\n",
+		rxe_dbg_dev(rxe, "cqe(%d) > max_cqe(%d)\n",
 				cqe, rxe->attr.max_cqe);
 		goto err1;
 	}
@@ -50,7 +50,7 @@ int rxe_cq_from_init(struct rxe_dev *rxe, struct rxe_cq *cq, int cqe,
 	cq->queue = rxe_queue_init(rxe, &cqe,
 			sizeof(struct rxe_cqe), type);
 	if (!cq->queue) {
-		rxe_dbg(rxe, "unable to create cq\n");
+		rxe_dbg_dev(rxe, "unable to create cq\n");
 		return -ENOMEM;
 	}
 
diff --git a/drivers/infiniband/sw/rxe/rxe_icrc.c b/drivers/infiniband/sw/rxe/rxe_icrc.c
index 71bc2c189588..fdf5f08cd8f1 100644
--- a/drivers/infiniband/sw/rxe/rxe_icrc.c
+++ b/drivers/infiniband/sw/rxe/rxe_icrc.c
@@ -21,7 +21,7 @@ int rxe_icrc_init(struct rxe_dev *rxe)
 
 	tfm = crypto_alloc_shash("crc32", 0, 0);
 	if (IS_ERR(tfm)) {
-		rxe_dbg(rxe, "failed to init crc32 algorithm err: %ld\n",
+		rxe_dbg_dev(rxe, "failed to init crc32 algorithm err: %ld\n",
 			       PTR_ERR(tfm));
 		return PTR_ERR(tfm);
 	}
@@ -51,7 +51,7 @@ static __be32 rxe_crc32(struct rxe_dev *rxe, __be32 crc, void *next, size_t len)
 	*(__be32 *)shash_desc_ctx(shash) = crc;
 	err = crypto_shash_update(shash, next, len);
 	if (unlikely(err)) {
-		rxe_dbg(rxe, "failed crc calculation, err: %d\n", err);
+		rxe_dbg_dev(rxe, "failed crc calculation, err: %d\n", err);
 		return (__force __be32)crc32_le((__force u32)crc, next, len);
 	}
 
diff --git a/drivers/infiniband/sw/rxe/rxe_mmap.c b/drivers/infiniband/sw/rxe/rxe_mmap.c
index a47d72dbc537..6b7f2bd69879 100644
--- a/drivers/infiniband/sw/rxe/rxe_mmap.c
+++ b/drivers/infiniband/sw/rxe/rxe_mmap.c
@@ -79,7 +79,7 @@ int rxe_mmap(struct ib_ucontext *context, struct vm_area_struct *vma)
 
 		/* Don't allow a mmap larger than the object. */
 		if (size > ip->info.size) {
-			rxe_dbg(rxe, "mmap region is larger than the object!\n");
+			rxe_dbg_dev(rxe, "mmap region is larger than the object!\n");
 			spin_unlock_bh(&rxe->pending_lock);
 			ret = -EINVAL;
 			goto done;
@@ -87,7 +87,7 @@ int rxe_mmap(struct ib_ucontext *context, struct vm_area_struct *vma)
 
 		goto found_it;
 	}
-	rxe_dbg(rxe, "unable to find pending mmap info\n");
+	rxe_dbg_dev(rxe, "unable to find pending mmap info\n");
 	spin_unlock_bh(&rxe->pending_lock);
 	ret = -EINVAL;
 	goto done;
@@ -98,7 +98,7 @@ int rxe_mmap(struct ib_ucontext *context, struct vm_area_struct *vma)
 
 	ret = remap_vmalloc_range(vma, ip->obj, 0);
 	if (ret) {
-		rxe_dbg(rxe, "err %d from remap_vmalloc_range\n", ret);
+		rxe_dbg_dev(rxe, "err %d from remap_vmalloc_range\n", ret);
 		goto done;
 	}
 
diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index 5e9a03831bf9..b10aa1580a64 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -731,7 +731,7 @@ int rxe_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
 		return -EINVAL;
 
 	rxe_cleanup(mr);
-
+	kfree_rcu(mr);
 	return 0;
 }
 
diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
index e02e1624bcf4..a2ace42e9536 100644
--- a/drivers/infiniband/sw/rxe/rxe_net.c
+++ b/drivers/infiniband/sw/rxe/rxe_net.c
@@ -596,7 +596,7 @@ static int rxe_notify(struct notifier_block *not_blk,
 		rxe_port_down(rxe);
 		break;
 	case NETDEV_CHANGEMTU:
-		rxe_dbg(rxe, "%s changed mtu to %d\n", ndev->name, ndev->mtu);
+		rxe_dbg_dev(rxe, "%s changed mtu to %d\n", ndev->name, ndev->mtu);
 		rxe_set_mtu(rxe, ndev->mtu);
 		break;
 	case NETDEV_CHANGE:
@@ -608,7 +608,7 @@ static int rxe_notify(struct notifier_block *not_blk,
 	case NETDEV_CHANGENAME:
 	case NETDEV_FEAT_CHANGE:
 	default:
-		rxe_dbg(rxe, "ignoring netdev event = %ld for %s\n",
+		rxe_dbg_dev(rxe, "ignoring netdev event = %ld for %s\n",
 			event, ndev->name);
 		break;
 	}
diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
index 1151c0b5ccea..6215c6de3a84 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.c
+++ b/drivers/infiniband/sw/rxe/rxe_pool.c
@@ -116,55 +116,12 @@ void rxe_pool_cleanup(struct rxe_pool *pool)
 	WARN_ON(!xa_empty(&pool->xa));
 }
 
-void *rxe_alloc(struct rxe_pool *pool)
-{
-	struct rxe_pool_elem *elem;
-	void *obj;
-	int err;
-
-	if (WARN_ON(!(pool->type == RXE_TYPE_MR)))
-		return NULL;
-
-	if (atomic_inc_return(&pool->num_elem) > pool->max_elem)
-		goto err_cnt;
-
-	obj = kzalloc(pool->elem_size, GFP_KERNEL);
-	if (!obj)
-		goto err_cnt;
-
-	elem = (struct rxe_pool_elem *)((u8 *)obj + pool->elem_offset);
-
-	elem->pool = pool;
-	elem->obj = obj;
-	kref_init(&elem->ref_cnt);
-	init_completion(&elem->complete);
-
-	/* allocate index in array but leave pointer as NULL so it
-	 * can't be looked up until rxe_finalize() is called
-	 */
-	err = xa_alloc_cyclic(&pool->xa, &elem->index, NULL, pool->limit,
-			      &pool->next, GFP_KERNEL);
-	if (err < 0)
-		goto err_free;
-
-	return obj;
-
-err_free:
-	kfree(obj);
-err_cnt:
-	atomic_dec(&pool->num_elem);
-	return NULL;
-}
-
 int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_elem *elem,
 				bool sleepable)
 {
 	int err;
 	gfp_t gfp_flags;
 
-	if (WARN_ON(pool->type == RXE_TYPE_MR))
-		return -EINVAL;
-
 	if (atomic_inc_return(&pool->num_elem) > pool->max_elem)
 		goto err_cnt;
 
@@ -275,9 +232,6 @@ int __rxe_cleanup(struct rxe_pool_elem *elem, bool sleepable)
 	if (pool->cleanup)
 		pool->cleanup(elem);
 
-	if (pool->type == RXE_TYPE_MR)
-		kfree_rcu(elem->obj);
-
 	atomic_dec(&pool->num_elem);
 
 	return err;
diff --git a/drivers/infiniband/sw/rxe/rxe_pool.h b/drivers/infiniband/sw/rxe/rxe_pool.h
index 9d83cb32092f..b42e26427a70 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.h
+++ b/drivers/infiniband/sw/rxe/rxe_pool.h
@@ -54,9 +54,6 @@ void rxe_pool_init(struct rxe_dev *rxe, struct rxe_pool *pool,
 /* free resources from object pool */
 void rxe_pool_cleanup(struct rxe_pool *pool);
 
-/* allocate an object from pool */
-void *rxe_alloc(struct rxe_pool *pool);
-
 /* connect already allocated object to pool */
 int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_elem *elem,
 				bool sleepable);
diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
index 13283ec06f95..d5de5ba6940f 100644
--- a/drivers/infiniband/sw/rxe/rxe_qp.c
+++ b/drivers/infiniband/sw/rxe/rxe_qp.c
@@ -19,33 +19,33 @@ static int rxe_qp_chk_cap(struct rxe_dev *rxe, struct ib_qp_cap *cap,
 			  int has_srq)
 {
 	if (cap->max_send_wr > rxe->attr.max_qp_wr) {
-		rxe_dbg(rxe, "invalid send wr = %u > %d\n",
+		rxe_dbg_dev(rxe, "invalid send wr = %u > %d\n",
 			 cap->max_send_wr, rxe->attr.max_qp_wr);
 		goto err1;
 	}
 
 	if (cap->max_send_sge > rxe->attr.max_send_sge) {
-		rxe_dbg(rxe, "invalid send sge = %u > %d\n",
+		rxe_dbg_dev(rxe, "invalid send sge = %u > %d\n",
 			 cap->max_send_sge, rxe->attr.max_send_sge);
 		goto err1;
 	}
 
 	if (!has_srq) {
 		if (cap->max_recv_wr > rxe->attr.max_qp_wr) {
-			rxe_dbg(rxe, "invalid recv wr = %u > %d\n",
+			rxe_dbg_dev(rxe, "invalid recv wr = %u > %d\n",
 				 cap->max_recv_wr, rxe->attr.max_qp_wr);
 			goto err1;
 		}
 
 		if (cap->max_recv_sge > rxe->attr.max_recv_sge) {
-			rxe_dbg(rxe, "invalid recv sge = %u > %d\n",
+			rxe_dbg_dev(rxe, "invalid recv sge = %u > %d\n",
 				 cap->max_recv_sge, rxe->attr.max_recv_sge);
 			goto err1;
 		}
 	}
 
 	if (cap->max_inline_data > rxe->max_inline_data) {
-		rxe_dbg(rxe, "invalid max inline data = %u > %d\n",
+		rxe_dbg_dev(rxe, "invalid max inline data = %u > %d\n",
 			 cap->max_inline_data, rxe->max_inline_data);
 		goto err1;
 	}
@@ -73,7 +73,7 @@ int rxe_qp_chk_init(struct rxe_dev *rxe, struct ib_qp_init_attr *init)
 	}
 
 	if (!init->recv_cq || !init->send_cq) {
-		rxe_dbg(rxe, "missing cq\n");
+		rxe_dbg_dev(rxe, "missing cq\n");
 		goto err1;
 	}
 
@@ -82,14 +82,14 @@ int rxe_qp_chk_init(struct rxe_dev *rxe, struct ib_qp_init_attr *init)
 
 	if (init->qp_type == IB_QPT_GSI) {
 		if (!rdma_is_port_valid(&rxe->ib_dev, port_num)) {
-			rxe_dbg(rxe, "invalid port = %d\n", port_num);
+			rxe_dbg_dev(rxe, "invalid port = %d\n", port_num);
 			goto err1;
 		}
 
 		port = &rxe->port;
 
 		if (init->qp_type == IB_QPT_GSI && port->qp_gsi_index) {
-			rxe_dbg(rxe, "GSI QP exists for port %d\n", port_num);
+			rxe_dbg_dev(rxe, "GSI QP exists for port %d\n", port_num);
 			goto err1;
 		}
 	}
diff --git a/drivers/infiniband/sw/rxe/rxe_srq.c b/drivers/infiniband/sw/rxe/rxe_srq.c
index 82e37a41ced4..27ca82ec0826 100644
--- a/drivers/infiniband/sw/rxe/rxe_srq.c
+++ b/drivers/infiniband/sw/rxe/rxe_srq.c
@@ -13,13 +13,13 @@ int rxe_srq_chk_init(struct rxe_dev *rxe, struct ib_srq_init_attr *init)
 	struct ib_srq_attr *attr = &init->attr;
 
 	if (attr->max_wr > rxe->attr.max_srq_wr) {
-		rxe_dbg(rxe, "max_wr(%d) > max_srq_wr(%d)\n",
+		rxe_dbg_dev(rxe, "max_wr(%d) > max_srq_wr(%d)\n",
 			attr->max_wr, rxe->attr.max_srq_wr);
 		goto err1;
 	}
 
 	if (attr->max_wr <= 0) {
-		rxe_dbg(rxe, "max_wr(%d) <= 0\n", attr->max_wr);
+		rxe_dbg_dev(rxe, "max_wr(%d) <= 0\n", attr->max_wr);
 		goto err1;
 	}
 
@@ -27,7 +27,7 @@ int rxe_srq_chk_init(struct rxe_dev *rxe, struct ib_srq_init_attr *init)
 		attr->max_wr = RXE_MIN_SRQ_WR;
 
 	if (attr->max_sge > rxe->attr.max_srq_sge) {
-		rxe_dbg(rxe, "max_sge(%d) > max_srq_sge(%d)\n",
+		rxe_dbg_dev(rxe, "max_sge(%d) > max_srq_sge(%d)\n",
 			attr->max_sge, rxe->attr.max_srq_sge);
 		goto err1;
 	}
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index 9ae7cf93365c..a40a6d058150 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -867,10 +867,17 @@ static struct ib_mr *rxe_get_dma_mr(struct ib_pd *ibpd, int access)
 	struct rxe_dev *rxe = to_rdev(ibpd->device);
 	struct rxe_pd *pd = to_rpd(ibpd);
 	struct rxe_mr *mr;
+	int err;
 
-	mr = rxe_alloc(&rxe->mr_pool);
-	if (!mr)
-		return ERR_PTR(-ENOMEM);
+	mr = kzalloc(sizeof(*mr), GFP_KERNEL);
+	if (!mr) {
+		err = -ENOMEM;
+		goto err_out;
+	}
+
+	err = rxe_add_to_pool(&rxe->mr_pool, mr);
+	if (err)
+		goto err_free;
 
 	rxe_get(pd);
 	mr->ibmr.pd = ibpd;
@@ -878,8 +885,12 @@ static struct ib_mr *rxe_get_dma_mr(struct ib_pd *ibpd, int access)
 
 	rxe_mr_init_dma(access, mr);
 	rxe_finalize(mr);
-
 	return &mr->ibmr;
+
+err_free:
+	kfree(mr);
+err_out:
+	return ERR_PTR(err);
 }
 
 static struct ib_mr *rxe_reg_user_mr(struct ib_pd *ibpd,
@@ -893,9 +904,15 @@ static struct ib_mr *rxe_reg_user_mr(struct ib_pd *ibpd,
 	struct rxe_pd *pd = to_rpd(ibpd);
 	struct rxe_mr *mr;
 
-	mr = rxe_alloc(&rxe->mr_pool);
-	if (!mr)
-		return ERR_PTR(-ENOMEM);
+	mr = kzalloc(sizeof(*mr), GFP_KERNEL);
+	if (!mr) {
+		err = -ENOMEM;
+		goto err_out;
+	}
+
+	err = rxe_add_to_pool(&rxe->mr_pool, mr);
+	if (err)
+		goto err_free;
 
 	rxe_get(pd);
 	mr->ibmr.pd = ibpd;
@@ -903,14 +920,16 @@ static struct ib_mr *rxe_reg_user_mr(struct ib_pd *ibpd,
 
 	err = rxe_mr_init_user(rxe, start, length, iova, access, mr);
 	if (err)
-		goto err1;
+		goto err_cleanup;
 
 	rxe_finalize(mr);
-
 	return &mr->ibmr;
 
-err1:
+err_cleanup:
 	rxe_cleanup(mr);
+err_free:
+	kfree(mr);
+err_out:
 	return ERR_PTR(err);
 }
 
@@ -925,9 +944,15 @@ static struct ib_mr *rxe_alloc_mr(struct ib_pd *ibpd, enum ib_mr_type mr_type,
 	if (mr_type != IB_MR_TYPE_MEM_REG)
 		return ERR_PTR(-EINVAL);
 
-	mr = rxe_alloc(&rxe->mr_pool);
-	if (!mr)
-		return ERR_PTR(-ENOMEM);
+	mr = kzalloc(sizeof(*mr), GFP_KERNEL);
+	if (!mr) {
+		err = -ENOMEM;
+		goto err_out;
+	}
+
+	err = rxe_add_to_pool(&rxe->mr_pool, mr);
+	if (err)
+		goto err_free;
 
 	rxe_get(pd);
 	mr->ibmr.pd = ibpd;
@@ -935,14 +960,16 @@ static struct ib_mr *rxe_alloc_mr(struct ib_pd *ibpd, enum ib_mr_type mr_type,
 
 	err = rxe_mr_init_fast(max_num_sg, mr);
 	if (err)
-		goto err1;
+		goto err_cleanup;
 
 	rxe_finalize(mr);
-
 	return &mr->ibmr;
 
-err1:
+err_cleanup:
 	rxe_cleanup(mr);
+err_free:
+	kfree(mr);
+err_out:
 	return ERR_PTR(err);
 }
 
@@ -1066,7 +1093,7 @@ int rxe_register_device(struct rxe_dev *rxe, const char *ibdev_name)
 
 	err = ib_register_device(dev, ibdev_name, NULL);
 	if (err)
-		rxe_dbg(rxe, "failed with error %d\n", err);
+		rxe_dbg_dev(rxe, "failed with error %d\n", err);
 
 	/*
 	 * Note that rxe may be invalid at this point if another thread
diff --git a/drivers/irqchip/irq-loongson-eiointc.c b/drivers/irqchip/irq-loongson-eiointc.c
index d15fd38c1756..90181c42840b 100644
--- a/drivers/irqchip/irq-loongson-eiointc.c
+++ b/drivers/irqchip/irq-loongson-eiointc.c
@@ -280,9 +280,6 @@ static void acpi_set_vec_parent(int node, struct irq_domain *parent, struct acpi
 {
 	int i;
 
-	if (cpu_has_flatmode)
-		node = cpu_to_node(node * CORES_PER_EIO_NODE);
-
 	for (i = 0; i < MAX_IO_PICS; i++) {
 		if (node == vec_group[i].node) {
 			vec_group[i].parent = parent;
@@ -343,19 +340,27 @@ static int __init pch_pic_parse_madt(union acpi_subtable_headers *header,
 	if (parent)
 		return pch_pic_acpi_init(parent, pchpic_entry);
 
-	return -EINVAL;
+	return 0;
 }
 
 static int __init pch_msi_parse_madt(union acpi_subtable_headers *header,
 					const unsigned long end)
 {
+	struct irq_domain *parent;
 	struct acpi_madt_msi_pic *pchmsi_entry = (struct acpi_madt_msi_pic *)header;
-	struct irq_domain *parent = acpi_get_vec_parent(eiointc_priv[nr_pics - 1]->node, msi_group);
+	int node;
+
+	if (cpu_has_flatmode)
+		node = cpu_to_node(eiointc_priv[nr_pics - 1]->node * CORES_PER_EIO_NODE);
+	else
+		node = eiointc_priv[nr_pics - 1]->node;
+
+	parent = acpi_get_vec_parent(node, msi_group);
 
 	if (parent)
 		return pch_msi_acpi_init(parent, pchmsi_entry);
 
-	return -EINVAL;
+	return 0;
 }
 
 static int __init acpi_cascade_irqdomain_init(void)
@@ -379,6 +384,7 @@ int __init eiointc_acpi_init(struct irq_domain *parent,
 	int i, ret, parent_irq;
 	unsigned long node_map;
 	struct eiointc_priv *priv;
+	int node;
 
 	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
 	if (!priv)
@@ -416,13 +422,19 @@ int __init eiointc_acpi_init(struct irq_domain *parent,
 	parent_irq = irq_create_mapping(parent, acpi_eiointc->cascade);
 	irq_set_chained_handler_and_data(parent_irq, eiointc_irq_dispatch, priv);
 
-	register_syscore_ops(&eiointc_syscore_ops);
-	cpuhp_setup_state_nocalls(CPUHP_AP_IRQ_LOONGARCH_STARTING,
+	if (nr_pics == 1) {
+		register_syscore_ops(&eiointc_syscore_ops);
+		cpuhp_setup_state_nocalls(CPUHP_AP_IRQ_LOONGARCH_STARTING,
 				  "irqchip/loongarch/intc:starting",
 				  eiointc_router_init, NULL);
+	}
 
-	acpi_set_vec_parent(acpi_eiointc->node, priv->eiointc_domain, pch_group);
-	acpi_set_vec_parent(acpi_eiointc->node, priv->eiointc_domain, msi_group);
+	if (cpu_has_flatmode)
+		node = cpu_to_node(acpi_eiointc->node * CORES_PER_EIO_NODE);
+	else
+		node = acpi_eiointc->node;
+	acpi_set_vec_parent(node, priv->eiointc_domain, pch_group);
+	acpi_set_vec_parent(node, priv->eiointc_domain, msi_group);
 	ret = acpi_cascade_irqdomain_init();
 
 	return ret;
diff --git a/drivers/irqchip/irq-loongson-pch-pic.c b/drivers/irqchip/irq-loongson-pch-pic.c
index 437f1af693d0..e5fe4d50be05 100644
--- a/drivers/irqchip/irq-loongson-pch-pic.c
+++ b/drivers/irqchip/irq-loongson-pch-pic.c
@@ -311,7 +311,8 @@ static int pch_pic_init(phys_addr_t addr, unsigned long size, int vec_base,
 	pch_pic_handle[nr_pics] = domain_handle;
 	pch_pic_priv[nr_pics++] = priv;
 
-	register_syscore_ops(&pch_pic_syscore_ops);
+	if (nr_pics == 1)
+		register_syscore_ops(&pch_pic_syscore_ops);
 
 	return 0;
 
@@ -403,6 +404,9 @@ int __init pch_pic_acpi_init(struct irq_domain *parent,
 	int ret, vec_base;
 	struct fwnode_handle *domain_handle;
 
+	if (find_pch_pic(acpi_pchpic->gsi_base) >= 0)
+		return 0;
+
 	vec_base = acpi_pchpic->gsi_base - GSI_MIN_PCH_IRQ;
 
 	domain_handle = irq_domain_alloc_fwnode(&acpi_pchpic->address);
diff --git a/drivers/mailbox/zynqmp-ipi-mailbox.c b/drivers/mailbox/zynqmp-ipi-mailbox.c
index e02a4a18e8c2..d097f45b0e5f 100644
--- a/drivers/mailbox/zynqmp-ipi-mailbox.c
+++ b/drivers/mailbox/zynqmp-ipi-mailbox.c
@@ -110,7 +110,7 @@ struct zynqmp_ipi_pdata {
 	unsigned int method;
 	u32 local_id;
 	int num_mboxes;
-	struct zynqmp_ipi_mbox *ipi_mboxes;
+	struct zynqmp_ipi_mbox ipi_mboxes[];
 };
 
 static struct device_driver zynqmp_ipi_mbox_driver = {
@@ -634,8 +634,13 @@ static int zynqmp_ipi_probe(struct platform_device *pdev)
 	struct zynqmp_ipi_mbox *mbox;
 	int num_mboxes, ret = -EINVAL;
 
-	num_mboxes = of_get_child_count(np);
-	pdata = devm_kzalloc(dev, sizeof(*pdata) + (num_mboxes * sizeof(*mbox)),
+	num_mboxes = of_get_available_child_count(np);
+	if (num_mboxes == 0) {
+		dev_err(dev, "mailbox nodes not available\n");
+		return -EINVAL;
+	}
+
+	pdata = devm_kzalloc(dev, struct_size(pdata, ipi_mboxes, num_mboxes),
 			     GFP_KERNEL);
 	if (!pdata)
 		return -ENOMEM;
@@ -649,8 +654,6 @@ static int zynqmp_ipi_probe(struct platform_device *pdev)
 	}
 
 	pdata->num_mboxes = num_mboxes;
-	pdata->ipi_mboxes = (struct zynqmp_ipi_mbox *)
-			    ((char *)pdata + sizeof(*pdata));
 
 	mbox = pdata->ipi_mboxes;
 	for_each_available_child_of_node(np, nc) {
diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index bf50a35db711..d75db5076793 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -2471,6 +2471,9 @@ static void spi_nor_init_flags(struct spi_nor *nor)
 
 	if (flags & NO_CHIP_ERASE)
 		nor->flags |= SNOR_F_NO_OP_CHIP_ERASE;
+
+	if (flags & SPI_NOR_RWW)
+		nor->flags |= SNOR_F_RWW;
 }
 
 /**
@@ -2980,6 +2983,9 @@ static void spi_nor_set_mtd_info(struct spi_nor *nor)
 		mtd->name = dev_name(dev);
 	mtd->type = MTD_NORFLASH;
 	mtd->flags = MTD_CAP_NORFLASH;
+	/* Unset BIT_WRITEABLE to enable JFFS2 write buffer for ECC'd NOR */
+	if (nor->flags & SNOR_F_ECC)
+		mtd->flags &= ~MTD_BIT_WRITEABLE;
 	if (nor->info->flags & SPI_NOR_NO_ERASE)
 		mtd->flags |= MTD_NO_ERASE;
 	else
diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
index f4246c52a1de..75ec2e560424 100644
--- a/drivers/mtd/spi-nor/core.h
+++ b/drivers/mtd/spi-nor/core.h
@@ -130,6 +130,8 @@ enum spi_nor_option_flags {
 	SNOR_F_IO_MODE_EN_VOLATILE = BIT(11),
 	SNOR_F_SOFT_RESET	= BIT(12),
 	SNOR_F_SWP_IS_VOLATILE	= BIT(13),
+	SNOR_F_RWW		= BIT(14),
+	SNOR_F_ECC		= BIT(15),
 };
 
 struct spi_nor_read_command {
@@ -459,6 +461,7 @@ struct spi_nor_fixups {
  *   NO_CHIP_ERASE:           chip does not support chip erase.
  *   SPI_NOR_NO_FR:           can't do fastread.
  *   SPI_NOR_QUAD_PP:         flash supports Quad Input Page Program.
+ *   SPI_NOR_RWW:             flash supports reads while write.
  *
  * @no_sfdp_flags:  flags that indicate support that can be discovered via SFDP.
  *                  Used when SFDP tables are not defined in the flash. These
@@ -509,6 +512,7 @@ struct flash_info {
 #define NO_CHIP_ERASE			BIT(7)
 #define SPI_NOR_NO_FR			BIT(8)
 #define SPI_NOR_QUAD_PP			BIT(9)
+#define SPI_NOR_RWW			BIT(10)
 
 	u8 no_sfdp_flags;
 #define SPI_NOR_SKIP_SFDP		BIT(0)
diff --git a/drivers/mtd/spi-nor/debugfs.c b/drivers/mtd/spi-nor/debugfs.c
index 558ffecf8ae6..285bdcbaa113 100644
--- a/drivers/mtd/spi-nor/debugfs.c
+++ b/drivers/mtd/spi-nor/debugfs.c
@@ -25,6 +25,8 @@ static const char *const snor_f_names[] = {
 	SNOR_F_NAME(IO_MODE_EN_VOLATILE),
 	SNOR_F_NAME(SOFT_RESET),
 	SNOR_F_NAME(SWP_IS_VOLATILE),
+	SNOR_F_NAME(RWW),
+	SNOR_F_NAME(ECC),
 };
 #undef SNOR_F_NAME
 
diff --git a/drivers/mtd/spi-nor/spansion.c b/drivers/mtd/spi-nor/spansion.c
index 07fe0f6fdfe3..aef085b476de 100644
--- a/drivers/mtd/spi-nor/spansion.c
+++ b/drivers/mtd/spi-nor/spansion.c
@@ -218,6 +218,17 @@ static int cypress_nor_set_page_size(struct spi_nor *nor)
 	return 0;
 }
 
+static void cypress_nor_ecc_init(struct spi_nor *nor)
+{
+	/*
+	 * Programming is supported only in 16-byte ECC data unit granularity.
+	 * Byte-programming, bit-walking, or multiple program operations to the
+	 * same ECC data unit without an erase are not allowed.
+	 */
+	nor->params->writesize = 16;
+	nor->flags |= SNOR_F_ECC;
+}
+
 static int
 s25hx_t_post_bfpt_fixup(struct spi_nor *nor,
 			const struct sfdp_parameter_header *bfpt_header,
@@ -255,13 +266,10 @@ static void s25hx_t_post_sfdp_fixup(struct spi_nor *nor)
 
 static void s25hx_t_late_init(struct spi_nor *nor)
 {
-	struct spi_nor_flash_parameter *params = nor->params;
-
 	/* Fast Read 4B requires mode cycles */
-	params->reads[SNOR_CMD_READ_FAST].num_mode_clocks = 8;
+	nor->params->reads[SNOR_CMD_READ_FAST].num_mode_clocks = 8;
 
-	/* The writesize should be ECC data unit size */
-	params->writesize = 16;
+	cypress_nor_ecc_init(nor);
 }
 
 static struct spi_nor_fixups s25hx_t_fixups = {
@@ -324,7 +332,7 @@ static int s28hx_t_post_bfpt_fixup(struct spi_nor *nor,
 static void s28hx_t_late_init(struct spi_nor *nor)
 {
 	nor->params->octal_dtr_enable = cypress_nor_octal_dtr_enable;
-	nor->params->writesize = 16;
+	cypress_nor_ecc_init(nor);
 }
 
 static const struct spi_nor_fixups s28hx_t_fixups = {
diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index 326f992536a7..69b6a9265e4e 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -446,9 +446,9 @@ mt7530_pad_clk_setup(struct dsa_switch *ds, phy_interface_t interface)
 		else
 			ssc_delta = 0x87;
 		if (priv->id == ID_MT7621) {
-			/* PLL frequency: 150MHz: 1.2GBit */
+			/* PLL frequency: 125MHz: 1.0GBit */
 			if (xtal == HWTRAP_XTAL_40MHZ)
-				ncpo1 = 0x0780;
+				ncpo1 = 0x0640;
 			if (xtal == HWTRAP_XTAL_25MHZ)
 				ncpo1 = 0x0a00;
 		} else { /* PLL frequency: 250MHz: 2.0Gbit */
@@ -1015,9 +1015,9 @@ mt753x_cpu_port_enable(struct dsa_switch *ds, int port)
 	mt7530_write(priv, MT7530_PVC_P(port),
 		     PORT_SPEC_TAG);
 
-	/* Disable flooding by default */
-	mt7530_rmw(priv, MT7530_MFC, BC_FFP_MASK | UNM_FFP_MASK | UNU_FFP_MASK,
-		   BC_FFP(BIT(port)) | UNM_FFP(BIT(port)) | UNU_FFP(BIT(port)));
+	/* Enable flooding on the CPU port */
+	mt7530_set(priv, MT7530_MFC, BC_FFP(BIT(port)) | UNM_FFP(BIT(port)) |
+		   UNU_FFP(BIT(port)));
 
 	/* Set CPU port number */
 	if (priv->id == ID_MT7621)
@@ -2312,12 +2312,69 @@ mt7530_setup(struct dsa_switch *ds)
 	return 0;
 }
 
+static int
+mt7531_setup_common(struct dsa_switch *ds)
+{
+	struct mt7530_priv *priv = ds->priv;
+	struct dsa_port *cpu_dp;
+	int ret, i;
+
+	/* BPDU to CPU port */
+	dsa_switch_for_each_cpu_port(cpu_dp, ds) {
+		mt7530_rmw(priv, MT7531_CFC, MT7531_CPU_PMAP_MASK,
+			   BIT(cpu_dp->index));
+		break;
+	}
+	mt7530_rmw(priv, MT753X_BPC, MT753X_BPDU_PORT_FW_MASK,
+		   MT753X_BPDU_CPU_ONLY);
+
+	/* Enable and reset MIB counters */
+	mt7530_mib_reset(ds);
+
+	/* Disable flooding on all ports */
+	mt7530_clear(priv, MT7530_MFC, BC_FFP_MASK | UNM_FFP_MASK |
+		     UNU_FFP_MASK);
+
+	for (i = 0; i < MT7530_NUM_PORTS; i++) {
+		/* Disable forwarding by default on all ports */
+		mt7530_rmw(priv, MT7530_PCR_P(i), PCR_MATRIX_MASK,
+			   PCR_MATRIX_CLR);
+
+		/* Disable learning by default on all ports */
+		mt7530_set(priv, MT7530_PSC_P(i), SA_DIS);
+
+		mt7530_set(priv, MT7531_DBG_CNT(i), MT7531_DIS_CLR);
+
+		if (dsa_is_cpu_port(ds, i)) {
+			ret = mt753x_cpu_port_enable(ds, i);
+			if (ret)
+				return ret;
+		} else {
+			mt7530_port_disable(ds, i);
+
+			/* Set default PVID to 0 on all user ports */
+			mt7530_rmw(priv, MT7530_PPBV1_P(i), G0_PORT_VID_MASK,
+				   G0_PORT_VID_DEF);
+		}
+
+		/* Enable consistent egress tag */
+		mt7530_rmw(priv, MT7530_PVC_P(i), PVC_EG_TAG_MASK,
+			   PVC_EG_TAG(MT7530_VLAN_EG_CONSISTENT));
+	}
+
+	/* Flush the FDB table */
+	ret = mt7530_fdb_cmd(priv, MT7530_FDB_FLUSH, NULL);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
 static int
 mt7531_setup(struct dsa_switch *ds)
 {
 	struct mt7530_priv *priv = ds->priv;
 	struct mt7530_dummy_poll p;
-	struct dsa_port *cpu_dp;
 	u32 val, id;
 	int ret, i;
 
@@ -2395,44 +2452,7 @@ mt7531_setup(struct dsa_switch *ds)
 	mt7531_ind_c45_phy_write(priv, MT753X_CTRL_PHY_ADDR, MDIO_MMD_VEND2,
 				 CORE_PLL_GROUP4, val);
 
-	/* BPDU to CPU port */
-	dsa_switch_for_each_cpu_port(cpu_dp, ds) {
-		mt7530_rmw(priv, MT7531_CFC, MT7531_CPU_PMAP_MASK,
-			   BIT(cpu_dp->index));
-		break;
-	}
-	mt7530_rmw(priv, MT753X_BPC, MT753X_BPDU_PORT_FW_MASK,
-		   MT753X_BPDU_CPU_ONLY);
-
-	/* Enable and reset MIB counters */
-	mt7530_mib_reset(ds);
-
-	for (i = 0; i < MT7530_NUM_PORTS; i++) {
-		/* Disable forwarding by default on all ports */
-		mt7530_rmw(priv, MT7530_PCR_P(i), PCR_MATRIX_MASK,
-			   PCR_MATRIX_CLR);
-
-		/* Disable learning by default on all ports */
-		mt7530_set(priv, MT7530_PSC_P(i), SA_DIS);
-
-		mt7530_set(priv, MT7531_DBG_CNT(i), MT7531_DIS_CLR);
-
-		if (dsa_is_cpu_port(ds, i)) {
-			ret = mt753x_cpu_port_enable(ds, i);
-			if (ret)
-				return ret;
-		} else {
-			mt7530_port_disable(ds, i);
-
-			/* Set default PVID to 0 on all user ports */
-			mt7530_rmw(priv, MT7530_PPBV1_P(i), G0_PORT_VID_MASK,
-				   G0_PORT_VID_DEF);
-		}
-
-		/* Enable consistent egress tag */
-		mt7530_rmw(priv, MT7530_PVC_P(i), PVC_EG_TAG_MASK,
-			   PVC_EG_TAG(MT7530_VLAN_EG_CONSISTENT));
-	}
+	mt7531_setup_common(ds);
 
 	/* Setup VLAN ID 0 for VLAN-unaware bridges */
 	ret = mt7530_setup_vlan0(priv);
@@ -2442,11 +2462,6 @@ mt7531_setup(struct dsa_switch *ds)
 	ds->assisted_learning_on_cpu_port = true;
 	ds->mtu_enforcement_ingress = true;
 
-	/* Flush the FDB table */
-	ret = mt7530_fdb_cmd(priv, MT7530_FDB_FLUSH, NULL);
-	if (ret < 0)
-		return ret;
-
 	return 0;
 }
 
diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index e57d86484a3a..9959262ebad2 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -5113,6 +5113,7 @@ static const struct mv88e6xxx_ops mv88e6321_ops = {
 	.set_cpu_port = mv88e6095_g1_set_cpu_port,
 	.set_egress_port = mv88e6095_g1_set_egress_port,
 	.watchdog_ops = &mv88e6390_watchdog_ops,
+	.mgmt_rsvd2cpu = mv88e6352_g2_mgmt_rsvd2cpu,
 	.reset = mv88e6352_g1_reset,
 	.vtu_getnext = mv88e6185_g1_vtu_getnext,
 	.vtu_loadpurge = mv88e6185_g1_vtu_loadpurge,
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_qos.c b/drivers/net/ethernet/freescale/enetc/enetc_qos.c
index fcebb54224c0..a8539a8554a1 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_qos.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_qos.c
@@ -1255,7 +1255,7 @@ static int enetc_psfp_parse_clsflower(struct enetc_ndev_priv *priv,
 		int index;
 
 		index = enetc_get_free_index(priv);
-		if (sfi->handle < 0) {
+		if (index < 0) {
 			NL_SET_ERR_MSG_MOD(extack, "No Stream Filter resource!");
 			err = -ENOSPC;
 			goto free_fmi;
diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 2341597408d1..5fd3b4131982 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -3737,7 +3737,8 @@ static int fec_enet_txq_xmit_frame(struct fec_enet_private *fep,
 	entries_free = fec_enet_get_free_txdesc_num(txq);
 	if (entries_free < MAX_SKB_FRAGS + 1) {
 		netdev_err(fep->netdev, "NOT enough BD for SG!\n");
-		return NETDEV_TX_OK;
+		xdp_return_frame(frame);
+		return NETDEV_TX_BUSY;
 	}
 
 	/* Fill in a Tx ring entry */
@@ -3795,6 +3796,7 @@ static int fec_enet_xdp_xmit(struct net_device *dev,
 	struct fec_enet_private *fep = netdev_priv(dev);
 	struct fec_enet_priv_tx_q *txq;
 	int cpu = smp_processor_id();
+	unsigned int sent_frames = 0;
 	struct netdev_queue *nq;
 	unsigned int queue;
 	int i;
@@ -3805,8 +3807,11 @@ static int fec_enet_xdp_xmit(struct net_device *dev,
 
 	__netif_tx_lock(nq, cpu);
 
-	for (i = 0; i < num_frames; i++)
-		fec_enet_txq_xmit_frame(fep, txq, frames[i]);
+	for (i = 0; i < num_frames; i++) {
+		if (fec_enet_txq_xmit_frame(fep, txq, frames[i]) != 0)
+			break;
+		sent_frames++;
+	}
 
 	/* Make sure the update to bdp and tx_skbuff are performed. */
 	wmb();
@@ -3816,7 +3821,7 @@ static int fec_enet_xdp_xmit(struct net_device *dev,
 
 	__netif_tx_unlock(nq);
 
-	return num_frames;
+	return sent_frames;
 }
 
 static const struct net_device_ops fec_netdev_ops = {
diff --git a/drivers/net/ethernet/intel/ice/ice_tc_lib.c b/drivers/net/ethernet/intel/ice/ice_tc_lib.c
index ce72d512eddf..a9db9bdd7262 100644
--- a/drivers/net/ethernet/intel/ice/ice_tc_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_tc_lib.c
@@ -693,17 +693,18 @@ ice_eswitch_add_tc_fltr(struct ice_vsi *vsi, struct ice_tc_flower_fltr *fltr)
 	 * results into order of switch rule evaluation.
 	 */
 	rule_info.priority = 7;
+	rule_info.flags_info.act_valid = true;
 
 	if (fltr->direction == ICE_ESWITCH_FLTR_INGRESS) {
 		rule_info.sw_act.flag |= ICE_FLTR_RX;
 		rule_info.sw_act.src = hw->pf_id;
 		rule_info.rx = true;
+		rule_info.flags_info.act = ICE_SINGLE_ACT_LB_ENABLE;
 	} else {
 		rule_info.sw_act.flag |= ICE_FLTR_TX;
 		rule_info.sw_act.src = vsi->idx;
 		rule_info.rx = false;
 		rule_info.flags_info.act = ICE_SINGLE_ACT_LAN_ENABLE;
-		rule_info.flags_info.act_valid = true;
 	}
 
 	/* specify the cookie as filter_rule_id */
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c
index f8156fe4b1dc..0ee943db3dc9 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c
@@ -1035,9 +1035,6 @@ static void ixgbe_free_q_vector(struct ixgbe_adapter *adapter, int v_idx)
 	adapter->q_vector[v_idx] = NULL;
 	__netif_napi_del(&q_vector->napi);
 
-	if (static_key_enabled(&ixgbe_xdp_locking_key))
-		static_branch_dec(&ixgbe_xdp_locking_key);
-
 	/*
 	 * after a call to __netif_napi_del() napi may still be used and
 	 * ixgbe_get_stats64() might access the rings on this vector,
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 4507fba8747a..03e583cf4815 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -6495,6 +6495,10 @@ static int ixgbe_sw_init(struct ixgbe_adapter *adapter,
 	set_bit(0, adapter->fwd_bitmask);
 	set_bit(__IXGBE_DOWN, &adapter->state);
 
+	/* enable locking for XDP_TX if we have more CPUs than queues */
+	if (nr_cpu_ids > IXGBE_MAX_XDP_QS)
+		static_branch_enable(&ixgbe_xdp_locking_key);
+
 	return 0;
 }
 
@@ -10288,8 +10292,6 @@ static int ixgbe_xdp_setup(struct net_device *dev, struct bpf_prog *prog)
 	 */
 	if (nr_cpu_ids > IXGBE_MAX_XDP_QS * 2)
 		return -ENOMEM;
-	else if (nr_cpu_ids > IXGBE_MAX_XDP_QS)
-		static_branch_inc(&ixgbe_xdp_locking_key);
 
 	old_prog = xchg(&adapter->xdp_prog, prog);
 	need_reset = (!!prog != !!old_prog);
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
index 724df6398bbe..bd77152bb8d7 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
@@ -1231,6 +1231,14 @@ static inline void link_status_user_format(u64 lstat,
 	linfo->an = FIELD_GET(RESP_LINKSTAT_AN, lstat);
 	linfo->fec = FIELD_GET(RESP_LINKSTAT_FEC, lstat);
 	linfo->lmac_type_id = FIELD_GET(RESP_LINKSTAT_LMAC_TYPE, lstat);
+
+	if (linfo->lmac_type_id >= LMAC_MODE_MAX) {
+		dev_err(&cgx->pdev->dev, "Unknown lmac_type_id %d reported by firmware on cgx port%d:%d",
+			linfo->lmac_type_id, cgx->cgx_id, lmac_id);
+		strncpy(linfo->lmac_type, "Unknown", LMACTYPE_STR_LEN - 1);
+		return;
+	}
+
 	lmac_string = cgx_lmactype_string[linfo->lmac_type_id];
 	strncpy(linfo->lmac_type, lmac_string, LMACTYPE_STR_LEN - 1);
 }
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.c b/drivers/net/ethernet/marvell/octeontx2/af/mbox.c
index 2898931d5260..9690ac01f02c 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.c
@@ -157,7 +157,7 @@ EXPORT_SYMBOL(otx2_mbox_init);
  */
 int otx2_mbox_regions_init(struct otx2_mbox *mbox, void **hwbase,
 			   struct pci_dev *pdev, void *reg_base,
-			   int direction, int ndevs)
+			   int direction, int ndevs, unsigned long *pf_bmap)
 {
 	struct otx2_mbox_dev *mdev;
 	int devid, err;
@@ -169,6 +169,9 @@ int otx2_mbox_regions_init(struct otx2_mbox *mbox, void **hwbase,
 	mbox->hwbase = hwbase[0];
 
 	for (devid = 0; devid < ndevs; devid++) {
+		if (!test_bit(devid, pf_bmap))
+			continue;
+
 		mdev = &mbox->dev[devid];
 		mdev->mbase = hwbase[devid];
 		mdev->hwbase = hwbase[devid];
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
index d2584ebb7a70..d9ee56ff73b4 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
@@ -96,9 +96,10 @@ void otx2_mbox_destroy(struct otx2_mbox *mbox);
 int otx2_mbox_init(struct otx2_mbox *mbox, void __force *hwbase,
 		   struct pci_dev *pdev, void __force *reg_base,
 		   int direction, int ndevs);
+
 int otx2_mbox_regions_init(struct otx2_mbox *mbox, void __force **hwbase,
 			   struct pci_dev *pdev, void __force *reg_base,
-			   int direction, int ndevs);
+			   int direction, int ndevs, unsigned long *bmap);
 void otx2_mbox_msg_send(struct otx2_mbox *mbox, int devid);
 int otx2_mbox_wait_for_rsp(struct otx2_mbox *mbox, int devid);
 int otx2_mbox_busy_poll_for_rsp(struct otx2_mbox *mbox, int devid);
@@ -242,9 +243,9 @@ M(NPC_MCAM_READ_BASE_RULE, 0x6011, npc_read_base_steer_rule,            \
 M(NPC_MCAM_GET_STATS, 0x6012, npc_mcam_entry_stats,                     \
 				   npc_mcam_get_stats_req,              \
 				   npc_mcam_get_stats_rsp)              \
-M(NPC_GET_SECRET_KEY, 0x6013, npc_get_secret_key,                     \
-				   npc_get_secret_key_req,              \
-				   npc_get_secret_key_rsp)              \
+M(NPC_GET_FIELD_HASH_INFO, 0x6013, npc_get_field_hash_info,                     \
+				   npc_get_field_hash_info_req,              \
+				   npc_get_field_hash_info_rsp)              \
 M(NPC_GET_FIELD_STATUS, 0x6014, npc_get_field_status,                     \
 				   npc_get_field_status_req,              \
 				   npc_get_field_status_rsp)              \
@@ -1517,14 +1518,20 @@ struct npc_mcam_get_stats_rsp {
 	u8 stat_ena; /* enabled */
 };
 
-struct npc_get_secret_key_req {
+struct npc_get_field_hash_info_req {
 	struct mbox_msghdr hdr;
 	u8 intf;
 };
 
-struct npc_get_secret_key_rsp {
+struct npc_get_field_hash_info_rsp {
 	struct mbox_msghdr hdr;
 	u64 secret_key[3];
+#define NPC_MAX_HASH 2
+#define NPC_MAX_HASH_MASK 2
+	/* NPC_AF_INTF(0..1)_HASH(0..1)_MASK(0..1) */
+	u64 hash_mask[NPC_MAX_INTF][NPC_MAX_HASH][NPC_MAX_HASH_MASK];
+	/* NPC_AF_INTF(0..1)_HASH(0..1)_RESULT_CTRL */
+	u64 hash_ctrl[NPC_MAX_INTF][NPC_MAX_HASH];
 };
 
 enum ptp_op {
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mcs.c b/drivers/net/ethernet/marvell/octeontx2/af/mcs.c
index f68a6a0e3aa4..c43f19dfbd74 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/mcs.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mcs.c
@@ -473,6 +473,8 @@ void mcs_flowid_entry_write(struct mcs *mcs, u64 *data, u64 *mask, int flow_id,
 		for (reg_id = 0; reg_id < 4; reg_id++) {
 			reg = MCSX_CPM_RX_SLAVE_FLOWID_TCAM_DATAX(reg_id, flow_id);
 			mcs_reg_write(mcs, reg, data[reg_id]);
+		}
+		for (reg_id = 0; reg_id < 4; reg_id++) {
 			reg = MCSX_CPM_RX_SLAVE_FLOWID_TCAM_MASKX(reg_id, flow_id);
 			mcs_reg_write(mcs, reg, mask[reg_id]);
 		}
@@ -480,6 +482,8 @@ void mcs_flowid_entry_write(struct mcs *mcs, u64 *data, u64 *mask, int flow_id,
 		for (reg_id = 0; reg_id < 4; reg_id++) {
 			reg = MCSX_CPM_TX_SLAVE_FLOWID_TCAM_DATAX(reg_id, flow_id);
 			mcs_reg_write(mcs, reg, data[reg_id]);
+		}
+		for (reg_id = 0; reg_id < 4; reg_id++) {
 			reg = MCSX_CPM_TX_SLAVE_FLOWID_TCAM_MASKX(reg_id, flow_id);
 			mcs_reg_write(mcs, reg, mask[reg_id]);
 		}
@@ -494,6 +498,9 @@ int mcs_install_flowid_bypass_entry(struct mcs *mcs)
 
 	/* Flow entry */
 	flow_id = mcs->hw->tcam_entries - MCS_RSRC_RSVD_CNT;
+	__set_bit(flow_id, mcs->rx.flow_ids.bmap);
+	__set_bit(flow_id, mcs->tx.flow_ids.bmap);
+
 	for (reg_id = 0; reg_id < 4; reg_id++) {
 		reg = MCSX_CPM_RX_SLAVE_FLOWID_TCAM_MASKX(reg_id, flow_id);
 		mcs_reg_write(mcs, reg, GENMASK_ULL(63, 0));
@@ -504,6 +511,8 @@ int mcs_install_flowid_bypass_entry(struct mcs *mcs)
 	}
 	/* secy */
 	secy_id = mcs->hw->secy_entries - MCS_RSRC_RSVD_CNT;
+	__set_bit(secy_id, mcs->rx.secy.bmap);
+	__set_bit(secy_id, mcs->tx.secy.bmap);
 
 	/* Set validate frames to NULL and enable control port */
 	plcy = 0x7ull;
@@ -528,6 +537,7 @@ int mcs_install_flowid_bypass_entry(struct mcs *mcs)
 	/* Enable Flowid entry */
 	mcs_ena_dis_flowid_entry(mcs, flow_id, MCS_RX, true);
 	mcs_ena_dis_flowid_entry(mcs, flow_id, MCS_TX, true);
+
 	return 0;
 }
 
@@ -926,60 +936,42 @@ static void mcs_tx_misc_intr_handler(struct mcs *mcs, u64 intr)
 	mcs_add_intr_wq_entry(mcs, &event);
 }
 
-static void mcs_bbe_intr_handler(struct mcs *mcs, u64 intr, enum mcs_direction dir)
+void cn10kb_mcs_bbe_intr_handler(struct mcs *mcs, u64 intr,
+				 enum mcs_direction dir)
 {
-	struct mcs_intr_event event = { 0 };
-	int i;
+	u64 val, reg;
+	int lmac;
 
-	if (!(intr & MCS_BBE_INT_MASK))
+	if (!(intr & 0x6ULL))
 		return;
 
-	event.mcs_id = mcs->mcs_id;
-	event.pcifunc = mcs->pf_map[0];
+	if (intr & BIT_ULL(1))
+		reg = (dir == MCS_RX) ? MCSX_BBE_RX_SLAVE_DFIFO_OVERFLOW_0 :
+					MCSX_BBE_TX_SLAVE_DFIFO_OVERFLOW_0;
+	else
+		reg = (dir == MCS_RX) ? MCSX_BBE_RX_SLAVE_PLFIFO_OVERFLOW_0 :
+					MCSX_BBE_TX_SLAVE_PLFIFO_OVERFLOW_0;
+	val = mcs_reg_read(mcs, reg);
 
-	for (i = 0; i < MCS_MAX_BBE_INT; i++) {
-		if (!(intr & BIT_ULL(i)))
+	/* policy/data over flow occurred */
+	for (lmac = 0; lmac < mcs->hw->lmac_cnt; lmac++) {
+		if (!(val & BIT_ULL(lmac)))
 			continue;
-
-		/* Lower nibble denotes data fifo overflow interrupts and
-		 * upper nibble indicates policy fifo overflow interrupts.
-		 */
-		if (intr & 0xFULL)
-			event.intr_mask = (dir == MCS_RX) ?
-					  MCS_BBE_RX_DFIFO_OVERFLOW_INT :
-					  MCS_BBE_TX_DFIFO_OVERFLOW_INT;
-		else
-			event.intr_mask = (dir == MCS_RX) ?
-					  MCS_BBE_RX_PLFIFO_OVERFLOW_INT :
-					  MCS_BBE_TX_PLFIFO_OVERFLOW_INT;
-
-		/* Notify the lmac_id info which ran into BBE fatal error */
-		event.lmac_id = i & 0x3ULL;
-		mcs_add_intr_wq_entry(mcs, &event);
+		dev_warn(mcs->dev, "BEE:Policy or data overflow occurred on lmac:%d\n", lmac);
 	}
 }
 
-static void mcs_pab_intr_handler(struct mcs *mcs, u64 intr, enum mcs_direction dir)
+void cn10kb_mcs_pab_intr_handler(struct mcs *mcs, u64 intr,
+				 enum mcs_direction dir)
 {
-	struct mcs_intr_event event = { 0 };
-	int i;
+	int lmac;
 
-	if (!(intr & MCS_PAB_INT_MASK))
+	if (!(intr & 0xFFFFFULL))
 		return;
 
-	event.mcs_id = mcs->mcs_id;
-	event.pcifunc = mcs->pf_map[0];
-
-	for (i = 0; i < MCS_MAX_PAB_INT; i++) {
-		if (!(intr & BIT_ULL(i)))
-			continue;
-
-		event.intr_mask = (dir == MCS_RX) ? MCS_PAB_RX_CHAN_OVERFLOW_INT :
-				  MCS_PAB_TX_CHAN_OVERFLOW_INT;
-
-		/* Notify the lmac_id info which ran into PAB fatal error */
-		event.lmac_id = i;
-		mcs_add_intr_wq_entry(mcs, &event);
+	for (lmac = 0; lmac < mcs->hw->lmac_cnt; lmac++) {
+		if (intr & BIT_ULL(lmac))
+			dev_warn(mcs->dev, "PAB: overflow occurred on lmac:%d\n", lmac);
 	}
 }
 
@@ -988,9 +980,8 @@ static irqreturn_t mcs_ip_intr_handler(int irq, void *mcs_irq)
 	struct mcs *mcs = (struct mcs *)mcs_irq;
 	u64 intr, cpm_intr, bbe_intr, pab_intr;
 
-	/* Disable and clear the interrupt */
+	/* Disable  the interrupt */
 	mcs_reg_write(mcs, MCSX_IP_INT_ENA_W1C, BIT_ULL(0));
-	mcs_reg_write(mcs, MCSX_IP_INT, BIT_ULL(0));
 
 	/* Check which block has interrupt*/
 	intr = mcs_reg_read(mcs, MCSX_TOP_SLAVE_INT_SUM);
@@ -1037,7 +1028,7 @@ static irqreturn_t mcs_ip_intr_handler(int irq, void *mcs_irq)
 	/* BBE RX */
 	if (intr & MCS_BBE_RX_INT_ENA) {
 		bbe_intr = mcs_reg_read(mcs, MCSX_BBE_RX_SLAVE_BBE_INT);
-		mcs_bbe_intr_handler(mcs, bbe_intr, MCS_RX);
+		mcs->mcs_ops->mcs_bbe_intr_handler(mcs, bbe_intr, MCS_RX);
 
 		/* Clear the interrupt */
 		mcs_reg_write(mcs, MCSX_BBE_RX_SLAVE_BBE_INT_INTR_RW, 0);
@@ -1047,7 +1038,7 @@ static irqreturn_t mcs_ip_intr_handler(int irq, void *mcs_irq)
 	/* BBE TX */
 	if (intr & MCS_BBE_TX_INT_ENA) {
 		bbe_intr = mcs_reg_read(mcs, MCSX_BBE_TX_SLAVE_BBE_INT);
-		mcs_bbe_intr_handler(mcs, bbe_intr, MCS_TX);
+		mcs->mcs_ops->mcs_bbe_intr_handler(mcs, bbe_intr, MCS_TX);
 
 		/* Clear the interrupt */
 		mcs_reg_write(mcs, MCSX_BBE_TX_SLAVE_BBE_INT_INTR_RW, 0);
@@ -1057,7 +1048,7 @@ static irqreturn_t mcs_ip_intr_handler(int irq, void *mcs_irq)
 	/* PAB RX */
 	if (intr & MCS_PAB_RX_INT_ENA) {
 		pab_intr = mcs_reg_read(mcs, MCSX_PAB_RX_SLAVE_PAB_INT);
-		mcs_pab_intr_handler(mcs, pab_intr, MCS_RX);
+		mcs->mcs_ops->mcs_pab_intr_handler(mcs, pab_intr, MCS_RX);
 
 		/* Clear the interrupt */
 		mcs_reg_write(mcs, MCSX_PAB_RX_SLAVE_PAB_INT_INTR_RW, 0);
@@ -1067,14 +1058,15 @@ static irqreturn_t mcs_ip_intr_handler(int irq, void *mcs_irq)
 	/* PAB TX */
 	if (intr & MCS_PAB_TX_INT_ENA) {
 		pab_intr = mcs_reg_read(mcs, MCSX_PAB_TX_SLAVE_PAB_INT);
-		mcs_pab_intr_handler(mcs, pab_intr, MCS_TX);
+		mcs->mcs_ops->mcs_pab_intr_handler(mcs, pab_intr, MCS_TX);
 
 		/* Clear the interrupt */
 		mcs_reg_write(mcs, MCSX_PAB_TX_SLAVE_PAB_INT_INTR_RW, 0);
 		mcs_reg_write(mcs, MCSX_PAB_TX_SLAVE_PAB_INT, pab_intr);
 	}
 
-	/* Enable the interrupt */
+	/* Clear and enable the interrupt */
+	mcs_reg_write(mcs, MCSX_IP_INT, BIT_ULL(0));
 	mcs_reg_write(mcs, MCSX_IP_INT_ENA_W1S, BIT_ULL(0));
 
 	return IRQ_HANDLED;
@@ -1156,7 +1148,7 @@ static int mcs_register_interrupts(struct mcs *mcs)
 		return ret;
 	}
 
-	ret = request_irq(pci_irq_vector(mcs->pdev, MCS_INT_VEC_IP),
+	ret = request_irq(pci_irq_vector(mcs->pdev, mcs->hw->ip_vec),
 			  mcs_ip_intr_handler, 0, "MCS_IP", mcs);
 	if (ret) {
 		dev_err(mcs->dev, "MCS IP irq registration failed\n");
@@ -1175,11 +1167,11 @@ static int mcs_register_interrupts(struct mcs *mcs)
 	mcs_reg_write(mcs, MCSX_CPM_TX_SLAVE_TX_INT_ENB, 0x7ULL);
 	mcs_reg_write(mcs, MCSX_CPM_RX_SLAVE_RX_INT_ENB, 0x7FULL);
 
-	mcs_reg_write(mcs, MCSX_BBE_RX_SLAVE_BBE_INT_ENB, 0xff);
-	mcs_reg_write(mcs, MCSX_BBE_TX_SLAVE_BBE_INT_ENB, 0xff);
+	mcs_reg_write(mcs, MCSX_BBE_RX_SLAVE_BBE_INT_ENB, 0xFFULL);
+	mcs_reg_write(mcs, MCSX_BBE_TX_SLAVE_BBE_INT_ENB, 0xFFULL);
 
-	mcs_reg_write(mcs, MCSX_PAB_RX_SLAVE_PAB_INT_ENB, 0xff);
-	mcs_reg_write(mcs, MCSX_PAB_TX_SLAVE_PAB_INT_ENB, 0xff);
+	mcs_reg_write(mcs, MCSX_PAB_RX_SLAVE_PAB_INT_ENB, 0xFFFFFULL);
+	mcs_reg_write(mcs, MCSX_PAB_TX_SLAVE_PAB_INT_ENB, 0xFFFFFULL);
 
 	mcs->tx_sa_active = alloc_mem(mcs, mcs->hw->sc_entries);
 	if (!mcs->tx_sa_active) {
@@ -1190,7 +1182,7 @@ static int mcs_register_interrupts(struct mcs *mcs)
 	return ret;
 
 free_irq:
-	free_irq(pci_irq_vector(mcs->pdev, MCS_INT_VEC_IP), mcs);
+	free_irq(pci_irq_vector(mcs->pdev, mcs->hw->ip_vec), mcs);
 exit:
 	pci_free_irq_vectors(mcs->pdev);
 	mcs->num_vec = 0;
@@ -1325,8 +1317,11 @@ void mcs_reset_port(struct mcs *mcs, u8 port_id, u8 reset)
 void mcs_set_lmac_mode(struct mcs *mcs, int lmac_id, u8 mode)
 {
 	u64 reg;
+	int id = lmac_id * 2;
 
-	reg = MCSX_MCS_TOP_SLAVE_CHANNEL_CFG(lmac_id * 2);
+	reg = MCSX_MCS_TOP_SLAVE_CHANNEL_CFG(id);
+	mcs_reg_write(mcs, reg, (u64)mode);
+	reg = MCSX_MCS_TOP_SLAVE_CHANNEL_CFG((id + 1));
 	mcs_reg_write(mcs, reg, (u64)mode);
 }
 
@@ -1484,6 +1479,7 @@ void cn10kb_mcs_set_hw_capabilities(struct mcs *mcs)
 	hw->lmac_cnt = 20;		/* lmacs/ports per mcs block */
 	hw->mcs_x2p_intf = 5;		/* x2p clabration intf */
 	hw->mcs_blks = 1;		/* MCS blocks */
+	hw->ip_vec = MCS_CN10KB_INT_VEC_IP; /* IP vector */
 }
 
 static struct mcs_ops cn10kb_mcs_ops = {
@@ -1492,6 +1488,8 @@ static struct mcs_ops cn10kb_mcs_ops = {
 	.mcs_tx_sa_mem_map_write	= cn10kb_mcs_tx_sa_mem_map_write,
 	.mcs_rx_sa_mem_map_write	= cn10kb_mcs_rx_sa_mem_map_write,
 	.mcs_flowid_secy_map		= cn10kb_mcs_flowid_secy_map,
+	.mcs_bbe_intr_handler		= cn10kb_mcs_bbe_intr_handler,
+	.mcs_pab_intr_handler		= cn10kb_mcs_pab_intr_handler,
 };
 
 static int mcs_probe(struct pci_dev *pdev, const struct pci_device_id *id)
@@ -1592,7 +1590,7 @@ static void mcs_remove(struct pci_dev *pdev)
 
 	/* Set MCS to external bypass */
 	mcs_set_external_bypass(mcs, true);
-	free_irq(pci_irq_vector(pdev, MCS_INT_VEC_IP), mcs);
+	free_irq(pci_irq_vector(pdev, mcs->hw->ip_vec), mcs);
 	pci_free_irq_vectors(pdev);
 	pci_release_regions(pdev);
 	pci_disable_device(pdev);
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mcs.h b/drivers/net/ethernet/marvell/octeontx2/af/mcs.h
index 64dc2b80e15d..0f89dcb76465 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/mcs.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mcs.h
@@ -43,24 +43,15 @@
 /* Reserved resources for default bypass entry */
 #define MCS_RSRC_RSVD_CNT		1
 
-/* MCS Interrupt Vector Enumeration */
-enum mcs_int_vec_e {
-	MCS_INT_VEC_MIL_RX_GBL		= 0x0,
-	MCS_INT_VEC_MIL_RX_LMACX	= 0x1,
-	MCS_INT_VEC_MIL_TX_LMACX	= 0x5,
-	MCS_INT_VEC_HIL_RX_GBL		= 0x9,
-	MCS_INT_VEC_HIL_RX_LMACX	= 0xa,
-	MCS_INT_VEC_HIL_TX_GBL		= 0xe,
-	MCS_INT_VEC_HIL_TX_LMACX	= 0xf,
-	MCS_INT_VEC_IP			= 0x13,
-	MCS_INT_VEC_CNT			= 0x14,
-};
+/* MCS Interrupt Vector */
+#define MCS_CNF10KB_INT_VEC_IP	0x13
+#define MCS_CN10KB_INT_VEC_IP	0x53
 
 #define MCS_MAX_BBE_INT			8ULL
 #define MCS_BBE_INT_MASK		0xFFULL
 
-#define MCS_MAX_PAB_INT			4ULL
-#define MCS_PAB_INT_MASK		0xFULL
+#define MCS_MAX_PAB_INT		8ULL
+#define MCS_PAB_INT_MASK	0xFULL
 
 #define MCS_BBE_RX_INT_ENA		BIT_ULL(0)
 #define MCS_BBE_TX_INT_ENA		BIT_ULL(1)
@@ -137,6 +128,7 @@ struct hwinfo {
 	u8 lmac_cnt;
 	u8 mcs_blks;
 	unsigned long	lmac_bmap; /* bitmap of enabled mcs lmac */
+	u16 ip_vec;
 };
 
 struct mcs {
@@ -165,6 +157,8 @@ struct mcs_ops {
 	void	(*mcs_tx_sa_mem_map_write)(struct mcs *mcs, struct mcs_tx_sc_sa_map *map);
 	void	(*mcs_rx_sa_mem_map_write)(struct mcs *mcs, struct mcs_rx_sc_sa_map *map);
 	void	(*mcs_flowid_secy_map)(struct mcs *mcs, struct secy_mem_map *map, int dir);
+	void	(*mcs_bbe_intr_handler)(struct mcs *mcs, u64 intr, enum mcs_direction dir);
+	void	(*mcs_pab_intr_handler)(struct mcs *mcs, u64 intr, enum mcs_direction dir);
 };
 
 extern struct pci_driver mcs_driver;
@@ -219,6 +213,8 @@ void cn10kb_mcs_tx_sa_mem_map_write(struct mcs *mcs, struct mcs_tx_sc_sa_map *ma
 void cn10kb_mcs_flowid_secy_map(struct mcs *mcs, struct secy_mem_map *map, int dir);
 void cn10kb_mcs_rx_sa_mem_map_write(struct mcs *mcs, struct mcs_rx_sc_sa_map *map);
 void cn10kb_mcs_parser_cfg(struct mcs *mcs);
+void cn10kb_mcs_pab_intr_handler(struct mcs *mcs, u64 intr, enum mcs_direction dir);
+void cn10kb_mcs_bbe_intr_handler(struct mcs *mcs, u64 intr, enum mcs_direction dir);
 
 /* CNF10K-B APIs */
 struct mcs_ops *cnf10kb_get_mac_ops(void);
@@ -229,6 +225,8 @@ void cnf10kb_mcs_rx_sa_mem_map_write(struct mcs *mcs, struct mcs_rx_sc_sa_map *m
 void cnf10kb_mcs_parser_cfg(struct mcs *mcs);
 void cnf10kb_mcs_tx_pn_thresh_reached_handler(struct mcs *mcs);
 void cnf10kb_mcs_tx_pn_wrapped_handler(struct mcs *mcs);
+void cnf10kb_mcs_bbe_intr_handler(struct mcs *mcs, u64 intr, enum mcs_direction dir);
+void cnf10kb_mcs_pab_intr_handler(struct mcs *mcs, u64 intr, enum mcs_direction dir);
 
 /* Stats APIs */
 void mcs_get_sc_stats(struct mcs *mcs, struct mcs_sc_stats *stats, int id, int dir);
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mcs_cnf10kb.c b/drivers/net/ethernet/marvell/octeontx2/af/mcs_cnf10kb.c
index 7b6205414428..9f9b904ab2cd 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/mcs_cnf10kb.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mcs_cnf10kb.c
@@ -13,6 +13,8 @@ static struct mcs_ops cnf10kb_mcs_ops   = {
 	.mcs_tx_sa_mem_map_write	= cnf10kb_mcs_tx_sa_mem_map_write,
 	.mcs_rx_sa_mem_map_write	= cnf10kb_mcs_rx_sa_mem_map_write,
 	.mcs_flowid_secy_map		= cnf10kb_mcs_flowid_secy_map,
+	.mcs_bbe_intr_handler		= cnf10kb_mcs_bbe_intr_handler,
+	.mcs_pab_intr_handler		= cnf10kb_mcs_pab_intr_handler,
 };
 
 struct mcs_ops *cnf10kb_get_mac_ops(void)
@@ -31,6 +33,7 @@ void cnf10kb_mcs_set_hw_capabilities(struct mcs *mcs)
 	hw->lmac_cnt = 4;		/* lmacs/ports per mcs block */
 	hw->mcs_x2p_intf = 1;		/* x2p clabration intf */
 	hw->mcs_blks = 7;		/* MCS blocks */
+	hw->ip_vec = MCS_CNF10KB_INT_VEC_IP; /* IP vector */
 }
 
 void cnf10kb_mcs_parser_cfg(struct mcs *mcs)
@@ -212,3 +215,63 @@ void cnf10kb_mcs_tx_pn_wrapped_handler(struct mcs *mcs)
 		mcs_add_intr_wq_entry(mcs, &event);
 	}
 }
+
+void cnf10kb_mcs_bbe_intr_handler(struct mcs *mcs, u64 intr,
+				  enum mcs_direction dir)
+{
+	struct mcs_intr_event event = { 0 };
+	int i;
+
+	if (!(intr & MCS_BBE_INT_MASK))
+		return;
+
+	event.mcs_id = mcs->mcs_id;
+	event.pcifunc = mcs->pf_map[0];
+
+	for (i = 0; i < MCS_MAX_BBE_INT; i++) {
+		if (!(intr & BIT_ULL(i)))
+			continue;
+
+		/* Lower nibble denotes data fifo overflow interrupts and
+		 * upper nibble indicates policy fifo overflow interrupts.
+		 */
+		if (intr & 0xFULL)
+			event.intr_mask = (dir == MCS_RX) ?
+					  MCS_BBE_RX_DFIFO_OVERFLOW_INT :
+					  MCS_BBE_TX_DFIFO_OVERFLOW_INT;
+		else
+			event.intr_mask = (dir == MCS_RX) ?
+					  MCS_BBE_RX_PLFIFO_OVERFLOW_INT :
+					  MCS_BBE_TX_PLFIFO_OVERFLOW_INT;
+
+		/* Notify the lmac_id info which ran into BBE fatal error */
+		event.lmac_id = i & 0x3ULL;
+		mcs_add_intr_wq_entry(mcs, &event);
+	}
+}
+
+void cnf10kb_mcs_pab_intr_handler(struct mcs *mcs, u64 intr,
+				  enum mcs_direction dir)
+{
+	struct mcs_intr_event event = { 0 };
+	int i;
+
+	if (!(intr & MCS_PAB_INT_MASK))
+		return;
+
+	event.mcs_id = mcs->mcs_id;
+	event.pcifunc = mcs->pf_map[0];
+
+	for (i = 0; i < MCS_MAX_PAB_INT; i++) {
+		if (!(intr & BIT_ULL(i)))
+			continue;
+
+		event.intr_mask = (dir == MCS_RX) ?
+				  MCS_PAB_RX_CHAN_OVERFLOW_INT :
+				  MCS_PAB_TX_CHAN_OVERFLOW_INT;
+
+		/* Notify the lmac_id info which ran into PAB fatal error */
+		event.lmac_id = i;
+		mcs_add_intr_wq_entry(mcs, &event);
+	}
+}
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mcs_reg.h b/drivers/net/ethernet/marvell/octeontx2/af/mcs_reg.h
index c95a8b8f5eaf..f3ab01fc363c 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/mcs_reg.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mcs_reg.h
@@ -97,6 +97,7 @@
 #define MCSX_PEX_TX_SLAVE_VLAN_CFGX(a)          (0x46f8ull + (a) * 0x8ull)
 #define MCSX_PEX_TX_SLAVE_CUSTOM_TAG_REL_MODE_SEL(a)	(0x788ull + (a) * 0x8ull)
 #define MCSX_PEX_TX_SLAVE_PORT_CONFIG(a)		(0x4738ull + (a) * 0x8ull)
+#define MCSX_PEX_RX_SLAVE_PORT_CFGX(a)		(0x3b98ull + (a) * 0x8ull)
 #define MCSX_PEX_RX_SLAVE_RULE_ETYPE_CFGX(a) ({	\
 	u64 offset;					\
 							\
@@ -275,7 +276,10 @@
 #define MCSX_BBE_RX_SLAVE_CAL_ENTRY			0x180ull
 #define MCSX_BBE_RX_SLAVE_CAL_LEN			0x188ull
 #define MCSX_PAB_RX_SLAVE_FIFO_SKID_CFGX(a)		(0x290ull + (a) * 0x40ull)
-
+#define MCSX_BBE_RX_SLAVE_DFIFO_OVERFLOW_0		0xe20
+#define MCSX_BBE_TX_SLAVE_DFIFO_OVERFLOW_0		0x1298
+#define MCSX_BBE_RX_SLAVE_PLFIFO_OVERFLOW_0		0xe40
+#define MCSX_BBE_TX_SLAVE_PLFIFO_OVERFLOW_0		0x12b8
 #define MCSX_BBE_RX_SLAVE_BBE_INT ({	\
 	u64 offset;			\
 					\
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mcs_rvu_if.c b/drivers/net/ethernet/marvell/octeontx2/af/mcs_rvu_if.c
index eb25e458266c..dfd23580e3b8 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/mcs_rvu_if.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mcs_rvu_if.c
@@ -11,6 +11,7 @@
 
 #include "mcs.h"
 #include "rvu.h"
+#include "mcs_reg.h"
 #include "lmac_common.h"
 
 #define M(_name, _id, _fn_name, _req_type, _rsp_type)			\
@@ -32,6 +33,42 @@ static struct _req_type __maybe_unused					\
 MBOX_UP_MCS_MESSAGES
 #undef M
 
+void rvu_mcs_ptp_cfg(struct rvu *rvu, u8 rpm_id, u8 lmac_id, bool ena)
+{
+	struct mcs *mcs;
+	u64 cfg;
+	u8 port;
+
+	if (!rvu->mcs_blk_cnt)
+		return;
+
+	/* When ptp is enabled, RPM appends 8B header for all
+	 * RX packets. MCS PEX need to configure to skip 8B
+	 * during packet parsing.
+	 */
+
+	/* CNF10K-B */
+	if (rvu->mcs_blk_cnt > 1) {
+		mcs = mcs_get_pdata(rpm_id);
+		cfg = mcs_reg_read(mcs, MCSX_PEX_RX_SLAVE_PEX_CONFIGURATION);
+		if (ena)
+			cfg |= BIT_ULL(lmac_id);
+		else
+			cfg &= ~BIT_ULL(lmac_id);
+		mcs_reg_write(mcs, MCSX_PEX_RX_SLAVE_PEX_CONFIGURATION, cfg);
+		return;
+	}
+	/* CN10KB */
+	mcs = mcs_get_pdata(0);
+	port = (rpm_id * rvu->hw->lmac_per_cgx) + lmac_id;
+	cfg = mcs_reg_read(mcs, MCSX_PEX_RX_SLAVE_PORT_CFGX(port));
+	if (ena)
+		cfg |= BIT_ULL(0);
+	else
+		cfg &= ~BIT_ULL(0);
+	mcs_reg_write(mcs, MCSX_PEX_RX_SLAVE_PORT_CFGX(port), cfg);
+}
+
 int rvu_mbox_handler_mcs_set_lmac_mode(struct rvu *rvu,
 				       struct mcs_set_lmac_mode *req,
 				       struct msg_rsp *rsp)
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
index 3f5e09b77d4b..873f081c030d 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
@@ -2274,7 +2274,7 @@ static inline void rvu_afvf_mbox_up_handler(struct work_struct *work)
 }
 
 static int rvu_get_mbox_regions(struct rvu *rvu, void **mbox_addr,
-				int num, int type)
+				int num, int type, unsigned long *pf_bmap)
 {
 	struct rvu_hwinfo *hw = rvu->hw;
 	int region;
@@ -2286,6 +2286,9 @@ static int rvu_get_mbox_regions(struct rvu *rvu, void **mbox_addr,
 	 */
 	if (type == TYPE_AFVF) {
 		for (region = 0; region < num; region++) {
+			if (!test_bit(region, pf_bmap))
+				continue;
+
 			if (hw->cap.per_pf_mbox_regs) {
 				bar4 = rvu_read64(rvu, BLKADDR_RVUM,
 						  RVU_AF_PFX_BAR4_ADDR(0)) +
@@ -2307,6 +2310,9 @@ static int rvu_get_mbox_regions(struct rvu *rvu, void **mbox_addr,
 	 * RVU_AF_PF_BAR4_ADDR register.
 	 */
 	for (region = 0; region < num; region++) {
+		if (!test_bit(region, pf_bmap))
+			continue;
+
 		if (hw->cap.per_pf_mbox_regs) {
 			bar4 = rvu_read64(rvu, BLKADDR_RVUM,
 					  RVU_AF_PFX_BAR4_ADDR(region));
@@ -2335,20 +2341,41 @@ static int rvu_mbox_init(struct rvu *rvu, struct mbox_wq_info *mw,
 	int err = -EINVAL, i, dir, dir_up;
 	void __iomem *reg_base;
 	struct rvu_work *mwork;
+	unsigned long *pf_bmap;
 	void **mbox_regions;
 	const char *name;
+	u64 cfg;
 
-	mbox_regions = kcalloc(num, sizeof(void *), GFP_KERNEL);
-	if (!mbox_regions)
+	pf_bmap = bitmap_zalloc(num, GFP_KERNEL);
+	if (!pf_bmap)
 		return -ENOMEM;
 
+	/* RVU VFs */
+	if (type == TYPE_AFVF)
+		bitmap_set(pf_bmap, 0, num);
+
+	if (type == TYPE_AFPF) {
+		/* Mark enabled PFs in bitmap */
+		for (i = 0; i < num; i++) {
+			cfg = rvu_read64(rvu, BLKADDR_RVUM, RVU_PRIV_PFX_CFG(i));
+			if (cfg & BIT_ULL(20))
+				set_bit(i, pf_bmap);
+		}
+	}
+
+	mbox_regions = kcalloc(num, sizeof(void *), GFP_KERNEL);
+	if (!mbox_regions) {
+		err = -ENOMEM;
+		goto free_bitmap;
+	}
+
 	switch (type) {
 	case TYPE_AFPF:
 		name = "rvu_afpf_mailbox";
 		dir = MBOX_DIR_AFPF;
 		dir_up = MBOX_DIR_AFPF_UP;
 		reg_base = rvu->afreg_base;
-		err = rvu_get_mbox_regions(rvu, mbox_regions, num, TYPE_AFPF);
+		err = rvu_get_mbox_regions(rvu, mbox_regions, num, TYPE_AFPF, pf_bmap);
 		if (err)
 			goto free_regions;
 		break;
@@ -2357,7 +2384,7 @@ static int rvu_mbox_init(struct rvu *rvu, struct mbox_wq_info *mw,
 		dir = MBOX_DIR_PFVF;
 		dir_up = MBOX_DIR_PFVF_UP;
 		reg_base = rvu->pfreg_base;
-		err = rvu_get_mbox_regions(rvu, mbox_regions, num, TYPE_AFVF);
+		err = rvu_get_mbox_regions(rvu, mbox_regions, num, TYPE_AFVF, pf_bmap);
 		if (err)
 			goto free_regions;
 		break;
@@ -2388,16 +2415,19 @@ static int rvu_mbox_init(struct rvu *rvu, struct mbox_wq_info *mw,
 	}
 
 	err = otx2_mbox_regions_init(&mw->mbox, mbox_regions, rvu->pdev,
-				     reg_base, dir, num);
+				     reg_base, dir, num, pf_bmap);
 	if (err)
 		goto exit;
 
 	err = otx2_mbox_regions_init(&mw->mbox_up, mbox_regions, rvu->pdev,
-				     reg_base, dir_up, num);
+				     reg_base, dir_up, num, pf_bmap);
 	if (err)
 		goto exit;
 
 	for (i = 0; i < num; i++) {
+		if (!test_bit(i, pf_bmap))
+			continue;
+
 		mwork = &mw->mbox_wrk[i];
 		mwork->rvu = rvu;
 		INIT_WORK(&mwork->work, mbox_handler);
@@ -2406,8 +2436,7 @@ static int rvu_mbox_init(struct rvu *rvu, struct mbox_wq_info *mw,
 		mwork->rvu = rvu;
 		INIT_WORK(&mwork->work, mbox_up_handler);
 	}
-	kfree(mbox_regions);
-	return 0;
+	goto free_regions;
 
 exit:
 	destroy_workqueue(mw->mbox_wq);
@@ -2416,6 +2445,8 @@ static int rvu_mbox_init(struct rvu *rvu, struct mbox_wq_info *mw,
 		iounmap((void __iomem *)mbox_regions[num]);
 free_regions:
 	kfree(mbox_regions);
+free_bitmap:
+	bitmap_free(pf_bmap);
 	return err;
 }
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
index f6c45cf27caf..f0502556d127 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
@@ -899,6 +899,7 @@ int rvu_get_hwvf(struct rvu *rvu, int pcifunc);
 /* CN10K MCS */
 int rvu_mcs_init(struct rvu *rvu);
 int rvu_mcs_flr_handler(struct rvu *rvu, u16 pcifunc);
+void rvu_mcs_ptp_cfg(struct rvu *rvu, u8 rpm_id, u8 lmac_id, bool ena);
 void rvu_mcs_exit(struct rvu *rvu);
 
 #endif /* RVU_H */
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
index 438b212fb54a..83b342fa8d75 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
@@ -773,6 +773,8 @@ static int rvu_cgx_ptp_rx_cfg(struct rvu *rvu, u16 pcifunc, bool enable)
 	/* This flag is required to clean up CGX conf if app gets killed */
 	pfvf->hw_rx_tstamp_en = enable;
 
+	/* Inform MCS about 8B RX header */
+	rvu_mcs_ptp_cfg(rvu, cgx_id, lmac_id, enable);
 	return 0;
 }
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cn10k.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cn10k.c
index 7dbbc115cde4..f9faa5b23bb9 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cn10k.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cn10k.c
@@ -60,13 +60,14 @@ static int rvu_get_lmtaddr(struct rvu *rvu, u16 pcifunc,
 			   u64 iova, u64 *lmt_addr)
 {
 	u64 pa, val, pf;
-	int err;
+	int err = 0;
 
 	if (!iova) {
 		dev_err(rvu->dev, "%s Requested Null address for transulation\n", __func__);
 		return -EINVAL;
 	}
 
+	mutex_lock(&rvu->rsrc_lock);
 	rvu_write64(rvu, BLKADDR_RVUM, RVU_AF_SMMU_ADDR_REQ, iova);
 	pf = rvu_get_pf(pcifunc) & 0x1F;
 	val = BIT_ULL(63) | BIT_ULL(14) | BIT_ULL(13) | pf << 8 |
@@ -76,12 +77,13 @@ static int rvu_get_lmtaddr(struct rvu *rvu, u16 pcifunc,
 	err = rvu_poll_reg(rvu, BLKADDR_RVUM, RVU_AF_SMMU_ADDR_RSP_STS, BIT_ULL(0), false);
 	if (err) {
 		dev_err(rvu->dev, "%s LMTLINE iova transulation failed\n", __func__);
-		return err;
+		goto exit;
 	}
 	val = rvu_read64(rvu, BLKADDR_RVUM, RVU_AF_SMMU_ADDR_RSP_STS);
 	if (val & ~0x1ULL) {
 		dev_err(rvu->dev, "%s LMTLINE iova transulation failed err:%llx\n", __func__, val);
-		return -EIO;
+		err = -EIO;
+		goto exit;
 	}
 	/* PA[51:12] = RVU_AF_SMMU_TLN_FLIT0[57:18]
 	 * PA[11:0] = IOVA[11:0]
@@ -89,8 +91,9 @@ static int rvu_get_lmtaddr(struct rvu *rvu, u16 pcifunc,
 	pa = rvu_read64(rvu, BLKADDR_RVUM, RVU_AF_SMMU_TLN_FLIT0) >> 18;
 	pa &= GENMASK_ULL(39, 0);
 	*lmt_addr = (pa << 12) | (iova  & 0xFFF);
-
-	return 0;
+exit:
+	mutex_unlock(&rvu->rsrc_lock);
+	return err;
 }
 
 static int rvu_update_lmtaddr(struct rvu *rvu, u16 pcifunc, u64 lmt_addr)
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
index 26cfa501f1a1..9533b1d92960 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
@@ -497,8 +497,9 @@ static int rvu_dbg_mcs_rx_secy_stats_display(struct seq_file *filp, void *unused
 			   stats.octet_validated_cnt);
 		seq_printf(filp, "secy%d: Pkts on disable port: %lld\n", secy_id,
 			   stats.pkt_port_disabled_cnt);
-		seq_printf(filp, "secy%d: Octets validated: %lld\n", secy_id, stats.pkt_badtag_cnt);
-		seq_printf(filp, "secy%d: Octets validated: %lld\n", secy_id, stats.pkt_nosa_cnt);
+		seq_printf(filp, "secy%d: Pkts with badtag: %lld\n", secy_id, stats.pkt_badtag_cnt);
+		seq_printf(filp, "secy%d: Pkts with no SA(sectag.tci.c=0): %lld\n", secy_id,
+			   stats.pkt_nosa_cnt);
 		seq_printf(filp, "secy%d: Pkts with nosaerror: %lld\n", secy_id,
 			   stats.pkt_nosaerror_cnt);
 		seq_printf(filp, "secy%d: Tagged ctrl pkts: %lld\n", secy_id,
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
index 006beb5cf98d..952319453701 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
@@ -13,11 +13,6 @@
 #include "rvu_npc_fs.h"
 #include "rvu_npc_hash.h"
 
-#define NPC_BYTESM		GENMASK_ULL(19, 16)
-#define NPC_HDR_OFFSET		GENMASK_ULL(15, 8)
-#define NPC_KEY_OFFSET		GENMASK_ULL(5, 0)
-#define NPC_LDATA_EN		BIT_ULL(7)
-
 static const char * const npc_flow_names[] = {
 	[NPC_DMAC]	= "dmac",
 	[NPC_SMAC]	= "smac",
@@ -442,6 +437,7 @@ static void npc_handle_multi_layer_fields(struct rvu *rvu, int blkaddr, u8 intf)
 static void npc_scan_ldata(struct rvu *rvu, int blkaddr, u8 lid,
 			   u8 lt, u64 cfg, u8 intf)
 {
+	struct npc_mcam_kex_hash *mkex_hash = rvu->kpu.mkex_hash;
 	struct npc_mcam *mcam = &rvu->hw->mcam;
 	u8 hdr, key, nr_bytes, bit_offset;
 	u8 la_ltype, la_start;
@@ -490,8 +486,21 @@ do {									       \
 	NPC_SCAN_HDR(NPC_SIP_IPV4, NPC_LID_LC, NPC_LT_LC_IP, 12, 4);
 	NPC_SCAN_HDR(NPC_DIP_IPV4, NPC_LID_LC, NPC_LT_LC_IP, 16, 4);
 	NPC_SCAN_HDR(NPC_IPFRAG_IPV6, NPC_LID_LC, NPC_LT_LC_IP6_EXT, 6, 1);
-	NPC_SCAN_HDR(NPC_SIP_IPV6, NPC_LID_LC, NPC_LT_LC_IP6, 8, 16);
-	NPC_SCAN_HDR(NPC_DIP_IPV6, NPC_LID_LC, NPC_LT_LC_IP6, 24, 16);
+	if (rvu->hw->cap.npc_hash_extract) {
+		if (mkex_hash->lid_lt_ld_hash_en[intf][lid][lt][0])
+			NPC_SCAN_HDR(NPC_SIP_IPV6, NPC_LID_LC, NPC_LT_LC_IP6, 8, 4);
+		else
+			NPC_SCAN_HDR(NPC_SIP_IPV6, NPC_LID_LC, NPC_LT_LC_IP6, 8, 16);
+
+		if (mkex_hash->lid_lt_ld_hash_en[intf][lid][lt][1])
+			NPC_SCAN_HDR(NPC_DIP_IPV6, NPC_LID_LC, NPC_LT_LC_IP6, 24, 4);
+		else
+			NPC_SCAN_HDR(NPC_DIP_IPV6, NPC_LID_LC, NPC_LT_LC_IP6, 24, 16);
+	} else {
+		NPC_SCAN_HDR(NPC_SIP_IPV6, NPC_LID_LC, NPC_LT_LC_IP6, 8, 16);
+		NPC_SCAN_HDR(NPC_DIP_IPV6, NPC_LID_LC, NPC_LT_LC_IP6, 24, 16);
+	}
+
 	NPC_SCAN_HDR(NPC_SPORT_UDP, NPC_LID_LD, NPC_LT_LD_UDP, 0, 2);
 	NPC_SCAN_HDR(NPC_DPORT_UDP, NPC_LID_LD, NPC_LT_LD_UDP, 2, 2);
 	NPC_SCAN_HDR(NPC_SPORT_TCP, NPC_LID_LD, NPC_LT_LD_TCP, 0, 2);
@@ -594,8 +603,7 @@ static int npc_scan_kex(struct rvu *rvu, int blkaddr, u8 intf)
 	 */
 	masked_cfg = cfg & NPC_EXACT_NIBBLE;
 	bitnr = NPC_EXACT_NIBBLE_START;
-	for_each_set_bit_from(bitnr, (unsigned long *)&masked_cfg,
-			      NPC_EXACT_NIBBLE_START) {
+	for_each_set_bit_from(bitnr, (unsigned long *)&masked_cfg, NPC_EXACT_NIBBLE_END + 1) {
 		npc_scan_exact_result(mcam, bitnr, key_nibble, intf);
 		key_nibble++;
 	}
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.h
index bdd65ce56a32..3f5c9042d10e 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.h
@@ -9,6 +9,10 @@
 #define __RVU_NPC_FS_H
 
 #define IPV6_WORDS	4
+#define NPC_BYTESM	GENMASK_ULL(19, 16)
+#define NPC_HDR_OFFSET	GENMASK_ULL(15, 8)
+#define NPC_KEY_OFFSET	GENMASK_ULL(5, 0)
+#define NPC_LDATA_EN	BIT_ULL(7)
 
 void npc_update_entry(struct rvu *rvu, enum key_fields type,
 		      struct mcam_entry *entry, u64 val_lo,
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_hash.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_hash.c
index f69102d20c90..b6e885263245 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_hash.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_hash.c
@@ -78,42 +78,43 @@ static u32 rvu_npc_toeplitz_hash(const u64 *data, u64 *key, size_t data_bit_len,
 	return hash_out;
 }
 
-u32 npc_field_hash_calc(u64 *ldata, struct npc_mcam_kex_hash *mkex_hash,
-			u64 *secret_key, u8 intf, u8 hash_idx)
+u32 npc_field_hash_calc(u64 *ldata, struct npc_get_field_hash_info_rsp rsp,
+			u8 intf, u8 hash_idx)
 {
 	u64 hash_key[3];
 	u64 data_padded[2];
 	u32 field_hash;
 
-	hash_key[0] = secret_key[1] << 31;
-	hash_key[0] |= secret_key[2];
-	hash_key[1] = secret_key[1] >> 33;
-	hash_key[1] |= secret_key[0] << 31;
-	hash_key[2] = secret_key[0] >> 33;
+	hash_key[0] = rsp.secret_key[1] << 31;
+	hash_key[0] |= rsp.secret_key[2];
+	hash_key[1] = rsp.secret_key[1] >> 33;
+	hash_key[1] |= rsp.secret_key[0] << 31;
+	hash_key[2] = rsp.secret_key[0] >> 33;
 
-	data_padded[0] = mkex_hash->hash_mask[intf][hash_idx][0] & ldata[0];
-	data_padded[1] = mkex_hash->hash_mask[intf][hash_idx][1] & ldata[1];
+	data_padded[0] = rsp.hash_mask[intf][hash_idx][0] & ldata[0];
+	data_padded[1] = rsp.hash_mask[intf][hash_idx][1] & ldata[1];
 	field_hash = rvu_npc_toeplitz_hash(data_padded, hash_key, 128, 159);
 
-	field_hash &= mkex_hash->hash_ctrl[intf][hash_idx] >> 32;
-	field_hash |= mkex_hash->hash_ctrl[intf][hash_idx];
+	field_hash &= FIELD_GET(GENMASK(63, 32), rsp.hash_ctrl[intf][hash_idx]);
+	field_hash += FIELD_GET(GENMASK(31, 0), rsp.hash_ctrl[intf][hash_idx]);
 	return field_hash;
 }
 
-static u64 npc_update_use_hash(int lt, int ld)
+static u64 npc_update_use_hash(struct rvu *rvu, int blkaddr,
+			       u8 intf, int lid, int lt, int ld)
 {
-	u64 cfg = 0;
-
-	switch (lt) {
-	case NPC_LT_LC_IP6:
-		/* Update use_hash(bit-20) and bytesm1 (bit-16:19)
-		 * in KEX_LD_CFG
-		 */
-		cfg = KEX_LD_CFG_USE_HASH(0x1, 0x03,
-					  ld ? 0x8 : 0x18,
-					  0x1, 0x0, 0x10);
-		break;
-	}
+	u8 hdr, key;
+	u64 cfg;
+
+	cfg = rvu_read64(rvu, blkaddr, NPC_AF_INTFX_LIDX_LTX_LDX_CFG(intf, lid, lt, ld));
+	hdr = FIELD_GET(NPC_HDR_OFFSET, cfg);
+	key = FIELD_GET(NPC_KEY_OFFSET, cfg);
+
+	/* Update use_hash(bit-20) to 'true' and
+	 * bytesm1(bit-16:19) to '0x3' in KEX_LD_CFG
+	 */
+	cfg = KEX_LD_CFG_USE_HASH(0x1, 0x03,
+				  hdr, 0x1, 0x0, key);
 
 	return cfg;
 }
@@ -132,12 +133,13 @@ static void npc_program_mkex_hash_rx(struct rvu *rvu, int blkaddr,
 		for (lt = 0; lt < NPC_MAX_LT; lt++) {
 			for (ld = 0; ld < NPC_MAX_LD; ld++) {
 				if (mkex_hash->lid_lt_ld_hash_en[intf][lid][lt][ld]) {
-					u64 cfg = npc_update_use_hash(lt, ld);
+					u64 cfg;
 
-					hash_cnt++;
 					if (hash_cnt == NPC_MAX_HASH)
 						return;
 
+					cfg = npc_update_use_hash(rvu, blkaddr,
+								  intf, lid, lt, ld);
 					/* Set updated KEX configuration */
 					SET_KEX_LD(intf, lid, lt, ld, cfg);
 					/* Set HASH configuration */
@@ -149,6 +151,8 @@ static void npc_program_mkex_hash_rx(struct rvu *rvu, int blkaddr,
 							     mkex_hash->hash_mask[intf][ld][1]);
 					SET_KEX_LD_HASH_CTRL(intf, ld,
 							     mkex_hash->hash_ctrl[intf][ld]);
+
+					hash_cnt++;
 				}
 			}
 		}
@@ -169,12 +173,13 @@ static void npc_program_mkex_hash_tx(struct rvu *rvu, int blkaddr,
 		for (lt = 0; lt < NPC_MAX_LT; lt++) {
 			for (ld = 0; ld < NPC_MAX_LD; ld++)
 				if (mkex_hash->lid_lt_ld_hash_en[intf][lid][lt][ld]) {
-					u64 cfg = npc_update_use_hash(lt, ld);
+					u64 cfg;
 
-					hash_cnt++;
 					if (hash_cnt == NPC_MAX_HASH)
 						return;
 
+					cfg = npc_update_use_hash(rvu, blkaddr,
+								  intf, lid, lt, ld);
 					/* Set updated KEX configuration */
 					SET_KEX_LD(intf, lid, lt, ld, cfg);
 					/* Set HASH configuration */
@@ -187,8 +192,6 @@ static void npc_program_mkex_hash_tx(struct rvu *rvu, int blkaddr,
 					SET_KEX_LD_HASH_CTRL(intf, ld,
 							     mkex_hash->hash_ctrl[intf][ld]);
 					hash_cnt++;
-					if (hash_cnt == NPC_MAX_HASH)
-						return;
 				}
 		}
 	}
@@ -242,8 +245,8 @@ void npc_update_field_hash(struct rvu *rvu, u8 intf,
 			   struct flow_msg *omask)
 {
 	struct npc_mcam_kex_hash *mkex_hash = rvu->kpu.mkex_hash;
-	struct npc_get_secret_key_req req;
-	struct npc_get_secret_key_rsp rsp;
+	struct npc_get_field_hash_info_req req;
+	struct npc_get_field_hash_info_rsp rsp;
 	u64 ldata[2], cfg;
 	u32 field_hash;
 	u8 hash_idx;
@@ -254,7 +257,7 @@ void npc_update_field_hash(struct rvu *rvu, u8 intf,
 	}
 
 	req.intf = intf;
-	rvu_mbox_handler_npc_get_secret_key(rvu, &req, &rsp);
+	rvu_mbox_handler_npc_get_field_hash_info(rvu, &req, &rsp);
 
 	for (hash_idx = 0; hash_idx < NPC_MAX_HASH; hash_idx++) {
 		cfg = rvu_read64(rvu, blkaddr, NPC_AF_INTFX_HASHX_CFG(intf, hash_idx));
@@ -270,44 +273,45 @@ void npc_update_field_hash(struct rvu *rvu, u8 intf,
 				 * is hashed to 32 bit value.
 				 */
 				case NPC_LT_LC_IP6:
-					if (features & BIT_ULL(NPC_SIP_IPV6)) {
+					/* ld[0] == hash_idx[0] == Source IPv6
+					 * ld[1] == hash_idx[1] == Destination IPv6
+					 */
+					if ((features & BIT_ULL(NPC_SIP_IPV6)) && !hash_idx) {
 						u32 src_ip[IPV6_WORDS];
 
 						be32_to_cpu_array(src_ip, pkt->ip6src, IPV6_WORDS);
-						ldata[0] = (u64)src_ip[0] << 32 | src_ip[1];
-						ldata[1] = (u64)src_ip[2] << 32 | src_ip[3];
+						ldata[1] = (u64)src_ip[0] << 32 | src_ip[1];
+						ldata[0] = (u64)src_ip[2] << 32 | src_ip[3];
 						field_hash = npc_field_hash_calc(ldata,
-										 mkex_hash,
-										 rsp.secret_key,
+										 rsp,
 										 intf,
 										 hash_idx);
 						npc_update_entry(rvu, NPC_SIP_IPV6, entry,
-								 field_hash, 0, 32, 0, intf);
+								 field_hash, 0,
+								 GENMASK(31, 0), 0, intf);
 						memcpy(&opkt->ip6src, &pkt->ip6src,
 						       sizeof(pkt->ip6src));
 						memcpy(&omask->ip6src, &mask->ip6src,
 						       sizeof(mask->ip6src));
-						break;
-					}
-
-					if (features & BIT_ULL(NPC_DIP_IPV6)) {
+					} else if ((features & BIT_ULL(NPC_DIP_IPV6)) && hash_idx) {
 						u32 dst_ip[IPV6_WORDS];
 
 						be32_to_cpu_array(dst_ip, pkt->ip6dst, IPV6_WORDS);
-						ldata[0] = (u64)dst_ip[0] << 32 | dst_ip[1];
-						ldata[1] = (u64)dst_ip[2] << 32 | dst_ip[3];
+						ldata[1] = (u64)dst_ip[0] << 32 | dst_ip[1];
+						ldata[0] = (u64)dst_ip[2] << 32 | dst_ip[3];
 						field_hash = npc_field_hash_calc(ldata,
-										 mkex_hash,
-										 rsp.secret_key,
+										 rsp,
 										 intf,
 										 hash_idx);
 						npc_update_entry(rvu, NPC_DIP_IPV6, entry,
-								 field_hash, 0, 32, 0, intf);
+								 field_hash, 0,
+								 GENMASK(31, 0), 0, intf);
 						memcpy(&opkt->ip6dst, &pkt->ip6dst,
 						       sizeof(pkt->ip6dst));
 						memcpy(&omask->ip6dst, &mask->ip6dst,
 						       sizeof(mask->ip6dst));
 					}
+
 					break;
 				}
 			}
@@ -315,13 +319,13 @@ void npc_update_field_hash(struct rvu *rvu, u8 intf,
 	}
 }
 
-int rvu_mbox_handler_npc_get_secret_key(struct rvu *rvu,
-					struct npc_get_secret_key_req *req,
-					struct npc_get_secret_key_rsp *rsp)
+int rvu_mbox_handler_npc_get_field_hash_info(struct rvu *rvu,
+					     struct npc_get_field_hash_info_req *req,
+					     struct npc_get_field_hash_info_rsp *rsp)
 {
 	u64 *secret_key = rsp->secret_key;
 	u8 intf = req->intf;
-	int blkaddr;
+	int i, j, blkaddr;
 
 	blkaddr = rvu_get_blkaddr(rvu, BLKTYPE_NPC, 0);
 	if (blkaddr < 0) {
@@ -333,6 +337,19 @@ int rvu_mbox_handler_npc_get_secret_key(struct rvu *rvu,
 	secret_key[1] = rvu_read64(rvu, blkaddr, NPC_AF_INTFX_SECRET_KEY1(intf));
 	secret_key[2] = rvu_read64(rvu, blkaddr, NPC_AF_INTFX_SECRET_KEY2(intf));
 
+	for (i = 0; i < NPC_MAX_HASH; i++) {
+		for (j = 0; j < NPC_MAX_HASH_MASK; j++) {
+			rsp->hash_mask[NIX_INTF_RX][i][j] =
+				GET_KEX_LD_HASH_MASK(NIX_INTF_RX, i, j);
+			rsp->hash_mask[NIX_INTF_TX][i][j] =
+				GET_KEX_LD_HASH_MASK(NIX_INTF_TX, i, j);
+		}
+	}
+
+	for (i = 0; i < NPC_MAX_INTF; i++)
+		for (j = 0; j < NPC_MAX_HASH; j++)
+			rsp->hash_ctrl[i][j] = GET_KEX_LD_HASH_CTRL(i, j);
+
 	return 0;
 }
 
@@ -1878,9 +1895,9 @@ int rvu_npc_exact_init(struct rvu *rvu)
 	rvu->hw->table = table;
 
 	/* Read table size, ways and depth */
-	table->mem_table.depth = FIELD_GET(GENMASK_ULL(31, 24), npc_const3);
 	table->mem_table.ways = FIELD_GET(GENMASK_ULL(19, 16), npc_const3);
-	table->cam_table.depth = FIELD_GET(GENMASK_ULL(15, 0), npc_const3);
+	table->mem_table.depth = FIELD_GET(GENMASK_ULL(15, 0), npc_const3);
+	table->cam_table.depth = FIELD_GET(GENMASK_ULL(31, 24), npc_const3);
 
 	dev_dbg(rvu->dev, "%s: NPC exact match 4way_2k table(ways=%d, depth=%d)\n",
 		__func__,  table->mem_table.ways, table->cam_table.depth);
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_hash.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_hash.h
index 3efeb09c58de..a1c3d987b804 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_hash.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_hash.h
@@ -31,6 +31,12 @@
 	rvu_write64(rvu, blkaddr,	\
 		    NPC_AF_INTFX_HASHX_MASKX(intf, ld, mask_idx), cfg)
 
+#define GET_KEX_LD_HASH_CTRL(intf, ld)	\
+	rvu_read64(rvu, blkaddr, NPC_AF_INTFX_HASHX_RESULT_CTRL(intf, ld))
+
+#define GET_KEX_LD_HASH_MASK(intf, ld, mask_idx)	\
+	rvu_read64(rvu, blkaddr, NPC_AF_INTFX_HASHX_MASKX(intf, ld, mask_idx))
+
 #define SET_KEX_LD_HASH_CTRL(intf, ld, cfg) \
 	rvu_write64(rvu, blkaddr,	\
 		    NPC_AF_INTFX_HASHX_RESULT_CTRL(intf, ld), cfg)
@@ -56,8 +62,8 @@ void npc_update_field_hash(struct rvu *rvu, u8 intf,
 			   struct flow_msg *omask);
 void npc_config_secret_key(struct rvu *rvu, int blkaddr);
 void npc_program_mkex_hash(struct rvu *rvu, int blkaddr);
-u32 npc_field_hash_calc(u64 *ldata, struct npc_mcam_kex_hash *mkex_hash,
-			u64 *secret_key, u8 intf, u8 hash_idx);
+u32 npc_field_hash_calc(u64 *ldata, struct npc_get_field_hash_info_rsp rsp,
+			u8 intf, u8 hash_idx);
 
 static struct npc_mcam_kex_hash npc_mkex_hash_default __maybe_unused = {
 	.lid_lt_ld_hash_en = {
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_macsec.c b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_macsec.c
index 9ec5f38d38a8..a487a98eac88 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_macsec.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_macsec.c
@@ -9,6 +9,7 @@
 #include <net/macsec.h>
 #include "otx2_common.h"
 
+#define MCS_TCAM0_MAC_DA_MASK		GENMASK_ULL(47, 0)
 #define MCS_TCAM0_MAC_SA_MASK		GENMASK_ULL(63, 48)
 #define MCS_TCAM1_MAC_SA_MASK		GENMASK_ULL(31, 0)
 #define MCS_TCAM1_ETYPE_MASK		GENMASK_ULL(47, 32)
@@ -149,11 +150,20 @@ static void cn10k_mcs_free_rsrc(struct otx2_nic *pfvf, enum mcs_direction dir,
 				enum mcs_rsrc_type type, u16 hw_rsrc_id,
 				bool all)
 {
+	struct mcs_clear_stats *clear_req;
 	struct mbox *mbox = &pfvf->mbox;
 	struct mcs_free_rsrc_req *req;
 
 	mutex_lock(&mbox->lock);
 
+	clear_req = otx2_mbox_alloc_msg_mcs_clear_stats(mbox);
+	if (!clear_req)
+		goto fail;
+
+	clear_req->id = hw_rsrc_id;
+	clear_req->type = type;
+	clear_req->dir = dir;
+
 	req = otx2_mbox_alloc_msg_mcs_free_resources(mbox);
 	if (!req)
 		goto fail;
@@ -237,8 +247,10 @@ static int cn10k_mcs_write_rx_flowid(struct otx2_nic *pfvf,
 				     struct cn10k_mcs_rxsc *rxsc, u8 hw_secy_id)
 {
 	struct macsec_rx_sc *sw_rx_sc = rxsc->sw_rxsc;
+	struct macsec_secy *secy = rxsc->sw_secy;
 	struct mcs_flowid_entry_write_req *req;
 	struct mbox *mbox = &pfvf->mbox;
+	u64 mac_da;
 	int ret;
 
 	mutex_lock(&mbox->lock);
@@ -249,11 +261,16 @@ static int cn10k_mcs_write_rx_flowid(struct otx2_nic *pfvf,
 		goto fail;
 	}
 
+	mac_da = ether_addr_to_u64(secy->netdev->dev_addr);
+
+	req->data[0] = FIELD_PREP(MCS_TCAM0_MAC_DA_MASK, mac_da);
+	req->mask[0] = ~0ULL;
+	req->mask[0] = ~MCS_TCAM0_MAC_DA_MASK;
+
 	req->data[1] = FIELD_PREP(MCS_TCAM1_ETYPE_MASK, ETH_P_MACSEC);
 	req->mask[1] = ~0ULL;
 	req->mask[1] &= ~MCS_TCAM1_ETYPE_MASK;
 
-	req->mask[0] = ~0ULL;
 	req->mask[2] = ~0ULL;
 	req->mask[3] = ~0ULL;
 
@@ -997,7 +1014,7 @@ static void cn10k_mcs_sync_stats(struct otx2_nic *pfvf, struct macsec_secy *secy
 
 	/* Check if sync is really needed */
 	if (secy->validate_frames == txsc->last_validate_frames &&
-	    secy->protect_frames == txsc->last_protect_frames)
+	    secy->replay_protect == txsc->last_replay_protect)
 		return;
 
 	cn10k_mcs_secy_stats(pfvf, txsc->hw_secy_id_rx, &rx_rsp, MCS_RX, true);
@@ -1019,19 +1036,19 @@ static void cn10k_mcs_sync_stats(struct otx2_nic *pfvf, struct macsec_secy *secy
 		rxsc->stats.InPktsInvalid += sc_rsp.pkt_invalid_cnt;
 		rxsc->stats.InPktsNotValid += sc_rsp.pkt_notvalid_cnt;
 
-		if (txsc->last_protect_frames)
+		if (txsc->last_replay_protect)
 			rxsc->stats.InPktsLate += sc_rsp.pkt_late_cnt;
 		else
 			rxsc->stats.InPktsDelayed += sc_rsp.pkt_late_cnt;
 
-		if (txsc->last_validate_frames == MACSEC_VALIDATE_CHECK)
+		if (txsc->last_validate_frames == MACSEC_VALIDATE_DISABLED)
 			rxsc->stats.InPktsUnchecked += sc_rsp.pkt_unchecked_cnt;
 		else
 			rxsc->stats.InPktsOK += sc_rsp.pkt_unchecked_cnt;
 	}
 
 	txsc->last_validate_frames = secy->validate_frames;
-	txsc->last_protect_frames = secy->protect_frames;
+	txsc->last_replay_protect = secy->replay_protect;
 }
 
 static int cn10k_mdo_open(struct macsec_context *ctx)
@@ -1100,7 +1117,7 @@ static int cn10k_mdo_add_secy(struct macsec_context *ctx)
 	txsc->sw_secy = secy;
 	txsc->encoding_sa = secy->tx_sc.encoding_sa;
 	txsc->last_validate_frames = secy->validate_frames;
-	txsc->last_protect_frames = secy->protect_frames;
+	txsc->last_replay_protect = secy->replay_protect;
 
 	list_add(&txsc->entry, &cfg->txsc_list);
 
@@ -1117,6 +1134,7 @@ static int cn10k_mdo_upd_secy(struct macsec_context *ctx)
 	struct macsec_secy *secy = ctx->secy;
 	struct macsec_tx_sa *sw_tx_sa;
 	struct cn10k_mcs_txsc *txsc;
+	bool active;
 	u8 sa_num;
 	int err;
 
@@ -1124,15 +1142,19 @@ static int cn10k_mdo_upd_secy(struct macsec_context *ctx)
 	if (!txsc)
 		return -ENOENT;
 
-	txsc->encoding_sa = secy->tx_sc.encoding_sa;
-
-	sa_num = txsc->encoding_sa;
-	sw_tx_sa = rcu_dereference_bh(secy->tx_sc.sa[sa_num]);
+	/* Encoding SA got changed */
+	if (txsc->encoding_sa != secy->tx_sc.encoding_sa) {
+		txsc->encoding_sa = secy->tx_sc.encoding_sa;
+		sa_num = txsc->encoding_sa;
+		sw_tx_sa = rcu_dereference_bh(secy->tx_sc.sa[sa_num]);
+		active = sw_tx_sa ? sw_tx_sa->active : false;
+		cn10k_mcs_link_tx_sa2sc(pfvf, secy, txsc, sa_num, active);
+	}
 
 	if (netif_running(secy->netdev)) {
 		cn10k_mcs_sync_stats(pfvf, secy, txsc);
 
-		err = cn10k_mcs_secy_tx_cfg(pfvf, secy, txsc, sw_tx_sa, sa_num);
+		err = cn10k_mcs_secy_tx_cfg(pfvf, secy, txsc, NULL, 0);
 		if (err)
 			return err;
 	}
@@ -1521,12 +1543,12 @@ static int cn10k_mdo_get_rx_sc_stats(struct macsec_context *ctx)
 	rxsc->stats.InPktsInvalid += rsp.pkt_invalid_cnt;
 	rxsc->stats.InPktsNotValid += rsp.pkt_notvalid_cnt;
 
-	if (secy->protect_frames)
+	if (secy->replay_protect)
 		rxsc->stats.InPktsLate += rsp.pkt_late_cnt;
 	else
 		rxsc->stats.InPktsDelayed += rsp.pkt_late_cnt;
 
-	if (secy->validate_frames == MACSEC_VALIDATE_CHECK)
+	if (secy->validate_frames == MACSEC_VALIDATE_DISABLED)
 		rxsc->stats.InPktsUnchecked += rsp.pkt_unchecked_cnt;
 	else
 		rxsc->stats.InPktsOK += rsp.pkt_unchecked_cnt;
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
index 3d22cc6a2804..0c8fc66ade82 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
@@ -335,11 +335,11 @@ struct otx2_flow_config {
 #define OTX2_PER_VF_VLAN_FLOWS	2 /* Rx + Tx per VF */
 #define OTX2_VF_VLAN_RX_INDEX	0
 #define OTX2_VF_VLAN_TX_INDEX	1
-	u16			max_flows;
-	u8			dmacflt_max_flows;
 	u32			*bmap_to_dmacindex;
 	unsigned long		*dmacflt_bmap;
 	struct list_head	flow_list;
+	u32			dmacflt_max_flows;
+	u16                     max_flows;
 };
 
 struct otx2_tc_info {
@@ -389,7 +389,7 @@ struct cn10k_mcs_txsc {
 	struct cn10k_txsc_stats stats;
 	struct list_head entry;
 	enum macsec_validation_type last_validate_frames;
-	bool last_protect_frames;
+	bool last_replay_protect;
 	u16 hw_secy_id_tx;
 	u16 hw_secy_id_rx;
 	u16 hw_flow_id;
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
index c1ea60bc2630..23eee2b3d408 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
@@ -1835,13 +1835,22 @@ int otx2_open(struct net_device *netdev)
 		otx2_dmacflt_reinstall_flows(pf);
 
 	err = otx2_rxtx_enable(pf, true);
-	if (err)
+	/* If a mbox communication error happens at this point then interface
+	 * will end up in a state such that it is in down state but hardware
+	 * mcam entries are enabled to receive the packets. Hence disable the
+	 * packet I/O.
+	 */
+	if (err == EIO)
+		goto err_disable_rxtx;
+	else if (err)
 		goto err_tx_stop_queues;
 
 	otx2_do_set_rx_mode(pf);
 
 	return 0;
 
+err_disable_rxtx:
+	otx2_rxtx_enable(pf, false);
 err_tx_stop_queues:
 	netif_tx_stop_all_queues(netdev);
 	netif_carrier_off(netdev);
@@ -3069,8 +3078,6 @@ static void otx2_remove(struct pci_dev *pdev)
 		otx2_config_pause_frm(pf);
 	}
 
-	cn10k_mcs_free(pf);
-
 #ifdef CONFIG_DCB
 	/* Disable PFC config */
 	if (pf->pfc_en) {
@@ -3084,6 +3091,7 @@ static void otx2_remove(struct pci_dev *pdev)
 
 	otx2_unregister_dl(pf);
 	unregister_netdev(netdev);
+	cn10k_mcs_free(pf);
 	otx2_sriov_disable(pf->pdev);
 	otx2_sriov_vfcfg_cleanup(pf);
 	if (pf->otx2_wq)
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
index 044cc211424e..8392f63e433f 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
@@ -544,7 +544,7 @@ static int otx2_tc_prepare_flow(struct otx2_nic *nic, struct otx2_tc_flow *node,
 		if (match.mask->flags & FLOW_DIS_IS_FRAGMENT) {
 			if (ntohs(flow_spec->etype) == ETH_P_IP) {
 				flow_spec->ip_flag = IPV4_FLAG_MORE;
-				flow_mask->ip_flag = 0xff;
+				flow_mask->ip_flag = IPV4_FLAG_MORE;
 				req->features |= BIT_ULL(NPC_IPFRAG_IPV4);
 			} else if (ntohs(flow_spec->etype) == ETH_P_IPV6) {
 				flow_spec->next_header = IPPROTO_FRAGMENT;
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
index ab126f8706c7..53366dbfbf27 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
@@ -621,7 +621,7 @@ static int otx2vf_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	err = otx2vf_realloc_msix_vectors(vf);
 	if (err)
-		goto err_mbox_destroy;
+		goto err_detach_rsrc;
 
 	err = otx2_set_real_num_queues(netdev, qcount, qcount);
 	if (err)
diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index f56d4e7d4ae5..4671d738a37c 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -1870,9 +1870,7 @@ static int mtk_poll_rx(struct napi_struct *napi, int budget,
 
 	while (done < budget) {
 		unsigned int pktlen, *rxdcsum;
-		bool has_hwaccel_tag = false;
 		struct net_device *netdev;
-		u16 vlan_proto, vlan_tci;
 		dma_addr_t dma_addr;
 		u32 hash, reason;
 		int mac = 0;
@@ -2007,31 +2005,16 @@ static int mtk_poll_rx(struct napi_struct *napi, int budget,
 			skb_checksum_none_assert(skb);
 		skb->protocol = eth_type_trans(skb, netdev);
 
-		if (netdev->features & NETIF_F_HW_VLAN_CTAG_RX) {
-			if (MTK_HAS_CAPS(eth->soc->caps, MTK_NETSYS_V2)) {
-				if (trxd.rxd3 & RX_DMA_VTAG_V2) {
-					vlan_proto = RX_DMA_VPID(trxd.rxd4);
-					vlan_tci = RX_DMA_VID(trxd.rxd4);
-					has_hwaccel_tag = true;
-				}
-			} else if (trxd.rxd2 & RX_DMA_VTAG) {
-				vlan_proto = RX_DMA_VPID(trxd.rxd3);
-				vlan_tci = RX_DMA_VID(trxd.rxd3);
-				has_hwaccel_tag = true;
-			}
-		}
-
 		/* When using VLAN untagging in combination with DSA, the
 		 * hardware treats the MTK special tag as a VLAN and untags it.
 		 */
-		if (has_hwaccel_tag && netdev_uses_dsa(netdev)) {
-			unsigned int port = vlan_proto & GENMASK(2, 0);
+		if (!MTK_HAS_CAPS(eth->soc->caps, MTK_NETSYS_V2) &&
+		    (trxd.rxd2 & RX_DMA_VTAG) && netdev_uses_dsa(netdev)) {
+			unsigned int port = RX_DMA_VPID(trxd.rxd3) & GENMASK(2, 0);
 
 			if (port < ARRAY_SIZE(eth->dsa_meta) &&
 			    eth->dsa_meta[port])
 				skb_dst_set_noref(skb, &eth->dsa_meta[port]->dst);
-		} else if (has_hwaccel_tag) {
-			__vlan_hwaccel_put_tag(skb, htons(vlan_proto), vlan_tci);
 		}
 
 		if (reason == MTK_PPE_CPU_REASON_HIT_UNBIND_RATE_REACHED)
@@ -2859,29 +2842,11 @@ static netdev_features_t mtk_fix_features(struct net_device *dev,
 
 static int mtk_set_features(struct net_device *dev, netdev_features_t features)
 {
-	struct mtk_mac *mac = netdev_priv(dev);
-	struct mtk_eth *eth = mac->hw;
 	netdev_features_t diff = dev->features ^ features;
-	int i;
 
 	if ((diff & NETIF_F_LRO) && !(features & NETIF_F_LRO))
 		mtk_hwlro_netdev_disable(dev);
 
-	/* Set RX VLAN offloading */
-	if (!(diff & NETIF_F_HW_VLAN_CTAG_RX))
-		return 0;
-
-	mtk_w32(eth, !!(features & NETIF_F_HW_VLAN_CTAG_RX),
-		MTK_CDMP_EG_CTRL);
-
-	/* sync features with other MAC */
-	for (i = 0; i < MTK_MAC_COUNT; i++) {
-		if (!eth->netdev[i] || eth->netdev[i] == dev)
-			continue;
-		eth->netdev[i]->features &= ~NETIF_F_HW_VLAN_CTAG_RX;
-		eth->netdev[i]->features |= features & NETIF_F_HW_VLAN_CTAG_RX;
-	}
-
 	return 0;
 }
 
@@ -3184,30 +3149,6 @@ static int mtk_open(struct net_device *dev)
 	struct mtk_eth *eth = mac->hw;
 	int i, err;
 
-	if (mtk_uses_dsa(dev) && !eth->prog) {
-		for (i = 0; i < ARRAY_SIZE(eth->dsa_meta); i++) {
-			struct metadata_dst *md_dst = eth->dsa_meta[i];
-
-			if (md_dst)
-				continue;
-
-			md_dst = metadata_dst_alloc(0, METADATA_HW_PORT_MUX,
-						    GFP_KERNEL);
-			if (!md_dst)
-				return -ENOMEM;
-
-			md_dst->u.port_info.port_id = i;
-			eth->dsa_meta[i] = md_dst;
-		}
-	} else {
-		/* Hardware special tag parsing needs to be disabled if at least
-		 * one MAC does not use DSA.
-		 */
-		u32 val = mtk_r32(eth, MTK_CDMP_IG_CTRL);
-		val &= ~MTK_CDMP_STAG_EN;
-		mtk_w32(eth, val, MTK_CDMP_IG_CTRL);
-	}
-
 	err = phylink_of_phy_connect(mac->phylink, mac->of_node, 0);
 	if (err) {
 		netdev_err(dev, "%s: could not attach PHY: %d\n", __func__,
@@ -3246,6 +3187,40 @@ static int mtk_open(struct net_device *dev)
 	phylink_start(mac->phylink);
 	netif_tx_start_all_queues(dev);
 
+	if (MTK_HAS_CAPS(eth->soc->caps, MTK_NETSYS_V2))
+		return 0;
+
+	if (mtk_uses_dsa(dev) && !eth->prog) {
+		for (i = 0; i < ARRAY_SIZE(eth->dsa_meta); i++) {
+			struct metadata_dst *md_dst = eth->dsa_meta[i];
+
+			if (md_dst)
+				continue;
+
+			md_dst = metadata_dst_alloc(0, METADATA_HW_PORT_MUX,
+						    GFP_KERNEL);
+			if (!md_dst)
+				return -ENOMEM;
+
+			md_dst->u.port_info.port_id = i;
+			eth->dsa_meta[i] = md_dst;
+		}
+	} else {
+		/* Hardware special tag parsing needs to be disabled if at least
+		 * one MAC does not use DSA.
+		 */
+		u32 val = mtk_r32(eth, MTK_CDMP_IG_CTRL);
+
+		val &= ~MTK_CDMP_STAG_EN;
+		mtk_w32(eth, val, MTK_CDMP_IG_CTRL);
+
+		val = mtk_r32(eth, MTK_CDMQ_IG_CTRL);
+		val &= ~MTK_CDMQ_STAG_EN;
+		mtk_w32(eth, val, MTK_CDMQ_IG_CTRL);
+
+		mtk_w32(eth, 0, MTK_CDMP_EG_CTRL);
+	}
+
 	return 0;
 }
 
@@ -3572,10 +3547,9 @@ static int mtk_hw_init(struct mtk_eth *eth)
 	if (!MTK_HAS_CAPS(eth->soc->caps, MTK_NETSYS_V2)) {
 		val = mtk_r32(eth, MTK_CDMP_IG_CTRL);
 		mtk_w32(eth, val | MTK_CDMP_STAG_EN, MTK_CDMP_IG_CTRL);
-	}
 
-	/* Enable RX VLan Offloading */
-	mtk_w32(eth, 1, MTK_CDMP_EG_CTRL);
+		mtk_w32(eth, 1, MTK_CDMP_EG_CTRL);
+	}
 
 	/* set interrupt delays based on current Net DIM sample */
 	mtk_dim_rx(&eth->rx_dim.work);
@@ -4176,7 +4150,7 @@ static int mtk_add_mac(struct mtk_eth *eth, struct device_node *np)
 		eth->netdev[id]->hw_features |= NETIF_F_LRO;
 
 	eth->netdev[id]->vlan_features = eth->soc->hw_features &
-		~(NETIF_F_HW_VLAN_CTAG_TX | NETIF_F_HW_VLAN_CTAG_RX);
+		~NETIF_F_HW_VLAN_CTAG_TX;
 	eth->netdev[id]->features |= eth->soc->hw_features;
 	eth->netdev[id]->ethtool_ops = &mtk_ethtool_ops;
 
diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.h b/drivers/net/ethernet/mediatek/mtk_eth_soc.h
index d4b4f9eaa441..79112bd3e952 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.h
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.h
@@ -48,7 +48,6 @@
 #define MTK_HW_FEATURES		(NETIF_F_IP_CSUM | \
 				 NETIF_F_RXCSUM | \
 				 NETIF_F_HW_VLAN_CTAG_TX | \
-				 NETIF_F_HW_VLAN_CTAG_RX | \
 				 NETIF_F_SG | NETIF_F_TSO | \
 				 NETIF_F_TSO6 | \
 				 NETIF_F_IPV6_CSUM |\
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_devlink.c b/drivers/net/ethernet/pensando/ionic/ionic_devlink.c
index e6ff757895ab..4ec66a6be073 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_devlink.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_devlink.c
@@ -61,6 +61,8 @@ struct ionic *ionic_devlink_alloc(struct device *dev)
 	struct devlink *dl;
 
 	dl = devlink_alloc(&ionic_dl_ops, sizeof(struct ionic), dev);
+	if (!dl)
+		return NULL;
 
 	return devlink_priv(dl);
 }
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c b/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
index 01c22701482d..d7370fb60a16 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
@@ -691,7 +691,7 @@ static int ionic_get_rxnfc(struct net_device *netdev,
 		info->data = lif->nxqs;
 		break;
 	default:
-		netdev_err(netdev, "Command parameter %d is not supported\n",
+		netdev_dbg(netdev, "Command parameter %d is not supported\n",
 			   info->cmd);
 		err = -EOPNOTSUPP;
 	}
diff --git a/drivers/net/ethernet/sfc/mcdi_port_common.c b/drivers/net/ethernet/sfc/mcdi_port_common.c
index 899cc1671004..0ab14f3d01d4 100644
--- a/drivers/net/ethernet/sfc/mcdi_port_common.c
+++ b/drivers/net/ethernet/sfc/mcdi_port_common.c
@@ -972,12 +972,15 @@ static u32 efx_mcdi_phy_module_type(struct efx_nic *efx)
 
 	/* A QSFP+ NIC may actually have an SFP+ module attached.
 	 * The ID is page 0, byte 0.
+	 * QSFP28 is of type SFF_8636, however, this is treated
+	 * the same by ethtool, so we can also treat them the same.
 	 */
 	switch (efx_mcdi_phy_get_module_eeprom_byte(efx, 0, 0)) {
-	case 0x3:
+	case 0x3: /* SFP */
 		return MC_CMD_MEDIA_SFP_PLUS;
-	case 0xc:
-	case 0xd:
+	case 0xc: /* QSFP */
+	case 0xd: /* QSFP+ */
+	case 0x11: /* QSFP28 */
 		return MC_CMD_MEDIA_QSFP_PLUS;
 	default:
 		return 0;
@@ -1075,7 +1078,7 @@ int efx_mcdi_phy_get_module_info(struct efx_nic *efx, struct ethtool_modinfo *mo
 
 	case MC_CMD_MEDIA_QSFP_PLUS:
 		modinfo->type = ETH_MODULE_SFF_8436;
-		modinfo->eeprom_len = ETH_MODULE_SFF_8436_LEN;
+		modinfo->eeprom_len = ETH_MODULE_SFF_8436_MAX_LEN;
 		break;
 
 	default:
diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index 23da1d9dafd1..059d610901d8 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -199,6 +199,7 @@
 #define OCP_EEE_AR		0xa41a
 #define OCP_EEE_DATA		0xa41c
 #define OCP_PHY_STATUS		0xa420
+#define OCP_INTR_EN		0xa424
 #define OCP_NCTL_CFG		0xa42c
 #define OCP_POWER_CFG		0xa430
 #define OCP_EEE_CFG		0xa432
@@ -620,6 +621,9 @@ enum spd_duplex {
 #define PHY_STAT_LAN_ON		3
 #define PHY_STAT_PWRDN		5
 
+/* OCP_INTR_EN */
+#define INTR_SPEED_FORCE	BIT(3)
+
 /* OCP_NCTL_CFG */
 #define PGA_RETURN_EN		BIT(1)
 
@@ -3023,12 +3027,16 @@ static int rtl_enable(struct r8152 *tp)
 	ocp_write_byte(tp, MCU_TYPE_PLA, PLA_CR, ocp_data);
 
 	switch (tp->version) {
-	case RTL_VER_08:
-	case RTL_VER_09:
-	case RTL_VER_14:
-		r8153b_rx_agg_chg_indicate(tp);
+	case RTL_VER_01:
+	case RTL_VER_02:
+	case RTL_VER_03:
+	case RTL_VER_04:
+	case RTL_VER_05:
+	case RTL_VER_06:
+	case RTL_VER_07:
 		break;
 	default:
+		r8153b_rx_agg_chg_indicate(tp);
 		break;
 	}
 
@@ -3082,7 +3090,6 @@ static void r8153_set_rx_early_timeout(struct r8152 *tp)
 			       640 / 8);
 		ocp_write_word(tp, MCU_TYPE_USB, USB_RX_EXTRA_AGGR_TMR,
 			       ocp_data);
-		r8153b_rx_agg_chg_indicate(tp);
 		break;
 
 	default:
@@ -3116,7 +3123,6 @@ static void r8153_set_rx_early_size(struct r8152 *tp)
 	case RTL_VER_15:
 		ocp_write_word(tp, MCU_TYPE_USB, USB_RX_EARLY_SIZE,
 			       ocp_data / 8);
-		r8153b_rx_agg_chg_indicate(tp);
 		break;
 	default:
 		WARN_ON_ONCE(1);
@@ -5986,6 +5992,25 @@ static void rtl8153_disable(struct r8152 *tp)
 	r8153_aldps_en(tp, true);
 }
 
+static u32 fc_pause_on_auto(struct r8152 *tp)
+{
+	return (ALIGN(mtu_to_size(tp->netdev->mtu), 1024) + 6 * 1024);
+}
+
+static u32 fc_pause_off_auto(struct r8152 *tp)
+{
+	return (ALIGN(mtu_to_size(tp->netdev->mtu), 1024) + 14 * 1024);
+}
+
+static void r8156_fc_parameter(struct r8152 *tp)
+{
+	u32 pause_on = tp->fc_pause_on ? tp->fc_pause_on : fc_pause_on_auto(tp);
+	u32 pause_off = tp->fc_pause_off ? tp->fc_pause_off : fc_pause_off_auto(tp);
+
+	ocp_write_word(tp, MCU_TYPE_PLA, PLA_RX_FIFO_FULL, pause_on / 16);
+	ocp_write_word(tp, MCU_TYPE_PLA, PLA_RX_FIFO_EMPTY, pause_off / 16);
+}
+
 static int rtl8156_enable(struct r8152 *tp)
 {
 	u32 ocp_data;
@@ -5994,6 +6019,7 @@ static int rtl8156_enable(struct r8152 *tp)
 	if (test_bit(RTL8152_UNPLUG, &tp->flags))
 		return -ENODEV;
 
+	r8156_fc_parameter(tp);
 	set_tx_qlen(tp);
 	rtl_set_eee_plus(tp);
 	r8153_set_rx_early_timeout(tp);
@@ -6025,9 +6051,24 @@ static int rtl8156_enable(struct r8152 *tp)
 		ocp_write_word(tp, MCU_TYPE_USB, USB_L1_CTRL, ocp_data);
 	}
 
+	ocp_data = ocp_read_word(tp, MCU_TYPE_USB, USB_FW_TASK);
+	ocp_data &= ~FC_PATCH_TASK;
+	ocp_write_word(tp, MCU_TYPE_USB, USB_FW_TASK, ocp_data);
+	usleep_range(1000, 2000);
+	ocp_data |= FC_PATCH_TASK;
+	ocp_write_word(tp, MCU_TYPE_USB, USB_FW_TASK, ocp_data);
+
 	return rtl_enable(tp);
 }
 
+static void rtl8156_disable(struct r8152 *tp)
+{
+	ocp_write_word(tp, MCU_TYPE_PLA, PLA_RX_FIFO_FULL, 0);
+	ocp_write_word(tp, MCU_TYPE_PLA, PLA_RX_FIFO_EMPTY, 0);
+
+	rtl8153_disable(tp);
+}
+
 static int rtl8156b_enable(struct r8152 *tp)
 {
 	u32 ocp_data;
@@ -6429,25 +6470,6 @@ static void rtl8153c_up(struct r8152 *tp)
 	r8153b_u1u2en(tp, true);
 }
 
-static inline u32 fc_pause_on_auto(struct r8152 *tp)
-{
-	return (ALIGN(mtu_to_size(tp->netdev->mtu), 1024) + 6 * 1024);
-}
-
-static inline u32 fc_pause_off_auto(struct r8152 *tp)
-{
-	return (ALIGN(mtu_to_size(tp->netdev->mtu), 1024) + 14 * 1024);
-}
-
-static void r8156_fc_parameter(struct r8152 *tp)
-{
-	u32 pause_on = tp->fc_pause_on ? tp->fc_pause_on : fc_pause_on_auto(tp);
-	u32 pause_off = tp->fc_pause_off ? tp->fc_pause_off : fc_pause_off_auto(tp);
-
-	ocp_write_word(tp, MCU_TYPE_PLA, PLA_RX_FIFO_FULL, pause_on / 16);
-	ocp_write_word(tp, MCU_TYPE_PLA, PLA_RX_FIFO_EMPTY, pause_off / 16);
-}
-
 static void rtl8156_change_mtu(struct r8152 *tp)
 {
 	u32 rx_max_size = mtu_to_size(tp->netdev->mtu);
@@ -7538,6 +7560,11 @@ static void r8156_hw_phy_cfg(struct r8152 *tp)
 				      ((swap_a & 0x1f) << 8) |
 				      ((swap_a >> 8) & 0x1f));
 		}
+
+		/* Notify the MAC when the speed is changed to force mode. */
+		data = ocp_reg_read(tp, OCP_INTR_EN);
+		data |= INTR_SPEED_FORCE;
+		ocp_reg_write(tp, OCP_INTR_EN, data);
 		break;
 	default:
 		break;
@@ -7933,6 +7960,11 @@ static void r8156b_hw_phy_cfg(struct r8152 *tp)
 		break;
 	}
 
+	/* Notify the MAC when the speed is changed to force mode. */
+	data = ocp_reg_read(tp, OCP_INTR_EN);
+	data |= INTR_SPEED_FORCE;
+	ocp_reg_write(tp, OCP_INTR_EN, data);
+
 	if (rtl_phy_patch_request(tp, true, true))
 		return;
 
@@ -9377,7 +9409,7 @@ static int rtl_ops_init(struct r8152 *tp)
 	case RTL_VER_10:
 		ops->init		= r8156_init;
 		ops->enable		= rtl8156_enable;
-		ops->disable		= rtl8153_disable;
+		ops->disable		= rtl8156_disable;
 		ops->up			= rtl8156_up;
 		ops->down		= rtl8156_down;
 		ops->unload		= rtl8153_unload;
diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 064406959221..259d54b229bf 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3411,12 +3411,14 @@ static void free_unused_bufs(struct virtnet_info *vi)
 		struct virtqueue *vq = vi->sq[i].vq;
 		while ((buf = virtqueue_detach_unused_buf(vq)) != NULL)
 			virtnet_sq_free_unused_buf(vq, buf);
+		cond_resched();
 	}
 
 	for (i = 0; i < vi->max_queue_pairs; i++) {
 		struct virtqueue *vq = vi->rq[i].vq;
 		while ((buf = virtqueue_detach_unused_buf(vq)) != NULL)
 			virtnet_rq_free_unused_buf(vq, buf);
+		cond_resched();
 	}
 }
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index 29f75948ab00..fe2de813fbf4 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -2715,6 +2715,7 @@ static bool iwl_mvm_wait_d3_notif(struct iwl_notif_wait_data *notif_wait,
 			break;
 		}
 
+
 		d3_data->notif_received |= IWL_D3_NOTIF_WOWLAN_INFO;
 		len = iwl_rx_packet_payload_len(pkt);
 		iwl_mvm_parse_wowlan_info_notif(mvm, notif, d3_data->status,
diff --git a/drivers/platform/x86/hp/hp-wmi.c b/drivers/platform/x86/hp/hp-wmi.c
index 2ef201b625b3..3bacee2b8d52 100644
--- a/drivers/platform/x86/hp/hp-wmi.c
+++ b/drivers/platform/x86/hp/hp-wmi.c
@@ -211,6 +211,7 @@ struct bios_rfkill2_state {
 static const struct key_entry hp_wmi_keymap[] = {
 	{ KE_KEY, 0x02,    { KEY_BRIGHTNESSUP } },
 	{ KE_KEY, 0x03,    { KEY_BRIGHTNESSDOWN } },
+	{ KE_KEY, 0x270,   { KEY_MICMUTE } },
 	{ KE_KEY, 0x20e6,  { KEY_PROG1 } },
 	{ KE_KEY, 0x20e8,  { KEY_MEDIA } },
 	{ KE_KEY, 0x2142,  { KEY_MEDIA } },
diff --git a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-common.c b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-common.c
index cb24de9e97dc..fa8f14c925ec 100644
--- a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-common.c
+++ b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-common.c
@@ -44,14 +44,18 @@ static ssize_t store_min_max_freq_khz(struct uncore_data *data,
 				      int min_max)
 {
 	unsigned int input;
+	int ret;
 
 	if (kstrtouint(buf, 10, &input))
 		return -EINVAL;
 
 	mutex_lock(&uncore_lock);
-	uncore_write(data, input, min_max);
+	ret = uncore_write(data, input, min_max);
 	mutex_unlock(&uncore_lock);
 
+	if (ret)
+		return ret;
+
 	return count;
 }
 
diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index 7191ff2625b1..e40cbe81b12c 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -10318,6 +10318,7 @@ static atomic_t dytc_ignore_event = ATOMIC_INIT(0);
 static DEFINE_MUTEX(dytc_mutex);
 static int dytc_capabilities;
 static bool dytc_mmc_get_available;
+static int profile_force;
 
 static int convert_dytc_to_profile(int funcmode, int dytcmode,
 		enum platform_profile_option *profile)
@@ -10580,6 +10581,21 @@ static int tpacpi_dytc_profile_init(struct ibm_init_struct *iibm)
 	if (err)
 		return err;
 
+	/* Check if user wants to override the profile selection */
+	if (profile_force) {
+		switch (profile_force) {
+		case -1:
+			dytc_capabilities = 0;
+			break;
+		case 1:
+			dytc_capabilities = BIT(DYTC_FC_MMC);
+			break;
+		case 2:
+			dytc_capabilities = BIT(DYTC_FC_PSC);
+			break;
+		}
+		pr_debug("Profile selection forced: 0x%x\n", dytc_capabilities);
+	}
 	if (dytc_capabilities & BIT(DYTC_FC_MMC)) { /* MMC MODE */
 		pr_debug("MMC is supported\n");
 		/*
@@ -10593,11 +10609,6 @@ static int tpacpi_dytc_profile_init(struct ibm_init_struct *iibm)
 				dytc_mmc_get_available = true;
 		}
 	} else if (dytc_capabilities & BIT(DYTC_FC_PSC)) { /* PSC MODE */
-		/* Support for this only works on AMD platforms */
-		if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD) {
-			dbg_printk(TPACPI_DBG_INIT, "PSC not support on Intel platforms\n");
-			return -ENODEV;
-		}
 		pr_debug("PSC is supported\n");
 	} else {
 		dbg_printk(TPACPI_DBG_INIT, "No DYTC support available\n");
@@ -11646,6 +11657,9 @@ MODULE_PARM_DESC(uwb_state,
 		 "Initial state of the emulated UWB switch");
 #endif
 
+module_param(profile_force, int, 0444);
+MODULE_PARM_DESC(profile_force, "Force profile mode. -1=off, 1=MMC, 2=PSC");
+
 static void thinkpad_acpi_module_exit(void)
 {
 	struct ibm_struct *ibm, *itmp;
diff --git a/drivers/platform/x86/touchscreen_dmi.c b/drivers/platform/x86/touchscreen_dmi.c
index 13802a3c3591..68e66b60445c 100644
--- a/drivers/platform/x86/touchscreen_dmi.c
+++ b/drivers/platform/x86/touchscreen_dmi.c
@@ -336,6 +336,22 @@ static const struct ts_dmi_data dexp_ursus_7w_data = {
 	.properties	= dexp_ursus_7w_props,
 };
 
+static const struct property_entry dexp_ursus_kx210i_props[] = {
+	PROPERTY_ENTRY_U32("touchscreen-min-x", 5),
+	PROPERTY_ENTRY_U32("touchscreen-min-y",  2),
+	PROPERTY_ENTRY_U32("touchscreen-size-x", 1720),
+	PROPERTY_ENTRY_U32("touchscreen-size-y", 1137),
+	PROPERTY_ENTRY_STRING("firmware-name", "gsl1680-dexp-ursus-kx210i.fw"),
+	PROPERTY_ENTRY_U32("silead,max-fingers", 10),
+	PROPERTY_ENTRY_BOOL("silead,home-button"),
+	{ }
+};
+
+static const struct ts_dmi_data dexp_ursus_kx210i_data = {
+	.acpi_name	= "MSSL1680:00",
+	.properties	= dexp_ursus_kx210i_props,
+};
+
 static const struct property_entry digma_citi_e200_props[] = {
 	PROPERTY_ENTRY_U32("touchscreen-size-x", 1980),
 	PROPERTY_ENTRY_U32("touchscreen-size-y", 1500),
@@ -378,6 +394,11 @@ static const struct ts_dmi_data gdix1001_01_upside_down_data = {
 	.properties	= gdix1001_upside_down_props,
 };
 
+static const struct ts_dmi_data gdix1002_00_upside_down_data = {
+	.acpi_name	= "GDIX1002:00",
+	.properties	= gdix1001_upside_down_props,
+};
+
 static const struct property_entry gp_electronic_t701_props[] = {
 	PROPERTY_ENTRY_U32("touchscreen-size-x", 960),
 	PROPERTY_ENTRY_U32("touchscreen-size-y", 640),
@@ -1185,6 +1206,14 @@ const struct dmi_system_id touchscreen_dmi_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "7W"),
 		},
 	},
+	{
+		/* DEXP Ursus KX210i */
+		.driver_data = (void *)&dexp_ursus_kx210i_data,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "INSYDE Corp."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "S107I"),
+		},
+	},
 	{
 		/* Digma Citi E200 */
 		.driver_data = (void *)&digma_citi_e200_data,
@@ -1295,6 +1324,18 @@ const struct dmi_system_id touchscreen_dmi_table[] = {
 			DMI_MATCH(DMI_BIOS_VERSION, "jumperx.T87.KFBNEEA"),
 		},
 	},
+	{
+		/* Juno Tablet */
+		.driver_data = (void *)&gdix1002_00_upside_down_data,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Default string"),
+			/* Both product- and board-name being "Default string" is somewhat rare */
+			DMI_MATCH(DMI_PRODUCT_NAME, "Default string"),
+			DMI_MATCH(DMI_BOARD_NAME, "Default string"),
+			/* Above matches are too generic, add partial bios-version match */
+			DMI_MATCH(DMI_BIOS_VERSION, "JP2V1."),
+		},
+	},
 	{
 		/* Mediacom WinPad 7.0 W700 (same hw as Wintron surftab 7") */
 		.driver_data = (void *)&trekstor_surftab_wintron70_data,
diff --git a/drivers/remoteproc/imx_dsp_rproc.c b/drivers/remoteproc/imx_dsp_rproc.c
index 95da1cbefacf..506ec9565716 100644
--- a/drivers/remoteproc/imx_dsp_rproc.c
+++ b/drivers/remoteproc/imx_dsp_rproc.c
@@ -627,15 +627,19 @@ static int imx_dsp_rproc_add_carveout(struct imx_dsp_rproc *priv)
 
 		rmem = of_reserved_mem_lookup(it.node);
 		if (!rmem) {
+			of_node_put(it.node);
 			dev_err(dev, "unable to acquire memory-region\n");
 			return -EINVAL;
 		}
 
-		if (imx_dsp_rproc_sys_to_da(priv, rmem->base, rmem->size, &da))
+		if (imx_dsp_rproc_sys_to_da(priv, rmem->base, rmem->size, &da)) {
+			of_node_put(it.node);
 			return -EINVAL;
+		}
 
 		cpu_addr = devm_ioremap_wc(dev, rmem->base, rmem->size);
 		if (!cpu_addr) {
+			of_node_put(it.node);
 			dev_err(dev, "failed to map memory %p\n", &rmem->base);
 			return -ENOMEM;
 		}
@@ -644,10 +648,12 @@ static int imx_dsp_rproc_add_carveout(struct imx_dsp_rproc *priv)
 		mem = rproc_mem_entry_init(dev, (void __force *)cpu_addr, (dma_addr_t)rmem->base,
 					   rmem->size, da, NULL, NULL, it.node->name);
 
-		if (mem)
+		if (mem) {
 			rproc_coredump_add_segment(rproc, da, rmem->size);
-		else
+		} else {
+			of_node_put(it.node);
 			return -ENOMEM;
+		}
 
 		rproc_add_carveout(rproc, mem);
 	}
diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
index 9fc978e0393c..0ab840dc7e97 100644
--- a/drivers/remoteproc/imx_rproc.c
+++ b/drivers/remoteproc/imx_rproc.c
@@ -541,6 +541,7 @@ static int imx_rproc_prepare(struct rproc *rproc)
 
 		rmem = of_reserved_mem_lookup(it.node);
 		if (!rmem) {
+			of_node_put(it.node);
 			dev_err(priv->dev, "unable to acquire memory-region\n");
 			return -EINVAL;
 		}
@@ -553,10 +554,12 @@ static int imx_rproc_prepare(struct rproc *rproc)
 					   imx_rproc_mem_alloc, imx_rproc_mem_release,
 					   it.node->name);
 
-		if (mem)
+		if (mem) {
 			rproc_coredump_add_segment(rproc, da, rmem->size);
-		else
+		} else {
+			of_node_put(it.node);
 			return -ENOMEM;
+		}
 
 		rproc_add_carveout(rproc, mem);
 	}
diff --git a/drivers/remoteproc/rcar_rproc.c b/drivers/remoteproc/rcar_rproc.c
index aa86154109c7..1ff2a73ade90 100644
--- a/drivers/remoteproc/rcar_rproc.c
+++ b/drivers/remoteproc/rcar_rproc.c
@@ -62,13 +62,16 @@ static int rcar_rproc_prepare(struct rproc *rproc)
 
 		rmem = of_reserved_mem_lookup(it.node);
 		if (!rmem) {
+			of_node_put(it.node);
 			dev_err(&rproc->dev,
 				"unable to acquire memory-region\n");
 			return -EINVAL;
 		}
 
-		if (rmem->base > U32_MAX)
+		if (rmem->base > U32_MAX) {
+			of_node_put(it.node);
 			return -EINVAL;
+		}
 
 		/* No need to translate pa to da, R-Car use same map */
 		da = rmem->base;
@@ -79,8 +82,10 @@ static int rcar_rproc_prepare(struct rproc *rproc)
 					   rcar_rproc_mem_release,
 					   it.node->name);
 
-		if (!mem)
+		if (!mem) {
+			of_node_put(it.node);
 			return -ENOMEM;
+		}
 
 		rproc_add_carveout(rproc, mem);
 	}
diff --git a/drivers/remoteproc/st_remoteproc.c b/drivers/remoteproc/st_remoteproc.c
index a3268d95a50e..e6bd3c7a950a 100644
--- a/drivers/remoteproc/st_remoteproc.c
+++ b/drivers/remoteproc/st_remoteproc.c
@@ -129,6 +129,7 @@ static int st_rproc_parse_fw(struct rproc *rproc, const struct firmware *fw)
 	while (of_phandle_iterator_next(&it) == 0) {
 		rmem = of_reserved_mem_lookup(it.node);
 		if (!rmem) {
+			of_node_put(it.node);
 			dev_err(dev, "unable to acquire memory-region\n");
 			return -EINVAL;
 		}
@@ -150,8 +151,10 @@ static int st_rproc_parse_fw(struct rproc *rproc, const struct firmware *fw)
 							   it.node->name);
 		}
 
-		if (!mem)
+		if (!mem) {
+			of_node_put(it.node);
 			return -ENOMEM;
+		}
 
 		rproc_add_carveout(rproc, mem);
 		index++;
diff --git a/drivers/remoteproc/stm32_rproc.c b/drivers/remoteproc/stm32_rproc.c
index 7d782ed9e589..23c1690b8d73 100644
--- a/drivers/remoteproc/stm32_rproc.c
+++ b/drivers/remoteproc/stm32_rproc.c
@@ -223,11 +223,13 @@ static int stm32_rproc_prepare(struct rproc *rproc)
 	while (of_phandle_iterator_next(&it) == 0) {
 		rmem = of_reserved_mem_lookup(it.node);
 		if (!rmem) {
+			of_node_put(it.node);
 			dev_err(dev, "unable to acquire memory-region\n");
 			return -EINVAL;
 		}
 
 		if (stm32_rproc_pa_to_da(rproc, rmem->base, &da) < 0) {
+			of_node_put(it.node);
 			dev_err(dev, "memory region not valid %pa\n",
 				&rmem->base);
 			return -EINVAL;
@@ -254,8 +256,10 @@ static int stm32_rproc_prepare(struct rproc *rproc)
 							   it.node->name);
 		}
 
-		if (!mem)
+		if (!mem) {
+			of_node_put(it.node);
 			return -ENOMEM;
+		}
 
 		rproc_add_carveout(rproc, mem);
 		index++;
diff --git a/drivers/scsi/qedi/qedi_main.c b/drivers/scsi/qedi/qedi_main.c
index f2ee49756df8..45d359554182 100644
--- a/drivers/scsi/qedi/qedi_main.c
+++ b/drivers/scsi/qedi/qedi_main.c
@@ -2450,6 +2450,9 @@ static void __qedi_remove(struct pci_dev *pdev, int mode)
 		qedi_ops->ll2->stop(qedi->cdev);
 	}
 
+	cancel_delayed_work_sync(&qedi->recovery_work);
+	cancel_delayed_work_sync(&qedi->board_disable_work);
+
 	qedi_free_iscsi_pf_param(qedi);
 
 	rval = qedi_ops->common->update_drv_state(qedi->cdev, false);
diff --git a/drivers/soc/qcom/llcc-qcom.c b/drivers/soc/qcom/llcc-qcom.c
index 26efe12012a0..d4d3eced52f3 100644
--- a/drivers/soc/qcom/llcc-qcom.c
+++ b/drivers/soc/qcom/llcc-qcom.c
@@ -122,10 +122,11 @@ struct llcc_slice_config {
 
 struct qcom_llcc_config {
 	const struct llcc_slice_config *sct_data;
-	int size;
-	bool need_llcc_cfg;
 	const u32 *reg_offset;
 	const struct llcc_edac_reg_offset *edac_reg_offset;
+	int size;
+	bool need_llcc_cfg;
+	bool no_edac;
 };
 
 enum llcc_reg_offset {
@@ -454,6 +455,7 @@ static const struct qcom_llcc_config sdm845_cfg = {
 	.need_llcc_cfg	= false,
 	.reg_offset	= llcc_v1_reg_offset,
 	.edac_reg_offset = &llcc_v1_edac_reg_offset,
+	.no_edac	= true,
 };
 
 static const struct qcom_llcc_config sm6350_cfg = {
@@ -1001,7 +1003,14 @@ static int qcom_llcc_probe(struct platform_device *pdev)
 		goto err;
 
 	drv_data->ecc_irq = platform_get_irq_optional(pdev, 0);
-	if (drv_data->ecc_irq >= 0) {
+
+	/*
+	 * On some platforms, the access to EDAC registers will be locked by
+	 * the bootloader. So probing the EDAC driver will result in a crash.
+	 * Hence, disable the creation of EDAC platform device for the
+	 * problematic platforms.
+	 */
+	if (!cfg->no_edac) {
 		llcc_edac = platform_device_register_data(&pdev->dev,
 						"qcom_llcc_edac", -1, drv_data,
 						sizeof(*drv_data));
diff --git a/drivers/spi/spi-fsl-cpm.c b/drivers/spi/spi-fsl-cpm.c
index 17a44d4f5021..38452089e8f3 100644
--- a/drivers/spi/spi-fsl-cpm.c
+++ b/drivers/spi/spi-fsl-cpm.c
@@ -21,6 +21,7 @@
 #include <linux/spi/spi.h>
 #include <linux/types.h>
 #include <linux/platform_device.h>
+#include <linux/byteorder/generic.h>
 
 #include "spi-fsl-cpm.h"
 #include "spi-fsl-lib.h"
@@ -120,6 +121,21 @@ int fsl_spi_cpm_bufs(struct mpc8xxx_spi *mspi,
 		mspi->rx_dma = mspi->dma_dummy_rx;
 		mspi->map_rx_dma = 0;
 	}
+	if (t->bits_per_word == 16 && t->tx_buf) {
+		const u16 *src = t->tx_buf;
+		u16 *dst;
+		int i;
+
+		dst = kmalloc(t->len, GFP_KERNEL);
+		if (!dst)
+			return -ENOMEM;
+
+		for (i = 0; i < t->len >> 1; i++)
+			dst[i] = cpu_to_le16p(src + i);
+
+		mspi->tx = dst;
+		mspi->map_tx_dma = 1;
+	}
 
 	if (mspi->map_tx_dma) {
 		void *nonconst_tx = (void *)mspi->tx; /* shut up gcc */
@@ -173,6 +189,13 @@ void fsl_spi_cpm_bufs_complete(struct mpc8xxx_spi *mspi)
 	if (mspi->map_rx_dma)
 		dma_unmap_single(dev, mspi->rx_dma, t->len, DMA_FROM_DEVICE);
 	mspi->xfer_in_progress = NULL;
+
+	if (t->bits_per_word == 16 && t->rx_buf) {
+		int i;
+
+		for (i = 0; i < t->len; i += 2)
+			le16_to_cpus(t->rx_buf + i);
+	}
 }
 EXPORT_SYMBOL_GPL(fsl_spi_cpm_bufs_complete);
 
diff --git a/drivers/spi/spi-fsl-spi.c b/drivers/spi/spi-fsl-spi.c
index 5602f052b2b5..b14f430a699d 100644
--- a/drivers/spi/spi-fsl-spi.c
+++ b/drivers/spi/spi-fsl-spi.c
@@ -177,26 +177,6 @@ static int mspi_apply_cpu_mode_quirks(struct spi_mpc8xxx_cs *cs,
 	return bits_per_word;
 }
 
-static int mspi_apply_qe_mode_quirks(struct spi_mpc8xxx_cs *cs,
-				struct spi_device *spi,
-				int bits_per_word)
-{
-	/* CPM/QE uses Little Endian for words > 8
-	 * so transform 16 and 32 bits words into 8 bits
-	 * Unfortnatly that doesn't work for LSB so
-	 * reject these for now */
-	/* Note: 32 bits word, LSB works iff
-	 * tfcr/rfcr is set to CPMFCR_GBL */
-	if (spi->mode & SPI_LSB_FIRST &&
-	    bits_per_word > 8)
-		return -EINVAL;
-	if (bits_per_word <= 8)
-		return bits_per_word;
-	if (bits_per_word == 16 || bits_per_word == 32)
-		return 8; /* pretend its 8 bits */
-	return -EINVAL;
-}
-
 static int fsl_spi_setup_transfer(struct spi_device *spi,
 					struct spi_transfer *t)
 {
@@ -224,9 +204,6 @@ static int fsl_spi_setup_transfer(struct spi_device *spi,
 		bits_per_word = mspi_apply_cpu_mode_quirks(cs, spi,
 							   mpc8xxx_spi,
 							   bits_per_word);
-	else
-		bits_per_word = mspi_apply_qe_mode_quirks(cs, spi,
-							  bits_per_word);
 
 	if (bits_per_word < 0)
 		return bits_per_word;
@@ -361,6 +338,22 @@ static int fsl_spi_prepare_message(struct spi_controller *ctlr,
 				t->bits_per_word = 32;
 			else if ((t->len & 1) == 0)
 				t->bits_per_word = 16;
+		} else {
+			/*
+			 * CPM/QE uses Little Endian for words > 8
+			 * so transform 16 and 32 bits words into 8 bits
+			 * Unfortnatly that doesn't work for LSB so
+			 * reject these for now
+			 * Note: 32 bits word, LSB works iff
+			 * tfcr/rfcr is set to CPMFCR_GBL
+			 */
+			if (m->spi->mode & SPI_LSB_FIRST && t->bits_per_word > 8)
+				return -EINVAL;
+			if (t->bits_per_word == 16 || t->bits_per_word == 32)
+				t->bits_per_word = 8; /* pretend its 8 bits */
+			if (t->bits_per_word == 8 && t->len >= 256 &&
+			    (mpc8xxx_spi->flags & SPI_CPM1))
+				t->bits_per_word = 16;
 		}
 	}
 	return fsl_spi_setup_transfer(m->spi, first);
@@ -594,8 +587,14 @@ static struct spi_master *fsl_spi_probe(struct device *dev,
 	if (mpc8xxx_spi->type == TYPE_GRLIB)
 		fsl_spi_grlib_probe(dev);
 
-	master->bits_per_word_mask =
-		(SPI_BPW_RANGE_MASK(4, 16) | SPI_BPW_MASK(32)) &
+	if (mpc8xxx_spi->flags & SPI_CPM_MODE)
+		master->bits_per_word_mask =
+			(SPI_BPW_RANGE_MASK(4, 8) | SPI_BPW_MASK(16) | SPI_BPW_MASK(32));
+	else
+		master->bits_per_word_mask =
+			(SPI_BPW_RANGE_MASK(4, 16) | SPI_BPW_MASK(32));
+
+	master->bits_per_word_mask &=
 		SPI_BPW_RANGE_MASK(1, mpc8xxx_spi->max_bits_per_word);
 
 	if (mpc8xxx_spi->flags & SPI_QE_CPU_MODE)
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 3faac3244c7d..e63700937ba8 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -2478,7 +2478,7 @@ static void __dwc3_gadget_set_speed(struct dwc3 *dwc)
 	dwc3_writel(dwc->regs, DWC3_DCFG, reg);
 }
 
-static int dwc3_gadget_run_stop(struct dwc3 *dwc, int is_on, int suspend)
+static int dwc3_gadget_run_stop(struct dwc3 *dwc, int is_on)
 {
 	u32			reg;
 	u32			timeout = 2000;
@@ -2497,17 +2497,11 @@ static int dwc3_gadget_run_stop(struct dwc3 *dwc, int is_on, int suspend)
 			reg &= ~DWC3_DCTL_KEEP_CONNECT;
 		reg |= DWC3_DCTL_RUN_STOP;
 
-		if (dwc->has_hibernation)
-			reg |= DWC3_DCTL_KEEP_CONNECT;
-
 		__dwc3_gadget_set_speed(dwc);
 		dwc->pullups_connected = true;
 	} else {
 		reg &= ~DWC3_DCTL_RUN_STOP;
 
-		if (dwc->has_hibernation && !suspend)
-			reg &= ~DWC3_DCTL_KEEP_CONNECT;
-
 		dwc->pullups_connected = false;
 	}
 
@@ -2552,7 +2546,6 @@ static int dwc3_gadget_soft_disconnect(struct dwc3 *dwc)
 	 * bit.
 	 */
 	dwc3_stop_active_transfers(dwc);
-	__dwc3_gadget_stop(dwc);
 	spin_unlock_irqrestore(&dwc->lock, flags);
 
 	/*
@@ -2589,7 +2582,19 @@ static int dwc3_gadget_soft_disconnect(struct dwc3 *dwc)
 	 * remaining event generated by the controller while polling for
 	 * DSTS.DEVCTLHLT.
 	 */
-	return dwc3_gadget_run_stop(dwc, false, false);
+	ret = dwc3_gadget_run_stop(dwc, false);
+
+	/*
+	 * Stop the gadget after controller is halted, so that if needed, the
+	 * events to update EP0 state can still occur while the run/stop
+	 * routine polls for the halted state.  DEVTEN is cleared as part of
+	 * gadget stop.
+	 */
+	spin_lock_irqsave(&dwc->lock, flags);
+	__dwc3_gadget_stop(dwc);
+	spin_unlock_irqrestore(&dwc->lock, flags);
+
+	return ret;
 }
 
 static int dwc3_gadget_pullup(struct usb_gadget *g, int is_on)
@@ -2643,7 +2648,7 @@ static int dwc3_gadget_pullup(struct usb_gadget *g, int is_on)
 
 		dwc3_event_buffers_setup(dwc);
 		__dwc3_gadget_start(dwc);
-		ret = dwc3_gadget_run_stop(dwc, true, false);
+		ret = dwc3_gadget_run_stop(dwc, true);
 	}
 
 	pm_runtime_put(dwc->dev);
@@ -4210,30 +4215,6 @@ static void dwc3_gadget_suspend_interrupt(struct dwc3 *dwc,
 	dwc->link_state = next;
 }
 
-static void dwc3_gadget_hibernation_interrupt(struct dwc3 *dwc,
-		unsigned int evtinfo)
-{
-	unsigned int is_ss = evtinfo & BIT(4);
-
-	/*
-	 * WORKAROUND: DWC3 revision 2.20a with hibernation support
-	 * have a known issue which can cause USB CV TD.9.23 to fail
-	 * randomly.
-	 *
-	 * Because of this issue, core could generate bogus hibernation
-	 * events which SW needs to ignore.
-	 *
-	 * Refers to:
-	 *
-	 * STAR#9000546576: Device Mode Hibernation: Issue in USB 2.0
-	 * Device Fallback from SuperSpeed
-	 */
-	if (is_ss ^ (dwc->speed == USB_SPEED_SUPER))
-		return;
-
-	/* enter hibernation here */
-}
-
 static void dwc3_gadget_interrupt(struct dwc3 *dwc,
 		const struct dwc3_event_devt *event)
 {
@@ -4251,11 +4232,7 @@ static void dwc3_gadget_interrupt(struct dwc3 *dwc,
 		dwc3_gadget_wakeup_interrupt(dwc);
 		break;
 	case DWC3_DEVICE_EVENT_HIBER_REQ:
-		if (dev_WARN_ONCE(dwc->dev, !dwc->has_hibernation,
-					"unexpected hibernation event\n"))
-			break;
-
-		dwc3_gadget_hibernation_interrupt(dwc, event->event_info);
+		dev_WARN_ONCE(dwc->dev, true, "unexpected hibernation event\n");
 		break;
 	case DWC3_DEVICE_EVENT_LINK_STATUS_CHANGE:
 		dwc3_gadget_linksts_change_interrupt(dwc, event->event_info);
@@ -4592,7 +4569,7 @@ int dwc3_gadget_suspend(struct dwc3 *dwc)
 	if (!dwc->gadget_driver)
 		return 0;
 
-	dwc3_gadget_run_stop(dwc, false, false);
+	dwc3_gadget_run_stop(dwc, false);
 
 	spin_lock_irqsave(&dwc->lock, flags);
 	dwc3_disconnect_gadget(dwc);
@@ -4613,7 +4590,7 @@ int dwc3_gadget_resume(struct dwc3 *dwc)
 	if (ret < 0)
 		goto err0;
 
-	ret = dwc3_gadget_run_stop(dwc, true, false);
+	ret = dwc3_gadget_run_stop(dwc, true);
 	if (ret < 0)
 		goto err1;
 
diff --git a/drivers/watchdog/dw_wdt.c b/drivers/watchdog/dw_wdt.c
index 52962e8d11a6..61af5d1332ac 100644
--- a/drivers/watchdog/dw_wdt.c
+++ b/drivers/watchdog/dw_wdt.c
@@ -635,7 +635,7 @@ static int dw_wdt_drv_probe(struct platform_device *pdev)
 
 	ret = dw_wdt_init_timeouts(dw_wdt, dev);
 	if (ret)
-		goto out_disable_clk;
+		goto out_assert_rst;
 
 	wdd = &dw_wdt->wdd;
 	wdd->ops = &dw_wdt_ops;
@@ -666,12 +666,15 @@ static int dw_wdt_drv_probe(struct platform_device *pdev)
 
 	ret = watchdog_register_device(wdd);
 	if (ret)
-		goto out_disable_pclk;
+		goto out_assert_rst;
 
 	dw_wdt_dbgfs_init(dw_wdt);
 
 	return 0;
 
+out_assert_rst:
+	reset_control_assert(dw_wdt->rst);
+
 out_disable_pclk:
 	clk_disable_unprepare(dw_wdt->pclk);
 
diff --git a/fs/afs/afs.h b/fs/afs/afs.h
index 432cb4b23961..81815724db6c 100644
--- a/fs/afs/afs.h
+++ b/fs/afs/afs.h
@@ -19,8 +19,8 @@
 #define AFSPATHMAX		1024	/* Maximum length of a pathname plus NUL */
 #define AFSOPAQUEMAX		1024	/* Maximum length of an opaque field */
 
-#define AFS_VL_MAX_LIFESPAN	(120 * HZ)
-#define AFS_PROBE_MAX_LIFESPAN	(30 * HZ)
+#define AFS_VL_MAX_LIFESPAN	120
+#define AFS_PROBE_MAX_LIFESPAN	30
 
 typedef u64			afs_volid_t;
 typedef u64			afs_vnodeid_t;
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index fd8567b98e2b..cd23a3c5b6ac 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -127,7 +127,7 @@ struct afs_call {
 	spinlock_t		state_lock;
 	int			error;		/* error code */
 	u32			abort_code;	/* Remote abort ID or 0 */
-	unsigned int		max_lifespan;	/* Maximum lifespan to set if not 0 */
+	unsigned int		max_lifespan;	/* Maximum lifespan in secs to set if not 0 */
 	unsigned		request_size;	/* size of request data */
 	unsigned		reply_max;	/* maximum size of reply */
 	unsigned		count2;		/* count used in unmarshalling */
diff --git a/fs/afs/rxrpc.c b/fs/afs/rxrpc.c
index 7817e2b860e5..6862e3dde364 100644
--- a/fs/afs/rxrpc.c
+++ b/fs/afs/rxrpc.c
@@ -334,7 +334,9 @@ void afs_make_call(struct afs_addr_cursor *ac, struct afs_call *call, gfp_t gfp)
 	/* create a call */
 	rxcall = rxrpc_kernel_begin_call(call->net->socket, srx, call->key,
 					 (unsigned long)call,
-					 tx_total_len, gfp,
+					 tx_total_len,
+					 call->max_lifespan,
+					 gfp,
 					 (call->async ?
 					  afs_wake_up_async_call :
 					  afs_wake_up_call_waiter),
@@ -349,10 +351,6 @@ void afs_make_call(struct afs_addr_cursor *ac, struct afs_call *call, gfp_t gfp)
 	}
 
 	call->rxcall = rxcall;
-
-	if (call->max_lifespan)
-		rxrpc_kernel_set_max_life(call->net->socket, rxcall,
-					  call->max_lifespan);
 	call->issue_time = ktime_get_real();
 
 	/* send the request */
diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index 0d7ae20e39c9..ab4bad7dfa6e 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -45,7 +45,8 @@ static int check_extent_in_eb(struct btrfs_backref_walk_ctx *ctx,
 	int root_count;
 	bool cached;
 
-	if (!btrfs_file_extent_compression(eb, fi) &&
+	if (!ctx->ignore_extent_item_pos &&
+	    !btrfs_file_extent_compression(eb, fi) &&
 	    !btrfs_file_extent_encryption(eb, fi) &&
 	    !btrfs_file_extent_other_encoding(eb, fi)) {
 		u64 data_offset;
@@ -552,7 +553,7 @@ static int add_all_parents(struct btrfs_backref_walk_ctx *ctx,
 				count++;
 			else
 				goto next;
-			if (!ctx->ignore_extent_item_pos) {
+			if (!ctx->skip_inode_ref_list) {
 				ret = check_extent_in_eb(ctx, &key, eb, fi, &eie);
 				if (ret == BTRFS_ITERATE_EXTENT_INODES_STOP ||
 				    ret < 0)
@@ -564,7 +565,7 @@ static int add_all_parents(struct btrfs_backref_walk_ctx *ctx,
 						  eie, (void **)&old, GFP_NOFS);
 			if (ret < 0)
 				break;
-			if (!ret && !ctx->ignore_extent_item_pos) {
+			if (!ret && !ctx->skip_inode_ref_list) {
 				while (old->next)
 					old = old->next;
 				old->next = eie;
@@ -1598,7 +1599,7 @@ static int find_parent_nodes(struct btrfs_backref_walk_ctx *ctx,
 				goto out;
 		}
 		if (ref->count && ref->parent) {
-			if (!ctx->ignore_extent_item_pos && !ref->inode_list &&
+			if (!ctx->skip_inode_ref_list && !ref->inode_list &&
 			    ref->level == 0) {
 				struct btrfs_tree_parent_check check = { 0 };
 				struct extent_buffer *eb;
@@ -1639,7 +1640,7 @@ static int find_parent_nodes(struct btrfs_backref_walk_ctx *ctx,
 						  (void **)&eie, GFP_NOFS);
 			if (ret < 0)
 				goto out;
-			if (!ret && !ctx->ignore_extent_item_pos) {
+			if (!ret && !ctx->skip_inode_ref_list) {
 				/*
 				 * We've recorded that parent, so we must extend
 				 * its inode list here.
@@ -1735,7 +1736,7 @@ int btrfs_find_all_leafs(struct btrfs_backref_walk_ctx *ctx)
 static int btrfs_find_all_roots_safe(struct btrfs_backref_walk_ctx *ctx)
 {
 	const u64 orig_bytenr = ctx->bytenr;
-	const bool orig_ignore_extent_item_pos = ctx->ignore_extent_item_pos;
+	const bool orig_skip_inode_ref_list = ctx->skip_inode_ref_list;
 	bool roots_ulist_allocated = false;
 	struct ulist_iterator uiter;
 	int ret = 0;
@@ -1756,7 +1757,7 @@ static int btrfs_find_all_roots_safe(struct btrfs_backref_walk_ctx *ctx)
 		roots_ulist_allocated = true;
 	}
 
-	ctx->ignore_extent_item_pos = true;
+	ctx->skip_inode_ref_list = true;
 
 	ULIST_ITER_INIT(&uiter);
 	while (1) {
@@ -1781,7 +1782,7 @@ static int btrfs_find_all_roots_safe(struct btrfs_backref_walk_ctx *ctx)
 	ulist_free(ctx->refs);
 	ctx->refs = NULL;
 	ctx->bytenr = orig_bytenr;
-	ctx->ignore_extent_item_pos = orig_ignore_extent_item_pos;
+	ctx->skip_inode_ref_list = orig_skip_inode_ref_list;
 
 	return ret;
 }
@@ -1885,7 +1886,7 @@ int btrfs_is_data_extent_shared(struct btrfs_inode *inode, u64 bytenr,
 		walk_ctx.time_seq = elem.seq;
 	}
 
-	walk_ctx.ignore_extent_item_pos = true;
+	walk_ctx.skip_inode_ref_list = true;
 	walk_ctx.trans = trans;
 	walk_ctx.fs_info = fs_info;
 	walk_ctx.refs = &ctx->refs;
diff --git a/fs/btrfs/backref.h b/fs/btrfs/backref.h
index ef6bbea3f456..1616e3e3f1e4 100644
--- a/fs/btrfs/backref.h
+++ b/fs/btrfs/backref.h
@@ -60,6 +60,12 @@ struct btrfs_backref_walk_ctx {
 	 * @extent_item_pos is ignored.
 	 */
 	bool ignore_extent_item_pos;
+	/*
+	 * If true and bytenr corresponds to a data extent, then the inode list
+	 * (each member describing inode number, file offset and root) is not
+	 * added to each reference added to the @refs ulist.
+	 */
+	bool skip_inode_ref_list;
 	/* A valid transaction handle or NULL. */
 	struct btrfs_trans_handle *trans;
 	/*
diff --git a/fs/btrfs/block-rsv.c b/fs/btrfs/block-rsv.c
index 5367a14d44d2..4bb4a4875872 100644
--- a/fs/btrfs/block-rsv.c
+++ b/fs/btrfs/block-rsv.c
@@ -124,7 +124,8 @@ static u64 block_rsv_release_bytes(struct btrfs_fs_info *fs_info,
 	} else {
 		num_bytes = 0;
 	}
-	if (block_rsv->qgroup_rsv_reserved >= block_rsv->qgroup_rsv_size) {
+	if (qgroup_to_release_ret &&
+	    block_rsv->qgroup_rsv_reserved >= block_rsv->qgroup_rsv_size) {
 		qgroup_to_release = block_rsv->qgroup_rsv_reserved -
 				    block_rsv->qgroup_rsv_size;
 		block_rsv->qgroup_rsv_reserved = block_rsv->qgroup_rsv_size;
diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 4754c9101a4c..306cc735180f 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -4493,10 +4493,12 @@ int btrfs_del_items(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 int btrfs_prev_leaf(struct btrfs_root *root, struct btrfs_path *path)
 {
 	struct btrfs_key key;
+	struct btrfs_key orig_key;
 	struct btrfs_disk_key found_key;
 	int ret;
 
 	btrfs_item_key_to_cpu(path->nodes[0], &key, 0);
+	orig_key = key;
 
 	if (key.offset > 0) {
 		key.offset--;
@@ -4513,8 +4515,36 @@ int btrfs_prev_leaf(struct btrfs_root *root, struct btrfs_path *path)
 
 	btrfs_release_path(path);
 	ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
-	if (ret < 0)
+	if (ret <= 0)
 		return ret;
+
+	/*
+	 * Previous key not found. Even if we were at slot 0 of the leaf we had
+	 * before releasing the path and calling btrfs_search_slot(), we now may
+	 * be in a slot pointing to the same original key - this can happen if
+	 * after we released the path, one of more items were moved from a
+	 * sibling leaf into the front of the leaf we had due to an insertion
+	 * (see push_leaf_right()).
+	 * If we hit this case and our slot is > 0 and just decrement the slot
+	 * so that the caller does not process the same key again, which may or
+	 * may not break the caller, depending on its logic.
+	 */
+	if (path->slots[0] < btrfs_header_nritems(path->nodes[0])) {
+		btrfs_item_key(path->nodes[0], &found_key, path->slots[0]);
+		ret = comp_keys(&found_key, &orig_key);
+		if (ret == 0) {
+			if (path->slots[0] > 0) {
+				path->slots[0]--;
+				return 0;
+			}
+			/*
+			 * At slot 0, same key as before, it means orig_key is
+			 * the lowest, leftmost, key in the tree. We're done.
+			 */
+			return 1;
+		}
+	}
+
 	btrfs_item_key(path->nodes[0], &found_key, 0);
 	ret = comp_keys(&found_key, &key);
 	/*
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 174d196d6960..fc1f3a91d882 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3306,23 +3306,34 @@ int btrfs_start_pre_rw_mount(struct btrfs_fs_info *fs_info)
 {
 	int ret;
 	const bool cache_opt = btrfs_test_opt(fs_info, SPACE_CACHE);
-	bool clear_free_space_tree = false;
+	bool rebuild_free_space_tree = false;
 
 	if (btrfs_test_opt(fs_info, CLEAR_CACHE) &&
 	    btrfs_fs_compat_ro(fs_info, FREE_SPACE_TREE)) {
-		clear_free_space_tree = true;
+		rebuild_free_space_tree = true;
 	} else if (btrfs_fs_compat_ro(fs_info, FREE_SPACE_TREE) &&
 		   !btrfs_fs_compat_ro(fs_info, FREE_SPACE_TREE_VALID)) {
 		btrfs_warn(fs_info, "free space tree is invalid");
-		clear_free_space_tree = true;
+		rebuild_free_space_tree = true;
 	}
 
-	if (clear_free_space_tree) {
-		btrfs_info(fs_info, "clearing free space tree");
-		ret = btrfs_clear_free_space_tree(fs_info);
+	if (rebuild_free_space_tree) {
+		btrfs_info(fs_info, "rebuilding free space tree");
+		ret = btrfs_rebuild_free_space_tree(fs_info);
 		if (ret) {
 			btrfs_warn(fs_info,
-				   "failed to clear free space tree: %d", ret);
+				   "failed to rebuild free space tree: %d", ret);
+			goto out;
+		}
+	}
+
+	if (btrfs_fs_compat_ro(fs_info, FREE_SPACE_TREE) &&
+	    !btrfs_test_opt(fs_info, FREE_SPACE_TREE)) {
+		btrfs_info(fs_info, "disabling free space tree");
+		ret = btrfs_delete_free_space_tree(fs_info);
+		if (ret) {
+			btrfs_warn(fs_info,
+				   "failed to disable free space tree: %d", ret);
 			goto out;
 		}
 	}
diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index 5de73466b2ca..d4d88ee04bf9 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -52,13 +52,13 @@ void btrfs_inode_safe_disk_i_size_write(struct btrfs_inode *inode, u64 new_i_siz
 	u64 start, end, i_size;
 	int ret;
 
+	spin_lock(&inode->lock);
 	i_size = new_i_size ?: i_size_read(&inode->vfs_inode);
 	if (btrfs_fs_incompat(fs_info, NO_HOLES)) {
 		inode->disk_i_size = i_size;
-		return;
+		goto out_unlock;
 	}
 
-	spin_lock(&inode->lock);
 	ret = find_contiguous_extent_bit(&inode->file_extent_tree, 0, &start,
 					 &end, EXTENT_DIRTY);
 	if (!ret && start == 0)
@@ -66,6 +66,7 @@ void btrfs_inode_safe_disk_i_size_write(struct btrfs_inode *inode, u64 new_i_siz
 	else
 		i_size = 0;
 	inode->disk_i_size = i_size;
+out_unlock:
 	spin_unlock(&inode->lock);
 }
 
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index d84cef89cdff..cf98a3c05480 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -870,15 +870,16 @@ static int __load_free_space_cache(struct btrfs_root *root, struct inode *inode,
 			}
 			spin_lock(&ctl->tree_lock);
 			ret = link_free_space(ctl, e);
-			ctl->total_bitmaps++;
-			recalculate_thresholds(ctl);
-			spin_unlock(&ctl->tree_lock);
 			if (ret) {
+				spin_unlock(&ctl->tree_lock);
 				btrfs_err(fs_info,
 					"Duplicate entries in free space cache, dumping");
 				kmem_cache_free(btrfs_free_space_cachep, e);
 				goto free_cache;
 			}
+			ctl->total_bitmaps++;
+			recalculate_thresholds(ctl);
+			spin_unlock(&ctl->tree_lock);
 			list_add_tail(&e->list, &bitmaps);
 		}
 
diff --git a/fs/btrfs/free-space-tree.c b/fs/btrfs/free-space-tree.c
index c667e878ef1a..3b623dce3379 100644
--- a/fs/btrfs/free-space-tree.c
+++ b/fs/btrfs/free-space-tree.c
@@ -1252,7 +1252,7 @@ static int clear_free_space_tree(struct btrfs_trans_handle *trans,
 	return ret;
 }
 
-int btrfs_clear_free_space_tree(struct btrfs_fs_info *fs_info)
+int btrfs_delete_free_space_tree(struct btrfs_fs_info *fs_info)
 {
 	struct btrfs_trans_handle *trans;
 	struct btrfs_root *tree_root = fs_info->tree_root;
@@ -1298,6 +1298,54 @@ int btrfs_clear_free_space_tree(struct btrfs_fs_info *fs_info)
 	return ret;
 }
 
+int btrfs_rebuild_free_space_tree(struct btrfs_fs_info *fs_info)
+{
+	struct btrfs_trans_handle *trans;
+	struct btrfs_key key = {
+		.objectid = BTRFS_FREE_SPACE_TREE_OBJECTID,
+		.type = BTRFS_ROOT_ITEM_KEY,
+		.offset = 0,
+	};
+	struct btrfs_root *free_space_root = btrfs_global_root(fs_info, &key);
+	struct rb_node *node;
+	int ret;
+
+	trans = btrfs_start_transaction(free_space_root, 1);
+	if (IS_ERR(trans))
+		return PTR_ERR(trans);
+
+	set_bit(BTRFS_FS_CREATING_FREE_SPACE_TREE, &fs_info->flags);
+	set_bit(BTRFS_FS_FREE_SPACE_TREE_UNTRUSTED, &fs_info->flags);
+
+	ret = clear_free_space_tree(trans, free_space_root);
+	if (ret)
+		goto abort;
+
+	node = rb_first_cached(&fs_info->block_group_cache_tree);
+	while (node) {
+		struct btrfs_block_group *block_group;
+
+		block_group = rb_entry(node, struct btrfs_block_group,
+				       cache_node);
+		ret = populate_free_space_tree(trans, block_group);
+		if (ret)
+			goto abort;
+		node = rb_next(node);
+	}
+
+	btrfs_set_fs_compat_ro(fs_info, FREE_SPACE_TREE);
+	btrfs_set_fs_compat_ro(fs_info, FREE_SPACE_TREE_VALID);
+	clear_bit(BTRFS_FS_CREATING_FREE_SPACE_TREE, &fs_info->flags);
+
+	ret = btrfs_commit_transaction(trans);
+	clear_bit(BTRFS_FS_FREE_SPACE_TREE_UNTRUSTED, &fs_info->flags);
+	return ret;
+abort:
+	btrfs_abort_transaction(trans, ret);
+	btrfs_end_transaction(trans);
+	return ret;
+}
+
 static int __add_block_group_free_space(struct btrfs_trans_handle *trans,
 					struct btrfs_block_group *block_group,
 					struct btrfs_path *path)
diff --git a/fs/btrfs/free-space-tree.h b/fs/btrfs/free-space-tree.h
index dc2463e4cfe3..6d5551d0ced8 100644
--- a/fs/btrfs/free-space-tree.h
+++ b/fs/btrfs/free-space-tree.h
@@ -18,7 +18,8 @@ struct btrfs_caching_control;
 
 void set_free_space_tree_thresholds(struct btrfs_block_group *block_group);
 int btrfs_create_free_space_tree(struct btrfs_fs_info *fs_info);
-int btrfs_clear_free_space_tree(struct btrfs_fs_info *fs_info);
+int btrfs_delete_free_space_tree(struct btrfs_fs_info *fs_info);
+int btrfs_rebuild_free_space_tree(struct btrfs_fs_info *fs_info);
 int load_free_space_tree(struct btrfs_caching_control *caching_ctl);
 int add_block_group_free_space(struct btrfs_trans_handle *trans,
 			       struct btrfs_block_group *block_group);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 98a800b8bd43..21ed4e3dd690 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3264,6 +3264,9 @@ int btrfs_finish_ordered_io(struct btrfs_ordered_extent *ordered_extent)
 		btrfs_rewrite_logical_zoned(ordered_extent);
 		btrfs_zone_finish_endio(fs_info, ordered_extent->disk_bytenr,
 					ordered_extent->disk_num_bytes);
+	} else if (btrfs_is_data_reloc_root(inode->root)) {
+		btrfs_zone_finish_endio(fs_info, ordered_extent->disk_bytenr,
+					ordered_extent->disk_num_bytes);
 	}
 
 	btrfs_free_io_failure_record(inode, start, end);
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index bff2d1fd3c81..8a045166a265 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -454,7 +454,9 @@ void btrfs_exclop_balance(struct btrfs_fs_info *fs_info,
 	case BTRFS_EXCLOP_BALANCE_PAUSED:
 		spin_lock(&fs_info->super_lock);
 		ASSERT(fs_info->exclusive_operation == BTRFS_EXCLOP_BALANCE ||
-		       fs_info->exclusive_operation == BTRFS_EXCLOP_DEV_ADD);
+		       fs_info->exclusive_operation == BTRFS_EXCLOP_DEV_ADD ||
+		       fs_info->exclusive_operation == BTRFS_EXCLOP_NONE ||
+		       fs_info->exclusive_operation == BTRFS_EXCLOP_BALANCE_PAUSED);
 		fs_info->exclusive_operation = BTRFS_EXCLOP_BALANCE_PAUSED;
 		spin_unlock(&fs_info->super_lock);
 		break;
diff --git a/fs/btrfs/print-tree.c b/fs/btrfs/print-tree.c
index b93c96213304..497b9dbd8a13 100644
--- a/fs/btrfs/print-tree.c
+++ b/fs/btrfs/print-tree.c
@@ -151,10 +151,10 @@ static void print_extent_item(struct extent_buffer *eb, int slot, int type)
 			pr_cont("shared data backref parent %llu count %u\n",
 			       offset, btrfs_shared_data_ref_count(eb, sref));
 			/*
-			 * offset is supposed to be a tree block which
-			 * must be aligned to nodesize.
+			 * Offset is supposed to be a tree block which must be
+			 * aligned to sectorsize.
 			 */
-			if (!IS_ALIGNED(offset, eb->fs_info->nodesize))
+			if (!IS_ALIGNED(offset, eb->fs_info->sectorsize))
 				pr_info(
 			"\t\t\t(parent %llu not aligned to sectorsize %u)\n",
 				     offset, eb->fs_info->sectorsize);
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 31ec4a7658ce..4f96a4825795 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -3422,7 +3422,7 @@ int add_data_references(struct reloc_control *rc,
 	btrfs_release_path(path);
 
 	ctx.bytenr = extent_key->objectid;
-	ctx.ignore_extent_item_pos = true;
+	ctx.skip_inode_ref_list = true;
 	ctx.fs_info = rc->extent_root->fs_info;
 
 	ret = btrfs_find_all_leafs(&ctx);
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 3f3c8f9186f9..21322be95c0d 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -825,7 +825,11 @@ int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
 	    !btrfs_test_opt(info, CLEAR_CACHE)) {
 		btrfs_err(info, "cannot disable free space tree");
 		ret = -EINVAL;
-
+	}
+	if (btrfs_fs_compat_ro(info, BLOCK_GROUP_TREE) &&
+	     !btrfs_test_opt(info, FREE_SPACE_TREE)) {
+		btrfs_err(info, "cannot disable free space tree with block-group-tree feature");
+		ret = -EINVAL;
 	}
 	if (!ret)
 		ret = btrfs_check_mountopts_zoned(info);
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index ce5ebba7fdd9..250c4755ec12 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -121,10 +121,9 @@ static int sb_write_pointer(struct block_device *bdev, struct blk_zone *zones,
 		int i;
 
 		for (i = 0; i < BTRFS_NR_SB_LOG_ZONES; i++) {
-			u64 bytenr;
-
-			bytenr = ((zones[i].start + zones[i].len)
-				   << SECTOR_SHIFT) - BTRFS_SUPER_INFO_SIZE;
+			u64 zone_end = (zones[i].start + zones[i].capacity) << SECTOR_SHIFT;
+			u64 bytenr = ALIGN_DOWN(zone_end, BTRFS_SUPER_INFO_SIZE) -
+						BTRFS_SUPER_INFO_SIZE;
 
 			page[i] = read_cache_page_gfp(mapping,
 					bytenr >> PAGE_SHIFT, GFP_NOFS);
@@ -1164,12 +1163,12 @@ int btrfs_ensure_empty_zones(struct btrfs_device *device, u64 start, u64 size)
 		return -ERANGE;
 
 	/* All the zones are conventional */
-	if (find_next_bit(zinfo->seq_zones, begin, end) == end)
+	if (find_next_bit(zinfo->seq_zones, end, begin) == end)
 		return 0;
 
 	/* All the zones are sequential and empty */
-	if (find_next_zero_bit(zinfo->seq_zones, begin, end) == end &&
-	    find_next_zero_bit(zinfo->empty_zones, begin, end) == end)
+	if (find_next_zero_bit(zinfo->seq_zones, end, begin) == end &&
+	    find_next_zero_bit(zinfo->empty_zones, end, begin) == end)
 		return 0;
 
 	for (pos = start; pos < start + size; pos += zinfo->zone_size) {
@@ -1606,11 +1605,11 @@ void btrfs_redirty_list_add(struct btrfs_transaction *trans,
 	    !list_empty(&eb->release_list))
 		return;
 
+	memzero_extent_buffer(eb, 0, eb->len);
+	set_bit(EXTENT_BUFFER_NO_CHECK, &eb->bflags);
 	set_extent_buffer_dirty(eb);
 	set_extent_bits_nowait(&trans->dirty_pages, eb->start,
 			       eb->start + eb->len - 1, EXTENT_DIRTY);
-	memzero_extent_buffer(eb, 0, eb->len);
-	set_bit(EXTENT_BUFFER_NO_CHECK, &eb->bflags);
 
 	spin_lock(&trans->releasing_ebs_lock);
 	list_add_tail(&eb->release_list, &trans->releasing_ebs);
diff --git a/fs/cifs/cifsfs.c b/fs/cifs/cifsfs.c
index 8485d380cddf..2b2dd769c3bc 100644
--- a/fs/cifs/cifsfs.c
+++ b/fs/cifs/cifsfs.c
@@ -743,6 +743,7 @@ static void cifs_umount_begin(struct super_block *sb)
 	spin_unlock(&tcon->tc_lock);
 	spin_unlock(&cifs_tcp_ses_lock);
 
+	cifs_close_all_deferred_files(tcon);
 	/* cancel_brl_requests(tcon); */ /* BB mark all brl mids as exiting */
 	/* cancel_notify_requests(tcon); */
 	if (tcon->ses && tcon->ses->server) {
@@ -758,6 +759,20 @@ static void cifs_umount_begin(struct super_block *sb)
 	return;
 }
 
+static int cifs_freeze(struct super_block *sb)
+{
+	struct cifs_sb_info *cifs_sb = CIFS_SB(sb);
+	struct cifs_tcon *tcon;
+
+	if (cifs_sb == NULL)
+		return 0;
+
+	tcon = cifs_sb_master_tcon(cifs_sb);
+
+	cifs_close_all_deferred_files(tcon);
+	return 0;
+}
+
 #ifdef CONFIG_CIFS_STATS2
 static int cifs_show_stats(struct seq_file *s, struct dentry *root)
 {
@@ -796,6 +811,7 @@ static const struct super_operations cifs_super_ops = {
 	as opens */
 	.show_options = cifs_show_options,
 	.umount_begin   = cifs_umount_begin,
+	.freeze_fs      = cifs_freeze,
 #ifdef CONFIG_CIFS_STATS2
 	.show_stats = cifs_show_stats,
 #endif
diff --git a/fs/cifs/cifsglob.h b/fs/cifs/cifsglob.h
index ea216e9d0f94..e6d12a656388 100644
--- a/fs/cifs/cifsglob.h
+++ b/fs/cifs/cifsglob.h
@@ -1244,8 +1244,8 @@ struct cifs_tcon {
 	struct cached_fids *cfids;
 	/* BB add field for back pointer to sb struct(s)? */
 #ifdef CONFIG_CIFS_DFS_UPCALL
-	struct list_head ulist; /* cache update list */
 	struct list_head dfs_ses_list;
+	struct delayed_work dfs_cache_work;
 #endif
 	struct delayed_work	query_interfaces; /* query interfaces workqueue job */
 };
diff --git a/fs/cifs/connect.c b/fs/cifs/connect.c
index 87527512c266..33fa18280e92 100644
--- a/fs/cifs/connect.c
+++ b/fs/cifs/connect.c
@@ -2386,6 +2386,9 @@ cifs_put_tcon(struct cifs_tcon *tcon)
 
 	/* cancel polling of interfaces */
 	cancel_delayed_work_sync(&tcon->query_interfaces);
+#ifdef CONFIG_CIFS_DFS_UPCALL
+	cancel_delayed_work_sync(&tcon->dfs_cache_work);
+#endif
 
 	if (tcon->use_witness) {
 		int rc;
@@ -2633,7 +2636,9 @@ cifs_get_tcon(struct cifs_ses *ses, struct smb3_fs_context *ctx)
 		queue_delayed_work(cifsiod_wq, &tcon->query_interfaces,
 				   (SMB_INTERFACE_POLL_INTERVAL * HZ));
 	}
-
+#ifdef CONFIG_CIFS_DFS_UPCALL
+	INIT_DELAYED_WORK(&tcon->dfs_cache_work, dfs_cache_refresh);
+#endif
 	spin_lock(&cifs_tcp_ses_lock);
 	list_add(&tcon->tcon_list, &ses->tcon_list);
 	spin_unlock(&cifs_tcp_ses_lock);
@@ -2749,6 +2754,13 @@ cifs_match_super(struct super_block *sb, void *data)
 
 	spin_lock(&cifs_tcp_ses_lock);
 	cifs_sb = CIFS_SB(sb);
+
+	/* We do not want to use a superblock that has been shutdown */
+	if (CIFS_MOUNT_SHUTDOWN & cifs_sb->mnt_cifs_flags) {
+		spin_unlock(&cifs_tcp_ses_lock);
+		return 0;
+	}
+
 	tlink = cifs_get_tlink(cifs_sb_master_tlink(cifs_sb));
 	if (tlink == NULL) {
 		/* can not match superblock if tlink were ever null */
@@ -4119,9 +4131,13 @@ int cifs_tree_connect(const unsigned int xid, struct cifs_tcon *tcon, const stru
 
 	/* only send once per connect */
 	spin_lock(&tcon->tc_lock);
-	if (tcon->ses->ses_status != SES_GOOD ||
-	    (tcon->status != TID_NEW &&
-	    tcon->status != TID_NEED_TCON)) {
+	if (tcon->status != TID_NEW &&
+	    tcon->status != TID_NEED_TCON) {
+		spin_unlock(&tcon->tc_lock);
+		return -EHOSTDOWN;
+	}
+
+	if (tcon->status == TID_GOOD) {
 		spin_unlock(&tcon->tc_lock);
 		return 0;
 	}
diff --git a/fs/cifs/dfs.c b/fs/cifs/dfs.c
index 4c392bde2406..a93dbca1411b 100644
--- a/fs/cifs/dfs.c
+++ b/fs/cifs/dfs.c
@@ -157,6 +157,8 @@ static int get_dfs_conn(struct cifs_mount_ctx *mnt_ctx, const char *ref_path, co
 		rc = cifs_is_path_remote(mnt_ctx);
 	}
 
+	dfs_cache_noreq_update_tgthint(ref_path + 1, tit);
+
 	if (rc == -EREMOTE && is_refsrv) {
 		rc2 = add_root_smb_session(mnt_ctx);
 		if (rc2)
@@ -259,6 +261,8 @@ static int __dfs_mount_share(struct cifs_mount_ctx *mnt_ctx)
 		if (list_empty(&tcon->dfs_ses_list)) {
 			list_replace_init(&mnt_ctx->dfs_ses_list,
 					  &tcon->dfs_ses_list);
+			queue_delayed_work(dfscache_wq, &tcon->dfs_cache_work,
+					   dfs_cache_get_ttl() * HZ);
 		} else {
 			dfs_put_root_smb_sessions(&mnt_ctx->dfs_ses_list);
 		}
@@ -571,9 +575,13 @@ int cifs_tree_connect(const unsigned int xid, struct cifs_tcon *tcon, const stru
 
 	/* only send once per connect */
 	spin_lock(&tcon->tc_lock);
-	if (tcon->ses->ses_status != SES_GOOD ||
-	    (tcon->status != TID_NEW &&
-	    tcon->status != TID_NEED_TCON)) {
+	if (tcon->status != TID_NEW &&
+	    tcon->status != TID_NEED_TCON) {
+		spin_unlock(&tcon->tc_lock);
+		return -EHOSTDOWN;
+	}
+
+	if (tcon->status == TID_GOOD) {
 		spin_unlock(&tcon->tc_lock);
 		return 0;
 	}
diff --git a/fs/cifs/dfs_cache.c b/fs/cifs/dfs_cache.c
index 9ccaa0c7ac94..1513b2709889 100644
--- a/fs/cifs/dfs_cache.c
+++ b/fs/cifs/dfs_cache.c
@@ -20,12 +20,14 @@
 #include "cifs_unicode.h"
 #include "smb2glob.h"
 #include "dns_resolve.h"
+#include "dfs.h"
 
 #include "dfs_cache.h"
 
-#define CACHE_HTABLE_SIZE 32
-#define CACHE_MAX_ENTRIES 64
-#define CACHE_MIN_TTL 120 /* 2 minutes */
+#define CACHE_HTABLE_SIZE	32
+#define CACHE_MAX_ENTRIES	64
+#define CACHE_MIN_TTL		120 /* 2 minutes */
+#define CACHE_DEFAULT_TTL	300 /* 5 minutes */
 
 #define IS_DFS_INTERLINK(v) (((v) & DFSREF_REFERRAL_SERVER) && !((v) & DFSREF_STORAGE_SERVER))
 
@@ -50,10 +52,9 @@ struct cache_entry {
 };
 
 static struct kmem_cache *cache_slab __read_mostly;
-static struct workqueue_struct *dfscache_wq __read_mostly;
+struct workqueue_struct *dfscache_wq;
 
-static int cache_ttl;
-static DEFINE_SPINLOCK(cache_ttl_lock);
+atomic_t dfs_cache_ttl;
 
 static struct nls_table *cache_cp;
 
@@ -65,10 +66,6 @@ static atomic_t cache_count;
 static struct hlist_head cache_htable[CACHE_HTABLE_SIZE];
 static DECLARE_RWSEM(htable_rw_lock);
 
-static void refresh_cache_worker(struct work_struct *work);
-
-static DECLARE_DELAYED_WORK(refresh_task, refresh_cache_worker);
-
 /**
  * dfs_cache_canonical_path - get a canonical DFS path
  *
@@ -290,7 +287,9 @@ int dfs_cache_init(void)
 	int rc;
 	int i;
 
-	dfscache_wq = alloc_workqueue("cifs-dfscache", WQ_FREEZABLE | WQ_UNBOUND, 1);
+	dfscache_wq = alloc_workqueue("cifs-dfscache",
+				      WQ_UNBOUND|WQ_FREEZABLE|WQ_MEM_RECLAIM,
+				      0);
 	if (!dfscache_wq)
 		return -ENOMEM;
 
@@ -306,6 +305,7 @@ int dfs_cache_init(void)
 		INIT_HLIST_HEAD(&cache_htable[i]);
 
 	atomic_set(&cache_count, 0);
+	atomic_set(&dfs_cache_ttl, CACHE_DEFAULT_TTL);
 	cache_cp = load_nls("utf8");
 	if (!cache_cp)
 		cache_cp = load_nls_default();
@@ -480,6 +480,7 @@ static struct cache_entry *add_cache_entry_locked(struct dfs_info3_param *refs,
 	int rc;
 	struct cache_entry *ce;
 	unsigned int hash;
+	int ttl;
 
 	WARN_ON(!rwsem_is_locked(&htable_rw_lock));
 
@@ -496,15 +497,8 @@ static struct cache_entry *add_cache_entry_locked(struct dfs_info3_param *refs,
 	if (IS_ERR(ce))
 		return ce;
 
-	spin_lock(&cache_ttl_lock);
-	if (!cache_ttl) {
-		cache_ttl = ce->ttl;
-		queue_delayed_work(dfscache_wq, &refresh_task, cache_ttl * HZ);
-	} else {
-		cache_ttl = min_t(int, cache_ttl, ce->ttl);
-		mod_delayed_work(dfscache_wq, &refresh_task, cache_ttl * HZ);
-	}
-	spin_unlock(&cache_ttl_lock);
+	ttl = min_t(int, atomic_read(&dfs_cache_ttl), ce->ttl);
+	atomic_set(&dfs_cache_ttl, ttl);
 
 	hlist_add_head(&ce->hlist, &cache_htable[hash]);
 	dump_ce(ce);
@@ -616,7 +610,6 @@ static struct cache_entry *lookup_cache_entry(const char *path)
  */
 void dfs_cache_destroy(void)
 {
-	cancel_delayed_work_sync(&refresh_task);
 	unload_nls(cache_cp);
 	flush_cache_ents();
 	kmem_cache_destroy(cache_slab);
@@ -1142,6 +1135,7 @@ static bool target_share_equal(struct TCP_Server_Info *server, const char *s1, c
  * target shares in @refs.
  */
 static void mark_for_reconnect_if_needed(struct TCP_Server_Info *server,
+					 const char *path,
 					 struct dfs_cache_tgt_list *old_tl,
 					 struct dfs_cache_tgt_list *new_tl)
 {
@@ -1153,8 +1147,10 @@ static void mark_for_reconnect_if_needed(struct TCP_Server_Info *server,
 		     nit = dfs_cache_get_next_tgt(new_tl, nit)) {
 			if (target_share_equal(server,
 					       dfs_cache_get_tgt_name(oit),
-					       dfs_cache_get_tgt_name(nit)))
+					       dfs_cache_get_tgt_name(nit))) {
+				dfs_cache_noreq_update_tgthint(path, nit);
 				return;
+			}
 		}
 	}
 
@@ -1162,13 +1158,28 @@ static void mark_for_reconnect_if_needed(struct TCP_Server_Info *server,
 	cifs_signal_cifsd_for_reconnect(server, true);
 }
 
+static bool is_ses_good(struct cifs_ses *ses)
+{
+	struct TCP_Server_Info *server = ses->server;
+	struct cifs_tcon *tcon = ses->tcon_ipc;
+	bool ret;
+
+	spin_lock(&ses->ses_lock);
+	spin_lock(&ses->chan_lock);
+	ret = !cifs_chan_needs_reconnect(ses, server) &&
+		ses->ses_status == SES_GOOD &&
+		!tcon->need_reconnect;
+	spin_unlock(&ses->chan_lock);
+	spin_unlock(&ses->ses_lock);
+	return ret;
+}
+
 /* Refresh dfs referral of tcon and mark it for reconnect if needed */
-static int __refresh_tcon(const char *path, struct cifs_tcon *tcon, bool force_refresh)
+static int __refresh_tcon(const char *path, struct cifs_ses *ses, bool force_refresh)
 {
 	struct dfs_cache_tgt_list old_tl = DFS_CACHE_TGT_LIST_INIT(old_tl);
 	struct dfs_cache_tgt_list new_tl = DFS_CACHE_TGT_LIST_INIT(new_tl);
-	struct cifs_ses *ses = CIFS_DFS_ROOT_SES(tcon->ses);
-	struct cifs_tcon *ipc = ses->tcon_ipc;
+	struct TCP_Server_Info *server = ses->server;
 	bool needs_refresh = false;
 	struct cache_entry *ce;
 	unsigned int xid;
@@ -1190,20 +1201,19 @@ static int __refresh_tcon(const char *path, struct cifs_tcon *tcon, bool force_r
 		goto out;
 	}
 
-	spin_lock(&ipc->tc_lock);
-	if (ses->ses_status != SES_GOOD || ipc->status != TID_GOOD) {
-		spin_unlock(&ipc->tc_lock);
-		cifs_dbg(FYI, "%s: skip cache refresh due to disconnected ipc\n", __func__);
+	ses = CIFS_DFS_ROOT_SES(ses);
+	if (!is_ses_good(ses)) {
+		cifs_dbg(FYI, "%s: skip cache refresh due to disconnected ipc\n",
+			 __func__);
 		goto out;
 	}
-	spin_unlock(&ipc->tc_lock);
 
 	ce = cache_refresh_path(xid, ses, path, true);
 	if (!IS_ERR(ce)) {
 		rc = get_targets(ce, &new_tl);
 		up_read(&htable_rw_lock);
 		cifs_dbg(FYI, "%s: get_targets: %d\n", __func__, rc);
-		mark_for_reconnect_if_needed(tcon->ses->server, &old_tl, &new_tl);
+		mark_for_reconnect_if_needed(server, path, &old_tl, &new_tl);
 	}
 
 out:
@@ -1216,10 +1226,11 @@ static int __refresh_tcon(const char *path, struct cifs_tcon *tcon, bool force_r
 static int refresh_tcon(struct cifs_tcon *tcon, bool force_refresh)
 {
 	struct TCP_Server_Info *server = tcon->ses->server;
+	struct cifs_ses *ses = tcon->ses;
 
 	mutex_lock(&server->refpath_lock);
 	if (server->leaf_fullpath)
-		__refresh_tcon(server->leaf_fullpath + 1, tcon, force_refresh);
+		__refresh_tcon(server->leaf_fullpath + 1, ses, force_refresh);
 	mutex_unlock(&server->refpath_lock);
 	return 0;
 }
@@ -1263,60 +1274,32 @@ int dfs_cache_remount_fs(struct cifs_sb_info *cifs_sb)
 	return refresh_tcon(tcon, true);
 }
 
-/*
- * Worker that will refresh DFS cache from all active mounts based on lowest TTL value
- * from a DFS referral.
- */
-static void refresh_cache_worker(struct work_struct *work)
+/* Refresh all DFS referrals related to DFS tcon */
+void dfs_cache_refresh(struct work_struct *work)
 {
 	struct TCP_Server_Info *server;
-	struct cifs_tcon *tcon, *ntcon;
-	struct list_head tcons;
+	struct dfs_root_ses *rses;
+	struct cifs_tcon *tcon;
 	struct cifs_ses *ses;
 
-	INIT_LIST_HEAD(&tcons);
+	tcon = container_of(work, struct cifs_tcon, dfs_cache_work.work);
+	ses = tcon->ses;
+	server = ses->server;
 
-	spin_lock(&cifs_tcp_ses_lock);
-	list_for_each_entry(server, &cifs_tcp_ses_list, tcp_ses_list) {
-		spin_lock(&server->srv_lock);
-		if (!server->leaf_fullpath) {
-			spin_unlock(&server->srv_lock);
-			continue;
-		}
-		spin_unlock(&server->srv_lock);
-
-		list_for_each_entry(ses, &server->smb_ses_list, smb_ses_list) {
-			if (ses->tcon_ipc) {
-				ses->ses_count++;
-				list_add_tail(&ses->tcon_ipc->ulist, &tcons);
-			}
-			list_for_each_entry(tcon, &ses->tcon_list, tcon_list) {
-				if (!tcon->ipc) {
-					tcon->tc_count++;
-					list_add_tail(&tcon->ulist, &tcons);
-				}
-			}
-		}
-	}
-	spin_unlock(&cifs_tcp_ses_lock);
-
-	list_for_each_entry_safe(tcon, ntcon, &tcons, ulist) {
-		struct TCP_Server_Info *server = tcon->ses->server;
-
-		list_del_init(&tcon->ulist);
+	mutex_lock(&server->refpath_lock);
+	if (server->leaf_fullpath)
+		__refresh_tcon(server->leaf_fullpath + 1, ses, false);
+	mutex_unlock(&server->refpath_lock);
 
+	list_for_each_entry(rses, &tcon->dfs_ses_list, list) {
+		ses = rses->ses;
+		server = ses->server;
 		mutex_lock(&server->refpath_lock);
 		if (server->leaf_fullpath)
-			__refresh_tcon(server->leaf_fullpath + 1, tcon, false);
+			__refresh_tcon(server->leaf_fullpath + 1, ses, false);
 		mutex_unlock(&server->refpath_lock);
-
-		if (tcon->ipc)
-			cifs_put_smb_ses(tcon->ses);
-		else
-			cifs_put_tcon(tcon);
 	}
 
-	spin_lock(&cache_ttl_lock);
-	queue_delayed_work(dfscache_wq, &refresh_task, cache_ttl * HZ);
-	spin_unlock(&cache_ttl_lock);
+	queue_delayed_work(dfscache_wq, &tcon->dfs_cache_work,
+			   atomic_read(&dfs_cache_ttl) * HZ);
 }
diff --git a/fs/cifs/dfs_cache.h b/fs/cifs/dfs_cache.h
index e0d39393035a..c6d89cd6d4fd 100644
--- a/fs/cifs/dfs_cache.h
+++ b/fs/cifs/dfs_cache.h
@@ -13,6 +13,9 @@
 #include <linux/uuid.h>
 #include "cifsglob.h"
 
+extern struct workqueue_struct *dfscache_wq;
+extern atomic_t dfs_cache_ttl;
+
 #define DFS_CACHE_TGT_LIST_INIT(var) { .tl_numtgts = 0, .tl_list = LIST_HEAD_INIT((var).tl_list), }
 
 struct dfs_cache_tgt_list {
@@ -42,6 +45,7 @@ int dfs_cache_get_tgt_share(char *path, const struct dfs_cache_tgt_iterator *it,
 			    char **prefix);
 char *dfs_cache_canonical_path(const char *path, const struct nls_table *cp, int remap);
 int dfs_cache_remount_fs(struct cifs_sb_info *cifs_sb);
+void dfs_cache_refresh(struct work_struct *work);
 
 static inline struct dfs_cache_tgt_iterator *
 dfs_cache_get_next_tgt(struct dfs_cache_tgt_list *tl,
@@ -89,4 +93,9 @@ dfs_cache_get_nr_tgts(const struct dfs_cache_tgt_list *tl)
 	return tl ? tl->tl_numtgts : 0;
 }
 
+static inline int dfs_cache_get_ttl(void)
+{
+	return atomic_read(&dfs_cache_ttl);
+}
+
 #endif /* _CIFS_DFS_CACHE_H */
diff --git a/fs/cifs/file.c b/fs/cifs/file.c
index bef7c335ccc6..d037366fcc5e 100644
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -48,13 +48,13 @@ cifs_mark_open_files_invalid(struct cifs_tcon *tcon)
 	struct list_head *tmp1;
 
 	/* only send once per connect */
-	spin_lock(&tcon->ses->ses_lock);
-	if ((tcon->ses->ses_status != SES_GOOD) || (tcon->status != TID_NEED_RECON)) {
-		spin_unlock(&tcon->ses->ses_lock);
+	spin_lock(&tcon->tc_lock);
+	if (tcon->status != TID_NEED_RECON) {
+		spin_unlock(&tcon->tc_lock);
 		return;
 	}
 	tcon->status = TID_IN_FILES_INVALIDATE;
-	spin_unlock(&tcon->ses->ses_lock);
+	spin_unlock(&tcon->tc_lock);
 
 	/* list all files open on tree connection and mark them invalid */
 	spin_lock(&tcon->open_file_lock);
diff --git a/fs/cifs/smb2ops.c b/fs/cifs/smb2ops.c
index 502b6915ccc4..d6d6d04fbcbe 100644
--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -1682,7 +1682,7 @@ smb2_copychunk_range(const unsigned int xid,
 		pcchunk->SourceOffset = cpu_to_le64(src_off);
 		pcchunk->TargetOffset = cpu_to_le64(dest_off);
 		pcchunk->Length =
-			cpu_to_le32(min_t(u32, len, tcon->max_bytes_chunk));
+			cpu_to_le32(min_t(u64, len, tcon->max_bytes_chunk));
 
 		/* Request server copy to target from src identified by key */
 		kfree(retbuf);
diff --git a/fs/ext4/balloc.c b/fs/ext4/balloc.c
index 8ff4b9192a9f..f2c415f31b75 100644
--- a/fs/ext4/balloc.c
+++ b/fs/ext4/balloc.c
@@ -303,6 +303,22 @@ struct ext4_group_desc * ext4_get_group_desc(struct super_block *sb,
 	return desc;
 }
 
+static ext4_fsblk_t ext4_valid_block_bitmap_padding(struct super_block *sb,
+						    ext4_group_t block_group,
+						    struct buffer_head *bh)
+{
+	ext4_grpblk_t next_zero_bit;
+	unsigned long bitmap_size = sb->s_blocksize * 8;
+	unsigned int offset = num_clusters_in_group(sb, block_group);
+
+	if (bitmap_size <= offset)
+		return 0;
+
+	next_zero_bit = ext4_find_next_zero_bit(bh->b_data, bitmap_size, offset);
+
+	return (next_zero_bit < bitmap_size ? next_zero_bit : 0);
+}
+
 /*
  * Return the block number which was discovered to be invalid, or 0 if
  * the block bitmap is valid.
@@ -401,6 +417,15 @@ static int ext4_validate_block_bitmap(struct super_block *sb,
 					EXT4_GROUP_INFO_BBITMAP_CORRUPT);
 		return -EFSCORRUPTED;
 	}
+	blk = ext4_valid_block_bitmap_padding(sb, block_group, bh);
+	if (unlikely(blk != 0)) {
+		ext4_unlock_group(sb, block_group);
+		ext4_error(sb, "bg %u: block %llu: padding at end of block bitmap is not set",
+			   block_group, blk);
+		ext4_mark_group_bitmap_corrupted(sb, block_group,
+						 EXT4_GROUP_INFO_BBITMAP_CORRUPT);
+		return -EFSCORRUPTED;
+	}
 	set_buffer_verified(bh);
 verified:
 	ext4_unlock_group(sb, block_group);
diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 6479146140d2..a3f0c79568a6 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1774,6 +1774,30 @@ static inline struct ext4_inode_info *EXT4_I(struct inode *inode)
 	return container_of(inode, struct ext4_inode_info, vfs_inode);
 }
 
+static inline int ext4_writepages_down_read(struct super_block *sb)
+{
+	percpu_down_read(&EXT4_SB(sb)->s_writepages_rwsem);
+	return memalloc_nofs_save();
+}
+
+static inline void ext4_writepages_up_read(struct super_block *sb, int ctx)
+{
+	memalloc_nofs_restore(ctx);
+	percpu_up_read(&EXT4_SB(sb)->s_writepages_rwsem);
+}
+
+static inline int ext4_writepages_down_write(struct super_block *sb)
+{
+	percpu_down_write(&EXT4_SB(sb)->s_writepages_rwsem);
+	return memalloc_nofs_save();
+}
+
+static inline void ext4_writepages_up_write(struct super_block *sb, int ctx)
+{
+	memalloc_nofs_restore(ctx);
+	percpu_up_write(&EXT4_SB(sb)->s_writepages_rwsem);
+}
+
 static inline int ext4_valid_inum(struct super_block *sb, unsigned long ino)
 {
 	return ino == EXT4_ROOT_INO ||
diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
index 7bc221038c6c..595abb9e7d74 100644
--- a/fs/ext4/extents_status.c
+++ b/fs/ext4/extents_status.c
@@ -267,14 +267,12 @@ static void __es_find_extent_range(struct inode *inode,
 
 	/* see if the extent has been cached */
 	es->es_lblk = es->es_len = es->es_pblk = 0;
-	if (tree->cache_es) {
-		es1 = tree->cache_es;
-		if (in_range(lblk, es1->es_lblk, es1->es_len)) {
-			es_debug("%u cached by [%u/%u) %llu %x\n",
-				 lblk, es1->es_lblk, es1->es_len,
-				 ext4_es_pblock(es1), ext4_es_status(es1));
-			goto out;
-		}
+	es1 = READ_ONCE(tree->cache_es);
+	if (es1 && in_range(lblk, es1->es_lblk, es1->es_len)) {
+		es_debug("%u cached by [%u/%u) %llu %x\n",
+			 lblk, es1->es_lblk, es1->es_len,
+			 ext4_es_pblock(es1), ext4_es_status(es1));
+		goto out;
 	}
 
 	es1 = __es_tree_search(&tree->root, lblk);
@@ -293,7 +291,7 @@ static void __es_find_extent_range(struct inode *inode,
 	}
 
 	if (es1 && matching_fn(es1)) {
-		tree->cache_es = es1;
+		WRITE_ONCE(tree->cache_es, es1);
 		es->es_lblk = es1->es_lblk;
 		es->es_len = es1->es_len;
 		es->es_pblk = es1->es_pblk;
@@ -931,14 +929,12 @@ int ext4_es_lookup_extent(struct inode *inode, ext4_lblk_t lblk,
 
 	/* find extent in cache firstly */
 	es->es_lblk = es->es_len = es->es_pblk = 0;
-	if (tree->cache_es) {
-		es1 = tree->cache_es;
-		if (in_range(lblk, es1->es_lblk, es1->es_len)) {
-			es_debug("%u cached by [%u/%u)\n",
-				 lblk, es1->es_lblk, es1->es_len);
-			found = 1;
-			goto out;
-		}
+	es1 = READ_ONCE(tree->cache_es);
+	if (es1 && in_range(lblk, es1->es_lblk, es1->es_len)) {
+		es_debug("%u cached by [%u/%u)\n",
+			 lblk, es1->es_lblk, es1->es_len);
+		found = 1;
+		goto out;
 	}
 
 	node = tree->root.rb_node;
diff --git a/fs/ext4/hash.c b/fs/ext4/hash.c
index 147b5241dd94..46c3423ddfa1 100644
--- a/fs/ext4/hash.c
+++ b/fs/ext4/hash.c
@@ -277,7 +277,11 @@ static int __ext4fs_dirhash(const struct inode *dir, const char *name, int len,
 	}
 	default:
 		hinfo->hash = 0;
-		return -1;
+		hinfo->minor_hash = 0;
+		ext4_warning(dir->i_sb,
+			     "invalid/unsupported hash tree version %u",
+			     hinfo->hash_version);
+		return -EINVAL;
 	}
 	hash = hash & ~1;
 	if (hash == (EXT4_HTREE_EOF_32BIT << 1))
diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index 1602d74b5eeb..cb36037f20fc 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -34,6 +34,7 @@ static int get_max_inline_xattr_value_size(struct inode *inode,
 	struct ext4_xattr_ibody_header *header;
 	struct ext4_xattr_entry *entry;
 	struct ext4_inode *raw_inode;
+	void *end;
 	int free, min_offs;
 
 	if (!EXT4_INODE_HAS_XATTR_SPACE(inode))
@@ -57,14 +58,23 @@ static int get_max_inline_xattr_value_size(struct inode *inode,
 	raw_inode = ext4_raw_inode(iloc);
 	header = IHDR(inode, raw_inode);
 	entry = IFIRST(header);
+	end = (void *)raw_inode + EXT4_SB(inode->i_sb)->s_inode_size;
 
 	/* Compute min_offs. */
-	for (; !IS_LAST_ENTRY(entry); entry = EXT4_XATTR_NEXT(entry)) {
+	while (!IS_LAST_ENTRY(entry)) {
+		void *next = EXT4_XATTR_NEXT(entry);
+
+		if (next >= end) {
+			EXT4_ERROR_INODE(inode,
+					 "corrupt xattr in inline inode");
+			return 0;
+		}
 		if (!entry->e_value_inum && entry->e_value_size) {
 			size_t offs = le16_to_cpu(entry->e_value_offs);
 			if (offs < min_offs)
 				min_offs = offs;
 		}
+		entry = next;
 	}
 	free = min_offs -
 		((void *)entry - (void *)IFIRST(header)) - sizeof(__u32);
@@ -350,7 +360,7 @@ static int ext4_update_inline_data(handle_t *handle, struct inode *inode,
 
 	error = ext4_xattr_ibody_get(inode, i.name_index, i.name,
 				     value, len);
-	if (error == -ENODATA)
+	if (error < 0)
 		goto out;
 
 	BUFFER_TRACE(is.iloc.bh, "get_write_access");
@@ -1177,6 +1187,7 @@ static int ext4_finish_convert_inline_dir(handle_t *handle,
 		ext4_initialize_dirent_tail(dir_block,
 					    inode->i_sb->s_blocksize);
 	set_buffer_uptodate(dir_block);
+	unlock_buffer(dir_block);
 	err = ext4_handle_dirty_dirblock(handle, inode, dir_block);
 	if (err)
 		return err;
@@ -1251,6 +1262,7 @@ static int ext4_convert_inline_data_nolock(handle_t *handle,
 	if (!S_ISDIR(inode->i_mode)) {
 		memcpy(data_bh->b_data, buf, inline_size);
 		set_buffer_uptodate(data_bh);
+		unlock_buffer(data_bh);
 		error = ext4_handle_dirty_metadata(handle,
 						   inode, data_bh);
 	} else {
@@ -1258,7 +1270,6 @@ static int ext4_convert_inline_data_nolock(handle_t *handle,
 						       buf, inline_size);
 	}
 
-	unlock_buffer(data_bh);
 out_restore:
 	if (error)
 		ext4_restore_inline_data(handle, inode, iloc, buf, inline_size);
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 0b87665aaff1..bfbfec99b134 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -2957,13 +2957,14 @@ static int ext4_writepages(struct address_space *mapping,
 		.can_map = 1,
 	};
 	int ret;
+	int alloc_ctx;
 
 	if (unlikely(ext4_forced_shutdown(EXT4_SB(sb))))
 		return -EIO;
 
-	percpu_down_read(&EXT4_SB(sb)->s_writepages_rwsem);
+	alloc_ctx = ext4_writepages_down_read(sb);
 	ret = ext4_do_writepages(&mpd);
-	percpu_up_read(&EXT4_SB(sb)->s_writepages_rwsem);
+	ext4_writepages_up_read(sb, alloc_ctx);
 
 	return ret;
 }
@@ -2991,17 +2992,18 @@ static int ext4_dax_writepages(struct address_space *mapping,
 	long nr_to_write = wbc->nr_to_write;
 	struct inode *inode = mapping->host;
 	struct ext4_sb_info *sbi = EXT4_SB(mapping->host->i_sb);
+	int alloc_ctx;
 
 	if (unlikely(ext4_forced_shutdown(EXT4_SB(inode->i_sb))))
 		return -EIO;
 
-	percpu_down_read(&sbi->s_writepages_rwsem);
+	alloc_ctx = ext4_writepages_down_read(inode->i_sb);
 	trace_ext4_writepages(inode, wbc);
 
 	ret = dax_writeback_mapping_range(mapping, sbi->s_daxdev, wbc);
 	trace_ext4_writepages_result(inode, wbc, ret,
 				     nr_to_write - wbc->nr_to_write);
-	percpu_up_read(&sbi->s_writepages_rwsem);
+	ext4_writepages_up_read(inode->i_sb, alloc_ctx);
 	return ret;
 }
 
@@ -3575,7 +3577,7 @@ static int ext4_iomap_overwrite_begin(struct inode *inode, loff_t offset,
 	 */
 	flags &= ~IOMAP_WRITE;
 	ret = ext4_iomap_begin(inode, offset, length, flags, iomap, srcmap);
-	WARN_ON_ONCE(iomap->type != IOMAP_MAPPED);
+	WARN_ON_ONCE(!ret && iomap->type != IOMAP_MAPPED);
 	return ret;
 }
 
@@ -6124,7 +6126,7 @@ int ext4_change_inode_journal_flag(struct inode *inode, int val)
 	journal_t *journal;
 	handle_t *handle;
 	int err;
-	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
+	int alloc_ctx;
 
 	/*
 	 * We have to be very careful here: changing a data block's
@@ -6162,7 +6164,7 @@ int ext4_change_inode_journal_flag(struct inode *inode, int val)
 		}
 	}
 
-	percpu_down_write(&sbi->s_writepages_rwsem);
+	alloc_ctx = ext4_writepages_down_write(inode->i_sb);
 	jbd2_journal_lock_updates(journal);
 
 	/*
@@ -6179,7 +6181,7 @@ int ext4_change_inode_journal_flag(struct inode *inode, int val)
 		err = jbd2_journal_flush(journal, 0);
 		if (err < 0) {
 			jbd2_journal_unlock_updates(journal);
-			percpu_up_write(&sbi->s_writepages_rwsem);
+			ext4_writepages_up_write(inode->i_sb, alloc_ctx);
 			return err;
 		}
 		ext4_clear_inode_flag(inode, EXT4_INODE_JOURNAL_DATA);
@@ -6187,7 +6189,7 @@ int ext4_change_inode_journal_flag(struct inode *inode, int val)
 	ext4_set_aops(inode);
 
 	jbd2_journal_unlock_updates(journal);
-	percpu_up_write(&sbi->s_writepages_rwsem);
+	ext4_writepages_up_write(inode->i_sb, alloc_ctx);
 
 	if (val)
 		filemap_invalidate_unlock(inode->i_mapping);
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 5b2ae37a8b80..5639a4cf7ff9 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -4820,7 +4820,11 @@ ext4_mb_release_group_pa(struct ext4_buddy *e4b,
 	trace_ext4_mb_release_group_pa(sb, pa);
 	BUG_ON(pa->pa_deleted == 0);
 	ext4_get_group_no_and_offset(sb, pa->pa_pstart, &group, &bit);
-	BUG_ON(group != e4b->bd_group && pa->pa_len != 0);
+	if (unlikely(group != e4b->bd_group && pa->pa_len != 0)) {
+		ext4_warning(sb, "bad group: expected %u, group %u, pa_start %llu",
+			     e4b->bd_group, group, pa->pa_pstart);
+		return 0;
+	}
 	mb_free_blocks(pa->pa_inode, e4b, bit, pa->pa_len);
 	atomic_add(pa->pa_len, &EXT4_SB(sb)->s_mb_discarded);
 	trace_ext4_mballoc_discard(sb, NULL, group, bit, pa->pa_len);
diff --git a/fs/ext4/migrate.c b/fs/ext4/migrate.c
index a19a9661646e..d98ac2af8199 100644
--- a/fs/ext4/migrate.c
+++ b/fs/ext4/migrate.c
@@ -408,7 +408,6 @@ static int free_ext_block(handle_t *handle, struct inode *inode)
 
 int ext4_ext_migrate(struct inode *inode)
 {
-	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
 	handle_t *handle;
 	int retval = 0, i;
 	__le32 *i_data;
@@ -418,6 +417,7 @@ int ext4_ext_migrate(struct inode *inode)
 	unsigned long max_entries;
 	__u32 goal, tmp_csum_seed;
 	uid_t owner[2];
+	int alloc_ctx;
 
 	/*
 	 * If the filesystem does not support extents, or the inode
@@ -434,7 +434,7 @@ int ext4_ext_migrate(struct inode *inode)
 		 */
 		return retval;
 
-	percpu_down_write(&sbi->s_writepages_rwsem);
+	alloc_ctx = ext4_writepages_down_write(inode->i_sb);
 
 	/*
 	 * Worst case we can touch the allocation bitmaps and a block
@@ -586,7 +586,7 @@ int ext4_ext_migrate(struct inode *inode)
 	unlock_new_inode(tmp_inode);
 	iput(tmp_inode);
 out_unlock:
-	percpu_up_write(&sbi->s_writepages_rwsem);
+	ext4_writepages_up_write(inode->i_sb, alloc_ctx);
 	return retval;
 }
 
@@ -605,6 +605,7 @@ int ext4_ind_migrate(struct inode *inode)
 	ext4_fsblk_t			blk;
 	handle_t			*handle;
 	int				ret, ret2 = 0;
+	int				alloc_ctx;
 
 	if (!ext4_has_feature_extents(inode->i_sb) ||
 	    (!ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS)))
@@ -621,7 +622,7 @@ int ext4_ind_migrate(struct inode *inode)
 	if (test_opt(inode->i_sb, DELALLOC))
 		ext4_alloc_da_blocks(inode);
 
-	percpu_down_write(&sbi->s_writepages_rwsem);
+	alloc_ctx = ext4_writepages_down_write(inode->i_sb);
 
 	handle = ext4_journal_start(inode, EXT4_HT_MIGRATE, 1);
 	if (IS_ERR(handle)) {
@@ -665,6 +666,6 @@ int ext4_ind_migrate(struct inode *inode)
 	ext4_journal_stop(handle);
 	up_write(&EXT4_I(inode)->i_data_sem);
 out_unlock:
-	percpu_up_write(&sbi->s_writepages_rwsem);
+	ext4_writepages_up_write(inode->i_sb, alloc_ctx);
 	return ret;
 }
diff --git a/fs/ext4/mmp.c b/fs/ext4/mmp.c
index 4681fff6665f..46735ce315b5 100644
--- a/fs/ext4/mmp.c
+++ b/fs/ext4/mmp.c
@@ -39,28 +39,36 @@ static void ext4_mmp_csum_set(struct super_block *sb, struct mmp_struct *mmp)
  * Write the MMP block using REQ_SYNC to try to get the block on-disk
  * faster.
  */
-static int write_mmp_block(struct super_block *sb, struct buffer_head *bh)
+static int write_mmp_block_thawed(struct super_block *sb,
+				  struct buffer_head *bh)
 {
 	struct mmp_struct *mmp = (struct mmp_struct *)(bh->b_data);
 
-	/*
-	 * We protect against freezing so that we don't create dirty buffers
-	 * on frozen filesystem.
-	 */
-	sb_start_write(sb);
 	ext4_mmp_csum_set(sb, mmp);
 	lock_buffer(bh);
 	bh->b_end_io = end_buffer_write_sync;
 	get_bh(bh);
 	submit_bh(REQ_OP_WRITE | REQ_SYNC | REQ_META | REQ_PRIO, bh);
 	wait_on_buffer(bh);
-	sb_end_write(sb);
 	if (unlikely(!buffer_uptodate(bh)))
 		return -EIO;
-
 	return 0;
 }
 
+static int write_mmp_block(struct super_block *sb, struct buffer_head *bh)
+{
+	int err;
+
+	/*
+	 * We protect against freezing so that we don't create dirty buffers
+	 * on frozen filesystem.
+	 */
+	sb_start_write(sb);
+	err = write_mmp_block_thawed(sb, bh);
+	sb_end_write(sb);
+	return err;
+}
+
 /*
  * Read the MMP block. It _must_ be read from disk and hence we clear the
  * uptodate flag on the buffer.
@@ -340,7 +348,11 @@ int ext4_multi_mount_protect(struct super_block *sb,
 	seq = mmp_new_seq();
 	mmp->mmp_seq = cpu_to_le32(seq);
 
-	retval = write_mmp_block(sb, bh);
+	/*
+	 * On mount / remount we are protected against fs freezing (by s_umount
+	 * semaphore) and grabbing freeze protection upsets lockdep
+	 */
+	retval = write_mmp_block_thawed(sb, bh);
 	if (retval)
 		goto failed;
 
diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index 604ee458f31d..6195e36576f1 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -674,7 +674,7 @@ static struct stats dx_show_leaf(struct inode *dir,
 				len = de->name_len;
 				if (!IS_ENCRYPTED(dir)) {
 					/* Directory is not encrypted */
-					ext4fs_dirhash(dir, de->name,
+					(void) ext4fs_dirhash(dir, de->name,
 						de->name_len, &h);
 					printk("%*.s:(U)%x.%u ", len,
 					       name, h.hash,
@@ -709,8 +709,9 @@ static struct stats dx_show_leaf(struct inode *dir,
 					if (IS_CASEFOLDED(dir))
 						h.hash = EXT4_DIRENT_HASH(de);
 					else
-						ext4fs_dirhash(dir, de->name,
-						       de->name_len, &h);
+						(void) ext4fs_dirhash(dir,
+							de->name,
+							de->name_len, &h);
 					printk("%*.s:(E)%x.%u ", len, name,
 					       h.hash, (unsigned) ((char *) de
 								   - base));
@@ -720,7 +721,8 @@ static struct stats dx_show_leaf(struct inode *dir,
 #else
 				int len = de->name_len;
 				char *name = de->name;
-				ext4fs_dirhash(dir, de->name, de->name_len, &h);
+				(void) ext4fs_dirhash(dir, de->name,
+						      de->name_len, &h);
 				printk("%*.s:%x.%u ", len, name, h.hash,
 				       (unsigned) ((char *) de - base));
 #endif
@@ -849,8 +851,14 @@ dx_probe(struct ext4_filename *fname, struct inode *dir,
 	hinfo->seed = EXT4_SB(dir->i_sb)->s_hash_seed;
 	/* hash is already computed for encrypted casefolded directory */
 	if (fname && fname_name(fname) &&
-				!(IS_ENCRYPTED(dir) && IS_CASEFOLDED(dir)))
-		ext4fs_dirhash(dir, fname_name(fname), fname_len(fname), hinfo);
+	    !(IS_ENCRYPTED(dir) && IS_CASEFOLDED(dir))) {
+		int ret = ext4fs_dirhash(dir, fname_name(fname),
+					 fname_len(fname), hinfo);
+		if (ret < 0) {
+			ret_err = ERR_PTR(ret);
+			goto fail;
+		}
+	}
 	hash = hinfo->hash;
 
 	if (root->info.unused_flags & 1) {
@@ -1111,7 +1119,12 @@ static int htree_dirblock_to_tree(struct file *dir_file,
 				hinfo->minor_hash = 0;
 			}
 		} else {
-			ext4fs_dirhash(dir, de->name, de->name_len, hinfo);
+			err = ext4fs_dirhash(dir, de->name,
+					     de->name_len, hinfo);
+			if (err < 0) {
+				count = err;
+				goto errout;
+			}
 		}
 		if ((hinfo->hash < start_hash) ||
 		    ((hinfo->hash == start_hash) &&
@@ -1313,8 +1326,12 @@ static int dx_make_map(struct inode *dir, struct buffer_head *bh,
 		if (de->name_len && de->inode) {
 			if (ext4_hash_in_dirent(dir))
 				h.hash = EXT4_DIRENT_HASH(de);
-			else
-				ext4fs_dirhash(dir, de->name, de->name_len, &h);
+			else {
+				int err = ext4fs_dirhash(dir, de->name,
+						     de->name_len, &h);
+				if (err < 0)
+					return err;
+			}
 			map_tail--;
 			map_tail->hash = h.hash;
 			map_tail->offs = ((char *) de - base)>>2;
@@ -1452,10 +1469,9 @@ int ext4_fname_setup_ci_filename(struct inode *dir, const struct qstr *iname,
 	hinfo->hash_version = DX_HASH_SIPHASH;
 	hinfo->seed = NULL;
 	if (cf_name->name)
-		ext4fs_dirhash(dir, cf_name->name, cf_name->len, hinfo);
+		return ext4fs_dirhash(dir, cf_name->name, cf_name->len, hinfo);
 	else
-		ext4fs_dirhash(dir, iname->name, iname->len, hinfo);
-	return 0;
+		return ext4fs_dirhash(dir, iname->name, iname->len, hinfo);
 }
 #endif
 
@@ -2298,10 +2314,15 @@ static int make_indexed_dir(handle_t *handle, struct ext4_filename *fname,
 	fname->hinfo.seed = EXT4_SB(dir->i_sb)->s_hash_seed;
 
 	/* casefolded encrypted hashes are computed on fname setup */
-	if (!ext4_hash_in_dirent(dir))
-		ext4fs_dirhash(dir, fname_name(fname),
-				fname_len(fname), &fname->hinfo);
-
+	if (!ext4_hash_in_dirent(dir)) {
+		int err = ext4fs_dirhash(dir, fname_name(fname),
+					 fname_len(fname), &fname->hinfo);
+		if (err < 0) {
+			brelse(bh2);
+			brelse(bh);
+			return err;
+		}
+	}
 	memset(frames, 0, sizeof(frames));
 	frame = frames;
 	frame->entries = entries;
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index e79ca9ef9831..2565fb02b7ab 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -3195,11 +3195,9 @@ static __le16 ext4_group_desc_csum(struct super_block *sb, __u32 block_group,
 	crc = crc16(crc, (__u8 *)gdp, offset);
 	offset += sizeof(gdp->bg_checksum); /* skip checksum */
 	/* for checksum of struct ext4_group_desc do the rest...*/
-	if (ext4_has_feature_64bit(sb) &&
-	    offset < le16_to_cpu(sbi->s_es->s_desc_size))
+	if (ext4_has_feature_64bit(sb) && offset < sbi->s_desc_size)
 		crc = crc16(crc, (__u8 *)gdp + offset,
-			    le16_to_cpu(sbi->s_es->s_desc_size) -
-				offset);
+			    sbi->s_desc_size - offset);
 
 out:
 	return cpu_to_le16(crc);
@@ -6568,9 +6566,6 @@ static int __ext4_remount(struct fs_context *fc, struct super_block *sb)
 	}
 
 #ifdef CONFIG_QUOTA
-	/* Release old quota file names */
-	for (i = 0; i < EXT4_MAXQUOTAS; i++)
-		kfree(old_opts.s_qf_names[i]);
 	if (enable_quota) {
 		if (sb_any_quota_suspended(sb))
 			dquot_resume(sb, -1);
@@ -6580,6 +6575,9 @@ static int __ext4_remount(struct fs_context *fc, struct super_block *sb)
 				goto restore_opts;
 		}
 	}
+	/* Release old quota file names */
+	for (i = 0; i < EXT4_MAXQUOTAS; i++)
+		kfree(old_opts.s_qf_names[i]);
 #endif
 	if (!test_opt(sb, BLOCK_VALIDITY) && sbi->s_system_blks)
 		ext4_release_system_zone(sb);
@@ -6590,6 +6588,13 @@ static int __ext4_remount(struct fs_context *fc, struct super_block *sb)
 	return 0;
 
 restore_opts:
+	/*
+	 * If there was a failing r/w to ro transition, we may need to
+	 * re-enable quota
+	 */
+	if ((sb->s_flags & SB_RDONLY) && !(old_sb_flags & SB_RDONLY) &&
+	    sb_any_quota_suspended(sb))
+		dquot_resume(sb, -1);
 	sb->s_flags = old_sb_flags;
 	sbi->s_mount_opt = old_opts.s_mount_opt;
 	sbi->s_mount_opt2 = old_opts.s_mount_opt2;
diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index f66c3fae9058..30f7c79ced47 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -2581,6 +2581,7 @@ static int ext4_xattr_move_to_block(handle_t *handle, struct inode *inode,
 		.in_inode = !!entry->e_value_inum,
 	};
 	struct ext4_xattr_ibody_header *header = IHDR(inode, raw_inode);
+	int needs_kvfree = 0;
 	int error;
 
 	is = kzalloc(sizeof(struct ext4_xattr_ibody_find), GFP_NOFS);
@@ -2603,7 +2604,7 @@ static int ext4_xattr_move_to_block(handle_t *handle, struct inode *inode,
 			error = -ENOMEM;
 			goto out;
 		}
-
+		needs_kvfree = 1;
 		error = ext4_xattr_inode_get(inode, entry, buffer, value_size);
 		if (error)
 			goto out;
@@ -2642,7 +2643,7 @@ static int ext4_xattr_move_to_block(handle_t *handle, struct inode *inode,
 
 out:
 	kfree(b_entry_name);
-	if (entry->e_value_inum && buffer)
+	if (needs_kvfree && buffer)
 		kvfree(buffer);
 	if (is)
 		brelse(is->iloc.bh);
diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
index 342af24b2f8c..3949ce2b484d 100644
--- a/fs/f2fs/extent_cache.c
+++ b/fs/f2fs/extent_cache.c
@@ -179,29 +179,6 @@ struct rb_entry *f2fs_lookup_rb_tree(struct rb_root_cached *root,
 	return re;
 }
 
-struct rb_node **f2fs_lookup_rb_tree_ext(struct f2fs_sb_info *sbi,
-					struct rb_root_cached *root,
-					struct rb_node **parent,
-					unsigned long long key, bool *leftmost)
-{
-	struct rb_node **p = &root->rb_root.rb_node;
-	struct rb_entry *re;
-
-	while (*p) {
-		*parent = *p;
-		re = rb_entry(*parent, struct rb_entry, rb_node);
-
-		if (key < re->key) {
-			p = &(*p)->rb_left;
-		} else {
-			p = &(*p)->rb_right;
-			*leftmost = false;
-		}
-	}
-
-	return p;
-}
-
 struct rb_node **f2fs_lookup_rb_tree_for_insert(struct f2fs_sb_info *sbi,
 				struct rb_root_cached *root,
 				struct rb_node **parent,
@@ -310,7 +287,7 @@ struct rb_entry *f2fs_lookup_rb_tree_ret(struct rb_root_cached *root,
 }
 
 bool f2fs_check_rb_tree_consistence(struct f2fs_sb_info *sbi,
-				struct rb_root_cached *root, bool check_key)
+				struct rb_root_cached *root)
 {
 #ifdef CONFIG_F2FS_CHECK_FS
 	struct rb_node *cur = rb_first_cached(root), *next;
@@ -327,23 +304,12 @@ bool f2fs_check_rb_tree_consistence(struct f2fs_sb_info *sbi,
 		cur_re = rb_entry(cur, struct rb_entry, rb_node);
 		next_re = rb_entry(next, struct rb_entry, rb_node);
 
-		if (check_key) {
-			if (cur_re->key > next_re->key) {
-				f2fs_info(sbi, "inconsistent rbtree, "
-					"cur(%llu) next(%llu)",
-					cur_re->key, next_re->key);
-				return false;
-			}
-			goto next;
-		}
-
 		if (cur_re->ofs + cur_re->len > next_re->ofs) {
 			f2fs_info(sbi, "inconsistent rbtree, cur(%u, %u) next(%u, %u)",
 				  cur_re->ofs, cur_re->len,
 				  next_re->ofs, next_re->len);
 			return false;
 		}
-next:
 		cur = next;
 	}
 #endif
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 42962ee0a117..8f01d2344409 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -629,13 +629,8 @@ enum extent_type {
 
 struct rb_entry {
 	struct rb_node rb_node;		/* rb node located in rb-tree */
-	union {
-		struct {
-			unsigned int ofs;	/* start offset of the entry */
-			unsigned int len;	/* length of the entry */
-		};
-		unsigned long long key;		/* 64-bits key */
-	} __packed;
+	unsigned int ofs;		/* start offset of the entry */
+	unsigned int len;		/* length of the entry */
 };
 
 struct extent_info {
@@ -4164,10 +4159,6 @@ void f2fs_leave_shrinker(struct f2fs_sb_info *sbi);
  */
 struct rb_entry *f2fs_lookup_rb_tree(struct rb_root_cached *root,
 				struct rb_entry *cached_re, unsigned int ofs);
-struct rb_node **f2fs_lookup_rb_tree_ext(struct f2fs_sb_info *sbi,
-				struct rb_root_cached *root,
-				struct rb_node **parent,
-				unsigned long long key, bool *left_most);
 struct rb_node **f2fs_lookup_rb_tree_for_insert(struct f2fs_sb_info *sbi,
 				struct rb_root_cached *root,
 				struct rb_node **parent,
@@ -4178,7 +4169,7 @@ struct rb_entry *f2fs_lookup_rb_tree_ret(struct rb_root_cached *root,
 		struct rb_node ***insert_p, struct rb_node **insert_parent,
 		bool force, bool *leftmost);
 bool f2fs_check_rb_tree_consistence(struct f2fs_sb_info *sbi,
-				struct rb_root_cached *root, bool check_key);
+				struct rb_root_cached *root);
 void f2fs_init_extent_tree(struct inode *inode);
 void f2fs_drop_extent_tree(struct inode *inode);
 void f2fs_destroy_extent_node(struct inode *inode);
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 72cda2f9380f..97426be7e07d 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -392,40 +392,95 @@ static unsigned int count_bits(const unsigned long *addr,
 	return sum;
 }
 
-static struct victim_entry *attach_victim_entry(struct f2fs_sb_info *sbi,
-				unsigned long long mtime, unsigned int segno,
-				struct rb_node *parent, struct rb_node **p,
-				bool left_most)
+static bool f2fs_check_victim_tree(struct f2fs_sb_info *sbi,
+				struct rb_root_cached *root)
+{
+#ifdef CONFIG_F2FS_CHECK_FS
+	struct rb_node *cur = rb_first_cached(root), *next;
+	struct victim_entry *cur_ve, *next_ve;
+
+	while (cur) {
+		next = rb_next(cur);
+		if (!next)
+			return true;
+
+		cur_ve = rb_entry(cur, struct victim_entry, rb_node);
+		next_ve = rb_entry(next, struct victim_entry, rb_node);
+
+		if (cur_ve->mtime > next_ve->mtime) {
+			f2fs_info(sbi, "broken victim_rbtree, "
+				"cur_mtime(%llu) next_mtime(%llu)",
+				cur_ve->mtime, next_ve->mtime);
+			return false;
+		}
+		cur = next;
+	}
+#endif
+	return true;
+}
+
+static struct victim_entry *__lookup_victim_entry(struct f2fs_sb_info *sbi,
+					unsigned long long mtime)
+{
+	struct atgc_management *am = &sbi->am;
+	struct rb_node *node = am->root.rb_root.rb_node;
+	struct victim_entry *ve = NULL;
+
+	while (node) {
+		ve = rb_entry(node, struct victim_entry, rb_node);
+
+		if (mtime < ve->mtime)
+			node = node->rb_left;
+		else
+			node = node->rb_right;
+	}
+	return ve;
+}
+
+static struct victim_entry *__create_victim_entry(struct f2fs_sb_info *sbi,
+		unsigned long long mtime, unsigned int segno)
 {
 	struct atgc_management *am = &sbi->am;
 	struct victim_entry *ve;
 
-	ve =  f2fs_kmem_cache_alloc(victim_entry_slab,
-				GFP_NOFS, true, NULL);
+	ve =  f2fs_kmem_cache_alloc(victim_entry_slab, GFP_NOFS, true, NULL);
 
 	ve->mtime = mtime;
 	ve->segno = segno;
 
-	rb_link_node(&ve->rb_node, parent, p);
-	rb_insert_color_cached(&ve->rb_node, &am->root, left_most);
-
 	list_add_tail(&ve->list, &am->victim_list);
-
 	am->victim_count++;
 
 	return ve;
 }
 
-static void insert_victim_entry(struct f2fs_sb_info *sbi,
+static void __insert_victim_entry(struct f2fs_sb_info *sbi,
 				unsigned long long mtime, unsigned int segno)
 {
 	struct atgc_management *am = &sbi->am;
-	struct rb_node **p;
+	struct rb_root_cached *root = &am->root;
+	struct rb_node **p = &root->rb_root.rb_node;
 	struct rb_node *parent = NULL;
+	struct victim_entry *ve;
 	bool left_most = true;
 
-	p = f2fs_lookup_rb_tree_ext(sbi, &am->root, &parent, mtime, &left_most);
-	attach_victim_entry(sbi, mtime, segno, parent, p, left_most);
+	/* look up rb tree to find parent node */
+	while (*p) {
+		parent = *p;
+		ve = rb_entry(parent, struct victim_entry, rb_node);
+
+		if (mtime < ve->mtime) {
+			p = &(*p)->rb_left;
+		} else {
+			p = &(*p)->rb_right;
+			left_most = false;
+		}
+	}
+
+	ve = __create_victim_entry(sbi, mtime, segno);
+
+	rb_link_node(&ve->rb_node, parent, p);
+	rb_insert_color_cached(&ve->rb_node, root, left_most);
 }
 
 static void add_victim_entry(struct f2fs_sb_info *sbi,
@@ -461,19 +516,7 @@ static void add_victim_entry(struct f2fs_sb_info *sbi,
 	if (sit_i->dirty_max_mtime - mtime < p->age_threshold)
 		return;
 
-	insert_victim_entry(sbi, mtime, segno);
-}
-
-static struct rb_node *lookup_central_victim(struct f2fs_sb_info *sbi,
-						struct victim_sel_policy *p)
-{
-	struct atgc_management *am = &sbi->am;
-	struct rb_node *parent = NULL;
-	bool left_most;
-
-	f2fs_lookup_rb_tree_ext(sbi, &am->root, &parent, p->age, &left_most);
-
-	return parent;
+	__insert_victim_entry(sbi, mtime, segno);
 }
 
 static void atgc_lookup_victim(struct f2fs_sb_info *sbi,
@@ -483,7 +526,6 @@ static void atgc_lookup_victim(struct f2fs_sb_info *sbi,
 	struct atgc_management *am = &sbi->am;
 	struct rb_root_cached *root = &am->root;
 	struct rb_node *node;
-	struct rb_entry *re;
 	struct victim_entry *ve;
 	unsigned long long total_time;
 	unsigned long long age, u, accu;
@@ -510,12 +552,10 @@ static void atgc_lookup_victim(struct f2fs_sb_info *sbi,
 
 	node = rb_first_cached(root);
 next:
-	re = rb_entry_safe(node, struct rb_entry, rb_node);
-	if (!re)
+	ve = rb_entry_safe(node, struct victim_entry, rb_node);
+	if (!ve)
 		return;
 
-	ve = (struct victim_entry *)re;
-
 	if (ve->mtime >= max_mtime || ve->mtime < min_mtime)
 		goto skip;
 
@@ -557,8 +597,6 @@ static void atssr_lookup_victim(struct f2fs_sb_info *sbi,
 {
 	struct sit_info *sit_i = SIT_I(sbi);
 	struct atgc_management *am = &sbi->am;
-	struct rb_node *node;
-	struct rb_entry *re;
 	struct victim_entry *ve;
 	unsigned long long age;
 	unsigned long long max_mtime = sit_i->dirty_max_mtime;
@@ -568,25 +606,22 @@ static void atssr_lookup_victim(struct f2fs_sb_info *sbi,
 	unsigned int dirty_threshold = max(am->max_candidate_count,
 					am->candidate_ratio *
 					am->victim_count / 100);
-	unsigned int cost;
-	unsigned int iter = 0;
+	unsigned int cost, iter;
 	int stage = 0;
 
 	if (max_mtime < min_mtime)
 		return;
 	max_mtime += 1;
 next_stage:
-	node = lookup_central_victim(sbi, p);
+	iter = 0;
+	ve = __lookup_victim_entry(sbi, p->age);
 next_node:
-	re = rb_entry_safe(node, struct rb_entry, rb_node);
-	if (!re) {
-		if (stage == 0)
-			goto skip_stage;
+	if (!ve) {
+		if (stage++ == 0)
+			goto next_stage;
 		return;
 	}
 
-	ve = (struct victim_entry *)re;
-
 	if (ve->mtime >= max_mtime || ve->mtime < min_mtime)
 		goto skip_node;
 
@@ -612,24 +647,20 @@ static void atssr_lookup_victim(struct f2fs_sb_info *sbi,
 	}
 skip_node:
 	if (iter < dirty_threshold) {
-		if (stage == 0)
-			node = rb_prev(node);
-		else if (stage == 1)
-			node = rb_next(node);
+		ve = rb_entry(stage == 0 ? rb_prev(&ve->rb_node) :
+					rb_next(&ve->rb_node),
+					struct victim_entry, rb_node);
 		goto next_node;
 	}
-skip_stage:
-	if (stage < 1) {
-		stage++;
-		iter = 0;
+
+	if (stage++ == 0)
 		goto next_stage;
-	}
 }
+
 static void lookup_victim_by_age(struct f2fs_sb_info *sbi,
 						struct victim_sel_policy *p)
 {
-	f2fs_bug_on(sbi, !f2fs_check_rb_tree_consistence(sbi,
-						&sbi->am.root, true));
+	f2fs_bug_on(sbi, !f2fs_check_victim_tree(sbi, &sbi->am.root));
 
 	if (p->gc_mode == GC_AT)
 		atgc_lookup_victim(sbi, p);
diff --git a/fs/f2fs/gc.h b/fs/f2fs/gc.h
index 19b956c2d697..ca84024b9c9e 100644
--- a/fs/f2fs/gc.h
+++ b/fs/f2fs/gc.h
@@ -55,20 +55,10 @@ struct gc_inode_list {
 	struct radix_tree_root iroot;
 };
 
-struct victim_info {
-	unsigned long long mtime;	/* mtime of section */
-	unsigned int segno;		/* section No. */
-};
-
 struct victim_entry {
 	struct rb_node rb_node;		/* rb node located in rb-tree */
-	union {
-		struct {
-			unsigned long long mtime;	/* mtime of section */
-			unsigned int segno;		/* segment No. */
-		};
-		struct victim_info vi;	/* victim info */
-	};
+	unsigned long long mtime;	/* mtime of section */
+	unsigned int segno;		/* segment No. */
 	struct list_head list;
 };
 
diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index 6032589099ce..156b81daa0cb 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -998,12 +998,20 @@ static int f2fs_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
 			goto out;
 	}
 
+	/*
+	 * Copied from ext4_rename: we need to protect against old.inode
+	 * directory getting converted from inline directory format into
+	 * a normal one.
+	 */
+	if (S_ISDIR(old_inode->i_mode))
+		inode_lock_nested(old_inode, I_MUTEX_NONDIR2);
+
 	err = -ENOENT;
 	old_entry = f2fs_find_entry(old_dir, &old_dentry->d_name, &old_page);
 	if (!old_entry) {
 		if (IS_ERR(old_page))
 			err = PTR_ERR(old_page);
-		goto out;
+		goto out_unlock_old;
 	}
 
 	if (S_ISDIR(old_inode->i_mode)) {
@@ -1111,6 +1119,9 @@ static int f2fs_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
 
 	f2fs_unlock_op(sbi);
 
+	if (S_ISDIR(old_inode->i_mode))
+		inode_unlock(old_inode);
+
 	if (IS_DIRSYNC(old_dir) || IS_DIRSYNC(new_dir))
 		f2fs_sync_fs(sbi->sb, 1);
 
@@ -1125,6 +1136,9 @@ static int f2fs_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
 		f2fs_put_page(old_dir_page, 0);
 out_old:
 	f2fs_put_page(old_page, 0);
+out_unlock_old:
+	if (S_ISDIR(old_inode->i_mode))
+		inode_unlock(old_inode);
 out:
 	iput(whiteout);
 	return err;
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 06991cf64329..097b5e7231d0 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -263,7 +263,7 @@ static int __replace_atomic_write_block(struct inode *inode, pgoff_t index,
 	f2fs_put_dnode(&dn);
 
 	trace_f2fs_replace_atomic_write_block(inode, F2FS_I(inode)->cow_inode,
-					index, *old_addr, new_addr, recover);
+			index, old_addr ? *old_addr : 0, new_addr, recover);
 	return 0;
 }
 
@@ -1487,7 +1487,7 @@ static int __issue_discard_cmd(struct f2fs_sb_info *sbi,
 			goto next;
 		if (unlikely(dcc->rbtree_check))
 			f2fs_bug_on(sbi, !f2fs_check_rb_tree_consistence(sbi,
-							&dcc->root, false));
+							&dcc->root));
 		blk_start_plug(&plug);
 		list_for_each_entry_safe(dc, tmp, pend_list, list) {
 			f2fs_bug_on(sbi, dc->state != D_PREP);
@@ -3003,7 +3003,7 @@ static unsigned int __issue_discard_cmd_range(struct f2fs_sb_info *sbi,
 	mutex_lock(&dcc->cmd_lock);
 	if (unlikely(dcc->rbtree_check))
 		f2fs_bug_on(sbi, !f2fs_check_rb_tree_consistence(sbi,
-							&dcc->root, false));
+							&dcc->root));
 
 	dc = (struct discard_cmd *)f2fs_lookup_rb_tree_ret(&dcc->root,
 					NULL, start,
diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 713e2d97935f..909150a57aeb 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -829,7 +829,7 @@ void wbc_detach_inode(struct writeback_control *wbc)
 		 * is okay.  The main goal is avoiding keeping an inode on
 		 * the wrong wb for an extended period of time.
 		 */
-		if (hweight32(history) > WB_FRN_HIST_THR_SLOTS)
+		if (hweight16(history) > WB_FRN_HIST_THR_SLOTS)
 			inode_switch_wbs(inode, max_id);
 	}
 
diff --git a/fs/ksmbd/connection.c b/fs/ksmbd/connection.c
index b8f9d627f241..e3312fbf4c09 100644
--- a/fs/ksmbd/connection.c
+++ b/fs/ksmbd/connection.c
@@ -20,7 +20,7 @@ static DEFINE_MUTEX(init_lock);
 static struct ksmbd_conn_ops default_conn_ops;
 
 LIST_HEAD(conn_list);
-DEFINE_RWLOCK(conn_list_lock);
+DECLARE_RWSEM(conn_list_lock);
 
 /**
  * ksmbd_conn_free() - free resources of the connection instance
@@ -32,9 +32,9 @@ DEFINE_RWLOCK(conn_list_lock);
  */
 void ksmbd_conn_free(struct ksmbd_conn *conn)
 {
-	write_lock(&conn_list_lock);
+	down_write(&conn_list_lock);
 	list_del(&conn->conns_list);
-	write_unlock(&conn_list_lock);
+	up_write(&conn_list_lock);
 
 	xa_destroy(&conn->sessions);
 	kvfree(conn->request_buf);
@@ -56,7 +56,7 @@ struct ksmbd_conn *ksmbd_conn_alloc(void)
 		return NULL;
 
 	conn->need_neg = true;
-	conn->status = KSMBD_SESS_NEW;
+	ksmbd_conn_set_new(conn);
 	conn->local_nls = load_nls("utf8");
 	if (!conn->local_nls)
 		conn->local_nls = load_nls_default();
@@ -84,9 +84,9 @@ struct ksmbd_conn *ksmbd_conn_alloc(void)
 	spin_lock_init(&conn->llist_lock);
 	INIT_LIST_HEAD(&conn->lock_list);
 
-	write_lock(&conn_list_lock);
+	down_write(&conn_list_lock);
 	list_add(&conn->conns_list, &conn_list);
-	write_unlock(&conn_list_lock);
+	up_write(&conn_list_lock);
 	return conn;
 }
 
@@ -95,7 +95,7 @@ bool ksmbd_conn_lookup_dialect(struct ksmbd_conn *c)
 	struct ksmbd_conn *t;
 	bool ret = false;
 
-	read_lock(&conn_list_lock);
+	down_read(&conn_list_lock);
 	list_for_each_entry(t, &conn_list, conns_list) {
 		if (memcmp(t->ClientGUID, c->ClientGUID, SMB2_CLIENT_GUID_SIZE))
 			continue;
@@ -103,7 +103,7 @@ bool ksmbd_conn_lookup_dialect(struct ksmbd_conn *c)
 		ret = true;
 		break;
 	}
-	read_unlock(&conn_list_lock);
+	up_read(&conn_list_lock);
 	return ret;
 }
 
@@ -149,19 +149,47 @@ int ksmbd_conn_try_dequeue_request(struct ksmbd_work *work)
 	return ret;
 }
 
-static void ksmbd_conn_lock(struct ksmbd_conn *conn)
+void ksmbd_conn_lock(struct ksmbd_conn *conn)
 {
 	mutex_lock(&conn->srv_mutex);
 }
 
-static void ksmbd_conn_unlock(struct ksmbd_conn *conn)
+void ksmbd_conn_unlock(struct ksmbd_conn *conn)
 {
 	mutex_unlock(&conn->srv_mutex);
 }
 
-void ksmbd_conn_wait_idle(struct ksmbd_conn *conn)
+void ksmbd_all_conn_set_status(u64 sess_id, u32 status)
 {
+	struct ksmbd_conn *conn;
+
+	down_read(&conn_list_lock);
+	list_for_each_entry(conn, &conn_list, conns_list) {
+		if (conn->binding || xa_load(&conn->sessions, sess_id))
+			WRITE_ONCE(conn->status, status);
+	}
+	up_read(&conn_list_lock);
+}
+
+void ksmbd_conn_wait_idle(struct ksmbd_conn *conn, u64 sess_id)
+{
+	struct ksmbd_conn *bind_conn;
+
 	wait_event(conn->req_running_q, atomic_read(&conn->req_running) < 2);
+
+	down_read(&conn_list_lock);
+	list_for_each_entry(bind_conn, &conn_list, conns_list) {
+		if (bind_conn == conn)
+			continue;
+
+		if ((bind_conn->binding || xa_load(&bind_conn->sessions, sess_id)) &&
+		    !ksmbd_conn_releasing(bind_conn) &&
+		    atomic_read(&bind_conn->req_running)) {
+			wait_event(bind_conn->req_running_q,
+				atomic_read(&bind_conn->req_running) == 0);
+		}
+	}
+	up_read(&conn_list_lock);
 }
 
 int ksmbd_conn_write(struct ksmbd_work *work)
@@ -245,7 +273,7 @@ bool ksmbd_conn_alive(struct ksmbd_conn *conn)
 	if (!ksmbd_server_running())
 		return false;
 
-	if (conn->status == KSMBD_SESS_EXITING)
+	if (ksmbd_conn_exiting(conn))
 		return false;
 
 	if (kthread_should_stop())
@@ -305,7 +333,7 @@ int ksmbd_conn_handler_loop(void *p)
 		pdu_size = get_rfc1002_len(hdr_buf);
 		ksmbd_debug(CONN, "RFC1002 header %u bytes\n", pdu_size);
 
-		if (conn->status == KSMBD_SESS_GOOD)
+		if (ksmbd_conn_good(conn))
 			max_allowed_pdu_size =
 				SMB3_MAX_MSGSIZE + conn->vals->max_write_size;
 		else
@@ -314,7 +342,7 @@ int ksmbd_conn_handler_loop(void *p)
 		if (pdu_size > max_allowed_pdu_size) {
 			pr_err_ratelimited("PDU length(%u) excceed maximum allowed pdu size(%u) on connection(%d)\n",
 					pdu_size, max_allowed_pdu_size,
-					conn->status);
+					READ_ONCE(conn->status));
 			break;
 		}
 
@@ -362,10 +390,10 @@ int ksmbd_conn_handler_loop(void *p)
 	}
 
 out:
+	ksmbd_conn_set_releasing(conn);
 	/* Wait till all reference dropped to the Server object*/
 	wait_event(conn->r_count_q, atomic_read(&conn->r_count) == 0);
 
-
 	if (IS_ENABLED(CONFIG_UNICODE))
 		utf8_unload(conn->um);
 	unload_nls(conn->local_nls);
@@ -409,7 +437,7 @@ static void stop_sessions(void)
 	struct ksmbd_transport *t;
 
 again:
-	read_lock(&conn_list_lock);
+	down_read(&conn_list_lock);
 	list_for_each_entry(conn, &conn_list, conns_list) {
 		struct task_struct *task;
 
@@ -418,14 +446,14 @@ static void stop_sessions(void)
 		if (task)
 			ksmbd_debug(CONN, "Stop session handler %s/%d\n",
 				    task->comm, task_pid_nr(task));
-		conn->status = KSMBD_SESS_EXITING;
+		ksmbd_conn_set_exiting(conn);
 		if (t->ops->shutdown) {
-			read_unlock(&conn_list_lock);
+			up_read(&conn_list_lock);
 			t->ops->shutdown(t);
-			read_lock(&conn_list_lock);
+			down_read(&conn_list_lock);
 		}
 	}
-	read_unlock(&conn_list_lock);
+	up_read(&conn_list_lock);
 
 	if (!list_empty(&conn_list)) {
 		schedule_timeout_interruptible(HZ / 10); /* 100ms */
diff --git a/fs/ksmbd/connection.h b/fs/ksmbd/connection.h
index 0e3a848defaf..ad8dfaa48ffb 100644
--- a/fs/ksmbd/connection.h
+++ b/fs/ksmbd/connection.h
@@ -26,7 +26,8 @@ enum {
 	KSMBD_SESS_GOOD,
 	KSMBD_SESS_EXITING,
 	KSMBD_SESS_NEED_RECONNECT,
-	KSMBD_SESS_NEED_NEGOTIATE
+	KSMBD_SESS_NEED_NEGOTIATE,
+	KSMBD_SESS_RELEASING
 };
 
 struct ksmbd_stats {
@@ -140,10 +141,10 @@ struct ksmbd_transport {
 #define KSMBD_TCP_PEER_SOCKADDR(c)	((struct sockaddr *)&((c)->peer_addr))
 
 extern struct list_head conn_list;
-extern rwlock_t conn_list_lock;
+extern struct rw_semaphore conn_list_lock;
 
 bool ksmbd_conn_alive(struct ksmbd_conn *conn);
-void ksmbd_conn_wait_idle(struct ksmbd_conn *conn);
+void ksmbd_conn_wait_idle(struct ksmbd_conn *conn, u64 sess_id);
 struct ksmbd_conn *ksmbd_conn_alloc(void);
 void ksmbd_conn_free(struct ksmbd_conn *conn);
 bool ksmbd_conn_lookup_dialect(struct ksmbd_conn *c);
@@ -162,6 +163,8 @@ void ksmbd_conn_init_server_callbacks(struct ksmbd_conn_ops *ops);
 int ksmbd_conn_handler_loop(void *p);
 int ksmbd_conn_transport_init(void);
 void ksmbd_conn_transport_destroy(void);
+void ksmbd_conn_lock(struct ksmbd_conn *conn);
+void ksmbd_conn_unlock(struct ksmbd_conn *conn);
 
 /*
  * WARNING
@@ -169,43 +172,60 @@ void ksmbd_conn_transport_destroy(void);
  * This is a hack. We will move status to a proper place once we land
  * a multi-sessions support.
  */
-static inline bool ksmbd_conn_good(struct ksmbd_work *work)
+static inline bool ksmbd_conn_good(struct ksmbd_conn *conn)
 {
-	return work->conn->status == KSMBD_SESS_GOOD;
+	return READ_ONCE(conn->status) == KSMBD_SESS_GOOD;
 }
 
-static inline bool ksmbd_conn_need_negotiate(struct ksmbd_work *work)
+static inline bool ksmbd_conn_need_negotiate(struct ksmbd_conn *conn)
 {
-	return work->conn->status == KSMBD_SESS_NEED_NEGOTIATE;
+	return READ_ONCE(conn->status) == KSMBD_SESS_NEED_NEGOTIATE;
 }
 
-static inline bool ksmbd_conn_need_reconnect(struct ksmbd_work *work)
+static inline bool ksmbd_conn_need_reconnect(struct ksmbd_conn *conn)
 {
-	return work->conn->status == KSMBD_SESS_NEED_RECONNECT;
+	return READ_ONCE(conn->status) == KSMBD_SESS_NEED_RECONNECT;
 }
 
-static inline bool ksmbd_conn_exiting(struct ksmbd_work *work)
+static inline bool ksmbd_conn_exiting(struct ksmbd_conn *conn)
 {
-	return work->conn->status == KSMBD_SESS_EXITING;
+	return READ_ONCE(conn->status) == KSMBD_SESS_EXITING;
 }
 
-static inline void ksmbd_conn_set_good(struct ksmbd_work *work)
+static inline bool ksmbd_conn_releasing(struct ksmbd_conn *conn)
 {
-	work->conn->status = KSMBD_SESS_GOOD;
+	return READ_ONCE(conn->status) == KSMBD_SESS_RELEASING;
 }
 
-static inline void ksmbd_conn_set_need_negotiate(struct ksmbd_work *work)
+static inline void ksmbd_conn_set_new(struct ksmbd_conn *conn)
 {
-	work->conn->status = KSMBD_SESS_NEED_NEGOTIATE;
+	WRITE_ONCE(conn->status, KSMBD_SESS_NEW);
 }
 
-static inline void ksmbd_conn_set_need_reconnect(struct ksmbd_work *work)
+static inline void ksmbd_conn_set_good(struct ksmbd_conn *conn)
 {
-	work->conn->status = KSMBD_SESS_NEED_RECONNECT;
+	WRITE_ONCE(conn->status, KSMBD_SESS_GOOD);
 }
 
-static inline void ksmbd_conn_set_exiting(struct ksmbd_work *work)
+static inline void ksmbd_conn_set_need_negotiate(struct ksmbd_conn *conn)
 {
-	work->conn->status = KSMBD_SESS_EXITING;
+	WRITE_ONCE(conn->status, KSMBD_SESS_NEED_NEGOTIATE);
 }
+
+static inline void ksmbd_conn_set_need_reconnect(struct ksmbd_conn *conn)
+{
+	WRITE_ONCE(conn->status, KSMBD_SESS_NEED_RECONNECT);
+}
+
+static inline void ksmbd_conn_set_exiting(struct ksmbd_conn *conn)
+{
+	WRITE_ONCE(conn->status, KSMBD_SESS_EXITING);
+}
+
+static inline void ksmbd_conn_set_releasing(struct ksmbd_conn *conn)
+{
+	WRITE_ONCE(conn->status, KSMBD_SESS_RELEASING);
+}
+
+void ksmbd_all_conn_set_status(u64 sess_id, u32 status);
 #endif /* __CONNECTION_H__ */
diff --git a/fs/ksmbd/mgmt/tree_connect.c b/fs/ksmbd/mgmt/tree_connect.c
index f19de20c2960..f07a05f37651 100644
--- a/fs/ksmbd/mgmt/tree_connect.c
+++ b/fs/ksmbd/mgmt/tree_connect.c
@@ -137,6 +137,9 @@ int ksmbd_tree_conn_session_logoff(struct ksmbd_session *sess)
 	struct ksmbd_tree_connect *tc;
 	unsigned long id;
 
+	if (!sess)
+		return -EINVAL;
+
 	xa_for_each(&sess->tree_conns, id, tc)
 		ret |= ksmbd_tree_conn_disconnect(sess, tc);
 	xa_destroy(&sess->tree_conns);
diff --git a/fs/ksmbd/mgmt/user_session.c b/fs/ksmbd/mgmt/user_session.c
index 92b1603b5abe..ea4b56d570fb 100644
--- a/fs/ksmbd/mgmt/user_session.c
+++ b/fs/ksmbd/mgmt/user_session.c
@@ -30,15 +30,15 @@ struct ksmbd_session_rpc {
 
 static void free_channel_list(struct ksmbd_session *sess)
 {
-	struct channel *chann, *tmp;
+	struct channel *chann;
+	unsigned long index;
 
-	write_lock(&sess->chann_lock);
-	list_for_each_entry_safe(chann, tmp, &sess->ksmbd_chann_list,
-				 chann_list) {
-		list_del(&chann->chann_list);
+	xa_for_each(&sess->ksmbd_chann_list, index, chann) {
+		xa_erase(&sess->ksmbd_chann_list, index);
 		kfree(chann);
 	}
-	write_unlock(&sess->chann_lock);
+
+	xa_destroy(&sess->ksmbd_chann_list);
 }
 
 static void __session_rpc_close(struct ksmbd_session *sess,
@@ -153,10 +153,6 @@ void ksmbd_session_destroy(struct ksmbd_session *sess)
 	if (!sess)
 		return;
 
-	down_write(&sessions_table_lock);
-	hash_del(&sess->hlist);
-	up_write(&sessions_table_lock);
-
 	if (sess->user)
 		ksmbd_free_user(sess->user);
 
@@ -174,76 +170,101 @@ static struct ksmbd_session *__session_lookup(unsigned long long id)
 	struct ksmbd_session *sess;
 
 	hash_for_each_possible(sessions_table, sess, hlist, id) {
-		if (id == sess->id)
+		if (id == sess->id) {
+			sess->last_active = jiffies;
 			return sess;
+		}
 	}
 	return NULL;
 }
 
+static void ksmbd_expire_session(struct ksmbd_conn *conn)
+{
+	unsigned long id;
+	struct ksmbd_session *sess;
+
+	down_write(&sessions_table_lock);
+	xa_for_each(&conn->sessions, id, sess) {
+		if (sess->state != SMB2_SESSION_VALID ||
+		    time_after(jiffies,
+			       sess->last_active + SMB2_SESSION_TIMEOUT)) {
+			xa_erase(&conn->sessions, sess->id);
+			hash_del(&sess->hlist);
+			ksmbd_session_destroy(sess);
+			continue;
+		}
+	}
+	up_write(&sessions_table_lock);
+}
+
 int ksmbd_session_register(struct ksmbd_conn *conn,
 			   struct ksmbd_session *sess)
 {
 	sess->dialect = conn->dialect;
 	memcpy(sess->ClientGUID, conn->ClientGUID, SMB2_CLIENT_GUID_SIZE);
+	ksmbd_expire_session(conn);
 	return xa_err(xa_store(&conn->sessions, sess->id, sess, GFP_KERNEL));
 }
 
 static int ksmbd_chann_del(struct ksmbd_conn *conn, struct ksmbd_session *sess)
 {
-	struct channel *chann, *tmp;
-
-	write_lock(&sess->chann_lock);
-	list_for_each_entry_safe(chann, tmp, &sess->ksmbd_chann_list,
-				 chann_list) {
-		if (chann->conn == conn) {
-			list_del(&chann->chann_list);
-			kfree(chann);
-			write_unlock(&sess->chann_lock);
-			return 0;
-		}
-	}
-	write_unlock(&sess->chann_lock);
+	struct channel *chann;
 
-	return -ENOENT;
+	chann = xa_erase(&sess->ksmbd_chann_list, (long)conn);
+	if (!chann)
+		return -ENOENT;
+
+	kfree(chann);
+	return 0;
 }
 
 void ksmbd_sessions_deregister(struct ksmbd_conn *conn)
 {
 	struct ksmbd_session *sess;
+	unsigned long id;
 
+	down_write(&sessions_table_lock);
 	if (conn->binding) {
 		int bkt;
+		struct hlist_node *tmp;
 
-		down_write(&sessions_table_lock);
-		hash_for_each(sessions_table, bkt, sess, hlist) {
-			if (!ksmbd_chann_del(conn, sess)) {
-				up_write(&sessions_table_lock);
-				goto sess_destroy;
+		hash_for_each_safe(sessions_table, bkt, tmp, sess, hlist) {
+			if (!ksmbd_chann_del(conn, sess) &&
+			    xa_empty(&sess->ksmbd_chann_list)) {
+				hash_del(&sess->hlist);
+				ksmbd_session_destroy(sess);
 			}
 		}
-		up_write(&sessions_table_lock);
-	} else {
-		unsigned long id;
-
-		xa_for_each(&conn->sessions, id, sess) {
-			if (!ksmbd_chann_del(conn, sess))
-				goto sess_destroy;
-		}
 	}
 
-	return;
+	xa_for_each(&conn->sessions, id, sess) {
+		unsigned long chann_id;
+		struct channel *chann;
+
+		xa_for_each(&sess->ksmbd_chann_list, chann_id, chann) {
+			if (chann->conn != conn)
+				ksmbd_conn_set_exiting(chann->conn);
+		}
 
-sess_destroy:
-	if (list_empty(&sess->ksmbd_chann_list)) {
-		xa_erase(&conn->sessions, sess->id);
-		ksmbd_session_destroy(sess);
+		ksmbd_chann_del(conn, sess);
+		if (xa_empty(&sess->ksmbd_chann_list)) {
+			xa_erase(&conn->sessions, sess->id);
+			hash_del(&sess->hlist);
+			ksmbd_session_destroy(sess);
+		}
 	}
+	up_write(&sessions_table_lock);
 }
 
 struct ksmbd_session *ksmbd_session_lookup(struct ksmbd_conn *conn,
 					   unsigned long long id)
 {
-	return xa_load(&conn->sessions, id);
+	struct ksmbd_session *sess;
+
+	sess = xa_load(&conn->sessions, id);
+	if (sess)
+		sess->last_active = jiffies;
+	return sess;
 }
 
 struct ksmbd_session *ksmbd_session_lookup_slowpath(unsigned long long id)
@@ -252,6 +273,8 @@ struct ksmbd_session *ksmbd_session_lookup_slowpath(unsigned long long id)
 
 	down_read(&sessions_table_lock);
 	sess = __session_lookup(id);
+	if (sess)
+		sess->last_active = jiffies;
 	up_read(&sessions_table_lock);
 
 	return sess;
@@ -320,6 +343,9 @@ static struct ksmbd_session *__session_create(int protocol)
 	struct ksmbd_session *sess;
 	int ret;
 
+	if (protocol != CIFDS_SESSION_FLAG_SMB2)
+		return NULL;
+
 	sess = kzalloc(sizeof(struct ksmbd_session), GFP_KERNEL);
 	if (!sess)
 		return NULL;
@@ -327,32 +353,24 @@ static struct ksmbd_session *__session_create(int protocol)
 	if (ksmbd_init_file_table(&sess->file_table))
 		goto error;
 
+	sess->last_active = jiffies;
+	sess->state = SMB2_SESSION_IN_PROGRESS;
 	set_session_flag(sess, protocol);
 	xa_init(&sess->tree_conns);
-	INIT_LIST_HEAD(&sess->ksmbd_chann_list);
+	xa_init(&sess->ksmbd_chann_list);
 	INIT_LIST_HEAD(&sess->rpc_handle_list);
 	sess->sequence_number = 1;
-	rwlock_init(&sess->chann_lock);
-
-	switch (protocol) {
-	case CIFDS_SESSION_FLAG_SMB2:
-		ret = __init_smb2_session(sess);
-		break;
-	default:
-		ret = -EINVAL;
-		break;
-	}
 
+	ret = __init_smb2_session(sess);
 	if (ret)
 		goto error;
 
 	ida_init(&sess->tree_conn_ida);
 
-	if (protocol == CIFDS_SESSION_FLAG_SMB2) {
-		down_write(&sessions_table_lock);
-		hash_add(sessions_table, &sess->hlist, sess->id);
-		up_write(&sessions_table_lock);
-	}
+	down_write(&sessions_table_lock);
+	hash_add(sessions_table, &sess->hlist, sess->id);
+	up_write(&sessions_table_lock);
+
 	return sess;
 
 error:
diff --git a/fs/ksmbd/mgmt/user_session.h b/fs/ksmbd/mgmt/user_session.h
index 8934b8ee275b..51f38e5b61ab 100644
--- a/fs/ksmbd/mgmt/user_session.h
+++ b/fs/ksmbd/mgmt/user_session.h
@@ -21,7 +21,6 @@ struct ksmbd_file_table;
 struct channel {
 	__u8			smb3signingkey[SMB3_SIGN_KEY_SIZE];
 	struct ksmbd_conn	*conn;
-	struct list_head	chann_list;
 };
 
 struct preauth_session {
@@ -50,8 +49,7 @@ struct ksmbd_session {
 	char				sess_key[CIFS_KEY_SIZE];
 
 	struct hlist_node		hlist;
-	rwlock_t			chann_lock;
-	struct list_head		ksmbd_chann_list;
+	struct xarray			ksmbd_chann_list;
 	struct xarray			tree_conns;
 	struct ida			tree_conn_ida;
 	struct list_head		rpc_handle_list;
@@ -61,6 +59,7 @@ struct ksmbd_session {
 	__u8				smb3signingkey[SMB3_SIGN_KEY_SIZE];
 
 	struct ksmbd_file_table		file_table;
+	unsigned long			last_active;
 };
 
 static inline int test_session_flag(struct ksmbd_session *sess, int bit)
diff --git a/fs/ksmbd/server.c b/fs/ksmbd/server.c
index cd8a873347a7..dc76d7cf241f 100644
--- a/fs/ksmbd/server.c
+++ b/fs/ksmbd/server.c
@@ -93,7 +93,8 @@ static inline int check_conn_state(struct ksmbd_work *work)
 {
 	struct smb_hdr *rsp_hdr;
 
-	if (ksmbd_conn_exiting(work) || ksmbd_conn_need_reconnect(work)) {
+	if (ksmbd_conn_exiting(work->conn) ||
+	    ksmbd_conn_need_reconnect(work->conn)) {
 		rsp_hdr = work->response_buf;
 		rsp_hdr->Status.CifsError = STATUS_CONNECTION_DISCONNECTED;
 		return 1;
diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index decaef3592f4..53badff17efa 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -74,14 +74,7 @@ static inline bool check_session_id(struct ksmbd_conn *conn, u64 id)
 
 struct channel *lookup_chann_list(struct ksmbd_session *sess, struct ksmbd_conn *conn)
 {
-	struct channel *chann;
-
-	list_for_each_entry(chann, &sess->ksmbd_chann_list, chann_list) {
-		if (chann->conn == conn)
-			return chann;
-	}
-
-	return NULL;
+	return xa_load(&sess->ksmbd_chann_list, (long)conn);
 }
 
 /**
@@ -254,7 +247,7 @@ int init_smb2_neg_rsp(struct ksmbd_work *work)
 
 	rsp = smb2_get_msg(work->response_buf);
 
-	WARN_ON(ksmbd_conn_good(work));
+	WARN_ON(ksmbd_conn_good(conn));
 
 	rsp->StructureSize = cpu_to_le16(65);
 	ksmbd_debug(SMB, "conn->dialect 0x%x\n", conn->dialect);
@@ -284,7 +277,7 @@ int init_smb2_neg_rsp(struct ksmbd_work *work)
 		rsp->SecurityMode |= SMB2_NEGOTIATE_SIGNING_REQUIRED_LE;
 	conn->use_spnego = true;
 
-	ksmbd_conn_set_need_negotiate(work);
+	ksmbd_conn_set_need_negotiate(conn);
 	return 0;
 }
 
@@ -574,7 +567,7 @@ int smb2_check_user_session(struct ksmbd_work *work)
 	    cmd == SMB2_SESSION_SETUP_HE)
 		return 0;
 
-	if (!ksmbd_conn_good(work))
+	if (!ksmbd_conn_good(conn))
 		return -EINVAL;
 
 	sess_id = le64_to_cpu(req_hdr->SessionId);
@@ -592,6 +585,7 @@ static void destroy_previous_session(struct ksmbd_conn *conn,
 	struct ksmbd_session *prev_sess = ksmbd_session_lookup_slowpath(id);
 	struct ksmbd_user *prev_user;
 	struct channel *chann;
+	long index;
 
 	if (!prev_sess)
 		return;
@@ -605,10 +599,8 @@ static void destroy_previous_session(struct ksmbd_conn *conn,
 		return;
 
 	prev_sess->state = SMB2_SESSION_EXPIRED;
-	write_lock(&prev_sess->chann_lock);
-	list_for_each_entry(chann, &prev_sess->ksmbd_chann_list, chann_list)
-		chann->conn->status = KSMBD_SESS_EXITING;
-	write_unlock(&prev_sess->chann_lock);
+	xa_for_each(&prev_sess->ksmbd_chann_list, index, chann)
+		ksmbd_conn_set_exiting(chann->conn);
 }
 
 /**
@@ -1075,7 +1067,7 @@ int smb2_handle_negotiate(struct ksmbd_work *work)
 
 	ksmbd_debug(SMB, "Received negotiate request\n");
 	conn->need_neg = false;
-	if (ksmbd_conn_good(work)) {
+	if (ksmbd_conn_good(conn)) {
 		pr_err("conn->tcp_status is already in CifsGood State\n");
 		work->send_no_response = 1;
 		return rc;
@@ -1230,7 +1222,7 @@ int smb2_handle_negotiate(struct ksmbd_work *work)
 	}
 
 	conn->srv_sec_mode = le16_to_cpu(rsp->SecurityMode);
-	ksmbd_conn_set_need_negotiate(work);
+	ksmbd_conn_set_need_negotiate(conn);
 
 err_out:
 	if (rc < 0)
@@ -1521,19 +1513,14 @@ static int ntlm_authenticate(struct ksmbd_work *work)
 
 binding_session:
 	if (conn->dialect >= SMB30_PROT_ID) {
-		read_lock(&sess->chann_lock);
 		chann = lookup_chann_list(sess, conn);
-		read_unlock(&sess->chann_lock);
 		if (!chann) {
 			chann = kmalloc(sizeof(struct channel), GFP_KERNEL);
 			if (!chann)
 				return -ENOMEM;
 
 			chann->conn = conn;
-			INIT_LIST_HEAD(&chann->chann_list);
-			write_lock(&sess->chann_lock);
-			list_add(&chann->chann_list, &sess->ksmbd_chann_list);
-			write_unlock(&sess->chann_lock);
+			xa_store(&sess->ksmbd_chann_list, (long)conn, chann, GFP_KERNEL);
 		}
 	}
 
@@ -1608,19 +1595,14 @@ static int krb5_authenticate(struct ksmbd_work *work)
 	}
 
 	if (conn->dialect >= SMB30_PROT_ID) {
-		read_lock(&sess->chann_lock);
 		chann = lookup_chann_list(sess, conn);
-		read_unlock(&sess->chann_lock);
 		if (!chann) {
 			chann = kmalloc(sizeof(struct channel), GFP_KERNEL);
 			if (!chann)
 				return -ENOMEM;
 
 			chann->conn = conn;
-			INIT_LIST_HEAD(&chann->chann_list);
-			write_lock(&sess->chann_lock);
-			list_add(&chann->chann_list, &sess->ksmbd_chann_list);
-			write_unlock(&sess->chann_lock);
+			xa_store(&sess->ksmbd_chann_list, (long)conn, chann, GFP_KERNEL);
 		}
 	}
 
@@ -1663,6 +1645,7 @@ int smb2_sess_setup(struct ksmbd_work *work)
 	rsp->SecurityBufferLength = 0;
 	inc_rfc1001_len(work->response_buf, 9);
 
+	ksmbd_conn_lock(conn);
 	if (!req->hdr.SessionId) {
 		sess = ksmbd_smb2_session_create();
 		if (!sess) {
@@ -1710,6 +1693,12 @@ int smb2_sess_setup(struct ksmbd_work *work)
 			goto out_err;
 		}
 
+		if (ksmbd_conn_need_reconnect(conn)) {
+			rc = -EFAULT;
+			sess = NULL;
+			goto out_err;
+		}
+
 		if (ksmbd_session_lookup(conn, sess_id)) {
 			rc = -EACCES;
 			goto out_err;
@@ -1734,12 +1723,20 @@ int smb2_sess_setup(struct ksmbd_work *work)
 			rc = -ENOENT;
 			goto out_err;
 		}
+
+		if (sess->state == SMB2_SESSION_EXPIRED) {
+			rc = -EFAULT;
+			goto out_err;
+		}
+
+		if (ksmbd_conn_need_reconnect(conn)) {
+			rc = -EFAULT;
+			sess = NULL;
+			goto out_err;
+		}
 	}
 	work->sess = sess;
 
-	if (sess->state == SMB2_SESSION_EXPIRED)
-		sess->state = SMB2_SESSION_IN_PROGRESS;
-
 	negblob_off = le16_to_cpu(req->SecurityBufferOffset);
 	negblob_len = le16_to_cpu(req->SecurityBufferLength);
 	if (negblob_off < offsetof(struct smb2_sess_setup_req, Buffer) ||
@@ -1769,8 +1766,10 @@ int smb2_sess_setup(struct ksmbd_work *work)
 				goto out_err;
 			}
 
-			ksmbd_conn_set_good(work);
-			sess->state = SMB2_SESSION_VALID;
+			if (!ksmbd_conn_need_reconnect(conn)) {
+				ksmbd_conn_set_good(conn);
+				sess->state = SMB2_SESSION_VALID;
+			}
 			kfree(sess->Preauth_HashValue);
 			sess->Preauth_HashValue = NULL;
 		} else if (conn->preferred_auth_mech == KSMBD_AUTH_NTLMSSP) {
@@ -1792,8 +1791,10 @@ int smb2_sess_setup(struct ksmbd_work *work)
 				if (rc)
 					goto out_err;
 
-				ksmbd_conn_set_good(work);
-				sess->state = SMB2_SESSION_VALID;
+				if (!ksmbd_conn_need_reconnect(conn)) {
+					ksmbd_conn_set_good(conn);
+					sess->state = SMB2_SESSION_VALID;
+				}
 				if (conn->binding) {
 					struct preauth_session *preauth_sess;
 
@@ -1861,14 +1862,17 @@ int smb2_sess_setup(struct ksmbd_work *work)
 			if (sess->user && sess->user->flags & KSMBD_USER_FLAG_DELAY_SESSION)
 				try_delay = true;
 
-			xa_erase(&conn->sessions, sess->id);
-			ksmbd_session_destroy(sess);
-			work->sess = NULL;
-			if (try_delay)
+			sess->last_active = jiffies;
+			sess->state = SMB2_SESSION_EXPIRED;
+			if (try_delay) {
+				ksmbd_conn_set_need_reconnect(conn);
 				ssleep(5);
+				ksmbd_conn_set_need_negotiate(conn);
+			}
 		}
 	}
 
+	ksmbd_conn_unlock(conn);
 	return rc;
 }
 
@@ -2093,21 +2097,25 @@ int smb2_session_logoff(struct ksmbd_work *work)
 {
 	struct ksmbd_conn *conn = work->conn;
 	struct smb2_logoff_rsp *rsp = smb2_get_msg(work->response_buf);
-	struct ksmbd_session *sess = work->sess;
+	struct ksmbd_session *sess;
+	struct smb2_logoff_req *req = smb2_get_msg(work->request_buf);
+	u64 sess_id = le64_to_cpu(req->hdr.SessionId);
 
 	rsp->StructureSize = cpu_to_le16(4);
 	inc_rfc1001_len(work->response_buf, 4);
 
 	ksmbd_debug(SMB, "request\n");
 
-	/* setting CifsExiting here may race with start_tcp_sess */
-	ksmbd_conn_set_need_reconnect(work);
+	ksmbd_all_conn_set_status(sess_id, KSMBD_SESS_NEED_RECONNECT);
 	ksmbd_close_session_fds(work);
-	ksmbd_conn_wait_idle(conn);
+	ksmbd_conn_wait_idle(conn, sess_id);
 
+	/*
+	 * Re-lookup session to validate if session is deleted
+	 * while waiting request complete
+	 */
+	sess = ksmbd_session_lookup_all(conn, sess_id);
 	if (ksmbd_tree_conn_session_logoff(sess)) {
-		struct smb2_logoff_req *req = smb2_get_msg(work->request_buf);
-
 		ksmbd_debug(SMB, "Invalid tid %d\n", req->hdr.Id.SyncId.TreeId);
 		rsp->hdr.Status = STATUS_NETWORK_NAME_DELETED;
 		smb2_set_err_rsp(work);
@@ -2119,9 +2127,7 @@ int smb2_session_logoff(struct ksmbd_work *work)
 
 	ksmbd_free_user(sess->user);
 	sess->user = NULL;
-
-	/* let start_tcp_sess free connection info now */
-	ksmbd_conn_set_need_negotiate(work);
+	ksmbd_all_conn_set_status(sess_id, KSMBD_SESS_NEED_NEGOTIATE);
 	return 0;
 }
 
@@ -6953,7 +6959,7 @@ int smb2_lock(struct ksmbd_work *work)
 
 		nolock = 1;
 		/* check locks in connection list */
-		read_lock(&conn_list_lock);
+		down_read(&conn_list_lock);
 		list_for_each_entry(conn, &conn_list, conns_list) {
 			spin_lock(&conn->llist_lock);
 			list_for_each_entry_safe(cmp_lock, tmp2, &conn->lock_list, clist) {
@@ -6970,7 +6976,7 @@ int smb2_lock(struct ksmbd_work *work)
 						list_del(&cmp_lock->flist);
 						list_del(&cmp_lock->clist);
 						spin_unlock(&conn->llist_lock);
-						read_unlock(&conn_list_lock);
+						up_read(&conn_list_lock);
 
 						locks_free_lock(cmp_lock->fl);
 						kfree(cmp_lock);
@@ -6992,7 +6998,7 @@ int smb2_lock(struct ksmbd_work *work)
 				    cmp_lock->start > smb_lock->start &&
 				    cmp_lock->start < smb_lock->end) {
 					spin_unlock(&conn->llist_lock);
-					read_unlock(&conn_list_lock);
+					up_read(&conn_list_lock);
 					pr_err("previous lock conflict with zero byte lock range\n");
 					goto out;
 				}
@@ -7001,7 +7007,7 @@ int smb2_lock(struct ksmbd_work *work)
 				    smb_lock->start > cmp_lock->start &&
 				    smb_lock->start < cmp_lock->end) {
 					spin_unlock(&conn->llist_lock);
-					read_unlock(&conn_list_lock);
+					up_read(&conn_list_lock);
 					pr_err("current lock conflict with zero byte lock range\n");
 					goto out;
 				}
@@ -7012,14 +7018,14 @@ int smb2_lock(struct ksmbd_work *work)
 				      cmp_lock->end >= smb_lock->end)) &&
 				    !cmp_lock->zero_len && !smb_lock->zero_len) {
 					spin_unlock(&conn->llist_lock);
-					read_unlock(&conn_list_lock);
+					up_read(&conn_list_lock);
 					pr_err("Not allow lock operation on exclusive lock range\n");
 					goto out;
 				}
 			}
 			spin_unlock(&conn->llist_lock);
 		}
-		read_unlock(&conn_list_lock);
+		up_read(&conn_list_lock);
 out_check_cl:
 		if (smb_lock->fl->fl_type == F_UNLCK && nolock) {
 			pr_err("Try to unlock nolocked range\n");
@@ -8434,14 +8440,11 @@ int smb3_check_sign_req(struct ksmbd_work *work)
 	if (le16_to_cpu(hdr->Command) == SMB2_SESSION_SETUP_HE) {
 		signing_key = work->sess->smb3signingkey;
 	} else {
-		read_lock(&work->sess->chann_lock);
 		chann = lookup_chann_list(work->sess, conn);
 		if (!chann) {
-			read_unlock(&work->sess->chann_lock);
 			return 0;
 		}
 		signing_key = chann->smb3signingkey;
-		read_unlock(&work->sess->chann_lock);
 	}
 
 	if (!signing_key) {
@@ -8501,14 +8504,11 @@ void smb3_set_sign_rsp(struct ksmbd_work *work)
 	    le16_to_cpu(hdr->Command) == SMB2_SESSION_SETUP_HE) {
 		signing_key = work->sess->smb3signingkey;
 	} else {
-		read_lock(&work->sess->chann_lock);
 		chann = lookup_chann_list(work->sess, work->conn);
 		if (!chann) {
-			read_unlock(&work->sess->chann_lock);
 			return;
 		}
 		signing_key = chann->smb3signingkey;
-		read_unlock(&work->sess->chann_lock);
 	}
 
 	if (!signing_key)
diff --git a/fs/ksmbd/smb2pdu.h b/fs/ksmbd/smb2pdu.h
index 0c8a770fe318..df05c9b2504d 100644
--- a/fs/ksmbd/smb2pdu.h
+++ b/fs/ksmbd/smb2pdu.h
@@ -61,6 +61,8 @@ struct preauth_integrity_info {
 #define SMB2_SESSION_IN_PROGRESS	BIT(0)
 #define SMB2_SESSION_VALID		BIT(1)
 
+#define SMB2_SESSION_TIMEOUT		(10 * HZ)
+
 struct create_durable_req_v2 {
 	struct create_context ccontext;
 	__u8   Name[8];
diff --git a/fs/ksmbd/transport_tcp.c b/fs/ksmbd/transport_tcp.c
index 20e85e2701f2..eff7a1d793f0 100644
--- a/fs/ksmbd/transport_tcp.c
+++ b/fs/ksmbd/transport_tcp.c
@@ -333,7 +333,7 @@ static int ksmbd_tcp_readv(struct tcp_transport *t, struct kvec *iov_orig,
 		if (length == -EINTR) {
 			total_read = -ESHUTDOWN;
 			break;
-		} else if (conn->status == KSMBD_SESS_NEED_RECONNECT) {
+		} else if (ksmbd_conn_need_reconnect(conn)) {
 			total_read = -EAGAIN;
 			break;
 		} else if (length == -ERESTARTSYS || length == -EAGAIN) {
diff --git a/fs/notify/inotify/inotify_fsnotify.c b/fs/notify/inotify/inotify_fsnotify.c
index 49cfe2ae6d23..993375f0db67 100644
--- a/fs/notify/inotify/inotify_fsnotify.c
+++ b/fs/notify/inotify/inotify_fsnotify.c
@@ -65,7 +65,7 @@ int inotify_handle_inode_event(struct fsnotify_mark *inode_mark, u32 mask,
 	struct fsnotify_event *fsn_event;
 	struct fsnotify_group *group = inode_mark->group;
 	int ret;
-	int len = 0;
+	int len = 0, wd;
 	int alloc_len = sizeof(struct inotify_event_info);
 	struct mem_cgroup *old_memcg;
 
@@ -80,6 +80,13 @@ int inotify_handle_inode_event(struct fsnotify_mark *inode_mark, u32 mask,
 	i_mark = container_of(inode_mark, struct inotify_inode_mark,
 			      fsn_mark);
 
+	/*
+	 * We can be racing with mark being detached. Don't report event with
+	 * invalid wd.
+	 */
+	wd = READ_ONCE(i_mark->wd);
+	if (wd == -1)
+		return 0;
 	/*
 	 * Whoever is interested in the event, pays for the allocation. Do not
 	 * trigger OOM killer in the target monitoring memcg as it may have
@@ -110,7 +117,7 @@ int inotify_handle_inode_event(struct fsnotify_mark *inode_mark, u32 mask,
 	fsn_event = &event->fse;
 	fsnotify_init_event(fsn_event);
 	event->mask = mask;
-	event->wd = i_mark->wd;
+	event->wd = wd;
 	event->sync_cookie = cookie;
 	event->name_len = len;
 	if (len)
diff --git a/fs/ntfs3/bitmap.c b/fs/ntfs3/bitmap.c
index 723fb64e6531..393c726ef17a 100644
--- a/fs/ntfs3/bitmap.c
+++ b/fs/ntfs3/bitmap.c
@@ -658,7 +658,8 @@ int wnd_init(struct wnd_bitmap *wnd, struct super_block *sb, size_t nbits)
 	if (!wnd->bits_last)
 		wnd->bits_last = wbits;
 
-	wnd->free_bits = kcalloc(wnd->nwnd, sizeof(u16), GFP_NOFS | __GFP_NOWARN);
+	wnd->free_bits =
+		kcalloc(wnd->nwnd, sizeof(u16), GFP_NOFS | __GFP_NOWARN);
 	if (!wnd->free_bits)
 		return -ENOMEM;
 
diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
index f1df52dfab74..7d0473da12c3 100644
--- a/fs/ntfs3/frecord.c
+++ b/fs/ntfs3/frecord.c
@@ -1645,7 +1645,7 @@ struct ATTR_FILE_NAME *ni_fname_name(struct ntfs_inode *ni,
 {
 	struct ATTRIB *attr = NULL;
 	struct ATTR_FILE_NAME *fname;
-       struct le_str *fns;
+	struct le_str *fns;
 
 	if (le)
 		*le = NULL;
diff --git a/fs/ntfs3/fsntfs.c b/fs/ntfs3/fsntfs.c
index 567563771bf8..24c9aeb5a49e 100644
--- a/fs/ntfs3/fsntfs.c
+++ b/fs/ntfs3/fsntfs.c
@@ -2594,8 +2594,10 @@ static inline bool is_reserved_name(struct ntfs_sb_info *sbi,
 	if (len == 4 || (len > 4 && le16_to_cpu(name[4]) == '.')) {
 		port_digit = le16_to_cpu(name[3]);
 		if (port_digit >= '1' && port_digit <= '9')
-			if (!ntfs_cmp_names(name, 3, COM_NAME, 3, upcase, false) ||
-			    !ntfs_cmp_names(name, 3, LPT_NAME, 3, upcase, false))
+			if (!ntfs_cmp_names(name, 3, COM_NAME, 3, upcase,
+					    false) ||
+			    !ntfs_cmp_names(name, 3, LPT_NAME, 3, upcase,
+					    false))
 				return true;
 	}
 
diff --git a/fs/ntfs3/namei.c b/fs/ntfs3/namei.c
index c8db35e2ae17..53ddea219e37 100644
--- a/fs/ntfs3/namei.c
+++ b/fs/ntfs3/namei.c
@@ -88,6 +88,16 @@ static struct dentry *ntfs_lookup(struct inode *dir, struct dentry *dentry,
 		__putname(uni);
 	}
 
+	/*
+	 * Check for a null pointer
+	 * If the MFT record of ntfs inode is not a base record, inode->i_op can be NULL.
+	 * This causes null pointer dereference in d_splice_alias().
+	 */
+	if (!IS_ERR_OR_NULL(inode) && !inode->i_op) {
+		iput(inode);
+		inode = ERR_PTR(-EINVAL);
+	}
+
 	return d_splice_alias(inode, dentry);
 }
 
diff --git a/fs/ntfs3/ntfs.h b/fs/ntfs3/ntfs.h
index 86ea1826d099..90151e56c122 100644
--- a/fs/ntfs3/ntfs.h
+++ b/fs/ntfs3/ntfs.h
@@ -435,9 +435,6 @@ static inline u64 attr_svcn(const struct ATTRIB *attr)
 	return attr->non_res ? le64_to_cpu(attr->nres.svcn) : 0;
 }
 
-/* The size of resident attribute by its resident size. */
-#define BYTES_PER_RESIDENT(b) (0x18 + (b))
-
 static_assert(sizeof(struct ATTRIB) == 0x48);
 static_assert(sizeof(((struct ATTRIB *)NULL)->res) == 0x08);
 static_assert(sizeof(((struct ATTRIB *)NULL)->nres) == 0x38);
diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index 436025e0f77a..d20b3e5f64d0 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -1287,7 +1287,10 @@ static int insert_links(struct ctl_table_header *head)
  * __register_sysctl_table - register a leaf sysctl table
  * @set: Sysctl tree to register on
  * @path: The path to the directory the sysctl table is in.
- * @table: the top-level table structure
+ * @table: the top-level table structure without any child. This table
+ * 	 should not be free'd after registration. So it should not be
+ * 	 used on stack. It can either be a global or dynamically allocated
+ * 	 by the caller and free'd later after sysctl unregistration.
  *
  * Register a sysctl table hierarchy. @table should be a filled in ctl_table
  * array. A completely 0 filled entry terminates the table.
@@ -1308,9 +1311,12 @@ static int insert_links(struct ctl_table_header *head)
  * proc_handler - the text handler routine (described below)
  *
  * extra1, extra2 - extra pointers usable by the proc handler routines
+ * XXX: we should eventually modify these to use long min / max [0]
+ * [0] https://lkml.kernel.org/87zgpte9o4.fsf@email.froward.int.ebiederm.org
  *
  * Leaf nodes in the sysctl tree will be represented by a single file
- * under /proc; non-leaf nodes will be represented by directories.
+ * under /proc; non-leaf nodes (where child is not NULL) are not allowed,
+ * sysctl_check_table() verifies this.
  *
  * There must be a proc_handler routine for any terminal nodes.
  * Several default handlers are available to cover common cases -
@@ -1352,7 +1358,7 @@ struct ctl_table_header *__register_sysctl_table(
 
 	spin_lock(&sysctl_lock);
 	dir = &set->dir;
-	/* Reference moved down the diretory tree get_subdir */
+	/* Reference moved down the directory tree get_subdir */
 	dir->header.nreg++;
 	spin_unlock(&sysctl_lock);
 
@@ -1369,6 +1375,11 @@ struct ctl_table_header *__register_sysctl_table(
 		if (namelen == 0)
 			continue;
 
+		/*
+		 * namelen ensures if name is "foo/bar/yay" only foo is
+		 * registered first. We traverse as if using mkdir -p and
+		 * return a ctl_dir for the last directory entry.
+		 */
 		dir = get_subdir(dir, name, namelen);
 		if (IS_ERR(dir))
 			goto fail;
@@ -1394,8 +1405,15 @@ struct ctl_table_header *__register_sysctl_table(
 
 /**
  * register_sysctl - register a sysctl table
- * @path: The path to the directory the sysctl table is in.
- * @table: the table structure
+ * @path: The path to the directory the sysctl table is in. If the path
+ * 	doesn't exist we will create it for you.
+ * @table: the table structure. The calller must ensure the life of the @table
+ * 	will be kept during the lifetime use of the syctl. It must not be freed
+ * 	until unregister_sysctl_table() is called with the given returned table
+ * 	with this registration. If your code is non modular then you don't need
+ * 	to call unregister_sysctl_table() and can instead use something like
+ * 	register_sysctl_init() which does not care for the result of the syctl
+ * 	registration.
  *
  * Register a sysctl table. @table should be a filled in ctl_table
  * array. A completely 0 filled entry terminates the table.
@@ -1411,8 +1429,11 @@ EXPORT_SYMBOL(register_sysctl);
 
 /**
  * __register_sysctl_init() - register sysctl table to path
- * @path: path name for sysctl base
- * @table: This is the sysctl table that needs to be registered to the path
+ * @path: path name for sysctl base. If that path doesn't exist we will create
+ * 	it for you.
+ * @table: This is the sysctl table that needs to be registered to the path.
+ * 	The caller must ensure the life of the @table will be kept during the
+ * 	lifetime use of the sysctl.
  * @table_name: The name of sysctl table, only used for log printing when
  *              registration fails
  *
@@ -1424,10 +1445,7 @@ EXPORT_SYMBOL(register_sysctl);
  * register_sysctl() failing on init are extremely low, and so for both reasons
  * this function does not return any error as it is used by initialization code.
  *
- * Context: Can only be called after your respective sysctl base path has been
- * registered. So for instance, most base directories are registered early on
- * init before init levels are processed through proc_sys_init() and
- * sysctl_init_bases().
+ * Context: if your base directory does not exist it will be created for you.
  */
 void __init __register_sysctl_init(const char *path, struct ctl_table *table,
 				 const char *table_name)
@@ -1557,6 +1575,7 @@ static int register_leaf_sysctl_tables(const char *path, char *pos,
  *
  * Register a sysctl table hierarchy. @table should be a filled in ctl_table
  * array. A completely 0 filled entry terminates the table.
+ * We are slowly deprecating this call so avoid its use.
  *
  * See __register_sysctl_table for more details.
  */
@@ -1628,6 +1647,7 @@ struct ctl_table_header *__register_sysctl_paths(
  *
  * Register a sysctl table hierarchy. @table should be a filled in ctl_table
  * array. A completely 0 filled entry terminates the table.
+ * We are slowly deprecating this caller so avoid future uses of it.
  *
  * See __register_sysctl_paths for more details.
  */
diff --git a/include/crypto/algapi.h b/include/crypto/algapi.h
index 61b327206b55..1fd81e74a174 100644
--- a/include/crypto/algapi.h
+++ b/include/crypto/algapi.h
@@ -302,4 +302,11 @@ enum {
 	CRYPTO_MSG_ALG_LOADED,
 };
 
+static inline void crypto_request_complete(struct crypto_async_request *req,
+					   int err)
+{
+	crypto_completion_t complete = req->complete;
+	complete(req, err);
+}
+
 #endif	/* _CRYPTO_ALGAPI_H */
diff --git a/include/drm/display/drm_dp.h b/include/drm/display/drm_dp.h
index e934aab357be..05f2cc03d03d 100644
--- a/include/drm/display/drm_dp.h
+++ b/include/drm/display/drm_dp.h
@@ -240,6 +240,8 @@
 #define DP_DSC_SUPPORT                      0x060   /* DP 1.4 */
 # define DP_DSC_DECOMPRESSION_IS_SUPPORTED  (1 << 0)
 # define DP_DSC_PASSTHROUGH_IS_SUPPORTED    (1 << 1)
+# define DP_DSC_DYNAMIC_PPS_UPDATE_SUPPORT_COMP_TO_COMP    (1 << 2)
+# define DP_DSC_DYNAMIC_PPS_UPDATE_SUPPORT_UNCOMP_TO_COMP  (1 << 3)
 
 #define DP_DSC_REV                          0x061
 # define DP_DSC_MAJOR_MASK                  (0xf << 0)
@@ -278,12 +280,14 @@
 
 #define DP_DSC_BLK_PREDICTION_SUPPORT       0x066
 # define DP_DSC_BLK_PREDICTION_IS_SUPPORTED (1 << 0)
+# define DP_DSC_RGB_COLOR_CONV_BYPASS_SUPPORT (1 << 1)
 
 #define DP_DSC_MAX_BITS_PER_PIXEL_LOW       0x067   /* eDP 1.4 */
 
 #define DP_DSC_MAX_BITS_PER_PIXEL_HI        0x068   /* eDP 1.4 */
 # define DP_DSC_MAX_BITS_PER_PIXEL_HI_MASK  (0x3 << 0)
-# define DP_DSC_MAX_BITS_PER_PIXEL_HI_SHIFT 8
+# define DP_DSC_MAX_BPP_DELTA_VERSION_MASK  (0x3 << 5)	/* eDP 1.5 & DP 2.0 */
+# define DP_DSC_MAX_BPP_DELTA_AVAILABILITY  (1 << 7)	/* eDP 1.5 & DP 2.0 */
 
 #define DP_DSC_DEC_COLOR_FORMAT_CAP         0x069
 # define DP_DSC_RGB                         (1 << 0)
@@ -345,11 +349,13 @@
 # define DP_DSC_24_PER_DP_DSC_SINK          (1 << 2)
 
 #define DP_DSC_BITS_PER_PIXEL_INC           0x06F
+# define DP_DSC_RGB_YCbCr444_MAX_BPP_DELTA_MASK 0x1f
+# define DP_DSC_RGB_YCbCr420_MAX_BPP_DELTA_MASK 0xe0
 # define DP_DSC_BITS_PER_PIXEL_1_16         0x0
 # define DP_DSC_BITS_PER_PIXEL_1_8          0x1
 # define DP_DSC_BITS_PER_PIXEL_1_4          0x2
 # define DP_DSC_BITS_PER_PIXEL_1_2          0x3
-# define DP_DSC_BITS_PER_PIXEL_1            0x4
+# define DP_DSC_BITS_PER_PIXEL_1_1          0x4
 
 #define DP_PSR_SUPPORT                      0x070   /* XXX 1.2? */
 # define DP_PSR_IS_SUPPORTED                1
diff --git a/include/drm/display/drm_dp_helper.h b/include/drm/display/drm_dp_helper.h
index ab55453f2d2c..ade9df59e156 100644
--- a/include/drm/display/drm_dp_helper.h
+++ b/include/drm/display/drm_dp_helper.h
@@ -181,9 +181,8 @@ static inline u16
 drm_edp_dsc_sink_output_bpp(const u8 dsc_dpcd[DP_DSC_RECEIVER_CAP_SIZE])
 {
 	return dsc_dpcd[DP_DSC_MAX_BITS_PER_PIXEL_LOW - DP_DSC_SUPPORT] |
-		(dsc_dpcd[DP_DSC_MAX_BITS_PER_PIXEL_HI - DP_DSC_SUPPORT] &
-		 DP_DSC_MAX_BITS_PER_PIXEL_HI_MASK <<
-		 DP_DSC_MAX_BITS_PER_PIXEL_HI_SHIFT);
+		((dsc_dpcd[DP_DSC_MAX_BITS_PER_PIXEL_HI - DP_DSC_SUPPORT] &
+		  DP_DSC_MAX_BITS_PER_PIXEL_HI_MASK) << 8);
 }
 
 static inline u32
diff --git a/include/linux/crypto.h b/include/linux/crypto.h
index 5d1e961f810e..b18f6e669fb1 100644
--- a/include/linux/crypto.h
+++ b/include/linux/crypto.h
@@ -176,6 +176,7 @@ struct crypto_async_request;
 struct crypto_tfm;
 struct crypto_type;
 
+typedef struct crypto_async_request crypto_completion_data_t;
 typedef void (*crypto_completion_t)(struct crypto_async_request *req, int err);
 
 /**
@@ -595,6 +596,11 @@ struct crypto_wait {
 /*
  * Async ops completion helper functioons
  */
+static inline void *crypto_get_completion_data(crypto_completion_data_t *req)
+{
+	return req->data;
+}
+
 void crypto_req_done(struct crypto_async_request *req, int err);
 
 static inline int crypto_wait_req(int err, struct crypto_wait *wait)
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 45c3d62e616d..95f33dadb2be 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -567,6 +567,7 @@
 #define PCI_DEVICE_ID_AMD_19H_M50H_DF_F3 0x166d
 #define PCI_DEVICE_ID_AMD_19H_M60H_DF_F3 0x14e3
 #define PCI_DEVICE_ID_AMD_19H_M70H_DF_F3 0x14f3
+#define PCI_DEVICE_ID_AMD_19H_M78H_DF_F3 0x12fb
 #define PCI_DEVICE_ID_AMD_CNB17H_F3	0x1703
 #define PCI_DEVICE_ID_AMD_LANCE		0x2000
 #define PCI_DEVICE_ID_AMD_LANCE_HOME	0x2001
diff --git a/include/net/af_rxrpc.h b/include/net/af_rxrpc.h
index ba717eac0229..73644bd42a3f 100644
--- a/include/net/af_rxrpc.h
+++ b/include/net/af_rxrpc.h
@@ -40,16 +40,17 @@ typedef void (*rxrpc_user_attach_call_t)(struct rxrpc_call *, unsigned long);
 void rxrpc_kernel_new_call_notification(struct socket *,
 					rxrpc_notify_new_call_t,
 					rxrpc_discard_new_call_t);
-struct rxrpc_call *rxrpc_kernel_begin_call(struct socket *,
-					   struct sockaddr_rxrpc *,
-					   struct key *,
-					   unsigned long,
-					   s64,
-					   gfp_t,
-					   rxrpc_notify_rx_t,
-					   bool,
-					   enum rxrpc_interruptibility,
-					   unsigned int);
+struct rxrpc_call *rxrpc_kernel_begin_call(struct socket *sock,
+					   struct sockaddr_rxrpc *srx,
+					   struct key *key,
+					   unsigned long user_call_ID,
+					   s64 tx_total_len,
+					   u32 hard_timeout,
+					   gfp_t gfp,
+					   rxrpc_notify_rx_t notify_rx,
+					   bool upgrade,
+					   enum rxrpc_interruptibility interruptibility,
+					   unsigned int debug_id);
 int rxrpc_kernel_send_data(struct socket *, struct rxrpc_call *,
 			   struct msghdr *, size_t,
 			   rxrpc_notify_end_tx_t);
diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index 84d5b649b95f..92d8e2c4edda 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -1251,7 +1251,7 @@ static struct rw_semaphore *rwsem_downgrade_wake(struct rw_semaphore *sem)
 /*
  * lock for reading
  */
-static inline int __down_read_common(struct rw_semaphore *sem, int state)
+static __always_inline int __down_read_common(struct rw_semaphore *sem, int state)
 {
 	int ret = 0;
 	long count;
@@ -1269,17 +1269,17 @@ static inline int __down_read_common(struct rw_semaphore *sem, int state)
 	return ret;
 }
 
-static inline void __down_read(struct rw_semaphore *sem)
+static __always_inline void __down_read(struct rw_semaphore *sem)
 {
 	__down_read_common(sem, TASK_UNINTERRUPTIBLE);
 }
 
-static inline int __down_read_interruptible(struct rw_semaphore *sem)
+static __always_inline int __down_read_interruptible(struct rw_semaphore *sem)
 {
 	return __down_read_common(sem, TASK_INTERRUPTIBLE);
 }
 
-static inline int __down_read_killable(struct rw_semaphore *sem)
+static __always_inline int __down_read_killable(struct rw_semaphore *sem)
 {
 	return __down_read_common(sem, TASK_KILLABLE);
 }
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 6f5ef18a8b77..ef3dd8f120e0 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -1608,7 +1608,7 @@ int skb_copy_ubufs(struct sk_buff *skb, gfp_t gfp_mask)
 {
 	int num_frags = skb_shinfo(skb)->nr_frags;
 	struct page *page, *head = NULL;
-	int i, new_frags;
+	int i, order, psize, new_frags;
 	u32 d_off;
 
 	if (skb_shared(skb) || skb_unclone(skb, gfp_mask))
@@ -1617,9 +1617,17 @@ int skb_copy_ubufs(struct sk_buff *skb, gfp_t gfp_mask)
 	if (!num_frags)
 		goto release;
 
-	new_frags = (__skb_pagelen(skb) + PAGE_SIZE - 1) >> PAGE_SHIFT;
+	/* We might have to allocate high order pages, so compute what minimum
+	 * page order is needed.
+	 */
+	order = 0;
+	while ((PAGE_SIZE << order) * MAX_SKB_FRAGS < __skb_pagelen(skb))
+		order++;
+	psize = (PAGE_SIZE << order);
+
+	new_frags = (__skb_pagelen(skb) + psize - 1) >> (PAGE_SHIFT + order);
 	for (i = 0; i < new_frags; i++) {
-		page = alloc_page(gfp_mask);
+		page = alloc_pages(gfp_mask | __GFP_COMP, order);
 		if (!page) {
 			while (head) {
 				struct page *next = (struct page *)page_private(head);
@@ -1646,11 +1654,11 @@ int skb_copy_ubufs(struct sk_buff *skb, gfp_t gfp_mask)
 			vaddr = kmap_atomic(p);
 
 			while (done < p_len) {
-				if (d_off == PAGE_SIZE) {
+				if (d_off == psize) {
 					d_off = 0;
 					page = (struct page *)page_private(page);
 				}
-				copy = min_t(u32, PAGE_SIZE - d_off, p_len - done);
+				copy = min_t(u32, psize - d_off, p_len - done);
 				memcpy(page_address(page) + d_off,
 				       vaddr + p_off + done, copy);
 				done += copy;
@@ -1666,7 +1674,7 @@ int skb_copy_ubufs(struct sk_buff *skb, gfp_t gfp_mask)
 
 	/* skb frags point to kernel buffers */
 	for (i = 0; i < new_frags - 1; i++) {
-		__skb_fill_page_desc(skb, i, head, 0, PAGE_SIZE);
+		__skb_fill_page_desc(skb, i, head, 0, psize);
 		head = (struct page *)page_private(head);
 	}
 	__skb_fill_page_desc(skb, new_frags - 1, head, 0, d_off);
diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index 646b3e490c71..f0c646a17700 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -573,8 +573,8 @@ static int ethtool_get_link_ksettings(struct net_device *dev,
 static int ethtool_set_link_ksettings(struct net_device *dev,
 				      void __user *useraddr)
 {
+	struct ethtool_link_ksettings link_ksettings = {};
 	int err;
-	struct ethtool_link_ksettings link_ksettings;
 
 	ASSERT_RTNL();
 
diff --git a/net/ipv6/sit.c b/net/ipv6/sit.c
index 70d81bba5093..3ffb6a5b1f82 100644
--- a/net/ipv6/sit.c
+++ b/net/ipv6/sit.c
@@ -1095,12 +1095,13 @@ static netdev_tx_t sit_tunnel_xmit(struct sk_buff *skb,
 
 static void ipip6_tunnel_bind_dev(struct net_device *dev)
 {
+	struct ip_tunnel *tunnel = netdev_priv(dev);
+	int t_hlen = tunnel->hlen + sizeof(struct iphdr);
 	struct net_device *tdev = NULL;
-	struct ip_tunnel *tunnel;
+	int hlen = LL_MAX_HEADER;
 	const struct iphdr *iph;
 	struct flowi4 fl4;
 
-	tunnel = netdev_priv(dev);
 	iph = &tunnel->parms.iph;
 
 	if (iph->daddr) {
@@ -1123,14 +1124,15 @@ static void ipip6_tunnel_bind_dev(struct net_device *dev)
 		tdev = __dev_get_by_index(tunnel->net, tunnel->parms.link);
 
 	if (tdev && !netif_is_l3_master(tdev)) {
-		int t_hlen = tunnel->hlen + sizeof(struct iphdr);
 		int mtu;
 
 		mtu = tdev->mtu - t_hlen;
 		if (mtu < IPV6_MIN_MTU)
 			mtu = IPV6_MIN_MTU;
 		WRITE_ONCE(dev->mtu, mtu);
+		hlen = tdev->hard_header_len + tdev->needed_headroom;
 	}
+	dev->needed_headroom = t_hlen + hlen;
 }
 
 static void ipip6_tunnel_update(struct ip_tunnel *t, struct ip_tunnel_parm *p,
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index e4da7267ed4b..e0706c33e547 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1064,7 +1064,7 @@ static void tcp_v6_send_reset(const struct sock *sk, struct sk_buff *skb)
 			if (np->repflow)
 				label = ip6_flowlabel(ipv6h);
 			priority = sk->sk_priority;
-			txhash = sk->sk_hash;
+			txhash = sk->sk_txhash;
 		}
 		if (sk->sk_state == TCP_TIME_WAIT) {
 			label = cpu_to_be32(inet_twsk(sk)->tw_flowlabel);
diff --git a/net/ncsi/ncsi-aen.c b/net/ncsi/ncsi-aen.c
index b635c194f0a8..62fb1031763d 100644
--- a/net/ncsi/ncsi-aen.c
+++ b/net/ncsi/ncsi-aen.c
@@ -165,6 +165,7 @@ static int ncsi_aen_handler_cr(struct ncsi_dev_priv *ndp,
 	nc->state = NCSI_CHANNEL_INACTIVE;
 	list_add_tail_rcu(&nc->link, &ndp->channel_queue);
 	spin_unlock_irqrestore(&ndp->lock, flags);
+	nc->modes[NCSI_MODE_TX_ENABLE].enable = 0;
 
 	return ncsi_process_next_channel(ndp);
 }
diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 96bc4b8ded42..d64478af0129 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -1951,7 +1951,8 @@ static struct nft_hook *nft_hook_list_find(struct list_head *hook_list,
 
 static int nf_tables_parse_netdev_hooks(struct net *net,
 					const struct nlattr *attr,
-					struct list_head *hook_list)
+					struct list_head *hook_list,
+					struct netlink_ext_ack *extack)
 {
 	struct nft_hook *hook, *next;
 	const struct nlattr *tmp;
@@ -1965,10 +1966,12 @@ static int nf_tables_parse_netdev_hooks(struct net *net,
 
 		hook = nft_netdev_hook_alloc(net, tmp);
 		if (IS_ERR(hook)) {
+			NL_SET_BAD_ATTR(extack, tmp);
 			err = PTR_ERR(hook);
 			goto err_hook;
 		}
 		if (nft_hook_list_find(hook_list, hook)) {
+			NL_SET_BAD_ATTR(extack, tmp);
 			kfree(hook);
 			err = -EEXIST;
 			goto err_hook;
@@ -2001,20 +2004,23 @@ struct nft_chain_hook {
 
 static int nft_chain_parse_netdev(struct net *net,
 				  struct nlattr *tb[],
-				  struct list_head *hook_list)
+				  struct list_head *hook_list,
+				  struct netlink_ext_ack *extack)
 {
 	struct nft_hook *hook;
 	int err;
 
 	if (tb[NFTA_HOOK_DEV]) {
 		hook = nft_netdev_hook_alloc(net, tb[NFTA_HOOK_DEV]);
-		if (IS_ERR(hook))
+		if (IS_ERR(hook)) {
+			NL_SET_BAD_ATTR(extack, tb[NFTA_HOOK_DEV]);
 			return PTR_ERR(hook);
+		}
 
 		list_add_tail(&hook->list, hook_list);
 	} else if (tb[NFTA_HOOK_DEVS]) {
 		err = nf_tables_parse_netdev_hooks(net, tb[NFTA_HOOK_DEVS],
-						   hook_list);
+						   hook_list, extack);
 		if (err < 0)
 			return err;
 
@@ -2047,8 +2053,10 @@ static int nft_chain_parse_hook(struct net *net,
 		return err;
 
 	if (ha[NFTA_HOOK_HOOKNUM] == NULL ||
-	    ha[NFTA_HOOK_PRIORITY] == NULL)
-		return -EINVAL;
+	    ha[NFTA_HOOK_PRIORITY] == NULL) {
+		NL_SET_BAD_ATTR(extack, nla[NFTA_CHAIN_NAME]);
+		return -ENOENT;
+	}
 
 	hook->num = ntohl(nla_get_be32(ha[NFTA_HOOK_HOOKNUM]));
 	hook->priority = ntohl(nla_get_be32(ha[NFTA_HOOK_PRIORITY]));
@@ -2082,7 +2090,7 @@ static int nft_chain_parse_hook(struct net *net,
 
 	INIT_LIST_HEAD(&hook->list);
 	if (nft_base_chain_netdev(family, hook->num)) {
-		err = nft_chain_parse_netdev(net, ha, &hook->list);
+		err = nft_chain_parse_netdev(net, ha, &hook->list, extack);
 		if (err < 0) {
 			module_put(type->owner);
 			return err;
@@ -7550,9 +7558,10 @@ static const struct nla_policy nft_flowtable_hook_policy[NFTA_FLOWTABLE_HOOK_MAX
 };
 
 static int nft_flowtable_parse_hook(const struct nft_ctx *ctx,
-				    const struct nlattr *attr,
+				    const struct nlattr * const nla[],
 				    struct nft_flowtable_hook *flowtable_hook,
-				    struct nft_flowtable *flowtable, bool add)
+				    struct nft_flowtable *flowtable,
+				    struct netlink_ext_ack *extack, bool add)
 {
 	struct nlattr *tb[NFTA_FLOWTABLE_HOOK_MAX + 1];
 	struct nft_hook *hook;
@@ -7561,15 +7570,18 @@ static int nft_flowtable_parse_hook(const struct nft_ctx *ctx,
 
 	INIT_LIST_HEAD(&flowtable_hook->list);
 
-	err = nla_parse_nested_deprecated(tb, NFTA_FLOWTABLE_HOOK_MAX, attr,
+	err = nla_parse_nested_deprecated(tb, NFTA_FLOWTABLE_HOOK_MAX,
+					  nla[NFTA_FLOWTABLE_HOOK],
 					  nft_flowtable_hook_policy, NULL);
 	if (err < 0)
 		return err;
 
 	if (add) {
 		if (!tb[NFTA_FLOWTABLE_HOOK_NUM] ||
-		    !tb[NFTA_FLOWTABLE_HOOK_PRIORITY])
-			return -EINVAL;
+		    !tb[NFTA_FLOWTABLE_HOOK_PRIORITY]) {
+			NL_SET_BAD_ATTR(extack, nla[NFTA_FLOWTABLE_NAME]);
+			return -ENOENT;
+		}
 
 		hooknum = ntohl(nla_get_be32(tb[NFTA_FLOWTABLE_HOOK_NUM]));
 		if (hooknum != NF_NETDEV_INGRESS)
@@ -7599,7 +7611,8 @@ static int nft_flowtable_parse_hook(const struct nft_ctx *ctx,
 	if (tb[NFTA_FLOWTABLE_HOOK_DEVS]) {
 		err = nf_tables_parse_netdev_hooks(ctx->net,
 						   tb[NFTA_FLOWTABLE_HOOK_DEVS],
-						   &flowtable_hook->list);
+						   &flowtable_hook->list,
+						   extack);
 		if (err < 0)
 			return err;
 	}
@@ -7731,7 +7744,7 @@ static int nft_register_flowtable_net_hooks(struct net *net,
 	return err;
 }
 
-static void nft_flowtable_hooks_destroy(struct list_head *hook_list)
+static void nft_hooks_destroy(struct list_head *hook_list)
 {
 	struct nft_hook *hook, *next;
 
@@ -7742,7 +7755,8 @@ static void nft_flowtable_hooks_destroy(struct list_head *hook_list)
 }
 
 static int nft_flowtable_update(struct nft_ctx *ctx, const struct nlmsghdr *nlh,
-				struct nft_flowtable *flowtable)
+				struct nft_flowtable *flowtable,
+				struct netlink_ext_ack *extack)
 {
 	const struct nlattr * const *nla = ctx->nla;
 	struct nft_flowtable_hook flowtable_hook;
@@ -7752,8 +7766,8 @@ static int nft_flowtable_update(struct nft_ctx *ctx, const struct nlmsghdr *nlh,
 	u32 flags;
 	int err;
 
-	err = nft_flowtable_parse_hook(ctx, nla[NFTA_FLOWTABLE_HOOK],
-				       &flowtable_hook, flowtable, false);
+	err = nft_flowtable_parse_hook(ctx, nla, &flowtable_hook, flowtable,
+				       extack, false);
 	if (err < 0)
 		return err;
 
@@ -7858,7 +7872,7 @@ static int nf_tables_newflowtable(struct sk_buff *skb,
 
 		nft_ctx_init(&ctx, net, skb, info->nlh, family, table, NULL, nla);
 
-		return nft_flowtable_update(&ctx, info->nlh, flowtable);
+		return nft_flowtable_update(&ctx, info->nlh, flowtable, extack);
 	}
 
 	nft_ctx_init(&ctx, net, skb, info->nlh, family, table, NULL, nla);
@@ -7898,8 +7912,8 @@ static int nf_tables_newflowtable(struct sk_buff *skb,
 	if (err < 0)
 		goto err3;
 
-	err = nft_flowtable_parse_hook(&ctx, nla[NFTA_FLOWTABLE_HOOK],
-				       &flowtable_hook, flowtable, true);
+	err = nft_flowtable_parse_hook(&ctx, nla, &flowtable_hook, flowtable,
+				       extack, true);
 	if (err < 0)
 		goto err4;
 
@@ -7911,7 +7925,7 @@ static int nf_tables_newflowtable(struct sk_buff *skb,
 					       &flowtable->hook_list,
 					       flowtable);
 	if (err < 0) {
-		nft_flowtable_hooks_destroy(&flowtable->hook_list);
+		nft_hooks_destroy(&flowtable->hook_list);
 		goto err4;
 	}
 
@@ -7951,7 +7965,8 @@ static void nft_flowtable_hook_release(struct nft_flowtable_hook *flowtable_hook
 }
 
 static int nft_delflowtable_hook(struct nft_ctx *ctx,
-				 struct nft_flowtable *flowtable)
+				 struct nft_flowtable *flowtable,
+				 struct netlink_ext_ack *extack)
 {
 	const struct nlattr * const *nla = ctx->nla;
 	struct nft_flowtable_hook flowtable_hook;
@@ -7960,8 +7975,8 @@ static int nft_delflowtable_hook(struct nft_ctx *ctx,
 	struct nft_trans *trans;
 	int err;
 
-	err = nft_flowtable_parse_hook(ctx, nla[NFTA_FLOWTABLE_HOOK],
-				       &flowtable_hook, flowtable, false);
+	err = nft_flowtable_parse_hook(ctx, nla, &flowtable_hook, flowtable,
+				       extack, false);
 	if (err < 0)
 		return err;
 
@@ -8039,7 +8054,7 @@ static int nf_tables_delflowtable(struct sk_buff *skb,
 	nft_ctx_init(&ctx, net, skb, info->nlh, family, table, NULL, nla);
 
 	if (nla[NFTA_FLOWTABLE_HOOK])
-		return nft_delflowtable_hook(&ctx, flowtable);
+		return nft_delflowtable_hook(&ctx, flowtable, extack);
 
 	if (flowtable->use > 0) {
 		NL_SET_BAD_ATTR(extack, attr);
@@ -8685,7 +8700,7 @@ static void nft_commit_release(struct nft_trans *trans)
 		break;
 	case NFT_MSG_DELFLOWTABLE:
 		if (nft_trans_flowtable_update(trans))
-			nft_flowtable_hooks_destroy(&nft_trans_flowtable_hooks(trans));
+			nft_hooks_destroy(&nft_trans_flowtable_hooks(trans));
 		else
 			nf_tables_flowtable_destroy(nft_trans_flowtable(trans));
 		break;
@@ -9331,7 +9346,7 @@ static void nf_tables_abort_release(struct nft_trans *trans)
 		break;
 	case NFT_MSG_NEWFLOWTABLE:
 		if (nft_trans_flowtable_update(trans))
-			nft_flowtable_hooks_destroy(&nft_trans_flowtable_hooks(trans));
+			nft_hooks_destroy(&nft_trans_flowtable_hooks(trans));
 		else
 			nf_tables_flowtable_destroy(nft_trans_flowtable(trans));
 		break;
diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index 1259b34a28eb..cc7a42ba94f9 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -2036,7 +2036,7 @@ static int packet_sendmsg_spkt(struct socket *sock, struct msghdr *msg,
 		goto retry;
 	}
 
-	if (!dev_validate_header(dev, skb->data, len)) {
+	if (!dev_validate_header(dev, skb->data, len) || !skb->len) {
 		err = -EINVAL;
 		goto out_unlock;
 	}
diff --git a/net/rxrpc/af_rxrpc.c b/net/rxrpc/af_rxrpc.c
index ebbd4a1c3f86..de5bebc99a4b 100644
--- a/net/rxrpc/af_rxrpc.c
+++ b/net/rxrpc/af_rxrpc.c
@@ -265,6 +265,7 @@ static int rxrpc_listen(struct socket *sock, int backlog)
  * @key: The security context to use (defaults to socket setting)
  * @user_call_ID: The ID to use
  * @tx_total_len: Total length of data to transmit during the call (or -1)
+ * @hard_timeout: The maximum lifespan of the call in sec
  * @gfp: The allocation constraints
  * @notify_rx: Where to send notifications instead of socket queue
  * @upgrade: Request service upgrade for call
@@ -283,6 +284,7 @@ struct rxrpc_call *rxrpc_kernel_begin_call(struct socket *sock,
 					   struct key *key,
 					   unsigned long user_call_ID,
 					   s64 tx_total_len,
+					   u32 hard_timeout,
 					   gfp_t gfp,
 					   rxrpc_notify_rx_t notify_rx,
 					   bool upgrade,
@@ -313,6 +315,7 @@ struct rxrpc_call *rxrpc_kernel_begin_call(struct socket *sock,
 	p.tx_total_len		= tx_total_len;
 	p.interruptibility	= interruptibility;
 	p.kernel		= true;
+	p.timeouts.hard		= hard_timeout;
 
 	memset(&cp, 0, sizeof(cp));
 	cp.local		= rx->local;
diff --git a/net/rxrpc/ar-internal.h b/net/rxrpc/ar-internal.h
index 433060cade03..ed0ef2dbd592 100644
--- a/net/rxrpc/ar-internal.h
+++ b/net/rxrpc/ar-internal.h
@@ -614,6 +614,7 @@ struct rxrpc_call {
 	unsigned long		expect_term_by;	/* When we expect call termination by */
 	u32			next_rx_timo;	/* Timeout for next Rx packet (jif) */
 	u32			next_req_timo;	/* Timeout for next Rx request packet (jif) */
+	u32			hard_timo;	/* Maximum lifetime or 0 (jif) */
 	struct timer_list	timer;		/* Combined event timer */
 	struct work_struct	destroyer;	/* In-process-context destroyer */
 	rxrpc_notify_rx_t	notify_rx;	/* kernel service Rx notification function */
diff --git a/net/rxrpc/call_object.c b/net/rxrpc/call_object.c
index 7ce562f6dc8d..80ed67f4f3a7 100644
--- a/net/rxrpc/call_object.c
+++ b/net/rxrpc/call_object.c
@@ -225,6 +225,13 @@ static struct rxrpc_call *rxrpc_alloc_client_call(struct rxrpc_sock *rx,
 	if (cp->exclusive)
 		__set_bit(RXRPC_CALL_EXCLUSIVE, &call->flags);
 
+	if (p->timeouts.normal)
+		call->next_rx_timo = min(msecs_to_jiffies(p->timeouts.normal), 1UL);
+	if (p->timeouts.idle)
+		call->next_req_timo = min(msecs_to_jiffies(p->timeouts.idle), 1UL);
+	if (p->timeouts.hard)
+		call->hard_timo = p->timeouts.hard * HZ;
+
 	ret = rxrpc_init_client_call_security(call);
 	if (ret < 0) {
 		rxrpc_prefail_call(call, RXRPC_CALL_LOCAL_ERROR, ret);
@@ -256,7 +263,7 @@ void rxrpc_start_call_timer(struct rxrpc_call *call)
 	call->keepalive_at = j;
 	call->expect_rx_by = j;
 	call->expect_req_by = j;
-	call->expect_term_by = j;
+	call->expect_term_by = j + call->hard_timo;
 	call->timer.expires = now;
 }
 
diff --git a/net/rxrpc/sendmsg.c b/net/rxrpc/sendmsg.c
index da49fcf1c456..8e0b94714e84 100644
--- a/net/rxrpc/sendmsg.c
+++ b/net/rxrpc/sendmsg.c
@@ -50,15 +50,11 @@ static int rxrpc_wait_to_be_connected(struct rxrpc_call *call, long *timeo)
 	_enter("%d", call->debug_id);
 
 	if (rxrpc_call_state(call) != RXRPC_CALL_CLIENT_AWAIT_CONN)
-		return call->error;
+		goto no_wait;
 
 	add_wait_queue_exclusive(&call->waitq, &myself);
 
 	for (;;) {
-		ret = call->error;
-		if (ret < 0)
-			break;
-
 		switch (call->interruptibility) {
 		case RXRPC_INTERRUPTIBLE:
 		case RXRPC_PREINTERRUPTIBLE:
@@ -69,10 +65,9 @@ static int rxrpc_wait_to_be_connected(struct rxrpc_call *call, long *timeo)
 			set_current_state(TASK_UNINTERRUPTIBLE);
 			break;
 		}
-		if (rxrpc_call_state(call) != RXRPC_CALL_CLIENT_AWAIT_CONN) {
-			ret = call->error;
+
+		if (rxrpc_call_state(call) != RXRPC_CALL_CLIENT_AWAIT_CONN)
 			break;
-		}
 		if ((call->interruptibility == RXRPC_INTERRUPTIBLE ||
 		     call->interruptibility == RXRPC_PREINTERRUPTIBLE) &&
 		    signal_pending(current)) {
@@ -85,6 +80,7 @@ static int rxrpc_wait_to_be_connected(struct rxrpc_call *call, long *timeo)
 	remove_wait_queue(&call->waitq, &myself);
 	__set_current_state(TASK_RUNNING);
 
+no_wait:
 	if (ret == 0 && rxrpc_call_is_complete(call))
 		ret = call->error;
 
@@ -655,15 +651,19 @@ int rxrpc_do_sendmsg(struct rxrpc_sock *rx, struct msghdr *msg, size_t len)
 		if (IS_ERR(call))
 			return PTR_ERR(call);
 		/* ... and we have the call lock. */
+		p.call.nr_timeouts = 0;
 		ret = 0;
 		if (rxrpc_call_is_complete(call))
 			goto out_put_unlock;
 	} else {
 		switch (rxrpc_call_state(call)) {
-		case RXRPC_CALL_UNINITIALISED:
 		case RXRPC_CALL_CLIENT_AWAIT_CONN:
-		case RXRPC_CALL_SERVER_PREALLOC:
 		case RXRPC_CALL_SERVER_SECURING:
+			if (p.command == RXRPC_CMD_SEND_ABORT)
+				break;
+			fallthrough;
+		case RXRPC_CALL_UNINITIALISED:
+		case RXRPC_CALL_SERVER_PREALLOC:
 			rxrpc_put_call(call, rxrpc_call_put_sendmsg);
 			ret = -EBUSY;
 			goto error_release_sock;
@@ -703,7 +703,7 @@ int rxrpc_do_sendmsg(struct rxrpc_sock *rx, struct msghdr *msg, size_t len)
 		fallthrough;
 	case 1:
 		if (p.call.timeouts.hard > 0) {
-			j = msecs_to_jiffies(p.call.timeouts.hard);
+			j = p.call.timeouts.hard * HZ;
 			now = jiffies;
 			j += now;
 			WRITE_ONCE(call->expect_term_by, j);
diff --git a/net/sched/act_mirred.c b/net/sched/act_mirred.c
index 8037ec9b1d31..a61482c5edbe 100644
--- a/net/sched/act_mirred.c
+++ b/net/sched/act_mirred.c
@@ -264,7 +264,7 @@ TC_INDIRECT_SCOPE int tcf_mirred_act(struct sk_buff *skb,
 		goto out;
 	}
 
-	if (unlikely(!(dev->flags & IFF_UP))) {
+	if (unlikely(!(dev->flags & IFF_UP)) || !netif_carrier_ok(dev)) {
 		net_notice_ratelimited("tc mirred to Houston: device %s is down\n",
 				       dev->name);
 		goto out;
diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
index 668130f08903..3f37e9c10af4 100644
--- a/net/sched/cls_api.c
+++ b/net/sched/cls_api.c
@@ -1484,6 +1484,7 @@ static int tcf_block_bind(struct tcf_block *block,
 
 err_unroll:
 	list_for_each_entry_safe(block_cb, next, &bo->cb_list, list) {
+		list_del(&block_cb->driver_list);
 		if (i-- > 0) {
 			list_del(&block_cb->list);
 			tcf_block_playback_offloads(block, block_cb->cb,
diff --git a/sound/soc/codecs/rt1316-sdw.c b/sound/soc/codecs/rt1316-sdw.c
index e6294cc7a995..45a3eff31915 100644
--- a/sound/soc/codecs/rt1316-sdw.c
+++ b/sound/soc/codecs/rt1316-sdw.c
@@ -584,7 +584,7 @@ static int rt1316_sdw_pcm_hw_free(struct snd_pcm_substream *substream,
  * slave_ops: callbacks for get_clock_stop_mode, clock_stop and
  * port_prep are not defined for now
  */
-static struct sdw_slave_ops rt1316_slave_ops = {
+static const struct sdw_slave_ops rt1316_slave_ops = {
 	.read_prop = rt1316_read_prop,
 	.update_status = rt1316_update_status,
 };
diff --git a/sound/soc/codecs/rt1318-sdw.c b/sound/soc/codecs/rt1318-sdw.c
index f85f5ab2c6d0..c6ec86e97a6e 100644
--- a/sound/soc/codecs/rt1318-sdw.c
+++ b/sound/soc/codecs/rt1318-sdw.c
@@ -697,7 +697,7 @@ static int rt1318_sdw_pcm_hw_free(struct snd_pcm_substream *substream,
  * slave_ops: callbacks for get_clock_stop_mode, clock_stop and
  * port_prep are not defined for now
  */
-static struct sdw_slave_ops rt1318_slave_ops = {
+static const struct sdw_slave_ops rt1318_slave_ops = {
 	.read_prop = rt1318_read_prop,
 	.update_status = rt1318_update_status,
 };
diff --git a/sound/soc/codecs/rt711-sdca-sdw.c b/sound/soc/codecs/rt711-sdca-sdw.c
index 88a8392a58ed..e23cec4c457d 100644
--- a/sound/soc/codecs/rt711-sdca-sdw.c
+++ b/sound/soc/codecs/rt711-sdca-sdw.c
@@ -338,7 +338,7 @@ static int rt711_sdca_interrupt_callback(struct sdw_slave *slave,
 	return ret;
 }
 
-static struct sdw_slave_ops rt711_sdca_slave_ops = {
+static const struct sdw_slave_ops rt711_sdca_slave_ops = {
 	.read_prop = rt711_sdca_read_prop,
 	.interrupt_callback = rt711_sdca_interrupt_callback,
 	.update_status = rt711_sdca_update_status,
diff --git a/sound/soc/codecs/rt715-sdca-sdw.c b/sound/soc/codecs/rt715-sdca-sdw.c
index c54ecf3e6987..38a82e4e2f95 100644
--- a/sound/soc/codecs/rt715-sdca-sdw.c
+++ b/sound/soc/codecs/rt715-sdca-sdw.c
@@ -172,7 +172,7 @@ static int rt715_sdca_read_prop(struct sdw_slave *slave)
 	return 0;
 }
 
-static struct sdw_slave_ops rt715_sdca_slave_ops = {
+static const struct sdw_slave_ops rt715_sdca_slave_ops = {
 	.read_prop = rt715_sdca_read_prop,
 	.update_status = rt715_sdca_update_status,
 };
diff --git a/sound/soc/codecs/wcd938x-sdw.c b/sound/soc/codecs/wcd938x-sdw.c
index 1bf3c06a2b62..402286dfaea4 100644
--- a/sound/soc/codecs/wcd938x-sdw.c
+++ b/sound/soc/codecs/wcd938x-sdw.c
@@ -161,6 +161,14 @@ EXPORT_SYMBOL_GPL(wcd938x_sdw_set_sdw_stream);
 static int wcd9380_update_status(struct sdw_slave *slave,
 				 enum sdw_slave_status status)
 {
+	struct wcd938x_sdw_priv *wcd = dev_get_drvdata(&slave->dev);
+
+	if (wcd->regmap && (status == SDW_SLAVE_ATTACHED)) {
+		/* Write out any cached changes that happened between probe and attach */
+		regcache_cache_only(wcd->regmap, false);
+		return regcache_sync(wcd->regmap);
+	}
+
 	return 0;
 }
 
@@ -177,21 +185,1015 @@ static int wcd9380_interrupt_callback(struct sdw_slave *slave,
 {
 	struct wcd938x_sdw_priv *wcd = dev_get_drvdata(&slave->dev);
 	struct irq_domain *slave_irq = wcd->slave_irq;
-	struct regmap *regmap = dev_get_regmap(&slave->dev, NULL);
 	u32 sts1, sts2, sts3;
 
 	do {
 		handle_nested_irq(irq_find_mapping(slave_irq, 0));
-		regmap_read(regmap, WCD938X_DIGITAL_INTR_STATUS_0, &sts1);
-		regmap_read(regmap, WCD938X_DIGITAL_INTR_STATUS_1, &sts2);
-		regmap_read(regmap, WCD938X_DIGITAL_INTR_STATUS_2, &sts3);
+		regmap_read(wcd->regmap, WCD938X_DIGITAL_INTR_STATUS_0, &sts1);
+		regmap_read(wcd->regmap, WCD938X_DIGITAL_INTR_STATUS_1, &sts2);
+		regmap_read(wcd->regmap, WCD938X_DIGITAL_INTR_STATUS_2, &sts3);
 
 	} while (sts1 || sts2 || sts3);
 
 	return IRQ_HANDLED;
 }
 
-static struct sdw_slave_ops wcd9380_slave_ops = {
+static const struct reg_default wcd938x_defaults[] = {
+	{WCD938X_ANA_PAGE_REGISTER,                            0x00},
+	{WCD938X_ANA_BIAS,                                     0x00},
+	{WCD938X_ANA_RX_SUPPLIES,                              0x00},
+	{WCD938X_ANA_HPH,                                      0x0C},
+	{WCD938X_ANA_EAR,                                      0x00},
+	{WCD938X_ANA_EAR_COMPANDER_CTL,                        0x02},
+	{WCD938X_ANA_TX_CH1,                                   0x20},
+	{WCD938X_ANA_TX_CH2,                                   0x00},
+	{WCD938X_ANA_TX_CH3,                                   0x20},
+	{WCD938X_ANA_TX_CH4,                                   0x00},
+	{WCD938X_ANA_MICB1_MICB2_DSP_EN_LOGIC,                 0x00},
+	{WCD938X_ANA_MICB3_DSP_EN_LOGIC,                       0x00},
+	{WCD938X_ANA_MBHC_MECH,                                0x39},
+	{WCD938X_ANA_MBHC_ELECT,                               0x08},
+	{WCD938X_ANA_MBHC_ZDET,                                0x00},
+	{WCD938X_ANA_MBHC_RESULT_1,                            0x00},
+	{WCD938X_ANA_MBHC_RESULT_2,                            0x00},
+	{WCD938X_ANA_MBHC_RESULT_3,                            0x00},
+	{WCD938X_ANA_MBHC_BTN0,                                0x00},
+	{WCD938X_ANA_MBHC_BTN1,                                0x10},
+	{WCD938X_ANA_MBHC_BTN2,                                0x20},
+	{WCD938X_ANA_MBHC_BTN3,                                0x30},
+	{WCD938X_ANA_MBHC_BTN4,                                0x40},
+	{WCD938X_ANA_MBHC_BTN5,                                0x50},
+	{WCD938X_ANA_MBHC_BTN6,                                0x60},
+	{WCD938X_ANA_MBHC_BTN7,                                0x70},
+	{WCD938X_ANA_MICB1,                                    0x10},
+	{WCD938X_ANA_MICB2,                                    0x10},
+	{WCD938X_ANA_MICB2_RAMP,                               0x00},
+	{WCD938X_ANA_MICB3,                                    0x10},
+	{WCD938X_ANA_MICB4,                                    0x10},
+	{WCD938X_BIAS_CTL,                                     0x2A},
+	{WCD938X_BIAS_VBG_FINE_ADJ,                            0x55},
+	{WCD938X_LDOL_VDDCX_ADJUST,                            0x01},
+	{WCD938X_LDOL_DISABLE_LDOL,                            0x00},
+	{WCD938X_MBHC_CTL_CLK,                                 0x00},
+	{WCD938X_MBHC_CTL_ANA,                                 0x00},
+	{WCD938X_MBHC_CTL_SPARE_1,                             0x00},
+	{WCD938X_MBHC_CTL_SPARE_2,                             0x00},
+	{WCD938X_MBHC_CTL_BCS,                                 0x00},
+	{WCD938X_MBHC_MOISTURE_DET_FSM_STATUS,                 0x00},
+	{WCD938X_MBHC_TEST_CTL,                                0x00},
+	{WCD938X_LDOH_MODE,                                    0x2B},
+	{WCD938X_LDOH_BIAS,                                    0x68},
+	{WCD938X_LDOH_STB_LOADS,                               0x00},
+	{WCD938X_LDOH_SLOWRAMP,                                0x50},
+	{WCD938X_MICB1_TEST_CTL_1,                             0x1A},
+	{WCD938X_MICB1_TEST_CTL_2,                             0x00},
+	{WCD938X_MICB1_TEST_CTL_3,                             0xA4},
+	{WCD938X_MICB2_TEST_CTL_1,                             0x1A},
+	{WCD938X_MICB2_TEST_CTL_2,                             0x00},
+	{WCD938X_MICB2_TEST_CTL_3,                             0x24},
+	{WCD938X_MICB3_TEST_CTL_1,                             0x1A},
+	{WCD938X_MICB3_TEST_CTL_2,                             0x00},
+	{WCD938X_MICB3_TEST_CTL_3,                             0xA4},
+	{WCD938X_MICB4_TEST_CTL_1,                             0x1A},
+	{WCD938X_MICB4_TEST_CTL_2,                             0x00},
+	{WCD938X_MICB4_TEST_CTL_3,                             0xA4},
+	{WCD938X_TX_COM_ADC_VCM,                               0x39},
+	{WCD938X_TX_COM_BIAS_ATEST,                            0xE0},
+	{WCD938X_TX_COM_SPARE1,                                0x00},
+	{WCD938X_TX_COM_SPARE2,                                0x00},
+	{WCD938X_TX_COM_TXFE_DIV_CTL,                          0x22},
+	{WCD938X_TX_COM_TXFE_DIV_START,                        0x00},
+	{WCD938X_TX_COM_SPARE3,                                0x00},
+	{WCD938X_TX_COM_SPARE4,                                0x00},
+	{WCD938X_TX_1_2_TEST_EN,                               0xCC},
+	{WCD938X_TX_1_2_ADC_IB,                                0xE9},
+	{WCD938X_TX_1_2_ATEST_REFCTL,                          0x0A},
+	{WCD938X_TX_1_2_TEST_CTL,                              0x38},
+	{WCD938X_TX_1_2_TEST_BLK_EN1,                          0xFF},
+	{WCD938X_TX_1_2_TXFE1_CLKDIV,                          0x00},
+	{WCD938X_TX_1_2_SAR2_ERR,                              0x00},
+	{WCD938X_TX_1_2_SAR1_ERR,                              0x00},
+	{WCD938X_TX_3_4_TEST_EN,                               0xCC},
+	{WCD938X_TX_3_4_ADC_IB,                                0xE9},
+	{WCD938X_TX_3_4_ATEST_REFCTL,                          0x0A},
+	{WCD938X_TX_3_4_TEST_CTL,                              0x38},
+	{WCD938X_TX_3_4_TEST_BLK_EN3,                          0xFF},
+	{WCD938X_TX_3_4_TXFE3_CLKDIV,                          0x00},
+	{WCD938X_TX_3_4_SAR4_ERR,                              0x00},
+	{WCD938X_TX_3_4_SAR3_ERR,                              0x00},
+	{WCD938X_TX_3_4_TEST_BLK_EN2,                          0xFB},
+	{WCD938X_TX_3_4_TXFE2_CLKDIV,                          0x00},
+	{WCD938X_TX_3_4_SPARE1,                                0x00},
+	{WCD938X_TX_3_4_TEST_BLK_EN4,                          0xFB},
+	{WCD938X_TX_3_4_TXFE4_CLKDIV,                          0x00},
+	{WCD938X_TX_3_4_SPARE2,                                0x00},
+	{WCD938X_CLASSH_MODE_1,                                0x40},
+	{WCD938X_CLASSH_MODE_2,                                0x3A},
+	{WCD938X_CLASSH_MODE_3,                                0x00},
+	{WCD938X_CLASSH_CTRL_VCL_1,                            0x70},
+	{WCD938X_CLASSH_CTRL_VCL_2,                            0x82},
+	{WCD938X_CLASSH_CTRL_CCL_1,                            0x31},
+	{WCD938X_CLASSH_CTRL_CCL_2,                            0x80},
+	{WCD938X_CLASSH_CTRL_CCL_3,                            0x80},
+	{WCD938X_CLASSH_CTRL_CCL_4,                            0x51},
+	{WCD938X_CLASSH_CTRL_CCL_5,                            0x00},
+	{WCD938X_CLASSH_BUCK_TMUX_A_D,                         0x00},
+	{WCD938X_CLASSH_BUCK_SW_DRV_CNTL,                      0x77},
+	{WCD938X_CLASSH_SPARE,                                 0x00},
+	{WCD938X_FLYBACK_EN,                                   0x4E},
+	{WCD938X_FLYBACK_VNEG_CTRL_1,                          0x0B},
+	{WCD938X_FLYBACK_VNEG_CTRL_2,                          0x45},
+	{WCD938X_FLYBACK_VNEG_CTRL_3,                          0x74},
+	{WCD938X_FLYBACK_VNEG_CTRL_4,                          0x7F},
+	{WCD938X_FLYBACK_VNEG_CTRL_5,                          0x83},
+	{WCD938X_FLYBACK_VNEG_CTRL_6,                          0x98},
+	{WCD938X_FLYBACK_VNEG_CTRL_7,                          0xA9},
+	{WCD938X_FLYBACK_VNEG_CTRL_8,                          0x68},
+	{WCD938X_FLYBACK_VNEG_CTRL_9,                          0x64},
+	{WCD938X_FLYBACK_VNEGDAC_CTRL_1,                       0xED},
+	{WCD938X_FLYBACK_VNEGDAC_CTRL_2,                       0xF0},
+	{WCD938X_FLYBACK_VNEGDAC_CTRL_3,                       0xA6},
+	{WCD938X_FLYBACK_CTRL_1,                               0x65},
+	{WCD938X_FLYBACK_TEST_CTL,                             0x00},
+	{WCD938X_RX_AUX_SW_CTL,                                0x00},
+	{WCD938X_RX_PA_AUX_IN_CONN,                            0x01},
+	{WCD938X_RX_TIMER_DIV,                                 0x32},
+	{WCD938X_RX_OCP_CTL,                                   0x1F},
+	{WCD938X_RX_OCP_COUNT,                                 0x77},
+	{WCD938X_RX_BIAS_EAR_DAC,                              0xA0},
+	{WCD938X_RX_BIAS_EAR_AMP,                              0xAA},
+	{WCD938X_RX_BIAS_HPH_LDO,                              0xA9},
+	{WCD938X_RX_BIAS_HPH_PA,                               0xAA},
+	{WCD938X_RX_BIAS_HPH_RDACBUFF_CNP2,                    0x8A},
+	{WCD938X_RX_BIAS_HPH_RDAC_LDO,                         0x88},
+	{WCD938X_RX_BIAS_HPH_CNP1,                             0x82},
+	{WCD938X_RX_BIAS_HPH_LOWPOWER,                         0x82},
+	{WCD938X_RX_BIAS_AUX_DAC,                              0xA0},
+	{WCD938X_RX_BIAS_AUX_AMP,                              0xAA},
+	{WCD938X_RX_BIAS_VNEGDAC_BLEEDER,                      0x50},
+	{WCD938X_RX_BIAS_MISC,                                 0x00},
+	{WCD938X_RX_BIAS_BUCK_RST,                             0x08},
+	{WCD938X_RX_BIAS_BUCK_VREF_ERRAMP,                     0x44},
+	{WCD938X_RX_BIAS_FLYB_ERRAMP,                          0x40},
+	{WCD938X_RX_BIAS_FLYB_BUFF,                            0xAA},
+	{WCD938X_RX_BIAS_FLYB_MID_RST,                         0x14},
+	{WCD938X_HPH_L_STATUS,                                 0x04},
+	{WCD938X_HPH_R_STATUS,                                 0x04},
+	{WCD938X_HPH_CNP_EN,                                   0x80},
+	{WCD938X_HPH_CNP_WG_CTL,                               0x9A},
+	{WCD938X_HPH_CNP_WG_TIME,                              0x14},
+	{WCD938X_HPH_OCP_CTL,                                  0x28},
+	{WCD938X_HPH_AUTO_CHOP,                                0x16},
+	{WCD938X_HPH_CHOP_CTL,                                 0x83},
+	{WCD938X_HPH_PA_CTL1,                                  0x46},
+	{WCD938X_HPH_PA_CTL2,                                  0x50},
+	{WCD938X_HPH_L_EN,                                     0x80},
+	{WCD938X_HPH_L_TEST,                                   0xE0},
+	{WCD938X_HPH_L_ATEST,                                  0x50},
+	{WCD938X_HPH_R_EN,                                     0x80},
+	{WCD938X_HPH_R_TEST,                                   0xE0},
+	{WCD938X_HPH_R_ATEST,                                  0x54},
+	{WCD938X_HPH_RDAC_CLK_CTL1,                            0x99},
+	{WCD938X_HPH_RDAC_CLK_CTL2,                            0x9B},
+	{WCD938X_HPH_RDAC_LDO_CTL,                             0x33},
+	{WCD938X_HPH_RDAC_CHOP_CLK_LP_CTL,                     0x00},
+	{WCD938X_HPH_REFBUFF_UHQA_CTL,                         0x68},
+	{WCD938X_HPH_REFBUFF_LP_CTL,                           0x0E},
+	{WCD938X_HPH_L_DAC_CTL,                                0x20},
+	{WCD938X_HPH_R_DAC_CTL,                                0x20},
+	{WCD938X_HPH_SURGE_HPHLR_SURGE_COMP_SEL,               0x55},
+	{WCD938X_HPH_SURGE_HPHLR_SURGE_EN,                     0x19},
+	{WCD938X_HPH_SURGE_HPHLR_SURGE_MISC1,                  0xA0},
+	{WCD938X_HPH_SURGE_HPHLR_SURGE_STATUS,                 0x00},
+	{WCD938X_EAR_EAR_EN_REG,                               0x22},
+	{WCD938X_EAR_EAR_PA_CON,                               0x44},
+	{WCD938X_EAR_EAR_SP_CON,                               0xDB},
+	{WCD938X_EAR_EAR_DAC_CON,                              0x80},
+	{WCD938X_EAR_EAR_CNP_FSM_CON,                          0xB2},
+	{WCD938X_EAR_TEST_CTL,                                 0x00},
+	{WCD938X_EAR_STATUS_REG_1,                             0x00},
+	{WCD938X_EAR_STATUS_REG_2,                             0x08},
+	{WCD938X_ANA_NEW_PAGE_REGISTER,                        0x00},
+	{WCD938X_HPH_NEW_ANA_HPH2,                             0x00},
+	{WCD938X_HPH_NEW_ANA_HPH3,                             0x00},
+	{WCD938X_SLEEP_CTL,                                    0x16},
+	{WCD938X_SLEEP_WATCHDOG_CTL,                           0x00},
+	{WCD938X_MBHC_NEW_ELECT_REM_CLAMP_CTL,                 0x00},
+	{WCD938X_MBHC_NEW_CTL_1,                               0x02},
+	{WCD938X_MBHC_NEW_CTL_2,                               0x05},
+	{WCD938X_MBHC_NEW_PLUG_DETECT_CTL,                     0xE9},
+	{WCD938X_MBHC_NEW_ZDET_ANA_CTL,                        0x0F},
+	{WCD938X_MBHC_NEW_ZDET_RAMP_CTL,                       0x00},
+	{WCD938X_MBHC_NEW_FSM_STATUS,                          0x00},
+	{WCD938X_MBHC_NEW_ADC_RESULT,                          0x00},
+	{WCD938X_TX_NEW_AMIC_MUX_CFG,                          0x00},
+	{WCD938X_AUX_AUXPA,                                    0x00},
+	{WCD938X_LDORXTX_MODE,                                 0x0C},
+	{WCD938X_LDORXTX_CONFIG,                               0x10},
+	{WCD938X_DIE_CRACK_DIE_CRK_DET_EN,                     0x00},
+	{WCD938X_DIE_CRACK_DIE_CRK_DET_OUT,                    0x00},
+	{WCD938X_HPH_NEW_INT_RDAC_GAIN_CTL,                    0x40},
+	{WCD938X_HPH_NEW_INT_RDAC_HD2_CTL_L,                   0x81},
+	{WCD938X_HPH_NEW_INT_RDAC_VREF_CTL,                    0x10},
+	{WCD938X_HPH_NEW_INT_RDAC_OVERRIDE_CTL,                0x00},
+	{WCD938X_HPH_NEW_INT_RDAC_HD2_CTL_R,                   0x81},
+	{WCD938X_HPH_NEW_INT_PA_MISC1,                         0x22},
+	{WCD938X_HPH_NEW_INT_PA_MISC2,                         0x00},
+	{WCD938X_HPH_NEW_INT_PA_RDAC_MISC,                     0x00},
+	{WCD938X_HPH_NEW_INT_HPH_TIMER1,                       0xFE},
+	{WCD938X_HPH_NEW_INT_HPH_TIMER2,                       0x02},
+	{WCD938X_HPH_NEW_INT_HPH_TIMER3,                       0x4E},
+	{WCD938X_HPH_NEW_INT_HPH_TIMER4,                       0x54},
+	{WCD938X_HPH_NEW_INT_PA_RDAC_MISC2,                    0x00},
+	{WCD938X_HPH_NEW_INT_PA_RDAC_MISC3,                    0x00},
+	{WCD938X_HPH_NEW_INT_RDAC_HD2_CTL_L_NEW,               0x90},
+	{WCD938X_HPH_NEW_INT_RDAC_HD2_CTL_R_NEW,               0x90},
+	{WCD938X_RX_NEW_INT_HPH_RDAC_BIAS_LOHIFI,              0x62},
+	{WCD938X_RX_NEW_INT_HPH_RDAC_BIAS_ULP,                 0x01},
+	{WCD938X_RX_NEW_INT_HPH_RDAC_LDO_LP,                   0x11},
+	{WCD938X_MBHC_NEW_INT_MOISTURE_DET_DC_CTRL,            0x57},
+	{WCD938X_MBHC_NEW_INT_MOISTURE_DET_POLLING_CTRL,       0x01},
+	{WCD938X_MBHC_NEW_INT_MECH_DET_CURRENT,                0x00},
+	{WCD938X_MBHC_NEW_INT_SPARE_2,                         0x00},
+	{WCD938X_EAR_INT_NEW_EAR_CHOPPER_CON,                  0xA8},
+	{WCD938X_EAR_INT_NEW_CNP_VCM_CON1,                     0x42},
+	{WCD938X_EAR_INT_NEW_CNP_VCM_CON2,                     0x22},
+	{WCD938X_EAR_INT_NEW_EAR_DYNAMIC_BIAS,                 0x00},
+	{WCD938X_AUX_INT_EN_REG,                               0x00},
+	{WCD938X_AUX_INT_PA_CTRL,                              0x06},
+	{WCD938X_AUX_INT_SP_CTRL,                              0xD2},
+	{WCD938X_AUX_INT_DAC_CTRL,                             0x80},
+	{WCD938X_AUX_INT_CLK_CTRL,                             0x50},
+	{WCD938X_AUX_INT_TEST_CTRL,                            0x00},
+	{WCD938X_AUX_INT_STATUS_REG,                           0x00},
+	{WCD938X_AUX_INT_MISC,                                 0x00},
+	{WCD938X_LDORXTX_INT_BIAS,                             0x6E},
+	{WCD938X_LDORXTX_INT_STB_LOADS_DTEST,                  0x50},
+	{WCD938X_LDORXTX_INT_TEST0,                            0x1C},
+	{WCD938X_LDORXTX_INT_STARTUP_TIMER,                    0xFF},
+	{WCD938X_LDORXTX_INT_TEST1,                            0x1F},
+	{WCD938X_LDORXTX_INT_STATUS,                           0x00},
+	{WCD938X_SLEEP_INT_WATCHDOG_CTL_1,                     0x0A},
+	{WCD938X_SLEEP_INT_WATCHDOG_CTL_2,                     0x0A},
+	{WCD938X_DIE_CRACK_INT_DIE_CRK_DET_INT1,               0x02},
+	{WCD938X_DIE_CRACK_INT_DIE_CRK_DET_INT2,               0x60},
+	{WCD938X_TX_COM_NEW_INT_TXFE_DIVSTOP_L2,               0xFF},
+	{WCD938X_TX_COM_NEW_INT_TXFE_DIVSTOP_L1,               0x7F},
+	{WCD938X_TX_COM_NEW_INT_TXFE_DIVSTOP_L0,               0x3F},
+	{WCD938X_TX_COM_NEW_INT_TXFE_DIVSTOP_ULP1P2M,          0x1F},
+	{WCD938X_TX_COM_NEW_INT_TXFE_DIVSTOP_ULP0P6M,          0x0F},
+	{WCD938X_TX_COM_NEW_INT_TXFE_ICTRL_STG1_L2L1,          0xD7},
+	{WCD938X_TX_COM_NEW_INT_TXFE_ICTRL_STG1_L0,            0xC8},
+	{WCD938X_TX_COM_NEW_INT_TXFE_ICTRL_STG1_ULP,           0xC6},
+	{WCD938X_TX_COM_NEW_INT_TXFE_ICTRL_STG2MAIN_L2L1,      0xD5},
+	{WCD938X_TX_COM_NEW_INT_TXFE_ICTRL_STG2MAIN_L0,        0xCA},
+	{WCD938X_TX_COM_NEW_INT_TXFE_ICTRL_STG2MAIN_ULP,       0x05},
+	{WCD938X_TX_COM_NEW_INT_TXFE_ICTRL_STG2CASC_L2L1L0,    0xA5},
+	{WCD938X_TX_COM_NEW_INT_TXFE_ICTRL_STG2CASC_ULP,       0x13},
+	{WCD938X_TX_COM_NEW_INT_TXADC_SCBIAS_L2L1,             0x88},
+	{WCD938X_TX_COM_NEW_INT_TXADC_SCBIAS_L0ULP,            0x42},
+	{WCD938X_TX_COM_NEW_INT_TXADC_INT_L2,                  0xFF},
+	{WCD938X_TX_COM_NEW_INT_TXADC_INT_L1,                  0x64},
+	{WCD938X_TX_COM_NEW_INT_TXADC_INT_L0,                  0x64},
+	{WCD938X_TX_COM_NEW_INT_TXADC_INT_ULP,                 0x77},
+	{WCD938X_DIGITAL_PAGE_REGISTER,                        0x00},
+	{WCD938X_DIGITAL_CHIP_ID0,                             0x00},
+	{WCD938X_DIGITAL_CHIP_ID1,                             0x00},
+	{WCD938X_DIGITAL_CHIP_ID2,                             0x0D},
+	{WCD938X_DIGITAL_CHIP_ID3,                             0x01},
+	{WCD938X_DIGITAL_SWR_TX_CLK_RATE,                      0x00},
+	{WCD938X_DIGITAL_CDC_RST_CTL,                          0x03},
+	{WCD938X_DIGITAL_TOP_CLK_CFG,                          0x00},
+	{WCD938X_DIGITAL_CDC_ANA_CLK_CTL,                      0x00},
+	{WCD938X_DIGITAL_CDC_DIG_CLK_CTL,                      0xF0},
+	{WCD938X_DIGITAL_SWR_RST_EN,                           0x00},
+	{WCD938X_DIGITAL_CDC_PATH_MODE,                        0x55},
+	{WCD938X_DIGITAL_CDC_RX_RST,                           0x00},
+	{WCD938X_DIGITAL_CDC_RX0_CTL,                          0xFC},
+	{WCD938X_DIGITAL_CDC_RX1_CTL,                          0xFC},
+	{WCD938X_DIGITAL_CDC_RX2_CTL,                          0xFC},
+	{WCD938X_DIGITAL_CDC_TX_ANA_MODE_0_1,                  0x00},
+	{WCD938X_DIGITAL_CDC_TX_ANA_MODE_2_3,                  0x00},
+	{WCD938X_DIGITAL_CDC_COMP_CTL_0,                       0x00},
+	{WCD938X_DIGITAL_CDC_ANA_TX_CLK_CTL,                   0x1E},
+	{WCD938X_DIGITAL_CDC_HPH_DSM_A1_0,                     0x00},
+	{WCD938X_DIGITAL_CDC_HPH_DSM_A1_1,                     0x01},
+	{WCD938X_DIGITAL_CDC_HPH_DSM_A2_0,                     0x63},
+	{WCD938X_DIGITAL_CDC_HPH_DSM_A2_1,                     0x04},
+	{WCD938X_DIGITAL_CDC_HPH_DSM_A3_0,                     0xAC},
+	{WCD938X_DIGITAL_CDC_HPH_DSM_A3_1,                     0x04},
+	{WCD938X_DIGITAL_CDC_HPH_DSM_A4_0,                     0x1A},
+	{WCD938X_DIGITAL_CDC_HPH_DSM_A4_1,                     0x03},
+	{WCD938X_DIGITAL_CDC_HPH_DSM_A5_0,                     0xBC},
+	{WCD938X_DIGITAL_CDC_HPH_DSM_A5_1,                     0x02},
+	{WCD938X_DIGITAL_CDC_HPH_DSM_A6_0,                     0xC7},
+	{WCD938X_DIGITAL_CDC_HPH_DSM_A7_0,                     0xF8},
+	{WCD938X_DIGITAL_CDC_HPH_DSM_C_0,                      0x47},
+	{WCD938X_DIGITAL_CDC_HPH_DSM_C_1,                      0x43},
+	{WCD938X_DIGITAL_CDC_HPH_DSM_C_2,                      0xB1},
+	{WCD938X_DIGITAL_CDC_HPH_DSM_C_3,                      0x17},
+	{WCD938X_DIGITAL_CDC_HPH_DSM_R1,                       0x4D},
+	{WCD938X_DIGITAL_CDC_HPH_DSM_R2,                       0x29},
+	{WCD938X_DIGITAL_CDC_HPH_DSM_R3,                       0x34},
+	{WCD938X_DIGITAL_CDC_HPH_DSM_R4,                       0x59},
+	{WCD938X_DIGITAL_CDC_HPH_DSM_R5,                       0x66},
+	{WCD938X_DIGITAL_CDC_HPH_DSM_R6,                       0x87},
+	{WCD938X_DIGITAL_CDC_HPH_DSM_R7,                       0x64},
+	{WCD938X_DIGITAL_CDC_AUX_DSM_A1_0,                     0x00},
+	{WCD938X_DIGITAL_CDC_AUX_DSM_A1_1,                     0x01},
+	{WCD938X_DIGITAL_CDC_AUX_DSM_A2_0,                     0x96},
+	{WCD938X_DIGITAL_CDC_AUX_DSM_A2_1,                     0x09},
+	{WCD938X_DIGITAL_CDC_AUX_DSM_A3_0,                     0xAB},
+	{WCD938X_DIGITAL_CDC_AUX_DSM_A3_1,                     0x05},
+	{WCD938X_DIGITAL_CDC_AUX_DSM_A4_0,                     0x1C},
+	{WCD938X_DIGITAL_CDC_AUX_DSM_A4_1,                     0x02},
+	{WCD938X_DIGITAL_CDC_AUX_DSM_A5_0,                     0x17},
+	{WCD938X_DIGITAL_CDC_AUX_DSM_A5_1,                     0x02},
+	{WCD938X_DIGITAL_CDC_AUX_DSM_A6_0,                     0xAA},
+	{WCD938X_DIGITAL_CDC_AUX_DSM_A7_0,                     0xE3},
+	{WCD938X_DIGITAL_CDC_AUX_DSM_C_0,                      0x69},
+	{WCD938X_DIGITAL_CDC_AUX_DSM_C_1,                      0x54},
+	{WCD938X_DIGITAL_CDC_AUX_DSM_C_2,                      0x02},
+	{WCD938X_DIGITAL_CDC_AUX_DSM_C_3,                      0x15},
+	{WCD938X_DIGITAL_CDC_AUX_DSM_R1,                       0xA4},
+	{WCD938X_DIGITAL_CDC_AUX_DSM_R2,                       0xB5},
+	{WCD938X_DIGITAL_CDC_AUX_DSM_R3,                       0x86},
+	{WCD938X_DIGITAL_CDC_AUX_DSM_R4,                       0x85},
+	{WCD938X_DIGITAL_CDC_AUX_DSM_R5,                       0xAA},
+	{WCD938X_DIGITAL_CDC_AUX_DSM_R6,                       0xE2},
+	{WCD938X_DIGITAL_CDC_AUX_DSM_R7,                       0x62},
+	{WCD938X_DIGITAL_CDC_HPH_GAIN_RX_0,                    0x55},
+	{WCD938X_DIGITAL_CDC_HPH_GAIN_RX_1,                    0xA9},
+	{WCD938X_DIGITAL_CDC_HPH_GAIN_DSD_0,                   0x3D},
+	{WCD938X_DIGITAL_CDC_HPH_GAIN_DSD_1,                   0x2E},
+	{WCD938X_DIGITAL_CDC_HPH_GAIN_DSD_2,                   0x01},
+	{WCD938X_DIGITAL_CDC_AUX_GAIN_DSD_0,                   0x00},
+	{WCD938X_DIGITAL_CDC_AUX_GAIN_DSD_1,                   0xFC},
+	{WCD938X_DIGITAL_CDC_AUX_GAIN_DSD_2,                   0x01},
+	{WCD938X_DIGITAL_CDC_HPH_GAIN_CTL,                     0x00},
+	{WCD938X_DIGITAL_CDC_AUX_GAIN_CTL,                     0x00},
+	{WCD938X_DIGITAL_CDC_EAR_PATH_CTL,                     0x00},
+	{WCD938X_DIGITAL_CDC_SWR_CLH,                          0x00},
+	{WCD938X_DIGITAL_SWR_CLH_BYP,                          0x00},
+	{WCD938X_DIGITAL_CDC_TX0_CTL,                          0x68},
+	{WCD938X_DIGITAL_CDC_TX1_CTL,                          0x68},
+	{WCD938X_DIGITAL_CDC_TX2_CTL,                          0x68},
+	{WCD938X_DIGITAL_CDC_TX_RST,                           0x00},
+	{WCD938X_DIGITAL_CDC_REQ_CTL,                          0x01},
+	{WCD938X_DIGITAL_CDC_RST,                              0x00},
+	{WCD938X_DIGITAL_CDC_AMIC_CTL,                         0x0F},
+	{WCD938X_DIGITAL_CDC_DMIC_CTL,                         0x04},
+	{WCD938X_DIGITAL_CDC_DMIC1_CTL,                        0x01},
+	{WCD938X_DIGITAL_CDC_DMIC2_CTL,                        0x01},
+	{WCD938X_DIGITAL_CDC_DMIC3_CTL,                        0x01},
+	{WCD938X_DIGITAL_CDC_DMIC4_CTL,                        0x01},
+	{WCD938X_DIGITAL_EFUSE_PRG_CTL,                        0x00},
+	{WCD938X_DIGITAL_EFUSE_CTL,                            0x2B},
+	{WCD938X_DIGITAL_CDC_DMIC_RATE_1_2,                    0x11},
+	{WCD938X_DIGITAL_CDC_DMIC_RATE_3_4,                    0x11},
+	{WCD938X_DIGITAL_PDM_WD_CTL0,                          0x00},
+	{WCD938X_DIGITAL_PDM_WD_CTL1,                          0x00},
+	{WCD938X_DIGITAL_PDM_WD_CTL2,                          0x00},
+	{WCD938X_DIGITAL_INTR_MODE,                            0x00},
+	{WCD938X_DIGITAL_INTR_MASK_0,                          0xFF},
+	{WCD938X_DIGITAL_INTR_MASK_1,                          0xFF},
+	{WCD938X_DIGITAL_INTR_MASK_2,                          0x3F},
+	{WCD938X_DIGITAL_INTR_STATUS_0,                        0x00},
+	{WCD938X_DIGITAL_INTR_STATUS_1,                        0x00},
+	{WCD938X_DIGITAL_INTR_STATUS_2,                        0x00},
+	{WCD938X_DIGITAL_INTR_CLEAR_0,                         0x00},
+	{WCD938X_DIGITAL_INTR_CLEAR_1,                         0x00},
+	{WCD938X_DIGITAL_INTR_CLEAR_2,                         0x00},
+	{WCD938X_DIGITAL_INTR_LEVEL_0,                         0x00},
+	{WCD938X_DIGITAL_INTR_LEVEL_1,                         0x00},
+	{WCD938X_DIGITAL_INTR_LEVEL_2,                         0x00},
+	{WCD938X_DIGITAL_INTR_SET_0,                           0x00},
+	{WCD938X_DIGITAL_INTR_SET_1,                           0x00},
+	{WCD938X_DIGITAL_INTR_SET_2,                           0x00},
+	{WCD938X_DIGITAL_INTR_TEST_0,                          0x00},
+	{WCD938X_DIGITAL_INTR_TEST_1,                          0x00},
+	{WCD938X_DIGITAL_INTR_TEST_2,                          0x00},
+	{WCD938X_DIGITAL_TX_MODE_DBG_EN,                       0x00},
+	{WCD938X_DIGITAL_TX_MODE_DBG_0_1,                      0x00},
+	{WCD938X_DIGITAL_TX_MODE_DBG_2_3,                      0x00},
+	{WCD938X_DIGITAL_LB_IN_SEL_CTL,                        0x00},
+	{WCD938X_DIGITAL_LOOP_BACK_MODE,                       0x00},
+	{WCD938X_DIGITAL_SWR_DAC_TEST,                         0x00},
+	{WCD938X_DIGITAL_SWR_HM_TEST_RX_0,                     0x40},
+	{WCD938X_DIGITAL_SWR_HM_TEST_TX_0,                     0x40},
+	{WCD938X_DIGITAL_SWR_HM_TEST_RX_1,                     0x00},
+	{WCD938X_DIGITAL_SWR_HM_TEST_TX_1,                     0x00},
+	{WCD938X_DIGITAL_SWR_HM_TEST_TX_2,                     0x00},
+	{WCD938X_DIGITAL_SWR_HM_TEST_0,                        0x00},
+	{WCD938X_DIGITAL_SWR_HM_TEST_1,                        0x00},
+	{WCD938X_DIGITAL_PAD_CTL_SWR_0,                        0x8F},
+	{WCD938X_DIGITAL_PAD_CTL_SWR_1,                        0x06},
+	{WCD938X_DIGITAL_I2C_CTL,                              0x00},
+	{WCD938X_DIGITAL_CDC_TX_TANGGU_SW_MODE,                0x00},
+	{WCD938X_DIGITAL_EFUSE_TEST_CTL_0,                     0x00},
+	{WCD938X_DIGITAL_EFUSE_TEST_CTL_1,                     0x00},
+	{WCD938X_DIGITAL_EFUSE_T_DATA_0,                       0x00},
+	{WCD938X_DIGITAL_EFUSE_T_DATA_1,                       0x00},
+	{WCD938X_DIGITAL_PAD_CTL_PDM_RX0,                      0xF1},
+	{WCD938X_DIGITAL_PAD_CTL_PDM_RX1,                      0xF1},
+	{WCD938X_DIGITAL_PAD_CTL_PDM_TX0,                      0xF1},
+	{WCD938X_DIGITAL_PAD_CTL_PDM_TX1,                      0xF1},
+	{WCD938X_DIGITAL_PAD_CTL_PDM_TX2,                      0xF1},
+	{WCD938X_DIGITAL_PAD_INP_DIS_0,                        0x00},
+	{WCD938X_DIGITAL_PAD_INP_DIS_1,                        0x00},
+	{WCD938X_DIGITAL_DRIVE_STRENGTH_0,                     0x00},
+	{WCD938X_DIGITAL_DRIVE_STRENGTH_1,                     0x00},
+	{WCD938X_DIGITAL_DRIVE_STRENGTH_2,                     0x00},
+	{WCD938X_DIGITAL_RX_DATA_EDGE_CTL,                     0x1F},
+	{WCD938X_DIGITAL_TX_DATA_EDGE_CTL,                     0x80},
+	{WCD938X_DIGITAL_GPIO_MODE,                            0x00},
+	{WCD938X_DIGITAL_PIN_CTL_OE,                           0x00},
+	{WCD938X_DIGITAL_PIN_CTL_DATA_0,                       0x00},
+	{WCD938X_DIGITAL_PIN_CTL_DATA_1,                       0x00},
+	{WCD938X_DIGITAL_PIN_STATUS_0,                         0x00},
+	{WCD938X_DIGITAL_PIN_STATUS_1,                         0x00},
+	{WCD938X_DIGITAL_DIG_DEBUG_CTL,                        0x00},
+	{WCD938X_DIGITAL_DIG_DEBUG_EN,                         0x00},
+	{WCD938X_DIGITAL_ANA_CSR_DBG_ADD,                      0x00},
+	{WCD938X_DIGITAL_ANA_CSR_DBG_CTL,                      0x48},
+	{WCD938X_DIGITAL_SSP_DBG,                              0x00},
+	{WCD938X_DIGITAL_MODE_STATUS_0,                        0x00},
+	{WCD938X_DIGITAL_MODE_STATUS_1,                        0x00},
+	{WCD938X_DIGITAL_SPARE_0,                              0x00},
+	{WCD938X_DIGITAL_SPARE_1,                              0x00},
+	{WCD938X_DIGITAL_SPARE_2,                              0x00},
+	{WCD938X_DIGITAL_EFUSE_REG_0,                          0x00},
+	{WCD938X_DIGITAL_EFUSE_REG_1,                          0xFF},
+	{WCD938X_DIGITAL_EFUSE_REG_2,                          0xFF},
+	{WCD938X_DIGITAL_EFUSE_REG_3,                          0xFF},
+	{WCD938X_DIGITAL_EFUSE_REG_4,                          0xFF},
+	{WCD938X_DIGITAL_EFUSE_REG_5,                          0xFF},
+	{WCD938X_DIGITAL_EFUSE_REG_6,                          0xFF},
+	{WCD938X_DIGITAL_EFUSE_REG_7,                          0xFF},
+	{WCD938X_DIGITAL_EFUSE_REG_8,                          0xFF},
+	{WCD938X_DIGITAL_EFUSE_REG_9,                          0xFF},
+	{WCD938X_DIGITAL_EFUSE_REG_10,                         0xFF},
+	{WCD938X_DIGITAL_EFUSE_REG_11,                         0xFF},
+	{WCD938X_DIGITAL_EFUSE_REG_12,                         0xFF},
+	{WCD938X_DIGITAL_EFUSE_REG_13,                         0xFF},
+	{WCD938X_DIGITAL_EFUSE_REG_14,                         0xFF},
+	{WCD938X_DIGITAL_EFUSE_REG_15,                         0xFF},
+	{WCD938X_DIGITAL_EFUSE_REG_16,                         0xFF},
+	{WCD938X_DIGITAL_EFUSE_REG_17,                         0xFF},
+	{WCD938X_DIGITAL_EFUSE_REG_18,                         0xFF},
+	{WCD938X_DIGITAL_EFUSE_REG_19,                         0xFF},
+	{WCD938X_DIGITAL_EFUSE_REG_20,                         0x0E},
+	{WCD938X_DIGITAL_EFUSE_REG_21,                         0x00},
+	{WCD938X_DIGITAL_EFUSE_REG_22,                         0x00},
+	{WCD938X_DIGITAL_EFUSE_REG_23,                         0xF8},
+	{WCD938X_DIGITAL_EFUSE_REG_24,                         0x16},
+	{WCD938X_DIGITAL_EFUSE_REG_25,                         0x00},
+	{WCD938X_DIGITAL_EFUSE_REG_26,                         0x00},
+	{WCD938X_DIGITAL_EFUSE_REG_27,                         0x00},
+	{WCD938X_DIGITAL_EFUSE_REG_28,                         0x00},
+	{WCD938X_DIGITAL_EFUSE_REG_29,                         0x00},
+	{WCD938X_DIGITAL_EFUSE_REG_30,                         0x00},
+	{WCD938X_DIGITAL_EFUSE_REG_31,                         0x00},
+	{WCD938X_DIGITAL_TX_REQ_FB_CTL_0,                      0x88},
+	{WCD938X_DIGITAL_TX_REQ_FB_CTL_1,                      0x88},
+	{WCD938X_DIGITAL_TX_REQ_FB_CTL_2,                      0x88},
+	{WCD938X_DIGITAL_TX_REQ_FB_CTL_3,                      0x88},
+	{WCD938X_DIGITAL_TX_REQ_FB_CTL_4,                      0x88},
+	{WCD938X_DIGITAL_DEM_BYPASS_DATA0,                     0x55},
+	{WCD938X_DIGITAL_DEM_BYPASS_DATA1,                     0x55},
+	{WCD938X_DIGITAL_DEM_BYPASS_DATA2,                     0x55},
+	{WCD938X_DIGITAL_DEM_BYPASS_DATA3,                     0x01},
+};
+
+static bool wcd938x_rdwr_register(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case WCD938X_ANA_PAGE_REGISTER:
+	case WCD938X_ANA_BIAS:
+	case WCD938X_ANA_RX_SUPPLIES:
+	case WCD938X_ANA_HPH:
+	case WCD938X_ANA_EAR:
+	case WCD938X_ANA_EAR_COMPANDER_CTL:
+	case WCD938X_ANA_TX_CH1:
+	case WCD938X_ANA_TX_CH2:
+	case WCD938X_ANA_TX_CH3:
+	case WCD938X_ANA_TX_CH4:
+	case WCD938X_ANA_MICB1_MICB2_DSP_EN_LOGIC:
+	case WCD938X_ANA_MICB3_DSP_EN_LOGIC:
+	case WCD938X_ANA_MBHC_MECH:
+	case WCD938X_ANA_MBHC_ELECT:
+	case WCD938X_ANA_MBHC_ZDET:
+	case WCD938X_ANA_MBHC_BTN0:
+	case WCD938X_ANA_MBHC_BTN1:
+	case WCD938X_ANA_MBHC_BTN2:
+	case WCD938X_ANA_MBHC_BTN3:
+	case WCD938X_ANA_MBHC_BTN4:
+	case WCD938X_ANA_MBHC_BTN5:
+	case WCD938X_ANA_MBHC_BTN6:
+	case WCD938X_ANA_MBHC_BTN7:
+	case WCD938X_ANA_MICB1:
+	case WCD938X_ANA_MICB2:
+	case WCD938X_ANA_MICB2_RAMP:
+	case WCD938X_ANA_MICB3:
+	case WCD938X_ANA_MICB4:
+	case WCD938X_BIAS_CTL:
+	case WCD938X_BIAS_VBG_FINE_ADJ:
+	case WCD938X_LDOL_VDDCX_ADJUST:
+	case WCD938X_LDOL_DISABLE_LDOL:
+	case WCD938X_MBHC_CTL_CLK:
+	case WCD938X_MBHC_CTL_ANA:
+	case WCD938X_MBHC_CTL_SPARE_1:
+	case WCD938X_MBHC_CTL_SPARE_2:
+	case WCD938X_MBHC_CTL_BCS:
+	case WCD938X_MBHC_TEST_CTL:
+	case WCD938X_LDOH_MODE:
+	case WCD938X_LDOH_BIAS:
+	case WCD938X_LDOH_STB_LOADS:
+	case WCD938X_LDOH_SLOWRAMP:
+	case WCD938X_MICB1_TEST_CTL_1:
+	case WCD938X_MICB1_TEST_CTL_2:
+	case WCD938X_MICB1_TEST_CTL_3:
+	case WCD938X_MICB2_TEST_CTL_1:
+	case WCD938X_MICB2_TEST_CTL_2:
+	case WCD938X_MICB2_TEST_CTL_3:
+	case WCD938X_MICB3_TEST_CTL_1:
+	case WCD938X_MICB3_TEST_CTL_2:
+	case WCD938X_MICB3_TEST_CTL_3:
+	case WCD938X_MICB4_TEST_CTL_1:
+	case WCD938X_MICB4_TEST_CTL_2:
+	case WCD938X_MICB4_TEST_CTL_3:
+	case WCD938X_TX_COM_ADC_VCM:
+	case WCD938X_TX_COM_BIAS_ATEST:
+	case WCD938X_TX_COM_SPARE1:
+	case WCD938X_TX_COM_SPARE2:
+	case WCD938X_TX_COM_TXFE_DIV_CTL:
+	case WCD938X_TX_COM_TXFE_DIV_START:
+	case WCD938X_TX_COM_SPARE3:
+	case WCD938X_TX_COM_SPARE4:
+	case WCD938X_TX_1_2_TEST_EN:
+	case WCD938X_TX_1_2_ADC_IB:
+	case WCD938X_TX_1_2_ATEST_REFCTL:
+	case WCD938X_TX_1_2_TEST_CTL:
+	case WCD938X_TX_1_2_TEST_BLK_EN1:
+	case WCD938X_TX_1_2_TXFE1_CLKDIV:
+	case WCD938X_TX_3_4_TEST_EN:
+	case WCD938X_TX_3_4_ADC_IB:
+	case WCD938X_TX_3_4_ATEST_REFCTL:
+	case WCD938X_TX_3_4_TEST_CTL:
+	case WCD938X_TX_3_4_TEST_BLK_EN3:
+	case WCD938X_TX_3_4_TXFE3_CLKDIV:
+	case WCD938X_TX_3_4_TEST_BLK_EN2:
+	case WCD938X_TX_3_4_TXFE2_CLKDIV:
+	case WCD938X_TX_3_4_SPARE1:
+	case WCD938X_TX_3_4_TEST_BLK_EN4:
+	case WCD938X_TX_3_4_TXFE4_CLKDIV:
+	case WCD938X_TX_3_4_SPARE2:
+	case WCD938X_CLASSH_MODE_1:
+	case WCD938X_CLASSH_MODE_2:
+	case WCD938X_CLASSH_MODE_3:
+	case WCD938X_CLASSH_CTRL_VCL_1:
+	case WCD938X_CLASSH_CTRL_VCL_2:
+	case WCD938X_CLASSH_CTRL_CCL_1:
+	case WCD938X_CLASSH_CTRL_CCL_2:
+	case WCD938X_CLASSH_CTRL_CCL_3:
+	case WCD938X_CLASSH_CTRL_CCL_4:
+	case WCD938X_CLASSH_CTRL_CCL_5:
+	case WCD938X_CLASSH_BUCK_TMUX_A_D:
+	case WCD938X_CLASSH_BUCK_SW_DRV_CNTL:
+	case WCD938X_CLASSH_SPARE:
+	case WCD938X_FLYBACK_EN:
+	case WCD938X_FLYBACK_VNEG_CTRL_1:
+	case WCD938X_FLYBACK_VNEG_CTRL_2:
+	case WCD938X_FLYBACK_VNEG_CTRL_3:
+	case WCD938X_FLYBACK_VNEG_CTRL_4:
+	case WCD938X_FLYBACK_VNEG_CTRL_5:
+	case WCD938X_FLYBACK_VNEG_CTRL_6:
+	case WCD938X_FLYBACK_VNEG_CTRL_7:
+	case WCD938X_FLYBACK_VNEG_CTRL_8:
+	case WCD938X_FLYBACK_VNEG_CTRL_9:
+	case WCD938X_FLYBACK_VNEGDAC_CTRL_1:
+	case WCD938X_FLYBACK_VNEGDAC_CTRL_2:
+	case WCD938X_FLYBACK_VNEGDAC_CTRL_3:
+	case WCD938X_FLYBACK_CTRL_1:
+	case WCD938X_FLYBACK_TEST_CTL:
+	case WCD938X_RX_AUX_SW_CTL:
+	case WCD938X_RX_PA_AUX_IN_CONN:
+	case WCD938X_RX_TIMER_DIV:
+	case WCD938X_RX_OCP_CTL:
+	case WCD938X_RX_OCP_COUNT:
+	case WCD938X_RX_BIAS_EAR_DAC:
+	case WCD938X_RX_BIAS_EAR_AMP:
+	case WCD938X_RX_BIAS_HPH_LDO:
+	case WCD938X_RX_BIAS_HPH_PA:
+	case WCD938X_RX_BIAS_HPH_RDACBUFF_CNP2:
+	case WCD938X_RX_BIAS_HPH_RDAC_LDO:
+	case WCD938X_RX_BIAS_HPH_CNP1:
+	case WCD938X_RX_BIAS_HPH_LOWPOWER:
+	case WCD938X_RX_BIAS_AUX_DAC:
+	case WCD938X_RX_BIAS_AUX_AMP:
+	case WCD938X_RX_BIAS_VNEGDAC_BLEEDER:
+	case WCD938X_RX_BIAS_MISC:
+	case WCD938X_RX_BIAS_BUCK_RST:
+	case WCD938X_RX_BIAS_BUCK_VREF_ERRAMP:
+	case WCD938X_RX_BIAS_FLYB_ERRAMP:
+	case WCD938X_RX_BIAS_FLYB_BUFF:
+	case WCD938X_RX_BIAS_FLYB_MID_RST:
+	case WCD938X_HPH_CNP_EN:
+	case WCD938X_HPH_CNP_WG_CTL:
+	case WCD938X_HPH_CNP_WG_TIME:
+	case WCD938X_HPH_OCP_CTL:
+	case WCD938X_HPH_AUTO_CHOP:
+	case WCD938X_HPH_CHOP_CTL:
+	case WCD938X_HPH_PA_CTL1:
+	case WCD938X_HPH_PA_CTL2:
+	case WCD938X_HPH_L_EN:
+	case WCD938X_HPH_L_TEST:
+	case WCD938X_HPH_L_ATEST:
+	case WCD938X_HPH_R_EN:
+	case WCD938X_HPH_R_TEST:
+	case WCD938X_HPH_R_ATEST:
+	case WCD938X_HPH_RDAC_CLK_CTL1:
+	case WCD938X_HPH_RDAC_CLK_CTL2:
+	case WCD938X_HPH_RDAC_LDO_CTL:
+	case WCD938X_HPH_RDAC_CHOP_CLK_LP_CTL:
+	case WCD938X_HPH_REFBUFF_UHQA_CTL:
+	case WCD938X_HPH_REFBUFF_LP_CTL:
+	case WCD938X_HPH_L_DAC_CTL:
+	case WCD938X_HPH_R_DAC_CTL:
+	case WCD938X_HPH_SURGE_HPHLR_SURGE_COMP_SEL:
+	case WCD938X_HPH_SURGE_HPHLR_SURGE_EN:
+	case WCD938X_HPH_SURGE_HPHLR_SURGE_MISC1:
+	case WCD938X_EAR_EAR_EN_REG:
+	case WCD938X_EAR_EAR_PA_CON:
+	case WCD938X_EAR_EAR_SP_CON:
+	case WCD938X_EAR_EAR_DAC_CON:
+	case WCD938X_EAR_EAR_CNP_FSM_CON:
+	case WCD938X_EAR_TEST_CTL:
+	case WCD938X_ANA_NEW_PAGE_REGISTER:
+	case WCD938X_HPH_NEW_ANA_HPH2:
+	case WCD938X_HPH_NEW_ANA_HPH3:
+	case WCD938X_SLEEP_CTL:
+	case WCD938X_SLEEP_WATCHDOG_CTL:
+	case WCD938X_MBHC_NEW_ELECT_REM_CLAMP_CTL:
+	case WCD938X_MBHC_NEW_CTL_1:
+	case WCD938X_MBHC_NEW_CTL_2:
+	case WCD938X_MBHC_NEW_PLUG_DETECT_CTL:
+	case WCD938X_MBHC_NEW_ZDET_ANA_CTL:
+	case WCD938X_MBHC_NEW_ZDET_RAMP_CTL:
+	case WCD938X_TX_NEW_AMIC_MUX_CFG:
+	case WCD938X_AUX_AUXPA:
+	case WCD938X_LDORXTX_MODE:
+	case WCD938X_LDORXTX_CONFIG:
+	case WCD938X_DIE_CRACK_DIE_CRK_DET_EN:
+	case WCD938X_HPH_NEW_INT_RDAC_GAIN_CTL:
+	case WCD938X_HPH_NEW_INT_RDAC_HD2_CTL_L:
+	case WCD938X_HPH_NEW_INT_RDAC_VREF_CTL:
+	case WCD938X_HPH_NEW_INT_RDAC_OVERRIDE_CTL:
+	case WCD938X_HPH_NEW_INT_RDAC_HD2_CTL_R:
+	case WCD938X_HPH_NEW_INT_PA_MISC1:
+	case WCD938X_HPH_NEW_INT_PA_MISC2:
+	case WCD938X_HPH_NEW_INT_PA_RDAC_MISC:
+	case WCD938X_HPH_NEW_INT_HPH_TIMER1:
+	case WCD938X_HPH_NEW_INT_HPH_TIMER2:
+	case WCD938X_HPH_NEW_INT_HPH_TIMER3:
+	case WCD938X_HPH_NEW_INT_HPH_TIMER4:
+	case WCD938X_HPH_NEW_INT_PA_RDAC_MISC2:
+	case WCD938X_HPH_NEW_INT_PA_RDAC_MISC3:
+	case WCD938X_HPH_NEW_INT_RDAC_HD2_CTL_L_NEW:
+	case WCD938X_HPH_NEW_INT_RDAC_HD2_CTL_R_NEW:
+	case WCD938X_RX_NEW_INT_HPH_RDAC_BIAS_LOHIFI:
+	case WCD938X_RX_NEW_INT_HPH_RDAC_BIAS_ULP:
+	case WCD938X_RX_NEW_INT_HPH_RDAC_LDO_LP:
+	case WCD938X_MBHC_NEW_INT_MOISTURE_DET_DC_CTRL:
+	case WCD938X_MBHC_NEW_INT_MOISTURE_DET_POLLING_CTRL:
+	case WCD938X_MBHC_NEW_INT_MECH_DET_CURRENT:
+	case WCD938X_MBHC_NEW_INT_SPARE_2:
+	case WCD938X_EAR_INT_NEW_EAR_CHOPPER_CON:
+	case WCD938X_EAR_INT_NEW_CNP_VCM_CON1:
+	case WCD938X_EAR_INT_NEW_CNP_VCM_CON2:
+	case WCD938X_EAR_INT_NEW_EAR_DYNAMIC_BIAS:
+	case WCD938X_AUX_INT_EN_REG:
+	case WCD938X_AUX_INT_PA_CTRL:
+	case WCD938X_AUX_INT_SP_CTRL:
+	case WCD938X_AUX_INT_DAC_CTRL:
+	case WCD938X_AUX_INT_CLK_CTRL:
+	case WCD938X_AUX_INT_TEST_CTRL:
+	case WCD938X_AUX_INT_MISC:
+	case WCD938X_LDORXTX_INT_BIAS:
+	case WCD938X_LDORXTX_INT_STB_LOADS_DTEST:
+	case WCD938X_LDORXTX_INT_TEST0:
+	case WCD938X_LDORXTX_INT_STARTUP_TIMER:
+	case WCD938X_LDORXTX_INT_TEST1:
+	case WCD938X_SLEEP_INT_WATCHDOG_CTL_1:
+	case WCD938X_SLEEP_INT_WATCHDOG_CTL_2:
+	case WCD938X_DIE_CRACK_INT_DIE_CRK_DET_INT1:
+	case WCD938X_DIE_CRACK_INT_DIE_CRK_DET_INT2:
+	case WCD938X_TX_COM_NEW_INT_TXFE_DIVSTOP_L2:
+	case WCD938X_TX_COM_NEW_INT_TXFE_DIVSTOP_L1:
+	case WCD938X_TX_COM_NEW_INT_TXFE_DIVSTOP_L0:
+	case WCD938X_TX_COM_NEW_INT_TXFE_DIVSTOP_ULP1P2M:
+	case WCD938X_TX_COM_NEW_INT_TXFE_DIVSTOP_ULP0P6M:
+	case WCD938X_TX_COM_NEW_INT_TXFE_ICTRL_STG1_L2L1:
+	case WCD938X_TX_COM_NEW_INT_TXFE_ICTRL_STG1_L0:
+	case WCD938X_TX_COM_NEW_INT_TXFE_ICTRL_STG1_ULP:
+	case WCD938X_TX_COM_NEW_INT_TXFE_ICTRL_STG2MAIN_L2L1:
+	case WCD938X_TX_COM_NEW_INT_TXFE_ICTRL_STG2MAIN_L0:
+	case WCD938X_TX_COM_NEW_INT_TXFE_ICTRL_STG2MAIN_ULP:
+	case WCD938X_TX_COM_NEW_INT_TXFE_ICTRL_STG2CASC_L2L1L0:
+	case WCD938X_TX_COM_NEW_INT_TXFE_ICTRL_STG2CASC_ULP:
+	case WCD938X_TX_COM_NEW_INT_TXADC_SCBIAS_L2L1:
+	case WCD938X_TX_COM_NEW_INT_TXADC_SCBIAS_L0ULP:
+	case WCD938X_TX_COM_NEW_INT_TXADC_INT_L2:
+	case WCD938X_TX_COM_NEW_INT_TXADC_INT_L1:
+	case WCD938X_TX_COM_NEW_INT_TXADC_INT_L0:
+	case WCD938X_TX_COM_NEW_INT_TXADC_INT_ULP:
+	case WCD938X_DIGITAL_PAGE_REGISTER:
+	case WCD938X_DIGITAL_SWR_TX_CLK_RATE:
+	case WCD938X_DIGITAL_CDC_RST_CTL:
+	case WCD938X_DIGITAL_TOP_CLK_CFG:
+	case WCD938X_DIGITAL_CDC_ANA_CLK_CTL:
+	case WCD938X_DIGITAL_CDC_DIG_CLK_CTL:
+	case WCD938X_DIGITAL_SWR_RST_EN:
+	case WCD938X_DIGITAL_CDC_PATH_MODE:
+	case WCD938X_DIGITAL_CDC_RX_RST:
+	case WCD938X_DIGITAL_CDC_RX0_CTL:
+	case WCD938X_DIGITAL_CDC_RX1_CTL:
+	case WCD938X_DIGITAL_CDC_RX2_CTL:
+	case WCD938X_DIGITAL_CDC_TX_ANA_MODE_0_1:
+	case WCD938X_DIGITAL_CDC_TX_ANA_MODE_2_3:
+	case WCD938X_DIGITAL_CDC_COMP_CTL_0:
+	case WCD938X_DIGITAL_CDC_ANA_TX_CLK_CTL:
+	case WCD938X_DIGITAL_CDC_HPH_DSM_A1_0:
+	case WCD938X_DIGITAL_CDC_HPH_DSM_A1_1:
+	case WCD938X_DIGITAL_CDC_HPH_DSM_A2_0:
+	case WCD938X_DIGITAL_CDC_HPH_DSM_A2_1:
+	case WCD938X_DIGITAL_CDC_HPH_DSM_A3_0:
+	case WCD938X_DIGITAL_CDC_HPH_DSM_A3_1:
+	case WCD938X_DIGITAL_CDC_HPH_DSM_A4_0:
+	case WCD938X_DIGITAL_CDC_HPH_DSM_A4_1:
+	case WCD938X_DIGITAL_CDC_HPH_DSM_A5_0:
+	case WCD938X_DIGITAL_CDC_HPH_DSM_A5_1:
+	case WCD938X_DIGITAL_CDC_HPH_DSM_A6_0:
+	case WCD938X_DIGITAL_CDC_HPH_DSM_A7_0:
+	case WCD938X_DIGITAL_CDC_HPH_DSM_C_0:
+	case WCD938X_DIGITAL_CDC_HPH_DSM_C_1:
+	case WCD938X_DIGITAL_CDC_HPH_DSM_C_2:
+	case WCD938X_DIGITAL_CDC_HPH_DSM_C_3:
+	case WCD938X_DIGITAL_CDC_HPH_DSM_R1:
+	case WCD938X_DIGITAL_CDC_HPH_DSM_R2:
+	case WCD938X_DIGITAL_CDC_HPH_DSM_R3:
+	case WCD938X_DIGITAL_CDC_HPH_DSM_R4:
+	case WCD938X_DIGITAL_CDC_HPH_DSM_R5:
+	case WCD938X_DIGITAL_CDC_HPH_DSM_R6:
+	case WCD938X_DIGITAL_CDC_HPH_DSM_R7:
+	case WCD938X_DIGITAL_CDC_AUX_DSM_A1_0:
+	case WCD938X_DIGITAL_CDC_AUX_DSM_A1_1:
+	case WCD938X_DIGITAL_CDC_AUX_DSM_A2_0:
+	case WCD938X_DIGITAL_CDC_AUX_DSM_A2_1:
+	case WCD938X_DIGITAL_CDC_AUX_DSM_A3_0:
+	case WCD938X_DIGITAL_CDC_AUX_DSM_A3_1:
+	case WCD938X_DIGITAL_CDC_AUX_DSM_A4_0:
+	case WCD938X_DIGITAL_CDC_AUX_DSM_A4_1:
+	case WCD938X_DIGITAL_CDC_AUX_DSM_A5_0:
+	case WCD938X_DIGITAL_CDC_AUX_DSM_A5_1:
+	case WCD938X_DIGITAL_CDC_AUX_DSM_A6_0:
+	case WCD938X_DIGITAL_CDC_AUX_DSM_A7_0:
+	case WCD938X_DIGITAL_CDC_AUX_DSM_C_0:
+	case WCD938X_DIGITAL_CDC_AUX_DSM_C_1:
+	case WCD938X_DIGITAL_CDC_AUX_DSM_C_2:
+	case WCD938X_DIGITAL_CDC_AUX_DSM_C_3:
+	case WCD938X_DIGITAL_CDC_AUX_DSM_R1:
+	case WCD938X_DIGITAL_CDC_AUX_DSM_R2:
+	case WCD938X_DIGITAL_CDC_AUX_DSM_R3:
+	case WCD938X_DIGITAL_CDC_AUX_DSM_R4:
+	case WCD938X_DIGITAL_CDC_AUX_DSM_R5:
+	case WCD938X_DIGITAL_CDC_AUX_DSM_R6:
+	case WCD938X_DIGITAL_CDC_AUX_DSM_R7:
+	case WCD938X_DIGITAL_CDC_HPH_GAIN_RX_0:
+	case WCD938X_DIGITAL_CDC_HPH_GAIN_RX_1:
+	case WCD938X_DIGITAL_CDC_HPH_GAIN_DSD_0:
+	case WCD938X_DIGITAL_CDC_HPH_GAIN_DSD_1:
+	case WCD938X_DIGITAL_CDC_HPH_GAIN_DSD_2:
+	case WCD938X_DIGITAL_CDC_AUX_GAIN_DSD_0:
+	case WCD938X_DIGITAL_CDC_AUX_GAIN_DSD_1:
+	case WCD938X_DIGITAL_CDC_AUX_GAIN_DSD_2:
+	case WCD938X_DIGITAL_CDC_HPH_GAIN_CTL:
+	case WCD938X_DIGITAL_CDC_AUX_GAIN_CTL:
+	case WCD938X_DIGITAL_CDC_EAR_PATH_CTL:
+	case WCD938X_DIGITAL_CDC_SWR_CLH:
+	case WCD938X_DIGITAL_SWR_CLH_BYP:
+	case WCD938X_DIGITAL_CDC_TX0_CTL:
+	case WCD938X_DIGITAL_CDC_TX1_CTL:
+	case WCD938X_DIGITAL_CDC_TX2_CTL:
+	case WCD938X_DIGITAL_CDC_TX_RST:
+	case WCD938X_DIGITAL_CDC_REQ_CTL:
+	case WCD938X_DIGITAL_CDC_RST:
+	case WCD938X_DIGITAL_CDC_AMIC_CTL:
+	case WCD938X_DIGITAL_CDC_DMIC_CTL:
+	case WCD938X_DIGITAL_CDC_DMIC1_CTL:
+	case WCD938X_DIGITAL_CDC_DMIC2_CTL:
+	case WCD938X_DIGITAL_CDC_DMIC3_CTL:
+	case WCD938X_DIGITAL_CDC_DMIC4_CTL:
+	case WCD938X_DIGITAL_EFUSE_PRG_CTL:
+	case WCD938X_DIGITAL_EFUSE_CTL:
+	case WCD938X_DIGITAL_CDC_DMIC_RATE_1_2:
+	case WCD938X_DIGITAL_CDC_DMIC_RATE_3_4:
+	case WCD938X_DIGITAL_PDM_WD_CTL0:
+	case WCD938X_DIGITAL_PDM_WD_CTL1:
+	case WCD938X_DIGITAL_PDM_WD_CTL2:
+	case WCD938X_DIGITAL_INTR_MODE:
+	case WCD938X_DIGITAL_INTR_MASK_0:
+	case WCD938X_DIGITAL_INTR_MASK_1:
+	case WCD938X_DIGITAL_INTR_MASK_2:
+	case WCD938X_DIGITAL_INTR_CLEAR_0:
+	case WCD938X_DIGITAL_INTR_CLEAR_1:
+	case WCD938X_DIGITAL_INTR_CLEAR_2:
+	case WCD938X_DIGITAL_INTR_LEVEL_0:
+	case WCD938X_DIGITAL_INTR_LEVEL_1:
+	case WCD938X_DIGITAL_INTR_LEVEL_2:
+	case WCD938X_DIGITAL_INTR_SET_0:
+	case WCD938X_DIGITAL_INTR_SET_1:
+	case WCD938X_DIGITAL_INTR_SET_2:
+	case WCD938X_DIGITAL_INTR_TEST_0:
+	case WCD938X_DIGITAL_INTR_TEST_1:
+	case WCD938X_DIGITAL_INTR_TEST_2:
+	case WCD938X_DIGITAL_TX_MODE_DBG_EN:
+	case WCD938X_DIGITAL_TX_MODE_DBG_0_1:
+	case WCD938X_DIGITAL_TX_MODE_DBG_2_3:
+	case WCD938X_DIGITAL_LB_IN_SEL_CTL:
+	case WCD938X_DIGITAL_LOOP_BACK_MODE:
+	case WCD938X_DIGITAL_SWR_DAC_TEST:
+	case WCD938X_DIGITAL_SWR_HM_TEST_RX_0:
+	case WCD938X_DIGITAL_SWR_HM_TEST_TX_0:
+	case WCD938X_DIGITAL_SWR_HM_TEST_RX_1:
+	case WCD938X_DIGITAL_SWR_HM_TEST_TX_1:
+	case WCD938X_DIGITAL_SWR_HM_TEST_TX_2:
+	case WCD938X_DIGITAL_PAD_CTL_SWR_0:
+	case WCD938X_DIGITAL_PAD_CTL_SWR_1:
+	case WCD938X_DIGITAL_I2C_CTL:
+	case WCD938X_DIGITAL_CDC_TX_TANGGU_SW_MODE:
+	case WCD938X_DIGITAL_EFUSE_TEST_CTL_0:
+	case WCD938X_DIGITAL_EFUSE_TEST_CTL_1:
+	case WCD938X_DIGITAL_PAD_CTL_PDM_RX0:
+	case WCD938X_DIGITAL_PAD_CTL_PDM_RX1:
+	case WCD938X_DIGITAL_PAD_CTL_PDM_TX0:
+	case WCD938X_DIGITAL_PAD_CTL_PDM_TX1:
+	case WCD938X_DIGITAL_PAD_CTL_PDM_TX2:
+	case WCD938X_DIGITAL_PAD_INP_DIS_0:
+	case WCD938X_DIGITAL_PAD_INP_DIS_1:
+	case WCD938X_DIGITAL_DRIVE_STRENGTH_0:
+	case WCD938X_DIGITAL_DRIVE_STRENGTH_1:
+	case WCD938X_DIGITAL_DRIVE_STRENGTH_2:
+	case WCD938X_DIGITAL_RX_DATA_EDGE_CTL:
+	case WCD938X_DIGITAL_TX_DATA_EDGE_CTL:
+	case WCD938X_DIGITAL_GPIO_MODE:
+	case WCD938X_DIGITAL_PIN_CTL_OE:
+	case WCD938X_DIGITAL_PIN_CTL_DATA_0:
+	case WCD938X_DIGITAL_PIN_CTL_DATA_1:
+	case WCD938X_DIGITAL_DIG_DEBUG_CTL:
+	case WCD938X_DIGITAL_DIG_DEBUG_EN:
+	case WCD938X_DIGITAL_ANA_CSR_DBG_ADD:
+	case WCD938X_DIGITAL_ANA_CSR_DBG_CTL:
+	case WCD938X_DIGITAL_SSP_DBG:
+	case WCD938X_DIGITAL_SPARE_0:
+	case WCD938X_DIGITAL_SPARE_1:
+	case WCD938X_DIGITAL_SPARE_2:
+	case WCD938X_DIGITAL_TX_REQ_FB_CTL_0:
+	case WCD938X_DIGITAL_TX_REQ_FB_CTL_1:
+	case WCD938X_DIGITAL_TX_REQ_FB_CTL_2:
+	case WCD938X_DIGITAL_TX_REQ_FB_CTL_3:
+	case WCD938X_DIGITAL_TX_REQ_FB_CTL_4:
+	case WCD938X_DIGITAL_DEM_BYPASS_DATA0:
+	case WCD938X_DIGITAL_DEM_BYPASS_DATA1:
+	case WCD938X_DIGITAL_DEM_BYPASS_DATA2:
+	case WCD938X_DIGITAL_DEM_BYPASS_DATA3:
+		return true;
+	}
+
+	return false;
+}
+
+static bool wcd938x_readonly_register(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case WCD938X_ANA_MBHC_RESULT_1:
+	case WCD938X_ANA_MBHC_RESULT_2:
+	case WCD938X_ANA_MBHC_RESULT_3:
+	case WCD938X_MBHC_MOISTURE_DET_FSM_STATUS:
+	case WCD938X_TX_1_2_SAR2_ERR:
+	case WCD938X_TX_1_2_SAR1_ERR:
+	case WCD938X_TX_3_4_SAR4_ERR:
+	case WCD938X_TX_3_4_SAR3_ERR:
+	case WCD938X_HPH_L_STATUS:
+	case WCD938X_HPH_R_STATUS:
+	case WCD938X_HPH_SURGE_HPHLR_SURGE_STATUS:
+	case WCD938X_EAR_STATUS_REG_1:
+	case WCD938X_EAR_STATUS_REG_2:
+	case WCD938X_MBHC_NEW_FSM_STATUS:
+	case WCD938X_MBHC_NEW_ADC_RESULT:
+	case WCD938X_DIE_CRACK_DIE_CRK_DET_OUT:
+	case WCD938X_AUX_INT_STATUS_REG:
+	case WCD938X_LDORXTX_INT_STATUS:
+	case WCD938X_DIGITAL_CHIP_ID0:
+	case WCD938X_DIGITAL_CHIP_ID1:
+	case WCD938X_DIGITAL_CHIP_ID2:
+	case WCD938X_DIGITAL_CHIP_ID3:
+	case WCD938X_DIGITAL_INTR_STATUS_0:
+	case WCD938X_DIGITAL_INTR_STATUS_1:
+	case WCD938X_DIGITAL_INTR_STATUS_2:
+	case WCD938X_DIGITAL_INTR_CLEAR_0:
+	case WCD938X_DIGITAL_INTR_CLEAR_1:
+	case WCD938X_DIGITAL_INTR_CLEAR_2:
+	case WCD938X_DIGITAL_SWR_HM_TEST_0:
+	case WCD938X_DIGITAL_SWR_HM_TEST_1:
+	case WCD938X_DIGITAL_EFUSE_T_DATA_0:
+	case WCD938X_DIGITAL_EFUSE_T_DATA_1:
+	case WCD938X_DIGITAL_PIN_STATUS_0:
+	case WCD938X_DIGITAL_PIN_STATUS_1:
+	case WCD938X_DIGITAL_MODE_STATUS_0:
+	case WCD938X_DIGITAL_MODE_STATUS_1:
+	case WCD938X_DIGITAL_EFUSE_REG_0:
+	case WCD938X_DIGITAL_EFUSE_REG_1:
+	case WCD938X_DIGITAL_EFUSE_REG_2:
+	case WCD938X_DIGITAL_EFUSE_REG_3:
+	case WCD938X_DIGITAL_EFUSE_REG_4:
+	case WCD938X_DIGITAL_EFUSE_REG_5:
+	case WCD938X_DIGITAL_EFUSE_REG_6:
+	case WCD938X_DIGITAL_EFUSE_REG_7:
+	case WCD938X_DIGITAL_EFUSE_REG_8:
+	case WCD938X_DIGITAL_EFUSE_REG_9:
+	case WCD938X_DIGITAL_EFUSE_REG_10:
+	case WCD938X_DIGITAL_EFUSE_REG_11:
+	case WCD938X_DIGITAL_EFUSE_REG_12:
+	case WCD938X_DIGITAL_EFUSE_REG_13:
+	case WCD938X_DIGITAL_EFUSE_REG_14:
+	case WCD938X_DIGITAL_EFUSE_REG_15:
+	case WCD938X_DIGITAL_EFUSE_REG_16:
+	case WCD938X_DIGITAL_EFUSE_REG_17:
+	case WCD938X_DIGITAL_EFUSE_REG_18:
+	case WCD938X_DIGITAL_EFUSE_REG_19:
+	case WCD938X_DIGITAL_EFUSE_REG_20:
+	case WCD938X_DIGITAL_EFUSE_REG_21:
+	case WCD938X_DIGITAL_EFUSE_REG_22:
+	case WCD938X_DIGITAL_EFUSE_REG_23:
+	case WCD938X_DIGITAL_EFUSE_REG_24:
+	case WCD938X_DIGITAL_EFUSE_REG_25:
+	case WCD938X_DIGITAL_EFUSE_REG_26:
+	case WCD938X_DIGITAL_EFUSE_REG_27:
+	case WCD938X_DIGITAL_EFUSE_REG_28:
+	case WCD938X_DIGITAL_EFUSE_REG_29:
+	case WCD938X_DIGITAL_EFUSE_REG_30:
+	case WCD938X_DIGITAL_EFUSE_REG_31:
+		return true;
+	}
+	return false;
+}
+
+static bool wcd938x_readable_register(struct device *dev, unsigned int reg)
+{
+	bool ret;
+
+	ret = wcd938x_readonly_register(dev, reg);
+	if (!ret)
+		return wcd938x_rdwr_register(dev, reg);
+
+	return ret;
+}
+
+static bool wcd938x_writeable_register(struct device *dev, unsigned int reg)
+{
+	return wcd938x_rdwr_register(dev, reg);
+}
+
+static bool wcd938x_volatile_register(struct device *dev, unsigned int reg)
+{
+	if (reg <= WCD938X_BASE_ADDRESS)
+		return false;
+
+	if (reg == WCD938X_DIGITAL_SWR_TX_CLK_RATE)
+		return true;
+
+	if (wcd938x_readonly_register(dev, reg))
+		return true;
+
+	return false;
+}
+
+static const struct regmap_config wcd938x_regmap_config = {
+	.name = "wcd938x_csr",
+	.reg_bits = 32,
+	.val_bits = 8,
+	.cache_type = REGCACHE_RBTREE,
+	.reg_defaults = wcd938x_defaults,
+	.num_reg_defaults = ARRAY_SIZE(wcd938x_defaults),
+	.max_register = WCD938X_MAX_REGISTER,
+	.readable_reg = wcd938x_readable_register,
+	.writeable_reg = wcd938x_writeable_register,
+	.volatile_reg = wcd938x_volatile_register,
+	.can_multi_write = true,
+};
+
+static const struct sdw_slave_ops wcd9380_slave_ops = {
 	.update_status = wcd9380_update_status,
 	.interrupt_callback = wcd9380_interrupt_callback,
 	.bus_config = wcd9380_bus_config,
@@ -261,6 +1263,16 @@ static int wcd9380_probe(struct sdw_slave *pdev,
 		wcd->ch_info = &wcd938x_sdw_rx_ch_info[0];
 	}
 
+	if (wcd->is_tx) {
+		wcd->regmap = devm_regmap_init_sdw(pdev, &wcd938x_regmap_config);
+		if (IS_ERR(wcd->regmap))
+			return dev_err_probe(dev, PTR_ERR(wcd->regmap),
+					     "Regmap init failed\n");
+
+		/* Start in cache-only until device is enumerated */
+		regcache_cache_only(wcd->regmap, true);
+	};
+
 	pm_runtime_set_autosuspend_delay(dev, 3000);
 	pm_runtime_use_autosuspend(dev);
 	pm_runtime_mark_last_busy(dev);
@@ -278,22 +1290,23 @@ MODULE_DEVICE_TABLE(sdw, wcd9380_slave_id);
 
 static int __maybe_unused wcd938x_sdw_runtime_suspend(struct device *dev)
 {
-	struct regmap *regmap = dev_get_regmap(dev, NULL);
+	struct wcd938x_sdw_priv *wcd = dev_get_drvdata(dev);
 
-	if (regmap) {
-		regcache_cache_only(regmap, true);
-		regcache_mark_dirty(regmap);
+	if (wcd->regmap) {
+		regcache_cache_only(wcd->regmap, true);
+		regcache_mark_dirty(wcd->regmap);
 	}
+
 	return 0;
 }
 
 static int __maybe_unused wcd938x_sdw_runtime_resume(struct device *dev)
 {
-	struct regmap *regmap = dev_get_regmap(dev, NULL);
+	struct wcd938x_sdw_priv *wcd = dev_get_drvdata(dev);
 
-	if (regmap) {
-		regcache_cache_only(regmap, false);
-		regcache_sync(regmap);
+	if (wcd->regmap) {
+		regcache_cache_only(wcd->regmap, false);
+		regcache_sync(wcd->regmap);
 	}
 
 	pm_runtime_mark_last_busy(dev);
diff --git a/sound/soc/codecs/wcd938x.c b/sound/soc/codecs/wcd938x.c
index fcac763b04d1..d34f13758aca 100644
--- a/sound/soc/codecs/wcd938x.c
+++ b/sound/soc/codecs/wcd938x.c
@@ -273,1001 +273,6 @@ static struct wcd_mbhc_field wcd_mbhc_fields[WCD_MBHC_REG_FUNC_MAX] = {
 	WCD_MBHC_FIELD(WCD_MBHC_ELECT_ISRC_EN, WCD938X_ANA_MBHC_ZDET, 0x02),
 };
 
-static const struct reg_default wcd938x_defaults[] = {
-	{WCD938X_ANA_PAGE_REGISTER,                            0x00},
-	{WCD938X_ANA_BIAS,                                     0x00},
-	{WCD938X_ANA_RX_SUPPLIES,                              0x00},
-	{WCD938X_ANA_HPH,                                      0x0C},
-	{WCD938X_ANA_EAR,                                      0x00},
-	{WCD938X_ANA_EAR_COMPANDER_CTL,                        0x02},
-	{WCD938X_ANA_TX_CH1,                                   0x20},
-	{WCD938X_ANA_TX_CH2,                                   0x00},
-	{WCD938X_ANA_TX_CH3,                                   0x20},
-	{WCD938X_ANA_TX_CH4,                                   0x00},
-	{WCD938X_ANA_MICB1_MICB2_DSP_EN_LOGIC,                 0x00},
-	{WCD938X_ANA_MICB3_DSP_EN_LOGIC,                       0x00},
-	{WCD938X_ANA_MBHC_MECH,                                0x39},
-	{WCD938X_ANA_MBHC_ELECT,                               0x08},
-	{WCD938X_ANA_MBHC_ZDET,                                0x00},
-	{WCD938X_ANA_MBHC_RESULT_1,                            0x00},
-	{WCD938X_ANA_MBHC_RESULT_2,                            0x00},
-	{WCD938X_ANA_MBHC_RESULT_3,                            0x00},
-	{WCD938X_ANA_MBHC_BTN0,                                0x00},
-	{WCD938X_ANA_MBHC_BTN1,                                0x10},
-	{WCD938X_ANA_MBHC_BTN2,                                0x20},
-	{WCD938X_ANA_MBHC_BTN3,                                0x30},
-	{WCD938X_ANA_MBHC_BTN4,                                0x40},
-	{WCD938X_ANA_MBHC_BTN5,                                0x50},
-	{WCD938X_ANA_MBHC_BTN6,                                0x60},
-	{WCD938X_ANA_MBHC_BTN7,                                0x70},
-	{WCD938X_ANA_MICB1,                                    0x10},
-	{WCD938X_ANA_MICB2,                                    0x10},
-	{WCD938X_ANA_MICB2_RAMP,                               0x00},
-	{WCD938X_ANA_MICB3,                                    0x10},
-	{WCD938X_ANA_MICB4,                                    0x10},
-	{WCD938X_BIAS_CTL,                                     0x2A},
-	{WCD938X_BIAS_VBG_FINE_ADJ,                            0x55},
-	{WCD938X_LDOL_VDDCX_ADJUST,                            0x01},
-	{WCD938X_LDOL_DISABLE_LDOL,                            0x00},
-	{WCD938X_MBHC_CTL_CLK,                                 0x00},
-	{WCD938X_MBHC_CTL_ANA,                                 0x00},
-	{WCD938X_MBHC_CTL_SPARE_1,                             0x00},
-	{WCD938X_MBHC_CTL_SPARE_2,                             0x00},
-	{WCD938X_MBHC_CTL_BCS,                                 0x00},
-	{WCD938X_MBHC_MOISTURE_DET_FSM_STATUS,                 0x00},
-	{WCD938X_MBHC_TEST_CTL,                                0x00},
-	{WCD938X_LDOH_MODE,                                    0x2B},
-	{WCD938X_LDOH_BIAS,                                    0x68},
-	{WCD938X_LDOH_STB_LOADS,                               0x00},
-	{WCD938X_LDOH_SLOWRAMP,                                0x50},
-	{WCD938X_MICB1_TEST_CTL_1,                             0x1A},
-	{WCD938X_MICB1_TEST_CTL_2,                             0x00},
-	{WCD938X_MICB1_TEST_CTL_3,                             0xA4},
-	{WCD938X_MICB2_TEST_CTL_1,                             0x1A},
-	{WCD938X_MICB2_TEST_CTL_2,                             0x00},
-	{WCD938X_MICB2_TEST_CTL_3,                             0x24},
-	{WCD938X_MICB3_TEST_CTL_1,                             0x1A},
-	{WCD938X_MICB3_TEST_CTL_2,                             0x00},
-	{WCD938X_MICB3_TEST_CTL_3,                             0xA4},
-	{WCD938X_MICB4_TEST_CTL_1,                             0x1A},
-	{WCD938X_MICB4_TEST_CTL_2,                             0x00},
-	{WCD938X_MICB4_TEST_CTL_3,                             0xA4},
-	{WCD938X_TX_COM_ADC_VCM,                               0x39},
-	{WCD938X_TX_COM_BIAS_ATEST,                            0xE0},
-	{WCD938X_TX_COM_SPARE1,                                0x00},
-	{WCD938X_TX_COM_SPARE2,                                0x00},
-	{WCD938X_TX_COM_TXFE_DIV_CTL,                          0x22},
-	{WCD938X_TX_COM_TXFE_DIV_START,                        0x00},
-	{WCD938X_TX_COM_SPARE3,                                0x00},
-	{WCD938X_TX_COM_SPARE4,                                0x00},
-	{WCD938X_TX_1_2_TEST_EN,                               0xCC},
-	{WCD938X_TX_1_2_ADC_IB,                                0xE9},
-	{WCD938X_TX_1_2_ATEST_REFCTL,                          0x0A},
-	{WCD938X_TX_1_2_TEST_CTL,                              0x38},
-	{WCD938X_TX_1_2_TEST_BLK_EN1,                          0xFF},
-	{WCD938X_TX_1_2_TXFE1_CLKDIV,                          0x00},
-	{WCD938X_TX_1_2_SAR2_ERR,                              0x00},
-	{WCD938X_TX_1_2_SAR1_ERR,                              0x00},
-	{WCD938X_TX_3_4_TEST_EN,                               0xCC},
-	{WCD938X_TX_3_4_ADC_IB,                                0xE9},
-	{WCD938X_TX_3_4_ATEST_REFCTL,                          0x0A},
-	{WCD938X_TX_3_4_TEST_CTL,                              0x38},
-	{WCD938X_TX_3_4_TEST_BLK_EN3,                          0xFF},
-	{WCD938X_TX_3_4_TXFE3_CLKDIV,                          0x00},
-	{WCD938X_TX_3_4_SAR4_ERR,                              0x00},
-	{WCD938X_TX_3_4_SAR3_ERR,                              0x00},
-	{WCD938X_TX_3_4_TEST_BLK_EN2,                          0xFB},
-	{WCD938X_TX_3_4_TXFE2_CLKDIV,                          0x00},
-	{WCD938X_TX_3_4_SPARE1,                                0x00},
-	{WCD938X_TX_3_4_TEST_BLK_EN4,                          0xFB},
-	{WCD938X_TX_3_4_TXFE4_CLKDIV,                          0x00},
-	{WCD938X_TX_3_4_SPARE2,                                0x00},
-	{WCD938X_CLASSH_MODE_1,                                0x40},
-	{WCD938X_CLASSH_MODE_2,                                0x3A},
-	{WCD938X_CLASSH_MODE_3,                                0x00},
-	{WCD938X_CLASSH_CTRL_VCL_1,                            0x70},
-	{WCD938X_CLASSH_CTRL_VCL_2,                            0x82},
-	{WCD938X_CLASSH_CTRL_CCL_1,                            0x31},
-	{WCD938X_CLASSH_CTRL_CCL_2,                            0x80},
-	{WCD938X_CLASSH_CTRL_CCL_3,                            0x80},
-	{WCD938X_CLASSH_CTRL_CCL_4,                            0x51},
-	{WCD938X_CLASSH_CTRL_CCL_5,                            0x00},
-	{WCD938X_CLASSH_BUCK_TMUX_A_D,                         0x00},
-	{WCD938X_CLASSH_BUCK_SW_DRV_CNTL,                      0x77},
-	{WCD938X_CLASSH_SPARE,                                 0x00},
-	{WCD938X_FLYBACK_EN,                                   0x4E},
-	{WCD938X_FLYBACK_VNEG_CTRL_1,                          0x0B},
-	{WCD938X_FLYBACK_VNEG_CTRL_2,                          0x45},
-	{WCD938X_FLYBACK_VNEG_CTRL_3,                          0x74},
-	{WCD938X_FLYBACK_VNEG_CTRL_4,                          0x7F},
-	{WCD938X_FLYBACK_VNEG_CTRL_5,                          0x83},
-	{WCD938X_FLYBACK_VNEG_CTRL_6,                          0x98},
-	{WCD938X_FLYBACK_VNEG_CTRL_7,                          0xA9},
-	{WCD938X_FLYBACK_VNEG_CTRL_8,                          0x68},
-	{WCD938X_FLYBACK_VNEG_CTRL_9,                          0x64},
-	{WCD938X_FLYBACK_VNEGDAC_CTRL_1,                       0xED},
-	{WCD938X_FLYBACK_VNEGDAC_CTRL_2,                       0xF0},
-	{WCD938X_FLYBACK_VNEGDAC_CTRL_3,                       0xA6},
-	{WCD938X_FLYBACK_CTRL_1,                               0x65},
-	{WCD938X_FLYBACK_TEST_CTL,                             0x00},
-	{WCD938X_RX_AUX_SW_CTL,                                0x00},
-	{WCD938X_RX_PA_AUX_IN_CONN,                            0x01},
-	{WCD938X_RX_TIMER_DIV,                                 0x32},
-	{WCD938X_RX_OCP_CTL,                                   0x1F},
-	{WCD938X_RX_OCP_COUNT,                                 0x77},
-	{WCD938X_RX_BIAS_EAR_DAC,                              0xA0},
-	{WCD938X_RX_BIAS_EAR_AMP,                              0xAA},
-	{WCD938X_RX_BIAS_HPH_LDO,                              0xA9},
-	{WCD938X_RX_BIAS_HPH_PA,                               0xAA},
-	{WCD938X_RX_BIAS_HPH_RDACBUFF_CNP2,                    0x8A},
-	{WCD938X_RX_BIAS_HPH_RDAC_LDO,                         0x88},
-	{WCD938X_RX_BIAS_HPH_CNP1,                             0x82},
-	{WCD938X_RX_BIAS_HPH_LOWPOWER,                         0x82},
-	{WCD938X_RX_BIAS_AUX_DAC,                              0xA0},
-	{WCD938X_RX_BIAS_AUX_AMP,                              0xAA},
-	{WCD938X_RX_BIAS_VNEGDAC_BLEEDER,                      0x50},
-	{WCD938X_RX_BIAS_MISC,                                 0x00},
-	{WCD938X_RX_BIAS_BUCK_RST,                             0x08},
-	{WCD938X_RX_BIAS_BUCK_VREF_ERRAMP,                     0x44},
-	{WCD938X_RX_BIAS_FLYB_ERRAMP,                          0x40},
-	{WCD938X_RX_BIAS_FLYB_BUFF,                            0xAA},
-	{WCD938X_RX_BIAS_FLYB_MID_RST,                         0x14},
-	{WCD938X_HPH_L_STATUS,                                 0x04},
-	{WCD938X_HPH_R_STATUS,                                 0x04},
-	{WCD938X_HPH_CNP_EN,                                   0x80},
-	{WCD938X_HPH_CNP_WG_CTL,                               0x9A},
-	{WCD938X_HPH_CNP_WG_TIME,                              0x14},
-	{WCD938X_HPH_OCP_CTL,                                  0x28},
-	{WCD938X_HPH_AUTO_CHOP,                                0x16},
-	{WCD938X_HPH_CHOP_CTL,                                 0x83},
-	{WCD938X_HPH_PA_CTL1,                                  0x46},
-	{WCD938X_HPH_PA_CTL2,                                  0x50},
-	{WCD938X_HPH_L_EN,                                     0x80},
-	{WCD938X_HPH_L_TEST,                                   0xE0},
-	{WCD938X_HPH_L_ATEST,                                  0x50},
-	{WCD938X_HPH_R_EN,                                     0x80},
-	{WCD938X_HPH_R_TEST,                                   0xE0},
-	{WCD938X_HPH_R_ATEST,                                  0x54},
-	{WCD938X_HPH_RDAC_CLK_CTL1,                            0x99},
-	{WCD938X_HPH_RDAC_CLK_CTL2,                            0x9B},
-	{WCD938X_HPH_RDAC_LDO_CTL,                             0x33},
-	{WCD938X_HPH_RDAC_CHOP_CLK_LP_CTL,                     0x00},
-	{WCD938X_HPH_REFBUFF_UHQA_CTL,                         0x68},
-	{WCD938X_HPH_REFBUFF_LP_CTL,                           0x0E},
-	{WCD938X_HPH_L_DAC_CTL,                                0x20},
-	{WCD938X_HPH_R_DAC_CTL,                                0x20},
-	{WCD938X_HPH_SURGE_HPHLR_SURGE_COMP_SEL,               0x55},
-	{WCD938X_HPH_SURGE_HPHLR_SURGE_EN,                     0x19},
-	{WCD938X_HPH_SURGE_HPHLR_SURGE_MISC1,                  0xA0},
-	{WCD938X_HPH_SURGE_HPHLR_SURGE_STATUS,                 0x00},
-	{WCD938X_EAR_EAR_EN_REG,                               0x22},
-	{WCD938X_EAR_EAR_PA_CON,                               0x44},
-	{WCD938X_EAR_EAR_SP_CON,                               0xDB},
-	{WCD938X_EAR_EAR_DAC_CON,                              0x80},
-	{WCD938X_EAR_EAR_CNP_FSM_CON,                          0xB2},
-	{WCD938X_EAR_TEST_CTL,                                 0x00},
-	{WCD938X_EAR_STATUS_REG_1,                             0x00},
-	{WCD938X_EAR_STATUS_REG_2,                             0x08},
-	{WCD938X_ANA_NEW_PAGE_REGISTER,                        0x00},
-	{WCD938X_HPH_NEW_ANA_HPH2,                             0x00},
-	{WCD938X_HPH_NEW_ANA_HPH3,                             0x00},
-	{WCD938X_SLEEP_CTL,                                    0x16},
-	{WCD938X_SLEEP_WATCHDOG_CTL,                           0x00},
-	{WCD938X_MBHC_NEW_ELECT_REM_CLAMP_CTL,                 0x00},
-	{WCD938X_MBHC_NEW_CTL_1,                               0x02},
-	{WCD938X_MBHC_NEW_CTL_2,                               0x05},
-	{WCD938X_MBHC_NEW_PLUG_DETECT_CTL,                     0xE9},
-	{WCD938X_MBHC_NEW_ZDET_ANA_CTL,                        0x0F},
-	{WCD938X_MBHC_NEW_ZDET_RAMP_CTL,                       0x00},
-	{WCD938X_MBHC_NEW_FSM_STATUS,                          0x00},
-	{WCD938X_MBHC_NEW_ADC_RESULT,                          0x00},
-	{WCD938X_TX_NEW_AMIC_MUX_CFG,                          0x00},
-	{WCD938X_AUX_AUXPA,                                    0x00},
-	{WCD938X_LDORXTX_MODE,                                 0x0C},
-	{WCD938X_LDORXTX_CONFIG,                               0x10},
-	{WCD938X_DIE_CRACK_DIE_CRK_DET_EN,                     0x00},
-	{WCD938X_DIE_CRACK_DIE_CRK_DET_OUT,                    0x00},
-	{WCD938X_HPH_NEW_INT_RDAC_GAIN_CTL,                    0x40},
-	{WCD938X_HPH_NEW_INT_RDAC_HD2_CTL_L,                   0x81},
-	{WCD938X_HPH_NEW_INT_RDAC_VREF_CTL,                    0x10},
-	{WCD938X_HPH_NEW_INT_RDAC_OVERRIDE_CTL,                0x00},
-	{WCD938X_HPH_NEW_INT_RDAC_HD2_CTL_R,                   0x81},
-	{WCD938X_HPH_NEW_INT_PA_MISC1,                         0x22},
-	{WCD938X_HPH_NEW_INT_PA_MISC2,                         0x00},
-	{WCD938X_HPH_NEW_INT_PA_RDAC_MISC,                     0x00},
-	{WCD938X_HPH_NEW_INT_HPH_TIMER1,                       0xFE},
-	{WCD938X_HPH_NEW_INT_HPH_TIMER2,                       0x02},
-	{WCD938X_HPH_NEW_INT_HPH_TIMER3,                       0x4E},
-	{WCD938X_HPH_NEW_INT_HPH_TIMER4,                       0x54},
-	{WCD938X_HPH_NEW_INT_PA_RDAC_MISC2,                    0x00},
-	{WCD938X_HPH_NEW_INT_PA_RDAC_MISC3,                    0x00},
-	{WCD938X_HPH_NEW_INT_RDAC_HD2_CTL_L_NEW,               0x90},
-	{WCD938X_HPH_NEW_INT_RDAC_HD2_CTL_R_NEW,               0x90},
-	{WCD938X_RX_NEW_INT_HPH_RDAC_BIAS_LOHIFI,              0x62},
-	{WCD938X_RX_NEW_INT_HPH_RDAC_BIAS_ULP,                 0x01},
-	{WCD938X_RX_NEW_INT_HPH_RDAC_LDO_LP,                   0x11},
-	{WCD938X_MBHC_NEW_INT_MOISTURE_DET_DC_CTRL,            0x57},
-	{WCD938X_MBHC_NEW_INT_MOISTURE_DET_POLLING_CTRL,       0x01},
-	{WCD938X_MBHC_NEW_INT_MECH_DET_CURRENT,                0x00},
-	{WCD938X_MBHC_NEW_INT_SPARE_2,                         0x00},
-	{WCD938X_EAR_INT_NEW_EAR_CHOPPER_CON,                  0xA8},
-	{WCD938X_EAR_INT_NEW_CNP_VCM_CON1,                     0x42},
-	{WCD938X_EAR_INT_NEW_CNP_VCM_CON2,                     0x22},
-	{WCD938X_EAR_INT_NEW_EAR_DYNAMIC_BIAS,                 0x00},
-	{WCD938X_AUX_INT_EN_REG,                               0x00},
-	{WCD938X_AUX_INT_PA_CTRL,                              0x06},
-	{WCD938X_AUX_INT_SP_CTRL,                              0xD2},
-	{WCD938X_AUX_INT_DAC_CTRL,                             0x80},
-	{WCD938X_AUX_INT_CLK_CTRL,                             0x50},
-	{WCD938X_AUX_INT_TEST_CTRL,                            0x00},
-	{WCD938X_AUX_INT_STATUS_REG,                           0x00},
-	{WCD938X_AUX_INT_MISC,                                 0x00},
-	{WCD938X_LDORXTX_INT_BIAS,                             0x6E},
-	{WCD938X_LDORXTX_INT_STB_LOADS_DTEST,                  0x50},
-	{WCD938X_LDORXTX_INT_TEST0,                            0x1C},
-	{WCD938X_LDORXTX_INT_STARTUP_TIMER,                    0xFF},
-	{WCD938X_LDORXTX_INT_TEST1,                            0x1F},
-	{WCD938X_LDORXTX_INT_STATUS,                           0x00},
-	{WCD938X_SLEEP_INT_WATCHDOG_CTL_1,                     0x0A},
-	{WCD938X_SLEEP_INT_WATCHDOG_CTL_2,                     0x0A},
-	{WCD938X_DIE_CRACK_INT_DIE_CRK_DET_INT1,               0x02},
-	{WCD938X_DIE_CRACK_INT_DIE_CRK_DET_INT2,               0x60},
-	{WCD938X_TX_COM_NEW_INT_TXFE_DIVSTOP_L2,               0xFF},
-	{WCD938X_TX_COM_NEW_INT_TXFE_DIVSTOP_L1,               0x7F},
-	{WCD938X_TX_COM_NEW_INT_TXFE_DIVSTOP_L0,               0x3F},
-	{WCD938X_TX_COM_NEW_INT_TXFE_DIVSTOP_ULP1P2M,          0x1F},
-	{WCD938X_TX_COM_NEW_INT_TXFE_DIVSTOP_ULP0P6M,          0x0F},
-	{WCD938X_TX_COM_NEW_INT_TXFE_ICTRL_STG1_L2L1,          0xD7},
-	{WCD938X_TX_COM_NEW_INT_TXFE_ICTRL_STG1_L0,            0xC8},
-	{WCD938X_TX_COM_NEW_INT_TXFE_ICTRL_STG1_ULP,           0xC6},
-	{WCD938X_TX_COM_NEW_INT_TXFE_ICTRL_STG2MAIN_L2L1,      0xD5},
-	{WCD938X_TX_COM_NEW_INT_TXFE_ICTRL_STG2MAIN_L0,        0xCA},
-	{WCD938X_TX_COM_NEW_INT_TXFE_ICTRL_STG2MAIN_ULP,       0x05},
-	{WCD938X_TX_COM_NEW_INT_TXFE_ICTRL_STG2CASC_L2L1L0,    0xA5},
-	{WCD938X_TX_COM_NEW_INT_TXFE_ICTRL_STG2CASC_ULP,       0x13},
-	{WCD938X_TX_COM_NEW_INT_TXADC_SCBIAS_L2L1,             0x88},
-	{WCD938X_TX_COM_NEW_INT_TXADC_SCBIAS_L0ULP,            0x42},
-	{WCD938X_TX_COM_NEW_INT_TXADC_INT_L2,                  0xFF},
-	{WCD938X_TX_COM_NEW_INT_TXADC_INT_L1,                  0x64},
-	{WCD938X_TX_COM_NEW_INT_TXADC_INT_L0,                  0x64},
-	{WCD938X_TX_COM_NEW_INT_TXADC_INT_ULP,                 0x77},
-	{WCD938X_DIGITAL_PAGE_REGISTER,                        0x00},
-	{WCD938X_DIGITAL_CHIP_ID0,                             0x00},
-	{WCD938X_DIGITAL_CHIP_ID1,                             0x00},
-	{WCD938X_DIGITAL_CHIP_ID2,                             0x0D},
-	{WCD938X_DIGITAL_CHIP_ID3,                             0x01},
-	{WCD938X_DIGITAL_SWR_TX_CLK_RATE,                      0x00},
-	{WCD938X_DIGITAL_CDC_RST_CTL,                          0x03},
-	{WCD938X_DIGITAL_TOP_CLK_CFG,                          0x00},
-	{WCD938X_DIGITAL_CDC_ANA_CLK_CTL,                      0x00},
-	{WCD938X_DIGITAL_CDC_DIG_CLK_CTL,                      0xF0},
-	{WCD938X_DIGITAL_SWR_RST_EN,                           0x00},
-	{WCD938X_DIGITAL_CDC_PATH_MODE,                        0x55},
-	{WCD938X_DIGITAL_CDC_RX_RST,                           0x00},
-	{WCD938X_DIGITAL_CDC_RX0_CTL,                          0xFC},
-	{WCD938X_DIGITAL_CDC_RX1_CTL,                          0xFC},
-	{WCD938X_DIGITAL_CDC_RX2_CTL,                          0xFC},
-	{WCD938X_DIGITAL_CDC_TX_ANA_MODE_0_1,                  0x00},
-	{WCD938X_DIGITAL_CDC_TX_ANA_MODE_2_3,                  0x00},
-	{WCD938X_DIGITAL_CDC_COMP_CTL_0,                       0x00},
-	{WCD938X_DIGITAL_CDC_ANA_TX_CLK_CTL,                   0x1E},
-	{WCD938X_DIGITAL_CDC_HPH_DSM_A1_0,                     0x00},
-	{WCD938X_DIGITAL_CDC_HPH_DSM_A1_1,                     0x01},
-	{WCD938X_DIGITAL_CDC_HPH_DSM_A2_0,                     0x63},
-	{WCD938X_DIGITAL_CDC_HPH_DSM_A2_1,                     0x04},
-	{WCD938X_DIGITAL_CDC_HPH_DSM_A3_0,                     0xAC},
-	{WCD938X_DIGITAL_CDC_HPH_DSM_A3_1,                     0x04},
-	{WCD938X_DIGITAL_CDC_HPH_DSM_A4_0,                     0x1A},
-	{WCD938X_DIGITAL_CDC_HPH_DSM_A4_1,                     0x03},
-	{WCD938X_DIGITAL_CDC_HPH_DSM_A5_0,                     0xBC},
-	{WCD938X_DIGITAL_CDC_HPH_DSM_A5_1,                     0x02},
-	{WCD938X_DIGITAL_CDC_HPH_DSM_A6_0,                     0xC7},
-	{WCD938X_DIGITAL_CDC_HPH_DSM_A7_0,                     0xF8},
-	{WCD938X_DIGITAL_CDC_HPH_DSM_C_0,                      0x47},
-	{WCD938X_DIGITAL_CDC_HPH_DSM_C_1,                      0x43},
-	{WCD938X_DIGITAL_CDC_HPH_DSM_C_2,                      0xB1},
-	{WCD938X_DIGITAL_CDC_HPH_DSM_C_3,                      0x17},
-	{WCD938X_DIGITAL_CDC_HPH_DSM_R1,                       0x4D},
-	{WCD938X_DIGITAL_CDC_HPH_DSM_R2,                       0x29},
-	{WCD938X_DIGITAL_CDC_HPH_DSM_R3,                       0x34},
-	{WCD938X_DIGITAL_CDC_HPH_DSM_R4,                       0x59},
-	{WCD938X_DIGITAL_CDC_HPH_DSM_R5,                       0x66},
-	{WCD938X_DIGITAL_CDC_HPH_DSM_R6,                       0x87},
-	{WCD938X_DIGITAL_CDC_HPH_DSM_R7,                       0x64},
-	{WCD938X_DIGITAL_CDC_AUX_DSM_A1_0,                     0x00},
-	{WCD938X_DIGITAL_CDC_AUX_DSM_A1_1,                     0x01},
-	{WCD938X_DIGITAL_CDC_AUX_DSM_A2_0,                     0x96},
-	{WCD938X_DIGITAL_CDC_AUX_DSM_A2_1,                     0x09},
-	{WCD938X_DIGITAL_CDC_AUX_DSM_A3_0,                     0xAB},
-	{WCD938X_DIGITAL_CDC_AUX_DSM_A3_1,                     0x05},
-	{WCD938X_DIGITAL_CDC_AUX_DSM_A4_0,                     0x1C},
-	{WCD938X_DIGITAL_CDC_AUX_DSM_A4_1,                     0x02},
-	{WCD938X_DIGITAL_CDC_AUX_DSM_A5_0,                     0x17},
-	{WCD938X_DIGITAL_CDC_AUX_DSM_A5_1,                     0x02},
-	{WCD938X_DIGITAL_CDC_AUX_DSM_A6_0,                     0xAA},
-	{WCD938X_DIGITAL_CDC_AUX_DSM_A7_0,                     0xE3},
-	{WCD938X_DIGITAL_CDC_AUX_DSM_C_0,                      0x69},
-	{WCD938X_DIGITAL_CDC_AUX_DSM_C_1,                      0x54},
-	{WCD938X_DIGITAL_CDC_AUX_DSM_C_2,                      0x02},
-	{WCD938X_DIGITAL_CDC_AUX_DSM_C_3,                      0x15},
-	{WCD938X_DIGITAL_CDC_AUX_DSM_R1,                       0xA4},
-	{WCD938X_DIGITAL_CDC_AUX_DSM_R2,                       0xB5},
-	{WCD938X_DIGITAL_CDC_AUX_DSM_R3,                       0x86},
-	{WCD938X_DIGITAL_CDC_AUX_DSM_R4,                       0x85},
-	{WCD938X_DIGITAL_CDC_AUX_DSM_R5,                       0xAA},
-	{WCD938X_DIGITAL_CDC_AUX_DSM_R6,                       0xE2},
-	{WCD938X_DIGITAL_CDC_AUX_DSM_R7,                       0x62},
-	{WCD938X_DIGITAL_CDC_HPH_GAIN_RX_0,                    0x55},
-	{WCD938X_DIGITAL_CDC_HPH_GAIN_RX_1,                    0xA9},
-	{WCD938X_DIGITAL_CDC_HPH_GAIN_DSD_0,                   0x3D},
-	{WCD938X_DIGITAL_CDC_HPH_GAIN_DSD_1,                   0x2E},
-	{WCD938X_DIGITAL_CDC_HPH_GAIN_DSD_2,                   0x01},
-	{WCD938X_DIGITAL_CDC_AUX_GAIN_DSD_0,                   0x00},
-	{WCD938X_DIGITAL_CDC_AUX_GAIN_DSD_1,                   0xFC},
-	{WCD938X_DIGITAL_CDC_AUX_GAIN_DSD_2,                   0x01},
-	{WCD938X_DIGITAL_CDC_HPH_GAIN_CTL,                     0x00},
-	{WCD938X_DIGITAL_CDC_AUX_GAIN_CTL,                     0x00},
-	{WCD938X_DIGITAL_CDC_EAR_PATH_CTL,                     0x00},
-	{WCD938X_DIGITAL_CDC_SWR_CLH,                          0x00},
-	{WCD938X_DIGITAL_SWR_CLH_BYP,                          0x00},
-	{WCD938X_DIGITAL_CDC_TX0_CTL,                          0x68},
-	{WCD938X_DIGITAL_CDC_TX1_CTL,                          0x68},
-	{WCD938X_DIGITAL_CDC_TX2_CTL,                          0x68},
-	{WCD938X_DIGITAL_CDC_TX_RST,                           0x00},
-	{WCD938X_DIGITAL_CDC_REQ_CTL,                          0x01},
-	{WCD938X_DIGITAL_CDC_RST,                              0x00},
-	{WCD938X_DIGITAL_CDC_AMIC_CTL,                         0x0F},
-	{WCD938X_DIGITAL_CDC_DMIC_CTL,                         0x04},
-	{WCD938X_DIGITAL_CDC_DMIC1_CTL,                        0x01},
-	{WCD938X_DIGITAL_CDC_DMIC2_CTL,                        0x01},
-	{WCD938X_DIGITAL_CDC_DMIC3_CTL,                        0x01},
-	{WCD938X_DIGITAL_CDC_DMIC4_CTL,                        0x01},
-	{WCD938X_DIGITAL_EFUSE_PRG_CTL,                        0x00},
-	{WCD938X_DIGITAL_EFUSE_CTL,                            0x2B},
-	{WCD938X_DIGITAL_CDC_DMIC_RATE_1_2,                    0x11},
-	{WCD938X_DIGITAL_CDC_DMIC_RATE_3_4,                    0x11},
-	{WCD938X_DIGITAL_PDM_WD_CTL0,                          0x00},
-	{WCD938X_DIGITAL_PDM_WD_CTL1,                          0x00},
-	{WCD938X_DIGITAL_PDM_WD_CTL2,                          0x00},
-	{WCD938X_DIGITAL_INTR_MODE,                            0x00},
-	{WCD938X_DIGITAL_INTR_MASK_0,                          0xFF},
-	{WCD938X_DIGITAL_INTR_MASK_1,                          0xFF},
-	{WCD938X_DIGITAL_INTR_MASK_2,                          0x3F},
-	{WCD938X_DIGITAL_INTR_STATUS_0,                        0x00},
-	{WCD938X_DIGITAL_INTR_STATUS_1,                        0x00},
-	{WCD938X_DIGITAL_INTR_STATUS_2,                        0x00},
-	{WCD938X_DIGITAL_INTR_CLEAR_0,                         0x00},
-	{WCD938X_DIGITAL_INTR_CLEAR_1,                         0x00},
-	{WCD938X_DIGITAL_INTR_CLEAR_2,                         0x00},
-	{WCD938X_DIGITAL_INTR_LEVEL_0,                         0x00},
-	{WCD938X_DIGITAL_INTR_LEVEL_1,                         0x00},
-	{WCD938X_DIGITAL_INTR_LEVEL_2,                         0x00},
-	{WCD938X_DIGITAL_INTR_SET_0,                           0x00},
-	{WCD938X_DIGITAL_INTR_SET_1,                           0x00},
-	{WCD938X_DIGITAL_INTR_SET_2,                           0x00},
-	{WCD938X_DIGITAL_INTR_TEST_0,                          0x00},
-	{WCD938X_DIGITAL_INTR_TEST_1,                          0x00},
-	{WCD938X_DIGITAL_INTR_TEST_2,                          0x00},
-	{WCD938X_DIGITAL_TX_MODE_DBG_EN,                       0x00},
-	{WCD938X_DIGITAL_TX_MODE_DBG_0_1,                      0x00},
-	{WCD938X_DIGITAL_TX_MODE_DBG_2_3,                      0x00},
-	{WCD938X_DIGITAL_LB_IN_SEL_CTL,                        0x00},
-	{WCD938X_DIGITAL_LOOP_BACK_MODE,                       0x00},
-	{WCD938X_DIGITAL_SWR_DAC_TEST,                         0x00},
-	{WCD938X_DIGITAL_SWR_HM_TEST_RX_0,                     0x40},
-	{WCD938X_DIGITAL_SWR_HM_TEST_TX_0,                     0x40},
-	{WCD938X_DIGITAL_SWR_HM_TEST_RX_1,                     0x00},
-	{WCD938X_DIGITAL_SWR_HM_TEST_TX_1,                     0x00},
-	{WCD938X_DIGITAL_SWR_HM_TEST_TX_2,                     0x00},
-	{WCD938X_DIGITAL_SWR_HM_TEST_0,                        0x00},
-	{WCD938X_DIGITAL_SWR_HM_TEST_1,                        0x00},
-	{WCD938X_DIGITAL_PAD_CTL_SWR_0,                        0x8F},
-	{WCD938X_DIGITAL_PAD_CTL_SWR_1,                        0x06},
-	{WCD938X_DIGITAL_I2C_CTL,                              0x00},
-	{WCD938X_DIGITAL_CDC_TX_TANGGU_SW_MODE,                0x00},
-	{WCD938X_DIGITAL_EFUSE_TEST_CTL_0,                     0x00},
-	{WCD938X_DIGITAL_EFUSE_TEST_CTL_1,                     0x00},
-	{WCD938X_DIGITAL_EFUSE_T_DATA_0,                       0x00},
-	{WCD938X_DIGITAL_EFUSE_T_DATA_1,                       0x00},
-	{WCD938X_DIGITAL_PAD_CTL_PDM_RX0,                      0xF1},
-	{WCD938X_DIGITAL_PAD_CTL_PDM_RX1,                      0xF1},
-	{WCD938X_DIGITAL_PAD_CTL_PDM_TX0,                      0xF1},
-	{WCD938X_DIGITAL_PAD_CTL_PDM_TX1,                      0xF1},
-	{WCD938X_DIGITAL_PAD_CTL_PDM_TX2,                      0xF1},
-	{WCD938X_DIGITAL_PAD_INP_DIS_0,                        0x00},
-	{WCD938X_DIGITAL_PAD_INP_DIS_1,                        0x00},
-	{WCD938X_DIGITAL_DRIVE_STRENGTH_0,                     0x00},
-	{WCD938X_DIGITAL_DRIVE_STRENGTH_1,                     0x00},
-	{WCD938X_DIGITAL_DRIVE_STRENGTH_2,                     0x00},
-	{WCD938X_DIGITAL_RX_DATA_EDGE_CTL,                     0x1F},
-	{WCD938X_DIGITAL_TX_DATA_EDGE_CTL,                     0x80},
-	{WCD938X_DIGITAL_GPIO_MODE,                            0x00},
-	{WCD938X_DIGITAL_PIN_CTL_OE,                           0x00},
-	{WCD938X_DIGITAL_PIN_CTL_DATA_0,                       0x00},
-	{WCD938X_DIGITAL_PIN_CTL_DATA_1,                       0x00},
-	{WCD938X_DIGITAL_PIN_STATUS_0,                         0x00},
-	{WCD938X_DIGITAL_PIN_STATUS_1,                         0x00},
-	{WCD938X_DIGITAL_DIG_DEBUG_CTL,                        0x00},
-	{WCD938X_DIGITAL_DIG_DEBUG_EN,                         0x00},
-	{WCD938X_DIGITAL_ANA_CSR_DBG_ADD,                      0x00},
-	{WCD938X_DIGITAL_ANA_CSR_DBG_CTL,                      0x48},
-	{WCD938X_DIGITAL_SSP_DBG,                              0x00},
-	{WCD938X_DIGITAL_MODE_STATUS_0,                        0x00},
-	{WCD938X_DIGITAL_MODE_STATUS_1,                        0x00},
-	{WCD938X_DIGITAL_SPARE_0,                              0x00},
-	{WCD938X_DIGITAL_SPARE_1,                              0x00},
-	{WCD938X_DIGITAL_SPARE_2,                              0x00},
-	{WCD938X_DIGITAL_EFUSE_REG_0,                          0x00},
-	{WCD938X_DIGITAL_EFUSE_REG_1,                          0xFF},
-	{WCD938X_DIGITAL_EFUSE_REG_2,                          0xFF},
-	{WCD938X_DIGITAL_EFUSE_REG_3,                          0xFF},
-	{WCD938X_DIGITAL_EFUSE_REG_4,                          0xFF},
-	{WCD938X_DIGITAL_EFUSE_REG_5,                          0xFF},
-	{WCD938X_DIGITAL_EFUSE_REG_6,                          0xFF},
-	{WCD938X_DIGITAL_EFUSE_REG_7,                          0xFF},
-	{WCD938X_DIGITAL_EFUSE_REG_8,                          0xFF},
-	{WCD938X_DIGITAL_EFUSE_REG_9,                          0xFF},
-	{WCD938X_DIGITAL_EFUSE_REG_10,                         0xFF},
-	{WCD938X_DIGITAL_EFUSE_REG_11,                         0xFF},
-	{WCD938X_DIGITAL_EFUSE_REG_12,                         0xFF},
-	{WCD938X_DIGITAL_EFUSE_REG_13,                         0xFF},
-	{WCD938X_DIGITAL_EFUSE_REG_14,                         0xFF},
-	{WCD938X_DIGITAL_EFUSE_REG_15,                         0xFF},
-	{WCD938X_DIGITAL_EFUSE_REG_16,                         0xFF},
-	{WCD938X_DIGITAL_EFUSE_REG_17,                         0xFF},
-	{WCD938X_DIGITAL_EFUSE_REG_18,                         0xFF},
-	{WCD938X_DIGITAL_EFUSE_REG_19,                         0xFF},
-	{WCD938X_DIGITAL_EFUSE_REG_20,                         0x0E},
-	{WCD938X_DIGITAL_EFUSE_REG_21,                         0x00},
-	{WCD938X_DIGITAL_EFUSE_REG_22,                         0x00},
-	{WCD938X_DIGITAL_EFUSE_REG_23,                         0xF8},
-	{WCD938X_DIGITAL_EFUSE_REG_24,                         0x16},
-	{WCD938X_DIGITAL_EFUSE_REG_25,                         0x00},
-	{WCD938X_DIGITAL_EFUSE_REG_26,                         0x00},
-	{WCD938X_DIGITAL_EFUSE_REG_27,                         0x00},
-	{WCD938X_DIGITAL_EFUSE_REG_28,                         0x00},
-	{WCD938X_DIGITAL_EFUSE_REG_29,                         0x00},
-	{WCD938X_DIGITAL_EFUSE_REG_30,                         0x00},
-	{WCD938X_DIGITAL_EFUSE_REG_31,                         0x00},
-	{WCD938X_DIGITAL_TX_REQ_FB_CTL_0,                      0x88},
-	{WCD938X_DIGITAL_TX_REQ_FB_CTL_1,                      0x88},
-	{WCD938X_DIGITAL_TX_REQ_FB_CTL_2,                      0x88},
-	{WCD938X_DIGITAL_TX_REQ_FB_CTL_3,                      0x88},
-	{WCD938X_DIGITAL_TX_REQ_FB_CTL_4,                      0x88},
-	{WCD938X_DIGITAL_DEM_BYPASS_DATA0,                     0x55},
-	{WCD938X_DIGITAL_DEM_BYPASS_DATA1,                     0x55},
-	{WCD938X_DIGITAL_DEM_BYPASS_DATA2,                     0x55},
-	{WCD938X_DIGITAL_DEM_BYPASS_DATA3,                     0x01},
-};
-
-static bool wcd938x_rdwr_register(struct device *dev, unsigned int reg)
-{
-	switch (reg) {
-	case WCD938X_ANA_PAGE_REGISTER:
-	case WCD938X_ANA_BIAS:
-	case WCD938X_ANA_RX_SUPPLIES:
-	case WCD938X_ANA_HPH:
-	case WCD938X_ANA_EAR:
-	case WCD938X_ANA_EAR_COMPANDER_CTL:
-	case WCD938X_ANA_TX_CH1:
-	case WCD938X_ANA_TX_CH2:
-	case WCD938X_ANA_TX_CH3:
-	case WCD938X_ANA_TX_CH4:
-	case WCD938X_ANA_MICB1_MICB2_DSP_EN_LOGIC:
-	case WCD938X_ANA_MICB3_DSP_EN_LOGIC:
-	case WCD938X_ANA_MBHC_MECH:
-	case WCD938X_ANA_MBHC_ELECT:
-	case WCD938X_ANA_MBHC_ZDET:
-	case WCD938X_ANA_MBHC_BTN0:
-	case WCD938X_ANA_MBHC_BTN1:
-	case WCD938X_ANA_MBHC_BTN2:
-	case WCD938X_ANA_MBHC_BTN3:
-	case WCD938X_ANA_MBHC_BTN4:
-	case WCD938X_ANA_MBHC_BTN5:
-	case WCD938X_ANA_MBHC_BTN6:
-	case WCD938X_ANA_MBHC_BTN7:
-	case WCD938X_ANA_MICB1:
-	case WCD938X_ANA_MICB2:
-	case WCD938X_ANA_MICB2_RAMP:
-	case WCD938X_ANA_MICB3:
-	case WCD938X_ANA_MICB4:
-	case WCD938X_BIAS_CTL:
-	case WCD938X_BIAS_VBG_FINE_ADJ:
-	case WCD938X_LDOL_VDDCX_ADJUST:
-	case WCD938X_LDOL_DISABLE_LDOL:
-	case WCD938X_MBHC_CTL_CLK:
-	case WCD938X_MBHC_CTL_ANA:
-	case WCD938X_MBHC_CTL_SPARE_1:
-	case WCD938X_MBHC_CTL_SPARE_2:
-	case WCD938X_MBHC_CTL_BCS:
-	case WCD938X_MBHC_TEST_CTL:
-	case WCD938X_LDOH_MODE:
-	case WCD938X_LDOH_BIAS:
-	case WCD938X_LDOH_STB_LOADS:
-	case WCD938X_LDOH_SLOWRAMP:
-	case WCD938X_MICB1_TEST_CTL_1:
-	case WCD938X_MICB1_TEST_CTL_2:
-	case WCD938X_MICB1_TEST_CTL_3:
-	case WCD938X_MICB2_TEST_CTL_1:
-	case WCD938X_MICB2_TEST_CTL_2:
-	case WCD938X_MICB2_TEST_CTL_3:
-	case WCD938X_MICB3_TEST_CTL_1:
-	case WCD938X_MICB3_TEST_CTL_2:
-	case WCD938X_MICB3_TEST_CTL_3:
-	case WCD938X_MICB4_TEST_CTL_1:
-	case WCD938X_MICB4_TEST_CTL_2:
-	case WCD938X_MICB4_TEST_CTL_3:
-	case WCD938X_TX_COM_ADC_VCM:
-	case WCD938X_TX_COM_BIAS_ATEST:
-	case WCD938X_TX_COM_SPARE1:
-	case WCD938X_TX_COM_SPARE2:
-	case WCD938X_TX_COM_TXFE_DIV_CTL:
-	case WCD938X_TX_COM_TXFE_DIV_START:
-	case WCD938X_TX_COM_SPARE3:
-	case WCD938X_TX_COM_SPARE4:
-	case WCD938X_TX_1_2_TEST_EN:
-	case WCD938X_TX_1_2_ADC_IB:
-	case WCD938X_TX_1_2_ATEST_REFCTL:
-	case WCD938X_TX_1_2_TEST_CTL:
-	case WCD938X_TX_1_2_TEST_BLK_EN1:
-	case WCD938X_TX_1_2_TXFE1_CLKDIV:
-	case WCD938X_TX_3_4_TEST_EN:
-	case WCD938X_TX_3_4_ADC_IB:
-	case WCD938X_TX_3_4_ATEST_REFCTL:
-	case WCD938X_TX_3_4_TEST_CTL:
-	case WCD938X_TX_3_4_TEST_BLK_EN3:
-	case WCD938X_TX_3_4_TXFE3_CLKDIV:
-	case WCD938X_TX_3_4_TEST_BLK_EN2:
-	case WCD938X_TX_3_4_TXFE2_CLKDIV:
-	case WCD938X_TX_3_4_SPARE1:
-	case WCD938X_TX_3_4_TEST_BLK_EN4:
-	case WCD938X_TX_3_4_TXFE4_CLKDIV:
-	case WCD938X_TX_3_4_SPARE2:
-	case WCD938X_CLASSH_MODE_1:
-	case WCD938X_CLASSH_MODE_2:
-	case WCD938X_CLASSH_MODE_3:
-	case WCD938X_CLASSH_CTRL_VCL_1:
-	case WCD938X_CLASSH_CTRL_VCL_2:
-	case WCD938X_CLASSH_CTRL_CCL_1:
-	case WCD938X_CLASSH_CTRL_CCL_2:
-	case WCD938X_CLASSH_CTRL_CCL_3:
-	case WCD938X_CLASSH_CTRL_CCL_4:
-	case WCD938X_CLASSH_CTRL_CCL_5:
-	case WCD938X_CLASSH_BUCK_TMUX_A_D:
-	case WCD938X_CLASSH_BUCK_SW_DRV_CNTL:
-	case WCD938X_CLASSH_SPARE:
-	case WCD938X_FLYBACK_EN:
-	case WCD938X_FLYBACK_VNEG_CTRL_1:
-	case WCD938X_FLYBACK_VNEG_CTRL_2:
-	case WCD938X_FLYBACK_VNEG_CTRL_3:
-	case WCD938X_FLYBACK_VNEG_CTRL_4:
-	case WCD938X_FLYBACK_VNEG_CTRL_5:
-	case WCD938X_FLYBACK_VNEG_CTRL_6:
-	case WCD938X_FLYBACK_VNEG_CTRL_7:
-	case WCD938X_FLYBACK_VNEG_CTRL_8:
-	case WCD938X_FLYBACK_VNEG_CTRL_9:
-	case WCD938X_FLYBACK_VNEGDAC_CTRL_1:
-	case WCD938X_FLYBACK_VNEGDAC_CTRL_2:
-	case WCD938X_FLYBACK_VNEGDAC_CTRL_3:
-	case WCD938X_FLYBACK_CTRL_1:
-	case WCD938X_FLYBACK_TEST_CTL:
-	case WCD938X_RX_AUX_SW_CTL:
-	case WCD938X_RX_PA_AUX_IN_CONN:
-	case WCD938X_RX_TIMER_DIV:
-	case WCD938X_RX_OCP_CTL:
-	case WCD938X_RX_OCP_COUNT:
-	case WCD938X_RX_BIAS_EAR_DAC:
-	case WCD938X_RX_BIAS_EAR_AMP:
-	case WCD938X_RX_BIAS_HPH_LDO:
-	case WCD938X_RX_BIAS_HPH_PA:
-	case WCD938X_RX_BIAS_HPH_RDACBUFF_CNP2:
-	case WCD938X_RX_BIAS_HPH_RDAC_LDO:
-	case WCD938X_RX_BIAS_HPH_CNP1:
-	case WCD938X_RX_BIAS_HPH_LOWPOWER:
-	case WCD938X_RX_BIAS_AUX_DAC:
-	case WCD938X_RX_BIAS_AUX_AMP:
-	case WCD938X_RX_BIAS_VNEGDAC_BLEEDER:
-	case WCD938X_RX_BIAS_MISC:
-	case WCD938X_RX_BIAS_BUCK_RST:
-	case WCD938X_RX_BIAS_BUCK_VREF_ERRAMP:
-	case WCD938X_RX_BIAS_FLYB_ERRAMP:
-	case WCD938X_RX_BIAS_FLYB_BUFF:
-	case WCD938X_RX_BIAS_FLYB_MID_RST:
-	case WCD938X_HPH_CNP_EN:
-	case WCD938X_HPH_CNP_WG_CTL:
-	case WCD938X_HPH_CNP_WG_TIME:
-	case WCD938X_HPH_OCP_CTL:
-	case WCD938X_HPH_AUTO_CHOP:
-	case WCD938X_HPH_CHOP_CTL:
-	case WCD938X_HPH_PA_CTL1:
-	case WCD938X_HPH_PA_CTL2:
-	case WCD938X_HPH_L_EN:
-	case WCD938X_HPH_L_TEST:
-	case WCD938X_HPH_L_ATEST:
-	case WCD938X_HPH_R_EN:
-	case WCD938X_HPH_R_TEST:
-	case WCD938X_HPH_R_ATEST:
-	case WCD938X_HPH_RDAC_CLK_CTL1:
-	case WCD938X_HPH_RDAC_CLK_CTL2:
-	case WCD938X_HPH_RDAC_LDO_CTL:
-	case WCD938X_HPH_RDAC_CHOP_CLK_LP_CTL:
-	case WCD938X_HPH_REFBUFF_UHQA_CTL:
-	case WCD938X_HPH_REFBUFF_LP_CTL:
-	case WCD938X_HPH_L_DAC_CTL:
-	case WCD938X_HPH_R_DAC_CTL:
-	case WCD938X_HPH_SURGE_HPHLR_SURGE_COMP_SEL:
-	case WCD938X_HPH_SURGE_HPHLR_SURGE_EN:
-	case WCD938X_HPH_SURGE_HPHLR_SURGE_MISC1:
-	case WCD938X_EAR_EAR_EN_REG:
-	case WCD938X_EAR_EAR_PA_CON:
-	case WCD938X_EAR_EAR_SP_CON:
-	case WCD938X_EAR_EAR_DAC_CON:
-	case WCD938X_EAR_EAR_CNP_FSM_CON:
-	case WCD938X_EAR_TEST_CTL:
-	case WCD938X_ANA_NEW_PAGE_REGISTER:
-	case WCD938X_HPH_NEW_ANA_HPH2:
-	case WCD938X_HPH_NEW_ANA_HPH3:
-	case WCD938X_SLEEP_CTL:
-	case WCD938X_SLEEP_WATCHDOG_CTL:
-	case WCD938X_MBHC_NEW_ELECT_REM_CLAMP_CTL:
-	case WCD938X_MBHC_NEW_CTL_1:
-	case WCD938X_MBHC_NEW_CTL_2:
-	case WCD938X_MBHC_NEW_PLUG_DETECT_CTL:
-	case WCD938X_MBHC_NEW_ZDET_ANA_CTL:
-	case WCD938X_MBHC_NEW_ZDET_RAMP_CTL:
-	case WCD938X_TX_NEW_AMIC_MUX_CFG:
-	case WCD938X_AUX_AUXPA:
-	case WCD938X_LDORXTX_MODE:
-	case WCD938X_LDORXTX_CONFIG:
-	case WCD938X_DIE_CRACK_DIE_CRK_DET_EN:
-	case WCD938X_HPH_NEW_INT_RDAC_GAIN_CTL:
-	case WCD938X_HPH_NEW_INT_RDAC_HD2_CTL_L:
-	case WCD938X_HPH_NEW_INT_RDAC_VREF_CTL:
-	case WCD938X_HPH_NEW_INT_RDAC_OVERRIDE_CTL:
-	case WCD938X_HPH_NEW_INT_RDAC_HD2_CTL_R:
-	case WCD938X_HPH_NEW_INT_PA_MISC1:
-	case WCD938X_HPH_NEW_INT_PA_MISC2:
-	case WCD938X_HPH_NEW_INT_PA_RDAC_MISC:
-	case WCD938X_HPH_NEW_INT_HPH_TIMER1:
-	case WCD938X_HPH_NEW_INT_HPH_TIMER2:
-	case WCD938X_HPH_NEW_INT_HPH_TIMER3:
-	case WCD938X_HPH_NEW_INT_HPH_TIMER4:
-	case WCD938X_HPH_NEW_INT_PA_RDAC_MISC2:
-	case WCD938X_HPH_NEW_INT_PA_RDAC_MISC3:
-	case WCD938X_HPH_NEW_INT_RDAC_HD2_CTL_L_NEW:
-	case WCD938X_HPH_NEW_INT_RDAC_HD2_CTL_R_NEW:
-	case WCD938X_RX_NEW_INT_HPH_RDAC_BIAS_LOHIFI:
-	case WCD938X_RX_NEW_INT_HPH_RDAC_BIAS_ULP:
-	case WCD938X_RX_NEW_INT_HPH_RDAC_LDO_LP:
-	case WCD938X_MBHC_NEW_INT_MOISTURE_DET_DC_CTRL:
-	case WCD938X_MBHC_NEW_INT_MOISTURE_DET_POLLING_CTRL:
-	case WCD938X_MBHC_NEW_INT_MECH_DET_CURRENT:
-	case WCD938X_MBHC_NEW_INT_SPARE_2:
-	case WCD938X_EAR_INT_NEW_EAR_CHOPPER_CON:
-	case WCD938X_EAR_INT_NEW_CNP_VCM_CON1:
-	case WCD938X_EAR_INT_NEW_CNP_VCM_CON2:
-	case WCD938X_EAR_INT_NEW_EAR_DYNAMIC_BIAS:
-	case WCD938X_AUX_INT_EN_REG:
-	case WCD938X_AUX_INT_PA_CTRL:
-	case WCD938X_AUX_INT_SP_CTRL:
-	case WCD938X_AUX_INT_DAC_CTRL:
-	case WCD938X_AUX_INT_CLK_CTRL:
-	case WCD938X_AUX_INT_TEST_CTRL:
-	case WCD938X_AUX_INT_MISC:
-	case WCD938X_LDORXTX_INT_BIAS:
-	case WCD938X_LDORXTX_INT_STB_LOADS_DTEST:
-	case WCD938X_LDORXTX_INT_TEST0:
-	case WCD938X_LDORXTX_INT_STARTUP_TIMER:
-	case WCD938X_LDORXTX_INT_TEST1:
-	case WCD938X_SLEEP_INT_WATCHDOG_CTL_1:
-	case WCD938X_SLEEP_INT_WATCHDOG_CTL_2:
-	case WCD938X_DIE_CRACK_INT_DIE_CRK_DET_INT1:
-	case WCD938X_DIE_CRACK_INT_DIE_CRK_DET_INT2:
-	case WCD938X_TX_COM_NEW_INT_TXFE_DIVSTOP_L2:
-	case WCD938X_TX_COM_NEW_INT_TXFE_DIVSTOP_L1:
-	case WCD938X_TX_COM_NEW_INT_TXFE_DIVSTOP_L0:
-	case WCD938X_TX_COM_NEW_INT_TXFE_DIVSTOP_ULP1P2M:
-	case WCD938X_TX_COM_NEW_INT_TXFE_DIVSTOP_ULP0P6M:
-	case WCD938X_TX_COM_NEW_INT_TXFE_ICTRL_STG1_L2L1:
-	case WCD938X_TX_COM_NEW_INT_TXFE_ICTRL_STG1_L0:
-	case WCD938X_TX_COM_NEW_INT_TXFE_ICTRL_STG1_ULP:
-	case WCD938X_TX_COM_NEW_INT_TXFE_ICTRL_STG2MAIN_L2L1:
-	case WCD938X_TX_COM_NEW_INT_TXFE_ICTRL_STG2MAIN_L0:
-	case WCD938X_TX_COM_NEW_INT_TXFE_ICTRL_STG2MAIN_ULP:
-	case WCD938X_TX_COM_NEW_INT_TXFE_ICTRL_STG2CASC_L2L1L0:
-	case WCD938X_TX_COM_NEW_INT_TXFE_ICTRL_STG2CASC_ULP:
-	case WCD938X_TX_COM_NEW_INT_TXADC_SCBIAS_L2L1:
-	case WCD938X_TX_COM_NEW_INT_TXADC_SCBIAS_L0ULP:
-	case WCD938X_TX_COM_NEW_INT_TXADC_INT_L2:
-	case WCD938X_TX_COM_NEW_INT_TXADC_INT_L1:
-	case WCD938X_TX_COM_NEW_INT_TXADC_INT_L0:
-	case WCD938X_TX_COM_NEW_INT_TXADC_INT_ULP:
-	case WCD938X_DIGITAL_PAGE_REGISTER:
-	case WCD938X_DIGITAL_SWR_TX_CLK_RATE:
-	case WCD938X_DIGITAL_CDC_RST_CTL:
-	case WCD938X_DIGITAL_TOP_CLK_CFG:
-	case WCD938X_DIGITAL_CDC_ANA_CLK_CTL:
-	case WCD938X_DIGITAL_CDC_DIG_CLK_CTL:
-	case WCD938X_DIGITAL_SWR_RST_EN:
-	case WCD938X_DIGITAL_CDC_PATH_MODE:
-	case WCD938X_DIGITAL_CDC_RX_RST:
-	case WCD938X_DIGITAL_CDC_RX0_CTL:
-	case WCD938X_DIGITAL_CDC_RX1_CTL:
-	case WCD938X_DIGITAL_CDC_RX2_CTL:
-	case WCD938X_DIGITAL_CDC_TX_ANA_MODE_0_1:
-	case WCD938X_DIGITAL_CDC_TX_ANA_MODE_2_3:
-	case WCD938X_DIGITAL_CDC_COMP_CTL_0:
-	case WCD938X_DIGITAL_CDC_ANA_TX_CLK_CTL:
-	case WCD938X_DIGITAL_CDC_HPH_DSM_A1_0:
-	case WCD938X_DIGITAL_CDC_HPH_DSM_A1_1:
-	case WCD938X_DIGITAL_CDC_HPH_DSM_A2_0:
-	case WCD938X_DIGITAL_CDC_HPH_DSM_A2_1:
-	case WCD938X_DIGITAL_CDC_HPH_DSM_A3_0:
-	case WCD938X_DIGITAL_CDC_HPH_DSM_A3_1:
-	case WCD938X_DIGITAL_CDC_HPH_DSM_A4_0:
-	case WCD938X_DIGITAL_CDC_HPH_DSM_A4_1:
-	case WCD938X_DIGITAL_CDC_HPH_DSM_A5_0:
-	case WCD938X_DIGITAL_CDC_HPH_DSM_A5_1:
-	case WCD938X_DIGITAL_CDC_HPH_DSM_A6_0:
-	case WCD938X_DIGITAL_CDC_HPH_DSM_A7_0:
-	case WCD938X_DIGITAL_CDC_HPH_DSM_C_0:
-	case WCD938X_DIGITAL_CDC_HPH_DSM_C_1:
-	case WCD938X_DIGITAL_CDC_HPH_DSM_C_2:
-	case WCD938X_DIGITAL_CDC_HPH_DSM_C_3:
-	case WCD938X_DIGITAL_CDC_HPH_DSM_R1:
-	case WCD938X_DIGITAL_CDC_HPH_DSM_R2:
-	case WCD938X_DIGITAL_CDC_HPH_DSM_R3:
-	case WCD938X_DIGITAL_CDC_HPH_DSM_R4:
-	case WCD938X_DIGITAL_CDC_HPH_DSM_R5:
-	case WCD938X_DIGITAL_CDC_HPH_DSM_R6:
-	case WCD938X_DIGITAL_CDC_HPH_DSM_R7:
-	case WCD938X_DIGITAL_CDC_AUX_DSM_A1_0:
-	case WCD938X_DIGITAL_CDC_AUX_DSM_A1_1:
-	case WCD938X_DIGITAL_CDC_AUX_DSM_A2_0:
-	case WCD938X_DIGITAL_CDC_AUX_DSM_A2_1:
-	case WCD938X_DIGITAL_CDC_AUX_DSM_A3_0:
-	case WCD938X_DIGITAL_CDC_AUX_DSM_A3_1:
-	case WCD938X_DIGITAL_CDC_AUX_DSM_A4_0:
-	case WCD938X_DIGITAL_CDC_AUX_DSM_A4_1:
-	case WCD938X_DIGITAL_CDC_AUX_DSM_A5_0:
-	case WCD938X_DIGITAL_CDC_AUX_DSM_A5_1:
-	case WCD938X_DIGITAL_CDC_AUX_DSM_A6_0:
-	case WCD938X_DIGITAL_CDC_AUX_DSM_A7_0:
-	case WCD938X_DIGITAL_CDC_AUX_DSM_C_0:
-	case WCD938X_DIGITAL_CDC_AUX_DSM_C_1:
-	case WCD938X_DIGITAL_CDC_AUX_DSM_C_2:
-	case WCD938X_DIGITAL_CDC_AUX_DSM_C_3:
-	case WCD938X_DIGITAL_CDC_AUX_DSM_R1:
-	case WCD938X_DIGITAL_CDC_AUX_DSM_R2:
-	case WCD938X_DIGITAL_CDC_AUX_DSM_R3:
-	case WCD938X_DIGITAL_CDC_AUX_DSM_R4:
-	case WCD938X_DIGITAL_CDC_AUX_DSM_R5:
-	case WCD938X_DIGITAL_CDC_AUX_DSM_R6:
-	case WCD938X_DIGITAL_CDC_AUX_DSM_R7:
-	case WCD938X_DIGITAL_CDC_HPH_GAIN_RX_0:
-	case WCD938X_DIGITAL_CDC_HPH_GAIN_RX_1:
-	case WCD938X_DIGITAL_CDC_HPH_GAIN_DSD_0:
-	case WCD938X_DIGITAL_CDC_HPH_GAIN_DSD_1:
-	case WCD938X_DIGITAL_CDC_HPH_GAIN_DSD_2:
-	case WCD938X_DIGITAL_CDC_AUX_GAIN_DSD_0:
-	case WCD938X_DIGITAL_CDC_AUX_GAIN_DSD_1:
-	case WCD938X_DIGITAL_CDC_AUX_GAIN_DSD_2:
-	case WCD938X_DIGITAL_CDC_HPH_GAIN_CTL:
-	case WCD938X_DIGITAL_CDC_AUX_GAIN_CTL:
-	case WCD938X_DIGITAL_CDC_EAR_PATH_CTL:
-	case WCD938X_DIGITAL_CDC_SWR_CLH:
-	case WCD938X_DIGITAL_SWR_CLH_BYP:
-	case WCD938X_DIGITAL_CDC_TX0_CTL:
-	case WCD938X_DIGITAL_CDC_TX1_CTL:
-	case WCD938X_DIGITAL_CDC_TX2_CTL:
-	case WCD938X_DIGITAL_CDC_TX_RST:
-	case WCD938X_DIGITAL_CDC_REQ_CTL:
-	case WCD938X_DIGITAL_CDC_RST:
-	case WCD938X_DIGITAL_CDC_AMIC_CTL:
-	case WCD938X_DIGITAL_CDC_DMIC_CTL:
-	case WCD938X_DIGITAL_CDC_DMIC1_CTL:
-	case WCD938X_DIGITAL_CDC_DMIC2_CTL:
-	case WCD938X_DIGITAL_CDC_DMIC3_CTL:
-	case WCD938X_DIGITAL_CDC_DMIC4_CTL:
-	case WCD938X_DIGITAL_EFUSE_PRG_CTL:
-	case WCD938X_DIGITAL_EFUSE_CTL:
-	case WCD938X_DIGITAL_CDC_DMIC_RATE_1_2:
-	case WCD938X_DIGITAL_CDC_DMIC_RATE_3_4:
-	case WCD938X_DIGITAL_PDM_WD_CTL0:
-	case WCD938X_DIGITAL_PDM_WD_CTL1:
-	case WCD938X_DIGITAL_PDM_WD_CTL2:
-	case WCD938X_DIGITAL_INTR_MODE:
-	case WCD938X_DIGITAL_INTR_MASK_0:
-	case WCD938X_DIGITAL_INTR_MASK_1:
-	case WCD938X_DIGITAL_INTR_MASK_2:
-	case WCD938X_DIGITAL_INTR_CLEAR_0:
-	case WCD938X_DIGITAL_INTR_CLEAR_1:
-	case WCD938X_DIGITAL_INTR_CLEAR_2:
-	case WCD938X_DIGITAL_INTR_LEVEL_0:
-	case WCD938X_DIGITAL_INTR_LEVEL_1:
-	case WCD938X_DIGITAL_INTR_LEVEL_2:
-	case WCD938X_DIGITAL_INTR_SET_0:
-	case WCD938X_DIGITAL_INTR_SET_1:
-	case WCD938X_DIGITAL_INTR_SET_2:
-	case WCD938X_DIGITAL_INTR_TEST_0:
-	case WCD938X_DIGITAL_INTR_TEST_1:
-	case WCD938X_DIGITAL_INTR_TEST_2:
-	case WCD938X_DIGITAL_TX_MODE_DBG_EN:
-	case WCD938X_DIGITAL_TX_MODE_DBG_0_1:
-	case WCD938X_DIGITAL_TX_MODE_DBG_2_3:
-	case WCD938X_DIGITAL_LB_IN_SEL_CTL:
-	case WCD938X_DIGITAL_LOOP_BACK_MODE:
-	case WCD938X_DIGITAL_SWR_DAC_TEST:
-	case WCD938X_DIGITAL_SWR_HM_TEST_RX_0:
-	case WCD938X_DIGITAL_SWR_HM_TEST_TX_0:
-	case WCD938X_DIGITAL_SWR_HM_TEST_RX_1:
-	case WCD938X_DIGITAL_SWR_HM_TEST_TX_1:
-	case WCD938X_DIGITAL_SWR_HM_TEST_TX_2:
-	case WCD938X_DIGITAL_PAD_CTL_SWR_0:
-	case WCD938X_DIGITAL_PAD_CTL_SWR_1:
-	case WCD938X_DIGITAL_I2C_CTL:
-	case WCD938X_DIGITAL_CDC_TX_TANGGU_SW_MODE:
-	case WCD938X_DIGITAL_EFUSE_TEST_CTL_0:
-	case WCD938X_DIGITAL_EFUSE_TEST_CTL_1:
-	case WCD938X_DIGITAL_PAD_CTL_PDM_RX0:
-	case WCD938X_DIGITAL_PAD_CTL_PDM_RX1:
-	case WCD938X_DIGITAL_PAD_CTL_PDM_TX0:
-	case WCD938X_DIGITAL_PAD_CTL_PDM_TX1:
-	case WCD938X_DIGITAL_PAD_CTL_PDM_TX2:
-	case WCD938X_DIGITAL_PAD_INP_DIS_0:
-	case WCD938X_DIGITAL_PAD_INP_DIS_1:
-	case WCD938X_DIGITAL_DRIVE_STRENGTH_0:
-	case WCD938X_DIGITAL_DRIVE_STRENGTH_1:
-	case WCD938X_DIGITAL_DRIVE_STRENGTH_2:
-	case WCD938X_DIGITAL_RX_DATA_EDGE_CTL:
-	case WCD938X_DIGITAL_TX_DATA_EDGE_CTL:
-	case WCD938X_DIGITAL_GPIO_MODE:
-	case WCD938X_DIGITAL_PIN_CTL_OE:
-	case WCD938X_DIGITAL_PIN_CTL_DATA_0:
-	case WCD938X_DIGITAL_PIN_CTL_DATA_1:
-	case WCD938X_DIGITAL_DIG_DEBUG_CTL:
-	case WCD938X_DIGITAL_DIG_DEBUG_EN:
-	case WCD938X_DIGITAL_ANA_CSR_DBG_ADD:
-	case WCD938X_DIGITAL_ANA_CSR_DBG_CTL:
-	case WCD938X_DIGITAL_SSP_DBG:
-	case WCD938X_DIGITAL_SPARE_0:
-	case WCD938X_DIGITAL_SPARE_1:
-	case WCD938X_DIGITAL_SPARE_2:
-	case WCD938X_DIGITAL_TX_REQ_FB_CTL_0:
-	case WCD938X_DIGITAL_TX_REQ_FB_CTL_1:
-	case WCD938X_DIGITAL_TX_REQ_FB_CTL_2:
-	case WCD938X_DIGITAL_TX_REQ_FB_CTL_3:
-	case WCD938X_DIGITAL_TX_REQ_FB_CTL_4:
-	case WCD938X_DIGITAL_DEM_BYPASS_DATA0:
-	case WCD938X_DIGITAL_DEM_BYPASS_DATA1:
-	case WCD938X_DIGITAL_DEM_BYPASS_DATA2:
-	case WCD938X_DIGITAL_DEM_BYPASS_DATA3:
-		return true;
-	}
-
-	return false;
-}
-
-static bool wcd938x_readonly_register(struct device *dev, unsigned int reg)
-{
-	switch (reg) {
-	case WCD938X_ANA_MBHC_RESULT_1:
-	case WCD938X_ANA_MBHC_RESULT_2:
-	case WCD938X_ANA_MBHC_RESULT_3:
-	case WCD938X_MBHC_MOISTURE_DET_FSM_STATUS:
-	case WCD938X_TX_1_2_SAR2_ERR:
-	case WCD938X_TX_1_2_SAR1_ERR:
-	case WCD938X_TX_3_4_SAR4_ERR:
-	case WCD938X_TX_3_4_SAR3_ERR:
-	case WCD938X_HPH_L_STATUS:
-	case WCD938X_HPH_R_STATUS:
-	case WCD938X_HPH_SURGE_HPHLR_SURGE_STATUS:
-	case WCD938X_EAR_STATUS_REG_1:
-	case WCD938X_EAR_STATUS_REG_2:
-	case WCD938X_MBHC_NEW_FSM_STATUS:
-	case WCD938X_MBHC_NEW_ADC_RESULT:
-	case WCD938X_DIE_CRACK_DIE_CRK_DET_OUT:
-	case WCD938X_AUX_INT_STATUS_REG:
-	case WCD938X_LDORXTX_INT_STATUS:
-	case WCD938X_DIGITAL_CHIP_ID0:
-	case WCD938X_DIGITAL_CHIP_ID1:
-	case WCD938X_DIGITAL_CHIP_ID2:
-	case WCD938X_DIGITAL_CHIP_ID3:
-	case WCD938X_DIGITAL_INTR_STATUS_0:
-	case WCD938X_DIGITAL_INTR_STATUS_1:
-	case WCD938X_DIGITAL_INTR_STATUS_2:
-	case WCD938X_DIGITAL_INTR_CLEAR_0:
-	case WCD938X_DIGITAL_INTR_CLEAR_1:
-	case WCD938X_DIGITAL_INTR_CLEAR_2:
-	case WCD938X_DIGITAL_SWR_HM_TEST_0:
-	case WCD938X_DIGITAL_SWR_HM_TEST_1:
-	case WCD938X_DIGITAL_EFUSE_T_DATA_0:
-	case WCD938X_DIGITAL_EFUSE_T_DATA_1:
-	case WCD938X_DIGITAL_PIN_STATUS_0:
-	case WCD938X_DIGITAL_PIN_STATUS_1:
-	case WCD938X_DIGITAL_MODE_STATUS_0:
-	case WCD938X_DIGITAL_MODE_STATUS_1:
-	case WCD938X_DIGITAL_EFUSE_REG_0:
-	case WCD938X_DIGITAL_EFUSE_REG_1:
-	case WCD938X_DIGITAL_EFUSE_REG_2:
-	case WCD938X_DIGITAL_EFUSE_REG_3:
-	case WCD938X_DIGITAL_EFUSE_REG_4:
-	case WCD938X_DIGITAL_EFUSE_REG_5:
-	case WCD938X_DIGITAL_EFUSE_REG_6:
-	case WCD938X_DIGITAL_EFUSE_REG_7:
-	case WCD938X_DIGITAL_EFUSE_REG_8:
-	case WCD938X_DIGITAL_EFUSE_REG_9:
-	case WCD938X_DIGITAL_EFUSE_REG_10:
-	case WCD938X_DIGITAL_EFUSE_REG_11:
-	case WCD938X_DIGITAL_EFUSE_REG_12:
-	case WCD938X_DIGITAL_EFUSE_REG_13:
-	case WCD938X_DIGITAL_EFUSE_REG_14:
-	case WCD938X_DIGITAL_EFUSE_REG_15:
-	case WCD938X_DIGITAL_EFUSE_REG_16:
-	case WCD938X_DIGITAL_EFUSE_REG_17:
-	case WCD938X_DIGITAL_EFUSE_REG_18:
-	case WCD938X_DIGITAL_EFUSE_REG_19:
-	case WCD938X_DIGITAL_EFUSE_REG_20:
-	case WCD938X_DIGITAL_EFUSE_REG_21:
-	case WCD938X_DIGITAL_EFUSE_REG_22:
-	case WCD938X_DIGITAL_EFUSE_REG_23:
-	case WCD938X_DIGITAL_EFUSE_REG_24:
-	case WCD938X_DIGITAL_EFUSE_REG_25:
-	case WCD938X_DIGITAL_EFUSE_REG_26:
-	case WCD938X_DIGITAL_EFUSE_REG_27:
-	case WCD938X_DIGITAL_EFUSE_REG_28:
-	case WCD938X_DIGITAL_EFUSE_REG_29:
-	case WCD938X_DIGITAL_EFUSE_REG_30:
-	case WCD938X_DIGITAL_EFUSE_REG_31:
-		return true;
-	}
-	return false;
-}
-
-static bool wcd938x_readable_register(struct device *dev, unsigned int reg)
-{
-	bool ret;
-
-	ret = wcd938x_readonly_register(dev, reg);
-	if (!ret)
-		return wcd938x_rdwr_register(dev, reg);
-
-	return ret;
-}
-
-static bool wcd938x_writeable_register(struct device *dev, unsigned int reg)
-{
-	return wcd938x_rdwr_register(dev, reg);
-}
-
-static bool wcd938x_volatile_register(struct device *dev, unsigned int reg)
-{
-	if (reg <= WCD938X_BASE_ADDRESS)
-		return false;
-
-	if (reg == WCD938X_DIGITAL_SWR_TX_CLK_RATE)
-		return true;
-
-	if (wcd938x_readonly_register(dev, reg))
-		return true;
-
-	return false;
-}
-
-static struct regmap_config wcd938x_regmap_config = {
-	.name = "wcd938x_csr",
-	.reg_bits = 32,
-	.val_bits = 8,
-	.cache_type = REGCACHE_RBTREE,
-	.reg_defaults = wcd938x_defaults,
-	.num_reg_defaults = ARRAY_SIZE(wcd938x_defaults),
-	.max_register = WCD938X_MAX_REGISTER,
-	.readable_reg = wcd938x_readable_register,
-	.writeable_reg = wcd938x_writeable_register,
-	.volatile_reg = wcd938x_volatile_register,
-	.can_multi_write = true,
-};
-
 static const struct regmap_irq wcd938x_irqs[WCD938X_NUM_IRQS] = {
 	REGMAP_IRQ_REG(WCD938X_IRQ_MBHC_BUTTON_PRESS_DET, 0, 0x01),
 	REGMAP_IRQ_REG(WCD938X_IRQ_MBHC_BUTTON_RELEASE_DET, 0, 0x02),
@@ -4412,10 +3417,10 @@ static int wcd938x_bind(struct device *dev)
 		return -EINVAL;
 	}
 
-	wcd938x->regmap = devm_regmap_init_sdw(wcd938x->tx_sdw_dev, &wcd938x_regmap_config);
-	if (IS_ERR(wcd938x->regmap)) {
-		dev_err(dev, "%s: tx csr regmap not found\n", __func__);
-		return PTR_ERR(wcd938x->regmap);
+	wcd938x->regmap = dev_get_regmap(&wcd938x->tx_sdw_dev->dev, NULL);
+	if (!wcd938x->regmap) {
+		dev_err(dev, "could not get TX device regmap\n");
+		return -EINVAL;
 	}
 
 	ret = wcd938x_irq_init(wcd938x, dev);
diff --git a/sound/soc/codecs/wcd938x.h b/sound/soc/codecs/wcd938x.h
index ea82039e7843..74b1498fec38 100644
--- a/sound/soc/codecs/wcd938x.h
+++ b/sound/soc/codecs/wcd938x.h
@@ -663,6 +663,7 @@ struct wcd938x_sdw_priv {
 	bool is_tx;
 	struct wcd938x_priv *wcd938x;
 	struct irq_domain *slave_irq;
+	struct regmap *regmap;
 };
 
 #if IS_ENABLED(CONFIG_SND_SOC_WCD938X_SDW)
diff --git a/sound/soc/codecs/wsa881x.c b/sound/soc/codecs/wsa881x.c
index 6c8b1db649b8..046843b57b03 100644
--- a/sound/soc/codecs/wsa881x.c
+++ b/sound/soc/codecs/wsa881x.c
@@ -1101,7 +1101,7 @@ static int wsa881x_bus_config(struct sdw_slave *slave,
 	return 0;
 }
 
-static struct sdw_slave_ops wsa881x_slave_ops = {
+static const struct sdw_slave_ops wsa881x_slave_ops = {
 	.update_status = wsa881x_update_status,
 	.bus_config = wsa881x_bus_config,
 	.port_prep = wsa881x_port_prep,
diff --git a/sound/soc/codecs/wsa883x.c b/sound/soc/codecs/wsa883x.c
index 58fdb4e9fd97..693e988f30c0 100644
--- a/sound/soc/codecs/wsa883x.c
+++ b/sound/soc/codecs/wsa883x.c
@@ -1073,7 +1073,7 @@ static int wsa883x_port_prep(struct sdw_slave *slave,
 	return 0;
 }
 
-static struct sdw_slave_ops wsa883x_slave_ops = {
+static const struct sdw_slave_ops wsa883x_slave_ops = {
 	.update_status = wsa883x_update_status,
 	.port_prep = wsa883x_port_prep,
 };
diff --git a/sound/soc/intel/common/soc-acpi-intel-byt-match.c b/sound/soc/intel/common/soc-acpi-intel-byt-match.c
index db5a92b9875a..87c44f284971 100644
--- a/sound/soc/intel/common/soc-acpi-intel-byt-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-byt-match.c
@@ -124,7 +124,7 @@ static const struct snd_soc_acpi_codecs rt5640_comp_ids = {
 };
 
 static const struct snd_soc_acpi_codecs wm5102_comp_ids = {
-	.num_codecs = 2,
+	.num_codecs = 3,
 	.codecs = { "10WM5102", "WM510204", "WM510205"},
 };
 
diff --git a/sound/usb/caiaq/input.c b/sound/usb/caiaq/input.c
index 1e2cf2f08eec..84f26dce7f5d 100644
--- a/sound/usb/caiaq/input.c
+++ b/sound/usb/caiaq/input.c
@@ -804,6 +804,7 @@ int snd_usb_caiaq_input_init(struct snd_usb_caiaqdev *cdev)
 
 	default:
 		/* no input methods supported on this device */
+		ret = -EINVAL;
 		goto exit_free_idev;
 	}
 
diff --git a/tools/perf/Build b/tools/perf/Build
index 6dd67e502295..aa7623622834 100644
--- a/tools/perf/Build
+++ b/tools/perf/Build
@@ -56,6 +56,6 @@ CFLAGS_builtin-report.o	   += -DDOCDIR="BUILD_STR($(srcdir_SQ)/Documentation)"
 perf-y += util/
 perf-y += arch/
 perf-y += ui/
-perf-$(CONFIG_LIBTRACEEVENT) += scripts/
+perf-y += scripts/
 
 gtk-y += ui/gtk/
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index b7d9c4206230..cc2b0ace54ba 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -647,13 +647,16 @@ all: shell_compatibility_test $(ALL_PROGRAMS) $(LANG_BINDINGS) $(OTHER_PROGRAMS)
 # Create python binding output directory if not already present
 _dummy := $(shell [ -d '$(OUTPUT)python' ] || mkdir -p '$(OUTPUT)python')
 
-$(OUTPUT)python/perf$(PYTHON_EXTENSION_SUFFIX): $(PYTHON_EXT_SRCS) $(PYTHON_EXT_DEPS) $(LIBPERF)
+$(OUTPUT)python/perf$(PYTHON_EXTENSION_SUFFIX): $(PYTHON_EXT_SRCS) $(PYTHON_EXT_DEPS) $(LIBPERF) $(LIBSUBCMD)
 	$(QUIET_GEN)LDSHARED="$(CC) -pthread -shared" \
         CFLAGS='$(CFLAGS)' LDFLAGS='$(LDFLAGS)' \
 	  $(PYTHON_WORD) util/setup.py \
 	  --quiet build_ext; \
 	cp $(PYTHON_EXTBUILD_LIB)perf*.so $(OUTPUT)python/
 
+python_perf_target:
+	@echo "Target is: $(OUTPUT)python/perf$(PYTHON_EXTENSION_SUFFIX)"
+
 please_set_SHELL_PATH_to_a_more_modern_shell:
 	$(Q)$$(:)
 
@@ -1151,7 +1154,7 @@ FORCE:
 .PHONY: all install clean config-clean strip install-gtk
 .PHONY: shell_compatibility_test please_set_SHELL_PATH_to_a_more_modern_shell
 .PHONY: .FORCE-PERF-VERSION-FILE TAGS tags cscope FORCE prepare
-.PHONY: archheaders
+.PHONY: archheaders python_perf_target
 
 endif # force_fixdep
 
diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index d7fe00f66b83..fb1b66ef2e16 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -1228,10 +1228,12 @@ int cmd_ftrace(int argc, const char **argv)
 		goto out_delete_filters;
 	}
 
+	/* Make system wide (-a) the default target. */
+	if (!argc && target__none(&ftrace.target))
+		ftrace.target.system_wide = true;
+
 	switch (subcmd) {
 	case PERF_FTRACE_TRACE:
-		if (!argc && target__none(&ftrace.target))
-			ftrace.target.system_wide = true;
 		cmd_func = __cmd_ftrace;
 		break;
 	case PERF_FTRACE_LATENCY:
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 8374117e66f6..be7c0c29d15b 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1866,7 +1866,7 @@ static void __record__read_lost_samples(struct record *rec, struct evsel *evsel,
 	int id_hdr_size;
 
 	if (perf_evsel__read(&evsel->core, cpu_idx, thread_idx, &count) < 0) {
-		pr_err("read LOST count failed\n");
+		pr_debug("read LOST count failed\n");
 		return;
 	}
 
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 69394ac0a20d..2f185012b9dd 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -2288,8 +2288,8 @@ static void setup_scripting(void)
 {
 #ifdef HAVE_LIBTRACEEVENT
 	setup_perl_scripting();
-	setup_python_scripting();
 #endif
+	setup_python_scripting();
 }
 
 static int flush_scripting(void)
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 387dc9c9e7be..682db49eef4c 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -773,7 +773,7 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 		counter->reset_group = false;
 		if (bpf_counter__load(counter, &target))
 			return -1;
-		if (!evsel__is_bpf(counter))
+		if (!(evsel__is_bperf(counter)))
 			all_counters_use_bpf = false;
 	}
 
@@ -789,7 +789,7 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 
 		if (counter->reset_group || counter->errored)
 			continue;
-		if (evsel__is_bpf(counter))
+		if (evsel__is_bperf(counter))
 			continue;
 try_again:
 		if (create_perf_stat_counter(counter, &stat_config, &target,
diff --git a/tools/perf/pmu-events/arch/powerpc/power9/other.json b/tools/perf/pmu-events/arch/powerpc/power9/other.json
index 3f69422c21f9..f10bd554521a 100644
--- a/tools/perf/pmu-events/arch/powerpc/power9/other.json
+++ b/tools/perf/pmu-events/arch/powerpc/power9/other.json
@@ -1417,7 +1417,7 @@
   {
     "EventCode": "0x45054",
     "EventName": "PM_FMA_CMPL",
-    "BriefDescription": "two flops operation completed (fmadd, fnmadd, fmsub, fnmsub) Scalar instructions only. "
+    "BriefDescription": "two flops operation completed (fmadd, fnmadd, fmsub, fnmsub) Scalar instructions only."
   },
   {
     "EventCode": "0x201E8",
@@ -2017,7 +2017,7 @@
   {
     "EventCode": "0xC0BC",
     "EventName": "PM_LSU_FLUSH_OTHER",
-    "BriefDescription": "Other LSU flushes including: Sync (sync ack from L2 caused search of LRQ for oldest snooped load, This will either signal a Precise Flush of the oldest snooped loa or a Flush Next PPC); Data Valid Flush Next (several cases of this, one example is store and reload are lined up such that a store-hit-reload scenario exists and the CDF has already launched and has gotten bad/stale data); Bad Data Valid Flush Next (might be a few cases of this, one example is a larxa (D$ hit) return data and dval but can't allocate to LMQ (LMQ full or other reason). Already gave dval but can't watch it for snoop_hit_larx. Need to take the “bad dval” back and flush all younger ops)"
+    "BriefDescription": "Other LSU flushes including: Sync (sync ack from L2 caused search of LRQ for oldest snooped load, This will either signal a Precise Flush of the oldest snooped loa or a Flush Next PPC); Data Valid Flush Next (several cases of this, one example is store and reload are lined up such that a store-hit-reload scenario exists and the CDF has already launched and has gotten bad/stale data); Bad Data Valid Flush Next (might be a few cases of this, one example is a larxa (D$ hit) return data and dval but can't allocate to LMQ (LMQ full or other reason). Already gave dval but can't watch it for snoop_hit_larx. Need to take the 'bad dval' back and flush all younger ops)"
   },
   {
     "EventCode": "0x5094",
diff --git a/tools/perf/pmu-events/arch/powerpc/power9/pipeline.json b/tools/perf/pmu-events/arch/powerpc/power9/pipeline.json
index d0265f255de2..723bffa41c44 100644
--- a/tools/perf/pmu-events/arch/powerpc/power9/pipeline.json
+++ b/tools/perf/pmu-events/arch/powerpc/power9/pipeline.json
@@ -442,7 +442,7 @@
   {
     "EventCode": "0x4D052",
     "EventName": "PM_2FLOP_CMPL",
-    "BriefDescription": "DP vector version of fmul, fsub, fcmp, fsel, fabs, fnabs, fres ,fsqrte, fneg "
+    "BriefDescription": "DP vector version of fmul, fsub, fcmp, fsel, fabs, fnabs, fres ,fsqrte, fneg"
   },
   {
     "EventCode": "0x1F142",
diff --git a/tools/perf/pmu-events/arch/s390/cf_z16/extended.json b/tools/perf/pmu-events/arch/s390/cf_z16/extended.json
index c306190fc06f..c2b10ec1c6e0 100644
--- a/tools/perf/pmu-events/arch/s390/cf_z16/extended.json
+++ b/tools/perf/pmu-events/arch/s390/cf_z16/extended.json
@@ -95,28 +95,28 @@
 		"EventCode": "145",
 		"EventName": "DCW_REQ",
 		"BriefDescription": "Directory Write Level 1 Data Cache from Cache",
-		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from the requestor’s Level-2 cache."
+		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from the requestors Level-2 cache."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "146",
 		"EventName": "DCW_REQ_IV",
 		"BriefDescription": "Directory Write Level 1 Data Cache from Cache with Intervention",
-		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from the requestor’s Level-2 cache with intervention."
+		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from the requestors Level-2 cache with intervention."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "147",
 		"EventName": "DCW_REQ_CHIP_HIT",
 		"BriefDescription": "Directory Write Level 1 Data Cache from Cache with Chip HP Hit",
-		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from the requestor’s Level-2 cache after using chip level horizontal persistence, Chip-HP hit."
+		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from the requestors Level-2 cache after using chip level horizontal persistence, Chip-HP hit."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "148",
 		"EventName": "DCW_REQ_DRAWER_HIT",
 		"BriefDescription": "Directory Write Level 1 Data Cache from Cache with Drawer HP Hit",
-		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from the requestor’s Level-2 cache after using drawer level horizontal persistence, Drawer-HP hit."
+		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from the requestors Level-2 cache after using drawer level horizontal persistence, Drawer-HP hit."
 	},
 	{
 		"Unit": "CPU-M-CF",
@@ -284,7 +284,7 @@
 		"EventCode": "172",
 		"EventName": "ICW_REQ_DRAWER_HIT",
 		"BriefDescription": "Directory Write Level 1 Instruction Cache from Cache with Drawer HP Hit",
-		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from the requestor’s Level-2 cache using drawer level horizontal persistence, Drawer-HP hit."
+		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from the requestors Level-2 cache using drawer level horizontal persistence, Drawer-HP hit."
 	},
 	{
 		"Unit": "CPU-M-CF",
diff --git a/tools/perf/scripts/Build b/tools/perf/scripts/Build
index 68d4b54574ad..7d8e2e57faac 100644
--- a/tools/perf/scripts/Build
+++ b/tools/perf/scripts/Build
@@ -1,2 +1,4 @@
-perf-$(CONFIG_LIBPERL)   += perl/Perf-Trace-Util/
+ifeq ($(CONFIG_LIBTRACEEVENT),y)
+  perf-$(CONFIG_LIBPERL)   += perl/Perf-Trace-Util/
+endif
 perf-$(CONFIG_LIBPYTHON) += python/Perf-Trace-Util/
diff --git a/tools/perf/scripts/python/Perf-Trace-Util/Build b/tools/perf/scripts/python/Perf-Trace-Util/Build
index d5fed4e42617..7d0e33ce6aba 100644
--- a/tools/perf/scripts/python/Perf-Trace-Util/Build
+++ b/tools/perf/scripts/python/Perf-Trace-Util/Build
@@ -1,3 +1,3 @@
-perf-$(CONFIG_LIBTRACEEVENT) += Context.o
+perf-y += Context.o
 
 CFLAGS_Context.o += $(PYTHON_EMBED_CCOPTS) -Wno-redundant-decls -Wno-strict-prototypes -Wno-unused-parameter -Wno-nested-externs
diff --git a/tools/perf/scripts/python/Perf-Trace-Util/Context.c b/tools/perf/scripts/python/Perf-Trace-Util/Context.c
index 895f5fc23965..b0d449f41650 100644
--- a/tools/perf/scripts/python/Perf-Trace-Util/Context.c
+++ b/tools/perf/scripts/python/Perf-Trace-Util/Context.c
@@ -59,6 +59,7 @@ static struct scripting_context *get_scripting_context(PyObject *args)
 	return get_args(args, "context", NULL);
 }
 
+#ifdef HAVE_LIBTRACEEVENT
 static PyObject *perf_trace_context_common_pc(PyObject *obj, PyObject *args)
 {
 	struct scripting_context *c = get_scripting_context(args);
@@ -90,6 +91,7 @@ static PyObject *perf_trace_context_common_lock_depth(PyObject *obj,
 
 	return Py_BuildValue("i", common_lock_depth(c));
 }
+#endif
 
 static PyObject *perf_sample_insn(PyObject *obj, PyObject *args)
 {
@@ -178,12 +180,14 @@ static PyObject *perf_sample_srccode(PyObject *obj, PyObject *args)
 }
 
 static PyMethodDef ContextMethods[] = {
+#ifdef HAVE_LIBTRACEEVENT
 	{ "common_pc", perf_trace_context_common_pc, METH_VARARGS,
 	  "Get the common preempt count event field value."},
 	{ "common_flags", perf_trace_context_common_flags, METH_VARARGS,
 	  "Get the common flags event field value."},
 	{ "common_lock_depth", perf_trace_context_common_lock_depth,
 	  METH_VARARGS,	"Get the common lock depth event field value."},
+#endif
 	{ "perf_sample_insn", perf_sample_insn,
 	  METH_VARARGS,	"Get the machine code instruction."},
 	{ "perf_set_itrace_options", perf_set_itrace_options,
diff --git a/tools/perf/scripts/python/intel-pt-events.py b/tools/perf/scripts/python/intel-pt-events.py
index 08862a2582f4..1c76368f13c1 100644
--- a/tools/perf/scripts/python/intel-pt-events.py
+++ b/tools/perf/scripts/python/intel-pt-events.py
@@ -11,7 +11,7 @@
 # FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
 # more details.
 
-from __future__ import print_function
+from __future__ import division, print_function
 
 import io
 import os
diff --git a/tools/perf/tests/make b/tools/perf/tests/make
index 009d6efb673c..deb37fb982e9 100644
--- a/tools/perf/tests/make
+++ b/tools/perf/tests/make
@@ -62,10 +62,11 @@ lib = lib
 endif
 
 has = $(shell which $1 2>/dev/null)
+python_perf_so := $(shell $(MAKE) python_perf_target|grep "Target is:"|awk '{print $$3}')
 
 # standard single make variable specified
 make_clean_all      := clean all
-make_python_perf_so := python/perf.so
+make_python_perf_so := $(python_perf_so)
 make_debug          := DEBUG=1
 make_no_libperl     := NO_LIBPERL=1
 make_no_libpython   := NO_LIBPYTHON=1
@@ -204,7 +205,7 @@ test_make_doc    := $(test_ok)
 test_make_help_O := $(test_ok)
 test_make_doc_O  := $(test_ok)
 
-test_make_python_perf_so := test -f $(PERF_O)/python/perf.so
+test_make_python_perf_so := test -f $(PERF_O)/$(python_perf_so)
 
 test_make_perf_o           := test -f $(PERF_O)/perf.o
 test_make_util_map_o       := test -f $(PERF_O)/util/map.o
diff --git a/tools/perf/tests/shell/record_offcpu.sh b/tools/perf/tests/shell/record_offcpu.sh
index e01973d4e0fb..f062ae9a95e1 100755
--- a/tools/perf/tests/shell/record_offcpu.sh
+++ b/tools/perf/tests/shell/record_offcpu.sh
@@ -65,7 +65,7 @@ test_offcpu_child() {
 
   # perf bench sched messaging creates 400 processes
   if ! perf record --off-cpu -e dummy -o ${perfdata} -- \
-    perf bench sched messaging -g 10 > /dev/null 2&>1
+    perf bench sched messaging -g 10 > /dev/null 2>&1
   then
     echo "Child task off-cpu test [Failed record]"
     err=1
diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 79b9498886a2..fa8759739878 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -78,7 +78,7 @@ perf-y += pmu-bison.o
 perf-y += pmu-hybrid.o
 perf-y += svghelper.o
 perf-$(CONFIG_LIBTRACEEVENT) += trace-event-info.o
-perf-$(CONFIG_LIBTRACEEVENT) += trace-event-scripting.o
+perf-y += trace-event-scripting.o
 perf-$(CONFIG_LIBTRACEEVENT) += trace-event.o
 perf-$(CONFIG_LIBTRACEEVENT) += trace-event-parse.o
 perf-$(CONFIG_LIBTRACEEVENT) += trace-event-read.o
diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 33303d03c2fa..2f327986090e 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -2488,26 +2488,29 @@ static int cs_etm__process_auxtrace_event(struct perf_session *session,
 	return 0;
 }
 
-static bool cs_etm__is_timeless_decoding(struct cs_etm_auxtrace *etm)
+static int cs_etm__setup_timeless_decoding(struct cs_etm_auxtrace *etm)
 {
 	struct evsel *evsel;
 	struct evlist *evlist = etm->session->evlist;
-	bool timeless_decoding = true;
 
 	/* Override timeless mode with user input from --itrace=Z */
-	if (etm->synth_opts.timeless_decoding)
-		return true;
+	if (etm->synth_opts.timeless_decoding) {
+		etm->timeless_decoding = true;
+		return 0;
+	}
 
 	/*
-	 * Circle through the list of event and complain if we find one
-	 * with the time bit set.
+	 * Find the cs_etm evsel and look at what its timestamp setting was
 	 */
-	evlist__for_each_entry(evlist, evsel) {
-		if ((evsel->core.attr.sample_type & PERF_SAMPLE_TIME))
-			timeless_decoding = false;
-	}
+	evlist__for_each_entry(evlist, evsel)
+		if (cs_etm__evsel_is_auxtrace(etm->session, evsel)) {
+			etm->timeless_decoding =
+				!(evsel->core.attr.config & BIT(ETM_OPT_TS));
+			return 0;
+		}
 
-	return timeless_decoding;
+	pr_err("CS ETM: Couldn't find ETM evsel\n");
+	return -EINVAL;
 }
 
 /*
@@ -2884,7 +2887,6 @@ int cs_etm__process_auxtrace_info_full(union perf_event *event,
 	etm->snapshot_mode = (ptr[CS_ETM_SNAPSHOT] != 0);
 	etm->metadata = metadata;
 	etm->auxtrace_type = auxtrace_info->type;
-	etm->timeless_decoding = cs_etm__is_timeless_decoding(etm);
 
 	etm->auxtrace.process_event = cs_etm__process_event;
 	etm->auxtrace.process_auxtrace_event = cs_etm__process_auxtrace_event;
@@ -2894,6 +2896,10 @@ int cs_etm__process_auxtrace_info_full(union perf_event *event,
 	etm->auxtrace.evsel_is_auxtrace = cs_etm__evsel_is_auxtrace;
 	session->auxtrace = &etm->auxtrace;
 
+	err = cs_etm__setup_timeless_decoding(etm);
+	if (err)
+		return err;
+
 	etm->unknown_thread = thread__new(999999999, 999999999);
 	if (!etm->unknown_thread) {
 		err = -ENOMEM;
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index d572be41b960..2899c97d997c 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -269,6 +269,11 @@ static inline bool evsel__is_bpf(struct evsel *evsel)
 	return evsel->bpf_counter_ops != NULL;
 }
 
+static inline bool evsel__is_bperf(struct evsel *evsel)
+{
+	return evsel->bpf_counter_ops != NULL && list_empty(&evsel->bpf_counter_list);
+}
+
 #define EVSEL__MAX_ALIASES 8
 
 extern const char *const evsel__hw_cache[PERF_COUNT_HW_CACHE_MAX][EVSEL__MAX_ALIASES];
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 2bdeb89352e7..be49be366c05 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1833,7 +1833,7 @@ static int perf_pmu__new_caps(struct list_head *list, char *name, char *value)
 	return 0;
 
 free_name:
-	zfree(caps->name);
+	zfree(&caps->name);
 free_caps:
 	free(caps);
 
diff --git a/tools/perf/util/scripting-engines/Build b/tools/perf/util/scripting-engines/Build
index 2c96aa3cc1ec..c220fec97032 100644
--- a/tools/perf/util/scripting-engines/Build
+++ b/tools/perf/util/scripting-engines/Build
@@ -1,7 +1,7 @@
 ifeq ($(CONFIG_LIBTRACEEVENT),y)
   perf-$(CONFIG_LIBPERL)   += trace-event-perl.o
-  perf-$(CONFIG_LIBPYTHON) += trace-event-python.o
 endif
+perf-$(CONFIG_LIBPYTHON) += trace-event-python.o
 
 CFLAGS_trace-event-perl.o += $(PERL_EMBED_CCOPTS) -Wno-redundant-decls -Wno-strict-prototypes -Wno-unused-parameter -Wno-shadow -Wno-nested-externs -Wno-undef -Wno-switch-default -Wno-bad-function-cast -Wno-declaration-after-statement -Wno-switch-enum
 
diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
index e930f5f1f36d..53c32b75c0ca 100644
--- a/tools/perf/util/scripting-engines/trace-event-python.c
+++ b/tools/perf/util/scripting-engines/trace-event-python.c
@@ -30,7 +30,9 @@
 #include <linux/bitmap.h>
 #include <linux/compiler.h>
 #include <linux/time64.h>
+#ifdef HAVE_LIBTRACEEVENT
 #include <traceevent/event-parse.h>
+#endif
 
 #include "../build-id.h"
 #include "../counts.h"
@@ -87,18 +89,21 @@ PyMODINIT_FUNC initperf_trace_context(void);
 PyMODINIT_FUNC PyInit_perf_trace_context(void);
 #endif
 
+#ifdef HAVE_LIBTRACEEVENT
 #define TRACE_EVENT_TYPE_MAX				\
 	((1 << (sizeof(unsigned short) * 8)) - 1)
 
 static DECLARE_BITMAP(events_defined, TRACE_EVENT_TYPE_MAX);
 
-#define MAX_FIELDS	64
 #define N_COMMON_FIELDS	7
 
-extern struct scripting_context *scripting_context;
-
 static char *cur_field_name;
 static int zero_flag_atom;
+#endif
+
+#define MAX_FIELDS	64
+
+extern struct scripting_context *scripting_context;
 
 static PyObject *main_module, *main_dict;
 
@@ -153,6 +158,26 @@ static PyObject *get_handler(const char *handler_name)
 	return handler;
 }
 
+static void call_object(PyObject *handler, PyObject *args, const char *die_msg)
+{
+	PyObject *retval;
+
+	retval = PyObject_CallObject(handler, args);
+	if (retval == NULL)
+		handler_call_die(die_msg);
+	Py_DECREF(retval);
+}
+
+static void try_call_object(const char *handler_name, PyObject *args)
+{
+	PyObject *handler;
+
+	handler = get_handler(handler_name);
+	if (handler)
+		call_object(handler, args, handler_name);
+}
+
+#ifdef HAVE_LIBTRACEEVENT
 static int get_argument_count(PyObject *handler)
 {
 	int arg_count = 0;
@@ -181,25 +206,6 @@ static int get_argument_count(PyObject *handler)
 	return arg_count;
 }
 
-static void call_object(PyObject *handler, PyObject *args, const char *die_msg)
-{
-	PyObject *retval;
-
-	retval = PyObject_CallObject(handler, args);
-	if (retval == NULL)
-		handler_call_die(die_msg);
-	Py_DECREF(retval);
-}
-
-static void try_call_object(const char *handler_name, PyObject *args)
-{
-	PyObject *handler;
-
-	handler = get_handler(handler_name);
-	if (handler)
-		call_object(handler, args, handler_name);
-}
-
 static void define_value(enum tep_print_arg_type field_type,
 			 const char *ev_name,
 			 const char *field_name,
@@ -379,6 +385,7 @@ static PyObject *get_field_numeric_entry(struct tep_event *event,
 		obj = list;
 	return obj;
 }
+#endif
 
 static const char *get_dsoname(struct map *map)
 {
@@ -906,6 +913,7 @@ static PyObject *get_perf_sample_dict(struct perf_sample *sample,
 	return dict;
 }
 
+#ifdef HAVE_LIBTRACEEVENT
 static void python_process_tracepoint(struct perf_sample *sample,
 				      struct evsel *evsel,
 				      struct addr_location *al,
@@ -1037,6 +1045,16 @@ static void python_process_tracepoint(struct perf_sample *sample,
 
 	Py_DECREF(t);
 }
+#else
+static void python_process_tracepoint(struct perf_sample *sample __maybe_unused,
+				      struct evsel *evsel __maybe_unused,
+				      struct addr_location *al __maybe_unused,
+				      struct addr_location *addr_al __maybe_unused)
+{
+	fprintf(stderr, "Tracepoint events are not supported because "
+			"perf is not linked with libtraceevent.\n");
+}
+#endif
 
 static PyObject *tuple_new(unsigned int sz)
 {
@@ -1967,6 +1985,7 @@ static int python_stop_script(void)
 	return 0;
 }
 
+#ifdef HAVE_LIBTRACEEVENT
 static int python_generate_script(struct tep_handle *pevent, const char *outfile)
 {
 	int i, not_first, count, nr_events;
@@ -2157,6 +2176,18 @@ static int python_generate_script(struct tep_handle *pevent, const char *outfile
 
 	return 0;
 }
+#else
+static int python_generate_script(struct tep_handle *pevent __maybe_unused,
+				  const char *outfile __maybe_unused)
+{
+	fprintf(stderr, "Generating Python perf-script is not supported."
+		"  Install libtraceevent and rebuild perf to enable it.\n"
+		"For example:\n  # apt install libtraceevent-dev (ubuntu)"
+		"\n  # yum install libtraceevent-devel (Fedora)"
+		"\n  etc.\n");
+	return -1;
+}
+#endif
 
 struct scripting_ops python_scripting_ops = {
 	.name			= "Python",
diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index 37662cdec5ee..22808643ab72 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -603,12 +603,7 @@ static char *hist_entry__get_srcfile(struct hist_entry *e)
 static int64_t
 sort__srcfile_cmp(struct hist_entry *left, struct hist_entry *right)
 {
-	if (!left->srcfile)
-		left->srcfile = hist_entry__get_srcfile(left);
-	if (!right->srcfile)
-		right->srcfile = hist_entry__get_srcfile(right);
-
-	return strcmp(right->srcfile, left->srcfile);
+	return sort__srcline_cmp(left, right);
 }
 
 static int64_t
@@ -971,8 +966,7 @@ static int hist_entry__dso_to_filter(struct hist_entry *he, int type,
 static int64_t
 sort__sym_from_cmp(struct hist_entry *left, struct hist_entry *right)
 {
-	struct addr_map_symbol *from_l = &left->branch_info->from;
-	struct addr_map_symbol *from_r = &right->branch_info->from;
+	struct addr_map_symbol *from_l, *from_r;
 
 	if (!left->branch_info || !right->branch_info)
 		return cmp_null(left->branch_info, right->branch_info);
diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index 96767d1b3f1c..714fd9d0b51e 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -581,7 +581,7 @@ static int elf_read_build_id(Elf *elf, void *bf, size_t size)
 				size_t sz = min(size, descsz);
 				memcpy(bf, ptr, sz);
 				memset(bf + sz, 0, size - sz);
-				err = descsz;
+				err = sz;
 				break;
 			}
 		}
diff --git a/tools/perf/util/trace-event-scripting.c b/tools/perf/util/trace-event-scripting.c
index 56175c53f9af..bd0000300c77 100644
--- a/tools/perf/util/trace-event-scripting.c
+++ b/tools/perf/util/trace-event-scripting.c
@@ -9,7 +9,9 @@
 #include <stdlib.h>
 #include <string.h>
 #include <errno.h>
+#ifdef HAVE_LIBTRACEEVENT
 #include <traceevent/event-parse.h>
+#endif
 
 #include "debug.h"
 #include "trace-event.h"
@@ -27,10 +29,11 @@ void scripting_context__update(struct scripting_context *c,
 			       struct addr_location *addr_al)
 {
 	c->event_data = sample->raw_data;
+	c->pevent = NULL;
+#ifdef HAVE_LIBTRACEEVENT
 	if (evsel->tp_format)
 		c->pevent = evsel->tp_format->tep;
-	else
-		c->pevent = NULL;
+#endif
 	c->event = event;
 	c->sample = sample;
 	c->evsel = evsel;
@@ -122,6 +125,7 @@ void setup_python_scripting(void)
 }
 #endif
 
+#ifdef HAVE_LIBTRACEEVENT
 static void print_perl_unsupported_msg(void)
 {
 	fprintf(stderr, "Perl scripting not supported."
@@ -186,3 +190,4 @@ void setup_perl_scripting(void)
 	register_perl_scripting(&perl_scripting_ops);
 }
 #endif
+#endif
diff --git a/tools/perf/util/tracepoint.c b/tools/perf/util/tracepoint.c
index 89ef56c43311..92dd8b455b90 100644
--- a/tools/perf/util/tracepoint.c
+++ b/tools/perf/util/tracepoint.c
@@ -50,6 +50,7 @@ int is_valid_tracepoint(const char *event_string)
 				 sys_dirent->d_name, evt_dirent->d_name);
 			if (!strcmp(evt_path, event_string)) {
 				closedir(evt_dir);
+				put_events_file(dir_path);
 				closedir(sys_dir);
 				return 1;
 			}
diff --git a/tools/testing/selftests/net/srv6_end_dt46_l3vpn_test.sh b/tools/testing/selftests/net/srv6_end_dt46_l3vpn_test.sh
index aebaab8ce44c..441eededa031 100755
--- a/tools/testing/selftests/net/srv6_end_dt46_l3vpn_test.sh
+++ b/tools/testing/selftests/net/srv6_end_dt46_l3vpn_test.sh
@@ -292,6 +292,11 @@ setup_hs()
 	ip netns exec ${hsname} sysctl -wq net.ipv6.conf.all.accept_dad=0
 	ip netns exec ${hsname} sysctl -wq net.ipv6.conf.default.accept_dad=0
 
+	# disable the rp_filter otherwise the kernel gets confused about how
+	# to route decap ipv4 packets.
+	ip netns exec ${rtname} sysctl -wq net.ipv4.conf.all.rp_filter=0
+	ip netns exec ${rtname} sysctl -wq net.ipv4.conf.default.rp_filter=0
+
 	ip -netns ${hsname} link add veth0 type veth peer name ${rtveth}
 	ip -netns ${hsname} link set ${rtveth} netns ${rtname}
 	ip -netns ${hsname} addr add ${IPv6_HS_NETWORK}::${hs}/64 dev veth0 nodad
@@ -316,11 +321,6 @@ setup_hs()
 	ip netns exec ${rtname} sysctl -wq net.ipv6.conf.${rtveth}.proxy_ndp=1
 	ip netns exec ${rtname} sysctl -wq net.ipv4.conf.${rtveth}.proxy_arp=1
 
-	# disable the rp_filter otherwise the kernel gets confused about how
-	# to route decap ipv4 packets.
-	ip netns exec ${rtname} sysctl -wq net.ipv4.conf.all.rp_filter=0
-	ip netns exec ${rtname} sysctl -wq net.ipv4.conf.${rtveth}.rp_filter=0
-
 	ip netns exec ${rtname} sh -c "echo 1 > /proc/sys/net/vrf/strict_mode"
 }
 
diff --git a/tools/testing/selftests/netfilter/Makefile b/tools/testing/selftests/netfilter/Makefile
index 4504ee07be08..3686bfa6c58d 100644
--- a/tools/testing/selftests/netfilter/Makefile
+++ b/tools/testing/selftests/netfilter/Makefile
@@ -8,8 +8,11 @@ TEST_PROGS := nft_trans_stress.sh nft_fib.sh nft_nat.sh bridge_brouter.sh \
 	ipip-conntrack-mtu.sh conntrack_tcp_unreplied.sh \
 	conntrack_vrf.sh nft_synproxy.sh rpath.sh
 
-CFLAGS += $(shell pkg-config --cflags libmnl 2>/dev/null || echo "-I/usr/include/libmnl")
-LDLIBS = -lmnl
+HOSTPKG_CONFIG := pkg-config
+
+CFLAGS += $(shell $(HOSTPKG_CONFIG) --cflags libmnl 2>/dev/null)
+LDLIBS += $(shell $(HOSTPKG_CONFIG) --libs libmnl 2>/dev/null || echo -lmnl)
+
 TEST_GEN_FILES =  nf-queue connect_close
 
 include ../lib.mk
