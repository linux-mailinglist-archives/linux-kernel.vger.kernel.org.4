Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 929447088A9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 21:52:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbjERTwt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 15:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbjERTwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 15:52:47 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6691010CF;
        Thu, 18 May 2023 12:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684439558; x=1715975558;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=awidV1hAwhtRlrQDgteR/yLzOz+GTTX7ZKKH/eNibOs=;
  b=l1jWARrita2tdMm9kO2Kh92g5+YTZCKDxQIeVZhT48AQp1YG9hwd4vwC
   UkYOVDWNZM1Z+970FBYb5LqzRwdMLCngpqLJenHpSBt0C0s1tsBePSd9B
   Xpeiq1dPYbyTReYXgkaal5YT612ACMsFxmm2SUMD2/BFFjHUvmc3GVhCC
   TONufl8TxWiW1qvQMs30YEtbkh/wyCST3m56h6iyyKathy+DQJ6HykeZV
   G/QNZCn5RAeTpmXo2nuZgXMUSvInxs7RJTdXq2HAUuYiNRUDGxTM52cu9
   9bWB0ETDmh0aYgYw48m54veEXTzoNyC1NBNo6P5mcwHkhL7Mq5pq41Zil
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="417861377"
X-IronPort-AV: E=Sophos;i="6.00,175,1681196400"; 
   d="scan'208";a="417861377"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2023 12:52:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="705316585"
X-IronPort-AV: E=Sophos;i="6.00,175,1681196400"; 
   d="scan'208";a="705316585"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga007.fm.intel.com with ESMTP; 18 May 2023 12:52:37 -0700
Received: from [10.209.99.208] (kliang2-mobl1.ccr.corp.intel.com [10.209.99.208])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 68CD6580B56;
        Thu, 18 May 2023 12:52:35 -0700 (PDT)
Message-ID: <37d2219f-68e5-ea8c-e04b-2c17fa991570@linux.intel.com>
Date:   Thu, 18 May 2023 15:52:34 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v1 2/2] perf stat: Document --metric-no-threshold and
 threshold colors
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        James Clark <james.clark@arm.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Eduard Zingerman <eddyz87@gmail.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ahmad Yasin <ahmad.yasin@intel.com>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Samantha Alt <samantha.alt@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>,
        Weilin Wang <weilin.wang@intel.com>,
        Edward Baker <edward.baker@intel.com>
References: <20230504195803.3331775-1-irogers@google.com>
 <20230504195803.3331775-2-irogers@google.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20230504195803.3331775-2-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-05-04 3:58 p.m., Ian Rogers wrote:
> Document the threshold behavior for -M/--metrics.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/Documentation/perf-stat.txt | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Documentation/perf-stat.txt
> index 29bdcfa93f04..ff71399db738 100644
> --- a/tools/perf/Documentation/perf-stat.txt
> +++ b/tools/perf/Documentation/perf-stat.txt
> @@ -353,6 +353,15 @@ small group that need not have multiplexing is lowered. This option
>  forbids the event merging logic from sharing events between groups and
>  may be used to increase accuracy in this case.
>  
> +--metric-no-threshold::
> +Metric thresholds may increase the number of events necessary to
> +compute whether a metric has exceeded its threshold expression. This
> +may not be desirable, for example, as the events can introduce
> +multiplexing. This option disables the adding of threshold expression
> +events for a metric. However, if there are sufficient events to
> +compute the threshold then the threshold is still computed and used to
> +color the metric's computed value.
> +
>  --quiet::
>  Don't print output, warnings or messages. This is useful with perf stat
>  record below to only write data to the perf.data file.
> @@ -389,6 +398,12 @@ For a group all metrics from the group are added.
>  The events from the metrics are automatically measured.
>  See perf list output for the possible metrics and metricgroups.
>  
> +	When threshold information is available for a metric, the
> +	color red is used to signify a metric has exceeded a threshold
> +	while green shows it is hasn't. The default color means that

A typo. "it is hasn't" -> "it hasn't"

Rest looks good to me.

Reviewed-by: Kan Liang <kan.liang@linux.intel.com>

Thanks,
Kan

> +	no threshold information was available or the threshold
> +	couldn't be computed.
> +
>  -A::
>  --no-aggr::
>  Do not aggregate counts across all monitored CPUs.
