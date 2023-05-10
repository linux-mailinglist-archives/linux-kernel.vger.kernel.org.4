Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5715D6FE3D9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 20:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236154AbjEJSSU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 14:18:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236092AbjEJSSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 14:18:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7F9E7AAE;
        Wed, 10 May 2023 11:17:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F291563EE6;
        Wed, 10 May 2023 18:17:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AD45C433EF;
        Wed, 10 May 2023 18:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683742639;
        bh=36kMQE5a3mUqBnp2yXq6LdyUZdUoydgWI1lu5/K5gTw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RJdm728OldYRMOkLRNzQ5FI7eRVArdLmRojLBRIw/3w316Tm8cEfVRjCTi6+XsdB3
         rsfpXso8EI7pyIDJlMfe7zbCQpd5s6fVcumn3e2xPoEXuWy1jSJWVq8QUYHUX98/0P
         ju7Xj4Xur9Xu3vYcP0zeMZpbCikL7BwGlC095+KqyXP+7dkZPq4dawTBDN1PG24B0Q
         RGltBOKBc9qdA887lnd0OmopaQUDDVHo6bPiidSwzhANNp9FrjJC1tIEa84aOukw3Y
         bGOzYKkQx6XOJ4+Qytdwy8u8qs6aVXuM4uBC95d3e1nPTXP0wOOJwOTOmjZLPL391M
         g5MJXe9Af31aQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id D37EDCE134A; Wed, 10 May 2023 11:17:18 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, akiyks@gmail.com, linux-doc@vger.kernel.org,
        kernel-team@meta.com, "Paul E. McKenney" <paulmck@kernel.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH locking/atomic 02/19] locking/atomic: Add "@" before "true" and "false" for fallback templates
Date:   Wed, 10 May 2023 11:17:00 -0700
Message-Id: <20230510181717.2200934-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <19135936-06d7-4705-8bc8-bb31c2a478ca@paulmck-laptop>
References: <19135936-06d7-4705-8bc8-bb31c2a478ca@paulmck-laptop>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix up kernel-doc pretty-printing by adding "@" before "true" and "false"
for atomic-operation fallback scripts lacking them.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Will Deacon <will@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>
---
 include/linux/atomic/atomic-arch-fallback.h | 54 ++++++++++-----------
 scripts/atomic/fallbacks/add_negative       |  4 +-
 scripts/atomic/fallbacks/add_unless         |  2 +-
 scripts/atomic/fallbacks/dec_and_test       |  2 +-
 scripts/atomic/fallbacks/inc_and_test       |  2 +-
 scripts/atomic/fallbacks/inc_not_zero       |  2 +-
 scripts/atomic/fallbacks/sub_and_test       |  2 +-
 7 files changed, 34 insertions(+), 34 deletions(-)

diff --git a/include/linux/atomic/atomic-arch-fallback.h b/include/linux/atomic/atomic-arch-fallback.h
index c4087c32fb0e..606be9d3aa22 100644
--- a/include/linux/atomic/atomic-arch-fallback.h
+++ b/include/linux/atomic/atomic-arch-fallback.h
@@ -1185,7 +1185,7 @@ arch_atomic_try_cmpxchg(atomic_t *v, int *old, int new)
  * @v: pointer of type atomic_t
  *
  * Atomically subtracts @i from @v and returns
- * true if the result is zero, or false for all
+ * @true if the result is zero, or @false for all
  * other cases.
  */
 static __always_inline bool
@@ -1202,7 +1202,7 @@ arch_atomic_sub_and_test(int i, atomic_t *v)
  * @v: pointer of type atomic_t
  *
  * Atomically decrements @v by 1 and
- * returns true if the result is 0, or false for all other
+ * returns @true if the result is 0, or @false for all other
  * cases.
  */
 static __always_inline bool
@@ -1219,7 +1219,7 @@ arch_atomic_dec_and_test(atomic_t *v)
  * @v: pointer of type atomic_t
  *
  * Atomically increments @v by 1
- * and returns true if the result is zero, or false for all
+ * and returns @true if the result is zero, or @false for all
  * other cases.
  */
 static __always_inline bool
@@ -1243,8 +1243,8 @@ arch_atomic_inc_and_test(atomic_t *v)
  * @i: integer value to add
  * @v: pointer of type atomic_t
  *
- * Atomically adds @i to @v and returns true if the result is negative,
- * or false when the result is greater than or equal to zero.
+ * Atomically adds @i to @v and returns @true if the result is negative,
+ * or @false when the result is greater than or equal to zero.
  */
 static __always_inline bool
 arch_atomic_add_negative(int i, atomic_t *v)
@@ -1260,8 +1260,8 @@ arch_atomic_add_negative(int i, atomic_t *v)
  * @i: integer value to add
  * @v: pointer of type atomic_t
  *
- * Atomically adds @i to @v and returns true if the result is negative,
- * or false when the result is greater than or equal to zero.
+ * Atomically adds @i to @v and returns @true if the result is negative,
+ * or @false when the result is greater than or equal to zero.
  */
 static __always_inline bool
 arch_atomic_add_negative_acquire(int i, atomic_t *v)
@@ -1277,8 +1277,8 @@ arch_atomic_add_negative_acquire(int i, atomic_t *v)
  * @i: integer value to add
  * @v: pointer of type atomic_t
  *
- * Atomically adds @i to @v and returns true if the result is negative,
- * or false when the result is greater than or equal to zero.
+ * Atomically adds @i to @v and returns @true if the result is negative,
+ * or @false when the result is greater than or equal to zero.
  */
 static __always_inline bool
 arch_atomic_add_negative_release(int i, atomic_t *v)
@@ -1294,8 +1294,8 @@ arch_atomic_add_negative_release(int i, atomic_t *v)
  * @i: integer value to add
  * @v: pointer of type atomic_t
  *
- * Atomically adds @i to @v and returns true if the result is negative,
- * or false when the result is greater than or equal to zero.
+ * Atomically adds @i to @v and returns @true if the result is negative,
+ * or @false when the result is greater than or equal to zero.
  */
 static __always_inline bool
 arch_atomic_add_negative_relaxed(int i, atomic_t *v)
@@ -1376,7 +1376,7 @@ arch_atomic_fetch_add_unless(atomic_t *v, int a, int u)
  * @u: ...unless v is equal to u.
  *
  * Atomically adds @a to @v, if @v was not already @u.
- * Returns true if the addition was done.
+ * Returns @true if the addition was done.
  */
 static __always_inline bool
 arch_atomic_add_unless(atomic_t *v, int a, int u)
@@ -1392,7 +1392,7 @@ arch_atomic_add_unless(atomic_t *v, int a, int u)
  * @v: pointer of type atomic_t
  *
  * Atomically increments @v by 1, if @v is non-zero.
- * Returns true if the increment was done.
+ * Returns @true if the increment was done.
  */
 static __always_inline bool
 arch_atomic_inc_not_zero(atomic_t *v)
@@ -2401,7 +2401,7 @@ arch_atomic64_try_cmpxchg(atomic64_t *v, s64 *old, s64 new)
  * @v: pointer of type atomic64_t
  *
  * Atomically subtracts @i from @v and returns
- * true if the result is zero, or false for all
+ * @true if the result is zero, or @false for all
  * other cases.
  */
 static __always_inline bool
@@ -2418,7 +2418,7 @@ arch_atomic64_sub_and_test(s64 i, atomic64_t *v)
  * @v: pointer of type atomic64_t
  *
  * Atomically decrements @v by 1 and
- * returns true if the result is 0, or false for all other
+ * returns @true if the result is 0, or @false for all other
  * cases.
  */
 static __always_inline bool
@@ -2435,7 +2435,7 @@ arch_atomic64_dec_and_test(atomic64_t *v)
  * @v: pointer of type atomic64_t
  *
  * Atomically increments @v by 1
- * and returns true if the result is zero, or false for all
+ * and returns @true if the result is zero, or @false for all
  * other cases.
  */
 static __always_inline bool
@@ -2459,8 +2459,8 @@ arch_atomic64_inc_and_test(atomic64_t *v)
  * @i: integer value to add
  * @v: pointer of type atomic64_t
  *
- * Atomically adds @i to @v and returns true if the result is negative,
- * or false when the result is greater than or equal to zero.
+ * Atomically adds @i to @v and returns @true if the result is negative,
+ * or @false when the result is greater than or equal to zero.
  */
 static __always_inline bool
 arch_atomic64_add_negative(s64 i, atomic64_t *v)
@@ -2476,8 +2476,8 @@ arch_atomic64_add_negative(s64 i, atomic64_t *v)
  * @i: integer value to add
  * @v: pointer of type atomic64_t
  *
- * Atomically adds @i to @v and returns true if the result is negative,
- * or false when the result is greater than or equal to zero.
+ * Atomically adds @i to @v and returns @true if the result is negative,
+ * or @false when the result is greater than or equal to zero.
  */
 static __always_inline bool
 arch_atomic64_add_negative_acquire(s64 i, atomic64_t *v)
@@ -2493,8 +2493,8 @@ arch_atomic64_add_negative_acquire(s64 i, atomic64_t *v)
  * @i: integer value to add
  * @v: pointer of type atomic64_t
  *
- * Atomically adds @i to @v and returns true if the result is negative,
- * or false when the result is greater than or equal to zero.
+ * Atomically adds @i to @v and returns @true if the result is negative,
+ * or @false when the result is greater than or equal to zero.
  */
 static __always_inline bool
 arch_atomic64_add_negative_release(s64 i, atomic64_t *v)
@@ -2510,8 +2510,8 @@ arch_atomic64_add_negative_release(s64 i, atomic64_t *v)
  * @i: integer value to add
  * @v: pointer of type atomic64_t
  *
- * Atomically adds @i to @v and returns true if the result is negative,
- * or false when the result is greater than or equal to zero.
+ * Atomically adds @i to @v and returns @true if the result is negative,
+ * or @false when the result is greater than or equal to zero.
  */
 static __always_inline bool
 arch_atomic64_add_negative_relaxed(s64 i, atomic64_t *v)
@@ -2592,7 +2592,7 @@ arch_atomic64_fetch_add_unless(atomic64_t *v, s64 a, s64 u)
  * @u: ...unless v is equal to u.
  *
  * Atomically adds @a to @v, if @v was not already @u.
- * Returns true if the addition was done.
+ * Returns @true if the addition was done.
  */
 static __always_inline bool
 arch_atomic64_add_unless(atomic64_t *v, s64 a, s64 u)
@@ -2608,7 +2608,7 @@ arch_atomic64_add_unless(atomic64_t *v, s64 a, s64 u)
  * @v: pointer of type atomic64_t
  *
  * Atomically increments @v by 1, if @v is non-zero.
- * Returns true if the increment was done.
+ * Returns @true if the increment was done.
  */
 static __always_inline bool
 arch_atomic64_inc_not_zero(atomic64_t *v)
@@ -2668,4 +2668,4 @@ arch_atomic64_dec_if_positive(atomic64_t *v)
 #endif
 
 #endif /* _LINUX_ATOMIC_FALLBACK_H */
-// 201cc01b616875888e0b2c79965c569a89c0edcd
+// e914194a1a82dfbc39d4d1c79ce1f59f64fb37da
diff --git a/scripts/atomic/fallbacks/add_negative b/scripts/atomic/fallbacks/add_negative
index e5980abf5904..c032e8bec6e2 100755
--- a/scripts/atomic/fallbacks/add_negative
+++ b/scripts/atomic/fallbacks/add_negative
@@ -4,8 +4,8 @@ cat <<EOF
  * @i: integer value to add
  * @v: pointer of type ${atomic}_t
  *
- * Atomically adds @i to @v and returns true if the result is negative,
- * or false when the result is greater than or equal to zero.
+ * Atomically adds @i to @v and returns @true if the result is negative,
+ * or @false when the result is greater than or equal to zero.
  */
 static __always_inline bool
 arch_${atomic}_add_negative${order}(${int} i, ${atomic}_t *v)
diff --git a/scripts/atomic/fallbacks/add_unless b/scripts/atomic/fallbacks/add_unless
index 9e5159c2ccfc..650fee935aed 100755
--- a/scripts/atomic/fallbacks/add_unless
+++ b/scripts/atomic/fallbacks/add_unless
@@ -6,7 +6,7 @@ cat << EOF
  * @u: ...unless v is equal to u.
  *
  * Atomically adds @a to @v, if @v was not already @u.
- * Returns true if the addition was done.
+ * Returns @true if the addition was done.
  */
 static __always_inline bool
 arch_${atomic}_add_unless(${atomic}_t *v, ${int} a, ${int} u)
diff --git a/scripts/atomic/fallbacks/dec_and_test b/scripts/atomic/fallbacks/dec_and_test
index 8549f359bd0e..3720896b1afc 100755
--- a/scripts/atomic/fallbacks/dec_and_test
+++ b/scripts/atomic/fallbacks/dec_and_test
@@ -4,7 +4,7 @@ cat <<EOF
  * @v: pointer of type ${atomic}_t
  *
  * Atomically decrements @v by 1 and
- * returns true if the result is 0, or false for all other
+ * returns @true if the result is 0, or @false for all other
  * cases.
  */
 static __always_inline bool
diff --git a/scripts/atomic/fallbacks/inc_and_test b/scripts/atomic/fallbacks/inc_and_test
index 0cf23fe1efb8..cc3ac1dde508 100755
--- a/scripts/atomic/fallbacks/inc_and_test
+++ b/scripts/atomic/fallbacks/inc_and_test
@@ -4,7 +4,7 @@ cat <<EOF
  * @v: pointer of type ${atomic}_t
  *
  * Atomically increments @v by 1
- * and returns true if the result is zero, or false for all
+ * and returns @true if the result is zero, or @false for all
  * other cases.
  */
 static __always_inline bool
diff --git a/scripts/atomic/fallbacks/inc_not_zero b/scripts/atomic/fallbacks/inc_not_zero
index ed8a1f562667..891fa3c057f6 100755
--- a/scripts/atomic/fallbacks/inc_not_zero
+++ b/scripts/atomic/fallbacks/inc_not_zero
@@ -4,7 +4,7 @@ cat <<EOF
  * @v: pointer of type ${atomic}_t
  *
  * Atomically increments @v by 1, if @v is non-zero.
- * Returns true if the increment was done.
+ * Returns @true if the increment was done.
  */
 static __always_inline bool
 arch_${atomic}_inc_not_zero(${atomic}_t *v)
diff --git a/scripts/atomic/fallbacks/sub_and_test b/scripts/atomic/fallbacks/sub_and_test
index 260f37341c88..204282e260ea 100755
--- a/scripts/atomic/fallbacks/sub_and_test
+++ b/scripts/atomic/fallbacks/sub_and_test
@@ -5,7 +5,7 @@ cat <<EOF
  * @v: pointer of type ${atomic}_t
  *
  * Atomically subtracts @i from @v and returns
- * true if the result is zero, or false for all
+ * @true if the result is zero, or @false for all
  * other cases.
  */
 static __always_inline bool
-- 
2.40.1

