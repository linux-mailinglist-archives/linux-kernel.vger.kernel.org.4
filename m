Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1228C6FE3D8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 20:18:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236088AbjEJSSR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 14:18:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236089AbjEJSSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 14:18:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 722B57A8A;
        Wed, 10 May 2023 11:17:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CB5D163F7A;
        Wed, 10 May 2023 18:17:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32FCFC433D2;
        Wed, 10 May 2023 18:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683742639;
        bh=KB8lXc7zZ3+DrRqeJZSACdw3EUil7+a97nQI2II+M98=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AD+barTaVX8y+DNIVRHjyZVk6aMS9U9wGnwdUs+i6L7QVRCp2GNxW0J4DvKl8xUNp
         bef+WyWRqxQ2qNXW0T4LmPXu0Tb/ybPtFbl+QQpTI1slzRMZRQszn8vuuhXH/Zr/Z3
         WGIICvcEU0TWzGd5ZK76KKHSI2Yu/RyGaXDFWRZrKjuOwaOCsBrB4nle1fUDxbdL+L
         zSBm6cWODgesfyDPnvqjTkKlymAb4LaVjjTQ0bNTlKYK/28BkVarf4OtUL5sBx1xZC
         IwFBwpnaBe1ltvrGZxViCB1Tpmx9dF1IE8bHX8muehsIXUXqQtxJPkYkuB+562ZEst
         BCQf7NrxipUUw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id D024CCE120B; Wed, 10 May 2023 11:17:18 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, akiyks@gmail.com, linux-doc@vger.kernel.org,
        kernel-team@meta.com, "Paul E. McKenney" <paulmck@kernel.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH locking/atomic 01/19] locking/atomic: Fix fetch_add_unless missing-period typo
Date:   Wed, 10 May 2023 11:16:59 -0700
Message-Id: <20230510181717.2200934-1-paulmck@kernel.org>
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

The fetch_add_unless() kernel-doc header is missing a period (".").
Therefore, add it.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Will Deacon <will@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>
---
 include/linux/atomic/atomic-arch-fallback.h | 6 +++---
 scripts/atomic/fallbacks/fetch_add_unless   | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/atomic/atomic-arch-fallback.h b/include/linux/atomic/atomic-arch-fallback.h
index a6e4437c5f36..c4087c32fb0e 100644
--- a/include/linux/atomic/atomic-arch-fallback.h
+++ b/include/linux/atomic/atomic-arch-fallback.h
@@ -1351,7 +1351,7 @@ arch_atomic_add_negative(int i, atomic_t *v)
  * @u: ...unless v is equal to u.
  *
  * Atomically adds @a to @v, so long as @v was not already @u.
- * Returns original value of @v
+ * Returns original value of @v.
  */
 static __always_inline int
 arch_atomic_fetch_add_unless(atomic_t *v, int a, int u)
@@ -2567,7 +2567,7 @@ arch_atomic64_add_negative(s64 i, atomic64_t *v)
  * @u: ...unless v is equal to u.
  *
  * Atomically adds @a to @v, so long as @v was not already @u.
- * Returns original value of @v
+ * Returns original value of @v.
  */
 static __always_inline s64
 arch_atomic64_fetch_add_unless(atomic64_t *v, s64 a, s64 u)
@@ -2668,4 +2668,4 @@ arch_atomic64_dec_if_positive(atomic64_t *v)
 #endif
 
 #endif /* _LINUX_ATOMIC_FALLBACK_H */
-// ad2e2b4d168dbc60a73922616047a9bfa446af36
+// 201cc01b616875888e0b2c79965c569a89c0edcd
diff --git a/scripts/atomic/fallbacks/fetch_add_unless b/scripts/atomic/fallbacks/fetch_add_unless
index 68ce13c8b9da..a1692df0d514 100755
--- a/scripts/atomic/fallbacks/fetch_add_unless
+++ b/scripts/atomic/fallbacks/fetch_add_unless
@@ -6,7 +6,7 @@ cat << EOF
  * @u: ...unless v is equal to u.
  *
  * Atomically adds @a to @v, so long as @v was not already @u.
- * Returns original value of @v
+ * Returns original value of @v.
  */
 static __always_inline ${int}
 arch_${atomic}_fetch_add_unless(${atomic}_t *v, ${int} a, ${int} u)
-- 
2.40.1

