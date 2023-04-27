Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91C436F0D02
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 22:21:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344204AbjD0UVq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 16:21:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbjD0UVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 16:21:42 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D388044B2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 13:21:38 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-3ef31924c64so817241cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 13:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682626898; x=1685218898;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tv9hPro3OSS46Q/f2tjpHHoxuBPTiIMR9w3i55Rdxcc=;
        b=0yZ2Oyw2bblQbKhlgfyipR78kkpVUdvDIN0T/I4lnzugopXvEVUZrvW+kadcMwbzTB
         7qF9w77P1VD+kRTn1fZNsznCGmY6qzjK8Odku5g1bbx9YhC/cmBf6fNgRGwtsHhe7MKl
         fylSi5+InEPbgmCtepIZBX+h00LfI/t+QO99Nf/ywO/SiiE4gIKt1RL8mkYc4zv458tv
         PhPyzhhtjmugiY5RUibgl3Dk7pQpCiVCYrWJSVKl9EC4GcqkjyGPPmv9mf/JfDYFMg+i
         eaky+NLd0JNJaovy6hQlsq4NTauY8HkGPrK4UJzUjp2V60M6RIasnG1LLQRROcWWJobb
         7c8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682626898; x=1685218898;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tv9hPro3OSS46Q/f2tjpHHoxuBPTiIMR9w3i55Rdxcc=;
        b=hcMiLalgeme2dYdKkRxafXEHTbWbEacjU1H66NDdLHwHpTUPxwskDz6i+8P5wFGT5N
         I3OhQcg1fZG8g+5eN8hQoqEXS+hDl9eN/Qz/VeRQp8xVStwHryHv7vBIY4zfvDSEcAhW
         trga7Rfxob7pMpZUTCv8RRjzZXzttc2EjYASV29LGFHGP3QEW/4z0cvnYhh8ieK7yQlz
         +zwSHAOlCth7sayITJjn4gbVNarRANqXobfQ16HWMB2zy0YGDQWtdLTTt9786sd67Loz
         p/qoyODligYXxPWPUipPPPEcUKi2jH/pNhyFpkCLyRsdxpfV9W4dQthLldudL4Jwn0Pf
         DZMg==
X-Gm-Message-State: AC+VfDwGb1sdzSMprRbf/iSRSS2g2OiGtuPeBJxVBOcrK5EDTqStxRvc
        pp9HW99+lXBSx7/aU04Hyx9AuhLm1r+2Pnytv/qg/A==
X-Google-Smtp-Source: ACHHUZ6U+BkVoWvcvT7HGuTLRPwQfYt6isypBwcrWa5uqaXETipZ4bHzM57zGwA0G5r8XnvN3heRvCRCxrPfGM6fZkk=
X-Received: by 2002:a05:622a:188:b0:3ef:a55:7f39 with SMTP id
 s8-20020a05622a018800b003ef0a557f39mr83207qtw.12.1682626897716; Thu, 27 Apr
 2023 13:21:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230426070050.1315519-1-irogers@google.com> <20230426070050.1315519-2-irogers@google.com>
 <77dd1ab3-9c94-c04a-24de-f8c192a6c8d2@linux.intel.com>
In-Reply-To: <77dd1ab3-9c94-c04a-24de-f8c192a6c8d2@linux.intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 27 Apr 2023 13:21:25 -0700
Message-ID: <CAP-5=fVBFjnmCuzSud=oGj6nGCs7haMkALGS+ZGJEyD4dSYqTA@mail.gmail.com>
Subject: Re: [PATCH v1 01/40] perf stat: Introduce skippable evsels
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

On Thu, Apr 27, 2023 at 11:54=E2=80=AFAM Liang, Kan <kan.liang@linux.intel.=
com> wrote:
>
>
>
> On 2023-04-26 3:00 a.m., Ian Rogers wrote:
> > Perf stat with no arguments will use default events and metrics. These
> > events may fail to open even with kernel and hypervisor disabled. When
> > these fail then the permissions error appears even though they were
> > implicitly selected. This is particularly a problem with the automatic
> > selection of the TopdownL1 metric group on certain architectures like
> > Skylake:
> >
> > ```
> > $ perf stat true
> > Error:
> > Access to performance monitoring and observability operations is limite=
d.
> > Consider adjusting /proc/sys/kernel/perf_event_paranoid setting to open
> > access to performance monitoring and observability operations for proce=
sses
> > without CAP_PERFMON, CAP_SYS_PTRACE or CAP_SYS_ADMIN Linux capability.
> > More information can be found at 'Perf events and tool security' docume=
nt:
> > https://www.kernel.org/doc/html/latest/admin-guide/perf-security.html
> > perf_event_paranoid setting is 2:
> >   -1: Allow use of (almost) all events by all users
> >       Ignore mlock limit after perf_event_mlock_kb without CAP_IPC_LOCK
> >> =3D 0: Disallow raw and ftrace function tracepoint access
> >> =3D 1: Disallow CPU event access
> >> =3D 2: Disallow kernel profiling
> > To make the adjusted perf_event_paranoid setting permanent preserve it
> > in /etc/sysctl.conf (e.g. kernel.perf_event_paranoid =3D <setting>)
> > ```
> >
> > This patch adds skippable evsels that when they fail to open won't
> > fail and won't appear in output. The TopdownL1 events, from the metric
> > group, are marked as skippable. This turns the failure above to:
> >
> > ```
> > $ perf stat true
> >
> >  Performance counter stats for 'true':
> >
> >               1.26 msec task-clock:u                     #    0.328 CPU=
s utilized
> >                  0      context-switches:u               #    0.000 /se=
c
> >                  0      cpu-migrations:u                 #    0.000 /se=
c
> >                 49      page-faults:u                    #   38.930 K/s=
ec
> >            176,449      cycles:u                         #    0.140 GHz=
                         (48.99%)
> >            122,905      instructions:u                   #    0.70  ins=
n per cycle
> >             28,264      branches:u                       #   22.456 M/s=
ec
> >              2,405      branch-misses:u                  #    8.51% of =
all branches
> >
> >        0.003834565 seconds time elapsed
> >
> >        0.000000000 seconds user
> >        0.004130000 seconds sys
> > ```
>
> If the same command runs with root permission, a different output will
> be displayed as below:
>
> $ sudo ./perf stat sleep 1
>
>  Performance counter stats for 'sleep 1':
>
>               0.97 msec task-clock                       #    0.001 CPUs
> utilized
>                  1      context-switches                 #    1.030 K/sec
>                  0      cpu-migrations                   #    0.000 /sec
>                 67      page-faults                      #   69.043 K/sec
>          1,135,552      cycles                           #    1.170 GHz
>                        (50.51%)
>          1,126,446      instructions                     #    0.99  insn
> per cycle
>            252,904      branches                         #  260.615 M/sec
>              7,297      branch-misses                    #    2.89% of
> all branches
>             22,518      CPU_CLK_UNHALTED.REF_XCLK        #   23.205
> M/sec
>             56,994      INT_MISC.RECOVERY_CYCLES_ANY     #   58.732 M/sec
>
> The last two events are useless.

You missed the system wide (-a) flag.

Thanks,
Ian

> It's not reliable to rely on perf_event_open()/kernel to tell whether
> an event is available or skippable. Kernel wouldn't check a specific even=
t.
>
> The patch works for the non-root mode is just because the event requires
> root permission. It's rejected by the kernel because of lacking
> permission. But if the same command runs with root privileges, the trash
> events are printed as above.
>
> I think a better way is to check the HW capability and decided whether
> to append the TopdownL1 metrics.
>
> https://lore.kernel.org/lkml/20230427182906.3411695-1-kan.liang@linux.int=
el.com/
>
>
> Thanks,
> Kan
>
>
> >
> > When the events can have kernel/hypervisor disabled, like on
> > Tigerlake, then it continues to succeed as:
> >
> > ```
> > $ perf stat true
> >
> >  Performance counter stats for 'true':
> >
> >               0.57 msec task-clock:u                     #    0.385 CPU=
s utilized
> >                  0      context-switches:u               #    0.000 /se=
c
> >                  0      cpu-migrations:u                 #    0.000 /se=
c
> >                 47      page-faults:u                    #   82.329 K/s=
ec
> >            287,017      cycles:u                         #    0.503 GHz
> >            133,318      instructions:u                   #    0.46  ins=
n per cycle
> >             31,396      branches:u                       #   54.996 M/s=
ec
> >              2,442      branch-misses:u                  #    7.78% of =
all branches
> >            998,790      TOPDOWN.SLOTS:u                  #     14.5 %  =
tma_retiring
> >                                                   #     27.6 %  tma_bac=
kend_bound
> >                                                   #     40.9 %  tma_fro=
ntend_bound
> >                                                   #     17.0 %  tma_bad=
_speculation
> >            144,922      topdown-retiring:u
> >            411,266      topdown-fe-bound:u
> >            258,510      topdown-be-bound:u
> >            184,090      topdown-bad-spec:u
> >              2,585      INT_MISC.UOP_DROPPING:u          #    4.528 M/s=
ec
> >              3,434      cpu/INT_MISC.RECOVERY_CYCLES,cmask=3D1,edge/u #=
    6.015 M/sec
> >
> >        0.001480954 seconds time elapsed
> >
> >        0.000000000 seconds user
> >        0.001686000 seconds sys
> > ```
> >
> > And this likewise works if paranoia allows or running as root.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/builtin-stat.c      | 39 ++++++++++++++++++++++++++--------
> >  tools/perf/util/evsel.c        | 15 +++++++++++--
> >  tools/perf/util/evsel.h        |  1 +
> >  tools/perf/util/stat-display.c |  4 ++++
> >  4 files changed, 48 insertions(+), 11 deletions(-)
> >
> > diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> > index efda63f6bf32..eb34f5418ad3 100644
> > --- a/tools/perf/builtin-stat.c
> > +++ b/tools/perf/builtin-stat.c
> > @@ -667,6 +667,13 @@ static enum counter_recovery stat_handle_error(str=
uct evsel *counter)
> >                       evsel_list->core.threads->err_thread =3D -1;
> >                       return COUNTER_RETRY;
> >               }
> > +     } else if (counter->skippable) {
> > +             if (verbose > 0)
> > +                     ui__warning("skipping event %s that kernel failed=
 to open .\n",
> > +                                 evsel__name(counter));
> > +             counter->supported =3D false;
> > +             counter->errored =3D true;
> > +             return COUNTER_SKIP;
> >       }
> >
> >       evsel__open_strerror(counter, &target, errno, msg, sizeof(msg));
> > @@ -1885,15 +1892,29 @@ static int add_default_attributes(void)
> >                * Add TopdownL1 metrics if they exist. To minimize
> >                * multiplexing, don't request threshold computation.
> >                */
> > -             if (metricgroup__has_metric("TopdownL1") &&
> > -                 metricgroup__parse_groups(evsel_list, "TopdownL1",
> > -                                         /*metric_no_group=3D*/false,
> > -                                         /*metric_no_merge=3D*/false,
> > -                                         /*metric_no_threshold=3D*/tru=
e,
> > -                                         stat_config.user_requested_cp=
u_list,
> > -                                         stat_config.system_wide,
> > -                                         &stat_config.metric_events) <=
 0)
> > -                     return -1;
> > +             if (metricgroup__has_metric("TopdownL1")) {
> > +                     struct evlist *metric_evlist =3D evlist__new();
> > +                     struct evsel *metric_evsel;
> > +
> > +                     if (!metric_evlist)
> > +                             return -1;
> > +
> > +                     if (metricgroup__parse_groups(metric_evlist, "Top=
downL1",
> > +                                                     /*metric_no_group=
=3D*/false,
> > +                                                     /*metric_no_merge=
=3D*/false,
> > +                                                     /*metric_no_thres=
hold=3D*/true,
> > +                                                     stat_config.user_=
requested_cpu_list,
> > +                                                     stat_config.syste=
m_wide,
> > +                                                     &stat_config.metr=
ic_events) < 0)
> > +                             return -1;
> > +
> > +                     evlist__for_each_entry(metric_evlist, metric_evse=
l) {
> > +                             metric_evsel->skippable =3D true;
> > +                     }
> > +                     evlist__splice_list_tail(evsel_list, &metric_evli=
st->core.entries);
> > +                     evlist__delete(metric_evlist);
> > +             }
> > +
> >               /* Platform specific attrs */
> >               if (evlist__add_default_attrs(evsel_list, default_null_at=
trs) < 0)
> >                       return -1;
> > diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> > index 356c07f03be6..1cd04b5998d2 100644
> > --- a/tools/perf/util/evsel.c
> > +++ b/tools/perf/util/evsel.c
> > @@ -290,6 +290,7 @@ void evsel__init(struct evsel *evsel,
> >       evsel->per_pkg_mask  =3D NULL;
> >       evsel->collect_stat  =3D false;
> >       evsel->pmu_name      =3D NULL;
> > +     evsel->skippable     =3D false;
> >  }
> >
> >  struct evsel *evsel__new_idx(struct perf_event_attr *attr, int idx)
> > @@ -1725,9 +1726,13 @@ static int get_group_fd(struct evsel *evsel, int=
 cpu_map_idx, int thread)
> >               return -1;
> >
> >       fd =3D FD(leader, cpu_map_idx, thread);
> > -     BUG_ON(fd =3D=3D -1);
> > +     BUG_ON(fd =3D=3D -1 && !leader->skippable);
> >
> > -     return fd;
> > +     /*
> > +      * When the leader has been skipped, return -2 to distinguish fro=
m no
> > +      * group leader case.
> > +      */
> > +     return fd =3D=3D -1 ? -2 : fd;
> >  }
> >
> >  static void evsel__remove_fd(struct evsel *pos, int nr_cpus, int nr_th=
reads, int thread_idx)
> > @@ -2109,6 +2114,12 @@ static int evsel__open_cpu(struct evsel *evsel, =
struct perf_cpu_map *cpus,
> >
> >                       group_fd =3D get_group_fd(evsel, idx, thread);
> >
> > +                     if (group_fd =3D=3D -2) {
> > +                             pr_debug("broken group leader for %s\n", =
evsel->name);
> > +                             err =3D -EINVAL;
> > +                             goto out_close;
> > +                     }
> > +
> >                       test_attr__ready();
> >
> >                       /* Debug message used by test scripts */
> > diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
> > index 35805dcdb1b9..bf8f01af1c0b 100644
> > --- a/tools/perf/util/evsel.h
> > +++ b/tools/perf/util/evsel.h
> > @@ -95,6 +95,7 @@ struct evsel {
> >               bool                    weak_group;
> >               bool                    bpf_counter;
> >               bool                    use_config_name;
> > +             bool                    skippable;
> >               int                     bpf_fd;
> >               struct bpf_object       *bpf_obj;
> >               struct list_head        config_terms;
> > diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-disp=
lay.c
> > index e6035ecbeee8..6b46bbb3d322 100644
> > --- a/tools/perf/util/stat-display.c
> > +++ b/tools/perf/util/stat-display.c
> > @@ -810,6 +810,10 @@ static bool should_skip_zero_counter(struct perf_s=
tat_config *config,
> >       struct perf_cpu cpu;
> >       int idx;
> >
> > +     /* Skip counters that were speculatively/default enabled rather t=
han requested. */
> > +     if (counter->skippable)
> > +             return true;
> > +
> >       /*
> >        * Skip value 0 when enabling --per-thread globally,
> >        * otherwise it will have too many 0 output.
