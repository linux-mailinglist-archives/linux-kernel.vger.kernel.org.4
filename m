Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D2FD62B468
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 09:00:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233036AbiKPIAA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 03:00:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232908AbiKPH7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 02:59:42 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10FC5C7
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 23:59:42 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id e128-20020a636986000000b0047075a1c725so8926470pgc.19
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 23:59:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LdOYk9RhgVfGcLslo0PFudrqwmqg3H4kC0w388sZncY=;
        b=fr/JCq7r62KE0Vzw76H1bT9MaRv3VI3U4VSrGRUA3D9YlXCe2DUz51VM2lWrXOMUxV
         YVvBZTX2gKnpizrEuUVasgONXKXLzliBHpflI08C9h2pwa2NzO4q064Jgg6ZKBz6igZS
         I9JwaIyxHq8NVtKRz0QSHSCkkbKYzCXQIsScAG1CA3z51Y67t22Hx7StMioevPluwQDa
         882XH8O/VafbYarNIkrtfLoqikiFo3UDW0rnkG0mNz8KsvhslrVhuOyDLWy5QEH8/pzd
         HHHIfpyQnTGTWeZAjbB1M+aC4xSsTawDgHC1jpHvqvNdu5z+IuWLtIrY3uupyafBSqv0
         ifUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LdOYk9RhgVfGcLslo0PFudrqwmqg3H4kC0w388sZncY=;
        b=dPhPrn8VdVuiKAWl13KtVGuUsWLWjTqgls5xBROGoXBc3RPmZqTDg8ljvpKbaGSqs/
         sS51DcUQ3AoiLpsdef3bNdACo3ILbOtQQzLKeLLBVl1ZB1YxUz2br/iY2LImD/hWm15o
         CP+n9p9Aq1d+3FM0rB1Uxi+SLkyTuKDzC0HG87VCJky1k/HfRV0yWqNX62rpE7vwWAWC
         rExbZQrDSgWWdBKKaY6FI7L8TXIH7SIYZQKN9iokyx4COp0F42uSVFBUBRXkQijr/QNf
         IDMbGEKEkWIc+tB3mRQKyl3yurcW6+jSJ90FNLj6YjugvKYPStBJ1KndqvLbMoIpaU2K
         TCBg==
X-Gm-Message-State: ANoB5pmg+IhiwPYYzdjJ4/L7yspZ/g00/XX1XgQIk4RTvZc38jncyC+Z
        SkCHM7wVArN3RwgknsTpDPBye2hvILPMDONKqu+pe+c3NKxdw+67HKMoXkFyYUuFGHaat6Wjkzg
        rB5SqVFILSXXFfqPGYkquhwMSv7rX3fi0H9TqwHIdhjzgYZ1HiuzLNwnWhzWMrvSL+73D1lU=
X-Google-Smtp-Source: AA0mqf6bh8609Vl5w5K4CFmBHb/c4y1gsGgnU4gCKQV5FPf5yeq4UY8W2edrceQwM+tG3UuG5lmDBiDT0Uax
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a17:90a:a392:b0:20a:fee1:8f69 with SMTP id
 x18-20020a17090aa39200b0020afee18f69mr225380pjp.0.1668585580398; Tue, 15 Nov
 2022 23:59:40 -0800 (PST)
Date:   Wed, 16 Nov 2022 07:59:28 +0000
In-Reply-To: <20221116075929.453876-1-jstultz@google.com>
Mime-Version: 1.0
References: <20221116075929.453876-1-jstultz@google.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Message-ID: <20221116075929.453876-4-jstultz@google.com>
Subject: [PATCH v5 3/3] softirq: defer softirq processing to ksoftirqd if CPU
 is busy with RT
From:   John Stultz <jstultz@google.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Pavankumar Kondeti <pkondeti@codeaurora.org>,
        John Dias <joaodias@google.com>,
        "Connor O'Brien" <connoro@google.com>,
        Rick Yiu <rickyiu@google.com>, John Kacur <jkacur@redhat.com>,
        Qais Yousef <qyousef@google.com>,
        Chris Redpath <chris.redpath@arm.com>,
        Abhijeet Dharmapurikar <adharmap@quicinc.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        kernel-team@android.com,
        Satya Durga Srinivasu Prabhala <satyap@codeaurora.org>,
        "J . Avila" <elavila@google.com>, John Stultz <jstultz@google.com>
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

From: Pavankumar Kondeti <pkondeti@codeaurora.org>

Defer the softirq processing to ksoftirqd if a RT task is
running or queued on the current CPU. This complements the RT
task placement algorithm which tries to find a CPU that is not
currently busy with softirqs.

Currently NET_TX, NET_RX, BLOCK and IRQ_POLL softirqs are only
deferred as they can potentially run for long time.

Additionally, this patch stubs out ksoftirqd_running() logic,
in the CONFIG_RT_SOFTIRQ_AWARE_SCHED case, as deferring
potentially long-running softirqs will cause the logic to not
process shorter-running softirqs immediately. By stubbing it out
the potentially long running softirqs are deferred, but the
shorter running ones can still run immediately.

This patch includes folded-in fixes by:
  Lingutla Chandrasekhar <clingutla@codeaurora.org>
  Satya Durga Srinivasu Prabhala <satyap@codeaurora.org>
  J. Avila <elavila@google.com>

Cc: John Dias <joaodias@google.com>
Cc: Connor O'Brien <connoro@google.com>
Cc: Rick Yiu <rickyiu@google.com>
Cc: John Kacur <jkacur@redhat.com>
Cc: Qais Yousef <qyousef@google.com>
Cc: Chris Redpath <chris.redpath@arm.com>
Cc: Abhijeet Dharmapurikar <adharmap@quicinc.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: kernel-team@android.com
Signed-off-by: Pavankumar Kondeti <pkondeti@codeaurora.org>
[satyap@codeaurora.org: trivial merge conflict resolution.]
Signed-off-by: Satya Durga Srinivasu Prabhala <satyap@codeaurora.org>
[elavila: Port to mainline, squash with bugfix]
Signed-off-by: J. Avila <elavila@google.com>
[jstultz: Rebase to linus/HEAD, minor rearranging of code,
 included bug fix Reported-by: Qais Yousef <qais.yousef@arm.com> ]
Signed-off-by: John Stultz <jstultz@google.com>
---
v4:
* Fix commit message to accurately note long-running softirqs
  (suggested by Qais)
* Switch to using rt_task(current) (suggested by Qais)
v5:
* Switch to using CONFIG_RT_SOFTIRQ_AWARE_SCHED (suggested by
  Joel Fernandes <joel@joelfernandes.org>)
---
 kernel/softirq.c | 29 +++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/kernel/softirq.c b/kernel/softirq.c
index dd92ce8f771b..5db2afd0be68 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -95,6 +95,7 @@ static void wakeup_softirqd(void)
 		wake_up_process(tsk);
 }
 
+#ifndef CONFIG_RT_SOFTIRQ_AWARE_SCHED
 /*
  * If ksoftirqd is scheduled, we do not want to process pending softirqs
  * right now. Let ksoftirqd handle this at its own rate, to get fairness,
@@ -109,6 +110,9 @@ static bool ksoftirqd_running(unsigned long pending)
 		return false;
 	return tsk && task_is_running(tsk) && !__kthread_should_park(tsk);
 }
+#else
+#define ksoftirqd_running(pending) (false)
+#endif /* CONFIG_RT_SOFTIRQ_AWARE_SCHED */
 
 #ifdef CONFIG_TRACE_IRQFLAGS
 DEFINE_PER_CPU(int, hardirqs_enabled);
@@ -540,6 +544,21 @@ static inline bool lockdep_softirq_start(void) { return false; }
 static inline void lockdep_softirq_end(bool in_hardirq) { }
 #endif
 
+#ifdef CONFIG_RT_SOFTIRQ_AWARE_SCHED
+static __u32 softirq_deferred_for_rt(__u32 *pending)
+{
+	__u32 deferred = 0;
+
+	if (rt_task(current)) {
+		deferred = *pending & LONG_SOFTIRQ_MASK;
+		*pending &= ~LONG_SOFTIRQ_MASK;
+	}
+	return deferred;
+}
+#else
+#define softirq_deferred_for_rt(x) (0)
+#endif
+
 asmlinkage __visible void __softirq_entry __do_softirq(void)
 {
 	unsigned long end = jiffies + MAX_SOFTIRQ_TIME;
@@ -547,6 +566,7 @@ asmlinkage __visible void __softirq_entry __do_softirq(void)
 	int max_restart = MAX_SOFTIRQ_RESTART;
 	struct softirq_action *h;
 	bool in_hardirq;
+	__u32 deferred;
 	__u32 pending;
 	int softirq_bit;
 
@@ -558,14 +578,16 @@ asmlinkage __visible void __softirq_entry __do_softirq(void)
 	current->flags &= ~PF_MEMALLOC;
 
 	pending = local_softirq_pending();
+	deferred = softirq_deferred_for_rt(&pending);
 
 	softirq_handle_begin();
+
 	in_hardirq = lockdep_softirq_start();
 	account_softirq_enter(current);
 
 restart:
 	/* Reset the pending bitmask before enabling irqs */
-	set_softirq_pending(0);
+	set_softirq_pending(deferred);
 	set_active_softirqs(pending);
 
 	local_irq_enable();
@@ -604,13 +626,16 @@ asmlinkage __visible void __softirq_entry __do_softirq(void)
 	local_irq_disable();
 
 	pending = local_softirq_pending();
+	deferred = softirq_deferred_for_rt(&pending);
+
 	if (pending) {
 		if (time_before(jiffies, end) && !need_resched() &&
 		    --max_restart)
 			goto restart;
+	}
 
+	if (pending | deferred)
 		wakeup_softirqd();
-	}
 
 	account_softirq_exit(current);
 	lockdep_softirq_end(in_hardirq);
-- 
2.38.1.431.g37b22c650d-goog

