Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BFE76DD0E1
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 06:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbjDKEZd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 00:25:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbjDKEZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 00:25:24 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE38610E
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 21:25:23 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id d2e1a72fcca58-632cf80572bso616520b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 21:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1681187123; x=1683779123;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=D11BkT/by/KTrics5kACR4e3C7wu73LGrBohPqnvbDM=;
        b=a/8h6h0U18RoU6lWNBts1y/Xzg9Z20KAdpvIJ/qhPltdInUHLLAQJQy6ixAXv1mjb1
         6RhdONDB2S/hncpRejyEtOMjxGgN9UbZ4Gcj3Rpjs2J7+/qOVGU/vqWKnSz2lIgvnrU7
         DQgcer+PFG7VOc6LR5J0jqwzYfqpyrdwGjpYuHF3terfFA/nfSWVvKaSOAFYYimDGr5X
         TUufRKic2F+HDcm80RvhbNxP6pHVdFJGRtEDjaEgYMw93ET9mCEOHNTnrnX9qCVZE430
         kD0Sp7XElrnLAsgHIaBE/mJQ2BCnRLN0FwFAbc3cZPeDRYjtTzRamp7EcC0xQCex3SgY
         U6PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681187123; x=1683779123;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D11BkT/by/KTrics5kACR4e3C7wu73LGrBohPqnvbDM=;
        b=l704giov0w+SuLsxBI12ogpY9ZZeuH7yMHZpt7JtK+/BeMDv0Va2kucE1XLLA8HGMf
         xT4PNd2yYLzp8zaALRiDtTOY5vjRNbdsmMRqnbd89MSjeJ8N4SyZW/s+8TxgrW5J9DX/
         omVqqgnds/ZGXL9PoNItvcMuCDUFzrp11ktt9HGB/hq/+FJ9JQuaGlAKQXFrzpt8y2ca
         Yoo2zdiXBL5Yu/41wgNK+0uUuNlCI3kId+srwzW2BOTrqZq08Goutm38JfOrQHyRiZHl
         u+gdLmRrZlOaSIQ20NCBmDMjGl+GU3VR1BzGWZG00TIfy7i7mp2GL0jlKQ5aQbbYUn4g
         Wypg==
X-Gm-Message-State: AAQBX9fQ7nv23S62Grr1Z4eJPhAu8yI6mx8Fdmyvcy6gfCV/vsBHjU4L
        meusCa25/+GaAYM0GNotyxxsvg+EyqcLzvZNLf42PHILZzbEnyd6+6U2v7Tlkj/Q/u2bc0AyeCY
        260p/3KhrVic4DQ1Jj2nw9mhO+KPImeJeTAlFvWU0yItpeK+NHXgV7mKKXZuqFiJM7ZI6uD8=
X-Google-Smtp-Source: AKy350bLfk3lZjV3uXu/HKmTd6O9B4gIlEG5TOe1lGSMQDkfVUgDSf42OlNaT7CZ3Jf3m2A9fvf0ixchCeFe
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a05:6a00:2387:b0:632:1d87:688b with SMTP
 id f7-20020a056a00238700b006321d87688bmr4479902pfc.0.1681187122894; Mon, 10
 Apr 2023 21:25:22 -0700 (PDT)
Date:   Tue, 11 Apr 2023 04:24:59 +0000
In-Reply-To: <20230411042511.1606592-1-jstultz@google.com>
Mime-Version: 1.0
References: <20230411042511.1606592-1-jstultz@google.com>
X-Mailer: git-send-email 2.40.0.577.gac1e443424-goog
Message-ID: <20230411042511.1606592-3-jstultz@google.com>
Subject: [PATCH v3 02/14] locking/mutex: make mutex::wait_lock irq safe
From:   John Stultz <jstultz@google.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Juri Lelli <juri.lelli@redhat.com>,
        Joel Fernandes <joelaf@google.com>,
        Qais Yousef <qyousef@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
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

From: Juri Lelli <juri.lelli@redhat.com>

mutex::wait_lock might be nested under rq->lock.

Make it irq safe then.

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
Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
[rebase & fix {un,}lock_wait_lock helpers in ww_mutex.h]
Signed-off-by: Connor O'Brien <connoro@google.com>
Signed-off-by: John Stultz <jstultz@google.com>
---
v3:
* Re-added this patch after it was dropped in v2 which
  caused lockdep warnings to trip.
---
 kernel/locking/mutex.c    | 18 ++++++++++--------
 kernel/locking/ww_mutex.h | 22 ++++++++++++----------
 2 files changed, 22 insertions(+), 18 deletions(-)

diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index 1582756914df..a528e7f42caa 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -572,6 +572,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 {
 	struct mutex_waiter waiter;
 	struct ww_mutex *ww;
+	unsigned long flags;
 	int ret;
 
 	if (!use_ww_ctx)
@@ -614,7 +615,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 		return 0;
 	}
 
-	raw_spin_lock(&lock->wait_lock);
+	raw_spin_lock_irqsave(&lock->wait_lock, flags);
 	/*
 	 * After waiting to acquire the wait_lock, try again.
 	 */
@@ -675,7 +676,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 				goto err;
 		}
 
-		raw_spin_unlock(&lock->wait_lock);
+		raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
 		if (ww_ctx)
 			ww_ctx_wake(ww_ctx);
 		schedule_preempt_disabled();
@@ -698,9 +699,9 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 			trace_contention_begin(lock, LCB_F_MUTEX);
 		}
 
-		raw_spin_lock(&lock->wait_lock);
+		raw_spin_lock_irqsave(&lock->wait_lock, flags);
 	}
-	raw_spin_lock(&lock->wait_lock);
+	raw_spin_lock_irqsave(&lock->wait_lock, flags);
 acquired:
 	__set_current_state(TASK_RUNNING);
 
@@ -726,7 +727,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 	if (ww_ctx)
 		ww_mutex_lock_acquired(ww, ww_ctx);
 
-	raw_spin_unlock(&lock->wait_lock);
+	raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
 	if (ww_ctx)
 		ww_ctx_wake(ww_ctx);
 	preempt_enable();
@@ -737,7 +738,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 	__mutex_remove_waiter(lock, &waiter);
 err_early_kill:
 	trace_contention_end(lock, ret);
-	raw_spin_unlock(&lock->wait_lock);
+	raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
 	debug_mutex_free_waiter(&waiter);
 	mutex_release(&lock->dep_map, ip);
 	if (ww_ctx)
@@ -909,6 +910,7 @@ static noinline void __sched __mutex_unlock_slowpath(struct mutex *lock, unsigne
 	struct task_struct *next = NULL;
 	DEFINE_WAKE_Q(wake_q);
 	unsigned long owner;
+	unsigned long flags;
 
 	mutex_release(&lock->dep_map, ip);
 
@@ -935,7 +937,7 @@ static noinline void __sched __mutex_unlock_slowpath(struct mutex *lock, unsigne
 		}
 	}
 
-	raw_spin_lock(&lock->wait_lock);
+	raw_spin_lock_irqsave(&lock->wait_lock, flags);
 	debug_mutex_unlock(lock);
 	if (!list_empty(&lock->wait_list)) {
 		/* get the first entry from the wait-list: */
@@ -953,7 +955,7 @@ static noinline void __sched __mutex_unlock_slowpath(struct mutex *lock, unsigne
 		__mutex_handoff(lock, next);
 
 	preempt_disable();
-	raw_spin_unlock(&lock->wait_lock);
+	raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
 
 	wake_up_q(&wake_q);
 	preempt_enable();
diff --git a/kernel/locking/ww_mutex.h b/kernel/locking/ww_mutex.h
index e49ea5336473..984a4e0bff36 100644
--- a/kernel/locking/ww_mutex.h
+++ b/kernel/locking/ww_mutex.h
@@ -70,14 +70,14 @@ __ww_mutex_has_waiters(struct mutex *lock)
 	return atomic_long_read(&lock->owner) & MUTEX_FLAG_WAITERS;
 }
 
-static inline void lock_wait_lock(struct mutex *lock)
+static inline void lock_wait_lock(struct mutex *lock, unsigned long *flags)
 {
-	raw_spin_lock(&lock->wait_lock);
+	raw_spin_lock_irqsave(&lock->wait_lock, *flags);
 }
 
-static inline void unlock_wait_lock(struct mutex *lock)
+static inline void unlock_wait_lock(struct mutex *lock, unsigned long flags)
 {
-	raw_spin_unlock(&lock->wait_lock);
+	raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
 }
 
 static inline void lockdep_assert_wait_lock_held(struct mutex *lock)
@@ -144,14 +144,14 @@ __ww_mutex_has_waiters(struct rt_mutex *lock)
 	return rt_mutex_has_waiters(&lock->rtmutex);
 }
 
-static inline void lock_wait_lock(struct rt_mutex *lock)
+static inline void lock_wait_lock(struct rt_mutex *lock, unsigned long *flags)
 {
-	raw_spin_lock(&lock->rtmutex.wait_lock);
+	raw_spin_lock_irqsave(&lock->rtmutex.wait_lock, *flags);
 }
 
-static inline void unlock_wait_lock(struct rt_mutex *lock)
+static inline void unlock_wait_lock(struct rt_mutex *lock, flags)
 {
-	raw_spin_unlock(&lock->rtmutex.wait_lock);
+	raw_spin_unlock_irqrestore(&lock->rtmutex.wait_lock, flags);
 }
 
 static inline void lockdep_assert_wait_lock_held(struct rt_mutex *lock)
@@ -383,6 +383,8 @@ __ww_mutex_check_waiters(struct MUTEX *lock, struct ww_acquire_ctx *ww_ctx)
 static __always_inline void
 ww_mutex_set_context_fastpath(struct ww_mutex *lock, struct ww_acquire_ctx *ctx)
 {
+	unsigned long flags;
+
 	ww_mutex_lock_acquired(lock, ctx);
 
 	/*
@@ -410,9 +412,9 @@ ww_mutex_set_context_fastpath(struct ww_mutex *lock, struct ww_acquire_ctx *ctx)
 	 * Uh oh, we raced in fastpath, check if any of the waiters need to
 	 * die or wound us.
 	 */
-	lock_wait_lock(&lock->base);
+	lock_wait_lock(&lock->base, &flags);
 	__ww_mutex_check_waiters(&lock->base, ctx);
-	unlock_wait_lock(&lock->base);
+	unlock_wait_lock(&lock->base, flags);
 }
 
 static __always_inline int
-- 
2.40.0.577.gac1e443424-goog

