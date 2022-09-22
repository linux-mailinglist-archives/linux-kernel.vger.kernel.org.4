Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63BFF5E5CD4
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 10:04:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbiIVIEL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 04:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbiIVIEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 04:04:08 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B82D20368;
        Thu, 22 Sep 2022 01:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663833846; x=1695369846;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=swqLIFUJLee+tTUNcuKbWi4nltLV2M9jqpih8qTBSjc=;
  b=L6cS3v8xQ9C3OuvniTgIIx9mpZhQr/suDJSMKSrRVZD6XtfdWI7S+NbM
   HNhri8Gg6heid9Zr08WbElQtWIQVVvTYyAPMfwUnMMrArErxR93bsZ5ew
   2ko9ivVKffybdi2cPe35MzexcFVR4olr0DUKW4UrKglAWSPeUERBakPF0
   MjbiQoLJcVisy1RzjIndnadOgkd2PPOJtvszKAFVgyjOYkl15eIef6ljx
   j1BxweC6Mnjxs0UXXyb+4hXa3pMPufElattyFT30daNlWA7m/tqPO3Vsc
   KPkVNNI0wiw8JWXeo2CS9Uoq/MivDmtsrmBa0g20OVaERYwPMl/A3GNiF
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10477"; a="326551134"
X-IronPort-AV: E=Sophos;i="5.93,335,1654585200"; 
   d="scan'208";a="326551134"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 01:04:05 -0700
X-IronPort-AV: E=Sophos;i="5.93,335,1654585200"; 
   d="scan'208";a="622002962"
Received: from xingzhen-mobl.ccr.corp.intel.com (HELO [10.238.4.231]) ([10.238.4.231])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 01:04:03 -0700
Message-ID: <7837075e-54cf-3e59-f60f-eb62fca4a3c5@linux.intel.com>
Date:   Thu, 22 Sep 2022 16:04:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH 2/2] perf parse-events: Remove "not supported" hybrid
 cache events
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>
Cc:     acme@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@intel.com, jolsa@kernel.org,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, ak@linux.intel.com,
        kan.liang@linux.intel.com
References: <20220922014904.3665674-1-zhengjun.xing@linux.intel.com>
 <20220922014904.3665674-2-zhengjun.xing@linux.intel.com>
 <CAP-5=fWhPAcbbws3H=VC7F3qnXv4hkbMd3rjk4_HtsBAQHPTTg@mail.gmail.com>
From:   Xing Zhengjun <zhengjun.xing@linux.intel.com>
In-Reply-To: <CAP-5=fWhPAcbbws3H=VC7F3qnXv4hkbMd3rjk4_HtsBAQHPTTg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/22/2022 11:16 AM, Ian Rogers wrote:
> On Wed, Sep 21, 2022 at 6:47 PM <zhengjun.xing@linux.intel.com> wrote:
>>
>> From: Zhengjun Xing <zhengjun.xing@linux.intel.com>
>>
>> By default, we create two hybrid cache events, one is for cpu_core, and
>> another is for cpu_atom. But Some hybrid hardware cache events are only
>> available on one CPU PMU. For example, the 'L1-dcache-load-misses' is only
>> available on cpu_core, while the 'L1-icache-loads' is only available on
>> cpu_atom. We need to remove "not supported" hybrid cache events. By
>> extending is_event_supported() to global API and using it to check if the
>> hybrid cache events are supported before being created, we can remove the
>> "not supported" hybrid cache events.
>>
>> Before:
>>
>>   # ./perf stat -e L1-dcache-load-misses,L1-icache-loads -a sleep 1
>>
>>   Performance counter stats for 'system wide':
>>
>>              52,570      cpu_core/L1-dcache-load-misses/
>>     <not supported>      cpu_atom/L1-dcache-load-misses/
>>     <not supported>      cpu_core/L1-icache-loads/
>>           1,471,817      cpu_atom/L1-icache-loads/
>>
>>         1.004915229 seconds time elapsed
>>
>> After:
>>
>>   # ./perf stat -e L1-dcache-load-misses,L1-icache-loads -a sleep 1
>>
>>   Performance counter stats for 'system wide':
>>
>>              54,510      cpu_core/L1-dcache-load-misses/
>>           1,441,286      cpu_atom/L1-icache-loads/
>>
>>         1.005114281 seconds time elapsed
>>
>> Fixes: 30def61f64ba ("perf parse-events: Create two hybrid cache events")
>> Signed-off-by: Zhengjun Xing <zhengjun.xing@linux.intel.com>
>> Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
>> ---
>>   tools/perf/util/parse-events-hybrid.c | 8 +++++++-
>>   tools/perf/util/print-events.c        | 2 +-
>>   tools/perf/util/print-events.h        | 3 ++-
>>   3 files changed, 10 insertions(+), 3 deletions(-)
>>
>> diff --git a/tools/perf/util/parse-events-hybrid.c b/tools/perf/util/parse-events-hybrid.c
>> index 284f8eabd3b9..cf2e1c2e968f 100644
>> --- a/tools/perf/util/parse-events-hybrid.c
>> +++ b/tools/perf/util/parse-events-hybrid.c
>> @@ -14,6 +14,7 @@
>>   #include "pmu.h"
>>   #include "pmu-hybrid.h"
>>   #include "perf.h"
>> +#include "print-events.h"
>>
>>   static void config_hybrid_attr(struct perf_event_attr *attr,
>>                                 int type, int pmu_type)
>> @@ -48,13 +49,18 @@ static int create_event_hybrid(__u32 config_type, int *idx,
>>          __u64 config = attr->config;
>>
>>          config_hybrid_attr(attr, config_type, pmu->type);
>> +
>> +       if (attr->type == PERF_TYPE_HW_CACHE
>> +           && !is_event_supported(attr->type, attr->config))
>> +               goto out;
> 
> A comment to explain this would be useful.

Thanks, I will add a comment in the next version.
> 
>> +
>>          evsel = parse_events__add_event_hybrid(list, idx, attr, name, metric_id,
>>                                                 pmu, config_terms);
>>          if (evsel)
>>                  evsel->pmu_name = strdup(pmu->name);
>>          else
>>                  return -ENOMEM;
> 
> For consistency should this use the "goto" pattern now? You can also
> handle the ENOMEM case for strdup.
> 
  Yes, I will add a strdup check in the next version.
>> -
>> +out:
>>          attr->type = type;
>>          attr->config = config;
>>          return 0;
>> diff --git a/tools/perf/util/print-events.c b/tools/perf/util/print-events.c
>> index 04050d4f6db8..fa5cc94cfcfe 100644
>> --- a/tools/perf/util/print-events.c
>> +++ b/tools/perf/util/print-events.c
>> @@ -239,7 +239,7 @@ void print_sdt_events(const char *subsys_glob, const char *event_glob,
>>          strlist__delete(sdtlist);
>>   }
>>
>> -static bool is_event_supported(u8 type, u64 config)
>> +bool is_event_supported(u8 type, u64 config)
> 
> This makes me tempted to say this function should be in parse-events.c.
> 
"is_event_supported" move to parse-events.c should be better, I will do 
it in the next version.

> Thanks,
> Ian
> 
>>   {
>>          bool ret = true;
>>          int open_return;
>> diff --git a/tools/perf/util/print-events.h b/tools/perf/util/print-events.h
>> index 1da9910d83a6..ad2902fd0507 100644
>> --- a/tools/perf/util/print-events.h
>> +++ b/tools/perf/util/print-events.h
>> @@ -1,14 +1,15 @@
>>   /* SPDX-License-Identifier: GPL-2.0 */
>>   #ifndef __PERF_PRINT_EVENTS_H
>>   #define __PERF_PRINT_EVENTS_H
>> -
>>   #include <stdbool.h>
>> +#include <linux/types.h>
>>
>>   struct event_symbol;
>>
>>   void print_events(const char *event_glob, bool name_only, bool quiet_flag,
>>                    bool long_desc, bool details_flag, bool deprecated,
>>                    const char *pmu_name);
>> +bool is_event_supported(u8 type, u64 config);
>>   int print_hwcache_events(const char *event_glob, bool name_only);
>>   void print_sdt_events(const char *subsys_glob, const char *event_glob,
>>                        bool name_only);
>> --
>> 2.25.1
>>

-- 
Zhengjun Xing
