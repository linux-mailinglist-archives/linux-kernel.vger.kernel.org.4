Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 953E4732B68
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 11:25:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343607AbjFPJZ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 05:25:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344013AbjFPJYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 05:24:50 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52F16270B;
        Fri, 16 Jun 2023 02:24:44 -0700 (PDT)
Date:   Fri, 16 Jun 2023 09:24:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686907483;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fxx0RCeiy6dviDtKxpkuqCnwNAMerbl/5Xrn8t4hSfI=;
        b=Vbosa4fEQnUQoxrubEOMLme/iPI/p1ltj8yIK6I4ultZOLQ6ABdijFuJss6c9RgrstkxoJ
        ODITBOWT/FAfwnwUxZniKVcAZDsXjIUJ9vr1GaSpxZ0D+wil3p1p+59L6tMbdrO6L+htX3
        ivHu9FlOnfl7t/NOaboDGFr+B5ciNmgFc1HIxuBVzZ2uTnvIYOzb5E53Kn9IyteSoXpka1
        f5zSTKjqe5aoQ7sYo2PvmXYCIbHeTxKGbflbsyTR+WfP/7nTrWyDUrQjotM8ExekMZ/Ls3
        IGG9sdGe1kOl0riBYXlJR6bfsHlah2JgNR0yI2Rm8kixTtiXDqjlMZh4OsPMeA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686907483;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fxx0RCeiy6dviDtKxpkuqCnwNAMerbl/5Xrn8t4hSfI=;
        b=MBq6okTPzj+u2vszI0WRZs2fpVOjpW8kWNHUzMWExTAb2LtckRqEcMrnwN48nVYjs5/WMz
        E4DxQmcEF4bdGJDA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] x86/fpu: Remove cpuinfo argument from init functions
Cc:     Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230613224545.783704297@linutronix.de>
References: <20230613224545.783704297@linutronix.de>
MIME-Version: 1.0
Message-ID: <168690748250.404.15732608028451702185.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     1f34bb2a24643e0087652d81078e4f616562738d
Gitweb:        https://git.kernel.org/tip/1f34bb2a24643e0087652d81078e4f616562738d
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 14 Jun 2023 01:39:43 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 16 Jun 2023 10:16:01 +02:00

x86/fpu: Remove cpuinfo argument from init functions

Nothing in the call chain requires it

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20230613224545.783704297@linutronix.de

---
 arch/x86/include/asm/fpu/api.h | 2 +-
 arch/x86/kernel/cpu/common.c   | 2 +-
 arch/x86/kernel/fpu/init.c     | 6 +++---
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/fpu/api.h b/arch/x86/include/asm/fpu/api.h
index 503a577..b475d9a 100644
--- a/arch/x86/include/asm/fpu/api.h
+++ b/arch/x86/include/asm/fpu/api.h
@@ -109,7 +109,7 @@ extern void fpu_reset_from_exception_fixup(void);
 
 /* Boot, hotplug and resume */
 extern void fpu__init_cpu(void);
-extern void fpu__init_system(struct cpuinfo_x86 *c);
+extern void fpu__init_system(void);
 extern void fpu__init_check_bugs(void);
 extern void fpu__resume_cpu(void);
 
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index b8a4db1..2807e5b 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1604,7 +1604,7 @@ static void __init early_identify_cpu(struct cpuinfo_x86 *c)
 
 	sld_setup(c);
 
-	fpu__init_system(c);
+	fpu__init_system();
 
 #ifdef CONFIG_X86_32
 	/*
diff --git a/arch/x86/kernel/fpu/init.c b/arch/x86/kernel/fpu/init.c
index 851eb13..5001df9 100644
--- a/arch/x86/kernel/fpu/init.c
+++ b/arch/x86/kernel/fpu/init.c
@@ -71,7 +71,7 @@ static bool fpu__probe_without_cpuid(void)
 	return fsw == 0 && (fcw & 0x103f) == 0x003f;
 }
 
-static void fpu__init_system_early_generic(struct cpuinfo_x86 *c)
+static void fpu__init_system_early_generic(void)
 {
 	if (!boot_cpu_has(X86_FEATURE_CPUID) &&
 	    !test_bit(X86_FEATURE_FPU, (unsigned long *)cpu_caps_cleared)) {
@@ -211,10 +211,10 @@ static void __init fpu__init_system_xstate_size_legacy(void)
  * Called on the boot CPU once per system bootup, to set up the initial
  * FPU state that is later cloned into all processes:
  */
-void __init fpu__init_system(struct cpuinfo_x86 *c)
+void __init fpu__init_system(void)
 {
 	fpstate_reset(&current->thread.fpu);
-	fpu__init_system_early_generic(c);
+	fpu__init_system_early_generic();
 
 	/*
 	 * The FPU has to be operational for some of the
