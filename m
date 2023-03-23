Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 063FF6C5CBF
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 03:40:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbjCWCkp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 22:40:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbjCWCki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 22:40:38 -0400
Received: from mx1.zhaoxin.com (MX1.ZHAOXIN.COM [210.0.225.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FCC12ED65
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 19:40:37 -0700 (PDT)
X-ASG-Debug-ID: 1679539227-086e23383d19100003-xx1T2L
Received: from ZXSHMBX1.zhaoxin.com (ZXSHMBX1.zhaoxin.com [10.28.252.163]) by mx1.zhaoxin.com with ESMTP id bDEbG0HSgFQx1BTG (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Thu, 23 Mar 2023 10:40:28 +0800 (CST)
X-Barracuda-Envelope-From: SilviaZhao-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.163
Received: from ZXBJMBX02.zhaoxin.com (10.29.252.6) by ZXSHMBX1.zhaoxin.com
 (10.28.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16; Thu, 23 Mar
 2023 10:40:28 +0800
Received: from silvia-OptiPlex-3010.zhaoxin.com (10.29.8.47) by
 ZXBJMBX02.zhaoxin.com (10.29.252.6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 23 Mar 2023 10:40:26 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.163
From:   silviazhao <silviazhao-oc@zhaoxin.com>
X-Barracuda-RBL-Trusted-Forwarder: 10.29.252.6
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>, <irogers@google.com>,
        <adrian.hunter@intel.com>, <tglx@linutronix.de>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <cobechen@zhaoxin.com>, <louisqi@zhaoxin.com>,
        <silviazhao@zhaoxin.com>, <cooperyan@zhaoxin.com>
Subject: [PATCH 2/3] perf/x86/zhaoxin: Replace open-coded model number with macros
Date:   Thu, 23 Mar 2023 10:40:25 +0800
X-ASG-Orig-Subj: [PATCH 2/3] perf/x86/zhaoxin: Replace open-coded model number with macros
Message-ID: <20230323024026.823-3-silviazhao-oc@zhaoxin.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230323024026.823-1-silviazhao-oc@zhaoxin.com>
References: <20230323024026.823-1-silviazhao-oc@zhaoxin.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.29.8.47]
X-ClientProxiedBy: zxbjmbx1.zhaoxin.com (10.29.252.163) To
 ZXBJMBX02.zhaoxin.com (10.29.252.6)
X-Barracuda-Connect: ZXSHMBX1.zhaoxin.com[10.28.252.163]
X-Barracuda-Start-Time: 1679539228
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.35:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 3668
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.106421
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace open-coded family-7 model number in arch/x86/events/zhaoxin/
core.c with the macros defined in zhaoxin-family.h.

Zhaoxin used to use non-canonical name for family 7 processors in
arch/x86/events/zhaoxin/core.c. Replace them with architecture name
to keep consistent with the macros. Following are the correspondences:
ZXD -> Wudaokou
ZXE -> Lujiazui

Signed-off-by: silviazhao <silviazhao-oc@zhaoxin.com>
---
 arch/x86/events/zhaoxin/core.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/arch/x86/events/zhaoxin/core.c b/arch/x86/events/zhaoxin/core.c
index 3e9acdaeed1e..34ccb214478c 100644
--- a/arch/x86/events/zhaoxin/core.c
+++ b/arch/x86/events/zhaoxin/core.c
@@ -14,6 +14,7 @@
 
 #include <asm/cpufeature.h>
 #include <asm/hardirq.h>
+#include <asm/zhaoxin-family.h>
 #include <asm/apic.h>
 
 #include "../perf_event.h"
@@ -36,7 +37,7 @@ static struct event_constraint zxc_event_constraints[] __read_mostly = {
 	EVENT_CONSTRAINT_END
 };
 
-static struct event_constraint zxd_event_constraints[] __read_mostly = {
+static struct event_constraint wudaokou_event_constraints[] __read_mostly = {
 
 	FIXED_EVENT_CONSTRAINT(0x00c0, 0), /* retired instructions */
 	FIXED_EVENT_CONSTRAINT(0x0082, 1), /* unhalted core clock cycles */
@@ -44,7 +45,7 @@ static struct event_constraint zxd_event_constraints[] __read_mostly = {
 	EVENT_CONSTRAINT_END
 };
 
-static __initconst const u64 zxd_hw_cache_event_ids
+static __initconst const u64 wudaokou_hw_cache_event_ids
 				[PERF_COUNT_HW_CACHE_MAX]
 				[PERF_COUNT_HW_CACHE_OP_MAX]
 				[PERF_COUNT_HW_CACHE_RESULT_MAX] = {
@@ -148,7 +149,7 @@ static __initconst const u64 zxd_hw_cache_event_ids
 },
 };
 
-static __initconst const u64 zxe_hw_cache_event_ids
+static __initconst const u64 lujiazui_hw_cache_event_ids
 				[PERF_COUNT_HW_CACHE_MAX]
 				[PERF_COUNT_HW_CACHE_OP_MAX]
 				[PERF_COUNT_HW_CACHE_RESULT_MAX] = {
@@ -471,7 +472,7 @@ static const struct x86_pmu zhaoxin_pmu __initconst = {
 	.max_events		= ARRAY_SIZE(zx_pmon_event_map),
 	.apic			= 1,
 	/*
-	 * For zxd/zxe, read/write operation for PMCx MSR is 48 bits.
+	 * For wudaokou/lujiazui, read/write operation for PMCx MSR is 48 bits.
 	 */
 	.max_period		= (1ULL << 47) - 1,
 	.get_event_constraints	= zhaoxin_get_event_constraints,
@@ -573,27 +574,27 @@ __init int zhaoxin_pmu_init(void)
 			X86_CONFIG(.event = 0x0f, .umask = 0x04, .inv = 0, .cmask = 0);
 
 		switch (boot_cpu_data.x86_model) {
-		case 0x1b:
-			memcpy(hw_cache_event_ids, zxd_hw_cache_event_ids,
+		case ZHAOXIN_FAM7_WUDAOKOU:
+			memcpy(hw_cache_event_ids, wudaokou_hw_cache_event_ids,
 			       sizeof(hw_cache_event_ids));
 
-			x86_pmu.event_constraints = zxd_event_constraints;
+			x86_pmu.event_constraints = wudaokou_event_constraints;
 
 			zx_pmon_event_map[PERF_COUNT_HW_BRANCH_INSTRUCTIONS] = 0x0700;
 			zx_pmon_event_map[PERF_COUNT_HW_BRANCH_MISSES] = 0x0709;
 
-			pr_cont("ZXD events, ");
+			pr_cont("Wudaokou events, ");
 			break;
-		case 0x3b:
-			memcpy(hw_cache_event_ids, zxe_hw_cache_event_ids,
+		case ZHAOXIN_FAM7_LUJIAZUI:
+			memcpy(hw_cache_event_ids, lujiazui_hw_cache_event_ids,
 			       sizeof(hw_cache_event_ids));
 
-			x86_pmu.event_constraints = zxd_event_constraints;
+			x86_pmu.event_constraints = wudaokou_event_constraints;
 
 			zx_pmon_event_map[PERF_COUNT_HW_BRANCH_INSTRUCTIONS] = 0x0028;
 			zx_pmon_event_map[PERF_COUNT_HW_BRANCH_MISSES] = 0x0029;
 
-			pr_cont("ZXE events, ");
+			pr_cont("Lujiazui events, ");
 			break;
 		default:
 			return -ENODEV;
-- 
2.17.1

