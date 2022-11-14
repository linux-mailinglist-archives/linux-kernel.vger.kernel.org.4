Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 214D96283D1
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 16:27:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235903AbiKNP1B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 10:27:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236339AbiKNP04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 10:26:56 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 617EB205CA;
        Mon, 14 Nov 2022 07:26:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668439615; x=1699975615;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=RLWKHnED+ezAz4xPOgfwYdUQ+x776iSR8SbypCj3UpY=;
  b=nWxgSsLVb95XL8o2L3AezFw/OILqbM8LA1MgPdAvFmfHd9eKUa5H9dz7
   xC8pfvn6qNRwVfLYJnX2T07wVP8ahmYMnaymiH0lbqbkAJs2jlSs9Ilat
   L+w4wd+MctrPDkIl+39ipLvLM3jXbnsiKl4MUclE1XILJTmrG+QwY4pF2
   D6D1rmojFNPBIFz7xrwy9+XZILyQZRVjo/3NkxT40Beu6BMk23oxZLRNL
   LDbY0x6qGFVVGU95RX2oNZDWfM8Shx/8P+OF7q77SYH2AJ+/iEnjiPhQ0
   VajSRtFLkYl2fsKQry3oHWgV0OfGlkKuqOCcWYpAkF/fazs9pIZCGYN8n
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="312002456"
X-IronPort-AV: E=Sophos;i="5.96,164,1665471600"; 
   d="scan'208";a="312002456"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2022 07:26:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="727563574"
X-IronPort-AV: E=Sophos;i="5.96,164,1665471600"; 
   d="scan'208";a="727563574"
Received: from linux.intel.com ([10.54.29.200])
  by FMSMGA003.fm.intel.com with ESMTP; 14 Nov 2022 07:26:52 -0800
Received: from [10.252.208.163] (kliang2-mobl1.ccr.corp.intel.com [10.252.208.163])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 81A6858097C;
        Mon, 14 Nov 2022 07:26:49 -0800 (PST)
Message-ID: <3464d5c2-0438-18ba-fbea-ab95ca5f22b4@linux.intel.com>
Date:   Mon, 14 Nov 2022 10:26:48 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v1 1/9] perf pmu: Add documentation
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>
Cc:     Weilin Wang <weilin.wang@intel.com>,
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
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Xin Gao <gaoxin@cdjrlc.com>, Rob Herring <robh@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
References: <20221114075127.2650315-1-irogers@google.com>
 <20221114075127.2650315-2-irogers@google.com>
 <bbb73e4b-a73e-6ce5-db1f-e54d1bb19c2c@linux.intel.com>
 <CAP-5=fUTDtGDJ3ONW5iKaeszDRwezzZCJCW59yvXQ4tEYyHsdg@mail.gmail.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <CAP-5=fUTDtGDJ3ONW5iKaeszDRwezzZCJCW59yvXQ4tEYyHsdg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022-11-14 9:09 a.m., Ian Rogers wrote:
> On Mon, Nov 14, 2022 at 5:40 AM Liang, Kan <kan.liang@linux.intel.com> wrote:
>>
>>
>>
>> On 2022-11-14 2:51 a.m., Ian Rogers wrote:
>>> Add documentation to struct perf_pmu and the associated structs of
>>> perf_pmu_alias and perf_pmu_format.
>>>
>>> Signed-off-by: Ian Rogers <irogers@google.com>
>>> ---
>>>  tools/perf/util/pmu.c |  14 ++++++
>>>  tools/perf/util/pmu.h | 105 +++++++++++++++++++++++++++++++++++++++---
>>>  2 files changed, 113 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
>>> index 6a86e6af0903..a8f9f47c6ed9 100644
>>> --- a/tools/perf/util/pmu.c
>>> +++ b/tools/perf/util/pmu.c
>>> @@ -31,10 +31,24 @@
>>>
>>>  struct perf_pmu perf_pmu__fake;
>>>
>>> +/**
>>> + * Values from a format file read from <sysfs>/devices/cpu/format/ held in
>>> + * struct perf_pmu. For example, the contents of
>>> + * <sysfs>/devices/cpu/format/event may be "config:0-7" and will be represented
>>> + * here as name="event", value=PERF_PMU_FORMAT_VALUE_CONFIG and bits 0 to 7 will
>>> + * be set.
>>> + */
>>>  struct perf_pmu_format {
>>> +     /** The modifier/file name. */
>>>       char *name;
>>> +     /**
>>> +      * Which config value the format relates to. Supported values are from
>>> +      * PERF_PMU_FORMAT_VALUE_CONFIG to PERF_PMU_FORMAT_VALUE_CONFIG_END.
>>> +      */
>>>       int value;
>>> +     /** Which config bits are set by this format value. */
>>>       DECLARE_BITMAP(bits, PERF_PMU_FORMAT_BITS);
>>> +     /** Element on list within struct perf_pmu. */
>>>       struct list_head list;
>>>  };
>>>
>>> diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
>>> index 68e15c38ae71..29571c0f9d15 100644
>>> --- a/tools/perf/util/pmu.h
>>> +++ b/tools/perf/util/pmu.h
>>> @@ -34,30 +34,91 @@ struct perf_pmu_caps {
>>>  };
>>>
>>>  struct perf_pmu {
>>> +     /** The name of the PMU such as "cpu". */
>>>       char *name;
>>> +     /**
>>> +      * Optional alternate name for the PMU determined in architecture
>>> +      * specific code.
>>> +      */
>>>       char *alias_name;
>>> +     /**
>>> +      * Optional PMU identifier read from
>>> +      * <sysfs>/bus/event_source/devices/<name>/identifier.
>>> +      */
>>>       char *id;
>>> +     /**
>>> +      * Perf event attributed type value, read from
>>> +      * <sysfs>/bus/event_source/devices/<name>/type.
>>> +      */
>>>       __u32 type;
>>> +     /**
>>> +      * Can the PMU name be selected as if it were an event?
>>> +      */
>>>       bool selectable;
>>> +     /**
>>> +      * Is the PMU not within the CPU core? Determined by the presence of
>>> +      * <sysfs>/bus/event_source/devices/<name>/cpumask.
>>> +      */
>>>       bool is_uncore;
>>> +     /** Is the PMU name either cpu_core or cpu_atom. */
>>
>> I don't think we want to limit the hybrid names only to cpu_core or
>> cpu_atom. Maybe something as below?
>> /* Is a hybrid CPU PMU, e.g., cpu_core, cpu_atom. */
> 
> Currently the hybrid code only works for cpu_core or cpu_atom, a
> limitation of its implementation. 

I don't think so. See perf_pmu__hybrid_mounted(). If a PMU is named as
"cpu_", we treat it as a hybrid CPU PMU. The cpu_core or cpu_atom should
only be hard coded to specially handle some model-specific cases, e.g.,
mem-loads-aux event.

Thanks,
Kan

> As pointed out in a later patch,
> this bool isn't being used when it could be and I think we can work to
> remove it. It would be possible to remove all uses of this with
> perf_pmu__is_hybrid. As such I think it may be useful to mark the
> hybrid variables in struct perf_pmu as deprecated while we work to
> replace their use with more generic just any PMU code.
> 
> Thanks,
> Ian
> 
>> Thanks,
>> Kan
>>
>>>       bool is_hybrid;
>>> +     /**
>>> +      * Are events auxiliary events? Determined in architecture specific
>>> +      * code.
>>> +      */
>>>       bool auxtrace;
>>> +     /**
>>> +      * Number of levels of :ppp precision supported by the PMU, read from
>>> +      * <sysfs>/bus/event_source/devices/<name>/caps/max_precise.
>>> +      */
>>>       int max_precise;
>>> +     /**
>>> +      * Optional default perf_event_attr determined in architecture specific
>>> +      * code.
>>> +      */
>>>       struct perf_event_attr *default_config;
>>> +     /**
>>> +      * Empty or the contents of either of:
>>> +      * <sysfs>/bus/event_source/devices/<name>/cpumask.
>>> +      * <sysfs>/bus/event_source/devices/<cpu>/cpus.
>>> +      */
>>>       struct perf_cpu_map *cpus;
>>> -     struct list_head format;  /* HEAD struct perf_pmu_format -> list */
>>> -     struct list_head aliases; /* HEAD struct perf_pmu_alias -> list */
>>> +     /**
>>> +      * Holds the contents of files read from
>>> +      * <sysfs>/bus/event_source/devices/<name>/format/. The contents specify
>>> +      * which event parameter changes what config, config1 or config2 bits.
>>> +      */
>>> +     struct list_head format;
>>> +     /**
>>> +      * List of struct perf_pmu_alias. Each alias corresponds to an event
>>> +      * read from <sysfs>/bus/event_source/devices/<name>/events/ or from
>>> +      * json events in pmu-events.c.
>>> +      */
>>> +     struct list_head aliases;
>>> +     /** Has the list caps been initialized? */
>>>       bool caps_initialized;
>>> +     /** The length of the list caps. */
>>>       u32 nr_caps;
>>> -     struct list_head caps;    /* HEAD struct perf_pmu_caps -> list */
>>> -     struct list_head list;    /* ELEM */
>>> +     /**
>>> +      * Holds the contents of files read from
>>> +      * <sysfs>/bus/event_source/devices/<name>/caps/. The contents are pairs
>>> +      * of the filename with the value of its contents, for example,
>>> +      * max_precise (see above) may have a value of 3.
>>> +      */
>>> +     struct list_head caps;
>>> +     /** Element on pmus list in pmu.c. */
>>> +     struct list_head list;
>>> +     /** Element on perf_pmu__hybrid_pmus. */
>>>       struct list_head hybrid_list;
>>>
>>> +     /** Features to inhibit when events on this PMU are opened. */
>>>       struct {
>>> +             /** Disables perf_event_attr exclude_guest and exclude_host. */
>>>               bool exclude_guest;
>>>       } missing_features;
>>>  };
>>>
>>> +/** A special global PMU used for testing. */
>>>  extern struct perf_pmu perf_pmu__fake;
>>>
>>>  struct perf_pmu_info {
>>> @@ -71,21 +132,53 @@ struct perf_pmu_info {
>>>
>>>  #define UNIT_MAX_LEN 31 /* max length for event unit name */
>>>
>>> +/**
>>> + * An event either read from sysfs or builtin in pmu-events.c, created by
>>> + * parsing the pmu-events json files.
>>> + */
>>>  struct perf_pmu_alias {
>>>       char *name;
>>> +     /** Optional short description of the event. */
>>>       char *desc;
>>> +     /** Optional long description. */
>>>       char *long_desc;
>>> +     /**
>>> +      * Optional topic such as cache or pipeline, particularly for json
>>> +      * events.
>>> +      */
>>>       char *topic;
>>> +     /** Comma separated parameter list. */
>>>       char *str;
>>> -     struct list_head terms; /* HEAD struct parse_events_term -> list */
>>> -     struct list_head list;  /* ELEM */
>>> +     /** Owned list of the original parsed parameters. */
>>> +     struct list_head terms;
>>> +     /** List element of struct perf_pmu aliases. */
>>> +     struct list_head list;
>>> +     /** Units for the event, such as bytes or cache lines. */
>>>       char unit[UNIT_MAX_LEN+1];
>>> +     /** Value to scale read counter values by. */
>>>       double scale;
>>> +     /**
>>> +      * Does the file
>>> +      * <sysfs>/bus/event_source/devices/<pmu_name>/events/<name>.per-pkg or
>>> +      * equivalent json value exist and have the value 1.
>>> +      */
>>>       bool per_pkg;
>>> +     /**
>>> +      * Does the file
>>> +      * <sysfs>/bus/event_source/devices/<pmu_name>/events/<name>.snapshot
>>> +      * exist and have the value 1.
>>> +      */
>>>       bool snapshot;
>>> +     /** Is the event hidden and so not shown in perf list by default. */
>>>       bool deprecated;
>>> +     /**
>>> +      * A metric expression associated with an event. Doing this makes little
>>> +      * sense due to scale and unit applying to both.
>>> +      */
>>>       char *metric_expr;
>>> +     /** A name for the metric. unit applying to both. */
>>>       char *metric_name;
>>> +     /** The name copied from struct perf_pmu. */
>>>       char *pmu_name;
>>>  };
>>>
