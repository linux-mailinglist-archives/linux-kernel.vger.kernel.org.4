Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FCA16FE3F2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 20:19:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236599AbjEJSTY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 14:19:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236162AbjEJSSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 14:18:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 176F883FE;
        Wed, 10 May 2023 11:18:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C6F0A63F93;
        Wed, 10 May 2023 18:17:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0535C433A4;
        Wed, 10 May 2023 18:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683742644;
        bh=yeFIpFg/iKGrZfbrxdL351Lmjv0weFLzV3+gdTLgI4E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KczCrmqFj0Mj9lVEKpCkKbR+cm3lmfrnsq6ph/rLxQPUY+3KS99z2fYFnAaxrNXYt
         ewEw3q7zLrYqCXYAC267dJXzLZDHdxa2BlunY0o81j/Fv9e2EkrkLszKb4bOrVJXpG
         1seEH1u0jnsKeAHY4/CjKJjlDjyhvM5gsTuDtRQs7+hMbcoSYH0CoLvXvCwzr2s1UZ
         JeJqhAdHm+MlXQ3v8z/HF7Bl7KS9DAxaahoQcpRQk+vQzg5WLDOYw0yosc8wdzYe66
         b66ezsnYiWZLckNNlTA4tSy+ukcmlyrRsm7Y3IAquPvKL5u7PE+csZS2h6TspLUcSh
         YY4vkUIRp1NYQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id ED174CE1ED9; Wed, 10 May 2023 11:17:18 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, akiyks@gmail.com, linux-doc@vger.kernel.org,
        kernel-team@meta.com, "Paul E. McKenney" <paulmck@kernel.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH locking/atomic 12/19] locking/atomic: Add kernel-doc header for arch_${atomic}_read_acquire
Date:   Wed, 10 May 2023 11:17:10 -0700
Message-Id: <20230510181717.2200934-12-paulmck@kernel.org>
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

Add kernel-doc header template for arch_${atomic}_read_acquire
function family.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Will Deacon <will@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>
---
 include/linux/atomic/atomic-arch-fallback.h | 16 +++++++++++++++-
 scripts/atomic/fallbacks/read_acquire       |  7 +++++++
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/include/linux/atomic/atomic-arch-fallback.h b/include/linux/atomic/atomic-arch-fallback.h
index 7ba75143c149..c3552b83bf49 100644
--- a/include/linux/atomic/atomic-arch-fallback.h
+++ b/include/linux/atomic/atomic-arch-fallback.h
@@ -240,6 +240,13 @@
 #endif /* arch_try_cmpxchg64_local */
 
 #ifndef arch_atomic_read_acquire
+/**
+ * arch_atomic_read_acquire - Atomic load acquire
+ * @v: pointer of type atomic_t
+ *
+ * Atomically load from *@v with acquire ordering, returning the value
+ * loaded.
+ */
 static __always_inline int
 arch_atomic_read_acquire(const atomic_t *v)
 {
@@ -1695,6 +1702,13 @@ arch_atomic_dec_if_positive(atomic_t *v)
 #endif
 
 #ifndef arch_atomic64_read_acquire
+/**
+ * arch_atomic64_read_acquire - Atomic load acquire
+ * @v: pointer of type atomic64_t
+ *
+ * Atomically load from *@v with acquire ordering, returning the value
+ * loaded.
+ */
 static __always_inline s64
 arch_atomic64_read_acquire(const atomic64_t *v)
 {
@@ -3146,4 +3160,4 @@ arch_atomic64_dec_if_positive(atomic64_t *v)
 #endif
 
 #endif /* _LINUX_ATOMIC_FALLBACK_H */
-// c46693a9f3b3ceacef003cd42764251148e3457d
+// 96c8a3c4d13b12c9f3e0f715709c8af1653a7e79
diff --git a/scripts/atomic/fallbacks/read_acquire b/scripts/atomic/fallbacks/read_acquire
index a0ea1d26e6b2..779f40c07018 100755
--- a/scripts/atomic/fallbacks/read_acquire
+++ b/scripts/atomic/fallbacks/read_acquire
@@ -1,4 +1,11 @@
 cat <<EOF
+/**
+ * arch_${atomic}_read_acquire - Atomic load acquire
+ * @v: pointer of type ${atomic}_t
+ *
+ * Atomically load from *@v with acquire ordering, returning the value
+ * loaded.
+ */
 static __always_inline ${ret}
 arch_${atomic}_read_acquire(const ${atomic}_t *v)
 {
-- 
2.40.1

