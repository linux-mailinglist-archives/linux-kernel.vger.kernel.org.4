Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 143615ED600
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 09:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233624AbiI1H0M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 03:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233442AbiI1HZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 03:25:04 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B89DDDED54
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 00:23:13 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id g6-20020a056902134600b006bbad6c9b78so497138ybu.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 00:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date;
        bh=vdKWTemQ9DTTzVyAUS1TSm5CZ2cRMr+rURsvAfxUbxM=;
        b=fH1c4SSlTs8fKc435IUOJAxdEjwsrveJOzZsJcCpH1mUh80MWVjx30u+uY2DNBCdzb
         v5keI53CJX9IcWkmlCE4PtrabwGdLHYfr2oxoJdGt1F05Ndm2x3W/jUY5HmjmiRLxH25
         tczDw7bw2/O7ROv0D6gwMY2/bv9H6e22LRnEGfxkpdzd4xC3fdiNlMV3a133vLFjg48Z
         uHXbt1+zydMvpctGe+jw7NymInAji5n9tjerSuz6dhKhXBj0jDuWedoHNWFFCQPvM9Hp
         1Op0uC2Bcpn1v68xAEXOAKcAFeD8kndu8wQE1NAp1c5oHyZQR/lBDNf860tyS3lkFE/D
         mTCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=vdKWTemQ9DTTzVyAUS1TSm5CZ2cRMr+rURsvAfxUbxM=;
        b=a+EvWqVZIi5gmn+1NkYNxps3wV50U+2X4pT1chWXqVfiOd6s/2cf9poP80+aGVp7jH
         teW8S71MYYNBGbaF/SltBGoACkAamdtJEFo36rKpjz3hexoqaLS9U5rwldot/q40tANB
         O1aDQrP26ZtVboHN6Q3ccmT/97/0a+t7Z4N/hD6eV5Pe60U4xBKfxvsad1HZRLR4WeAG
         BLzHxCcG7t2sYk3a0GOo0CZZiCt8m6+x5M5f7ZbSox6Z8qY4fpOrMEzFQPQYzS4NzeH6
         DG654GYXh/kwnUV3+jdF7BGYQieEEpwCYBFS/81RIjDAixcLAl8EOjJgsMJ6MvViedfq
         /EoA==
X-Gm-Message-State: ACrzQf1PYKXiSR2UWegZNbwWJWrY4IcsuxtHXe3Gn7Dy0vND9+zIHEoY
        Kw3VLQzaccGJkFaB5YMk7jkqVftYZOFs
X-Google-Smtp-Source: AMsMyM4RJEHWHMfsuhBdbj/k6uYQQtQrMjLUPCX7K6F94OVPaRTtU4R4F5+lj8Fa1CXOgHrrs1Mu8b/fobLt
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:7099:1ccb:612a:5ad6])
 (user=irogers job=sendgmr) by 2002:a81:b810:0:b0:340:cd15:875c with SMTP id
 v16-20020a81b810000000b00340cd15875cmr29053682ywe.42.1664349780207; Wed, 28
 Sep 2022 00:23:00 -0700 (PDT)
Date:   Wed, 28 Sep 2022 00:22:01 -0700
In-Reply-To: <20220928072204.1613330-1-irogers@google.com>
Message-Id: <20220928072204.1613330-20-irogers@google.com>
Mime-Version: 1.0
References: <20220928072204.1613330-1-irogers@google.com>
X-Mailer: git-send-email 2.37.3.998.g577e59143f-goog
Subject: [PATCH v1 19/22] perf vendor events: Update silvermont cpuids
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
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add cpuid that was added to https://download.01.org/perfmon/mapfile.csv

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/arch/x86/mapfile.csv | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-events/arch/x86/mapfile.csv
index 298ebda0c439..67ed9063eb54 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -21,7 +21,7 @@ GenuineIntel-6-1[AEF],v3,nehalemep,core
 GenuineIntel-6-2E,v3,nehalemex,core
 GenuineIntel-6-2A,v17,sandybridge,core
 GenuineIntel-6-8F,v1.06,sapphirerapids,core
-GenuineIntel-6-(37|4C|4D),v14,silvermont,core
+GenuineIntel-6-(37|4A|4C|4D),v14,silvermont,core
 GenuineIntel-6-(4E|5E|8E|9E|A5|A6),v53,skylake,core
 GenuineIntel-6-55-[01234],v1.28,skylakex,core
 GenuineIntel-6-86,v1.20,snowridgex,core
-- 
2.37.3.998.g577e59143f-goog

