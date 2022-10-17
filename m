Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90EA060120D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 16:58:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231549AbiJQO6R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 10:58:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231299AbiJQO46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 10:56:58 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B44E69F60;
        Mon, 17 Oct 2022 07:54:59 -0700 (PDT)
Date:   Mon, 17 Oct 2022 14:54:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1666018461;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IRJgDf5Wkhaip4yrP3UayGGKJm3M2nkgMjilqIVDrd0=;
        b=MmziDJS4nKYDnAEfHwdZhL/f7Swm7Cur4h3EYWJbdeJuLrDU2qLdf6jWzxNO68tbuC9Pt4
        fP/t7eqqhhMJbcSDweBJQs4VFqvfXntXz/XngeRer3GlFP0WFQHwt/Pbgf7v9OnLUtPM62
        g9pC3AGtHZ/Uu/IXmZSNcu75AsZ2EbsjXPia/2o2juYL0qIa7k0cWWMD8SJ8e95uIuKGlT
        2C1BLjjcUr2BkK8wGTze23guMtjb0Jo/ZUtboA7M1wJIhINMTnQAI227qiJ6mJEY0SIsQn
        dNUovAILDefkUnQ9uTatqc30q7wHy6frVIPi1y8hgNxhO9tf0OGLMJattF+feg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1666018461;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IRJgDf5Wkhaip4yrP3UayGGKJm3M2nkgMjilqIVDrd0=;
        b=jeceQm/4Or8p1RMztUBejRFxr89hRY2NL2zGo377hsQzWz7kqEgbuNiI2Ysn8dRnjRoGty
        kqFJ1u82a6WAMdCA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/entry: Align SYM_CODE_START() variants
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220915111144.144068841@infradead.org>
References: <20220915111144.144068841@infradead.org>
MIME-Version: 1.0
Message-ID: <166601846032.401.11080993772184847437.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     67e93ddd5d0b84ac17bddb13d98533e425282421
Gitweb:        https://git.kernel.org/tip/67e93ddd5d0b84ac17bddb13d98533e425282421
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 15 Sep 2022 13:10:51 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 17 Oct 2022 16:41:00 +02:00

x86/entry: Align SYM_CODE_START() variants

Explicitly align a bunch of commonly called SYM_CODE_START() symbols.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20220915111144.144068841@infradead.org
---
 arch/x86/entry/entry_64.S | 16 ++++++++++------
 arch/x86/entry/thunk_64.S |  4 ++--
 2 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 9953d96..e635f96 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -284,7 +284,8 @@ SYM_FUNC_END(__switch_to_asm)
  * r12: kernel thread arg
  */
 .pushsection .text, "ax"
-SYM_CODE_START(ret_from_fork)
+	__FUNC_ALIGN
+SYM_CODE_START_NOALIGN(ret_from_fork)
 	UNWIND_HINT_EMPTY
 	ANNOTATE_NOENDBR // copy_thread
 	movq	%rax, %rdi
@@ -600,13 +601,13 @@ SYM_CODE_END(\asmsym)
  * shared between 32 and 64 bit and emit the __irqentry_text_* markers
  * so the stacktrace boundary checks work.
  */
-	.align 16
+	__ALIGN
 	.globl __irqentry_text_start
 __irqentry_text_start:
 
 #include <asm/idtentry.h>
 
-	.align 16
+	__ALIGN
 	.globl __irqentry_text_end
 __irqentry_text_end:
 	ANNOTATE_NOENDBR
@@ -828,7 +829,8 @@ EXPORT_SYMBOL(asm_load_gs_index)
  *
  * C calling convention: exc_xen_hypervisor_callback(struct *pt_regs)
  */
-SYM_CODE_START_LOCAL(exc_xen_hypervisor_callback)
+	__FUNC_ALIGN
+SYM_CODE_START_LOCAL_NOALIGN(exc_xen_hypervisor_callback)
 
 /*
  * Since we don't modify %rdi, evtchn_do_upall(struct *pt_regs) will
@@ -856,7 +858,8 @@ SYM_CODE_END(exc_xen_hypervisor_callback)
  * We distinguish between categories by comparing each saved segment register
  * with its current contents: any discrepancy means we in category 1.
  */
-SYM_CODE_START(xen_failsafe_callback)
+	__FUNC_ALIGN
+SYM_CODE_START_NOALIGN(xen_failsafe_callback)
 	UNWIND_HINT_EMPTY
 	ENDBR
 	movl	%ds, %ecx
@@ -1516,7 +1519,8 @@ SYM_CODE_END(ignore_sysret)
 #endif
 
 .pushsection .text, "ax"
-SYM_CODE_START(rewind_stack_and_make_dead)
+	__FUNC_ALIGN
+SYM_CODE_START_NOALIGN(rewind_stack_and_make_dead)
 	UNWIND_HINT_FUNC
 	/* Prevent any naive code from trying to unwind to our caller. */
 	xorl	%ebp, %ebp
diff --git a/arch/x86/entry/thunk_64.S b/arch/x86/entry/thunk_64.S
index f38b07d..5e37f41 100644
--- a/arch/x86/entry/thunk_64.S
+++ b/arch/x86/entry/thunk_64.S
@@ -11,7 +11,7 @@
 
 	/* rdi:	arg1 ... normal C conventions. rax is saved/restored. */
 	.macro THUNK name, func
-SYM_FUNC_START_NOALIGN(\name)
+SYM_FUNC_START(\name)
 	pushq %rbp
 	movq %rsp, %rbp
 
@@ -36,7 +36,7 @@ SYM_FUNC_END(\name)
 	EXPORT_SYMBOL(preempt_schedule_thunk)
 	EXPORT_SYMBOL(preempt_schedule_notrace_thunk)
 
-SYM_CODE_START_LOCAL_NOALIGN(__thunk_restore)
+SYM_CODE_START_LOCAL(__thunk_restore)
 	popq %r11
 	popq %r10
 	popq %r9
