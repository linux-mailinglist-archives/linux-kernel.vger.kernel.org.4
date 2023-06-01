Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5602D7192DE
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 08:00:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231814AbjFAGAJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 02:00:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231629AbjFAF71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 01:59:27 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C935D1B0
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 22:59:12 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id 98e67ed59e1d1-256563a2097so66872a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 22:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685599152; x=1688191152;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xZN524CJUN5e0Pirf1W/KYPONg/g1WvIzNM3xlIxz/U=;
        b=bSYfIXe7m/IE0UNiNuUBMzCfB5MDvm8b1ebK+0UEs8877FvniZ2NqYD9JCqUQ36qET
         Vqh9PMxRsyrXIYDSuaeeTKtOcYcWlajLfXYBvQ6gnFjP4gUaJ4xpVbXvvscm+8GoUyCZ
         R8LW0VmJ2GRx7EOMj5QMvQn4c+aZ0+yxWN+mI8JOskmcij0uGPbQlYuzomSzcnoZrE4l
         iEdX82pARhBO5bvfF6vj7yHVRPl0nS29WayEAIBd9oj8rtaGENQUoPIbPuuRx0nOK/nq
         ityxi9AtWiM4guyXdgOJ1HYZY34Ld0i2yVBDIFBeF2/0CUC4osCrEXO37ytgi6iQ+FQL
         6IlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685599152; x=1688191152;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xZN524CJUN5e0Pirf1W/KYPONg/g1WvIzNM3xlIxz/U=;
        b=WA+q9d/2Yb/UGlciuQJiSi2FpwIuLb/xvOk/HkJiGvj1elBEYGZ787jQBeV9iR0rqG
         ennJ7xVS8y1lYuSw7KXJ8B5a8GTgzf+LuCnlpQONvT82xZNk6TlZRy7Z3AIpPiBo2gg0
         G5Ov0vjoHwPL7VekG3ikoenm/ouGQ0XnCoKWU0UJIENI+QLQqPQfvX5CYRi6H3rgqVsW
         Bq/6lMpjlwtKWog1XO8MDf0pWuOshhZAHlwVm04yVKji0v5PV4DxQ+UqQPDeNroICGxt
         0Qchmq0m5Psg4/oPO3iF+TxMH8MHG7Y5UsgBmID+ekK0FBKhICpdoxtwQw9XoXrw3c/+
         /Egg==
X-Gm-Message-State: AC+VfDwyxiD8CgXWtZR4gL6/YWMgeAiBV/Q8zfSm6x/W64O5WDZ4c1zv
        MggtyBmminspEAqLiAexS+TzisbN6MNTjG12+kw8bYOPwFJmo2uLKP5s6xuw5P3EnMVZi+7Tkqm
        Mzw/OrgqfAxN85zDHY1x/WFZROq+0FtETtWIcJv8hka0N0DAhi65PvZrU/7qlIMR5RCC2gww=
X-Google-Smtp-Source: ACHHUZ6d3Qe+CEnMzvuwJJSVIB+/3eCiXc9f+aRgBuS3eSm/+5LXmq1FxELSNekU3xdrf15r0yayt3Muwg8Q
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a17:903:449:b0:1b0:410e:906f with SMTP id
 iw9-20020a170903044900b001b0410e906fmr1811508plb.0.1685599152064; Wed, 31 May
 2023 22:59:12 -0700 (PDT)
Date:   Thu,  1 Jun 2023 05:58:12 +0000
In-Reply-To: <20230601055846.2349566-1-jstultz@google.com>
Mime-Version: 1.0
References: <20230601055846.2349566-1-jstultz@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Message-ID: <20230601055846.2349566-10-jstultz@google.com>
Subject: [PATCH v4 09/13] sched: Add proxy execution
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
        Youssef Esmat <youssefesmat@google.com>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>, kernel-team@android.com,
        Valentin Schneider <valentin.schneider@arm.com>,
        "Connor O'Brien" <connoro@google.com>,
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

From: Peter Zijlstra <peterz@infradead.org>

The classic solution to priority-inversion is priority-
inheritance, which the kernel supports via the rt_mutex.

However, priority-inheritance only really works for interactions
between RT tasks and lower-priority tasks (RT or OTHER), as it
utilizes RT's strict priority ordering. With CFS and DEADLINE
classes, the next task chosen by the scheduler does not use a
linear priority ordering. So a more general solution is needed.

Proxy Execution provides just that: It allows mutex owner to be
run using the entire scheduling-context of tasks that are blocked
waiting on that mutex.

The basic mechanism is implemented by this patch, the core of
which resides in the proxy() function. Tasks blocked on mutexes
are not dequeued, so, if one of them is selected by schedule()
as the next task to be run on a CPU, proxy() is used to walk the
blocked_on relation and find a proxy task (a lock owner) to run
on the lock-waiters behalf (utilizing the lock-waiters
scheduling context).

This can be thought of as similar to rt_mutex priority-
inheritance, but utilizes the scheduler's pick_next_task()
function to determine the most important task to run next, (from
the set of runnable *and* mutex blocked tasks) rather then a
integer priority value. Then the proxy() function finds a
dependent lock owner to run, effecively boosting it by running
with the selected tasks scheduler context.

Here come the tricky bits. In fact, the owner task might be in
all sort of states when a proxy is found (blocked, executing on
a different CPU, etc.). Details on how to handle different
situations are to be found in proxy() code comments.

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
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
[rebased, added comments and changelog]
Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
[Fixed rebase conflicts]
[squashed sched: Ensure blocked_on is always guarded by blocked_lock]
Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
[fix rebase conflicts, various fixes & tweaks commented inline]
[squashed sched: Use rq->curr vs rq->proxy checks]
Signed-off-by: Connor O'Brien <connoro@google.com>
[jstultz: Rebased, split up, and folded in changes from Juri
 Lelli and Connor O'Brian, added additional locking on
 get_task_blocked_on(next) logic, pretty major rework to better
 conditionalize logic on CONFIG_PROXY_EXEC and split up the very
 large proxy() function - hopefully without changes to logic /
 behavior]
Signed-off-by: John Stultz <jstultz@google.com>
---
v2:
* Numerous changes folded in
* Split out some of the logic into separate patches
* Break up the proxy() function so its a bit easier to read
  and is better conditionalized on CONFIG_PROXY_EXEC
v3:
* Improve comments
* Added fix to call __balance_callbacks before we call
  pick_next_task() again, as a callback may have been set
  causing rq_pin_lock to generate warnings.
* Added fix to call __balance_callbacks before we drop
  the rq lock in proxy_migrate_task, to avoid rq_pin_lock
  from generating warnings if a callback was set
v4:
* Rename blocked_proxy -> blocked_donor to clarify relationship
* Fix null ptr deref at end of proxy()
* Fix null ptr deref in ttwu_proxy_skip_wakeup()  path
* Remove verbose comments/questions to avoid review
  distractions, as suggested by Dietmar
* Reword and expand commit message to provide more detailed
  context on how the idea works.
* Minor rebase for moving *_task_blocked_on() wrappers to be
  a later add on to the main patch series.

TODO: Finish conditionalization edge cases
---
 include/linux/sched.h   |   2 +
 init/Kconfig            |   7 +
 kernel/Kconfig.locks    |   2 +-
 kernel/fork.c           |   2 +
 kernel/locking/mutex.c  |  37 ++-
 kernel/sched/core.c     | 525 +++++++++++++++++++++++++++++++++++++++-
 kernel/sched/deadline.c |   2 +-
 kernel/sched/fair.c     |   9 +-
 kernel/sched/rt.c       |   3 +-
 kernel/sched/sched.h    |  20 +-
 10 files changed, 594 insertions(+), 15 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 6b0d4b398b31..8ac9db6ca747 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1141,7 +1141,9 @@ struct task_struct {
 	struct rt_mutex_waiter		*pi_blocked_on;
 #endif
 
+	struct task_struct		*blocked_donor;	/* task that is boosting us */
 	struct mutex			*blocked_on;	/* lock we're blocked on */
+	struct list_head		blocked_entry;  /* tasks blocked on us */
 	raw_spinlock_t			blocked_lock;
 
 #ifdef CONFIG_DEBUG_ATOMIC_SLEEP
diff --git a/init/Kconfig b/init/Kconfig
index 32c24950c4ce..43abaffc7dfa 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -907,6 +907,13 @@ config NUMA_BALANCING_DEFAULT_ENABLED
 	  If set, automatic NUMA balancing will be enabled if running on a NUMA
 	  machine.
 
+config PROXY_EXEC
+	bool "Proxy Execution"
+	default n
+	help
+	  This option enables proxy execution, a mechanism for mutex owning
+	  tasks to inherit the scheduling context of higher priority waiters.
+
 menuconfig CGROUPS
 	bool "Control Group support"
 	select KERNFS
diff --git a/kernel/Kconfig.locks b/kernel/Kconfig.locks
index 4198f0273ecd..791c98f1d329 100644
--- a/kernel/Kconfig.locks
+++ b/kernel/Kconfig.locks
@@ -226,7 +226,7 @@ config ARCH_SUPPORTS_ATOMIC_RMW
 
 config MUTEX_SPIN_ON_OWNER
 	def_bool y
-	depends on SMP && ARCH_SUPPORTS_ATOMIC_RMW
+	depends on SMP && ARCH_SUPPORTS_ATOMIC_RMW && !PROXY_EXEC
 
 config RWSEM_SPIN_ON_OWNER
        def_bool y
diff --git a/kernel/fork.c b/kernel/fork.c
index 1ea1b2d527bb..2451eb8bcfe7 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2462,7 +2462,9 @@ __latent_entropy struct task_struct *copy_process(
 	lockdep_init_task(p);
 #endif
 
+	p->blocked_donor = NULL; /* nobody is boosting us yet */
 	p->blocked_on = NULL; /* not blocked yet */
+	INIT_LIST_HEAD(&p->blocked_entry);
 
 #ifdef CONFIG_BCACHE
 	p->sequential_io	= 0;
diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index 8c9f9dffe473..eabfd66ce224 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -905,11 +905,13 @@ static noinline void __sched __mutex_unlock_slowpath(struct mutex *lock, unsigne
 {
 	struct task_struct *next = NULL;
 	DEFINE_WAKE_Q(wake_q);
-	unsigned long owner;
+	/* Always force HANDOFF for Proxy Exec for now. Revisit. */
+	unsigned long owner = MUTEX_FLAG_HANDOFF;
 	unsigned long flags;
 
 	mutex_release(&lock->dep_map, ip);
 
+#ifndef CONFIG_PROXY_EXEC
 	/*
 	 * Release the lock before (potentially) taking the spinlock such that
 	 * other contenders can get on with things ASAP.
@@ -932,10 +934,38 @@ static noinline void __sched __mutex_unlock_slowpath(struct mutex *lock, unsigne
 			return;
 		}
 	}
+#endif
 
 	raw_spin_lock_irqsave(&lock->wait_lock, flags);
 	debug_mutex_unlock(lock);
-	if (!list_empty(&lock->wait_list)) {
+
+#ifdef CONFIG_PROXY_EXEC
+	raw_spin_lock(&current->blocked_lock);
+	/*
+	 * If we have a task boosting us, and that task was boosting us through
+	 * this lock, hand the lock to that task, as that is the highest
+	 * waiter, as selected by the scheduling function.
+	 */
+	next = current->blocked_donor;
+	if (next) {
+		struct mutex *next_lock;
+
+		raw_spin_lock_nested(&next->blocked_lock, SINGLE_DEPTH_NESTING);
+		next_lock = next->blocked_on;
+		raw_spin_unlock(&next->blocked_lock);
+		if (next_lock != lock) {
+			next = NULL;
+		} else {
+			wake_q_add(&wake_q, next);
+			current->blocked_donor = NULL;
+		}
+	}
+#endif
+
+	/*
+	 * Failing that, pick any on the wait list.
+	 */
+	if (!next && !list_empty(&lock->wait_list)) {
 		/* get the first entry from the wait-list: */
 		struct mutex_waiter *waiter =
 			list_first_entry(&lock->wait_list,
@@ -951,6 +981,9 @@ static noinline void __sched __mutex_unlock_slowpath(struct mutex *lock, unsigne
 		__mutex_handoff(lock, next);
 
 	preempt_disable();
+#ifdef CONFIG_PROXY_EXEC
+	raw_spin_unlock(&current->blocked_lock);
+#endif
 	raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
 
 	wake_up_q(&wake_q);
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 3dce69feb934..328776421c7a 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -95,6 +95,7 @@
 #include "../workqueue_internal.h"
 #include "../../io_uring/io-wq.h"
 #include "../smpboot.h"
+#include "../locking/mutex.h"
 
 EXPORT_TRACEPOINT_SYMBOL_GPL(ipi_send_cpu);
 EXPORT_TRACEPOINT_SYMBOL_GPL(ipi_send_cpumask);
@@ -2799,8 +2800,15 @@ static int affine_move_task(struct rq *rq, struct task_struct *p, struct rq_flag
 	struct set_affinity_pending my_pending = { }, *pending = NULL;
 	bool stop_pending, complete = false;
 
-	/* Can the task run on the task's current CPU? If so, we're done */
-	if (cpumask_test_cpu(task_cpu(p), &p->cpus_mask)) {
+	/*
+	 * Can the task run on the task's current CPU? If so, we're done
+	 *
+	 * We are also done if the task is selected, boosting a lock-
+	 * holding proxy, (and potentially has been migrated outside its
+	 * current or previous affinity mask)
+	 */
+	if (cpumask_test_cpu(task_cpu(p), &p->cpus_mask) ||
+	    (task_current_selected(rq, p) && !task_current(rq, p))) {
 		struct task_struct *push_task = NULL;
 
 		if ((flags & SCA_MIGRATE_ENABLE) &&
@@ -3713,6 +3721,54 @@ static inline void ttwu_do_wakeup(struct task_struct *p)
 	trace_sched_wakeup(p);
 }
 
+#ifdef CONFIG_PROXY_EXEC
+static void activate_task_and_blocked_ent(struct rq *rq, struct task_struct *p, int en_flags)
+{
+	/*
+	 * By calling activate_task with blocked_lock held, we order against
+	 * the proxy() blocked_task case such that no more blocked tasks will
+	 * be enqueued on p once we release p->blocked_lock.
+	 */
+	raw_spin_lock(&p->blocked_lock);
+	activate_task(rq, p, en_flags);
+	raw_spin_unlock(&p->blocked_lock);
+
+	/*
+	 * A whole bunch of 'proxy' tasks back this blocked task, wake
+	 * them all up to give this task its 'fair' share.
+	 */
+	while (!list_empty(&p->blocked_entry)) {
+		struct task_struct *pp =
+			list_first_entry(&p->blocked_entry,
+					 struct task_struct,
+					 blocked_entry);
+		raw_spin_lock(&pp->blocked_lock);
+		BUG_ON(pp->blocked_entry.prev != &p->blocked_entry);
+
+		list_del_init(&pp->blocked_entry);
+		if (READ_ONCE(pp->on_rq)) {
+			/*
+			 * We raced with a non mutex handoff activation of pp.
+			 * That activation will also take care of activating
+			 * all of the tasks after pp in the blocked_entry list,
+			 * so we're done here.
+			 */
+			raw_spin_unlock(&pp->blocked_lock);
+			break;
+		}
+		__set_task_cpu(pp, cpu_of(rq));
+		activate_task(rq, pp, en_flags);
+		resched_curr(rq);
+		raw_spin_unlock(&pp->blocked_lock);
+	}
+}
+#else
+static inline void activate_task_and_blocked_ent(struct rq *rq, struct task_struct *p, int en_flags)
+{
+	activate_task(rq, p, en_flags);
+}
+#endif
+
 static void
 ttwu_do_activate(struct rq *rq, struct task_struct *p, int wake_flags,
 		 struct rq_flags *rf)
@@ -3734,7 +3790,8 @@ ttwu_do_activate(struct rq *rq, struct task_struct *p, int wake_flags,
 		atomic_dec(&task_rq(p)->nr_iowait);
 	}
 
-	activate_task(rq, p, en_flags);
+	activate_task_and_blocked_ent(rq, p, en_flags);
+
 	check_preempt_curr(rq, p, wake_flags);
 
 	ttwu_do_wakeup(p);
@@ -3767,6 +3824,75 @@ ttwu_do_activate(struct rq *rq, struct task_struct *p, int wake_flags,
 #endif
 }
 
+#ifdef CONFIG_PROXY_EXEC
+bool ttwu_proxy_skip_wakeup(struct rq *rq, struct task_struct *p)
+{
+	if (task_current(rq, p)) {
+		bool ret = true;
+
+		raw_spin_lock(&p->blocked_lock);
+		if (task_is_blocked(p) && __mutex_owner(p->blocked_on) == p)
+			p->blocked_on = NULL;
+		if (!task_is_blocked(p))
+			ret = false;
+		raw_spin_unlock(&p->blocked_lock);
+		return ret;
+	}
+
+	/*
+	 * Since we don't dequeue for blocked-on relations, we'll always
+	 * trigger the on_rq_queued() clause for them.
+	 */
+	if (task_is_blocked(p)) {
+		raw_spin_lock(&p->blocked_lock);
+
+		if (!p->blocked_on || __mutex_owner(p->blocked_on) != p) {
+			/*
+			 * p already woke, ran and blocked on another mutex.
+			 * Since a successful wakeup already happened, we're
+			 * done.
+			 */
+			raw_spin_unlock(&p->blocked_lock);
+			return true;
+		}
+
+		p->blocked_on = NULL;
+		if (!cpumask_test_cpu(cpu_of(rq), p->cpus_ptr)) {
+			/*
+			 * proxy stuff moved us outside of the affinity mask
+			 * 'sleep' now and fail the direct wakeup so that the
+			 * normal wakeup path will fix things.
+			 */
+			deactivate_task(rq, p, DEQUEUE_SLEEP | DEQUEUE_NOCLOCK);
+			if (task_current_selected(rq, p)) {
+				/*
+				 * If p is the proxy, then remove lingering
+				 * references to it from rq and sched_class structs after
+				 * dequeueing.
+				 */
+				put_prev_task(rq, p);
+				rq_set_selected(rq, rq->idle);
+			}
+			resched_curr(rq);
+			raw_spin_unlock(&p->blocked_lock);
+			return true;
+		}
+		/*
+		 * Must resched after killing a blocked_on relation. The currently
+		 * executing context might not be the most elegible anymore.
+		 */
+		resched_curr(rq);
+		raw_spin_unlock(&p->blocked_lock);
+	}
+	return false;
+}
+#else
+static inline bool ttwu_proxy_skip_wakeup(struct rq *rq, struct task_struct *p)
+{
+	return false;
+}
+#endif
+
 /*
  * Consider @p being inside a wait loop:
  *
@@ -3799,9 +3925,15 @@ static int ttwu_runnable(struct task_struct *p, int wake_flags)
 	int ret = 0;
 
 	rq = __task_rq_lock(p, &rf);
-	if (!task_on_rq_queued(p))
+	if (!task_on_rq_queued(p)) {
+		BUG_ON(task_is_running(p));
 		goto out_unlock;
+	}
 
+	/*
+	 * ttwu_do_wakeup()->
+	 *   check_preempt_curr() may use rq clock
+	 */
 	if (!task_on_cpu(rq, p)) {
 		/*
 		 * When on_rq && !on_cpu the task is preempted, see if
@@ -3810,8 +3942,13 @@ static int ttwu_runnable(struct task_struct *p, int wake_flags)
 		update_rq_clock(rq);
 		check_preempt_curr(rq, p, wake_flags);
 	}
+
+	if (ttwu_proxy_skip_wakeup(rq, p))
+		goto out_unlock;
+
 	ttwu_do_wakeup(p);
 	ret = 1;
+
 out_unlock:
 	__task_rq_unlock(rq, &rf);
 
@@ -4225,6 +4362,11 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
 	if (READ_ONCE(p->on_rq) && ttwu_runnable(p, wake_flags))
 		goto unlock;
 
+	if (task_is_blocked(p)) {
+		success = 0;
+		goto unlock;
+	}
+
 #ifdef CONFIG_SMP
 	/*
 	 * Ensure we load p->on_cpu _after_ p->on_rq, otherwise it would be
@@ -5620,6 +5762,15 @@ void scheduler_tick(void)
 
 	rq_lock(rq, &rf);
 
+#ifdef CONFIG_PROXY_EXEC
+	if (task_cpu(curr) != cpu) {
+		BUG_ON(!test_preempt_need_resched() &&
+		       !tif_need_resched());
+		rq_unlock(rq, &rf);
+		return;
+	}
+#endif
+
 	update_rq_clock(rq);
 	thermal_pressure = arch_scale_thermal_pressure(cpu_of(rq));
 	update_thermal_load_avg(rq_clock_thermal(rq), rq, thermal_pressure);
@@ -6520,6 +6671,332 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 # define SM_MASK_PREEMPT	SM_PREEMPT
 #endif
 
+#ifdef CONFIG_PROXY_EXEC
+
+static struct task_struct *
+proxy_migrate_task(struct rq *rq, struct task_struct *next,
+		   struct rq_flags *rf, struct task_struct *p,
+		   int that_cpu, bool curr_in_chain)
+{
+	struct rq *that_rq;
+	LIST_HEAD(migrate_list);
+
+	/*
+	 * If the blocked-on relationship crosses CPUs, migrate @p to the
+	 * @owner's CPU.
+	 *
+	 * This is because we must respect the CPU affinity of execution
+	 * contexts (@owner) but we can ignore affinity for scheduling
+	 * contexts (@p). So we have to move scheduling contexts towards
+	 * potential execution contexts.
+	 */
+	that_rq = cpu_rq(that_cpu);
+
+	/*
+	 * @owner can disappear, simply migrate to @that_cpu and leave that CPU
+	 * to sort things out.
+	 */
+
+	/*
+	 * Since we're going to drop @rq, we have to put(@next) first,
+	 * otherwise we have a reference that no longer belongs to us.  Use
+	 * @fake_task to fill the void and make the next pick_next_task()
+	 * invocation happy.
+	 *
+	 * CPU0				CPU1
+	 *
+	 *				B mutex_lock(X)
+	 *
+	 * A mutex_lock(X) <- B
+	 * A __schedule()
+	 * A pick->A
+	 * A proxy->B
+	 * A migrate A to CPU1
+	 *				B mutex_unlock(X) -> A
+	 *				B __schedule()
+	 *				B pick->A
+	 *				B switch_to (A)
+	 *				A ... does stuff
+	 * A ... is still running here
+	 *
+	 *		* BOOM *
+	 */
+	put_prev_task(rq, next);
+	if (curr_in_chain) {
+		rq_set_selected(rq, rq->idle);
+		set_tsk_need_resched(rq->idle);
+		return rq->idle;
+	}
+	rq_set_selected(rq, rq->idle);
+
+	for (; p; p = p->blocked_donor) {
+		int wake_cpu = p->wake_cpu;
+
+		WARN_ON(p == rq->curr);
+
+		deactivate_task(rq, p, 0);
+		set_task_cpu(p, that_cpu);
+		/*
+		 * We can abuse blocked_entry to migrate the thing,
+		 * because @p is still on the rq.
+		 */
+		list_add(&p->blocked_entry, &migrate_list);
+
+		/*
+		 * Preserve p->wake_cpu, such that we can tell where it
+		 * used to run later.
+		 */
+		p->wake_cpu = wake_cpu;
+	}
+
+	if (rq->balance_callback)
+		__balance_callbacks(rq);
+
+	rq_unpin_lock(rq, rf);
+	raw_spin_rq_unlock(rq);
+	raw_spin_rq_lock(that_rq);
+
+	while (!list_empty(&migrate_list)) {
+		p = list_first_entry(&migrate_list, struct task_struct, blocked_entry);
+		list_del_init(&p->blocked_entry);
+
+		enqueue_task(that_rq, p, 0);
+		check_preempt_curr(that_rq, p, 0);
+		p->on_rq = TASK_ON_RQ_QUEUED;
+	}
+
+	raw_spin_rq_unlock(that_rq);
+	raw_spin_rq_lock(rq);
+	rq_repin_lock(rq, rf);
+
+	return NULL; /* Retry task selection on _this_ CPU. */
+}
+
+static inline struct task_struct *
+proxy_resched_idle(struct rq *rq, struct task_struct *next)
+{
+	put_prev_task(rq, next);
+	rq_set_selected(rq, rq->idle);
+	set_tsk_need_resched(rq->idle);
+	return rq->idle;
+}
+
+static void proxy_enqueue_on_owner(struct rq *rq, struct task_struct *p,
+				   struct task_struct *owner,
+				   struct task_struct *next)
+{
+	/*
+	 * Walk back up the blocked_donor relation and enqueue them all on @owner
+	 *
+	 * ttwu_activate() will pick them up and place them on whatever rq
+	 * @owner will run next.
+	 */
+	if (!owner->on_rq) {
+		for (; p; p = p->blocked_donor) {
+			if (p == owner)
+				continue;
+			BUG_ON(!p->on_rq);
+			deactivate_task(rq, p, DEQUEUE_SLEEP);
+			if (task_current_selected(rq, p)) {
+				put_prev_task(rq, next);
+				rq_set_selected(rq, rq->idle);
+			}
+			/*
+			 * ttwu_do_activate must not have a chance to activate p
+			 * elsewhere before it's fully extricated from its old rq.
+			 */
+			smp_mb();
+			list_add(&p->blocked_entry, &owner->blocked_entry);
+		}
+	}
+}
+
+/*
+ * Find who @next (currently blocked on a mutex) can proxy for.
+ *
+ * Follow the blocked-on relation:
+ *
+ *                ,-> task
+ *                |     | blocked-on
+ *                |     v
+ *  blocked_donor |   mutex
+ *                |     | owner
+ *                |     v
+ *                `-- task
+ *
+ * and set the blocked_donor relation, this latter is used by the mutex
+ * code to find which (blocked) task to hand-off to.
+ *
+ * Lock order:
+ *
+ *   p->pi_lock
+ *     rq->lock
+ *       mutex->wait_lock
+ *         p->blocked_lock
+ *
+ * Returns the task that is going to be used as execution context (the one
+ * that is actually going to be put to run on cpu_of(rq)).
+ */
+static struct task_struct *
+proxy(struct rq *rq, struct task_struct *next, struct rq_flags *rf)
+{
+	struct task_struct *p = next;
+	struct task_struct *owner = NULL;
+	bool curr_in_chain = false;
+	int this_cpu, that_cpu;
+	struct mutex *mutex;
+
+	this_cpu = cpu_of(rq);
+
+	/*
+	 * Follow blocked_on chain.
+	 *
+	 * TODO: deadlock detection
+	 */
+	for (p = next; p->blocked_on; p = owner) {
+		mutex = p->blocked_on;
+		/* Something changed in the chain, pick_again */
+		if (!mutex)
+			return NULL;
+
+		/*
+		 * By taking mutex->wait_lock we hold off concurrent mutex_unlock()
+		 * and ensure @owner sticks around.
+		 */
+		raw_spin_lock(&mutex->wait_lock);
+		raw_spin_lock(&p->blocked_lock);
+
+		/* Check again that p is blocked with blocked_lock held */
+		if (!task_is_blocked(p) || mutex != p->blocked_on) {
+			/*
+			 * Something changed in the blocked_on chain and
+			 * we don't know if only at this level. So, let's
+			 * just bail out completely and let __schedule
+			 * figure things out (pick_again loop).
+			 */
+			raw_spin_unlock(&p->blocked_lock);
+			raw_spin_unlock(&mutex->wait_lock);
+			return NULL;
+		}
+
+		if (task_current(rq, p))
+			curr_in_chain = true;
+
+		owner = __mutex_owner(mutex);
+		if (task_cpu(owner) != this_cpu) {
+			that_cpu = task_cpu(owner);
+			/*
+			 * @owner can disappear, simply migrate to @that_cpu and leave that CPU
+			 * to sort things out.
+			 */
+			raw_spin_unlock(&p->blocked_lock);
+			raw_spin_unlock(&mutex->wait_lock);
+
+			return proxy_migrate_task(rq, next, rf, p, that_cpu, curr_in_chain);
+		}
+
+		if (task_on_rq_migrating(owner)) {
+			/*
+			 * One of the chain of mutex owners is currently migrating to this
+			 * CPU, but has not yet been enqueued because we are holding the
+			 * rq lock. As a simple solution, just schedule rq->idle to give
+			 * the migration a chance to complete. Much like the migrate_task
+			 * case we should end up back in proxy(), this time hopefully with
+			 * all relevant tasks already enqueued.
+			 */
+			raw_spin_unlock(&p->blocked_lock);
+			raw_spin_unlock(&mutex->wait_lock);
+			return proxy_resched_idle(rq, next);
+		}
+
+		if (!owner->on_rq) {
+			/*
+			 * rq->curr must not be added to the blocked_entry list or else
+			 * ttwu_do_activate could enqueue it elsewhere before it switches
+			 * out here. The approach to avoiding this is the same as in the
+			 * migrate_task case.
+			 */
+			if (curr_in_chain) {
+				raw_spin_unlock(&p->blocked_lock);
+				raw_spin_unlock(&mutex->wait_lock);
+				return proxy_resched_idle(rq, next);
+			}
+
+			/*
+			 * If !@owner->on_rq, holding @rq->lock will not pin the task,
+			 * so we cannot drop @mutex->wait_lock until we're sure its a blocked
+			 * task on this rq.
+			 *
+			 * We use @owner->blocked_lock to serialize against ttwu_activate().
+			 * Either we see its new owner->on_rq or it will see our list_add().
+			 */
+			if (owner != p) {
+				raw_spin_unlock(&p->blocked_lock);
+				raw_spin_lock(&owner->blocked_lock);
+			}
+
+			proxy_enqueue_on_owner(rq, p, owner, next);
+
+			if (task_current_selected(rq, next)) {
+				put_prev_task(rq, next);
+				rq_set_selected(rq, rq->idle);
+			}
+			raw_spin_unlock(&owner->blocked_lock);
+			raw_spin_unlock(&mutex->wait_lock);
+
+			return NULL; /* retry task selection */
+		}
+
+		if (owner == p) {
+			/*
+			 * Its possible we interleave with mutex_unlock like:
+			 *
+			 *				lock(&rq->lock);
+			 *				  proxy()
+			 * mutex_unlock()
+			 *   lock(&wait_lock);
+			 *   next(owner) = current->blocked_donor;
+			 *   unlock(&wait_lock);
+			 *
+			 *   wake_up_q();
+			 *     ...
+			 *       ttwu_runnable()
+			 *         __task_rq_lock()
+			 *				  lock(&wait_lock);
+			 *				  owner == p
+			 *
+			 * Which leaves us to finish the ttwu_runnable() and make it go.
+			 *
+			 * So schedule rq->idle so that ttwu_runnable can get the rq lock
+			 * and mark owner as running.
+			 */
+			raw_spin_unlock(&p->blocked_lock);
+			raw_spin_unlock(&mutex->wait_lock);
+			return proxy_resched_idle(rq, next);
+		}
+
+		/*
+		 * OK, now we're absolutely sure @owner is not blocked _and_
+		 * on this rq, therefore holding @rq->lock is sufficient to
+		 * guarantee its existence, as per ttwu_remote().
+		 */
+		raw_spin_unlock(&p->blocked_lock);
+		raw_spin_unlock(&mutex->wait_lock);
+
+		owner->blocked_donor = p;
+	}
+
+	WARN_ON_ONCE(owner && !owner->on_rq);
+	return owner;
+}
+#else /* PROXY_EXEC */
+static struct task_struct *
+proxy(struct rq *rq, struct task_struct *next, struct rq_flags *rf)
+{
+	return next;
+}
+#endif /* PROXY_EXEC */
+
 /*
  * __schedule() is the main scheduler function.
  *
@@ -6567,6 +7044,7 @@ static void __sched notrace __schedule(unsigned int sched_mode)
 	struct rq_flags rf;
 	struct rq *rq;
 	int cpu;
+	bool preserve_need_resched = false;
 
 	cpu = smp_processor_id();
 	rq = cpu_rq(cpu);
@@ -6612,7 +7090,7 @@ static void __sched notrace __schedule(unsigned int sched_mode)
 	if (!(sched_mode & SM_MASK_PREEMPT) && prev_state) {
 		if (signal_pending_state(prev_state, prev)) {
 			WRITE_ONCE(prev->__state, TASK_RUNNING);
-		} else {
+		} else if (!task_is_blocked(prev)) {
 			prev->sched_contributes_to_load =
 				(prev_state & TASK_UNINTERRUPTIBLE) &&
 				!(prev_state & TASK_NOLOAD) &&
@@ -6638,13 +7116,43 @@ static void __sched notrace __schedule(unsigned int sched_mode)
 				atomic_inc(&rq->nr_iowait);
 				delayacct_blkio_start();
 			}
+		} else {
+			/*
+			 * Let's make this task, which is blocked on
+			 * a mutex, (push/pull)able (RT/DL).
+			 * Unfortunately we can only deal with that by
+			 * means of a dequeue/enqueue cycle. :-/
+			 */
+			dequeue_task(rq, prev, 0);
+			enqueue_task(rq, prev, 0);
 		}
 		switch_count = &prev->nvcsw;
 	}
 
-	next = pick_next_task(rq, prev, &rf);
+pick_again:
+	/*
+	 * If picked task is actually blocked it means that it can act as a
+	 * proxy for the task that is holding the mutex picked task is blocked
+	 * on. Get a reference to the blocked (going to be proxy) task here.
+	 * Note that if next isn't actually blocked we will have rq->proxy ==
+	 * rq->curr == next in the end, which is intended and means that proxy
+	 * execution is currently "not in use".
+	 */
+	next = pick_next_task(rq, rq_selected(rq), &rf);
 	rq_set_selected(rq, next);
-	clear_tsk_need_resched(prev);
+	next->blocked_donor = NULL;
+	if (unlikely(task_is_blocked(next))) {
+		next = proxy(rq, next, &rf);
+		if (!next) {
+			__balance_callbacks(rq);
+			goto pick_again;
+		}
+		if (next == rq->idle && prev == rq->idle)
+			preserve_need_resched = true;
+	}
+
+	if (!preserve_need_resched)
+		clear_tsk_need_resched(prev);
 	clear_preempt_need_resched();
 #ifdef CONFIG_SCHED_DEBUG
 	rq->last_seen_need_resched_ns = 0;
@@ -6731,6 +7239,9 @@ static inline void sched_submit_work(struct task_struct *tsk)
 	 */
 	SCHED_WARN_ON(current->__state & TASK_RTLOCK_WAIT);
 
+	if (task_is_blocked(tsk))
+		return;
+
 	/*
 	 * If we are going to sleep and we have plugged IO queued,
 	 * make sure to submit it to avoid deadlocks.
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index d41d562df078..1d2711aee448 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1740,7 +1740,7 @@ static void enqueue_task_dl(struct rq *rq, struct task_struct *p, int flags)
 
 	enqueue_dl_entity(&p->dl, flags);
 
-	if (!task_current(rq, p) && p->nr_cpus_allowed > 1)
+	if (!task_current(rq, p) && p->nr_cpus_allowed > 1 && !task_is_blocked(p))
 		enqueue_pushable_dl_task(rq, p);
 }
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 62c3c1762004..43efc576d2c6 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8023,7 +8023,9 @@ pick_next_task_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf
 		goto idle;
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
-	if (!prev || prev->sched_class != &fair_sched_class)
+	if (!prev ||
+	    prev->sched_class != &fair_sched_class ||
+	    rq->curr != rq_selected(rq))
 		goto simple;
 
 	/*
@@ -8541,6 +8543,9 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
 
 	lockdep_assert_rq_held(env->src_rq);
 
+	if (task_is_blocked(p))
+		return 0;
+
 	/*
 	 * We do not migrate tasks that are:
 	 * 1) throttled_lb_pair, or
@@ -8591,7 +8596,7 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
 	/* Record that we found at least one task that could run on dst_cpu */
 	env->flags &= ~LBF_ALL_PINNED;
 
-	if (task_on_cpu(env->src_rq, p)) {
+	if (task_on_cpu(env->src_rq, p) || task_current_selected(env->src_rq, p)) {
 		schedstat_inc(p->stats.nr_failed_migrations_running);
 		return 0;
 	}
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 3ba24c3fce20..f5b1075e8170 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1537,7 +1537,8 @@ enqueue_task_rt(struct rq *rq, struct task_struct *p, int flags)
 
 	enqueue_rt_entity(rt_se, flags);
 
-	if (!task_current(rq, p) && p->nr_cpus_allowed > 1)
+	if (!task_current(rq, p) && p->nr_cpus_allowed > 1 &&
+	    !task_is_blocked(p))
 		enqueue_pushable_task(rq, p);
 }
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 29597a6fd65b..1c832516b7e8 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2106,6 +2106,19 @@ static inline int task_current_selected(struct rq *rq, struct task_struct *p)
 	return rq_selected(rq) == p;
 }
 
+#ifdef CONFIG_PROXY_EXEC
+static inline bool task_is_blocked(struct task_struct *p)
+{
+	return !!p->blocked_on;
+}
+#else /* !PROXY_EXEC */
+static inline bool task_is_blocked(struct task_struct *p)
+{
+	return false;
+}
+
+#endif /* PROXY_EXEC */
+
 static inline int task_on_cpu(struct rq *rq, struct task_struct *p)
 {
 #ifdef CONFIG_SMP
@@ -2267,12 +2280,17 @@ struct sched_class {
 
 static inline void put_prev_task(struct rq *rq, struct task_struct *prev)
 {
-	WARN_ON_ONCE(rq_selected(rq) != prev);
+	WARN_ON_ONCE(rq->curr != prev && prev != rq_selected(rq));
+
+	if (prev == rq_selected(rq) && task_cpu(prev) != cpu_of(rq))
+		return;
+
 	prev->sched_class->put_prev_task(rq, prev);
 }
 
 static inline void set_next_task(struct rq *rq, struct task_struct *next)
 {
+	WARN_ON_ONCE(!task_current_selected(rq, next));
 	next->sched_class->set_next_task(rq, next, false);
 }
 
-- 
2.41.0.rc0.172.g3f132b7071-goog

