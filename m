Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AADCF6B8A6B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 06:34:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbjCNFeC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 01:34:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbjCNFdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 01:33:55 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 552631D929
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 22:33:49 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id i11-20020a256d0b000000b0086349255277so15889024ybc.8
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 22:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678772028;
        h=content-transfer-encoding:to:from:subject:references:mime-version
         :message-id:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZN1Gr4cUK1R0e+uW4iffwT2ufvFXlj3aIL35F5q+UY0=;
        b=mm5VYdj8thJ51OLG4h8+yTKPSgdTUZlzGgYAlILn9MikIuGggwk630VBO2WYP3M+p2
         cuXCIIskCu6eXRV2qWJDYKy0uvxx79JNqAEeZan9A9NaAZD2p/X/x5j863AbwBGUcKxE
         /gEl1qzjzNoBB0Ftly68bS3ikNCZuFvi89cFIehB7ZnibC3a9xlF1Q4ebTs0qy3BZ4GK
         +SGEXtkgILMJCW2bMe8VhjsbKCn+yUjZ+1fNqH81rVOzCyKqWnjsiT4oSyX/VpAfVPS0
         epkZOI+fp5h3Bwioo4yW75QjAIc8LRmvujxyZ8qGc+j7T6RZ+CYUYXuKIwUcPJ8sNba+
         vKNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678772028;
        h=content-transfer-encoding:to:from:subject:references:mime-version
         :message-id:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZN1Gr4cUK1R0e+uW4iffwT2ufvFXlj3aIL35F5q+UY0=;
        b=Y5o8+kopHnAI3MJLuZAfnOE9qcQ6fZuPXNGJwzdHazzsIyRJXhJPJHG+p1T42UIXZc
         Iqfj5ObyRl8eyfA36OFmMNqwAriyxgp+WVRdho0DoP3jgB15CK3ZjW5Rb3Axaj5tz5iT
         HMjEgZfcRqMBokOyb8CX1uI+fNWwmN79i37h1cmYsJmHLIyIF4QzcBIGg4/EB8axkhCZ
         bkmTd9c+uPx4/YCSJWMrUuF8NvRJ3yHwFkUazYuNxaQtA9mdqGLIpAbTNlIL4aTiHA4h
         Go6BhezXpGAkwhQfZ6FxbdMybK4uvCS1iaGv0Kr0Hiwhz1icaDFpuKxvZQfvB0auQm+f
         hJ0Q==
X-Gm-Message-State: AO0yUKWReq3RMp1Lb7kIMjdpbKN89ShANLGlrrH5NfHqw86YVIQGKeBq
        JAbrMi42Ncwmegy2Dn2wB3sMwvjUz1hZ
X-Google-Smtp-Source: AK7set8cTUSSw/4Xj3xNrSv87tnEqLa6Aqu8ECjJeei5Hob+ci2JD8bGm5rtTcXr8OGeRotRSXCfk47wboyg
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:adc3:d11e:dcd7:fd4e])
 (user=irogers job=sendgmr) by 2002:a05:6902:10e:b0:98e:6280:74ca with SMTP id
 o14-20020a056902010e00b0098e628074camr20485554ybh.1.1678772028608; Mon, 13
 Mar 2023 22:33:48 -0700 (PDT)
Date:   Mon, 13 Mar 2023 22:33:12 -0700
In-Reply-To: <20230314053312.3237390-1-irogers@google.com>
Message-Id: <20230314053312.3237390-4-irogers@google.com>
Mime-Version: 1.0
References: <20230314053312.3237390-1-irogers@google.com>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
Subject: [PATCH v1 3/3] perf vendor events intel: Update skylake events
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Edward Baker <edward.baker@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update from v54 to v55. Addition of OFFCORE_RESPONSE,
FP_ARITH_INST_RETIRED.SCALAR, FP_ARITH_INST_RETIRED.VECTOR and
INT_MISC.CLEARS_COUNT.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/arch/x86/mapfile.csv        |  2 +-
 tools/perf/pmu-events/arch/x86/skylake/cache.json |  8 ++++++++
 .../arch/x86/skylake/floating-point.json          | 15 +++++++++++++++
 .../pmu-events/arch/x86/skylake/pipeline.json     | 10 ++++++++++
 4 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-ev=
ents/arch/x86/mapfile.csv
index 34431709f7d0..9abebe50ae0d 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -24,7 +24,7 @@ GenuineIntel-6-2E,v3,nehalemex,core
 GenuineIntel-6-2A,v18,sandybridge,core
 GenuineIntel-6-(8F|CF),v1.11,sapphirerapids,core
 GenuineIntel-6-(37|4A|4C|4D|5A),v15,silvermont,core
-GenuineIntel-6-(4E|5E|8E|9E|A5|A6),v54,skylake,core
+GenuineIntel-6-(4E|5E|8E|9E|A5|A6),v55,skylake,core
 GenuineIntel-6-55-[01234],v1.29,skylakex,core
 GenuineIntel-6-86,v1.20,snowridgex,core
 GenuineIntel-6-8[CD],v1.10,tigerlake,core
diff --git a/tools/perf/pmu-events/arch/x86/skylake/cache.json b/tools/perf=
/pmu-events/arch/x86/skylake/cache.json
index 0080ac27b899..ce592d871949 100644
--- a/tools/perf/pmu-events/arch/x86/skylake/cache.json
+++ b/tools/perf/pmu-events/arch/x86/skylake/cache.json
@@ -553,6 +553,14 @@
         "SampleAfterValue": "2000003",
         "UMask": "0x4"
     },
+    {
+        "BriefDescription": "Offcore response can be programmed only with =
a specific pair of event select and counter MSR, and with specific event co=
des and predefine mask bit value in a dedicated MSR to specify attributes o=
f the offcore transaction",
+        "EventCode": "0xB7, 0xBB",
+        "EventName": "OFFCORE_RESPONSE",
+        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
     {
         "BriefDescription": "Counts all demand code reads have any respons=
e type.",
         "EventCode": "0xB7, 0xBB",
diff --git a/tools/perf/pmu-events/arch/x86/skylake/floating-point.json b/t=
ools/perf/pmu-events/arch/x86/skylake/floating-point.json
index eb83fa537e7d..4d494a5cabbf 100644
--- a/tools/perf/pmu-events/arch/x86/skylake/floating-point.json
+++ b/tools/perf/pmu-events/arch/x86/skylake/floating-point.json
@@ -31,6 +31,14 @@
         "SampleAfterValue": "2000003",
         "UMask": "0x20"
     },
+    {
+        "BriefDescription": "Counts once for most SIMD scalar computationa=
l floating-point instructions retired. Counts twice for DPP and FM(N)ADD/SU=
B instructions retired.",
+        "EventCode": "0xC7",
+        "EventName": "FP_ARITH_INST_RETIRED.SCALAR",
+        "PublicDescription": "Counts once for most SIMD scalar computation=
al single precision and double precision floating-point instructions retire=
d; some instructions will count twice as noted below.  Each count represent=
s 1 computational operation. Applies to SIMD scalar single precision floati=
ng-point instructions: ADD SUB MUL DIV MIN MAX SQRT RSQRT RCP FM(N)ADD/SUB.=
  FM(N)ADD/SUB instructions count twice as they perform 2 calculations per =
element. The DAZ and FTZ flags in the MXCSR register need to be set when us=
ing these events.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x3"
+    },
     {
         "BriefDescription": "Counts once for most SIMD scalar computationa=
l double precision floating-point instructions retired. Counts twice for DP=
P and FM(N)ADD/SUB instructions retired.",
         "EventCode": "0xC7",
@@ -47,6 +55,13 @@
         "SampleAfterValue": "2000003",
         "UMask": "0x2"
     },
+    {
+        "BriefDescription": "Number of any Vector retired FP arithmetic in=
structions",
+        "EventCode": "0xC7",
+        "EventName": "FP_ARITH_INST_RETIRED.VECTOR",
+        "SampleAfterValue": "2000003",
+        "UMask": "0xfc"
+    },
     {
         "BriefDescription": "Cycles with any input/output SSE or FP assist=
",
         "CounterMask": "1",
diff --git a/tools/perf/pmu-events/arch/x86/skylake/pipeline.json b/tools/p=
erf/pmu-events/arch/x86/skylake/pipeline.json
index 2c827d806554..2dfc3af08eff 100644
--- a/tools/perf/pmu-events/arch/x86/skylake/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/skylake/pipeline.json
@@ -404,6 +404,16 @@
         "SampleAfterValue": "2000003",
         "UMask": "0x1"
     },
+    {
+        "AnyThread": "1",
+        "BriefDescription": "Clears speculative count",
+        "CounterMask": "1",
+        "EventCode": "0x0D",
+        "EventName": "INT_MISC.CLEARS_COUNT",
+        "PublicDescription": "Counts the number of speculative clears due =
to any type of branch misprediction or machine clears",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x1"
+    },
     {
         "BriefDescription": "Cycles the issue-stage is waiting for front-e=
nd to fetch from resteered path following branch misprediction or machine c=
lear events.",
         "EventCode": "0x0D",
--=20
2.40.0.rc1.284.g88254d51c5-goog

