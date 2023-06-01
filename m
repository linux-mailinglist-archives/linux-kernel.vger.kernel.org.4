Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16CAE7192E0
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 08:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231788AbjFAGAZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 02:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231384AbjFAF7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 01:59:39 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30FD7E44
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 22:59:15 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5659c7dad06so7675827b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 22:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685599154; x=1688191154;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=akU7syuB1Kx4qpn7Uy+Yr+VxoiONi5TpTWs8ayG4zr0=;
        b=m4fwMK5bDUCAE+/OfwoTw/BIlN4EhbQ18rCUTHajji86kngwCfEn7ejf/syIqockRx
         t+PB7dPxWdmH4htk6K3SasBf2sOtJaTxpWAA/kRqvvC3qRzTtKtLvoVTp8SlJ7ZQuLVd
         3DwIzipvceN/tkYnmm6J1iPKQTJ2tlda1cqj1t3WqyMpBIB+aqrqVgn5h+OzvMkTIYVQ
         ONjFWYQN/kkcTzKv3tcTvBrlaD4xyi7iB7omNfI8hhfKs+BYc8nt/tjiBVyrEg59XETV
         7RrWno+kd7klPCWmedw1TQ73FEEgy5xycJ3npqOqqQe643+DiyFB9YDFX9Sr0WibCb0q
         TAXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685599154; x=1688191154;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=akU7syuB1Kx4qpn7Uy+Yr+VxoiONi5TpTWs8ayG4zr0=;
        b=HlXc3L2novZnX2aLzBro79PZgnw4Oin2f2nvuLd/AkMHPj/mWVnJjiq9MhvZbCs+dB
         BCjBkl5bB9dYM3wgjGAnJ4M8tUtw3r4nmtnmkqxjXdJwZwUil4EeL+qfQejx6ianszeb
         K1b6/UcbOzdGsWgv7syrC09PgVlMYNhzosw06BPVnEC8U8qrwh4jQLO1Zd1ktAnx/6hX
         SeePt5SaQtYBoOvzMtuCT38Fk+4fvvwVskIT/mX/z1RbD4aZ4Y/A3k+Fm1qb59OzjXTb
         +x3arKMKcD+DyZ/ahSbXscrOmsDYev+XZqNltTEkGBgGZo3kC1x8VAwlryivz2em6sse
         WxxA==
X-Gm-Message-State: AC+VfDwRmOW6i54WXgAeIyUS1RO836S9Rzws0rYWR0PLeJ3i1xpK22Io
        271QDRZ2NTrUsV6gk+SILBLfVX0VfhDLTG81Grt/o/rKK6YO7uqjDF64lpfrC1js15PtfUCDBMc
        ycbDLYUimstIRAk8mVU851hG+KOXH/ZHw5v5WAdT2Vt5VGcbXv2rtelv34b9BAMVb1bJk7z8=
X-Google-Smtp-Source: ACHHUZ7Yx13lcijwiBfNbyigouS/PkQ3hC4O1oFFkjiKEUdNj48UqOUa0y+3XHux3gDMgHXHasPHaRPgn2pW
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a81:e244:0:b0:565:ba68:3c2 with SMTP id
 z4-20020a81e244000000b00565ba6803c2mr4728822ywl.8.1685599153883; Wed, 31 May
 2023 22:59:13 -0700 (PDT)
Date:   Thu,  1 Jun 2023 05:58:13 +0000
In-Reply-To: <20230601055846.2349566-1-jstultz@google.com>
Mime-Version: 1.0
References: <20230601055846.2349566-1-jstultz@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Message-ID: <20230601055846.2349566-11-jstultz@google.com>
Subject: [PATCH v4 10/13] sched/rt: Fix proxy/current (push,pull)ability
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
blocked_donor |   mutex
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
Cc: Youssef Esmat <youssefesmat@google.com>
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
v3:
* Tweaked comments & commit message

TODO: Rework the wording of the commit message to match the rq_selected
renaming. (XXX Maybe "Delegator" for the task being proxied for?)
---
 kernel/sched/core.c | 36 +++++++++++++++++++++++++++---------
 kernel/sched/rt.c   | 22 +++++++++++++++++-----
 2 files changed, 44 insertions(+), 14 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 328776421c7a..c56921dc427e 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6989,12 +6989,29 @@ proxy(struct rq *rq, struct task_struct *next, struct rq_flags *rf)
 	WARN_ON_ONCE(owner && !owner->on_rq);
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
@@ -7043,6 +7060,7 @@ static void __sched notrace __schedule(unsigned int sched_mode)
 	unsigned long prev_state;
 	struct rq_flags rf;
 	struct rq *rq;
+	bool proxied;
 	int cpu;
 	bool preserve_need_resched = false;
 
@@ -7116,19 +7134,11 @@ static void __sched notrace __schedule(unsigned int sched_mode)
 				atomic_inc(&rq->nr_iowait);
 				delayacct_blkio_start();
 			}
-		} else {
-			/*
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
 
+	proxied = !!prev->blocked_donor;
 pick_again:
 	/*
 	 * If picked task is actually blocked it means that it can act as a
@@ -7165,6 +7175,10 @@ static void __sched notrace __schedule(unsigned int sched_mode)
 		 * changes to task_struct made by pick_next_task().
 		 */
 		RCU_INIT_POINTER(rq->curr, next);
+
+		if (unlikely(!task_current_selected(rq, next)))
+			proxy_tag_curr(rq, next);
+
 		/*
 		 * The membarrier system call requires each architecture
 		 * to have a full memory barrier after updating
@@ -7189,6 +7203,10 @@ static void __sched notrace __schedule(unsigned int sched_mode)
 		/* Also unlocks the rq: */
 		rq = context_switch(rq, prev, next, &rf);
 	} else {
+		/* In case next was already curr but just got blocked_donor*/
+		if (unlikely(!proxied && next->blocked_donor))
+			proxy_tag_curr(rq, next);
+
 		rq->clock_update_flags &= ~(RQCF_ACT_SKIP|RQCF_REQ_SKIP);
 
 		rq_unpin_lock(rq, &rf);
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index f5b1075e8170..d6bffcf31de0 100644
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
+	if (task_current(rq, p) || task_current_selected(rq, p))
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
@@ -1828,9 +1840,9 @@ static void put_prev_task_rt(struct rq *rq, struct task_struct *p)
 
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
2.41.0.rc0.172.g3f132b7071-goog

