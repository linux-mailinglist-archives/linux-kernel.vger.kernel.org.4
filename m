Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 414226DD0EC
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 06:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbjDKE0p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 00:26:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbjDKE0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 00:26:13 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 359B22691
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 21:25:38 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-54c23fab905so115897967b3.14
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 21:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1681187138; x=1683779138;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=eoYXpQ2LZXTwZUi+ZtMPLwKF3H0uK5AJbZIZwQzpjoA=;
        b=hkDg2HC82UsnhNvMFudGv3isGMGc1UAZKoxoddfB8xfrBsdcwYvXGPN5KJtYv9Li1r
         wbAA4HlfJqa36og0HMTDiLRCl6QQW0HIo4TUb5AQAMNsWJge7kv99n8KD6X0CZfMP0lp
         QJdMLqBARGxZk2sueqh54Tb6fgOZ6wZr+Z2RQutKyXU4+magzXP2yU0O4QLm2LUy+LCu
         zQE391SE9ailwxfJ5vY7GwGUAYaxtItZEv1RCZti7PYIvVX2vK2ApyhMMklJt7bZg34R
         aJLMbW1jXCUT9ZLa9YTbqrDxYSBsmZ9WxE17DO8JYXDH9GbmTvTPsG9WHM4nhrTVAk4m
         VqBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681187138; x=1683779138;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eoYXpQ2LZXTwZUi+ZtMPLwKF3H0uK5AJbZIZwQzpjoA=;
        b=j8G3tN733KzsI+udOTNza7FZYfVtBLKv96l1/+f6TAJb1xhdF2ZGQ4hTOPJDL4adYW
         lKkGJD9ZMZPAbCS2Is8KL0zGtkFEWSDkGZQQDnagzW86rZEaiK/hHfn//4Qs+Euh3o98
         3bhaXEl+cz/IxWfBvS1ePfv9jiZJbE9LY+o6MODXDiBEpmZB+WtqFdrOLPmH/Mszw2TJ
         +VRn7MkRjDwd+j/29fA6Tzf3+WYcXSFWaWRoYhsSAlnV3uHiMwwDsRPbRn8EUjOnNI3c
         /fivYoElYtAJByn636iv27eFQBdQoVgy+zoaBRZ1T5IRpbshUJNx2z0iOkxMXgKgkrU7
         URFw==
X-Gm-Message-State: AAQBX9fxvZ42M6hYJwlfy8xzrDs7UGjWwuzT7mEfm0ubc8ouUbPQiHnI
        kLeM2JIYR45njwWKGutPu1DzhJMIO/s6J4YiBJeUiv0rScGRPTMtAE33B6aeZrszb9T81kVuCTa
        uQPMS/zY0vmKdJ0VKfH4H8ZLOvDtoE+VDsl3YrjHTOHst8QuXm5A6d3WC5u7UoJHqpedBuWA=
X-Google-Smtp-Source: AKy350Zvg6EXftIhZzCDANoKTtzdNT9PnBznFFddpLSAgRw8tkvUkGvT6VluMG8Na6x+OOb1QX7/LgC/eFwC
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a81:bc08:0:b0:54e:e490:d190 with SMTP id
 a8-20020a81bc08000000b0054ee490d190mr925385ywi.4.1681187138097; Mon, 10 Apr
 2023 21:25:38 -0700 (PDT)
Date:   Tue, 11 Apr 2023 04:25:08 +0000
In-Reply-To: <20230411042511.1606592-1-jstultz@google.com>
Mime-Version: 1.0
References: <20230411042511.1606592-1-jstultz@google.com>
X-Mailer: git-send-email 2.40.0.577.gac1e443424-goog
Message-ID: <20230411042511.1606592-12-jstultz@google.com>
Subject: [PATCH v3 11/14] sched: Add proxy execution
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

A task currently holding a mutex (executing a critical section)
might find benefit in using scheduling contexts of other tasks
blocked on the same mutex if they happen to have higher priority
of the current owner (e.g., to prevent priority inversions).

Proxy execution lets a task do exactly that: if a mutex owner
has waiters, it can use waiters' scheduling context to
potentially continue running if preempted.

The basic mechanism is implemented by this patch, the core of
which resides in the proxy() function. Potential proxies (i.e.,
tasks blocked on a mutex) are not dequeued, so, if one of them
is actually selected by schedule() as the next task to be put to
run on a CPU, proxy() is used to walk the blocked_on relation
and find which task (mutex owner) might be able to use the
proxy's scheduling context.

Here come the tricky bits. In fact, owner task might be in all
sort of states when a proxy is found (blocked, executing on a
different CPU, etc.). Details on how to handle different
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

TODO: Finish conditionalization edge cases
---
 include/linux/sched.h   |   2 +
 init/Kconfig            |   7 +
 kernel/Kconfig.locks    |   2 +-
 kernel/fork.c           |   2 +
 kernel/locking/mutex.c  |  58 +++-
 kernel/sched/core.c     | 666 +++++++++++++++++++++++++++++++++++++++-
 kernel/sched/deadline.c |   2 +-
 kernel/sched/fair.c     |  13 +-
 kernel/sched/rt.c       |   3 +-
 kernel/sched/sched.h    |  21 +-
 10 files changed, 760 insertions(+), 16 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 6d22542d3648..b88303ceacaf 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1139,7 +1139,9 @@ struct task_struct {
 	struct rt_mutex_waiter		*pi_blocked_on;
 #endif
 
+	struct task_struct		*blocked_proxy;	/* task that is boosting us */
 	struct mutex			*blocked_on;	/* lock we're blocked on */
+	struct list_head		blocked_entry;  /* tasks blocked on us */
 	raw_spinlock_t			blocked_lock;
 
 #ifdef CONFIG_DEBUG_ATOMIC_SLEEP
diff --git a/init/Kconfig b/init/Kconfig
index 1fb5f313d18f..38cdd2ccc538 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -935,6 +935,13 @@ config NUMA_BALANCING_DEFAULT_ENABLED
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
index a0ff6d73affc..1cde7733d387 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2222,7 +2222,9 @@ static __latent_entropy struct task_struct *copy_process(
 	lockdep_init_task(p);
 #endif
 
+	p->blocked_proxy = NULL; /* nobody is boosting us yet */
 	p->blocked_on = NULL; /* not blocked yet */
+	INIT_LIST_HEAD(&p->blocked_entry);
 
 #ifdef CONFIG_BCACHE
 	p->sequential_io	= 0;
diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index cbc34d5f4486..d778dbfb9981 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -940,11 +940,22 @@ static noinline void __sched __mutex_unlock_slowpath(struct mutex *lock, unsigne
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
@@ -967,10 +978,48 @@ static noinline void __sched __mutex_unlock_slowpath(struct mutex *lock, unsigne
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
+	next = current->blocked_proxy;
+	if (next) {
+		struct mutex *next_lock;
+
+		/*
+		 * jstultz:  get_task_blocked_on(next) seemed to be missing locking
+		 * so I've added it here (which required nesting the locks).
+		 */
+		raw_spin_lock_nested(&next->blocked_lock, SINGLE_DEPTH_NESTING);
+		next_lock = get_task_blocked_on(next);
+		raw_spin_unlock(&next->blocked_lock);
+		if (next_lock != lock) {
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
@@ -985,7 +1034,10 @@ static noinline void __sched __mutex_unlock_slowpath(struct mutex *lock, unsigne
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
index 82a62480d8d7..1d92f1a304b8 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -505,6 +505,8 @@ sched_core_dequeue(struct rq *rq, struct task_struct *p, int flags) { }
  *
  * task_cpu(p): is changed by set_task_cpu(), the rules are:
  *
+ * XXX connoro: does it matter that ttwu_do_activate now calls __set_task_cpu
+ * on blocked tasks?
  *  - Don't call set_task_cpu() on a blocked task:
  *
  *    We don't care what CPU we're not running on, this simplifies hotplug,
@@ -2777,8 +2779,15 @@ static int affine_move_task(struct rq *rq, struct task_struct *p, struct rq_flag
 	struct set_affinity_pending my_pending = { }, *pending = NULL;
 	bool stop_pending, complete = false;
 
-	/* Can the task run on the task's current CPU? If so, we're done */
-	if (cpumask_test_cpu(task_cpu(p), &p->cpus_mask)) {
+	/*
+	 * Can the task run on the task's current CPU? If so, we're done
+	 *
+	 * We are also done if the task is currently acting as proxy (and
+	 * potentially has been migrated outside its current or previous
+	 * affinity mask)
+	 */
+	if (cpumask_test_cpu(task_cpu(p), &p->cpus_mask) ||
+	    (task_current_selected(rq, p) && !task_current(rq, p))) {
 		struct task_struct *push_task = NULL;
 
 		if ((flags & SCA_MIGRATE_ENABLE) &&
@@ -3690,6 +3699,72 @@ static inline void ttwu_do_wakeup(struct task_struct *p)
 	trace_sched_wakeup(p);
 }
 
+#ifdef CONFIG_PROXY_EXEC
+static void activate_task_and_blocked_ent(struct rq *rq, struct task_struct *p, int en_flags)
+{
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
+		/* XXX can't call set_task_cpu() because we are not holding
+		 * neither pp->pi_lock nor task's rq lock. This should however
+		 * be fine as this task can't be woken up as it is blocked on
+		 * this mutex atm.
+		 * A problem however might be that __set_task_cpu() calls
+		 * set_task_rq() which deals with groups and such...
+		 */
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
@@ -3711,7 +3786,8 @@ ttwu_do_activate(struct rq *rq, struct task_struct *p, int wake_flags,
 		atomic_dec(&task_rq(p)->nr_iowait);
 	}
 
-	activate_task(rq, p, en_flags);
+	activate_task_and_blocked_ent(rq, p, en_flags);
+
 	check_preempt_curr(rq, p, wake_flags);
 
 	ttwu_do_wakeup(p);
@@ -3744,6 +3820,95 @@ ttwu_do_activate(struct rq *rq, struct task_struct *p, int wake_flags,
 #endif
 }
 
+#ifdef CONFIG_PROXY_EXEC
+/* XXX jstultz: This needs a better name! */
+bool ttwu_proxy_skip_wakeup(struct rq *rq, struct task_struct *p)
+{
+	/*
+	 * XXX connoro: wrap this case with #ifdef CONFIG_PROXY_EXEC?
+	 */
+	if (task_current(rq, p)) {
+		bool ret = true;
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
+		if (mutex_owner(p->blocked_on) != p) {
+			/*
+			 * XXX connoro: p already woke, ran and blocked on
+			 * another mutex. Since a successful wakeup already
+			 * happened, we're done.
+			 */
+			raw_spin_unlock(&p->blocked_lock);
+			return true;
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
+			if (task_current_selected(rq, p)) {
+				/*
+				 * XXX connoro: If p is the proxy, then remove lingering
+				 * references to it from rq and sched_class structs after
+				 * dequeueing.
+				 * can we get here while rq is inside __schedule?
+				 * do any assumptions break if so?
+				 */
+				put_prev_task(rq, p);
+				rq_set_selected(rq, rq->idle);
+			}
+			resched_curr(rq);
+			raw_spin_unlock(&p->blocked_lock);
+			return true;
+		}
+		/* connoro: perhaps deq/enq here to get our task into the pushable task
+		 * list again now that it's unblocked? Does that break if we're the proxy or
+		 * does holding the rq lock make that OK?
+		 */
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
@@ -3776,9 +3941,15 @@ static int ttwu_runnable(struct task_struct *p, int wake_flags)
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
@@ -3787,8 +3958,14 @@ static int ttwu_runnable(struct task_struct *p, int wake_flags)
 		update_rq_clock(rq);
 		check_preempt_curr(rq, p, wake_flags);
 	}
+
+	/* XXX jstultz: This needs a better name! */
+	if (ttwu_proxy_skip_wakeup(rq, p))
+		goto out_unlock;
+
 	ttwu_do_wakeup(p);
 	ret = 1;
+
 out_unlock:
 	__task_rq_unlock(rq, &rf);
 
@@ -4196,6 +4373,23 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
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
@@ -5584,6 +5778,18 @@ void scheduler_tick(void)
 
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
@@ -6476,6 +6682,404 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
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
+		rq_set_selected(rq, rq->idle);
+		set_tsk_need_resched(rq->idle);
+		/*
+		 * XXX [juril] don't we still need to migrate @next to
+		 * @owner's CPU?
+		 */
+		return rq->idle;
+	}
+	rq_set_selected(rq, rq->idle);
+
+	for (; p; p = p->blocked_proxy) {
+		int wake_cpu = p->wake_cpu;
+
+		WARN_ON(p == rq_curr(rq));
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
+	/*
+	 * XXX jstultz: Try to ensure we handle balance callbacks
+	 * before releasing the rq lock - needs review
+	 */
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
+	 * Walk back up the blocked_proxy relation and enqueue them all on @owner
+	 *
+	 * ttwu_activate() will pick them up and place them on whatever rq
+	 * @owner will run next.
+	 * XXX connoro: originally we would jump back into the main proxy() loop
+	 * owner->on_rq !=0 path, but if we then end up taking the owned_task path
+	 * then we can overwrite p->on_rq after ttwu_do_activate sets it to 1 which breaks
+	 * the assumptions made in ttwu_do_activate.
+	 *
+	 * Perhaps revisit whether retry is now possible given the changes to the
+	 * owned_task path since I wrote the prior comment...
+	 */
+	if (!owner->on_rq) {
+		/* jstultz: Err, do we need to hold a lock on p? (we gave it up for owner) */
+		for (; p; p = p->blocked_proxy) {
+			if (p == owner)
+				continue;
+			BUG_ON(!p->on_rq);
+			deactivate_task(rq, p, DEQUEUE_SLEEP);
+			if (task_current_selected(rq, p)) {
+				put_prev_task(rq, next);
+				rq_set_selected(rq, rq->idle);
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
+ *  blocked_proxy |   mutex
+ *                |     | owner
+ *                |     v
+ *                `-- task
+ *
+ * and set the blocked_proxy relation, this latter is used by the mutex
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
+		owner = mutex_owner(mutex);
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
+			 * XXX connoro: one of the chain of mutex owners is currently
+			 * migrating to this CPU, but has not yet been enqueued because
+			 * we are holding the rq lock. As a simple solution, just schedule
+			 * rq->idle to give the migration a chance to complete. Much like
+			 * the migrate_task case we should end up back in proxy(), this
+			 * time hopefully with all relevant tasks already enqueued.
+			 */
+			raw_spin_unlock(&p->blocked_lock);
+			raw_spin_unlock(&mutex->wait_lock);
+			return proxy_resched_idle(rq, next);
+		}
+
+		if (!owner->on_rq) {
+			/*
+			 * XXX connoro: rq->curr must not be added to the blocked_entry list
+			 * or else ttwu_do_activate could enqueue it elsewhere before it
+			 * switches out here. The approach to avoiding this is the same as in
+			 * the migrate_task case.
+			 */
+			if (curr_in_chain) {
+				/*
+				 * This is identical to the owned_task handling, probably should
+				 * fold them together...
+				 */
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
+			 *   next(owner) = current->blocked_proxy;
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
+			 * XXX is this happening in case of an HANDOFF to p?
+			 * In any case, reading of the owner in __mutex_unlock_slowpath is
+			 * done atomically outside wait_lock (only adding waiters to wake_q is
+			 * done inside the critical section).
+			 * Does this means we can get to proxy _w/o an owner_ if that was
+			 * cleared before grabbing wait_lock? Do we account for this case?
+			 * OK we actually do (see PROXY_EXEC ifdeffery in unlock function).
+			 */
+
+			/*
+			 * XXX connoro: prior versions would clear p->blocked_on here, but I think
+			 * that can race with the handoff wakeup path. If a wakeup reaches the
+			 * call to ttwu_runnable after this point and finds that p is enqueued
+			 * and marked as unblocked, it will happily do a ttwu_do_wakeup() call
+			 * with zero regard for whether the task's affinity actually allows
+			 * running it on this CPU.
+			 */
+
+			/*
+			 * XXX connoro: previous versions would immediately run owner here if
+			 * it's allowed to run on this CPU, but this creates potential races
+			 * with the wakeup logic. Instead we can just take the blocked_task path
+			 * when owner is already !on_rq, or else schedule rq->idle so that
+			 * ttwu_runnable can get the rq lock and mark owner as running.
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
+		owner->blocked_proxy = p;
+	}
+
+	WARN_ON_ONCE(!owner->on_rq);
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
@@ -6523,6 +7127,7 @@ static void __sched notrace __schedule(unsigned int sched_mode)
 	struct rq_flags rf;
 	struct rq *rq;
 	int cpu;
+	bool preserve_need_resched = false;
 
 	cpu = smp_processor_id();
 	rq = cpu_rq(cpu);
@@ -6568,7 +7173,7 @@ static void __sched notrace __schedule(unsigned int sched_mode)
 	if (!(sched_mode & SM_MASK_PREEMPT) && prev_state) {
 		if (signal_pending_state(prev_state, prev)) {
 			WRITE_ONCE(prev->__state, TASK_RUNNING);
-		} else {
+		} else if (!task_is_blocked(prev)) {
 			prev->sched_contributes_to_load =
 				(prev_state & TASK_UNINTERRUPTIBLE) &&
 				!(prev_state & TASK_NOLOAD) &&
@@ -6594,13 +7199,56 @@ static void __sched notrace __schedule(unsigned int sched_mode)
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
+	next->blocked_proxy = NULL;
+	if (unlikely(task_is_blocked(next))) {
+		next = proxy(rq, next, &rf);
+		if (!next) {
+			/* In pick_next_task() we a balance callback
+			 * may have been queued, so call it here
+			 * to clear the callbacks to avoid warnings
+			 * in rq_pin_lock
+			 */
+			__balance_callbacks(rq);
+			goto pick_again;
+		}
+		/*
+		 * XXX connoro: when proxy() returns rq->idle it sets the
+		 * TIF_NEED_RESCHED flag, but in the case where
+		 * rq->idle == rq->prev, the flag would be cleared immediately,
+		 * defeating the desired behavior. So, check explicitly for
+		 * this case.
+		 */
+		if (next == rq->idle && prev == rq->idle)
+			preserve_need_resched = true;
+	}
+
+	if (!preserve_need_resched)
+		clear_tsk_need_resched(prev);
 	clear_preempt_need_resched();
 #ifdef CONFIG_SCHED_DEBUG
 	rq->last_seen_need_resched_ns = 0;
@@ -6687,6 +7335,10 @@ static inline void sched_submit_work(struct task_struct *tsk)
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
index 63a0564cb1f8..c47a75cd057f 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1740,7 +1740,7 @@ static void enqueue_task_dl(struct rq *rq, struct task_struct *p, int flags)
 
 	enqueue_dl_entity(&p->dl, flags);
 
-	if (!task_current(rq, p) && p->nr_cpus_allowed > 1)
+	if (!task_current(rq, p) && p->nr_cpus_allowed > 1 && !task_is_blocked(p))
 		enqueue_pushable_dl_task(rq, p);
 }
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 3f7df45f7402..748a912c2122 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7962,7 +7962,9 @@ pick_next_task_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf
 		goto idle;
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
-	if (!prev || prev->sched_class != &fair_sched_class)
+	if (!prev ||
+	    prev->sched_class != &fair_sched_class ||
+	    rq_curr(rq) != rq_selected(rq))
 		goto simple;
 
 	/*
@@ -8480,6 +8482,9 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
 
 	lockdep_assert_rq_held(env->src_rq);
 
+	if (task_is_blocked(p))
+		return 0;
+
 	/*
 	 * We do not migrate tasks that are:
 	 * 1) throttled_lb_pair, or
@@ -8530,7 +8535,11 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
 	/* Record that we found at least one task that could run on dst_cpu */
 	env->flags &= ~LBF_ALL_PINNED;
 
-	if (task_on_cpu(env->src_rq, p)) {
+	/*
+	 * XXX mutex unlock path may have marked proxy as unblocked allowing us to
+	 * reach this point, but we still shouldn't migrate it.
+	 */
+	if (task_on_cpu(env->src_rq, p) || task_current_selected(env->src_rq, p)) {
 		schedstat_inc(p->stats.nr_failed_migrations_running);
 		return 0;
 	}
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 44139d56466e..5ce48eb8f5b6 100644
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
index 70cb55ad025d..8330d22b286f 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2155,6 +2155,19 @@ static inline int task_current_selected(struct rq *rq, struct task_struct *p)
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
@@ -2312,12 +2325,18 @@ struct sched_class {
 
 static inline void put_prev_task(struct rq *rq, struct task_struct *prev)
 {
-	WARN_ON_ONCE(rq_selected(rq) != prev);
+	WARN_ON_ONCE(rq_curr(rq) != prev && prev != rq_selected(rq));
+
+	/* XXX connoro: is this check necessary? */
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
2.40.0.577.gac1e443424-goog

