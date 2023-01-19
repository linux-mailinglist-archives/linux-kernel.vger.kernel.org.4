Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 931EA67435B
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 21:14:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbjASUOe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 15:14:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbjASUOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 15:14:30 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AF3D9519D;
        Thu, 19 Jan 2023 12:14:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674159269; x=1705695269;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ZeCUFjyvh3AJ3w7Siul74Jx9GEqX2RiuD1sWIC7joAA=;
  b=D40ygtbqg0jvLqVYvsNG2kt2eMvTjxCY23KJO2qu/googHJrHoBhoc5B
   d3hM3x+x8I6k699yxPLmneriFLBRFffkECYR0c6XokQSsygmmqOO/9GbR
   dU1zDuYsvdWTcPBjt6/m59IswrsdxPDKbHRMd10yUiAXIv7dhlwpaUMzN
   wBjBhOBozxUcPLe86n0LPdpl13QtAWVy+BJoAhYJh+nck+vQz2FUefWS9
   4xHiKsBCJIlqkXy96Qsp6ILkjB2+3isJDVmadGMgfR+JkQDudPmqiBIao
   Xt8dTuihc/L8YX0LFejL6ongUYA9WcMoQPoEzTg28y/7CzWBiXrTmMDSM
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="305776648"
X-IronPort-AV: E=Sophos;i="5.97,229,1669104000"; 
   d="scan'208";a="305776648"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2023 12:14:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="802771059"
X-IronPort-AV: E=Sophos;i="5.97,229,1669104000"; 
   d="scan'208";a="802771059"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga001.fm.intel.com with ESMTP; 19 Jan 2023 12:14:28 -0800
Received: from [10.209.115.195] (kliang2-mobl1.ccr.corp.intel.com [10.209.115.195])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id B1306580AA4;
        Thu, 19 Jan 2023 12:14:26 -0800 (PST)
Message-ID: <c8238848-801b-af31-d9aa-91839fae5885@linux.intel.com>
Date:   Thu, 19 Jan 2023 15:14:25 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v1] perf tools: Fix foolproof typo
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Leo Yan <leo.yan@linaro.org>, Ali Saidi <alisaidi@amazon.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        James Clark <james.clark@arm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Sandipan Das <sandipan.das@amd.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230119201036.156441-1-irogers@google.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20230119201036.156441-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-01-19 3:10 p.m., Ian Rogers wrote:
> In the context of LBR stitching documentation.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>

Thanks Ian.

Acked-by: Kan Liang <kan.liang@linux.intel.com>

Thanks,
Kan

> ---
>  tools/perf/Documentation/perf-c2c.txt    | 2 +-
>  tools/perf/Documentation/perf-report.txt | 2 +-
>  tools/perf/Documentation/perf-script.txt | 2 +-
>  tools/perf/Documentation/perf-top.txt    | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/perf/Documentation/perf-c2c.txt b/tools/perf/Documentation/perf-c2c.txt
> index 5c5eb2def83e..af5c3106f468 100644
> --- a/tools/perf/Documentation/perf-c2c.txt
> +++ b/tools/perf/Documentation/perf-c2c.txt
> @@ -121,7 +121,7 @@ REPORT OPTIONS
>  	perf c2c record --call-graph lbr.
>  	Disabled by default. In common cases with call stack overflows,
>  	it can recreate better call stacks than the default lbr call stack
> -	output. But this approach is not full proof. There can be cases
> +	output. But this approach is not foolproof. There can be cases
>  	where it creates incorrect call stacks from incorrect matches.
>  	The known limitations include exception handing such as
>  	setjmp/longjmp will have calls/returns not match.
> diff --git a/tools/perf/Documentation/perf-report.txt b/tools/perf/Documentation/perf-report.txt
> index 4fa509b15948..9b0c0dbf9a77 100644
> --- a/tools/perf/Documentation/perf-report.txt
> +++ b/tools/perf/Documentation/perf-report.txt
> @@ -507,7 +507,7 @@ include::itrace.txt[]
>  	perf record --call-graph lbr.
>  	Disabled by default. In common cases with call stack overflows,
>  	it can recreate better call stacks than the default lbr call stack
> -	output. But this approach is not full proof. There can be cases
> +	output. But this approach is not foolproof. There can be cases
>  	where it creates incorrect call stacks from incorrect matches.
>  	The known limitations include exception handing such as
>  	setjmp/longjmp will have calls/returns not match.
> diff --git a/tools/perf/Documentation/perf-script.txt b/tools/perf/Documentation/perf-script.txt
> index 68e37de5fae4..8d77182fbf31 100644
> --- a/tools/perf/Documentation/perf-script.txt
> +++ b/tools/perf/Documentation/perf-script.txt
> @@ -502,7 +502,7 @@ include::itrace.txt[]
>  	perf record --call-graph lbr.
>  	Disabled by default. In common cases with call stack overflows,
>  	it can recreate better call stacks than the default lbr call stack
> -	output. But this approach is not full proof. There can be cases
> +	output. But this approach is not foolproof. There can be cases
>  	where it creates incorrect call stacks from incorrect matches.
>  	The known limitations include exception handing such as
>  	setjmp/longjmp will have calls/returns not match.
> diff --git a/tools/perf/Documentation/perf-top.txt b/tools/perf/Documentation/perf-top.txt
> index e534d709cc5a..c60e615b7183 100644
> --- a/tools/perf/Documentation/perf-top.txt
> +++ b/tools/perf/Documentation/perf-top.txt
> @@ -334,7 +334,7 @@ use '-e e1 -e e2 -G foo,foo' or just use '-e e1 -e e2 -G foo'.
>  	callgraph. The option must be used with --call-graph lbr recording.
>  	Disabled by default. In common cases with call stack overflows,
>  	it can recreate better call stacks than the default lbr call stack
> -	output. But this approach is not full proof. There can be cases
> +	output. But this approach is not foolproof. There can be cases
>  	where it creates incorrect call stacks from incorrect matches.
>  	The known limitations include exception handing such as
>  	setjmp/longjmp will have calls/returns not match.
