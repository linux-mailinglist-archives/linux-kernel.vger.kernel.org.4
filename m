Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 752C76DD0EF
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 06:27:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbjDKE11 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 00:27:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230236AbjDKE0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 00:26:33 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACC0D3C1B
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 21:25:44 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id j6-20020a255506000000b00b8ef3da4acfso4758376ybb.8
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 21:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1681187143; x=1683779143;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y/6hOBiHy1bEYHAGxzPHFuQ7hDS+zseLZd12U/15Vp8=;
        b=sIeuE5t6SEZoJebDKFeRtbS1L48rsUbt4c93iOrv+64E2MnOG6aL86RHI0gvrdjsvX
         7bbrgVhLmrxsoY8BOd14oS+PRAc2XaZJEPUhsWgf7kp9SmnZZrA/WkicVF+fVQep7Il8
         7PtAMfwzWqKOFsPGF2CJNxuBjDtPWKsrEfGG6LpvvJDGi3SAyPE4cfkOqxszMc3WViwO
         WMDn/l5rvfBD4zSlKhj3gpUjs2a+A/LdS1jeiT3vH5x15yihf6l+mnFy72BKii4Caz/Q
         2JIYvw8Y6Akb1msQvhH4ZKhVgHigK1HYbluiQPXJjem6Yz0YC1C48XRG/GHUedp//VZD
         2PQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681187143; x=1683779143;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y/6hOBiHy1bEYHAGxzPHFuQ7hDS+zseLZd12U/15Vp8=;
        b=3ktlchWrmbx2WaMX9PJiskxLI5uamTiWyzYF3neIbxc//Ntl2a2uDQ+FcrVGx7ZEGh
         QDs/L1dPN1r3mUaeRYMgQQ+61dY3NYMbpHU2ZwOWXts5nhyWZ9JhEZMU+hR1RLVTM+LZ
         QZMr2dMsEgZ+im/pjohteaU6lIEYq4gHvLoEcVQUT09+Pe/OYeILAKszMXHyNsR9c6O1
         +PcVOu3mQ1DFRZzYZI/UQ7AmUkx6ASCTYF5Zv0MqqjHNXDa/d1aI+Fb1oH8ig9RtYCin
         v1LbI+tJGYTEr5PPPEGlNYpOjzyqcO6e0hvuZ1L8tpi+f330jchP2Htb3GoIUqDtgllC
         JNJw==
X-Gm-Message-State: AAQBX9f+klgrZsA9RmCrDRGZKKorZrzujGUDv6rEtyRIbf7xz3qQvc/x
        h63NG9bEE0zGu8txjoJqIKUblGjYBclkp23LFdzp85Ic97dlCHW3GCS7Hnh4iR/IWX0KPiINR2b
        ehO7Pqx4piXcyUrfKPDa6gwtUTQNJMvWBiQZXy55CahouPwByF0JlBjSUBW8JH2PxR9rATSY=
X-Google-Smtp-Source: AKy350bfZe4kQbo8ZRC4t+yONkcQMM5VjvcU6phoN41kKcxO55+gEjF1aJlT8lu/fUzYvXyy6jV8a/4RQO/v
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a25:6c07:0:b0:b8b:eea7:525a with SMTP id
 h7-20020a256c07000000b00b8beea7525amr6139638ybc.7.1681187143235; Mon, 10 Apr
 2023 21:25:43 -0700 (PDT)
Date:   Tue, 11 Apr 2023 04:25:11 +0000
In-Reply-To: <20230411042511.1606592-1-jstultz@google.com>
Mime-Version: 1.0
References: <20230411042511.1606592-1-jstultz@google.com>
X-Mailer: git-send-email 2.40.0.577.gac1e443424-goog
Message-ID: <20230411042511.1606592-15-jstultz@google.com>
Subject: [PATCH v3 14/14] sched: Fix runtime accounting w/ proxy-execution
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
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
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
Cc: Mel Gorman <mgorman@suse.de>
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Will Deacon <will@kernel.org>
Cc: Waiman Long <longman@redhat.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: "Paul E . McKenney" <paulmck@kernel.org>
Signed-off-by: John Stultz <jstultz@google.com>
---
 kernel/sched/fair.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index acb8155f40c3..3abb48b3515c 100644
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
+		struct task_struct *running = rq_curr(rq);
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
2.40.0.577.gac1e443424-goog

