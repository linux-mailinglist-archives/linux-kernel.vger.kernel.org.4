Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 367BF73BB49
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 17:13:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232585AbjFWPND (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 11:13:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232448AbjFWPL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 11:11:28 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDB2F30D3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 08:11:03 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-be47a3b3a01so982612276.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 08:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687533054; x=1690125054;
        h=content-transfer-encoding:to:from:subject:references:mime-version
         :message-id:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IH93V5eIpnR2f14b4ZM+Ftn03PloFxrPP2IsbOx78io=;
        b=6tkCJbVnTb3RbhEhWfNrcbBleyTdLKcoH8NxrgI6w7nekLZmENgfS3c5q9jhBBHuTu
         iOTX6pePyvOtTYb8HD1K+j8YBNuqGfguWzNkUweGqAzyYeEqpCzHkT8Y8PX+EgazWAYk
         HaMTfKkFuo+60ken5pcC6J7OHVsUf6EAkWDjhoEZL106YiQF0R2pFgjTTfX7TxJx6+UZ
         Q/xfgWvYk503yvpF+87pWcyhZdhUZZii6ZxSvunC0IYYgqAIgBA9JDAyCEFtTiACmEbz
         p2dmlOG/5mEeXKW8dlHv56lszM8yq3nv6QtCHQ0j1FXvKCXgNG2Zl5nmF/C5Q2k7iujQ
         0BqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687533054; x=1690125054;
        h=content-transfer-encoding:to:from:subject:references:mime-version
         :message-id:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IH93V5eIpnR2f14b4ZM+Ftn03PloFxrPP2IsbOx78io=;
        b=VRVZWsjd4Bxr/dGSfhATMZhNB18WCPk1Lf2Qvae8E6N2US631zlmeTLiPtjkO1fwnC
         cBsT4jEG2S9GGtzKe/gdMAEvVTKNjZDBme8MuKCPeUbQnCdJa+FEEiHzj0W0ojm4k++6
         Ni3+0nHlXkxBxs17+oY9fZbbITguGLtSQ924apmyQj7HpXpdqFbozbitym0sCIFvgIvd
         TBBHRffEJD/rrYMxFkIg3x7IBJULyrHFIp1oUQjb/7EJDRodnH/kOkZnA7um8YmV6eYh
         Ob+ZfHyh2NocWekSsbwc7/xMmfa9Hfd7HQVEPxIzCSkmYp4osWaDjrHkNkn12luuO5Yh
         458w==
X-Gm-Message-State: AC+VfDwf9MqHUmkIs5iHGGua7CgN/2E2lwlTzcyocKy9tqUNjYPXnfc4
        eSxnuZofoz64iVkoFbosIBhnuwtIHhjW
X-Google-Smtp-Source: ACHHUZ71YtrP9eh5uIUH9igGT/qEm2g0LFTYHAxBkIZbIHRYVa/8joz40XdnhBaCuGE4JQq7/AsUsZwZRbeo
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:6559:8968:cdfe:35b6])
 (user=irogers job=sendgmr) by 2002:a25:3444:0:b0:ba1:d0:7f7c with SMTP id
 b65-20020a253444000000b00ba100d07f7cmr3638441yba.2.1687533053943; Fri, 23 Jun
 2023 08:10:53 -0700 (PDT)
Date:   Fri, 23 Jun 2023 08:10:12 -0700
In-Reply-To: <20230623151016.4193660-1-irogers@google.com>
Message-Id: <20230623151016.4193660-9-irogers@google.com>
Mime-Version: 1.0
References: <20230623151016.4193660-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Subject: [PATCH v2 08/12] perf vendor events intel: Update icelakex to 1.21
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
https://github.com/intel/perfmon/commit/78d47cbbae48a0297a507ae4fea234ff37f=
f9960
Adds the events ICACHE_DATA.STALLS, ICACHE_TAG.STALLS and
DECODE.LCP. Descriptions are also updated.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../arch/x86/icelakex/frontend.json           | 32 ++++++++++++++++---
 .../arch/x86/icelakex/pipeline.json           |  4 +--
 .../x86/icelakex/uncore-interconnect.json     |  2 +-
 tools/perf/pmu-events/arch/x86/mapfile.csv    |  2 +-
 4 files changed, 32 insertions(+), 8 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/icelakex/frontend.json b/tools/=
perf/pmu-events/arch/x86/icelakex/frontend.json
index 71498044f1cb..f6edc4222f42 100644
--- a/tools/perf/pmu-events/arch/x86/icelakex/frontend.json
+++ b/tools/perf/pmu-events/arch/x86/icelakex/frontend.json
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
diff --git a/tools/perf/pmu-events/arch/x86/icelakex/pipeline.json b/tools/=
perf/pmu-events/arch/x86/icelakex/pipeline.json
index 442a4c7539dd..176e5ef2a24a 100644
--- a/tools/perf/pmu-events/arch/x86/icelakex/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/icelakex/pipeline.json
@@ -318,10 +318,10 @@
         "UMask": "0x40"
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
diff --git a/tools/perf/pmu-events/arch/x86/icelakex/uncore-interconnect.js=
on b/tools/perf/pmu-events/arch/x86/icelakex/uncore-interconnect.json
index 8ac5907762e1..f87ea3f66d1b 100644
--- a/tools/perf/pmu-events/arch/x86/icelakex/uncore-interconnect.json
+++ b/tools/perf/pmu-events/arch/x86/icelakex/uncore-interconnect.json
@@ -9311,7 +9311,7 @@
         "EventCode": "0x50",
         "EventName": "UNC_M3UPI_RxC_HELD.PARALLEL_SUCCESS",
         "PerPkg": "1",
-        "PublicDescription": "Message Held : Parallel Success : ad and bl =
messages were actually slotted into the same flit in paralle",
+        "PublicDescription": "Message Held : Parallel Success : ad and bl =
messages were actually slotted into the same flit in parallel",
         "UMask": "0x8",
         "Unit": "M3UPI"
     },
diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-ev=
ents/arch/x86/mapfile.csv
index d63c9df8f65d..98828c3a9cde 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -14,7 +14,7 @@ GenuineIntel-6-A[DE],v1.01,graniterapids,core
 GenuineIntel-6-(3C|45|46),v33,haswell,core
 GenuineIntel-6-3F,v27,haswellx,core
 GenuineIntel-6-7[DE],v1.19,icelake,core
-GenuineIntel-6-6[AC],v1.20,icelakex,core
+GenuineIntel-6-6[AC],v1.21,icelakex,core
 GenuineIntel-6-3A,v24,ivybridge,core
 GenuineIntel-6-3E,v23,ivytown,core
 GenuineIntel-6-2D,v23,jaketown,core
--=20
2.41.0.162.gfafddb0af9-goog

