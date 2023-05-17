Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FC22706CBD
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 17:27:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232428AbjEQP1j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 11:27:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232295AbjEQP1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 11:27:16 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA3DE93C8
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 08:26:58 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-b9a7e3fc659so1749224276.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 08:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684337218; x=1686929218;
        h=content-transfer-encoding:to:from:subject:references:mime-version
         :message-id:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=arCNAH4DUrBRhF1S2IvuhWJMPpu8grMWaIbzVgUPpCo=;
        b=jut5iGlMEbZJX8EocNF7SFROxMdgC0BEl6jvKzm5ZbgnEpPz6IKyDA/9FTuyB34skc
         TldAoPOnLXljtGeVLaCuXwgUwVZYpnc2qhsRag1UskZcK7kgh2EzfURz5i9LlgY0ya2u
         cmDSHFQeiP8Yxjjj3ddrJ4woyTGNawmBSnJxODelv5EJXEnEMVBzsWyQwM82mNhsR3nx
         HZmeF90Jik37yZHBbmprhVaI8+oUHOzc+uxnxL95MSAzQEh0vvRi6ivhzYsQC0M+Sewk
         6V+WW9hHxFtA4xNQc0wrnsnfaHYSJNw8RlQbs6WSjUKX95DN7bhhEh2zi4krcypg0LJW
         dytQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684337218; x=1686929218;
        h=content-transfer-encoding:to:from:subject:references:mime-version
         :message-id:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=arCNAH4DUrBRhF1S2IvuhWJMPpu8grMWaIbzVgUPpCo=;
        b=G0hRmzYYCo8sVHevUOX6f6GP517sGRE7F0ZzViRr1veGwXnG2eJi6Ypa/K8lqUgImv
         I5YcSefUKnoHdcV4hHl2D9oAwnC4DjfI8wTsO01nPhQn8AwmRMTY6yDhdvi8SBmo4rP+
         /9N6ZRWBB2z65e5ByTqxVWtzv4aTaK6N8ipoME+oCzCEfsys3BOT0+0BN/9pjMpSJrBG
         ueOQOQ0KoMnbYf9Q6taq2HSy90hZyo7BojP9Df3e/CP9m93bhtTWcRQTadfx21ynjhJu
         TJrCu/crA3Nv2FA/R0KXK6FFV1B3RsCcLGo84ltscAZWWZIrLRnQXEqcKN0IPtbGpgC8
         ePVA==
X-Gm-Message-State: AC+VfDwYawhmTrHqa90sQ8U4eyvPDra54dRMSGdhFfQlkzqaJ9g32z1w
        B/4o7YyhxSbpFwM7bK/AXRuiFwXR6rhT
X-Google-Smtp-Source: ACHHUZ6KCehrVYABMQky71iEXMuzqSY+wMWRMglCiNzReGfS6HEkXW3VqWQCtMlitA5M/mKV7OV9/Dh0gKmc
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:628b:7e78:d09b:39b])
 (user=irogers job=sendgmr) by 2002:a25:253:0:b0:ba8:6b34:a6ce with SMTP id
 80-20020a250253000000b00ba86b34a6cemr689632ybc.8.1684337218179; Wed, 17 May
 2023 08:26:58 -0700 (PDT)
Date:   Wed, 17 May 2023 08:26:17 -0700
In-Reply-To: <20230517152626.563559-1-irogers@google.com>
Message-Id: <20230517152626.563559-7-irogers@google.com>
Mime-Version: 1.0
References: <20230517152626.563559-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
Subject: [PATCH v2 06/15] perf vendor events intel: Update icelake/icelakex events/metrics
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        John Garry <john.g.garry@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update icelake events to v1.18 including the new events
MEM_LOAD_MISC_RETIRED.UC and SQ_MISC.BUS_LOCK. Metrics are updated to
make TMA info metric names synchronized. Events and metrics were
generated by:
https://github.com/intel/perfmon/blob/main/scripts/create_perf_json.py

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../pmu-events/arch/x86/icelake/cache.json    |   18 +
 .../arch/x86/icelake/icl-metrics.json         |  950 ++++++------
 .../arch/x86/icelakex/icx-metrics.json        | 1306 ++++++++++-------
 tools/perf/pmu-events/arch/x86/mapfile.csv    |    2 +-
 4 files changed, 1276 insertions(+), 1000 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/icelake/cache.json b/tools/perf=
/pmu-events/arch/x86/icelake/cache.json
index a9174a0837f0..79b9f02a4b63 100644
--- a/tools/perf/pmu-events/arch/x86/icelake/cache.json
+++ b/tools/perf/pmu-events/arch/x86/icelake/cache.json
@@ -338,6 +338,16 @@
         "SampleAfterValue": "100003",
         "UMask": "0x8"
     },
+    {
+        "BriefDescription": "Retired instructions with at least 1 uncachea=
ble load or Bus Lock.",
+        "Data_LA": "1",
+        "EventCode": "0xd4",
+        "EventName": "MEM_LOAD_MISC_RETIRED.UC",
+        "PEBS": "1",
+        "PublicDescription": "Retired instructions with at least one load =
to uncacheable memory-type, or at least one cache-line split locked access =
(Bus Lock).",
+        "SampleAfterValue": "100007",
+        "UMask": "0x4"
+    },
     {
         "BriefDescription": "Number of completed demand load requests that=
 missed the L1, but hit the FB(fill buffer), because a preceding miss to th=
e same cacheline initiated the line to be brought into L1, but data is not =
yet ready in L1.",
         "Data_LA": "1",
@@ -833,6 +843,14 @@
         "SampleAfterValue": "1000003",
         "UMask": "0x4"
     },
+    {
+        "BriefDescription": "Counts bus locks, accounts for cache line spl=
it locks and UC locks.",
+        "EventCode": "0xF4",
+        "EventName": "SQ_MISC.BUS_LOCK",
+        "PublicDescription": "Counts the more expensive bus lock needed to=
 enforce cache coherency for certain memory accesses that need to be done a=
tomically.  Can be created by issuing an atomic instruction (via the LOCK p=
refix) which causes a cache line split or accesses uncacheable memory.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x10"
+    },
     {
         "BriefDescription": "Cycles the queue waiting for offcore response=
s is full.",
         "EventCode": "0xf4",
diff --git a/tools/perf/pmu-events/arch/x86/icelake/icl-metrics.json b/tool=
s/perf/pmu-events/arch/x86/icelake/icl-metrics.json
index ae8a96ec7fa5..20210742171d 100644
--- a/tools/perf/pmu-events/arch/x86/icelake/icl-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/icelake/icl-metrics.json
@@ -64,7 +64,7 @@
     },
     {
         "BriefDescription": "Uncore frequency per die [GHZ]",
-        "MetricExpr": "tma_info_socket_clks / #num_dies / duration_time / =
1e9",
+        "MetricExpr": "tma_info_system_socket_clks / #num_dies / duration_=
time / 1e9",
         "MetricGroup": "SoC",
         "MetricName": "UNCORE_FREQ"
     },
@@ -85,7 +85,7 @@
     },
     {
         "BriefDescription": "This metric estimates how often memory load a=
ccesses were aliased by preceding stores (in program order) with a 4K addre=
ss offset",
-        "MetricExpr": "LD_BLOCKS_PARTIAL.ADDRESS_ALIAS / tma_info_clks",
+        "MetricExpr": "LD_BLOCKS_PARTIAL.ADDRESS_ALIAS / tma_info_thread_c=
lks",
         "MetricGroup": "TopdownL4;tma_L4_group;tma_l1_bound_group",
         "MetricName": "tma_4k_aliasing",
         "MetricThreshold": "tma_4k_aliasing > 0.2 & (tma_l1_bound > 0.1 & =
(tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
@@ -94,7 +94,7 @@
     },
     {
         "BriefDescription": "This metric represents Core fraction of cycle=
s CPU dispatched uops on execution ports for ALU operations.",
-        "MetricExpr": "(UOPS_DISPATCHED.PORT_0 + UOPS_DISPATCHED.PORT_1 + =
UOPS_DISPATCHED.PORT_5 + UOPS_DISPATCHED.PORT_6) / (4 * tma_info_core_clks)=
",
+        "MetricExpr": "(UOPS_DISPATCHED.PORT_0 + UOPS_DISPATCHED.PORT_1 + =
UOPS_DISPATCHED.PORT_5 + UOPS_DISPATCHED.PORT_6) / (4 * tma_info_core_core_=
clks)",
         "MetricGroup": "TopdownL5;tma_L5_group;tma_ports_utilized_3m_group=
",
         "MetricName": "tma_alu_op_utilization",
         "MetricThreshold": "tma_alu_op_utilization > 0.6",
@@ -102,7 +102,7 @@
     },
     {
         "BriefDescription": "This metric estimates fraction of slots the C=
PU retired uops delivered by the Microcode_Sequencer as a result of Assists=
",
-        "MetricExpr": "100 * ASSISTS.ANY / tma_info_slots",
+        "MetricExpr": "100 * ASSISTS.ANY / tma_info_thread_slots",
         "MetricGroup": "TopdownL4;tma_L4_group;tma_microcode_sequencer_gro=
up",
         "MetricName": "tma_assists",
         "MetricThreshold": "tma_assists > 0.1 & (tma_microcode_sequencer >=
 0.05 & tma_heavy_operations > 0.1)",
@@ -111,7 +111,7 @@
     },
     {
         "BriefDescription": "This category represents fraction of slots wh=
ere no uops are being delivered due to a lack of required resources for acc=
epting new uops in the Backend",
-        "MetricExpr": "topdown\\-be\\-bound / (topdown\\-fe\\-bound + topd=
own\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) + 5 * cpu@INT=
_MISC.RECOVERY_CYCLES\\,cmask\\=3D1\\,edge@ / tma_info_slots",
+        "MetricExpr": "topdown\\-be\\-bound / (topdown\\-fe\\-bound + topd=
own\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) + 5 * cpu@INT=
_MISC.RECOVERY_CYCLES\\,cmask\\=3D1\\,edge@ / tma_info_thread_slots",
         "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
         "MetricName": "tma_backend_bound",
         "MetricThreshold": "tma_backend_bound > 0.2",
@@ -131,7 +131,7 @@
     },
     {
         "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring branch instructions.",
-        "MetricExpr": "tma_light_operations * BR_INST_RETIRED.ALL_BRANCHES=
 / (tma_retiring * tma_info_slots)",
+        "MetricExpr": "tma_light_operations * BR_INST_RETIRED.ALL_BRANCHES=
 / (tma_retiring * tma_info_thread_slots)",
         "MetricGroup": "Pipeline;TopdownL3;tma_L3_group;tma_light_operatio=
ns_group",
         "MetricName": "tma_branch_instructions",
         "MetricThreshold": "tma_branch_instructions > 0.1 & tma_light_oper=
ations > 0.6",
@@ -144,12 +144,12 @@
         "MetricName": "tma_branch_mispredicts",
         "MetricThreshold": "tma_branch_mispredicts > 0.1 & tma_bad_specula=
tion > 0.15",
         "MetricgroupNoGroup": "TopdownL2",
-        "PublicDescription": "This metric represents fraction of slots the=
 CPU has wasted due to Branch Misprediction.  These slots are either wasted=
 by uops fetched from an incorrectly speculated program path; or stalls whe=
n the out-of-order part of the machine needs to recover its state from a sp=
eculative path. Sample with: BR_MISP_RETIRED.ALL_BRANCHES. Related metrics:=
 tma_info_branch_misprediction_cost, tma_info_mispredictions, tma_mispredic=
ts_resteers",
+        "PublicDescription": "This metric represents fraction of slots the=
 CPU has wasted due to Branch Misprediction.  These slots are either wasted=
 by uops fetched from an incorrectly speculated program path; or stalls whe=
n the out-of-order part of the machine needs to recover its state from a sp=
eculative path. Sample with: BR_MISP_RETIRED.ALL_BRANCHES. Related metrics:=
 tma_info_bad_spec_branch_misprediction_cost, tma_info_bottleneck_mispredic=
tions, tma_mispredicts_resteers",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to Branch Resteers",
-        "MetricExpr": "INT_MISC.CLEAR_RESTEER_CYCLES / tma_info_clks + tma=
_unknown_branches",
+        "MetricExpr": "INT_MISC.CLEAR_RESTEER_CYCLES / tma_info_thread_clk=
s + tma_unknown_branches",
         "MetricGroup": "FetchLat;TopdownL3;tma_L3_group;tma_fetch_latency_=
group",
         "MetricName": "tma_branch_resteers",
         "MetricThreshold": "tma_branch_resteers > 0.05 & (tma_fetch_latenc=
y > 0.1 & tma_frontend_bound > 0.15)",
@@ -167,7 +167,7 @@
     },
     {
         "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to Branch Resteers as a result of Machine Clears",
-        "MetricExpr": "(1 - BR_MISP_RETIRED.ALL_BRANCHES / (BR_MISP_RETIRE=
D.ALL_BRANCHES + MACHINE_CLEARS.COUNT)) * INT_MISC.CLEAR_RESTEER_CYCLES / t=
ma_info_clks",
+        "MetricExpr": "(1 - BR_MISP_RETIRED.ALL_BRANCHES / (BR_MISP_RETIRE=
D.ALL_BRANCHES + MACHINE_CLEARS.COUNT)) * INT_MISC.CLEAR_RESTEER_CYCLES / t=
ma_info_thread_clks",
         "MetricGroup": "BadSpec;MachineClears;TopdownL4;tma_L4_group;tma_b=
ranch_resteers_group;tma_issueMC",
         "MetricName": "tma_clears_resteers",
         "MetricThreshold": "tma_clears_resteers > 0.05 & (tma_branch_reste=
ers > 0.05 & (tma_fetch_latency > 0.1 & tma_frontend_bound > 0.15))",
@@ -177,7 +177,7 @@
     {
         "BriefDescription": "This metric estimates fraction of cycles whil=
e the memory subsystem was handling synchronizations due to contested acces=
ses",
         "MetricConstraint": "NO_GROUP_EVENTS",
-        "MetricExpr": "(29 * tma_info_average_frequency * MEM_LOAD_L3_HIT_=
RETIRED.XSNP_HITM + 23.5 * tma_info_average_frequency * MEM_LOAD_L3_HIT_RET=
IRED.XSNP_MISS) * (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS /=
 2) / tma_info_clks",
+        "MetricExpr": "(29 * tma_info_system_average_frequency * MEM_LOAD_=
L3_HIT_RETIRED.XSNP_HITM + 23.5 * tma_info_system_average_frequency * MEM_L=
OAD_L3_HIT_RETIRED.XSNP_MISS) * (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RET=
IRED.L1_MISS / 2) / tma_info_thread_clks",
         "MetricGroup": "DataSharing;Offcore;Snoop;TopdownL4;tma_L4_group;t=
ma_issueSyncxn;tma_l3_bound_group",
         "MetricName": "tma_contested_accesses",
         "MetricThreshold": "tma_contested_accesses > 0.05 & (tma_l3_bound =
> 0.05 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
@@ -197,7 +197,7 @@
     {
         "BriefDescription": "This metric estimates fraction of cycles whil=
e the memory subsystem was handling synchronizations due to data-sharing ac=
cesses",
         "MetricConstraint": "NO_GROUP_EVENTS",
-        "MetricExpr": "23.5 * tma_info_average_frequency * MEM_LOAD_L3_HIT=
_RETIRED.XSNP_HIT * (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS=
 / 2) / tma_info_clks",
+        "MetricExpr": "23.5 * tma_info_system_average_frequency * MEM_LOAD=
_L3_HIT_RETIRED.XSNP_HIT * (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.=
L1_MISS / 2) / tma_info_thread_clks",
         "MetricGroup": "Offcore;Snoop;TopdownL4;tma_L4_group;tma_issueSync=
xn;tma_l3_bound_group",
         "MetricName": "tma_data_sharing",
         "MetricThreshold": "tma_data_sharing > 0.05 & (tma_l3_bound > 0.05=
 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
@@ -206,16 +206,16 @@
     },
     {
         "BriefDescription": "This metric represents fraction of cycles whe=
re decoder-0 was the only active decoder",
-        "MetricExpr": "(cpu@INST_DECODED.DECODERS\\,cmask\\=3D1@ - cpu@INS=
T_DECODED.DECODERS\\,cmask\\=3D2@) / tma_info_core_clks / 2",
+        "MetricExpr": "(cpu@INST_DECODED.DECODERS\\,cmask\\=3D1@ - cpu@INS=
T_DECODED.DECODERS\\,cmask\\=3D2@) / tma_info_core_core_clks / 2",
         "MetricGroup": "DSBmiss;FetchBW;TopdownL4;tma_L4_group;tma_issueD0=
;tma_mite_group",
         "MetricName": "tma_decoder0_alone",
-        "MetricThreshold": "tma_decoder0_alone > 0.1 & (tma_mite > 0.1 & (=
tma_fetch_bandwidth > 0.1 & tma_frontend_bound > 0.15 & tma_info_ipc / 5 > =
0.35))",
+        "MetricThreshold": "tma_decoder0_alone > 0.1 & (tma_mite > 0.1 & (=
tma_fetch_bandwidth > 0.1 & tma_frontend_bound > 0.15 & tma_info_thread_ipc=
 / 5 > 0.35))",
         "PublicDescription": "This metric represents fraction of cycles wh=
ere decoder-0 was the only active decoder. Related metrics: tma_few_uops_in=
structions",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "This metric represents fraction of cycles whe=
re the Divider unit was active",
-        "MetricExpr": "ARITH.DIVIDER_ACTIVE / tma_info_clks",
+        "MetricExpr": "ARITH.DIVIDER_ACTIVE / tma_info_thread_clks",
         "MetricGroup": "TopdownL3;tma_L3_group;tma_core_bound_group",
         "MetricName": "tma_divider",
         "MetricThreshold": "tma_divider > 0.2 & (tma_core_bound > 0.1 & tm=
a_backend_bound > 0.2)",
@@ -225,7 +225,7 @@
     {
         "BriefDescription": "This metric estimates how often the CPU was s=
talled on accesses to external memory (DRAM) by loads",
         "MetricConstraint": "NO_GROUP_EVENTS",
-        "MetricExpr": "CYCLE_ACTIVITY.STALLS_L3_MISS / tma_info_clks + (CY=
CLE_ACTIVITY.STALLS_L1D_MISS - CYCLE_ACTIVITY.STALLS_L2_MISS) / tma_info_cl=
ks - tma_l2_bound",
+        "MetricExpr": "CYCLE_ACTIVITY.STALLS_L3_MISS / tma_info_thread_clk=
s + (CYCLE_ACTIVITY.STALLS_L1D_MISS - CYCLE_ACTIVITY.STALLS_L2_MISS) / tma_=
info_thread_clks - tma_l2_bound",
         "MetricGroup": "MemoryBound;TmaL3mem;TopdownL3;tma_L3_group;tma_me=
mory_bound_group",
         "MetricName": "tma_dram_bound",
         "MetricThreshold": "tma_dram_bound > 0.1 & (tma_memory_bound > 0.2=
 & tma_backend_bound > 0.2)",
@@ -234,43 +234,43 @@
     },
     {
         "BriefDescription": "This metric represents Core fraction of cycle=
s in which CPU was likely limited due to DSB (decoded uop cache) fetch pipe=
line",
-        "MetricExpr": "(IDQ.DSB_CYCLES_ANY - IDQ.DSB_CYCLES_OK) / tma_info=
_core_clks / 2",
+        "MetricExpr": "(IDQ.DSB_CYCLES_ANY - IDQ.DSB_CYCLES_OK) / tma_info=
_core_core_clks / 2",
         "MetricGroup": "DSB;FetchBW;TopdownL3;tma_L3_group;tma_fetch_bandw=
idth_group",
         "MetricName": "tma_dsb",
-        "MetricThreshold": "tma_dsb > 0.15 & (tma_fetch_bandwidth > 0.1 & =
tma_frontend_bound > 0.15 & tma_info_ipc / 5 > 0.35)",
+        "MetricThreshold": "tma_dsb > 0.15 & (tma_fetch_bandwidth > 0.1 & =
tma_frontend_bound > 0.15 & tma_info_thread_ipc / 5 > 0.35)",
         "PublicDescription": "This metric represents Core fraction of cycl=
es in which CPU was likely limited due to DSB (decoded uop cache) fetch pip=
eline.  For example; inefficient utilization of the DSB cache structure or =
bank conflict when reading from it; are categorized here.",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to switches from DSB to MITE pipelines",
-        "MetricExpr": "DSB2MITE_SWITCHES.PENALTY_CYCLES / tma_info_clks",
+        "MetricExpr": "DSB2MITE_SWITCHES.PENALTY_CYCLES / tma_info_thread_=
clks",
         "MetricGroup": "DSBmiss;FetchLat;TopdownL3;tma_L3_group;tma_fetch_=
latency_group;tma_issueFB",
         "MetricName": "tma_dsb_switches",
         "MetricThreshold": "tma_dsb_switches > 0.05 & (tma_fetch_latency >=
 0.1 & tma_frontend_bound > 0.15)",
-        "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to switches from DSB to MITE pipelines. The DSB (deco=
ded i-cache) is a Uop Cache where the front-end directly delivers Uops (mic=
ro operations) avoiding heavy x86 decoding. The DSB pipeline has shorter la=
tency and delivered higher bandwidth than the MITE (legacy instruction deco=
de pipeline). Switching between the two pipelines can cause penalties hence=
 this metric measures the exposed penalty. Sample with: FRONTEND_RETIRED.DS=
B_MISS_PS. Related metrics: tma_fetch_bandwidth, tma_info_dsb_coverage, tma=
_info_dsb_misses, tma_info_iptb, tma_lcp",
+        "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to switches from DSB to MITE pipelines. The DSB (deco=
ded i-cache) is a Uop Cache where the front-end directly delivers Uops (mic=
ro operations) avoiding heavy x86 decoding. The DSB pipeline has shorter la=
tency and delivered higher bandwidth than the MITE (legacy instruction deco=
de pipeline). Switching between the two pipelines can cause penalties hence=
 this metric measures the exposed penalty. Sample with: FRONTEND_RETIRED.DS=
B_MISS_PS. Related metrics: tma_fetch_bandwidth, tma_info_botlnk_l2_dsb_mis=
ses, tma_info_frontend_dsb_coverage, tma_info_inst_mix_iptb, tma_lcp",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "This metric roughly estimates the fraction of=
 cycles where the Data TLB (DTLB) was missed by load accesses",
-        "MetricExpr": "min(7 * cpu@DTLB_LOAD_MISSES.STLB_HIT\\,cmask\\=3D1=
@ + DTLB_LOAD_MISSES.WALK_ACTIVE, max(CYCLE_ACTIVITY.CYCLES_MEM_ANY - CYCLE=
_ACTIVITY.CYCLES_L1D_MISS, 0)) / tma_info_clks",
+        "MetricExpr": "min(7 * cpu@DTLB_LOAD_MISSES.STLB_HIT\\,cmask\\=3D1=
@ + DTLB_LOAD_MISSES.WALK_ACTIVE, max(CYCLE_ACTIVITY.CYCLES_MEM_ANY - CYCLE=
_ACTIVITY.CYCLES_L1D_MISS, 0)) / tma_info_thread_clks",
         "MetricGroup": "MemoryTLB;TopdownL4;tma_L4_group;tma_issueTLB;tma_=
l1_bound_group",
         "MetricName": "tma_dtlb_load",
         "MetricThreshold": "tma_dtlb_load > 0.1 & (tma_l1_bound > 0.1 & (t=
ma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
-        "PublicDescription": "This metric roughly estimates the fraction o=
f cycles where the Data TLB (DTLB) was missed by load accesses. TLBs (Trans=
lation Look-aside Buffers) are processor caches for recently used entries o=
ut of the Page Tables that are used to map virtual- to physical-addresses b=
y the operating system. This metric approximates the potential delay of dem=
and loads missing the first-level data TLB (assuming worst case scenario wi=
th back to back misses to different pages). This includes hitting in the se=
cond-level TLB (STLB) as well as performing a hardware page walk on an STLB=
 miss. Sample with: MEM_INST_RETIRED.STLB_MISS_LOADS_PS. Related metrics: t=
ma_dtlb_store, tma_info_memory_data_tlbs",
+        "PublicDescription": "This metric roughly estimates the fraction o=
f cycles where the Data TLB (DTLB) was missed by load accesses. TLBs (Trans=
lation Look-aside Buffers) are processor caches for recently used entries o=
ut of the Page Tables that are used to map virtual- to physical-addresses b=
y the operating system. This metric approximates the potential delay of dem=
and loads missing the first-level data TLB (assuming worst case scenario wi=
th back to back misses to different pages). This includes hitting in the se=
cond-level TLB (STLB) as well as performing a hardware page walk on an STLB=
 miss. Sample with: MEM_INST_RETIRED.STLB_MISS_LOADS_PS. Related metrics: t=
ma_dtlb_store, tma_info_bottleneck_memory_data_tlbs",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "This metric roughly estimates the fraction of=
 cycles spent handling first-level data TLB store misses",
-        "MetricExpr": "(7 * cpu@DTLB_STORE_MISSES.STLB_HIT\\,cmask\\=3D1@ =
+ DTLB_STORE_MISSES.WALK_ACTIVE) / tma_info_core_clks",
+        "MetricExpr": "(7 * cpu@DTLB_STORE_MISSES.STLB_HIT\\,cmask\\=3D1@ =
+ DTLB_STORE_MISSES.WALK_ACTIVE) / tma_info_core_core_clks",
         "MetricGroup": "MemoryTLB;TopdownL4;tma_L4_group;tma_issueTLB;tma_=
store_bound_group",
         "MetricName": "tma_dtlb_store",
         "MetricThreshold": "tma_dtlb_store > 0.05 & (tma_store_bound > 0.2=
 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
-        "PublicDescription": "This metric roughly estimates the fraction o=
f cycles spent handling first-level data TLB store misses.  As with ordinar=
y data caching; focus on improving data locality and reducing working-set s=
ize to reduce DTLB overhead.  Additionally; consider using profile-guided o=
ptimization (PGO) to collocate frequently-used data on the same page.  Try =
using larger page sizes for large amounts of frequently-used data. Sample w=
ith: MEM_INST_RETIRED.STLB_MISS_STORES_PS. Related metrics: tma_dtlb_load, =
tma_info_memory_data_tlbs",
+        "PublicDescription": "This metric roughly estimates the fraction o=
f cycles spent handling first-level data TLB store misses.  As with ordinar=
y data caching; focus on improving data locality and reducing working-set s=
ize to reduce DTLB overhead.  Additionally; consider using profile-guided o=
ptimization (PGO) to collocate frequently-used data on the same page.  Try =
using larger page sizes for large amounts of frequently-used data. Sample w=
ith: MEM_INST_RETIRED.STLB_MISS_STORES_PS. Related metrics: tma_dtlb_load, =
tma_info_bottleneck_memory_data_tlbs",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "This metric roughly estimates how often CPU w=
as handling synchronizations due to False Sharing",
-        "MetricExpr": "32.5 * tma_info_average_frequency * OCR.DEMAND_RFO.=
L3_HIT.SNOOP_HITM / tma_info_clks",
+        "MetricExpr": "32.5 * tma_info_system_average_frequency * OCR.DEMA=
ND_RFO.L3_HIT.SNOOP_HITM / tma_info_thread_clks",
         "MetricGroup": "DataSharing;Offcore;Snoop;TopdownL4;tma_L4_group;t=
ma_issueSyncxn;tma_store_bound_group",
         "MetricName": "tma_false_sharing",
         "MetricThreshold": "tma_false_sharing > 0.05 & (tma_store_bound > =
0.2 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
@@ -279,11 +279,11 @@
     },
     {
         "BriefDescription": "This metric does a *rough estimation* of how =
often L1D Fill Buffer unavailability limited additional L1D miss memory acc=
ess requests to proceed",
-        "MetricExpr": "L1D_PEND_MISS.FB_FULL / tma_info_clks",
+        "MetricExpr": "L1D_PEND_MISS.FB_FULL / tma_info_thread_clks",
         "MetricGroup": "MemoryBW;TopdownL4;tma_L4_group;tma_issueBW;tma_is=
sueSL;tma_issueSmSt;tma_l1_bound_group",
         "MetricName": "tma_fb_full",
         "MetricThreshold": "tma_fb_full > 0.3",
-        "PublicDescription": "This metric does a *rough estimation* of how=
 often L1D Fill Buffer unavailability limited additional L1D miss memory ac=
cess requests to proceed. The higher the metric value; the deeper the memor=
y hierarchy level the misses are satisfied from (metric values >1 are valid=
). Often it hints on approaching bandwidth limits (to L2 cache; L3 cache or=
 external memory). Related metrics: tma_info_dram_bw_use, tma_info_memory_b=
andwidth, tma_mem_bandwidth, tma_sq_full, tma_store_latency, tma_streaming_=
stores",
+        "PublicDescription": "This metric does a *rough estimation* of how=
 often L1D Fill Buffer unavailability limited additional L1D miss memory ac=
cess requests to proceed. The higher the metric value; the deeper the memor=
y hierarchy level the misses are satisfied from (metric values >1 are valid=
). Often it hints on approaching bandwidth limits (to L2 cache; L3 cache or=
 external memory). Related metrics: tma_info_bottleneck_memory_bandwidth, t=
ma_info_system_dram_bw_use, tma_mem_bandwidth, tma_sq_full, tma_store_laten=
cy, tma_streaming_stores",
         "ScaleUnit": "100%"
     },
     {
@@ -291,14 +291,14 @@
         "MetricExpr": "max(0, tma_frontend_bound - tma_fetch_latency)",
         "MetricGroup": "FetchBW;Frontend;TmaL2;TopdownL2;tma_L2_group;tma_=
frontend_bound_group;tma_issueFB",
         "MetricName": "tma_fetch_bandwidth",
-        "MetricThreshold": "tma_fetch_bandwidth > 0.1 & tma_frontend_bound=
 > 0.15 & tma_info_ipc / 5 > 0.35",
+        "MetricThreshold": "tma_fetch_bandwidth > 0.1 & tma_frontend_bound=
 > 0.15 & tma_info_thread_ipc / 5 > 0.35",
         "MetricgroupNoGroup": "TopdownL2",
-        "PublicDescription": "This metric represents fraction of slots the=
 CPU was stalled due to Frontend bandwidth issues.  For example; inefficien=
cies at the instruction decoders; or restrictions for caching in the DSB (d=
ecoded uops cache) are categorized under Fetch Bandwidth. In such cases; th=
e Frontend typically delivers suboptimal amount of uops to the Backend. Sam=
ple with: FRONTEND_RETIRED.LATENCY_GE_2_BUBBLES_GE_1_PS;FRONTEND_RETIRED.LA=
TENCY_GE_1_PS;FRONTEND_RETIRED.LATENCY_GE_2_PS. Related metrics: tma_dsb_sw=
itches, tma_info_dsb_coverage, tma_info_dsb_misses, tma_info_iptb, tma_lcp"=
,
+        "PublicDescription": "This metric represents fraction of slots the=
 CPU was stalled due to Frontend bandwidth issues.  For example; inefficien=
cies at the instruction decoders; or restrictions for caching in the DSB (d=
ecoded uops cache) are categorized under Fetch Bandwidth. In such cases; th=
e Frontend typically delivers suboptimal amount of uops to the Backend. Sam=
ple with: FRONTEND_RETIRED.LATENCY_GE_2_BUBBLES_GE_1_PS;FRONTEND_RETIRED.LA=
TENCY_GE_1_PS;FRONTEND_RETIRED.LATENCY_GE_2_PS. Related metrics: tma_dsb_sw=
itches, tma_info_botlnk_l2_dsb_misses, tma_info_frontend_dsb_coverage, tma_=
info_inst_mix_iptb, tma_lcp",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "This metric represents fraction of slots the =
CPU was stalled due to Frontend latency issues",
-        "MetricExpr": "(5 * IDQ_UOPS_NOT_DELIVERED.CYCLES_0_UOPS_DELIV.COR=
E - INT_MISC.UOP_DROPPING) / tma_info_slots",
+        "MetricExpr": "(5 * IDQ_UOPS_NOT_DELIVERED.CYCLES_0_UOPS_DELIV.COR=
E - INT_MISC.UOP_DROPPING) / tma_info_thread_slots",
         "MetricGroup": "Frontend;TmaL2;TopdownL2;tma_L2_group;tma_frontend=
_bound_group",
         "MetricName": "tma_fetch_latency",
         "MetricThreshold": "tma_fetch_latency > 0.1 & tma_frontend_bound >=
 0.15",
@@ -327,7 +327,7 @@
     },
     {
         "BriefDescription": "This metric approximates arithmetic floating-=
point (FP) scalar uops fraction the CPU has retired",
-        "MetricExpr": "cpu@FP_ARITH_INST_RETIRED.SCALAR_SINGLE\\,umask\\=
=3D0x03@ / (tma_retiring * tma_info_slots)",
+        "MetricExpr": "cpu@FP_ARITH_INST_RETIRED.SCALAR_SINGLE\\,umask\\=
=3D0x03@ / (tma_retiring * tma_info_thread_slots)",
         "MetricGroup": "Compute;Flops;TopdownL4;tma_L4_group;tma_fp_arith_=
group;tma_issue2P",
         "MetricName": "tma_fp_scalar",
         "MetricThreshold": "tma_fp_scalar > 0.1 & (tma_fp_arith > 0.2 & tm=
a_light_operations > 0.6)",
@@ -336,7 +336,7 @@
     },
     {
         "BriefDescription": "This metric approximates arithmetic floating-=
point (FP) vector uops fraction the CPU has retired aggregated across all v=
ector widths",
-        "MetricExpr": "cpu@FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE\\,umas=
k\\=3D0xfc@ / (tma_retiring * tma_info_slots)",
+        "MetricExpr": "cpu@FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE\\,umas=
k\\=3D0xfc@ / (tma_retiring * tma_info_thread_slots)",
         "MetricGroup": "Compute;Flops;TopdownL4;tma_L4_group;tma_fp_arith_=
group;tma_issue2P",
         "MetricName": "tma_fp_vector",
         "MetricThreshold": "tma_fp_vector > 0.1 & (tma_fp_arith > 0.2 & tm=
a_light_operations > 0.6)",
@@ -345,7 +345,7 @@
     },
     {
         "BriefDescription": "This metric approximates arithmetic FP vector=
 uops fraction the CPU has retired for 128-bit wide vectors",
-        "MetricExpr": "(FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + FP_ARIT=
H_INST_RETIRED.128B_PACKED_SINGLE) / (tma_retiring * tma_info_slots)",
+        "MetricExpr": "(FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + FP_ARIT=
H_INST_RETIRED.128B_PACKED_SINGLE) / (tma_retiring * tma_info_thread_slots)=
",
         "MetricGroup": "Compute;Flops;TopdownL5;tma_L5_group;tma_fp_vector=
_group;tma_issue2P",
         "MetricName": "tma_fp_vector_128b",
         "MetricThreshold": "tma_fp_vector_128b > 0.1 & (tma_fp_vector > 0.=
1 & (tma_fp_arith > 0.2 & tma_light_operations > 0.6))",
@@ -354,7 +354,7 @@
     },
     {
         "BriefDescription": "This metric approximates arithmetic FP vector=
 uops fraction the CPU has retired for 256-bit wide vectors",
-        "MetricExpr": "(FP_ARITH_INST_RETIRED.256B_PACKED_DOUBLE + FP_ARIT=
H_INST_RETIRED.256B_PACKED_SINGLE) / (tma_retiring * tma_info_slots)",
+        "MetricExpr": "(FP_ARITH_INST_RETIRED.256B_PACKED_DOUBLE + FP_ARIT=
H_INST_RETIRED.256B_PACKED_SINGLE) / (tma_retiring * tma_info_thread_slots)=
",
         "MetricGroup": "Compute;Flops;TopdownL5;tma_L5_group;tma_fp_vector=
_group;tma_issue2P",
         "MetricName": "tma_fp_vector_256b",
         "MetricThreshold": "tma_fp_vector_256b > 0.1 & (tma_fp_vector > 0.=
1 & (tma_fp_arith > 0.2 & tma_light_operations > 0.6))",
@@ -363,7 +363,7 @@
     },
     {
         "BriefDescription": "This metric approximates arithmetic FP vector=
 uops fraction the CPU has retired for 512-bit wide vectors",
-        "MetricExpr": "(FP_ARITH_INST_RETIRED.512B_PACKED_DOUBLE + FP_ARIT=
H_INST_RETIRED.512B_PACKED_SINGLE) / (tma_retiring * tma_info_slots)",
+        "MetricExpr": "(FP_ARITH_INST_RETIRED.512B_PACKED_DOUBLE + FP_ARIT=
H_INST_RETIRED.512B_PACKED_SINGLE) / (tma_retiring * tma_info_thread_slots)=
",
         "MetricGroup": "Compute;Flops;TopdownL5;tma_L5_group;tma_fp_vector=
_group;tma_issue2P",
         "MetricName": "tma_fp_vector_512b",
         "MetricThreshold": "tma_fp_vector_512b > 0.1 & (tma_fp_vector > 0.=
1 & (tma_fp_arith > 0.2 & tma_light_operations > 0.6))",
@@ -372,7 +372,7 @@
     },
     {
         "BriefDescription": "This category represents fraction of slots wh=
ere the processor's Frontend undersupplies its Backend",
-        "MetricExpr": "topdown\\-fe\\-bound / (topdown\\-fe\\-bound + topd=
own\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) - INT_MISC.UO=
P_DROPPING / tma_info_slots",
+        "MetricExpr": "topdown\\-fe\\-bound / (topdown\\-fe\\-bound + topd=
own\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) - INT_MISC.UO=
P_DROPPING / tma_info_thread_slots",
         "MetricGroup": "PGO;TmaL1;TopdownL1;tma_L1_group",
         "MetricName": "tma_frontend_bound",
         "MetricThreshold": "tma_frontend_bound > 0.15",
@@ -392,7 +392,7 @@
     },
     {
         "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to instruction cache misses",
-        "MetricExpr": "ICACHE_16B.IFDATA_STALL / tma_info_clks",
+        "MetricExpr": "ICACHE_16B.IFDATA_STALL / tma_info_thread_clks",
         "MetricGroup": "BigFoot;FetchLat;IcMiss;TopdownL3;tma_L3_group;tma=
_fetch_latency_group",
         "MetricName": "tma_icache_misses",
         "MetricThreshold": "tma_icache_misses > 0.05 & (tma_fetch_latency =
> 0.1 & tma_frontend_bound > 0.15)",
@@ -400,676 +400,676 @@
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Measured Average Frequency for unhalted proce=
ssors [GHz]",
-        "MetricExpr": "tma_info_turbo_utilization * TSC / 1e9 / duration_t=
ime",
-        "MetricGroup": "Power;Summary",
-        "MetricName": "tma_info_average_frequency"
+        "BriefDescription": "Branch Misprediction Cost: Fraction of TMA sl=
ots wasted per non-speculative branch misprediction (retired JEClear)",
+        "MetricConstraint": "NO_GROUP_EVENTS",
+        "MetricExpr": "(tma_branch_mispredicts + tma_fetch_latency * tma_m=
ispredicts_resteers / (tma_branch_resteers + tma_dsb_switches + tma_icache_=
misses + tma_itlb_misses + tma_lcp + tma_ms_switches)) * tma_info_thread_sl=
ots / BR_MISP_RETIRED.ALL_BRANCHES",
+        "MetricGroup": "Bad;BrMispredicts;tma_issueBM",
+        "MetricName": "tma_info_bad_spec_branch_misprediction_cost",
+        "PublicDescription": "Branch Misprediction Cost: Fraction of TMA s=
lots wasted per non-speculative branch misprediction (retired JEClear). Rel=
ated metrics: tma_branch_mispredicts, tma_info_bottleneck_mispredictions, t=
ma_mispredicts_resteers"
+    },
+    {
+        "BriefDescription": "Instructions per retired mispredicts for cond=
itional non-taken branches (lower number means higher occurrence rate).",
+        "MetricExpr": "INST_RETIRED.ANY / BR_MISP_RETIRED.COND_NTAKEN",
+        "MetricGroup": "Bad;BrMispredicts",
+        "MetricName": "tma_info_bad_spec_ipmisp_cond_ntaken",
+        "MetricThreshold": "tma_info_bad_spec_ipmisp_cond_ntaken < 200"
+    },
+    {
+        "BriefDescription": "Instructions per retired mispredicts for cond=
itional taken branches (lower number means higher occurrence rate).",
+        "MetricExpr": "INST_RETIRED.ANY / BR_MISP_RETIRED.COND_TAKEN",
+        "MetricGroup": "Bad;BrMispredicts",
+        "MetricName": "tma_info_bad_spec_ipmisp_cond_taken",
+        "MetricThreshold": "tma_info_bad_spec_ipmisp_cond_taken < 200"
+    },
+    {
+        "BriefDescription": "Instructions per retired mispredicts for indi=
rect CALL or JMP branches (lower number means higher occurrence rate).",
+        "MetricExpr": "INST_RETIRED.ANY / BR_MISP_RETIRED.INDIRECT",
+        "MetricGroup": "Bad;BrMispredicts",
+        "MetricName": "tma_info_bad_spec_ipmisp_indirect",
+        "MetricThreshold": "tma_info_bad_spec_ipmisp_indirect < 1e3"
+    },
+    {
+        "BriefDescription": "Instructions per retired mispredicts for retu=
rn branches (lower number means higher occurrence rate).",
+        "MetricExpr": "INST_RETIRED.ANY / BR_MISP_RETIRED.RET",
+        "MetricGroup": "Bad;BrMispredicts",
+        "MetricName": "tma_info_bad_spec_ipmisp_ret",
+        "MetricThreshold": "tma_info_bad_spec_ipmisp_ret < 500"
+    },
+    {
+        "BriefDescription": "Number of Instructions per non-speculative Br=
anch Misprediction (JEClear) (lower number means higher occurrence rate)",
+        "MetricExpr": "INST_RETIRED.ANY / BR_MISP_RETIRED.ALL_BRANCHES",
+        "MetricGroup": "Bad;BadSpec;BrMispredicts",
+        "MetricName": "tma_info_bad_spec_ipmispredict",
+        "MetricThreshold": "tma_info_bad_spec_ipmispredict < 200"
+    },
+    {
+        "BriefDescription": "Probability of Core Bound bottleneck hidden b=
y SMT-profiling artifacts",
+        "MetricConstraint": "NO_GROUP_EVENTS",
+        "MetricExpr": "(100 * (1 - tma_core_bound / tma_ports_utilization =
if tma_core_bound < tma_ports_utilization else 1) if tma_info_system_smt_2t=
_utilization > 0.5 else 0)",
+        "MetricGroup": "Cor;SMT",
+        "MetricName": "tma_info_botlnk_l0_core_bound_likely",
+        "MetricThreshold": "tma_info_botlnk_l0_core_bound_likely > 0.5"
+    },
+    {
+        "BriefDescription": "Total pipeline cost of DSB (uop cache) misses=
 - subset of the Instruction_Fetch_BW Bottleneck",
+        "MetricConstraint": "NO_GROUP_EVENTS",
+        "MetricExpr": "100 * (tma_fetch_latency * tma_dsb_switches / (tma_=
branch_resteers + tma_dsb_switches + tma_icache_misses + tma_itlb_misses + =
tma_lcp + tma_ms_switches) + tma_fetch_bandwidth * tma_mite / (tma_dsb + tm=
a_lsd + tma_mite))",
+        "MetricGroup": "DSBmiss;Fed;tma_issueFB",
+        "MetricName": "tma_info_botlnk_l2_dsb_misses",
+        "MetricThreshold": "tma_info_botlnk_l2_dsb_misses > 10",
+        "PublicDescription": "Total pipeline cost of DSB (uop cache) misse=
s - subset of the Instruction_Fetch_BW Bottleneck. Related metrics: tma_dsb=
_switches, tma_fetch_bandwidth, tma_info_frontend_dsb_coverage, tma_info_in=
st_mix_iptb, tma_lcp"
+    },
+    {
+        "BriefDescription": "Total pipeline cost of Instruction Cache miss=
es - subset of the Big_Code Bottleneck",
+        "MetricExpr": "100 * (tma_fetch_latency * tma_icache_misses / (tma=
_branch_resteers + tma_dsb_switches + tma_icache_misses + tma_itlb_misses +=
 tma_lcp + tma_ms_switches))",
+        "MetricGroup": "Fed;FetchLat;IcMiss;tma_issueFL",
+        "MetricName": "tma_info_botlnk_l2_ic_misses",
+        "MetricThreshold": "tma_info_botlnk_l2_ic_misses > 5",
+        "PublicDescription": "Total pipeline cost of Instruction Cache mis=
ses - subset of the Big_Code Bottleneck. Related metrics: "
     },
     {
         "BriefDescription": "Total pipeline cost of instruction fetch rela=
ted bottlenecks by large code footprint programs (i-side cache; TLB and BTB=
 misses)",
         "MetricConstraint": "NO_GROUP_EVENTS",
         "MetricExpr": "100 * tma_fetch_latency * (tma_itlb_misses + tma_ic=
ache_misses + tma_unknown_branches) / (tma_branch_resteers + tma_dsb_switch=
es + tma_icache_misses + tma_itlb_misses + tma_lcp + tma_ms_switches)",
         "MetricGroup": "BigFoot;Fed;Frontend;IcMiss;MemoryTLB;tma_issueBC"=
,
-        "MetricName": "tma_info_big_code",
-        "MetricThreshold": "tma_info_big_code > 20",
-        "PublicDescription": "Total pipeline cost of instruction fetch rel=
ated bottlenecks by large code footprint programs (i-side cache; TLB and BT=
B misses). Related metrics: tma_info_branching_overhead"
+        "MetricName": "tma_info_bottleneck_big_code",
+        "MetricThreshold": "tma_info_bottleneck_big_code > 20",
+        "PublicDescription": "Total pipeline cost of instruction fetch rel=
ated bottlenecks by large code footprint programs (i-side cache; TLB and BT=
B misses). Related metrics: tma_info_bottleneck_branching_overhead"
     },
     {
-        "BriefDescription": "Branch instructions per taken branch.",
-        "MetricExpr": "BR_INST_RETIRED.ALL_BRANCHES / BR_INST_RETIRED.NEAR=
_TAKEN",
-        "MetricGroup": "Branches;Fed;PGO",
-        "MetricName": "tma_info_bptkbranch"
+        "BriefDescription": "Total pipeline cost of branch related instruc=
tions (used for program control-flow including function calls)",
+        "MetricExpr": "100 * ((BR_INST_RETIRED.COND + 3 * BR_INST_RETIRED.=
NEAR_CALL + (BR_INST_RETIRED.NEAR_TAKEN - BR_INST_RETIRED.COND_TAKEN - 2 * =
BR_INST_RETIRED.NEAR_CALL)) / tma_info_thread_slots)",
+        "MetricGroup": "Ret;tma_issueBC",
+        "MetricName": "tma_info_bottleneck_branching_overhead",
+        "MetricThreshold": "tma_info_bottleneck_branching_overhead > 10",
+        "PublicDescription": "Total pipeline cost of branch related instru=
ctions (used for program control-flow including function calls). Related me=
trics: tma_info_bottleneck_big_code"
     },
     {
-        "BriefDescription": "Branch Misprediction Cost: Fraction of TMA sl=
ots wasted per non-speculative branch misprediction (retired JEClear)",
+        "BriefDescription": "Total pipeline cost of instruction fetch band=
width related bottlenecks",
         "MetricConstraint": "NO_GROUP_EVENTS",
-        "MetricExpr": "(tma_branch_mispredicts + tma_fetch_latency * tma_m=
ispredicts_resteers / (tma_branch_resteers + tma_dsb_switches + tma_icache_=
misses + tma_itlb_misses + tma_lcp + tma_ms_switches)) * tma_info_slots / B=
R_MISP_RETIRED.ALL_BRANCHES",
-        "MetricGroup": "Bad;BrMispredicts;tma_issueBM",
-        "MetricName": "tma_info_branch_misprediction_cost",
-        "PublicDescription": "Branch Misprediction Cost: Fraction of TMA s=
lots wasted per non-speculative branch misprediction (retired JEClear). Rel=
ated metrics: tma_branch_mispredicts, tma_info_mispredictions, tma_mispredi=
cts_resteers"
+        "MetricExpr": "100 * (tma_frontend_bound - tma_fetch_latency * tma=
_mispredicts_resteers / (tma_branch_resteers + tma_dsb_switches + tma_icach=
e_misses + tma_itlb_misses + tma_lcp + tma_ms_switches)) - tma_info_bottlen=
eck_big_code",
+        "MetricGroup": "Fed;FetchBW;Frontend",
+        "MetricName": "tma_info_bottleneck_instruction_fetch_bw",
+        "MetricThreshold": "tma_info_bottleneck_instruction_fetch_bw > 20"
     },
     {
-        "BriefDescription": "Total pipeline cost of branch related instruc=
tions (used for program control-flow including function calls)",
-        "MetricExpr": "100 * ((BR_INST_RETIRED.COND + 3 * BR_INST_RETIRED.=
NEAR_CALL + (BR_INST_RETIRED.NEAR_TAKEN - BR_INST_RETIRED.COND_TAKEN - 2 * =
BR_INST_RETIRED.NEAR_CALL)) / tma_info_slots)",
-        "MetricGroup": "Ret;tma_issueBC",
-        "MetricName": "tma_info_branching_overhead",
-        "MetricThreshold": "tma_info_branching_overhead > 10",
-        "PublicDescription": "Total pipeline cost of branch related instru=
ctions (used for program control-flow including function calls). Related me=
trics: tma_info_big_code"
+        "BriefDescription": "Total pipeline cost of (external) Memory Band=
width related bottlenecks",
+        "MetricExpr": "100 * tma_memory_bound * (tma_dram_bound / (tma_dra=
m_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_bound) * (=
tma_mem_bandwidth / (tma_mem_bandwidth + tma_mem_latency)) + tma_l3_bound /=
 (tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_b=
ound) * (tma_sq_full / (tma_contested_accesses + tma_data_sharing + tma_l3_=
hit_latency + tma_sq_full))) + tma_l1_bound / (tma_dram_bound + tma_l1_boun=
d + tma_l2_bound + tma_l3_bound + tma_store_bound) * (tma_fb_full / (tma_4k=
_aliasing + tma_dtlb_load + tma_fb_full + tma_lock_latency + tma_split_load=
s + tma_store_fwd_blk))",
+        "MetricGroup": "Mem;MemoryBW;Offcore;tma_issueBW",
+        "MetricName": "tma_info_bottleneck_memory_bandwidth",
+        "MetricThreshold": "tma_info_bottleneck_memory_bandwidth > 20",
+        "PublicDescription": "Total pipeline cost of (external) Memory Ban=
dwidth related bottlenecks. Related metrics: tma_fb_full, tma_info_system_d=
ram_bw_use, tma_mem_bandwidth, tma_sq_full"
     },
     {
-        "BriefDescription": "Fraction of branches that are CALL or RET",
-        "MetricExpr": "(BR_INST_RETIRED.NEAR_CALL + BR_INST_RETIRED.NEAR_R=
ETURN) / BR_INST_RETIRED.ALL_BRANCHES",
-        "MetricGroup": "Bad;Branches",
-        "MetricName": "tma_info_callret"
+        "BriefDescription": "Total pipeline cost of Memory Address Transla=
tion related bottlenecks (data-side TLBs)",
+        "MetricConstraint": "NO_GROUP_EVENTS",
+        "MetricExpr": "100 * tma_memory_bound * (tma_l1_bound / max(tma_me=
mory_bound, tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + t=
ma_store_bound) * (tma_dtlb_load / max(tma_l1_bound, tma_4k_aliasing + tma_=
dtlb_load + tma_fb_full + tma_lock_latency + tma_split_loads + tma_store_fw=
d_blk)) + tma_store_bound / (tma_dram_bound + tma_l1_bound + tma_l2_bound +=
 tma_l3_bound + tma_store_bound) * (tma_dtlb_store / (tma_dtlb_store + tma_=
false_sharing + tma_split_stores + tma_store_latency + tma_streaming_stores=
)))",
+        "MetricGroup": "Mem;MemoryTLB;Offcore;tma_issueTLB",
+        "MetricName": "tma_info_bottleneck_memory_data_tlbs",
+        "MetricThreshold": "tma_info_bottleneck_memory_data_tlbs > 20",
+        "PublicDescription": "Total pipeline cost of Memory Address Transl=
ation related bottlenecks (data-side TLBs). Related metrics: tma_dtlb_load,=
 tma_dtlb_store"
     },
     {
-        "BriefDescription": "Per-Logical Processor actual clocks when the =
Logical Processor is active.",
-        "MetricExpr": "CPU_CLK_UNHALTED.THREAD",
-        "MetricGroup": "Pipeline",
-        "MetricName": "tma_info_clks"
+        "BriefDescription": "Total pipeline cost of Memory Latency related=
 bottlenecks (external memory and off-core caches)",
+        "MetricConstraint": "NO_GROUP_EVENTS",
+        "MetricExpr": "100 * tma_memory_bound * (tma_dram_bound / (tma_dra=
m_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_bound) * (=
tma_mem_latency / (tma_mem_bandwidth + tma_mem_latency)) + tma_l3_bound / (=
tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_bou=
nd) * (tma_l3_hit_latency / (tma_contested_accesses + tma_data_sharing + tm=
a_l3_hit_latency + tma_sq_full)) + tma_l2_bound / (tma_dram_bound + tma_l1_=
bound + tma_l2_bound + tma_l3_bound + tma_store_bound))",
+        "MetricGroup": "Mem;MemoryLat;Offcore;tma_issueLat",
+        "MetricName": "tma_info_bottleneck_memory_latency",
+        "MetricThreshold": "tma_info_bottleneck_memory_latency > 20",
+        "PublicDescription": "Total pipeline cost of Memory Latency relate=
d bottlenecks (external memory and off-core caches). Related metrics: tma_l=
3_hit_latency, tma_mem_latency"
     },
     {
-        "BriefDescription": "STLB (2nd level TLB) code speculative misses =
per kilo instruction (misses of any page-size that complete the page walk)"=
,
-        "MetricExpr": "1e3 * ITLB_MISSES.WALK_COMPLETED / INST_RETIRED.ANY=
",
-        "MetricGroup": "Fed;MemoryTLB",
-        "MetricName": "tma_info_code_stlb_mpki"
+        "BriefDescription": "Total pipeline cost of Branch Misprediction r=
elated bottlenecks",
+        "MetricConstraint": "NO_GROUP_EVENTS",
+        "MetricExpr": "100 * (tma_branch_mispredicts + tma_fetch_latency *=
 tma_mispredicts_resteers / (tma_branch_resteers + tma_dsb_switches + tma_i=
cache_misses + tma_itlb_misses + tma_lcp + tma_ms_switches))",
+        "MetricGroup": "Bad;BadSpec;BrMispredicts;tma_issueBM",
+        "MetricName": "tma_info_bottleneck_mispredictions",
+        "MetricThreshold": "tma_info_bottleneck_mispredictions > 20",
+        "PublicDescription": "Total pipeline cost of Branch Misprediction =
related bottlenecks. Related metrics: tma_branch_mispredicts, tma_info_bad_=
spec_branch_misprediction_cost, tma_mispredicts_resteers"
+    },
+    {
+        "BriefDescription": "Fraction of branches that are CALL or RET",
+        "MetricExpr": "(BR_INST_RETIRED.NEAR_CALL + BR_INST_RETIRED.NEAR_R=
ETURN) / BR_INST_RETIRED.ALL_BRANCHES",
+        "MetricGroup": "Bad;Branches",
+        "MetricName": "tma_info_branches_callret"
     },
     {
         "BriefDescription": "Fraction of branches that are non-taken condi=
tionals",
         "MetricExpr": "BR_INST_RETIRED.COND_NTAKEN / BR_INST_RETIRED.ALL_B=
RANCHES",
         "MetricGroup": "Bad;Branches;CodeGen;PGO",
-        "MetricName": "tma_info_cond_nt"
+        "MetricName": "tma_info_branches_cond_nt"
     },
     {
         "BriefDescription": "Fraction of branches that are taken condition=
als",
         "MetricExpr": "BR_INST_RETIRED.COND_TAKEN / BR_INST_RETIRED.ALL_BR=
ANCHES",
         "MetricGroup": "Bad;Branches;CodeGen;PGO",
-        "MetricName": "tma_info_cond_tk"
+        "MetricName": "tma_info_branches_cond_tk"
     },
     {
-        "BriefDescription": "Probability of Core Bound bottleneck hidden b=
y SMT-profiling artifacts",
-        "MetricConstraint": "NO_GROUP_EVENTS",
-        "MetricExpr": "(100 * (1 - tma_core_bound / tma_ports_utilization =
if tma_core_bound < tma_ports_utilization else 1) if tma_info_smt_2t_utiliz=
ation > 0.5 else 0)",
-        "MetricGroup": "Cor;SMT",
-        "MetricName": "tma_info_core_bound_likely",
-        "MetricThreshold": "tma_info_core_bound_likely > 0.5"
+        "BriefDescription": "Fraction of branches that are unconditional (=
direct or indirect) jumps",
+        "MetricExpr": "(BR_INST_RETIRED.NEAR_TAKEN - BR_INST_RETIRED.COND_=
TAKEN - 2 * BR_INST_RETIRED.NEAR_CALL) / BR_INST_RETIRED.ALL_BRANCHES",
+        "MetricGroup": "Bad;Branches",
+        "MetricName": "tma_info_branches_jump"
+    },
+    {
+        "BriefDescription": "Fraction of branches of other types (not indi=
vidually covered by other metrics in Info.Branches group)",
+        "MetricExpr": "1 - (tma_info_branches_cond_nt + tma_info_branches_=
cond_tk + tma_info_branches_callret + tma_info_branches_jump)",
+        "MetricGroup": "Bad;Branches",
+        "MetricName": "tma_info_branches_other_branches"
     },
     {
         "BriefDescription": "Core actual clocks when any Logical Processor=
 is active on the Physical Core",
         "MetricExpr": "CPU_CLK_UNHALTED.DISTRIBUTED",
         "MetricGroup": "SMT",
-        "MetricName": "tma_info_core_clks"
+        "MetricName": "tma_info_core_core_clks"
     },
     {
         "BriefDescription": "Instructions Per Cycle across hyper-threads (=
per physical core)",
-        "MetricExpr": "INST_RETIRED.ANY / tma_info_core_clks",
+        "MetricExpr": "INST_RETIRED.ANY / tma_info_core_core_clks",
         "MetricGroup": "Ret;SMT;TmaL1;tma_L1_group",
-        "MetricName": "tma_info_coreipc"
+        "MetricName": "tma_info_core_coreipc"
     },
     {
-        "BriefDescription": "Cycles Per Instruction (per Logical Processor=
)",
-        "MetricExpr": "1 / tma_info_ipc",
-        "MetricGroup": "Mem;Pipeline",
-        "MetricName": "tma_info_cpi"
-    },
-    {
-        "BriefDescription": "Average CPU Utilization",
-        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC / TSC",
-        "MetricGroup": "HPC;Summary",
-        "MetricName": "tma_info_cpu_utilization"
+        "BriefDescription": "Floating Point Operations Per Cycle",
+        "MetricConstraint": "NO_GROUP_EVENTS",
+        "MetricExpr": "(cpu@FP_ARITH_INST_RETIRED.SCALAR_SINGLE\\,umask\\=
=3D0x03@ + 2 * FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + 4 * cpu@FP_ARITH_=
INST_RETIRED.128B_PACKED_SINGLE\\,umask\\=3D0x18@ + 8 * cpu@FP_ARITH_INST_R=
ETIRED.256B_PACKED_SINGLE\\,umask\\=3D0x60@ + 16 * FP_ARITH_INST_RETIRED.51=
2B_PACKED_SINGLE) / tma_info_core_core_clks",
+        "MetricGroup": "Flops;Ret",
+        "MetricName": "tma_info_core_flopc"
     },
     {
-        "BriefDescription": "Average Parallel L2 cache miss data reads",
-        "MetricExpr": "OFFCORE_REQUESTS_OUTSTANDING.ALL_DATA_RD / OFFCORE_=
REQUESTS_OUTSTANDING.CYCLES_WITH_DATA_RD",
-        "MetricGroup": "Memory_BW;Offcore",
-        "MetricName": "tma_info_data_l2_mlp"
+        "BriefDescription": "Actual per-core usage of the Floating Point n=
on-X87 execution units (regardless of precision or vector-width)",
+        "MetricConstraint": "NO_GROUP_EVENTS",
+        "MetricExpr": "(cpu@FP_ARITH_INST_RETIRED.SCALAR_SINGLE\\,umask\\=
=3D0x03@ + cpu@FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE\\,umask\\=3D0xfc@) =
/ (2 * tma_info_core_core_clks)",
+        "MetricGroup": "Cor;Flops;HPC",
+        "MetricName": "tma_info_core_fp_arith_utilization",
+        "PublicDescription": "Actual per-core usage of the Floating Point =
non-X87 execution units (regardless of precision or vector-width). Values >=
 1 are possible due to ([BDW+] Fused-Multiply Add (FMA) counting - common; =
[ADL+] use all of ADD/MUL/FMA in Scalar or 128/256-bit vectors - less commo=
n)."
     },
     {
-        "BriefDescription": "Average external Memory Bandwidth Use for rea=
ds and writes [GB / sec]",
-        "MetricExpr": "64 * (UNC_ARB_TRK_REQUESTS.ALL + UNC_ARB_COH_TRK_RE=
QUESTS.ALL) / 1e6 / duration_time / 1e3",
-        "MetricGroup": "HPC;Mem;MemoryBW;SoC;tma_issueBW",
-        "MetricName": "tma_info_dram_bw_use",
-        "PublicDescription": "Average external Memory Bandwidth Use for re=
ads and writes [GB / sec]. Related metrics: tma_fb_full, tma_info_memory_ba=
ndwidth, tma_mem_bandwidth, tma_sq_full"
+        "BriefDescription": "Instruction-Level-Parallelism (average number=
 of uops executed when there is execution) per-core",
+        "MetricExpr": "UOPS_EXECUTED.THREAD / (UOPS_EXECUTED.CORE_CYCLES_G=
E_1 / 2 if #SMT_on else UOPS_EXECUTED.CORE_CYCLES_GE_1)",
+        "MetricGroup": "Backend;Cor;Pipeline;PortsUtil",
+        "MetricName": "tma_info_core_ilp"
     },
     {
         "BriefDescription": "Fraction of Uops delivered by the DSB (aka De=
coded ICache; or Uop Cache)",
         "MetricExpr": "IDQ.DSB_UOPS / UOPS_ISSUED.ANY",
         "MetricGroup": "DSB;Fed;FetchBW;tma_issueFB",
-        "MetricName": "tma_info_dsb_coverage",
-        "MetricThreshold": "tma_info_dsb_coverage < 0.7 & tma_info_ipc / 5=
 > 0.35",
-        "PublicDescription": "Fraction of Uops delivered by the DSB (aka D=
ecoded ICache; or Uop Cache). Related metrics: tma_dsb_switches, tma_fetch_=
bandwidth, tma_info_dsb_misses, tma_info_iptb, tma_lcp"
-    },
-    {
-        "BriefDescription": "Total pipeline cost of DSB (uop cache) misses=
 - subset of the Instruction_Fetch_BW Bottleneck",
-        "MetricConstraint": "NO_GROUP_EVENTS",
-        "MetricExpr": "100 * (tma_fetch_latency * tma_dsb_switches / (tma_=
branch_resteers + tma_dsb_switches + tma_icache_misses + tma_itlb_misses + =
tma_lcp + tma_ms_switches) + tma_fetch_bandwidth * tma_mite / (tma_dsb + tm=
a_lsd + tma_mite))",
-        "MetricGroup": "DSBmiss;Fed;tma_issueFB",
-        "MetricName": "tma_info_dsb_misses",
-        "MetricThreshold": "tma_info_dsb_misses > 10",
-        "PublicDescription": "Total pipeline cost of DSB (uop cache) misse=
s - subset of the Instruction_Fetch_BW Bottleneck. Related metrics: tma_dsb=
_switches, tma_fetch_bandwidth, tma_info_dsb_coverage, tma_info_iptb, tma_l=
cp"
+        "MetricName": "tma_info_frontend_dsb_coverage",
+        "MetricThreshold": "tma_info_frontend_dsb_coverage < 0.7 & tma_inf=
o_thread_ipc / 5 > 0.35",
+        "PublicDescription": "Fraction of Uops delivered by the DSB (aka D=
ecoded ICache; or Uop Cache). Related metrics: tma_dsb_switches, tma_fetch_=
bandwidth, tma_info_botlnk_l2_dsb_misses, tma_info_inst_mix_iptb, tma_lcp"
     },
     {
         "BriefDescription": "Average number of cycles of a switch from the=
 DSB fetch-unit to MITE fetch unit - see DSB_Switches tree node for details=
.",
         "MetricExpr": "DSB2MITE_SWITCHES.PENALTY_CYCLES / cpu@DSB2MITE_SWI=
TCHES.PENALTY_CYCLES\\,cmask\\=3D1\\,edge@",
         "MetricGroup": "DSBmiss",
-        "MetricName": "tma_info_dsb_switch_cost"
-    },
-    {
-        "BriefDescription": "Instruction-Level-Parallelism (average number=
 of uops executed when there is execution) per-thread",
-        "MetricExpr": "UOPS_EXECUTED.THREAD / cpu@UOPS_EXECUTED.THREAD\\,c=
mask\\=3D1@",
-        "MetricGroup": "Cor;Pipeline;PortsUtil;SMT",
-        "MetricName": "tma_info_execute"
-    },
-    {
-        "BriefDescription": "The ratio of Executed- by Issued-Uops",
-        "MetricExpr": "UOPS_EXECUTED.THREAD / UOPS_ISSUED.ANY",
-        "MetricGroup": "Cor;Pipeline",
-        "MetricName": "tma_info_execute_per_issue",
-        "PublicDescription": "The ratio of Executed- by Issued-Uops. Ratio=
 > 1 suggests high rate of uop micro-fusions. Ratio < 1 suggest high rate o=
f \"execute\" at rename stage."
-    },
-    {
-        "BriefDescription": "Fill Buffer (FB) hits per kilo instructions f=
or retired demand loads (L1D misses that merge into ongoing miss-handling e=
ntries)",
-        "MetricExpr": "1e3 * MEM_LOAD_RETIRED.FB_HIT / INST_RETIRED.ANY",
-        "MetricGroup": "CacheMisses;Mem",
-        "MetricName": "tma_info_fb_hpki"
+        "MetricName": "tma_info_frontend_dsb_switch_cost"
     },
     {
         "BriefDescription": "Average number of Uops issued by front-end wh=
en it issued something",
         "MetricExpr": "UOPS_ISSUED.ANY / cpu@UOPS_ISSUED.ANY\\,cmask\\=3D1=
@",
         "MetricGroup": "Fed;FetchBW",
-        "MetricName": "tma_info_fetch_upc"
+        "MetricName": "tma_info_frontend_fetch_upc"
     },
     {
-        "BriefDescription": "Floating Point Operations Per Cycle",
-        "MetricConstraint": "NO_GROUP_EVENTS",
-        "MetricExpr": "(cpu@FP_ARITH_INST_RETIRED.SCALAR_SINGLE\\,umask\\=
=3D0x03@ + 2 * FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + 4 * cpu@FP_ARITH_=
INST_RETIRED.128B_PACKED_SINGLE\\,umask\\=3D0x18@ + 8 * cpu@FP_ARITH_INST_R=
ETIRED.256B_PACKED_SINGLE\\,umask\\=3D0x60@ + 16 * FP_ARITH_INST_RETIRED.51=
2B_PACKED_SINGLE) / tma_info_core_clks",
-        "MetricGroup": "Flops;Ret",
-        "MetricName": "tma_info_flopc"
+        "BriefDescription": "Average Latency for L1 instruction cache miss=
es",
+        "MetricExpr": "ICACHE_16B.IFDATA_STALL / cpu@ICACHE_16B.IFDATA_STA=
LL\\,cmask\\=3D1\\,edge@",
+        "MetricGroup": "Fed;FetchLat;IcMiss",
+        "MetricName": "tma_info_frontend_icache_miss_latency"
     },
     {
-        "BriefDescription": "Actual per-core usage of the Floating Point n=
on-X87 execution units (regardless of precision or vector-width)",
-        "MetricConstraint": "NO_GROUP_EVENTS",
-        "MetricExpr": "(cpu@FP_ARITH_INST_RETIRED.SCALAR_SINGLE\\,umask\\=
=3D0x03@ + cpu@FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE\\,umask\\=3D0xfc@) =
/ (2 * tma_info_core_clks)",
-        "MetricGroup": "Cor;Flops;HPC",
-        "MetricName": "tma_info_fp_arith_utilization",
-        "PublicDescription": "Actual per-core usage of the Floating Point =
non-X87 execution units (regardless of precision or vector-width). Values >=
 1 are possible due to ([BDW+] Fused-Multiply Add (FMA) counting - common; =
[ADL+] use all of ADD/MUL/FMA in Scalar or 128/256-bit vectors - less commo=
n)."
+        "BriefDescription": "Instructions per non-speculative DSB miss (lo=
wer number means higher occurrence rate)",
+        "MetricExpr": "INST_RETIRED.ANY / FRONTEND_RETIRED.ANY_DSB_MISS",
+        "MetricGroup": "DSBmiss;Fed",
+        "MetricName": "tma_info_frontend_ipdsb_miss_ret",
+        "MetricThreshold": "tma_info_frontend_ipdsb_miss_ret < 50"
     },
     {
-        "BriefDescription": "Giga Floating Point Operations Per Second",
-        "MetricExpr": "(cpu@FP_ARITH_INST_RETIRED.SCALAR_SINGLE\\,umask\\=
=3D0x03@ + 2 * FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + 4 * cpu@FP_ARITH_=
INST_RETIRED.128B_PACKED_SINGLE\\,umask\\=3D0x18@ + 8 * cpu@FP_ARITH_INST_R=
ETIRED.256B_PACKED_SINGLE\\,umask\\=3D0x60@ + 16 * FP_ARITH_INST_RETIRED.51=
2B_PACKED_SINGLE) / 1e9 / duration_time",
-        "MetricGroup": "Cor;Flops;HPC",
-        "MetricName": "tma_info_gflops",
-        "PublicDescription": "Giga Floating Point Operations Per Second. A=
ggregate across all supported options of: FP precisions, scalar and vector =
instructions, vector-width and AMX engine."
+        "BriefDescription": "Instructions per speculative Unknown Branch M=
isprediction (BAClear) (lower number means higher occurrence rate)",
+        "MetricExpr": "tma_info_inst_mix_instructions / BACLEARS.ANY",
+        "MetricGroup": "Fed",
+        "MetricName": "tma_info_frontend_ipunknown_branch"
     },
     {
-        "BriefDescription": "Total pipeline cost of Instruction Cache miss=
es - subset of the Big_Code Bottleneck",
-        "MetricExpr": "100 * (tma_fetch_latency * tma_icache_misses / (tma=
_branch_resteers + tma_dsb_switches + tma_icache_misses + tma_itlb_misses +=
 tma_lcp + tma_ms_switches))",
-        "MetricGroup": "Fed;FetchLat;IcMiss;tma_issueFL",
-        "MetricName": "tma_info_ic_misses",
-        "MetricThreshold": "tma_info_ic_misses > 5",
-        "PublicDescription": "Total pipeline cost of Instruction Cache mis=
ses - subset of the Big_Code Bottleneck. Related metrics: "
+        "BriefDescription": "L2 cache true code cacheline misses per kilo =
instruction",
+        "MetricExpr": "1e3 * FRONTEND_RETIRED.L2_MISS / INST_RETIRED.ANY",
+        "MetricGroup": "IcMiss",
+        "MetricName": "tma_info_frontend_l2mpki_code"
     },
     {
-        "BriefDescription": "Average Latency for L1 instruction cache miss=
es",
-        "MetricExpr": "ICACHE_16B.IFDATA_STALL / cpu@ICACHE_16B.IFDATA_STA=
LL\\,cmask\\=3D1\\,edge@",
-        "MetricGroup": "Fed;FetchLat;IcMiss",
-        "MetricName": "tma_info_icache_miss_latency"
+        "BriefDescription": "L2 cache speculative code cacheline misses pe=
r kilo instruction",
+        "MetricExpr": "1e3 * L2_RQSTS.CODE_RD_MISS / INST_RETIRED.ANY",
+        "MetricGroup": "IcMiss",
+        "MetricName": "tma_info_frontend_l2mpki_code_all"
     },
     {
-        "BriefDescription": "Instruction-Level-Parallelism (average number=
 of uops executed when there is execution) per-core",
-        "MetricExpr": "UOPS_EXECUTED.THREAD / (UOPS_EXECUTED.CORE_CYCLES_G=
E_1 / 2 if #SMT_on else UOPS_EXECUTED.CORE_CYCLES_GE_1)",
-        "MetricGroup": "Backend;Cor;Pipeline;PortsUtil",
-        "MetricName": "tma_info_ilp"
+        "BriefDescription": "Fraction of Uops delivered by the LSD (Loop S=
tream Detector; aka Loop Cache)",
+        "MetricExpr": "LSD.UOPS / UOPS_ISSUED.ANY",
+        "MetricGroup": "Fed;LSD",
+        "MetricName": "tma_info_frontend_lsd_coverage"
     },
     {
-        "BriefDescription": "Total pipeline cost of instruction fetch band=
width related bottlenecks",
-        "MetricConstraint": "NO_GROUP_EVENTS",
-        "MetricExpr": "100 * (tma_frontend_bound - tma_fetch_latency * tma=
_mispredicts_resteers / (tma_branch_resteers + tma_dsb_switches + tma_icach=
e_misses + tma_itlb_misses + tma_lcp + tma_ms_switches)) - tma_info_big_cod=
e",
-        "MetricGroup": "Fed;FetchBW;Frontend",
-        "MetricName": "tma_info_instruction_fetch_bw",
-        "MetricThreshold": "tma_info_instruction_fetch_bw > 20"
+        "BriefDescription": "Branch instructions per taken branch.",
+        "MetricExpr": "BR_INST_RETIRED.ALL_BRANCHES / BR_INST_RETIRED.NEAR=
_TAKEN",
+        "MetricGroup": "Branches;Fed;PGO",
+        "MetricName": "tma_info_inst_mix_bptkbranch"
     },
     {
         "BriefDescription": "Total number of retired Instructions",
         "MetricExpr": "INST_RETIRED.ANY",
         "MetricGroup": "Summary;TmaL1;tma_L1_group",
-        "MetricName": "tma_info_instructions",
+        "MetricName": "tma_info_inst_mix_instructions",
         "PublicDescription": "Total number of retired Instructions. Sample=
 with: INST_RETIRED.PREC_DIST"
     },
     {
         "BriefDescription": "Instructions per FP Arithmetic instruction (l=
ower number means higher occurrence rate)",
         "MetricExpr": "INST_RETIRED.ANY / (cpu@FP_ARITH_INST_RETIRED.SCALA=
R_SINGLE\\,umask\\=3D0x03@ + cpu@FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE\\=
,umask\\=3D0xfc@)",
         "MetricGroup": "Flops;InsType",
-        "MetricName": "tma_info_iparith",
-        "MetricThreshold": "tma_info_iparith < 10",
+        "MetricName": "tma_info_inst_mix_iparith",
+        "MetricThreshold": "tma_info_inst_mix_iparith < 10",
         "PublicDescription": "Instructions per FP Arithmetic instruction (=
lower number means higher occurrence rate). May undercount due to FMA doubl=
e counting. Approximated prior to BDW."
     },
     {
         "BriefDescription": "Instructions per FP Arithmetic AVX/SSE 128-bi=
t instruction (lower number means higher occurrence rate)",
         "MetricExpr": "INST_RETIRED.ANY / (FP_ARITH_INST_RETIRED.128B_PACK=
ED_DOUBLE + FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE)",
         "MetricGroup": "Flops;FpVector;InsType",
-        "MetricName": "tma_info_iparith_avx128",
-        "MetricThreshold": "tma_info_iparith_avx128 < 10",
+        "MetricName": "tma_info_inst_mix_iparith_avx128",
+        "MetricThreshold": "tma_info_inst_mix_iparith_avx128 < 10",
         "PublicDescription": "Instructions per FP Arithmetic AVX/SSE 128-b=
it instruction (lower number means higher occurrence rate). May undercount =
due to FMA double counting."
     },
     {
         "BriefDescription": "Instructions per FP Arithmetic AVX* 256-bit i=
nstruction (lower number means higher occurrence rate)",
         "MetricExpr": "INST_RETIRED.ANY / (FP_ARITH_INST_RETIRED.256B_PACK=
ED_DOUBLE + FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE)",
         "MetricGroup": "Flops;FpVector;InsType",
-        "MetricName": "tma_info_iparith_avx256",
-        "MetricThreshold": "tma_info_iparith_avx256 < 10",
+        "MetricName": "tma_info_inst_mix_iparith_avx256",
+        "MetricThreshold": "tma_info_inst_mix_iparith_avx256 < 10",
         "PublicDescription": "Instructions per FP Arithmetic AVX* 256-bit =
instruction (lower number means higher occurrence rate). May undercount due=
 to FMA double counting."
     },
     {
         "BriefDescription": "Instructions per FP Arithmetic AVX 512-bit in=
struction (lower number means higher occurrence rate)",
         "MetricExpr": "INST_RETIRED.ANY / (FP_ARITH_INST_RETIRED.512B_PACK=
ED_DOUBLE + FP_ARITH_INST_RETIRED.512B_PACKED_SINGLE)",
         "MetricGroup": "Flops;FpVector;InsType",
-        "MetricName": "tma_info_iparith_avx512",
-        "MetricThreshold": "tma_info_iparith_avx512 < 10",
+        "MetricName": "tma_info_inst_mix_iparith_avx512",
+        "MetricThreshold": "tma_info_inst_mix_iparith_avx512 < 10",
         "PublicDescription": "Instructions per FP Arithmetic AVX 512-bit i=
nstruction (lower number means higher occurrence rate). May undercount due =
to FMA double counting."
     },
     {
         "BriefDescription": "Instructions per FP Arithmetic Scalar Double-=
Precision instruction (lower number means higher occurrence rate)",
         "MetricExpr": "INST_RETIRED.ANY / FP_ARITH_INST_RETIRED.SCALAR_DOU=
BLE",
         "MetricGroup": "Flops;FpScalar;InsType",
-        "MetricName": "tma_info_iparith_scalar_dp",
-        "MetricThreshold": "tma_info_iparith_scalar_dp < 10",
+        "MetricName": "tma_info_inst_mix_iparith_scalar_dp",
+        "MetricThreshold": "tma_info_inst_mix_iparith_scalar_dp < 10",
         "PublicDescription": "Instructions per FP Arithmetic Scalar Double=
-Precision instruction (lower number means higher occurrence rate). May und=
ercount due to FMA double counting."
     },
     {
         "BriefDescription": "Instructions per FP Arithmetic Scalar Single-=
Precision instruction (lower number means higher occurrence rate)",
         "MetricExpr": "INST_RETIRED.ANY / FP_ARITH_INST_RETIRED.SCALAR_SIN=
GLE",
         "MetricGroup": "Flops;FpScalar;InsType",
-        "MetricName": "tma_info_iparith_scalar_sp",
-        "MetricThreshold": "tma_info_iparith_scalar_sp < 10",
+        "MetricName": "tma_info_inst_mix_iparith_scalar_sp",
+        "MetricThreshold": "tma_info_inst_mix_iparith_scalar_sp < 10",
         "PublicDescription": "Instructions per FP Arithmetic Scalar Single=
-Precision instruction (lower number means higher occurrence rate). May und=
ercount due to FMA double counting."
     },
     {
         "BriefDescription": "Instructions per Branch (lower number means h=
igher occurrence rate)",
         "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.ALL_BRANCHES",
         "MetricGroup": "Branches;Fed;InsType",
-        "MetricName": "tma_info_ipbranch",
-        "MetricThreshold": "tma_info_ipbranch < 8"
-    },
-    {
-        "BriefDescription": "Instructions Per Cycle (per Logical Processor=
)",
-        "MetricExpr": "INST_RETIRED.ANY / tma_info_clks",
-        "MetricGroup": "Ret;Summary",
-        "MetricName": "tma_info_ipc"
+        "MetricName": "tma_info_inst_mix_ipbranch",
+        "MetricThreshold": "tma_info_inst_mix_ipbranch < 8"
     },
     {
         "BriefDescription": "Instructions per (near) call (lower number me=
ans higher occurrence rate)",
         "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.NEAR_CALL",
         "MetricGroup": "Branches;Fed;PGO",
-        "MetricName": "tma_info_ipcall",
-        "MetricThreshold": "tma_info_ipcall < 200"
-    },
-    {
-        "BriefDescription": "Instructions per non-speculative DSB miss (lo=
wer number means higher occurrence rate)",
-        "MetricExpr": "INST_RETIRED.ANY / FRONTEND_RETIRED.ANY_DSB_MISS",
-        "MetricGroup": "DSBmiss;Fed",
-        "MetricName": "tma_info_ipdsb_miss_ret",
-        "MetricThreshold": "tma_info_ipdsb_miss_ret < 50"
-    },
-    {
-        "BriefDescription": "Instructions per Far Branch ( Far Branches ap=
ply upon transition from application to operating system, handling interrup=
ts, exceptions) [lower number means higher occurrence rate]",
-        "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.FAR_BRANCH:u",
-        "MetricGroup": "Branches;OS",
-        "MetricName": "tma_info_ipfarbranch",
-        "MetricThreshold": "tma_info_ipfarbranch < 1e6"
+        "MetricName": "tma_info_inst_mix_ipcall",
+        "MetricThreshold": "tma_info_inst_mix_ipcall < 200"
     },
     {
         "BriefDescription": "Instructions per Floating Point (FP) Operatio=
n (lower number means higher occurrence rate)",
         "MetricExpr": "INST_RETIRED.ANY / (cpu@FP_ARITH_INST_RETIRED.SCALA=
R_SINGLE\\,umask\\=3D0x03@ + 2 * FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE +=
 4 * cpu@FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE\\,umask\\=3D0x18@ + 8 * c=
pu@FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE\\,umask\\=3D0x60@ + 16 * FP_ARI=
TH_INST_RETIRED.512B_PACKED_SINGLE)",
         "MetricGroup": "Flops;InsType",
-        "MetricName": "tma_info_ipflop",
-        "MetricThreshold": "tma_info_ipflop < 10"
+        "MetricName": "tma_info_inst_mix_ipflop",
+        "MetricThreshold": "tma_info_inst_mix_ipflop < 10"
     },
     {
         "BriefDescription": "Instructions per Load (lower number means hig=
her occurrence rate)",
         "MetricExpr": "INST_RETIRED.ANY / MEM_INST_RETIRED.ALL_LOADS",
         "MetricGroup": "InsType",
-        "MetricName": "tma_info_ipload",
-        "MetricThreshold": "tma_info_ipload < 3"
-    },
-    {
-        "BriefDescription": "Instructions per retired mispredicts for cond=
itional non-taken branches (lower number means higher occurrence rate).",
-        "MetricExpr": "INST_RETIRED.ANY / BR_MISP_RETIRED.COND_NTAKEN",
-        "MetricGroup": "Bad;BrMispredicts",
-        "MetricName": "tma_info_ipmisp_cond_ntaken",
-        "MetricThreshold": "tma_info_ipmisp_cond_ntaken < 200"
-    },
-    {
-        "BriefDescription": "Instructions per retired mispredicts for cond=
itional taken branches (lower number means higher occurrence rate).",
-        "MetricExpr": "INST_RETIRED.ANY / BR_MISP_RETIRED.COND_TAKEN",
-        "MetricGroup": "Bad;BrMispredicts",
-        "MetricName": "tma_info_ipmisp_cond_taken",
-        "MetricThreshold": "tma_info_ipmisp_cond_taken < 200"
-    },
-    {
-        "BriefDescription": "Instructions per retired mispredicts for indi=
rect CALL or JMP branches (lower number means higher occurrence rate).",
-        "MetricExpr": "INST_RETIRED.ANY / BR_MISP_RETIRED.INDIRECT",
-        "MetricGroup": "Bad;BrMispredicts",
-        "MetricName": "tma_info_ipmisp_indirect",
-        "MetricThreshold": "tma_info_ipmisp_indirect < 1e3"
-    },
-    {
-        "BriefDescription": "Instructions per retired mispredicts for retu=
rn branches (lower number means higher occurrence rate).",
-        "MetricExpr": "INST_RETIRED.ANY / BR_MISP_RETIRED.RET",
-        "MetricGroup": "Bad;BrMispredicts",
-        "MetricName": "tma_info_ipmisp_ret",
-        "MetricThreshold": "tma_info_ipmisp_ret < 500"
-    },
-    {
-        "BriefDescription": "Number of Instructions per non-speculative Br=
anch Misprediction (JEClear) (lower number means higher occurrence rate)",
-        "MetricExpr": "INST_RETIRED.ANY / BR_MISP_RETIRED.ALL_BRANCHES",
-        "MetricGroup": "Bad;BadSpec;BrMispredicts",
-        "MetricName": "tma_info_ipmispredict",
-        "MetricThreshold": "tma_info_ipmispredict < 200"
+        "MetricName": "tma_info_inst_mix_ipload",
+        "MetricThreshold": "tma_info_inst_mix_ipload < 3"
     },
     {
         "BriefDescription": "Instructions per Store (lower number means hi=
gher occurrence rate)",
         "MetricExpr": "INST_RETIRED.ANY / MEM_INST_RETIRED.ALL_STORES",
         "MetricGroup": "InsType",
-        "MetricName": "tma_info_ipstore",
-        "MetricThreshold": "tma_info_ipstore < 8"
+        "MetricName": "tma_info_inst_mix_ipstore",
+        "MetricThreshold": "tma_info_inst_mix_ipstore < 8"
     },
     {
         "BriefDescription": "Instructions per Software prefetch instructio=
n (of any type: NTA/T0/T1/T2/Prefetch) (lower number means higher occurrenc=
e rate)",
         "MetricExpr": "INST_RETIRED.ANY / cpu@SW_PREFETCH_ACCESS.T0\\,umas=
k\\=3D0xF@",
         "MetricGroup": "Prefetches",
-        "MetricName": "tma_info_ipswpf",
-        "MetricThreshold": "tma_info_ipswpf < 100"
+        "MetricName": "tma_info_inst_mix_ipswpf",
+        "MetricThreshold": "tma_info_inst_mix_ipswpf < 100"
     },
     {
         "BriefDescription": "Instruction per taken branch",
         "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.NEAR_TAKEN",
         "MetricGroup": "Branches;Fed;FetchBW;Frontend;PGO;tma_issueFB",
-        "MetricName": "tma_info_iptb",
-        "MetricThreshold": "tma_info_iptb < 11",
-        "PublicDescription": "Instruction per taken branch. Related metric=
s: tma_dsb_switches, tma_fetch_bandwidth, tma_info_dsb_coverage, tma_info_d=
sb_misses, tma_lcp"
+        "MetricName": "tma_info_inst_mix_iptb",
+        "MetricThreshold": "tma_info_inst_mix_iptb < 11",
+        "PublicDescription": "Instruction per taken branch. Related metric=
s: tma_dsb_switches, tma_fetch_bandwidth, tma_info_botlnk_l2_dsb_misses, tm=
a_info_frontend_dsb_coverage, tma_lcp"
     },
     {
-        "BriefDescription": "Instructions per speculative Unknown Branch M=
isprediction (BAClear) (lower number means higher occurrence rate)",
-        "MetricExpr": "tma_info_instructions / BACLEARS.ANY",
-        "MetricGroup": "Fed",
-        "MetricName": "tma_info_ipunknown_branch"
-    },
-    {
-        "BriefDescription": "Fraction of branches that are unconditional (=
direct or indirect) jumps",
-        "MetricExpr": "(BR_INST_RETIRED.NEAR_TAKEN - BR_INST_RETIRED.COND_=
TAKEN - 2 * BR_INST_RETIRED.NEAR_CALL) / BR_INST_RETIRED.ALL_BRANCHES",
-        "MetricGroup": "Bad;Branches",
-        "MetricName": "tma_info_jump"
+        "BriefDescription": "Average per-core data fill bandwidth to the L=
1 data cache [GB / sec]",
+        "MetricExpr": "64 * L1D.REPLACEMENT / 1e9 / duration_time",
+        "MetricGroup": "Mem;MemoryBW",
+        "MetricName": "tma_info_memory_core_l1d_cache_fill_bw"
     },
     {
-        "BriefDescription": "Cycles Per Instruction for the Operating Syst=
em (OS) Kernel mode",
-        "MetricExpr": "CPU_CLK_UNHALTED.THREAD_P:k / INST_RETIRED.ANY_P:k"=
,
-        "MetricGroup": "OS",
-        "MetricName": "tma_info_kernel_cpi"
+        "BriefDescription": "Average per-core data fill bandwidth to the L=
2 cache [GB / sec]",
+        "MetricExpr": "64 * L2_LINES_IN.ALL / 1e9 / duration_time",
+        "MetricGroup": "Mem;MemoryBW",
+        "MetricName": "tma_info_memory_core_l2_cache_fill_bw"
     },
     {
-        "BriefDescription": "Fraction of cycles spent in the Operating Sys=
tem (OS) Kernel mode",
-        "MetricExpr": "CPU_CLK_UNHALTED.THREAD_P:k / CPU_CLK_UNHALTED.THRE=
AD",
-        "MetricGroup": "OS",
-        "MetricName": "tma_info_kernel_utilization",
-        "MetricThreshold": "tma_info_kernel_utilization > 0.05"
+        "BriefDescription": "Average per-core data access bandwidth to the=
 L3 cache [GB / sec]",
+        "MetricExpr": "64 * OFFCORE_REQUESTS.ALL_REQUESTS / 1e9 / duration=
_time",
+        "MetricGroup": "Mem;MemoryBW;Offcore",
+        "MetricName": "tma_info_memory_core_l3_cache_access_bw"
     },
     {
-        "BriefDescription": "Average per-core data fill bandwidth to the L=
1 data cache [GB / sec]",
-        "MetricExpr": "64 * L1D.REPLACEMENT / 1e9 / duration_time",
+        "BriefDescription": "Average per-core data fill bandwidth to the L=
3 cache [GB / sec]",
+        "MetricExpr": "64 * LONGEST_LAT_CACHE.MISS / 1e9 / duration_time",
         "MetricGroup": "Mem;MemoryBW",
-        "MetricName": "tma_info_l1d_cache_fill_bw"
+        "MetricName": "tma_info_memory_core_l3_cache_fill_bw"
     },
     {
-        "BriefDescription": "Average per-thread data fill bandwidth to the=
 L1 data cache [GB / sec]",
-        "MetricExpr": "tma_info_l1d_cache_fill_bw",
-        "MetricGroup": "Mem;MemoryBW",
-        "MetricName": "tma_info_l1d_cache_fill_bw_1t"
+        "BriefDescription": "Fill Buffer (FB) hits per kilo instructions f=
or retired demand loads (L1D misses that merge into ongoing miss-handling e=
ntries)",
+        "MetricExpr": "1e3 * MEM_LOAD_RETIRED.FB_HIT / INST_RETIRED.ANY",
+        "MetricGroup": "CacheMisses;Mem",
+        "MetricName": "tma_info_memory_fb_hpki"
     },
     {
         "BriefDescription": "L1 cache true misses per kilo instruction for=
 retired demand loads",
         "MetricExpr": "1e3 * MEM_LOAD_RETIRED.L1_MISS / INST_RETIRED.ANY",
         "MetricGroup": "CacheMisses;Mem",
-        "MetricName": "tma_info_l1mpki"
+        "MetricName": "tma_info_memory_l1mpki"
     },
     {
         "BriefDescription": "L1 cache true misses per kilo instruction for=
 all demand loads (including speculative)",
         "MetricExpr": "1e3 * L2_RQSTS.ALL_DEMAND_DATA_RD / INST_RETIRED.AN=
Y",
         "MetricGroup": "CacheMisses;Mem",
-        "MetricName": "tma_info_l1mpki_load"
-    },
-    {
-        "BriefDescription": "Average per-core data fill bandwidth to the L=
2 cache [GB / sec]",
-        "MetricExpr": "64 * L2_LINES_IN.ALL / 1e9 / duration_time",
-        "MetricGroup": "Mem;MemoryBW",
-        "MetricName": "tma_info_l2_cache_fill_bw"
-    },
-    {
-        "BriefDescription": "Average per-thread data fill bandwidth to the=
 L2 cache [GB / sec]",
-        "MetricExpr": "tma_info_l2_cache_fill_bw",
-        "MetricGroup": "Mem;MemoryBW",
-        "MetricName": "tma_info_l2_cache_fill_bw_1t"
+        "MetricName": "tma_info_memory_l1mpki_load"
     },
     {
         "BriefDescription": "L2 cache hits per kilo instruction for all de=
mand loads  (including speculative)",
         "MetricExpr": "1e3 * L2_RQSTS.DEMAND_DATA_RD_HIT / INST_RETIRED.AN=
Y",
         "MetricGroup": "CacheMisses;Mem",
-        "MetricName": "tma_info_l2hpki_load"
+        "MetricName": "tma_info_memory_l2hpki_load"
     },
     {
         "BriefDescription": "L2 cache true misses per kilo instruction for=
 retired demand loads",
         "MetricExpr": "1e3 * MEM_LOAD_RETIRED.L2_MISS / INST_RETIRED.ANY",
         "MetricGroup": "Backend;CacheMisses;Mem",
-        "MetricName": "tma_info_l2mpki"
+        "MetricName": "tma_info_memory_l2mpki"
     },
     {
         "BriefDescription": "L2 cache ([RKL+] true) misses per kilo instru=
ction for all request types (including speculative)",
-        "MetricExpr": "1e3 * (OFFCORE_REQUESTS.ALL_DATA_RD - OFFCORE_REQUE=
STS.DEMAND_DATA_RD + L2_RQSTS.ALL_DEMAND_MISS + L2_RQSTS.SWPF_MISS) / tma_i=
nfo_instructions",
+        "MetricExpr": "1e3 * (OFFCORE_REQUESTS.ALL_DATA_RD - OFFCORE_REQUE=
STS.DEMAND_DATA_RD + L2_RQSTS.ALL_DEMAND_MISS + L2_RQSTS.SWPF_MISS) / tma_i=
nfo_inst_mix_instructions",
         "MetricGroup": "CacheMisses;Mem;Offcore",
-        "MetricName": "tma_info_l2mpki_all"
-    },
-    {
-        "BriefDescription": "L2 cache true code cacheline misses per kilo =
instruction",
-        "MetricExpr": "1e3 * FRONTEND_RETIRED.L2_MISS / INST_RETIRED.ANY",
-        "MetricGroup": "IcMiss",
-        "MetricName": "tma_info_l2mpki_code"
-    },
-    {
-        "BriefDescription": "L2 cache speculative code cacheline misses pe=
r kilo instruction",
-        "MetricExpr": "1e3 * L2_RQSTS.CODE_RD_MISS / INST_RETIRED.ANY",
-        "MetricGroup": "IcMiss",
-        "MetricName": "tma_info_l2mpki_code_all"
+        "MetricName": "tma_info_memory_l2mpki_all"
     },
     {
         "BriefDescription": "L2 cache ([RKL+] true) misses per kilo instru=
ction for all demand loads  (including speculative)",
         "MetricExpr": "1e3 * L2_RQSTS.DEMAND_DATA_RD_MISS / INST_RETIRED.A=
NY",
         "MetricGroup": "CacheMisses;Mem",
-        "MetricName": "tma_info_l2mpki_load"
-    },
-    {
-        "BriefDescription": "Average per-core data access bandwidth to the=
 L3 cache [GB / sec]",
-        "MetricExpr": "64 * OFFCORE_REQUESTS.ALL_REQUESTS / 1e9 / duration=
_time",
-        "MetricGroup": "Mem;MemoryBW;Offcore",
-        "MetricName": "tma_info_l3_cache_access_bw"
+        "MetricName": "tma_info_memory_l2mpki_load"
     },
     {
-        "BriefDescription": "Average per-thread data access bandwidth to t=
he L3 cache [GB / sec]",
-        "MetricExpr": "tma_info_l3_cache_access_bw",
-        "MetricGroup": "Mem;MemoryBW;Offcore",
-        "MetricName": "tma_info_l3_cache_access_bw_1t"
+        "BriefDescription": "L3 cache true misses per kilo instruction for=
 retired demand loads",
+        "MetricExpr": "1e3 * MEM_LOAD_RETIRED.L3_MISS / INST_RETIRED.ANY",
+        "MetricGroup": "CacheMisses;Mem",
+        "MetricName": "tma_info_memory_l3mpki"
     },
     {
-        "BriefDescription": "Average per-core data fill bandwidth to the L=
3 cache [GB / sec]",
-        "MetricExpr": "64 * LONGEST_LAT_CACHE.MISS / 1e9 / duration_time",
-        "MetricGroup": "Mem;MemoryBW",
-        "MetricName": "tma_info_l3_cache_fill_bw"
+        "BriefDescription": "Actual Average Latency for L1 data-cache miss=
 demand load operations (in core cycles)",
+        "MetricExpr": "L1D_PEND_MISS.PENDING / (MEM_LOAD_RETIRED.L1_MISS +=
 MEM_LOAD_RETIRED.FB_HIT)",
+        "MetricGroup": "Mem;MemoryBound;MemoryLat",
+        "MetricName": "tma_info_memory_load_miss_real_latency"
     },
     {
-        "BriefDescription": "Average per-thread data fill bandwidth to the=
 L3 cache [GB / sec]",
-        "MetricExpr": "tma_info_l3_cache_fill_bw",
-        "MetricGroup": "Mem;MemoryBW",
-        "MetricName": "tma_info_l3_cache_fill_bw_1t"
+        "BriefDescription": "Memory-Level-Parallelism (average number of L=
1 miss demand load when there is at least one such miss",
+        "MetricExpr": "L1D_PEND_MISS.PENDING / L1D_PEND_MISS.PENDING_CYCLE=
S",
+        "MetricGroup": "Mem;MemoryBW;MemoryBound",
+        "MetricName": "tma_info_memory_mlp",
+        "PublicDescription": "Memory-Level-Parallelism (average number of =
L1 miss demand load when there is at least one such miss. Per-Logical Proce=
ssor)"
     },
     {
-        "BriefDescription": "L3 cache true misses per kilo instruction for=
 retired demand loads",
-        "MetricExpr": "1e3 * MEM_LOAD_RETIRED.L3_MISS / INST_RETIRED.ANY",
-        "MetricGroup": "CacheMisses;Mem",
-        "MetricName": "tma_info_l3mpki"
+        "BriefDescription": "Average Parallel L2 cache miss data reads",
+        "MetricExpr": "OFFCORE_REQUESTS_OUTSTANDING.ALL_DATA_RD / OFFCORE_=
REQUESTS_OUTSTANDING.CYCLES_WITH_DATA_RD",
+        "MetricGroup": "Memory_BW;Offcore",
+        "MetricName": "tma_info_memory_oro_data_l2_mlp"
     },
     {
         "BriefDescription": "Average Latency for L2 cache miss demand Load=
s",
         "MetricExpr": "OFFCORE_REQUESTS_OUTSTANDING.DEMAND_DATA_RD / OFFCO=
RE_REQUESTS.DEMAND_DATA_RD",
         "MetricGroup": "Memory_Lat;Offcore",
-        "MetricName": "tma_info_load_l2_miss_latency"
+        "MetricName": "tma_info_memory_oro_load_l2_miss_latency"
     },
     {
         "BriefDescription": "Average Parallel L2 cache miss demand Loads",
         "MetricExpr": "OFFCORE_REQUESTS_OUTSTANDING.DEMAND_DATA_RD / cpu@O=
FFCORE_REQUESTS_OUTSTANDING.DEMAND_DATA_RD\\,cmask\\=3D1@",
         "MetricGroup": "Memory_BW;Offcore",
-        "MetricName": "tma_info_load_l2_mlp"
+        "MetricName": "tma_info_memory_oro_load_l2_mlp"
     },
     {
         "BriefDescription": "Average Latency for L3 cache miss demand Load=
s",
         "MetricExpr": "cpu@OFFCORE_REQUESTS_OUTSTANDING.DEMAND_DATA_RD\\,u=
mask\\=3D0x10@ / OFFCORE_REQUESTS.L3_MISS_DEMAND_DATA_RD",
         "MetricGroup": "Memory_Lat;Offcore",
-        "MetricName": "tma_info_load_l3_miss_latency"
+        "MetricName": "tma_info_memory_oro_load_l3_miss_latency"
     },
     {
-        "BriefDescription": "Actual Average Latency for L1 data-cache miss=
 demand load operations (in core cycles)",
-        "MetricExpr": "L1D_PEND_MISS.PENDING / (MEM_LOAD_RETIRED.L1_MISS +=
 MEM_LOAD_RETIRED.FB_HIT)",
-        "MetricGroup": "Mem;MemoryBound;MemoryLat",
-        "MetricName": "tma_info_load_miss_real_latency"
+        "BriefDescription": "Average per-thread data fill bandwidth to the=
 L1 data cache [GB / sec]",
+        "MetricExpr": "tma_info_memory_core_l1d_cache_fill_bw",
+        "MetricGroup": "Mem;MemoryBW",
+        "MetricName": "tma_info_memory_thread_l1d_cache_fill_bw_1t"
+    },
+    {
+        "BriefDescription": "Average per-thread data fill bandwidth to the=
 L2 cache [GB / sec]",
+        "MetricExpr": "tma_info_memory_core_l2_cache_fill_bw",
+        "MetricGroup": "Mem;MemoryBW",
+        "MetricName": "tma_info_memory_thread_l2_cache_fill_bw_1t"
+    },
+    {
+        "BriefDescription": "Average per-thread data access bandwidth to t=
he L3 cache [GB / sec]",
+        "MetricExpr": "tma_info_memory_core_l3_cache_access_bw",
+        "MetricGroup": "Mem;MemoryBW;Offcore",
+        "MetricName": "tma_info_memory_thread_l3_cache_access_bw_1t"
+    },
+    {
+        "BriefDescription": "Average per-thread data fill bandwidth to the=
 L3 cache [GB / sec]",
+        "MetricExpr": "tma_info_memory_core_l3_cache_fill_bw",
+        "MetricGroup": "Mem;MemoryBW",
+        "MetricName": "tma_info_memory_thread_l3_cache_fill_bw_1t"
+    },
+    {
+        "BriefDescription": "STLB (2nd level TLB) code speculative misses =
per kilo instruction (misses of any page-size that complete the page walk)"=
,
+        "MetricExpr": "1e3 * ITLB_MISSES.WALK_COMPLETED / INST_RETIRED.ANY=
",
+        "MetricGroup": "Fed;MemoryTLB",
+        "MetricName": "tma_info_memory_tlb_code_stlb_mpki"
     },
     {
         "BriefDescription": "STLB (2nd level TLB) data load speculative mi=
sses per kilo instruction (misses of any page-size that complete the page w=
alk)",
         "MetricExpr": "1e3 * DTLB_LOAD_MISSES.WALK_COMPLETED / INST_RETIRE=
D.ANY",
         "MetricGroup": "Mem;MemoryTLB",
-        "MetricName": "tma_info_load_stlb_mpki"
+        "MetricName": "tma_info_memory_tlb_load_stlb_mpki"
     },
     {
-        "BriefDescription": "Fraction of Uops delivered by the LSD (Loop S=
tream Detector; aka Loop Cache)",
-        "MetricExpr": "LSD.UOPS / UOPS_ISSUED.ANY",
-        "MetricGroup": "Fed;LSD",
-        "MetricName": "tma_info_lsd_coverage"
+        "BriefDescription": "Utilization of the core's Page Walker(s) serv=
ing STLB misses triggered by instruction/Load/Store accesses",
+        "MetricExpr": "(ITLB_MISSES.WALK_PENDING + DTLB_LOAD_MISSES.WALK_P=
ENDING + DTLB_STORE_MISSES.WALK_PENDING) / (2 * tma_info_core_core_clks)",
+        "MetricGroup": "Mem;MemoryTLB",
+        "MetricName": "tma_info_memory_tlb_page_walks_utilization",
+        "MetricThreshold": "tma_info_memory_tlb_page_walks_utilization > 0=
.5"
     },
     {
-        "BriefDescription": "Total pipeline cost of (external) Memory Band=
width related bottlenecks",
-        "MetricExpr": "100 * tma_memory_bound * (tma_dram_bound / (tma_dra=
m_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_bound) * (=
tma_mem_bandwidth / (tma_mem_bandwidth + tma_mem_latency)) + tma_l3_bound /=
 (tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_b=
ound) * (tma_sq_full / (tma_contested_accesses + tma_data_sharing + tma_l3_=
hit_latency + tma_sq_full))) + tma_l1_bound / (tma_dram_bound + tma_l1_boun=
d + tma_l2_bound + tma_l3_bound + tma_store_bound) * (tma_fb_full / (tma_4k=
_aliasing + tma_dtlb_load + tma_fb_full + tma_lock_latency + tma_split_load=
s + tma_store_fwd_blk))",
-        "MetricGroup": "Mem;MemoryBW;Offcore;tma_issueBW",
-        "MetricName": "tma_info_memory_bandwidth",
-        "MetricThreshold": "tma_info_memory_bandwidth > 20",
-        "PublicDescription": "Total pipeline cost of (external) Memory Ban=
dwidth related bottlenecks. Related metrics: tma_fb_full, tma_info_dram_bw_=
use, tma_mem_bandwidth, tma_sq_full"
+        "BriefDescription": "STLB (2nd level TLB) data store speculative m=
isses per kilo instruction (misses of any page-size that complete the page =
walk)",
+        "MetricExpr": "1e3 * DTLB_STORE_MISSES.WALK_COMPLETED / INST_RETIR=
ED.ANY",
+        "MetricGroup": "Mem;MemoryTLB",
+        "MetricName": "tma_info_memory_tlb_store_stlb_mpki"
     },
     {
-        "BriefDescription": "Total pipeline cost of Memory Address Transla=
tion related bottlenecks (data-side TLBs)",
-        "MetricConstraint": "NO_GROUP_EVENTS",
-        "MetricExpr": "100 * tma_memory_bound * (tma_l1_bound / max(tma_me=
mory_bound, tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + t=
ma_store_bound) * (tma_dtlb_load / max(tma_l1_bound, tma_4k_aliasing + tma_=
dtlb_load + tma_fb_full + tma_lock_latency + tma_split_loads + tma_store_fw=
d_blk)) + tma_store_bound / (tma_dram_bound + tma_l1_bound + tma_l2_bound +=
 tma_l3_bound + tma_store_bound) * (tma_dtlb_store / (tma_dtlb_store + tma_=
false_sharing + tma_split_stores + tma_store_latency + tma_streaming_stores=
)))",
-        "MetricGroup": "Mem;MemoryTLB;Offcore;tma_issueTLB",
-        "MetricName": "tma_info_memory_data_tlbs",
-        "MetricThreshold": "tma_info_memory_data_tlbs > 20",
-        "PublicDescription": "Total pipeline cost of Memory Address Transl=
ation related bottlenecks (data-side TLBs). Related metrics: tma_dtlb_load,=
 tma_dtlb_store"
+        "BriefDescription": "Instruction-Level-Parallelism (average number=
 of uops executed when there is execution) per-thread",
+        "MetricExpr": "UOPS_EXECUTED.THREAD / cpu@UOPS_EXECUTED.THREAD\\,c=
mask\\=3D1@",
+        "MetricGroup": "Cor;Pipeline;PortsUtil;SMT",
+        "MetricName": "tma_info_pipeline_execute"
     },
     {
-        "BriefDescription": "Total pipeline cost of Memory Latency related=
 bottlenecks (external memory and off-core caches)",
+        "BriefDescription": "Average number of Uops retired in cycles wher=
e at least one uop has retired.",
         "MetricConstraint": "NO_GROUP_EVENTS",
-        "MetricExpr": "100 * tma_memory_bound * (tma_dram_bound / (tma_dra=
m_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_bound) * (=
tma_mem_latency / (tma_mem_bandwidth + tma_mem_latency)) + tma_l3_bound / (=
tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_bou=
nd) * (tma_l3_hit_latency / (tma_contested_accesses + tma_data_sharing + tm=
a_l3_hit_latency + tma_sq_full)) + tma_l2_bound / (tma_dram_bound + tma_l1_=
bound + tma_l2_bound + tma_l3_bound + tma_store_bound))",
-        "MetricGroup": "Mem;MemoryLat;Offcore;tma_issueLat",
-        "MetricName": "tma_info_memory_latency",
-        "MetricThreshold": "tma_info_memory_latency > 20",
-        "PublicDescription": "Total pipeline cost of Memory Latency relate=
d bottlenecks (external memory and off-core caches). Related metrics: tma_l=
3_hit_latency, tma_mem_latency"
+        "MetricExpr": "tma_retiring * tma_info_thread_slots / cpu@UOPS_RET=
IRED.SLOTS\\,cmask\\=3D1@",
+        "MetricGroup": "Pipeline;Ret",
+        "MetricName": "tma_info_pipeline_retire"
     },
     {
-        "BriefDescription": "Total pipeline cost of Branch Misprediction r=
elated bottlenecks",
-        "MetricConstraint": "NO_GROUP_EVENTS",
-        "MetricExpr": "100 * (tma_branch_mispredicts + tma_fetch_latency *=
 tma_mispredicts_resteers / (tma_branch_resteers + tma_dsb_switches + tma_i=
cache_misses + tma_itlb_misses + tma_lcp + tma_ms_switches))",
-        "MetricGroup": "Bad;BadSpec;BrMispredicts;tma_issueBM",
-        "MetricName": "tma_info_mispredictions",
-        "MetricThreshold": "tma_info_mispredictions > 20",
-        "PublicDescription": "Total pipeline cost of Branch Misprediction =
related bottlenecks. Related metrics: tma_branch_mispredicts, tma_info_bran=
ch_misprediction_cost, tma_mispredicts_resteers"
+        "BriefDescription": "Measured Average Frequency for unhalted proce=
ssors [GHz]",
+        "MetricExpr": "tma_info_system_turbo_utilization * TSC / 1e9 / dur=
ation_time",
+        "MetricGroup": "Power;Summary",
+        "MetricName": "tma_info_system_average_frequency"
     },
     {
-        "BriefDescription": "Memory-Level-Parallelism (average number of L=
1 miss demand load when there is at least one such miss",
-        "MetricExpr": "L1D_PEND_MISS.PENDING / L1D_PEND_MISS.PENDING_CYCLE=
S",
-        "MetricGroup": "Mem;MemoryBW;MemoryBound",
-        "MetricName": "tma_info_mlp",
-        "PublicDescription": "Memory-Level-Parallelism (average number of =
L1 miss demand load when there is at least one such miss. Per-Logical Proce=
ssor)"
+        "BriefDescription": "Average CPU Utilization",
+        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC / TSC",
+        "MetricGroup": "HPC;Summary",
+        "MetricName": "tma_info_system_cpu_utilization"
     },
     {
-        "BriefDescription": "Fraction of branches of other types (not indi=
vidually covered by other metrics in Info.Branches group)",
-        "MetricExpr": "1 - (tma_info_cond_nt + tma_info_cond_tk + tma_info=
_callret + tma_info_jump)",
-        "MetricGroup": "Bad;Branches",
-        "MetricName": "tma_info_other_branches"
+        "BriefDescription": "Average external Memory Bandwidth Use for rea=
ds and writes [GB / sec]",
+        "MetricExpr": "64 * (UNC_ARB_TRK_REQUESTS.ALL + UNC_ARB_COH_TRK_RE=
QUESTS.ALL) / 1e6 / duration_time / 1e3",
+        "MetricGroup": "HPC;Mem;MemoryBW;SoC;tma_issueBW",
+        "MetricName": "tma_info_system_dram_bw_use",
+        "PublicDescription": "Average external Memory Bandwidth Use for re=
ads and writes [GB / sec]. Related metrics: tma_fb_full, tma_info_bottlenec=
k_memory_bandwidth, tma_mem_bandwidth, tma_sq_full"
     },
     {
-        "BriefDescription": "Utilization of the core's Page Walker(s) serv=
ing STLB misses triggered by instruction/Load/Store accesses",
-        "MetricExpr": "(ITLB_MISSES.WALK_PENDING + DTLB_LOAD_MISSES.WALK_P=
ENDING + DTLB_STORE_MISSES.WALK_PENDING) / (2 * tma_info_core_clks)",
-        "MetricGroup": "Mem;MemoryTLB",
-        "MetricName": "tma_info_page_walks_utilization",
-        "MetricThreshold": "tma_info_page_walks_utilization > 0.5"
+        "BriefDescription": "Giga Floating Point Operations Per Second",
+        "MetricExpr": "(cpu@FP_ARITH_INST_RETIRED.SCALAR_SINGLE\\,umask\\=
=3D0x03@ + 2 * FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + 4 * cpu@FP_ARITH_=
INST_RETIRED.128B_PACKED_SINGLE\\,umask\\=3D0x18@ + 8 * cpu@FP_ARITH_INST_R=
ETIRED.256B_PACKED_SINGLE\\,umask\\=3D0x60@ + 16 * FP_ARITH_INST_RETIRED.51=
2B_PACKED_SINGLE) / 1e9 / duration_time",
+        "MetricGroup": "Cor;Flops;HPC",
+        "MetricName": "tma_info_system_gflops",
+        "PublicDescription": "Giga Floating Point Operations Per Second. A=
ggregate across all supported options of: FP precisions, scalar and vector =
instructions, vector-width and AMX engine."
+    },
+    {
+        "BriefDescription": "Instructions per Far Branch ( Far Branches ap=
ply upon transition from application to operating system, handling interrup=
ts, exceptions) [lower number means higher occurrence rate]",
+        "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.FAR_BRANCH:u",
+        "MetricGroup": "Branches;OS",
+        "MetricName": "tma_info_system_ipfarbranch",
+        "MetricThreshold": "tma_info_system_ipfarbranch < 1e6"
+    },
+    {
+        "BriefDescription": "Cycles Per Instruction for the Operating Syst=
em (OS) Kernel mode",
+        "MetricExpr": "CPU_CLK_UNHALTED.THREAD_P:k / INST_RETIRED.ANY_P:k"=
,
+        "MetricGroup": "OS",
+        "MetricName": "tma_info_system_kernel_cpi"
+    },
+    {
+        "BriefDescription": "Fraction of cycles spent in the Operating Sys=
tem (OS) Kernel mode",
+        "MetricExpr": "CPU_CLK_UNHALTED.THREAD_P:k / CPU_CLK_UNHALTED.THRE=
AD",
+        "MetricGroup": "OS",
+        "MetricName": "tma_info_system_kernel_utilization",
+        "MetricThreshold": "tma_info_system_kernel_utilization > 0.05"
     },
     {
         "BriefDescription": "Fraction of Core cycles where the core was ru=
nning with power-delivery for baseline license level 0",
-        "MetricExpr": "CORE_POWER.LVL0_TURBO_LICENSE / tma_info_core_clks"=
,
+        "MetricExpr": "CORE_POWER.LVL0_TURBO_LICENSE / tma_info_core_core_=
clks",
         "MetricGroup": "Power",
-        "MetricName": "tma_info_power_license0_utilization",
+        "MetricName": "tma_info_system_power_license0_utilization",
         "PublicDescription": "Fraction of Core cycles where the core was r=
unning with power-delivery for baseline license level 0.  This includes non=
-AVX codes, SSE, AVX 128-bit, and low-current AVX 256-bit codes."
     },
     {
         "BriefDescription": "Fraction of Core cycles where the core was ru=
nning with power-delivery for license level 1",
-        "MetricExpr": "CORE_POWER.LVL1_TURBO_LICENSE / tma_info_core_clks"=
,
+        "MetricExpr": "CORE_POWER.LVL1_TURBO_LICENSE / tma_info_core_core_=
clks",
         "MetricGroup": "Power",
-        "MetricName": "tma_info_power_license1_utilization",
-        "MetricThreshold": "tma_info_power_license1_utilization > 0.5",
+        "MetricName": "tma_info_system_power_license1_utilization",
+        "MetricThreshold": "tma_info_system_power_license1_utilization > 0=
.5",
         "PublicDescription": "Fraction of Core cycles where the core was r=
unning with power-delivery for license level 1.  This includes high current=
 AVX 256-bit instructions as well as low current AVX 512-bit instructions."
     },
     {
         "BriefDescription": "Fraction of Core cycles where the core was ru=
nning with power-delivery for license level 2 (introduced in SKX)",
-        "MetricExpr": "CORE_POWER.LVL2_TURBO_LICENSE / tma_info_core_clks"=
,
+        "MetricExpr": "CORE_POWER.LVL2_TURBO_LICENSE / tma_info_core_core_=
clks",
         "MetricGroup": "Power",
-        "MetricName": "tma_info_power_license2_utilization",
-        "MetricThreshold": "tma_info_power_license2_utilization > 0.5",
+        "MetricName": "tma_info_system_power_license2_utilization",
+        "MetricThreshold": "tma_info_system_power_license2_utilization > 0=
.5",
         "PublicDescription": "Fraction of Core cycles where the core was r=
unning with power-delivery for license level 2 (introduced in SKX).  This i=
ncludes high current AVX 512-bit instructions."
     },
-    {
-        "BriefDescription": "Average number of Uops retired in cycles wher=
e at least one uop has retired.",
-        "MetricConstraint": "NO_GROUP_EVENTS",
-        "MetricExpr": "tma_retiring * tma_info_slots / cpu@UOPS_RETIRED.SL=
OTS\\,cmask\\=3D1@",
-        "MetricGroup": "Pipeline;Ret",
-        "MetricName": "tma_info_retire"
-    },
-    {
-        "BriefDescription": "Total issue-pipeline slots (per-Physical Core=
 till ICL; per-Logical Processor ICL onward)",
-        "MetricExpr": "TOPDOWN.SLOTS",
-        "MetricGroup": "TmaL1;tma_L1_group",
-        "MetricName": "tma_info_slots"
-    },
-    {
-        "BriefDescription": "Fraction of Physical Core issue-slots utilize=
d by this Logical Processor",
-        "MetricExpr": "(tma_info_slots / (TOPDOWN.SLOTS / 2) if #SMT_on el=
se 1)",
-        "MetricGroup": "SMT;TmaL1;tma_L1_group",
-        "MetricName": "tma_info_slots_utilization"
-    },
     {
         "BriefDescription": "Fraction of cycles where both hardware Logica=
l Processors were active",
         "MetricExpr": "(1 - CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_U=
NHALTED.REF_DISTRIBUTED if #SMT_on else 0)",
         "MetricGroup": "SMT",
-        "MetricName": "tma_info_smt_2t_utilization"
+        "MetricName": "tma_info_system_smt_2t_utilization"
     },
     {
         "BriefDescription": "Socket actual clocks when any core is active =
on that socket",
         "MetricExpr": "UNC_CLOCK.SOCKET",
         "MetricGroup": "SoC",
-        "MetricName": "tma_info_socket_clks"
-    },
-    {
-        "BriefDescription": "STLB (2nd level TLB) data store speculative m=
isses per kilo instruction (misses of any page-size that complete the page =
walk)",
-        "MetricExpr": "1e3 * DTLB_STORE_MISSES.WALK_COMPLETED / INST_RETIR=
ED.ANY",
-        "MetricGroup": "Mem;MemoryTLB",
-        "MetricName": "tma_info_store_stlb_mpki"
+        "MetricName": "tma_info_system_socket_clks"
     },
     {
         "BriefDescription": "Average Frequency Utilization relative nomina=
l frequency",
-        "MetricExpr": "tma_info_clks / CPU_CLK_UNHALTED.REF_TSC",
+        "MetricExpr": "tma_info_thread_clks / CPU_CLK_UNHALTED.REF_TSC",
         "MetricGroup": "Power",
-        "MetricName": "tma_info_turbo_utilization"
+        "MetricName": "tma_info_system_turbo_utilization"
+    },
+    {
+        "BriefDescription": "Per-Logical Processor actual clocks when the =
Logical Processor is active.",
+        "MetricExpr": "CPU_CLK_UNHALTED.THREAD",
+        "MetricGroup": "Pipeline",
+        "MetricName": "tma_info_thread_clks"
+    },
+    {
+        "BriefDescription": "Cycles Per Instruction (per Logical Processor=
)",
+        "MetricExpr": "1 / tma_info_thread_ipc",
+        "MetricGroup": "Mem;Pipeline",
+        "MetricName": "tma_info_thread_cpi"
+    },
+    {
+        "BriefDescription": "The ratio of Executed- by Issued-Uops",
+        "MetricExpr": "UOPS_EXECUTED.THREAD / UOPS_ISSUED.ANY",
+        "MetricGroup": "Cor;Pipeline",
+        "MetricName": "tma_info_thread_execute_per_issue",
+        "PublicDescription": "The ratio of Executed- by Issued-Uops. Ratio=
 > 1 suggests high rate of uop micro-fusions. Ratio < 1 suggest high rate o=
f \"execute\" at rename stage."
+    },
+    {
+        "BriefDescription": "Instructions Per Cycle (per Logical Processor=
)",
+        "MetricExpr": "INST_RETIRED.ANY / tma_info_thread_clks",
+        "MetricGroup": "Ret;Summary",
+        "MetricName": "tma_info_thread_ipc"
+    },
+    {
+        "BriefDescription": "Total issue-pipeline slots (per-Physical Core=
 till ICL; per-Logical Processor ICL onward)",
+        "MetricExpr": "TOPDOWN.SLOTS",
+        "MetricGroup": "TmaL1;tma_L1_group",
+        "MetricName": "tma_info_thread_slots"
+    },
+    {
+        "BriefDescription": "Fraction of Physical Core issue-slots utilize=
d by this Logical Processor",
+        "MetricExpr": "(tma_info_thread_slots / (TOPDOWN.SLOTS / 2) if #SM=
T_on else 1)",
+        "MetricGroup": "SMT;TmaL1;tma_L1_group",
+        "MetricName": "tma_info_thread_slots_utilization"
     },
     {
         "BriefDescription": "Uops Per Instruction",
-        "MetricExpr": "tma_retiring * tma_info_slots / INST_RETIRED.ANY",
+        "MetricExpr": "tma_retiring * tma_info_thread_slots / INST_RETIRED=
.ANY",
         "MetricGroup": "Pipeline;Ret;Retire",
-        "MetricName": "tma_info_uoppi",
-        "MetricThreshold": "tma_info_uoppi > 1.05"
+        "MetricName": "tma_info_thread_uoppi",
+        "MetricThreshold": "tma_info_thread_uoppi > 1.05"
     },
     {
         "BriefDescription": "Instruction per taken branch",
-        "MetricExpr": "tma_retiring * tma_info_slots / BR_INST_RETIRED.NEA=
R_TAKEN",
+        "MetricExpr": "tma_retiring * tma_info_thread_slots / BR_INST_RETI=
RED.NEAR_TAKEN",
         "MetricGroup": "Branches;Fed;FetchBW",
-        "MetricName": "tma_info_uptb",
-        "MetricThreshold": "tma_info_uptb < 7.5"
+        "MetricName": "tma_info_thread_uptb",
+        "MetricThreshold": "tma_info_thread_uptb < 7.5"
     },
     {
         "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to Instruction TLB (ITLB) misses",
-        "MetricExpr": "ICACHE_64B.IFTAG_STALL / tma_info_clks",
+        "MetricExpr": "ICACHE_64B.IFTAG_STALL / tma_info_thread_clks",
         "MetricGroup": "BigFoot;FetchLat;MemoryTLB;TopdownL3;tma_L3_group;=
tma_fetch_latency_group",
         "MetricName": "tma_itlb_misses",
         "MetricThreshold": "tma_itlb_misses > 0.05 & (tma_fetch_latency > =
0.1 & tma_frontend_bound > 0.15)",
@@ -1078,7 +1078,7 @@
     },
     {
         "BriefDescription": "This metric estimates how often the CPU was s=
talled without loads missing the L1 data cache",
-        "MetricExpr": "max((CYCLE_ACTIVITY.STALLS_MEM_ANY - CYCLE_ACTIVITY=
.STALLS_L1D_MISS) / tma_info_clks, 0)",
+        "MetricExpr": "max((CYCLE_ACTIVITY.STALLS_MEM_ANY - CYCLE_ACTIVITY=
.STALLS_L1D_MISS) / tma_info_thread_clks, 0)",
         "MetricGroup": "CacheMisses;MemoryBound;TmaL3mem;TopdownL3;tma_L3_=
group;tma_issueL1;tma_issueMC;tma_memory_bound_group",
         "MetricName": "tma_l1_bound",
         "MetricThreshold": "tma_l1_bound > 0.1 & (tma_memory_bound > 0.2 &=
 tma_backend_bound > 0.2)",
@@ -1088,7 +1088,7 @@
     {
         "BriefDescription": "This metric estimates how often the CPU was s=
talled due to L2 cache accesses by loads",
         "MetricConstraint": "NO_GROUP_EVENTS",
-        "MetricExpr": "MEM_LOAD_RETIRED.L2_HIT * (1 + MEM_LOAD_RETIRED.FB_=
HIT / MEM_LOAD_RETIRED.L1_MISS) / (MEM_LOAD_RETIRED.L2_HIT * (1 + MEM_LOAD_=
RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS) + L1D_PEND_MISS.FB_FULL_PERIODS)=
 * ((CYCLE_ACTIVITY.STALLS_L1D_MISS - CYCLE_ACTIVITY.STALLS_L2_MISS) / tma_=
info_clks)",
+        "MetricExpr": "MEM_LOAD_RETIRED.L2_HIT * (1 + MEM_LOAD_RETIRED.FB_=
HIT / MEM_LOAD_RETIRED.L1_MISS) / (MEM_LOAD_RETIRED.L2_HIT * (1 + MEM_LOAD_=
RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS) + L1D_PEND_MISS.FB_FULL_PERIODS)=
 * ((CYCLE_ACTIVITY.STALLS_L1D_MISS - CYCLE_ACTIVITY.STALLS_L2_MISS) / tma_=
info_thread_clks)",
         "MetricGroup": "CacheMisses;MemoryBound;TmaL3mem;TopdownL3;tma_L3_=
group;tma_memory_bound_group",
         "MetricName": "tma_l2_bound",
         "MetricThreshold": "tma_l2_bound > 0.05 & (tma_memory_bound > 0.2 =
& tma_backend_bound > 0.2)",
@@ -1097,7 +1097,7 @@
     },
     {
         "BriefDescription": "This metric estimates how often the CPU was s=
talled due to loads accesses to L3 cache or contended with a sibling Core",
-        "MetricExpr": "(CYCLE_ACTIVITY.STALLS_L2_MISS - CYCLE_ACTIVITY.STA=
LLS_L3_MISS) / tma_info_clks",
+        "MetricExpr": "(CYCLE_ACTIVITY.STALLS_L2_MISS - CYCLE_ACTIVITY.STA=
LLS_L3_MISS) / tma_info_thread_clks",
         "MetricGroup": "CacheMisses;MemoryBound;TmaL3mem;TopdownL3;tma_L3_=
group;tma_memory_bound_group",
         "MetricName": "tma_l3_bound",
         "MetricThreshold": "tma_l3_bound > 0.05 & (tma_memory_bound > 0.2 =
& tma_backend_bound > 0.2)",
@@ -1106,20 +1106,20 @@
     },
     {
         "BriefDescription": "This metric represents fraction of cycles wit=
h demand load accesses that hit the L3 cache under unloaded scenarios (poss=
ibly L3 latency limited)",
-        "MetricExpr": "9 * tma_info_average_frequency * MEM_LOAD_RETIRED.L=
3_HIT * (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS / 2) / tma_=
info_clks",
+        "MetricExpr": "9 * tma_info_system_average_frequency * MEM_LOAD_RE=
TIRED.L3_HIT * (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS / 2)=
 / tma_info_thread_clks",
         "MetricGroup": "MemoryLat;TopdownL4;tma_L4_group;tma_issueLat;tma_=
l3_bound_group",
         "MetricName": "tma_l3_hit_latency",
         "MetricThreshold": "tma_l3_hit_latency > 0.1 & (tma_l3_bound > 0.0=
5 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
-        "PublicDescription": "This metric represents fraction of cycles wi=
th demand load accesses that hit the L3 cache under unloaded scenarios (pos=
sibly L3 latency limited).  Avoiding private cache misses (i.e. L2 misses/L=
3 hits) will improve the latency; reduce contention with sibling physical c=
ores and increase performance.  Note the value of this node may overlap wit=
h its siblings. Sample with: MEM_LOAD_RETIRED.L3_HIT_PS. Related metrics: t=
ma_info_memory_latency, tma_mem_latency",
+        "PublicDescription": "This metric represents fraction of cycles wi=
th demand load accesses that hit the L3 cache under unloaded scenarios (pos=
sibly L3 latency limited).  Avoiding private cache misses (i.e. L2 misses/L=
3 hits) will improve the latency; reduce contention with sibling physical c=
ores and increase performance.  Note the value of this node may overlap wit=
h its siblings. Sample with: MEM_LOAD_RETIRED.L3_HIT_PS. Related metrics: t=
ma_info_bottleneck_memory_latency, tma_mem_latency",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "This metric represents fraction of cycles CPU=
 was stalled due to Length Changing Prefixes (LCPs)",
-        "MetricExpr": "ILD_STALL.LCP / tma_info_clks",
+        "MetricExpr": "ILD_STALL.LCP / tma_info_thread_clks",
         "MetricGroup": "FetchLat;TopdownL3;tma_L3_group;tma_fetch_latency_=
group;tma_issueFB",
         "MetricName": "tma_lcp",
         "MetricThreshold": "tma_lcp > 0.05 & (tma_fetch_latency > 0.1 & tm=
a_frontend_bound > 0.15)",
-        "PublicDescription": "This metric represents fraction of cycles CP=
U was stalled due to Length Changing Prefixes (LCPs). Using proper compiler=
 flags or Intel Compiler by default will certainly avoid this. #Link: Optim=
ization Guide about LCP BKMs. Related metrics: tma_dsb_switches, tma_fetch_=
bandwidth, tma_info_dsb_coverage, tma_info_dsb_misses, tma_info_iptb",
+        "PublicDescription": "This metric represents fraction of cycles CP=
U was stalled due to Length Changing Prefixes (LCPs). Using proper compiler=
 flags or Intel Compiler by default will certainly avoid this. #Link: Optim=
ization Guide about LCP BKMs. Related metrics: tma_dsb_switches, tma_fetch_=
bandwidth, tma_info_botlnk_l2_dsb_misses, tma_info_frontend_dsb_coverage, t=
ma_info_inst_mix_iptb",
         "ScaleUnit": "100%"
     },
     {
@@ -1134,7 +1134,7 @@
     },
     {
         "BriefDescription": "This metric represents Core fraction of cycle=
s CPU dispatched uops on execution port for Load operations",
-        "MetricExpr": "UOPS_DISPATCHED.PORT_2_3 / (2 * tma_info_core_clks)=
",
+        "MetricExpr": "UOPS_DISPATCHED.PORT_2_3 / (2 * tma_info_core_core_=
clks)",
         "MetricGroup": "TopdownL5;tma_L5_group;tma_ports_utilized_3m_group=
",
         "MetricName": "tma_load_op_utilization",
         "MetricThreshold": "tma_load_op_utilization > 0.6",
@@ -1151,7 +1151,7 @@
     },
     {
         "BriefDescription": "This metric estimates the fraction of cycles =
where the Second-level TLB (STLB) was missed by load accesses, performing a=
 hardware page walk",
-        "MetricExpr": "DTLB_LOAD_MISSES.WALK_ACTIVE / tma_info_clks",
+        "MetricExpr": "DTLB_LOAD_MISSES.WALK_ACTIVE / tma_info_thread_clks=
",
         "MetricGroup": "MemoryTLB;TopdownL5;tma_L5_group;tma_dtlb_load_gro=
up",
         "MetricName": "tma_load_stlb_miss",
         "MetricThreshold": "tma_load_stlb_miss > 0.05 & (tma_dtlb_load > 0=
.1 & (tma_l1_bound > 0.1 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.=
2)))",
@@ -1160,7 +1160,7 @@
     {
         "BriefDescription": "This metric represents fraction of cycles the=
 CPU spent handling cache misses due to lock operations",
         "MetricConstraint": "NO_GROUP_EVENTS",
-        "MetricExpr": "(16 * max(0, MEM_INST_RETIRED.LOCK_LOADS - L2_RQSTS=
.ALL_RFO) + MEM_INST_RETIRED.LOCK_LOADS / MEM_INST_RETIRED.ALL_STORES * (10=
 * L2_RQSTS.RFO_HIT + min(CPU_CLK_UNHALTED.THREAD, OFFCORE_REQUESTS_OUTSTAN=
DING.CYCLES_WITH_DEMAND_RFO))) / tma_info_clks",
+        "MetricExpr": "(16 * max(0, MEM_INST_RETIRED.LOCK_LOADS - L2_RQSTS=
.ALL_RFO) + MEM_INST_RETIRED.LOCK_LOADS / MEM_INST_RETIRED.ALL_STORES * (10=
 * L2_RQSTS.RFO_HIT + min(CPU_CLK_UNHALTED.THREAD, OFFCORE_REQUESTS_OUTSTAN=
DING.CYCLES_WITH_DEMAND_RFO))) / tma_info_thread_clks",
         "MetricGroup": "Offcore;TopdownL4;tma_L4_group;tma_issueRFO;tma_l1=
_bound_group",
         "MetricName": "tma_lock_latency",
         "MetricThreshold": "tma_lock_latency > 0.2 & (tma_l1_bound > 0.1 &=
 (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
@@ -1169,10 +1169,10 @@
     },
     {
         "BriefDescription": "This metric represents Core fraction of cycle=
s in which CPU was likely limited due to LSD (Loop Stream Detector) unit",
-        "MetricExpr": "(LSD.CYCLES_ACTIVE - LSD.CYCLES_OK) / tma_info_core=
_clks / 2",
+        "MetricExpr": "(LSD.CYCLES_ACTIVE - LSD.CYCLES_OK) / tma_info_core=
_core_clks / 2",
         "MetricGroup": "FetchBW;LSD;TopdownL3;tma_L3_group;tma_fetch_bandw=
idth_group",
         "MetricName": "tma_lsd",
-        "MetricThreshold": "tma_lsd > 0.15 & (tma_fetch_bandwidth > 0.1 & =
tma_frontend_bound > 0.15 & tma_info_ipc / 5 > 0.35)",
+        "MetricThreshold": "tma_lsd > 0.15 & (tma_fetch_bandwidth > 0.1 & =
tma_frontend_bound > 0.15 & tma_info_thread_ipc / 5 > 0.35)",
         "PublicDescription": "This metric represents Core fraction of cycl=
es in which CPU was likely limited due to LSD (Loop Stream Detector) unit. =
 LSD typically does well sustaining Uop supply. However; in some rare cases=
; optimal uop-delivery could not be reached for small loops whose size (in =
terms of number of uops) does not suit well the LSD structure.",
         "ScaleUnit": "100%"
     },
@@ -1188,20 +1188,20 @@
     },
     {
         "BriefDescription": "This metric estimates fraction of cycles wher=
e the core's performance was likely hurt due to approaching bandwidth limit=
s of external memory (DRAM)",
-        "MetricExpr": "min(CPU_CLK_UNHALTED.THREAD, cpu@OFFCORE_REQUESTS_O=
UTSTANDING.ALL_DATA_RD\\,cmask\\=3D4@) / tma_info_clks",
+        "MetricExpr": "min(CPU_CLK_UNHALTED.THREAD, cpu@OFFCORE_REQUESTS_O=
UTSTANDING.ALL_DATA_RD\\,cmask\\=3D4@) / tma_info_thread_clks",
         "MetricGroup": "MemoryBW;Offcore;TopdownL4;tma_L4_group;tma_dram_b=
ound_group;tma_issueBW",
         "MetricName": "tma_mem_bandwidth",
         "MetricThreshold": "tma_mem_bandwidth > 0.2 & (tma_dram_bound > 0.=
1 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
-        "PublicDescription": "This metric estimates fraction of cycles whe=
re the core's performance was likely hurt due to approaching bandwidth limi=
ts of external memory (DRAM).  The underlying heuristic assumes that a simi=
lar off-core traffic is generated by all IA cores. This metric does not agg=
regate non-data-read requests by this logical processor; requests from othe=
r IA Logical Processors/Physical Cores/sockets; or other non-IA devices lik=
e GPU; hence the maximum external memory bandwidth limits may or may not be=
 approached when this metric is flagged (see Uncore counters for that). Rel=
ated metrics: tma_fb_full, tma_info_dram_bw_use, tma_info_memory_bandwidth,=
 tma_sq_full",
+        "PublicDescription": "This metric estimates fraction of cycles whe=
re the core's performance was likely hurt due to approaching bandwidth limi=
ts of external memory (DRAM).  The underlying heuristic assumes that a simi=
lar off-core traffic is generated by all IA cores. This metric does not agg=
regate non-data-read requests by this logical processor; requests from othe=
r IA Logical Processors/Physical Cores/sockets; or other non-IA devices lik=
e GPU; hence the maximum external memory bandwidth limits may or may not be=
 approached when this metric is flagged (see Uncore counters for that). Rel=
ated metrics: tma_fb_full, tma_info_bottleneck_memory_bandwidth, tma_info_s=
ystem_dram_bw_use, tma_sq_full",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "This metric estimates fraction of cycles wher=
e the performance was likely hurt due to latency from external memory (DRAM=
)",
-        "MetricExpr": "min(CPU_CLK_UNHALTED.THREAD, OFFCORE_REQUESTS_OUTST=
ANDING.CYCLES_WITH_DATA_RD) / tma_info_clks - tma_mem_bandwidth",
+        "MetricExpr": "min(CPU_CLK_UNHALTED.THREAD, OFFCORE_REQUESTS_OUTST=
ANDING.CYCLES_WITH_DATA_RD) / tma_info_thread_clks - tma_mem_bandwidth",
         "MetricGroup": "MemoryLat;Offcore;TopdownL4;tma_L4_group;tma_dram_=
bound_group;tma_issueLat",
         "MetricName": "tma_mem_latency",
         "MetricThreshold": "tma_mem_latency > 0.1 & (tma_dram_bound > 0.1 =
& (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
-        "PublicDescription": "This metric estimates fraction of cycles whe=
re the performance was likely hurt due to latency from external memory (DRA=
M).  This metric does not aggregate requests from other Logical Processors/=
Physical Cores/sockets (see Uncore counters for that). Related metrics: tma=
_info_memory_latency, tma_l3_hit_latency",
+        "PublicDescription": "This metric estimates fraction of cycles whe=
re the performance was likely hurt due to latency from external memory (DRA=
M).  This metric does not aggregate requests from other Logical Processors/=
Physical Cores/sockets (see Uncore counters for that). Related metrics: tma=
_info_bottleneck_memory_latency, tma_l3_hit_latency",
         "ScaleUnit": "100%"
     },
     {
@@ -1225,7 +1225,7 @@
     },
     {
         "BriefDescription": "This metric represents fraction of slots the =
CPU was retiring uops fetched by the Microcode Sequencer (MS) unit",
-        "MetricExpr": "tma_retiring * tma_info_slots / UOPS_ISSUED.ANY * I=
DQ.MS_UOPS / tma_info_slots",
+        "MetricExpr": "tma_retiring * tma_info_thread_slots / UOPS_ISSUED.=
ANY * IDQ.MS_UOPS / tma_info_thread_slots",
         "MetricGroup": "MicroSeq;TopdownL3;tma_L3_group;tma_heavy_operatio=
ns_group;tma_issueMC;tma_issueMS",
         "MetricName": "tma_microcode_sequencer",
         "MetricThreshold": "tma_microcode_sequencer > 0.05 & tma_heavy_ope=
rations > 0.1",
@@ -1234,28 +1234,28 @@
     },
     {
         "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to Branch Resteers as a result of Branch Misprediction=
 at execution stage",
-        "MetricExpr": "BR_MISP_RETIRED.ALL_BRANCHES / (BR_MISP_RETIRED.ALL=
_BRANCHES + MACHINE_CLEARS.COUNT) * INT_MISC.CLEAR_RESTEER_CYCLES / tma_inf=
o_clks",
+        "MetricExpr": "BR_MISP_RETIRED.ALL_BRANCHES / (BR_MISP_RETIRED.ALL=
_BRANCHES + MACHINE_CLEARS.COUNT) * INT_MISC.CLEAR_RESTEER_CYCLES / tma_inf=
o_thread_clks",
         "MetricGroup": "BadSpec;BrMispredicts;TopdownL4;tma_L4_group;tma_b=
ranch_resteers_group;tma_issueBM",
         "MetricName": "tma_mispredicts_resteers",
         "MetricThreshold": "tma_mispredicts_resteers > 0.05 & (tma_branch_=
resteers > 0.05 & (tma_fetch_latency > 0.1 & tma_frontend_bound > 0.15))",
-        "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to Branch Resteers as a result of Branch Mispredictio=
n at execution stage. Sample with: INT_MISC.CLEAR_RESTEER_CYCLES. Related m=
etrics: tma_branch_mispredicts, tma_info_branch_misprediction_cost, tma_inf=
o_mispredictions",
+        "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to Branch Resteers as a result of Branch Mispredictio=
n at execution stage. Sample with: INT_MISC.CLEAR_RESTEER_CYCLES. Related m=
etrics: tma_branch_mispredicts, tma_info_bad_spec_branch_misprediction_cost=
, tma_info_bottleneck_mispredictions",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "This metric represents Core fraction of cycle=
s in which CPU was likely limited due to the MITE pipeline (the legacy deco=
de pipeline)",
-        "MetricExpr": "(IDQ.MITE_CYCLES_ANY - IDQ.MITE_CYCLES_OK) / tma_in=
fo_core_clks / 2",
+        "MetricExpr": "(IDQ.MITE_CYCLES_ANY - IDQ.MITE_CYCLES_OK) / tma_in=
fo_core_core_clks / 2",
         "MetricGroup": "DSBmiss;FetchBW;TopdownL3;tma_L3_group;tma_fetch_b=
andwidth_group",
         "MetricName": "tma_mite",
-        "MetricThreshold": "tma_mite > 0.1 & (tma_fetch_bandwidth > 0.1 & =
tma_frontend_bound > 0.15 & tma_info_ipc / 5 > 0.35)",
+        "MetricThreshold": "tma_mite > 0.1 & (tma_fetch_bandwidth > 0.1 & =
tma_frontend_bound > 0.15 & tma_info_thread_ipc / 5 > 0.35)",
         "PublicDescription": "This metric represents Core fraction of cycl=
es in which CPU was likely limited due to the MITE pipeline (the legacy dec=
ode pipeline). This pipeline is used for code that was not pre-cached in th=
e DSB or LSD. For example; inefficiencies due to asymmetric decoders; use o=
f long immediate or LCP can manifest as MITE fetch bandwidth bottleneck. Sa=
mple with: FRONTEND_RETIRED.ANY_DSB_MISS",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "This metric represents fraction of cycles whe=
re (only) 4 uops were delivered by the MITE pipeline",
-        "MetricExpr": "(cpu@IDQ.MITE_UOPS\\,cmask\\=3D4@ - cpu@IDQ.MITE_UO=
PS\\,cmask\\=3D5@) / tma_info_clks",
+        "MetricExpr": "(cpu@IDQ.MITE_UOPS\\,cmask\\=3D4@ - cpu@IDQ.MITE_UO=
PS\\,cmask\\=3D5@) / tma_info_thread_clks",
         "MetricGroup": "DSBmiss;FetchBW;TopdownL4;tma_L4_group;tma_mite_gr=
oup",
         "MetricName": "tma_mite_4wide",
-        "MetricThreshold": "tma_mite_4wide > 0.05 & (tma_mite > 0.1 & (tma=
_fetch_bandwidth > 0.1 & tma_frontend_bound > 0.15 & tma_info_ipc / 5 > 0.3=
5))",
+        "MetricThreshold": "tma_mite_4wide > 0.05 & (tma_mite > 0.1 & (tma=
_fetch_bandwidth > 0.1 & tma_frontend_bound > 0.15 & tma_info_thread_ipc / =
5 > 0.35))",
         "ScaleUnit": "100%"
     },
     {
@@ -1269,7 +1269,7 @@
     },
     {
         "BriefDescription": "This metric estimates the fraction of cycles =
when the CPU was stalled due to switches of uop delivery to the Microcode S=
equencer (MS)",
-        "MetricExpr": "3 * IDQ.MS_SWITCHES / tma_info_clks",
+        "MetricExpr": "3 * IDQ.MS_SWITCHES / tma_info_thread_clks",
         "MetricGroup": "FetchLat;MicroSeq;TopdownL3;tma_L3_group;tma_fetch=
_latency_group;tma_issueMC;tma_issueMS;tma_issueMV;tma_issueSO",
         "MetricName": "tma_ms_switches",
         "MetricThreshold": "tma_ms_switches > 0.05 & (tma_fetch_latency > =
0.1 & tma_frontend_bound > 0.15)",
@@ -1278,7 +1278,7 @@
     },
     {
         "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring NOP (no op) instructions",
-        "MetricExpr": "tma_light_operations * INST_RETIRED.NOP / (tma_reti=
ring * tma_info_slots)",
+        "MetricExpr": "tma_light_operations * INST_RETIRED.NOP / (tma_reti=
ring * tma_info_thread_slots)",
         "MetricGroup": "Pipeline;TopdownL3;tma_L3_group;tma_light_operatio=
ns_group",
         "MetricName": "tma_nop_instructions",
         "MetricThreshold": "tma_nop_instructions > 0.1 & tma_light_operati=
ons > 0.6",
@@ -1297,7 +1297,7 @@
     },
     {
         "BriefDescription": "This metric represents Core fraction of cycle=
s CPU dispatched uops on execution port 0 ([SNB+] ALU; [HSW+] ALU and 2nd b=
ranch)",
-        "MetricExpr": "UOPS_DISPATCHED.PORT_0 / tma_info_core_clks",
+        "MetricExpr": "UOPS_DISPATCHED.PORT_0 / tma_info_core_core_clks",
         "MetricGroup": "Compute;TopdownL6;tma_L6_group;tma_alu_op_utilizat=
ion_group;tma_issue2P",
         "MetricName": "tma_port_0",
         "MetricThreshold": "tma_port_0 > 0.6",
@@ -1306,7 +1306,7 @@
     },
     {
         "BriefDescription": "This metric represents Core fraction of cycle=
s CPU dispatched uops on execution port 1 (ALU)",
-        "MetricExpr": "UOPS_DISPATCHED.PORT_1 / tma_info_core_clks",
+        "MetricExpr": "UOPS_DISPATCHED.PORT_1 / tma_info_core_core_clks",
         "MetricGroup": "TopdownL6;tma_L6_group;tma_alu_op_utilization_grou=
p;tma_issue2P",
         "MetricName": "tma_port_1",
         "MetricThreshold": "tma_port_1 > 0.6",
@@ -1315,7 +1315,7 @@
     },
     {
         "BriefDescription": "This metric represents Core fraction of cycle=
s CPU dispatched uops on execution port 5 ([SNB+] Branches and ALU; [HSW+] =
ALU)",
-        "MetricExpr": "UOPS_DISPATCHED.PORT_5 / tma_info_core_clks",
+        "MetricExpr": "UOPS_DISPATCHED.PORT_5 / tma_info_core_core_clks",
         "MetricGroup": "TopdownL6;tma_L6_group;tma_alu_op_utilization_grou=
p;tma_issue2P",
         "MetricName": "tma_port_5",
         "MetricThreshold": "tma_port_5 > 0.6",
@@ -1324,7 +1324,7 @@
     },
     {
         "BriefDescription": "This metric represents Core fraction of cycle=
s CPU dispatched uops on execution port 6 ([HSW+]Primary Branch and simple =
ALU)",
-        "MetricExpr": "UOPS_DISPATCHED.PORT_6 / tma_info_core_clks",
+        "MetricExpr": "UOPS_DISPATCHED.PORT_6 / tma_info_core_core_clks",
         "MetricGroup": "TopdownL6;tma_L6_group;tma_alu_op_utilization_grou=
p;tma_issue2P",
         "MetricName": "tma_port_6",
         "MetricThreshold": "tma_port_6 > 0.6",
@@ -1333,7 +1333,7 @@
     },
     {
         "BriefDescription": "This metric estimates fraction of cycles the =
CPU performance was potentially limited due to Core computation issues (non=
 divider-related)",
-        "MetricExpr": "((cpu@EXE_ACTIVITY.3_PORTS_UTIL\\,umask\\=3D0x80@ +=
 tma_serializing_operation * (CYCLE_ACTIVITY.STALLS_TOTAL - CYCLE_ACTIVITY.=
STALLS_MEM_ANY) + (EXE_ACTIVITY.1_PORTS_UTIL + tma_retiring * EXE_ACTIVITY.=
2_PORTS_UTIL)) / tma_info_clks if ARITH.DIVIDER_ACTIVE < CYCLE_ACTIVITY.STA=
LLS_TOTAL - CYCLE_ACTIVITY.STALLS_MEM_ANY else (EXE_ACTIVITY.1_PORTS_UTIL +=
 tma_retiring * EXE_ACTIVITY.2_PORTS_UTIL) / tma_info_clks)",
+        "MetricExpr": "((cpu@EXE_ACTIVITY.3_PORTS_UTIL\\,umask\\=3D0x80@ +=
 tma_serializing_operation * (CYCLE_ACTIVITY.STALLS_TOTAL - CYCLE_ACTIVITY.=
STALLS_MEM_ANY) + (EXE_ACTIVITY.1_PORTS_UTIL + tma_retiring * EXE_ACTIVITY.=
2_PORTS_UTIL)) / tma_info_thread_clks if ARITH.DIVIDER_ACTIVE < CYCLE_ACTIV=
ITY.STALLS_TOTAL - CYCLE_ACTIVITY.STALLS_MEM_ANY else (EXE_ACTIVITY.1_PORTS=
_UTIL + tma_retiring * EXE_ACTIVITY.2_PORTS_UTIL) / tma_info_thread_clks)",
         "MetricGroup": "PortsUtil;TopdownL3;tma_L3_group;tma_core_bound_gr=
oup",
         "MetricName": "tma_ports_utilization",
         "MetricThreshold": "tma_ports_utilization > 0.15 & (tma_core_bound=
 > 0.1 & tma_backend_bound > 0.2)",
@@ -1342,7 +1342,7 @@
     },
     {
         "BriefDescription": "This metric represents fraction of cycles CPU=
 executed no uops on any execution port (Logical Processor cycles since ICL=
, Physical Core cycles otherwise)",
-        "MetricExpr": "cpu@EXE_ACTIVITY.3_PORTS_UTIL\\,umask\\=3D0x80@ / t=
ma_info_clks + tma_serializing_operation * (CYCLE_ACTIVITY.STALLS_TOTAL - C=
YCLE_ACTIVITY.STALLS_MEM_ANY) / tma_info_clks",
+        "MetricExpr": "cpu@EXE_ACTIVITY.3_PORTS_UTIL\\,umask\\=3D0x80@ / t=
ma_info_thread_clks + tma_serializing_operation * (CYCLE_ACTIVITY.STALLS_TO=
TAL - CYCLE_ACTIVITY.STALLS_MEM_ANY) / tma_info_thread_clks",
         "MetricGroup": "PortsUtil;TopdownL4;tma_L4_group;tma_ports_utiliza=
tion_group",
         "MetricName": "tma_ports_utilized_0",
         "MetricThreshold": "tma_ports_utilized_0 > 0.2 & (tma_ports_utiliz=
ation > 0.15 & (tma_core_bound > 0.1 & tma_backend_bound > 0.2))",
@@ -1351,7 +1351,7 @@
     },
     {
         "BriefDescription": "This metric represents fraction of cycles whe=
re the CPU executed total of 1 uop per cycle on all execution ports (Logica=
l Processor cycles since ICL, Physical Core cycles otherwise)",
-        "MetricExpr": "EXE_ACTIVITY.1_PORTS_UTIL / tma_info_clks",
+        "MetricExpr": "EXE_ACTIVITY.1_PORTS_UTIL / tma_info_thread_clks",
         "MetricGroup": "PortsUtil;TopdownL4;tma_L4_group;tma_issueL1;tma_p=
orts_utilization_group",
         "MetricName": "tma_ports_utilized_1",
         "MetricThreshold": "tma_ports_utilized_1 > 0.2 & (tma_ports_utiliz=
ation > 0.15 & (tma_core_bound > 0.1 & tma_backend_bound > 0.2))",
@@ -1360,7 +1360,7 @@
     },
     {
         "BriefDescription": "This metric represents fraction of cycles CPU=
 executed total of 2 uops per cycle on all execution ports (Logical Process=
or cycles since ICL, Physical Core cycles otherwise)",
-        "MetricExpr": "EXE_ACTIVITY.2_PORTS_UTIL / tma_info_clks",
+        "MetricExpr": "EXE_ACTIVITY.2_PORTS_UTIL / tma_info_thread_clks",
         "MetricGroup": "PortsUtil;TopdownL4;tma_L4_group;tma_issue2P;tma_p=
orts_utilization_group",
         "MetricName": "tma_ports_utilized_2",
         "MetricThreshold": "tma_ports_utilized_2 > 0.15 & (tma_ports_utili=
zation > 0.15 & (tma_core_bound > 0.1 & tma_backend_bound > 0.2))",
@@ -1369,7 +1369,7 @@
     },
     {
         "BriefDescription": "This metric represents fraction of cycles CPU=
 executed total of 3 or more uops per cycle on all execution ports (Logical=
 Processor cycles since ICL, Physical Core cycles otherwise)",
-        "MetricExpr": "UOPS_EXECUTED.CYCLES_GE_3 / tma_info_clks",
+        "MetricExpr": "UOPS_EXECUTED.CYCLES_GE_3 / tma_info_thread_clks",
         "MetricGroup": "PortsUtil;TopdownL4;tma_L4_group;tma_ports_utiliza=
tion_group",
         "MetricName": "tma_ports_utilized_3m",
         "MetricThreshold": "tma_ports_utilized_3m > 0.7 & (tma_ports_utili=
zation > 0.15 & (tma_core_bound > 0.1 & tma_backend_bound > 0.2))",
@@ -1378,7 +1378,7 @@
     },
     {
         "BriefDescription": "This category represents fraction of slots ut=
ilized by useful work i.e. issued uops that eventually get retired",
-        "MetricExpr": "topdown\\-retiring / (topdown\\-fe\\-bound + topdow=
n\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) + 0 * tma_info_=
slots",
+        "MetricExpr": "topdown\\-retiring / (topdown\\-fe\\-bound + topdow=
n\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) + 0 * tma_info_=
thread_slots",
         "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
         "MetricName": "tma_retiring",
         "MetricThreshold": "tma_retiring > 0.7 | tma_heavy_operations > 0.=
1",
@@ -1388,7 +1388,7 @@
     },
     {
         "BriefDescription": "This metric represents fraction of cycles the=
 CPU issue-pipeline was stalled due to serializing operations",
-        "MetricExpr": "RESOURCE_STALLS.SCOREBOARD / tma_info_clks",
+        "MetricExpr": "RESOURCE_STALLS.SCOREBOARD / tma_info_thread_clks",
         "MetricGroup": "PortsUtil;TopdownL5;tma_L5_group;tma_issueSO;tma_p=
orts_utilized_0_group",
         "MetricName": "tma_serializing_operation",
         "MetricThreshold": "tma_serializing_operation > 0.1 & (tma_ports_u=
tilized_0 > 0.2 & (tma_ports_utilization > 0.15 & (tma_core_bound > 0.1 & t=
ma_backend_bound > 0.2)))",
@@ -1397,7 +1397,7 @@
     },
     {
         "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to PAUSE Instructions",
-        "MetricExpr": "140 * MISC_RETIRED.PAUSE_INST / tma_info_clks",
+        "MetricExpr": "140 * MISC_RETIRED.PAUSE_INST / tma_info_thread_clk=
s",
         "MetricGroup": "TopdownL6;tma_L6_group;tma_serializing_operation_g=
roup",
         "MetricName": "tma_slow_pause",
         "MetricThreshold": "tma_slow_pause > 0.05 & (tma_serializing_opera=
tion > 0.1 & (tma_ports_utilized_0 > 0.2 & (tma_ports_utilization > 0.15 & =
(tma_core_bound > 0.1 & tma_backend_bound > 0.2))))",
@@ -1406,7 +1406,7 @@
     },
     {
         "BriefDescription": "This metric estimates fraction of cycles hand=
ling memory load split accesses - load that cross 64-byte cache line bounda=
ry",
-        "MetricExpr": "tma_info_load_miss_real_latency * LD_BLOCKS.NO_SR /=
 tma_info_clks",
+        "MetricExpr": "tma_info_memory_load_miss_real_latency * LD_BLOCKS.=
NO_SR / tma_info_thread_clks",
         "MetricGroup": "TopdownL4;tma_L4_group;tma_l1_bound_group",
         "MetricName": "tma_split_loads",
         "MetricThreshold": "tma_split_loads > 0.2 & (tma_l1_bound > 0.1 & =
(tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
@@ -1415,7 +1415,7 @@
     },
     {
         "BriefDescription": "This metric represents rate of split store ac=
cesses",
-        "MetricExpr": "MEM_INST_RETIRED.SPLIT_STORES / tma_info_core_clks"=
,
+        "MetricExpr": "MEM_INST_RETIRED.SPLIT_STORES / tma_info_core_core_=
clks",
         "MetricGroup": "TopdownL4;tma_L4_group;tma_issueSpSt;tma_store_bou=
nd_group",
         "MetricName": "tma_split_stores",
         "MetricThreshold": "tma_split_stores > 0.2 & (tma_store_bound > 0.=
2 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
@@ -1424,16 +1424,16 @@
     },
     {
         "BriefDescription": "This metric measures fraction of cycles where=
 the Super Queue (SQ) was full taking into account all request-types and bo=
th hardware SMT threads (Logical Processors)",
-        "MetricExpr": "L1D_PEND_MISS.L2_STALL / tma_info_clks",
+        "MetricExpr": "L1D_PEND_MISS.L2_STALL / tma_info_thread_clks",
         "MetricGroup": "MemoryBW;Offcore;TopdownL4;tma_L4_group;tma_issueB=
W;tma_l3_bound_group",
         "MetricName": "tma_sq_full",
         "MetricThreshold": "tma_sq_full > 0.3 & (tma_l3_bound > 0.05 & (tm=
a_memory_bound > 0.2 & tma_backend_bound > 0.2))",
-        "PublicDescription": "This metric measures fraction of cycles wher=
e the Super Queue (SQ) was full taking into account all request-types and b=
oth hardware SMT threads (Logical Processors). Related metrics: tma_fb_full=
, tma_info_dram_bw_use, tma_info_memory_bandwidth, tma_mem_bandwidth",
+        "PublicDescription": "This metric measures fraction of cycles wher=
e the Super Queue (SQ) was full taking into account all request-types and b=
oth hardware SMT threads (Logical Processors). Related metrics: tma_fb_full=
, tma_info_bottleneck_memory_bandwidth, tma_info_system_dram_bw_use, tma_me=
m_bandwidth",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "This metric estimates how often CPU was stall=
ed  due to RFO store memory accesses; RFO store issue a read-for-ownership =
request before the write",
-        "MetricExpr": "EXE_ACTIVITY.BOUND_ON_STORES / tma_info_clks",
+        "MetricExpr": "EXE_ACTIVITY.BOUND_ON_STORES / tma_info_thread_clks=
",
         "MetricGroup": "MemoryBound;TmaL3mem;TopdownL3;tma_L3_group;tma_me=
mory_bound_group",
         "MetricName": "tma_store_bound",
         "MetricThreshold": "tma_store_bound > 0.2 & (tma_memory_bound > 0.=
2 & tma_backend_bound > 0.2)",
@@ -1442,7 +1442,7 @@
     },
     {
         "BriefDescription": "This metric roughly estimates fraction of cyc=
les when the memory subsystem had loads blocked since they could not forwar=
d data from earlier (in program order) overlapping stores",
-        "MetricExpr": "13 * LD_BLOCKS.STORE_FORWARD / tma_info_clks",
+        "MetricExpr": "13 * LD_BLOCKS.STORE_FORWARD / tma_info_thread_clks=
",
         "MetricGroup": "TopdownL4;tma_L4_group;tma_l1_bound_group",
         "MetricName": "tma_store_fwd_blk",
         "MetricThreshold": "tma_store_fwd_blk > 0.1 & (tma_l1_bound > 0.1 =
& (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
@@ -1451,7 +1451,7 @@
     },
     {
         "BriefDescription": "This metric estimates fraction of cycles the =
CPU spent handling L1D store misses",
-        "MetricExpr": "(L2_RQSTS.RFO_HIT * 10 * (1 - MEM_INST_RETIRED.LOCK=
_LOADS / MEM_INST_RETIRED.ALL_STORES) + (1 - MEM_INST_RETIRED.LOCK_LOADS / =
MEM_INST_RETIRED.ALL_STORES) * min(CPU_CLK_UNHALTED.THREAD, OFFCORE_REQUEST=
S_OUTSTANDING.CYCLES_WITH_DEMAND_RFO)) / tma_info_clks",
+        "MetricExpr": "(L2_RQSTS.RFO_HIT * 10 * (1 - MEM_INST_RETIRED.LOCK=
_LOADS / MEM_INST_RETIRED.ALL_STORES) + (1 - MEM_INST_RETIRED.LOCK_LOADS / =
MEM_INST_RETIRED.ALL_STORES) * min(CPU_CLK_UNHALTED.THREAD, OFFCORE_REQUEST=
S_OUTSTANDING.CYCLES_WITH_DEMAND_RFO)) / tma_info_thread_clks",
         "MetricGroup": "MemoryLat;Offcore;TopdownL4;tma_L4_group;tma_issue=
RFO;tma_issueSL;tma_store_bound_group",
         "MetricName": "tma_store_latency",
         "MetricThreshold": "tma_store_latency > 0.1 & (tma_store_bound > 0=
.2 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
@@ -1460,7 +1460,7 @@
     },
     {
         "BriefDescription": "This metric represents Core fraction of cycle=
s CPU dispatched uops on execution port for Store operations",
-        "MetricExpr": "(UOPS_DISPATCHED.PORT_4_9 + UOPS_DISPATCHED.PORT_7_=
8) / (4 * tma_info_core_clks)",
+        "MetricExpr": "(UOPS_DISPATCHED.PORT_4_9 + UOPS_DISPATCHED.PORT_7_=
8) / (4 * tma_info_core_core_clks)",
         "MetricGroup": "TopdownL5;tma_L5_group;tma_ports_utilized_3m_group=
",
         "MetricName": "tma_store_op_utilization",
         "MetricThreshold": "tma_store_op_utilization > 0.6",
@@ -1477,7 +1477,7 @@
     },
     {
         "BriefDescription": "This metric estimates the fraction of cycles =
where the STLB was missed by store accesses, performing a hardware page wal=
k",
-        "MetricExpr": "DTLB_STORE_MISSES.WALK_ACTIVE / tma_info_core_clks"=
,
+        "MetricExpr": "DTLB_STORE_MISSES.WALK_ACTIVE / tma_info_core_core_=
clks",
         "MetricGroup": "MemoryTLB;TopdownL5;tma_L5_group;tma_dtlb_store_gr=
oup",
         "MetricName": "tma_store_stlb_miss",
         "MetricThreshold": "tma_store_stlb_miss > 0.05 & (tma_dtlb_store >=
 0.05 & (tma_store_bound > 0.2 & (tma_memory_bound > 0.2 & tma_backend_boun=
d > 0.2)))",
@@ -1485,7 +1485,7 @@
     },
     {
         "BriefDescription": "This metric estimates how often CPU was stall=
ed  due to Streaming store memory accesses; Streaming store optimize out a =
read request required by RFO stores",
-        "MetricExpr": "9 * OCR.STREAMING_WR.ANY_RESPONSE / tma_info_clks",
+        "MetricExpr": "9 * OCR.STREAMING_WR.ANY_RESPONSE / tma_info_thread=
_clks",
         "MetricGroup": "MemoryBW;Offcore;TopdownL4;tma_L4_group;tma_issueS=
mSt;tma_store_bound_group",
         "MetricName": "tma_streaming_stores",
         "MetricThreshold": "tma_streaming_stores > 0.2 & (tma_store_bound =
> 0.2 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
@@ -1494,7 +1494,7 @@
     },
     {
         "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to new branch address clears",
-        "MetricExpr": "10 * BACLEARS.ANY / tma_info_clks",
+        "MetricExpr": "10 * BACLEARS.ANY / tma_info_thread_clks",
         "MetricGroup": "BigFoot;FetchLat;TopdownL4;tma_L4_group;tma_branch=
_resteers_group",
         "MetricName": "tma_unknown_branches",
         "MetricThreshold": "tma_unknown_branches > 0.05 & (tma_branch_rest=
eers > 0.05 & (tma_fetch_latency > 0.1 & tma_frontend_bound > 0.15))",
diff --git a/tools/perf/pmu-events/arch/x86/icelakex/icx-metrics.json b/too=
ls/perf/pmu-events/arch/x86/icelakex/icx-metrics.json
index b736fec164d0..ef25cda019be 100644
--- a/tools/perf/pmu-events/arch/x86/icelakex/icx-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/icelakex/icx-metrics.json
@@ -29,10 +29,243 @@
     },
     {
         "BriefDescription": "Uncore frequency per die [GHZ]",
-        "MetricExpr": "tma_info_socket_clks / #num_dies / duration_time / =
1e9",
+        "MetricExpr": "tma_info_system_socket_clks / #num_dies / duration_=
time / 1e9",
         "MetricGroup": "SoC",
         "MetricName": "UNCORE_FREQ"
     },
+    {
+        "BriefDescription": "Cycles per instruction retired; indicating ho=
w much time each executed instruction took; in units of cycles.",
+        "MetricExpr": "CPU_CLK_UNHALTED.THREAD / INST_RETIRED.ANY",
+        "MetricName": "cpi",
+        "ScaleUnit": "1per_instr"
+    },
+    {
+        "BriefDescription": "CPU operating frequency (in GHz)",
+        "MetricExpr": "CPU_CLK_UNHALTED.THREAD / CPU_CLK_UNHALTED.REF_TSC =
* #SYSTEM_TSC_FREQ / 1e9",
+        "MetricName": "cpu_operating_frequency",
+        "ScaleUnit": "1GHz"
+    },
+    {
+        "BriefDescription": "Percentage of time spent in the active CPU po=
wer state C0",
+        "MetricExpr": "tma_info_system_cpu_utilization",
+        "MetricName": "cpu_utilization",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "Ratio of number of completed page walks (for =
2 megabyte page sizes) caused by demand data loads to the total number of c=
ompleted instructions",
+        "MetricExpr": "DTLB_LOAD_MISSES.WALK_COMPLETED_2M_4M / INST_RETIRE=
D.ANY",
+        "MetricName": "dtlb_2nd_level_2mb_large_page_load_mpi",
+        "PublicDescription": "Ratio of number of completed page walks (for=
 2 megabyte page sizes) caused by demand data loads to the total number of =
completed instructions. This implies it missed in the Data Translation Look=
aside Buffer (DTLB) and further levels of TLB.",
+        "ScaleUnit": "1per_instr"
+    },
+    {
+        "BriefDescription": "Ratio of number of completed page walks (for =
all page sizes) caused by demand data loads to the total number of complete=
d instructions",
+        "MetricExpr": "DTLB_LOAD_MISSES.WALK_COMPLETED / INST_RETIRED.ANY"=
,
+        "MetricName": "dtlb_2nd_level_load_mpi",
+        "PublicDescription": "Ratio of number of completed page walks (for=
 all page sizes) caused by demand data loads to the total number of complet=
ed instructions. This implies it missed in the DTLB and further levels of T=
LB.",
+        "ScaleUnit": "1per_instr"
+    },
+    {
+        "BriefDescription": "Ratio of number of completed page walks (for =
all page sizes) caused by demand data stores to the total number of complet=
ed instructions",
+        "MetricExpr": "DTLB_STORE_MISSES.WALK_COMPLETED / INST_RETIRED.ANY=
",
+        "MetricName": "dtlb_2nd_level_store_mpi",
+        "PublicDescription": "Ratio of number of completed page walks (for=
 all page sizes) caused by demand data stores to the total number of comple=
ted instructions. This implies it missed in the DTLB and further levels of =
TLB.",
+        "ScaleUnit": "1per_instr"
+    },
+    {
+        "BriefDescription": "Bandwidth of IO writes that are initiated by =
end device controllers that are writing memory to the CPU.",
+        "MetricExpr": "(UNC_CHA_TOR_INSERTS.IO_HIT_ITOM + UNC_CHA_TOR_INSE=
RTS.IO_MISS_ITOM + UNC_CHA_TOR_INSERTS.IO_HIT_ITOMCACHENEAR + UNC_CHA_TOR_I=
NSERTS.IO_MISS_ITOMCACHENEAR) * 64 / 1e6 / duration_time",
+        "MetricName": "io_bandwidth_write",
+        "ScaleUnit": "1MB/s"
+    },
+    {
+        "BriefDescription": "Ratio of number of completed page walks (for =
2 megabyte and 4 megabyte page sizes) caused by a code fetch to the total n=
umber of completed instructions",
+        "MetricExpr": "ITLB_MISSES.WALK_COMPLETED_2M_4M / INST_RETIRED.ANY=
",
+        "MetricName": "itlb_2nd_level_large_page_mpi",
+        "PublicDescription": "Ratio of number of completed page walks (for=
 2 megabyte and 4 megabyte page sizes) caused by a code fetch to the total =
number of completed instructions. This implies it missed in the Instruction=
 Translation Lookaside Buffer (ITLB) and further levels of TLB.",
+        "ScaleUnit": "1per_instr"
+    },
+    {
+        "BriefDescription": "Ratio of number of completed page walks (for =
all page sizes) caused by a code fetch to the total number of completed ins=
tructions",
+        "MetricExpr": "ITLB_MISSES.WALK_COMPLETED / INST_RETIRED.ANY",
+        "MetricName": "itlb_2nd_level_mpi",
+        "PublicDescription": "Ratio of number of completed page walks (for=
 all page sizes) caused by a code fetch to the total number of completed in=
structions. This implies it missed in the ITLB (Instruction TLB) and furthe=
r levels of TLB.",
+        "ScaleUnit": "1per_instr"
+    },
+    {
+        "BriefDescription": "Ratio of number of code read requests missing=
 in L1 instruction cache (includes prefetches) to the total number of compl=
eted instructions",
+        "MetricExpr": "L2_RQSTS.ALL_CODE_RD / INST_RETIRED.ANY",
+        "MetricName": "l1_i_code_read_misses_with_prefetches_per_instr",
+        "ScaleUnit": "1per_instr"
+    },
+    {
+        "BriefDescription": "Ratio of number of demand load requests hitti=
ng in L1 data cache to the total number of completed instructions",
+        "MetricExpr": "MEM_LOAD_RETIRED.L1_HIT / INST_RETIRED.ANY",
+        "MetricName": "l1d_demand_data_read_hits_per_instr",
+        "ScaleUnit": "1per_instr"
+    },
+    {
+        "BriefDescription": "Ratio of number of requests missing L1 data c=
ache (includes data+rfo w/ prefetches) to the total number of completed ins=
tructions",
+        "MetricExpr": "L1D.REPLACEMENT / INST_RETIRED.ANY",
+        "MetricName": "l1d_mpi",
+        "ScaleUnit": "1per_instr"
+    },
+    {
+        "BriefDescription": "Ratio of number of code read request missing =
L2 cache to the total number of completed instructions",
+        "MetricExpr": "L2_RQSTS.CODE_RD_MISS / INST_RETIRED.ANY",
+        "MetricName": "l2_demand_code_mpi",
+        "ScaleUnit": "1per_instr"
+    },
+    {
+        "BriefDescription": "Ratio of number of completed demand load requ=
ests hitting in L2 cache to the total number of completed instructions",
+        "MetricExpr": "MEM_LOAD_RETIRED.L2_HIT / INST_RETIRED.ANY",
+        "MetricName": "l2_demand_data_read_hits_per_instr",
+        "ScaleUnit": "1per_instr"
+    },
+    {
+        "BriefDescription": "Ratio of number of completed data read reques=
t missing L2 cache to the total number of completed instructions",
+        "MetricExpr": "MEM_LOAD_RETIRED.L2_MISS / INST_RETIRED.ANY",
+        "MetricName": "l2_demand_data_read_mpi",
+        "ScaleUnit": "1per_instr"
+    },
+    {
+        "BriefDescription": "Ratio of number of requests missing L2 cache =
(includes code+data+rfo w/ prefetches) to the total number of completed ins=
tructions",
+        "MetricExpr": "L2_LINES_IN.ALL / INST_RETIRED.ANY",
+        "MetricName": "l2_mpi",
+        "ScaleUnit": "1per_instr"
+    },
+    {
+        "BriefDescription": "Ratio of number of code read requests missing=
 last level core cache (includes demand w/ prefetches) to the total number =
of completed instructions",
+        "MetricExpr": "(UNC_CHA_TOR_INSERTS.IA_MISS_CRD + UNC_CHA_TOR_INSE=
RTS.IA_MISS_CRD_PREF) / INST_RETIRED.ANY",
+        "MetricName": "llc_code_read_mpi_demand_plus_prefetch",
+        "ScaleUnit": "1per_instr"
+    },
+    {
+        "BriefDescription": "Average latency of a last level cache (LLC) d=
emand data read miss (read memory access) in nano seconds",
+        "MetricExpr": "1e9 * (UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD / UNC_CHA_=
TOR_INSERTS.IA_MISS_DRD) / (UNC_CHA_CLOCKTICKS / (source_count(UNC_CHA_TOR_=
OCCUPANCY.IA_MISS_DRD) * #num_packages)) * duration_time",
+        "MetricName": "llc_demand_data_read_miss_latency",
+        "ScaleUnit": "1ns"
+    },
+    {
+        "BriefDescription": "Average latency of a last level cache (LLC) d=
emand data read miss (read memory access) addressed to local memory in nano=
 seconds",
+        "MetricExpr": "1e9 * (UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_LOCAL / UN=
C_CHA_TOR_INSERTS.IA_MISS_DRD_LOCAL) / (UNC_CHA_CLOCKTICKS / (source_count(=
UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_LOCAL) * #num_packages)) * duration_time"=
,
+        "MetricName": "llc_demand_data_read_miss_latency_for_local_request=
s",
+        "ScaleUnit": "1ns"
+    },
+    {
+        "BriefDescription": "Average latency of a last level cache (LLC) d=
emand data read miss (read memory access) addressed to remote memory in nan=
o seconds",
+        "MetricExpr": "1e9 * (UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_REMOTE / U=
NC_CHA_TOR_INSERTS.IA_MISS_DRD_REMOTE) / (UNC_CHA_CLOCKTICKS / (source_coun=
t(UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_REMOTE) * #num_packages)) * duration_ti=
me",
+        "MetricName": "llc_demand_data_read_miss_latency_for_remote_reques=
ts",
+        "ScaleUnit": "1ns"
+    },
+    {
+        "BriefDescription": "Average latency of a last level cache (LLC) d=
emand data read miss (read memory access) addressed to Intel(R) Optane(TM) =
Persistent Memory(PMEM) in nano seconds",
+        "MetricExpr": "1e9 * (UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_PMM / UNC_=
CHA_TOR_INSERTS.IA_MISS_DRD_PMM) / (UNC_CHA_CLOCKTICKS / (source_count(UNC_=
CHA_TOR_OCCUPANCY.IA_MISS_DRD_PMM) * #num_packages)) * duration_time",
+        "MetricName": "llc_demand_data_read_miss_to_pmem_latency",
+        "ScaleUnit": "1ns"
+    },
+    {
+        "BriefDescription": "Bandwidth (MB/sec) of read requests that miss=
 the last level cache (LLC) and go to local memory.",
+        "MetricExpr": "UNC_CHA_REQUESTS.READS_LOCAL * 64 / 1e6 / duration_=
time",
+        "MetricName": "llc_miss_local_memory_bandwidth_read",
+        "ScaleUnit": "1MB/s"
+    },
+    {
+        "BriefDescription": "Bandwidth (MB/sec) of write requests that mis=
s the last level cache (LLC) and go to local memory.",
+        "MetricExpr": "UNC_CHA_REQUESTS.WRITES_LOCAL * 64 / 1e6 / duration=
_time",
+        "MetricName": "llc_miss_local_memory_bandwidth_write",
+        "ScaleUnit": "1MB/s"
+    },
+    {
+        "BriefDescription": "Bandwidth (MB/sec) of read requests that miss=
 the last level cache (LLC) and go to remote memory.",
+        "MetricExpr": "UNC_CHA_REQUESTS.READS_REMOTE * 64 / 1e6 / duration=
_time",
+        "MetricName": "llc_miss_remote_memory_bandwidth_read",
+        "ScaleUnit": "1MB/s"
+    },
+    {
+        "BriefDescription": "Bandwidth (MB/sec) of write requests that mis=
s the last level cache (LLC) and go to remote memory.",
+        "MetricExpr": "UNC_CHA_REQUESTS.WRITES_REMOTE * 64 / 1e6 / duratio=
n_time",
+        "MetricName": "llc_miss_remote_memory_bandwidth_write",
+        "ScaleUnit": "1MB/s"
+    },
+    {
+        "BriefDescription": "The ratio of number of completed memory load =
instructions to the total number completed instructions",
+        "MetricExpr": "MEM_INST_RETIRED.ALL_LOADS / INST_RETIRED.ANY",
+        "MetricName": "loads_per_instr",
+        "ScaleUnit": "1per_instr"
+    },
+    {
+        "BriefDescription": "DDR memory read bandwidth (MB/sec)",
+        "MetricExpr": "UNC_M_CAS_COUNT.RD * 64 / 1e6 / duration_time",
+        "MetricName": "memory_bandwidth_read",
+        "ScaleUnit": "1MB/s"
+    },
+    {
+        "BriefDescription": "DDR memory bandwidth (MB/sec)",
+        "MetricExpr": "(UNC_M_CAS_COUNT.RD + UNC_M_CAS_COUNT.WR) * 64 / 1e=
6 / duration_time",
+        "MetricName": "memory_bandwidth_total",
+        "ScaleUnit": "1MB/s"
+    },
+    {
+        "BriefDescription": "DDR memory write bandwidth (MB/sec)",
+        "MetricExpr": "UNC_M_CAS_COUNT.WR * 64 / 1e6 / duration_time",
+        "MetricName": "memory_bandwidth_write",
+        "ScaleUnit": "1MB/s"
+    },
+    {
+        "BriefDescription": "Memory write bandwidth (MB/sec) caused by dir=
ectory updates; includes DDR and Intel(R) Optane(TM) Persistent Memory(PMEM=
).",
+        "MetricExpr": "(UNC_CHA_DIR_UPDATE.HA + UNC_CHA_DIR_UPDATE.TOR + U=
NC_M2M_DIRECTORY_UPDATE.ANY) * 64 / 1e6 / duration_time",
+        "MetricName": "memory_extra_write_bw_due_to_directory_updates",
+        "ScaleUnit": "1MB/s"
+    },
+    {
+        "BriefDescription": "Memory read that miss the last level cache (L=
LC) addressed to local DRAM as a percentage of total memory read accesses, =
does not include LLC prefetches.",
+        "MetricExpr": "(UNC_CHA_TOR_INSERTS.IA_MISS_DRD_LOCAL + UNC_CHA_TO=
R_INSERTS.IA_MISS_DRD_PREF_LOCAL) / (UNC_CHA_TOR_INSERTS.IA_MISS_DRD_LOCAL =
+ UNC_CHA_TOR_INSERTS.IA_MISS_DRD_PREF_LOCAL + UNC_CHA_TOR_INSERTS.IA_MISS_=
DRD_REMOTE + UNC_CHA_TOR_INSERTS.IA_MISS_DRD_PREF_REMOTE)",
+        "MetricName": "numa_reads_addressed_to_local_dram",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "Memory reads that miss the last level cache (=
LLC) addressed to remote DRAM as a percentage of total memory read accesses=
, does not include LLC prefetches.",
+        "MetricExpr": "(UNC_CHA_TOR_INSERTS.IA_MISS_DRD_REMOTE + UNC_CHA_T=
OR_INSERTS.IA_MISS_DRD_PREF_REMOTE) / (UNC_CHA_TOR_INSERTS.IA_MISS_DRD_LOCA=
L + UNC_CHA_TOR_INSERTS.IA_MISS_DRD_PREF_LOCAL + UNC_CHA_TOR_INSERTS.IA_MIS=
S_DRD_REMOTE + UNC_CHA_TOR_INSERTS.IA_MISS_DRD_PREF_REMOTE)",
+        "MetricName": "numa_reads_addressed_to_remote_dram",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "Uops delivered from decoded instruction cache=
 (decoded stream buffer or DSB) as a percent of total uops delivered to Ins=
truction Decode Queue",
+        "MetricExpr": "IDQ.DSB_UOPS / (IDQ.DSB_UOPS + IDQ.MITE_UOPS + IDQ.=
MS_UOPS + LSD.UOPS)",
+        "MetricName": "percent_uops_delivered_from_decoded_icache",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "Uops delivered from legacy decode pipeline (M=
icro-instruction Translation Engine or MITE) as a percent of total uops del=
ivered to Instruction Decode Queue",
+        "MetricExpr": "IDQ.MITE_UOPS / (IDQ.DSB_UOPS + IDQ.MITE_UOPS + IDQ=
.MS_UOPS + LSD.UOPS)",
+        "MetricName": "percent_uops_delivered_from_legacy_decode_pipeline"=
,
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "Uops delivered from microcode sequencer (MS) =
as a percent of total uops delivered to Instruction Decode Queue",
+        "MetricExpr": "IDQ.MS_UOPS / (IDQ.DSB_UOPS + IDQ.MITE_UOPS + IDQ.M=
S_UOPS + LSD.UOPS)",
+        "MetricName": "percent_uops_delivered_from_microcode_sequencer",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "Intel(R) Optane(TM) Persistent Memory(PMEM) m=
emory read bandwidth (MB/sec)",
+        "MetricExpr": "UNC_M_PMM_RPQ_INSERTS * 64 / 1e6 / duration_time",
+        "MetricName": "pmem_memory_bandwidth_read",
+        "ScaleUnit": "1MB/s"
+    },
+    {
+        "BriefDescription": "Intel(R) Optane(TM) Persistent Memory(PMEM) m=
emory bandwidth (MB/sec)",
+        "MetricExpr": "(UNC_M_PMM_RPQ_INSERTS + UNC_M_PMM_WPQ_INSERTS) * 6=
4 / 1e6 / duration_time",
+        "MetricName": "pmem_memory_bandwidth_total",
+        "ScaleUnit": "1MB/s"
+    },
+    {
+        "BriefDescription": "Intel(R) Optane(TM) Persistent Memory(PMEM) m=
emory write bandwidth (MB/sec)",
+        "MetricExpr": "UNC_M_PMM_WPQ_INSERTS * 64 / 1e6 / duration_time",
+        "MetricName": "pmem_memory_bandwidth_write",
+        "ScaleUnit": "1MB/s"
+    },
     {
         "BriefDescription": "Percentage of cycles spent in System Manageme=
nt Interrupts.",
         "MetricExpr": "((msr@aperf@ - cycles) / msr@aperf@ if msr@smi@ > 0=
 else 0)",
@@ -48,9 +281,15 @@
         "MetricName": "smi_num",
         "ScaleUnit": "1SMI#"
     },
+    {
+        "BriefDescription": "The ratio of number of completed memory store=
 instructions to the total number completed instructions",
+        "MetricExpr": "MEM_INST_RETIRED.ALL_STORES / INST_RETIRED.ANY",
+        "MetricName": "stores_per_instr",
+        "ScaleUnit": "1per_instr"
+    },
     {
         "BriefDescription": "This metric estimates how often memory load a=
ccesses were aliased by preceding stores (in program order) with a 4K addre=
ss offset",
-        "MetricExpr": "LD_BLOCKS_PARTIAL.ADDRESS_ALIAS / tma_info_clks",
+        "MetricExpr": "LD_BLOCKS_PARTIAL.ADDRESS_ALIAS / tma_info_thread_c=
lks",
         "MetricGroup": "TopdownL4;tma_L4_group;tma_l1_bound_group",
         "MetricName": "tma_4k_aliasing",
         "MetricThreshold": "tma_4k_aliasing > 0.2 & (tma_l1_bound > 0.1 & =
(tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
@@ -59,7 +298,7 @@
     },
     {
         "BriefDescription": "This metric represents Core fraction of cycle=
s CPU dispatched uops on execution ports for ALU operations.",
-        "MetricExpr": "(UOPS_DISPATCHED.PORT_0 + UOPS_DISPATCHED.PORT_1 + =
UOPS_DISPATCHED.PORT_5 + UOPS_DISPATCHED.PORT_6) / (4 * tma_info_core_clks)=
",
+        "MetricExpr": "(UOPS_DISPATCHED.PORT_0 + UOPS_DISPATCHED.PORT_1 + =
UOPS_DISPATCHED.PORT_5 + UOPS_DISPATCHED.PORT_6) / (4 * tma_info_core_core_=
clks)",
         "MetricGroup": "TopdownL5;tma_L5_group;tma_ports_utilized_3m_group=
",
         "MetricName": "tma_alu_op_utilization",
         "MetricThreshold": "tma_alu_op_utilization > 0.6",
@@ -67,7 +306,7 @@
     },
     {
         "BriefDescription": "This metric estimates fraction of slots the C=
PU retired uops delivered by the Microcode_Sequencer as a result of Assists=
",
-        "MetricExpr": "100 * ASSISTS.ANY / tma_info_slots",
+        "MetricExpr": "100 * ASSISTS.ANY / tma_info_thread_slots",
         "MetricGroup": "TopdownL4;tma_L4_group;tma_microcode_sequencer_gro=
up",
         "MetricName": "tma_assists",
         "MetricThreshold": "tma_assists > 0.1 & (tma_microcode_sequencer >=
 0.05 & tma_heavy_operations > 0.1)",
@@ -76,7 +315,7 @@
     },
     {
         "BriefDescription": "This category represents fraction of slots wh=
ere no uops are being delivered due to a lack of required resources for acc=
epting new uops in the Backend",
-        "MetricExpr": "topdown\\-be\\-bound / (topdown\\-fe\\-bound + topd=
own\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) + 5 * cpu@INT=
_MISC.RECOVERY_CYCLES\\,cmask\\=3D1\\,edge@ / tma_info_slots",
+        "MetricExpr": "topdown\\-be\\-bound / (topdown\\-fe\\-bound + topd=
own\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) + 5 * cpu@INT=
_MISC.RECOVERY_CYCLES\\,cmask\\=3D1\\,edge@ / tma_info_thread_slots",
         "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
         "MetricName": "tma_backend_bound",
         "MetricThreshold": "tma_backend_bound > 0.2",
@@ -96,7 +335,7 @@
     },
     {
         "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring branch instructions.",
-        "MetricExpr": "tma_light_operations * BR_INST_RETIRED.ALL_BRANCHES=
 / (tma_retiring * tma_info_slots)",
+        "MetricExpr": "tma_light_operations * BR_INST_RETIRED.ALL_BRANCHES=
 / (tma_retiring * tma_info_thread_slots)",
         "MetricGroup": "Pipeline;TopdownL3;tma_L3_group;tma_light_operatio=
ns_group",
         "MetricName": "tma_branch_instructions",
         "MetricThreshold": "tma_branch_instructions > 0.1 & tma_light_oper=
ations > 0.6",
@@ -109,12 +348,12 @@
         "MetricName": "tma_branch_mispredicts",
         "MetricThreshold": "tma_branch_mispredicts > 0.1 & tma_bad_specula=
tion > 0.15",
         "MetricgroupNoGroup": "TopdownL2",
-        "PublicDescription": "This metric represents fraction of slots the=
 CPU has wasted due to Branch Misprediction.  These slots are either wasted=
 by uops fetched from an incorrectly speculated program path; or stalls whe=
n the out-of-order part of the machine needs to recover its state from a sp=
eculative path. Sample with: BR_MISP_RETIRED.ALL_BRANCHES. Related metrics:=
 tma_info_branch_misprediction_cost, tma_info_mispredictions, tma_mispredic=
ts_resteers",
+        "PublicDescription": "This metric represents fraction of slots the=
 CPU has wasted due to Branch Misprediction.  These slots are either wasted=
 by uops fetched from an incorrectly speculated program path; or stalls whe=
n the out-of-order part of the machine needs to recover its state from a sp=
eculative path. Sample with: BR_MISP_RETIRED.ALL_BRANCHES. Related metrics:=
 tma_info_bad_spec_branch_misprediction_cost, tma_info_bottleneck_mispredic=
tions, tma_mispredicts_resteers",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to Branch Resteers",
-        "MetricExpr": "INT_MISC.CLEAR_RESTEER_CYCLES / tma_info_clks + tma=
_unknown_branches",
+        "MetricExpr": "INT_MISC.CLEAR_RESTEER_CYCLES / tma_info_thread_clk=
s + tma_unknown_branches",
         "MetricGroup": "FetchLat;TopdownL3;tma_L3_group;tma_fetch_latency_=
group",
         "MetricName": "tma_branch_resteers",
         "MetricThreshold": "tma_branch_resteers > 0.05 & (tma_fetch_latenc=
y > 0.1 & tma_frontend_bound > 0.15)",
@@ -132,7 +371,7 @@
     },
     {
         "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to Branch Resteers as a result of Machine Clears",
-        "MetricExpr": "(1 - BR_MISP_RETIRED.ALL_BRANCHES / (BR_MISP_RETIRE=
D.ALL_BRANCHES + MACHINE_CLEARS.COUNT)) * INT_MISC.CLEAR_RESTEER_CYCLES / t=
ma_info_clks",
+        "MetricExpr": "(1 - BR_MISP_RETIRED.ALL_BRANCHES / (BR_MISP_RETIRE=
D.ALL_BRANCHES + MACHINE_CLEARS.COUNT)) * INT_MISC.CLEAR_RESTEER_CYCLES / t=
ma_info_thread_clks",
         "MetricGroup": "BadSpec;MachineClears;TopdownL4;tma_L4_group;tma_b=
ranch_resteers_group;tma_issueMC",
         "MetricName": "tma_clears_resteers",
         "MetricThreshold": "tma_clears_resteers > 0.05 & (tma_branch_reste=
ers > 0.05 & (tma_fetch_latency > 0.1 & tma_frontend_bound > 0.15))",
@@ -142,7 +381,7 @@
     {
         "BriefDescription": "This metric estimates fraction of cycles whil=
e the memory subsystem was handling synchronizations due to contested acces=
ses",
         "MetricConstraint": "NO_GROUP_EVENTS",
-        "MetricExpr": "(44 * tma_info_average_frequency * (MEM_LOAD_L3_HIT=
_RETIRED.XSNP_HITM * (OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HITM / (OCR.DEMAND_DA=
TA_RD.L3_HIT.SNOOP_HITM + OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HIT_WITH_FWD))) +=
 43.5 * tma_info_average_frequency * MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS) * (=
1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS / 2) / tma_info_clks=
",
+        "MetricExpr": "(44 * tma_info_system_average_frequency * (MEM_LOAD=
_L3_HIT_RETIRED.XSNP_HITM * (OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HITM / (OCR.DE=
MAND_DATA_RD.L3_HIT.SNOOP_HITM + OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HIT_WITH_F=
WD))) + 43.5 * tma_info_system_average_frequency * MEM_LOAD_L3_HIT_RETIRED.=
XSNP_MISS) * (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS / 2) /=
 tma_info_thread_clks",
         "MetricGroup": "DataSharing;Offcore;Snoop;TopdownL4;tma_L4_group;t=
ma_issueSyncxn;tma_l3_bound_group",
         "MetricName": "tma_contested_accesses",
         "MetricThreshold": "tma_contested_accesses > 0.05 & (tma_l3_bound =
> 0.05 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
@@ -162,7 +401,7 @@
     {
         "BriefDescription": "This metric estimates fraction of cycles whil=
e the memory subsystem was handling synchronizations due to data-sharing ac=
cesses",
         "MetricConstraint": "NO_GROUP_EVENTS",
-        "MetricExpr": "43.5 * tma_info_average_frequency * (MEM_LOAD_L3_HI=
T_RETIRED.XSNP_HIT + MEM_LOAD_L3_HIT_RETIRED.XSNP_HITM * (1 - OCR.DEMAND_DA=
TA_RD.L3_HIT.SNOOP_HITM / (OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HITM + OCR.DEMAN=
D_DATA_RD.L3_HIT.SNOOP_HIT_WITH_FWD))) * (1 + MEM_LOAD_RETIRED.FB_HIT / MEM=
_LOAD_RETIRED.L1_MISS / 2) / tma_info_clks",
+        "MetricExpr": "43.5 * tma_info_system_average_frequency * (MEM_LOA=
D_L3_HIT_RETIRED.XSNP_HIT + MEM_LOAD_L3_HIT_RETIRED.XSNP_HITM * (1 - OCR.DE=
MAND_DATA_RD.L3_HIT.SNOOP_HITM / (OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HITM + OC=
R.DEMAND_DATA_RD.L3_HIT.SNOOP_HIT_WITH_FWD))) * (1 + MEM_LOAD_RETIRED.FB_HI=
T / MEM_LOAD_RETIRED.L1_MISS / 2) / tma_info_thread_clks",
         "MetricGroup": "Offcore;Snoop;TopdownL4;tma_L4_group;tma_issueSync=
xn;tma_l3_bound_group",
         "MetricName": "tma_data_sharing",
         "MetricThreshold": "tma_data_sharing > 0.05 & (tma_l3_bound > 0.05=
 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
@@ -171,16 +410,16 @@
     },
     {
         "BriefDescription": "This metric represents fraction of cycles whe=
re decoder-0 was the only active decoder",
-        "MetricExpr": "(cpu@INST_DECODED.DECODERS\\,cmask\\=3D1@ - cpu@INS=
T_DECODED.DECODERS\\,cmask\\=3D2@) / tma_info_core_clks / 2",
+        "MetricExpr": "(cpu@INST_DECODED.DECODERS\\,cmask\\=3D1@ - cpu@INS=
T_DECODED.DECODERS\\,cmask\\=3D2@) / tma_info_core_core_clks / 2",
         "MetricGroup": "DSBmiss;FetchBW;TopdownL4;tma_L4_group;tma_issueD0=
;tma_mite_group",
         "MetricName": "tma_decoder0_alone",
-        "MetricThreshold": "tma_decoder0_alone > 0.1 & (tma_mite > 0.1 & (=
tma_fetch_bandwidth > 0.1 & tma_frontend_bound > 0.15 & tma_info_ipc / 5 > =
0.35))",
+        "MetricThreshold": "tma_decoder0_alone > 0.1 & (tma_mite > 0.1 & (=
tma_fetch_bandwidth > 0.1 & tma_frontend_bound > 0.15 & tma_info_thread_ipc=
 / 5 > 0.35))",
         "PublicDescription": "This metric represents fraction of cycles wh=
ere decoder-0 was the only active decoder. Related metrics: tma_few_uops_in=
structions",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "This metric represents fraction of cycles whe=
re the Divider unit was active",
-        "MetricExpr": "ARITH.DIVIDER_ACTIVE / tma_info_clks",
+        "MetricExpr": "ARITH.DIVIDER_ACTIVE / tma_info_thread_clks",
         "MetricGroup": "TopdownL3;tma_L3_group;tma_core_bound_group",
         "MetricName": "tma_divider",
         "MetricThreshold": "tma_divider > 0.2 & (tma_core_bound > 0.1 & tm=
a_backend_bound > 0.2)",
@@ -190,7 +429,7 @@
     {
         "BriefDescription": "This metric estimates how often the CPU was s=
talled on accesses to external memory (DRAM) by loads",
         "MetricConstraint": "NO_GROUP_EVENTS",
-        "MetricExpr": "(CYCLE_ACTIVITY.STALLS_L3_MISS / tma_info_clks + (C=
YCLE_ACTIVITY.STALLS_L1D_MISS - CYCLE_ACTIVITY.STALLS_L2_MISS) / tma_info_c=
lks - tma_l2_bound - tma_pmm_bound if #has_pmem > 0 else CYCLE_ACTIVITY.STA=
LLS_L3_MISS / tma_info_clks + (CYCLE_ACTIVITY.STALLS_L1D_MISS - CYCLE_ACTIV=
ITY.STALLS_L2_MISS) / tma_info_clks - tma_l2_bound)",
+        "MetricExpr": "(CYCLE_ACTIVITY.STALLS_L3_MISS / tma_info_thread_cl=
ks + (CYCLE_ACTIVITY.STALLS_L1D_MISS - CYCLE_ACTIVITY.STALLS_L2_MISS) / tma=
_info_thread_clks - tma_l2_bound - tma_pmm_bound if #has_pmem > 0 else CYCL=
E_ACTIVITY.STALLS_L3_MISS / tma_info_thread_clks + (CYCLE_ACTIVITY.STALLS_L=
1D_MISS - CYCLE_ACTIVITY.STALLS_L2_MISS) / tma_info_thread_clks - tma_l2_bo=
und)",
         "MetricGroup": "MemoryBound;TmaL3mem;TopdownL3;tma_L3_group;tma_me=
mory_bound_group",
         "MetricName": "tma_dram_bound",
         "MetricThreshold": "tma_dram_bound > 0.1 & (tma_memory_bound > 0.2=
 & tma_backend_bound > 0.2)",
@@ -199,43 +438,43 @@
     },
     {
         "BriefDescription": "This metric represents Core fraction of cycle=
s in which CPU was likely limited due to DSB (decoded uop cache) fetch pipe=
line",
-        "MetricExpr": "(IDQ.DSB_CYCLES_ANY - IDQ.DSB_CYCLES_OK) / tma_info=
_core_clks / 2",
+        "MetricExpr": "(IDQ.DSB_CYCLES_ANY - IDQ.DSB_CYCLES_OK) / tma_info=
_core_core_clks / 2",
         "MetricGroup": "DSB;FetchBW;TopdownL3;tma_L3_group;tma_fetch_bandw=
idth_group",
         "MetricName": "tma_dsb",
-        "MetricThreshold": "tma_dsb > 0.15 & (tma_fetch_bandwidth > 0.1 & =
tma_frontend_bound > 0.15 & tma_info_ipc / 5 > 0.35)",
+        "MetricThreshold": "tma_dsb > 0.15 & (tma_fetch_bandwidth > 0.1 & =
tma_frontend_bound > 0.15 & tma_info_thread_ipc / 5 > 0.35)",
         "PublicDescription": "This metric represents Core fraction of cycl=
es in which CPU was likely limited due to DSB (decoded uop cache) fetch pip=
eline.  For example; inefficient utilization of the DSB cache structure or =
bank conflict when reading from it; are categorized here.",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to switches from DSB to MITE pipelines",
-        "MetricExpr": "DSB2MITE_SWITCHES.PENALTY_CYCLES / tma_info_clks",
+        "MetricExpr": "DSB2MITE_SWITCHES.PENALTY_CYCLES / tma_info_thread_=
clks",
         "MetricGroup": "DSBmiss;FetchLat;TopdownL3;tma_L3_group;tma_fetch_=
latency_group;tma_issueFB",
         "MetricName": "tma_dsb_switches",
         "MetricThreshold": "tma_dsb_switches > 0.05 & (tma_fetch_latency >=
 0.1 & tma_frontend_bound > 0.15)",
-        "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to switches from DSB to MITE pipelines. The DSB (deco=
ded i-cache) is a Uop Cache where the front-end directly delivers Uops (mic=
ro operations) avoiding heavy x86 decoding. The DSB pipeline has shorter la=
tency and delivered higher bandwidth than the MITE (legacy instruction deco=
de pipeline). Switching between the two pipelines can cause penalties hence=
 this metric measures the exposed penalty. Sample with: FRONTEND_RETIRED.DS=
B_MISS_PS. Related metrics: tma_fetch_bandwidth, tma_info_dsb_coverage, tma=
_info_dsb_misses, tma_info_iptb, tma_lcp",
+        "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to switches from DSB to MITE pipelines. The DSB (deco=
ded i-cache) is a Uop Cache where the front-end directly delivers Uops (mic=
ro operations) avoiding heavy x86 decoding. The DSB pipeline has shorter la=
tency and delivered higher bandwidth than the MITE (legacy instruction deco=
de pipeline). Switching between the two pipelines can cause penalties hence=
 this metric measures the exposed penalty. Sample with: FRONTEND_RETIRED.DS=
B_MISS_PS. Related metrics: tma_fetch_bandwidth, tma_info_botlnk_l2_dsb_mis=
ses, tma_info_frontend_dsb_coverage, tma_info_inst_mix_iptb, tma_lcp",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "This metric roughly estimates the fraction of=
 cycles where the Data TLB (DTLB) was missed by load accesses",
-        "MetricExpr": "min(7 * cpu@DTLB_LOAD_MISSES.STLB_HIT\\,cmask\\=3D1=
@ + DTLB_LOAD_MISSES.WALK_ACTIVE, max(CYCLE_ACTIVITY.CYCLES_MEM_ANY - CYCLE=
_ACTIVITY.CYCLES_L1D_MISS, 0)) / tma_info_clks",
+        "MetricExpr": "min(7 * cpu@DTLB_LOAD_MISSES.STLB_HIT\\,cmask\\=3D1=
@ + DTLB_LOAD_MISSES.WALK_ACTIVE, max(CYCLE_ACTIVITY.CYCLES_MEM_ANY - CYCLE=
_ACTIVITY.CYCLES_L1D_MISS, 0)) / tma_info_thread_clks",
         "MetricGroup": "MemoryTLB;TopdownL4;tma_L4_group;tma_issueTLB;tma_=
l1_bound_group",
         "MetricName": "tma_dtlb_load",
         "MetricThreshold": "tma_dtlb_load > 0.1 & (tma_l1_bound > 0.1 & (t=
ma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
-        "PublicDescription": "This metric roughly estimates the fraction o=
f cycles where the Data TLB (DTLB) was missed by load accesses. TLBs (Trans=
lation Look-aside Buffers) are processor caches for recently used entries o=
ut of the Page Tables that are used to map virtual- to physical-addresses b=
y the operating system. This metric approximates the potential delay of dem=
and loads missing the first-level data TLB (assuming worst case scenario wi=
th back to back misses to different pages). This includes hitting in the se=
cond-level TLB (STLB) as well as performing a hardware page walk on an STLB=
 miss. Sample with: MEM_INST_RETIRED.STLB_MISS_LOADS_PS. Related metrics: t=
ma_dtlb_store, tma_info_memory_data_tlbs",
+        "PublicDescription": "This metric roughly estimates the fraction o=
f cycles where the Data TLB (DTLB) was missed by load accesses. TLBs (Trans=
lation Look-aside Buffers) are processor caches for recently used entries o=
ut of the Page Tables that are used to map virtual- to physical-addresses b=
y the operating system. This metric approximates the potential delay of dem=
and loads missing the first-level data TLB (assuming worst case scenario wi=
th back to back misses to different pages). This includes hitting in the se=
cond-level TLB (STLB) as well as performing a hardware page walk on an STLB=
 miss. Sample with: MEM_INST_RETIRED.STLB_MISS_LOADS_PS. Related metrics: t=
ma_dtlb_store, tma_info_bottleneck_memory_data_tlbs",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "This metric roughly estimates the fraction of=
 cycles spent handling first-level data TLB store misses",
-        "MetricExpr": "(7 * cpu@DTLB_STORE_MISSES.STLB_HIT\\,cmask\\=3D1@ =
+ DTLB_STORE_MISSES.WALK_ACTIVE) / tma_info_core_clks",
+        "MetricExpr": "(7 * cpu@DTLB_STORE_MISSES.STLB_HIT\\,cmask\\=3D1@ =
+ DTLB_STORE_MISSES.WALK_ACTIVE) / tma_info_core_core_clks",
         "MetricGroup": "MemoryTLB;TopdownL4;tma_L4_group;tma_issueTLB;tma_=
store_bound_group",
         "MetricName": "tma_dtlb_store",
         "MetricThreshold": "tma_dtlb_store > 0.05 & (tma_store_bound > 0.2=
 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
-        "PublicDescription": "This metric roughly estimates the fraction o=
f cycles spent handling first-level data TLB store misses.  As with ordinar=
y data caching; focus on improving data locality and reducing working-set s=
ize to reduce DTLB overhead.  Additionally; consider using profile-guided o=
ptimization (PGO) to collocate frequently-used data on the same page.  Try =
using larger page sizes for large amounts of frequently-used data. Sample w=
ith: MEM_INST_RETIRED.STLB_MISS_STORES_PS. Related metrics: tma_dtlb_load, =
tma_info_memory_data_tlbs",
+        "PublicDescription": "This metric roughly estimates the fraction o=
f cycles spent handling first-level data TLB store misses.  As with ordinar=
y data caching; focus on improving data locality and reducing working-set s=
ize to reduce DTLB overhead.  Additionally; consider using profile-guided o=
ptimization (PGO) to collocate frequently-used data on the same page.  Try =
using larger page sizes for large amounts of frequently-used data. Sample w=
ith: MEM_INST_RETIRED.STLB_MISS_STORES_PS. Related metrics: tma_dtlb_load, =
tma_info_bottleneck_memory_data_tlbs",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "This metric roughly estimates how often CPU w=
as handling synchronizations due to False Sharing",
-        "MetricExpr": "48 * tma_info_average_frequency * OCR.DEMAND_RFO.L3=
_HIT.SNOOP_HITM / tma_info_clks",
+        "MetricExpr": "48 * tma_info_system_average_frequency * OCR.DEMAND=
_RFO.L3_HIT.SNOOP_HITM / tma_info_thread_clks",
         "MetricGroup": "DataSharing;Offcore;Snoop;TopdownL4;tma_L4_group;t=
ma_issueSyncxn;tma_store_bound_group",
         "MetricName": "tma_false_sharing",
         "MetricThreshold": "tma_false_sharing > 0.05 & (tma_store_bound > =
0.2 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
@@ -244,11 +483,11 @@
     },
     {
         "BriefDescription": "This metric does a *rough estimation* of how =
often L1D Fill Buffer unavailability limited additional L1D miss memory acc=
ess requests to proceed",
-        "MetricExpr": "L1D_PEND_MISS.FB_FULL / tma_info_clks",
+        "MetricExpr": "L1D_PEND_MISS.FB_FULL / tma_info_thread_clks",
         "MetricGroup": "MemoryBW;TopdownL4;tma_L4_group;tma_issueBW;tma_is=
sueSL;tma_issueSmSt;tma_l1_bound_group",
         "MetricName": "tma_fb_full",
         "MetricThreshold": "tma_fb_full > 0.3",
-        "PublicDescription": "This metric does a *rough estimation* of how=
 often L1D Fill Buffer unavailability limited additional L1D miss memory ac=
cess requests to proceed. The higher the metric value; the deeper the memor=
y hierarchy level the misses are satisfied from (metric values >1 are valid=
). Often it hints on approaching bandwidth limits (to L2 cache; L3 cache or=
 external memory). Related metrics: tma_info_dram_bw_use, tma_info_memory_b=
andwidth, tma_mem_bandwidth, tma_sq_full, tma_store_latency, tma_streaming_=
stores",
+        "PublicDescription": "This metric does a *rough estimation* of how=
 often L1D Fill Buffer unavailability limited additional L1D miss memory ac=
cess requests to proceed. The higher the metric value; the deeper the memor=
y hierarchy level the misses are satisfied from (metric values >1 are valid=
). Often it hints on approaching bandwidth limits (to L2 cache; L3 cache or=
 external memory). Related metrics: tma_info_bottleneck_memory_bandwidth, t=
ma_info_system_dram_bw_use, tma_mem_bandwidth, tma_sq_full, tma_store_laten=
cy, tma_streaming_stores",
         "ScaleUnit": "100%"
     },
     {
@@ -256,14 +495,14 @@
         "MetricExpr": "max(0, tma_frontend_bound - tma_fetch_latency)",
         "MetricGroup": "FetchBW;Frontend;TmaL2;TopdownL2;tma_L2_group;tma_=
frontend_bound_group;tma_issueFB",
         "MetricName": "tma_fetch_bandwidth",
-        "MetricThreshold": "tma_fetch_bandwidth > 0.1 & tma_frontend_bound=
 > 0.15 & tma_info_ipc / 5 > 0.35",
+        "MetricThreshold": "tma_fetch_bandwidth > 0.1 & tma_frontend_bound=
 > 0.15 & tma_info_thread_ipc / 5 > 0.35",
         "MetricgroupNoGroup": "TopdownL2",
-        "PublicDescription": "This metric represents fraction of slots the=
 CPU was stalled due to Frontend bandwidth issues.  For example; inefficien=
cies at the instruction decoders; or restrictions for caching in the DSB (d=
ecoded uops cache) are categorized under Fetch Bandwidth. In such cases; th=
e Frontend typically delivers suboptimal amount of uops to the Backend. Sam=
ple with: FRONTEND_RETIRED.LATENCY_GE_2_BUBBLES_GE_1_PS;FRONTEND_RETIRED.LA=
TENCY_GE_1_PS;FRONTEND_RETIRED.LATENCY_GE_2_PS. Related metrics: tma_dsb_sw=
itches, tma_info_dsb_coverage, tma_info_dsb_misses, tma_info_iptb, tma_lcp"=
,
+        "PublicDescription": "This metric represents fraction of slots the=
 CPU was stalled due to Frontend bandwidth issues.  For example; inefficien=
cies at the instruction decoders; or restrictions for caching in the DSB (d=
ecoded uops cache) are categorized under Fetch Bandwidth. In such cases; th=
e Frontend typically delivers suboptimal amount of uops to the Backend. Sam=
ple with: FRONTEND_RETIRED.LATENCY_GE_2_BUBBLES_GE_1_PS;FRONTEND_RETIRED.LA=
TENCY_GE_1_PS;FRONTEND_RETIRED.LATENCY_GE_2_PS. Related metrics: tma_dsb_sw=
itches, tma_info_botlnk_l2_dsb_misses, tma_info_frontend_dsb_coverage, tma_=
info_inst_mix_iptb, tma_lcp",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "This metric represents fraction of slots the =
CPU was stalled due to Frontend latency issues",
-        "MetricExpr": "(5 * IDQ_UOPS_NOT_DELIVERED.CYCLES_0_UOPS_DELIV.COR=
E - INT_MISC.UOP_DROPPING) / tma_info_slots",
+        "MetricExpr": "(5 * IDQ_UOPS_NOT_DELIVERED.CYCLES_0_UOPS_DELIV.COR=
E - INT_MISC.UOP_DROPPING) / tma_info_thread_slots",
         "MetricGroup": "Frontend;TmaL2;TopdownL2;tma_L2_group;tma_frontend=
_bound_group",
         "MetricName": "tma_fetch_latency",
         "MetricThreshold": "tma_fetch_latency > 0.1 & tma_frontend_bound >=
 0.15",
@@ -292,7 +531,7 @@
     },
     {
         "BriefDescription": "This metric approximates arithmetic floating-=
point (FP) scalar uops fraction the CPU has retired",
-        "MetricExpr": "cpu@FP_ARITH_INST_RETIRED.SCALAR_SINGLE\\,umask\\=
=3D0x03@ / (tma_retiring * tma_info_slots)",
+        "MetricExpr": "cpu@FP_ARITH_INST_RETIRED.SCALAR_SINGLE\\,umask\\=
=3D0x03@ / (tma_retiring * tma_info_thread_slots)",
         "MetricGroup": "Compute;Flops;TopdownL4;tma_L4_group;tma_fp_arith_=
group;tma_issue2P",
         "MetricName": "tma_fp_scalar",
         "MetricThreshold": "tma_fp_scalar > 0.1 & (tma_fp_arith > 0.2 & tm=
a_light_operations > 0.6)",
@@ -301,7 +540,7 @@
     },
     {
         "BriefDescription": "This metric approximates arithmetic floating-=
point (FP) vector uops fraction the CPU has retired aggregated across all v=
ector widths",
-        "MetricExpr": "cpu@FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE\\,umas=
k\\=3D0xfc@ / (tma_retiring * tma_info_slots)",
+        "MetricExpr": "cpu@FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE\\,umas=
k\\=3D0xfc@ / (tma_retiring * tma_info_thread_slots)",
         "MetricGroup": "Compute;Flops;TopdownL4;tma_L4_group;tma_fp_arith_=
group;tma_issue2P",
         "MetricName": "tma_fp_vector",
         "MetricThreshold": "tma_fp_vector > 0.1 & (tma_fp_arith > 0.2 & tm=
a_light_operations > 0.6)",
@@ -310,7 +549,7 @@
     },
     {
         "BriefDescription": "This metric approximates arithmetic FP vector=
 uops fraction the CPU has retired for 128-bit wide vectors",
-        "MetricExpr": "(FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + FP_ARIT=
H_INST_RETIRED.128B_PACKED_SINGLE) / (tma_retiring * tma_info_slots)",
+        "MetricExpr": "(FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + FP_ARIT=
H_INST_RETIRED.128B_PACKED_SINGLE) / (tma_retiring * tma_info_thread_slots)=
",
         "MetricGroup": "Compute;Flops;TopdownL5;tma_L5_group;tma_fp_vector=
_group;tma_issue2P",
         "MetricName": "tma_fp_vector_128b",
         "MetricThreshold": "tma_fp_vector_128b > 0.1 & (tma_fp_vector > 0.=
1 & (tma_fp_arith > 0.2 & tma_light_operations > 0.6))",
@@ -319,7 +558,7 @@
     },
     {
         "BriefDescription": "This metric approximates arithmetic FP vector=
 uops fraction the CPU has retired for 256-bit wide vectors",
-        "MetricExpr": "(FP_ARITH_INST_RETIRED.256B_PACKED_DOUBLE + FP_ARIT=
H_INST_RETIRED.256B_PACKED_SINGLE) / (tma_retiring * tma_info_slots)",
+        "MetricExpr": "(FP_ARITH_INST_RETIRED.256B_PACKED_DOUBLE + FP_ARIT=
H_INST_RETIRED.256B_PACKED_SINGLE) / (tma_retiring * tma_info_thread_slots)=
",
         "MetricGroup": "Compute;Flops;TopdownL5;tma_L5_group;tma_fp_vector=
_group;tma_issue2P",
         "MetricName": "tma_fp_vector_256b",
         "MetricThreshold": "tma_fp_vector_256b > 0.1 & (tma_fp_vector > 0.=
1 & (tma_fp_arith > 0.2 & tma_light_operations > 0.6))",
@@ -328,7 +567,7 @@
     },
     {
         "BriefDescription": "This metric approximates arithmetic FP vector=
 uops fraction the CPU has retired for 512-bit wide vectors",
-        "MetricExpr": "(FP_ARITH_INST_RETIRED.512B_PACKED_DOUBLE + FP_ARIT=
H_INST_RETIRED.512B_PACKED_SINGLE) / (tma_retiring * tma_info_slots)",
+        "MetricExpr": "(FP_ARITH_INST_RETIRED.512B_PACKED_DOUBLE + FP_ARIT=
H_INST_RETIRED.512B_PACKED_SINGLE) / (tma_retiring * tma_info_thread_slots)=
",
         "MetricGroup": "Compute;Flops;TopdownL5;tma_L5_group;tma_fp_vector=
_group;tma_issue2P",
         "MetricName": "tma_fp_vector_512b",
         "MetricThreshold": "tma_fp_vector_512b > 0.1 & (tma_fp_vector > 0.=
1 & (tma_fp_arith > 0.2 & tma_light_operations > 0.6))",
@@ -337,7 +576,7 @@
     },
     {
         "BriefDescription": "This category represents fraction of slots wh=
ere the processor's Frontend undersupplies its Backend",
-        "MetricExpr": "topdown\\-fe\\-bound / (topdown\\-fe\\-bound + topd=
own\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) - INT_MISC.UO=
P_DROPPING / tma_info_slots",
+        "MetricExpr": "topdown\\-fe\\-bound / (topdown\\-fe\\-bound + topd=
own\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) - INT_MISC.UO=
P_DROPPING / tma_info_thread_slots",
         "MetricGroup": "PGO;TmaL1;TopdownL1;tma_L1_group",
         "MetricName": "tma_frontend_bound",
         "MetricThreshold": "tma_frontend_bound > 0.15",
@@ -357,7 +596,7 @@
     },
     {
         "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to instruction cache misses",
-        "MetricExpr": "ICACHE_16B.IFDATA_STALL / tma_info_clks",
+        "MetricExpr": "ICACHE_16B.IFDATA_STALL / tma_info_thread_clks",
         "MetricGroup": "BigFoot;FetchLat;IcMiss;TopdownL3;tma_L3_group;tma=
_fetch_latency_group",
         "MetricName": "tma_icache_misses",
         "MetricThreshold": "tma_icache_misses > 0.05 & (tma_fetch_latency =
> 0.1 & tma_frontend_bound > 0.15)",
@@ -365,734 +604,741 @@
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Measured Average Frequency for unhalted proce=
ssors [GHz]",
-        "MetricExpr": "tma_info_turbo_utilization * TSC / 1e9 / duration_t=
ime",
-        "MetricGroup": "Power;Summary",
-        "MetricName": "tma_info_average_frequency"
+        "BriefDescription": "Branch Misprediction Cost: Fraction of TMA sl=
ots wasted per non-speculative branch misprediction (retired JEClear)",
+        "MetricConstraint": "NO_GROUP_EVENTS",
+        "MetricExpr": "(tma_branch_mispredicts + tma_fetch_latency * tma_m=
ispredicts_resteers / (tma_branch_resteers + tma_dsb_switches + tma_icache_=
misses + tma_itlb_misses + tma_lcp + tma_ms_switches)) * tma_info_thread_sl=
ots / BR_MISP_RETIRED.ALL_BRANCHES",
+        "MetricGroup": "Bad;BrMispredicts;tma_issueBM",
+        "MetricName": "tma_info_bad_spec_branch_misprediction_cost",
+        "PublicDescription": "Branch Misprediction Cost: Fraction of TMA s=
lots wasted per non-speculative branch misprediction (retired JEClear). Rel=
ated metrics: tma_branch_mispredicts, tma_info_bottleneck_mispredictions, t=
ma_mispredicts_resteers"
+    },
+    {
+        "BriefDescription": "Instructions per retired mispredicts for cond=
itional non-taken branches (lower number means higher occurrence rate).",
+        "MetricExpr": "INST_RETIRED.ANY / BR_MISP_RETIRED.COND_NTAKEN",
+        "MetricGroup": "Bad;BrMispredicts",
+        "MetricName": "tma_info_bad_spec_ipmisp_cond_ntaken",
+        "MetricThreshold": "tma_info_bad_spec_ipmisp_cond_ntaken < 200"
+    },
+    {
+        "BriefDescription": "Instructions per retired mispredicts for cond=
itional taken branches (lower number means higher occurrence rate).",
+        "MetricExpr": "INST_RETIRED.ANY / BR_MISP_RETIRED.COND_TAKEN",
+        "MetricGroup": "Bad;BrMispredicts",
+        "MetricName": "tma_info_bad_spec_ipmisp_cond_taken",
+        "MetricThreshold": "tma_info_bad_spec_ipmisp_cond_taken < 200"
+    },
+    {
+        "BriefDescription": "Instructions per retired mispredicts for indi=
rect CALL or JMP branches (lower number means higher occurrence rate).",
+        "MetricExpr": "INST_RETIRED.ANY / BR_MISP_RETIRED.INDIRECT",
+        "MetricGroup": "Bad;BrMispredicts",
+        "MetricName": "tma_info_bad_spec_ipmisp_indirect",
+        "MetricThreshold": "tma_info_bad_spec_ipmisp_indirect < 1e3"
+    },
+    {
+        "BriefDescription": "Instructions per retired mispredicts for retu=
rn branches (lower number means higher occurrence rate).",
+        "MetricExpr": "INST_RETIRED.ANY / BR_MISP_RETIRED.RET",
+        "MetricGroup": "Bad;BrMispredicts",
+        "MetricName": "tma_info_bad_spec_ipmisp_ret",
+        "MetricThreshold": "tma_info_bad_spec_ipmisp_ret < 500"
+    },
+    {
+        "BriefDescription": "Number of Instructions per non-speculative Br=
anch Misprediction (JEClear) (lower number means higher occurrence rate)",
+        "MetricExpr": "tma_info_core_ipmispredict",
+        "MetricGroup": "Bad;BadSpec;BrMispredicts",
+        "MetricName": "tma_info_bad_spec_ipmispredict",
+        "MetricThreshold": "tma_info_bad_spec_ipmispredict < 200"
+    },
+    {
+        "BriefDescription": "Probability of Core Bound bottleneck hidden b=
y SMT-profiling artifacts",
+        "MetricConstraint": "NO_GROUP_EVENTS",
+        "MetricExpr": "(100 * (1 - tma_core_bound / tma_ports_utilization =
if tma_core_bound < tma_ports_utilization else 1) if tma_info_system_smt_2t=
_utilization > 0.5 else 0)",
+        "MetricGroup": "Cor;SMT",
+        "MetricName": "tma_info_botlnk_l0_core_bound_likely",
+        "MetricThreshold": "tma_info_botlnk_l0_core_bound_likely > 0.5"
+    },
+    {
+        "BriefDescription": "Total pipeline cost of DSB (uop cache) misses=
 - subset of the Instruction_Fetch_BW Bottleneck",
+        "MetricConstraint": "NO_GROUP_EVENTS",
+        "MetricExpr": "100 * (tma_fetch_latency * tma_dsb_switches / (tma_=
branch_resteers + tma_dsb_switches + tma_icache_misses + tma_itlb_misses + =
tma_lcp + tma_ms_switches) + tma_fetch_bandwidth * tma_mite / (tma_dsb + tm=
a_mite))",
+        "MetricGroup": "DSBmiss;Fed;tma_issueFB",
+        "MetricName": "tma_info_botlnk_l2_dsb_misses",
+        "MetricThreshold": "tma_info_botlnk_l2_dsb_misses > 10",
+        "PublicDescription": "Total pipeline cost of DSB (uop cache) misse=
s - subset of the Instruction_Fetch_BW Bottleneck. Related metrics: tma_dsb=
_switches, tma_fetch_bandwidth, tma_info_frontend_dsb_coverage, tma_info_in=
st_mix_iptb, tma_lcp"
+    },
+    {
+        "BriefDescription": "Total pipeline cost of Instruction Cache miss=
es - subset of the Big_Code Bottleneck",
+        "MetricExpr": "100 * (tma_fetch_latency * tma_icache_misses / (tma=
_branch_resteers + tma_dsb_switches + tma_icache_misses + tma_itlb_misses +=
 tma_lcp + tma_ms_switches))",
+        "MetricGroup": "Fed;FetchLat;IcMiss;tma_issueFL",
+        "MetricName": "tma_info_botlnk_l2_ic_misses",
+        "MetricThreshold": "tma_info_botlnk_l2_ic_misses > 5",
+        "PublicDescription": "Total pipeline cost of Instruction Cache mis=
ses - subset of the Big_Code Bottleneck. Related metrics: "
     },
     {
         "BriefDescription": "Total pipeline cost of instruction fetch rela=
ted bottlenecks by large code footprint programs (i-side cache; TLB and BTB=
 misses)",
         "MetricConstraint": "NO_GROUP_EVENTS",
         "MetricExpr": "100 * tma_fetch_latency * (tma_itlb_misses + tma_ic=
ache_misses + tma_unknown_branches) / (tma_branch_resteers + tma_dsb_switch=
es + tma_icache_misses + tma_itlb_misses + tma_lcp + tma_ms_switches)",
         "MetricGroup": "BigFoot;Fed;Frontend;IcMiss;MemoryTLB;tma_issueBC"=
,
-        "MetricName": "tma_info_big_code",
-        "MetricThreshold": "tma_info_big_code > 20",
-        "PublicDescription": "Total pipeline cost of instruction fetch rel=
ated bottlenecks by large code footprint programs (i-side cache; TLB and BT=
B misses). Related metrics: tma_info_branching_overhead"
+        "MetricName": "tma_info_bottleneck_big_code",
+        "MetricThreshold": "tma_info_bottleneck_big_code > 20",
+        "PublicDescription": "Total pipeline cost of instruction fetch rel=
ated bottlenecks by large code footprint programs (i-side cache; TLB and BT=
B misses). Related metrics: tma_info_bottleneck_branching_overhead"
     },
     {
-        "BriefDescription": "Branch instructions per taken branch.",
-        "MetricExpr": "BR_INST_RETIRED.ALL_BRANCHES / BR_INST_RETIRED.NEAR=
_TAKEN",
-        "MetricGroup": "Branches;Fed;PGO",
-        "MetricName": "tma_info_bptkbranch"
+        "BriefDescription": "Total pipeline cost of branch related instruc=
tions (used for program control-flow including function calls)",
+        "MetricExpr": "100 * ((BR_INST_RETIRED.COND + 3 * BR_INST_RETIRED.=
NEAR_CALL + (BR_INST_RETIRED.NEAR_TAKEN - BR_INST_RETIRED.COND_TAKEN - 2 * =
BR_INST_RETIRED.NEAR_CALL)) / tma_info_thread_slots)",
+        "MetricGroup": "Ret;tma_issueBC",
+        "MetricName": "tma_info_bottleneck_branching_overhead",
+        "MetricThreshold": "tma_info_bottleneck_branching_overhead > 10",
+        "PublicDescription": "Total pipeline cost of branch related instru=
ctions (used for program control-flow including function calls). Related me=
trics: tma_info_bottleneck_big_code"
     },
     {
-        "BriefDescription": "Branch Misprediction Cost: Fraction of TMA sl=
ots wasted per non-speculative branch misprediction (retired JEClear)",
+        "BriefDescription": "Total pipeline cost of instruction fetch band=
width related bottlenecks",
         "MetricConstraint": "NO_GROUP_EVENTS",
-        "MetricExpr": "(tma_branch_mispredicts + tma_fetch_latency * tma_m=
ispredicts_resteers / (tma_branch_resteers + tma_dsb_switches + tma_icache_=
misses + tma_itlb_misses + tma_lcp + tma_ms_switches)) * tma_info_slots / B=
R_MISP_RETIRED.ALL_BRANCHES",
-        "MetricGroup": "Bad;BrMispredicts;tma_issueBM",
-        "MetricName": "tma_info_branch_misprediction_cost",
-        "PublicDescription": "Branch Misprediction Cost: Fraction of TMA s=
lots wasted per non-speculative branch misprediction (retired JEClear). Rel=
ated metrics: tma_branch_mispredicts, tma_info_mispredictions, tma_mispredi=
cts_resteers"
+        "MetricExpr": "100 * (tma_frontend_bound - tma_fetch_latency * tma=
_mispredicts_resteers / (tma_branch_resteers + tma_dsb_switches + tma_icach=
e_misses + tma_itlb_misses + tma_lcp + tma_ms_switches)) - tma_info_bottlen=
eck_big_code",
+        "MetricGroup": "Fed;FetchBW;Frontend",
+        "MetricName": "tma_info_bottleneck_instruction_fetch_bw",
+        "MetricThreshold": "tma_info_bottleneck_instruction_fetch_bw > 20"
     },
     {
-        "BriefDescription": "Total pipeline cost of branch related instruc=
tions (used for program control-flow including function calls)",
-        "MetricExpr": "100 * ((BR_INST_RETIRED.COND + 3 * BR_INST_RETIRED.=
NEAR_CALL + (BR_INST_RETIRED.NEAR_TAKEN - BR_INST_RETIRED.COND_TAKEN - 2 * =
BR_INST_RETIRED.NEAR_CALL)) / tma_info_slots)",
-        "MetricGroup": "Ret;tma_issueBC",
-        "MetricName": "tma_info_branching_overhead",
-        "MetricThreshold": "tma_info_branching_overhead > 10",
-        "PublicDescription": "Total pipeline cost of branch related instru=
ctions (used for program control-flow including function calls). Related me=
trics: tma_info_big_code"
+        "BriefDescription": "Total pipeline cost of (external) Memory Band=
width related bottlenecks",
+        "MetricExpr": "100 * tma_memory_bound * (tma_dram_bound / (tma_dra=
m_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_pmm_bound + tma_=
store_bound) * (tma_mem_bandwidth / (tma_mem_bandwidth + tma_mem_latency)) =
+ tma_l3_bound / (tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bou=
nd + tma_pmm_bound + tma_store_bound) * (tma_sq_full / (tma_contested_acces=
ses + tma_data_sharing + tma_l3_hit_latency + tma_sq_full))) + tma_l1_bound=
 / (tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_pmm_b=
ound + tma_store_bound) * (tma_fb_full / (tma_4k_aliasing + tma_dtlb_load +=
 tma_fb_full + tma_lock_latency + tma_split_loads + tma_store_fwd_blk))",
+        "MetricGroup": "Mem;MemoryBW;Offcore;tma_issueBW",
+        "MetricName": "tma_info_bottleneck_memory_bandwidth",
+        "MetricThreshold": "tma_info_bottleneck_memory_bandwidth > 20",
+        "PublicDescription": "Total pipeline cost of (external) Memory Ban=
dwidth related bottlenecks. Related metrics: tma_fb_full, tma_info_system_d=
ram_bw_use, tma_mem_bandwidth, tma_sq_full"
     },
     {
-        "BriefDescription": "Fraction of branches that are CALL or RET",
-        "MetricExpr": "(BR_INST_RETIRED.NEAR_CALL + BR_INST_RETIRED.NEAR_R=
ETURN) / BR_INST_RETIRED.ALL_BRANCHES",
-        "MetricGroup": "Bad;Branches",
-        "MetricName": "tma_info_callret"
+        "BriefDescription": "Total pipeline cost of Memory Address Transla=
tion related bottlenecks (data-side TLBs)",
+        "MetricConstraint": "NO_GROUP_EVENTS",
+        "MetricExpr": "100 * tma_memory_bound * (tma_l1_bound / max(tma_me=
mory_bound, tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + t=
ma_pmm_bound + tma_store_bound) * (tma_dtlb_load / max(tma_l1_bound, tma_4k=
_aliasing + tma_dtlb_load + tma_fb_full + tma_lock_latency + tma_split_load=
s + tma_store_fwd_blk)) + tma_store_bound / (tma_dram_bound + tma_l1_bound =
+ tma_l2_bound + tma_l3_bound + tma_pmm_bound + tma_store_bound) * (tma_dtl=
b_store / (tma_dtlb_store + tma_false_sharing + tma_split_stores + tma_stor=
e_latency + tma_streaming_stores)))",
+        "MetricGroup": "Mem;MemoryTLB;Offcore;tma_issueTLB",
+        "MetricName": "tma_info_bottleneck_memory_data_tlbs",
+        "MetricThreshold": "tma_info_bottleneck_memory_data_tlbs > 20",
+        "PublicDescription": "Total pipeline cost of Memory Address Transl=
ation related bottlenecks (data-side TLBs). Related metrics: tma_dtlb_load,=
 tma_dtlb_store"
     },
     {
-        "BriefDescription": "Per-Logical Processor actual clocks when the =
Logical Processor is active.",
-        "MetricExpr": "CPU_CLK_UNHALTED.THREAD",
-        "MetricGroup": "Pipeline",
-        "MetricName": "tma_info_clks"
+        "BriefDescription": "Total pipeline cost of Memory Latency related=
 bottlenecks (external memory and off-core caches)",
+        "MetricConstraint": "NO_GROUP_EVENTS",
+        "MetricExpr": "100 * tma_memory_bound * (tma_dram_bound / (tma_dra=
m_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_pmm_bound + tma_=
store_bound) * (tma_mem_latency / (tma_mem_bandwidth + tma_mem_latency)) + =
tma_l3_bound / (tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound=
 + tma_pmm_bound + tma_store_bound) * (tma_l3_hit_latency / (tma_contested_=
accesses + tma_data_sharing + tma_l3_hit_latency + tma_sq_full)) + tma_l2_b=
ound / (tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_p=
mm_bound + tma_store_bound))",
+        "MetricGroup": "Mem;MemoryLat;Offcore;tma_issueLat",
+        "MetricName": "tma_info_bottleneck_memory_latency",
+        "MetricThreshold": "tma_info_bottleneck_memory_latency > 20",
+        "PublicDescription": "Total pipeline cost of Memory Latency relate=
d bottlenecks (external memory and off-core caches). Related metrics: tma_l=
3_hit_latency, tma_mem_latency"
     },
     {
-        "BriefDescription": "STLB (2nd level TLB) code speculative misses =
per kilo instruction (misses of any page-size that complete the page walk)"=
,
-        "MetricExpr": "1e3 * ITLB_MISSES.WALK_COMPLETED / INST_RETIRED.ANY=
",
-        "MetricGroup": "Fed;MemoryTLB",
-        "MetricName": "tma_info_code_stlb_mpki"
+        "BriefDescription": "Total pipeline cost of Branch Misprediction r=
elated bottlenecks",
+        "MetricConstraint": "NO_GROUP_EVENTS",
+        "MetricExpr": "100 * (tma_branch_mispredicts + tma_fetch_latency *=
 tma_mispredicts_resteers / (tma_branch_resteers + tma_dsb_switches + tma_i=
cache_misses + tma_itlb_misses + tma_lcp + tma_ms_switches))",
+        "MetricGroup": "Bad;BadSpec;BrMispredicts;tma_issueBM",
+        "MetricName": "tma_info_bottleneck_mispredictions",
+        "MetricThreshold": "tma_info_bottleneck_mispredictions > 20",
+        "PublicDescription": "Total pipeline cost of Branch Misprediction =
related bottlenecks. Related metrics: tma_branch_mispredicts, tma_info_bad_=
spec_branch_misprediction_cost, tma_mispredicts_resteers"
+    },
+    {
+        "BriefDescription": "Fraction of branches that are CALL or RET",
+        "MetricExpr": "(BR_INST_RETIRED.NEAR_CALL + BR_INST_RETIRED.NEAR_R=
ETURN) / BR_INST_RETIRED.ALL_BRANCHES",
+        "MetricGroup": "Bad;Branches",
+        "MetricName": "tma_info_branches_callret"
     },
     {
         "BriefDescription": "Fraction of branches that are non-taken condi=
tionals",
         "MetricExpr": "BR_INST_RETIRED.COND_NTAKEN / BR_INST_RETIRED.ALL_B=
RANCHES",
         "MetricGroup": "Bad;Branches;CodeGen;PGO",
-        "MetricName": "tma_info_cond_nt"
+        "MetricName": "tma_info_branches_cond_nt"
     },
     {
         "BriefDescription": "Fraction of branches that are taken condition=
als",
         "MetricExpr": "BR_INST_RETIRED.COND_TAKEN / BR_INST_RETIRED.ALL_BR=
ANCHES",
         "MetricGroup": "Bad;Branches;CodeGen;PGO",
-        "MetricName": "tma_info_cond_tk"
+        "MetricName": "tma_info_branches_cond_tk"
     },
     {
-        "BriefDescription": "Probability of Core Bound bottleneck hidden b=
y SMT-profiling artifacts",
-        "MetricConstraint": "NO_GROUP_EVENTS",
-        "MetricExpr": "(100 * (1 - tma_core_bound / tma_ports_utilization =
if tma_core_bound < tma_ports_utilization else 1) if tma_info_smt_2t_utiliz=
ation > 0.5 else 0)",
-        "MetricGroup": "Cor;SMT",
-        "MetricName": "tma_info_core_bound_likely",
-        "MetricThreshold": "tma_info_core_bound_likely > 0.5"
+        "BriefDescription": "Fraction of branches that are unconditional (=
direct or indirect) jumps",
+        "MetricExpr": "(BR_INST_RETIRED.NEAR_TAKEN - BR_INST_RETIRED.COND_=
TAKEN - 2 * BR_INST_RETIRED.NEAR_CALL) / BR_INST_RETIRED.ALL_BRANCHES",
+        "MetricGroup": "Bad;Branches",
+        "MetricName": "tma_info_branches_jump"
+    },
+    {
+        "BriefDescription": "Fraction of branches of other types (not indi=
vidually covered by other metrics in Info.Branches group)",
+        "MetricExpr": "1 - (tma_info_branches_cond_nt + tma_info_branches_=
cond_tk + tma_info_branches_callret + tma_info_branches_jump)",
+        "MetricGroup": "Bad;Branches",
+        "MetricName": "tma_info_branches_other_branches"
     },
     {
         "BriefDescription": "Core actual clocks when any Logical Processor=
 is active on the Physical Core",
         "MetricExpr": "CPU_CLK_UNHALTED.DISTRIBUTED",
         "MetricGroup": "SMT",
-        "MetricName": "tma_info_core_clks"
+        "MetricName": "tma_info_core_core_clks"
     },
     {
         "BriefDescription": "Instructions Per Cycle across hyper-threads (=
per physical core)",
-        "MetricExpr": "INST_RETIRED.ANY / tma_info_core_clks",
+        "MetricExpr": "INST_RETIRED.ANY / tma_info_core_core_clks",
         "MetricGroup": "Ret;SMT;TmaL1;tma_L1_group",
-        "MetricName": "tma_info_coreipc"
+        "MetricName": "tma_info_core_coreipc"
     },
     {
-        "BriefDescription": "Cycles Per Instruction (per Logical Processor=
)",
-        "MetricExpr": "1 / tma_info_ipc",
-        "MetricGroup": "Mem;Pipeline",
-        "MetricName": "tma_info_cpi"
+        "BriefDescription": "Floating Point Operations Per Cycle",
+        "MetricConstraint": "NO_GROUP_EVENTS",
+        "MetricExpr": "(cpu@FP_ARITH_INST_RETIRED.SCALAR_SINGLE\\,umask\\=
=3D0x03@ + 2 * FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + 4 * cpu@FP_ARITH_=
INST_RETIRED.128B_PACKED_SINGLE\\,umask\\=3D0x18@ + 8 * cpu@FP_ARITH_INST_R=
ETIRED.256B_PACKED_SINGLE\\,umask\\=3D0x60@ + 16 * FP_ARITH_INST_RETIRED.51=
2B_PACKED_SINGLE) / tma_info_core_core_clks",
+        "MetricGroup": "Flops;Ret",
+        "MetricName": "tma_info_core_flopc"
     },
     {
-        "BriefDescription": "Average CPU Utilization",
-        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC / TSC",
-        "MetricGroup": "HPC;Summary",
-        "MetricName": "tma_info_cpu_utilization"
+        "BriefDescription": "Actual per-core usage of the Floating Point n=
on-X87 execution units (regardless of precision or vector-width)",
+        "MetricConstraint": "NO_GROUP_EVENTS",
+        "MetricExpr": "(cpu@FP_ARITH_INST_RETIRED.SCALAR_SINGLE\\,umask\\=
=3D0x03@ + cpu@FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE\\,umask\\=3D0xfc@) =
/ (2 * tma_info_core_core_clks)",
+        "MetricGroup": "Cor;Flops;HPC",
+        "MetricName": "tma_info_core_fp_arith_utilization",
+        "PublicDescription": "Actual per-core usage of the Floating Point =
non-X87 execution units (regardless of precision or vector-width). Values >=
 1 are possible due to ([BDW+] Fused-Multiply Add (FMA) counting - common; =
[ADL+] use all of ADD/MUL/FMA in Scalar or 128/256-bit vectors - less commo=
n)."
     },
     {
-        "BriefDescription": "Average Parallel L2 cache miss data reads",
-        "MetricExpr": "OFFCORE_REQUESTS_OUTSTANDING.ALL_DATA_RD / OFFCORE_=
REQUESTS_OUTSTANDING.CYCLES_WITH_DATA_RD",
-        "MetricGroup": "Memory_BW;Offcore",
-        "MetricName": "tma_info_data_l2_mlp"
+        "BriefDescription": "Instruction-Level-Parallelism (average number=
 of uops executed when there is execution) per-core",
+        "MetricExpr": "UOPS_EXECUTED.THREAD / (UOPS_EXECUTED.CORE_CYCLES_G=
E_1 / 2 if #SMT_on else UOPS_EXECUTED.CORE_CYCLES_GE_1)",
+        "MetricGroup": "Backend;Cor;Pipeline;PortsUtil",
+        "MetricName": "tma_info_core_ilp"
     },
     {
-        "BriefDescription": "Average external Memory Bandwidth Use for rea=
ds and writes [GB / sec]",
-        "MetricExpr": "64 * (UNC_M_CAS_COUNT.RD + UNC_M_CAS_COUNT.WR) / 1e=
9 / duration_time",
-        "MetricGroup": "HPC;Mem;MemoryBW;SoC;tma_issueBW",
-        "MetricName": "tma_info_dram_bw_use",
-        "PublicDescription": "Average external Memory Bandwidth Use for re=
ads and writes [GB / sec]. Related metrics: tma_fb_full, tma_info_memory_ba=
ndwidth, tma_mem_bandwidth, tma_sq_full"
+        "BriefDescription": "Number of Instructions per non-speculative Br=
anch Misprediction (JEClear)",
+        "MetricExpr": "INST_RETIRED.ANY / BR_MISP_RETIRED.ALL_BRANCHES",
+        "MetricGroup": "Bad;BadSpec;BrMispredicts;TopdownL1;tma_L1_group",
+        "MetricName": "tma_info_core_ipmispredict",
+        "MetricgroupNoGroup": "TopdownL1"
     },
     {
         "BriefDescription": "Fraction of Uops delivered by the DSB (aka De=
coded ICache; or Uop Cache)",
         "MetricExpr": "IDQ.DSB_UOPS / UOPS_ISSUED.ANY",
         "MetricGroup": "DSB;Fed;FetchBW;tma_issueFB",
-        "MetricName": "tma_info_dsb_coverage",
-        "MetricThreshold": "tma_info_dsb_coverage < 0.7 & tma_info_ipc / 5=
 > 0.35",
-        "PublicDescription": "Fraction of Uops delivered by the DSB (aka D=
ecoded ICache; or Uop Cache). Related metrics: tma_dsb_switches, tma_fetch_=
bandwidth, tma_info_dsb_misses, tma_info_iptb, tma_lcp"
-    },
-    {
-        "BriefDescription": "Total pipeline cost of DSB (uop cache) misses=
 - subset of the Instruction_Fetch_BW Bottleneck",
-        "MetricConstraint": "NO_GROUP_EVENTS",
-        "MetricExpr": "100 * (tma_fetch_latency * tma_dsb_switches / (tma_=
branch_resteers + tma_dsb_switches + tma_icache_misses + tma_itlb_misses + =
tma_lcp + tma_ms_switches) + tma_fetch_bandwidth * tma_mite / (tma_dsb + tm=
a_mite))",
-        "MetricGroup": "DSBmiss;Fed;tma_issueFB",
-        "MetricName": "tma_info_dsb_misses",
-        "MetricThreshold": "tma_info_dsb_misses > 10",
-        "PublicDescription": "Total pipeline cost of DSB (uop cache) misse=
s - subset of the Instruction_Fetch_BW Bottleneck. Related metrics: tma_dsb=
_switches, tma_fetch_bandwidth, tma_info_dsb_coverage, tma_info_iptb, tma_l=
cp"
+        "MetricName": "tma_info_frontend_dsb_coverage",
+        "MetricThreshold": "tma_info_frontend_dsb_coverage < 0.7 & tma_inf=
o_thread_ipc / 5 > 0.35",
+        "PublicDescription": "Fraction of Uops delivered by the DSB (aka D=
ecoded ICache; or Uop Cache). Related metrics: tma_dsb_switches, tma_fetch_=
bandwidth, tma_info_botlnk_l2_dsb_misses, tma_info_inst_mix_iptb, tma_lcp"
     },
     {
         "BriefDescription": "Average number of cycles of a switch from the=
 DSB fetch-unit to MITE fetch unit - see DSB_Switches tree node for details=
.",
         "MetricExpr": "DSB2MITE_SWITCHES.PENALTY_CYCLES / cpu@DSB2MITE_SWI=
TCHES.PENALTY_CYCLES\\,cmask\\=3D1\\,edge@",
         "MetricGroup": "DSBmiss",
-        "MetricName": "tma_info_dsb_switch_cost"
-    },
-    {
-        "BriefDescription": "Instruction-Level-Parallelism (average number=
 of uops executed when there is execution) per-thread",
-        "MetricExpr": "UOPS_EXECUTED.THREAD / cpu@UOPS_EXECUTED.THREAD\\,c=
mask\\=3D1@",
-        "MetricGroup": "Cor;Pipeline;PortsUtil;SMT",
-        "MetricName": "tma_info_execute"
-    },
-    {
-        "BriefDescription": "The ratio of Executed- by Issued-Uops",
-        "MetricExpr": "UOPS_EXECUTED.THREAD / UOPS_ISSUED.ANY",
-        "MetricGroup": "Cor;Pipeline",
-        "MetricName": "tma_info_execute_per_issue",
-        "PublicDescription": "The ratio of Executed- by Issued-Uops. Ratio=
 > 1 suggests high rate of uop micro-fusions. Ratio < 1 suggest high rate o=
f \"execute\" at rename stage."
-    },
-    {
-        "BriefDescription": "Fill Buffer (FB) hits per kilo instructions f=
or retired demand loads (L1D misses that merge into ongoing miss-handling e=
ntries)",
-        "MetricExpr": "1e3 * MEM_LOAD_RETIRED.FB_HIT / INST_RETIRED.ANY",
-        "MetricGroup": "CacheMisses;Mem",
-        "MetricName": "tma_info_fb_hpki"
+        "MetricName": "tma_info_frontend_dsb_switch_cost"
     },
     {
         "BriefDescription": "Average number of Uops issued by front-end wh=
en it issued something",
         "MetricExpr": "UOPS_ISSUED.ANY / cpu@UOPS_ISSUED.ANY\\,cmask\\=3D1=
@",
         "MetricGroup": "Fed;FetchBW",
-        "MetricName": "tma_info_fetch_upc"
-    },
-    {
-        "BriefDescription": "Floating Point Operations Per Cycle",
-        "MetricConstraint": "NO_GROUP_EVENTS",
-        "MetricExpr": "(cpu@FP_ARITH_INST_RETIRED.SCALAR_SINGLE\\,umask\\=
=3D0x03@ + 2 * FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + 4 * cpu@FP_ARITH_=
INST_RETIRED.128B_PACKED_SINGLE\\,umask\\=3D0x18@ + 8 * cpu@FP_ARITH_INST_R=
ETIRED.256B_PACKED_SINGLE\\,umask\\=3D0x60@ + 16 * FP_ARITH_INST_RETIRED.51=
2B_PACKED_SINGLE) / tma_info_core_clks",
-        "MetricGroup": "Flops;Ret",
-        "MetricName": "tma_info_flopc"
+        "MetricName": "tma_info_frontend_fetch_upc"
     },
     {
-        "BriefDescription": "Actual per-core usage of the Floating Point n=
on-X87 execution units (regardless of precision or vector-width)",
-        "MetricConstraint": "NO_GROUP_EVENTS",
-        "MetricExpr": "(cpu@FP_ARITH_INST_RETIRED.SCALAR_SINGLE\\,umask\\=
=3D0x03@ + cpu@FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE\\,umask\\=3D0xfc@) =
/ (2 * tma_info_core_clks)",
-        "MetricGroup": "Cor;Flops;HPC",
-        "MetricName": "tma_info_fp_arith_utilization",
-        "PublicDescription": "Actual per-core usage of the Floating Point =
non-X87 execution units (regardless of precision or vector-width). Values >=
 1 are possible due to ([BDW+] Fused-Multiply Add (FMA) counting - common; =
[ADL+] use all of ADD/MUL/FMA in Scalar or 128/256-bit vectors - less commo=
n)."
+        "BriefDescription": "Average Latency for L1 instruction cache miss=
es",
+        "MetricExpr": "ICACHE_16B.IFDATA_STALL / cpu@ICACHE_16B.IFDATA_STA=
LL\\,cmask\\=3D1\\,edge@",
+        "MetricGroup": "Fed;FetchLat;IcMiss",
+        "MetricName": "tma_info_frontend_icache_miss_latency"
     },
     {
-        "BriefDescription": "Giga Floating Point Operations Per Second",
-        "MetricExpr": "(cpu@FP_ARITH_INST_RETIRED.SCALAR_SINGLE\\,umask\\=
=3D0x03@ + 2 * FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + 4 * cpu@FP_ARITH_=
INST_RETIRED.128B_PACKED_SINGLE\\,umask\\=3D0x18@ + 8 * cpu@FP_ARITH_INST_R=
ETIRED.256B_PACKED_SINGLE\\,umask\\=3D0x60@ + 16 * FP_ARITH_INST_RETIRED.51=
2B_PACKED_SINGLE) / 1e9 / duration_time",
-        "MetricGroup": "Cor;Flops;HPC",
-        "MetricName": "tma_info_gflops",
-        "PublicDescription": "Giga Floating Point Operations Per Second. A=
ggregate across all supported options of: FP precisions, scalar and vector =
instructions, vector-width and AMX engine."
+        "BriefDescription": "Instructions per non-speculative DSB miss (lo=
wer number means higher occurrence rate)",
+        "MetricExpr": "INST_RETIRED.ANY / FRONTEND_RETIRED.ANY_DSB_MISS",
+        "MetricGroup": "DSBmiss;Fed",
+        "MetricName": "tma_info_frontend_ipdsb_miss_ret",
+        "MetricThreshold": "tma_info_frontend_ipdsb_miss_ret < 50"
     },
     {
-        "BriefDescription": "Total pipeline cost of Instruction Cache miss=
es - subset of the Big_Code Bottleneck",
-        "MetricExpr": "100 * (tma_fetch_latency * tma_icache_misses / (tma=
_branch_resteers + tma_dsb_switches + tma_icache_misses + tma_itlb_misses +=
 tma_lcp + tma_ms_switches))",
-        "MetricGroup": "Fed;FetchLat;IcMiss;tma_issueFL",
-        "MetricName": "tma_info_ic_misses",
-        "MetricThreshold": "tma_info_ic_misses > 5",
-        "PublicDescription": "Total pipeline cost of Instruction Cache mis=
ses - subset of the Big_Code Bottleneck. Related metrics: "
+        "BriefDescription": "Instructions per speculative Unknown Branch M=
isprediction (BAClear) (lower number means higher occurrence rate)",
+        "MetricExpr": "tma_info_inst_mix_instructions / BACLEARS.ANY",
+        "MetricGroup": "Fed",
+        "MetricName": "tma_info_frontend_ipunknown_branch"
     },
     {
-        "BriefDescription": "Average Latency for L1 instruction cache miss=
es",
-        "MetricExpr": "ICACHE_16B.IFDATA_STALL / cpu@ICACHE_16B.IFDATA_STA=
LL\\,cmask\\=3D1\\,edge@",
-        "MetricGroup": "Fed;FetchLat;IcMiss",
-        "MetricName": "tma_info_icache_miss_latency"
+        "BriefDescription": "L2 cache true code cacheline misses per kilo =
instruction",
+        "MetricExpr": "1e3 * FRONTEND_RETIRED.L2_MISS / INST_RETIRED.ANY",
+        "MetricGroup": "IcMiss",
+        "MetricName": "tma_info_frontend_l2mpki_code"
     },
     {
-        "BriefDescription": "Instruction-Level-Parallelism (average number=
 of uops executed when there is execution) per-core",
-        "MetricExpr": "UOPS_EXECUTED.THREAD / (UOPS_EXECUTED.CORE_CYCLES_G=
E_1 / 2 if #SMT_on else UOPS_EXECUTED.CORE_CYCLES_GE_1)",
-        "MetricGroup": "Backend;Cor;Pipeline;PortsUtil",
-        "MetricName": "tma_info_ilp"
+        "BriefDescription": "L2 cache speculative code cacheline misses pe=
r kilo instruction",
+        "MetricExpr": "1e3 * L2_RQSTS.CODE_RD_MISS / INST_RETIRED.ANY",
+        "MetricGroup": "IcMiss",
+        "MetricName": "tma_info_frontend_l2mpki_code_all"
     },
     {
-        "BriefDescription": "Total pipeline cost of instruction fetch band=
width related bottlenecks",
-        "MetricConstraint": "NO_GROUP_EVENTS",
-        "MetricExpr": "100 * (tma_frontend_bound - tma_fetch_latency * tma=
_mispredicts_resteers / (tma_branch_resteers + tma_dsb_switches + tma_icach=
e_misses + tma_itlb_misses + tma_lcp + tma_ms_switches)) - tma_info_big_cod=
e",
-        "MetricGroup": "Fed;FetchBW;Frontend",
-        "MetricName": "tma_info_instruction_fetch_bw",
-        "MetricThreshold": "tma_info_instruction_fetch_bw > 20"
+        "BriefDescription": "Branch instructions per taken branch.",
+        "MetricExpr": "BR_INST_RETIRED.ALL_BRANCHES / BR_INST_RETIRED.NEAR=
_TAKEN",
+        "MetricGroup": "Branches;Fed;PGO",
+        "MetricName": "tma_info_inst_mix_bptkbranch"
     },
     {
         "BriefDescription": "Total number of retired Instructions",
         "MetricExpr": "INST_RETIRED.ANY",
         "MetricGroup": "Summary;TmaL1;tma_L1_group",
-        "MetricName": "tma_info_instructions",
+        "MetricName": "tma_info_inst_mix_instructions",
         "PublicDescription": "Total number of retired Instructions. Sample=
 with: INST_RETIRED.PREC_DIST"
     },
-    {
-        "BriefDescription": "Average IO (network or disk) Bandwidth Use fo=
r Reads [GB / sec]",
-        "MetricExpr": "(UNC_CHA_TOR_INSERTS.IO_HIT_ITOM + UNC_CHA_TOR_INSE=
RTS.IO_MISS_ITOM + UNC_CHA_TOR_INSERTS.IO_HIT_ITOMCACHENEAR + UNC_CHA_TOR_I=
NSERTS.IO_MISS_ITOMCACHENEAR) * 64 / 1e9 / duration_time",
-        "MetricGroup": "IoBW;Mem;Server;SoC",
-        "MetricName": "tma_info_io_read_bw"
-    },
-    {
-        "BriefDescription": "Average IO (network or disk) Bandwidth Use fo=
r Writes [GB / sec]",
-        "MetricExpr": "UNC_CHA_TOR_INSERTS.IO_PCIRDCUR * 64 / 1e9 / durati=
on_time",
-        "MetricGroup": "IoBW;Mem;Server;SoC",
-        "MetricName": "tma_info_io_write_bw"
-    },
     {
         "BriefDescription": "Instructions per FP Arithmetic instruction (l=
ower number means higher occurrence rate)",
         "MetricExpr": "INST_RETIRED.ANY / (cpu@FP_ARITH_INST_RETIRED.SCALA=
R_SINGLE\\,umask\\=3D0x03@ + cpu@FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE\\=
,umask\\=3D0xfc@)",
         "MetricGroup": "Flops;InsType",
-        "MetricName": "tma_info_iparith",
-        "MetricThreshold": "tma_info_iparith < 10",
+        "MetricName": "tma_info_inst_mix_iparith",
+        "MetricThreshold": "tma_info_inst_mix_iparith < 10",
         "PublicDescription": "Instructions per FP Arithmetic instruction (=
lower number means higher occurrence rate). May undercount due to FMA doubl=
e counting. Approximated prior to BDW."
     },
     {
         "BriefDescription": "Instructions per FP Arithmetic AVX/SSE 128-bi=
t instruction (lower number means higher occurrence rate)",
         "MetricExpr": "INST_RETIRED.ANY / (FP_ARITH_INST_RETIRED.128B_PACK=
ED_DOUBLE + FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE)",
         "MetricGroup": "Flops;FpVector;InsType",
-        "MetricName": "tma_info_iparith_avx128",
-        "MetricThreshold": "tma_info_iparith_avx128 < 10",
+        "MetricName": "tma_info_inst_mix_iparith_avx128",
+        "MetricThreshold": "tma_info_inst_mix_iparith_avx128 < 10",
         "PublicDescription": "Instructions per FP Arithmetic AVX/SSE 128-b=
it instruction (lower number means higher occurrence rate). May undercount =
due to FMA double counting."
     },
     {
         "BriefDescription": "Instructions per FP Arithmetic AVX* 256-bit i=
nstruction (lower number means higher occurrence rate)",
         "MetricExpr": "INST_RETIRED.ANY / (FP_ARITH_INST_RETIRED.256B_PACK=
ED_DOUBLE + FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE)",
         "MetricGroup": "Flops;FpVector;InsType",
-        "MetricName": "tma_info_iparith_avx256",
-        "MetricThreshold": "tma_info_iparith_avx256 < 10",
+        "MetricName": "tma_info_inst_mix_iparith_avx256",
+        "MetricThreshold": "tma_info_inst_mix_iparith_avx256 < 10",
         "PublicDescription": "Instructions per FP Arithmetic AVX* 256-bit =
instruction (lower number means higher occurrence rate). May undercount due=
 to FMA double counting."
     },
     {
         "BriefDescription": "Instructions per FP Arithmetic AVX 512-bit in=
struction (lower number means higher occurrence rate)",
         "MetricExpr": "INST_RETIRED.ANY / (FP_ARITH_INST_RETIRED.512B_PACK=
ED_DOUBLE + FP_ARITH_INST_RETIRED.512B_PACKED_SINGLE)",
         "MetricGroup": "Flops;FpVector;InsType",
-        "MetricName": "tma_info_iparith_avx512",
-        "MetricThreshold": "tma_info_iparith_avx512 < 10",
+        "MetricName": "tma_info_inst_mix_iparith_avx512",
+        "MetricThreshold": "tma_info_inst_mix_iparith_avx512 < 10",
         "PublicDescription": "Instructions per FP Arithmetic AVX 512-bit i=
nstruction (lower number means higher occurrence rate). May undercount due =
to FMA double counting."
     },
     {
         "BriefDescription": "Instructions per FP Arithmetic Scalar Double-=
Precision instruction (lower number means higher occurrence rate)",
         "MetricExpr": "INST_RETIRED.ANY / FP_ARITH_INST_RETIRED.SCALAR_DOU=
BLE",
         "MetricGroup": "Flops;FpScalar;InsType",
-        "MetricName": "tma_info_iparith_scalar_dp",
-        "MetricThreshold": "tma_info_iparith_scalar_dp < 10",
+        "MetricName": "tma_info_inst_mix_iparith_scalar_dp",
+        "MetricThreshold": "tma_info_inst_mix_iparith_scalar_dp < 10",
         "PublicDescription": "Instructions per FP Arithmetic Scalar Double=
-Precision instruction (lower number means higher occurrence rate). May und=
ercount due to FMA double counting."
     },
     {
         "BriefDescription": "Instructions per FP Arithmetic Scalar Single-=
Precision instruction (lower number means higher occurrence rate)",
         "MetricExpr": "INST_RETIRED.ANY / FP_ARITH_INST_RETIRED.SCALAR_SIN=
GLE",
         "MetricGroup": "Flops;FpScalar;InsType",
-        "MetricName": "tma_info_iparith_scalar_sp",
-        "MetricThreshold": "tma_info_iparith_scalar_sp < 10",
+        "MetricName": "tma_info_inst_mix_iparith_scalar_sp",
+        "MetricThreshold": "tma_info_inst_mix_iparith_scalar_sp < 10",
         "PublicDescription": "Instructions per FP Arithmetic Scalar Single=
-Precision instruction (lower number means higher occurrence rate). May und=
ercount due to FMA double counting."
     },
     {
         "BriefDescription": "Instructions per Branch (lower number means h=
igher occurrence rate)",
         "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.ALL_BRANCHES",
         "MetricGroup": "Branches;Fed;InsType",
-        "MetricName": "tma_info_ipbranch",
-        "MetricThreshold": "tma_info_ipbranch < 8"
-    },
-    {
-        "BriefDescription": "Instructions Per Cycle (per Logical Processor=
)",
-        "MetricExpr": "INST_RETIRED.ANY / tma_info_clks",
-        "MetricGroup": "Ret;Summary",
-        "MetricName": "tma_info_ipc"
+        "MetricName": "tma_info_inst_mix_ipbranch",
+        "MetricThreshold": "tma_info_inst_mix_ipbranch < 8"
     },
     {
         "BriefDescription": "Instructions per (near) call (lower number me=
ans higher occurrence rate)",
         "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.NEAR_CALL",
         "MetricGroup": "Branches;Fed;PGO",
-        "MetricName": "tma_info_ipcall",
-        "MetricThreshold": "tma_info_ipcall < 200"
-    },
-    {
-        "BriefDescription": "Instructions per non-speculative DSB miss (lo=
wer number means higher occurrence rate)",
-        "MetricExpr": "INST_RETIRED.ANY / FRONTEND_RETIRED.ANY_DSB_MISS",
-        "MetricGroup": "DSBmiss;Fed",
-        "MetricName": "tma_info_ipdsb_miss_ret",
-        "MetricThreshold": "tma_info_ipdsb_miss_ret < 50"
-    },
-    {
-        "BriefDescription": "Instructions per Far Branch ( Far Branches ap=
ply upon transition from application to operating system, handling interrup=
ts, exceptions) [lower number means higher occurrence rate]",
-        "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.FAR_BRANCH:u",
-        "MetricGroup": "Branches;OS",
-        "MetricName": "tma_info_ipfarbranch",
-        "MetricThreshold": "tma_info_ipfarbranch < 1e6"
+        "MetricName": "tma_info_inst_mix_ipcall",
+        "MetricThreshold": "tma_info_inst_mix_ipcall < 200"
     },
     {
         "BriefDescription": "Instructions per Floating Point (FP) Operatio=
n (lower number means higher occurrence rate)",
         "MetricExpr": "INST_RETIRED.ANY / (cpu@FP_ARITH_INST_RETIRED.SCALA=
R_SINGLE\\,umask\\=3D0x03@ + 2 * FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE +=
 4 * cpu@FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE\\,umask\\=3D0x18@ + 8 * c=
pu@FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE\\,umask\\=3D0x60@ + 16 * FP_ARI=
TH_INST_RETIRED.512B_PACKED_SINGLE)",
         "MetricGroup": "Flops;InsType",
-        "MetricName": "tma_info_ipflop",
-        "MetricThreshold": "tma_info_ipflop < 10"
+        "MetricName": "tma_info_inst_mix_ipflop",
+        "MetricThreshold": "tma_info_inst_mix_ipflop < 10"
     },
     {
         "BriefDescription": "Instructions per Load (lower number means hig=
her occurrence rate)",
         "MetricExpr": "INST_RETIRED.ANY / MEM_INST_RETIRED.ALL_LOADS",
         "MetricGroup": "InsType",
-        "MetricName": "tma_info_ipload",
-        "MetricThreshold": "tma_info_ipload < 3"
-    },
-    {
-        "BriefDescription": "Instructions per retired mispredicts for cond=
itional non-taken branches (lower number means higher occurrence rate).",
-        "MetricExpr": "INST_RETIRED.ANY / BR_MISP_RETIRED.COND_NTAKEN",
-        "MetricGroup": "Bad;BrMispredicts",
-        "MetricName": "tma_info_ipmisp_cond_ntaken",
-        "MetricThreshold": "tma_info_ipmisp_cond_ntaken < 200"
-    },
-    {
-        "BriefDescription": "Instructions per retired mispredicts for cond=
itional taken branches (lower number means higher occurrence rate).",
-        "MetricExpr": "INST_RETIRED.ANY / BR_MISP_RETIRED.COND_TAKEN",
-        "MetricGroup": "Bad;BrMispredicts",
-        "MetricName": "tma_info_ipmisp_cond_taken",
-        "MetricThreshold": "tma_info_ipmisp_cond_taken < 200"
-    },
-    {
-        "BriefDescription": "Instructions per retired mispredicts for indi=
rect CALL or JMP branches (lower number means higher occurrence rate).",
-        "MetricExpr": "INST_RETIRED.ANY / BR_MISP_RETIRED.INDIRECT",
-        "MetricGroup": "Bad;BrMispredicts",
-        "MetricName": "tma_info_ipmisp_indirect",
-        "MetricThreshold": "tma_info_ipmisp_indirect < 1e3"
-    },
-    {
-        "BriefDescription": "Instructions per retired mispredicts for retu=
rn branches (lower number means higher occurrence rate).",
-        "MetricExpr": "INST_RETIRED.ANY / BR_MISP_RETIRED.RET",
-        "MetricGroup": "Bad;BrMispredicts",
-        "MetricName": "tma_info_ipmisp_ret",
-        "MetricThreshold": "tma_info_ipmisp_ret < 500"
-    },
-    {
-        "BriefDescription": "Number of Instructions per non-speculative Br=
anch Misprediction (JEClear) (lower number means higher occurrence rate)",
-        "MetricExpr": "INST_RETIRED.ANY / BR_MISP_RETIRED.ALL_BRANCHES",
-        "MetricGroup": "Bad;BadSpec;BrMispredicts",
-        "MetricName": "tma_info_ipmispredict",
-        "MetricThreshold": "tma_info_ipmispredict < 200"
+        "MetricName": "tma_info_inst_mix_ipload",
+        "MetricThreshold": "tma_info_inst_mix_ipload < 3"
     },
     {
         "BriefDescription": "Instructions per Store (lower number means hi=
gher occurrence rate)",
         "MetricExpr": "INST_RETIRED.ANY / MEM_INST_RETIRED.ALL_STORES",
         "MetricGroup": "InsType",
-        "MetricName": "tma_info_ipstore",
-        "MetricThreshold": "tma_info_ipstore < 8"
+        "MetricName": "tma_info_inst_mix_ipstore",
+        "MetricThreshold": "tma_info_inst_mix_ipstore < 8"
     },
     {
         "BriefDescription": "Instructions per Software prefetch instructio=
n (of any type: NTA/T0/T1/T2/Prefetch) (lower number means higher occurrenc=
e rate)",
         "MetricExpr": "INST_RETIRED.ANY / cpu@SW_PREFETCH_ACCESS.T0\\,umas=
k\\=3D0xF@",
         "MetricGroup": "Prefetches",
-        "MetricName": "tma_info_ipswpf",
-        "MetricThreshold": "tma_info_ipswpf < 100"
-    },
-    {
-        "BriefDescription": "Instruction per taken branch",
-        "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.NEAR_TAKEN",
-        "MetricGroup": "Branches;Fed;FetchBW;Frontend;PGO;tma_issueFB",
-        "MetricName": "tma_info_iptb",
-        "MetricThreshold": "tma_info_iptb < 11",
-        "PublicDescription": "Instruction per taken branch. Related metric=
s: tma_dsb_switches, tma_fetch_bandwidth, tma_info_dsb_coverage, tma_info_d=
sb_misses, tma_lcp"
-    },
-    {
-        "BriefDescription": "Instructions per speculative Unknown Branch M=
isprediction (BAClear) (lower number means higher occurrence rate)",
-        "MetricExpr": "tma_info_instructions / BACLEARS.ANY",
-        "MetricGroup": "Fed",
-        "MetricName": "tma_info_ipunknown_branch"
-    },
-    {
-        "BriefDescription": "Fraction of branches that are unconditional (=
direct or indirect) jumps",
-        "MetricExpr": "(BR_INST_RETIRED.NEAR_TAKEN - BR_INST_RETIRED.COND_=
TAKEN - 2 * BR_INST_RETIRED.NEAR_CALL) / BR_INST_RETIRED.ALL_BRANCHES",
-        "MetricGroup": "Bad;Branches",
-        "MetricName": "tma_info_jump"
-    },
-    {
-        "BriefDescription": "Cycles Per Instruction for the Operating Syst=
em (OS) Kernel mode",
-        "MetricExpr": "CPU_CLK_UNHALTED.THREAD_P:k / INST_RETIRED.ANY_P:k"=
,
-        "MetricGroup": "OS",
-        "MetricName": "tma_info_kernel_cpi"
-    },
-    {
-        "BriefDescription": "Fraction of cycles spent in the Operating Sys=
tem (OS) Kernel mode",
-        "MetricExpr": "CPU_CLK_UNHALTED.THREAD_P:k / CPU_CLK_UNHALTED.THRE=
AD",
-        "MetricGroup": "OS",
-        "MetricName": "tma_info_kernel_utilization",
-        "MetricThreshold": "tma_info_kernel_utilization > 0.05"
+        "MetricName": "tma_info_inst_mix_ipswpf",
+        "MetricThreshold": "tma_info_inst_mix_ipswpf < 100"
+    },
+    {
+        "BriefDescription": "Instruction per taken branch",
+        "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.NEAR_TAKEN",
+        "MetricGroup": "Branches;Fed;FetchBW;Frontend;PGO;tma_issueFB",
+        "MetricName": "tma_info_inst_mix_iptb",
+        "MetricThreshold": "tma_info_inst_mix_iptb < 11",
+        "PublicDescription": "Instruction per taken branch. Related metric=
s: tma_dsb_switches, tma_fetch_bandwidth, tma_info_botlnk_l2_dsb_misses, tm=
a_info_frontend_dsb_coverage, tma_lcp"
     },
     {
         "BriefDescription": "Average per-core data fill bandwidth to the L=
1 data cache [GB / sec]",
         "MetricExpr": "64 * L1D.REPLACEMENT / 1e9 / duration_time",
         "MetricGroup": "Mem;MemoryBW",
-        "MetricName": "tma_info_l1d_cache_fill_bw"
+        "MetricName": "tma_info_memory_core_l1d_cache_fill_bw"
     },
     {
-        "BriefDescription": "Average per-thread data fill bandwidth to the=
 L1 data cache [GB / sec]",
-        "MetricExpr": "tma_info_l1d_cache_fill_bw",
+        "BriefDescription": "Average per-core data fill bandwidth to the L=
2 cache [GB / sec]",
+        "MetricExpr": "64 * L2_LINES_IN.ALL / 1e9 / duration_time",
         "MetricGroup": "Mem;MemoryBW",
-        "MetricName": "tma_info_l1d_cache_fill_bw_1t"
+        "MetricName": "tma_info_memory_core_l2_cache_fill_bw"
     },
     {
-        "BriefDescription": "L1 cache true misses per kilo instruction for=
 retired demand loads",
-        "MetricExpr": "1e3 * MEM_LOAD_RETIRED.L1_MISS / INST_RETIRED.ANY",
-        "MetricGroup": "CacheMisses;Mem",
-        "MetricName": "tma_info_l1mpki"
+        "BriefDescription": "Rate of non silent evictions from the L2 cach=
e per Kilo instruction",
+        "MetricExpr": "1e3 * L2_LINES_OUT.NON_SILENT / tma_info_inst_mix_i=
nstructions",
+        "MetricGroup": "L2Evicts;Mem;Server",
+        "MetricName": "tma_info_memory_core_l2_evictions_nonsilent_pki"
     },
     {
-        "BriefDescription": "L1 cache true misses per kilo instruction for=
 all demand loads (including speculative)",
-        "MetricExpr": "1e3 * L2_RQSTS.ALL_DEMAND_DATA_RD / INST_RETIRED.AN=
Y",
-        "MetricGroup": "CacheMisses;Mem",
-        "MetricName": "tma_info_l1mpki_load"
+        "BriefDescription": "Rate of silent evictions from the L2 cache pe=
r Kilo instruction where the evicted lines are dropped (no writeback to L3 =
or memory)",
+        "MetricExpr": "1e3 * L2_LINES_OUT.SILENT / tma_info_inst_mix_instr=
uctions",
+        "MetricGroup": "L2Evicts;Mem;Server",
+        "MetricName": "tma_info_memory_core_l2_evictions_silent_pki"
     },
     {
-        "BriefDescription": "Average per-core data fill bandwidth to the L=
2 cache [GB / sec]",
-        "MetricExpr": "64 * L2_LINES_IN.ALL / 1e9 / duration_time",
-        "MetricGroup": "Mem;MemoryBW",
-        "MetricName": "tma_info_l2_cache_fill_bw"
+        "BriefDescription": "Average per-core data access bandwidth to the=
 L3 cache [GB / sec]",
+        "MetricExpr": "64 * OFFCORE_REQUESTS.ALL_REQUESTS / 1e9 / duration=
_time",
+        "MetricGroup": "Mem;MemoryBW;Offcore",
+        "MetricName": "tma_info_memory_core_l3_cache_access_bw"
     },
     {
-        "BriefDescription": "Average per-thread data fill bandwidth to the=
 L2 cache [GB / sec]",
-        "MetricExpr": "tma_info_l2_cache_fill_bw",
+        "BriefDescription": "Average per-core data fill bandwidth to the L=
3 cache [GB / sec]",
+        "MetricExpr": "64 * LONGEST_LAT_CACHE.MISS / 1e9 / duration_time",
         "MetricGroup": "Mem;MemoryBW",
-        "MetricName": "tma_info_l2_cache_fill_bw_1t"
+        "MetricName": "tma_info_memory_core_l3_cache_fill_bw"
     },
     {
-        "BriefDescription": "Rate of non silent evictions from the L2 cach=
e per Kilo instruction",
-        "MetricExpr": "1e3 * L2_LINES_OUT.NON_SILENT / tma_info_instructio=
ns",
-        "MetricGroup": "L2Evicts;Mem;Server",
-        "MetricName": "tma_info_l2_evictions_nonsilent_pki"
+        "BriefDescription": "Fill Buffer (FB) hits per kilo instructions f=
or retired demand loads (L1D misses that merge into ongoing miss-handling e=
ntries)",
+        "MetricExpr": "1e3 * MEM_LOAD_RETIRED.FB_HIT / INST_RETIRED.ANY",
+        "MetricGroup": "CacheMisses;Mem",
+        "MetricName": "tma_info_memory_fb_hpki"
     },
     {
-        "BriefDescription": "Rate of silent evictions from the L2 cache pe=
r Kilo instruction where the evicted lines are dropped (no writeback to L3 =
or memory)",
-        "MetricExpr": "1e3 * L2_LINES_OUT.SILENT / tma_info_instructions",
-        "MetricGroup": "L2Evicts;Mem;Server",
-        "MetricName": "tma_info_l2_evictions_silent_pki"
+        "BriefDescription": "L1 cache true misses per kilo instruction for=
 retired demand loads",
+        "MetricExpr": "1e3 * MEM_LOAD_RETIRED.L1_MISS / INST_RETIRED.ANY",
+        "MetricGroup": "CacheMisses;Mem",
+        "MetricName": "tma_info_memory_l1mpki"
+    },
+    {
+        "BriefDescription": "L1 cache true misses per kilo instruction for=
 all demand loads (including speculative)",
+        "MetricExpr": "1e3 * L2_RQSTS.ALL_DEMAND_DATA_RD / INST_RETIRED.AN=
Y",
+        "MetricGroup": "CacheMisses;Mem",
+        "MetricName": "tma_info_memory_l1mpki_load"
     },
     {
         "BriefDescription": "L2 cache hits per kilo instruction for all de=
mand loads  (including speculative)",
         "MetricExpr": "1e3 * L2_RQSTS.DEMAND_DATA_RD_HIT / INST_RETIRED.AN=
Y",
         "MetricGroup": "CacheMisses;Mem",
-        "MetricName": "tma_info_l2hpki_load"
+        "MetricName": "tma_info_memory_l2hpki_load"
     },
     {
         "BriefDescription": "L2 cache true misses per kilo instruction for=
 retired demand loads",
         "MetricExpr": "1e3 * MEM_LOAD_RETIRED.L2_MISS / INST_RETIRED.ANY",
         "MetricGroup": "Backend;CacheMisses;Mem",
-        "MetricName": "tma_info_l2mpki"
+        "MetricName": "tma_info_memory_l2mpki"
     },
     {
         "BriefDescription": "L2 cache ([RKL+] true) misses per kilo instru=
ction for all request types (including speculative)",
-        "MetricExpr": "1e3 * (OFFCORE_REQUESTS.ALL_DATA_RD - OFFCORE_REQUE=
STS.DEMAND_DATA_RD + L2_RQSTS.ALL_DEMAND_MISS + L2_RQSTS.SWPF_MISS) / tma_i=
nfo_instructions",
+        "MetricExpr": "1e3 * (OFFCORE_REQUESTS.ALL_DATA_RD - OFFCORE_REQUE=
STS.DEMAND_DATA_RD + L2_RQSTS.ALL_DEMAND_MISS + L2_RQSTS.SWPF_MISS) / tma_i=
nfo_inst_mix_instructions",
         "MetricGroup": "CacheMisses;Mem;Offcore",
-        "MetricName": "tma_info_l2mpki_all"
-    },
-    {
-        "BriefDescription": "L2 cache true code cacheline misses per kilo =
instruction",
-        "MetricExpr": "1e3 * FRONTEND_RETIRED.L2_MISS / INST_RETIRED.ANY",
-        "MetricGroup": "IcMiss",
-        "MetricName": "tma_info_l2mpki_code"
-    },
-    {
-        "BriefDescription": "L2 cache speculative code cacheline misses pe=
r kilo instruction",
-        "MetricExpr": "1e3 * L2_RQSTS.CODE_RD_MISS / INST_RETIRED.ANY",
-        "MetricGroup": "IcMiss",
-        "MetricName": "tma_info_l2mpki_code_all"
+        "MetricName": "tma_info_memory_l2mpki_all"
     },
     {
         "BriefDescription": "L2 cache ([RKL+] true) misses per kilo instru=
ction for all demand loads  (including speculative)",
         "MetricExpr": "1e3 * L2_RQSTS.DEMAND_DATA_RD_MISS / INST_RETIRED.A=
NY",
         "MetricGroup": "CacheMisses;Mem",
-        "MetricName": "tma_info_l2mpki_load"
-    },
-    {
-        "BriefDescription": "Average per-core data access bandwidth to the=
 L3 cache [GB / sec]",
-        "MetricExpr": "64 * OFFCORE_REQUESTS.ALL_REQUESTS / 1e9 / duration=
_time",
-        "MetricGroup": "Mem;MemoryBW;Offcore",
-        "MetricName": "tma_info_l3_cache_access_bw"
+        "MetricName": "tma_info_memory_l2mpki_load"
     },
     {
-        "BriefDescription": "Average per-thread data access bandwidth to t=
he L3 cache [GB / sec]",
-        "MetricExpr": "tma_info_l3_cache_access_bw",
-        "MetricGroup": "Mem;MemoryBW;Offcore",
-        "MetricName": "tma_info_l3_cache_access_bw_1t"
+        "BriefDescription": "L3 cache true misses per kilo instruction for=
 retired demand loads",
+        "MetricExpr": "1e3 * MEM_LOAD_RETIRED.L3_MISS / INST_RETIRED.ANY",
+        "MetricGroup": "CacheMisses;Mem",
+        "MetricName": "tma_info_memory_l3mpki"
     },
     {
-        "BriefDescription": "Average per-core data fill bandwidth to the L=
3 cache [GB / sec]",
-        "MetricExpr": "64 * LONGEST_LAT_CACHE.MISS / 1e9 / duration_time",
-        "MetricGroup": "Mem;MemoryBW",
-        "MetricName": "tma_info_l3_cache_fill_bw"
+        "BriefDescription": "Actual Average Latency for L1 data-cache miss=
 demand load operations (in core cycles)",
+        "MetricExpr": "L1D_PEND_MISS.PENDING / (MEM_LOAD_RETIRED.L1_MISS +=
 MEM_LOAD_RETIRED.FB_HIT)",
+        "MetricGroup": "Mem;MemoryBound;MemoryLat",
+        "MetricName": "tma_info_memory_load_miss_real_latency"
     },
     {
-        "BriefDescription": "Average per-thread data fill bandwidth to the=
 L3 cache [GB / sec]",
-        "MetricExpr": "tma_info_l3_cache_fill_bw",
-        "MetricGroup": "Mem;MemoryBW",
-        "MetricName": "tma_info_l3_cache_fill_bw_1t"
+        "BriefDescription": "Memory-Level-Parallelism (average number of L=
1 miss demand load when there is at least one such miss",
+        "MetricExpr": "L1D_PEND_MISS.PENDING / L1D_PEND_MISS.PENDING_CYCLE=
S",
+        "MetricGroup": "Mem;MemoryBW;MemoryBound",
+        "MetricName": "tma_info_memory_mlp",
+        "PublicDescription": "Memory-Level-Parallelism (average number of =
L1 miss demand load when there is at least one such miss. Per-Logical Proce=
ssor)"
     },
     {
-        "BriefDescription": "L3 cache true misses per kilo instruction for=
 retired demand loads",
-        "MetricExpr": "1e3 * MEM_LOAD_RETIRED.L3_MISS / INST_RETIRED.ANY",
-        "MetricGroup": "CacheMisses;Mem",
-        "MetricName": "tma_info_l3mpki"
+        "BriefDescription": "Average Parallel L2 cache miss data reads",
+        "MetricExpr": "OFFCORE_REQUESTS_OUTSTANDING.ALL_DATA_RD / OFFCORE_=
REQUESTS_OUTSTANDING.CYCLES_WITH_DATA_RD",
+        "MetricGroup": "Memory_BW;Offcore",
+        "MetricName": "tma_info_memory_oro_data_l2_mlp"
     },
     {
         "BriefDescription": "Average Latency for L2 cache miss demand Load=
s",
         "MetricExpr": "OFFCORE_REQUESTS_OUTSTANDING.DEMAND_DATA_RD / OFFCO=
RE_REQUESTS.DEMAND_DATA_RD",
         "MetricGroup": "Memory_Lat;Offcore",
-        "MetricName": "tma_info_load_l2_miss_latency"
+        "MetricName": "tma_info_memory_oro_load_l2_miss_latency"
     },
     {
         "BriefDescription": "Average Parallel L2 cache miss demand Loads",
         "MetricExpr": "OFFCORE_REQUESTS_OUTSTANDING.DEMAND_DATA_RD / cpu@O=
FFCORE_REQUESTS_OUTSTANDING.DEMAND_DATA_RD\\,cmask\\=3D1@",
         "MetricGroup": "Memory_BW;Offcore",
-        "MetricName": "tma_info_load_l2_mlp"
+        "MetricName": "tma_info_memory_oro_load_l2_mlp"
     },
     {
         "BriefDescription": "Average Latency for L3 cache miss demand Load=
s",
         "MetricExpr": "cpu@OFFCORE_REQUESTS_OUTSTANDING.DEMAND_DATA_RD\\,u=
mask\\=3D0x10@ / OFFCORE_REQUESTS.L3_MISS_DEMAND_DATA_RD",
         "MetricGroup": "Memory_Lat;Offcore",
-        "MetricName": "tma_info_load_l3_miss_latency"
+        "MetricName": "tma_info_memory_oro_load_l3_miss_latency"
     },
     {
-        "BriefDescription": "Actual Average Latency for L1 data-cache miss=
 demand load operations (in core cycles)",
-        "MetricExpr": "L1D_PEND_MISS.PENDING / (MEM_LOAD_RETIRED.L1_MISS +=
 MEM_LOAD_RETIRED.FB_HIT)",
-        "MetricGroup": "Mem;MemoryBound;MemoryLat",
-        "MetricName": "tma_info_load_miss_real_latency"
+        "BriefDescription": "Average per-thread data fill bandwidth to the=
 L1 data cache [GB / sec]",
+        "MetricExpr": "tma_info_memory_core_l1d_cache_fill_bw",
+        "MetricGroup": "Mem;MemoryBW",
+        "MetricName": "tma_info_memory_thread_l1d_cache_fill_bw_1t"
+    },
+    {
+        "BriefDescription": "Average per-thread data fill bandwidth to the=
 L2 cache [GB / sec]",
+        "MetricExpr": "tma_info_memory_core_l2_cache_fill_bw",
+        "MetricGroup": "Mem;MemoryBW",
+        "MetricName": "tma_info_memory_thread_l2_cache_fill_bw_1t"
+    },
+    {
+        "BriefDescription": "Average per-thread data access bandwidth to t=
he L3 cache [GB / sec]",
+        "MetricExpr": "tma_info_memory_core_l3_cache_access_bw",
+        "MetricGroup": "Mem;MemoryBW;Offcore",
+        "MetricName": "tma_info_memory_thread_l3_cache_access_bw_1t"
+    },
+    {
+        "BriefDescription": "Average per-thread data fill bandwidth to the=
 L3 cache [GB / sec]",
+        "MetricExpr": "tma_info_memory_core_l3_cache_fill_bw",
+        "MetricGroup": "Mem;MemoryBW",
+        "MetricName": "tma_info_memory_thread_l3_cache_fill_bw_1t"
+    },
+    {
+        "BriefDescription": "STLB (2nd level TLB) code speculative misses =
per kilo instruction (misses of any page-size that complete the page walk)"=
,
+        "MetricExpr": "1e3 * ITLB_MISSES.WALK_COMPLETED / INST_RETIRED.ANY=
",
+        "MetricGroup": "Fed;MemoryTLB",
+        "MetricName": "tma_info_memory_tlb_code_stlb_mpki"
     },
     {
         "BriefDescription": "STLB (2nd level TLB) data load speculative mi=
sses per kilo instruction (misses of any page-size that complete the page w=
alk)",
         "MetricExpr": "1e3 * DTLB_LOAD_MISSES.WALK_COMPLETED / INST_RETIRE=
D.ANY",
         "MetricGroup": "Mem;MemoryTLB",
-        "MetricName": "tma_info_load_stlb_mpki"
+        "MetricName": "tma_info_memory_tlb_load_stlb_mpki"
+    },
+    {
+        "BriefDescription": "Utilization of the core's Page Walker(s) serv=
ing STLB misses triggered by instruction/Load/Store accesses",
+        "MetricExpr": "(ITLB_MISSES.WALK_PENDING + DTLB_LOAD_MISSES.WALK_P=
ENDING + DTLB_STORE_MISSES.WALK_PENDING) / (2 * tma_info_core_core_clks)",
+        "MetricGroup": "Mem;MemoryTLB",
+        "MetricName": "tma_info_memory_tlb_page_walks_utilization",
+        "MetricThreshold": "tma_info_memory_tlb_page_walks_utilization > 0=
.5"
+    },
+    {
+        "BriefDescription": "STLB (2nd level TLB) data store speculative m=
isses per kilo instruction (misses of any page-size that complete the page =
walk)",
+        "MetricExpr": "1e3 * DTLB_STORE_MISSES.WALK_COMPLETED / INST_RETIR=
ED.ANY",
+        "MetricGroup": "Mem;MemoryTLB",
+        "MetricName": "tma_info_memory_tlb_store_stlb_mpki"
+    },
+    {
+        "BriefDescription": "Instruction-Level-Parallelism (average number=
 of uops executed when there is execution) per-thread",
+        "MetricExpr": "UOPS_EXECUTED.THREAD / cpu@UOPS_EXECUTED.THREAD\\,c=
mask\\=3D1@",
+        "MetricGroup": "Cor;Pipeline;PortsUtil;SMT",
+        "MetricName": "tma_info_pipeline_execute"
+    },
+    {
+        "BriefDescription": "Average number of Uops retired in cycles wher=
e at least one uop has retired.",
+        "MetricConstraint": "NO_GROUP_EVENTS",
+        "MetricExpr": "tma_retiring * tma_info_thread_slots / cpu@UOPS_RET=
IRED.SLOTS\\,cmask\\=3D1@",
+        "MetricGroup": "Pipeline;Ret",
+        "MetricName": "tma_info_pipeline_retire"
+    },
+    {
+        "BriefDescription": "Measured Average Frequency for unhalted proce=
ssors [GHz]",
+        "MetricExpr": "tma_info_system_turbo_utilization * TSC / 1e9 / dur=
ation_time",
+        "MetricGroup": "Power;Summary",
+        "MetricName": "tma_info_system_average_frequency"
+    },
+    {
+        "BriefDescription": "Average CPU Utilization",
+        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC / TSC",
+        "MetricGroup": "HPC;Summary",
+        "MetricName": "tma_info_system_cpu_utilization"
+    },
+    {
+        "BriefDescription": "Average external Memory Bandwidth Use for rea=
ds and writes [GB / sec]",
+        "MetricExpr": "64 * (UNC_M_CAS_COUNT.RD + UNC_M_CAS_COUNT.WR) / 1e=
9 / duration_time",
+        "MetricGroup": "HPC;Mem;MemoryBW;SoC;tma_issueBW",
+        "MetricName": "tma_info_system_dram_bw_use",
+        "PublicDescription": "Average external Memory Bandwidth Use for re=
ads and writes [GB / sec]. Related metrics: tma_fb_full, tma_info_bottlenec=
k_memory_bandwidth, tma_mem_bandwidth, tma_sq_full"
+    },
+    {
+        "BriefDescription": "Giga Floating Point Operations Per Second",
+        "MetricExpr": "(cpu@FP_ARITH_INST_RETIRED.SCALAR_SINGLE\\,umask\\=
=3D0x03@ + 2 * FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + 4 * cpu@FP_ARITH_=
INST_RETIRED.128B_PACKED_SINGLE\\,umask\\=3D0x18@ + 8 * cpu@FP_ARITH_INST_R=
ETIRED.256B_PACKED_SINGLE\\,umask\\=3D0x60@ + 16 * FP_ARITH_INST_RETIRED.51=
2B_PACKED_SINGLE) / 1e9 / duration_time",
+        "MetricGroup": "Cor;Flops;HPC",
+        "MetricName": "tma_info_system_gflops",
+        "PublicDescription": "Giga Floating Point Operations Per Second. A=
ggregate across all supported options of: FP precisions, scalar and vector =
instructions, vector-width and AMX engine."
+    },
+    {
+        "BriefDescription": "Average IO (network or disk) Bandwidth Use fo=
r Reads [GB / sec]",
+        "MetricExpr": "(UNC_CHA_TOR_INSERTS.IO_HIT_ITOM + UNC_CHA_TOR_INSE=
RTS.IO_MISS_ITOM + UNC_CHA_TOR_INSERTS.IO_HIT_ITOMCACHENEAR + UNC_CHA_TOR_I=
NSERTS.IO_MISS_ITOMCACHENEAR) * 64 / 1e9 / duration_time",
+        "MetricGroup": "IoBW;Mem;Server;SoC",
+        "MetricName": "tma_info_system_io_read_bw"
+    },
+    {
+        "BriefDescription": "Average IO (network or disk) Bandwidth Use fo=
r Writes [GB / sec]",
+        "MetricExpr": "UNC_CHA_TOR_INSERTS.IO_PCIRDCUR * 64 / 1e9 / durati=
on_time",
+        "MetricGroup": "IoBW;Mem;Server;SoC",
+        "MetricName": "tma_info_system_io_write_bw"
+    },
+    {
+        "BriefDescription": "Instructions per Far Branch ( Far Branches ap=
ply upon transition from application to operating system, handling interrup=
ts, exceptions) [lower number means higher occurrence rate]",
+        "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.FAR_BRANCH:u",
+        "MetricGroup": "Branches;OS",
+        "MetricName": "tma_info_system_ipfarbranch",
+        "MetricThreshold": "tma_info_system_ipfarbranch < 1e6"
+    },
+    {
+        "BriefDescription": "Cycles Per Instruction for the Operating Syst=
em (OS) Kernel mode",
+        "MetricExpr": "CPU_CLK_UNHALTED.THREAD_P:k / INST_RETIRED.ANY_P:k"=
,
+        "MetricGroup": "OS",
+        "MetricName": "tma_info_system_kernel_cpi"
+    },
+    {
+        "BriefDescription": "Fraction of cycles spent in the Operating Sys=
tem (OS) Kernel mode",
+        "MetricExpr": "CPU_CLK_UNHALTED.THREAD_P:k / CPU_CLK_UNHALTED.THRE=
AD",
+        "MetricGroup": "OS",
+        "MetricName": "tma_info_system_kernel_utilization",
+        "MetricThreshold": "tma_info_system_kernel_utilization > 0.05"
     },
     {
         "BriefDescription": "Average latency of data read request to exter=
nal DRAM memory [in nanoseconds]",
         "MetricExpr": "1e9 * (UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_DDR / UNC_=
CHA_TOR_INSERTS.IA_MISS_DRD_DDR) / cha_0@event\\=3D0x0@",
         "MetricGroup": "Mem;MemoryLat;Server;SoC",
-        "MetricName": "tma_info_mem_dram_read_latency",
+        "MetricName": "tma_info_system_mem_dram_read_latency",
         "PublicDescription": "Average latency of data read request to exte=
rnal DRAM memory [in nanoseconds]. Accounts for demand loads and L1/L2 data=
-read prefetches"
     },
     {
         "BriefDescription": "Average number of parallel data read requests=
 to external memory",
         "MetricExpr": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD / UNC_CHA_TOR_OCC=
UPANCY.IA_MISS_DRD@thresh\\=3D1@",
         "MetricGroup": "Mem;MemoryBW;SoC",
-        "MetricName": "tma_info_mem_parallel_reads",
+        "MetricName": "tma_info_system_mem_parallel_reads",
         "PublicDescription": "Average number of parallel data read request=
s to external memory. Accounts for demand loads and L1/L2 prefetches"
     },
     {
         "BriefDescription": "Average latency of data read request to exter=
nal 3D X-Point memory [in nanoseconds]",
         "MetricExpr": "(1e9 * (UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_PMM / UNC=
_CHA_TOR_INSERTS.IA_MISS_DRD_PMM) / cha_0@event\\=3D0x0@ if #has_pmem > 0 e=
lse 0)",
         "MetricGroup": "Mem;MemoryLat;Server;SoC",
-        "MetricName": "tma_info_mem_pmm_read_latency",
+        "MetricName": "tma_info_system_mem_pmm_read_latency",
         "PublicDescription": "Average latency of data read request to exte=
rnal 3D X-Point memory [in nanoseconds]. Accounts for demand loads and L1/L=
2 data-read prefetches"
     },
     {
         "BriefDescription": "Average latency of data read request to exter=
nal memory (in nanoseconds)",
-        "MetricExpr": "1e9 * (UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD / UNC_CHA_=
TOR_INSERTS.IA_MISS_DRD) / (tma_info_socket_clks / duration_time)",
+        "MetricExpr": "1e9 * (UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD / UNC_CHA_=
TOR_INSERTS.IA_MISS_DRD) / (tma_info_system_socket_clks / duration_time)",
         "MetricGroup": "Mem;MemoryLat;SoC",
-        "MetricName": "tma_info_mem_read_latency",
+        "MetricName": "tma_info_system_mem_read_latency",
         "PublicDescription": "Average latency of data read request to exte=
rnal memory (in nanoseconds). Accounts for demand loads and L1/L2 prefetche=
s. ([RKL+]memory-controller only)"
     },
-    {
-        "BriefDescription": "Total pipeline cost of (external) Memory Band=
width related bottlenecks",
-        "MetricExpr": "100 * tma_memory_bound * (tma_dram_bound / (tma_dra=
m_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_pmm_bound + tma_=
store_bound) * (tma_mem_bandwidth / (tma_mem_bandwidth + tma_mem_latency)) =
+ tma_l3_bound / (tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bou=
nd + tma_pmm_bound + tma_store_bound) * (tma_sq_full / (tma_contested_acces=
ses + tma_data_sharing + tma_l3_hit_latency + tma_sq_full))) + tma_l1_bound=
 / (tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_pmm_b=
ound + tma_store_bound) * (tma_fb_full / (tma_4k_aliasing + tma_dtlb_load +=
 tma_fb_full + tma_lock_latency + tma_split_loads + tma_store_fwd_blk))",
-        "MetricGroup": "Mem;MemoryBW;Offcore;tma_issueBW",
-        "MetricName": "tma_info_memory_bandwidth",
-        "MetricThreshold": "tma_info_memory_bandwidth > 20",
-        "PublicDescription": "Total pipeline cost of (external) Memory Ban=
dwidth related bottlenecks. Related metrics: tma_fb_full, tma_info_dram_bw_=
use, tma_mem_bandwidth, tma_sq_full"
-    },
-    {
-        "BriefDescription": "Total pipeline cost of Memory Address Transla=
tion related bottlenecks (data-side TLBs)",
-        "MetricConstraint": "NO_GROUP_EVENTS",
-        "MetricExpr": "100 * tma_memory_bound * (tma_l1_bound / max(tma_me=
mory_bound, tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + t=
ma_pmm_bound + tma_store_bound) * (tma_dtlb_load / max(tma_l1_bound, tma_4k=
_aliasing + tma_dtlb_load + tma_fb_full + tma_lock_latency + tma_split_load=
s + tma_store_fwd_blk)) + tma_store_bound / (tma_dram_bound + tma_l1_bound =
+ tma_l2_bound + tma_l3_bound + tma_pmm_bound + tma_store_bound) * (tma_dtl=
b_store / (tma_dtlb_store + tma_false_sharing + tma_split_stores + tma_stor=
e_latency + tma_streaming_stores)))",
-        "MetricGroup": "Mem;MemoryTLB;Offcore;tma_issueTLB",
-        "MetricName": "tma_info_memory_data_tlbs",
-        "MetricThreshold": "tma_info_memory_data_tlbs > 20",
-        "PublicDescription": "Total pipeline cost of Memory Address Transl=
ation related bottlenecks (data-side TLBs). Related metrics: tma_dtlb_load,=
 tma_dtlb_store"
-    },
-    {
-        "BriefDescription": "Total pipeline cost of Memory Latency related=
 bottlenecks (external memory and off-core caches)",
-        "MetricConstraint": "NO_GROUP_EVENTS",
-        "MetricExpr": "100 * tma_memory_bound * (tma_dram_bound / (tma_dra=
m_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_pmm_bound + tma_=
store_bound) * (tma_mem_latency / (tma_mem_bandwidth + tma_mem_latency)) + =
tma_l3_bound / (tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound=
 + tma_pmm_bound + tma_store_bound) * (tma_l3_hit_latency / (tma_contested_=
accesses + tma_data_sharing + tma_l3_hit_latency + tma_sq_full)) + tma_l2_b=
ound / (tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_p=
mm_bound + tma_store_bound))",
-        "MetricGroup": "Mem;MemoryLat;Offcore;tma_issueLat",
-        "MetricName": "tma_info_memory_latency",
-        "MetricThreshold": "tma_info_memory_latency > 20",
-        "PublicDescription": "Total pipeline cost of Memory Latency relate=
d bottlenecks (external memory and off-core caches). Related metrics: tma_l=
3_hit_latency, tma_mem_latency"
-    },
-    {
-        "BriefDescription": "Total pipeline cost of Branch Misprediction r=
elated bottlenecks",
-        "MetricConstraint": "NO_GROUP_EVENTS",
-        "MetricExpr": "100 * (tma_branch_mispredicts + tma_fetch_latency *=
 tma_mispredicts_resteers / (tma_branch_resteers + tma_dsb_switches + tma_i=
cache_misses + tma_itlb_misses + tma_lcp + tma_ms_switches))",
-        "MetricGroup": "Bad;BadSpec;BrMispredicts;tma_issueBM",
-        "MetricName": "tma_info_mispredictions",
-        "MetricThreshold": "tma_info_mispredictions > 20",
-        "PublicDescription": "Total pipeline cost of Branch Misprediction =
related bottlenecks. Related metrics: tma_branch_mispredicts, tma_info_bran=
ch_misprediction_cost, tma_mispredicts_resteers"
-    },
-    {
-        "BriefDescription": "Memory-Level-Parallelism (average number of L=
1 miss demand load when there is at least one such miss",
-        "MetricExpr": "L1D_PEND_MISS.PENDING / L1D_PEND_MISS.PENDING_CYCLE=
S",
-        "MetricGroup": "Mem;MemoryBW;MemoryBound",
-        "MetricName": "tma_info_mlp",
-        "PublicDescription": "Memory-Level-Parallelism (average number of =
L1 miss demand load when there is at least one such miss. Per-Logical Proce=
ssor)"
-    },
-    {
-        "BriefDescription": "Fraction of branches of other types (not indi=
vidually covered by other metrics in Info.Branches group)",
-        "MetricExpr": "1 - (tma_info_cond_nt + tma_info_cond_tk + tma_info=
_callret + tma_info_jump)",
-        "MetricGroup": "Bad;Branches",
-        "MetricName": "tma_info_other_branches"
-    },
-    {
-        "BriefDescription": "Utilization of the core's Page Walker(s) serv=
ing STLB misses triggered by instruction/Load/Store accesses",
-        "MetricExpr": "(ITLB_MISSES.WALK_PENDING + DTLB_LOAD_MISSES.WALK_P=
ENDING + DTLB_STORE_MISSES.WALK_PENDING) / (2 * tma_info_core_clks)",
-        "MetricGroup": "Mem;MemoryTLB",
-        "MetricName": "tma_info_page_walks_utilization",
-        "MetricThreshold": "tma_info_page_walks_utilization > 0.5"
-    },
     {
         "BriefDescription": "Average 3DXP Memory Bandwidth Use for reads [=
GB / sec]",
         "MetricExpr": "(64 * UNC_M_PMM_RPQ_INSERTS / 1e9 / duration_time i=
f #has_pmem > 0 else 0)",
         "MetricGroup": "Mem;MemoryBW;Server;SoC",
-        "MetricName": "tma_info_pmm_read_bw"
+        "MetricName": "tma_info_system_pmm_read_bw"
     },
     {
         "BriefDescription": "Average 3DXP Memory Bandwidth Use for Writes =
[GB / sec]",
         "MetricExpr": "(64 * UNC_M_PMM_WPQ_INSERTS / 1e9 / duration_time i=
f #has_pmem > 0 else 0)",
         "MetricGroup": "Mem;MemoryBW;Server;SoC",
-        "MetricName": "tma_info_pmm_write_bw"
+        "MetricName": "tma_info_system_pmm_write_bw"
     },
     {
         "BriefDescription": "Fraction of Core cycles where the core was ru=
nning with power-delivery for baseline license level 0",
-        "MetricExpr": "CORE_POWER.LVL0_TURBO_LICENSE / tma_info_core_clks"=
,
+        "MetricExpr": "CORE_POWER.LVL0_TURBO_LICENSE / tma_info_core_core_=
clks",
         "MetricGroup": "Power",
-        "MetricName": "tma_info_power_license0_utilization",
+        "MetricName": "tma_info_system_power_license0_utilization",
         "PublicDescription": "Fraction of Core cycles where the core was r=
unning with power-delivery for baseline license level 0.  This includes non=
-AVX codes, SSE, AVX 128-bit, and low-current AVX 256-bit codes."
     },
     {
         "BriefDescription": "Fraction of Core cycles where the core was ru=
nning with power-delivery for license level 1",
-        "MetricExpr": "CORE_POWER.LVL1_TURBO_LICENSE / tma_info_core_clks"=
,
+        "MetricExpr": "CORE_POWER.LVL1_TURBO_LICENSE / tma_info_core_core_=
clks",
         "MetricGroup": "Power",
-        "MetricName": "tma_info_power_license1_utilization",
-        "MetricThreshold": "tma_info_power_license1_utilization > 0.5",
+        "MetricName": "tma_info_system_power_license1_utilization",
+        "MetricThreshold": "tma_info_system_power_license1_utilization > 0=
.5",
         "PublicDescription": "Fraction of Core cycles where the core was r=
unning with power-delivery for license level 1.  This includes high current=
 AVX 256-bit instructions as well as low current AVX 512-bit instructions."
     },
     {
         "BriefDescription": "Fraction of Core cycles where the core was ru=
nning with power-delivery for license level 2 (introduced in SKX)",
-        "MetricExpr": "CORE_POWER.LVL2_TURBO_LICENSE / tma_info_core_clks"=
,
+        "MetricExpr": "CORE_POWER.LVL2_TURBO_LICENSE / tma_info_core_core_=
clks",
         "MetricGroup": "Power",
-        "MetricName": "tma_info_power_license2_utilization",
-        "MetricThreshold": "tma_info_power_license2_utilization > 0.5",
+        "MetricName": "tma_info_system_power_license2_utilization",
+        "MetricThreshold": "tma_info_system_power_license2_utilization > 0=
.5",
         "PublicDescription": "Fraction of Core cycles where the core was r=
unning with power-delivery for license level 2 (introduced in SKX).  This i=
ncludes high current AVX 512-bit instructions."
     },
-    {
-        "BriefDescription": "Average number of Uops retired in cycles wher=
e at least one uop has retired.",
-        "MetricConstraint": "NO_GROUP_EVENTS",
-        "MetricExpr": "tma_retiring * tma_info_slots / cpu@UOPS_RETIRED.SL=
OTS\\,cmask\\=3D1@",
-        "MetricGroup": "Pipeline;Ret",
-        "MetricName": "tma_info_retire"
-    },
-    {
-        "BriefDescription": "Total issue-pipeline slots (per-Physical Core=
 till ICL; per-Logical Processor ICL onward)",
-        "MetricExpr": "TOPDOWN.SLOTS",
-        "MetricGroup": "TmaL1;tma_L1_group",
-        "MetricName": "tma_info_slots"
-    },
-    {
-        "BriefDescription": "Fraction of Physical Core issue-slots utilize=
d by this Logical Processor",
-        "MetricExpr": "(tma_info_slots / (TOPDOWN.SLOTS / 2) if #SMT_on el=
se 1)",
-        "MetricGroup": "SMT;TmaL1;tma_L1_group",
-        "MetricName": "tma_info_slots_utilization"
-    },
     {
         "BriefDescription": "Fraction of cycles where both hardware Logica=
l Processors were active",
         "MetricExpr": "(1 - CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_U=
NHALTED.REF_DISTRIBUTED if #SMT_on else 0)",
         "MetricGroup": "SMT",
-        "MetricName": "tma_info_smt_2t_utilization"
+        "MetricName": "tma_info_system_smt_2t_utilization"
     },
     {
         "BriefDescription": "Socket actual clocks when any core is active =
on that socket",
         "MetricExpr": "cha_0@event\\=3D0x0@",
         "MetricGroup": "SoC",
-        "MetricName": "tma_info_socket_clks"
-    },
-    {
-        "BriefDescription": "STLB (2nd level TLB) data store speculative m=
isses per kilo instruction (misses of any page-size that complete the page =
walk)",
-        "MetricExpr": "1e3 * DTLB_STORE_MISSES.WALK_COMPLETED / INST_RETIR=
ED.ANY",
-        "MetricGroup": "Mem;MemoryTLB",
-        "MetricName": "tma_info_store_stlb_mpki"
+        "MetricName": "tma_info_system_socket_clks"
     },
     {
         "BriefDescription": "Average Frequency Utilization relative nomina=
l frequency",
-        "MetricExpr": "tma_info_clks / CPU_CLK_UNHALTED.REF_TSC",
+        "MetricExpr": "tma_info_thread_clks / CPU_CLK_UNHALTED.REF_TSC",
         "MetricGroup": "Power",
-        "MetricName": "tma_info_turbo_utilization"
+        "MetricName": "tma_info_system_turbo_utilization"
+    },
+    {
+        "BriefDescription": "Per-Logical Processor actual clocks when the =
Logical Processor is active.",
+        "MetricExpr": "CPU_CLK_UNHALTED.THREAD",
+        "MetricGroup": "Pipeline",
+        "MetricName": "tma_info_thread_clks"
+    },
+    {
+        "BriefDescription": "Cycles Per Instruction (per Logical Processor=
)",
+        "MetricExpr": "1 / tma_info_thread_ipc",
+        "MetricGroup": "Mem;Pipeline",
+        "MetricName": "tma_info_thread_cpi"
+    },
+    {
+        "BriefDescription": "The ratio of Executed- by Issued-Uops",
+        "MetricExpr": "UOPS_EXECUTED.THREAD / UOPS_ISSUED.ANY",
+        "MetricGroup": "Cor;Pipeline",
+        "MetricName": "tma_info_thread_execute_per_issue",
+        "PublicDescription": "The ratio of Executed- by Issued-Uops. Ratio=
 > 1 suggests high rate of uop micro-fusions. Ratio < 1 suggest high rate o=
f \"execute\" at rename stage."
+    },
+    {
+        "BriefDescription": "Instructions Per Cycle (per Logical Processor=
)",
+        "MetricExpr": "INST_RETIRED.ANY / tma_info_thread_clks",
+        "MetricGroup": "Ret;Summary",
+        "MetricName": "tma_info_thread_ipc"
+    },
+    {
+        "BriefDescription": "Total issue-pipeline slots (per-Physical Core=
 till ICL; per-Logical Processor ICL onward)",
+        "MetricExpr": "TOPDOWN.SLOTS",
+        "MetricGroup": "TmaL1;tma_L1_group",
+        "MetricName": "tma_info_thread_slots"
+    },
+    {
+        "BriefDescription": "Fraction of Physical Core issue-slots utilize=
d by this Logical Processor",
+        "MetricExpr": "(tma_info_thread_slots / (TOPDOWN.SLOTS / 2) if #SM=
T_on else 1)",
+        "MetricGroup": "SMT;TmaL1;tma_L1_group",
+        "MetricName": "tma_info_thread_slots_utilization"
     },
     {
         "BriefDescription": "Uops Per Instruction",
-        "MetricExpr": "tma_retiring * tma_info_slots / INST_RETIRED.ANY",
+        "MetricExpr": "tma_retiring * tma_info_thread_slots / INST_RETIRED=
.ANY",
         "MetricGroup": "Pipeline;Ret;Retire",
-        "MetricName": "tma_info_uoppi",
-        "MetricThreshold": "tma_info_uoppi > 1.05"
+        "MetricName": "tma_info_thread_uoppi",
+        "MetricThreshold": "tma_info_thread_uoppi > 1.05"
     },
     {
         "BriefDescription": "Instruction per taken branch",
-        "MetricExpr": "tma_retiring * tma_info_slots / BR_INST_RETIRED.NEA=
R_TAKEN",
+        "MetricExpr": "tma_retiring * tma_info_thread_slots / BR_INST_RETI=
RED.NEAR_TAKEN",
         "MetricGroup": "Branches;Fed;FetchBW",
-        "MetricName": "tma_info_uptb",
-        "MetricThreshold": "tma_info_uptb < 7.5"
+        "MetricName": "tma_info_thread_uptb",
+        "MetricThreshold": "tma_info_thread_uptb < 7.5"
     },
     {
         "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to Instruction TLB (ITLB) misses",
-        "MetricExpr": "ICACHE_64B.IFTAG_STALL / tma_info_clks",
+        "MetricExpr": "ICACHE_64B.IFTAG_STALL / tma_info_thread_clks",
         "MetricGroup": "BigFoot;FetchLat;MemoryTLB;TopdownL3;tma_L3_group;=
tma_fetch_latency_group",
         "MetricName": "tma_itlb_misses",
         "MetricThreshold": "tma_itlb_misses > 0.05 & (tma_fetch_latency > =
0.1 & tma_frontend_bound > 0.15)",
@@ -1101,7 +1347,7 @@
     },
     {
         "BriefDescription": "This metric estimates how often the CPU was s=
talled without loads missing the L1 data cache",
-        "MetricExpr": "max((CYCLE_ACTIVITY.STALLS_MEM_ANY - CYCLE_ACTIVITY=
.STALLS_L1D_MISS) / tma_info_clks, 0)",
+        "MetricExpr": "max((CYCLE_ACTIVITY.STALLS_MEM_ANY - CYCLE_ACTIVITY=
.STALLS_L1D_MISS) / tma_info_thread_clks, 0)",
         "MetricGroup": "CacheMisses;MemoryBound;TmaL3mem;TopdownL3;tma_L3_=
group;tma_issueL1;tma_issueMC;tma_memory_bound_group",
         "MetricName": "tma_l1_bound",
         "MetricThreshold": "tma_l1_bound > 0.1 & (tma_memory_bound > 0.2 &=
 tma_backend_bound > 0.2)",
@@ -1111,7 +1357,7 @@
     {
         "BriefDescription": "This metric estimates how often the CPU was s=
talled due to L2 cache accesses by loads",
         "MetricConstraint": "NO_GROUP_EVENTS",
-        "MetricExpr": "MEM_LOAD_RETIRED.L2_HIT * (1 + MEM_LOAD_RETIRED.FB_=
HIT / MEM_LOAD_RETIRED.L1_MISS) / (MEM_LOAD_RETIRED.L2_HIT * (1 + MEM_LOAD_=
RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS) + L1D_PEND_MISS.FB_FULL_PERIODS)=
 * ((CYCLE_ACTIVITY.STALLS_L1D_MISS - CYCLE_ACTIVITY.STALLS_L2_MISS) / tma_=
info_clks)",
+        "MetricExpr": "MEM_LOAD_RETIRED.L2_HIT * (1 + MEM_LOAD_RETIRED.FB_=
HIT / MEM_LOAD_RETIRED.L1_MISS) / (MEM_LOAD_RETIRED.L2_HIT * (1 + MEM_LOAD_=
RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS) + L1D_PEND_MISS.FB_FULL_PERIODS)=
 * ((CYCLE_ACTIVITY.STALLS_L1D_MISS - CYCLE_ACTIVITY.STALLS_L2_MISS) / tma_=
info_thread_clks)",
         "MetricGroup": "CacheMisses;MemoryBound;TmaL3mem;TopdownL3;tma_L3_=
group;tma_memory_bound_group",
         "MetricName": "tma_l2_bound",
         "MetricThreshold": "tma_l2_bound > 0.05 & (tma_memory_bound > 0.2 =
& tma_backend_bound > 0.2)",
@@ -1120,7 +1366,7 @@
     },
     {
         "BriefDescription": "This metric estimates how often the CPU was s=
talled due to loads accesses to L3 cache or contended with a sibling Core",
-        "MetricExpr": "(CYCLE_ACTIVITY.STALLS_L2_MISS - CYCLE_ACTIVITY.STA=
LLS_L3_MISS) / tma_info_clks",
+        "MetricExpr": "(CYCLE_ACTIVITY.STALLS_L2_MISS - CYCLE_ACTIVITY.STA=
LLS_L3_MISS) / tma_info_thread_clks",
         "MetricGroup": "CacheMisses;MemoryBound;TmaL3mem;TopdownL3;tma_L3_=
group;tma_memory_bound_group",
         "MetricName": "tma_l3_bound",
         "MetricThreshold": "tma_l3_bound > 0.05 & (tma_memory_bound > 0.2 =
& tma_backend_bound > 0.2)",
@@ -1129,20 +1375,20 @@
     },
     {
         "BriefDescription": "This metric represents fraction of cycles wit=
h demand load accesses that hit the L3 cache under unloaded scenarios (poss=
ibly L3 latency limited)",
-        "MetricExpr": "19 * tma_info_average_frequency * MEM_LOAD_RETIRED.=
L3_HIT * (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS / 2) / tma=
_info_clks",
+        "MetricExpr": "19 * tma_info_system_average_frequency * MEM_LOAD_R=
ETIRED.L3_HIT * (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS / 2=
) / tma_info_thread_clks",
         "MetricGroup": "MemoryLat;TopdownL4;tma_L4_group;tma_issueLat;tma_=
l3_bound_group",
         "MetricName": "tma_l3_hit_latency",
         "MetricThreshold": "tma_l3_hit_latency > 0.1 & (tma_l3_bound > 0.0=
5 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
-        "PublicDescription": "This metric represents fraction of cycles wi=
th demand load accesses that hit the L3 cache under unloaded scenarios (pos=
sibly L3 latency limited).  Avoiding private cache misses (i.e. L2 misses/L=
3 hits) will improve the latency; reduce contention with sibling physical c=
ores and increase performance.  Note the value of this node may overlap wit=
h its siblings. Sample with: MEM_LOAD_RETIRED.L3_HIT_PS. Related metrics: t=
ma_info_memory_latency, tma_mem_latency",
+        "PublicDescription": "This metric represents fraction of cycles wi=
th demand load accesses that hit the L3 cache under unloaded scenarios (pos=
sibly L3 latency limited).  Avoiding private cache misses (i.e. L2 misses/L=
3 hits) will improve the latency; reduce contention with sibling physical c=
ores and increase performance.  Note the value of this node may overlap wit=
h its siblings. Sample with: MEM_LOAD_RETIRED.L3_HIT_PS. Related metrics: t=
ma_info_bottleneck_memory_latency, tma_mem_latency",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "This metric represents fraction of cycles CPU=
 was stalled due to Length Changing Prefixes (LCPs)",
-        "MetricExpr": "ILD_STALL.LCP / tma_info_clks",
+        "MetricExpr": "ILD_STALL.LCP / tma_info_thread_clks",
         "MetricGroup": "FetchLat;TopdownL3;tma_L3_group;tma_fetch_latency_=
group;tma_issueFB",
         "MetricName": "tma_lcp",
         "MetricThreshold": "tma_lcp > 0.05 & (tma_fetch_latency > 0.1 & tm=
a_frontend_bound > 0.15)",
-        "PublicDescription": "This metric represents fraction of cycles CP=
U was stalled due to Length Changing Prefixes (LCPs). Using proper compiler=
 flags or Intel Compiler by default will certainly avoid this. #Link: Optim=
ization Guide about LCP BKMs. Related metrics: tma_dsb_switches, tma_fetch_=
bandwidth, tma_info_dsb_coverage, tma_info_dsb_misses, tma_info_iptb",
+        "PublicDescription": "This metric represents fraction of cycles CP=
U was stalled due to Length Changing Prefixes (LCPs). Using proper compiler=
 flags or Intel Compiler by default will certainly avoid this. #Link: Optim=
ization Guide about LCP BKMs. Related metrics: tma_dsb_switches, tma_fetch_=
bandwidth, tma_info_botlnk_l2_dsb_misses, tma_info_frontend_dsb_coverage, t=
ma_info_inst_mix_iptb",
         "ScaleUnit": "100%"
     },
     {
@@ -1157,7 +1403,7 @@
     },
     {
         "BriefDescription": "This metric represents Core fraction of cycle=
s CPU dispatched uops on execution port for Load operations",
-        "MetricExpr": "UOPS_DISPATCHED.PORT_2_3 / (2 * tma_info_core_clks)=
",
+        "MetricExpr": "UOPS_DISPATCHED.PORT_2_3 / (2 * tma_info_core_core_=
clks)",
         "MetricGroup": "TopdownL5;tma_L5_group;tma_ports_utilized_3m_group=
",
         "MetricName": "tma_load_op_utilization",
         "MetricThreshold": "tma_load_op_utilization > 0.6",
@@ -1174,7 +1420,7 @@
     },
     {
         "BriefDescription": "This metric estimates the fraction of cycles =
where the Second-level TLB (STLB) was missed by load accesses, performing a=
 hardware page walk",
-        "MetricExpr": "DTLB_LOAD_MISSES.WALK_ACTIVE / tma_info_clks",
+        "MetricExpr": "DTLB_LOAD_MISSES.WALK_ACTIVE / tma_info_thread_clks=
",
         "MetricGroup": "MemoryTLB;TopdownL5;tma_L5_group;tma_dtlb_load_gro=
up",
         "MetricName": "tma_load_stlb_miss",
         "MetricThreshold": "tma_load_stlb_miss > 0.05 & (tma_dtlb_load > 0=
.1 & (tma_l1_bound > 0.1 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.=
2)))",
@@ -1182,7 +1428,7 @@
     },
     {
         "BriefDescription": "This metric estimates fraction of cycles whil=
e the memory subsystem was handling loads from local memory",
-        "MetricExpr": "43.5 * tma_info_average_frequency * MEM_LOAD_L3_MIS=
S_RETIRED.LOCAL_DRAM * (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_M=
ISS / 2) / tma_info_clks",
+        "MetricExpr": "43.5 * tma_info_system_average_frequency * MEM_LOAD=
_L3_MISS_RETIRED.LOCAL_DRAM * (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIR=
ED.L1_MISS / 2) / tma_info_thread_clks",
         "MetricGroup": "Server;TopdownL5;tma_L5_group;tma_mem_latency_grou=
p",
         "MetricName": "tma_local_dram",
         "MetricThreshold": "tma_local_dram > 0.1 & (tma_mem_latency > 0.1 =
& (tma_dram_bound > 0.1 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2=
)))",
@@ -1192,7 +1438,7 @@
     {
         "BriefDescription": "This metric represents fraction of cycles the=
 CPU spent handling cache misses due to lock operations",
         "MetricConstraint": "NO_GROUP_EVENTS",
-        "MetricExpr": "(16 * max(0, MEM_INST_RETIRED.LOCK_LOADS - L2_RQSTS=
.ALL_RFO) + MEM_INST_RETIRED.LOCK_LOADS / MEM_INST_RETIRED.ALL_STORES * (10=
 * L2_RQSTS.RFO_HIT + min(CPU_CLK_UNHALTED.THREAD, OFFCORE_REQUESTS_OUTSTAN=
DING.CYCLES_WITH_DEMAND_RFO))) / tma_info_clks",
+        "MetricExpr": "(16 * max(0, MEM_INST_RETIRED.LOCK_LOADS - L2_RQSTS=
.ALL_RFO) + MEM_INST_RETIRED.LOCK_LOADS / MEM_INST_RETIRED.ALL_STORES * (10=
 * L2_RQSTS.RFO_HIT + min(CPU_CLK_UNHALTED.THREAD, OFFCORE_REQUESTS_OUTSTAN=
DING.CYCLES_WITH_DEMAND_RFO))) / tma_info_thread_clks",
         "MetricGroup": "Offcore;TopdownL4;tma_L4_group;tma_issueRFO;tma_l1=
_bound_group",
         "MetricName": "tma_lock_latency",
         "MetricThreshold": "tma_lock_latency > 0.2 & (tma_l1_bound > 0.1 &=
 (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
@@ -1211,20 +1457,20 @@
     },
     {
         "BriefDescription": "This metric estimates fraction of cycles wher=
e the core's performance was likely hurt due to approaching bandwidth limit=
s of external memory (DRAM)",
-        "MetricExpr": "min(CPU_CLK_UNHALTED.THREAD, cpu@OFFCORE_REQUESTS_O=
UTSTANDING.ALL_DATA_RD\\,cmask\\=3D4@) / tma_info_clks",
+        "MetricExpr": "min(CPU_CLK_UNHALTED.THREAD, cpu@OFFCORE_REQUESTS_O=
UTSTANDING.ALL_DATA_RD\\,cmask\\=3D4@) / tma_info_thread_clks",
         "MetricGroup": "MemoryBW;Offcore;TopdownL4;tma_L4_group;tma_dram_b=
ound_group;tma_issueBW",
         "MetricName": "tma_mem_bandwidth",
         "MetricThreshold": "tma_mem_bandwidth > 0.2 & (tma_dram_bound > 0.=
1 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
-        "PublicDescription": "This metric estimates fraction of cycles whe=
re the core's performance was likely hurt due to approaching bandwidth limi=
ts of external memory (DRAM).  The underlying heuristic assumes that a simi=
lar off-core traffic is generated by all IA cores. This metric does not agg=
regate non-data-read requests by this logical processor; requests from othe=
r IA Logical Processors/Physical Cores/sockets; or other non-IA devices lik=
e GPU; hence the maximum external memory bandwidth limits may or may not be=
 approached when this metric is flagged (see Uncore counters for that). Rel=
ated metrics: tma_fb_full, tma_info_dram_bw_use, tma_info_memory_bandwidth,=
 tma_sq_full",
+        "PublicDescription": "This metric estimates fraction of cycles whe=
re the core's performance was likely hurt due to approaching bandwidth limi=
ts of external memory (DRAM).  The underlying heuristic assumes that a simi=
lar off-core traffic is generated by all IA cores. This metric does not agg=
regate non-data-read requests by this logical processor; requests from othe=
r IA Logical Processors/Physical Cores/sockets; or other non-IA devices lik=
e GPU; hence the maximum external memory bandwidth limits may or may not be=
 approached when this metric is flagged (see Uncore counters for that). Rel=
ated metrics: tma_fb_full, tma_info_bottleneck_memory_bandwidth, tma_info_s=
ystem_dram_bw_use, tma_sq_full",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "This metric estimates fraction of cycles wher=
e the performance was likely hurt due to latency from external memory (DRAM=
)",
-        "MetricExpr": "min(CPU_CLK_UNHALTED.THREAD, OFFCORE_REQUESTS_OUTST=
ANDING.CYCLES_WITH_DATA_RD) / tma_info_clks - tma_mem_bandwidth",
+        "MetricExpr": "min(CPU_CLK_UNHALTED.THREAD, OFFCORE_REQUESTS_OUTST=
ANDING.CYCLES_WITH_DATA_RD) / tma_info_thread_clks - tma_mem_bandwidth",
         "MetricGroup": "MemoryLat;Offcore;TopdownL4;tma_L4_group;tma_dram_=
bound_group;tma_issueLat",
         "MetricName": "tma_mem_latency",
         "MetricThreshold": "tma_mem_latency > 0.1 & (tma_dram_bound > 0.1 =
& (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
-        "PublicDescription": "This metric estimates fraction of cycles whe=
re the performance was likely hurt due to latency from external memory (DRA=
M).  This metric does not aggregate requests from other Logical Processors/=
Physical Cores/sockets (see Uncore counters for that). Related metrics: tma=
_info_memory_latency, tma_l3_hit_latency",
+        "PublicDescription": "This metric estimates fraction of cycles whe=
re the performance was likely hurt due to latency from external memory (DRA=
M).  This metric does not aggregate requests from other Logical Processors/=
Physical Cores/sockets (see Uncore counters for that). Related metrics: tma=
_info_bottleneck_memory_latency, tma_l3_hit_latency",
         "ScaleUnit": "100%"
     },
     {
@@ -1248,7 +1494,7 @@
     },
     {
         "BriefDescription": "This metric represents fraction of slots the =
CPU was retiring uops fetched by the Microcode Sequencer (MS) unit",
-        "MetricExpr": "tma_retiring * tma_info_slots / UOPS_ISSUED.ANY * I=
DQ.MS_UOPS / tma_info_slots",
+        "MetricExpr": "tma_retiring * tma_info_thread_slots / UOPS_ISSUED.=
ANY * IDQ.MS_UOPS / tma_info_thread_slots",
         "MetricGroup": "MicroSeq;TopdownL3;tma_L3_group;tma_heavy_operatio=
ns_group;tma_issueMC;tma_issueMS",
         "MetricName": "tma_microcode_sequencer",
         "MetricThreshold": "tma_microcode_sequencer > 0.05 & tma_heavy_ope=
rations > 0.1",
@@ -1257,28 +1503,28 @@
     },
     {
         "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to Branch Resteers as a result of Branch Misprediction=
 at execution stage",
-        "MetricExpr": "BR_MISP_RETIRED.ALL_BRANCHES / (BR_MISP_RETIRED.ALL=
_BRANCHES + MACHINE_CLEARS.COUNT) * INT_MISC.CLEAR_RESTEER_CYCLES / tma_inf=
o_clks",
+        "MetricExpr": "BR_MISP_RETIRED.ALL_BRANCHES / (BR_MISP_RETIRED.ALL=
_BRANCHES + MACHINE_CLEARS.COUNT) * INT_MISC.CLEAR_RESTEER_CYCLES / tma_inf=
o_thread_clks",
         "MetricGroup": "BadSpec;BrMispredicts;TopdownL4;tma_L4_group;tma_b=
ranch_resteers_group;tma_issueBM",
         "MetricName": "tma_mispredicts_resteers",
         "MetricThreshold": "tma_mispredicts_resteers > 0.05 & (tma_branch_=
resteers > 0.05 & (tma_fetch_latency > 0.1 & tma_frontend_bound > 0.15))",
-        "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to Branch Resteers as a result of Branch Mispredictio=
n at execution stage. Sample with: INT_MISC.CLEAR_RESTEER_CYCLES. Related m=
etrics: tma_branch_mispredicts, tma_info_branch_misprediction_cost, tma_inf=
o_mispredictions",
+        "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to Branch Resteers as a result of Branch Mispredictio=
n at execution stage. Sample with: INT_MISC.CLEAR_RESTEER_CYCLES. Related m=
etrics: tma_branch_mispredicts, tma_info_bad_spec_branch_misprediction_cost=
, tma_info_bottleneck_mispredictions",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "This metric represents Core fraction of cycle=
s in which CPU was likely limited due to the MITE pipeline (the legacy deco=
de pipeline)",
-        "MetricExpr": "(IDQ.MITE_CYCLES_ANY - IDQ.MITE_CYCLES_OK) / tma_in=
fo_core_clks / 2",
+        "MetricExpr": "(IDQ.MITE_CYCLES_ANY - IDQ.MITE_CYCLES_OK) / tma_in=
fo_core_core_clks / 2",
         "MetricGroup": "DSBmiss;FetchBW;TopdownL3;tma_L3_group;tma_fetch_b=
andwidth_group",
         "MetricName": "tma_mite",
-        "MetricThreshold": "tma_mite > 0.1 & (tma_fetch_bandwidth > 0.1 & =
tma_frontend_bound > 0.15 & tma_info_ipc / 5 > 0.35)",
+        "MetricThreshold": "tma_mite > 0.1 & (tma_fetch_bandwidth > 0.1 & =
tma_frontend_bound > 0.15 & tma_info_thread_ipc / 5 > 0.35)",
         "PublicDescription": "This metric represents Core fraction of cycl=
es in which CPU was likely limited due to the MITE pipeline (the legacy dec=
ode pipeline). This pipeline is used for code that was not pre-cached in th=
e DSB or LSD. For example; inefficiencies due to asymmetric decoders; use o=
f long immediate or LCP can manifest as MITE fetch bandwidth bottleneck. Sa=
mple with: FRONTEND_RETIRED.ANY_DSB_MISS",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "This metric represents fraction of cycles whe=
re (only) 4 uops were delivered by the MITE pipeline",
-        "MetricExpr": "(cpu@IDQ.MITE_UOPS\\,cmask\\=3D4@ - cpu@IDQ.MITE_UO=
PS\\,cmask\\=3D5@) / tma_info_clks",
+        "MetricExpr": "(cpu@IDQ.MITE_UOPS\\,cmask\\=3D4@ - cpu@IDQ.MITE_UO=
PS\\,cmask\\=3D5@) / tma_info_thread_clks",
         "MetricGroup": "DSBmiss;FetchBW;TopdownL4;tma_L4_group;tma_mite_gr=
oup",
         "MetricName": "tma_mite_4wide",
-        "MetricThreshold": "tma_mite_4wide > 0.05 & (tma_mite > 0.1 & (tma=
_fetch_bandwidth > 0.1 & tma_frontend_bound > 0.15 & tma_info_ipc / 5 > 0.3=
5))",
+        "MetricThreshold": "tma_mite_4wide > 0.05 & (tma_mite > 0.1 & (tma=
_fetch_bandwidth > 0.1 & tma_frontend_bound > 0.15 & tma_info_thread_ipc / =
5 > 0.35))",
         "ScaleUnit": "100%"
     },
     {
@@ -1292,7 +1538,7 @@
     },
     {
         "BriefDescription": "This metric estimates the fraction of cycles =
when the CPU was stalled due to switches of uop delivery to the Microcode S=
equencer (MS)",
-        "MetricExpr": "3 * IDQ.MS_SWITCHES / tma_info_clks",
+        "MetricExpr": "3 * IDQ.MS_SWITCHES / tma_info_thread_clks",
         "MetricGroup": "FetchLat;MicroSeq;TopdownL3;tma_L3_group;tma_fetch=
_latency_group;tma_issueMC;tma_issueMS;tma_issueMV;tma_issueSO",
         "MetricName": "tma_ms_switches",
         "MetricThreshold": "tma_ms_switches > 0.05 & (tma_fetch_latency > =
0.1 & tma_frontend_bound > 0.15)",
@@ -1301,7 +1547,7 @@
     },
     {
         "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring NOP (no op) instructions",
-        "MetricExpr": "tma_light_operations * INST_RETIRED.NOP / (tma_reti=
ring * tma_info_slots)",
+        "MetricExpr": "tma_light_operations * INST_RETIRED.NOP / (tma_reti=
ring * tma_info_thread_slots)",
         "MetricGroup": "Pipeline;TopdownL3;tma_L3_group;tma_light_operatio=
ns_group",
         "MetricName": "tma_nop_instructions",
         "MetricThreshold": "tma_nop_instructions > 0.1 & tma_light_operati=
ons > 0.6",
@@ -1320,7 +1566,7 @@
     },
     {
         "BriefDescription": "This metric roughly estimates (based on idle =
latencies) how often the CPU was stalled on accesses to external 3D-Xpoint =
(Crystal Ridge, a.k.a",
-        "MetricExpr": "(((1 - ((19 * (MEM_LOAD_L3_MISS_RETIRED.REMOTE_DRAM=
 * (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS)) + 10 * (MEM_LO=
AD_L3_MISS_RETIRED.LOCAL_DRAM * (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RET=
IRED.L1_MISS) + MEM_LOAD_L3_MISS_RETIRED.REMOTE_FWD * (1 + MEM_LOAD_RETIRED=
.FB_HIT / MEM_LOAD_RETIRED.L1_MISS) + MEM_LOAD_L3_MISS_RETIRED.REMOTE_HITM =
* (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS))) / (19 * (MEM_L=
OAD_L3_MISS_RETIRED.REMOTE_DRAM * (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_R=
ETIRED.L1_MISS)) + 10 * (MEM_LOAD_L3_MISS_RETIRED.LOCAL_DRAM * (1 + MEM_LOA=
D_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS) + MEM_LOAD_L3_MISS_RETIRED.REM=
OTE_FWD * (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS) + MEM_LO=
AD_L3_MISS_RETIRED.REMOTE_HITM * (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RE=
TIRED.L1_MISS)) + (25 * (MEM_LOAD_RETIRED.LOCAL_PMM * (1 + MEM_LOAD_RETIRED=
.FB_HIT / MEM_LOAD_RETIRED.L1_MISS) if #has_pmem > 0 else 0) + 33 * (MEM_LO=
AD_L3_MISS_RETIRED.REMOTE_PMM * (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RET=
IRED.L1_MISS) if #has_pmem > 0 else 0))) if #has_pmem > 0 else 0)) * (CYCLE=
_ACTIVITY.STALLS_L3_MISS / tma_info_clks + (CYCLE_ACTIVITY.STALLS_L1D_MISS =
- CYCLE_ACTIVITY.STALLS_L2_MISS) / tma_info_clks - tma_l2_bound) if 1e6 * (=
MEM_LOAD_L3_MISS_RETIRED.REMOTE_PMM + MEM_LOAD_RETIRED.LOCAL_PMM) > MEM_LOA=
D_RETIRED.L1_MISS else 0) if #has_pmem > 0 else 0)",
+        "MetricExpr": "(((1 - ((19 * (MEM_LOAD_L3_MISS_RETIRED.REMOTE_DRAM=
 * (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS)) + 10 * (MEM_LO=
AD_L3_MISS_RETIRED.LOCAL_DRAM * (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RET=
IRED.L1_MISS) + MEM_LOAD_L3_MISS_RETIRED.REMOTE_FWD * (1 + MEM_LOAD_RETIRED=
.FB_HIT / MEM_LOAD_RETIRED.L1_MISS) + MEM_LOAD_L3_MISS_RETIRED.REMOTE_HITM =
* (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS))) / (19 * (MEM_L=
OAD_L3_MISS_RETIRED.REMOTE_DRAM * (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_R=
ETIRED.L1_MISS)) + 10 * (MEM_LOAD_L3_MISS_RETIRED.LOCAL_DRAM * (1 + MEM_LOA=
D_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS) + MEM_LOAD_L3_MISS_RETIRED.REM=
OTE_FWD * (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS) + MEM_LO=
AD_L3_MISS_RETIRED.REMOTE_HITM * (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RE=
TIRED.L1_MISS)) + (25 * (MEM_LOAD_RETIRED.LOCAL_PMM * (1 + MEM_LOAD_RETIRED=
.FB_HIT / MEM_LOAD_RETIRED.L1_MISS) if #has_pmem > 0 else 0) + 33 * (MEM_LO=
AD_L3_MISS_RETIRED.REMOTE_PMM * (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RET=
IRED.L1_MISS) if #has_pmem > 0 else 0))) if #has_pmem > 0 else 0)) * (CYCLE=
_ACTIVITY.STALLS_L3_MISS / tma_info_thread_clks + (CYCLE_ACTIVITY.STALLS_L1=
D_MISS - CYCLE_ACTIVITY.STALLS_L2_MISS) / tma_info_thread_clks - tma_l2_bou=
nd) if 1e6 * (MEM_LOAD_L3_MISS_RETIRED.REMOTE_PMM + MEM_LOAD_RETIRED.LOCAL_=
PMM) > MEM_LOAD_RETIRED.L1_MISS else 0) if #has_pmem > 0 else 0)",
         "MetricGroup": "MemoryBound;Server;TmaL3mem;TopdownL3;tma_L3_group=
;tma_memory_bound_group",
         "MetricName": "tma_pmm_bound",
         "MetricThreshold": "tma_pmm_bound > 0.1 & (tma_memory_bound > 0.2 =
& tma_backend_bound > 0.2)",
@@ -1329,7 +1575,7 @@
     },
     {
         "BriefDescription": "This metric represents Core fraction of cycle=
s CPU dispatched uops on execution port 0 ([SNB+] ALU; [HSW+] ALU and 2nd b=
ranch)",
-        "MetricExpr": "UOPS_DISPATCHED.PORT_0 / tma_info_core_clks",
+        "MetricExpr": "UOPS_DISPATCHED.PORT_0 / tma_info_core_core_clks",
         "MetricGroup": "Compute;TopdownL6;tma_L6_group;tma_alu_op_utilizat=
ion_group;tma_issue2P",
         "MetricName": "tma_port_0",
         "MetricThreshold": "tma_port_0 > 0.6",
@@ -1338,7 +1584,7 @@
     },
     {
         "BriefDescription": "This metric represents Core fraction of cycle=
s CPU dispatched uops on execution port 1 (ALU)",
-        "MetricExpr": "UOPS_DISPATCHED.PORT_1 / tma_info_core_clks",
+        "MetricExpr": "UOPS_DISPATCHED.PORT_1 / tma_info_core_core_clks",
         "MetricGroup": "TopdownL6;tma_L6_group;tma_alu_op_utilization_grou=
p;tma_issue2P",
         "MetricName": "tma_port_1",
         "MetricThreshold": "tma_port_1 > 0.6",
@@ -1347,7 +1593,7 @@
     },
     {
         "BriefDescription": "This metric represents Core fraction of cycle=
s CPU dispatched uops on execution port 5 ([SNB+] Branches and ALU; [HSW+] =
ALU)",
-        "MetricExpr": "UOPS_DISPATCHED.PORT_5 / tma_info_core_clks",
+        "MetricExpr": "UOPS_DISPATCHED.PORT_5 / tma_info_core_core_clks",
         "MetricGroup": "TopdownL6;tma_L6_group;tma_alu_op_utilization_grou=
p;tma_issue2P",
         "MetricName": "tma_port_5",
         "MetricThreshold": "tma_port_5 > 0.6",
@@ -1356,7 +1602,7 @@
     },
     {
         "BriefDescription": "This metric represents Core fraction of cycle=
s CPU dispatched uops on execution port 6 ([HSW+]Primary Branch and simple =
ALU)",
-        "MetricExpr": "UOPS_DISPATCHED.PORT_6 / tma_info_core_clks",
+        "MetricExpr": "UOPS_DISPATCHED.PORT_6 / tma_info_core_core_clks",
         "MetricGroup": "TopdownL6;tma_L6_group;tma_alu_op_utilization_grou=
p;tma_issue2P",
         "MetricName": "tma_port_6",
         "MetricThreshold": "tma_port_6 > 0.6",
@@ -1365,7 +1611,7 @@
     },
     {
         "BriefDescription": "This metric estimates fraction of cycles the =
CPU performance was potentially limited due to Core computation issues (non=
 divider-related)",
-        "MetricExpr": "((cpu@EXE_ACTIVITY.3_PORTS_UTIL\\,umask\\=3D0x80@ +=
 tma_serializing_operation * (CYCLE_ACTIVITY.STALLS_TOTAL - CYCLE_ACTIVITY.=
STALLS_MEM_ANY) + (EXE_ACTIVITY.1_PORTS_UTIL + tma_retiring * EXE_ACTIVITY.=
2_PORTS_UTIL)) / tma_info_clks if ARITH.DIVIDER_ACTIVE < CYCLE_ACTIVITY.STA=
LLS_TOTAL - CYCLE_ACTIVITY.STALLS_MEM_ANY else (EXE_ACTIVITY.1_PORTS_UTIL +=
 tma_retiring * EXE_ACTIVITY.2_PORTS_UTIL) / tma_info_clks)",
+        "MetricExpr": "((cpu@EXE_ACTIVITY.3_PORTS_UTIL\\,umask\\=3D0x80@ +=
 tma_serializing_operation * (CYCLE_ACTIVITY.STALLS_TOTAL - CYCLE_ACTIVITY.=
STALLS_MEM_ANY) + (EXE_ACTIVITY.1_PORTS_UTIL + tma_retiring * EXE_ACTIVITY.=
2_PORTS_UTIL)) / tma_info_thread_clks if ARITH.DIVIDER_ACTIVE < CYCLE_ACTIV=
ITY.STALLS_TOTAL - CYCLE_ACTIVITY.STALLS_MEM_ANY else (EXE_ACTIVITY.1_PORTS=
_UTIL + tma_retiring * EXE_ACTIVITY.2_PORTS_UTIL) / tma_info_thread_clks)",
         "MetricGroup": "PortsUtil;TopdownL3;tma_L3_group;tma_core_bound_gr=
oup",
         "MetricName": "tma_ports_utilization",
         "MetricThreshold": "tma_ports_utilization > 0.15 & (tma_core_bound=
 > 0.1 & tma_backend_bound > 0.2)",
@@ -1374,7 +1620,7 @@
     },
     {
         "BriefDescription": "This metric represents fraction of cycles CPU=
 executed no uops on any execution port (Logical Processor cycles since ICL=
, Physical Core cycles otherwise)",
-        "MetricExpr": "cpu@EXE_ACTIVITY.3_PORTS_UTIL\\,umask\\=3D0x80@ / t=
ma_info_clks + tma_serializing_operation * (CYCLE_ACTIVITY.STALLS_TOTAL - C=
YCLE_ACTIVITY.STALLS_MEM_ANY) / tma_info_clks",
+        "MetricExpr": "cpu@EXE_ACTIVITY.3_PORTS_UTIL\\,umask\\=3D0x80@ / t=
ma_info_thread_clks + tma_serializing_operation * (CYCLE_ACTIVITY.STALLS_TO=
TAL - CYCLE_ACTIVITY.STALLS_MEM_ANY) / tma_info_thread_clks",
         "MetricGroup": "PortsUtil;TopdownL4;tma_L4_group;tma_ports_utiliza=
tion_group",
         "MetricName": "tma_ports_utilized_0",
         "MetricThreshold": "tma_ports_utilized_0 > 0.2 & (tma_ports_utiliz=
ation > 0.15 & (tma_core_bound > 0.1 & tma_backend_bound > 0.2))",
@@ -1383,7 +1629,7 @@
     },
     {
         "BriefDescription": "This metric represents fraction of cycles whe=
re the CPU executed total of 1 uop per cycle on all execution ports (Logica=
l Processor cycles since ICL, Physical Core cycles otherwise)",
-        "MetricExpr": "EXE_ACTIVITY.1_PORTS_UTIL / tma_info_clks",
+        "MetricExpr": "EXE_ACTIVITY.1_PORTS_UTIL / tma_info_thread_clks",
         "MetricGroup": "PortsUtil;TopdownL4;tma_L4_group;tma_issueL1;tma_p=
orts_utilization_group",
         "MetricName": "tma_ports_utilized_1",
         "MetricThreshold": "tma_ports_utilized_1 > 0.2 & (tma_ports_utiliz=
ation > 0.15 & (tma_core_bound > 0.1 & tma_backend_bound > 0.2))",
@@ -1392,7 +1638,7 @@
     },
     {
         "BriefDescription": "This metric represents fraction of cycles CPU=
 executed total of 2 uops per cycle on all execution ports (Logical Process=
or cycles since ICL, Physical Core cycles otherwise)",
-        "MetricExpr": "EXE_ACTIVITY.2_PORTS_UTIL / tma_info_clks",
+        "MetricExpr": "EXE_ACTIVITY.2_PORTS_UTIL / tma_info_thread_clks",
         "MetricGroup": "PortsUtil;TopdownL4;tma_L4_group;tma_issue2P;tma_p=
orts_utilization_group",
         "MetricName": "tma_ports_utilized_2",
         "MetricThreshold": "tma_ports_utilized_2 > 0.15 & (tma_ports_utili=
zation > 0.15 & (tma_core_bound > 0.1 & tma_backend_bound > 0.2))",
@@ -1401,7 +1647,7 @@
     },
     {
         "BriefDescription": "This metric represents fraction of cycles CPU=
 executed total of 3 or more uops per cycle on all execution ports (Logical=
 Processor cycles since ICL, Physical Core cycles otherwise)",
-        "MetricExpr": "UOPS_EXECUTED.CYCLES_GE_3 / tma_info_clks",
+        "MetricExpr": "UOPS_EXECUTED.CYCLES_GE_3 / tma_info_thread_clks",
         "MetricGroup": "PortsUtil;TopdownL4;tma_L4_group;tma_ports_utiliza=
tion_group",
         "MetricName": "tma_ports_utilized_3m",
         "MetricThreshold": "tma_ports_utilized_3m > 0.7 & (tma_ports_utili=
zation > 0.15 & (tma_core_bound > 0.1 & tma_backend_bound > 0.2))",
@@ -1410,7 +1656,7 @@
     },
     {
         "BriefDescription": "This metric estimates fraction of cycles whil=
e the memory subsystem was handling loads from remote cache in other socket=
s including synchronizations issues",
-        "MetricExpr": "(97 * tma_info_average_frequency * MEM_LOAD_L3_MISS=
_RETIRED.REMOTE_HITM + 97 * tma_info_average_frequency * MEM_LOAD_L3_MISS_R=
ETIRED.REMOTE_FWD) * (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MIS=
S / 2) / tma_info_clks",
+        "MetricExpr": "(97 * tma_info_system_average_frequency * MEM_LOAD_=
L3_MISS_RETIRED.REMOTE_HITM + 97 * tma_info_system_average_frequency * MEM_=
LOAD_L3_MISS_RETIRED.REMOTE_FWD) * (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_=
RETIRED.L1_MISS / 2) / tma_info_thread_clks",
         "MetricGroup": "Offcore;Server;Snoop;TopdownL5;tma_L5_group;tma_is=
sueSyncxn;tma_mem_latency_group",
         "MetricName": "tma_remote_cache",
         "MetricThreshold": "tma_remote_cache > 0.05 & (tma_mem_latency > 0=
.1 & (tma_dram_bound > 0.1 & (tma_memory_bound > 0.2 & tma_backend_bound > =
0.2)))",
@@ -1419,7 +1665,7 @@
     },
     {
         "BriefDescription": "This metric estimates fraction of cycles whil=
e the memory subsystem was handling loads from remote memory",
-        "MetricExpr": "108 * tma_info_average_frequency * MEM_LOAD_L3_MISS=
_RETIRED.REMOTE_DRAM * (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_M=
ISS / 2) / tma_info_clks",
+        "MetricExpr": "108 * tma_info_system_average_frequency * MEM_LOAD_=
L3_MISS_RETIRED.REMOTE_DRAM * (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIR=
ED.L1_MISS / 2) / tma_info_thread_clks",
         "MetricGroup": "Server;Snoop;TopdownL5;tma_L5_group;tma_mem_latenc=
y_group",
         "MetricName": "tma_remote_dram",
         "MetricThreshold": "tma_remote_dram > 0.1 & (tma_mem_latency > 0.1=
 & (tma_dram_bound > 0.1 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.=
2)))",
@@ -1428,7 +1674,7 @@
     },
     {
         "BriefDescription": "This category represents fraction of slots ut=
ilized by useful work i.e. issued uops that eventually get retired",
-        "MetricExpr": "topdown\\-retiring / (topdown\\-fe\\-bound + topdow=
n\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) + 0 * tma_info_=
slots",
+        "MetricExpr": "topdown\\-retiring / (topdown\\-fe\\-bound + topdow=
n\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) + 0 * tma_info_=
thread_slots",
         "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
         "MetricName": "tma_retiring",
         "MetricThreshold": "tma_retiring > 0.7 | tma_heavy_operations > 0.=
1",
@@ -1438,7 +1684,7 @@
     },
     {
         "BriefDescription": "This metric represents fraction of cycles the=
 CPU issue-pipeline was stalled due to serializing operations",
-        "MetricExpr": "RESOURCE_STALLS.SCOREBOARD / tma_info_clks",
+        "MetricExpr": "RESOURCE_STALLS.SCOREBOARD / tma_info_thread_clks",
         "MetricGroup": "PortsUtil;TopdownL5;tma_L5_group;tma_issueSO;tma_p=
orts_utilized_0_group",
         "MetricName": "tma_serializing_operation",
         "MetricThreshold": "tma_serializing_operation > 0.1 & (tma_ports_u=
tilized_0 > 0.2 & (tma_ports_utilization > 0.15 & (tma_core_bound > 0.1 & t=
ma_backend_bound > 0.2)))",
@@ -1447,7 +1693,7 @@
     },
     {
         "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to PAUSE Instructions",
-        "MetricExpr": "37 * MISC_RETIRED.PAUSE_INST / tma_info_clks",
+        "MetricExpr": "37 * MISC_RETIRED.PAUSE_INST / tma_info_thread_clks=
",
         "MetricGroup": "TopdownL6;tma_L6_group;tma_serializing_operation_g=
roup",
         "MetricName": "tma_slow_pause",
         "MetricThreshold": "tma_slow_pause > 0.05 & (tma_serializing_opera=
tion > 0.1 & (tma_ports_utilized_0 > 0.2 & (tma_ports_utilization > 0.15 & =
(tma_core_bound > 0.1 & tma_backend_bound > 0.2))))",
@@ -1456,7 +1702,7 @@
     },
     {
         "BriefDescription": "This metric estimates fraction of cycles hand=
ling memory load split accesses - load that cross 64-byte cache line bounda=
ry",
-        "MetricExpr": "tma_info_load_miss_real_latency * LD_BLOCKS.NO_SR /=
 tma_info_clks",
+        "MetricExpr": "tma_info_memory_load_miss_real_latency * LD_BLOCKS.=
NO_SR / tma_info_thread_clks",
         "MetricGroup": "TopdownL4;tma_L4_group;tma_l1_bound_group",
         "MetricName": "tma_split_loads",
         "MetricThreshold": "tma_split_loads > 0.2 & (tma_l1_bound > 0.1 & =
(tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
@@ -1465,7 +1711,7 @@
     },
     {
         "BriefDescription": "This metric represents rate of split store ac=
cesses",
-        "MetricExpr": "MEM_INST_RETIRED.SPLIT_STORES / tma_info_core_clks"=
,
+        "MetricExpr": "MEM_INST_RETIRED.SPLIT_STORES / tma_info_core_core_=
clks",
         "MetricGroup": "TopdownL4;tma_L4_group;tma_issueSpSt;tma_store_bou=
nd_group",
         "MetricName": "tma_split_stores",
         "MetricThreshold": "tma_split_stores > 0.2 & (tma_store_bound > 0.=
2 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
@@ -1474,16 +1720,16 @@
     },
     {
         "BriefDescription": "This metric measures fraction of cycles where=
 the Super Queue (SQ) was full taking into account all request-types and bo=
th hardware SMT threads (Logical Processors)",
-        "MetricExpr": "L1D_PEND_MISS.L2_STALL / tma_info_clks",
+        "MetricExpr": "L1D_PEND_MISS.L2_STALL / tma_info_thread_clks",
         "MetricGroup": "MemoryBW;Offcore;TopdownL4;tma_L4_group;tma_issueB=
W;tma_l3_bound_group",
         "MetricName": "tma_sq_full",
         "MetricThreshold": "tma_sq_full > 0.3 & (tma_l3_bound > 0.05 & (tm=
a_memory_bound > 0.2 & tma_backend_bound > 0.2))",
-        "PublicDescription": "This metric measures fraction of cycles wher=
e the Super Queue (SQ) was full taking into account all request-types and b=
oth hardware SMT threads (Logical Processors). Related metrics: tma_fb_full=
, tma_info_dram_bw_use, tma_info_memory_bandwidth, tma_mem_bandwidth",
+        "PublicDescription": "This metric measures fraction of cycles wher=
e the Super Queue (SQ) was full taking into account all request-types and b=
oth hardware SMT threads (Logical Processors). Related metrics: tma_fb_full=
, tma_info_bottleneck_memory_bandwidth, tma_info_system_dram_bw_use, tma_me=
m_bandwidth",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "This metric estimates how often CPU was stall=
ed  due to RFO store memory accesses; RFO store issue a read-for-ownership =
request before the write",
-        "MetricExpr": "EXE_ACTIVITY.BOUND_ON_STORES / tma_info_clks",
+        "MetricExpr": "EXE_ACTIVITY.BOUND_ON_STORES / tma_info_thread_clks=
",
         "MetricGroup": "MemoryBound;TmaL3mem;TopdownL3;tma_L3_group;tma_me=
mory_bound_group",
         "MetricName": "tma_store_bound",
         "MetricThreshold": "tma_store_bound > 0.2 & (tma_memory_bound > 0.=
2 & tma_backend_bound > 0.2)",
@@ -1492,7 +1738,7 @@
     },
     {
         "BriefDescription": "This metric roughly estimates fraction of cyc=
les when the memory subsystem had loads blocked since they could not forwar=
d data from earlier (in program order) overlapping stores",
-        "MetricExpr": "13 * LD_BLOCKS.STORE_FORWARD / tma_info_clks",
+        "MetricExpr": "13 * LD_BLOCKS.STORE_FORWARD / tma_info_thread_clks=
",
         "MetricGroup": "TopdownL4;tma_L4_group;tma_l1_bound_group",
         "MetricName": "tma_store_fwd_blk",
         "MetricThreshold": "tma_store_fwd_blk > 0.1 & (tma_l1_bound > 0.1 =
& (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
@@ -1501,7 +1747,7 @@
     },
     {
         "BriefDescription": "This metric estimates fraction of cycles the =
CPU spent handling L1D store misses",
-        "MetricExpr": "(L2_RQSTS.RFO_HIT * 10 * (1 - MEM_INST_RETIRED.LOCK=
_LOADS / MEM_INST_RETIRED.ALL_STORES) + (1 - MEM_INST_RETIRED.LOCK_LOADS / =
MEM_INST_RETIRED.ALL_STORES) * min(CPU_CLK_UNHALTED.THREAD, OFFCORE_REQUEST=
S_OUTSTANDING.CYCLES_WITH_DEMAND_RFO)) / tma_info_clks",
+        "MetricExpr": "(L2_RQSTS.RFO_HIT * 10 * (1 - MEM_INST_RETIRED.LOCK=
_LOADS / MEM_INST_RETIRED.ALL_STORES) + (1 - MEM_INST_RETIRED.LOCK_LOADS / =
MEM_INST_RETIRED.ALL_STORES) * min(CPU_CLK_UNHALTED.THREAD, OFFCORE_REQUEST=
S_OUTSTANDING.CYCLES_WITH_DEMAND_RFO)) / tma_info_thread_clks",
         "MetricGroup": "MemoryLat;Offcore;TopdownL4;tma_L4_group;tma_issue=
RFO;tma_issueSL;tma_store_bound_group",
         "MetricName": "tma_store_latency",
         "MetricThreshold": "tma_store_latency > 0.1 & (tma_store_bound > 0=
.2 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
@@ -1510,7 +1756,7 @@
     },
     {
         "BriefDescription": "This metric represents Core fraction of cycle=
s CPU dispatched uops on execution port for Store operations",
-        "MetricExpr": "(UOPS_DISPATCHED.PORT_4_9 + UOPS_DISPATCHED.PORT_7_=
8) / (4 * tma_info_core_clks)",
+        "MetricExpr": "(UOPS_DISPATCHED.PORT_4_9 + UOPS_DISPATCHED.PORT_7_=
8) / (4 * tma_info_core_core_clks)",
         "MetricGroup": "TopdownL5;tma_L5_group;tma_ports_utilized_3m_group=
",
         "MetricName": "tma_store_op_utilization",
         "MetricThreshold": "tma_store_op_utilization > 0.6",
@@ -1527,7 +1773,7 @@
     },
     {
         "BriefDescription": "This metric estimates the fraction of cycles =
where the STLB was missed by store accesses, performing a hardware page wal=
k",
-        "MetricExpr": "DTLB_STORE_MISSES.WALK_ACTIVE / tma_info_core_clks"=
,
+        "MetricExpr": "DTLB_STORE_MISSES.WALK_ACTIVE / tma_info_core_core_=
clks",
         "MetricGroup": "MemoryTLB;TopdownL5;tma_L5_group;tma_dtlb_store_gr=
oup",
         "MetricName": "tma_store_stlb_miss",
         "MetricThreshold": "tma_store_stlb_miss > 0.05 & (tma_dtlb_store >=
 0.05 & (tma_store_bound > 0.2 & (tma_memory_bound > 0.2 & tma_backend_boun=
d > 0.2)))",
@@ -1535,7 +1781,7 @@
     },
     {
         "BriefDescription": "This metric estimates how often CPU was stall=
ed  due to Streaming store memory accesses; Streaming store optimize out a =
read request required by RFO stores",
-        "MetricExpr": "9 * OCR.STREAMING_WR.ANY_RESPONSE / tma_info_clks",
+        "MetricExpr": "9 * OCR.STREAMING_WR.ANY_RESPONSE / tma_info_thread=
_clks",
         "MetricGroup": "MemoryBW;Offcore;TopdownL4;tma_L4_group;tma_issueS=
mSt;tma_store_bound_group",
         "MetricName": "tma_streaming_stores",
         "MetricThreshold": "tma_streaming_stores > 0.2 & (tma_store_bound =
> 0.2 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
@@ -1544,7 +1790,7 @@
     },
     {
         "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to new branch address clears",
-        "MetricExpr": "10 * BACLEARS.ANY / tma_info_clks",
+        "MetricExpr": "10 * BACLEARS.ANY / tma_info_thread_clks",
         "MetricGroup": "BigFoot;FetchLat;TopdownL4;tma_L4_group;tma_branch=
_resteers_group",
         "MetricName": "tma_unknown_branches",
         "MetricThreshold": "tma_unknown_branches > 0.05 & (tma_branch_rest=
eers > 0.05 & (tma_fetch_latency > 0.1 & tma_frontend_bound > 0.15))",
@@ -1587,5 +1833,17 @@
         "MetricGroup": "transaction",
         "MetricName": "tsx_transactional_cycles",
         "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "Uncore operating frequency in GHz",
+        "MetricExpr": "UNC_CHA_CLOCKTICKS / (source_count(UNC_CHA_CLOCKTIC=
KS) * #num_packages) / 1e9 / duration_time",
+        "MetricName": "uncore_frequency",
+        "ScaleUnit": "1GHz"
+    },
+    {
+        "BriefDescription": "Intel(R) Ultra Path Interconnect (UPI) data t=
ransmit bandwidth (MB/sec)",
+        "MetricExpr": "UNC_UPI_TxL_FLITS.ALL_DATA * 7.111111111111111 / 1e=
6 / duration_time",
+        "MetricName": "upi_data_transmit_bw",
+        "ScaleUnit": "1MB/s"
     }
 ]
diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-ev=
ents/arch/x86/mapfile.csv
index f3ae41e28ed2..1d2e63575da7 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -13,7 +13,7 @@ GenuineIntel-6-B6,v1.00,grandridge,core
 GenuineIntel-6-A[DE],v1.01,graniterapids,core
 GenuineIntel-6-(3C|45|46),v33,haswell,core
 GenuineIntel-6-3F,v27,haswellx,core
-GenuineIntel-6-(7D|7E|A7),v1.17,icelake,core
+GenuineIntel-6-(7D|7E|A7),v1.18,icelake,core
 GenuineIntel-6-6[AC],v1.20,icelakex,core
 GenuineIntel-6-3A,v24,ivybridge,core
 GenuineIntel-6-3E,v23,ivytown,core
--=20
2.40.1.606.ga4b1b128d6-goog

