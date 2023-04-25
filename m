Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C057D6EE7CA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 20:51:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234881AbjDYSu4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 14:50:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234743AbjDYSub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 14:50:31 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95E4C17A28
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 11:49:47 -0700 (PDT)
Message-ID: <20230425183313.832240451@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1682448566;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=i81xyhGvTy9w945ZtWZh/foaQEfmkM7oK4crwg/Zkto=;
        b=TiKHpFlnw6PsC7+D5RBxlBFfRCC6LwE6aF2hWgRg7pYPYrCE1Kt3meij4/cHCcogwALmxD
        VoUhZNiZQP4ZdSoM0RNy5bI58Gqw8i63Yfjyii4g6rr/yu3idvHyFEU0hzmHrtOMlIncTm
        MuADC8PEwA6DEAQeaP5Yp30IdmxG/XhPz7akqBQpesyvEh7k6XdTa/bikIUsFKpDm0rX69
        pOEb4OJVr8gSY/hcWVl2wWsuDjLA2CeeSEJryfxjU7+ZN/JFyNRDXg7c3bgEw2lN14TVh+
        8Kc/G5EQRW85uCLxcBUGCQg0i3LAeLqPRa0zv7tH9jnv7NwY5RSK09dnPAJr3Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1682448566;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=i81xyhGvTy9w945ZtWZh/foaQEfmkM7oK4crwg/Zkto=;
        b=As1rskEcAO2jOlNgdFnf6Q9Yw+e5WJqqz0ahBhdsPfa+NUY6qqtF1x1SyWar2fEuVY+wiF
        bkD3Obm2DEBgubBQ==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        syzbot+5c54bd3eb218bb595aa9@syzkaller.appspotmail.com,
        Dmitry Vyukov <dvyukov@google.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>
Subject: [patch 19/20] posix-timers: Remove pointless comments
References: <20230425181827.219128101@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 25 Apr 2023 20:49:25 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Documenting the obvious is just consuming space for no value.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/time/posix-timers.c |   25 -------------------------
 1 file changed, 25 deletions(-)

--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -59,19 +59,6 @@ static const struct k_clock clock_realti
 #error "SIGEV_THREAD_ID must not share bit with other SIGEV values!"
 #endif
 
-/*
- * CLOCKs: The POSIX standard calls for a couple of clocks and allows us
- *	    to implement others.  This structure defines the various
- *	    clocks.
- *
- * FUNCTIONS: The CLOCKs structure defines possible functions to
- *	    handle various clock functions.
- *
- *	    The standard POSIX timer management code assumes the
- *	    following: 1.) The k_itimer struct (sched.h) is used for
- *	    the timer.  2.) The list, it_lock, it_clock, it_id and
- *	    it_pid fields are not modified by timer code.
- */
 static struct k_itimer *__lock_timer(timer_t timer_id, unsigned long *flags);
 
 #define lock_timer(tid, flags)						   \
@@ -140,7 +127,6 @@ static inline void unlock_timer(struct k
 	spin_unlock_irqrestore(&timr->it_lock, flags);
 }
 
-/* Get clock_realtime */
 static int posix_get_realtime_timespec(clockid_t which_clock, struct timespec64 *tp)
 {
 	ktime_get_real_ts64(tp);
@@ -152,7 +138,6 @@ static ktime_t posix_get_realtime_ktime(
 	return ktime_get_real();
 }
 
-/* Set clock_realtime */
 static int posix_clock_realtime_set(const clockid_t which_clock,
 				    const struct timespec64 *tp)
 {
@@ -165,9 +150,6 @@ static int posix_clock_realtime_adj(cons
 	return do_adjtimex(t);
 }
 
-/*
- * Get monotonic time for posix timers
- */
 static int posix_get_monotonic_timespec(clockid_t which_clock, struct timespec64 *tp)
 {
 	ktime_get_ts64(tp);
@@ -180,9 +162,6 @@ static ktime_t posix_get_monotonic_ktime
 	return ktime_get();
 }
 
-/*
- * Get monotonic-raw time for posix timers
- */
 static int posix_get_monotonic_raw(clockid_t which_clock, struct timespec64 *tp)
 {
 	ktime_get_raw_ts64(tp);
@@ -190,7 +169,6 @@ static int posix_get_monotonic_raw(clock
 	return 0;
 }
 
-
 static int posix_get_realtime_coarse(clockid_t which_clock, struct timespec64 *tp)
 {
 	ktime_get_coarse_real_ts64(tp);
@@ -241,9 +219,6 @@ static int posix_get_hrtimer_res(clockid
 	return 0;
 }
 
-/*
- * Initialize everything, well, just everything in Posix clocks/timers ;)
- */
 static __init int init_posix_timers(void)
 {
 	posix_timers_cache = kmem_cache_create("posix_timers_cache",

