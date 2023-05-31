Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BD27717F7F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 14:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235620AbjEaMFB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 08:05:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235574AbjEaMEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 08:04:51 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95C0EE5;
        Wed, 31 May 2023 05:04:50 -0700 (PDT)
Date:   Wed, 31 May 2023 12:04:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1685534689;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EnXceI711UzJSpm9Tc/LUW38R3dqqmQbiyu3XHe+824=;
        b=UZHQhSJbYkB7uyPgdESiTQ4qHJrR7+m/n67D4HEMYCVOFxZZe3aNOPK4m6aHr/q9SkL0Vt
        rlPLjST1ZGR4sorLSsC2OGPx+6LDIrBBQ6HJVee0GG/eWgAgIw2UvU4zl1lAeXBsWYKPJG
        sx2KshNrSxJ2NlynKPr4HgECCXi6f5N14Z4cLaGglUV9DzpRVpKiCBFZUDZ2lH1BZSjfRY
        g4uMTaz25XBw9je7gileZ6N6Ag3wbDepqEl5rKKGyOR3EVP50j2DdhZ1xjqi/q7eMz1O6z
        f0O9xToRXeGfNGVj/2MR7/jrFKMuj1jXDGWSza8bAO/68jW+qmmV0sxGHigE/w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1685534689;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EnXceI711UzJSpm9Tc/LUW38R3dqqmQbiyu3XHe+824=;
        b=nmQRFUKe+/Ed7WwHBQQ6GgyOxr87CkfCWXEG0OaGFOr1cQkLAeunAlFkD+420y5jNW9QSS
        SpLRIByHu7qLmwBA==
From:   "tip-bot2 for Arnd Bergmann" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Move unused stub functions to header
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230522195021.3456768-6-arnd@kernel.org>
References: <20230522195021.3456768-6-arnd@kernel.org>
MIME-Version: 1.0
Message-ID: <168553468874.404.6309078676435197068.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     7aa55f2a5902646a19db89dab9961867724b27b8
Gitweb:        https://git.kernel.org/tip/7aa55f2a5902646a19db89dab9961867724b27b8
Author:        Arnd Bergmann <arnd@arndb.de>
AuthorDate:    Mon, 22 May 2023 21:50:21 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 30 May 2023 22:46:26 +02:00

sched/fair: Move unused stub functions to header

These four functions have a normal definition for CONFIG_FAIR_GROUP_SCHED,
and empty one that is only referenced when FAIR_GROUP_SCHED is disabled
but CGROUP_SCHED is still enabled. If both are turned off, the functions
are still defined but the misisng prototype causes a W=1 warning:

kernel/sched/fair.c:12544:6: error: no previous prototype for 'free_fair_sched_group'
kernel/sched/fair.c:12546:5: error: no previous prototype for 'alloc_fair_sched_group'
kernel/sched/fair.c:12553:6: error: no previous prototype for 'online_fair_sched_group'
kernel/sched/fair.c:12555:6: error: no previous prototype for 'unregister_fair_sched_group'

Move the alternatives into the header as static inline functions with
the correct combination of #ifdef checks to avoid the warning without
adding even more complexity.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://lore.kernel.org/r/20230522195021.3456768-6-arnd@kernel.org
---
 kernel/sched/fair.c  | 6 +++---
 kernel/sched/sched.h | 2 --
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index a7a8ccd..48b6f0c 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -684,7 +684,7 @@ struct sched_entity *__pick_last_entity(struct cfs_rq *cfs_rq)
 /**************************************************************
  * Scheduling class statistics methods:
  */
-#ifdef CONFIG_SMP
+
 int sched_update_scaling(void)
 {
 	unsigned int factor = get_update_sysctl_factor();
@@ -702,7 +702,6 @@ int sched_update_scaling(void)
 	return 0;
 }
 #endif
-#endif
 
 /*
  * delta /= w
@@ -6169,8 +6168,9 @@ static inline int throttled_lb_pair(struct task_group *tg,
 	return 0;
 }
 
-#ifdef CONFIG_FAIR_GROUP_SCHED
 void init_cfs_bandwidth(struct cfs_bandwidth *cfs_b) {}
+
+#ifdef CONFIG_FAIR_GROUP_SCHED
 static void init_cfs_rq_runtime(struct cfs_rq *cfs_rq) {}
 #endif
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index ce07782..6784462 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1245,7 +1245,6 @@ static inline raw_spinlock_t *__rq_lockp(struct rq *rq)
 
 bool cfs_prio_less(const struct task_struct *a, const struct task_struct *b,
 			bool fi);
-void task_vruntime_update(struct rq *rq, struct task_struct *p, bool in_fi);
 
 /*
  * Helpers to check if the CPU's core cookie matches with the task's cookie
@@ -2377,7 +2376,6 @@ static inline struct cpuidle_state *idle_get_state(struct rq *rq)
 #endif
 
 extern void schedule_idle(void);
-asmlinkage void schedule_user(void);
 
 extern void sysrq_sched_debug_show(void);
 extern void sched_init_granularity(void);
