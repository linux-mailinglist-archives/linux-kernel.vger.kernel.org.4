Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A02C6FE3EF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 20:19:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236538AbjEJSTP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 14:19:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236145AbjEJSSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 14:18:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D54BC6A78;
        Wed, 10 May 2023 11:18:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B805863F8D;
        Wed, 10 May 2023 18:17:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A544AC433A0;
        Wed, 10 May 2023 18:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683742644;
        bh=7habnDi2108xRXlvaQYflFtpvA2CnKXlKIA8xuT2KGI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LR+TmNQNnhVZZ8MbTBFbBRWP0+QTufKpQ6+gR5YylKgr31b6xj270/v70vNdk1RAH
         KR6I4sNhSj+o28mu240yw8sG8I2NE8GfIMa13RuQ14IG476ycX2PQ7W2uxN092Hne1
         q7ZLFydJmhMFl2lh9EIombYLjFqINHOlDXWIMhRLUCGQ6Oh+4uTjLmley+HBCcRk7z
         b8F/U/+G23TCIOJlM0aYAwbAJCzodYHVnfrHu7yo4SenldBgfLGbTdaPYJzQLy7ZA/
         KMEDBTYPuzDtuTgNnnb6vFYPmvdjPYG7cd5KouuddaijUBg7WlVxLMt29j6fUV7WUz
         7NDuqTg4Yy8oQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 00EC3CE21C0; Wed, 10 May 2023 11:17:18 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, akiyks@gmail.com, linux-doc@vger.kernel.org,
        kernel-team@meta.com, "Paul E. McKenney" <paulmck@kernel.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH locking/atomic 15/19] locking/atomic: Add kernel-doc header for arch_${atomic}_${pfx}${name}${sfx}_release
Date:   Wed, 10 May 2023 11:17:13 -0700
Message-Id: <20230510181717.2200934-15-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <19135936-06d7-4705-8bc8-bb31c2a478ca@paulmck-laptop>
References: <19135936-06d7-4705-8bc8-bb31c2a478ca@paulmck-laptop>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add kernel-doc header template for arch_${atomic}_${pfx}${name}${sfx}_release
function family with the help of my good friend awk, as encapsulated in
acqrel.sh.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Will Deacon <will@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>
---
 include/linux/atomic/atomic-arch-fallback.h | 268 +++++++++++++++++++-
 scripts/atomic/fallbacks/release            |   2 +
 2 files changed, 269 insertions(+), 1 deletion(-)

diff --git a/include/linux/atomic/atomic-arch-fallback.h b/include/linux/atomic/atomic-arch-fallback.h
index fc80113ca60a..ec6821b4bbc1 100644
--- a/include/linux/atomic/atomic-arch-fallback.h
+++ b/include/linux/atomic/atomic-arch-fallback.h
@@ -311,6 +311,14 @@ arch_atomic_add_return_acquire(int i, atomic_t *v)
 #endif
 
 #ifndef arch_atomic_add_return_release
+/**
+ * arch_atomic_add_return_release - Atomic add with release ordering
+ * @i: value to add
+ * @v: pointer of type atomic_t
+ *
+ * Atomically add @i to @v using release ordering.
+ * Return new value.
+ */
 static __always_inline int
 arch_atomic_add_return_release(int i, atomic_t *v)
 {
@@ -361,6 +369,14 @@ arch_atomic_fetch_add_acquire(int i, atomic_t *v)
 #endif
 
 #ifndef arch_atomic_fetch_add_release
+/**
+ * arch_atomic_fetch_add_release - Atomic add with release ordering
+ * @i: value to add
+ * @v: pointer of type atomic_t
+ *
+ * Atomically add @i to @v using release ordering.
+ * Return old value.
+ */
 static __always_inline int
 arch_atomic_fetch_add_release(int i, atomic_t *v)
 {
@@ -411,6 +427,14 @@ arch_atomic_sub_return_acquire(int i, atomic_t *v)
 #endif
 
 #ifndef arch_atomic_sub_return_release
+/**
+ * arch_atomic_sub_return_release - Atomic sub with release ordering
+ * @i: value to subtract
+ * @v: pointer of type atomic_t
+ *
+ * Atomically subtract @i from @v using release ordering.
+ * Return new value.
+ */
 static __always_inline int
 arch_atomic_sub_return_release(int i, atomic_t *v)
 {
@@ -461,6 +485,14 @@ arch_atomic_fetch_sub_acquire(int i, atomic_t *v)
 #endif
 
 #ifndef arch_atomic_fetch_sub_release
+/**
+ * arch_atomic_fetch_sub_release - Atomic sub with release ordering
+ * @i: value to subtract
+ * @v: pointer of type atomic_t
+ *
+ * Atomically subtract @i from @v using release ordering.
+ * Return old value.
+ */
 static __always_inline int
 arch_atomic_fetch_sub_release(int i, atomic_t *v)
 {
@@ -593,6 +625,13 @@ arch_atomic_inc_return_acquire(atomic_t *v)
 #endif
 
 #ifndef arch_atomic_inc_return_release
+/**
+ * arch_atomic_inc_return_release - Atomic inc with release ordering
+ * @v: pointer of type atomic_t
+ *
+ * Atomically increment @v using release ordering.
+ * Return new value.
+ */
 static __always_inline int
 arch_atomic_inc_return_release(atomic_t *v)
 {
@@ -709,6 +748,13 @@ arch_atomic_fetch_inc_acquire(atomic_t *v)
 #endif
 
 #ifndef arch_atomic_fetch_inc_release
+/**
+ * arch_atomic_fetch_inc_release - Atomic inc with release ordering
+ * @v: pointer of type atomic_t
+ *
+ * Atomically increment @v using release ordering.
+ * Return old value.
+ */
 static __always_inline int
 arch_atomic_fetch_inc_release(atomic_t *v)
 {
@@ -841,6 +887,13 @@ arch_atomic_dec_return_acquire(atomic_t *v)
 #endif
 
 #ifndef arch_atomic_dec_return_release
+/**
+ * arch_atomic_dec_return_release - Atomic dec with release ordering
+ * @v: pointer of type atomic_t
+ *
+ * Atomically decrement @v using release ordering.
+ * Return new value.
+ */
 static __always_inline int
 arch_atomic_dec_return_release(atomic_t *v)
 {
@@ -957,6 +1010,13 @@ arch_atomic_fetch_dec_acquire(atomic_t *v)
 #endif
 
 #ifndef arch_atomic_fetch_dec_release
+/**
+ * arch_atomic_fetch_dec_release - Atomic dec with release ordering
+ * @v: pointer of type atomic_t
+ *
+ * Atomically decrement @v using release ordering.
+ * Return old value.
+ */
 static __always_inline int
 arch_atomic_fetch_dec_release(atomic_t *v)
 {
@@ -1007,6 +1067,14 @@ arch_atomic_fetch_and_acquire(int i, atomic_t *v)
 #endif
 
 #ifndef arch_atomic_fetch_and_release
+/**
+ * arch_atomic_fetch_and_release - Atomic and with release ordering
+ * @i: value to AND
+ * @v: pointer of type atomic_t
+ *
+ * Atomically AND @i with @v using release ordering.
+ * Return old value.
+ */
 static __always_inline int
 arch_atomic_fetch_and_release(int i, atomic_t *v)
 {
@@ -1145,6 +1213,14 @@ arch_atomic_fetch_andnot_acquire(int i, atomic_t *v)
 #endif
 
 #ifndef arch_atomic_fetch_andnot_release
+/**
+ * arch_atomic_fetch_andnot_release - Atomic andnot with release ordering
+ * @i: value to complement then AND
+ * @v: pointer of type atomic_t
+ *
+ * Atomically complement then AND @i with @v using release ordering.
+ * Return old value.
+ */
 static __always_inline int
 arch_atomic_fetch_andnot_release(int i, atomic_t *v)
 {
@@ -1195,6 +1271,14 @@ arch_atomic_fetch_or_acquire(int i, atomic_t *v)
 #endif
 
 #ifndef arch_atomic_fetch_or_release
+/**
+ * arch_atomic_fetch_or_release - Atomic or with release ordering
+ * @i: value to OR
+ * @v: pointer of type atomic_t
+ *
+ * Atomically OR @i with @v using release ordering.
+ * Return old value.
+ */
 static __always_inline int
 arch_atomic_fetch_or_release(int i, atomic_t *v)
 {
@@ -1245,6 +1329,14 @@ arch_atomic_fetch_xor_acquire(int i, atomic_t *v)
 #endif
 
 #ifndef arch_atomic_fetch_xor_release
+/**
+ * arch_atomic_fetch_xor_release - Atomic xor with release ordering
+ * @i: value to XOR
+ * @v: pointer of type atomic_t
+ *
+ * Atomically XOR @i with @v using release ordering.
+ * Return old value.
+ */
 static __always_inline int
 arch_atomic_fetch_xor_release(int i, atomic_t *v)
 {
@@ -1295,6 +1387,14 @@ arch_atomic_xchg_acquire(atomic_t *v, int i)
 #endif
 
 #ifndef arch_atomic_xchg_release
+/**
+ * arch_atomic_xchg_release - Atomic xchg with release ordering
+ * @v: pointer of type atomic_t
+ * @i: value to exchange
+ *
+ * Atomically exchange @i with @v using release ordering.
+ * Return old value.
+ */
 static __always_inline int
 arch_atomic_xchg_release(atomic_t *v, int i)
 {
@@ -1349,6 +1449,18 @@ arch_atomic_cmpxchg_acquire(atomic_t *v, int old, int new)
 #endif
 
 #ifndef arch_atomic_cmpxchg_release
+/**
+ * arch_atomic_cmpxchg_release - Atomic cmpxchg with release ordering
+ * @v: pointer of type atomic_t
+ * @old: desired old value to match
+ * @new: new value to put in
+ *
+ * Atomically compares @new to *@v, and if equal,
+ * stores @new to *@v, providing release ordering.
+ * Returns the old value *@v regardless of the result of
+ * the comparison.  Therefore, if the return value is not
+ * equal to @old, the cmpxchg operation failed.
+ */
 static __always_inline int
 arch_atomic_cmpxchg_release(atomic_t *v, int old, int new)
 {
@@ -1498,6 +1610,18 @@ arch_atomic_try_cmpxchg_acquire(atomic_t *v, int *old, int new)
 #endif
 
 #ifndef arch_atomic_try_cmpxchg_release
+/**
+ * arch_atomic_try_cmpxchg_release - Atomic try_cmpxchg with release ordering
+ * @v: pointer of type atomic_t
+ * @old: desired old value to match
+ * @new: new value to put in
+ *
+ * Atomically compares @new to *@v, and if equal,
+ * stores @new to *@v, providing release ordering.
+ * Returns @true if the cmpxchg operation succeeded,
+ * and false otherwise.  Either way, stores the old
+ * value of *@v to *@old.
+ */
 static __always_inline bool
 arch_atomic_try_cmpxchg_release(atomic_t *v, int *old, int new)
 {
@@ -1672,6 +1796,15 @@ arch_atomic_add_negative_acquire(int i, atomic_t *v)
 #endif
 
 #ifndef arch_atomic_add_negative_release
+/**
+ * arch_atomic_add_negative_release - Atomic add_negative with release ordering
+ * @i: value to add
+ * @v: pointer of type atomic_t
+ *
+ * Atomically add @i with @v using release ordering.
+ * Return @true if the result is negative, or @false when
+ * the result is greater than or equal to zero.
+ */
 static __always_inline bool
 arch_atomic_add_negative_release(int i, atomic_t *v)
 {
@@ -1906,6 +2039,14 @@ arch_atomic64_add_return_acquire(s64 i, atomic64_t *v)
 #endif
 
 #ifndef arch_atomic64_add_return_release
+/**
+ * arch_atomic64_add_return_release - Atomic add with release ordering
+ * @i: value to add
+ * @v: pointer of type atomic64_t
+ *
+ * Atomically add @i to @v using release ordering.
+ * Return new value.
+ */
 static __always_inline s64
 arch_atomic64_add_return_release(s64 i, atomic64_t *v)
 {
@@ -1956,6 +2097,14 @@ arch_atomic64_fetch_add_acquire(s64 i, atomic64_t *v)
 #endif
 
 #ifndef arch_atomic64_fetch_add_release
+/**
+ * arch_atomic64_fetch_add_release - Atomic add with release ordering
+ * @i: value to add
+ * @v: pointer of type atomic64_t
+ *
+ * Atomically add @i to @v using release ordering.
+ * Return old value.
+ */
 static __always_inline s64
 arch_atomic64_fetch_add_release(s64 i, atomic64_t *v)
 {
@@ -2006,6 +2155,14 @@ arch_atomic64_sub_return_acquire(s64 i, atomic64_t *v)
 #endif
 
 #ifndef arch_atomic64_sub_return_release
+/**
+ * arch_atomic64_sub_return_release - Atomic sub with release ordering
+ * @i: value to subtract
+ * @v: pointer of type atomic64_t
+ *
+ * Atomically subtract @i from @v using release ordering.
+ * Return new value.
+ */
 static __always_inline s64
 arch_atomic64_sub_return_release(s64 i, atomic64_t *v)
 {
@@ -2056,6 +2213,14 @@ arch_atomic64_fetch_sub_acquire(s64 i, atomic64_t *v)
 #endif
 
 #ifndef arch_atomic64_fetch_sub_release
+/**
+ * arch_atomic64_fetch_sub_release - Atomic sub with release ordering
+ * @i: value to subtract
+ * @v: pointer of type atomic64_t
+ *
+ * Atomically subtract @i from @v using release ordering.
+ * Return old value.
+ */
 static __always_inline s64
 arch_atomic64_fetch_sub_release(s64 i, atomic64_t *v)
 {
@@ -2188,6 +2353,13 @@ arch_atomic64_inc_return_acquire(atomic64_t *v)
 #endif
 
 #ifndef arch_atomic64_inc_return_release
+/**
+ * arch_atomic64_inc_return_release - Atomic inc with release ordering
+ * @v: pointer of type atomic64_t
+ *
+ * Atomically increment @v using release ordering.
+ * Return new value.
+ */
 static __always_inline s64
 arch_atomic64_inc_return_release(atomic64_t *v)
 {
@@ -2304,6 +2476,13 @@ arch_atomic64_fetch_inc_acquire(atomic64_t *v)
 #endif
 
 #ifndef arch_atomic64_fetch_inc_release
+/**
+ * arch_atomic64_fetch_inc_release - Atomic inc with release ordering
+ * @v: pointer of type atomic64_t
+ *
+ * Atomically increment @v using release ordering.
+ * Return old value.
+ */
 static __always_inline s64
 arch_atomic64_fetch_inc_release(atomic64_t *v)
 {
@@ -2436,6 +2615,13 @@ arch_atomic64_dec_return_acquire(atomic64_t *v)
 #endif
 
 #ifndef arch_atomic64_dec_return_release
+/**
+ * arch_atomic64_dec_return_release - Atomic dec with release ordering
+ * @v: pointer of type atomic64_t
+ *
+ * Atomically decrement @v using release ordering.
+ * Return new value.
+ */
 static __always_inline s64
 arch_atomic64_dec_return_release(atomic64_t *v)
 {
@@ -2552,6 +2738,13 @@ arch_atomic64_fetch_dec_acquire(atomic64_t *v)
 #endif
 
 #ifndef arch_atomic64_fetch_dec_release
+/**
+ * arch_atomic64_fetch_dec_release - Atomic dec with release ordering
+ * @v: pointer of type atomic64_t
+ *
+ * Atomically decrement @v using release ordering.
+ * Return old value.
+ */
 static __always_inline s64
 arch_atomic64_fetch_dec_release(atomic64_t *v)
 {
@@ -2602,6 +2795,14 @@ arch_atomic64_fetch_and_acquire(s64 i, atomic64_t *v)
 #endif
 
 #ifndef arch_atomic64_fetch_and_release
+/**
+ * arch_atomic64_fetch_and_release - Atomic and with release ordering
+ * @i: value to AND
+ * @v: pointer of type atomic64_t
+ *
+ * Atomically AND @i with @v using release ordering.
+ * Return old value.
+ */
 static __always_inline s64
 arch_atomic64_fetch_and_release(s64 i, atomic64_t *v)
 {
@@ -2740,6 +2941,14 @@ arch_atomic64_fetch_andnot_acquire(s64 i, atomic64_t *v)
 #endif
 
 #ifndef arch_atomic64_fetch_andnot_release
+/**
+ * arch_atomic64_fetch_andnot_release - Atomic andnot with release ordering
+ * @i: value to complement then AND
+ * @v: pointer of type atomic64_t
+ *
+ * Atomically complement then AND @i with @v using release ordering.
+ * Return old value.
+ */
 static __always_inline s64
 arch_atomic64_fetch_andnot_release(s64 i, atomic64_t *v)
 {
@@ -2790,6 +2999,14 @@ arch_atomic64_fetch_or_acquire(s64 i, atomic64_t *v)
 #endif
 
 #ifndef arch_atomic64_fetch_or_release
+/**
+ * arch_atomic64_fetch_or_release - Atomic or with release ordering
+ * @i: value to OR
+ * @v: pointer of type atomic64_t
+ *
+ * Atomically OR @i with @v using release ordering.
+ * Return old value.
+ */
 static __always_inline s64
 arch_atomic64_fetch_or_release(s64 i, atomic64_t *v)
 {
@@ -2840,6 +3057,14 @@ arch_atomic64_fetch_xor_acquire(s64 i, atomic64_t *v)
 #endif
 
 #ifndef arch_atomic64_fetch_xor_release
+/**
+ * arch_atomic64_fetch_xor_release - Atomic xor with release ordering
+ * @i: value to XOR
+ * @v: pointer of type atomic64_t
+ *
+ * Atomically XOR @i with @v using release ordering.
+ * Return old value.
+ */
 static __always_inline s64
 arch_atomic64_fetch_xor_release(s64 i, atomic64_t *v)
 {
@@ -2890,6 +3115,14 @@ arch_atomic64_xchg_acquire(atomic64_t *v, s64 i)
 #endif
 
 #ifndef arch_atomic64_xchg_release
+/**
+ * arch_atomic64_xchg_release - Atomic xchg with release ordering
+ * @v: pointer of type atomic64_t
+ * @i: value to exchange
+ *
+ * Atomically exchange @i with @v using release ordering.
+ * Return old value.
+ */
 static __always_inline s64
 arch_atomic64_xchg_release(atomic64_t *v, s64 i)
 {
@@ -2944,6 +3177,18 @@ arch_atomic64_cmpxchg_acquire(atomic64_t *v, s64 old, s64 new)
 #endif
 
 #ifndef arch_atomic64_cmpxchg_release
+/**
+ * arch_atomic64_cmpxchg_release - Atomic cmpxchg with release ordering
+ * @v: pointer of type atomic64_t
+ * @old: desired old value to match
+ * @new: new value to put in
+ *
+ * Atomically compares @new to *@v, and if equal,
+ * stores @new to *@v, providing release ordering.
+ * Returns the old value *@v regardless of the result of
+ * the comparison.  Therefore, if the return value is not
+ * equal to @old, the cmpxchg operation failed.
+ */
 static __always_inline s64
 arch_atomic64_cmpxchg_release(atomic64_t *v, s64 old, s64 new)
 {
@@ -3093,6 +3338,18 @@ arch_atomic64_try_cmpxchg_acquire(atomic64_t *v, s64 *old, s64 new)
 #endif
 
 #ifndef arch_atomic64_try_cmpxchg_release
+/**
+ * arch_atomic64_try_cmpxchg_release - Atomic try_cmpxchg with release ordering
+ * @v: pointer of type atomic64_t
+ * @old: desired old value to match
+ * @new: new value to put in
+ *
+ * Atomically compares @new to *@v, and if equal,
+ * stores @new to *@v, providing release ordering.
+ * Returns @true if the cmpxchg operation succeeded,
+ * and false otherwise.  Either way, stores the old
+ * value of *@v to *@old.
+ */
 static __always_inline bool
 arch_atomic64_try_cmpxchg_release(atomic64_t *v, s64 *old, s64 new)
 {
@@ -3267,6 +3524,15 @@ arch_atomic64_add_negative_acquire(s64 i, atomic64_t *v)
 #endif
 
 #ifndef arch_atomic64_add_negative_release
+/**
+ * arch_atomic64_add_negative_release - Atomic add_negative with release ordering
+ * @i: value to add
+ * @v: pointer of type atomic64_t
+ *
+ * Atomically add @i with @v using release ordering.
+ * Return @true if the result is negative, or @false when
+ * the result is greater than or equal to zero.
+ */
 static __always_inline bool
 arch_atomic64_add_negative_release(s64 i, atomic64_t *v)
 {
@@ -3426,4 +3692,4 @@ arch_atomic64_dec_if_positive(atomic64_t *v)
 #endif
 
 #endif /* _LINUX_ATOMIC_FALLBACK_H */
-// a7944792460cf5adb72d49025850800d2cd178be
+// 2caf9e8360f71f3841789431533b32b620a12c1e
diff --git a/scripts/atomic/fallbacks/release b/scripts/atomic/fallbacks/release
index b46feb56d69c..bce3a1cbd497 100755
--- a/scripts/atomic/fallbacks/release
+++ b/scripts/atomic/fallbacks/release
@@ -1,3 +1,5 @@
+acqrel=release
+. ${ATOMICDIR}/acqrel.sh
 cat <<EOF
 static __always_inline ${ret}
 arch_${atomic}_${pfx}${name}${sfx}_release(${params})
-- 
2.40.1

