Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EC9D5B3261
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 10:53:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbiIIIxR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 04:53:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbiIIIwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 04:52:45 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 591CB12D183;
        Fri,  9 Sep 2022 01:52:44 -0700 (PDT)
Date:   Fri, 09 Sep 2022 08:52:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1662713563;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EkLlHUf5V3qYjPzJAngJrSkRW8mWN3xGC6k8351nL1Q=;
        b=XYejB2vn6cVNnrzugMlad1odzFET+AelS1mrmSznByXJ3ZiwdyyMyjXMN7K0ksgulGpcvn
        ZVXGej0smIYYk95lThrPQXnLRGEMz41M/h5ePlmpfAHptxgrn8X4CPoMOjUvUUzy21U8U5
        wtfyn6K0caQQiltQwphdvff/YSIp9GwuVOxDjBnFHXSGXojcvN3jOf/1nKM6RvIDQkEgzx
        3j7H1K/ykpiDmkmcVX83WnQ8MQpGdAL1/oRpY5Bvn1ZqAMHs65RT0sDHaON0p+htb1e7Q0
        3KhGem15LubEi8YMQs3EBM2fI2GxHC0HHOJXX742qnG6UFLo8As0pL+AASyHQw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1662713563;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EkLlHUf5V3qYjPzJAngJrSkRW8mWN3xGC6k8351nL1Q=;
        b=hynCCeWMkH6WA4PWHHMAdXr8IfyFirgcyRdFfw8mBMeOrt7SrUymtvYYvUyqwwXZTSMCaL
        xdC9rTyJJjtdqrAg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86: Add two more x86_pmu methods
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220829101321.440196408@infradead.org>
References: <20220829101321.440196408@infradead.org>
MIME-Version: 1.0
Message-ID: <166271356180.401.10487629377866189074.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     73759c346341d39dfde39701476c0376dea0a98b
Gitweb:        https://git.kernel.org/tip/73759c346341d39dfde39701476c0376dea0a98b
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 10 May 2022 21:27:22 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 07 Sep 2022 21:54:02 +02:00

perf/x86: Add two more x86_pmu methods

In order to clean up x86_perf_event_{set_period,update)() start by
adding them as x86_pmu methods.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20220829101321.440196408@infradead.org
---
 arch/x86/events/core.c       | 22 +++++++++++++++++-----
 arch/x86/events/perf_event.h |  5 +++++
 2 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index bb34a28..bb559b7 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -72,6 +72,9 @@ DEFINE_STATIC_CALL_NULL(x86_pmu_add,  *x86_pmu.add);
 DEFINE_STATIC_CALL_NULL(x86_pmu_del,  *x86_pmu.del);
 DEFINE_STATIC_CALL_NULL(x86_pmu_read, *x86_pmu.read);
 
+DEFINE_STATIC_CALL_NULL(x86_pmu_set_period, *x86_pmu.set_period);
+DEFINE_STATIC_CALL_NULL(x86_pmu_update,     *x86_pmu.update);
+
 DEFINE_STATIC_CALL_NULL(x86_pmu_schedule_events,       *x86_pmu.schedule_events);
 DEFINE_STATIC_CALL_NULL(x86_pmu_get_event_constraints, *x86_pmu.get_event_constraints);
 DEFINE_STATIC_CALL_NULL(x86_pmu_put_event_constraints, *x86_pmu.put_event_constraints);
@@ -1518,7 +1521,7 @@ static void x86_pmu_start(struct perf_event *event, int flags)
 
 	if (flags & PERF_EF_RELOAD) {
 		WARN_ON_ONCE(!(event->hw.state & PERF_HES_UPTODATE));
-		x86_perf_event_set_period(event);
+		static_call(x86_pmu_set_period)(event);
 	}
 
 	event->hw.state = 0;
@@ -1610,7 +1613,7 @@ void x86_pmu_stop(struct perf_event *event, int flags)
 		 * Drain the remaining delta count out of a event
 		 * that we are disabling:
 		 */
-		x86_perf_event_update(event);
+		static_call(x86_pmu_update)(event);
 		hwc->state |= PERF_HES_UPTODATE;
 	}
 }
@@ -1700,7 +1703,7 @@ int x86_pmu_handle_irq(struct pt_regs *regs)
 
 		event = cpuc->events[idx];
 
-		val = x86_perf_event_update(event);
+		val = static_call(x86_pmu_update)(event);
 		if (val & (1ULL << (x86_pmu.cntval_bits - 1)))
 			continue;
 
@@ -1709,7 +1712,7 @@ int x86_pmu_handle_irq(struct pt_regs *regs)
 		 */
 		handled++;
 
-		if (!x86_perf_event_set_period(event))
+		if (!static_call(x86_pmu_set_period)(event))
 			continue;
 
 		perf_sample_data_init(&data, 0, event->hw.last_period);
@@ -2025,6 +2028,9 @@ static void x86_pmu_static_call_update(void)
 	static_call_update(x86_pmu_del, x86_pmu.del);
 	static_call_update(x86_pmu_read, x86_pmu.read);
 
+	static_call_update(x86_pmu_set_period, x86_pmu.set_period);
+	static_call_update(x86_pmu_update, x86_pmu.update);
+
 	static_call_update(x86_pmu_schedule_events, x86_pmu.schedule_events);
 	static_call_update(x86_pmu_get_event_constraints, x86_pmu.get_event_constraints);
 	static_call_update(x86_pmu_put_event_constraints, x86_pmu.put_event_constraints);
@@ -2044,7 +2050,7 @@ static void x86_pmu_static_call_update(void)
 
 static void _x86_pmu_read(struct perf_event *event)
 {
-	x86_perf_event_update(event);
+	static_call(x86_pmu_update)(event);
 }
 
 void x86_pmu_show_pmu_cap(int num_counters, int num_counters_fixed,
@@ -2151,6 +2157,12 @@ static int __init init_hw_perf_events(void)
 	if (!x86_pmu.guest_get_msrs)
 		x86_pmu.guest_get_msrs = (void *)&__static_call_return0;
 
+	if (!x86_pmu.set_period)
+		x86_pmu.set_period = x86_perf_event_set_period;
+
+	if (!x86_pmu.update)
+		x86_pmu.update = x86_perf_event_update;
+
 	x86_pmu_static_call_update();
 
 	/*
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 4a3dde2..7ae1a6c 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -743,6 +743,8 @@ struct x86_pmu {
 	void		(*add)(struct perf_event *);
 	void		(*del)(struct perf_event *);
 	void		(*read)(struct perf_event *event);
+	int		(*set_period)(struct perf_event *event);
+	u64		(*update)(struct perf_event *event);
 	int		(*hw_config)(struct perf_event *event);
 	int		(*schedule_events)(struct cpu_hw_events *cpuc, int n, int *assign);
 	unsigned	eventsel;
@@ -1042,6 +1044,9 @@ static struct perf_pmu_format_hybrid_attr format_attr_hybrid_##_name = {\
 struct pmu *x86_get_pmu(unsigned int cpu);
 extern struct x86_pmu x86_pmu __read_mostly;
 
+DECLARE_STATIC_CALL(x86_pmu_set_period, *x86_pmu.set_period);
+DECLARE_STATIC_CALL(x86_pmu_update,     *x86_pmu.update);
+
 static __always_inline struct x86_perf_task_context_opt *task_context_opt(void *ctx)
 {
 	if (static_cpu_has(X86_FEATURE_ARCH_LBR))
