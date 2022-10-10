Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4E165F97E0
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 07:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231621AbiJJFhW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 01:37:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231465AbiJJFgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 01:36:47 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BD6752DE4;
        Sun,  9 Oct 2022 22:36:24 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id n7so9475861plp.1;
        Sun, 09 Oct 2022 22:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EBjLzWT4H/vt1QWp8fOXfPXN2QfGxxbM4NV5HB9FiQk=;
        b=bVubwEWTfdZTa5pkj5Gr5K1Qhl1TwPXotTcXc4H6Nr9JvJuZr1NhaqVPl8e0jGq+Tn
         CiGLDe7BgkFt7UXhJII5A1crkqXjXwaT8JhWkPZl41oCRDksvB89Eb7H1XxSr685KgVf
         OYdHBVgGfrrpKOmDTOYz5QioeIJ1k63JgWlthpQwHsBwemM+ULBkPfnDEPB/MfKn3YYb
         iFg5kwj4ehOAYvtMTPjo9u7PyqLN2a+0mj6/4PVzkiZk0Or/Sm62aDRHwImdnqUpXIPG
         LoRppq7QLk8w1ATJG25iy2H4z7eb3+N86WqdCRVMDyT30tUBzoWXUU3SOhzq7hegKpgy
         WqUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EBjLzWT4H/vt1QWp8fOXfPXN2QfGxxbM4NV5HB9FiQk=;
        b=G2YP3hz3gpDsKVkSJr3ypUAq0/8+mj+8GFS6UdAJeYDYOGKhTJK65TIyPtsec4XB3J
         Xbqk51fEtxHzCRWrVlYeW/vu1Hq5XCrXR6rB++U81j/bUeFWD9BwO17OwX1BDZEIsElg
         1dTBYaKFj+DQ61B7/2nUqEx/KktQzDDzd4d5uwshEPtheGL2qUqKkI4g5f9tpJKsBv72
         FLYcYDDZDeE2Hgn/moaKTnUxs/Jz80D8ABvUAYLpMoebIx789Kk3zfJMk4ISf+UKoKyg
         opDBj1xtWv/AQWwedMUiPJf5CG8HgX1zSnVanUbMksWf2JP9oeAufLVmTS7KDhwMT8AT
         x/cQ==
X-Gm-Message-State: ACrzQf1NFr+CVIl32P3ZEo4/unoYu7p1TLmTnxVT088KHV6pADBx3b52
        OkHueVqRH/FGCWk8qeFOnHM=
X-Google-Smtp-Source: AMsMyM7/+oFP6IGDgIkzPiI50CR1aOxv9nOUDzYIMxyKofU1vUrK5drs+jiEru6x5U4uFa1irFQKMA==
X-Received: by 2002:a17:903:509:b0:179:ffcf:d275 with SMTP id jn9-20020a170903050900b00179ffcfd275mr17235764plb.150.1665380183687;
        Sun, 09 Oct 2022 22:36:23 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:1040:862f:cd0e:bf30:6d69])
        by smtp.gmail.com with ESMTPSA id u13-20020a170902e80d00b0017f7e0f4a4esm5667594plg.35.2022.10.09.22.36.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Oct 2022 22:36:23 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>, Andi Kleen <ak@linux.intel.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        James Clark <james.clark@arm.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>
Subject: [PATCH 14/19] perf stat: Add perf_stat_merge_counters()
Date:   Sun,  9 Oct 2022 22:35:55 -0700
Message-Id: <20221010053600.272854-15-namhyung@kernel.org>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
In-Reply-To: <20221010053600.272854-1-namhyung@kernel.org>
References: <20221010053600.272854-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The perf_stat_merge_counters() is to aggregate the same events in different
PMUs like in case of uncore or hybrid.  The same logic is in the stat-display
routines but I think it should be handled when it processes the event counters.

As it works on the aggr_counters, it doesn't change the output yet.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-stat.c |  2 +
 tools/perf/util/stat.c    | 96 +++++++++++++++++++++++++++++++++++++++
 tools/perf/util/stat.h    |  2 +
 3 files changed, 100 insertions(+)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 49a7e290d778..f90e8f29cb23 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -486,6 +486,8 @@ static void process_counters(void)
 			pr_warning("failed to process counter %s\n", counter->name);
 		counter->err = 0;
 	}
+
+	perf_stat_merge_counters(&stat_config, evsel_list);
 }
 
 static void process_interval(void)
diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index 4edfc1c5dc07..1bb197782a34 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -575,6 +575,102 @@ int perf_stat_process_counter(struct perf_stat_config *config,
 	return 0;
 }
 
+static int evsel__merge_aggr_counters(struct evsel *evsel, struct evsel *alias)
+{
+	struct perf_stat_evsel *ps_a = evsel->stats;
+	struct perf_stat_evsel *ps_b = alias->stats;
+	int i;
+
+	if (ps_a->aggr == NULL && ps_b->aggr == NULL)
+		return 0;
+
+	if (ps_a->nr_aggr != ps_b->nr_aggr) {
+		pr_err("Unmatched aggregation mode between aliases\n");
+		return -1;
+	}
+
+	for (i = 0; i < ps_a->nr_aggr; i++) {
+		struct perf_counts_values *aggr_counts_a = &ps_a->aggr[i].counts;
+		struct perf_counts_values *aggr_counts_b = &ps_b->aggr[i].counts;
+
+		/* NB: don't increase aggr.nr for aliases */
+
+		aggr_counts_a->val += aggr_counts_b->val;
+		aggr_counts_a->ena += aggr_counts_b->ena;
+		aggr_counts_a->run += aggr_counts_b->run;
+	}
+
+	return 0;
+}
+/* events should have the same name, scale, unit, cgroup but on different PMUs */
+static bool evsel__is_alias(struct evsel *evsel_a, struct evsel *evsel_b)
+{
+	if (strcmp(evsel__name(evsel_a), evsel__name(evsel_b)))
+		return false;
+
+	if (evsel_a->scale != evsel_b->scale)
+		return false;
+
+	if (evsel_a->cgrp != evsel_b->cgrp)
+		return false;
+
+	if (strcmp(evsel_a->unit, evsel_b->unit))
+		return false;
+
+	if (evsel__is_clock(evsel_a) != evsel__is_clock(evsel_b))
+		return false;
+
+	return !!strcmp(evsel_a->pmu_name, evsel_b->pmu_name);
+}
+
+static void evsel__merge_aliases(struct evsel *evsel)
+{
+	struct evlist *evlist = evsel->evlist;
+	struct evsel *alias;
+
+	alias = list_prepare_entry(evsel, &(evlist->core.entries), core.node);
+	list_for_each_entry_continue(alias, &evlist->core.entries, core.node) {
+		/* Merge the same events on different PMUs. */
+		if (evsel__is_alias(evsel, alias)) {
+			evsel__merge_aggr_counters(evsel, alias);
+			alias->merged_stat = true;
+		}
+	}
+}
+
+static bool evsel__should_merge_hybrid(struct evsel *evsel, struct perf_stat_config *config)
+{
+	struct perf_pmu *pmu;
+
+	if (!config->hybrid_merge)
+		return false;
+
+	pmu = evsel__find_pmu(evsel);
+	return pmu && pmu->is_hybrid;
+}
+
+static void evsel__merge_stats(struct evsel *evsel, struct perf_stat_config *config)
+{
+	/* this evsel is already merged */
+	if (evsel->merged_stat)
+		return;
+
+	if (evsel->auto_merge_stats || evsel__should_merge_hybrid(evsel, config))
+		evsel__merge_aliases(evsel);
+}
+
+/* merge the same uncore and hybrid events if requested */
+void perf_stat_merge_counters(struct perf_stat_config *config, struct evlist *evlist)
+{
+	struct evsel *evsel;
+
+	if (config->no_merge)
+		return;
+
+	evlist__for_each_entry(evlist, evsel)
+		evsel__merge_stats(evsel, config);
+}
+
 int perf_event__process_stat_event(struct perf_session *session,
 				   union perf_event *event)
 {
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index 3a876ad2870b..12cc60ab04e4 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -270,6 +270,8 @@ void evlist__reset_aggr_stats(struct evlist *evlist);
 
 int perf_stat_process_counter(struct perf_stat_config *config,
 			      struct evsel *counter);
+void perf_stat_merge_counters(struct perf_stat_config *config, struct evlist *evlist);
+
 struct perf_tool;
 union perf_event;
 struct perf_session;
-- 
2.38.0.rc1.362.ged0d419d3c-goog

