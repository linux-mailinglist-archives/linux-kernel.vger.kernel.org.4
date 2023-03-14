Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79A026B9694
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 14:43:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231854AbjCNNnJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 09:43:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232106AbjCNNmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 09:42:37 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1914E2FCF7
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 06:40:02 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id k2so8745262pll.8
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 06:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678801201;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sdVIPgO3mRRP4ck0Lj7HgDNy3YYMkZwVZjeL3OBLV1M=;
        b=RrNJWuKRQW+SX/mTZr4zEf/wuLFRFoWToaiY2Q9y4ZPCcDD6+24o9IuKbpqq0jPy1J
         O1ze5GzCjQ0BYtKePecBrNZdC3rCIDOgI5+GPqFDyPTLa/mWwrWUADp4RXhZ75imW8Kl
         UdIpYmaAjzQVdXPmT3QU+rSw0XsMwtyToywxeq9EGcutCVWsV8jlJE3/aGN5Y/83JbS7
         9aGMENMgnrKoqb+OTVlwbdPONdR1h7xyAaWOjSim4m7bbdVhaPIkKH5YXD/GQCu27Itq
         LVbYpE+rAng2m5/ZlB9K6hJWUGi7+MwPk87N9PFdrPDhtVP9RI384u526G0GidlFTW0c
         Jncw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678801201;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sdVIPgO3mRRP4ck0Lj7HgDNy3YYMkZwVZjeL3OBLV1M=;
        b=xqWGv8Wf0u1jaUNb/viefXaFqR6RdU+0lsMZ5z9wgrA9Zd2Vs6zUBSXbBKZksOUUKe
         E3IrltBLjc+ofImesxjmzMSHURJMpi9KtFgHmQvS4aaqNmOZidac6rD9LwBIf0/3Y7Hm
         6UpEX2ztgBLTE09Xhr0OwHKUbKD+sKaM/psCXrR6R04QhQdhxRAHtBsocm22r1dqbLKJ
         d66fV6gAbIhBXrJuWJzBZj4DpCXhCXvxVioedGzAzhHdlhK+GUoySqQkiMElKa6Jd/KB
         X5MyylTx8D/sQ6VBfQN2d7O1yd53I9nN1KRvqekBQcXNDeU9clQjmcT9NEsvLPt45yE2
         yhlw==
X-Gm-Message-State: AO0yUKU+/dnjsKIhevS3dkoyrafBFbLnDvmpG25MKrOD2RxbcWPaoEa4
        limiSm6X6acOgMO1NcU1sUe32k86rRkOWAT6kdq75Q==
X-Google-Smtp-Source: AK7set+vymFgiBlw3MN0ZVgBU5mtOuZTElj+WTkGkYH7QUUsPEW0VhKPAODMHWh+VBUiyWvtAJrumW2weWfc4WfIFZY=
X-Received: by 2002:a17:90a:4a15:b0:23c:fea4:770c with SMTP id
 e21-20020a17090a4a1500b0023cfea4770cmr2631668pjh.3.1678801201394; Tue, 14 Mar
 2023 06:40:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230306132418.50389-1-zhangqiao22@huawei.com>
 <20230309130524.GA273121@hirez.programming.kicks-ass.net> <CAKfTPtAf5RrzZRSHtfK+r3QvnFQ-oM3+rJ-z5SB8T4+nUv1aQw@mail.gmail.com>
 <20230309142825.GB273121@hirez.programming.kicks-ass.net> <ZAnvCGdlOrWbIC/o@hirez.programming.kicks-ass.net>
 <CAKfTPtADUas2QHZCQyu0ad-JTKRQ=PcsB=o7+PuJNVxHwAzkCQ@mail.gmail.com>
 <ZAs+zV0o9ShO7nLT@vingu-book> <ef2f07f1-fe3a-624f-52e7-1089138dc137@huawei.com>
 <CAKfTPtBaBdxfc9uoViNT8gsWU-GdgnHrDdWPpAduadTFmu1ZGg@mail.gmail.com>
 <55754a59-a01f-206a-43f6-d07ea37300dd@huawei.com> <CAKfTPtCCQ0__kz8UfaSm7qrpOQc47rPheD+KLoyBAbmp_tLP0w@mail.gmail.com>
 <3f43273a-5b73-0a44-a452-8a8427bb9ff2@huawei.com>
In-Reply-To: <3f43273a-5b73-0a44-a452-8a8427bb9ff2@huawei.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 14 Mar 2023 14:39:49 +0100
Message-ID: <CAKfTPtD7g5JKDAbob0pPS8EPsHGZhjrE+JEuiEmj19moFbY1HQ@mail.gmail.com>
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
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Mar 2023 at 14:38, Zhang Qiao <zhangqiao22@huawei.com> wrote:
>
>
>
> =E5=9C=A8 2023/3/14 21:26, Vincent Guittot =E5=86=99=E9=81=93:
> > On Tue, 14 Mar 2023 at 12:03, Zhang Qiao <zhangqiao22@huawei.com> wrote=
:
> >>
> >>
> >>
> >> =E5=9C=A8 2023/3/13 22:23, Vincent Guittot =E5=86=99=E9=81=93:
> >>> On Sat, 11 Mar 2023 at 10:57, Zhang Qiao <zhangqiao22@huawei.com> wro=
te:
> >>>>
> >>>>
> >>>>
> >>>> =E5=9C=A8 2023/3/10 22:29, Vincent Guittot =E5=86=99=E9=81=93:
> >>>>> Le jeudi 09 mars 2023 =C3=A0 16:14:38 (+0100), Vincent Guittot a =
=C3=A9crit :
> >>>>>> On Thu, 9 Mar 2023 at 15:37, Peter Zijlstra <peterz@infradead.org>=
 wrote:
> >>>>>>>
> >>>>>>> On Thu, Mar 09, 2023 at 03:28:25PM +0100, Peter Zijlstra wrote:
> >>>>>>>> On Thu, Mar 09, 2023 at 02:34:05PM +0100, Vincent Guittot wrote:
> >>>>>>>>
> >>>>>>>>> Then, even if we don't clear exec_start before migrating and ke=
ep
> >>>>>>>>> current value to be used in place_entity on the new cpu, we can=
't
> >>>>>>>>> compare the rq_clock_task(rq_of(cfs_rq)) of 2 different rqs AFA=
ICT
> >>>>>>>>
> >>>>>>>> Blergh -- indeed, irq and steal time can skew them between CPUs =
:/
> >>>>>>>> I suppose we can fudge that... wait_start (which is basically wh=
at we're
> >>>>>>>> making it do) also does that IIRC.
> >>>>>>>>
> >>>>>>>> I really dislike having this placement muck spreadout like propo=
sed.
> >>>>>>>
> >>>>>>> Also, I think we might be over-engineering this, we don't care ab=
out
> >>>>>>> accuracy at all, all we really care about is 'long-time'.
> >>>>>>
> >>>>>> you mean taking the patch 1/2 that you mentioned here to add a
> >>>>>> migrated field:
> >>>>>> https://lore.kernel.org/all/68832dfbb60fda030540b5f4e39c5801942689=
b1.1648228023.git.tim.c.chen@linux.intel.com/T/#ma5637eb8010f3f4a4abff778af=
8db705429d003b
> >>>>>>
> >>>>>> And assume that the divergence between the rq_clock_task() can be =
ignored ?
> >>>>>>
> >>>>>> That could probably work but we need to replace the (60LL *
> >>>>>> NSEC_PER_SEC) by ((1ULL << 63) / NICE_0_LOAD) because 60sec diverg=
ence
> >>>>>> would not be unrealistic.
> >>>>>> and a comment to explain why it's acceptable
> >>>>>
> >>>>> Zhang,
> >>>>>
> >>>>> Could you try the patch below ?
> >>>>> This is a rebase/merge/update of:
> >>>>> -patch 1/2 above and
> >>>>> -https://lore.kernel.org/lkml/20230209193107.1432770-1-rkagan@amazo=
n.de/
> >>>>
> >>>>
> >>>> I applyed and tested this patch, and it make hackbench slower.
> >>>> According to my previous test results. The good result is 82.1(s).
> >>>> But the result of this patch is 108.725(s).
> >>>
> >>> By "the result of this patch is 108.725(s)",  you mean the result of
> >>> https://lore.kernel.org/lkml/20230209193107.1432770-1-rkagan@amazon.d=
e/
> >>> alone, don't you ?
> >>
> >> No, with your patch, the test results is 108.725(s),
> >
> > Ok
> >
> >>
> >> git diff:
> >>
> >> diff --git a/include/linux/sched.h b/include/linux/sched.h
> >> index 63d242164b1a..93a3909ae4c4 100644
> >> --- a/include/linux/sched.h
> >> +++ b/include/linux/sched.h
> >> @@ -550,6 +550,7 @@ struct sched_entity {
> >>         struct rb_node                  run_node;
> >>         struct list_head                group_node;
> >>         unsigned int                    on_rq;
> >> +       unsigned int                    migrated;
> >>
> >>         u64                             exec_start;
> >>         u64                             sum_exec_runtime;
> >> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> >> index ff4dbbae3b10..e60defc39f6e 100644
> >> --- a/kernel/sched/fair.c
> >> +++ b/kernel/sched/fair.c
> >> @@ -1057,6 +1057,7 @@ update_stats_curr_start(struct cfs_rq *cfs_rq, s=
truct sched_entity *se)
> >>         /*
> >>          * We are starting a new run period:
> >>          */
> >> +       se->migrated =3D 0;
> >>         se->exec_start =3D rq_clock_task(rq_of(cfs_rq));
> >>  }
> >>
> >> @@ -4690,9 +4691,9 @@ place_entity(struct cfs_rq *cfs_rq, struct sched=
_entity *se, int initial)
> >>          * inversed due to s64 overflow.
> >>          */
> >>         sleep_time =3D rq_clock_task(rq_of(cfs_rq)) - se->exec_start;
> >> -       if ((s64)sleep_time > 60LL * NSEC_PER_SEC)
> >> +       if ((s64)sleep_time > (1ULL << 63) / scale_load_down(NICE_0_LO=
AD) / 2) {
> >>                 se->vruntime =3D vruntime;
> >> -       else
> >> +       } else
> >>                 se->vruntime =3D max_vruntime(se->vruntime, vruntime);
> >>  }
> >>
> >> @@ -7658,8 +7659,7 @@ static void migrate_task_rq_fair(struct task_str=
uct *p, int new_cpu)
> >>         se->avg.last_update_time =3D 0;
> >>
> >>         /* We have migrated, no longer consider this task hot */
> >> -       se->exec_start =3D 0;
> >> -
> >> +       se->migrated =3D 1;
> >>         update_scan_period(p, new_cpu);
> >>  }
> >>
> >> @@ -8343,6 +8343,8 @@ static int task_hot(struct task_struct *p, struc=
t lb_env *env)
> >>
> >>         if (sysctl_sched_migration_cost =3D=3D 0)
> >>                 return 0;
> >> +       if (p->se.migrated)
> >> +               return 0;
> >>
> >>         delta =3D rq_clock_task(env->src_rq) - p->se.exec_start;
> >>
> >>
> >>
> >>>
> >>>>
> >>>>
> >>>>> version1: v6.2
> >>>>> version2: v6.2 + commit 829c1651e9c4
> >>>>> version3: v6.2 + commit 829c1651e9c4 + this patch
> >>>>>
> >>>>> -------------------------------------------------
> >>>>>       version1        version2        version3
> >>>>> test1 81.0            118.1           82.1
> >>>>> test2 82.1            116.9           80.3
> >>>>> test3 83.2            103.9           83.3
> >>>>> avg(s)        82.1            113.0           81.9
> >>>
> >>> Ok, it looks like we are back to normal figures
> >
> > What do those results refer to then ?
>
> Quote from this email (https://lore.kernel.org/lkml/1cd19d3f-18c4-92f9-25=
7a-378cc18cfbc7@huawei.com/).

ok.

Then, there is something wrong in my patch. Let me look at it more deeply

>
> >
> >
> >>>
> >>>>>
> >>>>> -------------------------------------------------
> >>>>>
> >>>>> The proposal accepts a divergence of up to 52 days between the 2 rq=
s.
> >>>>>
> >>>>> If this work, we will prepare a proper patch
> >>>>>
> >>>>> diff --git a/include/linux/sched.h b/include/linux/sched.h
> >>>>> index 63d242164b1a..cb8af0a137f7 100644
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
> >>>>> index 7a1b1f855b96..36acd9598b40 100644
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
> >>>>> @@ -4684,13 +4685,23 @@ place_entity(struct cfs_rq *cfs_rq, struct =
sched_entity *se, int initial)
> >>>>>
> >>>>>         /*
> >>>>>          * Pull vruntime of the entity being placed to the base lev=
el of
> >>>>> -        * cfs_rq, to prevent boosting it if placed backwards.  If =
the entity
> >>>>> -        * slept for a long time, don't even try to compare its vru=
ntime with
> >>>>> -        * the base as it may be too far off and the comparison may=
 get
> >>>>> -        * inversed due to s64 overflow.
> >>>>> +        * cfs_rq, to prevent boosting it if placed backwards.
> >>>>> +        * However, min_vruntime can advance much faster than real =
time, with
> >>>>> +        * the exterme being when an entity with the minimal weight=
 always runs
> >>>>> +        * on the cfs_rq. If the new entity slept for long, its vru=
ntime
> >>>>> +        * difference from min_vruntime may overflow s64 and their =
comparison
> >>>>> +        * may get inversed, so ignore the entity's original vrunti=
me in that
> >>>>> +        * case.
> >>>>> +        * The maximal vruntime speedup is given by the ratio of no=
rmal to
> >>>>> +        * minimal weight: NICE_0_LOAD / MIN_SHARES, so cutting off=
 on the
> >>>>
> >>>> why not is `scale_load_down(NICE_0_LOAD) / MIN_SHARES` here ?
> >>>
> >>> yes, you are right.
> >>>
> >>>>
> >>>>
> >>>>> +        * sleep time of 2^63 / NICE_0_LOAD should be safe.
> >>>>> +        * When placing a migrated waking entity, its exec_start ha=
s been set
> >>>>> +        * from a different rq. In order to take into account a pos=
sible
> >>>>> +        * divergence between new and prev rq's clocks task because=
 of irq and
> >>>>
> >>>> This divergence might be larger, it cause `sleep_time` maybe negativ=
e.
> >>>
> >>> AFAICT, we are safe with ((1ULL << 63) / scale_load_down(NICE_0_LOAD)
> >>> / 2) as long as the divergence between the 2 rqs clocks task is lower
> >>> than 2^52nsec. Do you expect a divergence higher than 2^52 nsec
> >>> (around 52 days)?
> >>>
> >>> We can probably keep using (1ULL << 63) / scale_load_down(NICE_0_LOAD=
)
> >>> which is already half the max value if needed.
> >>>
> >>> the fact that sleep_time can be negative is not a problem as
> >>> s64)sleep_time > will take care of this.
> >>
> >> In my opinion, when comparing signed with unsigned, the compiler conve=
rts the signed value to unsigned.
> >> So, if sleep_time < 0, "(s64)sleep_time > (1ULL << 63) / NICE_0_LOAD /=
 2" will be true.
> >>
> >>>
> >>>>
> >>>>> +        * stolen time, we take an additional margin.
> >>>>>          */
> >>>>>         sleep_time =3D rq_clock_task(rq_of(cfs_rq)) - se->exec_star=
t;
> >>>>> -       if ((s64)sleep_time > 60LL * NSEC_PER_SEC)
> >>>>> +       if ((s64)sleep_time > (1ULL << 63) / NICE_0_LOAD / 2)>     =
            se->vruntime =3D vruntime;
> >>>>>         else
> >>>>>                 se->vruntime =3D max_vruntime(se->vruntime, vruntim=
e);
> >>>>> @@ -7658,7 +7669,7 @@ static void migrate_task_rq_fair(struct task_=
struct *p, int new_cpu)
> >>>>>         se->avg.last_update_time =3D 0;
> >>>>>
> >>>>>         /* We have migrated, no longer consider this task hot */
> >>>>> -       se->exec_start =3D 0;
> >>>>> +       se->migrated =3D 1;
> >>>>>
> >>>>>         update_scan_period(p, new_cpu);
> >>>>>  }
> >>>>> @@ -8344,6 +8355,9 @@ static int task_hot(struct task_struct *p, st=
ruct lb_env *env)
> >>>>>         if (sysctl_sched_migration_cost =3D=3D 0)
> >>>>>                 return 0;
> >>>>>
> >>>>> +       if (p->se.migrated)
> >>>>> +               return 0;
> >>>>> +
> >>>>>         delta =3D rq_clock_task(env->src_rq) - p->se.exec_start;
> >>>>>
> >>>>>         return delta < (s64)sysctl_sched_migration_cost;
> >>>>>
> >>>>>
> >>>>>
> >>>>>>
> >>>>>>
> >>>>>>>
> >>>>>>>
> >>>>> .
> >>>>>
> >>> .
> >>>
> > .
> >
