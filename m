Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33DC06DD0E7
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 06:26:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbjDKE0O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 00:26:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbjDKEZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 00:25:55 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1851B30E0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 21:25:34 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id pt5-20020a17090b3d0500b0023d3ffe542fso405685pjb.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 21:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1681187133; x=1683779133;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QGs69cFMj2ObD2ALOPqytWsX0S38G4o3J2+SZBj4hsY=;
        b=MKjkNKT/HRktibvKK5zHSxJWnEa9BzEKeztXPmlzrVhdwyFZn4zG66zS6GIs1o/GwH
         XFFiJ8AEaGFDQbkz93h0yJAH2t7YnXw56CV1aIcsKfhSaJST9lrtJM4Cler331pgbwJH
         2y4esmSXiO2NcihAdP6/nIItsCWeq1OiCHkWtjmJ3X4SV7vmEp5MG5YV4iqZBCG93sr9
         W/v+gcYPxWTk7e72m1+q4Kj5ad8EsqwvJmC+xZjQY5Rb2Yyaz/Ak6bYXVO7qEljBpBTK
         ZjsnhDhrUUlcyQInGOCSS1nvFNLtkeVZpXTthIw70wQqg+We/TKQwQSvNsC17+I1f5Tf
         h9wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681187133; x=1683779133;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QGs69cFMj2ObD2ALOPqytWsX0S38G4o3J2+SZBj4hsY=;
        b=asOzRJh3HqPjFiCnE57lX7eiLDFGpW8Qb+YfOPHwIXip6Fzep2TgNb++6ocnlloxmM
         CjZ0L8msn6oZs3rez6p8SdtS7HAjf4sLVDgZMon8DGyPZUv+LP5iMBf+HoSfKCsH3Hxl
         IbyvH8uVAixVQw7aDb9t0LmxFDHMZHXg6NaJUNDNsmrXJEsS7GT9o764UMsxEDTNaV/e
         q4lARTAc1h7AdIBTFVZ460k6vhN6THYJugO8F+5y8RlHozXdpo+MKX0/ypNTzYPpcWWn
         XR3Yk/2VIKCh7x4v4hqGnlHmd7hwaRTJzPBMx0BDwi/O8mXD6ownzLWaSlNSbJomV3sG
         zNfw==
X-Gm-Message-State: AAQBX9fnc6Tody1/CawNGlsyB4O7mDyV1aq1h3jtUx4KrwU5IDYWJI+v
        NrBtPTnqygRBHJerYa+J/G2NIikzsp2CsVL7WCWVYYqkI6/g5nQqtqCEbgxDkwlHGsK0LnCZr9K
        uVuZ+HHQeD6srLtUSc2e/cvQOxHJMUc8pLduRP8ZoKsX6+4LZ4NWA8dlx72YcuM4zVfKTzB8=
X-Google-Smtp-Source: AKy350btluCAZTYX0dd8uuf76sLKo0r+yZOkBE8lmKkQ7zE9n2HVN0u068LNQqi4ADsDCsWLXG23Yc/77QRC
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a17:90a:f98f:b0:246:d7d1:69ff with SMTP id
 cq15-20020a17090af98f00b00246d7d169ffmr499447pjb.1.1681187132868; Mon, 10 Apr
 2023 21:25:32 -0700 (PDT)
Date:   Tue, 11 Apr 2023 04:25:05 +0000
In-Reply-To: <20230411042511.1606592-1-jstultz@google.com>
Mime-Version: 1.0
References: <20230411042511.1606592-1-jstultz@google.com>
X-Mailer: git-send-email 2.40.0.577.gac1e443424-goog
Message-ID: <20230411042511.1606592-9-jstultz@google.com>
Subject: [PATCH v3 08/14] sched: Replace rq->curr access w/ rq_curr(rq)
From:   John Stultz <jstultz@google.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     John Stultz <jstultz@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Qais Yousef <qyousef@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
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
        "Paul E . McKenney" <paulmck@kernel.org>
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

In preparing for proxy-execution changes add a bit of
indirection for reading and writing rq->curr.

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
Signed-off-by: John Stultz <jstultz@google.com>
---
v3:
* Build fixups Reported-by: kernel test robot <lkp@intel.com>
  https://lore.kernel.org/oe-kbuild-all/202303211827.IXnKJ5rO-lkp@intel.com/
* Fix missed rq->curr references in comments
* Tweaked wrapper names
---
 kernel/sched/core.c       | 56 ++++++++++++++++++++-------------------
 kernel/sched/core_sched.c |  2 +-
 kernel/sched/cputime.c    |  4 +--
 kernel/sched/deadline.c   | 50 +++++++++++++++++-----------------
 kernel/sched/debug.c      |  2 +-
 kernel/sched/fair.c       | 25 ++++++++---------
 kernel/sched/idle.c       |  4 +--
 kernel/sched/membarrier.c | 22 +++++++--------
 kernel/sched/pelt.h       |  2 +-
 kernel/sched/rt.c         | 44 +++++++++++++++---------------
 kernel/sched/sched.h      | 46 +++++++++++++++++++++++++++-----
 11 files changed, 147 insertions(+), 110 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 0d18c3969f90..969256189da0 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -257,7 +257,7 @@ void sched_core_dequeue(struct rq *rq, struct task_struct *p, int flags)
 	 * and re-examine whether the core is still in forced idle state.
 	 */
 	if (!(flags & DEQUEUE_SAVE) && rq->nr_running == 1 &&
-	    rq->core->core_forceidle_count && rq->curr == rq->idle)
+	    rq->core->core_forceidle_count && rq_curr(rq) == rq->idle)
 		resched_curr(rq);
 }
 
@@ -703,7 +703,7 @@ static void update_rq_clock_task(struct rq *rq, s64 delta)
 
 	rq->prev_irq_time += irq_delta;
 	delta -= irq_delta;
-	psi_account_irqtime(rq->curr, irq_delta);
+	psi_account_irqtime(rq_curr(rq), irq_delta);
 #endif
 #ifdef CONFIG_PARAVIRT_TIME_ACCOUNTING
 	if (static_key_false((&paravirt_steal_rq_enabled))) {
@@ -773,7 +773,7 @@ static enum hrtimer_restart hrtick(struct hrtimer *timer)
 
 	rq_lock(rq, &rf);
 	update_rq_clock(rq);
-	rq->curr->sched_class->task_tick(rq, rq->curr, 1);
+	rq_curr(rq)->sched_class->task_tick(rq, rq_curr(rq), 1);
 	rq_unlock(rq, &rf);
 
 	return HRTIMER_NORESTART;
@@ -1020,7 +1020,7 @@ void wake_up_q(struct wake_q_head *head)
  */
 void resched_curr(struct rq *rq)
 {
-	struct task_struct *curr = rq->curr;
+	struct task_struct *curr = rq_curr(rq);
 	int cpu;
 
 	lockdep_assert_rq_held(rq);
@@ -2178,16 +2178,18 @@ static inline void check_class_changed(struct rq *rq, struct task_struct *p,
 
 void check_preempt_curr(struct rq *rq, struct task_struct *p, int flags)
 {
-	if (p->sched_class == rq->curr->sched_class)
-		rq->curr->sched_class->check_preempt_curr(rq, p, flags);
-	else if (sched_class_above(p->sched_class, rq->curr->sched_class))
+	struct task_struct *curr = rq_curr(rq);
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
+	if (task_on_rq_queued(curr) && test_tsk_need_resched(curr))
 		rq_clock_skip_update(rq);
 }
 
@@ -3862,11 +3864,11 @@ void wake_up_if_idle(int cpu)
 
 	rcu_read_lock();
 
-	if (!is_idle_task(rcu_dereference(rq->curr)))
+	if (!is_idle_task(rq_curr_rcu(rq)))
 		goto out;
 
 	rq_lock_irqsave(rq, &rf);
-	if (is_idle_task(rq->curr))
+	if (is_idle_task(rq_curr(rq)))
 		resched_curr(rq);
 	/* Else CPU is not idle, do nothing here: */
 	rq_unlock_irqrestore(rq, &rf);
@@ -4391,7 +4393,7 @@ struct task_struct *cpu_curr_snapshot(int cpu)
 	struct task_struct *t;
 
 	smp_mb(); /* Pairing determined by caller's synchronization design. */
-	t = rcu_dereference(cpu_curr(cpu));
+	t = cpu_curr_rcu(cpu);
 	smp_mb(); /* Pairing determined by caller's synchronization design. */
 	return t;
 }
@@ -5200,7 +5202,7 @@ static struct rq *finish_task_switch(struct task_struct *prev)
 	 * kernel thread and not issued an IPI. It is therefore possible to
 	 * schedule between user->kernel->user threads without passing though
 	 * switch_mm(). Membarrier requires a barrier after storing to
-	 * rq->curr, before returning to userspace, so provide them here:
+	 * rq_curr(rq), before returning to userspace, so provide them here:
 	 *
 	 * - a full memory barrier for {PRIVATE,GLOBAL}_EXPEDITED, implicitly
 	 *   provided by mmdrop(),
@@ -5283,7 +5285,7 @@ context_switch(struct rq *rq, struct task_struct *prev,
 		membarrier_switch_mm(rq, prev->active_mm, next->mm);
 		/*
 		 * sys_membarrier() requires an smp_mb() between setting
-		 * rq->curr / membarrier_switch_mm() and returning to userspace.
+		 * rq_curr(rq) / membarrier_switch_mm() and returning to userspace.
 		 *
 		 * The below provides this either through switch_mm(), or in
 		 * case 'prev->active_mm == next->mm' through
@@ -5567,7 +5569,7 @@ void scheduler_tick(void)
 {
 	int cpu = smp_processor_id();
 	struct rq *rq = cpu_rq(cpu);
-	struct task_struct *curr = rq->curr;
+	struct task_struct *curr = rq_curr(rq);
 	struct rq_flags rf;
 	unsigned long thermal_pressure;
 	u64 resched_latency;
@@ -5660,7 +5662,7 @@ static void sched_tick_remote(struct work_struct *work)
 		goto out_requeue;
 
 	rq_lock_irq(rq, &rf);
-	curr = rq->curr;
+	curr = rq_curr(rq);
 	if (cpu_is_offline(cpu))
 		goto out_unlock;
 
@@ -6204,7 +6206,7 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 		/* Did we break L1TF mitigation requirements? */
 		WARN_ON_ONCE(!cookie_match(next, rq_i->core_pick));
 
-		if (rq_i->curr == rq_i->core_pick) {
+		if (rq_curr(rq_i) == rq_i->core_pick) {
 			rq_i->core_pick = NULL;
 			continue;
 		}
@@ -6235,7 +6237,7 @@ static bool try_steal_cookie(int this, int that)
 	if (!cookie)
 		goto unlock;
 
-	if (dst->curr != dst->idle)
+	if (rq_curr(dst) != dst->idle)
 		goto unlock;
 
 	p = sched_core_find(src, cookie);
@@ -6243,7 +6245,7 @@ static bool try_steal_cookie(int this, int that)
 		goto unlock;
 
 	do {
-		if (p == src->core_pick || p == src->curr)
+		if (p == src->core_pick || p == rq_curr(src))
 			goto next;
 
 		if (!is_cpu_allowed(p, this))
@@ -6514,7 +6516,7 @@ static void __sched notrace __schedule(unsigned int sched_mode)
 
 	cpu = smp_processor_id();
 	rq = cpu_rq(cpu);
-	prev = rq->curr;
+	prev = rq_curr(rq);
 
 	schedule_debug(prev, !!sched_mode);
 
@@ -6537,7 +6539,7 @@ static void __sched notrace __schedule(unsigned int sched_mode)
 	 *     if (signal_pending_state())	    if (p->state & @state)
 	 *
 	 * Also, the membarrier system call requires a full memory barrier
-	 * after coming from user-space, before storing to rq->curr.
+	 * after coming from user-space, before storing to rq_curr().
 	 */
 	rq_lock(rq, &rf);
 	smp_mb__after_spinlock();
@@ -6596,14 +6598,14 @@ static void __sched notrace __schedule(unsigned int sched_mode)
 	if (likely(prev != next)) {
 		rq->nr_switches++;
 		/*
-		 * RCU users of rcu_dereference(rq->curr) may not see
+		 * RCU users of rq_curr_rcu(rq) may not see
 		 * changes to task_struct made by pick_next_task().
 		 */
-		RCU_INIT_POINTER(rq->curr, next);
+		rq_set_curr_rcu_init(rq, next);
 		/*
 		 * The membarrier system call requires each architecture
 		 * to have a full memory barrier after updating
-		 * rq->curr, before returning to user-space.
+		 * rq_curr(rq), before returning to user-space.
 		 *
 		 * Here are the schemes providing that barrier on the
 		 * various architectures:
@@ -7040,7 +7042,7 @@ void rt_mutex_setprio(struct task_struct *p, struct task_struct *pi_task)
 	 * real need to boost.
 	 */
 	if (unlikely(p == rq->idle)) {
-		WARN_ON(p != rq->curr);
+		WARN_ON(p != rq_curr(rq));
 		WARN_ON(p->pi_blocked_on);
 		goto out_unlock;
 	}
@@ -7256,7 +7258,7 @@ int idle_cpu(int cpu)
 {
 	struct rq *rq = cpu_rq(cpu);
 
-	if (rq->curr != rq->idle)
+	if (rq_curr(rq) != rq->idle)
 		return 0;
 
 	if (rq->nr_running)
@@ -9157,7 +9159,7 @@ void __init init_idle(struct task_struct *idle, int cpu)
 	rcu_read_unlock();
 
 	rq->idle = idle;
-	rcu_assign_pointer(rq->curr, idle);
+	rq_set_curr(rq, idle);
 	idle->on_rq = TASK_ON_RQ_QUEUED;
 #ifdef CONFIG_SMP
 	idle->on_cpu = 1;
@@ -9331,7 +9333,7 @@ static DEFINE_PER_CPU(struct cpu_stop_work, push_work);
  */
 static void balance_push(struct rq *rq)
 {
-	struct task_struct *push_task = rq->curr;
+	struct task_struct *push_task = rq_curr(rq);
 
 	lockdep_assert_rq_held(rq);
 
diff --git a/kernel/sched/core_sched.c b/kernel/sched/core_sched.c
index a57fd8f27498..ece2157a265d 100644
--- a/kernel/sched/core_sched.c
+++ b/kernel/sched/core_sched.c
@@ -273,7 +273,7 @@ void __sched_core_account_forceidle(struct rq *rq)
 
 	for_each_cpu(i, smt_mask) {
 		rq_i = cpu_rq(i);
-		p = rq_i->core_pick ?: rq_i->curr;
+		p = rq_i->core_pick ?: rq_curr(rq_i);
 
 		if (p == rq_i->idle)
 			continue;
diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index af7952f12e6c..83a653d47d22 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -994,7 +994,7 @@ u64 kcpustat_field(struct kernel_cpustat *kcpustat,
 		struct task_struct *curr;
 
 		rcu_read_lock();
-		curr = rcu_dereference(rq->curr);
+		curr = rq_curr_rcu(rq);
 		if (WARN_ON_ONCE(!curr)) {
 			rcu_read_unlock();
 			return cpustat[usage];
@@ -1081,7 +1081,7 @@ void kcpustat_cpu_fetch(struct kernel_cpustat *dst, int cpu)
 		struct task_struct *curr;
 
 		rcu_read_lock();
-		curr = rcu_dereference(rq->curr);
+		curr = rq_curr_rcu(rq);
 		if (WARN_ON_ONCE(!curr)) {
 			rcu_read_unlock();
 			*dst = *src;
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 5a7c4edd5b13..a8296d38b066 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1179,7 +1179,7 @@ static enum hrtimer_restart dl_task_timer(struct hrtimer *timer)
 #endif
 
 	enqueue_task_dl(rq, p, ENQUEUE_REPLENISH);
-	if (dl_task(rq->curr))
+	if (dl_task(rq_curr(rq)))
 		check_preempt_curr_dl(rq, p, 0);
 	else
 		resched_curr(rq);
@@ -1306,7 +1306,7 @@ static u64 grub_reclaim(u64 delta, struct rq *rq, struct sched_dl_entity *dl_se)
  */
 static void update_curr_dl(struct rq *rq)
 {
-	struct task_struct *curr = rq->curr;
+	struct task_struct *curr = rq_curr(rq);
 	struct sched_dl_entity *dl_se = &curr->dl;
 	s64 delta_exec, scaled_delta_exec;
 	int cpu = cpu_of(rq);
@@ -1792,7 +1792,7 @@ static void yield_task_dl(struct rq *rq)
 	 * it and the bandwidth timer will wake it up and will give it
 	 * new scheduling parameters (thanks to dl_yielded=1).
 	 */
-	rq->curr->dl.dl_yielded = 1;
+	rq_curr(rq)->dl.dl_yielded = 1;
 
 	update_rq_clock(rq);
 	update_curr_dl(rq);
@@ -1829,7 +1829,7 @@ select_task_rq_dl(struct task_struct *p, int cpu, int flags)
 	rq = cpu_rq(cpu);
 
 	rcu_read_lock();
-	curr = READ_ONCE(rq->curr); /* unlocked access */
+	curr = rq_curr_once(rq);
 
 	/*
 	 * If we are dealing with a -deadline task, we must
@@ -1904,8 +1904,8 @@ static void check_preempt_equal_dl(struct rq *rq, struct task_struct *p)
 	 * Current can't be migrated, useless to reschedule,
 	 * let's hope p can move out.
 	 */
-	if (rq->curr->nr_cpus_allowed == 1 ||
-	    !cpudl_find(&rq->rd->cpudl, rq->curr, NULL))
+	if (rq_curr(rq)->nr_cpus_allowed == 1 ||
+	    !cpudl_find(&rq->rd->cpudl, rq_curr(rq), NULL))
 		return;
 
 	/*
@@ -1944,7 +1944,7 @@ static int balance_dl(struct rq *rq, struct task_struct *p, struct rq_flags *rf)
 static void check_preempt_curr_dl(struct rq *rq, struct task_struct *p,
 				  int flags)
 {
-	if (dl_entity_preempt(&p->dl, &rq->curr->dl)) {
+	if (dl_entity_preempt(&p->dl, &rq_curr(rq)->dl)) {
 		resched_curr(rq);
 		return;
 	}
@@ -1954,8 +1954,8 @@ static void check_preempt_curr_dl(struct rq *rq, struct task_struct *p,
 	 * In the unlikely case current and p have the same deadline
 	 * let us try to decide what's the best thing to do...
 	 */
-	if ((p->dl.deadline == rq->curr->dl.deadline) &&
-	    !test_tsk_need_resched(rq->curr))
+	if ((p->dl.deadline == rq_curr(rq)->dl.deadline) &&
+	    !test_tsk_need_resched(rq_curr(rq)))
 		check_preempt_equal_dl(rq, p);
 #endif /* CONFIG_SMP */
 }
@@ -1989,7 +1989,7 @@ static void set_next_task_dl(struct rq *rq, struct task_struct *p, bool first)
 	if (hrtick_enabled_dl(rq))
 		start_hrtick_dl(rq, p);
 
-	if (rq->curr->sched_class != &dl_sched_class)
+	if (rq_curr(rq)->sched_class != &dl_sched_class)
 		update_dl_rq_load_avg(rq_clock_pelt(rq), rq, 0);
 
 	deadline_queue_push_tasks(rq);
@@ -2301,13 +2301,13 @@ static int push_dl_task(struct rq *rq)
 
 retry:
 	/*
-	 * If next_task preempts rq->curr, and rq->curr
+	 * If next_task preempts rq_curr(rq), and rq_curr(rq)
 	 * can move away, it makes sense to just reschedule
 	 * without going further in pushing next_task.
 	 */
-	if (dl_task(rq->curr) &&
-	    dl_time_before(next_task->dl.deadline, rq->curr->dl.deadline) &&
-	    rq->curr->nr_cpus_allowed > 1) {
+	if (dl_task(rq_curr(rq)) &&
+	    dl_time_before(next_task->dl.deadline, rq_curr(rq)->dl.deadline) &&
+	    rq_curr(rq)->nr_cpus_allowed > 1) {
 		resched_curr(rq);
 		return 0;
 	}
@@ -2315,7 +2315,7 @@ static int push_dl_task(struct rq *rq)
 	if (is_migration_disabled(next_task))
 		return 0;
 
-	if (WARN_ON(next_task == rq->curr))
+	if (WARN_ON(next_task == rq_curr(rq)))
 		return 0;
 
 	/* We might release rq lock */
@@ -2423,7 +2423,7 @@ static void pull_dl_task(struct rq *this_rq)
 		 */
 		if (p && dl_time_before(p->dl.deadline, dmin) &&
 		    dl_task_is_earliest_deadline(p, this_rq)) {
-			WARN_ON(p == src_rq->curr);
+			WARN_ON(p == rq_curr(src_rq));
 			WARN_ON(!task_on_rq_queued(p));
 
 			/*
@@ -2431,7 +2431,7 @@ static void pull_dl_task(struct rq *this_rq)
 			 * deadline than the current task of its runqueue.
 			 */
 			if (dl_time_before(p->dl.deadline,
-					   src_rq->curr->dl.deadline))
+					   rq_curr(src_rq)->dl.deadline))
 				goto skip;
 
 			if (is_migration_disabled(p)) {
@@ -2468,11 +2468,11 @@ static void pull_dl_task(struct rq *this_rq)
 static void task_woken_dl(struct rq *rq, struct task_struct *p)
 {
 	if (!task_on_cpu(rq, p) &&
-	    !test_tsk_need_resched(rq->curr) &&
+	    !test_tsk_need_resched(rq_curr(rq)) &&
 	    p->nr_cpus_allowed > 1 &&
-	    dl_task(rq->curr) &&
-	    (rq->curr->nr_cpus_allowed < 2 ||
-	     !dl_entity_preempt(&p->dl, &rq->curr->dl))) {
+	    dl_task(rq_curr(rq)) &&
+	    (rq_curr(rq)->nr_cpus_allowed < 2 ||
+	     !dl_entity_preempt(&p->dl, &rq_curr(rq)->dl))) {
 		push_dl_tasks(rq);
 	}
 }
@@ -2635,12 +2635,12 @@ static void switched_to_dl(struct rq *rq, struct task_struct *p)
 		return;
 	}
 
-	if (rq->curr != p) {
+	if (rq_curr(rq) != p) {
 #ifdef CONFIG_SMP
 		if (p->nr_cpus_allowed > 1 && rq->dl.overloaded)
 			deadline_queue_push_tasks(rq);
 #endif
-		if (dl_task(rq->curr))
+		if (dl_task(rq_curr(rq)))
 			check_preempt_curr_dl(rq, p, 0);
 		else
 			resched_curr(rq);
@@ -2684,8 +2684,8 @@ static void prio_changed_dl(struct rq *rq, struct task_struct *p,
 		 *
 		 * Otherwise, if p was given an earlier deadline, reschedule.
 		 */
-		if (!dl_task(rq->curr) ||
-		    dl_time_before(p->dl.deadline, rq->curr->dl.deadline))
+		if (!dl_task(rq_curr(rq)) ||
+		    dl_time_before(p->dl.deadline, rq_curr(rq)->dl.deadline))
 			resched_curr(rq);
 	}
 #else
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 1637b65ba07a..55f57156502d 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -743,7 +743,7 @@ do {									\
 	P(nr_switches);
 	P(nr_uninterruptible);
 	PN(next_balance);
-	SEQ_printf(m, "  .%-30s: %ld\n", "curr->pid", (long)(task_pid_nr(rq->curr)));
+	SEQ_printf(m, "  .%-30s: %ld\n", "curr->pid", (long)(task_pid_nr(rq_curr(rq))));
 	PN(clock);
 	PN(clock_task);
 #undef P
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index bea9a31c76ff..9295e85ab83b 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -919,7 +919,7 @@ static s64 update_curr_se(struct rq *rq, struct sched_entity *curr)
  */
 s64 update_curr_common(struct rq *rq)
 {
-	struct task_struct *curr = rq->curr;
+	struct task_struct *curr = rq_curr(rq);
 	s64 delta_exec;
 
 	delta_exec = update_curr_se(rq, &curr->se);
@@ -964,7 +964,7 @@ static void update_curr(struct cfs_rq *cfs_rq)
 
 static void update_curr_fair(struct rq *rq)
 {
-	update_curr(cfs_rq_of(&rq->curr->se));
+	update_curr(cfs_rq_of(&rq_curr(rq)->se));
 }
 
 static inline void
@@ -1958,7 +1958,7 @@ static bool task_numa_compare(struct task_numa_env *env,
 		return false;
 
 	rcu_read_lock();
-	cur = rcu_dereference(dst_rq->curr);
+	cur = rcu_dereference(rq_curr(dst_rq));
 	if (cur && ((cur->flags & PF_EXITING) || is_idle_task(cur)))
 		cur = NULL;
 
@@ -2747,7 +2747,7 @@ static void task_numa_group(struct task_struct *p, int cpupid, int flags,
 	}
 
 	rcu_read_lock();
-	tsk = READ_ONCE(cpu_rq(cpu)->curr);
+	tsk = READ_ONCE(cpu_curr(cpu));
 
 	if (!cpupid_match_pid(tsk, cpupid))
 		goto no_join;
@@ -3969,7 +3969,7 @@ static inline void migrate_se_pelt_lag(struct sched_entity *se)
 	rq = rq_of(cfs_rq);
 
 	rcu_read_lock();
-	is_idle = is_idle_task(rcu_dereference(rq->curr));
+	is_idle = is_idle_task(rq_curr_rcu(rq));
 	rcu_read_unlock();
 
 	/*
@@ -5534,7 +5534,7 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 	assert_list_leaf_cfs_rq(rq);
 
 	/* Determine whether we need to wake up potentially idle CPU: */
-	if (rq->curr == rq->idle && rq->cfs.nr_running)
+	if (rq_curr(rq) == rq->idle && rq->cfs.nr_running)
 		resched_curr(rq);
 }
 
@@ -6184,7 +6184,7 @@ static void hrtick_start_fair(struct rq *rq, struct task_struct *p)
  */
 static void hrtick_update(struct rq *rq)
 {
-	struct task_struct *curr = rq->curr;
+	struct task_struct *curr = rq_curr(rq);
 
 	if (!hrtick_enabled_fair(rq) || curr->sched_class != &fair_sched_class)
 		return;
@@ -7821,7 +7821,7 @@ static void set_skip_buddy(struct sched_entity *se)
  */
 static void check_preempt_wakeup(struct rq *rq, struct task_struct *p, int wake_flags)
 {
-	struct task_struct *curr = rq->curr;
+	struct task_struct *curr = rq_curr(rq);
 	struct sched_entity *se = &curr->se, *pse = &p->se;
 	struct cfs_rq *cfs_rq = task_cfs_rq(curr);
 	int scale = cfs_rq->nr_running >= sched_nr_latency;
@@ -8119,7 +8119,7 @@ static void put_prev_task_fair(struct rq *rq, struct task_struct *prev)
  */
 static void yield_task_fair(struct rq *rq)
 {
-	struct task_struct *curr = rq->curr;
+	struct task_struct *curr = rq_curr(rq);
 	struct cfs_rq *cfs_rq = task_cfs_rq(curr);
 	struct sched_entity *se = &curr->se;
 
@@ -8854,7 +8854,7 @@ static bool __update_blocked_others(struct rq *rq, bool *done)
 	 * update_load_avg() can call cpufreq_update_util(). Make sure that RT,
 	 * DL and IRQ signals have been updated before updating CFS.
 	 */
-	curr_class = rq->curr->sched_class;
+	curr_class = rq_curr(rq)->sched_class;
 
 	thermal_pressure = arch_scale_thermal_pressure(cpu_of(rq));
 
@@ -9673,8 +9673,9 @@ static unsigned int task_running_on_cpu(int cpu, struct task_struct *p)
 static int idle_cpu_without(int cpu, struct task_struct *p)
 {
 	struct rq *rq = cpu_rq(cpu);
+	struct task_struct *curr = rq_curr(rq);
 
-	if (rq->curr != rq->idle && rq->curr != p)
+	if (curr != rq->idle && curr != p)
 		return 0;
 
 	/*
@@ -10872,7 +10873,7 @@ static int load_balance(int this_cpu, struct rq *this_rq,
 			 * if the curr task on busiest CPU can't be
 			 * moved to this_cpu:
 			 */
-			if (!cpumask_test_cpu(this_cpu, busiest->curr->cpus_ptr)) {
+			if (!cpumask_test_cpu(this_cpu, rq_curr(busiest)->cpus_ptr)) {
 				raw_spin_rq_unlock_irqrestore(busiest, flags);
 				goto out_one_pinned;
 			}
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index e9ef66be2870..8b8b6214d7b7 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -246,8 +246,8 @@ static void do_idle(void)
 	/*
 	 * If the arch has a polling bit, we maintain an invariant:
 	 *
-	 * Our polling bit is clear if we're not scheduled (i.e. if rq->curr !=
-	 * rq->idle). This means that, if rq->idle has the polling bit set,
+	 * Our polling bit is clear if we're not scheduled (i.e. if rq_curr(rq)
+	 * != rq->idle). This means that, if rq->idle has the polling bit set,
 	 * then setting need_resched is guaranteed to cause the CPU to
 	 * reschedule.
 	 */
diff --git a/kernel/sched/membarrier.c b/kernel/sched/membarrier.c
index 2ad881d07752..761044fb3422 100644
--- a/kernel/sched/membarrier.c
+++ b/kernel/sched/membarrier.c
@@ -86,7 +86,7 @@
  *           membarrier():
  *           a: smp_mb()
  *                                           d: switch to kthread (includes mb)
- *           b: read rq->curr->mm == NULL
+ *           b: read rq_curr(rq)->mm == NULL
  *                                           e: switch to user (includes mb)
  *           c: smp_mb()
  *
@@ -108,7 +108,7 @@
  *                                           exit_mm():
  *                                             d: smp_mb()
  *                                             e: current->mm = NULL
- *             b: read rq->curr->mm == NULL
+ *             b: read rq_curr(rq)->mm == NULL
  *             c: smp_mb()
  *
  * Using scenario (B), we can show that (c) needs to be paired with (d).
@@ -122,7 +122,7 @@
  *                                           kthread_unuse_mm()
  *                                             d: smp_mb()
  *                                             e: current->mm = NULL
- *           b: read rq->curr->mm == NULL
+ *           b: read rq_curr(rq)->mm == NULL
  *                                           kthread_use_mm()
  *                                             f: current->mm = mm
  *                                             g: smp_mb()
@@ -251,7 +251,7 @@ static int membarrier_global_expedited(void)
 		return 0;
 
 	/*
-	 * Matches memory barriers around rq->curr modification in
+	 * Matches memory barriers around rq_set_curr() in
 	 * scheduler.
 	 */
 	smp_mb();	/* system call entry is not a mb. */
@@ -283,7 +283,7 @@ static int membarrier_global_expedited(void)
 		 * Skip the CPU if it runs a kernel thread which is not using
 		 * a task mm.
 		 */
-		p = rcu_dereference(cpu_rq(cpu)->curr);
+		p = cpu_curr_rcu(cpu);
 		if (!p->mm)
 			continue;
 
@@ -301,7 +301,7 @@ static int membarrier_global_expedited(void)
 	/*
 	 * Memory barrier on the caller thread _after_ we finished
 	 * waiting for the last IPI. Matches memory barriers around
-	 * rq->curr modification in scheduler.
+	 * rq_set_curr() in scheduler.
 	 */
 	smp_mb();	/* exit from system call is not a mb */
 	return 0;
@@ -339,7 +339,7 @@ static int membarrier_private_expedited(int flags, int cpu_id)
 		return 0;
 
 	/*
-	 * Matches memory barriers around rq->curr modification in
+	 * Matches memory barriers around rq_set_curr() in
 	 * scheduler.
 	 */
 	smp_mb();	/* system call entry is not a mb. */
@@ -355,7 +355,7 @@ static int membarrier_private_expedited(int flags, int cpu_id)
 		if (cpu_id >= nr_cpu_ids || !cpu_online(cpu_id))
 			goto out;
 		rcu_read_lock();
-		p = rcu_dereference(cpu_rq(cpu_id)->curr);
+		p = cpu_curr_rcu(cpu_id);
 		if (!p || p->mm != mm) {
 			rcu_read_unlock();
 			goto out;
@@ -368,7 +368,7 @@ static int membarrier_private_expedited(int flags, int cpu_id)
 		for_each_online_cpu(cpu) {
 			struct task_struct *p;
 
-			p = rcu_dereference(cpu_rq(cpu)->curr);
+			p = cpu_curr_rcu(cpu);
 			if (p && p->mm == mm)
 				__cpumask_set_cpu(cpu, tmpmask);
 		}
@@ -416,7 +416,7 @@ static int membarrier_private_expedited(int flags, int cpu_id)
 	/*
 	 * Memory barrier on the caller thread _after_ we finished
 	 * waiting for the last IPI. Matches memory barriers around
-	 * rq->curr modification in scheduler.
+	 * rq_set_curr() in scheduler.
 	 */
 	smp_mb();	/* exit from system call is not a mb */
 
@@ -466,7 +466,7 @@ static int sync_runqueues_membarrier_state(struct mm_struct *mm)
 		struct rq *rq = cpu_rq(cpu);
 		struct task_struct *p;
 
-		p = rcu_dereference(rq->curr);
+		p = rq_curr_rcu(rq);
 		if (p && p->mm == mm)
 			__cpumask_set_cpu(cpu, tmpmask);
 	}
diff --git a/kernel/sched/pelt.h b/kernel/sched/pelt.h
index 3a0e0dc28721..bf3276f8df78 100644
--- a/kernel/sched/pelt.h
+++ b/kernel/sched/pelt.h
@@ -94,7 +94,7 @@ static inline void _update_idle_rq_clock_pelt(struct rq *rq)
  */
 static inline void update_rq_clock_pelt(struct rq *rq, s64 delta)
 {
-	if (unlikely(is_idle_task(rq->curr))) {
+	if (unlikely(is_idle_task(rq_curr(rq)))) {
 		_update_idle_rq_clock_pelt(rq);
 		return;
 	}
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 18eb6ce60c5c..ecd53be8a6e5 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -574,7 +574,7 @@ static void dequeue_rt_entity(struct sched_rt_entity *rt_se, unsigned int flags)
 
 static void sched_rt_rq_enqueue(struct rt_rq *rt_rq)
 {
-	struct task_struct *curr = rq_of_rt_rq(rt_rq)->curr;
+	struct task_struct *curr = rq_curr(rq_of_rt_rq(rt_rq));
 	struct rq *rq = rq_of_rt_rq(rt_rq);
 	struct sched_rt_entity *rt_se;
 
@@ -958,7 +958,7 @@ static int do_sched_rt_period_timer(struct rt_bandwidth *rt_b, int overrun)
 				 * and this unthrottle will get accounted as
 				 * 'runtime'.
 				 */
-				if (rt_rq->rt_nr_running && rq->curr == rq->idle)
+				if (rt_rq->rt_nr_running && rq_curr(rq) == rq->idle)
 					rq_clock_cancel_skipupdate(rq);
 			}
 			if (rt_rq->rt_time || rt_rq->rt_nr_running)
@@ -1044,7 +1044,7 @@ static int sched_rt_runtime_exceeded(struct rt_rq *rt_rq)
  */
 static void update_curr_rt(struct rq *rq)
 {
-	struct task_struct *curr = rq->curr;
+	struct task_struct *curr = rq_curr(rq);
 	struct sched_rt_entity *rt_se = &curr->rt;
 	s64 delta_exec;
 
@@ -1582,7 +1582,7 @@ static void requeue_task_rt(struct rq *rq, struct task_struct *p, int head)
 
 static void yield_task_rt(struct rq *rq)
 {
-	requeue_task_rt(rq, rq->curr, 0);
+	requeue_task_rt(rq, rq_curr(rq), 0);
 }
 
 #ifdef CONFIG_SMP
@@ -1602,7 +1602,7 @@ select_task_rq_rt(struct task_struct *p, int cpu, int flags)
 	rq = cpu_rq(cpu);
 
 	rcu_read_lock();
-	curr = READ_ONCE(rq->curr); /* unlocked access */
+	curr = rq_curr_once(rq);
 
 	/*
 	 * If the current task on @p's runqueue is an RT task, then
@@ -1666,8 +1666,8 @@ static void check_preempt_equal_prio(struct rq *rq, struct task_struct *p)
 	 * Current can't be migrated, useless to reschedule,
 	 * let's hope p can move out.
 	 */
-	if (rq->curr->nr_cpus_allowed == 1 ||
-	    !cpupri_find(&rq->rd->cpupri, rq->curr, NULL))
+	if (rq_curr(rq)->nr_cpus_allowed == 1 ||
+	    !cpupri_find(&rq->rd->cpupri, rq_curr(rq), NULL))
 		return;
 
 	/*
@@ -1710,7 +1710,7 @@ static int balance_rt(struct rq *rq, struct task_struct *p, struct rq_flags *rf)
  */
 static void check_preempt_curr_rt(struct rq *rq, struct task_struct *p, int flags)
 {
-	if (p->prio < rq->curr->prio) {
+	if (p->prio < rq_curr(rq)->prio) {
 		resched_curr(rq);
 		return;
 	}
@@ -1728,7 +1728,7 @@ static void check_preempt_curr_rt(struct rq *rq, struct task_struct *p, int flag
 	 * to move current somewhere else, making room for our non-migratable
 	 * task.
 	 */
-	if (p->prio == rq->curr->prio && !test_tsk_need_resched(rq->curr))
+	if (p->prio == rq_curr(rq)->prio && !test_tsk_need_resched(rq_curr(rq)))
 		check_preempt_equal_prio(rq, p);
 #endif
 }
@@ -1753,7 +1753,7 @@ static inline void set_next_task_rt(struct rq *rq, struct task_struct *p, bool f
 	 * utilization. We only care of the case where we start to schedule a
 	 * rt task
 	 */
-	if (rq->curr->sched_class != &rt_sched_class)
+	if (rq_curr(rq)->sched_class != &rt_sched_class)
 		update_rt_rq_load_avg(rq_clock_pelt(rq), rq, 0);
 
 	rt_queue_push_tasks(rq);
@@ -2062,7 +2062,7 @@ static int push_rt_task(struct rq *rq, bool pull)
 	 * higher priority than current. If that's the case
 	 * just reschedule current.
 	 */
-	if (unlikely(next_task->prio < rq->curr->prio)) {
+	if (unlikely(next_task->prio < rq_curr(rq)->prio)) {
 		resched_curr(rq);
 		return 0;
 	}
@@ -2083,10 +2083,10 @@ static int push_rt_task(struct rq *rq, bool pull)
 		 * Note that the stoppers are masqueraded as SCHED_FIFO
 		 * (cf. sched_set_stop_task()), so we can't rely on rt_task().
 		 */
-		if (rq->curr->sched_class != &rt_sched_class)
+		if (rq_curr(rq)->sched_class != &rt_sched_class)
 			return 0;
 
-		cpu = find_lowest_rq(rq->curr);
+		cpu = find_lowest_rq(rq_curr(rq));
 		if (cpu == -1 || cpu == rq->cpu)
 			return 0;
 
@@ -2107,7 +2107,7 @@ static int push_rt_task(struct rq *rq, bool pull)
 		return 0;
 	}
 
-	if (WARN_ON(next_task == rq->curr))
+	if (WARN_ON(next_task == rq_curr(rq)))
 		return 0;
 
 	/* We might release rq lock */
@@ -2404,7 +2404,7 @@ static void pull_rt_task(struct rq *this_rq)
 		 * the to-be-scheduled task?
 		 */
 		if (p && (p->prio < this_rq->rt.highest_prio.curr)) {
-			WARN_ON(p == src_rq->curr);
+			WARN_ON(p == rq_curr(src_rq));
 			WARN_ON(!task_on_rq_queued(p));
 
 			/*
@@ -2415,7 +2415,7 @@ static void pull_rt_task(struct rq *this_rq)
 			 * p if it is lower in priority than the
 			 * current task on the run queue
 			 */
-			if (p->prio < src_rq->curr->prio)
+			if (p->prio < rq_curr(src_rq)->prio)
 				goto skip;
 
 			if (is_migration_disabled(p)) {
@@ -2455,11 +2455,11 @@ static void pull_rt_task(struct rq *this_rq)
 static void task_woken_rt(struct rq *rq, struct task_struct *p)
 {
 	bool need_to_push = !task_on_cpu(rq, p) &&
-			    !test_tsk_need_resched(rq->curr) &&
+			    !test_tsk_need_resched(rq_curr(rq)) &&
 			    p->nr_cpus_allowed > 1 &&
-			    (dl_task(rq->curr) || rt_task(rq->curr)) &&
-			    (rq->curr->nr_cpus_allowed < 2 ||
-			     rq->curr->prio <= p->prio);
+			    (dl_task(rq_curr(rq)) || rt_task(rq_curr(rq))) &&
+			    (rq_curr(rq)->nr_cpus_allowed < 2 ||
+			     rq_curr(rq)->prio <= p->prio);
 
 	if (need_to_push)
 		push_rt_tasks(rq);
@@ -2543,7 +2543,7 @@ static void switched_to_rt(struct rq *rq, struct task_struct *p)
 		if (p->nr_cpus_allowed > 1 && rq->rt.overloaded)
 			rt_queue_push_tasks(rq);
 #endif /* CONFIG_SMP */
-		if (p->prio < rq->curr->prio && cpu_online(cpu_of(rq)))
+		if (p->prio < rq_curr(rq)->prio && cpu_online(cpu_of(rq)))
 			resched_curr(rq);
 	}
 }
@@ -2584,7 +2584,7 @@ prio_changed_rt(struct rq *rq, struct task_struct *p, int oldprio)
 		 * greater than the current running task
 		 * then reschedule.
 		 */
-		if (p->prio < rq->curr->prio)
+		if (p->prio < rq_curr(rq)->prio)
 			resched_curr(rq);
 	}
 }
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index d18e3c3a3f40..9e6fb54c66be 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1008,7 +1008,7 @@ struct rq {
 	 */
 	unsigned int		nr_uninterruptible;
 
-	struct task_struct __rcu	*curr;
+	struct task_struct __rcu	*curr_exec;
 	struct task_struct	*idle;
 	struct task_struct	*stop;
 	unsigned long		next_balance;
@@ -1201,12 +1201,46 @@ static inline bool is_migration_disabled(struct task_struct *p)
 
 DECLARE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);
 
+static inline struct task_struct *rq_curr(struct rq *rq)
+{
+	return rq->curr_exec;
+}
+
+static inline struct task_struct *rq_curr_rcu(struct rq *rq)
+{
+	return rcu_dereference(rq->curr_exec);
+}
+
+static inline struct task_struct *rq_curr_once(struct rq *rq)
+{
+	return READ_ONCE(rq->curr_exec);
+}
+
+static inline void rq_set_curr(struct rq *rq, struct task_struct *task)
+{
+	rcu_assign_pointer(rq->curr_exec, task);
+}
+
+/*
+ *  XXX jstultz: seems like rcu_assign_pointer above would also
+ *               work for this, but trying to match usage.
+ */
+static inline void rq_set_curr_rcu_init(struct rq *rq, struct task_struct *task)
+{
+	RCU_INIT_POINTER(rq->curr_exec, task);
+}
+
 #define cpu_rq(cpu)		(&per_cpu(runqueues, (cpu)))
 #define this_rq()		this_cpu_ptr(&runqueues)
 #define task_rq(p)		cpu_rq(task_cpu(p))
-#define cpu_curr(cpu)		(cpu_rq(cpu)->curr)
+#define cpu_curr(cpu)		(rq_curr(cpu_rq(cpu)))
 #define raw_rq()		raw_cpu_ptr(&runqueues)
 
+static inline struct task_struct *cpu_curr_rcu(int cpu)
+{
+	return rq_curr_rcu(cpu_rq(cpu));
+}
+
 struct sched_group;
 #ifdef CONFIG_SCHED_CORE
 static inline struct cpumask *sched_group_span(struct sched_group *sg);
@@ -2070,7 +2104,7 @@ static inline u64 global_rt_runtime(void)
 
 static inline int task_current(struct rq *rq, struct task_struct *p)
 {
-	return rq->curr == p;
+	return rq_curr(rq) == p;
 }
 
 static inline int task_on_cpu(struct rq *rq, struct task_struct *p)
@@ -2230,7 +2264,7 @@ struct sched_class {
 
 static inline void put_prev_task(struct rq *rq, struct task_struct *prev)
 {
-	WARN_ON_ONCE(rq->curr != prev);
+	WARN_ON_ONCE(rq_curr(rq) != prev);
 	prev->sched_class->put_prev_task(rq, prev);
 }
 
@@ -2311,7 +2345,7 @@ extern void set_cpus_allowed_common(struct task_struct *p, struct affinity_conte
 
 static inline struct task_struct *get_push_task(struct rq *rq)
 {
-	struct task_struct *p = rq->curr;
+	struct task_struct *p = rq_curr(rq);
 
 	lockdep_assert_rq_held(rq);
 
@@ -3193,7 +3227,7 @@ static inline bool sched_energy_enabled(void) { return false; }
  * The scheduler provides memory barriers required by membarrier between:
  * - prior user-space memory accesses and store to rq->membarrier_state,
  * - store to rq->membarrier_state and following user-space memory accesses.
- * In the same way it provides those guarantees around store to rq->curr.
+ * In the same way it provides those guarantees around store to rq_curr(rq).
  */
 static inline void membarrier_switch_mm(struct rq *rq,
 					struct mm_struct *prev_mm,
-- 
2.40.0.577.gac1e443424-goog

