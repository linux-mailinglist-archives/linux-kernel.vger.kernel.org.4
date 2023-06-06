Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE3B2723BBA
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 10:28:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237233AbjFFI2R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 04:28:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236874AbjFFI0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 04:26:39 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF31810C4;
        Tue,  6 Jun 2023 01:26:30 -0700 (PDT)
Date:   Tue, 06 Jun 2023 08:26:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686039986;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xCuLThqTgLcMb2amhs+S1RDzbQDy9tHLnFaS78b885A=;
        b=XvTgqR32n7ChIgxjta9CAzwkk5yszEE83qmFXljcaf/Ak2RrFMGq2oNqpiwI0GrkRnLRLD
        qDXtF7v+Yvf5udWbAHnLFh3ZERIqPIT6KecR8ucUIjRsLKIsy1La2XBN2IqtZdURe9ap/M
        0A+kzRYPfXKuErWjFP9yBKHooTc0XdkZ/XnKpqCNrGW1nBzhusO+lTOi2Z9oEleATq4yy7
        HKxgA0ZgleHYMQ0ATKJTAF4Pdb98SUus6T+5uaogvQMHNnjgvDuELBR/MFwU2yLOB3BUs0
        4rCpZWvqdith229q8Cf9Vsb7NbKaZy1+8uVrtYkEHB7RktC2zDjiL5osZMLIJw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686039986;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xCuLThqTgLcMb2amhs+S1RDzbQDy9tHLnFaS78b885A=;
        b=gB6ELWRHLjYY7/66gkcPfl5LZYOpXCIDhKMOrjAysUdXosFIg30HPuaM/9U2um6EkQNH6Q
        /KB2iIqcjIAONkBQ==
From:   "tip-bot2 for Mark Rutland" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/atomic: remove fallback comments
Cc:     Mark Rutland <mark.rutland@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230605070124.3741859-3-mark.rutland@arm.com>
References: <20230605070124.3741859-3-mark.rutland@arm.com>
MIME-Version: 1.0
Message-ID: <168603998560.404.5057491793332191934.tip-bot2@tip-bot2>
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

Commit-ID:     14d72d4b6f0e88b5f683c1a5b7a876a55055852d
Gitweb:        https://git.kernel.org/tip/14d72d4b6f0e88b5f683c1a5b7a876a55055852d
Author:        Mark Rutland <mark.rutland@arm.com>
AuthorDate:    Mon, 05 Jun 2023 08:00:59 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 05 Jun 2023 09:57:13 +02:00

locking/atomic: remove fallback comments

Currently a subset of the fallback templates have kerneldoc comments,
resulting in a haphazard set of generated kerneldoc comments as only
some operations have fallback templates to begin with.

We'd like to generate more consistent kerneldoc comments, and to do so
we'll need to restructure the way the fallback code is generated.

To minimize churn and to make it easier to restructure the fallback
code, this patch removes the existing kerneldoc comments from the
fallback templates. We can add new kerneldoc comments in subsequent
patches.

There should be no functional change as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Link: https://lore.kernel.org/r/20230605070124.3741859-3-mark.rutland@arm.com
---
 include/linux/atomic/atomic-arch-fallback.h | 166 +-------------------
 scripts/atomic/fallbacks/add_negative       |   8 +-
 scripts/atomic/fallbacks/add_unless         |   9 +-
 scripts/atomic/fallbacks/dec_and_test       |   8 +-
 scripts/atomic/fallbacks/fetch_add_unless   |   9 +-
 scripts/atomic/fallbacks/inc_and_test       |   8 +-
 scripts/atomic/fallbacks/inc_not_zero       |   7 +-
 scripts/atomic/fallbacks/sub_and_test       |   9 +-
 8 files changed, 1 insertion(+), 223 deletions(-)

diff --git a/include/linux/atomic/atomic-arch-fallback.h b/include/linux/atomic/atomic-arch-fallback.h
index 1722ddb..3ce4cb5 100644
--- a/include/linux/atomic/atomic-arch-fallback.h
+++ b/include/linux/atomic/atomic-arch-fallback.h
@@ -1272,15 +1272,6 @@ arch_atomic_try_cmpxchg(atomic_t *v, int *old, int new)
 #endif /* arch_atomic_try_cmpxchg_relaxed */
 
 #ifndef arch_atomic_sub_and_test
-/**
- * arch_atomic_sub_and_test - subtract value from variable and test result
- * @i: integer value to subtract
- * @v: pointer of type atomic_t
- *
- * Atomically subtracts @i from @v and returns
- * true if the result is zero, or false for all
- * other cases.
- */
 static __always_inline bool
 arch_atomic_sub_and_test(int i, atomic_t *v)
 {
@@ -1290,14 +1281,6 @@ arch_atomic_sub_and_test(int i, atomic_t *v)
 #endif
 
 #ifndef arch_atomic_dec_and_test
-/**
- * arch_atomic_dec_and_test - decrement and test
- * @v: pointer of type atomic_t
- *
- * Atomically decrements @v by 1 and
- * returns true if the result is 0, or false for all other
- * cases.
- */
 static __always_inline bool
 arch_atomic_dec_and_test(atomic_t *v)
 {
@@ -1307,14 +1290,6 @@ arch_atomic_dec_and_test(atomic_t *v)
 #endif
 
 #ifndef arch_atomic_inc_and_test
-/**
- * arch_atomic_inc_and_test - increment and test
- * @v: pointer of type atomic_t
- *
- * Atomically increments @v by 1
- * and returns true if the result is zero, or false for all
- * other cases.
- */
 static __always_inline bool
 arch_atomic_inc_and_test(atomic_t *v)
 {
@@ -1331,14 +1306,6 @@ arch_atomic_inc_and_test(atomic_t *v)
 #endif /* arch_atomic_add_negative */
 
 #ifndef arch_atomic_add_negative
-/**
- * arch_atomic_add_negative - Add and test if negative
- * @i: integer value to add
- * @v: pointer of type atomic_t
- *
- * Atomically adds @i to @v and returns true if the result is negative,
- * or false when the result is greater than or equal to zero.
- */
 static __always_inline bool
 arch_atomic_add_negative(int i, atomic_t *v)
 {
@@ -1348,14 +1315,6 @@ arch_atomic_add_negative(int i, atomic_t *v)
 #endif
 
 #ifndef arch_atomic_add_negative_acquire
-/**
- * arch_atomic_add_negative_acquire - Add and test if negative
- * @i: integer value to add
- * @v: pointer of type atomic_t
- *
- * Atomically adds @i to @v and returns true if the result is negative,
- * or false when the result is greater than or equal to zero.
- */
 static __always_inline bool
 arch_atomic_add_negative_acquire(int i, atomic_t *v)
 {
@@ -1365,14 +1324,6 @@ arch_atomic_add_negative_acquire(int i, atomic_t *v)
 #endif
 
 #ifndef arch_atomic_add_negative_release
-/**
- * arch_atomic_add_negative_release - Add and test if negative
- * @i: integer value to add
- * @v: pointer of type atomic_t
- *
- * Atomically adds @i to @v and returns true if the result is negative,
- * or false when the result is greater than or equal to zero.
- */
 static __always_inline bool
 arch_atomic_add_negative_release(int i, atomic_t *v)
 {
@@ -1382,14 +1333,6 @@ arch_atomic_add_negative_release(int i, atomic_t *v)
 #endif
 
 #ifndef arch_atomic_add_negative_relaxed
-/**
- * arch_atomic_add_negative_relaxed - Add and test if negative
- * @i: integer value to add
- * @v: pointer of type atomic_t
- *
- * Atomically adds @i to @v and returns true if the result is negative,
- * or false when the result is greater than or equal to zero.
- */
 static __always_inline bool
 arch_atomic_add_negative_relaxed(int i, atomic_t *v)
 {
@@ -1437,15 +1380,6 @@ arch_atomic_add_negative(int i, atomic_t *v)
 #endif /* arch_atomic_add_negative_relaxed */
 
 #ifndef arch_atomic_fetch_add_unless
-/**
- * arch_atomic_fetch_add_unless - add unless the number is already a given value
- * @v: pointer of type atomic_t
- * @a: the amount to add to v...
- * @u: ...unless v is equal to u.
- *
- * Atomically adds @a to @v, so long as @v was not already @u.
- * Returns original value of @v
- */
 static __always_inline int
 arch_atomic_fetch_add_unless(atomic_t *v, int a, int u)
 {
@@ -1462,15 +1396,6 @@ arch_atomic_fetch_add_unless(atomic_t *v, int a, int u)
 #endif
 
 #ifndef arch_atomic_add_unless
-/**
- * arch_atomic_add_unless - add unless the number is already a given value
- * @v: pointer of type atomic_t
- * @a: the amount to add to v...
- * @u: ...unless v is equal to u.
- *
- * Atomically adds @a to @v, if @v was not already @u.
- * Returns true if the addition was done.
- */
 static __always_inline bool
 arch_atomic_add_unless(atomic_t *v, int a, int u)
 {
@@ -1480,13 +1405,6 @@ arch_atomic_add_unless(atomic_t *v, int a, int u)
 #endif
 
 #ifndef arch_atomic_inc_not_zero
-/**
- * arch_atomic_inc_not_zero - increment unless the number is zero
- * @v: pointer of type atomic_t
- *
- * Atomically increments @v by 1, if @v is non-zero.
- * Returns true if the increment was done.
- */
 static __always_inline bool
 arch_atomic_inc_not_zero(atomic_t *v)
 {
@@ -2488,15 +2406,6 @@ arch_atomic64_try_cmpxchg(atomic64_t *v, s64 *old, s64 new)
 #endif /* arch_atomic64_try_cmpxchg_relaxed */
 
 #ifndef arch_atomic64_sub_and_test
-/**
- * arch_atomic64_sub_and_test - subtract value from variable and test result
- * @i: integer value to subtract
- * @v: pointer of type atomic64_t
- *
- * Atomically subtracts @i from @v and returns
- * true if the result is zero, or false for all
- * other cases.
- */
 static __always_inline bool
 arch_atomic64_sub_and_test(s64 i, atomic64_t *v)
 {
@@ -2506,14 +2415,6 @@ arch_atomic64_sub_and_test(s64 i, atomic64_t *v)
 #endif
 
 #ifndef arch_atomic64_dec_and_test
-/**
- * arch_atomic64_dec_and_test - decrement and test
- * @v: pointer of type atomic64_t
- *
- * Atomically decrements @v by 1 and
- * returns true if the result is 0, or false for all other
- * cases.
- */
 static __always_inline bool
 arch_atomic64_dec_and_test(atomic64_t *v)
 {
@@ -2523,14 +2424,6 @@ arch_atomic64_dec_and_test(atomic64_t *v)
 #endif
 
 #ifndef arch_atomic64_inc_and_test
-/**
- * arch_atomic64_inc_and_test - increment and test
- * @v: pointer of type atomic64_t
- *
- * Atomically increments @v by 1
- * and returns true if the result is zero, or false for all
- * other cases.
- */
 static __always_inline bool
 arch_atomic64_inc_and_test(atomic64_t *v)
 {
@@ -2547,14 +2440,6 @@ arch_atomic64_inc_and_test(atomic64_t *v)
 #endif /* arch_atomic64_add_negative */
 
 #ifndef arch_atomic64_add_negative
-/**
- * arch_atomic64_add_negative - Add and test if negative
- * @i: integer value to add
- * @v: pointer of type atomic64_t
- *
- * Atomically adds @i to @v and returns true if the result is negative,
- * or false when the result is greater than or equal to zero.
- */
 static __always_inline bool
 arch_atomic64_add_negative(s64 i, atomic64_t *v)
 {
@@ -2564,14 +2449,6 @@ arch_atomic64_add_negative(s64 i, atomic64_t *v)
 #endif
 
 #ifndef arch_atomic64_add_negative_acquire
-/**
- * arch_atomic64_add_negative_acquire - Add and test if negative
- * @i: integer value to add
- * @v: pointer of type atomic64_t
- *
- * Atomically adds @i to @v and returns true if the result is negative,
- * or false when the result is greater than or equal to zero.
- */
 static __always_inline bool
 arch_atomic64_add_negative_acquire(s64 i, atomic64_t *v)
 {
@@ -2581,14 +2458,6 @@ arch_atomic64_add_negative_acquire(s64 i, atomic64_t *v)
 #endif
 
 #ifndef arch_atomic64_add_negative_release
-/**
- * arch_atomic64_add_negative_release - Add and test if negative
- * @i: integer value to add
- * @v: pointer of type atomic64_t
- *
- * Atomically adds @i to @v and returns true if the result is negative,
- * or false when the result is greater than or equal to zero.
- */
 static __always_inline bool
 arch_atomic64_add_negative_release(s64 i, atomic64_t *v)
 {
@@ -2598,14 +2467,6 @@ arch_atomic64_add_negative_release(s64 i, atomic64_t *v)
 #endif
 
 #ifndef arch_atomic64_add_negative_relaxed
-/**
- * arch_atomic64_add_negative_relaxed - Add and test if negative
- * @i: integer value to add
- * @v: pointer of type atomic64_t
- *
- * Atomically adds @i to @v and returns true if the result is negative,
- * or false when the result is greater than or equal to zero.
- */
 static __always_inline bool
 arch_atomic64_add_negative_relaxed(s64 i, atomic64_t *v)
 {
@@ -2653,15 +2514,6 @@ arch_atomic64_add_negative(s64 i, atomic64_t *v)
 #endif /* arch_atomic64_add_negative_relaxed */
 
 #ifndef arch_atomic64_fetch_add_unless
-/**
- * arch_atomic64_fetch_add_unless - add unless the number is already a given value
- * @v: pointer of type atomic64_t
- * @a: the amount to add to v...
- * @u: ...unless v is equal to u.
- *
- * Atomically adds @a to @v, so long as @v was not already @u.
- * Returns original value of @v
- */
 static __always_inline s64
 arch_atomic64_fetch_add_unless(atomic64_t *v, s64 a, s64 u)
 {
@@ -2678,15 +2530,6 @@ arch_atomic64_fetch_add_unless(atomic64_t *v, s64 a, s64 u)
 #endif
 
 #ifndef arch_atomic64_add_unless
-/**
- * arch_atomic64_add_unless - add unless the number is already a given value
- * @v: pointer of type atomic64_t
- * @a: the amount to add to v...
- * @u: ...unless v is equal to u.
- *
- * Atomically adds @a to @v, if @v was not already @u.
- * Returns true if the addition was done.
- */
 static __always_inline bool
 arch_atomic64_add_unless(atomic64_t *v, s64 a, s64 u)
 {
@@ -2696,13 +2539,6 @@ arch_atomic64_add_unless(atomic64_t *v, s64 a, s64 u)
 #endif
 
 #ifndef arch_atomic64_inc_not_zero
-/**
- * arch_atomic64_inc_not_zero - increment unless the number is zero
- * @v: pointer of type atomic64_t
- *
- * Atomically increments @v by 1, if @v is non-zero.
- * Returns true if the increment was done.
- */
 static __always_inline bool
 arch_atomic64_inc_not_zero(atomic64_t *v)
 {
@@ -2761,4 +2597,4 @@ arch_atomic64_dec_if_positive(atomic64_t *v)
 #endif
 
 #endif /* _LINUX_ATOMIC_FALLBACK_H */
-// 52dfc6fe4a2e7234bbd2aa3e16a377c1db793a53
+// 9f0fd6ed53267c6ec64e36cd18e6fd8df57ea277
diff --git a/scripts/atomic/fallbacks/add_negative b/scripts/atomic/fallbacks/add_negative
index e5980ab..d0bd2df 100755
--- a/scripts/atomic/fallbacks/add_negative
+++ b/scripts/atomic/fallbacks/add_negative
@@ -1,12 +1,4 @@
 cat <<EOF
-/**
- * arch_${atomic}_add_negative${order} - Add and test if negative
- * @i: integer value to add
- * @v: pointer of type ${atomic}_t
- *
- * Atomically adds @i to @v and returns true if the result is negative,
- * or false when the result is greater than or equal to zero.
- */
 static __always_inline bool
 arch_${atomic}_add_negative${order}(${int} i, ${atomic}_t *v)
 {
diff --git a/scripts/atomic/fallbacks/add_unless b/scripts/atomic/fallbacks/add_unless
index 9e5159c..cf79b9d 100755
--- a/scripts/atomic/fallbacks/add_unless
+++ b/scripts/atomic/fallbacks/add_unless
@@ -1,13 +1,4 @@
 cat << EOF
-/**
- * arch_${atomic}_add_unless - add unless the number is already a given value
- * @v: pointer of type ${atomic}_t
- * @a: the amount to add to v...
- * @u: ...unless v is equal to u.
- *
- * Atomically adds @a to @v, if @v was not already @u.
- * Returns true if the addition was done.
- */
 static __always_inline bool
 arch_${atomic}_add_unless(${atomic}_t *v, ${int} a, ${int} u)
 {
diff --git a/scripts/atomic/fallbacks/dec_and_test b/scripts/atomic/fallbacks/dec_and_test
index 8549f35..3f6b6a8 100755
--- a/scripts/atomic/fallbacks/dec_and_test
+++ b/scripts/atomic/fallbacks/dec_and_test
@@ -1,12 +1,4 @@
 cat <<EOF
-/**
- * arch_${atomic}_dec_and_test - decrement and test
- * @v: pointer of type ${atomic}_t
- *
- * Atomically decrements @v by 1 and
- * returns true if the result is 0, or false for all other
- * cases.
- */
 static __always_inline bool
 arch_${atomic}_dec_and_test(${atomic}_t *v)
 {
diff --git a/scripts/atomic/fallbacks/fetch_add_unless b/scripts/atomic/fallbacks/fetch_add_unless
index 68ce13c..81d2834 100755
--- a/scripts/atomic/fallbacks/fetch_add_unless
+++ b/scripts/atomic/fallbacks/fetch_add_unless
@@ -1,13 +1,4 @@
 cat << EOF
-/**
- * arch_${atomic}_fetch_add_unless - add unless the number is already a given value
- * @v: pointer of type ${atomic}_t
- * @a: the amount to add to v...
- * @u: ...unless v is equal to u.
- *
- * Atomically adds @a to @v, so long as @v was not already @u.
- * Returns original value of @v
- */
 static __always_inline ${int}
 arch_${atomic}_fetch_add_unless(${atomic}_t *v, ${int} a, ${int} u)
 {
diff --git a/scripts/atomic/fallbacks/inc_and_test b/scripts/atomic/fallbacks/inc_and_test
index 0cf23fe..c726a6d 100755
--- a/scripts/atomic/fallbacks/inc_and_test
+++ b/scripts/atomic/fallbacks/inc_and_test
@@ -1,12 +1,4 @@
 cat <<EOF
-/**
- * arch_${atomic}_inc_and_test - increment and test
- * @v: pointer of type ${atomic}_t
- *
- * Atomically increments @v by 1
- * and returns true if the result is zero, or false for all
- * other cases.
- */
 static __always_inline bool
 arch_${atomic}_inc_and_test(${atomic}_t *v)
 {
diff --git a/scripts/atomic/fallbacks/inc_not_zero b/scripts/atomic/fallbacks/inc_not_zero
index ed8a1f5..9760359 100755
--- a/scripts/atomic/fallbacks/inc_not_zero
+++ b/scripts/atomic/fallbacks/inc_not_zero
@@ -1,11 +1,4 @@
 cat <<EOF
-/**
- * arch_${atomic}_inc_not_zero - increment unless the number is zero
- * @v: pointer of type ${atomic}_t
- *
- * Atomically increments @v by 1, if @v is non-zero.
- * Returns true if the increment was done.
- */
 static __always_inline bool
 arch_${atomic}_inc_not_zero(${atomic}_t *v)
 {
diff --git a/scripts/atomic/fallbacks/sub_and_test b/scripts/atomic/fallbacks/sub_and_test
index 260f373..da8a049 100755
--- a/scripts/atomic/fallbacks/sub_and_test
+++ b/scripts/atomic/fallbacks/sub_and_test
@@ -1,13 +1,4 @@
 cat <<EOF
-/**
- * arch_${atomic}_sub_and_test - subtract value from variable and test result
- * @i: integer value to subtract
- * @v: pointer of type ${atomic}_t
- *
- * Atomically subtracts @i from @v and returns
- * true if the result is zero, or false for all
- * other cases.
- */
 static __always_inline bool
 arch_${atomic}_sub_and_test(${int} i, ${atomic}_t *v)
 {
