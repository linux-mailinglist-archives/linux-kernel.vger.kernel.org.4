Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F10216BB7D3
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 16:30:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232234AbjCOPax (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 11:30:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbjCOPav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 11:30:51 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0799E1A499
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 08:30:49 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id ce7so11943370pfb.9
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 08:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678894248;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xcGVieuMyZZ9Lj0ZjbNO9WSYV9aPOeRlOXTIocxgwDI=;
        b=mTuCvShyw7OUU+lmxBFmYqQKDk70Be/gZccprZQXr5u1iUz80HyfKC17m1VWGc1XC+
         M62nmB6qHzJCMlKo2NBEY8LqzyRWT76j5j75kjOnfeh02ULmctCG69/Uvs/r1jAndpkG
         XBApOpyDkyhjZ+txFyA1ACG+P8+7WydhbZHIqqHiVqEADJ85K6ZS71NZlVxgGcYTHgHs
         dKduRXl7iDqZcmCT1b7P2NFouyD04em5RwLVDr2vAw+WoLIV0OIP1cvOOKubS/jjaFLw
         IRnkdLGoIUokXXNQtrNswT0mrUSVQqjn9NWxVxs6oldMlmH0IR0yk2emB43LCwk2idO4
         Si2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678894248;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xcGVieuMyZZ9Lj0ZjbNO9WSYV9aPOeRlOXTIocxgwDI=;
        b=ZE9m3SjqfwyHvmp+ESFLRKgAJ9dBBf7CuMrop8MFplkg/6jcDMHbUpJvQS+iHBJFSD
         C2m1JwYZDI26QC4wwyhOJOvUAgfhBxfL/deTMSbOpOpeh2wtdcLkPZU1g5CqLDSCcf0R
         EJXjedJ8ME/ICKCN/hn7MCn9xtbhKRcAyP4wKZy8XQPWYEvsQ3Zm2RiTpEtSLiNBzSiS
         QiV/0PNX/TRDk0CpkOpUg/K+tVS12Kp9lrQK9VLLfYgk7lv/N4juKl4rDtPLmU8N9PyH
         M51OBlQHrDzaFH8fxLl2UD0L+NBEwwlQRhLF8i8X/36bFZMWtCSfWGjtgfakosOLQv2b
         gzcg==
X-Gm-Message-State: AO0yUKXMo50zy/dHbYr1twoaD44rI99nz7K3a1mJDpm0QZLYfYq6zfTi
        BvRhlLVQV4qeIOvzlCotPcoDx1rqqDe6sMTQpfoq4g==
X-Google-Smtp-Source: AK7set9uUJkr/m5aMRZRV8E6KYfqG9MkQgZDvnM6WbHgmMcu3ZsirYUxO/GO7QYeKgfm59yuVvSO6vrpH08s7XoOjoM=
X-Received: by 2002:a63:5904:0:b0:4fc:7e60:d0c with SMTP id
 n4-20020a635904000000b004fc7e600d0cmr14084362pgb.11.1678894248362; Wed, 15
 Mar 2023 08:30:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230309142825.GB273121@hirez.programming.kicks-ass.net>
 <ZAnvCGdlOrWbIC/o@hirez.programming.kicks-ass.net> <CAKfTPtADUas2QHZCQyu0ad-JTKRQ=PcsB=o7+PuJNVxHwAzkCQ@mail.gmail.com>
 <ZAs+zV0o9ShO7nLT@vingu-book> <ef2f07f1-fe3a-624f-52e7-1089138dc137@huawei.com>
 <CAKfTPtBaBdxfc9uoViNT8gsWU-GdgnHrDdWPpAduadTFmu1ZGg@mail.gmail.com>
 <55754a59-a01f-206a-43f6-d07ea37300dd@huawei.com> <CAKfTPtCCQ0__kz8UfaSm7qrpOQc47rPheD+KLoyBAbmp_tLP0w@mail.gmail.com>
 <3f43273a-5b73-0a44-a452-8a8427bb9ff2@huawei.com> <CAKfTPtD7g5JKDAbob0pPS8EPsHGZhjrE+JEuiEmj19moFbY1HQ@mail.gmail.com>
 <ZBCTg/dGAIRsldHU@vingu-book> <5a08aa29-f197-1379-c441-8c1db5fa7ab7@huawei.com>
In-Reply-To: <5a08aa29-f197-1379-c441-8c1db5fa7ab7@huawei.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 15 Mar 2023 16:30:36 +0100
Message-ID: <CAKfTPtC8a-Psp=2z0COfvKQm_M3NGBZF8++bYJn6xRseSvE-Fw@mail.gmail.com>
Subject: Re: [PATCH v2] sched/fair: sanitize vruntime of entity being migrated
To:     Zhang Qiao <zhangqiao22@huawei.com>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, rkagan@amazon.de,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DIET_1,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Mar 2023 at 10:16, Zhang Qiao <zhangqiao22@huawei.com> wrote:
>
>
>
> =E5=9C=A8 2023/3/14 23:32, Vincent Guittot =E5=86=99=E9=81=93:
> > Le mardi 14 mars 2023 =C3=A0 14:39:49 (+0100), Vincent Guittot a =C3=A9=
crit :
> >> On Tue, 14 Mar 2023 at 14:38, Zhang Qiao <zhangqiao22@huawei.com> wrot=
e:
> >>>
> >>>
> >>>
> >>> =E5=9C=A8 2023/3/14 21:26, Vincent Guittot =E5=86=99=E9=81=93:
> >>>> On Tue, 14 Mar 2023 at 12:03, Zhang Qiao <zhangqiao22@huawei.com> wr=
ote:
> >>>>>
> >>>>>
> >>>>>
> >>>>> =E5=9C=A8 2023/3/13 22:23, Vincent Guittot =E5=86=99=E9=81=93:
> >>>>>> On Sat, 11 Mar 2023 at 10:57, Zhang Qiao <zhangqiao22@huawei.com> =
wrote:
> >>>>>>>
> >>>>>>>
> >>>>>>>
> >>>>>>> =E5=9C=A8 2023/3/10 22:29, Vincent Guittot =E5=86=99=E9=81=93:
> >>>>>>>> Le jeudi 09 mars 2023 =C3=A0 16:14:38 (+0100), Vincent Guittot a=
 =C3=A9crit :
> >>>>>>>>> On Thu, 9 Mar 2023 at 15:37, Peter Zijlstra <peterz@infradead.o=
rg> wrote:
> >>>>>>>>>>
> >>>>>>>>>> On Thu, Mar 09, 2023 at 03:28:25PM +0100, Peter Zijlstra wrote=
:
> >>>>>>>>>>> On Thu, Mar 09, 2023 at 02:34:05PM +0100, Vincent Guittot wro=
te:
> >>>>>>>>>>>
> >>>>>>>>>>>> Then, even if we don't clear exec_start before migrating and=
 keep
> >>>>>>>>>>>> current value to be used in place_entity on the new cpu, we =
can't
> >>>>>>>>>>>> compare the rq_clock_task(rq_of(cfs_rq)) of 2 different rqs =
AFAICT
> >>>>>>>>>>>
> >>>>>>>>>>> Blergh -- indeed, irq and steal time can skew them between CP=
Us :/
> >>>>>>>>>>> I suppose we can fudge that... wait_start (which is basically=
 what we're
> >>>>>>>>>>> making it do) also does that IIRC.
> >>>>>>>>>>>
> >>>>>>>>>>> I really dislike having this placement muck spreadout like pr=
oposed.
> >>>>>>>>>>
> >>>>>>>>>> Also, I think we might be over-engineering this, we don't care=
 about
> >>>>>>>>>> accuracy at all, all we really care about is 'long-time'.
> >>>>>>>>>
> >>>>>>>>> you mean taking the patch 1/2 that you mentioned here to add a
> >>>>>>>>> migrated field:
> >>>>>>>>> https://lore.kernel.org/all/68832dfbb60fda030540b5f4e39c5801942=
689b1.1648228023.git.tim.c.chen@linux.intel.com/T/#ma5637eb8010f3f4a4abff77=
8af8db705429d003b
> >>>>>>>>>
> >>>>>>>>> And assume that the divergence between the rq_clock_task() can =
be ignored ?
> >>>>>>>>>
> >>>>>>>>> That could probably work but we need to replace the (60LL *
> >>>>>>>>> NSEC_PER_SEC) by ((1ULL << 63) / NICE_0_LOAD) because 60sec div=
ergence
> >>>>>>>>> would not be unrealistic.
> >>>>>>>>> and a comment to explain why it's acceptable
> >>>>>>>>
> >>>>>>>> Zhang,
> >>>>>>>>
> >>>>>>>> Could you try the patch below ?
> >>>>>>>> This is a rebase/merge/update of:
> >>>>>>>> -patch 1/2 above and
> >>>>>>>> -https://lore.kernel.org/lkml/20230209193107.1432770-1-rkagan@am=
azon.de/
> >>>>>>>
> >>>>>>>
> >>>>>>> I applyed and tested this patch, and it make hackbench slower.
> >>>>>>> According to my previous test results. The good result is 82.1(s)=
.
> >>>>>>> But the result of this patch is 108.725(s).
> >>>>>>
> >>>>>> By "the result of this patch is 108.725(s)",  you mean the result =
of
> >>>>>> https://lore.kernel.org/lkml/20230209193107.1432770-1-rkagan@amazo=
n.de/
> >>>>>> alone, don't you ?
> >>>>>
> >>>>> No, with your patch, the test results is 108.725(s),
> >>>>
> >>>> Ok
> >>>>
> >>>>>
> >>>>> git diff:
> >>>>>
> >>>>> diff --git a/include/linux/sched.h b/include/linux/sched.h
> >>>>> index 63d242164b1a..93a3909ae4c4 100644
> >>>>> --- a/include/linux/sched.h
> >>>>> +++ b/include/linux/sched.h
> >>>>> @@ -550,6 +550,7 @@ struct sched_entity {
> >>>>>         struct rb_node                  run_node;
> >>>>>         struct list_head                group_node;
> >>>>>         unsigned int                    on_rq;
> >>>>> +       unsigned int                    migrated;
> >>>>>
> >>>>>         u64                             exec_start;
> >>>>>         u64                             sum_exec_runtime;
> >>>>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> >>>>> index ff4dbbae3b10..e60defc39f6e 100644
> >>>>> --- a/kernel/sched/fair.c
> >>>>> +++ b/kernel/sched/fair.c
> >>>>> @@ -1057,6 +1057,7 @@ update_stats_curr_start(struct cfs_rq *cfs_rq=
, struct sched_entity *se)
> >>>>>         /*
> >>>>>          * We are starting a new run period:
> >>>>>          */
> >>>>> +       se->migrated =3D 0;
> >>>>>         se->exec_start =3D rq_clock_task(rq_of(cfs_rq));
> >>>>>  }
> >>>>>
> >>>>> @@ -4690,9 +4691,9 @@ place_entity(struct cfs_rq *cfs_rq, struct sc=
hed_entity *se, int initial)
> >>>>>          * inversed due to s64 overflow.
> >>>>>          */
> >>>>>         sleep_time =3D rq_clock_task(rq_of(cfs_rq)) - se->exec_star=
t;
> >>>>> -       if ((s64)sleep_time > 60LL * NSEC_PER_SEC)
> >>>>> +       if ((s64)sleep_time > (1ULL << 63) / scale_load_down(NICE_0=
_LOAD) / 2) {
> >>>>>                 se->vruntime =3D vruntime;
> >>>>> -       else
> >>>>> +       } else
> >>>>>                 se->vruntime =3D max_vruntime(se->vruntime, vruntim=
e);
> >>>>>  }
> >>>>>
> >>>>> @@ -7658,8 +7659,7 @@ static void migrate_task_rq_fair(struct task_=
struct *p, int new_cpu)
> >>>>>         se->avg.last_update_time =3D 0;
> >>>>>
> >>>>>         /* We have migrated, no longer consider this task hot */
> >>>>> -       se->exec_start =3D 0;
> >>>>> -
> >>>>> +       se->migrated =3D 1;
> >>>>>         update_scan_period(p, new_cpu);
> >>>>>  }
> >>>>>
> >>>>> @@ -8343,6 +8343,8 @@ static int task_hot(struct task_struct *p, st=
ruct lb_env *env)
> >>>>>
> >>>>>         if (sysctl_sched_migration_cost =3D=3D 0)
> >>>>>                 return 0;
> >>>>> +       if (p->se.migrated)
> >>>>> +               return 0;
> >>>>>
> >>>>>         delta =3D rq_clock_task(env->src_rq) - p->se.exec_start;
> >>>>>
> >>>>>
> >>>>>
> >>>>>>
> >>>>>>>
> >>>>>>>
> >>>>>>>> version1: v6.2
> >>>>>>>> version2: v6.2 + commit 829c1651e9c4
> >>>>>>>> version3: v6.2 + commit 829c1651e9c4 + this patch
> >>>>>>>>
> >>>>>>>> -------------------------------------------------
> >>>>>>>>       version1        version2        version3
> >>>>>>>> test1 81.0            118.1           82.1
> >>>>>>>> test2 82.1            116.9           80.3
> >>>>>>>> test3 83.2            103.9           83.3
> >>>>>>>> avg(s)        82.1            113.0           81.9
> >>>>>>
> >>>>>> Ok, it looks like we are back to normal figures
> >>>>
> >>>> What do those results refer to then ?
> >>>
> >>> Quote from this email (https://lore.kernel.org/lkml/1cd19d3f-18c4-92f=
9-257a-378cc18cfbc7@huawei.com/).
> >>
> >> ok.
> >>
> >> Then, there is something wrong in my patch. Let me look at it more dee=
ply
> >
> > Coudl you try the patc below. It fixes the problem on my system
> >
>
> Yes, it fixes the problem.
>
> ------
>
>  Performance counter stats for 'hackbench -g 44 -f 20 --process --pipe -l=
 60000 -s 100' (10 runs):
>
>              79.53 +- 1.21 seconds time elapsed  ( +-  1.52% )

Thanks for testing

>
>
>
> > ---
> >  kernel/sched/fair.c | 84 +++++++++++++++++++++++++++++++--------------
> >  1 file changed, 59 insertions(+), 25 deletions(-)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 0f499e9a74b5..f8722e47bb0b 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -4648,23 +4648,36 @@ static void check_spread(struct cfs_rq *cfs_rq,=
 struct sched_entity *se)
> >  #endif
> >  }
> >
> > +static inline bool entity_is_long_sleeper(struct sched_entity *se)
> > +{
> > +       struct cfs_rq *cfs_rq;
> > +       u64 sleep_time;
> > +
> > +       if (se->exec_start =3D=3D 0)
> > +               return false;
> > +
> > +       cfs_rq =3D cfs_rq_of(se);
> > +
> > +       sleep_time =3D rq_clock_task(rq_of(cfs_rq));
> > +
> > +       /* Happen while migrating because of clock task divergence */
> > +       if (sleep_time <=3D se->exec_start)
> > +            return false;
> > +
> > +       sleep_time -=3D se->exec_start;
> > +       if (sleep_time > ((1ULL << 63) / scale_load_down(NICE_0_LOAD)))
> > +               return true;
> > +
> > +       return false;
> > +}
> > +
> >  static void
> > -place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int initi=
al)
> > +place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags=
)
> >  {
> >       u64 vruntime =3D cfs_rq->min_vruntime;
> > -     u64 sleep_time;
> > -
> > -     /*
> > -      * The 'current' period is already promised to the current tasks,
> > -      * however the extra weight of the new task will slow them down a
> > -      * little, place the new task so that it fits in the slot that
> > -      * stays open at the end.
> > -      */
> > -     if (initial && sched_feat(START_DEBIT))
> > -             vruntime +=3D sched_vslice(cfs_rq, se);
> >
> >       /* sleeps up to a single latency don't count. */
> > -     if (!initial) {
> > +     if (flags & ENQUEUE_WAKEUP) {
> >               unsigned long thresh;
> >
> >               if (se_is_idle(se))
> > @@ -4680,20 +4693,43 @@ place_entity(struct cfs_rq *cfs_rq, struct sche=
d_entity *se, int initial)
> >                       thresh >>=3D 1;
> >
> >               vruntime -=3D thresh;
> > +     } else if sched_feat(START_DEBIT) {
>
> There's a parenthesis missing here.

+1

>
>
> > +             /*
> > +              * The 'current' period is already promised to the curren=
t tasks,
> > +              * however the extra weight of the new task will slow the=
m down a
> > +              * little, place the new task so that it fits in the slot=
 that
> > +              * stays open at the end.
> > +              */
> > +             vruntime +=3D sched_vslice(cfs_rq, se);
> >       }
> >
> >       /*
> >        * Pull vruntime of the entity being placed to the base level of
> > -      * cfs_rq, to prevent boosting it if placed backwards.  If the en=
tity
> > -      * slept for a long time, don't even try to compare its vruntime =
with
> > -      * the base as it may be too far off and the comparison may get
> > -      * inversed due to s64 overflow.
> > -      */
> > -     sleep_time =3D rq_clock_task(rq_of(cfs_rq)) - se->exec_start;
> > -     if ((s64)sleep_time > 60LL * NSEC_PER_SEC)
> > +      * cfs_rq, to prevent boosting it if placed backwards.
> > +      * However, min_vruntime can advance much faster than real time, =
with
> > +      * the exterme being when an entity with the minimal weight alway=
s runs
> > +      * on the cfs_rq. If the new entity slept for long, its vruntime
> > +      * difference from min_vruntime may overflow s64 and their compar=
ison
> > +      * may get inversed, so ignore the entity's original vruntime in =
that
> > +      * case.
> > +      * The maximal vruntime speedup is given by the ratio of normal t=
o
> > +      * minimal weight: scale_load_down(NICE_0_LOAD) / MIN_SHARES.
> > +      * When placing a migrated waking entity, its exec_start has been=
 set
> > +      * from a different rq. In order to take into account a possible
> > +      * divergence between new and prev rq's clocks task because of ir=
q and
> > +      * stolen time, we take an additional margin.
> > +      * So, cutting off on the sleep time of
> > +      *     2^63 / scale_load_down(NICE_0_LOAD) ~ 104 days
> > +      * should be safe.
> > +
> > +      */
> > +     if (entity_is_long_sleeper(se))
> >               se->vruntime =3D vruntime;
> >       else
> >               se->vruntime =3D max_vruntime(se->vruntime, vruntime);
> > +
> > +     if (flags & ENQUEUE_MIGRATED)
> > +             se->exec_start =3D 0;
> >  }
> >
> >  static void check_enqueue_throttle(struct cfs_rq *cfs_rq);
> > @@ -4769,7 +4805,7 @@ enqueue_entity(struct cfs_rq *cfs_rq, struct sche=
d_entity *se, int flags)
> >       account_entity_enqueue(cfs_rq, se);
> >
> >       if (flags & ENQUEUE_WAKEUP)
> > -             place_entity(cfs_rq, se, 0);
> > +             place_entity(cfs_rq, se, flags);
> >
> >       check_schedstat_required();
> >       update_stats_enqueue_fair(cfs_rq, se, flags);
> > @@ -7665,9 +7701,6 @@ static void migrate_task_rq_fair(struct task_stru=
ct *p, int new_cpu)
> >       /* Tell new CPU we are migrated */
> >       se->avg.last_update_time =3D 0;
> >
> > -     /* We have migrated, no longer consider this task hot */
> > -     se->exec_start =3D 0;
> > -
> >       update_scan_period(p, new_cpu);
> >  }
> >
> > @@ -11993,7 +12026,7 @@ static void task_fork_fair(struct task_struct *=
p)
> >               update_curr(cfs_rq);
> >               se->vruntime =3D curr->vruntime;
> >       }
> > -     place_entity(cfs_rq, se, 1);
> > +     place_entity(cfs_rq, se, 0);
> >
> >       if (sysctl_sched_child_runs_first && curr && entity_before(curr, =
se)) {
> >               /*
> > @@ -12137,8 +12170,9 @@ static void detach_task_cfs_rq(struct task_stru=
ct *p)
> >               /*
> >                * Fix up our vruntime so that the current sleep doesn't
> >                * cause 'unlimited' sleep bonus.
> > +              * This is the same as placing a waking task.
> >                */
> > -             place_entity(cfs_rq, se, 0);
> > +             place_entity(cfs_rq, se, ENQUEUE_WAKEUP);
> >               se->vruntime -=3D cfs_rq->min_vruntime;
> >       }
> >
> > --
> > 2.34.1
> >
> >
> >>
> >>>
> >>>>
> > .
> >
