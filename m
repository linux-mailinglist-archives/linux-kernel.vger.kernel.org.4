Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DA385F37FE
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 23:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbiJCVpW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 17:45:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbiJCVpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 17:45:12 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED64114D16
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 14:45:10 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id o91-20020a17090a0a6400b0020a72db3b87so2361053pjo.5
        for <linux-kernel@vger.kernel.org>; Mon, 03 Oct 2022 14:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=PIwBsFUD4Ot2l3U8sW+vVhpIiC7Hv9NlG7rycXRX2po=;
        b=WsbC16muix309bhmioqs8JVwvNFkkMDaq54hdAngB8qg74k12aNlX6m/jXFMQw68Hz
         xVdkbG/ox1TVUu9nPM959l5QO3b6uQ6SG8nwNtEsjG+Fba0urh7pfpFBsSr0KQo7UTRv
         fi9Wxr24Uz0rV/L0Eu0d7tl7xsJG8BEtBIJRQ3yGNjqqgh8GGP6Bh0HQF92m0AET+xEF
         qG+JSm+fjRRyLHvXxJA7lgMyknnmmpKiApT5nnBiKYGFtKHEHjpH452HGTbr6qeTMVec
         Q2io8QnU5YKsXKxhaOTV5C4NEKCYPTnWGSwhGS7yt+J3gFr76dMsmQMTnhgx68mtEC6/
         8VeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=PIwBsFUD4Ot2l3U8sW+vVhpIiC7Hv9NlG7rycXRX2po=;
        b=Eg6+zd1NjKp40xNCvLjH0vyavsDzqCbOVbbpjmFzWBJmPlTHTAusAAex5rKSo0AetA
         kHGZTE36FpTyJqlC+eue5w4drq7PWc0+8uW05Wh1/B63FzcpRJzfKPqX0sQN12QhR5Y7
         ZG/cMM37j5P1QHyJ8bvEJFiuUGFuPHr3jxtdc1GlkPUGXCzSwjT0a9ObAlepNQqinrXk
         PJGsIO3cWdpmQ4UqsQmp9olT3Tg28pRuaeO1Vg/DVnnff6RVe2zu628NGA1eUEMuwobN
         rFIDUA8BUF7oMg2IhgcyWzEkr4erZvN6JQuyCXJCR10QwI1XTfeQai2Nuc3OdM4Ok12S
         OnXg==
X-Gm-Message-State: ACrzQf02XpNAZpXUKmm3wk7d6aaWWEdOBPRCzE4qnMcAruOziztyNlVP
        wbmaLRaOjnT/KzesmSFVEX4c2DPG2IHh+JkPkdE2Oa9AZpZm1wkEeRUfawK9ZLNrxTRhfB0Gulp
        smV3v2b0DvII6HwFnaW30NHlOHJvz4xZfl5eYHmjcrB5Vdt8Md+6yBxSml7sMYo1GnvpsfBsp
X-Google-Smtp-Source: AMsMyM6jVzjtgYcqJCYTAYXYgBMFEx+HLsCSl+XDfyDhxM/eLW7+jaVcJDULrhHqZFf4GxgDJ03aimEkdAe1
X-Received: from connoro.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:a99])
 (user=connoro job=sendgmr) by 2002:a17:90a:c986:b0:205:f08c:a82b with SMTP id
 w6-20020a17090ac98600b00205f08ca82bmr65264pjt.1.1664833508580; Mon, 03 Oct
 2022 14:45:08 -0700 (PDT)
Date:   Mon,  3 Oct 2022 21:44:53 +0000
In-Reply-To: <20221003214501.2050087-1-connoro@google.com>
Mime-Version: 1.0
References: <20221003214501.2050087-1-connoro@google.com>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Message-ID: <20221003214501.2050087-4-connoro@google.com>
Subject: [RFC PATCH 03/11] kernel/locking: Add p->blocked_on wrapper
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

From: Valentin Schneider <valentin.schneider@arm.com>

This lets us assert p->blocked_lock is held whenever we access
p->blocked_on.

XXX: just make a pointer return, so we can also check at get's.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
[fix conflicts]
Signed-off-by: Connor O'Brien <connoro@google.com>
---
 include/linux/sched.h  | 7 +++++++
 kernel/locking/mutex.c | 6 +++---
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index bd995e66d7d6..379e4c052644 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2201,6 +2201,13 @@ static inline int rwlock_needbreak(rwlock_t *lock)
 #endif
 }
 
+static inline void set_task_blocked_on(struct task_struct *p, struct mutex *m)
+{
+	lockdep_assert_held(&p->blocked_lock);
+
+	p->blocked_on = m;
+}
+
 static __always_inline bool need_resched(void)
 {
 	return unlikely(tif_need_resched());
diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index f05cd2d216c7..7800380219db 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -645,7 +645,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 			goto err_early_kill;
 	}
 
-	current->blocked_on = lock;
+	set_task_blocked_on(current, lock);
 	set_current_state(state);
 	trace_contention_begin(lock, LCB_F_MUTEX);
 	for (;;) {
@@ -686,7 +686,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 		/*
 		 * Gets reset by ttwu_runnable().
 		 */
-		current->blocked_on = lock;
+		set_task_blocked_on(current, lock);
 		set_current_state(state);
 		/*
 		 * Here we order against unlock; we must either see it change
@@ -720,7 +720,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 	}
 
 	__mutex_remove_waiter(lock, &waiter);
-	current->blocked_on = NULL;
+	set_task_blocked_on(current, NULL);
 
 	debug_mutex_free_waiter(&waiter);
 
-- 
2.38.0.rc1.362.ged0d419d3c-goog

