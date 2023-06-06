Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86026723BB7
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 10:28:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237217AbjFFI2D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 04:28:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236855AbjFFI0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 04:26:38 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3FA9E7B;
        Tue,  6 Jun 2023 01:26:29 -0700 (PDT)
Date:   Tue, 06 Jun 2023 08:26:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686039984;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gSpHO4Vk4xeLSiEnA0YqKwAala7mS3mcfnE/HMnWXCQ=;
        b=t/YRPKG4nF5j7kqolvx9YhR93FHn43fxkjvmj+zjW3nYh2oKd8S4SlY6biuCTVj4kd+Tlt
        iR1/8w/YX0fUpiEXyPE9dIX5dm1apuNSmR6MdcUIatHFslu+xwgREUrSvBfzIEkHhCSH5L
        Bfh0Yl+x4sMxqTdVfi9LgrI0TW2Rl6HB9Un2fVgv2rYBMVQYHz7XsIJq+yNgJBDJTdP2I1
        z00Bl9QdCpMkEqbuCz4MOcYd2DLezZ5XqeK+D2mWaQdeD0Cd8TtfhvhrEMA8PxooILD3Mq
        NOJPmv/1Tl4CTpj0u+UsoyUWTAx29LIvlmTHIC1fZfL58nGMH+Pu5WWk3DmqyQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686039984;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gSpHO4Vk4xeLSiEnA0YqKwAala7mS3mcfnE/HMnWXCQ=;
        b=j2ZO3wdfsu064g0ZJfQW5XfEhQQv6Rpy/ti4hkv61FSTC7AoYZ0dYPZzMZqTz/0zwQZYOG
        DUXQ+RCD88vJQXDA==
From:   "tip-bot2 for Mark Rutland" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/atomic: arc: add preprocessor symbols
Cc:     Mark Rutland <mark.rutland@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230605070124.3741859-6-mark.rutland@arm.com>
References: <20230605070124.3741859-6-mark.rutland@arm.com>
MIME-Version: 1.0
Message-ID: <168603998443.404.13672376626762271875.tip-bot2@tip-bot2>
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

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     f739287ef57bc01155e556033462e9a6ff020c97
Gitweb:        https://git.kernel.org/tip/f739287ef57bc01155e556033462e9a6ff020c97
Author:        Mark Rutland <mark.rutland@arm.com>
AuthorDate:    Mon, 05 Jun 2023 08:01:02 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 05 Jun 2023 09:57:14 +02:00

locking/atomic: arc: add preprocessor symbols

Some atomics can be implemented in several different ways, e.g.
FULL/ACQUIRE/RELEASE ordered atomics can be implemented in terms of
RELAXED atomics, and ACQUIRE/RELEASE/RELAXED can be implemented in terms
of FULL ordered atomics. Other atomics are optional, and don't exist in
some configurations (e.g. not all architectures implement the 128-bit
cmpxchg ops).

Subsequent patches will require that architectures define a preprocessor
symbol for any atomic (or ordering variant) which is optional. This will
make the fallback ifdeffery more robust, and simplify future changes.

Add the required definitions to arch/arc.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Link: https://lore.kernel.org/r/20230605070124.3741859-6-mark.rutland@arm.com
---
 arch/arc/include/asm/atomic-spinlock.h |  9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arc/include/asm/atomic-spinlock.h b/arch/arc/include/asm/atomic-spinlock.h
index 2c83034..89d12a6 100644
--- a/arch/arc/include/asm/atomic-spinlock.h
+++ b/arch/arc/include/asm/atomic-spinlock.h
@@ -81,6 +81,11 @@ static inline int arch_atomic_fetch_##op(int i, atomic_t *v)		\
 ATOMIC_OPS(add, +=, add)
 ATOMIC_OPS(sub, -=, sub)
 
+#define arch_atomic_fetch_add		arch_atomic_fetch_add
+#define arch_atomic_fetch_sub		arch_atomic_fetch_sub
+#define arch_atomic_add_return		arch_atomic_add_return
+#define arch_atomic_sub_return		arch_atomic_sub_return
+
 #undef ATOMIC_OPS
 #define ATOMIC_OPS(op, c_op, asm_op)					\
 	ATOMIC_OP(op, c_op, asm_op)					\
@@ -92,7 +97,11 @@ ATOMIC_OPS(or, |=, or)
 ATOMIC_OPS(xor, ^=, xor)
 
 #define arch_atomic_andnot		arch_atomic_andnot
+
+#define arch_atomic_fetch_and		arch_atomic_fetch_and
 #define arch_atomic_fetch_andnot	arch_atomic_fetch_andnot
+#define arch_atomic_fetch_or		arch_atomic_fetch_or
+#define arch_atomic_fetch_xor		arch_atomic_fetch_xor
 
 #undef ATOMIC_OPS
 #undef ATOMIC_FETCH_OP
