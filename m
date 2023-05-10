Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2161E6FE3E7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 20:19:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236405AbjEJSTA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 14:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236076AbjEJSSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 14:18:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E76457ED6;
        Wed, 10 May 2023 11:18:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 317EB63F87;
        Wed, 10 May 2023 18:17:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 970B4C433D2;
        Wed, 10 May 2023 18:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683742644;
        bh=0NNr6pXpT4nPPvOEzgx3h6iYrhe2MKVVK49PaoO8bUE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PkJiGnQerc3TzX9FDzvkK0UUi8VoowqO17Bvc8Qkmk4MgxT0yW1ov0ieLq/k85k04
         53uap/CnEtEHlOQDl4Nvh/O7z1phP+S2JjGGbRGPZIDCXLLywN3DUnQlpt/UXo330q
         niA/E173A+Fewiy5EMprfUqmqE1AGqkblzsb1a1SYhWOKjRJMmcF8Qx1A395qKvaGy
         Dg4uIZ97XwwFRs9hIbOqWEx92vvWSycBV+qrUnJpXKnjHp70Fx2ol4e1dQN8yOet0q
         lZDjjBKHNUIVPxvc6XSwKl/w3aX37wPfqX4XNNKf8HJIEIozqslPe5DM5HYjHYP//t
         FJ0D2H36Wxftw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id DD7FECE16A7; Wed, 10 May 2023 11:17:18 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, akiyks@gmail.com, linux-doc@vger.kernel.org,
        kernel-team@meta.com, "Paul E. McKenney" <paulmck@kernel.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH locking/atomic 06/19] locking/atomic: Add kernel-doc header for arch_${atomic}_${pfx}andnot${sfx}${order}
Date:   Wed, 10 May 2023 11:17:04 -0700
Message-Id: <20230510181717.2200934-6-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <19135936-06d7-4705-8bc8-bb31c2a478ca@paulmck-laptop>
References: <19135936-06d7-4705-8bc8-bb31c2a478ca@paulmck-laptop>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add kernel-doc header template for arch_${atomic}_${pfx}andnot${sfx}${order}
function family.

[ paulmck: Apply feedback from Akira Yokosawa. ]

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Will Deacon <will@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>
---
 include/linux/atomic/atomic-arch-fallback.h | 82 ++++++++++++++++++++-
 scripts/atomic/fallbacks/andnot             |  8 ++
 2 files changed, 89 insertions(+), 1 deletion(-)

diff --git a/include/linux/atomic/atomic-arch-fallback.h b/include/linux/atomic/atomic-arch-fallback.h
index 41e43e8dff8d..d5ff29a7128d 100644
--- a/include/linux/atomic/atomic-arch-fallback.h
+++ b/include/linux/atomic/atomic-arch-fallback.h
@@ -950,6 +950,14 @@ arch_atomic_fetch_and(int i, atomic_t *v)
 #endif /* arch_atomic_fetch_and_relaxed */
 
 #ifndef arch_atomic_andnot
+/**
+ * arch_atomic_andnot - Atomic and-not
+ * @i: the quantity to and-not with *@v
+ * @v: pointer of type atomic_t
+ *
+ * Atomically and-not @i with @v using full ordering.
+ * returning no value.
+ */
 static __always_inline void
 arch_atomic_andnot(int i, atomic_t *v)
 {
@@ -966,6 +974,14 @@ arch_atomic_andnot(int i, atomic_t *v)
 #endif /* arch_atomic_fetch_andnot */
 
 #ifndef arch_atomic_fetch_andnot
+/**
+ * arch_atomic_fetch_andnot - Atomic and-not
+ * @i: the quantity to and-not with *@v
+ * @v: pointer of type atomic_t
+ *
+ * Atomically and-not @i with @v using full ordering.
+ * returning old value.
+ */
 static __always_inline int
 arch_atomic_fetch_andnot(int i, atomic_t *v)
 {
@@ -975,6 +991,14 @@ arch_atomic_fetch_andnot(int i, atomic_t *v)
 #endif
 
 #ifndef arch_atomic_fetch_andnot_acquire
+/**
+ * arch_atomic_fetch_andnot_acquire - Atomic and-not
+ * @i: the quantity to and-not with *@v
+ * @v: pointer of type atomic_t
+ *
+ * Atomically and-not @i with @v using acquire ordering.
+ * returning old value.
+ */
 static __always_inline int
 arch_atomic_fetch_andnot_acquire(int i, atomic_t *v)
 {
@@ -984,6 +1008,14 @@ arch_atomic_fetch_andnot_acquire(int i, atomic_t *v)
 #endif
 
 #ifndef arch_atomic_fetch_andnot_release
+/**
+ * arch_atomic_fetch_andnot_release - Atomic and-not
+ * @i: the quantity to and-not with *@v
+ * @v: pointer of type atomic_t
+ *
+ * Atomically and-not @i with @v using release ordering.
+ * returning old value.
+ */
 static __always_inline int
 arch_atomic_fetch_andnot_release(int i, atomic_t *v)
 {
@@ -993,6 +1025,14 @@ arch_atomic_fetch_andnot_release(int i, atomic_t *v)
 #endif
 
 #ifndef arch_atomic_fetch_andnot_relaxed
+/**
+ * arch_atomic_fetch_andnot_relaxed - Atomic and-not
+ * @i: the quantity to and-not with *@v
+ * @v: pointer of type atomic_t
+ *
+ * Atomically and-not @i with @v using no ordering.
+ * returning old value.
+ */
 static __always_inline int
 arch_atomic_fetch_andnot_relaxed(int i, atomic_t *v)
 {
@@ -2292,6 +2332,14 @@ arch_atomic64_fetch_and(s64 i, atomic64_t *v)
 #endif /* arch_atomic64_fetch_and_relaxed */
 
 #ifndef arch_atomic64_andnot
+/**
+ * arch_atomic64_andnot - Atomic and-not
+ * @i: the quantity to and-not with *@v
+ * @v: pointer of type atomic64_t
+ *
+ * Atomically and-not @i with @v using full ordering.
+ * returning no value.
+ */
 static __always_inline void
 arch_atomic64_andnot(s64 i, atomic64_t *v)
 {
@@ -2308,6 +2356,14 @@ arch_atomic64_andnot(s64 i, atomic64_t *v)
 #endif /* arch_atomic64_fetch_andnot */
 
 #ifndef arch_atomic64_fetch_andnot
+/**
+ * arch_atomic64_fetch_andnot - Atomic and-not
+ * @i: the quantity to and-not with *@v
+ * @v: pointer of type atomic64_t
+ *
+ * Atomically and-not @i with @v using full ordering.
+ * returning old value.
+ */
 static __always_inline s64
 arch_atomic64_fetch_andnot(s64 i, atomic64_t *v)
 {
@@ -2317,6 +2373,14 @@ arch_atomic64_fetch_andnot(s64 i, atomic64_t *v)
 #endif
 
 #ifndef arch_atomic64_fetch_andnot_acquire
+/**
+ * arch_atomic64_fetch_andnot_acquire - Atomic and-not
+ * @i: the quantity to and-not with *@v
+ * @v: pointer of type atomic64_t
+ *
+ * Atomically and-not @i with @v using acquire ordering.
+ * returning old value.
+ */
 static __always_inline s64
 arch_atomic64_fetch_andnot_acquire(s64 i, atomic64_t *v)
 {
@@ -2326,6 +2390,14 @@ arch_atomic64_fetch_andnot_acquire(s64 i, atomic64_t *v)
 #endif
 
 #ifndef arch_atomic64_fetch_andnot_release
+/**
+ * arch_atomic64_fetch_andnot_release - Atomic and-not
+ * @i: the quantity to and-not with *@v
+ * @v: pointer of type atomic64_t
+ *
+ * Atomically and-not @i with @v using release ordering.
+ * returning old value.
+ */
 static __always_inline s64
 arch_atomic64_fetch_andnot_release(s64 i, atomic64_t *v)
 {
@@ -2335,6 +2407,14 @@ arch_atomic64_fetch_andnot_release(s64 i, atomic64_t *v)
 #endif
 
 #ifndef arch_atomic64_fetch_andnot_relaxed
+/**
+ * arch_atomic64_fetch_andnot_relaxed - Atomic and-not
+ * @i: the quantity to and-not with *@v
+ * @v: pointer of type atomic64_t
+ *
+ * Atomically and-not @i with @v using no ordering.
+ * returning old value.
+ */
 static __always_inline s64
 arch_atomic64_fetch_andnot_relaxed(s64 i, atomic64_t *v)
 {
@@ -2920,4 +3000,4 @@ arch_atomic64_dec_if_positive(atomic64_t *v)
 #endif
 
 #endif /* _LINUX_ATOMIC_FALLBACK_H */
-// 1a1d30491494653253bfe3b5d2e2c6583cb57473
+// e403f06ce98fe72ae0698e8f2c78f8a45894e465
diff --git a/scripts/atomic/fallbacks/andnot b/scripts/atomic/fallbacks/andnot
index 5a42f54a3595..9fbc0ce75a7c 100755
--- a/scripts/atomic/fallbacks/andnot
+++ b/scripts/atomic/fallbacks/andnot
@@ -1,4 +1,12 @@
 cat <<EOF
+/**
+ * arch_${atomic}_${pfx}andnot${sfx}${order} - Atomic and-not
+ * @i: the quantity to and-not with *@v
+ * @v: pointer of type ${atomic}_t
+ *
+ * Atomically and-not @i with @v using ${docbook_order} ordering.
+ * returning ${docbook_oldnew} value.
+ */
 static __always_inline ${ret}
 arch_${atomic}_${pfx}andnot${sfx}${order}(${int} i, ${atomic}_t *v)
 {
-- 
2.40.1

