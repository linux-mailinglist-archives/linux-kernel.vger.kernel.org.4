Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B0406B8C1E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 08:41:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbjCNHlp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 03:41:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjCNHln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 03:41:43 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 885B88C952
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 00:41:42 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id x11so15634775pln.12
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 00:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678779702;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X/attwMFOxpWb7eNF/MChUb1i1WD1E4IXSOJUH4CD2Y=;
        b=aZSpN7Wven4xaWMaTwgq00Y6w9K8H6AptVqZp9A4RsXHXsmZoDifVdRVYhsACVnRJr
         TpMgElDHrpbvVQFpKWLsALOxEPVAmtI+PYdrUPiDevM6Xe24H12r+A6CShmsakbi0st9
         ciTpqYuNrO3zghy3fe5hVZh68Mwcef9TLED5ZOHigX4YHLX72qxUxK5g/+/LEiXOBJG+
         DfEIIk1c+eg5sm9O1Mrl+aOwBf/NAZmoNQBou4IbTXxbu5UDIZZEPNmjWeX2txux7Rer
         povjcygDXHxnjIOhLO/iaCVDMVUNWQKEDeMmrCyECPbsMqL0LAdbfYsRCNNPE+jHVP/h
         9bZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678779702;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X/attwMFOxpWb7eNF/MChUb1i1WD1E4IXSOJUH4CD2Y=;
        b=15MX90xbpxum8z2PJA+VUH+xO5zqVMNxVdc3gaEwFI9mzHjFkjHftofZtKNIP5FINR
         NF54euUsnjyxfEf48d/Er57uGllX2C3alD6AKZcK4IaCSV7uzFLwOFD0hdWXe5+zoLyX
         MuPaiquLsWqg2sTwutUNJOY5zDJGejhx5+oQ63CdLsiFcJLjbrJBjFahA7eCshmO0tXW
         HhGGU6HLS0Rg71tpuLZO32PdBJynJHshm2q6tq8r9F+lvlqT+drwByuUFAIBuK1aLtL1
         V0IHRucEPFYxiHzS1EsdPuE63APGTg2ZInuTWiAlmsr5mfYFnoUhM9uyFHVkZ/ppBx1E
         +AdA==
X-Gm-Message-State: AO0yUKXJrv0MbxG/gKKyGwkgDpFzns2JzEc+6AHAU7tKsEWGWXKzSS6T
        a9h9wb1wYe86JVf+WQhDI1g/INNbESpVSvNqRR++uA==
X-Google-Smtp-Source: AK7set/UIjZ7kvLBT0snq0vmY9kxyJeywwIx/2qiEXhSyt/ppV58HioLuvAD3mxL+CcfJUeDz7VdJcMKID0bjDWrho4=
X-Received: by 2002:a17:90b:28f:b0:23d:3659:9710 with SMTP id
 az15-20020a17090b028f00b0023d36599710mr580120pjb.3.1678779701898; Tue, 14 Mar
 2023 00:41:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230306132418.50389-1-zhangqiao22@huawei.com>
 <20230309130524.GA273121@hirez.programming.kicks-ass.net> <CAKfTPtAf5RrzZRSHtfK+r3QvnFQ-oM3+rJ-z5SB8T4+nUv1aQw@mail.gmail.com>
 <20230309142825.GB273121@hirez.programming.kicks-ass.net> <ZAnvCGdlOrWbIC/o@hirez.programming.kicks-ass.net>
 <CAKfTPtADUas2QHZCQyu0ad-JTKRQ=PcsB=o7+PuJNVxHwAzkCQ@mail.gmail.com>
 <ZAs+zV0o9ShO7nLT@vingu-book> <02a08042-e7c4-464d-bc20-9ec4ccdab1ff@arm.com> <8c093661-7431-00d8-d703-b8f7a7c8e747@arm.com>
In-Reply-To: <8c093661-7431-00d8-d703-b8f7a7c8e747@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 14 Mar 2023 08:41:30 +0100
Message-ID: <CAKfTPtBw9SJxVBcN1qff7jRzE81kXSjbc-rXD6goEBFiXEwbyg@mail.gmail.com>
Subject: Re: [PATCH v2] sched/fair: sanitize vruntime of entity being migrated
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Zhang Qiao <zhangqiao22@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        juri.lelli@redhat.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        rkagan@amazon.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Mar 2023 at 19:17, Dietmar Eggemann <dietmar.eggemann@arm.com> w=
rote:
>
> On 13/03/2023 10:06, Dietmar Eggemann wrote:
> > On 10/03/2023 15:29, Vincent Guittot wrote:
> >> Le jeudi 09 mars 2023 =C3=AF=C2=BF=C2=BD 16:14:38 (+0100), Vincent Gui=
ttot a =C3=AF=C2=BF=C2=BDcrit :
> >>> On Thu, 9 Mar 2023 at 15:37, Peter Zijlstra <peterz@infradead.org> wr=
ote:
> >>>>
> >>>> On Thu, Mar 09, 2023 at 03:28:25PM +0100, Peter Zijlstra wrote:
> >>>>> On Thu, Mar 09, 2023 at 02:34:05PM +0100, Vincent Guittot wrote:
>
> [...]
>
> > Looks to me that this patch brings back the old numbers:
> >
> > model name    : Intel(R) Xeon(R) Silver 4314 CPU @ 2.40GHz
> >
> > perf stat --null --repeat 10 -- perf bench sched messaging -g 50 -l 500=
0
> >
> > tip sched/core
> >
> > a2e90611b9f4 - sched/fair: Remove capacity inversion detection
> > (2023-02-11 Vincent Guittot)
> >
> >   5.7295 +- 0.0219 seconds time elapsed  ( +-  0.38% )
> >
> > 829c1651e9c4 - sched/fair: sanitize vruntime of entity being placed
> > (2023-02-11 Zhang Qiao)
> >
> >   6.0961 +- 0.0297 seconds time elapsed  ( +-  0.49% )
> >
> > this patch on top 829c1651e9c4
> >
> >   5.7165 +- 0.0231 seconds time elapsed  ( +-  0.40% )
> >
> > [...]
>
> Couldn't we not just defer setting `se->exec_start =3D 0` until the end o=
f
> place_entity() for ENQUEUE_MIGRATED instead to avoid this extra se flag
> `migrated`?

Yes, that's a good point.

I'm going to use something a bit different from your proposal below by
merging initial and flag
static void place_entity(struct cfs_rq *cfs_rq, struct sched_entity
*se, int flags)

with flags:
0 for initial placement
ENQUEUE_WAKEUP for wakeup
ENQUEUE_MIGRATED for migrated task

>
> -->8--
>
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 0c70c558b12c..4df2b3e76b30 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -550,7 +550,6 @@ struct sched_entity {
>         struct rb_node                  run_node;
>         struct list_head                group_node;
>         unsigned int                    on_rq;
> -       unsigned int                    migrated;
>
>         u64                             exec_start;
>         u64                             sum_exec_runtime;
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index a8aa8cd3c745..365ee548e9f0 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -1057,7 +1057,6 @@ update_stats_curr_start(struct cfs_rq *cfs_rq, stru=
ct sched_entity *se)
>         /*
>          * We are starting a new run period:
>          */
> -       se->migrated =3D 0;
>         se->exec_start =3D rq_clock_task(rq_of(cfs_rq));
>  }
>
> @@ -4649,8 +4648,8 @@ static void check_spread(struct cfs_rq *cfs_rq, str=
uct sched_entity *se)
>  #endif
>  }
>
> -static void
> -place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int initial=
)
> +static void place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se,
> +                        int flags, int initial)
>  {
>         u64 vruntime =3D cfs_rq->min_vruntime;
>         u64 sleep_time;
> @@ -4705,6 +4704,9 @@ place_entity(struct cfs_rq *cfs_rq, struct sched_en=
tity *se, int initial)
>                 se->vruntime =3D vruntime;
>         else
>                 se->vruntime =3D max_vruntime(se->vruntime, vruntime);
> +
> +       if (flags & ENQUEUE_MIGRATED)
> +               se->exec_start =3D 0;
>  }
>
>  static void check_enqueue_throttle(struct cfs_rq *cfs_rq);
> @@ -4780,7 +4782,7 @@ enqueue_entity(struct cfs_rq *cfs_rq, struct sched_=
entity *se, int flags)
>         account_entity_enqueue(cfs_rq, se);
>
>         if (flags & ENQUEUE_WAKEUP)
> -               place_entity(cfs_rq, se, 0);
> +               place_entity(cfs_rq, se, flags, 0);
>
>         check_schedstat_required();
>         update_stats_enqueue_fair(cfs_rq, se, flags);
> @@ -7668,9 +7670,6 @@ static void migrate_task_rq_fair(struct task_struct=
 *p, int new_cpu)
>         /* Tell new CPU we are migrated */
>         se->avg.last_update_time =3D 0;
>
> -       /* We have migrated, no longer consider this task hot */
> -       se->migrated =3D 1;
> -
>         update_scan_period(p, new_cpu);
>  }
>
> @@ -8355,9 +8354,6 @@ static int task_hot(struct task_struct *p, struct l=
b_env *env)
>         if (sysctl_sched_migration_cost =3D=3D 0)
>                 return 0;
>
> -       if (p->se.migrated)
> -               return 0;
> -
>         delta =3D rq_clock_task(env->src_rq) - p->se.exec_start;
>
>         return delta < (s64)sysctl_sched_migration_cost;
> @@ -11999,7 +11995,7 @@ static void task_fork_fair(struct task_struct *p)
>                 update_curr(cfs_rq);
>                 se->vruntime =3D curr->vruntime;
>         }
> -       place_entity(cfs_rq, se, 1);
> +       place_entity(cfs_rq, se, 0, 1);
>
>         if (sysctl_sched_child_runs_first && curr && entity_before(curr, =
se)) {
>                 /*
> @@ -12144,7 +12140,7 @@ static void detach_task_cfs_rq(struct task_struct=
 *p)
>                  * Fix up our vruntime so that the current sleep doesn't
>                  * cause 'unlimited' sleep bonus.
>                  */
> -               place_entity(cfs_rq, se, 0);
> +               place_entity(cfs_rq, se, 0, 0);
>                 se->vruntime -=3D cfs_rq->min_vruntime;
>         }
>
>
