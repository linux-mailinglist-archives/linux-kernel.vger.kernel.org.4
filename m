Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51BFE6C25BF
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 00:38:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbjCTXi3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 19:38:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbjCTXiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 19:38:08 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FF5337F3D
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 16:37:51 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id d34-20020a630e22000000b005039e28b68cso3051426pgl.13
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 16:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679355469;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3nt7ktkvxxILsehranU+Miwg4EJn7JcE65bPTJJiIlM=;
        b=MF7ny7k+jssj98HAIfBEfXAGt5f6xTZ6NXWRScj/3l59EBWUXAzLO577sUq8POXjxO
         0Uhcj1ybV2CbguQahw7a6vht0nAbw1cs3ffypEi0Zal1ml+dLsKjKX7XtH9SZAcxapEc
         7QbOurbJk24Iwk39AYpHx5LHMJVAte0yLQoUQTcjcnEGvNN1ZCcnbZ1W3dT0HeQf7Akf
         +u9F//JdmQ/Ol/rKgV3/hRw4U5CezGKZ/7fwS5vTCn1rtKPP+3PLMph2sFDkbjSSmNxt
         xVoSMuX4ry5bjgRhraJqGrzQPc2JX292z0CgTj0UZf3vpfMunleeu09jktvHvmcJW3O8
         yHuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679355469;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3nt7ktkvxxILsehranU+Miwg4EJn7JcE65bPTJJiIlM=;
        b=FfnZMOOTIzStaThs5SmPDY3SBxXY5DC3LNvfDipRqq9BxLEr9mPljGBdEipKC4cip2
         nbHwvfH5Dy8nzNdYGF7BeolyjR2e2CMfoVAEmYTezSPmwpgIZg7UVSpqvTsCnV9IKbp0
         RUShQQ9jGxpZ2w46g899d5l+r5Zd97vEbwbvXVUfj46JJjikOLGY1Oxa3+kYRgI0orRp
         cYg8d85IVggCWyKt9F1Wt9/rRO+KZcluDE+IpZs9iLp/IOn4NSE1jJqwm7Hq2QFpvaKC
         BfVT0DlAkqwPwiyzbqPjB2Itrc5D/nObJEh6dVPEngTyTwcGV2CLQeqv4Qs50ngZuny5
         0pjQ==
X-Gm-Message-State: AO0yUKV4LjKfB3Uvhxkat14VD3sEy86fBJ1y6imfObu6fXwN5Ftzxwqs
        r2ivyUijCLGO5aQxtttIVoStZ/hN0pbDY8cvjVFuyPaCOn9Ob+3IpF7RVfG/8jJXFPk9j8WdbvB
        gN6dctnXlqxX1zbEN9/DkPHC89PaAa9HiW9a+5hNi4hODmVTnh8WBp6Lpj5Z5rCW9HcQYB/w=
X-Google-Smtp-Source: AK7set97brf64S96UP/Qz5wMFe2nigJaJ2POxcaCgJQsuEnuRs3y8pcM2SanOJ5MS8d+hkNWZ9+EuG5hT8OT
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a05:6a00:b4f:b0:623:7446:7075 with SMTP id
 p15-20020a056a000b4f00b0062374467075mr332785pfo.2.1679355469525; Mon, 20 Mar
 2023 16:37:49 -0700 (PDT)
Date:   Mon, 20 Mar 2023 23:37:19 +0000
In-Reply-To: <20230320233720.3488453-1-jstultz@google.com>
Mime-Version: 1.0
References: <20230320233720.3488453-1-jstultz@google.com>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
Message-ID: <20230320233720.3488453-12-jstultz@google.com>
Subject: [PATCH v2 11/12] sched/rt: Fix proxy/current (push,pull)ability
From:   John Stultz <jstultz@google.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
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

From: Valentin Schneider <valentin.schneider@arm.com>

Proxy execution forms atomic pairs of tasks: a proxy (scheduling context)
and an owner (execution context). The proxy, along with the rest of the
blocked chain, follows the owner wrt CPU placement.

They can be the same task, in which case push/pull doesn't need any
modification. When they are different, however,
FIFO1 & FIFO42:

	     ,->  RT42
	     |     | blocked-on
	     |     v
  proxied-by |   mutex
	     |     | owner
	     |     v
	     `--  RT1

   RT1
   RT42

  CPU0            CPU1
   ^                ^
   |                |
  overloaded    !overloaded
  rq prio = 42  rq prio = 0

RT1 is eligible to be pushed to CPU1, but should that happen it will
"carry" RT42 along. Clearly here neither RT1 nor RT42 must be seen as
push/pullable.

Furthermore, tasks becoming blocked on a mutex don't need an explicit
dequeue/enqueue cycle to be made (push/pull)able: they have to be running
to block on a mutex, thus they will eventually hit put_prev_task().

XXX: pinned tasks becoming unblocked should be removed from the push/pull
lists, but those don't get to see __schedule() straight away.

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
Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Connor O'Brien <connoro@google.com>
Signed-off-by: John Stultz <jstultz@google.com>
---
 kernel/sched/core.c | 36 ++++++++++++++++++++++++++----------
 kernel/sched/rt.c   | 22 +++++++++++++++++-----
 2 files changed, 43 insertions(+), 15 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index d0f86670bdf8..11138277c7c8 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7062,12 +7062,28 @@ proxy(struct rq *rq, struct task_struct *next, struct rq_flags *rf)
 	WARN_ON_ONCE(!owner->on_rq);
 	return owner;
 }
+
+static inline void proxy_tag_curr(struct rq *rq, struct task_struct *next)
+{
+	/*
+	 * pick_next_task() calls set_next_task() on the proxy at some
+	 * point, which ensures it is not push/pullable. However, the
+	 * proxy *and* the owner form an atomic pair wrt push/pull.
+	 *
+	 * Make sure owner is not pushable. Unfortunately we can only
+	 * deal with that by means of a dequeue/enqueue cycle. :-/
+	 */
+	dequeue_task(rq, next, DEQUEUE_NOCLOCK | DEQUEUE_SAVE);
+	enqueue_task(rq, next, ENQUEUE_NOCLOCK | ENQUEUE_RESTORE);
+}
 #else /* PROXY_EXEC */
 static struct task_struct *
 proxy(struct rq *rq, struct task_struct *next, struct rq_flags *rf)
 {
 	return next;
 }
+
+static inline void proxy_tag_curr(struct rq *rq, struct task_struct *next) { }
 #endif /* PROXY_EXEC */
 
 /*
@@ -7116,6 +7132,7 @@ static void __sched notrace __schedule(unsigned int sched_mode)
 	unsigned long prev_state;
 	struct rq_flags rf;
 	struct rq *rq;
+	bool proxied;
 	int cpu;
 	bool preserve_need_resched = false;
 
@@ -7189,20 +7206,11 @@ static void __sched notrace __schedule(unsigned int sched_mode)
 				atomic_inc(&rq->nr_iowait);
 				delayacct_blkio_start();
 			}
-		} else {
-			/*
-			 * XXX
-			 * Let's make this task, which is blocked on
-			 * a mutex, (push/pull)able (RT/DL).
-			 * Unfortunately we can only deal with that by
-			 * means of a dequeue/enqueue cycle. :-/
-			 */
-			dequeue_task(rq, prev, 0);
-			enqueue_task(rq, prev, 0);
 		}
 		switch_count = &prev->nvcsw;
 	}
 
+	proxied = !!prev->blocked_proxy;
 pick_again:
 	/*
 	 * If picked task is actually blocked it means that it can act as a
@@ -7244,6 +7252,10 @@ static void __sched notrace __schedule(unsigned int sched_mode)
 		 * changes to task_struct made by pick_next_task().
 		 */
 		rq_set_curr_rcu_init(rq, next);
+
+		if (unlikely(!task_current_proxy(rq, next)))
+			proxy_tag_curr(rq, next);
+
 		/*
 		 * The membarrier system call requires each architecture
 		 * to have a full memory barrier after updating
@@ -7268,6 +7280,10 @@ static void __sched notrace __schedule(unsigned int sched_mode)
 		/* Also unlocks the rq: */
 		rq = context_switch(rq, prev, next, &rf);
 	} else {
+		/* In case next was already curr but just got blocked_proxy */
+		if (unlikely(!proxied && next->blocked_proxy))
+			proxy_tag_curr(rq, next);
+
 		rq->clock_update_flags &= ~(RQCF_ACT_SKIP|RQCF_REQ_SKIP);
 
 		rq_unpin_lock(rq, &rf);
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index d1c5a022eae4..419270b0918e 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1537,9 +1537,21 @@ enqueue_task_rt(struct rq *rq, struct task_struct *p, int flags)
 
 	enqueue_rt_entity(rt_se, flags);
 
-	if (!task_current(rq, p) && p->nr_cpus_allowed > 1 &&
-	    !task_is_blocked(p))
-		enqueue_pushable_task(rq, p);
+	/*
+	 * Current can't be pushed away. Proxy is tied to current, so don't
+	 * push it either.
+	 */
+	if (task_current(rq, p) || task_current_proxy(rq, p))
+		return;
+
+	/*
+	 * Pinned tasks can't be pushed.
+	 * Affinity of blocked tasks doesn't matter.
+	 */
+	if (!task_is_blocked(p) && p->nr_cpus_allowed == 1)
+		return;
+
+	enqueue_pushable_task(rq, p);
 }
 
 static void dequeue_task_rt(struct rq *rq, struct task_struct *p, int flags)
@@ -1832,9 +1844,9 @@ static void put_prev_task_rt(struct rq *rq, struct task_struct *p)
 
 	/*
 	 * The previous task needs to be made eligible for pushing
-	 * if it is still active
+	 * if it is still active. Affinity of blocked task doesn't matter.
 	 */
-	if (on_rt_rq(&p->rt) && p->nr_cpus_allowed > 1)
+	if (on_rt_rq(&p->rt) && (p->nr_cpus_allowed > 1 || task_is_blocked(p)))
 		enqueue_pushable_task(rq, p);
 }
 
-- 
2.40.0.rc1.284.g88254d51c5-goog

