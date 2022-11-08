Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF741620639
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 02:39:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233202AbiKHBjR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 20:39:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbiKHBjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 20:39:15 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD311625F
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 17:39:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id C54BECE1755
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 01:39:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF33AC433C1;
        Tue,  8 Nov 2022 01:39:07 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     loongarch@lists.linux.dev, Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-kernel@vger.kernel.org, Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH] LoongArch: SMP: Change prefix from loongson3 to loongson
Date:   Tue,  8 Nov 2022 09:36:49 +0800
Message-Id: <20221108013649.3872869-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SMP operations can be shared by Loongson-2 series and Loongson-3 series,
so we change the prefix from loongson3 to loongson for all functions and
data structures.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/include/asm/irq.h |  2 +-
 arch/loongarch/include/asm/smp.h | 30 +++++++++++-----------
 arch/loongarch/kernel/irq.c      |  2 +-
 arch/loongarch/kernel/smp.c      | 44 ++++++++++++++++----------------
 4 files changed, 39 insertions(+), 39 deletions(-)

diff --git a/arch/loongarch/include/asm/irq.h b/arch/loongarch/include/asm/irq.h
index d06d4542b634..5332b1433f38 100644
--- a/arch/loongarch/include/asm/irq.h
+++ b/arch/loongarch/include/asm/irq.h
@@ -117,7 +117,7 @@ extern struct fwnode_handle *liointc_handle;
 extern struct fwnode_handle *pch_lpc_handle;
 extern struct fwnode_handle *pch_pic_handle[MAX_IO_PICS];
 
-extern irqreturn_t loongson3_ipi_interrupt(int irq, void *dev);
+extern irqreturn_t loongson_ipi_interrupt(int irq, void *dev);
 
 #include <asm-generic/irq.h>
 
diff --git a/arch/loongarch/include/asm/smp.h b/arch/loongarch/include/asm/smp.h
index 71189b28bfb2..3dd172d9ffea 100644
--- a/arch/loongarch/include/asm/smp.h
+++ b/arch/loongarch/include/asm/smp.h
@@ -19,21 +19,21 @@ extern cpumask_t cpu_sibling_map[];
 extern cpumask_t cpu_core_map[];
 extern cpumask_t cpu_foreign_map[];
 
-void loongson3_smp_setup(void);
-void loongson3_prepare_cpus(unsigned int max_cpus);
-void loongson3_boot_secondary(int cpu, struct task_struct *idle);
-void loongson3_init_secondary(void);
-void loongson3_smp_finish(void);
-void loongson3_send_ipi_single(int cpu, unsigned int action);
-void loongson3_send_ipi_mask(const struct cpumask *mask, unsigned int action);
+void loongson_smp_setup(void);
+void loongson_prepare_cpus(unsigned int max_cpus);
+void loongson_boot_secondary(int cpu, struct task_struct *idle);
+void loongson_init_secondary(void);
+void loongson_smp_finish(void);
+void loongson_send_ipi_single(int cpu, unsigned int action);
+void loongson_send_ipi_mask(const struct cpumask *mask, unsigned int action);
 #ifdef CONFIG_HOTPLUG_CPU
-int loongson3_cpu_disable(void);
-void loongson3_cpu_die(unsigned int cpu);
+int loongson_cpu_disable(void);
+void loongson_cpu_die(unsigned int cpu);
 #endif
 
 static inline void plat_smp_setup(void)
 {
-	loongson3_smp_setup();
+	loongson_smp_setup();
 }
 
 static inline int raw_smp_processor_id(void)
@@ -85,28 +85,28 @@ extern void show_ipi_list(struct seq_file *p, int prec);
  */
 static inline void smp_send_reschedule(int cpu)
 {
-	loongson3_send_ipi_single(cpu, SMP_RESCHEDULE);
+	loongson_send_ipi_single(cpu, SMP_RESCHEDULE);
 }
 
 static inline void arch_send_call_function_single_ipi(int cpu)
 {
-	loongson3_send_ipi_single(cpu, SMP_CALL_FUNCTION);
+	loongson_send_ipi_single(cpu, SMP_CALL_FUNCTION);
 }
 
 static inline void arch_send_call_function_ipi_mask(const struct cpumask *mask)
 {
-	loongson3_send_ipi_mask(mask, SMP_CALL_FUNCTION);
+	loongson_send_ipi_mask(mask, SMP_CALL_FUNCTION);
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
 static inline int __cpu_disable(void)
 {
-	return loongson3_cpu_disable();
+	return loongson_cpu_disable();
 }
 
 static inline void __cpu_die(unsigned int cpu)
 {
-	loongson3_cpu_die(cpu);
+	loongson_cpu_die(cpu);
 }
 
 extern void play_dead(void);
diff --git a/arch/loongarch/kernel/irq.c b/arch/loongarch/kernel/irq.c
index 1ba19c76563e..0524bf1169b7 100644
--- a/arch/loongarch/kernel/irq.c
+++ b/arch/loongarch/kernel/irq.c
@@ -117,7 +117,7 @@ void __init init_IRQ(void)
 	if (ipi_irq < 0)
 		panic("IPI IRQ mapping failed\n");
 	irq_set_percpu_devid(ipi_irq);
-	r = request_percpu_irq(ipi_irq, loongson3_ipi_interrupt, "IPI", &ipi_dummy_dev);
+	r = request_percpu_irq(ipi_irq, loongson_ipi_interrupt, "IPI", &ipi_dummy_dev);
 	if (r < 0)
 		panic("IPI IRQ request failed\n");
 #endif
diff --git a/arch/loongarch/kernel/smp.c b/arch/loongarch/kernel/smp.c
index 781a4d4bdddc..6ed72f7ff278 100644
--- a/arch/loongarch/kernel/smp.c
+++ b/arch/loongarch/kernel/smp.c
@@ -136,12 +136,12 @@ static void ipi_write_action(int cpu, u32 action)
 	}
 }
 
-void loongson3_send_ipi_single(int cpu, unsigned int action)
+void loongson_send_ipi_single(int cpu, unsigned int action)
 {
 	ipi_write_action(cpu_logical_map(cpu), (u32)action);
 }
 
-void loongson3_send_ipi_mask(const struct cpumask *mask, unsigned int action)
+void loongson_send_ipi_mask(const struct cpumask *mask, unsigned int action)
 {
 	unsigned int i;
 
@@ -149,7 +149,7 @@ void loongson3_send_ipi_mask(const struct cpumask *mask, unsigned int action)
 		ipi_write_action(cpu_logical_map(i), (u32)action);
 }
 
-irqreturn_t loongson3_ipi_interrupt(int irq, void *dev)
+irqreturn_t loongson_ipi_interrupt(int irq, void *dev)
 {
 	unsigned int action;
 	unsigned int cpu = smp_processor_id();
@@ -169,7 +169,7 @@ irqreturn_t loongson3_ipi_interrupt(int irq, void *dev)
 	return IRQ_HANDLED;
 }
 
-void __init loongson3_smp_setup(void)
+void __init loongson_smp_setup(void)
 {
 	cpu_data[0].core = cpu_logical_map(0) % loongson_sysconf.cores_per_package;
 	cpu_data[0].package = cpu_logical_map(0) / loongson_sysconf.cores_per_package;
@@ -178,7 +178,7 @@ void __init loongson3_smp_setup(void)
 	pr_info("Detected %i available CPU(s)\n", loongson_sysconf.nr_cpus);
 }
 
-void __init loongson3_prepare_cpus(unsigned int max_cpus)
+void __init loongson_prepare_cpus(unsigned int max_cpus)
 {
 	int i = 0;
 
@@ -193,7 +193,7 @@ void __init loongson3_prepare_cpus(unsigned int max_cpus)
 /*
  * Setup the PC, SP, and TP of a secondary processor and start it running!
  */
-void loongson3_boot_secondary(int cpu, struct task_struct *idle)
+void loongson_boot_secondary(int cpu, struct task_struct *idle)
 {
 	unsigned long entry;
 
@@ -205,13 +205,13 @@ void loongson3_boot_secondary(int cpu, struct task_struct *idle)
 
 	csr_mail_send(entry, cpu_logical_map(cpu), 0);
 
-	loongson3_send_ipi_single(cpu, SMP_BOOT_CPU);
+	loongson_send_ipi_single(cpu, SMP_BOOT_CPU);
 }
 
 /*
  * SMP init and finish on secondary CPUs
  */
-void loongson3_init_secondary(void)
+void loongson_init_secondary(void)
 {
 	unsigned int cpu = smp_processor_id();
 	unsigned int imask = ECFGF_IP0 | ECFGF_IP1 | ECFGF_IP2 |
@@ -231,7 +231,7 @@ void loongson3_init_secondary(void)
 		     cpu_logical_map(cpu) / loongson_sysconf.cores_per_package;
 }
 
-void loongson3_smp_finish(void)
+void loongson_smp_finish(void)
 {
 	local_irq_enable();
 	iocsr_write64(0, LOONGARCH_IOCSR_MBUF0);
@@ -240,7 +240,7 @@ void loongson3_smp_finish(void)
 
 #ifdef CONFIG_HOTPLUG_CPU
 
-int loongson3_cpu_disable(void)
+int loongson_cpu_disable(void)
 {
 	unsigned long flags;
 	unsigned int cpu = smp_processor_id();
@@ -262,7 +262,7 @@ int loongson3_cpu_disable(void)
 	return 0;
 }
 
-void loongson3_cpu_die(unsigned int cpu)
+void loongson_cpu_die(unsigned int cpu)
 {
 	while (per_cpu(cpu_state, cpu) != CPU_DEAD)
 		cpu_relax();
@@ -300,19 +300,19 @@ void play_dead(void)
  */
 #ifdef CONFIG_PM
 
-static int loongson3_ipi_suspend(void)
+static int loongson_ipi_suspend(void)
 {
 	return 0;
 }
 
-static void loongson3_ipi_resume(void)
+static void loongson_ipi_resume(void)
 {
 	iocsr_write32(0xffffffff, LOONGARCH_IOCSR_IPI_EN);
 }
 
-static struct syscore_ops loongson3_ipi_syscore_ops = {
-	.resume         = loongson3_ipi_resume,
-	.suspend        = loongson3_ipi_suspend,
+static struct syscore_ops loongson_ipi_syscore_ops = {
+	.resume         = loongson_ipi_resume,
+	.suspend        = loongson_ipi_suspend,
 };
 
 /*
@@ -321,7 +321,7 @@ static struct syscore_ops loongson3_ipi_syscore_ops = {
  */
 static int __init ipi_pm_init(void)
 {
-	register_syscore_ops(&loongson3_ipi_syscore_ops);
+	register_syscore_ops(&loongson_ipi_syscore_ops);
 	return 0;
 }
 
@@ -425,7 +425,7 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
 {
 	init_new_context(current, &init_mm);
 	current_thread_info()->cpu = 0;
-	loongson3_prepare_cpus(max_cpus);
+	loongson_prepare_cpus(max_cpus);
 	set_cpu_sibling_map(0);
 	set_cpu_core_map(0);
 	calculate_cpu_foreign_map();
@@ -436,7 +436,7 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
 
 int __cpu_up(unsigned int cpu, struct task_struct *tidle)
 {
-	loongson3_boot_secondary(cpu, tidle);
+	loongson_boot_secondary(cpu, tidle);
 
 	/* Wait for CPU to start and be ready to sync counters */
 	if (!wait_for_completion_timeout(&cpu_starting,
@@ -465,7 +465,7 @@ asmlinkage void start_secondary(void)
 
 	cpu_probe();
 	constant_clockevent_init();
-	loongson3_init_secondary();
+	loongson_init_secondary();
 
 	set_cpu_sibling_map(cpu);
 	set_cpu_core_map(cpu);
@@ -487,11 +487,11 @@ asmlinkage void start_secondary(void)
 	complete(&cpu_running);
 
 	/*
-	 * irq will be enabled in loongson3_smp_finish(), enabling it too
+	 * irq will be enabled in loongson_smp_finish(), enabling it too
 	 * early is dangerous.
 	 */
 	WARN_ON_ONCE(!irqs_disabled());
-	loongson3_smp_finish();
+	loongson_smp_finish();
 
 	cpu_startup_entry(CPUHP_AP_ONLINE_IDLE);
 }
-- 
2.31.1

