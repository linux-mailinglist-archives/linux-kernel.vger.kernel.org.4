Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3BB36EFE8D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 02:37:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242758AbjD0Ahc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 20:37:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjD0Ah3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 20:37:29 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 522212D79
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 17:37:27 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-3f0a2f8216fso574621cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 17:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682555846; x=1685147846;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dtpbYg47MRBFbPma5G4Rl0iDpKzymK6csYe1V0e2k3w=;
        b=fjarVsT4m4//eQKvpKCMrv+k+J4/QwkksLbrLayg/9sIoSpxGJkeqWo+QKCKcTNyCe
         nxeyDVUVSDs/GID0edmdUJKdQBbzSZBTeDCMmZbh7HCkaFjlRPwsrJY+lgnh3cBbKrtg
         yaC34PRRwjLjDrg24IIkV6uiWUmCrb4z0RMJ1ZpFWuXSQudtLuJnlvQYD+81hilE+w46
         gt/FieNQVe6fBnnnvHFchwy4NI7f56uTxn+IP63q6G0w/bm0SyLKgd3voy6nDLPqMto5
         MytYAySEklkxCDqHcEmr4LZPzpCStXQB9EIsZDAPjpCNLWW+X/G70qKxdsm1nVEDwFv4
         daNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682555846; x=1685147846;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dtpbYg47MRBFbPma5G4Rl0iDpKzymK6csYe1V0e2k3w=;
        b=PYYscxICEZlt0pmLbEboqMpagY16/126XDQdJENUioaAdeklenxFkxKrgQVI6lQtzn
         zguiyKy+4lmiv0DK3CLk2rbqJf+y8nk66lu5b4MTlyqIVxEkyT/W52ZuPeO9pjf1+2Oe
         n2p/NgLz7j9H+CBva4fPblNR2P1K+Zr6SVEltN3Le1TTTeB8JY1SbIetxlqEj1ZhK+Wb
         /lwilKiy91itddPvTxWGjQfaQ5X5rkYO6OYulTdD7Ql1PbhSdCx0uwtB5kAvqlosSbIR
         l5d4A42geWyPmJaSGupnYnKWyh3t0A96RKhIGAZb13HFgn6U6L9NjfVyqBT15gQB9dtt
         iBwA==
X-Gm-Message-State: AC+VfDxxOSf1iOFRlSoXPsX4WZFAjv6jhpO6w0JsanHWj8scWPyIFoPw
        qnzv8dcySDs1qugzNmRK0LNrEKn/KfHGExj5SjS74g==
X-Google-Smtp-Source: ACHHUZ6lnJIHWqOGgunGlZ56M0yGtPHialXaA2rolExRCAx+mDniUvDphCESX6b1QkDtghBxc/f2jMIW7atpvWCZH4k=
X-Received: by 2002:ac8:7d4e:0:b0:3bf:e4e0:26a0 with SMTP id
 h14-20020ac87d4e000000b003bfe4e026a0mr31707qtb.14.1682555846265; Wed, 26 Apr
 2023 17:37:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230426070050.1315519-1-irogers@google.com> <20230426070050.1315519-2-irogers@google.com>
 <BYAPR11MB2807A842BCDCE8111D457378EC659@BYAPR11MB2807.namprd11.prod.outlook.com>
In-Reply-To: <BYAPR11MB2807A842BCDCE8111D457378EC659@BYAPR11MB2807.namprd11.prod.outlook.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 26 Apr 2023 17:37:11 -0700
Message-ID: <CAP-5=fWfAxmcTPoxBjg64q0Es=052itWZy1EXpUh5NG7bXFnnw@mail.gmail.com>
Subject: Re: [PATCH v1 01/40] perf stat: Introduce skippable evsels
To:     "Yasin, Ahmad" <ahmad.yasin@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        "Eranian, Stephane" <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        "Taylor, Perry" <perry.taylor@intel.com>,
        "Alt, Samantha" <samantha.alt@intel.com>,
        "Biggers, Caleb" <caleb.biggers@intel.com>,
        "Wang, Weilin" <weilin.wang@intel.com>,
        "Baker, Edward" <edward.baker@intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        "Hunter, Adrian" <adrian.hunter@intel.com>,
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
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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

On Wed, Apr 26, 2023 at 4:26=E2=80=AFPM Yasin, Ahmad <ahmad.yasin@intel.com=
> wrote:
>
> The output got needlessly lengthened with recent changes from Ian.
>
> These four metrics:
>                   #     14.5 %  tma_retiring
>                                                   #     27.6 %  tma_backe=
nd_bound
>                                                   #     40.9 %  tma_front=
end_bound
>                                                   #     17.0 %  tma_bad_s=
peculation
> better be appended on the right hand side of these four events (as curren=
t perf-stat does):
>            144,922      topdown-retiring:u
>            411,266      topdown-fe-bound:u
>            258,510      topdown-be-bound:u
>            184,090      topdown-bad-spec:u
>
> Also, I think we should not bother the default perf-stat users with the l=
ast two events:
>              2,585      INT_MISC.UOP_DROPPING:u          #    4.528 M/sec
>              3,434      cpu/INT_MISC.RECOVERY_CYCLES,cmask=3D1,edge/u #  =
  6.015 M/sec
>
> (yes, there are meant to increase accuracy of the previous tma_* level1 m=
etrics, but the underlying event vary from model to model, e.g. SKL to ICL =
to SPR).
>
> Besides, I can think on better metrics to append on the top-most TMA even=
t (TOPDOWN.SLOTS). tma_retiring does not belong there.
>
> Ahmad

Hi Ahmad,

when running perf without events and metrics you get a set of events
and metrics added for you. Previously this meant hard coded metrics
and these are just wrong. Their formulas are wrong, their thresholds
are wrong, they don't use groups correctly, they are inconsistent
between hybrid core types (appearing for one and not the other) and
there is more. When there is a hard coded metric then as they are
implicit from events being enabled, if I gather topdown level 3
metrics, topdown level 1 hard coded metrics may appear. So if I
generate CSV output I may or may not get implicitly added columns from
hard coded metrics. This bug was  introduced by Intel and we've
consistently requested a fix, including at our last face-to-face. On
top of this the hard coded metrics in Linux 6.3 use "saved values" for
aggregation and this is broken, counts are at least doubled in some
cases meaning depending on flags you get wildly wrong figures for, for
example, memory bandwidth. So everything is wrong in Linux 6.3 and
needed fixing - this is something that Intel have been testing since
February, for a bug introduced in October, but these complaints came
up 2 weeks ago. Note, ARM pointed out an issue with this patch series
in less than a day, which is awesome testing work!

The switch to json metrics is both documented in the code base as
being the desired route and also in presentations we have worked with
Intel on giving (over years). But anyway, the complaint keeps coming
back to the perf output when running without events or metrics. The
output of what are called "shadow stats" in perf is tied to the output
of events, for metrics it is tied to a "leading" event ie the first
event parsed. For perf metric (cpu or cpu_core topdown-*) events there
is a requirement that the group leader is slots, and so when there are
topdown events in a metric it follows that the metrics are all output
with the slots event. We could look to change this behavior but why?
The complaint is that the output is hard to read, but it is hard to
read regardless of json metrics. In the meeting today, "slots" is a
classic example of what users don't understand. This is a separate
problem than fixing bugs in aggregation, hybrid, etc. The naming
decision to use "tma_bad_speculation" rather than "Bad Speculation" as
used in Linux 6.3 was one that I recall you personally approving.

Adding back the hard coded metrics and output for 6.4 is a regression:
 - it will break CSV output when moving across architectures
 - there is no testing unlike the json metrics that are tested as part
of project Valkyrie
 - grouping, formulas, thresholds, etc. are broken.
 - the only compelling reason could be to avoid hybrid crashes, but
that is something far better solved with this patch series.

I understand toplev is using this output for the timed pebs work. It
should not! There are no tests on the text output of perf, but what
there are tests on are the CSV and Json output - that's why they
exist. Tools should be using the CSV and Json output, if text were to
be required tool output then there should be tests on it. I've asked
for toplev to be added to the shell tests every time this has come up
in the past. It is far better to fix toplev not to use text output.

These changes are about fixing hybrid not about the output format of
the perf tool. At no point during 6.4 development has the json metric
output changed. Complaining that a tool, toplev, needs fixing because
of this is the fault of the tool that was doing something wrong. Once
tools are not using the text output then we can fix it and make it
more human readable. There is no reason, for example, to include
events *at all* when displaying metrics. At the same time as cleaning
this up we can question whether IPC and branch miss rate should be
gathered, as these contribute to multiplexing - another reason to run
the tool with CSV or Json output with a named metric, metric group or
event.

I acknowledge your point but it is wrong. I can share today's slide
deck with you if it is useful, Sam said she would be following up
inside of Intel. The only proposed fix for 6.4 is to not enable the
TopdownL1 group on hybrid. This patch series is the proposed long-term
hybrid fix and for 6.5. Testing, reviews, etc. all very much
appreciated.

Thanks,
Ian

> -----Original Message-----
> From: Ian Rogers <irogers@google.com>
> Sent: Wednesday, April 26, 2023 10:00
> To: Arnaldo Carvalho de Melo <acme@kernel.org>; Kan Liang <kan.liang@linu=
x.intel.com>; Yasin, Ahmad <ahmad.yasin@intel.com>; Peter Zijlstra <peterz@=
infradead.org>; Ingo Molnar <mingo@redhat.com>; Eranian, Stephane <eranian@=
google.com>; Andi Kleen <ak@linux.intel.com>; Taylor, Perry <perry.taylor@i=
ntel.com>; Alt, Samantha <samantha.alt@intel.com>; Biggers, Caleb <caleb.bi=
ggers@intel.com>; Wang, Weilin <weilin.wang@intel.com>; Baker, Edward <edwa=
rd.baker@intel.com>; Mark Rutland <mark.rutland@arm.com>; Alexander Shishki=
n <alexander.shishkin@linux.intel.com>; Jiri Olsa <jolsa@kernel.org>; Namhy=
ung Kim <namhyung@kernel.org>; Hunter, Adrian <adrian.hunter@intel.com>; Fl=
orian Fischer <florian.fischer@muhq.space>; Rob Herring <robh@kernel.org>; =
Zhengjun Xing <zhengjun.xing@linux.intel.com>; John Garry <john.g.garry@ora=
cle.com>; Kajol Jain <kjain@linux.ibm.com>; Sumanth Korikkar <sumanthk@linu=
x.ibm.com>; Thomas Richter <tmricht@linux.ibm.com>; Tiezhu Yang <yangtiezhu=
@loongson.cn>; Ravi Bangoria <ravi.bangoria@amd.com>; Leo Yan <leo.yan@lina=
ro.org>; Yang Jihong <yangjihong1@huawei.com>; James Clark <james.clark@arm=
.com>; Suzuki Poulouse <suzuki.poulose@arm.com>; Kang Minchul <tegongkang@g=
mail.com>; Athira Rajeev <atrajeev@linux.vnet.ibm.com>; linux-perf-users@vg=
er.kernel.org; linux-kernel@vger.kernel.org
> Cc: Ian Rogers <irogers@google.com>
> Subject: [PATCH v1 01/40] perf stat: Introduce skippable evsels
>
> Perf stat with no arguments will use default events and metrics. These ev=
ents may fail to open even with kernel and hypervisor disabled. When these =
fail then the permissions error appears even though they were implicitly se=
lected. This is particularly a problem with the automatic selection of the =
TopdownL1 metric group on certain architectures like
> Skylake:
>
> ```
> $ perf stat true
> Error:
> Access to performance monitoring and observability operations is limited.
> Consider adjusting /proc/sys/kernel/perf_event_paranoid setting to open a=
ccess to performance monitoring and observability operations for processes =
without CAP_PERFMON, CAP_SYS_PTRACE or CAP_SYS_ADMIN Linux capability.
> More information can be found at 'Perf events and tool security' document=
:
> https://www.kernel.org/doc/html/latest/admin-guide/perf-security.html
> perf_event_paranoid setting is 2:
>   -1: Allow use of (almost) all events by all users
>       Ignore mlock limit after perf_event_mlock_kb without CAP_IPC_LOCK
> >=3D 0: Disallow raw and ftrace function tracepoint access =3D 1: Disallo=
w
> >CPU event access =3D 2: Disallow kernel profiling
> To make the adjusted perf_event_paranoid setting permanent preserve it in=
 /etc/sysctl.conf (e.g. kernel.perf_event_paranoid =3D <setting>) ```
>
> This patch adds skippable evsels that when they fail to open won't fail a=
nd won't appear in output. The TopdownL1 events, from the metric group, are=
 marked as skippable. This turns the failure above to:
>
> ```
> $ perf stat true
>
>  Performance counter stats for 'true':
>
>               1.26 msec task-clock:u                     #    0.328 CPUs =
utilized
>                  0      context-switches:u               #    0.000 /sec
>                  0      cpu-migrations:u                 #    0.000 /sec
>                 49      page-faults:u                    #   38.930 K/sec
>            176,449      cycles:u                         #    0.140 GHz  =
                       (48.99%)
>            122,905      instructions:u                   #    0.70  insn =
per cycle
>             28,264      branches:u                       #   22.456 M/sec
>              2,405      branch-misses:u                  #    8.51% of al=
l branches
>
>        0.003834565 seconds time elapsed
>
>        0.000000000 seconds user
>        0.004130000 seconds sys
> ```
>
> When the events can have kernel/hypervisor disabled, like on Tigerlake, t=
hen it continues to succeed as:
>
> ```
> $ perf stat true
>
>  Performance counter stats for 'true':
>
>               0.57 msec task-clock:u                     #    0.385 CPUs =
utilized
>                  0      context-switches:u               #    0.000 /sec
>                  0      cpu-migrations:u                 #    0.000 /sec
>                 47      page-faults:u                    #   82.329 K/sec
>            287,017      cycles:u                         #    0.503 GHz
>            133,318      instructions:u                   #    0.46  insn =
per cycle
>             31,396      branches:u                       #   54.996 M/sec
>              2,442      branch-misses:u                  #    7.78% of al=
l branches
>            998,790      TOPDOWN.SLOTS:u                  #     14.5 %  tm=
a_retiring
>                                                   #     27.6 %  tma_backe=
nd_bound
>                                                   #     40.9 %  tma_front=
end_bound
>                                                   #     17.0 %  tma_bad_s=
peculation
>            144,922      topdown-retiring:u
>            411,266      topdown-fe-bound:u
>            258,510      topdown-be-bound:u
>            184,090      topdown-bad-spec:u
>              2,585      INT_MISC.UOP_DROPPING:u          #    4.528 M/sec
>              3,434      cpu/INT_MISC.RECOVERY_CYCLES,cmask=3D1,edge/u #  =
  6.015 M/sec
>
>        0.001480954 seconds time elapsed
>
>        0.000000000 seconds user
>        0.001686000 seconds sys
> ```
>
> And this likewise works if paranoia allows or running as root.
>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/builtin-stat.c      | 39 ++++++++++++++++++++++++++--------
>  tools/perf/util/evsel.c        | 15 +++++++++++--
>  tools/perf/util/evsel.h        |  1 +
>  tools/perf/util/stat-display.c |  4 ++++
>  4 files changed, 48 insertions(+), 11 deletions(-)
>
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c index =
efda63f6bf32..eb34f5418ad3 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -667,6 +667,13 @@ static enum counter_recovery stat_handle_error(struc=
t evsel *counter)
>                         evsel_list->core.threads->err_thread =3D -1;
>                         return COUNTER_RETRY;
>                 }
> +       } else if (counter->skippable) {
> +               if (verbose > 0)
> +                       ui__warning("skipping event %s that kernel failed=
 to open .\n",
> +                                   evsel__name(counter));
> +               counter->supported =3D false;
> +               counter->errored =3D true;
> +               return COUNTER_SKIP;
>         }
>
>         evsel__open_strerror(counter, &target, errno, msg, sizeof(msg)); =
@@ -1885,15 +1892,29 @@ static int add_default_attributes(void)
>                  * Add TopdownL1 metrics if they exist. To minimize
>                  * multiplexing, don't request threshold computation.
>                  */
> -               if (metricgroup__has_metric("TopdownL1") &&
> -                   metricgroup__parse_groups(evsel_list, "TopdownL1",
> -                                           /*metric_no_group=3D*/false,
> -                                           /*metric_no_merge=3D*/false,
> -                                           /*metric_no_threshold=3D*/tru=
e,
> -                                           stat_config.user_requested_cp=
u_list,
> -                                           stat_config.system_wide,
> -                                           &stat_config.metric_events) <=
 0)
> -                       return -1;
> +               if (metricgroup__has_metric("TopdownL1")) {
> +                       struct evlist *metric_evlist =3D evlist__new();
> +                       struct evsel *metric_evsel;
> +
> +                       if (!metric_evlist)
> +                               return -1;
> +
> +                       if (metricgroup__parse_groups(metric_evlist, "Top=
downL1",
> +                                                       /*metric_no_group=
=3D*/false,
> +                                                       /*metric_no_merge=
=3D*/false,
> +                                                       /*metric_no_thres=
hold=3D*/true,
> +                                                       stat_config.user_=
requested_cpu_list,
> +                                                       stat_config.syste=
m_wide,
> +                                                       &stat_config.metr=
ic_events) < 0)
> +                               return -1;
> +
> +                       evlist__for_each_entry(metric_evlist, metric_evse=
l) {
> +                               metric_evsel->skippable =3D true;
> +                       }
> +                       evlist__splice_list_tail(evsel_list, &metric_evli=
st->core.entries);
> +                       evlist__delete(metric_evlist);
> +               }
> +
>                 /* Platform specific attrs */
>                 if (evlist__add_default_attrs(evsel_list, default_null_at=
trs) < 0)
>                         return -1;
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c index 356c=
07f03be6..1cd04b5998d2 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -290,6 +290,7 @@ void evsel__init(struct evsel *evsel,
>         evsel->per_pkg_mask  =3D NULL;
>         evsel->collect_stat  =3D false;
>         evsel->pmu_name      =3D NULL;
> +       evsel->skippable     =3D false;
>  }
>
>  struct evsel *evsel__new_idx(struct perf_event_attr *attr, int idx) @@ -=
1725,9 +1726,13 @@ static int get_group_fd(struct evsel *evsel, int cpu_map=
_idx, int thread)
>                 return -1;
>
>         fd =3D FD(leader, cpu_map_idx, thread);
> -       BUG_ON(fd =3D=3D -1);
> +       BUG_ON(fd =3D=3D -1 && !leader->skippable);
>
> -       return fd;
> +       /*
> +        * When the leader has been skipped, return -2 to distinguish fro=
m no
> +        * group leader case.
> +        */
> +       return fd =3D=3D -1 ? -2 : fd;
>  }
>
>  static void evsel__remove_fd(struct evsel *pos, int nr_cpus, int nr_thre=
ads, int thread_idx) @@ -2109,6 +2114,12 @@ static int evsel__open_cpu(stru=
ct evsel *evsel, struct perf_cpu_map *cpus,
>
>                         group_fd =3D get_group_fd(evsel, idx, thread);
>
> +                       if (group_fd =3D=3D -2) {
> +                               pr_debug("broken group leader for %s\n", =
evsel->name);
> +                               err =3D -EINVAL;
> +                               goto out_close;
> +                       }
> +
>                         test_attr__ready();
>
>                         /* Debug message used by test scripts */ diff --g=
it a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h index 35805dcdb1b9..=
bf8f01af1c0b 100644
> --- a/tools/perf/util/evsel.h
> +++ b/tools/perf/util/evsel.h
> @@ -95,6 +95,7 @@ struct evsel {
>                 bool                    weak_group;
>                 bool                    bpf_counter;
>                 bool                    use_config_name;
> +               bool                    skippable;
>                 int                     bpf_fd;
>                 struct bpf_object       *bpf_obj;
>                 struct list_head        config_terms;
> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-displa=
y.c index e6035ecbeee8..6b46bbb3d322 100644
> --- a/tools/perf/util/stat-display.c
> +++ b/tools/perf/util/stat-display.c
> @@ -810,6 +810,10 @@ static bool should_skip_zero_counter(struct perf_sta=
t_config *config,
>         struct perf_cpu cpu;
>         int idx;
>
> +       /* Skip counters that were speculatively/default enabled rather t=
han requested. */
> +       if (counter->skippable)
> +               return true;
> +
>         /*
>          * Skip value 0 when enabling --per-thread globally,
>          * otherwise it will have too many 0 output.
> --
> 2.40.1.495.gc816e09b53d-goog
>
> ---------------------------------------------------------------------
> Intel Israel (74) Limited
>
> This e-mail and any attachments may contain confidential material for
> the sole use of the intended recipient(s). Any review or distribution
> by others is strictly prohibited. If you are not the intended
> recipient, please contact the sender and delete all copies.
