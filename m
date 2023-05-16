Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7104A7048BE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 11:12:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232035AbjEPJMX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 05:12:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231848AbjEPJKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 05:10:14 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E0874ECF;
        Tue, 16 May 2023 02:10:06 -0700 (PDT)
Date:   Tue, 16 May 2023 09:10:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1684228203;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ivBvsuIznrf474d3TtYKCDlVxZswWEZo79X4phb6sjE=;
        b=OMcALAi1gWMKw5O8cGdWjTUkeIVFZfLNqseZsps/VCX6HqBWje0guWvUUhDc3Y5MB1WIBf
        LV8xPTbFhuS2mXzyFIpwMmEmG3Wv5tVFmzYpW7nynzyZ9I6KOfJ8Q9/nZGVoQ9caWa6LYu
        zaHQzlw9Z4E29pRkEsFyLpvjbAbH2mZCYxvpcJEmIn7/hrLtReVeMnHbHpsvxUEM+kfbJE
        6hkEz3m8S3NZG8nts/n1hJDzzuFCfcPCIiVx9ueGRQY3i26MgtJxfwVUJWlLSQ8kBBKwWD
        qB7gWwC1WlY0TJwMttzii09W6UdorDQVljRhdmTz3/t29FSBXjx5Rp75SpGqgw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1684228203;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ivBvsuIznrf474d3TtYKCDlVxZswWEZo79X4phb6sjE=;
        b=38KRgf93SnqW/aIzHlL/z9lSFt/qyMLLKV8dqc++ljKQ/Gg1zblIOzA/hEwBepr8T0Il3p
        JB+bs3yN+nm9JQCQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: smp/core] x86/topology: Remove CPU0 hotplug option
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Helge Deller <deller@gmx.de>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230512205255.715707999@linutronix.de>
References: <20230512205255.715707999@linutronix.de>
MIME-Version: 1.0
Message-ID: <168422820257.404.4532570541365199768.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the smp/core branch of tip:

Commit-ID:     e59e74dc48a309cb848ffc3d76a0d61aa6803c05
Gitweb:        https://git.kernel.org/tip/e59e74dc48a309cb848ffc3d76a0d61aa6803c05
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 12 May 2023 23:07:04 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 15 May 2023 13:44:49 +02:00

x86/topology: Remove CPU0 hotplug option

This was introduced together with commit e1c467e69040 ("x86, hotplug: Wake
up CPU0 via NMI instead of INIT, SIPI, SIPI") to eventually support
physical hotplug of CPU0:

 "We'll change this code in the future to wake up hard offlined CPU0 if
  real platform and request are available."

11 years later this has not happened and physical hotplug is not officially
supported. Remove the cruft.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Michael Kelley <mikelley@microsoft.com>
Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>
Tested-by: Helge Deller <deller@gmx.de> # parisc
Tested-by: Guilherme G. Piccoli <gpiccoli@igalia.com> # Steam Deck
Link: https://lore.kernel.org/r/20230512205255.715707999@linutronix.de
---
 Documentation/admin-guide/kernel-parameters.txt | 14 +--
 Documentation/core-api/cpu_hotplug.rst          | 13 +--
 arch/x86/Kconfig                                | 43 +-------
 arch/x86/include/asm/cpu.h                      |  3 +-
 arch/x86/kernel/topology.c                      | 98 +----------------
 arch/x86/power/cpu.c                            | 37 +------
 6 files changed, 6 insertions(+), 202 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 9e5bab2..ccb91a2 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -818,20 +818,6 @@
 			Format:
 			<first_slot>,<last_slot>,<port>,<enum_bit>[,<debug>]
 
-	cpu0_hotplug	[X86] Turn on CPU0 hotplug feature when
-			CONFIG_BOOTPARAM_HOTPLUG_CPU0 is off.
-			Some features depend on CPU0. Known dependencies are:
-			1. Resume from suspend/hibernate depends on CPU0.
-			Suspend/hibernate will fail if CPU0 is offline and you
-			need to online CPU0 before suspend/hibernate.
-			2. PIC interrupts also depend on CPU0. CPU0 can't be
-			removed if a PIC interrupt is detected.
-			It's said poweroff/reboot may depend on CPU0 on some
-			machines although I haven't seen such issues so far
-			after CPU0 is offline on a few tested machines.
-			If the dependencies are under your control, you can
-			turn on cpu0_hotplug.
-
 	cpuidle.off=1	[CPU_IDLE]
 			disable the cpuidle sub-system
 
diff --git a/Documentation/core-api/cpu_hotplug.rst b/Documentation/core-api/cpu_hotplug.rst
index f75778d..e6f5bc3 100644
--- a/Documentation/core-api/cpu_hotplug.rst
+++ b/Documentation/core-api/cpu_hotplug.rst
@@ -127,17 +127,8 @@ bring CPU4 back online::
  $ echo 1 > /sys/devices/system/cpu/cpu4/online
  smpboot: Booting Node 0 Processor 4 APIC 0x1
 
-The CPU is usable again. This should work on all CPUs. CPU0 is often special
-and excluded from CPU hotplug. On X86 the kernel option
-*CONFIG_BOOTPARAM_HOTPLUG_CPU0* has to be enabled in order to be able to
-shutdown CPU0. Alternatively the kernel command option *cpu0_hotplug* can be
-used. Some known dependencies of CPU0:
-
-* Resume from hibernate/suspend. Hibernate/suspend will fail if CPU0 is offline.
-* PIC interrupts. CPU0 can't be removed if a PIC interrupt is detected.
-
-Please let Fenghua Yu <fenghua.yu@intel.com> know if you find any dependencies
-on CPU0.
+The CPU is usable again. This should work on all CPUs, but CPU0 is often special
+and excluded from CPU hotplug.
 
 The CPU hotplug coordination
 ============================
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 53bab12..d019133 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2305,49 +2305,6 @@ config HOTPLUG_CPU
 	def_bool y
 	depends on SMP
 
-config BOOTPARAM_HOTPLUG_CPU0
-	bool "Set default setting of cpu0_hotpluggable"
-	depends on HOTPLUG_CPU
-	help
-	  Set whether default state of cpu0_hotpluggable is on or off.
-
-	  Say Y here to enable CPU0 hotplug by default. If this switch
-	  is turned on, there is no need to give cpu0_hotplug kernel
-	  parameter and the CPU0 hotplug feature is enabled by default.
-
-	  Please note: there are two known CPU0 dependencies if you want
-	  to enable the CPU0 hotplug feature either by this switch or by
-	  cpu0_hotplug kernel parameter.
-
-	  First, resume from hibernate or suspend always starts from CPU0.
-	  So hibernate and suspend are prevented if CPU0 is offline.
-
-	  Second dependency is PIC interrupts always go to CPU0. CPU0 can not
-	  offline if any interrupt can not migrate out of CPU0. There may
-	  be other CPU0 dependencies.
-
-	  Please make sure the dependencies are under your control before
-	  you enable this feature.
-
-	  Say N if you don't want to enable CPU0 hotplug feature by default.
-	  You still can enable the CPU0 hotplug feature at boot by kernel
-	  parameter cpu0_hotplug.
-
-config DEBUG_HOTPLUG_CPU0
-	def_bool n
-	prompt "Debug CPU0 hotplug"
-	depends on HOTPLUG_CPU
-	help
-	  Enabling this option offlines CPU0 (if CPU0 can be offlined) as
-	  soon as possible and boots up userspace with CPU0 offlined. User
-	  can online CPU0 back after boot time.
-
-	  To debug CPU0 hotplug, you need to enable CPU0 offline/online
-	  feature by either turning on CONFIG_BOOTPARAM_HOTPLUG_CPU0 during
-	  compilation or giving cpu0_hotplug kernel parameter at boot.
-
-	  If unsure, say N.
-
 config COMPAT_VDSO
 	def_bool n
 	prompt "Disable the 32-bit vDSO (needed for glibc 2.3.3)"
diff --git a/arch/x86/include/asm/cpu.h b/arch/x86/include/asm/cpu.h
index b356464..c854376 100644
--- a/arch/x86/include/asm/cpu.h
+++ b/arch/x86/include/asm/cpu.h
@@ -31,9 +31,6 @@ struct x86_cpu {
 extern int arch_register_cpu(int num);
 extern void arch_unregister_cpu(int);
 extern void soft_restart_cpu(void);
-#ifdef CONFIG_DEBUG_HOTPLUG_CPU0
-extern int _debug_hotplug_cpu(int cpu, int action);
-#endif
 #endif
 
 extern void ap_init_aperfmperf(void);
diff --git a/arch/x86/kernel/topology.c b/arch/x86/kernel/topology.c
index 1b83377..ca004e2 100644
--- a/arch/x86/kernel/topology.c
+++ b/arch/x86/kernel/topology.c
@@ -38,102 +38,12 @@
 static DEFINE_PER_CPU(struct x86_cpu, cpu_devices);
 
 #ifdef CONFIG_HOTPLUG_CPU
-
-#ifdef CONFIG_BOOTPARAM_HOTPLUG_CPU0
-static int cpu0_hotpluggable = 1;
-#else
-static int cpu0_hotpluggable;
-static int __init enable_cpu0_hotplug(char *str)
-{
-	cpu0_hotpluggable = 1;
-	return 1;
-}
-
-__setup("cpu0_hotplug", enable_cpu0_hotplug);
-#endif
-
-#ifdef CONFIG_DEBUG_HOTPLUG_CPU0
-/*
- * This function offlines a CPU as early as possible and allows userspace to
- * boot up without the CPU. The CPU can be onlined back by user after boot.
- *
- * This is only called for debugging CPU offline/online feature.
- */
-int _debug_hotplug_cpu(int cpu, int action)
+int arch_register_cpu(int cpu)
 {
-	int ret;
-
-	if (!cpu_is_hotpluggable(cpu))
-		return -EINVAL;
+	struct x86_cpu *xc = per_cpu_ptr(&cpu_devices, cpu);
 
-	switch (action) {
-	case 0:
-		ret = remove_cpu(cpu);
-		if (!ret)
-			pr_info("DEBUG_HOTPLUG_CPU0: CPU %u is now offline\n", cpu);
-		else
-			pr_debug("Can't offline CPU%d.\n", cpu);
-		break;
-	case 1:
-		ret = add_cpu(cpu);
-		if (ret)
-			pr_debug("Can't online CPU%d.\n", cpu);
-
-		break;
-	default:
-		ret = -EINVAL;
-	}
-
-	return ret;
-}
-
-static int __init debug_hotplug_cpu(void)
-{
-	_debug_hotplug_cpu(0, 0);
-	return 0;
-}
-
-late_initcall_sync(debug_hotplug_cpu);
-#endif /* CONFIG_DEBUG_HOTPLUG_CPU0 */
-
-int arch_register_cpu(int num)
-{
-	struct cpuinfo_x86 *c = &cpu_data(num);
-
-	/*
-	 * Currently CPU0 is only hotpluggable on Intel platforms. Other
-	 * vendors can add hotplug support later.
-	 * Xen PV guests don't support CPU0 hotplug at all.
-	 */
-	if (c->x86_vendor != X86_VENDOR_INTEL ||
-	    cpu_feature_enabled(X86_FEATURE_XENPV))
-		cpu0_hotpluggable = 0;
-
-	/*
-	 * Two known BSP/CPU0 dependencies: Resume from suspend/hibernate
-	 * depends on BSP. PIC interrupts depend on BSP.
-	 *
-	 * If the BSP dependencies are under control, one can tell kernel to
-	 * enable BSP hotplug. This basically adds a control file and
-	 * one can attempt to offline BSP.
-	 */
-	if (num == 0 && cpu0_hotpluggable) {
-		unsigned int irq;
-		/*
-		 * We won't take down the boot processor on i386 if some
-		 * interrupts only are able to be serviced by the BSP in PIC.
-		 */
-		for_each_active_irq(irq) {
-			if (!IO_APIC_IRQ(irq) && irq_has_action(irq)) {
-				cpu0_hotpluggable = 0;
-				break;
-			}
-		}
-	}
-	if (num || cpu0_hotpluggable)
-		per_cpu(cpu_devices, num).cpu.hotpluggable = 1;
-
-	return register_cpu(&per_cpu(cpu_devices, num).cpu, num);
+	xc->cpu.hotpluggable = cpu > 0;
+	return register_cpu(&xc->cpu, cpu);
 }
 EXPORT_SYMBOL(arch_register_cpu);
 
diff --git a/arch/x86/power/cpu.c b/arch/x86/power/cpu.c
index 7a4d5e9..63230ff 100644
--- a/arch/x86/power/cpu.c
+++ b/arch/x86/power/cpu.c
@@ -351,43 +351,6 @@ static int bsp_pm_callback(struct notifier_block *nb, unsigned long action,
 	case PM_HIBERNATION_PREPARE:
 		ret = bsp_check();
 		break;
-#ifdef CONFIG_DEBUG_HOTPLUG_CPU0
-	case PM_RESTORE_PREPARE:
-		/*
-		 * When system resumes from hibernation, online CPU0 because
-		 * 1. it's required for resume and
-		 * 2. the CPU was online before hibernation
-		 */
-		if (!cpu_online(0))
-			_debug_hotplug_cpu(0, 1);
-		break;
-	case PM_POST_RESTORE:
-		/*
-		 * When a resume really happens, this code won't be called.
-		 *
-		 * This code is called only when user space hibernation software
-		 * prepares for snapshot device during boot time. So we just
-		 * call _debug_hotplug_cpu() to restore to CPU0's state prior to
-		 * preparing the snapshot device.
-		 *
-		 * This works for normal boot case in our CPU0 hotplug debug
-		 * mode, i.e. CPU0 is offline and user mode hibernation
-		 * software initializes during boot time.
-		 *
-		 * If CPU0 is online and user application accesses snapshot
-		 * device after boot time, this will offline CPU0 and user may
-		 * see different CPU0 state before and after accessing
-		 * the snapshot device. But hopefully this is not a case when
-		 * user debugging CPU0 hotplug. Even if users hit this case,
-		 * they can easily online CPU0 back.
-		 *
-		 * To simplify this debug code, we only consider normal boot
-		 * case. Otherwise we need to remember CPU0's state and restore
-		 * to that state and resolve racy conditions etc.
-		 */
-		_debug_hotplug_cpu(0, 0);
-		break;
-#endif
 	default:
 		break;
 	}
