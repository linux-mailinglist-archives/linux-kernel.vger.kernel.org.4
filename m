Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 101E16C25BE
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 00:38:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbjCTXiZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 19:38:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbjCTXiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 19:38:07 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F41E366AD
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 16:37:46 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id c187-20020a25c0c4000000b00b6fd84f760dso262443ybf.12
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 16:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679355464;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=t4SbJQTGrAynFT6BXJUh1wiDWDragfA0SgeXDDiqdjc=;
        b=M6QKpdQBBfE00Vnz6gDnC+aUq3b22ZycjP5yAJmfNt9mIqAsGoL1uGarveMYg7vxIn
         55wx/MauuW85+PVHRw5MzdZ3uxWl9MzZwXheezwaEuNyPxchlLI0Abwd/r4WLjTJTJBt
         EztIpm9ucJT2qKGbJUFoFOTL0a9hif2K3iJAum8tEJghrSvSVsF9mVtYd1lDPbwQ2eAW
         ylH/Fke88qffooeOMIJGGgjL7mzskg2dGHxk5iVBY3kwkxdWkMkZjNtBmGOt9HUtRQYY
         7kuQAGq82X3K3bIpaN0Y6NU8812C7+ChoWW++qdCS9b/DvNKOzbBhz/gZnjuZgpgafLp
         +rwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679355464;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t4SbJQTGrAynFT6BXJUh1wiDWDragfA0SgeXDDiqdjc=;
        b=Bwsh/l0nOWNxHglFsUxLHc/ZEK5QbYuXK0KGjm/iTBXQ6aHDhz1l9Ptp+bZG63j9z+
         E0zsr6OWgmer6CGbcQnHN09sDTmOv79pdWTgczIA4TjHbCePbJKVkjLPQu8lz0sEoVGB
         c/WBR5GE4S+Z5EpYyWl2FD5/kkpSzrY1GsvGl+EZVZ5X92IbCTpChHYtftNwRX84rUMS
         XdLml7cz3CP30Ue/H4coqcC4+SYLtPbE6yheh/QTPml2GmSCCXKL3ZE3hGC6AonEoWCX
         5g0T8JxSrNKWLFHX2Sieq46K9HckbVzJZ2CmGK5fWdRgVTXiyFKKK1c3VljLWelsn5Rw
         mOHw==
X-Gm-Message-State: AAQBX9cqoMDs1U96kBFZj6bmpoVx3dobvWEdK0XAfIhDQfLXVgZ19RKF
        S9b8gr7JLUNNZxkA3RlWOdWHg2GqaJg8dW5D/9tY8wuVh833EXcCjEankwHZJeDcvqHCfkSJ/Dv
        9IG+OxwMTiPm4eln8QnjCsyowLiKIB1XntsaN8PD0wRulXigGDnLN8152OpxwNw0LmWegJjo=
X-Google-Smtp-Source: AKy350Z4j3R5C8lOFP8K0LxNO1Liw0+XgkmyPA6vzyeP7fJvdiMtZhR4sLJOzQT0RK2kYD0HLe1bSW8dohLD
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a05:6902:706:b0:b6f:3b44:8587 with SMTP id
 k6-20020a056902070600b00b6f3b448587mr176301ybt.11.1679355464716; Mon, 20 Mar
 2023 16:37:44 -0700 (PDT)
Date:   Mon, 20 Mar 2023 23:37:16 +0000
In-Reply-To: <20230320233720.3488453-1-jstultz@google.com>
Mime-Version: 1.0
References: <20230320233720.3488453-1-jstultz@google.com>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
Message-ID: <20230320233720.3488453-9-jstultz@google.com>
Subject: [PATCH v2 08/12] sched: Split scheduler execution context
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
        "Paul E . McKenney" <paulmck@kernel.org>, kernel-team@android.com,
        "Connor O'Brien" <connoro@google.com>,
        John Stultz <jstultz@google.com>
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

XXX connoro: some further work may be needed in RT/DL load balancing
paths to properly handle split context; see comments in code for
specifics

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
Cc: kernel-team@android.com
[added lot of comments/questions - identifiable by XXX]
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20181009092434.26221-5-juri.lelli@redhat.com
[add additional comments and update more sched_class code to use
 rq::proxy]
Signed-off-by: Connor O'Brien <connoro@google.com>
[jstultz: Rebased and resolved minor collisions, reworked to use
 accessors, tweaked update_curr_common to use rq_proxy fixing rt
 scheduling issues]
Signed-off-by: John Stultz <jstultz@google.com>
---
v2:
* Reworked to use accessors
* Fixed update_curr_common to use proxy instead of curr
---
 kernel/sched/core.c     | 41 +++++++++++++++++-------
 kernel/sched/deadline.c | 36 +++++++++++----------
 kernel/sched/fair.c     | 22 +++++++------
 kernel/sched/rt.c       | 59 +++++++++++++++++++++++------------
 kernel/sched/sched.h    | 69 +++++++++++++++++++++++++++++++++++++++--
 5 files changed, 168 insertions(+), 59 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index faaad249f8f7..ab6b1917bc70 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -773,7 +773,7 @@ static enum hrtimer_restart hrtick(struct hrtimer *timer)
 
 	rq_lock(rq, &rf);
 	update_rq_clock(rq);
-	rq_curr(rq)->sched_class->task_tick(rq, rq_curr(rq), 1);
+	rq_proxy(rq)->sched_class->task_tick(rq, rq_proxy(rq), 1);
 	rq_unlock(rq, &rf);
 
 	return HRTIMER_NORESTART;
@@ -2175,7 +2175,7 @@ static inline void check_class_changed(struct rq *rq, struct task_struct *p,
 
 void check_preempt_curr(struct rq *rq, struct task_struct *p, int flags)
 {
-	struct task_struct *curr = rq_curr(rq);
+	struct task_struct *curr = rq_proxy(rq);
 
 	if (p->sched_class == curr->sched_class)
 		curr->sched_class->check_preempt_curr(rq, p, flags);
@@ -2186,7 +2186,7 @@ void check_preempt_curr(struct rq *rq, struct task_struct *p, int flags)
 	 * A queue event has occurred, and we're going to schedule.  In
 	 * this case, we can save a useless back to back clock update.
 	 */
-	if (task_on_rq_queued(curr) && test_tsk_need_resched(curr))
+	if (task_on_rq_queued(curr) && test_tsk_need_resched(rq_curr(rq)))
 		rq_clock_skip_update(rq);
 }
 
@@ -2576,7 +2576,7 @@ __do_set_cpus_allowed(struct task_struct *p, struct affinity_context *ctx)
 		lockdep_assert_held(&p->pi_lock);
 
 	queued = task_on_rq_queued(p);
-	running = task_current(rq, p);
+	running = task_current_proxy(rq, p);
 
 	if (queued) {
 		/*
@@ -5498,7 +5498,7 @@ unsigned long long task_sched_runtime(struct task_struct *p)
 	 * project cycles that may never be accounted to this
 	 * thread, breaking clock_gettime().
 	 */
-	if (task_current(rq, p) && task_on_rq_queued(p)) {
+	if (task_current_proxy(rq, p) && task_on_rq_queued(p)) {
 		prefetch_curr_exec_start(p);
 		update_rq_clock(rq);
 		p->sched_class->update_curr(rq);
@@ -5566,7 +5566,8 @@ void scheduler_tick(void)
 {
 	int cpu = smp_processor_id();
 	struct rq *rq = cpu_rq(cpu);
-	struct task_struct *curr = rq_curr(rq);
+	/* accounting goes to the proxy task */
+	struct task_struct *curr = rq_proxy(rq);
 	struct rq_flags rf;
 	unsigned long thermal_pressure;
 	u64 resched_latency;
@@ -5663,6 +5664,13 @@ static void sched_tick_remote(struct work_struct *work)
 	if (cpu_is_offline(cpu))
 		goto out_unlock;
 
+	/*
+	 * XXX don't we need to account to rq->proxy?
+	 * Maybe, since this is a remote tick for full dynticks mode, we are
+	 * always sure that there is no proxy (only a single task is running.
+	 */
+	SCHED_WARN_ON(rq_curr(rq) != rq_proxy(rq));
+
 	update_rq_clock(rq);
 
 	if (!is_idle_task(curr)) {
@@ -6586,6 +6594,7 @@ static void __sched notrace __schedule(unsigned int sched_mode)
 	}
 
 	next = pick_next_task(rq, prev, &rf);
+	rq_set_proxy(rq, next);
 	clear_tsk_need_resched(prev);
 	clear_preempt_need_resched();
 #ifdef CONFIG_SCHED_DEBUG
@@ -7052,7 +7061,10 @@ void rt_mutex_setprio(struct task_struct *p, struct task_struct *pi_task)
 
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
@@ -7140,7 +7152,10 @@ void set_user_nice(struct task_struct *p, long nice)
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
@@ -7704,7 +7719,10 @@ static int __sched_setscheduler(struct task_struct *p,
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
@@ -9156,6 +9174,7 @@ void __init init_idle(struct task_struct *idle, int cpu)
 	rcu_read_unlock();
 
 	rq->idle = idle;
+	rq_set_proxy(rq, idle);
 	rq_set_curr(rq, idle);
 	idle->on_rq = TASK_ON_RQ_QUEUED;
 #ifdef CONFIG_SMP
@@ -9258,7 +9277,7 @@ void sched_setnuma(struct task_struct *p, int nid)
 
 	rq = task_rq_lock(p, &rf);
 	queued = task_on_rq_queued(p);
-	running = task_current(rq, p);
+	running = task_current_proxy(rq, p);
 
 	if (queued)
 		dequeue_task(rq, p, DEQUEUE_SAVE);
@@ -10370,7 +10389,7 @@ void sched_move_task(struct task_struct *tsk)
 	rq = task_rq_lock(tsk, &rf);
 	update_rq_clock(rq);
 
-	running = task_current(rq, tsk);
+	running = task_current_proxy(rq, tsk);
 	queued = task_on_rq_queued(tsk);
 
 	if (queued)
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 4e3acc76708f..6ec40f90317c 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1179,7 +1179,7 @@ static enum hrtimer_restart dl_task_timer(struct hrtimer *timer)
 #endif
 
 	enqueue_task_dl(rq, p, ENQUEUE_REPLENISH);
-	if (dl_task(rq_curr(rq)))
+	if (dl_task(rq_proxy(rq)))
 		check_preempt_curr_dl(rq, p, 0);
 	else
 		resched_curr(rq);
@@ -1306,7 +1306,7 @@ static u64 grub_reclaim(u64 delta, struct rq *rq, struct sched_dl_entity *dl_se)
  */
 static void update_curr_dl(struct rq *rq)
 {
-	struct task_struct *curr = rq_curr(rq);
+	struct task_struct *curr = rq_proxy(rq);
 	struct sched_dl_entity *dl_se = &curr->dl;
 	s64 delta_exec, scaled_delta_exec;
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
 	curr = rq_curr_unlocked(rq); /* XXX jstultz: using rcu_dereference intead of READ_ONCE */
+	proxy = rq_proxy_unlocked(rq);
 
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
@@ -1905,7 +1906,7 @@ static void check_preempt_equal_dl(struct rq *rq, struct task_struct *p)
 	 * let's hope p can move out.
 	 */
 	if (rq_curr(rq)->nr_cpus_allowed == 1 ||
-	    !cpudl_find(&rq->rd->cpudl, rq_curr(rq), NULL))
+	    !cpudl_find(&rq->rd->cpudl, rq_proxy(rq), NULL))
 		return;
 
 	/*
@@ -1944,7 +1945,7 @@ static int balance_dl(struct rq *rq, struct task_struct *p, struct rq_flags *rf)
 static void check_preempt_curr_dl(struct rq *rq, struct task_struct *p,
 				  int flags)
 {
-	if (dl_entity_preempt(&p->dl, &rq_curr(rq)->dl)) {
+	if (dl_entity_preempt(&p->dl, &rq_proxy(rq)->dl)) {
 		resched_curr(rq);
 		return;
 	}
@@ -1954,7 +1955,7 @@ static void check_preempt_curr_dl(struct rq *rq, struct task_struct *p,
 	 * In the unlikely case current and p have the same deadline
 	 * let us try to decide what's the best thing to do...
 	 */
-	if ((p->dl.deadline == rq_curr(rq)->dl.deadline) &&
+	if ((p->dl.deadline == rq_proxy(rq)->dl.deadline) &&
 	    !test_tsk_need_resched(rq_curr(rq)))
 		check_preempt_equal_dl(rq, p);
 #endif /* CONFIG_SMP */
@@ -1989,7 +1990,7 @@ static void set_next_task_dl(struct rq *rq, struct task_struct *p, bool first)
 	if (hrtick_enabled_dl(rq))
 		start_hrtick_dl(rq, p);
 
-	if (rq_curr(rq)->sched_class != &dl_sched_class)
+	if (rq_proxy(rq)->sched_class != &dl_sched_class)
 		update_dl_rq_load_avg(rq_clock_pelt(rq), rq, 0);
 
 	deadline_queue_push_tasks(rq);
@@ -2305,8 +2306,8 @@ static int push_dl_task(struct rq *rq)
 	 * can move away, it makes sense to just reschedule
 	 * without going further in pushing next_task.
 	 */
-	if (dl_task(rq_curr(rq)) &&
-	    dl_time_before(next_task->dl.deadline, rq_curr(rq)->dl.deadline) &&
+	if (dl_task(rq_proxy(rq)) &&
+	    dl_time_before(next_task->dl.deadline, rq_proxy(rq)->dl.deadline) &&
 	    rq_curr(rq)->nr_cpus_allowed > 1) {
 		resched_curr(rq);
 		return 0;
@@ -2322,6 +2323,7 @@ static int push_dl_task(struct rq *rq)
 	get_task_struct(next_task);
 
 	/* Will lock the rq it'll find */
+	/* XXX connoro: update find_lock_later_rq() for split context? */
 	later_rq = find_lock_later_rq(next_task, rq);
 	if (!later_rq) {
 		struct task_struct *task;
@@ -2431,7 +2433,7 @@ static void pull_dl_task(struct rq *this_rq)
 			 * deadline than the current task of its runqueue.
 			 */
 			if (dl_time_before(p->dl.deadline,
-					   rq_curr(src_rq)->dl.deadline))
+					   rq_proxy(src_rq)->dl.deadline))
 				goto skip;
 
 			if (is_migration_disabled(p)) {
@@ -2470,9 +2472,9 @@ static void task_woken_dl(struct rq *rq, struct task_struct *p)
 	if (!task_on_cpu(rq, p) &&
 	    !test_tsk_need_resched(rq_curr(rq)) &&
 	    p->nr_cpus_allowed > 1 &&
-	    dl_task(rq_curr(rq)) &&
+	    dl_task(rq_proxy(rq)) &&
 	    (rq_curr(rq)->nr_cpus_allowed < 2 ||
-	     !dl_entity_preempt(&p->dl, &rq_curr(rq)->dl))) {
+	     !dl_entity_preempt(&p->dl, &rq_proxy(rq)->dl))) {
 		push_dl_tasks(rq);
 	}
 }
@@ -2635,12 +2637,12 @@ static void switched_to_dl(struct rq *rq, struct task_struct *p)
 		return;
 	}
 
-	if (rq_curr(rq) != p) {
+	if (rq_proxy(rq) != p) {
 #ifdef CONFIG_SMP
 		if (p->nr_cpus_allowed > 1 && rq->dl.overloaded)
 			deadline_queue_push_tasks(rq);
 #endif
-		if (dl_task(rq_curr(rq)))
+		if (dl_task(rq_proxy(rq)))
 			check_preempt_curr_dl(rq, p, 0);
 		else
 			resched_curr(rq);
@@ -2669,7 +2671,7 @@ static void prio_changed_dl(struct rq *rq, struct task_struct *p,
 	if (!rq->dl.overloaded)
 		deadline_queue_pull_task(rq);
 
-	if (task_current(rq, p)) {
+	if (task_current_proxy(rq, p)) {
 		/*
 		 * If we now have a earlier deadline task than p,
 		 * then reschedule, provided p is still on this
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 8b35dfc0c442..1471519b95c5 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -919,7 +919,7 @@ static s64 update_curr_se(struct rq *rq, struct sched_entity *curr)
  */
 s64 update_curr_common(struct rq *rq)
 {
-	struct task_struct *curr = rq_curr(rq);
+	struct task_struct *curr = rq_proxy(rq);
 	s64 delta_exec;
 
 	delta_exec = update_curr_se(rq, &curr->se);
@@ -964,7 +964,7 @@ static void update_curr(struct cfs_rq *cfs_rq)
 
 static void update_curr_fair(struct rq *rq)
 {
-	update_curr(cfs_rq_of(&rq_curr(rq)->se));
+	update_curr(cfs_rq_of(&rq_proxy(rq)->se));
 }
 
 static inline void
@@ -6133,7 +6133,7 @@ static void hrtick_start_fair(struct rq *rq, struct task_struct *p)
 		s64 delta = slice - ran;
 
 		if (delta < 0) {
-			if (task_current(rq, p))
+			if (task_current_proxy(rq, p))
 				resched_curr(rq);
 			return;
 		}
@@ -6148,7 +6148,7 @@ static void hrtick_start_fair(struct rq *rq, struct task_struct *p)
  */
 static void hrtick_update(struct rq *rq)
 {
-	struct task_struct *curr = rq_curr(rq);
+	struct task_struct *curr = rq_proxy(rq);
 
 	if (!hrtick_enabled_fair(rq) || curr->sched_class != &fair_sched_class)
 		return;
@@ -7788,7 +7788,7 @@ static void set_skip_buddy(struct sched_entity *se)
  */
 static void check_preempt_wakeup(struct rq *rq, struct task_struct *p, int wake_flags)
 {
-	struct task_struct *curr = rq_curr(rq);
+	struct task_struct *curr = rq_proxy(rq);
 	struct sched_entity *se = &curr->se, *pse = &p->se;
 	struct cfs_rq *cfs_rq = task_cfs_rq(curr);
 	int scale = cfs_rq->nr_running >= sched_nr_latency;
@@ -7822,7 +7822,7 @@ static void check_preempt_wakeup(struct rq *rq, struct task_struct *p, int wake_
 	 * prevents us from potentially nominating it as a false LAST_BUDDY
 	 * below.
 	 */
-	if (test_tsk_need_resched(curr))
+	if (test_tsk_need_resched(rq_curr(rq)))
 		return;
 
 	/* Idle tasks are by definition preempted by non-idle tasks. */
@@ -8821,7 +8821,7 @@ static bool __update_blocked_others(struct rq *rq, bool *done)
 	 * update_load_avg() can call cpufreq_update_util(). Make sure that RT,
 	 * DL and IRQ signals have been updated before updating CFS.
 	 */
-	curr_class = rq_curr(rq)->sched_class;
+	curr_class = rq_proxy(rq)->sched_class;
 
 	thermal_pressure = arch_scale_thermal_pressure(cpu_of(rq));
 
@@ -11984,6 +11984,10 @@ static void task_tick_fair(struct rq *rq, struct task_struct *curr, int queued)
 		entity_tick(cfs_rq, se, queued);
 	}
 
+	/*
+	 * XXX need to use execution context (rq->curr) for task_tick_numa and
+	 * update_misfit_status?
+	 */
 	if (static_branch_unlikely(&sched_numa_balancing))
 		task_tick_numa(rq, curr);
 
@@ -12047,7 +12051,7 @@ prio_changed_fair(struct rq *rq, struct task_struct *p, int oldprio)
 	 * our priority decreased, or if we are not currently running on
 	 * this runqueue and our priority is higher than the current's
 	 */
-	if (task_current(rq, p)) {
+	if (task_current_proxy(rq, p)) {
 		if (p->prio > oldprio)
 			resched_curr(rq);
 	} else
@@ -12192,7 +12196,7 @@ static void switched_to_fair(struct rq *rq, struct task_struct *p)
 		 * kick off the schedule if running, otherwise just see
 		 * if we can still preempt the current task.
 		 */
-		if (task_current(rq, p))
+		if (task_current_proxy(rq, p))
 			resched_curr(rq);
 		else
 			check_preempt_curr(rq, p, 0);
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 91c992230aba..03e5d8fa67aa 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -574,7 +574,7 @@ static void dequeue_rt_entity(struct sched_rt_entity *rt_se, unsigned int flags)
 
 static void sched_rt_rq_enqueue(struct rt_rq *rt_rq)
 {
-	struct task_struct *curr = rq_curr(rq_of_rt_rq(rt_rq));
+	struct task_struct *curr = rq_proxy(rq_of_rt_rq(rt_rq));
 	struct rq *rq = rq_of_rt_rq(rt_rq);
 	struct sched_rt_entity *rt_se;
 
@@ -1044,7 +1044,7 @@ static int sched_rt_runtime_exceeded(struct rt_rq *rt_rq)
  */
 static void update_curr_rt(struct rq *rq)
 {
-	struct task_struct *curr = rq_curr(rq);
+	struct task_struct *curr = rq_proxy(rq);
 	struct sched_rt_entity *rt_se = &curr->rt;
 	s64 delta_exec;
 
@@ -1591,7 +1591,7 @@ static int find_lowest_rq(struct task_struct *task);
 static int
 select_task_rq_rt(struct task_struct *p, int cpu, int flags)
 {
-	struct task_struct *curr;
+	struct task_struct *curr, *proxy;
 	struct rq *rq;
 	bool test;
 
@@ -1603,6 +1603,7 @@ select_task_rq_rt(struct task_struct *p, int cpu, int flags)
 
 	rcu_read_lock();
 	curr = rq_curr_unlocked(rq); /* XXX jstultz: using rcu_dereference intead of READ_ONCE */
+	proxy = rq_proxy_unlocked(rq);
 
 	/*
 	 * If the current task on @p's runqueue is an RT task, then
@@ -1631,8 +1632,8 @@ select_task_rq_rt(struct task_struct *p, int cpu, int flags)
 	 * systems like big.LITTLE.
 	 */
 	test = curr &&
-	       unlikely(rt_task(curr)) &&
-	       (curr->nr_cpus_allowed < 2 || curr->prio <= p->prio);
+	       unlikely(rt_task(proxy)) &&
+	       (curr->nr_cpus_allowed < 2 || proxy->prio <= p->prio);
 
 	if (test || !rt_task_fits_capacity(p, cpu)) {
 		int target = find_lowest_rq(p);
@@ -1662,12 +1663,12 @@ select_task_rq_rt(struct task_struct *p, int cpu, int flags)
 
 static void check_preempt_equal_prio(struct rq *rq, struct task_struct *p)
 {
-	/*
-	 * Current can't be migrated, useless to reschedule,
-	 * let's hope p can move out.
+	/* XXX connoro: need to revise cpupri_find() to reflect the split
+	 * context since it should look at rq->proxy for priority but rq->curr
+	 * for affinity.
 	 */
 	if (rq_curr(rq)->nr_cpus_allowed == 1 ||
-	    !cpupri_find(&rq->rd->cpupri, rq_curr(rq), NULL))
+	    !cpupri_find(&rq->rd->cpupri, rq_proxy(rq), NULL))
 		return;
 
 	/*
@@ -1710,7 +1711,9 @@ static int balance_rt(struct rq *rq, struct task_struct *p, struct rq_flags *rf)
  */
 static void check_preempt_curr_rt(struct rq *rq, struct task_struct *p, int flags)
 {
-	if (p->prio < rq_curr(rq)->prio) {
+	struct task_struct *curr = rq_proxy(rq);
+
+	if (p->prio < curr->prio) {
 		resched_curr(rq);
 		return;
 	}
@@ -1728,7 +1731,7 @@ static void check_preempt_curr_rt(struct rq *rq, struct task_struct *p, int flag
 	 * to move current somewhere else, making room for our non-migratable
 	 * task.
 	 */
-	if (p->prio == rq_curr(rq)->prio && !test_tsk_need_resched(rq_curr(rq)))
+	if (p->prio == curr->prio && !test_tsk_need_resched(rq_curr(rq)))
 		check_preempt_equal_prio(rq, p);
 #endif
 }
@@ -1753,7 +1756,7 @@ static inline void set_next_task_rt(struct rq *rq, struct task_struct *p, bool f
 	 * utilization. We only care of the case where we start to schedule a
 	 * rt task
 	 */
-	if (rq_curr(rq)->sched_class != &rt_sched_class)
+	if (rq_proxy(rq)->sched_class != &rt_sched_class)
 		update_rt_rq_load_avg(rq_clock_pelt(rq), rq, 0);
 
 	rt_queue_push_tasks(rq);
@@ -2029,7 +2032,7 @@ static struct task_struct *pick_next_pushable_task(struct rq *rq)
 			      struct task_struct, pushable_tasks);
 
 	BUG_ON(rq->cpu != task_cpu(p));
-	BUG_ON(task_current(rq, p));
+	BUG_ON(task_current(rq, p) || task_current_proxy(rq, p));
 	BUG_ON(p->nr_cpus_allowed <= 1);
 
 	BUG_ON(!task_on_rq_queued(p));
@@ -2062,7 +2065,7 @@ static int push_rt_task(struct rq *rq, bool pull)
 	 * higher priority than current. If that's the case
 	 * just reschedule current.
 	 */
-	if (unlikely(next_task->prio < rq_curr(rq)->prio)) {
+	if (unlikely(next_task->prio < rq_proxy(rq)->prio)) {
 		resched_curr(rq);
 		return 0;
 	}
@@ -2083,6 +2086,16 @@ static int push_rt_task(struct rq *rq, bool pull)
 		 * Note that the stoppers are masqueraded as SCHED_FIFO
 		 * (cf. sched_set_stop_task()), so we can't rely on rt_task().
 		 */
+		/*
+		 * XXX connoro: seems like what we actually want here might be:
+		 * 1) Enforce that rq->proxy must be RT
+		 * 2) Revise find_lowest_rq() to handle split context, searching
+		 *    for an rq that can accommodate rq->proxy's prio and
+		 *    rq->curr's affinity
+		 * 3) Send the whole chain to the new rq in push_cpu_stop()?
+		 * If #3 is needed, might be best to make a separate patch with
+		 * all the "chain-level load balancing" changes.
+		 */
 		if (rq_curr(rq)->sched_class != &rt_sched_class)
 			return 0;
 
@@ -2114,6 +2127,12 @@ static int push_rt_task(struct rq *rq, bool pull)
 	get_task_struct(next_task);
 
 	/* find_lock_lowest_rq locks the rq if found */
+	/*
+	 * XXX connoro: find_lock_lowest_rq() likely also needs split context
+	 * support. This also needs to include something like an exec_ctx=NULL
+	 * case for when we push a blocked task whose lock owner is not on
+	 * this rq.
+	 */
 	lowest_rq = find_lock_lowest_rq(next_task, rq);
 	if (!lowest_rq) {
 		struct task_struct *task;
@@ -2415,7 +2434,7 @@ static void pull_rt_task(struct rq *this_rq)
 			 * p if it is lower in priority than the
 			 * current task on the run queue
 			 */
-			if (p->prio < rq_curr(src_rq)->prio)
+			if (p->prio < rq_proxy(src_rq)->prio)
 				goto skip;
 
 			if (is_migration_disabled(p)) {
@@ -2457,9 +2476,9 @@ static void task_woken_rt(struct rq *rq, struct task_struct *p)
 	bool need_to_push = !task_on_cpu(rq, p) &&
 			    !test_tsk_need_resched(rq_curr(rq)) &&
 			    p->nr_cpus_allowed > 1 &&
-			    (dl_task(rq_curr(rq)) || rt_task(rq_curr(rq))) &&
+			    (dl_task(rq_proxy(rq)) || rt_task(rq_proxy(rq))) &&
 			    (rq_curr(rq)->nr_cpus_allowed < 2 ||
-			     rq_curr(rq)->prio <= p->prio);
+			     rq_proxy(rq)->prio <= p->prio);
 
 	if (need_to_push)
 		push_rt_tasks(rq);
@@ -2543,7 +2562,7 @@ static void switched_to_rt(struct rq *rq, struct task_struct *p)
 		if (p->nr_cpus_allowed > 1 && rq->rt.overloaded)
 			rt_queue_push_tasks(rq);
 #endif /* CONFIG_SMP */
-		if (p->prio < rq_curr(rq)->prio && cpu_online(cpu_of(rq)))
+		if (p->prio < rq_proxy(rq)->prio && cpu_online(cpu_of(rq)))
 			resched_curr(rq);
 	}
 }
@@ -2558,7 +2577,7 @@ prio_changed_rt(struct rq *rq, struct task_struct *p, int oldprio)
 	if (!task_on_rq_queued(p))
 		return;
 
-	if (task_current(rq, p)) {
+	if (task_current_proxy(rq, p)) {
 #ifdef CONFIG_SMP
 		/*
 		 * If our priority decreases while running, we
@@ -2584,7 +2603,7 @@ prio_changed_rt(struct rq *rq, struct task_struct *p, int oldprio)
 		 * greater than the current running task
 		 * then reschedule.
 		 */
-		if (p->prio < rq_curr(rq)->prio)
+		if (p->prio < rq_proxy(rq)->prio)
 			resched_curr(rq);
 	}
 }
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 00f73ca4c618..84e49c2530b0 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1008,7 +1008,17 @@ struct rq {
 	 */
 	unsigned int		nr_uninterruptible;
 
-	struct task_struct __rcu	*curr_exec;
+	/*
+	 * XXX jstultz: Personally, I feel like these should be switched.
+	 * Where rq_curr() returns the selected scheduler context, and
+	 * but rq_proxy() returns the execution context we're going to
+	 * run on behalf of the selected task. But for now keeping it
+	 * the same.
+	 */
+	struct task_struct __rcu	*curr_exec; /* Execution context */
+#ifdef CONFIG_PROXY_EXEC
+	struct task_struct __rcu	*curr_sched; /* Scheduling context (policy) */
+#endif
 	struct task_struct	*idle;
 	struct task_struct	*stop;
 	unsigned long		next_balance;
@@ -1226,6 +1236,38 @@ static inline void rq_set_curr_rcu_init(struct rq *rq, struct task_struct *task)
 	RCU_INIT_POINTER(rq->curr_exec, task);
 }
 
+#ifdef CONFIG_PROXY_EXEC
+static inline struct task_struct *rq_proxy(struct rq *rq)
+{
+	return rq->curr_sched;
+}
+
+static inline struct task_struct *rq_proxy_unlocked(struct rq *rq)
+{
+	return rcu_dereference(rq->curr_sched);
+}
+
+static inline void rq_set_proxy(struct rq *rq, struct task_struct *t)
+{
+	rcu_assign_pointer(rq->curr_sched, t);
+}
+#else
+static inline struct task_struct *rq_proxy(struct rq *rq)
+{
+	return rq->curr_exec;
+}
+
+static inline struct task_struct *rq_proxy_unlocked(struct rq *rq)
+{
+	return rcu_dereference(rq->curr_exec);
+}
+
+static inline void rq_set_proxy(struct rq *rq, struct task_struct *t)
+{
+	/* Do nothing */
+}
+#endif
+
 #define cpu_rq(cpu)		(&per_cpu(runqueues, (cpu)))
 #define this_rq()		this_cpu_ptr(&runqueues)
 #define task_rq(p)		cpu_rq(task_cpu(p))
@@ -2098,11 +2140,25 @@ static inline u64 global_rt_runtime(void)
 	return (u64)sysctl_sched_rt_runtime * NSEC_PER_USEC;
 }
 
+/*
+ * Is p the current execution context?
+ */
 static inline int task_current(struct rq *rq, struct task_struct *p)
 {
 	return rq_curr(rq) == p;
 }
 
+/*
+ * Is p the current scheduling context?
+ *
+ * Note that it might be the current execution context at the same time if
+ * rq->curr == rq->proxy == p.
+ */
+static inline int task_current_proxy(struct rq *rq, struct task_struct *p)
+{
+	return rq_proxy(rq) == p;
+}
+
 static inline int task_on_cpu(struct rq *rq, struct task_struct *p)
 {
 #ifdef CONFIG_SMP
@@ -2260,7 +2316,7 @@ struct sched_class {
 
 static inline void put_prev_task(struct rq *rq, struct task_struct *prev)
 {
-	WARN_ON_ONCE(rq_curr(rq) != prev);
+	WARN_ON_ONCE(rq_proxy(rq) != prev);
 	prev->sched_class->put_prev_task(rq, prev);
 }
 
@@ -2341,6 +2397,15 @@ extern void set_cpus_allowed_common(struct task_struct *p, struct affinity_conte
 
 static inline struct task_struct *get_push_task(struct rq *rq)
 {
+	/*
+	 * XXX connoro: should this be rq->proxy? When rq->curr != rq->proxy,
+	 * pushing rq->curr alone means it stops inheriting. Perhaps returning
+	 * rq->proxy and pushing the entire chain would be correct? OTOH if we
+	 * are guaranteed that rq->proxy is the highest prio task on the rq when
+	 * get_push_task() is called, then proxy() will migrate the rest of the
+	 * chain during the __schedule() call immediately after rq->curr is
+	 * pushed.
+	 */
 	struct task_struct *p = rq_curr(rq);
 
 	lockdep_assert_rq_held(rq);
-- 
2.40.0.rc1.284.g88254d51c5-goog

