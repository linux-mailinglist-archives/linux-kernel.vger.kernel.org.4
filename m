Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB5A6FE3F0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 20:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236557AbjEJSTS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 14:19:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236117AbjEJSST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 14:18:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4C4D659D;
        Wed, 10 May 2023 11:18:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C27F063F92;
        Wed, 10 May 2023 18:17:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA228C433A7;
        Wed, 10 May 2023 18:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683742644;
        bh=cpvv3VEJW+5eargd3gZNCUUoeAAIBIzdoTFRowhV52A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TUE0DR8KKEgUfULoaQ+FPC48KAJ1L4SA47gpCRvQARqdCe61E9oPwdXH5TvmAMA1N
         Ximd1pFgunErS+/C2N7OswCuWRiBM2JrRGZrbVNKpa6jMch5KLANSc7n9Hz1opC1lg
         7I9ym2zcUBki9qM2mDr23AcFxIdIQBqfAeDiCfQ9kDk0+gwy4YJBGjI+aaOC3XuhcN
         2zMAHHHwArF12aGVqQCrGQ3PtH6JxeRAMBWQqJanuNjgpNq55KYM4jQeS/4oG5ichb
         B5O4g4J81HHy77Mrt2dUPkQn/Xd0Sq53vgt31PPCyeDqCiZ0l1MMq91uPqZ5gyGmgJ
         2lmUW3agwjV+g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id E039ACE18F0; Wed, 10 May 2023 11:17:18 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, akiyks@gmail.com, linux-doc@vger.kernel.org,
        kernel-team@meta.com, "Paul E. McKenney" <paulmck@kernel.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH locking/atomic 07/19] locking/atomic: Add kernel-doc header for arch_${atomic}_try_cmpxchg${order}
Date:   Wed, 10 May 2023 11:17:05 -0700
Message-Id: <20230510181717.2200934-7-paulmck@kernel.org>
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

Add kernel-doc header template for arch_${atomic}_try_cmpxchg${order}
function family.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Will Deacon <will@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>
---
 include/linux/atomic/atomic-arch-fallback.h | 82 ++++++++++++++++++++-
 scripts/atomic/fallbacks/try_cmpxchg        | 10 +++
 2 files changed, 91 insertions(+), 1 deletion(-)

diff --git a/include/linux/atomic/atomic-arch-fallback.h b/include/linux/atomic/atomic-arch-fallback.h
index d5ff29a7128d..ed72d94346e9 100644
--- a/include/linux/atomic/atomic-arch-fallback.h
+++ b/include/linux/atomic/atomic-arch-fallback.h
@@ -1255,6 +1255,16 @@ arch_atomic_cmpxchg(atomic_t *v, int old, int new)
 #endif /* arch_atomic_try_cmpxchg */
 
 #ifndef arch_atomic_try_cmpxchg
+/**
+ * arch_atomic_try_cmpxchg - Atomic cmpxchg with bool return value
+ * @v:  pointer of type atomic_t
+ * @old:  desired old value to match
+ * @new:  new value to put in
+ *
+ * Atomically compares @new to *@v, and if equal, stores @new to *@v,
+ * providing full ordering.
+ * Returns @true if the cmpxchg operation succeeded, and false otherwise.
+ */
 static __always_inline bool
 arch_atomic_try_cmpxchg(atomic_t *v, int *old, int new)
 {
@@ -1268,6 +1278,16 @@ arch_atomic_try_cmpxchg(atomic_t *v, int *old, int new)
 #endif
 
 #ifndef arch_atomic_try_cmpxchg_acquire
+/**
+ * arch_atomic_try_cmpxchg_acquire - Atomic cmpxchg with bool return value
+ * @v:  pointer of type atomic_t
+ * @old:  desired old value to match
+ * @new:  new value to put in
+ *
+ * Atomically compares @new to *@v, and if equal, stores @new to *@v,
+ * providing acquire ordering.
+ * Returns @true if the cmpxchg operation succeeded, and false otherwise.
+ */
 static __always_inline bool
 arch_atomic_try_cmpxchg_acquire(atomic_t *v, int *old, int new)
 {
@@ -1281,6 +1301,16 @@ arch_atomic_try_cmpxchg_acquire(atomic_t *v, int *old, int new)
 #endif
 
 #ifndef arch_atomic_try_cmpxchg_release
+/**
+ * arch_atomic_try_cmpxchg_release - Atomic cmpxchg with bool return value
+ * @v:  pointer of type atomic_t
+ * @old:  desired old value to match
+ * @new:  new value to put in
+ *
+ * Atomically compares @new to *@v, and if equal, stores @new to *@v,
+ * providing release ordering.
+ * Returns @true if the cmpxchg operation succeeded, and false otherwise.
+ */
 static __always_inline bool
 arch_atomic_try_cmpxchg_release(atomic_t *v, int *old, int new)
 {
@@ -1294,6 +1324,16 @@ arch_atomic_try_cmpxchg_release(atomic_t *v, int *old, int new)
 #endif
 
 #ifndef arch_atomic_try_cmpxchg_relaxed
+/**
+ * arch_atomic_try_cmpxchg_relaxed - Atomic cmpxchg with bool return value
+ * @v:  pointer of type atomic_t
+ * @old:  desired old value to match
+ * @new:  new value to put in
+ *
+ * Atomically compares @new to *@v, and if equal, stores @new to *@v,
+ * providing no ordering.
+ * Returns @true if the cmpxchg operation succeeded, and false otherwise.
+ */
 static __always_inline bool
 arch_atomic_try_cmpxchg_relaxed(atomic_t *v, int *old, int new)
 {
@@ -2637,6 +2677,16 @@ arch_atomic64_cmpxchg(atomic64_t *v, s64 old, s64 new)
 #endif /* arch_atomic64_try_cmpxchg */
 
 #ifndef arch_atomic64_try_cmpxchg
+/**
+ * arch_atomic64_try_cmpxchg - Atomic cmpxchg with bool return value
+ * @v:  pointer of type atomic64_t
+ * @old:  desired old value to match
+ * @new:  new value to put in
+ *
+ * Atomically compares @new to *@v, and if equal, stores @new to *@v,
+ * providing full ordering.
+ * Returns @true if the cmpxchg operation succeeded, and false otherwise.
+ */
 static __always_inline bool
 arch_atomic64_try_cmpxchg(atomic64_t *v, s64 *old, s64 new)
 {
@@ -2650,6 +2700,16 @@ arch_atomic64_try_cmpxchg(atomic64_t *v, s64 *old, s64 new)
 #endif
 
 #ifndef arch_atomic64_try_cmpxchg_acquire
+/**
+ * arch_atomic64_try_cmpxchg_acquire - Atomic cmpxchg with bool return value
+ * @v:  pointer of type atomic64_t
+ * @old:  desired old value to match
+ * @new:  new value to put in
+ *
+ * Atomically compares @new to *@v, and if equal, stores @new to *@v,
+ * providing acquire ordering.
+ * Returns @true if the cmpxchg operation succeeded, and false otherwise.
+ */
 static __always_inline bool
 arch_atomic64_try_cmpxchg_acquire(atomic64_t *v, s64 *old, s64 new)
 {
@@ -2663,6 +2723,16 @@ arch_atomic64_try_cmpxchg_acquire(atomic64_t *v, s64 *old, s64 new)
 #endif
 
 #ifndef arch_atomic64_try_cmpxchg_release
+/**
+ * arch_atomic64_try_cmpxchg_release - Atomic cmpxchg with bool return value
+ * @v:  pointer of type atomic64_t
+ * @old:  desired old value to match
+ * @new:  new value to put in
+ *
+ * Atomically compares @new to *@v, and if equal, stores @new to *@v,
+ * providing release ordering.
+ * Returns @true if the cmpxchg operation succeeded, and false otherwise.
+ */
 static __always_inline bool
 arch_atomic64_try_cmpxchg_release(atomic64_t *v, s64 *old, s64 new)
 {
@@ -2676,6 +2746,16 @@ arch_atomic64_try_cmpxchg_release(atomic64_t *v, s64 *old, s64 new)
 #endif
 
 #ifndef arch_atomic64_try_cmpxchg_relaxed
+/**
+ * arch_atomic64_try_cmpxchg_relaxed - Atomic cmpxchg with bool return value
+ * @v:  pointer of type atomic64_t
+ * @old:  desired old value to match
+ * @new:  new value to put in
+ *
+ * Atomically compares @new to *@v, and if equal, stores @new to *@v,
+ * providing no ordering.
+ * Returns @true if the cmpxchg operation succeeded, and false otherwise.
+ */
 static __always_inline bool
 arch_atomic64_try_cmpxchg_relaxed(atomic64_t *v, s64 *old, s64 new)
 {
@@ -3000,4 +3080,4 @@ arch_atomic64_dec_if_positive(atomic64_t *v)
 #endif
 
 #endif /* _LINUX_ATOMIC_FALLBACK_H */
-// e403f06ce98fe72ae0698e8f2c78f8a45894e465
+// 3b29d5595f48f921507f19bc794c91aecb782ad3
diff --git a/scripts/atomic/fallbacks/try_cmpxchg b/scripts/atomic/fallbacks/try_cmpxchg
index 890f850ede37..baf7412f9bf4 100755
--- a/scripts/atomic/fallbacks/try_cmpxchg
+++ b/scripts/atomic/fallbacks/try_cmpxchg
@@ -1,4 +1,14 @@
 cat <<EOF
+/**
+ * arch_${atomic}_try_cmpxchg${order} - Atomic cmpxchg with bool return value
+ * @v:  pointer of type ${atomic}_t
+ * @old:  desired old value to match
+ * @new:  new value to put in
+ *
+ * Atomically compares @new to *@v, and if equal, stores @new to *@v,
+ * providing ${docbook_order} ordering.
+ * Returns @true if the cmpxchg operation succeeded, and false otherwise.
+ */
 static __always_inline bool
 arch_${atomic}_try_cmpxchg${order}(${atomic}_t *v, ${int} *old, ${int} new)
 {
-- 
2.40.1

