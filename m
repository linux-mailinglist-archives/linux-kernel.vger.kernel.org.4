Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83CA15FF141
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 17:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbiJNPZ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 11:25:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230370AbiJNPZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 11:25:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C200E106E31;
        Fri, 14 Oct 2022 08:25:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 70CE6B82362;
        Fri, 14 Oct 2022 15:25:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19275C43470;
        Fri, 14 Oct 2022 15:25:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665761139;
        bh=tBWSB2RMwgDRIDz5HzUwkKxuyw5LEsM3Fqlis7Mu+F8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jywwUZh+hu9uQluhvU1+df85/bcLTaRcqmjER+Eeuj78VK85Zd6lmRz1HDtzBVuMZ
         fyLyOWh3J9Px/pHuQyfmPrGR+r3igzIGZKkMkZ770QzVYUuPcOYy7Pvaah0gk0t5U9
         E0IRRChhJ+wmNRjj1swfbsF8iVorlJro4Jl8lfMZzIqGtRHMnzwg80oHNgHWqgFxlO
         /e8TJq1szJvQile3A6ShaSI5iaXeAx/tTRyT/z2SkgRfGj7N1FXlrh3SvQAd7Ygpih
         TUtgbqYqJ6GKgQ8g23K9jOHb9djur0ghxfddttBzcGv58Temp1oNMhlSukz6kK5kaZ
         SLzHpPDfLmerQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 42BB84062C; Fri, 14 Oct 2022 12:25:37 -0300 (-03)
Date:   Fri, 14 Oct 2022 12:25:37 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Leo Yan <leo.yan@linaro.org>,
        James Clark <james.clark@arm.com>
Subject: Re: [PATCH v4 0/3] perf tool: 'config3' attribute support
Message-ID: <Y0l/cc8MTNY8RQUl@kernel.org>
References: <20220914-arm-perf-tool-spe1-2-v2-v4-0-83c098e6212e@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220914-arm-perf-tool-spe1-2-v2-v4-0-83c098e6212e@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Oct 04, 2022 at 02:12:34PM -0500, Rob Herring escreveu:
> This series is a fix to allow unknown 'configN' attrs and then extends 
> perf tool to support a new config3 attr.
> 
> The config3 support is RFC for context as the kernel side support[1] is 
> not yet accepted. Patch 1 is intended for 6.1.
> 
> [1] https://lore.kernel.org/all/20220825-arm-spe-v8-7-v1-0-c75b8d92e692@kernel.org/
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> Changes in v4:
> - Fix event parsing test segfault
> - Add 'config3' in event parsing tests
> - Link to v3: https://lore.kernel.org/r/20220914-arm-perf-tool-spe1-2-v2-v3-0-8189fc04dcc6@kernel.org

Thanks, applied.

- Arnaldo

 
> ---
> Rob Herring (3):
>       perf: Skip and warn on unknown format 'configN' attrs
>       perf tools: Sync perf_event_attr::config3 addition
>       perf: Add support for perf_event_attr::config3
> 
>  include/uapi/linux/perf_event.h       |  3 +++
>  tools/include/uapi/linux/perf_event.h |  3 +++
>  tools/perf/tests/parse-events.c       | 13 ++++++++++++-
>  tools/perf/util/parse-events.c        |  9 +++++++++
>  tools/perf/util/parse-events.h        |  1 +
>  tools/perf/util/parse-events.l        |  1 +
>  tools/perf/util/pmu.c                 | 20 ++++++++++++++++++++
>  tools/perf/util/pmu.h                 |  3 +++
>  tools/perf/util/pmu.l                 |  2 --
>  tools/perf/util/pmu.y                 | 15 ++++-----------
>  10 files changed, 56 insertions(+), 14 deletions(-)
> ---
> base-commit: 1c23f9e627a7b412978b4e852793c5e3c3efc555
> change-id: 20220914-arm-perf-tool-spe1-2-v2-cab789c5d598
> 
> Best regards,
> -- 
> Rob Herring <robh@kernel.org>

-- 

- Arnaldo
