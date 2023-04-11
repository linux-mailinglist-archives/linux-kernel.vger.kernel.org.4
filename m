Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 041446DD0EE
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 06:27:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbjDKE1B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 00:27:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbjDKE0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 00:26:16 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 894073C23
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 21:25:42 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-1a52104db35so3251805ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 21:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1681187142; x=1683779142;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=aqbmtVWq+rNWBxgazqjFRXmtnuaSzfFomrIJgWqj7lI=;
        b=N4K3WNfIFz6KEb95R/sEj3oC+roc7rWpRkP+DtvQeM6+VWKpDGlaN+xWOA1x9Gn25V
         kGE9HCAepci5c+Vqq7QKTfjBRdAoO3YGWMnMSbglv+/xwQNvOK4PDUQn2P7pht3nMMCD
         9rTOeaXncTnMaeWhwPHaL2ygvuQcxS2u3SjRva4OJsCLh/O91cNYMBLdty8JyRoKMYU9
         Y6iW3zpZCaUwUeX8zgJzhxLeoUhLLucpC7u093LMez3ruomUx55VsWLh4K5Ik6z/vVxA
         rtmgH98u+qERMMLGiaZPl3xUpHffLuhUesSZCT6B/C3703ZtENpISO81SviqYeyJM87A
         5e7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681187142; x=1683779142;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aqbmtVWq+rNWBxgazqjFRXmtnuaSzfFomrIJgWqj7lI=;
        b=3Nw5BA89sULRyHHyokJM5ZT0sRI3egm1QY5c/6hOznUBYzBMNuo4XESnhmJE8QsKsi
         FsmVDDLDmFPtNZflRUEuKxJKL2OUK9/RvWIqM7qYMUZT0qqqu/jfOnH6oT2XUqOFZRgA
         EEYtThfuo+3GuYPXUgKRo4ufrBnExokZT+SMtYg4U6tuLSIPvmBDlipmY1dVJvEU5tqf
         gLBDnXGH8esVQ0KAxtiyR5qrVTf269HwVGtDncj3ZCfrmSSR0BDq6UwxoAMaOn9RI7fY
         7+XrZNGDPh14lthUlrUDvz+90awLDKE6391nVu4rjC6gDJGHn9ZG+Z+27PpqnlixHXEu
         KW9w==
X-Gm-Message-State: AAQBX9ee9TFaMpyJNPtNUi6zC7nZOLRcvgWqOaw/DFQEohdzCn7r5WT3
        Cy3SqhTeXzSWjMViIIl7QcLJ3hjbBSdtOWxkg3M6c7+/ugMic3mDa6mDBOFDODQ617CyQjmc/qz
        oW46SKBSpbsdLouQY9fBP7QmlZCTsU1bBRAGNKKukNotN/ao3I1c/hkGg/Z8tzbSNNz6697c=
X-Google-Smtp-Source: AKy350YDBIZjhtxg3aCUKae05/9KZrDUSlZA2vMTxB8bqYW4QrUHtHcdP0zcdWHx2+paVsyKQMPps2Xdczm7
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a05:6a00:b41:b0:62d:934e:6ef8 with SMTP id
 p1-20020a056a000b4100b0062d934e6ef8mr5963461pfo.5.1681187141668; Mon, 10 Apr
 2023 21:25:41 -0700 (PDT)
Date:   Tue, 11 Apr 2023 04:25:10 +0000
In-Reply-To: <20230411042511.1606592-1-jstultz@google.com>
Mime-Version: 1.0
References: <20230411042511.1606592-1-jstultz@google.com>
X-Mailer: git-send-email 2.40.0.577.gac1e443424-goog
Message-ID: <20230411042511.1606592-14-jstultz@google.com>
Subject: [PATCH v3 13/14] sched: Attempt to fix rt/dl load balancing via chain
 level balance
From:   John Stultz <jstultz@google.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     "Connor O'Brien" <connoro@google.com>,
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
        "Paul E . McKenney" <paulmck@kernel.org>,
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

From: Connor O'Brien <connoro@google.com>

RT/DL balancing is supposed to guarantee that with N cpus available &
CPU affinity permitting, the top N RT/DL tasks will get spread across
the CPUs and all get to run. Proxy exec greatly complicates this as
blocked tasks remain on the rq but cannot be usefully migrated away
from their lock owning tasks. This has two major consequences:
1. In order to get the desired properties we need to migrate a blocked
task, its would-be proxy, and everything in between, all together -
i.e., we need to push/pull "blocked chains" rather than individual
tasks.
2. Tasks that are part of rq->curr's "blocked tree" therefore should
not be pushed or pulled. Options for enforcing this seem to include
a) create some sort of complex data structure for tracking
pushability, updating it whenever the blocked tree for rq->curr
changes (e.g. on mutex handoffs, migrations, etc.) as well as on
context switches.
b) give up on O(1) pushability checks, and search through the pushable
list every push/pull until we find a pushable "chain"
c) Extend option "b" with some sort of caching to avoid repeated work.

For the sake of simplicity & separating the "chain level balancing"
concerns from complicated optimizations, this patch focuses on trying
to implement option "b" correctly. This can then hopefully provide a
baseline for "correct load balancing behavior" that optimizations can
try to implement more efficiently.

Note:
The inability to atomically check "is task enqueued on a specific rq"
creates 2 possible races when following a blocked chain:
- If we check task_rq() first on a task that is dequeued from its rq,
  it can be woken and enqueued on another rq before the call to
  task_on_rq_queued()
- If we call task_on_rq_queued() first on a task that is on another
  rq, it can be dequeued (since we don't hold its rq's lock) and then
  be set to the current rq before we check task_rq().

Maybe there's a more elegant solution that would work, but for now,
just sandwich the task_rq() check between two task_on_rq_queued()
checks, all separated by smp_rmb() calls. Since we hold rq's lock,
task can't be enqueued or dequeued from rq, so neither race should be
possible.

extensive comments on various pitfalls, races, etc. included inline.

TODO: Probably no good reason not to move the new helper
implementations from sched.h into core.c

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
Signed-off-by: Connor O'Brien <connoro@google.com>
[jstultz: rebased & sorted minor conflicts, folded down numerous
 fixes from Connor, fixed number of checkpatch issues]
Signed-off-by: John Stultz <jstultz@google.com>
---
v3:
* Fix crash by checking find_exec_ctx return for NULL before using it
---
 kernel/sched/core.c        |  10 +-
 kernel/sched/cpudeadline.c |  12 +--
 kernel/sched/cpudeadline.h |   3 +-
 kernel/sched/cpupri.c      |  29 ++++--
 kernel/sched/cpupri.h      |   6 +-
 kernel/sched/deadline.c    | 147 +++++++++++++++++---------
 kernel/sched/fair.c        |   5 +
 kernel/sched/rt.c          | 204 ++++++++++++++++++++++++++-----------
 kernel/sched/sched.h       | 149 ++++++++++++++++++++++++++-
 9 files changed, 434 insertions(+), 131 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 033856bae002..653348263d42 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2495,6 +2495,10 @@ static int migration_cpu_stop(void *data)
 
 int push_cpu_stop(void *arg)
 {
+	/* XXX connoro: how do we handle this case when the rq->curr we push away
+	 * is part of a proxy chain!?
+	 * we actually push the old rq->proxy and its blocker chain.
+	 */
 	struct rq *lowest_rq = NULL, *rq = this_rq();
 	struct task_struct *p = arg;
 
@@ -2519,9 +2523,7 @@ int push_cpu_stop(void *arg)
 
 	// XXX validate p is still the highest prio task
 	if (task_rq(p) == rq) {
-		deactivate_task(rq, p, 0);
-		set_task_cpu(p, lowest_rq->cpu);
-		activate_task(lowest_rq, p, 0);
+		push_task_chain(rq, lowest_rq, p);
 		resched_curr(lowest_rq);
 	}
 
@@ -7271,7 +7273,7 @@ static void __sched notrace __schedule(unsigned int sched_mode)
 		 */
 		rq_set_curr_rcu_init(rq, next);
 
-		if (unlikely(!task_current_proxy(rq, next)))
+		if (unlikely(!task_current_selected(rq, next)))
 			proxy_tag_curr(rq, next);
 
 		/*
diff --git a/kernel/sched/cpudeadline.c b/kernel/sched/cpudeadline.c
index 57c92d751bcd..efd6d716a3f2 100644
--- a/kernel/sched/cpudeadline.c
+++ b/kernel/sched/cpudeadline.c
@@ -113,13 +113,13 @@ static inline int cpudl_maximum(struct cpudl *cp)
  *
  * Returns: int - CPUs were found
  */
-int cpudl_find(struct cpudl *cp, struct task_struct *p,
+int cpudl_find(struct cpudl *cp, struct task_struct *sched_ctx, struct task_struct *exec_ctx,
 	       struct cpumask *later_mask)
 {
-	const struct sched_dl_entity *dl_se = &p->dl;
+	const struct sched_dl_entity *dl_se = &sched_ctx->dl;
 
 	if (later_mask &&
-	    cpumask_and(later_mask, cp->free_cpus, &p->cpus_mask)) {
+	    cpumask_and(later_mask, cp->free_cpus, &exec_ctx->cpus_mask)) {
 		unsigned long cap, max_cap = 0;
 		int cpu, max_cpu = -1;
 
@@ -128,13 +128,13 @@ int cpudl_find(struct cpudl *cp, struct task_struct *p,
 
 		/* Ensure the capacity of the CPUs fits the task. */
 		for_each_cpu(cpu, later_mask) {
-			if (!dl_task_fits_capacity(p, cpu)) {
+			if (!dl_task_fits_capacity(sched_ctx, cpu)) {
 				cpumask_clear_cpu(cpu, later_mask);
 
 				cap = capacity_orig_of(cpu);
 
 				if (cap > max_cap ||
-				    (cpu == task_cpu(p) && cap == max_cap)) {
+				    (cpu == task_cpu(exec_ctx) && cap == max_cap)) {
 					max_cap = cap;
 					max_cpu = cpu;
 				}
@@ -150,7 +150,7 @@ int cpudl_find(struct cpudl *cp, struct task_struct *p,
 
 		WARN_ON(best_cpu != -1 && !cpu_present(best_cpu));
 
-		if (cpumask_test_cpu(best_cpu, &p->cpus_mask) &&
+		if (cpumask_test_cpu(best_cpu, &exec_ctx->cpus_mask) &&
 		    dl_time_before(dl_se->deadline, cp->elements[0].dl)) {
 			if (later_mask)
 				cpumask_set_cpu(best_cpu, later_mask);
diff --git a/kernel/sched/cpudeadline.h b/kernel/sched/cpudeadline.h
index 0adeda93b5fb..6bb27f70e9d2 100644
--- a/kernel/sched/cpudeadline.h
+++ b/kernel/sched/cpudeadline.h
@@ -16,7 +16,8 @@ struct cpudl {
 };
 
 #ifdef CONFIG_SMP
-int  cpudl_find(struct cpudl *cp, struct task_struct *p, struct cpumask *later_mask);
+int  cpudl_find(struct cpudl *cp, struct task_struct *sched_ctx,
+		struct task_struct *exec_ctx, struct cpumask *later_mask);
 void cpudl_set(struct cpudl *cp, int cpu, u64 dl);
 void cpudl_clear(struct cpudl *cp, int cpu);
 int  cpudl_init(struct cpudl *cp);
diff --git a/kernel/sched/cpupri.c b/kernel/sched/cpupri.c
index a286e726eb4b..285242b76597 100644
--- a/kernel/sched/cpupri.c
+++ b/kernel/sched/cpupri.c
@@ -64,6 +64,7 @@ static int convert_prio(int prio)
 	return cpupri;
 }
 
+/* XXX connoro: the p passed in here should be exec ctx */
 static inline int __cpupri_find(struct cpupri *cp, struct task_struct *p,
 				struct cpumask *lowest_mask, int idx)
 {
@@ -96,11 +97,15 @@ static inline int __cpupri_find(struct cpupri *cp, struct task_struct *p,
 	if (skip)
 		return 0;
 
-	if (cpumask_any_and(&p->cpus_mask, vec->mask) >= nr_cpu_ids)
+	if ((p && cpumask_any_and(&p->cpus_mask, vec->mask) >= nr_cpu_ids) ||
+	    (!p && cpumask_any(vec->mask) >= nr_cpu_ids))
 		return 0;
 
 	if (lowest_mask) {
-		cpumask_and(lowest_mask, &p->cpus_mask, vec->mask);
+		if (p)
+			cpumask_and(lowest_mask, &p->cpus_mask, vec->mask);
+		else
+			cpumask_copy(lowest_mask, vec->mask);
 
 		/*
 		 * We have to ensure that we have at least one bit
@@ -117,10 +122,11 @@ static inline int __cpupri_find(struct cpupri *cp, struct task_struct *p,
 	return 1;
 }
 
-int cpupri_find(struct cpupri *cp, struct task_struct *p,
+int cpupri_find(struct cpupri *cp, struct task_struct *sched_ctx,
+		struct task_struct *exec_ctx,
 		struct cpumask *lowest_mask)
 {
-	return cpupri_find_fitness(cp, p, lowest_mask, NULL);
+	return cpupri_find_fitness(cp, sched_ctx, exec_ctx, lowest_mask, NULL);
 }
 
 /**
@@ -140,18 +146,19 @@ int cpupri_find(struct cpupri *cp, struct task_struct *p,
  *
  * Return: (int)bool - CPUs were found
  */
-int cpupri_find_fitness(struct cpupri *cp, struct task_struct *p,
-		struct cpumask *lowest_mask,
-		bool (*fitness_fn)(struct task_struct *p, int cpu))
+int cpupri_find_fitness(struct cpupri *cp, struct task_struct *sched_ctx,
+			struct task_struct *exec_ctx,
+			struct cpumask *lowest_mask,
+			bool (*fitness_fn)(struct task_struct *p, int cpu))
 {
-	int task_pri = convert_prio(p->prio);
+	int task_pri = convert_prio(sched_ctx->prio);
 	int idx, cpu;
 
 	WARN_ON_ONCE(task_pri >= CPUPRI_NR_PRIORITIES);
 
 	for (idx = 0; idx < task_pri; idx++) {
 
-		if (!__cpupri_find(cp, p, lowest_mask, idx))
+		if (!__cpupri_find(cp, exec_ctx, lowest_mask, idx))
 			continue;
 
 		if (!lowest_mask || !fitness_fn)
@@ -159,7 +166,7 @@ int cpupri_find_fitness(struct cpupri *cp, struct task_struct *p,
 
 		/* Ensure the capacity of the CPUs fit the task */
 		for_each_cpu(cpu, lowest_mask) {
-			if (!fitness_fn(p, cpu))
+			if (!fitness_fn(sched_ctx, cpu))
 				cpumask_clear_cpu(cpu, lowest_mask);
 		}
 
@@ -191,7 +198,7 @@ int cpupri_find_fitness(struct cpupri *cp, struct task_struct *p,
 	 * really care.
 	 */
 	if (fitness_fn)
-		return cpupri_find(cp, p, lowest_mask);
+		return cpupri_find(cp, sched_ctx, exec_ctx, lowest_mask);
 
 	return 0;
 }
diff --git a/kernel/sched/cpupri.h b/kernel/sched/cpupri.h
index d6cba0020064..bde7243cec2e 100644
--- a/kernel/sched/cpupri.h
+++ b/kernel/sched/cpupri.h
@@ -18,9 +18,11 @@ struct cpupri {
 };
 
 #ifdef CONFIG_SMP
-int  cpupri_find(struct cpupri *cp, struct task_struct *p,
+int  cpupri_find(struct cpupri *cp, struct task_struct *sched_ctx,
+		 struct task_struct *exec_ctx,
 		 struct cpumask *lowest_mask);
-int  cpupri_find_fitness(struct cpupri *cp, struct task_struct *p,
+int  cpupri_find_fitness(struct cpupri *cp, struct task_struct *sched_ctx,
+			 struct task_struct *exec_ctx,
 			 struct cpumask *lowest_mask,
 			 bool (*fitness_fn)(struct task_struct *p, int cpu));
 void cpupri_set(struct cpupri *cp, int cpu, int pri);
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index c47a75cd057f..539d04310597 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1814,7 +1814,7 @@ static inline bool dl_task_is_earliest_deadline(struct task_struct *p,
 			       rq->dl.earliest_dl.curr));
 }
 
-static int find_later_rq(struct task_struct *task);
+static int find_later_rq(struct task_struct *sched_ctx, struct task_struct *exec_ctx);
 
 static int
 select_task_rq_dl(struct task_struct *p, int cpu, int flags)
@@ -1854,7 +1854,11 @@ select_task_rq_dl(struct task_struct *p, int cpu, int flags)
 		select_rq |= !dl_task_fits_capacity(p, cpu);
 
 	if (select_rq) {
-		int target = find_later_rq(p);
+		/*
+		 * XXX connoro: verify this but in wakeup path we should
+		 * always have unblocked p, so exec_ctx == sched_ctx == p.
+		 */
+		int target = find_later_rq(p, p);
 
 		if (target != -1 &&
 		    dl_task_is_earliest_deadline(p, cpu_rq(target)))
@@ -1901,12 +1905,18 @@ static void migrate_task_rq_dl(struct task_struct *p, int new_cpu __maybe_unused
 
 static void check_preempt_equal_dl(struct rq *rq, struct task_struct *p)
 {
+	struct task_struct *exec_ctx;
+
 	/*
 	 * Current can't be migrated, useless to reschedule,
 	 * let's hope p can move out.
 	 */
 	if (rq_curr(rq)->nr_cpus_allowed == 1 ||
-	    !cpudl_find(&rq->rd->cpudl, rq_selected(rq), NULL))
+	    !cpudl_find(&rq->rd->cpudl, rq_selected(rq), rq_curr(rq), NULL))
+		return;
+
+	exec_ctx = find_exec_ctx(rq, p);
+	if (task_current(rq, exec_ctx))
 		return;
 
 	/*
@@ -1914,7 +1924,7 @@ static void check_preempt_equal_dl(struct rq *rq, struct task_struct *p)
 	 * see if it is pushed or pulled somewhere else.
 	 */
 	if (p->nr_cpus_allowed != 1 &&
-	    cpudl_find(&rq->rd->cpudl, p, NULL))
+	    cpudl_find(&rq->rd->cpudl, p, exec_ctx, NULL))
 		return;
 
 	resched_curr(rq);
@@ -2084,14 +2094,6 @@ static void task_fork_dl(struct task_struct *p)
 /* Only try algorithms three times */
 #define DL_MAX_TRIES 3
 
-static int pick_dl_task(struct rq *rq, struct task_struct *p, int cpu)
-{
-	if (!task_on_cpu(rq, p) &&
-	    cpumask_test_cpu(cpu, &p->cpus_mask))
-		return 1;
-	return 0;
-}
-
 /*
  * Return the earliest pushable rq's task, which is suitable to be executed
  * on the CPU, NULL otherwise:
@@ -2110,7 +2112,7 @@ static struct task_struct *pick_earliest_pushable_dl_task(struct rq *rq, int cpu
 	if (next_node) {
 		p = __node_2_pdl(next_node);
 
-		if (pick_dl_task(rq, p, cpu))
+		if (pushable_chain(rq, p, cpu) == 1)
 			return p;
 
 		next_node = rb_next(next_node);
@@ -2122,25 +2124,25 @@ static struct task_struct *pick_earliest_pushable_dl_task(struct rq *rq, int cpu
 
 static DEFINE_PER_CPU(cpumask_var_t, local_cpu_mask_dl);
 
-static int find_later_rq(struct task_struct *task)
+static int find_later_rq(struct task_struct *sched_ctx, struct task_struct *exec_ctx)
 {
 	struct sched_domain *sd;
 	struct cpumask *later_mask = this_cpu_cpumask_var_ptr(local_cpu_mask_dl);
 	int this_cpu = smp_processor_id();
-	int cpu = task_cpu(task);
+	int cpu = task_cpu(sched_ctx);
 
 	/* Make sure the mask is initialized first */
 	if (unlikely(!later_mask))
 		return -1;
 
-	if (task->nr_cpus_allowed == 1)
+	if (exec_ctx && exec_ctx->nr_cpus_allowed == 1)
 		return -1;
 
 	/*
 	 * We have to consider system topology and task affinity
 	 * first, then we can look for a suitable CPU.
 	 */
-	if (!cpudl_find(&task_rq(task)->rd->cpudl, task, later_mask))
+	if (!cpudl_find(&task_rq(exec_ctx)->rd->cpudl, sched_ctx, exec_ctx, later_mask))
 		return -1;
 
 	/*
@@ -2209,15 +2211,66 @@ static int find_later_rq(struct task_struct *task)
 	return -1;
 }
 
+static struct task_struct *pick_next_pushable_dl_task(struct rq *rq)
+{
+	struct task_struct *p = NULL;
+	struct rb_node *next_node;
+
+	if (!has_pushable_dl_tasks(rq))
+		return NULL;
+
+	next_node = rb_first_cached(&rq->dl.pushable_dl_tasks_root);
+
+next_node:
+	if (next_node) {
+		p = __node_2_pdl(next_node);
+
+		/*
+		 * cpu argument doesn't matter because we treat a -1 result
+		 * (pushable but can't go to cpu0) the same as a 1 result
+		 * (pushable to cpu0). All we care about here is general
+		 * pushability.
+		 */
+		if (pushable_chain(rq, p, 0))
+			return p; /* XXX connoro TODO this is definitely wrong in combo with the later checks...*/
+
+		next_node = rb_next(next_node);
+		goto next_node;
+	}
+
+	if (!p)
+		return NULL;
+
+	WARN_ON_ONCE(rq->cpu != task_cpu(p));
+	WARN_ON_ONCE(task_current(rq, p));
+	WARN_ON_ONCE(p->nr_cpus_allowed <= 1);
+
+	WARN_ON_ONCE(!task_on_rq_queued(p));
+	WARN_ON_ONCE(!dl_task(p));
+
+	return p;
+}
+
 /* Locks the rq it finds */
 static struct rq *find_lock_later_rq(struct task_struct *task, struct rq *rq)
 {
+	struct task_struct *exec_ctx;
 	struct rq *later_rq = NULL;
+	bool retry;
 	int tries;
 	int cpu;
 
 	for (tries = 0; tries < DL_MAX_TRIES; tries++) {
-		cpu = find_later_rq(task);
+		retry = false;
+		exec_ctx = find_exec_ctx(rq, task);
+		/*
+		 * XXX jstultz: double check: if we get null from find_exec_ctx,
+		 * is breaking the right thing?
+		 */
+		if (!exec_ctx)
+			break;
+
+		cpu = find_later_rq(task, exec_ctx);
 
 		if ((cpu == -1) || (cpu == rq->cpu))
 			break;
@@ -2236,11 +2289,30 @@ static struct rq *find_lock_later_rq(struct task_struct *task, struct rq *rq)
 
 		/* Retry if something changed. */
 		if (double_lock_balance(rq, later_rq)) {
-			if (unlikely(task_rq(task) != rq ||
-				     !cpumask_test_cpu(later_rq->cpu, &task->cpus_mask) ||
-				     task_on_cpu(rq, task) ||
-				     !dl_task(task) ||
-				     !task_on_rq_queued(task))) {
+			bool fail = false;
+
+			/* XXX connoro: this is a mess. Surely there's a better way to express it...*/
+			if (!dl_task(task)) {
+				fail = true;
+			} else if (rq != this_rq()) {
+				struct task_struct *next_task = pick_next_pushable_dl_task(rq);
+
+				if (next_task != task) {
+					fail = true;
+				} else {
+					exec_ctx = find_exec_ctx(rq, next_task);
+					retry = (exec_ctx &&
+						!cpumask_test_cpu(later_rq->cpu,
+								  &exec_ctx->cpus_mask));
+				}
+			} else {
+				int pushable = pushable_chain(rq, task, later_rq->cpu);
+
+				fail = !pushable;
+				retry = pushable == -1;
+			}
+
+			if (unlikely(fail)) {
 				double_unlock_balance(rq, later_rq);
 				later_rq = NULL;
 				break;
@@ -2252,7 +2324,7 @@ static struct rq *find_lock_later_rq(struct task_struct *task, struct rq *rq)
 		 * its earliest one has a later deadline than our
 		 * task, the rq is a good one.
 		 */
-		if (dl_task_is_earliest_deadline(task, later_rq))
+		if (!retry && dl_task_is_earliest_deadline(task, later_rq))
 			break;
 
 		/* Otherwise we try again. */
@@ -2263,25 +2335,6 @@ static struct rq *find_lock_later_rq(struct task_struct *task, struct rq *rq)
 	return later_rq;
 }
 
-static struct task_struct *pick_next_pushable_dl_task(struct rq *rq)
-{
-	struct task_struct *p;
-
-	if (!has_pushable_dl_tasks(rq))
-		return NULL;
-
-	p = __node_2_pdl(rb_first_cached(&rq->dl.pushable_dl_tasks_root));
-
-	WARN_ON_ONCE(rq->cpu != task_cpu(p));
-	WARN_ON_ONCE(task_current(rq, p));
-	WARN_ON_ONCE(p->nr_cpus_allowed <= 1);
-
-	WARN_ON_ONCE(!task_on_rq_queued(p));
-	WARN_ON_ONCE(!dl_task(p));
-
-	return p;
-}
-
 /*
  * See if the non running -deadline tasks on this rq
  * can be sent to some other CPU where they can preempt
@@ -2351,9 +2404,7 @@ static int push_dl_task(struct rq *rq)
 		goto retry;
 	}
 
-	deactivate_task(rq, next_task, 0);
-	set_task_cpu(next_task, later_rq->cpu);
-	activate_task(later_rq, next_task, 0);
+	push_task_chain(rq, later_rq, next_task);
 	ret = 1;
 
 	resched_curr(later_rq);
@@ -2439,9 +2490,7 @@ static void pull_dl_task(struct rq *this_rq)
 			if (is_migration_disabled(p)) {
 				push_task = get_push_task(src_rq);
 			} else {
-				deactivate_task(src_rq, p, 0);
-				set_task_cpu(p, this_cpu);
-				activate_task(this_rq, p, 0);
+				push_task_chain(src_rq, this_rq, p);
 				dmin = p->dl.deadline;
 				resched = true;
 			}
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 748a912c2122..acb8155f40c3 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8482,6 +8482,11 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
 
 	lockdep_assert_rq_held(env->src_rq);
 
+	/*
+	 * XXX connoro: Is this correct, or should we be doing chain
+	 * balancing for CFS tasks too? Balancing chains that aren't
+	 * part of the running task's blocked "tree" seems reasonable?
+	 */
 	if (task_is_blocked(p))
 		return 0;
 
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index af92e4147703..a3af1eb47647 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1541,7 +1541,7 @@ enqueue_task_rt(struct rq *rq, struct task_struct *p, int flags)
 	 * Current can't be pushed away. Proxy is tied to current, so don't
 	 * push it either.
 	 */
-	if (task_current(rq, p) || task_current_proxy(rq, p))
+	if (task_current(rq, p) || task_current_selected(rq, p))
 		return;
 
 	/*
@@ -1599,7 +1599,7 @@ static void yield_task_rt(struct rq *rq)
 }
 
 #ifdef CONFIG_SMP
-static int find_lowest_rq(struct task_struct *task);
+static int find_lowest_rq(struct task_struct *sched_ctx, struct task_struct *exec_ctx);
 
 static int
 select_task_rq_rt(struct task_struct *p, int cpu, int flags)
@@ -1649,7 +1649,10 @@ select_task_rq_rt(struct task_struct *p, int cpu, int flags)
 	       (curr->nr_cpus_allowed < 2 || proxy->prio <= p->prio);
 
 	if (test || !rt_task_fits_capacity(p, cpu)) {
-		int target = find_lowest_rq(p);
+		/* XXX connoro: double check this, but if we're waking p then
+		 * it is unblocked so exec_ctx == sched_ctx == p.
+		 */
+		int target = find_lowest_rq(p, p);
 
 		/*
 		 * Bail out if we were forcing a migration to find a better
@@ -1676,12 +1679,22 @@ select_task_rq_rt(struct task_struct *p, int cpu, int flags)
 
 static void check_preempt_equal_prio(struct rq *rq, struct task_struct *p)
 {
+	struct task_struct *exec_ctx = p;
+	/*
+	 * Current can't be migrated, useless to reschedule,
+	 * let's hope p can move out.
+	 */
 	/* XXX connoro: need to revise cpupri_find() to reflect the split
 	 * context since it should look at rq_selected() for priority but
 	 * rq_curr() for affinity.
 	 */
 	if (rq_curr(rq)->nr_cpus_allowed == 1 ||
-	    !cpupri_find(&rq->rd->cpupri, rq_selected(rq), NULL))
+	    !cpupri_find(&rq->rd->cpupri, rq_selected(rq), rq_curr(rq), NULL))
+		return;
+
+	/* No reason to preempt since rq->curr wouldn't change anyway */
+	exec_ctx = find_exec_ctx(rq, p);
+	if (task_current(rq, exec_ctx))
 		return;
 
 	/*
@@ -1689,7 +1702,7 @@ static void check_preempt_equal_prio(struct rq *rq, struct task_struct *p)
 	 * see if it is pushed or pulled somewhere else.
 	 */
 	if (p->nr_cpus_allowed != 1 &&
-	    cpupri_find(&rq->rd->cpupri, p, NULL))
+	    cpupri_find(&rq->rd->cpupri, p, exec_ctx, NULL))
 		return;
 
 	/*
@@ -1855,15 +1868,6 @@ static void put_prev_task_rt(struct rq *rq, struct task_struct *p)
 /* Only try algorithms three times */
 #define RT_MAX_TRIES 3
 
-static int pick_rt_task(struct rq *rq, struct task_struct *p, int cpu)
-{
-	if (!task_on_cpu(rq, p) &&
-	    cpumask_test_cpu(cpu, &p->cpus_mask))
-		return 1;
-
-	return 0;
-}
-
 /*
  * Return the highest pushable rq's task, which is suitable to be executed
  * on the CPU, NULL otherwise
@@ -1877,7 +1881,7 @@ static struct task_struct *pick_highest_pushable_task(struct rq *rq, int cpu)
 		return NULL;
 
 	plist_for_each_entry(p, head, pushable_tasks) {
-		if (pick_rt_task(rq, p, cpu))
+		if (pushable_chain(rq, p, cpu) == 1)
 			return p;
 	}
 
@@ -1886,19 +1890,19 @@ static struct task_struct *pick_highest_pushable_task(struct rq *rq, int cpu)
 
 static DEFINE_PER_CPU(cpumask_var_t, local_cpu_mask);
 
-static int find_lowest_rq(struct task_struct *task)
+static int find_lowest_rq(struct task_struct *sched_ctx, struct task_struct *exec_ctx)
 {
 	struct sched_domain *sd;
 	struct cpumask *lowest_mask = this_cpu_cpumask_var_ptr(local_cpu_mask);
 	int this_cpu = smp_processor_id();
-	int cpu      = task_cpu(task);
+	int cpu      = task_cpu(sched_ctx);
 	int ret;
 
 	/* Make sure the mask is initialized first */
 	if (unlikely(!lowest_mask))
 		return -1;
 
-	if (task->nr_cpus_allowed == 1)
+	if (exec_ctx && exec_ctx->nr_cpus_allowed == 1)
 		return -1; /* No other targets possible */
 
 	/*
@@ -1907,13 +1911,13 @@ static int find_lowest_rq(struct task_struct *task)
 	 */
 	if (sched_asym_cpucap_active()) {
 
-		ret = cpupri_find_fitness(&task_rq(task)->rd->cpupri,
-					  task, lowest_mask,
+		ret = cpupri_find_fitness(&task_rq(sched_ctx)->rd->cpupri,
+					  sched_ctx, exec_ctx, lowest_mask,
 					  rt_task_fits_capacity);
 	} else {
 
-		ret = cpupri_find(&task_rq(task)->rd->cpupri,
-				  task, lowest_mask);
+		ret = cpupri_find(&task_rq(sched_ctx)->rd->cpupri,
+				  sched_ctx, exec_ctx, lowest_mask);
 	}
 
 	if (!ret)
@@ -1977,15 +1981,48 @@ static int find_lowest_rq(struct task_struct *task)
 	return -1;
 }
 
+static struct task_struct *pick_next_pushable_task(struct rq *rq)
+{
+	struct plist_head *head = &rq->rt.pushable_tasks;
+	struct task_struct *p, *push_task = NULL;
+
+	if (!has_pushable_tasks(rq))
+		return NULL;
+
+	plist_for_each_entry(p, head, pushable_tasks) {
+		if (pushable_chain(rq, p, 0)) {
+			push_task = p;
+			break;
+		}
+	}
+
+	if (!push_task)
+		return NULL;
+
+	BUG_ON(rq->cpu != task_cpu(push_task));
+	BUG_ON(task_current(rq, push_task) || task_current_selected(rq, push_task));
+	/*XXX connoro: this check is pointless for blocked push_task. */
+	/* BUG_ON(push_task->nr_cpus_allowed <= 1); */
+
+	BUG_ON(!task_on_rq_queued(push_task));
+	BUG_ON(!rt_task(push_task));
+
+	return p;
+}
+
 /* Will lock the rq it finds */
 static struct rq *find_lock_lowest_rq(struct task_struct *task, struct rq *rq)
 {
+	struct task_struct *exec_ctx;
 	struct rq *lowest_rq = NULL;
+	bool retry;
 	int tries;
 	int cpu;
 
 	for (tries = 0; tries < RT_MAX_TRIES; tries++) {
-		cpu = find_lowest_rq(task);
+		retry = false;
+		exec_ctx = find_exec_ctx(rq, task);
+		cpu = find_lowest_rq(task, exec_ctx);
 
 		if ((cpu == -1) || (cpu == rq->cpu))
 			break;
@@ -2004,18 +2041,77 @@ static struct rq *find_lock_lowest_rq(struct task_struct *task, struct rq *rq)
 
 		/* if the prio of this runqueue changed, try again */
 		if (double_lock_balance(rq, lowest_rq)) {
+			bool fail = false;
 			/*
 			 * We had to unlock the run queue. In
 			 * the mean time, task could have
 			 * migrated already or had its affinity changed.
 			 * Also make sure that it wasn't scheduled on its rq.
+			 *
+			 * XXX connoro: releasing the rq lock means we need to re-check pushability.
+			 * Some scenarios:
+			 * 1) If a migration from another CPU sent a task/chain to rq
+			 *    that made task newly unpushable by completing a chain
+			 *    from task to rq->curr, then we need to bail out and push something
+			 *    else.
+			 * 2) If our chain led off this CPU or to a dequeued task, the last waiter
+			 *    on this CPU might have acquired the lock and woken (or even migrated
+			 *    & run, handed off the lock it held, etc...). This can invalidate the
+			 *    result of find_lowest_rq() if our chain previously ended in a blocked
+			 *    task whose affinity we could ignore, but now ends in an unblocked
+			 *    task that can't run on lowest_rq.
+			 * 3) race described at https://lore.kernel.org/all/1523536384-26781-2-git-send-email-huawei.libin@huawei.com/
+			 *
+			 * Notes on these:
+			 * - Scenario #2 is properly handled by rerunning find_lowest_rq
+			 * - Scenario #1 requires that we fail
+			 * - Scenario #3 can AFAICT only occur when rq is not this_rq(). And the
+			 *   suggested fix is not universally correct now that push_cpu_stop() can
+			 *   call this function.
 			 */
-			if (unlikely(task_rq(task) != rq ||
-				     !cpumask_test_cpu(lowest_rq->cpu, &task->cpus_mask) ||
-				     task_on_cpu(rq, task) ||
-				     !rt_task(task) ||
-				     !task_on_rq_queued(task))) {
+			if (!rt_task(task)) {
+				fail = true;
+			} else if (rq != this_rq()) {
+				/*
+				 * If we are dealing with a remote rq, then all bets are off
+				 * because task might have run & then been dequeued since we
+				 * released the lock, at which point our normal checks can race
+				 * with migration, as described in
+				 * https://lore.kernel.org/all/1523536384-26781-2-git-send-email-huawei.libin@huawei.com/
+				 * Need to repick to ensure we avoid a race.
+				 * But re-picking would be unnecessary & incorrect in the
+				 * push_cpu_stop() path.
+				 */
+				struct task_struct *next_task = pick_next_pushable_task(rq);
+
+				if (next_task != task) {
+					fail = true;
+				} else {
+					exec_ctx = find_exec_ctx(rq, next_task);
+					retry = (exec_ctx &&
+						 !cpumask_test_cpu(lowest_rq->cpu,
+								   &exec_ctx->cpus_mask));
+				}
+			} else {
+				/*
+				 * Chain level balancing introduces new ways for our choice of
+				 * task & rq to become invalid when we release the rq lock, e.g.:
+				 * 1) Migration to rq from another CPU makes task newly unpushable
+				 *    by completing a "blocked chain" from task to rq->curr.
+				 *    Fail so a different task can be chosen for push.
+				 * 2) In cases where task's blocked chain led to a dequeued task
+				 *    or one on another rq, the last waiter in the chain on this
+				 *    rq might have acquired the lock and woken, meaning we must
+				 *    pick a different rq if its affinity prevents running on
+				 *    lowest_rq.
+				 */
+				int pushable = pushable_chain(rq, task, lowest_rq->cpu);
+
+				fail = !pushable;
+				retry = pushable == -1;
+			}
 
+			if (unlikely(fail)) {
 				double_unlock_balance(rq, lowest_rq);
 				lowest_rq = NULL;
 				break;
@@ -2023,7 +2119,7 @@ static struct rq *find_lock_lowest_rq(struct task_struct *task, struct rq *rq)
 		}
 
 		/* If this rq is still suitable use it. */
-		if (lowest_rq->rt.highest_prio.curr > task->prio)
+		if (lowest_rq->rt.highest_prio.curr > task->prio && !retry)
 			break;
 
 		/* try again */
@@ -2034,26 +2130,6 @@ static struct rq *find_lock_lowest_rq(struct task_struct *task, struct rq *rq)
 	return lowest_rq;
 }
 
-static struct task_struct *pick_next_pushable_task(struct rq *rq)
-{
-	struct task_struct *p;
-
-	if (!has_pushable_tasks(rq))
-		return NULL;
-
-	p = plist_first_entry(&rq->rt.pushable_tasks,
-			      struct task_struct, pushable_tasks);
-
-	BUG_ON(rq->cpu != task_cpu(p));
-	BUG_ON(task_current(rq, p) || task_current_selected(rq, p));
-	BUG_ON(p->nr_cpus_allowed <= 1);
-
-	BUG_ON(!task_on_rq_queued(p));
-	BUG_ON(!rt_task(p));
-
-	return p;
-}
-
 /*
  * If the current CPU has more than one RT task, see if the non
  * running task can migrate over to a CPU that is running a task
@@ -2109,10 +2185,10 @@ static int push_rt_task(struct rq *rq, bool pull)
 		 * If #3 is needed, might be best to make a separate patch with
 		 * all the "chain-level load balancing" changes.
 		 */
-		if (rq_curr(rq)->sched_class != &rt_sched_class)
+		if (rq_selected(rq)->sched_class != &rt_sched_class)
 			return 0;
 
-		cpu = find_lowest_rq(rq_curr(rq));
+		cpu = find_lowest_rq(rq_selected(rq), rq_curr(rq));
 		if (cpu == -1 || cpu == rq->cpu)
 			return 0;
 
@@ -2146,6 +2222,15 @@ static int push_rt_task(struct rq *rq, bool pull)
 	 * case for when we push a blocked task whose lock owner is not on
 	 * this rq.
 	 */
+	/* XXX connoro: we might unlock the rq here. But it might be the case that
+	 * the unpushable set can only *grow* and not shrink? Hmmm
+	 * - load balancing should not pull anything from the active blocked tree
+	 * - rq->curr can't have made progress or released mutexes
+	 * - we can't have scheduled, right? Is preemption disabled here?
+	 * - however, suppose proxy() pushed a task or chain here that linked our chain
+	 *   into the active tree.
+	 */
+	/* XXX connoro: we need to pass in */
 	lowest_rq = find_lock_lowest_rq(next_task, rq);
 	if (!lowest_rq) {
 		struct task_struct *task;
@@ -2180,9 +2265,7 @@ static int push_rt_task(struct rq *rq, bool pull)
 		goto retry;
 	}
 
-	deactivate_task(rq, next_task, 0);
-	set_task_cpu(next_task, lowest_rq->cpu);
-	activate_task(lowest_rq, next_task, 0);
+	push_task_chain(rq, lowest_rq, next_task);
 	resched_curr(lowest_rq);
 	ret = 1;
 
@@ -2453,9 +2536,8 @@ static void pull_rt_task(struct rq *this_rq)
 			if (is_migration_disabled(p)) {
 				push_task = get_push_task(src_rq);
 			} else {
-				deactivate_task(src_rq, p, 0);
-				set_task_cpu(p, this_cpu);
-				activate_task(this_rq, p, 0);
+				/* XXX connoro: need to do chain migration here. */
+				push_task_chain(src_rq, this_rq, p);
 				resched = true;
 			}
 			/*
@@ -2469,6 +2551,14 @@ static void pull_rt_task(struct rq *this_rq)
 		double_unlock_balance(this_rq, src_rq);
 
 		if (push_task) {
+			/*
+			 * can push_cpu_stop get away with following blocked_proxy
+			 * even though it's not following it from rq->curr?
+			 * I can't figure out if that's correct.
+			 * Ha! actually the trick is that get_push_task should return
+			 * the proxy!
+			 * So push_cpu_stop just follows blocked_on relations.
+			 */
 			raw_spin_rq_unlock(this_rq);
 			stop_one_cpu_nowait(src_rq->cpu, push_cpu_stop,
 					    push_task, &src_rq->push_work);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 8330d22b286f..a4f5d03dfd50 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2422,7 +2422,7 @@ static inline struct task_struct *get_push_task(struct rq *rq)
 	 * chain during the __schedule() call immediately after rq_curr() is
 	 * pushed.
 	 */
-	struct task_struct *p = rq_curr(rq);
+	struct task_struct *p = rq_selected(rq);
 
 	lockdep_assert_rq_held(rq);
 
@@ -3409,4 +3409,151 @@ static inline void switch_mm_cid(struct task_struct *prev, struct task_struct *n
 static inline void switch_mm_cid(struct task_struct *prev, struct task_struct *next) { }
 #endif
 
+#ifdef CONFIG_SMP
+
+static inline bool task_queued_on_rq(struct rq *rq, struct task_struct *task)
+{
+	if (!task_on_rq_queued(task))
+		return false;
+	smp_rmb();
+	if (task_rq(task) != rq)
+		return false;
+	smp_rmb();
+	if (!task_on_rq_queued(task))
+		return false;
+	return true;
+}
+
+static inline void push_task_chain(struct rq *rq, struct rq *dst_rq, struct task_struct *task)
+{
+	struct task_struct *owner;
+
+	lockdep_assert_rq_held(rq);
+	lockdep_assert_rq_held(dst_rq);
+
+	BUG_ON(!task_queued_on_rq(rq, task));
+	BUG_ON(task_current_selected(rq, task));
+
+	for (; task != NULL; task = owner) {
+		/*
+		 * XXX connoro: note that if task is currently in the process of migrating to
+		 * rq (but not yet enqueued since we hold the rq lock) then we stop only after
+		 * pushing all the preceding tasks. This isn't ideal (the pushed chain will
+		 * probably get sent back as soon as it's picked on dst_rq) but short of holding
+		 * all of the rq locks while balancing, I don't see how we can avoid this, and
+		 * some extra migrations are clearly better than trying to dequeue task from rq
+		 * before it's ever enqueued here.
+		 *
+		 * XXX connoro: catastrophic race when task is dequeued on rq to start and then
+		 * wakes on another rq in between the two checks.
+		 * There's probably a better way than the below though...
+		 */
+		if (!task_queued_on_rq(rq, task) || task_current_selected(rq, task))
+			break;
+
+		if (task_is_blocked(task)) {
+			owner = mutex_owner(task->blocked_on);
+		} else {
+			owner = NULL;
+		}
+		deactivate_task(rq, task, 0);
+		set_task_cpu(task, dst_rq->cpu);
+		activate_task(dst_rq, task, 0);
+		if (task == owner)
+			break;
+	}
+}
+
+/*
+ * Returns the unblocked task at the end of the blocked chain starting with p
+ * if that chain is composed entirely of tasks enqueued on rq, or NULL otherwise.
+ */
+static inline struct task_struct *find_exec_ctx(struct rq *rq, struct task_struct *p)
+{
+	struct task_struct *exec_ctx, *owner;
+	struct mutex *mutex;
+
+	lockdep_assert_rq_held(rq);
+
+	/*
+	 * XXX connoro: I *think* we have to return rq->curr if it occurs anywhere in the chain
+	 * to avoid races in certain scenarios where rq->curr has just blocked but can't
+	 * switch out until we release its rq lock.
+	 * Should the check be task_on_cpu() instead? Does it matter? I don't think this
+	 * gets called while context switch is actually ongoing which IIUC is where this would
+	 * make a difference...
+	 * correction: it can get called from finish_task_switch apparently. Unless that's wrong;
+	 * double check.
+	 */
+	for (exec_ctx = p; task_is_blocked(exec_ctx) && !task_on_cpu(rq, exec_ctx);
+							exec_ctx = owner) {
+		mutex = exec_ctx->blocked_on;
+		owner = mutex_owner(mutex);
+		if (owner == exec_ctx)
+			break;
+
+		/*
+		 * XXX connoro: can we race here if owner is migrating to rq?
+		 * owner has to be dequeued from its old rq before set_task_cpu
+		 * is called, and we hold this rq's lock so it can't be
+		 * enqueued here yet...right?
+		 *
+		 * Also if owner is dequeued we can race with its wakeup on another
+		 * CPU...at which point all hell will break loose potentially...
+		 */
+		if (!task_queued_on_rq(rq, owner) || task_current_selected(rq, owner)) {
+			exec_ctx = NULL;
+			break;
+		}
+	}
+	return exec_ctx;
+}
+
+/*
+ * Returns:
+ * 1 if chain is pushable and affinity does not prevent pushing to cpu
+ * 0 if chain is unpushable
+ * -1 if chain is pushable but affinity blocks running on cpu.
+ * XXX connoro: maybe there's a cleaner way to do this...
+ */
+static inline int pushable_chain(struct rq *rq, struct task_struct *p, int cpu)
+{
+	struct task_struct *exec_ctx;
+
+	lockdep_assert_rq_held(rq);
+
+	/*
+	 * XXX connoro: 2 issues combine here:
+	 * 1) we apparently have some stuff on the pushable list after it's
+	 *    dequeued from the rq
+	 * 2) This check can race with migration/wakeup if p was already dequeued
+	 *    when we got the rq lock...
+	 */
+	if (task_rq(p) != rq || !task_on_rq_queued(p))
+		return 0;
+
+	exec_ctx = find_exec_ctx(rq, p);
+	/*
+	 * Chain leads off the rq, we're free to push it anywhere.
+	 *
+	 * One wrinkle with relying on find_exec_ctx is that when the chain
+	 * leads to a task currently migrating to rq, we see the chain as
+	 * pushable & push everything prior to the migrating task. Even if
+	 * we checked explicitly for this case, we could still race with a
+	 * migration after the check.
+	 * This shouldn't permanently produce a bad state though, as proxy()
+	 * will send the chain back to rq and by that point the migration
+	 * should be complete & a proper push can occur.
+	 */
+	if (!exec_ctx)
+		return 1;
+
+	if (task_on_cpu(rq, exec_ctx) || exec_ctx->nr_cpus_allowed <= 1)
+		return 0;
+
+	return cpumask_test_cpu(cpu, &exec_ctx->cpus_mask) ? 1 : -1;
+}
+
+#endif
+
 #endif /* _KERNEL_SCHED_SCHED_H */
-- 
2.40.0.577.gac1e443424-goog

