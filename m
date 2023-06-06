Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE248723B80
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 10:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236747AbjFFI00 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 04:26:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236619AbjFFI0T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 04:26:19 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 048B2E8;
        Tue,  6 Jun 2023 01:26:16 -0700 (PDT)
Date:   Tue, 06 Jun 2023 08:26:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686039975;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9TK1wlccTM/oew9VGNxJ3LUXzLB8jpUa9eTaVhUIacc=;
        b=MdQPMhuNGrDNqVLsUqHV9QOoU7GPGmK7kP1Znl/alZcROSFFdOSvUpuZz99ZT4eiMkkSMA
        +0b2P+XOHlaB5FGxLcc8CPTV1gLAVUP7r8PJr8g8fJIQO58N3VgV5QCz3MFhc+4xh12aIr
        DeJ3xxQ9hDTsRGrN4kolY1Ba9s6uI1aS2n13ZLIiDbqWrMRLNwQxAmslmmH9vmWmzkZpHP
        CnQ+RGzF/C136HmEjYKO532yrYV/7ZA2MppAHNRZgBLlLtSW4hwruM1d08wimBXy+grXwc
        OE596FIoiwq7JEb9ntyJgB7HUOqy14XvMhBSOka6FtEctZkfZyCCmD6o8EemMQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686039975;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9TK1wlccTM/oew9VGNxJ3LUXzLB8jpUa9eTaVhUIacc=;
        b=7229X6zvtk94WQFtRV7SSWWHhR+PH+tFmfdyOAtPuhrlKV2SKz5mFH4Z63Ir6AH+sSWLqr
        VeeFeX520Zd9BrDw==
From:   "tip-bot2 for Mark Rutland" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/atomic: treewide: delete arch_atomic_*()
 kerneldoc
Cc:     Mark Rutland <mark.rutland@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230605070124.3741859-28-mark.rutland@arm.com>
References: <20230605070124.3741859-28-mark.rutland@arm.com>
MIME-Version: 1.0
Message-ID: <168603997447.404.5216233293564519123.tip-bot2@tip-bot2>
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

Commit-ID:     ef558b4b7bbbf7e115c87e4da21ce86444d6ec3b
Gitweb:        https://git.kernel.org/tip/ef558b4b7bbbf7e115c87e4da21ce86444d6ec3b
Author:        Mark Rutland <mark.rutland@arm.com>
AuthorDate:    Mon, 05 Jun 2023 08:01:24 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 05 Jun 2023 09:57:24 +02:00

locking/atomic: treewide: delete arch_atomic_*() kerneldoc

Currently several architectures have kerneldoc comments for
arch_atomic_*(), which is unhelpful as these live in a shared namespace
where they clash, and the arch_atomic_*() ops are now an implementation
detail of the raw_atomic_*() ops, which no-one should use those
directly.

Delete the kerneldoc comments for arch_atomic_*(), along with
pseudo-kerneldoc comments which are in the correct style but are missing
the leading '/**' necessary to be true kerneldoc comments.

There should be no functional change as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Link: https://lore.kernel.org/r/20230605070124.3741859-28-mark.rutland@arm.com
---
 arch/alpha/include/asm/atomic.h       | 25 +-------
 arch/arc/include/asm/atomic64-arcv2.h | 17 +-----
 arch/hexagon/include/asm/atomic.h     | 16 +-----
 arch/loongarch/include/asm/atomic.h   | 49 +---------------
 arch/x86/include/asm/atomic.h         | 87 +--------------------------
 arch/x86/include/asm/atomic64_32.h    | 76 +-----------------------
 arch/x86/include/asm/atomic64_64.h    | 81 +------------------------
 7 files changed, 351 deletions(-)

diff --git a/arch/alpha/include/asm/atomic.h b/arch/alpha/include/asm/atomic.h
index ec8ab55..cbd9244 100644
--- a/arch/alpha/include/asm/atomic.h
+++ b/arch/alpha/include/asm/atomic.h
@@ -200,15 +200,6 @@ ATOMIC_OPS(xor, xor)
 #undef ATOMIC_OP_RETURN
 #undef ATOMIC_OP
 
-/**
- * arch_atomic_fetch_add_unless - add unless the number is a given value
- * @v: pointer of type atomic_t
- * @a: the amount to add to v...
- * @u: ...unless v is equal to u.
- *
- * Atomically adds @a to @v, so long as it was not @u.
- * Returns the old value of @v.
- */
 static __inline__ int arch_atomic_fetch_add_unless(atomic_t *v, int a, int u)
 {
 	int c, new, old;
@@ -232,15 +223,6 @@ static __inline__ int arch_atomic_fetch_add_unless(atomic_t *v, int a, int u)
 }
 #define arch_atomic_fetch_add_unless arch_atomic_fetch_add_unless
 
-/**
- * arch_atomic64_fetch_add_unless - add unless the number is a given value
- * @v: pointer of type atomic64_t
- * @a: the amount to add to v...
- * @u: ...unless v is equal to u.
- *
- * Atomically adds @a to @v, so long as it was not @u.
- * Returns the old value of @v.
- */
 static __inline__ s64 arch_atomic64_fetch_add_unless(atomic64_t *v, s64 a, s64 u)
 {
 	s64 c, new, old;
@@ -264,13 +246,6 @@ static __inline__ s64 arch_atomic64_fetch_add_unless(atomic64_t *v, s64 a, s64 u
 }
 #define arch_atomic64_fetch_add_unless arch_atomic64_fetch_add_unless
 
-/*
- * arch_atomic64_dec_if_positive - decrement by 1 if old value positive
- * @v: pointer of type atomic_t
- *
- * The function returns the old value of *v minus 1, even if
- * the atomic variable, v, was not decremented.
- */
 static inline s64 arch_atomic64_dec_if_positive(atomic64_t *v)
 {
 	s64 old, tmp;
diff --git a/arch/arc/include/asm/atomic64-arcv2.h b/arch/arc/include/asm/atomic64-arcv2.h
index 2b7c9e6..6b6db98 100644
--- a/arch/arc/include/asm/atomic64-arcv2.h
+++ b/arch/arc/include/asm/atomic64-arcv2.h
@@ -182,14 +182,6 @@ static inline s64 arch_atomic64_xchg(atomic64_t *ptr, s64 new)
 }
 #define arch_atomic64_xchg arch_atomic64_xchg
 
-/**
- * arch_atomic64_dec_if_positive - decrement by 1 if old value positive
- * @v: pointer of type atomic64_t
- *
- * The function returns the old value of *v minus 1, even if
- * the atomic variable, v, was not decremented.
- */
-
 static inline s64 arch_atomic64_dec_if_positive(atomic64_t *v)
 {
 	s64 val;
@@ -214,15 +206,6 @@ static inline s64 arch_atomic64_dec_if_positive(atomic64_t *v)
 }
 #define arch_atomic64_dec_if_positive arch_atomic64_dec_if_positive
 
-/**
- * arch_atomic64_fetch_add_unless - add unless the number is a given value
- * @v: pointer of type atomic64_t
- * @a: the amount to add to v...
- * @u: ...unless v is equal to u.
- *
- * Atomically adds @a to @v, if it was not @u.
- * Returns the old value of @v
- */
 static inline s64 arch_atomic64_fetch_add_unless(atomic64_t *v, s64 a, s64 u)
 {
 	s64 old, temp;
diff --git a/arch/hexagon/include/asm/atomic.h b/arch/hexagon/include/asm/atomic.h
index 5c84400..2447d08 100644
--- a/arch/hexagon/include/asm/atomic.h
+++ b/arch/hexagon/include/asm/atomic.h
@@ -28,12 +28,6 @@ static inline void arch_atomic_set(atomic_t *v, int new)
 
 #define arch_atomic_set_release(v, i)	arch_atomic_set((v), (i))
 
-/**
- * arch_atomic_read - reads a word, atomically
- * @v: pointer to atomic value
- *
- * Assumes all word reads on our architecture are atomic.
- */
 #define arch_atomic_read(v)		READ_ONCE((v)->counter)
 
 #define ATOMIC_OP(op)							\
@@ -112,16 +106,6 @@ ATOMIC_OPS(xor)
 #undef ATOMIC_OP_RETURN
 #undef ATOMIC_OP
 
-/**
- * arch_atomic_fetch_add_unless - add unless the number is a given value
- * @v: pointer to value
- * @a: amount to add
- * @u: unless value is equal to u
- *
- * Returns old value.
- *
- */
-
 static inline int arch_atomic_fetch_add_unless(atomic_t *v, int a, int u)
 {
 	int __oldval;
diff --git a/arch/loongarch/include/asm/atomic.h b/arch/loongarch/include/asm/atomic.h
index 8d73c85..e27f0c7 100644
--- a/arch/loongarch/include/asm/atomic.h
+++ b/arch/loongarch/include/asm/atomic.h
@@ -29,21 +29,7 @@
 
 #define ATOMIC_INIT(i)	  { (i) }
 
-/*
- * arch_atomic_read - read atomic variable
- * @v: pointer of type atomic_t
- *
- * Atomically reads the value of @v.
- */
 #define arch_atomic_read(v)	READ_ONCE((v)->counter)
-
-/*
- * arch_atomic_set - set atomic variable
- * @v: pointer of type atomic_t
- * @i: required value
- *
- * Atomically sets the value of @v to @i.
- */
 #define arch_atomic_set(v, i)	WRITE_ONCE((v)->counter, (i))
 
 #define ATOMIC_OP(op, I, asm_op)					\
@@ -139,14 +125,6 @@ static inline int arch_atomic_fetch_add_unless(atomic_t *v, int a, int u)
 }
 #define arch_atomic_fetch_add_unless arch_atomic_fetch_add_unless
 
-/*
- * arch_atomic_sub_if_positive - conditionally subtract integer from atomic variable
- * @i: integer value to subtract
- * @v: pointer of type atomic_t
- *
- * Atomically test @v and subtract @i if @v is greater or equal than @i.
- * The function returns the old value of @v minus @i.
- */
 static inline int arch_atomic_sub_if_positive(int i, atomic_t *v)
 {
 	int result;
@@ -181,28 +159,13 @@ static inline int arch_atomic_sub_if_positive(int i, atomic_t *v)
 	return result;
 }
 
-/*
- * arch_atomic_dec_if_positive - decrement by 1 if old value positive
- * @v: pointer of type atomic_t
- */
 #define arch_atomic_dec_if_positive(v)	arch_atomic_sub_if_positive(1, v)
 
 #ifdef CONFIG_64BIT
 
 #define ATOMIC64_INIT(i)    { (i) }
 
-/*
- * arch_atomic64_read - read atomic variable
- * @v: pointer of type atomic64_t
- *
- */
 #define arch_atomic64_read(v)	READ_ONCE((v)->counter)
-
-/*
- * arch_atomic64_set - set atomic variable
- * @v: pointer of type atomic64_t
- * @i: required value
- */
 #define arch_atomic64_set(v, i)	WRITE_ONCE((v)->counter, (i))
 
 #define ATOMIC64_OP(op, I, asm_op)					\
@@ -297,14 +260,6 @@ static inline long arch_atomic64_fetch_add_unless(atomic64_t *v, long a, long u)
 }
 #define arch_atomic64_fetch_add_unless arch_atomic64_fetch_add_unless
 
-/*
- * arch_atomic64_sub_if_positive - conditionally subtract integer from atomic variable
- * @i: integer value to subtract
- * @v: pointer of type atomic64_t
- *
- * Atomically test @v and subtract @i if @v is greater or equal than @i.
- * The function returns the old value of @v minus @i.
- */
 static inline long arch_atomic64_sub_if_positive(long i, atomic64_t *v)
 {
 	long result;
@@ -339,10 +294,6 @@ static inline long arch_atomic64_sub_if_positive(long i, atomic64_t *v)
 	return result;
 }
 
-/*
- * arch_atomic64_dec_if_positive - decrement by 1 if old value positive
- * @v: pointer of type atomic64_t
- */
 #define arch_atomic64_dec_if_positive(v)	arch_atomic64_sub_if_positive(1, v)
 
 #endif /* CONFIG_64BIT */
diff --git a/arch/x86/include/asm/atomic.h b/arch/x86/include/asm/atomic.h
index 5e754e8..55a55ec 100644
--- a/arch/x86/include/asm/atomic.h
+++ b/arch/x86/include/asm/atomic.h
@@ -14,12 +14,6 @@
  * resource counting etc..
  */
 
-/**
- * arch_atomic_read - read atomic variable
- * @v: pointer of type atomic_t
- *
- * Atomically reads the value of @v.
- */
 static __always_inline int arch_atomic_read(const atomic_t *v)
 {
 	/*
@@ -29,25 +23,11 @@ static __always_inline int arch_atomic_read(const atomic_t *v)
 	return __READ_ONCE((v)->counter);
 }
 
-/**
- * arch_atomic_set - set atomic variable
- * @v: pointer of type atomic_t
- * @i: required value
- *
- * Atomically sets the value of @v to @i.
- */
 static __always_inline void arch_atomic_set(atomic_t *v, int i)
 {
 	__WRITE_ONCE(v->counter, i);
 }
 
-/**
- * arch_atomic_add - add integer to atomic variable
- * @i: integer value to add
- * @v: pointer of type atomic_t
- *
- * Atomically adds @i to @v.
- */
 static __always_inline void arch_atomic_add(int i, atomic_t *v)
 {
 	asm volatile(LOCK_PREFIX "addl %1,%0"
@@ -55,13 +35,6 @@ static __always_inline void arch_atomic_add(int i, atomic_t *v)
 		     : "ir" (i) : "memory");
 }
 
-/**
- * arch_atomic_sub - subtract integer from atomic variable
- * @i: integer value to subtract
- * @v: pointer of type atomic_t
- *
- * Atomically subtracts @i from @v.
- */
 static __always_inline void arch_atomic_sub(int i, atomic_t *v)
 {
 	asm volatile(LOCK_PREFIX "subl %1,%0"
@@ -69,27 +42,12 @@ static __always_inline void arch_atomic_sub(int i, atomic_t *v)
 		     : "ir" (i) : "memory");
 }
 
-/**
- * arch_atomic_sub_and_test - subtract value from variable and test result
- * @i: integer value to subtract
- * @v: pointer of type atomic_t
- *
- * Atomically subtracts @i from @v and returns
- * true if the result is zero, or false for all
- * other cases.
- */
 static __always_inline bool arch_atomic_sub_and_test(int i, atomic_t *v)
 {
 	return GEN_BINARY_RMWcc(LOCK_PREFIX "subl", v->counter, e, "er", i);
 }
 #define arch_atomic_sub_and_test arch_atomic_sub_and_test
 
-/**
- * arch_atomic_inc - increment atomic variable
- * @v: pointer of type atomic_t
- *
- * Atomically increments @v by 1.
- */
 static __always_inline void arch_atomic_inc(atomic_t *v)
 {
 	asm volatile(LOCK_PREFIX "incl %0"
@@ -97,12 +55,6 @@ static __always_inline void arch_atomic_inc(atomic_t *v)
 }
 #define arch_atomic_inc arch_atomic_inc
 
-/**
- * arch_atomic_dec - decrement atomic variable
- * @v: pointer of type atomic_t
- *
- * Atomically decrements @v by 1.
- */
 static __always_inline void arch_atomic_dec(atomic_t *v)
 {
 	asm volatile(LOCK_PREFIX "decl %0"
@@ -110,69 +62,30 @@ static __always_inline void arch_atomic_dec(atomic_t *v)
 }
 #define arch_atomic_dec arch_atomic_dec
 
-/**
- * arch_atomic_dec_and_test - decrement and test
- * @v: pointer of type atomic_t
- *
- * Atomically decrements @v by 1 and
- * returns true if the result is 0, or false for all other
- * cases.
- */
 static __always_inline bool arch_atomic_dec_and_test(atomic_t *v)
 {
 	return GEN_UNARY_RMWcc(LOCK_PREFIX "decl", v->counter, e);
 }
 #define arch_atomic_dec_and_test arch_atomic_dec_and_test
 
-/**
- * arch_atomic_inc_and_test - increment and test
- * @v: pointer of type atomic_t
- *
- * Atomically increments @v by 1
- * and returns true if the result is zero, or false for all
- * other cases.
- */
 static __always_inline bool arch_atomic_inc_and_test(atomic_t *v)
 {
 	return GEN_UNARY_RMWcc(LOCK_PREFIX "incl", v->counter, e);
 }
 #define arch_atomic_inc_and_test arch_atomic_inc_and_test
 
-/**
- * arch_atomic_add_negative - add and test if negative
- * @i: integer value to add
- * @v: pointer of type atomic_t
- *
- * Atomically adds @i to @v and returns true
- * if the result is negative, or false when
- * result is greater than or equal to zero.
- */
 static __always_inline bool arch_atomic_add_negative(int i, atomic_t *v)
 {
 	return GEN_BINARY_RMWcc(LOCK_PREFIX "addl", v->counter, s, "er", i);
 }
 #define arch_atomic_add_negative arch_atomic_add_negative
 
-/**
- * arch_atomic_add_return - add integer and return
- * @i: integer value to add
- * @v: pointer of type atomic_t
- *
- * Atomically adds @i to @v and returns @i + @v
- */
 static __always_inline int arch_atomic_add_return(int i, atomic_t *v)
 {
 	return i + xadd(&v->counter, i);
 }
 #define arch_atomic_add_return arch_atomic_add_return
 
-/**
- * arch_atomic_sub_return - subtract integer and return
- * @v: pointer of type atomic_t
- * @i: integer value to subtract
- *
- * Atomically subtracts @i from @v and returns @v - @i
- */
 static __always_inline int arch_atomic_sub_return(int i, atomic_t *v)
 {
 	return arch_atomic_add_return(-i, v);
diff --git a/arch/x86/include/asm/atomic64_32.h b/arch/x86/include/asm/atomic64_32.h
index 808b4ee..3486d91 100644
--- a/arch/x86/include/asm/atomic64_32.h
+++ b/arch/x86/include/asm/atomic64_32.h
@@ -61,30 +61,12 @@ ATOMIC64_DECL(add_unless);
 #undef __ATOMIC64_DECL
 #undef ATOMIC64_EXPORT
 
-/**
- * arch_atomic64_cmpxchg - cmpxchg atomic64 variable
- * @v: pointer to type atomic64_t
- * @o: expected value
- * @n: new value
- *
- * Atomically sets @v to @n if it was equal to @o and returns
- * the old value.
- */
-
 static __always_inline s64 arch_atomic64_cmpxchg(atomic64_t *v, s64 o, s64 n)
 {
 	return arch_cmpxchg64(&v->counter, o, n);
 }
 #define arch_atomic64_cmpxchg arch_atomic64_cmpxchg
 
-/**
- * arch_atomic64_xchg - xchg atomic64 variable
- * @v: pointer to type atomic64_t
- * @n: value to assign
- *
- * Atomically xchgs the value of @v to @n and returns
- * the old value.
- */
 static __always_inline s64 arch_atomic64_xchg(atomic64_t *v, s64 n)
 {
 	s64 o;
@@ -97,13 +79,6 @@ static __always_inline s64 arch_atomic64_xchg(atomic64_t *v, s64 n)
 }
 #define arch_atomic64_xchg arch_atomic64_xchg
 
-/**
- * arch_atomic64_set - set atomic64 variable
- * @v: pointer to type atomic64_t
- * @i: value to assign
- *
- * Atomically sets the value of @v to @n.
- */
 static __always_inline void arch_atomic64_set(atomic64_t *v, s64 i)
 {
 	unsigned high = (unsigned)(i >> 32);
@@ -113,12 +88,6 @@ static __always_inline void arch_atomic64_set(atomic64_t *v, s64 i)
 			     : "eax", "edx", "memory");
 }
 
-/**
- * arch_atomic64_read - read atomic64 variable
- * @v: pointer to type atomic64_t
- *
- * Atomically reads the value of @v and returns it.
- */
 static __always_inline s64 arch_atomic64_read(const atomic64_t *v)
 {
 	s64 r;
@@ -126,13 +95,6 @@ static __always_inline s64 arch_atomic64_read(const atomic64_t *v)
 	return r;
 }
 
-/**
- * arch_atomic64_add_return - add and return
- * @i: integer value to add
- * @v: pointer to type atomic64_t
- *
- * Atomically adds @i to @v and returns @i + *@v
- */
 static __always_inline s64 arch_atomic64_add_return(s64 i, atomic64_t *v)
 {
 	alternative_atomic64(add_return,
@@ -142,9 +104,6 @@ static __always_inline s64 arch_atomic64_add_return(s64 i, atomic64_t *v)
 }
 #define arch_atomic64_add_return arch_atomic64_add_return
 
-/*
- * Other variants with different arithmetic operators:
- */
 static __always_inline s64 arch_atomic64_sub_return(s64 i, atomic64_t *v)
 {
 	alternative_atomic64(sub_return,
@@ -172,13 +131,6 @@ static __always_inline s64 arch_atomic64_dec_return(atomic64_t *v)
 }
 #define arch_atomic64_dec_return arch_atomic64_dec_return
 
-/**
- * arch_atomic64_add - add integer to atomic64 variable
- * @i: integer value to add
- * @v: pointer to type atomic64_t
- *
- * Atomically adds @i to @v.
- */
 static __always_inline s64 arch_atomic64_add(s64 i, atomic64_t *v)
 {
 	__alternative_atomic64(add, add_return,
@@ -187,13 +139,6 @@ static __always_inline s64 arch_atomic64_add(s64 i, atomic64_t *v)
 	return i;
 }
 
-/**
- * arch_atomic64_sub - subtract the atomic64 variable
- * @i: integer value to subtract
- * @v: pointer to type atomic64_t
- *
- * Atomically subtracts @i from @v.
- */
 static __always_inline s64 arch_atomic64_sub(s64 i, atomic64_t *v)
 {
 	__alternative_atomic64(sub, sub_return,
@@ -202,12 +147,6 @@ static __always_inline s64 arch_atomic64_sub(s64 i, atomic64_t *v)
 	return i;
 }
 
-/**
- * arch_atomic64_inc - increment atomic64 variable
- * @v: pointer to type atomic64_t
- *
- * Atomically increments @v by 1.
- */
 static __always_inline void arch_atomic64_inc(atomic64_t *v)
 {
 	__alternative_atomic64(inc, inc_return, /* no output */,
@@ -215,12 +154,6 @@ static __always_inline void arch_atomic64_inc(atomic64_t *v)
 }
 #define arch_atomic64_inc arch_atomic64_inc
 
-/**
- * arch_atomic64_dec - decrement atomic64 variable
- * @v: pointer to type atomic64_t
- *
- * Atomically decrements @v by 1.
- */
 static __always_inline void arch_atomic64_dec(atomic64_t *v)
 {
 	__alternative_atomic64(dec, dec_return, /* no output */,
@@ -228,15 +161,6 @@ static __always_inline void arch_atomic64_dec(atomic64_t *v)
 }
 #define arch_atomic64_dec arch_atomic64_dec
 
-/**
- * arch_atomic64_add_unless - add unless the number is a given value
- * @v: pointer of type atomic64_t
- * @a: the amount to add to v...
- * @u: ...unless v is equal to u.
- *
- * Atomically adds @a to @v, so long as it was not @u.
- * Returns non-zero if the add was done, zero otherwise.
- */
 static __always_inline int arch_atomic64_add_unless(atomic64_t *v, s64 a, s64 u)
 {
 	unsigned low = (unsigned)u;
diff --git a/arch/x86/include/asm/atomic64_64.h b/arch/x86/include/asm/atomic64_64.h
index c496595..3165c0f 100644
--- a/arch/x86/include/asm/atomic64_64.h
+++ b/arch/x86/include/asm/atomic64_64.h
@@ -10,37 +10,16 @@
 
 #define ATOMIC64_INIT(i)	{ (i) }
 
-/**
- * arch_atomic64_read - read atomic64 variable
- * @v: pointer of type atomic64_t
- *
- * Atomically reads the value of @v.
- * Doesn't imply a read memory barrier.
- */
 static __always_inline s64 arch_atomic64_read(const atomic64_t *v)
 {
 	return __READ_ONCE((v)->counter);
 }
 
-/**
- * arch_atomic64_set - set atomic64 variable
- * @v: pointer to type atomic64_t
- * @i: required value
- *
- * Atomically sets the value of @v to @i.
- */
 static __always_inline void arch_atomic64_set(atomic64_t *v, s64 i)
 {
 	__WRITE_ONCE(v->counter, i);
 }
 
-/**
- * arch_atomic64_add - add integer to atomic64 variable
- * @i: integer value to add
- * @v: pointer to type atomic64_t
- *
- * Atomically adds @i to @v.
- */
 static __always_inline void arch_atomic64_add(s64 i, atomic64_t *v)
 {
 	asm volatile(LOCK_PREFIX "addq %1,%0"
@@ -48,13 +27,6 @@ static __always_inline void arch_atomic64_add(s64 i, atomic64_t *v)
 		     : "er" (i), "m" (v->counter) : "memory");
 }
 
-/**
- * arch_atomic64_sub - subtract the atomic64 variable
- * @i: integer value to subtract
- * @v: pointer to type atomic64_t
- *
- * Atomically subtracts @i from @v.
- */
 static __always_inline void arch_atomic64_sub(s64 i, atomic64_t *v)
 {
 	asm volatile(LOCK_PREFIX "subq %1,%0"
@@ -62,27 +34,12 @@ static __always_inline void arch_atomic64_sub(s64 i, atomic64_t *v)
 		     : "er" (i), "m" (v->counter) : "memory");
 }
 
-/**
- * arch_atomic64_sub_and_test - subtract value from variable and test result
- * @i: integer value to subtract
- * @v: pointer to type atomic64_t
- *
- * Atomically subtracts @i from @v and returns
- * true if the result is zero, or false for all
- * other cases.
- */
 static __always_inline bool arch_atomic64_sub_and_test(s64 i, atomic64_t *v)
 {
 	return GEN_BINARY_RMWcc(LOCK_PREFIX "subq", v->counter, e, "er", i);
 }
 #define arch_atomic64_sub_and_test arch_atomic64_sub_and_test
 
-/**
- * arch_atomic64_inc - increment atomic64 variable
- * @v: pointer to type atomic64_t
- *
- * Atomically increments @v by 1.
- */
 static __always_inline void arch_atomic64_inc(atomic64_t *v)
 {
 	asm volatile(LOCK_PREFIX "incq %0"
@@ -91,12 +48,6 @@ static __always_inline void arch_atomic64_inc(atomic64_t *v)
 }
 #define arch_atomic64_inc arch_atomic64_inc
 
-/**
- * arch_atomic64_dec - decrement atomic64 variable
- * @v: pointer to type atomic64_t
- *
- * Atomically decrements @v by 1.
- */
 static __always_inline void arch_atomic64_dec(atomic64_t *v)
 {
 	asm volatile(LOCK_PREFIX "decq %0"
@@ -105,56 +56,24 @@ static __always_inline void arch_atomic64_dec(atomic64_t *v)
 }
 #define arch_atomic64_dec arch_atomic64_dec
 
-/**
- * arch_atomic64_dec_and_test - decrement and test
- * @v: pointer to type atomic64_t
- *
- * Atomically decrements @v by 1 and
- * returns true if the result is 0, or false for all other
- * cases.
- */
 static __always_inline bool arch_atomic64_dec_and_test(atomic64_t *v)
 {
 	return GEN_UNARY_RMWcc(LOCK_PREFIX "decq", v->counter, e);
 }
 #define arch_atomic64_dec_and_test arch_atomic64_dec_and_test
 
-/**
- * arch_atomic64_inc_and_test - increment and test
- * @v: pointer to type atomic64_t
- *
- * Atomically increments @v by 1
- * and returns true if the result is zero, or false for all
- * other cases.
- */
 static __always_inline bool arch_atomic64_inc_and_test(atomic64_t *v)
 {
 	return GEN_UNARY_RMWcc(LOCK_PREFIX "incq", v->counter, e);
 }
 #define arch_atomic64_inc_and_test arch_atomic64_inc_and_test
 
-/**
- * arch_atomic64_add_negative - add and test if negative
- * @i: integer value to add
- * @v: pointer to type atomic64_t
- *
- * Atomically adds @i to @v and returns true
- * if the result is negative, or false when
- * result is greater than or equal to zero.
- */
 static __always_inline bool arch_atomic64_add_negative(s64 i, atomic64_t *v)
 {
 	return GEN_BINARY_RMWcc(LOCK_PREFIX "addq", v->counter, s, "er", i);
 }
 #define arch_atomic64_add_negative arch_atomic64_add_negative
 
-/**
- * arch_atomic64_add_return - add and return
- * @i: integer value to add
- * @v: pointer to type atomic64_t
- *
- * Atomically adds @i to @v and returns @i + @v
- */
 static __always_inline s64 arch_atomic64_add_return(s64 i, atomic64_t *v)
 {
 	return i + xadd(&v->counter, i);
