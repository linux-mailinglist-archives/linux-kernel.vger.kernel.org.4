Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5524462EEBC
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 08:57:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241325AbiKRH5s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 02:57:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241294AbiKRH5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 02:57:30 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9948C8C0A7;
        Thu, 17 Nov 2022 23:57:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668758237; x=1700294237;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0pt1PgAFbX5gqGtAxAD97Zd8VYi2dhY+QCnWDRNLaw4=;
  b=I8cuhOFzNA0sJGrZoS1G8sbGqnV0/vJu1cK8vCUyacUvuXbo2g4AcToD
   TdZJMgbQkgwmXIKe27jy5q4V66wkf35g5bwucs+F4DF2+127hLuONNQix
   pWcH9ZH7R+swOiRhN5Qx2P6++RLd6wZr9vdoHCMW/rvrunfn8AeQ1n3Z4
   1tdQezDG22XT1cZrlFKLA3mV6rfjlwmPdeX8gu1rcYrjfNwbQzcVVHhS5
   YL11z1+G/f7vnrIjlqAqfdG1pIb9q8HE3yhdXQBcDEyDeUbYgRm9l0R++
   w50p4fUrB2/wkA7/cdb72i4uAI4/gsU5/NVnr0wWAIDDGoBj/XlPAbedh
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="313093196"
X-IronPort-AV: E=Sophos;i="5.96,173,1665471600"; 
   d="scan'208";a="313093196"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2022 23:57:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="634348351"
X-IronPort-AV: E=Sophos;i="5.96,173,1665471600"; 
   d="scan'208";a="634348351"
Received: from zxingrtx.sh.intel.com ([10.239.159.110])
  by orsmga007.jf.intel.com with ESMTP; 17 Nov 2022 23:57:12 -0800
From:   zhengjun.xing@linux.intel.com
To:     acme@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@intel.com, jolsa@kernel.org, namhyung@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        irogers@google.com, ak@linux.intel.com, kan.liang@linux.intel.com,
        zhengjun.xing@linux.intel.com
Subject: [PATCH 5/5] perf vendor events intel: Update events for alderlake
Date:   Fri, 18 Nov 2022 15:57:02 +0800
Message-Id: <20221118075702.40689-5-zhengjun.xing@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221118075702.40689-1-zhengjun.xing@linux.intel.com>
References: <20221118075702.40689-1-zhengjun.xing@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhengjun Xing <zhengjun.xing@linux.intel.com>

Update JSON core/uncore events for alderlake to perf.

Based on ADL JSON event list v1.16:

https://github.com/intel/perfmon/tree/main/ADL/events

Signed-off-by: Zhengjun Xing <zhengjun.xing@linux.intel.com>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
---
 .../pmu-events/arch/x86/alderlake/cache.json  |  91 ++++++++++++--
 .../arch/x86/alderlake/floating-point.json    |   8 ++
 .../arch/x86/alderlake/frontend.json          |  36 ++++++
 .../pmu-events/arch/x86/alderlake/memory.json |  37 ++++++
 .../pmu-events/arch/x86/alderlake/other.json  |   4 +
 .../arch/x86/alderlake/pipeline.json          | 116 ++++++++++++++++++
 .../arch/x86/alderlake/uncore-other.json      |  65 ++++++++--
 .../arch/x86/alderlake/virtual-memory.json    |  23 ++++
 8 files changed, 362 insertions(+), 18 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/alderlake/cache.json b/tools/pe=
rf/pmu-events/arch/x86/alderlake/cache.json
index 2cc62d2779d2..10a3fdc20874 100644
--- a/tools/perf/pmu-events/arch/x86/alderlake/cache.json
+++ b/tools/perf/pmu-events/arch/x86/alderlake/cache.json
@@ -6,6 +6,7 @@
         "EventCode": "0x2e",
         "EventName": "LONGEST_LAT_CACHE.MISS",
         "PEBScounters": "0,1,2,3,4,5",
+        "PublicDescription": "Counts the number of cacheable memory reques=
ts that miss in the Last Level Cache (LLC). Requests include demand loads, =
reads for ownership (RFO), instruction fetches and L1 HW prefetches. If the=
 platform has an L3 cache, the LLC is the L3 cache, otherwise it is the L2 =
cache. Counts on a per core basis.",
         "SampleAfterValue": "200003",
         "Speculative": "1",
         "UMask": "0x41",
@@ -18,6 +19,7 @@
         "EventCode": "0x2e",
         "EventName": "LONGEST_LAT_CACHE.REFERENCE",
         "PEBScounters": "0,1,2,3,4,5",
+        "PublicDescription": "Counts the number of cacheable memory reques=
ts that access the Last Level Cache (LLC). Requests include demand loads, r=
eads for ownership (RFO), instruction fetches and L1 HW prefetches. If the =
platform has an L3 cache, the LLC is the L3 cache, otherwise it is the L2 c=
ache. Counts on a per core basis.",
         "SampleAfterValue": "200003",
         "Speculative": "1",
         "UMask": "0x4f",
@@ -30,6 +32,7 @@
         "EventCode": "0x34",
         "EventName": "MEM_BOUND_STALLS.IFETCH",
         "PEBScounters": "0,1,2,3,4,5",
+        "PublicDescription": "Counts the number of cycles the core is stal=
led due to an instruction cache or translation lookaside buffer (TLB) miss =
which hit in the L2, LLC, DRAM or MMIO (Non-DRAM).",
         "SampleAfterValue": "200003",
         "Speculative": "1",
         "UMask": "0x38",
@@ -42,6 +45,7 @@
         "EventCode": "0x34",
         "EventName": "MEM_BOUND_STALLS.IFETCH_DRAM_HIT",
         "PEBScounters": "0,1,2,3,4,5",
+        "PublicDescription": "Counts the number of cycles the core is stal=
led due to an instruction cache or translation lookaside buffer (TLB) miss =
which hit in DRAM or MMIO (non-DRAM).",
         "SampleAfterValue": "200003",
         "Speculative": "1",
         "UMask": "0x20",
@@ -54,6 +58,7 @@
         "EventCode": "0x34",
         "EventName": "MEM_BOUND_STALLS.IFETCH_L2_HIT",
         "PEBScounters": "0,1,2,3,4,5",
+        "PublicDescription": "Counts the number of cycles the core is stal=
led due to an instruction cache or Translation Lookaside Buffer (TLB) miss =
which hit in the L2 cache.",
         "SampleAfterValue": "200003",
         "Speculative": "1",
         "UMask": "0x8",
@@ -66,6 +71,7 @@
         "EventCode": "0x34",
         "EventName": "MEM_BOUND_STALLS.IFETCH_LLC_HIT",
         "PEBScounters": "0,1,2,3,4,5",
+        "PublicDescription": "Counts the number of cycles the core is stal=
led due to an instruction cache or Translation Lookaside Buffer (TLB) miss =
which hit in the Last Level Cache (LLC) or other core with HITE/F/M.",
         "SampleAfterValue": "200003",
         "Speculative": "1",
         "UMask": "0x10",
@@ -114,6 +120,7 @@
         "EventCode": "0x34",
         "EventName": "MEM_BOUND_STALLS.LOAD_LLC_HIT",
         "PEBScounters": "0,1,2,3,4,5",
+        "PublicDescription": "Counts the number of cycles the core is stal=
led due to a demand load which hit in the Last Level Cache (LLC) or other c=
ore with HITE/F/M.",
         "SampleAfterValue": "200003",
         "Speculative": "1",
         "UMask": "0x2",
@@ -215,6 +222,7 @@
         "EventName": "MEM_UOPS_RETIRED.ALL_LOADS",
         "PEBS": "1",
         "PEBScounters": "0,1,2,3,4,5",
+        "PublicDescription": "Counts the total number of load uops retired=
.",
         "SampleAfterValue": "200003",
         "UMask": "0x81",
         "Unit": "cpu_atom"
@@ -228,6 +236,7 @@
         "EventName": "MEM_UOPS_RETIRED.ALL_STORES",
         "PEBS": "1",
         "PEBScounters": "0,1,2,3,4,5",
+        "PublicDescription": "Counts the total number of store uops retire=
d.",
         "SampleAfterValue": "200003",
         "UMask": "0x82",
         "Unit": "cpu_atom"
@@ -243,7 +252,7 @@
         "MSRIndex": "0x3F6",
         "MSRValue": "0x80",
         "PEBS": "2",
-        "PEBScounters": "0,1",
+        "PublicDescription": "Counts the number of tagged loads with an in=
struction latency that exceeds or equals the threshold of 128 cycles as def=
ined in MEC_CR_PEBS_LD_LAT_THRESHOLD (3F6H). Only counts with PEBS enabled.=
 If a PEBS record is generated, will populate the PEBS Latency and PEBS Dat=
a Source fields accordingly.",
         "SampleAfterValue": "1000003",
         "TakenAlone": "1",
         "UMask": "0x5",
@@ -260,7 +269,7 @@
         "MSRIndex": "0x3F6",
         "MSRValue": "0x10",
         "PEBS": "2",
-        "PEBScounters": "0,1",
+        "PublicDescription": "Counts the number of tagged loads with an in=
struction latency that exceeds or equals the threshold of 16 cycles as defi=
ned in MEC_CR_PEBS_LD_LAT_THRESHOLD (3F6H). Only counts with PEBS enabled. =
If a PEBS record is generated, will populate the PEBS Latency and PEBS Data=
 Source fields accordingly.",
         "SampleAfterValue": "1000003",
         "TakenAlone": "1",
         "UMask": "0x5",
@@ -277,7 +286,7 @@
         "MSRIndex": "0x3F6",
         "MSRValue": "0x100",
         "PEBS": "2",
-        "PEBScounters": "0,1",
+        "PublicDescription": "Counts the number of tagged loads with an in=
struction latency that exceeds or equals the threshold of 256 cycles as def=
ined in MEC_CR_PEBS_LD_LAT_THRESHOLD (3F6H). Only counts with PEBS enabled.=
 If a PEBS record is generated, will populate the PEBS Latency and PEBS Dat=
a Source fields accordingly.",
         "SampleAfterValue": "1000003",
         "TakenAlone": "1",
         "UMask": "0x5",
@@ -294,7 +303,7 @@
         "MSRIndex": "0x3F6",
         "MSRValue": "0x20",
         "PEBS": "2",
-        "PEBScounters": "0,1",
+        "PublicDescription": "Counts the number of tagged loads with an in=
struction latency that exceeds or equals the threshold of 32 cycles as defi=
ned in MEC_CR_PEBS_LD_LAT_THRESHOLD (3F6H). Only counts with PEBS enabled. =
If a PEBS record is generated, will populate the PEBS Latency and PEBS Data=
 Source fields accordingly.",
         "SampleAfterValue": "1000003",
         "TakenAlone": "1",
         "UMask": "0x5",
@@ -311,7 +320,7 @@
         "MSRIndex": "0x3F6",
         "MSRValue": "0x4",
         "PEBS": "2",
-        "PEBScounters": "0,1",
+        "PublicDescription": "Counts the number of tagged loads with an in=
struction latency that exceeds or equals the threshold of 4 cycles as defin=
ed in MEC_CR_PEBS_LD_LAT_THRESHOLD (3F6H). Only counts with PEBS enabled. I=
f a PEBS record is generated, will populate the PEBS Latency and PEBS Data =
Source fields accordingly.",
         "SampleAfterValue": "1000003",
         "TakenAlone": "1",
         "UMask": "0x5",
@@ -328,7 +337,7 @@
         "MSRIndex": "0x3F6",
         "MSRValue": "0x200",
         "PEBS": "2",
-        "PEBScounters": "0,1",
+        "PublicDescription": "Counts the number of tagged loads with an in=
struction latency that exceeds or equals the threshold of 512 cycles as def=
ined in MEC_CR_PEBS_LD_LAT_THRESHOLD (3F6H). Only counts with PEBS enabled.=
 If a PEBS record is generated, will populate the PEBS Latency and PEBS Dat=
a Source fields accordingly.",
         "SampleAfterValue": "1000003",
         "TakenAlone": "1",
         "UMask": "0x5",
@@ -345,7 +354,7 @@
         "MSRIndex": "0x3F6",
         "MSRValue": "0x40",
         "PEBS": "2",
-        "PEBScounters": "0,1",
+        "PublicDescription": "Counts the number of tagged loads with an in=
struction latency that exceeds or equals the threshold of 64 cycles as defi=
ned in MEC_CR_PEBS_LD_LAT_THRESHOLD (3F6H). Only counts with PEBS enabled. =
If a PEBS record is generated, will populate the PEBS Latency and PEBS Data=
 Source fields accordingly.",
         "SampleAfterValue": "1000003",
         "TakenAlone": "1",
         "UMask": "0x5",
@@ -362,7 +371,7 @@
         "MSRIndex": "0x3F6",
         "MSRValue": "0x8",
         "PEBS": "2",
-        "PEBScounters": "0,1",
+        "PublicDescription": "Counts the number of tagged loads with an in=
struction latency that exceeds or equals the threshold of 8 cycles as defin=
ed in MEC_CR_PEBS_LD_LAT_THRESHOLD (3F6H). Only counts with PEBS enabled. I=
f a PEBS record is generated, will populate the PEBS Latency and PEBS Data =
Source fields accordingly.",
         "SampleAfterValue": "1000003",
         "TakenAlone": "1",
         "UMask": "0x5",
@@ -391,6 +400,7 @@
         "L1_Hit_Indication": "1",
         "PEBS": "2",
         "PEBScounters": "0,1,2,3,4,5",
+        "PublicDescription": "Counts the number of stores uops retired. Co=
unts with or without PEBS enabled. If PEBS is enabled and a PEBS record is =
generated, will populate PEBS Latency and PEBS Data Source fields according=
ly.",
         "SampleAfterValue": "1000003",
         "UMask": "0x6",
         "Unit": "cpu_atom"
@@ -492,6 +502,7 @@
         "EventCode": "0x51",
         "EventName": "L1D.REPLACEMENT",
         "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts L1D data line replacements including =
opportunistic replacements, and replacements that require stall-for-replace=
 or block-for-replace.",
         "SampleAfterValue": "100003",
         "Speculative": "1",
         "UMask": "0x1",
@@ -504,13 +515,14 @@
         "EventCode": "0x48",
         "EventName": "L1D_PEND_MISS.FB_FULL",
         "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts number of cycles a demand request has=
 waited due to L1D Fill Buffer (FB) unavailability. Demand requests include=
 cacheable/uncacheable demand load, store, lock or SW prefetch accesses.",
         "SampleAfterValue": "1000003",
         "Speculative": "1",
         "UMask": "0x2",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Number of phases a demand request has waited =
due to L1D Fill Buffer (FB) unavailablability.",
+        "BriefDescription": "Number of phases a demand request has waited =
due to L1D Fill Buffer (FB) unavailability.",
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3",
         "CounterMask": "1",
@@ -518,6 +530,7 @@
         "EventCode": "0x48",
         "EventName": "L1D_PEND_MISS.FB_FULL_PERIODS",
         "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts number of phases a demand request has=
 waited due to L1D Fill Buffer (FB) unavailability. Demand requests include=
 cacheable/uncacheable demand load, store, lock or SW prefetch accesses.",
         "SampleAfterValue": "1000003",
         "Speculative": "1",
         "UMask": "0x2",
@@ -527,6 +540,7 @@
         "BriefDescription": "This event is deprecated. Refer to new event =
L1D_PEND_MISS.L2_STALLS",
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3",
+        "Deprecated": "1",
         "EventCode": "0x48",
         "EventName": "L1D_PEND_MISS.L2_STALL",
         "PEBScounters": "0,1,2,3",
@@ -542,6 +556,7 @@
         "EventCode": "0x48",
         "EventName": "L1D_PEND_MISS.L2_STALLS",
         "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts number of cycles a demand request has=
 waited due to L1D due to lack of L2 resources. Demand requests include cac=
heable/uncacheable demand load, store, lock or SW prefetch accesses.",
         "SampleAfterValue": "1000003",
         "Speculative": "1",
         "UMask": "0x4",
@@ -554,6 +569,7 @@
         "EventCode": "0x48",
         "EventName": "L1D_PEND_MISS.PENDING",
         "PEBScounters": "0,1,2,3",
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
         "Speculative": "1",
         "UMask": "0x1",
@@ -567,6 +583,7 @@
         "EventCode": "0x48",
         "EventName": "L1D_PEND_MISS.PENDING_CYCLES",
         "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts duration of L1D miss outstanding in c=
ycles.",
         "SampleAfterValue": "1000003",
         "Speculative": "1",
         "UMask": "0x1",
@@ -579,6 +596,7 @@
         "EventCode": "0x25",
         "EventName": "L2_LINES_IN.ALL",
         "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts the number of L2 cache lines filling =
the L2. Counting does not cover rejects.",
         "SampleAfterValue": "100003",
         "Speculative": "1",
         "UMask": "0x1f",
@@ -591,6 +609,7 @@
         "EventCode": "0x26",
         "EventName": "L2_LINES_OUT.USELESS_HWPF",
         "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts the number of cache lines that have b=
een prefetched by the L2 hardware prefetcher but not used by demand access =
when evicted from the L2 cache",
         "SampleAfterValue": "200003",
         "Speculative": "1",
         "UMask": "0x4",
@@ -603,6 +622,7 @@
         "EventCode": "0x24",
         "EventName": "L2_REQUEST.ALL",
         "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts all requests that were hit or true mi=
sses in L2 cache. True-miss excludes misses that were merged with ongoing L=
2 misses.[This event is alias to L2_RQSTS.REFERENCES]",
         "SampleAfterValue": "200003",
         "Speculative": "1",
         "UMask": "0xff",
@@ -615,6 +635,7 @@
         "EventCode": "0x24",
         "EventName": "L2_REQUEST.MISS",
         "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts read requests of any type with true-m=
iss in the L2 cache. True-miss excludes L2 misses that were merged with ong=
oing L2 misses.[This event is alias to L2_RQSTS.MISS]",
         "SampleAfterValue": "200003",
         "Speculative": "1",
         "UMask": "0x3f",
@@ -627,6 +648,7 @@
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.ALL_CODE_RD",
         "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts the total number of L2 code requests.=
",
         "SampleAfterValue": "200003",
         "Speculative": "1",
         "UMask": "0xe4",
@@ -639,6 +661,7 @@
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.ALL_DEMAND_DATA_RD",
         "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts Demand Data Read requests accessing t=
he L2 cache. These requests may hit or miss L2 cache. True-miss exclude mis=
ses that were merged with ongoing L2 misses. An access is counted once.",
         "SampleAfterValue": "200003",
         "Speculative": "1",
         "UMask": "0xe1",
@@ -651,6 +674,7 @@
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.ALL_DEMAND_MISS",
         "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts demand requests that miss L2 cache.",
         "SampleAfterValue": "200003",
         "Speculative": "1",
         "UMask": "0x27",
@@ -675,6 +699,7 @@
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.ALL_RFO",
         "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts the total number of RFO (read for own=
ership) requests to L2 cache. L2 RFO requests include both L1D demand RFO m=
isses as well as L1D RFO prefetches.",
         "SampleAfterValue": "200003",
         "Speculative": "1",
         "UMask": "0xe2",
@@ -687,6 +712,7 @@
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.CODE_RD_HIT",
         "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts L2 cache hits when fetching instructi=
ons, code reads.",
         "SampleAfterValue": "200003",
         "Speculative": "1",
         "UMask": "0xc4",
@@ -699,6 +725,7 @@
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.CODE_RD_MISS",
         "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts L2 cache misses when fetching instruc=
tions.",
         "SampleAfterValue": "200003",
         "Speculative": "1",
         "UMask": "0x24",
@@ -711,6 +738,7 @@
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.DEMAND_DATA_RD_HIT",
         "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts the number of demand Data Read reques=
ts initiated by load instructions that hit L2 cache.",
         "SampleAfterValue": "200003",
         "Speculative": "1",
         "UMask": "0xc1",
@@ -723,6 +751,7 @@
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.DEMAND_DATA_RD_MISS",
         "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts demand Data Read requests with true-m=
iss in the L2 cache. True-miss excludes misses that were merged with ongoin=
g L2 misses. An access is counted once.",
         "SampleAfterValue": "200003",
         "Speculative": "1",
         "UMask": "0x21",
@@ -747,6 +776,7 @@
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.MISS",
         "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts read requests of any type with true-m=
iss in the L2 cache. True-miss excludes L2 misses that were merged with ong=
oing L2 misses.[This event is alias to L2_REQUEST.MISS]",
         "SampleAfterValue": "200003",
         "Speculative": "1",
         "UMask": "0x3f",
@@ -759,6 +789,7 @@
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.REFERENCES",
         "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts all requests that were hit or true mi=
sses in L2 cache. True-miss excludes misses that were merged with ongoing L=
2 misses.[This event is alias to L2_REQUEST.ALL]",
         "SampleAfterValue": "200003",
         "Speculative": "1",
         "UMask": "0xff",
@@ -771,6 +802,7 @@
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.RFO_HIT",
         "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts the RFO (Read-for-Ownership) requests=
 that hit L2 cache.",
         "SampleAfterValue": "200003",
         "Speculative": "1",
         "UMask": "0xc2",
@@ -783,6 +815,7 @@
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.RFO_MISS",
         "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts the RFO (Read-for-Ownership) requests=
 that miss L2 cache.",
         "SampleAfterValue": "200003",
         "Speculative": "1",
         "UMask": "0x22",
@@ -795,6 +828,7 @@
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.SWPF_HIT",
         "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts Software prefetch requests that hit t=
he L2 cache. Accounts for PREFETCHNTA and PREFETCHT0/1/2 instructions when =
FB is not full.",
         "SampleAfterValue": "200003",
         "Speculative": "1",
         "UMask": "0xc8",
@@ -807,6 +841,7 @@
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.SWPF_MISS",
         "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts Software prefetch requests that miss =
the L2 cache. Accounts for PREFETCHNTA and PREFETCHT0/1/2 instructions when=
 FB is not full.",
         "SampleAfterValue": "200003",
         "Speculative": "1",
         "UMask": "0x28",
@@ -819,6 +854,7 @@
         "EventCode": "0x2e",
         "EventName": "LONGEST_LAT_CACHE.MISS",
         "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts core-originated cacheable requests th=
at miss the L3 cache (Longest Latency cache). Requests include data and cod=
e reads, Reads-for-Ownership (RFOs), speculative accesses and hardware pref=
etches to the L1 and L2.  It does not include hardware prefetches to the L3=
, and may not count other types of requests to the L3.",
         "SampleAfterValue": "100003",
         "Speculative": "1",
         "UMask": "0x41",
@@ -831,6 +867,7 @@
         "EventCode": "0x2e",
         "EventName": "LONGEST_LAT_CACHE.REFERENCE",
         "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts core-originated cacheable requests to=
 the L3 cache (Longest Latency cache). Requests include data and code reads=
, Reads-for-Ownership (RFOs), speculative accesses and hardware prefetches =
to the L1 and L2.  It does not include hardware prefetches to the L3, and m=
ay not count other types of requests to the L3.",
         "SampleAfterValue": "100003",
         "Speculative": "1",
         "UMask": "0x4f",
@@ -845,6 +882,7 @@
         "EventName": "MEM_INST_RETIRED.ALL_LOADS",
         "PEBS": "1",
         "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts all retired load instructions. This e=
vent accounts for SW prefetch instructions of PREFETCHNTA or PREFETCHT0/1/2=
 or PREFETCHW.",
         "SampleAfterValue": "1000003",
         "UMask": "0x81",
         "Unit": "cpu_core"
@@ -859,6 +897,7 @@
         "L1_Hit_Indication": "1",
         "PEBS": "1",
         "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts all retired store instructions.",
         "SampleAfterValue": "1000003",
         "UMask": "0x82",
         "Unit": "cpu_core"
@@ -873,6 +912,7 @@
         "L1_Hit_Indication": "1",
         "PEBS": "1",
         "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts all retired memory instructions - loa=
ds and stores.",
         "SampleAfterValue": "1000003",
         "UMask": "0x83",
         "Unit": "cpu_core"
@@ -886,6 +926,7 @@
         "EventName": "MEM_INST_RETIRED.LOCK_LOADS",
         "PEBS": "1",
         "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts retired load instructions with locked=
 access.",
         "SampleAfterValue": "100007",
         "UMask": "0x21",
         "Unit": "cpu_core"
@@ -899,6 +940,7 @@
         "EventName": "MEM_INST_RETIRED.SPLIT_LOADS",
         "PEBS": "1",
         "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts retired load instructions that split =
across a cacheline boundary.",
         "SampleAfterValue": "100003",
         "UMask": "0x41",
         "Unit": "cpu_core"
@@ -913,6 +955,7 @@
         "L1_Hit_Indication": "1",
         "PEBS": "1",
         "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts retired store instructions that split=
 across a cacheline boundary.",
         "SampleAfterValue": "100003",
         "UMask": "0x42",
         "Unit": "cpu_core"
@@ -926,6 +969,7 @@
         "EventName": "MEM_INST_RETIRED.STLB_MISS_LOADS",
         "PEBS": "1",
         "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Number of retired load instructions that (st=
art a) miss in the 2nd-level TLB (STLB).",
         "SampleAfterValue": "100003",
         "UMask": "0x11",
         "Unit": "cpu_core"
@@ -940,6 +984,7 @@
         "L1_Hit_Indication": "1",
         "PEBS": "1",
         "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Number of retired store instructions that (s=
tart a) miss in the 2nd-level TLB (STLB).",
         "SampleAfterValue": "100003",
         "UMask": "0x12",
         "Unit": "cpu_core"
@@ -951,6 +996,7 @@
         "EventCode": "0x43",
         "EventName": "MEM_LOAD_COMPLETED.L1_MISS_ANY",
         "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Number of completed demand load requests tha=
t missed the L1 data cache including shadow misses (FB hits, merge to an on=
going L1D miss)",
         "SampleAfterValue": "1000003",
         "Speculative": "1",
         "UMask": "0xfd",
@@ -965,6 +1011,7 @@
         "EventName": "MEM_LOAD_L3_HIT_RETIRED.XSNP_FWD",
         "PEBS": "1",
         "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts retired load instructions whose data =
sources were HitM responses from shared L3.",
         "SampleAfterValue": "20011",
         "UMask": "0x4",
         "Unit": "cpu_core"
@@ -978,6 +1025,7 @@
         "EventName": "MEM_LOAD_L3_HIT_RETIRED.XSNP_HIT",
         "PEBS": "1",
         "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts retired load instructions whose data =
sources were L3 and cross-core snoop hits in on-pkg core cache.",
         "SampleAfterValue": "20011",
         "UMask": "0x2",
         "Unit": "cpu_core"
@@ -991,6 +1039,7 @@
         "EventName": "MEM_LOAD_L3_HIT_RETIRED.XSNP_HITM",
         "PEBS": "1",
         "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts retired load instructions whose data =
sources were HitM responses from shared L3.",
         "SampleAfterValue": "20011",
         "UMask": "0x4",
         "Unit": "cpu_core"
@@ -1004,6 +1053,7 @@
         "EventName": "MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS",
         "PEBS": "1",
         "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts the retired load instructions whose d=
ata sources were L3 hit and cross-core snoop missed in on-pkg core cache.",
         "SampleAfterValue": "20011",
         "UMask": "0x1",
         "Unit": "cpu_core"
@@ -1017,6 +1067,7 @@
         "EventName": "MEM_LOAD_L3_HIT_RETIRED.XSNP_NONE",
         "PEBS": "1",
         "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts retired load instructions whose data =
sources were hits in L3 without snoops required.",
         "SampleAfterValue": "100003",
         "UMask": "0x8",
         "Unit": "cpu_core"
@@ -1030,17 +1081,21 @@
         "EventName": "MEM_LOAD_L3_HIT_RETIRED.XSNP_NO_FWD",
         "PEBS": "1",
         "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts retired load instructions whose data =
sources were L3 and cross-core snoop hits in on-pkg core cache.",
         "SampleAfterValue": "20011",
         "UMask": "0x2",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Retired load instructions which data sources =
missed L3 but serviced from local dram",
+        "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xd3",
         "EventName": "MEM_LOAD_L3_MISS_RETIRED.LOCAL_DRAM",
+        "PEBS": "1",
         "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Retired load instructions which data sources=
 missed L3 but serviced from local DRAM.",
         "SampleAfterValue": "100007",
         "UMask": "0x1",
         "Unit": "cpu_core"
@@ -1054,6 +1109,7 @@
         "EventName": "MEM_LOAD_MISC_RETIRED.UC",
         "PEBS": "1",
         "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Retired instructions with at least one load =
to uncacheable memory-type, or at least one cache-line split locked access =
(Bus Lock).",
         "SampleAfterValue": "100007",
         "UMask": "0x4",
         "Unit": "cpu_core"
@@ -1067,6 +1123,7 @@
         "EventName": "MEM_LOAD_RETIRED.FB_HIT",
         "PEBS": "1",
         "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts retired load instructions with at lea=
st one uop was load missed in L1 but hit FB (Fill Buffers) due to preceding=
 miss to the same cache line with data not ready.",
         "SampleAfterValue": "100007",
         "UMask": "0x40",
         "Unit": "cpu_core"
@@ -1080,6 +1137,7 @@
         "EventName": "MEM_LOAD_RETIRED.L1_HIT",
         "PEBS": "1",
         "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts retired load instructions with at lea=
st one uop that hit in the L1 data cache. This event includes all SW prefet=
ches and lock instructions regardless of the data source.",
         "SampleAfterValue": "1000003",
         "UMask": "0x1",
         "Unit": "cpu_core"
@@ -1093,6 +1151,7 @@
         "EventName": "MEM_LOAD_RETIRED.L1_MISS",
         "PEBS": "1",
         "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts retired load instructions with at lea=
st one uop that missed in the L1 cache.",
         "SampleAfterValue": "200003",
         "UMask": "0x8",
         "Unit": "cpu_core"
@@ -1106,6 +1165,7 @@
         "EventName": "MEM_LOAD_RETIRED.L2_HIT",
         "PEBS": "1",
         "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts retired load instructions with L2 cac=
he hits as data sources.",
         "SampleAfterValue": "200003",
         "UMask": "0x2",
         "Unit": "cpu_core"
@@ -1119,6 +1179,7 @@
         "EventName": "MEM_LOAD_RETIRED.L2_MISS",
         "PEBS": "1",
         "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts retired load instructions missed L2 c=
ache as data sources.",
         "SampleAfterValue": "100021",
         "UMask": "0x10",
         "Unit": "cpu_core"
@@ -1132,6 +1193,7 @@
         "EventName": "MEM_LOAD_RETIRED.L3_HIT",
         "PEBS": "1",
         "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts retired load instructions with at lea=
st one uop that hit in the L3 cache.",
         "SampleAfterValue": "100021",
         "UMask": "0x4",
         "Unit": "cpu_core"
@@ -1145,6 +1207,7 @@
         "EventName": "MEM_LOAD_RETIRED.L3_MISS",
         "PEBS": "1",
         "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts retired load instructions with at lea=
st one uop that missed in the L3 cache.",
         "SampleAfterValue": "50021",
         "UMask": "0x20",
         "Unit": "cpu_core"
@@ -1162,10 +1225,12 @@
     },
     {
         "BriefDescription": "Retired memory uops for any access",
+        "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xe5",
         "EventName": "MEM_UOP_RETIRED.ANY",
         "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Number of retired micro-operations (uops) fo=
r load or store memory accesses",
         "SampleAfterValue": "1000003",
         "UMask": "0x3",
         "Unit": "cpu_core"
@@ -1222,6 +1287,7 @@
         "EventCode": "0x21",
         "EventName": "OFFCORE_REQUESTS.DATA_RD",
         "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts the demand and prefetch data reads. A=
ll Core Data Reads include cacheable 'Demands' and L2 prefetchers (not L3 p=
refetchers). Counting also covers reads due to page walks resulted from any=
 request type.",
         "SampleAfterValue": "100003",
         "Speculative": "1",
         "UMask": "0x8",
@@ -1234,6 +1300,7 @@
         "EventCode": "0x21",
         "EventName": "OFFCORE_REQUESTS.DEMAND_DATA_RD",
         "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts the Demand Data Read requests sent to=
 uncore. Use it in conjunction with OFFCORE_REQUESTS_OUTSTANDING to determi=
ne average latency in the uncore.",
         "SampleAfterValue": "100003",
         "Speculative": "1",
         "UMask": "0x1",
@@ -1243,6 +1310,7 @@
         "BriefDescription": "This event is deprecated. Refer to new event =
OFFCORE_REQUESTS_OUTSTANDING.DATA_RD",
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3",
+        "Deprecated": "1",
         "Errata": "ADL038",
         "EventCode": "0x20",
         "EventName": "OFFCORE_REQUESTS_OUTSTANDING.ALL_DATA_RD",
@@ -1274,6 +1342,7 @@
         "EventCode": "0x20",
         "EventName": "OFFCORE_REQUESTS_OUTSTANDING.CYCLES_WITH_DEMAND_RFO",
         "PEBScounters": "0,1,2,3",
+        "PublicDescription": "OFFCORE_REQUESTS_OUTSTANDING.CYCLES_WITH_DEM=
AND_RFO",
         "SampleAfterValue": "1000003",
         "Speculative": "1",
         "UMask": "0x4",
@@ -1299,6 +1368,7 @@
         "EventCode": "0x40",
         "EventName": "SW_PREFETCH_ACCESS.NTA",
         "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts the number of PREFETCHNTA instruction=
s executed.",
         "SampleAfterValue": "100003",
         "Speculative": "1",
         "UMask": "0x1",
@@ -1311,6 +1381,7 @@
         "EventCode": "0x40",
         "EventName": "SW_PREFETCH_ACCESS.PREFETCHW",
         "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts the number of PREFETCHW instructions =
executed.",
         "SampleAfterValue": "100003",
         "Speculative": "1",
         "UMask": "0x8",
@@ -1323,6 +1394,7 @@
         "EventCode": "0x40",
         "EventName": "SW_PREFETCH_ACCESS.T0",
         "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts the number of PREFETCHT0 instructions=
 executed.",
         "SampleAfterValue": "100003",
         "Speculative": "1",
         "UMask": "0x2",
@@ -1335,6 +1407,7 @@
         "EventCode": "0x40",
         "EventName": "SW_PREFETCH_ACCESS.T1_T2",
         "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts the number of PREFETCHT1 or PREFETCHT=
2 instructions executed.",
         "SampleAfterValue": "100003",
         "Speculative": "1",
         "UMask": "0x4",
diff --git a/tools/perf/pmu-events/arch/x86/alderlake/floating-point.json b=
/tools/perf/pmu-events/arch/x86/alderlake/floating-point.json
index 48a4605fc057..7cae3f9c2d02 100644
--- a/tools/perf/pmu-events/arch/x86/alderlake/floating-point.json
+++ b/tools/perf/pmu-events/arch/x86/alderlake/floating-point.json
@@ -6,6 +6,7 @@
         "EventCode": "0xc3",
         "EventName": "MACHINE_CLEARS.FP_ASSIST",
         "PEBScounters": "0,1,2,3,4,5",
+        "PublicDescription": "Counts the number of floating point operatio=
ns retired that required microcode assist, which is not a reflection of the=
 number of FP operations, instructions or uops.",
         "SampleAfterValue": "20003",
         "Speculative": "1",
         "UMask": "0x4",
@@ -43,6 +44,7 @@
         "EventCode": "0xc1",
         "EventName": "ASSISTS.FP",
         "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts all microcode Floating Point assists.=
",
         "SampleAfterValue": "100003",
         "Speculative": "1",
         "UMask": "0x2",
@@ -103,6 +105,7 @@
         "EventCode": "0xc7",
         "EventName": "FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE",
         "PEBScounters": "0,1,2,3,4,5,6,7",
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
@@ -114,6 +117,7 @@
         "EventCode": "0xc7",
         "EventName": "FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE",
         "PEBScounters": "0,1,2,3,4,5,6,7",
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
@@ -125,6 +129,7 @@
         "EventCode": "0xc7",
         "EventName": "FP_ARITH_INST_RETIRED.256B_PACKED_DOUBLE",
         "PEBScounters": "0,1,2,3,4,5,6,7",
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
@@ -136,6 +141,7 @@
         "EventCode": "0xc7",
         "EventName": "FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE",
         "PEBScounters": "0,1,2,3,4,5,6,7",
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
@@ -147,6 +153,7 @@
         "EventCode": "0xc7",
         "EventName": "FP_ARITH_INST_RETIRED.SCALAR_DOUBLE",
         "PEBScounters": "0,1,2,3,4,5,6,7",
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
@@ -158,6 +165,7 @@
         "EventCode": "0xc7",
         "EventName": "FP_ARITH_INST_RETIRED.SCALAR_SINGLE",
         "PEBScounters": "0,1,2,3,4,5,6,7",
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
diff --git a/tools/perf/pmu-events/arch/x86/alderlake/frontend.json b/tools=
/perf/pmu-events/arch/x86/alderlake/frontend.json
index da1a7ba0e568..06674b7203cf 100644
--- a/tools/perf/pmu-events/arch/x86/alderlake/frontend.json
+++ b/tools/perf/pmu-events/arch/x86/alderlake/frontend.json
@@ -6,6 +6,7 @@
         "EventCode": "0xe6",
         "EventName": "BACLEARS.ANY",
         "PEBScounters": "0,1,2,3,4,5",
+        "PublicDescription": "Counts the total number of BACLEARS, which o=
ccur when the Branch Target Buffer (BTB) prediction or lack thereof, was co=
rrected by a later branch predictor in the frontend.  Includes BACLEARS due=
 to all branch types including conditional and unconditional jumps, returns=
, and indirect branches.",
         "SampleAfterValue": "100003",
         "Speculative": "1",
         "UMask": "0x1",
@@ -18,6 +19,7 @@
         "EventCode": "0x80",
         "EventName": "ICACHE.ACCESSES",
         "PEBScounters": "0,1,2,3,4,5",
+        "PublicDescription": "Counts the total number of requests to the i=
nstruction cache.  The event only counts new cache line accesses, so that m=
ultiple back to back fetches to the exact same cache line or byte chunk cou=
nt as one.  Specifically, the event counts when accesses from sequential co=
de crosses the cache line boundary, or when a branch target is moved to a n=
ew line or to a non-sequential byte chunk of the same line.",
         "SampleAfterValue": "200003",
         "Speculative": "1",
         "UMask": "0x3",
@@ -30,6 +32,7 @@
         "EventCode": "0x80",
         "EventName": "ICACHE.MISSES",
         "PEBScounters": "0,1,2,3,4,5",
+        "PublicDescription": "Counts the number of missed requests to the =
instruction cache.  The event only counts new cache line accesses, so that =
multiple back to back fetches to the exact same cache line and byte chunk c=
ount as one.  Specifically, the event counts when accesses from sequential =
code crosses the cache line boundary, or when a branch target is moved to a=
 new line or to a non-sequential byte chunk of the same line.",
         "SampleAfterValue": "200003",
         "Speculative": "1",
         "UMask": "0x2",
@@ -42,6 +45,7 @@
         "EventCode": "0x87",
         "EventName": "DECODE.LCP",
         "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts cycles that the Instruction Length de=
coder (ILD) stalls occurred due to dynamically changing prefix length of th=
e decoded instruction (by operand size prefix instruction 0x66, address siz=
e prefix instruction 0x67 or REX.W for Intel64). Count is proportional to t=
he number of prefixes in a 16B-line. This may result in a three-cycle penal=
ty for each LCP (Length changing prefix) in a 16-byte chunk.",
         "SampleAfterValue": "500009",
         "Speculative": "1",
         "UMask": "0x1",
@@ -66,6 +70,7 @@
         "EventCode": "0x61",
         "EventName": "DSB2MITE_SWITCHES.PENALTY_CYCLES",
         "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Decode Stream Buffer (DSB) is a Uop-cache th=
at holds translations of previously fetched instructions that were decoded =
by the legacy x86 decode pipeline (MITE). This event counts fetch penalty c=
ycles when a transition occurs from DSB to MITE.",
         "SampleAfterValue": "100003",
         "Speculative": "1",
         "UMask": "0x2",
@@ -81,6 +86,7 @@
         "MSRValue": "0x1",
         "PEBS": "1",
         "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts retired Instructions that experienced=
 DSB (Decode stream buffer i.e. the decoded instruction-cache) miss.",
         "SampleAfterValue": "100007",
         "TakenAlone": "1",
         "UMask": "0x1",
@@ -96,6 +102,7 @@
         "MSRValue": "0x11",
         "PEBS": "1",
         "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Number of retired Instructions that experien=
ced a critical DSB (Decode stream buffer i.e. the decoded instruction-cache=
) miss. Critical means stalls were exposed to the back-end as a result of t=
he DSB miss.",
         "SampleAfterValue": "100007",
         "TakenAlone": "1",
         "UMask": "0x1",
@@ -111,6 +118,7 @@
         "MSRValue": "0x14",
         "PEBS": "1",
         "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts retired Instructions that experienced=
 iTLB (Instruction TLB) true miss.",
         "SampleAfterValue": "100007",
         "TakenAlone": "1",
         "UMask": "0x1",
@@ -126,6 +134,7 @@
         "MSRValue": "0x12",
         "PEBS": "1",
         "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts retired Instructions who experienced =
Instruction L1 Cache true miss.",
         "SampleAfterValue": "100007",
         "TakenAlone": "1",
         "UMask": "0x1",
@@ -141,6 +150,7 @@
         "MSRValue": "0x13",
         "PEBS": "1",
         "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts retired Instructions who experienced =
Instruction L2 Cache true miss.",
         "SampleAfterValue": "100007",
         "TakenAlone": "1",
         "UMask": "0x1",
@@ -156,6 +166,7 @@
         "MSRValue": "0x600106",
         "PEBS": "1",
         "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Retired instructions that are fetched after =
an interval where the front-end delivered no uops for a period of at least =
1 cycle which was not interrupted by a back-end stall.",
         "SampleAfterValue": "100007",
         "TakenAlone": "1",
         "UMask": "0x1",
@@ -171,6 +182,7 @@
         "MSRValue": "0x608006",
         "PEBS": "1",
         "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts retired instructions that are fetched=
 after an interval where the front-end delivered no uops for a period of 12=
8 cycles which was not interrupted by a back-end stall.",
         "SampleAfterValue": "100007",
         "TakenAlone": "1",
         "UMask": "0x1",
@@ -186,6 +198,7 @@
         "MSRValue": "0x601006",
         "PEBS": "1",
         "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts retired instructions that are deliver=
ed to the back-end after a front-end stall of at least 16 cycles. During th=
is period the front-end delivered no uops.",
         "SampleAfterValue": "100007",
         "TakenAlone": "1",
         "UMask": "0x1",
@@ -201,6 +214,7 @@
         "MSRValue": "0x600206",
         "PEBS": "1",
         "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Retired instructions that are fetched after =
an interval where the front-end delivered no uops for a period of at least =
2 cycles which was not interrupted by a back-end stall.",
         "SampleAfterValue": "100007",
         "TakenAlone": "1",
         "UMask": "0x1",
@@ -216,6 +230,7 @@
         "MSRValue": "0x610006",
         "PEBS": "1",
         "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts retired instructions that are fetched=
 after an interval where the front-end delivered no uops for a period of 25=
6 cycles which was not interrupted by a back-end stall.",
         "SampleAfterValue": "100007",
         "TakenAlone": "1",
         "UMask": "0x1",
@@ -231,6 +246,7 @@
         "MSRValue": "0x100206",
         "PEBS": "1",
         "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts retired instructions that are deliver=
ed to the back-end after the front-end had at least 1 bubble-slot for a per=
iod of 2 cycles. A bubble-slot is an empty issue-pipeline slot while there =
was no RAT stall.",
         "SampleAfterValue": "100007",
         "TakenAlone": "1",
         "UMask": "0x1",
@@ -246,6 +262,7 @@
         "MSRValue": "0x602006",
         "PEBS": "1",
         "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts retired instructions that are deliver=
ed to the back-end after a front-end stall of at least 32 cycles. During th=
is period the front-end delivered no uops.",
         "SampleAfterValue": "100007",
         "TakenAlone": "1",
         "UMask": "0x1",
@@ -261,6 +278,7 @@
         "MSRValue": "0x600406",
         "PEBS": "1",
         "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts retired instructions that are fetched=
 after an interval where the front-end delivered no uops for a period of 4 =
cycles which was not interrupted by a back-end stall.",
         "SampleAfterValue": "100007",
         "TakenAlone": "1",
         "UMask": "0x1",
@@ -276,6 +294,7 @@
         "MSRValue": "0x620006",
         "PEBS": "1",
         "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts retired instructions that are fetched=
 after an interval where the front-end delivered no uops for a period of 51=
2 cycles which was not interrupted by a back-end stall.",
         "SampleAfterValue": "100007",
         "TakenAlone": "1",
         "UMask": "0x1",
@@ -291,6 +310,7 @@
         "MSRValue": "0x604006",
         "PEBS": "1",
         "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts retired instructions that are fetched=
 after an interval where the front-end delivered no uops for a period of 64=
 cycles which was not interrupted by a back-end stall.",
         "SampleAfterValue": "100007",
         "TakenAlone": "1",
         "UMask": "0x1",
@@ -306,6 +326,7 @@
         "MSRValue": "0x600806",
         "PEBS": "1",
         "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts retired instructions that are deliver=
ed to the back-end after a front-end stall of at least 8 cycles. During thi=
s period the front-end delivered no uops.",
         "SampleAfterValue": "100007",
         "TakenAlone": "1",
         "UMask": "0x1",
@@ -336,6 +357,7 @@
         "MSRValue": "0x15",
         "PEBS": "1",
         "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts retired Instructions that experienced=
 STLB (2nd level TLB) true miss.",
         "SampleAfterValue": "100007",
         "TakenAlone": "1",
         "UMask": "0x1",
@@ -363,6 +385,7 @@
         "EventCode": "0x80",
         "EventName": "ICACHE_DATA.STALLS",
         "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts cycles where a code line fetch is sta=
lled due to an L1 instruction cache miss. The decode pipeline works at a 32=
 Byte granularity.",
         "SampleAfterValue": "500009",
         "Speculative": "1",
         "UMask": "0x4",
@@ -375,6 +398,7 @@
         "EventCode": "0x83",
         "EventName": "ICACHE_TAG.STALLS",
         "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts cycles where a code fetch is stalled =
due to L1 instruction cache tag miss.",
         "SampleAfterValue": "200003",
         "Speculative": "1",
         "UMask": "0x4",
@@ -388,6 +412,7 @@
         "EventCode": "0x79",
         "EventName": "IDQ.DSB_CYCLES_ANY",
         "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts the number of cycles uops were delive=
red to Instruction Decode Queue (IDQ) from the Decode Stream Buffer (DSB) p=
ath.",
         "SampleAfterValue": "2000003",
         "Speculative": "1",
         "UMask": "0x8",
@@ -401,6 +426,7 @@
         "EventCode": "0x79",
         "EventName": "IDQ.DSB_CYCLES_OK",
         "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts the number of cycles where optimal nu=
mber of uops was delivered to the Instruction Decode Queue (IDQ) from the M=
ITE (legacy decode pipeline) path. During these cycles uops are not being d=
elivered from the Decode Stream Buffer (DSB).",
         "SampleAfterValue": "2000003",
         "Speculative": "1",
         "UMask": "0x8",
@@ -413,6 +439,7 @@
         "EventCode": "0x79",
         "EventName": "IDQ.DSB_UOPS",
         "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts the number of uops delivered to Instr=
uction Decode Queue (IDQ) from the Decode Stream Buffer (DSB) path.",
         "SampleAfterValue": "2000003",
         "Speculative": "1",
         "UMask": "0x8",
@@ -426,6 +453,7 @@
         "EventCode": "0x79",
         "EventName": "IDQ.MITE_CYCLES_ANY",
         "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts the number of cycles uops were delive=
red to the Instruction Decode Queue (IDQ) from the MITE (legacy decode pipe=
line) path. During these cycles uops are not being delivered from the Decod=
e Stream Buffer (DSB).",
         "SampleAfterValue": "2000003",
         "Speculative": "1",
         "UMask": "0x4",
@@ -439,6 +467,7 @@
         "EventCode": "0x79",
         "EventName": "IDQ.MITE_CYCLES_OK",
         "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts the number of cycles where optimal nu=
mber of uops was delivered to the Instruction Decode Queue (IDQ) from the M=
ITE (legacy decode pipeline) path. During these cycles uops are not being d=
elivered from the Decode Stream Buffer (DSB).",
         "SampleAfterValue": "2000003",
         "Speculative": "1",
         "UMask": "0x4",
@@ -451,6 +480,7 @@
         "EventCode": "0x79",
         "EventName": "IDQ.MITE_UOPS",
         "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts the number of uops delivered to Instr=
uction Decode Queue (IDQ) from the MITE path. This also means that uops are=
 not being delivered from the Decode Stream Buffer (DSB).",
         "SampleAfterValue": "2000003",
         "Speculative": "1",
         "UMask": "0x4",
@@ -464,6 +494,7 @@
         "EventCode": "0x79",
         "EventName": "IDQ.MS_CYCLES_ANY",
         "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts cycles during which uops are being de=
livered to Instruction Decode Queue (IDQ) while the Microcode Sequencer (MS=
) is busy. Uops maybe initiated by Decode Stream Buffer (DSB) or MITE.",
         "SampleAfterValue": "2000003",
         "Speculative": "1",
         "UMask": "0x20",
@@ -478,6 +509,7 @@
         "EventCode": "0x79",
         "EventName": "IDQ.MS_SWITCHES",
         "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Number of switches from DSB (Decode Stream B=
uffer) or MITE (legacy decode pipeline) to the Microcode Sequencer.",
         "SampleAfterValue": "100003",
         "Speculative": "1",
         "UMask": "0x20",
@@ -490,6 +522,7 @@
         "EventCode": "0x79",
         "EventName": "IDQ.MS_UOPS",
         "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts the total number of uops delivered by=
 the Microcode Sequencer (MS).",
         "SampleAfterValue": "1000003",
         "Speculative": "1",
         "UMask": "0x20",
@@ -502,6 +535,7 @@
         "EventCode": "0x9c",
         "EventName": "IDQ_UOPS_NOT_DELIVERED.CORE",
         "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts the number of uops not delivered to b=
y the Instruction Decode Queue (IDQ) to the back-end of the pipeline when t=
here was no back-end stalls. This event counts for one SMT thread in a give=
n cycle.",
         "SampleAfterValue": "1000003",
         "Speculative": "1",
         "UMask": "0x1",
@@ -515,6 +549,7 @@
         "EventCode": "0x9c",
         "EventName": "IDQ_UOPS_NOT_DELIVERED.CYCLES_0_UOPS_DELIV.CORE",
         "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts the number of cycles when no uops wer=
e delivered by the Instruction Decode Queue (IDQ) to the back-end of the pi=
peline when there was no back-end stalls. This event counts for one SMT thr=
ead in a given cycle.",
         "SampleAfterValue": "1000003",
         "Speculative": "1",
         "UMask": "0x1",
@@ -529,6 +564,7 @@
         "EventName": "IDQ_UOPS_NOT_DELIVERED.CYCLES_FE_WAS_OK",
         "Invert": "1",
         "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts the number of cycles when the optimal=
 number of uops were delivered by the Instruction Decode Queue (IDQ) to the=
 back-end of the pipeline when there was no back-end stalls. This event cou=
nts for one SMT thread in a given cycle.",
         "SampleAfterValue": "1000003",
         "Speculative": "1",
         "UMask": "0x1",
diff --git a/tools/perf/pmu-events/arch/x86/alderlake/memory.json b/tools/p=
erf/pmu-events/arch/x86/alderlake/memory.json
index f894e4a0212b..bbe518851be9 100644
--- a/tools/perf/pmu-events/arch/x86/alderlake/memory.json
+++ b/tools/perf/pmu-events/arch/x86/alderlake/memory.json
@@ -30,6 +30,7 @@
         "EventCode": "0x05",
         "EventName": "LD_HEAD.OTHER_AT_RET",
         "PEBScounters": "0,1,2,3,4,5",
+        "PublicDescription": "Counts the number of cycles that the head (o=
ldest load) of the load buffer and retirement are both stalled due to other=
 block cases such as pipeline conflicts, fences, etc.",
         "SampleAfterValue": "1000003",
         "Speculative": "1",
         "UMask": "0xc0",
@@ -135,6 +136,7 @@
         "EventCode": "0xc3",
         "EventName": "MACHINE_CLEARS.MEMORY_ORDERING",
         "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts the number of Machine Clears detected=
 dye to memory ordering. Memory Ordering Machine Clears may apply when a me=
mory read may not conform to the memory ordering rules of the x86 architect=
ure",
         "SampleAfterValue": "100003",
         "Speculative": "1",
         "UMask": "0x2",
@@ -203,6 +205,7 @@
         "MSRValue": "0x80",
         "PEBS": "2",
         "PEBScounters": "1,2,3,4,5,6,7",
+        "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 128 cycles.  Reported=
 latency may be longer than just the memory latency.",
         "SampleAfterValue": "1009",
         "TakenAlone": "1",
         "UMask": "0x1",
@@ -219,6 +222,7 @@
         "MSRValue": "0x10",
         "PEBS": "2",
         "PEBScounters": "1,2,3,4,5,6,7",
+        "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 16 cycles.  Reported =
latency may be longer than just the memory latency.",
         "SampleAfterValue": "20011",
         "TakenAlone": "1",
         "UMask": "0x1",
@@ -235,6 +239,7 @@
         "MSRValue": "0x100",
         "PEBS": "2",
         "PEBScounters": "1,2,3,4,5,6,7",
+        "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 256 cycles.  Reported=
 latency may be longer than just the memory latency.",
         "SampleAfterValue": "503",
         "TakenAlone": "1",
         "UMask": "0x1",
@@ -251,6 +256,7 @@
         "MSRValue": "0x20",
         "PEBS": "2",
         "PEBScounters": "1,2,3,4,5,6,7",
+        "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 32 cycles.  Reported =
latency may be longer than just the memory latency.",
         "SampleAfterValue": "100007",
         "TakenAlone": "1",
         "UMask": "0x1",
@@ -267,6 +273,7 @@
         "MSRValue": "0x4",
         "PEBS": "2",
         "PEBScounters": "1,2,3,4,5,6,7",
+        "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 4 cycles.  Reported l=
atency may be longer than just the memory latency.",
         "SampleAfterValue": "100003",
         "TakenAlone": "1",
         "UMask": "0x1",
@@ -283,6 +290,7 @@
         "MSRValue": "0x200",
         "PEBS": "2",
         "PEBScounters": "1,2,3,4,5,6,7",
+        "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 512 cycles.  Reported=
 latency may be longer than just the memory latency.",
         "SampleAfterValue": "101",
         "TakenAlone": "1",
         "UMask": "0x1",
@@ -299,6 +307,7 @@
         "MSRValue": "0x40",
         "PEBS": "2",
         "PEBScounters": "1,2,3,4,5,6,7",
+        "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 64 cycles.  Reported =
latency may be longer than just the memory latency.",
         "SampleAfterValue": "2003",
         "TakenAlone": "1",
         "UMask": "0x1",
@@ -315,6 +324,7 @@
         "MSRValue": "0x8",
         "PEBS": "2",
         "PEBScounters": "1,2,3,4,5,6,7",
+        "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 8 cycles.  Reported l=
atency may be longer than just the memory latency.",
         "SampleAfterValue": "50021",
         "TakenAlone": "1",
         "UMask": "0x1",
@@ -327,6 +337,7 @@
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
@@ -352,5 +363,31 @@
         "SampleAfterValue": "100003",
         "UMask": "0x1",
         "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Demand Data Read requests who miss L3 cache",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x21",
+        "EventName": "OFFCORE_REQUESTS.L3_MISS_DEMAND_DATA_RD",
+        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Demand Data Read requests who miss L3 cache.=
",
+        "SampleAfterValue": "100003",
+        "Speculative": "1",
+        "UMask": "0x10",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "For every cycle, increments by the number of =
demand data read requests pending that are known to have missed the L3 cach=
e.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x20",
+        "EventName": "OFFCORE_REQUESTS_OUTSTANDING.L3_MISS_DEMAND_DATA_RD",
+        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "For every cycle, increments by the number of=
 demand data read requests pending that are known to have missed the L3 cac=
he.  Note that this does not capture all elapsed cycles while requests are =
outstanding - only cycles from when the requests were known by the requesti=
ng core to have missed the L3 cache.",
+        "SampleAfterValue": "2000003",
+        "Speculative": "1",
+        "UMask": "0x10",
+        "Unit": "cpu_core"
     }
 ]
diff --git a/tools/perf/pmu-events/arch/x86/alderlake/other.json b/tools/pe=
rf/pmu-events/arch/x86/alderlake/other.json
index c49d8ce27310..6e9d6466300b 100644
--- a/tools/perf/pmu-events/arch/x86/alderlake/other.json
+++ b/tools/perf/pmu-events/arch/x86/alderlake/other.json
@@ -154,6 +154,7 @@
         "EventCode": "0xa5",
         "EventName": "RS.EMPTY",
         "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts cycles during which the reservation s=
tation (RS) is empty for this logical processor. This is usually caused whe=
n the front-end pipeline runs into starvation periods (e.g. branch mispredi=
ctions or i-cache misses)",
         "SampleAfterValue": "1000003",
         "Speculative": "1",
         "UMask": "0x7",
@@ -169,6 +170,7 @@
         "EventName": "RS.EMPTY_COUNT",
         "Invert": "1",
         "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts end of periods where the Reservation =
Station (RS) was empty. Could be useful to closely sample on front-end late=
ncy issues (see the FRONTEND_RETIRED event of designated precise events)",
         "SampleAfterValue": "100003",
         "Speculative": "1",
         "UMask": "0x7",
@@ -179,6 +181,7 @@
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
+        "Deprecated": "1",
         "EdgeDetect": "1",
         "EventCode": "0xa5",
         "EventName": "RS_EMPTY.COUNT",
@@ -193,6 +196,7 @@
         "BriefDescription": "This event is deprecated. Refer to new event =
RS.EMPTY",
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3,4,5,6,7",
+        "Deprecated": "1",
         "EventCode": "0xa5",
         "EventName": "RS_EMPTY.CYCLES",
         "PEBScounters": "0,1,2,3,4,5,6,7",
diff --git a/tools/perf/pmu-events/arch/x86/alderlake/pipeline.json b/tools=
/perf/pmu-events/arch/x86/alderlake/pipeline.json
index 1a137f7f8b7e..82077970bb37 100644
--- a/tools/perf/pmu-events/arch/x86/alderlake/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/alderlake/pipeline.json
@@ -7,6 +7,7 @@
         "EventName": "BR_INST_RETIRED.ALL_BRANCHES",
         "PEBS": "1",
         "PEBScounters": "0,1,2,3,4,5",
+        "PublicDescription": "Counts the total number of instructions in w=
hich the instruction pointer (IP) of the processor is resteered due to a br=
anch instruction and the branch instruction successfully retires.  All bran=
ch type instructions are accounted for.",
         "SampleAfterValue": "200003",
         "Unit": "cpu_atom"
     },
@@ -14,6 +15,7 @@
         "BriefDescription": "This event is deprecated. Refer to new event =
BR_INST_RETIRED.NEAR_CALL",
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3,4,5",
+        "Deprecated": "1",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.CALL",
         "PEBS": "1",
@@ -86,6 +88,7 @@
         "BriefDescription": "This event is deprecated. Refer to new event =
BR_INST_RETIRED.INDIRECT_CALL",
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3,4,5",
+        "Deprecated": "1",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.IND_CALL",
         "PEBS": "1",
@@ -98,6 +101,7 @@
         "BriefDescription": "This event is deprecated. Refer to new event =
BR_INST_RETIRED.COND",
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3,4,5",
+        "Deprecated": "1",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.JCC",
         "PEBS": "1",
@@ -134,6 +138,7 @@
         "BriefDescription": "This event is deprecated. Refer to new event =
BR_INST_RETIRED.INDIRECT",
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3,4,5",
+        "Deprecated": "1",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.NON_RETURN_IND",
         "PEBS": "1",
@@ -158,6 +163,7 @@
         "BriefDescription": "This event is deprecated. Refer to new event =
BR_INST_RETIRED.NEAR_RETURN",
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3,4,5",
+        "Deprecated": "1",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.RETURN",
         "PEBS": "1",
@@ -170,6 +176,7 @@
         "BriefDescription": "This event is deprecated. Refer to new event =
BR_INST_RETIRED.COND_TAKEN",
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3,4,5",
+        "Deprecated": "1",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.TAKEN_JCC",
         "PEBS": "1",
@@ -186,6 +193,7 @@
         "EventName": "BR_MISP_RETIRED.ALL_BRANCHES",
         "PEBS": "1",
         "PEBScounters": "0,1,2,3,4,5",
+        "PublicDescription": "Counts the total number of mispredicted bran=
ch instructions retired.  All branch type instructions are accounted for.  =
Prediction of the branch target address enables the processor to begin exec=
uting instructions before the non-speculative execution path is known. The =
branch prediction unit (BPU) predicts the target address based on the instr=
uction pointer (IP) of the branch and on the execution path through which e=
xecution reached this IP.    A branch misprediction occurs when the predict=
ion is wrong, and results in discarding all instructions executed in the sp=
eculative path and re-fetching from the correct path.",
         "SampleAfterValue": "200003",
         "Unit": "cpu_atom"
     },
@@ -241,6 +249,7 @@
         "BriefDescription": "This event is deprecated. Refer to new event =
BR_MISP_RETIRED.INDIRECT_CALL",
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3,4,5",
+        "Deprecated": "1",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.IND_CALL",
         "PEBS": "1",
@@ -253,6 +262,7 @@
         "BriefDescription": "This event is deprecated. Refer to new event =
BR_MISP_RETIRED.COND",
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3,4,5",
+        "Deprecated": "1",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.JCC",
         "PEBS": "1",
@@ -265,6 +275,7 @@
         "BriefDescription": "This event is deprecated. Refer to new event =
BR_MISP_RETIRED.INDIRECT",
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3,4,5",
+        "Deprecated": "1",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.NON_RETURN_IND",
         "PEBS": "1",
@@ -289,6 +300,7 @@
         "BriefDescription": "This event is deprecated. Refer to new event =
BR_MISP_RETIRED.COND_TAKEN",
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3,4,5",
+        "Deprecated": "1",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.TAKEN_JCC",
         "PEBS": "1",
@@ -303,6 +315,7 @@
         "Counter": "Fixed counter 1",
         "EventName": "CPU_CLK_UNHALTED.CORE",
         "PEBScounters": "33",
+        "PublicDescription": "Counts the number of core cycles while the c=
ore is not in a halt state. The core enters the halt state when it is runni=
ng the HLT instruction. The core frequency may change from time to time. Fo=
r this reason this event may have a changing ratio with regards to time. Th=
is event uses fixed counter 1.",
         "SampleAfterValue": "2000003",
         "Speculative": "1",
         "UMask": "0x2",
@@ -315,6 +328,7 @@
         "EventCode": "0x3c",
         "EventName": "CPU_CLK_UNHALTED.CORE_P",
         "PEBScounters": "0,1,2,3,4,5",
+        "PublicDescription": "Counts the number of core cycles while the c=
ore is not in a halt state. The core enters the halt state when it is runni=
ng the HLT instruction. The core frequency may change from time to time. Fo=
r this reason this event may have a changing ratio with regards to time. Th=
is event uses a programmable general purpose performance counter.",
         "SampleAfterValue": "2000003",
         "Speculative": "1",
         "Unit": "cpu_atom"
@@ -325,6 +339,7 @@
         "Counter": "Fixed counter 2",
         "EventName": "CPU_CLK_UNHALTED.REF_TSC",
         "PEBScounters": "34",
+        "PublicDescription": "Counts the number of reference cycles that t=
he core is not in a halt state. The core enters the halt state when it is r=
unning the HLT instruction. This event is not affected by core frequency ch=
anges and increments at a fixed frequency that is also used for the Time St=
amp Counter (TSC). This event uses fixed counter 2.",
         "SampleAfterValue": "2000003",
         "Speculative": "1",
         "UMask": "0x3",
@@ -337,6 +352,7 @@
         "EventCode": "0x3c",
         "EventName": "CPU_CLK_UNHALTED.REF_TSC_P",
         "PEBScounters": "0,1,2,3,4,5",
+        "PublicDescription": "Counts the number of reference cycles that t=
he core is not in a halt state. The core enters the halt state when it is r=
unning the HLT instruction. This event is not affected by core frequency ch=
anges and increments at a fixed frequency that is also used for the Time St=
amp Counter (TSC). This event uses a programmable general purpose performan=
ce counter.",
         "SampleAfterValue": "2000003",
         "Speculative": "1",
         "UMask": "0x1",
@@ -348,6 +364,7 @@
         "Counter": "Fixed counter 1",
         "EventName": "CPU_CLK_UNHALTED.THREAD",
         "PEBScounters": "33",
+        "PublicDescription": "Counts the number of core cycles while the c=
ore is not in a halt state.  The core enters the halt state when it is runn=
ing the HLT instruction. The core frequency may change from time to time. F=
or this reason this event may have a changing ratio with regards to time.  =
This event uses fixed counter 1.",
         "SampleAfterValue": "2000003",
         "Speculative": "1",
         "UMask": "0x2",
@@ -360,6 +377,7 @@
         "EventCode": "0x3c",
         "EventName": "CPU_CLK_UNHALTED.THREAD_P",
         "PEBScounters": "0,1,2,3,4,5",
+        "PublicDescription": "Counts the number of core cycles while the c=
ore is not in a halt state.  The core enters the halt state when it is runn=
ing the HLT instruction. The core frequency may change from time to time. F=
or this reason this event may have a changing ratio with regards to time. T=
his event uses a programmable general purpose performance counter.",
         "SampleAfterValue": "2000003",
         "Speculative": "1",
         "Unit": "cpu_atom"
@@ -371,6 +389,7 @@
         "EventName": "INST_RETIRED.ANY",
         "PEBS": "1",
         "PEBScounters": "32",
+        "PublicDescription": "Counts the total number of instructions that=
 retired. For instructions that consist of multiple uops, this event counts=
 the retirement of the last uop of the instruction. This event continues co=
unting during hardware interrupts, traps, and inside interrupt handlers. Th=
is event uses fixed counter 0.",
         "SampleAfterValue": "2000003",
         "UMask": "0x1",
         "Unit": "cpu_atom"
@@ -383,6 +402,7 @@
         "EventName": "INST_RETIRED.ANY_P",
         "PEBS": "1",
         "PEBScounters": "0,1,2,3,4,5",
+        "PublicDescription": "Counts the total number of instructions that=
 retired. For instructions that consist of multiple uops, this event counts=
 the retirement of the last uop of the instruction. This event continues co=
unting during hardware interrupts, traps, and inside interrupt handlers. Th=
is event uses a programmable general purpose performance counter.",
         "SampleAfterValue": "2000003",
         "Unit": "cpu_atom"
     },
@@ -390,6 +410,7 @@
         "BriefDescription": "This event is deprecated. Refer to new event =
LD_BLOCKS.ADDRESS_ALIAS",
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3,4,5",
+        "Deprecated": "1",
         "EventCode": "0x03",
         "EventName": "LD_BLOCKS.4K_ALIAS",
         "PEBS": "1",
@@ -489,6 +510,7 @@
         "EventCode": "0x75",
         "EventName": "SERIALIZATION.NON_C01_MS_SCB",
         "PEBScounters": "0,1,2,3,4,5",
+        "PublicDescription": "Counts the number of issue slots not consume=
d by the backend due to a micro-sequencer (MS) scoreboard, which stalls the=
 front-end from issuing from the UROM until a specified older uop retires. =
The most commonly executed instruction with an MS scoreboard is PAUSE.",
         "SampleAfterValue": "200003",
         "Speculative": "1",
         "UMask": "0x2",
@@ -501,6 +523,7 @@
         "EventCode": "0x73",
         "EventName": "TOPDOWN_BAD_SPECULATION.ALL",
         "PEBScounters": "0,1,2,3,4,5",
+        "PublicDescription": "Counts the total number of issue slots that =
were not consumed by the backend because allocation is stalled due to a mis=
predicted jump or a machine clear. Only issue slots wasted due to fast nuke=
s such as memory ordering nukes are counted. Other nukes are not accounted =
for. Counts all issue slots blocked during this recovery window including r=
elevant microcode flows and while uops are not yet available in the instruc=
tion queue (IQ) even if an FE_bound event occurs during this period. Also i=
ncludes the issue slots that were consumed by the backend but were thrown a=
way because they were younger than the mispredict or machine clear.",
         "SampleAfterValue": "1000003",
         "Speculative": "1",
         "Unit": "cpu_atom"
@@ -654,6 +677,7 @@
         "EventCode": "0x71",
         "EventName": "TOPDOWN_FE_BOUND.BRANCH_DETECT",
         "PEBScounters": "0,1,2,3,4,5",
+        "PublicDescription": "Counts the number of issue slots every cycle=
 that were not delivered by the frontend due to BACLEARS, which occurs when=
 the Branch Target Buffer (BTB) prediction or lack thereof, was corrected b=
y a later branch predictor in the frontend. Includes BACLEARS due to all br=
anch types including conditional and unconditional jumps, returns, and indi=
rect branches.",
         "SampleAfterValue": "1000003",
         "Speculative": "1",
         "UMask": "0x2",
@@ -666,6 +690,7 @@
         "EventCode": "0x71",
         "EventName": "TOPDOWN_FE_BOUND.BRANCH_RESTEER",
         "PEBScounters": "0,1,2,3,4,5",
+        "PublicDescription": "Counts the number of issue slots every cycle=
 that were not delivered by the frontend due to BTCLEARS, which occurs when=
 the Branch Target Buffer (BTB) predicts a taken branch.",
         "SampleAfterValue": "1000003",
         "Speculative": "1",
         "UMask": "0x40",
@@ -726,6 +751,7 @@
         "EventCode": "0x71",
         "EventName": "TOPDOWN_FE_BOUND.ITLB",
         "PEBScounters": "0,1,2,3,4,5",
+        "PublicDescription": "Counts the number of issue slots every cycle=
 that were not delivered by the frontend due to Instruction Table Lookaside=
 Buffer (ITLB) misses.",
         "SampleAfterValue": "1000003",
         "Speculative": "1",
         "UMask": "0x10",
@@ -797,6 +823,7 @@
         "EventName": "UOPS_RETIRED.MS",
         "PEBS": "1",
         "PEBScounters": "0,1,2,3,4,5",
+        "PublicDescription": "Counts the number of uops that are from comp=
lex flows issued by the Microcode Sequencer (MS). This includes uops from f=
lows due to complex instructions, faults, assists, and inserted flows.",
         "SampleAfterValue": "2000003",
         "UMask": "0x1",
         "Unit": "cpu_atom"
@@ -818,6 +845,7 @@
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
+        "Deprecated": "1",
         "EventCode": "0xb0",
         "EventName": "ARITH.DIVIDER_ACTIVE",
         "PEBScounters": "0,1,2,3,4,5,6,7",
@@ -834,6 +862,7 @@
         "EventCode": "0xb0",
         "EventName": "ARITH.DIV_ACTIVE",
         "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts cycles when divide unit is busy execu=
ting divide or square root operations. Accounts for integer and floating-po=
int operations.",
         "SampleAfterValue": "1000003",
         "Speculative": "1",
         "UMask": "0x9",
@@ -844,6 +873,7 @@
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
+        "Deprecated": "1",
         "EventCode": "0xb0",
         "EventName": "ARITH.FP_DIVIDER_ACTIVE",
         "PEBScounters": "0,1,2,3,4,5,6,7",
@@ -869,6 +899,7 @@
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
+        "Deprecated": "1",
         "EventCode": "0xb0",
         "EventName": "ARITH.INT_DIVIDER_ACTIVE",
         "PEBScounters": "0,1,2,3,4,5,6,7",
@@ -884,6 +915,7 @@
         "EventCode": "0xc1",
         "EventName": "ASSISTS.ANY",
         "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts the number of occurrences where a mic=
rocode assist is invoked by hardware. Examples include AD (page Access Dirt=
y), FP and AVX related assists.",
         "SampleAfterValue": "100003",
         "Speculative": "1",
         "UMask": "0x1b",
@@ -897,6 +929,7 @@
         "EventName": "BR_INST_RETIRED.ALL_BRANCHES",
         "PEBS": "1",
         "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts all branch instructions retired.",
         "SampleAfterValue": "400009",
         "Unit": "cpu_core"
     },
@@ -908,6 +941,7 @@
         "EventName": "BR_INST_RETIRED.COND",
         "PEBS": "1",
         "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts conditional branch instructions retir=
ed.",
         "SampleAfterValue": "400009",
         "UMask": "0x11",
         "Unit": "cpu_core"
@@ -920,6 +954,7 @@
         "EventName": "BR_INST_RETIRED.COND_NTAKEN",
         "PEBS": "1",
         "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts not taken branch instructions retired=
.",
         "SampleAfterValue": "400009",
         "UMask": "0x10",
         "Unit": "cpu_core"
@@ -932,6 +967,7 @@
         "EventName": "BR_INST_RETIRED.COND_TAKEN",
         "PEBS": "1",
         "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts taken conditional branch instructions=
 retired.",
         "SampleAfterValue": "400009",
         "UMask": "0x1",
         "Unit": "cpu_core"
@@ -944,6 +980,7 @@
         "EventName": "BR_INST_RETIRED.FAR_BRANCH",
         "PEBS": "1",
         "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts far branch instructions retired.",
         "SampleAfterValue": "100007",
         "UMask": "0x40",
         "Unit": "cpu_core"
@@ -956,6 +993,7 @@
         "EventName": "BR_INST_RETIRED.INDIRECT",
         "PEBS": "1",
         "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts near indirect branch instructions ret=
ired excluding returns. TSX abort is an indirect branch.",
         "SampleAfterValue": "100003",
         "UMask": "0x80",
         "Unit": "cpu_core"
@@ -968,6 +1006,7 @@
         "EventName": "BR_INST_RETIRED.NEAR_CALL",
         "PEBS": "1",
         "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts both direct and indirect near call in=
structions retired.",
         "SampleAfterValue": "100007",
         "UMask": "0x2",
         "Unit": "cpu_core"
@@ -980,6 +1019,7 @@
         "EventName": "BR_INST_RETIRED.NEAR_RETURN",
         "PEBS": "1",
         "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts return instructions retired.",
         "SampleAfterValue": "100007",
         "UMask": "0x8",
         "Unit": "cpu_core"
@@ -992,6 +1032,7 @@
         "EventName": "BR_INST_RETIRED.NEAR_TAKEN",
         "PEBS": "1",
         "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts taken branch instructions retired.",
         "SampleAfterValue": "400009",
         "UMask": "0x20",
         "Unit": "cpu_core"
@@ -1004,6 +1045,7 @@
         "EventName": "BR_MISP_RETIRED.ALL_BRANCHES",
         "PEBS": "1",
         "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts all the retired branch instructions t=
hat were mispredicted by the processor. A branch misprediction occurs when =
the processor incorrectly predicts the destination of the branch.  When the=
 misprediction is discovered at execution, all the instructions executed in=
 the wrong (speculative) path must be discarded, and the processor must sta=
rt fetching from the correct path.",
         "SampleAfterValue": "400009",
         "Unit": "cpu_core"
     },
@@ -1015,6 +1057,7 @@
         "EventName": "BR_MISP_RETIRED.COND",
         "PEBS": "1",
         "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts mispredicted conditional branch instr=
uctions retired.",
         "SampleAfterValue": "400009",
         "UMask": "0x11",
         "Unit": "cpu_core"
@@ -1027,6 +1070,7 @@
         "EventName": "BR_MISP_RETIRED.COND_NTAKEN",
         "PEBS": "1",
         "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts the number of conditional branch inst=
ructions retired that were mispredicted and the branch direction was not ta=
ken.",
         "SampleAfterValue": "400009",
         "UMask": "0x10",
         "Unit": "cpu_core"
@@ -1039,6 +1083,7 @@
         "EventName": "BR_MISP_RETIRED.COND_TAKEN",
         "PEBS": "1",
         "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts taken conditional mispredicted branch=
 instructions retired.",
         "SampleAfterValue": "400009",
         "UMask": "0x1",
         "Unit": "cpu_core"
@@ -1051,6 +1096,7 @@
         "EventName": "BR_MISP_RETIRED.INDIRECT_CALL",
         "PEBS": "1",
         "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts retired mispredicted indirect (near t=
aken) CALL instructions, including both register and memory indirect.",
         "SampleAfterValue": "400009",
         "UMask": "0x2",
         "Unit": "cpu_core"
@@ -1063,6 +1109,7 @@
         "EventName": "BR_MISP_RETIRED.NEAR_TAKEN",
         "PEBS": "1",
         "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts number of near branch instructions re=
tired that were mispredicted and taken.",
         "SampleAfterValue": "400009",
         "UMask": "0x20",
         "Unit": "cpu_core"
@@ -1075,6 +1122,7 @@
         "EventName": "BR_MISP_RETIRED.RET",
         "PEBS": "1",
         "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "This is a non-precise version (that is, does=
 not use PEBS) of the event that counts mispredicted return instructions re=
tired.",
         "SampleAfterValue": "100007",
         "UMask": "0x8",
         "Unit": "cpu_core"
@@ -1086,6 +1134,7 @@
         "EventCode": "0xec",
         "EventName": "CPU_CLK_UNHALTED.C01",
         "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts core clocks when the thread is in the=
 C0.1 light-weight slower wakeup time but more power saving optimized state=
.  This state can be entered via the TPAUSE or UMWAIT instructions.",
         "SampleAfterValue": "2000003",
         "Speculative": "1",
         "UMask": "0x10",
@@ -1098,6 +1147,7 @@
         "EventCode": "0xec",
         "EventName": "CPU_CLK_UNHALTED.C02",
         "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts core clocks when the thread is in the=
 C0.2 light-weight faster wakeup time but less power saving optimized state=
.  This state can be entered via the TPAUSE or UMWAIT instructions.",
         "SampleAfterValue": "2000003",
         "Speculative": "1",
         "UMask": "0x20",
@@ -1110,6 +1160,7 @@
         "EventCode": "0xec",
         "EventName": "CPU_CLK_UNHALTED.C0_WAIT",
         "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts core clocks when the thread is in the=
 C0.1 or C0.2 power saving optimized states (TPAUSE or UMWAIT instructions)=
 or running the PAUSE instruction.",
         "SampleAfterValue": "2000003",
         "Speculative": "1",
         "UMask": "0x70",
@@ -1122,6 +1173,7 @@
         "EventCode": "0xec",
         "EventName": "CPU_CLK_UNHALTED.DISTRIBUTED",
         "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "This event distributes cycle counts between =
active hyperthreads, i.e., those in C0.  A hyperthread becomes inactive whe=
n it executes the HLT or MWAIT instructions.  If all other hyperthreads are=
 inactive (or disabled or do not exist), all counts are attributed to this =
hyperthread. To obtain the full count when the Core is active, sum the coun=
ts from each hyperthread.",
         "SampleAfterValue": "2000003",
         "Speculative": "1",
         "UMask": "0x2",
@@ -1134,6 +1186,7 @@
         "EventCode": "0x3c",
         "EventName": "CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE",
         "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts Core crystal clock cycles when curren=
t thread is unhalted and the other thread is halted.",
         "SampleAfterValue": "25003",
         "Speculative": "1",
         "UMask": "0x2",
@@ -1153,6 +1206,7 @@
     },
     {
         "BriefDescription": "CPU_CLK_UNHALTED.PAUSE_INST",
+        "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
         "EdgeDetect": "1",
@@ -1166,10 +1220,12 @@
     },
     {
         "BriefDescription": "Core crystal clock cycles. Cycle counts are e=
venly distributed between active threads in the Core.",
+        "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x3c",
         "EventName": "CPU_CLK_UNHALTED.REF_DISTRIBUTED",
         "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "This event distributes Core crystal clock cy=
cle counts between active hyperthreads, i.e., those in C0 sleep-state. A hy=
perthread becomes inactive when it executes the HLT or MWAIT instructions. =
If one thread is active in a core, all counts are attributed to this hypert=
hread. To obtain the full count when the Core is active, sum the counts fro=
m each hyperthread.",
         "SampleAfterValue": "2000003",
         "Speculative": "1",
         "UMask": "0x8",
@@ -1181,6 +1237,7 @@
         "Counter": "Fixed counter 2",
         "EventName": "CPU_CLK_UNHALTED.REF_TSC",
         "PEBScounters": "34",
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
         "Speculative": "1",
         "UMask": "0x3",
@@ -1193,6 +1250,7 @@
         "EventCode": "0x3c",
         "EventName": "CPU_CLK_UNHALTED.REF_TSC_P",
         "PEBScounters": "0,1,2,3,4,5,6,7",
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
         "Speculative": "1",
         "UMask": "0x1",
@@ -1204,6 +1262,7 @@
         "Counter": "Fixed counter 1",
         "EventName": "CPU_CLK_UNHALTED.THREAD",
         "PEBScounters": "33",
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
         "Speculative": "1",
         "UMask": "0x2",
@@ -1216,6 +1275,7 @@
         "EventCode": "0x3c",
         "EventName": "CPU_CLK_UNHALTED.THREAD_P",
         "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "This is an architectural event that counts t=
he number of thread cycles while the thread is not in a halt state. The thr=
ead enters the halt state when it is running the HLT instruction. The core =
frequency may change from time to time due to power or thermal throttling. =
For this reason, this event may have a changing ratio with regards to wall =
clock time.",
         "SampleAfterValue": "2000003",
         "Speculative": "1",
         "Unit": "cpu_core"
@@ -1305,6 +1365,7 @@
         "EventCode": "0xa6",
         "EventName": "EXE_ACTIVITY.1_PORTS_UTIL",
         "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts cycles during which a total of 1 uop =
was executed on all ports and Reservation Station (RS) was not empty.",
         "SampleAfterValue": "2000003",
         "Speculative": "1",
         "UMask": "0x2",
@@ -1317,6 +1378,7 @@
         "EventCode": "0xa6",
         "EventName": "EXE_ACTIVITY.2_PORTS_UTIL",
         "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts cycles during which a total of 2 uops=
 were executed on all ports and Reservation Station (RS) was not empty.",
         "SampleAfterValue": "2000003",
         "Speculative": "1",
         "UMask": "0x4",
@@ -1329,6 +1391,7 @@
         "EventCode": "0xa6",
         "EventName": "EXE_ACTIVITY.3_PORTS_UTIL",
         "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Cycles total of 3 uops are executed on all p=
orts and Reservation Station (RS) was not empty.",
         "SampleAfterValue": "2000003",
         "Speculative": "1",
         "UMask": "0x8",
@@ -1341,6 +1404,7 @@
         "EventCode": "0xa6",
         "EventName": "EXE_ACTIVITY.4_PORTS_UTIL",
         "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Cycles total of 4 uops are executed on all p=
orts and Reservation Station (RS) was not empty.",
         "SampleAfterValue": "2000003",
         "Speculative": "1",
         "UMask": "0x10",
@@ -1367,6 +1431,7 @@
         "EventCode": "0xa6",
         "EventName": "EXE_ACTIVITY.BOUND_ON_STORES",
         "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts cycles where the Store Buffer was ful=
l and no loads caused an execution stall.",
         "SampleAfterValue": "1000003",
         "Speculative": "1",
         "UMask": "0x40",
@@ -1379,6 +1444,7 @@
         "EventCode": "0xa6",
         "EventName": "EXE_ACTIVITY.EXE_BOUND_0_PORTS",
         "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Number of cycles total of 0 uops executed on=
 all ports, Reservation Station (RS) was not empty, the Store Buffer (SB) w=
as not full and there was no outstanding load.",
         "SampleAfterValue": "1000003",
         "Speculative": "1",
         "UMask": "0x80",
@@ -1391,6 +1457,7 @@
         "EventCode": "0x75",
         "EventName": "INST_DECODED.DECODERS",
         "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Number of decoders utilized in a cycle when =
the MITE (legacy decode pipeline) fetches instructions.",
         "SampleAfterValue": "2000003",
         "Speculative": "1",
         "UMask": "0x1",
@@ -1403,6 +1470,7 @@
         "EventName": "INST_RETIRED.ANY",
         "PEBS": "1",
         "PEBScounters": "32",
+        "PublicDescription": "Counts the number of X86 instructions retire=
d - an Architectural PerfMon event. Counting continues during hardware inte=
rrupts, traps, and inside interrupt handlers. Notes: INST_RETIRED.ANY is co=
unted by a designated fixed counter freeing up programmable counters to cou=
nt other events. INST_RETIRED.ANY_P is counted by a programmable counter.",
         "SampleAfterValue": "2000003",
         "UMask": "0x1",
         "Unit": "cpu_core"
@@ -1415,6 +1483,7 @@
         "EventName": "INST_RETIRED.ANY_P",
         "PEBS": "1",
         "PEBScounters": "1,2,3,4,5,6,7",
+        "PublicDescription": "Counts the number of X86 instructions retire=
d - an Architectural PerfMon event. Counting continues during hardware inte=
rrupts, traps, and inside interrupt handlers. Notes: INST_RETIRED.ANY is co=
unted by a designated fixed counter freeing up programmable counters to cou=
nt other events. INST_RETIRED.ANY_P is counted by a programmable counter.",
         "SampleAfterValue": "2000003",
         "Unit": "cpu_core"
     },
@@ -1436,6 +1505,7 @@
         "EventCode": "0xc0",
         "EventName": "INST_RETIRED.NOP",
         "PEBScounters": "1,2,3,4,5,6,7",
+        "PublicDescription": "Counts all retired NOP or ENDBR32/64 instruc=
tions",
         "SampleAfterValue": "2000003",
         "UMask": "0x2",
         "Unit": "cpu_core"
@@ -1447,6 +1517,7 @@
         "EventName": "INST_RETIRED.PREC_DIST",
         "PEBS": "1",
         "PEBScounters": "32",
+        "PublicDescription": "A version of INST_RETIRED that allows for a =
precise distribution of samples across instructions retired. It utilizes th=
e Precise Distribution of Instructions Retired (PDIR++) feature to fix bias=
 in how retired instructions get sampled. Use on Fixed Counter 0.",
         "SampleAfterValue": "2000003",
         "UMask": "0x1",
         "Unit": "cpu_core"
@@ -1469,6 +1540,7 @@
         "EventCode": "0xad",
         "EventName": "INT_MISC.CLEAR_RESTEER_CYCLES",
         "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Cycles after recovery from a branch mispredi=
ction or machine clear till the first uop is issued from the resteered path=
.",
         "SampleAfterValue": "500009",
         "Speculative": "1",
         "UMask": "0x80",
@@ -1481,6 +1553,7 @@
         "EventCode": "0xad",
         "EventName": "INT_MISC.RECOVERY_CYCLES",
         "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts core cycles when the Resource allocat=
or was stalled due to recovery from an earlier branch misprediction or mach=
ine clear event.",
         "SampleAfterValue": "500009",
         "Speculative": "1",
         "UMask": "0x1",
@@ -1508,6 +1581,7 @@
         "EventCode": "0xad",
         "EventName": "INT_MISC.UOP_DROPPING",
         "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Estimated number of Top-down Microarchitectu=
re Analysis slots that got dropped due to non front-end reasons",
         "SampleAfterValue": "1000003",
         "Speculative": "1",
         "UMask": "0x10",
@@ -1542,6 +1616,7 @@
         "EventCode": "0xe7",
         "EventName": "INT_VEC_RETIRED.ADD_128",
         "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Number of retired integer ADD/SUB (regular o=
r horizontal), SAD 128-bit vector instructions.",
         "SampleAfterValue": "1000003",
         "UMask": "0x3",
         "Unit": "cpu_core"
@@ -1553,6 +1628,7 @@
         "EventCode": "0xe7",
         "EventName": "INT_VEC_RETIRED.ADD_256",
         "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Number of retired integer ADD/SUB (regular o=
r horizontal), SAD 256-bit vector instructions.",
         "SampleAfterValue": "1000003",
         "UMask": "0xc",
         "Unit": "cpu_core"
@@ -1608,6 +1684,7 @@
         "EventCode": "0x03",
         "EventName": "LD_BLOCKS.ADDRESS_ALIAS",
         "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts the number of times a load got blocke=
d due to false dependencies in MOB due to partial compare on address.",
         "SampleAfterValue": "100003",
         "Speculative": "1",
         "UMask": "0x4",
@@ -1620,6 +1697,7 @@
         "EventCode": "0x03",
         "EventName": "LD_BLOCKS.NO_SR",
         "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts the number of times that split load o=
perations are temporarily blocked because all resources for handling the sp=
lit accesses are in use.",
         "SampleAfterValue": "100003",
         "Speculative": "1",
         "UMask": "0x88",
@@ -1632,6 +1710,7 @@
         "EventCode": "0x03",
         "EventName": "LD_BLOCKS.STORE_FORWARD",
         "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts the number of times where store forwa=
rding was prevented for a load operation. The most common case is a load bl=
ocked due to the address of memory access (partially) overlapping with a pr=
eceding uncompleted store. Note: See the table of not supported store forwa=
rds in the Optimization Guide.",
         "SampleAfterValue": "100003",
         "Speculative": "1",
         "UMask": "0x82",
@@ -1644,6 +1723,7 @@
         "EventCode": "0x4c",
         "EventName": "LOAD_HIT_PREFETCH.SWPF",
         "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts all not software-prefetch load dispat=
ches that hit the fill buffer (FB) allocated for the software prefetch. It =
can also be incremented by some lock instructions. So it should only be use=
d with profiling so that the locks can be excluded by ASM (Assembly File) i=
nspection of the nearby instructions.",
         "SampleAfterValue": "100003",
         "Speculative": "1",
         "UMask": "0x1",
@@ -1657,6 +1737,7 @@
         "EventCode": "0xa8",
         "EventName": "LSD.CYCLES_ACTIVE",
         "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts the cycles when at least one uop is d=
elivered by the LSD (Loop-stream detector).",
         "SampleAfterValue": "2000003",
         "Speculative": "1",
         "UMask": "0x1",
@@ -1670,6 +1751,7 @@
         "EventCode": "0xa8",
         "EventName": "LSD.CYCLES_OK",
         "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts the cycles when optimal number of uop=
s is delivered by the LSD (Loop-stream detector).",
         "SampleAfterValue": "2000003",
         "Speculative": "1",
         "UMask": "0x1",
@@ -1682,6 +1764,7 @@
         "EventCode": "0xa8",
         "EventName": "LSD.UOPS",
         "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts the number of uops delivered to the b=
ack-end by the LSD(Loop Stream Detector).",
         "SampleAfterValue": "2000003",
         "Speculative": "1",
         "UMask": "0x1",
@@ -1696,6 +1779,7 @@
         "EventCode": "0xc3",
         "EventName": "MACHINE_CLEARS.COUNT",
         "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts the number of machine clears (nukes) =
of any type.",
         "SampleAfterValue": "100003",
         "Speculative": "1",
         "UMask": "0x1",
@@ -1708,6 +1792,7 @@
         "EventCode": "0xc3",
         "EventName": "MACHINE_CLEARS.SMC",
         "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts self-modifying code (SMC) detected, w=
hich causes a machine clear.",
         "SampleAfterValue": "100003",
         "Speculative": "1",
         "UMask": "0x4",
@@ -1732,6 +1817,7 @@
         "EventCode": "0xcc",
         "EventName": "MISC_RETIRED.LBR_INSERTS",
         "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Increments when an entry is added to the Las=
t Branch Record (LBR) array (or removed from the array in case of RETURNs i=
n call stack mode). The event requires LBR enable via IA32_DEBUGCTL MSR and=
 branch type selection via MSR_LBR_SELECT.",
         "SampleAfterValue": "100003",
         "UMask": "0x20",
         "Unit": "cpu_core"
@@ -1743,6 +1829,7 @@
         "EventCode": "0xa2",
         "EventName": "RESOURCE_STALLS.SB",
         "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts allocation stall cycles caused by the=
 store buffer (SB) being full. This counts cycles that the pipeline back-en=
d blocked uop delivery from the front-end.",
         "SampleAfterValue": "100003",
         "Speculative": "1",
         "UMask": "0x8",
@@ -1767,6 +1854,7 @@
         "EventCode": "0xa4",
         "EventName": "TOPDOWN.BACKEND_BOUND_SLOTS",
         "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Number of slots in TMA method where no micro=
-operations were being issued from front-end to back-end of the machine due=
 to lack of back-end resources.",
         "SampleAfterValue": "10000003",
         "Speculative": "1",
         "UMask": "0x2",
@@ -1777,6 +1865,7 @@
         "CollectPEBSRecord": "2",
         "EventCode": "0xa4",
         "EventName": "TOPDOWN.BAD_SPEC_SLOTS",
+        "PublicDescription": "Number of slots of TMA method that were wast=
ed due to incorrect speculation. It covers all types of control-flow or dat=
a-related mis-speculations.",
         "SampleAfterValue": "10000003",
         "Speculative": "1",
         "UMask": "0x4",
@@ -1787,6 +1876,7 @@
         "CollectPEBSRecord": "2",
         "EventCode": "0xa4",
         "EventName": "TOPDOWN.BR_MISPREDICT_SLOTS",
+        "PublicDescription": "Number of TMA slots that were wasted due to =
incorrect speculation by (any type of) branch mispredictions. This event es=
timates number of specualtive operations that were issued but not retired a=
s well as the out-of-order engine recovery past a branch misprediction.",
         "SampleAfterValue": "10000003",
         "Speculative": "1",
         "UMask": "0x8",
@@ -1810,6 +1900,7 @@
         "Counter": "Fixed counter 3",
         "EventName": "TOPDOWN.SLOTS",
         "PEBScounters": "35",
+        "PublicDescription": "Number of available slots for an unhalted lo=
gical processor. The event increments by machine-width of the narrowest pip=
eline as employed by the Top-down Microarchitecture Analysis method (TMA). =
The count is distributed among unhalted logical processors (hyper-threads) =
who share the same physical core. Software can use this event as the denomi=
nator for the top-level metrics of the TMA method. This architectural event=
 is counted on a designated fixed counter (Fixed Counter 3).",
         "SampleAfterValue": "10000003",
         "Speculative": "1",
         "UMask": "0x4",
@@ -1822,6 +1913,7 @@
         "EventCode": "0xa4",
         "EventName": "TOPDOWN.SLOTS_P",
         "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts the number of available slots for an =
unhalted logical processor. The event increments by machine-width of the na=
rrowest pipeline as employed by the Top-down Microarchitecture Analysis met=
hod. The count is distributed among unhalted logical processors (hyper-thre=
ads) who share the same physical core.",
         "SampleAfterValue": "10000003",
         "Speculative": "1",
         "UMask": "0x1",
@@ -1846,6 +1938,7 @@
         "EventCode": "0xb2",
         "EventName": "UOPS_DISPATCHED.PORT_0",
         "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Number of uops dispatch to execution  port 0=
.",
         "SampleAfterValue": "2000003",
         "Speculative": "1",
         "UMask": "0x1",
@@ -1858,6 +1951,7 @@
         "EventCode": "0xb2",
         "EventName": "UOPS_DISPATCHED.PORT_1",
         "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Number of uops dispatch to execution  port 1=
.",
         "SampleAfterValue": "2000003",
         "Speculative": "1",
         "UMask": "0x2",
@@ -1870,6 +1964,7 @@
         "EventCode": "0xb2",
         "EventName": "UOPS_DISPATCHED.PORT_2_3_10",
         "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Number of uops dispatch to execution ports 2=
, 3 and 10",
         "SampleAfterValue": "2000003",
         "Speculative": "1",
         "UMask": "0x4",
@@ -1882,6 +1977,7 @@
         "EventCode": "0xb2",
         "EventName": "UOPS_DISPATCHED.PORT_4_9",
         "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Number of uops dispatch to execution ports 4=
 and 9",
         "SampleAfterValue": "2000003",
         "Speculative": "1",
         "UMask": "0x10",
@@ -1894,6 +1990,7 @@
         "EventCode": "0xb2",
         "EventName": "UOPS_DISPATCHED.PORT_5_11",
         "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Number of uops dispatch to execution ports 5=
 and 11",
         "SampleAfterValue": "2000003",
         "Speculative": "1",
         "UMask": "0x20",
@@ -1906,6 +2003,7 @@
         "EventCode": "0xb2",
         "EventName": "UOPS_DISPATCHED.PORT_6",
         "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Number of uops dispatch to execution  port 6=
.",
         "SampleAfterValue": "2000003",
         "Speculative": "1",
         "UMask": "0x40",
@@ -1918,6 +2016,7 @@
         "EventCode": "0xb2",
         "EventName": "UOPS_DISPATCHED.PORT_7_8",
         "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Number of uops dispatch to execution  ports =
7 and 8.",
         "SampleAfterValue": "2000003",
         "Speculative": "1",
         "UMask": "0x80",
@@ -1931,6 +2030,7 @@
         "EventCode": "0xb1",
         "EventName": "UOPS_EXECUTED.CORE_CYCLES_GE_1",
         "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts cycles when at least 1 micro-op is ex=
ecuted from any thread on physical core.",
         "SampleAfterValue": "2000003",
         "Speculative": "1",
         "UMask": "0x2",
@@ -1944,6 +2044,7 @@
         "EventCode": "0xb1",
         "EventName": "UOPS_EXECUTED.CORE_CYCLES_GE_2",
         "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts cycles when at least 2 micro-ops are =
executed from any thread on physical core.",
         "SampleAfterValue": "2000003",
         "Speculative": "1",
         "UMask": "0x2",
@@ -1957,6 +2058,7 @@
         "EventCode": "0xb1",
         "EventName": "UOPS_EXECUTED.CORE_CYCLES_GE_3",
         "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts cycles when at least 3 micro-ops are =
executed from any thread on physical core.",
         "SampleAfterValue": "2000003",
         "Speculative": "1",
         "UMask": "0x2",
@@ -1970,6 +2072,7 @@
         "EventCode": "0xb1",
         "EventName": "UOPS_EXECUTED.CORE_CYCLES_GE_4",
         "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts cycles when at least 4 micro-ops are =
executed from any thread on physical core.",
         "SampleAfterValue": "2000003",
         "Speculative": "1",
         "UMask": "0x2",
@@ -1983,6 +2086,7 @@
         "EventCode": "0xb1",
         "EventName": "UOPS_EXECUTED.CYCLES_GE_1",
         "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Cycles where at least 1 uop was executed per=
-thread.",
         "SampleAfterValue": "2000003",
         "Speculative": "1",
         "UMask": "0x1",
@@ -1996,6 +2100,7 @@
         "EventCode": "0xb1",
         "EventName": "UOPS_EXECUTED.CYCLES_GE_2",
         "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Cycles where at least 2 uops were executed p=
er-thread.",
         "SampleAfterValue": "2000003",
         "Speculative": "1",
         "UMask": "0x1",
@@ -2009,6 +2114,7 @@
         "EventCode": "0xb1",
         "EventName": "UOPS_EXECUTED.CYCLES_GE_3",
         "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Cycles where at least 3 uops were executed p=
er-thread.",
         "SampleAfterValue": "2000003",
         "Speculative": "1",
         "UMask": "0x1",
@@ -2022,6 +2128,7 @@
         "EventCode": "0xb1",
         "EventName": "UOPS_EXECUTED.CYCLES_GE_4",
         "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Cycles where at least 4 uops were executed p=
er-thread.",
         "SampleAfterValue": "2000003",
         "Speculative": "1",
         "UMask": "0x1",
@@ -2036,6 +2143,7 @@
         "EventName": "UOPS_EXECUTED.STALLS",
         "Invert": "1",
         "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts cycles during which no uops were disp=
atched from the Reservation Station (RS) per thread.",
         "SampleAfterValue": "2000003",
         "Speculative": "1",
         "UMask": "0x1",
@@ -2046,6 +2154,7 @@
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
+        "Deprecated": "1",
         "EventCode": "0xb1",
         "EventName": "UOPS_EXECUTED.STALL_CYCLES",
         "Invert": "1",
@@ -2074,6 +2183,7 @@
         "EventCode": "0xb1",
         "EventName": "UOPS_EXECUTED.X87",
         "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts the number of x87 uops executed.",
         "SampleAfterValue": "2000003",
         "Speculative": "1",
         "UMask": "0x10",
@@ -2086,6 +2196,7 @@
         "EventCode": "0xae",
         "EventName": "UOPS_ISSUED.ANY",
         "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts the number of uops that the Resource =
Allocation Table (RAT) issues to the Reservation Station (RS).",
         "SampleAfterValue": "2000003",
         "Speculative": "1",
         "UMask": "0x1",
@@ -2099,6 +2210,7 @@
         "EventCode": "0xc2",
         "EventName": "UOPS_RETIRED.CYCLES",
         "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts cycles where at least one uop has ret=
ired.",
         "SampleAfterValue": "1000003",
         "UMask": "0x2",
         "Unit": "cpu_core"
@@ -2110,6 +2222,7 @@
         "EventCode": "0xc2",
         "EventName": "UOPS_RETIRED.HEAVY",
         "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts the number of retired micro-operation=
s (uops) except the last uop of each instruction. An instruction that is de=
coded into less than two uops does not contribute to the count.",
         "SampleAfterValue": "2000003",
         "UMask": "0x1",
         "Unit": "cpu_core"
@@ -2135,6 +2248,7 @@
         "EventCode": "0xc2",
         "EventName": "UOPS_RETIRED.SLOTS",
         "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts the retirement slots used each cycle.=
",
         "SampleAfterValue": "2000003",
         "UMask": "0x2",
         "Unit": "cpu_core"
@@ -2148,6 +2262,7 @@
         "EventName": "UOPS_RETIRED.STALLS",
         "Invert": "1",
         "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "This event counts cycles without actually re=
tired uops.",
         "SampleAfterValue": "1000003",
         "UMask": "0x2",
         "Unit": "cpu_core"
@@ -2157,6 +2272,7 @@
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
+        "Deprecated": "1",
         "EventCode": "0xc2",
         "EventName": "UOPS_RETIRED.STALL_CYCLES",
         "Invert": "1",
diff --git a/tools/perf/pmu-events/arch/x86/alderlake/uncore-other.json b/t=
ools/perf/pmu-events/arch/x86/alderlake/uncore-other.json
index b1ae349f5f21..8a31b0e0a1b7 100644
--- a/tools/perf/pmu-events/arch/x86/alderlake/uncore-other.json
+++ b/tools/perf/pmu-events/arch/x86/alderlake/uncore-other.json
@@ -1,13 +1,4 @@
 [
-    {
-        "BriefDescription": "This 48-bit fixed counter counts the UCLK cyc=
les",
-        "Counter": "Fixed",
-        "CounterType": "PGMABLE",
-        "EventCode": "0xff",
-        "EventName": "UNC_CLOCK.SOCKET",
-        "PerPkg": "1",
-        "Unit": "CLOCK"
-    },
     {
         "BriefDescription": "Counts the number of coherent and in-coherent=
 requests initiated by IA cores, processor graphic units, or LLC",
         "Counter": "0,1",
@@ -28,6 +19,15 @@
         "UMask": "0x01",
         "Unit": "ARB"
     },
+    {
+        "BriefDescription": "This 48-bit fixed counter counts the UCLK cyc=
les",
+        "Counter": "Fixed",
+        "CounterType": "FIXED",
+        "EventCode": "0xff",
+        "EventName": "UNC_CLOCK.SOCKET",
+        "PerPkg": "1",
+        "Unit": "CLOCK"
+    },
     {
         "BriefDescription": "Each cycle counts number of all outgoing vali=
d entries in ReqTrk. Such entry is defined as valid from its allocation in =
ReqTrk till deallocation. Accounts for Coherent and non-coherent traffic",
         "CounterType": "PGMABLE",
@@ -36,5 +36,52 @@
         "PerPkg": "1",
         "UMask": "0x01",
         "Unit": "ARB"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_ARB_DAT_REQUESTS.RD",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x81",
+        "EventName": "UNC_ARB_REQ_TRK_REQUEST.DRD",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "ARB"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_ARB_DAT_OCCUPANCY.ALL",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x85",
+        "EventName": "UNC_ARB_IFA_OCCUPANCY.ALL",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "ARB"
+    },
+    {
+        "BriefDescription": "Each cycle counts number of any coherent requ=
est at memory controller that were issued by any core",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x85",
+        "EventName": "UNC_ARB_DAT_OCCUPANCY.ALL",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "ARB"
+    },
+    {
+        "BriefDescription": "Number of coherent read requests sent to memo=
ry controller that were issued by any core",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x81",
+        "EventName": "UNC_ARB_DAT_REQUESTS.RD",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "ARB"
+    },
+    {
+        "BriefDescription": "Each cycle counts number of coherent reads pe=
nding on data return from memory controller that were issued by any core",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x85",
+        "EventName": "UNC_ARB_DAT_OCCUPANCY.RD",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "ARB"
     }
 ]
diff --git a/tools/perf/pmu-events/arch/x86/alderlake/virtual-memory.json b=
/tools/perf/pmu-events/arch/x86/alderlake/virtual-memory.json
index 12baf768ad8d..cda558a19e6f 100644
--- a/tools/perf/pmu-events/arch/x86/alderlake/virtual-memory.json
+++ b/tools/perf/pmu-events/arch/x86/alderlake/virtual-memory.json
@@ -6,6 +6,7 @@
         "EventCode": "0x08",
         "EventName": "DTLB_LOAD_MISSES.WALK_COMPLETED",
         "PEBScounters": "0,1,2,3,4,5",
+        "PublicDescription": "Counts the number of page walks completed du=
e to loads (including SW prefetches) whose address translations missed in a=
ll Translation Lookaside Buffer (TLB) levels and were mapped to any page si=
ze. Includes page walks that page fault.",
         "SampleAfterValue": "200003",
         "Speculative": "1",
         "UMask": "0xe",
@@ -18,6 +19,7 @@
         "EventCode": "0x49",
         "EventName": "DTLB_STORE_MISSES.WALK_COMPLETED",
         "PEBScounters": "0,1,2,3,4,5",
+        "PublicDescription": "Counts the number of page walks completed du=
e to stores whose address translations missed in all Translation Lookaside =
Buffer (TLB) levels and were mapped to any page size.  Includes page walks =
that page fault.",
         "SampleAfterValue": "2000003",
         "Speculative": "1",
         "UMask": "0xe",
@@ -54,6 +56,7 @@
         "EventCode": "0x85",
         "EventName": "ITLB_MISSES.WALK_COMPLETED",
         "PEBScounters": "0,1,2,3,4,5",
+        "PublicDescription": "Counts the number of page walks completed du=
e to instruction fetches whose address translations missed in all Translati=
on Lookaside Buffer (TLB) levels and were mapped to any page size.  Include=
s page walks that page fault.",
         "SampleAfterValue": "200003",
         "Speculative": "1",
         "UMask": "0xe",
@@ -78,6 +81,7 @@
         "EventCode": "0x12",
         "EventName": "DTLB_LOAD_MISSES.STLB_HIT",
         "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts loads that miss the DTLB (Data TLB) a=
nd hit the STLB (Second level TLB).",
         "SampleAfterValue": "100003",
         "Speculative": "1",
         "UMask": "0x20",
@@ -91,6 +95,7 @@
         "EventCode": "0x12",
         "EventName": "DTLB_LOAD_MISSES.WALK_ACTIVE",
         "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts cycles when at least one PMH (Page Mi=
ss Handler) is busy with a page walk for a demand load.",
         "SampleAfterValue": "100003",
         "Speculative": "1",
         "UMask": "0x10",
@@ -103,6 +108,7 @@
         "EventCode": "0x12",
         "EventName": "DTLB_LOAD_MISSES.WALK_COMPLETED",
         "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts completed page walks  (all page sizes=
) caused by demand data loads. This implies it missed in the DTLB and furth=
er levels of TLB. The page walk can end with or without a fault.",
         "SampleAfterValue": "100003",
         "Speculative": "1",
         "UMask": "0xe",
@@ -115,6 +121,7 @@
         "EventCode": "0x12",
         "EventName": "DTLB_LOAD_MISSES.WALK_COMPLETED_1G",
         "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts completed page walks  (1G sizes) caus=
ed by demand data loads. This implies address translations missed in the DT=
LB and further levels of TLB. The page walk can end with or without a fault=
.",
         "SampleAfterValue": "100003",
         "Speculative": "1",
         "UMask": "0x8",
@@ -127,6 +134,7 @@
         "EventCode": "0x12",
         "EventName": "DTLB_LOAD_MISSES.WALK_COMPLETED_2M_4M",
         "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts completed page walks  (2M/4M sizes) c=
aused by demand data loads. This implies address translations missed in the=
 DTLB and further levels of TLB. The page walk can end with or without a fa=
ult.",
         "SampleAfterValue": "100003",
         "Speculative": "1",
         "UMask": "0x4",
@@ -139,6 +147,7 @@
         "EventCode": "0x12",
         "EventName": "DTLB_LOAD_MISSES.WALK_COMPLETED_4K",
         "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts completed page walks  (4K sizes) caus=
ed by demand data loads. This implies address translations missed in the DT=
LB and further levels of TLB. The page walk can end with or without a fault=
.",
         "SampleAfterValue": "100003",
         "Speculative": "1",
         "UMask": "0x2",
@@ -151,6 +160,7 @@
         "EventCode": "0x12",
         "EventName": "DTLB_LOAD_MISSES.WALK_PENDING",
         "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts the number of page walks outstanding =
for a demand load in the PMH (Page Miss Handler) each cycle.",
         "SampleAfterValue": "100003",
         "Speculative": "1",
         "UMask": "0x10",
@@ -163,6 +173,7 @@
         "EventCode": "0x13",
         "EventName": "DTLB_STORE_MISSES.STLB_HIT",
         "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts stores that miss the DTLB (Data TLB) =
and hit the STLB (2nd Level TLB).",
         "SampleAfterValue": "100003",
         "Speculative": "1",
         "UMask": "0x20",
@@ -176,6 +187,7 @@
         "EventCode": "0x13",
         "EventName": "DTLB_STORE_MISSES.WALK_ACTIVE",
         "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts cycles when at least one PMH (Page Mi=
ss Handler) is busy with a page walk for a store.",
         "SampleAfterValue": "100003",
         "Speculative": "1",
         "UMask": "0x10",
@@ -188,6 +200,7 @@
         "EventCode": "0x13",
         "EventName": "DTLB_STORE_MISSES.WALK_COMPLETED",
         "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts completed page walks  (all page sizes=
) caused by demand data stores. This implies it missed in the DTLB and furt=
her levels of TLB. The page walk can end with or without a fault.",
         "SampleAfterValue": "100003",
         "Speculative": "1",
         "UMask": "0xe",
@@ -200,6 +213,7 @@
         "EventCode": "0x13",
         "EventName": "DTLB_STORE_MISSES.WALK_COMPLETED_1G",
         "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts completed page walks  (1G sizes) caus=
ed by demand data stores. This implies address translations missed in the D=
TLB and further levels of TLB. The page walk can end with or without a faul=
t.",
         "SampleAfterValue": "100003",
         "Speculative": "1",
         "UMask": "0x8",
@@ -212,6 +226,7 @@
         "EventCode": "0x13",
         "EventName": "DTLB_STORE_MISSES.WALK_COMPLETED_2M_4M",
         "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts completed page walks  (2M/4M sizes) c=
aused by demand data stores. This implies address translations missed in th=
e DTLB and further levels of TLB. The page walk can end with or without a f=
ault.",
         "SampleAfterValue": "100003",
         "Speculative": "1",
         "UMask": "0x4",
@@ -224,6 +239,7 @@
         "EventCode": "0x13",
         "EventName": "DTLB_STORE_MISSES.WALK_COMPLETED_4K",
         "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts completed page walks  (4K sizes) caus=
ed by demand data stores. This implies address translations missed in the D=
TLB and further levels of TLB. The page walk can end with or without a faul=
t.",
         "SampleAfterValue": "100003",
         "Speculative": "1",
         "UMask": "0x2",
@@ -236,6 +252,7 @@
         "EventCode": "0x13",
         "EventName": "DTLB_STORE_MISSES.WALK_PENDING",
         "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts the number of page walks outstanding =
for a store in the PMH (Page Miss Handler) each cycle.",
         "SampleAfterValue": "100003",
         "Speculative": "1",
         "UMask": "0x10",
@@ -248,6 +265,7 @@
         "EventCode": "0x11",
         "EventName": "ITLB_MISSES.STLB_HIT",
         "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts instruction fetch requests that miss =
the ITLB (Instruction TLB) and hit the STLB (Second-level TLB).",
         "SampleAfterValue": "100003",
         "Speculative": "1",
         "UMask": "0x20",
@@ -261,6 +279,7 @@
         "EventCode": "0x11",
         "EventName": "ITLB_MISSES.WALK_ACTIVE",
         "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts cycles when at least one PMH (Page Mi=
ss Handler) is busy with a page walk for a code (instruction fetch) request=
.",
         "SampleAfterValue": "100003",
         "Speculative": "1",
         "UMask": "0x10",
@@ -273,6 +292,7 @@
         "EventCode": "0x11",
         "EventName": "ITLB_MISSES.WALK_COMPLETED",
         "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts completed page walks (all page sizes)=
 caused by a code fetch. This implies it missed in the ITLB (Instruction TL=
B) and further levels of TLB. The page walk can end with or without a fault=
.",
         "SampleAfterValue": "100003",
         "Speculative": "1",
         "UMask": "0xe",
@@ -285,6 +305,7 @@
         "EventCode": "0x11",
         "EventName": "ITLB_MISSES.WALK_COMPLETED_2M_4M",
         "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts completed page walks (2M/4M page size=
s) caused by a code fetch. This implies it missed in the ITLB (Instruction =
TLB) and further levels of TLB. The page walk can end with or without a fau=
lt.",
         "SampleAfterValue": "100003",
         "Speculative": "1",
         "UMask": "0x4",
@@ -297,6 +318,7 @@
         "EventCode": "0x11",
         "EventName": "ITLB_MISSES.WALK_COMPLETED_4K",
         "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts completed page walks (4K page sizes) =
caused by a code fetch. This implies it missed in the ITLB (Instruction TLB=
) and further levels of TLB. The page walk can end with or without a fault.=
",
         "SampleAfterValue": "100003",
         "Speculative": "1",
         "UMask": "0x2",
@@ -309,6 +331,7 @@
         "EventCode": "0x11",
         "EventName": "ITLB_MISSES.WALK_PENDING",
         "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts the number of page walks outstanding =
for an outstanding code (instruction fetch) request in the PMH (Page Miss H=
andler) each cycle.",
         "SampleAfterValue": "100003",
         "Speculative": "1",
         "UMask": "0x10",
--=20
2.25.1

