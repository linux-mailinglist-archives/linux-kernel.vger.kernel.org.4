Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B50BB5ED602
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 09:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233633AbiI1H0V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 03:26:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbiI1HZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 03:25:05 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5D29E05F3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 00:23:13 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-3538689fc60so6163267b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 00:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date;
        bh=LsVk6401kd9oKyAiPPm0Nchj764xcYZ+XeTYR8tydfw=;
        b=C12WPdtnLFhkJCGhCWjUZ+OfKBl+Zo34ygcsojkHHFtcmn8W3TOAyrZv3EDwxClQ+R
         HyIL2zUG67/J+jX//eAxW9WTGq+u25SDhUmDKbWPmOHiojX3GxMs7Yau15z3ZcpBdtsT
         XvcRBtZcBqUlB+j6zEEmGm55OWmihZTDcCGjVL85e1/oS/aNfHl5QDVLAVf0A99gaPAe
         ZsNWzqTc4e/uaMr2njMFLR11cWTGZWcXPxWS3+uDt0W0qyfd33k/8j2Mwcaf7k4c9mJv
         kjk61SKOErJ1xJM+RdF24Lo7+bOyl2QtnlkTzG854X704h0iAGhyksrTbyuldeob3i+W
         Fsxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date;
        bh=LsVk6401kd9oKyAiPPm0Nchj764xcYZ+XeTYR8tydfw=;
        b=nSbse24Hz/cRQzNaOMB9qBz26xSwpKsjtshn6a4hGTFhaiuzLsbhyjRchWvCrHaROc
         zgcVLAFeVDclWvR37KmruWkWulP1t0TFbPM4NuSZgcRbv/WOLDTQw/QiSqczLNnUL0Q7
         9WiUQlhxs7NTIoS3zuRX7mlRpPr/lP7513Tdk8xe5pzj0U/icuj5Bx0oSxFuS25jH8bx
         5zA9VtizUCklxSUDeMPkbIVSZh22d6roWRmF2zuYUgEahYB6xY+rqw2g2rmBaA8RQdJD
         sf8+wX/NWuyWWqP1Ud5I1Oeu/KTxSp4SIddG+fSyNr/wDHHH2kNR+R8eAZQsmeiMCeKa
         HOyw==
X-Gm-Message-State: ACrzQf0oYyF3IPdZHUCaIHokNTdX9JW9Q0yUn36TMzUOn+K20LZmP5a+
        uku3tx+Jk6/x9fVdUE1NmJxmfIrV1x7+
X-Google-Smtp-Source: AMsMyM7xqKK43se/X5kfJA43fqThfFLzo30P0SoEvHVvIrWIrqNifu4n6TgO89/MHQchZueFPLy8/A3jl7sf
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:7099:1ccb:612a:5ad6])
 (user=irogers job=sendgmr) by 2002:a25:3b04:0:b0:6a7:6d30:966d with SMTP id
 i4-20020a253b04000000b006a76d30966dmr29554694yba.146.1664349777549; Wed, 28
 Sep 2022 00:22:57 -0700 (PDT)
Date:   Wed, 28 Sep 2022 00:22:00 -0700
In-Reply-To: <20220928072204.1613330-1-irogers@google.com>
Message-Id: <20220928072204.1613330-19-irogers@google.com>
Mime-Version: 1.0
References: <20220928072204.1613330-1-irogers@google.com>
X-Mailer: git-send-email 2.37.3.998.g577e59143f-goog
Subject: [PATCH v1 18/22] perf vendor events: Update Intel sapphirerapids
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

Events are updated to v1.06 the core metrics are based on TMA 4.4 full.

Use script at:
https://github.com/intel/event-converter-for-linux-perf/blob/master/downloa=
d_and_gen.py
with updates at:
https://github.com/captain5050/event-converter-for-linux-perf

Updates include:
 - Rename of topdown TMA metrics from Frontend_Bound to tma_frontend_bound.
 - Addition of all 6 levels of TMA metrics. Previously metrics
   involving topdown events were dropped. Child metrics are placed in
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
 tools/perf/pmu-events/arch/x86/mapfile.csv    |   2 +-
 .../arch/x86/sapphirerapids/cache.json        |   4 +-
 .../arch/x86/sapphirerapids/frontend.json     |  11 +
 .../arch/x86/sapphirerapids/pipeline.json     |   4 +-
 .../arch/x86/sapphirerapids/spr-metrics.json  | 858 ++++++++++++++++--
 5 files changed, 807 insertions(+), 72 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-ev=
ents/arch/x86/mapfile.csv
index 80acb5fb722c..298ebda0c439 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -20,7 +20,7 @@ GenuineIntel-6-AA,v1.00,meteorlake,core
 GenuineIntel-6-1[AEF],v3,nehalemep,core
 GenuineIntel-6-2E,v3,nehalemex,core
 GenuineIntel-6-2A,v17,sandybridge,core
-GenuineIntel-6-8F,v1.04,sapphirerapids,core
+GenuineIntel-6-8F,v1.06,sapphirerapids,core
 GenuineIntel-6-(37|4C|4D),v14,silvermont,core
 GenuineIntel-6-(4E|5E|8E|9E|A5|A6),v53,skylake,core
 GenuineIntel-6-55-[01234],v1.28,skylakex,core
diff --git a/tools/perf/pmu-events/arch/x86/sapphirerapids/cache.json b/too=
ls/perf/pmu-events/arch/x86/sapphirerapids/cache.json
index 348476ce8107..c05c741e22db 100644
--- a/tools/perf/pmu-events/arch/x86/sapphirerapids/cache.json
+++ b/tools/perf/pmu-events/arch/x86/sapphirerapids/cache.json
@@ -35,7 +35,7 @@
         "UMask": "0x2"
     },
     {
-        "BriefDescription": "Number of phases a demand request has waited =
due to L1D Fill Buffer (FB) unavailablability.",
+        "BriefDescription": "Number of phases a demand request has waited =
due to L1D Fill Buffer (FB) unavailability.",
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3",
         "CounterMask": "1",
@@ -43,7 +43,7 @@
         "EventCode": "0x48",
         "EventName": "L1D_PEND_MISS.FB_FULL_PERIODS",
         "PEBScounters": "0,1,2,3",
-        "PublicDescription": "Counts number of phases a demand request has=
 waited due to L1D Fill Buffer (FB) unavailablability. Demand requests incl=
ude cacheable/uncacheable demand load, store, lock or SW prefetch accesses.=
",
+        "PublicDescription": "Counts number of phases a demand request has=
 waited due to L1D Fill Buffer (FB) unavailability. Demand requests include=
 cacheable/uncacheable demand load, store, lock or SW prefetch accesses.",
         "SampleAfterValue": "1000003",
         "Speculative": "1",
         "UMask": "0x2"
diff --git a/tools/perf/pmu-events/arch/x86/sapphirerapids/frontend.json b/=
tools/perf/pmu-events/arch/x86/sapphirerapids/frontend.json
index 44ecf38ad970..ff0d47ce8e9a 100644
--- a/tools/perf/pmu-events/arch/x86/sapphirerapids/frontend.json
+++ b/tools/perf/pmu-events/arch/x86/sapphirerapids/frontend.json
@@ -11,6 +11,17 @@
         "Speculative": "1",
         "UMask": "0x1"
     },
+    {
+        "BriefDescription": "Cycles the Microcode Sequencer is busy.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x87",
+        "EventName": "DECODE.MS_BUSY",
+        "PEBScounters": "0,1,2,3",
+        "SampleAfterValue": "500009",
+        "Speculative": "1",
+        "UMask": "0x2"
+    },
     {
         "BriefDescription": "DSB-to-MITE switch true penalty cycles.",
         "CollectPEBSRecord": "2",
diff --git a/tools/perf/pmu-events/arch/x86/sapphirerapids/pipeline.json b/=
tools/perf/pmu-events/arch/x86/sapphirerapids/pipeline.json
index df4f3d714e6e..b2f0d9393d3c 100644
--- a/tools/perf/pmu-events/arch/x86/sapphirerapids/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/sapphirerapids/pipeline.json
@@ -80,10 +80,10 @@
         "EventCode": "0xc1",
         "EventName": "ASSISTS.ANY",
         "PEBScounters": "0,1,2,3,4,5,6,7",
-        "PublicDescription": "Counts the number of occurrences where a mic=
rocode assist is invoked by hardware Examples include AD (page Access Dirty=
), FP and AVX related assists.",
+        "PublicDescription": "Counts the number of occurrences where a mic=
rocode assist is invoked by hardware. Examples include AD (page Access Dirt=
y), FP and AVX related assists.",
         "SampleAfterValue": "100003",
         "Speculative": "1",
-        "UMask": "0x1f"
+        "UMask": "0x1b"
     },
     {
         "BriefDescription": "All branch instructions retired.",
diff --git a/tools/perf/pmu-events/arch/x86/sapphirerapids/spr-metrics.json=
 b/tools/perf/pmu-events/arch/x86/sapphirerapids/spr-metrics.json
index e194dfc5c25b..7fc52935d447 100644
--- a/tools/perf/pmu-events/arch/x86/sapphirerapids/spr-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/sapphirerapids/spr-metrics.json
@@ -1,16 +1,716 @@
 [
+    {
+        "BriefDescription": "This category represents fraction of slots wh=
ere the processor's Frontend undersupplies its Backend",
+        "MetricExpr": "topdown\\-fe\\-bound / (topdown\\-fe\\-bound + topd=
own\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) - INT_MISC.UO=
P_DROPPING / SLOTS",
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
ache misses would be categorized under Frontend Bound. Sample with: FRONTEN=
D_RETIRED.LATENCY_GE_4_PS"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of slots the =
CPU was stalled due to Frontend latency issues",
+        "MetricExpr": "(topdown\\-fetch\\-lat / (topdown\\-fe\\-bound + to=
pdown\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) - INT_MISC.=
UOP_DROPPING / SLOTS)",
+        "MetricGroup": "Frontend;TopdownL2;tma_L2_group;tma_frontend_bound=
_group",
+        "MetricName": "tma_fetch_latency",
+        "PublicDescription": "This metric represents fraction of slots the=
 CPU was stalled due to Frontend latency issues.  For example; instruction-=
cache misses; iTLB misses or fetch stalls after a branch misprediction are =
categorized under Frontend Latency. In such cases; the Frontend eventually =
delivers no uops for some period. Sample with: FRONTEND_RETIRED.LATENCY_GE_=
16_PS;FRONTEND_RETIRED.LATENCY_GE_8_PS"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to instruction cache misses",
+        "MetricExpr": "ICACHE_DATA.STALLS / CLKS",
+        "MetricGroup": "BigFoot;FetchLat;IcMiss;TopdownL3;tma_fetch_latenc=
y_group",
+        "MetricName": "tma_icache_misses",
+        "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to instruction cache misses. Sample with: FRONTEND_RE=
TIRED.L2_MISS_PS;FRONTEND_RETIRED.L1I_MISS_PS"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to Instruction TLB (ITLB) misses",
+        "MetricExpr": "ICACHE_TAG.STALLS / CLKS",
+        "MetricGroup": "BigFoot;FetchLat;MemoryTLB;TopdownL3;tma_fetch_lat=
ency_group",
+        "MetricName": "tma_itlb_misses",
+        "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to Instruction TLB (ITLB) misses. Sample with: FRONTE=
ND_RETIRED.STLB_MISS_PS;FRONTEND_RETIRED.ITLB_MISS_PS"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to Branch Resteers",
+        "MetricExpr": "INT_MISC.CLEAR_RESTEER_CYCLES / CLKS + tma_unknown_=
branches",
+        "MetricGroup": "FetchLat;TopdownL3;tma_fetch_latency_group",
+        "MetricName": "tma_branch_resteers",
+        "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to Branch Resteers. Branch Resteers estimates the Fro=
ntend delay in fetching operations from corrected path; following all sorts=
 of miss-predicted branches. For example; branchy code with lots of miss-pr=
edictions might get categorized under Branch Resteers. Note the value of th=
is node may overlap with its siblings. Sample with: BR_MISP_RETIRED.ALL_BRA=
NCHES"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to Branch Resteers as a result of Branch Misprediction=
 at execution stage",
+        "MetricExpr": "(tma_branch_mispredicts / tma_bad_speculation) * IN=
T_MISC.CLEAR_RESTEER_CYCLES / CLKS",
+        "MetricGroup": "BadSpec;BrMispredicts;TopdownL4;tma_branch_resteer=
s_group",
+        "MetricName": "tma_mispredicts_resteers",
+        "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to Branch Resteers as a result of Branch Mispredictio=
n at execution stage.  Sample with: INT_MISC.CLEAR_RESTEER_CYCLES"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to Branch Resteers as a result of Machine Clears",
+        "MetricExpr": "(1 - (tma_branch_mispredicts / tma_bad_speculation)=
) * INT_MISC.CLEAR_RESTEER_CYCLES / CLKS",
+        "MetricGroup": "BadSpec;MachineClears;TopdownL4;tma_branch_resteer=
s_group",
+        "MetricName": "tma_clears_resteers",
+        "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to Branch Resteers as a result of Machine Clears.  Sa=
mple with: INT_MISC.CLEAR_RESTEER_CYCLES"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to new branch address clears",
+        "MetricExpr": "INT_MISC.UNKNOWN_BRANCH_CYCLES / CLKS",
+        "MetricGroup": "BigFoot;FetchLat;TopdownL4;tma_branch_resteers_gro=
up",
+        "MetricName": "tma_unknown_branches",
+        "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to new branch address clears. These are fetched branc=
hes the Branch Prediction Unit was unable to recognize (First fetch or hitt=
ing BPU capacity limit). Sample with: FRONTEND_RETIRED.UNKNOWN_BRANCH"
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
 this metric measures the exposed penalty. Sample with: FRONTEND_RETIRED.DS=
B_MISS_PS"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of cycles CPU=
 was stalled due to Length Changing Prefixes (LCPs)",
+        "MetricExpr": "DECODE.LCP / CLKS",
+        "MetricGroup": "FetchLat;TopdownL3;tma_fetch_latency_group",
+        "MetricName": "tma_lcp",
+        "PublicDescription": "This metric represents fraction of cycles CP=
U was stalled due to Length Changing Prefixes (LCPs). Using proper compiler=
 flags or Intel Compiler by default will certainly avoid this. #Link: Optim=
ization Guide about LCP BKMs."
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
with Denormals. Sample with: FRONTEND_RETIRED.MS_FLOWS"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of slots the =
CPU was stalled due to Frontend bandwidth issues",
+        "MetricExpr": "max(0, tma_frontend_bound - tma_fetch_latency)",
+        "MetricGroup": "FetchBW;Frontend;TopdownL2;tma_L2_group;tma_fronte=
nd_bound_group",
+        "MetricName": "tma_fetch_bandwidth",
+        "PublicDescription": "This metric represents fraction of slots the=
 CPU was stalled due to Frontend bandwidth issues.  For example; inefficien=
cies at the instruction decoders; or restrictions for caching in the DSB (d=
ecoded uops cache) are categorized under Fetch Bandwidth. In such cases; th=
e Frontend typically delivers suboptimal amount of uops to the Backend. Sam=
ple with: FRONTEND_RETIRED.LATENCY_GE_2_BUBBLES_GE_1_PS;FRONTEND_RETIRED.LA=
TENCY_GE_1_PS;FRONTEND_RETIRED.LATENCY_GE_2_PS"
+    },
+    {
+        "BriefDescription": "This metric represents Core fraction of cycle=
s in which CPU was likely limited due to the MITE pipeline (the legacy deco=
de pipeline)",
+        "MetricExpr": "(IDQ.MITE_CYCLES_ANY - IDQ.MITE_CYCLES_OK) / CORE_C=
LKS / 2",
+        "MetricGroup": "DSBmiss;FetchBW;TopdownL3;tma_fetch_bandwidth_grou=
p",
+        "MetricName": "tma_mite",
+        "PublicDescription": "This metric represents Core fraction of cycl=
es in which CPU was likely limited due to the MITE pipeline (the legacy dec=
ode pipeline). This pipeline is used for code that was not pre-cached in th=
e DSB or LSD. For example; inefficiencies due to asymmetric decoders; use o=
f long immediate or LCP can manifest as MITE fetch bandwidth bottleneck. Sa=
mple with: FRONTEND_RETIRED.ANY_DSB_MISS"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of cycles whe=
re decoder-0 was the only active decoder",
+        "MetricExpr": "(cpu@INST_DECODED.DECODERS\\,cmask\\=3D1@ - cpu@INS=
T_DECODED.DECODERS\\,cmask\\=3D2@) / CORE_CLKS",
+        "MetricGroup": "DSBmiss;FetchBW;TopdownL4;tma_mite_group",
+        "MetricName": "tma_decoder0_alone"
+    },
+    {
+        "BriefDescription": "This metric represents Core fraction of cycle=
s in which CPU was likely limited due to DSB (decoded uop cache) fetch pipe=
line",
+        "MetricExpr": "(IDQ.DSB_CYCLES_ANY - IDQ.DSB_CYCLES_OK) / CORE_CLK=
S / 2",
+        "MetricGroup": "DSB;FetchBW;TopdownL3;tma_fetch_bandwidth_group",
+        "MetricName": "tma_dsb",
+        "PublicDescription": "This metric represents Core fraction of cycl=
es in which CPU was likely limited due to DSB (decoded uop cache) fetch pip=
eline.  For example; inefficient utilization of the DSB cache structure or =
bank conflict when reading from it; are categorized here."
+    },
+    {
+        "BriefDescription": "This category represents fraction of slots wa=
sted due to incorrect speculations",
+        "MetricExpr": "max(1 - (tma_frontend_bound + tma_backend_bound + t=
ma_retiring), 0)",
+        "MetricGroup": "TopdownL1;tma_L1_group",
+        "MetricName": "tma_bad_speculation",
+        "PublicDescription": "This category represents fraction of slots w=
asted due to incorrect speculations. This include slots used to issue uops =
that do not eventually get retired and slots for which the issue-pipeline w=
as blocked due to recovery from earlier incorrect speculation. For example;=
 wasted work due to miss-predicted branches are categorized under Bad Specu=
lation category. Incorrect data speculation followed by Memory Ordering Nuk=
es is another example."
+    },
+    {
+        "BriefDescription": "This metric represents fraction of slots the =
CPU has wasted due to Branch Misprediction",
+        "MetricExpr": "topdown\\-br\\-mispredict / (topdown\\-fe\\-bound +=
 topdown\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound)",
+        "MetricGroup": "BadSpec;BrMispredicts;TopdownL2;tma_L2_group;tma_b=
ad_speculation_group",
+        "MetricName": "tma_branch_mispredicts",
+        "PublicDescription": "This metric represents fraction of slots the=
 CPU has wasted due to Branch Misprediction.  These slots are either wasted=
 by uops fetched from an incorrectly speculated program path; or stalls whe=
n the out-of-order part of the machine needs to recover its state from a sp=
eculative path. Sample with: TOPDOWN.BR_MISPREDICT_SLOTS"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of slots the =
CPU has wasted due to Machine Clears",
+        "MetricExpr": "max(0, tma_bad_speculation - tma_branch_mispredicts=
)",
+        "MetricGroup": "BadSpec;MachineClears;TopdownL2;tma_L2_group;tma_b=
ad_speculation_group",
+        "MetricName": "tma_machine_clears",
+        "PublicDescription": "This metric represents fraction of slots the=
 CPU has wasted due to Machine Clears.  These slots are either wasted by uo=
ps fetched prior to the clear; or stalls the out-of-order portion of the ma=
chine needs to recover its state after the clear. For example; this can hap=
pen due to memory ordering Nukes (e.g. Memory Disambiguation) or Self-Modif=
ying-Code (SMC) nukes. Sample with: MACHINE_CLEARS.COUNT"
+    },
+    {
+        "BriefDescription": "This category represents fraction of slots wh=
ere no uops are being delivered due to a lack of required resources for acc=
epting new uops in the Backend",
+        "MetricExpr": "topdown\\-be\\-bound / (topdown\\-fe\\-bound + topd=
own\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound)",
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
d and Core Bound. Sample with: TOPDOWN.BACKEND_BOUND_SLOTS"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of slots the =
Memory subsystem within the Backend was a bottleneck",
+        "MetricExpr": "topdown\\-mem\\-bound / (topdown\\-fe\\-bound + top=
down\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound)",
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
."
+    },
+    {
+        "BriefDescription": "This metric estimates how often the CPU was s=
talled without loads missing the L1 data cache",
+        "MetricExpr": "max((EXE_ACTIVITY.BOUND_ON_LOADS - MEMORY_ACTIVITY.=
STALLS_L1D_MISS) / CLKS, 0)",
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
g the L1 cache. Sample with: MEM_LOAD_RETIRED.L1_HIT_PS;MEM_LOAD_RETIRED.FB=
_HIT_PS"
+    },
+    {
+        "BriefDescription": "This metric roughly estimates the fraction of=
 cycles where the Data TLB (DTLB) was missed by load accesses",
+        "MetricExpr": "min(7 * cpu@DTLB_LOAD_MISSES.STLB_HIT\\,cmask\\=3D1=
@ + DTLB_LOAD_MISSES.WALK_ACTIVE, max(CYCLE_ACTIVITY.CYCLES_MEM_ANY - MEMOR=
Y_ACTIVITY.CYCLES_L1D_MISS, 0)) / CLKS",
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
 miss. Sample with: MEM_INST_RETIRED.STLB_MISS_LOADS_PS"
+    },
+    {
+        "BriefDescription": "This metric roughly estimates the fraction of=
 cycles where the (first level) DTLB was missed by load accesses, that late=
r on hit in second-level TLB (STLB)",
+        "MetricExpr": "tma_dtlb_load - tma_load_stlb_miss",
+        "MetricGroup": "MemoryTLB;TopdownL5;tma_dtlb_load_group",
+        "MetricName": "tma_load_stlb_hit"
+    },
+    {
+        "BriefDescription": "This metric estimates the fraction of cycles =
where the Second-level TLB (STLB) was missed by load accesses, performing a=
 hardware page walk",
+        "MetricExpr": "DTLB_LOAD_MISSES.WALK_ACTIVE / CLKS",
+        "MetricGroup": "MemoryTLB;TopdownL5;tma_dtlb_load_group",
+        "MetricName": "tma_load_stlb_miss"
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
ore is writing a smaller region than the load is reading."
+    },
+    {
+        "BriefDescription": "This metric represents fraction of cycles the=
 CPU spent handling cache misses due to lock operations",
+        "MetricExpr": "(16 * max(0, MEM_INST_RETIRED.LOCK_LOADS - L2_RQSTS=
.ALL_RFO) + (MEM_INST_RETIRED.LOCK_LOADS / MEM_INST_RETIRED.ALL_STORES) * (=
10 * L2_RQSTS.RFO_HIT + min(CPU_CLK_UNHALTED.THREAD, OFFCORE_REQUESTS_OUTST=
ANDING.CYCLES_WITH_DEMAND_RFO))) / CLKS",
+        "MetricGroup": "Offcore;TopdownL4;tma_l1_bound_group",
+        "MetricName": "tma_lock_latency",
+        "PublicDescription": "This metric represents fraction of cycles th=
e CPU spent handling cache misses due to lock operations. Due to the microa=
rchitecture handling of locks; they are classified as L1_Bound regardless o=
f what memory source satisfied them. Sample with: MEM_INST_RETIRED.LOCK_LOA=
DS_PS"
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
ary.  Sample with: MEM_INST_RETIRED.SPLIT_LOADS_PS"
+    },
+    {
+        "BriefDescription": "This metric does a *rough estimation* of how =
often L1D Fill Buffer unavailability limited additional L1D miss memory acc=
ess requests to proceed",
+        "MetricExpr": "L1D_PEND_MISS.FB_FULL / CLKS",
+        "MetricGroup": "MemoryBW;TopdownL4;tma_l1_bound_group",
+        "MetricName": "tma_fb_full",
+        "PublicDescription": "This metric does a *rough estimation* of how=
 often L1D Fill Buffer unavailability limited additional L1D miss memory ac=
cess requests to proceed. The higher the metric value; the deeper the memor=
y hierarchy level the misses are satisfied from (metric values >1 are valid=
). Often it hints on approaching bandwidth limits (to L2 cache; L3 cache or=
 external memory)."
+    },
+    {
+        "BriefDescription": "This metric estimates how often the CPU was s=
talled due to L2 cache accesses by loads",
+        "MetricExpr": "(MEMORY_ACTIVITY.STALLS_L1D_MISS - MEMORY_ACTIVITY.=
STALLS_L2_MISS) / CLKS",
+        "MetricGroup": "CacheMisses;MemoryBound;TmaL3mem;TopdownL3;tma_mem=
ory_bound_group",
+        "MetricName": "tma_l2_bound",
+        "PublicDescription": "This metric estimates how often the CPU was =
stalled due to L2 cache accesses by loads.  Avoiding cache misses (i.e. L1 =
misses/L2 hits) can improve the latency and increase performance. Sample wi=
th: MEM_LOAD_RETIRED.L2_HIT_PS"
+    },
+    {
+        "BriefDescription": "This metric estimates how often the CPU was s=
talled due to loads accesses to L3 cache or contended with a sibling Core",
+        "MetricExpr": "(MEMORY_ACTIVITY.STALLS_L2_MISS - MEMORY_ACTIVITY.S=
TALLS_L3_MISS) / CLKS",
+        "MetricGroup": "CacheMisses;MemoryBound;TmaL3mem;TopdownL3;tma_mem=
ory_bound_group",
+        "MetricName": "tma_l3_bound",
+        "PublicDescription": "This metric estimates how often the CPU was =
stalled due to loads accesses to L3 cache or contended with a sibling Core.=
  Avoiding cache misses (i.e. L2 misses/L3 hits) can improve the latency an=
d increase performance. Sample with: MEM_LOAD_RETIRED.L3_HIT_PS"
+    },
+    {
+        "BriefDescription": "This metric estimates fraction of cycles whil=
e the memory subsystem was handling synchronizations due to contested acces=
ses",
+        "MetricExpr": "((25 * Average_Frequency) * (MEM_LOAD_L3_HIT_RETIRE=
D.XSNP_FWD * (OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HITM / (OCR.DEMAND_DATA_RD.L3=
_HIT.SNOOP_HITM + OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HIT_WITH_FWD))) + (24 * A=
verage_Frequency) * MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS) * (1 + (MEM_LOAD_RET=
IRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS) / 2) / CLKS",
+        "MetricGroup": "DataSharing;Offcore;Snoop;TopdownL4;tma_l3_bound_g=
roup",
+        "MetricName": "tma_contested_accesses",
+        "PublicDescription": "This metric estimates fraction of cycles whi=
le the memory subsystem was handling synchronizations due to contested acce=
sses. Contested accesses occur when data written by one Logical Processor a=
re read by another Logical Processor on a different Physical Core. Examples=
 of contested accesses include synchronizations such as locks; true data sh=
aring such as modified locked variables; and false sharing. Sample with: ME=
M_LOAD_L3_HIT_RETIRED.XSNP_FWD;MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS"
+    },
+    {
+        "BriefDescription": "This metric estimates fraction of cycles whil=
e the memory subsystem was handling synchronizations due to data-sharing ac=
cesses",
+        "MetricExpr": "(24 * Average_Frequency) * (MEM_LOAD_L3_HIT_RETIRED=
.XSNP_NO_FWD + MEM_LOAD_L3_HIT_RETIRED.XSNP_FWD * (1 - (OCR.DEMAND_DATA_RD.=
L3_HIT.SNOOP_HITM / (OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HITM + OCR.DEMAND_DATA=
_RD.L3_HIT.SNOOP_HIT_WITH_FWD)))) * (1 + (MEM_LOAD_RETIRED.FB_HIT / MEM_LOA=
D_RETIRED.L1_MISS) / 2) / CLKS",
+        "MetricGroup": "Offcore;Snoop;TopdownL4;tma_l3_bound_group",
+        "MetricName": "tma_data_sharing",
+        "PublicDescription": "This metric estimates fraction of cycles whi=
le the memory subsystem was handling synchronizations due to data-sharing a=
ccesses. Data shared by multiple Logical Processors (even just read shared)=
 may cause increased access latency due to cache coherency. Excessive data =
sharing can drastically harm multithreaded performance. Sample with: MEM_LO=
AD_L3_HIT_RETIRED.XSNP_NO_FWD"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of cycles wit=
h demand load accesses that hit the L3 cache under unloaded scenarios (poss=
ibly L3 latency limited)",
+        "MetricExpr": "(9 * Average_Frequency) * MEM_LOAD_RETIRED.L3_HIT *=
 (1 + (MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS) / 2) / CLKS",
+        "MetricGroup": "MemoryLat;TopdownL4;tma_l3_bound_group",
+        "MetricName": "tma_l3_hit_latency",
+        "PublicDescription": "This metric represents fraction of cycles wi=
th demand load accesses that hit the L3 cache under unloaded scenarios (pos=
sibly L3 latency limited).  Avoiding private cache misses (i.e. L2 misses/L=
3 hits) will improve the latency; reduce contention with sibling physical c=
ores and increase performance.  Note the value of this node may overlap wit=
h its siblings. Sample with: MEM_LOAD_RETIRED.L3_HIT_PS"
+    },
+    {
+        "BriefDescription": "This metric measures fraction of cycles where=
 the Super Queue (SQ) was full taking into account all request-types and bo=
th hardware SMT threads (Logical Processors)",
+        "MetricExpr": "(XQ.FULL_CYCLES + L1D_PEND_MISS.L2_STALLS) / CLKS",
+        "MetricGroup": "MemoryBW;Offcore;TopdownL4;tma_l3_bound_group",
+        "MetricName": "tma_sq_full",
+        "PublicDescription": "This metric measures fraction of cycles wher=
e the Super Queue (SQ) was full taking into account all request-types and b=
oth hardware SMT threads (Logical Processors). The Super Queue is used for =
requests to access the L2 cache or to go out to the Uncore."
+    },
+    {
+        "BriefDescription": "This metric estimates how often the CPU was s=
talled on accesses to external memory (DRAM) by loads",
+        "MetricExpr": "((MEMORY_ACTIVITY.STALLS_L3_MISS / CLKS) - tma_pmm_=
bound)",
+        "MetricGroup": "MemoryBound;TmaL3mem;TopdownL3;tma_memory_bound_gr=
oup",
+        "MetricName": "tma_dram_bound",
+        "PublicDescription": "This metric estimates how often the CPU was =
stalled on accesses to external memory (DRAM) by loads. Better caching can =
improve the latency and increase performance. Sample with: MEM_LOAD_RETIRED=
.L3_MISS_PS"
+    },
+    {
+        "BriefDescription": "This metric estimates fraction of cycles wher=
e the core's performance was likely hurt due to approaching bandwidth limit=
s of external memory (DRAM)",
+        "MetricExpr": "min(CPU_CLK_UNHALTED.THREAD, cpu@OFFCORE_REQUESTS_O=
UTSTANDING.ALL_DATA_RD\\,cmask\\=3D4@) / CLKS",
+        "MetricGroup": "MemoryBW;Offcore;TopdownL4;tma_dram_bound_group",
+        "MetricName": "tma_mem_bandwidth",
+        "PublicDescription": "This metric estimates fraction of cycles whe=
re the core's performance was likely hurt due to approaching bandwidth limi=
ts of external memory (DRAM).  The underlying heuristic assumes that a simi=
lar off-core traffic is generated by all IA cores. This metric does not agg=
regate non-data-read requests by this logical processor; requests from othe=
r IA Logical Processors/Physical Cores/sockets; or other non-IA devices lik=
e GPU; hence the maximum external memory bandwidth limits may or may not be=
 approached when this metric is flagged (see Uncore counters for that)."
+    },
+    {
+        "BriefDescription": "This metric estimates fraction of cycles wher=
e the core's performance was likely hurt due to memory bandwidth Allocation=
 feature (RDT's memory bandwidth throttling).",
+        "MetricExpr": "INT_MISC.MBA_STALLS / CLKS",
+        "MetricGroup": "MemoryBW;Offcore;Server;TopdownL5;tma_mem_bandwidt=
h_group",
+        "MetricName": "tma_mba_stalls"
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
Physical Cores/sockets (see Uncore counters for that)."
+    },
+    {
+        "BriefDescription": "This metric estimates fraction of cycles whil=
e the memory subsystem was handling loads from local memory",
+        "MetricExpr": "(54.5 * Average_Frequency) * MEM_LOAD_L3_MISS_RETIR=
ED.LOCAL_DRAM * (1 + (MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS) /=
 2) / CLKS",
+        "MetricGroup": "Server;TopdownL5;tma_mem_latency_group",
+        "MetricName": "tma_local_dram",
+        "PublicDescription": "This metric estimates fraction of cycles whi=
le the memory subsystem was handling loads from local memory. Caching will =
improve the latency and increase performance. Sample with: MEM_LOAD_L3_MISS=
_RETIRED.LOCAL_DRAM_PS"
+    },
+    {
+        "BriefDescription": "This metric estimates fraction of cycles whil=
e the memory subsystem was handling loads from remote memory",
+        "MetricExpr": "(119 * Average_Frequency) * MEM_LOAD_L3_MISS_RETIRE=
D.REMOTE_DRAM * (1 + (MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS) /=
 2) / CLKS",
+        "MetricGroup": "Server;Snoop;TopdownL5;tma_mem_latency_group",
+        "MetricName": "tma_remote_dram",
+        "PublicDescription": "This metric estimates fraction of cycles whi=
le the memory subsystem was handling loads from remote memory. This is caus=
ed often due to non-optimal NUMA allocations. #link to NUMA article Sample =
with: MEM_LOAD_L3_MISS_RETIRED.REMOTE_DRAM_PS"
+    },
+    {
+        "BriefDescription": "This metric estimates fraction of cycles whil=
e the memory subsystem was handling loads from remote cache in other socket=
s including synchronizations issues",
+        "MetricExpr": "((108 * Average_Frequency) * MEM_LOAD_L3_MISS_RETIR=
ED.REMOTE_HITM + (108 * Average_Frequency) * MEM_LOAD_L3_MISS_RETIRED.REMOT=
E_FWD) * (1 + (MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS) / 2) / C=
LKS",
+        "MetricGroup": "Offcore;Server;Snoop;TopdownL5;tma_mem_latency_gro=
up",
+        "MetricName": "tma_remote_cache",
+        "PublicDescription": "This metric estimates fraction of cycles whi=
le the memory subsystem was handling loads from remote cache in other socke=
ts including synchronizations issues. This is caused often due to non-optim=
al NUMA allocations. #link to NUMA article Sample with: MEM_LOAD_L3_MISS_RE=
TIRED.REMOTE_HITM_PS;MEM_LOAD_L3_MISS_RETIRED.REMOTE_FWD_PS"
+    },
+    {
+        "BriefDescription": "This metric roughly estimates (based on idle =
latencies) how often the CPU was stalled on accesses to external 3D-Xpoint =
(Crystal Ridge, a.k.a",
+        "MetricExpr": "(((1 - ((19 * (MEM_LOAD_L3_MISS_RETIRED.REMOTE_DRAM=
 * (1 + (MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS))) + 10 * ((MEM=
_LOAD_L3_MISS_RETIRED.LOCAL_DRAM * (1 + (MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD=
_RETIRED.L1_MISS))) + (MEM_LOAD_L3_MISS_RETIRED.REMOTE_FWD * (1 + (MEM_LOAD=
_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS))) + (MEM_LOAD_L3_MISS_RETIRED.R=
EMOTE_HITM * (1 + (MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS))))) =
/ ((19 * (MEM_LOAD_L3_MISS_RETIRED.REMOTE_DRAM * (1 + (MEM_LOAD_RETIRED.FB_=
HIT / MEM_LOAD_RETIRED.L1_MISS))) + 10 * ((MEM_LOAD_L3_MISS_RETIRED.LOCAL_D=
RAM * (1 + (MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS))) + (MEM_LO=
AD_L3_MISS_RETIRED.REMOTE_FWD * (1 + (MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RE=
TIRED.L1_MISS))) + (MEM_LOAD_L3_MISS_RETIRED.REMOTE_HITM * (1 + (MEM_LOAD_R=
ETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS))))) + (25 * (MEM_LOAD_RETIRED.LOC=
AL_PMM * (1 + (MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS))) + 33 *=
 (MEM_LOAD_L3_MISS_RETIRED.REMOTE_PMM * (1 + (MEM_LOAD_RETIRED.FB_HIT / MEM=
_LOAD_RETIRED.L1_MISS))))))) * (MEMORY_ACTIVITY.STALLS_L3_MISS / CLKS)) if =
(1000000 * (MEM_LOAD_L3_MISS_RETIRED.REMOTE_PMM + MEM_LOAD_RETIRED.LOCAL_PM=
M) > MEM_LOAD_RETIRED.L1_MISS) else 0)",
+        "MetricGroup": "MemoryBound;Server;TmaL3mem;TopdownL3;tma_memory_b=
ound_group",
+        "MetricName": "tma_pmm_bound",
+        "PublicDescription": "This metric roughly estimates (based on idle=
 latencies) how often the CPU was stalled on accesses to external 3D-Xpoint=
 (Crystal Ridge, a.k.a. IXP) memory by loads, PMM stands for Persistent Mem=
ory Module. "
+    },
+    {
+        "BriefDescription": "This metric estimates how often CPU was stall=
ed  due to RFO store memory accesses; RFO store issue a read-for-ownership =
request before the write",
+        "MetricExpr": "EXE_ACTIVITY.BOUND_ON_STORES / CLKS",
+        "MetricGroup": "MemoryBound;TmaL3mem;TopdownL3;tma_memory_bound_gr=
oup",
+        "MetricName": "tma_store_bound",
+        "PublicDescription": "This metric estimates how often CPU was stal=
led  due to RFO store memory accesses; RFO store issue a read-for-ownership=
 request before the write. Even though store accesses do not typically stal=
l out-of-order CPUs; there are few cases where stores can lead to actual st=
alls. This metric will be flagged should RFO stores be a bottleneck. Sample=
 with: MEM_INST_RETIRED.ALL_STORES_PS"
+    },
+    {
+        "BriefDescription": "This metric estimates fraction of cycles the =
CPU spent handling L1D store misses",
+        "MetricExpr": "((MEM_STORE_RETIRED.L2_HIT * 10 * (1 - (MEM_INST_RE=
TIRED.LOCK_LOADS / MEM_INST_RETIRED.ALL_STORES))) + (1 - (MEM_INST_RETIRED.=
LOCK_LOADS / MEM_INST_RETIRED.ALL_STORES)) * min(CPU_CLK_UNHALTED.THREAD, O=
FFCORE_REQUESTS_OUTSTANDING.CYCLES_WITH_DEMAND_RFO)) / CLKS",
+        "MetricGroup": "MemoryLat;Offcore;TopdownL4;tma_store_bound_group"=
,
+        "MetricName": "tma_store_latency",
+        "PublicDescription": "This metric estimates fraction of cycles the=
 CPU spent handling L1D store misses. Store accesses usually less impact ou=
t-of-order core performance; however; holding resources for longer time can=
 lead into undesired implications (e.g. contention on L1D fill-buffer entri=
es - see FB_Full)"
+    },
+    {
+        "BriefDescription": "This metric roughly estimates how often CPU w=
as handling synchronizations due to False Sharing",
+        "MetricExpr": "(28 * Average_Frequency) * OCR.DEMAND_RFO.L3_HIT.SN=
OOP_HITM / CLKS",
+        "MetricGroup": "DataSharing;Offcore;Snoop;TopdownL4;tma_store_boun=
d_group",
+        "MetricName": "tma_false_sharing",
+        "PublicDescription": "This metric roughly estimates how often CPU =
was handling synchronizations due to False Sharing. False Sharing is a mult=
ithreading hiccup; where multiple Logical Processors contend on different d=
ata-elements mapped into the same cache line.  Sample with: OCR.DEMAND_RFO.=
L3_HIT.SNOOP_HITM"
+    },
+    {
+        "BriefDescription": "This metric represents rate of split store ac=
cesses",
+        "MetricExpr": "MEM_INST_RETIRED.SPLIT_STORES / CORE_CLKS",
+        "MetricGroup": "TopdownL4;tma_store_bound_group",
+        "MetricName": "tma_split_stores",
+        "PublicDescription": "This metric represents rate of split store a=
ccesses.  Consider aligning your data to the 64-byte cache line granularity=
. Sample with: MEM_INST_RETIRED.SPLIT_STORES_PS"
+    },
+    {
+        "BriefDescription": "This metric estimates how often CPU was stall=
ed  due to Streaming store memory accesses; Streaming store optimize out a =
read request required by RFO stores",
+        "MetricExpr": "9 * OCR.STREAMING_WR.ANY_RESPONSE / CLKS",
+        "MetricGroup": "MemoryBW;Offcore;TopdownL4;tma_store_bound_group",
+        "MetricName": "tma_streaming_stores",
+        "PublicDescription": "This metric estimates how often CPU was stal=
led  due to Streaming store memory accesses; Streaming store optimize out a=
 read request required by RFO stores. Even though store accesses do not typ=
ically stall out-of-order CPUs; there are few cases where stores can lead t=
o actual stalls. This metric will be flagged should Streaming stores be a b=
ottleneck. Sample with: OCR.STREAMING_WR.ANY_RESPONSE"
+    },
+    {
+        "BriefDescription": "This metric roughly estimates the fraction of=
 cycles spent handling first-level data TLB store misses",
+        "MetricExpr": "(7 * cpu@DTLB_STORE_MISSES.STLB_HIT\\,cmask\\=3D1@ =
+ DTLB_STORE_MISSES.WALK_ACTIVE) / CORE_CLKS",
+        "MetricGroup": "MemoryTLB;TopdownL4;tma_store_bound_group",
+        "MetricName": "tma_dtlb_store",
+        "PublicDescription": "This metric roughly estimates the fraction o=
f cycles spent handling first-level data TLB store misses.  As with ordinar=
y data caching; focus on improving data locality and reducing working-set s=
ize to reduce DTLB overhead.  Additionally; consider using profile-guided o=
ptimization (PGO) to collocate frequently-used data on the same page.  Try =
using larger page sizes for large amounts of frequently-used data. Sample w=
ith: MEM_INST_RETIRED.STLB_MISS_STORES_PS"
+    },
+    {
+        "BriefDescription": "This metric roughly estimates the fraction of=
 cycles where the TLB was missed by store accesses, hitting in the second-l=
evel TLB (STLB)",
+        "MetricExpr": "tma_dtlb_store - tma_store_stlb_miss",
+        "MetricGroup": "MemoryTLB;TopdownL5;tma_dtlb_store_group",
+        "MetricName": "tma_store_stlb_hit"
+    },
+    {
+        "BriefDescription": "This metric estimates the fraction of cycles =
where the STLB was missed by store accesses, performing a hardware page wal=
k",
+        "MetricExpr": "DTLB_STORE_MISSES.WALK_ACTIVE / CORE_CLKS",
+        "MetricGroup": "MemoryTLB;TopdownL5;tma_dtlb_store_group",
+        "MetricName": "tma_store_stlb_miss"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of slots wher=
e Core non-memory issues were of a bottleneck",
+        "MetricExpr": "max(0, tma_backend_bound - tma_memory_bound)",
+        "MetricGroup": "Backend;Compute;TopdownL2;tma_L2_group;tma_backend=
_bound_group",
+        "MetricName": "tma_core_bound",
+        "PublicDescription": "This metric represents fraction of slots whe=
re Core non-memory issues were of a bottleneck.  Shortage in hardware compu=
te resources; or dependencies in software's instructions are both categoriz=
ed under Core Bound. Hence it may indicate the machine ran out of an out-of=
-order resource; certain execution units are overloaded or dependencies in =
program's data- or instruction-flow are limiting the performance (e.g. FP-c=
hained long-latency arithmetic operations)."
+    },
+    {
+        "BriefDescription": "This metric represents fraction of cycles whe=
re the Divider unit was active",
+        "MetricExpr": "ARITH.DIVIDER_ACTIVE / CLKS",
+        "MetricGroup": "TopdownL3;tma_core_bound_group",
+        "MetricName": "tma_divider",
+        "PublicDescription": "This metric represents fraction of cycles wh=
ere the Divider unit was active. Divide and square root instructions are pe=
rformed by the Divider unit and can take considerably longer latency than i=
nteger or Floating Point addition; subtraction; or multiplication. Sample w=
ith: ARITH.DIVIDER_ACTIVE"
+    },
+    {
+        "BriefDescription": "This metric estimates fraction of cycles the =
CPU performance was potentially limited due to Core computation issues (non=
 divider-related)",
+        "MetricExpr": "(cpu@EXE_ACTIVITY.3_PORTS_UTIL\\,umask\\=3D0x80@ + =
(EXE_ACTIVITY.1_PORTS_UTIL + tma_retiring * cpu@EXE_ACTIVITY.2_PORTS_UTIL\\=
,umask\\=3D0xc@)) / CLKS if (ARITH.DIVIDER_ACTIVE < (CYCLE_ACTIVITY.STALLS_=
TOTAL - EXE_ACTIVITY.BOUND_ON_LOADS)) else (EXE_ACTIVITY.1_PORTS_UTIL + tma=
_retiring * cpu@EXE_ACTIVITY.2_PORTS_UTIL\\,umask\\=3D0xc@) / CLKS",
+        "MetricGroup": "PortsUtil;TopdownL3;tma_core_bound_group",
+        "MetricName": "tma_ports_utilization",
+        "PublicDescription": "This metric estimates fraction of cycles the=
 CPU performance was potentially limited due to Core computation issues (no=
n divider-related).  Two distinct categories can be attributed into this me=
tric: (1) heavy data-dependency among contiguous instructions would manifes=
t in this metric - such cases are often referred to as low Instruction Leve=
l Parallelism (ILP). (2) Contention on some hardware execution unit other t=
han Divider. For example; when there are too many multiply operations."
+    },
+    {
+        "BriefDescription": "This metric represents fraction of cycles CPU=
 executed no uops on any execution port (Logical Processor cycles since ICL=
, Physical Core cycles otherwise)",
+        "MetricExpr": "cpu@EXE_ACTIVITY.3_PORTS_UTIL\\,umask\\=3D0x80@ / C=
LKS + tma_serializing_operation * (CYCLE_ACTIVITY.STALLS_TOTAL - EXE_ACTIVI=
TY.BOUND_ON_LOADS) / CLKS",
+        "MetricGroup": "PortsUtil;TopdownL4;tma_ports_utilization_group",
+        "MetricName": "tma_ports_utilized_0",
+        "PublicDescription": "This metric represents fraction of cycles CP=
U executed no uops on any execution port (Logical Processor cycles since IC=
L, Physical Core cycles otherwise). Long-latency instructions like divides =
may contribute to this metric."
+    },
+    {
+        "BriefDescription": "This metric represents fraction of cycles the=
 CPU issue-pipeline was stalled due to serializing operations",
+        "MetricExpr": "RESOURCE_STALLS.SCOREBOARD / CLKS",
+        "MetricGroup": "TopdownL5;tma_ports_utilized_0_group",
+        "MetricName": "tma_serializing_operation",
+        "PublicDescription": "This metric represents fraction of cycles th=
e CPU issue-pipeline was stalled due to serializing operations. Instruction=
s like CPUID; WRMSR or LFENCE serialize the out-of-order execution which ma=
y limit performance. Sample with: RESOURCE_STALLS.SCOREBOARD"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to PAUSE Instructions",
+        "MetricExpr": "CPU_CLK_UNHALTED.PAUSE / CLKS",
+        "MetricGroup": "TopdownL6;tma_serializing_operation_group",
+        "MetricName": "tma_slow_pause",
+        "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to PAUSE Instructions. Sample with: CPU_CLK_UNHALTED.=
PAUSE_INST"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to LFENCE Instructions.",
+        "MetricExpr": "13 * MISC2_RETIRED.LFENCE / CLKS",
+        "MetricGroup": "TopdownL6;tma_serializing_operation_group",
+        "MetricName": "tma_memory_fence"
+    },
+    {
+        "BriefDescription": "The Mixing_Vectors metric gives the percentag=
e of injected blend uops out of all uops issued",
+        "MetricExpr": "160 * ASSISTS.SSE_AVX_MIX / CLKS",
+        "MetricGroup": "TopdownL5;tma_ports_utilized_0_group",
+        "MetricName": "tma_mixing_vectors",
+        "PublicDescription": "The Mixing_Vectors metric gives the percenta=
ge of injected blend uops out of all uops issued. Usually a Mixing_Vectors =
over 5% is worth investigating. Read more in Appendix B1 of the Optimizatio=
ns Guide for this topic."
+    },
+    {
+        "BriefDescription": "This metric estimates fraction of cycles wher=
e the Advanced Matrix Extensions (AMX) execution engine was busy with tile =
(arithmetic) operations",
+        "MetricExpr": "EXE.AMX_BUSY / CORE_CLKS",
+        "MetricGroup": "Compute;HPC;Server;TopdownL5;tma_ports_utilized_0_=
group",
+        "MetricName": "tma_amx_busy"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of cycles whe=
re the CPU executed total of 1 uop per cycle on all execution ports (Logica=
l Processor cycles since ICL, Physical Core cycles otherwise)",
+        "MetricExpr": "EXE_ACTIVITY.1_PORTS_UTIL / CLKS",
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
 assembly can be helpful. Sample with: EXE_ACTIVITY.1_PORTS_UTIL"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of cycles CPU=
 executed total of 2 uops per cycle on all execution ports (Logical Process=
or cycles since ICL, Physical Core cycles otherwise)",
+        "MetricExpr": "EXE_ACTIVITY.2_PORTS_UTIL / CLKS",
+        "MetricGroup": "PortsUtil;TopdownL4;tma_ports_utilization_group",
+        "MetricName": "tma_ports_utilized_2",
+        "PublicDescription": "This metric represents fraction of cycles CP=
U executed total of 2 uops per cycle on all execution ports (Logical Proces=
sor cycles since ICL, Physical Core cycles otherwise).  Loop Vectorization =
-most compilers feature auto-Vectorization options today- reduces pressure =
on the execution ports as multiple elements are calculated with same uop. S=
ample with: EXE_ACTIVITY.2_PORTS_UTIL"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of cycles CPU=
 executed total of 3 or more uops per cycle on all execution ports (Logical=
 Processor cycles since ICL, Physical Core cycles otherwise)",
+        "MetricExpr": "UOPS_EXECUTED.CYCLES_GE_3 / CLKS",
+        "MetricGroup": "PortsUtil;TopdownL4;tma_ports_utilization_group",
+        "MetricName": "tma_ports_utilized_3m",
+        "PublicDescription": "This metric represents fraction of cycles CP=
U executed total of 3 or more uops per cycle on all execution ports (Logica=
l Processor cycles since ICL, Physical Core cycles otherwise). Sample with:=
 UOPS_EXECUTED.CYCLES_GE_3"
+    },
+    {
+        "BriefDescription": "This metric represents Core fraction of cycle=
s CPU dispatched uops on execution ports for ALU operations.",
+        "MetricExpr": "(UOPS_DISPATCHED.PORT_0 + UOPS_DISPATCHED.PORT_1 + =
UOPS_DISPATCHED.PORT_5_11 + UOPS_DISPATCHED.PORT_6) / (5 * CORE_CLKS)",
+        "MetricGroup": "TopdownL5;tma_ports_utilized_3m_group",
+        "MetricName": "tma_alu_op_utilization"
+    },
+    {
+        "BriefDescription": "This metric represents Core fraction of cycle=
s CPU dispatched uops on execution port 0 ([SNB+] ALU; [HSW+] ALU and 2nd b=
ranch) Sample with: UOPS_DISPATCHED.PORT_0",
+        "MetricExpr": "UOPS_DISPATCHED.PORT_0 / CORE_CLKS",
+        "MetricGroup": "Compute;TopdownL6;tma_alu_op_utilization_group",
+        "MetricName": "tma_port_0"
+    },
+    {
+        "BriefDescription": "This metric represents Core fraction of cycle=
s CPU dispatched uops on execution port 1 (ALU) Sample with: UOPS_DISPATCHE=
D.PORT_1",
+        "MetricExpr": "UOPS_DISPATCHED.PORT_1 / CORE_CLKS",
+        "MetricGroup": "TopdownL6;tma_alu_op_utilization_group",
+        "MetricName": "tma_port_1"
+    },
+    {
+        "BriefDescription": "This metric represents Core fraction of cycle=
s CPU dispatched uops on execution port 6 ([HSW+]Primary Branch and simple =
ALU) Sample with: UOPS_DISPATCHED.PORT_6",
+        "MetricExpr": "UOPS_DISPATCHED.PORT_6 / CORE_CLKS",
+        "MetricGroup": "TopdownL6;tma_alu_op_utilization_group",
+        "MetricName": "tma_port_6"
+    },
+    {
+        "BriefDescription": "This metric represents Core fraction of cycle=
s CPU dispatched uops on execution port for Load operations Sample with: UO=
PS_DISPATCHED.PORT_2_3_10",
+        "MetricExpr": "UOPS_DISPATCHED.PORT_2_3_10 / (3 * CORE_CLKS)",
+        "MetricGroup": "TopdownL5;tma_ports_utilized_3m_group",
+        "MetricName": "tma_load_op_utilization"
+    },
+    {
+        "BriefDescription": "This metric represents Core fraction of cycle=
s CPU dispatched uops on execution port for Store operations Sample with: U=
OPS_DISPATCHED.PORT_7_8",
+        "MetricExpr": "(UOPS_DISPATCHED.PORT_4_9 + UOPS_DISPATCHED.PORT_7_=
8) / (4 * CORE_CLKS)",
+        "MetricGroup": "TopdownL5;tma_ports_utilized_3m_group",
+        "MetricName": "tma_store_op_utilization"
+    },
+    {
+        "BriefDescription": "This category represents fraction of slots ut=
ilized by useful work i.e. issued uops that eventually get retired",
+        "MetricExpr": "topdown\\-retiring / (topdown\\-fe\\-bound + topdow=
n\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound)",
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
D.SLOTS"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring light-weight operations -- instructions that require=
 no more than one uop (micro-operation)",
+        "MetricExpr": "max(0, tma_retiring - tma_heavy_operations)",
+        "MetricGroup": "Retire;TopdownL2;tma_L2_group;tma_retiring_group",
+        "MetricName": "tma_light_operations",
+        "PublicDescription": "This metric represents fraction of slots whe=
re the CPU was retiring light-weight operations -- instructions that requir=
e no more than one uop (micro-operation). This correlates with total number=
 of instructions used by the program. A uops-per-instruction (see UPI metri=
c) ratio of 1 or less should be expected for decently optimized software ru=
nning on Intel Core/Xeon products. While this often indicates efficient X86=
 instructions were executed; high value does not necessarily mean better pe=
rformance cannot be achieved. Sample with: INST_RETIRED.PREC_DIST"
+    },
+    {
+        "BriefDescription": "This metric represents overall arithmetic flo=
ating-point (FP) operations fraction the CPU has executed (retired)",
+        "MetricExpr": "tma_x87_use + tma_fp_scalar + tma_fp_vector + tma_f=
p_amx",
+        "MetricGroup": "HPC;TopdownL3;tma_light_operations_group",
+        "MetricName": "tma_fp_arith",
+        "PublicDescription": "This metric represents overall arithmetic fl=
oating-point (FP) operations fraction the CPU has executed (retired). Note =
this metric's value may exceed its parent due to use of \"Uops\" CountDomai=
n and FMA double-counting."
+    },
+    {
+        "BriefDescription": "This metric serves as an approximation of leg=
acy x87 usage",
+        "MetricExpr": "tma_retiring * UOPS_EXECUTED.X87 / UOPS_EXECUTED.TH=
READ",
+        "MetricGroup": "Compute;TopdownL4;tma_fp_arith_group",
+        "MetricName": "tma_x87_use",
+        "PublicDescription": "This metric serves as an approximation of le=
gacy x87 usage. It accounts for instructions beyond X87 FP arithmetic opera=
tions; hence may be used as a thermometer to avoid X87 high usage and prefe=
rably upgrade to modern ISA. See Tip under Tuning Hint."
+    },
+    {
+        "BriefDescription": "This metric approximates arithmetic floating-=
point (FP) scalar uops fraction the CPU has retired",
+        "MetricExpr": "(FP_ARITH_INST_RETIRED.SCALAR_SINGLE + FP_ARITH_INS=
T_RETIRED.SCALAR_DOUBLE + FP_ARITH_INST_RETIRED2.SCALAR) / (tma_retiring * =
SLOTS)",
+        "MetricGroup": "Compute;Flops;TopdownL4;tma_fp_arith_group",
+        "MetricName": "tma_fp_scalar",
+        "PublicDescription": "This metric approximates arithmetic floating=
-point (FP) scalar uops fraction the CPU has retired. May overcount due to =
FMA double counting."
+    },
+    {
+        "BriefDescription": "This metric approximates arithmetic floating-=
point (FP) vector uops fraction the CPU has retired aggregated across all v=
ector widths",
+        "MetricExpr": "(FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + FP_ARIT=
H_INST_RETIRED.128B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.256B_PACKED_DOUBL=
E + FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.512B_P=
ACKED_DOUBLE + FP_ARITH_INST_RETIRED.512B_PACKED_SINGLE + FP_ARITH_INST_RET=
IRED2.VECTOR) / (tma_retiring * SLOTS)",
+        "MetricGroup": "Compute;Flops;TopdownL4;tma_fp_arith_group",
+        "MetricName": "tma_fp_vector",
+        "PublicDescription": "This metric approximates arithmetic floating=
-point (FP) vector uops fraction the CPU has retired aggregated across all =
vector widths. May overcount due to FMA double counting."
+    },
+    {
+        "BriefDescription": "This metric approximates arithmetic FP vector=
 uops fraction the CPU has retired for 128-bit wide vectors",
+        "MetricExpr": "(FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + FP_ARIT=
H_INST_RETIRED.128B_PACKED_SINGLE + FP_ARITH_INST_RETIRED2.128B_PACKED_HALF=
) / (tma_retiring * SLOTS)",
+        "MetricGroup": "Compute;Flops;TopdownL5;tma_fp_vector_group",
+        "MetricName": "tma_fp_vector_128b",
+        "PublicDescription": "This metric approximates arithmetic FP vecto=
r uops fraction the CPU has retired for 128-bit wide vectors. May overcount=
 due to FMA double counting."
+    },
+    {
+        "BriefDescription": "This metric approximates arithmetic FP vector=
 uops fraction the CPU has retired for 256-bit wide vectors",
+        "MetricExpr": "(FP_ARITH_INST_RETIRED.256B_PACKED_DOUBLE + FP_ARIT=
H_INST_RETIRED.256B_PACKED_SINGLE + FP_ARITH_INST_RETIRED2.256B_PACKED_HALF=
) / (tma_retiring * SLOTS)",
+        "MetricGroup": "Compute;Flops;TopdownL5;tma_fp_vector_group",
+        "MetricName": "tma_fp_vector_256b",
+        "PublicDescription": "This metric approximates arithmetic FP vecto=
r uops fraction the CPU has retired for 256-bit wide vectors. May overcount=
 due to FMA double counting."
+    },
+    {
+        "BriefDescription": "This metric approximates arithmetic FP vector=
 uops fraction the CPU has retired for 512-bit wide vectors",
+        "MetricExpr": "(FP_ARITH_INST_RETIRED.512B_PACKED_DOUBLE + FP_ARIT=
H_INST_RETIRED.512B_PACKED_SINGLE + FP_ARITH_INST_RETIRED2.512B_PACKED_HALF=
) / (tma_retiring * SLOTS)",
+        "MetricGroup": "Compute;Flops;TopdownL5;tma_fp_vector_group",
+        "MetricName": "tma_fp_vector_512b",
+        "PublicDescription": "This metric approximates arithmetic FP vecto=
r uops fraction the CPU has retired for 512-bit wide vectors. May overcount=
 due to FMA double counting."
+    },
+    {
+        "BriefDescription": "This metric approximates arithmetic floating-=
point (FP) matrix uops fraction the CPU has retired (aggregated across all =
supported FP datatypes in AMX engine)",
+        "MetricExpr": "cpu@AMX_OPS_RETIRED.BF16\\,cmask\\=3D1@ / (tma_reti=
ring * SLOTS)",
+        "MetricGroup": "Compute;Flops;HPC;Pipeline;Server;TopdownL4;tma_fp=
_arith_group",
+        "MetricName": "tma_fp_amx",
+        "PublicDescription": "This metric approximates arithmetic floating=
-point (FP) matrix uops fraction the CPU has retired (aggregated across all=
 supported FP datatypes in AMX engine). Refer to AMX_Busy and GFLOPs metric=
s for actual AMX utilization and FP performance, resp."
+    },
+    {
+        "BriefDescription": "This metric represents overall Integer (Int) =
select operations fraction the CPU has executed (retired)",
+        "MetricExpr": "tma_int_vector_128b + tma_int_vector_256b + tma_shu=
ffles",
+        "MetricGroup": "Pipeline;TopdownL3;tma_light_operations_group",
+        "MetricName": "tma_int_operations",
+        "PublicDescription": "This metric represents overall Integer (Int)=
 select operations fraction the CPU has executed (retired). Vector/Matrix I=
nt operations and shuffles are counted. Note this metric's value may exceed=
 its parent due to use of \"Uops\" CountDomain."
+    },
+    {
+        "BriefDescription": "This metric represents 128-bit vector Integer=
 ADD/SUB/SAD or VNNI (Vector Neural Network Instructions) uops fraction the=
 CPU has retired.",
+        "MetricExpr": "(INT_VEC_RETIRED.ADD_128 + INT_VEC_RETIRED.VNNI_128=
) / (tma_retiring * SLOTS)",
+        "MetricGroup": "Compute;IntVector;Pipeline;TopdownL4;tma_int_opera=
tions_group",
+        "MetricName": "tma_int_vector_128b"
+    },
+    {
+        "BriefDescription": "This metric represents 256-bit vector Integer=
 ADD/SUB/SAD or VNNI (Vector Neural Network Instructions) uops fraction the=
 CPU has retired.",
+        "MetricExpr": "(INT_VEC_RETIRED.ADD_256 + INT_VEC_RETIRED.MUL_256 =
+ INT_VEC_RETIRED.VNNI_256) / (tma_retiring * SLOTS)",
+        "MetricGroup": "Compute;IntVector;Pipeline;TopdownL4;tma_int_opera=
tions_group",
+        "MetricName": "tma_int_vector_256b"
+    },
+    {
+        "BriefDescription": "This metric approximates arithmetic Integer (=
Int) matrix uops fraction the CPU has retired (aggregated across all suppor=
ted Int datatypes in AMX engine)",
+        "MetricExpr": "cpu@AMX_OPS_RETIRED.INT8\\,cmask\\=3D1@ / (tma_reti=
ring * SLOTS)",
+        "MetricGroup": "Compute;HPC;IntVector;Pipeline;Server;TopdownL4;tm=
a_int_operations_group",
+        "MetricName": "tma_int_amx",
+        "PublicDescription": "This metric approximates arithmetic Integer =
(Int) matrix uops fraction the CPU has retired (aggregated across all suppo=
rted Int datatypes in AMX engine). Refer to AMX_Busy and TIOPs metrics for =
actual AMX utilization and Int performance, resp."
+    },
+    {
+        "BriefDescription": "This metric represents Shuffle (cross \"vecto=
r lane\" data transfers) uops fraction the CPU has retired.",
+        "MetricExpr": "INT_VEC_RETIRED.SHUFFLES / (tma_retiring * SLOTS)",
+        "MetricGroup": "HPC;Pipeline;TopdownL4;tma_int_operations_group",
+        "MetricName": "tma_shuffles"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring memory operations -- uops for memory load or store a=
ccesses.",
+        "MetricExpr": "tma_light_operations * MEM_UOP_RETIRED.ANY / (tma_r=
etiring * SLOTS)",
+        "MetricGroup": "Pipeline;TopdownL3;tma_light_operations_group",
+        "MetricName": "tma_memory_operations"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring fused instructions -- where one uop can represent mu=
ltiple contiguous instructions",
+        "MetricExpr": "tma_light_operations * INST_RETIRED.MACRO_FUSED / (=
tma_retiring * SLOTS)",
+        "MetricGroup": "Pipeline;TopdownL3;tma_light_operations_group",
+        "MetricName": "tma_fused_instructions",
+        "PublicDescription": "This metric represents fraction of slots whe=
re the CPU was retiring fused instructions -- where one uop can represent m=
ultiple contiguous instructions. The instruction pairs of CMP+JCC or DEC+JC=
C are commonly used examples."
+    },
+    {
+        "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring branch instructions that were not fused",
+        "MetricExpr": "tma_light_operations * (BR_INST_RETIRED.ALL_BRANCHE=
S - INST_RETIRED.MACRO_FUSED) / (tma_retiring * SLOTS)",
+        "MetricGroup": "Pipeline;TopdownL3;tma_light_operations_group",
+        "MetricName": "tma_non_fused_branches",
+        "PublicDescription": "This metric represents fraction of slots whe=
re the CPU was retiring branch instructions that were not fused. Non-condit=
ional branches like direct JMP or CALL would count here. Can be used to exa=
mine fusible conditional jumps that were not fused."
+    },
+    {
+        "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring NOP (no op) instructions",
+        "MetricExpr": "tma_light_operations * INST_RETIRED.NOP / (tma_reti=
ring * SLOTS)",
+        "MetricGroup": "Pipeline;TopdownL3;tma_light_operations_group",
+        "MetricName": "tma_nop_instructions",
+        "PublicDescription": "This metric represents fraction of slots whe=
re the CPU was retiring NOP (no op) instructions. Compilers often use NOPs =
for certain address alignments - e.g. start address of a function or loop b=
ody. Sample with: INST_RETIRED.NOP"
+    },
+    {
+        "BriefDescription": "This metric represents the remaining light uo=
ps fraction the CPU has executed - remaining means not covered by other sib=
ling nodes. May undercount due to FMA double counting",
+        "MetricExpr": "max(0, tma_light_operations - (tma_fp_arith + tma_i=
nt_operations + tma_memory_operations + tma_fused_instructions + tma_non_fu=
sed_branches + tma_nop_instructions))",
+        "MetricGroup": "Pipeline;TopdownL3;tma_light_operations_group",
+        "MetricName": "tma_other_light_ops"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring heavy-weight operations -- instructions that require=
 two or more uops or microcoded sequences",
+        "MetricExpr": "topdown\\-heavy\\-ops / (topdown\\-fe\\-bound + top=
down\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound)",
+        "MetricGroup": "Retire;TopdownL2;tma_L2_group;tma_retiring_group",
+        "MetricName": "tma_heavy_operations",
+        "PublicDescription": "This metric represents fraction of slots whe=
re the CPU was retiring heavy-weight operations -- instructions that requir=
e two or more uops or microcoded sequences. This highly-correlates with the=
 uop length of these instructions/sequences. Sample with: UOPS_RETIRED.HEAV=
Y"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring instructions that that are decoder into two or up to=
 ([SNB+] four; [ADL+] five) uops",
+        "MetricExpr": "tma_heavy_operations - tma_microcode_sequencer",
+        "MetricGroup": "TopdownL3;tma_heavy_operations_group",
+        "MetricName": "tma_few_uops_instructions",
+        "PublicDescription": "This metric represents fraction of slots whe=
re the CPU was retiring instructions that that are decoder into two or up t=
o ([SNB+] four; [ADL+] five) uops. This highly-correlates with the number o=
f uops in such instructions."
+    },
+    {
+        "BriefDescription": "This metric represents fraction of slots the =
CPU was retiring uops fetched by the Microcode Sequencer (MS) unit",
+        "MetricExpr": "UOPS_RETIRED.MS / SLOTS",
+        "MetricGroup": "MicroSeq;TopdownL3;tma_heavy_operations_group",
+        "MetricName": "tma_microcode_sequencer",
+        "PublicDescription": "This metric represents fraction of slots the=
 CPU was retiring uops fetched by the Microcode Sequencer (MS) unit.  The M=
S is used for CISC instructions not supported by the default decoders (like=
 repeat move strings; or CPUID); or by microcode assists used to address so=
me operation modes (like in Floating Point assists). These cases can often =
be avoided. Sample with: UOPS_RETIRED.MS"
+    },
+    {
+        "BriefDescription": "This metric estimates fraction of slots the C=
PU retired uops delivered by the Microcode_Sequencer as a result of Assists=
",
+        "MetricExpr": "100 * cpu@ASSISTS.ANY\\,umask\\=3D0x1B@ / SLOTS",
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
rmance and they can be avoided in many cases. Sample with: ASSISTS.ANY"
+    },
+    {
+        "BriefDescription": "This metric roughly estimates fraction of slo=
ts the CPU retired uops as a result of handing Page Faults",
+        "MetricExpr": "99 * ASSISTS.PAGE_FAULT / SLOTS",
+        "MetricGroup": "TopdownL5;tma_assists_group",
+        "MetricName": "tma_page_faults",
+        "PublicDescription": "This metric roughly estimates fraction of sl=
ots the CPU retired uops as a result of handing Page Faults. A Page Fault m=
ay apply on first application access to a memory page. Note operating syste=
m handling of page faults accounts for the majority of its cost."
+    },
+    {
+        "BriefDescription": "This metric roughly estimates fraction of slo=
ts the CPU retired uops as a result of handing Floating Point (FP) Assists"=
,
+        "MetricExpr": "30 * ASSISTS.FP / SLOTS",
+        "MetricGroup": "HPC;TopdownL5;tma_assists_group",
+        "MetricName": "tma_fp_assists",
+        "PublicDescription": "This metric roughly estimates fraction of sl=
ots the CPU retired uops as a result of handing Floating Point (FP) Assists=
. FP Assist may apply when working with very small floating point values (s=
o-called denormals)."
+    },
+    {
+        "BriefDescription": "This metric estimates fraction of slots the C=
PU retired uops as a result of handing SSE to AVX* or AVX* to SSE transitio=
n Assists. ",
+        "MetricExpr": "63 * ASSISTS.SSE_AVX_MIX / SLOTS",
+        "MetricGroup": "HPC;TopdownL5;tma_assists_group",
+        "MetricName": "tma_avx_assists"
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
ot imply sub-optimal use of machine resources. Sample with: FRONTEND_RETIRE=
D.MS_FLOWS"
+    },
+    {
+        "BriefDescription": "Total pipeline cost of Branch Misprediction r=
elated bottlenecks",
+        "MetricExpr": "100 * (tma_branch_mispredicts + tma_fetch_latency *=
 tma_mispredicts_resteers / (tma_branch_resteers + tma_dsb_switches + tma_i=
cache_misses + tma_itlb_misses + tma_lcp + tma_ms_switches))",
+        "MetricGroup": "Bad;BadSpec;BrMispredicts",
+        "MetricName": "Mispredictions"
+    },
+    {
+        "BriefDescription": "Total pipeline cost of (external) Memory Band=
width related bottlenecks",
+        "MetricExpr": "100 * tma_memory_bound * ((tma_dram_bound / (tma_dr=
am_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_pmm_bound + tma=
_store_bound)) * (tma_mem_bandwidth / (tma_mem_bandwidth + tma_mem_latency)=
) + (tma_l3_bound / (tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_=
bound + tma_pmm_bound + tma_store_bound)) * (tma_sq_full / (tma_contested_a=
ccesses + tma_data_sharing + tma_l3_hit_latency + tma_sq_full))) + (tma_l1_=
bound / (tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_=
pmm_bound + tma_store_bound)) * (tma_fb_full / (tma_dtlb_load + tma_fb_full=
 + tma_lock_latency + tma_split_loads + tma_store_fwd_blk)) ",
+        "MetricGroup": "Mem;MemoryBW;Offcore",
+        "MetricName": "Memory_Bandwidth"
+    },
+    {
+        "BriefDescription": "Total pipeline cost of Memory Latency related=
 bottlenecks (external memory and off-core caches)",
+        "MetricExpr": "100 * tma_memory_bound * ((tma_dram_bound / (tma_dr=
am_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_pmm_bound + tma=
_store_bound)) * (tma_mem_latency / (tma_mem_bandwidth + tma_mem_latency)) =
+ (tma_l3_bound / (tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bo=
und + tma_pmm_bound + tma_store_bound)) * (tma_l3_hit_latency / (tma_contes=
ted_accesses + tma_data_sharing + tma_l3_hit_latency + tma_sq_full)) + (tma=
_l2_bound / (tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + =
tma_pmm_bound + tma_store_bound)))",
+        "MetricGroup": "Mem;MemoryLat;Offcore",
+        "MetricName": "Memory_Latency"
+    },
+    {
+        "BriefDescription": "Total pipeline cost of Memory Address Transla=
tion related bottlenecks (data-side TLBs)",
+        "MetricExpr": "100 * tma_memory_bound * ((tma_l1_bound / max(tma_m=
emory_bound, tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + =
tma_pmm_bound + tma_store_bound)) * (tma_dtlb_load / max(tma_l1_bound, tma_=
dtlb_load + tma_fb_full + tma_lock_latency + tma_split_loads + tma_store_fw=
d_blk)) + (tma_store_bound / (tma_dram_bound + tma_l1_bound + tma_l2_bound =
+ tma_l3_bound + tma_pmm_bound + tma_store_bound)) * (tma_dtlb_store / (tma=
_dtlb_store + tma_false_sharing + tma_split_stores + tma_store_latency + tm=
a_streaming_stores))) ",
+        "MetricGroup": "Mem;MemoryTLB;Offcore",
+        "MetricName": "Memory_Data_TLBs"
+    },
     {
         "BriefDescription": "Total pipeline cost of branch related instruc=
tions (used for program control-flow including function calls)",
-        "MetricExpr": "100 * (( BR_INST_RETIRED.COND + 3 * BR_INST_RETIRED=
.NEAR_CALL + (BR_INST_RETIRED.NEAR_TAKEN - BR_INST_RETIRED.COND_TAKEN - 2 *=
 BR_INST_RETIRED.NEAR_CALL) ) / TOPDOWN.SLOTS)",
+        "MetricExpr": "100 * ((BR_INST_RETIRED.COND + 3 * BR_INST_RETIRED.=
NEAR_CALL + (BR_INST_RETIRED.NEAR_TAKEN - BR_INST_RETIRED.COND_TAKEN - 2 * =
BR_INST_RETIRED.NEAR_CALL)) / SLOTS)",
         "MetricGroup": "Ret",
         "MetricName": "Branching_Overhead"
     },
+    {
+        "BriefDescription": "Total pipeline cost of instruction fetch rela=
ted bottlenecks by large code footprint programs (i-side cache; TLB and BTB=
 misses)",
+        "MetricExpr": "100 * tma_fetch_latency * (tma_itlb_misses + tma_ic=
ache_misses + tma_unknown_branches) / (tma_branch_resteers + tma_dsb_switch=
es + tma_icache_misses + tma_itlb_misses + tma_lcp + tma_ms_switches)",
+        "MetricGroup": "BigFoot;Fed;Frontend;IcMiss;MemoryTLB",
+        "MetricName": "Big_Code"
+    },
+    {
+        "BriefDescription": "Total pipeline cost of instruction fetch band=
width related bottlenecks",
+        "MetricExpr": "100 * (tma_frontend_bound - tma_fetch_latency * tma=
_mispredicts_resteers / (tma_branch_resteers + tma_dsb_switches + tma_icach=
e_misses + tma_itlb_misses + tma_lcp + tma_ms_switches)) - Big_Code",
+        "MetricGroup": "Fed;FetchBW;Frontend",
+        "MetricName": "Instruction_Fetch_BW"
+    },
     {
         "BriefDescription": "Instructions Per Cycle (per Logical Processor=
)",
-        "MetricExpr": "INST_RETIRED.ANY / CPU_CLK_UNHALTED.THREAD",
+        "MetricExpr": "INST_RETIRED.ANY / CLKS",
         "MetricGroup": "Ret;Summary",
         "MetricName": "IPC"
     },
+    {
+        "BriefDescription": "Uops Per Instruction",
+        "MetricExpr": "(tma_retiring * SLOTS) / INST_RETIRED.ANY",
+        "MetricGroup": "Pipeline;Ret;Retire",
+        "MetricName": "UPI"
+    },
+    {
+        "BriefDescription": "Instruction per taken branch",
+        "MetricExpr": "(tma_retiring * SLOTS) / BR_INST_RETIRED.NEAR_TAKEN=
",
+        "MetricGroup": "Branches;Fed;FetchBW",
+        "MetricName": "UpTB"
+    },
     {
         "BriefDescription": "Per-Logical Processor actual clocks when the =
Logical Processor is active.",
         "MetricExpr": "CPU_CLK_UNHALTED.THREAD",
@@ -20,13 +720,13 @@
     {
         "BriefDescription": "Total issue-pipeline slots (per-Physical Core=
 till ICL; per-Logical Processor ICL onward)",
         "MetricExpr": "TOPDOWN.SLOTS",
-        "MetricGroup": "TmaL1",
+        "MetricGroup": "tma_L1_group",
         "MetricName": "SLOTS"
     },
     {
         "BriefDescription": "Fraction of Physical Core issue-slots utilize=
d by this Logical Processor",
-        "MetricExpr": "TOPDOWN.SLOTS / ( TOPDOWN.SLOTS / 2 ) if #SMT_on el=
se 1",
-        "MetricGroup": "SMT;TmaL1",
+        "MetricExpr": "SLOTS / (TOPDOWN.SLOTS / 2) if #SMT_on else 1",
+        "MetricGroup": "SMT;tma_L1_group",
         "MetricName": "Slots_Utilization"
     },
     {
@@ -38,29 +738,35 @@
     },
     {
         "BriefDescription": "Instructions Per Cycle across hyper-threads (=
per physical core)",
-        "MetricExpr": "INST_RETIRED.ANY / CPU_CLK_UNHALTED.DISTRIBUTED",
-        "MetricGroup": "Ret;SMT;TmaL1",
+        "MetricExpr": "INST_RETIRED.ANY / CORE_CLKS",
+        "MetricGroup": "Ret;SMT;tma_L1_group",
         "MetricName": "CoreIPC"
     },
     {
         "BriefDescription": "Floating Point Operations Per Cycle",
-        "MetricExpr": "( 1 * ( FP_ARITH_INST_RETIRED.SCALAR_SINGLE + FP_AR=
ITH_INST_RETIRED.SCALAR_DOUBLE + FP_ARITH_INST_RETIRED2.SCALAR_HALF ) + 2 *=
 ( FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + FP_ARITH_INST_RETIRED2.COMPLE=
X_SCALAR_HALF ) + 4 * ( FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE + FP_ARITH=
_INST_RETIRED.256B_PACKED_DOUBLE ) + 8 * ( FP_ARITH_INST_RETIRED2.128B_PACK=
ED_HALF + FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.=
512B_PACKED_DOUBLE ) + 16 * ( FP_ARITH_INST_RETIRED2.256B_PACKED_HALF + FP_=
ARITH_INST_RETIRED.512B_PACKED_SINGLE ) + 32 * FP_ARITH_INST_RETIRED2.512B_=
PACKED_HALF + 4 * AMX_OPS_RETIRED.BF16 ) / CPU_CLK_UNHALTED.DISTRIBUTED",
-        "MetricGroup": "Ret;Flops",
+        "MetricExpr": "(1 * (FP_ARITH_INST_RETIRED.SCALAR_SINGLE + FP_ARIT=
H_INST_RETIRED.SCALAR_DOUBLE + FP_ARITH_INST_RETIRED2.SCALAR_HALF) + 2 * (F=
P_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + FP_ARITH_INST_RETIRED2.COMPLEX_SC=
ALAR_HALF) + 4 * (FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE + FP_ARITH_INST_=
RETIRED.256B_PACKED_DOUBLE) + 8 * (FP_ARITH_INST_RETIRED2.128B_PACKED_HALF =
+ FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.512B_PAC=
KED_DOUBLE) + 16 * (FP_ARITH_INST_RETIRED2.256B_PACKED_HALF + FP_ARITH_INST=
_RETIRED.512B_PACKED_SINGLE) + 32 * FP_ARITH_INST_RETIRED2.512B_PACKED_HALF=
 + 4 * AMX_OPS_RETIRED.BF16) / CORE_CLKS",
+        "MetricGroup": "Flops;Ret",
         "MetricName": "FLOPc"
     },
     {
         "BriefDescription": "Actual per-core usage of the Floating Point n=
on-X87 execution units (regardless of precision or vector-width)",
-        "MetricExpr": "( FP_ARITH_DISPATCHED.PORT_0 + FP_ARITH_DISPATCHED.=
PORT_1 + FP_ARITH_DISPATCHED.PORT_5 ) / ( 2 * CPU_CLK_UNHALTED.DISTRIBUTED =
)",
+        "MetricExpr": "(FP_ARITH_DISPATCHED.PORT_0 + FP_ARITH_DISPATCHED.P=
ORT_1 + FP_ARITH_DISPATCHED.PORT_5) / (2 * CORE_CLKS)",
         "MetricGroup": "Cor;Flops;HPC",
         "MetricName": "FP_Arith_Utilization",
         "PublicDescription": "Actual per-core usage of the Floating Point =
non-X87 execution units (regardless of precision or vector-width). Values >=
 1 are possible due to ([BDW+] Fused-Multiply Add (FMA) counting - common; =
[ADL+] use all of ADD/MUL/FMA in Scalar or 128/256-bit vectors - less commo=
n)."
     },
     {
         "BriefDescription": "Instruction-Level-Parallelism (average number=
 of uops executed when there is execution) per-core",
-        "MetricExpr": "UOPS_EXECUTED.THREAD / (( UOPS_EXECUTED.CORE_CYCLES=
_GE_1 / 2 ) if #SMT_on else UOPS_EXECUTED.CORE_CYCLES_GE_1)",
+        "MetricExpr": "UOPS_EXECUTED.THREAD / ((UOPS_EXECUTED.CORE_CYCLES_=
GE_1 / 2) if #SMT_on else UOPS_EXECUTED.CORE_CYCLES_GE_1)",
         "MetricGroup": "Backend;Cor;Pipeline;PortsUtil",
         "MetricName": "ILP"
     },
+    {
+        "BriefDescription": "Probability of Core Bound bottleneck hidden b=
y SMT-profiling artifacts",
+        "MetricExpr": "(1 - tma_core_bound / tma_ports_utilization if tma_=
core_bound < tma_ports_utilization else 1) if SMT_2T_Utilization > 0.5 else=
 0",
+        "MetricGroup": "Cor;SMT",
+        "MetricName": "Core_Bound_Likely"
+    },
     {
         "BriefDescription": "Core actual clocks when any Logical Processor=
 is active on the Physical Core",
         "MetricExpr": "CPU_CLK_UNHALTED.DISTRIBUTED",
@@ -105,13 +811,13 @@
     },
     {
         "BriefDescription": "Instructions per Floating Point (FP) Operatio=
n (lower number means higher occurrence rate)",
-        "MetricExpr": "INST_RETIRED.ANY / ( 1 * ( FP_ARITH_INST_RETIRED.SC=
ALAR_SINGLE + FP_ARITH_INST_RETIRED.SCALAR_DOUBLE + FP_ARITH_INST_RETIRED2.=
SCALAR_HALF ) + 2 * ( FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + FP_ARITH_I=
NST_RETIRED2.COMPLEX_SCALAR_HALF ) + 4 * ( FP_ARITH_INST_RETIRED.128B_PACKE=
D_SINGLE + FP_ARITH_INST_RETIRED.256B_PACKED_DOUBLE ) + 8 * ( FP_ARITH_INST=
_RETIRED2.128B_PACKED_HALF + FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE + FP_=
ARITH_INST_RETIRED.512B_PACKED_DOUBLE ) + 16 * ( FP_ARITH_INST_RETIRED2.256=
B_PACKED_HALF + FP_ARITH_INST_RETIRED.512B_PACKED_SINGLE ) + 32 * FP_ARITH_=
INST_RETIRED2.512B_PACKED_HALF + 4 * AMX_OPS_RETIRED.BF16 )",
+        "MetricExpr": "INST_RETIRED.ANY / (1 * (FP_ARITH_INST_RETIRED.SCAL=
AR_SINGLE + FP_ARITH_INST_RETIRED.SCALAR_DOUBLE + FP_ARITH_INST_RETIRED2.SC=
ALAR_HALF) + 2 * (FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + FP_ARITH_INST_=
RETIRED2.COMPLEX_SCALAR_HALF) + 4 * (FP_ARITH_INST_RETIRED.128B_PACKED_SING=
LE + FP_ARITH_INST_RETIRED.256B_PACKED_DOUBLE) + 8 * (FP_ARITH_INST_RETIRED=
2.128B_PACKED_HALF + FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE + FP_ARITH_IN=
ST_RETIRED.512B_PACKED_DOUBLE) + 16 * (FP_ARITH_INST_RETIRED2.256B_PACKED_H=
ALF + FP_ARITH_INST_RETIRED.512B_PACKED_SINGLE) + 32 * FP_ARITH_INST_RETIRE=
D2.512B_PACKED_HALF + 4 * AMX_OPS_RETIRED.BF16)",
         "MetricGroup": "Flops;InsType",
         "MetricName": "IpFLOP"
     },
     {
         "BriefDescription": "Instructions per FP Arithmetic instruction (l=
ower number means higher occurrence rate)",
-        "MetricExpr": "INST_RETIRED.ANY / ( (FP_ARITH_INST_RETIRED.SCALAR_=
SINGLE + FP_ARITH_INST_RETIRED.SCALAR_DOUBLE + FP_ARITH_INST_RETIRED2.SCALA=
R) + (FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + FP_ARITH_INST_RETIRED.128B=
_PACKED_SINGLE + FP_ARITH_INST_RETIRED.256B_PACKED_DOUBLE + FP_ARITH_INST_R=
ETIRED.256B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.512B_PACKED_DOUBLE + FP_A=
RITH_INST_RETIRED.512B_PACKED_SINGLE + FP_ARITH_INST_RETIRED2.VECTOR) )",
+        "MetricExpr": "INST_RETIRED.ANY / ((FP_ARITH_INST_RETIRED.SCALAR_S=
INGLE + FP_ARITH_INST_RETIRED.SCALAR_DOUBLE + FP_ARITH_INST_RETIRED2.SCALAR=
) + (FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + FP_ARITH_INST_RETIRED.128B_=
PACKED_SINGLE + FP_ARITH_INST_RETIRED.256B_PACKED_DOUBLE + FP_ARITH_INST_RE=
TIRED.256B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.512B_PACKED_DOUBLE + FP_AR=
ITH_INST_RETIRED.512B_PACKED_SINGLE + FP_ARITH_INST_RETIRED2.VECTOR))",
         "MetricGroup": "Flops;InsType",
         "MetricName": "IpArith",
         "PublicDescription": "Instructions per FP Arithmetic instruction (=
lower number means higher occurrence rate). May undercount due to FMA doubl=
e counting. Approximated prior to BDW."
@@ -132,21 +838,21 @@
     },
     {
         "BriefDescription": "Instructions per FP Arithmetic AVX/SSE 128-bi=
t instruction (lower number means higher occurrence rate)",
-        "MetricExpr": "INST_RETIRED.ANY / ( FP_ARITH_INST_RETIRED.128B_PAC=
KED_DOUBLE + FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE + FP_ARITH_INST_RETIR=
ED2.128B_PACKED_HALF )",
+        "MetricExpr": "INST_RETIRED.ANY / (FP_ARITH_INST_RETIRED.128B_PACK=
ED_DOUBLE + FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE + FP_ARITH_INST_RETIRE=
D2.128B_PACKED_HALF)",
         "MetricGroup": "Flops;FpVector;InsType",
         "MetricName": "IpArith_AVX128",
         "PublicDescription": "Instructions per FP Arithmetic AVX/SSE 128-b=
it instruction (lower number means higher occurrence rate). May undercount =
due to FMA double counting."
     },
     {
         "BriefDescription": "Instructions per FP Arithmetic AVX* 256-bit i=
nstruction (lower number means higher occurrence rate)",
-        "MetricExpr": "INST_RETIRED.ANY / ( FP_ARITH_INST_RETIRED.256B_PAC=
KED_DOUBLE + FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE + FP_ARITH_INST_RETIR=
ED2.256B_PACKED_HALF )",
+        "MetricExpr": "INST_RETIRED.ANY / (FP_ARITH_INST_RETIRED.256B_PACK=
ED_DOUBLE + FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE + FP_ARITH_INST_RETIRE=
D2.256B_PACKED_HALF)",
         "MetricGroup": "Flops;FpVector;InsType",
         "MetricName": "IpArith_AVX256",
         "PublicDescription": "Instructions per FP Arithmetic AVX* 256-bit =
instruction (lower number means higher occurrence rate). May undercount due=
 to FMA double counting."
     },
     {
         "BriefDescription": "Instructions per FP Arithmetic AVX 512-bit in=
struction (lower number means higher occurrence rate)",
-        "MetricExpr": "INST_RETIRED.ANY / ( FP_ARITH_INST_RETIRED.512B_PAC=
KED_DOUBLE + FP_ARITH_INST_RETIRED.512B_PACKED_SINGLE + FP_ARITH_INST_RETIR=
ED2.512B_PACKED_HALF )",
+        "MetricExpr": "INST_RETIRED.ANY / (FP_ARITH_INST_RETIRED.512B_PACK=
ED_DOUBLE + FP_ARITH_INST_RETIRED.512B_PACKED_SINGLE + FP_ARITH_INST_RETIRE=
D2.512B_PACKED_HALF)",
         "MetricGroup": "Flops;FpVector;InsType",
         "MetricName": "IpArith_AVX512",
         "PublicDescription": "Instructions per FP Arithmetic AVX 512-bit i=
nstruction (lower number means higher occurrence rate). May undercount due =
to FMA double counting."
@@ -161,7 +867,7 @@
     {
         "BriefDescription": "Instructions per Integer Arithmetic AMX opera=
tion (lower number means higher occurrence rate)",
         "MetricExpr": "INST_RETIRED.ANY / AMX_OPS_RETIRED.INT8",
-        "MetricGroup": "IntVector;InsType;Server",
+        "MetricGroup": "InsType;IntVector;Server",
         "MetricName": "IpArith_AMX_Int8",
         "PublicDescription": "Instructions per Integer Arithmetic AMX oper=
ation (lower number means higher occurrence rate). Operations factored per =
matrices' sizes of the AMX instructions."
     },
@@ -172,11 +878,17 @@
         "MetricName": "IpSWPF"
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
+    {
+        "BriefDescription": "Average number of Uops retired in cycles wher=
e at least one uop has retired.",
+        "MetricExpr": "(tma_retiring * SLOTS) / cpu@UOPS_RETIRED.SLOTS\\,c=
mask\\=3D1@",
+        "MetricGroup": "Pipeline;Ret",
+        "MetricName": "Retire"
+    },
     {
         "BriefDescription": "Estimated fraction of retirement-cycles deali=
ng with repeat instructions",
         "MetricExpr": "INST_RETIRED.REP_ITERATION / cpu@UOPS_RETIRED.SLOTS=
\\,cmask\\=3D1@",
@@ -213,6 +925,12 @@
         "MetricGroup": "DSBmiss",
         "MetricName": "DSB_Switch_Cost"
     },
+    {
+        "BriefDescription": "Total penalty related to DSB (uop cache) miss=
es - subset of the Instruction_Fetch_BW Bottleneck.",
+        "MetricExpr": "100 * (tma_fetch_latency * tma_dsb_switches / (tma_=
branch_resteers + tma_dsb_switches + tma_icache_misses + tma_itlb_misses + =
tma_lcp + tma_ms_switches) + tma_fetch_bandwidth * tma_mite / (tma_dsb + tm=
a_mite))",
+        "MetricGroup": "DSBmiss;Fed",
+        "MetricName": "DSB_Misses"
+    },
     {
         "BriefDescription": "Number of Instructions per non-speculative DS=
B miss (lower number means higher occurrence rate)",
         "MetricExpr": "INST_RETIRED.ANY / FRONTEND_RETIRED.ANY_DSB_MISS",
@@ -225,6 +943,12 @@
         "MetricGroup": "Bad;BadSpec;BrMispredicts",
         "MetricName": "IpMispredict"
     },
+    {
+        "BriefDescription": "Branch Misprediction Cost: Fraction of TMA sl=
ots wasted per non-speculative branch misprediction (retired JEClear)",
+        "MetricExpr": " (tma_branch_mispredicts + tma_fetch_latency * tma_=
mispredicts_resteers / (tma_branch_resteers + tma_dsb_switches + tma_icache=
_misses + tma_itlb_misses + tma_lcp + tma_ms_switches)) * SLOTS / BR_MISP_R=
ETIRED.ALL_BRANCHES",
+        "MetricGroup": "Bad;BrMispredicts",
+        "MetricName": "Branch_Misprediction_Cost"
+    },
     {
         "BriefDescription": "Fraction of branches that are non-taken condi=
tionals",
         "MetricExpr": "BR_INST_RETIRED.COND_NTAKEN / BR_INST_RETIRED.ALL_B=
RANCHES",
@@ -239,7 +963,7 @@
     },
     {
         "BriefDescription": "Fraction of branches that are CALL or RET",
-        "MetricExpr": "( BR_INST_RETIRED.NEAR_CALL + BR_INST_RETIRED.NEAR_=
RETURN ) / BR_INST_RETIRED.ALL_BRANCHES",
+        "MetricExpr": "(BR_INST_RETIRED.NEAR_CALL + BR_INST_RETIRED.NEAR_R=
ETURN) / BR_INST_RETIRED.ALL_BRANCHES",
         "MetricGroup": "Bad;Branches",
         "MetricName": "CallRet"
     },
@@ -251,7 +975,7 @@
     },
     {
         "BriefDescription": "Fraction of branches of other types (not indi=
vidually covered by other metrics in Info.Branches group)",
-        "MetricExpr": "1 - ( (BR_INST_RETIRED.COND_NTAKEN / BR_INST_RETIRE=
D.ALL_BRANCHES) + (BR_INST_RETIRED.COND_TAKEN / BR_INST_RETIRED.ALL_BRANCHE=
S) + (( BR_INST_RETIRED.NEAR_CALL + BR_INST_RETIRED.NEAR_RETURN ) / BR_INST=
_RETIRED.ALL_BRANCHES) + ((BR_INST_RETIRED.NEAR_TAKEN - BR_INST_RETIRED.CON=
D_TAKEN - 2 * BR_INST_RETIRED.NEAR_CALL) / BR_INST_RETIRED.ALL_BRANCHES) )"=
,
+        "MetricExpr": "1 - (Cond_NT + Cond_TK + CallRet + Jump)",
         "MetricGroup": "Bad;Branches",
         "MetricName": "Other_Branches"
     },
@@ -264,67 +988,67 @@
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
         "MetricExpr": "1000 * MEM_LOAD_RETIRED.L1_MISS / INST_RETIRED.ANY"=
,
-        "MetricGroup": "Mem;CacheMisses",
+        "MetricGroup": "CacheMisses;Mem",
         "MetricName": "L1MPKI"
     },
     {
         "BriefDescription": "L1 cache true misses per kilo instruction for=
 all demand loads (including speculative)",
         "MetricExpr": "1000 * L2_RQSTS.ALL_DEMAND_DATA_RD / INST_RETIRED.A=
NY",
-        "MetricGroup": "Mem;CacheMisses",
+        "MetricGroup": "CacheMisses;Mem",
         "MetricName": "L1MPKI_Load"
     },
     {
         "BriefDescription": "L2 cache true misses per kilo instruction for=
 retired demand loads",
         "MetricExpr": "1000 * MEM_LOAD_RETIRED.L2_MISS / INST_RETIRED.ANY"=
,
-        "MetricGroup": "Mem;Backend;CacheMisses",
+        "MetricGroup": "Backend;CacheMisses;Mem",
         "MetricName": "L2MPKI"
     },
     {
         "BriefDescription": "L2 cache ([RKL+] true) misses per kilo instru=
ction for all request types (including speculative)",
         "MetricExpr": "1000 * L2_RQSTS.MISS / INST_RETIRED.ANY",
-        "MetricGroup": "Mem;CacheMisses;Offcore",
+        "MetricGroup": "CacheMisses;Mem;Offcore",
         "MetricName": "L2MPKI_All"
     },
     {
         "BriefDescription": "L2 cache ([RKL+] true) misses per kilo instru=
ction for all demand loads  (including speculative)",
         "MetricExpr": "1000 * L2_RQSTS.DEMAND_DATA_RD_MISS / INST_RETIRED.=
ANY",
-        "MetricGroup": "Mem;CacheMisses",
+        "MetricGroup": "CacheMisses;Mem",
         "MetricName": "L2MPKI_Load"
     },
     {
         "BriefDescription": "L2 cache hits per kilo instruction for all re=
quest types (including speculative)",
-        "MetricExpr": "1000 * ( L2_RQSTS.REFERENCES - L2_RQSTS.MISS ) / IN=
ST_RETIRED.ANY",
-        "MetricGroup": "Mem;CacheMisses",
+        "MetricExpr": "1000 * (L2_RQSTS.REFERENCES - L2_RQSTS.MISS) / INST=
_RETIRED.ANY",
+        "MetricGroup": "CacheMisses;Mem",
         "MetricName": "L2HPKI_All"
     },
     {
         "BriefDescription": "L2 cache hits per kilo instruction for all de=
mand loads  (including speculative)",
         "MetricExpr": "1000 * L2_RQSTS.DEMAND_DATA_RD_HIT / INST_RETIRED.A=
NY",
-        "MetricGroup": "Mem;CacheMisses",
+        "MetricGroup": "CacheMisses;Mem",
         "MetricName": "L2HPKI_Load"
     },
     {
         "BriefDescription": "L3 cache true misses per kilo instruction for=
 retired demand loads",
         "MetricExpr": "1000 * MEM_LOAD_RETIRED.L3_MISS / INST_RETIRED.ANY"=
,
-        "MetricGroup": "Mem;CacheMisses",
+        "MetricGroup": "CacheMisses;Mem",
         "MetricName": "L3MPKI"
     },
     {
         "BriefDescription": "Fill Buffer (FB) hits per kilo instructions f=
or retired demand loads (L1D misses that merge into ongoing miss-handling e=
ntries)",
         "MetricExpr": "1000 * MEM_LOAD_RETIRED.FB_HIT / INST_RETIRED.ANY",
-        "MetricGroup": "Mem;CacheMisses",
+        "MetricGroup": "CacheMisses;Mem",
         "MetricName": "FB_HPKI"
     },
     {
         "BriefDescription": "Utilization of the core's Page Walker(s) serv=
ing STLB misses triggered by instruction/Load/Store accesses",
         "MetricConstraint": "NO_NMI_WATCHDOG",
-        "MetricExpr": "( ITLB_MISSES.WALK_PENDING + DTLB_LOAD_MISSES.WALK_=
PENDING + DTLB_STORE_MISSES.WALK_PENDING ) / ( 4 * CPU_CLK_UNHALTED.DISTRIB=
UTED )",
+        "MetricExpr": "(ITLB_MISSES.WALK_PENDING + DTLB_LOAD_MISSES.WALK_P=
ENDING + DTLB_STORE_MISSES.WALK_PENDING) / (4 * CORE_CLKS)",
         "MetricGroup": "Mem;MemoryTLB",
         "MetricName": "Page_Walks_Utilization"
     },
@@ -354,37 +1078,37 @@
     },
     {
         "BriefDescription": "Rate of silent evictions from the L2 cache pe=
r Kilo instruction where the evicted lines are dropped (no writeback to L3 =
or memory)",
-        "MetricExpr": "1000 * L2_LINES_OUT.SILENT / INST_RETIRED.ANY",
+        "MetricExpr": "1000 * L2_LINES_OUT.SILENT / Instructions",
         "MetricGroup": "L2Evicts;Mem;Server",
         "MetricName": "L2_Evictions_Silent_PKI"
     },
     {
         "BriefDescription": "Rate of non silent evictions from the L2 cach=
e per Kilo instruction",
-        "MetricExpr": "1000 * L2_LINES_OUT.NON_SILENT / INST_RETIRED.ANY",
+        "MetricExpr": "1000 * L2_LINES_OUT.NON_SILENT / Instructions",
         "MetricGroup": "L2Evicts;Mem;Server",
         "MetricName": "L2_Evictions_NonSilent_PKI"
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
     {
         "BriefDescription": "Average per-thread data access bandwidth to t=
he L3 cache [GB / sec]",
-        "MetricExpr": "(64 * OFFCORE_REQUESTS.ALL_REQUESTS / 1000000000 / =
duration_time)",
+        "MetricExpr": "L3_Cache_Access_BW",
         "MetricGroup": "Mem;MemoryBW;Offcore",
         "MetricName": "L3_Cache_Access_BW_1T"
     },
@@ -396,26 +1120,26 @@
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
-        "MetricExpr": "( ( 1 * ( FP_ARITH_INST_RETIRED.SCALAR_SINGLE + FP_=
ARITH_INST_RETIRED.SCALAR_DOUBLE + FP_ARITH_INST_RETIRED2.SCALAR_HALF ) + 2=
 * ( FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + FP_ARITH_INST_RETIRED2.COMP=
LEX_SCALAR_HALF ) + 4 * ( FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE + FP_ARI=
TH_INST_RETIRED.256B_PACKED_DOUBLE ) + 8 * ( FP_ARITH_INST_RETIRED2.128B_PA=
CKED_HALF + FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE + FP_ARITH_INST_RETIRE=
D.512B_PACKED_DOUBLE ) + 16 * ( FP_ARITH_INST_RETIRED2.256B_PACKED_HALF + F=
P_ARITH_INST_RETIRED.512B_PACKED_SINGLE ) + 32 * FP_ARITH_INST_RETIRED2.512=
B_PACKED_HALF + 4 * AMX_OPS_RETIRED.BF16 ) / 1000000000 ) / duration_time",
+        "MetricExpr": "((1 * (FP_ARITH_INST_RETIRED.SCALAR_SINGLE + FP_ARI=
TH_INST_RETIRED.SCALAR_DOUBLE + FP_ARITH_INST_RETIRED2.SCALAR_HALF) + 2 * (=
FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + FP_ARITH_INST_RETIRED2.COMPLEX_S=
CALAR_HALF) + 4 * (FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE + FP_ARITH_INST=
_RETIRED.256B_PACKED_DOUBLE) + 8 * (FP_ARITH_INST_RETIRED2.128B_PACKED_HALF=
 + FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.512B_PA=
CKED_DOUBLE) + 16 * (FP_ARITH_INST_RETIRED2.256B_PACKED_HALF + FP_ARITH_INS=
T_RETIRED.512B_PACKED_SINGLE) + 32 * FP_ARITH_INST_RETIRED2.512B_PACKED_HAL=
F + 4 * AMX_OPS_RETIRED.BF16) / 1000000000) / duration_time",
         "MetricGroup": "Cor;Flops;HPC",
         "MetricName": "GFLOPs",
         "PublicDescription": "Giga Floating Point Operations Per Second. A=
ggregate across all supported options of: FP precisions, scalar and vector =
instructions, vector-width and AMX engine."
     },
     {
         "BriefDescription": "Tera Integer (matrix) Operations Per Second",
-        "MetricExpr": "( 8 * AMX_OPS_RETIRED.INT8 /  1000000000000 ) / dur=
ation_time",
+        "MetricExpr": "(8 * AMX_OPS_RETIRED.INT8 / 1e12) / duration_time",
         "MetricGroup": "Cor;HPC;IntVector;Server",
         "MetricName": "TIOPS"
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
@@ -439,13 +1163,13 @@
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
-        "MetricExpr": "1000000000 * ( UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD / =
UNC_CHA_TOR_INSERTS.IA_MISS_DRD ) / ( uncore_cha_0@event\\=3D0x1@ / duratio=
n_time )",
+        "MetricExpr": "1000000000 * (UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD / U=
NC_CHA_TOR_INSERTS.IA_MISS_DRD) / (Socket_CLKS / duration_time)",
         "MetricGroup": "Mem;MemoryLat;SoC",
         "MetricName": "MEM_Read_Latency"
     },
@@ -457,32 +1181,32 @@
     },
     {
         "BriefDescription": "Average latency of data read request to exter=
nal 3D X-Point memory [in nanoseconds]. Accounts for demand loads and L1/L2=
 data-read prefetches",
-        "MetricExpr": "( 1000000000 * ( UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_=
PMM / UNC_CHA_TOR_INSERTS.IA_MISS_DRD_PMM ) / uncore_cha_0@event\\=3D0x1@ )=
",
-        "MetricGroup": "Mem;MemoryLat;SoC;Server",
+        "MetricExpr": "(1000000000 * (UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_PM=
M / UNC_CHA_TOR_INSERTS.IA_MISS_DRD_PMM) / uncore_cha_0@event\\=3D0x1@)",
+        "MetricGroup": "Mem;MemoryLat;Server;SoC",
         "MetricName": "MEM_PMM_Read_Latency"
     },
     {
         "BriefDescription": "Average latency of data read request to exter=
nal DRAM memory [in nanoseconds]. Accounts for demand loads and L1/L2 data-=
read prefetches",
-        "MetricExpr": " 1000000000 * ( UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_D=
DR / UNC_CHA_TOR_INSERTS.IA_MISS_DRD_DDR ) / uncore_cha_0@event\\=3D0x1@",
-        "MetricGroup": "Mem;MemoryLat;SoC;Server",
+        "MetricExpr": " 1000000000 * (UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_DD=
R / UNC_CHA_TOR_INSERTS.IA_MISS_DRD_DDR) / uncore_cha_0@event\\=3D0x1@",
+        "MetricGroup": "Mem;MemoryLat;Server;SoC",
         "MetricName": "MEM_DRAM_Read_Latency"
     },
     {
         "BriefDescription": "Average 3DXP Memory Bandwidth Use for reads [=
GB / sec]",
-        "MetricExpr": "( ( 64 * UNC_M_PMM_RPQ_INSERTS / 1000000000 ) / dur=
ation_time )",
-        "MetricGroup": "Mem;MemoryBW;SoC;Server",
+        "MetricExpr": "((64 * UNC_M_PMM_RPQ_INSERTS / 1000000000) / durati=
on_time)",
+        "MetricGroup": "Mem;MemoryBW;Server;SoC",
         "MetricName": "PMM_Read_BW"
     },
     {
         "BriefDescription": "Average 3DXP Memory Bandwidth Use for Writes =
[GB / sec]",
-        "MetricExpr": "( ( 64 * UNC_M_PMM_WPQ_INSERTS / 1000000000 ) / dur=
ation_time )",
-        "MetricGroup": "Mem;MemoryBW;SoC;Server",
+        "MetricExpr": "((64 * UNC_M_PMM_WPQ_INSERTS / 1000000000) / durati=
on_time)",
+        "MetricGroup": "Mem;MemoryBW;Server;SoC",
         "MetricName": "PMM_Write_BW"
     },
     {
         "BriefDescription": "Average IO (network or disk) Bandwidth Use fo=
r Writes [GB / sec]",
         "MetricExpr": "UNC_CHA_TOR_INSERTS.IO_PCIRDCUR * 64 / 1000000000 /=
 duration_time",
-        "MetricGroup": "IoBW;Mem;SoC;Server",
+        "MetricGroup": "IoBW;Mem;Server;SoC",
         "MetricName": "IO_Write_BW"
     },
     {
@@ -491,12 +1215,6 @@
         "MetricGroup": "SoC",
         "MetricName": "Socket_CLKS"
     },
-    {
-        "BriefDescription": "Uncore frequency per die [GHZ]",
-        "MetricExpr": "uncore_cha_0@event\\=3D0x1@ / #num_dies / duration_=
time / 1000000000",
-        "MetricGroup": "SoC",
-        "MetricName": "UNCORE_FREQ"
-    },
     {
         "BriefDescription": "Instructions per Far Branch ( Far Branches ap=
ply upon transition from application to operating system, handling interrup=
ts, exceptions) [lower number means higher occurrence rate]",
         "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.FAR_BRANCH:u",
@@ -527,6 +1245,12 @@
         "MetricGroup": "Power",
         "MetricName": "C6_Pkg_Residency"
     },
+    {
+        "BriefDescription": "Uncore frequency per die [GHZ]",
+        "MetricExpr": "Socket_CLKS / #num_dies / duration_time / 100000000=
0",
+        "MetricGroup": "SoC",
+        "MetricName": "UNCORE_FREQ"
+    },
     {
         "BriefDescription": "Percentage of time spent in the active CPU po=
wer state C0",
         "MetricExpr": "100 * CPU_CLK_UNHALTED.REF_TSC / TSC",
@@ -620,42 +1344,42 @@
     },
     {
         "BriefDescription": "Ratio of number of code read requests missing=
 last level core cache (includes demand w/ prefetches) to the total number =
of completed instructions",
-        "MetricExpr": "( UNC_CHA_TOR_INSERTS.IA_MISS_CRD ) / INST_RETIRED.=
ANY",
+        "MetricExpr": "UNC_CHA_TOR_INSERTS.IA_MISS_CRD / INST_RETIRED.ANY"=
,
         "MetricGroup": "",
         "MetricName": "llc_code_read_mpi_demand_plus_prefetch",
         "ScaleUnit": "1per_instr"
     },
     {
         "BriefDescription": "Average latency of a last level cache (LLC) d=
emand data read miss (read memory access) in nano seconds",
-        "MetricExpr": "( ( 1000000000 * ( UNC_CHA_TOR_OCCUPANCY.IA_MISS_DR=
D / UNC_CHA_TOR_INSERTS.IA_MISS_DRD ) / ( UNC_CHA_CLOCKTICKS / ( source_cou=
nt(UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD) * #num_packages ) ) ) * duration_time=
 )",
+        "MetricExpr": "( 1000000000 * ( UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD =
/ UNC_CHA_TOR_INSERTS.IA_MISS_DRD ) / ( UNC_CHA_CLOCKTICKS / ( source_count=
(UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD) * #num_packages ) ) ) * duration_time",
         "MetricGroup": "",
         "MetricName": "llc_demand_data_read_miss_latency",
         "ScaleUnit": "1ns"
     },
     {
         "BriefDescription": "Average latency of a last level cache (LLC) d=
emand data read miss (read memory access) addressed to local memory in nano=
 seconds",
-        "MetricExpr": "( ( 1000000000 * ( UNC_CHA_TOR_OCCUPANCY.IA_MISS_DR=
D_LOCAL / UNC_CHA_TOR_INSERTS.IA_MISS_DRD_LOCAL ) / ( UNC_CHA_CLOCKTICKS / =
( source_count(UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_LOCAL) * #num_packages ) )=
 ) * duration_time )",
+        "MetricExpr": "( 1000000000 * ( UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_=
LOCAL / UNC_CHA_TOR_INSERTS.IA_MISS_DRD_LOCAL ) / ( UNC_CHA_CLOCKTICKS / ( =
source_count(UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_LOCAL) * #num_packages ) ) )=
 * duration_time",
         "MetricGroup": "",
         "MetricName": "llc_demand_data_read_miss_latency_for_local_request=
s",
         "ScaleUnit": "1ns"
     },
     {
         "BriefDescription": "Average latency of a last level cache (LLC) d=
emand data read miss (read memory access) addressed to remote memory in nan=
o seconds",
-        "MetricExpr": "( ( 1000000000 * ( UNC_CHA_TOR_OCCUPANCY.IA_MISS_DR=
D_REMOTE / UNC_CHA_TOR_INSERTS.IA_MISS_DRD_REMOTE ) / ( UNC_CHA_CLOCKTICKS =
/ ( source_count(UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_REMOTE) * #num_packages =
) ) ) * duration_time )",
+        "MetricExpr": "( 1000000000 * ( UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_=
REMOTE / UNC_CHA_TOR_INSERTS.IA_MISS_DRD_REMOTE ) / ( UNC_CHA_CLOCKTICKS / =
( source_count(UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_REMOTE) * #num_packages ) =
) ) * duration_time",
         "MetricGroup": "",
         "MetricName": "llc_demand_data_read_miss_latency_for_remote_reques=
ts",
         "ScaleUnit": "1ns"
     },
     {
         "BriefDescription": "Average latency of a last level cache (LLC) d=
emand data read miss (read memory access) addressed to Intel(R) Optane(TM) =
Persistent Memory(PMEM) in nano seconds",
-        "MetricExpr": "( ( 1000000000 * ( UNC_CHA_TOR_OCCUPANCY.IA_MISS_DR=
D_PMM / UNC_CHA_TOR_INSERTS.IA_MISS_DRD_PMM ) / ( UNC_CHA_CLOCKTICKS / ( so=
urce_count(UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_PMM) * #num_packages ) ) ) * d=
uration_time )",
+        "MetricExpr": "( 1000000000 * ( UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_=
PMM / UNC_CHA_TOR_INSERTS.IA_MISS_DRD_PMM ) / ( UNC_CHA_CLOCKTICKS / ( sour=
ce_count(UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_PMM) * #num_packages ) ) ) * dur=
ation_time",
         "MetricGroup": "",
         "MetricName": "llc_demand_data_read_miss_to_pmem_latency",
         "ScaleUnit": "1ns"
     },
     {
         "BriefDescription": "Average latency of a last level cache (LLC) d=
emand data read miss (read memory access) addressed to DRAM in nano seconds=
",
-        "MetricExpr": "( ( 1000000000 * ( UNC_CHA_TOR_OCCUPANCY.IA_MISS_DR=
D_DDR / UNC_CHA_TOR_INSERTS.IA_MISS_DRD_DDR ) / ( UNC_CHA_CLOCKTICKS / ( so=
urce_count(UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_DDR) * #num_packages ) ) ) * d=
uration_time )",
+        "MetricExpr": "( 1000000000 * ( UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_=
DDR / UNC_CHA_TOR_INSERTS.IA_MISS_DRD_DDR ) / ( UNC_CHA_CLOCKTICKS / ( sour=
ce_count(UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_DDR) * #num_packages ) ) ) * dur=
ation_time",
         "MetricGroup": "",
         "MetricName": "llc_demand_data_read_miss_to_dram_latency",
         "ScaleUnit": "1ns"
--=20
2.37.3.998.g577e59143f-goog

