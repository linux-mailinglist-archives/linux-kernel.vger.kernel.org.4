Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4888270B461
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 07:13:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231396AbjEVFNP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 01:13:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbjEVFNM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 01:13:12 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0742F4
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 22:13:10 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id e9e14a558f8ab-33164ec77ccso202755ab.0
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 22:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684732390; x=1687324390;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oVFuz+LppT4Bt6rO2tywL1VM/+thHNG8bsummeehR1Q=;
        b=0k1j9Rc1+O9BltBLMf/2JOwufCw5dbkJJf/ywrCZipO6+8+uv1jrQYYIXgah+6grbR
         D/7iVC7mJGeCRZ3rYuAN2l9R9zWMkYvuHoF4twd2BX0w25WrheBbMHzkvQXfH81jvMAQ
         Q3m9CaDPZan17r/+oPeDylxFo+sC4UfDxXeNukVaZ94vhqyA5Wd60rNSbFNbIPfbHoCL
         nglFqqUXgw/h99k3FcD0rj6jq5DUSoWF7SsnNTx1Y0nmmU+b4BtbTuTd5Zds08Y6xpmT
         OQSlSS/VeOdN+fqaUzpfWp+gxB8wPa+ghwrvN2/w17f9fUgUYJDjB2eM44wOfSftQD3i
         dFLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684732390; x=1687324390;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oVFuz+LppT4Bt6rO2tywL1VM/+thHNG8bsummeehR1Q=;
        b=dFvc0q5KWq0jkIS07a1oheM5laxd60QkRd88MpzDaYSY6eGbtQjN+RjDYqUuyHMDyw
         XeJWHiO54Ccmeufs8oJEoXMyBmsq/4f/n25opS4ytGyQbdF8mxzQDKzBv5EZTE2nksSe
         UL7dL34xfhMg03kZ03GwoPMfNyp7Id2eqSdE34XIyV4RBgcvKld4X4q5/GJy43gQO3fR
         RLiHLBEs6YCoJs88znFD85RGqGmCLekqgmEV6tzJONJRo2z1Ujy4mI9uC9wdtWOUYNlL
         R2W6JGYVK2vNIzqTM4aP5Zy2eQNuHLe9iYkZp7KQW170rrzGZyE/A1WjWWPs05PrX9mJ
         Wy6Q==
X-Gm-Message-State: AC+VfDxBXPrdVKFDix31xa/5on2jGfQu/FMMGRYiKeRVwO9rWBgfeiDF
        AtyuQWQf7bH9mNsyoYV57MGMTmm+H+kDVGwOCz22bQ==
X-Google-Smtp-Source: ACHHUZ5l3QDvwrpKPScYMJ0LU7PxG6d0PLZdyn5/2xzitEy2Al1dk1MsNaOqXn5Dj/iHdC2bW8nnE9C4etmd7oKJkGk=
X-Received: by 2002:a05:6e02:12cb:b0:331:948c:86f3 with SMTP id
 i11-20020a056e0212cb00b00331948c86f3mr402240ilm.19.1684732389851; Sun, 21 May
 2023 22:13:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230517145803.559429-1-irogers@google.com> <20230517145803.559429-4-irogers@google.com>
 <ba6ab7b6-4ce0-2f07-2b8b-a4373d96c742@linux.intel.com>
In-Reply-To: <ba6ab7b6-4ce0-2f07-2b8b-a4373d96c742@linux.intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Sun, 21 May 2023 22:12:58 -0700
Message-ID: <CAP-5=fVanehMRXUQUsmxSZAijHTOfxzJtNTr84rPjEnxGKdpQA@mail.gmail.com>
Subject: Re: [PATCH v1 03/23] perf evlist: Remove __evlist__add_default
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
        Raul Silvera <rsilvera@google.com>,
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

On Sun, May 21, 2023 at 12:12=E2=80=AFPM Liang, Kan <kan.liang@linux.intel.=
com> wrote:
>
>
>
> On 2023-05-17 10:57 a.m., Ian Rogers wrote:
> > __evlist__add_default adds a cycles event to a typically empty evlist
> > and was extended for hybrid with evlist__add_default_hybrid, as more
> > than 1 PMU was necessary. Rather than have dedicated logic for the
> > cycles event, this change switches to parsing 'cycles' which will
> > handle wildcarding the PMUs appropriately for hybrid.
>
> I think the default event for the perf record was cycles:P, but this
> patch changes the default event to cycles. I think it's better to use
> cycles:P which is more accurate.
>
> Thanks,
> Kan

Agreed. It looks like even though the event is "cycles:P" it is always
displayed as "cycles" and the logic to add "ppp" never fires as
attr.precise_ip is always 0 at the point it is inspected. I'll fix in
v2.

Thanks,
Ian

> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/arch/x86/util/evsel.c | 20 --------------
> >  tools/perf/builtin-record.c      | 13 +++------
> >  tools/perf/builtin-top.c         | 10 ++++---
> >  tools/perf/util/evlist-hybrid.c  | 25 -----------------
> >  tools/perf/util/evlist-hybrid.h  |  1 -
> >  tools/perf/util/evlist.c         | 22 ++++++---------
> >  tools/perf/util/evlist.h         |  7 -----
> >  tools/perf/util/evsel.c          | 46 --------------------------------
> >  tools/perf/util/evsel.h          |  3 ---
> >  9 files changed, 17 insertions(+), 130 deletions(-)
> >
> > diff --git a/tools/perf/arch/x86/util/evsel.c b/tools/perf/arch/x86/uti=
l/evsel.c
> > index ea3972d785d1..153cdca94cd4 100644
> > --- a/tools/perf/arch/x86/util/evsel.c
> > +++ b/tools/perf/arch/x86/util/evsel.c
> > @@ -16,26 +16,6 @@ void arch_evsel__set_sample_weight(struct evsel *evs=
el)
> >       evsel__set_sample_bit(evsel, WEIGHT_STRUCT);
> >  }
> >
> > -void arch_evsel__fixup_new_cycles(struct perf_event_attr *attr)
> > -{
> > -     struct perf_env env =3D { .total_mem =3D 0, } ;
> > -
> > -     if (!perf_env__cpuid(&env))
> > -             return;
> > -
> > -     /*
> > -      * On AMD, precise cycles event sampling internally uses IBS pmu.
> > -      * But IBS does not have filtering capabilities and perf by defau=
lt
> > -      * sets exclude_guest =3D 1. This makes IBS pmu event init fail a=
nd
> > -      * thus perf ends up doing non-precise sampling. Avoid it by clea=
ring
> > -      * exclude_guest.
> > -      */
> > -     if (env.cpuid && strstarts(env.cpuid, "AuthenticAMD"))
> > -             attr->exclude_guest =3D 0;
> > -
> > -     free(env.cpuid);
> > -}
> > -
> >  /* Check whether the evsel's PMU supports the perf metrics */
> >  bool evsel__sys_has_perf_metrics(const struct evsel *evsel)
> >  {
> > diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> > index 9d212236c75a..85f2bd035a94 100644
> > --- a/tools/perf/builtin-record.c
> > +++ b/tools/perf/builtin-record.c
> > @@ -4161,18 +4161,11 @@ int cmd_record(int argc, const char **argv)
> >               record.opts.tail_synthesize =3D true;
> >
> >       if (rec->evlist->core.nr_entries =3D=3D 0) {
> > -             if (perf_pmu__has_hybrid()) {
> > -                     err =3D evlist__add_default_hybrid(rec->evlist,
> > -                                                      !record.opts.no_=
samples);
> > -             } else {
> > -                     err =3D __evlist__add_default(rec->evlist,
> > -                                                 !record.opts.no_sampl=
es);
> > -             }
> > +             bool can_profile_kernel =3D perf_event_paranoid_check(1);
> >
> > -             if (err < 0) {
> > -                     pr_err("Not enough memory for event selector list=
\n");
> > +             err =3D parse_event(rec->evlist, can_profile_kernel ? "cy=
cles" : "cycles:u");
> > +             if (err)
> >                       goto out;
> > -             }
> >       }
> >
> >       if (rec->opts.target.tid && !rec->opts.no_inherit_set)
> > diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
> > index 48ee49e95c5e..d1e6d23bee3e 100644
> > --- a/tools/perf/builtin-top.c
> > +++ b/tools/perf/builtin-top.c
> > @@ -1653,10 +1653,12 @@ int cmd_top(int argc, const char **argv)
> >       if (annotate_check_args(&top.annotation_opts) < 0)
> >               goto out_delete_evlist;
> >
> > -     if (!top.evlist->core.nr_entries &&
> > -         evlist__add_default(top.evlist) < 0) {
> > -             pr_err("Not enough memory for event selector list\n");
> > -             goto out_delete_evlist;
> > +     if (!top.evlist->core.nr_entries) {
> > +             bool can_profile_kernel =3D perf_event_paranoid_check(1);
> > +             int err =3D parse_event(top.evlist, can_profile_kernel ? =
"cycles" : "cycles:u");
> > +
> > +             if (err)
> > +                     goto out_delete_evlist;
> >       }
> >
> >       status =3D evswitch__init(&top.evswitch, top.evlist, stderr);
> > diff --git a/tools/perf/util/evlist-hybrid.c b/tools/perf/util/evlist-h=
ybrid.c
> > index 0f59c80f27b2..64f78d06fe19 100644
> > --- a/tools/perf/util/evlist-hybrid.c
> > +++ b/tools/perf/util/evlist-hybrid.c
> > @@ -16,31 +16,6 @@
> >  #include <perf/evsel.h>
> >  #include <perf/cpumap.h>
> >
> > -int evlist__add_default_hybrid(struct evlist *evlist, bool precise)
> > -{
> > -     struct evsel *evsel;
> > -     struct perf_pmu *pmu;
> > -     __u64 config;
> > -     struct perf_cpu_map *cpus;
> > -
> > -     perf_pmu__for_each_hybrid_pmu(pmu) {
> > -             config =3D PERF_COUNT_HW_CPU_CYCLES |
> > -                      ((__u64)pmu->type << PERF_PMU_TYPE_SHIFT);
> > -             evsel =3D evsel__new_cycles(precise, PERF_TYPE_HARDWARE,
> > -                                       config);
> > -             if (!evsel)
> > -                     return -ENOMEM;
> > -
> > -             cpus =3D perf_cpu_map__get(pmu->cpus);
> > -             evsel->core.cpus =3D cpus;
> > -             evsel->core.own_cpus =3D perf_cpu_map__get(cpus);
> > -             evsel->pmu_name =3D strdup(pmu->name);
> > -             evlist__add(evlist, evsel);
> > -     }
> > -
> > -     return 0;
> > -}
> > -
> >  bool evlist__has_hybrid(struct evlist *evlist)
> >  {
> >       struct evsel *evsel;
> > diff --git a/tools/perf/util/evlist-hybrid.h b/tools/perf/util/evlist-h=
ybrid.h
> > index 4b000eda6626..0cded76eb344 100644
> > --- a/tools/perf/util/evlist-hybrid.h
> > +++ b/tools/perf/util/evlist-hybrid.h
> > @@ -7,7 +7,6 @@
> >  #include "evlist.h"
> >  #include <unistd.h>
> >
> > -int evlist__add_default_hybrid(struct evlist *evlist, bool precise);
> >  bool evlist__has_hybrid(struct evlist *evlist);
> >
> >  #endif /* __PERF_EVLIST_HYBRID_H */
> > diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> > index 5d0d99127a90..b8ca99afdfe5 100644
> > --- a/tools/perf/util/evlist.c
> > +++ b/tools/perf/util/evlist.c
> > @@ -93,8 +93,15 @@ struct evlist *evlist__new(void)
> >  struct evlist *evlist__new_default(void)
> >  {
> >       struct evlist *evlist =3D evlist__new();
> > +     bool can_profile_kernel;
> > +     int err;
> > +
> > +     if (!evlist)
> > +             return NULL;
> >
> > -     if (evlist && evlist__add_default(evlist)) {
> > +     can_profile_kernel =3D perf_event_paranoid_check(1);
> > +     err =3D parse_event(evlist, can_profile_kernel ? "cycles" : "cycl=
es:u");
> > +     if (err) {
> >               evlist__delete(evlist);
> >               evlist =3D NULL;
> >       }
> > @@ -237,19 +244,6 @@ static void evlist__set_leader(struct evlist *evli=
st)
> >       perf_evlist__set_leader(&evlist->core);
> >  }
> >
> > -int __evlist__add_default(struct evlist *evlist, bool precise)
> > -{
> > -     struct evsel *evsel;
> > -
> > -     evsel =3D evsel__new_cycles(precise, PERF_TYPE_HARDWARE,
> > -                               PERF_COUNT_HW_CPU_CYCLES);
> > -     if (evsel =3D=3D NULL)
> > -             return -ENOMEM;
> > -
> > -     evlist__add(evlist, evsel);
> > -     return 0;
> > -}
> > -
> >  static struct evsel *evlist__dummy_event(struct evlist *evlist)
> >  {
> >       struct perf_event_attr attr =3D {
> > diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
> > index 5e7ff44f3043..664c6bf7b3e0 100644
> > --- a/tools/perf/util/evlist.h
> > +++ b/tools/perf/util/evlist.h
> > @@ -100,13 +100,6 @@ void evlist__delete(struct evlist *evlist);
> >  void evlist__add(struct evlist *evlist, struct evsel *entry);
> >  void evlist__remove(struct evlist *evlist, struct evsel *evsel);
> >
> > -int __evlist__add_default(struct evlist *evlist, bool precise);
> > -
> > -static inline int evlist__add_default(struct evlist *evlist)
> > -{
> > -     return __evlist__add_default(evlist, true);
> > -}
> > -
> >  int evlist__add_attrs(struct evlist *evlist, struct perf_event_attr *a=
ttrs, size_t nr_attrs);
> >
> >  int __evlist__add_default_attrs(struct evlist *evlist,
> > diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> > index 2f5910b31fa9..b39615124672 100644
> > --- a/tools/perf/util/evsel.c
> > +++ b/tools/perf/util/evsel.c
> > @@ -316,48 +316,6 @@ struct evsel *evsel__new_idx(struct perf_event_att=
r *attr, int idx)
> >       return evsel;
> >  }
> >
> > -static bool perf_event_can_profile_kernel(void)
> > -{
> > -     return perf_event_paranoid_check(1);
> > -}
> > -
> > -struct evsel *evsel__new_cycles(bool precise __maybe_unused, __u32 typ=
e, __u64 config)
> > -{
> > -     struct perf_event_attr attr =3D {
> > -             .type   =3D type,
> > -             .config =3D config,
> > -             .exclude_kernel =3D !perf_event_can_profile_kernel(),
> > -     };
> > -     struct evsel *evsel;
> > -
> > -     event_attr_init(&attr);
> > -
> > -     /*
> > -      * Now let the usual logic to set up the perf_event_attr defaults
> > -      * to kick in when we return and before perf_evsel__open() is cal=
led.
> > -      */
> > -     evsel =3D evsel__new(&attr);
> > -     if (evsel =3D=3D NULL)
> > -             goto out;
> > -
> > -     arch_evsel__fixup_new_cycles(&evsel->core.attr);
> > -
> > -     evsel->precise_max =3D true;
> > -
> > -     /* use asprintf() because free(evsel) assumes name is allocated *=
/
> > -     if (asprintf(&evsel->name, "cycles%s%s%.*s",
> > -                  (attr.precise_ip || attr.exclude_kernel) ? ":" : "",
> > -                  attr.exclude_kernel ? "u" : "",
> > -                  attr.precise_ip ? attr.precise_ip + 1 : 0, "ppp") < =
0)
> > -             goto error_free;
> > -out:
> > -     return evsel;
> > -error_free:
> > -     evsel__delete(evsel);
> > -     evsel =3D NULL;
> > -     goto out;
> > -}
> > -
> >  int copy_config_terms(struct list_head *dst, struct list_head *src)
> >  {
> >       struct evsel_config_term *pos, *tmp;
> > @@ -1130,10 +1088,6 @@ void __weak arch_evsel__set_sample_weight(struct=
 evsel *evsel)
> >       evsel__set_sample_bit(evsel, WEIGHT);
> >  }
> >
> > -void __weak arch_evsel__fixup_new_cycles(struct perf_event_attr *attr =
__maybe_unused)
> > -{
> > -}
> > -
> >  void __weak arch__post_evsel_config(struct evsel *evsel __maybe_unused=
,
> >                                   struct perf_event_attr *attr __maybe_=
unused)
> >  {
> > diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
> > index df8928745fc6..429b172cc94d 100644
> > --- a/tools/perf/util/evsel.h
> > +++ b/tools/perf/util/evsel.h
> > @@ -243,8 +243,6 @@ static inline struct evsel *evsel__newtp(const char=
 *sys, const char *name)
> >  }
> >  #endif
> >
> > -struct evsel *evsel__new_cycles(bool precise, __u32 type, __u64 config=
);
> > -
> >  #ifdef HAVE_LIBTRACEEVENT
> >  struct tep_event *event_format__new(const char *sys, const char *name)=
;
> >  #endif
> > @@ -312,7 +310,6 @@ void __evsel__reset_sample_bit(struct evsel *evsel,=
 enum perf_event_sample_forma
> >  void evsel__set_sample_id(struct evsel *evsel, bool use_sample_identif=
ier);
> >
> >  void arch_evsel__set_sample_weight(struct evsel *evsel);
> > -void arch_evsel__fixup_new_cycles(struct perf_event_attr *attr);
> >  void arch__post_evsel_config(struct evsel *evsel, struct perf_event_at=
tr *attr);
> >
> >  int evsel__set_filter(struct evsel *evsel, const char *filter);
