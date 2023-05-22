Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E17470B482
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 07:22:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231949AbjEVFWP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 01:22:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231948AbjEVFWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 01:22:11 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C22ECA
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 22:22:09 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id e9e14a558f8ab-33828a86ee2so254735ab.0
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 22:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684732929; x=1687324929;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S0tc4RCP3K7u6Ic2UEzhCnJzGDUs990ssG7u5qThApw=;
        b=WX5uf8y+w1R3/FqJ8jgI1CIL29Co9IaTgCcYhehHjAXfRy96xa22FF6LaNVL4j8Kq1
         EmsqUjgnK0tLg2ykDGCcdsdeRNFmNXAiQiO6kCVzv6bdkM0qGxaQOD374nwjtSRDJiy9
         oImdK4zwu+I35I9teq2Cc2lMPDMHrkK7xz72IFcGKEyS2g51fmp4gUfPXPLNlEwc5Aay
         elILKdPufok6sltRsULp8UkF+RqMu7MfT6za4rqzk3R+psk/cJDRPqD5FrEFqP7S3Zg9
         Pt7zH/mB7KVcjaDXqqi381B1Y+UK2Xi9UM66X7yEUWqjUXwG0+UXCNjwtYlPpzEQjV4V
         2UTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684732929; x=1687324929;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S0tc4RCP3K7u6Ic2UEzhCnJzGDUs990ssG7u5qThApw=;
        b=GyQXNU/zwHkvicuf+Pn6I1qRO+JJ/RLaS7p4FBjAjPg3Vu/YPCRuxY1h8W6XerPKgp
         c3pSkhi7jpU624JGb6E1OYuQS4JhP2p8mm5sT40TzT+dUe9q9E4YLLS3gnuyOJIH46aU
         MbSChnmS0H7KU6XSX3WuqD/RhcyLYSZJQrCwPFFA6jY9uc+0DlObaeoMlrm2oITfVHar
         f3dGNY51pIPMvnMUHphxcRPcRb1Vb7jN2Bnu3vkWlG5vPy2Br1OB1QOmklT0irsTG03l
         VRWXaafztPDOc+LwFbVwJ8mNb2O5RMfKPAKaCSoFQj9VmyzJrFEkt0SK+9n8vWEk+vjJ
         NS+g==
X-Gm-Message-State: AC+VfDzXkUbvsN7PopAqQknBOHSyYuMZQp3oJ5fixoQ1idPoffnCLWzI
        6oaCkolgh1u2Bshh1CLcXrRlMXYRaRSfaZy2FFdwKw==
X-Google-Smtp-Source: ACHHUZ77M7eJMoSH/61HLM0tG1ppslArzT+OOris+LEeaQRu2shLxzzpYsHnE3ecKCwLLFO5gSXEJ8tu25OrkccUryE=
X-Received: by 2002:a05:6e02:2185:b0:338:13f1:8c0c with SMTP id
 j5-20020a056e02218500b0033813f18c0cmr660734ila.16.1684732928613; Sun, 21 May
 2023 22:22:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230517145803.559429-1-irogers@google.com> <20230517145803.559429-6-irogers@google.com>
 <1ea342ab-d68f-26e5-0043-f05b1886009e@linux.intel.com>
In-Reply-To: <1ea342ab-d68f-26e5-0043-f05b1886009e@linux.intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Sun, 21 May 2023 22:21:57 -0700
Message-ID: <CAP-5=fU3OYNsjaJhLq_8tJXZKFARCTqrg3CEr64-3rAm_kTx+A@mail.gmail.com>
Subject: Re: [PATCH v1 05/23] perf pmu: Remove perf_pmu__hybrid_mounted
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 21, 2023 at 12:23=E2=80=AFPM Liang, Kan <kan.liang@linux.intel.=
com> wrote:
>
>
>
> On 2023-05-17 10:57 a.m., Ian Rogers wrote:
> > perf_pmu__hybrid_mounted is used to detect whether cpu_core or
> > cpu_atom
>
> Currently, there are only two CPU types for a hybrid machine, core and
> atom. But there may be more CPU types added later. Please see the CPUID
> 1AH EAX enumeration in SDM VOL2. It has several reserved encodings for
> CPU types. It's better not using the hardcode cpu_core/cpu_atom to
> replace the perf_pmu__hybrid_mounted().
>
> Thanks,
> Kan

This is covered by later patches. Specifically patches like:
patch 7: perf pmu: Add is_core to pmu
patch 20: Split pmus list into core and uncore

Ultimately in pmus.h we have two scan routines, one for all PMUs and
one for core PMUs. For everything except hybrid (and the name varies a
bit on ARM) the core scan only scans "cpu", on hybrid it scans
"cpu_atom" and "cpu_core".  The determination of core vs uncore is
done without using the name, so can support >2 hybrid PMUs. At this
point in the patch series I'm trying to simplify everything so that I
can then build the pmus interface.

Thanks,
Ian

> > is mounted with a non-empty cpus file by
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
> > index 1e0be23d4dd7..729b1f166f80 100644
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
> > @@ -898,6 +895,16 @@ static int pmu_max_precise(int dirfd, struct perf_=
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
> > +}
> > +
> >  static struct perf_pmu *pmu_lookup(int dirfd, const char *lookup_name)
> >  {
> >       struct perf_pmu *pmu;
> > @@ -905,15 +912,8 @@ static struct perf_pmu *pmu_lookup(int dirfd, cons=
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
> > @@ -933,8 +933,10 @@ static struct perf_pmu *pmu_lookup(int dirfd, cons=
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
> > @@ -964,7 +966,7 @@ static struct perf_pmu *pmu_lookup(int dirfd, const=
 char *lookup_name)
> >       list_splice(&aliases, &pmu->aliases);
> >       list_add_tail(&pmu->list, &pmus);
> >
> > -     if (is_hybrid)
> > +     if (!strcmp(name, "cpu_core") || !strcmp(name, "cpu_atom"))
> >               list_add_tail(&pmu->hybrid_list, &perf_pmu__hybrid_pmus);
> >       else
> >               INIT_LIST_HEAD(&pmu->hybrid_list);
