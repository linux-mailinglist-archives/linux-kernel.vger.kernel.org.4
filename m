Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 748737132C5
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 08:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231627AbjE0GFp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 May 2023 02:05:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231582AbjE0GFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 May 2023 02:05:43 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61EAC189
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 23:05:40 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3f600a6a890so25575e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 23:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685167539; x=1687759539;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h+VqRQExtTrH9S+FZIicKy2SoxXeKIv5Pl5YKkb8yOU=;
        b=0aX8fI0SmbVTXsAjji1whY6LJ8jtL5lF0rCQz0h+106ZDqNGnd+zznZFBoRES0Gavs
         19AHNoWNmevaE1bGaGvFnOfqKtdKMDylrVGDzT02lgzOYNBsX/tCWC5cjd7UmfS9XW5/
         m/d/zhxUaZTF5O/q/J3xsJMYglPWxfHm9lMbT5pfZf/MMwBL77VusnKCo4oGQYgXNml0
         3HCAaPVnsA1d9lGFqtThfmAuQuPDGGa86NZcSG4KHBxXynESFjyyNj/h/bgrGKZPtjx7
         REcfiMtIBLbN1+9L4goesoiVv4LagFQAfmCizxmij273EoGT/ceuXq2igv1A0nMijdIX
         kz1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685167539; x=1687759539;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h+VqRQExtTrH9S+FZIicKy2SoxXeKIv5Pl5YKkb8yOU=;
        b=ZSBXzM1JCBEnq+DbnWS4htGoQmUhUpRoNc+9uHF4jufpDdUACHhOT2DHt35sKBJ8Ro
         Tdj+RfxKWGa60yx0mi+dmEumEirShHy4ECA1CdPrS1yNNyHpXvkN6+rTr+eNdRv3bcG7
         ZQy7CNG/V9GZqpy1Meo6TTZO8VzC41EBWQmoeF/Mx0uhSig0nvKqVy9zN8xhvxdHbeQK
         TXm/Ra0FC8oyxFHb+YFuVoVmWJGTuuhkjgtCbXIsL3yiKKJi3SLgM+8dYElnxAZ1YKAf
         ELQTcFCiLySoMbk5lcg/CdtiUEa4wioWafHP4i87urPQxTozAhlk+8j0yhx4RtaQ7mfx
         FUsQ==
X-Gm-Message-State: AC+VfDzTVPzAQM66zjVYjeGygfo7M4BjAUPtGyiKmKWc7XeU7vZzDJwB
        LY8rHfnYnifoDebyh+cAFX4cE31Id6t4La8NZ7ZbIg==
X-Google-Smtp-Source: ACHHUZ6H+Busoinm6NiPQ0cJPOPkyYSQt0m+kJyVmjqmN3/IvUGJzwl1XDEwh9hZej5CuP36g4gCGAeED2POqCRVRTY=
X-Received: by 2002:a1c:5408:0:b0:3f1:758c:dd23 with SMTP id
 i8-20020a1c5408000000b003f1758cdd23mr63579wmb.7.1685167538607; Fri, 26 May
 2023 23:05:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230526215410.2435674-1-irogers@google.com> <20230526215410.2435674-4-irogers@google.com>
 <ZHFdnEpNMKq7EbWh@kernel.org> <ZHFffgMt1fHzbc55@kernel.org>
In-Reply-To: <ZHFffgMt1fHzbc55@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 26 May 2023 23:05:25 -0700
Message-ID: <CAP-5=fUEd9tRnnqzRogz5CUD8OZJMLE8kEcvROiYo4FEXzv8HQ@mail.gmail.com>
Subject: Re: [PATCH v4 03/35] perf cpumap: Add equal function
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 26, 2023 at 6:40=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Fri, May 26, 2023 at 10:32:12PM -0300, Arnaldo Carvalho de Melo escrev=
eu:
> > Em Fri, May 26, 2023 at 02:53:38PM -0700, Ian Rogers escreveu:
> > > Equality is a useful property to compare after merging and
> > > intersecting maps.
> > >
> > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
> > > ---
> > >  tools/lib/perf/cpumap.c              | 21 ++++++++++++++++
> > >  tools/lib/perf/include/perf/cpumap.h |  2 ++
> > >  tools/perf/tests/cpumap.c            | 37 ++++++++++++++++++++++++++=
++
> > >  3 files changed, 60 insertions(+)
> > >
> > > diff --git a/tools/lib/perf/cpumap.c b/tools/lib/perf/cpumap.c
> > > index d4f3a1a12522..48595a3ad69c 100644
> > > --- a/tools/lib/perf/cpumap.c
> > > +++ b/tools/lib/perf/cpumap.c
> > > @@ -321,6 +321,27 @@ bool perf_cpu_map__has(const struct perf_cpu_map=
 *cpus, struct perf_cpu cpu)
> > >     return perf_cpu_map__idx(cpus, cpu) !=3D -1;
> > >  }
> > >
> > > +bool perf_cpu_map__equal(const struct perf_cpu_map *lhs, const struc=
t perf_cpu_map *rhs)
> > > +{
> > > +   int nr;
> > > +
> > > +   if (lhs =3D=3D rhs)
> > > +           return true;
> > > +
> > > +   if (!lhs || !rhs)
> > > +           return false;
> > > +
> > > +   nr =3D perf_cpu_map__nr(lhs);
> > > +   if (nr !=3D perf_cpu_map__nr(rhs))
> > > +           return false;
> > > +
> > > +   for (int idx =3D 0; idx < nr; idx++) {
> > > +           if (RC_CHK_ACCESS(lhs)->map[idx].cpu !=3D RC_CHK_ACCESS(r=
hs)->map[idx].cpu)
> > > +                   return false;
> >
> > Don't we have an accessor to avoid this RC_CHK_ACCESS()-> access?
>
>  In the following patch you use it:
>
> +bool perf_cpu_map__has_any_cpu(const struct perf_cpu_map *map)
> +{
> +       return map && perf_cpu_map__cpu(map, 0).cpu =3D=3D -1;
> +}
>
> But it does extra checks you did already:
>
> struct perf_cpu perf_cpu_map__cpu(const struct perf_cpu_map *cpus, int id=
x)
> {
>         struct perf_cpu result =3D {
>                 .cpu =3D -1
>         };
>
>         if (cpus && idx < RC_CHK_ACCESS(cpus)->nr)
>                 return RC_CHK_ACCESS(cpus)->map[idx];
>
>         return result;
> }
>
> Usually we have:
>
> struct perf_cpu __perf_cpu_map__cpu(const struct perf_cpu_map *cpus, int =
idx)
> {
>         return RC_CHK_ACCESS(cpus)->map[idx];
> }
>
> struct perf_cpu perf_cpu_map__cpu(const struct perf_cpu_map *cpus, int id=
x)
> {
>         struct perf_cpu result =3D {
>                 .cpu =3D -1
>         };
>
>         if (cpus && idx < __perf_cpu_map__nr(cpus))
>                 return __perf_cpu_map__cpu(cpus, idx);
>
>         return result;
> }
>
> Then you would have:
>
> bool perf_cpu_map__equal(const struct perf_cpu_map *lhs, const struct per=
f_cpu_map *rhs)
> {
>         int nr;
>
>         if (lhs =3D=3D rhs)
>                 return true;
>
>         if (!lhs || !rhs)
>                 return false;
>
>         nr =3D __perf_cpu_map__nr(lhs);  // no need to check lhs again fo=
r NULL
>         if (nr !=3D __perf_cpu_map__nr(rhs)) // ditto for rhs
>                 return false;
>
>         for (int idx =3D 0; idx < nr; idx++) {
>                 if (__perf_cpu_map__cpu(lhs, idx)->cpu !=3D __perf_cpu_ma=
p__cpu(rhs, idx)->cpu)
>                         return false;
>

Thanks, I'll update for v5. Fwiw, on intersect, I keep forgetting to
mention that this was sent previously as:
https://lore.kernel.org/lkml/20220408035616.1356953-4-irogers@google.com/

Ian

> > > +   }
> > > +   return true;
> > > +}
> > > +
> > >  struct perf_cpu perf_cpu_map__max(const struct perf_cpu_map *map)
> > >  {
> > >     struct perf_cpu result =3D {
> > > diff --git a/tools/lib/perf/include/perf/cpumap.h b/tools/lib/perf/in=
clude/perf/cpumap.h
> > > index 0466c4216fbb..d0ae9552f8e2 100644
> > > --- a/tools/lib/perf/include/perf/cpumap.h
> > > +++ b/tools/lib/perf/include/perf/cpumap.h
> > > @@ -28,6 +28,8 @@ LIBPERF_API int perf_cpu_map__nr(const struct perf_=
cpu_map *cpus);
> > >  LIBPERF_API bool perf_cpu_map__empty(const struct perf_cpu_map *map)=
;
> > >  LIBPERF_API struct perf_cpu perf_cpu_map__max(const struct perf_cpu_=
map *map);
> > >  LIBPERF_API bool perf_cpu_map__has(const struct perf_cpu_map *map, s=
truct perf_cpu cpu);
> > > +LIBPERF_API bool perf_cpu_map__equal(const struct perf_cpu_map *lhs,
> > > +                                const struct perf_cpu_map *rhs);
> > >
> > >  #define perf_cpu_map__for_each_cpu(cpu, idx, cpus)         \
> > >     for ((idx) =3D 0, (cpu) =3D perf_cpu_map__cpu(cpus, idx);   \
> > > diff --git a/tools/perf/tests/cpumap.c b/tools/perf/tests/cpumap.c
> > > index 83805690c209..7730fc2ab40b 100644
> > > --- a/tools/perf/tests/cpumap.c
> > > +++ b/tools/perf/tests/cpumap.c
> > > @@ -211,11 +211,48 @@ static int test__cpu_map_intersect(struct test_=
suite *test __maybe_unused,
> > >     return ret;
> > >  }
> > >
> > > +static int test__cpu_map_equal(struct test_suite *test __maybe_unuse=
d, int subtest __maybe_unused)
> > > +{
> > > +   struct perf_cpu_map *any =3D perf_cpu_map__dummy_new();
> > > +   struct perf_cpu_map *one =3D perf_cpu_map__new("1");
> > > +   struct perf_cpu_map *two =3D perf_cpu_map__new("2");
> > > +   struct perf_cpu_map *empty =3D perf_cpu_map__intersect(one, two);
> > > +   struct perf_cpu_map *pair =3D perf_cpu_map__new("1-2");
> > > +   struct perf_cpu_map *tmp;
> > > +   struct perf_cpu_map *maps[] =3D {empty, any, one, two, pair};
> > > +
> > > +   for (size_t i =3D 0; i < ARRAY_SIZE(maps); i++) {
> > > +           /* Maps equal themself. */
> > > +           TEST_ASSERT_VAL("equal", perf_cpu_map__equal(maps[i], map=
s[i]));
> > > +           for (size_t j =3D 0; j < ARRAY_SIZE(maps); j++) {
> > > +                   /* Maps dont't equal each other. */
> > > +                   if (i =3D=3D j)
> > > +                           continue;
> > > +                   TEST_ASSERT_VAL("not equal", !perf_cpu_map__equal=
(maps[i], maps[j]));
> > > +           }
> > > +   }
> > > +
> > > +   /* Maps equal made maps. */
> > > +   tmp =3D perf_cpu_map__merge(perf_cpu_map__get(one), two);
> > > +   TEST_ASSERT_VAL("pair", perf_cpu_map__equal(pair, tmp));
> > > +   perf_cpu_map__put(tmp);
> > > +
> > > +   tmp =3D perf_cpu_map__intersect(pair, one);
> > > +   TEST_ASSERT_VAL("one", perf_cpu_map__equal(one, tmp));
> > > +   perf_cpu_map__put(tmp);
> > > +
> > > +   for (size_t i =3D 0; i < ARRAY_SIZE(maps); i++)
> > > +           perf_cpu_map__put(maps[i]);
> > > +
> > > +   return TEST_OK;
> > > +}
> > > +
> > >  static struct test_case tests__cpu_map[] =3D {
> > >     TEST_CASE("Synthesize cpu map", cpu_map_synthesize),
> > >     TEST_CASE("Print cpu map", cpu_map_print),
> > >     TEST_CASE("Merge cpu map", cpu_map_merge),
> > >     TEST_CASE("Intersect cpu map", cpu_map_intersect),
> > > +   TEST_CASE("Equal cpu map", cpu_map_equal),
> > >     {       .name =3D NULL, }
> > >  };
> > >
> > > --
> > > 2.41.0.rc0.172.g3f132b7071-goog
> > >
> >
> > --
> >
> > - Arnaldo
>
> --
>
> - Arnaldo
