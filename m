Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BF386DD0ED
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 06:27:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbjDKE06 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 00:26:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbjDKE0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 00:26:15 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EE0F3ABB
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 21:25:41 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-54c0c9de33aso136527787b3.15
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 21:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1681187140; x=1683779140;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=piEpuDYcKHF89nkEdwaozfXRx7wTZdEh3pdPf1YGVNw=;
        b=CjLzarKi92f1d0XLabTPl60LM/umqPJhbsLylM7t9Npvvm4ynJBk0RUKXBpPoWelfc
         zhAbTeSJkJRI40owH36KA/gxFo5LZWId1kXHdZdd5DbUbvdDSx9PBkmx1fe7vvOmElhc
         jyI9/6h2Vv3s055fhxir3/yeFpoCEJQ78/yWR/OCPLRqxiOrV4RCuKiEHbGMKxm7hOop
         jAoObY7mp9+VnhysRXKBy1QtxyrlT3lSZjOlYnAx/gaJmiFDsNr8z2tYXjTVeQWPk+35
         dquGQFXfkmTFmvv/2/YuMdiUgicXu0YA10chzue/RhZjYW5rjaBgCCcF/ed3pp+efTp7
         4j3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681187140; x=1683779140;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=piEpuDYcKHF89nkEdwaozfXRx7wTZdEh3pdPf1YGVNw=;
        b=J/MIWuGeFPj3W8MotfkBYF1PCeueuQwu+QtCjRDUvko7bvulN49W4+vcjG+x1b9Un4
         dzeOMOHqIPzkBkIbfWSD0WUvr78kbeXXZZvESP5dEzWeAYs7gnDcK8mXyvHYi77pvWIG
         EbCVubYpGAl5y0EWv/FiXnvifYCcjzopOUDTjxxzoCoXDyzajYWqwtycxKBeo9ItMJA3
         540mpNPOOtVOZivqxPYiBWOChnwFpko9whixf6rN+knPdwdVv3VVKAEcvqj4VIVDIZO7
         ZBroQXDECpch4NoMuH4LlxB5ZGE/rRph5sDdexqpM712dwcm//0SoEx/zU8/HPX+neU4
         hzuw==
X-Gm-Message-State: AAQBX9ecG4zSkVbiXZmE/vhXyLn9sKgJT812O3uh3H3Mwz/eyx+8MAo7
        qWOozy3tVgluY8nzG75jrD1kEyLw4lFaDb+kbDfD2FZ4aw8Br4OoEBbgVtzL2EqVRT0MmcPzefu
        Pym74oia2i6q2JRxaeO/FyfZFU2Q90vI2LcjfIR2u9pQGcByUZwYS6y3sQbxgMu8WSgcf5GY=
X-Google-Smtp-Source: AKy350YWruGP+bJKTaBSiq8DZf396qHcrMA0NFOfxhcsQzWyUR+5HibNc4baZmAaQkP91r0Eyuj2q59zQKqF
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a05:690c:1:b0:544:bbd2:74be with SMTP id
 bc1-20020a05690c000100b00544bbd274bemr8499842ywb.4.1681187139908; Mon, 10 Apr
 2023 21:25:39 -0700 (PDT)
Date:   Tue, 11 Apr 2023 04:25:09 +0000
In-Reply-To: <20230411042511.1606592-1-jstultz@google.com>
Mime-Version: 1.0
References: <20230411042511.1606592-1-jstultz@google.com>
X-Mailer: git-send-email 2.40.0.577.gac1e443424-goog
Message-ID: <20230411042511.1606592-13-jstultz@google.com>
Subject: [PATCH v3 12/14] sched/rt: Fix proxy/current (push,pull)ability
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
        "Paul E . McKenney" <paulmck@kernel.org>,
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
blocked_proxy |   mutex
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
Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Connor O'Brien <connoro@google.com>
Signed-off-by: John Stultz <jstultz@google.com>
---
v3:
* Tweaked comments & commit message

TODO: Rework the wording of the commit message to match the rq_selected
renaming. (XXX Maybe "Delegator" for the task being proxied for?)
---
 kernel/sched/core.c | 37 +++++++++++++++++++++++++++----------
 kernel/sched/rt.c   | 22 +++++++++++++++++-----
 2 files changed, 44 insertions(+), 15 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 1d92f1a304b8..033856bae002 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7072,12 +7072,29 @@ proxy(struct rq *rq, struct task_struct *next, struct rq_flags *rf)
 	WARN_ON_ONCE(!owner->on_rq);
 	return owner;
 }
+
+static inline void proxy_tag_curr(struct rq *rq, struct task_struct *next)
+{
+	/*
+	 * pick_next_task() calls set_next_task() on the selected task
+	 * at some point, which ensures it is not push/pullable.
+	 * However, the selected task *and* the ,mutex owner form an
+	 * atomic pair wrt push/pull.
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
@@ -7126,6 +7143,7 @@ static void __sched notrace __schedule(unsigned int sched_mode)
 	unsigned long prev_state;
 	struct rq_flags rf;
 	struct rq *rq;
+	bool proxied;
 	int cpu;
 	bool preserve_need_resched = false;
 
@@ -7199,20 +7217,11 @@ static void __sched notrace __schedule(unsigned int sched_mode)
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
@@ -7261,6 +7270,10 @@ static void __sched notrace __schedule(unsigned int sched_mode)
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
@@ -7285,6 +7298,10 @@ static void __sched notrace __schedule(unsigned int sched_mode)
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
index 5ce48eb8f5b6..af92e4147703 100644
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
2.40.0.577.gac1e443424-goog

