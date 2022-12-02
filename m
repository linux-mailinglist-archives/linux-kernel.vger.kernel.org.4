Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29D7164078A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 14:14:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233041AbiLBNOu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 08:14:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232011AbiLBNOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 08:14:48 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2A4CC2D34;
        Fri,  2 Dec 2022 05:14:46 -0800 (PST)
Date:   Fri, 02 Dec 2022 13:14:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669986885;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h+p2fu6JSCcHY0+/+EgBDL3llyV9MW691Es3BXXbOoA=;
        b=V5rT8kblTn0wGD71Q6TbK7hSlbNG/8Mo3Be3SGLDQmD3haAkUZhav1D52Z6SIqSN05VRfY
        46bpuGHep3wfZdQiFIoShYtBQqPAQpBQnZF0e911wVBjkoh0MdB5C/sw16HYwJSultteUM
        HMztnTn1hMDeJHo76w7V6iA4xUeFeq8FBo6V7F4WQ13KJD+rCy361Zy0CNHxHd6jyCh0cX
        WSgsQL3t6SlHBlMbsmiqp0UJc4eS8OLNFBm7Hu/eLMWV20fper2ZiuClCbEpwYgvLJLcmT
        waxFl1oFhRDTD3k038a9imMPPb/GCztgUkNYkuoeTbyhZ0G2kRnpSO52gvvckA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669986885;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h+p2fu6JSCcHY0+/+EgBDL3llyV9MW691Es3BXXbOoA=;
        b=slJ/mJ+I3cZUWlsJOiQhQgNXk9NEzXEABOwkoFv68OKnxRrTPv6HlD5vTY7jBx/KHbcF6g
        Dzzv79lGg5gS8lAA==
From:   "tip-bot2 for Brian Gerst" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/asm/32: Remove setup_once()
Cc:     Brian Gerst <brgerst@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221115184328.70874-1-brgerst@gmail.com>
References: <20221115184328.70874-1-brgerst@gmail.com>
MIME-Version: 1.0
Message-ID: <166998688334.4906.16854290928005814272.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     ff4c85c05333c6f24d3fe0a344c6dacd18a7ee49
Gitweb:        https://git.kernel.org/tip/ff4c85c05333c6f24d3fe0a344c6dacd18a7ee49
Author:        Brian Gerst <brgerst@gmail.com>
AuthorDate:    Tue, 15 Nov 2022 13:43:28 -05:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 02 Dec 2022 14:06:34 +01:00

x86/asm/32: Remove setup_once()

After the removal of the stack canary segment setup code, this function
does nothing.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20221115184328.70874-1-brgerst@gmail.com

---
 arch/x86/kernel/head_32.S | 22 ----------------------
 1 file changed, 22 deletions(-)

diff --git a/arch/x86/kernel/head_32.S b/arch/x86/kernel/head_32.S
index 9b7acc9..67c8ed9 100644
--- a/arch/x86/kernel/head_32.S
+++ b/arch/x86/kernel/head_32.S
@@ -261,16 +261,6 @@ SYM_FUNC_START(startup_32_smp)
 	addl $__PAGE_OFFSET, %esp
 
 /*
- * start system 32-bit setup. We need to re-do some of the things done
- * in 16-bit mode for the "real" operations.
- */
-	movl setup_once_ref,%eax
-	andl %eax,%eax
-	jz 1f				# Did we do this already?
-	call *%eax
-1:
-
-/*
  * Check if it is 486
  */
 	movb $4,X86			# at least 486
@@ -331,18 +321,7 @@ SYM_FUNC_END(startup_32_smp)
 
 #include "verify_cpu.S"
 
-/*
- *  setup_once
- *
- *  The setup work we only want to run on the BSP.
- *
- *  Warning: %esi is live across this function.
- */
 __INIT
-setup_once:
-	andl $0,setup_once_ref	/* Once is enough, thanks */
-	RET
-
 SYM_FUNC_START(early_idt_handler_array)
 	# 36(%esp) %eflags
 	# 32(%esp) %cs
@@ -458,7 +437,6 @@ SYM_DATA(early_recursion_flag, .long 0)
 __REFDATA
 	.align 4
 SYM_DATA(initial_code,		.long i386_start_kernel)
-SYM_DATA(setup_once_ref,	.long setup_once)
 
 #ifdef CONFIG_PAGE_TABLE_ISOLATION
 #define	PGD_ALIGN	(2 * PAGE_SIZE)
