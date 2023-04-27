Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A26476F0D10
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 22:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344231AbjD0UYH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 16:24:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344215AbjD0UYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 16:24:04 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20C421993
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 13:24:03 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id d75a77b69052e-3ef36d814a5so819221cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 13:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682627042; x=1685219042;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kj7mX16UBRhDPmlEut7HTPAM0sSWs+YXki+LAoqIX7E=;
        b=eH6ewRn/ILP8n0TExs59jAIZxX3LCQuqiOcdy7Dbt+tZz5+ZmwCbUnOko+nhlAKVXB
         q7q2l6L1LCvxAWB2/EFwnezw7LT2+I8YTCobv7bXDpaAsnVknK4NYWhf/zBs3/hkrIHG
         WgBw4G9e8cuFDI2qs4w0wy9mmuvJckNWZ4zhHTOvX9DNAbcb0jim2q1chLm0Pffpue0E
         Qukx+por2CiLdJDMGglqJSOUdiyjfOfEt8XXRsbfsHIM5wzUa6Tp7qp4k7V/34nEYEpg
         U9w1D5oKEtnuXA1AXNbZsfyuPbE4Ye29qpNr0p5ooMs1lAqEMWo3An5I8daYEis8gjDi
         9bHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682627042; x=1685219042;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kj7mX16UBRhDPmlEut7HTPAM0sSWs+YXki+LAoqIX7E=;
        b=Tg+gG5uTpiRpG8QSELHgu4PT+S7iB2bppaqg0uPXv5Ae/Jot8JdKgwG7GI6RxvlvMH
         CXW34w4rzghNVUIov2UhhSlr1oZwgULm6tzp9pPOgzCt82FwwoBntbFViI93bC5s8uDK
         bvKaRJPBju2hDsj3lfbrubP4Tsg5tqTMCBC/yjegXZHvrWcLhSTINjLTcCd4CRrdD9Vt
         WnVEz5bQTe3FMd7kzvISgGt2lQ2XhLaauMgZcTimwBW+FURXM0vB6FzQq/iwCf2CAcdh
         JX5DXhif0b1BcFK85cgLuq6FlAQhlzL/RMgxHVAzTQfeZtiO9oS4KbvbGpNHySNCzitY
         smEg==
X-Gm-Message-State: AC+VfDyTtBT4NExPh99sR6s2rp7fmUSQVmT8lp76iEqgwtPcmcKvBooB
        7OWg09Q6vSSoZ0uUy5HtiRUITPFafOYygOu+lE2FaA==
X-Google-Smtp-Source: ACHHUZ5kw56fWD56+VEzyPaLEd9MIGViOce64X3qCS9sLyT0+DSoJsdNdeAhRy5Pu748YWGd4h1nOIgwQ9tY2H/VqyU=
X-Received: by 2002:a05:622a:198b:b0:3f1:7f39:593b with SMTP id
 u11-20020a05622a198b00b003f17f39593bmr63203qtc.13.1682627041908; Thu, 27 Apr
 2023 13:24:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230426070050.1315519-1-irogers@google.com> <20230426070050.1315519-9-irogers@google.com>
 <05b7b1cf-0b77-0e0f-8d02-1c26016fa7d8@linux.intel.com>
In-Reply-To: <05b7b1cf-0b77-0e0f-8d02-1c26016fa7d8@linux.intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 27 Apr 2023 13:23:50 -0700
Message-ID: <CAP-5=fVOY_Mq8gC236ThApJ7G7ZfjRuY4RJGGMixOqMkaRWxnQ@mail.gmail.com>
Subject: Re: [PATCH v1 08/40] perf test: Test more sysfs events
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
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
        Ravi Bangoria <ravi.bangoria@amd.com>,
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

On Thu, Apr 27, 2023 at 12:39=E2=80=AFPM Liang, Kan <kan.liang@linux.intel.=
com> wrote:
>
>
>
> On 2023-04-26 3:00 a.m., Ian Rogers wrote:
> > Parse events for all PMUs, and not just cpu, in test "Parsing of all
> > PMU events from sysfs".
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
>
> Run the test on Cascade Lake and Alder Lake. It looks good.
>
> Tested-by: Kan Liang <kan.liang@linux.intel.com>

Arnaldo found an issue (strchr with an uninitialized value) that I
have a fix for in v2 of this. The bug got introduced by trying to
separate out the hybrid from the not hybrid changes.

Thanks,
Ian

> Thanks,
> Kan
> > ---
> >  tools/perf/tests/parse-events.c | 103 +++++++++++++++++---------------
> >  1 file changed, 55 insertions(+), 48 deletions(-)
> >
> > diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-e=
vents.c
> > index 8068cfd89b84..385bbbc4a409 100644
> > --- a/tools/perf/tests/parse-events.c
> > +++ b/tools/perf/tests/parse-events.c
> > @@ -7,6 +7,7 @@
> >  #include "debug.h"
> >  #include "pmu.h"
> >  #include "pmu-hybrid.h"
> > +#include "pmus.h"
> >  #include <dirent.h>
> >  #include <errno.h>
> >  #include "fncache.h"
> > @@ -2225,49 +2226,24 @@ static int test_pmu(void)
> >
> >  static int test__pmu_events(struct test_suite *test __maybe_unused, in=
t subtest __maybe_unused)
> >  {
> > -     struct stat st;
> > -     char path[PATH_MAX];
> > -     struct dirent *ent;
> > -     DIR *dir;
> > -     int ret;
> > -
> > -     if (!test_pmu())
> > -             return TEST_SKIP;
> > -
> > -     snprintf(path, PATH_MAX, "%s/bus/event_source/devices/cpu/events/=
",
> > -              sysfs__mountpoint());
> > -
> > -     ret =3D stat(path, &st);
> > -     if (ret) {
> > -             pr_debug("omitting PMU cpu events tests: %s\n", path);
> > -             return TEST_OK;
> > -     }
> > +     struct perf_pmu *pmu;
> > +     int ret =3D TEST_OK;
> >
> > -     dir =3D opendir(path);
> > -     if (!dir) {
> > -             pr_debug("can't open pmu event dir: %s\n", path);
> > -             return TEST_FAIL;
> > -     }
> > +     perf_pmus__for_each_pmu(pmu) {
> > +             struct stat st;
> > +             char path[PATH_MAX];
> > +             struct dirent *ent;
> > +             DIR *dir;
> > +             int err;
> >
> > -     ret =3D TEST_OK;
> > -     while ((ent =3D readdir(dir))) {
> > -             struct evlist_test e =3D { .name =3D NULL, };
> > -             char name[2 * NAME_MAX + 1 + 12 + 3];
> > -             int test_ret;
> > +             snprintf(path, PATH_MAX, "%s/bus/event_source/devices/%s/=
events/",
> > +                     sysfs__mountpoint(), pmu->name);
> >
> > -             /* Names containing . are special and cannot be used dire=
ctly */
> > -             if (strchr(ent->d_name, '.'))
> > +             err =3D stat(path, &st);
> > +             if (err) {
> > +                     pr_debug("skipping PMU %s events tests: %s\n", pm=
u->name, path);
> > +                     ret =3D combine_test_results(ret, TEST_SKIP);
> >                       continue;
> > -
> > -             snprintf(name, sizeof(name), "cpu/event=3D%s/u", ent->d_n=
ame);
> > -
> > -             e.name  =3D name;
> > -             e.check =3D test__checkevent_pmu_events;
> > -
> > -             test_ret =3D test_event(&e);
> > -             if (test_ret !=3D TEST_OK) {
> > -                     pr_debug("Test PMU event failed for '%s'", name);
> > -                     ret =3D combine_test_results(ret, test_ret);
> >               }
> >               /*
> >                * Names containing '-' are recognized as prefixes and su=
ffixes
> > @@ -2282,17 +2258,48 @@ static int test__pmu_events(struct test_suite *=
test __maybe_unused, int subtest
> >               if (strchr(ent->d_name, '-'))
> >                       continue;
> >
> > -             snprintf(name, sizeof(name), "%s:u,cpu/event=3D%s/u", ent=
->d_name, ent->d_name);
> > -             e.name  =3D name;
> > -             e.check =3D test__checkevent_pmu_events_mix;
> > -             test_ret =3D test_event(&e);
> > -             if (test_ret !=3D TEST_OK) {
> > -                     pr_debug("Test PMU event failed for '%s'", name);
> > -                     ret =3D combine_test_results(ret, test_ret);
> > +             dir =3D opendir(path);
> > +             if (!dir) {
> > +                     pr_debug("can't open pmu event dir: %s\n", path);
> > +                     ret =3D combine_test_results(ret, TEST_SKIP);
> > +                     continue;
> >               }
> > -     }
> >
> > -     closedir(dir);
> > +             while ((ent =3D readdir(dir))) {
> > +                     struct evlist_test e =3D { .name =3D NULL, };
> > +                     char name[2 * NAME_MAX + 1 + 12 + 3];
> > +                     int test_ret;
> > +
> > +                     /* Names containing . are special and cannot be u=
sed directly */
> > +                     if (strchr(ent->d_name, '.'))
> > +                             continue;
> > +
> > +                     snprintf(name, sizeof(name), "%s/event=3D%s/u", p=
mu->name, ent->d_name);
> > +
> > +                     e.name  =3D name;
> > +                     e.check =3D test__checkevent_pmu_events;
> > +
> > +                     test_ret =3D test_event(&e);
> > +                     if (test_ret !=3D TEST_OK) {
> > +                             pr_debug("Test PMU event failed for '%s'"=
, name);
> > +                             ret =3D combine_test_results(ret, test_re=
t);
> > +                     }
> > +
> > +                     if (!is_pmu_core(pmu->name))
> > +                             continue;
> > +
> > +                     snprintf(name, sizeof(name), "%s:u,%s/event=3D%s/=
u", ent->d_name, pmu->name, ent->d_name);
> > +                     e.name  =3D name;
> > +                     e.check =3D test__checkevent_pmu_events_mix;
> > +                     test_ret =3D test_event(&e);
> > +                     if (test_ret !=3D TEST_OK) {
> > +                             pr_debug("Test PMU event failed for '%s'"=
, name);
> > +                             ret =3D combine_test_results(ret, test_re=
t);
> > +                     }
> > +             }
> > +
> > +             closedir(dir);
> > +     }
> >       return ret;
> >  }
> >
