Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1BC86DE83F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 01:45:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbjDKXpa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 19:45:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbjDKXpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 19:45:22 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BC7F4C24
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 16:45:12 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 184-20020a2515c1000000b009419f64f6afso10625085ybv.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 16:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681256711;
        h=content-transfer-encoding:to:from:subject:references:mime-version
         :message-id:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d/T/xU2Yq1vEePI3qmWUebnXaaSA90g08mbqWgT1W7g=;
        b=kFpOWipksCFKkTuBB67SPcDa84cXE/AcAl5wC7jtN/tR8oVz0EqII+UlF1WKDUSnVL
         KlF43QwLk4z5PtA7qAdnLjjmAuezxP2zSoEjKP2cu8eJIuPCXjxmTdK0hFIfMfXMIwAN
         lJ0oCwsW/076uHgz7Ms+0m/uYBmkWuWd7Aa5bo0ouuKyeLVo3gw6MyNQdu/cSuRVmcyH
         4UOB4C91h1oRlpMKKnMCiwno0nvKW1pGPZiIVKTwmDJKBJ2ZFTvXrUg7rWygJsjU/4P1
         apSgn3xZreHvd9unH0kkW5QhxDFEhQ6CbfepmQY0opKgJT5EqotDnELC64VNMZDYqIYz
         TRAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681256711;
        h=content-transfer-encoding:to:from:subject:references:mime-version
         :message-id:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=d/T/xU2Yq1vEePI3qmWUebnXaaSA90g08mbqWgT1W7g=;
        b=OFXd/8XR+NvlLnG6Pv8galFoHmGvSVPEK2JEF56Ck98VwoJTe+GcQsWuONFKcFPD0L
         w234LVwNfn54t2g7X0sM6g7S+6Lll5NaD4HBZE+BgvFl/pYLoeQ/SW5k+oVEpo+u/f28
         mP+6/EtjUaKQKwUBnPV1s0Mar0AncMba1j5p3JdUN4Zy5FNWX3RkcUS7sql1Wznd5uWE
         MgOTHnJnhkOSWwSxPCw1if+zTc9U66nb1R/kj/LMjtfAd2lYNVM9jmvE+1N9LSDmlXU0
         7hONu1lxBSvGxLNmXghkLJm9oCsTL70WXiTtA9m+uRhpvyjYkY3KfhSCbGhVHQ77wDbh
         4xkQ==
X-Gm-Message-State: AAQBX9dB0ZPJs+nGbbYcHfLw0Dnn+3QDr1gUpWctVXpUAZbM64yj6Z6O
        P0IPub4zCcJNCNvBrKkU2pTxCnB0AOk1
X-Google-Smtp-Source: AKy350b9Wk2xCPmmLf4lePEkpgpZ7ITKF2nGF7HAaI42QviYndH0AFqfwFszHKGB2NTFLAys0zyYXnyd9Stc
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:f663:83e0:f9b2:5a17])
 (user=irogers job=sendgmr) by 2002:a25:76c7:0:b0:b75:8ac3:d5d2 with SMTP id
 r190-20020a2576c7000000b00b758ac3d5d2mr437284ybc.4.1681256711807; Tue, 11 Apr
 2023 16:45:11 -0700 (PDT)
Date:   Tue, 11 Apr 2023 16:44:39 -0700
In-Reply-To: <20230411234440.3313680-1-irogers@google.com>
Message-Id: <20230411234440.3313680-3-irogers@google.com>
Mime-Version: 1.0
References: <20230411234440.3313680-1-irogers@google.com>
X-Mailer: git-send-email 2.40.0.577.gac1e443424-goog
Subject: [PATCH v1 2/3] perf vendor events: Update icelakex to v1.20
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
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
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

Update from v1.19 to v1.20 affecting the uncore
UNC_CHA_CORE_SNP.REMOTE_GTONE event's umask.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/arch/x86/icelakex/uncore-other.json | 2 +-
 tools/perf/pmu-events/arch/x86/mapfile.csv                | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/icelakex/uncore-other.json b/to=
ols/perf/pmu-events/arch/x86/icelakex/uncore-other.json
index 8210e286eec1..134b54da0869 100644
--- a/tools/perf/pmu-events/arch/x86/icelakex/uncore-other.json
+++ b/tools/perf/pmu-events/arch/x86/icelakex/uncore-other.json
@@ -981,7 +981,7 @@
         "EventName": "UNC_CHA_CORE_SNP.REMOTE_GTONE",
         "PerPkg": "1",
         "PublicDescription": "Core Cross Snoops Issued : Multiple Snoop Ta=
rgets from Remote : Counts the number of transactions that trigger a config=
urable number of cross snoops.  Cores are snooped if the transaction looks =
up the cache and determines that it is necessary based on the operation typ=
e and what CoreValid bits are set.  For example, if 2 CV bits are set on a =
data read, the cores must have the data in S state so it is not necessary t=
o snoop them.  However, if only 1 CV bit is set the core my have modified t=
he data.  If the transaction was an RFO, it would need to invalidate the li=
nes.  This event can be filtered based on who triggered the initial snoop(s=
).",
-        "UMask": "0x22",
+        "UMask": "0x12",
         "Unit": "CHA"
     },
     {
diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-ev=
ents/arch/x86/mapfile.csv
index 9e7545d09b23..58faf18474b5 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -13,7 +13,7 @@ GenuineIntel-6-A[DE],v1.01,graniterapids,core
 GenuineIntel-6-(3C|45|46),v33,haswell,core
 GenuineIntel-6-3F,v27,haswellx,core
 GenuineIntel-6-(7D|7E|A7),v1.17,icelake,core
-GenuineIntel-6-6[AC],v1.19,icelakex,core
+GenuineIntel-6-6[AC],v1.20,icelakex,core
 GenuineIntel-6-3A,v24,ivybridge,core
 GenuineIntel-6-3E,v23,ivytown,core
 GenuineIntel-6-2D,v23,jaketown,core
--=20
2.40.0.577.gac1e443424-goog

