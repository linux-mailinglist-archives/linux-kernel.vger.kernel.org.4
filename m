Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8F536DD0E9
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 06:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbjDKE0S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 00:26:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbjDKE0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 00:26:02 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D787A3595
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 21:25:35 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id 98e67ed59e1d1-2467aa31e77so455860a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 21:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1681187135; x=1683779135;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kLVCvGDgyolH8XsJyVtUp0s6XASmsJpCWxd7zmCGgc0=;
        b=dEk/4j5HijfXP5QDCl6VOZfe699/8vSmK6ziRbuJnB8C2H03QUcCGousEi+Fkb1K6R
         wCquTObCE3IO2NNck8om6jX8nkxy5G+Z9oSXzJdwdSrBPAE6yGJ2Nf0Ttuns5UNQGY/M
         LRGd0/CPyEFCThogppiZWbGddnprxF0Mu1DB7tFRI7Y8sIsLv7GGWCjFsm4ecVeHxbn9
         0NIlXEq/T4PSvrF/+3TeZ7Eyi9+xhOQeEOC0FgwKHhB5uyAzvBFBYlC48x36q5fkTH5o
         ljcGZ15yQNLvZjo0lIx3GpD/UZEjS9LmtKdnnNrcFNHSxT3H7dla7OTZ4T2ftdJu+PXh
         4l4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681187135; x=1683779135;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kLVCvGDgyolH8XsJyVtUp0s6XASmsJpCWxd7zmCGgc0=;
        b=MCqVmYpX3zO7ffGEW7Zx8DlsX9NqVy5zsgXDL4zL4fFdo3I1PUFKZMLqmPzKpLiZMn
         mpi7mLTZPSsdXgdJop+qQhfIGn4CLWLh7NFjVnIwzOiWxX1KkzXpeazZdCvugnT+/Dda
         lfUCD5jZhPodUWG4SI3h6uBTVsRBxZxz3gd+wjbTvf89lcgCAxYaY4zbaqmTpJUJQi6D
         +40NikUahPnaX2feVuT4AvRzjJ4Ng/Wjc1Vu6+TXU4wIy+xoIG03O+pUl8XqR3UWP31V
         IDFFIFuqr1riJD9XTPFufMxcu8k4kDF4x6AJwI9kKJilv60UQmM8d8ZnN6p1WfgjnQ9a
         XlRQ==
X-Gm-Message-State: AAQBX9eRyyQA8qbqUY4UoHb06WBJXkuum5z2HgbUZor8mGnEmPoTws1p
        KdCmwJQI/gOLQh5mhdV2MhmN9QJdGFYvr5eHqdbXvhmfR+SAeFR28ai1+9sy26j4XhBHhkkoDNe
        6jMfv4xpcZV2uzNZf7+klfXF2NXOsKVlqjrqq2AmrOHJUPM4n1rL5yGh//cz3ne8sTDsM2GE=
X-Google-Smtp-Source: AKy350abeXnDn1A1Yw8twfv2OjbJ5Dns4k1e6QFQaVRCIA0Z86uE6IrNLQrU8tO9bYDBfzbsDnadIRz0imZ7
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a05:6a00:190c:b0:62e:1972:fab5 with SMTP
 id y12-20020a056a00190c00b0062e1972fab5mr4521538pfi.4.1681187134570; Mon, 10
 Apr 2023 21:25:34 -0700 (PDT)
Date:   Tue, 11 Apr 2023 04:25:06 +0000
In-Reply-To: <20230411042511.1606592-1-jstultz@google.com>
Mime-Version: 1.0
References: <20230411042511.1606592-1-jstultz@google.com>
X-Mailer: git-send-email 2.40.0.577.gac1e443424-goog
Message-ID: <20230411042511.1606592-10-jstultz@google.com>
Subject: [PATCH v3 09/14] sched: Split scheduler execution context
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

Lets define the scheduling context as all the scheduler state in
task_struct and the execution context as all state required to run the
task.

Currently both are intertwined in task_struct. We want to logically
split these such that we can run the execution context of one task
with the scheduling context of another.

To this purpose introduce rq_selected() to point to the task_struct
used for scheduler state and preserve rq_curr() to denote the execution
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
v3:
* Tweaked wrapper names
* Swapped proxy for selected for clarity
---
 kernel/sched/core.c     | 41 +++++++++++++++++++--------
 kernel/sched/deadline.c | 36 +++++++++++++-----------
 kernel/sched/fair.c     | 22 +++++++++------
 kernel/sched/rt.c       | 61 ++++++++++++++++++++++++++--------------
 kernel/sched/sched.h    | 62 +++++++++++++++++++++++++++++++++++++++--
 5 files changed, 162 insertions(+), 60 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 969256189da0..a9cf8397c601 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -773,7 +773,7 @@ static enum hrtimer_restart hrtick(struct hrtimer *timer)
 
 	rq_lock(rq, &rf);
 	update_rq_clock(rq);
-	rq_curr(rq)->sched_class->task_tick(rq, rq_curr(rq), 1);
+	rq_selected(rq)->sched_class->task_tick(rq, rq_selected(rq), 1);
 	rq_unlock(rq, &rf);
 
 	return HRTIMER_NORESTART;
@@ -2178,7 +2178,7 @@ static inline void check_class_changed(struct rq *rq, struct task_struct *p,
 
 void check_preempt_curr(struct rq *rq, struct task_struct *p, int flags)
 {
-	struct task_struct *curr = rq_curr(rq);
+	struct task_struct *curr = rq_selected(rq);
 
 	if (p->sched_class == curr->sched_class)
 		curr->sched_class->check_preempt_curr(rq, p, flags);
@@ -2189,7 +2189,7 @@ void check_preempt_curr(struct rq *rq, struct task_struct *p, int flags)
 	 * A queue event has occurred, and we're going to schedule.  In
 	 * this case, we can save a useless back to back clock update.
 	 */
-	if (task_on_rq_queued(curr) && test_tsk_need_resched(curr))
+	if (task_on_rq_queued(curr) && test_tsk_need_resched(rq_curr(rq)))
 		rq_clock_skip_update(rq);
 }
 
@@ -2579,7 +2579,7 @@ __do_set_cpus_allowed(struct task_struct *p, struct affinity_context *ctx)
 		lockdep_assert_held(&p->pi_lock);
 
 	queued = task_on_rq_queued(p);
-	running = task_current(rq, p);
+	running = task_current_selected(rq, p);
 
 	if (queued) {
 		/*
@@ -5501,7 +5501,7 @@ unsigned long long task_sched_runtime(struct task_struct *p)
 	 * project cycles that may never be accounted to this
 	 * thread, breaking clock_gettime().
 	 */
-	if (task_current(rq, p) && task_on_rq_queued(p)) {
+	if (task_current_selected(rq, p) && task_on_rq_queued(p)) {
 		prefetch_curr_exec_start(p);
 		update_rq_clock(rq);
 		p->sched_class->update_curr(rq);
@@ -5569,7 +5569,8 @@ void scheduler_tick(void)
 {
 	int cpu = smp_processor_id();
 	struct rq *rq = cpu_rq(cpu);
-	struct task_struct *curr = rq_curr(rq);
+	/* accounting goes to the selected task */
+	struct task_struct *curr = rq_selected(rq);
 	struct rq_flags rf;
 	unsigned long thermal_pressure;
 	u64 resched_latency;
@@ -5666,6 +5667,13 @@ static void sched_tick_remote(struct work_struct *work)
 	if (cpu_is_offline(cpu))
 		goto out_unlock;
 
+	/*
+	 * XXX don't we need to account to rq_selected()??
+	 * Maybe, since this is a remote tick for full dynticks mode, we are
+	 * always sure that there is no proxy (only a single task is running).
+	 */
+	SCHED_WARN_ON(rq_curr(rq) != rq_selected(rq));
+
 	update_rq_clock(rq);
 
 	if (!is_idle_task(curr)) {
@@ -6589,6 +6597,7 @@ static void __sched notrace __schedule(unsigned int sched_mode)
 	}
 
 	next = pick_next_task(rq, prev, &rf);
+	rq_set_selected(rq, next);
 	clear_tsk_need_resched(prev);
 	clear_preempt_need_resched();
 #ifdef CONFIG_SCHED_DEBUG
@@ -7055,7 +7064,10 @@ void rt_mutex_setprio(struct task_struct *p, struct task_struct *pi_task)
 
 	prev_class = p->sched_class;
 	queued = task_on_rq_queued(p);
-	running = task_current(rq, p);
+	/*
+	 * XXX how does (proxy exec) mutexes and RT_mutexes work together?!
+	 */
+	running = task_current_selected(rq, p);
 	if (queued)
 		dequeue_task(rq, p, queue_flag);
 	if (running)
@@ -7143,7 +7155,10 @@ void set_user_nice(struct task_struct *p, long nice)
 		goto out_unlock;
 	}
 	queued = task_on_rq_queued(p);
-	running = task_current(rq, p);
+	/*
+	 * XXX see concerns about do_set_cpus_allowed, rt_mutex_prio & Co.
+	 */
+	running = task_current_selected(rq, p);
 	if (queued)
 		dequeue_task(rq, p, DEQUEUE_SAVE | DEQUEUE_NOCLOCK);
 	if (running)
@@ -7707,7 +7722,10 @@ static int __sched_setscheduler(struct task_struct *p,
 	}
 
 	queued = task_on_rq_queued(p);
-	running = task_current(rq, p);
+	/*
+	 * XXX and again, how is this safe w.r.t. proxy exec?
+	 */
+	running = task_current_selected(rq, p);
 	if (queued)
 		dequeue_task(rq, p, queue_flags);
 	if (running)
@@ -9159,6 +9177,7 @@ void __init init_idle(struct task_struct *idle, int cpu)
 	rcu_read_unlock();
 
 	rq->idle = idle;
+	rq_set_selected(rq, idle);
 	rq_set_curr(rq, idle);
 	idle->on_rq = TASK_ON_RQ_QUEUED;
 #ifdef CONFIG_SMP
@@ -9261,7 +9280,7 @@ void sched_setnuma(struct task_struct *p, int nid)
 
 	rq = task_rq_lock(p, &rf);
 	queued = task_on_rq_queued(p);
-	running = task_current(rq, p);
+	running = task_current_selected(rq, p);
 
 	if (queued)
 		dequeue_task(rq, p, DEQUEUE_SAVE);
@@ -10373,7 +10392,7 @@ void sched_move_task(struct task_struct *tsk)
 	rq = task_rq_lock(tsk, &rf);
 	update_rq_clock(rq);
 
-	running = task_current(rq, tsk);
+	running = task_current_selected(rq, tsk);
 	queued = task_on_rq_queued(tsk);
 
 	if (queued)
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index a8296d38b066..63a0564cb1f8 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1179,7 +1179,7 @@ static enum hrtimer_restart dl_task_timer(struct hrtimer *timer)
 #endif
 
 	enqueue_task_dl(rq, p, ENQUEUE_REPLENISH);
-	if (dl_task(rq_curr(rq)))
+	if (dl_task(rq_selected(rq)))
 		check_preempt_curr_dl(rq, p, 0);
 	else
 		resched_curr(rq);
@@ -1306,7 +1306,7 @@ static u64 grub_reclaim(u64 delta, struct rq *rq, struct sched_dl_entity *dl_se)
  */
 static void update_curr_dl(struct rq *rq)
 {
-	struct task_struct *curr = rq_curr(rq);
+	struct task_struct *curr = rq_selected(rq);
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
 	curr = rq_curr_once(rq);
+	proxy = rq_selected_once(rq);
 
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
+	    !cpudl_find(&rq->rd->cpudl, rq_selected(rq), NULL))
 		return;
 
 	/*
@@ -1944,7 +1945,7 @@ static int balance_dl(struct rq *rq, struct task_struct *p, struct rq_flags *rf)
 static void check_preempt_curr_dl(struct rq *rq, struct task_struct *p,
 				  int flags)
 {
-	if (dl_entity_preempt(&p->dl, &rq_curr(rq)->dl)) {
+	if (dl_entity_preempt(&p->dl, &rq_selected(rq)->dl)) {
 		resched_curr(rq);
 		return;
 	}
@@ -1954,7 +1955,7 @@ static void check_preempt_curr_dl(struct rq *rq, struct task_struct *p,
 	 * In the unlikely case current and p have the same deadline
 	 * let us try to decide what's the best thing to do...
 	 */
-	if ((p->dl.deadline == rq_curr(rq)->dl.deadline) &&
+	if ((p->dl.deadline == rq_selected(rq)->dl.deadline) &&
 	    !test_tsk_need_resched(rq_curr(rq)))
 		check_preempt_equal_dl(rq, p);
 #endif /* CONFIG_SMP */
@@ -1989,7 +1990,7 @@ static void set_next_task_dl(struct rq *rq, struct task_struct *p, bool first)
 	if (hrtick_enabled_dl(rq))
 		start_hrtick_dl(rq, p);
 
-	if (rq_curr(rq)->sched_class != &dl_sched_class)
+	if (rq_selected(rq)->sched_class != &dl_sched_class)
 		update_dl_rq_load_avg(rq_clock_pelt(rq), rq, 0);
 
 	deadline_queue_push_tasks(rq);
@@ -2305,8 +2306,8 @@ static int push_dl_task(struct rq *rq)
 	 * can move away, it makes sense to just reschedule
 	 * without going further in pushing next_task.
 	 */
-	if (dl_task(rq_curr(rq)) &&
-	    dl_time_before(next_task->dl.deadline, rq_curr(rq)->dl.deadline) &&
+	if (dl_task(rq_selected(rq)) &&
+	    dl_time_before(next_task->dl.deadline, rq_selected(rq)->dl.deadline) &&
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
+					   rq_selected(src_rq)->dl.deadline))
 				goto skip;
 
 			if (is_migration_disabled(p)) {
@@ -2470,9 +2472,9 @@ static void task_woken_dl(struct rq *rq, struct task_struct *p)
 	if (!task_on_cpu(rq, p) &&
 	    !test_tsk_need_resched(rq_curr(rq)) &&
 	    p->nr_cpus_allowed > 1 &&
-	    dl_task(rq_curr(rq)) &&
+	    dl_task(rq_selected(rq)) &&
 	    (rq_curr(rq)->nr_cpus_allowed < 2 ||
-	     !dl_entity_preempt(&p->dl, &rq_curr(rq)->dl))) {
+	     !dl_entity_preempt(&p->dl, &rq_selected(rq)->dl))) {
 		push_dl_tasks(rq);
 	}
 }
@@ -2635,12 +2637,12 @@ static void switched_to_dl(struct rq *rq, struct task_struct *p)
 		return;
 	}
 
-	if (rq_curr(rq) != p) {
+	if (rq_selected(rq) != p) {
 #ifdef CONFIG_SMP
 		if (p->nr_cpus_allowed > 1 && rq->dl.overloaded)
 			deadline_queue_push_tasks(rq);
 #endif
-		if (dl_task(rq_curr(rq)))
+		if (dl_task(rq_selected(rq)))
 			check_preempt_curr_dl(rq, p, 0);
 		else
 			resched_curr(rq);
@@ -2669,7 +2671,7 @@ static void prio_changed_dl(struct rq *rq, struct task_struct *p,
 	if (!rq->dl.overloaded)
 		deadline_queue_pull_task(rq);
 
-	if (task_current(rq, p)) {
+	if (task_current_selected(rq, p)) {
 		/*
 		 * If we now have a earlier deadline task than p,
 		 * then reschedule, provided p is still on this
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 9295e85ab83b..3f7df45f7402 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -919,7 +919,7 @@ static s64 update_curr_se(struct rq *rq, struct sched_entity *curr)
  */
 s64 update_curr_common(struct rq *rq)
 {
-	struct task_struct *curr = rq_curr(rq);
+	struct task_struct *curr = rq_selected(rq);
 	s64 delta_exec;
 
 	delta_exec = update_curr_se(rq, &curr->se);
@@ -964,7 +964,7 @@ static void update_curr(struct cfs_rq *cfs_rq)
 
 static void update_curr_fair(struct rq *rq)
 {
-	update_curr(cfs_rq_of(&rq_curr(rq)->se));
+	update_curr(cfs_rq_of(&rq_selected(rq)->se));
 }
 
 static inline void
@@ -6169,7 +6169,7 @@ static void hrtick_start_fair(struct rq *rq, struct task_struct *p)
 		s64 delta = slice - ran;
 
 		if (delta < 0) {
-			if (task_current(rq, p))
+			if (task_current_selected(rq, p))
 				resched_curr(rq);
 			return;
 		}
@@ -6184,7 +6184,7 @@ static void hrtick_start_fair(struct rq *rq, struct task_struct *p)
  */
 static void hrtick_update(struct rq *rq)
 {
-	struct task_struct *curr = rq_curr(rq);
+	struct task_struct *curr = rq_selected(rq);
 
 	if (!hrtick_enabled_fair(rq) || curr->sched_class != &fair_sched_class)
 		return;
@@ -7821,7 +7821,7 @@ static void set_skip_buddy(struct sched_entity *se)
  */
 static void check_preempt_wakeup(struct rq *rq, struct task_struct *p, int wake_flags)
 {
-	struct task_struct *curr = rq_curr(rq);
+	struct task_struct *curr = rq_selected(rq);
 	struct sched_entity *se = &curr->se, *pse = &p->se;
 	struct cfs_rq *cfs_rq = task_cfs_rq(curr);
 	int scale = cfs_rq->nr_running >= sched_nr_latency;
@@ -7855,7 +7855,7 @@ static void check_preempt_wakeup(struct rq *rq, struct task_struct *p, int wake_
 	 * prevents us from potentially nominating it as a false LAST_BUDDY
 	 * below.
 	 */
-	if (test_tsk_need_resched(curr))
+	if (test_tsk_need_resched(rq_curr(rq)))
 		return;
 
 	/* Idle tasks are by definition preempted by non-idle tasks. */
@@ -8854,7 +8854,7 @@ static bool __update_blocked_others(struct rq *rq, bool *done)
 	 * update_load_avg() can call cpufreq_update_util(). Make sure that RT,
 	 * DL and IRQ signals have been updated before updating CFS.
 	 */
-	curr_class = rq_curr(rq)->sched_class;
+	curr_class = rq_selected(rq)->sched_class;
 
 	thermal_pressure = arch_scale_thermal_pressure(cpu_of(rq));
 
@@ -12017,6 +12017,10 @@ static void task_tick_fair(struct rq *rq, struct task_struct *curr, int queued)
 		entity_tick(cfs_rq, se, queued);
 	}
 
+	/*
+	 * XXX need to use execution context (rq->curr) for task_tick_numa and
+	 * update_misfit_status?
+	 */
 	if (static_branch_unlikely(&sched_numa_balancing))
 		task_tick_numa(rq, curr);
 
@@ -12080,7 +12084,7 @@ prio_changed_fair(struct rq *rq, struct task_struct *p, int oldprio)
 	 * our priority decreased, or if we are not currently running on
 	 * this runqueue and our priority is higher than the current's
 	 */
-	if (task_current(rq, p)) {
+	if (task_current_selected(rq, p)) {
 		if (p->prio > oldprio)
 			resched_curr(rq);
 	} else
@@ -12225,7 +12229,7 @@ static void switched_to_fair(struct rq *rq, struct task_struct *p)
 		 * kick off the schedule if running, otherwise just see
 		 * if we can still preempt the current task.
 		 */
-		if (task_current(rq, p))
+		if (task_current_selected(rq, p))
 			resched_curr(rq);
 		else
 			check_preempt_curr(rq, p, 0);
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index ecd53be8a6e5..44139d56466e 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -574,7 +574,7 @@ static void dequeue_rt_entity(struct sched_rt_entity *rt_se, unsigned int flags)
 
 static void sched_rt_rq_enqueue(struct rt_rq *rt_rq)
 {
-	struct task_struct *curr = rq_curr(rq_of_rt_rq(rt_rq));
+	struct task_struct *curr = rq_selected(rq_of_rt_rq(rt_rq));
 	struct rq *rq = rq_of_rt_rq(rt_rq);
 	struct sched_rt_entity *rt_se;
 
@@ -1044,7 +1044,7 @@ static int sched_rt_runtime_exceeded(struct rt_rq *rt_rq)
  */
 static void update_curr_rt(struct rq *rq)
 {
-	struct task_struct *curr = rq_curr(rq);
+	struct task_struct *curr = rq_selected(rq);
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
 
@@ -1602,7 +1602,8 @@ select_task_rq_rt(struct task_struct *p, int cpu, int flags)
 	rq = cpu_rq(cpu);
 
 	rcu_read_lock();
-	curr = rq_curr_once(rq);
+	curr = rq_curr_once(rq); /* XXX jstultz: using rcu_dereference intead of READ_ONCE */
+	proxy = rq_selected_once(rq);
 
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
+	 * context since it should look at rq_selected() for priority but
+	 * rq_curr() for affinity.
 	 */
 	if (rq_curr(rq)->nr_cpus_allowed == 1 ||
-	    !cpupri_find(&rq->rd->cpupri, rq_curr(rq), NULL))
+	    !cpupri_find(&rq->rd->cpupri, rq_selected(rq), NULL))
 		return;
 
 	/*
@@ -1710,7 +1711,9 @@ static int balance_rt(struct rq *rq, struct task_struct *p, struct rq_flags *rf)
  */
 static void check_preempt_curr_rt(struct rq *rq, struct task_struct *p, int flags)
 {
-	if (p->prio < rq_curr(rq)->prio) {
+	struct task_struct *curr = rq_selected(rq);
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
+	if (rq_selected(rq)->sched_class != &rt_sched_class)
 		update_rt_rq_load_avg(rq_clock_pelt(rq), rq, 0);
 
 	rt_queue_push_tasks(rq);
@@ -2029,7 +2032,7 @@ static struct task_struct *pick_next_pushable_task(struct rq *rq)
 			      struct task_struct, pushable_tasks);
 
 	BUG_ON(rq->cpu != task_cpu(p));
-	BUG_ON(task_current(rq, p));
+	BUG_ON(task_current(rq, p) || task_current_selected(rq, p));
 	BUG_ON(p->nr_cpus_allowed <= 1);
 
 	BUG_ON(!task_on_rq_queued(p));
@@ -2062,7 +2065,7 @@ static int push_rt_task(struct rq *rq, bool pull)
 	 * higher priority than current. If that's the case
 	 * just reschedule current.
 	 */
-	if (unlikely(next_task->prio < rq_curr(rq)->prio)) {
+	if (unlikely(next_task->prio < rq_selected(rq)->prio)) {
 		resched_curr(rq);
 		return 0;
 	}
@@ -2083,6 +2086,16 @@ static int push_rt_task(struct rq *rq, bool pull)
 		 * Note that the stoppers are masqueraded as SCHED_FIFO
 		 * (cf. sched_set_stop_task()), so we can't rely on rt_task().
 		 */
+		/*
+		 * XXX connoro: seems like what we actually want here might be:
+		 * 1) Enforce that rq_selected() must be RT
+		 * 2) Revise find_lowest_rq() to handle split context, searching
+		 *    for an rq that can accommodate rq_selected()'s prio and
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
+			if (p->prio < rq_selected(src_rq)->prio)
 				goto skip;
 
 			if (is_migration_disabled(p)) {
@@ -2457,9 +2476,9 @@ static void task_woken_rt(struct rq *rq, struct task_struct *p)
 	bool need_to_push = !task_on_cpu(rq, p) &&
 			    !test_tsk_need_resched(rq_curr(rq)) &&
 			    p->nr_cpus_allowed > 1 &&
-			    (dl_task(rq_curr(rq)) || rt_task(rq_curr(rq))) &&
+			    (dl_task(rq_selected(rq)) || rt_task(rq_selected(rq))) &&
 			    (rq_curr(rq)->nr_cpus_allowed < 2 ||
-			     rq_curr(rq)->prio <= p->prio);
+			     rq_selected(rq)->prio <= p->prio);
 
 	if (need_to_push)
 		push_rt_tasks(rq);
@@ -2543,7 +2562,7 @@ static void switched_to_rt(struct rq *rq, struct task_struct *p)
 		if (p->nr_cpus_allowed > 1 && rq->rt.overloaded)
 			rt_queue_push_tasks(rq);
 #endif /* CONFIG_SMP */
-		if (p->prio < rq_curr(rq)->prio && cpu_online(cpu_of(rq)))
+		if (p->prio < rq_selected(rq)->prio && cpu_online(cpu_of(rq)))
 			resched_curr(rq);
 	}
 }
@@ -2558,7 +2577,7 @@ prio_changed_rt(struct rq *rq, struct task_struct *p, int oldprio)
 	if (!task_on_rq_queued(p))
 		return;
 
-	if (task_current(rq, p)) {
+	if (task_current_selected(rq, p)) {
 #ifdef CONFIG_SMP
 		/*
 		 * If our priority decreases while running, we
@@ -2584,7 +2603,7 @@ prio_changed_rt(struct rq *rq, struct task_struct *p, int oldprio)
 		 * greater than the current running task
 		 * then reschedule.
 		 */
-		if (p->prio < rq_curr(rq)->prio)
+		if (p->prio < rq_selected(rq)->prio)
 			resched_curr(rq);
 	}
 }
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 9e6fb54c66be..70cb55ad025d 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1008,7 +1008,10 @@ struct rq {
 	 */
 	unsigned int		nr_uninterruptible;
 
-	struct task_struct __rcu	*curr_exec;
+	struct task_struct __rcu	*curr_exec; /* Execution context */
+#ifdef CONFIG_PROXY_EXEC
+	struct task_struct __rcu	*curr_sched; /* Scheduling context (policy) */
+#endif
 	struct task_struct	*idle;
 	struct task_struct	*stop;
 	unsigned long		next_balance;
@@ -1230,6 +1233,37 @@ static inline void rq_set_curr_rcu_init(struct rq *rq, struct task_struct *task)
 	RCU_INIT_POINTER(rq->curr_exec, task);
 }
 
+#ifdef CONFIG_PROXY_EXEC
+static inline struct task_struct *rq_selected(struct rq *rq)
+{
+	return rq->curr_sched;
+}
+
+static inline struct task_struct *rq_selected_rcu(struct rq *rq)
+{
+	return rcu_dereference(rq->curr_sched);
+}
+
+static inline struct task_struct *rq_selected_once(struct rq *rq)
+{
+	return READ_ONCE(rq->curr_sched);
+}
+
+static inline void rq_set_selected(struct rq *rq, struct task_struct *t)
+{
+	rcu_assign_pointer(rq->curr_sched, t);
+}
+
+#else
+#define rq_selected(x)		(rq_curr(x))
+#define rq_selected_rcu(x)		(rq_curr_rcu(x))
+#define rq_selected_once(x)	(rq_curr_once(x))
+static inline void rq_set_selected(struct rq *rq, struct task_struct *t)
+{
+	/* Do nothing */
+}
+#endif
+
 #define cpu_rq(cpu)		(&per_cpu(runqueues, (cpu)))
 #define this_rq()		this_cpu_ptr(&runqueues)
 #define task_rq(p)		cpu_rq(task_cpu(p))
@@ -2102,11 +2136,25 @@ static inline u64 global_rt_runtime(void)
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
+ * rq_curr() == rq_selected() == p.
+ */
+static inline int task_current_selected(struct rq *rq, struct task_struct *p)
+{
+	return rq_selected(rq) == p;
+}
+
 static inline int task_on_cpu(struct rq *rq, struct task_struct *p)
 {
 #ifdef CONFIG_SMP
@@ -2264,7 +2312,7 @@ struct sched_class {
 
 static inline void put_prev_task(struct rq *rq, struct task_struct *prev)
 {
-	WARN_ON_ONCE(rq_curr(rq) != prev);
+	WARN_ON_ONCE(rq_selected(rq) != prev);
 	prev->sched_class->put_prev_task(rq, prev);
 }
 
@@ -2345,6 +2393,16 @@ extern void set_cpus_allowed_common(struct task_struct *p, struct affinity_conte
 
 static inline struct task_struct *get_push_task(struct rq *rq)
 {
+	/*
+	 * XXX connoro: should this be rq_selected?
+	 * When rq_curr() != rq_selected(), pushing rq_curr() alone means it
+	 * stops inheriting. Perhaps returning rq_selected() and pushing the
+	 * entire chain would be correct? OTOH if we are guaranteed that
+	 * rq_selected() is the highest prio task on the rq when
+	 * get_push_task() is called, then proxy() will migrate the rest of the
+	 * chain during the __schedule() call immediately after rq_curr() is
+	 * pushed.
+	 */
 	struct task_struct *p = rq_curr(rq);
 
 	lockdep_assert_rq_held(rq);
-- 
2.40.0.577.gac1e443424-goog

