Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B8217192D6
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 07:59:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231570AbjFAF7K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 01:59:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231346AbjFAF7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 01:59:02 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B76B3E2
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 22:59:00 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-1b04dbcf0dbso11627185ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 22:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685599140; x=1688191140;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FaQ7YZpF/a7XORZFgvpD5+n/cW3rFAGF9tyaRnUZ5sQ=;
        b=PHMTWzkkY25hOPAv9d+K9oomvi0+2+zzYTPyqcbL9XE7laYRcOGfak4pVh55ON2xVB
         E7pFkIzp2gSGJGq41w6Urs7YP2oGAAtai2qfJuztgcDLqvsubulaYwJ+O3xs3jCEPup0
         kX4b9jyPGpPYzrb2bI3vhvGvRIhII70pB/KUa69cfodkCH0j2oUL1AR11LH/4cuz+CUI
         UFBP0pVcTVsi0gb5G2sIFOEug55lSkMRivzYEyerlDEaQbqAXcE3gyJnWF7fS/812wWv
         CO6b3Nku4VDqaKDoOvaQfM9Q2GTg1sM4U6zs+ezsayB6VeFkx/LguGX2LEx/ee96sWpx
         hyXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685599140; x=1688191140;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FaQ7YZpF/a7XORZFgvpD5+n/cW3rFAGF9tyaRnUZ5sQ=;
        b=DHUH6LutLVFP1+DfXetfRT77ecJ9UJAOUmHe6NHX2MjRGO7guz1X89VKkoPgDSznWg
         z4bZrW8JYuDDSjSFrhlPMocSwG9b0sfAE0BMWj72wBdFSktB4xBaNEp8a9i4lxjYZlYY
         m7K9ycqP41tGSLa2hQGUvWAM/6kEQoVkj9O+6f5VnoZ8tGMGhtHoMAgZW0zJNZ1THBtI
         wpsCsZOqXW+59WMQO3gJaUG2vuD+61Mep8mTx9ykhvBBn3nWs7fpBMF/4hmiOpP0w5Mz
         9caOVPCEaldbp727YMuMlNazbQTTirc3fxdpeZ/NuiMUes+I5ULxAitpM4MLYgzLbrP2
         RaQA==
X-Gm-Message-State: AC+VfDz8axEMFTJIRlXp+n4R/6IePojORrTyIzjuC8AMyOuoX773f7Ho
        cowv31AhW7ZmtsADC4SFxPXlmQOEUzpVYKhdqJN2NZdzsoIV8VjsT02zM3yfmGWX1eAfj+0ji42
        8UbM/YXtlVucg2Jgl39+bLcFMZDL+2DjQkZSji+M7fw15ZH8QsQT5yIxVoiA5BPJvtHyDF24=
X-Google-Smtp-Source: ACHHUZ6HpMMjpu8n5u2KFXjOvtyPTw2eZJoxVN8kwfJg896ESK42l3fkGQaU3GakiUKI4K8S1L/Jq91ZR9R5
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a17:902:a5c9:b0:1a6:8a07:960a with SMTP id
 t9-20020a170902a5c900b001a68a07960amr187334plq.0.1685599139086; Wed, 31 May
 2023 22:58:59 -0700 (PDT)
Date:   Thu,  1 Jun 2023 05:58:05 +0000
In-Reply-To: <20230601055846.2349566-1-jstultz@google.com>
Mime-Version: 1.0
References: <20230601055846.2349566-1-jstultz@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Message-ID: <20230601055846.2349566-3-jstultz@google.com>
Subject: [PATCH v4 02/13] locking/ww_mutex: Remove wakeups from under mutex::wait_lock
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
        Youssef Esmat <youssefesmat@google.com>,
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
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
Cc: Youssef Esmat <youssefesmat@google.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Will Deacon <will@kernel.org>
Cc: Waiman Long <longman@redhat.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: "Paul E . McKenney" <paulmck@kernel.org>
Cc: kernel-team@android.com
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
2.41.0.rc0.172.g3f132b7071-goog

