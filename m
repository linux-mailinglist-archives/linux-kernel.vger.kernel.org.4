Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09A026BDD93
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 01:26:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbjCQA0m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 20:26:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjCQA0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 20:26:41 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC06576160;
        Thu, 16 Mar 2023 17:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=KyE6bGmufLuW1NevJVVogw+zL3sQkacM1yXKg7U2wAM=; b=s7AuvQEGFv7LnIfqxnMbweIPN2
        YkwOuD41BrNYX/yH3grC8NW9Er2NzkgogsC+vV3y3jaLn3ClS5+EuwQ+UIv8ZjI69nffac2hq67Aj
        TkH2zHMrm8ck0Ok3eWEfKAlw1jLzHmkrBrysnfk1kvV8pHdTectXhDPxsUFe/4X0O7/miB2cxO+aN
        Hvu+Z0zHxxE6gorp4PqD31p7XCBa9hcI4XpFTD0sezhlYUQOPjWJbMH2B9ZhG76jbCtQn/KYBmiEM
        fn9yvPdPY8MJM+w8vYaTP+sl/BRMyPvauK60dAOqTW+T7FXEgyDwXnv6L180tGb24yyyHB6bUw4Rf
        BCylamDQ==;
Received: from [2601:1c2:980:9ec0::21b4] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pcxva-000RQL-1a;
        Fri, 17 Mar 2023 00:26:38 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: [PATCH] Documentation: kernel-parameters: sort all "no..." parameters
Date:   Thu, 16 Mar 2023 17:26:35 -0700
Message-Id: <20230317002635.16540-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sort all of the "no..." kernel parameters into the correct order
as specified in kernel-parameters.rst: "into English Dictionary order
(defined as ignoring all punctuation and sorting digits before letters
in a case insensitive manner)".

No other changes here, just movement of lines.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
---
 Documentation/admin-guide/kernel-parameters.txt |  256 +++++++-------
 1 file changed, 128 insertions(+), 128 deletions(-)

diff -- a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -928,9 +928,6 @@
 
 	debug_objects	[KNL] Enable object debugging
 
-	no_debug_objects
-			[KNL] Disable object debugging
-
 	debug_guardpage_minorder=
 			[KNL] When CONFIG_DEBUG_PAGEALLOC is set, this
 			parameter allows control of the order of pages that will
@@ -3592,7 +3589,21 @@
 	no5lvl		[X86-64] Disable 5-level paging mode. Forces
 			kernel to use 4-level paging instead.
 
-	nofsgsbase	[X86] Disables FSGSBASE instructions.
+	noaliencache	[MM, NUMA, SLAB] Disables the allocation of alien
+			caches in the slab allocator.  Saves per-node memory,
+			but will impact performance.
+
+	noalign		[KNL,ARM]
+
+	noaltinstr	[S390] Disables alternative instructions patching
+			(CPU alternatives feature).
+
+	noapic		[SMP,APIC] Tells the kernel to not make use of any
+			IOAPICs that may be present in the system.
+
+	noautogroup	Disable scheduler automatic task group creation.
+
+	nocache		[ARM]
 
 	no_console_suspend
 			[HW] Never suspend the console
@@ -3609,32 +3620,8 @@
 			/sys/module/printk/parameters/console_suspend) to
 			turn on/off it dynamically.
 
-	novmcoredd	[KNL,KDUMP]
-			Disable device dump. Device dump allows drivers to
-			append dump data to vmcore so you can collect driver
-			specified debug info.  Drivers can append the data
-			without any limit and this data is stored in memory,
-			so this may cause significant memory stress.  Disabling
-			device dump can help save memory but the driver debug
-			data will be no longer available.  This parameter
-			is only available when CONFIG_PROC_VMCORE_DEVICE_DUMP
-			is set.
-
-	noaliencache	[MM, NUMA, SLAB] Disables the allocation of alien
-			caches in the slab allocator.  Saves per-node memory,
-			but will impact performance.
-
-	noalign		[KNL,ARM]
-
-	noaltinstr	[S390] Disables alternative instructions patching
-			(CPU alternatives feature).
-
-	noapic		[SMP,APIC] Tells the kernel to not make use of any
-			IOAPICs that may be present in the system.
-
-	noautogroup	Disable scheduler automatic task group creation.
-
-	nocache		[ARM]
+	no_debug_objects
+			[KNL] Disable object debugging
 
 	nodsp		[SH] Disable hardware DSP at boot time.
 
@@ -3644,14 +3631,6 @@
 
 	noexec		[IA-64]
 
-	nosmap		[PPC]
-			Disable SMAP (Supervisor Mode Access Prevention)
-			even if it is supported by processor.
-
-	nosmep		[PPC64s]
-			Disable SMEP (Supervisor Mode Execution Prevention)
-			even if it is supported by processor.
-
 	noexec32	[X86-64]
 			This affects only 32-bit executables.
 			noexec32=on: enable non-executable mappings (default)
@@ -3659,74 +3638,18 @@
 			noexec32=off: disable non-executable mappings
 				read implies executable mappings
 
+	no_file_caps	Tells the kernel not to honor file capabilities.  The
+			only way then for a file to be executed with privilege
+			is to be setuid root or executed by root.
+
 	nofpu		[MIPS,SH] Disable hardware FPU at boot time.
 
+	nofsgsbase	[X86] Disables FSGSBASE instructions.
+
 	nofxsr		[BUGS=X86-32] Disables x86 floating point extended
 			register save and restore. The kernel will only save
 			legacy floating-point registers on task switch.
 
-	nohugeiomap	[KNL,X86,PPC,ARM64] Disable kernel huge I/O mappings.
-
-	nohugevmalloc	[KNL,X86,PPC,ARM64] Disable kernel huge vmalloc mappings.
-
-	nosmt		[KNL,S390] Disable symmetric multithreading (SMT).
-			Equivalent to smt=1.
-
-			[KNL,X86] Disable symmetric multithreading (SMT).
-			nosmt=force: Force disable SMT, cannot be undone
-				     via the sysfs control file.
-
-	nospectre_v1	[X86,PPC] Disable mitigations for Spectre Variant 1
-			(bounds check bypass). With this option data leaks are
-			possible in the system.
-
-	nospectre_v2	[X86,PPC_E500,ARM64] Disable all mitigations for
-			the Spectre variant 2 (indirect branch prediction)
-			vulnerability. System may allow data leaks with this
-			option.
-
-	nospectre_bhb	[ARM64] Disable all mitigations for Spectre-BHB (branch
-			history injection) vulnerability. System may allow data leaks
-			with this option.
-
-	nospec_store_bypass_disable
-			[HW] Disable all mitigations for the Speculative Store Bypass vulnerability
-
-	no_uaccess_flush
-	                [PPC] Don't flush the L1-D cache after accessing user data.
-
-	noxsave		[BUGS=X86] Disables x86 extended register state save
-			and restore using xsave. The kernel will fallback to
-			enabling legacy floating-point and sse state.
-
-	noxsaveopt	[X86] Disables xsaveopt used in saving x86 extended
-			register states. The kernel will fall back to use
-			xsave to save the states. By using this parameter,
-			performance of saving the states is degraded because
-			xsave doesn't support modified optimization while
-			xsaveopt supports it on xsaveopt enabled systems.
-
-	noxsaves	[X86] Disables xsaves and xrstors used in saving and
-			restoring x86 extended register state in compacted
-			form of xsave area. The kernel will fall back to use
-			xsaveopt and xrstor to save and restore the states
-			in standard form of xsave area. By using this
-			parameter, xsave area per process might occupy more
-			memory on xsaves enabled systems.
-
-	nohlt		[ARM,ARM64,MICROBLAZE,SH] Forces the kernel to busy wait
-			in do_idle() and not use the arch_cpu_idle()
-			implementation; requires CONFIG_GENERIC_IDLE_POLL_SETUP
-			to be effective. This is useful on platforms where the
-			sleep(SH) or wfi(ARM,ARM64) instructions do not work
-			correctly or when doing power measurements to evaluate
-			the impact of the sleep instructions. This is also
-			useful when using JTAG debugger.
-
-	no_file_caps	Tells the kernel not to honor file capabilities.  The
-			only way then for a file to be executed with privilege
-			is to be setuid root or executed by root.
-
 	nohalt		[IA-64] Tells the kernel not to use the power saving
 			function PAL_HALT_LIGHT when idle. This increases
 			power-consumption. On the positive side, it reduces
@@ -3750,6 +3673,19 @@
 
 	nohibernate	[HIBERNATION] Disable hibernation and resume.
 
+	nohlt		[ARM,ARM64,MICROBLAZE,SH] Forces the kernel to busy wait
+			in do_idle() and not use the arch_cpu_idle()
+			implementation; requires CONFIG_GENERIC_IDLE_POLL_SETUP
+			to be effective. This is useful on platforms where the
+			sleep(SH) or wfi(ARM,ARM64) instructions do not work
+			correctly or when doing power measurements to evaluate
+			the impact of the sleep instructions. This is also
+			useful when using JTAG debugger.
+
+	nohugeiomap	[KNL,X86,PPC,ARM64] Disable kernel huge I/O mappings.
+
+	nohugevmalloc	[KNL,X86,PPC,ARM64] Disable kernel huge vmalloc mappings.
+
 	nohz=		[KNL] Boottime enable/disable dynamic ticks
 			Valid arguments: on, off
 			Default: on
@@ -3767,16 +3703,6 @@
 			Note that this argument takes precedence over
 			the CONFIG_RCU_NOCB_CPU_DEFAULT_ALL option.
 
-	noiotrap	[SH] Disables trapped I/O port accesses.
-
-	noirqdebug	[X86-32] Disables the code which attempts to detect and
-			disable unhandled interrupt sources.
-
-	no_timer_check	[X86,APIC] Disables the code which tests for
-			broken timer IRQ sources.
-
-	noisapnp	[ISAPNP] Disables ISA PnP code.
-
 	noinitrd	[RAM] Tells the kernel not to load any configured
 			initial RAM disk.
 
@@ -3788,6 +3714,13 @@
 
 	noinvpcid	[X86] Disable the INVPCID cpu feature.
 
+	noiotrap	[SH] Disables trapped I/O port accesses.
+
+	noirqdebug	[X86-32] Disables the code which attempts to detect and
+			disable unhandled interrupt sources.
+
+	noisapnp	[ISAPNP] Disables ISA PnP code.
+
 	nojitter	[IA-64] Disables jitter checking for ITC timers.
 
 	nokaslr		[KNL]
@@ -3795,18 +3728,10 @@
 			kernel and module base offset ASLR (Address Space
 			Layout Randomization).
 
-	no-kvmclock	[X86,KVM] Disable paravirtualized KVM clock driver
-
 	no-kvmapf	[X86,KVM] Disable paravirtualized asynchronous page
 			fault handling.
 
-	no-vmw-sched-clock
-			[X86,PV_OPS] Disable paravirtualized VMware scheduler
-			clock and use the default one.
-
-	no-steal-acc	[X86,PV_OPS,ARM64,PPC/PSERIES] Disable paravirtualized
-			steal time accounting. steal time is computed, but
-			won't influence scheduler behaviour
+	no-kvmclock	[X86,KVM] Disable paravirtualized KVM clock driver
 
 	nolapic		[X86-32,APIC] Do not enable or use the local APIC.
 
@@ -3819,10 +3744,6 @@
 	nomfgpt		[X86-32] Disable Multi-Function General Purpose
 			Timer usage (for AMD Geode machines).
 
-	nonmi_ipi	[X86] Disable using NMI IPIs during panic/reboot to
-			shutdown the other cpus.  Instead use the REBOOT_VECTOR
-			irq.
-
 	nomodeset	Disable kernel modesetting. Most systems' firmware
 			sets up a display mode and provides framebuffer memory
 			for output. With nomodeset, DRM and fbdev drivers will
@@ -3835,6 +3756,10 @@
 
 	nomodule	Disable module load
 
+	nonmi_ipi	[X86] Disable using NMI IPIs during panic/reboot to
+			shutdown the other cpus.  Instead use the REBOOT_VECTOR
+			irq.
+
 	nopat		[X86] Disable PAT (page attribute table extension of
 			pagetables) support.
 
@@ -3843,6 +3768,9 @@
 	nopku		[X86] Disable Memory Protection Keys CPU feature found
 			in some Intel CPUs.
 
+	nopti		[X86-64]
+			Equivalent to pti=off
+
 	nopv=		[X86,XEN,KVM,HYPER_V,VMWARE]
 			Disables the PV optimizations forcing the guest to run
 			as generic guest with no PV drivers. Currently support
@@ -3862,21 +3790,77 @@
 	noresume	[SWSUSP] Disables resume and restores original swap
 			space.
 
+	nosbagart	[IA-64]
+
 	no-scroll	[VGA] Disables scrollback.
 			This is required for the Braillex ib80-piezo Braille
 			reader made by F.H. Papenmeier (Germany).
 
-	nosbagart	[IA-64]
-
 	nosgx		[X86-64,SGX] Disables Intel SGX kernel support.
 
+	nosmap		[PPC]
+			Disable SMAP (Supervisor Mode Access Prevention)
+			even if it is supported by processor.
+
+	nosmep		[PPC64s]
+			Disable SMEP (Supervisor Mode Execution Prevention)
+			even if it is supported by processor.
+
 	nosmp		[SMP] Tells an SMP kernel to act as a UP kernel,
 			and disable the IO APIC.  legacy for "maxcpus=0".
 
+	nosmt		[KNL,S390] Disable symmetric multithreading (SMT).
+			Equivalent to smt=1.
+
+			[KNL,X86] Disable symmetric multithreading (SMT).
+			nosmt=force: Force disable SMT, cannot be undone
+				     via the sysfs control file.
+
 	nosoftlockup	[KNL] Disable the soft-lockup detector.
 
+	nospec_store_bypass_disable
+			[HW] Disable all mitigations for the Speculative Store Bypass vulnerability
+
+	nospectre_bhb	[ARM64] Disable all mitigations for Spectre-BHB (branch
+			history injection) vulnerability. System may allow data leaks
+			with this option.
+
+	nospectre_v1	[X86,PPC] Disable mitigations for Spectre Variant 1
+			(bounds check bypass). With this option data leaks are
+			possible in the system.
+
+	nospectre_v2	[X86,PPC_E500,ARM64] Disable all mitigations for
+			the Spectre variant 2 (indirect branch prediction)
+			vulnerability. System may allow data leaks with this
+			option.
+
+	no-steal-acc	[X86,PV_OPS,ARM64,PPC/PSERIES] Disable paravirtualized
+			steal time accounting. steal time is computed, but
+			won't influence scheduler behaviour
+
 	nosync		[HW,M68K] Disables sync negotiation for all devices.
 
+	no_timer_check	[X86,APIC] Disables the code which tests for
+			broken timer IRQ sources.
+
+	no_uaccess_flush
+	                [PPC] Don't flush the L1-D cache after accessing user data.
+
+	novmcoredd	[KNL,KDUMP]
+			Disable device dump. Device dump allows drivers to
+			append dump data to vmcore so you can collect driver
+			specified debug info.  Drivers can append the data
+			without any limit and this data is stored in memory,
+			so this may cause significant memory stress.  Disabling
+			device dump can help save memory but the driver debug
+			data will be no longer available.  This parameter
+			is only available when CONFIG_PROC_VMCORE_DEVICE_DUMP
+			is set.
+
+	no-vmw-sched-clock
+			[X86,PV_OPS] Disable paravirtualized VMware scheduler
+			clock and use the default one.
+
 	nowatchdog	[KNL] Disable both lockup detectors, i.e.
 			soft-lockup and NMI watchdog (hard-lockup).
 
@@ -3888,6 +3872,25 @@
 			LEGACY_XAPIC_DISABLED bit set in the
 			IA32_XAPIC_DISABLE_STATUS MSR.
 
+	noxsave		[BUGS=X86] Disables x86 extended register state save
+			and restore using xsave. The kernel will fallback to
+			enabling legacy floating-point and sse state.
+
+	noxsaveopt	[X86] Disables xsaveopt used in saving x86 extended
+			register states. The kernel will fall back to use
+			xsave to save the states. By using this parameter,
+			performance of saving the states is degraded because
+			xsave doesn't support modified optimization while
+			xsaveopt supports it on xsaveopt enabled systems.
+
+	noxsaves	[X86] Disables xsaves and xrstors used in saving and
+			restoring x86 extended register state in compacted
+			form of xsave area. The kernel will fall back to use
+			xsaveopt and xrstor to save and restore the states
+			in standard form of xsave area. By using this
+			parameter, xsave area per process might occupy more
+			memory on xsaves enabled systems.
+
 	nps_mtm_hs_ctr=	[KNL,ARC]
 			This parameter sets the maximum duration, in
 			cycles, each HW thread of the CTOP can run
@@ -4595,9 +4598,6 @@
 
 			Not specifying this option is equivalent to pti=auto.
 
-	nopti		[X86-64]
-			Equivalent to pti=off
-
 	pty.legacy_count=
 			[KNL] Number of legacy pty's. Overwrites compiled-in
 			default number.
