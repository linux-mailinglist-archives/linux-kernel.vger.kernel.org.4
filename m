Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD6486FE3E9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 20:19:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236089AbjEJSTC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 14:19:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236086AbjEJSSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 14:18:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6097B35AB;
        Wed, 10 May 2023 11:18:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C262163F8B;
        Wed, 10 May 2023 18:17:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B494DC433A8;
        Wed, 10 May 2023 18:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683742644;
        bh=938G6zjstowu8jkLfQwOfPppGEFi6/h20gxxEv4pKds=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hrtuScckU1FqLRkp02MZHPh7X2V9uGIK3cXaf6OJl9tOUkIrNKx6WICOIN68mBOkT
         tcppCT7rbf2yDmS0eyK1RfcUdPLm/78ZtwryjthZRMyU2Ak51mhlpBsTBmrZEvMfpM
         vXksW7Iu/pE6tInVfjjwJF1hVnai5vO6dO7V1zZR1PPayYRPxLL5eAngyDYuJpUY7C
         mgkvebQHfLxC8SvO6ZcjE9KUdX9kQjP273voEX6fH/og2ODkfLOvqB5ih1yDJW0y44
         FHQufgCMlP9nLVCUOrfCtV2GWCvFMF+WTtwKSicprf4gDVXLltL3pdhHReHTfRLRhX
         mZsRC/o1HcIew==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id EAA23CE1EA5; Wed, 10 May 2023 11:17:18 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, akiyks@gmail.com, linux-doc@vger.kernel.org,
        kernel-team@meta.com, "Paul E. McKenney" <paulmck@kernel.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH locking/atomic 11/19] locking/atomic: Add kernel-doc header for arch_${atomic}_set_release
Date:   Wed, 10 May 2023 11:17:09 -0700
Message-Id: <20230510181717.2200934-11-paulmck@kernel.org>
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

Add kernel-doc header template for arch_${atomic}_set_release
function family.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Will Deacon <will@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>
---
 include/linux/atomic/atomic-arch-fallback.h | 16 +++++++++++++++-
 scripts/atomic/fallbacks/set_release        |  7 +++++++
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/include/linux/atomic/atomic-arch-fallback.h b/include/linux/atomic/atomic-arch-fallback.h
index a90ee496bb81..7ba75143c149 100644
--- a/include/linux/atomic/atomic-arch-fallback.h
+++ b/include/linux/atomic/atomic-arch-fallback.h
@@ -258,6 +258,13 @@ arch_atomic_read_acquire(const atomic_t *v)
 #endif
 
 #ifndef arch_atomic_set_release
+/**
+ * arch_atomic_set_release - Atomic store release
+ * @v: pointer of type atomic_t
+ * @i: value to store
+ *
+ * Atomically store @i into *@v with release ordering.
+ */
 static __always_inline void
 arch_atomic_set_release(atomic_t *v, int i)
 {
@@ -1706,6 +1713,13 @@ arch_atomic64_read_acquire(const atomic64_t *v)
 #endif
 
 #ifndef arch_atomic64_set_release
+/**
+ * arch_atomic64_set_release - Atomic store release
+ * @v: pointer of type atomic64_t
+ * @i: value to store
+ *
+ * Atomically store @i into *@v with release ordering.
+ */
 static __always_inline void
 arch_atomic64_set_release(atomic64_t *v, s64 i)
 {
@@ -3132,4 +3146,4 @@ arch_atomic64_dec_if_positive(atomic64_t *v)
 #endif
 
 #endif /* _LINUX_ATOMIC_FALLBACK_H */
-// 3fd0ec685588b84c6428145b7628f79ce23a464c
+// c46693a9f3b3ceacef003cd42764251148e3457d
diff --git a/scripts/atomic/fallbacks/set_release b/scripts/atomic/fallbacks/set_release
index 05cdb7f42477..46effb6203e5 100755
--- a/scripts/atomic/fallbacks/set_release
+++ b/scripts/atomic/fallbacks/set_release
@@ -1,4 +1,11 @@
 cat <<EOF
+/**
+ * arch_${atomic}_set_release - Atomic store release
+ * @v: pointer of type ${atomic}_t
+ * @i: value to store
+ *
+ * Atomically store @i into *@v with release ordering.
+ */
 static __always_inline void
 arch_${atomic}_set_release(${atomic}_t *v, ${int} i)
 {
-- 
2.40.1

