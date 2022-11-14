Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCF36627837
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 09:56:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236446AbiKNIz7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 03:55:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235805AbiKNIz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 03:55:57 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5A0A1BE91;
        Mon, 14 Nov 2022 00:55:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668416155; x=1699952155;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=rRFtchUjQVP1jvMyJGehQTQ8v6Sk26CYocZPzri0fOE=;
  b=Z1LhdjOYdA2Qfm6vY55YrYXfTmeJGFYevsG0kyXA86Y0j0dt+xoP4JD9
   yacrMfOCLA6BE8ks1riJgy2SeKh4ciJUWXQvI4bI7qxtzs5yu8Ocw4USS
   10+sB/B+scEigAvfjQdaR1XaGRLebQwmTqbRhCvInGrDcm+r++zs3S93s
   LlMvWFH4HI8GcaiLA0WicYFSYkrrcCambg/rRGUIMRqno4R0MCMg1qczX
   6iDzdjeREmFQhu8c2A5jIz3Vdpeui/3vOPKPYFg+souIhwy7MD+VmPo8k
   rf7M72OWXahivOQSA8hwztSDYwCG0ZmBhIrOaMYKHHFQFboQPksHGlbiA
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10530"; a="310626406"
X-IronPort-AV: E=Sophos;i="5.96,161,1665471600"; 
   d="scan'208";a="310626406"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2022 00:55:55 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10530"; a="640692835"
X-IronPort-AV: E=Sophos;i="5.96,161,1665471600"; 
   d="scan'208";a="640692835"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.58.157])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2022 00:55:50 -0800
Message-ID: <0a54d2bc-142f-f62d-978c-70f97332fdfc@intel.com>
Date:   Mon, 14 Nov 2022 10:55:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [PATCH v1 1/9] perf pmu: Add documentation
To:     Ian Rogers <irogers@google.com>,
        Weilin Wang <weilin.wang@intel.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>,
        Leo Yan <leo.yan@linaro.org>,
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
Cc:     Stephane Eranian <eranian@google.com>
References: <20221114075127.2650315-1-irogers@google.com>
 <20221114075127.2650315-2-irogers@google.com>
Content-Language: en-US
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20221114075127.2650315-2-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/11/22 09:51, Ian Rogers wrote:
> Add documentation to struct perf_pmu and the associated structs of
> perf_pmu_alias and perf_pmu_format.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>

Should this be kernel-doc format?

$ ./scripts/kernel-doc -man tools/perf/util/pmu.* > /tmp/manout
tools/perf/util/pmu.c:35: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 * Values from a format file read from <sysfs>/devices/cpu/format/ held in
tools/perf/util/pmu.c:1: warning: no structured comments found
tools/perf/util/pmu.h:140: warning: cannot understand function prototype: 'struct perf_pmu_alias '
tools/perf/util/pmu.h:1: warning: no structured comments found
tools/perf/util/pmu.l:1: warning: no structured comments found
tools/perf/util/pmu.o:1: warning: no structured comments found
tools/perf/util/pmu.y:1: warning: no structured comments found
$ man -l /tmp/manout | cat
$

> ---
>  tools/perf/util/pmu.c |  14 ++++++
>  tools/perf/util/pmu.h | 105 +++++++++++++++++++++++++++++++++++++++---
>  2 files changed, 113 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index 6a86e6af0903..a8f9f47c6ed9 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -31,10 +31,24 @@
>  
>  struct perf_pmu perf_pmu__fake;
>  
> +/**
> + * Values from a format file read from <sysfs>/devices/cpu/format/ held in
> + * struct perf_pmu. For example, the contents of
> + * <sysfs>/devices/cpu/format/event may be "config:0-7" and will be represented
> + * here as name="event", value=PERF_PMU_FORMAT_VALUE_CONFIG and bits 0 to 7 will
> + * be set.
> + */
>  struct perf_pmu_format {
> +	/** The modifier/file name. */
>  	char *name;
> +	/**
> +	 * Which config value the format relates to. Supported values are from
> +	 * PERF_PMU_FORMAT_VALUE_CONFIG to PERF_PMU_FORMAT_VALUE_CONFIG_END.
> +	 */
>  	int value;
> +	/** Which config bits are set by this format value. */
>  	DECLARE_BITMAP(bits, PERF_PMU_FORMAT_BITS);
> +	/** Element on list within struct perf_pmu. */
>  	struct list_head list;
>  };
>  
> diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
> index 68e15c38ae71..29571c0f9d15 100644
> --- a/tools/perf/util/pmu.h
> +++ b/tools/perf/util/pmu.h
> @@ -34,30 +34,91 @@ struct perf_pmu_caps {
>  };
>  
>  struct perf_pmu {
> +	/** The name of the PMU such as "cpu". */
>  	char *name;
> +	/**
> +	 * Optional alternate name for the PMU determined in architecture
> +	 * specific code.
> +	 */
>  	char *alias_name;
> +	/**
> +	 * Optional PMU identifier read from
> +	 * <sysfs>/bus/event_source/devices/<name>/identifier.
> +	 */
>  	char *id;
> +	/**
> +	 * Perf event attributed type value, read from
> +	 * <sysfs>/bus/event_source/devices/<name>/type.
> +	 */
>  	__u32 type;
> +	/**
> +	 * Can the PMU name be selected as if it were an event?
> +	 */
>  	bool selectable;
> +	/**
> +	 * Is the PMU not within the CPU core? Determined by the presence of
> +	 * <sysfs>/bus/event_source/devices/<name>/cpumask.
> +	 */
>  	bool is_uncore;
> +	/** Is the PMU name either cpu_core or cpu_atom. */
>  	bool is_hybrid;
> +	/**
> +	 * Are events auxiliary events? Determined in architecture specific
> +	 * code.
> +	 */
>  	bool auxtrace;
> +	/**
> +	 * Number of levels of :ppp precision supported by the PMU, read from
> +	 * <sysfs>/bus/event_source/devices/<name>/caps/max_precise.
> +	 */
>  	int max_precise;
> +	/**
> +	 * Optional default perf_event_attr determined in architecture specific
> +	 * code.
> +	 */
>  	struct perf_event_attr *default_config;
> +	/**
> +	 * Empty or the contents of either of:
> +	 * <sysfs>/bus/event_source/devices/<name>/cpumask.
> +	 * <sysfs>/bus/event_source/devices/<cpu>/cpus.
> +	 */
>  	struct perf_cpu_map *cpus;
> -	struct list_head format;  /* HEAD struct perf_pmu_format -> list */
> -	struct list_head aliases; /* HEAD struct perf_pmu_alias -> list */
> +	/**
> +	 * Holds the contents of files read from
> +	 * <sysfs>/bus/event_source/devices/<name>/format/. The contents specify
> +	 * which event parameter changes what config, config1 or config2 bits.
> +	 */
> +	struct list_head format;
> +	/**
> +	 * List of struct perf_pmu_alias. Each alias corresponds to an event
> +	 * read from <sysfs>/bus/event_source/devices/<name>/events/ or from
> +	 * json events in pmu-events.c.
> +	 */
> +	struct list_head aliases;
> +	/** Has the list caps been initialized? */
>  	bool caps_initialized;
> +	/** The length of the list caps. */
>  	u32 nr_caps;
> -	struct list_head caps;    /* HEAD struct perf_pmu_caps -> list */
> -	struct list_head list;    /* ELEM */
> +	/**
> +	 * Holds the contents of files read from
> +	 * <sysfs>/bus/event_source/devices/<name>/caps/. The contents are pairs
> +	 * of the filename with the value of its contents, for example,
> +	 * max_precise (see above) may have a value of 3.
> +	 */
> +	struct list_head caps;
> +	/** Element on pmus list in pmu.c. */
> +	struct list_head list;
> +	/** Element on perf_pmu__hybrid_pmus. */
>  	struct list_head hybrid_list;
>  
> +	/** Features to inhibit when events on this PMU are opened. */
>  	struct {
> +		/** Disables perf_event_attr exclude_guest and exclude_host. */
>  		bool exclude_guest;
>  	} missing_features;
>  };
>  
> +/** A special global PMU used for testing. */
>  extern struct perf_pmu perf_pmu__fake;
>  
>  struct perf_pmu_info {
> @@ -71,21 +132,53 @@ struct perf_pmu_info {
>  
>  #define UNIT_MAX_LEN	31 /* max length for event unit name */
>  
> +/**
> + * An event either read from sysfs or builtin in pmu-events.c, created by
> + * parsing the pmu-events json files.
> + */
>  struct perf_pmu_alias {
>  	char *name;
> +	/** Optional short description of the event. */
>  	char *desc;
> +	/** Optional long description. */
>  	char *long_desc;
> +	/**
> +	 * Optional topic such as cache or pipeline, particularly for json
> +	 * events.
> +	 */
>  	char *topic;
> +	/** Comma separated parameter list. */
>  	char *str;
> -	struct list_head terms; /* HEAD struct parse_events_term -> list */
> -	struct list_head list;  /* ELEM */
> +	/** Owned list of the original parsed parameters. */
> +	struct list_head terms;
> +	/** List element of struct perf_pmu aliases. */
> +	struct list_head list;
> +	/** Units for the event, such as bytes or cache lines. */
>  	char unit[UNIT_MAX_LEN+1];
> +	/** Value to scale read counter values by. */
>  	double scale;
> +	/**
> +	 * Does the file
> +	 * <sysfs>/bus/event_source/devices/<pmu_name>/events/<name>.per-pkg or
> +	 * equivalent json value exist and have the value 1.
> +	 */
>  	bool per_pkg;
> +	/**
> +	 * Does the file
> +	 * <sysfs>/bus/event_source/devices/<pmu_name>/events/<name>.snapshot
> +	 * exist and have the value 1.
> +	 */
>  	bool snapshot;
> +	/** Is the event hidden and so not shown in perf list by default. */
>  	bool deprecated;
> +	/**
> +	 * A metric expression associated with an event. Doing this makes little
> +	 * sense due to scale and unit applying to both.
> +	 */
>  	char *metric_expr;
> +	/** A name for the metric. unit applying to both. */
>  	char *metric_name;
> +	/** The name copied from struct perf_pmu. */
>  	char *pmu_name;
>  };
>  

