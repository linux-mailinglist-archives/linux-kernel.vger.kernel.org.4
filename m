Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0237C6B7A3F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 15:24:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231297AbjCMOYM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 10:24:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230184AbjCMOYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 10:24:09 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E53030CA
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 07:24:08 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id i5so13139618pla.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 07:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678717448;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lRjLsWD1s9PiUGUflXB9OZ/ZFzhXexQY3ic+6NuDrAw=;
        b=bHeNsG2jilm8VVoda3xJW8bP8NR1kruZpYxXXhvl9C02MhFWtPV5ykuXAvFS2aoiSD
         3kQ/HklZxmvA2dZGWVgWG1C0ds/MfflSaTujjmctTBTUq7BwVy9KtXkhs2K5ST79aX2a
         R16bt4Rn6llSXtUKqy4Vspaa9TcsnG/2Xs15O8rjBDLpfxcLvBjj/JY3A5O5BLudMCWB
         r0GzKQ4t3xjnn0M/77ryO0Dnhic6QFMiqebac2bICLhVFdTS/gtAZfg974tEFk4SXebD
         ZArZ+c5Ss2prhtc29BaBhQKm/Pi0CaJj/LwJWynZM+Hh4Vtq+YIAsQhQODSbbYU51Dlb
         /5UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678717448;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lRjLsWD1s9PiUGUflXB9OZ/ZFzhXexQY3ic+6NuDrAw=;
        b=61RhcoAAWQ5X8GbiW9TYxeKSvSEUOYSriZlta/uYOV91VU2iMwvF6Bi6gxJb2HU7dR
         Hev/n0GzFRqgy18ot1CpsqSsqyYVlPcu6VOGQuvaWTq740CAAKGb5OOLVVgnqSz4DXfc
         8PCteG2ZxLD6Vvf9xYojGXcnrY8IgCH8x8AVp+cFdj66wlckKIkCvVAQPrYTcGm4B0Ur
         GgTEvzEhLkk4713r4WyBZnq/lo5pGjYu5Em/fVD9RuJFpjoq/n6xQmapJpVNHVKcALPU
         CUBD+dN8NjYTMPjuUg3m9ejJR2EhnkKBsbokZF8cg1oXGtnqHwAQKOlcnWPxa5iK6xMv
         qk5A==
X-Gm-Message-State: AO0yUKXlAGoZgDbP4mmOTTV95SRxk9u8gvmT8H55JHl3xmp2t1KLVFba
        6oMm5HTmHG4G+B4l+SmYEtejPt1TnlBoZ6qVB9rEFA==
X-Google-Smtp-Source: AK7set99AoSrsJYq26IuPeH2owEbi3TBQiXc2EgAUIug3mtxMgJTyTzqWMZQXXWtLTkgLtP1HJS7KuLAP5qspVt7kfg=
X-Received: by 2002:a17:90b:3889:b0:233:c921:ab7e with SMTP id
 mu9-20020a17090b388900b00233c921ab7emr4123190pjb.4.1678717447861; Mon, 13 Mar
 2023 07:24:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230306132418.50389-1-zhangqiao22@huawei.com>
 <20230309130524.GA273121@hirez.programming.kicks-ass.net> <CAKfTPtAf5RrzZRSHtfK+r3QvnFQ-oM3+rJ-z5SB8T4+nUv1aQw@mail.gmail.com>
 <20230309142825.GB273121@hirez.programming.kicks-ass.net> <ZAnvCGdlOrWbIC/o@hirez.programming.kicks-ass.net>
 <CAKfTPtADUas2QHZCQyu0ad-JTKRQ=PcsB=o7+PuJNVxHwAzkCQ@mail.gmail.com>
 <ZAs+zV0o9ShO7nLT@vingu-book> <ef2f07f1-fe3a-624f-52e7-1089138dc137@huawei.com>
In-Reply-To: <ef2f07f1-fe3a-624f-52e7-1089138dc137@huawei.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 13 Mar 2023 15:23:56 +0100
Message-ID: <CAKfTPtBaBdxfc9uoViNT8gsWU-GdgnHrDdWPpAduadTFmu1ZGg@mail.gmail.com>
Subject: Re: [PATCH v2] sched/fair: sanitize vruntime of entity being migrated
To:     Zhang Qiao <zhangqiao22@huawei.com>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, rkagan@amazon.de,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Mar 2023 at 10:57, Zhang Qiao <zhangqiao22@huawei.com> wrote:
>
>
>
> =E5=9C=A8 2023/3/10 22:29, Vincent Guittot =E5=86=99=E9=81=93:
> > Le jeudi 09 mars 2023 =C3=A0 16:14:38 (+0100), Vincent Guittot a =C3=A9=
crit :
> >> On Thu, 9 Mar 2023 at 15:37, Peter Zijlstra <peterz@infradead.org> wro=
te:
> >>>
> >>> On Thu, Mar 09, 2023 at 03:28:25PM +0100, Peter Zijlstra wrote:
> >>>> On Thu, Mar 09, 2023 at 02:34:05PM +0100, Vincent Guittot wrote:
> >>>>
> >>>>> Then, even if we don't clear exec_start before migrating and keep
> >>>>> current value to be used in place_entity on the new cpu, we can't
> >>>>> compare the rq_clock_task(rq_of(cfs_rq)) of 2 different rqs AFAICT
> >>>>
> >>>> Blergh -- indeed, irq and steal time can skew them between CPUs :/
> >>>> I suppose we can fudge that... wait_start (which is basically what w=
e're
> >>>> making it do) also does that IIRC.
> >>>>
> >>>> I really dislike having this placement muck spreadout like proposed.
> >>>
> >>> Also, I think we might be over-engineering this, we don't care about
> >>> accuracy at all, all we really care about is 'long-time'.
> >>
> >> you mean taking the patch 1/2 that you mentioned here to add a
> >> migrated field:
> >> https://lore.kernel.org/all/68832dfbb60fda030540b5f4e39c5801942689b1.1=
648228023.git.tim.c.chen@linux.intel.com/T/#ma5637eb8010f3f4a4abff778af8db7=
05429d003b
> >>
> >> And assume that the divergence between the rq_clock_task() can be igno=
red ?
> >>
> >> That could probably work but we need to replace the (60LL *
> >> NSEC_PER_SEC) by ((1ULL << 63) / NICE_0_LOAD) because 60sec divergence
> >> would not be unrealistic.
> >> and a comment to explain why it's acceptable
> >
> > Zhang,
> >
> > Could you try the patch below ?
> > This is a rebase/merge/update of:
> > -patch 1/2 above and
> > -https://lore.kernel.org/lkml/20230209193107.1432770-1-rkagan@amazon.de=
/
>
>
> I applyed and tested this patch, and it make hackbench slower.
> According to my previous test results. The good result is 82.1(s).
> But the result of this patch is 108.725(s).

By "the result of this patch is 108.725(s)",  you mean the result of
https://lore.kernel.org/lkml/20230209193107.1432770-1-rkagan@amazon.de/
alone, don't you ?

>
>
> > version1: v6.2
> > version2: v6.2 + commit 829c1651e9c4
> > version3: v6.2 + commit 829c1651e9c4 + this patch
> >
> > -------------------------------------------------
> >       version1        version2        version3
> > test1 81.0            118.1           82.1
> > test2 82.1            116.9           80.3
> > test3 83.2            103.9           83.3
> > avg(s)        82.1            113.0           81.9

Ok, it looks like we are back to normal figures

> >
> > -------------------------------------------------
> >
> > The proposal accepts a divergence of up to 52 days between the 2 rqs.
> >
> > If this work, we will prepare a proper patch
> >
> > diff --git a/include/linux/sched.h b/include/linux/sched.h
> > index 63d242164b1a..cb8af0a137f7 100644
> > --- a/include/linux/sched.h
> > +++ b/include/linux/sched.h
> > @@ -550,6 +550,7 @@ struct sched_entity {
> >         struct rb_node                  run_node;
> >         struct list_head                group_node;
> >         unsigned int                    on_rq;
> > +       unsigned int                    migrated;
> >
> >         u64                             exec_start;
> >         u64                             sum_exec_runtime;
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 7a1b1f855b96..36acd9598b40 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -1057,6 +1057,7 @@ update_stats_curr_start(struct cfs_rq *cfs_rq, st=
ruct sched_entity *se)
> >         /*
> >          * We are starting a new run period:
> >          */
> > +       se->migrated =3D 0;
> >         se->exec_start =3D rq_clock_task(rq_of(cfs_rq));
> >  }
> >
> > @@ -4684,13 +4685,23 @@ place_entity(struct cfs_rq *cfs_rq, struct sche=
d_entity *se, int initial)
> >
> >         /*
> >          * Pull vruntime of the entity being placed to the base level o=
f
> > -        * cfs_rq, to prevent boosting it if placed backwards.  If the =
entity
> > -        * slept for a long time, don't even try to compare its vruntim=
e with
> > -        * the base as it may be too far off and the comparison may get
> > -        * inversed due to s64 overflow.
> > +        * cfs_rq, to prevent boosting it if placed backwards.
> > +        * However, min_vruntime can advance much faster than real time=
, with
> > +        * the exterme being when an entity with the minimal weight alw=
ays runs
> > +        * on the cfs_rq. If the new entity slept for long, its vruntim=
e
> > +        * difference from min_vruntime may overflow s64 and their comp=
arison
> > +        * may get inversed, so ignore the entity's original vruntime i=
n that
> > +        * case.
> > +        * The maximal vruntime speedup is given by the ratio of normal=
 to
> > +        * minimal weight: NICE_0_LOAD / MIN_SHARES, so cutting off on =
the
>
> why not is `scale_load_down(NICE_0_LOAD) / MIN_SHARES` here ?

yes, you are right.

>
>
> > +        * sleep time of 2^63 / NICE_0_LOAD should be safe.
> > +        * When placing a migrated waking entity, its exec_start has be=
en set
> > +        * from a different rq. In order to take into account a possibl=
e
> > +        * divergence between new and prev rq's clocks task because of =
irq and
>
> This divergence might be larger, it cause `sleep_time` maybe negative.

AFAICT, we are safe with ((1ULL << 63) / scale_load_down(NICE_0_LOAD)
/ 2) as long as the divergence between the 2 rqs clocks task is lower
than 2^52nsec. Do you expect a divergence higher than 2^52 nsec
(around 52 days)?

We can probably keep using (1ULL << 63) / scale_load_down(NICE_0_LOAD)
which is already half the max value if needed.

the fact that sleep_time can be negative is not a problem as
s64)sleep_time > will take care of this.

>
> > +        * stolen time, we take an additional margin.
> >          */
> >         sleep_time =3D rq_clock_task(rq_of(cfs_rq)) - se->exec_start;
> > -       if ((s64)sleep_time > 60LL * NSEC_PER_SEC)
> > +       if ((s64)sleep_time > (1ULL << 63) / NICE_0_LOAD / 2)>         =
        se->vruntime =3D vruntime;
> >         else
> >                 se->vruntime =3D max_vruntime(se->vruntime, vruntime);
> > @@ -7658,7 +7669,7 @@ static void migrate_task_rq_fair(struct task_stru=
ct *p, int new_cpu)
> >         se->avg.last_update_time =3D 0;
> >
> >         /* We have migrated, no longer consider this task hot */
> > -       se->exec_start =3D 0;
> > +       se->migrated =3D 1;
> >
> >         update_scan_period(p, new_cpu);
> >  }
> > @@ -8344,6 +8355,9 @@ static int task_hot(struct task_struct *p, struct=
 lb_env *env)
> >         if (sysctl_sched_migration_cost =3D=3D 0)
> >                 return 0;
> >
> > +       if (p->se.migrated)
> > +               return 0;
> > +
> >         delta =3D rq_clock_task(env->src_rq) - p->se.exec_start;
> >
> >         return delta < (s64)sysctl_sched_migration_cost;
> >
> >
> >
> >>
> >>
> >>>
> >>>
> > .
> >
