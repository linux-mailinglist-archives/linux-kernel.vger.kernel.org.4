Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1B1973BB4E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 17:13:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232621AbjFWPNG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 11:13:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232288AbjFWPLn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 11:11:43 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FA432724
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 08:11:10 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5704991ea05so10982667b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 08:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687533064; x=1690125064;
        h=content-transfer-encoding:to:from:subject:references:mime-version
         :message-id:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NjmwL8WseP3HzYigt6canmDc/9LLjtw4UlWBwZCWzrI=;
        b=5pRYaw4oEivyTLfaXO50KNsphBBt2HZ3hzpCDKDYewdSu9CQNRTV1OGheLK/gzyCVk
         K89jQmhYhcezy3Wa78KX9QJgrRvGSBDlcRH+Fs7hnTqxlU6ApNLCvpdWSmYC1dyHdLyz
         qv0DoNCjN9CE+WKKhEzMt8kRaUB4uj2vJlLhP9EtcLy9dcgR6jFfx1sgt882D5cWMs39
         kKN2oLxYvB4bI3Wazd1b61l/JNmvxPz/cbF66xEPWXuS3GLe3rc/A2ysSTE9+7byyHf4
         FgUlCsYTHEKfPenSvSPabGmnuVoCSVvMigrLox3phKB+oyTAcnjRKV/S0hHdNcUhhgKO
         I/Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687533064; x=1690125064;
        h=content-transfer-encoding:to:from:subject:references:mime-version
         :message-id:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NjmwL8WseP3HzYigt6canmDc/9LLjtw4UlWBwZCWzrI=;
        b=ER2WSznqzp3JLndqi0PkxPnxsoKOp1YKfVacxIesIDuKOow18hnHXtXttX+CYad8Y0
         8hfma5vyCTyQTCu+3yA0Ooq3TLBEs5jxgM13bdc3a6MxR6JDUwkvN5qTgQiaWvRM1ojW
         wtZKk71gcxGJVFCsTteQD7v3fZd5xcfsN/WrxckN8htJYz5iPhX55weueViW3tUT7oXm
         LghCxdJudSKm+a8PwqsKrV7RBV7jnAu6b0RpE3VTzeUKCa2fLPVmxJLlLIpUI7mFCYB5
         70C9G/DvhGNv3pR1tp5W0EAepiLrcHdsb5ehh7zDBZHqjYaz9EIkh6i5PsZz9F1C6hTm
         bylg==
X-Gm-Message-State: AC+VfDylgQPxwaHqrX0ncSzkO1zTbi0fqhdNmaFLCDdhmGHc8/hvqKFl
        nkeGAj5A/DE9SXF5+lwwBTMspmNc6BD6
X-Google-Smtp-Source: ACHHUZ5ZRQOjBM7R9fyw55HuF/+F5cACymM0q4IeYxLU+rS3Qeb0hZjzxc7H/lioBzxTNs3m1wbJC2A5RVlQ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:6559:8968:cdfe:35b6])
 (user=irogers job=sendgmr) by 2002:a81:b60a:0:b0:573:4c08:ec40 with SMTP id
 u10-20020a81b60a000000b005734c08ec40mr6253294ywh.7.1687533064442; Fri, 23 Jun
 2023 08:11:04 -0700 (PDT)
Date:   Fri, 23 Jun 2023 08:10:16 -0700
In-Reply-To: <20230623151016.4193660-1-irogers@google.com>
Message-Id: <20230623151016.4193660-13-irogers@google.com>
Mime-Version: 1.0
References: <20230623151016.4193660-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Subject: [PATCH v2 12/12] perf vendor events intel: Update tigerlake to 1.13
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
        Kajol Jain <kjain@linux.ibm.com>,
        John Garry <john.g.garry@oracle.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Sohom Datta <sohomdatta1@gmail.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Perry Taylor <perry.taylor@intel.com>,
        Samantha Alt <samantha.alt@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>,
        Weilin Wang <weilin.wang@intel.com>,
        Edward Baker <edward.baker@intel.com>
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

Updates were released in:
https://github.com/intel/perfmon/commit/9a3cd5ad68aee46078c663fe0cd9484e395=
6fd88
Adds the events ICACHE_DATA.STALLS, ICACHE_TAG.STALLS and
DECODE.LCP. Descriptions are also updated.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/arch/x86/mapfile.csv    |  2 +-
 .../arch/x86/tigerlake/frontend.json          | 32 ++++++++++++++++---
 .../arch/x86/tigerlake/pipeline.json          |  6 ++--
 3 files changed, 32 insertions(+), 8 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-ev=
ents/arch/x86/mapfile.csv
index 7c6598a9b240..6650100830c4 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -30,7 +30,7 @@ GenuineIntel-6-(37|4A|4C|4D|5A),v15,silvermont,core
 GenuineIntel-6-(4E|5E|8E|9E|A5|A6),v57,skylake,core
 GenuineIntel-6-55-[01234],v1.31,skylakex,core
 GenuineIntel-6-86,v1.21,snowridgex,core
-GenuineIntel-6-8[CD],v1.12,tigerlake,core
+GenuineIntel-6-8[CD],v1.13,tigerlake,core
 GenuineIntel-6-2C,v4,westmereep-dp,core
 GenuineIntel-6-25,v3,westmereep-sp,core
 GenuineIntel-6-2F,v3,westmereex,core
diff --git a/tools/perf/pmu-events/arch/x86/tigerlake/frontend.json b/tools=
/perf/pmu-events/arch/x86/tigerlake/frontend.json
index 23b8528590b3..d7b972452c0e 100644
--- a/tools/perf/pmu-events/arch/x86/tigerlake/frontend.json
+++ b/tools/perf/pmu-events/arch/x86/tigerlake/frontend.json
@@ -7,6 +7,14 @@
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
+    {
+        "BriefDescription": "Stalls caused by changing prefix length of th=
e instruction. [This event is alias to ILD_STALL.LCP]",
+        "EventCode": "0x87",
+        "EventName": "DECODE.LCP",
+        "PublicDescription": "Counts cycles that the Instruction Length de=
coder (ILD) stalls occurred due to dynamically changing prefix length of th=
e decoded instruction (by operand size prefix instruction 0x66, address siz=
e prefix instruction 0x67 or REX.W for Intel64). Count is proportional to t=
he number of prefixes in a 16B-line. This may result in a three-cycle penal=
ty for each LCP (Length changing prefix) in a 16-byte chunk. [This event is=
 alias to ILD_STALL.LCP]",
+        "SampleAfterValue": "500009",
+        "UMask": "0x1"
+    },
     {
         "BriefDescription": "Decode Stream Buffer (DSB)-to-MITE transition=
s count.",
         "CounterMask": "1",
@@ -213,10 +221,10 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Cycles where a code fetch is stalled due to L=
1 instruction cache miss.",
+        "BriefDescription": "Cycles where a code fetch is stalled due to L=
1 instruction cache miss. [This event is alias to ICACHE_DATA.STALLS]",
         "EventCode": "0x80",
         "EventName": "ICACHE_16B.IFDATA_STALL",
-        "PublicDescription": "Counts cycles where a code line fetch is sta=
lled due to an L1 instruction cache miss. The legacy decode pipeline works =
at a 16 Byte granularity.",
+        "PublicDescription": "Counts cycles where a code line fetch is sta=
lled due to an L1 instruction cache miss. The legacy decode pipeline works =
at a 16 Byte granularity. [This event is alias to ICACHE_DATA.STALLS]",
         "SampleAfterValue": "500009",
         "UMask": "0x4"
     },
@@ -237,10 +245,26 @@
         "UMask": "0x2"
     },
     {
-        "BriefDescription": "Cycles where a code fetch is stalled due to L=
1 instruction cache tag miss.",
+        "BriefDescription": "Cycles where a code fetch is stalled due to L=
1 instruction cache tag miss. [This event is alias to ICACHE_TAG.STALLS]",
         "EventCode": "0x83",
         "EventName": "ICACHE_64B.IFTAG_STALL",
-        "PublicDescription": "Counts cycles where a code fetch is stalled =
due to L1 instruction cache tag miss.",
+        "PublicDescription": "Counts cycles where a code fetch is stalled =
due to L1 instruction cache tag miss. [This event is alias to ICACHE_TAG.ST=
ALLS]",
+        "SampleAfterValue": "200003",
+        "UMask": "0x4"
+    },
+    {
+        "BriefDescription": "Cycles where a code fetch is stalled due to L=
1 instruction cache miss. [This event is alias to ICACHE_16B.IFDATA_STALL]"=
,
+        "EventCode": "0x80",
+        "EventName": "ICACHE_DATA.STALLS",
+        "PublicDescription": "Counts cycles where a code line fetch is sta=
lled due to an L1 instruction cache miss. The legacy decode pipeline works =
at a 16 Byte granularity. [This event is alias to ICACHE_16B.IFDATA_STALL]"=
,
+        "SampleAfterValue": "500009",
+        "UMask": "0x4"
+    },
+    {
+        "BriefDescription": "Cycles where a code fetch is stalled due to L=
1 instruction cache tag miss. [This event is alias to ICACHE_64B.IFTAG_STAL=
L]",
+        "EventCode": "0x83",
+        "EventName": "ICACHE_TAG.STALLS",
+        "PublicDescription": "Counts cycles where a code fetch is stalled =
due to L1 instruction cache tag miss. [This event is alias to ICACHE_64B.IF=
TAG_STALL]",
         "SampleAfterValue": "200003",
         "UMask": "0x4"
     },
diff --git a/tools/perf/pmu-events/arch/x86/tigerlake/pipeline.json b/tools=
/perf/pmu-events/arch/x86/tigerlake/pipeline.json
index 020801cbd7e3..541bf1dd1679 100644
--- a/tools/perf/pmu-events/arch/x86/tigerlake/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/tigerlake/pipeline.json
@@ -335,10 +335,10 @@
         "UMask": "0x80"
     },
     {
-        "BriefDescription": "Stalls caused by changing prefix length of th=
e instruction.",
+        "BriefDescription": "Stalls caused by changing prefix length of th=
e instruction. [This event is alias to DECODE.LCP]",
         "EventCode": "0x87",
         "EventName": "ILD_STALL.LCP",
-        "PublicDescription": "Counts cycles that the Instruction Length de=
coder (ILD) stalls occurred due to dynamically changing prefix length of th=
e decoded instruction (by operand size prefix instruction 0x66, address siz=
e prefix instruction 0x67 or REX.W for Intel64). Count is proportional to t=
he number of prefixes in a 16B-line. This may result in a three-cycle penal=
ty for each LCP (Length changing prefix) in a 16-byte chunk.",
+        "PublicDescription": "Counts cycles that the Instruction Length de=
coder (ILD) stalls occurred due to dynamically changing prefix length of th=
e decoded instruction (by operand size prefix instruction 0x66, address siz=
e prefix instruction 0x67 or REX.W for Intel64). Count is proportional to t=
he number of prefixes in a 16B-line. This may result in a three-cycle penal=
ty for each LCP (Length changing prefix) in a 16-byte chunk. [This event is=
 alias to DECODE.LCP]",
         "SampleAfterValue": "500009",
         "UMask": "0x1"
     },
@@ -564,7 +564,7 @@
         "BriefDescription": "TMA slots wasted due to incorrect speculation=
 by branch mispredictions",
         "EventCode": "0xa4",
         "EventName": "TOPDOWN.BR_MISPREDICT_SLOTS",
-        "PublicDescription": "Number of TMA slots that were wasted due to =
incorrect speculation by branch mispredictions. This event estimates number=
 of operations that were issued but not retired from the specualtive path a=
s well as the out-of-order engine recovery past a branch misprediction.",
+        "PublicDescription": "Number of TMA slots that were wasted due to =
incorrect speculation by branch mispredictions. This event estimates number=
 of operations that were issued but not retired from the speculative path a=
s well as the out-of-order engine recovery past a branch misprediction.",
         "SampleAfterValue": "10000003",
         "UMask": "0x8"
     },
--=20
2.41.0.162.gfafddb0af9-goog

