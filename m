Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C31B26F0CA5
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 21:39:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244481AbjD0Tjh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 15:39:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343655AbjD0Tjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 15:39:35 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F0D5213A;
        Thu, 27 Apr 2023 12:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682624374; x=1714160374;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=cY4rH7P8iY/+1ilBU7ExpezMXhmPsPrS0cJpUe7NWUE=;
  b=Q0Yrdtb51qcxHgXTyGCEL13mwhdtIPa36GiQUi//5ALQwHQOR9t5Cm2W
   bm7hxwYHEEO6+PBMQh80r/VHowg5qAlTysF/uMzsMCXIb60EFbE7OEq2o
   zhATplppT65TiDBnJm64BY1rE/R2UPy8O7w4M7dcGXqJJrlnU60UDqt6t
   WqFddN7Tiv2bJUVMpz2mIZiTf4lC7HjwiyLfSBnLldFfoaaXJj0FXSCee
   xkht+i7sK/mTsBEXHsl0+HcyfGFziU62xAUkUS2wncVcN8iKKzzWI7pVw
   n43n+XLxFzAOIIlQr0WPUxZpx16FDgYWlQ8WeYyqdTT33BWBb2GIT7dVv
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="375534711"
X-IronPort-AV: E=Sophos;i="5.99,232,1677571200"; 
   d="scan'208";a="375534711"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2023 12:39:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="644821280"
X-IronPort-AV: E=Sophos;i="5.99,232,1677571200"; 
   d="scan'208";a="644821280"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga003.jf.intel.com with ESMTP; 27 Apr 2023 12:39:32 -0700
Received: from [10.209.41.222] (kliang2-mobl1.ccr.corp.intel.com [10.209.41.222])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 04AC6580377;
        Thu, 27 Apr 2023 12:39:28 -0700 (PDT)
Message-ID: <496640a2-368d-aaa1-b678-50f65df7d74c@linux.intel.com>
Date:   Thu, 27 Apr 2023 15:39:27 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v1 09/40] perf test: Use valid for PMU tests
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ahmad Yasin <ahmad.yasin@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Samantha Alt <samantha.alt@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>,
        Weilin Wang <weilin.wang@intel.com>,
        Edward Baker <edward.baker@intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        Rob Herring <robh@kernel.org>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        John Garry <john.g.garry@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Leo Yan <leo.yan@linaro.org>,
        Yang Jihong <yangjihong1@huawei.com>,
        James Clark <james.clark@arm.com>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        Kang Minchul <tegongkang@gmail.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230426070050.1315519-1-irogers@google.com>
 <20230426070050.1315519-10-irogers@google.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20230426070050.1315519-10-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-04-26 3:00 a.m., Ian Rogers wrote:
> Rather than skip all tests in test__events_pmu if PMU cpu isn't
> present, use the per-test valid test. This allows the running of
> software PMU tests on hybrid and arm systems.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>

Run the test on Cascade Lake and Alder Lake. It looks good.

Tested-by: Kan Liang <kan.liang@linux.intel.com>

Thanks,
Kan

> ---
>  tools/perf/tests/parse-events.c | 27 +++++++++------------------
>  1 file changed, 9 insertions(+), 18 deletions(-)
> 
> diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
> index 385bbbc4a409..08d6b8a3015d 100644
> --- a/tools/perf/tests/parse-events.c
> +++ b/tools/perf/tests/parse-events.c
> @@ -1430,6 +1430,11 @@ static int test__checkevent_config_cache(struct evlist *evlist)
>  	return TEST_OK;
>  }
>  
> +static bool test__pmu_cpu_valid(void)
> +{
> +	return !!perf_pmu__find("cpu");
> +}
> +
>  static bool test__intel_pt_valid(void)
>  {
>  	return !!perf_pmu__find("intel_pt");
> @@ -1979,21 +1984,25 @@ static const struct evlist_test test__events[] = {
>  static const struct evlist_test test__events_pmu[] = {
>  	{
>  		.name  = "cpu/config=10,config1,config2=3,period=1000/u",
> +		.valid = test__pmu_cpu_valid,
>  		.check = test__checkevent_pmu,
>  		/* 0 */
>  	},
>  	{
>  		.name  = "cpu/config=1,name=krava/u,cpu/config=2/u",
> +		.valid = test__pmu_cpu_valid,
>  		.check = test__checkevent_pmu_name,
>  		/* 1 */
>  	},
>  	{
>  		.name  = "cpu/config=1,call-graph=fp,time,period=100000/,cpu/config=2,call-graph=no,time=0,period=2000/",
> +		.valid = test__pmu_cpu_valid,
>  		.check = test__checkevent_pmu_partial_time_callgraph,
>  		/* 2 */
>  	},
>  	{
>  		.name  = "cpu/name='COMPLEX_CYCLES_NAME:orig=cycles,desc=chip-clock-ticks',period=0x1,event=0x2/ukp",
> +		.valid = test__pmu_cpu_valid,
>  		.check = test__checkevent_complex_name,
>  		/* 3 */
>  	},
> @@ -2209,21 +2218,6 @@ static int test__terms2(struct test_suite *test __maybe_unused, int subtest __ma
>  	return test_terms(test__terms, ARRAY_SIZE(test__terms));
>  }
>  
> -static int test_pmu(void)
> -{
> -	struct stat st;
> -	char path[PATH_MAX];
> -	int ret;
> -
> -	snprintf(path, PATH_MAX, "%s/bus/event_source/devices/cpu/format/",
> -		 sysfs__mountpoint());
> -
> -	ret = stat(path, &st);
> -	if (ret)
> -		pr_debug("omitting PMU cpu tests\n");
> -	return !ret;
> -}
> -
>  static int test__pmu_events(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
>  {
>  	struct perf_pmu *pmu;
> @@ -2305,9 +2299,6 @@ static int test__pmu_events(struct test_suite *test __maybe_unused, int subtest
>  
>  static int test__pmu_events2(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
>  {
> -	if (!test_pmu())
> -		return TEST_SKIP;
> -
>  	return test_events(test__events_pmu, ARRAY_SIZE(test__events_pmu));
>  }
>  
