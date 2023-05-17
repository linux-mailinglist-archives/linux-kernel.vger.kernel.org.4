Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 290CE706CD2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 17:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230244AbjEQP2i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 11:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232417AbjEQP1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 11:27:37 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 926234ED4
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 08:27:12 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-b9a25f6aa0eso1546836276.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 08:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684337232; x=1686929232;
        h=content-transfer-encoding:to:from:subject:references:mime-version
         :message-id:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BnAfIbmSAJy1nhwxlLI4CXbH/I642OPdNYHz63+L4Ls=;
        b=jJ6Lv6pBGhBdbg8dlgNbLJXToWyWeZsC2jlJJu3XSWZzgtCif8skwz5ZO/ItHRjsgd
         IwfmnTOgl0oTSqcfMX5ScXXbG97xEzbeGL9fbvothWyXK5zh9Li8ILBNgjaDLjm5rBsK
         xLkzONEoa2TyBtDYQOOniF5lk+bTSR+W+iIkrxGh+43z8DGP9Z6zhEF36yFQ006n7ls/
         pn7gPyXk/8Jf9kewBYls55LuqLBrs7TpEyEI0HYzkgsyPV9hLXxeSf2tomUPXc/cwKmE
         uwLQgCOZAqz7GwvUKsDVTHQq/Wp8yOh7dIrcWfOEsN4jNb6wTKLY9inia89GQaQwPVz8
         eziw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684337232; x=1686929232;
        h=content-transfer-encoding:to:from:subject:references:mime-version
         :message-id:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BnAfIbmSAJy1nhwxlLI4CXbH/I642OPdNYHz63+L4Ls=;
        b=Oy7KhMe3PsNsaIR677Aa0fPG5FOHq8aqYJi4+755fvF+mai437DAlLWx9enK69R+Kc
         5T1st/+YJ0kGod4weXchrv9EJTWxhLYVZhWuldTYHaYzniBuwZtgmHptXbWN/dOJBbQv
         VAtxR1PJfHnSVPVez1GG0hXimUkridt1BLt13k7DLyxEyj3V8eE4tWXuqZpBkXM3rt7O
         86xvRk2+awM543FoD4aqmry/bVmj1Khy7oqqtjKTRZzVdjKv6KmkfhQQrPCGfNGCMQzc
         yVoSX/b7dzPqf/z+HHOM3qZ3mDtvOgHKuHOrULDnzY60TPqGhguCT4qlAL3eiO71e6mg
         80wA==
X-Gm-Message-State: AC+VfDzmE4KY4uP7sDVFjXu/2mGxXQopn/O97IaJ4KYMeBHK9DTaFMYA
        AT0gCQAlXQQUFg5ApvO7/yhhT4v3GT4L
X-Google-Smtp-Source: ACHHUZ6D/rEoKjI8TF3RK6PJ2192oHSaGusQlrM7URrrLIixKvbDGA2Ra+u4TkREVvfHEFfqmnysHKrC1TKJ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:628b:7e78:d09b:39b])
 (user=irogers job=sendgmr) by 2002:a25:8d09:0:b0:ba8:5e0e:f5a7 with SMTP id
 n9-20020a258d09000000b00ba85e0ef5a7mr910022ybl.7.1684337231873; Wed, 17 May
 2023 08:27:11 -0700 (PDT)
Date:   Wed, 17 May 2023 08:26:23 -0700
In-Reply-To: <20230517152626.563559-1-irogers@google.com>
Message-Id: <20230517152626.563559-13-irogers@google.com>
Mime-Version: 1.0
References: <20230517152626.563559-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
Subject: [PATCH v2 12/15] perf vendor events intel: Update snowridgex events
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

Update snowridgex to v1.21 that marks deprecated a number of events
and adds improves descriptions. The events data was generated by:
https://github.com/intel/perfmon/blob/main/scripts/create_perf_json.py

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/arch/x86/mapfile.csv         |  2 +-
 .../perf/pmu-events/arch/x86/snowridgex/cache.json |  7 +++++++
 .../pmu-events/arch/x86/snowridgex/memory.json     |  2 ++
 .../perf/pmu-events/arch/x86/snowridgex/other.json | 10 ++++++++++
 .../pmu-events/arch/x86/snowridgex/pipeline.json   |  3 +++
 .../arch/x86/snowridgex/uncore-interconnect.json   | 14 +++++++-------
 .../pmu-events/arch/x86/snowridgex/uncore-io.json  |  8 --------
 .../arch/x86/snowridgex/uncore-memory.json         |  7 +++----
 .../arch/x86/snowridgex/uncore-power.json          |  6 +++---
 9 files changed, 36 insertions(+), 23 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-ev=
ents/arch/x86/mapfile.csv
index 4731a92af9f9..4a1a2b8d6201 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -28,7 +28,7 @@ GenuineIntel-6-AF,v1.00,sierraforest,core
 GenuineIntel-6-(37|4A|4C|4D|5A),v15,silvermont,core
 GenuineIntel-6-(4E|5E|8E|9E|A5|A6),v56,skylake,core
 GenuineIntel-6-55-[01234],v1.30,skylakex,core
-GenuineIntel-6-86,v1.20,snowridgex,core
+GenuineIntel-6-86,v1.21,snowridgex,core
 GenuineIntel-6-8[CD],v1.10,tigerlake,core
 GenuineIntel-6-2C,v4,westmereep-dp,core
 GenuineIntel-6-25,v3,westmereep-sp,core
diff --git a/tools/perf/pmu-events/arch/x86/snowridgex/cache.json b/tools/p=
erf/pmu-events/arch/x86/snowridgex/cache.json
index 0ab90e3bf76b..c6be60584522 100644
--- a/tools/perf/pmu-events/arch/x86/snowridgex/cache.json
+++ b/tools/perf/pmu-events/arch/x86/snowridgex/cache.json
@@ -72,6 +72,7 @@
         "BriefDescription": "Counts the number of cycles the core is stall=
ed due to an instruction cache or TLB miss which hit in the L2, LLC, DRAM o=
r MMIO (Non-DRAM).",
         "EventCode": "0x34",
         "EventName": "MEM_BOUND_STALLS.IFETCH",
+        "PublicDescription": "Counts the number of cycles the core is stal=
led due to an instruction cache or translation lookaside buffer (TLB) miss =
which hit in the L2, LLC, DRAM or MMIO (Non-DRAM).",
         "SampleAfterValue": "200003",
         "UMask": "0x38"
     },
@@ -437,6 +438,7 @@
     },
     {
         "BriefDescription": "This event is deprecated. Refer to new event =
OCR.DEMAND_DATA_AND_L1PF_RD.L3_HIT",
+        "Deprecated": "1",
         "EventCode": "0XB7",
         "EventName": "OCR.DEMAND_DATA_RD.L3_HIT",
         "MSRIndex": "0x1a6,0x1a7",
@@ -446,6 +448,7 @@
     },
     {
         "BriefDescription": "This event is deprecated. Refer to new event =
OCR.DEMAND_DATA_AND_L1PF_RD.L3_HIT.SNOOP_HITM",
+        "Deprecated": "1",
         "EventCode": "0XB7",
         "EventName": "OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HITM",
         "MSRIndex": "0x1a6,0x1a7",
@@ -455,6 +458,7 @@
     },
     {
         "BriefDescription": "This event is deprecated. Refer to new event =
OCR.DEMAND_DATA_AND_L1PF_RD.L3_HIT.SNOOP_HIT_NO_FWD",
+        "Deprecated": "1",
         "EventCode": "0XB7",
         "EventName": "OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HIT_NO_FWD",
         "MSRIndex": "0x1a6,0x1a7",
@@ -464,6 +468,7 @@
     },
     {
         "BriefDescription": "This event is deprecated. Refer to new event =
OCR.DEMAND_DATA_AND_L1PF_RD.L3_HIT.SNOOP_HIT_WITH_FWD",
+        "Deprecated": "1",
         "EventCode": "0XB7",
         "EventName": "OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HIT_WITH_FWD",
         "MSRIndex": "0x1a6,0x1a7",
@@ -473,6 +478,7 @@
     },
     {
         "BriefDescription": "This event is deprecated. Refer to new event =
OCR.DEMAND_DATA_AND_L1PF_RD.L3_HIT.SNOOP_MISS",
+        "Deprecated": "1",
         "EventCode": "0XB7",
         "EventName": "OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_MISS",
         "MSRIndex": "0x1a6,0x1a7",
@@ -482,6 +488,7 @@
     },
     {
         "BriefDescription": "This event is deprecated. Refer to new event =
OCR.DEMAND_DATA_AND_L1PF_RD.L3_HIT.SNOOP_NOT_NEEDED",
+        "Deprecated": "1",
         "EventCode": "0XB7",
         "EventName": "OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_NOT_NEEDED",
         "MSRIndex": "0x1a6,0x1a7",
diff --git a/tools/perf/pmu-events/arch/x86/snowridgex/memory.json b/tools/=
perf/pmu-events/arch/x86/snowridgex/memory.json
index 18621909d1a9..c02eb0e836ad 100644
--- a/tools/perf/pmu-events/arch/x86/snowridgex/memory.json
+++ b/tools/perf/pmu-events/arch/x86/snowridgex/memory.json
@@ -96,6 +96,7 @@
     },
     {
         "BriefDescription": "This event is deprecated. Refer to new event =
OCR.DEMAND_DATA_AND_L1PF_RD.L3_MISS",
+        "Deprecated": "1",
         "EventCode": "0XB7",
         "EventName": "OCR.DEMAND_DATA_RD.L3_MISS",
         "MSRIndex": "0x1a6,0x1a7",
@@ -105,6 +106,7 @@
     },
     {
         "BriefDescription": "This event is deprecated. Refer to new event =
OCR.DEMAND_DATA_AND_L1PF_RD.L3_MISS_LOCAL",
+        "Deprecated": "1",
         "EventCode": "0XB7",
         "EventName": "OCR.DEMAND_DATA_RD.L3_MISS_LOCAL",
         "MSRIndex": "0x1a6,0x1a7",
diff --git a/tools/perf/pmu-events/arch/x86/snowridgex/other.json b/tools/p=
erf/pmu-events/arch/x86/snowridgex/other.json
index 00ae180ded25..fefbc383b840 100644
--- a/tools/perf/pmu-events/arch/x86/snowridgex/other.json
+++ b/tools/perf/pmu-events/arch/x86/snowridgex/other.json
@@ -1,6 +1,7 @@
 [
     {
         "BriefDescription": "This event is deprecated. Refer to new event =
BUS_LOCK.SELF_LOCKS",
+        "Deprecated": "1",
         "EdgeDetect": "1",
         "EventCode": "0x63",
         "EventName": "BUS_LOCK.ALL",
@@ -16,6 +17,7 @@
     },
     {
         "BriefDescription": "This event is deprecated. Refer to new event =
BUS_LOCK.BLOCK_CYCLES",
+        "Deprecated": "1",
         "EventCode": "0x63",
         "EventName": "BUS_LOCK.CYCLES_OTHER_BLOCK",
         "SampleAfterValue": "200003",
@@ -23,6 +25,7 @@
     },
     {
         "BriefDescription": "This event is deprecated. Refer to new event =
BUS_LOCK.LOCK_CYCLES",
+        "Deprecated": "1",
         "EventCode": "0x63",
         "EventName": "BUS_LOCK.CYCLES_SELF_BLOCK",
         "SampleAfterValue": "200003",
@@ -46,6 +49,7 @@
     },
     {
         "BriefDescription": "This event is deprecated. Refer to new event =
MEM_BOUND_STALLS.LOAD_DRAM_HIT",
+        "Deprecated": "1",
         "EventCode": "0x34",
         "EventName": "C0_STALLS.LOAD_DRAM_HIT",
         "SampleAfterValue": "200003",
@@ -53,6 +57,7 @@
     },
     {
         "BriefDescription": "This event is deprecated. Refer to new event =
MEM_BOUND_STALLS.LOAD_L2_HIT",
+        "Deprecated": "1",
         "EventCode": "0x34",
         "EventName": "C0_STALLS.LOAD_L2_HIT",
         "SampleAfterValue": "200003",
@@ -60,6 +65,7 @@
     },
     {
         "BriefDescription": "This event is deprecated. Refer to new event =
MEM_BOUND_STALLS.LOAD_LLC_HIT",
+        "Deprecated": "1",
         "EventCode": "0x34",
         "EventName": "C0_STALLS.LOAD_LLC_HIT",
         "SampleAfterValue": "200003",
@@ -207,6 +213,7 @@
     },
     {
         "BriefDescription": "This event is deprecated. Refer to new event =
OCR.DEMAND_DATA_AND_L1PF_RD.ANY_RESPONSE",
+        "Deprecated": "1",
         "EventCode": "0XB7",
         "EventName": "OCR.DEMAND_DATA_RD.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -216,6 +223,7 @@
     },
     {
         "BriefDescription": "This event is deprecated. Refer to new event =
OCR.DEMAND_DATA_AND_L1PF_RD.DRAM",
+        "Deprecated": "1",
         "EventCode": "0XB7",
         "EventName": "OCR.DEMAND_DATA_RD.DRAM",
         "MSRIndex": "0x1a6,0x1a7",
@@ -225,6 +233,7 @@
     },
     {
         "BriefDescription": "This event is deprecated. Refer to new event =
OCR.DEMAND_DATA_AND_L1PF_RD.LOCAL_DRAM",
+        "Deprecated": "1",
         "EventCode": "0XB7",
         "EventName": "OCR.DEMAND_DATA_RD.LOCAL_DRAM",
         "MSRIndex": "0x1a6,0x1a7",
@@ -234,6 +243,7 @@
     },
     {
         "BriefDescription": "This event is deprecated. Refer to new event =
OCR.DEMAND_DATA_AND_L1PF_RD.OUTSTANDING",
+        "Deprecated": "1",
         "EventCode": "0XB7",
         "EventName": "OCR.DEMAND_DATA_RD.OUTSTANDING",
         "MSRIndex": "0x1a6",
diff --git a/tools/perf/pmu-events/arch/x86/snowridgex/pipeline.json b/tool=
s/perf/pmu-events/arch/x86/snowridgex/pipeline.json
index 9dd8c909facc..c483c0838e08 100644
--- a/tools/perf/pmu-events/arch/x86/snowridgex/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/snowridgex/pipeline.json
@@ -165,6 +165,7 @@
     },
     {
         "BriefDescription": "This event is deprecated.",
+        "Deprecated": "1",
         "EventCode": "0xcd",
         "EventName": "CYCLES_DIV_BUSY.ANY",
         "SampleAfterValue": "2000003"
@@ -283,6 +284,7 @@
     },
     {
         "BriefDescription": "This event is deprecated. Refer to new event =
TOPDOWN_BAD_SPECULATION.FASTNUKE",
+        "Deprecated": "1",
         "EventCode": "0x73",
         "EventName": "TOPDOWN_BAD_SPECULATION.MONUKE",
         "SampleAfterValue": "1000003",
@@ -338,6 +340,7 @@
     },
     {
         "BriefDescription": "This event is deprecated.",
+        "Deprecated": "1",
         "EventCode": "0x74",
         "EventName": "TOPDOWN_BE_BOUND.STORE_BUFFER",
         "SampleAfterValue": "1000003",
diff --git a/tools/perf/pmu-events/arch/x86/snowridgex/uncore-interconnect.=
json b/tools/perf/pmu-events/arch/x86/snowridgex/uncore-interconnect.json
index de3840078e21..7e2895f7fe3d 100644
--- a/tools/perf/pmu-events/arch/x86/snowridgex/uncore-interconnect.json
+++ b/tools/perf/pmu-events/arch/x86/snowridgex/uncore-interconnect.json
@@ -590,7 +590,7 @@
         "EventCode": "0x0C",
         "EventName": "UNC_I_TxS_REQUEST_OCCUPANCY",
         "PerPkg": "1",
-        "PublicDescription": "Outbound Request Queue Occupancy : Accumulte=
s the number of outstanding outbound requests from the IRP to the switch (t=
owards the devices).  This can be used in conjuection with the allocations =
event in order to calculate average latency of outbound requests.",
+        "PublicDescription": "Outbound Request Queue Occupancy : Accumulat=
es the number of outstanding outbound requests from the IRP to the switch (=
towards the devices).  This can be used in conjunction with the allocations=
 event in order to calculate average latency of outbound requests.",
         "Unit": "IRP"
     },
     {
@@ -5570,7 +5570,7 @@
         "Unit": "M2M"
     },
     {
-        "BriefDescription": "M2M-&gt;iMC WPQ Cycles w/Credits - Regular : =
Channel 0",
+        "BriefDescription": "M2M->iMC WPQ Cycles w/Credits - Regular : Cha=
nnel 0",
         "EventCode": "0x4D",
         "EventName": "UNC_M2M_WPQ_NO_REG_CRD.CHN0",
         "PerPkg": "1",
@@ -5578,7 +5578,7 @@
         "Unit": "M2M"
     },
     {
-        "BriefDescription": "M2M-&gt;iMC WPQ Cycles w/Credits - Regular : =
Channel 1",
+        "BriefDescription": "M2M->iMC WPQ Cycles w/Credits - Regular : Cha=
nnel 1",
         "EventCode": "0x4D",
         "EventName": "UNC_M2M_WPQ_NO_REG_CRD.CHN1",
         "PerPkg": "1",
@@ -5586,7 +5586,7 @@
         "Unit": "M2M"
     },
     {
-        "BriefDescription": "M2M-&gt;iMC WPQ Cycles w/Credits - Regular : =
Channel 2",
+        "BriefDescription": "M2M->iMC WPQ Cycles w/Credits - Regular : Cha=
nnel 2",
         "EventCode": "0x4D",
         "EventName": "UNC_M2M_WPQ_NO_REG_CRD.CHN2",
         "PerPkg": "1",
@@ -5594,7 +5594,7 @@
         "Unit": "M2M"
     },
     {
-        "BriefDescription": "M2M-&gt;iMC WPQ Cycles w/Credits - Special : =
Channel 0",
+        "BriefDescription": "M2M->iMC WPQ Cycles w/Credits - Special : Cha=
nnel 0",
         "EventCode": "0x4E",
         "EventName": "UNC_M2M_WPQ_NO_SPEC_CRD.CHN0",
         "PerPkg": "1",
@@ -5602,7 +5602,7 @@
         "Unit": "M2M"
     },
     {
-        "BriefDescription": "M2M-&gt;iMC WPQ Cycles w/Credits - Special : =
Channel 1",
+        "BriefDescription": "M2M->iMC WPQ Cycles w/Credits - Special : Cha=
nnel 1",
         "EventCode": "0x4E",
         "EventName": "UNC_M2M_WPQ_NO_SPEC_CRD.CHN1",
         "PerPkg": "1",
@@ -5610,7 +5610,7 @@
         "Unit": "M2M"
     },
     {
-        "BriefDescription": "M2M-&gt;iMC WPQ Cycles w/Credits - Special : =
Channel 2",
+        "BriefDescription": "M2M->iMC WPQ Cycles w/Credits - Special : Cha=
nnel 2",
         "EventCode": "0x4E",
         "EventName": "UNC_M2M_WPQ_NO_SPEC_CRD.CHN2",
         "PerPkg": "1",
diff --git a/tools/perf/pmu-events/arch/x86/snowridgex/uncore-io.json b/too=
ls/perf/pmu-events/arch/x86/snowridgex/uncore-io.json
index 996028071ee4..ecdd6f0f8e8f 100644
--- a/tools/perf/pmu-events/arch/x86/snowridgex/uncore-io.json
+++ b/tools/perf/pmu-events/arch/x86/snowridgex/uncore-io.json
@@ -34,7 +34,6 @@
         "EventCode": "0xff",
         "EventName": "UNC_IIO_BANDWIDTH_IN.PART0_FREERUN",
         "PerPkg": "1",
-        "PublicDescription": "UNC_IIO_BANDWIDTH_IN.PART0_FREERUN",
         "UMask": "0x20",
         "Unit": "iio_free_running"
     },
@@ -43,7 +42,6 @@
         "EventCode": "0xff",
         "EventName": "UNC_IIO_BANDWIDTH_IN.PART1_FREERUN",
         "PerPkg": "1",
-        "PublicDescription": "UNC_IIO_BANDWIDTH_IN.PART1_FREERUN",
         "UMask": "0x21",
         "Unit": "iio_free_running"
     },
@@ -52,7 +50,6 @@
         "EventCode": "0xff",
         "EventName": "UNC_IIO_BANDWIDTH_IN.PART2_FREERUN",
         "PerPkg": "1",
-        "PublicDescription": "UNC_IIO_BANDWIDTH_IN.PART2_FREERUN",
         "UMask": "0x22",
         "Unit": "iio_free_running"
     },
@@ -61,7 +58,6 @@
         "EventCode": "0xff",
         "EventName": "UNC_IIO_BANDWIDTH_IN.PART3_FREERUN",
         "PerPkg": "1",
-        "PublicDescription": "UNC_IIO_BANDWIDTH_IN.PART3_FREERUN",
         "UMask": "0x23",
         "Unit": "iio_free_running"
     },
@@ -70,7 +66,6 @@
         "EventCode": "0xff",
         "EventName": "UNC_IIO_BANDWIDTH_IN.PART4_FREERUN",
         "PerPkg": "1",
-        "PublicDescription": "UNC_IIO_BANDWIDTH_IN.PART4_FREERUN",
         "UMask": "0x24",
         "Unit": "iio_free_running"
     },
@@ -79,7 +74,6 @@
         "EventCode": "0xff",
         "EventName": "UNC_IIO_BANDWIDTH_IN.PART5_FREERUN",
         "PerPkg": "1",
-        "PublicDescription": "UNC_IIO_BANDWIDTH_IN.PART5_FREERUN",
         "UMask": "0x25",
         "Unit": "iio_free_running"
     },
@@ -88,7 +82,6 @@
         "EventCode": "0xff",
         "EventName": "UNC_IIO_BANDWIDTH_IN.PART6_FREERUN",
         "PerPkg": "1",
-        "PublicDescription": "UNC_IIO_BANDWIDTH_IN.PART6_FREERUN",
         "UMask": "0x26",
         "Unit": "iio_free_running"
     },
@@ -97,7 +90,6 @@
         "EventCode": "0xff",
         "EventName": "UNC_IIO_BANDWIDTH_IN.PART7_FREERUN",
         "PerPkg": "1",
-        "PublicDescription": "UNC_IIO_BANDWIDTH_IN.PART7_FREERUN",
         "UMask": "0x27",
         "Unit": "iio_free_running"
     },
diff --git a/tools/perf/pmu-events/arch/x86/snowridgex/uncore-memory.json b=
/tools/perf/pmu-events/arch/x86/snowridgex/uncore-memory.json
index 530e9b71b92a..b80911d498dd 100644
--- a/tools/perf/pmu-events/arch/x86/snowridgex/uncore-memory.json
+++ b/tools/perf/pmu-events/arch/x86/snowridgex/uncore-memory.json
@@ -130,7 +130,6 @@
         "EventCode": "0xff",
         "EventName": "UNC_M_CLOCKTICKS_FREERUN",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_CLOCKTICKS_FREERUN",
         "UMask": "0x10",
         "Unit": "imc_free_running"
     },
@@ -322,7 +321,7 @@
         "EventCode": "0x02",
         "EventName": "UNC_M_PRE_COUNT.PGT",
         "PerPkg": "1",
-        "PublicDescription": "DRAM Precharge commands. : Precharge due to =
page table : Counts the number of DRAM Precharge commands sent on this chan=
nel. : Prechages from Page Table",
+        "PublicDescription": "DRAM Precharge commands. : Precharge due to =
page table : Counts the number of DRAM Precharge commands sent on this chan=
nel. : Precharges from Page Table",
         "UMask": "0x10",
         "Unit": "iMC"
     },
@@ -497,7 +496,7 @@
         "EventCode": "0x82",
         "EventName": "UNC_M_WPQ_OCCUPANCY_PCH0",
         "PerPkg": "1",
-        "PublicDescription": "Write Pending Queue Occupancy : Accumulates =
the occupancies of the Write Pending Queue each cycle.  This can then be us=
ed to calculate both the average queue occupancy (in conjunction with the n=
umber of cycles not empty) and the average latency (in conjunction with the=
 number of allocations).  The WPQ is used to schedule write out to the memo=
ry controller and to track the writes.  Requests allocate into the WPQ soon=
 after they enter the memory controller, and need credits for an entry in t=
his buffer before being sent from the HA to the iMC.  They deallocate after=
 being issued to DRAM.  Write requests themselves are able to complete (fro=
m the perspective of the rest of the system) as soon they have posted to th=
e iMC.  This is not to be confused with actually performing the write to DR=
AM.  Therefore, the average latency for this queue is actually not useful f=
or deconstruction intermediate write latencies.  So, we provide filtering b=
ased on if the request has posted or not.  By using the not posted filter, =
we can track how long writes spent in the iMC before completions were sent =
to the HA.  The posted filter, on the other hand, provides information abou=
t how much queueing is actually happenning in the iMC for writes before the=
y are actually issued to memory.  High average occupancies will generally c=
oincide with high write major mode counts.",
+        "PublicDescription": "Write Pending Queue Occupancy : Accumulates =
the occupancies of the Write Pending Queue each cycle.  This can then be us=
ed to calculate both the average queue occupancy (in conjunction with the n=
umber of cycles not empty) and the average latency (in conjunction with the=
 number of allocations).  The WPQ is used to schedule write out to the memo=
ry controller and to track the writes.  Requests allocate into the WPQ soon=
 after they enter the memory controller, and need credits for an entry in t=
his buffer before being sent from the HA to the iMC.  They deallocate after=
 being issued to DRAM.  Write requests themselves are able to complete (fro=
m the perspective of the rest of the system) as soon they have posted to th=
e iMC.  This is not to be confused with actually performing the write to DR=
AM.  Therefore, the average latency for this queue is actually not useful f=
or deconstruction intermediate write latencies.  So, we provide filtering b=
ased on if the request has posted or not.  By using the not posted filter, =
we can track how long writes spent in the iMC before completions were sent =
to the HA.  The posted filter, on the other hand, provides information abou=
t how much queueing is actually happening in the iMC for writes before they=
 are actually issued to memory.  High average occupancies will generally co=
incide with high write major mode counts.",
         "Unit": "iMC"
     },
     {
@@ -505,7 +504,7 @@
         "EventCode": "0x83",
         "EventName": "UNC_M_WPQ_OCCUPANCY_PCH1",
         "PerPkg": "1",
-        "PublicDescription": "Write Pending Queue Occupancy : Accumulates =
the occupancies of the Write Pending Queue each cycle.  This can then be us=
ed to calculate both the average queue occupancy (in conjunction with the n=
umber of cycles not empty) and the average latency (in conjunction with the=
 number of allocations).  The WPQ is used to schedule write out to the memo=
ry controller and to track the writes.  Requests allocate into the WPQ soon=
 after they enter the memory controller, and need credits for an entry in t=
his buffer before being sent from the HA to the iMC.  They deallocate after=
 being issued to DRAM.  Write requests themselves are able to complete (fro=
m the perspective of the rest of the system) as soon they have posted to th=
e iMC.  This is not to be confused with actually performing the write to DR=
AM.  Therefore, the average latency for this queue is actually not useful f=
or deconstruction intermediate write latencies.  So, we provide filtering b=
ased on if the request has posted or not.  By using the not posted filter, =
we can track how long writes spent in the iMC before completions were sent =
to the HA.  The posted filter, on the other hand, provides information abou=
t how much queueing is actually happenning in the iMC for writes before the=
y are actually issued to memory.  High average occupancies will generally c=
oincide with high write major mode counts.",
+        "PublicDescription": "Write Pending Queue Occupancy : Accumulates =
the occupancies of the Write Pending Queue each cycle.  This can then be us=
ed to calculate both the average queue occupancy (in conjunction with the n=
umber of cycles not empty) and the average latency (in conjunction with the=
 number of allocations).  The WPQ is used to schedule write out to the memo=
ry controller and to track the writes.  Requests allocate into the WPQ soon=
 after they enter the memory controller, and need credits for an entry in t=
his buffer before being sent from the HA to the iMC.  They deallocate after=
 being issued to DRAM.  Write requests themselves are able to complete (fro=
m the perspective of the rest of the system) as soon they have posted to th=
e iMC.  This is not to be confused with actually performing the write to DR=
AM.  Therefore, the average latency for this queue is actually not useful f=
or deconstruction intermediate write latencies.  So, we provide filtering b=
ased on if the request has posted or not.  By using the not posted filter, =
we can track how long writes spent in the iMC before completions were sent =
to the HA.  The posted filter, on the other hand, provides information abou=
t how much queueing is actually happening in the iMC for writes before they=
 are actually issued to memory.  High average occupancies will generally co=
incide with high write major mode counts.",
         "Unit": "iMC"
     },
     {
diff --git a/tools/perf/pmu-events/arch/x86/snowridgex/uncore-power.json b/=
tools/perf/pmu-events/arch/x86/snowridgex/uncore-power.json
index 27fc155f1223..a61ffca2dfea 100644
--- a/tools/perf/pmu-events/arch/x86/snowridgex/uncore-power.json
+++ b/tools/perf/pmu-events/arch/x86/snowridgex/uncore-power.json
@@ -149,7 +149,7 @@
         "EventCode": "0x80",
         "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C0",
         "PerPkg": "1",
-        "PublicDescription": "Number of cores in C-State : C0 and C1 : Thi=
s is an occupancy event that tracks the number of cores that are in the cho=
sen C-State.  It can be used by itself to get the average number of cores i=
n that C-state with threshholding to generate histograms, or with other PCU=
 events and occupancy triggering to capture other details.",
+        "PublicDescription": "Number of cores in C-State : C0 and C1 : Thi=
s is an occupancy event that tracks the number of cores that are in the cho=
sen C-State.  It can be used by itself to get the average number of cores i=
n that C-state with thresholding to generate histograms, or with other PCU =
events and occupancy triggering to capture other details.",
         "Unit": "PCU"
     },
     {
@@ -157,7 +157,7 @@
         "EventCode": "0x80",
         "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C3",
         "PerPkg": "1",
-        "PublicDescription": "Number of cores in C-State : C3 : This is an=
 occupancy event that tracks the number of cores that are in the chosen C-S=
tate.  It can be used by itself to get the average number of cores in that =
C-state with threshholding to generate histograms, or with other PCU events=
 and occupancy triggering to capture other details.",
+        "PublicDescription": "Number of cores in C-State : C3 : This is an=
 occupancy event that tracks the number of cores that are in the chosen C-S=
tate.  It can be used by itself to get the average number of cores in that =
C-state with thresholding to generate histograms, or with other PCU events =
and occupancy triggering to capture other details.",
         "Unit": "PCU"
     },
     {
@@ -165,7 +165,7 @@
         "EventCode": "0x80",
         "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C6",
         "PerPkg": "1",
-        "PublicDescription": "Number of cores in C-State : C6 and C7 : Thi=
s is an occupancy event that tracks the number of cores that are in the cho=
sen C-State.  It can be used by itself to get the average number of cores i=
n that C-state with threshholding to generate histograms, or with other PCU=
 events and occupancy triggering to capture other details.",
+        "PublicDescription": "Number of cores in C-State : C6 and C7 : Thi=
s is an occupancy event that tracks the number of cores that are in the cho=
sen C-State.  It can be used by itself to get the average number of cores i=
n that C-state with thresholding to generate histograms, or with other PCU =
events and occupancy triggering to capture other details.",
         "Unit": "PCU"
     },
     {
--=20
2.40.1.606.ga4b1b128d6-goog

