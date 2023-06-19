Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3087D734EEA
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 11:00:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbjFSI7i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 04:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbjFSI7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 04:59:20 -0400
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E42D83;
        Mon, 19 Jun 2023 01:59:17 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=renyu.zj@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0VlTKQLc_1687165151;
Received: from 30.221.149.0(mailfrom:renyu.zj@linux.alibaba.com fp:SMTPD_---0VlTKQLc_1687165151)
          by smtp.aliyun-inc.com;
          Mon, 19 Jun 2023 16:59:12 +0800
Message-ID: <a6e1114c-b37c-6999-0668-039aa495db84@linux.alibaba.com>
Date:   Mon, 19 Jun 2023 16:59:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH v3 2/7] perf metric: Event "Compat" value supports
 matching multiple identifiers
To:     John Garry <john.g.garry@oracle.com>,
        Ian Rogers <irogers@google.com>, Will Deacon <will@kernel.org>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ilkka Koskinen <ilkka@os.amperecomputing.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org,
        Zhuo Song <zhuo.song@linux.alibaba.com>
References: <1685438374-33287-1-git-send-email-renyu.zj@linux.alibaba.com>
 <1685438374-33287-3-git-send-email-renyu.zj@linux.alibaba.com>
 <c1d8ee9b-4839-1011-4dad-c4777d8f8224@oracle.com>
 <452e724b-2a2c-52fd-274b-60db7a7f730e@linux.alibaba.com>
 <c4b2fca8-602d-9c76-90a7-3eafd92da8bc@oracle.com>
 <76fcb062-61a8-5f90-b39d-b5fb6da35652@linux.alibaba.com>
 <5f38ef6c-8c50-5df9-19dd-c3c9fe590452@oracle.com>
 <e4be7189-a1ba-7758-bff3-e7b8d8ff1419@linux.alibaba.com>
 <892f57c7-8ce2-634c-26f3-4d4ab8b2f2ce@oracle.com>
 <079d7920-2030-2e00-a833-5ec6d450f7dc@oracle.com>
 <552eebae-76bb-a2fe-ccdc-11e8a01717da@linux.alibaba.com>
 <045a49c9-b9ae-bf0e-c4be-858d905bcc55@oracle.com>
 <7c765e0f-ca76-d212-0496-f9c56369e389@linux.alibaba.com>
 <d1ab4947-6bdf-2b9c-5b26-52c572611ca6@oracle.com>
From:   Jing Zhang <renyu.zj@linux.alibaba.com>
In-Reply-To: <d1ab4947-6bdf-2b9c-5b26-52c572611ca6@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/6/19 下午3:07, John Garry 写道:
> On 19/06/2023 03:58, Jing Zhang wrote:
>>> +++ b/tools/perf/pmu-events/arch/arm64/arm/cmn/sys/metrics.json
>>> @@ -0,0 +1,74 @@
>>> +[
>>> +    {
>>> +        "MetricName": "slc_miss_rate",
>>> +        "BriefDescription": "The system level cache miss rate include.",
>>> +        "MetricGroup": "arm_cmn",
>>> +        "MetricExpr": "hnf_cache_miss / hnf_slc_sf_cache_access",
>>>
>>> So this expression uses event aliases hnf_cache_miss and hnf_slc_sf_cache_access - where are they defined in a JSON?
>>>
>> Hi John,
>>
>> I defined the aliases for these events in the JSON file during the RFC version. However, I later removed the alias
>> definitions for these events in subsequent versions due to the possibility of non-uniqueness and difficulty in defining
>> their EventCode. But this does not affect their usage in metrics. In other words, metrics can use the aliases without
>> defining event aliases in the JSON file.
> 
> Really? So how can we resolve the event aliases when we try to run the metric?
> 
> Please verify running these metrics with 'perf stat', like 'perf stat -v -M slc_miss_rate'
> 

Ok, it shows:
#./perf stat -v -M slc_miss_rate sleep 1

metric expr hnf_cache_miss / hnf_slc_sf_cache_access for slc_miss_rate
found event duration_time
found event hnf_slc_sf_cache_access
found event hnf_cache_miss
Parsing metric events '{hnf_slc_sf_cache_access/metric-id=hnf_slc_sf_cache_access/,hnf_cache_miss/metric-id=hnf_cache_miss/}:W,duration_time'
hnf_slc_sf_cache_access -> arm_cmn_0/type=0x5,eventid=0x2/
hnf_slc_sf_cache_access -> arm_cmn_1/type=0x5,eventid=0x2/
hnf_cache_miss -> arm_cmn_0/type=0x5,eventid=0x1/
hnf_cache_miss -> arm_cmn_1/type=0x5,eventid=0x1/
Control descriptor is not initialized
hnf_slc_sf_cache_access: 127615 1001344900 1001344900
hnf_cache_miss: 36829 1001344900 1001344900
hnf_slc_sf_cache_access: 131526 1001343540 1001343540
hnf_cache_miss: 40587 1001343540 1001343540
duration_time: 1001381687 1001381687 1001381687

 Performance counter stats for 'system wide':

           259,141      hnf_slc_sf_cache_access   #     29.9 %  slc_miss_rate
            77,416      hnf_cache_miss
     1,001,381,687 ns   duration_time

       1.001381687 seconds time elapsed



#./perf list
...
 arm_cmn_0/hnf_cache_miss/                          [Kernel PMU event]
 arm_cmn_0/hnf_slc_sf_cache_access/                 [Kernel PMU event]
...
 arm_cmn_1/hnf_cache_miss/                          [Kernel PMU event]
 arm_cmn_1/hnf_slc_sf_cache_access/                 [Kernel PMU event]
...

>>
>> In the past, I always thought that the function of the alias was to explain the meaning of these events in the perf list.
>> Or maybe I'm missing something?
> 
> Event aliases do give the ability to describe the event in perf list. But we can also run them for 'perf stat', like:
> 
> ./perf list uncore
> List of pre-defined events (to be used in -e or -M):
> 
>   uncore_cbox_0/clockticks/                          [Kernel PMU event]
>   uncore_cbox_1/clockticks/                          [Kernel PMU event]
>   uncore_imc/data_reads/                             [Kernel PMU event]
>   uncore_imc/data_writes/                            [Kernel PMU event]
>   uncore_imc/gt_requests/                            [Kernel PMU event]
>   uncore_imc/ia_requests/                            [Kernel PMU event]
>   uncore_imc/io_requests/                            [Kernel PMU event]
> 
> uncore cache:
>   unc_cbo_cache_lookup.any_es
>        [L3 Lookup any request that access cache and found line in E or S-state. Unit: uncore_cbox]
> ...
> 
> sudo ./perf stat -v -e unc_cbo_cache_lookup.any_es
> Using CPUID GenuineIntel-6-3D-4
> unc_cbo_cache_lookup.any_es -> uncore_cbox_0/event=0x34,umask=0x86/
> unc_cbo_cache_lookup.any_es -> uncore_cbox_1/event=0x34,umask=0x86/
> Control descriptor is not initialized
> ^Cunc_cbo_cache_lookup.any_es: 14361103 1853372468 1853372468
> unc_cbo_cache_lookup.any_es: 14322188 1853360415 1853360415
> 
>  Performance counter stats for 'system wide':
> 
>         14,361,103      unc_cbo_cache_lookup.any_es
>         14,322,188      unc_cbo_cache_lookup.any_es
> 
>        1.853388227 seconds time elapsed
> 

Ok, thanks. If I use events without a prefix, such as perf stat -e clockticks sleep 1, will this also work?

Thanks,
Jing


> 
> Thanks,
> John
