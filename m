Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E700712C79
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 20:33:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237572AbjEZSdb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 14:33:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236450AbjEZSd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 14:33:29 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 616E2134
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 11:33:27 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3f600a6a890so8995e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 11:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685126006; x=1687718006;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6JxMzvds2avNOsdPi6D0GZaG3j3Kl1uN/P97Wgte3QU=;
        b=7xxgvyNUGXl5HU9jjrwJr/FubM7qSVcguv9rPoQB4Iz9na0uCeBSJHUnYpn0FbxE4M
         2xbkZcJEOH/9oh5wezLYASGa6Rxx7XlxtBcKiIpbIXtvut1NGw0Pg6v553DULx9Gppgo
         nKiaa6JEY+L80L3vqLz+b76lq+YEAOi/dXWcitgBPMew+E5HFW48U4YLvAATM8gDrFYi
         K6bb7YJzUG9bZI3j6EF9DuSo8P1WswEByShxV85cYpJdWZfwjLgmuLX6JMxOHbVUGGI7
         N1vkWH60WDUPtHkf+SU8gqjnzbD85CYOTrtOaQCMQS3piCgblVQSVTDap55M2xr+SmM8
         5ZwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685126006; x=1687718006;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6JxMzvds2avNOsdPi6D0GZaG3j3Kl1uN/P97Wgte3QU=;
        b=T+pJkxtmbWKwLuRx6hjNhG9GakEmrnrEcQkOBP9uDn97ITGZP2U2nqbGYha6nsuRbU
         0b8s0o9ViP7IoRdCwKKvBsCPpL1Li/37fCpufqAxgBWHl7nOC3yzG1OlAgRNg0/Fc0MC
         MmG+DXnWcvE3NO5Q4TAGR7Hbe1XiBrnbPoregDg1xJi1+V+sFAQ8S7vQh/RC/G8livfZ
         7qTBzbfXALQTw11a69ZSd+FRG2yFt6Xx4wn6f2IRhrVhUfrrIDFiF1BkrPI5g3qmv0fz
         qTKVvePgV6jPxReQv1v5zjiLRfbW47lNZcifJoLWZyh5+13uUCt+DpwShrWMu8IJ/5P4
         woAQ==
X-Gm-Message-State: AC+VfDy1fGNSAZX/u4sQuZqa/zjyE46a1ykWdP+HUiZY8HJkxbK2oOiS
        Kcq4fQFMAaIgo7ixSaMjaTswu5nBWNVsTVYpjfTnlQ==
X-Google-Smtp-Source: ACHHUZ4Ht4O6eiX9Fvhjel4y4La3TeEMwH6xuB2HxJ1w7YnSgrBrraonrQVSiq0saRKb5PQDBjgaWsNxm+dPHOJnb6I=
X-Received: by 2002:a05:600c:314a:b0:3f5:f63:d490 with SMTP id
 h10-20020a05600c314a00b003f50f63d490mr14241wmo.5.1685126005614; Fri, 26 May
 2023 11:33:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230524221831.1741381-1-irogers@google.com> <20230524221831.1741381-17-irogers@google.com>
 <3d943607-645e-be8d-3a68-90e62e402c3d@linux.intel.com>
In-Reply-To: <3d943607-645e-be8d-3a68-90e62e402c3d@linux.intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 26 May 2023 11:33:13 -0700
Message-ID: <CAP-5=fWJXthOUF+ma1Z+MT2yfpA81did=-0hA3tREvAqNoAzww@mail.gmail.com>
Subject: Re: [PATCH v3 16/35] perf pmu: Remove perf_pmu__hybrid_mounted
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

On Fri, May 26, 2023 at 11:14=E2=80=AFAM Liang, Kan <kan.liang@linux.intel.=
com> wrote:
>
>
>
> On 2023-05-24 6:18 p.m., Ian Rogers wrote:
> > perf_pmu__hybrid_mounted is used to detect whether cpu_core or
> > cpu_atom is mounted with a non-empty cpus file by
> > pmu_lookup. pmu_lookup will attempt to read the cpus file too and so
> > the check can be folded into this.
> >
> > Checking hybrid_mounted in pmu_is_uncore is redundant as the next
> > cpumask read will fail returning false.
> >
> > Reduce the scope of perf_pmu__find_hybrid_pmu by making it static.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/util/pmu-hybrid.c | 15 +--------------
> >  tools/perf/util/pmu-hybrid.h |  3 ---
> >  tools/perf/util/pmu.c        | 26 ++++++++++++++------------
> >  3 files changed, 15 insertions(+), 29 deletions(-)
> >
> > diff --git a/tools/perf/util/pmu-hybrid.c b/tools/perf/util/pmu-hybrid.=
c
> > index bc4cb0738c35..7fe943dd3217 100644
> > --- a/tools/perf/util/pmu-hybrid.c
> > +++ b/tools/perf/util/pmu-hybrid.c
> > @@ -18,20 +18,7 @@
> >
> >  LIST_HEAD(perf_pmu__hybrid_pmus);
> >
> > -bool perf_pmu__hybrid_mounted(const char *name)
> > -{
> > -     int cpu;
> > -     char pmu_name[PATH_MAX];
> > -     struct perf_pmu pmu =3D {.name =3D pmu_name};
> > -
> > -     if (strncmp(name, "cpu_", 4))
> > -             return false;
> > -
> > -     strlcpy(pmu_name, name, sizeof(pmu_name));
> > -     return perf_pmu__scan_file(&pmu, "cpus", "%u", &cpu) > 0;
> > -}
> > -
> > -struct perf_pmu *perf_pmu__find_hybrid_pmu(const char *name)
> > +static struct perf_pmu *perf_pmu__find_hybrid_pmu(const char *name)
> >  {
> >       struct perf_pmu *pmu;
> >
> > diff --git a/tools/perf/util/pmu-hybrid.h b/tools/perf/util/pmu-hybrid.=
h
> > index 206b94931531..8dbcae935020 100644
> > --- a/tools/perf/util/pmu-hybrid.h
> > +++ b/tools/perf/util/pmu-hybrid.h
> > @@ -13,9 +13,6 @@ extern struct list_head perf_pmu__hybrid_pmus;
> >  #define perf_pmu__for_each_hybrid_pmu(pmu)   \
> >       list_for_each_entry(pmu, &perf_pmu__hybrid_pmus, hybrid_list)
> >
> > -bool perf_pmu__hybrid_mounted(const char *name);
> > -
> > -struct perf_pmu *perf_pmu__find_hybrid_pmu(const char *name);
> >  bool perf_pmu__is_hybrid(const char *name);
> >
> >  static inline int perf_pmu__hybrid_pmu_num(void)
> > diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> > index cd94abe7a87a..e9f3e6a777c0 100644
> > --- a/tools/perf/util/pmu.c
> > +++ b/tools/perf/util/pmu.c
> > @@ -617,9 +617,6 @@ static bool pmu_is_uncore(int dirfd, const char *na=
me)
> >  {
> >       int fd;
> >
> > -     if (perf_pmu__hybrid_mounted(name))
> > -             return false;
> > -
> >       fd =3D perf_pmu__pathname_fd(dirfd, name, "cpumask", O_PATH);
> >       if (fd < 0)
> >               return false;
> > @@ -900,6 +897,16 @@ static int pmu_max_precise(int dirfd, struct perf_=
pmu *pmu)
> >       return max_precise;
> >  }
> >
> > +/**
> > + * perf_pmu__skip_empty_cpus() - should pmu_lookup skip the named PMU =
if the
> > + *      cpus or cpumask file isn't present?
> > + * @name: Name of PMU.
> > + */
> > +static bool perf_pmu__skip_empty_cpus(const char *name)
> > +{
> > +     return !strcmp(name, "cpu_core") || !strcmp(name, "cpu_atom");
>
> Can we use the below to replace?
> return !strncmp(name, "cpu_", 4);
>
> Otherwise, anytime a new core PMU name is introduced, I have to patch
> the function.

I dislike this function but was carrying it forward, I think we can
get rid of it. The point of erroring is to not have core PMUs when
there are no online CPUs associated with it. For existing core PMUs
this just isn't something that can happen as otherwise what CPU are
you running on. For hybrid it can happen and we know we care because
the PMU's type is core. So why not change the error to be when the cpu
map is empty and the CPU is core? I'm going to assume that my logic is
sound and change the code in v4, but please complain.

Thanks,
Ian

> Thanks,
> Kan
>
> > +}
> > +
> >  static struct perf_pmu *pmu_lookup(int dirfd, const char *lookup_name)
> >  {
> >       struct perf_pmu *pmu;
> > @@ -907,15 +914,8 @@ static struct perf_pmu *pmu_lookup(int dirfd, cons=
t char *lookup_name)
> >       LIST_HEAD(aliases);
> >       __u32 type;
> >       char *name =3D pmu_find_real_name(lookup_name);
> > -     bool is_hybrid =3D perf_pmu__hybrid_mounted(name);
> >       char *alias_name;
> >
> > -     /*
> > -      * Check pmu name for hybrid and the pmu may be invalid in sysfs
> > -      */
> > -     if (!strncmp(name, "cpu_", 4) && !is_hybrid)
> > -             return NULL;
> > -
> >       /*
> >        * The pmu data we store & need consists of the pmu
> >        * type value and format definitions. Load both right
> > @@ -935,8 +935,10 @@ static struct perf_pmu *pmu_lookup(int dirfd, cons=
t char *lookup_name)
> >               return NULL;
> >
> >       pmu->cpus =3D pmu_cpumask(dirfd, name);
> > -     pmu->name =3D strdup(name);
> > +     if (!pmu->cpus && perf_pmu__skip_empty_cpus(name))
> > +             goto err;
> >
> > +     pmu->name =3D strdup(name);
> >       if (!pmu->name)
> >               goto err;
> >
> > @@ -967,7 +969,7 @@ static struct perf_pmu *pmu_lookup(int dirfd, const=
 char *lookup_name)
> >       list_splice(&aliases, &pmu->aliases);
> >       list_add_tail(&pmu->list, &pmus);
> >
> > -     if (is_hybrid)
> > +     if (!strcmp(name, "cpu_core") || !strcmp(name, "cpu_atom"))
> >               list_add_tail(&pmu->hybrid_list, &perf_pmu__hybrid_pmus);
> >       else
> >               INIT_LIST_HEAD(&pmu->hybrid_list);
