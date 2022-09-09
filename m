Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 276335B324B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 10:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbiIIIw6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 04:52:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231527AbiIIIwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 04:52:42 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E83012F22A;
        Fri,  9 Sep 2022 01:52:40 -0700 (PDT)
Date:   Fri, 09 Sep 2022 08:52:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1662713558;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zfLBYOk5fsHcL3Rcj35owICM/f85d4cSwp7DqZ4Fi8o=;
        b=Rr9RVrlqsxltKLrOZkMliKQDDmr5U9N5lQ8EVFvDHRy70L+K7dUHQ5qcGt+U9gaq75jzGF
        4qDBeOa51+U7/r+mZduXHmU3Vq5x580HmhBqeD+yqIEAwqEn1bHiGAD6j6GCqCQtNQcCFa
        WMxtuciCsSzmJYBcIrVUIaVbpI1zN3BD9hypvA9qCHGD1APgZcneoLiP5JnnZ2U8sygWT1
        We7TpwurhttXfmuslwuceF6l3gyGvJbs3F0ypcS5I5COzJ/y/fgl2nBoRafsJFuyTMIgz6
        0Mmd6KfG5hj6WJC8KErKZJviR6EOXG7CVaJtQLrPpCC/6mi7cHN1SakKx5sfQw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1662713558;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zfLBYOk5fsHcL3Rcj35owICM/f85d4cSwp7DqZ4Fi8o=;
        b=TOfduUH9RX9y50xnEB7T+F2UDTzT2qrNjujZ/pyY+7z2k7dK+3/+dCXKH/W7qB0xYU0WeQ
        quN8q1bKNp5kRGBw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel: Remove x86_pmu::set_topdown_event_period
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220829101321.706354189@infradead.org>
References: <20220829101321.706354189@infradead.org>
MIME-Version: 1.0
Message-ID: <166271355740.401.11201746805784007.tip-bot2@tip-bot2>
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

Commit-ID:     2368516731901c391826f7cf23516173193652fa
Gitweb:        https://git.kernel.org/tip/2368516731901c391826f7cf23516173193652fa
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 11 May 2022 16:41:25 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 07 Sep 2022 21:54:03 +02:00

perf/x86/intel: Remove x86_pmu::set_topdown_event_period

Now that it is all internal to the intel driver, remove
x86_pmu::set_topdown_event_period.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20220829101321.706354189@infradead.org
---
 arch/x86/events/intel/core.c | 16 ++++++++++------
 arch/x86/events/perf_event.h |  1 -
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 92cc390..75400ed 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2521,6 +2521,8 @@ static int adl_set_topdown_event_period(struct perf_event *event)
 	return icl_set_topdown_event_period(event);
 }
 
+DEFINE_STATIC_CALL(intel_pmu_set_topdown_event_period, x86_perf_event_set_period);
+
 static inline u64 icl_get_metrics_event_value(u64 metric, u64 slots, int idx)
 {
 	u32 val;
@@ -2811,9 +2813,8 @@ int intel_pmu_save_and_restart(struct perf_event *event)
 
 static int intel_pmu_set_period(struct perf_event *event)
 {
-	if (unlikely(is_topdown_count(event)) &&
-	    x86_pmu.set_topdown_event_period)
-		return x86_pmu.set_topdown_event_period(event);
+	if (unlikely(is_topdown_count(event)))
+		return static_call(intel_pmu_set_topdown_event_period)(event);
 
 	return x86_perf_event_set_period(event);
 }
@@ -6292,7 +6293,8 @@ __init int intel_pmu_init(void)
 		intel_pmu_pebs_data_source_skl(pmem);
 		x86_pmu.num_topdown_events = 4;
 		x86_pmu.update_topdown_event = icl_update_topdown_event;
-		x86_pmu.set_topdown_event_period = icl_set_topdown_event_period;
+		static_call_update(intel_pmu_set_topdown_event_period,
+				   &icl_set_topdown_event_period);
 		pr_cont("Icelake events, ");
 		name = "icelake";
 		break;
@@ -6330,7 +6332,8 @@ __init int intel_pmu_init(void)
 		intel_pmu_pebs_data_source_skl(pmem);
 		x86_pmu.num_topdown_events = 8;
 		x86_pmu.update_topdown_event = icl_update_topdown_event;
-		x86_pmu.set_topdown_event_period = icl_set_topdown_event_period;
+		static_call_update(intel_pmu_set_topdown_event_period,
+				   &icl_set_topdown_event_period);
 		pr_cont("Sapphire Rapids events, ");
 		name = "sapphire_rapids";
 		break;
@@ -6367,7 +6370,8 @@ __init int intel_pmu_init(void)
 		x86_pmu.pebs_latency_data = adl_latency_data_small;
 		x86_pmu.num_topdown_events = 8;
 		x86_pmu.update_topdown_event = adl_update_topdown_event;
-		x86_pmu.set_topdown_event_period = adl_set_topdown_event_period;
+		static_call_update(intel_pmu_set_topdown_event_period,
+				   &adl_set_topdown_event_period);
 
 		x86_pmu.filter_match = intel_pmu_filter_match;
 		x86_pmu.get_event_constraints = adl_get_event_constraints;
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index e82d2d2..be27ead 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -890,7 +890,6 @@ struct x86_pmu {
 	 */
 	int		num_topdown_events;
 	u64		(*update_topdown_event)(struct perf_event *event);
-	int		(*set_topdown_event_period)(struct perf_event *event);
 
 	/*
 	 * perf task context (i.e. struct perf_event_context::task_ctx_data)
