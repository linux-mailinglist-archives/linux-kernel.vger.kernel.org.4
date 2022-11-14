Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9FC5628B0B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 22:08:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237427AbiKNVIQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 16:08:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237465AbiKNVIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 16:08:12 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E67ADF08
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 13:08:06 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id c10-20020a17090aa60a00b00212e91df6acso5298070pjq.5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 13:08:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=A43/003qhTsv7CHC/gbD1owyfDC6UmPlxbrZ5F9DYHE=;
        b=rhiXYshjGUJhA/M185y0KXRxAFIdbaKAD3QrfRD1anGpjuQA5GWSsTwg3BBAijbVzn
         wd5NP29ezESx931htUcdriEcxr8clV6u/URqyID+lKpm/wtxpo6+MLGUtpIwbJj+ctUK
         xgUpKErT92875LnGyNI0YZJS99XWLRLUTHPLCFS+GsUYiNSUaTq+BHU643NCkHNJAqip
         l43qsrjQOgq5WNeMVwOCGkISqIieidsvfCXXM6pA7QzpE/YM7diVfV33ToSCLl8m/rTr
         Y1Ma7jT4qX+YYoNVejap713djXGbd+O7mKCJKaekI3teqI2xHFs9bAcGVy8z8tRTcGMR
         l91Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A43/003qhTsv7CHC/gbD1owyfDC6UmPlxbrZ5F9DYHE=;
        b=zTdp3AK06relnwmPEMA0hBlIjxeZsjKXw3TIK866rsXOab/SeyfJDKK9Y46Ec1v6Gm
         AQ9pL8YQhsS1xT9OqzyJ2y1egdSQ5Our52QzCu61gKflY24XbIf+dhDEu8MMZmYCxq4T
         PHXIVMPSp+ETKd9qwyy1JfsGa063pUxvxHdSnN3TPZpfndyWrnaxk/1pV8T9we+PULId
         Ktk4dcfEeXmpR1jXaDcXXbydrTVsZupN+I2GHIvg5gq4uPr7qYF+9z4IkstLqcjyHyHq
         FUQZuNBiuuy7mDijMXf53+lwI1mWMsPcKBLtXdArMmcdhojhxuIkWsU9KkKEsdEBnem+
         MD4w==
X-Gm-Message-State: ANoB5pkRNYFkEbZKnnO1dAt4pTKw3vWhkBG+LQtSiQixLr4JGwJlMxCK
        +HgGNYRuNeojbo4rcCe1bsbai9Y3gjqZ
X-Google-Smtp-Source: AA0mqf5lV1zFCacp1EEd4Fyyl7M+3qTHhzRdycnlZP+7YJB86dxdkSXYY8w2qLFhgLfOWvOCHtLjGxfZib3e
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:553:438f:b86a:87f])
 (user=irogers job=sendgmr) by 2002:a05:6a00:848:b0:572:4ea6:ddc7 with SMTP id
 q8-20020a056a00084800b005724ea6ddc7mr2900518pfk.26.1668460085614; Mon, 14 Nov
 2022 13:08:05 -0800 (PST)
Date:   Mon, 14 Nov 2022 13:07:15 -0800
In-Reply-To: <20221114210723.2749751-1-irogers@google.com>
Message-Id: <20221114210723.2749751-3-irogers@google.com>
Mime-Version: 1.0
References: <20221114210723.2749751-1-irogers@google.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Subject: [PATCH v3 02/10] perf pmu: Add documentation
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
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
 tools/perf/util/pmu.c |  16 ++++++
 tools/perf/util/pmu.h | 122 +++++++++++++++++++++++++++++++++++++++---
 2 files changed, 132 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 48e7be6f3baa..057e1528c32f 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -31,10 +31,26 @@
 
 struct perf_pmu perf_pmu__fake;
 
+/**
+ * struct perf_pmu_format - Values from a format file read from
+ * <sysfs>/devices/cpu/format/ held in struct perf_pmu.
+ *
+ * For example, the contents of <sysfs>/devices/cpu/format/event may be
+ * "config:0-7" and will be represented here as name="event",
+ * value=PERF_PMU_FORMAT_VALUE_CONFIG and bits 0 to 7 will be set.
+ */
 struct perf_pmu_format {
+	/** @name: The modifier/file name. */
 	char *name;
+	/**
+	 * @value : Which config value the format relates to. Supported values
+	 * are from PERF_PMU_FORMAT_VALUE_CONFIG to
+	 * PERF_PMU_FORMAT_VALUE_CONFIG_END.
+	 */
 	int value;
+	/** @bits: Which config bits are set by this format value. */
 	DECLARE_BITMAP(bits, PERF_PMU_FORMAT_BITS);
+	/** @list: Element on list within struct perf_pmu. */
 	struct list_head list;
 };
 
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 0d556d02ce52..ee02e1ef9187 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -33,30 +33,101 @@ struct perf_pmu_caps {
 	struct list_head list;
 };
 
+/**
+ * struct perf_pmu - hi
+ */
 struct perf_pmu {
+	/** @name: The name of the PMU such as "cpu". */
 	char *name;
+	/**
+	 * @alias_name: Optional alternate name for the PMU determined in
+	 * architecture specific code.
+	 */
 	char *alias_name;
+	/**
+	 * @id: Optional PMU identifier read from
+	 * <sysfs>/bus/event_source/devices/<name>/identifier.
+	 */
 	char *id;
+	/**
+	 * @type: Perf event attributed type value, read from
+	 * <sysfs>/bus/event_source/devices/<name>/type.
+	 */
 	__u32 type;
+	/**
+	 * @selectable: Can the PMU name be selected as if it were an event?
+	 */
 	bool selectable;
+	/**
+	 * @is_uncore: Is the PMU not within the CPU core? Determined by the
+	 * presence of <sysfs>/bus/event_source/devices/<name>/cpumask.
+	 */
 	bool is_uncore;
+	/**
+	 * @auxtrace: Are events auxiliary events? Determined in architecture
+	 * specific code.
+	 */
 	bool auxtrace;
+	/**
+	 * @max_precise: Number of levels of :ppp precision supported by the
+	 * PMU, read from
+	 * <sysfs>/bus/event_source/devices/<name>/caps/max_precise.
+	 */
 	int max_precise;
+	/**
+	 * @default_config: Optional default perf_event_attr determined in
+	 * architecture specific code.
+	 */
 	struct perf_event_attr *default_config;
+	/**
+	 * @cpus: Empty or the contents of either of:
+	 * <sysfs>/bus/event_source/devices/<name>/cpumask.
+	 * <sysfs>/bus/event_source/devices/<cpu>/cpus.
+	 */
 	struct perf_cpu_map *cpus;
-	struct list_head format;  /* HEAD struct perf_pmu_format -> list */
-	struct list_head aliases; /* HEAD struct perf_pmu_alias -> list */
+	/**
+	 * @format: Holds the contents of files read from
+	 * <sysfs>/bus/event_source/devices/<name>/format/. The contents specify
+	 * which event parameter changes what config, config1 or config2 bits.
+	 */
+	struct list_head format;
+	/**
+	 * @aliases: List of struct perf_pmu_alias. Each alias corresponds to an
+	 * event read from <sysfs>/bus/event_source/devices/<name>/events/ or
+	 * from json events in pmu-events.c.
+	 */
+	struct list_head aliases;
+	/** @caps_initialized: Has the list caps been initialized? */
 	bool caps_initialized;
+	/** @nr_caps: The length of the list caps. */
 	u32 nr_caps;
-	struct list_head caps;    /* HEAD struct perf_pmu_caps -> list */
-	struct list_head list;    /* ELEM */
+	/**
+	 * @caps: Holds the contents of files read from
+	 * <sysfs>/bus/event_source/devices/<name>/caps/.
+	 *
+	 * The contents are pairs of the filename with the value of its
+	 * contents, for example, max_precise (see above) may have a value of 3.
+	 */
+	struct list_head caps;
+	/** @list: Element on pmus list in pmu.c. */
+	struct list_head list;
+	/** @hybrid_list: Element on perf_pmu__hybrid_pmus. */
 	struct list_head hybrid_list;
 
+	/**
+	 * @missing_features: Features to inhibit when events on this PMU are
+	 * opened.
+	 */
 	struct {
+		/**
+		 * @exclude_guest: Disables perf_event_attr exclude_guest and
+		 * exclude_host.
+		 */
 		bool exclude_guest;
 	} missing_features;
 };
 
+/** @perf_pmu__fake: A special global PMU used for testing. */
 extern struct perf_pmu perf_pmu__fake;
 
 struct perf_pmu_info {
@@ -70,21 +141,60 @@ struct perf_pmu_info {
 
 #define UNIT_MAX_LEN	31 /* max length for event unit name */
 
+/**
+ * struct perf_pmu_alias - An event either read from sysfs or builtin in
+ * pmu-events.c, created by parsing the pmu-events json files.
+ */
 struct perf_pmu_alias {
+	/** @name: Name of the event like "mem-loads". */
 	char *name;
+	/** @desc: Optional short description of the event. */
 	char *desc;
+	/** @long_desc: Optional long description. */
 	char *long_desc;
+	/**
+	 * @topic: Optional topic such as cache or pipeline, particularly for
+	 * json events.
+	 */
 	char *topic;
+	/**
+	 * @str: Comma separated parameter list like
+	 * "event=0xcd,umask=0x1,ldlat=0x3".
+	 */
 	char *str;
-	struct list_head terms; /* HEAD struct parse_events_term -> list */
-	struct list_head list;  /* ELEM */
+	/** @terms: Owned list of the original parsed parameters. */
+	struct list_head terms;
+	/** @list: List element of struct perf_pmu aliases. */
+	struct list_head list;
+	/** @unit: Units for the event, such as bytes or cache lines. */
 	char unit[UNIT_MAX_LEN+1];
+	/** @scale: Value to scale read counter values by. */
 	double scale;
+	/**
+	 * @per_pkg: Does the file
+	 * <sysfs>/bus/event_source/devices/<pmu_name>/events/<name>.per-pkg or
+	 * equivalent json value exist and have the value 1.
+	 */
 	bool per_pkg;
+	/**
+	 * @snapshot: Does the file
+	 * <sysfs>/bus/event_source/devices/<pmu_name>/events/<name>.snapshot
+	 * exist and have the value 1.
+	 */
 	bool snapshot;
+	/**
+	 * @deprecated: Is the event hidden and so not shown in perf list by
+	 * default.
+	 */
 	bool deprecated;
+	/**
+	 * @metric_expr: A metric expression associated with an event. Doing
+	 * this makes little sense due to scale and unit applying to both.
+	 */
 	char *metric_expr;
+	/** @metric_name: A name for the metric. unit applying to both. */
 	char *metric_name;
+	/** @pmu_name: The name copied from struct perf_pmu. */
 	char *pmu_name;
 };
 
-- 
2.38.1.431.g37b22c650d-goog

