Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9218669E62B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 18:45:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234672AbjBURo7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 12:44:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234231AbjBURoz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 12:44:55 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28A5C22793
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 09:44:51 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id l6so3828561wms.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 09:44:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yh9v6RAm+HNl6CF5k8FLm9HUf948OjPWmeuMQStJeQQ=;
        b=c6Jv41jxKv3P/aEl3rGmtdXPZ3RPf861nm2UH3b772kfsHcpeeB7ee9oZ05W1R2U0a
         hRWxUVfm61oPeORpqUf/zUq8Eb8MsmZtXrnuVU/8ptCitK9+yZu9Xqum88hZN3HjLgYB
         s2ZWsMTsecKzqhmjxqGEZDNDNKztsQwvFh5yR8b8v7WWr420WGQiPe2Fm6RExoWkdCiZ
         WfQGtWxGNyDVrc8ZYT0gB2yafepSSPxs0Gz/9UbXsvKQcFqUl4AQ+WbwtP8wvzkZnoJI
         Wt736C1psAxScOik6dxBKLk/5yEbQsa3Bm+9DqpmxV3OjdbnNL4cro0u65F8tjEcWwN2
         AjOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yh9v6RAm+HNl6CF5k8FLm9HUf948OjPWmeuMQStJeQQ=;
        b=zBNr+BGPCi2EyJuyD9c3G8v2rnjx4m84W+ahuiNJr7x5PEDRObS5sgagTRSH+1JzBr
         bfxIyzWNqIctHc5yL4dV3l9oxnIhoPSoB0i45u6EUZjqxiRqU3qmVBTUe0wRAD8WoAxD
         jjBhrPW1rMw2lDFiq3y6YNFDGwrJHdM/91qdrwt9c88ezKMGd16uketY2FHFx64PsB8m
         oDOccdkKlQa9HB5wg+S5vPA7Ho7KzeTEQb8IsU3Vz89FFvbfh/IqXzMbjS2k5KGUWcjn
         WaTobBBpzCvHpl84zXEPO/aZMaGi8BifP9Pd1iYt+jP7IsO3wWJeOJjcb5LaBcUYrl0n
         yclA==
X-Gm-Message-State: AO0yUKVEUx5OjU1C7BE5G+ZIr4DTjZMdl2FHzRmOcA0visAPyMmp4JS6
        YW1rzPKZ/DXki6f56j3TonElB1iJDPk6Fg/PUwsDXw==
X-Google-Smtp-Source: AK7set/JJ7HVLEOsfWgx1XDABVRPwWS4EEihwMCUmsDBcUM7WRLl5dHjtONc+qvbHK5QjRgqQXKPkOexajadGlpzSgI=
X-Received: by 2002:a05:600c:1c95:b0:3db:1d5e:699 with SMTP id
 k21-20020a05600c1c9500b003db1d5e0699mr714500wms.195.1677001489347; Tue, 21
 Feb 2023 09:44:49 -0800 (PST)
MIME-Version: 1.0
References: <20230219092848.639226-1-irogers@google.com> <Y/IFNyI9JcChoR2p@kernel.org>
 <CAP-5=fWzydsYNKPBv+wCh4M9QaRbk5NiJOUDsjbjPdPjFWQ82g@mail.gmail.com>
In-Reply-To: <CAP-5=fWzydsYNKPBv+wCh4M9QaRbk5NiJOUDsjbjPdPjFWQ82g@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 21 Feb 2023 09:44:36 -0800
Message-ID: <CAP-5=fWmFtktttCmXBmF1W-V5yU47UFod=MxOX3re5pG_ScETQ@mail.gmail.com>
Subject: Re: [PATCH v1 00/51] shadow metric clean up and improvements
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Stephane Eranian <eranian@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Sandipan Das <sandipan.das@amd.com>,
        James Clark <james.clark@arm.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        John Garry <john.g.garry@oracle.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        Florian Fischer <florian.fischer@muhq.space>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Sean Christopherson <seanjc@google.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        "moderated list:ARM/STM32 ARCHITECTURE" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Perry Taylor <perry.taylor@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 19, 2023 at 7:43=E2=80=AFAM Ian Rogers <irogers@google.com> wro=
te:
>
> On Sun, Feb 19, 2023, 3:17 AM Arnaldo Carvalho de Melo <acme@kernel.org> =
wrote:
> >
> > Em Sun, Feb 19, 2023 at 01:27:57AM -0800, Ian Rogers escreveu:
> > > Recently the shadow stat metrics broke due to repeated aggregation an=
d
> > > a quick fix was applied:
> > > https://lore.kernel.org/lkml/20230209064447.83733-1-irogers@google.co=
m/
> > > This is the longer fix but one that comes with some extras. To avoid
> > > fixing issues for hard coded metrics, the topdown, SMI cost and
> > > transaction flags are moved into json metrics. A side effect of this
> > > is that TopdownL1 metrics will now be displayed when supported, if no
> > > "perf stat" events are specified.
> > >
> > > Another fix included here is for event grouping as raised in:
> > > https://lore.kernel.org/lkml/CA+icZUU_ew7pzWJJZLbj1xsU6MQTPrj8tkFfDhN=
dTDRQfGUBMQ@mail.gmail.com/
> > > Metrics are now tagged with NMI and SMT flags, meaning that the event=
s
> > > shouldn't be grouped if the NMI watchdog is enabled or SMT is enabled=
.
> > >
> > > Given the two issues, the metrics are re-generated and the patches
> > > also include the latest Intel vendor events. The changes to the metri=
c
> > > generation code can be seen in:
> > > https://github.com/intel/perfmon/pull/56
> > >
> > > Hard coded metrics support thresholds, the patches add this ability t=
o
> > > json metrics so that the hard coded metrics can be removed. Migrate
> > > remaining hard coded metrics to looking up counters from the
> > > evlist/aggregation count. Finally, get rid of the saved_value logic
> > > and thereby look to fix the aggregation issues.
> > >
> > > Some related fix ups and code clean ups are included in the changes,
> > > in particular to aid with the code's readability and to keep topdown
> > > documentation in sync.
> >
> > That is great work but won't have a reasonable time sitting on
> > linux-next to make it into 6.3.
> >
> > I have just applied it locally for the usual set of tests, that I'll
> > report back here.
>
>
> Ugh. I'm guessing it won't be useful if I point out more things broken
> with the current workaround, like metrics with --repeat :-/
>
> Thanks,
> Ian

So currently the flow of patches is:

1) initially testing - acme tmp.perf/core
2) things staged for next release - acme perf/core (perhaps this
should be called perf-next)
3) linux wide next release testing - linux-next
4) release - linus/master

I wonder if there should be a perf-next-next branch to work around the
"sitting time" problem. Otherwise anybody who touches code in these 51
patches will create a merge conflict. Given the aggregation issues
we're likely to see changes in this code and so conflicts are likely
to happen.

The patch flow with perf-next-next would be:

1) initial testing - tmp.perf-next-next
2) things acquiring sitting time and where developers work - perf-next-next
3) things staged for the next release - perf-next
4) as 3 above
5) as 4 above

With linux-next picking up acme perf/core (aka perf-next) daily it
isn't clear whether we should work off of perf-core or linux-next as
they are so in sync. This process means we've lost a sitting place for
developer patches and we're going to feel the pain in terms of merge
conflicts on the list, difficulty building off of the latest work
without cherry-picking from the list, etc.

Thanks,
Ian

> > - Arnaldo
> >
> > > Ian Rogers (51):
> > >   perf tools: Ensure evsel name is initialized
> > >   perf metrics: Improve variable names
> > >   perf pmu-events: Remove aggr_mode from pmu_event
> > >   perf pmu-events: Change aggr_mode to be an enum
> > >   perf pmu-events: Change deprecated to be a bool
> > >   perf pmu-events: Change perpkg to be a bool
> > >   perf expr: Make the online topology accessible globally
> > >   perf pmu-events: Make the metric_constraint an enum
> > >   perf pmu-events: Don't '\0' terminate enum values
> > >   perf vendor events intel: Refresh alderlake events
> > >   perf vendor events intel: Refresh alderlake-n metrics
> > >   perf vendor events intel: Refresh broadwell metrics
> > >   perf vendor events intel: Refresh broadwellde metrics
> > >   perf vendor events intel: Refresh broadwellx metrics
> > >   perf vendor events intel: Refresh cascadelakex events
> > >   perf vendor events intel: Add graniterapids events
> > >   perf vendor events intel: Refresh haswell metrics
> > >   perf vendor events intel: Refresh haswellx metrics
> > >   perf vendor events intel: Refresh icelake events
> > >   perf vendor events intel: Refresh icelakex metrics
> > >   perf vendor events intel: Refresh ivybridge metrics
> > >   perf vendor events intel: Refresh ivytown metrics
> > >   perf vendor events intel: Refresh jaketown events
> > >   perf vendor events intel: Refresh knightslanding events
> > >   perf vendor events intel: Refresh sandybridge events
> > >   perf vendor events intel: Refresh sapphirerapids events
> > >   perf vendor events intel: Refresh silvermont events
> > >   perf vendor events intel: Refresh skylake events
> > >   perf vendor events intel: Refresh skylakex metrics
> > >   perf vendor events intel: Refresh tigerlake events
> > >   perf vendor events intel: Refresh westmereep-dp events
> > >   perf jevents: Add rand support to metrics
> > >   perf jevent: Parse metric thresholds
> > >   perf pmu-events: Test parsing metric thresholds with the fake PMU
> > >   perf list: Support for printing metric thresholds
> > >   perf metric: Compute and print threshold values
> > >   perf expr: More explicit NAN handling
> > >   perf metric: Add --metric-no-threshold option
> > >   perf stat: Add TopdownL1 metric as a default if present
> > >   perf stat: Implement --topdown using json metrics
> > >   perf stat: Remove topdown event special handling
> > >   perf doc: Refresh topdown documentation
> > >   perf stat: Remove hard coded transaction events
> > >   perf stat: Use metrics for --smi-cost
> > >   perf stat: Remove perf_stat_evsel_id
> > >   perf stat: Move enums from header
> > >   perf stat: Hide runtime_stat
> > >   perf stat: Add cpu_aggr_map for loop
> > >   perf metric: Directly use counts rather than saved_value
> > >   perf stat: Use counts rather than saved_value
> > >   perf stat: Remove saved_value/runtime_stat
> > >
> > >  tools/perf/Documentation/perf-stat.txt        |   27 +-
> > >  tools/perf/Documentation/topdown.txt          |   70 +-
> > >  tools/perf/arch/powerpc/util/header.c         |    2 +-
> > >  tools/perf/arch/x86/util/evlist.c             |    6 +-
> > >  tools/perf/arch/x86/util/topdown.c            |   78 +-
> > >  tools/perf/arch/x86/util/topdown.h            |    1 -
> > >  tools/perf/builtin-list.c                     |   13 +-
> > >  tools/perf/builtin-script.c                   |    9 +-
> > >  tools/perf/builtin-stat.c                     |  233 +-
> > >  .../arch/x86/alderlake/adl-metrics.json       | 3190 ++++++++++-----=
--
> > >  .../pmu-events/arch/x86/alderlake/cache.json  |   36 +-
> > >  .../arch/x86/alderlake/floating-point.json    |   27 +
> > >  .../arch/x86/alderlake/frontend.json          |    9 +
> > >  .../pmu-events/arch/x86/alderlake/memory.json |    3 +-
> > >  .../arch/x86/alderlake/pipeline.json          |   14 +-
> > >  .../arch/x86/alderlake/uncore-other.json      |   28 +-
> > >  .../arch/x86/alderlaken/adln-metrics.json     |  811 +++--
> > >  .../arch/x86/broadwell/bdw-metrics.json       | 1439 ++++----
> > >  .../arch/x86/broadwellde/bdwde-metrics.json   | 1405 ++++----
> > >  .../arch/x86/broadwellx/bdx-metrics.json      | 1626 +++++----
> > >  .../arch/x86/broadwellx/uncore-cache.json     |   74 +-
> > >  .../x86/broadwellx/uncore-interconnect.json   |   64 +-
> > >  .../arch/x86/broadwellx/uncore-other.json     |    4 +-
> > >  .../arch/x86/cascadelakex/cache.json          |   24 +-
> > >  .../arch/x86/cascadelakex/clx-metrics.json    | 2198 ++++++------
> > >  .../arch/x86/cascadelakex/frontend.json       |    8 +-
> > >  .../arch/x86/cascadelakex/pipeline.json       |   16 +
> > >  .../arch/x86/cascadelakex/uncore-memory.json  |   18 +-
> > >  .../arch/x86/cascadelakex/uncore-other.json   |  120 +-
> > >  .../arch/x86/cascadelakex/uncore-power.json   |    8 +-
> > >  .../arch/x86/graniterapids/cache.json         |   54 +
> > >  .../arch/x86/graniterapids/frontend.json      |   10 +
> > >  .../arch/x86/graniterapids/memory.json        |  174 +
> > >  .../arch/x86/graniterapids/other.json         |   29 +
> > >  .../arch/x86/graniterapids/pipeline.json      |  102 +
> > >  .../x86/graniterapids/virtual-memory.json     |   26 +
> > >  .../arch/x86/haswell/hsw-metrics.json         | 1220 ++++---
> > >  .../arch/x86/haswellx/hsx-metrics.json        | 1397 ++++----
> > >  .../pmu-events/arch/x86/icelake/cache.json    |   16 +
> > >  .../arch/x86/icelake/floating-point.json      |   31 +
> > >  .../arch/x86/icelake/icl-metrics.json         | 1932 +++++-----
> > >  .../pmu-events/arch/x86/icelake/pipeline.json |   23 +-
> > >  .../arch/x86/icelake/uncore-other.json        |   56 +
> > >  .../arch/x86/icelakex/icx-metrics.json        | 2153 +++++------
> > >  .../arch/x86/icelakex/uncore-memory.json      |    2 +-
> > >  .../arch/x86/icelakex/uncore-other.json       |    4 +-
> > >  .../arch/x86/ivybridge/ivb-metrics.json       | 1270 ++++---
> > >  .../arch/x86/ivytown/ivt-metrics.json         | 1311 ++++---
> > >  .../pmu-events/arch/x86/jaketown/cache.json   |    6 +-
> > >  .../arch/x86/jaketown/floating-point.json     |    2 +-
> > >  .../arch/x86/jaketown/frontend.json           |   12 +-
> > >  .../arch/x86/jaketown/jkt-metrics.json        |  602 ++--
> > >  .../arch/x86/jaketown/pipeline.json           |    2 +-
> > >  .../arch/x86/jaketown/uncore-cache.json       |   22 +-
> > >  .../x86/jaketown/uncore-interconnect.json     |   74 +-
> > >  .../arch/x86/jaketown/uncore-memory.json      |    4 +-
> > >  .../arch/x86/jaketown/uncore-other.json       |   22 +-
> > >  .../arch/x86/jaketown/uncore-power.json       |    8 +-
> > >  .../arch/x86/knightslanding/cache.json        |   94 +-
> > >  .../arch/x86/knightslanding/pipeline.json     |    8 +-
> > >  .../arch/x86/knightslanding/uncore-other.json |    8 +-
> > >  tools/perf/pmu-events/arch/x86/mapfile.csv    |   29 +-
> > >  .../arch/x86/sandybridge/cache.json           |    8 +-
> > >  .../arch/x86/sandybridge/floating-point.json  |    2 +-
> > >  .../arch/x86/sandybridge/frontend.json        |   12 +-
> > >  .../arch/x86/sandybridge/pipeline.json        |    2 +-
> > >  .../arch/x86/sandybridge/snb-metrics.json     |  601 ++--
> > >  .../arch/x86/sapphirerapids/cache.json        |   24 +-
> > >  .../x86/sapphirerapids/floating-point.json    |   32 +
> > >  .../arch/x86/sapphirerapids/frontend.json     |    8 +
> > >  .../arch/x86/sapphirerapids/pipeline.json     |   19 +-
> > >  .../arch/x86/sapphirerapids/spr-metrics.json  | 2283 ++++++------
> > >  .../arch/x86/sapphirerapids/uncore-other.json |   60 +
> > >  .../arch/x86/silvermont/frontend.json         |    2 +-
> > >  .../arch/x86/silvermont/pipeline.json         |    2 +-
> > >  .../pmu-events/arch/x86/skylake/cache.json    |   25 +-
> > >  .../pmu-events/arch/x86/skylake/frontend.json |    8 +-
> > >  .../pmu-events/arch/x86/skylake/other.json    |    1 +
> > >  .../pmu-events/arch/x86/skylake/pipeline.json |   16 +
> > >  .../arch/x86/skylake/skl-metrics.json         | 1877 ++++++----
> > >  .../arch/x86/skylake/uncore-other.json        |    1 +
> > >  .../pmu-events/arch/x86/skylakex/cache.json   |    8 +-
> > >  .../arch/x86/skylakex/frontend.json           |    8 +-
> > >  .../arch/x86/skylakex/pipeline.json           |   16 +
> > >  .../arch/x86/skylakex/skx-metrics.json        | 2097 +++++------
> > >  .../arch/x86/skylakex/uncore-memory.json      |    2 +-
> > >  .../arch/x86/skylakex/uncore-other.json       |   96 +-
> > >  .../arch/x86/skylakex/uncore-power.json       |    6 +-
> > >  .../arch/x86/tigerlake/floating-point.json    |   31 +
> > >  .../arch/x86/tigerlake/pipeline.json          |   18 +
> > >  .../arch/x86/tigerlake/tgl-metrics.json       | 1942 +++++-----
> > >  .../arch/x86/tigerlake/uncore-other.json      |   28 +-
> > >  .../arch/x86/westmereep-dp/cache.json         |    2 +-
> > >  .../x86/westmereep-dp/virtual-memory.json     |    2 +-
> > >  tools/perf/pmu-events/jevents.py              |   58 +-
> > >  tools/perf/pmu-events/metric.py               |    8 +-
> > >  tools/perf/pmu-events/pmu-events.h            |   35 +-
> > >  tools/perf/tests/expand-cgroup.c              |    3 +-
> > >  tools/perf/tests/expr.c                       |    7 +-
> > >  tools/perf/tests/parse-metric.c               |   21 +-
> > >  tools/perf/tests/pmu-events.c                 |   49 +-
> > >  tools/perf/util/cpumap.h                      |    3 +
> > >  tools/perf/util/cputopo.c                     |   14 +
> > >  tools/perf/util/cputopo.h                     |    5 +
> > >  tools/perf/util/evsel.h                       |    2 +-
> > >  tools/perf/util/expr.c                        |   16 +-
> > >  tools/perf/util/expr.y                        |   12 +-
> > >  tools/perf/util/metricgroup.c                 |  178 +-
> > >  tools/perf/util/metricgroup.h                 |    5 +-
> > >  tools/perf/util/pmu.c                         |   17 +-
> > >  tools/perf/util/print-events.h                |    1 +
> > >  tools/perf/util/smt.c                         |   11 +-
> > >  tools/perf/util/smt.h                         |   12 +-
> > >  tools/perf/util/stat-display.c                |  117 +-
> > >  tools/perf/util/stat-shadow.c                 | 1287 ++-----
> > >  tools/perf/util/stat.c                        |   74 -
> > >  tools/perf/util/stat.h                        |   96 +-
> > >  tools/perf/util/synthetic-events.c            |    2 +-
> > >  tools/perf/util/topdown.c                     |   68 +-
> > >  tools/perf/util/topdown.h                     |   11 +-
> > >  120 files changed, 18025 insertions(+), 15590 deletions(-)
> > >  create mode 100644 tools/perf/pmu-events/arch/x86/graniterapids/cach=
e.json
> > >  create mode 100644 tools/perf/pmu-events/arch/x86/graniterapids/fron=
tend.json
> > >  create mode 100644 tools/perf/pmu-events/arch/x86/graniterapids/memo=
ry.json
> > >  create mode 100644 tools/perf/pmu-events/arch/x86/graniterapids/othe=
r.json
> > >  create mode 100644 tools/perf/pmu-events/arch/x86/graniterapids/pipe=
line.json
> > >  create mode 100644 tools/perf/pmu-events/arch/x86/graniterapids/virt=
ual-memory.json
> > >
> > > --
> > > 2.39.2.637.g21b0678d19-goog
> > >
> >
> > --
> >
> > - Arnaldo
