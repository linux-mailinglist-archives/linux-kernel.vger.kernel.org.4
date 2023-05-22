Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C22270B43A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 06:53:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231557AbjEVExF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 00:53:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231572AbjEVExC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 00:53:02 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E5DFFE
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 21:52:58 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id e9e14a558f8ab-338458a9304so181405ab.1
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 21:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684731178; x=1687323178;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PAjpW8+8t+AatFAmMs1Mphf0k8MPeZh4wyrk30YVTUw=;
        b=wa0TWVLgXkxIVfGipT6nXDZw3ufkcoyqbieIehP/9kpoEri/hBkWeEL0Uzbs6EHLJ8
         2FR3gXu51YuoPk0otzT8KLF2E6bLKzVzEmBQMF44SMqcPlW24jBoM20Iw9+RXHXtF3tW
         jNR27B1bBLL6vrTF7S8+tgE9iAaEA0I+DoEkJ+kEXhvaMeaOAAhaHrQIItH5HA4OALj2
         fbBo9OtSqgZM+pRxfPSYoe7bKcozECcTMOvF5+MuQCHoiNzVaNJ9x4Z4sRSCZXn2QFes
         H0F3WWk/xUv3+NaSNl3QzUrtO9kPmo8XkYKsYoIZitCbYSgUjdB7a3IyBmRAnVj6ozuG
         4hNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684731178; x=1687323178;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PAjpW8+8t+AatFAmMs1Mphf0k8MPeZh4wyrk30YVTUw=;
        b=aKRv92dwlPgpSl3XvTQybpE6aJfmT0nzOuvanS/xlN85t3ino8aZRrTRA5nWVPKXfK
         6Xfqj50InZW+R5DbzJ1ZDWJetI5Ia0Sq42NYUa6pQuZZuRncg2tKMQmpgV0dljXoUDFU
         7Ny1ZmXqdHei9vDwn1GKEkJWcbfj/or6iydzr9NX+XDBJe0yMW4y3Az/7JlPEoK1uftj
         hLwjFMErL/8gdiccIbkYPXsO8Wge5yw2QLARudD0q/ru65c7YfknhsGXz8vi6rX3oHPw
         hAyXIx13E50c1FNM1hQf1OTv2OMm0/Ho/+VEGGNV1J2LIHfwv41c/xSUue5Qoz0Lj+xe
         l2Nw==
X-Gm-Message-State: AC+VfDwlWsE1PPOPiEXp5xJ+KHBfca4Ko8Z6zuTLaQw4h7oTkPuFbTtL
        ZLCVRjBJjWKVViBE+FIP+CMbDrHlp8cTvZCzA4sgsA==
X-Google-Smtp-Source: ACHHUZ68VK5ykgE7OwXfBX6uCsX1XWI3n80iV/eqtV8giwWQ0CUWidmYijphy4bR66GNAi3zWG96xoS/Eda9Slwit00=
X-Received: by 2002:a05:6e02:1a85:b0:326:55d0:efad with SMTP id
 k5-20020a056e021a8500b0032655d0efadmr431717ilv.12.1684731177539; Sun, 21 May
 2023 21:52:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230517145803.559429-1-irogers@google.com> <20230517145803.559429-2-irogers@google.com>
 <3586d413-b7c9-9790-ec4e-4132502c806d@linux.intel.com>
In-Reply-To: <3586d413-b7c9-9790-ec4e-4132502c806d@linux.intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Sun, 21 May 2023 21:52:46 -0700
Message-ID: <CAP-5=fUERgwWt=C88QOdx8JzxB1P0RXJ9WxGUY=GABwdU6Pvpg@mail.gmail.com>
Subject: Re: [PATCH v1 01/23] perf tools: Warn if no user requested CPUs match
 PMU's CPUs
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

On Sun, May 21, 2023 at 12:04=E2=80=AFPM Liang, Kan <kan.liang@linux.intel.=
com> wrote:
>
>
>
> On 2023-05-17 10:57 a.m., Ian Rogers wrote:
> > In commit 1d3351e631fc ("perf tools: Enable on a list of CPUs for hybri=
d")
> > perf on hybrid will warn if a user requested CPU doesn't match the PMU
> > of the given event but only for hybrid PMUs. Make the logic generic
> > for all PMUs and remove the hybrid logic.
>
> The logic may not work for all PMUs, especially for uncore.
>
> For uncore, the user should be able to read counters from any CPU of a
> socket/die, not just the CPU from the cpumask.
> Please see d6a2f9035bfc ("perf/core: Introduce PMU_EV_CAP_READ_ACTIVE_PKG=
").
>
> Thanks,
> Kan

Hi Kan,

the code specifically handles this and for uncore PMUs the check is
that the CPU is any online CPU:

"""
... Uncore PMUs list a CPU in sysfs, but this may be overwritten by a
+ *     user requested CPU and so any online CPU is applicable. Core PMUs h=
andle
+ *     events on the CPUs in their list and otherwise the event isn't
supported.
...
+               to_test =3D pmu && pmu->is_uncore ? cpu_map__online() :
evsel__cpus(pos);
...
"""

in the commit message this is also called out:

"""
For example on a 16 (0-15) CPU system:
```
$ perf stat -e imc_free_running/data_read/,cycles -C 16 true
WARNING: Requested CPU(s) '16' not supported by PMU
'uncore_imc_free_running_1' for event 'imc_free_running/data_read/'
WARNING: Requested CPU(s) '16' not supported by PMU
'uncore_imc_free_running_0' for event 'imc_free_running/data_read/'
WARNING: Requested CPU(s) '16' not supported by PMU 'cpu' for event 'cycles=
'
...
"""
CPU 16 is invalid, only 0 to 15 are valid, and so there are warnings
for the uncore events for "imc_free_running/data_read/".

Thanks,
Ian

> >
> > Warn if a CPU is requested that is offline for uncore events. Warn if
> > a CPU is requested for a core PMU, but the CPU isn't within the cpu
> > map of that PMU.
> >
> > For example on a 16 (0-15) CPU system:
> > ```
> > $ perf stat -e imc_free_running/data_read/,cycles -C 16 true
> > WARNING: Requested CPU(s) '16' not supported by PMU 'uncore_imc_free_ru=
nning_1' for event 'imc_free_running/data_read/'
> > WARNING: Requested CPU(s) '16' not supported by PMU 'uncore_imc_free_ru=
nning_0' for event 'imc_free_running/data_read/'
> > WARNING: Requested CPU(s) '16' not supported by PMU 'cpu' for event 'cy=
cles'
> >
> >  Performance counter stats for 'CPU(s) 16':
> >
> >    <not supported> MiB  imc_free_running/data_read/
> >    <not supported>      cycles
> >
> >        0.000570094 seconds time elapsed
> > ```
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/builtin-record.c     |  6 +--
> >  tools/perf/builtin-stat.c       |  5 +--
> >  tools/perf/util/cpumap.h        |  2 +-
> >  tools/perf/util/evlist-hybrid.c | 74 ---------------------------------
> >  tools/perf/util/evlist-hybrid.h |  1 -
> >  tools/perf/util/evlist.c        | 44 ++++++++++++++++++++
> >  tools/perf/util/evlist.h        |  2 +
> >  tools/perf/util/pmu.c           | 33 ---------------
> >  tools/perf/util/pmu.h           |  4 --
> >  9 files changed, 49 insertions(+), 122 deletions(-)
> >
> > diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> > index ec0f2d5f189f..9d212236c75a 100644
> > --- a/tools/perf/builtin-record.c
> > +++ b/tools/perf/builtin-record.c
> > @@ -4198,11 +4198,7 @@ int cmd_record(int argc, const char **argv)
> >       /* Enable ignoring missing threads when -u/-p option is defined. =
*/
> >       rec->opts.ignore_missing_thread =3D rec->opts.target.uid !=3D UIN=
T_MAX || rec->opts.target.pid;
> >
> > -     if (evlist__fix_hybrid_cpus(rec->evlist, rec->opts.target.cpu_lis=
t)) {
> > -             pr_err("failed to use cpu list %s\n",
> > -                    rec->opts.target.cpu_list);
> > -             goto out;
> > -     }
> > +     evlist__warn_user_requested_cpus(rec->evlist, rec->opts.target.cp=
u_list);
> >
> >       rec->opts.target.hybrid =3D perf_pmu__has_hybrid();
> >
> > diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> > index bc45cee3f77c..612467216306 100644
> > --- a/tools/perf/builtin-stat.c
> > +++ b/tools/perf/builtin-stat.c
> > @@ -2462,10 +2462,7 @@ int cmd_stat(int argc, const char **argv)
> >               }
> >       }
> >
> > -     if (evlist__fix_hybrid_cpus(evsel_list, target.cpu_list)) {
> > -             pr_err("failed to use cpu list %s\n", target.cpu_list);
> > -             goto out;
> > -     }
> > +     evlist__warn_user_requested_cpus(evsel_list, target.cpu_list);
> >
> >       target.hybrid =3D perf_pmu__has_hybrid();
> >       if (evlist__create_maps(evsel_list, &target) < 0) {
> > diff --git a/tools/perf/util/cpumap.h b/tools/perf/util/cpumap.h
> > index e3426541e0aa..c1de993c083f 100644
> > --- a/tools/perf/util/cpumap.h
> > +++ b/tools/perf/util/cpumap.h
> > @@ -59,7 +59,7 @@ struct perf_cpu cpu__max_present_cpu(void);
> >  /**
> >   * cpu_map__is_dummy - Events associated with a pid, rather than a CPU=
, use a single dummy map with an entry of -1.
> >   */
> > -static inline bool cpu_map__is_dummy(struct perf_cpu_map *cpus)
> > +static inline bool cpu_map__is_dummy(const struct perf_cpu_map *cpus)
> >  {
> >       return perf_cpu_map__nr(cpus) =3D=3D 1 && perf_cpu_map__cpu(cpus,=
 0).cpu =3D=3D -1;
> >  }
> > diff --git a/tools/perf/util/evlist-hybrid.c b/tools/perf/util/evlist-h=
ybrid.c
> > index 57f02beef023..db3f5fbdebe1 100644
> > --- a/tools/perf/util/evlist-hybrid.c
> > +++ b/tools/perf/util/evlist-hybrid.c
> > @@ -86,77 +86,3 @@ bool evlist__has_hybrid(struct evlist *evlist)
> >
> >       return false;
> >  }
> > -
> > -int evlist__fix_hybrid_cpus(struct evlist *evlist, const char *cpu_lis=
t)
> > -{
> > -     struct perf_cpu_map *cpus;
> > -     struct evsel *evsel, *tmp;
> > -     struct perf_pmu *pmu;
> > -     int ret, unmatched_count =3D 0, events_nr =3D 0;
> > -
> > -     if (!perf_pmu__has_hybrid() || !cpu_list)
> > -             return 0;
> > -
> > -     cpus =3D perf_cpu_map__new(cpu_list);
> > -     if (!cpus)
> > -             return -1;
> > -
> > -     /*
> > -      * The evsels are created with hybrid pmu's cpus. But now we
> > -      * need to check and adjust the cpus of evsel by cpu_list because
> > -      * cpu_list may cause conflicts with cpus of evsel. For example,
> > -      * cpus of evsel is cpu0-7, but the cpu_list is cpu6-8, we need
> > -      * to adjust the cpus of evsel to cpu6-7. And then propatate maps
> > -      * in evlist__create_maps().
> > -      */
> > -     evlist__for_each_entry_safe(evlist, tmp, evsel) {
> > -             struct perf_cpu_map *matched_cpus, *unmatched_cpus;
> > -             char buf1[128], buf2[128];
> > -
> > -             pmu =3D perf_pmu__find_hybrid_pmu(evsel->pmu_name);
> > -             if (!pmu)
> > -                     continue;
> > -
> > -             ret =3D perf_pmu__cpus_match(pmu, cpus, &matched_cpus,
> > -                                        &unmatched_cpus);
> > -             if (ret)
> > -                     goto out;
> > -
> > -             events_nr++;
> > -
> > -             if (perf_cpu_map__nr(matched_cpus) > 0 &&
> > -                 (perf_cpu_map__nr(unmatched_cpus) > 0 ||
> > -                  perf_cpu_map__nr(matched_cpus) < perf_cpu_map__nr(cp=
us) ||
> > -                  perf_cpu_map__nr(matched_cpus) < perf_cpu_map__nr(pm=
u->cpus))) {
> > -                     perf_cpu_map__put(evsel->core.cpus);
> > -                     perf_cpu_map__put(evsel->core.own_cpus);
> > -                     evsel->core.cpus =3D perf_cpu_map__get(matched_cp=
us);
> > -                     evsel->core.own_cpus =3D perf_cpu_map__get(matche=
d_cpus);
> > -
> > -                     if (perf_cpu_map__nr(unmatched_cpus) > 0) {
> > -                             cpu_map__snprint(matched_cpus, buf1, size=
of(buf1));
> > -                             pr_warning("WARNING: use %s in '%s' for '=
%s', skip other cpus in list.\n",
> > -                                        buf1, pmu->name, evsel->name);
> > -                     }
> > -             }
> > -
> > -             if (perf_cpu_map__nr(matched_cpus) =3D=3D 0) {
> > -                     evlist__remove(evlist, evsel);
> > -                     evsel__delete(evsel);
> > -
> > -                     cpu_map__snprint(cpus, buf1, sizeof(buf1));
> > -                     cpu_map__snprint(pmu->cpus, buf2, sizeof(buf2));
> > -                     pr_warning("WARNING: %s isn't a '%s', please use =
a CPU list in the '%s' range (%s)\n",
> > -                                buf1, pmu->name, pmu->name, buf2);
> > -                     unmatched_count++;
> > -             }
> > -
> > -             perf_cpu_map__put(matched_cpus);
> > -             perf_cpu_map__put(unmatched_cpus);
> > -     }
> > -     if (events_nr)
> > -             ret =3D (unmatched_count =3D=3D events_nr) ? -1 : 0;
> > -out:
> > -     perf_cpu_map__put(cpus);
> > -     return ret;
> > -}
> > diff --git a/tools/perf/util/evlist-hybrid.h b/tools/perf/util/evlist-h=
ybrid.h
> > index aacdb1b0f948..19f74b4c340a 100644
> > --- a/tools/perf/util/evlist-hybrid.h
> > +++ b/tools/perf/util/evlist-hybrid.h
> > @@ -10,6 +10,5 @@
> >  int evlist__add_default_hybrid(struct evlist *evlist, bool precise);
> >  void evlist__warn_hybrid_group(struct evlist *evlist);
> >  bool evlist__has_hybrid(struct evlist *evlist);
> > -int evlist__fix_hybrid_cpus(struct evlist *evlist, const char *cpu_lis=
t);
> >
> >  #endif /* __PERF_EVLIST_HYBRID_H */
> > diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> > index a0504316b06f..5d0d99127a90 100644
> > --- a/tools/perf/util/evlist.c
> > +++ b/tools/perf/util/evlist.c
> > @@ -2465,3 +2465,47 @@ void evlist__check_mem_load_aux(struct evlist *e=
vlist)
> >               }
> >       }
> >  }
> > +
> > +/**
> > + * evlist__warn_user_requested_cpus() - Check each evsel against reque=
sted CPUs
> > + *     and warn if the user CPU list is inapplicable for the event's P=
MUs
> > + *     CPUs. Uncore PMUs list a CPU in sysfs, but this may be overwrit=
ten by a
> > + *     user requested CPU and so any online CPU is applicable. Core PM=
Us handle
> > + *     events on the CPUs in their list and otherwise the event isn't =
supported.
> > + * @evlist: The list of events being checked.
> > + * @cpu_list: The user provided list of CPUs.
> > + */
> > +void evlist__warn_user_requested_cpus(struct evlist *evlist, const cha=
r *cpu_list)
> > +{
> > +     struct perf_cpu_map *user_requested_cpus;
> > +     struct evsel *pos;
> > +
> > +     if (!cpu_list)
> > +             return;
> > +
> > +     user_requested_cpus =3D perf_cpu_map__new(cpu_list);
> > +     if (!user_requested_cpus)
> > +             return;
> > +
> > +     evlist__for_each_entry(evlist, pos) {
> > +             const struct perf_cpu_map *to_test;
> > +             struct perf_cpu cpu;
> > +             int idx;
> > +             bool warn =3D true;
> > +             const struct perf_pmu *pmu =3D evsel__find_pmu(pos);
> > +
> > +             to_test =3D pmu && pmu->is_uncore ? cpu_map__online() : e=
vsel__cpus(pos);
> > +
> > +             perf_cpu_map__for_each_cpu(cpu, idx, to_test) {
> > +                     if (perf_cpu_map__has(user_requested_cpus, cpu)) =
{
> > +                             warn =3D false;
> > +                             break;
> > +                     }
> > +             }
> > +             if (warn) {
> > +                     pr_warning("WARNING: Requested CPU(s) '%s' not su=
pported by PMU '%s' for event '%s'\n",
> > +                             cpu_list, pmu ? pmu->name : "cpu", evsel_=
_name(pos));
> > +             }
> > +     }
> > +     perf_cpu_map__put(user_requested_cpus);
> > +}
> > diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
> > index e7e5540cc970..5e7ff44f3043 100644
> > --- a/tools/perf/util/evlist.h
> > +++ b/tools/perf/util/evlist.h
> > @@ -447,4 +447,6 @@ struct evsel *evlist__find_evsel(struct evlist *evl=
ist, int idx);
> >
> >  int evlist__scnprintf_evsels(struct evlist *evlist, size_t size, char =
*bf);
> >  void evlist__check_mem_load_aux(struct evlist *evlist);
> > +void evlist__warn_user_requested_cpus(struct evlist *evlist, const cha=
r *cpu_list);
> > +
> >  #endif /* __PERF_EVLIST_H */
> > diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> > index f4f0afbc391c..1e0be23d4dd7 100644
> > --- a/tools/perf/util/pmu.c
> > +++ b/tools/perf/util/pmu.c
> > @@ -2038,39 +2038,6 @@ int perf_pmu__match(char *pattern, char *name, c=
har *tok)
> >       return 0;
> >  }
> >
> > -int perf_pmu__cpus_match(struct perf_pmu *pmu, struct perf_cpu_map *cp=
us,
> > -                      struct perf_cpu_map **mcpus_ptr,
> > -                      struct perf_cpu_map **ucpus_ptr)
> > -{
> > -     struct perf_cpu_map *pmu_cpus =3D pmu->cpus;
> > -     struct perf_cpu_map *matched_cpus, *unmatched_cpus;
> > -     struct perf_cpu cpu;
> > -     int i, matched_nr =3D 0, unmatched_nr =3D 0;
> > -
> > -     matched_cpus =3D perf_cpu_map__default_new();
> > -     if (!matched_cpus)
> > -             return -1;
> > -
> > -     unmatched_cpus =3D perf_cpu_map__default_new();
> > -     if (!unmatched_cpus) {
> > -             perf_cpu_map__put(matched_cpus);
> > -             return -1;
> > -     }
> > -
> > -     perf_cpu_map__for_each_cpu(cpu, i, cpus) {
> > -             if (!perf_cpu_map__has(pmu_cpus, cpu))
> > -                     RC_CHK_ACCESS(unmatched_cpus)->map[unmatched_nr++=
] =3D cpu;
> > -             else
> > -                     RC_CHK_ACCESS(matched_cpus)->map[matched_nr++] =
=3D cpu;
> > -     }
> > -
> > -     perf_cpu_map__set_nr(unmatched_cpus, unmatched_nr);
> > -     perf_cpu_map__set_nr(matched_cpus, matched_nr);
> > -     *mcpus_ptr =3D matched_cpus;
> > -     *ucpus_ptr =3D unmatched_cpus;
> > -     return 0;
> > -}
> > -
> >  double __weak perf_pmu__cpu_slots_per_cycle(void)
> >  {
> >       return NAN;
> > diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
> > index 0e0cb6283594..49033bb134f3 100644
> > --- a/tools/perf/util/pmu.h
> > +++ b/tools/perf/util/pmu.h
> > @@ -257,10 +257,6 @@ void perf_pmu__warn_invalid_formats(struct perf_pm=
u *pmu);
> >  bool perf_pmu__has_hybrid(void);
> >  int perf_pmu__match(char *pattern, char *name, char *tok);
> >
> > -int perf_pmu__cpus_match(struct perf_pmu *pmu, struct perf_cpu_map *cp=
us,
> > -                      struct perf_cpu_map **mcpus_ptr,
> > -                      struct perf_cpu_map **ucpus_ptr);
> > -
> >  char *pmu_find_real_name(const char *name);
> >  char *pmu_find_alias_name(const char *name);
> >  double perf_pmu__cpu_slots_per_cycle(void);
