Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF70C6C5CBE
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 03:40:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230191AbjCWCkr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 22:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbjCWCkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 22:40:41 -0400
Received: from mx1.zhaoxin.com (MX1.ZHAOXIN.COM [210.0.225.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA9B52ED62
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 19:40:39 -0700 (PDT)
X-ASG-Debug-ID: 1679539227-086e23383d19100004-xx1T2L
Received: from ZXSHMBX1.zhaoxin.com (ZXSHMBX1.zhaoxin.com [10.28.252.163]) by mx1.zhaoxin.com with ESMTP id HrCO3B1dqIWL6POD (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Thu, 23 Mar 2023 10:40:29 +0800 (CST)
X-Barracuda-Envelope-From: SilviaZhao-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.163
Received: from ZXBJMBX02.zhaoxin.com (10.29.252.6) by ZXSHMBX1.zhaoxin.com
 (10.28.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16; Thu, 23 Mar
 2023 10:40:28 +0800
Received: from silvia-OptiPlex-3010.zhaoxin.com (10.29.8.47) by
 ZXBJMBX02.zhaoxin.com (10.29.252.6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 23 Mar 2023 10:40:27 +0800
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
Subject: [PATCH 3/3] perf/x86/zhaoxin: Add Yongfeng support
Date:   Thu, 23 Mar 2023 10:40:26 +0800
X-ASG-Orig-Subj: [PATCH 3/3] perf/x86/zhaoxin: Add Yongfeng support
Message-ID: <20230323024026.823-4-silviazhao-oc@zhaoxin.com>
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
X-Barracuda-Scan-Msg-Size: 3268
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

Add support for Yongfeng which is Zhaoxin's successor microarchitecture
to Lujiazui.

Remove PERF_COUNT_HW_CACHE_REFERENCES and PERF_COUNT_HW_CACHE_MISSES
from global zx_pmon_event_map, since the cache hierarchy was changed
from Yongfeng, and these pmc event map changed too.

Add PERF_COUNT_HW_BRANCH_INSTRUCTIONS and PERF_COUNT_HW_BRANCH_MISSES
to global zx_pmon_event_map, since these two events will keep
consistent for Lujiazui and later.

Signed-off-by: silviazhao <silviazhao-oc@zhaoxin.com>
---
 arch/x86/events/zhaoxin/core.c | 30 +++++++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

diff --git a/arch/x86/events/zhaoxin/core.c b/arch/x86/events/zhaoxin/core.c
index 34ccb214478c..634aa0c4a8c6 100644
--- a/arch/x86/events/zhaoxin/core.c
+++ b/arch/x86/events/zhaoxin/core.c
@@ -20,15 +20,15 @@
 #include "../perf_event.h"
 
 /*
- * Zhaoxin PerfMon, used on zxc and later.
+ * Zhaoxin PerfMon, used on Lujiazui and later.
  */
 static u64 zx_pmon_event_map[PERF_COUNT_HW_MAX] __read_mostly = {
 
 	[PERF_COUNT_HW_CPU_CYCLES]        = 0x0082,
 	[PERF_COUNT_HW_INSTRUCTIONS]      = 0x00c0,
-	[PERF_COUNT_HW_CACHE_REFERENCES]  = 0x0515,
-	[PERF_COUNT_HW_CACHE_MISSES]      = 0x051a,
 	[PERF_COUNT_HW_BUS_CYCLES]        = 0x0083,
+	[PERF_COUNT_HW_BRANCH_INSTRUCTIONS] = 0x0028,
+	[PERF_COUNT_HW_BRANCH_MISSES]	= 0x0029,
 };
 
 static struct event_constraint zxc_event_constraints[] __read_mostly = {
@@ -560,6 +560,8 @@ __init int zhaoxin_pmu_init(void)
 			zx_pmon_event_map[PERF_COUNT_HW_CACHE_REFERENCES] = 0;
 			zx_pmon_event_map[PERF_COUNT_HW_CACHE_MISSES] = 0;
 			zx_pmon_event_map[PERF_COUNT_HW_BUS_CYCLES] = 0;
+			zx_pmon_event_map[PERF_COUNT_HW_BRANCH_INSTRUCTIONS] = 0;
+			zx_pmon_event_map[PERF_COUNT_HW_BRANCH_MISSES] = 0;
 
 			pr_cont("ZXC events, ");
 			break;
@@ -580,6 +582,9 @@ __init int zhaoxin_pmu_init(void)
 
 			x86_pmu.event_constraints = wudaokou_event_constraints;
 
+			zx_pmon_event_map[PERF_COUNT_HW_CACHE_REFERENCES]  = 0x0515,
+			zx_pmon_event_map[PERF_COUNT_HW_CACHE_MISSES]      = 0x051a,
+
 			zx_pmon_event_map[PERF_COUNT_HW_BRANCH_INSTRUCTIONS] = 0x0700;
 			zx_pmon_event_map[PERF_COUNT_HW_BRANCH_MISSES] = 0x0709;
 
@@ -591,11 +596,26 @@ __init int zhaoxin_pmu_init(void)
 
 			x86_pmu.event_constraints = wudaokou_event_constraints;
 
-			zx_pmon_event_map[PERF_COUNT_HW_BRANCH_INSTRUCTIONS] = 0x0028;
-			zx_pmon_event_map[PERF_COUNT_HW_BRANCH_MISSES] = 0x0029;
+			zx_pmon_event_map[PERF_COUNT_HW_CACHE_REFERENCES]  = 0x0515,
+			zx_pmon_event_map[PERF_COUNT_HW_CACHE_MISSES]      = 0x051a,
 
 			pr_cont("Lujiazui events, ");
 			break;
+		case ZHAOXIN_FAM7_YONGFENG:
+			zx_pmon_event_map[PERF_COUNT_HW_STALLED_CYCLES_FRONTEND] =
+				X86_CONFIG(.event = 0x02, .umask = 0x01, .inv = 0x01,
+						.cmask = 0x01);
+
+			memcpy(hw_cache_event_ids, lujiazui_hw_cache_event_ids,
+					sizeof(hw_cache_event_ids));
+
+			x86_pmu.event_constraints = wudaokou_event_constraints;
+
+			zx_pmon_event_map[PERF_COUNT_HW_CACHE_REFERENCES]  = 0x051a;
+			zx_pmon_event_map[PERF_COUNT_HW_CACHE_MISSES]      = 0;
+
+			pr_cont("Yongfeng events, ");
+			break;
 		default:
 			return -ENODEV;
 		}
-- 
2.17.1

