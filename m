Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 171FC641A3D
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Dec 2022 02:31:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbiLDBbB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Dec 2022 20:31:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiLDBbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Dec 2022 20:31:00 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 396981A065;
        Sat,  3 Dec 2022 17:30:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=f5BszEzuXRFPTLRULdjAwhxfF5sskkT10Q/DrW/LbMw=; b=tzchrICJeOk6XHbyGTwCjZ6KVM
        ZOuFhC+RIO5YWXl3/h63iSUqoHr53spU6G3ArMDKlXlP4bG+QGwmUvJy1AuNfGXSibIE6dZabt+qc
        61XlLsSLWtREjtaB1+x15sFPiRYK2u/+YS16OCq6bdQnCFXUdZgjVatvM29tixb1wxbQhBT6PQdnT
        sOeyuq2HVGfNa3OFz+4H0mPo3c2A+eD0JXyy0KVsIdF7Ps6ZlfAoo9M3PMInhwI5dud2aXPLPLucg
        dljV3y0/nWA7sqYmwHW9KR6bphFaqtCejN9yBvLEB6mMgk9zqkhP8TGnGiAJRlXHY9osE01JYZ102
        fXc+JPJA==;
Received: from [2601:1c2:d80:3110::a2e7] (helo=casper.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p1dqQ-001gys-3w; Sun, 04 Dec 2022 01:31:02 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: [PATCH] Documentation: admin: move OOO entries in kernel-parameters.txt
Date:   Sat,  3 Dec 2022 17:30:50 -0800
Message-Id: <20221204013050.11496-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the most blatant out-of-order entries in kernel-parameters.txt.

No changes other than modifying the order of the entries.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
---
Do not backport.

 Documentation/admin-guide/kernel-parameters.txt |  122 +++++++-------
 1 file changed, 61 insertions(+), 61 deletions(-)

diff -- a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -378,18 +378,16 @@
 	autoconf=	[IPV6]
 			See Documentation/networking/ipv6.rst.
 
-	show_lapic=	[APIC,X86] Advanced Programmable Interrupt Controller
-			Limit apic dumping. The parameter defines the maximal
-			number of local apics being dumped. Also it is possible
-			to set it to "all" by meaning -- no limit here.
-			Format: { 1 (default) | 2 | ... | all }.
-			The parameter valid if only apic=debug or
-			apic=verbose is specified.
-			Example: apic=debug show_lapic=all
-
 	apm=		[APM] Advanced Power Management
 			See header of arch/x86/kernel/apm_32.c.
 
+	apparmor=	[APPARMOR] Disable or enable AppArmor at boot time
+			Format: { "0" | "1" }
+			See security/apparmor/Kconfig help text
+			0 -- disable.
+			1 -- enable.
+			Default value is set via kernel config option.
+
 	arcrimi=	[HW,NET] ARCnet - "RIM I" (entirely mem-mapped) cards
 			Format: <io>,<irq>,<nodeID>
 
@@ -1045,26 +1043,12 @@
 			can be useful when debugging issues that require an SLB
 			miss to occur.
 
-	stress_slb	[PPC]
-			Limits the number of kernel SLB entries, and flushes
-			them frequently to increase the rate of SLB faults
-			on kernel addresses.
-
-	stress_hpt	[PPC]
-			Limits the number of kernel HPT entries in the hash
-			page table to increase the rate of hash page table
-			faults on kernel addresses.
-
 	disable=	[IPV6]
 			See Documentation/networking/ipv6.rst.
 
 	disable_radix	[PPC]
 			Disable RADIX MMU mode on POWER9
 
-	radix_hcall_invalidate=on  [PPC/PSERIES]
-			Disable RADIX GTSE feature and use hcall for TLB
-			invalidate.
-
 	disable_tlbie	[PPC]
 			Disable TLBIE instruction. Currently does not work
 			with KVM, with HASH MMU, or with coherent accelerators.
@@ -1166,16 +1150,6 @@
 			Documentation/admin-guide/dynamic-debug-howto.rst
 			for details.
 
-	nopku		[X86] Disable Memory Protection Keys CPU feature found
-			in some Intel CPUs.
-
-	<module>.async_probe[=<bool>] [KNL]
-			If no <bool> value is specified or if the value
-			specified is not a valid <bool>, enable asynchronous
-			probe on this module.  Otherwise, enable/disable
-			asynchronous probe on this module as indicated by the
-			<bool> value. See also: module.async_probe
-
 	early_ioremap_debug [KNL]
 			Enable debug messages in early_ioremap support. This
 			is useful for tracking down temporary early mappings
@@ -1791,12 +1765,6 @@
 				      which allow the hypervisor to 'idle' the
 				      guest on lock contention.
 
-	keep_bootcon	[KNL]
-			Do not unregister boot console at start. This is only
-			useful for debugging when something happens in the window
-			between unregistering the boot console and initializing
-			the real console.
-
 	i2c_bus=	[HW]	Override the default board specific I2C bus speed
 				or register an additional I2C bus that is not
 				registered from board initialization code.
@@ -2366,17 +2334,18 @@
 	js=		[HW,JOY] Analog joystick
 			See Documentation/input/joydev/joystick.rst.
 
-	nokaslr		[KNL]
-			When CONFIG_RANDOMIZE_BASE is set, this disables
-			kernel and module base offset ASLR (Address Space
-			Layout Randomization).
-
 	kasan_multi_shot
 			[KNL] Enforce KASAN (Kernel Address Sanitizer) to print
 			report on every invalid memory access. Without this
 			parameter KASAN will print report only for the first
 			invalid access.
 
+	keep_bootcon	[KNL]
+			Do not unregister boot console at start. This is only
+			useful for debugging when something happens in the window
+			between unregistering the boot console and initializing
+			the real console.
+
 	keepinitrd	[HW,ARM]
 
 	kernelcore=	[KNL,X86,IA-64,PPC]
@@ -3325,6 +3294,13 @@
 			For details see:
 			Documentation/admin-guide/hw-vuln/processor_mmio_stale_data.rst
 
+	<module>.async_probe[=<bool>] [KNL]
+			If no <bool> value is specified or if the value
+			specified is not a valid <bool>, enable asynchronous
+			probe on this module.  Otherwise, enable/disable
+			asynchronous probe on this module as indicated by the
+			<bool> value. See also: module.async_probe
+
 	module.async_probe=<bool>
 			[KNL] When set to true, modules will use async probing
 			by default. To enable/disable async probing for a
@@ -3779,6 +3755,11 @@
 
 	nojitter	[IA-64] Disables jitter checking for ITC timers.
 
+	nokaslr		[KNL]
+			When CONFIG_RANDOMIZE_BASE is set, this disables
+			kernel and module base offset ASLR (Address Space
+			Layout Randomization).
+
 	no-kvmclock	[X86,KVM] Disable paravirtualized KVM clock driver
 
 	no-kvmapf	[X86,KVM] Disable paravirtualized asynchronous page
@@ -3824,6 +3805,19 @@
 
 	nopcid		[X86-64] Disable the PCID cpu feature.
 
+	nopku		[X86] Disable Memory Protection Keys CPU feature found
+			in some Intel CPUs.
+
+	nopv=		[X86,XEN,KVM,HYPER_V,VMWARE]
+			Disables the PV optimizations forcing the guest to run
+			as generic guest with no PV drivers. Currently support
+			XEN HVM, KVM, HYPER_V and VMWARE guest.
+
+	nopvspin	[X86,XEN,KVM]
+			Disables the qspinlock slow path using PV optimizations
+			which allow the hypervisor to 'idle' the guest on lock
+			contention.
+
 	norandmaps	Don't use address space randomization.  Equivalent to
 			echo 0 > /proc/sys/kernel/randomize_va_space
 
@@ -4591,6 +4585,10 @@
 
 	r128=		[HW,DRM]
 
+	radix_hcall_invalidate=on  [PPC/PSERIES]
+			Disable RADIX GTSE feature and use hcall for TLB
+			invalidate.
+
 	raid=		[HW,RAID]
 			See Documentation/admin-guide/md.rst.
 
@@ -5572,13 +5570,6 @@
 			1 -- enable.
 			Default value is 1.
 
-	apparmor=	[APPARMOR] Disable or enable AppArmor at boot time
-			Format: { "0" | "1" }
-			See security/apparmor/Kconfig help text
-			0 -- disable.
-			1 -- enable.
-			Default value is set via kernel config option.
-
 	serialnumber	[BUGS=X86-32]
 
 	sev=option[,option...] [X86-64] See Documentation/x86/x86_64/boot-options.rst
@@ -5586,6 +5577,15 @@
 	shapers=	[NET]
 			Maximal number of shapers.
 
+	show_lapic=	[APIC,X86] Advanced Programmable Interrupt Controller
+			Limit apic dumping. The parameter defines the maximal
+			number of local apics being dumped. Also it is possible
+			to set it to "all" by meaning -- no limit here.
+			Format: { 1 (default) | 2 | ... | all }.
+			The parameter valid if only apic=debug or
+			apic=verbose is specified.
+			Example: apic=debug show_lapic=all
+
 	simeth=		[IA-64]
 	simscsi=
 
@@ -6025,6 +6025,16 @@
 			be used to filter out binaries which have
 			not yet been made aware of AT_MINSIGSTKSZ.
 
+	stress_hpt	[PPC]
+			Limits the number of kernel HPT entries in the hash
+			page table to increase the rate of hash page table
+			faults on kernel addresses.
+
+	stress_slb	[PPC]
+			Limits the number of kernel SLB entries, and flushes
+			them frequently to increase the rate of SLB faults
+			on kernel addresses.
+
 	sunrpc.min_resvport=
 	sunrpc.max_resvport=
 			[NFS,SUNRPC]
@@ -6957,16 +6967,6 @@
 			fairer and the number of possible event channels is
 			much higher. Default is on (use fifo events).
 
-	nopv=		[X86,XEN,KVM,HYPER_V,VMWARE]
-			Disables the PV optimizations forcing the guest to run
-			as generic guest with no PV drivers. Currently support
-			XEN HVM, KVM, HYPER_V and VMWARE guest.
-
-	nopvspin	[X86,XEN,KVM]
-			Disables the qspinlock slow path using PV optimizations
-			which allow the hypervisor to 'idle' the guest on lock
-			contention.
-
 	xirc2ps_cs=	[NET,PCMCIA]
 			Format:
 			<irq>,<irq_mask>,<io>,<full_duplex>,<do_sound>,<lockup_hack>[,<irq2>[,<irq3>[,<irq4>]]]
