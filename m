Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7050C6FE3DA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 20:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232680AbjEJSSY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 14:18:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236114AbjEJSSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 14:18:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7D2B7AA7;
        Wed, 10 May 2023 11:17:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1CFA663F85;
        Wed, 10 May 2023 18:17:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72391C4339C;
        Wed, 10 May 2023 18:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683742639;
        bh=iiJ/VzQpstXqdm3RN63oyTIvoY5ZmUM0BoWf7nHGo3s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pGXkvifBANBwFxv+VhyFewAoIZARO3vmZjp8qrln5HSEa39f99X5TL1K1btzJ+wze
         bH/wE4vffWqeAnEDdXwkuIYxOc3oyZCvOkYoXrz/BWKTjQswIn0Q1Jgv5RkwZ4CFBI
         xjvsZpoMkPBB1AwXZ8LXp8aa5SSh1TaU85MGp5mK4FNcOMKsuaMAQme9SxNvoND7q7
         8M+I+qLP4mtAdh7By0Hgbr5cEw8Yd5QRa2E6MjaxwE6WcAwvO6rAzOpYzNPtbxvKDD
         DMahCot6e0rdpS9+VfermloCH/UpqRfK1l79qyTdddGG9O8Ho+hgQzNj/xmOIrFol7
         beH4ALztdlpeA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id DB181CE1434; Wed, 10 May 2023 11:17:18 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, akiyks@gmail.com, linux-doc@vger.kernel.org,
        kernel-team@meta.com, "Paul E. McKenney" <paulmck@kernel.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH locking/atomic 05/19] locking/atomic: Add kernel-doc header for arch_${atomic}_${pfx}dec${sfx}${order}
Date:   Wed, 10 May 2023 11:17:03 -0700
Message-Id: <20230510181717.2200934-5-paulmck@kernel.org>
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

Add kernel-doc header template for arch_${atomic}_${pfx}dec${sfx}${order}
function family.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Will Deacon <will@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>
---
 include/linux/atomic/atomic-arch-fallback.h | 128 +++++++++++++++++++-
 scripts/atomic/fallbacks/dec                |   7 ++
 2 files changed, 134 insertions(+), 1 deletion(-)

diff --git a/include/linux/atomic/atomic-arch-fallback.h b/include/linux/atomic/atomic-arch-fallback.h
index e7e83f18d192..41e43e8dff8d 100644
--- a/include/linux/atomic/atomic-arch-fallback.h
+++ b/include/linux/atomic/atomic-arch-fallback.h
@@ -674,6 +674,13 @@ arch_atomic_fetch_inc(atomic_t *v)
 #endif /* arch_atomic_fetch_inc_relaxed */
 
 #ifndef arch_atomic_dec
+/**
+ * arch_atomic_dec - Atomic decrement
+ * @v: pointer of type atomic_t
+ *
+ * Atomically decrement @v with full ordering,
+ * returning no value.
+ */
 static __always_inline void
 arch_atomic_dec(atomic_t *v)
 {
@@ -690,6 +697,13 @@ arch_atomic_dec(atomic_t *v)
 #endif /* arch_atomic_dec_return */
 
 #ifndef arch_atomic_dec_return
+/**
+ * arch_atomic_dec_return - Atomic decrement
+ * @v: pointer of type atomic_t
+ *
+ * Atomically decrement @v with full ordering,
+ * returning new value.
+ */
 static __always_inline int
 arch_atomic_dec_return(atomic_t *v)
 {
@@ -699,6 +713,13 @@ arch_atomic_dec_return(atomic_t *v)
 #endif
 
 #ifndef arch_atomic_dec_return_acquire
+/**
+ * arch_atomic_dec_return_acquire - Atomic decrement
+ * @v: pointer of type atomic_t
+ *
+ * Atomically decrement @v with acquire ordering,
+ * returning new value.
+ */
 static __always_inline int
 arch_atomic_dec_return_acquire(atomic_t *v)
 {
@@ -708,6 +729,13 @@ arch_atomic_dec_return_acquire(atomic_t *v)
 #endif
 
 #ifndef arch_atomic_dec_return_release
+/**
+ * arch_atomic_dec_return_release - Atomic decrement
+ * @v: pointer of type atomic_t
+ *
+ * Atomically decrement @v with release ordering,
+ * returning new value.
+ */
 static __always_inline int
 arch_atomic_dec_return_release(atomic_t *v)
 {
@@ -717,6 +745,13 @@ arch_atomic_dec_return_release(atomic_t *v)
 #endif
 
 #ifndef arch_atomic_dec_return_relaxed
+/**
+ * arch_atomic_dec_return_relaxed - Atomic decrement
+ * @v: pointer of type atomic_t
+ *
+ * Atomically decrement @v with no ordering,
+ * returning new value.
+ */
 static __always_inline int
 arch_atomic_dec_return_relaxed(atomic_t *v)
 {
@@ -771,6 +806,13 @@ arch_atomic_dec_return(atomic_t *v)
 #endif /* arch_atomic_fetch_dec */
 
 #ifndef arch_atomic_fetch_dec
+/**
+ * arch_atomic_fetch_dec - Atomic decrement
+ * @v: pointer of type atomic_t
+ *
+ * Atomically decrement @v with full ordering,
+ * returning old value.
+ */
 static __always_inline int
 arch_atomic_fetch_dec(atomic_t *v)
 {
@@ -780,6 +822,13 @@ arch_atomic_fetch_dec(atomic_t *v)
 #endif
 
 #ifndef arch_atomic_fetch_dec_acquire
+/**
+ * arch_atomic_fetch_dec_acquire - Atomic decrement
+ * @v: pointer of type atomic_t
+ *
+ * Atomically decrement @v with acquire ordering,
+ * returning old value.
+ */
 static __always_inline int
 arch_atomic_fetch_dec_acquire(atomic_t *v)
 {
@@ -789,6 +838,13 @@ arch_atomic_fetch_dec_acquire(atomic_t *v)
 #endif
 
 #ifndef arch_atomic_fetch_dec_release
+/**
+ * arch_atomic_fetch_dec_release - Atomic decrement
+ * @v: pointer of type atomic_t
+ *
+ * Atomically decrement @v with release ordering,
+ * returning old value.
+ */
 static __always_inline int
 arch_atomic_fetch_dec_release(atomic_t *v)
 {
@@ -798,6 +854,13 @@ arch_atomic_fetch_dec_release(atomic_t *v)
 #endif
 
 #ifndef arch_atomic_fetch_dec_relaxed
+/**
+ * arch_atomic_fetch_dec_relaxed - Atomic decrement
+ * @v: pointer of type atomic_t
+ *
+ * Atomically decrement @v with no ordering,
+ * returning old value.
+ */
 static __always_inline int
 arch_atomic_fetch_dec_relaxed(atomic_t *v)
 {
@@ -1953,6 +2016,13 @@ arch_atomic64_fetch_inc(atomic64_t *v)
 #endif /* arch_atomic64_fetch_inc_relaxed */
 
 #ifndef arch_atomic64_dec
+/**
+ * arch_atomic64_dec - Atomic decrement
+ * @v: pointer of type atomic64_t
+ *
+ * Atomically decrement @v with full ordering,
+ * returning no value.
+ */
 static __always_inline void
 arch_atomic64_dec(atomic64_t *v)
 {
@@ -1969,6 +2039,13 @@ arch_atomic64_dec(atomic64_t *v)
 #endif /* arch_atomic64_dec_return */
 
 #ifndef arch_atomic64_dec_return
+/**
+ * arch_atomic64_dec_return - Atomic decrement
+ * @v: pointer of type atomic64_t
+ *
+ * Atomically decrement @v with full ordering,
+ * returning new value.
+ */
 static __always_inline s64
 arch_atomic64_dec_return(atomic64_t *v)
 {
@@ -1978,6 +2055,13 @@ arch_atomic64_dec_return(atomic64_t *v)
 #endif
 
 #ifndef arch_atomic64_dec_return_acquire
+/**
+ * arch_atomic64_dec_return_acquire - Atomic decrement
+ * @v: pointer of type atomic64_t
+ *
+ * Atomically decrement @v with acquire ordering,
+ * returning new value.
+ */
 static __always_inline s64
 arch_atomic64_dec_return_acquire(atomic64_t *v)
 {
@@ -1987,6 +2071,13 @@ arch_atomic64_dec_return_acquire(atomic64_t *v)
 #endif
 
 #ifndef arch_atomic64_dec_return_release
+/**
+ * arch_atomic64_dec_return_release - Atomic decrement
+ * @v: pointer of type atomic64_t
+ *
+ * Atomically decrement @v with release ordering,
+ * returning new value.
+ */
 static __always_inline s64
 arch_atomic64_dec_return_release(atomic64_t *v)
 {
@@ -1996,6 +2087,13 @@ arch_atomic64_dec_return_release(atomic64_t *v)
 #endif
 
 #ifndef arch_atomic64_dec_return_relaxed
+/**
+ * arch_atomic64_dec_return_relaxed - Atomic decrement
+ * @v: pointer of type atomic64_t
+ *
+ * Atomically decrement @v with no ordering,
+ * returning new value.
+ */
 static __always_inline s64
 arch_atomic64_dec_return_relaxed(atomic64_t *v)
 {
@@ -2050,6 +2148,13 @@ arch_atomic64_dec_return(atomic64_t *v)
 #endif /* arch_atomic64_fetch_dec */
 
 #ifndef arch_atomic64_fetch_dec
+/**
+ * arch_atomic64_fetch_dec - Atomic decrement
+ * @v: pointer of type atomic64_t
+ *
+ * Atomically decrement @v with full ordering,
+ * returning old value.
+ */
 static __always_inline s64
 arch_atomic64_fetch_dec(atomic64_t *v)
 {
@@ -2059,6 +2164,13 @@ arch_atomic64_fetch_dec(atomic64_t *v)
 #endif
 
 #ifndef arch_atomic64_fetch_dec_acquire
+/**
+ * arch_atomic64_fetch_dec_acquire - Atomic decrement
+ * @v: pointer of type atomic64_t
+ *
+ * Atomically decrement @v with acquire ordering,
+ * returning old value.
+ */
 static __always_inline s64
 arch_atomic64_fetch_dec_acquire(atomic64_t *v)
 {
@@ -2068,6 +2180,13 @@ arch_atomic64_fetch_dec_acquire(atomic64_t *v)
 #endif
 
 #ifndef arch_atomic64_fetch_dec_release
+/**
+ * arch_atomic64_fetch_dec_release - Atomic decrement
+ * @v: pointer of type atomic64_t
+ *
+ * Atomically decrement @v with release ordering,
+ * returning old value.
+ */
 static __always_inline s64
 arch_atomic64_fetch_dec_release(atomic64_t *v)
 {
@@ -2077,6 +2196,13 @@ arch_atomic64_fetch_dec_release(atomic64_t *v)
 #endif
 
 #ifndef arch_atomic64_fetch_dec_relaxed
+/**
+ * arch_atomic64_fetch_dec_relaxed - Atomic decrement
+ * @v: pointer of type atomic64_t
+ *
+ * Atomically decrement @v with no ordering,
+ * returning old value.
+ */
 static __always_inline s64
 arch_atomic64_fetch_dec_relaxed(atomic64_t *v)
 {
@@ -2794,4 +2920,4 @@ arch_atomic64_dec_if_positive(atomic64_t *v)
 #endif
 
 #endif /* _LINUX_ATOMIC_FALLBACK_H */
-// 17cefb0ff9b450685d4072202d4a1c309b0606c2
+// 1a1d30491494653253bfe3b5d2e2c6583cb57473
diff --git a/scripts/atomic/fallbacks/dec b/scripts/atomic/fallbacks/dec
index 8c144c818e9e..e99c8edd36a3 100755
--- a/scripts/atomic/fallbacks/dec
+++ b/scripts/atomic/fallbacks/dec
@@ -1,4 +1,11 @@
 cat <<EOF
+/**
+ * arch_${atomic}_${pfx}dec${sfx}${order} - Atomic decrement
+ * @v: pointer of type ${atomic}_t
+ *
+ * Atomically decrement @v with ${docbook_order} ordering,
+ * returning ${docbook_oldnew} value.
+ */
 static __always_inline ${ret}
 arch_${atomic}_${pfx}dec${sfx}${order}(${atomic}_t *v)
 {
-- 
2.40.1

