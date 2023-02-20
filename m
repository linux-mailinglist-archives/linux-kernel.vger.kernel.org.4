Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B321F69C9EC
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 12:33:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231830AbjBTLdR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 06:33:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231862AbjBTLdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 06:33:03 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19E066181
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 03:32:56 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1676892775;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=DlGgBr2SEe9ma73ajs2KyVBPpUCNquWZKfN+W1BIShg=;
        b=qZwVNg6B6LSHW/tBHE2FAnxvlNL6U9UVhQVapYOIua8Hcd6IL3FWP6t8RXO49Uj4OrVQOw
        PdwEnKa/Lae+C/iejmIpLho1hRAqzZtH7S8OjmqkPXwyW54Jt3vT14htJsgZ6YeH/zTmYH
        Z+TXnivUEZdEJBi+gP7sq7EEz3Ib5cDgd5YmhjVzwThYM8GB23NnohHvC0kvGk1h3p15af
        /3cjokQ3PQwx6lilXU1LkFvYhJ+KOVkYYdzeGN7pFsxcCR3X8WWibamaG3WpVc+wVkU9zS
        7OUPYbsnCLlqOIsCfIQkW09b5Zs2a3+SvS5O1UBvAkFsJMg14pQKRwM9TxzOWQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1676892775;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=DlGgBr2SEe9ma73ajs2KyVBPpUCNquWZKfN+W1BIShg=;
        b=WWAnyb4r+r0vjvuXHtQDEIUPf75fvSBTIyGSWkPkaRYOotDTX4yLCeosd4wgehlFSqrd19
        EsrCzLc41Vc4svAQ==
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] x86/cleanups for v6.3-rc1
References: <167689254797.295764.1600565060995031919.tglx@xen13>
Message-ID: <167689255093.295764.7287608125437351112.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Date:   Mon, 20 Feb 2023 12:32:55 +0100 (CET)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest x86/cleanups branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-cleanups-202=
3-02-20

up to:  fcb3a81d2217: x86/hotplug: Remove incorrect comment about mwait_play_=
dead()


Miscellaneous cleanups in X86:

  - Correct the common copy and pasted mishandling of kstrtobool() in the
    strict_sas_size() setup function.

  - Make recalibrate_cpu_khz() an GPL only export.

  - Check TSC feature before doing anything else which avoids pointless
    code execution if TSC is not available.

  - Remove or fixup stale and misleading comments.

  - Remove unused or pointelessly duplicated variables.

  - Spelling and typo fixes.


Thanks,

	tglx

------------------>
Borislav Petkov (AMD) (3):
      x86/cacheinfo: Remove unused trace variable
      x86/tsc: Make recalibrate_cpu_khz() export GPL only
      x86/tsc: Do feature check as the very first thing

Christophe JAILLET (1):
      x86/signal: Fix the value returned by strict_sas_size()

Juergen Gross (1):
      x86/cpu: Remove misleading comment

Randy Dunlap (1):
      x86/Kconfig: Fix spellos & punctuation

Srivatsa S. Bhat (VMware) (1):
      x86/hotplug: Remove incorrect comment about mwait_play_dead()

Wang Yong (1):
      x86/boot/e820: Fix typo in e820.c comment

Yuntao Wang (1):
      x86/setup: Move duplicate boot_cpu_data definition out of the ifdeffery


 arch/x86/Kconfig                |  6 +++---
 arch/x86/kernel/cpu/cacheinfo.c |  5 +----
 arch/x86/kernel/cpu/common.c    |  2 +-
 arch/x86/kernel/e820.c          |  6 +++---
 arch/x86/kernel/setup.c         | 10 ++--------
 arch/x86/kernel/signal.c        |  2 +-
 arch/x86/kernel/smpboot.c       |  2 +-
 arch/x86/kernel/tsc.c           | 13 ++++++-------
 8 files changed, 18 insertions(+), 28 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 3604074a878b..a825bf031f49 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1502,7 +1502,7 @@ config X86_5LEVEL
 	depends on X86_64
 	help
 	  5-level paging enables access to larger address space:
-	  upto 128 PiB of virtual address space and 4 PiB of
+	  up to 128 PiB of virtual address space and 4 PiB of
 	  physical address space.
=20
 	  It will be supported by future Intel CPUs.
@@ -2609,8 +2609,8 @@ config CALL_THUNKS_DEBUG
 	  a noisy dmesg about callthunks generation and call patching for
 	  trouble shooting. The debug prints need to be enabled on the
 	  kernel command line with 'debug-callthunks'.
-	  Only enable this, when you are debugging call thunks as this
-	  creates a noticable runtime overhead. If unsure say N.
+	  Only enable this when you are debugging call thunks as this
+	  creates a noticeable runtime overhead. If unsure say N.
=20
 config CPU_IBPB_ENTRY
 	bool "Enable IBPB on kernel entry"
diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index f4e5aa27eec6..4063e8991211 100644
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -734,7 +734,7 @@ void init_hygon_cacheinfo(struct cpuinfo_x86 *c)
 void init_intel_cacheinfo(struct cpuinfo_x86 *c)
 {
 	/* Cache sizes */
-	unsigned int trace =3D 0, l1i =3D 0, l1d =3D 0, l2 =3D 0, l3 =3D 0;
+	unsigned int l1i =3D 0, l1d =3D 0, l2 =3D 0, l3 =3D 0;
 	unsigned int new_l1d =3D 0, new_l1i =3D 0; /* Cache sizes from cpuid(4) */
 	unsigned int new_l2 =3D 0, new_l3 =3D 0, i; /* Cache sizes from cpuid(4) */
 	unsigned int l2_id =3D 0, l3_id =3D 0, num_threads_sharing, index_msb;
@@ -835,9 +835,6 @@ void init_intel_cacheinfo(struct cpuinfo_x86 *c)
 						case LVL_3:
 							l3 +=3D cache_table[k].size;
 							break;
-						case LVL_TRACE:
-							trace +=3D cache_table[k].size;
-							break;
 						}
=20
 						break;
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 9cfca3d7d0e2..7670397438c6 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -567,7 +567,7 @@ static __init int setup_disable_pku(char *arg)
 	return 1;
 }
 __setup("nopku", setup_disable_pku);
-#endif /* CONFIG_X86_64 */
+#endif
=20
 #ifdef CONFIG_X86_KERNEL_IBT
=20
diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index 9dac24680ff8..fb8cf953380d 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -53,7 +53,7 @@
  *
  * Once the E820 map has been converted to the standard Linux memory layout
  * information its role stops - modifying it has no effect and does not get
- * re-propagated. So itsmain role is a temporary bootstrap storage of firmwa=
re
+ * re-propagated. So its main role is a temporary bootstrap storage of firmw=
are
  * specific memory layout data during early bootup.
  */
 static struct e820_table e820_table_init		__initdata;
@@ -395,7 +395,7 @@ int __init e820__update_table(struct e820_table *table)
=20
 		/* Continue building up new map based on this information: */
 		if (current_type !=3D last_type || e820_nomerge(current_type)) {
-			if (last_type !=3D 0)	 {
+			if (last_type) {
 				new_entries[new_nr_entries].size =3D change_point[chg_idx]->addr - last_=
addr;
 				/* Move forward only if the new size was non-zero: */
 				if (new_entries[new_nr_entries].size !=3D 0)
@@ -403,7 +403,7 @@ int __init e820__update_table(struct e820_table *table)
 					if (++new_nr_entries >=3D max_nr_entries)
 						break;
 			}
-			if (current_type !=3D 0)	{
+			if (current_type) {
 				new_entries[new_nr_entries].addr =3D change_point[chg_idx]->addr;
 				new_entries[new_nr_entries].type =3D current_type;
 				last_addr =3D change_point[chg_idx]->addr;
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 88188549647c..16babff771bd 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -114,11 +114,6 @@ static struct resource bss_resource =3D {
 #ifdef CONFIG_X86_32
 /* CPU data as detected by the assembly code in head_32.S */
 struct cpuinfo_x86 new_cpu_data;
-
-/* Common CPU data for all CPUs */
-struct cpuinfo_x86 boot_cpu_data __read_mostly;
-EXPORT_SYMBOL(boot_cpu_data);
-
 unsigned int def_to_bigsmp;
=20
 struct apm_info apm_info;
@@ -132,11 +127,10 @@ EXPORT_SYMBOL(ist_info);
 struct ist_info ist_info;
 #endif
=20
-#else
-struct cpuinfo_x86 boot_cpu_data __read_mostly;
-EXPORT_SYMBOL(boot_cpu_data);
 #endif
=20
+struct cpuinfo_x86 boot_cpu_data __read_mostly;
+EXPORT_SYMBOL(boot_cpu_data);
=20
 #if !defined(CONFIG_X86_PAE) || defined(CONFIG_X86_64)
 __visible unsigned long mmu_cr4_features __ro_after_init;
diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index 1504eb8d25aa..004cb30b7419 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -360,7 +360,7 @@ static bool strict_sigaltstack_size __ro_after_init =3D f=
alse;
=20
 static int __init strict_sas_size(char *arg)
 {
-	return kstrtobool(arg, &strict_sigaltstack_size);
+	return kstrtobool(arg, &strict_sigaltstack_size) =3D=3D 0;
 }
 __setup("strict_sas_size", strict_sas_size);
=20
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 55cad72715d9..9013bb28255a 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1833,7 +1833,7 @@ void native_play_dead(void)
 	play_dead_common();
 	tboot_shutdown(TB_SHUTDOWN_WFS);
=20
-	mwait_play_dead();	/* Only returns on failure */
+	mwait_play_dead();
 	if (cpuidle_play_dead())
 		hlt_play_dead();
 }
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index a78e73da4a74..aff1d79dd6ba 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -912,8 +912,7 @@ void recalibrate_cpu_khz(void)
 						    cpu_khz_old, cpu_khz);
 #endif
 }
-
-EXPORT_SYMBOL(recalibrate_cpu_khz);
+EXPORT_SYMBOL_GPL(recalibrate_cpu_khz);
=20
=20
 static unsigned long long cyc2ns_suspend;
@@ -1510,6 +1509,11 @@ void __init tsc_early_init(void)
=20
 void __init tsc_init(void)
 {
+	if (!cpu_feature_enabled(X86_FEATURE_TSC)) {
+		setup_clear_cpu_cap(X86_FEATURE_TSC_DEADLINE_TIMER);
+		return;
+	}
+
 	/*
 	 * native_calibrate_cpu_early can only calibrate using methods that are
 	 * available early in boot.
@@ -1517,11 +1521,6 @@ void __init tsc_init(void)
 	if (x86_platform.calibrate_cpu =3D=3D native_calibrate_cpu_early)
 		x86_platform.calibrate_cpu =3D native_calibrate_cpu;
=20
-	if (!boot_cpu_has(X86_FEATURE_TSC)) {
-		setup_clear_cpu_cap(X86_FEATURE_TSC_DEADLINE_TIMER);
-		return;
-	}
-
 	if (!tsc_khz) {
 		/* We failed to determine frequencies earlier, try again */
 		if (!determine_cpu_tsc_frequencies(false)) {

