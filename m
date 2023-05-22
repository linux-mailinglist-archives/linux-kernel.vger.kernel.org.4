Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69E4D70B491
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 07:31:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231625AbjEVFa5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 01:30:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjEVFay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 01:30:54 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27626AA
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 22:30:53 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id e9e14a558f8ab-33828a86ee2so255595ab.0
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 22:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684733452; x=1687325452;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QcdvohU0f2w+fIMIX4DbPiChuLXgbqb9UEE/pNtU84k=;
        b=6N8KkioYqaNwktef6Iq8E5OZXCmKbj1txma/kt5JIFjoTBgLmhUyqho/o6d1DY9PMi
         /Gqat1eCV+T88xSdtMX9+zK4vQFfYdY18H8uyte14d9SVQ5fVhfwve/W05l3TbR3Mg7S
         hUV/HYC0LWDD0V/jwvyDYk2uxpUqU5NoduKYg/PZISq+U1849p0A+CLMKFg95+7H7leb
         XeDeQIkDrqAxJVQ0aOZAiaq/OSNCwdInkHBw/gi4LoI/QGpR0PUtTGUbgMiXwQ0p/2b9
         hJxe3oaVOzLYLUnQ9wdQzeWEksLNEnvks+TGSvXN1/DJyRTDm9rI3zOVGnwxiH+o/dnX
         z5Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684733452; x=1687325452;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QcdvohU0f2w+fIMIX4DbPiChuLXgbqb9UEE/pNtU84k=;
        b=YAXfQsMSVU9lhCduyF/gxf/exp3o4nLKS0hQrLyRmhi2W/ytsu2WuZ4I51UCbOdd0z
         KQSBO7+u4VT5So10j23tIz5ym+tMA/UvO/2vkYYP4+YqKK37rJgk3spIL7gyWutGBc3n
         qmEPz/xUawIzA/F5VaPjcpy90ucJOX0YDE/5TvvSPyHDwxS5D5DrQZdtkR9BlwqokXRZ
         N3Wrn9DR7ed9V9ALI/j4bEl4Yp6NAXxXRo+fuvjOhG1zRy1ZogmqFy/1eSNyiMYztzD8
         cHNMw6KfnbUvBqdSlgRw2pCOLO+afWWW1qCHIB30iQ2k89isXmpoAYL1wjvnYcRyNN6+
         ctdw==
X-Gm-Message-State: AC+VfDxDqabBtva3lPWyfeijKpndDuhcgEntG7M4uPwpRvpuHaurWvA1
        qQQI0H0T7ERGX6dJU1UEdgpXQxWeul3FLFSJpd+rcQ==
X-Google-Smtp-Source: ACHHUZ5aHxjgOROb+esLKY1PeiXeNdAKL5G4yO/Acvbmkrtd0rm5Ip7bPbLL4suDd4QhlbFlqRnwRoZbENEIyp37PCo=
X-Received: by 2002:a05:6e02:1a0a:b0:32a:f2a9:d1b7 with SMTP id
 s10-20020a056e021a0a00b0032af2a9d1b7mr783043ild.10.1684733452291; Sun, 21 May
 2023 22:30:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230517145803.559429-1-irogers@google.com> <20230517145803.559429-21-irogers@google.com>
 <efd8389a-aef1-96de-273a-ebac565cb852@linux.intel.com>
In-Reply-To: <efd8389a-aef1-96de-273a-ebac565cb852@linux.intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Sun, 21 May 2023 22:30:40 -0700
Message-ID: <CAP-5=fV5zgPs_VayVhMq-pu7C1A_QeFvbq=jtC04GBS9T4yV2w@mail.gmail.com>
Subject: Re: [PATCH v1 20/23] perf pmus: Split pmus list into core and uncore
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Ming Wang <wangming01@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>,
        Sandipan Das <sandipan.das@amd.com>,
        Dmitrii Dolgov <9erthalion6@gmail.com>,
        Sean Christopherson <seanjc@google.com>,
        Ali Saidi <alisaidi@amazon.com>, Rob Herring <robh@kernel.org>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Kang Minchul <tegongkang@gmail.com>,
        linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 21, 2023 at 1:07=E2=80=AFPM Liang, Kan <kan.liang@linux.intel.c=
om> wrote:
>
> On 2023-05-17 10:58 a.m., Ian Rogers wrote:
> > Split the pmus list into core and uncore. This will later allow for
> > the core and uncore pmus to be populated separately.
>
> I think the "uncore pmus" here means the other non-core PMUs, right? If
> so, I think the "uncore pmus" is misleading, since we have a dedicated
> uncore driver/PMU. Maybe we can use "other pmus" instead.
>
> Thanks,
> Kan

I'm okay with other PMUs. I'll change it in v2.

Thanks,
Ian

> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/util/pmus.c | 52 ++++++++++++++++++++++++++++++------------
> >  1 file changed, 38 insertions(+), 14 deletions(-)
> >
> > diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
> > index 2fb28e583366..dd029a810147 100644
> > --- a/tools/perf/util/pmus.c
> > +++ b/tools/perf/util/pmus.c
> > @@ -12,13 +12,19 @@
> >  #include "pmu.h"
> >  #include "print-events.h"
> >
> > -static LIST_HEAD(pmus);
> > +static LIST_HEAD(core_pmus);
> > +static LIST_HEAD(uncore_pmus);
> >
> >  void perf_pmus__destroy(void)
> >  {
> >       struct perf_pmu *pmu, *tmp;
> >
> > -     list_for_each_entry_safe(pmu, tmp, &pmus, list) {
> > +     list_for_each_entry_safe(pmu, tmp, &core_pmus, list) {
> > +             list_del(&pmu->list);
> > +
> > +             perf_pmu__delete(pmu);
> > +     }
> > +     list_for_each_entry_safe(pmu, tmp, &uncore_pmus, list) {
> >               list_del(&pmu->list);
> >
> >               perf_pmu__delete(pmu);
> > @@ -29,7 +35,12 @@ static struct perf_pmu *pmu_find(const char *name)
> >  {
> >       struct perf_pmu *pmu;
> >
> > -     list_for_each_entry(pmu, &pmus, list) {
> > +     list_for_each_entry(pmu, &core_pmus, list) {
> > +             if (!strcmp(pmu->name, name) ||
> > +                 (pmu->alias_name && !strcmp(pmu->alias_name, name)))
> > +                     return pmu;
> > +     }
> > +     list_for_each_entry(pmu, &uncore_pmus, list) {
> >               if (!strcmp(pmu->name, name) ||
> >                   (pmu->alias_name && !strcmp(pmu->alias_name, name)))
> >                       return pmu;
> > @@ -53,7 +64,7 @@ struct perf_pmu *perf_pmus__find(const char *name)
> >               return pmu;
> >
> >       dirfd =3D perf_pmu__event_source_devices_fd();
> > -     pmu =3D perf_pmu__lookup(&pmus, dirfd, name);
> > +     pmu =3D perf_pmu__lookup(is_pmu_core(name) ? &core_pmus : &uncore=
_pmus, dirfd, name);
> >       close(dirfd);
> >
> >       return pmu;
> > @@ -72,7 +83,7 @@ static struct perf_pmu *perf_pmu__find2(int dirfd, co=
nst char *name)
> >       if (pmu)
> >               return pmu;
> >
> > -     return perf_pmu__lookup(&pmus, dirfd, name);
> > +     return perf_pmu__lookup(is_pmu_core(name) ? &core_pmus : &uncore_=
pmus, dirfd, name);
> >  }
> >
> >  /* Add all pmus in sysfs to pmu list: */
> > @@ -93,7 +104,7 @@ static void pmu_read_sysfs(void)
> >       while ((dent =3D readdir(dir))) {
> >               if (!strcmp(dent->d_name, ".") || !strcmp(dent->d_name, "=
.."))
> >                       continue;
> > -             /* add to static LIST_HEAD(pmus): */
> > +             /* add to static LIST_HEAD(core_pmus) or LIST_HEAD(uncore=
_pmus): */
> >               perf_pmu__find2(fd, dent->d_name);
> >       }
> >
> > @@ -104,24 +115,37 @@ struct perf_pmu *perf_pmus__find_by_type(unsigned=
 int type)
> >  {
> >       struct perf_pmu *pmu;
> >
> > -     list_for_each_entry(pmu, &pmus, list)
> > +     list_for_each_entry(pmu, &core_pmus, list) {
> >               if (pmu->type =3D=3D type)
> >                       return pmu;
> > -
> > +     }
> > +     list_for_each_entry(pmu, &uncore_pmus, list) {
> > +             if (pmu->type =3D=3D type)
> > +                     return pmu;
> > +     }
> >       return NULL;
> >  }
> >
> > +/*
> > + * pmu iterator: If pmu is NULL, we start at the begin, otherwise retu=
rn the
> > + * next pmu. Returns NULL on end.
> > + */
> >  struct perf_pmu *perf_pmus__scan(struct perf_pmu *pmu)
> >  {
> > -     /*
> > -      * pmu iterator: If pmu is NULL, we start at the begin,
> > -      * otherwise return the next pmu. Returns NULL on end.
> > -      */
> > +     bool use_core_pmus =3D !pmu || pmu->is_core;
> > +
> >       if (!pmu) {
> >               pmu_read_sysfs();
> > -             pmu =3D list_prepare_entry(pmu, &pmus, list);
> > +             pmu =3D list_prepare_entry(pmu, &core_pmus, list);
> > +     }
> > +     if (use_core_pmus) {
> > +             list_for_each_entry_continue(pmu, &core_pmus, list)
> > +                     return pmu;
> > +
> > +             pmu =3D NULL;
> > +             pmu =3D list_prepare_entry(pmu, &uncore_pmus, list);
> >       }
> > -     list_for_each_entry_continue(pmu, &pmus, list)
> > +     list_for_each_entry_continue(pmu, &uncore_pmus, list)
> >               return pmu;
> >       return NULL;
> >  }
