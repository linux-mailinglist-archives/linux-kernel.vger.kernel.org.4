Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7003722A51
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 17:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234084AbjFEPIn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 11:08:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233783AbjFEPI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 11:08:28 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22D42F2;
        Mon,  5 Jun 2023 08:08:27 -0700 (PDT)
Date:   Mon, 05 Jun 2023 15:08:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1685977705;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3d2BXh0h4elG7qlNWfNxWWJunObZyqtevvQxFq0QGqk=;
        b=b47SumWDvZeaFmpDa6FA91TVSgKCjqZCMGCI7q6ZAIXHuxqElCP8qpywL1Hv6Viq4wc9CU
        9pxsrIvP6WgfWZEmja1byPkaYoq2xc9A9yH1lztlBoqyXjkhqzN30dPEpa1C+cExhX8CXG
        dwlMizUAz9LUOJaaLgwuMZcN2Eh5TAUJgVPwZUwvokaRIx7LPmHkCuh93nIEYjAgWGCHaj
        p/Xcr/TRgOxiDCBgptM4rBxqKInd+MfrimaNRGVN2QvMDANAjmm6AHVrdt4bGLqclq8t+Q
        yKCeDf6Jes56KSQF+iXk7D318cXIKiaKNfC+A78247J9HGy4SWHTxGkz8/A/Gw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1685977705;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3d2BXh0h4elG7qlNWfNxWWJunObZyqtevvQxFq0QGqk=;
        b=KPb4qNTEyU/y2Iu48TwVlekYqI6/OdQUxtTg9A0jKHtCHJ0bgGQ3x355a8RVV2RGfWKC8m
        bNzPiea7sWGcuUAQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] posix-timers: Remove pointless comments
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230425183313.832240451@linutronix.de>
References: <20230425183313.832240451@linutronix.de>
MIME-Version: 1.0
Message-ID: <168597770528.404.15468213878026107518.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     478a93ac9ed7da5e7cd98e00502b142e22dab4d7
Gitweb:        https://git.kernel.org/tip/478a93ac9ed7da5e7cd98e00502b142e22dab4d7
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 25 Apr 2023 20:49:25 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 05 Jun 2023 17:03:39 +02:00

posix-timers: Remove pointless comments

Documenting the obvious is just consuming space for no value.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/r/20230425183313.832240451@linutronix.de

---
 kernel/time/posix-timers.c | 25 -------------------------
 1 file changed, 25 deletions(-)

diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index a22c183..fde1ca9 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -59,19 +59,6 @@ static const struct k_clock clock_realtime, clock_monotonic;
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
@@ -141,7 +128,6 @@ static inline void unlock_timer(struct k_itimer *timr, unsigned long flags)
 	spin_unlock_irqrestore(&timr->it_lock, flags);
 }
 
-/* Get clock_realtime */
 static int posix_get_realtime_timespec(clockid_t which_clock, struct timespec64 *tp)
 {
 	ktime_get_real_ts64(tp);
@@ -153,7 +139,6 @@ static ktime_t posix_get_realtime_ktime(clockid_t which_clock)
 	return ktime_get_real();
 }
 
-/* Set clock_realtime */
 static int posix_clock_realtime_set(const clockid_t which_clock,
 				    const struct timespec64 *tp)
 {
@@ -166,9 +151,6 @@ static int posix_clock_realtime_adj(const clockid_t which_clock,
 	return do_adjtimex(t);
 }
 
-/*
- * Get monotonic time for posix timers
- */
 static int posix_get_monotonic_timespec(clockid_t which_clock, struct timespec64 *tp)
 {
 	ktime_get_ts64(tp);
@@ -181,9 +163,6 @@ static ktime_t posix_get_monotonic_ktime(clockid_t which_clock)
 	return ktime_get();
 }
 
-/*
- * Get monotonic-raw time for posix timers
- */
 static int posix_get_monotonic_raw(clockid_t which_clock, struct timespec64 *tp)
 {
 	ktime_get_raw_ts64(tp);
@@ -191,7 +170,6 @@ static int posix_get_monotonic_raw(clockid_t which_clock, struct timespec64 *tp)
 	return 0;
 }
 
-
 static int posix_get_realtime_coarse(clockid_t which_clock, struct timespec64 *tp)
 {
 	ktime_get_coarse_real_ts64(tp);
@@ -242,9 +220,6 @@ static int posix_get_hrtimer_res(clockid_t which_clock, struct timespec64 *tp)
 	return 0;
 }
 
-/*
- * Initialize everything, well, just everything in Posix clocks/timers ;)
- */
 static __init int init_posix_timers(void)
 {
 	posix_timers_cache = kmem_cache_create("posix_timers_cache",
