Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCB78722A5E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 17:09:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232467AbjFEPIt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 11:08:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233794AbjFEPI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 11:08:29 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA7ECD2;
        Mon,  5 Jun 2023 08:08:27 -0700 (PDT)
Date:   Mon, 05 Jun 2023 15:08:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1685977706;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PAplYoHSmngzRsFNWrHFnD3XVwaxz1tiQGVB5+wXWZI=;
        b=p6VBCA1dJJfgCghJt0XubE3YK1ZNh+9VCT26rtWlD7uOgbSBuy4XSVNZsM5zPH+RADE+Cd
        9Q3Uynb5kL/XT95EM88JDAY1MEsVQlR7VZRcsocflFJi+hV+PVOmG5hvnvBaMy8LniGWfl
        9fieJ3BoLk2q3upLZ+ss0rKKq4TeXG2eXqYITudIYoxQ7bUaksHSrrIoi+HNgbzzO6vnqe
        3FIS3Bnu5qVv87WWYt4S7WNJTEaDsATlIE3zG+UIgGHTk57XcRawscpL+N0ddamwk2LBku
        isxv+ATLw8YXlnYgsRyRrFZhgsrD1vINwHR3rqQG43IqRaAFXO9Enqm5ZyqQ1Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1685977706;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PAplYoHSmngzRsFNWrHFnD3XVwaxz1tiQGVB5+wXWZI=;
        b=dZghajwuc2DSTridLx2UGjYivki09QXrVUKPyOcjexsZM4RYI6EcGFMBL6CRKpaSp/647T
        Tv0kfc8hNs/UfcBQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] posix-timers: Clarify posix_timer_fn() comments
Cc:     Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <874jnrdmrq.ffs@tglx>
References: <874jnrdmrq.ffs@tglx>
MIME-Version: 1.0
Message-ID: <168597770582.404.11174447408587272957.tip-bot2@tip-bot2>
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

Commit-ID:     63dede13d09850a8ace210f8e4227ac5a6b309ae
Gitweb:        https://git.kernel.org/tip/63dede13d09850a8ace210f8e4227ac5a6b309ae
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 01 Jun 2023 21:07:37 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 05 Jun 2023 17:03:38 +02:00

posix-timers: Clarify posix_timer_fn() comments

Make the issues vs. SIG_IGN understandable and remove the 15 years old
promise that a proper solution is already on the horizon.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/874jnrdmrq.ffs@tglx

---
 kernel/time/posix-timers.c | 62 +++++++++++++++++++------------------
 1 file changed, 32 insertions(+), 30 deletions(-)

diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index f1a7c62..a22c183 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -326,11 +326,11 @@ int posix_timer_event(struct k_itimer *timr, int si_private)
 }
 
 /*
- * This function gets called when a POSIX.1b interval timer expires.  It
- * is used as a callback from the kernel internal timer.  The
- * run_timer_list code ALWAYS calls with interrupts on.
-
- * This code is for CLOCK_REALTIME* and CLOCK_MONOTONIC* timers.
+ * This function gets called when a POSIX.1b interval timer expires from
+ * the HRTIMER interrupt (soft interrupt on RT kernels).
+ *
+ * Handles CLOCK_REALTIME, CLOCK_MONOTONIC, CLOCK_BOOTTIME and CLOCK_TAI
+ * based timers.
  */
 static enum hrtimer_restart posix_timer_fn(struct hrtimer *timer)
 {
@@ -348,9 +348,10 @@ static enum hrtimer_restart posix_timer_fn(struct hrtimer *timer)
 
 	if (posix_timer_event(timr, si_private)) {
 		/*
-		 * signal was not sent because of sig_ignor
-		 * we will not get a call back to restart it AND
-		 * it should be restarted.
+		 * The signal was not queued due to SIG_IGN. As a
+		 * consequence the timer is not going to be rearmed from
+		 * the signal delivery path. But as a real signal handler
+		 * can be installed later the timer must be rearmed here.
 		 */
 		if (timr->it_interval != 0) {
 			ktime_t now = hrtimer_cb_get_time(timer);
@@ -359,34 +360,35 @@ static enum hrtimer_restart posix_timer_fn(struct hrtimer *timer)
 			 * FIXME: What we really want, is to stop this
 			 * timer completely and restart it in case the
 			 * SIG_IGN is removed. This is a non trivial
-			 * change which involves sighand locking
-			 * (sigh !), which we don't want to do late in
-			 * the release cycle.
+			 * change to the signal handling code.
+			 *
+			 * For now let timers with an interval less than a
+			 * jiffie expire every jiffie and recheck for a
+			 * valid signal handler.
+			 *
+			 * This avoids interrupt starvation in case of a
+			 * very small interval, which would expire the
+			 * timer immediately again.
 			 *
-			 * For now we just let timers with an interval
-			 * less than a jiffie expire every jiffie to
-			 * avoid softirq starvation in case of SIG_IGN
-			 * and a very small interval, which would put
-			 * the timer right back on the softirq pending
-			 * list. By moving now ahead of time we trick
-			 * hrtimer_forward() to expire the timer
-			 * later, while we still maintain the overrun
-			 * accuracy, but have some inconsistency in
-			 * the timer_gettime() case. This is at least
-			 * better than a starved softirq. A more
-			 * complex fix which solves also another related
-			 * inconsistency is already in the pipeline.
+			 * Moving now ahead of time by one jiffie tricks
+			 * hrtimer_forward() to expire the timer later,
+			 * while it still maintains the overrun accuracy
+			 * for the price of a slight inconsistency in the
+			 * timer_gettime() case. This is at least better
+			 * than a timer storm.
+			 *
+			 * Only required when high resolution timers are
+			 * enabled as the periodic tick based timers are
+			 * automatically aligned to the next tick.
 			 */
-#ifdef CONFIG_HIGH_RES_TIMERS
-			{
-				ktime_t kj = NSEC_PER_SEC / HZ;
+			if (IS_ENABLED(CONFIG_HIGHRES_TIMERS)) {
+				ktime_t kj = TICK_NSECS;
 
 				if (timr->it_interval < kj)
 					now = ktime_add(now, kj);
 			}
-#endif
-			timr->it_overrun += hrtimer_forward(timer, now,
-							    timr->it_interval);
+
+			timr->it_overrun += hrtimer_forward(timer, now, timr->it_interval);
 			ret = HRTIMER_RESTART;
 			++timr->it_requeue_pending;
 			timr->it_active = 1;
