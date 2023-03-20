Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 956A36C25B4
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 00:37:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbjCTXhu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 19:37:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbjCTXhj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 19:37:39 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2DFE31E38
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 16:37:36 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id x4-20020a170902ec8400b001a1a5f6f272so6470275plg.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 16:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679355456;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cMj53Ovo44UMn5m6zz+VUE8eJafwWOHMtJt0fmXwh1Q=;
        b=FQri1/SzY9gLklv6+qN60xKrrefTsyZ6OtdQIFK6RF0aboHB7uqGPJy0dgEkyOdWnq
         +0FAHFif8sofWS6mrTOgZSG1uFg9qj0XBlM+7jw6manM67omYzvKkbhb2Y6nYo+2NlV3
         2VBgkAoc3GPEdOjmNu3ghVW+rWr1YfUU3qcBMSzzcynTXqN2sAaqMxy6RhxWn9RgglFR
         QU1jG1edWO1EcSz41LRfC0NH4C68f6OiPLT9LwRV4AViwKSUo5F4suPQP95I/ktdbbRl
         5o9YuSnr+C79AgheV6l+6z85hqyS58y80GjZyggaLq0weN6FltVKT47q+MhonBBWGiZy
         haGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679355456;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cMj53Ovo44UMn5m6zz+VUE8eJafwWOHMtJt0fmXwh1Q=;
        b=1Mpjp5yiugxCd5PPTsbo7+YqAbJGlgON45fOXi7Kar1/EBwzY5tkKXVW954xfolZad
         87IeVYPXloYdMvV8G8Vt2QgD8p20l/Oq0AS4gvrIJqy7CNeHthsyIsuqqk63Me8teD/d
         sBfb2oQj1TUm/3LlmArPkZFCd3wOeBX9AimmIv51GQkp8D8YR0/Vz7sXSok/6ewBJ81O
         wUhumRjjM9cSmucCQX0EqxfRwknq3iBcjGeWbZb+HKjKMvWKbucp9gbNjL94nFZTZ1TF
         OZ7YicVsFrtg1dQ1IGpcpaFnLP4+NFYh/9Y5RVZWCtKeNfpfBueLcUb4nGRwFsrPlxWl
         jQtA==
X-Gm-Message-State: AO0yUKWjWUS4NYUa5aQiKA0Fp8ISDVzQSvxgZE5oEebgipKHrYHVwXdz
        XGCDw+OjYTN88P8K1p70XpLos74lNqXc+OeF7NAZ6G8MffOd351edNw02oTHwSHDuuJmADI3rjx
        OtFWCwfzgcRKSR1rBYI8HMYCYcHAYGJoYd5UOOpKOsjAgNbxa57csnUfnA1go5YMYKloXc9U=
X-Google-Smtp-Source: AK7set9JZt4KLOQ+UeWyDL78Vk+6vq+fLnqhNjUhHpo/KsPl88zjqIqNguvcYnk1ZpszXTTW8C2sNPXr0X/E
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a65:4308:0:b0:509:3be7:eac9 with SMTP id
 j8-20020a654308000000b005093be7eac9mr132895pgq.0.1679355456284; Mon, 20 Mar
 2023 16:37:36 -0700 (PDT)
Date:   Mon, 20 Mar 2023 23:37:11 +0000
In-Reply-To: <20230320233720.3488453-1-jstultz@google.com>
Mime-Version: 1.0
References: <20230320233720.3488453-1-jstultz@google.com>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
Message-ID: <20230320233720.3488453-4-jstultz@google.com>
Subject: [PATCH v2 03/12] locking/mutex: Add task_struct::blocked_lock to
 serialize changes to the blocked_on state
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
        Valentin Schneider <valentin.schneider@arm.com>,
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

This patch was split out from the later "sched: Add proxy
execution" patch.

Adds blocked_lock to the task_struct so we can safely keep track
of which tasks are blocked on us.

This will be used for tracking blocked-task/mutex chains with
the prox-execution patch in a similar fashion to how priority
inheritence is done with rt_mutexes.

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
[rebased, added comments and changelog]
Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
[Fixed rebase conflicts]
[squashed sched: Ensure blocked_on is always guarded by blocked_lock]
Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
[fix rebase conflicts, various fixes & tweaks commented inline]
[squashed sched: Use rq->curr vs rq->proxy checks]
Signed-off-by: Connor O'Brien <connoro@google.com>
[jstultz: Split out from bigger patch]
Signed-off-by: John Stultz <jstultz@google.com>
---
v2:
* Split out into its own patch

TODO: Still need to clarify some of the locking changes here
---
 include/linux/sched.h  |  1 +
 init/init_task.c       |  1 +
 kernel/fork.c          |  1 +
 kernel/locking/mutex.c | 27 +++++++++++++++++++++++----
 4 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 9924d1926bc3..031615b5dc2a 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1141,6 +1141,7 @@ struct task_struct {
 
 	struct task_struct		*blocked_proxy;	/* task that is boosting us */
 	struct mutex			*blocked_on;	/* lock we're blocked on */
+	raw_spinlock_t			blocked_lock;
 
 #ifdef CONFIG_DEBUG_ATOMIC_SLEEP
 	int				non_block_count;
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
diff --git a/kernel/fork.c b/kernel/fork.c
index ad27fa09fe70..95410333332f 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2121,6 +2121,7 @@ static __latent_entropy struct task_struct *copy_process(
 	ftrace_graph_init_task(p);
 
 	rt_mutex_init_task(p);
+	raw_spin_lock_init(&p->blocked_lock);
 
 	lockdep_assert_irqs_enabled();
 #ifdef CONFIG_PROVE_LOCKING
diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index f5296aa82255..2f31ebb08b4a 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -615,6 +615,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 	}
 
 	raw_spin_lock(&lock->wait_lock);
+	raw_spin_lock(&current->blocked_lock);
 	/*
 	 * After waiting to acquire the wait_lock, try again.
 	 */
@@ -676,6 +677,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 				goto err;
 		}
 
+		raw_spin_unlock(&current->blocked_lock);
 		raw_spin_unlock(&lock->wait_lock);
 		if (ww_ctx)
 			ww_ctx_wake(ww_ctx);
@@ -683,6 +685,8 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 
 		first = __mutex_waiter_is_first(lock, &waiter);
 
+		raw_spin_lock(&lock->wait_lock);
+		raw_spin_lock(&current->blocked_lock);
 		/*
 		 * Gets reset by ttwu_runnable().
 		 */
@@ -697,15 +701,28 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
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
+			raw_spin_unlock(&lock->wait_lock);
 			trace_contention_begin(lock, LCB_F_MUTEX | LCB_F_SPIN);
-			if (mutex_optimistic_spin(lock, ww_ctx, &waiter))
+			acquired = mutex_optimistic_spin(lock, ww_ctx, &waiter);
+			raw_spin_lock(&lock->wait_lock);
+			raw_spin_lock(&current->blocked_lock);
+			if (acquired)
 				break;
 			trace_contention_begin(lock, LCB_F_MUTEX);
 		}
-
-		raw_spin_lock(&lock->wait_lock);
 	}
-	raw_spin_lock(&lock->wait_lock);
 acquired:
 	__set_current_state(TASK_RUNNING);
 
@@ -732,6 +749,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 	if (ww_ctx)
 		ww_mutex_lock_acquired(ww, ww_ctx);
 
+	raw_spin_unlock(&current->blocked_lock);
 	raw_spin_unlock(&lock->wait_lock);
 	if (ww_ctx)
 		ww_ctx_wake(ww_ctx);
@@ -744,6 +762,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 	__mutex_remove_waiter(lock, &waiter);
 err_early_kill:
 	trace_contention_end(lock, ret);
+	raw_spin_unlock(&current->blocked_lock);
 	raw_spin_unlock(&lock->wait_lock);
 	debug_mutex_free_waiter(&waiter);
 	mutex_release(&lock->dep_map, ip);
-- 
2.40.0.rc1.284.g88254d51c5-goog

