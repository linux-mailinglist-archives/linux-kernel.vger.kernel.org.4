Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A5C06FE3F5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 20:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236629AbjEJSTd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 14:19:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235203AbjEJSSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 14:18:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31D3365BD;
        Wed, 10 May 2023 11:18:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D56A463F9A;
        Wed, 10 May 2023 18:17:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1356C433AA;
        Wed, 10 May 2023 18:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683742644;
        bh=nBj3d4LCCUMW5/TfWa3VcbQzjTyzaZ4UhHxKnXGM9cY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MN2a7GB4jBlLpLdWwglaVMtLRtX0PlxxY2MebnjJWSUHXCE2Gb5AgMNmkp/Sf9Zxs
         cVEZydotkLzbTjB8d6sjgVj2Hd7mwa1t0D/sk4jSn/eVU7YA6zICa29gp+4USaAkqD
         jov0LW49r4S5ibs1FJa4zAwVIMcwsi2zmFVP/cscRnm0BJ8fbwYqwdhhA27QVe8W2J
         00RUTqy1EiZ3h0iqTs5DKqCtYW0j/ypp3X0cYr7iWA8e3wIV/XaHB6pYk7Gq6xrR31
         y4y60InlwF8j8J0HyqgdC5mX7R5Wy3ctHISfsq1LHH+uS2EdWX1kKvfAZy8GgrenpL
         +uGU+UZ5A5Mng==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 03C35CE21C8; Wed, 10 May 2023 11:17:19 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, akiyks@gmail.com, linux-doc@vger.kernel.org,
        kernel-team@meta.com, "Paul E. McKenney" <paulmck@kernel.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH locking/atomic 16/19] locking/atomic: Add kernel-doc header for arch_${atomic}_${pfx}${name}${sfx}
Date:   Wed, 10 May 2023 11:17:14 -0700
Message-Id: <20230510181717.2200934-16-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <19135936-06d7-4705-8bc8-bb31c2a478ca@paulmck-laptop>
References: <19135936-06d7-4705-8bc8-bb31c2a478ca@paulmck-laptop>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add kernel-doc header template for arch_${atomic}_${pfx}${name}${sfx}
function family with the help of my good friend awk, as encapsulated in
acqrel.sh.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Will Deacon <will@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>
---
 include/linux/atomic/atomic-arch-fallback.h | 268 +++++++++++++++++++-
 scripts/atomic/fallbacks/fence              |   2 +
 2 files changed, 269 insertions(+), 1 deletion(-)

diff --git a/include/linux/atomic/atomic-arch-fallback.h b/include/linux/atomic/atomic-arch-fallback.h
index ec6821b4bbc1..41aa94f0aacd 100644
--- a/include/linux/atomic/atomic-arch-fallback.h
+++ b/include/linux/atomic/atomic-arch-fallback.h
@@ -329,6 +329,14 @@ arch_atomic_add_return_release(int i, atomic_t *v)
 #endif
 
 #ifndef arch_atomic_add_return
+/**
+ * arch_atomic_add_return - Atomic add with full ordering
+ * @i: value to add
+ * @v: pointer of type atomic_t
+ *
+ * Atomically add @i to @v using full ordering.
+ * Return new value.
+ */
 static __always_inline int
 arch_atomic_add_return(int i, atomic_t *v)
 {
@@ -387,6 +395,14 @@ arch_atomic_fetch_add_release(int i, atomic_t *v)
 #endif
 
 #ifndef arch_atomic_fetch_add
+/**
+ * arch_atomic_fetch_add - Atomic add with full ordering
+ * @i: value to add
+ * @v: pointer of type atomic_t
+ *
+ * Atomically add @i to @v using full ordering.
+ * Return old value.
+ */
 static __always_inline int
 arch_atomic_fetch_add(int i, atomic_t *v)
 {
@@ -445,6 +461,14 @@ arch_atomic_sub_return_release(int i, atomic_t *v)
 #endif
 
 #ifndef arch_atomic_sub_return
+/**
+ * arch_atomic_sub_return - Atomic sub with full ordering
+ * @i: value to subtract
+ * @v: pointer of type atomic_t
+ *
+ * Atomically subtract @i from @v using full ordering.
+ * Return new value.
+ */
 static __always_inline int
 arch_atomic_sub_return(int i, atomic_t *v)
 {
@@ -503,6 +527,14 @@ arch_atomic_fetch_sub_release(int i, atomic_t *v)
 #endif
 
 #ifndef arch_atomic_fetch_sub
+/**
+ * arch_atomic_fetch_sub - Atomic sub with full ordering
+ * @i: value to subtract
+ * @v: pointer of type atomic_t
+ *
+ * Atomically subtract @i from @v using full ordering.
+ * Return old value.
+ */
 static __always_inline int
 arch_atomic_fetch_sub(int i, atomic_t *v)
 {
@@ -642,6 +674,13 @@ arch_atomic_inc_return_release(atomic_t *v)
 #endif
 
 #ifndef arch_atomic_inc_return
+/**
+ * arch_atomic_inc_return - Atomic inc with full ordering
+ * @v: pointer of type atomic_t
+ *
+ * Atomically increment @v using full ordering.
+ * Return new value.
+ */
 static __always_inline int
 arch_atomic_inc_return(atomic_t *v)
 {
@@ -765,6 +804,13 @@ arch_atomic_fetch_inc_release(atomic_t *v)
 #endif
 
 #ifndef arch_atomic_fetch_inc
+/**
+ * arch_atomic_fetch_inc - Atomic inc with full ordering
+ * @v: pointer of type atomic_t
+ *
+ * Atomically increment @v using full ordering.
+ * Return old value.
+ */
 static __always_inline int
 arch_atomic_fetch_inc(atomic_t *v)
 {
@@ -904,6 +950,13 @@ arch_atomic_dec_return_release(atomic_t *v)
 #endif
 
 #ifndef arch_atomic_dec_return
+/**
+ * arch_atomic_dec_return - Atomic dec with full ordering
+ * @v: pointer of type atomic_t
+ *
+ * Atomically decrement @v using full ordering.
+ * Return new value.
+ */
 static __always_inline int
 arch_atomic_dec_return(atomic_t *v)
 {
@@ -1027,6 +1080,13 @@ arch_atomic_fetch_dec_release(atomic_t *v)
 #endif
 
 #ifndef arch_atomic_fetch_dec
+/**
+ * arch_atomic_fetch_dec - Atomic dec with full ordering
+ * @v: pointer of type atomic_t
+ *
+ * Atomically decrement @v using full ordering.
+ * Return old value.
+ */
 static __always_inline int
 arch_atomic_fetch_dec(atomic_t *v)
 {
@@ -1085,6 +1145,14 @@ arch_atomic_fetch_and_release(int i, atomic_t *v)
 #endif
 
 #ifndef arch_atomic_fetch_and
+/**
+ * arch_atomic_fetch_and - Atomic and with full ordering
+ * @i: value to AND
+ * @v: pointer of type atomic_t
+ *
+ * Atomically AND @i with @v using full ordering.
+ * Return old value.
+ */
 static __always_inline int
 arch_atomic_fetch_and(int i, atomic_t *v)
 {
@@ -1231,6 +1299,14 @@ arch_atomic_fetch_andnot_release(int i, atomic_t *v)
 #endif
 
 #ifndef arch_atomic_fetch_andnot
+/**
+ * arch_atomic_fetch_andnot - Atomic andnot with full ordering
+ * @i: value to complement then AND
+ * @v: pointer of type atomic_t
+ *
+ * Atomically complement then AND @i with @v using full ordering.
+ * Return old value.
+ */
 static __always_inline int
 arch_atomic_fetch_andnot(int i, atomic_t *v)
 {
@@ -1289,6 +1365,14 @@ arch_atomic_fetch_or_release(int i, atomic_t *v)
 #endif
 
 #ifndef arch_atomic_fetch_or
+/**
+ * arch_atomic_fetch_or - Atomic or with full ordering
+ * @i: value to OR
+ * @v: pointer of type atomic_t
+ *
+ * Atomically OR @i with @v using full ordering.
+ * Return old value.
+ */
 static __always_inline int
 arch_atomic_fetch_or(int i, atomic_t *v)
 {
@@ -1347,6 +1431,14 @@ arch_atomic_fetch_xor_release(int i, atomic_t *v)
 #endif
 
 #ifndef arch_atomic_fetch_xor
+/**
+ * arch_atomic_fetch_xor - Atomic xor with full ordering
+ * @i: value to XOR
+ * @v: pointer of type atomic_t
+ *
+ * Atomically XOR @i with @v using full ordering.
+ * Return old value.
+ */
 static __always_inline int
 arch_atomic_fetch_xor(int i, atomic_t *v)
 {
@@ -1405,6 +1497,14 @@ arch_atomic_xchg_release(atomic_t *v, int i)
 #endif
 
 #ifndef arch_atomic_xchg
+/**
+ * arch_atomic_xchg - Atomic xchg with full ordering
+ * @v: pointer of type atomic_t
+ * @i: value to exchange
+ *
+ * Atomically exchange @i with @v using full ordering.
+ * Return old value.
+ */
 static __always_inline int
 arch_atomic_xchg(atomic_t *v, int i)
 {
@@ -1471,6 +1571,18 @@ arch_atomic_cmpxchg_release(atomic_t *v, int old, int new)
 #endif
 
 #ifndef arch_atomic_cmpxchg
+/**
+ * arch_atomic_cmpxchg - Atomic cmpxchg with full ordering
+ * @v: pointer of type atomic_t
+ * @old: desired old value to match
+ * @new: new value to put in
+ *
+ * Atomically compares @new to *@v, and if equal,
+ * stores @new to *@v, providing full ordering.
+ * Returns the old value *@v regardless of the result of
+ * the comparison.  Therefore, if the return value is not
+ * equal to @old, the cmpxchg operation failed.
+ */
 static __always_inline int
 arch_atomic_cmpxchg(atomic_t *v, int old, int new)
 {
@@ -1632,6 +1744,18 @@ arch_atomic_try_cmpxchg_release(atomic_t *v, int *old, int new)
 #endif
 
 #ifndef arch_atomic_try_cmpxchg
+/**
+ * arch_atomic_try_cmpxchg - Atomic try_cmpxchg with full ordering
+ * @v: pointer of type atomic_t
+ * @old: desired old value to match
+ * @new: new value to put in
+ *
+ * Atomically compares @new to *@v, and if equal,
+ * stores @new to *@v, providing full ordering.
+ * Returns @true if the cmpxchg operation succeeded,
+ * and false otherwise.  Either way, stores the old
+ * value of *@v to *@old.
+ */
 static __always_inline bool
 arch_atomic_try_cmpxchg(atomic_t *v, int *old, int new)
 {
@@ -1815,6 +1939,15 @@ arch_atomic_add_negative_release(int i, atomic_t *v)
 #endif
 
 #ifndef arch_atomic_add_negative
+/**
+ * arch_atomic_add_negative - Atomic add_negative with full ordering
+ * @i: value to add
+ * @v: pointer of type atomic_t
+ *
+ * Atomically add @i with @v using full ordering.
+ * Return @true if the result is negative, or @false when
+ * the result is greater than or equal to zero.
+ */
 static __always_inline bool
 arch_atomic_add_negative(int i, atomic_t *v)
 {
@@ -2057,6 +2190,14 @@ arch_atomic64_add_return_release(s64 i, atomic64_t *v)
 #endif
 
 #ifndef arch_atomic64_add_return
+/**
+ * arch_atomic64_add_return - Atomic add with full ordering
+ * @i: value to add
+ * @v: pointer of type atomic64_t
+ *
+ * Atomically add @i to @v using full ordering.
+ * Return new value.
+ */
 static __always_inline s64
 arch_atomic64_add_return(s64 i, atomic64_t *v)
 {
@@ -2115,6 +2256,14 @@ arch_atomic64_fetch_add_release(s64 i, atomic64_t *v)
 #endif
 
 #ifndef arch_atomic64_fetch_add
+/**
+ * arch_atomic64_fetch_add - Atomic add with full ordering
+ * @i: value to add
+ * @v: pointer of type atomic64_t
+ *
+ * Atomically add @i to @v using full ordering.
+ * Return old value.
+ */
 static __always_inline s64
 arch_atomic64_fetch_add(s64 i, atomic64_t *v)
 {
@@ -2173,6 +2322,14 @@ arch_atomic64_sub_return_release(s64 i, atomic64_t *v)
 #endif
 
 #ifndef arch_atomic64_sub_return
+/**
+ * arch_atomic64_sub_return - Atomic sub with full ordering
+ * @i: value to subtract
+ * @v: pointer of type atomic64_t
+ *
+ * Atomically subtract @i from @v using full ordering.
+ * Return new value.
+ */
 static __always_inline s64
 arch_atomic64_sub_return(s64 i, atomic64_t *v)
 {
@@ -2231,6 +2388,14 @@ arch_atomic64_fetch_sub_release(s64 i, atomic64_t *v)
 #endif
 
 #ifndef arch_atomic64_fetch_sub
+/**
+ * arch_atomic64_fetch_sub - Atomic sub with full ordering
+ * @i: value to subtract
+ * @v: pointer of type atomic64_t
+ *
+ * Atomically subtract @i from @v using full ordering.
+ * Return old value.
+ */
 static __always_inline s64
 arch_atomic64_fetch_sub(s64 i, atomic64_t *v)
 {
@@ -2370,6 +2535,13 @@ arch_atomic64_inc_return_release(atomic64_t *v)
 #endif
 
 #ifndef arch_atomic64_inc_return
+/**
+ * arch_atomic64_inc_return - Atomic inc with full ordering
+ * @v: pointer of type atomic64_t
+ *
+ * Atomically increment @v using full ordering.
+ * Return new value.
+ */
 static __always_inline s64
 arch_atomic64_inc_return(atomic64_t *v)
 {
@@ -2493,6 +2665,13 @@ arch_atomic64_fetch_inc_release(atomic64_t *v)
 #endif
 
 #ifndef arch_atomic64_fetch_inc
+/**
+ * arch_atomic64_fetch_inc - Atomic inc with full ordering
+ * @v: pointer of type atomic64_t
+ *
+ * Atomically increment @v using full ordering.
+ * Return old value.
+ */
 static __always_inline s64
 arch_atomic64_fetch_inc(atomic64_t *v)
 {
@@ -2632,6 +2811,13 @@ arch_atomic64_dec_return_release(atomic64_t *v)
 #endif
 
 #ifndef arch_atomic64_dec_return
+/**
+ * arch_atomic64_dec_return - Atomic dec with full ordering
+ * @v: pointer of type atomic64_t
+ *
+ * Atomically decrement @v using full ordering.
+ * Return new value.
+ */
 static __always_inline s64
 arch_atomic64_dec_return(atomic64_t *v)
 {
@@ -2755,6 +2941,13 @@ arch_atomic64_fetch_dec_release(atomic64_t *v)
 #endif
 
 #ifndef arch_atomic64_fetch_dec
+/**
+ * arch_atomic64_fetch_dec - Atomic dec with full ordering
+ * @v: pointer of type atomic64_t
+ *
+ * Atomically decrement @v using full ordering.
+ * Return old value.
+ */
 static __always_inline s64
 arch_atomic64_fetch_dec(atomic64_t *v)
 {
@@ -2813,6 +3006,14 @@ arch_atomic64_fetch_and_release(s64 i, atomic64_t *v)
 #endif
 
 #ifndef arch_atomic64_fetch_and
+/**
+ * arch_atomic64_fetch_and - Atomic and with full ordering
+ * @i: value to AND
+ * @v: pointer of type atomic64_t
+ *
+ * Atomically AND @i with @v using full ordering.
+ * Return old value.
+ */
 static __always_inline s64
 arch_atomic64_fetch_and(s64 i, atomic64_t *v)
 {
@@ -2959,6 +3160,14 @@ arch_atomic64_fetch_andnot_release(s64 i, atomic64_t *v)
 #endif
 
 #ifndef arch_atomic64_fetch_andnot
+/**
+ * arch_atomic64_fetch_andnot - Atomic andnot with full ordering
+ * @i: value to complement then AND
+ * @v: pointer of type atomic64_t
+ *
+ * Atomically complement then AND @i with @v using full ordering.
+ * Return old value.
+ */
 static __always_inline s64
 arch_atomic64_fetch_andnot(s64 i, atomic64_t *v)
 {
@@ -3017,6 +3226,14 @@ arch_atomic64_fetch_or_release(s64 i, atomic64_t *v)
 #endif
 
 #ifndef arch_atomic64_fetch_or
+/**
+ * arch_atomic64_fetch_or - Atomic or with full ordering
+ * @i: value to OR
+ * @v: pointer of type atomic64_t
+ *
+ * Atomically OR @i with @v using full ordering.
+ * Return old value.
+ */
 static __always_inline s64
 arch_atomic64_fetch_or(s64 i, atomic64_t *v)
 {
@@ -3075,6 +3292,14 @@ arch_atomic64_fetch_xor_release(s64 i, atomic64_t *v)
 #endif
 
 #ifndef arch_atomic64_fetch_xor
+/**
+ * arch_atomic64_fetch_xor - Atomic xor with full ordering
+ * @i: value to XOR
+ * @v: pointer of type atomic64_t
+ *
+ * Atomically XOR @i with @v using full ordering.
+ * Return old value.
+ */
 static __always_inline s64
 arch_atomic64_fetch_xor(s64 i, atomic64_t *v)
 {
@@ -3133,6 +3358,14 @@ arch_atomic64_xchg_release(atomic64_t *v, s64 i)
 #endif
 
 #ifndef arch_atomic64_xchg
+/**
+ * arch_atomic64_xchg - Atomic xchg with full ordering
+ * @v: pointer of type atomic64_t
+ * @i: value to exchange
+ *
+ * Atomically exchange @i with @v using full ordering.
+ * Return old value.
+ */
 static __always_inline s64
 arch_atomic64_xchg(atomic64_t *v, s64 i)
 {
@@ -3199,6 +3432,18 @@ arch_atomic64_cmpxchg_release(atomic64_t *v, s64 old, s64 new)
 #endif
 
 #ifndef arch_atomic64_cmpxchg
+/**
+ * arch_atomic64_cmpxchg - Atomic cmpxchg with full ordering
+ * @v: pointer of type atomic64_t
+ * @old: desired old value to match
+ * @new: new value to put in
+ *
+ * Atomically compares @new to *@v, and if equal,
+ * stores @new to *@v, providing full ordering.
+ * Returns the old value *@v regardless of the result of
+ * the comparison.  Therefore, if the return value is not
+ * equal to @old, the cmpxchg operation failed.
+ */
 static __always_inline s64
 arch_atomic64_cmpxchg(atomic64_t *v, s64 old, s64 new)
 {
@@ -3360,6 +3605,18 @@ arch_atomic64_try_cmpxchg_release(atomic64_t *v, s64 *old, s64 new)
 #endif
 
 #ifndef arch_atomic64_try_cmpxchg
+/**
+ * arch_atomic64_try_cmpxchg - Atomic try_cmpxchg with full ordering
+ * @v: pointer of type atomic64_t
+ * @old: desired old value to match
+ * @new: new value to put in
+ *
+ * Atomically compares @new to *@v, and if equal,
+ * stores @new to *@v, providing full ordering.
+ * Returns @true if the cmpxchg operation succeeded,
+ * and false otherwise.  Either way, stores the old
+ * value of *@v to *@old.
+ */
 static __always_inline bool
 arch_atomic64_try_cmpxchg(atomic64_t *v, s64 *old, s64 new)
 {
@@ -3543,6 +3800,15 @@ arch_atomic64_add_negative_release(s64 i, atomic64_t *v)
 #endif
 
 #ifndef arch_atomic64_add_negative
+/**
+ * arch_atomic64_add_negative - Atomic add_negative with full ordering
+ * @i: value to add
+ * @v: pointer of type atomic64_t
+ *
+ * Atomically add @i with @v using full ordering.
+ * Return @true if the result is negative, or @false when
+ * the result is greater than or equal to zero.
+ */
 static __always_inline bool
 arch_atomic64_add_negative(s64 i, atomic64_t *v)
 {
@@ -3692,4 +3958,4 @@ arch_atomic64_dec_if_positive(atomic64_t *v)
 #endif
 
 #endif /* _LINUX_ATOMIC_FALLBACK_H */
-// 2caf9e8360f71f3841789431533b32b620a12c1e
+// 7c2c97cd48cf9c672efc44b9fed5a37b8970dde4
diff --git a/scripts/atomic/fallbacks/fence b/scripts/atomic/fallbacks/fence
index 07757d8e338e..975855dfba25 100755
--- a/scripts/atomic/fallbacks/fence
+++ b/scripts/atomic/fallbacks/fence
@@ -1,3 +1,5 @@
+acqrel=full
+. ${ATOMICDIR}/acqrel.sh
 cat <<EOF
 static __always_inline ${ret}
 arch_${atomic}_${pfx}${name}${sfx}(${params})
-- 
2.40.1

