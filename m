Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E70987192E1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 08:00:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231807AbjFAGAb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 02:00:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231791AbjFAF7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 01:59:46 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F036E4E
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 22:59:16 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-568a8704f6dso6802827b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 22:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685599155; x=1688191155;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=sjSiEVFvwgKwRefW1DaGSRLOPMcqZfNZ3si0heaKz+s=;
        b=b1+z3n6FNugQyOLOwnC3N2SWHkOrz7xV94xG8m9n8T+0UtNRNf7tXQzr1gSb+gwSsE
         oKuKYcSx1oWajoDSZJZYCZ1EYISY9gpjvfSeIsDpBqO73H+ysVsENVAN+wDDw75sgj11
         zdnsq3MoAdutrtns1l7bJzmL6oFwp+FLqJ1DYtK5cBt7iQEoYzg8oBHu0fr99Vc5tMgh
         amfxXyWpjoC3CX5ZtaUQ3ScErPeOQDErr9+Funxhn69wsf6+/LOeU8oCRkIdqYo39cJT
         SXqZ6Db9Ls1W59tP78/BE4pOtP39ZF+OyFG1LJPMX/k7FbxbN52LaJ14p0CppD1kyKD6
         xdyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685599155; x=1688191155;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sjSiEVFvwgKwRefW1DaGSRLOPMcqZfNZ3si0heaKz+s=;
        b=VWCTB998tITwkqMLxFIz7rdhiaohAYGGMPiCPv2VR+MS4fx1bycD2nOCuME7EujqcY
         ZDgtRN1ltD5Jtu3oUZnvaawTp27f/LQ4TU54S5Wf5ktr1ZODWXCFEY2BgiY/toNwXjfm
         jEow4dLhPe5Uhkl9vXXPLvGwwAtOcMuFLltKjKOXA5Wct0FmerZn7xqXGXSHMOy3v2FU
         9RgoYYbh0ezfon7YVZYI+dvPTk3cei3a9bWasqtE4jmCeghK+XcN8XpSALmO22b7sbqu
         /lnmebJ4tza2nDlV8F26bocTSlVh3nSZ8DzXQeskbUEr9ebsqdfqb3OSj3wrv5600QEG
         EA6w==
X-Gm-Message-State: AC+VfDxN+TYbHMOGmWFS4N6xhhkJJ8p77wP7a+PecB1KWgqyxhZd9gRC
        yyBsxycZW1IMdF+eyuW2TaA0DTN/ox7m5uOmuHLWnYcuxHk2Sc74zhI6YS66kcTgc9B2qRyOQBn
        ASjQMRpC+GFjBHcg25r0tN6J0APNG00x1M6AlDRkTPdi6eTHT6CtkfX8j5khq2N+y6fvX7q8=
X-Google-Smtp-Source: ACHHUZ4ae+ByRjg7oFCP5l58qYx1ruaRX97pztd56Cuj+KYgcUUo5vzWbgY5iH3Ls6sfPyyTTIb9IkgcGi5R
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a81:af4d:0:b0:565:9e73:f92f with SMTP id
 x13-20020a81af4d000000b005659e73f92fmr4558928ywj.10.1685599155660; Wed, 31
 May 2023 22:59:15 -0700 (PDT)
Date:   Thu,  1 Jun 2023 05:58:14 +0000
In-Reply-To: <20230601055846.2349566-1-jstultz@google.com>
Mime-Version: 1.0
References: <20230601055846.2349566-1-jstultz@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Message-ID: <20230601055846.2349566-12-jstultz@google.com>
Subject: [PATCH v4 11/13] sched: Fix runtime accounting w/ proxy-execution
From:   John Stultz <jstultz@google.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     John Stultz <jstultz@google.com>,
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
        "Paul E . McKenney" <paulmck@kernel.org>, kernel-team@android.com
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

The idea here is we want to charge the selected task's vruntime
but charge the executed task's sum_exec_runtime.

This way cputime accounting goes against the task actually running
but vruntime accounting goes against the selected task so we get
proper fairness.

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
Signed-off-by: John Stultz <jstultz@google.com>
---
 kernel/sched/fair.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 43efc576d2c6..c2e17bfa6b31 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -891,22 +891,36 @@ static void update_tg_load_avg(struct cfs_rq *cfs_rq)
 }
 #endif /* CONFIG_SMP */
 
-static s64 update_curr_se(struct rq *rq, struct sched_entity *curr)
+static s64 update_curr_se(struct rq *rq, struct sched_entity *se)
 {
 	u64 now = rq_clock_task(rq);
 	s64 delta_exec;
 
-	delta_exec = now - curr->exec_start;
+	/* Calculate the delta from selected se */
+	delta_exec = now - se->exec_start;
 	if (unlikely(delta_exec <= 0))
 		return delta_exec;
 
-	curr->exec_start = now;
-	curr->sum_exec_runtime += delta_exec;
+	/* Update selected se's exec_start */
+	se->exec_start = now;
+	if (entity_is_task(se)) {
+		struct task_struct *running = rq->curr;
+		/*
+		 * If se is a task, we account the time
+		 * against the running task, as w/ proxy-exec
+		 * they may not be the same.
+		 */
+		running->se.exec_start = now;
+		running->se.sum_exec_runtime += delta_exec;
+	} else {
+		/* If not task, account the time against se */
+		se->sum_exec_runtime += delta_exec;
+	}
 
 	if (schedstat_enabled()) {
 		struct sched_statistics *stats;
 
-		stats = __schedstats_from_se(curr);
+		stats = __schedstats_from_se(se);
 		__schedstat_set(stats->exec_max,
 				max(delta_exec, stats->exec_max));
 	}
-- 
2.41.0.rc0.172.g3f132b7071-goog

