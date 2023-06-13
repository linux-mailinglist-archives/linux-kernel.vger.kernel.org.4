Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EA8272ECA4
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 22:12:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240661AbjFMUMi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 16:12:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240845AbjFMUMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 16:12:20 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 485B82107;
        Tue, 13 Jun 2023 13:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686687116; x=1718223116;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=7j6b1PUNYhA/Tb+R1b5gtDigUxvfmNbGsC9sTp/9R1E=;
  b=JEN1l5AbESJCvKbHRA3Bg3MSKCpXdj2oiIHSJ35QjyGqfjPBEe8N0eMi
   hrFOwZswfCrekurgvI38YvJaL0tK/rW6SRtgIbGY2VCdgJOXuFwPqJYid
   8HXEKvh8WqqEVyPO0cmPwcVpD0enn7gUmLS6rM83pNbBqB34uZA/pac9w
   L3FgIBG4xW37TFOxRY+DJdW5X1TpaoPGcf9sZLZJxNBDfUvuGQU3G5QLe
   Q9x/G/uS6ZmZkIUJ2FphzqLwp1ItA/HJT/ZQ/iCgtBaXn5tMAuwOTlXrr
   5M6rDpHTXAHKvIyNdJFH31PBzKLBFd1tM2kZtFPiG7xvTakyC6cNyiKsu
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="444813672"
X-IronPort-AV: E=Sophos;i="6.00,240,1681196400"; 
   d="scan'208";a="444813672"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2023 13:11:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="836020940"
X-IronPort-AV: E=Sophos;i="6.00,240,1681196400"; 
   d="scan'208";a="836020940"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga004.jf.intel.com with ESMTP; 13 Jun 2023 13:11:40 -0700
Received: from [10.251.24.95] (kliang2-mobl1.ccr.corp.intel.com [10.251.24.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 6957F580BF8;
        Tue, 13 Jun 2023 13:11:36 -0700 (PDT)
Message-ID: <cd8009fe-9049-2c29-d5d9-1205ce98cb47@linux.intel.com>
Date:   Tue, 13 Jun 2023 16:11:27 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 5/8] perf stat,jevents: Introduce Default tags for the
 default mode
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>
Cc:     acme@kernel.org, mingo@redhat.com, peterz@infradead.org,
        namhyung@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        ak@linux.intel.com, eranian@google.com, ahmad.yasin@intel.com
References: <20230607162700.3234712-1-kan.liang@linux.intel.com>
 <20230607162700.3234712-6-kan.liang@linux.intel.com>
 <CAP-5=fU_5fkJZ49B2yxkS4usuKw9fXZ=o-oJo3n5-j5YTAWNvA@mail.gmail.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <CAP-5=fU_5fkJZ49B2yxkS4usuKw9fXZ=o-oJo3n5-j5YTAWNvA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-06-13 3:59 p.m., Ian Rogers wrote:
> On Wed, Jun 7, 2023 at 9:27 AM <kan.liang@linux.intel.com> wrote:
>>
>> From: Kan Liang <kan.liang@linux.intel.com>
>>
>> Introduce a new metricgroup, Default, to tag all the metric groups which
>> will be collected in the default mode.
>>
>> Add a new field, DefaultMetricgroupName, in the JSON file to indicate
>> the real metric group name. It will be printed in the default output
>> to replace the event names.
>>
>> There is nothing changed for the output format.
>>
>> On SPR, both TopdownL1 and TopdownL2 are displayed in the default
>> output.
>>
>> On ARM, Intel ICL and later platforms (before SPR), only TopdownL1 is
>> displayed in the default output.
>>
>> Suggested-by: Stephane Eranian <eranian@google.com>
>> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
>> ---
>>  tools/perf/builtin-stat.c          | 4 ++--
>>  tools/perf/pmu-events/jevents.py   | 5 +++--
>>  tools/perf/pmu-events/pmu-events.h | 1 +
>>  tools/perf/util/metricgroup.c      | 3 +++
>>  4 files changed, 9 insertions(+), 4 deletions(-)
>>
>> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
>> index c87c6897edc9..2269b3e90e9b 100644
>> --- a/tools/perf/builtin-stat.c
>> +++ b/tools/perf/builtin-stat.c
>> @@ -2154,14 +2154,14 @@ static int add_default_attributes(void)
>>                  * Add TopdownL1 metrics if they exist. To minimize
>>                  * multiplexing, don't request threshold computation.
>>                  */
>> -               if (metricgroup__has_metric(pmu, "TopdownL1")) {
>> +               if (metricgroup__has_metric(pmu, "Default")) {
>>                         struct evlist *metric_evlist = evlist__new();
>>                         struct evsel *metric_evsel;
>>
>>                         if (!metric_evlist)
>>                                 return -1;
>>
>> -                       if (metricgroup__parse_groups(metric_evlist, pmu, "TopdownL1",
>> +                       if (metricgroup__parse_groups(metric_evlist, pmu, "Default",
>>                                                         /*metric_no_group=*/false,
>>                                                         /*metric_no_merge=*/false,
>>                                                         /*metric_no_threshold=*/true,
>> diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
>> index 7ed258be1829..12e80bb7939b 100755
>> --- a/tools/perf/pmu-events/jevents.py
>> +++ b/tools/perf/pmu-events/jevents.py
>> @@ -54,8 +54,8 @@ _json_event_attributes = [
>>  # Attributes that are in pmu_metric rather than pmu_event.
>>  _json_metric_attributes = [
>>      'pmu', 'metric_name', 'metric_group', 'metric_expr', 'metric_threshold',
>> -    'desc', 'long_desc', 'unit', 'compat', 'metricgroup_no_group', 'aggr_mode',
>> -    'event_grouping'
>> +    'desc', 'long_desc', 'unit', 'compat', 'metricgroup_no_group',
>> +    'default_metricgroup_name', 'aggr_mode', 'event_grouping'
>>  ]
>>  # Attributes that are bools or enum int values, encoded as '0', '1',...
>>  _json_enum_attributes = ['aggr_mode', 'deprecated', 'event_grouping', 'perpkg']
>> @@ -307,6 +307,7 @@ class JsonEvent:
>>      self.metric_name = jd.get('MetricName')
>>      self.metric_group = jd.get('MetricGroup')
>>      self.metricgroup_no_group = jd.get('MetricgroupNoGroup')
>> +    self.default_metricgroup_name = jd.get('DefaultMetricgroupName')
>>      self.event_grouping = convert_metric_constraint(jd.get('MetricConstraint'))
>>      self.metric_expr = None
>>      if 'MetricExpr' in jd:
>> diff --git a/tools/perf/pmu-events/pmu-events.h b/tools/perf/pmu-events/pmu-events.h
>> index 8cd23d656a5d..caf59f23cd64 100644
>> --- a/tools/perf/pmu-events/pmu-events.h
>> +++ b/tools/perf/pmu-events/pmu-events.h
>> @@ -61,6 +61,7 @@ struct pmu_metric {
>>         const char *desc;
>>         const char *long_desc;
>>         const char *metricgroup_no_group;
>> +       const char *default_metricgroup_name;
>>         enum aggr_mode_class aggr_mode;
>>         enum metric_event_groups event_grouping;
>>  };
>> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
>> index 74f2d8efc02d..efafa02db5e5 100644
>> --- a/tools/perf/util/metricgroup.c
>> +++ b/tools/perf/util/metricgroup.c
>> @@ -137,6 +137,8 @@ struct metric {
>>          * output.
>>          */
>>         const char *metric_unit;
>> +       /** Optional default metric group name */
>> +       const char *default_metricgroup_name;
> 
> Adding a bit more to the comment would be useful, like:
> 
> Optional name of the metric group reported if the Default metric group
> is being processed.

Sure.

Thanks,
Kan
> 
>>         /** Optional null terminated array of referenced metrics. */
>>         struct metric_ref *metric_refs;
>>         /**
>> @@ -219,6 +221,7 @@ static struct metric *metric__new(const struct pmu_metric *pm,
>>
>>         m->pmu = pm->pmu ?: "cpu";
>>         m->metric_name = pm->metric_name;
>> +       m->default_metricgroup_name = pm->default_metricgroup_name;
>>         m->modifier = NULL;
>>         if (modifier) {
>>                 m->modifier = strdup(modifier);
>> --
>> 2.35.1
>>
