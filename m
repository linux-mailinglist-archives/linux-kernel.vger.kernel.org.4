Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD4DA5F3805
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 23:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbiJCVqK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 17:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbiJCVpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 17:45:34 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E35E91D0DE
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 14:45:17 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id z9-20020a17090a468900b00202fdb32ba1so5708228pjf.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Oct 2022 14:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=Ds0HvMSRFwQ1xDHngCWOAuo70Kk6lCv77UzINTpHkBM=;
        b=FGMrRqYJxCNCVJGiE038Q5guA7B0Q80pFQprKr4xcaIuYQG13sxVuQlv7oaBfEkaZt
         9dgSVPdFcOGlstikx7nvRQTASUhAwP86KHw+OPqDFUZav9+RyA9OMoCbO8k6o4j3Eg/T
         jJwJWQV+/fl2Y44W3Rb/D31h9GT+8+uPvQZk/NLive+u8NGfQvNH2f6j1NmGVypxNmLm
         42D2vhutDjIZTCFTy+RrUW0FU5B6UdBpR3MbrlFCxrjfP5RQOx/kLwGjar/EogiC4mGG
         e07ovA7hR/tQq5iaFVO+dgHM84BwAPinEAliwCs5A63maZdB3XCSadpSxDxhMwLAuh3L
         axWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=Ds0HvMSRFwQ1xDHngCWOAuo70Kk6lCv77UzINTpHkBM=;
        b=7qVHxJOOncQe/fejYTXzBT53p3moJGENLMTwNSbMiZZ4c0dk6HbE/YCq+u8hFltX/v
         RWJKLzml/rGCSETpLA+a81tFfVSuZIpEjGX2ogQ2523IEWc16G1rgMNmbCHWoXhfj4+q
         ZOncu7f25KzuA3t7eLxd0dYBuytU0ceOuk/EPdtbgicpfpgkSuYPI7MQIPAdDOR1W4LT
         12KCOA2U9tTA6in5NlcbdjT/DZiQFi/oWNgGRtpUHqZPiiKslym1jjxybhRgqhCFqMWm
         AzQjJGkT4IdlYtY+NDH1Fl9WVVi5otKd30Hj+Brur057/QKwoSy2lCHQ42uJiSQQ67Jq
         dpoA==
X-Gm-Message-State: ACrzQf0cYuU/10Qgq17DCQOT7v6IfAsvFMbOERTwsmDqyf5OpaH4ehGJ
        3M4yVy+dp83m1QRgCRrn/Bdvh2QX1SqxJzgmVC7vtmHwrZDR8PK+X8Y6IVSY+UXBMsi9O6t4SKe
        P9W5WsZ40NtZoTI5lK1e2Ii4hkf2Sl9AOIoH0hQVxpLgMPNmzuoaVnnpO7iqlEP9OrzVyrZC2
X-Google-Smtp-Source: AMsMyM7X+/W66bLszCgBt7LOjuAd0hdnH8ZvIcA5NIEYoSFUDwkMHUJ9KQKjiA81E/vDPTPMkhJ2xr4tgNUD
X-Received: from connoro.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:a99])
 (user=connoro job=sendgmr) by 2002:a05:6a00:cd6:b0:546:d03:3dd7 with SMTP id
 b22-20020a056a000cd600b005460d033dd7mr24423056pfv.19.1664833516058; Mon, 03
 Oct 2022 14:45:16 -0700 (PDT)
Date:   Mon,  3 Oct 2022 21:44:57 +0000
In-Reply-To: <20221003214501.2050087-1-connoro@google.com>
Mime-Version: 1.0
References: <20221003214501.2050087-1-connoro@google.com>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Message-ID: <20221003214501.2050087-8-connoro@google.com>
Subject: [RFC PATCH 07/11] sched: Add proxy execution
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

A task currently holding a mutex (executing a critical section) might
find benefit in using scheduling contexts of other tasks blocked on the
same mutex if they happen to have higher priority of the current owner
(e.g., to prevent priority inversions).

Proxy execution lets a task do exactly that: if a mutex owner has
waiters, it can use waiters' scheduling context to potentially continue
running if preempted.

The basic mechanism is implemented by this patch, the core of which
resides in the proxy() function. Potential proxies (i.e., tasks blocked
on a mutex) are not dequeued, so, if one of them is actually selected by
schedule() as the next task to be put to run on a CPU, proxy() is used
to walk the blocked_on relation and find which task (mutex owner) might
be able to use the proxy's scheduling context.

Here come the tricky bits. In fact, owner task might be in all sort of
states when a proxy is found (blocked, executing on a different CPU,
etc.). Details on how to handle different situations are to be found in
proxy() code comments.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
[rebased, added comments and changelog]
Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
[Fixed rebase conflicts]
[squashed sched: Ensure blocked_on is always guarded by blocked_lock]
Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
[fix rebase conflicts, various fixes & tweaks commented inline]
[squashed sched: Use rq->curr vs rq->proxy checks]
Signed-off-by: Connor O'Brien <connoro@google.com>
Link: https://lore.kernel.org/all/20181009092434.26221-6-juri.lelli@redhat.com/
---
 include/linux/sched.h   |   2 +
 init/Kconfig            |   7 +
 init/init_task.c        |   1 +
 kernel/Kconfig.locks    |   2 +-
 kernel/fork.c           |   2 +
 kernel/locking/mutex.c  |  78 +++++-
 kernel/sched/core.c     | 585 +++++++++++++++++++++++++++++++++++++++-
 kernel/sched/deadline.c |   2 +-
 kernel/sched/fair.c     |  13 +-
 kernel/sched/rt.c       |   3 +-
 kernel/sched/sched.h    |  21 +-
 11 files changed, 694 insertions(+), 22 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 379e4c052644..1ccd0c1bde38 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1132,6 +1132,8 @@ struct task_struct {
 
 	struct task_struct		*blocked_proxy;	/* task that is boosting us */
 	struct mutex			*blocked_on;	/* lock we're blocked on */
+	struct list_head		blocked_entry;  /* tasks blocked on us */
+	raw_spinlock_t			blocked_lock;
 
 #ifdef CONFIG_DEBUG_ATOMIC_SLEEP
 	int				non_block_count;
diff --git a/init/Kconfig b/init/Kconfig
index 532362fcfe31..a341b9755a57 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -922,6 +922,13 @@ config NUMA_BALANCING_DEFAULT_ENABLED
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
index 81e809c343fd..409f4d955537 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2106,6 +2106,7 @@ static __latent_entropy struct task_struct *copy_process(
 	ftrace_graph_init_task(p);
 
 	rt_mutex_init_task(p);
+	raw_spin_lock_init(&p->blocked_lock);
 
 	lockdep_assert_irqs_enabled();
 #ifdef CONFIG_PROVE_LOCKING
@@ -2210,6 +2211,7 @@ static __latent_entropy struct task_struct *copy_process(
 
 	p->blocked_proxy = NULL; /* nobody is boosting us yet */
 	p->blocked_on = NULL; /* not blocked yet */
+	INIT_LIST_HEAD(&p->blocked_entry);
 
 #ifdef CONFIG_BCACHE
 	p->sequential_io	= 0;
diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index 325fc9db5004..ba8bfac23c10 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -621,6 +621,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 	}
 
 	raw_spin_lock_irqsave(&lock->wait_lock, flags);
+	raw_spin_lock(&current->blocked_lock);
 	/*
 	 * After waiting to acquire the wait_lock, try again.
 	 */
@@ -682,6 +683,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 				goto err;
 		}
 
+		raw_spin_unlock(&current->blocked_lock);
 		raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
 		if (ww_ctx)
 			ww_ctx_wake(ww_ctx);
@@ -689,6 +691,8 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 
 		first = __mutex_waiter_is_first(lock, &waiter);
 
+		raw_spin_lock_irqsave(&lock->wait_lock, flags);
+		raw_spin_lock(&current->blocked_lock);
 		/*
 		 * Gets reset by ttwu_runnable().
 		 */
@@ -703,15 +707,28 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
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
 
@@ -738,6 +755,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 	if (ww_ctx)
 		ww_mutex_lock_acquired(ww, ww_ctx);
 
+	raw_spin_unlock(&current->blocked_lock);
 	raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
 	if (ww_ctx)
 		ww_ctx_wake(ww_ctx);
@@ -749,6 +767,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 	__mutex_remove_waiter(lock, &waiter);
 err_early_kill:
 	trace_contention_end(lock, ret);
+	raw_spin_unlock(&current->blocked_lock);
 	raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
 	debug_mutex_free_waiter(&waiter);
 	mutex_release(&lock->dep_map, ip);
@@ -920,11 +939,22 @@ static noinline void __sched __mutex_unlock_slowpath(struct mutex *lock, unsigne
 {
 	struct task_struct *next = NULL;
 	DEFINE_WAKE_Q(wake_q);
-	unsigned long owner;
+	/*
+	 * XXX [juril] Proxy Exec forces always an HANDOFF (so that owner is
+	 * never empty when there are waiters waiting?). Should we make this
+	 * conditional on having proxy exec configured in?
+	 */
+	unsigned long owner = MUTEX_FLAG_HANDOFF;
 	unsigned long flags;
 
 	mutex_release(&lock->dep_map, ip);
 
+	/*
+	 * XXX must always handoff the mutex to avoid !owner in proxy().
+	 * scheduler delay is minimal since we hand off to the task that
+	 * is to be scheduled next.
+	 */
+#ifndef CONFIG_PROXY_EXEC
 	/*
 	 * Release the lock before (potentially) taking the spinlock such that
 	 * other contenders can get on with things ASAP.
@@ -947,10 +977,41 @@ static noinline void __sched __mutex_unlock_slowpath(struct mutex *lock, unsigne
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
+	 *
+	 * XXX existence guarantee on ->blocked_task ?
+	 */
+	next = current->blocked_proxy;
+	if (next) {
+		if (next->blocked_on != lock) {
+			next = NULL;
+		} else {
+			wake_q_add(&wake_q, next);
+			current->blocked_proxy = NULL;
+		}
+	}
+
+	/*
+	 * XXX if there was no higher prio proxy, ->blocked_task will not have
+	 * been set.  Therefore lower prio contending tasks are serviced in
+	 * FIFO order.
+	 */
+#endif
+
+	/*
+	 * Failing that, pick any on the wait list.
+	 */
+	if (!next && !list_empty(&lock->wait_list)) {
 		/* get the first entry from the wait-list: */
 		struct mutex_waiter *waiter =
 			list_first_entry(&lock->wait_list,
@@ -965,7 +1026,10 @@ static noinline void __sched __mutex_unlock_slowpath(struct mutex *lock, unsigne
 	if (owner & MUTEX_FLAG_HANDOFF)
 		__mutex_handoff(lock, next);
 
-	preempt_disable();
+	preempt_disable(); /* XXX connoro: why disable preemption here? */
+#ifdef CONFIG_PROXY_EXEC
+	raw_spin_unlock(&current->blocked_lock);
+#endif
 	raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
 
 	wake_up_q(&wake_q);
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index c8bfa1ad9551..416e61182c17 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -510,6 +510,8 @@ sched_core_dequeue(struct rq *rq, struct task_struct *p, int flags) { }
  *
  * task_cpu(p): is changed by set_task_cpu(), the rules are:
  *
+ * XXX connoro: does it matter that ttwu_do_activate now calls __set_task_cpu
+ * on blocked tasks?
  *  - Don't call set_task_cpu() on a blocked task:
  *
  *    We don't care what CPU we're not running on, this simplifies hotplug,
@@ -2714,8 +2716,15 @@ static int affine_move_task(struct rq *rq, struct task_struct *p, struct rq_flag
 	struct set_affinity_pending my_pending = { }, *pending = NULL;
 	bool stop_pending, complete = false;
 
-	/* Can the task run on the task's current CPU? If so, we're done */
-	if (cpumask_test_cpu(task_cpu(p), &p->cpus_mask)) {
+	/*
+	 * Can the task run on the task's current CPU? If so, we're done
+	 *
+	 * We are also done if the task is currently acting as proxy (and
+	 * potentially has been migrated outside its current or previous
+	 * affinity mask.
+	 */
+	if (cpumask_test_cpu(task_cpu(p), &p->cpus_mask) ||
+	    (task_current_proxy(rq, p) && !task_current(rq, p))) {
 		struct task_struct *push_task = NULL;
 
 		if ((flags & SCA_MIGRATE_ENABLE) &&
@@ -3681,7 +3690,55 @@ ttwu_do_activate(struct rq *rq, struct task_struct *p, int wake_flags,
 		atomic_dec(&task_rq(p)->nr_iowait);
 	}
 
+	/*
+	 * XXX connoro: By calling activate_task with blocked_lock held, we order against
+	 * the proxy() blocked_task case such that no more blocked tasks will
+	 * be enqueued on p once we release p->blocked_lock.
+	 */
+	raw_spin_lock(&p->blocked_lock);
+	/*
+	 * XXX connoro: do we need to check p->on_rq here like we do for pp below?
+	 * or does holding p->pi_lock ensure nobody else activates p first?
+	 */
 	activate_task(rq, p, en_flags);
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
+		/*
+		 * XXX connoro: proxy blocked_task case might be enqueuing more blocked tasks
+		 * on pp. If those continue past when we delete pp from the list, we'll get an
+		 * active with a non-empty blocked_entry list, which is no good. Locking
+		 * pp->blocked_lock ensures either the blocked_task path gets the lock first and
+		 * enqueues everything before we ever get the lock, or we get the lock first, the
+		 * other path sees pp->on_rq != 0 and enqueues nothing.
+		 */
+		raw_spin_lock(&pp->blocked_lock);
+		BUG_ON(pp->blocked_entry.prev != &p->blocked_entry);
+
+		list_del_init(&pp->blocked_entry);
+		if (READ_ONCE(pp->on_rq)) {
+			/*
+			 * XXX connoro: We raced with a non mutex handoff activation of pp. That
+			 * activation will also take care of activating all of the tasks after pp in
+			 * the blocked_entry list, so we're done here.
+			 */
+			raw_spin_unlock(&pp->blocked_lock);
+			break;
+		}
+		activate_task(rq, pp, en_flags);
+		pp->on_rq = TASK_ON_RQ_QUEUED;
+		resched_curr(rq);
+		raw_spin_unlock(&pp->blocked_lock);
+	}
+
 	ttwu_do_wakeup(rq, p, wake_flags, rf);
 }
 
@@ -3717,12 +3774,96 @@ static int ttwu_runnable(struct task_struct *p, int wake_flags)
 	int ret = 0;
 
 	rq = __task_rq_lock(p, &rf);
-	if (task_on_rq_queued(p)) {
-		/* check_preempt_curr() may use rq clock */
-		update_rq_clock(rq);
-		ttwu_do_wakeup(rq, p, wake_flags, &rf);
-		ret = 1;
+	if (!task_on_rq_queued(p)) {
+		BUG_ON(task_is_running(p));
+		goto out_unlock;
 	}
+
+	/*
+	 * ttwu_do_wakeup()->
+	 *   check_preempt_curr() may use rq clock
+	 */
+	update_rq_clock(rq);
+
+	/*
+	 * XXX connoro: wrap this case with #ifdef CONFIG_PROXY_EXEC?
+	 */
+	if (task_current(rq, p)) {
+		/*
+		 * XXX connoro: p is currently running. 3 cases are possible:
+		 * 1) p is blocked on a lock it owns, but we got the rq lock before
+		 *    it could schedule out. Kill blocked_on relation and call
+		 *    ttwu_do_wakeup
+		 * 2) p is blocked on a lock it does not own. Leave blocked_on
+		 *    unchanged, don't call ttwu_do_wakeup, and return 0.
+		 * 3) p is unblocked, but unless we hold onto blocked_lock while
+		 *    calling ttwu_do_wakeup, we could race with it becoming
+		 *    blocked and overwrite the correct p->__state with TASK_RUNNING.
+		 */
+		raw_spin_lock(&p->blocked_lock);
+		if (task_is_blocked(p) && mutex_owner(p->blocked_on) == p)
+			set_task_blocked_on(p, NULL);
+		if (!task_is_blocked(p)) {
+			ttwu_do_wakeup(rq, p, wake_flags, &rf);
+			ret = 1;
+		}
+		raw_spin_unlock(&p->blocked_lock);
+		goto out_unlock;
+	}
+
+	/*
+	 * Since we don't dequeue for blocked-on relations, we'll always
+	 * trigger the on_rq_queued() clause for them.
+	 */
+	if (task_is_blocked(p)) {
+		raw_spin_lock(&p->blocked_lock);
+
+		if (mutex_owner(p->blocked_on) != p) {
+			/*
+			 * XXX connoro: p already woke, ran and blocked on
+			 * another mutex. Since a successful wakeup already
+			 * happened, we're done.
+			 */
+			raw_spin_unlock(&p->blocked_lock);
+			goto out_unlock;
+		}
+
+		set_task_blocked_on(p, NULL);
+		if (!cpumask_test_cpu(cpu_of(rq), p->cpus_ptr)) {
+			/*
+			 * proxy stuff moved us outside of the affinity mask
+			 * 'sleep' now and fail the direct wakeup so that the
+			 * normal wakeup path will fix things.
+			 */
+			deactivate_task(rq, p, DEQUEUE_SLEEP | DEQUEUE_NOCLOCK);
+			if (task_current_proxy(rq, p)) {
+				/*
+				 * XXX connoro: If p is the proxy, then remove lingering
+				 * references to it from rq and sched_class structs after
+				 * dequeueing.
+				 * can we get here while rq is inside __schedule?
+				 * do any assumptions break if so?
+				 */
+				put_prev_task(rq, p);
+				rq->proxy = rq->idle;
+			}
+			resched_curr(rq);
+			raw_spin_unlock(&p->blocked_lock);
+			goto out_unlock;
+		}
+
+		/*
+		 * Must resched after killing a blocked_on relation. The currently
+		 * executing context might not be the most elegible anymore.
+		 */
+		resched_curr(rq);
+		raw_spin_unlock(&p->blocked_lock);
+	}
+
+	ttwu_do_wakeup(rq, p, wake_flags, &rf);
+	ret = 1;
+
+out_unlock:
 	__task_rq_unlock(rq, &rf);
 
 	return ret;
@@ -4126,6 +4267,23 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
 	if (READ_ONCE(p->on_rq) && ttwu_runnable(p, wake_flags))
 		goto unlock;
 
+	if (task_is_blocked(p)) {
+		/*
+		 * XXX connoro: we are in one of 2 cases:
+		 * 1) p is blocked on a mutex it doesn't own but is still
+		 *    enqueued on a rq. We definitely don't want to keep going
+		 *    (and potentially activate it elsewhere without ever
+		 *    dequeueing) but maybe this is more properly handled by
+		 *    having ttwu_runnable() return 1 in this case?
+		 * 2) p was removed from its rq and added to a blocked_entry
+		 *    list by proxy(). It should not be woken until the task at
+		 *    the head of the list gets a mutex handoff wakeup.
+		 * Should try_to_wake_up() return 1 in either of these cases?
+		 */
+		success = 0;
+		goto unlock;
+	}
+
 #ifdef CONFIG_SMP
 	/*
 	 * Ensure we load p->on_cpu _after_ p->on_rq, otherwise it would be
@@ -5462,6 +5620,18 @@ void scheduler_tick(void)
 
 	rq_lock(rq, &rf);
 
+#ifdef CONFIG_PROXY_EXEC
+	/*
+	 * XXX connoro: is this check needed? Why?
+	 */
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
@@ -6355,6 +6525,373 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 # define SM_MASK_PREEMPT	SM_PREEMPT
 #endif
 
+#ifdef CONFIG_PROXY_EXEC
+
+/*
+ * Find who @next (currently blocked on a mutex) can proxy for.
+ *
+ * Follow the blocked-on relation:
+ *
+ *                ,-> task
+ *                |     | blocked-on
+ *                |     v
+ *     proxied-by |   mutex
+ *                |     | owner
+ *                |     v
+ *                `-- task
+ *
+ * and set the proxied-by relation, this latter is used by the mutex code
+ * to find which (blocked) task to hand-off to.
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
+	struct mutex *mutex;
+	struct rq *that_rq;
+	int this_cpu, that_cpu;
+	bool curr_in_chain = false;
+	LIST_HEAD(migrate_list);
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
+		owner = mutex_owner(mutex);
+		/*
+		 * XXX can't this be 0|FLAGS? See __mutex_unlock_slowpath for(;;)
+		 * Mmm, OK, this can't probably happen because we force
+		 * unlock to skip the for(;;) loop. Is this acceptable though?
+		 */
+		if (task_cpu(owner) != this_cpu)
+			goto migrate_task;
+
+		if (task_on_rq_migrating(owner))
+			goto migrating_task;
+
+		if (owner == p)
+			goto owned_task;
+
+		if (!owner->on_rq)
+			goto blocked_task;
+
+		/*
+		 * OK, now we're absolutely sure @owner is not blocked _and_
+		 * on this rq, therefore holding @rq->lock is sufficient to
+		 * guarantee its existence, as per ttwu_remote().
+		 */
+		raw_spin_unlock(&p->blocked_lock);
+		raw_spin_unlock(&mutex->wait_lock);
+
+		owner->blocked_proxy = p;
+	}
+
+	WARN_ON_ONCE(!owner->on_rq);
+
+	return owner;
+
+migrate_task:
+	/*
+	 * The blocked-on relation must not cross CPUs, if this happens
+	 * migrate @p to the @owner's CPU.
+	 *
+	 * This is because we must respect the CPU affinity of execution
+	 * contexts (@owner) but we can ignore affinity for scheduling
+	 * contexts (@p). So we have to move scheduling contexts towards
+	 * potential execution contexts.
+	 *
+	 * XXX [juril] what if @p is not the highest prio task once migrated
+	 * to @owner's CPU?
+	 *
+	 * XXX [juril] also, after @p is migrated it is not migrated back once
+	 * @owner releases the lock? Isn't this a potential problem w.r.t.
+	 * @owner affinity settings?
+	 * [juril] OK. It is migrated back into its affinity mask in
+	 * ttwu_remote(), or by using wake_cpu via select_task_rq, guess we
+	 * might want to add a comment about that here. :-)
+	 *
+	 * TODO: could optimize by finding the CPU of the final owner
+	 * and migrating things there. Given:
+	 *
+	 *	CPU0	CPU1	CPU2
+	 *
+	 *	 a ----> b ----> c
+	 *
+	 * the current scheme would result in migrating 'a' to CPU1,
+	 * then CPU1 would migrate b and a to CPU2. Only then would
+	 * CPU2 run c.
+	 */
+	that_cpu = task_cpu(owner);
+	that_rq = cpu_rq(that_cpu);
+	/*
+	 * @owner can disappear, simply migrate to @that_cpu and leave that CPU
+	 * to sort things out.
+	 */
+	raw_spin_unlock(&p->blocked_lock);
+	raw_spin_unlock(&mutex->wait_lock);
+
+	/*
+	 * Since we're going to drop @rq, we have to put(@next) first,
+	 * otherwise we have a reference that no longer belongs to us.  Use
+	 * @fake_task to fill the void and make the next pick_next_task()
+	 * invocation happy.
+	 *
+	 * XXX double, triple think about this.
+	 * XXX put doesn't work with ON_RQ_MIGRATE
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
+		rq->proxy = rq->idle;
+		set_tsk_need_resched(rq->idle);
+		/*
+		 * XXX [juril] don't we still need to migrate @next to
+		 * @owner's CPU?
+		 */
+		return rq->idle;
+	}
+	rq->proxy = rq->idle;
+
+	for (; p; p = p->blocked_proxy) {
+		int wake_cpu = p->wake_cpu;
+
+		WARN_ON(p == rq->curr);
+
+		deactivate_task(rq, p, 0);
+		set_task_cpu(p, that_cpu);
+		/*
+		 * We can abuse blocked_entry to migrate the thing, because @p is
+		 * still on the rq.
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
+		/*
+		 * check_preempt_curr has already called
+		 * resched_curr(that_rq) in case it is
+		 * needed.
+		 */
+	}
+
+	raw_spin_rq_unlock(that_rq);
+	raw_spin_rq_lock(rq);
+	rq_repin_lock(rq, rf);
+
+	return NULL; /* Retry task selection on _this_ CPU. */
+
+migrating_task:
+	/*
+	 * XXX connoro: one of the chain of mutex owners is currently
+	 * migrating to this CPU, but has not yet been enqueued because
+	 * we are holding the rq lock. As a simple solution, just schedule
+	 * rq->idle to give the migration a chance to complete. Much like
+	 * the migrate_task case we should end up back in proxy(), this
+	 * time hopefully with all relevant tasks already enqueued.
+	 */
+	raw_spin_unlock(&p->blocked_lock);
+	raw_spin_unlock(&mutex->wait_lock);
+	put_prev_task(rq, next);
+	rq->proxy = rq->idle;
+	set_tsk_need_resched(rq->idle);
+	return rq->idle;
+owned_task:
+	/*
+	 * Its possible we interleave with mutex_unlock like:
+	 *
+	 *				lock(&rq->lock);
+	 *				  proxy()
+	 * mutex_unlock()
+	 *   lock(&wait_lock);
+	 *   next(owner) = current->blocked_proxy;
+	 *   unlock(&wait_lock);
+	 *
+	 *   wake_up_q();
+	 *     ...
+	 *       ttwu_runnable()
+	 *         __task_rq_lock()
+	 *				  lock(&wait_lock);
+	 *				  owner == p
+	 *
+	 * Which leaves us to finish the ttwu_runnable() and make it go.
+	 *
+	 * XXX is this happening in case of an HANDOFF to p?
+	 * In any case, reading of the owner in __mutex_unlock_slowpath is
+	 * done atomically outside wait_lock (only adding waiters to wake_q is
+	 * done inside the critical section).
+	 * Does this means we can get to proxy _w/o an owner_ if that was
+	 * cleared before grabbing wait_lock? Do we account for this case?
+	 * OK we actually do (see PROXY_EXEC ifdeffery in unlock function).
+	 */
+
+	set_task_blocked_on(owner, NULL);
+
+	/*
+	 * XXX connoro: previous versions would immediately run owner here if
+	 * it's allowed to run on this CPU, but this creates potential races
+	 * with the wakeup logic. Instead we can just take the blocked_task path
+	 * when owner is already !on_rq, or else schedule rq->idle so that ttwu_runnable
+	 * can get the rq lock and mark owner as running.
+	 */
+	if (!owner->on_rq)
+		goto blocked_task;
+
+	raw_spin_unlock(&p->blocked_lock);
+	raw_spin_unlock(&mutex->wait_lock);
+	put_prev_task(rq, next);
+	rq->proxy = rq->idle;
+	set_tsk_need_resched(rq->idle);
+	return rq->idle;
+
+blocked_task:
+	/*
+	 * XXX connoro: rq->curr must not be added to the blocked_entry list
+	 * or else ttwu_do_activate could enqueue it elsewhere before it switches out
+	 * here. The approach to avoiding this is the same as in the migrate_task case.
+	 */
+	if (curr_in_chain) {
+		raw_spin_unlock(&p->blocked_lock);
+		raw_spin_unlock(&mutex->wait_lock);
+		put_prev_task(rq, next);
+		rq->proxy = rq->idle;
+		set_tsk_need_resched(rq->idle);
+		return rq->idle;
+	}
+	/*
+	 * If !@owner->on_rq, holding @rq->lock will not pin the task,
+	 * so we cannot drop @mutex->wait_lock until we're sure its a blocked
+	 * task on this rq.
+	 *
+	 * We use @owner->blocked_lock to serialize against ttwu_activate().
+	 * Either we see its new owner->on_rq or it will see our list_add().
+	 */
+	if (owner != p) {
+		raw_spin_unlock(&p->blocked_lock);
+		raw_spin_lock(&owner->blocked_lock);
+	}
+
+	/*
+	 * Walk back up the blocked_proxy relation and enqueue them all on @owner
+	 *
+	 * ttwu_activate() will pick them up and place them on whatever rq
+	 * @owner will run next.
+	 * XXX connoro: originally we would jump back into the main proxy() loop
+	 * owner->on_rq !=0 path, but if we then end up taking the owned_task path
+	 * then we can overwrite p->on_rq after ttwu_do_activate sets it to 1 which breaks
+	 * the assumptions made in ttwu_do_activate.
+	 */
+	if (!owner->on_rq) {
+		for (; p; p = p->blocked_proxy) {
+			if (p == owner)
+				continue;
+			BUG_ON(!p->on_rq);
+			deactivate_task(rq, p, DEQUEUE_SLEEP);
+			if (task_current_proxy(rq, p)) {
+				put_prev_task(rq, next);
+				rq->proxy = rq->idle;
+			}
+			/*
+			 * XXX connoro: need to verify this is necessary. The rationale is that
+			 * ttwu_do_activate must not have a chance to activate p elsewhere before
+			 * it's fully extricated from its old rq.
+			 */
+			smp_mb();
+			list_add(&p->blocked_entry, &owner->blocked_entry);
+		}
+	}
+	if (task_current_proxy(rq, next)) {
+		put_prev_task(rq, next);
+		rq->proxy = rq->idle;
+	}
+	raw_spin_unlock(&owner->blocked_lock);
+	raw_spin_unlock(&mutex->wait_lock);
+
+	return NULL; /* retry task selection */
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
@@ -6447,7 +6984,7 @@ static void __sched notrace __schedule(unsigned int sched_mode)
 	if (!(sched_mode & SM_MASK_PREEMPT) && prev_state) {
 		if (signal_pending_state(prev_state, prev)) {
 			WRITE_ONCE(prev->__state, TASK_RUNNING);
-		} else {
+		} else if (!task_is_blocked(prev)) {
 			prev->sched_contributes_to_load =
 				(prev_state & TASK_UNINTERRUPTIBLE) &&
 				!(prev_state & TASK_NOLOAD) &&
@@ -6473,11 +7010,37 @@ static void __sched notrace __schedule(unsigned int sched_mode)
 				atomic_inc(&rq->nr_iowait);
 				delayacct_blkio_start();
 			}
+		} else {
+			/*
+			 * XXX
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
 
-	rq->proxy = next = pick_next_task(rq, prev, &rf);
+pick_again:
+	/*
+	 * If picked task is actually blocked it means that it can act as a
+	 * proxy for the task that is holding the mutex picked task is blocked
+	 * on. Get a reference to the blocked (going to be proxy) task here.
+	 * Note that if next isn't actually blocked we will have rq->proxy ==
+	 * rq->curr == next in the end, which is intended and means that proxy
+	 * execution is currently "not in use".
+	 */
+	rq->proxy = next = pick_next_task(rq, rq->proxy, &rf);
+	next->blocked_proxy = NULL;
+	if (unlikely(task_is_blocked(next))) {
+		next = proxy(rq, next, &rf);
+		if (!next)
+			goto pick_again;
+	}
+
 	clear_tsk_need_resched(prev);
 	clear_preempt_need_resched();
 #ifdef CONFIG_SCHED_DEBUG
@@ -6565,6 +7128,10 @@ static inline void sched_submit_work(struct task_struct *tsk)
 	 */
 	SCHED_WARN_ON(current->__state & TASK_RTLOCK_WAIT);
 
+	/* XXX still necessary? tsk_is_pi_blocked check here was deleted... */
+	if (task_is_blocked(tsk))
+		return;
+
 	/*
 	 * If we are going to sleep and we have plugged IO queued,
 	 * make sure to submit it to avoid deadlocks.
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index d5ab7ff64fbc..5416d61e87e7 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1748,7 +1748,7 @@ static void enqueue_task_dl(struct rq *rq, struct task_struct *p, int flags)
 
 	enqueue_dl_entity(&p->dl, flags);
 
-	if (!task_current(rq, p) && p->nr_cpus_allowed > 1)
+	if (!task_current(rq, p) && p->nr_cpus_allowed > 1 && !task_is_blocked(p))
 		enqueue_pushable_dl_task(rq, p);
 }
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index d142f0611b34..2d8e9f9c6826 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7370,7 +7370,9 @@ pick_next_task_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf
 		goto idle;
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
-	if (!prev || prev->sched_class != &fair_sched_class)
+	if (!prev ||
+	    prev->sched_class != &fair_sched_class ||
+	    rq->curr !=	rq->proxy)
 		goto simple;
 
 	/*
@@ -7888,6 +7890,9 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
 
 	lockdep_assert_rq_held(env->src_rq);
 
+	if (task_is_blocked(p))
+		return 0;
+
 	/*
 	 * We do not migrate tasks that are:
 	 * 1) throttled_lb_pair, or
@@ -7938,7 +7943,11 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
 	/* Record that we found at least one task that could run on dst_cpu */
 	env->flags &= ~LBF_ALL_PINNED;
 
-	if (task_running(env->src_rq, p)) {
+	/*
+	 * XXX mutex unlock path may have marked proxy as unblocked allowing us to
+	 * reach this point, but we still shouldn't migrate it.
+	 */
+	if (task_running(env->src_rq, p) || task_current_proxy(env->src_rq, p)) {
 		schedstat_inc(p->stats.nr_failed_migrations_running);
 		return 0;
 	}
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 116556f4fb0a..09385fcb1713 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1548,7 +1548,8 @@ enqueue_task_rt(struct rq *rq, struct task_struct *p, int flags)
 
 	enqueue_rt_entity(rt_se, flags);
 
-	if (!task_current(rq, p) && p->nr_cpus_allowed > 1)
+	if (!task_current(rq, p) && p->nr_cpus_allowed > 1 &&
+	    !task_is_blocked(p))
 		enqueue_pushable_task(rq, p);
 }
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 0ef59dc7b8ea..354e75587fed 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2079,6 +2079,19 @@ static inline int task_current_proxy(struct rq *rq, struct task_struct *p)
 	return rq->proxy == p;
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
 static inline int task_running(struct rq *rq, struct task_struct *p)
 {
 #ifdef CONFIG_SMP
@@ -2233,12 +2246,18 @@ struct sched_class {
 
 static inline void put_prev_task(struct rq *rq, struct task_struct *prev)
 {
-	WARN_ON_ONCE(rq->proxy != prev);
+	WARN_ON_ONCE(rq->curr != prev && prev != rq->proxy);
+
+	/* XXX connoro: is this check necessary? */
+	if (prev == rq->proxy && task_cpu(prev) != cpu_of(rq))
+		return;
+
 	prev->sched_class->put_prev_task(rq, prev);
 }
 
 static inline void set_next_task(struct rq *rq, struct task_struct *next)
 {
+	WARN_ON_ONCE(!task_current_proxy(rq, next));
 	next->sched_class->set_next_task(rq, next, false);
 }
 
-- 
2.38.0.rc1.362.ged0d419d3c-goog

