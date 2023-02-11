Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E98EC692EE5
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 07:45:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbjBKGph (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 01:45:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjBKGpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 01:45:35 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FD085FCB
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 22:45:34 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-50fe0b4495cso71705447b3.14
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 22:45:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XUY7buPyO2Rb/4t6A6ezRdCJ8u1oMoPZarNvz1ZIp8s=;
        b=PmjHVhyGfR1NIIAusqytgQan7a4hI9LjnhwDKSfTH1KlwLVkXKGO/eyC3G6OiAQYhc
         FuaTwHQncXZ6S008ELgQPHlIdw8dLOL4/NaF1yycqXzlC6JwAC/q3VdZLnqF6i7q91UW
         BWfTUSqTuiIFUZ81wiW1acNezLK9h3emYKB0yuyyRxJxdibhFyzjhhMdkXcxMb3YS2PB
         9eonuFLxZIvZBbwNc0bkJXk3cTvAzOCTOccq7aVYusqljhUwVnpsGsTQ3j74HsW2jYkN
         urgt8hxnbKFmsDvojvpSumhBdVZsi0d3+G5eiABGYDYn36ZynWKMfqCKlDsHoUUgzNWW
         bfEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XUY7buPyO2Rb/4t6A6ezRdCJ8u1oMoPZarNvz1ZIp8s=;
        b=mYmZXUQdwpxfL9HHbZC2IUbuPdE/GEAMkLrKjSLB3qhuzyv6xsyFcK+dVYSOFVAVK3
         GGDoPD4J6ZQKTQl3OugAMsrb7UKLfkuIwogY/VEe8+qjrN0Qsrvd7a3lVUwUNnncgrcE
         wh1snGKDAQeIV8zDesxKyQ5wCI+hk74nU2ap0ouJ0touDn8+f72heJwBLOFJ69HpR2zg
         NNZB6gpRr9627GP/oB7Kbf+GgttB9o8LoNm8b2YXfSQhH7Xvlq59zwIizQXxnCMyYA/0
         qKwe6Le85Y+UO5JA1ecHBHhTgiXMWx/PDrzx1tR4BfZdRDIrvWHmhb2F3s+mUUsEdYd9
         98ew==
X-Gm-Message-State: AO0yUKUcYy6beaA4kmqSFoN3YGtl4zOLMAa/dRMwM2gJG1Q78tTFXmAM
        rh7yep7qIY32MGELCMhFJOVPfrq0YDr69NKqBzEI/3xG1RGOFgFu23vzNKvYVOpDhKSbq/bR/Zc
        Flm9hi0h9dA2ypvcKLy3K1JADwFYO3HY532fiyfCmD2OKlnj4A5oy4X9CMj7GO42dbrggH1A=
X-Google-Smtp-Source: AK7set+9BvlpeZIZtVdSoCzE/GiwNfSRP64kUSkJBerCGUufyrydctPPBkLMSjgsAmj4TFi5QLgDNbwGHkmR
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a0d:fb84:0:b0:527:9733:fdee with SMTP id
 l126-20020a0dfb84000000b005279733fdeemr2175211ywf.490.1676097933895; Fri, 10
 Feb 2023 22:45:33 -0800 (PST)
Date:   Sat, 11 Feb 2023 06:45:27 +0000
In-Reply-To: <20230211064527.3481754-1-jstultz@google.com>
Mime-Version: 1.0
References: <20230211064527.3481754-1-jstultz@google.com>
X-Mailer: git-send-email 2.39.1.581.gbfd45094c4-goog
Message-ID: <20230211064527.3481754-2-jstultz@google.com>
Subject: [RFC][PATCH 2/2] time: alarmtimer: Use TASK_FREEZABLE to cleanup
 freezer handling
From:   John Stultz <jstultz@google.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Michael <michael@mipisi.de>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of trying to handle the freezer waking up tasks from
schedule() in nanosleep on alarmtimers explicitly, use
TASK_FREEZABLE which marks the task freezable when it goes
to schedule, which prevents the signal wakeup.

This allows for the freezer handling to be removed, simplifying
the code.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Michael <michael@mipisi.de>
Cc: Michael Trimarchi <michael@amarulasolutions.com>
Cc: kernel-team@android.com
Originally-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/lkml/alpine.DEB.2.21.1909021247250.3955@nanos.tec.linutronix.de/
[jstultz: Forward ported to 6.2-rc and split out from a separate
          fix.]
Signed-off-by: John Stultz <jstultz@google.com>
---
 kernel/time/alarmtimer.c | 53 ++--------------------------------------
 1 file changed, 2 insertions(+), 51 deletions(-)

diff --git a/kernel/time/alarmtimer.c b/kernel/time/alarmtimer.c
index f7b2128f64e2..15ecde8fcc1b 100644
--- a/kernel/time/alarmtimer.c
+++ b/kernel/time/alarmtimer.c
@@ -49,14 +49,6 @@ static struct alarm_base {
 	clockid_t		base_clockid;
 } alarm_bases[ALARM_NUMTYPE];
 
-#if defined(CONFIG_POSIX_TIMERS) || defined(CONFIG_RTC_CLASS)
-/* freezer information to handle clock_nanosleep triggered wakeups */
-static enum alarmtimer_type freezer_alarmtype;
-static ktime_t freezer_expires;
-static ktime_t freezer_delta;
-static DEFINE_SPINLOCK(freezer_delta_lock);
-#endif
-
 #ifdef CONFIG_RTC_CLASS
 /* rtc timer and device for setting alarm wakeups at suspend */
 static struct rtc_timer		rtctimer;
@@ -241,19 +233,12 @@ EXPORT_SYMBOL_GPL(alarm_expires_remaining);
  */
 static int alarmtimer_suspend(struct device *dev)
 {
-	ktime_t min, now, expires;
+	ktime_t now, expires, min = KTIME_MAX;
 	int i, ret, type;
 	struct rtc_device *rtc;
 	unsigned long flags;
 	struct rtc_time tm;
 
-	spin_lock_irqsave(&freezer_delta_lock, flags);
-	min = freezer_delta;
-	expires = freezer_expires;
-	type = freezer_alarmtype;
-	freezer_delta = KTIME_MAX;
-	spin_unlock_irqrestore(&freezer_delta_lock, flags);
-
 	rtc = alarmtimer_get_rtcdev();
 	/* If we have no rtcdev, just return */
 	if (!rtc)
@@ -480,38 +465,6 @@ u64 alarm_forward_now(struct alarm *alarm, ktime_t interval)
 EXPORT_SYMBOL_GPL(alarm_forward_now);
 
 #ifdef CONFIG_POSIX_TIMERS
-
-static void alarmtimer_freezerset(ktime_t absexp, enum alarmtimer_type type)
-{
-	struct alarm_base *base;
-	unsigned long flags;
-	ktime_t delta;
-
-	switch(type) {
-	case ALARM_REALTIME:
-		base = &alarm_bases[ALARM_REALTIME];
-		type = ALARM_REALTIME_FREEZER;
-		break;
-	case ALARM_BOOTTIME:
-		base = &alarm_bases[ALARM_BOOTTIME];
-		type = ALARM_BOOTTIME_FREEZER;
-		break;
-	default:
-		WARN_ONCE(1, "Invalid alarm type: %d\n", type);
-		return;
-	}
-
-	delta = ktime_sub(absexp, base->get_ktime());
-
-	spin_lock_irqsave(&freezer_delta_lock, flags);
-	if (delta < freezer_delta) {
-		freezer_delta = delta;
-		freezer_expires = absexp;
-		freezer_alarmtype = type;
-	}
-	spin_unlock_irqrestore(&freezer_delta_lock, flags);
-}
-
 /**
  * clock2alarm - helper that converts from clockid to alarmtypes
  * @clockid: clockid.
@@ -750,7 +703,7 @@ static int alarmtimer_do_nsleep(struct alarm *alarm, ktime_t absexp,
 	struct restart_block *restart;
 	alarm->data = (void *)current;
 	do {
-		set_current_state(TASK_INTERRUPTIBLE);
+		set_current_state(TASK_INTERRUPTIBLE | TASK_FREEZABLE);
 		alarm_start(alarm, absexp);
 		if (likely(alarm->data))
 			schedule();
@@ -765,8 +718,6 @@ static int alarmtimer_do_nsleep(struct alarm *alarm, ktime_t absexp,
 	if (!alarm->data)
 		return 0;
 
-	if (freezing(current))
-		alarmtimer_freezerset(absexp, type);
 	restart = &current->restart_block;
 	if (restart->nanosleep.type != TT_NONE) {
 		struct timespec64 rmt;
-- 
2.39.1.581.gbfd45094c4-goog

