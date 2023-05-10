Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75E186FE3E2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 20:19:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236318AbjEJSSg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 14:18:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236057AbjEJSSP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 14:18:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6EA07DBD;
        Wed, 10 May 2023 11:18:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 383C563F89;
        Wed, 10 May 2023 18:17:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0B34C433EF;
        Wed, 10 May 2023 18:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683742644;
        bh=5orfwLg08dIm14Vms6sjyzzLD3V/C5KXtMlKMkWcY24=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Em+tJutPuctz8SiLrvZzic/5pGf+w4amVFJR944sz9bai88jhwKqi+nkCtPNnUE4n
         gvJ7WNeAmDAecOWnnm9LAhq1pOA7s5sF+Aj1HfAG2b7ec6xio+WcM5tEVk6D9eVBAJ
         xaDu4viqi/AhOtY/Y7OAhfY+lsgFYFsk4Y19MQg8wh57lYQGCpXlpddJjK3q2TzDhj
         pOYVPPG5/nJgGCaZPksnNeYZYE4+Ek7oPmPbBmBtpy7wtFkFjLB09x1gJce76W7rpR
         qqFOumnKGEA+Fxy9CHm41NYF0K4a1/CpYljDtxu7CiuY4N2f/Cj6qJe7UvpYm69xX0
         yGHqD5hGTjgrA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id E8047CE1D7A; Wed, 10 May 2023 11:17:18 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, akiyks@gmail.com, linux-doc@vger.kernel.org,
        kernel-team@meta.com, "Paul E. McKenney" <paulmck@kernel.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH locking/atomic 10/19] locking/atomic: Add kernel-doc header for arch_${atomic}_inc_unless_negative
Date:   Wed, 10 May 2023 11:17:08 -0700
Message-Id: <20230510181717.2200934-10-paulmck@kernel.org>
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

Add kernel-doc header template for arch_${atomic}_inc_unless_negative
function family.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Will Deacon <will@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>
---
 include/linux/atomic/atomic-arch-fallback.h  | 18 +++++++++++++++++-
 scripts/atomic/fallbacks/inc_unless_negative |  8 ++++++++
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/include/linux/atomic/atomic-arch-fallback.h b/include/linux/atomic/atomic-arch-fallback.h
index e6c7356d5dfc..a90ee496bb81 100644
--- a/include/linux/atomic/atomic-arch-fallback.h
+++ b/include/linux/atomic/atomic-arch-fallback.h
@@ -1609,6 +1609,14 @@ arch_atomic_inc_not_zero(atomic_t *v)
 #endif
 
 #ifndef arch_atomic_inc_unless_negative
+/**
+ * arch_atomic_inc_unless_negative - Atomic increment if old value is non-negative
+ * @v: pointer of type atomic_t
+ *
+ * Atomically increment @v, but only if the original value is greater
+ * than or equal to zero.  Return @true if the increment happened and
+ * @false otherwise.
+ */
 static __always_inline bool
 arch_atomic_inc_unless_negative(atomic_t *v)
 {
@@ -3049,6 +3057,14 @@ arch_atomic64_inc_not_zero(atomic64_t *v)
 #endif
 
 #ifndef arch_atomic64_inc_unless_negative
+/**
+ * arch_atomic64_inc_unless_negative - Atomic increment if old value is non-negative
+ * @v: pointer of type atomic64_t
+ *
+ * Atomically increment @v, but only if the original value is greater
+ * than or equal to zero.  Return @true if the increment happened and
+ * @false otherwise.
+ */
 static __always_inline bool
 arch_atomic64_inc_unless_negative(atomic64_t *v)
 {
@@ -3116,4 +3132,4 @@ arch_atomic64_dec_if_positive(atomic64_t *v)
 #endif
 
 #endif /* _LINUX_ATOMIC_FALLBACK_H */
-// 225b2fe3eb6bbe34729abed7a856b91abc8d434e
+// 3fd0ec685588b84c6428145b7628f79ce23a464c
diff --git a/scripts/atomic/fallbacks/inc_unless_negative b/scripts/atomic/fallbacks/inc_unless_negative
index 95d8ce48233f..98830b0dcdb1 100755
--- a/scripts/atomic/fallbacks/inc_unless_negative
+++ b/scripts/atomic/fallbacks/inc_unless_negative
@@ -1,4 +1,12 @@
 cat <<EOF
+/**
+ * arch_${atomic}_inc_unless_negative - Atomic increment if old value is non-negative
+ * @v: pointer of type ${atomic}_t
+ *
+ * Atomically increment @v, but only if the original value is greater
+ * than or equal to zero.  Return @true if the increment happened and
+ * @false otherwise.
+ */
 static __always_inline bool
 arch_${atomic}_inc_unless_negative(${atomic}_t *v)
 {
-- 
2.40.1

