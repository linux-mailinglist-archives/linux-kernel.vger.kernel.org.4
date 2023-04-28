Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 625116F1A13
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 15:58:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346330AbjD1N6D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 09:58:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345489AbjD1N6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 09:58:00 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB4091735;
        Fri, 28 Apr 2023 06:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682690278; x=1714226278;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=2cFTGUgH6DYAueSg1ZpME3M2eE79DKcm9o+rk82ncp4=;
  b=ad+U27Qsh2JKJtAsybVT3n5VIdm5Hw37z59f65GBjalPXarOgJUg23ne
   zH+VVDCGK+kiwaeRm60xC32fHYJXvmKNPs1Rv1IlDIriiFzf5IxX5cUUS
   7Pfbuy5hUfwuIT7mIdB+gEc/uGwsoI6t4M3SjNw+IHA3fQ55Dy6hBS0LQ
   L3hpRjFYowTktrUVtiuFVm3uX0sEZBP/jCJS25r662aUtb07eodKjolUd
   Lc9q6lZ3GgOQ8tKav4QPA0yFFlgR4FYhhwT1GJSWWKKui/PkvsUkPUIQg
   JhYAiIvmQD5S1uxOgnKhybeRRmg/OdUUaVh4QdJZ4gfgUW3L+VVT3FAq7
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10694"; a="413142410"
X-IronPort-AV: E=Sophos;i="5.99,234,1677571200"; 
   d="scan'208";a="413142410"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2023 06:57:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10694"; a="727542613"
X-IronPort-AV: E=Sophos;i="5.99,234,1677571200"; 
   d="scan'208";a="727542613"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga001.jf.intel.com with ESMTP; 28 Apr 2023 06:57:56 -0700
Received: from [10.212.155.101] (kliang2-mobl1.ccr.corp.intel.com [10.212.155.101])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id AA177580C99;
        Fri, 28 Apr 2023 06:57:53 -0700 (PDT)
Message-ID: <2ab4e5b6-25ee-5eb4-5e06-5194c67369b5@linux.intel.com>
Date:   Fri, 28 Apr 2023 09:57:52 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 21/43] perf test x86 hybrid: Update test expectations
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
References: <20230428073809.1803624-1-irogers@google.com>
 <20230428073809.1803624-22-irogers@google.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20230428073809.1803624-22-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-04-28 3:37 a.m., Ian Rogers wrote:
> Don't assume evlist order. Switch to a loop rather than depend on
> evlist order for raw events test.
> 
> Update hybrid event expectations. Previous values were based on
> parsing legacy hardware events from sysfs, update to the correct PMU
> specific legacy values.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/arch/x86/tests/hybrid.c | 54 ++++++++++++++----------------
>  1 file changed, 26 insertions(+), 28 deletions(-)
> 
> diff --git a/tools/perf/arch/x86/tests/hybrid.c b/tools/perf/arch/x86/tests/hybrid.c
> index 0f99cfd116ee..d2a173ba3db9 100644
> --- a/tools/perf/arch/x86/tests/hybrid.c
> +++ b/tools/perf/arch/x86/tests/hybrid.c
> @@ -11,13 +11,18 @@ static bool test_config(const struct evsel *evsel, __u64 expected_config)
>  	return (evsel->core.attr.config & PERF_HW_EVENT_MASK) == expected_config;
>  }
>  
> +static bool test_perf_config(const struct perf_evsel *evsel, __u64 expected_config)
> +{
> +	return (evsel->attr.config & PERF_HW_EVENT_MASK) == expected_config;
> +}
> +
>  static int test__hybrid_hw_event_with_pmu(struct evlist *evlist)
>  {
>  	struct evsel *evsel = evlist__first(evlist);
>  
>  	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->core.nr_entries);
> -	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type);
> -	TEST_ASSERT_VAL("wrong config", test_config(evsel, 0x3c));
> +	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
> +	TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_CPU_CYCLES));

Can you please add the "hybrid type" check as well?

https://lore.kernel.org/lkml/4fbbe5bf-2f7d-8aa3-62b1-72829f75e009@linux.intel.com/

It's part of the attr.config layout design. We should test it as well.

Thanks,
Kan

>  	return TEST_OK;
>  }
>  
> @@ -27,13 +32,13 @@ static int test__hybrid_hw_group_event(struct evlist *evlist)
>  
>  	evsel = leader = evlist__first(evlist);
>  	TEST_ASSERT_VAL("wrong number of entries", 2 == evlist->core.nr_entries);
> -	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type);
> -	TEST_ASSERT_VAL("wrong config", test_config(evsel, 0x3c));
> +	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
> +	TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_CPU_CYCLES));
>  	TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
>  
>  	evsel = evsel__next(evsel);
> -	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type);
> -	TEST_ASSERT_VAL("wrong config", test_config(evsel, 0xc0));
> +	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
> +	TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_INSTRUCTIONS));
>  	TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
>  	return TEST_OK;
>  }
> @@ -48,8 +53,8 @@ static int test__hybrid_sw_hw_group_event(struct evlist *evlist)
>  	TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
>  
>  	evsel = evsel__next(evsel);
> -	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type);
> -	TEST_ASSERT_VAL("wrong config", test_config(evsel, 0x3c));
> +	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
> +	TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_CPU_CYCLES));
>  	TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
>  	return TEST_OK;
>  }
> @@ -60,8 +65,8 @@ static int test__hybrid_hw_sw_group_event(struct evlist *evlist)
>  
>  	evsel = leader = evlist__first(evlist);
>  	TEST_ASSERT_VAL("wrong number of entries", 2 == evlist->core.nr_entries);
> -	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type);
> -	TEST_ASSERT_VAL("wrong config", test_config(evsel, 0x3c));
> +	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
> +	TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_CPU_CYCLES));
>  	TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
>  
>  	evsel = evsel__next(evsel);
> @@ -76,15 +81,15 @@ static int test__hybrid_group_modifier1(struct evlist *evlist)
>  
>  	evsel = leader = evlist__first(evlist);
>  	TEST_ASSERT_VAL("wrong number of entries", 2 == evlist->core.nr_entries);
> -	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type);
> -	TEST_ASSERT_VAL("wrong config", test_config(evsel, 0x3c));
> +	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
> +	TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_CPU_CYCLES));
>  	TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
>  	TEST_ASSERT_VAL("wrong exclude_user", evsel->core.attr.exclude_user);
>  	TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
>  
>  	evsel = evsel__next(evsel);
> -	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type);
> -	TEST_ASSERT_VAL("wrong config", test_config(evsel, 0xc0));
> +	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
> +	TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_INSTRUCTIONS));
>  	TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
>  	TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
>  	TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
> @@ -93,22 +98,15 @@ static int test__hybrid_group_modifier1(struct evlist *evlist)
>  
>  static int test__hybrid_raw1(struct evlist *evlist)
>  {
> -	struct evsel *evsel = evlist__first(evlist);
> +	struct perf_evsel *evsel;
>  
> -	if (!perf_pmu__hybrid_mounted("cpu_atom")) {
> -		TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->core.nr_entries);
> -		TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type);
> -		TEST_ASSERT_VAL("wrong config", test_config(evsel, 0x1a));
> -		return TEST_OK;
> -	}
> -
> -	TEST_ASSERT_VAL("wrong number of entries", 2 == evlist->core.nr_entries);
> -	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type);
> -	TEST_ASSERT_VAL("wrong config", test_config(evsel, 0x1a));
> +	perf_evlist__for_each_evsel(&evlist->core, evsel) {
> +		struct perf_pmu *pmu = perf_pmu__find_by_type(evsel->attr.type);
>  
> -	/* The type of second event is randome value */
> -	evsel = evsel__next(evsel);
> -	TEST_ASSERT_VAL("wrong config", test_config(evsel, 0x1a));
> +		TEST_ASSERT_VAL("missing pmu", pmu);
> +		TEST_ASSERT_VAL("unexpected pmu", !strncmp(pmu->name, "cpu_", 4));
> +		TEST_ASSERT_VAL("wrong config", test_perf_config(evsel, 0x1a));
> +	}
>  	return TEST_OK;
>  }
>  
