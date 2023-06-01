Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ABF57192D9
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 07:59:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231757AbjFAF7c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 01:59:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231454AbjFAF7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 01:59:23 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51EDC134
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 22:59:05 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-53f6f7d1881so501768a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 22:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685599145; x=1688191145;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tA6ilenfOVCfqFhRPW4Q4OY0y2aBdfOYBjx4iLdDwxg=;
        b=uu0J52T7qkJscVOK+7yZFuNHChkY0GtIR0E7rv/znylDY1txNu0fcXPhTO3RrOWXiH
         FKxkrh91Okg9+vhSl4s6hK0g7sxWjwUOuoSnDNp1ksWF3GZHI6YIe9I75iVdNFRkBMKV
         TjthkIwJBICMU6e+6kEjpZtvjrpby4RjpYFomTkPjtvEXSTcYCgbkssqnnc9K0WSdk25
         To3zQQA3qhG4TFEZ9mLaeIkm1c5yg2XoLH9wLDcT1afc/SPsa8xBnnH/cs6IRsspfWld
         d0p4zy53AgJD8flnmHvJeQTkCs1U2bUkPEKyAvupVLtFulrEnhz4aPytEsS+GgLkJNrM
         5c4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685599145; x=1688191145;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tA6ilenfOVCfqFhRPW4Q4OY0y2aBdfOYBjx4iLdDwxg=;
        b=WnZK6N45JutQ4DCcaNtt4m3HZyzeILuPTNap3rYK39BAVFENl+2M+EWvex55/VUFVD
         3WVIfORQS5gUqimZxji+t8y9wqUmtRrg54Hj/6dt34VgLdLWUvCgq45eny9Zr0k1XFRr
         JUMwaArwmD1NXL8vAkuMSm1ca7842VlIWiwczBeJ3tNxVYyZuextf/mWiqozh8VBmxrN
         4pmjK+jcUltQ5oredebpFMjMCaeeEUKppzl/R12zcHaCqnXnpKYQ4PuXpmFPRdQ223NI
         XtNk6rj3uvPW3X48g1o/HS4zwnqmHnv1QqrAxren49o8obM59c2yVdn/cx/QY4uQYcpn
         6TJg==
X-Gm-Message-State: AC+VfDz0ZdQrC4cNYvdlvgOYnx4tjQ8FOmJzZAnCbndT+GeUdkv/RZHo
        cit17ox73ctB2Qz95j1ttu0imazbGqtKY1UtSru+qHu8Uo9+wBEM5GB1fAqyNdx37BGVF82Kxac
        qhuZ3jYS4e1RyuRTmwoot7qtKY5culOnyV3+nrGrIZgOXG8pCNMYSl+vl5bRNbeDTEcH3O4o=
X-Google-Smtp-Source: ACHHUZ54FztApJjDueu0/LmkVbt/bJ5UP2ez5eKigt0JjhWe9SE6G5UjKN5mHPKh6fQgPYF9BRaL94HcaKhd
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a63:d044:0:b0:53f:32cf:bcd1 with SMTP id
 s4-20020a63d044000000b0053f32cfbcd1mr1588583pgi.5.1685599144613; Wed, 31 May
 2023 22:59:04 -0700 (PDT)
Date:   Thu,  1 Jun 2023 05:58:08 +0000
In-Reply-To: <20230601055846.2349566-1-jstultz@google.com>
Mime-Version: 1.0
References: <20230601055846.2349566-1-jstultz@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Message-ID: <20230601055846.2349566-6-jstultz@google.com>
Subject: [PATCH v4 05/13] locking/mutex: Add task_struct::blocked_lock to
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
[jstultz: Split out from bigger patch]
Signed-off-by: John Stultz <jstultz@google.com>
---
v2:
* Split out into its own patch
v4:
* Remove verbose comments/questions to avoid review
  distractions, as suggested by Dietmar
* Fixed nested block_on locking for ww_mutex access
---
 include/linux/sched.h     |  1 +
 init/init_task.c          |  1 +
 kernel/fork.c             |  1 +
 kernel/locking/mutex.c    | 22 ++++++++++++++++++----
 kernel/locking/ww_mutex.h |  6 ++++++
 5 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index a312a2ff47bf..6b0d4b398b31 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1142,6 +1142,7 @@ struct task_struct {
 #endif
 
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
index 9244c540bb13..1ea1b2d527bb 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2359,6 +2359,7 @@ __latent_entropy struct task_struct *copy_process(
 	ftrace_graph_init_task(p);
 
 	rt_mutex_init_task(p);
+	raw_spin_lock_init(&p->blocked_lock);
 
 	lockdep_assert_irqs_enabled();
 #ifdef CONFIG_PROVE_LOCKING
diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index d7a202c35ebe..ac3d2e350fac 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -616,6 +616,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 	}
 
 	raw_spin_lock_irqsave(&lock->wait_lock, flags);
+	raw_spin_lock(&current->blocked_lock);
 	/*
 	 * After waiting to acquire the wait_lock, try again.
 	 */
@@ -677,6 +678,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 				goto err;
 		}
 
+		raw_spin_unlock(&current->blocked_lock);
 		raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
 		if (ww_ctx)
 			ww_ctx_wake(ww_ctx);
@@ -684,6 +686,8 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 
 		first = __mutex_waiter_is_first(lock, &waiter);
 
+		raw_spin_lock_irqsave(&lock->wait_lock, flags);
+		raw_spin_lock(&current->blocked_lock);
 		/*
 		 * Gets reset by ttwu_runnable().
 		 */
@@ -698,15 +702,23 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 			break;
 
 		if (first) {
+			bool acquired;
+
+			/*
+			 * mutex_optimistic_spin() can schedule, so  we need to
+			 * release these locks before calling it.
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
 
@@ -733,6 +745,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 	if (ww_ctx)
 		ww_mutex_lock_acquired(ww, ww_ctx);
 
+	raw_spin_unlock(&current->blocked_lock);
 	raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
 	if (ww_ctx)
 		ww_ctx_wake(ww_ctx);
@@ -745,6 +758,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 	__mutex_remove_waiter(lock, &waiter);
 err_early_kill:
 	trace_contention_end(lock, ret);
+	raw_spin_unlock(&current->blocked_lock);
 	raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
 	debug_mutex_free_waiter(&waiter);
 	mutex_release(&lock->dep_map, ip);
diff --git a/kernel/locking/ww_mutex.h b/kernel/locking/ww_mutex.h
index 7d623417b496..8378b533bb1e 100644
--- a/kernel/locking/ww_mutex.h
+++ b/kernel/locking/ww_mutex.h
@@ -287,6 +287,8 @@ __ww_mutex_die(struct MUTEX *lock, struct MUTEX_WAITER *waiter,
 		return false;
 
 	if (waiter->ww_ctx->acquired > 0 && __ww_ctx_less(waiter->ww_ctx, ww_ctx)) {
+		/* nested as we should hold current->blocked_lock already */
+		raw_spin_lock_nested(&waiter->task->blocked_lock, SINGLE_DEPTH_NESTING);
 #ifndef WW_RT
 		debug_mutex_wake_waiter(lock, waiter);
 #endif
@@ -297,6 +299,7 @@ __ww_mutex_die(struct MUTEX *lock, struct MUTEX_WAITER *waiter,
 		 * blocked_on relationships that can't resolve.
 		 */
 		waiter->task->blocked_on = NULL;
+		raw_spin_unlock(&waiter->task->blocked_lock);
 	}
 
 	return true;
@@ -343,6 +346,8 @@ static bool __ww_mutex_wound(struct MUTEX *lock,
 		 * wakeup pending to re-read the wounded state.
 		 */
 		if (owner != current) {
+			/* nested as we should hold current->blocked_lock already */
+			raw_spin_lock_nested(&owner->blocked_lock, SINGLE_DEPTH_NESTING);
 			wake_q_add(&ww_ctx->wake_q, owner);
 			/*
 			 * When waking up the task to wound, be sure to clear the
@@ -350,6 +355,7 @@ static bool __ww_mutex_wound(struct MUTEX *lock,
 			 * blocked_on relationships that can't resolve.
 			 */
 			owner->blocked_on = NULL;
+			raw_spin_unlock(&owner->blocked_lock);
 		}
 		return true;
 	}
-- 
2.41.0.rc0.172.g3f132b7071-goog

