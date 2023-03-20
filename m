Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5839C6C25BB
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 00:38:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbjCTXiR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 19:38:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbjCTXiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 19:38:06 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E9F236FCE
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 16:37:48 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id 16-20020a056a00071000b00627e9b4871eso3226638pfl.11
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 16:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679355467;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=M9InGmtBwylP8bL6euAgOOc7oo3A0OeHZtEdYhhnysM=;
        b=tBdJJ3bXzEAqBg5M0RohgU8XkpUgmAhZxi1F0ozqNaJD6/TmyjVYC+9AfydDlWAM5p
         e+gPMOfd3Qxx7L7CE+2mTiQoZNNfTDDwrJAsqSOZjZ8a701+03qydsrxkSV4g5ToI9bI
         pdv/wYQAg0XHJUvrG+UfODoKHkUrEEJmqlyoE7//VxvFl03fyRJeA+2+oARodE0+F2v+
         hJTNcXMtgC//nZ6xBQpwKFQEJqeKTCR9C8SYsKqYHYLeUIYmi19Nv2wGbysNKET8gu4q
         Qg/UWnCrbgzrIzSRaZanCxvhJVagIUPxzn0BHKstG9QF3jd7izTWrWR84W7DT54Y4vJt
         Dzkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679355467;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M9InGmtBwylP8bL6euAgOOc7oo3A0OeHZtEdYhhnysM=;
        b=V/n0li+T7obXhBw1nr1+UHcBt7yWooP7RgJSaIVk9lweBGfKOTNfkLHdT7NLAPF9qM
         AxhydsVG090Am6UML8f9H5mJJu17xLfeVkCJUCWDQwbmtwZ+rxadf6UaKr+mlQFyL1yB
         ugTnLu4pCU1ysH1OnZ+0HgKa6ByY5F14kuMFTD9u/mTlkgpAbzCYjFLaFlYWF7PDG48P
         ZpwSXxLswozbZh2NjWsLqN5raxMl99qWou/MPD6X4RtAGn3CXQ/g6cVU4PMbUKJM96Uj
         JpQjUuy9z9BvZsY1BPIAUZQjKQdbfnKb08KE/m30zlDAdYXOmX0XiMMBvMJ9tEmLBtbt
         HMGg==
X-Gm-Message-State: AO0yUKUHMbesA3rsMAyCeAYnz+FSDPcjuCLKhXmAgHc59PW4UqzSKzvV
        TGuZiv/75EouvH8ndwgJpepr+Csi1J6RpAKEayyQ1opcS+5mI5bqx6VzDoYcYwhIds6OtdDLrUW
        SU9TPeN6fD5cepUUF/Tja5ZL0wWqACs7KpNZDRFCSgg52gz0HN/ElkSU8tS2w1hiG1PGg0JU=
X-Google-Smtp-Source: AK7set+Cc/FrzX8GRbXMdfC3dJumnpy4zLOwOjiylJF4B5gDV2j0npme6j/GjnY3LbGkGwR1HnNRh0k4xmeL
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a17:903:183:b0:19a:ec61:98d4 with SMTP id
 z3-20020a170903018300b0019aec6198d4mr87109plg.0.1679355466445; Mon, 20 Mar
 2023 16:37:46 -0700 (PDT)
Date:   Mon, 20 Mar 2023 23:37:17 +0000
In-Reply-To: <20230320233720.3488453-1-jstultz@google.com>
Mime-Version: 1.0
References: <20230320233720.3488453-1-jstultz@google.com>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
Message-ID: <20230320233720.3488453-10-jstultz@google.com>
Subject: [PATCH v2 09/12] sched: Unnest ttwu_runnable in prep for proxy-execution
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
        "Paul E . McKenney" <paulmck@kernel.org>, kernel-team@android.com
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

Slightly rework ttwu_runnable to minimize the nesting to help
make the proxy-execution changes easier to read.

Should be no logical change here.

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
Signed-off-by: John Stultz <jstultz@google.com>
---
 kernel/sched/core.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index ab6b1917bc70..82f5b29ae675 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3773,18 +3773,20 @@ static int ttwu_runnable(struct task_struct *p, int wake_flags)
 	int ret = 0;
 
 	rq = __task_rq_lock(p, &rf);
-	if (task_on_rq_queued(p)) {
-		if (!task_on_cpu(rq, p)) {
-			/*
-			 * When on_rq && !on_cpu the task is preempted, see if
-			 * it should preempt the task that is current now.
-			 */
-			update_rq_clock(rq);
-			check_preempt_curr(rq, p, wake_flags);
-		}
-		ttwu_do_wakeup(p);
-		ret = 1;
+	if (!task_on_rq_queued(p))
+		goto out_unlock;
+
+	if (!task_on_cpu(rq, p)) {
+		/*
+		 * When on_rq && !on_cpu the task is preempted, see if
+		 * it should preempt the task that is current now.
+		 */
+		update_rq_clock(rq);
+		check_preempt_curr(rq, p, wake_flags);
 	}
+	ttwu_do_wakeup(p);
+	ret = 1;
+out_unlock:
 	__task_rq_unlock(rq, &rf);
 
 	return ret;
-- 
2.40.0.rc1.284.g88254d51c5-goog

