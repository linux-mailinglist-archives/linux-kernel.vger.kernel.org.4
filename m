Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFF9972330E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 00:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233026AbjFEWRm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 18:17:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231764AbjFEWRh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 18:17:37 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEAC3F7;
        Mon,  5 Jun 2023 15:17:35 -0700 (PDT)
Date:   Mon, 05 Jun 2023 22:17:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686003453;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bFmH/8FSm71LlhXFZhQZcUgNT4LB4jyLCm1ehu4mUuo=;
        b=W4Wbp6n3tiOYWvBoVimqo1Xv+Zx4yxEyJ9OPhhwFXb+b/d1wsUZqXVSpkurefGfxbS2Auw
        WJ+HRScB1aWv2gg6kTZMge3SXLqY+odrMDRzzgh27kCNHD4a4Q8ioStiSgD11qk8BKorps
        t2XIbdkblmGK0VnsDBtrs3qa1jcEkVpnPxDTUMit4qsy7FDoeZpHwQ1t9sKJU/bijTh6XP
        +Afh54K1YHTxmg4WDvyQ5XMcOVk6+TJCnrAeqsjtdx4Dgd+0KZrwqAeL9xS/h7YThQYbLT
        Q1qXQhVlRSyOeCegY2L7F81lnZ+v/Vb8NYVDVb9GoHE+8Y7OpgkOuFFWRQub7g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686003453;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bFmH/8FSm71LlhXFZhQZcUgNT4LB4jyLCm1ehu4mUuo=;
        b=WPEYK36h+fJhhJZT7d7ItAcH/IyqYbXxJRwzzGOsnE82QOSmJIAXDiaEq5GN7zDdqZawRL
        WkqrEIkvSv35B0AQ==
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
Message-ID: <168600345308.404.11871144619298875931.tip-bot2@tip-bot2>
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

Commit-ID:     298356a3c78198f44ba5df65547a9085334daa38
Gitweb:        https://git.kernel.org/tip/298356a3c78198f44ba5df65547a9085334daa38
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 25 Apr 2023 20:49:25 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 06 Jun 2023 00:12:55 +02:00

posix-timers: Remove pointless comments

Documenting the obvious is just consuming space for no value.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/r/20230425183313.832240451@linutronix.de

---
 kernel/time/posix-timers.c | 25 -------------------------
 1 file changed, 25 deletions(-)

diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index a942020..bdd718c 100644
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
