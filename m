Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6844D6370D6
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 04:13:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbiKXDNk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 22:13:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiKXDNW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 22:13:22 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA915C5623;
        Wed, 23 Nov 2022 19:13:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669259596; x=1700795596;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KxDtZCXW7I6hiXsjahohuKxDne9ZFD8qEUXPT92vcYY=;
  b=bhvfqJX1v7aYiSdu5ArjIToCJLeHtw40kUR8VxZn5IJGQsmF37Qh6WWO
   HuqzR7DLA5P3ZSt37IiGQtAPyaSvUavexy4ZXi2H+9nMQbcaQQM/+clHR
   V35EUWV603SOtfzVCoVM7HFULxmjYunrQXhxOLOA42eP6FQPHuBB6nG2C
   XqivOL6wgPIB7wj5xS7bAlcAqgk13BUkCt1IESu+1eqBIBJsc1+fcwYED
   qYjetLvPc9MpcG4+an5Ea1S/d/+8RypOfw5V+nl7O2TdPN3E18eQAxy1i
   8SxfAMB2W8Wd28azHSicYdR4BXzGiF0EV9QSMgHZkNZTygMJ5IPKSYWu8
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10540"; a="301767494"
X-IronPort-AV: E=Sophos;i="5.96,189,1665471600"; 
   d="scan'208";a="301767494"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2022 19:13:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10540"; a="644330914"
X-IronPort-AV: E=Sophos;i="5.96,189,1665471600"; 
   d="scan'208";a="644330914"
Received: from zxingrtx.sh.intel.com ([10.239.159.110])
  by fmsmga007.fm.intel.com with ESMTP; 23 Nov 2022 19:13:06 -0800
From:   zhengjun.xing@linux.intel.com
To:     acme@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@intel.com, jolsa@kernel.org, namhyung@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        irogers@google.com, ak@linux.intel.com, kan.liang@linux.intel.com,
        zhengjun.xing@linux.intel.com
Subject: [PATCH v3 4/4] perf vendor events intel: Update events and metrics for alderlake
Date:   Thu, 24 Nov 2022 11:14:41 +0800
Message-Id: <20221124031441.110134-4-zhengjun.xing@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221124031441.110134-1-zhengjun.xing@linux.intel.com>
References: <20221124031441.110134-1-zhengjun.xing@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhengjun Xing <zhengjun.xing@linux.intel.com>

Update JSON events and metrics for alderlake to perf.

Based on ADL JSON event list v1.16:

https://github.com/intel/perfmon/tree/main/ADL/events

Generate the event list and metrics with the converter scripts:

https://github.com/intel/perfmon/pull/32

Signed-off-by: Zhengjun Xing <zhengjun.xing@linux.intel.com>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
Acked-by: Ian Rogers <irogers@google.com>
---
Change log:
  v3:
    * Adds "Acked-by" from Ian Rogers <irogers@google.com>=20=20
  v2:
    * Regenerate the event list and metrics with the new converter scripts.
      (https://github.com/intel/perfmon/pull/32)
    * Update event version for ADL in mapfile.

 .../arch/x86/alderlake/adl-metrics.json       |   73 +-
 .../pmu-events/arch/x86/alderlake/cache.json  | 1391 +++++-------
 .../arch/x86/alderlake/floating-point.json    |   91 +-
 .../arch/x86/alderlake/frontend.json          |  224 +-
 .../pmu-events/arch/x86/alderlake/memory.json |  214 +-
 .../pmu-events/arch/x86/alderlake/other.json  |  132 +-
 .../arch/x86/alderlake/pipeline.json          | 1932 ++++++-----------
 .../arch/x86/alderlake/uncore-memory.json     |  185 +-
 .../arch/x86/alderlake/uncore-other.json      |   73 +-
 .../arch/x86/alderlake/virtual-memory.json    |  223 +-
 tools/perf/pmu-events/arch/x86/mapfile.csv    |    2 +-
 11 files changed, 1687 insertions(+), 2853 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/alderlake/adl-metrics.json b/to=
ols/perf/pmu-events/arch/x86/alderlake/adl-metrics.json
index e06d26ad5138..edf440e9359a 100644
--- a/tools/perf/pmu-events/arch/x86/alderlake/adl-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/alderlake/adl-metrics.json
@@ -1287,14 +1287,14 @@
     },
     {
         "BriefDescription": "Average CPU Utilization",
-        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC / msr@tsc@",
+        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC / TSC",
         "MetricGroup": "HPC;Summary",
         "MetricName": "CPU_Utilization",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Measured Average Frequency for unhalted proce=
ssors [GHz]",
-        "MetricExpr": "Turbo_Utilization * msr@tsc@ / 1000000000 / duratio=
n_time",
+        "MetricExpr": "Turbo_Utilization * TSC / 1000000000 / duration_tim=
e",
         "MetricGroup": "Power;Summary",
         "MetricName": "Average_Frequency",
         "Unit": "cpu_core"
@@ -1337,18 +1337,25 @@
     },
     {
         "BriefDescription": "Average external Memory Bandwidth Use for rea=
ds and writes [GB / sec]",
-        "MetricExpr": "64 * (arb@event\\=3D0x81\\,umask\\=3D0x1@ + arb@eve=
nt\\=3D0x84\\,umask\\=3D0x1@) / 1000000 / duration_time / 1000",
+        "MetricExpr": "64 * (UNC_ARB_TRK_REQUESTS.ALL + UNC_ARB_COH_TRK_RE=
QUESTS.ALL) / 1000000 / duration_time / 1000",
         "MetricGroup": "HPC;Mem;MemoryBW;SoC",
         "MetricName": "DRAM_BW_Use",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Average number of parallel requests to extern=
al memory. Accounts for all requests",
-        "MetricExpr": "UNC_ARB_TRK_OCCUPANCY.ALL / arb@event\\=3D0x81\\,um=
ask\\=3D0x1@",
+        "MetricExpr": "UNC_ARB_TRK_OCCUPANCY.ALL / UNC_ARB_TRK_REQUESTS.AL=
L",
         "MetricGroup": "Mem;SoC",
         "MetricName": "MEM_Parallel_Requests",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Socket actual clocks when any core is active =
on that socket",
+        "MetricExpr": "UNC_CLOCK.SOCKET",
+        "MetricGroup": "SoC",
+        "MetricName": "Socket_CLKS",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "Instructions per Far Branch ( Far Branches ap=
ply upon transition from application to operating system, handling interrup=
ts, exceptions) [lower number means higher occurrence rate]",
         "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.FAR_BRANCH:u",
@@ -1356,6 +1363,12 @@
         "MetricName": "IpFarBranch",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Uncore frequency per die [GHZ]",
+        "MetricExpr": "Socket_CLKS / #num_dies / duration_time / 100000000=
0",
+        "MetricGroup": "SoC",
+        "MetricName": "UNCORE_FREQ"
+    },
     {
         "BriefDescription": "Counts the number of issue slots  that were n=
ot consumed by the backend due to frontend stalls.",
         "MetricExpr": "TOPDOWN_FE_BOUND.ALL / SLOTS",
@@ -1902,7 +1915,7 @@
     },
     {
         "BriefDescription": "Average CPU Utilization",
-        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC / msr@tsc@",
+        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC / TSC",
         "MetricName": "CPU_Utilization",
         "Unit": "cpu_atom"
     },
@@ -1950,62 +1963,72 @@
     },
     {
         "BriefDescription": "C1 residency percent per core",
-        "MetricExpr": "(cstate_core@c1\\-residency@ / msr@tsc@) * 100",
+        "MetricExpr": "cstate_core@c1\\-residency@ / TSC",
         "MetricGroup": "Power",
-        "MetricName": "C1_Core_Residency"
+        "MetricName": "C1_Core_Residency",
+        "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "C6 residency percent per core",
-        "MetricExpr": "(cstate_core@c6\\-residency@ / msr@tsc@) * 100",
+        "MetricExpr": "cstate_core@c6\\-residency@ / TSC",
         "MetricGroup": "Power",
-        "MetricName": "C6_Core_Residency"
+        "MetricName": "C6_Core_Residency",
+        "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "C7 residency percent per core",
-        "MetricExpr": "(cstate_core@c7\\-residency@ / msr@tsc@) * 100",
+        "MetricExpr": "cstate_core@c7\\-residency@ / TSC",
         "MetricGroup": "Power",
-        "MetricName": "C7_Core_Residency"
+        "MetricName": "C7_Core_Residency",
+        "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "C2 residency percent per package",
-        "MetricExpr": "(cstate_pkg@c2\\-residency@ / msr@tsc@) * 100",
+        "MetricExpr": "cstate_pkg@c2\\-residency@ / TSC",
         "MetricGroup": "Power",
-        "MetricName": "C2_Pkg_Residency"
+        "MetricName": "C2_Pkg_Residency",
+        "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "C3 residency percent per package",
-        "MetricExpr": "(cstate_pkg@c3\\-residency@ / msr@tsc@) * 100",
+        "MetricExpr": "cstate_pkg@c3\\-residency@ / TSC",
         "MetricGroup": "Power",
-        "MetricName": "C3_Pkg_Residency"
+        "MetricName": "C3_Pkg_Residency",
+        "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "C6 residency percent per package",
-        "MetricExpr": "(cstate_pkg@c6\\-residency@ / msr@tsc@) * 100",
+        "MetricExpr": "cstate_pkg@c6\\-residency@ / TSC",
         "MetricGroup": "Power",
-        "MetricName": "C6_Pkg_Residency"
+        "MetricName": "C6_Pkg_Residency",
+        "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "C7 residency percent per package",
-        "MetricExpr": "(cstate_pkg@c7\\-residency@ / msr@tsc@) * 100",
+        "MetricExpr": "cstate_pkg@c7\\-residency@ / TSC",
         "MetricGroup": "Power",
-        "MetricName": "C7_Pkg_Residency"
+        "MetricName": "C7_Pkg_Residency",
+        "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "C8 residency percent per package",
-        "MetricExpr": "(cstate_pkg@c8\\-residency@ / msr@tsc@) * 100",
+        "MetricExpr": "cstate_pkg@c8\\-residency@ / TSC",
         "MetricGroup": "Power",
-        "MetricName": "C8_Pkg_Residency"
+        "MetricName": "C8_Pkg_Residency",
+        "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "C9 residency percent per package",
-        "MetricExpr": "(cstate_pkg@c9\\-residency@ / msr@tsc@) * 100",
+        "MetricExpr": "cstate_pkg@c9\\-residency@ / TSC",
         "MetricGroup": "Power",
-        "MetricName": "C9_Pkg_Residency"
+        "MetricName": "C9_Pkg_Residency",
+        "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "C10 residency percent per package",
-        "MetricExpr": "(cstate_pkg@c10\\-residency@ / msr@tsc@) * 100",
+        "MetricExpr": "cstate_pkg@c10\\-residency@ / TSC",
         "MetricGroup": "Power",
-        "MetricName": "C10_Pkg_Residency"
+        "MetricName": "C10_Pkg_Residency",
+        "ScaleUnit": "100%"
     }
 ]
diff --git a/tools/perf/pmu-events/arch/x86/alderlake/cache.json b/tools/pe=
rf/pmu-events/arch/x86/alderlake/cache.json
index 2cc62d2779d2..adc9887b8ae0 100644
--- a/tools/perf/pmu-events/arch/x86/alderlake/cache.json
+++ b/tools/perf/pmu-events/arch/x86/alderlake/cache.json
@@ -1,1178 +1,871 @@
 [
-    {
-        "BriefDescription": "Counts the number of cacheable memory request=
s that miss in the LLC. Counts on a per core basis.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5",
-        "EventCode": "0x2e",
-        "EventName": "LONGEST_LAT_CACHE.MISS",
-        "PEBScounters": "0,1,2,3,4,5",
-        "SampleAfterValue": "200003",
-        "Speculative": "1",
-        "UMask": "0x41",
-        "Unit": "cpu_atom"
-    },
-    {
-        "BriefDescription": "Counts the number of cacheable memory request=
s that access the LLC. Counts on a per core basis.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5",
-        "EventCode": "0x2e",
-        "EventName": "LONGEST_LAT_CACHE.REFERENCE",
-        "PEBScounters": "0,1,2,3,4,5",
-        "SampleAfterValue": "200003",
-        "Speculative": "1",
-        "UMask": "0x4f",
-        "Unit": "cpu_atom"
-    },
-    {
-        "BriefDescription": "Counts the number of cycles the core is stall=
ed due to an instruction cache or TLB miss which hit in the L2, LLC, DRAM o=
r MMIO (Non-DRAM).",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5",
-        "EventCode": "0x34",
-        "EventName": "MEM_BOUND_STALLS.IFETCH",
-        "PEBScounters": "0,1,2,3,4,5",
-        "SampleAfterValue": "200003",
-        "Speculative": "1",
-        "UMask": "0x38",
-        "Unit": "cpu_atom"
-    },
-    {
-        "BriefDescription": "Counts the number of cycles the core is stall=
ed due to an instruction cache or TLB miss which hit in DRAM or MMIO (Non-D=
RAM).",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5",
-        "EventCode": "0x34",
-        "EventName": "MEM_BOUND_STALLS.IFETCH_DRAM_HIT",
-        "PEBScounters": "0,1,2,3,4,5",
-        "SampleAfterValue": "200003",
-        "Speculative": "1",
-        "UMask": "0x20",
-        "Unit": "cpu_atom"
-    },
-    {
-        "BriefDescription": "Counts the number of cycles the core is stall=
ed due to an instruction cache or TLB miss which hit in the L2 cache.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5",
-        "EventCode": "0x34",
-        "EventName": "MEM_BOUND_STALLS.IFETCH_L2_HIT",
-        "PEBScounters": "0,1,2,3,4,5",
-        "SampleAfterValue": "200003",
-        "Speculative": "1",
-        "UMask": "0x8",
-        "Unit": "cpu_atom"
-    },
-    {
-        "BriefDescription": "Counts the number of cycles the core is stall=
ed due to an instruction cache or TLB miss which hit in the LLC or other co=
re with HITE/F/M.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5",
-        "EventCode": "0x34",
-        "EventName": "MEM_BOUND_STALLS.IFETCH_LLC_HIT",
-        "PEBScounters": "0,1,2,3,4,5",
-        "SampleAfterValue": "200003",
-        "Speculative": "1",
-        "UMask": "0x10",
-        "Unit": "cpu_atom"
-    },
-    {
-        "BriefDescription": "Counts the number of cycles the core is stall=
ed due to a demand load miss which hit in the L2, LLC, DRAM or MMIO (Non-DR=
AM).",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5",
-        "EventCode": "0x34",
-        "EventName": "MEM_BOUND_STALLS.LOAD",
-        "PEBScounters": "0,1,2,3,4,5",
-        "SampleAfterValue": "200003",
-        "Speculative": "1",
-        "UMask": "0x7",
-        "Unit": "cpu_atom"
-    },
-    {
-        "BriefDescription": "Counts the number of cycles the core is stall=
ed due to a demand load miss which hit in DRAM or MMIO (Non-DRAM).",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5",
-        "EventCode": "0x34",
-        "EventName": "MEM_BOUND_STALLS.LOAD_DRAM_HIT",
-        "PEBScounters": "0,1,2,3,4,5",
-        "SampleAfterValue": "200003",
-        "Speculative": "1",
-        "UMask": "0x4",
-        "Unit": "cpu_atom"
-    },
-    {
-        "BriefDescription": "Counts the number of cycles the core is stall=
ed due to a demand load which hit in the L2 cache.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5",
-        "EventCode": "0x34",
-        "EventName": "MEM_BOUND_STALLS.LOAD_L2_HIT",
-        "PEBScounters": "0,1,2,3,4,5",
-        "SampleAfterValue": "200003",
-        "Speculative": "1",
-        "UMask": "0x1",
-        "Unit": "cpu_atom"
-    },
-    {
-        "BriefDescription": "Counts the number of cycles the core is stall=
ed due to a demand load which hit in the LLC or other core with HITE/F/M.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5",
-        "EventCode": "0x34",
-        "EventName": "MEM_BOUND_STALLS.LOAD_LLC_HIT",
-        "PEBScounters": "0,1,2,3,4,5",
-        "SampleAfterValue": "200003",
-        "Speculative": "1",
-        "UMask": "0x2",
-        "Unit": "cpu_atom"
-    },
-    {
-        "BriefDescription": "Counts the number of load uops retired that h=
it in DRAM.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5",
-        "Data_LA": "1",
-        "EventCode": "0xd1",
-        "EventName": "MEM_LOAD_UOPS_RETIRED.DRAM_HIT",
-        "PEBS": "1",
-        "PEBScounters": "0,1,2,3,4,5",
-        "SampleAfterValue": "200003",
-        "UMask": "0x80",
-        "Unit": "cpu_atom"
-    },
-    {
-        "BriefDescription": "Counts the number of load uops retired that h=
it in the L2 cache.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5",
-        "Data_LA": "1",
-        "EventCode": "0xd1",
-        "EventName": "MEM_LOAD_UOPS_RETIRED.L2_HIT",
-        "PEBS": "1",
-        "PEBScounters": "0,1,2,3,4,5",
-        "SampleAfterValue": "200003",
-        "UMask": "0x2",
-        "Unit": "cpu_atom"
-    },
-    {
-        "BriefDescription": "Counts the number of load uops retired that h=
it in the L3 cache.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5",
-        "Data_LA": "1",
-        "EventCode": "0xd1",
-        "EventName": "MEM_LOAD_UOPS_RETIRED.L3_HIT",
-        "PEBS": "1",
-        "PEBScounters": "0,1,2,3,4,5",
-        "SampleAfterValue": "200003",
-        "UMask": "0x4",
-        "Unit": "cpu_atom"
-    },
-    {
-        "BriefDescription": "Counts the number of cycles that uops are blo=
cked for any of the following reasons:  load buffer, store buffer or RSV fu=
ll.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5",
-        "EventCode": "0x04",
-        "EventName": "MEM_SCHEDULER_BLOCK.ALL",
-        "PEBScounters": "0,1,2,3,4,5",
-        "SampleAfterValue": "20003",
-        "Speculative": "1",
-        "UMask": "0x7",
-        "Unit": "cpu_atom"
-    },
-    {
-        "BriefDescription": "Counts the number of cycles that uops are blo=
cked due to a load buffer full condition.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5",
-        "EventCode": "0x04",
-        "EventName": "MEM_SCHEDULER_BLOCK.LD_BUF",
-        "PEBScounters": "0,1,2,3,4,5",
-        "SampleAfterValue": "20003",
-        "Speculative": "1",
-        "UMask": "0x2",
-        "Unit": "cpu_atom"
-    },
-    {
-        "BriefDescription": "Counts the number of cycles that uops are blo=
cked due to an RSV full condition.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5",
-        "EventCode": "0x04",
-        "EventName": "MEM_SCHEDULER_BLOCK.RSV",
-        "PEBScounters": "0,1,2,3,4,5",
-        "SampleAfterValue": "20003",
-        "Speculative": "1",
-        "UMask": "0x4",
-        "Unit": "cpu_atom"
-    },
-    {
-        "BriefDescription": "Counts the number of cycles that uops are blo=
cked due to a store buffer full condition.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5",
-        "EventCode": "0x04",
-        "EventName": "MEM_SCHEDULER_BLOCK.ST_BUF",
-        "PEBScounters": "0,1,2,3,4,5",
-        "SampleAfterValue": "20003",
-        "Speculative": "1",
-        "UMask": "0x1",
-        "Unit": "cpu_atom"
-    },
-    {
-        "BriefDescription": "Counts the number of load uops retired.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5",
-        "Data_LA": "1",
-        "EventCode": "0xd0",
-        "EventName": "MEM_UOPS_RETIRED.ALL_LOADS",
-        "PEBS": "1",
-        "PEBScounters": "0,1,2,3,4,5",
-        "SampleAfterValue": "200003",
-        "UMask": "0x81",
-        "Unit": "cpu_atom"
-    },
-    {
-        "BriefDescription": "Counts the number of store uops retired.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5",
-        "Data_LA": "1",
-        "EventCode": "0xd0",
-        "EventName": "MEM_UOPS_RETIRED.ALL_STORES",
-        "PEBS": "1",
-        "PEBScounters": "0,1,2,3,4,5",
-        "SampleAfterValue": "200003",
-        "UMask": "0x82",
-        "Unit": "cpu_atom"
-    },
-    {
-        "BriefDescription": "Counts the number of tagged loads with an ins=
truction latency that exceeds or equals the threshold of 128 cycles as defi=
ned in MEC_CR_PEBS_LD_LAT_THRESHOLD (3F6H). Only counts with PEBS enabled.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1",
-        "Data_LA": "1",
-        "EventCode": "0xd0",
-        "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_128",
-        "L1_Hit_Indication": "1",
-        "MSRIndex": "0x3F6",
-        "MSRValue": "0x80",
-        "PEBS": "2",
-        "PEBScounters": "0,1",
-        "SampleAfterValue": "1000003",
-        "TakenAlone": "1",
-        "UMask": "0x5",
-        "Unit": "cpu_atom"
-    },
-    {
-        "BriefDescription": "Counts the number of tagged loads with an ins=
truction latency that exceeds or equals the threshold of 16 cycles as defin=
ed in MEC_CR_PEBS_LD_LAT_THRESHOLD (3F6H). Only counts with PEBS enabled.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1",
-        "Data_LA": "1",
-        "EventCode": "0xd0",
-        "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_16",
-        "L1_Hit_Indication": "1",
-        "MSRIndex": "0x3F6",
-        "MSRValue": "0x10",
-        "PEBS": "2",
-        "PEBScounters": "0,1",
-        "SampleAfterValue": "1000003",
-        "TakenAlone": "1",
-        "UMask": "0x5",
-        "Unit": "cpu_atom"
-    },
-    {
-        "BriefDescription": "Counts the number of tagged loads with an ins=
truction latency that exceeds or equals the threshold of 256 cycles as defi=
ned in MEC_CR_PEBS_LD_LAT_THRESHOLD (3F6H). Only counts with PEBS enabled.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1",
-        "Data_LA": "1",
-        "EventCode": "0xd0",
-        "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_256",
-        "L1_Hit_Indication": "1",
-        "MSRIndex": "0x3F6",
-        "MSRValue": "0x100",
-        "PEBS": "2",
-        "PEBScounters": "0,1",
-        "SampleAfterValue": "1000003",
-        "TakenAlone": "1",
-        "UMask": "0x5",
-        "Unit": "cpu_atom"
-    },
-    {
-        "BriefDescription": "Counts the number of tagged loads with an ins=
truction latency that exceeds or equals the threshold of 32 cycles as defin=
ed in MEC_CR_PEBS_LD_LAT_THRESHOLD (3F6H). Only counts with PEBS enabled.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1",
-        "Data_LA": "1",
-        "EventCode": "0xd0",
-        "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_32",
-        "L1_Hit_Indication": "1",
-        "MSRIndex": "0x3F6",
-        "MSRValue": "0x20",
-        "PEBS": "2",
-        "PEBScounters": "0,1",
-        "SampleAfterValue": "1000003",
-        "TakenAlone": "1",
-        "UMask": "0x5",
-        "Unit": "cpu_atom"
-    },
-    {
-        "BriefDescription": "Counts the number of tagged loads with an ins=
truction latency that exceeds or equals the threshold of 4 cycles as define=
d in MEC_CR_PEBS_LD_LAT_THRESHOLD (3F6H). Only counts with PEBS enabled.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1",
-        "Data_LA": "1",
-        "EventCode": "0xd0",
-        "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_4",
-        "L1_Hit_Indication": "1",
-        "MSRIndex": "0x3F6",
-        "MSRValue": "0x4",
-        "PEBS": "2",
-        "PEBScounters": "0,1",
-        "SampleAfterValue": "1000003",
-        "TakenAlone": "1",
-        "UMask": "0x5",
-        "Unit": "cpu_atom"
-    },
-    {
-        "BriefDescription": "Counts the number of tagged loads with an ins=
truction latency that exceeds or equals the threshold of 512 cycles as defi=
ned in MEC_CR_PEBS_LD_LAT_THRESHOLD (3F6H). Only counts with PEBS enabled.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1",
-        "Data_LA": "1",
-        "EventCode": "0xd0",
-        "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_512",
-        "L1_Hit_Indication": "1",
-        "MSRIndex": "0x3F6",
-        "MSRValue": "0x200",
-        "PEBS": "2",
-        "PEBScounters": "0,1",
-        "SampleAfterValue": "1000003",
-        "TakenAlone": "1",
-        "UMask": "0x5",
-        "Unit": "cpu_atom"
-    },
-    {
-        "BriefDescription": "Counts the number of tagged loads with an ins=
truction latency that exceeds or equals the threshold of 64 cycles as defin=
ed in MEC_CR_PEBS_LD_LAT_THRESHOLD (3F6H). Only counts with PEBS enabled.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1",
-        "Data_LA": "1",
-        "EventCode": "0xd0",
-        "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_64",
-        "L1_Hit_Indication": "1",
-        "MSRIndex": "0x3F6",
-        "MSRValue": "0x40",
-        "PEBS": "2",
-        "PEBScounters": "0,1",
-        "SampleAfterValue": "1000003",
-        "TakenAlone": "1",
-        "UMask": "0x5",
-        "Unit": "cpu_atom"
-    },
-    {
-        "BriefDescription": "Counts the number of tagged loads with an ins=
truction latency that exceeds or equals the threshold of 8 cycles as define=
d in MEC_CR_PEBS_LD_LAT_THRESHOLD (3F6H). Only counts with PEBS enabled.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1",
-        "Data_LA": "1",
-        "EventCode": "0xd0",
-        "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_8",
-        "L1_Hit_Indication": "1",
-        "MSRIndex": "0x3F6",
-        "MSRValue": "0x8",
-        "PEBS": "2",
-        "PEBScounters": "0,1",
-        "SampleAfterValue": "1000003",
-        "TakenAlone": "1",
-        "UMask": "0x5",
-        "Unit": "cpu_atom"
-    },
-    {
-        "BriefDescription": "Counts the number of retired split load uops.=
",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5",
-        "Data_LA": "1",
-        "EventCode": "0xd0",
-        "EventName": "MEM_UOPS_RETIRED.SPLIT_LOADS",
-        "PEBS": "1",
-        "PEBScounters": "0,1,2,3,4,5",
-        "SampleAfterValue": "200003",
-        "UMask": "0x41",
-        "Unit": "cpu_atom"
-    },
-    {
-        "BriefDescription": "Counts the number of stores uops retired. Cou=
nts with or without PEBS enabled.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5",
-        "Data_LA": "1",
-        "EventCode": "0xd0",
-        "EventName": "MEM_UOPS_RETIRED.STORE_LATENCY",
-        "L1_Hit_Indication": "1",
-        "PEBS": "2",
-        "PEBScounters": "0,1,2,3,4,5",
-        "SampleAfterValue": "1000003",
-        "UMask": "0x6",
-        "Unit": "cpu_atom"
-    },
-    {
-        "BriefDescription": "Counts demand data reads that were supplied b=
y the L3 cache.",
-        "Counter": "0,1,2,3,4,5",
-        "EventCode": "0xB7",
-        "EventName": "OCR.DEMAND_DATA_RD.L3_HIT",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x3F803C0001",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1",
-        "Unit": "cpu_atom"
-    },
-    {
-        "BriefDescription": "Counts demand data reads that were supplied b=
y the L3 cache where a snoop was sent, the snoop hit, and modified data was=
 forwarded.",
-        "Counter": "0,1,2,3,4,5",
-        "EventCode": "0xB7",
-        "EventName": "OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HITM",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x10003C0001",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1",
-        "Unit": "cpu_atom"
-    },
-    {
-        "BriefDescription": "Counts demand data reads that were supplied b=
y the L3 cache where a snoop was sent, the snoop hit, but no data was forwa=
rded.",
-        "Counter": "0,1,2,3,4,5",
-        "EventCode": "0xB7",
-        "EventName": "OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HIT_NO_FWD",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x4003C0001",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1",
-        "Unit": "cpu_atom"
-    },
-    {
-        "BriefDescription": "Counts demand data reads that were supplied b=
y the L3 cache where a snoop was sent, the snoop hit, and non-modified data=
 was forwarded.",
-        "Counter": "0,1,2,3,4,5",
-        "EventCode": "0xB7",
-        "EventName": "OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HIT_WITH_FWD",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x8003C0001",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1",
-        "Unit": "cpu_atom"
-    },
-    {
-        "BriefDescription": "Counts demand reads for ownership (RFO) and s=
oftware prefetches for exclusive ownership (PREFETCHW) that were supplied b=
y the L3 cache.",
-        "Counter": "0,1,2,3,4,5",
-        "EventCode": "0xB7",
-        "EventName": "OCR.DEMAND_RFO.L3_HIT",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x3F803C0002",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1",
-        "Unit": "cpu_atom"
-    },
-    {
-        "BriefDescription": "Counts demand reads for ownership (RFO) and s=
oftware prefetches for exclusive ownership (PREFETCHW) that were supplied b=
y the L3 cache where a snoop was sent, the snoop hit, and modified data was=
 forwarded.",
-        "Counter": "0,1,2,3,4,5",
-        "EventCode": "0xB7",
-        "EventName": "OCR.DEMAND_RFO.L3_HIT.SNOOP_HITM",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x10003C0002",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1",
-        "Unit": "cpu_atom"
-    },
-    {
-        "BriefDescription": "Counts the number of issue slots every cycle =
that were not delivered by the frontend due to instruction cache misses.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5",
-        "EventCode": "0x71",
-        "EventName": "TOPDOWN_FE_BOUND.ICACHE",
-        "PEBScounters": "0,1,2,3,4,5",
-        "SampleAfterValue": "1000003",
-        "Speculative": "1",
-        "UMask": "0x20",
-        "Unit": "cpu_atom"
-    },
     {
         "BriefDescription": "L1D.HWPF_MISS",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x51",
         "EventName": "L1D.HWPF_MISS",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "1000003",
-        "Speculative": "1",
         "UMask": "0x20",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Counts the number of cache lines replaced in =
L1 data cache.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x51",
         "EventName": "L1D.REPLACEMENT",
-        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts L1D data line replacements including =
opportunistic replacements, and replacements that require stall-for-replace=
 or block-for-replace.",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0x1",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Number of cycles a demand request has waited =
due to L1D Fill Buffer (FB) unavailability.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x48",
         "EventName": "L1D_PEND_MISS.FB_FULL",
-        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts number of cycles a demand request has=
 waited due to L1D Fill Buffer (FB) unavailability. Demand requests include=
 cacheable/uncacheable demand load, store, lock or SW prefetch accesses.",
         "SampleAfterValue": "1000003",
-        "Speculative": "1",
         "UMask": "0x2",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Number of phases a demand request has waited =
due to L1D Fill Buffer (FB) unavailablability.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
+        "BriefDescription": "Number of phases a demand request has waited =
due to L1D Fill Buffer (FB) unavailability.",
         "CounterMask": "1",
         "EdgeDetect": "1",
         "EventCode": "0x48",
         "EventName": "L1D_PEND_MISS.FB_FULL_PERIODS",
-        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts number of phases a demand request has=
 waited due to L1D Fill Buffer (FB) unavailability. Demand requests include=
 cacheable/uncacheable demand load, store, lock or SW prefetch accesses.",
         "SampleAfterValue": "1000003",
-        "Speculative": "1",
         "UMask": "0x2",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "This event is deprecated. Refer to new event =
L1D_PEND_MISS.L2_STALLS",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
+        "Deprecated": "1",
         "EventCode": "0x48",
         "EventName": "L1D_PEND_MISS.L2_STALL",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "1000003",
-        "Speculative": "1",
         "UMask": "0x4",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Number of cycles a demand request has waited =
due to L1D due to lack of L2 resources.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x48",
         "EventName": "L1D_PEND_MISS.L2_STALLS",
-        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts number of cycles a demand request has=
 waited due to L1D due to lack of L2 resources. Demand requests include cac=
heable/uncacheable demand load, store, lock or SW prefetch accesses.",
         "SampleAfterValue": "1000003",
-        "Speculative": "1",
         "UMask": "0x4",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Number of L1D misses that are outstanding",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x48",
         "EventName": "L1D_PEND_MISS.PENDING",
-        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts number of L1D misses that are outstan=
ding in each cycle, that is each cycle the number of Fill Buffers (FB) outs=
tanding required by Demand Reads. FB either is held by demand loads, or it =
is held by non-demand loads and gets hit at least once by demand. The valid=
 outstanding interval is defined until the FB deallocation by one of the fo=
llowing ways: from FB allocation, if FB is allocated by demand from the dem=
and Hit FB, if it is allocated by hardware or software prefetch. Note: In t=
he L1D, a Demand Read contains cacheable or noncacheable demand loads, incl=
uding ones causing cache-line splits and reads due to page walks resulted f=
rom any request type.",
         "SampleAfterValue": "1000003",
-        "Speculative": "1",
         "UMask": "0x1",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Cycles with L1D load Misses outstanding.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "CounterMask": "1",
         "EventCode": "0x48",
         "EventName": "L1D_PEND_MISS.PENDING_CYCLES",
-        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts duration of L1D miss outstanding in c=
ycles.",
         "SampleAfterValue": "1000003",
-        "Speculative": "1",
         "UMask": "0x1",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "L2 cache lines filling L2",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x25",
         "EventName": "L2_LINES_IN.ALL",
-        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts the number of L2 cache lines filling =
the L2. Counting does not cover rejects.",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0x1f",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Cache lines that have been L2 hardware prefet=
ched but not used by demand accesses",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x26",
         "EventName": "L2_LINES_OUT.USELESS_HWPF",
-        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts the number of cache lines that have b=
een prefetched by the L2 hardware prefetcher but not used by demand access =
when evicted from the L2 cache",
         "SampleAfterValue": "200003",
-        "Speculative": "1",
         "UMask": "0x4",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "All accesses to L2 cache[This event is alias =
to L2_RQSTS.REFERENCES]",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_REQUEST.ALL",
-        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts all requests that were hit or true mi=
sses in L2 cache. True-miss excludes misses that were merged with ongoing L=
2 misses.[This event is alias to L2_RQSTS.REFERENCES]",
         "SampleAfterValue": "200003",
-        "Speculative": "1",
         "UMask": "0xff",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Read requests with true-miss in L2 cache.[Thi=
s event is alias to L2_RQSTS.MISS]",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_REQUEST.MISS",
-        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts read requests of any type with true-m=
iss in the L2 cache. True-miss excludes L2 misses that were merged with ong=
oing L2 misses.[This event is alias to L2_RQSTS.MISS]",
         "SampleAfterValue": "200003",
-        "Speculative": "1",
         "UMask": "0x3f",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "L2 code requests",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.ALL_CODE_RD",
-        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts the total number of L2 code requests.=
",
         "SampleAfterValue": "200003",
-        "Speculative": "1",
         "UMask": "0xe4",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Demand Data Read access L2 cache",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.ALL_DEMAND_DATA_RD",
-        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts Demand Data Read requests accessing t=
he L2 cache. These requests may hit or miss L2 cache. True-miss exclude mis=
ses that were merged with ongoing L2 misses. An access is counted once.",
         "SampleAfterValue": "200003",
-        "Speculative": "1",
         "UMask": "0xe1",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Demand requests that miss L2 cache",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.ALL_DEMAND_MISS",
-        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts demand requests that miss L2 cache.",
         "SampleAfterValue": "200003",
-        "Speculative": "1",
         "UMask": "0x27",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "L2_RQSTS.ALL_HWPF",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.ALL_HWPF",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "200003",
-        "Speculative": "1",
         "UMask": "0xf0",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "RFO requests to L2 cache.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.ALL_RFO",
-        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts the total number of RFO (read for own=
ership) requests to L2 cache. L2 RFO requests include both L1D demand RFO m=
isses as well as L1D RFO prefetches.",
         "SampleAfterValue": "200003",
-        "Speculative": "1",
         "UMask": "0xe2",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "L2 cache hits when fetching instructions, cod=
e reads.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.CODE_RD_HIT",
-        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts L2 cache hits when fetching instructi=
ons, code reads.",
         "SampleAfterValue": "200003",
-        "Speculative": "1",
         "UMask": "0xc4",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "L2 cache misses when fetching instructions",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.CODE_RD_MISS",
-        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts L2 cache misses when fetching instruc=
tions.",
         "SampleAfterValue": "200003",
-        "Speculative": "1",
         "UMask": "0x24",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Demand Data Read requests that hit L2 cache",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.DEMAND_DATA_RD_HIT",
-        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts the number of demand Data Read reques=
ts initiated by load instructions that hit L2 cache.",
         "SampleAfterValue": "200003",
-        "Speculative": "1",
         "UMask": "0xc1",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Demand Data Read miss L2 cache",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.DEMAND_DATA_RD_MISS",
-        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts demand Data Read requests with true-m=
iss in the L2 cache. True-miss excludes misses that were merged with ongoin=
g L2 misses. An access is counted once.",
         "SampleAfterValue": "200003",
-        "Speculative": "1",
         "UMask": "0x21",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "L2_RQSTS.HWPF_MISS",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.HWPF_MISS",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "200003",
-        "Speculative": "1",
         "UMask": "0x30",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Read requests with true-miss in L2 cache.[Thi=
s event is alias to L2_REQUEST.MISS]",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.MISS",
-        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts read requests of any type with true-m=
iss in the L2 cache. True-miss excludes L2 misses that were merged with ong=
oing L2 misses.[This event is alias to L2_REQUEST.MISS]",
         "SampleAfterValue": "200003",
-        "Speculative": "1",
         "UMask": "0x3f",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "All accesses to L2 cache[This event is alias =
to L2_REQUEST.ALL]",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x24",
-        "EventName": "L2_RQSTS.REFERENCES",
-        "PEBScounters": "0,1,2,3",
+        "BriefDescription": "All accesses to L2 cache[This event is alias =
to L2_REQUEST.ALL]",
+        "EventCode": "0x24",
+        "EventName": "L2_RQSTS.REFERENCES",
+        "PublicDescription": "Counts all requests that were hit or true mi=
sses in L2 cache. True-miss excludes misses that were merged with ongoing L=
2 misses.[This event is alias to L2_REQUEST.ALL]",
+        "SampleAfterValue": "200003",
+        "UMask": "0xff",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "RFO requests that hit L2 cache.",
+        "EventCode": "0x24",
+        "EventName": "L2_RQSTS.RFO_HIT",
+        "PublicDescription": "Counts the RFO (Read-for-Ownership) requests=
 that hit L2 cache.",
+        "SampleAfterValue": "200003",
+        "UMask": "0xc2",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "RFO requests that miss L2 cache",
+        "EventCode": "0x24",
+        "EventName": "L2_RQSTS.RFO_MISS",
+        "PublicDescription": "Counts the RFO (Read-for-Ownership) requests=
 that miss L2 cache.",
+        "SampleAfterValue": "200003",
+        "UMask": "0x22",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "SW prefetch requests that hit L2 cache.",
+        "EventCode": "0x24",
+        "EventName": "L2_RQSTS.SWPF_HIT",
+        "PublicDescription": "Counts Software prefetch requests that hit t=
he L2 cache. Accounts for PREFETCHNTA and PREFETCHT0/1/2 instructions when =
FB is not full.",
+        "SampleAfterValue": "200003",
+        "UMask": "0xc8",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "SW prefetch requests that miss L2 cache.",
+        "EventCode": "0x24",
+        "EventName": "L2_RQSTS.SWPF_MISS",
+        "PublicDescription": "Counts Software prefetch requests that miss =
the L2 cache. Accounts for PREFETCHNTA and PREFETCHT0/1/2 instructions when=
 FB is not full.",
+        "SampleAfterValue": "200003",
+        "UMask": "0x28",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Counts the number of cacheable memory request=
s that miss in the LLC. Counts on a per core basis.",
+        "EventCode": "0x2e",
+        "EventName": "LONGEST_LAT_CACHE.MISS",
+        "PublicDescription": "Counts the number of cacheable memory reques=
ts that miss in the Last Level Cache (LLC). Requests include demand loads, =
reads for ownership (RFO), instruction fetches and L1 HW prefetches. If the=
 platform has an L3 cache, the LLC is the L3 cache, otherwise it is the L2 =
cache. Counts on a per core basis.",
+        "SampleAfterValue": "200003",
+        "UMask": "0x41",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Core-originated cacheable requests that misse=
d L3  (Except hardware prefetches to the L3)",
+        "EventCode": "0x2e",
+        "EventName": "LONGEST_LAT_CACHE.MISS",
+        "PublicDescription": "Counts core-originated cacheable requests th=
at miss the L3 cache (Longest Latency cache). Requests include data and cod=
e reads, Reads-for-Ownership (RFOs), speculative accesses and hardware pref=
etches to the L1 and L2.  It does not include hardware prefetches to the L3=
, and may not count other types of requests to the L3.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x41",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Counts the number of cacheable memory request=
s that access the LLC. Counts on a per core basis.",
+        "EventCode": "0x2e",
+        "EventName": "LONGEST_LAT_CACHE.REFERENCE",
+        "PublicDescription": "Counts the number of cacheable memory reques=
ts that access the Last Level Cache (LLC). Requests include demand loads, r=
eads for ownership (RFO), instruction fetches and L1 HW prefetches. If the =
platform has an L3 cache, the LLC is the L3 cache, otherwise it is the L2 c=
ache. Counts on a per core basis.",
+        "SampleAfterValue": "200003",
+        "UMask": "0x4f",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Core-originated cacheable requests that refer=
 to L3 (Except hardware prefetches to the L3)",
+        "EventCode": "0x2e",
+        "EventName": "LONGEST_LAT_CACHE.REFERENCE",
+        "PublicDescription": "Counts core-originated cacheable requests to=
 the L3 cache (Longest Latency cache). Requests include data and code reads=
, Reads-for-Ownership (RFOs), speculative accesses and hardware prefetches =
to the L1 and L2.  It does not include hardware prefetches to the L3, and m=
ay not count other types of requests to the L3.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x4f",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Counts the number of cycles the core is stall=
ed due to an instruction cache or TLB miss which hit in the L2, LLC, DRAM o=
r MMIO (Non-DRAM).",
+        "EventCode": "0x34",
+        "EventName": "MEM_BOUND_STALLS.IFETCH",
+        "PublicDescription": "Counts the number of cycles the core is stal=
led due to an instruction cache or translation lookaside buffer (TLB) miss =
which hit in the L2, LLC, DRAM or MMIO (Non-DRAM).",
+        "SampleAfterValue": "200003",
+        "UMask": "0x38",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of cycles the core is stall=
ed due to an instruction cache or TLB miss which hit in DRAM or MMIO (Non-D=
RAM).",
+        "EventCode": "0x34",
+        "EventName": "MEM_BOUND_STALLS.IFETCH_DRAM_HIT",
+        "PublicDescription": "Counts the number of cycles the core is stal=
led due to an instruction cache or translation lookaside buffer (TLB) miss =
which hit in DRAM or MMIO (non-DRAM).",
         "SampleAfterValue": "200003",
-        "Speculative": "1",
-        "UMask": "0xff",
-        "Unit": "cpu_core"
+        "UMask": "0x20",
+        "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "RFO requests that hit L2 cache.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x24",
-        "EventName": "L2_RQSTS.RFO_HIT",
-        "PEBScounters": "0,1,2,3",
+        "BriefDescription": "Counts the number of cycles the core is stall=
ed due to an instruction cache or TLB miss which hit in the L2 cache.",
+        "EventCode": "0x34",
+        "EventName": "MEM_BOUND_STALLS.IFETCH_L2_HIT",
+        "PublicDescription": "Counts the number of cycles the core is stal=
led due to an instruction cache or Translation Lookaside Buffer (TLB) miss =
which hit in the L2 cache.",
         "SampleAfterValue": "200003",
-        "Speculative": "1",
-        "UMask": "0xc2",
-        "Unit": "cpu_core"
+        "UMask": "0x8",
+        "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "RFO requests that miss L2 cache",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x24",
-        "EventName": "L2_RQSTS.RFO_MISS",
-        "PEBScounters": "0,1,2,3",
+        "BriefDescription": "Counts the number of cycles the core is stall=
ed due to an instruction cache or TLB miss which hit in the LLC or other co=
re with HITE/F/M.",
+        "EventCode": "0x34",
+        "EventName": "MEM_BOUND_STALLS.IFETCH_LLC_HIT",
+        "PublicDescription": "Counts the number of cycles the core is stal=
led due to an instruction cache or Translation Lookaside Buffer (TLB) miss =
which hit in the Last Level Cache (LLC) or other core with HITE/F/M.",
         "SampleAfterValue": "200003",
-        "Speculative": "1",
-        "UMask": "0x22",
-        "Unit": "cpu_core"
+        "UMask": "0x10",
+        "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "SW prefetch requests that hit L2 cache.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x24",
-        "EventName": "L2_RQSTS.SWPF_HIT",
-        "PEBScounters": "0,1,2,3",
+        "BriefDescription": "Counts the number of cycles the core is stall=
ed due to a demand load miss which hit in the L2, LLC, DRAM or MMIO (Non-DR=
AM).",
+        "EventCode": "0x34",
+        "EventName": "MEM_BOUND_STALLS.LOAD",
         "SampleAfterValue": "200003",
-        "Speculative": "1",
-        "UMask": "0xc8",
-        "Unit": "cpu_core"
+        "UMask": "0x7",
+        "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "SW prefetch requests that miss L2 cache.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x24",
-        "EventName": "L2_RQSTS.SWPF_MISS",
-        "PEBScounters": "0,1,2,3",
+        "BriefDescription": "Counts the number of cycles the core is stall=
ed due to a demand load miss which hit in DRAM or MMIO (Non-DRAM).",
+        "EventCode": "0x34",
+        "EventName": "MEM_BOUND_STALLS.LOAD_DRAM_HIT",
         "SampleAfterValue": "200003",
-        "Speculative": "1",
-        "UMask": "0x28",
-        "Unit": "cpu_core"
+        "UMask": "0x4",
+        "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Core-originated cacheable requests that misse=
d L3  (Except hardware prefetches to the L3)",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
-        "EventCode": "0x2e",
-        "EventName": "LONGEST_LAT_CACHE.MISS",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
-        "SampleAfterValue": "100003",
-        "Speculative": "1",
-        "UMask": "0x41",
-        "Unit": "cpu_core"
+        "BriefDescription": "Counts the number of cycles the core is stall=
ed due to a demand load which hit in the L2 cache.",
+        "EventCode": "0x34",
+        "EventName": "MEM_BOUND_STALLS.LOAD_L2_HIT",
+        "SampleAfterValue": "200003",
+        "UMask": "0x1",
+        "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Core-originated cacheable requests that refer=
 to L3 (Except hardware prefetches to the L3)",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
-        "EventCode": "0x2e",
-        "EventName": "LONGEST_LAT_CACHE.REFERENCE",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
-        "SampleAfterValue": "100003",
-        "Speculative": "1",
-        "UMask": "0x4f",
-        "Unit": "cpu_core"
+        "BriefDescription": "Counts the number of cycles the core is stall=
ed due to a demand load which hit in the LLC or other core with HITE/F/M.",
+        "EventCode": "0x34",
+        "EventName": "MEM_BOUND_STALLS.LOAD_LLC_HIT",
+        "PublicDescription": "Counts the number of cycles the core is stal=
led due to a demand load which hit in the Last Level Cache (LLC) or other c=
ore with HITE/F/M.",
+        "SampleAfterValue": "200003",
+        "UMask": "0x2",
+        "Unit": "cpu_atom"
     },
     {
         "BriefDescription": "Retired load instructions.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_INST_RETIRED.ALL_LOADS",
         "PEBS": "1",
-        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts all retired load instructions. This e=
vent accounts for SW prefetch instructions of PREFETCHNTA or PREFETCHT0/1/2=
 or PREFETCHW.",
         "SampleAfterValue": "1000003",
         "UMask": "0x81",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Retired store instructions.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_INST_RETIRED.ALL_STORES",
-        "L1_Hit_Indication": "1",
         "PEBS": "1",
-        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts all retired store instructions.",
         "SampleAfterValue": "1000003",
         "UMask": "0x82",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "All retired memory instructions.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_INST_RETIRED.ANY",
-        "L1_Hit_Indication": "1",
         "PEBS": "1",
-        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts all retired memory instructions - loa=
ds and stores.",
         "SampleAfterValue": "1000003",
         "UMask": "0x83",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Retired load instructions with locked access.=
",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_INST_RETIRED.LOCK_LOADS",
         "PEBS": "1",
-        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts retired load instructions with locked=
 access.",
         "SampleAfterValue": "100007",
         "UMask": "0x21",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Retired load instructions that split across a=
 cacheline boundary.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_INST_RETIRED.SPLIT_LOADS",
         "PEBS": "1",
-        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts retired load instructions that split =
across a cacheline boundary.",
         "SampleAfterValue": "100003",
         "UMask": "0x41",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Retired store instructions that split across =
a cacheline boundary.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_INST_RETIRED.SPLIT_STORES",
-        "L1_Hit_Indication": "1",
         "PEBS": "1",
-        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts retired store instructions that split=
 across a cacheline boundary.",
         "SampleAfterValue": "100003",
         "UMask": "0x42",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Retired load instructions that miss the STLB.=
",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_INST_RETIRED.STLB_MISS_LOADS",
         "PEBS": "1",
-        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Number of retired load instructions that (st=
art a) miss in the 2nd-level TLB (STLB).",
         "SampleAfterValue": "100003",
         "UMask": "0x11",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Retired store instructions that miss the STLB=
.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_INST_RETIRED.STLB_MISS_STORES",
-        "L1_Hit_Indication": "1",
         "PEBS": "1",
-        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Number of retired store instructions that (s=
tart a) miss in the 2nd-level TLB (STLB).",
         "SampleAfterValue": "100003",
         "UMask": "0x12",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Completed demand load uops that miss the L1 d=
-cache.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x43",
         "EventName": "MEM_LOAD_COMPLETED.L1_MISS_ANY",
-        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Number of completed demand load requests tha=
t missed the L1 data cache including shadow misses (FB hits, merge to an on=
going L1D miss)",
         "SampleAfterValue": "1000003",
-        "Speculative": "1",
         "UMask": "0xfd",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Retired load instructions whose data sources =
were HitM responses from shared L3",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xd2",
         "EventName": "MEM_LOAD_L3_HIT_RETIRED.XSNP_FWD",
         "PEBS": "1",
-        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts retired load instructions whose data =
sources were HitM responses from shared L3.",
         "SampleAfterValue": "20011",
         "UMask": "0x4",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Retired load instructions whose data sources =
were L3 and cross-core snoop hits in on-pkg core cache",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xd2",
         "EventName": "MEM_LOAD_L3_HIT_RETIRED.XSNP_HIT",
         "PEBS": "1",
-        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts retired load instructions whose data =
sources were L3 and cross-core snoop hits in on-pkg core cache.",
         "SampleAfterValue": "20011",
         "UMask": "0x2",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Retired load instructions whose data sources =
were HitM responses from shared L3",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xd2",
         "EventName": "MEM_LOAD_L3_HIT_RETIRED.XSNP_HITM",
         "PEBS": "1",
-        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts retired load instructions whose data =
sources were HitM responses from shared L3.",
+        "SampleAfterValue": "20011",
+        "UMask": "0x4",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Retired load instructions whose data sources =
were L3 hit and cross-core snoop missed in on-pkg core cache.",
+        "Data_LA": "1",
+        "EventCode": "0xd2",
+        "EventName": "MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS",
+        "PEBS": "1",
+        "PublicDescription": "Counts the retired load instructions whose d=
ata sources were L3 hit and cross-core snoop missed in on-pkg core cache.",
+        "SampleAfterValue": "20011",
+        "UMask": "0x1",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Retired load instructions whose data sources =
were hits in L3 without snoops required",
+        "Data_LA": "1",
+        "EventCode": "0xd2",
+        "EventName": "MEM_LOAD_L3_HIT_RETIRED.XSNP_NONE",
+        "PEBS": "1",
+        "PublicDescription": "Counts retired load instructions whose data =
sources were hits in L3 without snoops required.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x8",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Retired load instructions whose data sources =
were L3 and cross-core snoop hits in on-pkg core cache",
+        "Data_LA": "1",
+        "EventCode": "0xd2",
+        "EventName": "MEM_LOAD_L3_HIT_RETIRED.XSNP_NO_FWD",
+        "PEBS": "1",
+        "PublicDescription": "Counts retired load instructions whose data =
sources were L3 and cross-core snoop hits in on-pkg core cache.",
         "SampleAfterValue": "20011",
+        "UMask": "0x2",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Retired load instructions which data sources =
missed L3 but serviced from local dram",
+        "Data_LA": "1",
+        "EventCode": "0xd3",
+        "EventName": "MEM_LOAD_L3_MISS_RETIRED.LOCAL_DRAM",
+        "PEBS": "1",
+        "PublicDescription": "Retired load instructions which data sources=
 missed L3 but serviced from local DRAM.",
+        "SampleAfterValue": "100007",
+        "UMask": "0x1",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Retired instructions with at least 1 uncachea=
ble load or lock.",
+        "Data_LA": "1",
+        "EventCode": "0xd4",
+        "EventName": "MEM_LOAD_MISC_RETIRED.UC",
+        "PEBS": "1",
+        "PublicDescription": "Retired instructions with at least one load =
to uncacheable memory-type, or at least one cache-line split locked access =
(Bus Lock).",
+        "SampleAfterValue": "100007",
+        "UMask": "0x4",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Number of completed demand load requests that=
 missed the L1, but hit the FB(fill buffer), because a preceding miss to th=
e same cacheline initiated the line to be brought into L1, but data is not =
yet ready in L1.",
+        "Data_LA": "1",
+        "EventCode": "0xd1",
+        "EventName": "MEM_LOAD_RETIRED.FB_HIT",
+        "PEBS": "1",
+        "PublicDescription": "Counts retired load instructions with at lea=
st one uop was load missed in L1 but hit FB (Fill Buffers) due to preceding=
 miss to the same cache line with data not ready.",
+        "SampleAfterValue": "100007",
+        "UMask": "0x40",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Retired load instructions with L1 cache hits =
as data sources",
+        "Data_LA": "1",
+        "EventCode": "0xd1",
+        "EventName": "MEM_LOAD_RETIRED.L1_HIT",
+        "PEBS": "1",
+        "PublicDescription": "Counts retired load instructions with at lea=
st one uop that hit in the L1 data cache. This event includes all SW prefet=
ches and lock instructions regardless of the data source.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Retired load instructions missed L1 cache as =
data sources",
+        "Data_LA": "1",
+        "EventCode": "0xd1",
+        "EventName": "MEM_LOAD_RETIRED.L1_MISS",
+        "PEBS": "1",
+        "PublicDescription": "Counts retired load instructions with at lea=
st one uop that missed in the L1 cache.",
+        "SampleAfterValue": "200003",
+        "UMask": "0x8",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Retired load instructions with L2 cache hits =
as data sources",
+        "Data_LA": "1",
+        "EventCode": "0xd1",
+        "EventName": "MEM_LOAD_RETIRED.L2_HIT",
+        "PEBS": "1",
+        "PublicDescription": "Counts retired load instructions with L2 cac=
he hits as data sources.",
+        "SampleAfterValue": "200003",
+        "UMask": "0x2",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Retired load instructions missed L2 cache as =
data sources",
+        "Data_LA": "1",
+        "EventCode": "0xd1",
+        "EventName": "MEM_LOAD_RETIRED.L2_MISS",
+        "PEBS": "1",
+        "PublicDescription": "Counts retired load instructions missed L2 c=
ache as data sources.",
+        "SampleAfterValue": "100021",
+        "UMask": "0x10",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Retired load instructions with L3 cache hits =
as data sources",
+        "Data_LA": "1",
+        "EventCode": "0xd1",
+        "EventName": "MEM_LOAD_RETIRED.L3_HIT",
+        "PEBS": "1",
+        "PublicDescription": "Counts retired load instructions with at lea=
st one uop that hit in the L3 cache.",
+        "SampleAfterValue": "100021",
         "UMask": "0x4",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Retired load instructions whose data sources =
were L3 hit and cross-core snoop missed in on-pkg core cache.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
-        "Data_LA": "1",
-        "EventCode": "0xd2",
-        "EventName": "MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS",
-        "PEBS": "1",
-        "PEBScounters": "0,1,2,3",
-        "SampleAfterValue": "20011",
+        "BriefDescription": "Retired load instructions missed L3 cache as =
data sources",
+        "Data_LA": "1",
+        "EventCode": "0xd1",
+        "EventName": "MEM_LOAD_RETIRED.L3_MISS",
+        "PEBS": "1",
+        "PublicDescription": "Counts retired load instructions with at lea=
st one uop that missed in the L3 cache.",
+        "SampleAfterValue": "50021",
+        "UMask": "0x20",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Counts the number of load uops retired that h=
it in DRAM.",
+        "Data_LA": "1",
+        "EventCode": "0xd1",
+        "EventName": "MEM_LOAD_UOPS_RETIRED.DRAM_HIT",
+        "PEBS": "1",
+        "SampleAfterValue": "200003",
+        "UMask": "0x80",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of load uops retired that h=
it in the L2 cache.",
+        "Data_LA": "1",
+        "EventCode": "0xd1",
+        "EventName": "MEM_LOAD_UOPS_RETIRED.L2_HIT",
+        "PEBS": "1",
+        "SampleAfterValue": "200003",
+        "UMask": "0x2",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of load uops retired that h=
it in the L3 cache.",
+        "Data_LA": "1",
+        "EventCode": "0xd1",
+        "EventName": "MEM_LOAD_UOPS_RETIRED.L3_HIT",
+        "PEBS": "1",
+        "SampleAfterValue": "200003",
+        "UMask": "0x4",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of cycles that uops are blo=
cked for any of the following reasons:  load buffer, store buffer or RSV fu=
ll.",
+        "EventCode": "0x04",
+        "EventName": "MEM_SCHEDULER_BLOCK.ALL",
+        "SampleAfterValue": "20003",
+        "UMask": "0x7",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of cycles that uops are blo=
cked due to a load buffer full condition.",
+        "EventCode": "0x04",
+        "EventName": "MEM_SCHEDULER_BLOCK.LD_BUF",
+        "SampleAfterValue": "20003",
+        "UMask": "0x2",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of cycles that uops are blo=
cked due to an RSV full condition.",
+        "EventCode": "0x04",
+        "EventName": "MEM_SCHEDULER_BLOCK.RSV",
+        "SampleAfterValue": "20003",
+        "UMask": "0x4",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of cycles that uops are blo=
cked due to a store buffer full condition.",
+        "EventCode": "0x04",
+        "EventName": "MEM_SCHEDULER_BLOCK.ST_BUF",
+        "SampleAfterValue": "20003",
+        "UMask": "0x1",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "MEM_STORE_RETIRED.L2_HIT",
+        "EventCode": "0x44",
+        "EventName": "MEM_STORE_RETIRED.L2_HIT",
+        "SampleAfterValue": "200003",
         "UMask": "0x1",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Retired load instructions whose data sources =
were hits in L3 without snoops required",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
+        "BriefDescription": "Counts the number of load uops retired.",
         "Data_LA": "1",
-        "EventCode": "0xd2",
-        "EventName": "MEM_LOAD_L3_HIT_RETIRED.XSNP_NONE",
+        "EventCode": "0xd0",
+        "EventName": "MEM_UOPS_RETIRED.ALL_LOADS",
         "PEBS": "1",
-        "PEBScounters": "0,1,2,3",
-        "SampleAfterValue": "100003",
-        "UMask": "0x8",
-        "Unit": "cpu_core"
+        "PublicDescription": "Counts the total number of load uops retired=
.",
+        "SampleAfterValue": "200003",
+        "UMask": "0x81",
+        "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Retired load instructions whose data sources =
were L3 and cross-core snoop hits in on-pkg core cache",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
+        "BriefDescription": "Counts the number of store uops retired.",
         "Data_LA": "1",
-        "EventCode": "0xd2",
-        "EventName": "MEM_LOAD_L3_HIT_RETIRED.XSNP_NO_FWD",
+        "EventCode": "0xd0",
+        "EventName": "MEM_UOPS_RETIRED.ALL_STORES",
         "PEBS": "1",
-        "PEBScounters": "0,1,2,3",
-        "SampleAfterValue": "20011",
-        "UMask": "0x2",
-        "Unit": "cpu_core"
+        "PublicDescription": "Counts the total number of store uops retire=
d.",
+        "SampleAfterValue": "200003",
+        "UMask": "0x82",
+        "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Retired load instructions which data sources =
missed L3 but serviced from local dram",
-        "Counter": "0,1,2,3",
+        "BriefDescription": "Counts the number of tagged loads with an ins=
truction latency that exceeds or equals the threshold of 128 cycles as defi=
ned in MEC_CR_PEBS_LD_LAT_THRESHOLD (3F6H). Only counts with PEBS enabled.",
         "Data_LA": "1",
-        "EventCode": "0xd3",
-        "EventName": "MEM_LOAD_L3_MISS_RETIRED.LOCAL_DRAM",
-        "PEBScounters": "0,1,2,3",
-        "SampleAfterValue": "100007",
-        "UMask": "0x1",
-        "Unit": "cpu_core"
+        "EventCode": "0xd0",
+        "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_128",
+        "MSRIndex": "0x3F6",
+        "MSRValue": "0x80",
+        "PEBS": "2",
+        "PublicDescription": "Counts the number of tagged loads with an in=
struction latency that exceeds or equals the threshold of 128 cycles as def=
ined in MEC_CR_PEBS_LD_LAT_THRESHOLD (3F6H). Only counts with PEBS enabled.=
 If a PEBS record is generated, will populate the PEBS Latency and PEBS Dat=
a Source fields accordingly.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x5",
+        "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Retired instructions with at least 1 uncachea=
ble load or lock.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
+        "BriefDescription": "Counts the number of tagged loads with an ins=
truction latency that exceeds or equals the threshold of 16 cycles as defin=
ed in MEC_CR_PEBS_LD_LAT_THRESHOLD (3F6H). Only counts with PEBS enabled.",
         "Data_LA": "1",
-        "EventCode": "0xd4",
-        "EventName": "MEM_LOAD_MISC_RETIRED.UC",
-        "PEBS": "1",
-        "PEBScounters": "0,1,2,3",
-        "SampleAfterValue": "100007",
-        "UMask": "0x4",
-        "Unit": "cpu_core"
+        "EventCode": "0xd0",
+        "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_16",
+        "MSRIndex": "0x3F6",
+        "MSRValue": "0x10",
+        "PEBS": "2",
+        "PublicDescription": "Counts the number of tagged loads with an in=
struction latency that exceeds or equals the threshold of 16 cycles as defi=
ned in MEC_CR_PEBS_LD_LAT_THRESHOLD (3F6H). Only counts with PEBS enabled. =
If a PEBS record is generated, will populate the PEBS Latency and PEBS Data=
 Source fields accordingly.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x5",
+        "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Number of completed demand load requests that=
 missed the L1, but hit the FB(fill buffer), because a preceding miss to th=
e same cacheline initiated the line to be brought into L1, but data is not =
yet ready in L1.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
+        "BriefDescription": "Counts the number of tagged loads with an ins=
truction latency that exceeds or equals the threshold of 256 cycles as defi=
ned in MEC_CR_PEBS_LD_LAT_THRESHOLD (3F6H). Only counts with PEBS enabled.",
         "Data_LA": "1",
-        "EventCode": "0xd1",
-        "EventName": "MEM_LOAD_RETIRED.FB_HIT",
-        "PEBS": "1",
-        "PEBScounters": "0,1,2,3",
-        "SampleAfterValue": "100007",
-        "UMask": "0x40",
-        "Unit": "cpu_core"
+        "EventCode": "0xd0",
+        "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_256",
+        "MSRIndex": "0x3F6",
+        "MSRValue": "0x100",
+        "PEBS": "2",
+        "PublicDescription": "Counts the number of tagged loads with an in=
struction latency that exceeds or equals the threshold of 256 cycles as def=
ined in MEC_CR_PEBS_LD_LAT_THRESHOLD (3F6H). Only counts with PEBS enabled.=
 If a PEBS record is generated, will populate the PEBS Latency and PEBS Dat=
a Source fields accordingly.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x5",
+        "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Retired load instructions with L1 cache hits =
as data sources",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
+        "BriefDescription": "Counts the number of tagged loads with an ins=
truction latency that exceeds or equals the threshold of 32 cycles as defin=
ed in MEC_CR_PEBS_LD_LAT_THRESHOLD (3F6H). Only counts with PEBS enabled.",
         "Data_LA": "1",
-        "EventCode": "0xd1",
-        "EventName": "MEM_LOAD_RETIRED.L1_HIT",
-        "PEBS": "1",
-        "PEBScounters": "0,1,2,3",
+        "EventCode": "0xd0",
+        "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_32",
+        "MSRIndex": "0x3F6",
+        "MSRValue": "0x20",
+        "PEBS": "2",
+        "PublicDescription": "Counts the number of tagged loads with an in=
struction latency that exceeds or equals the threshold of 32 cycles as defi=
ned in MEC_CR_PEBS_LD_LAT_THRESHOLD (3F6H). Only counts with PEBS enabled. =
If a PEBS record is generated, will populate the PEBS Latency and PEBS Data=
 Source fields accordingly.",
         "SampleAfterValue": "1000003",
-        "UMask": "0x1",
-        "Unit": "cpu_core"
+        "UMask": "0x5",
+        "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Retired load instructions missed L1 cache as =
data sources",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
+        "BriefDescription": "Counts the number of tagged loads with an ins=
truction latency that exceeds or equals the threshold of 4 cycles as define=
d in MEC_CR_PEBS_LD_LAT_THRESHOLD (3F6H). Only counts with PEBS enabled.",
         "Data_LA": "1",
-        "EventCode": "0xd1",
-        "EventName": "MEM_LOAD_RETIRED.L1_MISS",
-        "PEBS": "1",
-        "PEBScounters": "0,1,2,3",
-        "SampleAfterValue": "200003",
-        "UMask": "0x8",
-        "Unit": "cpu_core"
+        "EventCode": "0xd0",
+        "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_4",
+        "MSRIndex": "0x3F6",
+        "MSRValue": "0x4",
+        "PEBS": "2",
+        "PublicDescription": "Counts the number of tagged loads with an in=
struction latency that exceeds or equals the threshold of 4 cycles as defin=
ed in MEC_CR_PEBS_LD_LAT_THRESHOLD (3F6H). Only counts with PEBS enabled. I=
f a PEBS record is generated, will populate the PEBS Latency and PEBS Data =
Source fields accordingly.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x5",
+        "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Retired load instructions with L2 cache hits =
as data sources",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
+        "BriefDescription": "Counts the number of tagged loads with an ins=
truction latency that exceeds or equals the threshold of 512 cycles as defi=
ned in MEC_CR_PEBS_LD_LAT_THRESHOLD (3F6H). Only counts with PEBS enabled.",
         "Data_LA": "1",
-        "EventCode": "0xd1",
-        "EventName": "MEM_LOAD_RETIRED.L2_HIT",
-        "PEBS": "1",
-        "PEBScounters": "0,1,2,3",
-        "SampleAfterValue": "200003",
-        "UMask": "0x2",
-        "Unit": "cpu_core"
+        "EventCode": "0xd0",
+        "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_512",
+        "MSRIndex": "0x3F6",
+        "MSRValue": "0x200",
+        "PEBS": "2",
+        "PublicDescription": "Counts the number of tagged loads with an in=
struction latency that exceeds or equals the threshold of 512 cycles as def=
ined in MEC_CR_PEBS_LD_LAT_THRESHOLD (3F6H). Only counts with PEBS enabled.=
 If a PEBS record is generated, will populate the PEBS Latency and PEBS Dat=
a Source fields accordingly.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x5",
+        "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Retired load instructions missed L2 cache as =
data sources",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
+        "BriefDescription": "Counts the number of tagged loads with an ins=
truction latency that exceeds or equals the threshold of 64 cycles as defin=
ed in MEC_CR_PEBS_LD_LAT_THRESHOLD (3F6H). Only counts with PEBS enabled.",
         "Data_LA": "1",
-        "EventCode": "0xd1",
-        "EventName": "MEM_LOAD_RETIRED.L2_MISS",
-        "PEBS": "1",
-        "PEBScounters": "0,1,2,3",
-        "SampleAfterValue": "100021",
-        "UMask": "0x10",
-        "Unit": "cpu_core"
+        "EventCode": "0xd0",
+        "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_64",
+        "MSRIndex": "0x3F6",
+        "MSRValue": "0x40",
+        "PEBS": "2",
+        "PublicDescription": "Counts the number of tagged loads with an in=
struction latency that exceeds or equals the threshold of 64 cycles as defi=
ned in MEC_CR_PEBS_LD_LAT_THRESHOLD (3F6H). Only counts with PEBS enabled. =
If a PEBS record is generated, will populate the PEBS Latency and PEBS Data=
 Source fields accordingly.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x5",
+        "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Retired load instructions with L3 cache hits =
as data sources",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
+        "BriefDescription": "Counts the number of tagged loads with an ins=
truction latency that exceeds or equals the threshold of 8 cycles as define=
d in MEC_CR_PEBS_LD_LAT_THRESHOLD (3F6H). Only counts with PEBS enabled.",
         "Data_LA": "1",
-        "EventCode": "0xd1",
-        "EventName": "MEM_LOAD_RETIRED.L3_HIT",
-        "PEBS": "1",
-        "PEBScounters": "0,1,2,3",
-        "SampleAfterValue": "100021",
-        "UMask": "0x4",
-        "Unit": "cpu_core"
+        "EventCode": "0xd0",
+        "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_8",
+        "MSRIndex": "0x3F6",
+        "MSRValue": "0x8",
+        "PEBS": "2",
+        "PublicDescription": "Counts the number of tagged loads with an in=
struction latency that exceeds or equals the threshold of 8 cycles as defin=
ed in MEC_CR_PEBS_LD_LAT_THRESHOLD (3F6H). Only counts with PEBS enabled. I=
f a PEBS record is generated, will populate the PEBS Latency and PEBS Data =
Source fields accordingly.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x5",
+        "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Retired load instructions missed L3 cache as =
data sources",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
+        "BriefDescription": "Counts the number of retired split load uops.=
",
         "Data_LA": "1",
-        "EventCode": "0xd1",
-        "EventName": "MEM_LOAD_RETIRED.L3_MISS",
+        "EventCode": "0xd0",
+        "EventName": "MEM_UOPS_RETIRED.SPLIT_LOADS",
         "PEBS": "1",
-        "PEBScounters": "0,1,2,3",
-        "SampleAfterValue": "50021",
-        "UMask": "0x20",
-        "Unit": "cpu_core"
+        "SampleAfterValue": "200003",
+        "UMask": "0x41",
+        "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "MEM_STORE_RETIRED.L2_HIT",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x44",
-        "EventName": "MEM_STORE_RETIRED.L2_HIT",
-        "PEBScounters": "0,1,2,3",
-        "SampleAfterValue": "200003",
-        "UMask": "0x1",
-        "Unit": "cpu_core"
+        "BriefDescription": "Counts the number of stores uops retired. Cou=
nts with or without PEBS enabled.",
+        "Data_LA": "1",
+        "EventCode": "0xd0",
+        "EventName": "MEM_UOPS_RETIRED.STORE_LATENCY",
+        "PEBS": "2",
+        "PublicDescription": "Counts the number of stores uops retired. Co=
unts with or without PEBS enabled. If PEBS is enabled and a PEBS record is =
generated, will populate PEBS Latency and PEBS Data Source fields according=
ly.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x6",
+        "Unit": "cpu_atom"
     },
     {
         "BriefDescription": "Retired memory uops for any access",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xe5",
         "EventName": "MEM_UOP_RETIRED.ANY",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Number of retired micro-operations (uops) fo=
r load or store memory accesses",
         "SampleAfterValue": "1000003",
         "UMask": "0x3",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts demand data reads that were supplied b=
y the L3 cache.",
+        "EventCode": "0xB7",
+        "EventName": "OCR.DEMAND_DATA_RD.L3_HIT",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x3F803C0001",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts demand data reads that were supplied b=
y the L3 cache where a snoop was sent, the snoop hit, and modified data was=
 forwarded.",
+        "EventCode": "0xB7",
+        "EventName": "OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HITM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x10003C0001",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Counts demand data reads that resulted in a s=
noop hit in another cores caches, data forwarding is required as the data i=
s modified.",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HITM",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1181,9 +874,28 @@
         "UMask": "0x1",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts demand data reads that were supplied b=
y the L3 cache where a snoop was sent, the snoop hit, but no data was forwa=
rded.",
+        "EventCode": "0xB7",
+        "EventName": "OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HIT_NO_FWD",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x4003C0001",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts demand data reads that were supplied b=
y the L3 cache where a snoop was sent, the snoop hit, and non-modified data=
 was forwarded.",
+        "EventCode": "0xB7",
+        "EventName": "OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HIT_WITH_FWD",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x8003C0001",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HIT_WITH_FWD",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HIT_WITH_FWD",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1192,9 +904,28 @@
         "UMask": "0x1",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts demand reads for ownership (RFO) and s=
oftware prefetches for exclusive ownership (PREFETCHW) that were supplied b=
y the L3 cache.",
+        "EventCode": "0xB7",
+        "EventName": "OCR.DEMAND_RFO.L3_HIT",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x3F803C0002",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts demand reads for ownership (RFO) and s=
oftware prefetches for exclusive ownership (PREFETCHW) that were supplied b=
y the L3 cache where a snoop was sent, the snoop hit, and modified data was=
 forwarded.",
+        "EventCode": "0xB7",
+        "EventName": "OCR.DEMAND_RFO.L3_HIT.SNOOP_HITM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x10003C0002",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Counts demand read for ownership (RFO) reques=
ts and software prefetches for exclusive ownership (PREFETCHW) that resulte=
d in a snoop hit in another cores caches, data forwarding is required as th=
e data is modified.",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.DEMAND_RFO.L3_HIT.SNOOP_HITM",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1205,139 +936,111 @@
     },
     {
         "BriefDescription": "OFFCORE_REQUESTS.ALL_REQUESTS",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x21",
         "EventName": "OFFCORE_REQUESTS.ALL_REQUESTS",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0x80",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Demand and prefetch data reads",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x21",
         "EventName": "OFFCORE_REQUESTS.DATA_RD",
-        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts the demand and prefetch data reads. A=
ll Core Data Reads include cacheable 'Demands' and L2 prefetchers (not L3 p=
refetchers). Counting also covers reads due to page walks resulted from any=
 request type.",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0x8",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Demand Data Read requests sent to uncore",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x21",
         "EventName": "OFFCORE_REQUESTS.DEMAND_DATA_RD",
-        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts the Demand Data Read requests sent to=
 uncore. Use it in conjunction with OFFCORE_REQUESTS_OUTSTANDING to determi=
ne average latency in the uncore.",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0x1",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "This event is deprecated. Refer to new event =
OFFCORE_REQUESTS_OUTSTANDING.DATA_RD",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
+        "Deprecated": "1",
         "Errata": "ADL038",
         "EventCode": "0x20",
         "EventName": "OFFCORE_REQUESTS_OUTSTANDING.ALL_DATA_RD",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "1000003",
-        "Speculative": "1",
         "UMask": "0x8",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "OFFCORE_REQUESTS_OUTSTANDING.CYCLES_WITH_DATA=
_RD",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "CounterMask": "1",
         "Errata": "ADL038",
         "EventCode": "0x20",
         "EventName": "OFFCORE_REQUESTS_OUTSTANDING.CYCLES_WITH_DATA_RD",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "1000003",
-        "Speculative": "1",
         "UMask": "0x8",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "For every cycle where the core is waiting on =
at least 1 outstanding Demand RFO request, increments by 1.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "CounterMask": "1",
         "EventCode": "0x20",
         "EventName": "OFFCORE_REQUESTS_OUTSTANDING.CYCLES_WITH_DEMAND_RFO",
-        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "OFFCORE_REQUESTS_OUTSTANDING.CYCLES_WITH_DEM=
AND_RFO",
         "SampleAfterValue": "1000003",
-        "Speculative": "1",
         "UMask": "0x4",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "OFFCORE_REQUESTS_OUTSTANDING.DATA_RD",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "Errata": "ADL038",
         "EventCode": "0x20",
         "EventName": "OFFCORE_REQUESTS_OUTSTANDING.DATA_RD",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "1000003",
-        "Speculative": "1",
         "UMask": "0x8",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Number of PREFETCHNTA instructions executed.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x40",
         "EventName": "SW_PREFETCH_ACCESS.NTA",
-        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts the number of PREFETCHNTA instruction=
s executed.",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0x1",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Number of PREFETCHW instructions executed.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x40",
         "EventName": "SW_PREFETCH_ACCESS.PREFETCHW",
-        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts the number of PREFETCHW instructions =
executed.",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0x8",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Number of PREFETCHT0 instructions executed.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x40",
         "EventName": "SW_PREFETCH_ACCESS.T0",
-        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts the number of PREFETCHT0 instructions=
 executed.",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0x2",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Number of PREFETCHT1 or PREFETCHT2 instructio=
ns executed.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x40",
         "EventName": "SW_PREFETCH_ACCESS.T1_T2",
-        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts the number of PREFETCHT1 or PREFETCHT=
2 instructions executed.",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0x4",
         "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Counts the number of issue slots every cycle =
that were not delivered by the frontend due to instruction cache misses.",
+        "EventCode": "0x71",
+        "EventName": "TOPDOWN_FE_BOUND.ICACHE",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x20",
+        "Unit": "cpu_atom"
     }
 ]
diff --git a/tools/perf/pmu-events/arch/x86/alderlake/floating-point.json b=
/tools/perf/pmu-events/arch/x86/alderlake/floating-point.json
index 48a4605fc057..3eb7cab9b431 100644
--- a/tools/perf/pmu-events/arch/x86/alderlake/floating-point.json
+++ b/tools/perf/pmu-events/arch/x86/alderlake/floating-point.json
@@ -1,165 +1,124 @@
 [
-    {
-        "BriefDescription": "Counts the number of floating point operation=
s retired that required microcode assist.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5",
-        "EventCode": "0xc3",
-        "EventName": "MACHINE_CLEARS.FP_ASSIST",
-        "PEBScounters": "0,1,2,3,4,5",
-        "SampleAfterValue": "20003",
-        "Speculative": "1",
-        "UMask": "0x4",
-        "Unit": "cpu_atom"
-    },
-    {
-        "BriefDescription": "Counts the number of floating point divide uo=
ps retired (x87 and SSE, including x87 sqrt).",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5",
-        "EventCode": "0xc2",
-        "EventName": "UOPS_RETIRED.FPDIV",
-        "PEBS": "1",
-        "PEBScounters": "0,1,2,3,4,5",
-        "SampleAfterValue": "2000003",
-        "UMask": "0x8",
-        "Unit": "cpu_atom"
-    },
     {
         "BriefDescription": "ARITH.FPDIV_ACTIVE",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
         "EventCode": "0xb0",
         "EventName": "ARITH.FPDIV_ACTIVE",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "1000003",
-        "Speculative": "1",
         "UMask": "0x1",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Counts all microcode FP assists.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc1",
         "EventName": "ASSISTS.FP",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts all microcode Floating Point assists.=
",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0x2",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "ASSISTS.SSE_AVX_MIX",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc1",
         "EventName": "ASSISTS.SSE_AVX_MIX",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "1000003",
-        "Speculative": "1",
         "UMask": "0x10",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "FP_ARITH_DISPATCHED.PORT_0",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xb3",
         "EventName": "FP_ARITH_DISPATCHED.PORT_0",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "2000003",
-        "Speculative": "1",
         "UMask": "0x1",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "FP_ARITH_DISPATCHED.PORT_1",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xb3",
         "EventName": "FP_ARITH_DISPATCHED.PORT_1",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "2000003",
-        "Speculative": "1",
         "UMask": "0x2",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "FP_ARITH_DISPATCHED.PORT_5",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xb3",
         "EventName": "FP_ARITH_DISPATCHED.PORT_5",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "2000003",
-        "Speculative": "1",
         "UMask": "0x4",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Counts number of SSE/AVX computational 128-bi=
t packed double precision floating-point instructions retired; some instruc=
tions will count twice as noted below.  Each count represents 2 computation=
 operations, one for each element.  Applies to SSE* and AVX* packed double =
precision floating-point instructions: ADD SUB HADD HSUB SUBADD MUL DIV MIN=
 MAX SQRT DPP FM(N)ADD/SUB.  DPP and FM(N)ADD/SUB instructions count twice =
as they perform 2 calculations per element.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc7",
         "EventName": "FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Number of SSE/AVX computational 128-bit pack=
ed double precision floating-point instructions retired; some instructions =
will count twice as noted below.  Each count represents 2 computation opera=
tions, one for each element.  Applies to SSE* and AVX* packed double precis=
ion floating-point instructions: ADD SUB HADD HSUB SUBADD MUL DIV MIN MAX S=
QRT DPP FM(N)ADD/SUB.  DPP and FM(N)ADD/SUB instructions count twice as the=
y perform 2 calculations per element. The DAZ and FTZ flags in the MXCSR re=
gister need to be set when using these events.",
         "SampleAfterValue": "100003",
         "UMask": "0x4",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Number of SSE/AVX computational 128-bit packe=
d single precision floating-point instructions retired; some instructions w=
ill count twice as noted below.  Each count represents 4 computation operat=
ions, one for each element.  Applies to SSE* and AVX* packed single precisi=
on floating-point instructions: ADD SUB MUL DIV MIN MAX RCP14 RSQRT14 SQRT =
DPP FM(N)ADD/SUB.  DPP and FM(N)ADD/SUB instructions count twice as they pe=
rform 2 calculations per element.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc7",
         "EventName": "FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Number of SSE/AVX computational 128-bit pack=
ed single precision floating-point instructions retired; some instructions =
will count twice as noted below.  Each count represents 4 computation opera=
tions, one for each element.  Applies to SSE* and AVX* packed single precis=
ion floating-point instructions: ADD SUB HADD HSUB SUBADD MUL DIV MIN MAX S=
QRT RSQRT RCP DPP FM(N)ADD/SUB.  DPP and FM(N)ADD/SUB instructions count tw=
ice as they perform 2 calculations per element. The DAZ and FTZ flags in th=
e MXCSR register need to be set when using these events.",
         "SampleAfterValue": "100003",
         "UMask": "0x8",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Counts number of SSE/AVX computational 256-bi=
t packed double precision floating-point instructions retired; some instruc=
tions will count twice as noted below.  Each count represents 4 computation=
 operations, one for each element.  Applies to SSE* and AVX* packed double =
precision floating-point instructions: ADD SUB HADD HSUB SUBADD MUL DIV MIN=
 MAX SQRT FM(N)ADD/SUB.  FM(N)ADD/SUB instructions count twice as they perf=
orm 2 calculations per element.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc7",
         "EventName": "FP_ARITH_INST_RETIRED.256B_PACKED_DOUBLE",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Number of SSE/AVX computational 256-bit pack=
ed double precision floating-point instructions retired; some instructions =
will count twice as noted below.  Each count represents 4 computation opera=
tions, one for each element.  Applies to SSE* and AVX* packed double precis=
ion floating-point instructions: ADD SUB HADD HSUB SUBADD MUL DIV MIN MAX S=
QRT FM(N)ADD/SUB.  FM(N)ADD/SUB instructions count twice as they perform 2 =
calculations per element. The DAZ and FTZ flags in the MXCSR register need =
to be set when using these events.",
         "SampleAfterValue": "100003",
         "UMask": "0x10",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Counts number of SSE/AVX computational 256-bi=
t packed single precision floating-point instructions retired; some instruc=
tions will count twice as noted below.  Each count represents 8 computation=
 operations, one for each element.  Applies to SSE* and AVX* packed single =
precision floating-point instructions: ADD SUB HADD HSUB SUBADD MUL DIV MIN=
 MAX SQRT RSQRT RCP DPP FM(N)ADD/SUB.  DPP and FM(N)ADD/SUB instructions co=
unt twice as they perform 2 calculations per element.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc7",
         "EventName": "FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Number of SSE/AVX computational 256-bit pack=
ed single precision floating-point instructions retired; some instructions =
will count twice as noted below.  Each count represents 8 computation opera=
tions, one for each element.  Applies to SSE* and AVX* packed single precis=
ion floating-point instructions: ADD SUB HADD HSUB SUBADD MUL DIV MIN MAX S=
QRT RSQRT RCP DPP FM(N)ADD/SUB.  DPP and FM(N)ADD/SUB instructions count tw=
ice as they perform 2 calculations per element. The DAZ and FTZ flags in th=
e MXCSR register need to be set when using these events.",
         "SampleAfterValue": "100003",
         "UMask": "0x20",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Counts number of SSE/AVX computational scalar=
 double precision floating-point instructions retired; some instructions wi=
ll count twice as noted below.  Each count represents 1 computational opera=
tion. Applies to SSE* and AVX* scalar double precision floating-point instr=
uctions: ADD SUB MUL DIV MIN MAX SQRT FM(N)ADD/SUB.  FM(N)ADD/SUB instructi=
ons count twice as they perform 2 calculations per element.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc7",
         "EventName": "FP_ARITH_INST_RETIRED.SCALAR_DOUBLE",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Number of SSE/AVX computational scalar doubl=
e precision floating-point instructions retired; some instructions will cou=
nt twice as noted below.  Each count represents 1 computational operation. =
Applies to SSE* and AVX* scalar double precision floating-point instruction=
s: ADD SUB MUL DIV MIN MAX SQRT FM(N)ADD/SUB.  FM(N)ADD/SUB instructions co=
unt twice as they perform 2 calculations per element. The DAZ and FTZ flags=
 in the MXCSR register need to be set when using these events.",
         "SampleAfterValue": "100003",
         "UMask": "0x1",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Counts number of SSE/AVX computational scalar=
 single precision floating-point instructions retired; some instructions wi=
ll count twice as noted below.  Each count represents 1 computational opera=
tion. Applies to SSE* and AVX* scalar single precision floating-point instr=
uctions: ADD SUB MUL DIV MIN MAX SQRT RSQRT RCP FM(N)ADD/SUB.  FM(N)ADD/SUB=
 instructions count twice as they perform 2 calculations per element.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc7",
         "EventName": "FP_ARITH_INST_RETIRED.SCALAR_SINGLE",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Number of SSE/AVX computational scalar singl=
e precision floating-point instructions retired; some instructions will cou=
nt twice as noted below.  Each count represents 1 computational operation. =
Applies to SSE* and AVX* scalar single precision floating-point instruction=
s: ADD SUB MUL DIV MIN MAX SQRT RSQRT RCP FM(N)ADD/SUB.  FM(N)ADD/SUB instr=
uctions count twice as they perform 2 calculations per element. The DAZ and=
 FTZ flags in the MXCSR register need to be set when using these events.",
         "SampleAfterValue": "100003",
         "UMask": "0x2",
         "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Counts the number of floating point operation=
s retired that required microcode assist.",
+        "EventCode": "0xc3",
+        "EventName": "MACHINE_CLEARS.FP_ASSIST",
+        "PublicDescription": "Counts the number of floating point operatio=
ns retired that required microcode assist, which is not a reflection of the=
 number of FP operations, instructions or uops.",
+        "SampleAfterValue": "20003",
+        "UMask": "0x4",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of floating point divide uo=
ps retired (x87 and SSE, including x87 sqrt).",
+        "EventCode": "0xc2",
+        "EventName": "UOPS_RETIRED.FPDIV",
+        "PEBS": "1",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x8",
+        "Unit": "cpu_atom"
     }
 ]
diff --git a/tools/perf/pmu-events/arch/x86/alderlake/frontend.json b/tools=
/perf/pmu-events/arch/x86/alderlake/frontend.json
index da1a7ba0e568..250cd128b674 100644
--- a/tools/perf/pmu-events/arch/x86/alderlake/frontend.json
+++ b/tools/perf/pmu-events/arch/x86/alderlake/frontend.json
@@ -1,536 +1,416 @@
 [
     {
         "BriefDescription": "Counts the total number of BACLEARS due to al=
l branch types including conditional and unconditional jumps, returns, and =
indirect branches.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5",
         "EventCode": "0xe6",
         "EventName": "BACLEARS.ANY",
-        "PEBScounters": "0,1,2,3,4,5",
+        "PublicDescription": "Counts the total number of BACLEARS, which o=
ccur when the Branch Target Buffer (BTB) prediction or lack thereof, was co=
rrected by a later branch predictor in the frontend.  Includes BACLEARS due=
 to all branch types including conditional and unconditional jumps, returns=
, and indirect branches.",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0x1",
         "Unit": "cpu_atom"
     },
-    {
-        "BriefDescription": "Counts the number of requests to the instruct=
ion cache for one or more bytes of a cache line.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5",
-        "EventCode": "0x80",
-        "EventName": "ICACHE.ACCESSES",
-        "PEBScounters": "0,1,2,3,4,5",
-        "SampleAfterValue": "200003",
-        "Speculative": "1",
-        "UMask": "0x3",
-        "Unit": "cpu_atom"
-    },
-    {
-        "BriefDescription": "Counts the number of instruction cache misses=
.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5",
-        "EventCode": "0x80",
-        "EventName": "ICACHE.MISSES",
-        "PEBScounters": "0,1,2,3,4,5",
-        "SampleAfterValue": "200003",
-        "Speculative": "1",
-        "UMask": "0x2",
-        "Unit": "cpu_atom"
-    },
     {
         "BriefDescription": "Stalls caused by changing prefix length of th=
e instruction.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x87",
         "EventName": "DECODE.LCP",
-        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts cycles that the Instruction Length de=
coder (ILD) stalls occurred due to dynamically changing prefix length of th=
e decoded instruction (by operand size prefix instruction 0x66, address siz=
e prefix instruction 0x67 or REX.W for Intel64). Count is proportional to t=
he number of prefixes in a 16B-line. This may result in a three-cycle penal=
ty for each LCP (Length changing prefix) in a 16-byte chunk.",
         "SampleAfterValue": "500009",
-        "Speculative": "1",
         "UMask": "0x1",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Cycles the Microcode Sequencer is busy.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x87",
         "EventName": "DECODE.MS_BUSY",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "500009",
-        "Speculative": "1",
         "UMask": "0x2",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "DSB-to-MITE switch true penalty cycles.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x61",
         "EventName": "DSB2MITE_SWITCHES.PENALTY_CYCLES",
-        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Decode Stream Buffer (DSB) is a Uop-cache th=
at holds translations of previously fetched instructions that were decoded =
by the legacy x86 decode pipeline (MITE). This event counts fetch penalty c=
ycles when a transition occurs from DSB to MITE.",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0x2",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Retired Instructions who experienced DSB miss=
.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc6",
         "EventName": "FRONTEND_RETIRED.ANY_DSB_MISS",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x1",
         "PEBS": "1",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts retired Instructions that experienced=
 DSB (Decode stream buffer i.e. the decoded instruction-cache) miss.",
         "SampleAfterValue": "100007",
-        "TakenAlone": "1",
         "UMask": "0x1",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Retired Instructions who experienced a critic=
al DSB miss.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc6",
         "EventName": "FRONTEND_RETIRED.DSB_MISS",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x11",
         "PEBS": "1",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Number of retired Instructions that experien=
ced a critical DSB (Decode stream buffer i.e. the decoded instruction-cache=
) miss. Critical means stalls were exposed to the back-end as a result of t=
he DSB miss.",
         "SampleAfterValue": "100007",
-        "TakenAlone": "1",
         "UMask": "0x1",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Retired Instructions who experienced iTLB tru=
e miss.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc6",
         "EventName": "FRONTEND_RETIRED.ITLB_MISS",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x14",
         "PEBS": "1",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts retired Instructions that experienced=
 iTLB (Instruction TLB) true miss.",
         "SampleAfterValue": "100007",
-        "TakenAlone": "1",
         "UMask": "0x1",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Retired Instructions who experienced Instruct=
ion L1 Cache true miss.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc6",
         "EventName": "FRONTEND_RETIRED.L1I_MISS",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x12",
         "PEBS": "1",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts retired Instructions who experienced =
Instruction L1 Cache true miss.",
         "SampleAfterValue": "100007",
-        "TakenAlone": "1",
         "UMask": "0x1",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Retired Instructions who experienced Instruct=
ion L2 Cache true miss.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc6",
         "EventName": "FRONTEND_RETIRED.L2_MISS",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x13",
         "PEBS": "1",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts retired Instructions who experienced =
Instruction L2 Cache true miss.",
         "SampleAfterValue": "100007",
-        "TakenAlone": "1",
         "UMask": "0x1",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Retired instructions after front-end starvati=
on of at least 1 cycle",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc6",
         "EventName": "FRONTEND_RETIRED.LATENCY_GE_1",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x600106",
         "PEBS": "1",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Retired instructions that are fetched after =
an interval where the front-end delivered no uops for a period of at least =
1 cycle which was not interrupted by a back-end stall.",
         "SampleAfterValue": "100007",
-        "TakenAlone": "1",
         "UMask": "0x1",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Retired instructions that are fetched after a=
n interval where the front-end delivered no uops for a period of 128 cycles=
 which was not interrupted by a back-end stall.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc6",
         "EventName": "FRONTEND_RETIRED.LATENCY_GE_128",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x608006",
         "PEBS": "1",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts retired instructions that are fetched=
 after an interval where the front-end delivered no uops for a period of 12=
8 cycles which was not interrupted by a back-end stall.",
         "SampleAfterValue": "100007",
-        "TakenAlone": "1",
         "UMask": "0x1",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Retired instructions that are fetched after a=
n interval where the front-end delivered no uops for a period of 16 cycles =
which was not interrupted by a back-end stall.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc6",
         "EventName": "FRONTEND_RETIRED.LATENCY_GE_16",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x601006",
         "PEBS": "1",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts retired instructions that are deliver=
ed to the back-end after a front-end stall of at least 16 cycles. During th=
is period the front-end delivered no uops.",
         "SampleAfterValue": "100007",
-        "TakenAlone": "1",
         "UMask": "0x1",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Retired instructions after front-end starvati=
on of at least 2 cycles",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc6",
         "EventName": "FRONTEND_RETIRED.LATENCY_GE_2",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x600206",
         "PEBS": "1",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Retired instructions that are fetched after =
an interval where the front-end delivered no uops for a period of at least =
2 cycles which was not interrupted by a back-end stall.",
         "SampleAfterValue": "100007",
-        "TakenAlone": "1",
         "UMask": "0x1",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Retired instructions that are fetched after a=
n interval where the front-end delivered no uops for a period of 256 cycles=
 which was not interrupted by a back-end stall.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc6",
         "EventName": "FRONTEND_RETIRED.LATENCY_GE_256",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x610006",
         "PEBS": "1",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts retired instructions that are fetched=
 after an interval where the front-end delivered no uops for a period of 25=
6 cycles which was not interrupted by a back-end stall.",
         "SampleAfterValue": "100007",
-        "TakenAlone": "1",
         "UMask": "0x1",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Retired instructions that are fetched after a=
n interval where the front-end had at least 1 bubble-slot for a period of 2=
 cycles which was not interrupted by a back-end stall.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc6",
         "EventName": "FRONTEND_RETIRED.LATENCY_GE_2_BUBBLES_GE_1",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x100206",
         "PEBS": "1",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts retired instructions that are deliver=
ed to the back-end after the front-end had at least 1 bubble-slot for a per=
iod of 2 cycles. A bubble-slot is an empty issue-pipeline slot while there =
was no RAT stall.",
         "SampleAfterValue": "100007",
-        "TakenAlone": "1",
         "UMask": "0x1",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Retired instructions that are fetched after a=
n interval where the front-end delivered no uops for a period of 32 cycles =
which was not interrupted by a back-end stall.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc6",
         "EventName": "FRONTEND_RETIRED.LATENCY_GE_32",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x602006",
         "PEBS": "1",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts retired instructions that are deliver=
ed to the back-end after a front-end stall of at least 32 cycles. During th=
is period the front-end delivered no uops.",
         "SampleAfterValue": "100007",
-        "TakenAlone": "1",
         "UMask": "0x1",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Retired instructions that are fetched after a=
n interval where the front-end delivered no uops for a period of 4 cycles w=
hich was not interrupted by a back-end stall.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc6",
         "EventName": "FRONTEND_RETIRED.LATENCY_GE_4",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x600406",
         "PEBS": "1",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts retired instructions that are fetched=
 after an interval where the front-end delivered no uops for a period of 4 =
cycles which was not interrupted by a back-end stall.",
         "SampleAfterValue": "100007",
-        "TakenAlone": "1",
         "UMask": "0x1",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Retired instructions that are fetched after a=
n interval where the front-end delivered no uops for a period of 512 cycles=
 which was not interrupted by a back-end stall.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc6",
         "EventName": "FRONTEND_RETIRED.LATENCY_GE_512",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x620006",
         "PEBS": "1",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts retired instructions that are fetched=
 after an interval where the front-end delivered no uops for a period of 51=
2 cycles which was not interrupted by a back-end stall.",
         "SampleAfterValue": "100007",
-        "TakenAlone": "1",
         "UMask": "0x1",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Retired instructions that are fetched after a=
n interval where the front-end delivered no uops for a period of 64 cycles =
which was not interrupted by a back-end stall.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc6",
         "EventName": "FRONTEND_RETIRED.LATENCY_GE_64",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x604006",
         "PEBS": "1",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts retired instructions that are fetched=
 after an interval where the front-end delivered no uops for a period of 64=
 cycles which was not interrupted by a back-end stall.",
         "SampleAfterValue": "100007",
-        "TakenAlone": "1",
         "UMask": "0x1",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Retired instructions that are fetched after a=
n interval where the front-end delivered no uops for a period of 8 cycles w=
hich was not interrupted by a back-end stall.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc6",
         "EventName": "FRONTEND_RETIRED.LATENCY_GE_8",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x600806",
         "PEBS": "1",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts retired instructions that are deliver=
ed to the back-end after a front-end stall of at least 8 cycles. During thi=
s period the front-end delivered no uops.",
         "SampleAfterValue": "100007",
-        "TakenAlone": "1",
         "UMask": "0x1",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "FRONTEND_RETIRED.MS_FLOWS",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc6",
         "EventName": "FRONTEND_RETIRED.MS_FLOWS",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x8",
         "PEBS": "1",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "100007",
-        "TakenAlone": "1",
         "UMask": "0x1",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Retired Instructions who experienced STLB (2n=
d level TLB) true miss.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc6",
         "EventName": "FRONTEND_RETIRED.STLB_MISS",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x15",
         "PEBS": "1",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts retired Instructions that experienced=
 STLB (2nd level TLB) true miss.",
         "SampleAfterValue": "100007",
-        "TakenAlone": "1",
         "UMask": "0x1",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "FRONTEND_RETIRED.UNKNOWN_BRANCH",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc6",
         "EventName": "FRONTEND_RETIRED.UNKNOWN_BRANCH",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x17",
         "PEBS": "1",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "100007",
-        "TakenAlone": "1",
         "UMask": "0x1",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts the number of requests to the instruct=
ion cache for one or more bytes of a cache line.",
+        "EventCode": "0x80",
+        "EventName": "ICACHE.ACCESSES",
+        "PublicDescription": "Counts the total number of requests to the i=
nstruction cache.  The event only counts new cache line accesses, so that m=
ultiple back to back fetches to the exact same cache line or byte chunk cou=
nt as one.  Specifically, the event counts when accesses from sequential co=
de crosses the cache line boundary, or when a branch target is moved to a n=
ew line or to a non-sequential byte chunk of the same line.",
+        "SampleAfterValue": "200003",
+        "UMask": "0x3",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of instruction cache misses=
.",
+        "EventCode": "0x80",
+        "EventName": "ICACHE.MISSES",
+        "PublicDescription": "Counts the number of missed requests to the =
instruction cache.  The event only counts new cache line accesses, so that =
multiple back to back fetches to the exact same cache line and byte chunk c=
ount as one.  Specifically, the event counts when accesses from sequential =
code crosses the cache line boundary, or when a branch target is moved to a=
 new line or to a non-sequential byte chunk of the same line.",
+        "SampleAfterValue": "200003",
+        "UMask": "0x2",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Cycles where a code fetch is stalled due to L=
1 instruction cache miss.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x80",
         "EventName": "ICACHE_DATA.STALLS",
-        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts cycles where a code line fetch is sta=
lled due to an L1 instruction cache miss. The decode pipeline works at a 32=
 Byte granularity.",
         "SampleAfterValue": "500009",
-        "Speculative": "1",
         "UMask": "0x4",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Cycles where a code fetch is stalled due to L=
1 instruction cache tag miss.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x83",
         "EventName": "ICACHE_TAG.STALLS",
-        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts cycles where a code fetch is stalled =
due to L1 instruction cache tag miss.",
         "SampleAfterValue": "200003",
-        "Speculative": "1",
         "UMask": "0x4",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Cycles Decode Stream Buffer (DSB) is deliveri=
ng any Uop",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "CounterMask": "1",
         "EventCode": "0x79",
         "EventName": "IDQ.DSB_CYCLES_ANY",
-        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts the number of cycles uops were delive=
red to Instruction Decode Queue (IDQ) from the Decode Stream Buffer (DSB) p=
ath.",
         "SampleAfterValue": "2000003",
-        "Speculative": "1",
         "UMask": "0x8",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Cycles DSB is delivering optimal number of Uo=
ps",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "CounterMask": "6",
         "EventCode": "0x79",
         "EventName": "IDQ.DSB_CYCLES_OK",
-        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts the number of cycles where optimal nu=
mber of uops was delivered to the Instruction Decode Queue (IDQ) from the M=
ITE (legacy decode pipeline) path. During these cycles uops are not being d=
elivered from the Decode Stream Buffer (DSB).",
         "SampleAfterValue": "2000003",
-        "Speculative": "1",
         "UMask": "0x8",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Uops delivered to Instruction Decode Queue (I=
DQ) from the Decode Stream Buffer (DSB) path",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x79",
         "EventName": "IDQ.DSB_UOPS",
-        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts the number of uops delivered to Instr=
uction Decode Queue (IDQ) from the Decode Stream Buffer (DSB) path.",
         "SampleAfterValue": "2000003",
-        "Speculative": "1",
         "UMask": "0x8",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Cycles MITE is delivering any Uop",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "CounterMask": "1",
         "EventCode": "0x79",
         "EventName": "IDQ.MITE_CYCLES_ANY",
-        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts the number of cycles uops were delive=
red to the Instruction Decode Queue (IDQ) from the MITE (legacy decode pipe=
line) path. During these cycles uops are not being delivered from the Decod=
e Stream Buffer (DSB).",
         "SampleAfterValue": "2000003",
-        "Speculative": "1",
         "UMask": "0x4",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Cycles MITE is delivering optimal number of U=
ops",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "CounterMask": "6",
         "EventCode": "0x79",
         "EventName": "IDQ.MITE_CYCLES_OK",
-        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts the number of cycles where optimal nu=
mber of uops was delivered to the Instruction Decode Queue (IDQ) from the M=
ITE (legacy decode pipeline) path. During these cycles uops are not being d=
elivered from the Decode Stream Buffer (DSB).",
         "SampleAfterValue": "2000003",
-        "Speculative": "1",
         "UMask": "0x4",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Uops delivered to Instruction Decode Queue (I=
DQ) from MITE path",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x79",
         "EventName": "IDQ.MITE_UOPS",
-        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts the number of uops delivered to Instr=
uction Decode Queue (IDQ) from the MITE path. This also means that uops are=
 not being delivered from the Decode Stream Buffer (DSB).",
         "SampleAfterValue": "2000003",
-        "Speculative": "1",
         "UMask": "0x4",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Cycles when uops are being delivered to IDQ w=
hile MS is busy",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "CounterMask": "1",
         "EventCode": "0x79",
         "EventName": "IDQ.MS_CYCLES_ANY",
-        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts cycles during which uops are being de=
livered to Instruction Decode Queue (IDQ) while the Microcode Sequencer (MS=
) is busy. Uops maybe initiated by Decode Stream Buffer (DSB) or MITE.",
         "SampleAfterValue": "2000003",
-        "Speculative": "1",
         "UMask": "0x20",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Number of switches from DSB or MITE to the MS=
",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "CounterMask": "1",
         "EdgeDetect": "1",
         "EventCode": "0x79",
         "EventName": "IDQ.MS_SWITCHES",
-        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Number of switches from DSB (Decode Stream B=
uffer) or MITE (legacy decode pipeline) to the Microcode Sequencer.",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0x20",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Uops delivered to IDQ while MS is busy",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x79",
         "EventName": "IDQ.MS_UOPS",
-        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts the total number of uops delivered by=
 the Microcode Sequencer (MS).",
         "SampleAfterValue": "1000003",
-        "Speculative": "1",
         "UMask": "0x20",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Uops not delivered by IDQ when backend of the=
 machine is not stalled",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x9c",
         "EventName": "IDQ_UOPS_NOT_DELIVERED.CORE",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts the number of uops not delivered to b=
y the Instruction Decode Queue (IDQ) to the back-end of the pipeline when t=
here was no back-end stalls. This event counts for one SMT thread in a give=
n cycle.",
         "SampleAfterValue": "1000003",
-        "Speculative": "1",
         "UMask": "0x1",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Cycles when no uops are not delivered by the =
IDQ when backend of the machine is not stalled",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "CounterMask": "6",
         "EventCode": "0x9c",
         "EventName": "IDQ_UOPS_NOT_DELIVERED.CYCLES_0_UOPS_DELIV.CORE",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts the number of cycles when no uops wer=
e delivered by the Instruction Decode Queue (IDQ) to the back-end of the pi=
peline when there was no back-end stalls. This event counts for one SMT thr=
ead in a given cycle.",
         "SampleAfterValue": "1000003",
-        "Speculative": "1",
         "UMask": "0x1",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Cycles when optimal number of uops was delive=
red to the back-end when the back-end is not stalled",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
         "EventCode": "0x9c",
         "EventName": "IDQ_UOPS_NOT_DELIVERED.CYCLES_FE_WAS_OK",
         "Invert": "1",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts the number of cycles when the optimal=
 number of uops were delivered by the Instruction Decode Queue (IDQ) to the=
 back-end of the pipeline when there was no back-end stalls. This event cou=
nts for one SMT thread in a given cycle.",
         "SampleAfterValue": "1000003",
-        "Speculative": "1",
         "UMask": "0x1",
         "Unit": "cpu_core"
     }
diff --git a/tools/perf/pmu-events/arch/x86/alderlake/memory.json b/tools/p=
erf/pmu-events/arch/x86/alderlake/memory.json
index f894e4a0212b..7595eb4ab46f 100644
--- a/tools/perf/pmu-events/arch/x86/alderlake/memory.json
+++ b/tools/perf/pmu-events/arch/x86/alderlake/memory.json
@@ -1,339 +1,234 @@
 [
+    {
+        "BriefDescription": "Execution stalls while L3 cache miss demand l=
oad is outstanding.",
+        "CounterMask": "6",
+        "EventCode": "0xa3",
+        "EventName": "CYCLE_ACTIVITY.STALLS_L3_MISS",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x6",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "Counts the number of cycles that the head (ol=
dest load) of the load buffer is stalled due to any number of reasons, incl=
uding an L1 miss, WCB full, pagewalk, store address block or store data blo=
ck, on a load that retires.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5",
         "EventCode": "0x05",
         "EventName": "LD_HEAD.ANY_AT_RET",
-        "PEBScounters": "0,1,2,3,4,5",
         "SampleAfterValue": "1000003",
-        "Speculative": "1",
         "UMask": "0xff",
         "Unit": "cpu_atom"
     },
     {
         "BriefDescription": "Counts the number of cycles that the head (ol=
dest load) of the load buffer is stalled due to a core bound stall includin=
g a store address match, a DTLB miss or a page walk that detains the load f=
rom retiring.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5",
         "EventCode": "0x05",
         "EventName": "LD_HEAD.L1_BOUND_AT_RET",
-        "PEBScounters": "0,1,2,3,4,5",
         "SampleAfterValue": "1000003",
-        "Speculative": "1",
         "UMask": "0xf4",
         "Unit": "cpu_atom"
     },
     {
         "BriefDescription": "Counts the number of cycles that the head (ol=
dest load) of the load buffer and retirement are both stalled due to other =
block cases.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5",
         "EventCode": "0x05",
         "EventName": "LD_HEAD.OTHER_AT_RET",
-        "PEBScounters": "0,1,2,3,4,5",
+        "PublicDescription": "Counts the number of cycles that the head (o=
ldest load) of the load buffer and retirement are both stalled due to other=
 block cases such as pipeline conflicts, fences, etc.",
         "SampleAfterValue": "1000003",
-        "Speculative": "1",
         "UMask": "0xc0",
         "Unit": "cpu_atom"
     },
     {
         "BriefDescription": "Counts the number of cycles that the head (ol=
dest load) of the load buffer and retirement are both stalled due to a page=
walk.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5",
         "EventCode": "0x05",
         "EventName": "LD_HEAD.PGWALK_AT_RET",
-        "PEBScounters": "0,1,2,3,4,5",
         "SampleAfterValue": "1000003",
-        "Speculative": "1",
         "UMask": "0xa0",
         "Unit": "cpu_atom"
     },
     {
         "BriefDescription": "Counts the number of cycles that the head (ol=
dest load) of the load buffer and retirement are both stalled due to a stor=
e address match.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5",
         "EventCode": "0x05",
         "EventName": "LD_HEAD.ST_ADDR_AT_RET",
-        "PEBScounters": "0,1,2,3,4,5",
         "SampleAfterValue": "1000003",
-        "Speculative": "1",
         "UMask": "0x84",
         "Unit": "cpu_atom"
     },
     {
         "BriefDescription": "Counts the number of machine clears due to me=
mory ordering caused by a snoop from an external agent. Does not count inte=
rnally generated machine clears such as those due to memory disambiguation.=
",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5",
         "EventCode": "0xc3",
         "EventName": "MACHINE_CLEARS.MEMORY_ORDERING",
-        "PEBScounters": "0,1,2,3,4,5",
         "SampleAfterValue": "20003",
-        "Speculative": "1",
         "UMask": "0x2",
         "Unit": "cpu_atom"
     },
-    {
-        "BriefDescription": "Counts demand data reads that were not suppli=
ed by the L3 cache.",
-        "Counter": "0,1,2,3,4,5",
-        "EventCode": "0xB7",
-        "EventName": "OCR.DEMAND_DATA_RD.L3_MISS",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x3F84400001",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1",
-        "Unit": "cpu_atom"
-    },
-    {
-        "BriefDescription": "Counts demand data reads that were not suppli=
ed by the L3 cache.",
-        "Counter": "0,1,2,3,4,5",
-        "EventCode": "0xB7",
-        "EventName": "OCR.DEMAND_DATA_RD.L3_MISS_LOCAL",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x3F84400001",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1",
-        "Unit": "cpu_atom"
-    },
-    {
-        "BriefDescription": "Counts demand reads for ownership (RFO) and s=
oftware prefetches for exclusive ownership (PREFETCHW) that were not suppli=
ed by the L3 cache.",
-        "Counter": "0,1,2,3,4,5",
-        "EventCode": "0xB7",
-        "EventName": "OCR.DEMAND_RFO.L3_MISS",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x3F84400002",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1",
-        "Unit": "cpu_atom"
-    },
-    {
-        "BriefDescription": "Counts demand reads for ownership (RFO) and s=
oftware prefetches for exclusive ownership (PREFETCHW) that were not suppli=
ed by the L3 cache.",
-        "Counter": "0,1,2,3,4,5",
-        "EventCode": "0xB7",
-        "EventName": "OCR.DEMAND_RFO.L3_MISS_LOCAL",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x3F84400002",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1",
-        "Unit": "cpu_atom"
-    },
-    {
-        "BriefDescription": "Execution stalls while L3 cache miss demand l=
oad is outstanding.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
-        "CounterMask": "6",
-        "EventCode": "0xa3",
-        "EventName": "CYCLE_ACTIVITY.STALLS_L3_MISS",
-        "PEBScounters": "0,1,2,3",
-        "SampleAfterValue": "1000003",
-        "Speculative": "1",
-        "UMask": "0x6",
-        "Unit": "cpu_core"
-    },
     {
         "BriefDescription": "Number of machine clears due to memory orderi=
ng conflicts.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc3",
         "EventName": "MACHINE_CLEARS.MEMORY_ORDERING",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts the number of Machine Clears detected=
 dye to memory ordering. Memory Ordering Machine Clears may apply when a me=
mory read may not conform to the memory ordering rules of the x86 architect=
ure",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0x2",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Cycles while L1 cache miss demand load is out=
standing.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "CounterMask": "2",
         "EventCode": "0x47",
         "EventName": "MEMORY_ACTIVITY.CYCLES_L1D_MISS",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "1000003",
-        "Speculative": "1",
         "UMask": "0x2",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Execution stalls while L1 cache miss demand l=
oad is outstanding.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "CounterMask": "3",
         "EventCode": "0x47",
         "EventName": "MEMORY_ACTIVITY.STALLS_L1D_MISS",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "1000003",
-        "Speculative": "1",
         "UMask": "0x3",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "MEMORY_ACTIVITY.STALLS_L2_MISS",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "CounterMask": "5",
         "EventCode": "0x47",
         "EventName": "MEMORY_ACTIVITY.STALLS_L2_MISS",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "1000003",
-        "Speculative": "1",
         "UMask": "0x5",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "MEMORY_ACTIVITY.STALLS_L3_MISS",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "CounterMask": "9",
         "EventCode": "0x47",
         "EventName": "MEMORY_ACTIVITY.STALLS_L3_MISS",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "1000003",
-        "Speculative": "1",
         "UMask": "0x9",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Counts randomly selected loads when the laten=
cy from first dispatch to completion is greater than 128 cycles.",
-        "CollectPEBSRecord": "2",
-        "Counter": "1,2,3,4,5,6,7",
         "Data_LA": "1",
         "EventCode": "0xcd",
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_128",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x80",
         "PEBS": "2",
-        "PEBScounters": "1,2,3,4,5,6,7",
+        "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 128 cycles.  Reported=
 latency may be longer than just the memory latency.",
         "SampleAfterValue": "1009",
-        "TakenAlone": "1",
         "UMask": "0x1",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Counts randomly selected loads when the laten=
cy from first dispatch to completion is greater than 16 cycles.",
-        "CollectPEBSRecord": "2",
-        "Counter": "1,2,3,4,5,6,7",
         "Data_LA": "1",
         "EventCode": "0xcd",
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_16",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x10",
         "PEBS": "2",
-        "PEBScounters": "1,2,3,4,5,6,7",
+        "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 16 cycles.  Reported =
latency may be longer than just the memory latency.",
         "SampleAfterValue": "20011",
-        "TakenAlone": "1",
         "UMask": "0x1",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Counts randomly selected loads when the laten=
cy from first dispatch to completion is greater than 256 cycles.",
-        "CollectPEBSRecord": "2",
-        "Counter": "1,2,3,4,5,6,7",
         "Data_LA": "1",
         "EventCode": "0xcd",
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_256",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x100",
         "PEBS": "2",
-        "PEBScounters": "1,2,3,4,5,6,7",
+        "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 256 cycles.  Reported=
 latency may be longer than just the memory latency.",
         "SampleAfterValue": "503",
-        "TakenAlone": "1",
         "UMask": "0x1",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Counts randomly selected loads when the laten=
cy from first dispatch to completion is greater than 32 cycles.",
-        "CollectPEBSRecord": "2",
-        "Counter": "1,2,3,4,5,6,7",
         "Data_LA": "1",
         "EventCode": "0xcd",
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_32",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x20",
         "PEBS": "2",
-        "PEBScounters": "1,2,3,4,5,6,7",
+        "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 32 cycles.  Reported =
latency may be longer than just the memory latency.",
         "SampleAfterValue": "100007",
-        "TakenAlone": "1",
         "UMask": "0x1",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Counts randomly selected loads when the laten=
cy from first dispatch to completion is greater than 4 cycles.",
-        "CollectPEBSRecord": "2",
-        "Counter": "1,2,3,4,5,6,7",
         "Data_LA": "1",
         "EventCode": "0xcd",
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_4",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x4",
         "PEBS": "2",
-        "PEBScounters": "1,2,3,4,5,6,7",
+        "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 4 cycles.  Reported l=
atency may be longer than just the memory latency.",
         "SampleAfterValue": "100003",
-        "TakenAlone": "1",
         "UMask": "0x1",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Counts randomly selected loads when the laten=
cy from first dispatch to completion is greater than 512 cycles.",
-        "CollectPEBSRecord": "2",
-        "Counter": "1,2,3,4,5,6,7",
         "Data_LA": "1",
         "EventCode": "0xcd",
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_512",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x200",
         "PEBS": "2",
-        "PEBScounters": "1,2,3,4,5,6,7",
+        "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 512 cycles.  Reported=
 latency may be longer than just the memory latency.",
         "SampleAfterValue": "101",
-        "TakenAlone": "1",
         "UMask": "0x1",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Counts randomly selected loads when the laten=
cy from first dispatch to completion is greater than 64 cycles.",
-        "CollectPEBSRecord": "2",
-        "Counter": "1,2,3,4,5,6,7",
         "Data_LA": "1",
         "EventCode": "0xcd",
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_64",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x40",
         "PEBS": "2",
-        "PEBScounters": "1,2,3,4,5,6,7",
+        "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 64 cycles.  Reported =
latency may be longer than just the memory latency.",
         "SampleAfterValue": "2003",
-        "TakenAlone": "1",
         "UMask": "0x1",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Counts randomly selected loads when the laten=
cy from first dispatch to completion is greater than 8 cycles.",
-        "CollectPEBSRecord": "2",
-        "Counter": "1,2,3,4,5,6,7",
         "Data_LA": "1",
         "EventCode": "0xcd",
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_8",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x8",
         "PEBS": "2",
-        "PEBScounters": "1,2,3,4,5,6,7",
+        "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 8 cycles.  Reported l=
atency may be longer than just the memory latency.",
         "SampleAfterValue": "50021",
-        "TakenAlone": "1",
         "UMask": "0x1",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Retired memory store access operations. A PDi=
st event for PEBS Store Latency Facility.",
-        "CollectPEBSRecord": "2",
         "Data_LA": "1",
         "EventCode": "0xcd",
         "EventName": "MEM_TRANS_RETIRED.STORE_SAMPLE",
         "PEBS": "2",
+        "PublicDescription": "Counts Retired memory accesses with at least=
 1 store operation. This PEBS event is the precisely-distributed (PDist) tr=
igger covering all stores uops for sampling by the PEBS Store Latency Facil=
ity. The facility is described in Intel SDM Volume 3 section 19.9.8",
         "SampleAfterValue": "1000003",
         "UMask": "0x2",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Counts demand data reads that were not suppli=
ed by the L3 cache.",
-        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xB7",
+        "EventName": "OCR.DEMAND_DATA_RD.L3_MISS",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x3F84400001",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts demand data reads that were not suppli=
ed by the L3 cache.",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.DEMAND_DATA_RD.L3_MISS",
         "MSRIndex": "0x1a6,0x1a7",
@@ -342,9 +237,28 @@
         "UMask": "0x1",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts demand data reads that were not suppli=
ed by the L3 cache.",
+        "EventCode": "0xB7",
+        "EventName": "OCR.DEMAND_DATA_RD.L3_MISS_LOCAL",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x3F84400001",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts demand reads for ownership (RFO) and s=
oftware prefetches for exclusive ownership (PREFETCHW) that were not suppli=
ed by the L3 cache.",
+        "EventCode": "0xB7",
+        "EventName": "OCR.DEMAND_RFO.L3_MISS",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x3F84400002",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Counts demand read for ownership (RFO) reques=
ts and software prefetches for exclusive ownership (PREFETCHW) that were no=
t supplied by the L3 cache.",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.DEMAND_RFO.L3_MISS",
         "MSRIndex": "0x1a6,0x1a7",
@@ -352,5 +266,33 @@
         "SampleAfterValue": "100003",
         "UMask": "0x1",
         "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Counts demand reads for ownership (RFO) and s=
oftware prefetches for exclusive ownership (PREFETCHW) that were not suppli=
ed by the L3 cache.",
+        "EventCode": "0xB7",
+        "EventName": "OCR.DEMAND_RFO.L3_MISS_LOCAL",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x3F84400002",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Demand Data Read requests who miss L3 cache",
+        "EventCode": "0x21",
+        "EventName": "OFFCORE_REQUESTS.L3_MISS_DEMAND_DATA_RD",
+        "PublicDescription": "Demand Data Read requests who miss L3 cache.=
",
+        "SampleAfterValue": "100003",
+        "UMask": "0x10",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "For every cycle, increments by the number of =
demand data read requests pending that are known to have missed the L3 cach=
e.",
+        "EventCode": "0x20",
+        "EventName": "OFFCORE_REQUESTS_OUTSTANDING.L3_MISS_DEMAND_DATA_RD",
+        "PublicDescription": "For every cycle, increments by the number of=
 demand data read requests pending that are known to have missed the L3 cac=
he.  Note that this does not capture all elapsed cycles while requests are =
outstanding - only cycles from when the requests were known by the requesti=
ng core to have missed the L3 cache.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x10",
+        "Unit": "cpu_core"
     }
 ]
diff --git a/tools/perf/pmu-events/arch/x86/alderlake/other.json b/tools/pe=
rf/pmu-events/arch/x86/alderlake/other.json
index c49d8ce27310..329c611d7cf7 100644
--- a/tools/perf/pmu-events/arch/x86/alderlake/other.json
+++ b/tools/perf/pmu-events/arch/x86/alderlake/other.json
@@ -1,111 +1,66 @@
 [
-    {
-        "BriefDescription": "Counts modified writebacks from L1 cache and =
L2 cache that have any type of response.",
-        "Counter": "0,1,2,3,4,5",
-        "EventCode": "0xB7",
-        "EventName": "OCR.COREWB_M.ANY_RESPONSE",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x10008",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1",
-        "Unit": "cpu_atom"
-    },
-    {
-        "BriefDescription": "Counts demand data reads that have any type o=
f response.",
-        "Counter": "0,1,2,3,4,5",
-        "EventCode": "0xB7",
-        "EventName": "OCR.DEMAND_DATA_RD.ANY_RESPONSE",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x10001",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1",
-        "Unit": "cpu_atom"
-    },
-    {
-        "BriefDescription": "Counts demand reads for ownership (RFO) and s=
oftware prefetches for exclusive ownership (PREFETCHW) that have any type o=
f response.",
-        "Counter": "0,1,2,3,4,5",
-        "EventCode": "0xB7",
-        "EventName": "OCR.DEMAND_RFO.ANY_RESPONSE",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x10002",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1",
-        "Unit": "cpu_atom"
-    },
-    {
-        "BriefDescription": "Counts streaming stores that have any type of=
 response.",
-        "Counter": "0,1,2,3,4,5",
-        "EventCode": "0xB7",
-        "EventName": "OCR.STREAMING_WR.ANY_RESPONSE",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x10800",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1",
-        "Unit": "cpu_atom"
-    },
     {
         "BriefDescription": "ASSISTS.HARDWARE",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc1",
         "EventName": "ASSISTS.HARDWARE",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0x4",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "ASSISTS.PAGE_FAULT",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc1",
         "EventName": "ASSISTS.PAGE_FAULT",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "1000003",
-        "Speculative": "1",
         "UMask": "0x8",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "CORE_POWER.LICENSE_1",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x28",
         "EventName": "CORE_POWER.LICENSE_1",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "200003",
-        "Speculative": "1",
         "UMask": "0x2",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "CORE_POWER.LICENSE_2",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x28",
         "EventName": "CORE_POWER.LICENSE_2",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "200003",
-        "Speculative": "1",
         "UMask": "0x4",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "CORE_POWER.LICENSE_3",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x28",
         "EventName": "CORE_POWER.LICENSE_3",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "200003",
-        "Speculative": "1",
         "UMask": "0x8",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts modified writebacks from L1 cache and =
L2 cache that have any type of response.",
+        "EventCode": "0xB7",
+        "EventName": "OCR.COREWB_M.ANY_RESPONSE",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x10008",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts demand data reads that have any type o=
f response.",
+        "EventCode": "0xB7",
+        "EventName": "OCR.DEMAND_DATA_RD.ANY_RESPONSE",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x10001",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Counts demand data reads that have any type o=
f response.",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.DEMAND_DATA_RD.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -116,7 +71,6 @@
     },
     {
         "BriefDescription": "Counts demand data reads that were supplied b=
y DRAM.",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.DEMAND_DATA_RD.DRAM",
         "MSRIndex": "0x1a6,0x1a7",
@@ -125,9 +79,18 @@
         "UMask": "0x1",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts demand reads for ownership (RFO) and s=
oftware prefetches for exclusive ownership (PREFETCHW) that have any type o=
f response.",
+        "EventCode": "0xB7",
+        "EventName": "OCR.DEMAND_RFO.ANY_RESPONSE",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x10002",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Counts demand read for ownership (RFO) reques=
ts and software prefetches for exclusive ownership (PREFETCHW) that have an=
y type of response.",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.DEMAND_RFO.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -138,7 +101,16 @@
     },
     {
         "BriefDescription": "Counts streaming stores that have any type of=
 response.",
-        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xB7",
+        "EventName": "OCR.STREAMING_WR.ANY_RESPONSE",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x10800",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts streaming stores that have any type of=
 response.",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.STREAMING_WR.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -149,68 +121,52 @@
     },
     {
         "BriefDescription": "Cycles when Reservation Station (RS) is empty=
 for the thread.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xa5",
         "EventName": "RS.EMPTY",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts cycles during which the reservation s=
tation (RS) is empty for this logical processor. This is usually caused whe=
n the front-end pipeline runs into starvation periods (e.g. branch mispredi=
ctions or i-cache misses)",
         "SampleAfterValue": "1000003",
-        "Speculative": "1",
         "UMask": "0x7",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Counts end of periods where the Reservation S=
tation (RS) was empty.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
         "EdgeDetect": "1",
         "EventCode": "0xa5",
         "EventName": "RS.EMPTY_COUNT",
         "Invert": "1",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts end of periods where the Reservation =
Station (RS) was empty. Could be useful to closely sample on front-end late=
ncy issues (see the FRONTEND_RETIRED event of designated precise events)",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0x7",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "This event is deprecated. Refer to new event =
RS.EMPTY_COUNT",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
+        "Deprecated": "1",
         "EdgeDetect": "1",
         "EventCode": "0xa5",
         "EventName": "RS_EMPTY.COUNT",
         "Invert": "1",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0x7",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "This event is deprecated. Refer to new event =
RS.EMPTY",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
+        "Deprecated": "1",
         "EventCode": "0xa5",
         "EventName": "RS_EMPTY.CYCLES",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "1000003",
-        "Speculative": "1",
         "UMask": "0x7",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "XQ.FULL_CYCLES",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "CounterMask": "1",
         "EventCode": "0x2d",
         "EventName": "XQ.FULL_CYCLES",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "1000003",
-        "Speculative": "1",
         "UMask": "0x1",
         "Unit": "cpu_core"
     }
diff --git a/tools/perf/pmu-events/arch/x86/alderlake/pipeline.json b/tools=
/perf/pmu-events/arch/x86/alderlake/pipeline.json
index 1a137f7f8b7e..f46fa7ba168a 100644
--- a/tools/perf/pmu-events/arch/x86/alderlake/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/alderlake/pipeline.json
@@ -1,2168 +1,1634 @@
 [
-    {
-        "BriefDescription": "Counts the total number of branch instruction=
s retired for all branch types.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5",
-        "EventCode": "0xc4",
-        "EventName": "BR_INST_RETIRED.ALL_BRANCHES",
-        "PEBS": "1",
-        "PEBScounters": "0,1,2,3,4,5",
-        "SampleAfterValue": "200003",
-        "Unit": "cpu_atom"
-    },
-    {
-        "BriefDescription": "This event is deprecated. Refer to new event =
BR_INST_RETIRED.NEAR_CALL",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5",
-        "EventCode": "0xc4",
-        "EventName": "BR_INST_RETIRED.CALL",
-        "PEBS": "1",
-        "PEBScounters": "0,1,2,3,4,5",
-        "SampleAfterValue": "200003",
-        "UMask": "0xf9",
-        "Unit": "cpu_atom"
-    },
-    {
-        "BriefDescription": "Counts the number of retired JCC (Jump on Con=
ditional Code) branch instructions retired, includes both taken and not tak=
en branches.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5",
-        "EventCode": "0xc4",
-        "EventName": "BR_INST_RETIRED.COND",
-        "PEBS": "1",
-        "PEBScounters": "0,1,2,3,4,5",
-        "SampleAfterValue": "200003",
-        "UMask": "0x7e",
-        "Unit": "cpu_atom"
-    },
-    {
-        "BriefDescription": "Counts the number of taken JCC (Jump on Condi=
tional Code) branch instructions retired.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5",
-        "EventCode": "0xc4",
-        "EventName": "BR_INST_RETIRED.COND_TAKEN",
-        "PEBS": "1",
-        "PEBScounters": "0,1,2,3,4,5",
-        "SampleAfterValue": "200003",
-        "UMask": "0xfe",
-        "Unit": "cpu_atom"
-    },
-    {
-        "BriefDescription": "Counts the number of far branch instructions =
retired, includes far jump, far call and return, and interrupt call and ret=
urn.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5",
-        "EventCode": "0xc4",
-        "EventName": "BR_INST_RETIRED.FAR_BRANCH",
-        "PEBS": "1",
-        "PEBScounters": "0,1,2,3,4,5",
-        "SampleAfterValue": "200003",
-        "UMask": "0xbf",
-        "Unit": "cpu_atom"
-    },
-    {
-        "BriefDescription": "Counts the number of near indirect JMP and ne=
ar indirect CALL branch instructions retired.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5",
-        "EventCode": "0xc4",
-        "EventName": "BR_INST_RETIRED.INDIRECT",
-        "PEBS": "1",
-        "PEBScounters": "0,1,2,3,4,5",
-        "SampleAfterValue": "200003",
-        "UMask": "0xeb",
-        "Unit": "cpu_atom"
-    },
-    {
-        "BriefDescription": "Counts the number of near indirect CALL branc=
h instructions retired.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5",
-        "EventCode": "0xc4",
-        "EventName": "BR_INST_RETIRED.INDIRECT_CALL",
-        "PEBS": "1",
-        "PEBScounters": "0,1,2,3,4,5",
-        "SampleAfterValue": "200003",
-        "UMask": "0xfb",
-        "Unit": "cpu_atom"
-    },
-    {
-        "BriefDescription": "This event is deprecated. Refer to new event =
BR_INST_RETIRED.INDIRECT_CALL",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5",
-        "EventCode": "0xc4",
-        "EventName": "BR_INST_RETIRED.IND_CALL",
-        "PEBS": "1",
-        "PEBScounters": "0,1,2,3,4,5",
-        "SampleAfterValue": "200003",
-        "UMask": "0xfb",
-        "Unit": "cpu_atom"
-    },
-    {
-        "BriefDescription": "This event is deprecated. Refer to new event =
BR_INST_RETIRED.COND",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5",
-        "EventCode": "0xc4",
-        "EventName": "BR_INST_RETIRED.JCC",
-        "PEBS": "1",
-        "PEBScounters": "0,1,2,3,4,5",
-        "SampleAfterValue": "200003",
-        "UMask": "0x7e",
-        "Unit": "cpu_atom"
-    },
-    {
-        "BriefDescription": "Counts the number of near CALL branch instruc=
tions retired.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5",
-        "EventCode": "0xc4",
-        "EventName": "BR_INST_RETIRED.NEAR_CALL",
-        "PEBS": "1",
-        "PEBScounters": "0,1,2,3,4,5",
-        "SampleAfterValue": "200003",
-        "UMask": "0xf9",
-        "Unit": "cpu_atom"
-    },
-    {
-        "BriefDescription": "Counts the number of near RET branch instruct=
ions retired.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5",
-        "EventCode": "0xc4",
-        "EventName": "BR_INST_RETIRED.NEAR_RETURN",
-        "PEBS": "1",
-        "PEBScounters": "0,1,2,3,4,5",
-        "SampleAfterValue": "200003",
-        "UMask": "0xf7",
-        "Unit": "cpu_atom"
-    },
-    {
-        "BriefDescription": "This event is deprecated. Refer to new event =
BR_INST_RETIRED.INDIRECT",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5",
-        "EventCode": "0xc4",
-        "EventName": "BR_INST_RETIRED.NON_RETURN_IND",
-        "PEBS": "1",
-        "PEBScounters": "0,1,2,3,4,5",
-        "SampleAfterValue": "200003",
-        "UMask": "0xeb",
-        "Unit": "cpu_atom"
-    },
-    {
-        "BriefDescription": "Counts the number of near relative CALL branc=
h instructions retired.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5",
-        "EventCode": "0xc4",
-        "EventName": "BR_INST_RETIRED.REL_CALL",
-        "PEBS": "1",
-        "PEBScounters": "0,1,2,3,4,5",
-        "SampleAfterValue": "200003",
-        "UMask": "0xfd",
-        "Unit": "cpu_atom"
-    },
-    {
-        "BriefDescription": "This event is deprecated. Refer to new event =
BR_INST_RETIRED.NEAR_RETURN",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5",
-        "EventCode": "0xc4",
-        "EventName": "BR_INST_RETIRED.RETURN",
-        "PEBS": "1",
-        "PEBScounters": "0,1,2,3,4,5",
-        "SampleAfterValue": "200003",
-        "UMask": "0xf7",
-        "Unit": "cpu_atom"
-    },
-    {
-        "BriefDescription": "This event is deprecated. Refer to new event =
BR_INST_RETIRED.COND_TAKEN",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5",
-        "EventCode": "0xc4",
-        "EventName": "BR_INST_RETIRED.TAKEN_JCC",
-        "PEBS": "1",
-        "PEBScounters": "0,1,2,3,4,5",
-        "SampleAfterValue": "200003",
-        "UMask": "0xfe",
-        "Unit": "cpu_atom"
-    },
-    {
-        "BriefDescription": "Counts the total number of mispredicted branc=
h instructions retired for all branch types.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5",
-        "EventCode": "0xc5",
-        "EventName": "BR_MISP_RETIRED.ALL_BRANCHES",
-        "PEBS": "1",
-        "PEBScounters": "0,1,2,3,4,5",
-        "SampleAfterValue": "200003",
-        "Unit": "cpu_atom"
-    },
-    {
-        "BriefDescription": "Counts the number of mispredicted JCC (Jump o=
n Conditional Code) branch instructions retired.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5",
-        "EventCode": "0xc5",
-        "EventName": "BR_MISP_RETIRED.COND",
-        "PEBS": "1",
-        "PEBScounters": "0,1,2,3,4,5",
-        "SampleAfterValue": "200003",
-        "UMask": "0x7e",
-        "Unit": "cpu_atom"
-    },
-    {
-        "BriefDescription": "Counts the number of mispredicted taken JCC (=
Jump on Conditional Code) branch instructions retired.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5",
-        "EventCode": "0xc5",
-        "EventName": "BR_MISP_RETIRED.COND_TAKEN",
-        "PEBS": "1",
-        "PEBScounters": "0,1,2,3,4,5",
-        "SampleAfterValue": "200003",
-        "UMask": "0xfe",
-        "Unit": "cpu_atom"
-    },
-    {
-        "BriefDescription": "Counts the number of mispredicted near indire=
ct JMP and near indirect CALL branch instructions retired.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5",
-        "EventCode": "0xc5",
-        "EventName": "BR_MISP_RETIRED.INDIRECT",
-        "PEBS": "1",
-        "PEBScounters": "0,1,2,3,4,5",
-        "SampleAfterValue": "200003",
-        "UMask": "0xeb",
-        "Unit": "cpu_atom"
-    },
-    {
-        "BriefDescription": "Counts the number of mispredicted near indire=
ct CALL branch instructions retired.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5",
-        "EventCode": "0xc5",
-        "EventName": "BR_MISP_RETIRED.INDIRECT_CALL",
-        "PEBS": "1",
-        "PEBScounters": "0,1,2,3,4,5",
-        "SampleAfterValue": "200003",
-        "UMask": "0xfb",
-        "Unit": "cpu_atom"
-    },
-    {
-        "BriefDescription": "This event is deprecated. Refer to new event =
BR_MISP_RETIRED.INDIRECT_CALL",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5",
-        "EventCode": "0xc5",
-        "EventName": "BR_MISP_RETIRED.IND_CALL",
-        "PEBS": "1",
-        "PEBScounters": "0,1,2,3,4,5",
-        "SampleAfterValue": "200003",
-        "UMask": "0xfb",
-        "Unit": "cpu_atom"
-    },
-    {
-        "BriefDescription": "This event is deprecated. Refer to new event =
BR_MISP_RETIRED.COND",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5",
-        "EventCode": "0xc5",
-        "EventName": "BR_MISP_RETIRED.JCC",
-        "PEBS": "1",
-        "PEBScounters": "0,1,2,3,4,5",
-        "SampleAfterValue": "200003",
-        "UMask": "0x7e",
-        "Unit": "cpu_atom"
-    },
-    {
-        "BriefDescription": "This event is deprecated. Refer to new event =
BR_MISP_RETIRED.INDIRECT",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5",
-        "EventCode": "0xc5",
-        "EventName": "BR_MISP_RETIRED.NON_RETURN_IND",
-        "PEBS": "1",
-        "PEBScounters": "0,1,2,3,4,5",
-        "SampleAfterValue": "200003",
-        "UMask": "0xeb",
-        "Unit": "cpu_atom"
-    },
-    {
-        "BriefDescription": "Counts the number of mispredicted near RET br=
anch instructions retired.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5",
-        "EventCode": "0xc5",
-        "EventName": "BR_MISP_RETIRED.RETURN",
-        "PEBS": "1",
-        "PEBScounters": "0,1,2,3,4,5",
-        "SampleAfterValue": "200003",
-        "UMask": "0xf7",
-        "Unit": "cpu_atom"
-    },
-    {
-        "BriefDescription": "This event is deprecated. Refer to new event =
BR_MISP_RETIRED.COND_TAKEN",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5",
-        "EventCode": "0xc5",
-        "EventName": "BR_MISP_RETIRED.TAKEN_JCC",
-        "PEBS": "1",
-        "PEBScounters": "0,1,2,3,4,5",
-        "SampleAfterValue": "200003",
-        "UMask": "0xfe",
-        "Unit": "cpu_atom"
-    },
-    {
-        "BriefDescription": "Counts the number of unhalted core clock cycl=
es. (Fixed event)",
-        "CollectPEBSRecord": "2",
-        "Counter": "Fixed counter 1",
-        "EventName": "CPU_CLK_UNHALTED.CORE",
-        "PEBScounters": "33",
-        "SampleAfterValue": "2000003",
-        "Speculative": "1",
-        "UMask": "0x2",
-        "Unit": "cpu_atom"
-    },
-    {
-        "BriefDescription": "Counts the number of unhalted core clock cycl=
es.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5",
-        "EventCode": "0x3c",
-        "EventName": "CPU_CLK_UNHALTED.CORE_P",
-        "PEBScounters": "0,1,2,3,4,5",
-        "SampleAfterValue": "2000003",
-        "Speculative": "1",
-        "Unit": "cpu_atom"
-    },
-    {
-        "BriefDescription": "Counts the number of unhalted reference clock=
 cycles at TSC frequency. (Fixed event)",
-        "CollectPEBSRecord": "2",
-        "Counter": "Fixed counter 2",
-        "EventName": "CPU_CLK_UNHALTED.REF_TSC",
-        "PEBScounters": "34",
-        "SampleAfterValue": "2000003",
-        "Speculative": "1",
-        "UMask": "0x3",
-        "Unit": "cpu_atom"
-    },
-    {
-        "BriefDescription": "Counts the number of unhalted reference clock=
 cycles at TSC frequency.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5",
-        "EventCode": "0x3c",
-        "EventName": "CPU_CLK_UNHALTED.REF_TSC_P",
-        "PEBScounters": "0,1,2,3,4,5",
-        "SampleAfterValue": "2000003",
-        "Speculative": "1",
-        "UMask": "0x1",
-        "Unit": "cpu_atom"
-    },
-    {
-        "BriefDescription": "Counts the number of unhalted core clock cycl=
es. (Fixed event)",
-        "CollectPEBSRecord": "2",
-        "Counter": "Fixed counter 1",
-        "EventName": "CPU_CLK_UNHALTED.THREAD",
-        "PEBScounters": "33",
-        "SampleAfterValue": "2000003",
-        "Speculative": "1",
-        "UMask": "0x2",
-        "Unit": "cpu_atom"
-    },
-    {
-        "BriefDescription": "Counts the number of unhalted core clock cycl=
es.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5",
-        "EventCode": "0x3c",
-        "EventName": "CPU_CLK_UNHALTED.THREAD_P",
-        "PEBScounters": "0,1,2,3,4,5",
-        "SampleAfterValue": "2000003",
-        "Speculative": "1",
-        "Unit": "cpu_atom"
-    },
-    {
-        "BriefDescription": "Counts the total number of instructions retir=
ed. (Fixed event)",
-        "CollectPEBSRecord": "2",
-        "Counter": "Fixed counter 0",
-        "EventName": "INST_RETIRED.ANY",
-        "PEBS": "1",
-        "PEBScounters": "32",
-        "SampleAfterValue": "2000003",
-        "UMask": "0x1",
-        "Unit": "cpu_atom"
-    },
-    {
-        "BriefDescription": "Counts the total number of instructions retir=
ed.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5",
-        "EventCode": "0xc0",
-        "EventName": "INST_RETIRED.ANY_P",
-        "PEBS": "1",
-        "PEBScounters": "0,1,2,3,4,5",
-        "SampleAfterValue": "2000003",
-        "Unit": "cpu_atom"
-    },
-    {
-        "BriefDescription": "This event is deprecated. Refer to new event =
LD_BLOCKS.ADDRESS_ALIAS",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5",
-        "EventCode": "0x03",
-        "EventName": "LD_BLOCKS.4K_ALIAS",
-        "PEBS": "1",
-        "PEBScounters": "0,1,2,3,4,5",
-        "SampleAfterValue": "1000003",
-        "UMask": "0x4",
-        "Unit": "cpu_atom"
-    },
-    {
-        "BriefDescription": "Counts the number of retired loads that are b=
locked because it initially appears to be store forward blocked, but subseq=
uently is shown not to be blocked based on 4K alias check.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5",
-        "EventCode": "0x03",
-        "EventName": "LD_BLOCKS.ADDRESS_ALIAS",
-        "PEBS": "1",
-        "PEBScounters": "0,1,2,3,4,5",
-        "SampleAfterValue": "1000003",
-        "UMask": "0x4",
-        "Unit": "cpu_atom"
-    },
-    {
-        "BriefDescription": "Counts the number of retired loads that are b=
locked because its address exactly matches an older store whose data is not=
 ready.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5",
-        "EventCode": "0x03",
-        "EventName": "LD_BLOCKS.DATA_UNKNOWN",
-        "PEBS": "1",
-        "PEBScounters": "0,1,2,3,4,5",
-        "SampleAfterValue": "1000003",
-        "UMask": "0x1",
-        "Unit": "cpu_atom"
-    },
-    {
-        "BriefDescription": "Counts the number of machine clears due to me=
mory ordering in which an internal load passes an older store within the sa=
me CPU.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5",
-        "EventCode": "0xc3",
-        "EventName": "MACHINE_CLEARS.DISAMBIGUATION",
-        "PEBScounters": "0,1,2,3,4,5",
-        "SampleAfterValue": "20003",
-        "Speculative": "1",
-        "UMask": "0x8",
-        "Unit": "cpu_atom"
-    },
-    {
-        "BriefDescription": "Counts the number of machines clears due to m=
emory renaming.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5",
-        "EventCode": "0xc3",
-        "EventName": "MACHINE_CLEARS.MRN_NUKE",
-        "PEBScounters": "0,1,2,3,4,5",
-        "SampleAfterValue": "1000003",
-        "Speculative": "1",
-        "UMask": "0x80",
-        "Unit": "cpu_atom"
-    },
-    {
-        "BriefDescription": "Counts the number of machine clears due to a =
page fault.  Counts both I-Side and D-Side (Loads/Stores) page faults.  A p=
age fault occurs when either the page is not present, or an access violatio=
n occurs.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5",
-        "EventCode": "0xc3",
-        "EventName": "MACHINE_CLEARS.PAGE_FAULT",
-        "PEBScounters": "0,1,2,3,4,5",
-        "SampleAfterValue": "20003",
-        "Speculative": "1",
-        "UMask": "0x20",
-        "Unit": "cpu_atom"
-    },
-    {
-        "BriefDescription": "Counts the number of machine clears that flus=
h the pipeline and restart the machine with the use of microcode due to SMC=
, MEMORY_ORDERING, FP_ASSISTS, PAGE_FAULT, DISAMBIGUATION, and FPC_VIRTUAL_=
TRAP.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5",
-        "EventCode": "0xc3",
-        "EventName": "MACHINE_CLEARS.SLOW",
-        "PEBScounters": "0,1,2,3,4,5",
-        "SampleAfterValue": "20003",
-        "Speculative": "1",
-        "UMask": "0x6f",
-        "Unit": "cpu_atom"
-    },
-    {
-        "BriefDescription": "Counts the number of machine clears due to pr=
ogram modifying data (self modifying code) within 1K of a recently fetched =
code page.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5",
-        "EventCode": "0xc3",
-        "EventName": "MACHINE_CLEARS.SMC",
-        "PEBScounters": "0,1,2,3,4,5",
-        "SampleAfterValue": "20003",
-        "Speculative": "1",
-        "UMask": "0x1",
-        "Unit": "cpu_atom"
-    },
-    {
-        "BriefDescription": "Counts the number of issue slots not consumed=
 by the backend due to a micro-sequencer (MS) scoreboard, which stalls the =
front-end from issuing from the UROM until a specified older uop retires.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5",
-        "EventCode": "0x75",
-        "EventName": "SERIALIZATION.NON_C01_MS_SCB",
-        "PEBScounters": "0,1,2,3,4,5",
-        "SampleAfterValue": "200003",
-        "Speculative": "1",
-        "UMask": "0x2",
-        "Unit": "cpu_atom"
-    },
-    {
-        "BriefDescription": "Counts the total number of issue slots that w=
ere not consumed by the backend because allocation is stalled due to a misp=
redicted jump or a machine clear.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5",
-        "EventCode": "0x73",
-        "EventName": "TOPDOWN_BAD_SPECULATION.ALL",
-        "PEBScounters": "0,1,2,3,4,5",
-        "SampleAfterValue": "1000003",
-        "Speculative": "1",
-        "Unit": "cpu_atom"
-    },
-    {
-        "BriefDescription": "Counts the number of issue slots every cycle =
that were not consumed by the backend due to fast nukes such as memory orde=
ring and memory disambiguation machine clears.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5",
-        "EventCode": "0x73",
-        "EventName": "TOPDOWN_BAD_SPECULATION.FASTNUKE",
-        "PEBScounters": "0,1,2,3,4,5",
-        "SampleAfterValue": "1000003",
-        "Speculative": "1",
-        "UMask": "0x2",
-        "Unit": "cpu_atom"
-    },
-    {
-        "BriefDescription": "Counts the total number of issue slots that w=
ere not consumed by the backend because allocation is stalled due to a mach=
ine clear (nuke) of any kind including memory ordering and memory disambigu=
ation.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5",
-        "EventCode": "0x73",
-        "EventName": "TOPDOWN_BAD_SPECULATION.MACHINE_CLEARS",
-        "PEBScounters": "0,1,2,3,4,5",
-        "SampleAfterValue": "1000003",
-        "Speculative": "1",
-        "UMask": "0x3",
-        "Unit": "cpu_atom"
-    },
-    {
-        "BriefDescription": "Counts the number of issue slots every cycle =
that were not consumed by the backend due to branch mispredicts.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5",
-        "EventCode": "0x73",
-        "EventName": "TOPDOWN_BAD_SPECULATION.MISPREDICT",
-        "PEBScounters": "0,1,2,3,4,5",
-        "SampleAfterValue": "1000003",
-        "Speculative": "1",
-        "UMask": "0x4",
-        "Unit": "cpu_atom"
-    },
-    {
-        "BriefDescription": "Counts the number of issue slots every cycle =
that were not consumed by the backend due to a machine clear (nuke).",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5",
-        "EventCode": "0x73",
-        "EventName": "TOPDOWN_BAD_SPECULATION.NUKE",
-        "PEBScounters": "0,1,2,3,4,5",
-        "SampleAfterValue": "1000003",
-        "Speculative": "1",
-        "UMask": "0x1",
-        "Unit": "cpu_atom"
-    },
-    {
-        "BriefDescription": "Counts the total number of issue slots every =
cycle that were not consumed by the backend due to backend stalls.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5",
-        "EventCode": "0x74",
-        "EventName": "TOPDOWN_BE_BOUND.ALL",
-        "PEBScounters": "0,1,2,3,4,5",
-        "SampleAfterValue": "1000003",
-        "Speculative": "1",
-        "Unit": "cpu_atom"
-    },
-    {
-        "BriefDescription": "Counts the number of issue slots every cycle =
that were not consumed by the backend due to certain allocation restriction=
s.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5",
-        "EventCode": "0x74",
-        "EventName": "TOPDOWN_BE_BOUND.ALLOC_RESTRICTIONS",
-        "PEBScounters": "0,1,2,3,4,5",
-        "SampleAfterValue": "1000003",
-        "Speculative": "1",
-        "UMask": "0x1",
-        "Unit": "cpu_atom"
-    },
-    {
-        "BriefDescription": "Counts the number of issue slots every cycle =
that were not consumed by the backend due to memory reservation stalls in w=
hich a scheduler is not able to accept uops.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5",
-        "EventCode": "0x74",
-        "EventName": "TOPDOWN_BE_BOUND.MEM_SCHEDULER",
-        "PEBScounters": "0,1,2,3,4,5",
-        "SampleAfterValue": "1000003",
-        "Speculative": "1",
-        "UMask": "0x2",
-        "Unit": "cpu_atom"
-    },
-    {
-        "BriefDescription": "Counts the number of issue slots every cycle =
that were not consumed by the backend due to IEC or FPC RAT stalls, which c=
an be due to FIQ or IEC reservation stalls in which the integer, floating p=
oint or SIMD scheduler is not able to accept uops.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5",
-        "EventCode": "0x74",
-        "EventName": "TOPDOWN_BE_BOUND.NON_MEM_SCHEDULER",
-        "PEBScounters": "0,1,2,3,4,5",
-        "SampleAfterValue": "1000003",
-        "Speculative": "1",
-        "UMask": "0x8",
-        "Unit": "cpu_atom"
-    },
-    {
-        "BriefDescription": "Counts the number of issue slots every cycle =
that were not consumed by the backend due to the physical register file una=
ble to accept an entry (marble stalls).",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5",
-        "EventCode": "0x74",
-        "EventName": "TOPDOWN_BE_BOUND.REGISTER",
-        "PEBScounters": "0,1,2,3,4,5",
-        "SampleAfterValue": "1000003",
-        "Speculative": "1",
-        "UMask": "0x20",
-        "Unit": "cpu_atom"
-    },
-    {
-        "BriefDescription": "Counts the number of issue slots every cycle =
that were not consumed by the backend due to the reorder buffer being full =
(ROB stalls).",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5",
-        "EventCode": "0x74",
-        "EventName": "TOPDOWN_BE_BOUND.REORDER_BUFFER",
-        "PEBScounters": "0,1,2,3,4,5",
-        "SampleAfterValue": "1000003",
-        "Speculative": "1",
-        "UMask": "0x40",
-        "Unit": "cpu_atom"
-    },
-    {
-        "BriefDescription": "Counts the number of issue slots every cycle =
that were not consumed by the backend due to scoreboards from the instructi=
on queue (IQ), jump execution unit (JEU), or microcode sequencer (MS).",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5",
-        "EventCode": "0x74",
-        "EventName": "TOPDOWN_BE_BOUND.SERIALIZATION",
-        "PEBScounters": "0,1,2,3,4,5",
-        "SampleAfterValue": "1000003",
-        "Speculative": "1",
-        "UMask": "0x10",
-        "Unit": "cpu_atom"
-    },
-    {
-        "BriefDescription": "Counts the total number of issue slots every =
cycle that were not consumed by the backend due to frontend stalls.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5",
-        "EventCode": "0x71",
-        "EventName": "TOPDOWN_FE_BOUND.ALL",
-        "PEBScounters": "0,1,2,3,4,5",
-        "SampleAfterValue": "1000003",
-        "Speculative": "1",
-        "Unit": "cpu_atom"
-    },
-    {
-        "BriefDescription": "Counts the number of issue slots every cycle =
that were not delivered by the frontend due to BACLEARS.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5",
-        "EventCode": "0x71",
-        "EventName": "TOPDOWN_FE_BOUND.BRANCH_DETECT",
-        "PEBScounters": "0,1,2,3,4,5",
-        "SampleAfterValue": "1000003",
-        "Speculative": "1",
-        "UMask": "0x2",
-        "Unit": "cpu_atom"
-    },
-    {
-        "BriefDescription": "Counts the number of issue slots every cycle =
that were not delivered by the frontend due to BTCLEARS.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5",
-        "EventCode": "0x71",
-        "EventName": "TOPDOWN_FE_BOUND.BRANCH_RESTEER",
-        "PEBScounters": "0,1,2,3,4,5",
-        "SampleAfterValue": "1000003",
-        "Speculative": "1",
-        "UMask": "0x40",
-        "Unit": "cpu_atom"
-    },
-    {
-        "BriefDescription": "Counts the number of issue slots every cycle =
that were not delivered by the frontend due to the microcode sequencer (MS)=
.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5",
-        "EventCode": "0x71",
-        "EventName": "TOPDOWN_FE_BOUND.CISC",
-        "PEBScounters": "0,1,2,3,4,5",
-        "SampleAfterValue": "1000003",
-        "Speculative": "1",
-        "UMask": "0x1",
-        "Unit": "cpu_atom"
-    },
-    {
-        "BriefDescription": "Counts the number of issue slots every cycle =
that were not delivered by the frontend due to decode stalls.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5",
-        "EventCode": "0x71",
-        "EventName": "TOPDOWN_FE_BOUND.DECODE",
-        "PEBScounters": "0,1,2,3,4,5",
-        "SampleAfterValue": "1000003",
-        "Speculative": "1",
-        "UMask": "0x8",
-        "Unit": "cpu_atom"
-    },
-    {
-        "BriefDescription": "Counts the number of issue slots every cycle =
that were not delivered by the frontend due to frontend bandwidth restricti=
ons due to decode, predecode, cisc, and other limitations.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5",
-        "EventCode": "0x71",
-        "EventName": "TOPDOWN_FE_BOUND.FRONTEND_BANDWIDTH",
-        "PEBScounters": "0,1,2,3,4,5",
-        "SampleAfterValue": "1000003",
-        "Speculative": "1",
-        "UMask": "0x8d",
-        "Unit": "cpu_atom"
-    },
-    {
-        "BriefDescription": "Counts the number of issue slots every cycle =
that were not delivered by the frontend due to a latency related stalls inc=
luding BACLEARs, BTCLEARs, ITLB misses, and ICache misses.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5",
-        "EventCode": "0x71",
-        "EventName": "TOPDOWN_FE_BOUND.FRONTEND_LATENCY",
-        "PEBScounters": "0,1,2,3,4,5",
-        "SampleAfterValue": "1000003",
-        "Speculative": "1",
-        "UMask": "0x72",
-        "Unit": "cpu_atom"
-    },
-    {
-        "BriefDescription": "Counts the number of issue slots every cycle =
that were not delivered by the frontend due to ITLB misses.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5",
-        "EventCode": "0x71",
-        "EventName": "TOPDOWN_FE_BOUND.ITLB",
-        "PEBScounters": "0,1,2,3,4,5",
-        "SampleAfterValue": "1000003",
-        "Speculative": "1",
-        "UMask": "0x10",
-        "Unit": "cpu_atom"
-    },
-    {
-        "BriefDescription": "Counts the number of issue slots every cycle =
that were not delivered by the frontend due to other common frontend stalls=
 not categorized.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5",
-        "EventCode": "0x71",
-        "EventName": "TOPDOWN_FE_BOUND.OTHER",
-        "PEBScounters": "0,1,2,3,4,5",
-        "SampleAfterValue": "1000003",
-        "Speculative": "1",
-        "UMask": "0x80",
-        "Unit": "cpu_atom"
-    },
-    {
-        "BriefDescription": "Counts the number of issue slots every cycle =
that were not delivered by the frontend due to wrong predecodes.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5",
-        "EventCode": "0x71",
-        "EventName": "TOPDOWN_FE_BOUND.PREDECODE",
-        "PEBScounters": "0,1,2,3,4,5",
-        "SampleAfterValue": "1000003",
-        "Speculative": "1",
-        "UMask": "0x4",
-        "Unit": "cpu_atom"
-    },
-    {
-        "BriefDescription": "Counts the total number of consumed retiremen=
t slots.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5",
-        "EventCode": "0xc2",
-        "EventName": "TOPDOWN_RETIRING.ALL",
-        "PEBS": "1",
-        "PEBScounters": "0,1,2,3,4,5",
-        "SampleAfterValue": "1000003",
-        "Unit": "cpu_atom"
-    },
-    {
-        "BriefDescription": "Counts the total number of uops retired.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5",
-        "EventCode": "0xc2",
-        "EventName": "UOPS_RETIRED.ALL",
-        "PEBS": "1",
-        "PEBScounters": "0,1,2,3,4,5",
-        "SampleAfterValue": "2000003",
-        "Unit": "cpu_atom"
-    },
-    {
-        "BriefDescription": "Counts the number of integer divide uops reti=
red.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5",
-        "EventCode": "0xc2",
-        "EventName": "UOPS_RETIRED.IDIV",
-        "PEBS": "1",
-        "PEBScounters": "0,1,2,3,4,5",
-        "SampleAfterValue": "2000003",
-        "UMask": "0x10",
-        "Unit": "cpu_atom"
-    },
-    {
-        "BriefDescription": "Counts the number of uops that are from compl=
ex flows issued by the micro-sequencer (MS).",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5",
-        "EventCode": "0xc2",
-        "EventName": "UOPS_RETIRED.MS",
-        "PEBS": "1",
-        "PEBScounters": "0,1,2,3,4,5",
-        "SampleAfterValue": "2000003",
-        "UMask": "0x1",
-        "Unit": "cpu_atom"
-    },
-    {
-        "BriefDescription": "Counts the number of x87 uops retired, includ=
es those in MS flows.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5",
-        "EventCode": "0xc2",
-        "EventName": "UOPS_RETIRED.X87",
-        "PEBS": "1",
-        "PEBScounters": "0,1,2,3,4,5",
-        "SampleAfterValue": "2000003",
-        "UMask": "0x2",
-        "Unit": "cpu_atom"
-    },
     {
         "BriefDescription": "This event is deprecated. Refer to new event =
ARITH.DIV_ACTIVE",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
+        "Deprecated": "1",
         "EventCode": "0xb0",
         "EventName": "ARITH.DIVIDER_ACTIVE",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "1000003",
-        "Speculative": "1",
         "UMask": "0x9",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Cycles when divide unit is busy executing div=
ide or square root operations.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
         "EventCode": "0xb0",
         "EventName": "ARITH.DIV_ACTIVE",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts cycles when divide unit is busy execu=
ting divide or square root operations. Accounts for integer and floating-po=
int operations.",
         "SampleAfterValue": "1000003",
-        "Speculative": "1",
         "UMask": "0x9",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "This event is deprecated. Refer to new event =
ARITH.FPDIV_ACTIVE",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
+        "Deprecated": "1",
         "EventCode": "0xb0",
         "EventName": "ARITH.FP_DIVIDER_ACTIVE",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "1000003",
-        "Speculative": "1",
         "UMask": "0x1",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "This event counts the cycles the integer divi=
der is busy.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xb0",
         "EventName": "ARITH.IDIV_ACTIVE",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "1000003",
-        "Speculative": "1",
         "UMask": "0x8",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "This event is deprecated. Refer to new event =
ARITH.IDIV_ACTIVE",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
+        "Deprecated": "1",
         "EventCode": "0xb0",
         "EventName": "ARITH.INT_DIVIDER_ACTIVE",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "1000003",
-        "Speculative": "1",
         "UMask": "0x8",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Number of occurrences where a microcode assis=
t is invoked by hardware.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc1",
         "EventName": "ASSISTS.ANY",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts the number of occurrences where a mic=
rocode assist is invoked by hardware. Examples include AD (page Access Dirt=
y), FP and AVX related assists.",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0x1b",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts the total number of branch instruction=
s retired for all branch types.",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.ALL_BRANCHES",
+        "PEBS": "1",
+        "PublicDescription": "Counts the total number of instructions in w=
hich the instruction pointer (IP) of the processor is resteered due to a br=
anch instruction and the branch instruction successfully retires.  All bran=
ch type instructions are accounted for.",
+        "SampleAfterValue": "200003",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "All branch instructions retired.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.ALL_BRANCHES",
         "PEBS": "1",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts all branch instructions retired.",
         "SampleAfterValue": "400009",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
BR_INST_RETIRED.NEAR_CALL",
+        "Deprecated": "1",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.CALL",
+        "PEBS": "1",
+        "SampleAfterValue": "200003",
+        "UMask": "0xf9",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of retired JCC (Jump on Con=
ditional Code) branch instructions retired, includes both taken and not tak=
en branches.",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.COND",
+        "PEBS": "1",
+        "SampleAfterValue": "200003",
+        "UMask": "0x7e",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Conditional branch instructions retired.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.COND",
         "PEBS": "1",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts conditional branch instructions retir=
ed.",
         "SampleAfterValue": "400009",
         "UMask": "0x11",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Not taken branch instructions retired.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.COND_NTAKEN",
         "PEBS": "1",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts not taken branch instructions retired=
.",
         "SampleAfterValue": "400009",
         "UMask": "0x10",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts the number of taken JCC (Jump on Condi=
tional Code) branch instructions retired.",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.COND_TAKEN",
+        "PEBS": "1",
+        "SampleAfterValue": "200003",
+        "UMask": "0xfe",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Taken conditional branch instructions retired=
.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.COND_TAKEN",
         "PEBS": "1",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts taken conditional branch instructions=
 retired.",
         "SampleAfterValue": "400009",
         "UMask": "0x1",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts the number of far branch instructions =
retired, includes far jump, far call and return, and interrupt call and ret=
urn.",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.FAR_BRANCH",
+        "PEBS": "1",
+        "SampleAfterValue": "200003",
+        "UMask": "0xbf",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Far branch instructions retired.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.FAR_BRANCH",
         "PEBS": "1",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts far branch instructions retired.",
         "SampleAfterValue": "100007",
         "UMask": "0x40",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts the number of near indirect JMP and ne=
ar indirect CALL branch instructions retired.",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.INDIRECT",
+        "PEBS": "1",
+        "SampleAfterValue": "200003",
+        "UMask": "0xeb",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Indirect near branch instructions retired (ex=
cluding returns)",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.INDIRECT",
         "PEBS": "1",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts near indirect branch instructions ret=
ired excluding returns. TSX abort is an indirect branch.",
         "SampleAfterValue": "100003",
         "UMask": "0x80",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts the number of near indirect CALL branc=
h instructions retired.",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.INDIRECT_CALL",
+        "PEBS": "1",
+        "SampleAfterValue": "200003",
+        "UMask": "0xfb",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
BR_INST_RETIRED.INDIRECT_CALL",
+        "Deprecated": "1",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.IND_CALL",
+        "PEBS": "1",
+        "SampleAfterValue": "200003",
+        "UMask": "0xfb",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
BR_INST_RETIRED.COND",
+        "Deprecated": "1",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.JCC",
+        "PEBS": "1",
+        "SampleAfterValue": "200003",
+        "UMask": "0x7e",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of near CALL branch instruc=
tions retired.",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.NEAR_CALL",
+        "PEBS": "1",
+        "SampleAfterValue": "200003",
+        "UMask": "0xf9",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Direct and indirect near call instructions re=
tired.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.NEAR_CALL",
         "PEBS": "1",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts both direct and indirect near call in=
structions retired.",
         "SampleAfterValue": "100007",
         "UMask": "0x2",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts the number of near RET branch instruct=
ions retired.",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.NEAR_RETURN",
+        "PEBS": "1",
+        "SampleAfterValue": "200003",
+        "UMask": "0xf7",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Return instructions retired.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.NEAR_RETURN",
         "PEBS": "1",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts return instructions retired.",
         "SampleAfterValue": "100007",
         "UMask": "0x8",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Taken branch instructions retired.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.NEAR_TAKEN",
         "PEBS": "1",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts taken branch instructions retired.",
         "SampleAfterValue": "400009",
         "UMask": "0x20",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
BR_INST_RETIRED.INDIRECT",
+        "Deprecated": "1",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.NON_RETURN_IND",
+        "PEBS": "1",
+        "SampleAfterValue": "200003",
+        "UMask": "0xeb",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of near relative CALL branc=
h instructions retired.",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.REL_CALL",
+        "PEBS": "1",
+        "SampleAfterValue": "200003",
+        "UMask": "0xfd",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
BR_INST_RETIRED.NEAR_RETURN",
+        "Deprecated": "1",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.RETURN",
+        "PEBS": "1",
+        "SampleAfterValue": "200003",
+        "UMask": "0xf7",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
BR_INST_RETIRED.COND_TAKEN",
+        "Deprecated": "1",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.TAKEN_JCC",
+        "PEBS": "1",
+        "SampleAfterValue": "200003",
+        "UMask": "0xfe",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the total number of mispredicted branc=
h instructions retired for all branch types.",
+        "EventCode": "0xc5",
+        "EventName": "BR_MISP_RETIRED.ALL_BRANCHES",
+        "PEBS": "1",
+        "PublicDescription": "Counts the total number of mispredicted bran=
ch instructions retired.  All branch type instructions are accounted for.  =
Prediction of the branch target address enables the processor to begin exec=
uting instructions before the non-speculative execution path is known. The =
branch prediction unit (BPU) predicts the target address based on the instr=
uction pointer (IP) of the branch and on the execution path through which e=
xecution reached this IP.    A branch misprediction occurs when the predict=
ion is wrong, and results in discarding all instructions executed in the sp=
eculative path and re-fetching from the correct path.",
+        "SampleAfterValue": "200003",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "All mispredicted branch instructions retired.=
",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.ALL_BRANCHES",
         "PEBS": "1",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts all the retired branch instructions t=
hat were mispredicted by the processor. A branch misprediction occurs when =
the processor incorrectly predicts the destination of the branch.  When the=
 misprediction is discovered at execution, all the instructions executed in=
 the wrong (speculative) path must be discarded, and the processor must sta=
rt fetching from the correct path.",
         "SampleAfterValue": "400009",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts the number of mispredicted JCC (Jump o=
n Conditional Code) branch instructions retired.",
+        "EventCode": "0xc5",
+        "EventName": "BR_MISP_RETIRED.COND",
+        "PEBS": "1",
+        "SampleAfterValue": "200003",
+        "UMask": "0x7e",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Mispredicted conditional branch instructions =
retired.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.COND",
         "PEBS": "1",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts mispredicted conditional branch instr=
uctions retired.",
         "SampleAfterValue": "400009",
         "UMask": "0x11",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Mispredicted non-taken conditional branch ins=
tructions retired.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.COND_NTAKEN",
         "PEBS": "1",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts the number of conditional branch inst=
ructions retired that were mispredicted and the branch direction was not ta=
ken.",
         "SampleAfterValue": "400009",
         "UMask": "0x10",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts the number of mispredicted taken JCC (=
Jump on Conditional Code) branch instructions retired.",
+        "EventCode": "0xc5",
+        "EventName": "BR_MISP_RETIRED.COND_TAKEN",
+        "PEBS": "1",
+        "SampleAfterValue": "200003",
+        "UMask": "0xfe",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "number of branch instructions retired that we=
re mispredicted and taken.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.COND_TAKEN",
         "PEBS": "1",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts taken conditional mispredicted branch=
 instructions retired.",
         "SampleAfterValue": "400009",
         "UMask": "0x1",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts the number of mispredicted near indire=
ct JMP and near indirect CALL branch instructions retired.",
+        "EventCode": "0xc5",
+        "EventName": "BR_MISP_RETIRED.INDIRECT",
+        "PEBS": "1",
+        "SampleAfterValue": "200003",
+        "UMask": "0xeb",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of mispredicted near indire=
ct CALL branch instructions retired.",
+        "EventCode": "0xc5",
+        "EventName": "BR_MISP_RETIRED.INDIRECT_CALL",
+        "PEBS": "1",
+        "SampleAfterValue": "200003",
+        "UMask": "0xfb",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Mispredicted indirect CALL retired.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.INDIRECT_CALL",
         "PEBS": "1",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts retired mispredicted indirect (near t=
aken) CALL instructions, including both register and memory indirect.",
         "SampleAfterValue": "400009",
         "UMask": "0x2",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
BR_MISP_RETIRED.INDIRECT_CALL",
+        "Deprecated": "1",
+        "EventCode": "0xc5",
+        "EventName": "BR_MISP_RETIRED.IND_CALL",
+        "PEBS": "1",
+        "SampleAfterValue": "200003",
+        "UMask": "0xfb",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
BR_MISP_RETIRED.COND",
+        "Deprecated": "1",
+        "EventCode": "0xc5",
+        "EventName": "BR_MISP_RETIRED.JCC",
+        "PEBS": "1",
+        "SampleAfterValue": "200003",
+        "UMask": "0x7e",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Number of near branch instructions retired th=
at were mispredicted and taken.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.NEAR_TAKEN",
         "PEBS": "1",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts number of near branch instructions re=
tired that were mispredicted and taken.",
         "SampleAfterValue": "400009",
         "UMask": "0x20",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
BR_MISP_RETIRED.INDIRECT",
+        "Deprecated": "1",
+        "EventCode": "0xc5",
+        "EventName": "BR_MISP_RETIRED.NON_RETURN_IND",
+        "PEBS": "1",
+        "SampleAfterValue": "200003",
+        "UMask": "0xeb",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "This event counts the number of mispredicted =
ret instructions retired. Non PEBS",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.RET",
         "PEBS": "1",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "This is a non-precise version (that is, does=
 not use PEBS) of the event that counts mispredicted return instructions re=
tired.",
         "SampleAfterValue": "100007",
         "UMask": "0x8",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts the number of mispredicted near RET br=
anch instructions retired.",
+        "EventCode": "0xc5",
+        "EventName": "BR_MISP_RETIRED.RETURN",
+        "PEBS": "1",
+        "SampleAfterValue": "200003",
+        "UMask": "0xf7",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
BR_MISP_RETIRED.COND_TAKEN",
+        "Deprecated": "1",
+        "EventCode": "0xc5",
+        "EventName": "BR_MISP_RETIRED.TAKEN_JCC",
+        "PEBS": "1",
+        "SampleAfterValue": "200003",
+        "UMask": "0xfe",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Core clocks when the thread is in the C0.1 li=
ght-weight slower wakeup time but more power saving optimized state.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xec",
         "EventName": "CPU_CLK_UNHALTED.C01",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts core clocks when the thread is in the=
 C0.1 light-weight slower wakeup time but more power saving optimized state=
.  This state can be entered via the TPAUSE or UMWAIT instructions.",
         "SampleAfterValue": "2000003",
-        "Speculative": "1",
         "UMask": "0x10",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Core clocks when the thread is in the C0.2 li=
ght-weight faster wakeup time but less power saving optimized state.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xec",
         "EventName": "CPU_CLK_UNHALTED.C02",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts core clocks when the thread is in the=
 C0.2 light-weight faster wakeup time but less power saving optimized state=
.  This state can be entered via the TPAUSE or UMWAIT instructions.",
         "SampleAfterValue": "2000003",
-        "Speculative": "1",
         "UMask": "0x20",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Core clocks when the thread is in the C0.1 or=
 C0.2 or running a PAUSE in C0 ACPI state.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xec",
         "EventName": "CPU_CLK_UNHALTED.C0_WAIT",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts core clocks when the thread is in the=
 C0.1 or C0.2 power saving optimized states (TPAUSE or UMWAIT instructions)=
 or running the PAUSE instruction.",
         "SampleAfterValue": "2000003",
-        "Speculative": "1",
         "UMask": "0x70",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts the number of unhalted core clock cycl=
es. (Fixed event)",
+        "EventName": "CPU_CLK_UNHALTED.CORE",
+        "PublicDescription": "Counts the number of core cycles while the c=
ore is not in a halt state. The core enters the halt state when it is runni=
ng the HLT instruction. The core frequency may change from time to time. Fo=
r this reason this event may have a changing ratio with regards to time. Th=
is event uses fixed counter 1.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x2",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of unhalted core clock cycl=
es.",
+        "EventCode": "0x3c",
+        "EventName": "CPU_CLK_UNHALTED.CORE_P",
+        "PublicDescription": "Counts the number of core cycles while the c=
ore is not in a halt state. The core enters the halt state when it is runni=
ng the HLT instruction. The core frequency may change from time to time. Fo=
r this reason this event may have a changing ratio with regards to time. Th=
is event uses a programmable general purpose performance counter.",
+        "SampleAfterValue": "2000003",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Cycle counts are evenly distributed between a=
ctive threads in the Core.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xec",
         "EventName": "CPU_CLK_UNHALTED.DISTRIBUTED",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "This event distributes cycle counts between =
active hyperthreads, i.e., those in C0.  A hyperthread becomes inactive whe=
n it executes the HLT or MWAIT instructions.  If all other hyperthreads are=
 inactive (or disabled or do not exist), all counts are attributed to this =
hyperthread. To obtain the full count when the Core is active, sum the coun=
ts from each hyperthread.",
         "SampleAfterValue": "2000003",
-        "Speculative": "1",
         "UMask": "0x2",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Core crystal clock cycles when this thread is=
 unhalted and the other thread is halted.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x3c",
         "EventName": "CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts Core crystal clock cycles when curren=
t thread is unhalted and the other thread is halted.",
         "SampleAfterValue": "25003",
-        "Speculative": "1",
         "UMask": "0x2",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "CPU_CLK_UNHALTED.PAUSE",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xec",
         "EventName": "CPU_CLK_UNHALTED.PAUSE",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "2000003",
-        "Speculative": "1",
         "UMask": "0x40",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "CPU_CLK_UNHALTED.PAUSE_INST",
-        "Counter": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
         "EdgeDetect": "1",
         "EventCode": "0xec",
         "EventName": "CPU_CLK_UNHALTED.PAUSE_INST",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "2000003",
-        "Speculative": "1",
         "UMask": "0x40",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Core crystal clock cycles. Cycle counts are e=
venly distributed between active threads in the Core.",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x3c",
         "EventName": "CPU_CLK_UNHALTED.REF_DISTRIBUTED",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "This event distributes Core crystal clock cy=
cle counts between active hyperthreads, i.e., those in C0 sleep-state. A hy=
perthread becomes inactive when it executes the HLT or MWAIT instructions. =
If one thread is active in a core, all counts are attributed to this hypert=
hread. To obtain the full count when the Core is active, sum the counts fro=
m each hyperthread.",
         "SampleAfterValue": "2000003",
-        "Speculative": "1",
         "UMask": "0x8",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts the number of unhalted reference clock=
 cycles at TSC frequency. (Fixed event)",
+        "EventName": "CPU_CLK_UNHALTED.REF_TSC",
+        "PublicDescription": "Counts the number of reference cycles that t=
he core is not in a halt state. The core enters the halt state when it is r=
unning the HLT instruction. This event is not affected by core frequency ch=
anges and increments at a fixed frequency that is also used for the Time St=
amp Counter (TSC). This event uses fixed counter 2.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x3",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Reference cycles when the core is not in halt=
 state.",
-        "CollectPEBSRecord": "2",
-        "Counter": "Fixed counter 2",
         "EventName": "CPU_CLK_UNHALTED.REF_TSC",
-        "PEBScounters": "34",
+        "PublicDescription": "Counts the number of reference cycles when t=
he core is not in a halt state. The core enters the halt state when it is r=
unning the HLT instruction or the MWAIT instruction. This event is not affe=
cted by core frequency changes (for example, P states, TM2 transitions) but=
 has the same incrementing frequency as the time stamp counter. This event =
can approximate elapsed time while the core was not in a halt state. It is =
counted on a dedicated fixed counter, leaving the eight programmable counte=
rs available for other events. Note: On all current platforms this event st=
ops counting during 'throttling (TM)' states duty off periods the processor=
 is 'halted'.  The counter update is done at a lower clock rate then the co=
re clock the overflow status bit for this counter may appear 'sticky'.  Aft=
er the counter has overflowed and software clears the overflow status bit a=
nd resets the counter to less than MAX. The reset value to the counter is n=
ot clocked immediately so the overflow status bit will flip 'high (1)' and =
generate another PMI (if enabled) after which the reset value gets clocked =
into the counter. Therefore, software will get the interrupt, read the over=
flow status bit '1 for bit 34 while the counter value is less than MAX. Sof=
tware should ignore this case.",
         "SampleAfterValue": "2000003",
-        "Speculative": "1",
         "UMask": "0x3",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts the number of unhalted reference clock=
 cycles at TSC frequency.",
+        "EventCode": "0x3c",
+        "EventName": "CPU_CLK_UNHALTED.REF_TSC_P",
+        "PublicDescription": "Counts the number of reference cycles that t=
he core is not in a halt state. The core enters the halt state when it is r=
unning the HLT instruction. This event is not affected by core frequency ch=
anges and increments at a fixed frequency that is also used for the Time St=
amp Counter (TSC). This event uses a programmable general purpose performan=
ce counter.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x1",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Reference cycles when the core is not in halt=
 state.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x3c",
         "EventName": "CPU_CLK_UNHALTED.REF_TSC_P",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts the number of reference cycles when t=
he core is not in a halt state. The core enters the halt state when it is r=
unning the HLT instruction or the MWAIT instruction. This event is not affe=
cted by core frequency changes (for example, P states, TM2 transitions) but=
 has the same incrementing frequency as the time stamp counter. This event =
can approximate elapsed time while the core was not in a halt state. It is =
counted on a dedicated fixed counter, leaving the four (eight when Hyperthr=
eading is disabled) programmable counters available for other events. Note:=
 On all current platforms this event stops counting during 'throttling (TM)=
' states duty off periods the processor is 'halted'.  The counter update is=
 done at a lower clock rate then the core clock the overflow status bit for=
 this counter may appear 'sticky'.  After the counter has overflowed and so=
ftware clears the overflow status bit and resets the counter to less than M=
AX. The reset value to the counter is not clocked immediately so the overfl=
ow status bit will flip 'high (1)' and generate another PMI (if enabled) af=
ter which the reset value gets clocked into the counter. Therefore, softwar=
e will get the interrupt, read the overflow status bit '1 for bit 34 while =
the counter value is less than MAX. Software should ignore this case.",
         "SampleAfterValue": "2000003",
-        "Speculative": "1",
         "UMask": "0x1",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts the number of unhalted core clock cycl=
es. (Fixed event)",
+        "EventName": "CPU_CLK_UNHALTED.THREAD",
+        "PublicDescription": "Counts the number of core cycles while the c=
ore is not in a halt state.  The core enters the halt state when it is runn=
ing the HLT instruction. The core frequency may change from time to time. F=
or this reason this event may have a changing ratio with regards to time.  =
This event uses fixed counter 1.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x2",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Core cycles when the thread is not in halt st=
ate",
-        "CollectPEBSRecord": "2",
-        "Counter": "Fixed counter 1",
         "EventName": "CPU_CLK_UNHALTED.THREAD",
-        "PEBScounters": "33",
+        "PublicDescription": "Counts the number of core cycles while the t=
hread is not in a halt state. The thread enters the halt state when it is r=
unning the HLT instruction. This event is a component in many key event rat=
ios. The core frequency may change from time to time due to transitions ass=
ociated with Enhanced Intel SpeedStep Technology or TM2. For this reason th=
is event may have a changing ratio with regards to time. When the core freq=
uency is constant, this event can approximate elapsed time while the core w=
as not in the halt state. It is counted on a dedicated fixed counter, leavi=
ng the eight programmable counters available for other events.",
         "SampleAfterValue": "2000003",
-        "Speculative": "1",
         "UMask": "0x2",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts the number of unhalted core clock cycl=
es.",
+        "EventCode": "0x3c",
+        "EventName": "CPU_CLK_UNHALTED.THREAD_P",
+        "PublicDescription": "Counts the number of core cycles while the c=
ore is not in a halt state.  The core enters the halt state when it is runn=
ing the HLT instruction. The core frequency may change from time to time. F=
or this reason this event may have a changing ratio with regards to time. T=
his event uses a programmable general purpose performance counter.",
+        "SampleAfterValue": "2000003",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Thread cycles when thread is not in halt stat=
e",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x3c",
         "EventName": "CPU_CLK_UNHALTED.THREAD_P",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "This is an architectural event that counts t=
he number of thread cycles while the thread is not in a halt state. The thr=
ead enters the halt state when it is running the HLT instruction. The core =
frequency may change from time to time due to power or thermal throttling. =
For this reason, this event may have a changing ratio with regards to wall =
clock time.",
         "SampleAfterValue": "2000003",
-        "Speculative": "1",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Cycles while L1 cache miss demand load is out=
standing.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "CounterMask": "8",
         "EventCode": "0xa3",
         "EventName": "CYCLE_ACTIVITY.CYCLES_L1D_MISS",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "1000003",
-        "Speculative": "1",
         "UMask": "0x8",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Cycles while L2 cache miss demand load is out=
standing.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "CounterMask": "1",
         "EventCode": "0xa3",
         "EventName": "CYCLE_ACTIVITY.CYCLES_L2_MISS",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "1000003",
-        "Speculative": "1",
         "UMask": "0x1",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Cycles while memory subsystem has an outstand=
ing load.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "CounterMask": "16",
         "EventCode": "0xa3",
         "EventName": "CYCLE_ACTIVITY.CYCLES_MEM_ANY",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "1000003",
-        "Speculative": "1",
         "UMask": "0x10",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Execution stalls while L1 cache miss demand l=
oad is outstanding.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "CounterMask": "12",
         "EventCode": "0xa3",
         "EventName": "CYCLE_ACTIVITY.STALLS_L1D_MISS",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "1000003",
-        "Speculative": "1",
         "UMask": "0xc",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Execution stalls while L2 cache miss demand l=
oad is outstanding.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "CounterMask": "5",
         "EventCode": "0xa3",
         "EventName": "CYCLE_ACTIVITY.STALLS_L2_MISS",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "1000003",
-        "Speculative": "1",
         "UMask": "0x5",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Total execution stalls.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "CounterMask": "4",
         "EventCode": "0xa3",
         "EventName": "CYCLE_ACTIVITY.STALLS_TOTAL",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "1000003",
-        "Speculative": "1",
         "UMask": "0x4",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Cycles total of 1 uop is executed on all port=
s and Reservation Station was not empty.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xa6",
         "EventName": "EXE_ACTIVITY.1_PORTS_UTIL",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts cycles during which a total of 1 uop =
was executed on all ports and Reservation Station (RS) was not empty.",
         "SampleAfterValue": "2000003",
-        "Speculative": "1",
         "UMask": "0x2",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Cycles total of 2 uops are executed on all po=
rts and Reservation Station was not empty.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xa6",
         "EventName": "EXE_ACTIVITY.2_PORTS_UTIL",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts cycles during which a total of 2 uops=
 were executed on all ports and Reservation Station (RS) was not empty.",
         "SampleAfterValue": "2000003",
-        "Speculative": "1",
         "UMask": "0x4",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Cycles total of 3 uops are executed on all po=
rts and Reservation Station was not empty.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xa6",
         "EventName": "EXE_ACTIVITY.3_PORTS_UTIL",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Cycles total of 3 uops are executed on all p=
orts and Reservation Station (RS) was not empty.",
         "SampleAfterValue": "2000003",
-        "Speculative": "1",
         "UMask": "0x8",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Cycles total of 4 uops are executed on all po=
rts and Reservation Station was not empty.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xa6",
         "EventName": "EXE_ACTIVITY.4_PORTS_UTIL",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Cycles total of 4 uops are executed on all p=
orts and Reservation Station (RS) was not empty.",
         "SampleAfterValue": "2000003",
-        "Speculative": "1",
         "UMask": "0x10",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Execution stalls while memory subsystem has a=
n outstanding load.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "CounterMask": "5",
         "EventCode": "0xa6",
         "EventName": "EXE_ACTIVITY.BOUND_ON_LOADS",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "2000003",
-        "Speculative": "1",
         "UMask": "0x21",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Cycles where the Store Buffer was full and no=
 loads caused an execution stall.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "CounterMask": "2",
         "EventCode": "0xa6",
         "EventName": "EXE_ACTIVITY.BOUND_ON_STORES",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts cycles where the Store Buffer was ful=
l and no loads caused an execution stall.",
         "SampleAfterValue": "1000003",
-        "Speculative": "1",
         "UMask": "0x40",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Cycles no uop executed while RS was not empty=
, the SB was not full and there was no outstanding load.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xa6",
         "EventName": "EXE_ACTIVITY.EXE_BOUND_0_PORTS",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Number of cycles total of 0 uops executed on=
 all ports, Reservation Station (RS) was not empty, the Store Buffer (SB) w=
as not full and there was no outstanding load.",
         "SampleAfterValue": "1000003",
-        "Speculative": "1",
         "UMask": "0x80",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Instruction decoders utilized in a cycle",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x75",
         "EventName": "INST_DECODED.DECODERS",
-        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Number of decoders utilized in a cycle when =
the MITE (legacy decode pipeline) fetches instructions.",
         "SampleAfterValue": "2000003",
-        "Speculative": "1",
         "UMask": "0x1",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts the total number of instructions retir=
ed. (Fixed event)",
+        "EventName": "INST_RETIRED.ANY",
+        "PEBS": "1",
+        "PublicDescription": "Counts the total number of instructions that=
 retired. For instructions that consist of multiple uops, this event counts=
 the retirement of the last uop of the instruction. This event continues co=
unting during hardware interrupts, traps, and inside interrupt handlers. Th=
is event uses fixed counter 0.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x1",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Number of instructions retired. Fixed Counter=
 - architectural event",
-        "CollectPEBSRecord": "2",
-        "Counter": "Fixed counter 0",
         "EventName": "INST_RETIRED.ANY",
         "PEBS": "1",
-        "PEBScounters": "32",
+        "PublicDescription": "Counts the number of X86 instructions retire=
d - an Architectural PerfMon event. Counting continues during hardware inte=
rrupts, traps, and inside interrupt handlers. Notes: INST_RETIRED.ANY is co=
unted by a designated fixed counter freeing up programmable counters to cou=
nt other events. INST_RETIRED.ANY_P is counted by a programmable counter.",
         "SampleAfterValue": "2000003",
         "UMask": "0x1",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts the total number of instructions retir=
ed.",
+        "EventCode": "0xc0",
+        "EventName": "INST_RETIRED.ANY_P",
+        "PEBS": "1",
+        "PublicDescription": "Counts the total number of instructions that=
 retired. For instructions that consist of multiple uops, this event counts=
 the retirement of the last uop of the instruction. This event continues co=
unting during hardware interrupts, traps, and inside interrupt handlers. Th=
is event uses a programmable general purpose performance counter.",
+        "SampleAfterValue": "2000003",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Number of instructions retired. General Count=
er - architectural event",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc0",
         "EventName": "INST_RETIRED.ANY_P",
         "PEBS": "1",
-        "PEBScounters": "1,2,3,4,5,6,7",
+        "PublicDescription": "Counts the number of X86 instructions retire=
d - an Architectural PerfMon event. Counting continues during hardware inte=
rrupts, traps, and inside interrupt handlers. Notes: INST_RETIRED.ANY is co=
unted by a designated fixed counter freeing up programmable counters to cou=
nt other events. INST_RETIRED.ANY_P is counted by a programmable counter.",
         "SampleAfterValue": "2000003",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "INST_RETIRED.MACRO_FUSED",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc0",
         "EventName": "INST_RETIRED.MACRO_FUSED",
-        "PEBScounters": "1,2,3,4,5,6,7",
         "SampleAfterValue": "2000003",
         "UMask": "0x10",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Retired NOP instructions.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc0",
         "EventName": "INST_RETIRED.NOP",
-        "PEBScounters": "1,2,3,4,5,6,7",
+        "PublicDescription": "Counts all retired NOP or ENDBR32/64 instruc=
tions",
         "SampleAfterValue": "2000003",
         "UMask": "0x2",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Precise instruction retired with PEBS precise=
-distribution",
-        "CollectPEBSRecord": "2",
-        "Counter": "Fixed counter 0",
         "EventName": "INST_RETIRED.PREC_DIST",
         "PEBS": "1",
-        "PEBScounters": "32",
+        "PublicDescription": "A version of INST_RETIRED that allows for a =
precise distribution of samples across instructions retired. It utilizes th=
e Precise Distribution of Instructions Retired (PDIR++) feature to fix bias=
 in how retired instructions get sampled. Use on Fixed Counter 0.",
         "SampleAfterValue": "2000003",
         "UMask": "0x1",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "INST_RETIRED.REP_ITERATION",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc0",
         "EventName": "INST_RETIRED.REP_ITERATION",
-        "PEBScounters": "1,2,3,4,5,6,7",
         "SampleAfterValue": "2000003",
         "UMask": "0x8",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Counts cycles after recovery from a branch mi=
sprediction or machine clear till the first uop is issued from the resteere=
d path.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xad",
         "EventName": "INT_MISC.CLEAR_RESTEER_CYCLES",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Cycles after recovery from a branch mispredi=
ction or machine clear till the first uop is issued from the resteered path=
.",
         "SampleAfterValue": "500009",
-        "Speculative": "1",
         "UMask": "0x80",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Core cycles the allocator was stalled due to =
recovery from earlier clear event for this thread",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xad",
         "EventName": "INT_MISC.RECOVERY_CYCLES",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts core cycles when the Resource allocat=
or was stalled due to recovery from an earlier branch misprediction or mach=
ine clear event.",
         "SampleAfterValue": "500009",
-        "Speculative": "1",
         "UMask": "0x1",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "INT_MISC.UNKNOWN_BRANCH_CYCLES",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xad",
         "EventName": "INT_MISC.UNKNOWN_BRANCH_CYCLES",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x7",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "1000003",
-        "Speculative": "1",
-        "TakenAlone": "1",
         "UMask": "0x40",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "TMA slots where uops got dropped",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xad",
         "EventName": "INT_MISC.UOP_DROPPING",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Estimated number of Top-down Microarchitectu=
re Analysis slots that got dropped due to non front-end reasons",
         "SampleAfterValue": "1000003",
-        "Speculative": "1",
         "UMask": "0x10",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "INT_VEC_RETIRED.128BIT",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xe7",
         "EventName": "INT_VEC_RETIRED.128BIT",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "1000003",
         "UMask": "0x13",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "INT_VEC_RETIRED.256BIT",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xe7",
         "EventName": "INT_VEC_RETIRED.256BIT",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "1000003",
         "UMask": "0xac",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "integer ADD, SUB, SAD 128-bit vector instruct=
ions.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xe7",
         "EventName": "INT_VEC_RETIRED.ADD_128",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Number of retired integer ADD/SUB (regular o=
r horizontal), SAD 128-bit vector instructions.",
         "SampleAfterValue": "1000003",
         "UMask": "0x3",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "integer ADD, SUB, SAD 256-bit vector instruct=
ions.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xe7",
         "EventName": "INT_VEC_RETIRED.ADD_256",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Number of retired integer ADD/SUB (regular o=
r horizontal), SAD 256-bit vector instructions.",
         "SampleAfterValue": "1000003",
         "UMask": "0xc",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "INT_VEC_RETIRED.MUL_256",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xe7",
         "EventName": "INT_VEC_RETIRED.MUL_256",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "1000003",
         "UMask": "0x80",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "INT_VEC_RETIRED.SHUFFLES",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xe7",
         "EventName": "INT_VEC_RETIRED.SHUFFLES",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "1000003",
         "UMask": "0x40",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "INT_VEC_RETIRED.VNNI_128",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xe7",
         "EventName": "INT_VEC_RETIRED.VNNI_128",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "1000003",
         "UMask": "0x10",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "INT_VEC_RETIRED.VNNI_256",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xe7",
         "EventName": "INT_VEC_RETIRED.VNNI_256",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "1000003",
         "UMask": "0x20",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
LD_BLOCKS.ADDRESS_ALIAS",
+        "Deprecated": "1",
+        "EventCode": "0x03",
+        "EventName": "LD_BLOCKS.4K_ALIAS",
+        "PEBS": "1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x4",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of retired loads that are b=
locked because it initially appears to be store forward blocked, but subseq=
uently is shown not to be blocked based on 4K alias check.",
+        "EventCode": "0x03",
+        "EventName": "LD_BLOCKS.ADDRESS_ALIAS",
+        "PEBS": "1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x4",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "False dependencies in MOB due to partial comp=
are on address.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x03",
         "EventName": "LD_BLOCKS.ADDRESS_ALIAS",
-        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts the number of times a load got blocke=
d due to false dependencies in MOB due to partial compare on address.",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0x4",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts the number of retired loads that are b=
locked because its address exactly matches an older store whose data is not=
 ready.",
+        "EventCode": "0x03",
+        "EventName": "LD_BLOCKS.DATA_UNKNOWN",
+        "PEBS": "1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "The number of times that split load operation=
s are temporarily blocked because all resources for handling the split acce=
sses are in use.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x03",
         "EventName": "LD_BLOCKS.NO_SR",
-        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts the number of times that split load o=
perations are temporarily blocked because all resources for handling the sp=
lit accesses are in use.",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0x88",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Loads blocked due to overlapping with a prece=
ding store that cannot be forwarded.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x03",
         "EventName": "LD_BLOCKS.STORE_FORWARD",
-        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts the number of times where store forwa=
rding was prevented for a load operation. The most common case is a load bl=
ocked due to the address of memory access (partially) overlapping with a pr=
eceding uncompleted store. Note: See the table of not supported store forwa=
rds in the Optimization Guide.",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0x82",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Counts the number of demand load dispatches t=
hat hit L1D fill buffer (FB) allocated for software prefetch.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x4c",
         "EventName": "LOAD_HIT_PREFETCH.SWPF",
-        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts all not software-prefetch load dispat=
ches that hit the fill buffer (FB) allocated for the software prefetch. It =
can also be incremented by some lock instructions. So it should only be use=
d with profiling so that the locks can be excluded by ASM (Assembly File) i=
nspection of the nearby instructions.",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0x1",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Cycles Uops delivered by the LSD, but didn't =
come from the decoder.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
         "EventCode": "0xa8",
         "EventName": "LSD.CYCLES_ACTIVE",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts the cycles when at least one uop is d=
elivered by the LSD (Loop-stream detector).",
         "SampleAfterValue": "2000003",
-        "Speculative": "1",
         "UMask": "0x1",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Cycles optimal number of Uops delivered by th=
e LSD, but did not come from the decoder.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "CounterMask": "6",
         "EventCode": "0xa8",
         "EventName": "LSD.CYCLES_OK",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts the cycles when optimal number of uop=
s is delivered by the LSD (Loop-stream detector).",
         "SampleAfterValue": "2000003",
-        "Speculative": "1",
         "UMask": "0x1",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Number of Uops delivered by the LSD.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
-        "EventCode": "0xa8",
-        "EventName": "LSD.UOPS",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
-        "SampleAfterValue": "2000003",
-        "Speculative": "1",
-        "UMask": "0x1",
-        "Unit": "cpu_core"
+        "BriefDescription": "Number of Uops delivered by the LSD.",
+        "EventCode": "0xa8",
+        "EventName": "LSD.UOPS",
+        "PublicDescription": "Counts the number of uops delivered to the b=
ack-end by the LSD(Loop Stream Detector).",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x1",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Number of machine clears (nukes) of any type.=
",
+        "CounterMask": "1",
+        "EdgeDetect": "1",
+        "EventCode": "0xc3",
+        "EventName": "MACHINE_CLEARS.COUNT",
+        "PublicDescription": "Counts the number of machine clears (nukes) =
of any type.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Counts the number of machine clears due to me=
mory ordering in which an internal load passes an older store within the sa=
me CPU.",
+        "EventCode": "0xc3",
+        "EventName": "MACHINE_CLEARS.DISAMBIGUATION",
+        "SampleAfterValue": "20003",
+        "UMask": "0x8",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of machines clears due to m=
emory renaming.",
+        "EventCode": "0xc3",
+        "EventName": "MACHINE_CLEARS.MRN_NUKE",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x80",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of machine clears due to a =
page fault.  Counts both I-Side and D-Side (Loads/Stores) page faults.  A p=
age fault occurs when either the page is not present, or an access violatio=
n occurs.",
+        "EventCode": "0xc3",
+        "EventName": "MACHINE_CLEARS.PAGE_FAULT",
+        "SampleAfterValue": "20003",
+        "UMask": "0x20",
+        "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Number of machine clears (nukes) of any type.=
",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
-        "CounterMask": "1",
-        "EdgeDetect": "1",
+        "BriefDescription": "Counts the number of machine clears that flus=
h the pipeline and restart the machine with the use of microcode due to SMC=
, MEMORY_ORDERING, FP_ASSISTS, PAGE_FAULT, DISAMBIGUATION, and FPC_VIRTUAL_=
TRAP.",
         "EventCode": "0xc3",
-        "EventName": "MACHINE_CLEARS.COUNT",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
-        "SampleAfterValue": "100003",
-        "Speculative": "1",
+        "EventName": "MACHINE_CLEARS.SLOW",
+        "SampleAfterValue": "20003",
+        "UMask": "0x6f",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of machine clears due to pr=
ogram modifying data (self modifying code) within 1K of a recently fetched =
code page.",
+        "EventCode": "0xc3",
+        "EventName": "MACHINE_CLEARS.SMC",
+        "SampleAfterValue": "20003",
         "UMask": "0x1",
-        "Unit": "cpu_core"
+        "Unit": "cpu_atom"
     },
     {
         "BriefDescription": "Self-modifying code (SMC) detected.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc3",
         "EventName": "MACHINE_CLEARS.SMC",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts self-modifying code (SMC) detected, w=
hich causes a machine clear.",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0x4",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "MISC2_RETIRED.LFENCE",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xe0",
         "EventName": "MISC2_RETIRED.LFENCE",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "400009",
-        "Speculative": "1",
         "UMask": "0x20",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Increments whenever there is an update to the=
 LBR array.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xcc",
         "EventName": "MISC_RETIRED.LBR_INSERTS",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Increments when an entry is added to the Las=
t Branch Record (LBR) array (or removed from the array in case of RETURNs i=
n call stack mode). The event requires LBR enable via IA32_DEBUGCTL MSR and=
 branch type selection via MSR_LBR_SELECT.",
         "SampleAfterValue": "100003",
         "UMask": "0x20",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Cycles stalled due to no store buffers availa=
ble. (not including draining form sync).",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xa2",
         "EventName": "RESOURCE_STALLS.SB",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts allocation stall cycles caused by the=
 store buffer (SB) being full. This counts cycles that the pipeline back-en=
d blocked uop delivery from the front-end.",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0x8",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Counts cycles where the pipeline is stalled d=
ue to serializing operations.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xa2",
         "EventName": "RESOURCE_STALLS.SCOREBOARD",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0x2",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts the number of issue slots not consumed=
 by the backend due to a micro-sequencer (MS) scoreboard, which stalls the =
front-end from issuing from the UROM until a specified older uop retires.",
+        "EventCode": "0x75",
+        "EventName": "SERIALIZATION.NON_C01_MS_SCB",
+        "PublicDescription": "Counts the number of issue slots not consume=
d by the backend due to a micro-sequencer (MS) scoreboard, which stalls the=
 front-end from issuing from the UROM until a specified older uop retires. =
The most commonly executed instruction with an MS scoreboard is PAUSE.",
+        "SampleAfterValue": "200003",
+        "UMask": "0x2",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "TMA slots where no uops were being issued due=
 to lack of back-end resources.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xa4",
         "EventName": "TOPDOWN.BACKEND_BOUND_SLOTS",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Number of slots in TMA method where no micro=
-operations were being issued from front-end to back-end of the machine due=
 to lack of back-end resources.",
         "SampleAfterValue": "10000003",
-        "Speculative": "1",
         "UMask": "0x2",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "TMA slots wasted due to incorrect speculation=
s.",
-        "CollectPEBSRecord": "2",
         "EventCode": "0xa4",
         "EventName": "TOPDOWN.BAD_SPEC_SLOTS",
+        "PublicDescription": "Number of slots of TMA method that were wast=
ed due to incorrect speculation. It covers all types of control-flow or dat=
a-related mis-speculations.",
         "SampleAfterValue": "10000003",
-        "Speculative": "1",
         "UMask": "0x4",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "TMA slots wasted due to incorrect speculation=
 by branch mispredictions",
-        "CollectPEBSRecord": "2",
         "EventCode": "0xa4",
         "EventName": "TOPDOWN.BR_MISPREDICT_SLOTS",
+        "PublicDescription": "Number of TMA slots that were wasted due to =
incorrect speculation by (any type of) branch mispredictions. This event es=
timates number of specualtive operations that were issued but not retired a=
s well as the out-of-order engine recovery past a branch misprediction.",
         "SampleAfterValue": "10000003",
-        "Speculative": "1",
         "UMask": "0x8",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "TOPDOWN.MEMORY_BOUND_SLOTS",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xa4",
         "EventName": "TOPDOWN.MEMORY_BOUND_SLOTS",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "10000003",
-        "Speculative": "1",
         "UMask": "0x10",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "TMA slots available for an unhalted logical p=
rocessor. Fixed counter - architectural event",
-        "CollectPEBSRecord": "2",
-        "Counter": "Fixed counter 3",
         "EventName": "TOPDOWN.SLOTS",
-        "PEBScounters": "35",
+        "PublicDescription": "Number of available slots for an unhalted lo=
gical processor. The event increments by machine-width of the narrowest pip=
eline as employed by the Top-down Microarchitecture Analysis method (TMA). =
The count is distributed among unhalted logical processors (hyper-threads) =
who share the same physical core. Software can use this event as the denomi=
nator for the top-level metrics of the TMA method. This architectural event=
 is counted on a designated fixed counter (Fixed Counter 3).",
         "SampleAfterValue": "10000003",
-        "Speculative": "1",
         "UMask": "0x4",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "TMA slots available for an unhalted logical p=
rocessor. General counter - architectural event",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xa4",
         "EventName": "TOPDOWN.SLOTS_P",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts the number of available slots for an =
unhalted logical processor. The event increments by machine-width of the na=
rrowest pipeline as employed by the Top-down Microarchitecture Analysis met=
hod. The count is distributed among unhalted logical processors (hyper-thre=
ads) who share the same physical core.",
         "SampleAfterValue": "10000003",
-        "Speculative": "1",
         "UMask": "0x1",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts the total number of issue slots that w=
ere not consumed by the backend because allocation is stalled due to a misp=
redicted jump or a machine clear.",
+        "EventCode": "0x73",
+        "EventName": "TOPDOWN_BAD_SPECULATION.ALL",
+        "PublicDescription": "Counts the total number of issue slots that =
were not consumed by the backend because allocation is stalled due to a mis=
predicted jump or a machine clear. Only issue slots wasted due to fast nuke=
s such as memory ordering nukes are counted. Other nukes are not accounted =
for. Counts all issue slots blocked during this recovery window including r=
elevant microcode flows and while uops are not yet available in the instruc=
tion queue (IQ) even if an FE_bound event occurs during this period. Also i=
ncludes the issue slots that were consumed by the backend but were thrown a=
way because they were younger than the mispredict or machine clear.",
+        "SampleAfterValue": "1000003",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of issue slots every cycle =
that were not consumed by the backend due to fast nukes such as memory orde=
ring and memory disambiguation machine clears.",
+        "EventCode": "0x73",
+        "EventName": "TOPDOWN_BAD_SPECULATION.FASTNUKE",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x2",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the total number of issue slots that w=
ere not consumed by the backend because allocation is stalled due to a mach=
ine clear (nuke) of any kind including memory ordering and memory disambigu=
ation.",
+        "EventCode": "0x73",
+        "EventName": "TOPDOWN_BAD_SPECULATION.MACHINE_CLEARS",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x3",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of issue slots every cycle =
that were not consumed by the backend due to branch mispredicts.",
+        "EventCode": "0x73",
+        "EventName": "TOPDOWN_BAD_SPECULATION.MISPREDICT",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x4",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of issue slots every cycle =
that were not consumed by the backend due to a machine clear (nuke).",
+        "EventCode": "0x73",
+        "EventName": "TOPDOWN_BAD_SPECULATION.NUKE",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the total number of issue slots every =
cycle that were not consumed by the backend due to backend stalls.",
+        "EventCode": "0x74",
+        "EventName": "TOPDOWN_BE_BOUND.ALL",
+        "SampleAfterValue": "1000003",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of issue slots every cycle =
that were not consumed by the backend due to certain allocation restriction=
s.",
+        "EventCode": "0x74",
+        "EventName": "TOPDOWN_BE_BOUND.ALLOC_RESTRICTIONS",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of issue slots every cycle =
that were not consumed by the backend due to memory reservation stalls in w=
hich a scheduler is not able to accept uops.",
+        "EventCode": "0x74",
+        "EventName": "TOPDOWN_BE_BOUND.MEM_SCHEDULER",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x2",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of issue slots every cycle =
that were not consumed by the backend due to IEC or FPC RAT stalls, which c=
an be due to FIQ or IEC reservation stalls in which the integer, floating p=
oint or SIMD scheduler is not able to accept uops.",
+        "EventCode": "0x74",
+        "EventName": "TOPDOWN_BE_BOUND.NON_MEM_SCHEDULER",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x8",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of issue slots every cycle =
that were not consumed by the backend due to the physical register file una=
ble to accept an entry (marble stalls).",
+        "EventCode": "0x74",
+        "EventName": "TOPDOWN_BE_BOUND.REGISTER",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x20",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of issue slots every cycle =
that were not consumed by the backend due to the reorder buffer being full =
(ROB stalls).",
+        "EventCode": "0x74",
+        "EventName": "TOPDOWN_BE_BOUND.REORDER_BUFFER",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x40",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of issue slots every cycle =
that were not consumed by the backend due to scoreboards from the instructi=
on queue (IQ), jump execution unit (JEU), or microcode sequencer (MS).",
+        "EventCode": "0x74",
+        "EventName": "TOPDOWN_BE_BOUND.SERIALIZATION",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x10",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the total number of issue slots every =
cycle that were not consumed by the backend due to frontend stalls.",
+        "EventCode": "0x71",
+        "EventName": "TOPDOWN_FE_BOUND.ALL",
+        "SampleAfterValue": "1000003",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of issue slots every cycle =
that were not delivered by the frontend due to BACLEARS.",
+        "EventCode": "0x71",
+        "EventName": "TOPDOWN_FE_BOUND.BRANCH_DETECT",
+        "PublicDescription": "Counts the number of issue slots every cycle=
 that were not delivered by the frontend due to BACLEARS, which occurs when=
 the Branch Target Buffer (BTB) prediction or lack thereof, was corrected b=
y a later branch predictor in the frontend. Includes BACLEARS due to all br=
anch types including conditional and unconditional jumps, returns, and indi=
rect branches.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x2",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of issue slots every cycle =
that were not delivered by the frontend due to BTCLEARS.",
+        "EventCode": "0x71",
+        "EventName": "TOPDOWN_FE_BOUND.BRANCH_RESTEER",
+        "PublicDescription": "Counts the number of issue slots every cycle=
 that were not delivered by the frontend due to BTCLEARS, which occurs when=
 the Branch Target Buffer (BTB) predicts a taken branch.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x40",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of issue slots every cycle =
that were not delivered by the frontend due to the microcode sequencer (MS)=
.",
+        "EventCode": "0x71",
+        "EventName": "TOPDOWN_FE_BOUND.CISC",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of issue slots every cycle =
that were not delivered by the frontend due to decode stalls.",
+        "EventCode": "0x71",
+        "EventName": "TOPDOWN_FE_BOUND.DECODE",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x8",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of issue slots every cycle =
that were not delivered by the frontend due to frontend bandwidth restricti=
ons due to decode, predecode, cisc, and other limitations.",
+        "EventCode": "0x71",
+        "EventName": "TOPDOWN_FE_BOUND.FRONTEND_BANDWIDTH",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x8d",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of issue slots every cycle =
that were not delivered by the frontend due to a latency related stalls inc=
luding BACLEARs, BTCLEARs, ITLB misses, and ICache misses.",
+        "EventCode": "0x71",
+        "EventName": "TOPDOWN_FE_BOUND.FRONTEND_LATENCY",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x72",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of issue slots every cycle =
that were not delivered by the frontend due to ITLB misses.",
+        "EventCode": "0x71",
+        "EventName": "TOPDOWN_FE_BOUND.ITLB",
+        "PublicDescription": "Counts the number of issue slots every cycle=
 that were not delivered by the frontend due to Instruction Table Lookaside=
 Buffer (ITLB) misses.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x10",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of issue slots every cycle =
that were not delivered by the frontend due to other common frontend stalls=
 not categorized.",
+        "EventCode": "0x71",
+        "EventName": "TOPDOWN_FE_BOUND.OTHER",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x80",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of issue slots every cycle =
that were not delivered by the frontend due to wrong predecodes.",
+        "EventCode": "0x71",
+        "EventName": "TOPDOWN_FE_BOUND.PREDECODE",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x4",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the total number of consumed retiremen=
t slots.",
+        "EventCode": "0xc2",
+        "EventName": "TOPDOWN_RETIRING.ALL",
+        "PEBS": "1",
+        "SampleAfterValue": "1000003",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "UOPS_DECODED.DEC0_UOPS",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x76",
         "EventName": "UOPS_DECODED.DEC0_UOPS",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "1000003",
-        "Speculative": "1",
         "UMask": "0x1",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Uops executed on port 0",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xb2",
         "EventName": "UOPS_DISPATCHED.PORT_0",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Number of uops dispatch to execution  port 0=
.",
         "SampleAfterValue": "2000003",
-        "Speculative": "1",
         "UMask": "0x1",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Uops executed on port 1",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xb2",
         "EventName": "UOPS_DISPATCHED.PORT_1",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Number of uops dispatch to execution  port 1=
.",
         "SampleAfterValue": "2000003",
-        "Speculative": "1",
         "UMask": "0x2",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Uops executed on ports 2, 3 and 10",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xb2",
         "EventName": "UOPS_DISPATCHED.PORT_2_3_10",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Number of uops dispatch to execution ports 2=
, 3 and 10",
         "SampleAfterValue": "2000003",
-        "Speculative": "1",
         "UMask": "0x4",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Uops executed on ports 4 and 9",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xb2",
         "EventName": "UOPS_DISPATCHED.PORT_4_9",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Number of uops dispatch to execution ports 4=
 and 9",
         "SampleAfterValue": "2000003",
-        "Speculative": "1",
         "UMask": "0x10",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Uops executed on ports 5 and 11",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xb2",
         "EventName": "UOPS_DISPATCHED.PORT_5_11",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Number of uops dispatch to execution ports 5=
 and 11",
         "SampleAfterValue": "2000003",
-        "Speculative": "1",
         "UMask": "0x20",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Uops executed on port 6",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xb2",
         "EventName": "UOPS_DISPATCHED.PORT_6",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Number of uops dispatch to execution  port 6=
.",
         "SampleAfterValue": "2000003",
-        "Speculative": "1",
         "UMask": "0x40",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Uops executed on ports 7 and 8",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xb2",
         "EventName": "UOPS_DISPATCHED.PORT_7_8",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Number of uops dispatch to execution  ports =
7 and 8.",
         "SampleAfterValue": "2000003",
-        "Speculative": "1",
         "UMask": "0x80",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Cycles at least 1 micro-op is executed from a=
ny thread on physical core.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
         "EventCode": "0xb1",
         "EventName": "UOPS_EXECUTED.CORE_CYCLES_GE_1",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts cycles when at least 1 micro-op is ex=
ecuted from any thread on physical core.",
         "SampleAfterValue": "2000003",
-        "Speculative": "1",
         "UMask": "0x2",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Cycles at least 2 micro-op is executed from a=
ny thread on physical core.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "CounterMask": "2",
         "EventCode": "0xb1",
         "EventName": "UOPS_EXECUTED.CORE_CYCLES_GE_2",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts cycles when at least 2 micro-ops are =
executed from any thread on physical core.",
         "SampleAfterValue": "2000003",
-        "Speculative": "1",
         "UMask": "0x2",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Cycles at least 3 micro-op is executed from a=
ny thread on physical core.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "CounterMask": "3",
         "EventCode": "0xb1",
         "EventName": "UOPS_EXECUTED.CORE_CYCLES_GE_3",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts cycles when at least 3 micro-ops are =
executed from any thread on physical core.",
         "SampleAfterValue": "2000003",
-        "Speculative": "1",
         "UMask": "0x2",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Cycles at least 4 micro-op is executed from a=
ny thread on physical core.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "CounterMask": "4",
         "EventCode": "0xb1",
         "EventName": "UOPS_EXECUTED.CORE_CYCLES_GE_4",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts cycles when at least 4 micro-ops are =
executed from any thread on physical core.",
         "SampleAfterValue": "2000003",
-        "Speculative": "1",
         "UMask": "0x2",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Cycles where at least 1 uop was executed per-=
thread",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
         "EventCode": "0xb1",
         "EventName": "UOPS_EXECUTED.CYCLES_GE_1",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Cycles where at least 1 uop was executed per=
-thread.",
         "SampleAfterValue": "2000003",
-        "Speculative": "1",
         "UMask": "0x1",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Cycles where at least 2 uops were executed pe=
r-thread",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "CounterMask": "2",
         "EventCode": "0xb1",
         "EventName": "UOPS_EXECUTED.CYCLES_GE_2",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Cycles where at least 2 uops were executed p=
er-thread.",
         "SampleAfterValue": "2000003",
-        "Speculative": "1",
         "UMask": "0x1",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Cycles where at least 3 uops were executed pe=
r-thread",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "CounterMask": "3",
         "EventCode": "0xb1",
         "EventName": "UOPS_EXECUTED.CYCLES_GE_3",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Cycles where at least 3 uops were executed p=
er-thread.",
         "SampleAfterValue": "2000003",
-        "Speculative": "1",
         "UMask": "0x1",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Cycles where at least 4 uops were executed pe=
r-thread",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "CounterMask": "4",
         "EventCode": "0xb1",
         "EventName": "UOPS_EXECUTED.CYCLES_GE_4",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Cycles where at least 4 uops were executed p=
er-thread.",
         "SampleAfterValue": "2000003",
-        "Speculative": "1",
         "UMask": "0x1",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Counts number of cycles no uops were dispatch=
ed to be executed on this thread.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
         "EventCode": "0xb1",
         "EventName": "UOPS_EXECUTED.STALLS",
         "Invert": "1",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts cycles during which no uops were disp=
atched from the Reservation Station (RS) per thread.",
         "SampleAfterValue": "2000003",
-        "Speculative": "1",
         "UMask": "0x1",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "This event is deprecated. Refer to new event =
UOPS_EXECUTED.STALLS",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
+        "Deprecated": "1",
         "EventCode": "0xb1",
         "EventName": "UOPS_EXECUTED.STALL_CYCLES",
         "Invert": "1",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "2000003",
-        "Speculative": "1",
         "UMask": "0x1",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Counts the number of uops to be executed per-=
thread each cycle.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xb1",
         "EventName": "UOPS_EXECUTED.THREAD",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "2000003",
-        "Speculative": "1",
         "UMask": "0x1",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Counts the number of x87 uops dispatched.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xb1",
         "EventName": "UOPS_EXECUTED.X87",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts the number of x87 uops executed.",
         "SampleAfterValue": "2000003",
-        "Speculative": "1",
         "UMask": "0x10",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Uops that RAT issues to RS",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xae",
         "EventName": "UOPS_ISSUED.ANY",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts the number of uops that the Resource =
Allocation Table (RAT) issues to the Reservation Station (RS).",
         "SampleAfterValue": "2000003",
-        "Speculative": "1",
         "UMask": "0x1",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts the total number of uops retired.",
+        "EventCode": "0xc2",
+        "EventName": "UOPS_RETIRED.ALL",
+        "PEBS": "1",
+        "SampleAfterValue": "2000003",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Cycles with retired uop(s).",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
         "EventCode": "0xc2",
         "EventName": "UOPS_RETIRED.CYCLES",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts cycles where at least one uop has ret=
ired.",
         "SampleAfterValue": "1000003",
         "UMask": "0x2",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Retired uops except the last uop of each inst=
ruction.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc2",
         "EventName": "UOPS_RETIRED.HEAVY",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts the number of retired micro-operation=
s (uops) except the last uop of each instruction. An instruction that is de=
coded into less than two uops does not contribute to the count.",
         "SampleAfterValue": "2000003",
         "UMask": "0x1",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts the number of integer divide uops reti=
red.",
+        "EventCode": "0xc2",
+        "EventName": "UOPS_RETIRED.IDIV",
+        "PEBS": "1",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x10",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of uops that are from compl=
ex flows issued by the micro-sequencer (MS).",
+        "EventCode": "0xc2",
+        "EventName": "UOPS_RETIRED.MS",
+        "PEBS": "1",
+        "PublicDescription": "Counts the number of uops that are from comp=
lex flows issued by the Microcode Sequencer (MS). This includes uops from f=
lows due to complex instructions, faults, assists, and inserted flows.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x1",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "UOPS_RETIRED.MS",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc2",
         "EventName": "UOPS_RETIRED.MS",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x8",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "2000003",
-        "TakenAlone": "1",
         "UMask": "0x4",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Retirement slots used.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc2",
         "EventName": "UOPS_RETIRED.SLOTS",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts the retirement slots used each cycle.=
",
         "SampleAfterValue": "2000003",
         "UMask": "0x2",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Cycles without actually retired uops.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
         "EventCode": "0xc2",
         "EventName": "UOPS_RETIRED.STALLS",
         "Invert": "1",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "This event counts cycles without actually re=
tired uops.",
         "SampleAfterValue": "1000003",
         "UMask": "0x2",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "This event is deprecated. Refer to new event =
UOPS_RETIRED.STALLS",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
+        "Deprecated": "1",
         "EventCode": "0xc2",
         "EventName": "UOPS_RETIRED.STALL_CYCLES",
         "Invert": "1",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "1000003",
         "UMask": "0x2",
         "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Counts the number of x87 uops retired, includ=
es those in MS flows.",
+        "EventCode": "0xc2",
+        "EventName": "UOPS_RETIRED.X87",
+        "PEBS": "1",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x2",
+        "Unit": "cpu_atom"
     }
 ]
diff --git a/tools/perf/pmu-events/arch/x86/alderlake/uncore-memory.json b/=
tools/perf/pmu-events/arch/x86/alderlake/uncore-memory.json
index d82d6f62a6fb..2ccd9cf96957 100644
--- a/tools/perf/pmu-events/arch/x86/alderlake/uncore-memory.json
+++ b/tools/perf/pmu-events/arch/x86/alderlake/uncore-memory.json
@@ -1,221 +1,174 @@
 [
     {
-        "BriefDescription": "Number of clocks",
-        "Counter": "0,1,2,3,4",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x01",
-        "EventName": "UNC_M_CLOCKTICKS",
+        "BriefDescription": "Counts every 64B read  request entering the M=
emory Controller 0 to DRAM (sum of all channels).",
+        "EventName": "UNC_MC0_RDCAS_COUNT_FREERUN",
         "PerPkg": "1",
+        "PublicDescription": "Counts every 64B read request entering the M=
emory Controller 0 to DRAM (sum of all channels).",
         "Unit": "iMC"
     },
     {
-        "BriefDescription": "Incoming VC0 read request",
-        "Counter": "0,1,2,3,4",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x02",
-        "EventName": "UNC_M_VC0_REQUESTS_RD",
+        "BriefDescription": "Counts every 64B write request entering the M=
emory Controller 0 to DRAM (sum of all channels). Each write request counts=
 as a new request incrementing this counter. However, same cache line write=
 requests (both full and partial) are combined to a single 64 byte data tra=
nsfer to DRAM.",
+        "EventName": "UNC_MC0_WRCAS_COUNT_FREERUN",
         "PerPkg": "1",
         "Unit": "iMC"
     },
     {
-        "BriefDescription": "Incoming VC0 write request",
-        "Counter": "0,1,2,3,4",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x03",
-        "EventName": "UNC_M_VC0_REQUESTS_WR",
+        "BriefDescription": "Counts every 64B read request entering the Me=
mory Controller 1 to DRAM (sum of all channels).",
+        "EventName": "UNC_MC1_RDCAS_COUNT_FREERUN",
         "PerPkg": "1",
+        "PublicDescription": "Counts every 64B read entering the Memory Co=
ntroller 1 to DRAM (sum of all channels).",
         "Unit": "iMC"
     },
     {
-        "BriefDescription": "Incoming VC1 read request",
-        "Counter": "0,1,2,3,4",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x04",
-        "EventName": "UNC_M_VC1_REQUESTS_RD",
+        "BriefDescription": "Counts every 64B write request entering the M=
emory Controller 1 to DRAM (sum of all channels). Each write request counts=
 as a new request incrementing this counter. However, same cache line write=
 requests (both full and partial) are combined to a single 64 byte data tra=
nsfer to DRAM.",
+        "EventName": "UNC_MC1_WRCAS_COUNT_FREERUN",
         "PerPkg": "1",
         "Unit": "iMC"
     },
     {
-        "BriefDescription": "Incoming VC1 write request",
-        "Counter": "0,1,2,3,4",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x05",
-        "EventName": "UNC_M_VC1_REQUESTS_WR",
+        "BriefDescription": "ACT command for a read request sent to DRAM",
+        "EventCode": "0x24",
+        "EventName": "UNC_M_ACT_COUNT_RD",
         "PerPkg": "1",
         "Unit": "iMC"
     },
     {
-        "BriefDescription": "Incoming read prefetch request from IA",
-        "Counter": "0,1,2,3,4",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x0A",
-        "EventName": "UNC_M_PREFETCH_RD",
+        "BriefDescription": "ACT command sent to DRAM",
+        "EventCode": "0x26",
+        "EventName": "UNC_M_ACT_COUNT_TOTAL",
         "PerPkg": "1",
         "Unit": "iMC"
     },
     {
-        "BriefDescription": "Any Rank at Hot state",
-        "Counter": "0,1,2,3,4",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x19",
-        "EventName": "UNC_M_DRAM_THERMAL_HOT",
+        "BriefDescription": "ACT command for a write request sent to DRAM",
+        "EventCode": "0x25",
+        "EventName": "UNC_M_ACT_COUNT_WR",
         "PerPkg": "1",
         "Unit": "iMC"
     },
     {
-        "BriefDescription": "Any Rank at Warm state",
-        "Counter": "0,1,2,3,4",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x1A",
-        "EventName": "UNC_M_DRAM_THERMAL_WARM",
+        "BriefDescription": "Read CAS command sent to DRAM",
+        "EventCode": "0x22",
+        "EventName": "UNC_M_CAS_COUNT_RD",
         "PerPkg": "1",
         "Unit": "iMC"
     },
     {
-        "BriefDescription": "incoming read request page status is Page Hit=
",
-        "Counter": "0,1,2,3,4",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x1C",
-        "EventName": "UNC_M_DRAM_PAGE_HIT_RD",
+        "BriefDescription": "Write CAS command sent to DRAM",
+        "EventCode": "0x23",
+        "EventName": "UNC_M_CAS_COUNT_WR",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Number of clocks",
+        "EventCode": "0x01",
+        "EventName": "UNC_M_CLOCKTICKS",
         "PerPkg": "1",
         "Unit": "iMC"
     },
     {
         "BriefDescription": "incoming read request page status is Page Emp=
ty",
-        "Counter": "0,1,2,3,4",
-        "CounterType": "PGMABLE",
         "EventCode": "0x1D",
         "EventName": "UNC_M_DRAM_PAGE_EMPTY_RD",
         "PerPkg": "1",
         "Unit": "iMC"
     },
     {
-        "BriefDescription": "incoming read request page status is Page Mis=
s",
-        "Counter": "0,1,2,3,4",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x1E",
-        "EventName": "UNC_M_DRAM_PAGE_MISS_RD",
+        "BriefDescription": "incoming write request page status is Page Em=
pty",
+        "EventCode": "0x20",
+        "EventName": "UNC_M_DRAM_PAGE_EMPTY_WR",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "incoming read request page status is Page Hit=
",
+        "EventCode": "0x1C",
+        "EventName": "UNC_M_DRAM_PAGE_HIT_RD",
         "PerPkg": "1",
         "Unit": "iMC"
     },
     {
         "BriefDescription": "incoming write request page status is Page Hi=
t",
-        "Counter": "0,1,2,3,4",
-        "CounterType": "PGMABLE",
         "EventCode": "0x1F",
         "EventName": "UNC_M_DRAM_PAGE_HIT_WR",
         "PerPkg": "1",
         "Unit": "iMC"
     },
     {
-        "BriefDescription": "incoming write request page status is Page Em=
pty",
-        "Counter": "0,1,2,3,4",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x20",
-        "EventName": "UNC_M_DRAM_PAGE_EMPTY_WR",
+        "BriefDescription": "incoming read request page status is Page Mis=
s",
+        "EventCode": "0x1E",
+        "EventName": "UNC_M_DRAM_PAGE_MISS_RD",
         "PerPkg": "1",
         "Unit": "iMC"
     },
     {
         "BriefDescription": "incoming write request page status is Page Mi=
ss",
-        "Counter": "0,1,2,3,4",
-        "CounterType": "PGMABLE",
         "EventCode": "0x21",
         "EventName": "UNC_M_DRAM_PAGE_MISS_WR",
         "PerPkg": "1",
         "Unit": "iMC"
     },
     {
-        "BriefDescription": "Read CAS command sent to DRAM",
-        "Counter": "0,1,2,3,4",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x22",
-        "EventName": "UNC_M_CAS_COUNT_RD",
-        "PerPkg": "1",
-        "Unit": "iMC"
-    },
-    {
-        "BriefDescription": "Write CAS command sent to DRAM",
-        "Counter": "0,1,2,3,4",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x23",
-        "EventName": "UNC_M_CAS_COUNT_WR",
+        "BriefDescription": "Any Rank at Hot state",
+        "EventCode": "0x19",
+        "EventName": "UNC_M_DRAM_THERMAL_HOT",
         "PerPkg": "1",
         "Unit": "iMC"
     },
     {
-        "BriefDescription": "ACT command for a read request sent to DRAM",
-        "Counter": "0,1,2,3,4",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x24",
-        "EventName": "UNC_M_ACT_COUNT_RD",
+        "BriefDescription": "Any Rank at Warm state",
+        "EventCode": "0x1A",
+        "EventName": "UNC_M_DRAM_THERMAL_WARM",
         "PerPkg": "1",
         "Unit": "iMC"
     },
     {
-        "BriefDescription": "ACT command for a write request sent to DRAM",
-        "Counter": "0,1,2,3,4",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x25",
-        "EventName": "UNC_M_ACT_COUNT_WR",
+        "BriefDescription": "Incoming read prefetch request from IA.",
+        "EventCode": "0x0A",
+        "EventName": "UNC_M_PREFETCH_RD",
         "PerPkg": "1",
         "Unit": "iMC"
     },
     {
-        "BriefDescription": "ACT command sent to DRAM",
-        "Counter": "0,1,2,3,4",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x26",
-        "EventName": "UNC_M_ACT_COUNT_TOTAL",
+        "BriefDescription": "PRE command sent to DRAM due to page table id=
le timer expiration",
+        "EventCode": "0x28",
+        "EventName": "UNC_M_PRE_COUNT_IDLE",
         "PerPkg": "1",
         "Unit": "iMC"
     },
     {
         "BriefDescription": "PRE command sent to DRAM for a read/write req=
uest",
-        "Counter": "0,1,2,3,4",
-        "CounterType": "PGMABLE",
         "EventCode": "0x27",
         "EventName": "UNC_M_PRE_COUNT_PAGE_MISS",
         "PerPkg": "1",
         "Unit": "iMC"
     },
     {
-        "BriefDescription": "PRE command sent to DRAM due to page table id=
le timer expiration",
-        "Counter": "0,1,2,3,4",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x28",
-        "EventName": "UNC_M_PRE_COUNT_IDLE",
-        "PerPkg": "1",
-        "Unit": "iMC"
-    },
-    {
-        "BriefDescription": "Counts every 64B read  request entering the M=
emory Controller 0 to DRAM (sum of all channels)",
-        "CounterType": "FREERUN",
-        "EventName": "UNC_MC0_RDCAS_COUNT_FREERUN",
+        "BriefDescription": "Incoming VC0 read request",
+        "EventCode": "0x02",
+        "EventName": "UNC_M_VC0_REQUESTS_RD",
         "PerPkg": "1",
         "Unit": "iMC"
     },
     {
-        "BriefDescription": "Counts every 64B read request entering the Me=
mory Controller 1 to DRAM (sum of all channels)",
-        "Counter": "3",
-        "CounterType": "FREERUN",
-        "EventName": "UNC_MC1_RDCAS_COUNT_FREERUN",
+        "BriefDescription": "Incoming VC0 write request",
+        "EventCode": "0x03",
+        "EventName": "UNC_M_VC0_REQUESTS_WR",
         "PerPkg": "1",
         "Unit": "iMC"
     },
     {
-        "BriefDescription": "Counts every 64B write request entering the M=
emory Controller 0 to DRAM (sum of all channels). Each write request counts=
 as a new request incrementing this counter. However, same cache line write=
 requests (both full and partial) are combined to a single 64 byte data tra=
nsfer to DRAM",
-        "Counter": "1",
-        "CounterType": "FREERUN",
-        "EventName": "UNC_MC0_WRCAS_COUNT_FREERUN",
+        "BriefDescription": "Incoming VC1 read request",
+        "EventCode": "0x04",
+        "EventName": "UNC_M_VC1_REQUESTS_RD",
         "PerPkg": "1",
         "Unit": "iMC"
     },
     {
-        "BriefDescription": "Counts every 64B write request entering the M=
emory Controller 1 to DRAM (sum of all channels). Each write request counts=
 as a new request incrementing this counter. However, same cache line write=
 requests (both full and partial) are combined to a single 64 byte data tra=
nsfer to DRAM",
-        "Counter": "4",
-        "CounterType": "FREERUN",
-        "EventName": "UNC_MC1_WRCAS_COUNT_FREERUN",
+        "BriefDescription": "Incoming VC1 write request",
+        "EventCode": "0x05",
+        "EventName": "UNC_M_VC1_REQUESTS_WR",
         "PerPkg": "1",
         "Unit": "iMC"
     }
diff --git a/tools/perf/pmu-events/arch/x86/alderlake/uncore-other.json b/t=
ools/perf/pmu-events/arch/x86/alderlake/uncore-other.json
index b1ae349f5f21..bc5fb6b76065 100644
--- a/tools/perf/pmu-events/arch/x86/alderlake/uncore-other.json
+++ b/tools/perf/pmu-events/arch/x86/alderlake/uncore-other.json
@@ -1,40 +1,73 @@
 [
     {
-        "BriefDescription": "This 48-bit fixed counter counts the UCLK cyc=
les",
-        "Counter": "Fixed",
-        "CounterType": "PGMABLE",
-        "EventCode": "0xff",
-        "EventName": "UNC_CLOCK.SOCKET",
+        "BriefDescription": "Number of requests allocated in Coherency Tra=
cker.",
+        "EventCode": "0x84",
+        "EventName": "UNC_ARB_COH_TRK_REQUESTS.ALL",
         "PerPkg": "1",
-        "Unit": "CLOCK"
+        "UMask": "0x1",
+        "Unit": "ARB"
     },
     {
-        "BriefDescription": "Counts the number of coherent and in-coherent=
 requests initiated by IA cores, processor graphic units, or LLC",
-        "Counter": "0,1",
-        "CounterType": "PGMABLE",
+        "BriefDescription": "Each cycle counts number of any coherent requ=
est at memory controller that were issued by any core.",
+        "EventCode": "0x85",
+        "EventName": "UNC_ARB_DAT_OCCUPANCY.ALL",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "ARB"
+    },
+    {
+        "BriefDescription": "Each cycle counts number of coherent reads pe=
nding on data return from memory controller that were issued by any core.",
+        "EventCode": "0x85",
+        "EventName": "UNC_ARB_DAT_OCCUPANCY.RD",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "ARB"
+    },
+    {
+        "BriefDescription": "Number of coherent read requests sent to memo=
ry controller that were issued by any core.",
         "EventCode": "0x81",
-        "EventName": "UNC_ARB_TRK_REQUESTS.ALL",
+        "EventName": "UNC_ARB_DAT_REQUESTS.RD",
         "PerPkg": "1",
-        "UMask": "0x01",
+        "UMask": "0x2",
         "Unit": "ARB"
     },
     {
-        "BriefDescription": "Number of requests allocated in Coherency Tra=
cker",
-        "Counter": "0,1",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x84",
-        "EventName": "UNC_ARB_COH_TRK_REQUESTS.ALL",
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_ARB_DAT_OCCUPANCY.ALL",
+        "EventCode": "0x85",
+        "EventName": "UNC_ARB_IFA_OCCUPANCY.ALL",
         "PerPkg": "1",
-        "UMask": "0x01",
+        "UMask": "0x1",
         "Unit": "ARB"
     },
     {
-        "BriefDescription": "Each cycle counts number of all outgoing vali=
d entries in ReqTrk. Such entry is defined as valid from its allocation in =
ReqTrk till deallocation. Accounts for Coherent and non-coherent traffic",
-        "CounterType": "PGMABLE",
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_ARB_DAT_REQUESTS.RD",
+        "EventCode": "0x81",
+        "EventName": "UNC_ARB_REQ_TRK_REQUEST.DRD",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "ARB"
+    },
+    {
+        "BriefDescription": "Each cycle counts number of all outgoing vali=
d entries in ReqTrk. Such entry is defined as valid from its allocation in =
ReqTrk till deallocation. Accounts for Coherent and non-coherent traffic.",
         "EventCode": "0x80",
         "EventName": "UNC_ARB_TRK_OCCUPANCY.ALL",
         "PerPkg": "1",
-        "UMask": "0x01",
+        "UMask": "0x1",
         "Unit": "ARB"
+    },
+    {
+        "BriefDescription": "Counts the number of coherent and in-coherent=
 requests initiated by IA cores, processor graphic units, or LLC.",
+        "EventCode": "0x81",
+        "EventName": "UNC_ARB_TRK_REQUESTS.ALL",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "ARB"
+    },
+    {
+        "BriefDescription": "This 48-bit fixed counter counts the UCLK cyc=
les.",
+        "EventCode": "0xff",
+        "EventName": "UNC_CLOCK.SOCKET",
+        "PerPkg": "1",
+        "Unit": "CLOCK"
     }
 ]
diff --git a/tools/perf/pmu-events/arch/x86/alderlake/virtual-memory.json b=
/tools/perf/pmu-events/arch/x86/alderlake/virtual-memory.json
index 12baf768ad8d..3827d292da80 100644
--- a/tools/perf/pmu-events/arch/x86/alderlake/virtual-memory.json
+++ b/tools/perf/pmu-events/arch/x86/alderlake/virtual-memory.json
@@ -1,317 +1,236 @@
 [
-    {
-        "BriefDescription": "Counts the number of page walks completed due=
 to load DTLB misses to any page size.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5",
-        "EventCode": "0x08",
-        "EventName": "DTLB_LOAD_MISSES.WALK_COMPLETED",
-        "PEBScounters": "0,1,2,3,4,5",
-        "SampleAfterValue": "200003",
-        "Speculative": "1",
-        "UMask": "0xe",
-        "Unit": "cpu_atom"
-    },
-    {
-        "BriefDescription": "Counts the number of page walks completed due=
 to store DTLB misses to any page size.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5",
-        "EventCode": "0x49",
-        "EventName": "DTLB_STORE_MISSES.WALK_COMPLETED",
-        "PEBScounters": "0,1,2,3,4,5",
-        "SampleAfterValue": "2000003",
-        "Speculative": "1",
-        "UMask": "0xe",
-        "Unit": "cpu_atom"
-    },
-    {
-        "BriefDescription": "Counts the number of page walks initiated by =
a instruction fetch that missed the first and second level TLBs.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5",
-        "EventCode": "0x85",
-        "EventName": "ITLB_MISSES.MISS_CAUSED_WALK",
-        "PEBScounters": "0,1,2,3,4,5",
-        "SampleAfterValue": "1000003",
-        "Speculative": "1",
-        "UMask": "0x1",
-        "Unit": "cpu_atom"
-    },
-    {
-        "BriefDescription": "Counts the number of page walks due to an ins=
truction fetch that miss the PDE (Page Directory Entry) cache.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5",
-        "EventCode": "0x85",
-        "EventName": "ITLB_MISSES.PDE_CACHE_MISS",
-        "PEBScounters": "0,1,2,3,4,5",
-        "SampleAfterValue": "2000003",
-        "Speculative": "1",
-        "UMask": "0x80",
-        "Unit": "cpu_atom"
-    },
-    {
-        "BriefDescription": "Counts the number of page walks completed due=
 to instruction fetch misses to any page size.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5",
-        "EventCode": "0x85",
-        "EventName": "ITLB_MISSES.WALK_COMPLETED",
-        "PEBScounters": "0,1,2,3,4,5",
-        "SampleAfterValue": "200003",
-        "Speculative": "1",
-        "UMask": "0xe",
-        "Unit": "cpu_atom"
-    },
-    {
-        "BriefDescription": "Counts the number of cycles that the head (ol=
dest load) of the load buffer and retirement are both stalled due to a DTLB=
 miss.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5",
-        "EventCode": "0x05",
-        "EventName": "LD_HEAD.DTLB_MISS_AT_RET",
-        "PEBScounters": "0,1,2,3,4,5",
-        "SampleAfterValue": "1000003",
-        "Speculative": "1",
-        "UMask": "0x90",
-        "Unit": "cpu_atom"
-    },
     {
         "BriefDescription": "Loads that miss the DTLB and hit the STLB.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x12",
         "EventName": "DTLB_LOAD_MISSES.STLB_HIT",
-        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts loads that miss the DTLB (Data TLB) a=
nd hit the STLB (Second level TLB).",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0x20",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Cycles when at least one PMH is busy with a p=
age walk for a demand load.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "CounterMask": "1",
         "EventCode": "0x12",
         "EventName": "DTLB_LOAD_MISSES.WALK_ACTIVE",
-        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts cycles when at least one PMH (Page Mi=
ss Handler) is busy with a page walk for a demand load.",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0x10",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts the number of page walks completed due=
 to load DTLB misses to any page size.",
+        "EventCode": "0x08",
+        "EventName": "DTLB_LOAD_MISSES.WALK_COMPLETED",
+        "PublicDescription": "Counts the number of page walks completed du=
e to loads (including SW prefetches) whose address translations missed in a=
ll Translation Lookaside Buffer (TLB) levels and were mapped to any page si=
ze. Includes page walks that page fault.",
+        "SampleAfterValue": "200003",
+        "UMask": "0xe",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Load miss in all TLB levels causes a page wal=
k that completes. (All page sizes)",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x12",
         "EventName": "DTLB_LOAD_MISSES.WALK_COMPLETED",
-        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts completed page walks  (all page sizes=
) caused by demand data loads. This implies it missed in the DTLB and furth=
er levels of TLB. The page walk can end with or without a fault.",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0xe",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Page walks completed due to a demand data loa=
d to a 1G page.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x12",
         "EventName": "DTLB_LOAD_MISSES.WALK_COMPLETED_1G",
-        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts completed page walks  (1G sizes) caus=
ed by demand data loads. This implies address translations missed in the DT=
LB and further levels of TLB. The page walk can end with or without a fault=
.",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0x8",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Page walks completed due to a demand data loa=
d to a 2M/4M page.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x12",
         "EventName": "DTLB_LOAD_MISSES.WALK_COMPLETED_2M_4M",
-        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts completed page walks  (2M/4M sizes) c=
aused by demand data loads. This implies address translations missed in the=
 DTLB and further levels of TLB. The page walk can end with or without a fa=
ult.",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0x4",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Page walks completed due to a demand data loa=
d to a 4K page.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x12",
         "EventName": "DTLB_LOAD_MISSES.WALK_COMPLETED_4K",
-        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts completed page walks  (4K sizes) caus=
ed by demand data loads. This implies address translations missed in the DT=
LB and further levels of TLB. The page walk can end with or without a fault=
.",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0x2",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Number of page walks outstanding for a demand=
 load in the PMH each cycle.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x12",
         "EventName": "DTLB_LOAD_MISSES.WALK_PENDING",
-        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts the number of page walks outstanding =
for a demand load in the PMH (Page Miss Handler) each cycle.",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0x10",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Stores that miss the DTLB and hit the STLB.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x13",
         "EventName": "DTLB_STORE_MISSES.STLB_HIT",
-        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts stores that miss the DTLB (Data TLB) =
and hit the STLB (2nd Level TLB).",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0x20",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Cycles when at least one PMH is busy with a p=
age walk for a store.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "CounterMask": "1",
         "EventCode": "0x13",
         "EventName": "DTLB_STORE_MISSES.WALK_ACTIVE",
-        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts cycles when at least one PMH (Page Mi=
ss Handler) is busy with a page walk for a store.",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0x10",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts the number of page walks completed due=
 to store DTLB misses to any page size.",
+        "EventCode": "0x49",
+        "EventName": "DTLB_STORE_MISSES.WALK_COMPLETED",
+        "PublicDescription": "Counts the number of page walks completed du=
e to stores whose address translations missed in all Translation Lookaside =
Buffer (TLB) levels and were mapped to any page size.  Includes page walks =
that page fault.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0xe",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Store misses in all TLB levels causes a page =
walk that completes. (All page sizes)",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x13",
         "EventName": "DTLB_STORE_MISSES.WALK_COMPLETED",
-        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts completed page walks  (all page sizes=
) caused by demand data stores. This implies it missed in the DTLB and furt=
her levels of TLB. The page walk can end with or without a fault.",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0xe",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Page walks completed due to a demand data sto=
re to a 1G page.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x13",
         "EventName": "DTLB_STORE_MISSES.WALK_COMPLETED_1G",
-        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts completed page walks  (1G sizes) caus=
ed by demand data stores. This implies address translations missed in the D=
TLB and further levels of TLB. The page walk can end with or without a faul=
t.",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0x8",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Page walks completed due to a demand data sto=
re to a 2M/4M page.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x13",
         "EventName": "DTLB_STORE_MISSES.WALK_COMPLETED_2M_4M",
-        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts completed page walks  (2M/4M sizes) c=
aused by demand data stores. This implies address translations missed in th=
e DTLB and further levels of TLB. The page walk can end with or without a f=
ault.",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0x4",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Page walks completed due to a demand data sto=
re to a 4K page.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x13",
         "EventName": "DTLB_STORE_MISSES.WALK_COMPLETED_4K",
-        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts completed page walks  (4K sizes) caus=
ed by demand data stores. This implies address translations missed in the D=
TLB and further levels of TLB. The page walk can end with or without a faul=
t.",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0x2",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Number of page walks outstanding for a store =
in the PMH each cycle.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x13",
         "EventName": "DTLB_STORE_MISSES.WALK_PENDING",
-        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts the number of page walks outstanding =
for a store in the PMH (Page Miss Handler) each cycle.",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0x10",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts the number of page walks initiated by =
a instruction fetch that missed the first and second level TLBs.",
+        "EventCode": "0x85",
+        "EventName": "ITLB_MISSES.MISS_CAUSED_WALK",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of page walks due to an ins=
truction fetch that miss the PDE (Page Directory Entry) cache.",
+        "EventCode": "0x85",
+        "EventName": "ITLB_MISSES.PDE_CACHE_MISS",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x80",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Instruction fetch requests that miss the ITLB=
 and hit the STLB.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x11",
         "EventName": "ITLB_MISSES.STLB_HIT",
-        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts instruction fetch requests that miss =
the ITLB (Instruction TLB) and hit the STLB (Second-level TLB).",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0x20",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Cycles when at least one PMH is busy with a p=
age walk for code (instruction fetch) request.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "CounterMask": "1",
         "EventCode": "0x11",
         "EventName": "ITLB_MISSES.WALK_ACTIVE",
-        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts cycles when at least one PMH (Page Mi=
ss Handler) is busy with a page walk for a code (instruction fetch) request=
.",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0x10",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts the number of page walks completed due=
 to instruction fetch misses to any page size.",
+        "EventCode": "0x85",
+        "EventName": "ITLB_MISSES.WALK_COMPLETED",
+        "PublicDescription": "Counts the number of page walks completed du=
e to instruction fetches whose address translations missed in all Translati=
on Lookaside Buffer (TLB) levels and were mapped to any page size.  Include=
s page walks that page fault.",
+        "SampleAfterValue": "200003",
+        "UMask": "0xe",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Code miss in all TLB levels causes a page wal=
k that completes. (All page sizes)",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x11",
         "EventName": "ITLB_MISSES.WALK_COMPLETED",
-        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts completed page walks (all page sizes)=
 caused by a code fetch. This implies it missed in the ITLB (Instruction TL=
B) and further levels of TLB. The page walk can end with or without a fault=
.",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0xe",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Code miss in all TLB levels causes a page wal=
k that completes. (2M/4M)",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x11",
         "EventName": "ITLB_MISSES.WALK_COMPLETED_2M_4M",
-        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts completed page walks (2M/4M page size=
s) caused by a code fetch. This implies it missed in the ITLB (Instruction =
TLB) and further levels of TLB. The page walk can end with or without a fau=
lt.",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0x4",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Code miss in all TLB levels causes a page wal=
k that completes. (4K)",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x11",
         "EventName": "ITLB_MISSES.WALK_COMPLETED_4K",
-        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts completed page walks (4K page sizes) =
caused by a code fetch. This implies it missed in the ITLB (Instruction TLB=
) and further levels of TLB. The page walk can end with or without a fault.=
",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0x2",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Number of page walks outstanding for an outst=
anding code request in the PMH each cycle.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x11",
         "EventName": "ITLB_MISSES.WALK_PENDING",
-        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts the number of page walks outstanding =
for an outstanding code (instruction fetch) request in the PMH (Page Miss H=
andler) each cycle.",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0x10",
         "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Counts the number of cycles that the head (ol=
dest load) of the load buffer and retirement are both stalled due to a DTLB=
 miss.",
+        "EventCode": "0x05",
+        "EventName": "LD_HEAD.DTLB_MISS_AT_RET",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x90",
+        "Unit": "cpu_atom"
     }
 ]
diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-ev=
ents/arch/x86/mapfile.csv
index 78af105ca236..df47462a125f 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -1,5 +1,5 @@
 Family-model,Version,Filename,EventType
-GenuineIntel-6-(97|9A|B7|BA|BF),v1.15,alderlake,core
+GenuineIntel-6-(97|9A|B7|BA|BF),v1.16,alderlake,core
 GenuineIntel-6-BE,v1.16,alderlaken,core
 GenuineIntel-6-(1C|26|27|35|36),v4,bonnell,core
 GenuineIntel-6-(3D|47),v26,broadwell,core
--=20
2.25.1

