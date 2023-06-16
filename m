Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36EB4733481
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 17:16:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345919AbjFPPQw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 11:16:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345700AbjFPPQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 11:16:46 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 980B03590;
        Fri, 16 Jun 2023 08:16:44 -0700 (PDT)
Date:   Fri, 16 Jun 2023 15:16:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686928603;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T2X08GY+8je3qIgAuEB7aoFUINAb3BIhnuWZ+7W6UHM=;
        b=1mS2+hNsg8EjxouaUGM6POvlbWuURlGOeAXX/6Z7a9wsO1HzzFqNyCUp1PaRJNGZInT1I0
        qizOSEhLKAW2KWrGznlc2xd4N4vWqx/tVZBlQiCK2Xy4MfU3r9Z23GCk6AAViOrw8D5Lbg
        ZnBkC8pdn9QD2PVGSeSywRRwVIi1FVUKm4yEKm72v6x6S4NIc1eWTXgNfw22mVxOSmoN8O
        090/3FjitJBJDU7+joI/GG1mG4XPkslVLAFlUBJQoyWXmEBtEk6HY3fNaVAJX6r1SrLJ+e
        K8HBBj7XBRC39NaE+ihkQ1Fiy3Aj6G5GJfALmiH6ivOghoje6vTmFumU56W26Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686928603;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T2X08GY+8je3qIgAuEB7aoFUINAb3BIhnuWZ+7W6UHM=;
        b=cVkHiXdcXgRkHiGge5BLxf9ikfsxikbq6nu2VxzWvXaoeUgOlC8jzvBD/MbXhKCqW45+YA
        BPi1r8h3JKOLCrAQ==
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
Message-ID: <168692860274.404.124512830013535834.tip-bot2@tip-bot2>
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

Commit-ID:     a707df30c9438a9d4d0a43ae7f22b59b078f94c4
Gitweb:        https://git.kernel.org/tip/a707df30c9438a9d4d0a43ae7f22b59b078f94c4
Author:        Tom Rix <trix@redhat.com>
AuthorDate:    Sun, 11 Jun 2023 08:25:35 -04:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 16 Jun 2023 17:08:01 +02:00

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
index 6189d1a..7666dbc 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7433,7 +7433,7 @@ eenv_pd_max_util(struct energy_env *eenv, struct cpumask *pd_cpus,
 	for_each_cpu(cpu, pd_cpus) {
 		struct task_struct *tsk = (cpu == dst_cpu) ? p : NULL;
 		unsigned long util = cpu_util(cpu, p, dst_cpu, 1);
-		unsigned long cpu_util;
+		unsigned long eff_util;
 
 		/*
 		 * Performance domain frequency: utilization clamping
@@ -7442,8 +7442,8 @@ eenv_pd_max_util(struct energy_env *eenv, struct cpumask *pd_cpus,
 		 * NOTE: in case RT tasks are running, by default the
 		 * FREQUENCY_UTIL's utilization can be max OPP.
 		 */
-		cpu_util = effective_cpu_util(cpu, util, FREQUENCY_UTIL, tsk);
-		max_util = max(max_util, cpu_util);
+		eff_util = effective_cpu_util(cpu, util, FREQUENCY_UTIL, tsk);
+		max_util = max(max_util, eff_util);
 	}
 
 	return min(max_util, eenv->cpu_cap);
