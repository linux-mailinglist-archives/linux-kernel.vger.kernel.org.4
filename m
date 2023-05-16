Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 048B470557C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 19:54:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231994AbjEPRyE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 13:54:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231906AbjEPRyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 13:54:01 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EE55421F;
        Tue, 16 May 2023 10:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684259640; x=1715795640;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=YiZsIgYOL4lLbtKev0w4UMEVL78YCd3KwcfQatPQ4s0=;
  b=M4giy1LtGqOqyisQOWfiX9wX8Np9JhHO5jxZj5B/4M/D/Je6bMdBuvuQ
   p8imNLNG4ud0oxaIlTIqARlda+6HOhMtXMrC5UE1LJe6GS1d+tbG13tMm
   oUOumk4kwE8Tk9rJcdW6aaU4BCuPT7ZCS/Dg2LaKzMBOoJSLl2ZJAzhq3
   k3ki1pgE5aYGUF+Iffqgjd+CXbsclgHfrFKA5F+F7Ws+oMYW9EpjiOHZM
   BG6r3+LqyzmQN8REmU//r4sPlYuIHdoUWEHXE+MUMWTuzmD6IW/miRcHF
   /J2mn7otcUe9N/Nd2qqx4RC9YPgDHZtAwNqjRuhohI05y+A1oSF3fFrmX
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10712"; a="351579559"
X-IronPort-AV: E=Sophos;i="5.99,278,1677571200"; 
   d="scan'208";a="351579559"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2023 10:53:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10712"; a="678937377"
X-IronPort-AV: E=Sophos;i="5.99,278,1677571200"; 
   d="scan'208";a="678937377"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga006.jf.intel.com with ESMTP; 16 May 2023 10:53:58 -0700
Received: from [10.212.175.225] (kliang2-mobl1.ccr.corp.intel.com [10.212.175.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 3A60E5808AE;
        Tue, 16 May 2023 10:53:57 -0700 (PDT)
Message-ID: <4f1e2e31-4efd-ba94-18e5-e53189429d9b@linux.intel.com>
Date:   Tue, 16 May 2023 13:53:56 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v1 15/15] perf vendor events intel: Add metricgroup
 descriptions for all models
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
        John Garry <john.garry@huawei.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
References: <20230515215844.653610-1-irogers@google.com>
 <20230515215844.653610-16-irogers@google.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20230515215844.653610-16-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-05-15 5:58 p.m., Ian Rogers wrote:
> Add metric group descriptions created by:
> https://github.com/intel/perfmon/blob/main/scripts/create_perf_json.py
> The descriptions add some additional detail in perf list.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  .../arch/x86/alderlake/metricgroups.json      | 122 ++++++++++++++++++
>  .../arch/x86/alderlaken/metricgroups.json     |  26 ++++
>  .../arch/x86/broadwell/metricgroups.json      | 107 +++++++++++++++
>  .../arch/x86/broadwellde/metricgroups.json    | 107 +++++++++++++++
>  .../arch/x86/broadwellx/metricgroups.json     | 107 +++++++++++++++
>  .../arch/x86/cascadelakex/metricgroups.json   | 114 ++++++++++++++++
>  .../arch/x86/haswell/metricgroups.json        | 107 +++++++++++++++
>  .../arch/x86/haswellx/metricgroups.json       | 107 +++++++++++++++
>  .../arch/x86/icelake/metricgroups.json        | 113 ++++++++++++++++
>  .../arch/x86/icelakex/metricgroups.json       | 114 ++++++++++++++++
>  .../arch/x86/ivybridge/metricgroups.json      | 107 +++++++++++++++
>  .../arch/x86/ivytown/metricgroups.json        | 107 +++++++++++++++
>  .../arch/x86/jaketown/metricgroups.json       | 100 ++++++++++++++
>  .../arch/x86/sandybridge/metricgroups.json    | 100 ++++++++++++++
>  .../arch/x86/sapphirerapids/metricgroups.json | 118 +++++++++++++++++
>  .../arch/x86/skylake/metricgroups.json        | 113 ++++++++++++++++
>  .../arch/x86/skylakex/metricgroups.json       | 114 ++++++++++++++++
>  .../arch/x86/tigerlake/metricgroups.json      | 113 ++++++++++++++++
>  18 files changed, 1896 insertions(+)
>  create mode 100644 tools/perf/pmu-events/arch/x86/alderlake/metricgroups.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/alderlaken/metricgroups.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/broadwell/metricgroups.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/broadwellde/metricgroups.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/broadwellx/metricgroups.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/cascadelakex/metricgroups.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/haswell/metricgroups.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/haswellx/metricgroups.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/icelake/metricgroups.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/icelakex/metricgroups.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/ivybridge/metricgroups.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/ivytown/metricgroups.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/jaketown/metricgroups.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/sandybridge/metricgroups.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/sapphirerapids/metricgroups.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/skylake/metricgroups.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/skylakex/metricgroups.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/tigerlake/metricgroups.json
> 
> diff --git a/tools/perf/pmu-events/arch/x86/alderlake/metricgroups.json b/tools/perf/pmu-events/arch/x86/alderlake/metricgroups.json
> new file mode 100644
> index 000000000000..273ccfb0ed6f
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/x86/alderlake/metricgroups.json
> @@ -0,0 +1,122 @@
> +{
> +    "Backend": "Grouping from metrics spreadsheet",
> +    "Bad": "Grouping from metrics spreadsheet",
> +    "BadSpec": "Grouping from metrics spreadsheet",
> +    "BigFoot": "Grouping from metrics spreadsheet",
> +    "BrMispredicts": "Grouping from metrics spreadsheet",
> +    "Branches": "Grouping from metrics spreadsheet",

The description "Grouping from metrics spreadsheet" seems meaningless,
and may bring confusion information, e.g., what is metrics spreadsheet?
I think it may be better to leave it empty if we don't have a proper
description for the metricgroup.

Other descriptions look good to me.

Thanks,
Kan
