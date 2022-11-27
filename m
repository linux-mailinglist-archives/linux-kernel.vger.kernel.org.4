Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A44EA639D84
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Nov 2022 23:09:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbiK0WJn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 17:09:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiK0WJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 17:09:41 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACA291BD;
        Sun, 27 Nov 2022 14:09:39 -0800 (PST)
Date:   Sun, 27 Nov 2022 22:09:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669586977;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5WnSODMBbA6Bfa14xT8hm7I0CdPcSERAB6QrKazhsLw=;
        b=vuFXzvpIl5ZDt13KHNR8xFyy45nNsWSdViJayZ2/8nrEmbbROLovZd6VXsoW6V+DIqTtQD
        nnDGjojB5Kj75GGJpAtn1/JNOfRXj9+37ll0FHgmKfDBbll14CG2+zlMaZwpOV7SDr8XGB
        ra7AXGPhxwo2ZnApe/xTxLFxUJfCvGGigJAUdKAWlZaB6TcxoSMb+AmSIudwuCKkT0kx2E
        r8K4ciO/hPJic3g/sh9CspbqPY/197e6nwP5DY6C48VcTUTfkfXoGl4BJgnHUWkWpk2FFM
        ejBJdJNEJefWYwI+erPxjt1UelI6IBiF16869Y8UNdFwNeqVvxx/jhMEYn6t2A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669586977;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5WnSODMBbA6Bfa14xT8hm7I0CdPcSERAB6QrKazhsLw=;
        b=UP2o3OfAd2n9AOYIxbyofxEzrVw8KS9fHn1kt4Xv3MGdP4kAi21i6XT05VK8qIQwEsI/UL
        G3kpKsAxvh9xa+Cw==
From:   "tip-bot2 for Borislav Petkov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Move MSR defines into msr-index.h
Cc:     Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221106212923.20699-1-bp@alien8.de>
References: <20221106212923.20699-1-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <166958697536.4906.10536001538688556050.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     97fa21f65c3eb5bbab9b4734bed37fd624cddd86
Gitweb:        https://git.kernel.org/tip/97fa21f65c3eb5bbab9b4734bed37fd624cddd86
Author:        Borislav Petkov <bp@suse.de>
AuthorDate:    Sun, 06 Nov 2022 22:24:08 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Sun, 27 Nov 2022 23:00:45 +01:00

x86/resctrl: Move MSR defines into msr-index.h

msr-index.h should contain all MSRs for easier grepping for MSR numbers
when dealing with unchecked MSR access warnings, for example.

Move the resctrl ones. Prefix IA32_PQR_ASSOC with "MSR_" while at it.

No functional changes.

Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/20221106212923.20699-1-bp@alien8.de
---
 arch/x86/include/asm/msr-index.h          | 21 +++++++++++++++------
 arch/x86/include/asm/resctrl.h            |  8 +++-----
 arch/x86/kernel/cpu/resctrl/core.c        |  2 +-
 arch/x86/kernel/cpu/resctrl/internal.h    | 10 ----------
 arch/x86/kernel/cpu/resctrl/pseudo_lock.c |  4 ++--
 5 files changed, 21 insertions(+), 24 deletions(-)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 10ac527..9308eb9 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -4,12 +4,7 @@
 
 #include <linux/bits.h>
 
-/*
- * CPU model specific register (MSR) numbers.
- *
- * Do not add new entries to this file unless the definitions are shared
- * between multiple compilation units.
- */
+/* CPU model specific register (MSR) numbers. */
 
 /* x86-64 specific MSRs */
 #define MSR_EFER		0xc0000080 /* extended feature register */
@@ -1050,6 +1045,20 @@
 #define VMX_BASIC_MEM_TYPE_WB	6LLU
 #define VMX_BASIC_INOUT		0x0040000000000000LLU
 
+/* Resctrl MSRs: */
+/* - Intel: */
+#define MSR_IA32_L3_QOS_CFG		0xc81
+#define MSR_IA32_L2_QOS_CFG		0xc82
+#define MSR_IA32_QM_EVTSEL		0xc8d
+#define MSR_IA32_QM_CTR			0xc8e
+#define MSR_IA32_PQR_ASSOC		0xc8f
+#define MSR_IA32_L3_CBM_BASE		0xc90
+#define MSR_IA32_L2_CBM_BASE		0xd10
+#define MSR_IA32_MBA_THRTL_BASE		0xd50
+
+/* - AMD: */
+#define MSR_IA32_MBA_BW_BASE		0xc0000200
+
 /* MSR_IA32_VMX_MISC bits */
 #define MSR_IA32_VMX_MISC_INTEL_PT                 (1ULL << 14)
 #define MSR_IA32_VMX_MISC_VMWRITE_SHADOW_RO_FIELDS (1ULL << 29)
diff --git a/arch/x86/include/asm/resctrl.h b/arch/x86/include/asm/resctrl.h
index d24b04e..52788f7 100644
--- a/arch/x86/include/asm/resctrl.h
+++ b/arch/x86/include/asm/resctrl.h
@@ -7,8 +7,6 @@
 #include <linux/sched.h>
 #include <linux/jump_label.h>
 
-#define IA32_PQR_ASSOC	0x0c8f
-
 /**
  * struct resctrl_pqr_state - State cache for the PQR MSR
  * @cur_rmid:		The cached Resource Monitoring ID
@@ -16,8 +14,8 @@
  * @default_rmid:	The user assigned Resource Monitoring ID
  * @default_closid:	The user assigned cached Class Of Service ID
  *
- * The upper 32 bits of IA32_PQR_ASSOC contain closid and the
- * lower 10 bits rmid. The update to IA32_PQR_ASSOC always
+ * The upper 32 bits of MSR_IA32_PQR_ASSOC contain closid and the
+ * lower 10 bits rmid. The update to MSR_IA32_PQR_ASSOC always
  * contains both parts, so we need to cache them. This also
  * stores the user configured per cpu CLOSID and RMID.
  *
@@ -77,7 +75,7 @@ static void __resctrl_sched_in(void)
 	if (closid != state->cur_closid || rmid != state->cur_rmid) {
 		state->cur_closid = closid;
 		state->cur_rmid = rmid;
-		wrmsr(IA32_PQR_ASSOC, rmid, closid);
+		wrmsr(MSR_IA32_PQR_ASSOC, rmid, closid);
 	}
 }
 
diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 03cfbf0..c98e52f 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -575,7 +575,7 @@ static void clear_closid_rmid(int cpu)
 	state->default_rmid = 0;
 	state->cur_closid = 0;
 	state->cur_rmid = 0;
-	wrmsr(IA32_PQR_ASSOC, 0, 0);
+	wrmsr(MSR_IA32_PQR_ASSOC, 0, 0);
 }
 
 static int resctrl_online_cpu(unsigned int cpu)
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 5f71286..5ebd28e 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -8,16 +8,6 @@
 #include <linux/fs_context.h>
 #include <linux/jump_label.h>
 
-#define MSR_IA32_L3_QOS_CFG		0xc81
-#define MSR_IA32_L2_QOS_CFG		0xc82
-#define MSR_IA32_L3_CBM_BASE		0xc90
-#define MSR_IA32_L2_CBM_BASE		0xd10
-#define MSR_IA32_MBA_THRTL_BASE		0xd50
-#define MSR_IA32_MBA_BW_BASE		0xc0000200
-
-#define MSR_IA32_QM_CTR			0x0c8e
-#define MSR_IA32_QM_EVTSEL		0x0c8d
-
 #define L3_QOS_CDP_ENABLE		0x01ULL
 
 #define L2_QOS_CDP_ENABLE		0x01ULL
diff --git a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
index d961ae3..ba8d076 100644
--- a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
+++ b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
@@ -477,7 +477,7 @@ static int pseudo_lock_fn(void *_rdtgrp)
 	 * pseudo-locked followed by reading of kernel memory to load it
 	 * into the cache.
 	 */
-	__wrmsr(IA32_PQR_ASSOC, rmid_p, rdtgrp->closid);
+	__wrmsr(MSR_IA32_PQR_ASSOC, rmid_p, rdtgrp->closid);
 	/*
 	 * Cache was flushed earlier. Now access kernel memory to read it
 	 * into cache region associated with just activated plr->closid.
@@ -513,7 +513,7 @@ static int pseudo_lock_fn(void *_rdtgrp)
 	 * Critical section end: restore closid with capacity bitmask that
 	 * does not overlap with pseudo-locked region.
 	 */
-	__wrmsr(IA32_PQR_ASSOC, rmid_p, closid_p);
+	__wrmsr(MSR_IA32_PQR_ASSOC, rmid_p, closid_p);
 
 	/* Re-enable the hardware prefetcher(s) */
 	wrmsrl(MSR_MISC_FEATURE_CONTROL, saved_msr);
