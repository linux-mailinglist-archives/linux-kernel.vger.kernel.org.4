Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97CEB65BE15
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 11:31:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236965AbjACKbS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 05:31:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230309AbjACKbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 05:31:10 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06B44AE49;
        Tue,  3 Jan 2023 02:31:04 -0800 (PST)
Date:   Tue, 03 Jan 2023 10:31:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1672741862;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9dQaYHnS1tUWEwOPpf3/CuKygC0/bC+taW1NVHW03hI=;
        b=BefH7es72a9MOjOJ7x3ZMwHpfRGtrgls+OzTuYOuusRWiX0jvNA+8pz8+ZABYI/f/eqk4C
        pMQsZDXYjJt/jQSkv0FIIaMfUvj0HhJb/v5Z3bSiCglI1pin4XFyEiTDvMc4NmFZIVhjzd
        tny8EnKjCgDJm0GMCrtT6DNnvuLZOtOzMUyzpEddy8qCOdUxOI7AaQdmdyJpy/VOS13i4f
        lnKB4KIVQ6ruU1qg+A3WxGG79VKCnqqLbS+UpgFPqYGK6NMo7zUtuXXUpu/MtAg90TezkL
        ZE04VVQXFdBbGtxW/r+K8BO9qn+rlhMymRiYXIQXGpe5SKithMRqgpGjXgM//Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1672741862;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9dQaYHnS1tUWEwOPpf3/CuKygC0/bC+taW1NVHW03hI=;
        b=XWOo6SlfE8LdAHfb6jVL87xzLs+JXEKgEK3HjR4u9wxtnPFxV93HqV8xBPxDAoV4BPMKyH
        o+5abwnDqeDEMrAg==
From:   "tip-bot2 for Randy Dunlap" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/urgent] time: Fix various kernel-doc problems
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230103032849.12723-1-rdunlap@infradead.org>
References: <20230103032849.12723-1-rdunlap@infradead.org>
MIME-Version: 1.0
Message-ID: <167274186174.4906.12725128769668943577.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/urgent branch of tip:

Commit-ID:     f3cb80804b8295323919e031281768ba3bf5f8da
Gitweb:        https://git.kernel.org/tip/f3cb80804b8295323919e031281768ba3bf5f8da
Author:        Randy Dunlap <rdunlap@infradead.org>
AuthorDate:    Mon, 02 Jan 2023 19:28:49 -08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 03 Jan 2023 11:07:58 +01:00

time: Fix various kernel-doc problems

Clean up kernel-doc complaints about function names and non-kernel-doc
comments in kernel/time/. Fixes these warnings:

  kernel/time/time.c:479: warning: expecting prototype for set_normalized_timespec(). Prototype was for set_normalized_timespec64() instead
  kernel/time/time.c:553: warning: expecting prototype for msecs_to_jiffies(). Prototype was for __msecs_to_jiffies() instead

  kernel/time/timekeeping.c:1595: warning: contents before sections
  kernel/time/timekeeping.c:1705: warning: This comment starts with '/**', but isn't a kernel-doc comment.
   * We have three kinds of time sources to use for sleep time
  kernel/time/timekeeping.c:1726: warning: This comment starts with '/**', but isn't a kernel-doc comment.
   * 1) can be determined whether to use or not only when doing

  kernel/time/tick-oneshot.c:21: warning: missing initial short description on line:
   * tick_program_event
  kernel/time/tick-oneshot.c:107: warning: expecting prototype for tick_check_oneshot_mode(). Prototype was for tick_oneshot_mode_active() instead

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20230103032849.12723-1-rdunlap@infradead.org
---
 kernel/time/tick-oneshot.c | 4 ++--
 kernel/time/time.c         | 8 ++++----
 kernel/time/timekeeping.c  | 8 ++++----
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/kernel/time/tick-oneshot.c b/kernel/time/tick-oneshot.c
index 475ecce..5e2c2c2 100644
--- a/kernel/time/tick-oneshot.c
+++ b/kernel/time/tick-oneshot.c
@@ -18,7 +18,7 @@
 #include "tick-internal.h"
 
 /**
- * tick_program_event
+ * tick_program_event - program the CPU local timer device for the next event
  */
 int tick_program_event(ktime_t expires, int force)
 {
@@ -99,7 +99,7 @@ int tick_switch_to_oneshot(void (*handler)(struct clock_event_device *))
 }
 
 /**
- * tick_check_oneshot_mode - check whether the system is in oneshot mode
+ * tick_oneshot_mode_active - check whether the system is in oneshot mode
  *
  * returns 1 when either nohz or highres are enabled. otherwise 0.
  */
diff --git a/kernel/time/time.c b/kernel/time/time.c
index 526257b..f4198af 100644
--- a/kernel/time/time.c
+++ b/kernel/time/time.c
@@ -462,7 +462,7 @@ struct __kernel_old_timeval ns_to_kernel_old_timeval(s64 nsec)
 EXPORT_SYMBOL(ns_to_kernel_old_timeval);
 
 /**
- * set_normalized_timespec - set timespec sec and nsec parts and normalize
+ * set_normalized_timespec64 - set timespec sec and nsec parts and normalize
  *
  * @ts:		pointer to timespec variable to be set
  * @sec:	seconds to set
@@ -526,7 +526,7 @@ struct timespec64 ns_to_timespec64(s64 nsec)
 EXPORT_SYMBOL(ns_to_timespec64);
 
 /**
- * msecs_to_jiffies: - convert milliseconds to jiffies
+ * __msecs_to_jiffies: - convert milliseconds to jiffies
  * @m:	time in milliseconds
  *
  * conversion is done as follows:
@@ -541,12 +541,12 @@ EXPORT_SYMBOL(ns_to_timespec64);
  *   handling any 32-bit overflows.
  *   for the details see __msecs_to_jiffies()
  *
- * msecs_to_jiffies() checks for the passed in value being a constant
+ * __msecs_to_jiffies() checks for the passed in value being a constant
  * via __builtin_constant_p() allowing gcc to eliminate most of the
  * code, __msecs_to_jiffies() is called if the value passed does not
  * allow constant folding and the actual conversion must be done at
  * runtime.
- * the _msecs_to_jiffies helpers are the HZ dependent conversion
+ * The _msecs_to_jiffies helpers are the HZ dependent conversion
  * routines found in include/linux/jiffies.h
  */
 unsigned long __msecs_to_jiffies(const unsigned int m)
diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index f72b9f1..5579ead 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -1590,10 +1590,10 @@ void __weak read_persistent_clock64(struct timespec64 *ts)
 /**
  * read_persistent_wall_and_boot_offset - Read persistent clock, and also offset
  *                                        from the boot.
+ * @wall_time:	  current time as returned by persistent clock
+ * @boot_offset:  offset that is defined as wall_time - boot_time
  *
  * Weak dummy function for arches that do not yet support it.
- * @wall_time:	- current time as returned by persistent clock
- * @boot_offset: - offset that is defined as wall_time - boot_time
  *
  * The default function calculates offset based on the current value of
  * local_clock(). This way architectures that support sched_clock() but don't
@@ -1701,7 +1701,7 @@ static void __timekeeping_inject_sleeptime(struct timekeeper *tk,
 }
 
 #if defined(CONFIG_PM_SLEEP) && defined(CONFIG_RTC_HCTOSYS_DEVICE)
-/**
+/*
  * We have three kinds of time sources to use for sleep time
  * injection, the preference order is:
  * 1) non-stop clocksource
@@ -1722,7 +1722,7 @@ bool timekeeping_rtc_skipresume(void)
 	return !suspend_timing_needed;
 }
 
-/**
+/*
  * 1) can be determined whether to use or not only when doing
  * timekeeping_resume() which is invoked after rtc_suspend(),
  * so we can't skip rtc_suspend() surely if system has 1).
