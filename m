Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71DA05F3806
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 23:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbiJCVqR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 17:46:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiJCVpw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 17:45:52 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01D281E708
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 14:45:20 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id g3-20020a17090a7d0300b0020a644c7ff9so2918917pjl.7
        for <linux-kernel@vger.kernel.org>; Mon, 03 Oct 2022 14:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=Mnda/qahpa2pvZaDgTXjk2mSGFQBIr6Oa8fowc4pnVs=;
        b=McBXEq6H2g/BjHmQxXYOnQstF1hY21mqrrF2W4hDcxqY8tLN4iAyXaZK5+ndvrkRo7
         CuUMavA6QHCfjSnXHtAsnLdSOeOPPMn2lapneoruYrzn0o6yC1XJpxY4GVYJFTr/uVO8
         x3d0WqXNqwgka0ppOSQa8MgSOQt+VfQox3BRgTm8TchKrF8cJGquCVWsbelzk83GChex
         CA7/ZFLynh/2dFr6TWsuxFzcmpmafzZxpOJVMOtnR1cvG7LAt/89QMX8Y3dKzuWm2ITi
         VKFFN41o3hezakbE68qgoHrcFPD/yZB0u/ca7C5mGFzC3xg45wx48fnMCWGcpMaUJOnB
         pgYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=Mnda/qahpa2pvZaDgTXjk2mSGFQBIr6Oa8fowc4pnVs=;
        b=QMxnXHAoNhvxPcgeV1m4sBv/FlRb5U7COVQjr8iUZWaHJ+ZHSI3cWf1xceAqqVOf6a
         T7wTsde/MoIU5r5gdGE/62O2/reASmS+0pN8qj1U3RbR4RMlM8QnRVYQuVSJGsHjYsgV
         e16aVo5Rs7yZP7o08l/IjRapagFzeYYmmqhEQeO1e/Q0sRZOuaM5vrSZbhCQyXxKVtAO
         fq0jb1SJQ9hwOh4/WwKZD5MuHPeKbmgj1101RY/q+0VEkiTzoqbInCcC3QQscgg8INIV
         LDnjq6ZrJ4IbocAtJqP8V56m7/oIlN2nuIgq/WERRq3beNVuFrIooksH3LfqEusQTjt6
         gVng==
X-Gm-Message-State: ACrzQf1dEfnqniIWDLXZ84sjovfJOqHTDJn3n1h10hGCOXr0WnDRnlQ1
        ombhjw+qVUZT9qjgeTgzkJ9VuAuT1RwNwjXjZd0P5kwpb6E4Qlc59gvZftB0e/AZsc/1/WuM59Z
        LO4QoApJRR/jOvDA3kjW5kTuDFNw0iokVDPrY3/pG3GXUh3E4MaOvmtbWJ0ilwDI8/SvdEzeG
X-Google-Smtp-Source: AMsMyM6EJxHenJsWm2lr21tQ/rSiKkwSCyVv6VKbbDz2Rzy4Qmh9IFIWGWl/yWZqgDuQyk9URHG+MvAjrR6Y
X-Received: from connoro.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:a99])
 (user=connoro job=sendgmr) by 2002:a05:6a00:2491:b0:544:2599:6f08 with SMTP
 id c17-20020a056a00249100b0054425996f08mr23966678pfv.47.1664833519706; Mon,
 03 Oct 2022 14:45:19 -0700 (PDT)
Date:   Mon,  3 Oct 2022 21:44:59 +0000
In-Reply-To: <20221003214501.2050087-1-connoro@google.com>
Mime-Version: 1.0
References: <20221003214501.2050087-1-connoro@google.com>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Message-ID: <20221003214501.2050087-10-connoro@google.com>
Subject: [RFC PATCH 09/11] sched/rt: Fix proxy/current (push,pull)ability
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

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Connor O'Brien <connoro@google.com>
---
 kernel/sched/core.c | 36 ++++++++++++++++++++++++++----------
 kernel/sched/rt.c   | 22 +++++++++++++++++-----
 2 files changed, 43 insertions(+), 15 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index ad2e7b49f98e..88a5fa34dc06 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6891,12 +6891,28 @@ proxy(struct rq *rq, struct task_struct *next, struct rq_flags *rf)
 
 	return NULL; /* retry task selection */
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
@@ -6945,6 +6961,7 @@ static void __sched notrace __schedule(unsigned int sched_mode)
 	unsigned long prev_state;
 	struct rq_flags rf;
 	struct rq *rq;
+	bool proxied;
 	int cpu;
 
 	cpu = smp_processor_id();
@@ -7017,20 +7034,11 @@ static void __sched notrace __schedule(unsigned int sched_mode)
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
@@ -7061,6 +7069,10 @@ static void __sched notrace __schedule(unsigned int sched_mode)
 		 * changes to task_struct made by pick_next_task().
 		 */
 		RCU_INIT_POINTER(rq->curr, next);
+
+		if (unlikely(!task_current_proxy(rq, next)))
+			proxy_tag_curr(rq, next);
+
 		/*
 		 * The membarrier system call requires each architecture
 		 * to have a full memory barrier after updating
@@ -7085,6 +7097,10 @@ static void __sched notrace __schedule(unsigned int sched_mode)
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
index 09385fcb1713..a99a59b2b246 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1548,9 +1548,21 @@ enqueue_task_rt(struct rq *rq, struct task_struct *p, int flags)
 
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
@@ -1841,9 +1853,9 @@ static void put_prev_task_rt(struct rq *rq, struct task_struct *p)
 
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
2.38.0.rc1.362.ged0d419d3c-goog

