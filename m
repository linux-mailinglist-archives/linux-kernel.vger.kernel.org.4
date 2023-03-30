Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 227DD6D10B0
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 23:17:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbjC3VRv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 17:17:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbjC3VRt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 17:17:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6330E19A6;
        Thu, 30 Mar 2023 14:17:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0050FB82A2E;
        Thu, 30 Mar 2023 21:17:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D155C433D2;
        Thu, 30 Mar 2023 21:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680211065;
        bh=0sF39v6ZsZyswJE7VRD85k8BLhUYNT8/Pw2LibgU/Do=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UicpQNuJA4/TttC8oXCA+E3QW/6zm78RYjliOtaPpVD+sOkqMsGyMbREegcFscyYc
         0FC8sVtT4sgeJcuTvieyEaHAHJeRErnkDL9Qx4y000G9x2xpc5Ufr3ygCFR8QxAPdh
         ahE4PphBZrndQ2cEgrrU1zbPBzbDJKuwd6/8X5MXWBBuvMyG7B6/vznn/um5acyIpN
         JTlj0cUxaJdLAfmbQam6nXs4q30YJVSzWC5XCNDQU0IIgpWmhePtn5gc6dGDmCkojW
         0kF9GmMJJyeEQQ5PpZ5PjfJEJxDWoJUzGCifWJkHc6Dcc/+8ftThDqGT96KdZCimJk
         CMonp9/OBl8MA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 227ED4052D; Thu, 30 Mar 2023 18:17:43 -0300 (-03)
Date:   Thu, 30 Mar 2023 18:17:43 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Edward Baker <edward.baker@intel.com>
Subject: Re: [PATCH v1] perf vendor events intel: Update ivybridge and ivytown
Message-ID: <ZCX8d7ZSUdTGk1Jj@kernel.org>
References: <20230328234142.1080045-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230328234142.1080045-1-irogers@google.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Mar 28, 2023 at 04:41:42PM -0700, Ian Rogers escreveu:
> Update to versions 24 and 23 respectively. Adds the event
> BR_MISP_EXEC.INDIRECT.

Thanks, applied.

- Arnaldo

 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/pmu-events/arch/x86/ivybridge/pipeline.json | 8 ++++++++
>  tools/perf/pmu-events/arch/x86/ivytown/pipeline.json   | 8 ++++++++
>  tools/perf/pmu-events/arch/x86/mapfile.csv             | 4 ++--
>  3 files changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/pmu-events/arch/x86/ivybridge/pipeline.json b/tools/perf/pmu-events/arch/x86/ivybridge/pipeline.json
> index d1e64e0d683e..30a3da9cd22b 100644
> --- a/tools/perf/pmu-events/arch/x86/ivybridge/pipeline.json
> +++ b/tools/perf/pmu-events/arch/x86/ivybridge/pipeline.json
> @@ -215,6 +215,14 @@
>          "SampleAfterValue": "200003",
>          "UMask": "0xc4"
>      },
> +    {
> +        "BriefDescription": "Speculative mispredicted indirect branches",
> +        "EventCode": "0x89",
> +        "EventName": "BR_MISP_EXEC.INDIRECT",
> +        "PublicDescription": "Counts speculatively miss-predicted indirect branches at execution time. Counts for indirect near CALL or JMP instructions (RET excluded).",
> +        "SampleAfterValue": "200003",
> +        "UMask": "0xe4"
> +    },
>      {
>          "BriefDescription": "Not taken speculative and retired mispredicted macro conditional branches",
>          "EventCode": "0x89",
> diff --git a/tools/perf/pmu-events/arch/x86/ivytown/pipeline.json b/tools/perf/pmu-events/arch/x86/ivytown/pipeline.json
> index d1e64e0d683e..30a3da9cd22b 100644
> --- a/tools/perf/pmu-events/arch/x86/ivytown/pipeline.json
> +++ b/tools/perf/pmu-events/arch/x86/ivytown/pipeline.json
> @@ -215,6 +215,14 @@
>          "SampleAfterValue": "200003",
>          "UMask": "0xc4"
>      },
> +    {
> +        "BriefDescription": "Speculative mispredicted indirect branches",
> +        "EventCode": "0x89",
> +        "EventName": "BR_MISP_EXEC.INDIRECT",
> +        "PublicDescription": "Counts speculatively miss-predicted indirect branches at execution time. Counts for indirect near CALL or JMP instructions (RET excluded).",
> +        "SampleAfterValue": "200003",
> +        "UMask": "0xe4"
> +    },
>      {
>          "BriefDescription": "Not taken speculative and retired mispredicted macro conditional branches",
>          "EventCode": "0x89",
> diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-events/arch/x86/mapfile.csv
> index 41d755d570e6..97b3ffc284a6 100644
> --- a/tools/perf/pmu-events/arch/x86/mapfile.csv
> +++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
> @@ -14,8 +14,8 @@ GenuineIntel-6-(3C|45|46),v33,haswell,core
>  GenuineIntel-6-3F,v27,haswellx,core
>  GenuineIntel-6-(7D|7E|A7),v1.17,icelake,core
>  GenuineIntel-6-6[AC],v1.19,icelakex,core
> -GenuineIntel-6-3A,v23,ivybridge,core
> -GenuineIntel-6-3E,v22,ivytown,core
> +GenuineIntel-6-3A,v24,ivybridge,core
> +GenuineIntel-6-3E,v23,ivytown,core
>  GenuineIntel-6-2D,v23,jaketown,core
>  GenuineIntel-6-(57|85),v10,knightslanding,core
>  GenuineIntel-6-A[AC],v1.01,meteorlake,core
> -- 
> 2.40.0.348.gf938b09366-goog
> 

-- 

- Arnaldo
