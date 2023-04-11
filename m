Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A10F66DD0DD
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 06:25:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbjDKEZ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 00:25:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbjDKEZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 00:25:22 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AED9110E
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 21:25:21 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-54c01480e3cso150821757b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 21:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1681187121; x=1683779121;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9MZM9lxALf3anqWVT8caCUbvqRi6B6TU3wXrzxXwWm8=;
        b=m8OotgtBD1dzwzHFSOf6A8OMx2YT3W8fCJbtXvtA35su8koTUi5BxAyq9TwdQjLanf
         ogg8wPBp/laRDNFwwTEQ9ErH0fSRI6i1zZf4WjfvWsG+FsZtyq7/cVYGj+FUpNj//EYG
         E8FJTf7BFLWX7kkpnTnBM2FcPY2yHolepF1Q+BEwvK2FnIUhvqgvjuOmvFXUpt1zN9Md
         s1pccaUyOi5wl0OSWlqTtE29In4QAdG6qcLGje9UDqb8eWV9EVWhVdpLctYqswWxWPjm
         TZHXMB9KvWywjlgs67eHfiUM0z5VXQ7zC8HjylL8ux7XCWHGtmeHAzeWpyL64I4yy08O
         w/rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681187121; x=1683779121;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9MZM9lxALf3anqWVT8caCUbvqRi6B6TU3wXrzxXwWm8=;
        b=ukuGJxBPyEWxr4c3mlVnQ8M2q+XcAJCefotiBUpnRf9BxQ0ZhpJKoavtRlLCaJ6PLN
         1ma0+yeG9UyIDASrpQLT424pH9uhGScQ6ffEzpU7tmzxlwwQ9Zpld+KlyEI/G86BUSxD
         RrBWCXHvi2ZdakXovcbRJ9j37ibPeghnmJwA0Q31hn1pD7WXeV833X/a+wBB7+n0ALhy
         6si/uiV6GYyDa3gEiLLu3dFWEIxchiIIc7MfD8gsB/resAzomToa92i8w4lqcKIrC9n4
         swAw7/R1Oix+V6pWvbDqT5mnLyv8Q310SYklKn1A2chUQzQIzxrmOL410qcljPy+vJTH
         hRrA==
X-Gm-Message-State: AAQBX9d5wSjSZ73j0kxEdRBLTMHuE4jTBOXtdQBWTZGxKLiRmfdDGGan
        dyzeiS/ymvwhuccdFJV6ZLv2x5tjNShrXg0/ehVU7UVauRpxR1h3+U+MGLiZO//POqvnHyxJpqs
        uhrdIhkKGInzN19D98zfE3hxy6U1zA5aWJth6vwh38Kxf4sNT4NQHmeCitacPqSq62eLQlJI=
X-Google-Smtp-Source: AKy350YJspf/c1sV4lTrsMq9sZ1AzhVO1/PBLcmtTpNkA1tlHXm2jVcp0657Vmq/Xm8eTXxtqEPw5W9i8YZS
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a81:ad61:0:b0:546:6ef:8baf with SMTP id
 l33-20020a81ad61000000b0054606ef8bafmr6900052ywk.2.1681187120831; Mon, 10 Apr
 2023 21:25:20 -0700 (PDT)
Date:   Tue, 11 Apr 2023 04:24:58 +0000
In-Reply-To: <20230411042511.1606592-1-jstultz@google.com>
Mime-Version: 1.0
References: <20230411042511.1606592-1-jstultz@google.com>
X-Mailer: git-send-email 2.40.0.577.gac1e443424-goog
Message-ID: <20230411042511.1606592-2-jstultz@google.com>
Subject: [PATCH v3 01/14] locking/ww_mutex: Remove wakeups from under mutex::wait_lock
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

From: Peter Zijlstra <peterz@infradead.org>

In preparation to nest mutex::wait_lock under rq::lock we need to remove
wakeups from under it.

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
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Connor O'Brien <connoro@google.com>
Signed-off-by: John Stultz <jstultz@google.com>
---
v2:
* Move wake_q_init() as suggested by Waiman Long
---
 include/linux/ww_mutex.h  |  3 +++
 kernel/locking/mutex.c    |  8 ++++++++
 kernel/locking/ww_mutex.h | 10 ++++++++--
 3 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/include/linux/ww_mutex.h b/include/linux/ww_mutex.h
index bb763085479a..9335b2202017 100644
--- a/include/linux/ww_mutex.h
+++ b/include/linux/ww_mutex.h
@@ -19,6 +19,7 @@
 
 #include <linux/mutex.h>
 #include <linux/rtmutex.h>
+#include <linux/sched/wake_q.h>
 
 #if defined(CONFIG_DEBUG_MUTEXES) || \
    (defined(CONFIG_PREEMPT_RT) && defined(CONFIG_DEBUG_RT_MUTEXES))
@@ -58,6 +59,7 @@ struct ww_acquire_ctx {
 	unsigned int acquired;
 	unsigned short wounded;
 	unsigned short is_wait_die;
+	struct wake_q_head wake_q;
 #ifdef DEBUG_WW_MUTEXES
 	unsigned int done_acquire;
 	struct ww_class *ww_class;
@@ -137,6 +139,7 @@ static inline void ww_acquire_init(struct ww_acquire_ctx *ctx,
 	ctx->acquired = 0;
 	ctx->wounded = false;
 	ctx->is_wait_die = ww_class->is_wait_die;
+	wake_q_init(&ctx->wake_q);
 #ifdef DEBUG_WW_MUTEXES
 	ctx->ww_class = ww_class;
 	ctx->done_acquire = 0;
diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index d973fe6041bf..1582756914df 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -676,6 +676,8 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 		}
 
 		raw_spin_unlock(&lock->wait_lock);
+		if (ww_ctx)
+			ww_ctx_wake(ww_ctx);
 		schedule_preempt_disabled();
 
 		first = __mutex_waiter_is_first(lock, &waiter);
@@ -725,6 +727,8 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 		ww_mutex_lock_acquired(ww, ww_ctx);
 
 	raw_spin_unlock(&lock->wait_lock);
+	if (ww_ctx)
+		ww_ctx_wake(ww_ctx);
 	preempt_enable();
 	return 0;
 
@@ -736,6 +740,8 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 	raw_spin_unlock(&lock->wait_lock);
 	debug_mutex_free_waiter(&waiter);
 	mutex_release(&lock->dep_map, ip);
+	if (ww_ctx)
+		ww_ctx_wake(ww_ctx);
 	preempt_enable();
 	return ret;
 }
@@ -946,9 +952,11 @@ static noinline void __sched __mutex_unlock_slowpath(struct mutex *lock, unsigne
 	if (owner & MUTEX_FLAG_HANDOFF)
 		__mutex_handoff(lock, next);
 
+	preempt_disable();
 	raw_spin_unlock(&lock->wait_lock);
 
 	wake_up_q(&wake_q);
+	preempt_enable();
 }
 
 #ifndef CONFIG_DEBUG_LOCK_ALLOC
diff --git a/kernel/locking/ww_mutex.h b/kernel/locking/ww_mutex.h
index 56f139201f24..e49ea5336473 100644
--- a/kernel/locking/ww_mutex.h
+++ b/kernel/locking/ww_mutex.h
@@ -161,6 +161,12 @@ static inline void lockdep_assert_wait_lock_held(struct rt_mutex *lock)
 
 #endif /* WW_RT */
 
+void ww_ctx_wake(struct ww_acquire_ctx *ww_ctx)
+{
+	wake_up_q(&ww_ctx->wake_q);
+	wake_q_init(&ww_ctx->wake_q);
+}
+
 /*
  * Wait-Die:
  *   The newer transactions are killed when:
@@ -284,7 +290,7 @@ __ww_mutex_die(struct MUTEX *lock, struct MUTEX_WAITER *waiter,
 #ifndef WW_RT
 		debug_mutex_wake_waiter(lock, waiter);
 #endif
-		wake_up_process(waiter->task);
+		wake_q_add(&ww_ctx->wake_q, waiter->task);
 	}
 
 	return true;
@@ -331,7 +337,7 @@ static bool __ww_mutex_wound(struct MUTEX *lock,
 		 * wakeup pending to re-read the wounded state.
 		 */
 		if (owner != current)
-			wake_up_process(owner);
+			wake_q_add(&ww_ctx->wake_q, owner);
 
 		return true;
 	}
-- 
2.40.0.577.gac1e443424-goog

