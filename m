Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65EDC731718
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 13:40:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238801AbjFOLjr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 07:39:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343975AbjFOLi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 07:38:56 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A014D30F4;
        Thu, 15 Jun 2023 04:38:15 -0700 (PDT)
Date:   Thu, 15 Jun 2023 11:38:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686829094;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jjyYguGFs2U0Ix82lCRk+pLP0T2H4echqzZFEN6s9bk=;
        b=upOY2LIFtTZbLWuUZgUZWjkHa94EVsAj6nIsEUcLBOj+Po/sWDPKlIqSfVbb++oBRJ/uAo
        E6paPglz7O2Y8duzJ53kY2riU4AbPRTN5ovqVSScFPK5NU+Dwo7GOjZJQcbW1jNZF2Uw6V
        czG5x8GCzo/DQVZuFrw37Xb+e/UEK79+o7C9NoQ+YFUaFLzDxSmP2NKW09DthqisSlwId0
        8rbz3lCXuEAyCs1uZU1MbsfNPO6jw5gAAl6YtiC0bBVCwGDI4uauf2OV8iEsQ5KpnMnO31
        g+R7bvD7MgBWN4MRPWx9fgys7XQ4o2ce+TZbbGbSrN6gAgSPb1oHStSzsPM+yQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686829094;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jjyYguGFs2U0Ix82lCRk+pLP0T2H4echqzZFEN6s9bk=;
        b=nf4Z/FOlGTKv9UYFnkIhj83aLhTTp7GbSKOdnwi5sKj5xVFq5F5rJOXx2jO+UzoUDf1Que
        Kmu+l3rn1QrwRXDQ==
From:   "tip-bot2 for Tom Rix" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Rename variable cpu_util eff_util
Cc:     Tom Rix <trix@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Valentin Schneider <vschneid@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230611122535.183654-1-trix@redhat.com>
References: <20230611122535.183654-1-trix@redhat.com>
MIME-Version: 1.0
Message-ID: <168682909369.404.14833174104608297588.tip-bot2@tip-bot2>
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

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     24cce6bc14759bbddd8d2252d733212e1911b977
Gitweb:        https://git.kernel.org/tip/24cce6bc14759bbddd8d2252d733212e1911b977
Author:        Tom Rix <trix@redhat.com>
AuthorDate:    Sun, 11 Jun 2023 08:25:35 -04:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 15 Jun 2023 13:28:20 +02:00

sched/fair: Rename variable cpu_util eff_util

cppcheck reports
kernel/sched/fair.c:7436:17: style: Local variable 'cpu_util' shadows outer function [shadowFunction]
  unsigned long cpu_util;
                ^

Clean this up by renaming the variable to eff_util

Signed-off-by: Tom Rix <trix@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Valentin Schneider <vschneid@redhat.com>
Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Link: https://lore.kernel.org/r/20230611122535.183654-1-trix@redhat.com
---
 kernel/sched/fair.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 819efad..0219cf8 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7463,7 +7463,7 @@ eenv_pd_max_util(struct energy_env *eenv, struct cpumask *pd_cpus,
 	for_each_cpu(cpu, pd_cpus) {
 		struct task_struct *tsk = (cpu == dst_cpu) ? p : NULL;
 		unsigned long util = cpu_util(cpu, p, dst_cpu, 1);
-		unsigned long cpu_util;
+		unsigned long eff_util;
 
 		/*
 		 * Performance domain frequency: utilization clamping
@@ -7472,8 +7472,8 @@ eenv_pd_max_util(struct energy_env *eenv, struct cpumask *pd_cpus,
 		 * NOTE: in case RT tasks are running, by default the
 		 * FREQUENCY_UTIL's utilization can be max OPP.
 		 */
-		cpu_util = effective_cpu_util(cpu, util, FREQUENCY_UTIL, tsk);
-		max_util = max(max_util, cpu_util);
+		eff_util = effective_cpu_util(cpu, util, FREQUENCY_UTIL, tsk);
+		max_util = max(max_util, eff_util);
 	}
 
 	return min(max_util, eenv->cpu_cap);
