Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 297375ED5F3
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 09:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233508AbiI1HYE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 03:24:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233504AbiI1HWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 03:22:37 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF074D824E
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 00:22:33 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-349e6acbac9so113792057b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 00:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date;
        bh=+uljP0IZBjEa6liP5N6VFozdPRq+OISBI0t9P6nIUUs=;
        b=LLnH2QbvqYr/N0WnuyBjktiKaCnxyRBNo+CLSudb/qnwNtnvwYV7BdBbn4o77dTPGl
         genLbayfWUogTwUcdFKGTSvDUYRBQ+6dimv5mmv61jRaGTP/N/pJlIm6LpgGCG/57htZ
         z4JJndAW7WgN14TaflATNaVpA+XjXAwYLIT5GAetS1VenRcELnaMxP0whQQyRL2xWdyZ
         eDNUkmSkU0tL+uwBT5P7xYKenwboqJCpW+UXUH8vBtyguTrIBZyBIPLF8r5G6sM3pKla
         jd6K9iv/0kr5/otWKVDqlLornKruv8xnKZDvzGgNOv5YazUpWzunOD/MBpF5ibH1/ctP
         rXyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=+uljP0IZBjEa6liP5N6VFozdPRq+OISBI0t9P6nIUUs=;
        b=HD99zZGKuv2t/XEIjFPT832Oi/qMlmyU+c2mVT71j4wmQNJatuSiucgocPOmq9Z/Ml
         LDN4y1arS38JGhfo9jUGr5xTYlqoidh5KdjkqzjHwkCM36JF+voPR5ROs88FtJFBCN3e
         QAu0advgjh/uklo3qfZxV5IG7XhQFrIPPofoIE9XXiHIVqxjz6JDb47EZWck+CIh2pOJ
         CY+kODBJ++4ZbR0HFJP6u4yWvzeQgPpwfQaeifBRzOUkff+Tm1i8QJT7kJBLqcgxzHpH
         uUFjPtXOL3IZCvDHUd472gdaRwO2WCAyiWu9811oj6DskXm4oqO7vEmyB3jDy/fFLcQz
         PgtA==
X-Gm-Message-State: ACrzQf03yXIaV0zyZ5wmR/8eZy5EVQlpbsWrdJNxdDJz6clY57riri0z
        pGkOA8amayts+zrZDIwYDR+Ed65EuI8l
X-Google-Smtp-Source: AMsMyM5hap4jwoKcGPXXMuVVlOc8GWTYTyBREFQxWtYbxD2Mxz56HU7aNCiuuS3DoI+0x2mtIaMmvWFQ7enE
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:7099:1ccb:612a:5ad6])
 (user=irogers job=sendgmr) by 2002:a81:8103:0:b0:345:62dd:a9a7 with SMTP id
 r3-20020a818103000000b0034562dda9a7mr28435005ywf.330.1664349752544; Wed, 28
 Sep 2022 00:22:32 -0700 (PDT)
Date:   Wed, 28 Sep 2022 00:21:51 -0700
In-Reply-To: <20220928072204.1613330-1-irogers@google.com>
Message-Id: <20220928072204.1613330-10-irogers@google.com>
Mime-Version: 1.0
References: <20220928072204.1613330-1-irogers@google.com>
X-Mailer: git-send-email 2.37.3.998.g577e59143f-goog
Subject: [PATCH v1 09/22] perf vendor events: Update elkhartlake cpuids
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
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
index 594c6e96f0ce..6d0cd5030743 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -5,7 +5,7 @@ GenuineIntel-6-(3D|47),v26,broadwell,core
 GenuineIntel-6-56,v23,broadwellde,core
 GenuineIntel-6-4F,v19,broadwellx,core
 GenuineIntel-6-55-[56789ABCDEF],v1.16,cascadelakex,core
-GenuineIntel-6-96,v1.03,elkhartlake,core
+GenuineIntel-6-9[6C],v1.03,elkhartlake,core
 GenuineIntel-6-5[CF],v13,goldmont,core
 GenuineIntel-6-7A,v1.01,goldmontplus,core
 GenuineIntel-6-(3C|45|46),v31,haswell,core
-- 
2.37.3.998.g577e59143f-goog

