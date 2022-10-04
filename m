Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E44C65F48FC
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 19:56:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbiJDR4S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 13:56:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbiJDR4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 13:56:13 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5DEB5E657
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 10:56:10 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id n40-20020a05600c3ba800b003b49aefc35fso7988196wms.5
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 10:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=64g6Yo5IR062rBWvJYqoNxVzF4f+8aSWVKwtmllf1RA=;
        b=bX9FpQMBYvtMaqt4A+nc2TDlC5nf+YAJSBCQuDWMgZKoadgb9cD+7+VQHSAR6zEJwx
         1oJlOzErurBwjacFu1YaJX/vjKJZbfM2/zJlEsLWhxk3C6sZiq/Q3v8kcafCJxOA4KlH
         14Tt0bmPPZsT2vhkFEasKqUmcgEC7GuZDeDSB3i9j7iIlU1eVIXzteQlJAOapVJ0/6Ki
         nerznZp32a/rLHzLqTtR0XBpXsp250ZbcJBf2JGDlPBDqTgFkGI2y4EI5G3R37k4TTO2
         t8/SDj3fB3DP4ANCZULTKG2iJWYP3FbsXTUljDqMVBfwkEr05Qoadzw3o5ClLcA0GsO8
         Nk5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=64g6Yo5IR062rBWvJYqoNxVzF4f+8aSWVKwtmllf1RA=;
        b=y3FrTh9Z7TGI0XqYOAJc4OiLQMK8bVYzINUB3vOXQ+u69yS5Awfb2/FDcOln4rje8G
         QvFje5NtkftuUQ/jTqIGsJJghhV75TXp/T4CTsVcaak3eP6Wxz+XfKM2rSRZR1EoahD0
         rLbHnwshs3WIva/eTZyafHv81orDRhHGJVa9DPNIZ0qPVxfj0J3WMqtkyTf5R+j6bUfA
         Qd+It5OqhxTlJ50fIrpB6rMvGD6X1U/XXm/jpDgFE7u4Q7SHpVIytQyiFzqJAV9UDX+r
         I7h5T7injlMvYDUnL8tOglFltfZ9Vm92oBSZ0t8+paNK01lSKwQr7PSFwT0Q228W6UM8
         AWPA==
X-Gm-Message-State: ACrzQf13lIA0e4RqUP/w17ytrDjZLhrNhxmlwXzpZFBiGyxrHAnn1MqG
        Af1GZHff6+YTxnp0yrP0r+3rHIw2z8kFidzsM8LiGA==
X-Google-Smtp-Source: AMsMyM45ZnSGu6kM9Ved/dp2Mgtdt/9vjikIYyHFWKknkqWhc+01vtq28BeaEzL4s9Siln3OqSOAyDi0g7l8Z+9fhAk=
X-Received: by 2002:a7b:c048:0:b0:3b4:fb26:f0f3 with SMTP id
 u8-20020a7bc048000000b003b4fb26f0f3mr678166wmc.115.1664906169263; Tue, 04 Oct
 2022 10:56:09 -0700 (PDT)
MIME-Version: 1.0
References: <20221004021612.325521-1-irogers@google.com> <CAP-5=fXk6sLhZsEs72G4pOuZNzDJLc2Vkkvf+Jv=LXQDHPy8-w@mail.gmail.com>
 <677c6ec7-2e01-635b-dbfb-fbb9280e5b7c@linux.intel.com>
In-Reply-To: <677c6ec7-2e01-635b-dbfb-fbb9280e5b7c@linux.intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 4 Oct 2022 10:55:56 -0700
Message-ID: <CAP-5=fUFuw-WYj7xVm3WrnggN2NW7pJkznUQ-j3U4fwMB5PdnA@mail.gmail.com>
Subject: Re: [PATCH v3 00/23] Improvements to Intel perf metrics
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>, perry.taylor@intel.com,
        caleb.biggers@intel.com, kshipra.bopardikar@intel.com,
        samantha.alt@intel.com, ahmad.yasin@intel.com,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 4, 2022 at 10:29 AM Andi Kleen <ak@linux.intel.com> wrote:
>
> [cutting down cc list]
>
>
> On 10/3/2022 8:43 PM, Ian Rogers wrote:
> > On Mon, Oct 3, 2022 at 7:16 PM Ian Rogers <irogers@google.com> wrote:
> >> For consistency with:
> >> https://github.com/intel/perfmon-metrics
> >> rename of topdown TMA metrics from Frontend_Bound to tma_frontend_bound.
> >>
> >> Remove _SMT suffix metrics are dropped as the #SMT_On and #EBS_Mode
> >> are correctly expanded in the single main metric. Fix perf expr to
> >> allow a double if to be correctly processed.
> >>
> >> Add all 6 levels of TMA metrics. Child metrics are placed in a group
> >> named after their parent allowing children of a metric to be
> >> easily measured using the metric name with a _group suffix.
> >>
> >> Don't drop TMA metrics if they contain topdown events.
> >>
> >> The ## and ##? operators are correctly expanded.
> >>
> >> The locate-with column is added to the long description describing a
> >> sampling event.
> >>
> >> Metrics are written in terms of other metrics to reduce the expression
> >> size and increase readability.
> >>
> >> Following this the pmu-events/arch/x86 directories match those created
> >> by the script at:
> >> https://github.com/intel/event-converter-for-linux-perf/blob/master/download_and_gen.py
> >> with updates at:
> >> https://github.com/captain5050/event-converter-for-linux-perf
> >>
> >>
> >> v3. Fix a parse metrics test failure due to making metrics referring
> >>      to other metrics case sensitive - make the cases in the test
> >>      metric match.
> >> v2. Fixes commit message wrt missing mapfile.csv updates as noted by
> >>      Zhengjun Xing <zhengjun.xing@linux.intel.com>. ScaleUnit is added
> >>      for TMA metrics. Metrics with topdown events have have a missing
> >>      slots event added if necessary. The latest metrics at:
> >>      https://github.com/intel/perfmon-metrics are used, however, the
> >>      event-converter-for-linux-perf scripts now prefer their own
> >>      metrics in case of mismatched units when a metric is written in
> >>      terms of another.  Additional testing was performed on broadwell,
> >>      broadwellde, cascadelakex, haswellx, sapphirerapids and tigerlake
> >>      CPUs.
> > I wrote up a little example of performing a top-down analysis for the
> > perf wiki here:
> > https://perf.wiki.kernel.org/index.php/Top-Down_Analysis
>
>
> I did some quick testing.
>
> On Skylake the output of L1 isn't scaled to percent:
>
> $ ./perf stat -M TopdownL1 ~/pmu/pmu-tools/workloads/BC1s
>
>   Performance counter stats for '/home/ak/pmu/pmu-tools/workloads/BC1s':
>
>         608,066,701      INT_MISC.RECOVERY_CYCLES         # 0.32
> Bad_Speculation          (50.02%)
>       5,364,230,382      CPU_CLK_UNHALTED.THREAD          # 0.48
> Retiring                 (50.02%)
>      10,194,062,626 UOPS_RETIRED.RETIRE_SLOTS (50.02%)
>      14,613,100,390 UOPS_ISSUED.ANY (50.02%)
>       2,928,793,077      IDQ_UOPS_NOT_DELIVERED.CORE      # 0.14
> Frontend_Bound
>                                                    #     0.07
> Backend_Bound            (50.02%)
>         604,850,703 INT_MISC.RECOVERY_CYCLES (50.02%)
>       5,357,291,185 CPU_CLK_UNHALTED.THREAD (50.02%)
>      14,618,285,580 UOPS_ISSUED.ANY (50.02%)

Did you build Arnaldo's perf/core branch with the changes applied? The
metric values here should be tma_bad_speculation, tma_retiring,
tma_frontend_bound, tma_backend_bound.

Looking at:
https://lore.kernel.org/lkml/20221004021612.325521-22-irogers@google.com/

+        "MetricExpr": "1 - tma_frontend_bound - (UOPS_ISSUED.ANY + 4
* ((INT_MISC.RECOVERY_CYCLES_ANY / 2) if #SMT_on else
INT_MISC.RECOVERY_CYCLES)) / SLOTS",
+        "MetricGroup": "TopdownL1;tma_L1_group",
+        "MetricName": "tma_backend_bound",
+        "PublicDescription": "This category represents fraction of
slots where no uops are being delivered due to a lack of required
resources for accepting new uops in the Backend. Backend is the
portion of the processor core where the out-of-order scheduler
dispatches ready uops into their respective execution units; and once
completed these uops get retired according to program order. For
example; stalls due to data-cache misses or stalls due to the divider
unit being overloaded are both categorized under Backend Bound.
Backend Bound is further divided into two main categories: Memory
Bound and Core Bound.",
+        "ScaleUnit": "100%"

So it wouldn't make sense to me that the scale was missing. Fwiw, I
did test on SkylakeX but used Tigerlake for the wiki due to potential
clock domain issues with SLOTS.

> Then if I follow the wiki example here I would expect I need to do
>
> $ ./perf stat -M tma_backend_bound_group ~/pmu/pmu-tools/workloads/BC1s
>
> Cannot find metric or group `tma_backend_bound_group'
>
> but tma_retiring_group doesn't exist. So it seems the methodology isn't
> fully consistent everywhere? Perhaps the wiki needs to document the
> supported CPUs and also what part of the hierarchy is supported.

So I think you've not got Arnaldo's branch with the changes applied.
Unfortunately the instructions around '_group' are only going to apply
to Linux 6.1.

> Another problem I noticed in the example is that the sample event didn't
> specify PEBS, even though it probably should at least on Icelake+ where
> every event can be used with less over with PEBS.

The 'Sample with' text is just text for a description. We can change
it or put something on the wiki, what would you suggest?

> Also with all these groups that need to be specified by hand some bash
> completion support for groups would be really useful)

Ack. My expectation is that everyone starts with TopdownL1 and goes
from there adding '_group' to the metric they want to drill into.
There are 104 topdown metrics and I'm not sure how useful expanding
all of these would be. On Icelake+ this becomes muddy due to the
unconditional printing of topdown metrics in the midst of the
regularly computed metrics, this can be seen on the wiki.
https://perf.wiki.kernel.org/index.php/Top-Down_Analysis
For example, when the level 2 metric group tma_backend_bound_group is
given the level 1 metrics Retiring, Frontend Bound, Backend Bound and
Bad Speculation are displayed.

Thanks,
Ian

> -Andi
>
>
