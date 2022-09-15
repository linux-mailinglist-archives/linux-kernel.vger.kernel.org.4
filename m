Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E1A65B9CC2
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 16:17:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbiIOOQq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 10:16:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbiIOOQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 10:16:42 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E83A25A2C8;
        Thu, 15 Sep 2022 07:16:40 -0700 (PDT)
Date:   Thu, 15 Sep 2022 14:16:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1663251398;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eMvD6jjlbRsFd+s2e4cOs1s7I1Uh1C5NgEpu4VtLWUQ=;
        b=J0qJzOC3GVrSpso2nQsSdXQwVfp3gRUQfagb6zRecH452hcxwj5haYePvy6ANxfRRi94A5
        v4IpOybLZ2fB2SOLdlASg5TV+o9YIjEfOLOANRwhdpFHVS5Rv6kZnCW8L0sBKy48W3wosN
        zTRaTz6iGrR4DPbHugIcgP29Zwpy9Ahbg8to1knG7eYjJM2uQnylTTILZZkAqjjYWQMQe/
        XeFrMPAV1ojUkO8xUehLujjwDUlFMNkriH3Set5o9PdgCNtlTxYgSlioK7wn2WNrhzlLYR
        xIeL9gravNt657gOj3bVoqesWIaPSw3pJyCuTEEwH/aMWjNfk6S6zgz6rGZ2/A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1663251398;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eMvD6jjlbRsFd+s2e4cOs1s7I1Uh1C5NgEpu4VtLWUQ=;
        b=hptVoQpJ3Wv8KGAK/DvUjh5lzAol3Zyb3CyS30NR01wbtRd7P9Dsm047zLGRU+Mv/YO1u2
        ntTVxZelPppbjJDg==
From:   "tip-bot2 for Namhyung Kim" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf: Kill __PERF_SAMPLE_CALLCHAIN_EARLY
Cc:     Namhyung Kim <namhyung@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220908214104.3851807-3-namhyung@kernel.org>
References: <20220908214104.3851807-3-namhyung@kernel.org>
MIME-Version: 1.0
Message-ID: <166325139712.401.13892634089162382455.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     b4e12b2d70fd9eccdb3cef8015dc1788ca38e3fd
Gitweb:        https://git.kernel.org/tip/b4e12b2d70fd9eccdb3cef8015dc1788ca38e3fd
Author:        Namhyung Kim <namhyung@kernel.org>
AuthorDate:    Thu, 08 Sep 2022 14:41:04 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 13 Sep 2022 15:03:23 +02:00

perf: Kill __PERF_SAMPLE_CALLCHAIN_EARLY

There's no in-tree user anymore.  Let's get rid of it.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20220908214104.3851807-3-namhyung@kernel.org
---
 arch/x86/events/amd/ibs.c       | 10 ----------
 arch/x86/events/intel/core.c    |  3 ---
 include/uapi/linux/perf_event.h |  2 --
 3 files changed, 15 deletions(-)

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index dab0941..ce5720b 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -300,16 +300,6 @@ static int perf_ibs_init(struct perf_event *event)
 	hwc->config_base = perf_ibs->msr;
 	hwc->config = config;
 
-	/*
-	 * rip recorded by IbsOpRip will not be consistent with rsp and rbp
-	 * recorded as part of interrupt regs. Thus we need to use rip from
-	 * interrupt regs while unwinding call stack. Setting _EARLY flag
-	 * makes sure we unwind call-stack before perf sample rip is set to
-	 * IbsOpRip.
-	 */
-	if (event->attr.sample_type & PERF_SAMPLE_CALLCHAIN)
-		event->attr.sample_type |= __PERF_SAMPLE_CALLCHAIN_EARLY;
-
 	return 0;
 }
 
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 7f4e7e6..b16c91a 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3868,9 +3868,6 @@ static int intel_pmu_hw_config(struct perf_event *event)
 		}
 		if (x86_pmu.pebs_aliases)
 			x86_pmu.pebs_aliases(event);
-
-		if (event->attr.sample_type & PERF_SAMPLE_CALLCHAIN)
-			event->attr.sample_type |= __PERF_SAMPLE_CALLCHAIN_EARLY;
 	}
 
 	if (needs_branch_stack(event)) {
diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index dca1658..e639c74 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -164,8 +164,6 @@ enum perf_event_sample_format {
 	PERF_SAMPLE_WEIGHT_STRUCT		= 1U << 24,
 
 	PERF_SAMPLE_MAX = 1U << 25,		/* non-ABI */
-
-	__PERF_SAMPLE_CALLCHAIN_EARLY		= 1ULL << 63, /* non-ABI; internal use */
 };
 
 #define PERF_SAMPLE_WEIGHT_TYPE	(PERF_SAMPLE_WEIGHT | PERF_SAMPLE_WEIGHT_STRUCT)
