Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4CFD687663
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 08:32:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbjBBHcM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 02:32:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjBBHcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 02:32:10 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C32B79F27
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 23:32:09 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id ha3-20020a17090af3c300b00230222051a6so1005537pjb.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Feb 2023 23:32:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pbd4MZHsiULdUR359ojLBIAjtvO1jr9zQzzGbH8lc2I=;
        b=c7qz3Xm43EOdvxhAg2kglrpK7w69x6NXU0683wUB8k24bVzmdjZkhS9hg8pk4QZVjK
         HZ68jI30Gj3ABe1GPXaeKXcqyFeqCJWM4xxJxEN+rldJPq4A7mHnWSPV1oCIHqxMI+Zx
         34+FRsb/4qen45qmPaq3Is+SCRxTZASELP+Brxn86RBeWCrmYfhO5pzsSmKUdRje8m4F
         0kjKJsycKJSmDBL0bY0TJFcO70k4QqX681urqKfOMWaIwCWpM33+aVhB6CY3k8cnYloy
         BRebmiflvKyg5XMkWT8ARX5+BP3Di1v6vfqsmkCFjUgZmkcc5SdUEJJIsZHHIfnApQ+4
         q7Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pbd4MZHsiULdUR359ojLBIAjtvO1jr9zQzzGbH8lc2I=;
        b=xNryifgi/QC/2Scs4W62+L1YU/hBcWiGwt7VOohhMRs28POyNXUWG21gdMTauJyt0u
         2xSDCTYVJx8HOu/N1rntBoQ4WWZkpwgreoxbEDU6cZ1axXHBSp78Q3BJVT6bzKitXN5T
         Rn7UsQIBy1RjIgy/0u0dbS/k4qOlxYZ2CMvrymdf6X/cvk2tnT3yx/zTFpR6bcV71IED
         TM+BuzFEFmAcUOHKcw51JQYWIsTprxsAGx1X2rjYmNaCcPAodJPgyc46HQ9CiHc7+zBS
         hKGo4UYXnrKYfLm9h2+LGrxTjLRxXvPW7PKrxDqmGXjQZ7OCiJ/GSxw/vSNv9TSfmdbG
         IIiw==
X-Gm-Message-State: AO0yUKUyNdrMS55SjhpDQSFchvnnBJFAYSRHO9BInSVB/VYdgDtGAdlJ
        tuT9gXpfLvw3gN02OOSFxOIwMQ==
X-Google-Smtp-Source: AK7set8tKyTpkj0ZXvECd9oUs8GVhp0d9osE3pKU1MLtVb6u22AP3K2FPXbaHngjMj1iLyaFia6c0Q==
X-Received: by 2002:a17:902:d292:b0:197:90f8:f3b with SMTP id t18-20020a170902d29200b0019790f80f3bmr5040697plc.57.1675323128769;
        Wed, 01 Feb 2023 23:32:08 -0800 (PST)
Received: from sumit-X1.. ([223.178.209.222])
        by smtp.gmail.com with ESMTPSA id o17-20020a170902d4d100b00196077ba463sm12959015plg.123.2023.02.01.23.32.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 23:32:08 -0800 (PST)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     will@kernel.org, catalin.marinas@arm.com
Cc:     mark.rutland@arm.com, daniel.thompson@linaro.org,
        dianders@chromium.org, liwei391@huawei.com, mhiramat@kernel.org,
        maz@kernel.org, ardb@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v6 1/2] arm64: entry: Skip single stepping into interrupt handlers
Date:   Thu,  2 Feb 2023 13:01:47 +0530
Message-Id: <20230202073148.657746-2-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230202073148.657746-1-sumit.garg@linaro.org>
References: <20230202073148.657746-1-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_BL_SPAMCOP_NET,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently on systems where the timer interrupt (or any other
fast-at-human-scale periodic interrupt) is active then it is impossible
to step any code with interrupts unlocked because we will always end up
stepping into the timer interrupt instead of stepping the user code.

The common user's goal while single stepping is that when they step then
the system will stop at PC+4 or PC+I for a branch that gets taken
relative to the instruction they are stepping. So, fix broken single step
implementation via skipping single stepping into interrupt handlers.

The methodology is when we receive an interrupt from EL1, check if we
are single stepping (pstate.SS). If yes then we save MDSCR_EL1.SS and
clear the register bit if it was set. Then unmask only D and leave I set.
On return from the interrupt, set D and restore MDSCR_EL1.SS. Along with
this skip reschedule if we were stepping.

Suggested-by: Will Deacon <will@kernel.org>
Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
Tested-by: Douglas Anderson <dianders@chromium.org>
Acked-by: Daniel Thompson <daniel.thompson@linaro.org>
Tested-by: Daniel Thompson <daniel.thompson@linaro.org>
---
 arch/arm64/kernel/entry-common.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
index cce1167199e3..568481f66977 100644
--- a/arch/arm64/kernel/entry-common.c
+++ b/arch/arm64/kernel/entry-common.c
@@ -231,11 +231,15 @@ DEFINE_STATIC_KEY_TRUE(sk_dynamic_irqentry_exit_cond_resched);
 #define need_irq_preemption()	(IS_ENABLED(CONFIG_PREEMPTION))
 #endif
 
-static void __sched arm64_preempt_schedule_irq(void)
+static void __sched arm64_preempt_schedule_irq(struct pt_regs *regs)
 {
 	if (!need_irq_preemption())
 		return;
 
+	/* Don't reschedule in case we are single stepping */
+	if (regs->pstate & DBG_SPSR_SS)
+		return;
+
 	/*
 	 * Note: thread_info::preempt_count includes both thread_info::count
 	 * and thread_info::need_resched, and is not equivalent to
@@ -471,19 +475,33 @@ static __always_inline void __el1_irq(struct pt_regs *regs,
 	do_interrupt_handler(regs, handler);
 	irq_exit_rcu();
 
-	arm64_preempt_schedule_irq();
+	arm64_preempt_schedule_irq(regs);
 
 	exit_to_kernel_mode(regs);
 }
+
 static void noinstr el1_interrupt(struct pt_regs *regs,
 				  void (*handler)(struct pt_regs *))
 {
+	unsigned long mdscr;
+
+	/* Disable single stepping within interrupt handler */
+	if (regs->pstate & DBG_SPSR_SS) {
+		mdscr = read_sysreg(mdscr_el1);
+		write_sysreg(mdscr & ~DBG_MDSCR_SS, mdscr_el1);
+	}
+
 	write_sysreg(DAIF_PROCCTX_NOIRQ, daif);
 
 	if (IS_ENABLED(CONFIG_ARM64_PSEUDO_NMI) && !interrupts_enabled(regs))
 		__el1_pnmi(regs, handler);
 	else
 		__el1_irq(regs, handler);
+
+	if (regs->pstate & DBG_SPSR_SS) {
+		write_sysreg(DAIF_PROCCTX_NOIRQ | PSR_D_BIT, daif);
+		write_sysreg(mdscr, mdscr_el1);
+	}
 }
 
 asmlinkage void noinstr el1h_64_irq_handler(struct pt_regs *regs)
-- 
2.34.1

