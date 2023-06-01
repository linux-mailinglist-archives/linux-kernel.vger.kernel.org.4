Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB2F67192D8
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 07:59:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231658AbjFAF72 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 01:59:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230492AbjFAF7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 01:59:22 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C030912C
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 22:59:03 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-ba83a9779f3so759725276.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 22:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685599143; x=1688191143;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=AyD0cN67LNIzuGBK8Xxb/HVicw5rCOl2zKHQGUMlrFI=;
        b=xoX+58EHDllSIt4VsQ+j6JtTLwO4g9lc0odrIy/UIjjo/FCr9edTouKiiGC4zWnmoG
         Z20mDWvK5aIN9y1CgfSwAj2RDB1SbruDBCUvkI5Bo7ZqvTfIKvA1+hBRzvayrMY3Kwoo
         sWPXPVp49m1h8snFucliYFwPDffiILXiqAEd8Mf8mM7QRsBfxkkuT8kJwb/C7WddsqZQ
         7Sx+mfyXr6JG3BxQ3EE0qKKmrH0Jc9aY8/ZRwLsANbS4SPS+PpveRJVI8lKf/PNWGSDn
         pN4caPQZjIqnsEFmi2sKqFqnEjwnWZeHUGWIiiqJ3Y4liUZvHwOCoBePZN60klyfjayq
         D7vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685599143; x=1688191143;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AyD0cN67LNIzuGBK8Xxb/HVicw5rCOl2zKHQGUMlrFI=;
        b=XNccycI/KEvvZPlEazv3qeQY4RcS2iMfLz+YbXqeYAwxUnefUNkBRC8EquDKrip1bL
         hsmcdjnZBmCGgVMMWpsfmq4K/3RAD7G8z79kiIXM5sL/ubCaGTUZheBrYC3B/43+6ib7
         5Yfn7VdeennWWYkgnBj2LYM/RCecMV1FQXuvd3uoON6xVuKVS2xhVLkBP2yLdHciyUcD
         eERwvIRGf5fMC2D//nQk8EKcw0l2maKr8wYlI5+jxedsvuezCYKTmWQfq5tPgnOVEP1A
         QJihU62NyYRhK2/Zc7W/FV8w0Y31AAFkdfUn/kMKQCTchDj+7rjt3O89kcYVdfu2xClb
         YQtg==
X-Gm-Message-State: AC+VfDy5lVLou9ULuQ3OVFEDFjJvRPAyuGP9j6cOCe5vU+4RUiKaPUff
        HdV3fU0uz1zq2NuMleuoLPvcYeNEoj75wZQyIgDV+5nImlup52gAhHP83JkcRqnR48dbNkVmm2i
        ax+ce1hmNCoISS0CUNebqcNi1cQbQN9sQh+f3NZ9wugH7kKiqoCLis9HztBnA7mSiFwIMnAc=
X-Google-Smtp-Source: ACHHUZ6u5HW7aY/ktCAO5XWaCNOrse7rwBxMhaWzsHEL7J50aagIzml2isGuN5GYY/rinPk1v3Yb+McNjlCu
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a05:6902:4ea:b0:ba8:337a:d8a3 with SMTP id
 w10-20020a05690204ea00b00ba8337ad8a3mr4666669ybs.11.1685599142821; Wed, 31
 May 2023 22:59:02 -0700 (PDT)
Date:   Thu,  1 Jun 2023 05:58:07 +0000
In-Reply-To: <20230601055846.2349566-1-jstultz@google.com>
Mime-Version: 1.0
References: <20230601055846.2349566-1-jstultz@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Message-ID: <20230601055846.2349566-5-jstultz@google.com>
Subject: [PATCH v4 04/13] locking/mutex: Rework task_struct::blocked_on
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
Cc: Youssef Esmat <youssefesmat@google.com>
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
v4:
* Ensure we clear blocked_on when waking ww_mutexes to die or wound.
  This is critical so we don't get ciruclar blocked_on relationships
  that can't be resolved.
---
 include/linux/sched.h        |  5 +----
 kernel/fork.c                |  3 +--
 kernel/locking/mutex-debug.c |  9 +++++----
 kernel/locking/mutex.c       |  7 +++++++
 kernel/locking/ww_mutex.h    | 16 ++++++++++++++--
 5 files changed, 28 insertions(+), 12 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 37dd571a1246..a312a2ff47bf 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1141,10 +1141,7 @@ struct task_struct {
 	struct rt_mutex_waiter		*pi_blocked_on;
 #endif
 
-#ifdef CONFIG_DEBUG_MUTEXES
-	/* Mutex deadlock detection: */
-	struct mutex_waiter		*blocked_on;
-#endif
+	struct mutex			*blocked_on;	/* lock we're blocked on */
 
 #ifdef CONFIG_DEBUG_ATOMIC_SLEEP
 	int				non_block_count;
diff --git a/kernel/fork.c b/kernel/fork.c
index ed4e01daccaa..9244c540bb13 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2461,9 +2461,8 @@ __latent_entropy struct task_struct *copy_process(
 	lockdep_init_task(p);
 #endif
 
-#ifdef CONFIG_DEBUG_MUTEXES
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
index a528e7f42caa..d7a202c35ebe 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -646,6 +646,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 			goto err_early_kill;
 	}
 
+	current->blocked_on = lock;
 	set_current_state(state);
 	trace_contention_begin(lock, LCB_F_MUTEX);
 	for (;;) {
@@ -683,6 +684,10 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 
 		first = __mutex_waiter_is_first(lock, &waiter);
 
+		/*
+		 * Gets reset by ttwu_runnable().
+		 */
+		current->blocked_on = lock;
 		set_current_state(state);
 		/*
 		 * Here we order against unlock; we must either see it change
@@ -720,6 +725,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 	debug_mutex_free_waiter(&waiter);
 
 skip_wait:
+	current->blocked_on = NULL;
 	/* got the lock - cleanup and rejoice! */
 	lock_acquired(&lock->dep_map, ip);
 	trace_contention_end(lock, 0);
@@ -734,6 +740,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 	return 0;
 
 err:
+	current->blocked_on = NULL;
 	__set_current_state(TASK_RUNNING);
 	__mutex_remove_waiter(lock, &waiter);
 err_early_kill:
diff --git a/kernel/locking/ww_mutex.h b/kernel/locking/ww_mutex.h
index 984a4e0bff36..7d623417b496 100644
--- a/kernel/locking/ww_mutex.h
+++ b/kernel/locking/ww_mutex.h
@@ -291,6 +291,12 @@ __ww_mutex_die(struct MUTEX *lock, struct MUTEX_WAITER *waiter,
 		debug_mutex_wake_waiter(lock, waiter);
 #endif
 		wake_q_add(&ww_ctx->wake_q, waiter->task);
+		/*
+		 * When waking up the task to die, be sure to clear the
+		 * blocked_on pointer. Otherwise we can see circular
+		 * blocked_on relationships that can't resolve.
+		 */
+		waiter->task->blocked_on = NULL;
 	}
 
 	return true;
@@ -336,9 +342,15 @@ static bool __ww_mutex_wound(struct MUTEX *lock,
 		 * it's wounded in __ww_mutex_check_kill() or has a
 		 * wakeup pending to re-read the wounded state.
 		 */
-		if (owner != current)
+		if (owner != current) {
 			wake_q_add(&ww_ctx->wake_q, owner);
-
+			/*
+			 * When waking up the task to wound, be sure to clear the
+			 * blocked_on pointer. Otherwise we can see circular
+			 * blocked_on relationships that can't resolve.
+			 */
+			owner->blocked_on = NULL;
+		}
 		return true;
 	}
 
-- 
2.41.0.rc0.172.g3f132b7071-goog

