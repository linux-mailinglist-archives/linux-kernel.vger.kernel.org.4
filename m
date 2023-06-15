Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 024D37319B1
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 15:15:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343864AbjFONPM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 09:15:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344095AbjFONOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 09:14:48 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA7453596;
        Thu, 15 Jun 2023 06:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686834865; x=1718370865;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=rwNfSlwgid9qaCUU9SYoqzSKim/ZlTBt/ffrkcFdTMo=;
  b=IpWzPlK4IBVhq+GBh583GSmqY4Cf9z6xdKVbZcZlfcJnBlhIJiidVv1t
   v7j+zXjBu5LX5AQbN/xOUm3WnsE9bRH7+ZsZnxoSDorsju9fSzsXfFudQ
   m36o6l9J+EccQOR50su0mEwEESAZn4LbWKtG5FQaQ6x5U7SXJKXlmFn0w
   4HYrXgq8zmTz5UeXvy1Gmlp7SHJL3C5pYGFoa5PLUg+wJ6/KnS9Gl/qRi
   m9rlJ4UMYAj7XoVmookHP/CutSunarJU7XrSHTn+eGgLGoT3Y4IyC46Ub
   hhkcKRxY5SJFWrTRs7eUM9mTFwJhI9Z5p89AUTZU9E9EdvSF+SILGkcEU
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="348580760"
X-IronPort-AV: E=Sophos;i="6.00,244,1681196400"; 
   d="scan'208";a="348580760"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 06:08:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="1042651395"
X-IronPort-AV: E=Sophos;i="6.00,244,1681196400"; 
   d="scan'208";a="1042651395"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga005.fm.intel.com with ESMTP; 15 Jun 2023 06:08:08 -0700
Received: from [10.209.76.72] (kliang2-mobl1.ccr.corp.intel.com [10.209.76.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id E1C29580C9B;
        Thu, 15 Jun 2023 06:08:06 -0700 (PDT)
Message-ID: <3e933824-c119-335c-f092-8580704ea334@linux.intel.com>
Date:   Thu, 15 Jun 2023 09:08:05 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH V2 4/8] perf metrics: Sort the Default metricgroup
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>
Cc:     acme@kernel.org, mingo@redhat.com, peterz@infradead.org,
        namhyung@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        ak@linux.intel.com, eranian@google.com, ahmad.yasin@intel.com
References: <20230615001735.3643996-1-kan.liang@linux.intel.com>
 <20230615001735.3643996-5-kan.liang@linux.intel.com>
 <CAP-5=fWbLkyQpxxhfCmqit7p4WgHVUOCjsADm-XojcT5ppcv7g@mail.gmail.com>
 <CAP-5=fU=jS6UmKdFziRq1Zt0c8FY+3XSrB9Xufw0BSHkGAcO-A@mail.gmail.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <CAP-5=fU=jS6UmKdFziRq1Zt0c8FY+3XSrB9Xufw0BSHkGAcO-A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-06-15 1:52 a.m., Ian Rogers wrote:
> On Wed, Jun 14, 2023 at 9:30 PM Ian Rogers <irogers@google.com> wrote:
>>
>> On Wed, Jun 14, 2023 at 5:18 PM <kan.liang@linux.intel.com> wrote:
>>>
>>> From: Kan Liang <kan.liang@linux.intel.com>
>>>
>>> The new default mode will print the metrics as a metric group. The
>>> metrics from the same metric group must be adjacent to each other in the
>>> metric list. But the metric_list_cmp() sorts metrics by the number of
>>> events.
>>>
>>> Add a new sort for the Default metricgroup, which sorts by
>>> default_metricgroup_name and metric_name.
>>>
>>> Add is_default in the struct metric_event to indicate that it's from
>>> the Default metricgroup.
>>>
>>> Store the displayed metricgroup name of the Default metricgroup into
>>> the metric expr for output.
>>>
>>> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
>>> ---
>>>  tools/perf/util/metricgroup.c | 35 +++++++++++++++++++++++++++++++++++
>>>  tools/perf/util/metricgroup.h |  3 +++
>>>  2 files changed, 38 insertions(+)
>>>
>>> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
>>> index 8b19644ade7d..acf86b15ee49 100644
>>> --- a/tools/perf/util/metricgroup.c
>>> +++ b/tools/perf/util/metricgroup.c
>>> @@ -79,6 +79,7 @@ static struct rb_node *metric_event_new(struct rblist *rblist __maybe_unused,
>>>                 return NULL;
>>>         memcpy(me, entry, sizeof(struct metric_event));
>>>         me->evsel = ((struct metric_event *)entry)->evsel;
>>> +       me->is_default = false;
>>>         INIT_LIST_HEAD(&me->head);
>>>         return &me->nd;
>>>  }
>>> @@ -1160,6 +1161,25 @@ static int metric_list_cmp(void *priv __maybe_unused, const struct list_head *l,
>>>         return right_count - left_count;
>>>  }
>>>
>>> +/**
>>> + * default_metricgroup_cmp - Implements complex key for the Default metricgroup
>>> + *                          that first sorts by default_metricgroup_name, then
>>> + *                          metric_name.
>>> + */
>>> +static int default_metricgroup_cmp(void *priv __maybe_unused,
>>> +                                  const struct list_head *l,
>>> +                                  const struct list_head *r)
>>> +{
>>> +       const struct metric *left = container_of(l, struct metric, nd);
>>> +       const struct metric *right = container_of(r, struct metric, nd);
>>> +       int diff = strcmp(right->default_metricgroup_name, left->default_metricgroup_name);
>>> +
>>> +       if (diff)
>>> +               return diff;
>>> +
>>> +       return strcmp(right->metric_name, left->metric_name);
>>> +}
>>> +
>>>  struct metricgroup__add_metric_data {
>>>         struct list_head *list;
>>>         const char *pmu;
>>> @@ -1515,6 +1535,7 @@ static int parse_groups(struct evlist *perf_evlist,
>>>         LIST_HEAD(metric_list);
>>>         struct metric *m;
>>>         bool tool_events[PERF_TOOL_MAX] = {false};
>>> +       bool is_default = !strcmp(str, "Default");
>>>         int ret;
>>>
>>>         if (metric_events_list->nr_entries == 0)
>>> @@ -1549,6 +1570,9 @@ static int parse_groups(struct evlist *perf_evlist,
>>>                         goto out;
>>>         }
>>>
>>> +       if (is_default)
>>> +               list_sort(NULL, &metric_list, default_metricgroup_cmp);
>>> +
>>>         list_for_each_entry(m, &metric_list, nd) {
>>>                 struct metric_event *me;
>>>                 struct evsel **metric_events;
>>> @@ -1637,6 +1661,17 @@ static int parse_groups(struct evlist *perf_evlist,
>>>                 expr->metric_unit = m->metric_unit;
>>>                 expr->metric_events = metric_events;
>>>                 expr->runtime = m->pctx->sctx.runtime;
>>> +               if (m->pmu && strcmp(m->pmu, "cpu")) {
>>> +                       char *name;
>>> +
>>> +                       if (asprintf(&name, "%s (%s)", m->default_metricgroup_name, m->pmu) < 0)
>>
>> With EXTRA_CFLAGS="-fsanitize=address" this is causing:
>>
>> $ perf test 7 -vv -F
>>   7: PMU events                                                      :
>> ...
>>   7.5: Parsing of metric thresholds with fake PMUs                   :
>> ...
>> ==2072355==ERROR: LeakSanitizer: detected memory leaks
>>
>> Direct leak of 6199 byte(s) in 340 object(s) allocated from:
>>    #0 0x7f24cce7077b in __interceptor_strdup
>> ../../../../src/libsanitizer/asan/asan_interceptors.cp
>> p:439
>>    #1 0x55972b328abd in asprintf util/util.c:566
>>    #2 0x55972b251dbd in parse_groups util/metricgroup.c:1667
>>    #3 0x55972b25231f in metricgroup__parse_groups_test util/metricgroup.c:1719
>>    #4 0x55972b139aff in test__parsing_callback tests/pmu-events.c:837
>>    #5 0x55972b5119a9 in pmu_metrics_table_for_each_metric
>> /tmp/perf/pmu-events/pmu-events.c:61641
>>    #6 0x55972b511fdf in pmu_for_each_core_metric
>> /tmp/perf/pmu-events/pmu-events.c:61742
>>    #7 0x55972b13a3bc in test__parsing tests/pmu-events.c:898
>>    #8 0x55972b106cd7 in run_test tests/builtin-test.c:236
>>    #9 0x55972b106f7c in test_and_print tests/builtin-test.c:265
>>    #10 0x55972b107f96 in __cmd_test tests/builtin-test.c:436
>>    #11 0x55972b10927a in cmd_test tests/builtin-test.c:559
>>    #12 0x55972b19584a in run_builtin
>> /home/irogers/kernel.org/tools/perf/perf.c:323
>>    #13 0x55972b195dbb in handle_internal_command
>> /home/irogers/kernel.org/tools/perf/perf.c:377
>>    #14 0x55972b196183 in run_argv /home/irogers/kernel.org/tools/perf/perf.c:421
>>    #15 0x55972b1966eb in main /home/irogers/kernel.org/tools/perf/perf.c:537
>>    #16 0x7f24cbe46189 in __libc_start_call_main
>> ../sysdeps/nptl/libc_start_call_main.h:58
>>
>> SUMMARY: AddressSanitizer: 6199 byte(s) leaked in 340 allocation(s)
>>
>> As this is mixing allocated and unallocated strings, you like want to
>> strdup the unallocated ones, then add a free to the exit routine.
>>
>> Thanks,
>> Ian
> 
> Except for the memory leak, everything looks good here. Will ack with
> the memory leak fix.
> 

Thanks Ian. I will fix the memory leak and send a V3.

Thanks,
Kan

> Thanks,
> Ian
> 
>>> +                               expr->default_metricgroup_name = m->default_metricgroup_name;
>>> +                       else
>>> +                               expr->default_metricgroup_name = name;
>>> +               } else
>>> +                       expr->default_metricgroup_name = m->default_metricgroup_name;
>>> +               if (is_default)
>>> +                       me->is_default = true;
>>>                 list_add(&expr->nd, &me->head);
>>>         }
>>>
>>> diff --git a/tools/perf/util/metricgroup.h b/tools/perf/util/metricgroup.h
>>> index bf18274c15df..d5325c6ec8e1 100644
>>> --- a/tools/perf/util/metricgroup.h
>>> +++ b/tools/perf/util/metricgroup.h
>>> @@ -22,6 +22,7 @@ struct cgroup;
>>>  struct metric_event {
>>>         struct rb_node nd;
>>>         struct evsel *evsel;
>>> +       bool is_default; /* the metric evsel from the Default metricgroup */
>>>         struct list_head head; /* list of metric_expr */
>>>  };
>>>
>>> @@ -55,6 +56,8 @@ struct metric_expr {
>>>          * more human intelligible) and then add "MiB" afterward when displayed.
>>>          */
>>>         const char *metric_unit;
>>> +       /** Displayed metricgroup name of the Default metricgroup */
>>> +       const char *default_metricgroup_name;
>>>         /** Null terminated array of events used by the metric. */
>>>         struct evsel **metric_events;
>>>         /** Null terminated array of referenced metrics. */
>>> --
>>> 2.35.1
>>>
