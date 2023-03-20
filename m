Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F174D6C25B5
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 00:37:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbjCTXhy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 19:37:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbjCTXhn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 19:37:43 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D289A32E66
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 16:37:38 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id q8-20020a17090ad38800b0023f116f305bso6562831pju.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 16:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679355458;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QPe4aD84vTizqGVjBuhouTmqyuMdRzMicw0Vakqg7dw=;
        b=ssFRdKNIWLs8SJbLw9mTZNeXDLO7hBAb57Qh4XOW0Q6dnA9GoNWGVlBftazejph1K5
         TOB2IA4Nqzdj3Rxv+4aczv0bwgePmdETrXn9hEvNF7aIhiBNQfe58gJBqtNGpow0YAuu
         EwMh4pE53lyboirSUGNDJh0/h5Ai4XQ42HwIKugFcdvtec71wSHOrDpqUmSM27gAV6yB
         hwBCSa3rom54vUm+0sIu3j7m0VVfmtPVCBM2+7CXdlGgkqWUz68LLit20W/aIFu6VUCF
         0z/9DnASZUqaqxVVLAcSzPaslTC9BPY/3lCSjwYGA9pVQyNJ8dUyy4CAteT8EAqUItzG
         zcuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679355458;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QPe4aD84vTizqGVjBuhouTmqyuMdRzMicw0Vakqg7dw=;
        b=UwJL995TXO19UTxRA+bv4uhp7WWmoY2T17NZh+69vwVhnBHw5Iy3AGAmXjOT2g9x96
         Cjm+YktOivls227oficqp9NOc3GXuHYp9tPSXaVel3QUGajkeFsEI0GA6rzqYKJi4GgK
         q5Tg15+DxbpIs/i1Vox3KWAAhRPTnk0P8pUuoMSH7RRxyhCTtna7SOb3LcfQjl2YkrO7
         h4EkYDRdDQkoL5m7RT0D+T0rjQ+EvnIhz1fDEO0i1AVSPz7GpECku55InwHyZZlJcNh9
         40QerZGjVZmzOt07XtPHtmCrB0Wngmx7aKa6q9I+bAFBSejMMu+4uRULtF6nLS2TozJp
         +O4A==
X-Gm-Message-State: AO0yUKU7QJ3vBTo00tAhMFRNNx7+VUVCjQqlQHbH0rjgvXDCwfrvO2BB
        HzUMZ707mLAod/pJxEqPrska+1m/Vo0OQXRS8+LwubA5vof/hbBwa3RtGCdWTmLOxooVA9D1Ze5
        eCyPrgOeKgZOFzbfIMssA66c7XNkXv3sZmEyCh3qPyDFXLNhAMHzMjO/5GyFRrkkx6MuzIR4=
X-Google-Smtp-Source: AK7set8yDbrHrWuCBh8ZQFI48eR0gTIDwrkRiJN8npB4Rfoiu1XUilV1Pg5KhPvFXSIucnAIDMG6qyeLW6jF
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a05:6a00:14ca:b0:626:1710:9b7d with SMTP
 id w10-20020a056a0014ca00b0062617109b7dmr6078478pfu.0.1679355457901; Mon, 20
 Mar 2023 16:37:37 -0700 (PDT)
Date:   Mon, 20 Mar 2023 23:37:12 +0000
In-Reply-To: <20230320233720.3488453-1-jstultz@google.com>
Mime-Version: 1.0
References: <20230320233720.3488453-1-jstultz@google.com>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
Message-ID: <20230320233720.3488453-5-jstultz@google.com>
Subject: [PATCH v2 04/12] locking/mutex: Add p->blocked_on wrappers
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

This lets us assert p->blocked_lock is held whenever we access
p->blocked_on.

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
[fix conflicts, call in more places]
Signed-off-by: Connor O'Brien <connoro@google.com>
[jstultz: tweaked commit subject, added get_task_blocked_on() as well]
Signed-off-by: John Stultz <jstultz@google.com>
---
v2:
* Added get_task_blocked_on() accessor
---
 include/linux/sched.h        | 14 ++++++++++++++
 kernel/locking/mutex-debug.c |  4 ++--
 kernel/locking/mutex.c       |  8 ++++----
 3 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 031615b5dc2a..a1606d0bd3fe 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2223,6 +2223,20 @@ static inline int rwlock_needbreak(rwlock_t *lock)
 #endif
 }
 
+static inline void set_task_blocked_on(struct task_struct *p, struct mutex *m)
+{
+	lockdep_assert_held(&p->blocked_lock);
+
+	p->blocked_on = m;
+}
+
+static inline struct mutex *get_task_blocked_on(struct task_struct *p)
+{
+	lockdep_assert_held(&p->blocked_lock);
+
+	return p->blocked_on;
+}
+
 static __always_inline bool need_resched(void)
 {
 	return unlikely(tif_need_resched());
diff --git a/kernel/locking/mutex-debug.c b/kernel/locking/mutex-debug.c
index 7228909c3e62..e3cd64ae6ea4 100644
--- a/kernel/locking/mutex-debug.c
+++ b/kernel/locking/mutex-debug.c
@@ -53,13 +53,13 @@ void debug_mutex_add_waiter(struct mutex *lock, struct mutex_waiter *waiter,
 	lockdep_assert_held(&lock->wait_lock);
 
 	/* Current thread can't be already blocked (since it's executing!) */
-	DEBUG_LOCKS_WARN_ON(task->blocked_on);
+	DEBUG_LOCKS_WARN_ON(get_task_blocked_on(task));
 }
 
 void debug_mutex_remove_waiter(struct mutex *lock, struct mutex_waiter *waiter,
 			 struct task_struct *task)
 {
-	struct mutex *blocked_on = READ_ONCE(task->blocked_on);
+	struct mutex *blocked_on = get_task_blocked_on(task); /*XXX jstultz: dropped READ_ONCE here, revisit.*/
 
 	DEBUG_LOCKS_WARN_ON(list_empty(&waiter->list));
 	DEBUG_LOCKS_WARN_ON(waiter->task != task);
diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index 2f31ebb08b4a..d322f7c1c8fa 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -646,7 +646,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 			goto err_early_kill;
 	}
 
-	current->blocked_on = lock;
+	set_task_blocked_on(current, lock);
 	set_current_state(state);
 	trace_contention_begin(lock, LCB_F_MUTEX);
 	for (;;) {
@@ -690,7 +690,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 		/*
 		 * Gets reset by ttwu_runnable().
 		 */
-		current->blocked_on = lock;
+		set_task_blocked_on(current, lock);
 		set_current_state(state);
 		/*
 		 * Here we order against unlock; we must either see it change
@@ -741,7 +741,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 	debug_mutex_free_waiter(&waiter);
 
 skip_wait:
-	current->blocked_on = NULL;
+	set_task_blocked_on(current, NULL);
 	/* got the lock - cleanup and rejoice! */
 	lock_acquired(&lock->dep_map, ip);
 	trace_contention_end(lock, 0);
@@ -757,7 +757,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 	return 0;
 
 err:
-	current->blocked_on = NULL;
+	set_task_blocked_on(current, NULL);
 	__set_current_state(TASK_RUNNING);
 	__mutex_remove_waiter(lock, &waiter);
 err_early_kill:
-- 
2.40.0.rc1.284.g88254d51c5-goog

