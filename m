Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9944A5F37FF
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 23:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbiJCVpP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 17:45:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbiJCVpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 17:45:07 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BCA813D32
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 14:45:05 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-34d3fbc7cfcso121296117b3.7
        for <linux-kernel@vger.kernel.org>; Mon, 03 Oct 2022 14:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=B8qc+WSWzdXr6sM8i3dmxcLDMefnO3OCjkkf9PmCdBE=;
        b=bRzZme66F6sL4JTHAGE3E9J+hnKgkLdO3x7SmjqLaJeTXj5TSe2t918UOb4uOAfJQ9
         kCEI+VLuIBiHI6BlWY5mDN5QpXQZkl5Q8CJelYBfA/LUDhEKnBJSPIuJz/uI49ApDzT1
         RbCJtMx1p2/D2C0PInLVQ8xJHjxwM2cTzxnqzQiTgxASz/aPzJJnt9w8Kj0FM9twCmIb
         XwIx7wycmV/NVhn1nyIQw/EVm1/dNpcQ6gINAnLpdFF/7iBIO097+Hn1YVTmbbtIE3Qk
         BpjDPCrt8x0CkVqstv1/ndw7EDxinnvpQ4/1Ogd8TRwLJ3OSm12262JWCGtsaUC7aUn0
         nsMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=B8qc+WSWzdXr6sM8i3dmxcLDMefnO3OCjkkf9PmCdBE=;
        b=Z+jm1W9480sFZVdmxuCRhQaoycqytA2kdUSK4LBRLrLMV3+Dku2OC5/hXIQNkGnoVh
         66ZbZhMtAwq7x55a7G0yffZxQqlDpTzZRbE8YQUMpB8R/xa6Uai2F0dO0Kgd+rkJIiXu
         YV0FFkCeRMNrf0BiIht4Y4Trd1Zh2GFdm2AGWcpym4gUYOgxeKpb2bu30Tw4HOwyQILV
         7Gk3KKOnYL2GHnWLm2VA4eR7rDlKe+o9z8NGC8XAf70VXcmiJdAotQObyx0hZq4rykyf
         +CfJ9JPZ8E3dEzdrrQUe4RmA4X2YfpXVlt650HtHyiAR2/YvHyQKJ+sUS7Ds8I6s37q1
         EeBg==
X-Gm-Message-State: ACrzQf3GnOmWjwJwGHlFRfCeoqrEMR/Xs8GxYIdEHGdgd1qOjXOH4PNm
        W1tM6n31ocdui106+uUR4k7YKCa/z7illx8tfV5pKkiCUOwWJxr1jPckEY7sPtirHBQ/Sp8oQOj
        MSfnLfH1ytYKHOLjQBsaEXuIR+URLVju0f3rnTOYdzDWlHdQe1nUsWM+b44uqpu+lHzBnXwZr
X-Google-Smtp-Source: AMsMyM5i44JQ2L2wP9FusyWb2ZNatjUeGC+uiaQKGJUAefgSsbN7wyCZkpuPSDHol+WMSADbHHC64iQhkZJG
X-Received: from connoro.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:a99])
 (user=connoro job=sendgmr) by 2002:a81:a015:0:b0:35b:935b:8a1c with SMTP id
 x21-20020a81a015000000b0035b935b8a1cmr1028791ywg.297.1664833505008; Mon, 03
 Oct 2022 14:45:05 -0700 (PDT)
Date:   Mon,  3 Oct 2022 21:44:51 +0000
In-Reply-To: <20221003214501.2050087-1-connoro@google.com>
Mime-Version: 1.0
References: <20221003214501.2050087-1-connoro@google.com>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Message-ID: <20221003214501.2050087-2-connoro@google.com>
Subject: [RFC PATCH 01/11] locking/ww_mutex: Remove wakeups from under mutex::wait_lock
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

In preparation to nest mutex::wait_lock under rq::lock we need to remove
wakeups from under it.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Connor O'Brien <connoro@google.com>
---
 include/linux/ww_mutex.h  | 3 +++
 kernel/locking/mutex.c    | 8 ++++++++
 kernel/locking/ww_mutex.h | 9 +++++++--
 kernel/sched/core.c       | 7 +++++++
 4 files changed, 25 insertions(+), 2 deletions(-)

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
index 56f139201f24..dfc174cd96c6 100644
--- a/kernel/locking/ww_mutex.h
+++ b/kernel/locking/ww_mutex.h
@@ -161,6 +161,11 @@ static inline void lockdep_assert_wait_lock_held(struct rt_mutex *lock)
 
 #endif /* WW_RT */
 
+void ww_ctx_wake(struct ww_acquire_ctx *ww_ctx)
+{
+	wake_up_q(&ww_ctx->wake_q);
+}
+
 /*
  * Wait-Die:
  *   The newer transactions are killed when:
@@ -284,7 +289,7 @@ __ww_mutex_die(struct MUTEX *lock, struct MUTEX_WAITER *waiter,
 #ifndef WW_RT
 		debug_mutex_wake_waiter(lock, waiter);
 #endif
-		wake_up_process(waiter->task);
+		wake_q_add(&ww_ctx->wake_q, waiter->task);
 	}
 
 	return true;
@@ -331,7 +336,7 @@ static bool __ww_mutex_wound(struct MUTEX *lock,
 		 * wakeup pending to re-read the wounded state.
 		 */
 		if (owner != current)
-			wake_up_process(owner);
+			wake_q_add(&ww_ctx->wake_q, owner);
 
 		return true;
 	}
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index ee28253c9ac0..617e737392be 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1013,6 +1013,13 @@ void wake_up_q(struct wake_q_head *head)
 		wake_up_process(task);
 		put_task_struct(task);
 	}
+	/*
+	 * XXX connoro: seems this is needed now that ww_ctx_wake() passes in a
+	 * wake_q_head that is embedded in struct ww_acquire_ctx rather than
+	 * declared locally.
+	 */
+	head->first = node;
+	head->lastp = &head->first;
 }
 
 /*
-- 
2.38.0.rc1.362.ged0d419d3c-goog

