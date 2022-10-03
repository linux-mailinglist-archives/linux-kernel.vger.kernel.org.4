Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D95685F3802
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 23:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbiJCVpk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 17:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbiJCVpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 17:45:30 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 087C518E29
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 14:45:13 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-348608c1cd3so123209367b3.10
        for <linux-kernel@vger.kernel.org>; Mon, 03 Oct 2022 14:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=2lPDHkr6OShzL47HqxwubJ6/4MPgxbVL4q/02vHxIIE=;
        b=poAaPLRQ2uMD6UtJQz4DocNnFzc32qhqU5IsGQf0XMue4VAGo05e3gqQmOKnXfuJlS
         O6ZdQo4W5QdrGHJP6EP5I+YAkwMEbUy1cQWOj5lOj+mypgIaLtDdALAUzdBK0n/Y6h4b
         q9oYgA2TQnIrw0q3AL4TX6NbN0Amwa0bzLj8m2PKP90bRunMnOZdwfjMRAj8CAb6sYFR
         rZcmlMDgEjfNu0VhlMIBlKkaFbMOjZdh4ofivlMQIDQizlh9QsYIQYxkv4ajko0VtLDx
         72oJa5/pcbDwUIp/Dn8GsD2KQ7PMaEKSEaXA1z6FRZHNY+q4RV6LwApiZibP5NNRrmz3
         z1lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=2lPDHkr6OShzL47HqxwubJ6/4MPgxbVL4q/02vHxIIE=;
        b=fEV73Iif7ts50UmXJxVCGkQtG6TshVvvrvsaUkDC/+wsyNmXutq3jIdhfwXSXKqPuE
         PgfF4wnWv7Wzd7EXLSqRN4JGecaVlpBYqRcrnjhBxBjwOii9LdW3dEkaDSJvgMQiCZXL
         8jTTBFPC5HHvSx5ptrNVXwnRp4B9pULXQ7iTEgq/a/LGxzoEVWgbDCYYJnnX8IYrSqCU
         pTCZgen+hOIZDnBCMB3Y2ooGvqZEB+3hQ6z6QtzF3dWZPQMCBFAqWkQkOkX51M6zmCuw
         v2X+Y/Jl0vwJ9CD/cBfUcmu4u7a+SzJU1EXLxLr8FdasLO/ABKsYgmf9ljCiT2cYm+RO
         8evA==
X-Gm-Message-State: ACrzQf036TiIqiK/fochO43GBmrs2Fo8NFzDVjEliX98eM5A9ncKHjrj
        NZbHgMHNu6F1D2sPVNIxHcar3BIXdBDq9s3/Z07xcAFGoXjWzgFAzTET1+QBDdIT4UjF33h1+ip
        W8hgij5MAxml+/gCM4gmV+Q/XlNpwMs3MRyZrqVn3l81BdDYWWdBZ7drwPFYojH13x0DUbny5
X-Google-Smtp-Source: AMsMyM5dUOaDgraeet2PohobNtZAAxBzv/JN3vhLRIzUdBYHavr608lL0jbMkPuRUjjMDI8Al2tRDbN9lWd3
X-Received: from connoro.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:a99])
 (user=connoro job=sendgmr) by 2002:a5b:a44:0:b0:6b0:13b:c93b with SMTP id
 z4-20020a5b0a44000000b006b0013bc93bmr22656337ybq.398.1664833512297; Mon, 03
 Oct 2022 14:45:12 -0700 (PDT)
Date:   Mon,  3 Oct 2022 21:44:55 +0000
In-Reply-To: <20221003214501.2050087-1-connoro@google.com>
Mime-Version: 1.0
References: <20221003214501.2050087-1-connoro@google.com>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Message-ID: <20221003214501.2050087-6-connoro@google.com>
Subject: [RFC PATCH 05/11] sched: Split scheduler execution context
From:   "Connor O'Brien" <connoro@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com, John Stultz <jstultz@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        "Connor O'Brien" <connoro@google.com>
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

From: Peter Zijlstra <peterz@infradead.org>

Lets define the scheduling context as all the scheduler state in
task_struct and the execution context as all state required to run the
task.

Currently both are intertwined in task_struct. We want to logically
split these such that we can run the execution context of one task
with the scheduling context of another.

To this purpose introduce rq::proxy to point to the task_struct used
for scheduler state and preserve rq::curr to denote the execution
context.

XXX connoro: A couple cases here may need more discussion:
- sched_yield() and yield_to(): whether we call the sched_class
  methods for rq->curr or rq->proxy, there seem to be cases where
  proxy exec could cause a yielding mutex owner to run again
  immediately. How much of a concern is this?
- push_rt_task() calls find_lowest_rq() which can only be invoked on
  RT tasks (scheduler context) but considers CPU affinity (execution
  context). For now we call find_lowest_rq() on rq->curr, bailing out
  when it is not RT, but does this give the desired behavior?

[added lot of comments/questions - identifiable by XXX]
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20181009092434.26221-5-juri.lelli@redhat.com
[add additional comments and update more sched_class code to use
 rq::proxy]
Signed-off-by: Connor O'Brien <connoro@google.com>
---
 kernel/sched/core.c     | 63 +++++++++++++++++++++++++++++++----------
 kernel/sched/deadline.c | 35 ++++++++++++-----------
 kernel/sched/fair.c     | 20 +++++++------
 kernel/sched/rt.c       | 42 ++++++++++++++++-----------
 kernel/sched/sched.h    | 23 +++++++++++++--
 5 files changed, 124 insertions(+), 59 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 617e737392be..c8bfa1ad9551 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -772,12 +772,13 @@ static enum hrtimer_restart hrtick(struct hrtimer *timer)
 {
 	struct rq *rq = container_of(timer, struct rq, hrtick_timer);
 	struct rq_flags rf;
+	struct task_struct *curr = rq->proxy;
 
 	WARN_ON_ONCE(cpu_of(rq) != smp_processor_id());
 
 	rq_lock(rq, &rf);
 	update_rq_clock(rq);
-	rq->curr->sched_class->task_tick(rq, rq->curr, 1);
+	curr->sched_class->task_tick(rq, curr, 1);
 	rq_unlock(rq, &rf);
 
 	return HRTIMER_NORESTART;
@@ -2186,16 +2187,18 @@ static inline void check_class_changed(struct rq *rq, struct task_struct *p,
 
 void check_preempt_curr(struct rq *rq, struct task_struct *p, int flags)
 {
-	if (p->sched_class == rq->curr->sched_class)
-		rq->curr->sched_class->check_preempt_curr(rq, p, flags);
-	else if (sched_class_above(p->sched_class, rq->curr->sched_class))
+	struct task_struct *curr = rq->proxy;
+
+	if (p->sched_class == curr->sched_class)
+		curr->sched_class->check_preempt_curr(rq, p, flags);
+	else if (sched_class_above(p->sched_class, curr->sched_class))
 		resched_curr(rq);
 
 	/*
 	 * A queue event has occurred, and we're going to schedule.  In
 	 * this case, we can save a useless back to back clock update.
 	 */
-	if (task_on_rq_queued(rq->curr) && test_tsk_need_resched(rq->curr))
+	if (task_on_rq_queued(curr) && test_tsk_need_resched(rq->curr))
 		rq_clock_skip_update(rq);
 }
 
@@ -2571,7 +2574,11 @@ __do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new_mask, u32
 		lockdep_assert_held(&p->pi_lock);
 
 	queued = task_on_rq_queued(p);
-	running = task_current(rq, p);
+	/*
+	 * XXX is changing affinity of a proxy a problem?
+	 * Consider for example put_prev_ set_curr_ below...
+	 */
+	running = task_current_proxy(rq, p);
 
 	if (queued) {
 		/*
@@ -5376,7 +5383,7 @@ unsigned long long task_sched_runtime(struct task_struct *p)
 	 * project cycles that may never be accounted to this
 	 * thread, breaking clock_gettime().
 	 */
-	if (task_current(rq, p) && task_on_rq_queued(p)) {
+	if (task_current_proxy(rq, p) && task_on_rq_queued(p)) {
 		prefetch_curr_exec_start(p);
 		update_rq_clock(rq);
 		p->sched_class->update_curr(rq);
@@ -5444,10 +5451,11 @@ void scheduler_tick(void)
 {
 	int cpu = smp_processor_id();
 	struct rq *rq = cpu_rq(cpu);
-	struct task_struct *curr = rq->curr;
 	struct rq_flags rf;
 	unsigned long thermal_pressure;
 	u64 resched_latency;
+	/* accounting goes to the proxy task */
+	struct task_struct *curr = rq->proxy;
 
 	arch_scale_freq_tick();
 	sched_clock_tick();
@@ -5539,6 +5547,13 @@ static void sched_tick_remote(struct work_struct *work)
 	if (cpu_is_offline(cpu))
 		goto out_unlock;
 
+	/*
+	 * XXX don't we need to account to rq->proxy?
+	 * Maybe, since this is a remote tick for full dynticks mode, we are
+	 * always sure that there is no proxy (only a single task is running.
+	 */
+	SCHED_WARN_ON(rq->curr != rq->proxy);
+
 	update_rq_clock(rq);
 
 	if (!is_idle_task(curr)) {
@@ -6462,7 +6477,7 @@ static void __sched notrace __schedule(unsigned int sched_mode)
 		switch_count = &prev->nvcsw;
 	}
 
-	next = pick_next_task(rq, prev, &rf);
+	rq->proxy = next = pick_next_task(rq, prev, &rf);
 	clear_tsk_need_resched(prev);
 	clear_preempt_need_resched();
 #ifdef CONFIG_SCHED_DEBUG
@@ -6929,7 +6944,10 @@ void rt_mutex_setprio(struct task_struct *p, struct task_struct *pi_task)
 
 	prev_class = p->sched_class;
 	queued = task_on_rq_queued(p);
-	running = task_current(rq, p);
+	/*
+	 * XXX how does (proxy exec) mutexes and RT_mutexes work together?!
+	 */
+	running = task_current_proxy(rq, p);
 	if (queued)
 		dequeue_task(rq, p, queue_flag);
 	if (running)
@@ -7017,7 +7035,10 @@ void set_user_nice(struct task_struct *p, long nice)
 		goto out_unlock;
 	}
 	queued = task_on_rq_queued(p);
-	running = task_current(rq, p);
+	/*
+	 * XXX see concerns about do_set_cpus_allowed, rt_mutex_prio & Co.
+	 */
+	running = task_current_proxy(rq, p);
 	if (queued)
 		dequeue_task(rq, p, DEQUEUE_SAVE | DEQUEUE_NOCLOCK);
 	if (running)
@@ -7581,7 +7602,10 @@ static int __sched_setscheduler(struct task_struct *p,
 	}
 
 	queued = task_on_rq_queued(p);
-	running = task_current(rq, p);
+	/*
+	 * XXX and again, how is this safe w.r.t. proxy exec?
+	 */
+	running = task_current_proxy(rq, p);
 	if (queued)
 		dequeue_task(rq, p, queue_flags);
 	if (running)
@@ -8276,6 +8300,11 @@ static void do_sched_yield(void)
 	rq = this_rq_lock_irq(&rf);
 
 	schedstat_inc(rq->yld_count);
+	/*
+	 * XXX how about proxy exec?
+	 * If a task currently proxied by some other task yields, should we
+	 * apply the proxy or the current yield "behaviour" ?
+	 */
 	current->sched_class->yield_task(rq);
 
 	preempt_disable();
@@ -8625,6 +8654,10 @@ EXPORT_SYMBOL(yield);
  */
 int __sched yield_to(struct task_struct *p, bool preempt)
 {
+	/*
+	 * XXX what about current being proxied?
+	 * Should we use proxy->sched_class methods in this case?
+	 */
 	struct task_struct *curr = current;
 	struct rq *rq, *p_rq;
 	unsigned long flags;
@@ -8984,7 +9017,7 @@ void __init init_idle(struct task_struct *idle, int cpu)
 	__set_task_cpu(idle, cpu);
 	rcu_read_unlock();
 
-	rq->idle = idle;
+	rq->proxy = rq->idle = idle;
 	rcu_assign_pointer(rq->curr, idle);
 	idle->on_rq = TASK_ON_RQ_QUEUED;
 #ifdef CONFIG_SMP
@@ -9087,7 +9120,7 @@ void sched_setnuma(struct task_struct *p, int nid)
 
 	rq = task_rq_lock(p, &rf);
 	queued = task_on_rq_queued(p);
-	running = task_current(rq, p);
+	running = task_current_proxy(rq, p);
 
 	if (queued)
 		dequeue_task(rq, p, DEQUEUE_SAVE);
@@ -10209,7 +10242,7 @@ void sched_move_task(struct task_struct *tsk)
 	rq = task_rq_lock(tsk, &rf);
 	update_rq_clock(rq);
 
-	running = task_current(rq, tsk);
+	running = task_current_proxy(rq, tsk);
 	queued = task_on_rq_queued(tsk);
 
 	if (queued)
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 0ab79d819a0d..d5ab7ff64fbc 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1176,7 +1176,7 @@ static enum hrtimer_restart dl_task_timer(struct hrtimer *timer)
 #endif
 
 	enqueue_task_dl(rq, p, ENQUEUE_REPLENISH);
-	if (dl_task(rq->curr))
+	if (dl_task(rq->proxy))
 		check_preempt_curr_dl(rq, p, 0);
 	else
 		resched_curr(rq);
@@ -1303,7 +1303,7 @@ static u64 grub_reclaim(u64 delta, struct rq *rq, struct sched_dl_entity *dl_se)
  */
 static void update_curr_dl(struct rq *rq)
 {
-	struct task_struct *curr = rq->curr;
+	struct task_struct *curr = rq->proxy;
 	struct sched_dl_entity *dl_se = &curr->dl;
 	u64 delta_exec, scaled_delta_exec;
 	int cpu = cpu_of(rq);
@@ -1819,7 +1819,7 @@ static int find_later_rq(struct task_struct *task);
 static int
 select_task_rq_dl(struct task_struct *p, int cpu, int flags)
 {
-	struct task_struct *curr;
+	struct task_struct *curr, *proxy;
 	bool select_rq;
 	struct rq *rq;
 
@@ -1830,6 +1830,7 @@ select_task_rq_dl(struct task_struct *p, int cpu, int flags)
 
 	rcu_read_lock();
 	curr = READ_ONCE(rq->curr); /* unlocked access */
+	proxy = READ_ONCE(rq->proxy);
 
 	/*
 	 * If we are dealing with a -deadline task, we must
@@ -1840,9 +1841,9 @@ select_task_rq_dl(struct task_struct *p, int cpu, int flags)
 	 * other hand, if it has a shorter deadline, we
 	 * try to make it stay here, it might be important.
 	 */
-	select_rq = unlikely(dl_task(curr)) &&
+	select_rq = unlikely(dl_task(proxy)) &&
 		    (curr->nr_cpus_allowed < 2 ||
-		     !dl_entity_preempt(&p->dl, &curr->dl)) &&
+		     !dl_entity_preempt(&p->dl, &proxy->dl)) &&
 		    p->nr_cpus_allowed > 1;
 
 	/*
@@ -1907,7 +1908,7 @@ static void check_preempt_equal_dl(struct rq *rq, struct task_struct *p)
 	 * let's hope p can move out.
 	 */
 	if (rq->curr->nr_cpus_allowed == 1 ||
-	    !cpudl_find(&rq->rd->cpudl, rq->curr, NULL))
+	    !cpudl_find(&rq->rd->cpudl, rq->proxy, NULL))
 		return;
 
 	/*
@@ -1946,7 +1947,7 @@ static int balance_dl(struct rq *rq, struct task_struct *p, struct rq_flags *rf)
 static void check_preempt_curr_dl(struct rq *rq, struct task_struct *p,
 				  int flags)
 {
-	if (dl_entity_preempt(&p->dl, &rq->curr->dl)) {
+	if (dl_entity_preempt(&p->dl, &rq->proxy->dl)) {
 		resched_curr(rq);
 		return;
 	}
@@ -1956,7 +1957,7 @@ static void check_preempt_curr_dl(struct rq *rq, struct task_struct *p,
 	 * In the unlikely case current and p have the same deadline
 	 * let us try to decide what's the best thing to do...
 	 */
-	if ((p->dl.deadline == rq->curr->dl.deadline) &&
+	if (p->dl.deadline == rq->proxy->dl.deadline &&
 	    !test_tsk_need_resched(rq->curr))
 		check_preempt_equal_dl(rq, p);
 #endif /* CONFIG_SMP */
@@ -1991,7 +1992,7 @@ static void set_next_task_dl(struct rq *rq, struct task_struct *p, bool first)
 	if (hrtick_enabled_dl(rq))
 		start_hrtick_dl(rq, p);
 
-	if (rq->curr->sched_class != &dl_sched_class)
+	if (rq->proxy->sched_class != &dl_sched_class)
 		update_dl_rq_load_avg(rq_clock_pelt(rq), rq, 0);
 
 	deadline_queue_push_tasks(rq);
@@ -2311,8 +2312,8 @@ static int push_dl_task(struct rq *rq)
 	 * can move away, it makes sense to just reschedule
 	 * without going further in pushing next_task.
 	 */
-	if (dl_task(rq->curr) &&
-	    dl_time_before(next_task->dl.deadline, rq->curr->dl.deadline) &&
+	if (dl_task(rq->proxy) &&
+	    dl_time_before(next_task->dl.deadline, rq->proxy->dl.deadline) &&
 	    rq->curr->nr_cpus_allowed > 1) {
 		resched_curr(rq);
 		return 0;
@@ -2439,7 +2440,7 @@ static void pull_dl_task(struct rq *this_rq)
 			 * deadline than the current task of its runqueue.
 			 */
 			if (dl_time_before(p->dl.deadline,
-					   src_rq->curr->dl.deadline))
+					   src_rq->proxy->dl.deadline))
 				goto skip;
 
 			if (is_migration_disabled(p)) {
@@ -2478,9 +2479,9 @@ static void task_woken_dl(struct rq *rq, struct task_struct *p)
 	if (!task_running(rq, p) &&
 	    !test_tsk_need_resched(rq->curr) &&
 	    p->nr_cpus_allowed > 1 &&
-	    dl_task(rq->curr) &&
+	    dl_task(rq->proxy) &&
 	    (rq->curr->nr_cpus_allowed < 2 ||
-	     !dl_entity_preempt(&p->dl, &rq->curr->dl))) {
+	     !dl_entity_preempt(&p->dl, &rq->proxy->dl))) {
 		push_dl_tasks(rq);
 	}
 }
@@ -2644,12 +2645,12 @@ static void switched_to_dl(struct rq *rq, struct task_struct *p)
 		return;
 	}
 
-	if (rq->curr != p) {
+	if (rq->proxy != p) {
 #ifdef CONFIG_SMP
 		if (p->nr_cpus_allowed > 1 && rq->dl.overloaded)
 			deadline_queue_push_tasks(rq);
 #endif
-		if (dl_task(rq->curr))
+		if (dl_task(rq->proxy))
 			check_preempt_curr_dl(rq, p, 0);
 		else
 			resched_curr(rq);
@@ -2665,7 +2666,7 @@ static void switched_to_dl(struct rq *rq, struct task_struct *p)
 static void prio_changed_dl(struct rq *rq, struct task_struct *p,
 			    int oldprio)
 {
-	if (task_on_rq_queued(p) || task_current(rq, p)) {
+	if (task_on_rq_queued(p) || task_current_proxy(rq, p)) {
 #ifdef CONFIG_SMP
 		/*
 		 * This might be too much, but unfortunately
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 914096c5b1ae..d142f0611b34 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -924,7 +924,7 @@ static void update_curr(struct cfs_rq *cfs_rq)
 
 static void update_curr_fair(struct rq *rq)
 {
-	update_curr(cfs_rq_of(&rq->curr->se));
+	update_curr(cfs_rq_of(&rq->proxy->se));
 }
 
 static inline void
@@ -5645,7 +5645,7 @@ static void hrtick_start_fair(struct rq *rq, struct task_struct *p)
 		s64 delta = slice - ran;
 
 		if (delta < 0) {
-			if (task_current(rq, p))
+			if (task_current_proxy(rq, p))
 				resched_curr(rq);
 			return;
 		}
@@ -5660,7 +5660,7 @@ static void hrtick_start_fair(struct rq *rq, struct task_struct *p)
  */
 static void hrtick_update(struct rq *rq)
 {
-	struct task_struct *curr = rq->curr;
+	struct task_struct *curr = rq->proxy;
 
 	if (!hrtick_enabled_fair(rq) || curr->sched_class != &fair_sched_class)
 		return;
@@ -7229,7 +7229,7 @@ static void set_skip_buddy(struct sched_entity *se)
  */
 static void check_preempt_wakeup(struct rq *rq, struct task_struct *p, int wake_flags)
 {
-	struct task_struct *curr = rq->curr;
+	struct task_struct *curr = rq->proxy;
 	struct sched_entity *se = &curr->se, *pse = &p->se;
 	struct cfs_rq *cfs_rq = task_cfs_rq(curr);
 	int scale = cfs_rq->nr_running >= sched_nr_latency;
@@ -7263,7 +7263,7 @@ static void check_preempt_wakeup(struct rq *rq, struct task_struct *p, int wake_
 	 * prevents us from potentially nominating it as a false LAST_BUDDY
 	 * below.
 	 */
-	if (test_tsk_need_resched(curr))
+	if (test_tsk_need_resched(rq->curr))
 		return;
 
 	/* Idle tasks are by definition preempted by non-idle tasks. */
@@ -8260,7 +8260,7 @@ static bool __update_blocked_others(struct rq *rq, bool *done)
 	 * update_load_avg() can call cpufreq_update_util(). Make sure that RT,
 	 * DL and IRQ signals have been updated before updating CFS.
 	 */
-	curr_class = rq->curr->sched_class;
+	curr_class = rq->proxy->sched_class;
 
 	thermal_pressure = arch_scale_thermal_pressure(cpu_of(rq));
 
@@ -11416,6 +11416,10 @@ static void task_tick_fair(struct rq *rq, struct task_struct *curr, int queued)
 		entity_tick(cfs_rq, se, queued);
 	}
 
+	/*
+	 * XXX need to use execution context (rq->curr) for task_tick_numa and
+	 * update_misfit_status?
+	 */
 	if (static_branch_unlikely(&sched_numa_balancing))
 		task_tick_numa(rq, curr);
 
@@ -11479,7 +11483,7 @@ prio_changed_fair(struct rq *rq, struct task_struct *p, int oldprio)
 	 * our priority decreased, or if we are not currently running on
 	 * this runqueue and our priority is higher than the current's
 	 */
-	if (task_current(rq, p)) {
+	if (task_current_proxy(rq, p)) {
 		if (p->prio > oldprio)
 			resched_curr(rq);
 	} else
@@ -11621,7 +11625,7 @@ static void switched_to_fair(struct rq *rq, struct task_struct *p)
 		 * kick off the schedule if running, otherwise just see
 		 * if we can still preempt the current task.
 		 */
-		if (task_current(rq, p))
+		if (task_current_proxy(rq, p))
 			resched_curr(rq);
 		else
 			check_preempt_curr(rq, p, 0);
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 55f39c8f4203..116556f4fb0a 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -574,7 +574,7 @@ static void dequeue_rt_entity(struct sched_rt_entity *rt_se, unsigned int flags)
 
 static void sched_rt_rq_enqueue(struct rt_rq *rt_rq)
 {
-	struct task_struct *curr = rq_of_rt_rq(rt_rq)->curr;
+	struct task_struct *curr = rq_of_rt_rq(rt_rq)->proxy;
 	struct rq *rq = rq_of_rt_rq(rt_rq);
 	struct sched_rt_entity *rt_se;
 
@@ -1044,7 +1044,7 @@ static int sched_rt_runtime_exceeded(struct rt_rq *rt_rq)
  */
 static void update_curr_rt(struct rq *rq)
 {
-	struct task_struct *curr = rq->curr;
+	struct task_struct *curr = rq->proxy;
 	struct sched_rt_entity *rt_se = &curr->rt;
 	u64 delta_exec;
 	u64 now;
@@ -1602,7 +1602,7 @@ static int find_lowest_rq(struct task_struct *task);
 static int
 select_task_rq_rt(struct task_struct *p, int cpu, int flags)
 {
-	struct task_struct *curr;
+	struct task_struct *curr, *proxy;
 	struct rq *rq;
 	bool test;
 
@@ -1614,6 +1614,7 @@ select_task_rq_rt(struct task_struct *p, int cpu, int flags)
 
 	rcu_read_lock();
 	curr = READ_ONCE(rq->curr); /* unlocked access */
+	proxy = READ_ONCE(rq->proxy);
 
 	/*
 	 * If the current task on @p's runqueue is an RT task, then
@@ -1642,8 +1643,8 @@ select_task_rq_rt(struct task_struct *p, int cpu, int flags)
 	 * systems like big.LITTLE.
 	 */
 	test = curr &&
-	       unlikely(rt_task(curr)) &&
-	       (curr->nr_cpus_allowed < 2 || curr->prio <= p->prio);
+	       unlikely(rt_task(proxy)) &&
+	       (curr->nr_cpus_allowed < 2 || proxy->prio <= p->prio);
 
 	if (test || !rt_task_fits_capacity(p, cpu)) {
 		int target = find_lowest_rq(p);
@@ -1677,8 +1678,9 @@ static void check_preempt_equal_prio(struct rq *rq, struct task_struct *p)
 	 * Current can't be migrated, useless to reschedule,
 	 * let's hope p can move out.
 	 */
+	/* XXX connoro: should we also bail out in the proxy != curr case? */
 	if (rq->curr->nr_cpus_allowed == 1 ||
-	    !cpupri_find(&rq->rd->cpupri, rq->curr, NULL))
+	    !cpupri_find(&rq->rd->cpupri, rq->proxy, NULL))
 		return;
 
 	/*
@@ -1721,7 +1723,9 @@ static int balance_rt(struct rq *rq, struct task_struct *p, struct rq_flags *rf)
  */
 static void check_preempt_curr_rt(struct rq *rq, struct task_struct *p, int flags)
 {
-	if (p->prio < rq->curr->prio) {
+	struct task_struct *curr = rq->proxy;
+
+	if (p->prio < curr->prio) {
 		resched_curr(rq);
 		return;
 	}
@@ -1739,7 +1743,7 @@ static void check_preempt_curr_rt(struct rq *rq, struct task_struct *p, int flag
 	 * to move current somewhere else, making room for our non-migratable
 	 * task.
 	 */
-	if (p->prio == rq->curr->prio && !test_tsk_need_resched(rq->curr))
+	if (p->prio == curr->prio && !test_tsk_need_resched(rq->curr))
 		check_preempt_equal_prio(rq, p);
 #endif
 }
@@ -1764,7 +1768,7 @@ static inline void set_next_task_rt(struct rq *rq, struct task_struct *p, bool f
 	 * utilization. We only care of the case where we start to schedule a
 	 * rt task
 	 */
-	if (rq->curr->sched_class != &rt_sched_class)
+	if (rq->proxy->sched_class != &rt_sched_class)
 		update_rt_rq_load_avg(rq_clock_pelt(rq), rq, 0);
 
 	rt_queue_push_tasks(rq);
@@ -2037,7 +2041,7 @@ static struct task_struct *pick_next_pushable_task(struct rq *rq)
 			      struct task_struct, pushable_tasks);
 
 	BUG_ON(rq->cpu != task_cpu(p));
-	BUG_ON(task_current(rq, p));
+	BUG_ON(task_current(rq, p) || task_current_proxy(rq, p));
 	BUG_ON(p->nr_cpus_allowed <= 1);
 
 	BUG_ON(!task_on_rq_queued(p));
@@ -2070,7 +2074,7 @@ static int push_rt_task(struct rq *rq, bool pull)
 	 * higher priority than current. If that's the case
 	 * just reschedule current.
 	 */
-	if (unlikely(next_task->prio < rq->curr->prio)) {
+	if (unlikely(next_task->prio < rq->proxy->prio)) {
 		resched_curr(rq);
 		return 0;
 	}
@@ -2091,6 +2095,10 @@ static int push_rt_task(struct rq *rq, bool pull)
 		 * Note that the stoppers are masqueraded as SCHED_FIFO
 		 * (cf. sched_set_stop_task()), so we can't rely on rt_task().
 		 */
+		/* XXX connoro: we still want to call find_lowest_rq on curr because
+		 * it considers CPU affinity, so curr still has to be RT. But should
+		 * we bail out if proxy is not also RT?
+		 */
 		if (rq->curr->sched_class != &rt_sched_class)
 			return 0;
 
@@ -2423,7 +2431,7 @@ static void pull_rt_task(struct rq *this_rq)
 			 * p if it is lower in priority than the
 			 * current task on the run queue
 			 */
-			if (p->prio < src_rq->curr->prio)
+			if (p->prio < src_rq->proxy->prio)
 				goto skip;
 
 			if (is_migration_disabled(p)) {
@@ -2465,9 +2473,9 @@ static void task_woken_rt(struct rq *rq, struct task_struct *p)
 	bool need_to_push = !task_running(rq, p) &&
 			    !test_tsk_need_resched(rq->curr) &&
 			    p->nr_cpus_allowed > 1 &&
-			    (dl_task(rq->curr) || rt_task(rq->curr)) &&
+			    (dl_task(rq->proxy) || rt_task(rq->proxy)) &&
 			    (rq->curr->nr_cpus_allowed < 2 ||
-			     rq->curr->prio <= p->prio);
+			     rq->proxy->prio <= p->prio);
 
 	if (need_to_push)
 		push_rt_tasks(rq);
@@ -2551,7 +2559,7 @@ static void switched_to_rt(struct rq *rq, struct task_struct *p)
 		if (p->nr_cpus_allowed > 1 && rq->rt.overloaded)
 			rt_queue_push_tasks(rq);
 #endif /* CONFIG_SMP */
-		if (p->prio < rq->curr->prio && cpu_online(cpu_of(rq)))
+		if (p->prio < rq->proxy->prio && cpu_online(cpu_of(rq)))
 			resched_curr(rq);
 	}
 }
@@ -2566,7 +2574,7 @@ prio_changed_rt(struct rq *rq, struct task_struct *p, int oldprio)
 	if (!task_on_rq_queued(p))
 		return;
 
-	if (task_current(rq, p)) {
+	if (task_current_proxy(rq, p)) {
 #ifdef CONFIG_SMP
 		/*
 		 * If our priority decreases while running, we
@@ -2592,7 +2600,7 @@ prio_changed_rt(struct rq *rq, struct task_struct *p, int oldprio)
 		 * greater than the current running task
 		 * then reschedule.
 		 */
-		if (p->prio < rq->curr->prio)
+		if (p->prio < rq->proxy->prio)
 			resched_curr(rq);
 	}
 }
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index e26688d387ae..0ef59dc7b8ea 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1014,7 +1014,12 @@ struct rq {
 	 */
 	unsigned int		nr_uninterruptible;
 
-	struct task_struct __rcu	*curr;
+	/*
+	 * XXX connoro: could different names (e.g. exec_ctx and sched_ctx) help
+	 * with readability?
+	 */
+	struct task_struct __rcu	*curr;  /* Execution context */
+	struct task_struct	*proxy; /* Scheduling context (policy) */
 	struct task_struct	*idle;
 	struct task_struct	*stop;
 	unsigned long		next_balance;
@@ -2055,11 +2060,25 @@ static inline u64 global_rt_runtime(void)
 	return (u64)sysctl_sched_rt_runtime * NSEC_PER_USEC;
 }
 
+/*
+ * Is p the current execution context?
+ */
 static inline int task_current(struct rq *rq, struct task_struct *p)
 {
 	return rq->curr == p;
 }
 
+/*
+ * Is p the current scheduling context?
+ *
+ * Note that it might be the current execution context at the same time if
+ * rq->curr == rq->proxy == p.
+ */
+static inline int task_current_proxy(struct rq *rq, struct task_struct *p)
+{
+	return rq->proxy == p;
+}
+
 static inline int task_running(struct rq *rq, struct task_struct *p)
 {
 #ifdef CONFIG_SMP
@@ -2214,7 +2233,7 @@ struct sched_class {
 
 static inline void put_prev_task(struct rq *rq, struct task_struct *prev)
 {
-	WARN_ON_ONCE(rq->curr != prev);
+	WARN_ON_ONCE(rq->proxy != prev);
 	prev->sched_class->put_prev_task(rq, prev);
 }
 
-- 
2.38.0.rc1.362.ged0d419d3c-goog

