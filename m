Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7F266276BC
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 08:52:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236041AbiKNHwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 02:52:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236046AbiKNHvz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 02:51:55 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 999E21929D
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 23:51:54 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-37010fefe48so99354327b3.19
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 23:51:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kfq7MOLKAIqDxqx4rLeUrwOnMwpKcW1Ol+sZHsc45dM=;
        b=MA1qCyfua+1dcVUN8bEXa2QfV9Eq8wlr3ZBvzLA/YEztRzgbvLXyBUQCStCfD2ynyt
         QqiEBTdTZxgUeGYH810tRqUiYSJ0A1TKMm4yhdXq8cTEfdJZsPWZhKMs7CVVA5XgUiXU
         nWGDxXDau5E093ERmkGLQ24TejdoUyHrpdVKlquPSrsH7dBeMKMn0caqdWOEqZyq9EER
         q87bSLyYJShFle6WbZL+0ai17FVM4oyibX+5bm0o+YQaQpt8YyOJvO+x3q23NEoHYPIl
         YkSwF4WugbGOuPZdOUk6/h9O3e5kWy/iLt8uihIKGhjxD5I5Ez1D8Veo5Z9k3Q/vT1Iz
         MKDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kfq7MOLKAIqDxqx4rLeUrwOnMwpKcW1Ol+sZHsc45dM=;
        b=vNtnpRziq11oWspf0KXHHdslIBgnFHMz7Im4mrF/aN1TbRhQB+JPIsrv7zk3sb/PNN
         /+5mYr3Hl3I6wy3sJaWnZHkgFM7es/1+G1QsyMwN2XwDF8rKwrAyH64LxhnU1sWzkdHN
         Y1ewvOM6rS11r+LG4SajhiVRW9FHa6d0sepZ0SE9ye9mqDatdhKZRsXtIX57Q0xPTAhl
         SIjSpX1THd7amFofy0oqgAyVHNJa1VSPmES6lyPdezhfENNob70FIZSTx2qwiUtJvN9W
         /d259uOCxh13ssaMJn0W/832wXSMIw8LEwG9FQEaUSudB2nPe1E/0+Rsv/t805jm6deb
         diLg==
X-Gm-Message-State: ANoB5pmjV77lPz/m1Fu90kJgnSXd2TDY2C2RBC3yZkayi0f8/qj4pmTE
        csnuWQq0Nh16vg9j6/aEqmzBoJMRUx+q
X-Google-Smtp-Source: AA0mqf7JwK+fWKCbE5LGrxgMLJrvuuIzw20afLOew1pWQJVeZdcIVET0GmnVaLWd3lZ4b1us9Je+mqKGa8pD
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:cba6:8279:98e6:3d6e])
 (user=irogers job=sendgmr) by 2002:a25:7347:0:b0:6d4:84c5:8549 with SMTP id
 o68-20020a257347000000b006d484c58549mr11313671ybc.376.1668412313851; Sun, 13
 Nov 2022 23:51:53 -0800 (PST)
Date:   Sun, 13 Nov 2022 23:51:19 -0800
In-Reply-To: <20221114075127.2650315-1-irogers@google.com>
Message-Id: <20221114075127.2650315-2-irogers@google.com>
Mime-Version: 1.0
References: <20221114075127.2650315-1-irogers@google.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Subject: [PATCH v1 1/9] perf pmu: Add documentation
From:   Ian Rogers <irogers@google.com>
To:     Weilin Wang <weilin.wang@intel.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Sandipan Das <sandipan.das@amd.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Xin Gao <gaoxin@cdjrlc.com>, Rob Herring <robh@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
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

Add documentation to struct perf_pmu and the associated structs of
perf_pmu_alias and perf_pmu_format.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/pmu.c |  14 ++++++
 tools/perf/util/pmu.h | 105 +++++++++++++++++++++++++++++++++++++++---
 2 files changed, 113 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 6a86e6af0903..a8f9f47c6ed9 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -31,10 +31,24 @@
 
 struct perf_pmu perf_pmu__fake;
 
+/**
+ * Values from a format file read from <sysfs>/devices/cpu/format/ held in
+ * struct perf_pmu. For example, the contents of
+ * <sysfs>/devices/cpu/format/event may be "config:0-7" and will be represented
+ * here as name="event", value=PERF_PMU_FORMAT_VALUE_CONFIG and bits 0 to 7 will
+ * be set.
+ */
 struct perf_pmu_format {
+	/** The modifier/file name. */
 	char *name;
+	/**
+	 * Which config value the format relates to. Supported values are from
+	 * PERF_PMU_FORMAT_VALUE_CONFIG to PERF_PMU_FORMAT_VALUE_CONFIG_END.
+	 */
 	int value;
+	/** Which config bits are set by this format value. */
 	DECLARE_BITMAP(bits, PERF_PMU_FORMAT_BITS);
+	/** Element on list within struct perf_pmu. */
 	struct list_head list;
 };
 
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 68e15c38ae71..29571c0f9d15 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -34,30 +34,91 @@ struct perf_pmu_caps {
 };
 
 struct perf_pmu {
+	/** The name of the PMU such as "cpu". */
 	char *name;
+	/**
+	 * Optional alternate name for the PMU determined in architecture
+	 * specific code.
+	 */
 	char *alias_name;
+	/**
+	 * Optional PMU identifier read from
+	 * <sysfs>/bus/event_source/devices/<name>/identifier.
+	 */
 	char *id;
+	/**
+	 * Perf event attributed type value, read from
+	 * <sysfs>/bus/event_source/devices/<name>/type.
+	 */
 	__u32 type;
+	/**
+	 * Can the PMU name be selected as if it were an event?
+	 */
 	bool selectable;
+	/**
+	 * Is the PMU not within the CPU core? Determined by the presence of
+	 * <sysfs>/bus/event_source/devices/<name>/cpumask.
+	 */
 	bool is_uncore;
+	/** Is the PMU name either cpu_core or cpu_atom. */
 	bool is_hybrid;
+	/**
+	 * Are events auxiliary events? Determined in architecture specific
+	 * code.
+	 */
 	bool auxtrace;
+	/**
+	 * Number of levels of :ppp precision supported by the PMU, read from
+	 * <sysfs>/bus/event_source/devices/<name>/caps/max_precise.
+	 */
 	int max_precise;
+	/**
+	 * Optional default perf_event_attr determined in architecture specific
+	 * code.
+	 */
 	struct perf_event_attr *default_config;
+	/**
+	 * Empty or the contents of either of:
+	 * <sysfs>/bus/event_source/devices/<name>/cpumask.
+	 * <sysfs>/bus/event_source/devices/<cpu>/cpus.
+	 */
 	struct perf_cpu_map *cpus;
-	struct list_head format;  /* HEAD struct perf_pmu_format -> list */
-	struct list_head aliases; /* HEAD struct perf_pmu_alias -> list */
+	/**
+	 * Holds the contents of files read from
+	 * <sysfs>/bus/event_source/devices/<name>/format/. The contents specify
+	 * which event parameter changes what config, config1 or config2 bits.
+	 */
+	struct list_head format;
+	/**
+	 * List of struct perf_pmu_alias. Each alias corresponds to an event
+	 * read from <sysfs>/bus/event_source/devices/<name>/events/ or from
+	 * json events in pmu-events.c.
+	 */
+	struct list_head aliases;
+	/** Has the list caps been initialized? */
 	bool caps_initialized;
+	/** The length of the list caps. */
 	u32 nr_caps;
-	struct list_head caps;    /* HEAD struct perf_pmu_caps -> list */
-	struct list_head list;    /* ELEM */
+	/**
+	 * Holds the contents of files read from
+	 * <sysfs>/bus/event_source/devices/<name>/caps/. The contents are pairs
+	 * of the filename with the value of its contents, for example,
+	 * max_precise (see above) may have a value of 3.
+	 */
+	struct list_head caps;
+	/** Element on pmus list in pmu.c. */
+	struct list_head list;
+	/** Element on perf_pmu__hybrid_pmus. */
 	struct list_head hybrid_list;
 
+	/** Features to inhibit when events on this PMU are opened. */
 	struct {
+		/** Disables perf_event_attr exclude_guest and exclude_host. */
 		bool exclude_guest;
 	} missing_features;
 };
 
+/** A special global PMU used for testing. */
 extern struct perf_pmu perf_pmu__fake;
 
 struct perf_pmu_info {
@@ -71,21 +132,53 @@ struct perf_pmu_info {
 
 #define UNIT_MAX_LEN	31 /* max length for event unit name */
 
+/**
+ * An event either read from sysfs or builtin in pmu-events.c, created by
+ * parsing the pmu-events json files.
+ */
 struct perf_pmu_alias {
 	char *name;
+	/** Optional short description of the event. */
 	char *desc;
+	/** Optional long description. */
 	char *long_desc;
+	/**
+	 * Optional topic such as cache or pipeline, particularly for json
+	 * events.
+	 */
 	char *topic;
+	/** Comma separated parameter list. */
 	char *str;
-	struct list_head terms; /* HEAD struct parse_events_term -> list */
-	struct list_head list;  /* ELEM */
+	/** Owned list of the original parsed parameters. */
+	struct list_head terms;
+	/** List element of struct perf_pmu aliases. */
+	struct list_head list;
+	/** Units for the event, such as bytes or cache lines. */
 	char unit[UNIT_MAX_LEN+1];
+	/** Value to scale read counter values by. */
 	double scale;
+	/**
+	 * Does the file
+	 * <sysfs>/bus/event_source/devices/<pmu_name>/events/<name>.per-pkg or
+	 * equivalent json value exist and have the value 1.
+	 */
 	bool per_pkg;
+	/**
+	 * Does the file
+	 * <sysfs>/bus/event_source/devices/<pmu_name>/events/<name>.snapshot
+	 * exist and have the value 1.
+	 */
 	bool snapshot;
+	/** Is the event hidden and so not shown in perf list by default. */
 	bool deprecated;
+	/**
+	 * A metric expression associated with an event. Doing this makes little
+	 * sense due to scale and unit applying to both.
+	 */
 	char *metric_expr;
+	/** A name for the metric. unit applying to both. */
 	char *metric_name;
+	/** The name copied from struct perf_pmu. */
 	char *pmu_name;
 };
 
-- 
2.38.1.431.g37b22c650d-goog

