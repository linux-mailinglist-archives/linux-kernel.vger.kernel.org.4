Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20FF05F3B4E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 04:19:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbiJDCTJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 22:19:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbiJDCR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 22:17:57 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD16C4057E
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 19:17:04 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-355bdeba45bso113296577b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Oct 2022 19:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date;
        bh=dLUz/Ts7Fk8657K2blvINPjVFBnsySekpY1d7WHVMRg=;
        b=OvdLg+T2PuvBTSaQ/NuiCQ1abwG25hRxyyb4EM8+pKRXS7amKr71lRAUkzXtkMX+sO
         CQnflsCkmX0JYiO88vrG6Uxt+NTJO5yxZttruULMzsd1X8YPv+xCGIfOLtzWdmBuPE9g
         DfX0j+zSvCGWLWCPkpo9hnwAuJDDMiUEhPmN7+YeA21dddobnEiOqWi0ZBPYSMsO1cfb
         OK4H8LC3990o5JcqOfT9h50Sav4Y+bLW97qzSJ2QT68lsv94ZmT4rVSUYSH0y5+5FtPF
         G62PS22+oNRm4RGGTX6NXbdhx/R6+73eU0kwvmqNoMD0k4wumiGjWmijYnZ5SaJ634xy
         Ditw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date;
        bh=dLUz/Ts7Fk8657K2blvINPjVFBnsySekpY1d7WHVMRg=;
        b=WudTpQojRJgpCv/WbUFPGe9um1Gw3hc0pxpNgRE/mrkyxTW06ZCVUkDq4CiEqQvZtx
         9GVC7ThmD2/9WB7rFy78qPTrqNKIDxcUU23V8DF/lJJGpgV7xhQs5gp69CEHsWKZINJf
         T8A1NsfT5LUO3jbseHsI3Og2qW8n2E6ugIbpNKnJ+QJKA9XhZOpHCYmPQoVDLL49WzNP
         CTbtJlgW0NaeEICztCfSeRBULNQIWWgjPTgb4lbSzY59uZUWIzuOXhE3NudseMfa5JeD
         K4e50NHh7eb9ipOnWWWG/istMhyDadAOgvOn8ybh4v/xyBvCzSAke+HZ18xYDM9DWnnM
         vzRQ==
X-Gm-Message-State: ACrzQf1FrG++YYx6NNzbFNetk4qOVOYcCsWEoTq/E9JPqkaI7P2G9sQg
        ceLXevwaZmn9oDT2XevBNErHkkK4Mj09
X-Google-Smtp-Source: AMsMyM6ydPfJFGhqdjQUy0iYp3BB3bjGkNBIvJWSERxSa/wm9hEDVw/oUsyxE8Y6G3rzEMaP4TkjELF8JsZQ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:a86d:8afd:70b1:9b0c])
 (user=irogers job=sendgmr) by 2002:a25:d0a:0:b0:6bc:f7a4:b982 with SMTP id
 10-20020a250d0a000000b006bcf7a4b982mr17194089ybn.77.1664849822607; Mon, 03
 Oct 2022 19:17:02 -0700 (PDT)
Date:   Mon,  3 Oct 2022 19:16:05 -0700
In-Reply-To: <20221004021612.325521-1-irogers@google.com>
Message-Id: <20221004021612.325521-17-irogers@google.com>
Mime-Version: 1.0
References: <20221004021612.325521-1-irogers@google.com>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Subject: [PATCH v3 16/23] perf vendor events: Update Intel ivytown
From:   Ian Rogers <irogers@google.com>
To:     Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, perry.taylor@intel.com,
        caleb.biggers@intel.com, kshipra.bopardikar@intel.com,
        samantha.alt@intel.com, ahmad.yasin@intel.com,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        James Clark <james.clark@arm.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Miaoqian Lin <linmq006@gmail.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Events are updated to v22 the core metrics are based on TMA 4.4 full.

Use script at:
https://github.com/intel/event-converter-for-linux-perf/blob/master/downloa=
d_and_gen.py
with updates at:
https://github.com/captain5050/event-converter-for-linux-perf

Updates include:
 - Rename of topdown TMA metrics from Frontend_Bound to tma_frontend_bound.
 - _SMT suffix metrics are dropped as the #SMT_On and #EBS_Mode are
   correctly expanded in the single main metric.
 - Addition of all 6 levels of TMA metrics. Child metrics are placed in
   a group named after their parent allowing children of a metric to
   be easily measured using the metric name with a _group suffix.
 - ## and ##? operators are correctly expanded.
 - The locate-with column is added to the long description describing
   a sampling event.
 - Metrics are written in terms of other metrics to reduce the
   expression size and increase readability.

Tested with 'perf test':
 10: PMU events                                                      :
 10.1: PMU event table sanity                                        : Ok
 10.2: PMU event map aliases                                         : Ok
 10.3: Parsing of PMU event table metrics                            : Ok
 10.4: Parsing of PMU event table metrics with fake PMUs             : Ok

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../pmu-events/arch/x86/ivytown/cache.json    |   4 +-
 .../arch/x86/ivytown/floating-point.json      |   2 +-
 .../pmu-events/arch/x86/ivytown/frontend.json |  18 +-
 .../arch/x86/ivytown/ivt-metrics.json         | 630 +++++++++++++++---
 .../arch/x86/ivytown/uncore-cache.json        |  58 +-
 .../arch/x86/ivytown/uncore-interconnect.json |  84 +--
 .../arch/x86/ivytown/uncore-memory.json       |   2 +-
 .../arch/x86/ivytown/uncore-other.json        |   6 +-
 .../arch/x86/ivytown/uncore-power.json        |   8 +-
 tools/perf/pmu-events/arch/x86/mapfile.csv    |   2 +-
 10 files changed, 625 insertions(+), 189 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/ivytown/cache.json b/tools/perf=
/pmu-events/arch/x86/ivytown/cache.json
index 27576d53b347..d95b98c83914 100644
--- a/tools/perf/pmu-events/arch/x86/ivytown/cache.json
+++ b/tools/perf/pmu-events/arch/x86/ivytown/cache.json
@@ -21,7 +21,7 @@
         "UMask": "0x2"
     },
     {
-        "BriefDescription": "L1D miss oustandings duration in cycles",
+        "BriefDescription": "L1D miss outstanding duration in cycles",
         "Counter": "2",
         "CounterHTOff": "2",
         "EventCode": "0x48",
@@ -658,7 +658,7 @@
         "UMask": "0x8"
     },
     {
-        "BriefDescription": "Cacheable and noncachaeble code read requests=
",
+        "BriefDescription": "Cacheable and noncacheable code read requests=
",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xB0",
diff --git a/tools/perf/pmu-events/arch/x86/ivytown/floating-point.json b/t=
ools/perf/pmu-events/arch/x86/ivytown/floating-point.json
index 4c2ac010cf55..88891cba54ec 100644
--- a/tools/perf/pmu-events/arch/x86/ivytown/floating-point.json
+++ b/tools/perf/pmu-events/arch/x86/ivytown/floating-point.json
@@ -91,7 +91,7 @@
         "UMask": "0x20"
     },
     {
-        "BriefDescription": "Number of FP Computational Uops Executed this=
 cycle. The number of FADD, FSUB, FCOM, FMULs, integer MULsand IMULs, FDIVs=
, FPREMs, FSQRTS, integer DIVs, and IDIVs. This event does not distinguish =
an FADD used in the middle of a transcendental flow from a s",
+        "BriefDescription": "Number of FP Computational Uops Executed this=
 cycle. The number of FADD, FSUB, FCOM, FMULs, integer MULs and IMULs, FDIV=
s, FPREMs, FSQRTS, integer DIVs, and IDIVs. This event does not distinguish=
 an FADD used in the middle of a transcendental flow from a s",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x10",
diff --git a/tools/perf/pmu-events/arch/x86/ivytown/frontend.json b/tools/p=
erf/pmu-events/arch/x86/ivytown/frontend.json
index 2b1a82dd86ab..0a295c4e093d 100644
--- a/tools/perf/pmu-events/arch/x86/ivytown/frontend.json
+++ b/tools/perf/pmu-events/arch/x86/ivytown/frontend.json
@@ -176,41 +176,41 @@
         "UMask": "0x4"
     },
     {
-        "BriefDescription": "Cycles when uops are being delivered to Instr=
uction Decode Queue (IDQ) while Microcode Sequenser (MS) is busy",
+        "BriefDescription": "Cycles when uops are being delivered to Instr=
uction Decode Queue (IDQ) while Microcode Sequencer (MS) is busy",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
         "EventCode": "0x79",
         "EventName": "IDQ.MS_CYCLES",
-        "PublicDescription": "Cycles when uops are being delivered to Inst=
ruction Decode Queue (IDQ) while Microcode Sequenser (MS) is busy.",
+        "PublicDescription": "Cycles when uops are being delivered to Inst=
ruction Decode Queue (IDQ) while Microcode Sequencer (MS) is busy.",
         "SampleAfterValue": "2000003",
         "UMask": "0x30"
     },
     {
-        "BriefDescription": "Cycles when uops initiated by Decode Stream B=
uffer (DSB) are being delivered to Instruction Decode Queue (IDQ) while Mic=
rocode Sequenser (MS) is busy",
+        "BriefDescription": "Cycles when uops initiated by Decode Stream B=
uffer (DSB) are being delivered to Instruction Decode Queue (IDQ) while Mic=
rocode Sequencer (MS) is busy",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
         "EventCode": "0x79",
         "EventName": "IDQ.MS_DSB_CYCLES",
-        "PublicDescription": "Cycles when uops initiated by Decode Stream =
Buffer (DSB) are being delivered to Instruction Decode Queue (IDQ) while Mi=
crocode Sequenser (MS) is busy.",
+        "PublicDescription": "Cycles when uops initiated by Decode Stream =
Buffer (DSB) are being delivered to Instruction Decode Queue (IDQ) while Mi=
crocode Sequencer (MS) is busy.",
         "SampleAfterValue": "2000003",
         "UMask": "0x10"
     },
     {
-        "BriefDescription": "Deliveries to Instruction Decode Queue (IDQ) =
initiated by Decode Stream Buffer (DSB) while Microcode Sequenser (MS) is b=
usy",
+        "BriefDescription": "Deliveries to Instruction Decode Queue (IDQ) =
initiated by Decode Stream Buffer (DSB) while Microcode Sequencer (MS) is b=
usy",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
         "EdgeDetect": "1",
         "EventCode": "0x79",
         "EventName": "IDQ.MS_DSB_OCCUR",
-        "PublicDescription": "Deliveries to Instruction Decode Queue (IDQ)=
 initiated by Decode Stream Buffer (DSB) while Microcode Sequenser (MS) is =
busy.",
+        "PublicDescription": "Deliveries to Instruction Decode Queue (IDQ)=
 initiated by Decode Stream Buffer (DSB) while Microcode Sequencer (MS) is =
busy.",
         "SampleAfterValue": "2000003",
         "UMask": "0x10"
     },
     {
-        "BriefDescription": "Uops initiated by Decode Stream Buffer (DSB) =
that are being delivered to Instruction Decode Queue (IDQ) while Microcode =
Sequenser (MS) is busy",
+        "BriefDescription": "Uops initiated by Decode Stream Buffer (DSB) =
that are being delivered to Instruction Decode Queue (IDQ) while Microcode =
Sequencer (MS) is busy",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x79",
@@ -220,7 +220,7 @@
         "UMask": "0x10"
     },
     {
-        "BriefDescription": "Uops initiated by MITE and delivered to Instr=
uction Decode Queue (IDQ) while Microcode Sequenser (MS) is busy",
+        "BriefDescription": "Uops initiated by MITE and delivered to Instr=
uction Decode Queue (IDQ) while Microcode Sequencer (MS) is busy",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x79",
@@ -242,7 +242,7 @@
         "UMask": "0x30"
     },
     {
-        "BriefDescription": "Uops delivered to Instruction Decode Queue (I=
DQ) while Microcode Sequenser (MS) is busy",
+        "BriefDescription": "Uops delivered to Instruction Decode Queue (I=
DQ) while Microcode Sequencer (MS) is busy",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x79",
diff --git a/tools/perf/pmu-events/arch/x86/ivytown/ivt-metrics.json b/tool=
s/perf/pmu-events/arch/x86/ivytown/ivt-metrics.json
index 19c7f3b41102..99a45c8d8cee 100644
--- a/tools/perf/pmu-events/arch/x86/ivytown/ivt-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/ivytown/ivt-metrics.json
@@ -1,64 +1,524 @@
 [
     {
         "BriefDescription": "This category represents fraction of slots wh=
ere the processor's Frontend undersupplies its Backend",
-        "MetricExpr": "IDQ_UOPS_NOT_DELIVERED.CORE / (4 * CPU_CLK_UNHALTED=
.THREAD)",
-        "MetricGroup": "TopdownL1",
-        "MetricName": "Frontend_Bound",
-        "PublicDescription": "This category represents fraction of slots w=
here the processor's Frontend undersupplies its Backend. Frontend denotes t=
he first part of the processor core responsible to fetch operations that ar=
e executed later on by the Backend part. Within the Frontend; a branch pred=
ictor predicts the next address to fetch; cache-lines are fetched from the =
memory subsystem; parsed into instructions; and lastly decoded into micro-o=
perations (uops). Ideally the Frontend can issue Machine_Width uops every c=
ycle to the Backend. Frontend Bound denotes unutilized issue-slots when the=
re is no Backend stall; i.e. bubbles where Frontend delivered no uops while=
 Backend could have accepted them. For example; stalls due to instruction-c=
ache misses would be categorized under Frontend Bound."
+        "MetricExpr": "IDQ_UOPS_NOT_DELIVERED.CORE / SLOTS",
+        "MetricGroup": "PGO;TopdownL1;tma_L1_group",
+        "MetricName": "tma_frontend_bound",
+        "PublicDescription": "This category represents fraction of slots w=
here the processor's Frontend undersupplies its Backend. Frontend denotes t=
he first part of the processor core responsible to fetch operations that ar=
e executed later on by the Backend part. Within the Frontend; a branch pred=
ictor predicts the next address to fetch; cache-lines are fetched from the =
memory subsystem; parsed into instructions; and lastly decoded into micro-o=
perations (uops). Ideally the Frontend can issue Machine_Width uops every c=
ycle to the Backend. Frontend Bound denotes unutilized issue-slots when the=
re is no Backend stall; i.e. bubbles where Frontend delivered no uops while=
 Backend could have accepted them. For example; stalls due to instruction-c=
ache misses would be categorized under Frontend Bound.",
+        "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "This category represents fraction of slots wh=
ere the processor's Frontend undersupplies its Backend. SMT version; use wh=
en SMT is enabled and measuring per logical CPU.",
-        "MetricExpr": "IDQ_UOPS_NOT_DELIVERED.CORE / (4 * ( ( CPU_CLK_UNHA=
LTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHA=
LTED.REF_XCLK ) ))",
-        "MetricGroup": "TopdownL1_SMT",
-        "MetricName": "Frontend_Bound_SMT",
-        "PublicDescription": "This category represents fraction of slots w=
here the processor's Frontend undersupplies its Backend. Frontend denotes t=
he first part of the processor core responsible to fetch operations that ar=
e executed later on by the Backend part. Within the Frontend; a branch pred=
ictor predicts the next address to fetch; cache-lines are fetched from the =
memory subsystem; parsed into instructions; and lastly decoded into micro-o=
perations (uops). Ideally the Frontend can issue Machine_Width uops every c=
ycle to the Backend. Frontend Bound denotes unutilized issue-slots when the=
re is no Backend stall; i.e. bubbles where Frontend delivered no uops while=
 Backend could have accepted them. For example; stalls due to instruction-c=
ache misses would be categorized under Frontend Bound. SMT version; use whe=
n SMT is enabled and measuring per logical CPU."
+        "BriefDescription": "This metric represents fraction of slots the =
CPU was stalled due to Frontend latency issues",
+        "MetricExpr": "4 * min(CPU_CLK_UNHALTED.THREAD, IDQ_UOPS_NOT_DELIV=
ERED.CYCLES_0_UOPS_DELIV.CORE) / SLOTS",
+        "MetricGroup": "Frontend;TopdownL2;tma_L2_group;tma_frontend_bound=
_group",
+        "MetricName": "tma_fetch_latency",
+        "PublicDescription": "This metric represents fraction of slots the=
 CPU was stalled due to Frontend latency issues.  For example; instruction-=
cache misses; iTLB misses or fetch stalls after a branch misprediction are =
categorized under Frontend Latency. In such cases; the Frontend eventually =
delivers no uops for some period. Sample with: RS_EVENTS.EMPTY_END",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to instruction cache misses.",
+        "MetricExpr": "ICACHE.IFETCH_STALL / CLKS - tma_itlb_misses",
+        "MetricGroup": "BigFoot;FetchLat;IcMiss;TopdownL3;tma_fetch_latenc=
y_group",
+        "MetricName": "tma_icache_misses",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to Instruction TLB (ITLB) misses",
+        "MetricExpr": "(12 * ITLB_MISSES.STLB_HIT + ITLB_MISSES.WALK_DURAT=
ION) / CLKS",
+        "MetricGroup": "BigFoot;FetchLat;MemoryTLB;TopdownL3;tma_fetch_lat=
ency_group",
+        "MetricName": "tma_itlb_misses",
+        "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to Instruction TLB (ITLB) misses. Sample with: ITLB_M=
ISSES.WALK_COMPLETED",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to Branch Resteers",
+        "MetricExpr": "12 * (BR_MISP_RETIRED.ALL_BRANCHES + MACHINE_CLEARS=
.COUNT + BACLEARS.ANY) / CLKS",
+        "MetricGroup": "FetchLat;TopdownL3;tma_fetch_latency_group",
+        "MetricName": "tma_branch_resteers",
+        "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to Branch Resteers. Branch Resteers estimates the Fro=
ntend delay in fetching operations from corrected path; following all sorts=
 of miss-predicted branches. For example; branchy code with lots of miss-pr=
edictions might get categorized under Branch Resteers. Note the value of th=
is node may overlap with its siblings. Sample with: BR_MISP_RETIRED.ALL_BRA=
NCHES",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to switches from DSB to MITE pipelines",
+        "MetricExpr": "DSB2MITE_SWITCHES.PENALTY_CYCLES / CLKS",
+        "MetricGroup": "DSBmiss;FetchLat;TopdownL3;tma_fetch_latency_group=
",
+        "MetricName": "tma_dsb_switches",
+        "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to switches from DSB to MITE pipelines. The DSB (deco=
ded i-cache) is a Uop Cache where the front-end directly delivers Uops (mic=
ro operations) avoiding heavy x86 decoding. The DSB pipeline has shorter la=
tency and delivered higher bandwidth than the MITE (legacy instruction deco=
de pipeline). Switching between the two pipelines can cause penalties hence=
 this metric measures the exposed penalty.",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of cycles CPU=
 was stalled due to Length Changing Prefixes (LCPs)",
+        "MetricExpr": "ILD_STALL.LCP / CLKS",
+        "MetricGroup": "FetchLat;TopdownL3;tma_fetch_latency_group",
+        "MetricName": "tma_lcp",
+        "PublicDescription": "This metric represents fraction of cycles CP=
U was stalled due to Length Changing Prefixes (LCPs). Using proper compiler=
 flags or Intel Compiler by default will certainly avoid this. #Link: Optim=
ization Guide about LCP BKMs.",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric estimates the fraction of cycles =
when the CPU was stalled due to switches of uop delivery to the Microcode S=
equencer (MS)",
+        "MetricExpr": "3 * IDQ.MS_SWITCHES / CLKS",
+        "MetricGroup": "FetchLat;MicroSeq;TopdownL3;tma_fetch_latency_grou=
p",
+        "MetricName": "tma_ms_switches",
+        "PublicDescription": "This metric estimates the fraction of cycles=
 when the CPU was stalled due to switches of uop delivery to the Microcode =
Sequencer (MS). Commonly used instructions are optimized for delivery by th=
e DSB (decoded i-cache) or MITE (legacy instruction decode) pipelines. Cert=
ain operations cannot be handled natively by the execution pipeline; and mu=
st be performed by microcode (small programs injected into the execution st=
ream). Switching to the MS too often can negatively impact performance. The=
 MS is designated to deliver long uop flows required by CISC instructions l=
ike CPUID; or uncommon conditions like Floating Point Assists when dealing =
with Denormals. Sample with: IDQ.MS_SWITCHES",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of slots the =
CPU was stalled due to Frontend bandwidth issues",
+        "MetricExpr": "tma_frontend_bound - tma_fetch_latency",
+        "MetricGroup": "FetchBW;Frontend;TopdownL2;tma_L2_group;tma_fronte=
nd_bound_group",
+        "MetricName": "tma_fetch_bandwidth",
+        "PublicDescription": "This metric represents fraction of slots the=
 CPU was stalled due to Frontend bandwidth issues.  For example; inefficien=
cies at the instruction decoders; or restrictions for caching in the DSB (d=
ecoded uops cache) are categorized under Fetch Bandwidth. In such cases; th=
e Frontend typically delivers suboptimal amount of uops to the Backend.",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric represents Core fraction of cycle=
s in which CPU was likely limited due to the MITE pipeline (the legacy deco=
de pipeline)",
+        "MetricExpr": "(IDQ.ALL_MITE_CYCLES_ANY_UOPS - IDQ.ALL_MITE_CYCLES=
_4_UOPS) / CORE_CLKS / 2",
+        "MetricGroup": "DSBmiss;FetchBW;TopdownL3;tma_fetch_bandwidth_grou=
p",
+        "MetricName": "tma_mite",
+        "PublicDescription": "This metric represents Core fraction of cycl=
es in which CPU was likely limited due to the MITE pipeline (the legacy dec=
ode pipeline). This pipeline is used for code that was not pre-cached in th=
e DSB or LSD. For example; inefficiencies due to asymmetric decoders; use o=
f long immediate or LCP can manifest as MITE fetch bandwidth bottleneck.",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric represents Core fraction of cycle=
s in which CPU was likely limited due to DSB (decoded uop cache) fetch pipe=
line",
+        "MetricExpr": "(IDQ.ALL_DSB_CYCLES_ANY_UOPS - IDQ.ALL_DSB_CYCLES_4=
_UOPS) / CORE_CLKS / 2",
+        "MetricGroup": "DSB;FetchBW;TopdownL3;tma_fetch_bandwidth_group",
+        "MetricName": "tma_dsb",
+        "PublicDescription": "This metric represents Core fraction of cycl=
es in which CPU was likely limited due to DSB (decoded uop cache) fetch pip=
eline.  For example; inefficient utilization of the DSB cache structure or =
bank conflict when reading from it; are categorized here.",
+        "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "This category represents fraction of slots wa=
sted due to incorrect speculations",
-        "MetricExpr": "( UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 *=
 INT_MISC.RECOVERY_CYCLES ) / (4 * CPU_CLK_UNHALTED.THREAD)",
-        "MetricGroup": "TopdownL1",
-        "MetricName": "Bad_Speculation",
-        "PublicDescription": "This category represents fraction of slots w=
asted due to incorrect speculations. This include slots used to issue uops =
that do not eventually get retired and slots for which the issue-pipeline w=
as blocked due to recovery from earlier incorrect speculation. For example;=
 wasted work due to miss-predicted branches are categorized under Bad Specu=
lation category. Incorrect data speculation followed by Memory Ordering Nuk=
es is another example."
+        "MetricExpr": "(UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * =
((INT_MISC.RECOVERY_CYCLES_ANY / 2) if #SMT_on else INT_MISC.RECOVERY_CYCLE=
S)) / SLOTS",
+        "MetricGroup": "TopdownL1;tma_L1_group",
+        "MetricName": "tma_bad_speculation",
+        "PublicDescription": "This category represents fraction of slots w=
asted due to incorrect speculations. This include slots used to issue uops =
that do not eventually get retired and slots for which the issue-pipeline w=
as blocked due to recovery from earlier incorrect speculation. For example;=
 wasted work due to miss-predicted branches are categorized under Bad Specu=
lation category. Incorrect data speculation followed by Memory Ordering Nuk=
es is another example.",
+        "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "This category represents fraction of slots wa=
sted due to incorrect speculations. SMT version; use when SMT is enabled an=
d measuring per logical CPU.",
-        "MetricExpr": "( UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 *=
 ( INT_MISC.RECOVERY_CYCLES_ANY / 2 ) ) / (4 * ( ( CPU_CLK_UNHALTED.THREAD =
/ 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCL=
K ) ))",
-        "MetricGroup": "TopdownL1_SMT",
-        "MetricName": "Bad_Speculation_SMT",
-        "PublicDescription": "This category represents fraction of slots w=
asted due to incorrect speculations. This include slots used to issue uops =
that do not eventually get retired and slots for which the issue-pipeline w=
as blocked due to recovery from earlier incorrect speculation. For example;=
 wasted work due to miss-predicted branches are categorized under Bad Specu=
lation category. Incorrect data speculation followed by Memory Ordering Nuk=
es is another example. SMT version; use when SMT is enabled and measuring p=
er logical CPU."
+        "BriefDescription": "This metric represents fraction of slots the =
CPU has wasted due to Branch Misprediction",
+        "MetricExpr": "(BR_MISP_RETIRED.ALL_BRANCHES / (BR_MISP_RETIRED.AL=
L_BRANCHES + MACHINE_CLEARS.COUNT)) * tma_bad_speculation",
+        "MetricGroup": "BadSpec;BrMispredicts;TopdownL2;tma_L2_group;tma_b=
ad_speculation_group",
+        "MetricName": "tma_branch_mispredicts",
+        "PublicDescription": "This metric represents fraction of slots the=
 CPU has wasted due to Branch Misprediction.  These slots are either wasted=
 by uops fetched from an incorrectly speculated program path; or stalls whe=
n the out-of-order part of the machine needs to recover its state from a sp=
eculative path. Sample with: BR_MISP_RETIRED.ALL_BRANCHES",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of slots the =
CPU has wasted due to Machine Clears",
+        "MetricExpr": "tma_bad_speculation - tma_branch_mispredicts",
+        "MetricGroup": "BadSpec;MachineClears;TopdownL2;tma_L2_group;tma_b=
ad_speculation_group",
+        "MetricName": "tma_machine_clears",
+        "PublicDescription": "This metric represents fraction of slots the=
 CPU has wasted due to Machine Clears.  These slots are either wasted by uo=
ps fetched prior to the clear; or stalls the out-of-order portion of the ma=
chine needs to recover its state after the clear. For example; this can hap=
pen due to memory ordering Nukes (e.g. Memory Disambiguation) or Self-Modif=
ying-Code (SMC) nukes. Sample with: MACHINE_CLEARS.COUNT",
+        "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "This category represents fraction of slots wh=
ere no uops are being delivered due to a lack of required resources for acc=
epting new uops in the Backend",
-        "MetricConstraint": "NO_NMI_WATCHDOG",
-        "MetricExpr": "1 - ( (IDQ_UOPS_NOT_DELIVERED.CORE / (4 * CPU_CLK_U=
NHALTED.THREAD)) + (( UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * INT=
_MISC.RECOVERY_CYCLES ) / (4 * CPU_CLK_UNHALTED.THREAD)) + (UOPS_RETIRED.RE=
TIRE_SLOTS / (4 * CPU_CLK_UNHALTED.THREAD)) )",
-        "MetricGroup": "TopdownL1",
-        "MetricName": "Backend_Bound",
-        "PublicDescription": "This category represents fraction of slots w=
here no uops are being delivered due to a lack of required resources for ac=
cepting new uops in the Backend. Backend is the portion of the processor co=
re where the out-of-order scheduler dispatches ready uops into their respec=
tive execution units; and once completed these uops get retired according t=
o program order. For example; stalls due to data-cache misses or stalls due=
 to the divider unit being overloaded are both categorized under Backend Bo=
und. Backend Bound is further divided into two main categories: Memory Boun=
d and Core Bound."
+        "MetricExpr": "1 - (tma_frontend_bound + tma_bad_speculation + tma=
_retiring)",
+        "MetricGroup": "TopdownL1;tma_L1_group",
+        "MetricName": "tma_backend_bound",
+        "PublicDescription": "This category represents fraction of slots w=
here no uops are being delivered due to a lack of required resources for ac=
cepting new uops in the Backend. Backend is the portion of the processor co=
re where the out-of-order scheduler dispatches ready uops into their respec=
tive execution units; and once completed these uops get retired according t=
o program order. For example; stalls due to data-cache misses or stalls due=
 to the divider unit being overloaded are both categorized under Backend Bo=
und. Backend Bound is further divided into two main categories: Memory Boun=
d and Core Bound.",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of slots the =
Memory subsystem within the Backend was a bottleneck",
+        "MetricExpr": "((min(CPU_CLK_UNHALTED.THREAD, CYCLE_ACTIVITY.STALL=
S_LDM_PENDING) + RESOURCE_STALLS.SB) / (min(CPU_CLK_UNHALTED.THREAD, CYCLE_=
ACTIVITY.CYCLES_NO_EXECUTE) + UOPS_EXECUTED.CYCLES_GE_1_UOP_EXEC - UOPS_EXE=
CUTED.CYCLES_GE_3_UOPS_EXEC if (IPC > 1.8) else UOPS_EXECUTED.CYCLES_GE_2_U=
OPS_EXEC - RS_EVENTS.EMPTY_CYCLES if (tma_fetch_latency > 0.1) else RESOURC=
E_STALLS.SB)) * tma_backend_bound",
+        "MetricGroup": "Backend;TopdownL2;tma_L2_group;tma_backend_bound_g=
roup",
+        "MetricName": "tma_memory_bound",
+        "PublicDescription": "This metric represents fraction of slots the=
 Memory subsystem within the Backend was a bottleneck.  Memory Bound estima=
tes fraction of slots where pipeline is likely stalled due to demand load o=
r store instructions. This accounts mainly for (1) non-completed in-flight =
memory demand loads which coincides with execution units starvation; in add=
ition to (2) cases where stores could impose backpressure on the pipeline w=
hen many of them get buffered at the same time (less common out of the two)=
.",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric estimates how often the CPU was s=
talled without loads missing the L1 data cache",
+        "MetricExpr": "max((min(CPU_CLK_UNHALTED.THREAD, CYCLE_ACTIVITY.ST=
ALLS_LDM_PENDING) - CYCLE_ACTIVITY.STALLS_L1D_PENDING) / CLKS, 0)",
+        "MetricGroup": "CacheMisses;MemoryBound;TmaL3mem;TopdownL3;tma_mem=
ory_bound_group",
+        "MetricName": "tma_l1_bound",
+        "PublicDescription": "This metric estimates how often the CPU was =
stalled without loads missing the L1 data cache.  The L1 data cache typical=
ly has the shortest latency.  However; in certain cases like loads blocked =
on older stores; a load might suffer due to high latency even though it is =
being satisfied by the L1. Another example is loads who miss in the TLB. Th=
ese cases are characterized by execution unit stalls; while some non-comple=
ted demand load lives in the machine without having that demand load missin=
g the L1 cache. Sample with: MEM_LOAD_UOPS_RETIRED.L1_HIT_PS;MEM_LOAD_UOPS_=
RETIRED.HIT_LFB_PS",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric roughly estimates the fraction of=
 cycles where the Data TLB (DTLB) was missed by load accesses",
+        "MetricExpr": "(7 * DTLB_LOAD_MISSES.STLB_HIT + DTLB_LOAD_MISSES.W=
ALK_DURATION) / CLKS",
+        "MetricGroup": "MemoryTLB;TopdownL4;tma_l1_bound_group",
+        "MetricName": "tma_dtlb_load",
+        "PublicDescription": "This metric roughly estimates the fraction o=
f cycles where the Data TLB (DTLB) was missed by load accesses. TLBs (Trans=
lation Look-aside Buffers) are processor caches for recently used entries o=
ut of the Page Tables that are used to map virtual- to physical-addresses b=
y the operating system. This metric approximates the potential delay of dem=
and loads missing the first-level data TLB (assuming worst case scenario wi=
th back to back misses to different pages). This includes hitting in the se=
cond-level TLB (STLB) as well as performing a hardware page walk on an STLB=
 miss. Sample with: MEM_UOPS_RETIRED.STLB_MISS_LOADS_PS",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric roughly estimates fraction of cyc=
les when the memory subsystem had loads blocked since they could not forwar=
d data from earlier (in program order) overlapping stores",
+        "MetricExpr": "13 * LD_BLOCKS.STORE_FORWARD / CLKS",
+        "MetricGroup": "TopdownL4;tma_l1_bound_group",
+        "MetricName": "tma_store_fwd_blk",
+        "PublicDescription": "This metric roughly estimates fraction of cy=
cles when the memory subsystem had loads blocked since they could not forwa=
rd data from earlier (in program order) overlapping stores. To streamline m=
emory operations in the pipeline; a load can avoid waiting for memory if a =
prior in-flight store is writing the data that the load wants to read (stor=
e forwarding process). However; in some cases the load may be blocked for a=
 significant time pending the store forward. For example; when the prior st=
ore is writing a smaller region than the load is reading.",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of cycles the=
 CPU spent handling cache misses due to lock operations",
+        "MetricExpr": "(MEM_UOPS_RETIRED.LOCK_LOADS / MEM_UOPS_RETIRED.ALL=
_STORES) * min(CPU_CLK_UNHALTED.THREAD, OFFCORE_REQUESTS_OUTSTANDING.CYCLES=
_WITH_DEMAND_RFO) / CLKS",
+        "MetricGroup": "Offcore;TopdownL4;tma_l1_bound_group",
+        "MetricName": "tma_lock_latency",
+        "PublicDescription": "This metric represents fraction of cycles th=
e CPU spent handling cache misses due to lock operations. Due to the microa=
rchitecture handling of locks; they are classified as L1_Bound regardless o=
f what memory source satisfied them. Sample with: MEM_UOPS_RETIRED.LOCK_LOA=
DS_PS",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric estimates fraction of cycles hand=
ling memory load split accesses - load that cross 64-byte cache line bounda=
ry",
+        "MetricExpr": "13 * LD_BLOCKS.NO_SR / CLKS",
+        "MetricGroup": "TopdownL4;tma_l1_bound_group",
+        "MetricName": "tma_split_loads",
+        "PublicDescription": "This metric estimates fraction of cycles han=
dling memory load split accesses - load that cross 64-byte cache line bound=
ary.  Sample with: MEM_UOPS_RETIRED.SPLIT_LOADS_PS",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric estimates how often memory load a=
ccesses were aliased by preceding stores (in program order) with a 4K addre=
ss offset",
+        "MetricExpr": "LD_BLOCKS_PARTIAL.ADDRESS_ALIAS / CLKS",
+        "MetricGroup": "TopdownL4;tma_l1_bound_group",
+        "MetricName": "tma_4k_aliasing",
+        "PublicDescription": "This metric estimates how often memory load =
accesses were aliased by preceding stores (in program order) with a 4K addr=
ess offset. False match is possible; which incur a few cycles load re-issue=
. However; the short re-issue duration is often hidden by the out-of-order =
core and HW optimizations; hence a user may safely ignore a high value of t=
his metric unless it manages to propagate up into parent nodes of the hiera=
rchy (e.g. to L1_Bound).",
+        "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "This category represents fraction of slots wh=
ere no uops are being delivered due to a lack of required resources for acc=
epting new uops in the Backend. SMT version; use when SMT is enabled and me=
asuring per logical CPU.",
-        "MetricExpr": "1 - ( (IDQ_UOPS_NOT_DELIVERED.CORE / (4 * ( ( CPU_C=
LK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_C=
LK_UNHALTED.REF_XCLK ) ))) + (( UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS=
 + 4 * ( INT_MISC.RECOVERY_CYCLES_ANY / 2 ) ) / (4 * ( ( CPU_CLK_UNHALTED.T=
HREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.R=
EF_XCLK ) ))) + (UOPS_RETIRED.RETIRE_SLOTS / (4 * ( ( CPU_CLK_UNHALTED.THRE=
AD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_=
XCLK ) ))) )",
-        "MetricGroup": "TopdownL1_SMT",
-        "MetricName": "Backend_Bound_SMT",
-        "PublicDescription": "This category represents fraction of slots w=
here no uops are being delivered due to a lack of required resources for ac=
cepting new uops in the Backend. Backend is the portion of the processor co=
re where the out-of-order scheduler dispatches ready uops into their respec=
tive execution units; and once completed these uops get retired according t=
o program order. For example; stalls due to data-cache misses or stalls due=
 to the divider unit being overloaded are both categorized under Backend Bo=
und. Backend Bound is further divided into two main categories: Memory Boun=
d and Core Bound. SMT version; use when SMT is enabled and measuring per lo=
gical CPU."
+        "BriefDescription": "This metric does a *rough estimation* of how =
often L1D Fill Buffer unavailability limited additional L1D miss memory acc=
ess requests to proceed",
+        "MetricExpr": "Load_Miss_Real_Latency * cpu@L1D_PEND_MISS.FB_FULL\=
\,cmask\\=3D1@ / CLKS",
+        "MetricGroup": "MemoryBW;TopdownL4;tma_l1_bound_group",
+        "MetricName": "tma_fb_full",
+        "PublicDescription": "This metric does a *rough estimation* of how=
 often L1D Fill Buffer unavailability limited additional L1D miss memory ac=
cess requests to proceed. The higher the metric value; the deeper the memor=
y hierarchy level the misses are satisfied from (metric values >1 are valid=
). Often it hints on approaching bandwidth limits (to L2 cache; L3 cache or=
 external memory).",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric estimates how often the CPU was s=
talled due to L2 cache accesses by loads",
+        "MetricExpr": "(CYCLE_ACTIVITY.STALLS_L1D_PENDING - CYCLE_ACTIVITY=
.STALLS_L2_PENDING) / CLKS",
+        "MetricGroup": "CacheMisses;MemoryBound;TmaL3mem;TopdownL3;tma_mem=
ory_bound_group",
+        "MetricName": "tma_l2_bound",
+        "PublicDescription": "This metric estimates how often the CPU was =
stalled due to L2 cache accesses by loads.  Avoiding cache misses (i.e. L1 =
misses/L2 hits) can improve the latency and increase performance. Sample wi=
th: MEM_LOAD_UOPS_RETIRED.L2_HIT_PS",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric estimates how often the CPU was s=
talled due to loads accesses to L3 cache or contended with a sibling Core",
+        "MetricExpr": "(MEM_LOAD_UOPS_RETIRED.LLC_HIT / (MEM_LOAD_UOPS_RET=
IRED.LLC_HIT + 7 * MEM_LOAD_UOPS_RETIRED.LLC_MISS)) * CYCLE_ACTIVITY.STALLS=
_L2_PENDING / CLKS",
+        "MetricGroup": "CacheMisses;MemoryBound;TmaL3mem;TopdownL3;tma_mem=
ory_bound_group",
+        "MetricName": "tma_l3_bound",
+        "PublicDescription": "This metric estimates how often the CPU was =
stalled due to loads accesses to L3 cache or contended with a sibling Core.=
  Avoiding cache misses (i.e. L2 misses/L3 hits) can improve the latency an=
d increase performance. Sample with: MEM_LOAD_UOPS_RETIRED.L3_HIT_PS",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric estimates fraction of cycles whil=
e the memory subsystem was handling synchronizations due to contested acces=
ses",
+        "MetricExpr": "(60 * (MEM_LOAD_UOPS_LLC_HIT_RETIRED.XSNP_HITM * (1=
 + mem_load_uops_retired.hit_lfb / ((MEM_LOAD_UOPS_RETIRED.L2_HIT + MEM_LOA=
D_UOPS_RETIRED.LLC_HIT + MEM_LOAD_UOPS_LLC_HIT_RETIRED.XSNP_HIT + MEM_LOAD_=
UOPS_LLC_HIT_RETIRED.XSNP_HITM + MEM_LOAD_UOPS_LLC_HIT_RETIRED.XSNP_MISS) +=
 MEM_LOAD_UOPS_LLC_MISS_RETIRED.LOCAL_DRAM + MEM_LOAD_UOPS_LLC_MISS_RETIRED=
.REMOTE_DRAM + MEM_LOAD_UOPS_LLC_MISS_RETIRED.REMOTE_HITM + MEM_LOAD_UOPS_L=
LC_MISS_RETIRED.REMOTE_FWD))) + 43 * (MEM_LOAD_UOPS_LLC_HIT_RETIRED.XSNP_MI=
SS * (1 + mem_load_uops_retired.hit_lfb / ((MEM_LOAD_UOPS_RETIRED.L2_HIT + =
MEM_LOAD_UOPS_RETIRED.LLC_HIT + MEM_LOAD_UOPS_LLC_HIT_RETIRED.XSNP_HIT + ME=
M_LOAD_UOPS_LLC_HIT_RETIRED.XSNP_HITM + MEM_LOAD_UOPS_LLC_HIT_RETIRED.XSNP_=
MISS) + MEM_LOAD_UOPS_LLC_MISS_RETIRED.LOCAL_DRAM + MEM_LOAD_UOPS_LLC_MISS_=
RETIRED.REMOTE_DRAM + MEM_LOAD_UOPS_LLC_MISS_RETIRED.REMOTE_HITM + MEM_LOAD=
_UOPS_LLC_MISS_RETIRED.REMOTE_FWD)))) / CLKS",
+        "MetricGroup": "DataSharing;Offcore;Snoop;TopdownL4;tma_l3_bound_g=
roup",
+        "MetricName": "tma_contested_accesses",
+        "PublicDescription": "This metric estimates fraction of cycles whi=
le the memory subsystem was handling synchronizations due to contested acce=
sses. Contested accesses occur when data written by one Logical Processor a=
re read by another Logical Processor on a different Physical Core. Examples=
 of contested accesses include synchronizations such as locks; true data sh=
aring such as modified locked variables; and false sharing. Sample with: ME=
M_LOAD_L3_HIT_RETIRED.XSNP_HITM_PS;MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS_PS",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric estimates fraction of cycles whil=
e the memory subsystem was handling synchronizations due to data-sharing ac=
cesses",
+        "MetricExpr": "43 * (MEM_LOAD_UOPS_LLC_HIT_RETIRED.XSNP_HIT * (1 +=
 mem_load_uops_retired.hit_lfb / ((MEM_LOAD_UOPS_RETIRED.L2_HIT + MEM_LOAD_=
UOPS_RETIRED.LLC_HIT + MEM_LOAD_UOPS_LLC_HIT_RETIRED.XSNP_HIT + MEM_LOAD_UO=
PS_LLC_HIT_RETIRED.XSNP_HITM + MEM_LOAD_UOPS_LLC_HIT_RETIRED.XSNP_MISS) + M=
EM_LOAD_UOPS_LLC_MISS_RETIRED.LOCAL_DRAM + MEM_LOAD_UOPS_LLC_MISS_RETIRED.R=
EMOTE_DRAM + MEM_LOAD_UOPS_LLC_MISS_RETIRED.REMOTE_HITM + MEM_LOAD_UOPS_LLC=
_MISS_RETIRED.REMOTE_FWD))) / CLKS",
+        "MetricGroup": "Offcore;Snoop;TopdownL4;tma_l3_bound_group",
+        "MetricName": "tma_data_sharing",
+        "PublicDescription": "This metric estimates fraction of cycles whi=
le the memory subsystem was handling synchronizations due to data-sharing a=
ccesses. Data shared by multiple Logical Processors (even just read shared)=
 may cause increased access latency due to cache coherency. Excessive data =
sharing can drastically harm multithreaded performance. Sample with: MEM_LO=
AD_L3_HIT_RETIRED.XSNP_HIT_PS",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of cycles wit=
h demand load accesses that hit the L3 cache under unloaded scenarios (poss=
ibly L3 latency limited)",
+        "MetricExpr": "41 * (MEM_LOAD_UOPS_RETIRED.LLC_HIT * (1 + mem_load=
_uops_retired.hit_lfb / ((MEM_LOAD_UOPS_RETIRED.L2_HIT + MEM_LOAD_UOPS_RETI=
RED.LLC_HIT + MEM_LOAD_UOPS_LLC_HIT_RETIRED.XSNP_HIT + MEM_LOAD_UOPS_LLC_HI=
T_RETIRED.XSNP_HITM + MEM_LOAD_UOPS_LLC_HIT_RETIRED.XSNP_MISS) + MEM_LOAD_U=
OPS_LLC_MISS_RETIRED.LOCAL_DRAM + MEM_LOAD_UOPS_LLC_MISS_RETIRED.REMOTE_DRA=
M + MEM_LOAD_UOPS_LLC_MISS_RETIRED.REMOTE_HITM + MEM_LOAD_UOPS_LLC_MISS_RET=
IRED.REMOTE_FWD))) / CLKS",
+        "MetricGroup": "MemoryLat;TopdownL4;tma_l3_bound_group",
+        "MetricName": "tma_l3_hit_latency",
+        "PublicDescription": "This metric represents fraction of cycles wi=
th demand load accesses that hit the L3 cache under unloaded scenarios (pos=
sibly L3 latency limited).  Avoiding private cache misses (i.e. L2 misses/L=
3 hits) will improve the latency; reduce contention with sibling physical c=
ores and increase performance.  Note the value of this node may overlap wit=
h its siblings. Sample with: MEM_LOAD_UOPS_RETIRED.L3_HIT_PS",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric measures fraction of cycles where=
 the Super Queue (SQ) was full taking into account all request-types and bo=
th hardware SMT threads (Logical Processors)",
+        "MetricExpr": "((OFFCORE_REQUESTS_BUFFER.SQ_FULL / 2) if #SMT_on e=
lse OFFCORE_REQUESTS_BUFFER.SQ_FULL) / CORE_CLKS",
+        "MetricGroup": "MemoryBW;Offcore;TopdownL4;tma_l3_bound_group",
+        "MetricName": "tma_sq_full",
+        "PublicDescription": "This metric measures fraction of cycles wher=
e the Super Queue (SQ) was full taking into account all request-types and b=
oth hardware SMT threads (Logical Processors). The Super Queue is used for =
requests to access the L2 cache or to go out to the Uncore.",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric estimates how often the CPU was s=
talled on accesses to external memory (DRAM) by loads",
+        "MetricExpr": "(1 - (MEM_LOAD_UOPS_RETIRED.LLC_HIT / (MEM_LOAD_UOP=
S_RETIRED.LLC_HIT + 7 * MEM_LOAD_UOPS_RETIRED.LLC_MISS))) * CYCLE_ACTIVITY.=
STALLS_L2_PENDING / CLKS",
+        "MetricGroup": "MemoryBound;TmaL3mem;TopdownL3;tma_memory_bound_gr=
oup",
+        "MetricName": "tma_dram_bound",
+        "PublicDescription": "This metric estimates how often the CPU was =
stalled on accesses to external memory (DRAM) by loads. Better caching can =
improve the latency and increase performance. Sample with: MEM_LOAD_UOPS_RE=
TIRED.L3_MISS_PS",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric estimates fraction of cycles wher=
e the core's performance was likely hurt due to approaching bandwidth limit=
s of external memory (DRAM)",
+        "MetricExpr": "min(CPU_CLK_UNHALTED.THREAD, cpu@OFFCORE_REQUESTS_O=
UTSTANDING.ALL_DATA_RD\\,cmask\\=3D6@) / CLKS",
+        "MetricGroup": "MemoryBW;Offcore;TopdownL4;tma_dram_bound_group",
+        "MetricName": "tma_mem_bandwidth",
+        "PublicDescription": "This metric estimates fraction of cycles whe=
re the core's performance was likely hurt due to approaching bandwidth limi=
ts of external memory (DRAM).  The underlying heuristic assumes that a simi=
lar off-core traffic is generated by all IA cores. This metric does not agg=
regate non-data-read requests by this logical processor; requests from othe=
r IA Logical Processors/Physical Cores/sockets; or other non-IA devices lik=
e GPU; hence the maximum external memory bandwidth limits may or may not be=
 approached when this metric is flagged (see Uncore counters for that).",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric estimates fraction of cycles wher=
e the performance was likely hurt due to latency from external memory (DRAM=
)",
+        "MetricExpr": "min(CPU_CLK_UNHALTED.THREAD, OFFCORE_REQUESTS_OUTST=
ANDING.CYCLES_WITH_DATA_RD) / CLKS - tma_mem_bandwidth",
+        "MetricGroup": "MemoryLat;Offcore;TopdownL4;tma_dram_bound_group",
+        "MetricName": "tma_mem_latency",
+        "PublicDescription": "This metric estimates fraction of cycles whe=
re the performance was likely hurt due to latency from external memory (DRA=
M).  This metric does not aggregate requests from other Logical Processors/=
Physical Cores/sockets (see Uncore counters for that).",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric estimates fraction of cycles whil=
e the memory subsystem was handling loads from local memory",
+        "MetricExpr": "200 * (MEM_LOAD_UOPS_LLC_MISS_RETIRED.LOCAL_DRAM * =
(1 + mem_load_uops_retired.hit_lfb / ((MEM_LOAD_UOPS_RETIRED.L2_HIT + MEM_L=
OAD_UOPS_RETIRED.LLC_HIT + MEM_LOAD_UOPS_LLC_HIT_RETIRED.XSNP_HIT + MEM_LOA=
D_UOPS_LLC_HIT_RETIRED.XSNP_HITM + MEM_LOAD_UOPS_LLC_HIT_RETIRED.XSNP_MISS)=
 + MEM_LOAD_UOPS_LLC_MISS_RETIRED.LOCAL_DRAM + MEM_LOAD_UOPS_LLC_MISS_RETIR=
ED.REMOTE_DRAM + MEM_LOAD_UOPS_LLC_MISS_RETIRED.REMOTE_HITM + MEM_LOAD_UOPS=
_LLC_MISS_RETIRED.REMOTE_FWD))) / CLKS",
+        "MetricGroup": "Server;TopdownL5;tma_mem_latency_group",
+        "MetricName": "tma_local_dram",
+        "PublicDescription": "This metric estimates fraction of cycles whi=
le the memory subsystem was handling loads from local memory. Caching will =
improve the latency and increase performance. Sample with: MEM_LOAD_UOPS_L3=
_MISS_RETIRED.LOCAL_DRAM_PS",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric estimates fraction of cycles whil=
e the memory subsystem was handling loads from remote memory",
+        "MetricExpr": "310 * (MEM_LOAD_UOPS_LLC_MISS_RETIRED.REMOTE_DRAM *=
 (1 + mem_load_uops_retired.hit_lfb / ((MEM_LOAD_UOPS_RETIRED.L2_HIT + MEM_=
LOAD_UOPS_RETIRED.LLC_HIT + MEM_LOAD_UOPS_LLC_HIT_RETIRED.XSNP_HIT + MEM_LO=
AD_UOPS_LLC_HIT_RETIRED.XSNP_HITM + MEM_LOAD_UOPS_LLC_HIT_RETIRED.XSNP_MISS=
) + MEM_LOAD_UOPS_LLC_MISS_RETIRED.LOCAL_DRAM + MEM_LOAD_UOPS_LLC_MISS_RETI=
RED.REMOTE_DRAM + MEM_LOAD_UOPS_LLC_MISS_RETIRED.REMOTE_HITM + MEM_LOAD_UOP=
S_LLC_MISS_RETIRED.REMOTE_FWD))) / CLKS",
+        "MetricGroup": "Server;Snoop;TopdownL5;tma_mem_latency_group",
+        "MetricName": "tma_remote_dram",
+        "PublicDescription": "This metric estimates fraction of cycles whi=
le the memory subsystem was handling loads from remote memory. This is caus=
ed often due to non-optimal NUMA allocations. #link to NUMA article Sample =
with: MEM_LOAD_UOPS_L3_MISS_RETIRED.REMOTE_DRAM_PS",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric estimates fraction of cycles whil=
e the memory subsystem was handling loads from remote cache in other socket=
s including synchronizations issues",
+        "MetricExpr": "(200 * (MEM_LOAD_UOPS_LLC_MISS_RETIRED.REMOTE_HITM =
* (1 + mem_load_uops_retired.hit_lfb / ((MEM_LOAD_UOPS_RETIRED.L2_HIT + MEM=
_LOAD_UOPS_RETIRED.LLC_HIT + MEM_LOAD_UOPS_LLC_HIT_RETIRED.XSNP_HIT + MEM_L=
OAD_UOPS_LLC_HIT_RETIRED.XSNP_HITM + MEM_LOAD_UOPS_LLC_HIT_RETIRED.XSNP_MIS=
S) + MEM_LOAD_UOPS_LLC_MISS_RETIRED.LOCAL_DRAM + MEM_LOAD_UOPS_LLC_MISS_RET=
IRED.REMOTE_DRAM + MEM_LOAD_UOPS_LLC_MISS_RETIRED.REMOTE_HITM + MEM_LOAD_UO=
PS_LLC_MISS_RETIRED.REMOTE_FWD))) + 180 * (MEM_LOAD_UOPS_LLC_MISS_RETIRED.R=
EMOTE_FWD * (1 + mem_load_uops_retired.hit_lfb / ((MEM_LOAD_UOPS_RETIRED.L2=
_HIT + MEM_LOAD_UOPS_RETIRED.LLC_HIT + MEM_LOAD_UOPS_LLC_HIT_RETIRED.XSNP_H=
IT + MEM_LOAD_UOPS_LLC_HIT_RETIRED.XSNP_HITM + MEM_LOAD_UOPS_LLC_HIT_RETIRE=
D.XSNP_MISS) + MEM_LOAD_UOPS_LLC_MISS_RETIRED.LOCAL_DRAM + MEM_LOAD_UOPS_LL=
C_MISS_RETIRED.REMOTE_DRAM + MEM_LOAD_UOPS_LLC_MISS_RETIRED.REMOTE_HITM + M=
EM_LOAD_UOPS_LLC_MISS_RETIRED.REMOTE_FWD)))) / CLKS",
+        "MetricGroup": "Offcore;Server;Snoop;TopdownL5;tma_mem_latency_gro=
up",
+        "MetricName": "tma_remote_cache",
+        "PublicDescription": "This metric estimates fraction of cycles whi=
le the memory subsystem was handling loads from remote cache in other socke=
ts including synchronizations issues. This is caused often due to non-optim=
al NUMA allocations. #link to NUMA article Sample with: MEM_LOAD_UOPS_L3_MI=
SS_RETIRED.REMOTE_HITM_PS;MEM_LOAD_UOPS_L3_MISS_RETIRED.REMOTE_FWD_PS",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric estimates how often CPU was stall=
ed  due to RFO store memory accesses; RFO store issue a read-for-ownership =
request before the write",
+        "MetricExpr": "RESOURCE_STALLS.SB / CLKS",
+        "MetricGroup": "MemoryBound;TmaL3mem;TopdownL3;tma_memory_bound_gr=
oup",
+        "MetricName": "tma_store_bound",
+        "PublicDescription": "This metric estimates how often CPU was stal=
led  due to RFO store memory accesses; RFO store issue a read-for-ownership=
 request before the write. Even though store accesses do not typically stal=
l out-of-order CPUs; there are few cases where stores can lead to actual st=
alls. This metric will be flagged should RFO stores be a bottleneck. Sample=
 with: MEM_UOPS_RETIRED.ALL_STORES_PS",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric estimates fraction of cycles the =
CPU spent handling L1D store misses",
+        "MetricExpr": "((L2_RQSTS.RFO_HIT * 9 * (1 - (MEM_UOPS_RETIRED.LOC=
K_LOADS / MEM_UOPS_RETIRED.ALL_STORES))) + (1 - (MEM_UOPS_RETIRED.LOCK_LOAD=
S / MEM_UOPS_RETIRED.ALL_STORES)) * min(CPU_CLK_UNHALTED.THREAD, OFFCORE_RE=
QUESTS_OUTSTANDING.CYCLES_WITH_DEMAND_RFO)) / CLKS",
+        "MetricGroup": "MemoryLat;Offcore;TopdownL4;tma_store_bound_group"=
,
+        "MetricName": "tma_store_latency",
+        "PublicDescription": "This metric estimates fraction of cycles the=
 CPU spent handling L1D store misses. Store accesses usually less impact ou=
t-of-order core performance; however; holding resources for longer time can=
 lead into undesired implications (e.g. contention on L1D fill-buffer entri=
es - see FB_Full)",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric roughly estimates how often CPU w=
as handling synchronizations due to False Sharing",
+        "MetricExpr": "(200 * OFFCORE_RESPONSE.DEMAND_RFO.LLC_MISS.REMOTE_=
HITM + 60 * OFFCORE_RESPONSE.DEMAND_RFO.LLC_HIT.HITM_OTHER_CORE) / CLKS",
+        "MetricGroup": "DataSharing;Offcore;Snoop;TopdownL4;tma_store_boun=
d_group",
+        "MetricName": "tma_false_sharing",
+        "PublicDescription": "This metric roughly estimates how often CPU =
was handling synchronizations due to False Sharing. False Sharing is a mult=
ithreading hiccup; where multiple Logical Processors contend on different d=
ata-elements mapped into the same cache line.  Sample with: MEM_LOAD_L3_HIT=
_RETIRED.XSNP_HITM_PS;OFFCORE_RESPONSE.DEMAND_RFO.L3_HIT.SNOOP_HITM",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric represents rate of split store ac=
cesses",
+        "MetricExpr": "2 * MEM_UOPS_RETIRED.SPLIT_STORES / CORE_CLKS",
+        "MetricGroup": "TopdownL4;tma_store_bound_group",
+        "MetricName": "tma_split_stores",
+        "PublicDescription": "This metric represents rate of split store a=
ccesses.  Consider aligning your data to the 64-byte cache line granularity=
. Sample with: MEM_UOPS_RETIRED.SPLIT_STORES_PS",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric roughly estimates the fraction of=
 cycles spent handling first-level data TLB store misses",
+        "MetricExpr": "(7 * DTLB_STORE_MISSES.STLB_HIT + DTLB_STORE_MISSES=
.WALK_DURATION) / CLKS",
+        "MetricGroup": "MemoryTLB;TopdownL4;tma_store_bound_group",
+        "MetricName": "tma_dtlb_store",
+        "PublicDescription": "This metric roughly estimates the fraction o=
f cycles spent handling first-level data TLB store misses.  As with ordinar=
y data caching; focus on improving data locality and reducing working-set s=
ize to reduce DTLB overhead.  Additionally; consider using profile-guided o=
ptimization (PGO) to collocate frequently-used data on the same page.  Try =
using larger page sizes for large amounts of frequently-used data. Sample w=
ith: MEM_UOPS_RETIRED.STLB_MISS_STORES_PS",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of slots wher=
e Core non-memory issues were of a bottleneck",
+        "MetricExpr": "tma_backend_bound - tma_memory_bound",
+        "MetricGroup": "Backend;Compute;TopdownL2;tma_L2_group;tma_backend=
_bound_group",
+        "MetricName": "tma_core_bound",
+        "PublicDescription": "This metric represents fraction of slots whe=
re Core non-memory issues were of a bottleneck.  Shortage in hardware compu=
te resources; or dependencies in software's instructions are both categoriz=
ed under Core Bound. Hence it may indicate the machine ran out of an out-of=
-order resource; certain execution units are overloaded or dependencies in =
program's data- or instruction-flow are limiting the performance (e.g. FP-c=
hained long-latency arithmetic operations).",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of cycles whe=
re the Divider unit was active",
+        "MetricExpr": "ARITH.FPU_DIV_ACTIVE / CORE_CLKS",
+        "MetricGroup": "TopdownL3;tma_core_bound_group",
+        "MetricName": "tma_divider",
+        "PublicDescription": "This metric represents fraction of cycles wh=
ere the Divider unit was active. Divide and square root instructions are pe=
rformed by the Divider unit and can take considerably longer latency than i=
nteger or Floating Point addition; subtraction; or multiplication. Sample w=
ith: ARITH.DIVIDER_UOPS",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric estimates fraction of cycles the =
CPU performance was potentially limited due to Core computation issues (non=
 divider-related)",
+        "MetricExpr": "((min(CPU_CLK_UNHALTED.THREAD, CYCLE_ACTIVITY.CYCLE=
S_NO_EXECUTE) + UOPS_EXECUTED.CYCLES_GE_1_UOP_EXEC - UOPS_EXECUTED.CYCLES_G=
E_3_UOPS_EXEC if (IPC > 1.8) else UOPS_EXECUTED.CYCLES_GE_2_UOPS_EXEC - RS_=
EVENTS.EMPTY_CYCLES if (tma_fetch_latency > 0.1) else RESOURCE_STALLS.SB) -=
 RESOURCE_STALLS.SB - min(CPU_CLK_UNHALTED.THREAD, CYCLE_ACTIVITY.STALLS_LD=
M_PENDING)) / CLKS",
+        "MetricGroup": "PortsUtil;TopdownL3;tma_core_bound_group",
+        "MetricName": "tma_ports_utilization",
+        "PublicDescription": "This metric estimates fraction of cycles the=
 CPU performance was potentially limited due to Core computation issues (no=
n divider-related).  Two distinct categories can be attributed into this me=
tric: (1) heavy data-dependency among contiguous instructions would manifes=
t in this metric - such cases are often referred to as low Instruction Leve=
l Parallelism (ILP). (2) Contention on some hardware execution unit other t=
han Divider. For example; when there are too many multiply operations.",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of cycles CPU=
 executed no uops on any execution port (Logical Processor cycles since ICL=
, Physical Core cycles otherwise)",
+        "MetricExpr": "(cpu@UOPS_EXECUTED.CORE\\,inv\\,cmask\\=3D1@) / 2 i=
f #SMT_on else (min(CPU_CLK_UNHALTED.THREAD, CYCLE_ACTIVITY.CYCLES_NO_EXECU=
TE) - RS_EVENTS.EMPTY_CYCLES if (tma_fetch_latency > 0.1) else 0) / CORE_CL=
KS",
+        "MetricGroup": "PortsUtil;TopdownL4;tma_ports_utilization_group",
+        "MetricName": "tma_ports_utilized_0",
+        "PublicDescription": "This metric represents fraction of cycles CP=
U executed no uops on any execution port (Logical Processor cycles since IC=
L, Physical Core cycles otherwise). Long-latency instructions like divides =
may contribute to this metric.",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of cycles whe=
re the CPU executed total of 1 uop per cycle on all execution ports (Logica=
l Processor cycles since ICL, Physical Core cycles otherwise)",
+        "MetricExpr": "(cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D1@ - cpu@UOPS_E=
XECUTED.CORE\\,cmask\\=3D2@) / 2 if #SMT_on else (UOPS_EXECUTED.CYCLES_GE_1=
_UOP_EXEC - UOPS_EXECUTED.CYCLES_GE_2_UOPS_EXEC) / CORE_CLKS",
+        "MetricGroup": "PortsUtil;TopdownL4;tma_ports_utilization_group",
+        "MetricName": "tma_ports_utilized_1",
+        "PublicDescription": "This metric represents fraction of cycles wh=
ere the CPU executed total of 1 uop per cycle on all execution ports (Logic=
al Processor cycles since ICL, Physical Core cycles otherwise). This can be=
 due to heavy data-dependency among software instructions; or over oversubs=
cribing a particular hardware resource. In some other cases with high 1_Por=
t_Utilized and L1_Bound; this metric can point to L1 data-cache latency bot=
tleneck that may not necessarily manifest with complete execution starvatio=
n (due to the short L1 latency e.g. walking a linked list) - looking at the=
 assembly can be helpful.",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of cycles CPU=
 executed total of 2 uops per cycle on all execution ports (Logical Process=
or cycles since ICL, Physical Core cycles otherwise)",
+        "MetricExpr": "(cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D2@ - cpu@UOPS_E=
XECUTED.CORE\\,cmask\\=3D3@) / 2 if #SMT_on else (UOPS_EXECUTED.CYCLES_GE_2=
_UOPS_EXEC - UOPS_EXECUTED.CYCLES_GE_3_UOPS_EXEC) / CORE_CLKS",
+        "MetricGroup": "PortsUtil;TopdownL4;tma_ports_utilization_group",
+        "MetricName": "tma_ports_utilized_2",
+        "PublicDescription": "This metric represents fraction of cycles CP=
U executed total of 2 uops per cycle on all execution ports (Logical Proces=
sor cycles since ICL, Physical Core cycles otherwise).  Loop Vectorization =
-most compilers feature auto-Vectorization options today- reduces pressure =
on the execution ports as multiple elements are calculated with same uop.",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of cycles CPU=
 executed total of 3 or more uops per cycle on all execution ports (Logical=
 Processor cycles since ICL, Physical Core cycles otherwise).",
+        "MetricExpr": "((cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D3@ / 2) if #SM=
T_on else UOPS_EXECUTED.CYCLES_GE_3_UOPS_EXEC) / CORE_CLKS",
+        "MetricGroup": "PortsUtil;TopdownL4;tma_ports_utilization_group",
+        "MetricName": "tma_ports_utilized_3m",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric represents Core fraction of cycle=
s CPU dispatched uops on execution ports for ALU operations.",
+        "MetricExpr": "(UOPS_DISPATCHED_PORT.PORT_0 + UOPS_DISPATCHED_PORT=
.PORT_1 + UOPS_DISPATCHED_PORT.PORT_5) / (3 * CORE_CLKS)",
+        "MetricGroup": "TopdownL5;tma_ports_utilized_3m_group",
+        "MetricName": "tma_alu_op_utilization",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric represents Core fraction of cycle=
s CPU dispatched uops on execution port 0 ([SNB+] ALU; [HSW+] ALU and 2nd b=
ranch) Sample with: UOPS_DISPATCHED_PORT.PORT_0",
+        "MetricExpr": "UOPS_DISPATCHED_PORT.PORT_0 / CORE_CLKS",
+        "MetricGroup": "Compute;TopdownL6;tma_alu_op_utilization_group",
+        "MetricName": "tma_port_0",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric represents Core fraction of cycle=
s CPU dispatched uops on execution port 1 (ALU) Sample with: UOPS_DISPATCHE=
D_PORT.PORT_1",
+        "MetricExpr": "UOPS_DISPATCHED_PORT.PORT_1 / CORE_CLKS",
+        "MetricGroup": "TopdownL6;tma_alu_op_utilization_group",
+        "MetricName": "tma_port_1",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric represents Core fraction of cycle=
s CPU dispatched uops on execution port 5 ([SNB+] Branches and ALU; [HSW+] =
ALU) Sample with: UOPS_DISPATCHED.PORT_5",
+        "MetricExpr": "UOPS_DISPATCHED_PORT.PORT_5 / CORE_CLKS",
+        "MetricGroup": "TopdownL6;tma_alu_op_utilization_group",
+        "MetricName": "tma_port_5",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric represents Core fraction of cycle=
s CPU dispatched uops on execution port for Load operations Sample with: UO=
PS_DISPATCHED.PORT_2_3",
+        "MetricExpr": "(UOPS_DISPATCHED_PORT.PORT_2 + UOPS_DISPATCHED_PORT=
.PORT_3 - UOPS_DISPATCHED_PORT.PORT_4) / (2 * CORE_CLKS)",
+        "MetricGroup": "TopdownL5;tma_ports_utilized_3m_group",
+        "MetricName": "tma_load_op_utilization",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric represents Core fraction of cycle=
s CPU dispatched uops on execution port 2 ([SNB+]Loads and Store-address; [=
ICL+] Loads) Sample with: UOPS_DISPATCHED_PORT.PORT_2",
+        "MetricExpr": "UOPS_DISPATCHED_PORT.PORT_2 / CORE_CLKS",
+        "MetricGroup": "TopdownL6;tma_load_op_utilization_group",
+        "MetricName": "tma_port_2",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric represents Core fraction of cycle=
s CPU dispatched uops on execution port 3 ([SNB+]Loads and Store-address; [=
ICL+] Loads) Sample with: UOPS_DISPATCHED_PORT.PORT_3",
+        "MetricExpr": "UOPS_DISPATCHED_PORT.PORT_3 / CORE_CLKS",
+        "MetricGroup": "TopdownL6;tma_load_op_utilization_group",
+        "MetricName": "tma_port_3",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric represents Core fraction of cycle=
s CPU dispatched uops on execution port for Store operations",
+        "MetricExpr": "UOPS_DISPATCHED_PORT.PORT_4 / CORE_CLKS",
+        "MetricGroup": "TopdownL5;tma_ports_utilized_3m_group",
+        "MetricName": "tma_store_op_utilization",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric represents Core fraction of cycle=
s CPU dispatched uops on execution port 4 (Store-data) Sample with: UOPS_DI=
SPATCHED_PORT.PORT_4",
+        "MetricExpr": "UOPS_DISPATCHED_PORT.PORT_4 / CORE_CLKS",
+        "MetricGroup": "TopdownL6;tma_store_op_utilization_group",
+        "MetricName": "tma_port_4",
+        "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "This category represents fraction of slots ut=
ilized by useful work i.e. issued uops that eventually get retired",
-        "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / (4 * CPU_CLK_UNHALTED.T=
HREAD)",
-        "MetricGroup": "TopdownL1",
-        "MetricName": "Retiring",
-        "PublicDescription": "This category represents fraction of slots u=
tilized by useful work i.e. issued uops that eventually get retired. Ideall=
y; all pipeline slots would be attributed to the Retiring category.  Retiri=
ng of 100% would indicate the maximum Pipeline_Width throughput was achieve=
d.  Maximizing Retiring typically increases the Instructions-per-cycle (see=
 IPC metric). Note that a high Retiring value does not necessary mean there=
 is no room for more performance.  For example; Heavy-operations or Microco=
de Assists are categorized under Retiring. They often indicate suboptimal p=
erformance and can often be optimized or avoided. "
+        "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / SLOTS",
+        "MetricGroup": "TopdownL1;tma_L1_group",
+        "MetricName": "tma_retiring",
+        "PublicDescription": "This category represents fraction of slots u=
tilized by useful work i.e. issued uops that eventually get retired. Ideall=
y; all pipeline slots would be attributed to the Retiring category.  Retiri=
ng of 100% would indicate the maximum Pipeline_Width throughput was achieve=
d.  Maximizing Retiring typically increases the Instructions-per-cycle (see=
 IPC metric). Note that a high Retiring value does not necessary mean there=
 is no room for more performance.  For example; Heavy-operations or Microco=
de Assists are categorized under Retiring. They often indicate suboptimal p=
erformance and can often be optimized or avoided.  Sample with: UOPS_RETIRE=
D.RETIRE_SLOTS",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring light-weight operations -- instructions that require=
 no more than one uop (micro-operation)",
+        "MetricExpr": "tma_retiring - tma_heavy_operations",
+        "MetricGroup": "Retire;TopdownL2;tma_L2_group;tma_retiring_group",
+        "MetricName": "tma_light_operations",
+        "PublicDescription": "This metric represents fraction of slots whe=
re the CPU was retiring light-weight operations -- instructions that requir=
e no more than one uop (micro-operation). This correlates with total number=
 of instructions used by the program. A uops-per-instruction (see UPI metri=
c) ratio of 1 or less should be expected for decently optimized software ru=
nning on Intel Core/Xeon products. While this often indicates efficient X86=
 instructions were executed; high value does not necessarily mean better pe=
rformance cannot be achieved. Sample with: INST_RETIRED.PREC_DIST",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric represents overall arithmetic flo=
ating-point (FP) operations fraction the CPU has executed (retired)",
+        "MetricExpr": "tma_x87_use + tma_fp_scalar + tma_fp_vector",
+        "MetricGroup": "HPC;TopdownL3;tma_light_operations_group",
+        "MetricName": "tma_fp_arith",
+        "PublicDescription": "This metric represents overall arithmetic fl=
oating-point (FP) operations fraction the CPU has executed (retired). Note =
this metric's value may exceed its parent due to use of \"Uops\" CountDomai=
n and FMA double-counting.",
+        "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "This category represents fraction of slots ut=
ilized by useful work i.e. issued uops that eventually get retired. SMT ver=
sion; use when SMT is enabled and measuring per logical CPU.",
-        "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / (4 * ( ( CPU_CLK_UNHALT=
ED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALT=
ED.REF_XCLK ) ))",
-        "MetricGroup": "TopdownL1_SMT",
-        "MetricName": "Retiring_SMT",
-        "PublicDescription": "This category represents fraction of slots u=
tilized by useful work i.e. issued uops that eventually get retired. Ideall=
y; all pipeline slots would be attributed to the Retiring category.  Retiri=
ng of 100% would indicate the maximum Pipeline_Width throughput was achieve=
d.  Maximizing Retiring typically increases the Instructions-per-cycle (see=
 IPC metric). Note that a high Retiring value does not necessary mean there=
 is no room for more performance.  For example; Heavy-operations or Microco=
de Assists are categorized under Retiring. They often indicate suboptimal p=
erformance and can often be optimized or avoided. SMT version; use when SMT=
 is enabled and measuring per logical CPU."
+        "BriefDescription": "This metric serves as an approximation of leg=
acy x87 usage",
+        "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS * FP_COMP_OPS_EXE.X87 / U=
OPS_EXECUTED.THREAD",
+        "MetricGroup": "Compute;TopdownL4;tma_fp_arith_group",
+        "MetricName": "tma_x87_use",
+        "PublicDescription": "This metric serves as an approximation of le=
gacy x87 usage. It accounts for instructions beyond X87 FP arithmetic opera=
tions; hence may be used as a thermometer to avoid X87 high usage and prefe=
rably upgrade to modern ISA. See Tip under Tuning Hint.",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric approximates arithmetic floating-=
point (FP) scalar uops fraction the CPU has retired",
+        "MetricExpr": "(FP_COMP_OPS_EXE.SSE_SCALAR_SINGLE + FP_COMP_OPS_EX=
E.SSE_SCALAR_DOUBLE) / UOPS_EXECUTED.THREAD",
+        "MetricGroup": "Compute;Flops;TopdownL4;tma_fp_arith_group",
+        "MetricName": "tma_fp_scalar",
+        "PublicDescription": "This metric approximates arithmetic floating=
-point (FP) scalar uops fraction the CPU has retired. May overcount due to =
FMA double counting.",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric approximates arithmetic floating-=
point (FP) vector uops fraction the CPU has retired aggregated across all v=
ector widths",
+        "MetricExpr": "(FP_COMP_OPS_EXE.SSE_PACKED_DOUBLE + FP_COMP_OPS_EX=
E.SSE_PACKED_SINGLE + SIMD_FP_256.PACKED_SINGLE + SIMD_FP_256.PACKED_DOUBLE=
) / UOPS_EXECUTED.THREAD",
+        "MetricGroup": "Compute;Flops;TopdownL4;tma_fp_arith_group",
+        "MetricName": "tma_fp_vector",
+        "PublicDescription": "This metric approximates arithmetic floating=
-point (FP) vector uops fraction the CPU has retired aggregated across all =
vector widths. May overcount due to FMA double counting.",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring heavy-weight operations -- instructions that require=
 two or more uops or microcoded sequences",
+        "MetricExpr": "tma_microcode_sequencer",
+        "MetricGroup": "Retire;TopdownL2;tma_L2_group;tma_retiring_group",
+        "MetricName": "tma_heavy_operations",
+        "PublicDescription": "This metric represents fraction of slots whe=
re the CPU was retiring heavy-weight operations -- instructions that requir=
e two or more uops or microcoded sequences. This highly-correlates with the=
 uop length of these instructions/sequences.",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of slots the =
CPU was retiring uops fetched by the Microcode Sequencer (MS) unit",
+        "MetricExpr": "(UOPS_RETIRED.RETIRE_SLOTS / UOPS_ISSUED.ANY) * IDQ=
.MS_UOPS / SLOTS",
+        "MetricGroup": "MicroSeq;TopdownL3;tma_heavy_operations_group",
+        "MetricName": "tma_microcode_sequencer",
+        "PublicDescription": "This metric represents fraction of slots the=
 CPU was retiring uops fetched by the Microcode Sequencer (MS) unit.  The M=
S is used for CISC instructions not supported by the default decoders (like=
 repeat move strings; or CPUID); or by microcode assists used to address so=
me operation modes (like in Floating Point assists). These cases can often =
be avoided. Sample with: IDQ.MS_UOPS",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric estimates fraction of slots the C=
PU retired uops delivered by the Microcode_Sequencer as a result of Assists=
",
+        "MetricExpr": "100 * OTHER_ASSISTS.ANY_WB_ASSIST / SLOTS",
+        "MetricGroup": "TopdownL4;tma_microcode_sequencer_group",
+        "MetricName": "tma_assists",
+        "PublicDescription": "This metric estimates fraction of slots the =
CPU retired uops delivered by the Microcode_Sequencer as a result of Assist=
s. Assists are long sequences of uops that are required in certain corner-c=
ases for operations that cannot be handled natively by the execution pipeli=
ne. For example; when working with very small floating point values (so-cal=
led Denormals); the FP units are not set up to perform these operations nat=
ively. Instead; a sequence of instructions to perform the computation on th=
e Denormals is injected into the pipeline. Since these microcode sequences =
might be dozens of uops long; Assists can be extremely deleterious to perfo=
rmance and they can be avoided in many cases. Sample with: OTHER_ASSISTS.AN=
Y",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric estimates fraction of cycles the =
CPU retired uops originated from CISC (complex instruction set computer) in=
struction",
+        "MetricExpr": "max(0, tma_microcode_sequencer - tma_assists)",
+        "MetricGroup": "TopdownL4;tma_microcode_sequencer_group",
+        "MetricName": "tma_cisc",
+        "PublicDescription": "This metric estimates fraction of cycles the=
 CPU retired uops originated from CISC (complex instruction set computer) i=
nstruction. A CISC instruction has multiple uops that are required to perfo=
rm the instruction's functionality as in the case of read-modify-write as a=
n example. Since these instructions require multiple uops they may or may n=
ot imply sub-optimal use of machine resources.",
+        "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "Instructions Per Cycle (per Logical Processor=
)",
-        "MetricExpr": "INST_RETIRED.ANY / CPU_CLK_UNHALTED.THREAD",
+        "MetricExpr": "INST_RETIRED.ANY / CLKS",
         "MetricGroup": "Ret;Summary",
         "MetricName": "IPC"
     },
@@ -76,8 +536,8 @@
     },
     {
         "BriefDescription": "Cycles Per Instruction (per Logical Processor=
)",
-        "MetricExpr": "1 / (INST_RETIRED.ANY / CPU_CLK_UNHALTED.THREAD)",
-        "MetricGroup": "Pipeline;Mem",
+        "MetricExpr": "1 / IPC",
+        "MetricGroup": "Mem;Pipeline",
         "MetricName": "CPI"
     },
     {
@@ -88,16 +548,10 @@
     },
     {
         "BriefDescription": "Total issue-pipeline slots (per-Physical Core=
 till ICL; per-Logical Processor ICL onward)",
-        "MetricExpr": "4 * CPU_CLK_UNHALTED.THREAD",
-        "MetricGroup": "TmaL1",
+        "MetricExpr": "4 * CORE_CLKS",
+        "MetricGroup": "tma_L1_group",
         "MetricName": "SLOTS"
     },
-    {
-        "BriefDescription": "Total issue-pipeline slots (per-Physical Core=
 till ICL; per-Logical Processor ICL onward)",
-        "MetricExpr": "4 * ( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_C=
LK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )",
-        "MetricGroup": "TmaL1_SMT",
-        "MetricName": "SLOTS_SMT"
-    },
     {
         "BriefDescription": "The ratio of Executed- by Issued-Uops",
         "MetricExpr": "UOPS_EXECUTED.THREAD / UOPS_ISSUED.ANY",
@@ -107,37 +561,25 @@
     },
     {
         "BriefDescription": "Instructions Per Cycle across hyper-threads (=
per physical core)",
-        "MetricExpr": "INST_RETIRED.ANY / CPU_CLK_UNHALTED.THREAD",
-        "MetricGroup": "Ret;SMT;TmaL1",
+        "MetricExpr": "INST_RETIRED.ANY / CORE_CLKS",
+        "MetricGroup": "Ret;SMT;tma_L1_group",
         "MetricName": "CoreIPC"
     },
-    {
-        "BriefDescription": "Instructions Per Cycle across hyper-threads (=
per physical core)",
-        "MetricExpr": "INST_RETIRED.ANY / ( ( CPU_CLK_UNHALTED.THREAD / 2 =
) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) =
)",
-        "MetricGroup": "Ret;SMT;TmaL1_SMT",
-        "MetricName": "CoreIPC_SMT"
-    },
     {
         "BriefDescription": "Floating Point Operations Per Cycle",
-        "MetricExpr": "( 1 * ( FP_COMP_OPS_EXE.SSE_SCALAR_SINGLE + FP_COMP=
_OPS_EXE.SSE_SCALAR_DOUBLE ) + 2 * FP_COMP_OPS_EXE.SSE_PACKED_DOUBLE + 4 * =
( FP_COMP_OPS_EXE.SSE_PACKED_SINGLE + SIMD_FP_256.PACKED_DOUBLE ) + 8 * SIM=
D_FP_256.PACKED_SINGLE ) / CPU_CLK_UNHALTED.THREAD",
-        "MetricGroup": "Ret;Flops",
+        "MetricExpr": "(1 * (FP_COMP_OPS_EXE.SSE_SCALAR_SINGLE + FP_COMP_O=
PS_EXE.SSE_SCALAR_DOUBLE) + 2 * FP_COMP_OPS_EXE.SSE_PACKED_DOUBLE + 4 * (FP=
_COMP_OPS_EXE.SSE_PACKED_SINGLE + SIMD_FP_256.PACKED_DOUBLE) + 8 * SIMD_FP_=
256.PACKED_SINGLE) / CORE_CLKS",
+        "MetricGroup": "Flops;Ret",
         "MetricName": "FLOPc"
     },
-    {
-        "BriefDescription": "Floating Point Operations Per Cycle",
-        "MetricExpr": "( 1 * ( FP_COMP_OPS_EXE.SSE_SCALAR_SINGLE + FP_COMP=
_OPS_EXE.SSE_SCALAR_DOUBLE ) + 2 * FP_COMP_OPS_EXE.SSE_PACKED_DOUBLE + 4 * =
( FP_COMP_OPS_EXE.SSE_PACKED_SINGLE + SIMD_FP_256.PACKED_DOUBLE ) + 8 * SIM=
D_FP_256.PACKED_SINGLE ) / ( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CL=
K_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )",
-        "MetricGroup": "Ret;Flops_SMT",
-        "MetricName": "FLOPc_SMT"
-    },
     {
         "BriefDescription": "Instruction-Level-Parallelism (average number=
 of uops executed when there is execution) per-core",
-        "MetricExpr": "UOPS_EXECUTED.THREAD / (( cpu@UOPS_EXECUTED.CORE\\,=
cmask\\=3D1@ / 2 ) if #SMT_on else UOPS_EXECUTED.CYCLES_GE_1_UOP_EXEC)",
+        "MetricExpr": "UOPS_EXECUTED.THREAD / ((cpu@UOPS_EXECUTED.CORE\\,c=
mask\\=3D1@ / 2) if #SMT_on else UOPS_EXECUTED.CYCLES_GE_1_UOP_EXEC)",
         "MetricGroup": "Backend;Cor;Pipeline;PortsUtil",
         "MetricName": "ILP"
     },
     {
         "BriefDescription": "Core actual clocks when any Logical Processor=
 is active on the Physical Core",
-        "MetricExpr": "( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_U=
NHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )",
+        "MetricExpr": "((CPU_CLK_UNHALTED.THREAD / 2) * (1 + CPU_CLK_UNHAL=
TED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK)) if #core_wide < 1 else =
(CPU_CLK_UNHALTED.THREAD_ANY / 2) if #SMT_on else CLKS",
         "MetricGroup": "SMT",
         "MetricName": "CORE_CLKS"
     },
@@ -179,15 +621,15 @@
     },
     {
         "BriefDescription": "Instructions per FP Arithmetic instruction (l=
ower number means higher occurrence rate)",
-        "MetricExpr": "1 / ( ((FP_COMP_OPS_EXE.SSE_SCALAR_SINGLE + FP_COMP=
_OPS_EXE.SSE_SCALAR_DOUBLE) / UOPS_EXECUTED.THREAD) + ((FP_COMP_OPS_EXE.SSE=
_PACKED_DOUBLE + FP_COMP_OPS_EXE.SSE_PACKED_SINGLE + SIMD_FP_256.PACKED_SIN=
GLE + SIMD_FP_256.PACKED_DOUBLE) / UOPS_EXECUTED.THREAD) )",
+        "MetricExpr": "1 / (tma_fp_scalar + tma_fp_vector)",
         "MetricGroup": "Flops;InsType",
         "MetricName": "IpArith",
         "PublicDescription": "Instructions per FP Arithmetic instruction (=
lower number means higher occurrence rate). May undercount due to FMA doubl=
e counting. Approximated prior to BDW."
     },
     {
-        "BriefDescription": "Total number of retired Instructions, Sample =
with: INST_RETIRED.PREC_DIST",
+        "BriefDescription": "Total number of retired Instructions Sample w=
ith: INST_RETIRED.PREC_DIST",
         "MetricExpr": "INST_RETIRED.ANY",
-        "MetricGroup": "Summary;TmaL1",
+        "MetricGroup": "Summary;tma_L1_group",
         "MetricName": "Instructions"
     },
     {
@@ -204,7 +646,7 @@
     },
     {
         "BriefDescription": "Fraction of Uops delivered by the DSB (aka De=
coded ICache; or Uop Cache)",
-        "MetricExpr": "IDQ.DSB_UOPS / (( IDQ.DSB_UOPS + LSD.UOPS + IDQ.MIT=
E_UOPS + IDQ.MS_UOPS ) )",
+        "MetricExpr": "IDQ.DSB_UOPS / ((IDQ.DSB_UOPS + LSD.UOPS + IDQ.MITE=
_UOPS + IDQ.MS_UOPS))",
         "MetricGroup": "DSB;Fed;FetchBW",
         "MetricName": "DSB_Coverage"
     },
@@ -216,47 +658,41 @@
     },
     {
         "BriefDescription": "Actual Average Latency for L1 data-cache miss=
 demand load operations (in core cycles)",
-        "MetricExpr": "L1D_PEND_MISS.PENDING / ( MEM_LOAD_UOPS_RETIRED.L1_=
MISS + mem_load_uops_retired.hit_lfb )",
+        "MetricExpr": "L1D_PEND_MISS.PENDING / (MEM_LOAD_UOPS_RETIRED.L1_M=
ISS + mem_load_uops_retired.hit_lfb)",
         "MetricGroup": "Mem;MemoryBound;MemoryLat",
         "MetricName": "Load_Miss_Real_Latency"
     },
     {
         "BriefDescription": "Memory-Level-Parallelism (average number of L=
1 miss demand load when there is at least one such miss. Per-Logical Proces=
sor)",
         "MetricExpr": "L1D_PEND_MISS.PENDING / L1D_PEND_MISS.PENDING_CYCLE=
S",
-        "MetricGroup": "Mem;MemoryBound;MemoryBW",
+        "MetricGroup": "Mem;MemoryBW;MemoryBound",
         "MetricName": "MLP"
     },
     {
         "BriefDescription": "L1 cache true misses per kilo instruction for=
 retired demand loads",
         "MetricExpr": "1000 * MEM_LOAD_UOPS_RETIRED.L1_MISS / INST_RETIRED=
.ANY",
-        "MetricGroup": "Mem;CacheMisses",
+        "MetricGroup": "CacheMisses;Mem",
         "MetricName": "L1MPKI"
     },
     {
         "BriefDescription": "L2 cache true misses per kilo instruction for=
 retired demand loads",
         "MetricExpr": "1000 * MEM_LOAD_UOPS_RETIRED.L2_MISS / INST_RETIRED=
.ANY",
-        "MetricGroup": "Mem;Backend;CacheMisses",
+        "MetricGroup": "Backend;CacheMisses;Mem",
         "MetricName": "L2MPKI"
     },
     {
         "BriefDescription": "L3 cache true misses per kilo instruction for=
 retired demand loads",
         "MetricExpr": "1000 * MEM_LOAD_UOPS_RETIRED.LLC_MISS / INST_RETIRE=
D.ANY",
-        "MetricGroup": "Mem;CacheMisses",
+        "MetricGroup": "CacheMisses;Mem",
         "MetricName": "L3MPKI"
     },
     {
         "BriefDescription": "Utilization of the core's Page Walker(s) serv=
ing STLB misses triggered by instruction/Load/Store accesses",
         "MetricConstraint": "NO_NMI_WATCHDOG",
-        "MetricExpr": "( ITLB_MISSES.WALK_DURATION + DTLB_LOAD_MISSES.WALK=
_DURATION + DTLB_STORE_MISSES.WALK_DURATION ) / CPU_CLK_UNHALTED.THREAD",
+        "MetricExpr": "(ITLB_MISSES.WALK_DURATION + DTLB_LOAD_MISSES.WALK_=
DURATION + DTLB_STORE_MISSES.WALK_DURATION) / CORE_CLKS",
         "MetricGroup": "Mem;MemoryTLB",
         "MetricName": "Page_Walks_Utilization"
     },
-    {
-        "BriefDescription": "Utilization of the core's Page Walker(s) serv=
ing STLB misses triggered by instruction/Load/Store accesses",
-        "MetricExpr": "( ITLB_MISSES.WALK_DURATION + DTLB_LOAD_MISSES.WALK=
_DURATION + DTLB_STORE_MISSES.WALK_DURATION ) / ( ( CPU_CLK_UNHALTED.THREAD=
 / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XC=
LK ) )",
-        "MetricGroup": "Mem;MemoryTLB_SMT",
-        "MetricName": "Page_Walks_Utilization_SMT"
-    },
     {
         "BriefDescription": "Average per-core data fill bandwidth to the L=
1 data cache [GB / sec]",
         "MetricExpr": "64 * L1D.REPLACEMENT / 1000000000 / duration_time",
@@ -277,19 +713,19 @@
     },
     {
         "BriefDescription": "Average per-thread data fill bandwidth to the=
 L1 data cache [GB / sec]",
-        "MetricExpr": "(64 * L1D.REPLACEMENT / 1000000000 / duration_time)=
",
+        "MetricExpr": "L1D_Cache_Fill_BW",
         "MetricGroup": "Mem;MemoryBW",
         "MetricName": "L1D_Cache_Fill_BW_1T"
     },
     {
         "BriefDescription": "Average per-thread data fill bandwidth to the=
 L2 cache [GB / sec]",
-        "MetricExpr": "(64 * L2_LINES_IN.ALL / 1000000000 / duration_time)=
",
+        "MetricExpr": "L2_Cache_Fill_BW",
         "MetricGroup": "Mem;MemoryBW",
         "MetricName": "L2_Cache_Fill_BW_1T"
     },
     {
         "BriefDescription": "Average per-thread data fill bandwidth to the=
 L3 cache [GB / sec]",
-        "MetricExpr": "(64 * LONGEST_LAT_CACHE.MISS / 1000000000 / duratio=
n_time)",
+        "MetricExpr": "L3_Cache_Fill_BW",
         "MetricGroup": "Mem;MemoryBW",
         "MetricName": "L3_Cache_Fill_BW_1T"
     },
@@ -307,26 +743,26 @@
     },
     {
         "BriefDescription": "Measured Average Frequency for unhalted proce=
ssors [GHz]",
-        "MetricExpr": "(CPU_CLK_UNHALTED.THREAD / CPU_CLK_UNHALTED.REF_TSC=
) * msr@tsc@ / 1000000000 / duration_time",
-        "MetricGroup": "Summary;Power",
+        "MetricExpr": "Turbo_Utilization * msr@tsc@ / 1000000000 / duratio=
n_time",
+        "MetricGroup": "Power;Summary",
         "MetricName": "Average_Frequency"
     },
     {
         "BriefDescription": "Giga Floating Point Operations Per Second",
-        "MetricExpr": "( ( 1 * ( FP_COMP_OPS_EXE.SSE_SCALAR_SINGLE + FP_CO=
MP_OPS_EXE.SSE_SCALAR_DOUBLE ) + 2 * FP_COMP_OPS_EXE.SSE_PACKED_DOUBLE + 4 =
* ( FP_COMP_OPS_EXE.SSE_PACKED_SINGLE + SIMD_FP_256.PACKED_DOUBLE ) + 8 * S=
IMD_FP_256.PACKED_SINGLE ) / 1000000000 ) / duration_time",
+        "MetricExpr": "((1 * (FP_COMP_OPS_EXE.SSE_SCALAR_SINGLE + FP_COMP_=
OPS_EXE.SSE_SCALAR_DOUBLE) + 2 * FP_COMP_OPS_EXE.SSE_PACKED_DOUBLE + 4 * (F=
P_COMP_OPS_EXE.SSE_PACKED_SINGLE + SIMD_FP_256.PACKED_DOUBLE) + 8 * SIMD_FP=
_256.PACKED_SINGLE) / 1000000000) / duration_time",
         "MetricGroup": "Cor;Flops;HPC",
         "MetricName": "GFLOPs",
         "PublicDescription": "Giga Floating Point Operations Per Second. A=
ggregate across all supported options of: FP precisions, scalar and vector =
instructions, vector-width and AMX engine."
     },
     {
         "BriefDescription": "Average Frequency Utilization relative nomina=
l frequency",
-        "MetricExpr": "CPU_CLK_UNHALTED.THREAD / CPU_CLK_UNHALTED.REF_TSC"=
,
+        "MetricExpr": "CLKS / CPU_CLK_UNHALTED.REF_TSC",
         "MetricGroup": "Power",
         "MetricName": "Turbo_Utilization"
     },
     {
         "BriefDescription": "Fraction of cycles where both hardware Logica=
l Processors were active",
-        "MetricExpr": "1 - CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / ( CPU_CLK_=
UNHALTED.REF_XCLK_ANY / 2 ) if #SMT_on else 0",
+        "MetricExpr": "1 - CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / (CPU_CLK_U=
NHALTED.REF_XCLK_ANY / 2) if #SMT_on else 0",
         "MetricGroup": "SMT",
         "MetricName": "SMT_2T_Utilization"
     },
@@ -344,7 +780,7 @@
     },
     {
         "BriefDescription": "Average external Memory Bandwidth Use for rea=
ds and writes [GB / sec]",
-        "MetricExpr": "( 64 * ( uncore_imc@cas_count_read@ + uncore_imc@ca=
s_count_write@ ) / 1000000000 ) / duration_time",
+        "MetricExpr": "(64 * (uncore_imc@cas_count_read@ + uncore_imc@cas_=
count_write@) / 1000000000) / duration_time",
         "MetricGroup": "HPC;Mem;MemoryBW;SoC",
         "MetricName": "DRAM_BW_Use"
     },
@@ -354,12 +790,6 @@
         "MetricGroup": "SoC",
         "MetricName": "Socket_CLKS"
     },
-    {
-        "BriefDescription": "Uncore frequency per die [GHZ]",
-        "MetricExpr": "cbox_0@event\\=3D0x0@ / #num_dies / duration_time /=
 1000000000",
-        "MetricGroup": "SoC",
-        "MetricName": "UNCORE_FREQ"
-    },
     {
         "BriefDescription": "Instructions per Far Branch ( Far Branches ap=
ply upon transition from application to operating system, handling interrup=
ts, exceptions) [lower number means higher occurrence rate]",
         "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.FAR_BRANCH:u",
@@ -407,5 +837,11 @@
         "MetricExpr": "(cstate_pkg@c7\\-residency@ / msr@tsc@) * 100",
         "MetricGroup": "Power",
         "MetricName": "C7_Pkg_Residency"
+    },
+    {
+        "BriefDescription": "Uncore frequency per die [GHZ]",
+        "MetricExpr": "Socket_CLKS / #num_dies / duration_time / 100000000=
0",
+        "MetricGroup": "SoC",
+        "MetricName": "UNCORE_FREQ"
     }
 ]
diff --git a/tools/perf/pmu-events/arch/x86/ivytown/uncore-cache.json b/too=
ls/perf/pmu-events/arch/x86/ivytown/uncore-cache.json
index 93e07385eeec..c118ff54c30e 100644
--- a/tools/perf/pmu-events/arch/x86/ivytown/uncore-cache.json
+++ b/tools/perf/pmu-events/arch/x86/ivytown/uncore-cache.json
@@ -61,7 +61,7 @@
         "EventCode": "0x34",
         "EventName": "UNC_C_LLC_LOOKUP.WRITE",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of times the LLC was acces=
sed - this includes code, data, prefetches and hints coming from L2.  This =
has numerous filters available.  Note the non-standard filtering equation. =
 This event will count requests that lookup the cache multiple times with m=
ultiple increments.  One must ALWAYS set filter mask bit 0 and select a sta=
te or states to match.  Otherwise, the event will count nothing.   CBoGlCtr=
l[22:17] bits correspond to [M'FMESI] state.; Writeback transactions from L=
2 to the LLC  This includes all write transactions -- both Cachable and UC.=
",
+        "PublicDescription": "Counts the number of times the LLC was acces=
sed - this includes code, data, prefetches and hints coming from L2.  This =
has numerous filters available.  Note the non-standard filtering equation. =
 This event will count requests that lookup the cache multiple times with m=
ultiple increments.  One must ALWAYS set filter mask bit 0 and select a sta=
te or states to match.  Otherwise, the event will count nothing.   CBoGlCtr=
l[22:17] bits correspond to [M'FMESI] state.; Writeback transactions from L=
2 to the LLC  This includes all write transactions -- both Cacheable and UC=
.",
         "UMask": "0x5",
         "Unit": "CBO"
     },
@@ -999,7 +999,7 @@
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.ALL",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH and=
 set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; All transactions inserted=
 into the TOR.    This includes requests that reside in the TOR for a short=
 time, such as LLC Hits that do not need to snoop cores or requests that ge=
t rejected and have to be retried through one of the ingress queues.  The T=
OR is more commonly a bottleneck in skews with smaller core counts, where t=
he ratio of RTIDs to TOR entries is larger.  Note that there are reserved T=
OR entries for various request types, so it is possible that a given reques=
t type be blocked with an occupancy that is less than 20.  Also note that g=
enerally requests will not be able to arbitrate into the TOR pipeline if th=
ere are no available TOR slots.",
+        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; All transactions inserte=
d into the TOR.    This includes requests that reside in the TOR for a shor=
t time, such as LLC Hits that do not need to snoop cores or requests that g=
et rejected and have to be retried through one of the ingress queues.  The =
TOR is more commonly a bottleneck in skews with smaller core counts, where =
the ratio of RTIDs to TOR entries is larger.  Note that there are reserved =
TOR entries for various request types, so it is possible that a given reque=
st type be blocked with an occupancy that is less than 20.  Also note that =
generally requests will not be able to arbitrate into the TOR pipeline if t=
here are no available TOR slots.",
         "UMask": "0x8",
         "Unit": "CBO"
     },
@@ -1009,7 +1009,7 @@
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.EVICTION",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH and=
 set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Eviction transactions ins=
erted into the TOR.  Evictions can be quick, such as when the line is in th=
e F, S, or E states and no core valid bits are set.  They can also be longe=
r if either CV bits are set (so the cores need to be snooped) and/or if the=
re is a HitM (in which case it is necessary to write the request out to mem=
ory).",
+        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Eviction transactions in=
serted into the TOR.  Evictions can be quick, such as when the line is in t=
he F, S, or E states and no core valid bits are set.  They can also be long=
er if either CV bits are set (so the cores need to be snooped) and/or if th=
ere is a HitM (in which case it is necessary to write the request out to me=
mory).",
         "UMask": "0x4",
         "Unit": "CBO"
     },
@@ -1019,7 +1019,7 @@
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.LOCAL",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH and=
 set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; All transactions inserted=
 into the TOR that are satisifed by locally HOMed memory.",
+        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; All transactions inserte=
d into the TOR that are satisfied by locally HOMed memory.",
         "UMask": "0x28",
         "Unit": "CBO"
     },
@@ -1029,7 +1029,7 @@
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.LOCAL_OPCODE",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH and=
 set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; All transactions, satisif=
ed by an opcode,  inserted into the TOR that are satisifed by locally HOMed=
 memory.",
+        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; All transactions, satisf=
ied by an opcode,  inserted into the TOR that are satisfied by locally HOMe=
d memory.",
         "UMask": "0x21",
         "Unit": "CBO"
     },
@@ -1039,7 +1039,7 @@
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.MISS_LOCAL",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH and=
 set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Miss transactions inserte=
d into the TOR that are satisifed by locally HOMed memory.",
+        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Miss transactions insert=
ed into the TOR that are satisfied by locally HOMed memory.",
         "UMask": "0x2A",
         "Unit": "CBO"
     },
@@ -1049,7 +1049,7 @@
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.MISS_LOCAL_OPCODE",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH and=
 set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Miss transactions, satisi=
fed by an opcode, inserted into the TOR that are satisifed by locally HOMed=
 memory.",
+        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Miss transactions, satis=
fied by an opcode, inserted into the TOR that are satisfied by locally HOMe=
d memory.",
         "UMask": "0x23",
         "Unit": "CBO"
     },
@@ -1059,7 +1059,7 @@
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.MISS_OPCODE",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH and=
 set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Miss transactions inserte=
d into the TOR that match an opcode.",
+        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Miss transactions insert=
ed into the TOR that match an opcode.",
         "UMask": "0x3",
         "Unit": "CBO"
     },
@@ -1069,7 +1069,7 @@
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.MISS_REMOTE",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH and=
 set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Miss transactions inserte=
d into the TOR that are satisifed by remote caches or remote memory.",
+        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Miss transactions insert=
ed into the TOR that are satisfied by remote caches or remote memory.",
         "UMask": "0x8A",
         "Unit": "CBO"
     },
@@ -1079,7 +1079,7 @@
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.MISS_REMOTE_OPCODE",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH and=
 set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Miss transactions, satisi=
fed by an opcode,  inserted into the TOR that are satisifed by remote cache=
s or remote memory.",
+        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Miss transactions, satis=
fied by an opcode,  inserted into the TOR that are satisfied by remote cach=
es or remote memory.",
         "UMask": "0x83",
         "Unit": "CBO"
     },
@@ -1089,7 +1089,7 @@
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.NID_ALL",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH and=
 set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; All NID matched (matches =
an RTID destination) transactions inserted into the TOR.  The NID is progra=
mmed in Cn_MSR_PMON_BOX_FILTER.nid.  In conjunction with STATE =3D I, it is=
 possible to monitor misses to specific NIDs in the system.",
+        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; All NID matched (matches=
 an RTID destination) transactions inserted into the TOR.  The NID is progr=
ammed in Cn_MSR_PMON_BOX_FILTER.nid.  In conjunction with STATE =3D I, it i=
s possible to monitor misses to specific NIDs in the system.",
         "UMask": "0x48",
         "Unit": "CBO"
     },
@@ -1099,7 +1099,7 @@
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.NID_EVICTION",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH and=
 set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; NID matched eviction tran=
sactions inserted into the TOR.",
+        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; NID matched eviction tra=
nsactions inserted into the TOR.",
         "UMask": "0x44",
         "Unit": "CBO"
     },
@@ -1109,7 +1109,7 @@
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.NID_MISS_ALL",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH and=
 set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; All NID matched miss requ=
ests that were inserted into the TOR.",
+        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; All NID matched miss req=
uests that were inserted into the TOR.",
         "UMask": "0x4A",
         "Unit": "CBO"
     },
@@ -1119,7 +1119,7 @@
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.NID_MISS_OPCODE",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH and=
 set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Miss transactions inserte=
d into the TOR that match a NID and an opcode.",
+        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Miss transactions insert=
ed into the TOR that match a NID and an opcode.",
         "UMask": "0x43",
         "Unit": "CBO"
     },
@@ -1129,7 +1129,7 @@
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.NID_OPCODE",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH and=
 set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Transactions inserted int=
o the TOR that match a NID and an opcode.",
+        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Transactions inserted in=
to the TOR that match a NID and an opcode.",
         "UMask": "0x41",
         "Unit": "CBO"
     },
@@ -1139,7 +1139,7 @@
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.NID_WB",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH and=
 set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; NID matched write transac=
tions inserted into the TOR.",
+        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; NID matched write transa=
ctions inserted into the TOR.",
         "UMask": "0x50",
         "Unit": "CBO"
     },
@@ -1149,7 +1149,7 @@
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.OPCODE",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH and=
 set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Transactions inserted int=
o the TOR that match an opcode (matched by Cn_MSR_PMON_BOX_FILTER.opc)",
+        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Transactions inserted in=
to the TOR that match an opcode (matched by Cn_MSR_PMON_BOX_FILTER.opc)",
         "UMask": "0x1",
         "Unit": "CBO"
     },
@@ -1159,7 +1159,7 @@
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.REMOTE",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH and=
 set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; All transactions inserted=
 into the TOR that are satisifed by remote caches or remote memory.",
+        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; All transactions inserte=
d into the TOR that are satisfied by remote caches or remote memory.",
         "UMask": "0x88",
         "Unit": "CBO"
     },
@@ -1169,7 +1169,7 @@
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.REMOTE_OPCODE",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH and=
 set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; All transactions, satisif=
ed by an opcode,  inserted into the TOR that are satisifed by remote caches=
 or remote memory.",
+        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; All transactions, satisf=
ied by an opcode,  inserted into the TOR that are satisfied by remote cache=
s or remote memory.",
         "UMask": "0x81",
         "Unit": "CBO"
     },
@@ -1179,7 +1179,7 @@
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.WB",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH and=
 set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Write transactions insert=
ed into the TOR.   This does not include RFO, but actual operations that co=
ntain data being sent from the core.",
+        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Write transactions inser=
ted into the TOR.   This does not include RFO, but actual operations that c=
ontain data being sent from the core.",
         "UMask": "0x10",
         "Unit": "CBO"
     },
@@ -1215,7 +1215,7 @@
         "EventCode": "0x36",
         "EventName": "UNC_C_TOR_OCCUPANCY.LOCAL_OPCODE",
         "PerPkg": "1",
-        "PublicDescription": "For each cycle, this event accumulates the n=
umber of valid entries in the TOR that match qualifications specified by th=
e subevent.   There are a number of subevent 'filters' but only a subset of=
 the subevent combinations are valid.  Subevents that require an opcode or =
NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  I=
f, for example, one wanted to count DRD Local Misses, one should select MIS=
S_OPC_MATCH and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182); Number of ou=
tstanding  transactions, satisifed by an opcode,  in the TOR that are satis=
ifed by locally HOMed memory.",
+        "PublicDescription": "For each cycle, this event accumulates the n=
umber of valid entries in the TOR that match qualifications specified by th=
e subevent.   There are a number of subevent 'filters' but only a subset of=
 the subevent combinations are valid.  Subevents that require an opcode or =
NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  I=
f, for example, one wanted to count DRD Local Misses, one should select MIS=
S_OPC_MATCH and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182); Number of ou=
tstanding  transactions, satisfied by an opcode,  in the TOR that are satis=
fied by locally HOMed memory.",
         "UMask": "0x21",
         "Unit": "CBO"
     },
@@ -1242,7 +1242,7 @@
         "EventCode": "0x36",
         "EventName": "UNC_C_TOR_OCCUPANCY.MISS_LOCAL_OPCODE",
         "PerPkg": "1",
-        "PublicDescription": "For each cycle, this event accumulates the n=
umber of valid entries in the TOR that match qualifications specified by th=
e subevent.   There are a number of subevent 'filters' but only a subset of=
 the subevent combinations are valid.  Subevents that require an opcode or =
NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  I=
f, for example, one wanted to count DRD Local Misses, one should select MIS=
S_OPC_MATCH and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182); Number of ou=
tstanding Miss transactions, satisifed by an opcode, in the TOR that are sa=
tisifed by locally HOMed memory.",
+        "PublicDescription": "For each cycle, this event accumulates the n=
umber of valid entries in the TOR that match qualifications specified by th=
e subevent.   There are a number of subevent 'filters' but only a subset of=
 the subevent combinations are valid.  Subevents that require an opcode or =
NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  I=
f, for example, one wanted to count DRD Local Misses, one should select MIS=
S_OPC_MATCH and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182); Number of ou=
tstanding Miss transactions, satisfied by an opcode, in the TOR that are sa=
tisfied by locally HOMed memory.",
         "UMask": "0x23",
         "Unit": "CBO"
     },
@@ -1269,7 +1269,7 @@
         "EventCode": "0x36",
         "EventName": "UNC_C_TOR_OCCUPANCY.MISS_REMOTE_OPCODE",
         "PerPkg": "1",
-        "PublicDescription": "For each cycle, this event accumulates the n=
umber of valid entries in the TOR that match qualifications specified by th=
e subevent.   There are a number of subevent 'filters' but only a subset of=
 the subevent combinations are valid.  Subevents that require an opcode or =
NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  I=
f, for example, one wanted to count DRD Local Misses, one should select MIS=
S_OPC_MATCH and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182); Number of ou=
tstanding Miss transactions, satisifed by an opcode, in the TOR that are sa=
tisifed by remote caches or remote memory.",
+        "PublicDescription": "For each cycle, this event accumulates the n=
umber of valid entries in the TOR that match qualifications specified by th=
e subevent.   There are a number of subevent 'filters' but only a subset of=
 the subevent combinations are valid.  Subevents that require an opcode or =
NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  I=
f, for example, one wanted to count DRD Local Misses, one should select MIS=
S_OPC_MATCH and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182); Number of ou=
tstanding Miss transactions, satisfied by an opcode, in the TOR that are sa=
tisfied by remote caches or remote memory.",
         "UMask": "0x83",
         "Unit": "CBO"
     },
@@ -1350,7 +1350,7 @@
         "EventCode": "0x36",
         "EventName": "UNC_C_TOR_OCCUPANCY.REMOTE_OPCODE",
         "PerPkg": "1",
-        "PublicDescription": "For each cycle, this event accumulates the n=
umber of valid entries in the TOR that match qualifications specified by th=
e subevent.   There are a number of subevent 'filters' but only a subset of=
 the subevent combinations are valid.  Subevents that require an opcode or =
NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  I=
f, for example, one wanted to count DRD Local Misses, one should select MIS=
S_OPC_MATCH and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182); Number of ou=
tstanding  transactions, satisifed by an opcode,  in the TOR that are satis=
ifed by remote caches or remote memory.",
+        "PublicDescription": "For each cycle, this event accumulates the n=
umber of valid entries in the TOR that match qualifications specified by th=
e subevent.   There are a number of subevent 'filters' but only a subset of=
 the subevent combinations are valid.  Subevents that require an opcode or =
NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  I=
f, for example, one wanted to count DRD Local Misses, one should select MIS=
S_OPC_MATCH and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182); Number of ou=
tstanding  transactions, satisfied by an opcode,  in the TOR that are satis=
fied by remote caches or remote memory.",
         "UMask": "0x81",
         "Unit": "CBO"
     },
@@ -1446,7 +1446,7 @@
         "EventCode": "0x2",
         "EventName": "UNC_C_TxR_INSERTS.BL_CORE",
         "PerPkg": "1",
-        "PublicDescription": "Number of allocations into the Cbo Egress.  =
The Egress is used to queue up requests destined for the ring.; Ring transa=
ctions from the Corebo destined for the BL ring.  This is commonly used for=
 transfering writeback data to the cache.",
+        "PublicDescription": "Number of allocations into the Cbo Egress.  =
The Egress is used to queue up requests destined for the ring.; Ring transa=
ctions from the Corebo destined for the BL ring.  This is commonly used for=
 transferring writeback data to the cache.",
         "UMask": "0x40",
         "Unit": "CBO"
     },
@@ -1692,7 +1692,7 @@
         "EventCode": "0xb",
         "EventName": "UNC_H_CONFLICT_CYCLES.LAST",
         "PerPkg": "1",
-        "PublicDescription": "Count every last conflictor in conflict chai=
n. Can be used to compute the average conflict chain length as (#Ackcnflts/=
#LastConflictor)+1. This can be used to give a feel for the conflict chain =
lenghts while analyzing lock kernels.",
+        "PublicDescription": "Count every last conflictor in conflict chai=
n. Can be used to compute the average conflict chain length as (#Ackcnflts/=
#LastConflictor)+1. This can be used to give a feel for the conflict chain =
lengths while analyzing lock kernels.",
         "UMask": "0x4",
         "Unit": "HA"
     },
@@ -1729,7 +1729,7 @@
         "EventCode": "0x41",
         "EventName": "UNC_H_DIRECTORY_LAT_OPT",
         "PerPkg": "1",
-        "PublicDescription": "Directory Latency Optimization Data Return P=
ath Taken. When directory mode is enabled and the directory retuned for a r=
ead is Dir=3DI, then data can be returned using a faster path if certain co=
nditions are met (credits, free pipeline, etc).",
+        "PublicDescription": "Directory Latency Optimization Data Return P=
ath Taken. When directory mode is enabled and the directory returned for a =
read is Dir=3DI, then data can be returned using a faster path if certain c=
onditions are met (credits, free pipeline, etc).",
         "Unit": "HA"
     },
     {
@@ -2686,7 +2686,7 @@
         "EventCode": "0x21",
         "EventName": "UNC_H_SNOOP_RESP.RSPSFWD",
         "PerPkg": "1",
-        "PublicDescription": "Counts the total number of RspI snoop respon=
ses received.  Whenever a snoops are issued, one or more snoop responses wi=
ll be returned depending on the topology of the system.   In systems larger=
 than 2s, when multiple snoops are returned this will count all the snoops =
that are received.  For example, if 3 snoops were issued and returned RspI,=
 RspS, and RspSFwd; then each of these sub-events would increment by 1.; Fi=
lters for a snoop response of RspSFwd.  This is returned when a remote cach=
ing agent forwards data but holds on to its currentl copy.  This is common =
for data and code reads that hit in a remote socket in E or F state.",
+        "PublicDescription": "Counts the total number of RspI snoop respon=
ses received.  Whenever a snoops are issued, one or more snoop responses wi=
ll be returned depending on the topology of the system.   In systems larger=
 than 2s, when multiple snoops are returned this will count all the snoops =
that are received.  For example, if 3 snoops were issued and returned RspI,=
 RspS, and RspSFwd; then each of these sub-events would increment by 1.; Fi=
lters for a snoop response of RspSFwd.  This is returned when a remote cach=
ing agent forwards data but holds on to its currently copy.  This is common=
 for data and code reads that hit in a remote socket in E or F state.",
         "UMask": "0x8",
         "Unit": "HA"
     },
@@ -2766,7 +2766,7 @@
         "EventCode": "0x60",
         "EventName": "UNC_H_SNP_RESP_RECV_LOCAL.RSPSFWD",
         "PerPkg": "1",
-        "PublicDescription": "Number of snoop responses received for a Loc=
al  request; Filters for a snoop response of RspSFwd.  This is returned whe=
n a remote caching agent forwards data but holds on to its currentl copy.  =
This is common for data and code reads that hit in a remote socket in E or =
F state.",
+        "PublicDescription": "Number of snoop responses received for a Loc=
al  request; Filters for a snoop response of RspSFwd.  This is returned whe=
n a remote caching agent forwards data but holds on to its currently copy. =
 This is common for data and code reads that hit in a remote socket in E or=
 F state.",
         "UMask": "0x8",
         "Unit": "HA"
     },
diff --git a/tools/perf/pmu-events/arch/x86/ivytown/uncore-interconnect.jso=
n b/tools/perf/pmu-events/arch/x86/ivytown/uncore-interconnect.json
index b3b1a08d4acf..10ea4afeffc1 100644
--- a/tools/perf/pmu-events/arch/x86/ivytown/uncore-interconnect.json
+++ b/tools/perf/pmu-events/arch/x86/ivytown/uncore-interconnect.json
@@ -24,7 +24,7 @@
         "EventCode": "0x13",
         "EventName": "UNC_Q_DIRECT2CORE.FAILURE_CREDITS",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of DRS packets that we att=
empted to do direct2core on.  There are 4 mutually exlusive filters.  Filte=
r [0] can be used to get successful spawns, while [1:3] provide the differe=
nt failure cases.  Note that this does not count packets that are not candi=
dates for Direct2Core.  The only candidates for Direct2Core are DRS packets=
 destined for Cbos.; The spawn failed because there were not enough Egress =
credits.  Had there been enough credits, the spawn would have worked as the=
 RBT bit was set and the RBT tag matched.",
+        "PublicDescription": "Counts the number of DRS packets that we att=
empted to do direct2core on.  There are 4 mutually exclusive filters.  Filt=
er [0] can be used to get successful spawns, while [1:3] provide the differ=
ent failure cases.  Note that this does not count packets that are not cand=
idates for Direct2Core.  The only candidates for Direct2Core are DRS packet=
s destined for Cbos.; The spawn failed because there were not enough Egress=
 credits.  Had there been enough credits, the spawn would have worked as th=
e RBT bit was set and the RBT tag matched.",
         "UMask": "0x2",
         "Unit": "QPI LL"
     },
@@ -34,7 +34,7 @@
         "EventCode": "0x13",
         "EventName": "UNC_Q_DIRECT2CORE.FAILURE_CREDITS_MISS",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of DRS packets that we att=
empted to do direct2core on.  There are 4 mutually exlusive filters.  Filte=
r [0] can be used to get successful spawns, while [1:3] provide the differe=
nt failure cases.  Note that this does not count packets that are not candi=
dates for Direct2Core.  The only candidates for Direct2Core are DRS packets=
 destined for Cbos.; The spawn failed because the RBT tag did not match and=
 there weren't enough Egress credits.   The valid bit was set.",
+        "PublicDescription": "Counts the number of DRS packets that we att=
empted to do direct2core on.  There are 4 mutually exclusive filters.  Filt=
er [0] can be used to get successful spawns, while [1:3] provide the differ=
ent failure cases.  Note that this does not count packets that are not cand=
idates for Direct2Core.  The only candidates for Direct2Core are DRS packet=
s destined for Cbos.; The spawn failed because the RBT tag did not match an=
d there weren't enough Egress credits.   The valid bit was set.",
         "UMask": "0x20",
         "Unit": "QPI LL"
     },
@@ -44,7 +44,7 @@
         "EventCode": "0x13",
         "EventName": "UNC_Q_DIRECT2CORE.FAILURE_CREDITS_RBT",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of DRS packets that we att=
empted to do direct2core on.  There are 4 mutually exlusive filters.  Filte=
r [0] can be used to get successful spawns, while [1:3] provide the differe=
nt failure cases.  Note that this does not count packets that are not candi=
dates for Direct2Core.  The only candidates for Direct2Core are DRS packets=
 destined for Cbos.; The spawn failed because there were not enough Egress =
credits AND the RBT bit was not set, but the RBT tag matched.",
+        "PublicDescription": "Counts the number of DRS packets that we att=
empted to do direct2core on.  There are 4 mutually exclusive filters.  Filt=
er [0] can be used to get successful spawns, while [1:3] provide the differ=
ent failure cases.  Note that this does not count packets that are not cand=
idates for Direct2Core.  The only candidates for Direct2Core are DRS packet=
s destined for Cbos.; The spawn failed because there were not enough Egress=
 credits AND the RBT bit was not set, but the RBT tag matched.",
         "UMask": "0x8",
         "Unit": "QPI LL"
     },
@@ -54,7 +54,7 @@
         "EventCode": "0x13",
         "EventName": "UNC_Q_DIRECT2CORE.FAILURE_CREDITS_RBT_MISS",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of DRS packets that we att=
empted to do direct2core on.  There are 4 mutually exlusive filters.  Filte=
r [0] can be used to get successful spawns, while [1:3] provide the differe=
nt failure cases.  Note that this does not count packets that are not candi=
dates for Direct2Core.  The only candidates for Direct2Core are DRS packets=
 destined for Cbos.; The spawn failed because the RBT tag did not match, th=
e valid bit was not set and there weren't enough Egress credits.",
+        "PublicDescription": "Counts the number of DRS packets that we att=
empted to do direct2core on.  There are 4 mutually exclusive filters.  Filt=
er [0] can be used to get successful spawns, while [1:3] provide the differ=
ent failure cases.  Note that this does not count packets that are not cand=
idates for Direct2Core.  The only candidates for Direct2Core are DRS packet=
s destined for Cbos.; The spawn failed because the RBT tag did not match, t=
he valid bit was not set and there weren't enough Egress credits.",
         "UMask": "0x80",
         "Unit": "QPI LL"
     },
@@ -64,7 +64,7 @@
         "EventCode": "0x13",
         "EventName": "UNC_Q_DIRECT2CORE.FAILURE_MISS",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of DRS packets that we att=
empted to do direct2core on.  There are 4 mutually exlusive filters.  Filte=
r [0] can be used to get successful spawns, while [1:3] provide the differe=
nt failure cases.  Note that this does not count packets that are not candi=
dates for Direct2Core.  The only candidates for Direct2Core are DRS packets=
 destined for Cbos.; The spawn failed because the RBT tag did not match alt=
hough the valid bit was set and there were enough Egress credits.",
+        "PublicDescription": "Counts the number of DRS packets that we att=
empted to do direct2core on.  There are 4 mutually exclusive filters.  Filt=
er [0] can be used to get successful spawns, while [1:3] provide the differ=
ent failure cases.  Note that this does not count packets that are not cand=
idates for Direct2Core.  The only candidates for Direct2Core are DRS packet=
s destined for Cbos.; The spawn failed because the RBT tag did not match al=
though the valid bit was set and there were enough Egress credits.",
         "UMask": "0x10",
         "Unit": "QPI LL"
     },
@@ -74,7 +74,7 @@
         "EventCode": "0x13",
         "EventName": "UNC_Q_DIRECT2CORE.FAILURE_RBT_HIT",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of DRS packets that we att=
empted to do direct2core on.  There are 4 mutually exlusive filters.  Filte=
r [0] can be used to get successful spawns, while [1:3] provide the differe=
nt failure cases.  Note that this does not count packets that are not candi=
dates for Direct2Core.  The only candidates for Direct2Core are DRS packets=
 destined for Cbos.; The spawn failed because the route-back table (RBT) sp=
ecified that the transaction should not trigger a direct2core tranaction.  =
This is common for IO transactions.  There were enough Egress credits and t=
he RBT tag matched but the valid bit was not set.",
+        "PublicDescription": "Counts the number of DRS packets that we att=
empted to do direct2core on.  There are 4 mutually exclusive filters.  Filt=
er [0] can be used to get successful spawns, while [1:3] provide the differ=
ent failure cases.  Note that this does not count packets that are not cand=
idates for Direct2Core.  The only candidates for Direct2Core are DRS packet=
s destined for Cbos.; The spawn failed because the route-back table (RBT) s=
pecified that the transaction should not trigger a direct2core transaction.=
  This is common for IO transactions.  There were enough Egress credits and=
 the RBT tag matched but the valid bit was not set.",
         "UMask": "0x4",
         "Unit": "QPI LL"
     },
@@ -84,7 +84,7 @@
         "EventCode": "0x13",
         "EventName": "UNC_Q_DIRECT2CORE.FAILURE_RBT_MISS",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of DRS packets that we att=
empted to do direct2core on.  There are 4 mutually exlusive filters.  Filte=
r [0] can be used to get successful spawns, while [1:3] provide the differe=
nt failure cases.  Note that this does not count packets that are not candi=
dates for Direct2Core.  The only candidates for Direct2Core are DRS packets=
 destined for Cbos.; The spawn failed because the RBT tag did not match and=
 the valid bit was not set although there were enough Egress credits.",
+        "PublicDescription": "Counts the number of DRS packets that we att=
empted to do direct2core on.  There are 4 mutually exclusive filters.  Filt=
er [0] can be used to get successful spawns, while [1:3] provide the differ=
ent failure cases.  Note that this does not count packets that are not cand=
idates for Direct2Core.  The only candidates for Direct2Core are DRS packet=
s destined for Cbos.; The spawn failed because the RBT tag did not match an=
d the valid bit was not set although there were enough Egress credits.",
         "UMask": "0x40",
         "Unit": "QPI LL"
     },
@@ -94,7 +94,7 @@
         "EventCode": "0x13",
         "EventName": "UNC_Q_DIRECT2CORE.SUCCESS_RBT_HIT",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of DRS packets that we att=
empted to do direct2core on.  There are 4 mutually exlusive filters.  Filte=
r [0] can be used to get successful spawns, while [1:3] provide the differe=
nt failure cases.  Note that this does not count packets that are not candi=
dates for Direct2Core.  The only candidates for Direct2Core are DRS packets=
 destined for Cbos.; The spawn was successful.  There were sufficient credi=
ts, the RBT valid bit was set and there was an RBT tag match.  The message =
was marked to spawn direct2core.",
+        "PublicDescription": "Counts the number of DRS packets that we att=
empted to do direct2core on.  There are 4 mutually exclusive filters.  Filt=
er [0] can be used to get successful spawns, while [1:3] provide the differ=
ent failure cases.  Note that this does not count packets that are not cand=
idates for Direct2Core.  The only candidates for Direct2Core are DRS packet=
s destined for Cbos.; The spawn was successful.  There were sufficient cred=
its, the RBT valid bit was set and there was an RBT tag match.  The message=
 was marked to spawn direct2core.",
         "UMask": "0x1",
         "Unit": "QPI LL"
     },
@@ -131,7 +131,7 @@
         "EventCode": "0x9",
         "EventName": "UNC_Q_RxL_BYPASSED",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of times that an incoming =
flit was able to bypass the flit buffer and pass directly across the BGF an=
d into the Egress.  This is a latency optimization, and should generally be=
 the common case.  If this value is less than the number of flits transfere=
d, it implies that there was queueing getting onto the ring, and thus the t=
ransactions saw higher latency.",
+        "PublicDescription": "Counts the number of times that an incoming =
flit was able to bypass the flit buffer and pass directly across the BGF an=
d into the Egress.  This is a latency optimization, and should generally be=
 the common case.  If this value is less than the number of flits transferr=
ed, it implies that there was queueing getting onto the ring, and thus the =
transactions saw higher latency.",
         "Unit": "QPI LL"
     },
     {
@@ -443,7 +443,7 @@
         "EventCode": "0x1",
         "EventName": "UNC_Q_RxL_FLITS_G0.DATA",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  It includes filters for Idle, protocol, and Data Flits.  Each f=
lit is made up of 80 bits of information (in addition to some ECC data).  I=
n full-width (L0) mode, flits are made up of four fits, each of which conta=
ins 20 bits of data (along with some additional ECC data).   In half-width =
(L0p) mode, the fits are only 10 bits, and therefore it takes twice as many=
 fits to transmit a flit.  When one talks about QPI speed (for example, 8.0=
 GT/s), the transfers here refer to fits.  Therefore, in L0, the system wil=
l transfer 1 flit at the rate of 1/4th the QPI speed.  One can calculate th=
e bandwidth of the link by taking: flits*80b/time.  Note that this is not t=
he same as data bandwidth.  For example, when we are transfering a 64B cach=
eline across QPI, we will break it into 9 flits -- 1 with header informatio=
n and 8 with 64 bits of actual data and an additional 16 bits of other info=
rmation.  To calculate data bandwidth, one should therefore do: data flits =
* 8B / time (for L0) or 4B instead of 8B for L0p.; Number of data flitsrece=
ived over QPI.  Each flit contains 64b of data.  This includes both DRS and=
 NCB data flits (coherent and non-coherent).  This can be used to calculate=
 the data bandwidth of the QPI link.  One can get a good picture of the QPI=
-link characteristics by evaluating the protocol flits, data flits, and idl=
e/null flits.  This does not include the header flits that go in data packe=
ts.",
+        "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  It includes filters for Idle, protocol, and Data Flits.  Each f=
lit is made up of 80 bits of information (in addition to some ECC data).  I=
n full-width (L0) mode, flits are made up of four fits, each of which conta=
ins 20 bits of data (along with some additional ECC data).   In half-width =
(L0p) mode, the fits are only 10 bits, and therefore it takes twice as many=
 fits to transmit a flit.  When one talks about QPI speed (for example, 8.0=
 GT/s), the transfers here refer to fits.  Therefore, in L0, the system wil=
l transfer 1 flit at the rate of 1/4th the QPI speed.  One can calculate th=
e bandwidth of the link by taking: flits*80b/time.  Note that this is not t=
he same as data bandwidth.  For example, when we are transferring a 64B cac=
heline across QPI, we will break it into 9 flits -- 1 with header informati=
on and 8 with 64 bits of actual data and an additional 16 bits of other inf=
ormation.  To calculate data bandwidth, one should therefore do: data flits=
 * 8B / time (for L0) or 4B instead of 8B for L0p.; Number of data flits re=
ceived over QPI.  Each flit contains 64b of data.  This includes both DRS a=
nd NCB data flits (coherent and non-coherent).  This can be used to calcula=
te the data bandwidth of the QPI link.  One can get a good picture of the Q=
PI-link characteristics by evaluating the protocol flits, data flits, and i=
dle/null flits.  This does not include the header flits that go in data pac=
kets.",
         "UMask": "0x2",
         "Unit": "QPI LL"
     },
@@ -453,7 +453,7 @@
         "EventCode": "0x1",
         "EventName": "UNC_Q_RxL_FLITS_G0.IDLE",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  It includes filters for Idle, protocol, and Data Flits.  Each f=
lit is made up of 80 bits of information (in addition to some ECC data).  I=
n full-width (L0) mode, flits are made up of four fits, each of which conta=
ins 20 bits of data (along with some additional ECC data).   In half-width =
(L0p) mode, the fits are only 10 bits, and therefore it takes twice as many=
 fits to transmit a flit.  When one talks about QPI speed (for example, 8.0=
 GT/s), the transfers here refer to fits.  Therefore, in L0, the system wil=
l transfer 1 flit at the rate of 1/4th the QPI speed.  One can calculate th=
e bandwidth of the link by taking: flits*80b/time.  Note that this is not t=
he same as data bandwidth.  For example, when we are transfering a 64B cach=
eline across QPI, we will break it into 9 flits -- 1 with header informatio=
n and 8 with 64 bits of actual data and an additional 16 bits of other info=
rmation.  To calculate data bandwidth, one should therefore do: data flits =
* 8B / time (for L0) or 4B instead of 8B for L0p.; Number of flits received=
 over QPI that do not hold protocol payload.  When QPI is not in a power sa=
ving state, it continuously transmits flits across the link.  When there ar=
e no protocol flits to send, it will send IDLE and NULL flits  across.  The=
se flits sometimes do carry a payload, such as credit returns, but are gene=
rall not considered part of the QPI bandwidth.",
+        "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  It includes filters for Idle, protocol, and Data Flits.  Each f=
lit is made up of 80 bits of information (in addition to some ECC data).  I=
n full-width (L0) mode, flits are made up of four fits, each of which conta=
ins 20 bits of data (along with some additional ECC data).   In half-width =
(L0p) mode, the fits are only 10 bits, and therefore it takes twice as many=
 fits to transmit a flit.  When one talks about QPI speed (for example, 8.0=
 GT/s), the transfers here refer to fits.  Therefore, in L0, the system wil=
l transfer 1 flit at the rate of 1/4th the QPI speed.  One can calculate th=
e bandwidth of the link by taking: flits*80b/time.  Note that this is not t=
he same as data bandwidth.  For example, when we are transferring a 64B cac=
heline across QPI, we will break it into 9 flits -- 1 with header informati=
on and 8 with 64 bits of actual data and an additional 16 bits of other inf=
ormation.  To calculate data bandwidth, one should therefore do: data flits=
 * 8B / time (for L0) or 4B instead of 8B for L0p.; Number of flits receive=
d over QPI that do not hold protocol payload.  When QPI is not in a power s=
aving state, it continuously transmits flits across the link.  When there a=
re no protocol flits to send, it will send IDLE and NULL flits  across.  Th=
ese flits sometimes do carry a payload, such as credit returns, but are gen=
erally not considered part of the QPI bandwidth.",
         "UMask": "0x1",
         "Unit": "QPI LL"
     },
@@ -463,7 +463,7 @@
         "EventCode": "0x1",
         "EventName": "UNC_Q_RxL_FLITS_G0.NON_DATA",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  It includes filters for Idle, protocol, and Data Flits.  Each f=
lit is made up of 80 bits of information (in addition to some ECC data).  I=
n full-width (L0) mode, flits are made up of four fits, each of which conta=
ins 20 bits of data (along with some additional ECC data).   In half-width =
(L0p) mode, the fits are only 10 bits, and therefore it takes twice as many=
 fits to transmit a flit.  When one talks about QPI speed (for example, 8.0=
 GT/s), the transfers here refer to fits.  Therefore, in L0, the system wil=
l transfer 1 flit at the rate of 1/4th the QPI speed.  One can calculate th=
e bandwidth of the link by taking: flits*80b/time.  Note that this is not t=
he same as data bandwidth.  For example, when we are transfering a 64B cach=
eline across QPI, we will break it into 9 flits -- 1 with header informatio=
n and 8 with 64 bits of actual data and an additional 16 bits of other info=
rmation.  To calculate data bandwidth, one should therefore do: data flits =
* 8B / time (for L0) or 4B instead of 8B for L0p.; Number of non-NULL non-d=
ata flits received across QPI.  This basically tracks the protocol overhead=
 on the QPI link.  One can get a good picture of the QPI-link characteristi=
cs by evaluating the protocol flits, data flits, and idle/null flits.  This=
 includes the header flits for data packets.",
+        "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  It includes filters for Idle, protocol, and Data Flits.  Each f=
lit is made up of 80 bits of information (in addition to some ECC data).  I=
n full-width (L0) mode, flits are made up of four fits, each of which conta=
ins 20 bits of data (along with some additional ECC data).   In half-width =
(L0p) mode, the fits are only 10 bits, and therefore it takes twice as many=
 fits to transmit a flit.  When one talks about QPI speed (for example, 8.0=
 GT/s), the transfers here refer to fits.  Therefore, in L0, the system wil=
l transfer 1 flit at the rate of 1/4th the QPI speed.  One can calculate th=
e bandwidth of the link by taking: flits*80b/time.  Note that this is not t=
he same as data bandwidth.  For example, when we are transferring a 64B cac=
heline across QPI, we will break it into 9 flits -- 1 with header informati=
on and 8 with 64 bits of actual data and an additional 16 bits of other inf=
ormation.  To calculate data bandwidth, one should therefore do: data flits=
 * 8B / time (for L0) or 4B instead of 8B for L0p.; Number of non-NULL non-=
data flits received across QPI.  This basically tracks the protocol overhea=
d on the QPI link.  One can get a good picture of the QPI-link characterist=
ics by evaluating the protocol flits, data flits, and idle/null flits.  Thi=
s includes the header flits for data packets.",
         "UMask": "0x4",
         "Unit": "QPI LL"
     },
@@ -474,7 +474,7 @@
         "EventName": "UNC_Q_RxL_FLITS_G1.DRS",
         "ExtSel": "1",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three groups that allow us to track flits.  It i=
ncludes filters for SNP, HOM, and DRS message classes.  Each flit is made u=
p of 80 bits of information (in addition to some ECC data).  In full-width =
(L0) mode, flits are made up of four fits, each of which contains 20 bits o=
f data (along with some additional ECC data).   In half-width (L0p) mode, t=
he fits are only 10 bits, and therefore it takes twice as many fits to tran=
smit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), the t=
ransfers here refer to fits.  Therefore, in L0, the system will transfer 1 =
flit at the rate of 1/4th the QPI speed.  One can calculate the bandwidth o=
f the link by taking: flits*80b/time.  Note that this is not the same as da=
ta bandwidth.  For example, when we are transfering a 64B cacheline across =
QPI, we will break it into 9 flits -- 1 with header information and 8 with =
64 bits of actual data and an additional 16 bits of other information.  To =
calculate data bandwidth, one should therefore do: data flits * 8B / time.;=
 Counts the total number of flits received over QPI on the DRS (Data Respon=
se) channel.  DRS flits are used to transmit data with coherency.  This doe=
s not count data flits received over the NCB channel which transmits non-co=
herent data.",
+        "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three groups that allow us to track flits.  It i=
ncludes filters for SNP, HOM, and DRS message classes.  Each flit is made u=
p of 80 bits of information (in addition to some ECC data).  In full-width =
(L0) mode, flits are made up of four fits, each of which contains 20 bits o=
f data (along with some additional ECC data).   In half-width (L0p) mode, t=
he fits are only 10 bits, and therefore it takes twice as many fits to tran=
smit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), the t=
ransfers here refer to fits.  Therefore, in L0, the system will transfer 1 =
flit at the rate of 1/4th the QPI speed.  One can calculate the bandwidth o=
f the link by taking: flits*80b/time.  Note that this is not the same as da=
ta bandwidth.  For example, when we are transferring a 64B cacheline across=
 QPI, we will break it into 9 flits -- 1 with header information and 8 with=
 64 bits of actual data and an additional 16 bits of other information.  To=
 calculate data bandwidth, one should therefore do: data flits * 8B / time.=
; Counts the total number of flits received over QPI on the DRS (Data Respo=
nse) channel.  DRS flits are used to transmit data with coherency.  This do=
es not count data flits received over the NCB channel which transmits non-c=
oherent data.",
         "UMask": "0x18",
         "Unit": "QPI LL"
     },
@@ -485,7 +485,7 @@
         "EventName": "UNC_Q_RxL_FLITS_G1.DRS_DATA",
         "ExtSel": "1",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three groups that allow us to track flits.  It i=
ncludes filters for SNP, HOM, and DRS message classes.  Each flit is made u=
p of 80 bits of information (in addition to some ECC data).  In full-width =
(L0) mode, flits are made up of four fits, each of which contains 20 bits o=
f data (along with some additional ECC data).   In half-width (L0p) mode, t=
he fits are only 10 bits, and therefore it takes twice as many fits to tran=
smit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), the t=
ransfers here refer to fits.  Therefore, in L0, the system will transfer 1 =
flit at the rate of 1/4th the QPI speed.  One can calculate the bandwidth o=
f the link by taking: flits*80b/time.  Note that this is not the same as da=
ta bandwidth.  For example, when we are transfering a 64B cacheline across =
QPI, we will break it into 9 flits -- 1 with header information and 8 with =
64 bits of actual data and an additional 16 bits of other information.  To =
calculate data bandwidth, one should therefore do: data flits * 8B / time.;=
 Counts the total number of data flits received over QPI on the DRS (Data R=
esponse) channel.  DRS flits are used to transmit data with coherency.  Thi=
s does not count data flits received over the NCB channel which transmits n=
on-coherent data.  This includes only the data flits (not the header).",
+        "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three groups that allow us to track flits.  It i=
ncludes filters for SNP, HOM, and DRS message classes.  Each flit is made u=
p of 80 bits of information (in addition to some ECC data).  In full-width =
(L0) mode, flits are made up of four fits, each of which contains 20 bits o=
f data (along with some additional ECC data).   In half-width (L0p) mode, t=
he fits are only 10 bits, and therefore it takes twice as many fits to tran=
smit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), the t=
ransfers here refer to fits.  Therefore, in L0, the system will transfer 1 =
flit at the rate of 1/4th the QPI speed.  One can calculate the bandwidth o=
f the link by taking: flits*80b/time.  Note that this is not the same as da=
ta bandwidth.  For example, when we are transferring a 64B cacheline across=
 QPI, we will break it into 9 flits -- 1 with header information and 8 with=
 64 bits of actual data and an additional 16 bits of other information.  To=
 calculate data bandwidth, one should therefore do: data flits * 8B / time.=
; Counts the total number of data flits received over QPI on the DRS (Data =
Response) channel.  DRS flits are used to transmit data with coherency.  Th=
is does not count data flits received over the NCB channel which transmits =
non-coherent data.  This includes only the data flits (not the header).",
         "UMask": "0x8",
         "Unit": "QPI LL"
     },
@@ -496,7 +496,7 @@
         "EventName": "UNC_Q_RxL_FLITS_G1.DRS_NONDATA",
         "ExtSel": "1",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three groups that allow us to track flits.  It i=
ncludes filters for SNP, HOM, and DRS message classes.  Each flit is made u=
p of 80 bits of information (in addition to some ECC data).  In full-width =
(L0) mode, flits are made up of four fits, each of which contains 20 bits o=
f data (along with some additional ECC data).   In half-width (L0p) mode, t=
he fits are only 10 bits, and therefore it takes twice as many fits to tran=
smit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), the t=
ransfers here refer to fits.  Therefore, in L0, the system will transfer 1 =
flit at the rate of 1/4th the QPI speed.  One can calculate the bandwidth o=
f the link by taking: flits*80b/time.  Note that this is not the same as da=
ta bandwidth.  For example, when we are transfering a 64B cacheline across =
QPI, we will break it into 9 flits -- 1 with header information and 8 with =
64 bits of actual data and an additional 16 bits of other information.  To =
calculate data bandwidth, one should therefore do: data flits * 8B / time.;=
 Counts the total number of protocol flits received over QPI on the DRS (Da=
ta Response) channel.  DRS flits are used to transmit data with coherency. =
 This does not count data flits received over the NCB channel which transmi=
ts non-coherent data.  This includes only the header flits (not the data). =
 This includes extended headers.",
+        "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three groups that allow us to track flits.  It i=
ncludes filters for SNP, HOM, and DRS message classes.  Each flit is made u=
p of 80 bits of information (in addition to some ECC data).  In full-width =
(L0) mode, flits are made up of four fits, each of which contains 20 bits o=
f data (along with some additional ECC data).   In half-width (L0p) mode, t=
he fits are only 10 bits, and therefore it takes twice as many fits to tran=
smit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), the t=
ransfers here refer to fits.  Therefore, in L0, the system will transfer 1 =
flit at the rate of 1/4th the QPI speed.  One can calculate the bandwidth o=
f the link by taking: flits*80b/time.  Note that this is not the same as da=
ta bandwidth.  For example, when we are transferring a 64B cacheline across=
 QPI, we will break it into 9 flits -- 1 with header information and 8 with=
 64 bits of actual data and an additional 16 bits of other information.  To=
 calculate data bandwidth, one should therefore do: data flits * 8B / time.=
; Counts the total number of protocol flits received over QPI on the DRS (D=
ata Response) channel.  DRS flits are used to transmit data with coherency.=
  This does not count data flits received over the NCB channel which transm=
its non-coherent data.  This includes only the header flits (not the data).=
  This includes extended headers.",
         "UMask": "0x10",
         "Unit": "QPI LL"
     },
@@ -507,7 +507,7 @@
         "EventName": "UNC_Q_RxL_FLITS_G1.HOM",
         "ExtSel": "1",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three groups that allow us to track flits.  It i=
ncludes filters for SNP, HOM, and DRS message classes.  Each flit is made u=
p of 80 bits of information (in addition to some ECC data).  In full-width =
(L0) mode, flits are made up of four fits, each of which contains 20 bits o=
f data (along with some additional ECC data).   In half-width (L0p) mode, t=
he fits are only 10 bits, and therefore it takes twice as many fits to tran=
smit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), the t=
ransfers here refer to fits.  Therefore, in L0, the system will transfer 1 =
flit at the rate of 1/4th the QPI speed.  One can calculate the bandwidth o=
f the link by taking: flits*80b/time.  Note that this is not the same as da=
ta bandwidth.  For example, when we are transfering a 64B cacheline across =
QPI, we will break it into 9 flits -- 1 with header information and 8 with =
64 bits of actual data and an additional 16 bits of other information.  To =
calculate data bandwidth, one should therefore do: data flits * 8B / time.;=
 Counts the number of flits received over QPI on the home channel.",
+        "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three groups that allow us to track flits.  It i=
ncludes filters for SNP, HOM, and DRS message classes.  Each flit is made u=
p of 80 bits of information (in addition to some ECC data).  In full-width =
(L0) mode, flits are made up of four fits, each of which contains 20 bits o=
f data (along with some additional ECC data).   In half-width (L0p) mode, t=
he fits are only 10 bits, and therefore it takes twice as many fits to tran=
smit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), the t=
ransfers here refer to fits.  Therefore, in L0, the system will transfer 1 =
flit at the rate of 1/4th the QPI speed.  One can calculate the bandwidth o=
f the link by taking: flits*80b/time.  Note that this is not the same as da=
ta bandwidth.  For example, when we are transferring a 64B cacheline across=
 QPI, we will break it into 9 flits -- 1 with header information and 8 with=
 64 bits of actual data and an additional 16 bits of other information.  To=
 calculate data bandwidth, one should therefore do: data flits * 8B / time.=
; Counts the number of flits received over QPI on the home channel.",
         "UMask": "0x6",
         "Unit": "QPI LL"
     },
@@ -518,7 +518,7 @@
         "EventName": "UNC_Q_RxL_FLITS_G1.HOM_NONREQ",
         "ExtSel": "1",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three groups that allow us to track flits.  It i=
ncludes filters for SNP, HOM, and DRS message classes.  Each flit is made u=
p of 80 bits of information (in addition to some ECC data).  In full-width =
(L0) mode, flits are made up of four fits, each of which contains 20 bits o=
f data (along with some additional ECC data).   In half-width (L0p) mode, t=
he fits are only 10 bits, and therefore it takes twice as many fits to tran=
smit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), the t=
ransfers here refer to fits.  Therefore, in L0, the system will transfer 1 =
flit at the rate of 1/4th the QPI speed.  One can calculate the bandwidth o=
f the link by taking: flits*80b/time.  Note that this is not the same as da=
ta bandwidth.  For example, when we are transfering a 64B cacheline across =
QPI, we will break it into 9 flits -- 1 with header information and 8 with =
64 bits of actual data and an additional 16 bits of other information.  To =
calculate data bandwidth, one should therefore do: data flits * 8B / time.;=
 Counts the number of non-request flits received over QPI on the home chann=
el.  These are most commonly snoop responses, and this event can be used as=
 a proxy for that.",
+        "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three groups that allow us to track flits.  It i=
ncludes filters for SNP, HOM, and DRS message classes.  Each flit is made u=
p of 80 bits of information (in addition to some ECC data).  In full-width =
(L0) mode, flits are made up of four fits, each of which contains 20 bits o=
f data (along with some additional ECC data).   In half-width (L0p) mode, t=
he fits are only 10 bits, and therefore it takes twice as many fits to tran=
smit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), the t=
ransfers here refer to fits.  Therefore, in L0, the system will transfer 1 =
flit at the rate of 1/4th the QPI speed.  One can calculate the bandwidth o=
f the link by taking: flits*80b/time.  Note that this is not the same as da=
ta bandwidth.  For example, when we are transferring a 64B cacheline across=
 QPI, we will break it into 9 flits -- 1 with header information and 8 with=
 64 bits of actual data and an additional 16 bits of other information.  To=
 calculate data bandwidth, one should therefore do: data flits * 8B / time.=
; Counts the number of non-request flits received over QPI on the home chan=
nel.  These are most commonly snoop responses, and this event can be used a=
s a proxy for that.",
         "UMask": "0x4",
         "Unit": "QPI LL"
     },
@@ -529,7 +529,7 @@
         "EventName": "UNC_Q_RxL_FLITS_G1.HOM_REQ",
         "ExtSel": "1",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three groups that allow us to track flits.  It i=
ncludes filters for SNP, HOM, and DRS message classes.  Each flit is made u=
p of 80 bits of information (in addition to some ECC data).  In full-width =
(L0) mode, flits are made up of four fits, each of which contains 20 bits o=
f data (along with some additional ECC data).   In half-width (L0p) mode, t=
he fits are only 10 bits, and therefore it takes twice as many fits to tran=
smit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), the t=
ransfers here refer to fits.  Therefore, in L0, the system will transfer 1 =
flit at the rate of 1/4th the QPI speed.  One can calculate the bandwidth o=
f the link by taking: flits*80b/time.  Note that this is not the same as da=
ta bandwidth.  For example, when we are transfering a 64B cacheline across =
QPI, we will break it into 9 flits -- 1 with header information and 8 with =
64 bits of actual data and an additional 16 bits of other information.  To =
calculate data bandwidth, one should therefore do: data flits * 8B / time.;=
 Counts the number of data request received over QPI on the home channel.  =
This basically counts the number of remote memory requests received over QP=
I.  In conjunction with the local read count in the Home Agent, one can cal=
culate the number of LLC Misses.",
+        "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three groups that allow us to track flits.  It i=
ncludes filters for SNP, HOM, and DRS message classes.  Each flit is made u=
p of 80 bits of information (in addition to some ECC data).  In full-width =
(L0) mode, flits are made up of four fits, each of which contains 20 bits o=
f data (along with some additional ECC data).   In half-width (L0p) mode, t=
he fits are only 10 bits, and therefore it takes twice as many fits to tran=
smit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), the t=
ransfers here refer to fits.  Therefore, in L0, the system will transfer 1 =
flit at the rate of 1/4th the QPI speed.  One can calculate the bandwidth o=
f the link by taking: flits*80b/time.  Note that this is not the same as da=
ta bandwidth.  For example, when we are transferring a 64B cacheline across=
 QPI, we will break it into 9 flits -- 1 with header information and 8 with=
 64 bits of actual data and an additional 16 bits of other information.  To=
 calculate data bandwidth, one should therefore do: data flits * 8B / time.=
; Counts the number of data request received over QPI on the home channel. =
 This basically counts the number of remote memory requests received over Q=
PI.  In conjunction with the local read count in the Home Agent, one can ca=
lculate the number of LLC Misses.",
         "UMask": "0x2",
         "Unit": "QPI LL"
     },
@@ -540,7 +540,7 @@
         "EventName": "UNC_Q_RxL_FLITS_G1.SNP",
         "ExtSel": "1",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three groups that allow us to track flits.  It i=
ncludes filters for SNP, HOM, and DRS message classes.  Each flit is made u=
p of 80 bits of information (in addition to some ECC data).  In full-width =
(L0) mode, flits are made up of four fits, each of which contains 20 bits o=
f data (along with some additional ECC data).   In half-width (L0p) mode, t=
he fits are only 10 bits, and therefore it takes twice as many fits to tran=
smit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), the t=
ransfers here refer to fits.  Therefore, in L0, the system will transfer 1 =
flit at the rate of 1/4th the QPI speed.  One can calculate the bandwidth o=
f the link by taking: flits*80b/time.  Note that this is not the same as da=
ta bandwidth.  For example, when we are transfering a 64B cacheline across =
QPI, we will break it into 9 flits -- 1 with header information and 8 with =
64 bits of actual data and an additional 16 bits of other information.  To =
calculate data bandwidth, one should therefore do: data flits * 8B / time.;=
 Counts the number of snoop request flits received over QPI.  These request=
s are contained in the snoop channel.  This does not include snoop response=
s, which are received on the home channel.",
+        "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three groups that allow us to track flits.  It i=
ncludes filters for SNP, HOM, and DRS message classes.  Each flit is made u=
p of 80 bits of information (in addition to some ECC data).  In full-width =
(L0) mode, flits are made up of four fits, each of which contains 20 bits o=
f data (along with some additional ECC data).   In half-width (L0p) mode, t=
he fits are only 10 bits, and therefore it takes twice as many fits to tran=
smit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), the t=
ransfers here refer to fits.  Therefore, in L0, the system will transfer 1 =
flit at the rate of 1/4th the QPI speed.  One can calculate the bandwidth o=
f the link by taking: flits*80b/time.  Note that this is not the same as da=
ta bandwidth.  For example, when we are transferring a 64B cacheline across=
 QPI, we will break it into 9 flits -- 1 with header information and 8 with=
 64 bits of actual data and an additional 16 bits of other information.  To=
 calculate data bandwidth, one should therefore do: data flits * 8B / time.=
; Counts the number of snoop request flits received over QPI.  These reques=
ts are contained in the snoop channel.  This does not include snoop respons=
es, which are received on the home channel.",
         "UMask": "0x1",
         "Unit": "QPI LL"
     },
@@ -551,7 +551,7 @@
         "EventName": "UNC_Q_RxL_FLITS_G2.NCB",
         "ExtSel": "1",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three groups that allow us to track flits.  It i=
ncludes filters for NDR, NCB, and NCS message classes.  Each flit is made u=
p of 80 bits of information (in addition to some ECC data).  In full-width =
(L0) mode, flits are made up of four fits, each of which contains 20 bits o=
f data (along with some additional ECC data).   In half-width (L0p) mode, t=
he fits are only 10 bits, and therefore it takes twice as many fits to tran=
smit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), the t=
ransfers here refer to fits.  Therefore, in L0, the system will transfer 1 =
flit at the rate of 1/4th the QPI speed.  One can calculate the bandwidth o=
f the link by taking: flits*80b/time.  Note that this is not the same as da=
ta bandwidth.  For example, when we are transfering a 64B cacheline across =
QPI, we will break it into 9 flits -- 1 with header information and 8 with =
64 bits of actual data and an additional 16 bits of other information.  To =
calculate data bandwidth, one should therefore do: data flits * 8B / time.;=
 Number of Non-Coherent Bypass flits.  These packets are generally used to =
transmit non-coherent data across QPI.",
+        "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three groups that allow us to track flits.  It i=
ncludes filters for NDR, NCB, and NCS message classes.  Each flit is made u=
p of 80 bits of information (in addition to some ECC data).  In full-width =
(L0) mode, flits are made up of four fits, each of which contains 20 bits o=
f data (along with some additional ECC data).   In half-width (L0p) mode, t=
he fits are only 10 bits, and therefore it takes twice as many fits to tran=
smit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), the t=
ransfers here refer to fits.  Therefore, in L0, the system will transfer 1 =
flit at the rate of 1/4th the QPI speed.  One can calculate the bandwidth o=
f the link by taking: flits*80b/time.  Note that this is not the same as da=
ta bandwidth.  For example, when we are transferring a 64B cacheline across=
 QPI, we will break it into 9 flits -- 1 with header information and 8 with=
 64 bits of actual data and an additional 16 bits of other information.  To=
 calculate data bandwidth, one should therefore do: data flits * 8B / time.=
; Number of Non-Coherent Bypass flits.  These packets are generally used to=
 transmit non-coherent data across QPI.",
         "UMask": "0xC",
         "Unit": "QPI LL"
     },
@@ -562,7 +562,7 @@
         "EventName": "UNC_Q_RxL_FLITS_G2.NCB_DATA",
         "ExtSel": "1",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three groups that allow us to track flits.  It i=
ncludes filters for NDR, NCB, and NCS message classes.  Each flit is made u=
p of 80 bits of information (in addition to some ECC data).  In full-width =
(L0) mode, flits are made up of four fits, each of which contains 20 bits o=
f data (along with some additional ECC data).   In half-width (L0p) mode, t=
he fits are only 10 bits, and therefore it takes twice as many fits to tran=
smit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), the t=
ransfers here refer to fits.  Therefore, in L0, the system will transfer 1 =
flit at the rate of 1/4th the QPI speed.  One can calculate the bandwidth o=
f the link by taking: flits*80b/time.  Note that this is not the same as da=
ta bandwidth.  For example, when we are transfering a 64B cacheline across =
QPI, we will break it into 9 flits -- 1 with header information and 8 with =
64 bits of actual data and an additional 16 bits of other information.  To =
calculate data bandwidth, one should therefore do: data flits * 8B / time.;=
 Number of Non-Coherent Bypass data flits.  These flits are generally used =
to transmit non-coherent data across QPI.  This does not include a count of=
 the DRS (coherent) data flits.  This only counts the data flits, not the N=
CB headers.",
+        "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three groups that allow us to track flits.  It i=
ncludes filters for NDR, NCB, and NCS message classes.  Each flit is made u=
p of 80 bits of information (in addition to some ECC data).  In full-width =
(L0) mode, flits are made up of four fits, each of which contains 20 bits o=
f data (along with some additional ECC data).   In half-width (L0p) mode, t=
he fits are only 10 bits, and therefore it takes twice as many fits to tran=
smit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), the t=
ransfers here refer to fits.  Therefore, in L0, the system will transfer 1 =
flit at the rate of 1/4th the QPI speed.  One can calculate the bandwidth o=
f the link by taking: flits*80b/time.  Note that this is not the same as da=
ta bandwidth.  For example, when we are transferring a 64B cacheline across=
 QPI, we will break it into 9 flits -- 1 with header information and 8 with=
 64 bits of actual data and an additional 16 bits of other information.  To=
 calculate data bandwidth, one should therefore do: data flits * 8B / time.=
; Number of Non-Coherent Bypass data flits.  These flits are generally used=
 to transmit non-coherent data across QPI.  This does not include a count o=
f the DRS (coherent) data flits.  This only counts the data flits, not the =
NCB headers.",
         "UMask": "0x4",
         "Unit": "QPI LL"
     },
@@ -573,7 +573,7 @@
         "EventName": "UNC_Q_RxL_FLITS_G2.NCB_NONDATA",
         "ExtSel": "1",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three groups that allow us to track flits.  It i=
ncludes filters for NDR, NCB, and NCS message classes.  Each flit is made u=
p of 80 bits of information (in addition to some ECC data).  In full-width =
(L0) mode, flits are made up of four fits, each of which contains 20 bits o=
f data (along with some additional ECC data).   In half-width (L0p) mode, t=
he fits are only 10 bits, and therefore it takes twice as many fits to tran=
smit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), the t=
ransfers here refer to fits.  Therefore, in L0, the system will transfer 1 =
flit at the rate of 1/4th the QPI speed.  One can calculate the bandwidth o=
f the link by taking: flits*80b/time.  Note that this is not the same as da=
ta bandwidth.  For example, when we are transfering a 64B cacheline across =
QPI, we will break it into 9 flits -- 1 with header information and 8 with =
64 bits of actual data and an additional 16 bits of other information.  To =
calculate data bandwidth, one should therefore do: data flits * 8B / time.;=
 Number of Non-Coherent Bypass non-data flits.  These packets are generally=
 used to transmit non-coherent data across QPI, and the flits counted here =
are for headers and other non-data flits.  This includes extended headers."=
,
+        "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three groups that allow us to track flits.  It i=
ncludes filters for NDR, NCB, and NCS message classes.  Each flit is made u=
p of 80 bits of information (in addition to some ECC data).  In full-width =
(L0) mode, flits are made up of four fits, each of which contains 20 bits o=
f data (along with some additional ECC data).   In half-width (L0p) mode, t=
he fits are only 10 bits, and therefore it takes twice as many fits to tran=
smit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), the t=
ransfers here refer to fits.  Therefore, in L0, the system will transfer 1 =
flit at the rate of 1/4th the QPI speed.  One can calculate the bandwidth o=
f the link by taking: flits*80b/time.  Note that this is not the same as da=
ta bandwidth.  For example, when we are transferring a 64B cacheline across=
 QPI, we will break it into 9 flits -- 1 with header information and 8 with=
 64 bits of actual data and an additional 16 bits of other information.  To=
 calculate data bandwidth, one should therefore do: data flits * 8B / time.=
; Number of Non-Coherent Bypass non-data flits.  These packets are generall=
y used to transmit non-coherent data across QPI, and the flits counted here=
 are for headers and other non-data flits.  This includes extended headers.=
",
         "UMask": "0x8",
         "Unit": "QPI LL"
     },
@@ -584,7 +584,7 @@
         "EventName": "UNC_Q_RxL_FLITS_G2.NCS",
         "ExtSel": "1",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three groups that allow us to track flits.  It i=
ncludes filters for NDR, NCB, and NCS message classes.  Each flit is made u=
p of 80 bits of information (in addition to some ECC data).  In full-width =
(L0) mode, flits are made up of four fits, each of which contains 20 bits o=
f data (along with some additional ECC data).   In half-width (L0p) mode, t=
he fits are only 10 bits, and therefore it takes twice as many fits to tran=
smit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), the t=
ransfers here refer to fits.  Therefore, in L0, the system will transfer 1 =
flit at the rate of 1/4th the QPI speed.  One can calculate the bandwidth o=
f the link by taking: flits*80b/time.  Note that this is not the same as da=
ta bandwidth.  For example, when we are transfering a 64B cacheline across =
QPI, we will break it into 9 flits -- 1 with header information and 8 with =
64 bits of actual data and an additional 16 bits of other information.  To =
calculate data bandwidth, one should therefore do: data flits * 8B / time.;=
 Number of NCS (non-coherent standard) flits received over QPI.    This inc=
ludes extended headers.",
+        "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three groups that allow us to track flits.  It i=
ncludes filters for NDR, NCB, and NCS message classes.  Each flit is made u=
p of 80 bits of information (in addition to some ECC data).  In full-width =
(L0) mode, flits are made up of four fits, each of which contains 20 bits o=
f data (along with some additional ECC data).   In half-width (L0p) mode, t=
he fits are only 10 bits, and therefore it takes twice as many fits to tran=
smit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), the t=
ransfers here refer to fits.  Therefore, in L0, the system will transfer 1 =
flit at the rate of 1/4th the QPI speed.  One can calculate the bandwidth o=
f the link by taking: flits*80b/time.  Note that this is not the same as da=
ta bandwidth.  For example, when we are transferring a 64B cacheline across=
 QPI, we will break it into 9 flits -- 1 with header information and 8 with=
 64 bits of actual data and an additional 16 bits of other information.  To=
 calculate data bandwidth, one should therefore do: data flits * 8B / time.=
; Number of NCS (non-coherent standard) flits received over QPI.    This in=
cludes extended headers.",
         "UMask": "0x10",
         "Unit": "QPI LL"
     },
@@ -595,7 +595,7 @@
         "EventName": "UNC_Q_RxL_FLITS_G2.NDR_AD",
         "ExtSel": "1",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three groups that allow us to track flits.  It i=
ncludes filters for NDR, NCB, and NCS message classes.  Each flit is made u=
p of 80 bits of information (in addition to some ECC data).  In full-width =
(L0) mode, flits are made up of four fits, each of which contains 20 bits o=
f data (along with some additional ECC data).   In half-width (L0p) mode, t=
he fits are only 10 bits, and therefore it takes twice as many fits to tran=
smit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), the t=
ransfers here refer to fits.  Therefore, in L0, the system will transfer 1 =
flit at the rate of 1/4th the QPI speed.  One can calculate the bandwidth o=
f the link by taking: flits*80b/time.  Note that this is not the same as da=
ta bandwidth.  For example, when we are transfering a 64B cacheline across =
QPI, we will break it into 9 flits -- 1 with header information and 8 with =
64 bits of actual data and an additional 16 bits of other information.  To =
calculate data bandwidth, one should therefore do: data flits * 8B / time.;=
 Counts the total number of flits received over the NDR (Non-Data Response)=
 channel.  This channel is used to send a variety of protocol flits includi=
ng grants and completions.  This is only for NDR packets to the local socke=
t which use the AK ring.",
+        "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three groups that allow us to track flits.  It i=
ncludes filters for NDR, NCB, and NCS message classes.  Each flit is made u=
p of 80 bits of information (in addition to some ECC data).  In full-width =
(L0) mode, flits are made up of four fits, each of which contains 20 bits o=
f data (along with some additional ECC data).   In half-width (L0p) mode, t=
he fits are only 10 bits, and therefore it takes twice as many fits to tran=
smit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), the t=
ransfers here refer to fits.  Therefore, in L0, the system will transfer 1 =
flit at the rate of 1/4th the QPI speed.  One can calculate the bandwidth o=
f the link by taking: flits*80b/time.  Note that this is not the same as da=
ta bandwidth.  For example, when we are transferring a 64B cacheline across=
 QPI, we will break it into 9 flits -- 1 with header information and 8 with=
 64 bits of actual data and an additional 16 bits of other information.  To=
 calculate data bandwidth, one should therefore do: data flits * 8B / time.=
; Counts the total number of flits received over the NDR (Non-Data Response=
) channel.  This channel is used to send a variety of protocol flits includ=
ing grants and completions.  This is only for NDR packets to the local sock=
et which use the AK ring.",
         "UMask": "0x1",
         "Unit": "QPI LL"
     },
@@ -606,7 +606,7 @@
         "EventName": "UNC_Q_RxL_FLITS_G2.NDR_AK",
         "ExtSel": "1",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three groups that allow us to track flits.  It i=
ncludes filters for NDR, NCB, and NCS message classes.  Each flit is made u=
p of 80 bits of information (in addition to some ECC data).  In full-width =
(L0) mode, flits are made up of four fits, each of which contains 20 bits o=
f data (along with some additional ECC data).   In half-width (L0p) mode, t=
he fits are only 10 bits, and therefore it takes twice as many fits to tran=
smit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), the t=
ransfers here refer to fits.  Therefore, in L0, the system will transfer 1 =
flit at the rate of 1/4th the QPI speed.  One can calculate the bandwidth o=
f the link by taking: flits*80b/time.  Note that this is not the same as da=
ta bandwidth.  For example, when we are transfering a 64B cacheline across =
QPI, we will break it into 9 flits -- 1 with header information and 8 with =
64 bits of actual data and an additional 16 bits of other information.  To =
calculate data bandwidth, one should therefore do: data flits * 8B / time.;=
 Counts the total number of flits received over the NDR (Non-Data Response)=
 channel.  This channel is used to send a variety of protocol flits includi=
ng grants and completions.  This is only for NDR packets destined for Route=
-thru to a remote socket.",
+        "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three groups that allow us to track flits.  It i=
ncludes filters for NDR, NCB, and NCS message classes.  Each flit is made u=
p of 80 bits of information (in addition to some ECC data).  In full-width =
(L0) mode, flits are made up of four fits, each of which contains 20 bits o=
f data (along with some additional ECC data).   In half-width (L0p) mode, t=
he fits are only 10 bits, and therefore it takes twice as many fits to tran=
smit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), the t=
ransfers here refer to fits.  Therefore, in L0, the system will transfer 1 =
flit at the rate of 1/4th the QPI speed.  One can calculate the bandwidth o=
f the link by taking: flits*80b/time.  Note that this is not the same as da=
ta bandwidth.  For example, when we are transferring a 64B cacheline across=
 QPI, we will break it into 9 flits -- 1 with header information and 8 with=
 64 bits of actual data and an additional 16 bits of other information.  To=
 calculate data bandwidth, one should therefore do: data flits * 8B / time.=
; Counts the total number of flits received over the NDR (Non-Data Response=
) channel.  This channel is used to send a variety of protocol flits includ=
ing grants and completions.  This is only for NDR packets destined for Rout=
e-thru to a remote socket.",
         "UMask": "0x2",
         "Unit": "QPI LL"
     },
@@ -1227,7 +1227,7 @@
         "Counter": "0,1,2,3",
         "EventName": "UNC_Q_TxL_FLITS_G0.DATA",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of flits transmitted acros=
s the QPI Link.  It includes filters for Idle, protocol, and Data Flits.  E=
ach flit is made up of 80 bits of information (in addition to some ECC data=
).  In full-width (L0) mode, flits are made up of four fits, each of which =
contains 20 bits of data (along with some additional ECC data).   In half-w=
idth (L0p) mode, the fits are only 10 bits, and therefore it takes twice as=
 many fits to transmit a flit.  When one talks about QPI speed (for example=
, 8.0 GT/s), the transfers here refer to fits.  Therefore, in L0, the syste=
m will transfer 1 flit at the rate of 1/4th the QPI speed.  One can calcula=
te the bandwidth of the link by taking: flits*80b/time.  Note that this is =
not the same as data bandwidth.  For example, when we are transfering a 64B=
 cacheline across QPI, we will break it into 9 flits -- 1 with header infor=
mation and 8 with 64 bits of actual data and an additional 16 bits of other=
 information.  To calculate data bandwidth, one should therefore do: data f=
lits * 8B / time (for L0) or 4B instead of 8B for L0p.; Number of data flit=
s transmitted over QPI.  Each flit contains 64b of data.  This includes bot=
h DRS and NCB data flits (coherent and non-coherent).  This can be used to =
calculate the data bandwidth of the QPI link.  One can get a good picture o=
f the QPI-link characteristics by evaluating the protocol flits, data flits=
, and idle/null flits.  This does not include the header flits that go in d=
ata packets.",
+        "PublicDescription": "Counts the number of flits transmitted acros=
s the QPI Link.  It includes filters for Idle, protocol, and Data Flits.  E=
ach flit is made up of 80 bits of information (in addition to some ECC data=
).  In full-width (L0) mode, flits are made up of four fits, each of which =
contains 20 bits of data (along with some additional ECC data).   In half-w=
idth (L0p) mode, the fits are only 10 bits, and therefore it takes twice as=
 many fits to transmit a flit.  When one talks about QPI speed (for example=
, 8.0 GT/s), the transfers here refer to fits.  Therefore, in L0, the syste=
m will transfer 1 flit at the rate of 1/4th the QPI speed.  One can calcula=
te the bandwidth of the link by taking: flits*80b/time.  Note that this is =
not the same as data bandwidth.  For example, when we are transferring a 64=
B cacheline across QPI, we will break it into 9 flits -- 1 with header info=
rmation and 8 with 64 bits of actual data and an additional 16 bits of othe=
r information.  To calculate data bandwidth, one should therefore do: data =
flits * 8B / time (for L0) or 4B instead of 8B for L0p.; Number of data fli=
ts transmitted over QPI.  Each flit contains 64b of data.  This includes bo=
th DRS and NCB data flits (coherent and non-coherent).  This can be used to=
 calculate the data bandwidth of the QPI link.  One can get a good picture =
of the QPI-link characteristics by evaluating the protocol flits, data flit=
s, and idle/null flits.  This does not include the header flits that go in =
data packets.",
         "UMask": "0x2",
         "Unit": "QPI LL"
     },
@@ -1236,7 +1236,7 @@
         "Counter": "0,1,2,3",
         "EventName": "UNC_Q_TxL_FLITS_G0.NON_DATA",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of flits transmitted acros=
s the QPI Link.  It includes filters for Idle, protocol, and Data Flits.  E=
ach flit is made up of 80 bits of information (in addition to some ECC data=
).  In full-width (L0) mode, flits are made up of four fits, each of which =
contains 20 bits of data (along with some additional ECC data).   In half-w=
idth (L0p) mode, the fits are only 10 bits, and therefore it takes twice as=
 many fits to transmit a flit.  When one talks about QPI speed (for example=
, 8.0 GT/s), the transfers here refer to fits.  Therefore, in L0, the syste=
m will transfer 1 flit at the rate of 1/4th the QPI speed.  One can calcula=
te the bandwidth of the link by taking: flits*80b/time.  Note that this is =
not the same as data bandwidth.  For example, when we are transfering a 64B=
 cacheline across QPI, we will break it into 9 flits -- 1 with header infor=
mation and 8 with 64 bits of actual data and an additional 16 bits of other=
 information.  To calculate data bandwidth, one should therefore do: data f=
lits * 8B / time (for L0) or 4B instead of 8B for L0p.; Number of non-NULL =
non-data flits transmitted across QPI.  This basically tracks the protocol =
overhead on the QPI link.  One can get a good picture of the QPI-link chara=
cteristics by evaluating the protocol flits, data flits, and idle/null flit=
s.  This includes the header flits for data packets.",
+        "PublicDescription": "Counts the number of flits transmitted acros=
s the QPI Link.  It includes filters for Idle, protocol, and Data Flits.  E=
ach flit is made up of 80 bits of information (in addition to some ECC data=
).  In full-width (L0) mode, flits are made up of four fits, each of which =
contains 20 bits of data (along with some additional ECC data).   In half-w=
idth (L0p) mode, the fits are only 10 bits, and therefore it takes twice as=
 many fits to transmit a flit.  When one talks about QPI speed (for example=
, 8.0 GT/s), the transfers here refer to fits.  Therefore, in L0, the syste=
m will transfer 1 flit at the rate of 1/4th the QPI speed.  One can calcula=
te the bandwidth of the link by taking: flits*80b/time.  Note that this is =
not the same as data bandwidth.  For example, when we are transferring a 64=
B cacheline across QPI, we will break it into 9 flits -- 1 with header info=
rmation and 8 with 64 bits of actual data and an additional 16 bits of othe=
r information.  To calculate data bandwidth, one should therefore do: data =
flits * 8B / time (for L0) or 4B instead of 8B for L0p.; Number of non-NULL=
 non-data flits transmitted across QPI.  This basically tracks the protocol=
 overhead on the QPI link.  One can get a good picture of the QPI-link char=
acteristics by evaluating the protocol flits, data flits, and idle/null fli=
ts.  This includes the header flits for data packets.",
         "UMask": "0x4",
         "Unit": "QPI LL"
     },
@@ -1246,7 +1246,7 @@
         "EventName": "UNC_Q_TxL_FLITS_G1.DRS",
         "ExtSel": "1",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of flits trasmitted across=
 the QPI Link.  This is one of three groups that allow us to track flits.  =
It includes filters for SNP, HOM, and DRS message classes.  Each flit is ma=
de up of 80 bits of information (in addition to some ECC data).  In full-wi=
dth (L0) mode, flits are made up of four fits, each of which contains 20 bi=
ts of data (along with some additional ECC data).   In half-width (L0p) mod=
e, the fits are only 10 bits, and therefore it takes twice as many fits to =
transmit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), t=
he transfers here refer to fits.  Therefore, in L0, the system will transfe=
r 1 flit at the rate of 1/4th the QPI speed.  One can calculate the bandwid=
th of the link by taking: flits*80b/time.  Note that this is not the same a=
s data bandwidth.  For example, when we are transfering a 64B cacheline acr=
oss QPI, we will break it into 9 flits -- 1 with header information and 8 w=
ith 64 bits of actual data and an additional 16 bits of other information. =
 To calculate data bandwidth, one should therefore do: data flits * 8B / ti=
me.; Counts the total number of flits transmitted over QPI on the DRS (Data=
 Response) channel.  DRS flits are used to transmit data with coherency.",
+        "PublicDescription": "Counts the number of flits transmitted acros=
s the QPI Link.  This is one of three groups that allow us to track flits. =
 It includes filters for SNP, HOM, and DRS message classes.  Each flit is m=
ade up of 80 bits of information (in addition to some ECC data).  In full-w=
idth (L0) mode, flits are made up of four fits, each of which contains 20 b=
its of data (along with some additional ECC data).   In half-width (L0p) mo=
de, the fits are only 10 bits, and therefore it takes twice as many fits to=
 transmit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), =
the transfers here refer to fits.  Therefore, in L0, the system will transf=
er 1 flit at the rate of 1/4th the QPI speed.  One can calculate the bandwi=
dth of the link by taking: flits*80b/time.  Note that this is not the same =
as data bandwidth.  For example, when we are transferring a 64B cacheline a=
cross QPI, we will break it into 9 flits -- 1 with header information and 8=
 with 64 bits of actual data and an additional 16 bits of other information=
.  To calculate data bandwidth, one should therefore do: data flits * 8B / =
time.; Counts the total number of flits transmitted over QPI on the DRS (Da=
ta Response) channel.  DRS flits are used to transmit data with coherency."=
,
         "UMask": "0x18",
         "Unit": "QPI LL"
     },
@@ -1256,7 +1256,7 @@
         "EventName": "UNC_Q_TxL_FLITS_G1.DRS_DATA",
         "ExtSel": "1",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of flits trasmitted across=
 the QPI Link.  This is one of three groups that allow us to track flits.  =
It includes filters for SNP, HOM, and DRS message classes.  Each flit is ma=
de up of 80 bits of information (in addition to some ECC data).  In full-wi=
dth (L0) mode, flits are made up of four fits, each of which contains 20 bi=
ts of data (along with some additional ECC data).   In half-width (L0p) mod=
e, the fits are only 10 bits, and therefore it takes twice as many fits to =
transmit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), t=
he transfers here refer to fits.  Therefore, in L0, the system will transfe=
r 1 flit at the rate of 1/4th the QPI speed.  One can calculate the bandwid=
th of the link by taking: flits*80b/time.  Note that this is not the same a=
s data bandwidth.  For example, when we are transfering a 64B cacheline acr=
oss QPI, we will break it into 9 flits -- 1 with header information and 8 w=
ith 64 bits of actual data and an additional 16 bits of other information. =
 To calculate data bandwidth, one should therefore do: data flits * 8B / ti=
me.; Counts the total number of data flits transmitted over QPI on the DRS =
(Data Response) channel.  DRS flits are used to transmit data with coherenc=
y.  This does not count data flits transmitted over the NCB channel which t=
ransmits non-coherent data.  This includes only the data flits (not the hea=
der).",
+        "PublicDescription": "Counts the number of flits transmitted acros=
s the QPI Link.  This is one of three groups that allow us to track flits. =
 It includes filters for SNP, HOM, and DRS message classes.  Each flit is m=
ade up of 80 bits of information (in addition to some ECC data).  In full-w=
idth (L0) mode, flits are made up of four fits, each of which contains 20 b=
its of data (along with some additional ECC data).   In half-width (L0p) mo=
de, the fits are only 10 bits, and therefore it takes twice as many fits to=
 transmit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), =
the transfers here refer to fits.  Therefore, in L0, the system will transf=
er 1 flit at the rate of 1/4th the QPI speed.  One can calculate the bandwi=
dth of the link by taking: flits*80b/time.  Note that this is not the same =
as data bandwidth.  For example, when we are transferring a 64B cacheline a=
cross QPI, we will break it into 9 flits -- 1 with header information and 8=
 with 64 bits of actual data and an additional 16 bits of other information=
.  To calculate data bandwidth, one should therefore do: data flits * 8B / =
time.; Counts the total number of data flits transmitted over QPI on the DR=
S (Data Response) channel.  DRS flits are used to transmit data with cohere=
ncy.  This does not count data flits transmitted over the NCB channel which=
 transmits non-coherent data.  This includes only the data flits (not the h=
eader).",
         "UMask": "0x8",
         "Unit": "QPI LL"
     },
@@ -1266,7 +1266,7 @@
         "EventName": "UNC_Q_TxL_FLITS_G1.DRS_NONDATA",
         "ExtSel": "1",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of flits trasmitted across=
 the QPI Link.  This is one of three groups that allow us to track flits.  =
It includes filters for SNP, HOM, and DRS message classes.  Each flit is ma=
de up of 80 bits of information (in addition to some ECC data).  In full-wi=
dth (L0) mode, flits are made up of four fits, each of which contains 20 bi=
ts of data (along with some additional ECC data).   In half-width (L0p) mod=
e, the fits are only 10 bits, and therefore it takes twice as many fits to =
transmit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), t=
he transfers here refer to fits.  Therefore, in L0, the system will transfe=
r 1 flit at the rate of 1/4th the QPI speed.  One can calculate the bandwid=
th of the link by taking: flits*80b/time.  Note that this is not the same a=
s data bandwidth.  For example, when we are transfering a 64B cacheline acr=
oss QPI, we will break it into 9 flits -- 1 with header information and 8 w=
ith 64 bits of actual data and an additional 16 bits of other information. =
 To calculate data bandwidth, one should therefore do: data flits * 8B / ti=
me.; Counts the total number of protocol flits transmitted over QPI on the =
DRS (Data Response) channel.  DRS flits are used to transmit data with cohe=
rency.  This does not count data flits transmitted over the NCB channel whi=
ch transmits non-coherent data.  This includes only the header flits (not t=
he data).  This includes extended headers.",
+        "PublicDescription": "Counts the number of flits transmitted acros=
s the QPI Link.  This is one of three groups that allow us to track flits. =
 It includes filters for SNP, HOM, and DRS message classes.  Each flit is m=
ade up of 80 bits of information (in addition to some ECC data).  In full-w=
idth (L0) mode, flits are made up of four fits, each of which contains 20 b=
its of data (along with some additional ECC data).   In half-width (L0p) mo=
de, the fits are only 10 bits, and therefore it takes twice as many fits to=
 transmit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), =
the transfers here refer to fits.  Therefore, in L0, the system will transf=
er 1 flit at the rate of 1/4th the QPI speed.  One can calculate the bandwi=
dth of the link by taking: flits*80b/time.  Note that this is not the same =
as data bandwidth.  For example, when we are transferring a 64B cacheline a=
cross QPI, we will break it into 9 flits -- 1 with header information and 8=
 with 64 bits of actual data and an additional 16 bits of other information=
.  To calculate data bandwidth, one should therefore do: data flits * 8B / =
time.; Counts the total number of protocol flits transmitted over QPI on th=
e DRS (Data Response) channel.  DRS flits are used to transmit data with co=
herency.  This does not count data flits transmitted over the NCB channel w=
hich transmits non-coherent data.  This includes only the header flits (not=
 the data).  This includes extended headers.",
         "UMask": "0x10",
         "Unit": "QPI LL"
     },
@@ -1276,7 +1276,7 @@
         "EventName": "UNC_Q_TxL_FLITS_G1.HOM",
         "ExtSel": "1",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of flits trasmitted across=
 the QPI Link.  This is one of three groups that allow us to track flits.  =
It includes filters for SNP, HOM, and DRS message classes.  Each flit is ma=
de up of 80 bits of information (in addition to some ECC data).  In full-wi=
dth (L0) mode, flits are made up of four fits, each of which contains 20 bi=
ts of data (along with some additional ECC data).   In half-width (L0p) mod=
e, the fits are only 10 bits, and therefore it takes twice as many fits to =
transmit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), t=
he transfers here refer to fits.  Therefore, in L0, the system will transfe=
r 1 flit at the rate of 1/4th the QPI speed.  One can calculate the bandwid=
th of the link by taking: flits*80b/time.  Note that this is not the same a=
s data bandwidth.  For example, when we are transfering a 64B cacheline acr=
oss QPI, we will break it into 9 flits -- 1 with header information and 8 w=
ith 64 bits of actual data and an additional 16 bits of other information. =
 To calculate data bandwidth, one should therefore do: data flits * 8B / ti=
me.; Counts the number of flits transmitted over QPI on the home channel.",
+        "PublicDescription": "Counts the number of flits transmitted acros=
s the QPI Link.  This is one of three groups that allow us to track flits. =
 It includes filters for SNP, HOM, and DRS message classes.  Each flit is m=
ade up of 80 bits of information (in addition to some ECC data).  In full-w=
idth (L0) mode, flits are made up of four fits, each of which contains 20 b=
its of data (along with some additional ECC data).   In half-width (L0p) mo=
de, the fits are only 10 bits, and therefore it takes twice as many fits to=
 transmit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), =
the transfers here refer to fits.  Therefore, in L0, the system will transf=
er 1 flit at the rate of 1/4th the QPI speed.  One can calculate the bandwi=
dth of the link by taking: flits*80b/time.  Note that this is not the same =
as data bandwidth.  For example, when we are transferring a 64B cacheline a=
cross QPI, we will break it into 9 flits -- 1 with header information and 8=
 with 64 bits of actual data and an additional 16 bits of other information=
.  To calculate data bandwidth, one should therefore do: data flits * 8B / =
time.; Counts the number of flits transmitted over QPI on the home channel.=
",
         "UMask": "0x6",
         "Unit": "QPI LL"
     },
@@ -1286,7 +1286,7 @@
         "EventName": "UNC_Q_TxL_FLITS_G1.HOM_NONREQ",
         "ExtSel": "1",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of flits trasmitted across=
 the QPI Link.  This is one of three groups that allow us to track flits.  =
It includes filters for SNP, HOM, and DRS message classes.  Each flit is ma=
de up of 80 bits of information (in addition to some ECC data).  In full-wi=
dth (L0) mode, flits are made up of four fits, each of which contains 20 bi=
ts of data (along with some additional ECC data).   In half-width (L0p) mod=
e, the fits are only 10 bits, and therefore it takes twice as many fits to =
transmit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), t=
he transfers here refer to fits.  Therefore, in L0, the system will transfe=
r 1 flit at the rate of 1/4th the QPI speed.  One can calculate the bandwid=
th of the link by taking: flits*80b/time.  Note that this is not the same a=
s data bandwidth.  For example, when we are transfering a 64B cacheline acr=
oss QPI, we will break it into 9 flits -- 1 with header information and 8 w=
ith 64 bits of actual data and an additional 16 bits of other information. =
 To calculate data bandwidth, one should therefore do: data flits * 8B / ti=
me.; Counts the number of non-request flits transmitted over QPI on the hom=
e channel.  These are most commonly snoop responses, and this event can be =
used as a proxy for that.",
+        "PublicDescription": "Counts the number of flits transmitted acros=
s the QPI Link.  This is one of three groups that allow us to track flits. =
 It includes filters for SNP, HOM, and DRS message classes.  Each flit is m=
ade up of 80 bits of information (in addition to some ECC data).  In full-w=
idth (L0) mode, flits are made up of four fits, each of which contains 20 b=
its of data (along with some additional ECC data).   In half-width (L0p) mo=
de, the fits are only 10 bits, and therefore it takes twice as many fits to=
 transmit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), =
the transfers here refer to fits.  Therefore, in L0, the system will transf=
er 1 flit at the rate of 1/4th the QPI speed.  One can calculate the bandwi=
dth of the link by taking: flits*80b/time.  Note that this is not the same =
as data bandwidth.  For example, when we are transferring a 64B cacheline a=
cross QPI, we will break it into 9 flits -- 1 with header information and 8=
 with 64 bits of actual data and an additional 16 bits of other information=
.  To calculate data bandwidth, one should therefore do: data flits * 8B / =
time.; Counts the number of non-request flits transmitted over QPI on the h=
ome channel.  These are most commonly snoop responses, and this event can b=
e used as a proxy for that.",
         "UMask": "0x4",
         "Unit": "QPI LL"
     },
@@ -1296,7 +1296,7 @@
         "EventName": "UNC_Q_TxL_FLITS_G1.HOM_REQ",
         "ExtSel": "1",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of flits trasmitted across=
 the QPI Link.  This is one of three groups that allow us to track flits.  =
It includes filters for SNP, HOM, and DRS message classes.  Each flit is ma=
de up of 80 bits of information (in addition to some ECC data).  In full-wi=
dth (L0) mode, flits are made up of four fits, each of which contains 20 bi=
ts of data (along with some additional ECC data).   In half-width (L0p) mod=
e, the fits are only 10 bits, and therefore it takes twice as many fits to =
transmit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), t=
he transfers here refer to fits.  Therefore, in L0, the system will transfe=
r 1 flit at the rate of 1/4th the QPI speed.  One can calculate the bandwid=
th of the link by taking: flits*80b/time.  Note that this is not the same a=
s data bandwidth.  For example, when we are transfering a 64B cacheline acr=
oss QPI, we will break it into 9 flits -- 1 with header information and 8 w=
ith 64 bits of actual data and an additional 16 bits of other information. =
 To calculate data bandwidth, one should therefore do: data flits * 8B / ti=
me.; Counts the number of data request transmitted over QPI on the home cha=
nnel.  This basically counts the number of remote memory requests transmitt=
ed over QPI.  In conjunction with the local read count in the Home Agent, o=
ne can calculate the number of LLC Misses.",
+        "PublicDescription": "Counts the number of flits transmitted acros=
s the QPI Link.  This is one of three groups that allow us to track flits. =
 It includes filters for SNP, HOM, and DRS message classes.  Each flit is m=
ade up of 80 bits of information (in addition to some ECC data).  In full-w=
idth (L0) mode, flits are made up of four fits, each of which contains 20 b=
its of data (along with some additional ECC data).   In half-width (L0p) mo=
de, the fits are only 10 bits, and therefore it takes twice as many fits to=
 transmit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), =
the transfers here refer to fits.  Therefore, in L0, the system will transf=
er 1 flit at the rate of 1/4th the QPI speed.  One can calculate the bandwi=
dth of the link by taking: flits*80b/time.  Note that this is not the same =
as data bandwidth.  For example, when we are transferring a 64B cacheline a=
cross QPI, we will break it into 9 flits -- 1 with header information and 8=
 with 64 bits of actual data and an additional 16 bits of other information=
.  To calculate data bandwidth, one should therefore do: data flits * 8B / =
time.; Counts the number of data request transmitted over QPI on the home c=
hannel.  This basically counts the number of remote memory requests transmi=
tted over QPI.  In conjunction with the local read count in the Home Agent,=
 one can calculate the number of LLC Misses.",
         "UMask": "0x2",
         "Unit": "QPI LL"
     },
@@ -1306,7 +1306,7 @@
         "EventName": "UNC_Q_TxL_FLITS_G1.SNP",
         "ExtSel": "1",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of flits trasmitted across=
 the QPI Link.  This is one of three groups that allow us to track flits.  =
It includes filters for SNP, HOM, and DRS message classes.  Each flit is ma=
de up of 80 bits of information (in addition to some ECC data).  In full-wi=
dth (L0) mode, flits are made up of four fits, each of which contains 20 bi=
ts of data (along with some additional ECC data).   In half-width (L0p) mod=
e, the fits are only 10 bits, and therefore it takes twice as many fits to =
transmit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), t=
he transfers here refer to fits.  Therefore, in L0, the system will transfe=
r 1 flit at the rate of 1/4th the QPI speed.  One can calculate the bandwid=
th of the link by taking: flits*80b/time.  Note that this is not the same a=
s data bandwidth.  For example, when we are transfering a 64B cacheline acr=
oss QPI, we will break it into 9 flits -- 1 with header information and 8 w=
ith 64 bits of actual data and an additional 16 bits of other information. =
 To calculate data bandwidth, one should therefore do: data flits * 8B / ti=
me.; Counts the number of snoop request flits transmitted over QPI.  These =
requests are contained in the snoop channel.  This does not include snoop r=
esponses, which are transmitted on the home channel.",
+        "PublicDescription": "Counts the number of flits transmitted acros=
s the QPI Link.  This is one of three groups that allow us to track flits. =
 It includes filters for SNP, HOM, and DRS message classes.  Each flit is m=
ade up of 80 bits of information (in addition to some ECC data).  In full-w=
idth (L0) mode, flits are made up of four fits, each of which contains 20 b=
its of data (along with some additional ECC data).   In half-width (L0p) mo=
de, the fits are only 10 bits, and therefore it takes twice as many fits to=
 transmit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), =
the transfers here refer to fits.  Therefore, in L0, the system will transf=
er 1 flit at the rate of 1/4th the QPI speed.  One can calculate the bandwi=
dth of the link by taking: flits*80b/time.  Note that this is not the same =
as data bandwidth.  For example, when we are transferring a 64B cacheline a=
cross QPI, we will break it into 9 flits -- 1 with header information and 8=
 with 64 bits of actual data and an additional 16 bits of other information=
.  To calculate data bandwidth, one should therefore do: data flits * 8B / =
time.; Counts the number of snoop request flits transmitted over QPI.  Thes=
e requests are contained in the snoop channel.  This does not include snoop=
 responses, which are transmitted on the home channel.",
         "UMask": "0x1",
         "Unit": "QPI LL"
     },
@@ -1317,7 +1317,7 @@
         "EventName": "UNC_Q_TxL_FLITS_G2.NCB",
         "ExtSel": "1",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of flits trasmitted across=
 the QPI Link.  This is one of three groups that allow us to track flits.  =
It includes filters for NDR, NCB, and NCS message classes.  Each flit is ma=
de up of 80 bits of information (in addition to some ECC data).  In full-wi=
dth (L0) mode, flits are made up of four fits, each of which contains 20 bi=
ts of data (along with some additional ECC data).   In half-width (L0p) mod=
e, the fits are only 10 bits, and therefore it takes twice as many fits to =
transmit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), t=
he transfers here refer to fits.  Therefore, in L0, the system will transfe=
r 1 flit at the rate of 1/4th the QPI speed.  One can calculate the bandwid=
th of the link by taking: flits*80b/time.  Note that this is not the same a=
s data bandwidth.  For example, when we are transfering a 64B cacheline acr=
oss QPI, we will break it into 9 flits -- 1 with header information and 8 w=
ith 64 bits of actual data and an additional 16 bits of other information. =
 To calculate data bandwidth, one should therefore do: data flits * 8B / ti=
me.; Number of Non-Coherent Bypass flits.  These packets are generally used=
 to transmit non-coherent data across QPI.",
+        "PublicDescription": "Counts the number of flits transmitted acros=
s the QPI Link.  This is one of three groups that allow us to track flits. =
 It includes filters for NDR, NCB, and NCS message classes.  Each flit is m=
ade up of 80 bits of information (in addition to some ECC data).  In full-w=
idth (L0) mode, flits are made up of four fits, each of which contains 20 b=
its of data (along with some additional ECC data).   In half-width (L0p) mo=
de, the fits are only 10 bits, and therefore it takes twice as many fits to=
 transmit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), =
the transfers here refer to fits.  Therefore, in L0, the system will transf=
er 1 flit at the rate of 1/4th the QPI speed.  One can calculate the bandwi=
dth of the link by taking: flits*80b/time.  Note that this is not the same =
as data bandwidth.  For example, when we are transferring a 64B cacheline a=
cross QPI, we will break it into 9 flits -- 1 with header information and 8=
 with 64 bits of actual data and an additional 16 bits of other information=
.  To calculate data bandwidth, one should therefore do: data flits * 8B / =
time.; Number of Non-Coherent Bypass flits.  These packets are generally us=
ed to transmit non-coherent data across QPI.",
         "UMask": "0xC",
         "Unit": "QPI LL"
     },
@@ -1328,7 +1328,7 @@
         "EventName": "UNC_Q_TxL_FLITS_G2.NCB_DATA",
         "ExtSel": "1",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of flits trasmitted across=
 the QPI Link.  This is one of three groups that allow us to track flits.  =
It includes filters for NDR, NCB, and NCS message classes.  Each flit is ma=
de up of 80 bits of information (in addition to some ECC data).  In full-wi=
dth (L0) mode, flits are made up of four fits, each of which contains 20 bi=
ts of data (along with some additional ECC data).   In half-width (L0p) mod=
e, the fits are only 10 bits, and therefore it takes twice as many fits to =
transmit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), t=
he transfers here refer to fits.  Therefore, in L0, the system will transfe=
r 1 flit at the rate of 1/4th the QPI speed.  One can calculate the bandwid=
th of the link by taking: flits*80b/time.  Note that this is not the same a=
s data bandwidth.  For example, when we are transfering a 64B cacheline acr=
oss QPI, we will break it into 9 flits -- 1 with header information and 8 w=
ith 64 bits of actual data and an additional 16 bits of other information. =
 To calculate data bandwidth, one should therefore do: data flits * 8B / ti=
me.; Number of Non-Coherent Bypass data flits.  These flits are generally u=
sed to transmit non-coherent data across QPI.  This does not include a coun=
t of the DRS (coherent) data flits.  This only counts the data flits, not t=
e NCB headers.",
+        "PublicDescription": "Counts the number of flits transmitted acros=
s the QPI Link.  This is one of three groups that allow us to track flits. =
 It includes filters for NDR, NCB, and NCS message classes.  Each flit is m=
ade up of 80 bits of information (in addition to some ECC data).  In full-w=
idth (L0) mode, flits are made up of four fits, each of which contains 20 b=
its of data (along with some additional ECC data).   In half-width (L0p) mo=
de, the fits are only 10 bits, and therefore it takes twice as many fits to=
 transmit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), =
the transfers here refer to fits.  Therefore, in L0, the system will transf=
er 1 flit at the rate of 1/4th the QPI speed.  One can calculate the bandwi=
dth of the link by taking: flits*80b/time.  Note that this is not the same =
as data bandwidth.  For example, when we are transferring a 64B cacheline a=
cross QPI, we will break it into 9 flits -- 1 with header information and 8=
 with 64 bits of actual data and an additional 16 bits of other information=
.  To calculate data bandwidth, one should therefore do: data flits * 8B / =
time.; Number of Non-Coherent Bypass data flits.  These flits are generally=
 used to transmit non-coherent data across QPI.  This does not include a co=
unt of the DRS (coherent) data flits.  This only counts the data flits, not=
 the NCB headers.",
         "UMask": "0x4",
         "Unit": "QPI LL"
     },
@@ -1339,7 +1339,7 @@
         "EventName": "UNC_Q_TxL_FLITS_G2.NCB_NONDATA",
         "ExtSel": "1",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of flits trasmitted across=
 the QPI Link.  This is one of three groups that allow us to track flits.  =
It includes filters for NDR, NCB, and NCS message classes.  Each flit is ma=
de up of 80 bits of information (in addition to some ECC data).  In full-wi=
dth (L0) mode, flits are made up of four fits, each of which contains 20 bi=
ts of data (along with some additional ECC data).   In half-width (L0p) mod=
e, the fits are only 10 bits, and therefore it takes twice as many fits to =
transmit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), t=
he transfers here refer to fits.  Therefore, in L0, the system will transfe=
r 1 flit at the rate of 1/4th the QPI speed.  One can calculate the bandwid=
th of the link by taking: flits*80b/time.  Note that this is not the same a=
s data bandwidth.  For example, when we are transfering a 64B cacheline acr=
oss QPI, we will break it into 9 flits -- 1 with header information and 8 w=
ith 64 bits of actual data and an additional 16 bits of other information. =
 To calculate data bandwidth, one should therefore do: data flits * 8B / ti=
me.; Number of Non-Coherent Bypass non-data flits.  These packets are gener=
ally used to transmit non-coherent data across QPI, and the flits counted h=
ere are for headers and other non-data flits.  This includes extended heade=
rs.",
+        "PublicDescription": "Counts the number of flits transmitted acros=
s the QPI Link.  This is one of three groups that allow us to track flits. =
 It includes filters for NDR, NCB, and NCS message classes.  Each flit is m=
ade up of 80 bits of information (in addition to some ECC data).  In full-w=
idth (L0) mode, flits are made up of four fits, each of which contains 20 b=
its of data (along with some additional ECC data).   In half-width (L0p) mo=
de, the fits are only 10 bits, and therefore it takes twice as many fits to=
 transmit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), =
the transfers here refer to fits.  Therefore, in L0, the system will transf=
er 1 flit at the rate of 1/4th the QPI speed.  One can calculate the bandwi=
dth of the link by taking: flits*80b/time.  Note that this is not the same =
as data bandwidth.  For example, when we are transferring a 64B cacheline a=
cross QPI, we will break it into 9 flits -- 1 with header information and 8=
 with 64 bits of actual data and an additional 16 bits of other information=
.  To calculate data bandwidth, one should therefore do: data flits * 8B / =
time.; Number of Non-Coherent Bypass non-data flits.  These packets are gen=
erally used to transmit non-coherent data across QPI, and the flits counted=
 here are for headers and other non-data flits.  This includes extended hea=
ders.",
         "UMask": "0x8",
         "Unit": "QPI LL"
     },
@@ -1350,7 +1350,7 @@
         "EventName": "UNC_Q_TxL_FLITS_G2.NCS",
         "ExtSel": "1",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of flits trasmitted across=
 the QPI Link.  This is one of three groups that allow us to track flits.  =
It includes filters for NDR, NCB, and NCS message classes.  Each flit is ma=
de up of 80 bits of information (in addition to some ECC data).  In full-wi=
dth (L0) mode, flits are made up of four fits, each of which contains 20 bi=
ts of data (along with some additional ECC data).   In half-width (L0p) mod=
e, the fits are only 10 bits, and therefore it takes twice as many fits to =
transmit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), t=
he transfers here refer to fits.  Therefore, in L0, the system will transfe=
r 1 flit at the rate of 1/4th the QPI speed.  One can calculate the bandwid=
th of the link by taking: flits*80b/time.  Note that this is not the same a=
s data bandwidth.  For example, when we are transfering a 64B cacheline acr=
oss QPI, we will break it into 9 flits -- 1 with header information and 8 w=
ith 64 bits of actual data and an additional 16 bits of other information. =
 To calculate data bandwidth, one should therefore do: data flits * 8B / ti=
me.; Number of NCS (non-coherent standard) flits transmitted over QPI.    T=
his includes extended headers.",
+        "PublicDescription": "Counts the number of flits transmitted acros=
s the QPI Link.  This is one of three groups that allow us to track flits. =
 It includes filters for NDR, NCB, and NCS message classes.  Each flit is m=
ade up of 80 bits of information (in addition to some ECC data).  In full-w=
idth (L0) mode, flits are made up of four fits, each of which contains 20 b=
its of data (along with some additional ECC data).   In half-width (L0p) mo=
de, the fits are only 10 bits, and therefore it takes twice as many fits to=
 transmit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), =
the transfers here refer to fits.  Therefore, in L0, the system will transf=
er 1 flit at the rate of 1/4th the QPI speed.  One can calculate the bandwi=
dth of the link by taking: flits*80b/time.  Note that this is not the same =
as data bandwidth.  For example, when we are transferring a 64B cacheline a=
cross QPI, we will break it into 9 flits -- 1 with header information and 8=
 with 64 bits of actual data and an additional 16 bits of other information=
.  To calculate data bandwidth, one should therefore do: data flits * 8B / =
time.; Number of NCS (non-coherent standard) flits transmitted over QPI.   =
 This includes extended headers.",
         "UMask": "0x10",
         "Unit": "QPI LL"
     },
@@ -1361,7 +1361,7 @@
         "EventName": "UNC_Q_TxL_FLITS_G2.NDR_AD",
         "ExtSel": "1",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of flits trasmitted across=
 the QPI Link.  This is one of three groups that allow us to track flits.  =
It includes filters for NDR, NCB, and NCS message classes.  Each flit is ma=
de up of 80 bits of information (in addition to some ECC data).  In full-wi=
dth (L0) mode, flits are made up of four fits, each of which contains 20 bi=
ts of data (along with some additional ECC data).   In half-width (L0p) mod=
e, the fits are only 10 bits, and therefore it takes twice as many fits to =
transmit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), t=
he transfers here refer to fits.  Therefore, in L0, the system will transfe=
r 1 flit at the rate of 1/4th the QPI speed.  One can calculate the bandwid=
th of the link by taking: flits*80b/time.  Note that this is not the same a=
s data bandwidth.  For example, when we are transfering a 64B cacheline acr=
oss QPI, we will break it into 9 flits -- 1 with header information and 8 w=
ith 64 bits of actual data and an additional 16 bits of other information. =
 To calculate data bandwidth, one should therefore do: data flits * 8B / ti=
me.; Counts the total number of flits transmitted over the NDR (Non-Data Re=
sponse) channel.  This channel is used to send a variety of protocol flits =
including grants and completions.  This is only for NDR packets to the loca=
l socket which use the AK ring.",
+        "PublicDescription": "Counts the number of flits transmitted acros=
s the QPI Link.  This is one of three groups that allow us to track flits. =
 It includes filters for NDR, NCB, and NCS message classes.  Each flit is m=
ade up of 80 bits of information (in addition to some ECC data).  In full-w=
idth (L0) mode, flits are made up of four fits, each of which contains 20 b=
its of data (along with some additional ECC data).   In half-width (L0p) mo=
de, the fits are only 10 bits, and therefore it takes twice as many fits to=
 transmit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), =
the transfers here refer to fits.  Therefore, in L0, the system will transf=
er 1 flit at the rate of 1/4th the QPI speed.  One can calculate the bandwi=
dth of the link by taking: flits*80b/time.  Note that this is not the same =
as data bandwidth.  For example, when we are transferring a 64B cacheline a=
cross QPI, we will break it into 9 flits -- 1 with header information and 8=
 with 64 bits of actual data and an additional 16 bits of other information=
.  To calculate data bandwidth, one should therefore do: data flits * 8B / =
time.; Counts the total number of flits transmitted over the NDR (Non-Data =
Response) channel.  This channel is used to send a variety of protocol flit=
s including grants and completions.  This is only for NDR packets to the lo=
cal socket which use the AK ring.",
         "UMask": "0x1",
         "Unit": "QPI LL"
     },
@@ -1372,7 +1372,7 @@
         "EventName": "UNC_Q_TxL_FLITS_G2.NDR_AK",
         "ExtSel": "1",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of flits trasmitted across=
 the QPI Link.  This is one of three groups that allow us to track flits.  =
It includes filters for NDR, NCB, and NCS message classes.  Each flit is ma=
de up of 80 bits of information (in addition to some ECC data).  In full-wi=
dth (L0) mode, flits are made up of four fits, each of which contains 20 bi=
ts of data (along with some additional ECC data).   In half-width (L0p) mod=
e, the fits are only 10 bits, and therefore it takes twice as many fits to =
transmit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), t=
he transfers here refer to fits.  Therefore, in L0, the system will transfe=
r 1 flit at the rate of 1/4th the QPI speed.  One can calculate the bandwid=
th of the link by taking: flits*80b/time.  Note that this is not the same a=
s data bandwidth.  For example, when we are transfering a 64B cacheline acr=
oss QPI, we will break it into 9 flits -- 1 with header information and 8 w=
ith 64 bits of actual data and an additional 16 bits of other information. =
 To calculate data bandwidth, one should therefore do: data flits * 8B / ti=
me.; Counts the total number of flits transmitted over the NDR (Non-Data Re=
sponse) channel.  This channel is used to send a variety of protocol flits =
including grants and completions.  This is only for NDR packets destined fo=
r Route-thru to a remote socket.",
+        "PublicDescription": "Counts the number of flits transmitted acros=
s the QPI Link.  This is one of three groups that allow us to track flits. =
 It includes filters for NDR, NCB, and NCS message classes.  Each flit is m=
ade up of 80 bits of information (in addition to some ECC data).  In full-w=
idth (L0) mode, flits are made up of four fits, each of which contains 20 b=
its of data (along with some additional ECC data).   In half-width (L0p) mo=
de, the fits are only 10 bits, and therefore it takes twice as many fits to=
 transmit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), =
the transfers here refer to fits.  Therefore, in L0, the system will transf=
er 1 flit at the rate of 1/4th the QPI speed.  One can calculate the bandwi=
dth of the link by taking: flits*80b/time.  Note that this is not the same =
as data bandwidth.  For example, when we are transferring a 64B cacheline a=
cross QPI, we will break it into 9 flits -- 1 with header information and 8=
 with 64 bits of actual data and an additional 16 bits of other information=
.  To calculate data bandwidth, one should therefore do: data flits * 8B / =
time.; Counts the total number of flits transmitted over the NDR (Non-Data =
Response) channel.  This channel is used to send a variety of protocol flit=
s including grants and completions.  This is only for NDR packets destined =
for Route-thru to a remote socket.",
         "UMask": "0x2",
         "Unit": "QPI LL"
     },
@@ -1511,7 +1511,7 @@
         "EventName": "UNC_Q_TxR_AD_SNP_CREDIT_OCCUPANCY.VN0",
         "ExtSel": "1",
         "PerPkg": "1",
-        "PublicDescription": "Occupancy event that tracks the number of li=
nk layer credits into the R3 (for transactions across the BGF) available in=
 each cycle.  Flow Control FIFO fro Snoop messages on AD.",
+        "PublicDescription": "Occupancy event that tracks the number of li=
nk layer credits into the R3 (for transactions across the BGF) available in=
 each cycle.  Flow Control FIFO for Snoop messages on AD.",
         "UMask": "0x1",
         "Unit": "QPI LL"
     },
@@ -1522,7 +1522,7 @@
         "EventName": "UNC_Q_TxR_AD_SNP_CREDIT_OCCUPANCY.VN1",
         "ExtSel": "1",
         "PerPkg": "1",
-        "PublicDescription": "Occupancy event that tracks the number of li=
nk layer credits into the R3 (for transactions across the BGF) available in=
 each cycle.  Flow Control FIFO fro Snoop messages on AD.",
+        "PublicDescription": "Occupancy event that tracks the number of li=
nk layer credits into the R3 (for transactions across the BGF) available in=
 each cycle.  Flow Control FIFO for Snoop messages on AD.",
         "UMask": "0x2",
         "Unit": "QPI LL"
     },
diff --git a/tools/perf/pmu-events/arch/x86/ivytown/uncore-memory.json b/to=
ols/perf/pmu-events/arch/x86/ivytown/uncore-memory.json
index 63b49b712c62..ed60ebca35cb 100644
--- a/tools/perf/pmu-events/arch/x86/ivytown/uncore-memory.json
+++ b/tools/perf/pmu-events/arch/x86/ivytown/uncore-memory.json
@@ -188,7 +188,7 @@
         "EventCode": "0x9",
         "EventName": "UNC_M_ECC_CORRECTABLE_ERRORS",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of ECC errors detected and=
 corrected by the iMC on this channel.  This counter is only useful with EC=
C DRAM devices.  This count will increment one time for each correction reg=
ardless of the number of bits corrected.  The iMC can correct up to 4 bit e=
rrors in independent channel mode and 8 bit erros in lockstep mode.",
+        "PublicDescription": "Counts the number of ECC errors detected and=
 corrected by the iMC on this channel.  This counter is only useful with EC=
C DRAM devices.  This count will increment one time for each correction reg=
ardless of the number of bits corrected.  The iMC can correct up to 4 bit e=
rrors in independent channel mode and 8 bit errors in lockstep mode.",
         "Unit": "iMC"
     },
     {
diff --git a/tools/perf/pmu-events/arch/x86/ivytown/uncore-other.json b/too=
ls/perf/pmu-events/arch/x86/ivytown/uncore-other.json
index af289aa6c98e..6c7ddf642fc3 100644
--- a/tools/perf/pmu-events/arch/x86/ivytown/uncore-other.json
+++ b/tools/perf/pmu-events/arch/x86/ivytown/uncore-other.json
@@ -2097,7 +2097,7 @@
         "EventCode": "0x33",
         "EventName": "UNC_R3_VNA_CREDITS_ACQUIRED",
         "PerPkg": "1",
-        "PublicDescription": "Number of QPI VNA Credit acquisitions.  This=
 event can be used in conjunction with the VNA In-Use Accumulator to calcul=
ate the average lifetime of a credit holder.  VNA credits are used by all m=
essage classes in order to communicate across QPI.  If a packet is unable t=
o acquire credits, it will then attempt to use credts from the VN0 pool.  N=
ote that a single packet may require multiple flit buffers (i.e. when data =
is being transfered).  Therefore, this event will increment by the number o=
f credits acquired in each cycle.  Filtering based on message class is not =
provided.  One can count the number of packets transfered in a given messag=
e class using an qfclk event.",
+        "PublicDescription": "Number of QPI VNA Credit acquisitions.  This=
 event can be used in conjunction with the VNA In-Use Accumulator to calcul=
ate the average lifetime of a credit holder.  VNA credits are used by all m=
essage classes in order to communicate across QPI.  If a packet is unable t=
o acquire credits, it will then attempt to use credits from the VN0 pool.  =
Note that a single packet may require multiple flit buffers (i.e. when data=
 is being transferred).  Therefore, this event will increment by the number=
 of credits acquired in each cycle.  Filtering based on message class is no=
t provided.  One can count the number of packets transferred in a given mes=
sage class using an qfclk event.",
         "Unit": "R3QPI"
     },
     {
@@ -2106,7 +2106,7 @@
         "EventCode": "0x33",
         "EventName": "UNC_R3_VNA_CREDITS_ACQUIRED.AD",
         "PerPkg": "1",
-        "PublicDescription": "Number of QPI VNA Credit acquisitions.  This=
 event can be used in conjunction with the VNA In-Use Accumulator to calcul=
ate the average lifetime of a credit holder.  VNA credits are used by all m=
essage classes in order to communicate across QPI.  If a packet is unable t=
o acquire credits, it will then attempt to use credts from the VN0 pool.  N=
ote that a single packet may require multiple flit buffers (i.e. when data =
is being transfered).  Therefore, this event will increment by the number o=
f credits acquired in each cycle.  Filtering based on message class is not =
provided.  One can count the number of packets transfered in a given messag=
e class using an qfclk event.; Filter for the Home (HOM) message class.  HO=
M is generally used to send requests, request responses, and snoop response=
s.",
+        "PublicDescription": "Number of QPI VNA Credit acquisitions.  This=
 event can be used in conjunction with the VNA In-Use Accumulator to calcul=
ate the average lifetime of a credit holder.  VNA credits are used by all m=
essage classes in order to communicate across QPI.  If a packet is unable t=
o acquire credits, it will then attempt to use credits from the VN0 pool.  =
Note that a single packet may require multiple flit buffers (i.e. when data=
 is being transferred).  Therefore, this event will increment by the number=
 of credits acquired in each cycle.  Filtering based on message class is no=
t provided.  One can count the number of packets transferred in a given mes=
sage class using an qfclk event.; Filter for the Home (HOM) message class. =
 HOM is generally used to send requests, request responses, and snoop respo=
nses.",
         "UMask": "0x1",
         "Unit": "R3QPI"
     },
@@ -2116,7 +2116,7 @@
         "EventCode": "0x33",
         "EventName": "UNC_R3_VNA_CREDITS_ACQUIRED.BL",
         "PerPkg": "1",
-        "PublicDescription": "Number of QPI VNA Credit acquisitions.  This=
 event can be used in conjunction with the VNA In-Use Accumulator to calcul=
ate the average lifetime of a credit holder.  VNA credits are used by all m=
essage classes in order to communicate across QPI.  If a packet is unable t=
o acquire credits, it will then attempt to use credts from the VN0 pool.  N=
ote that a single packet may require multiple flit buffers (i.e. when data =
is being transfered).  Therefore, this event will increment by the number o=
f credits acquired in each cycle.  Filtering based on message class is not =
provided.  One can count the number of packets transfered in a given messag=
e class using an qfclk event.; Filter for the Home (HOM) message class.  HO=
M is generally used to send requests, request responses, and snoop response=
s.",
+        "PublicDescription": "Number of QPI VNA Credit acquisitions.  This=
 event can be used in conjunction with the VNA In-Use Accumulator to calcul=
ate the average lifetime of a credit holder.  VNA credits are used by all m=
essage classes in order to communicate across QPI.  If a packet is unable t=
o acquire credits, it will then attempt to use credits from the VN0 pool.  =
Note that a single packet may require multiple flit buffers (i.e. when data=
 is being transferred).  Therefore, this event will increment by the number=
 of credits acquired in each cycle.  Filtering based on message class is no=
t provided.  One can count the number of packets transferred in a given mes=
sage class using an qfclk event.; Filter for the Home (HOM) message class. =
 HOM is generally used to send requests, request responses, and snoop respo=
nses.",
         "UMask": "0x4",
         "Unit": "R3QPI"
     },
diff --git a/tools/perf/pmu-events/arch/x86/ivytown/uncore-power.json b/too=
ls/perf/pmu-events/arch/x86/ivytown/uncore-power.json
index 0ba63a97ddfa..74c87217d75c 100644
--- a/tools/perf/pmu-events/arch/x86/ivytown/uncore-power.json
+++ b/tools/perf/pmu-events/arch/x86/ivytown/uncore-power.json
@@ -601,7 +601,7 @@
         "EventCode": "0x80",
         "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C0",
         "PerPkg": "1",
-        "PublicDescription": "This is an occupancy event that tracks the n=
umber of cores that are in the chosen C-State.  It can be used by itself to=
 get the average number of cores in that C-state with threshholding to gene=
rate histograms, or with other PCU events and occupancy triggering to captu=
re other details.",
+        "PublicDescription": "This is an occupancy event that tracks the n=
umber of cores that are in the chosen C-State.  It can be used by itself to=
 get the average number of cores in that C-state with thresholding to gener=
ate histograms, or with other PCU events and occupancy triggering to captur=
e other details.",
         "Unit": "PCU"
     },
     {
@@ -610,7 +610,7 @@
         "EventCode": "0x80",
         "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C3",
         "PerPkg": "1",
-        "PublicDescription": "This is an occupancy event that tracks the n=
umber of cores that are in the chosen C-State.  It can be used by itself to=
 get the average number of cores in that C-state with threshholding to gene=
rate histograms, or with other PCU events and occupancy triggering to captu=
re other details.",
+        "PublicDescription": "This is an occupancy event that tracks the n=
umber of cores that are in the chosen C-State.  It can be used by itself to=
 get the average number of cores in that C-state with thresholding to gener=
ate histograms, or with other PCU events and occupancy triggering to captur=
e other details.",
         "Unit": "PCU"
     },
     {
@@ -619,7 +619,7 @@
         "EventCode": "0x80",
         "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C6",
         "PerPkg": "1",
-        "PublicDescription": "This is an occupancy event that tracks the n=
umber of cores that are in the chosen C-State.  It can be used by itself to=
 get the average number of cores in that C-state with threshholding to gene=
rate histograms, or with other PCU events and occupancy triggering to captu=
re other details.",
+        "PublicDescription": "This is an occupancy event that tracks the n=
umber of cores that are in the chosen C-State.  It can be used by itself to=
 get the average number of cores in that C-state with thresholding to gener=
ate histograms, or with other PCU events and occupancy triggering to captur=
e other details.",
         "Unit": "PCU"
     },
     {
@@ -637,7 +637,7 @@
         "EventCode": "0x9",
         "EventName": "UNC_P_PROCHOT_INTERNAL_CYCLES",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles that we are in I=
nteral PROCHOT mode.  This mode is triggered when a sensor on the die deter=
mines that we are too hot and must throttle to avoid damaging the chip.",
+        "PublicDescription": "Counts the number of cycles that we are in I=
nternal PROCHOT mode.  This mode is triggered when a sensor on the die dete=
rmines that we are too hot and must throttle to avoid damaging the chip.",
         "Unit": "PCU"
     },
     {
diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-ev=
ents/arch/x86/mapfile.csv
index 84535179d128..81bd6f5d5354 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -13,7 +13,7 @@ GenuineIntel-6-3F,v26,haswellx,core
 GenuineIntel-6-(7D|7E|A7),v1.15,icelake,core
 GenuineIntel-6-6[AC],v1.16,icelakex,core
 GenuineIntel-6-3A,v22,ivybridge,core
-GenuineIntel-6-3E,v21,ivytown,core
+GenuineIntel-6-3E,v22,ivytown,core
 GenuineIntel-6-2D,v21,jaketown,core
 GenuineIntel-6-(57|85),v9,knightslanding,core
 GenuineIntel-6-AA,v1.00,meteorlake,core
--=20
2.38.0.rc1.362.ged0d419d3c-goog

