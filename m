Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C9BF72F0C5
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 02:02:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240504AbjFNAC2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 20:02:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239777AbjFNACV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 20:02:21 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4400AE5;
        Tue, 13 Jun 2023 17:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686700937; x=1718236937;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=tw/g5j4tmI6skPYvE/CaffnfGNvBq/osuNSdr49Uvuo=;
  b=Nv+Hd+NeooxPYUQ+QD0rYFKv0I2vvuZqlW7Cl1b8rDF0V7Odbb9z1HgE
   DLBKpPiNtVrmQ9QIhOY9h77zC+XcPVc0KliiSeRtp4I+bQ+KtY9xK7SbE
   9s38rQ3k9y4ueOk3GlBzfO49Uu3d+y+lzSyNigesTCy/oaW1Qqc5Up4yA
   ZTGwO2WazeOX0ex7SjMV1SYeGfCVh1mU+Daee8LDwRa8GNSPi0U3HY3ZF
   FIQT/H+Z+9XMXAL8NEI+5/ytDnutMGUkcK5s8DWBRpIif55hIRsI3pyXZ
   UaF1Tpf2jdFaqF/z42BB2Du7TA+KDglprWF2pfmEd2WRSt5J5Sv85iEH1
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="358482283"
X-IronPort-AV: E=Sophos;i="6.00,241,1681196400"; 
   d="scan'208";a="358482283"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2023 17:02:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="856296090"
X-IronPort-AV: E=Sophos;i="6.00,241,1681196400"; 
   d="scan'208";a="856296090"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga001.fm.intel.com with ESMTP; 13 Jun 2023 17:02:16 -0700
Received: from [10.251.24.95] (kliang2-mobl1.ccr.corp.intel.com [10.251.24.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 540E0580BEE;
        Tue, 13 Jun 2023 17:02:14 -0700 (PDT)
Message-ID: <2d5bb2ce-d8d5-40ca-5c5b-9eb08fa9c04f@linux.intel.com>
Date:   Tue, 13 Jun 2023 20:02:13 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 3/8] perf metric: JSON flag to default metric group
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>
Cc:     ahmad.yasin@intel.com, acme@kernel.org, mingo@redhat.com,
        peterz@infradead.org, namhyung@kernel.org, jolsa@kernel.org,
        adrian.hunter@intel.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, ak@linux.intel.com,
        eranian@google.com
References: <20230607162700.3234712-1-kan.liang@linux.intel.com>
 <20230607162700.3234712-4-kan.liang@linux.intel.com>
 <CAP-5=fUSKwTd8BKYfL+mwo=JmJb2qeR+BJ+1Br83jEiXtfjn7A@mail.gmail.com>
 <ae4ff916-5e79-0340-06d5-e4634913ba2e@linux.intel.com>
 <CAP-5=fVTDPCeaHHt9uQWdeczOKYDFNNuWFBxN-0pcsAjjvuR6g@mail.gmail.com>
 <46da55c7-ecb6-05af-e1b6-2100cd65b259@linux.intel.com>
 <CAP-5=fX_Fm0oRZqVpSa4XUtAfDSHsXQH9H+0SSvJCZxTtuO9+w@mail.gmail.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <CAP-5=fX_Fm0oRZqVpSa4XUtAfDSHsXQH9H+0SSvJCZxTtuO9+w@mail.gmail.com>
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



On 2023-06-13 5:28 p.m., Ian Rogers wrote:
> On Tue, Jun 13, 2023 at 2:00 PM Liang, Kan <kan.liang@linux.intel.com> wrote:
>>
>>
>>
>> On 2023-06-13 4:28 p.m., Ian Rogers wrote:
>>> On Tue, Jun 13, 2023 at 1:10 PM Liang, Kan <kan.liang@linux.intel.com> wrote:
>>>>
>>>>
>>>>
>>>> On 2023-06-13 3:44 p.m., Ian Rogers wrote:
>>>>> On Wed, Jun 7, 2023 at 9:27 AM <kan.liang@linux.intel.com> wrote:
>>>>>>
>>>>>> From: Kan Liang <kan.liang@linux.intel.com>
>>>>>>
>>>>>> For the default output, the default metric group could vary on different
>>>>>> platforms. For example, on SPR, the TopdownL1 and TopdownL2 metrics
>>>>>> should be displayed in the default mode. On ICL, only the TopdownL1
>>>>>> should be displayed.
>>>>>>
>>>>>> Add a flag so we can tag the default metric group for different
>>>>>> platforms rather than hack the perf code.
>>>>>>
>>>>>> The flag is added to Intel TopdownL1 since ICL and TopdownL2 metrics
>>>>>> since SPR.
>>>>>>
>>>>>> Add a new field, DefaultMetricgroupName, in the JSON file to indicate
>>>>>> the real metric group name.
>>>>>>
>>>>>> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
>>>>>> ---
>>>>>>  .../arch/x86/alderlake/adl-metrics.json       | 20 ++++---
>>>>>>  .../arch/x86/icelake/icl-metrics.json         | 20 ++++---
>>>>>>  .../arch/x86/icelakex/icx-metrics.json        | 20 ++++---
>>>>>>  .../arch/x86/sapphirerapids/spr-metrics.json  | 60 +++++++++++--------
>>>>>>  .../arch/x86/tigerlake/tgl-metrics.json       | 20 ++++---
>>>>>>  5 files changed, 84 insertions(+), 56 deletions(-)
>>>>>>
>>>>>> diff --git a/tools/perf/pmu-events/arch/x86/alderlake/adl-metrics.json b/tools/perf/pmu-events/arch/x86/alderlake/adl-metrics.json
>>>>>> index c9f7e3d4ab08..e78c85220e27 100644
>>>>>> --- a/tools/perf/pmu-events/arch/x86/alderlake/adl-metrics.json
>>>>>> +++ b/tools/perf/pmu-events/arch/x86/alderlake/adl-metrics.json
>>>>>> @@ -832,22 +832,24 @@
>>>>>>      },
>>>>>>      {
>>>>>>          "BriefDescription": "This category represents fraction of slots where no uops are being delivered due to a lack of required resources for accepting new uops in the Backend",
>>>>>> +        "DefaultMetricgroupName": "TopdownL1",
>>>>>>          "MetricExpr": "cpu_core@topdown\\-be\\-bound@ / (cpu_core@topdown\\-fe\\-bound@ + cpu_core@topdown\\-bad\\-spec@ + cpu_core@topdown\\-retiring@ + cpu_core@topdown\\-be\\-bound@) + 0 * tma_info_thread_slots",
>>>>>> -        "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
>>>>>> +        "MetricGroup": "Default;TmaL1;TopdownL1;tma_L1_group",
>>>>>>          "MetricName": "tma_backend_bound",
>>>>>>          "MetricThreshold": "tma_backend_bound > 0.2",
>>>>>> -        "MetricgroupNoGroup": "TopdownL1",
>>>>>> +        "MetricgroupNoGroup": "TopdownL1;Default",
>>>>>>          "PublicDescription": "This category represents fraction of slots where no uops are being delivered due to a lack of required resources for accepting new uops in the Backend. Backend is the portion of the processor core where the out-of-order scheduler dispatches ready uops into their respective execution units; and once completed these uops get retired according to program order. For example; stalls due to data-cache misses or stalls due to the divider unit being overloaded are both categorized under Backend Bound. Backend Bound is further divided into two main categories: Memory Bound and Core Bound. Sample with: TOPDOWN.BACKEND_BOUND_SLOTS",
>>>>>>          "ScaleUnit": "100%",
>>>>>>          "Unit": "cpu_core"
>>>>>>      },
>>>>>>      {
>>>>>>          "BriefDescription": "This category represents fraction of slots wasted due to incorrect speculations",
>>>>>> +        "DefaultMetricgroupName": "TopdownL1",
>>>>>>          "MetricExpr": "max(1 - (tma_frontend_bound + tma_backend_bound + tma_retiring), 0)",
>>>>>> -        "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
>>>>>> +        "MetricGroup": "Default;TmaL1;TopdownL1;tma_L1_group",
>>>>>>          "MetricName": "tma_bad_speculation",
>>>>>>          "MetricThreshold": "tma_bad_speculation > 0.15",
>>>>>> -        "MetricgroupNoGroup": "TopdownL1",
>>>>>> +        "MetricgroupNoGroup": "TopdownL1;Default",
>>>>>>          "PublicDescription": "This category represents fraction of slots wasted due to incorrect speculations. This include slots used to issue uops that do not eventually get retired and slots for which the issue-pipeline was blocked due to recovery from earlier incorrect speculation. For example; wasted work due to miss-predicted branches are categorized under Bad Speculation category. Incorrect data speculation followed by Memory Ordering Nukes is another example.",
>>>>>>          "ScaleUnit": "100%",
>>>>>>          "Unit": "cpu_core"
>>>>>> @@ -1112,11 +1114,12 @@
>>>>>>      },
>>>>>>      {
>>>>>>          "BriefDescription": "This category represents fraction of slots where the processor's Frontend undersupplies its Backend",
>>>>>> +        "DefaultMetricgroupName": "TopdownL1",
>>>>>>          "MetricExpr": "cpu_core@topdown\\-fe\\-bound@ / (cpu_core@topdown\\-fe\\-bound@ + cpu_core@topdown\\-bad\\-spec@ + cpu_core@topdown\\-retiring@ + cpu_core@topdown\\-be\\-bound@) - cpu_core@INT_MISC.UOP_DROPPING@ / tma_info_thread_slots",
>>>>>> -        "MetricGroup": "PGO;TmaL1;TopdownL1;tma_L1_group",
>>>>>> +        "MetricGroup": "Default;PGO;TmaL1;TopdownL1;tma_L1_group",
>>>>>>          "MetricName": "tma_frontend_bound",
>>>>>>          "MetricThreshold": "tma_frontend_bound > 0.15",
>>>>>> -        "MetricgroupNoGroup": "TopdownL1",
>>>>>> +        "MetricgroupNoGroup": "TopdownL1;Default",
>>>>>>          "PublicDescription": "This category represents fraction of slots where the processor's Frontend undersupplies its Backend. Frontend denotes the first part of the processor core responsible to fetch operations that are executed later on by the Backend part. Within the Frontend; a branch predictor predicts the next address to fetch; cache-lines are fetched from the memory subsystem; parsed into instructions; and lastly decoded into micro-operations (uops). Ideally the Frontend can issue Pipeline_Width uops every cycle to the Backend. Frontend Bound denotes unutilized issue-slots when there is no Backend stall; i.e. bubbles where Frontend delivered no uops while Backend could have accepted them. For example; stalls due to instruction-cache misses would be categorized under Frontend Bound. Sample with: FRONTEND_RETIRED.LATENCY_GE_4_PS",
>>>>>>          "ScaleUnit": "100%",
>>>>>>          "Unit": "cpu_core"
>>>>>> @@ -2316,11 +2319,12 @@
>>>>>>      },
>>>>>>      {
>>>>>>          "BriefDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired",
>>>>>> +        "DefaultMetricgroupName": "TopdownL1",
>>>>>>          "MetricExpr": "cpu_core@topdown\\-retiring@ / (cpu_core@topdown\\-fe\\-bound@ + cpu_core@topdown\\-bad\\-spec@ + cpu_core@topdown\\-retiring@ + cpu_core@topdown\\-be\\-bound@) + 0 * tma_info_thread_slots",
>>>>>> -        "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
>>>>>> +        "MetricGroup": "Default;TmaL1;TopdownL1;tma_L1_group",
>>>>>>          "MetricName": "tma_retiring",
>>>>>>          "MetricThreshold": "tma_retiring > 0.7 | tma_heavy_operations > 0.1",
>>>>>> -        "MetricgroupNoGroup": "TopdownL1",
>>>>>> +        "MetricgroupNoGroup": "TopdownL1;Default",
>>>>>>          "PublicDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired. Ideally; all pipeline slots would be attributed to the Retiring category.  Retiring of 100% would indicate the maximum Pipeline_Width throughput was achieved.  Maximizing Retiring typically increases the Instructions-per-cycle (see IPC metric). Note that a high Retiring value does not necessary mean there is no room for more performance.  For example; Heavy-operations or Microcode Assists are categorized under Retiring. They often indicate suboptimal performance and can often be optimized or avoided. Sample with: UOPS_RETIRED.SLOTS",
>>>>>>          "ScaleUnit": "100%",
>>>>>>          "Unit": "cpu_core"
>>>>>
>>>>> For Alderlake the Default metric group is added for all cpu_core
>>>>> metrics but not cpu_atom. This will lead to only getting metrics for
>>>>> performance cores while the workload could be running on atoms. This
>>>>> could lead to a false conclusion that the workload has no issues with
>>>>> the metrics. I think this behavior is surprising and should be called
>>>>> out as intentional in the commit message.
>>>>>
>>>>
>>>> The e-core doesn't have enough counters to calculate all the Topdown
>>>> events. It will trigger the multiplexing. We try to avoid it in the
>>>> default mode.
>>>> I will update the commit in V2.
>>>
>>> Is multiplexing a worse crime than only giving output for half the
>>> cores? Both can be misleading. Perhaps the safest thing is to not use
>>> Default on hybrid platforms.
>>>
>>
>> I think if we cannot give the accurate number, we shouldn't show it. I
>> don't think it's a problem just showing the Topdown on p-core. If the
>> user doesn't find their interested data in the default mode, they can
>> always use the --topdown for a specific core.
> 
> So --topdown is just dressing to using "-M TopdownL ..." and using -M
> is how to drill down by group. I'm not sure how useful the command
> line flag is, especially for levels >2.
> 
> Playing devil's advocate somewhat on the hybrid metric, let's say I
> configure a managed runtime like a JVM so that all garbage collector
> threads run on atom cores the main workload runs on the p-cores. This
> is at least done in research papers. Let's say the garbage collector
> is backend memory bound. The result from the default metrics won't
> show this just (from the cover letter):
> 
> ```
>  Performance counter stats for 'system wide':
> 
>          32,154.81 msec cpu-clock                        #   31.978
> CPUs utilized
>                165      context-switches                 #    5.131 /sec
>                 33      cpu-migrations                   #    1.026 /sec
>                 72      page-faults                      #    2.239 /sec
>          5,653,347      cpu_core/cycles/                 #    0.000 GHz
>          4,164,114      cpu_atom/cycles/                 #    0.000 GHz
>          3,921,839      cpu_core/instructions/           #    0.69
> insn per cycle
>          2,142,800      cpu_atom/instructions/           #    0.38
> insn per cycle
>            713,629      cpu_core/branches/               #   22.194 K/sec
>            452,838      cpu_atom/branches/               #   14.083 K/sec
>             26,810      cpu_core/branch-misses/          #    3.76% of
> all branches
>             26,029      cpu_atom/branch-misses/          #    3.65% of
> all branches
>              TopdownL1 (cpu_core)                 #     32.0 %
> tma_backend_bound
>                                                   #      8.0 %
> tma_bad_speculation
>                                                   #     45.5 %
> tma_frontend_bound
>                                                   #     14.5 %  tma_retiring
> ```
> 
> As the garbage collector needs to run to free memory it can lead to
> priority inversion where the garbage collector being slow is meaning
> there isn't enough heap on the p-cores. Here the user has to interpret
> the "(cpu_core)" to know that only half the metrics are shown and they
> should run with "-M TopdownL1" to get cpu_core and cpu_atom. From this
> they can see they have a memory bound issue on the atom cores. This
> seems less safe than reporting nothing then the user specifying "-M
> TopdownL1" to get the metrics on both cores.

OK. I will think about it. But no matter which way we choose, I think we
have to update the script anyway.

> 
> For the multiplexing problem, is it solved by removing IPC from this output?

No, IPC should only uses the fixed counters. The branch events share the
GP counters with the Topdown events.

Thanks,
Kan

> 
> Thanks,
> Ian
> 
>> Thanks,
>> Kan
>>
>>> Thanks,
>>> Ian
>>>
>>>> Thanks,
>>>> Kan
>>>>
>>>>> Thanks,
>>>>> Ian
>>>>>
>>>>>> diff --git a/tools/perf/pmu-events/arch/x86/icelake/icl-metrics.json b/tools/perf/pmu-events/arch/x86/icelake/icl-metrics.json
>>>>>> index 20210742171d..cc4edf855064 100644
>>>>>> --- a/tools/perf/pmu-events/arch/x86/icelake/icl-metrics.json
>>>>>> +++ b/tools/perf/pmu-events/arch/x86/icelake/icl-metrics.json
>>>>>> @@ -111,21 +111,23 @@
>>>>>>      },
>>>>>>      {
>>>>>>          "BriefDescription": "This category represents fraction of slots where no uops are being delivered due to a lack of required resources for accepting new uops in the Backend",
>>>>>> +        "DefaultMetricgroupName": "TopdownL1",
>>>>>>          "MetricExpr": "topdown\\-be\\-bound / (topdown\\-fe\\-bound + topdown\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) + 5 * cpu@INT_MISC.RECOVERY_CYCLES\\,cmask\\=1\\,edge@ / tma_info_thread_slots",
>>>>>> -        "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
>>>>>> +        "MetricGroup": "Default;TmaL1;TopdownL1;tma_L1_group",
>>>>>>          "MetricName": "tma_backend_bound",
>>>>>>          "MetricThreshold": "tma_backend_bound > 0.2",
>>>>>> -        "MetricgroupNoGroup": "TopdownL1",
>>>>>> +        "MetricgroupNoGroup": "TopdownL1;Default",
>>>>>>          "PublicDescription": "This category represents fraction of slots where no uops are being delivered due to a lack of required resources for accepting new uops in the Backend. Backend is the portion of the processor core where the out-of-order scheduler dispatches ready uops into their respective execution units; and once completed these uops get retired according to program order. For example; stalls due to data-cache misses or stalls due to the divider unit being overloaded are both categorized under Backend Bound. Backend Bound is further divided into two main categories: Memory Bound and Core Bound. Sample with: TOPDOWN.BACKEND_BOUND_SLOTS",
>>>>>>          "ScaleUnit": "100%"
>>>>>>      },
>>>>>>      {
>>>>>>          "BriefDescription": "This category represents fraction of slots wasted due to incorrect speculations",
>>>>>> +        "DefaultMetricgroupName": "TopdownL1",
>>>>>>          "MetricExpr": "max(1 - (tma_frontend_bound + tma_backend_bound + tma_retiring), 0)",
>>>>>> -        "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
>>>>>> +        "MetricGroup": "Default;TmaL1;TopdownL1;tma_L1_group",
>>>>>>          "MetricName": "tma_bad_speculation",
>>>>>>          "MetricThreshold": "tma_bad_speculation > 0.15",
>>>>>> -        "MetricgroupNoGroup": "TopdownL1",
>>>>>> +        "MetricgroupNoGroup": "TopdownL1;Default",
>>>>>>          "PublicDescription": "This category represents fraction of slots wasted due to incorrect speculations. This include slots used to issue uops that do not eventually get retired and slots for which the issue-pipeline was blocked due to recovery from earlier incorrect speculation. For example; wasted work due to miss-predicted branches are categorized under Bad Speculation category. Incorrect data speculation followed by Memory Ordering Nukes is another example.",
>>>>>>          "ScaleUnit": "100%"
>>>>>>      },
>>>>>> @@ -372,11 +374,12 @@
>>>>>>      },
>>>>>>      {
>>>>>>          "BriefDescription": "This category represents fraction of slots where the processor's Frontend undersupplies its Backend",
>>>>>> +        "DefaultMetricgroupName": "TopdownL1",
>>>>>>          "MetricExpr": "topdown\\-fe\\-bound / (topdown\\-fe\\-bound + topdown\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) - INT_MISC.UOP_DROPPING / tma_info_thread_slots",
>>>>>> -        "MetricGroup": "PGO;TmaL1;TopdownL1;tma_L1_group",
>>>>>> +        "MetricGroup": "Default;PGO;TmaL1;TopdownL1;tma_L1_group",
>>>>>>          "MetricName": "tma_frontend_bound",
>>>>>>          "MetricThreshold": "tma_frontend_bound > 0.15",
>>>>>> -        "MetricgroupNoGroup": "TopdownL1",
>>>>>> +        "MetricgroupNoGroup": "TopdownL1;Default",
>>>>>>          "PublicDescription": "This category represents fraction of slots where the processor's Frontend undersupplies its Backend. Frontend denotes the first part of the processor core responsible to fetch operations that are executed later on by the Backend part. Within the Frontend; a branch predictor predicts the next address to fetch; cache-lines are fetched from the memory subsystem; parsed into instructions; and lastly decoded into micro-operations (uops). Ideally the Frontend can issue Pipeline_Width uops every cycle to the Backend. Frontend Bound denotes unutilized issue-slots when there is no Backend stall; i.e. bubbles where Frontend delivered no uops while Backend could have accepted them. For example; stalls due to instruction-cache misses would be categorized under Frontend Bound. Sample with: FRONTEND_RETIRED.LATENCY_GE_4_PS",
>>>>>>          "ScaleUnit": "100%"
>>>>>>      },
>>>>>> @@ -1378,11 +1381,12 @@
>>>>>>      },
>>>>>>      {
>>>>>>          "BriefDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired",
>>>>>> +        "DefaultMetricgroupName": "TopdownL1",
>>>>>>          "MetricExpr": "topdown\\-retiring / (topdown\\-fe\\-bound + topdown\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) + 0 * tma_info_thread_slots",
>>>>>> -        "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
>>>>>> +        "MetricGroup": "Default;TmaL1;TopdownL1;tma_L1_group",
>>>>>>          "MetricName": "tma_retiring",
>>>>>>          "MetricThreshold": "tma_retiring > 0.7 | tma_heavy_operations > 0.1",
>>>>>> -        "MetricgroupNoGroup": "TopdownL1",
>>>>>> +        "MetricgroupNoGroup": "TopdownL1;Default",
>>>>>>          "PublicDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired. Ideally; all pipeline slots would be attributed to the Retiring category.  Retiring of 100% would indicate the maximum Pipeline_Width throughput was achieved.  Maximizing Retiring typically increases the Instructions-per-cycle (see IPC metric). Note that a high Retiring value does not necessary mean there is no room for more performance.  For example; Heavy-operations or Microcode Assists are categorized under Retiring. They often indicate suboptimal performance and can often be optimized or avoided. Sample with: UOPS_RETIRED.SLOTS",
>>>>>>          "ScaleUnit": "100%"
>>>>>>      },
>>>>>> diff --git a/tools/perf/pmu-events/arch/x86/icelakex/icx-metrics.json b/tools/perf/pmu-events/arch/x86/icelakex/icx-metrics.json
>>>>>> index ef25cda019be..6f25b5b7aaf6 100644
>>>>>> --- a/tools/perf/pmu-events/arch/x86/icelakex/icx-metrics.json
>>>>>> +++ b/tools/perf/pmu-events/arch/x86/icelakex/icx-metrics.json
>>>>>> @@ -315,21 +315,23 @@
>>>>>>      },
>>>>>>      {
>>>>>>          "BriefDescription": "This category represents fraction of slots where no uops are being delivered due to a lack of required resources for accepting new uops in the Backend",
>>>>>> +        "DefaultMetricgroupName": "TopdownL1",
>>>>>>          "MetricExpr": "topdown\\-be\\-bound / (topdown\\-fe\\-bound + topdown\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) + 5 * cpu@INT_MISC.RECOVERY_CYCLES\\,cmask\\=1\\,edge@ / tma_info_thread_slots",
>>>>>> -        "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
>>>>>> +        "MetricGroup": "Default;TmaL1;TopdownL1;tma_L1_group",
>>>>>>          "MetricName": "tma_backend_bound",
>>>>>>          "MetricThreshold": "tma_backend_bound > 0.2",
>>>>>> -        "MetricgroupNoGroup": "TopdownL1",
>>>>>> +        "MetricgroupNoGroup": "TopdownL1;Default",
>>>>>>          "PublicDescription": "This category represents fraction of slots where no uops are being delivered due to a lack of required resources for accepting new uops in the Backend. Backend is the portion of the processor core where the out-of-order scheduler dispatches ready uops into their respective execution units; and once completed these uops get retired according to program order. For example; stalls due to data-cache misses or stalls due to the divider unit being overloaded are both categorized under Backend Bound. Backend Bound is further divided into two main categories: Memory Bound and Core Bound. Sample with: TOPDOWN.BACKEND_BOUND_SLOTS",
>>>>>>          "ScaleUnit": "100%"
>>>>>>      },
>>>>>>      {
>>>>>>          "BriefDescription": "This category represents fraction of slots wasted due to incorrect speculations",
>>>>>> +        "DefaultMetricgroupName": "TopdownL1",
>>>>>>          "MetricExpr": "max(1 - (tma_frontend_bound + tma_backend_bound + tma_retiring), 0)",
>>>>>> -        "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
>>>>>> +        "MetricGroup": "Default;TmaL1;TopdownL1;tma_L1_group",
>>>>>>          "MetricName": "tma_bad_speculation",
>>>>>>          "MetricThreshold": "tma_bad_speculation > 0.15",
>>>>>> -        "MetricgroupNoGroup": "TopdownL1",
>>>>>> +        "MetricgroupNoGroup": "TopdownL1;Default",
>>>>>>          "PublicDescription": "This category represents fraction of slots wasted due to incorrect speculations. This include slots used to issue uops that do not eventually get retired and slots for which the issue-pipeline was blocked due to recovery from earlier incorrect speculation. For example; wasted work due to miss-predicted branches are categorized under Bad Speculation category. Incorrect data speculation followed by Memory Ordering Nukes is another example.",
>>>>>>          "ScaleUnit": "100%"
>>>>>>      },
>>>>>> @@ -576,11 +578,12 @@
>>>>>>      },
>>>>>>      {
>>>>>>          "BriefDescription": "This category represents fraction of slots where the processor's Frontend undersupplies its Backend",
>>>>>> +        "DefaultMetricgroupName": "TopdownL1",
>>>>>>          "MetricExpr": "topdown\\-fe\\-bound / (topdown\\-fe\\-bound + topdown\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) - INT_MISC.UOP_DROPPING / tma_info_thread_slots",
>>>>>> -        "MetricGroup": "PGO;TmaL1;TopdownL1;tma_L1_group",
>>>>>> +        "MetricGroup": "Default;PGO;TmaL1;TopdownL1;tma_L1_group",
>>>>>>          "MetricName": "tma_frontend_bound",
>>>>>>          "MetricThreshold": "tma_frontend_bound > 0.15",
>>>>>> -        "MetricgroupNoGroup": "TopdownL1",
>>>>>> +        "MetricgroupNoGroup": "TopdownL1;Default",
>>>>>>          "PublicDescription": "This category represents fraction of slots where the processor's Frontend undersupplies its Backend. Frontend denotes the first part of the processor core responsible to fetch operations that are executed later on by the Backend part. Within the Frontend; a branch predictor predicts the next address to fetch; cache-lines are fetched from the memory subsystem; parsed into instructions; and lastly decoded into micro-operations (uops). Ideally the Frontend can issue Pipeline_Width uops every cycle to the Backend. Frontend Bound denotes unutilized issue-slots when there is no Backend stall; i.e. bubbles where Frontend delivered no uops while Backend could have accepted them. For example; stalls due to instruction-cache misses would be categorized under Frontend Bound. Sample with: FRONTEND_RETIRED.LATENCY_GE_4_PS",
>>>>>>          "ScaleUnit": "100%"
>>>>>>      },
>>>>>> @@ -1674,11 +1677,12 @@
>>>>>>      },
>>>>>>      {
>>>>>>          "BriefDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired",
>>>>>> +        "DefaultMetricgroupName": "TopdownL1",
>>>>>>          "MetricExpr": "topdown\\-retiring / (topdown\\-fe\\-bound + topdown\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) + 0 * tma_info_thread_slots",
>>>>>> -        "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
>>>>>> +        "MetricGroup": "Default;TmaL1;TopdownL1;tma_L1_group",
>>>>>>          "MetricName": "tma_retiring",
>>>>>>          "MetricThreshold": "tma_retiring > 0.7 | tma_heavy_operations > 0.1",
>>>>>> -        "MetricgroupNoGroup": "TopdownL1",
>>>>>> +        "MetricgroupNoGroup": "TopdownL1;Default",
>>>>>>          "PublicDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired. Ideally; all pipeline slots would be attributed to the Retiring category.  Retiring of 100% would indicate the maximum Pipeline_Width throughput was achieved.  Maximizing Retiring typically increases the Instructions-per-cycle (see IPC metric). Note that a high Retiring value does not necessary mean there is no room for more performance.  For example; Heavy-operations or Microcode Assists are categorized under Retiring. They often indicate suboptimal performance and can often be optimized or avoided. Sample with: UOPS_RETIRED.SLOTS",
>>>>>>          "ScaleUnit": "100%"
>>>>>>      },
>>>>>> diff --git a/tools/perf/pmu-events/arch/x86/sapphirerapids/spr-metrics.json b/tools/perf/pmu-events/arch/x86/sapphirerapids/spr-metrics.json
>>>>>> index 4f3dd85540b6..c732982f70b5 100644
>>>>>> --- a/tools/perf/pmu-events/arch/x86/sapphirerapids/spr-metrics.json
>>>>>> +++ b/tools/perf/pmu-events/arch/x86/sapphirerapids/spr-metrics.json
>>>>>> @@ -340,31 +340,34 @@
>>>>>>      },
>>>>>>      {
>>>>>>          "BriefDescription": "This category represents fraction of slots where no uops are being delivered due to a lack of required resources for accepting new uops in the Backend",
>>>>>> +        "DefaultMetricgroupName": "TopdownL1",
>>>>>>          "MetricExpr": "topdown\\-be\\-bound / (topdown\\-fe\\-bound + topdown\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) + 0 * tma_info_thread_slots",
>>>>>> -        "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
>>>>>> +        "MetricGroup": "Default;TmaL1;TopdownL1;tma_L1_group",
>>>>>>          "MetricName": "tma_backend_bound",
>>>>>>          "MetricThreshold": "tma_backend_bound > 0.2",
>>>>>> -        "MetricgroupNoGroup": "TopdownL1",
>>>>>> +        "MetricgroupNoGroup": "TopdownL1;Default",
>>>>>>          "PublicDescription": "This category represents fraction of slots where no uops are being delivered due to a lack of required resources for accepting new uops in the Backend. Backend is the portion of the processor core where the out-of-order scheduler dispatches ready uops into their respective execution units; and once completed these uops get retired according to program order. For example; stalls due to data-cache misses or stalls due to the divider unit being overloaded are both categorized under Backend Bound. Backend Bound is further divided into two main categories: Memory Bound and Core Bound. Sample with: TOPDOWN.BACKEND_BOUND_SLOTS",
>>>>>>          "ScaleUnit": "100%"
>>>>>>      },
>>>>>>      {
>>>>>>          "BriefDescription": "This category represents fraction of slots wasted due to incorrect speculations",
>>>>>> +        "DefaultMetricgroupName": "TopdownL1",
>>>>>>          "MetricExpr": "max(1 - (tma_frontend_bound + tma_backend_bound + tma_retiring), 0)",
>>>>>> -        "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
>>>>>> +        "MetricGroup": "Default;TmaL1;TopdownL1;tma_L1_group",
>>>>>>          "MetricName": "tma_bad_speculation",
>>>>>>          "MetricThreshold": "tma_bad_speculation > 0.15",
>>>>>> -        "MetricgroupNoGroup": "TopdownL1",
>>>>>> +        "MetricgroupNoGroup": "TopdownL1;Default",
>>>>>>          "PublicDescription": "This category represents fraction of slots wasted due to incorrect speculations. This include slots used to issue uops that do not eventually get retired and slots for which the issue-pipeline was blocked due to recovery from earlier incorrect speculation. For example; wasted work due to miss-predicted branches are categorized under Bad Speculation category. Incorrect data speculation followed by Memory Ordering Nukes is another example.",
>>>>>>          "ScaleUnit": "100%"
>>>>>>      },
>>>>>>      {
>>>>>>          "BriefDescription": "This metric represents fraction of slots the CPU has wasted due to Branch Misprediction",
>>>>>> +        "DefaultMetricgroupName": "TopdownL2",
>>>>>>          "MetricExpr": "topdown\\-br\\-mispredict / (topdown\\-fe\\-bound + topdown\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) + 0 * tma_info_thread_slots",
>>>>>> -        "MetricGroup": "BadSpec;BrMispredicts;TmaL2;TopdownL2;tma_L2_group;tma_bad_speculation_group;tma_issueBM",
>>>>>> +        "MetricGroup": "BadSpec;BrMispredicts;Default;TmaL2;TopdownL2;tma_L2_group;tma_bad_speculation_group;tma_issueBM",
>>>>>>          "MetricName": "tma_branch_mispredicts",
>>>>>>          "MetricThreshold": "tma_branch_mispredicts > 0.1 & tma_bad_speculation > 0.15",
>>>>>> -        "MetricgroupNoGroup": "TopdownL2",
>>>>>> +        "MetricgroupNoGroup": "TopdownL2;Default",
>>>>>>          "PublicDescription": "This metric represents fraction of slots the CPU has wasted due to Branch Misprediction.  These slots are either wasted by uops fetched from an incorrectly speculated program path; or stalls when the out-of-order part of the machine needs to recover its state from a speculative path. Sample with: TOPDOWN.BR_MISPREDICT_SLOTS. Related metrics: tma_info_bad_spec_branch_misprediction_cost, tma_info_bottleneck_mispredictions, tma_mispredicts_resteers",
>>>>>>          "ScaleUnit": "100%"
>>>>>>      },
>>>>>> @@ -407,11 +410,12 @@
>>>>>>      },
>>>>>>      {
>>>>>>          "BriefDescription": "This metric represents fraction of slots where Core non-memory issues were of a bottleneck",
>>>>>> +        "DefaultMetricgroupName": "TopdownL2",
>>>>>>          "MetricExpr": "max(0, tma_backend_bound - tma_memory_bound)",
>>>>>> -        "MetricGroup": "Backend;Compute;TmaL2;TopdownL2;tma_L2_group;tma_backend_bound_group",
>>>>>> +        "MetricGroup": "Backend;Compute;Default;TmaL2;TopdownL2;tma_L2_group;tma_backend_bound_group",
>>>>>>          "MetricName": "tma_core_bound",
>>>>>>          "MetricThreshold": "tma_core_bound > 0.1 & tma_backend_bound > 0.2",
>>>>>> -        "MetricgroupNoGroup": "TopdownL2",
>>>>>> +        "MetricgroupNoGroup": "TopdownL2;Default",
>>>>>>          "PublicDescription": "This metric represents fraction of slots where Core non-memory issues were of a bottleneck.  Shortage in hardware compute resources; or dependencies in software's instructions are both categorized under Core Bound. Hence it may indicate the machine ran out of an out-of-order resource; certain execution units are overloaded or dependencies in program's data- or instruction-flow are limiting the performance (e.g. FP-chained long-latency arithmetic operations).",
>>>>>>          "ScaleUnit": "100%"
>>>>>>      },
>>>>>> @@ -509,21 +513,23 @@
>>>>>>      },
>>>>>>      {
>>>>>>          "BriefDescription": "This metric represents fraction of slots the CPU was stalled due to Frontend bandwidth issues",
>>>>>> +        "DefaultMetricgroupName": "TopdownL2",
>>>>>>          "MetricExpr": "max(0, tma_frontend_bound - tma_fetch_latency)",
>>>>>> -        "MetricGroup": "FetchBW;Frontend;TmaL2;TopdownL2;tma_L2_group;tma_frontend_bound_group;tma_issueFB",
>>>>>> +        "MetricGroup": "Default;FetchBW;Frontend;TmaL2;TopdownL2;tma_L2_group;tma_frontend_bound_group;tma_issueFB",
>>>>>>          "MetricName": "tma_fetch_bandwidth",
>>>>>>          "MetricThreshold": "tma_fetch_bandwidth > 0.1 & tma_frontend_bound > 0.15 & tma_info_thread_ipc / 6 > 0.35",
>>>>>> -        "MetricgroupNoGroup": "TopdownL2",
>>>>>> +        "MetricgroupNoGroup": "TopdownL2;Default",
>>>>>>          "PublicDescription": "This metric represents fraction of slots the CPU was stalled due to Frontend bandwidth issues.  For example; inefficiencies at the instruction decoders; or restrictions for caching in the DSB (decoded uops cache) are categorized under Fetch Bandwidth. In such cases; the Frontend typically delivers suboptimal amount of uops to the Backend. Sample with: FRONTEND_RETIRED.LATENCY_GE_2_BUBBLES_GE_1_PS;FRONTEND_RETIRED.LATENCY_GE_1_PS;FRONTEND_RETIRED.LATENCY_GE_2_PS. Related metrics: tma_dsb_switches, tma_info_botlnk_l2_dsb_misses, tma_info_frontend_dsb_coverage, tma_info_inst_mix_iptb, tma_lcp",
>>>>>>          "ScaleUnit": "100%"
>>>>>>      },
>>>>>>      {
>>>>>>          "BriefDescription": "This metric represents fraction of slots the CPU was stalled due to Frontend latency issues",
>>>>>> +        "DefaultMetricgroupName": "TopdownL2",
>>>>>>          "MetricExpr": "topdown\\-fetch\\-lat / (topdown\\-fe\\-bound + topdown\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) - INT_MISC.UOP_DROPPING / tma_info_thread_slots",
>>>>>> -        "MetricGroup": "Frontend;TmaL2;TopdownL2;tma_L2_group;tma_frontend_bound_group",
>>>>>> +        "MetricGroup": "Default;Frontend;TmaL2;TopdownL2;tma_L2_group;tma_frontend_bound_group",
>>>>>>          "MetricName": "tma_fetch_latency",
>>>>>>          "MetricThreshold": "tma_fetch_latency > 0.1 & tma_frontend_bound > 0.15",
>>>>>> -        "MetricgroupNoGroup": "TopdownL2",
>>>>>> +        "MetricgroupNoGroup": "TopdownL2;Default",
>>>>>>          "PublicDescription": "This metric represents fraction of slots the CPU was stalled due to Frontend latency issues.  For example; instruction-cache misses; iTLB misses or fetch stalls after a branch misprediction are categorized under Frontend Latency. In such cases; the Frontend eventually delivers no uops for some period. Sample with: FRONTEND_RETIRED.LATENCY_GE_16_PS;FRONTEND_RETIRED.LATENCY_GE_8_PS",
>>>>>>          "ScaleUnit": "100%"
>>>>>>      },
>>>>>> @@ -611,11 +617,12 @@
>>>>>>      },
>>>>>>      {
>>>>>>          "BriefDescription": "This category represents fraction of slots where the processor's Frontend undersupplies its Backend",
>>>>>> +        "DefaultMetricgroupName": "TopdownL1",
>>>>>>          "MetricExpr": "topdown\\-fe\\-bound / (topdown\\-fe\\-bound + topdown\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) - INT_MISC.UOP_DROPPING / tma_info_thread_slots",
>>>>>> -        "MetricGroup": "PGO;TmaL1;TopdownL1;tma_L1_group",
>>>>>> +        "MetricGroup": "Default;PGO;TmaL1;TopdownL1;tma_L1_group",
>>>>>>          "MetricName": "tma_frontend_bound",
>>>>>>          "MetricThreshold": "tma_frontend_bound > 0.15",
>>>>>> -        "MetricgroupNoGroup": "TopdownL1",
>>>>>> +        "MetricgroupNoGroup": "TopdownL1;Default",
>>>>>>          "PublicDescription": "This category represents fraction of slots where the processor's Frontend undersupplies its Backend. Frontend denotes the first part of the processor core responsible to fetch operations that are executed later on by the Backend part. Within the Frontend; a branch predictor predicts the next address to fetch; cache-lines are fetched from the memory subsystem; parsed into instructions; and lastly decoded into micro-operations (uops). Ideally the Frontend can issue Pipeline_Width uops every cycle to the Backend. Frontend Bound denotes unutilized issue-slots when there is no Backend stall; i.e. bubbles where Frontend delivered no uops while Backend could have accepted them. For example; stalls due to instruction-cache misses would be categorized under Frontend Bound. Sample with: FRONTEND_RETIRED.LATENCY_GE_4_PS",
>>>>>>          "ScaleUnit": "100%"
>>>>>>      },
>>>>>> @@ -630,11 +637,12 @@
>>>>>>      },
>>>>>>      {
>>>>>>          "BriefDescription": "This metric represents fraction of slots where the CPU was retiring heavy-weight operations -- instructions that require two or more uops or micro-coded sequences",
>>>>>> +        "DefaultMetricgroupName": "TopdownL2",
>>>>>>          "MetricExpr": "topdown\\-heavy\\-ops / (topdown\\-fe\\-bound + topdown\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) + 0 * tma_info_thread_slots",
>>>>>> -        "MetricGroup": "Retire;TmaL2;TopdownL2;tma_L2_group;tma_retiring_group",
>>>>>> +        "MetricGroup": "Default;Retire;TmaL2;TopdownL2;tma_L2_group;tma_retiring_group",
>>>>>>          "MetricName": "tma_heavy_operations",
>>>>>>          "MetricThreshold": "tma_heavy_operations > 0.1",
>>>>>> -        "MetricgroupNoGroup": "TopdownL2",
>>>>>> +        "MetricgroupNoGroup": "TopdownL2;Default",
>>>>>>          "PublicDescription": "This metric represents fraction of slots where the CPU was retiring heavy-weight operations -- instructions that require two or more uops or micro-coded sequences. This highly-correlates with the uop length of these instructions/sequences. Sample with: UOPS_RETIRED.HEAVY",
>>>>>>          "ScaleUnit": "100%"
>>>>>>      },
>>>>>> @@ -1486,11 +1494,12 @@
>>>>>>      },
>>>>>>      {
>>>>>>          "BriefDescription": "This metric represents fraction of slots where the CPU was retiring light-weight operations -- instructions that require no more than one uop (micro-operation)",
>>>>>> +        "DefaultMetricgroupName": "TopdownL2",
>>>>>>          "MetricExpr": "max(0, tma_retiring - tma_heavy_operations)",
>>>>>> -        "MetricGroup": "Retire;TmaL2;TopdownL2;tma_L2_group;tma_retiring_group",
>>>>>> +        "MetricGroup": "Default;Retire;TmaL2;TopdownL2;tma_L2_group;tma_retiring_group",
>>>>>>          "MetricName": "tma_light_operations",
>>>>>>          "MetricThreshold": "tma_light_operations > 0.6",
>>>>>> -        "MetricgroupNoGroup": "TopdownL2",
>>>>>> +        "MetricgroupNoGroup": "TopdownL2;Default",
>>>>>>          "PublicDescription": "This metric represents fraction of slots where the CPU was retiring light-weight operations -- instructions that require no more than one uop (micro-operation). This correlates with total number of instructions used by the program. A uops-per-instruction (see UopPI metric) ratio of 1 or less should be expected for decently optimized software running on Intel Core/Xeon products. While this often indicates efficient X86 instructions were executed; high value does not necessarily mean better performance cannot be achieved. Sample with: INST_RETIRED.PREC_DIST",
>>>>>>          "ScaleUnit": "100%"
>>>>>>      },
>>>>>> @@ -1540,11 +1549,12 @@
>>>>>>      },
>>>>>>      {
>>>>>>          "BriefDescription": "This metric represents fraction of slots the CPU has wasted due to Machine Clears",
>>>>>> +        "DefaultMetricgroupName": "TopdownL2",
>>>>>>          "MetricExpr": "max(0, tma_bad_speculation - tma_branch_mispredicts)",
>>>>>> -        "MetricGroup": "BadSpec;MachineClears;TmaL2;TopdownL2;tma_L2_group;tma_bad_speculation_group;tma_issueMC;tma_issueSyncxn",
>>>>>> +        "MetricGroup": "BadSpec;Default;MachineClears;TmaL2;TopdownL2;tma_L2_group;tma_bad_speculation_group;tma_issueMC;tma_issueSyncxn",
>>>>>>          "MetricName": "tma_machine_clears",
>>>>>>          "MetricThreshold": "tma_machine_clears > 0.1 & tma_bad_speculation > 0.15",
>>>>>> -        "MetricgroupNoGroup": "TopdownL2",
>>>>>> +        "MetricgroupNoGroup": "TopdownL2;Default",
>>>>>>          "PublicDescription": "This metric represents fraction of slots the CPU has wasted due to Machine Clears.  These slots are either wasted by uops fetched prior to the clear; or stalls the out-of-order portion of the machine needs to recover its state after the clear. For example; this can happen due to memory ordering Nukes (e.g. Memory Disambiguation) or Self-Modifying-Code (SMC) nukes. Sample with: MACHINE_CLEARS.COUNT. Related metrics: tma_clears_resteers, tma_contested_accesses, tma_data_sharing, tma_false_sharing, tma_l1_bound, tma_microcode_sequencer, tma_ms_switches, tma_remote_cache",
>>>>>>          "ScaleUnit": "100%"
>>>>>>      },
>>>>>> @@ -1576,11 +1586,12 @@
>>>>>>      },
>>>>>>      {
>>>>>>          "BriefDescription": "This metric represents fraction of slots the Memory subsystem within the Backend was a bottleneck",
>>>>>> +        "DefaultMetricgroupName": "TopdownL2",
>>>>>>          "MetricExpr": "topdown\\-mem\\-bound / (topdown\\-fe\\-bound + topdown\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) + 0 * tma_info_thread_slots",
>>>>>> -        "MetricGroup": "Backend;TmaL2;TopdownL2;tma_L2_group;tma_backend_bound_group",
>>>>>> +        "MetricGroup": "Backend;Default;TmaL2;TopdownL2;tma_L2_group;tma_backend_bound_group",
>>>>>>          "MetricName": "tma_memory_bound",
>>>>>>          "MetricThreshold": "tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
>>>>>> -        "MetricgroupNoGroup": "TopdownL2",
>>>>>> +        "MetricgroupNoGroup": "TopdownL2;Default",
>>>>>>          "PublicDescription": "This metric represents fraction of slots the Memory subsystem within the Backend was a bottleneck.  Memory Bound estimates fraction of slots where pipeline is likely stalled due to demand load or store instructions. This accounts mainly for (1) non-completed in-flight memory demand loads which coincides with execution units starvation; in addition to (2) cases where stores could impose backpressure on the pipeline when many of them get buffered at the same time (less common out of the two).",
>>>>>>          "ScaleUnit": "100%"
>>>>>>      },
>>>>>> @@ -1784,11 +1795,12 @@
>>>>>>      },
>>>>>>      {
>>>>>>          "BriefDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired",
>>>>>> +        "DefaultMetricgroupName": "TopdownL1",
>>>>>>          "MetricExpr": "topdown\\-retiring / (topdown\\-fe\\-bound + topdown\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) + 0 * tma_info_thread_slots",
>>>>>> -        "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
>>>>>> +        "MetricGroup": "Default;TmaL1;TopdownL1;tma_L1_group",
>>>>>>          "MetricName": "tma_retiring",
>>>>>>          "MetricThreshold": "tma_retiring > 0.7 | tma_heavy_operations > 0.1",
>>>>>> -        "MetricgroupNoGroup": "TopdownL1",
>>>>>> +        "MetricgroupNoGroup": "TopdownL1;Default",
>>>>>>          "PublicDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired. Ideally; all pipeline slots would be attributed to the Retiring category.  Retiring of 100% would indicate the maximum Pipeline_Width throughput was achieved.  Maximizing Retiring typically increases the Instructions-per-cycle (see IPC metric). Note that a high Retiring value does not necessary mean there is no room for more performance.  For example; Heavy-operations or Microcode Assists are categorized under Retiring. They often indicate suboptimal performance and can often be optimized or avoided. Sample with: UOPS_RETIRED.SLOTS",
>>>>>>          "ScaleUnit": "100%"
>>>>>>      },
>>>>>> diff --git a/tools/perf/pmu-events/arch/x86/tigerlake/tgl-metrics.json b/tools/perf/pmu-events/arch/x86/tigerlake/tgl-metrics.json
>>>>>> index d0538a754288..83346911aa63 100644
>>>>>> --- a/tools/perf/pmu-events/arch/x86/tigerlake/tgl-metrics.json
>>>>>> +++ b/tools/perf/pmu-events/arch/x86/tigerlake/tgl-metrics.json
>>>>>> @@ -105,21 +105,23 @@
>>>>>>      },
>>>>>>      {
>>>>>>          "BriefDescription": "This category represents fraction of slots where no uops are being delivered due to a lack of required resources for accepting new uops in the Backend",
>>>>>> +        "DefaultMetricgroupName": "TopdownL1",
>>>>>>          "MetricExpr": "topdown\\-be\\-bound / (topdown\\-fe\\-bound + topdown\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) + 5 * cpu@INT_MISC.RECOVERY_CYCLES\\,cmask\\=1\\,edge@ / tma_info_thread_slots",
>>>>>> -        "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
>>>>>> +        "MetricGroup": "Default;TmaL1;TopdownL1;tma_L1_group",
>>>>>>          "MetricName": "tma_backend_bound",
>>>>>>          "MetricThreshold": "tma_backend_bound > 0.2",
>>>>>> -        "MetricgroupNoGroup": "TopdownL1",
>>>>>> +        "MetricgroupNoGroup": "TopdownL1;Default",
>>>>>>          "PublicDescription": "This category represents fraction of slots where no uops are being delivered due to a lack of required resources for accepting new uops in the Backend. Backend is the portion of the processor core where the out-of-order scheduler dispatches ready uops into their respective execution units; and once completed these uops get retired according to program order. For example; stalls due to data-cache misses or stalls due to the divider unit being overloaded are both categorized under Backend Bound. Backend Bound is further divided into two main categories: Memory Bound and Core Bound. Sample with: TOPDOWN.BACKEND_BOUND_SLOTS",
>>>>>>          "ScaleUnit": "100%"
>>>>>>      },
>>>>>>      {
>>>>>>          "BriefDescription": "This category represents fraction of slots wasted due to incorrect speculations",
>>>>>> +        "DefaultMetricgroupName": "TopdownL1",
>>>>>>          "MetricExpr": "max(1 - (tma_frontend_bound + tma_backend_bound + tma_retiring), 0)",
>>>>>> -        "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
>>>>>> +        "MetricGroup": "Default;TmaL1;TopdownL1;tma_L1_group",
>>>>>>          "MetricName": "tma_bad_speculation",
>>>>>>          "MetricThreshold": "tma_bad_speculation > 0.15",
>>>>>> -        "MetricgroupNoGroup": "TopdownL1",
>>>>>> +        "MetricgroupNoGroup": "TopdownL1;Default",
>>>>>>          "PublicDescription": "This category represents fraction of slots wasted due to incorrect speculations. This include slots used to issue uops that do not eventually get retired and slots for which the issue-pipeline was blocked due to recovery from earlier incorrect speculation. For example; wasted work due to miss-predicted branches are categorized under Bad Speculation category. Incorrect data speculation followed by Memory Ordering Nukes is another example.",
>>>>>>          "ScaleUnit": "100%"
>>>>>>      },
>>>>>> @@ -366,11 +368,12 @@
>>>>>>      },
>>>>>>      {
>>>>>>          "BriefDescription": "This category represents fraction of slots where the processor's Frontend undersupplies its Backend",
>>>>>> +        "DefaultMetricgroupName": "TopdownL1",
>>>>>>          "MetricExpr": "topdown\\-fe\\-bound / (topdown\\-fe\\-bound + topdown\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) - INT_MISC.UOP_DROPPING / tma_info_thread_slots",
>>>>>> -        "MetricGroup": "PGO;TmaL1;TopdownL1;tma_L1_group",
>>>>>> +        "MetricGroup": "Default;PGO;TmaL1;TopdownL1;tma_L1_group",
>>>>>>          "MetricName": "tma_frontend_bound",
>>>>>>          "MetricThreshold": "tma_frontend_bound > 0.15",
>>>>>> -        "MetricgroupNoGroup": "TopdownL1",
>>>>>> +        "MetricgroupNoGroup": "TopdownL1;Default",
>>>>>>          "PublicDescription": "This category represents fraction of slots where the processor's Frontend undersupplies its Backend. Frontend denotes the first part of the processor core responsible to fetch operations that are executed later on by the Backend part. Within the Frontend; a branch predictor predicts the next address to fetch; cache-lines are fetched from the memory subsystem; parsed into instructions; and lastly decoded into micro-operations (uops). Ideally the Frontend can issue Pipeline_Width uops every cycle to the Backend. Frontend Bound denotes unutilized issue-slots when there is no Backend stall; i.e. bubbles where Frontend delivered no uops while Backend could have accepted them. For example; stalls due to instruction-cache misses would be categorized under Frontend Bound. Sample with: FRONTEND_RETIRED.LATENCY_GE_4_PS",
>>>>>>          "ScaleUnit": "100%"
>>>>>>      },
>>>>>> @@ -1392,11 +1395,12 @@
>>>>>>      },
>>>>>>      {
>>>>>>          "BriefDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired",
>>>>>> +        "DefaultMetricgroupName": "TopdownL1",
>>>>>>          "MetricExpr": "topdown\\-retiring / (topdown\\-fe\\-bound + topdown\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) + 0 * tma_info_thread_slots",
>>>>>> -        "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
>>>>>> +        "MetricGroup": "Default;TmaL1;TopdownL1;tma_L1_group",
>>>>>>          "MetricName": "tma_retiring",
>>>>>>          "MetricThreshold": "tma_retiring > 0.7 | tma_heavy_operations > 0.1",
>>>>>> -        "MetricgroupNoGroup": "TopdownL1",
>>>>>> +        "MetricgroupNoGroup": "TopdownL1;Default",
>>>>>>          "PublicDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired. Ideally; all pipeline slots would be attributed to the Retiring category.  Retiring of 100% would indicate the maximum Pipeline_Width throughput was achieved.  Maximizing Retiring typically increases the Instructions-per-cycle (see IPC metric). Note that a high Retiring value does not necessary mean there is no room for more performance.  For example; Heavy-operations or Microcode Assists are categorized under Retiring. They often indicate suboptimal performance and can often be optimized or avoided. Sample with: UOPS_RETIRED.SLOTS",
>>>>>>          "ScaleUnit": "100%"
>>>>>>      },
>>>>>> --
>>>>>> 2.35.1
>>>>>>
