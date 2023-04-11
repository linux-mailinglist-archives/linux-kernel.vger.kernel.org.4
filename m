Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DED056DD0E3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 06:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbjDKEZl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 00:25:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbjDKEZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 00:25:27 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A582626BE
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 21:25:26 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id k7-20020a170902c40700b001a20f75cd40so4415191plk.22
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 21:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1681187126; x=1683779126;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UHVT3HqFgc9YcSUsEkMLCVBjJkF8RFumVK/cskeGmNA=;
        b=VbottEcWO41KpD1qtyu9FHlRCSJZdu4FW5Q/IsJbmdGTGRJB2AYl3dhfPelR3e5e02
         3P+/UyK4TTP1aQbOkZkNCv7Sif65DF+O9fLt06eC6R3FsmBNHVMwUHRMYahTwaBty3kN
         xWsy8ND//clDiIwKJBwpOE2JEHFUbZyvqcuMPvjwwE+jwryelkb7Q7cm49E33AlGkQz8
         Zb4S52tJGkUOLVhuEFwr2NknZPQx16wAjg2jMnz9B3tHs9KCZD6FiTbPbXym5RGoWPf5
         6z/+yAL4MoFkFI2lD+e2A6bKdxEFHabxAuNoHY5GZwMl5O2/QNvgmCwFAF0t27QfhwRT
         gK1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681187126; x=1683779126;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UHVT3HqFgc9YcSUsEkMLCVBjJkF8RFumVK/cskeGmNA=;
        b=lW6I//mB/LyfTuMce5uUiwcTuKxZQFWGEDUS7cPKC1xRqvFTijpIzMHK+aFcxOzthR
         UtmNPLSHJ57YG9hZDvgiq8R3AHiPQgw3ERYQJyxZqrgyl/pTtJQtDYrCueKwfkufc8fB
         06aYuQ36nKpLi2bWuwfR7YnkaCYKkwlf8VhtcIT7HSN/yz63bHhpsxpqzTU/d2R8kZ+7
         uhuHe9M6AOz0Ag+cNTazFXKgA5T7SHf0Yfx0zuabmdEo2cLzbIYWUdjZQhPbAYP3uYS+
         d1LGTYQ1hrTkxJC+EE1Upc8tS9xCvy3yU6V/uDix8MAobmi8WYHJYFCJ9abvCgqW+M1t
         ltcw==
X-Gm-Message-State: AAQBX9eLuRqr7dQ4gPcLirOEdZuEkcqudZIVWVE3yf5C4KNz1oHEk0QD
        NiKYKQ4CC5VMNfirMmRFJrr5XlhPBSA6b7vVAynWxtXejDUiFskzjC+rEm7dLz0a1oxsXql9gqh
        BIAwLu3q+fVvDth6ZOjjH55fpijkBPxcPZU33DZwi5gQSqF8vf3eJJni9EMEThKwVg9hxAoc=
X-Google-Smtp-Source: AKy350ZprjH+WO9igNL7Sw51ThJrBl1XpIdlgNRwXqdlfxAxAyfzGGKA338qaLLbIjYJDTT0oLicjZmLKKuK
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a17:902:9898:b0:19f:35d3:ed0b with SMTP id
 s24-20020a170902989800b0019f35d3ed0bmr4086337plp.2.1681187125879; Mon, 10 Apr
 2023 21:25:25 -0700 (PDT)
Date:   Tue, 11 Apr 2023 04:25:01 +0000
In-Reply-To: <20230411042511.1606592-1-jstultz@google.com>
Mime-Version: 1.0
References: <20230411042511.1606592-1-jstultz@google.com>
X-Mailer: git-send-email 2.40.0.577.gac1e443424-goog
Message-ID: <20230411042511.1606592-5-jstultz@google.com>
Subject: [PATCH v3 04/14] locking/mutex: Add task_struct::blocked_lock to
 serialize changes to the blocked_on state
From:   John Stultz <jstultz@google.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Joel Fernandes <joelaf@google.com>,
        Qais Yousef <qyousef@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Zimuzo Ezeozue <zezeozue@google.com>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        "Connor O'Brien" <connoro@google.com>,
        John Stultz <jstultz@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

This patch was split out from the later "sched: Add proxy
execution" patch.

Adds blocked_lock to the task_struct so we can safely keep track
of which tasks are blocked on us.

This will be used for tracking blocked-task/mutex chains with
the prox-execution patch in a similar fashion to how priority
inheritence is done with rt_mutexes.

Cc: Joel Fernandes <joelaf@google.com>
Cc: Qais Yousef <qyousef@google.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ben Segall <bsegall@google.com>
Cc: Zimuzo Ezeozue <zezeozue@google.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Will Deacon <will@kernel.org>
Cc: Waiman Long <longman@redhat.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: "Paul E . McKenney" <paulmck@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
[rebased, added comments and changelog]
Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
[Fixed rebase conflicts]
[squashed sched: Ensure blocked_on is always guarded by blocked_lock]
Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
[fix rebase conflicts, various fixes & tweaks commented inline]
[squashed sched: Use rq->curr vs rq->proxy checks]
Signed-off-by: Connor O'Brien <connoro@google.com>
[jstultz: Split out from bigger patch]
Signed-off-by: John Stultz <jstultz@google.com>
---
v2:
* Split out into its own patch

TODO: Still need to clarify some of the locking changes here
---
 include/linux/sched.h  |  1 +
 init/init_task.c       |  1 +
 kernel/fork.c          |  1 +
 kernel/locking/mutex.c | 27 +++++++++++++++++++++++----
 4 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 6053c7dfb40e..2d736b6c44e9 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1140,6 +1140,7 @@ struct task_struct {
 #endif
 
 	struct mutex			*blocked_on;	/* lock we're blocked on */
+	raw_spinlock_t			blocked_lock;
 
 #ifdef CONFIG_DEBUG_ATOMIC_SLEEP
 	int				non_block_count;
diff --git a/init/init_task.c b/init/init_task.c
index ff6c4b9bfe6b..189ce67e9704 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -130,6 +130,7 @@ struct task_struct init_task
 	.journal_info	= NULL,
 	INIT_CPU_TIMERS(init_task)
 	.pi_lock	= __RAW_SPIN_LOCK_UNLOCKED(init_task.pi_lock),
+	.blocked_lock	= __RAW_SPIN_LOCK_UNLOCKED(init_task.blocked_lock),
 	.timer_slack_ns = 50000, /* 50 usec default slack */
 	.thread_pid	= &init_struct_pid,
 	.thread_group	= LIST_HEAD_INIT(init_task.thread_group),
diff --git a/kernel/fork.c b/kernel/fork.c
index 933406f5596b..a0ff6d73affc 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2119,6 +2119,7 @@ static __latent_entropy struct task_struct *copy_process(
 	ftrace_graph_init_task(p);
 
 	rt_mutex_init_task(p);
+	raw_spin_lock_init(&p->blocked_lock);
 
 	lockdep_assert_irqs_enabled();
 #ifdef CONFIG_PROVE_LOCKING
diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index d7a202c35ebe..9cb2686fb974 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -616,6 +616,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 	}
 
 	raw_spin_lock_irqsave(&lock->wait_lock, flags);
+	raw_spin_lock(&current->blocked_lock);
 	/*
 	 * After waiting to acquire the wait_lock, try again.
 	 */
@@ -677,6 +678,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 				goto err;
 		}
 
+		raw_spin_unlock(&current->blocked_lock);
 		raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
 		if (ww_ctx)
 			ww_ctx_wake(ww_ctx);
@@ -684,6 +686,8 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 
 		first = __mutex_waiter_is_first(lock, &waiter);
 
+		raw_spin_lock_irqsave(&lock->wait_lock, flags);
+		raw_spin_lock(&current->blocked_lock);
 		/*
 		 * Gets reset by ttwu_runnable().
 		 */
@@ -698,15 +702,28 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 			break;
 
 		if (first) {
+			bool acquired;
+
+			/*
+			 * XXX connoro: mutex_optimistic_spin() can schedule, so
+			 * we need to release these locks before calling it.
+			 * This needs refactoring though b/c currently we take
+			 * the locks earlier than necessary when proxy exec is
+			 * disabled and release them unnecessarily when it's
+			 * enabled. At a minimum, need to verify that releasing
+			 * blocked_lock here doesn't create any races.
+			 */
+			raw_spin_unlock(&current->blocked_lock);
+			raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
 			trace_contention_begin(lock, LCB_F_MUTEX | LCB_F_SPIN);
-			if (mutex_optimistic_spin(lock, ww_ctx, &waiter))
+			acquired = mutex_optimistic_spin(lock, ww_ctx, &waiter);
+			raw_spin_lock_irqsave(&lock->wait_lock, flags);
+			raw_spin_lock(&current->blocked_lock);
+			if (acquired)
 				break;
 			trace_contention_begin(lock, LCB_F_MUTEX);
 		}
-
-		raw_spin_lock_irqsave(&lock->wait_lock, flags);
 	}
-	raw_spin_lock_irqsave(&lock->wait_lock, flags);
 acquired:
 	__set_current_state(TASK_RUNNING);
 
@@ -733,6 +750,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 	if (ww_ctx)
 		ww_mutex_lock_acquired(ww, ww_ctx);
 
+	raw_spin_unlock(&current->blocked_lock);
 	raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
 	if (ww_ctx)
 		ww_ctx_wake(ww_ctx);
@@ -745,6 +763,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 	__mutex_remove_waiter(lock, &waiter);
 err_early_kill:
 	trace_contention_end(lock, ret);
+	raw_spin_unlock(&current->blocked_lock);
 	raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
 	debug_mutex_free_waiter(&waiter);
 	mutex_release(&lock->dep_map, ip);
-- 
2.40.0.577.gac1e443424-goog

