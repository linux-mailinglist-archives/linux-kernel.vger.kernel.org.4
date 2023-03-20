Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 812496C25B7
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 00:38:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbjCTXiB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 19:38:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbjCTXhq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 19:37:46 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84521360BA
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 16:37:42 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-541942bfdccso137613757b3.14
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 16:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679355461;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=EXUPFRWvUoPWNb0Il/ErV9BdLrNKUbzckVL5LhCzOk4=;
        b=pWAdfG1JiAKkpg0IlCiD+BBXZ0EifdhaAyoftNYcou9kXETlE0oYJJM0NJNk9yM2U/
         prYlyGJE3y1ZxNz2bQsJzbpiMOvWCykB1bbPgK9nKA7aJf2PQeGOsfRv0SXFOURXO53w
         Tjn3CSkX/tkzMJa1HxYXAn3jyDJaSY1EmDeoi3bY7hWy1y3fDW6KWZhn91TJP39zARdN
         ZLXEhRCMZhVvPjPaAjJo0NQdkMi6QvsI+CGgODe9es36meDQuxCzs/40flqq3tGNj6Ud
         DiCfSOqWIwBkcdH4d5I8wUX1ewxumSefVyeyCmiHHp1Ph2C+8mowNig8zMvzoZiLGnmn
         T9Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679355461;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EXUPFRWvUoPWNb0Il/ErV9BdLrNKUbzckVL5LhCzOk4=;
        b=sQT5GjY7r7X+5y5nnqm6sWEud43XxL+j2UpeOKNCoA4FoHikKYdbj8Z36Fy1InMPnH
         /XuXOIbUdQ+iAIznDmjdl13fSuXrlWn6YHWwEkDBoJkTwvIoj5KJ8F797L+uv5XaqnkA
         88I5UQBBSrgY2jlVkwvlbQBXvU64oCK2SEk6akToZyA0KWo+6cHeysWEYwGYQRt4gfwN
         2hTWkBAM4J93c4aUuQQVWGUuoWE50AsWxwW+BiYdy2w8OJCG9mMPXlY3uk3MbHpcBp5W
         Vl0eeDlSLxxd40cJAgnURdpRJcsTCDlQBhHiVYfcvEzdKrLPgVSIie4D3rSmCvnCjRTo
         AESg==
X-Gm-Message-State: AAQBX9ebAr6HfdCBBh4mq1+pbTEFq2Igz5il6Pcw37lxtiQKmFaskO5T
        EqLDV+IBp8d6/RSLMmv4SJ3HpegUTZpYgO4y6zYItxGCE/iA2DrO1cjTN5/elE31SWZ0xR15Mar
        YlXOd1C5g/NSwCtESpu/IXesoE1BUXq68EEli1VkLR6PM1mUEW42C9FN1/V90NOg0Fq2JHkY=
X-Google-Smtp-Source: AKy350amAtvhiAxdj/BOy1vM9OZ+kNn41zo1h/kbWLNB5E08I6tITn6A+ga7mFbBfm6L9JF8to9AnCgh0lFg
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a05:6902:1503:b0:acd:7374:f154 with SMTP
 id q3-20020a056902150300b00acd7374f154mr215625ybu.7.1679355461180; Mon, 20
 Mar 2023 16:37:41 -0700 (PDT)
Date:   Mon, 20 Mar 2023 23:37:14 +0000
In-Reply-To: <20230320233720.3488453-1-jstultz@google.com>
Mime-Version: 1.0
References: <20230320233720.3488453-1-jstultz@google.com>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
Message-ID: <20230320233720.3488453-7-jstultz@google.com>
Subject: [PATCH v2 06/12] sched: Unify runtime accounting across classes
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

All classes use sched_entity::exec_start to track runtime and have
copies of the exact same code around to compute runtime.

Collapse all that.

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
[fix conflicts, fold in update_current_exec_runtime]
Signed-off-by: Connor O'Brien <connoro@google.com>
[jstultz: rebased, resovling minor conflicts]
Signed-off-by: John Stultz <jstultz@google.com>
---
 include/linux/sched.h    |  2 +-
 kernel/sched/deadline.c  | 13 +++-------
 kernel/sched/fair.c      | 56 ++++++++++++++++++++++++++++++----------
 kernel/sched/rt.c        | 13 +++-------
 kernel/sched/sched.h     | 12 ++-------
 kernel/sched/stop_task.c | 13 +---------
 6 files changed, 52 insertions(+), 57 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index a1606d0bd3fe..fc75fcc696db 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -519,7 +519,7 @@ struct sched_statistics {
 	u64				block_max;
 	s64				sum_block_runtime;
 
-	u64				exec_max;
+	s64				exec_max;
 	u64				slice_max;
 
 	u64				nr_migrations_cold;
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 71b24371a6f7..5a7c4edd5b13 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1308,9 +1308,8 @@ static void update_curr_dl(struct rq *rq)
 {
 	struct task_struct *curr = rq->curr;
 	struct sched_dl_entity *dl_se = &curr->dl;
-	u64 delta_exec, scaled_delta_exec;
+	s64 delta_exec, scaled_delta_exec;
 	int cpu = cpu_of(rq);
-	u64 now;
 
 	if (!dl_task(curr) || !on_dl_rq(dl_se))
 		return;
@@ -1323,21 +1322,15 @@ static void update_curr_dl(struct rq *rq)
 	 * natural solution, but the full ramifications of this
 	 * approach need further study.
 	 */
-	now = rq_clock_task(rq);
-	delta_exec = now - curr->se.exec_start;
-	if (unlikely((s64)delta_exec <= 0)) {
+	delta_exec = update_curr_common(rq);
+	if (unlikely(delta_exec <= 0)) {
 		if (unlikely(dl_se->dl_yielded))
 			goto throttle;
 		return;
 	}
 
-	schedstat_set(curr->stats.exec_max,
-		      max(curr->stats.exec_max, delta_exec));
-
 	trace_sched_stat_runtime(curr, delta_exec, 0);
 
-	update_current_exec_runtime(curr, now, delta_exec);
-
 	if (dl_entity_is_special(dl_se))
 		return;
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 7a1b1f855b96..03e61be5c94f 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -891,23 +891,17 @@ static void update_tg_load_avg(struct cfs_rq *cfs_rq)
 }
 #endif /* CONFIG_SMP */
 
-/*
- * Update the current task's runtime statistics.
- */
-static void update_curr(struct cfs_rq *cfs_rq)
+static s64 update_curr_se(struct rq *rq, struct sched_entity *curr)
 {
-	struct sched_entity *curr = cfs_rq->curr;
-	u64 now = rq_clock_task(rq_of(cfs_rq));
-	u64 delta_exec;
-
-	if (unlikely(!curr))
-		return;
+	u64 now = rq_clock_task(rq);
+	s64 delta_exec;
 
 	delta_exec = now - curr->exec_start;
-	if (unlikely((s64)delta_exec <= 0))
-		return;
+	if (unlikely(delta_exec <= 0))
+		return delta_exec;
 
 	curr->exec_start = now;
+	curr->sum_exec_runtime += delta_exec;
 
 	if (schedstat_enabled()) {
 		struct sched_statistics *stats;
@@ -917,9 +911,43 @@ static void update_curr(struct cfs_rq *cfs_rq)
 				max(delta_exec, stats->exec_max));
 	}
 
-	curr->sum_exec_runtime += delta_exec;
-	schedstat_add(cfs_rq->exec_clock, delta_exec);
+	return delta_exec;
+}
+
+/*
+ * Used by other classes to account runtime.
+ */
+s64 update_curr_common(struct rq *rq)
+{
+	struct task_struct *curr = rq->curr;
+	s64 delta_exec;
 
+	delta_exec = update_curr_se(rq, &curr->se);
+	if (unlikely(delta_exec <= 0))
+		return delta_exec;
+
+	account_group_exec_runtime(curr, delta_exec);
+	cgroup_account_cputime(curr, delta_exec);
+
+	return delta_exec;
+}
+
+/*
+ * Update the current task's runtime statistics.
+ */
+static void update_curr(struct cfs_rq *cfs_rq)
+{
+	struct sched_entity *curr = cfs_rq->curr;
+	s64 delta_exec;
+
+	if (unlikely(!curr))
+		return;
+
+	delta_exec = update_curr_se(rq_of(cfs_rq), curr);
+	if (unlikely(delta_exec <= 0))
+		return;
+
+	schedstat_add(cfs_rq->exec_clock, delta_exec);
 	curr->vruntime += calc_delta_fair(delta_exec, curr);
 	update_min_vruntime(cfs_rq);
 
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 0a11f44adee5..18eb6ce60c5c 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1046,24 +1046,17 @@ static void update_curr_rt(struct rq *rq)
 {
 	struct task_struct *curr = rq->curr;
 	struct sched_rt_entity *rt_se = &curr->rt;
-	u64 delta_exec;
-	u64 now;
+	s64 delta_exec;
 
 	if (curr->sched_class != &rt_sched_class)
 		return;
 
-	now = rq_clock_task(rq);
-	delta_exec = now - curr->se.exec_start;
-	if (unlikely((s64)delta_exec <= 0))
+	delta_exec = update_curr_common(rq);
+	if (unlikely(delta_exec < 0))
 		return;
 
-	schedstat_set(curr->stats.exec_max,
-		      max(curr->stats.exec_max, delta_exec));
-
 	trace_sched_stat_runtime(curr, delta_exec, 0);
 
-	update_current_exec_runtime(curr, now, delta_exec);
-
 	if (!rt_bandwidth_enabled())
 		return;
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 3e8df6d31c1e..d18e3c3a3f40 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2166,6 +2166,8 @@ struct affinity_context {
 	unsigned int flags;
 };
 
+extern s64 update_curr_common(struct rq *rq);
+
 struct sched_class {
 
 #ifdef CONFIG_UCLAMP_TASK
@@ -3238,16 +3240,6 @@ extern int sched_dynamic_mode(const char *str);
 extern void sched_dynamic_update(int mode);
 #endif
 
-static inline void update_current_exec_runtime(struct task_struct *curr,
-						u64 now, u64 delta_exec)
-{
-	curr->se.sum_exec_runtime += delta_exec;
-	account_group_exec_runtime(curr, delta_exec);
-
-	curr->se.exec_start = now;
-	cgroup_account_cputime(curr, delta_exec);
-}
-
 #ifdef CONFIG_SCHED_MM_CID
 static inline int __mm_cid_get(struct mm_struct *mm)
 {
diff --git a/kernel/sched/stop_task.c b/kernel/sched/stop_task.c
index 85590599b4d6..7595494ceb6d 100644
--- a/kernel/sched/stop_task.c
+++ b/kernel/sched/stop_task.c
@@ -70,18 +70,7 @@ static void yield_task_stop(struct rq *rq)
 
 static void put_prev_task_stop(struct rq *rq, struct task_struct *prev)
 {
-	struct task_struct *curr = rq->curr;
-	u64 now, delta_exec;
-
-	now = rq_clock_task(rq);
-	delta_exec = now - curr->se.exec_start;
-	if (unlikely((s64)delta_exec < 0))
-		delta_exec = 0;
-
-	schedstat_set(curr->stats.exec_max,
-		      max(curr->stats.exec_max, delta_exec));
-
-	update_current_exec_runtime(curr, now, delta_exec);
+	update_curr_common(rq);
 }
 
 /*
-- 
2.40.0.rc1.284.g88254d51c5-goog

