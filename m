Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 179176C25B3
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 00:37:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbjCTXhp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 19:37:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbjCTXhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 19:37:37 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 381D312CF6
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 16:37:35 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id 16-20020a056a00073000b006260bbaa3a4so5994683pfm.16
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 16:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679355454;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=uF1KX+DGVvWB9dHeVQYr4nKN4tbX0q4czFFzk+0W9lY=;
        b=pB8ozmYLU0gT9MKtbjkj8i/M3ld7COkWRbZjMpNcegVyz012RvTc/+zHIDuWY/XpzU
         iimyh/AGSlypF/acoui7O5DEgSPlqxHfJZrqA0aB98LnKtEg5YUwZw5RrSoH9/0E6pbm
         MY+SLQP7GBhjFgl3uuFlI92xti0E6qrbazyK/CTc1dlUtxcy9w+AsVYkbLkwzG3/Lucg
         zkR+oLFKEV5EiIvTc9SWroSPtLwdTDPijXrg+T5G2JRKTn3/cXp6SDnrIVeDkS6NNKZi
         VFP94EC98BF/ZZ4hXDdLyI6sDt/34RakIy47RN26dDUTOzZR7ZtQ9jWvwVa+vUTsueup
         x+lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679355454;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uF1KX+DGVvWB9dHeVQYr4nKN4tbX0q4czFFzk+0W9lY=;
        b=NUgAGRO3Y2zcB27vmCBhxiXiQU1vjpHfxscipO0KuOCghcaIdONDeR1Pt4yHodGrjy
         dJ18Es/R0Nl+vKeIZlXlVZvl1J7ZaNau4d3Uv9sxoDPJCJko5bRb+243AHCfztnqDl/Q
         SJcrpIqhVQcsp/vJzwlxiS1XZCTiY/Yu76a8AUP7zwwglFY3BYzccWxNk8N2azYXpq3v
         9L7CA0haQt2V7L0dm8Y8AdxQx/jdEIrX75kgQJMC+S0mJG9kbMwqcFeUc5chebKTWAR+
         2YxQV6/lhr7woehOm1907F0oSqeaqmeshAAe71Pxofx5uR5cGe9AMrHE7jMPo76snOCA
         OzPQ==
X-Gm-Message-State: AO0yUKWkWOWA5mCXd7qoVQjYRN/VjDoxCDE27JuwuKv9OvMNOrFQXIXz
        Cq+oiEpIDXOiznpP60QQPcH/vlobpDgeIrqPy6oFo5d6lP352FbLQHIgU664mGO/Ju46uYzZcMA
        sGdx1EsfSG8ptfS/KB6zyygZApK8WfcyHxSZgyJuerDQ6BX/ZSv1Wh+MCHup/MbeZVmJ4U6w=
X-Google-Smtp-Source: AK7set/n/Tu4XQGND01Bw0c1QBBlPoI6/BMgi8uukHZo4+apcZn/1T54CRy6/AjTqbe5ZorlWd8enyv8PbNd
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a17:902:c949:b0:19a:5953:e85c with SMTP id
 i9-20020a170902c94900b0019a5953e85cmr600458pla.1.1679355454487; Mon, 20 Mar
 2023 16:37:34 -0700 (PDT)
Date:   Mon, 20 Mar 2023 23:37:10 +0000
In-Reply-To: <20230320233720.3488453-1-jstultz@google.com>
Mime-Version: 1.0
References: <20230320233720.3488453-1-jstultz@google.com>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
Message-ID: <20230320233720.3488453-3-jstultz@google.com>
Subject: [PATCH v2 02/12] locking/mutex: Rework task_struct::blocked_on
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

Track the blocked-on relation for mutexes, this allows following this
relation at schedule time.

   task
     | blocked-on
     v
   mutex
     | owner
     v
   task

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
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
[minor changes while rebasing]
Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Connor O'Brien <connoro@google.com>
[jstultz: Fix blocked_on tracking in __mutex_lock_common in error paths]
Signed-off-by: John Stultz <jstultz@google.com>
---
v2:
* Fixed blocked_on tracking in error paths that was causing crashes
---
 include/linux/sched.h        | 6 ++----
 kernel/fork.c                | 4 ++--
 kernel/locking/mutex-debug.c | 9 +++++----
 kernel/locking/mutex.c       | 7 +++++++
 4 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 63d242164b1a..9924d1926bc3 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1139,10 +1139,8 @@ struct task_struct {
 	struct rt_mutex_waiter		*pi_blocked_on;
 #endif
 
-#ifdef CONFIG_DEBUG_MUTEXES
-	/* Mutex deadlock detection: */
-	struct mutex_waiter		*blocked_on;
-#endif
+	struct task_struct		*blocked_proxy;	/* task that is boosting us */
+	struct mutex			*blocked_on;	/* lock we're blocked on */
 
 #ifdef CONFIG_DEBUG_ATOMIC_SLEEP
 	int				non_block_count;
diff --git a/kernel/fork.c b/kernel/fork.c
index d8cda4c6de6c..ad27fa09fe70 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2223,9 +2223,9 @@ static __latent_entropy struct task_struct *copy_process(
 	lockdep_init_task(p);
 #endif
 
-#ifdef CONFIG_DEBUG_MUTEXES
+	p->blocked_proxy = NULL; /* nobody is boosting us yet */
 	p->blocked_on = NULL; /* not blocked yet */
-#endif
+
 #ifdef CONFIG_BCACHE
 	p->sequential_io	= 0;
 	p->sequential_io_avg	= 0;
diff --git a/kernel/locking/mutex-debug.c b/kernel/locking/mutex-debug.c
index bc8abb8549d2..7228909c3e62 100644
--- a/kernel/locking/mutex-debug.c
+++ b/kernel/locking/mutex-debug.c
@@ -52,17 +52,18 @@ void debug_mutex_add_waiter(struct mutex *lock, struct mutex_waiter *waiter,
 {
 	lockdep_assert_held(&lock->wait_lock);
 
-	/* Mark the current thread as blocked on the lock: */
-	task->blocked_on = waiter;
+	/* Current thread can't be already blocked (since it's executing!) */
+	DEBUG_LOCKS_WARN_ON(task->blocked_on);
 }
 
 void debug_mutex_remove_waiter(struct mutex *lock, struct mutex_waiter *waiter,
 			 struct task_struct *task)
 {
+	struct mutex *blocked_on = READ_ONCE(task->blocked_on);
+
 	DEBUG_LOCKS_WARN_ON(list_empty(&waiter->list));
 	DEBUG_LOCKS_WARN_ON(waiter->task != task);
-	DEBUG_LOCKS_WARN_ON(task->blocked_on != waiter);
-	task->blocked_on = NULL;
+	DEBUG_LOCKS_WARN_ON(blocked_on && blocked_on != lock);
 
 	INIT_LIST_HEAD(&waiter->list);
 	waiter->task = NULL;
diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index 1582756914df..f5296aa82255 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -645,6 +645,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 			goto err_early_kill;
 	}
 
+	current->blocked_on = lock;
 	set_current_state(state);
 	trace_contention_begin(lock, LCB_F_MUTEX);
 	for (;;) {
@@ -682,6 +683,10 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 
 		first = __mutex_waiter_is_first(lock, &waiter);
 
+		/*
+		 * Gets reset by ttwu_runnable().
+		 */
+		current->blocked_on = lock;
 		set_current_state(state);
 		/*
 		 * Here we order against unlock; we must either see it change
@@ -719,6 +724,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 	debug_mutex_free_waiter(&waiter);
 
 skip_wait:
+	current->blocked_on = NULL;
 	/* got the lock - cleanup and rejoice! */
 	lock_acquired(&lock->dep_map, ip);
 	trace_contention_end(lock, 0);
@@ -733,6 +739,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 	return 0;
 
 err:
+	current->blocked_on = NULL;
 	__set_current_state(TASK_RUNNING);
 	__mutex_remove_waiter(lock, &waiter);
 err_early_kill:
-- 
2.40.0.rc1.284.g88254d51c5-goog

