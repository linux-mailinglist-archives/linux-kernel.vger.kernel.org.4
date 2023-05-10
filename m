Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBE8D6FE3ED
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 20:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236179AbjEJSTL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 14:19:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236144AbjEJSSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 14:18:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1730B83E7;
        Wed, 10 May 2023 11:18:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C80E963F94;
        Wed, 10 May 2023 18:17:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E139EC433AE;
        Wed, 10 May 2023 18:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683742644;
        bh=O5+R08c8ff/9UCItSQg4aHCY6O5NYgQTn22+Zu0iVq8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Xce+75GfENdMWBpO3VsBhIq+md1L1PO/sfpQ26MlP7lpDMWE8xELlYvvI7F9H6Ndi
         VaCKiOScuM6OKVzlkdJSlnVy7YeKReqJcuqcbEUkTBGGE3LoH+hYCX5pZPbqBVuSe8
         zO87kovaSZAGKDRIS8UaMgLQGxxZcOeXNjWxbrOaVdyRqjIDOyabSjgel2z2fI3mxz
         GHx65Y2Rf8mCE4QpBXQ9G+CNjMsVFSYNL3Gq9EhIJIUZTZs+FQIpCfbiwqfK5kmUEu
         rZZLhD/RTYr8j2Dtrenmxh2MDewaUdsaqqsecWPd69AkjSaE692PbpvFo7MIVyE46/
         He9ag/wpppS/g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 06C1CCE21CB; Wed, 10 May 2023 11:17:19 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, akiyks@gmail.com, linux-doc@vger.kernel.org,
        kernel-team@meta.com, "Paul E. McKenney" <paulmck@kernel.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH locking/atomic 17/19] x86/atomic.h: Remove duplicate kernel-doc headers
Date:   Wed, 10 May 2023 11:17:15 -0700
Message-Id: <20230510181717.2200934-17-paulmck@kernel.org>
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

Scripting the kernel-doc headers resulted in a few duplicates.  Remove the
duplicates from the x86-specific files.

Reported-by: Akira Yokosawa <akiyks@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Will Deacon <will@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: <x86@kernel.org>
---
 arch/x86/include/asm/atomic.h | 60 -----------------------------------
 1 file changed, 60 deletions(-)

diff --git a/arch/x86/include/asm/atomic.h b/arch/x86/include/asm/atomic.h
index 5e754e895767..5df979d65fb5 100644
--- a/arch/x86/include/asm/atomic.h
+++ b/arch/x86/include/asm/atomic.h
@@ -69,27 +69,12 @@ static __always_inline void arch_atomic_sub(int i, atomic_t *v)
 		     : "ir" (i) : "memory");
 }
 
-/**
- * arch_atomic_sub_and_test - subtract value from variable and test result
- * @i: integer value to subtract
- * @v: pointer of type atomic_t
- *
- * Atomically subtracts @i from @v and returns
- * true if the result is zero, or false for all
- * other cases.
- */
 static __always_inline bool arch_atomic_sub_and_test(int i, atomic_t *v)
 {
 	return GEN_BINARY_RMWcc(LOCK_PREFIX "subl", v->counter, e, "er", i);
 }
 #define arch_atomic_sub_and_test arch_atomic_sub_and_test
 
-/**
- * arch_atomic_inc - increment atomic variable
- * @v: pointer of type atomic_t
- *
- * Atomically increments @v by 1.
- */
 static __always_inline void arch_atomic_inc(atomic_t *v)
 {
 	asm volatile(LOCK_PREFIX "incl %0"
@@ -97,12 +82,6 @@ static __always_inline void arch_atomic_inc(atomic_t *v)
 }
 #define arch_atomic_inc arch_atomic_inc
 
-/**
- * arch_atomic_dec - decrement atomic variable
- * @v: pointer of type atomic_t
- *
- * Atomically decrements @v by 1.
- */
 static __always_inline void arch_atomic_dec(atomic_t *v)
 {
 	asm volatile(LOCK_PREFIX "decl %0"
@@ -110,69 +89,30 @@ static __always_inline void arch_atomic_dec(atomic_t *v)
 }
 #define arch_atomic_dec arch_atomic_dec
 
-/**
- * arch_atomic_dec_and_test - decrement and test
- * @v: pointer of type atomic_t
- *
- * Atomically decrements @v by 1 and
- * returns true if the result is 0, or false for all other
- * cases.
- */
 static __always_inline bool arch_atomic_dec_and_test(atomic_t *v)
 {
 	return GEN_UNARY_RMWcc(LOCK_PREFIX "decl", v->counter, e);
 }
 #define arch_atomic_dec_and_test arch_atomic_dec_and_test
 
-/**
- * arch_atomic_inc_and_test - increment and test
- * @v: pointer of type atomic_t
- *
- * Atomically increments @v by 1
- * and returns true if the result is zero, or false for all
- * other cases.
- */
 static __always_inline bool arch_atomic_inc_and_test(atomic_t *v)
 {
 	return GEN_UNARY_RMWcc(LOCK_PREFIX "incl", v->counter, e);
 }
 #define arch_atomic_inc_and_test arch_atomic_inc_and_test
 
-/**
- * arch_atomic_add_negative - add and test if negative
- * @i: integer value to add
- * @v: pointer of type atomic_t
- *
- * Atomically adds @i to @v and returns true
- * if the result is negative, or false when
- * result is greater than or equal to zero.
- */
 static __always_inline bool arch_atomic_add_negative(int i, atomic_t *v)
 {
 	return GEN_BINARY_RMWcc(LOCK_PREFIX "addl", v->counter, s, "er", i);
 }
 #define arch_atomic_add_negative arch_atomic_add_negative
 
-/**
- * arch_atomic_add_return - add integer and return
- * @i: integer value to add
- * @v: pointer of type atomic_t
- *
- * Atomically adds @i to @v and returns @i + @v
- */
 static __always_inline int arch_atomic_add_return(int i, atomic_t *v)
 {
 	return i + xadd(&v->counter, i);
 }
 #define arch_atomic_add_return arch_atomic_add_return
 
-/**
- * arch_atomic_sub_return - subtract integer and return
- * @v: pointer of type atomic_t
- * @i: integer value to subtract
- *
- * Atomically subtracts @i from @v and returns @v - @i
- */
 static __always_inline int arch_atomic_sub_return(int i, atomic_t *v)
 {
 	return arch_atomic_add_return(-i, v);
-- 
2.40.1

