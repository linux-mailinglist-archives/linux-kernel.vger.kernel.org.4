Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 516A8722A6A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 17:09:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234669AbjFEPJC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 11:09:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234092AbjFEPIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 11:08:31 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FFAFF4;
        Mon,  5 Jun 2023 08:08:30 -0700 (PDT)
Date:   Mon, 05 Jun 2023 15:08:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1685977709;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pHADv+7OJHIno4T2z92NZCkIXEf4MQBrTvQux6oHnC8=;
        b=gONi7Sz/LG3KaZQTg5rLL6R8Ouiev/MBANiPRmkfQ/j4skcRVCxDSEBJnR08PAbVjS6Y7e
        3MLeyrnTEGnKH5q4L0EprOKzch+KXNmNhudbEumda55MbI231dEc/9wP9D0IjJ5NWFJID2
        PW6ENxc1wBshcLniDamwavTkIJZ85H+tXjPhyiGiuxoexP52KEZTUDqoRfkaNhSIg7m2bE
        ipHLdibporcdpspY7BDPithJdOeKTwqjDswW6CVtW+7udGPJaAEUGpEWKgj1kWFmM4vy4R
        UyssLAncvDiT8lGp9uuHzK4abYqUSdyoyajI0Pa7s8H941SZMuAKkX0gPJ+ZpQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1685977709;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pHADv+7OJHIno4T2z92NZCkIXEf4MQBrTvQux6oHnC8=;
        b=Hvlypsmq8DED57jrR2753CEClplnHfko9+WXlbt0Teog+84Jmx9+Sn3DsGtR6grWOyI6fp
        121tocJ9N8EBS6DQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] posix-timers: Document common_clock_get() correctly
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230425183313.409169321@linutronix.de>
References: <20230425183313.409169321@linutronix.de>
MIME-Version: 1.0
Message-ID: <168597770881.404.18105372994539780742.tip-bot2@tip-bot2>
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

Commit-ID:     13a5dd88bb4c8aec6c3f808f75b73b1fe4705244
Gitweb:        https://git.kernel.org/tip/13a5dd88bb4c8aec6c3f808f75b73b1fe4705244
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 25 Apr 2023 20:49:12 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 05 Jun 2023 17:03:38 +02:00

posix-timers: Document common_clock_get() correctly

Replace another confusing and inaccurate set of comments.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/r/20230425183313.409169321@linutronix.de

---
 kernel/time/posix-timers.c | 50 ++++++++++++++++++++++---------------
 1 file changed, 30 insertions(+), 20 deletions(-)

diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index c9896ff..663d3c6 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -660,20 +660,16 @@ static s64 common_hrtimer_forward(struct k_itimer *timr, ktime_t now)
 }
 
 /*
- * Get the time remaining on a POSIX.1b interval timer.  This function
- * is ALWAYS called with spin_lock_irq on the timer, thus it must not
- * mess with irq.
+ * Get the time remaining on a POSIX.1b interval timer.
  *
- * We have a couple of messes to clean up here.  First there is the case
- * of a timer that has a requeue pending.  These timers should appear to
- * be in the timer list with an expiry as if we were to requeue them
- * now.
+ * Two issues to handle here:
  *
- * The second issue is the SIGEV_NONE timer which may be active but is
- * not really ever put in the timer list (to save system resources).
- * This timer may be expired, and if so, we will do it here.  Otherwise
- * it is the same as a requeue pending timer WRT to what we should
- * report.
+ *  1) The timer has a requeue pending. The return value must appear as
+ *     if the timer has been requeued right now.
+ *
+ *  2) The timer is a SIGEV_NONE timer. These timers are never enqueued
+ *     into the hrtimer queue and therefore never expired. Emulate expiry
+ *     here taking #1 into account.
  */
 void common_timer_get(struct k_itimer *timr, struct itimerspec64 *cur_setting)
 {
@@ -689,8 +685,12 @@ void common_timer_get(struct k_itimer *timr, struct itimerspec64 *cur_setting)
 		cur_setting->it_interval = ktime_to_timespec64(iv);
 	} else if (!timr->it_active) {
 		/*
-		 * SIGEV_NONE oneshot timers are never queued. Check them
-		 * below.
+		 * SIGEV_NONE oneshot timers are never queued and therefore
+		 * timr->it_active is always false. The check below
+		 * vs. remaining time will handle this case.
+		 *
+		 * For all other timers there is nothing to update here, so
+		 * return.
 		 */
 		if (!sig_none)
 			return;
@@ -699,18 +699,29 @@ void common_timer_get(struct k_itimer *timr, struct itimerspec64 *cur_setting)
 	now = kc->clock_get_ktime(timr->it_clock);
 
 	/*
-	 * When a requeue is pending or this is a SIGEV_NONE timer move the
-	 * expiry time forward by intervals, so expiry is > now.
+	 * If this is an interval timer and either has requeue pending or
+	 * is a SIGEV_NONE timer move the expiry time forward by intervals,
+	 * so expiry is > now.
 	 */
 	if (iv && (timr->it_requeue_pending & REQUEUE_PENDING || sig_none))
 		timr->it_overrun += kc->timer_forward(timr, now);
 
 	remaining = kc->timer_remaining(timr, now);
-	/* Return 0 only, when the timer is expired and not pending */
+	/*
+	 * As @now is retrieved before a possible timer_forward() and
+	 * cannot be reevaluated by the compiler @remaining is based on the
+	 * same @now value. Therefore @remaining is consistent vs. @now.
+	 *
+	 * Consequently all interval timers, i.e. @iv > 0, cannot have a
+	 * remaining time <= 0 because timer_forward() guarantees to move
+	 * them forward so that the next timer expiry is > @now.
+	 */
 	if (remaining <= 0) {
 		/*
-		 * A single shot SIGEV_NONE timer must return 0, when
-		 * it is expired !
+		 * A single shot SIGEV_NONE timer must return 0, when it is
+		 * expired! Timers which have a real signal delivery mode
+		 * must return a remaining time greater than 0 because the
+		 * signal has not yet been delivered.
 		 */
 		if (!sig_none)
 			cur_setting->it_value.tv_nsec = 1;
@@ -719,7 +730,6 @@ void common_timer_get(struct k_itimer *timr, struct itimerspec64 *cur_setting)
 	}
 }
 
-/* Get the time remaining on a POSIX.1b interval timer. */
 static int do_timer_gettime(timer_t timer_id,  struct itimerspec64 *setting)
 {
 	struct k_itimer *timr;
