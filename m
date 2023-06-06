Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E05D3723BB0
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 10:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236929AbjFFI1m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 04:27:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236778AbjFFI0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 04:26:37 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40F27E5F;
        Tue,  6 Jun 2023 01:26:26 -0700 (PDT)
Date:   Tue, 06 Jun 2023 08:26:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686039982;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5Ui+Ud7wkq4QL5en5S6OXWeSXWqR7zswHYkvuQHf7Jg=;
        b=PV8Od2pE27uK0Ko9898rlXVpE++GXxrSPlpG2t1gpYJHqvm97esHXR+ljkYBGNPPVbEAdU
        upAUy9hguN6uMisRrxBllo6f9AWTm4GfXcq/P1GYhR2Y9YcWvGgtLGKUQjDA0mGg6iaH7J
        +35JGqKwddN1AS0pa/TKbk1Eku0Z/vOMZb1Pc1mWaS97SERJVqfX5Al6rWm5m48GQbUVDK
        8Es0gbCftlExxS0PiRSZqVEAkBHRwYxqIwZMQkesWrUdVoTI7ZQGMuIcPQyVR35oP+qT2m
        WWrrvyM7BvnNNhjWPS0jEYyEFE7ikV+0sMs3YivolgMiPxdPc44fN3LhK1QX/g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686039982;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5Ui+Ud7wkq4QL5en5S6OXWeSXWqR7zswHYkvuQHf7Jg=;
        b=xmsKoM15u58R2+TfkiP1XQJcWgUSK4ymfAV3ppaV0SJOllWN0X6u3KhVt55lua4kvHgwHy
        X+kBxYNyNSGZMVBg==
From:   "tip-bot2 for Mark Rutland" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/atomic: sparc: add preprocessor symbols
Cc:     Mark Rutland <mark.rutland@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230605070124.3741859-12-mark.rutland@arm.com>
References: <20230605070124.3741859-12-mark.rutland@arm.com>
MIME-Version: 1.0
Message-ID: <168603998216.404.17373423050894332901.tip-bot2@tip-bot2>
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

Commit-ID:     358c449afa662b1120d43738d2b0400ed2cc97df
Gitweb:        https://git.kernel.org/tip/358c449afa662b1120d43738d2b0400ed2cc97df
Author:        Mark Rutland <mark.rutland@arm.com>
AuthorDate:    Mon, 05 Jun 2023 08:01:08 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 05 Jun 2023 09:57:17 +02:00

locking/atomic: sparc: add preprocessor symbols

Some atomics can be implemented in several different ways, e.g.
FULL/ACQUIRE/RELEASE ordered atomics can be implemented in terms of
RELAXED atomics, and ACQUIRE/RELEASE/RELAXED can be implemented in terms
of FULL ordered atomics. Other atomics are optional, and don't exist in
some configurations (e.g. not all architectures implement the 128-bit
cmpxchg ops).

Subsequent patches will require that architectures define a preprocessor
symbol for any atomic (or ordering variant) which is optional. This will
make the fallback ifdeffery more robust, and simplify future changes.

Add the required definitions to arch/sparc.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Link: https://lore.kernel.org/r/20230605070124.3741859-12-mark.rutland@arm.com
---
 arch/sparc/include/asm/atomic_32.h | 16 ++++++++++++++--
 arch/sparc/include/asm/atomic_64.h | 18 ++++++++++++++++++
 2 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/include/asm/atomic_32.h b/arch/sparc/include/asm/atomic_32.h
index 1c9e6c7..60ce2fe 100644
--- a/arch/sparc/include/asm/atomic_32.h
+++ b/arch/sparc/include/asm/atomic_32.h
@@ -19,19 +19,31 @@
 #include <asm-generic/atomic64.h>
 
 int arch_atomic_add_return(int, atomic_t *);
+#define arch_atomic_add_return arch_atomic_add_return
+
 int arch_atomic_fetch_add(int, atomic_t *);
+#define arch_atomic_fetch_add arch_atomic_fetch_add
+
 int arch_atomic_fetch_and(int, atomic_t *);
+#define arch_atomic_fetch_and arch_atomic_fetch_and
+
 int arch_atomic_fetch_or(int, atomic_t *);
+#define arch_atomic_fetch_or arch_atomic_fetch_or
+
 int arch_atomic_fetch_xor(int, atomic_t *);
+#define arch_atomic_fetch_xor arch_atomic_fetch_xor
+
 int arch_atomic_cmpxchg(atomic_t *, int, int);
 #define arch_atomic_cmpxchg arch_atomic_cmpxchg
+
 int arch_atomic_xchg(atomic_t *, int);
 #define arch_atomic_xchg arch_atomic_xchg
-int arch_atomic_fetch_add_unless(atomic_t *, int, int);
-void arch_atomic_set(atomic_t *, int);
 
+int arch_atomic_fetch_add_unless(atomic_t *, int, int);
 #define arch_atomic_fetch_add_unless arch_atomic_fetch_add_unless
 
+void arch_atomic_set(atomic_t *, int);
+
 #define arch_atomic_set_release(v, i)	arch_atomic_set((v), (i))
 
 #define arch_atomic_read(v)		READ_ONCE((v)->counter)
diff --git a/arch/sparc/include/asm/atomic_64.h b/arch/sparc/include/asm/atomic_64.h
index df6a8b0..a5e9c37 100644
--- a/arch/sparc/include/asm/atomic_64.h
+++ b/arch/sparc/include/asm/atomic_64.h
@@ -37,6 +37,16 @@ s64 arch_atomic64_fetch_##op(s64, atomic64_t *);
 ATOMIC_OPS(add)
 ATOMIC_OPS(sub)
 
+#define arch_atomic_add_return			arch_atomic_add_return
+#define arch_atomic_sub_return			arch_atomic_sub_return
+#define arch_atomic_fetch_add			arch_atomic_fetch_add
+#define arch_atomic_fetch_sub			arch_atomic_fetch_sub
+
+#define arch_atomic64_add_return		arch_atomic64_add_return
+#define arch_atomic64_sub_return		arch_atomic64_sub_return
+#define arch_atomic64_fetch_add			arch_atomic64_fetch_add
+#define arch_atomic64_fetch_sub			arch_atomic64_fetch_sub
+
 #undef ATOMIC_OPS
 #define ATOMIC_OPS(op) ATOMIC_OP(op) ATOMIC_FETCH_OP(op)
 
@@ -44,6 +54,14 @@ ATOMIC_OPS(and)
 ATOMIC_OPS(or)
 ATOMIC_OPS(xor)
 
+#define arch_atomic_fetch_and			arch_atomic_fetch_and
+#define arch_atomic_fetch_or			arch_atomic_fetch_or
+#define arch_atomic_fetch_xor			arch_atomic_fetch_xor
+
+#define arch_atomic64_fetch_and			arch_atomic64_fetch_and
+#define arch_atomic64_fetch_or			arch_atomic64_fetch_or
+#define arch_atomic64_fetch_xor			arch_atomic64_fetch_xor
+
 #undef ATOMIC_OPS
 #undef ATOMIC_FETCH_OP
 #undef ATOMIC_OP_RETURN
