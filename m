Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDFBD6F2BA3
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 01:41:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232102AbjD3Xlj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Apr 2023 19:41:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232080AbjD3Xlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Apr 2023 19:41:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95B0AE7C;
        Sun, 30 Apr 2023 16:41:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1D752615CC;
        Sun, 30 Apr 2023 23:41:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2202FC433D2;
        Sun, 30 Apr 2023 23:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1682898091;
        bh=bOfQ1dF0IDCUB7cotjP37Jxfou76XWaedc5dVGe4jCA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J99BkvpO04RUIBHkhTeuBO5ujWoqofijmScFNwQx4+q4AlqbKkAwHwX15i3eNFwMR
         4OiEbY4o4sfDE/3ydzBiyDOu03e4To8BbKB994PytrbMyj3kwwkXH1LAB446KM3iEe
         asJ9O6WHrh/PR8BqE7Mm6lQx586tpUmuD6pHF7k4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.2.14
Date:   Mon,  1 May 2023 08:41:21 +0900
Message-Id: <2023050120-cornbread-numbly-bb88@gregkh>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <2023050120-coma-rift-e24b@gregkh>
References: <2023050120-coma-rift-e24b@gregkh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

diff --git a/Documentation/riscv/vm-layout.rst b/Documentation/riscv/vm-layout.rst
index 3be44e74ec5d..5462c84f4723 100644
--- a/Documentation/riscv/vm-layout.rst
+++ b/Documentation/riscv/vm-layout.rst
@@ -47,7 +47,7 @@ RISC-V Linux Kernel SV39
                                                               | Kernel-space virtual memory, shared between all processes:
   ____________________________________________________________|___________________________________________________________
                     |            |                  |         |
-   ffffffc6fee00000 | -228    GB | ffffffc6feffffff |    2 MB | fixmap
+   ffffffc6fea00000 | -228    GB | ffffffc6feffffff |    6 MB | fixmap
    ffffffc6ff000000 | -228    GB | ffffffc6ffffffff |   16 MB | PCI io
    ffffffc700000000 | -228    GB | ffffffc7ffffffff |    4 GB | vmemmap
    ffffffc800000000 | -224    GB | ffffffd7ffffffff |   64 GB | vmalloc/ioremap space
@@ -83,7 +83,7 @@ RISC-V Linux Kernel SV48
                                                               | Kernel-space virtual memory, shared between all processes:
   ____________________________________________________________|___________________________________________________________
                     |            |                  |         |
-   ffff8d7ffee00000 |  -114.5 TB | ffff8d7ffeffffff |    2 MB | fixmap
+   ffff8d7ffea00000 |  -114.5 TB | ffff8d7ffeffffff |    6 MB | fixmap
    ffff8d7fff000000 |  -114.5 TB | ffff8d7fffffffff |   16 MB | PCI io
    ffff8d8000000000 |  -114.5 TB | ffff8f7fffffffff |    2 TB | vmemmap
    ffff8f8000000000 |  -112.5 TB | ffffaf7fffffffff |   32 TB | vmalloc/ioremap space
@@ -119,7 +119,7 @@ RISC-V Linux Kernel SV57
                                                               | Kernel-space virtual memory, shared between all processes:
   ____________________________________________________________|___________________________________________________________
                     |            |                  |         |
-   ff1bfffffee00000 | -57     PB | ff1bfffffeffffff |    2 MB | fixmap
+   ff1bfffffea00000 | -57     PB | ff1bfffffeffffff |    6 MB | fixmap
    ff1bffffff000000 | -57     PB | ff1bffffffffffff |   16 MB | PCI io
    ff1c000000000000 | -57     PB | ff1fffffffffffff |    1 PB | vmemmap
    ff20000000000000 | -56     PB | ff5fffffffffffff |   16 PB | vmalloc/ioremap space
diff --git a/Makefile b/Makefile
index f76a4a63aaf5..031d40ad0bd9 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 2
-SUBLEVEL = 13
+SUBLEVEL = 14
 EXTRAVERSION =
 NAME = Hurr durr I'ma ninja sloth
 
diff --git a/arch/riscv/include/asm/fixmap.h b/arch/riscv/include/asm/fixmap.h
index 5c3e7b97fcc6..0a55099bb734 100644
--- a/arch/riscv/include/asm/fixmap.h
+++ b/arch/riscv/include/asm/fixmap.h
@@ -22,6 +22,14 @@
  */
 enum fixed_addresses {
 	FIX_HOLE,
+	/*
+	 * The fdt fixmap mapping must be PMD aligned and will be mapped
+	 * using PMD entries in fixmap_pmd in 64-bit and a PGD entry in 32-bit.
+	 */
+	FIX_FDT_END,
+	FIX_FDT = FIX_FDT_END + FIX_FDT_SIZE / PAGE_SIZE - 1,
+
+	/* Below fixmaps will be mapped using fixmap_pte */
 	FIX_PTE,
 	FIX_PMD,
 	FIX_PUD,
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 6da0f3285dd2..f1ef0c3f905a 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -87,9 +87,13 @@
 
 #define FIXADDR_TOP      PCI_IO_START
 #ifdef CONFIG_64BIT
-#define FIXADDR_SIZE     PMD_SIZE
+#define MAX_FDT_SIZE	 PMD_SIZE
+#define FIX_FDT_SIZE	 (MAX_FDT_SIZE + SZ_2M)
+#define FIXADDR_SIZE     (PMD_SIZE + FIX_FDT_SIZE)
 #else
-#define FIXADDR_SIZE     PGDIR_SIZE
+#define MAX_FDT_SIZE	 PGDIR_SIZE
+#define FIX_FDT_SIZE	 MAX_FDT_SIZE
+#define FIXADDR_SIZE     (PGDIR_SIZE + FIX_FDT_SIZE)
 #endif
 #define FIXADDR_START    (FIXADDR_TOP - FIXADDR_SIZE)
 
diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
index 86acd690d529..2acf51c23567 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -278,12 +278,8 @@ void __init setup_arch(char **cmdline_p)
 #if IS_ENABLED(CONFIG_BUILTIN_DTB)
 	unflatten_and_copy_device_tree();
 #else
-	if (early_init_dt_verify(__va(XIP_FIXUP(dtb_early_pa))))
-		unflatten_device_tree();
-	else
-		pr_err("No DTB found in kernel mappings\n");
+	unflatten_device_tree();
 #endif
-	early_init_fdt_scan_reserved_mem();
 	misc_mem_init();
 
 	init_resources();
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 478d6763a01a..0f14f4a8d179 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -57,7 +57,6 @@ unsigned long empty_zero_page[PAGE_SIZE / sizeof(unsigned long)]
 EXPORT_SYMBOL(empty_zero_page);
 
 extern char _start[];
-#define DTB_EARLY_BASE_VA      PGDIR_SIZE
 void *_dtb_early_va __initdata;
 uintptr_t _dtb_early_pa __initdata;
 
@@ -236,31 +235,22 @@ static void __init setup_bootmem(void)
 	set_max_mapnr(max_low_pfn - ARCH_PFN_OFFSET);
 
 	reserve_initrd_mem();
+
+	/*
+	 * No allocation should be done before reserving the memory as defined
+	 * in the device tree, otherwise the allocation could end up in a
+	 * reserved region.
+	 */
+	early_init_fdt_scan_reserved_mem();
+
 	/*
 	 * If DTB is built in, no need to reserve its memblock.
 	 * Otherwise, do reserve it but avoid using
 	 * early_init_fdt_reserve_self() since __pa() does
 	 * not work for DTB pointers that are fixmap addresses
 	 */
-	if (!IS_ENABLED(CONFIG_BUILTIN_DTB)) {
-		/*
-		 * In case the DTB is not located in a memory region we won't
-		 * be able to locate it later on via the linear mapping and
-		 * get a segfault when accessing it via __va(dtb_early_pa).
-		 * To avoid this situation copy DTB to a memory region.
-		 * Note that memblock_phys_alloc will also reserve DTB region.
-		 */
-		if (!memblock_is_memory(dtb_early_pa)) {
-			size_t fdt_size = fdt_totalsize(dtb_early_va);
-			phys_addr_t new_dtb_early_pa = memblock_phys_alloc(fdt_size, PAGE_SIZE);
-			void *new_dtb_early_va = early_memremap(new_dtb_early_pa, fdt_size);
-
-			memcpy(new_dtb_early_va, dtb_early_va, fdt_size);
-			early_memunmap(new_dtb_early_va, fdt_size);
-			_dtb_early_pa = new_dtb_early_pa;
-		} else
-			memblock_reserve(dtb_early_pa, fdt_totalsize(dtb_early_va));
-	}
+	if (!IS_ENABLED(CONFIG_BUILTIN_DTB))
+		memblock_reserve(dtb_early_pa, fdt_totalsize(dtb_early_va));
 
 	dma_contiguous_reserve(dma32_phys_limit);
 	if (IS_ENABLED(CONFIG_64BIT))
@@ -279,9 +269,6 @@ pgd_t trampoline_pg_dir[PTRS_PER_PGD] __page_aligned_bss;
 static pte_t fixmap_pte[PTRS_PER_PTE] __page_aligned_bss;
 
 pgd_t early_pg_dir[PTRS_PER_PGD] __initdata __aligned(PAGE_SIZE);
-static p4d_t __maybe_unused early_dtb_p4d[PTRS_PER_P4D] __initdata __aligned(PAGE_SIZE);
-static pud_t __maybe_unused early_dtb_pud[PTRS_PER_PUD] __initdata __aligned(PAGE_SIZE);
-static pmd_t __maybe_unused early_dtb_pmd[PTRS_PER_PMD] __initdata __aligned(PAGE_SIZE);
 
 #ifdef CONFIG_XIP_KERNEL
 #define pt_ops			(*(struct pt_alloc_ops *)XIP_FIXUP(&pt_ops))
@@ -626,9 +613,6 @@ static void __init create_p4d_mapping(p4d_t *p4dp,
 #define trampoline_pgd_next	(pgtable_l5_enabled ?			\
 		(uintptr_t)trampoline_p4d : (pgtable_l4_enabled ?	\
 		(uintptr_t)trampoline_pud : (uintptr_t)trampoline_pmd))
-#define early_dtb_pgd_next	(pgtable_l5_enabled ?			\
-		(uintptr_t)early_dtb_p4d : (pgtable_l4_enabled ?	\
-		(uintptr_t)early_dtb_pud : (uintptr_t)early_dtb_pmd))
 #else
 #define pgd_next_t		pte_t
 #define alloc_pgd_next(__va)	pt_ops.alloc_pte(__va)
@@ -636,7 +620,6 @@ static void __init create_p4d_mapping(p4d_t *p4dp,
 #define create_pgd_next_mapping(__nextp, __va, __pa, __sz, __prot)	\
 	create_pte_mapping(__nextp, __va, __pa, __sz, __prot)
 #define fixmap_pgd_next		((uintptr_t)fixmap_pte)
-#define early_dtb_pgd_next	((uintptr_t)early_dtb_pmd)
 #define create_p4d_mapping(__pmdp, __va, __pa, __sz, __prot) do {} while(0)
 #define create_pud_mapping(__pmdp, __va, __pa, __sz, __prot) do {} while(0)
 #define create_pmd_mapping(__pmdp, __va, __pa, __sz, __prot) do {} while(0)
@@ -860,32 +843,28 @@ static void __init create_kernel_page_table(pgd_t *pgdir, bool early)
  * this means 2 PMD entries whereas for 32-bit kernel, this is only 1 PGDIR
  * entry.
  */
-static void __init create_fdt_early_page_table(pgd_t *pgdir, uintptr_t dtb_pa)
+static void __init create_fdt_early_page_table(pgd_t *pgdir,
+					       uintptr_t fix_fdt_va,
+					       uintptr_t dtb_pa)
 {
-#ifndef CONFIG_BUILTIN_DTB
 	uintptr_t pa = dtb_pa & ~(PMD_SIZE - 1);
 
-	create_pgd_mapping(early_pg_dir, DTB_EARLY_BASE_VA,
-			   IS_ENABLED(CONFIG_64BIT) ? early_dtb_pgd_next : pa,
-			   PGDIR_SIZE,
-			   IS_ENABLED(CONFIG_64BIT) ? PAGE_TABLE : PAGE_KERNEL);
-
-	if (pgtable_l5_enabled)
-		create_p4d_mapping(early_dtb_p4d, DTB_EARLY_BASE_VA,
-				   (uintptr_t)early_dtb_pud, P4D_SIZE, PAGE_TABLE);
-
-	if (pgtable_l4_enabled)
-		create_pud_mapping(early_dtb_pud, DTB_EARLY_BASE_VA,
-				   (uintptr_t)early_dtb_pmd, PUD_SIZE, PAGE_TABLE);
+#ifndef CONFIG_BUILTIN_DTB
+	/* Make sure the fdt fixmap address is always aligned on PMD size */
+	BUILD_BUG_ON(FIX_FDT % (PMD_SIZE / PAGE_SIZE));
 
-	if (IS_ENABLED(CONFIG_64BIT)) {
-		create_pmd_mapping(early_dtb_pmd, DTB_EARLY_BASE_VA,
+	/* In 32-bit only, the fdt lies in its own PGD */
+	if (!IS_ENABLED(CONFIG_64BIT)) {
+		create_pgd_mapping(early_pg_dir, fix_fdt_va,
+				   pa, MAX_FDT_SIZE, PAGE_KERNEL);
+	} else {
+		create_pmd_mapping(fixmap_pmd, fix_fdt_va,
 				   pa, PMD_SIZE, PAGE_KERNEL);
-		create_pmd_mapping(early_dtb_pmd, DTB_EARLY_BASE_VA + PMD_SIZE,
+		create_pmd_mapping(fixmap_pmd, fix_fdt_va + PMD_SIZE,
 				   pa + PMD_SIZE, PMD_SIZE, PAGE_KERNEL);
 	}
 
-	dtb_early_va = (void *)DTB_EARLY_BASE_VA + (dtb_pa & (PMD_SIZE - 1));
+	dtb_early_va = (void *)fix_fdt_va + (dtb_pa & (PMD_SIZE - 1));
 #else
 	/*
 	 * For 64-bit kernel, __va can't be used since it would return a linear
@@ -1055,7 +1034,8 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
 	create_kernel_page_table(early_pg_dir, true);
 
 	/* Setup early mapping for FDT early scan */
-	create_fdt_early_page_table(early_pg_dir, dtb_pa);
+	create_fdt_early_page_table(early_pg_dir,
+				    __fix_to_virt(FIX_FDT), dtb_pa);
 
 	/*
 	 * Bootime fixmap only can handle PMD_SIZE mapping. Thus, boot-ioremap
@@ -1097,6 +1077,16 @@ static void __init setup_vm_final(void)
 	u64 i;
 
 	/* Setup swapper PGD for fixmap */
+#if !defined(CONFIG_64BIT)
+	/*
+	 * In 32-bit, the device tree lies in a pgd entry, so it must be copied
+	 * directly in swapper_pg_dir in addition to the pgd entry that points
+	 * to fixmap_pte.
+	 */
+	unsigned long idx = pgd_index(__fix_to_virt(FIX_FDT));
+
+	set_pgd(&swapper_pg_dir[idx], early_pg_dir[idx]);
+#endif
 	create_pgd_mapping(swapper_pg_dir, FIXADDR_START,
 			   __pa_symbol(fixmap_pgd_next),
 			   PGDIR_SIZE, PAGE_TABLE);
diff --git a/arch/x86/Makefile.um b/arch/x86/Makefile.um
index b3c1ae084180..1aa64846e539 100644
--- a/arch/x86/Makefile.um
+++ b/arch/x86/Makefile.um
@@ -1,6 +1,17 @@
 # SPDX-License-Identifier: GPL-2.0
 core-y += arch/x86/crypto/
 
+#
+# Disable SSE and other FP/SIMD instructions to match normal x86
+# This is required to work around issues in older LLVM versions, but breaks
+# GCC versions < 11. See:
+# https://gcc.gnu.org/bugzilla/show_bug.cgi?id=99652
+#
+ifeq ($(CONFIG_CC_IS_CLANG),y)
+KBUILD_CFLAGS += -mno-sse -mno-mmx -mno-sse2 -mno-3dnow -mno-avx
+KBUILD_RUSTFLAGS += -Ctarget-feature=-sse,-sse2,-sse3,-ssse3,-sse4.1,-sse4.2,-avx,-avx2
+endif
+
 ifeq ($(CONFIG_X86_32),y)
 START := 0x8048000
 
diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 959fe018d0dd..488f07314db3 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -718,7 +718,12 @@ static int really_probe_debug(struct device *dev, struct device_driver *drv)
 	calltime = ktime_get();
 	ret = really_probe(dev, drv);
 	rettime = ktime_get();
-	pr_debug("probe of %s returned %d after %lld usecs\n",
+	/*
+	 * Don't change this to pr_debug() because that requires
+	 * CONFIG_DYNAMIC_DEBUG and we want a simple 'initcall_debug' on the
+	 * kernel commandline to print this all the time at the debug level.
+	 */
+	printk(KERN_DEBUG "probe of %s returned %d after %lld usecs\n",
 		 dev_name(dev), ret, ktime_us_delta(rettime, calltime));
 	return ret;
 }
diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
index 7c9175619a1d..e9c79f76f1b6 100644
--- a/drivers/gpio/gpiolib-acpi.c
+++ b/drivers/gpio/gpiolib-acpi.c
@@ -1627,6 +1627,19 @@ static const struct dmi_system_id gpiolib_acpi_quirks[] __initconst = {
 			.ignore_interrupt = "AMDI0030:00@18",
 		},
 	},
+	{
+		/*
+		 * Spurious wakeups from TP_ATTN# pin
+		 * Found in BIOS 1.7.8
+		 * https://gitlab.freedesktop.org/drm/amd/-/issues/1722#note_1720627
+		 */
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "NL5xNU"),
+		},
+		.driver_data = &(struct acpi_gpiolib_dmi_quirk) {
+			.ignore_wake = "ELAN0415:00@9",
+		},
+	},
 	{
 		/*
 		 * Spurious wakeups from TP_ATTN# pin
diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
index 0d0c26ebab90..ecccd0185019 100644
--- a/drivers/gpu/drm/drm_fb_helper.c
+++ b/drivers/gpu/drm/drm_fb_helper.c
@@ -1558,6 +1558,9 @@ int drm_fb_helper_check_var(struct fb_var_screeninfo *var,
 		return -EINVAL;
 	}
 
+	var->xres_virtual = fb->width;
+	var->yres_virtual = fb->height;
+
 	/*
 	 * Workaround for SDL 1.2, which is known to be setting all pixel format
 	 * fields values to zero in some cases. We treat this situation as a
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
index 65d4799a5658..ff710b0b5071 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
@@ -965,6 +965,12 @@ int brcmf_sdiod_probe(struct brcmf_sdio_dev *sdiodev)
 		.driver_data = BRCMF_FWVENDOR_ ## fw_vend \
 	}
 
+#define CYW_SDIO_DEVICE(dev_id, fw_vend) \
+	{ \
+		SDIO_DEVICE(SDIO_VENDOR_ID_CYPRESS, dev_id), \
+		.driver_data = BRCMF_FWVENDOR_ ## fw_vend \
+	}
+
 /* devices we support, null terminated */
 static const struct sdio_device_id brcmf_sdmmc_ids[] = {
 	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_43143, WCC),
@@ -979,6 +985,7 @@ static const struct sdio_device_id brcmf_sdmmc_ids[] = {
 	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_4335_4339, WCC),
 	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_4339, WCC),
 	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_43430, WCC),
+	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_43439, WCC),
 	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_4345, WCC),
 	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_43455, WCC),
 	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_4354, WCC),
@@ -986,9 +993,9 @@ static const struct sdio_device_id brcmf_sdmmc_ids[] = {
 	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_4359, WCC),
 	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_CYPRESS_4373, CYW),
 	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_CYPRESS_43012, CYW),
-	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_CYPRESS_43439, CYW),
 	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_CYPRESS_43752, CYW),
 	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_CYPRESS_89359, CYW),
+	CYW_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_CYPRESS_43439, CYW),
 	{ /* end: all zeroes */ }
 };
 MODULE_DEVICE_TABLE(sdio, brcmf_sdmmc_ids);
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index b115902eb475..b8c99bfce963 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -6164,6 +6164,11 @@ static s32 brcmf_get_assoc_ies(struct brcmf_cfg80211_info *cfg,
 		(struct brcmf_cfg80211_assoc_ielen_le *)cfg->extra_buf;
 	req_len = le32_to_cpu(assoc_info->req_len);
 	resp_len = le32_to_cpu(assoc_info->resp_len);
+	if (req_len > WL_EXTRA_BUF_MAX || resp_len > WL_EXTRA_BUF_MAX) {
+		bphy_err(drvr, "invalid lengths in assoc info: req %u resp %u\n",
+			 req_len, resp_len);
+		return -EINVAL;
+	}
 	if (req_len) {
 		err = brcmf_fil_iovar_data_get(ifp, "assoc_req_ies",
 					       cfg->extra_buf,
diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index f31cc3c76329..644a55447fd7 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -595,6 +595,11 @@ static void option_instat_callback(struct urb *urb);
 #define SIERRA_VENDOR_ID			0x1199
 #define SIERRA_PRODUCT_EM9191			0x90d3
 
+/* UNISOC (Spreadtrum) products */
+#define UNISOC_VENDOR_ID			0x1782
+/* TOZED LT70-C based on UNISOC SL8563 uses UNISOC's vendor ID */
+#define TOZED_PRODUCT_LT70C			0x4055
+
 /* Device flags */
 
 /* Highest interface number which can be used with NCTRL() and RSVD() */
@@ -2225,6 +2230,7 @@ static const struct usb_device_id option_ids[] = {
 	{ USB_DEVICE_AND_INTERFACE_INFO(OPPO_VENDOR_ID, OPPO_PRODUCT_R11, 0xff, 0xff, 0x30) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(SIERRA_VENDOR_ID, SIERRA_PRODUCT_EM9191, 0xff, 0xff, 0x30) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(SIERRA_VENDOR_ID, SIERRA_PRODUCT_EM9191, 0xff, 0, 0) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(UNISOC_VENDOR_ID, TOZED_PRODUCT_LT70C, 0xff, 0, 0) },
 	{ } /* Terminating entry */
 };
 MODULE_DEVICE_TABLE(usb, option_ids);
diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index d50182b6deec..614baded3963 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -1892,7 +1892,7 @@ static int get_cur_inode_state(struct send_ctx *sctx, u64 ino, u64 gen)
 	int left_ret;
 	int right_ret;
 	u64 left_gen;
-	u64 right_gen;
+	u64 right_gen = 0;
 	struct btrfs_inode_info info;
 
 	ret = get_inode_info(sctx->send_root, ino, &info);
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index fe652f8fc697..3f65e37dbd6a 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -2618,7 +2618,7 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 	struct block_device *bdev;
 	struct super_block *sb = fs_info->sb;
 	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
-	struct btrfs_fs_devices *seed_devices;
+	struct btrfs_fs_devices *seed_devices = NULL;
 	u64 orig_super_total_bytes;
 	u64 orig_super_num_devices;
 	int ret = 0;
diff --git a/include/linux/mmc/sdio_ids.h b/include/linux/mmc/sdio_ids.h
index 74f9d9a6d330..f0cf9c5d6502 100644
--- a/include/linux/mmc/sdio_ids.h
+++ b/include/linux/mmc/sdio_ids.h
@@ -74,10 +74,13 @@
 #define SDIO_DEVICE_ID_BROADCOM_43362		0xa962
 #define SDIO_DEVICE_ID_BROADCOM_43364		0xa9a4
 #define SDIO_DEVICE_ID_BROADCOM_43430		0xa9a6
-#define SDIO_DEVICE_ID_BROADCOM_CYPRESS_43439	0xa9af
+#define SDIO_DEVICE_ID_BROADCOM_43439		0xa9af
 #define SDIO_DEVICE_ID_BROADCOM_43455		0xa9bf
 #define SDIO_DEVICE_ID_BROADCOM_CYPRESS_43752	0xaae8
 
+#define SDIO_VENDOR_ID_CYPRESS			0x04b4
+#define SDIO_DEVICE_ID_BROADCOM_CYPRESS_43439	0xbd3d
+
 #define SDIO_VENDOR_ID_MARVELL			0x02df
 #define SDIO_DEVICE_ID_MARVELL_LIBERTAS		0x9103
 #define SDIO_DEVICE_ID_MARVELL_8688_WLAN	0x9104
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index cf34a961821a..522129193771 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3131,6 +3131,18 @@ need_offload_krc(struct kfree_rcu_cpu *krcp)
 	return !!krcp->head;
 }
 
+static bool
+need_wait_for_krwp_work(struct kfree_rcu_cpu_work *krwp)
+{
+	int i;
+
+	for (i = 0; i < FREE_N_CHANNELS; i++)
+		if (krwp->bkvhead_free[i])
+			return true;
+
+	return !!krwp->head_free;
+}
+
 static void
 schedule_delayed_monitor_work(struct kfree_rcu_cpu *krcp)
 {
@@ -3162,14 +3174,13 @@ static void kfree_rcu_monitor(struct work_struct *work)
 	for (i = 0; i < KFREE_N_BATCHES; i++) {
 		struct kfree_rcu_cpu_work *krwp = &(krcp->krw_arr[i]);
 
-		// Try to detach bkvhead or head and attach it over any
-		// available corresponding free channel. It can be that
-		// a previous RCU batch is in progress, it means that
-		// immediately to queue another one is not possible so
-		// in that case the monitor work is rearmed.
-		if ((krcp->bkvhead[0] && !krwp->bkvhead_free[0]) ||
-			(krcp->bkvhead[1] && !krwp->bkvhead_free[1]) ||
-				(krcp->head && !krwp->head_free)) {
+		// Try to detach bulk_head or head and attach it, only when
+		// all channels are free.  Any channel is not free means at krwp
+		// there is on-going rcu work to handle krwp's free business.
+		if (need_wait_for_krwp_work(krwp))
+			continue;
+
+		if (need_offload_krc(krcp)) {
 			// Channel 1 corresponds to the SLAB-pointer bulk path.
 			// Channel 2 corresponds to vmalloc-pointer bulk path.
 			for (j = 0; j < FREE_N_CHANNELS; j++) {
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index f940395667c8..e132f70a059e 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -784,70 +784,56 @@ static int vma_replace_policy(struct vm_area_struct *vma,
 	return err;
 }
 
-/* Step 2: apply policy to a range and do splits. */
-static int mbind_range(struct mm_struct *mm, unsigned long start,
-		       unsigned long end, struct mempolicy *new_pol)
+/* Split or merge the VMA (if required) and apply the new policy */
+static int mbind_range(struct vma_iterator *vmi, struct vm_area_struct *vma,
+		struct vm_area_struct **prev, unsigned long start,
+		unsigned long end, struct mempolicy *new_pol)
 {
-	MA_STATE(mas, &mm->mm_mt, start, start);
-	struct vm_area_struct *prev;
-	struct vm_area_struct *vma;
-	int err = 0;
+	struct vm_area_struct *merged;
+	unsigned long vmstart, vmend;
 	pgoff_t pgoff;
+	int err;
 
-	prev = mas_prev(&mas, 0);
-	if (unlikely(!prev))
-		mas_set(&mas, start);
+	vmend = min(end, vma->vm_end);
+	if (start > vma->vm_start) {
+		*prev = vma;
+		vmstart = start;
+	} else {
+		vmstart = vma->vm_start;
+	}
 
-	vma = mas_find(&mas, end - 1);
-	if (WARN_ON(!vma))
+	if (mpol_equal(vma_policy(vma), new_pol))
 		return 0;
 
-	if (start > vma->vm_start)
-		prev = vma;
-
-	for (; vma; vma = mas_next(&mas, end - 1)) {
-		unsigned long vmstart = max(start, vma->vm_start);
-		unsigned long vmend = min(end, vma->vm_end);
-
-		if (mpol_equal(vma_policy(vma), new_pol))
-			goto next;
-
-		pgoff = vma->vm_pgoff +
-			((vmstart - vma->vm_start) >> PAGE_SHIFT);
-		prev = vma_merge(mm, prev, vmstart, vmend, vma->vm_flags,
-				 vma->anon_vma, vma->vm_file, pgoff,
-				 new_pol, vma->vm_userfaultfd_ctx,
-				 anon_vma_name(vma));
-		if (prev) {
-			/* vma_merge() invalidated the mas */
-			mas_pause(&mas);
-			vma = prev;
-			goto replace;
-		}
-		if (vma->vm_start != vmstart) {
-			err = split_vma(vma->vm_mm, vma, vmstart, 1);
-			if (err)
-				goto out;
-			/* split_vma() invalidated the mas */
-			mas_pause(&mas);
-		}
-		if (vma->vm_end != vmend) {
-			err = split_vma(vma->vm_mm, vma, vmend, 0);
-			if (err)
-				goto out;
-			/* split_vma() invalidated the mas */
-			mas_pause(&mas);
-		}
-replace:
-		err = vma_replace_policy(vma, new_pol);
+	pgoff = vma->vm_pgoff + ((vmstart - vma->vm_start) >> PAGE_SHIFT);
+	merged = vma_merge(vma->vm_mm, *prev, vmstart, vmend, vma->vm_flags,
+			   vma->anon_vma, vma->vm_file, pgoff, new_pol,
+			   vma->vm_userfaultfd_ctx, anon_vma_name(vma));
+	if (merged) {
+		*prev = merged;
+		/* vma_merge() invalidated the mas */
+		mas_pause(&vmi->mas);
+		return vma_replace_policy(merged, new_pol);
+	}
+
+	if (vma->vm_start != vmstart) {
+		err = split_vma(vma->vm_mm, vma, vmstart, 1);
 		if (err)
-			goto out;
-next:
-		prev = vma;
+			return err;
+		/* split_vma() invalidated the mas */
+		mas_pause(&vmi->mas);
 	}
 
-out:
-	return err;
+	if (vma->vm_end != vmend) {
+		err = split_vma(vma->vm_mm, vma, vmend, 0);
+		if (err)
+			return err;
+		/* split_vma() invalidated the mas */
+		mas_pause(&vmi->mas);
+	}
+
+	*prev = vma;
+	return vma_replace_policy(vma, new_pol);
 }
 
 /* Set the process memory policy */
@@ -1259,6 +1245,8 @@ static long do_mbind(unsigned long start, unsigned long len,
 		     nodemask_t *nmask, unsigned long flags)
 {
 	struct mm_struct *mm = current->mm;
+	struct vm_area_struct *vma, *prev;
+	struct vma_iterator vmi;
 	struct mempolicy *new;
 	unsigned long end;
 	int err;
@@ -1328,7 +1316,13 @@ static long do_mbind(unsigned long start, unsigned long len,
 		goto up_out;
 	}
 
-	err = mbind_range(mm, start, end, new);
+	vma_iter_init(&vmi, mm, start);
+	prev = vma_prev(&vmi);
+	for_each_vma_range(vmi, vma, end) {
+		err = mbind_range(&vmi, vma, &prev, start, end, new);
+		if (err)
+			break;
+	}
 
 	if (!err) {
 		int nr_failed = 0;
@@ -1489,10 +1483,8 @@ SYSCALL_DEFINE4(set_mempolicy_home_node, unsigned long, start, unsigned long, le
 		unsigned long, home_node, unsigned long, flags)
 {
 	struct mm_struct *mm = current->mm;
-	struct vm_area_struct *vma;
+	struct vm_area_struct *vma, *prev;
 	struct mempolicy *new;
-	unsigned long vmstart;
-	unsigned long vmend;
 	unsigned long end;
 	int err = -ENOENT;
 	VMA_ITERATOR(vmi, mm, start);
@@ -1521,9 +1513,8 @@ SYSCALL_DEFINE4(set_mempolicy_home_node, unsigned long, start, unsigned long, le
 	if (end == start)
 		return 0;
 	mmap_write_lock(mm);
+	prev = vma_prev(&vmi);
 	for_each_vma_range(vmi, vma, end) {
-		vmstart = max(start, vma->vm_start);
-		vmend   = min(end, vma->vm_end);
 		new = mpol_dup(vma_policy(vma));
 		if (IS_ERR(new)) {
 			err = PTR_ERR(new);
@@ -1547,7 +1538,7 @@ SYSCALL_DEFINE4(set_mempolicy_home_node, unsigned long, start, unsigned long, le
 		}
 
 		new->home_node = home_node;
-		err = mbind_range(mm, vmstart, vmend, new);
+		err = mbind_range(&vmi, vma, &prev, start, end, new);
 		mpol_put(new);
 		if (err)
 			break;
diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index 06581223238c..f597fe0db9f8 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -1003,7 +1003,14 @@ static int hci_sock_ioctl(struct socket *sock, unsigned int cmd,
 	if (hci_sock_gen_cookie(sk)) {
 		struct sk_buff *skb;
 
-		if (capable(CAP_NET_ADMIN))
+		/* Perform careful checks before setting the HCI_SOCK_TRUSTED
+		 * flag. Make sure that not only the current task but also
+		 * the socket opener has the required capability, since
+		 * privileged programs can be tricked into making ioctl calls
+		 * on HCI sockets, and the socket should not be marked as
+		 * trusted simply because the ioctl caller is privileged.
+		 */
+		if (sk_capable(sk, CAP_NET_ADMIN))
 			hci_sock_set_flag(sk, HCI_SOCK_TRUSTED);
 
 		/* Send event to monitor */
