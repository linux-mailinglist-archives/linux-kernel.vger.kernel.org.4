Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0DAC6B13BC
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 22:23:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbjCHVXV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 16:23:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbjCHVXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 16:23:17 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3C0157D02
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 13:23:06 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id q16so16723056wrw.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 13:23:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678310585;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zyyo5lSuTDuD+6bmoTgfWdbRKpvTfKz50pwNyACh4+g=;
        b=Bo4aWgu9MuXl6rTodtgo+ravQewBrDG6SLsATYO5mJIPR3j5GVXMM8t2O1aHf432Y2
         z1HOA2hRzbgnhM1Lss9YuTH3ZyozieyRS/DrF4Jp8FYj6mY59lQejoAoHEcm41mqhnDM
         dsgMwCiuoFQvsiNLtSumUj1OT13Ot8YCJXAKKvwZncnucLeKWf2FM6MXNXs+tGPPU7Sq
         piPFENK86DlcSB1xyfzHFO+oasvJrYeV6ryUdVKYOeyom7nNtk/b/b1xDiHo8KEdlL4N
         jQ1cV2AW6Xj7tPcZ3WjG8aoXxQMhbs1WEm70fy3dNjx7wUemccQGkkZLTtZfh/Wu6DmL
         JTpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678310585;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zyyo5lSuTDuD+6bmoTgfWdbRKpvTfKz50pwNyACh4+g=;
        b=BKoecgJMiZF0wxwn+Cb0PMU5WMXxnl79vnEYVChsC+r4+0ea5nxB5+hty4GWjfGoC2
         WJ7hKh2nOVKrFdLxuhxhFUNuhBox8QYMrxApd2UQXouX8VFZh7/9yvqmcy1AZ15y7zp5
         e4g1XL1UOjIA1BKpcLd19wmhsSZ/Ur+4phhU5Z/8BkqwRGa7CKxBKJ3MFJ3Nq8JXpLc4
         9b3t8NP6pazhD+FGgM5Hi9xAzGiJeyxsHAEKC/MrBKIAwPp0iSR7bzwEZLY2v4Xn3+Z0
         sKXYW+7hgUBEIjXKkn0FygTPHalIfR5jzTfzSeVnjd1Uj3Q81XkYZ7ntL4dx+DSis9Pu
         Y9Hg==
X-Gm-Message-State: AO0yUKWCSahF79rnR2hPJXGfzUXN3fblbpwsl23Prqa5Bl0ZYt2tzHuS
        K+JLErjrTIi71lY9hJU2PHt38Hy91tLspbPj632pbg==
X-Google-Smtp-Source: AK7set93A+CVsXNGoLx02VG2DB2cqwnGQxI8JlHKcxIerGx8cl6mL7KI35ZbCeKFMVY0eKQ3bHJ3ZGGR1yCl4jDQlAo=
X-Received: by 2002:a5d:608a:0:b0:2c8:2cbc:7a2e with SMTP id
 w10-20020a5d608a000000b002c82cbc7a2emr3853880wrt.4.1678310585092; Wed, 08 Mar
 2023 13:23:05 -0800 (PST)
MIME-Version: 1.0
References: <20230308081731.1887278-1-irogers@google.com> <20230308081731.1887278-4-irogers@google.com>
 <a39b7055-3fde-b351-89af-525d4f5ccee6@linux.intel.com>
In-Reply-To: <a39b7055-3fde-b351-89af-525d4f5ccee6@linux.intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 8 Mar 2023 13:22:52 -0800
Message-ID: <CAP-5=fXJ7zDvb9h+yT+o1qDPT9znsuaey0Ym=RJGtzvYJG8roA@mail.gmail.com>
Subject: Re: [PATCH v3 03/11] perf record: Early auxtrace initialization
 before event parsing
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        "Steinar H. Gunderson" <sesse@google.com>,
        Qi Liu <liuqi115@huawei.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        James Clark <james.clark@arm.com>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        Sean Christopherson <seanjc@google.com>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.g.garry@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
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

On Wed, Mar 8, 2023 at 12:32=E2=80=AFPM Liang, Kan <kan.liang@linux.intel.c=
om> wrote:
>
>
>
> On 2023-03-08 3:17 a.m., Ian Rogers wrote:
> > This allows event parsing to use the evsel__is_aux_event function,
> > which is important when determining event grouping.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/arch/x86/util/auxtrace.c | 17 +++++++++++++----
> >  tools/perf/builtin-record.c         |  6 ++++++
> >  tools/perf/util/auxtrace.h          |  2 ++
> >  3 files changed, 21 insertions(+), 4 deletions(-)
> >
> > diff --git a/tools/perf/arch/x86/util/auxtrace.c b/tools/perf/arch/x86/=
util/auxtrace.c
> > index 3da506e13f49..de1e4842ea2e 100644
> > --- a/tools/perf/arch/x86/util/auxtrace.c
> > +++ b/tools/perf/arch/x86/util/auxtrace.c
> > @@ -15,6 +15,19 @@
> >  #include "../../../util/intel-bts.h"
> >  #include "../../../util/evlist.h"
> >
> > +void auxtrace__early_init(void)
> > +{
> > +     struct perf_pmu *intel_pt_pmu;
> > +     struct perf_pmu *intel_bts_pmu;
> > +
> > +     intel_pt_pmu =3D perf_pmu__find(INTEL_PT_PMU_NAME);
> > +     if (intel_pt_pmu)
> > +             intel_pt_pmu->auxtrace =3D true;
> > +     intel_bts_pmu =3D perf_pmu__find(INTEL_BTS_PMU_NAME);
> > +     if (intel_bts_pmu)
> > +             intel_bts_pmu->auxtrace =3D true;
> > +}
> > +
> >  static
> >  struct auxtrace_record *auxtrace_record__init_intel(struct evlist *evl=
ist,
> >                                                   int *err)
> > @@ -26,11 +39,7 @@ struct auxtrace_record *auxtrace_record__init_intel(=
struct evlist *evlist,
> >       bool found_bts =3D false;
> >
> >       intel_pt_pmu =3D perf_pmu__find(INTEL_PT_PMU_NAME);
> > -     if (intel_pt_pmu)
> > -             intel_pt_pmu->auxtrace =3D true;
> >       intel_bts_pmu =3D perf_pmu__find(INTEL_BTS_PMU_NAME);
> > -     if (intel_bts_pmu)
> > -             intel_bts_pmu->auxtrace =3D true;
> >
> >       evlist__for_each_entry(evlist, evsel) {
> >               if (intel_pt_pmu && evsel->core.attr.type =3D=3D intel_pt=
_pmu->type)
> > diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> > index 8374117e66f6..a0870c076dc0 100644
> > --- a/tools/perf/builtin-record.c
> > +++ b/tools/perf/builtin-record.c
> > @@ -3940,6 +3940,10 @@ static int record__init_thread_masks(struct reco=
rd *rec)
> >       return ret;
> >  }
> >
> > +__weak void auxtrace__early_init(void)
> > +{
> > +}
> > +
>
> Does the method which Adrian suggested work for you?
>
> https://lore.kernel.org/lkml/9788f0f1-087f-7f0b-048a-0146afe1f632@intel.c=
om/
>
> With that, we don't need to introduce another weak function.
>
> Thanks,
> Kan

Thanks Kan,

that works and I'm not sure how I missed Adrian's e-mail. I'll put it into =
v4.

Ian

>
> >  int cmd_record(int argc, const char **argv)
> >  {
> >       int err;
> > @@ -3985,6 +3989,8 @@ int cmd_record(int argc, const char **argv)
> >       if (err)
> >               return err;
> >
> > +     auxtrace__early_init();
> > +
> >       argc =3D parse_options(argc, argv, record_options, record_usage,
> >                           PARSE_OPT_STOP_AT_NON_OPTION);
> >       if (quiet)
> > diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
> > index 29eb82dff574..49a86aa6ac94 100644
> > --- a/tools/perf/util/auxtrace.h
> > +++ b/tools/perf/util/auxtrace.h
> > @@ -457,6 +457,8 @@ struct addr_filters {
> >
> >  struct auxtrace_cache;
> >
> > +void auxtrace__early_init(void);
> > +
> >  #ifdef HAVE_AUXTRACE_SUPPORT
> >
> >  u64 compat_auxtrace_mmap__read_head(struct auxtrace_mmap *mm);
