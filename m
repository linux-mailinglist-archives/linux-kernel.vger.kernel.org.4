Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4E4863D4D0
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 12:41:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234803AbiK3LlT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 06:41:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234119AbiK3LlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 06:41:07 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FF2B2EF23;
        Wed, 30 Nov 2022 03:41:05 -0800 (PST)
Date:   Wed, 30 Nov 2022 11:41:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669808464;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sAAXxhLK1PhnrCXMeKDMnRnD3e/sj6jVUormXog/ISI=;
        b=YCHFXoaMYElZMgwRw7YfRoe5B+lgqIwoopFcRTyoNlR5UNqXXqN2zToB3F+K1RuXjTE9VQ
        tOd7Aj9r6LGSEH+2Jt7fbfb61n6GZiK9Rmtw4bBF8WK6YVDQWqA78DPjNIazM6y5/HUeOl
        HcOicGyVV13YS0IcR4h127/GV4keZRZyavoL/y1CD6W+u980TBJ54e6P9/w2DjnQcGipu8
        yq/yN/f1oWfWZZDLO5sa4B9pVIVkwMMyTQKOfLLjiRx+V8elisURLxJGedO3LTNyH3XbN8
        uJB6lPLYN2bng/skWUXxnwAygXcXW05pHUh6VCKI+dzykXHkuB1ZXRnaJSj3Vg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669808464;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sAAXxhLK1PhnrCXMeKDMnRnD3e/sj6jVUormXog/ISI=;
        b=mvZLgZVK9hTwTEBhK+gaQr7a0EcXoyRCxA5Q6C09VDSecZyJ0RQ2TGRUPnigLHJ5DOP/kU
        k/M9DZzPF7H+caDA==
From:   "tip-bot2 for Borislav Petkov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/cpuid: Carve out all CPUID functionality
Cc:     Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221124164150.3040-1-bp@alien8.de>
References: <20221124164150.3040-1-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <166980846247.4906.12851925292211041024.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     d800169041c0e035160c8b81f30d4b7e8f8ef777
Gitweb:        https://git.kernel.org/tip/d800169041c0e035160c8b81f30d4b7e8f8ef777
Author:        Borislav Petkov <bp@suse.de>
AuthorDate:    Thu, 24 Nov 2022 16:31:27 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 29 Nov 2022 20:41:24 +01:00

x86/cpuid: Carve out all CPUID functionality

Carve it out into a special header, where it belongs.

No functional changes.

Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/20221124164150.3040-1-bp@alien8.de
---
 arch/x86/include/asm/cpuid.h     | 141 +++++++++++++++++++++++++++++-
 arch/x86/include/asm/processor.h | 133 +----------------------------
 2 files changed, 140 insertions(+), 134 deletions(-)

diff --git a/arch/x86/include/asm/cpuid.h b/arch/x86/include/asm/cpuid.h
index 70b2db1..9bee3e7 100644
--- a/arch/x86/include/asm/cpuid.h
+++ b/arch/x86/include/asm/cpuid.h
@@ -1,13 +1,132 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
  * CPUID-related helpers/definitions
- *
- * Derived from arch/x86/kvm/cpuid.c
  */
 
 #ifndef _ASM_X86_CPUID_H
 #define _ASM_X86_CPUID_H
 
+#include <asm/string.h>
+
+struct cpuid_regs {
+	u32 eax, ebx, ecx, edx;
+};
+
+enum cpuid_regs_idx {
+	CPUID_EAX = 0,
+	CPUID_EBX,
+	CPUID_ECX,
+	CPUID_EDX,
+};
+
+#ifdef CONFIG_X86_32
+extern int have_cpuid_p(void);
+#else
+static inline int have_cpuid_p(void)
+{
+	return 1;
+}
+#endif
+static inline void native_cpuid(unsigned int *eax, unsigned int *ebx,
+				unsigned int *ecx, unsigned int *edx)
+{
+	/* ecx is often an input as well as an output. */
+	asm volatile("cpuid"
+	    : "=a" (*eax),
+	      "=b" (*ebx),
+	      "=c" (*ecx),
+	      "=d" (*edx)
+	    : "0" (*eax), "2" (*ecx)
+	    : "memory");
+}
+
+#define native_cpuid_reg(reg)					\
+static inline unsigned int native_cpuid_##reg(unsigned int op)	\
+{								\
+	unsigned int eax = op, ebx, ecx = 0, edx;		\
+								\
+	native_cpuid(&eax, &ebx, &ecx, &edx);			\
+								\
+	return reg;						\
+}
+
+/*
+ * Native CPUID functions returning a single datum.
+ */
+native_cpuid_reg(eax)
+native_cpuid_reg(ebx)
+native_cpuid_reg(ecx)
+native_cpuid_reg(edx)
+
+#ifdef CONFIG_PARAVIRT_XXL
+#include <asm/paravirt.h>
+#else
+#define __cpuid			native_cpuid
+#endif
+
+/*
+ * Generic CPUID function
+ * clear %ecx since some cpus (Cyrix MII) do not set or clear %ecx
+ * resulting in stale register contents being returned.
+ */
+static inline void cpuid(unsigned int op,
+			 unsigned int *eax, unsigned int *ebx,
+			 unsigned int *ecx, unsigned int *edx)
+{
+	*eax = op;
+	*ecx = 0;
+	__cpuid(eax, ebx, ecx, edx);
+}
+
+/* Some CPUID calls want 'count' to be placed in ecx */
+static inline void cpuid_count(unsigned int op, int count,
+			       unsigned int *eax, unsigned int *ebx,
+			       unsigned int *ecx, unsigned int *edx)
+{
+	*eax = op;
+	*ecx = count;
+	__cpuid(eax, ebx, ecx, edx);
+}
+
+/*
+ * CPUID functions returning a single datum
+ */
+static inline unsigned int cpuid_eax(unsigned int op)
+{
+	unsigned int eax, ebx, ecx, edx;
+
+	cpuid(op, &eax, &ebx, &ecx, &edx);
+
+	return eax;
+}
+
+static inline unsigned int cpuid_ebx(unsigned int op)
+{
+	unsigned int eax, ebx, ecx, edx;
+
+	cpuid(op, &eax, &ebx, &ecx, &edx);
+
+	return ebx;
+}
+
+static inline unsigned int cpuid_ecx(unsigned int op)
+{
+	unsigned int eax, ebx, ecx, edx;
+
+	cpuid(op, &eax, &ebx, &ecx, &edx);
+
+	return ecx;
+}
+
+static inline unsigned int cpuid_edx(unsigned int op)
+{
+	unsigned int eax, ebx, ecx, edx;
+
+	cpuid(op, &eax, &ebx, &ecx, &edx);
+
+	return edx;
+}
+
 static __always_inline bool cpuid_function_is_indexed(u32 function)
 {
 	switch (function) {
@@ -31,4 +150,22 @@ static __always_inline bool cpuid_function_is_indexed(u32 function)
 	return false;
 }
 
+#define for_each_possible_hypervisor_cpuid_base(function) \
+	for (function = 0x40000000; function < 0x40010000; function += 0x100)
+
+static inline uint32_t hypervisor_cpuid_base(const char *sig, uint32_t leaves)
+{
+	uint32_t base, eax, signature[3];
+
+	for_each_possible_hypervisor_cpuid_base(base) {
+		cpuid(base, &eax, &signature[0], &signature[1], &signature[2]);
+
+		if (!memcmp(sig, signature, 12) &&
+		    (leaves == 0 || ((eax - base) >= leaves)))
+			return base;
+	}
+
+	return 0;
+}
+
 #endif /* _ASM_X86_CPUID_H */
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 67c9d73..6836c64 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -16,6 +16,7 @@ struct vm86;
 #include <uapi/asm/sigcontext.h>
 #include <asm/current.h>
 #include <asm/cpufeatures.h>
+#include <asm/cpuid.h>
 #include <asm/page.h>
 #include <asm/pgtable_types.h>
 #include <asm/percpu.h>
@@ -146,17 +147,6 @@ struct cpuinfo_x86 {
 	unsigned		initialized : 1;
 } __randomize_layout;
 
-struct cpuid_regs {
-	u32 eax, ebx, ecx, edx;
-};
-
-enum cpuid_regs_idx {
-	CPUID_EAX = 0,
-	CPUID_EBX,
-	CPUID_ECX,
-	CPUID_EDX,
-};
-
 #define X86_VENDOR_INTEL	0
 #define X86_VENDOR_CYRIX	1
 #define X86_VENDOR_AMD		2
@@ -205,45 +195,6 @@ extern void identify_secondary_cpu(struct cpuinfo_x86 *);
 extern void print_cpu_info(struct cpuinfo_x86 *);
 void print_cpu_msr(struct cpuinfo_x86 *);
 
-#ifdef CONFIG_X86_32
-extern int have_cpuid_p(void);
-#else
-static inline int have_cpuid_p(void)
-{
-	return 1;
-}
-#endif
-static inline void native_cpuid(unsigned int *eax, unsigned int *ebx,
-				unsigned int *ecx, unsigned int *edx)
-{
-	/* ecx is often an input as well as an output. */
-	asm volatile("cpuid"
-	    : "=a" (*eax),
-	      "=b" (*ebx),
-	      "=c" (*ecx),
-	      "=d" (*edx)
-	    : "0" (*eax), "2" (*ecx)
-	    : "memory");
-}
-
-#define native_cpuid_reg(reg)					\
-static inline unsigned int native_cpuid_##reg(unsigned int op)	\
-{								\
-	unsigned int eax = op, ebx, ecx = 0, edx;		\
-								\
-	native_cpuid(&eax, &ebx, &ecx, &edx);			\
-								\
-	return reg;						\
-}
-
-/*
- * Native CPUID functions returning a single datum.
- */
-native_cpuid_reg(eax)
-native_cpuid_reg(ebx)
-native_cpuid_reg(ecx)
-native_cpuid_reg(edx)
-
 /*
  * Friendlier CR3 helpers.
  */
@@ -578,7 +529,6 @@ static __always_inline bool on_thread_stack(void)
 #ifdef CONFIG_PARAVIRT_XXL
 #include <asm/paravirt.h>
 #else
-#define __cpuid			native_cpuid
 
 static inline void load_sp0(unsigned long sp0)
 {
@@ -589,69 +539,6 @@ static inline void load_sp0(unsigned long sp0)
 
 unsigned long __get_wchan(struct task_struct *p);
 
-/*
- * Generic CPUID function
- * clear %ecx since some cpus (Cyrix MII) do not set or clear %ecx
- * resulting in stale register contents being returned.
- */
-static inline void cpuid(unsigned int op,
-			 unsigned int *eax, unsigned int *ebx,
-			 unsigned int *ecx, unsigned int *edx)
-{
-	*eax = op;
-	*ecx = 0;
-	__cpuid(eax, ebx, ecx, edx);
-}
-
-/* Some CPUID calls want 'count' to be placed in ecx */
-static inline void cpuid_count(unsigned int op, int count,
-			       unsigned int *eax, unsigned int *ebx,
-			       unsigned int *ecx, unsigned int *edx)
-{
-	*eax = op;
-	*ecx = count;
-	__cpuid(eax, ebx, ecx, edx);
-}
-
-/*
- * CPUID functions returning a single datum
- */
-static inline unsigned int cpuid_eax(unsigned int op)
-{
-	unsigned int eax, ebx, ecx, edx;
-
-	cpuid(op, &eax, &ebx, &ecx, &edx);
-
-	return eax;
-}
-
-static inline unsigned int cpuid_ebx(unsigned int op)
-{
-	unsigned int eax, ebx, ecx, edx;
-
-	cpuid(op, &eax, &ebx, &ecx, &edx);
-
-	return ebx;
-}
-
-static inline unsigned int cpuid_ecx(unsigned int op)
-{
-	unsigned int eax, ebx, ecx, edx;
-
-	cpuid(op, &eax, &ebx, &ecx, &edx);
-
-	return ecx;
-}
-
-static inline unsigned int cpuid_edx(unsigned int op)
-{
-	unsigned int eax, ebx, ecx, edx;
-
-	cpuid(op, &eax, &ebx, &ecx, &edx);
-
-	return edx;
-}
-
 extern void select_idle_routine(const struct cpuinfo_x86 *c);
 extern void amd_e400_c1e_apic_setup(void);
 
@@ -805,24 +692,6 @@ static inline u32 amd_get_nodes_per_socket(void)	{ return 0; }
 static inline u32 amd_get_highest_perf(void)		{ return 0; }
 #endif
 
-#define for_each_possible_hypervisor_cpuid_base(function) \
-	for (function = 0x40000000; function < 0x40010000; function += 0x100)
-
-static inline uint32_t hypervisor_cpuid_base(const char *sig, uint32_t leaves)
-{
-	uint32_t base, eax, signature[3];
-
-	for_each_possible_hypervisor_cpuid_base(base) {
-		cpuid(base, &eax, &signature[0], &signature[1], &signature[2]);
-
-		if (!memcmp(sig, signature, 12) &&
-		    (leaves == 0 || ((eax - base) >= leaves)))
-			return base;
-	}
-
-	return 0;
-}
-
 extern unsigned long arch_align_stack(unsigned long sp);
 void free_init_pages(const char *what, unsigned long begin, unsigned long end);
 extern void free_kernel_image_pages(const char *what, void *begin, void *end);
