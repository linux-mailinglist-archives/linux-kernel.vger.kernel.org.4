Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FA036F4D0A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 00:42:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbjEBWmr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 18:42:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbjEBWmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 18:42:21 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12207359F
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 15:41:58 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-552f2f940edso84358317b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 May 2023 15:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683067308; x=1685659308;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ub3nsWvIc7LdAE08OZJfmvPZS6krUrWnEa75g5zW2eY=;
        b=AOK1HC/vf5yI5ql5xcP5VyEU2FXfzZB2Kmq1GuA4h4OL/07Yh4rwN64HQkYCe5v1Bn
         uiJx9+PL/bleEnQvS+kPi2bu9wb6NnOUz+zaGla9geQwfPGv2mqCuN4pmSQignFH8i0k
         Dkt74qsBq2zwe3IR2gfljagbPd7k4p44KYhVJ0CgalJJQm+V2b2+T5/PoWqDu86RxDXJ
         3vc42n7qnd99938EmEO8L2p3w5yLbSKtUudkwPl3vtANbsh94aCW4i6lGpdJyQsdfmUq
         yDGe1dmN7j3yLTJOIIV93fDRMNKkF4srjV7tgxWv32gTOkhC+6AZ+BF3FWw2KQUhCN5O
         e7Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683067308; x=1685659308;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ub3nsWvIc7LdAE08OZJfmvPZS6krUrWnEa75g5zW2eY=;
        b=Ko+XQK1pKWibBwW80gTHPNAsz+IcS6jrVEDX9D9hJqcGtCntoG8vqCrElc6G23ZiBN
         VMamUXng37ctp/cgnfe7MfVuDJGKZYrQMiU3d2ZbpZbWtDt3bDxfoKUyZUbA8vX2B7xw
         E3RYLVL/Z3D7+IOC5ATgBWmx01m9LOFc31oYyFCT1r2c2QXDWXMsJyEOnFEgo1HcGmMd
         aLPGkyKx637iFJzKzDJcH4rNHlvxw9xmZWkIJ6V2ieHMiHGIxh6sT6y9BVCOgJlbXM9l
         wjtQzo/dmosX7wbD27m0/DHzLILxQGT3hjKusOOAh/bh9x0iwXG1++EJ0mi1i4NpuN2h
         VOcA==
X-Gm-Message-State: AC+VfDwzoP+YhAsJWW8tsA93OfCwnbDp3UGCMldnyC0OkzLjElAoXCs1
        /EwjGhAKJq/+xyIVrs86e/TPn79AdDWR
X-Google-Smtp-Source: ACHHUZ5O5QDTGQhFxpgi0A658hMse1rEsdLbBsf0gMGIcJSpwIugw8qyRTL5V1lyZ7qI72XFYeTyIpcCCKbr
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:e70c:446b:d23b:982e])
 (user=irogers job=sendgmr) by 2002:a81:7e41:0:b0:556:9897:e2c7 with SMTP id
 p1-20020a817e41000000b005569897e2c7mr11611032ywn.3.1683067308397; Tue, 02 May
 2023 15:41:48 -0700 (PDT)
Date:   Tue,  2 May 2023 15:38:28 -0700
In-Reply-To: <20230502223851.2234828-1-irogers@google.com>
Message-Id: <20230502223851.2234828-22-irogers@google.com>
Mime-Version: 1.0
References: <20230502223851.2234828-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Subject: [PATCH v4 21/44] perf test x86 hybrid: Update test expectations
From:   Ian Rogers <irogers@google.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ahmad Yasin <ahmad.yasin@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Samantha Alt <samantha.alt@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>,
        Weilin Wang <weilin.wang@intel.com>,
        Edward Baker <edward.baker@intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        Rob Herring <robh@kernel.org>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        John Garry <john.g.garry@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Leo Yan <leo.yan@linaro.org>,
        Yang Jihong <yangjihong1@huawei.com>,
        James Clark <james.clark@arm.com>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        Kang Minchul <tegongkang@gmail.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't assume evlist order. Switch to a loop rather than depend on
evlist order for raw events test.

Update hybrid event expectations. Previous values were based on
parsing legacy hardware events from sysfs, update to the correct PMU
specific legacy values.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/x86/tests/hybrid.c | 54 ++++++++++++++----------------
 1 file changed, 26 insertions(+), 28 deletions(-)

diff --git a/tools/perf/arch/x86/tests/hybrid.c b/tools/perf/arch/x86/tests/hybrid.c
index 0f99cfd116ee..d2a173ba3db9 100644
--- a/tools/perf/arch/x86/tests/hybrid.c
+++ b/tools/perf/arch/x86/tests/hybrid.c
@@ -11,13 +11,18 @@ static bool test_config(const struct evsel *evsel, __u64 expected_config)
 	return (evsel->core.attr.config & PERF_HW_EVENT_MASK) == expected_config;
 }
 
+static bool test_perf_config(const struct perf_evsel *evsel, __u64 expected_config)
+{
+	return (evsel->attr.config & PERF_HW_EVENT_MASK) == expected_config;
+}
+
 static int test__hybrid_hw_event_with_pmu(struct evlist *evlist)
 {
 	struct evsel *evsel = evlist__first(evlist);
 
 	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->core.nr_entries);
-	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config", test_config(evsel, 0x3c));
+	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
+	TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_CPU_CYCLES));
 	return TEST_OK;
 }
 
@@ -27,13 +32,13 @@ static int test__hybrid_hw_group_event(struct evlist *evlist)
 
 	evsel = leader = evlist__first(evlist);
 	TEST_ASSERT_VAL("wrong number of entries", 2 == evlist->core.nr_entries);
-	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config", test_config(evsel, 0x3c));
+	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
+	TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_CPU_CYCLES));
 	TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
 
 	evsel = evsel__next(evsel);
-	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config", test_config(evsel, 0xc0));
+	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
+	TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_INSTRUCTIONS));
 	TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
 	return TEST_OK;
 }
@@ -48,8 +53,8 @@ static int test__hybrid_sw_hw_group_event(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
 
 	evsel = evsel__next(evsel);
-	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config", test_config(evsel, 0x3c));
+	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
+	TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_CPU_CYCLES));
 	TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
 	return TEST_OK;
 }
@@ -60,8 +65,8 @@ static int test__hybrid_hw_sw_group_event(struct evlist *evlist)
 
 	evsel = leader = evlist__first(evlist);
 	TEST_ASSERT_VAL("wrong number of entries", 2 == evlist->core.nr_entries);
-	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config", test_config(evsel, 0x3c));
+	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
+	TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_CPU_CYCLES));
 	TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
 
 	evsel = evsel__next(evsel);
@@ -76,15 +81,15 @@ static int test__hybrid_group_modifier1(struct evlist *evlist)
 
 	evsel = leader = evlist__first(evlist);
 	TEST_ASSERT_VAL("wrong number of entries", 2 == evlist->core.nr_entries);
-	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config", test_config(evsel, 0x3c));
+	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
+	TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_CPU_CYCLES));
 	TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
 	TEST_ASSERT_VAL("wrong exclude_user", evsel->core.attr.exclude_user);
 	TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
 
 	evsel = evsel__next(evsel);
-	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config", test_config(evsel, 0xc0));
+	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
+	TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_INSTRUCTIONS));
 	TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
 	TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
 	TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
@@ -93,22 +98,15 @@ static int test__hybrid_group_modifier1(struct evlist *evlist)
 
 static int test__hybrid_raw1(struct evlist *evlist)
 {
-	struct evsel *evsel = evlist__first(evlist);
+	struct perf_evsel *evsel;
 
-	if (!perf_pmu__hybrid_mounted("cpu_atom")) {
-		TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->core.nr_entries);
-		TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type);
-		TEST_ASSERT_VAL("wrong config", test_config(evsel, 0x1a));
-		return TEST_OK;
-	}
-
-	TEST_ASSERT_VAL("wrong number of entries", 2 == evlist->core.nr_entries);
-	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config", test_config(evsel, 0x1a));
+	perf_evlist__for_each_evsel(&evlist->core, evsel) {
+		struct perf_pmu *pmu = perf_pmu__find_by_type(evsel->attr.type);
 
-	/* The type of second event is randome value */
-	evsel = evsel__next(evsel);
-	TEST_ASSERT_VAL("wrong config", test_config(evsel, 0x1a));
+		TEST_ASSERT_VAL("missing pmu", pmu);
+		TEST_ASSERT_VAL("unexpected pmu", !strncmp(pmu->name, "cpu_", 4));
+		TEST_ASSERT_VAL("wrong config", test_perf_config(evsel, 0x1a));
+	}
 	return TEST_OK;
 }
 
-- 
2.40.1.495.gc816e09b53d-goog

