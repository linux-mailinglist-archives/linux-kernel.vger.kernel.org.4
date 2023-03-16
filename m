Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87ADE6BC3CD
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 03:32:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbjCPCca (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 22:32:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjCPCc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 22:32:29 -0400
X-Greylist: delayed 932 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 15 Mar 2023 19:32:26 PDT
Received: from mx1.zhaoxin.com (MX1.ZHAOXIN.COM [210.0.225.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D07F2310B
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 19:32:25 -0700 (PDT)
X-ASG-Debug-ID: 1678933008-086e23383a0caf0001-xx1T2L
Received: from ZXSHMBX1.zhaoxin.com (ZXSHMBX1.zhaoxin.com [10.28.252.163]) by mx1.zhaoxin.com with ESMTP id tm8aC84sEFWYeBmF (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Thu, 16 Mar 2023 10:16:48 +0800 (CST)
X-Barracuda-Envelope-From: SilviaZhao-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.163
Received: from ZXBJMBX02.zhaoxin.com (10.29.252.6) by ZXSHMBX1.zhaoxin.com
 (10.28.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16; Thu, 16 Mar
 2023 10:16:48 +0800
Received: from silvia-OptiPlex-3010.zhaoxin.com (10.29.8.47) by
 ZXBJMBX02.zhaoxin.com (10.29.252.6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 16 Mar 2023 10:16:47 +0800
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
Subject: [PATCH] perf/x86/zhaoxin: Add Yongfeng support
Date:   Thu, 16 Mar 2023 10:16:47 +0800
X-ASG-Orig-Subj: [PATCH] perf/x86/zhaoxin: Add Yongfeng support
Message-ID: <20230316021647.771-1-silviazhao-oc@zhaoxin.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.29.8.47]
X-ClientProxiedBy: zxbjmbx1.zhaoxin.com (10.29.252.163) To
 ZXBJMBX02.zhaoxin.com (10.29.252.6)
X-Barracuda-Connect: ZXSHMBX1.zhaoxin.com[10.28.252.163]
X-Barracuda-Start-Time: 1678933008
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.35:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 3206
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.106093
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for Yongfeng which is Zhaoxin's successor microarchitecture
to ZXE.

Remove PERF_COUNT_HW_CACHE_REFERENCES and PERF_COUNT_HW_CACHE_MISSES
from global zx_pmon_event_map, since the cache hierarchy was changed
from Yongfeng, and these pmc event map changed too.

Add PERF_COUNT_HW_BRANCH_INSTRUCTIONS and PERF_COUNT_HW_BRANCH_MISSES
to global zx_pmon_event_map, since these two event will keep consistent
for ZXE and later.

Signed-off-by: silviazhao <silviazhao-oc@zhaoxin.com>
---
 arch/x86/events/zhaoxin/core.c | 29 ++++++++++++++++++++++++-----
 1 file changed, 24 insertions(+), 5 deletions(-)

diff --git a/arch/x86/events/zhaoxin/core.c b/arch/x86/events/zhaoxin/core.c
index 3e9acdaeed1e..06a0923a9581 100644
--- a/arch/x86/events/zhaoxin/core.c
+++ b/arch/x86/events/zhaoxin/core.c
@@ -19,15 +19,15 @@
 #include "../perf_event.h"
 
 /*
- * Zhaoxin PerfMon, used on zxc and later.
+ * Zhaoxin PerfMon, used on ZXE and later.
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
@@ -559,6 +559,8 @@ __init int zhaoxin_pmu_init(void)
 			zx_pmon_event_map[PERF_COUNT_HW_CACHE_REFERENCES] = 0;
 			zx_pmon_event_map[PERF_COUNT_HW_CACHE_MISSES] = 0;
 			zx_pmon_event_map[PERF_COUNT_HW_BUS_CYCLES] = 0;
+			zx_pmon_event_map[PERF_COUNT_HW_BRANCH_INSTRUCTIONS] = 0;
+			zx_pmon_event_map[PERF_COUNT_HW_BRANCH_MISSES] = 0;
 
 			pr_cont("ZXC events, ");
 			break;
@@ -579,6 +581,9 @@ __init int zhaoxin_pmu_init(void)
 
 			x86_pmu.event_constraints = zxd_event_constraints;
 
+			zx_pmon_event_map[PERF_COUNT_HW_CACHE_REFERENCES]  = 0x0515,
+			zx_pmon_event_map[PERF_COUNT_HW_CACHE_MISSES]      = 0x051a,
+
 			zx_pmon_event_map[PERF_COUNT_HW_BRANCH_INSTRUCTIONS] = 0x0700;
 			zx_pmon_event_map[PERF_COUNT_HW_BRANCH_MISSES] = 0x0709;
 
@@ -590,11 +595,25 @@ __init int zhaoxin_pmu_init(void)
 
 			x86_pmu.event_constraints = zxd_event_constraints;
 
-			zx_pmon_event_map[PERF_COUNT_HW_BRANCH_INSTRUCTIONS] = 0x0028;
-			zx_pmon_event_map[PERF_COUNT_HW_BRANCH_MISSES] = 0x0029;
+			zx_pmon_event_map[PERF_COUNT_HW_CACHE_REFERENCES]  = 0x0515,
+			zx_pmon_event_map[PERF_COUNT_HW_CACHE_MISSES]      = 0x051a,
 
 			pr_cont("ZXE events, ");
 			break;
+		case 0x5b:
+			zx_pmon_event_map[PERF_COUNT_HW_STALLED_CYCLES_FRONTEND] =
+				X86_CONFIG(.event = 0x02, .umask = 0x01, .inv = 0x01,
+						.cmask = 0x01);
+
+			memcpy(hw_cache_event_ids, zxe_hw_cache_event_ids,
+					sizeof(hw_cache_event_ids));
+
+			x86_pmu.event_constraints = zxd_event_constraints;
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

