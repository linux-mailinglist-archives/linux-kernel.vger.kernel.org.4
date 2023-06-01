Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E913771965C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 11:06:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232077AbjFAJGc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 05:06:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232353AbjFAJG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 05:06:29 -0400
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67686119;
        Thu,  1 Jun 2023 02:06:21 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=renyu.zj@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0Vk4g27q_1685610375;
Received: from 30.221.149.38(mailfrom:renyu.zj@linux.alibaba.com fp:SMTPD_---0Vk4g27q_1685610375)
          by smtp.aliyun-inc.com;
          Thu, 01 Jun 2023 17:06:16 +0800
Message-ID: <0992b68a-8015-26f3-4a90-6ebde7877c8b@linux.alibaba.com>
Date:   Thu, 1 Jun 2023 17:06:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH v3 3/7] perf vendor events: Add JSON metrics for CMN
To:     Shuai Xue <xueshuai@linux.alibaba.com>,
        John Garry <john.g.garry@oracle.com>,
        Ian Rogers <irogers@google.com>, Will Deacon <will@kernel.org>,
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
 <1685438374-33287-4-git-send-email-renyu.zj@linux.alibaba.com>
 <a31c7578-93fe-193e-1c4b-fa8fa187f5dd@linux.alibaba.com>
From:   Jing Zhang <renyu.zj@linux.alibaba.com>
In-Reply-To: <a31c7578-93fe-193e-1c4b-fa8fa187f5dd@linux.alibaba.com>
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



在 2023/5/31 上午10:43, Shuai Xue 写道:
> 
> 
> On 2023/5/30 17:19, Jing Zhang wrote:
>> Add JSON metrics for arm CMN. Currently just add part of CMN PMU
>> metrics which are general and compatible for any SoC and CMN-ANY.
> 
> Is it a typo? You mean "any SoC integration with CMN-ANY" right?
> 

Yes, I will fix it in the next version.

Thanks,
Jing

> Thanks,
> Shuai
> 
>>
>> Signed-off-by: Jing Zhang <renyu.zj@linux.alibaba.com>
>> ---
>>  .../pmu-events/arch/arm64/arm/cmn/sys/metrics.json | 74 ++++++++++++++++++++++
>>  tools/perf/pmu-events/jevents.py                   |  1 +
>>  2 files changed, 75 insertions(+)
>>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cmn/sys/metrics.json
>>
>> diff --git a/tools/perf/pmu-events/arch/arm64/arm/cmn/sys/metrics.json b/tools/perf/pmu-events/arch/arm64/arm/cmn/sys/metrics.json
>> new file mode 100644
>> index 0000000..e70ac1a
>> --- /dev/null
>> +++ b/tools/perf/pmu-events/arch/arm64/arm/cmn/sys/metrics.json
>> @@ -0,0 +1,74 @@
>> +[
>> +	{
>> +		"MetricName": "slc_miss_rate",
>> +		"BriefDescription": "The system level cache miss rate include.",
>> +		"MetricGroup": "arm_cmn",
>> +		"MetricExpr": "hnf_cache_miss / hnf_slc_sf_cache_access",
>> +		"ScaleUnit": "100%",
>> +		"Unit": "arm_cmn",
>> +		"Compat": "arm_cmn600;arm_cmn650;arm_cmn700;arm_ci700"
>> +	},
>> +	{
>> +		"MetricName": "hnf_message_retry_rate",
>> +		"BriefDescription": "HN-F message retry rate indicates whether a lack of credits is causing the bottlenecks.",
>> +		"MetricGroup": "arm_cmn",
>> +		"MetricExpr": "hnf_pocq_retry / hnf_pocq_reqs_recvd",
>> +		"ScaleUnit": "100%",
>> +		"Unit": "arm_cmn",
>> +		"Compat": "arm_cmn600;arm_cmn650;arm_cmn700;arm_ci700"
>> +	},
>> +	{
>> +		"MetricName": "sf_hit_rate",
>> +		"BriefDescription": "Snoop filter hit rate can be used to measure the Snoop Filter efficiency.",
>> +		"MetricGroup": "arm_cmn",
>> +		"MetricExpr": "hnf_sf_hit / hnf_slc_sf_cache_access",
>> +		"ScaleUnit": "100%",
>> +		"Unit": "arm_cmn",
>> +		"Compat": "arm_cmn600;arm_cmn650;arm_cmn700;arm_ci700"
>> +	},
>> +	{
>> +		"MetricName": "mc_message_retry_rate",
>> +		"BriefDescription": "The memory controller request retries rate indicates whether the memory controller is the bottleneck.",
>> +		"MetricGroup": "arm_cmn",
>> +		"MetricExpr": "hnf_mc_retries / hnf_mc_reqs",
>> +		"ScaleUnit": "100%",
>> +		"Unit": "arm_cmn",
>> +		"Compat": "arm_cmn600;arm_cmn650;arm_cmn700;arm_ci700"
>> +	},
>> +	{
>> +		"MetricName": "rni_actual_read_bandwidth.all",
>> +		"BriefDescription": "This event measure the actual bandwidth(MB/sec) that RN-I bridge sends to the interconnect.",
>> +		"MetricGroup": "arm_cmn",
>> +		"MetricExpr": "rnid_rxdat_flits * 32 / 1e6 / duration_time",
>> +		"ScaleUnit": "1MB/s",
>> +		"Unit": "arm_cmn",
>> +		"Compat": "arm_cmn600;arm_cmn650;arm_cmn700;arm_ci700"
>> +	},
>> +	{
>> +		"MetricName": "rni_actual_write_bandwidth.all",
>> +		"BriefDescription": "This event measures the actual write bandwidth(MB/sec) at RN-I bridges.",
>> +		"MetricGroup": "arm_cmn",
>> +		"MetricExpr": "rnid_txdat_flits * 32 / 1e6 / duration_time",
>> +		"ScaleUnit": "1MB/s",
>> +		"Unit": "arm_cmn",
>> +		"Compat": "arm_cmn600;arm_cmn650;arm_cmn700;arm_ci700"
>> +	},
>> +	{
>> +		"MetricName": "rni_retry_rate",
>> +		"BriefDescription": "RN-I bridge retry rate indicates whether the memory controller is the bottleneck.",
>> +		"MetricGroup": "arm_cmn",
>> +		"MetricExpr": "rnid_txreq_flits_retried / rnid_txreq_flits_total",
>> +		"ScaleUnit": "100%",
>> +		"Unit": "arm_cmn",
>> +		"Compat": "arm_cmn600;arm_cmn650;arm_cmn700;arm_ci700"
>> +	},
>> +	{
>> +		"MetricName": "sbsx_actual_write_bandwidth.all",
>> +		"BriefDescription": "sbsx actual write bandwidth(MB/sec).",
>> +		"MetricGroup": "arm_cmn",
>> +		"MetricExpr": "sbsx_txdat_flitv * 32 / 1e6 / duration_time",
>> +		"ScaleUnit": "1MB/s",
>> +		"Unit": "arm_cmn",
>> +		"Compat": "arm_cmn600;arm_cmn650;arm_cmn700;arm_ci700"
>> +	}
>> +]
>> diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
>> index 2bcd07c..7cff2c6 100755
>> --- a/tools/perf/pmu-events/jevents.py
>> +++ b/tools/perf/pmu-events/jevents.py
>> @@ -256,6 +256,7 @@ class JsonEvent:
>>            'DFPMC': 'amd_df',
>>            'cpu_core': 'cpu_core',
>>            'cpu_atom': 'cpu_atom',
>> +          'arm_cmn': 'arm_cmn',
>>        }
>>        return table[unit] if unit in table else f'uncore_{unit.lower()}'
>>  
