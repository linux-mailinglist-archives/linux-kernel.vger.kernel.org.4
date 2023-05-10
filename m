Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6287F6FE3D0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 20:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233011AbjEJSR5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 14:17:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232680AbjEJSRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 14:17:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 450C87698;
        Wed, 10 May 2023 11:17:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1468F63F84;
        Wed, 10 May 2023 18:17:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B39EC4339E;
        Wed, 10 May 2023 18:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683742639;
        bh=zZ3XxzsBzG+T4eWG6R7cIa9XtqUZca0NtqY/PyOE+Z4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=swv48Cj1DjA/SiutaZI0kAPe3JBqdZVJj69UGOZftIExWF3qhIZqkZZOAWh83vSO5
         a9VP3DvFqvvpszxK0GiRuAGbaYBGKDXTI1NgoT2E0evA4PrbQiG1ozJMO7Ep402ILQ
         /QThqrF6oNUKKHgIuk/NNVpJNaRir0ME6MHVpGF47m3LQOs3pnJdATnP++cBUELZ5D
         5kt8v2dA4BU7ImSHvZBuG9jafj6ActIPAMgD2tFopWFNI9178lIUnQulcvNbqjK379
         L3G303Nx+P6o8NADwMIOlb38RgN00GmSYIJOQxdVhChEdTQ/cqg/mPojGhXax7TtNG
         d8eQSA+Nxmv2A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id D89F7CE1400; Wed, 10 May 2023 11:17:18 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, akiyks@gmail.com, linux-doc@vger.kernel.org,
        kernel-team@meta.com, "Paul E. McKenney" <paulmck@kernel.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH locking/atomic 04/19] locking/atomic: Add kernel-doc header for arch_${atomic}_${pfx}inc${sfx}${order}
Date:   Wed, 10 May 2023 11:17:02 -0700
Message-Id: <20230510181717.2200934-4-paulmck@kernel.org>
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

Add kernel-doc header template for arch_${atomic}_${pfx}inc${sfx}${order}
function family.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Will Deacon <will@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>
---
 include/linux/atomic/atomic-arch-fallback.h | 128 +++++++++++++++++++-
 scripts/atomic/fallbacks/inc                |   7 ++
 2 files changed, 134 insertions(+), 1 deletion(-)

diff --git a/include/linux/atomic/atomic-arch-fallback.h b/include/linux/atomic/atomic-arch-fallback.h
index 606be9d3aa22..e7e83f18d192 100644
--- a/include/linux/atomic/atomic-arch-fallback.h
+++ b/include/linux/atomic/atomic-arch-fallback.h
@@ -440,6 +440,13 @@ arch_atomic_fetch_sub(int i, atomic_t *v)
 #endif /* arch_atomic_fetch_sub_relaxed */
 
 #ifndef arch_atomic_inc
+/**
+ * arch_atomic_inc - Atomic increment
+ * @v: pointer of type atomic_t
+ *
+ * Atomically increment @v with full ordering,
+ * returning no value.
+ */
 static __always_inline void
 arch_atomic_inc(atomic_t *v)
 {
@@ -456,6 +463,13 @@ arch_atomic_inc(atomic_t *v)
 #endif /* arch_atomic_inc_return */
 
 #ifndef arch_atomic_inc_return
+/**
+ * arch_atomic_inc_return - Atomic increment
+ * @v: pointer of type atomic_t
+ *
+ * Atomically increment @v with full ordering,
+ * returning new value.
+ */
 static __always_inline int
 arch_atomic_inc_return(atomic_t *v)
 {
@@ -465,6 +479,13 @@ arch_atomic_inc_return(atomic_t *v)
 #endif
 
 #ifndef arch_atomic_inc_return_acquire
+/**
+ * arch_atomic_inc_return_acquire - Atomic increment
+ * @v: pointer of type atomic_t
+ *
+ * Atomically increment @v with acquire ordering,
+ * returning new value.
+ */
 static __always_inline int
 arch_atomic_inc_return_acquire(atomic_t *v)
 {
@@ -474,6 +495,13 @@ arch_atomic_inc_return_acquire(atomic_t *v)
 #endif
 
 #ifndef arch_atomic_inc_return_release
+/**
+ * arch_atomic_inc_return_release - Atomic increment
+ * @v: pointer of type atomic_t
+ *
+ * Atomically increment @v with release ordering,
+ * returning new value.
+ */
 static __always_inline int
 arch_atomic_inc_return_release(atomic_t *v)
 {
@@ -483,6 +511,13 @@ arch_atomic_inc_return_release(atomic_t *v)
 #endif
 
 #ifndef arch_atomic_inc_return_relaxed
+/**
+ * arch_atomic_inc_return_relaxed - Atomic increment
+ * @v: pointer of type atomic_t
+ *
+ * Atomically increment @v with no ordering,
+ * returning new value.
+ */
 static __always_inline int
 arch_atomic_inc_return_relaxed(atomic_t *v)
 {
@@ -537,6 +572,13 @@ arch_atomic_inc_return(atomic_t *v)
 #endif /* arch_atomic_fetch_inc */
 
 #ifndef arch_atomic_fetch_inc
+/**
+ * arch_atomic_fetch_inc - Atomic increment
+ * @v: pointer of type atomic_t
+ *
+ * Atomically increment @v with full ordering,
+ * returning old value.
+ */
 static __always_inline int
 arch_atomic_fetch_inc(atomic_t *v)
 {
@@ -546,6 +588,13 @@ arch_atomic_fetch_inc(atomic_t *v)
 #endif
 
 #ifndef arch_atomic_fetch_inc_acquire
+/**
+ * arch_atomic_fetch_inc_acquire - Atomic increment
+ * @v: pointer of type atomic_t
+ *
+ * Atomically increment @v with acquire ordering,
+ * returning old value.
+ */
 static __always_inline int
 arch_atomic_fetch_inc_acquire(atomic_t *v)
 {
@@ -555,6 +604,13 @@ arch_atomic_fetch_inc_acquire(atomic_t *v)
 #endif
 
 #ifndef arch_atomic_fetch_inc_release
+/**
+ * arch_atomic_fetch_inc_release - Atomic increment
+ * @v: pointer of type atomic_t
+ *
+ * Atomically increment @v with release ordering,
+ * returning old value.
+ */
 static __always_inline int
 arch_atomic_fetch_inc_release(atomic_t *v)
 {
@@ -564,6 +620,13 @@ arch_atomic_fetch_inc_release(atomic_t *v)
 #endif
 
 #ifndef arch_atomic_fetch_inc_relaxed
+/**
+ * arch_atomic_fetch_inc_relaxed - Atomic increment
+ * @v: pointer of type atomic_t
+ *
+ * Atomically increment @v with no ordering,
+ * returning old value.
+ */
 static __always_inline int
 arch_atomic_fetch_inc_relaxed(atomic_t *v)
 {
@@ -1656,6 +1719,13 @@ arch_atomic64_fetch_sub(s64 i, atomic64_t *v)
 #endif /* arch_atomic64_fetch_sub_relaxed */
 
 #ifndef arch_atomic64_inc
+/**
+ * arch_atomic64_inc - Atomic increment
+ * @v: pointer of type atomic64_t
+ *
+ * Atomically increment @v with full ordering,
+ * returning no value.
+ */
 static __always_inline void
 arch_atomic64_inc(atomic64_t *v)
 {
@@ -1672,6 +1742,13 @@ arch_atomic64_inc(atomic64_t *v)
 #endif /* arch_atomic64_inc_return */
 
 #ifndef arch_atomic64_inc_return
+/**
+ * arch_atomic64_inc_return - Atomic increment
+ * @v: pointer of type atomic64_t
+ *
+ * Atomically increment @v with full ordering,
+ * returning new value.
+ */
 static __always_inline s64
 arch_atomic64_inc_return(atomic64_t *v)
 {
@@ -1681,6 +1758,13 @@ arch_atomic64_inc_return(atomic64_t *v)
 #endif
 
 #ifndef arch_atomic64_inc_return_acquire
+/**
+ * arch_atomic64_inc_return_acquire - Atomic increment
+ * @v: pointer of type atomic64_t
+ *
+ * Atomically increment @v with acquire ordering,
+ * returning new value.
+ */
 static __always_inline s64
 arch_atomic64_inc_return_acquire(atomic64_t *v)
 {
@@ -1690,6 +1774,13 @@ arch_atomic64_inc_return_acquire(atomic64_t *v)
 #endif
 
 #ifndef arch_atomic64_inc_return_release
+/**
+ * arch_atomic64_inc_return_release - Atomic increment
+ * @v: pointer of type atomic64_t
+ *
+ * Atomically increment @v with release ordering,
+ * returning new value.
+ */
 static __always_inline s64
 arch_atomic64_inc_return_release(atomic64_t *v)
 {
@@ -1699,6 +1790,13 @@ arch_atomic64_inc_return_release(atomic64_t *v)
 #endif
 
 #ifndef arch_atomic64_inc_return_relaxed
+/**
+ * arch_atomic64_inc_return_relaxed - Atomic increment
+ * @v: pointer of type atomic64_t
+ *
+ * Atomically increment @v with no ordering,
+ * returning new value.
+ */
 static __always_inline s64
 arch_atomic64_inc_return_relaxed(atomic64_t *v)
 {
@@ -1753,6 +1851,13 @@ arch_atomic64_inc_return(atomic64_t *v)
 #endif /* arch_atomic64_fetch_inc */
 
 #ifndef arch_atomic64_fetch_inc
+/**
+ * arch_atomic64_fetch_inc - Atomic increment
+ * @v: pointer of type atomic64_t
+ *
+ * Atomically increment @v with full ordering,
+ * returning old value.
+ */
 static __always_inline s64
 arch_atomic64_fetch_inc(atomic64_t *v)
 {
@@ -1762,6 +1867,13 @@ arch_atomic64_fetch_inc(atomic64_t *v)
 #endif
 
 #ifndef arch_atomic64_fetch_inc_acquire
+/**
+ * arch_atomic64_fetch_inc_acquire - Atomic increment
+ * @v: pointer of type atomic64_t
+ *
+ * Atomically increment @v with acquire ordering,
+ * returning old value.
+ */
 static __always_inline s64
 arch_atomic64_fetch_inc_acquire(atomic64_t *v)
 {
@@ -1771,6 +1883,13 @@ arch_atomic64_fetch_inc_acquire(atomic64_t *v)
 #endif
 
 #ifndef arch_atomic64_fetch_inc_release
+/**
+ * arch_atomic64_fetch_inc_release - Atomic increment
+ * @v: pointer of type atomic64_t
+ *
+ * Atomically increment @v with release ordering,
+ * returning old value.
+ */
 static __always_inline s64
 arch_atomic64_fetch_inc_release(atomic64_t *v)
 {
@@ -1780,6 +1899,13 @@ arch_atomic64_fetch_inc_release(atomic64_t *v)
 #endif
 
 #ifndef arch_atomic64_fetch_inc_relaxed
+/**
+ * arch_atomic64_fetch_inc_relaxed - Atomic increment
+ * @v: pointer of type atomic64_t
+ *
+ * Atomically increment @v with no ordering,
+ * returning old value.
+ */
 static __always_inline s64
 arch_atomic64_fetch_inc_relaxed(atomic64_t *v)
 {
@@ -2668,4 +2794,4 @@ arch_atomic64_dec_if_positive(atomic64_t *v)
 #endif
 
 #endif /* _LINUX_ATOMIC_FALLBACK_H */
-// e914194a1a82dfbc39d4d1c79ce1f59f64fb37da
+// 17cefb0ff9b450685d4072202d4a1c309b0606c2
diff --git a/scripts/atomic/fallbacks/inc b/scripts/atomic/fallbacks/inc
index 3c2c3739169e..3f2c0730cd0c 100755
--- a/scripts/atomic/fallbacks/inc
+++ b/scripts/atomic/fallbacks/inc
@@ -1,4 +1,11 @@
 cat <<EOF
+/**
+ * arch_${atomic}_${pfx}inc${sfx}${order} - Atomic increment
+ * @v: pointer of type ${atomic}_t
+ *
+ * Atomically increment @v with ${docbook_order} ordering,
+ * returning ${docbook_oldnew} value.
+ */
 static __always_inline ${ret}
 arch_${atomic}_${pfx}inc${sfx}${order}(${atomic}_t *v)
 {
-- 
2.40.1

