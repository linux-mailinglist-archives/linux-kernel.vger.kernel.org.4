Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B0EF65B9AD
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 04:29:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236588AbjACD26 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 22:28:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233379AbjACD2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 22:28:53 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E53D02BDD
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 19:28:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=qELDRvhZejlneuLrWHElLOiKYcXok0NaLlzwVBniaCk=; b=RGGrpVVRBCDe0HAwoA+Rpd0cv2
        xg3sKYt9Dn3irS68XhNTJxRebL6aA09IITs1Jywni5h18cK1c2/wDgWHg1xWLqfbbBXrbDoOPEWY0
        +1Ejj55VeRnIr8aLgm8jtRf8K7U2z0sUzKATW58LqTW0sw5rG39OxHVWF0/AcxeKEcE7dL3QcuuYx
        XWmJmGe1Rq/vjRZ4jKfDhtSveJRmvuVD5nmXTH25bBcbLRng2i4rEI+WU+w60COuS3vkN/Ahbcqag
        9uMPqQIK7Z1AkbTpqxKLXBiYnN805NQQk5/zwnGGCCMhfwYDd9zplC9ApTZ2mCP02ZEenlTB78zgO
        nI1RYNcA==;
Received: from [2601:1c2:d80:3110::a2e7] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pCXyr-00G5Rp-US; Tue, 03 Jan 2023 03:28:50 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH] time: fix various kernel-doc problems
Date:   Mon,  2 Jan 2023 19:28:49 -0800
Message-Id: <20230103032849.12723-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
Cc: John Stultz <jstultz@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Frederic Weisbecker <fweisbec@gmail.com>
Cc: Ingo Molnar <mingo@kernel.org>
---
 kernel/time/tick-oneshot.c |    4 ++--
 kernel/time/time.c         |    8 ++++----
 kernel/time/timekeeping.c  |    8 ++++----
 3 files changed, 10 insertions(+), 10 deletions(-)

diff -- a/kernel/time/time.c b/kernel/time/time.c
--- a/kernel/time/time.c
+++ b/kernel/time/time.c
@@ -462,7 +462,7 @@ struct __kernel_old_timeval ns_to_kernel
 EXPORT_SYMBOL(ns_to_kernel_old_timeval);
 
 /**
- * set_normalized_timespec - set timespec sec and nsec parts and normalize
+ * set_normalized_timespec64 - set timespec sec and nsec parts and normalize
  *
  * @ts:		pointer to timespec variable to be set
  * @sec:	seconds to set
@@ -526,7 +526,7 @@ struct timespec64 ns_to_timespec64(s64 n
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
diff -- a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -1590,10 +1590,10 @@ void __weak read_persistent_clock64(stru
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
@@ -1701,7 +1701,7 @@ static void __timekeeping_inject_sleepti
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
diff -- a/kernel/time/tick-oneshot.c b/kernel/time/tick-oneshot.c
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
@@ -103,7 +103,7 @@ int tick_switch_to_oneshot(void (*handle
  *
  * returns 1 when either nohz or highres are enabled. otherwise 0.
  */
-int tick_oneshot_mode_active(void)
+int tick_check_oneshot_mode(void)
 {
 	unsigned long flags;
 	int ret;
