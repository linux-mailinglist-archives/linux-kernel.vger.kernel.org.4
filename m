Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D5FF6F4B02
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 22:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbjEBUJ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 16:09:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbjEBUJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 16:09:54 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A188D19B3
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 13:09:52 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id e9e14a558f8ab-32f4e0f42a7so151765ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 May 2023 13:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683058192; x=1685650192;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=813DkMObVqAM93FFVGWHCCH8FioK14LS5zdDr6BTj+E=;
        b=cVkde0VGivBrUYaejgu8ZwEzjZzdCv8XscNE1zxihTCtyTI0zFWw8/OzNlS0Dbu058
         8BSnSbUjxGlo4P4lSdJNtMpVbjB0Zca3vycKWBz1Lox9WKh507yA9cXnJoPPuvWSMex7
         ELj16xq6hCgMI56ZdU500t4N8smU+oyF5JU/s9vyaHNAwO1jsyfaMxY6W4oRFTv69wUw
         aLbFp/jFV12V2f1mgpHKBsj/JEO02gssz9BKxoDp6rBx85vOtY46KlKw/AkpdPAVkVC2
         T2aGL096XyISN13XS+SWE489dZb0hrteWMumdXlsk/NdU8GB5eeQkCnMrQ5M73Q6KERf
         cZmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683058192; x=1685650192;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=813DkMObVqAM93FFVGWHCCH8FioK14LS5zdDr6BTj+E=;
        b=LQ7NEQa/X/3584r2IJH4Plou6i09Ps7Cn9RQCUm27IoT5dYLDphSvP8QRL6C8gOfLv
         xIrjiZxVFQUOYnRP1nbr4tsTf3h/pVI1NP36WQ1cSuNU8KvS2rmqTmsrjYfHvnlK4Jx1
         4qczZrEI6zYiFD4fFc33xH3s+S/sQ8MbIzDtRMw1KY8o4LQRlDRPudGALJZXeuxt4RgN
         QcyBYwi+M4R/WQNmHPTHnKWV9oBL9Sb51C/JW0hEyXwF59WIQlqtWaKnmMVY17+wORV8
         S8GlJ4rDf+eBfobPnNfcqIG8/vo2Oo2zTgprl9VR1a562ziY10O+MJPh/dGxvXEiKKOA
         NiVQ==
X-Gm-Message-State: AC+VfDzpVr69VGLsI1mZh8FDp5d8PJ/3xTZDy5fmR3xOZYUTanFILWir
        Omut3zojx3ALQJnC92GLiSibVUFdOqGT2LHuUqp01g==
X-Google-Smtp-Source: ACHHUZ4Q3i+mCqTUQgzum2pwURp+OqBha0yZh50wmkHPi2KfD+PQuKICDnLb7L7UbqiSnERIxYcdM5b4hiof8m3FmLc=
X-Received: by 2002:a05:6e02:1aa7:b0:32f:7715:4482 with SMTP id
 l7-20020a056e021aa700b0032f77154482mr74904ilv.4.1683058191787; Tue, 02 May
 2023 13:09:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230429053506.1962559-1-irogers@google.com> <20230429053506.1962559-33-irogers@google.com>
 <a5153c87-044a-655d-acb4-aff9c33ab686@amd.com>
In-Reply-To: <a5153c87-044a-655d-acb4-aff9c33ab686@amd.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 2 May 2023 13:09:40 -0700
Message-ID: <CAP-5=fW28bBVuTbpF_5bwHw39=Kct5w1UjjBuVeLe_o+-6AWXA@mail.gmail.com>
Subject: Re: [PATCH v3 32/46] perf stat: Make cputype filter generic
To:     Ravi Bangoria <ravi.bangoria@amd.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
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
        Leo Yan <leo.yan@linaro.org>,
        Yang Jihong <yangjihong1@huawei.com>,
        James Clark <james.clark@arm.com>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        Kang Minchul <tegongkang@gmail.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 2, 2023 at 3:52=E2=80=AFAM Ravi Bangoria <ravi.bangoria@amd.com=
> wrote:
>
> On 29-Apr-23 11:04 AM, Ian Rogers wrote:
> > Rather than limit the --cputype argument for "perf list" and "perf
> > stat" to hybrid PMUs of just cpu_atom and cpu_core, allow any PMU.
>
> I've couple of doubts:
>
> 1. Can you please explain intention to do this esp for perf list. Since, =
IIUC,
>    `perf list --unit` option provide the same functionality.

I agree with you. The option already exists and I think we should just
move this option to being deprecated/hidden:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/too=
ls/lib/subcmd/parse-options.h#n46

> 2. Since we are already specifying pmu name for non-standerd/arch-specifi=
c
>    events like `pmu/attributes/`, I'm not sure where `perf stat --cputype=
=3Dpmu`
>    is useful. Can you please explain perf stat usability aspect for non-h=
ybrid
>    pmus.

Completely agreed. This patch series is trying to remove the
duplicated code introduced by the hybrid changes. In this case I
didn't want to remove an option, and potentially break users of that
option, as part of fixing things up. A lot of what you are saying here
I added as comments to the original patch series.

> 3. What am I missing here:
>
>    $ sudo ./perf stat --cputype=3Damd_df -e amd_l3/event=3D0x4,umask=3D0x=
ff/ -C 0 -- sleep 1
>     Performance counter stats for 'CPU(s) 0':
>
>            108,267      amd_l3/event=3D0x4,umask=3D0xff/
>
>        1.061290167 seconds time elapsed

The cputype applies to wildcard-ed events. So on hybrid:
$ perf stat -e cycles true
will open cycles on cpu_atom and cpu_core, the
parse_events__filter_pmu function is used skip PMUs based on cputype.

> 3. Also, IMHO, using --cputype option to specify _pmu name_ is bit odd.

Right, when the "feature" was added I would have preferred it as PMU
rather than CPU.

> >
> > Note, that if cpu_atom isn't mounted but a filter of cpu_atom is
> > requested, then this will now fail. As such a filter would never
> > succeed, no events can come from that unmounted PMU, then this
> > behavior could never have been useful and failing is clearer.
>
> I'm hitting a segfault if I use non-existing pmu:
>
> $ sudo ./perf list --cputype=3Drandom
> WARNING: cputype is not supported!
> Segmentation fault

Will fix in v4. The warning should be fatal/exit rather than try to
read the PMU's name.

Thanks,
Ian

> > @@ -443,8 +443,8 @@ int cmd_list(int argc, const char **argv)
> >                           "Print information on the perf event names an=
d expressions used internally by events."),
> >               OPT_BOOLEAN(0, "deprecated", &default_ps.deprecated,
> >                           "Print deprecated events."),
> > -             OPT_STRING(0, "cputype", &hybrid_name, "hybrid cpu type",
> > -                        "Limit PMU or metric printing to the given hyb=
rid PMU (e.g. core or atom)."),
> > +             OPT_STRING(0, "cputype", &cputype, "cpu type",
> > +                        "Limit PMU or metric printing to the given PMU=
 (e.g. cpu, core or atom)."),
>
> man perf-list does not describe --cputype. I think we should add it as pa=
rt
> of this patch?
>
> Similarly, man perf-stat also needs to be updated.
>
>
> > +const struct perf_pmu *perf_pmus__pmu_for_pmu_filter(const char *str)
> > +{
> > +     struct perf_pmu *pmu =3D NULL;
> > +
> > +     while ((pmu =3D perf_pmu__scan(pmu)) !=3D NULL) {
> > +             if (!strcmp(pmu->name, str))
> > +                     return pmu;
> > +             /* Ignore "uncore_" prefix. */
> > +             if (!strncmp(pmu->name, "uncore_", 7)) {
> > +                     if (!strcmp(pmu->name + 7, str))
> > +                             return pmu;
>
> Any specific reason to ignore "uncore_"? IMHO, ignoring prefix of some
> pmus and not of others is bit confusing for naive user.
