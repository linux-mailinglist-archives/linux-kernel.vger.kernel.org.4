Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ED357192E2
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 08:00:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231704AbjFAGAw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 02:00:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231823AbjFAF7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 01:59:52 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97BE7E57
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 22:59:18 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-ba8cf175f5bso4086699276.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 22:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685599158; x=1688191158;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VZEDw7T8jyn9hTL84YkZjKnXpFBEhVZAMOLLsrmZEN4=;
        b=WYKSxpMrmDbSYLsQeaM+5wQCPuBp98WSqdLa1Dh2EGoC/RXoW6lmIklVjERDYqof1O
         Ow0PQxa/6AbwxpfchMe6slQ56dvb2oYXl2idDloav8DhfMgtbcHafd6/R+ushkzrbHyL
         OT8RNsoPRFOmOfkjiTO2nHEO0npB98eQYFlqYzoM1MkOexprFaObfRmh37ABiM5n3gOW
         Ak7NWGYzNZlUNXK8+vaThbU+fDYbwSbxEmyvRgza4SAo/3A/vURhCW2VYDWe2kL6t1ay
         YCIdnyC7lXx1Ykklkzs64nQ76IqN2RftESGIJtYc6pyQy5z6GB7ueE5wJuXvTlTOjvjd
         kDhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685599158; x=1688191158;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VZEDw7T8jyn9hTL84YkZjKnXpFBEhVZAMOLLsrmZEN4=;
        b=Wm5UjV2JuiboGMIEai/J8fb7rBdAfyGYYqze5/Xm2/QCpPVhFGG9NH0sw2/WTR3K+W
         Fx4GfQo6q7sqkqNGFfBPklsmmuPLiNNd5tOT724KAf6buFvHjaxxHG1jM3l0XoYsUmnH
         mLtkF5bD5EcW6YNA6jsU/QhzmYW4onPbgLOP1LYCfu14U0Ulqxz4Z4G0wYDpHWfYGKJR
         qPYRFEerxQOYCKZnz0JMJMxG3+GBETXjfog3480R4ZAWxF2B56bLYYfULN/Bq84iG5xY
         6GJX/4O234xagJOv4ZYg1yVUyadCSOqvyrUNj7xn6lWggO3Vy4FbnQtheDb1JkalQqmt
         myhQ==
X-Gm-Message-State: AC+VfDyAW1BVy8/EYB1x5WYqbX7y6akb7qYkQSqrv0kaepVh23/IP96D
        Us/N137bkK7gEWCNUkEpuonYKBn84ACGFqeuC+38W8PzHVvsu/S1jt7Wuq8dJqZbWXPmENpcLX4
        nURSgG1jVuK8W3NF1oCxBSBbafsobJC0iMghuLkKufWq/4zIZc/qSqtCUMEVb9yghvum0A7Y=
X-Google-Smtp-Source: ACHHUZ5iBSlUsGR/ZNxypESof6ALaoE7ox3NUjuYg56Dhcsptcj8Zgim/v0x7Y360DsQQC34/l51KXpRwRQk
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a25:94b:0:b0:bb1:569c:f381 with SMTP id
 u11-20020a25094b000000b00bb1569cf381mr616589ybm.1.1685599157640; Wed, 31 May
 2023 22:59:17 -0700 (PDT)
Date:   Thu,  1 Jun 2023 05:58:15 +0000
In-Reply-To: <20230601055846.2349566-1-jstultz@google.com>
Mime-Version: 1.0
References: <20230601055846.2349566-1-jstultz@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Message-ID: <20230601055846.2349566-13-jstultz@google.com>
Subject: [PATCH v4 12/13] sched: Attempt to fix rt/dl load balancing via chain
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
        Youssef Esmat <youssefesmat@google.com>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>, kernel-team@android.com,
        John Stultz <jstultz@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
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
Cc: Youssef Esmat <youssefesmat@google.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Will Deacon <will@kernel.org>
Cc: Waiman Long <longman@redhat.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: "Paul E . McKenney" <paulmck@kernel.org>
Cc: kernel-team@android.com
Signed-off-by: Connor O'Brien <connoro@google.com>
[jstultz: rebased & sorted minor conflicts, folded down numerous
 fixes from Connor, fixed number of checkpatch issues]
Signed-off-by: John Stultz <jstultz@google.com>
---
v3:
* Fix crash by checking find_exec_ctx return for NULL before using it
v4:
* Remove verbose comments/questions to avoid review
  distractions, as suggested by Dietmar
* Moved most added functions from sched.h into core.c to be able
  to access __mutex_owner()
---
 kernel/sched/core.c        | 108 +++++++++++++++++++++-
 kernel/sched/cpudeadline.c |  12 +--
 kernel/sched/cpudeadline.h |   3 +-
 kernel/sched/cpupri.c      |  28 +++---
 kernel/sched/cpupri.h      |   6 +-
 kernel/sched/deadline.c    | 139 +++++++++++++++++-----------
 kernel/sched/rt.c          | 179 +++++++++++++++++++++++++------------
 kernel/sched/sched.h       |   8 +-
 8 files changed, 352 insertions(+), 131 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index c56921dc427e..e0e6c2feefd0 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2540,9 +2540,7 @@ int push_cpu_stop(void *arg)
 
 	// XXX validate p is still the highest prio task
 	if (task_rq(p) == rq) {
-		deactivate_task(rq, p, 0);
-		set_task_cpu(p, lowest_rq->cpu);
-		activate_task(lowest_rq, p, 0);
+		push_task_chain(rq, lowest_rq, p);
 		resched_curr(lowest_rq);
 	}
 
@@ -3824,6 +3822,110 @@ ttwu_do_activate(struct rq *rq, struct task_struct *p, int wake_flags,
 #endif
 }
 
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
+void push_task_chain(struct rq *rq, struct rq *dst_rq, struct task_struct *task)
+{
+	struct task_struct *owner;
+
+	lockdep_assert_rq_held(rq);
+	lockdep_assert_rq_held(dst_rq);
+
+	BUG_ON(!task_queued_on_rq(rq, task));
+	BUG_ON(task_current_selected(rq, task));
+
+	while (task) {
+		if (!task_queued_on_rq(rq, task) || task_current_selected(rq, task))
+			break;
+
+		if (task_is_blocked(task))
+			owner = __mutex_owner(task->blocked_on);
+		else
+			owner = NULL;
+
+		deactivate_task(rq, task, 0);
+		set_task_cpu(task, dst_rq->cpu);
+		activate_task(dst_rq, task, 0);
+		if (task == owner)
+			break;
+		task = owner;
+	}
+}
+
+/*
+ * Returns the unblocked task at the end of the blocked chain starting with p
+ * if that chain is composed entirely of tasks enqueued on rq, or NULL otherwise.
+ */
+struct task_struct *find_exec_ctx(struct rq *rq, struct task_struct *p)
+{
+	struct task_struct *exec_ctx, *owner;
+	struct mutex *mutex;
+
+	lockdep_assert_rq_held(rq);
+
+	for (exec_ctx = p; task_is_blocked(exec_ctx) && !task_on_cpu(rq, exec_ctx);
+							exec_ctx = owner) {
+		mutex = exec_ctx->blocked_on;
+		owner = __mutex_owner(mutex);
+		if (owner == exec_ctx)
+			break;
+
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
+ */
+int pushable_chain(struct rq *rq, struct task_struct *p, int cpu)
+{
+	struct task_struct *exec_ctx;
+
+	lockdep_assert_rq_held(rq);
+
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
 #ifdef CONFIG_PROXY_EXEC
 bool ttwu_proxy_skip_wakeup(struct rq *rq, struct task_struct *p)
 {
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
index a286e726eb4b..fb4ddfde221e 100644
--- a/kernel/sched/cpupri.c
+++ b/kernel/sched/cpupri.c
@@ -96,11 +96,15 @@ static inline int __cpupri_find(struct cpupri *cp, struct task_struct *p,
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
@@ -117,10 +121,11 @@ static inline int __cpupri_find(struct cpupri *cp, struct task_struct *p,
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
@@ -140,18 +145,19 @@ int cpupri_find(struct cpupri *cp, struct task_struct *p,
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
@@ -159,7 +165,7 @@ int cpupri_find_fitness(struct cpupri *cp, struct task_struct *p,
 
 		/* Ensure the capacity of the CPUs fit the task */
 		for_each_cpu(cpu, lowest_mask) {
-			if (!fitness_fn(p, cpu))
+			if (!fitness_fn(sched_ctx, cpu))
 				cpumask_clear_cpu(cpu, lowest_mask);
 		}
 
@@ -191,7 +197,7 @@ int cpupri_find_fitness(struct cpupri *cp, struct task_struct *p,
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
index 1d2711aee448..3cc8f96480e8 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1814,7 +1814,7 @@ static inline bool dl_task_is_earliest_deadline(struct task_struct *p,
 			       rq->dl.earliest_dl.curr));
 }
 
-static int find_later_rq(struct task_struct *task);
+static int find_later_rq(struct task_struct *sched_ctx, struct task_struct *exec_ctx);
 
 static int
 select_task_rq_dl(struct task_struct *p, int cpu, int flags)
@@ -1854,7 +1854,7 @@ select_task_rq_dl(struct task_struct *p, int cpu, int flags)
 		select_rq |= !dl_task_fits_capacity(p, cpu);
 
 	if (select_rq) {
-		int target = find_later_rq(p);
+		int target = find_later_rq(p, p);
 
 		if (target != -1 &&
 		    dl_task_is_earliest_deadline(p, cpu_rq(target)))
@@ -1901,12 +1901,18 @@ static void migrate_task_rq_dl(struct task_struct *p, int new_cpu __maybe_unused
 
 static void check_preempt_equal_dl(struct rq *rq, struct task_struct *p)
 {
+	struct task_struct *exec_ctx;
+
 	/*
 	 * Current can't be migrated, useless to reschedule,
 	 * let's hope p can move out.
 	 */
 	if (rq->curr->nr_cpus_allowed == 1 ||
-	    !cpudl_find(&rq->rd->cpudl, rq_selected(rq), NULL))
+	    !cpudl_find(&rq->rd->cpudl, rq_selected(rq), rq->curr, NULL))
+		return;
+
+	exec_ctx = find_exec_ctx(rq, p);
+	if (task_current(rq, exec_ctx))
 		return;
 
 	/*
@@ -1914,7 +1920,7 @@ static void check_preempt_equal_dl(struct rq *rq, struct task_struct *p)
 	 * see if it is pushed or pulled somewhere else.
 	 */
 	if (p->nr_cpus_allowed != 1 &&
-	    cpudl_find(&rq->rd->cpudl, p, NULL))
+	    cpudl_find(&rq->rd->cpudl, p, exec_ctx, NULL))
 		return;
 
 	resched_curr(rq);
@@ -2084,14 +2090,6 @@ static void task_fork_dl(struct task_struct *p)
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
@@ -2110,7 +2108,7 @@ static struct task_struct *pick_earliest_pushable_dl_task(struct rq *rq, int cpu
 	if (next_node) {
 		p = __node_2_pdl(next_node);
 
-		if (pick_dl_task(rq, p, cpu))
+		if (pushable_chain(rq, p, cpu) == 1)
 			return p;
 
 		next_node = rb_next(next_node);
@@ -2122,25 +2120,25 @@ static struct task_struct *pick_earliest_pushable_dl_task(struct rq *rq, int cpu
 
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
@@ -2209,15 +2207,62 @@ static int find_later_rq(struct task_struct *task)
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
+			return p;
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
+		if (!exec_ctx)
+			break;
+
+		cpu = find_later_rq(task, exec_ctx);
 
 		if ((cpu == -1) || (cpu == rq->cpu))
 			break;
@@ -2236,12 +2281,29 @@ static struct rq *find_lock_later_rq(struct task_struct *task, struct rq *rq)
 
 		/* Retry if something changed. */
 		if (double_lock_balance(rq, later_rq)) {
-			if (unlikely(task_rq(task) != rq ||
-				     !cpumask_test_cpu(later_rq->cpu, &task->cpus_mask) ||
-				     task_on_cpu(rq, task) ||
-				     !dl_task(task) ||
-				     is_migration_disabled(task) ||
-				     !task_on_rq_queued(task))) {
+			bool fail = false;
+
+			if (!dl_task(task) || is_migration_disabled(task)) {
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
@@ -2253,7 +2315,7 @@ static struct rq *find_lock_later_rq(struct task_struct *task, struct rq *rq)
 		 * its earliest one has a later deadline than our
 		 * task, the rq is a good one.
 		 */
-		if (dl_task_is_earliest_deadline(task, later_rq))
+		if (!retry && dl_task_is_earliest_deadline(task, later_rq))
 			break;
 
 		/* Otherwise we try again. */
@@ -2264,25 +2326,6 @@ static struct rq *find_lock_later_rq(struct task_struct *task, struct rq *rq)
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
@@ -2351,9 +2394,7 @@ static int push_dl_task(struct rq *rq)
 		goto retry;
 	}
 
-	deactivate_task(rq, next_task, 0);
-	set_task_cpu(next_task, later_rq->cpu);
-	activate_task(later_rq, next_task, 0);
+	push_task_chain(rq, later_rq, next_task);
 	ret = 1;
 
 	resched_curr(later_rq);
@@ -2439,9 +2480,7 @@ static void pull_dl_task(struct rq *this_rq)
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
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index d6bffcf31de0..a1780c2c7101 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1599,7 +1599,7 @@ static void yield_task_rt(struct rq *rq)
 }
 
 #ifdef CONFIG_SMP
-static int find_lowest_rq(struct task_struct *task);
+static int find_lowest_rq(struct task_struct *sched_ctx, struct task_struct *exec_ctx);
 
 static int
 select_task_rq_rt(struct task_struct *p, int cpu, int flags)
@@ -1649,7 +1649,7 @@ select_task_rq_rt(struct task_struct *p, int cpu, int flags)
 	       (curr->nr_cpus_allowed < 2 || selected->prio <= p->prio);
 
 	if (test || !rt_task_fits_capacity(p, cpu)) {
-		int target = find_lowest_rq(p);
+		int target = find_lowest_rq(p, p);
 
 		/*
 		 * Bail out if we were forcing a migration to find a better
@@ -1676,8 +1676,18 @@ select_task_rq_rt(struct task_struct *p, int cpu, int flags)
 
 static void check_preempt_equal_prio(struct rq *rq, struct task_struct *p)
 {
+	struct task_struct *exec_ctx = p;
+	/*
+	 * Current can't be migrated, useless to reschedule,
+	 * let's hope p can move out.
+	 */
 	if (rq->curr->nr_cpus_allowed == 1 ||
-	    !cpupri_find(&rq->rd->cpupri, rq_selected(rq), NULL))
+	    !cpupri_find(&rq->rd->cpupri, rq_selected(rq), rq->curr, NULL))
+		return;
+
+	/* No reason to preempt since rq->curr wouldn't change anyway */
+	exec_ctx = find_exec_ctx(rq, p);
+	if (task_current(rq, exec_ctx))
 		return;
 
 	/*
@@ -1685,7 +1695,7 @@ static void check_preempt_equal_prio(struct rq *rq, struct task_struct *p)
 	 * see if it is pushed or pulled somewhere else.
 	 */
 	if (p->nr_cpus_allowed != 1 &&
-	    cpupri_find(&rq->rd->cpupri, p, NULL))
+	    cpupri_find(&rq->rd->cpupri, p, exec_ctx, NULL))
 		return;
 
 	/*
@@ -1851,15 +1861,6 @@ static void put_prev_task_rt(struct rq *rq, struct task_struct *p)
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
@@ -1873,7 +1874,7 @@ static struct task_struct *pick_highest_pushable_task(struct rq *rq, int cpu)
 		return NULL;
 
 	plist_for_each_entry(p, head, pushable_tasks) {
-		if (pick_rt_task(rq, p, cpu))
+		if (pushable_chain(rq, p, cpu) == 1)
 			return p;
 	}
 
@@ -1882,19 +1883,19 @@ static struct task_struct *pick_highest_pushable_task(struct rq *rq, int cpu)
 
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
@@ -1903,13 +1904,13 @@ static int find_lowest_rq(struct task_struct *task)
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
@@ -1973,15 +1974,45 @@ static int find_lowest_rq(struct task_struct *task)
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
@@ -2000,6 +2031,7 @@ static struct rq *find_lock_lowest_rq(struct task_struct *task, struct rq *rq)
 
 		/* if the prio of this runqueue changed, try again */
 		if (double_lock_balance(rq, lowest_rq)) {
+			bool fail = false;
 			/*
 			 * We had to unlock the run queue. In
 			 * the mean time, task could have
@@ -2008,14 +2040,71 @@ static struct rq *find_lock_lowest_rq(struct task_struct *task, struct rq *rq)
 			 * It is possible the task was scheduled, set
 			 * "migrate_disabled" and then got preempted, so we must
 			 * check the task migration disable flag here too.
+			 *
+			 * Releasing the rq lock means we need to re-check pushability.
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
+			 * 3) Race described at https://lore.kernel.org/all/1523536384-26781-2-git-send-email-huawei.libin@huawei.com/
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
-				     is_migration_disabled(task) ||
-				     !task_on_rq_queued(task))) {
+			if (!rt_task(task) || is_migration_disabled(task)) {
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
 
+				fail = !pushable;
+				retry = pushable == -1;
+			}
+
+			if (unlikely(fail)) {
 				double_unlock_balance(rq, lowest_rq);
 				lowest_rq = NULL;
 				break;
@@ -2023,7 +2112,7 @@ static struct rq *find_lock_lowest_rq(struct task_struct *task, struct rq *rq)
 		}
 
 		/* If this rq is still suitable use it. */
-		if (lowest_rq->rt.highest_prio.curr > task->prio)
+		if (lowest_rq->rt.highest_prio.curr > task->prio && !retry)
 			break;
 
 		/* try again */
@@ -2034,26 +2123,6 @@ static struct rq *find_lock_lowest_rq(struct task_struct *task, struct rq *rq)
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
@@ -2099,10 +2168,10 @@ static int push_rt_task(struct rq *rq, bool pull)
 		 * Note that the stoppers are masqueraded as SCHED_FIFO
 		 * (cf. sched_set_stop_task()), so we can't rely on rt_task().
 		 */
-		if (rq->curr->sched_class != &rt_sched_class)
+		if (rq_selected(rq)->sched_class != &rt_sched_class)
 			return 0;
 
-		cpu = find_lowest_rq(rq->curr);
+		cpu = find_lowest_rq(rq_selected(rq), rq->curr);
 		if (cpu == -1 || cpu == rq->cpu)
 			return 0;
 
@@ -2164,9 +2233,7 @@ static int push_rt_task(struct rq *rq, bool pull)
 		goto retry;
 	}
 
-	deactivate_task(rq, next_task, 0);
-	set_task_cpu(next_task, lowest_rq->cpu);
-	activate_task(lowest_rq, next_task, 0);
+	push_task_chain(rq, lowest_rq, next_task);
 	resched_curr(lowest_rq);
 	ret = 1;
 
@@ -2437,9 +2504,7 @@ static void pull_rt_task(struct rq *this_rq)
 			if (is_migration_disabled(p)) {
 				push_task = get_push_task(src_rq);
 			} else {
-				deactivate_task(src_rq, p, 0);
-				set_task_cpu(p, this_cpu);
-				activate_task(this_rq, p, 0);
+				push_task_chain(src_rq, this_rq, p);
 				resched = true;
 			}
 			/*
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 1c832516b7e8..3a80cc4278ca 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2366,7 +2366,7 @@ extern void set_cpus_allowed_common(struct task_struct *p, struct affinity_conte
 
 static inline struct task_struct *get_push_task(struct rq *rq)
 {
-	struct task_struct *p = rq->curr;
+	struct task_struct *p = rq_selected(rq);
 
 	lockdep_assert_rq_held(rq);
 
@@ -3530,4 +3530,10 @@ static inline void task_tick_mm_cid(struct rq *rq, struct task_struct *curr) { }
 static inline void init_sched_mm_cid(struct task_struct *t) { }
 #endif
 
+#ifdef CONFIG_SMP
+void push_task_chain(struct rq *rq, struct rq *dst_rq, struct task_struct *task);
+struct task_struct *find_exec_ctx(struct rq *rq, struct task_struct *p);
+int pushable_chain(struct rq *rq, struct task_struct *p, int cpu);
+#endif
+
 #endif /* _KERNEL_SCHED_SCHED_H */
-- 
2.41.0.rc0.172.g3f132b7071-goog

