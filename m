Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEAAA5F3800
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 23:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbiJCVpS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 17:45:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbiJCVpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 17:45:08 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FBC213D06
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 14:45:07 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id j3-20020a170902da8300b001782a6fbc87so8888332plx.5
        for <linux-kernel@vger.kernel.org>; Mon, 03 Oct 2022 14:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=TM6SuMdKuVsnc15Opjp9I6Izjk9B3SQFKaFUjfkVYPs=;
        b=I/e0acLCaRdSojUsJgDudR9zTw4Vv4aUA4b5qLl7VZ6782tfZw3g8gOAXjQhkwyeAE
         26Rs6NFvDjA51cBWsQ22ZY1cKWYIUkyP6eC1+CRbvZwitJ2iRxwZlr3gPfYLmfDg8VQ+
         XIZyoI0Jq46QHEC6kzfSW4finvtKOcwutdttzZ/EizXpF7t8TGYazAh3gWxJWeHvUVR6
         hz1gW8Fu+7kUe/gfTpVxk9AerPsxx7eQJDbEkagdPy8qWn5/gygSIgrIe0eSIDa2VSGJ
         1cMtlP0PD9n5b1uxoHglZKLBFPW8/GpCp804XGDNKbCqGKQlWVM/S9eTZ8TvDow5AjdX
         hOeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=TM6SuMdKuVsnc15Opjp9I6Izjk9B3SQFKaFUjfkVYPs=;
        b=BFswBwHlS/xhi9W1S03/ZOce2nb5FsrlSLNC5PiR5WGW/J8OauIqURz1Y1eiZY7RB7
         OeocYZwLgdAu0dQ/Gyt1g+oWmSPDHpsvxMkxK1lQXeB+snf7gKU61mS3SlET3+45PTwn
         SmxGDebgKV3b5zCWM9IbCkLWBvt7k5fhYmy5IVsmItvakvZud3p3vkxp2+UXE18XTbV+
         rJOyuOGj4EmkdQBIRQIANFcR6qVF+Jj4vYxTQCuEBFW5+F52bw+8Z/6lJpQe+ikpBeaf
         16Eyap/hh5O3xahHMPw9Kwh4Xrxj3pFmPojEzqut3XxLKy9okfWA/IRAryQptxAZGhQL
         +lpA==
X-Gm-Message-State: ACrzQf2UVJxm0qSCj/OKRPWJI3btcu06QyMnOnRhf+nfqAJ6oTRp7VsK
        ezSFA8k+DHI21zvez3ctSB2Dkgkhq0lW+suFpPsJQAZ6bWgipB/UzWtfOsRkbGX7Ra9CA81Wt53
        cIzq9jgR6LTQcwC5emK54mHhWMlFX1W6yXDiQYuVHcXgfsbsnVzRABJHEuZyyebZ+VaC/PeWe
X-Google-Smtp-Source: AMsMyM7iYj2bPPXU5/ah7EUpjS7Q4AFEppG9kmporR8vADi/X1YeBjD5/1ACdNxOvLAFGgNXYJrftt1EEEwM
X-Received: from connoro.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:a99])
 (user=connoro job=sendgmr) by 2002:a05:6a00:238c:b0:544:c42d:8a67 with SMTP
 id f12-20020a056a00238c00b00544c42d8a67mr24355446pfc.21.1664833506800; Mon,
 03 Oct 2022 14:45:06 -0700 (PDT)
Date:   Mon,  3 Oct 2022 21:44:52 +0000
In-Reply-To: <20221003214501.2050087-1-connoro@google.com>
Mime-Version: 1.0
References: <20221003214501.2050087-1-connoro@google.com>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Message-ID: <20221003214501.2050087-3-connoro@google.com>
Subject: [RFC PATCH 02/11] locking/mutex: Rework task_struct::blocked_on
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

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
[minor changes while rebasing]
Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Connor O'Brien <connoro@google.com>
Link: https://lkml.kernel.org/r/20181009092434.26221-4-juri.lelli@redhat.com
---
 include/linux/sched.h        | 6 ++----
 kernel/fork.c                | 4 ++--
 kernel/locking/mutex-debug.c | 9 +++++----
 kernel/locking/mutex.c       | 6 ++++++
 4 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index e7b2f8a5c711..bd995e66d7d6 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1130,10 +1130,8 @@ struct task_struct {
 	struct rt_mutex_waiter		*pi_blocked_on;
 #endif
 
-#ifdef CONFIG_DEBUG_MUTEXES
-	/* Mutex deadlock detection: */
-	struct mutex_waiter		*blocked_on;
-#endif
+	struct task_struct		*blocked_proxy;	/* task that is boosting us */
+	struct mutex			*blocked_on;	/* lock we're blocked on */
 
 #ifdef CONFIG_DEBUG_ATOMIC_SLEEP
 	int				non_block_count;
diff --git a/kernel/fork.c b/kernel/fork.c
index 2b6bd511c6ed..81e809c343fd 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2208,9 +2208,9 @@ static __latent_entropy struct task_struct *copy_process(
 	lockdep_init_task(p);
 #endif
 
-#ifdef CONFIG_DEBUG_MUTEXES
+	p->blocked_proxy = NULL; /* nobody is boosting us yet */
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
index 1582756914df..f05cd2d216c7 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -645,6 +645,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 			goto err_early_kill;
 	}
 
+	current->blocked_on = lock;
 	set_current_state(state);
 	trace_contention_begin(lock, LCB_F_MUTEX);
 	for (;;) {
@@ -682,6 +683,10 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 
 		first = __mutex_waiter_is_first(lock, &waiter);
 
+		/*
+		 * Gets reset by ttwu_runnable().
+		 */
+		current->blocked_on = lock;
 		set_current_state(state);
 		/*
 		 * Here we order against unlock; we must either see it change
@@ -715,6 +720,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 	}
 
 	__mutex_remove_waiter(lock, &waiter);
+	current->blocked_on = NULL;
 
 	debug_mutex_free_waiter(&waiter);
 
-- 
2.38.0.rc1.362.ged0d419d3c-goog

