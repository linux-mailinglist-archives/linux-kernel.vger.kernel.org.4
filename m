Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 629246DD0E4
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 06:25:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbjDKEZx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 00:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbjDKEZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 00:25:29 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5021B2D5A
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 21:25:28 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id v67-20020a254846000000b00b8189f73e94so30494744yba.12
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 21:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1681187127; x=1683779127;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MXbqcM8S0eoqY1JXMQQLXkL4JKytwPxCmdsZ17HQXnE=;
        b=WK9/avoTybboSLoz1SBxCBBJnRPD/Fd/1to1j2hAhGaAsh+wRplwRqS4kx4v9MqJrY
         7iSOkK8HXV8a8dc2GnPxpH6SqClEmMxKazCmc4zJbRyGQUb5MruIYt/wzpFfRAf6xrQS
         il7AC0DqyPgA+fYVr6P/St1k777N/15sA1RGQiR910rWVDV3tinIpXdyBQ8fYpEzqlx/
         OUuD6e6aAcO6M/UorjnNeVZ75OZ1mFZjEbToiqb7tiycf3j5UUs1KlJKcUUiydTbkAuB
         wksAC9/P2sOfBQuqe3JDJylNcebdeV1VkkRKeMMkMxBX88yJseIYg9zjD3s5ks0wEzTl
         veFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681187127; x=1683779127;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MXbqcM8S0eoqY1JXMQQLXkL4JKytwPxCmdsZ17HQXnE=;
        b=WqHWyIMhBvQ4Fw/kglN/7C72gzlEmJ586YGTO8uDwN6yoPA/1t+m22ZRIieJ41j6Rt
         +eWdZMxxscdueS1BbhAyyMqi/w3BDLKMeGZ5IufY1wdH0w6DsioQ0klHHhfsaM1s+Ejp
         ZJAAjsRbf1YHvyAL0/Pe+dfSqjzUhOIDDQK0doyzf6gQVr+k+ih1F5+WxCPXmdCppkYl
         y9hGZYXkPNejD/S8rUmrsXGtV7e5SL+BypTVJroe0MdSwEpxAeM2U2XPZGI6rCo++vUf
         P/xV/tZ+7Kenx1x1Mw+LQDSq3UB2aucbMtX2JStmstRkbDpxuw1b1jDIhIgeREOPDwme
         zfpA==
X-Gm-Message-State: AAQBX9fj1369Y0X9yjUtJT159s9Vwn+aYqTyYIebjDWb52LzJlnDgljS
        UYfLduMj47uGnCv0W2qaqUC/3/m+5UL+JH3OO0qbK0u5OHjWepuKr+QK3Leif+T1NjqKVhVa0xK
        +BcF+GSr/tYZezaGcWdSPxqUH7XZ0Jg08Jozq7Qtvrmy3nchcHlrT3aqoB4hhTY+dTVYuSV0=
X-Google-Smtp-Source: AKy350YTwDNMNFMEMSlEf2un49G3Hi/s1Jg7Eo4F9wi9+MfJgOiKQO66YR3cMhFTxI1jfBmdVFHcBKboPBZ3
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a81:4320:0:b0:541:6941:5aa8 with SMTP id
 q32-20020a814320000000b0054169415aa8mr5051718ywa.7.1681187127553; Mon, 10 Apr
 2023 21:25:27 -0700 (PDT)
Date:   Tue, 11 Apr 2023 04:25:02 +0000
In-Reply-To: <20230411042511.1606592-1-jstultz@google.com>
Mime-Version: 1.0
References: <20230411042511.1606592-1-jstultz@google.com>
X-Mailer: git-send-email 2.40.0.577.gac1e443424-goog
Message-ID: <20230411042511.1606592-6-jstultz@google.com>
Subject: [PATCH v3 05/14] locking/mutex: Add p->blocked_on wrappers
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
index 2d736b6c44e9..9d46ca8ac221 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2222,6 +2222,20 @@ static inline int rwlock_needbreak(rwlock_t *lock)
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
index 9cb2686fb974..45f1b7519f63 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -647,7 +647,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 			goto err_early_kill;
 	}
 
-	current->blocked_on = lock;
+	set_task_blocked_on(current, lock);
 	set_current_state(state);
 	trace_contention_begin(lock, LCB_F_MUTEX);
 	for (;;) {
@@ -691,7 +691,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 		/*
 		 * Gets reset by ttwu_runnable().
 		 */
-		current->blocked_on = lock;
+		set_task_blocked_on(current, lock);
 		set_current_state(state);
 		/*
 		 * Here we order against unlock; we must either see it change
@@ -742,7 +742,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 	debug_mutex_free_waiter(&waiter);
 
 skip_wait:
-	current->blocked_on = NULL;
+	set_task_blocked_on(current, NULL);
 	/* got the lock - cleanup and rejoice! */
 	lock_acquired(&lock->dep_map, ip);
 	trace_contention_end(lock, 0);
@@ -758,7 +758,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 	return 0;
 
 err:
-	current->blocked_on = NULL;
+	set_task_blocked_on(current, NULL);
 	__set_current_state(TASK_RUNNING);
 	__mutex_remove_waiter(lock, &waiter);
 err_early_kill:
-- 
2.40.0.577.gac1e443424-goog

