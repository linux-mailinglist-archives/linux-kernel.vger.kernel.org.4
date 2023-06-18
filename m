Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD43C73485B
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jun 2023 22:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbjFRUun (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jun 2023 16:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbjFRUuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 16:50:06 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3A58E50;
        Sun, 18 Jun 2023 13:50:04 -0700 (PDT)
Date:   Sun, 18 Jun 2023 20:50:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1687121403;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YpXG9REuMylSASdnlFZVvxdCBcm2UP5k7d+AffXNLKE=;
        b=MfsUgq5Z9Og+qG8qijuKFNR/4OMzFFR6otO8kUFcUvqDa1GQFt62adL7Fibw0BWIvVXBKa
        1Aytq3VKa1MGZBRON6hIfMGsIlTdvUoWCHIS75bsmjHa2HqLU4xqrTU5adXKp6MKQ8gbvT
        B6lpJznhPQ6AYlA1qjjt2Q7EJS4B8eFmngshRHOUw6Y4g3XhtvNLJLg1C0zrARJYn7Fb44
        MRa0XJr2oe4zOms5cE5PvopUVKTRptkjVu5ia8pSJwWm23qXw2X+Pett4geLsPaMUsqDYP
        VSFtZ+mSVT76X06gI5jq5KuA8x8AmN4CXgH67XhOGaA6uLZnUuMX5/TN5GUT4Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1687121403;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YpXG9REuMylSASdnlFZVvxdCBcm2UP5k7d+AffXNLKE=;
        b=jpozfEYg6XfmtrMjdPPd6AWAMbbiEigo2jU8+K0qRKSMsQt6duS36s9NGX6ekNHraSWNGX
        qLRBc18YDbkH82Cg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] posix-timers: Document sys_clock_getres() correctly
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230425183313.356427330@linutronix.de>
References: <20230425183313.356427330@linutronix.de>
MIME-Version: 1.0
Message-ID: <168712140276.404.16251417611941366765.tip-bot2@tip-bot2>
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

Commit-ID:     01679b5db7172b898be325ff272e10aebd412911
Gitweb:        https://git.kernel.org/tip/01679b5db7172b898be325ff272e10aebd412911
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 25 Apr 2023 20:49:11 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sun, 18 Jun 2023 22:41:50 +02:00

posix-timers: Document sys_clock_getres() correctly

The decades old comment about Posix clock resolution is confusing at best.

Remove it and add a proper explanation to sys_clock_getres().

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/r/20230425183313.356427330@linutronix.de

---
 kernel/time/posix-timers.c | 81 +++++++++++++++++++++++++++++++++----
 1 file changed, 73 insertions(+), 8 deletions(-)

diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index 6ac6933..1acdd04 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -67,14 +67,6 @@ static const struct k_clock clock_realtime, clock_monotonic;
  *	    to implement others.  This structure defines the various
  *	    clocks.
  *
- * RESOLUTION: Clock resolution is used to round up timer and interval
- *	    times, NOT to report clock times, which are reported with as
- *	    much resolution as the system can muster.  In some cases this
- *	    resolution may depend on the underlying clock hardware and
- *	    may not be quantifiable until run time, and only then is the
- *	    necessary code is written.	The standard says we should say
- *	    something about this issue in the documentation...
- *
  * FUNCTIONS: The CLOCKs structure defines possible functions to
  *	    handle various clock functions.
  *
@@ -1198,6 +1190,79 @@ SYSCALL_DEFINE2(clock_adjtime, const clockid_t, which_clock,
 	return err;
 }
 
+/**
+ * sys_clock_getres - Get the resolution of a clock
+ * @which_clock:	The clock to get the resolution for
+ * @tp:			Pointer to a a user space timespec64 for storage
+ *
+ * POSIX defines:
+ *
+ * "The clock_getres() function shall return the resolution of any
+ * clock. Clock resolutions are implementation-defined and cannot be set by
+ * a process. If the argument res is not NULL, the resolution of the
+ * specified clock shall be stored in the location pointed to by res. If
+ * res is NULL, the clock resolution is not returned. If the time argument
+ * of clock_settime() is not a multiple of res, then the value is truncated
+ * to a multiple of res."
+ *
+ * Due to the various hardware constraints the real resolution can vary
+ * wildly and even change during runtime when the underlying devices are
+ * replaced. The kernel also can use hardware devices with different
+ * resolutions for reading the time and for arming timers.
+ *
+ * The kernel therefore deviates from the POSIX spec in various aspects:
+ *
+ * 1) The resolution returned to user space
+ *
+ *    For CLOCK_REALTIME, CLOCK_MONOTONIC, CLOCK_BOOTTIME, CLOCK_TAI,
+ *    CLOCK_REALTIME_ALARM, CLOCK_BOOTTIME_ALAREM and CLOCK_MONOTONIC_RAW
+ *    the kernel differentiates only two cases:
+ *
+ *    I)  Low resolution mode:
+ *
+ *	  When high resolution timers are disabled at compile or runtime
+ *	  the resolution returned is nanoseconds per tick, which represents
+ *	  the precision at which timers expire.
+ *
+ *    II) High resolution mode:
+ *
+ *	  When high resolution timers are enabled the resolution returned
+ *	  is always one nanosecond independent of the actual resolution of
+ *	  the underlying hardware devices.
+ *
+ *	  For CLOCK_*_ALARM the actual resolution depends on system
+ *	  state. When system is running the resolution is the same as the
+ *	  resolution of the other clocks. During suspend the actual
+ *	  resolution is the resolution of the underlying RTC device which
+ *	  might be way less precise than the clockevent device used during
+ *	  running state.
+ *
+ *   For CLOCK_REALTIME_COARSE and CLOCK_MONOTONIC_COARSE the resolution
+ *   returned is always nanoseconds per tick.
+ *
+ *   For CLOCK_PROCESS_CPUTIME and CLOCK_THREAD_CPUTIME the resolution
+ *   returned is always one nanosecond under the assumption that the
+ *   underlying scheduler clock has a better resolution than nanoseconds
+ *   per tick.
+ *
+ *   For dynamic POSIX clocks (PTP devices) the resolution returned is
+ *   always one nanosecond.
+ *
+ * 2) Affect on sys_clock_settime()
+ *
+ *    The kernel does not truncate the time which is handed in to
+ *    sys_clock_settime(). The kernel internal timekeeping is always using
+ *    nanoseconds precision independent of the clocksource device which is
+ *    used to read the time from. The resolution of that device only
+ *    affects the presicion of the time returned by sys_clock_gettime().
+ *
+ * Returns:
+ *	0		Success. @tp contains the resolution
+ *	-EINVAL		@which_clock is not a valid clock ID
+ *	-EFAULT		Copying the resolution to @tp faulted
+ *	-ENODEV		Dynamic POSIX clock is not backed by a device
+ *	-EOPNOTSUPP	Dynamic POSIX clock does not support getres()
+ */
 SYSCALL_DEFINE2(clock_getres, const clockid_t, which_clock,
 		struct __kernel_timespec __user *, tp)
 {
