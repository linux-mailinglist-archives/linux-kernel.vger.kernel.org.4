Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D66E464DF94
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 18:23:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbiLORXW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 12:23:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbiLORXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 12:23:20 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCB8CBC3A;
        Thu, 15 Dec 2022 09:23:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671124998; x=1702660998;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=QKznmQkXpxZFBwp8kBMesbPOYGClC409WYrkqo3GF1o=;
  b=Nx9rwXioqfWEp6112T122tZt4qscb+rk/E2HQwP42SdxnJf2OzuB12/b
   G8SzAdnsAVbT6TNOFgn1pu8Ockh7Ht+pogk8pGdo1KXlhuXP22HZSlgEb
   iyzS/0B+RHyhDAz0Z1POsQ/ucc7bfuZg60qM94jFZCwfNnDjd7RkdBK6e
   fU4jxWyOvV3CVpsjfRgA0r6U5uTQKQVEcKvJTUAtEZTj2eOcmKbIz97n5
   IfbE1/rO35uD4SC3XY5ZyfSyLN3TYrOAuT+nZ2BfSIcA9xOABRpRHjSIt
   SBCdjpl7PB9UaXtSLEYgSG/ApCAAfOx3HMlretEYGajwSSOVdU/FbITuE
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10562"; a="299088215"
X-IronPort-AV: E=Sophos;i="5.96,248,1665471600"; 
   d="scan'208";a="299088215"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2022 09:23:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10562"; a="642983907"
X-IronPort-AV: E=Sophos;i="5.96,248,1665471600"; 
   d="scan'208";a="642983907"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga007.jf.intel.com with ESMTP; 15 Dec 2022 09:23:17 -0800
Received: from [10.252.210.143] (kliang2-mobl1.ccr.corp.intel.com [10.252.210.143])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id B1D13580DAB;
        Thu, 15 Dec 2022 09:23:15 -0800 (PST)
Message-ID: <bbbe8cb7-bc12-537f-0977-e96ab7cf3cfa@linux.intel.com>
Date:   Thu, 15 Dec 2022 12:23:14 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v1 00/32] Refresh Intel vendor events
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
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     John Garry <john.g.garry@oracle.com>,
        Stephane Eranian <eranian@google.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>
References: <20221215064755.1620246-1-irogers@google.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20221215064755.1620246-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022-12-15 1:47 a.m., Ian Rogers wrote:
> Use new repository [1] and converter script to regenerate Intel vendor
> metrics. In particular this change removes unnecessary json fields and
> correct uncore events that previously had a buggy converter.
> 

Thanks Ian.

The patch series looks good to me.

Acked-by: Kan Liang <kan.liang@linux.intel.com>

Thanks,
Kan

> [1] https://github.com/intel/perfmon/
> 
> Ian Rogers (32):
>   perf test pmu-events: Fake PMU metric workaround
>   perf vendor events intel: Refresh alderlake metrics
>   perf vendor events intel: Refresh alderlake-n metrics
>   perf vendor events intel: Refresh bonnell events
>   perf vendor events intel: Refresh broadwell metrics and events
>   perf vendor events intel: Refresh broadwellde metrics and events
>   perf vendor events intel: Refresh broadwellx metrics and events
>   perf vendor events intel: Refresh cascadelakex metrics and events
>   perf vendor events intel: Refresh elkhartlake events
>   perf vendor events intel: Refresh goldmont events
>   perf vendor events intel: Refresh goldmontplus events
>   perf vendor events intel: Refresh haswell metrics and events
>   perf vendor events intel: Refresh haswellx metrics and events
>   perf vendor events intel: Refresh icelake metrics and events
>   perf vendor events intel: Refresh icelakex metrics and events
>   perf vendor events intel: Refresh ivybridge metrics and events
>   perf vendor events intel: Refresh ivytown metrics and events
>   perf vendor events intel: Refresh jaketown metrics and events
>   perf vendor events intel: Refresh knightslanding events
>   perf vendor events intel: Refresh meteorlake events
>   perf vendor events intel: Refresh nehalemep events
>   perf vendor events intel: Refresh nehalemex events
>   perf vendor events intel: Refresh sandybridge metrics and events
>   perf vendor events intel: Refresh sapphirerapids metrics and events
>   perf vendor events intel: Refresh silvermont events
>   perf vendor events intel: Refresh skylake metrics and events
>   perf vendor events intel: Refresh skylakex metrics and events
>   perf vendor events intel: Refresh snowridgex events
>   perf vendor events intel: Refresh tigerlake metrics and events
>   perf vendor events intel: Refresh westmereep-dp events
>   perf vendor events intel: Refresh westmereep-sp events
>   perf vendor events intel: Refresh westmereex events
> 
>  .../arch/x86/alderlake/adl-metrics.json       |   116 +-
>  .../arch/x86/alderlaken/adln-metrics.json     |    22 +-
>  .../pmu-events/arch/x86/bonnell/cache.json    |    93 -
>  .../arch/x86/bonnell/floating-point.json      |    47 +-
>  .../pmu-events/arch/x86/bonnell/frontend.json |    11 -
>  .../pmu-events/arch/x86/bonnell/memory.json   |    19 -
>  .../pmu-events/arch/x86/bonnell/other.json    |    74 +-
>  .../pmu-events/arch/x86/bonnell/pipeline.json |    65 +-
>  .../arch/x86/bonnell/virtual-memory.json      |    15 -
>  .../arch/x86/broadwell/bdw-metrics.json       |   137 +-
>  .../pmu-events/arch/x86/broadwell/cache.json  |   957 -
>  .../arch/x86/broadwell/floating-point.json    |    40 -
>  .../arch/x86/broadwell/frontend.json          |    56 -
>  .../pmu-events/arch/x86/broadwell/memory.json |   890 -
>  .../pmu-events/arch/x86/broadwell/other.json  |     8 -
>  .../arch/x86/broadwell/pipeline.json          |   272 -
>  .../arch/x86/broadwell/uncore-cache.json      |    19 -
>  .../arch/x86/broadwell/uncore-other.json      |    25 +-
>  .../arch/x86/broadwell/virtual-memory.json    |    76 -
>  .../arch/x86/broadwellde/bdwde-metrics.json   |   143 +-
>  .../arch/x86/broadwellde/cache.json           |   153 -
>  .../arch/x86/broadwellde/floating-point.json  |    40 -
>  .../arch/x86/broadwellde/frontend.json        |    56 -
>  .../arch/x86/broadwellde/memory.json          |    86 -
>  .../arch/x86/broadwellde/other.json           |     8 -
>  .../arch/x86/broadwellde/pipeline.json        |   272 -
>  .../arch/x86/broadwellde/uncore-cache.json    |   414 +-
>  .../arch/x86/broadwellde/uncore-memory.json   |   477 +-
>  .../arch/x86/broadwellde/uncore-other.json    |   163 +-
>  .../arch/x86/broadwellde/uncore-power.json    |    57 -
>  .../arch/x86/broadwellde/virtual-memory.json  |    76 -
>  .../arch/x86/broadwellx/bdx-metrics.json      |  1703 +-
>  .../pmu-events/arch/x86/broadwellx/cache.json |   191 -
>  .../arch/x86/broadwellx/floating-point.json   |    40 -
>  .../arch/x86/broadwellx/frontend.json         |    56 -
>  .../arch/x86/broadwellx/memory.json           |   143 -
>  .../pmu-events/arch/x86/broadwellx/other.json |     8 -
>  .../arch/x86/broadwellx/pipeline.json         |   272 -
>  .../arch/x86/broadwellx/uncore-cache.json     |  3740 +-
>  .../x86/broadwellx/uncore-interconnect.json   |  1225 +-
>  .../arch/x86/broadwellx/uncore-memory.json    |  2052 +-
>  .../arch/x86/broadwellx/uncore-other.json     |  2410 +-
>  .../arch/x86/broadwellx/uncore-power.json     |   198 +-
>  .../arch/x86/broadwellx/virtual-memory.json   |    76 -
>  .../arch/x86/cascadelakex/cache.json          |  3644 --
>  .../arch/x86/cascadelakex/clx-metrics.json    |  2217 +-
>  .../arch/x86/cascadelakex/floating-point.json |    24 -
>  .../arch/x86/cascadelakex/frontend.json       |   109 -
>  .../arch/x86/cascadelakex/memory.json         |  2194 -
>  .../arch/x86/cascadelakex/other.json          |   490 -
>  .../arch/x86/cascadelakex/pipeline.json       |   194 -
>  .../arch/x86/cascadelakex/uncore-memory.json  |  3185 +-
>  .../arch/x86/cascadelakex/uncore-other.json   | 29444 +++++-----
>  .../arch/x86/cascadelakex/uncore-power.json   |    45 +-
>  .../arch/x86/cascadelakex/virtual-memory.json |    56 -
>  .../arch/x86/elkhartlake/cache.json           |   252 -
>  .../arch/x86/elkhartlake/floating-point.json  |    11 -
>  .../arch/x86/elkhartlake/frontend.json        |    36 -
>  .../arch/x86/elkhartlake/memory.json          |    84 -
>  .../arch/x86/elkhartlake/other.json           |   143 -
>  .../arch/x86/elkhartlake/pipeline.json        |   213 -
>  .../arch/x86/elkhartlake/virtual-memory.json  |   117 -
>  .../pmu-events/arch/x86/goldmont/cache.json   |   288 -
>  .../arch/x86/goldmont/floating-point.json     |     6 -
>  .../arch/x86/goldmont/frontend.json           |    16 -
>  .../pmu-events/arch/x86/goldmont/memory.json  |     6 -
>  .../pmu-events/arch/x86/goldmont/other.json   |    10 -
>  .../arch/x86/goldmont/pipeline.json           |    77 -
>  .../arch/x86/goldmont/virtual-memory.json     |    14 -
>  .../arch/x86/goldmontplus/cache.json          |   470 -
>  .../arch/x86/goldmontplus/floating-point.json |    11 -
>  .../arch/x86/goldmontplus/frontend.json       |    32 -
>  .../arch/x86/goldmontplus/memory.json         |    10 -
>  .../arch/x86/goldmontplus/other.json          |    20 -
>  .../arch/x86/goldmontplus/pipeline.json       |   143 -
>  .../arch/x86/goldmontplus/virtual-memory.json |    69 -
>  .../pmu-events/arch/x86/haswell/cache.json    |   211 -
>  .../arch/x86/haswell/floating-point.json      |    20 -
>  .../pmu-events/arch/x86/haswell/frontend.json |    58 -
>  .../arch/x86/haswell/hsw-metrics.json         |   117 +-
>  .../pmu-events/arch/x86/haswell/memory.json   |   149 -
>  .../pmu-events/arch/x86/haswell/other.json    |     8 -
>  .../pmu-events/arch/x86/haswell/pipeline.json |   258 -
>  .../arch/x86/haswell/uncore-cache.json        |    50 -
>  .../arch/x86/haswell/uncore-other.json        |    21 +-
>  .../arch/x86/haswell/virtual-memory.json      |    98 -
>  .../pmu-events/arch/x86/haswellx/cache.json   |   217 -
>  .../arch/x86/haswellx/floating-point.json     |    20 -
>  .../arch/x86/haswellx/frontend.json           |    58 -
>  .../arch/x86/haswellx/hsx-metrics.json        |  1467 +-
>  .../pmu-events/arch/x86/haswellx/memory.json  |   170 -
>  .../pmu-events/arch/x86/haswellx/other.json   |     8 -
>  .../arch/x86/haswellx/pipeline.json           |   258 -
>  .../arch/x86/haswellx/uncore-cache.json       |  2448 +-
>  .../x86/haswellx/uncore-interconnect.json     |   722 +-
>  .../arch/x86/haswellx/uncore-memory.json      |  2037 +-
>  .../arch/x86/haswellx/uncore-other.json       |  1834 +-
>  .../arch/x86/haswellx/uncore-power.json       |   150 +-
>  .../arch/x86/haswellx/virtual-memory.json     |    98 -
>  .../pmu-events/arch/x86/icelake/cache.json    |   412 -
>  .../arch/x86/icelake/floating-point.json      |    28 -
>  .../pmu-events/arch/x86/icelake/frontend.json |   144 -
>  .../arch/x86/icelake/icl-metrics.json         |   151 +-
>  .../pmu-events/arch/x86/icelake/memory.json   |   171 -
>  .../pmu-events/arch/x86/icelake/other.json    |   132 -
>  .../pmu-events/arch/x86/icelake/pipeline.json |   349 +-
>  .../arch/x86/icelake/uncore-other.json        |    10 +-
>  .../arch/x86/icelake/virtual-memory.json      |    80 -
>  .../pmu-events/arch/x86/icelakex/cache.json   |   316 +-
>  .../arch/x86/icelakex/floating-point.json     |    28 -
>  .../arch/x86/icelakex/frontend.json           |   140 -
>  .../arch/x86/icelakex/icx-metrics.json        |  2192 +-
>  .../pmu-events/arch/x86/icelakex/memory.json  |   139 +-
>  .../pmu-events/arch/x86/icelakex/other.json   |   117 -
>  .../arch/x86/icelakex/pipeline.json           |   344 +-
>  .../arch/x86/icelakex/uncore-memory.json      |  1878 +-
>  .../arch/x86/icelakex/uncore-other.json       | 45144 +++++++---------
>  .../arch/x86/icelakex/uncore-power.json       |   115 +-
>  .../arch/x86/icelakex/virtual-memory.json     |    88 -
>  .../pmu-events/arch/x86/ivybridge/cache.json  |   235 -
>  .../arch/x86/ivybridge/floating-point.json    |    34 -
>  .../arch/x86/ivybridge/frontend.json          |    60 -
>  .../arch/x86/ivybridge/ivb-metrics.json       |   119 +-
>  .../pmu-events/arch/x86/ivybridge/memory.json |    54 -
>  .../pmu-events/arch/x86/ivybridge/other.json  |     8 -
>  .../arch/x86/ivybridge/pipeline.json          |   250 -
>  .../arch/x86/ivybridge/uncore-cache.json      |    50 -
>  .../arch/x86/ivybridge/uncore-other.json      |    28 +-
>  .../arch/x86/ivybridge/virtual-memory.json    |    36 -
>  .../pmu-events/arch/x86/ivytown/cache.json    |   274 -
>  .../arch/x86/ivytown/floating-point.json      |    34 -
>  .../pmu-events/arch/x86/ivytown/frontend.json |    60 -
>  .../arch/x86/ivytown/ivt-metrics.json         |   133 +-
>  .../pmu-events/arch/x86/ivytown/memory.json   |   121 -
>  .../pmu-events/arch/x86/ivytown/other.json    |     8 -
>  .../pmu-events/arch/x86/ivytown/pipeline.json |   250 -
>  .../arch/x86/ivytown/uncore-cache.json        |   388 +-
>  .../arch/x86/ivytown/uncore-interconnect.json |   505 +-
>  .../arch/x86/ivytown/uncore-memory.json       |   209 +-
>  .../arch/x86/ivytown/uncore-other.json        |   254 +-
>  .../arch/x86/ivytown/uncore-power.json        |    95 -
>  .../arch/x86/ivytown/virtual-memory.json      |    40 -
>  .../pmu-events/arch/x86/jaketown/cache.json   |   289 -
>  .../arch/x86/jaketown/floating-point.json     |    30 -
>  .../arch/x86/jaketown/frontend.json           |    64 -
>  .../arch/x86/jaketown/jkt-metrics.json        |    91 +-
>  .../pmu-events/arch/x86/jaketown/memory.json  |   103 -
>  .../pmu-events/arch/x86/jaketown/other.json   |    12 -
>  .../arch/x86/jaketown/pipeline.json           |   255 -
>  .../arch/x86/jaketown/uncore-cache.json       |   266 +-
>  .../x86/jaketown/uncore-interconnect.json     |   132 -
>  .../arch/x86/jaketown/uncore-memory.json      |    58 -
>  .../arch/x86/jaketown/uncore-other.json       |   155 +-
>  .../arch/x86/jaketown/uncore-power.json       |    51 -
>  .../arch/x86/jaketown/virtual-memory.json     |    32 -
>  .../arch/x86/knightslanding/cache.json        |   411 -
>  .../x86/knightslanding/floating-point.json    |     3 -
>  .../arch/x86/knightslanding/frontend.json     |     7 -
>  .../arch/x86/knightslanding/memory.json       |   201 -
>  .../arch/x86/knightslanding/pipeline.json     |    44 -
>  .../arch/x86/knightslanding/uncore-other.json |  1040 +-
>  .../x86/knightslanding/virtual-memory.json    |     7 -
>  tools/perf/pmu-events/arch/x86/mapfile.csv    |    14 +-
>  .../pmu-events/arch/x86/meteorlake/cache.json |   170 +-
>  .../arch/x86/meteorlake/frontend.json         |     6 -
>  .../arch/x86/meteorlake/memory.json           |    77 +-
>  .../pmu-events/arch/x86/meteorlake/other.json |    24 +-
>  .../arch/x86/meteorlake/pipeline.json         |   222 +-
>  .../arch/x86/meteorlake/virtual-memory.json   |    28 +-
>  .../pmu-events/arch/x86/nehalemep/cache.json  |   524 -
>  .../arch/x86/nehalemep/floating-point.json    |    28 -
>  .../arch/x86/nehalemep/frontend.json          |     3 -
>  .../pmu-events/arch/x86/nehalemep/memory.json |   134 -
>  .../pmu-events/arch/x86/nehalemep/other.json  |    18 -
>  .../arch/x86/nehalemep/pipeline.json          |   127 +-
>  .../arch/x86/nehalemep/virtual-memory.json    |    13 -
>  .../pmu-events/arch/x86/nehalemex/cache.json  |   519 -
>  .../arch/x86/nehalemex/floating-point.json    |    28 -
>  .../arch/x86/nehalemex/frontend.json          |     3 -
>  .../pmu-events/arch/x86/nehalemex/memory.json |   134 -
>  .../pmu-events/arch/x86/nehalemex/other.json  |    18 -
>  .../arch/x86/nehalemex/pipeline.json          |   127 +-
>  .../arch/x86/nehalemex/virtual-memory.json    |    13 -
>  .../arch/x86/sandybridge/cache.json           |   441 -
>  .../arch/x86/sandybridge/floating-point.json  |    30 -
>  .../arch/x86/sandybridge/frontend.json        |    64 -
>  .../arch/x86/sandybridge/memory.json          |   108 -
>  .../arch/x86/sandybridge/other.json           |    12 -
>  .../arch/x86/sandybridge/pipeline.json        |   257 -
>  .../arch/x86/sandybridge/snb-metrics.json     |    83 +-
>  .../arch/x86/sandybridge/uncore-cache.json    |    50 -
>  .../arch/x86/sandybridge/uncore-other.json    |    28 +-
>  .../arch/x86/sandybridge/virtual-memory.json  |    32 -
>  .../arch/x86/sapphirerapids/cache.json        |   350 +-
>  .../x86/sapphirerapids/floating-point.json    |    63 -
>  .../arch/x86/sapphirerapids/frontend.json     |   144 -
>  .../arch/x86/sapphirerapids/memory.json       |   125 +-
>  .../arch/x86/sapphirerapids/other.json        |    91 +-
>  .../arch/x86/sapphirerapids/pipeline.json     |   424 +-
>  .../arch/x86/sapphirerapids/spr-metrics.json  |  2309 +-
>  .../x86/sapphirerapids/uncore-memory.json     |   526 +-
>  .../arch/x86/sapphirerapids/uncore-other.json |  6606 +--
>  .../arch/x86/sapphirerapids/uncore-power.json |    84 +-
>  .../x86/sapphirerapids/virtual-memory.json    |    80 -
>  .../pmu-events/arch/x86/silvermont/cache.json |   133 -
>  .../arch/x86/silvermont/floating-point.json   |     1 -
>  .../arch/x86/silvermont/frontend.json         |     8 -
>  .../arch/x86/silvermont/memory.json           |     1 -
>  .../pmu-events/arch/x86/silvermont/other.json |     2 -
>  .../arch/x86/silvermont/pipeline.json         |    35 -
>  .../arch/x86/silvermont/virtual-memory.json   |     7 -
>  .../pmu-events/arch/x86/skylake/cache.json    |   660 -
>  .../arch/x86/skylake/floating-point.json      |    14 -
>  .../pmu-events/arch/x86/skylake/frontend.json |   109 -
>  .../pmu-events/arch/x86/skylake/memory.json   |   358 -
>  .../pmu-events/arch/x86/skylake/other.json    |     4 -
>  .../pmu-events/arch/x86/skylake/pipeline.json |   192 -
>  .../arch/x86/skylake/skl-metrics.json         |   155 +-
>  .../arch/x86/skylake/uncore-cache.json        |    18 -
>  .../arch/x86/skylake/uncore-other.json        |    31 +-
>  .../arch/x86/skylake/virtual-memory.json      |    56 -
>  .../pmu-events/arch/x86/skylakex/cache.json   |   368 -
>  .../arch/x86/skylakex/floating-point.json     |    18 -
>  .../arch/x86/skylakex/frontend.json           |   109 -
>  .../pmu-events/arch/x86/skylakex/memory.json  |   310 -
>  .../pmu-events/arch/x86/skylakex/other.json   |    30 -
>  .../arch/x86/skylakex/pipeline.json           |   194 -
>  .../arch/x86/skylakex/skx-metrics.json        |  2134 +-
>  .../arch/x86/skylakex/uncore-memory.json      |  2303 +-
>  .../arch/x86/skylakex/uncore-other.json       | 29356 +++++-----
>  .../arch/x86/skylakex/uncore-power.json       |    45 +-
>  .../arch/x86/skylakex/virtual-memory.json     |    56 -
>  .../pmu-events/arch/x86/snowridgex/cache.json |   252 -
>  .../arch/x86/snowridgex/floating-point.json   |    11 -
>  .../arch/x86/snowridgex/frontend.json         |    36 -
>  .../arch/x86/snowridgex/memory.json           |    84 -
>  .../pmu-events/arch/x86/snowridgex/other.json |   143 -
>  .../arch/x86/snowridgex/pipeline.json         |   213 -
>  .../arch/x86/snowridgex/uncore-memory.json    |   624 +-
>  .../arch/x86/snowridgex/uncore-other.json     | 26334 ++++-----
>  .../arch/x86/snowridgex/uncore-power.json     |   114 +-
>  .../arch/x86/snowridgex/virtual-memory.json   |   117 -
>  .../pmu-events/arch/x86/tigerlake/cache.json  |   210 +-
>  .../arch/x86/tigerlake/floating-point.json    |    27 -
>  .../arch/x86/tigerlake/frontend.json          |   125 -
>  .../pmu-events/arch/x86/tigerlake/memory.json |    77 -
>  .../pmu-events/arch/x86/tigerlake/other.json  |    13 -
>  .../arch/x86/tigerlake/pipeline.json          |   287 +-
>  .../arch/x86/tigerlake/tgl-metrics.json       |   141 +-
>  .../arch/x86/tigerlake/uncore-other.json      |    96 +-
>  .../arch/x86/tigerlake/virtual-memory.json    |    60 -
>  .../arch/x86/westmereep-dp/cache.json         |   445 -
>  .../x86/westmereep-dp/floating-point.json     |    28 -
>  .../arch/x86/westmereep-dp/frontend.json      |     3 -
>  .../arch/x86/westmereep-dp/memory.json        |   137 -
>  .../arch/x86/westmereep-dp/other.json         |    22 -
>  .../arch/x86/westmereep-dp/pipeline.json      |   129 +-
>  .../x86/westmereep-dp/virtual-memory.json     |    21 -
>  .../arch/x86/westmereep-sp/cache.json         |   517 -
>  .../x86/westmereep-sp/floating-point.json     |    28 -
>  .../arch/x86/westmereep-sp/frontend.json      |     3 -
>  .../arch/x86/westmereep-sp/memory.json        |   134 -
>  .../arch/x86/westmereep-sp/other.json         |    22 -
>  .../arch/x86/westmereep-sp/pipeline.json      |   129 +-
>  .../x86/westmereep-sp/virtual-memory.json     |    18 -
>  .../pmu-events/arch/x86/westmereex/cache.json |   516 -
>  .../arch/x86/westmereex/floating-point.json   |    28 -
>  .../arch/x86/westmereex/frontend.json         |     3 -
>  .../arch/x86/westmereex/memory.json           |   135 -
>  .../pmu-events/arch/x86/westmereex/other.json |    22 -
>  .../arch/x86/westmereex/pipeline.json         |   129 +-
>  .../arch/x86/westmereex/virtual-memory.json   |    21 -
>  tools/perf/tests/pmu-events.c                 |    17 +-
>  273 files changed, 87488 insertions(+), 124409 deletions(-)
> 
