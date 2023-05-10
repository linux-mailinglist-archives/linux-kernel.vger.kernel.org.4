Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A720D6FE2C1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 18:51:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235982AbjEJQvW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 12:51:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231402AbjEJQvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 12:51:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81D4C7EEA;
        Wed, 10 May 2023 09:51:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0BCF4635CD;
        Wed, 10 May 2023 16:51:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C05FC433D2;
        Wed, 10 May 2023 16:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683737476;
        bh=e5svw6pITw1IMjZGGc9XWb9jqmKkBvDUvNW+meAVtoM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TgykYrWLZJy54+ab8YkUgf6pZbz64aPmLpK8HryLKssVYHTNxFEXuH7pANZGS6Uua
         p0FqflRaYpEhcuiFdbfv9YKSG17dQYC9do2cIUwTLm8Zx6elRpOwKQiJnTfddE00gq
         76dBrbrL/+Tafe+E0rltfeXSq+p5QJvx2X3t4oAOKHUVpJ3kXGrA02C9GXKuWRJW+p
         OY1TWBHHN3G9WDRw9rF1mHDd3awh0pWOIOG8pJoFhUMi3RjYQZ8c6dhpu4K4RUvgiG
         CMrPw1HmSEmWvbiqEAJeoy7ewMzjZOh/0pBH8op2s/9YROkqhAjbVvDUDODM082LiY
         Q18joeQ/cQ+rA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 194D8CE126E; Wed, 10 May 2023 09:51:16 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 1/3] doc: Get rcutree module parameters back into alpha order
Date:   Wed, 10 May 2023 09:51:13 -0700
Message-Id: <20230510165115.2187040-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <16136ef4-9437-442b-b7c8-3fb6b2120873@paulmck-laptop>
References: <16136ef4-9437-442b-b7c8-3fb6b2120873@paulmck-laptop>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit puts the rcutree module parameters back into proper
alphabetical order.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 .../admin-guide/kernel-parameters.txt         | 120 +++++++++---------
 1 file changed, 60 insertions(+), 60 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 9e5bab29685f..8a094e2fc381 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4736,43 +4736,6 @@
 			the propagation of recent CPU-hotplug changes up
 			the rcu_node combining tree.
 
-	rcutree.use_softirq=	[KNL]
-			If set to zero, move all RCU_SOFTIRQ processing to
-			per-CPU rcuc kthreads.  Defaults to a non-zero
-			value, meaning that RCU_SOFTIRQ is used by default.
-			Specify rcutree.use_softirq=0 to use rcuc kthreads.
-
-			But note that CONFIG_PREEMPT_RT=y kernels disable
-			this kernel boot parameter, forcibly setting it
-			to zero.
-
-	rcutree.rcu_fanout_exact= [KNL]
-			Disable autobalancing of the rcu_node combining
-			tree.  This is used by rcutorture, and might
-			possibly be useful for architectures having high
-			cache-to-cache transfer latencies.
-
-	rcutree.rcu_fanout_leaf= [KNL]
-			Change the number of CPUs assigned to each
-			leaf rcu_node structure.  Useful for very
-			large systems, which will choose the value 64,
-			and for NUMA systems with large remote-access
-			latencies, which will choose a value aligned
-			with the appropriate hardware boundaries.
-
-	rcutree.rcu_min_cached_objs= [KNL]
-			Minimum number of objects which are cached and
-			maintained per one CPU. Object size is equal
-			to PAGE_SIZE. The cache allows to reduce the
-			pressure to page allocator, also it makes the
-			whole algorithm to behave better in low memory
-			condition.
-
-	rcutree.rcu_delay_page_cache_fill_msec= [KNL]
-			Set the page-cache refill delay (in milliseconds)
-			in response to low-memory conditions.  The range
-			of permitted values is in the range 0:100000.
-
 	rcutree.jiffies_till_first_fqs= [KNL]
 			Set delay from grace-period initialization to
 			first attempt to force quiescent states.
@@ -4811,21 +4774,6 @@
 			When RCU_NOCB_CPU is set, also adjust the
 			priority of NOCB callback kthreads.
 
-	rcutree.rcu_divisor= [KNL]
-			Set the shift-right count to use to compute
-			the callback-invocation batch limit bl from
-			the number of callbacks queued on this CPU.
-			The result will be bounded below by the value of
-			the rcutree.blimit kernel parameter.  Every bl
-			callbacks, the softirq handler will exit in
-			order to allow the CPU to do other work.
-
-			Please note that this callback-invocation batch
-			limit applies only to non-offloaded callback
-			invocation.  Offloaded callbacks are instead
-			invoked in the context of an rcuoc kthread, which
-			scheduler will preempt as it does any other task.
-
 	rcutree.nocb_nobypass_lim_per_jiffy= [KNL]
 			On callback-offloaded (rcu_nocbs) CPUs,
 			RCU reduces the lock contention that would
@@ -4839,14 +4787,6 @@
 			the ->nocb_bypass queue.  The definition of "too
 			many" is supplied by this kernel boot parameter.
 
-	rcutree.rcu_nocb_gp_stride= [KNL]
-			Set the number of NOCB callback kthreads in
-			each group, which defaults to the square root
-			of the number of CPUs.	Larger numbers reduce
-			the wakeup overhead on the global grace-period
-			kthread, but increases that same overhead on
-			each group's NOCB grace-period kthread.
-
 	rcutree.qhimark= [KNL]
 			Set threshold of queued RCU callbacks beyond which
 			batch limiting is disabled.
@@ -4864,6 +4804,56 @@
 			on rcutree.qhimark at boot time and to zero to
 			disable more aggressive help enlistment.
 
+	rcutree.rcu_delay_page_cache_fill_msec= [KNL]
+			Set the page-cache refill delay (in milliseconds)
+			in response to low-memory conditions.  The range
+			of permitted values is in the range 0:100000.
+
+	rcutree.rcu_divisor= [KNL]
+			Set the shift-right count to use to compute
+			the callback-invocation batch limit bl from
+			the number of callbacks queued on this CPU.
+			The result will be bounded below by the value of
+			the rcutree.blimit kernel parameter.  Every bl
+			callbacks, the softirq handler will exit in
+			order to allow the CPU to do other work.
+
+			Please note that this callback-invocation batch
+			limit applies only to non-offloaded callback
+			invocation.  Offloaded callbacks are instead
+			invoked in the context of an rcuoc kthread, which
+			scheduler will preempt as it does any other task.
+
+	rcutree.rcu_fanout_exact= [KNL]
+			Disable autobalancing of the rcu_node combining
+			tree.  This is used by rcutorture, and might
+			possibly be useful for architectures having high
+			cache-to-cache transfer latencies.
+
+	rcutree.rcu_fanout_leaf= [KNL]
+			Change the number of CPUs assigned to each
+			leaf rcu_node structure.  Useful for very
+			large systems, which will choose the value 64,
+			and for NUMA systems with large remote-access
+			latencies, which will choose a value aligned
+			with the appropriate hardware boundaries.
+
+	rcutree.rcu_min_cached_objs= [KNL]
+			Minimum number of objects which are cached and
+			maintained per one CPU. Object size is equal
+			to PAGE_SIZE. The cache allows to reduce the
+			pressure to page allocator, also it makes the
+			whole algorithm to behave better in low memory
+			condition.
+
+	rcutree.rcu_nocb_gp_stride= [KNL]
+			Set the number of NOCB callback kthreads in
+			each group, which defaults to the square root
+			of the number of CPUs.	Larger numbers reduce
+			the wakeup overhead on the global grace-period
+			kthread, but increases that same overhead on
+			each group's NOCB grace-period kthread.
+
 	rcutree.rcu_kick_kthreads= [KNL]
 			Cause the grace-period kthread to get an extra
 			wake_up() if it sleeps three times longer than
@@ -4885,6 +4875,16 @@
 			rcu_node tree with an eye towards determining
 			why a new grace period has not yet started.
 
+	rcutree.use_softirq=	[KNL]
+			If set to zero, move all RCU_SOFTIRQ processing to
+			per-CPU rcuc kthreads.  Defaults to a non-zero
+			value, meaning that RCU_SOFTIRQ is used by default.
+			Specify rcutree.use_softirq=0 to use rcuc kthreads.
+
+			But note that CONFIG_PREEMPT_RT=y kernels disable
+			this kernel boot parameter, forcibly setting it
+			to zero.
+
 	rcuscale.gp_async= [KNL]
 			Measure performance of asynchronous
 			grace-period primitives such as call_rcu().
-- 
2.40.1

