Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 343115EF016
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 10:13:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235151AbiI2IND (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 04:13:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234998AbiI2INA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 04:13:00 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA59413BCC1;
        Thu, 29 Sep 2022 01:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664439178; x=1695975178;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=IQ7z/I+zLeVa5Aa6mLZ8ZxCc1tq6PQJIg4/ITcyKHNc=;
  b=EiRV/+ei1DIliOEr1P5AbqFsdQpPMQNZUOPgGKHXGBwgKz9MWsaNI++T
   TeQvSMg9RbRWAl5kQwpNorx7YftO301b/SUHYsLldUh5y82zI5msAIniq
   RDYe4bpg4Idmr2vB8gKi6X8hiomWo7e3tpVMSJQqHUjVBmIwFqIMCcS75
   3XRBUbT+HG8lhQeAwtoP1jPMj7IJ1JfCfBeUaUhmgFz9yvtzW1ilYENXm
   H8/9c7mc+xB0k/yeQ2hCbHTSso2buA2Iu7uddoGOjCMDQg2V2kloeVS+W
   a+e0klaL6QybS7oHi3eWfra5G9oTdRObuhg9SDqHUbfV0m+s0t/Wi3uSo
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10484"; a="299428164"
X-IronPort-AV: E=Sophos;i="5.93,354,1654585200"; 
   d="scan'208";a="299428164"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2022 01:12:58 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10484"; a="726296616"
X-IronPort-AV: E=Sophos;i="5.93,354,1654585200"; 
   d="scan'208";a="726296616"
Received: from xingzhen-mobl.ccr.corp.intel.com (HELO [10.238.4.231]) ([10.238.4.231])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2022 01:12:53 -0700
Message-ID: <dd33559e-5d55-9866-136f-554466c0c44f@linux.intel.com>
Date:   Thu, 29 Sep 2022 16:12:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v1 05/22] perf vendor events: Update Intel alderlake
To:     Ian Rogers <irogers@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, perry.taylor@intel.com,
        caleb.biggers@intel.com, kshipra.bopardikar@intel.com,
        samantha.alt@intel.com, ahmad.yasin@intel.com,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
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
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
References: <20220928072204.1613330-1-irogers@google.com>
 <20220928072204.1613330-6-irogers@google.com>
 <44f59d7c-ced7-2d74-edbc-f354047339fe@linux.intel.com>
 <YzRVOD4u2SI0K29Y@kernel.org>
 <CAP-5=fUogKZx6JP_vg+6ti+BnbEcX+3Wnzi077s4VgxEKLpQeQ@mail.gmail.com>
Content-Language: en-US
From:   Xing Zhengjun <zhengjun.xing@linux.intel.com>
In-Reply-To: <CAP-5=fUogKZx6JP_vg+6ti+BnbEcX+3Wnzi077s4VgxEKLpQeQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/29/2022 10:23 AM, Ian Rogers wrote:
> On Wed, Sep 28, 2022 at 7:08 AM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
>>
>> Em Wed, Sep 28, 2022 at 04:22:53PM +0800, Xing Zhengjun escreveu:
>>> On 9/28/2022 3:21 PM, Ian Rogers wrote:
>>>> diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-events/arch/x86/mapfile.csv
>>>> index 7f2d777fd97f..594c6e96f0ce 100644
>>>> --- a/tools/perf/pmu-events/arch/x86/mapfile.csv
>>>> +++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
>>>> @@ -1,5 +1,5 @@
>>>>    Family-model,Version,Filename,EventType
>>>> -GenuineIntel-6-9[7A],v1.13,alderlake,core
>>>> +GenuineIntel-6-(97|9A|B7|BA|BF),v1.15,alderlake,core
>>>
>>> The commit description should mention this change "Add more CPUID support
>>> for ADL"
>>
>> I added this note, with that can I have your Reviewed-by or Acked-by?
>>
>> - Arnaldo
> 
> I think I should send a v2. I can add this then. Other things for v2 are:
> - this week there will likely be an update to [1] which is implicitly
> integrated here.
> - the topdown metrics are all percentages but are currently values
> zero to 1. It is straightforward to add a ScaleUnit of 100% to them
> all.
> - eyeballing topdown event metrics like:
> 
>      {
>         "BriefDescription": "This category represents fraction of slots
> utilized by useful work i.e. issued uops that eventually get retired",
>         "MetricExpr": "topdown\\-retiring / (topdown\\-fe\\-bound +
> topdown\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound)",
>         "MetricGroup": "TopdownL1;tma_L1_group",
>         "MetricName": "tma_retiring",
> ...
> it looks like the group will fail due to the missing slots event. This
> can be fixed with:
>         "MetricExpr": "topdown\\-retiring / (topdown\\-fe\\-bound +
> topdown\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) + 0
> * TOPDOWN.SLOTS",
> 
> Thanks,
> Ian

I just test all the events for SPR/ADL, no error find.
But there are a lots of metrics fail due to slots missed.

|0929_005708.420|ERROR| common.sh:123:do_cmd() - perf stat -M 
"tma_branch_mispredicts" -a sleep 0.1 failed. Return code is 255|
|0929_005709.221|ERROR| common.sh:123:do_cmd() - perf stat -M 
"tma_backend_bound" -a sleep 0.1 failed. Return code is 255|
|0929_005709.544|ERROR| common.sh:123:do_cmd() - perf stat -M 
"tma_memory_bound" -a sleep 0.1 failed. Return code is 255|
|0929_005723.757|ERROR| common.sh:123:do_cmd() - perf stat -M 
"tma_core_bound" -a sleep 0.1 failed. Return code is 255|
|0929_005724.531|ERROR| common.sh:123:do_cmd() - perf stat -M 
"tma_ports_utilization" -a sleep 0.1 failed. Return code is 255|
|0929_005731.541|ERROR| common.sh:123:do_cmd() - perf stat -M 
"tma_retiring" -a sleep 0.1 failed. Return code is 255|
|0929_005731.860|ERROR| common.sh:123:do_cmd() - perf stat -M 
"tma_light_operations" -a sleep 0.1 failed. Return code is 255|
|0929_005732.811|ERROR| common.sh:123:do_cmd() - perf stat -M 
"tma_x87_use" -a sleep 0.1 failed. Return code is 255|
|0929_005741.026|ERROR| common.sh:123:do_cmd() - perf stat -M 
"tma_heavy_operations" -a sleep 0.1 failed. Return code is 255|
|0929_005746.165|ERROR| common.sh:123:do_cmd() - perf stat -M 
"Memory_Latency" -a sleep 0.1 failed. Return code is 255|

# perf stat -v  -M "tma_branch_mispredicts" -a sleep 1
Using CPUID GenuineIntel-6-8F-3
metric expr topdown\-br\-mispredict / (topdown\-fe\-bound + 
topdown\-bad\-spec + topdown\-retiring + topdown\-be\-bound) for 
tma_branch_mispredicts
found event topdown-retiring
found event topdown-fe-bound
found event topdown-be-bound
found event topdown-br-mispredict
found event topdown-bad-spec
Parsing metric events 
'{topdown-retiring/metric-id=topdown!1retiring/,topdown-fe-bound/metric-id=topdown!1fe!1bound/,topdown-be-bound/metric-id=topdown!1be!1bound/,topdown-br-mispredict/metric-id=topdown!1br!1mispredict/,topdown-bad-spec/metric-id=topdown!1bad!1spec/}:W'
topdown-retiring -> cpu/event=0,umask=0x80/
topdown-fe-bound -> cpu/event=0,umask=0x82/
topdown-be-bound -> cpu/event=0,umask=0x83/
topdown-br-mispredict -> cpu/event=0,umask=0x85/
topdown-bad-spec -> cpu/event=0,umask=0x81/
Control descriptor is not initialized
Warning:
topdown-retiring event is not supported by the kernel.
Error:
The sys_perf_event_open() syscall returned with 22 (Invalid argument) 
for event (topdown-retiring).
/bin/dmesg | grep -i perf may provide additional information.


> 
> [1] https://github.com/intel/perfmon-metrics
> 
>>>>    GenuineIntel-6-(1C|26|27|35|36),v4,bonnell,core
>>>>    GenuineIntel-6-(3D|47),v26,broadwell,core
>>>>    GenuineIntel-6-56,v23,broadwellde,core
>>>
>>> --
>>> Zhengjun Xing
>>
>> --
>>
>> - Arnaldo

-- 
Zhengjun Xing
