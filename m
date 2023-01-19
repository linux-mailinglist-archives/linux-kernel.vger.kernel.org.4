Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60911673DD6
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 16:46:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231351AbjASPq0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 10:46:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231326AbjASPqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 10:46:14 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4F0486ED2;
        Thu, 19 Jan 2023 07:46:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jhvtngKBeAgm0UEGoU0G2NmyFhttBS3hhRWFEdNmOPE=; b=rbPSIr6h2eeFKrbPmtUCev05v1
        njPF7zxdL7Y8WQWKrTNEIWwJV+7j5abZ1RhVfIFF4hhGFVSWunsAUGl1oX6JInadEbtHktJCMtzyE
        KeaSQtL8Z1v0lMMe+dO+Cwbd6GTA3SLfhManQxk7INRkf5rtPkWvvP+c5zwtXlQjE8FYDfBR2jyAv
        AyEMbhPCvDXJgGIvpoRaTxY59b1vt59hpFx0Ifwbf84js48TGws6hdvrsCzw2Cr5f3DC9Xh8t/HUL
        4eXSjjfGfwEZEHNp8vBfU3aOOMIY/I9prXp0sgfF2Vs+eZvEdopl2CQ/KSNL6czH1IAMzgmEwlGg+
        uYl83/qw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pIX6s-0016EM-SW; Thu, 19 Jan 2023 15:45:51 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 85FC0300348;
        Thu, 19 Jan 2023 16:45:49 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D564D20DC0EA0; Thu, 19 Jan 2023 16:45:49 +0100 (CET)
Date:   Thu, 19 Jan 2023 16:45:49 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     kernel test robot <oliver.sang@intel.com>
Cc:     oe-lkp@lists.linux.dev, lkp@intel.com,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        linux-trace-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [tip:sched/core] [tracing, hardirq]  9aedeaed6f:
 WARNING:suspicious_RCU_usage
Message-ID: <Y8llrdNT6RD/0dbq@hirez.programming.kicks-ass.net>
References: <202301192148.58ece903-oliver.sang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202301192148.58ece903-oliver.sang@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2023 at 10:06:21PM +0800, kernel test robot wrote:
> 
> Greeting,
> 
> FYI, we noticed WARNING:suspicious_RCU_usage due to commit (built with gcc-11):
> 
> commit: 9aedeaed6fc6fe8452b9b8225e95cc2b8631ff91 ("tracing, hardirq: No moar _rcuidle() tracing")
> https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git sched/core
> 
> [test failed on linux-next/master f3381a7baf5ccbd091eb2c4fd2afd84266fcef24]
> 
> in testcase: kernel-selftests
> version: kernel-selftests-x86_64-d4cf28ee-1_20230110
> with following parameters:
> 
> 	group: ftrace

Moo, so I've had these patches in my git tree for months :/

The thing that seems to shut it up is the below, but I'm not entirely
sure how we get there, all the code should be cpuidle/noinstr, which
implies notrace.

Steve, what's the easiest way to figure out what triggers this? Put a
printk() in prepare_ftrace_return() or so?

---

diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
index 3183aeb7f5b4..fecdf0bb3bc4 100644
--- a/include/linux/cpuidle.h
+++ b/include/linux/cpuidle.h
@@ -15,6 +15,7 @@
 #include <linux/list.h>
 #include <linux/hrtimer.h>
 #include <linux/context_tracking.h>
+#include <linux/ftrace.h>
 
 #define CPUIDLE_STATE_MAX	10
 #define CPUIDLE_NAME_LEN	16
@@ -119,6 +120,7 @@ DECLARE_PER_CPU(struct cpuidle_device, cpuidle_dev);
 static __always_inline void ct_cpuidle_enter(void)
 {
 	lockdep_assert_irqs_disabled();
+	pause_graph_tracing();
 	/*
 	 * Idle is allowed to (temporary) enable IRQs. It
 	 * will return with IRQs disabled.
@@ -143,6 +145,7 @@ static __always_inline void ct_cpuidle_exit(void)
 	lockdep_hardirqs_off(_RET_IP_);
 	ct_idle_exit();
 	instrumentation_begin();
+	unpause_graph_tracing();
 }
 
 /****************************

