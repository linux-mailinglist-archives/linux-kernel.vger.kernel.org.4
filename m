Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CB84640EDC
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 21:05:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234685AbiLBUFV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 15:05:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233637AbiLBUFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 15:05:19 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 272A1EFD22
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 12:05:18 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id n7so4294036wms.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 12:05:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TiUU1kGDE18WkHjFu8u7TPR9Pw0MBeKZx33kkvUGDmw=;
        b=NgH8pUoWD1JoiRDTf1LN42P1y6eo8B9+Q3TLfBYToqYLyi5esgiLXCQ36R0GtxDQdP
         JX0LbmYfpxKoNzUGf6psAgvqAwplupXdkSSA70hf11Gbc7B44Tv0hOLfvuiwUT74W24W
         oVIXnG3BzsUI1lT2el9NM+nbifo+Vj1qdrRJ8F8vxanhJew++QjhGYvBL483RtgAAgb6
         YNc/6NL+Bthgb6XsbTGIssvrdMCqZ+Nz33CDayxa6iaFiXSKtqnVN2tOgkfP4f4TOKFe
         +s6p7lgeodGZp67nfnZIqlL7IegkniA7H28Q0wGbMVFScpbFaD6fTCInH8Q9z3Fffq+n
         S8aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TiUU1kGDE18WkHjFu8u7TPR9Pw0MBeKZx33kkvUGDmw=;
        b=n5IKdr7sptlBGsAh3Qb9GQbj4ONfhHiOsJ6tAkoIorq003/Xa0uPeQ+5b7Y4bdGYoP
         ejNWzrbG11gThn0wF3mR2vt0uMGciXEa/7++roJqqIJ38QBon/Ov11XOPIy1aMV9z/RP
         QlKOUPEt1YWK5EoWLaX00y8LyUoiBKAQonUARtkR94cQoEB/KUx5OrJ6PQqXNBSsb2Vg
         t4lBHDBNw68Mn4HqhMzSPJ+PM6xS2i5PlkmwqJFt80EDcdMkGW7tR0PGiLFJFStH+RSf
         kK93YI7RwCtFdRCYk4FXimNzErTV/8YmI+QbLB8ePWVzXurTf3d4EpI/TRZFyy0UMiLo
         crEQ==
X-Gm-Message-State: ANoB5plvkJ151dPabnCW5y5jjXRHYH9QkNJl+xWSRi0oW95EvcROICfW
        A0XZJ/seJhTrQyuTUwbiQQ/MMwcFDS2WwKJL8xcIWg==
X-Google-Smtp-Source: AA0mqf4Y9QTurlLEnVPt8qOsLHlYLi31FrfXvEF064i0oCya4m55AizJlhB0Lg+HxS60kCG5xUE8YIKWlWiSMPWz8mE=
X-Received: by 2002:a1c:7318:0:b0:3cf:cb16:f24a with SMTP id
 d24-20020a1c7318000000b003cfcb16f24amr55813272wmb.182.1670011516472; Fri, 02
 Dec 2022 12:05:16 -0800 (PST)
MIME-Version: 1.0
References: <1668411720-3581-1-git-send-email-renyu.zj@linux.alibaba.com>
 <1669310088-13482-1-git-send-email-renyu.zj@linux.alibaba.com>
 <1669310088-13482-6-git-send-email-renyu.zj@linux.alibaba.com>
 <CAP-5=fV0WSTK=MT6K2nqsqYT6xCTg7Pv_rXahHFeRhV0ZHCiEQ@mail.gmail.com> <1a7fc9da-2589-1835-716f-d52027f0ecda@linux.alibaba.com>
In-Reply-To: <1a7fc9da-2589-1835-716f-d52027f0ecda@linux.alibaba.com>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 2 Dec 2022 12:05:04 -0800
Message-ID: <CAP-5=fUT=u7N4GP9Y6r7dv5yTKtLqPYxYE73d7Rj8fXQ+YQidA@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] perf vendor events arm64: Add PE utilization
 metrics for neoverse-n2
To:     Jing Zhang <renyu.zj@linux.alibaba.com>
Cc:     John Garry <john.g.garry@oracle.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Andrew Kilroy <andrew.kilroy@arm.com>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Zhuo Song <zhuo.song@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Thu, Dec 1, 2022 at 3:08 AM Jing Zhang <renyu.zj@linux.alibaba.com> wrot=
e:
>
>
>
> =E5=9C=A8 2022/12/1 =E4=B8=8A=E5=8D=882:58, Ian Rogers =E5=86=99=E9=81=93=
:
> > On Thu, Nov 24, 2022 at 9:15 AM Jing Zhang <renyu.zj@linux.alibaba.com>=
 wrote:
> >>
> >> Add PE utilization related metrics.
> >>
> >> Signed-off-by: Jing Zhang <renyu.zj@linux.alibaba.com>
> >> ---
> >>  .../arch/arm64/arm/neoverse-n2/metrics.json        | 45 +++++++++++++=
+++++++++
> >>  1 file changed, 45 insertions(+)
> >>
> >> diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/metrics.=
json b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/metrics.json
> >> index 23c7d62..7b54819 100644
> >> --- a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/metrics.json
> >> +++ b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/metrics.json
> >> @@ -189,5 +189,50 @@
> >>          "MetricGroup": "Branch",
> >>          "MetricName": "branch_miss_pred_rate",
> >>          "ScaleUnit": "100%"
> >> +    },
> >> +    {
> >> +        "MetricExpr": "instructions / CPU_CYCLES",
> >> +        "PublicDescription": "The average number of instructions exec=
uted for each cycle.",
> >> +        "BriefDescription": "Instructions per cycle",
> >> +        "MetricGroup": "PEutilization",
> >> +        "MetricName": "ipc"
> >> +    },
> >
> > A related useful metric is percentage of peak, so if the peak IPC is 8
> > (usually a constant related to the number of functional units) then
> > you can just compute the ratio of IPC with this.
> >
>
> Glad to discuss these with you.
> The peak ipc value of neoverse-n2 is 5. Maybe I should add an ipc_rate me=
tric?
>
> >> +    {
> >> +        "MetricExpr": "INST_RETIRED / CPU_CYCLES",
> >> +        "PublicDescription": "Architecturally executed Instructions P=
er Cycle (IPC)",
> >> +        "BriefDescription": "Architecturally executed Instructions Pe=
r Cycle (IPC)",
> >
> >
> > The duplicated descriptions are unnecessary. Drop the public one for
> > consistency with what we do for Intel:
> > https://github.com/intel/perfmon/blob/main/scripts/create_perf_json.py#=
L299
> >
>
> Sounds good, will do.
>
> >> +        "MetricGroup": "PEutilization",
> >> +        "MetricName": "retired_ipc"
> >> +    },
> >> +    {
> >> +        "MetricExpr": "INST_SPEC / CPU_CYCLES",
> >> +        "PublicDescription": "Speculatively executed Instructions Per=
 Cycle (IPC)",
> >> +        "BriefDescription": "Speculatively executed Instructions Per =
Cycle (IPC)",
> >> +        "MetricGroup": "PEutilization",
> >> +        "MetricName": "spec_ipc"
> >> +    },
> >> +    {
> >> +        "MetricExpr": "OP_RETIRED / OP_SPEC",
> >> +        "PublicDescription": "Fraction of operations retired",
> >> +        "BriefDescription": "Fraction of operations retired",
> >
> > Would instructions be clearer than operations here?
> >
>
> operation and instruction are different. OP_RETIRED counts any operation =
(not instruction)
> that has been architecturally executed, For example, speculatively execut=
ed operations that
> have been abandoned for a branch mispredict will not be counted. So I thi=
nk operation might
> be more accurate.

Thanks, I see this note in the N2 PMU guide:

"""
For PMU event definitions, some events specifically count
instructions, while other events count micro-operations (which are
referred to as operations). Please be aware of the use of the word
"operations" or "instructions" in the event description.
"""

From your explanation I wasn't sure if operation was a superset of
instruction that included both retired and speculated ones, or whether
operation had another meaning. I don't see operation being used in the
micro-operation sense elsewhere in the ARM perf json, I think
micro-operation is more consistent and also clearer:
https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/p=
erf/pmu-events/arch/arm64/arm/cortex-a75/pipeline.json?h=3Dperf/core#n27

Perhaps the description can be something like:
Of all the micro-operations issued, what percentage were retired. A
lower number indicates bad speculation.

An alternate way to add documentation is the perf wiki's glossary:
https://perf.wiki.kernel.org/index.php/Glossary

I added the Neoverse N2 PMU Guide to:
https://perf.wiki.kernel.org/index.php/Useful_Links#Manuals

Thanks,
Ian

> >> +        "MetricGroup": "PEutilization",
> >> +        "MetricName": "retired_rate",
> >> +        "ScaleUnit": "100%"
> >> +    },
> >> +    {
> >> +        "MetricExpr": "1 - OP_RETIRED / OP_SPEC",
> >
> > Should OP_RETIRED be greater than OP_SPEC? In which case won't this
> > metric be negative?
> >
>
> OP_RETIRED will not be greater than OP_SPEC. OP_SPEC counts any operation=
 that has been
> speculatively executed. OP_SPEC is a superset of the OP_RETIRED event. Th=
ere is a
> description about OP_SPEC and OP_RETIRED in this neoverse-n2 document.
> Link: https://documentation-service.arm.com/static/62cfe21e31ea212bb66273=
93?token=3D
>
> >> +        "PublicDescription": "Fraction of operations wasted",
> >> +        "BriefDescription": "Fraction of operations wasted",
> >> +        "MetricGroup": "PEutilization",
> >> +        "MetricName": "wasted_rate",
> >> +        "ScaleUnit": "100%"
> >> +    },
> >> +    {
> >> +        "MetricExpr": "OP_RETIRED / OP_SPEC * (1 - (STALL_SLOT - CPU_=
CYCLES) / (CPU_CYCLES * 5))",
> >> +        "PublicDescription": "Utilization of CPU",
> >> +        "BriefDescription": "Utilization of CPU",
> >
> > Some more detail in the description would be useful.
> >
>
> Ok, I'll describe it in more detail. CPU_utilization reflects the truly e=
ffective ratio of operation
> executed by the CPU, which means that misprediction and stall are not inc=
luded. Note that stall_slot
> minus cpu_cycles is a correction to the stall_slot error count.
>
> >> +        "MetricGroup": "PEutilization",
> >> +        "MetricName": "cpu_utilization",
> >> +        "ScaleUnit": "100%"
> >>      }
> >>  ]
> >> --
> >> 1.8.3.1
> >>
