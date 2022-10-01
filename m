Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7487D5F1A32
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 08:09:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbiJAGJA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 02:09:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiJAGHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 02:07:25 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DD7D130F10
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 23:07:12 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-3579d28ffd6so9937057b3.18
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 23:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date;
        bh=WBi/zjqY1H2qu2T4heI4XM/6PHRlY2MLte2wHLsjygA=;
        b=m48WypvlBuZeQxWyCFym2YzL6zfXIViBv5zyjwt786UIPK0SLyCJCKI1gUNapwSv0Q
         /srcgMroTlAiXFn7CFzs9zoQXNmpYivc1exqvI73pgiRaQL6sDeaHdP3yNAOI0ShSeBv
         lYp5KNeWa7MxRE+WDe6FvgWOUqfwSRJqP3mivdEXNhyhKhRs7z8c0S3uqTIhykJv7o/s
         s8zp4pfe8FwKhyhQPoiStr1IBbvyh172mbH8RFTKKQOYuIfMZcuaXX4w1J3utfjQ4hiX
         g4RkO48OEY9Gc/1Y3jtNuLEoiX6mWushWWIB5RkxPSFRm68yxhFMEgr6ZiK1p07XfkcH
         E7cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date;
        bh=WBi/zjqY1H2qu2T4heI4XM/6PHRlY2MLte2wHLsjygA=;
        b=0+vQaDQ9IZq7pdZ9IWRo2NEheTm/Kp54MlYxC/ToLzBCn/iBeICxTkxAkUhzQRgSdy
         LV/4rSfqJAQrvvdV7r8f2O6Mw+6mBR2aD2j3x0Gjkuk2Z1eHzz5TvL2TIRk62ih7R8cw
         vfS9PzZ3m91GT0lKyHo1qjFyBHIi6toVTNDM27IBvEC0Cl82eR3BoIhyHKZXl/C+cPrl
         FvnWnwa1XnZomsPp9JUXIrabKVBWu3P4RGNKnxHtrrIif2MqbyUDnRWVdU8gj6IlVI+O
         RmJ+1//wVu6I1r2exBNSC+uFmsPKDqoevatYMn9GfWokV9DQpohZVcYWeD0qKS+wbzEe
         oD8w==
X-Gm-Message-State: ACrzQf3POJ/VL5ZA9MTwEVCvZSbgGza5BHgKjlchDgCtnVULGUOfdUit
        gycC0CDeGqnby97uhgEaQam7O1PLtY0D
X-Google-Smtp-Source: AMsMyM6XsYCsCyfOk27nhTtn8U5BXBD0ylaKfvoSZOebL+SQlA5Bv93Vb+ctaX8kb+SHWEAMKgK9AK5wNkoW
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:de60:c6ac:8491:ce1e])
 (user=irogers job=sendgmr) by 2002:a25:d1d0:0:b0:6bd:cad:9354 with SMTP id
 i199-20020a25d1d0000000b006bd0cad9354mr4213799ybg.454.1664604431788; Fri, 30
 Sep 2022 23:07:11 -0700 (PDT)
Date:   Fri, 30 Sep 2022 23:06:25 -0700
In-Reply-To: <20221001060636.2661983-1-irogers@google.com>
Message-Id: <20221001060636.2661983-12-irogers@google.com>
Mime-Version: 1.0
References: <20221001060636.2661983-1-irogers@google.com>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Subject: [PATCH v2 11/22] perf vendor events: Update Intel haswellx
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

Events are updated to v26, the core metrics are based on TMA 4.4 full.

Use script at:
https://github.com/intel/event-converter-for-linux-perf/blob/master/downloa=
d_and_gen.py
with updates at:
https://github.com/captain5050/event-converter-for-linux-perf

Updates include:
 - Uncore event updates by Zhengjun Xing <zhengjun.xing@linux.intel.com>.
 - Rename of topdown TMA metrics from Frontend_Bound to tma_frontend_bound.
 - _SMT suffix metrics are dropped as the #SMT_On and #EBS_Mode are
   correctly expanded in the single main metric.
 - Addition of all 6 levels of TMA metrics. Previously metrics
   involving topdown events were dropped. Child metrics are placed in
   a group named after their parent allowing children of a metric to
   be easily measured using the metric name with a _group suffix.
 - ## and ##? operators are correctly expanded.
 - The locate-with column is added to the long description describing
   a sampling event.
 - Metrics are written in terms of other metrics to reduce the
   expression size and increase readability.
 - Latest metrics from: https://github.com/intel/perfmon-metrics

Tested with 'perf test':
 10: PMU events                                                      :
 10.1: PMU event table sanity                                        : Ok
 10.2: PMU event map aliases                                         : Ok
 10.3: Parsing of PMU event table metrics                            : Ok
 10.4: Parsing of PMU event table metrics with fake PMUs             : Ok

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../pmu-events/arch/x86/haswellx/cache.json   |   2 +-
 .../arch/x86/haswellx/frontend.json           |  12 +-
 .../arch/x86/haswellx/hsx-metrics.json        | 919 +++++++++++-------
 .../x86/haswellx/uncore-interconnect.json     |  18 +-
 .../arch/x86/haswellx/uncore-memory.json      |  18 +-
 tools/perf/pmu-events/arch/x86/mapfile.csv    |   2 +-
 6 files changed, 615 insertions(+), 356 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/haswellx/cache.json b/tools/per=
f/pmu-events/arch/x86/haswellx/cache.json
index 7557a203a1b6..427c949bed6e 100644
--- a/tools/perf/pmu-events/arch/x86/haswellx/cache.json
+++ b/tools/perf/pmu-events/arch/x86/haswellx/cache.json
@@ -691,7 +691,7 @@
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
diff --git a/tools/perf/pmu-events/arch/x86/haswellx/frontend.json b/tools/=
perf/pmu-events/arch/x86/haswellx/frontend.json
index c45a09abe5d3..18a993297108 100644
--- a/tools/perf/pmu-events/arch/x86/haswellx/frontend.json
+++ b/tools/perf/pmu-events/arch/x86/haswellx/frontend.json
@@ -161,7 +161,7 @@
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
@@ -172,7 +172,7 @@
         "UMask": "0x30"
     },
     {
-        "BriefDescription": "Cycles when uops initiated by Decode Stream B=
uffer (DSB) are being delivered to Instruction Decode Queue (IDQ) while Mic=
rocode Sequenser (MS) is busy.",
+        "BriefDescription": "Cycles when uops initiated by Decode Stream B=
uffer (DSB) are being delivered to Instruction Decode Queue (IDQ) while Mic=
rocode Sequencer (MS) is busy.",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
@@ -182,7 +182,7 @@
         "UMask": "0x10"
     },
     {
-        "BriefDescription": "Deliveries to Instruction Decode Queue (IDQ) =
initiated by Decode Stream Buffer (DSB) while Microcode Sequenser (MS) is b=
usy.",
+        "BriefDescription": "Deliveries to Instruction Decode Queue (IDQ) =
initiated by Decode Stream Buffer (DSB) while Microcode Sequencer (MS) is b=
usy.",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
@@ -193,7 +193,7 @@
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
@@ -203,7 +203,7 @@
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
@@ -224,7 +224,7 @@
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
diff --git a/tools/perf/pmu-events/arch/x86/haswellx/hsx-metrics.json b/too=
ls/perf/pmu-events/arch/x86/haswellx/hsx-metrics.json
index d31d76db9d84..2cd86750986a 100644
--- a/tools/perf/pmu-events/arch/x86/haswellx/hsx-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/haswellx/hsx-metrics.json
@@ -1,64 +1,514 @@
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
+        "MetricExpr": "ICACHE.IFDATA_STALL / CLKS",
+        "MetricGroup": "BigFoot;FetchLat;IcMiss;TopdownL3;tma_fetch_latenc=
y_group",
+        "MetricName": "tma_icache_misses",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to Instruction TLB (ITLB) misses",
+        "MetricExpr": "(14 * ITLB_MISSES.STLB_HIT + ITLB_MISSES.WALK_DURAT=
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
+        "MetricExpr": "2 * IDQ.MS_SWITCHES / CLKS",
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
ACTIVITY.CYCLES_NO_EXECUTE) + (cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D1@ - cpu@=
UOPS_EXECUTED.CORE\\,cmask\\=3D3@ if (IPC > 1.8) else cpu@UOPS_EXECUTED.COR=
E\\,cmask\\=3D2@) / 2 - RS_EVENTS.EMPTY_CYCLES if (tma_fetch_latency > 0.1)=
 else RESOURCE_STALLS.SB) if #SMT_on else (min(CPU_CLK_UNHALTED.THREAD, CYC=
LE_ACTIVITY.CYCLES_NO_EXECUTE) + cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D1@ - cp=
u@UOPS_EXECUTED.CORE\\,cmask\\=3D3@ if (IPC > 1.8) else cpu@UOPS_EXECUTED.C=
ORE\\,cmask\\=3D2@ - RS_EVENTS.EMPTY_CYCLES if (tma_fetch_latency > 0.1) el=
se RESOURCE_STALLS.SB)) * tma_backend_bound",
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
+        "MetricExpr": "(8 * DTLB_LOAD_MISSES.STLB_HIT + DTLB_LOAD_MISSES.W=
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
+        "MetricExpr": "Load_Miss_Real_Latency * LD_BLOCKS.NO_SR / CLKS",
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
+    },
+    {
+        "BriefDescription": "This metric does a *rough estimation* of how =
often L1D Fill Buffer unavailability limited additional L1D miss memory acc=
ess requests to proceed",
+        "MetricExpr": "Load_Miss_Real_Latency * cpu@L1D_PEND_MISS.REQUEST_=
FB_FULL\\,cmask\\=3D1@ / CLKS",
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
+        "MetricExpr": "(MEM_LOAD_UOPS_RETIRED.L3_HIT / (MEM_LOAD_UOPS_RETI=
RED.L3_HIT + 7 * MEM_LOAD_UOPS_RETIRED.L3_MISS)) * CYCLE_ACTIVITY.STALLS_L2=
_PENDING / CLKS",
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
+        "MetricExpr": "(60 * (MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_HITM * (1 =
+ mem_load_uops_retired.hit_lfb / ((MEM_LOAD_UOPS_RETIRED.L2_HIT + MEM_LOAD=
_UOPS_RETIRED.L3_HIT + MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_HIT + MEM_LOAD_UOP=
S_L3_HIT_RETIRED.XSNP_HITM + MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_MISS) + MEM_=
LOAD_UOPS_L3_MISS_RETIRED.LOCAL_DRAM + MEM_LOAD_UOPS_L3_MISS_RETIRED.REMOTE=
_DRAM + MEM_LOAD_UOPS_L3_MISS_RETIRED.REMOTE_HITM + MEM_LOAD_UOPS_L3_MISS_R=
ETIRED.REMOTE_FWD))) + 43 * (MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_MISS * (1 + =
mem_load_uops_retired.hit_lfb / ((MEM_LOAD_UOPS_RETIRED.L2_HIT + MEM_LOAD_U=
OPS_RETIRED.L3_HIT + MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_HIT + MEM_LOAD_UOPS_=
L3_HIT_RETIRED.XSNP_HITM + MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_MISS) + MEM_LO=
AD_UOPS_L3_MISS_RETIRED.LOCAL_DRAM + MEM_LOAD_UOPS_L3_MISS_RETIRED.REMOTE_D=
RAM + MEM_LOAD_UOPS_L3_MISS_RETIRED.REMOTE_HITM + MEM_LOAD_UOPS_L3_MISS_RET=
IRED.REMOTE_FWD)))) / CLKS",
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
+        "MetricExpr": "43 * (MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_HIT * (1 + =
mem_load_uops_retired.hit_lfb / ((MEM_LOAD_UOPS_RETIRED.L2_HIT + MEM_LOAD_U=
OPS_RETIRED.L3_HIT + MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_HIT + MEM_LOAD_UOPS_=
L3_HIT_RETIRED.XSNP_HITM + MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_MISS) + MEM_LO=
AD_UOPS_L3_MISS_RETIRED.LOCAL_DRAM + MEM_LOAD_UOPS_L3_MISS_RETIRED.REMOTE_D=
RAM + MEM_LOAD_UOPS_L3_MISS_RETIRED.REMOTE_HITM + MEM_LOAD_UOPS_L3_MISS_RET=
IRED.REMOTE_FWD))) / CLKS",
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
+        "MetricExpr": "41 * (MEM_LOAD_UOPS_RETIRED.L3_HIT * (1 + mem_load_=
uops_retired.hit_lfb / ((MEM_LOAD_UOPS_RETIRED.L2_HIT + MEM_LOAD_UOPS_RETIR=
ED.L3_HIT + MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_HIT + MEM_LOAD_UOPS_L3_HIT_RE=
TIRED.XSNP_HITM + MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_MISS) + MEM_LOAD_UOPS_L=
3_MISS_RETIRED.LOCAL_DRAM + MEM_LOAD_UOPS_L3_MISS_RETIRED.REMOTE_DRAM + MEM=
_LOAD_UOPS_L3_MISS_RETIRED.REMOTE_HITM + MEM_LOAD_UOPS_L3_MISS_RETIRED.REMO=
TE_FWD))) / CLKS",
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
+        "MetricExpr": "(1 - (MEM_LOAD_UOPS_RETIRED.L3_HIT / (MEM_LOAD_UOPS=
_RETIRED.L3_HIT + 7 * MEM_LOAD_UOPS_RETIRED.L3_MISS))) * CYCLE_ACTIVITY.STA=
LLS_L2_PENDING / CLKS",
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
+        "MetricExpr": "200 * (MEM_LOAD_UOPS_L3_MISS_RETIRED.LOCAL_DRAM * (=
1 + mem_load_uops_retired.hit_lfb / ((MEM_LOAD_UOPS_RETIRED.L2_HIT + MEM_LO=
AD_UOPS_RETIRED.L3_HIT + MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_HIT + MEM_LOAD_U=
OPS_L3_HIT_RETIRED.XSNP_HITM + MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_MISS) + ME=
M_LOAD_UOPS_L3_MISS_RETIRED.LOCAL_DRAM + MEM_LOAD_UOPS_L3_MISS_RETIRED.REMO=
TE_DRAM + MEM_LOAD_UOPS_L3_MISS_RETIRED.REMOTE_HITM + MEM_LOAD_UOPS_L3_MISS=
_RETIRED.REMOTE_FWD))) / CLKS",
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
+        "MetricExpr": "310 * (MEM_LOAD_UOPS_L3_MISS_RETIRED.REMOTE_DRAM * =
(1 + mem_load_uops_retired.hit_lfb / ((MEM_LOAD_UOPS_RETIRED.L2_HIT + MEM_L=
OAD_UOPS_RETIRED.L3_HIT + MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_HIT + MEM_LOAD_=
UOPS_L3_HIT_RETIRED.XSNP_HITM + MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_MISS) + M=
EM_LOAD_UOPS_L3_MISS_RETIRED.LOCAL_DRAM + MEM_LOAD_UOPS_L3_MISS_RETIRED.REM=
OTE_DRAM + MEM_LOAD_UOPS_L3_MISS_RETIRED.REMOTE_HITM + MEM_LOAD_UOPS_L3_MIS=
S_RETIRED.REMOTE_FWD))) / CLKS",
+        "MetricGroup": "Server;Snoop;TopdownL5;tma_mem_latency_group",
+        "MetricName": "tma_remote_dram",
+        "PublicDescription": "This metric estimates fraction of cycles whi=
le the memory subsystem was handling loads from remote memory. This is caus=
ed often due to non-optimal NUMA allocations. #link to NUMA article Sample =
with: MEM_LOAD_UOPS_L3_MISS_RETIRED.REMOTE_DRAM_PS",
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
+        "BriefDescription": "This metric estimates fraction of cycles whil=
e the memory subsystem was handling loads from remote cache in other socket=
s including synchronizations issues",
+        "MetricExpr": "(200 * (MEM_LOAD_UOPS_L3_MISS_RETIRED.REMOTE_HITM *=
 (1 + mem_load_uops_retired.hit_lfb / ((MEM_LOAD_UOPS_RETIRED.L2_HIT + MEM_=
LOAD_UOPS_RETIRED.L3_HIT + MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_HIT + MEM_LOAD=
_UOPS_L3_HIT_RETIRED.XSNP_HITM + MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_MISS) + =
MEM_LOAD_UOPS_L3_MISS_RETIRED.LOCAL_DRAM + MEM_LOAD_UOPS_L3_MISS_RETIRED.RE=
MOTE_DRAM + MEM_LOAD_UOPS_L3_MISS_RETIRED.REMOTE_HITM + MEM_LOAD_UOPS_L3_MI=
SS_RETIRED.REMOTE_FWD))) + 180 * (MEM_LOAD_UOPS_L3_MISS_RETIRED.REMOTE_FWD =
* (1 + mem_load_uops_retired.hit_lfb / ((MEM_LOAD_UOPS_RETIRED.L2_HIT + MEM=
_LOAD_UOPS_RETIRED.L3_HIT + MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_HIT + MEM_LOA=
D_UOPS_L3_HIT_RETIRED.XSNP_HITM + MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_MISS) +=
 MEM_LOAD_UOPS_L3_MISS_RETIRED.LOCAL_DRAM + MEM_LOAD_UOPS_L3_MISS_RETIRED.R=
EMOTE_DRAM + MEM_LOAD_UOPS_L3_MISS_RETIRED.REMOTE_HITM + MEM_LOAD_UOPS_L3_M=
ISS_RETIRED.REMOTE_FWD)))) / CLKS",
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
+        "MetricExpr": "(8 * DTLB_STORE_MISSES.STLB_HIT + DTLB_STORE_MISSES=
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
+        "MetricExpr": "10 * ARITH.DIVIDER_UOPS / CORE_CLKS",
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
S_NO_EXECUTE) + (cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D1@ - cpu@UOPS_EXECUTED.=
CORE\\,cmask\\=3D3@ if (IPC > 1.8) else cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D=
2@) / 2 - RS_EVENTS.EMPTY_CYCLES if (tma_fetch_latency > 0.1) else RESOURCE=
_STALLS.SB) if #SMT_on else (min(CPU_CLK_UNHALTED.THREAD, CYCLE_ACTIVITY.CY=
CLES_NO_EXECUTE) + cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D1@ - cpu@UOPS_EXECUTE=
D.CORE\\,cmask\\=3D3@ if (IPC > 1.8) else cpu@UOPS_EXECUTED.CORE\\,cmask\\=
=3D2@ - RS_EVENTS.EMPTY_CYCLES if (tma_fetch_latency > 0.1) else RESOURCE_S=
TALLS.SB) - RESOURCE_STALLS.SB - min(CPU_CLK_UNHALTED.THREAD, CYCLE_ACTIVIT=
Y.STALLS_LDM_PENDING)) / CLKS",
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
XECUTED.CORE\\,cmask\\=3D2@) / 2 if #SMT_on else (cpu@UOPS_EXECUTED.CORE\\,=
cmask\\=3D1@ - cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D2@) / CORE_CLKS",
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
XECUTED.CORE\\,cmask\\=3D3@) / 2 if #SMT_on else (cpu@UOPS_EXECUTED.CORE\\,=
cmask\\=3D2@ - cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D3@) / CORE_CLKS",
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
T_on else cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D3@) / CORE_CLKS",
+        "MetricGroup": "PortsUtil;TopdownL4;tma_ports_utilization_group",
+        "MetricName": "tma_ports_utilized_3m",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric represents Core fraction of cycle=
s CPU dispatched uops on execution ports for ALU operations.",
+        "MetricExpr": "(UOPS_DISPATCHED_PORT.PORT_0 + UOPS_DISPATCHED_PORT=
.PORT_1 + UOPS_DISPATCHED_PORT.PORT_5 + UOPS_DISPATCHED_PORT.PORT_6) / (4 *=
 CORE_CLKS)",
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
s CPU dispatched uops on execution port 6 ([HSW+]Primary Branch and simple =
ALU) Sample with: UOPS_DISPATCHED_PORT.PORT_6",
+        "MetricExpr": "UOPS_DISPATCHED_PORT.PORT_6 / CORE_CLKS",
+        "MetricGroup": "TopdownL6;tma_alu_op_utilization_group",
+        "MetricName": "tma_port_6",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric represents Core fraction of cycle=
s CPU dispatched uops on execution port for Load operations Sample with: UO=
PS_DISPATCHED.PORT_2_3",
+        "MetricExpr": "(UOPS_DISPATCHED_PORT.PORT_2 + UOPS_DISPATCHED_PORT=
.PORT_3 + UOPS_DISPATCHED_PORT.PORT_7 - UOPS_DISPATCHED_PORT.PORT_4) / (2 *=
 CORE_CLKS)",
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
+    },
+    {
+        "BriefDescription": "This metric represents Core fraction of cycle=
s CPU dispatched uops on execution port 7 ([HSW+]simple Store-address) Samp=
le with: UOPS_DISPATCHED_PORT.PORT_7",
+        "MetricExpr": "UOPS_DISPATCHED_PORT.PORT_7 / CORE_CLKS",
+        "MetricGroup": "TopdownL6;tma_store_op_utilization_group",
+        "MetricName": "tma_port_7",
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
+        "BriefDescription": "This metric serves as an approximation of leg=
acy x87 usage",
+        "MetricExpr": "INST_RETIRED.X87 * UPI / UOPS_RETIRED.RETIRE_SLOTS"=
,
+        "MetricGroup": "Compute;TopdownL4;tma_fp_arith_group",
+        "MetricName": "tma_x87_use",
+        "PublicDescription": "This metric serves as an approximation of le=
gacy x87 usage. It accounts for instructions beyond X87 FP arithmetic opera=
tions; hence may be used as a thermometer to avoid X87 high usage and prefe=
rably upgrade to modern ISA. See Tip under Tuning Hint.",
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
@@ -74,6 +524,12 @@
         "MetricGroup": "Branches;Fed;FetchBW",
         "MetricName": "UpTB"
     },
+    {
+        "BriefDescription": "Cycles Per Instruction (per Logical Processor=
)",
+        "MetricExpr": "1 / IPC",
+        "MetricGroup": "Mem;Pipeline",
+        "MetricName": "CPI"
+    },
     {
         "BriefDescription": "Per-Logical Processor actual clocks when the =
Logical Processor is active.",
         "MetricExpr": "CPU_CLK_UNHALTED.THREAD",
@@ -82,37 +538,25 @@
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
         "BriefDescription": "Instruction-Level-Parallelism (average number=
 of uops executed when there is execution) per-core",
-        "MetricExpr": "( UOPS_EXECUTED.CORE / 2 / (( cpu@UOPS_EXECUTED.COR=
E\\,cmask\\=3D1@ / 2 ) if #SMT_on else cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D1=
@) ) if #SMT_on else UOPS_EXECUTED.CORE / (( cpu@UOPS_EXECUTED.CORE\\,cmask=
\\=3D1@ / 2 ) if #SMT_on else cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D1@)",
+        "MetricExpr": "(UOPS_EXECUTED.CORE / 2 / ((cpu@UOPS_EXECUTED.CORE\=
\,cmask\\=3D1@ / 2) if #SMT_on else cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D1@))=
 if #SMT_on else UOPS_EXECUTED.CORE / ((cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D=
1@ / 2) if #SMT_on else cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D1@)",
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
@@ -153,9 +597,9 @@
         "MetricName": "BpTkBranch"
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
@@ -166,7 +610,7 @@
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
@@ -178,47 +622,41 @@
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
         "MetricExpr": "1000 * MEM_LOAD_UOPS_RETIRED.L3_MISS / INST_RETIRED=
.ANY",
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
@@ -239,19 +677,19 @@
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
@@ -269,19 +707,19 @@
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
@@ -299,13 +737,13 @@
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
     {
         "BriefDescription": "Average latency of data read request to exter=
nal memory (in nanoseconds). Accounts for demand loads and L1/L2 prefetches=
",
-        "MetricExpr": "1000000000 * ( cbox@event\\=3D0x36\\,umask\\=3D0x3\=
\,filter_opc\\=3D0x182@ / cbox@event\\=3D0x35\\,umask\\=3D0x3\\,filter_opc\=
\=3D0x182@ ) / ( cbox_0@event\\=3D0x0@ / duration_time )",
+        "MetricExpr": "1000000000 * (cbox@event\\=3D0x36\\,umask\\=3D0x3\\=
,filter_opc\\=3D0x182@ / cbox@event\\=3D0x35\\,umask\\=3D0x3\\,filter_opc\\=
=3D0x182@) / (Socket_CLKS / duration_time)",
         "MetricGroup": "Mem;MemoryLat;SoC",
         "MetricName": "MEM_Read_Latency"
     },
@@ -321,12 +759,6 @@
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
@@ -375,403 +807,234 @@
         "MetricGroup": "Power",
         "MetricName": "C7_Pkg_Residency"
     },
+    {
+        "BriefDescription": "Uncore frequency per die [GHZ]",
+        "MetricExpr": "Socket_CLKS / #num_dies / duration_time / 100000000=
0",
+        "MetricGroup": "SoC",
+        "MetricName": "UNCORE_FREQ"
+    },
     {
         "BriefDescription": "CPU operating frequency (in GHz)",
-        "MetricExpr": "( CPU_CLK_UNHALTED.THREAD  /  CPU_CLK_UNHALTED.REF_=
TSC  *  #SYSTEM_TSC_FREQ ) / 1000000000",
+        "MetricExpr": "(( CPU_CLK_UNHALTED.THREAD / CPU_CLK_UNHALTED.REF_T=
SC * #SYSTEM_TSC_FREQ ) / 1000000000) / duration_time",
         "MetricGroup": "",
         "MetricName": "cpu_operating_frequency",
         "ScaleUnit": "1GHz"
     },
-    {
-        "BriefDescription": "Cycles per instruction retired; indicating ho=
w much time each executed instruction took; in units of cycles.",
-        "MetricExpr": " CPU_CLK_UNHALTED.THREAD  /  INST_RETIRED.ANY ",
-        "MetricGroup": "",
-        "MetricName": "cpi",
-        "ScaleUnit": "1per_instr"
-    },
     {
         "BriefDescription": "The ratio of number of completed memory load =
instructions to the total number completed instructions",
-        "MetricExpr": " MEM_UOPS_RETIRED.ALL_LOADS  /  INST_RETIRED.ANY ",
+        "MetricExpr": "MEM_UOPS_RETIRED.ALL_LOADS / INST_RETIRED.ANY",
         "MetricGroup": "",
         "MetricName": "loads_per_instr",
         "ScaleUnit": "1per_instr"
     },
     {
         "BriefDescription": "The ratio of number of completed memory store=
 instructions to the total number completed instructions",
-        "MetricExpr": " MEM_UOPS_RETIRED.ALL_STORES  /  INST_RETIRED.ANY "=
,
+        "MetricExpr": "MEM_UOPS_RETIRED.ALL_STORES / INST_RETIRED.ANY",
         "MetricGroup": "",
         "MetricName": "stores_per_instr",
         "ScaleUnit": "1per_instr"
     },
     {
         "BriefDescription": "Ratio of number of requests missing L1 data c=
ache (includes data+rfo w/ prefetches) to the total number of completed ins=
tructions",
-        "MetricExpr": " L1D.REPLACEMENT  /  INST_RETIRED.ANY ",
+        "MetricExpr": "L1D.REPLACEMENT / INST_RETIRED.ANY",
         "MetricGroup": "",
-        "MetricName": "l1d_mpi_includes_data_plus_rfo_with_prefetches",
+        "MetricName": "l1d_mpi",
         "ScaleUnit": "1per_instr"
     },
     {
         "BriefDescription": "Ratio of number of demand load requests hitti=
ng in L1 data cache to the total number of completed instructions",
-        "MetricExpr": " MEM_LOAD_UOPS_RETIRED.L1_HIT  /  INST_RETIRED.ANY =
",
+        "MetricExpr": "MEM_LOAD_UOPS_RETIRED.L1_HIT / INST_RETIRED.ANY",
         "MetricGroup": "",
         "MetricName": "l1d_demand_data_read_hits_per_instr",
         "ScaleUnit": "1per_instr"
     },
     {
         "BriefDescription": "Ratio of number of code read requests missing=
 in L1 instruction cache (includes prefetches) to the total number of compl=
eted instructions",
-        "MetricExpr": " L2_RQSTS.ALL_CODE_RD  /  INST_RETIRED.ANY ",
+        "MetricExpr": "L2_RQSTS.ALL_CODE_RD / INST_RETIRED.ANY",
         "MetricGroup": "",
         "MetricName": "l1_i_code_read_misses_with_prefetches_per_instr",
         "ScaleUnit": "1per_instr"
     },
     {
         "BriefDescription": "Ratio of number of completed demand load requ=
ests hitting in L2 cache to the total number of completed instructions",
-        "MetricExpr": " MEM_LOAD_UOPS_RETIRED.L2_HIT  /  INST_RETIRED.ANY =
",
+        "MetricExpr": "MEM_LOAD_UOPS_RETIRED.L2_HIT / INST_RETIRED.ANY",
         "MetricGroup": "",
         "MetricName": "l2_demand_data_read_hits_per_instr",
         "ScaleUnit": "1per_instr"
     },
     {
         "BriefDescription": "Ratio of number of requests missing L2 cache =
(includes code+data+rfo w/ prefetches) to the total number of completed ins=
tructions",
-        "MetricExpr": " L2_LINES_IN.ALL  /  INST_RETIRED.ANY ",
+        "MetricExpr": "L2_LINES_IN.ALL / INST_RETIRED.ANY",
         "MetricGroup": "",
-        "MetricName": "l2_mpi_includes_code_plus_data_plus_rfo_with_prefet=
ches",
+        "MetricName": "l2_mpi",
         "ScaleUnit": "1per_instr"
     },
     {
         "BriefDescription": "Ratio of number of completed data read reques=
t missing L2 cache to the total number of completed instructions",
-        "MetricExpr": " MEM_LOAD_UOPS_RETIRED.L2_MISS  /  INST_RETIRED.ANY=
 ",
+        "MetricExpr": "MEM_LOAD_UOPS_RETIRED.L2_MISS / INST_RETIRED.ANY",
         "MetricGroup": "",
         "MetricName": "l2_demand_data_read_mpi",
         "ScaleUnit": "1per_instr"
     },
     {
         "BriefDescription": "Ratio of number of code read request missing =
L2 cache to the total number of completed instructions",
-        "MetricExpr": " L2_RQSTS.CODE_RD_MISS  /  INST_RETIRED.ANY ",
+        "MetricExpr": "L2_RQSTS.CODE_RD_MISS / INST_RETIRED.ANY",
         "MetricGroup": "",
         "MetricName": "l2_demand_code_mpi",
         "ScaleUnit": "1per_instr"
     },
+    {
+        "BriefDescription": "Average latency of a last level cache (LLC) d=
emand and prefetch data read miss (read memory access) in nano seconds",
+        "MetricExpr": "( 1000000000 * ( cbox@UNC_C_TOR_OCCUPANCY.MISS_OPCO=
DE\\,filter_opc\\=3D0x182@ / cbox@UNC_C_TOR_INSERTS.MISS_OPCODE\\,filter_op=
c\\=3D0x182@ ) / ( UNC_C_CLOCKTICKS / ( #num_cores / #num_packages * #num_p=
ackages ) ) ) * duration_time",
+        "MetricGroup": "",
+        "MetricName": "llc_data_read_demand_plus_prefetch_miss_latency",
+        "ScaleUnit": "1ns"
+    },
+    {
+        "BriefDescription": "Average latency of a last level cache (LLC) d=
emand and prefetch data read miss (read memory access) addressed to local m=
emory in nano seconds",
+        "MetricExpr": "( 1000000000 * ( cbox@UNC_C_TOR_OCCUPANCY.MISS_LOCA=
L_OPCODE\\,filter_opc\\=3D0x182@ / cbox@UNC_C_TOR_INSERTS.MISS_LOCAL_OPCODE=
\\,filter_opc\\=3D0x182@ ) / ( UNC_C_CLOCKTICKS / ( #num_cores / #num_packa=
ges * #num_packages ) ) ) * duration_time",
+        "MetricGroup": "",
+        "MetricName": "llc_data_read_demand_plus_prefetch_miss_latency_for=
_local_requests",
+        "ScaleUnit": "1ns"
+    },
+    {
+        "BriefDescription": "Average latency of a last level cache (LLC) d=
emand and prefetch data read miss (read memory access) addressed to remote =
memory in nano seconds",
+        "MetricExpr": "( 1000000000 * ( cbox@UNC_C_TOR_OCCUPANCY.MISS_REMO=
TE_OPCODE\\,filter_opc\\=3D0x182@ / cbox@UNC_C_TOR_INSERTS.MISS_REMOTE_OPCO=
DE\\,filter_opc\\=3D0x182@ ) / ( UNC_C_CLOCKTICKS / ( #num_cores / #num_pac=
kages * #num_packages ) ) ) * duration_time",
+        "MetricGroup": "",
+        "MetricName": "llc_data_read_demand_plus_prefetch_miss_latency_for=
_remote_requests",
+        "ScaleUnit": "1ns"
+    },
     {
         "BriefDescription": "Ratio of number of completed page walks (for =
all page sizes) caused by a code fetch to the total number of completed ins=
tructions. This implies it missed in the ITLB (Instruction TLB) and further=
 levels of TLB.",
-        "MetricExpr": " ITLB_MISSES.WALK_COMPLETED  /  INST_RETIRED.ANY ",
+        "MetricExpr": "ITLB_MISSES.WALK_COMPLETED / INST_RETIRED.ANY",
         "MetricGroup": "",
         "MetricName": "itlb_mpi",
         "ScaleUnit": "1per_instr"
     },
     {
         "BriefDescription": "Ratio of number of completed page walks (for =
2 megabyte and 4 megabyte page sizes) caused by a code fetch to the total n=
umber of completed instructions. This implies it missed in the Instruction =
Translation Lookaside Buffer (ITLB) and further levels of TLB.",
-        "MetricExpr": " ITLB_MISSES.WALK_COMPLETED_2M_4M  /  INST_RETIRED.=
ANY ",
+        "MetricExpr": "ITLB_MISSES.WALK_COMPLETED_2M_4M / INST_RETIRED.ANY=
",
         "MetricGroup": "",
         "MetricName": "itlb_large_page_mpi",
         "ScaleUnit": "1per_instr"
     },
     {
         "BriefDescription": "Ratio of number of completed page walks (for =
all page sizes) caused by demand data loads to the total number of complete=
d instructions. This implies it missed in the DTLB and further levels of TL=
B.",
-        "MetricExpr": " DTLB_LOAD_MISSES.WALK_COMPLETED  /  INST_RETIRED.A=
NY ",
+        "MetricExpr": "DTLB_LOAD_MISSES.WALK_COMPLETED / INST_RETIRED.ANY"=
,
         "MetricGroup": "",
         "MetricName": "dtlb_load_mpi",
         "ScaleUnit": "1per_instr"
     },
     {
         "BriefDescription": "Ratio of number of completed page walks (for =
all page sizes) caused by demand data stores to the total number of complet=
ed instructions. This implies it missed in the DTLB and further levels of T=
LB.",
-        "MetricExpr": " DTLB_STORE_MISSES.WALK_COMPLETED  /  INST_RETIRED.=
ANY ",
+        "MetricExpr": "DTLB_STORE_MISSES.WALK_COMPLETED / INST_RETIRED.ANY=
",
         "MetricGroup": "",
         "MetricName": "dtlb_store_mpi",
         "ScaleUnit": "1per_instr"
     },
+    {
+        "BriefDescription": "Uncore operating frequency in GHz",
+        "MetricExpr": "( UNC_C_CLOCKTICKS / ( #num_cores / #num_packages *=
 #num_packages ) / 1000000000) / duration_time",
+        "MetricGroup": "",
+        "MetricName": "uncore_frequency",
+        "ScaleUnit": "1GHz"
+    },
     {
         "BriefDescription": "Intel(R) Quick Path Interconnect (QPI) data t=
ransmit bandwidth (MB/sec)",
-        "MetricExpr": "( UNC_Q_TxL_FLITS_G0.DATA  * 8 / 1000000) / duratio=
n_time",
+        "MetricExpr": "( UNC_Q_TxL_FLITS_G0.DATA * 8 / 1000000) / duration=
_time",
         "MetricGroup": "",
-        "MetricName": "qpi_data_transmit_bw_only_data",
+        "MetricName": "qpi_data_transmit_bw",
         "ScaleUnit": "1MB/s"
     },
     {
         "BriefDescription": "DDR memory read bandwidth (MB/sec)",
-        "MetricExpr": "( UNC_M_CAS_COUNT.RD  * 64 / 1000000) / duration_ti=
me",
+        "MetricExpr": "( UNC_M_CAS_COUNT.RD * 64 / 1000000) / duration_tim=
e",
         "MetricGroup": "",
         "MetricName": "memory_bandwidth_read",
         "ScaleUnit": "1MB/s"
     },
     {
         "BriefDescription": "DDR memory write bandwidth (MB/sec)",
-        "MetricExpr": "( UNC_M_CAS_COUNT.WR  * 64 / 1000000) / duration_ti=
me",
+        "MetricExpr": "( UNC_M_CAS_COUNT.WR * 64 / 1000000) / duration_tim=
e",
         "MetricGroup": "",
         "MetricName": "memory_bandwidth_write",
         "ScaleUnit": "1MB/s"
     },
     {
         "BriefDescription": "DDR memory bandwidth (MB/sec)",
-        "MetricExpr": "(( UNC_M_CAS_COUNT.RD  +  UNC_M_CAS_COUNT.WR ) * 64=
 / 1000000) / duration_time",
+        "MetricExpr": "(( UNC_M_CAS_COUNT.RD + UNC_M_CAS_COUNT.WR ) * 64 /=
 1000000) / duration_time",
         "MetricGroup": "",
         "MetricName": "memory_bandwidth_total",
         "ScaleUnit": "1MB/s"
     },
     {
         "BriefDescription": "Bandwidth of IO reads that are initiated by e=
nd device controllers that are requesting memory from the CPU.",
-        "MetricExpr": "( cbox@UNC_C_TOR_INSERTS.OPCODE\\,filter_opc\\=3D0x=
19e@  * 64 / 1000000) / duration_time",
+        "MetricExpr": "( cbox@UNC_C_TOR_INSERTS.OPCODE\\,filter_opc\\=3D0x=
19e@ * 64 / 1000000) / duration_time",
         "MetricGroup": "",
-        "MetricName": "io_bandwidth_read",
+        "MetricName": "io_bandwidth_disk_or_network_writes",
         "ScaleUnit": "1MB/s"
     },
     {
         "BriefDescription": "Bandwidth of IO writes that are initiated by =
end device controllers that are writing memory to the CPU.",
-        "MetricExpr": "( cbox@UNC_C_TOR_INSERTS.OPCODE\\,filter_opc\\=3D0x=
1c8\\,filter_tid\\=3D0x3e@  * 64 / 1000000) / duration_time",
+        "MetricExpr": "( cbox@UNC_C_TOR_INSERTS.OPCODE\\,filter_opc\\=3D0x=
1c8\\,filter_tid\\=3D0x3e@ * 64 / 1000000) / duration_time",
         "MetricGroup": "",
-        "MetricName": "io_bandwidth_write",
+        "MetricName": "io_bandwidth_disk_or_network_reads",
         "ScaleUnit": "1MB/s"
     },
     {
         "BriefDescription": "Uops delivered from decoded instruction cache=
 (decoded stream buffer or DSB) as a percent of total uops delivered to Ins=
truction Decode Queue",
-        "MetricExpr": "100 * ( IDQ.DSB_UOPS  /  UOPS_ISSUED.ANY )",
+        "MetricExpr": "100 * ( IDQ.DSB_UOPS / UOPS_ISSUED.ANY )",
         "MetricGroup": "",
-        "MetricName": "percent_uops_delivered_frodecoded_icache_dsb",
+        "MetricName": "percent_uops_delivered_from_decoded_icache",
         "ScaleUnit": "1%"
     },
     {
         "BriefDescription": "Uops delivered from legacy decode pipeline (M=
icro-instruction Translation Engine or MITE) as a percent of total uops del=
ivered to Instruction Decode Queue",
-        "MetricExpr": "100 * ( IDQ.MITE_UOPS  /  UOPS_ISSUED.ANY )",
+        "MetricExpr": "100 * ( IDQ.MITE_UOPS / UOPS_ISSUED.ANY )",
         "MetricGroup": "",
-        "MetricName": "percent_uops_delivered_frolegacy_decode_pipeline_mi=
te",
+        "MetricName": "percent_uops_delivered_from_legacy_decode_pipeline"=
,
         "ScaleUnit": "1%"
     },
     {
         "BriefDescription": "Uops delivered from microcode sequencer (MS) =
as a percent of total uops delivered to Instruction Decode Queue",
-        "MetricExpr": "100 * ( IDQ.MS_UOPS  /  UOPS_ISSUED.ANY )",
+        "MetricExpr": "100 * ( IDQ.MS_UOPS / UOPS_ISSUED.ANY )",
         "MetricGroup": "",
-        "MetricName": "percent_uops_delivered_fromicrocode_sequencer_ms",
+        "MetricName": "percent_uops_delivered_from_microcode_sequencer",
         "ScaleUnit": "1%"
     },
     {
         "BriefDescription": "Uops delivered from loop stream detector(LSD)=
 as a percent of total uops delivered to Instruction Decode Queue",
-        "MetricExpr": "100 * ( UOPS_ISSUED.ANY  -  IDQ.MITE_UOPS  -  IDQ.M=
S_UOPS  -  IDQ.DSB_UOPS ) /  UOPS_ISSUED.ANY ",
+        "MetricExpr": "100 * ( UOPS_ISSUED.ANY - IDQ.MITE_UOPS - IDQ.MS_UO=
PS - IDQ.DSB_UOPS ) / UOPS_ISSUED.ANY",
         "MetricGroup": "",
-        "MetricName": "percent_uops_delivered_froloop_streadetector_lsd",
+        "MetricName": "percent_uops_delivered_from_loop_stream_detector",
         "ScaleUnit": "1%"
     },
     {
         "BriefDescription": "Ratio of number of data read requests missing=
 last level core cache (includes demand w/ prefetches) to the total number =
of completed instructions",
-        "MetricExpr": "( cbox@UNC_C_TOR_INSERTS.MISS_OPCODE\\,filter_opc\\=
=3D0x182@  +  cbox@UNC_C_TOR_INSERTS.MISS_OPCODE\\,filter_opc\\=3D0x192@ ) =
/  INST_RETIRED.ANY ",
+        "MetricExpr": "( cbox@UNC_C_TOR_INSERTS.MISS_OPCODE\\,filter_opc\\=
=3D0x182@ + cbox@UNC_C_TOR_INSERTS.MISS_OPCODE\\,filter_opc\\=3D0x192@ ) / =
INST_RETIRED.ANY",
         "MetricGroup": "",
         "MetricName": "llc_data_read_mpi_demand_plus_prefetch",
         "ScaleUnit": "1per_instr"
     },
     {
         "BriefDescription": "Ratio of number of code read requests missing=
 last level core cache (includes demand w/ prefetches) to the total number =
of completed instructions",
-        "MetricExpr": "( cbox@UNC_C_TOR_INSERTS.MISS_OPCODE\\,filter_opc\\=
=3D0x181@  +  cbox@UNC_C_TOR_INSERTS.MISS_OPCODE\\,filter_opc\\=3D0x191@ ) =
/  INST_RETIRED.ANY ",
+        "MetricExpr": "( cbox@UNC_C_TOR_INSERTS.MISS_OPCODE\\,filter_opc\\=
=3D0x181@ + cbox@UNC_C_TOR_INSERTS.MISS_OPCODE\\,filter_opc\\=3D0x191@ ) / =
INST_RETIRED.ANY",
         "MetricGroup": "",
         "MetricName": "llc_code_read_mpi_demand_plus_prefetch",
         "ScaleUnit": "1per_instr"
     },
     {
         "BriefDescription": "Memory read that miss the last level cache (L=
LC) addressed to local DRAM as a percentage of total memory read accesses, =
does not include LLC prefetches.",
-        "MetricExpr": "100 *  cbox@UNC_C_TOR_INSERTS.MISS_OPCODE\\,filter_=
opc\\=3D0x182@  / ( cbox@UNC_C_TOR_INSERTS.MISS_OPCODE\\,filter_opc\\=3D0x1=
82@  +  cbox@UNC_C_TOR_INSERTS.MISS_OPCODE\\,filter_opc\\=3D0x182@ )",
+        "MetricExpr": "100 * cbox@UNC_C_TOR_INSERTS.MISS_LOCAL_OPCODE\\,fi=
lter_opc\\=3D0x182@ / ( cbox@UNC_C_TOR_INSERTS.MISS_LOCAL_OPCODE\\,filter_o=
pc\\=3D0x182@ + cbox@UNC_C_TOR_INSERTS.MISS_REMOTE_OPCODE\\,filter_opc\\=3D=
0x182@ )",
         "MetricGroup": "",
-        "MetricName": "numa_percent_reads_addressed_to_local_dram",
+        "MetricName": "numa_reads_addressed_to_local_dram",
         "ScaleUnit": "1%"
     },
     {
         "BriefDescription": "Memory reads that miss the last level cache (=
LLC) addressed to remote DRAM as a percentage of total memory read accesses=
, does not include LLC prefetches.",
-        "MetricExpr": "100 *  cbox@UNC_C_TOR_INSERTS.MISS_OPCODE\\,filter_=
opc\\=3D0x182@  / ( cbox@UNC_C_TOR_INSERTS.MISS_OPCODE\\,filter_opc\\=3D0x1=
82@  +  cbox@UNC_C_TOR_INSERTS.MISS_OPCODE\\,filter_opc\\=3D0x182@ )",
-        "MetricGroup": "",
-        "MetricName": "numa_percent_reads_addressed_to_remote_dram",
-        "ScaleUnit": "1%"
-    },
-    {
-        "BriefDescription": "This category represents fraction of slots wh=
ere the processor's Frontend undersupplies its Backend. Frontend denotes th=
e first part of the processor core responsible to fetch operations that are=
 executed later on by the Backend part. Within the Frontend; a branch predi=
ctor predicts the next address to fetch; cache-lines are fetched from the m=
emory subsystem; parsed into instructions; and lastly decoded into micro-op=
erations (uops). Ideally the Frontend can issue Machine_Width uops every cy=
cle to the Backend. Frontend Bound denotes unutilized issue-slots when ther=
e is no Backend stall; i.e. bubbles where Frontend delivered no uops while =
Backend could have accepted them. For example; stalls due to instruction-ca=
che misses would be categorized under Frontend Bound.",
-        "MetricExpr": "100 * (  IDQ_UOPS_NOT_DELIVERED.CORE  / ( ( 4 ) * (=
 (  CPU_CLK_UNHALTED.THREAD_ANY  / 2 ) if  #SMT_on  else (  CPU_CLK_UNHALTE=
D.THREAD  ) ) ) )",
-        "MetricGroup": "TmaL1, PGO",
-        "MetricName": "tma_frontend_bound_percent",
-        "ScaleUnit": "1%"
-    },
-    {
-        "BriefDescription": "This metric represents fraction of slots the =
CPU was stalled due to Frontend latency issues.  For example; instruction-c=
ache misses; iTLB misses or fetch stalls after a branch misprediction are c=
ategorized under Frontend Latency. In such cases; the Frontend eventually d=
elivers no uops for some period.",
-        "MetricExpr": "100 * ( ( 4 ) * ( min(  CPU_CLK_UNHALTED.THREAD  , =
 IDQ_UOPS_NOT_DELIVERED.CYCLES_0_UOPS_DELIV.CORE  ) ) / ( ( 4 ) * ( (  CPU_=
CLK_UNHALTED.THREAD_ANY  / 2 ) if  #SMT_on  else (  CPU_CLK_UNHALTED.THREAD=
  ) ) ) )",
-        "MetricGroup": "Frontend, TmaL2",
-        "MetricName": "tma_fetch_latency_percent",
-        "ScaleUnit": "1%"
-    },
-    {
-        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to instruction cache misses.",
-        "MetricExpr": "100 * (  ICACHE.IFDATA_STALL  / (  CPU_CLK_UNHALTED=
.THREAD  ) )",
-        "MetricGroup": "BigFoot, FetchLat, IcMiss",
-        "MetricName": "tma_icache_misses_percent",
-        "ScaleUnit": "1%"
-    },
-    {
-        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to Instruction TLB (ITLB) misses.",
-        "MetricExpr": "100 * ( ( 14 *  ITLB_MISSES.STLB_HIT  +  ITLB_MISSE=
S.WALK_DURATION  ) / (  CPU_CLK_UNHALTED.THREAD  ) )",
-        "MetricGroup": "BigFoot, FetchLat, MemoryTLB",
-        "MetricName": "tma_itlb_misses_percent",
-        "ScaleUnit": "1%"
-    },
-    {
-        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to Branch Resteers. Branch Resteers estimates the Fron=
tend delay in fetching operations from corrected path; following all sorts =
of miss-predicted branches. For example; branchy code with lots of miss-pre=
dictions might get categorized under Branch Resteers. Note the value of thi=
s node may overlap with its siblings.",
-        "MetricExpr": "100 * ( ( 12 ) * (  BR_MISP_RETIRED.ALL_BRANCHES  +=
  MACHINE_CLEARS.COUNT  +  BACLEARS.ANY  ) / (  CPU_CLK_UNHALTED.THREAD  ) =
)",
-        "MetricGroup": "FetchLat",
-        "MetricName": "tma_branch_resteers_percent",
-        "ScaleUnit": "1%"
-    },
-    {
-        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to switches from DSB to MITE pipelines. The DSB (decod=
ed i-cache) is a Uop Cache where the front-end directly delivers Uops (micr=
o operations) avoiding heavy x86 decoding. The DSB pipeline has shorter lat=
ency and delivered higher bandwidth than the MITE (legacy instruction decod=
e pipeline). Switching between the two pipelines can cause penalties hence =
this metric measures the exposed penalty.",
-        "MetricExpr": "100 * (  DSB2MITE_SWITCHES.PENALTY_CYCLES  / (  CPU=
_CLK_UNHALTED.THREAD  ) )",
-        "MetricGroup": "DSBmiss, FetchLat",
-        "MetricName": "tma_dsb_switches_percent",
-        "ScaleUnit": "1%"
-    },
-    {
-        "BriefDescription": "This metric represents fraction of cycles CPU=
 was stalled due to Length Changing Prefixes (LCPs). Using proper compiler =
flags or Intel Compiler by default will certainly avoid this. #Link: Optimi=
zation Guide about LCP BKMs.",
-        "MetricExpr": "100 * (  ILD_STALL.LCP  / (  CPU_CLK_UNHALTED.THREA=
D  ) )",
-        "MetricGroup": "FetchLat",
-        "MetricName": "tma_lcp_percent",
-        "ScaleUnit": "1%"
-    },
-    {
-        "BriefDescription": "This metric estimates the fraction of cycles =
when the CPU was stalled due to switches of uop delivery to the Microcode S=
equencer (MS). Commonly used instructions are optimized for delivery by the=
 DSB (decoded i-cache) or MITE (legacy instruction decode) pipelines. Certa=
in operations cannot be handled natively by the execution pipeline; and mus=
t be performed by microcode (small programs injected into the execution str=
eam). Switching to the MS too often can negatively impact performance. The =
MS is designated to deliver long uop flows required by CISC instructions li=
ke CPUID; or uncommon conditions like Floating Point Assists when dealing w=
ith Denormals.",
-        "MetricExpr": "100 * ( ( 2 ) *  IDQ.MS_SWITCHES  / (  CPU_CLK_UNHA=
LTED.THREAD  ) )",
-        "MetricGroup": "FetchLat, MicroSeq",
-        "MetricName": "tma_ms_switches_percent",
-        "ScaleUnit": "1%"
-    },
-    {
-        "BriefDescription": "This metric represents fraction of slots the =
CPU was stalled due to Frontend bandwidth issues.  For example; inefficienc=
ies at the instruction decoders; or restrictions for caching in the DSB (de=
coded uops cache) are categorized under Fetch Bandwidth. In such cases; the=
 Frontend typically delivers suboptimal amount of uops to the Backend.",
-        "MetricExpr": "100 * ( (  IDQ_UOPS_NOT_DELIVERED.CORE  / ( ( 4 ) *=
 ( (  CPU_CLK_UNHALTED.THREAD_ANY  / 2 ) if  #SMT_on  else (  CPU_CLK_UNHAL=
TED.THREAD  ) ) ) ) - ( ( 4 ) * ( min(  CPU_CLK_UNHALTED.THREAD  ,  IDQ_UOP=
S_NOT_DELIVERED.CYCLES_0_UOPS_DELIV.CORE  ) ) / ( ( 4 ) * ( (  CPU_CLK_UNHA=
LTED.THREAD_ANY  / 2 ) if  #SMT_on  else (  CPU_CLK_UNHALTED.THREAD  ) ) ) =
) )",
-        "MetricGroup": "FetchBW, Frontend, TmaL2",
-        "MetricName": "tma_fetch_bandwidth_percent",
-        "ScaleUnit": "1%"
-    },
-    {
-        "BriefDescription": "This metric represents Core fraction of cycle=
s in which CPU was likely limited due to the MITE pipeline (the legacy deco=
de pipeline). This pipeline is used for code that was not pre-cached in the=
 DSB or LSD. For example; inefficiencies due to asymmetric decoders; use of=
 long immediate or LCP can manifest as MITE fetch bandwidth bottleneck.",
-        "MetricExpr": "100 * ( (  IDQ.ALL_MITE_CYCLES_ANY_UOPS  -  IDQ.ALL=
_MITE_CYCLES_4_UOPS  ) / ( (  CPU_CLK_UNHALTED.THREAD_ANY  / 2 ) if  #SMT_o=
n  else (  CPU_CLK_UNHALTED.THREAD  ) ) / 2 )",
-        "MetricGroup": "DSBmiss, FetchBW",
-        "MetricName": "tma_mite_percent",
-        "ScaleUnit": "1%"
-    },
-    {
-        "BriefDescription": "This metric represents Core fraction of cycle=
s in which CPU was likely limited due to DSB (decoded uop cache) fetch pipe=
line.  For example; inefficient utilization of the DSB cache structure or b=
ank conflict when reading from it; are categorized here.",
-        "MetricExpr": "100 * ( (  IDQ.ALL_DSB_CYCLES_ANY_UOPS  -  IDQ.ALL_=
DSB_CYCLES_4_UOPS  ) / ( (  CPU_CLK_UNHALTED.THREAD_ANY  / 2 ) if  #SMT_on =
 else (  CPU_CLK_UNHALTED.THREAD  ) ) / 2 )",
-        "MetricGroup": "DSB, FetchBW",
-        "MetricName": "tma_dsb_percent",
-        "ScaleUnit": "1%"
-    },
-    {
-        "BriefDescription": "This category represents fraction of slots wa=
sted due to incorrect speculations. This include slots used to issue uops t=
hat do not eventually get retired and slots for which the issue-pipeline wa=
s blocked due to recovery from earlier incorrect speculation. For example; =
wasted work due to miss-predicted branches are categorized under Bad Specul=
ation category. Incorrect data speculation followed by Memory Ordering Nuke=
s is another example.",
-        "MetricExpr": "100 * ( (  UOPS_ISSUED.ANY  - (  UOPS_RETIRED.RETIR=
E_SLOTS  ) + ( 4 ) * ( (  INT_MISC.RECOVERY_CYCLES_ANY  / 2 ) if  #SMT_on  =
else  INT_MISC.RECOVERY_CYCLES  ) ) / ( ( 4 ) * ( (  CPU_CLK_UNHALTED.THREA=
D_ANY  / 2 ) if  #SMT_on  else (  CPU_CLK_UNHALTED.THREAD  ) ) ) )",
-        "MetricGroup": "TmaL1",
-        "MetricName": "tma_bad_speculation_percent",
-        "ScaleUnit": "1%"
-    },
-    {
-        "BriefDescription": "This metric represents fraction of slots the =
CPU has wasted due to Branch Misprediction.  These slots are either wasted =
by uops fetched from an incorrectly speculated program path; or stalls when=
 the out-of-order part of the machine needs to recover its state from a spe=
culative path.",
-        "MetricExpr": "100 * ( (  BR_MISP_RETIRED.ALL_BRANCHES  / (  BR_MI=
SP_RETIRED.ALL_BRANCHES  +  MACHINE_CLEARS.COUNT  ) ) * ( (  UOPS_ISSUED.AN=
Y  - (  UOPS_RETIRED.RETIRE_SLOTS  ) + ( 4 ) * ( (  INT_MISC.RECOVERY_CYCLE=
S_ANY  / 2 ) if  #SMT_on  else  INT_MISC.RECOVERY_CYCLES  ) ) / ( ( 4 ) * (=
 (  CPU_CLK_UNHALTED.THREAD_ANY  / 2 ) if  #SMT_on  else (  CPU_CLK_UNHALTE=
D.THREAD  ) ) ) ) )",
-        "MetricGroup": "BadSpec, BrMispredicts, TmaL2",
-        "MetricName": "tma_branch_mispredicts_percent",
-        "ScaleUnit": "1%"
-    },
-    {
-        "BriefDescription": "This metric represents fraction of slots the =
CPU has wasted due to Machine Clears.  These slots are either wasted by uop=
s fetched prior to the clear; or stalls the out-of-order portion of the mac=
hine needs to recover its state after the clear. For example; this can happ=
en due to memory ordering Nukes (e.g. Memory Disambiguation) or Self-Modify=
ing-Code (SMC) nukes.",
-        "MetricExpr": "100 * ( ( (  UOPS_ISSUED.ANY  - (  UOPS_RETIRED.RET=
IRE_SLOTS  ) + ( 4 ) * ( (  INT_MISC.RECOVERY_CYCLES_ANY  / 2 ) if  #SMT_on=
  else  INT_MISC.RECOVERY_CYCLES  ) ) / ( ( 4 ) * ( (  CPU_CLK_UNHALTED.THR=
EAD_ANY  / 2 ) if  #SMT_on  else (  CPU_CLK_UNHALTED.THREAD  ) ) ) ) - ( ( =
 BR_MISP_RETIRED.ALL_BRANCHES  / (  BR_MISP_RETIRED.ALL_BRANCHES  +  MACHIN=
E_CLEARS.COUNT  ) ) * ( (  UOPS_ISSUED.ANY  - (  UOPS_RETIRED.RETIRE_SLOTS =
 ) + ( 4 ) * ( (  INT_MISC.RECOVERY_CYCLES_ANY  / 2 ) if  #SMT_on  else  IN=
T_MISC.RECOVERY_CYCLES  ) ) / ( ( 4 ) * ( (  CPU_CLK_UNHALTED.THREAD_ANY  /=
 2 ) if  #SMT_on  else (  CPU_CLK_UNHALTED.THREAD  ) ) ) ) ) )",
-        "MetricGroup": "BadSpec, MachineClears, TmaL2",
-        "MetricName": "tma_machine_clears_percent",
-        "ScaleUnit": "1%"
-    },
-    {
-        "BriefDescription": "This category represents fraction of slots wh=
ere no uops are being delivered due to a lack of required resources for acc=
epting new uops in the Backend. Backend is the portion of the processor cor=
e where the out-of-order scheduler dispatches ready uops into their respect=
ive execution units; and once completed these uops get retired according to=
 program order. For example; stalls due to data-cache misses or stalls due =
to the divider unit being overloaded are both categorized under Backend Bou=
nd. Backend Bound is further divided into two main categories: Memory Bound=
 and Core Bound.",
-        "MetricExpr": "100 * ( 1 - ( (  IDQ_UOPS_NOT_DELIVERED.CORE  / ( (=
 4 ) * ( (  CPU_CLK_UNHALTED.THREAD_ANY  / 2 ) if  #SMT_on  else (  CPU_CLK=
_UNHALTED.THREAD  ) ) ) ) + ( (  UOPS_ISSUED.ANY  - (  UOPS_RETIRED.RETIRE_=
SLOTS  ) + ( 4 ) * ( (  INT_MISC.RECOVERY_CYCLES_ANY  / 2 ) if  #SMT_on  el=
se  INT_MISC.RECOVERY_CYCLES  ) ) / ( ( 4 ) * ( (  CPU_CLK_UNHALTED.THREAD_=
ANY  / 2 ) if  #SMT_on  else (  CPU_CLK_UNHALTED.THREAD  ) ) ) ) + ( (  UOP=
S_RETIRED.RETIRE_SLOTS  ) / ( ( 4 ) * ( (  CPU_CLK_UNHALTED.THREAD_ANY  / 2=
 ) if  #SMT_on  else (  CPU_CLK_UNHALTED.THREAD  ) ) ) ) ) )",
-        "MetricGroup": "TmaL1",
-        "MetricName": "tma_backend_bound_percent",
-        "ScaleUnit": "1%"
-    },
-    {
-        "BriefDescription": "This metric represents fraction of slots the =
Memory subsystem within the Backend was a bottleneck.  Memory Bound estimat=
es fraction of slots where pipeline is likely stalled due to demand load or=
 store instructions. This accounts mainly for (1) non-completed in-flight m=
emory demand loads which coincides with execution units starvation; in addi=
tion to (2) cases where stores could impose backpressure on the pipeline wh=
en many of them get buffered at the same time (less common out of the two).=
",
-        "MetricExpr": "100 * ( ( ( ( min(  CPU_CLK_UNHALTED.THREAD  ,  CYC=
LE_ACTIVITY.STALLS_LDM_PENDING  ) ) +  RESOURCE_STALLS.SB  ) / ( ( ( min(  =
CPU_CLK_UNHALTED.THREAD  ,  CYCLE_ACTIVITY.CYCLES_NO_EXECUTE  ) ) + (  cpu@=
UOPS_EXECUTED.CORE\\,cmask\\=3D0x1@  - (  cpu@UOPS_EXECUTED.CORE\\,cmask\\=
=3D0x3@  if ( (  INST_RETIRED.ANY  / (  CPU_CLK_UNHALTED.THREAD  ) ) > 1.8 =
) else  cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D0x2@  ) ) / 2 - (  RS_EVENTS.EMP=
TY_CYCLES  if ( ( ( 4 ) * ( min(  CPU_CLK_UNHALTED.THREAD  ,  IDQ_UOPS_NOT_=
DELIVERED.CYCLES_0_UOPS_DELIV.CORE  ) ) / ( ( 4 ) * ( (  CPU_CLK_UNHALTED.T=
HREAD_ANY  / 2 ) if  #SMT_on  else (  CPU_CLK_UNHALTED.THREAD  ) ) ) ) > 0.=
1 ) else 0 ) +  RESOURCE_STALLS.SB  ) if  #SMT_on  else ( ( min(  CPU_CLK_U=
NHALTED.THREAD  ,  CYCLE_ACTIVITY.CYCLES_NO_EXECUTE  ) ) +  cpu@UOPS_EXECUT=
ED.CORE\\,cmask\\=3D0x1@  - (  cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D0x3@  if =
( (  INST_RETIRED.ANY  / (  CPU_CLK_UNHALTED.THREAD  ) ) > 1.8 ) else  cpu@=
UOPS_EXECUTED.CORE\\,cmask\\=3D0x2@  ) - (  RS_EVENTS.EMPTY_CYCLES  if ( ( =
( 4 ) * ( min(  CPU_CLK_UNHALTED.THREAD  ,  IDQ_UOPS_NOT_DELIVERED.CYCLES_0=
_UOPS_DELIV.CORE  ) ) / ( ( 4 ) * ( (  CPU_CLK_UNHALTED.THREAD_ANY  / 2 ) i=
f  #SMT_on  else (  CPU_CLK_UNHALTED.THREAD  ) ) ) ) > 0.1 ) else 0 ) +  RE=
SOURCE_STALLS.SB  ) ) ) * ( 1 - ( (  IDQ_UOPS_NOT_DELIVERED.CORE  / ( ( 4 )=
 * ( (  CPU_CLK_UNHALTED.THREAD_ANY  / 2 ) if  #SMT_on  else (  CPU_CLK_UNH=
ALTED.THREAD  ) ) ) ) + ( (  UOPS_ISSUED.ANY  - (  UOPS_RETIRED.RETIRE_SLOT=
S  ) + ( 4 ) * ( (  INT_MISC.RECOVERY_CYCLES_ANY  / 2 ) if  #SMT_on  else  =
INT_MISC.RECOVERY_CYCLES  ) ) / ( ( 4 ) * ( (  CPU_CLK_UNHALTED.THREAD_ANY =
 / 2 ) if  #SMT_on  else (  CPU_CLK_UNHALTED.THREAD  ) ) ) ) + ( (  UOPS_RE=
TIRED.RETIRE_SLOTS  ) / ( ( 4 ) * ( (  CPU_CLK_UNHALTED.THREAD_ANY  / 2 ) i=
f  #SMT_on  else (  CPU_CLK_UNHALTED.THREAD  ) ) ) ) ) ) )",
-        "MetricGroup": "Backend, TmaL2",
-        "MetricName": "tma_memory_bound_percent",
-        "ScaleUnit": "1%"
-    },
-    {
-        "BriefDescription": "This metric estimates how often the CPU was s=
talled without loads missing the L1 data cache.  The L1 data cache typicall=
y has the shortest latency.  However; in certain cases like loads blocked o=
n older stores; a load might suffer due to high latency even though it is b=
eing satisfied by the L1. Another example is loads who miss in the TLB. The=
se cases are characterized by execution unit stalls; while some non-complet=
ed demand load lives in the machine without having that demand load missing=
 the L1 cache.",
-        "MetricExpr": "100 * ( max( ( ( min(  CPU_CLK_UNHALTED.THREAD  ,  =
CYCLE_ACTIVITY.STALLS_LDM_PENDING  ) ) -  CYCLE_ACTIVITY.STALLS_L1D_PENDING=
  ) / (  CPU_CLK_UNHALTED.THREAD  ) , 0 ) )",
-        "MetricGroup": "CacheMisses, MemoryBound, TmaL3mem",
-        "MetricName": "tma_l1_bound_percent",
-        "ScaleUnit": "1%"
-    },
-    {
-        "BriefDescription": "This metric estimates how often the CPU was s=
talled due to L2 cache accesses by loads.  Avoiding cache misses (i.e. L1 m=
isses/L2 hits) can improve the latency and increase performance.",
-        "MetricExpr": "100 * ( (  CYCLE_ACTIVITY.STALLS_L1D_PENDING  -  CY=
CLE_ACTIVITY.STALLS_L2_PENDING  ) / (  CPU_CLK_UNHALTED.THREAD  ) )",
-        "MetricGroup": "CacheMisses, MemoryBound, TmaL3mem",
-        "MetricName": "tma_l2_bound_percent",
-        "ScaleUnit": "1%"
-    },
-    {
-        "BriefDescription": "This metric estimates how often the CPU was s=
talled due to loads accesses to L3 cache or contended with a sibling Core. =
 Avoiding cache misses (i.e. L2 misses/L3 hits) can improve the latency and=
 increase performance.",
-        "MetricExpr": "100 * ( (  MEM_LOAD_UOPS_RETIRED.L3_HIT  / (  MEM_L=
OAD_UOPS_RETIRED.L3_HIT  + ( 7 ) *  MEM_LOAD_UOPS_RETIRED.L3_MISS  ) ) *  C=
YCLE_ACTIVITY.STALLS_L2_PENDING  / (  CPU_CLK_UNHALTED.THREAD  ) )",
-        "MetricGroup": "CacheMisses, MemoryBound, TmaL3mem",
-        "MetricName": "tma_l3_bound_percent",
-        "ScaleUnit": "1%"
-    },
-    {
-        "BriefDescription": "This metric estimates how often the CPU was s=
talled on accesses to external memory (DRAM) by loads. Better caching can i=
mprove the latency and increase performance.",
-        "MetricExpr": "100 * ( min( ( ( 1 - (  MEM_LOAD_UOPS_RETIRED.L3_HI=
T  / (  MEM_LOAD_UOPS_RETIRED.L3_HIT  + ( 7 ) *  MEM_LOAD_UOPS_RETIRED.L3_M=
ISS  ) ) ) *  CYCLE_ACTIVITY.STALLS_L2_PENDING  / (  CPU_CLK_UNHALTED.THREA=
D  ) ) , ( 1 ) ) )",
-        "MetricGroup": "MemoryBound, TmaL3mem",
-        "MetricName": "tma_drabound_percent",
-        "ScaleUnit": "1%"
-    },
-    {
-        "BriefDescription": "This metric estimates how often CPU was stall=
ed  due to RFO store memory accesses; RFO store issue a read-for-ownership =
request before the write. Even though store accesses do not typically stall=
 out-of-order CPUs; there are few cases where stores can lead to actual sta=
lls. This metric will be flagged should RFO stores be a bottleneck.",
-        "MetricExpr": "100 * (  RESOURCE_STALLS.SB  / (  CPU_CLK_UNHALTED.=
THREAD  ) )",
-        "MetricGroup": "MemoryBound, TmaL3mem",
-        "MetricName": "tma_store_bound_percent",
-        "ScaleUnit": "1%"
-    },
-    {
-        "BriefDescription": "This metric represents fraction of slots wher=
e Core non-memory issues were of a bottleneck.  Shortage in hardware comput=
e resources; or dependencies in software's instructions are both categorize=
d under Core Bound. Hence it may indicate the machine ran out of an out-of-=
order resource; certain execution units are overloaded or dependencies in p=
rogram's data- or instruction-flow are limiting the performance (e.g. FP-ch=
ained long-latency arithmetic operations).",
-        "MetricExpr": "100 * ( ( 1 - ( (  IDQ_UOPS_NOT_DELIVERED.CORE  / (=
 ( 4 ) * ( (  CPU_CLK_UNHALTED.THREAD_ANY  / 2 ) if  #SMT_on  else (  CPU_C=
LK_UNHALTED.THREAD  ) ) ) ) + ( (  UOPS_ISSUED.ANY  - (  UOPS_RETIRED.RETIR=
E_SLOTS  ) + ( 4 ) * ( (  INT_MISC.RECOVERY_CYCLES_ANY  / 2 ) if  #SMT_on  =
else  INT_MISC.RECOVERY_CYCLES  ) ) / ( ( 4 ) * ( (  CPU_CLK_UNHALTED.THREA=
D_ANY  / 2 ) if  #SMT_on  else (  CPU_CLK_UNHALTED.THREAD  ) ) ) ) + ( (  U=
OPS_RETIRED.RETIRE_SLOTS  ) / ( ( 4 ) * ( (  CPU_CLK_UNHALTED.THREAD_ANY  /=
 2 ) if  #SMT_on  else (  CPU_CLK_UNHALTED.THREAD  ) ) ) ) ) ) - ( ( ( ( mi=
n(  CPU_CLK_UNHALTED.THREAD  ,  CYCLE_ACTIVITY.STALLS_LDM_PENDING  ) ) +  R=
ESOURCE_STALLS.SB  ) / ( ( ( min(  CPU_CLK_UNHALTED.THREAD  ,  CYCLE_ACTIVI=
TY.CYCLES_NO_EXECUTE  ) ) + (  cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D0x1@  - (=
  cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D0x3@  if ( (  INST_RETIRED.ANY  / (  C=
PU_CLK_UNHALTED.THREAD  ) ) > 1.8 ) else  cpu@UOPS_EXECUTED.CORE\\,cmask\\=
=3D0x2@  ) ) / 2 - (  RS_EVENTS.EMPTY_CYCLES  if ( ( ( 4 ) * ( min(  CPU_CL=
K_UNHALTED.THREAD  ,  IDQ_UOPS_NOT_DELIVERED.CYCLES_0_UOPS_DELIV.CORE  ) ) =
/ ( ( 4 ) * ( (  CPU_CLK_UNHALTED.THREAD_ANY  / 2 ) if  #SMT_on  else (  CP=
U_CLK_UNHALTED.THREAD  ) ) ) ) > 0.1 ) else 0 ) +  RESOURCE_STALLS.SB  ) if=
  #SMT_on  else ( ( min(  CPU_CLK_UNHALTED.THREAD  ,  CYCLE_ACTIVITY.CYCLES=
_NO_EXECUTE  ) ) +  cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D0x1@  - (  cpu@UOPS_=
EXECUTED.CORE\\,cmask\\=3D0x3@  if ( (  INST_RETIRED.ANY  / (  CPU_CLK_UNHA=
LTED.THREAD  ) ) > 1.8 ) else  cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D0x2@  ) -=
 (  RS_EVENTS.EMPTY_CYCLES  if ( ( ( 4 ) * ( min(  CPU_CLK_UNHALTED.THREAD =
 ,  IDQ_UOPS_NOT_DELIVERED.CYCLES_0_UOPS_DELIV.CORE  ) ) / ( ( 4 ) * ( (  C=
PU_CLK_UNHALTED.THREAD_ANY  / 2 ) if  #SMT_on  else (  CPU_CLK_UNHALTED.THR=
EAD  ) ) ) ) > 0.1 ) else 0 ) +  RESOURCE_STALLS.SB  ) ) ) * ( 1 - ( (  IDQ=
_UOPS_NOT_DELIVERED.CORE  / ( ( 4 ) * ( (  CPU_CLK_UNHALTED.THREAD_ANY  / 2=
 ) if  #SMT_on  else (  CPU_CLK_UNHALTED.THREAD  ) ) ) ) + ( (  UOPS_ISSUED=
.ANY  - (  UOPS_RETIRED.RETIRE_SLOTS  ) + ( 4 ) * ( (  INT_MISC.RECOVERY_CY=
CLES_ANY  / 2 ) if  #SMT_on  else  INT_MISC.RECOVERY_CYCLES  ) ) / ( ( 4 ) =
* ( (  CPU_CLK_UNHALTED.THREAD_ANY  / 2 ) if  #SMT_on  else (  CPU_CLK_UNHA=
LTED.THREAD  ) ) ) ) + ( (  UOPS_RETIRED.RETIRE_SLOTS  ) / ( ( 4 ) * ( (  C=
PU_CLK_UNHALTED.THREAD_ANY  / 2 ) if  #SMT_on  else (  CPU_CLK_UNHALTED.THR=
EAD  ) ) ) ) ) ) ) )",
-        "MetricGroup": "Backend, TmaL2, Compute",
-        "MetricName": "tma_core_bound_percent",
-        "ScaleUnit": "1%"
-    },
-    {
-        "BriefDescription": "This metric represents fraction of cycles whe=
re the Divider unit was active. Divide and square root instructions are per=
formed by the Divider unit and can take considerably longer latency than in=
teger or Floating Point addition; subtraction; or multiplication.",
-        "MetricExpr": "100 * ( 10 *  ARITH.DIVIDER_UOPS  / ( (  CPU_CLK_UN=
HALTED.THREAD_ANY  / 2 ) if  #SMT_on  else (  CPU_CLK_UNHALTED.THREAD  ) ) =
)",
+        "MetricExpr": "100 * cbox@UNC_C_TOR_INSERTS.MISS_REMOTE_OPCODE\\,f=
ilter_opc\\=3D0x182@ / ( cbox@UNC_C_TOR_INSERTS.MISS_LOCAL_OPCODE\\,filter_=
opc\\=3D0x182@ + cbox@UNC_C_TOR_INSERTS.MISS_REMOTE_OPCODE\\,filter_opc\\=
=3D0x182@ )",
         "MetricGroup": "",
-        "MetricName": "tma_divider_percent",
-        "ScaleUnit": "1%"
-    },
-    {
-        "BriefDescription": "This metric estimates fraction of cycles the =
CPU performance was potentially limited due to Core computation issues (non=
 divider-related).  Two distinct categories can be attributed into this met=
ric: (1) heavy data-dependency among contiguous instructions would manifest=
 in this metric - such cases are often referred to as low Instruction Level=
 Parallelism (ILP). (2) Contention on some hardware execution unit other th=
an Divider. For example; when there are too many multiply operations.",
-        "MetricExpr": "100 * ( ( ( ( ( min(  CPU_CLK_UNHALTED.THREAD  ,  C=
YCLE_ACTIVITY.CYCLES_NO_EXECUTE  ) ) + (  cpu@UOPS_EXECUTED.CORE\\,cmask\\=
=3D0x1@  - (  cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D0x3@  if ( (  INST_RETIRED=
.ANY  / (  CPU_CLK_UNHALTED.THREAD  ) ) > 1.8 ) else  cpu@UOPS_EXECUTED.COR=
E\\,cmask\\=3D0x2@  ) ) / 2 - (  RS_EVENTS.EMPTY_CYCLES  if ( ( ( 4 ) * ( m=
in(  CPU_CLK_UNHALTED.THREAD  ,  IDQ_UOPS_NOT_DELIVERED.CYCLES_0_UOPS_DELIV=
.CORE  ) ) / ( ( 4 ) * ( (  CPU_CLK_UNHALTED.THREAD_ANY  / 2 ) if  #SMT_on =
 else (  CPU_CLK_UNHALTED.THREAD  ) ) ) ) > 0.1 ) else 0 ) +  RESOURCE_STAL=
LS.SB  ) if  #SMT_on  else ( ( min(  CPU_CLK_UNHALTED.THREAD  ,  CYCLE_ACTI=
VITY.CYCLES_NO_EXECUTE  ) ) +  cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D0x1@  - (=
  cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D0x3@  if ( (  INST_RETIRED.ANY  / (  C=
PU_CLK_UNHALTED.THREAD  ) ) > 1.8 ) else  cpu@UOPS_EXECUTED.CORE\\,cmask\\=
=3D0x2@  ) - (  RS_EVENTS.EMPTY_CYCLES  if ( ( ( 4 ) * ( min(  CPU_CLK_UNHA=
LTED.THREAD  ,  IDQ_UOPS_NOT_DELIVERED.CYCLES_0_UOPS_DELIV.CORE  ) ) / ( ( =
4 ) * ( (  CPU_CLK_UNHALTED.THREAD_ANY  / 2 ) if  #SMT_on  else (  CPU_CLK_=
UNHALTED.THREAD  ) ) ) ) > 0.1 ) else 0 ) +  RESOURCE_STALLS.SB  ) ) -  RES=
OURCE_STALLS.SB  - ( min(  CPU_CLK_UNHALTED.THREAD  ,  CYCLE_ACTIVITY.STALL=
S_LDM_PENDING  ) ) ) / (  CPU_CLK_UNHALTED.THREAD  ) )",
-        "MetricGroup": "PortsUtil",
-        "MetricName": "tma_ports_utilization_percent",
-        "ScaleUnit": "1%"
-    },
-    {
-        "BriefDescription": "This category represents fraction of slots ut=
ilized by useful work i.e. issued uops that eventually get retired. Ideally=
; all pipeline slots would be attributed to the Retiring category.  Retirin=
g of 100% would indicate the maximum Pipeline_Width throughput was achieved=
.  Maximizing Retiring typically increases the Instructions-per-cycle (see =
IPC metric). Note that a high Retiring value does not necessary mean there =
is no room for more performance.  For example; Heavy-operations or Microcod=
e Assists are categorized under Retiring. They often indicate suboptimal pe=
rformance and can often be optimized or avoided. ",
-        "MetricExpr": "100 * ( (  UOPS_RETIRED.RETIRE_SLOTS  ) / ( ( 4 ) *=
 ( (  CPU_CLK_UNHALTED.THREAD_ANY  / 2 ) if  #SMT_on  else (  CPU_CLK_UNHAL=
TED.THREAD  ) ) ) )",
-        "MetricGroup": "TmaL1",
-        "MetricName": "tma_retiring_percent",
-        "ScaleUnit": "1%"
-    },
-    {
-        "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring light-weight operations -- instructions that require=
 no more than one uop (micro-operation). This correlates with total number =
of instructions used by the program. A uops-per-instruction (see UPI metric=
) ratio of 1 or less should be expected for decently optimized software run=
ning on Intel Core/Xeon products. While this often indicates efficient X86 =
instructions were executed; high value does not necessarily mean better per=
formance cannot be achieved.",
-        "MetricExpr": "100 * ( ( (  UOPS_RETIRED.RETIRE_SLOTS  ) / ( ( 4 )=
 * ( (  CPU_CLK_UNHALTED.THREAD_ANY  / 2 ) if  #SMT_on  else (  CPU_CLK_UNH=
ALTED.THREAD  ) ) ) ) - ( ( ( (  UOPS_RETIRED.RETIRE_SLOTS  ) /  UOPS_ISSUE=
D.ANY  ) *  IDQ.MS_UOPS  / ( ( 4 ) * ( (  CPU_CLK_UNHALTED.THREAD_ANY  / 2 =
) if  #SMT_on  else (  CPU_CLK_UNHALTED.THREAD  ) ) ) ) ) )",
-        "MetricGroup": "Retire, TmaL2",
-        "MetricName": "tma_light_operations_percent",
-        "ScaleUnit": "1%"
-    },
-    {
-        "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring heavy-weight operations -- instructions that require=
 two or more uops or microcoded sequences. This highly-correlates with the =
uop length of these instructions/sequences.",
-        "MetricExpr": "100 * ( ( ( (  UOPS_RETIRED.RETIRE_SLOTS  ) /  UOPS=
_ISSUED.ANY  ) *  IDQ.MS_UOPS  / ( ( 4 ) * ( (  CPU_CLK_UNHALTED.THREAD_ANY=
  / 2 ) if  #SMT_on  else (  CPU_CLK_UNHALTED.THREAD  ) ) ) ) )",
-        "MetricGroup": "Retire, TmaL2",
-        "MetricName": "tma_heavy_operations_percent",
-        "ScaleUnit": "1%"
-    },
-    {
-        "BriefDescription": "This metric represents fraction of slots the =
CPU was retiring uops fetched by the Microcode Sequencer (MS) unit.  The MS=
 is used for CISC instructions not supported by the default decoders (like =
repeat move strings; or CPUID); or by microcode assists used to address som=
e operation modes (like in Floating Point assists). These cases can often b=
e avoided.",
-        "MetricExpr": "100 * ( ( (  UOPS_RETIRED.RETIRE_SLOTS  ) /  UOPS_I=
SSUED.ANY  ) *  IDQ.MS_UOPS  / ( ( 4 ) * ( (  CPU_CLK_UNHALTED.THREAD_ANY  =
/ 2 ) if  #SMT_on  else (  CPU_CLK_UNHALTED.THREAD  ) ) ) )",
-        "MetricGroup": "MicroSeq",
-        "MetricName": "tma_microcode_sequencer_percent",
+        "MetricName": "numa_reads_addressed_to_remote_dram",
         "ScaleUnit": "1%"
     }
 ]
diff --git a/tools/perf/pmu-events/arch/x86/haswellx/uncore-interconnect.js=
on b/tools/perf/pmu-events/arch/x86/haswellx/uncore-interconnect.json
index 3e48ff3516b0..eb0a05fbb704 100644
--- a/tools/perf/pmu-events/arch/x86/haswellx/uncore-interconnect.json
+++ b/tools/perf/pmu-events/arch/x86/haswellx/uncore-interconnect.json
@@ -981,36 +981,34 @@
         "Unit": "QPI LL"
     },
     {
-        "BriefDescription": "Number of data flits transmitted . Derived fr=
om unc_q_txl_flits_g0.data",
+        "BriefDescription": "Flits Transferred - Group 0; Data Tx Flits",
         "Counter": "0,1,2,3",
-        "EventName": "QPI_DATA_BANDWIDTH_TX",
+        "EventName": "UNC_Q_TxL_FLITS_G0.DATA",
         "PerPkg": "1",
-        "ScaleUnit": "8Bytes",
         "UMask": "0x2",
         "Unit": "QPI LL"
     },
     {
-        "BriefDescription": "Number of data flits transmitted ",
+        "BriefDescription": "Number of data flits transmitted . Derived fr=
om unc_q_txl_flits_g0.data",
         "Counter": "0,1,2,3",
-        "EventName": "UNC_Q_TxL_FLITS_G0.DATA",
+        "EventName": "QPI_DATA_BANDWIDTH_TX",
         "PerPkg": "1",
         "ScaleUnit": "8Bytes",
         "UMask": "0x2",
         "Unit": "QPI LL"
     },
     {
-        "BriefDescription": "Number of non data (control) flits transmitte=
d . Derived from unc_q_txl_flits_g0.non_data",
+        "BriefDescription": "Flits Transferred - Group 0; Non-Data protoco=
l Tx Flits",
         "Counter": "0,1,2,3",
-        "EventName": "QPI_CTL_BANDWIDTH_TX",
+        "EventName": "UNC_Q_TxL_FLITS_G0.NON_DATA",
         "PerPkg": "1",
-        "ScaleUnit": "8Bytes",
         "UMask": "0x4",
         "Unit": "QPI LL"
     },
     {
-        "BriefDescription": "Number of non data (control) flits transmitte=
d ",
+        "BriefDescription": "Number of non data (control) flits transmitte=
d . Derived from unc_q_txl_flits_g0.non_data",
         "Counter": "0,1,2,3",
-        "EventName": "UNC_Q_TxL_FLITS_G0.NON_DATA",
+        "EventName": "QPI_CTL_BANDWIDTH_TX",
         "PerPkg": "1",
         "ScaleUnit": "8Bytes",
         "UMask": "0x4",
diff --git a/tools/perf/pmu-events/arch/x86/haswellx/uncore-memory.json b/t=
ools/perf/pmu-events/arch/x86/haswellx/uncore-memory.json
index db3418db312e..c003daa9ed8c 100644
--- a/tools/perf/pmu-events/arch/x86/haswellx/uncore-memory.json
+++ b/tools/perf/pmu-events/arch/x86/haswellx/uncore-memory.json
@@ -72,20 +72,19 @@
         "Unit": "iMC"
     },
     {
-        "BriefDescription": "read requests to memory controller. Derived f=
rom unc_m_cas_count.rd",
+        "BriefDescription": "DRAM RD_CAS and WR_CAS Commands.; All DRAM Re=
ads (RD_CAS + Underfills)",
         "Counter": "0,1,2,3",
         "EventCode": "0x4",
-        "EventName": "LLC_MISSES.MEM_READ",
+        "EventName": "UNC_M_CAS_COUNT.RD",
         "PerPkg": "1",
-        "ScaleUnit": "64Bytes",
         "UMask": "0x3",
         "Unit": "iMC"
     },
     {
-        "BriefDescription": "read requests to memory controller",
+        "BriefDescription": "read requests to memory controller. Derived f=
rom unc_m_cas_count.rd",
         "Counter": "0,1,2,3",
         "EventCode": "0x4",
-        "EventName": "UNC_M_CAS_COUNT.RD",
+        "EventName": "LLC_MISSES.MEM_READ",
         "PerPkg": "1",
         "ScaleUnit": "64Bytes",
         "UMask": "0x3",
@@ -110,20 +109,19 @@
         "Unit": "iMC"
     },
     {
-        "BriefDescription": "write requests to memory controller. Derived =
from unc_m_cas_count.wr",
+        "BriefDescription": "DRAM RD_CAS and WR_CAS Commands.; All DRAM WR=
_CAS (both Modes)",
         "Counter": "0,1,2,3",
         "EventCode": "0x4",
-        "EventName": "LLC_MISSES.MEM_WRITE",
+        "EventName": "UNC_M_CAS_COUNT.WR",
         "PerPkg": "1",
-        "ScaleUnit": "64Bytes",
         "UMask": "0xC",
         "Unit": "iMC"
     },
     {
-        "BriefDescription": "write requests to memory controller",
+        "BriefDescription": "write requests to memory controller. Derived =
from unc_m_cas_count.wr",
         "Counter": "0,1,2,3",
         "EventCode": "0x4",
-        "EventName": "UNC_M_CAS_COUNT.WR",
+        "EventName": "LLC_MISSES.MEM_WRITE",
         "PerPkg": "1",
         "ScaleUnit": "64Bytes",
         "UMask": "0xC",
diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-ev=
ents/arch/x86/mapfile.csv
index 63a0e98fd116..ddc9fc8b7171 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -9,7 +9,7 @@ GenuineIntel-6-9[6C],v1.03,elkhartlake,core
 GenuineIntel-6-5[CF],v13,goldmont,core
 GenuineIntel-6-7A,v1.01,goldmontplus,core
 GenuineIntel-6-(3C|45|46),v32,haswell,core
-GenuineIntel-6-3F,v25,haswellx,core
+GenuineIntel-6-3F,v26,haswellx,core
 GenuineIntel-6-(7D|7E|A7),v1.14,icelake,core
 GenuineIntel-6-6[AC],v1.15,icelakex,core
 GenuineIntel-6-3A,v22,ivybridge,core
--=20
2.38.0.rc1.362.ged0d419d3c-goog

