Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D9936FAE1B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 13:41:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236199AbjEHLl0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 07:41:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236088AbjEHLlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 07:41:00 -0400
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A14024031C;
        Mon,  8 May 2023 04:40:36 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R311e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=renyu.zj@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0Vi5DXX._1683546030;
Received: from 30.221.149.87(mailfrom:renyu.zj@linux.alibaba.com fp:SMTPD_---0Vi5DXX._1683546030)
          by smtp.aliyun-inc.com;
          Mon, 08 May 2023 19:40:32 +0800
Message-ID: <5a90f26d-980f-794e-c620-09d50dd9e310@linux.alibaba.com>
Date:   Mon, 8 May 2023 19:40:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH v2 5/5] perf vendor events: Add JSON metrics for Yitian
 710 DDR
To:     Shuai Xue <xueshuai@linux.alibaba.com>,
        John Garry <john.g.garry@oracle.com>,
        Ian Rogers <irogers@google.com>, Will Deacon <will@kernel.org>
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
References: <1682329456-19418-1-git-send-email-renyu.zj@linux.alibaba.com>
 <1682329456-19418-6-git-send-email-renyu.zj@linux.alibaba.com>
 <bf593f0f-5c62-f36a-a5d2-f6376f3babda@linux.alibaba.com>
From:   Jing Zhang <renyu.zj@linux.alibaba.com>
In-Reply-To: <bf593f0f-5c62-f36a-a5d2-f6376f3babda@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-11.7 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/5/4 下午3:31, Shuai Xue 写道:
> 
> 
> On 2023/4/24 17:44, Jing Zhang wrote:
>> Add JSON metrics for T-HEAD Yitian 710 SoC DDR.
>>
>> Signed-off-by: Jing Zhang <renyu.zj@linux.alibaba.com>
> 
> 
> Could you also update the Documentation/admin-guide/perf/alibaba_pmu.rst
> with some example of how to use these metrics?
> 

Yes，will do.

Thanks,
Jing


> Best Regards,
> Shuai
> 
> 
>> ---
>>  .../arch/arm64/freescale/yitian710/sys/metrics.json  | 20 ++++++++++++++++++++
>>  1 file changed, 20 insertions(+)
>>  create mode 100644 tools/perf/pmu-events/arch/arm64/freescale/yitian710/sys/metrics.json
>>
>> diff --git a/tools/perf/pmu-events/arch/arm64/freescale/yitian710/sys/metrics.json b/tools/perf/pmu-events/arch/arm64/freescale/yitian710/sys/metrics.json
>> new file mode 100644
>> index 0000000..1a92477
>> --- /dev/null
>> +++ b/tools/perf/pmu-events/arch/arm64/freescale/yitian710/sys/metrics.json
>> @@ -0,0 +1,20 @@
>> +[
>> +	{
>> +		"MetricName": "ddr_read_bandwidth.all",
>> +		"BriefDescription": "The ddr read bandwidth(MB/s).",
>> +		"MetricGroup": "ddr",
>> +		"MetricExpr": "hif_rd * 64 / 1e6 / duration_time",
>> +		"ScaleUnit": "1MB/s",
>> +		"Unit": "ali_drw",
>> +		"Compat": "ali_drw_pmu"
>> +	},
>> +	{
>> +		"MetricName": "ddr_write_bandwidth.all",
>> +		"BriefDescription": "The ddr write bandwidth(MB/s).",
>> +		"MetricGroup": "ddr",
>> +		"MetricExpr": "(hif_wr + hif_rmw) * 64 / 1e6 / duration_time",
>> +		"ScaleUnit": "1MB/s",
>> +		"Unit": "ali_drw",
>> +		"Compat": "ali_drw_pmu"
>> +	}
>> +]
