Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A88D6FE3D6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 20:18:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236032AbjEJSSO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 14:18:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236102AbjEJSSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 14:18:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C76307AA5;
        Wed, 10 May 2023 11:17:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2CA5663F7D;
        Wed, 10 May 2023 18:17:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F1E7C4339C;
        Wed, 10 May 2023 18:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683742644;
        bh=FJU5RCiZpCrQOcJ2eziBcfOGyF3Kln3b8QgDAQjPb0s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YsOXDi3wcldqoNlczsWnUe0VqUlSDba9kRlBkTjBNyD5GfWBuPsQ6GMqNIy3ZxO73
         Fofi/sB282sOwraaAHmdPVfVYdRYGRJErdiEFiDEL7dus4SnzmP9C24g5YF10XAPc9
         Q3zVOE9TdfIQDdH8pPduLG6Bk5uqP1evwK+U9fjrKdMW0oHUnS46EsbSt7z1XbaciT
         vW7LaqDpej4orDgfHVFIemJoyvJzWD74aTacJHOiZ7c8POxIpSqeugknoZSPD7ibt5
         JoXltZkq1O2tmZIoUpH9RUSJJKdNmCY7q8pFu1pyY9EeGfZglkS60RYU7mD8JSnmrT
         pVP8EKLCbsziQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id E537DCE1C80; Wed, 10 May 2023 11:17:18 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, akiyks@gmail.com, linux-doc@vger.kernel.org,
        kernel-team@meta.com, "Paul E. McKenney" <paulmck@kernel.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH locking/atomic 09/19] locking/atomic: Add kernel-doc header for arch_${atomic}_dec_unless_positive
Date:   Wed, 10 May 2023 11:17:07 -0700
Message-Id: <20230510181717.2200934-9-paulmck@kernel.org>
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

Add kernel-doc header template for arch_${atomic}_dec_unless_positive
function family.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Will Deacon <will@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>
---
 include/linux/atomic/atomic-arch-fallback.h  | 18 +++++++++++++++++-
 scripts/atomic/fallbacks/dec_unless_positive |  8 ++++++++
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/include/linux/atomic/atomic-arch-fallback.h b/include/linux/atomic/atomic-arch-fallback.h
index 4d4d94925cb0..e6c7356d5dfc 100644
--- a/include/linux/atomic/atomic-arch-fallback.h
+++ b/include/linux/atomic/atomic-arch-fallback.h
@@ -1625,6 +1625,14 @@ arch_atomic_inc_unless_negative(atomic_t *v)
 #endif
 
 #ifndef arch_atomic_dec_unless_positive
+/**
+ * arch_atomic_dec_unless_positive - Atomic decrement if old value is non-positive
+ * @v: pointer of type atomic_t
+ *
+ * Atomically decrement @v, but only if the original value is less
+ * than or equal to zero.  Return @true if the decrement happened and
+ * @false otherwise.
+ */
 static __always_inline bool
 arch_atomic_dec_unless_positive(atomic_t *v)
 {
@@ -3057,6 +3065,14 @@ arch_atomic64_inc_unless_negative(atomic64_t *v)
 #endif
 
 #ifndef arch_atomic64_dec_unless_positive
+/**
+ * arch_atomic64_dec_unless_positive - Atomic decrement if old value is non-positive
+ * @v: pointer of type atomic64_t
+ *
+ * Atomically decrement @v, but only if the original value is less
+ * than or equal to zero.  Return @true if the decrement happened and
+ * @false otherwise.
+ */
 static __always_inline bool
 arch_atomic64_dec_unless_positive(atomic64_t *v)
 {
@@ -3100,4 +3116,4 @@ arch_atomic64_dec_if_positive(atomic64_t *v)
 #endif
 
 #endif /* _LINUX_ATOMIC_FALLBACK_H */
-// c7041896e7e66a52d8005ba021f3b3b05f99bcb3
+// 225b2fe3eb6bbe34729abed7a856b91abc8d434e
diff --git a/scripts/atomic/fallbacks/dec_unless_positive b/scripts/atomic/fallbacks/dec_unless_positive
index c531d5afecc4..c3d01d201c63 100755
--- a/scripts/atomic/fallbacks/dec_unless_positive
+++ b/scripts/atomic/fallbacks/dec_unless_positive
@@ -1,4 +1,12 @@
 cat <<EOF
+/**
+ * arch_${atomic}_dec_unless_positive - Atomic decrement if old value is non-positive
+ * @v: pointer of type ${atomic}_t
+ *
+ * Atomically decrement @v, but only if the original value is less
+ * than or equal to zero.  Return @true if the decrement happened and
+ * @false otherwise.
+ */
 static __always_inline bool
 arch_${atomic}_dec_unless_positive(${atomic}_t *v)
 {
-- 
2.40.1

