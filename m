Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D18264DFD5
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 18:39:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbiLORj3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 12:39:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbiLORj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 12:39:26 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3BFC2B243
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 09:39:24 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id a16so91886qtw.10
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 09:39:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4/Pg3x44pgLS1fChNz1PezM6SL4WV88ZkurR47u/O58=;
        b=pKE0r5/A3TNLjK6XNHV/8ppp6Cu4VmmbKZAuN2XI7ydnXDL5BS1b4FQk2nOpTXmWdm
         6o8YX+KIHF39MvprBkFDGt+htNK7dpGfHdw1l2CPFKOj+cnFp7Z0SHkFtqYgqTalgghH
         e/Z2GOOZXG36DXR77D5tSNILc1tz4UZAVpTZYCT/yhAlGYIeuGo6qonn5oShOdZwp9lv
         PzLXX4DbKOp6A2dn829d09gwjUU6yMkpbCASoKoqO5zUfToelg6+uvtkKUGKEqKX4Zxj
         pIvpog996qMkChU4wzcLJdIYm5NmQLaBYArocq2+hjPxlHKyl27hLukYFBfXeiQKY8n1
         tQ+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4/Pg3x44pgLS1fChNz1PezM6SL4WV88ZkurR47u/O58=;
        b=yqjjjjMZOZeOJ+G6Ieu14nMjhyR6uM1D+gQouZ3fqfYw/an9ewQmRMOBCVoHSwe3ei
         yzpbHOr5HLZFj6Mp1UWbLLE6CH+JiFIjoYFMVjINa/teDUL6fN3tqb2RE8ZbH7MjHnaM
         2Aw21j7LfddZgT/+4qGfNj93KvXSqajO9Dula0NEi04WJqGj8V6JVZrKpGJjyrkqIvU5
         CkEL/m0PuO7g2/lSjzI0oC74j+KCp7j9ZkxDadJ3wBH55p9leobGwrEcowkjiCOyh0uh
         EPRxnRX4wIvO/oXuubd1qtKFprSx+kIiFv+F+VAu0PNRrgvobJkrhSXhpA3wWCeewTYd
         nUew==
X-Gm-Message-State: ANoB5pnLGRXIFy2AFO/GvlwPjKtjOWyEilzy4F2rpxPWkYTDXc2/UK6d
        N6ZsSxGAFsjxS8PD9OiuanoYgDQthv8DMGBrxstqiFEFl5iSqw==
X-Google-Smtp-Source: AA0mqf7hQfWE+QKn6g/V4VSX5u6W9Q7x3XVw1wv7F/dMwigwg25K3yzgsUF2T5amEGLCc8dIcbmRkR2i3eKwEUZ4NfE=
X-Received: by 2002:ac8:6981:0:b0:3a7:ead5:8760 with SMTP id
 o1-20020ac86981000000b003a7ead58760mr10682129qtq.418.1671125963364; Thu, 15
 Dec 2022 09:39:23 -0800 (PST)
MIME-Version: 1.0
References: <20221127141742.1644023-1-qyousef@layalina.io> <20221127141742.1644023-4-qyousef@layalina.io>
 <CAKfTPtCawKvhMwJYVUskYcX7eR2K7SziWVzvjGh6JCVB+WT5tQ@mail.gmail.com>
 <20221203143323.w32boxa6asqvvdnp@airbuntu> <CAKfTPtCZYGEvDBe5X1v7TiNZag0atUozGKip6EAgvZDWyo8e-g@mail.gmail.com>
 <20221205110159.nd5igwvsaj55jar7@airbuntu> <CAKfTPtAOhQyfyH_qRArC2SZ1sQOBnRZ4CXARiWu2fvb+KPGsXw@mail.gmail.com>
 <20221208140526.vvmjxlz6akgqyoma@airbuntu> <20221209164739.GA24368@vingu-book>
 <20221212184317.sntxy3h6k44oz4mo@airbuntu>
In-Reply-To: <20221212184317.sntxy3h6k44oz4mo@airbuntu>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 15 Dec 2022 18:39:12 +0100
Message-ID: <CAKfTPtBX0ugM87CEjAXUbVhnTZTwAAnjXu2fRfc6ezHE8=aC6w@mail.gmail.com>
Subject: Re: [RFC PATCH 3/3] sched/fair: Traverse cpufreq policies to detect
 capacity inversion
To:     Qais Yousef <qyousef@layalina.io>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukasz Luba <lukasz.luba@arm.com>, Wei Wang <wvw@google.com>,
        Xuewen Yan <xuewen.yan94@gmail.com>,
        Hank <han.lin@mediatek.com>,
        Jonathan JMChen <Jonathan.JMChen@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Dec 2022 at 19:43, Qais Yousef <qyousef@layalina.io> wrote:
>
> On 12/09/22 17:47, Vincent Guittot wrote:
>
> [...]
>
> > > > > > This patch loops on all cpufreq policy in sched softirq, how can this
> > > > > > be sane ? and not only in eas mode but also in the default asymmetric
> > > > >
> > > > > Hmm I'm still puzzled. Why it's not sane to do it here but it's okay to do it
> > > > > in the wake up path in feec()?
> > > >
> > > > feec() should be considered as an exception not as the default rule.
> > > > Thing like above which loops for_each on external subsystem should be
> > > > prevented and the fact that feec loops all PDs doesn't means that we
> > > > can put that everywhere else
> > >
> > > Fair enough. But really understanding the root cause behind this limitation
> > > will be very helpful. I don't have the same appreciation of why this is
> > > a problem, and shedding more light will help me to think more about it in the
> > > future.
> > >
> >
> > Take the example of 1k cores with per cpu policy. Do you really think a
> > for_each_cpufreq_policy would be reasonable ?
>
> Hmm I don't think such an HMP system makes sense to ever exist.
>
> That system has to be a multi-socket system and I doubt inversion detection is
> something of value.
>
> Point taken anyway. Let's find another way to do this.
>
> [...]
>
> > > This only makes sense to me if you refer to death by thousand cuts kind of
> > > problem. I can't see how this on its own being a problem.. I'll run some tests
> > > to convince myself.
> >
> > That's exactly the point, the scheduler tries hard to not add any system size
> > related limitation like: it's fine because it's only for 8 cores system.
> > I don't want to lock up the uclamp/util_fits_cpu in such limitations so you
> > can't use for_each_cpufreq or anything similar at runtime in sched softirq
>
> I'm happy to make things more generic so more users can benefit :-)
>
> >
> > >
> > > >
> > > > uclamp_min should not be used to set an over utilized cpu  because it
> > >
> > > uclamp_min must set overutilized. If a long running task has its uclamp_min
> > > changed, we want to upmigrate it if that's necessary to meet the new demand.
> >
> > I think that you are too much focused on your 8 cores android system.
>
> I am not; you're making an assumption here :-)
>
> HMP systems for 1k servers just don't make any sense. A desktop with 128 or
> even 256 HMP cores is a big stretch; and if that exist I don't think there's an
> overhead to worry about here; and I *did* consider this. I measured the impact
> if we have 128 and it was mere 1 or 2 us extra.  And that's on under powered
> pine book pro. If such a system exist it'd probably be more performant.
>
> > uclamp_min must not set a CPU overutilized because the CPU is not overutilized
> > in this case. It's only the task that is misfit. You mostly try to bias some
> > behavior to fit your use case.
>
> Maybe we are talking about different things over here. As long as we agree it's
> a misfit task then we are aligned.
>
> As far as I know misfit required overutilized to re-enable load balance. But
> maybe there's a detail that's creating this confusion.

The current implementation uses overutilized to fix misfit task
placement because it was assumed that misfit task also means that the
cpu is overutilized as only the utilization was used but It's not
mandatory as proposed below and there is no direct relation anymore
with uclamp_min

>
> >
> > >
> > > Keep in mind in android tasks could move between top-app, foreground and
> > > background groups.
> > >
> > > And keep in mind Android now implement a framework to dynamically change
> > > uclamp. It's available from Android 12 as part of Android Dynamic Performance
> > > Framework (ADPF). It's under CPU Hints.
> > >
> > >     https://developer.android.com/games/optimize/adpf
> > >
> >
> > I have never put any kind of limitation of the task or system behavior
>
> Nope you didn't. I was just trying to highlight some additional problems we're
> seeing that we'd need to consider :-)

I don't see any additional problem TBH.

>
> >
> > > > doesn means that the cpu is overutilized and uclamp_max should be used
> > >
> > > It is a misfit task; which requires overutilized to be set to re-enable load
> > > balance for uclamp_min to upgrate it. For uclamp max we should not set
> > > overutilized, agreed and that's what we should be doing.
> >
> > That's probably the root of your problem here. The load balance is still
> > periodically called even when EAS is enabled but the latter prevents task
> > migration unless overutilized in order to not break the energy aware task
>
> Okay. For me this means load_balance is disabled since it's effectively doing
> nothing. So maybe it's a terminology problem of what I meant with load balance
> is disabled.

This is not doing nothing and your patch is using load_balance to
detect inversion as an example

>
> > placement. But if a task is misplaced and a cpu finds it can help,
> > we should let it pull the task without disabling EAS. This will not enable the
> > performance spread behavior and we can expect the other small tasks to be
> > packed by EAS on the best cpu at next wakeup.
> >
> > So intead of trying to detect a very specific capacity inversion use case
> > during this periodic this load balance, it's better to let a CPU that can
> > fix the misfit situation to pull the task.
>
> I can't see the relation here.
>
> Capacity inversion is required NOT in load balance. In every place will look

You are using periodic load_balance to detect capacity inversion:
update_cpu_capacity() is called during periodic load_balance. Instead
of detecting capacity inversion, use load_balance to pull a misfit
task.
Either there is a cpu on which the task can fit better and it will
pull it or there is no better place and it will not

> for a fitting CPU; we need to ensure hints to place the task on big cpu works
> even under thermal pressure.
>
> If uclamp_min = 1024, but big core has 5% thermal pressure, it should still fit
> there. And feec() a long with all other callers should respect that too.

That's probably where I disagree, task should probably stay on this
cpu because there is no better option (ie cpu with higher compute
capacity) but the task doesn't fit on the cpu because its capacity is
below uclamp_min. You might think that I niptick there but that makes
a difference in the way to handle the situation.

>
> How better overutilized detection helps here? EAS needs to consider this as
> a candidate CPU and place it there at wake up.

If uclamp_min = 1024, but big core has 5% thermal pressure, big cpu
doesn't fit, otherwise uclamp_min is meaningless. But it can still
remain the best choice and feec should select it.

>
> >
> > See below
> >
> > >
> > > > for not setting overutilized a cpu with a clamped max value
> > > >
> > > > >
> > > > > I'm all ears if there's a simpler way to address the problem :-)
> > > >
> > > > let me try to prepare a something to show what I mean
> > >
> > > A PoC just to help me see what you mean would be great, thanks!
> > >
> >
> > I have reverted patches:
> > Revert "sched/fair: Detect capacity inversion"
> > Revert "sched/fair: Consider capacity inversion in util_fits_cpu()"
> > Revert "sched/uclamp: Make cpu_overutilized() use util_fits_cpu()"
> >
> > ---
> >  kernel/sched/fair.c | 32 +++++++++++++++++---------------
> >  1 file changed, 17 insertions(+), 15 deletions(-)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 4423681baf15..6e54afc0a6ec 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -4539,7 +4539,7 @@ static inline int util_fits_cpu(unsigned long util,
> >        * the time.
> >        */
> >       capacity_orig = capacity_orig_of(cpu);
> > -     capacity_orig_thermal = capacity_orig - arch_scale_thermal_pressure(cpu);
> > +     capacity_orig_thermal = capacity_orig - thermal_load_avg(cpu_rq(cpu));
> >
> >       /*
> >        * We want to force a task to fit a cpu as implied by uclamp_max.
> > @@ -4578,8 +4578,7 @@ static inline int util_fits_cpu(unsigned long util,
> >        *     2. The system is being saturated when we're operating near
> >        *        max capacity, it doesn't make sense to block overutilized.
> >        */
> > -     uclamp_max_fits = (capacity_orig == SCHED_CAPACITY_SCALE) && (uclamp_max == SCHED_CAPACITY_SCALE);
> > -     uclamp_max_fits = !uclamp_max_fits && (uclamp_max <= capacity_orig);
> > +     uclamp_max_fits = (uclamp_max <= capacity_orig) || (capacity_orig == SCHED_CAPACITY_SCALE);
> >       fits = fits || uclamp_max_fits;
> >
> >       /*
> > @@ -4614,7 +4613,7 @@ static inline int util_fits_cpu(unsigned long util,
> >        * handle the case uclamp_min > uclamp_max.
> >        */
> >       uclamp_min = min(uclamp_min, uclamp_max);
> > -     if (util < uclamp_min && capacity_orig != SCHED_CAPACITY_SCALE)
> > +     if (util < uclamp_min)
> >               fits = fits && (uclamp_min <= capacity_orig_thermal);
> >
> >       return fits;
> > @@ -6064,7 +6063,10 @@ static inline void hrtick_update(struct rq *rq)
> >  #ifdef CONFIG_SMP
> >  static inline bool cpu_overutilized(int cpu)
> >  {
> > -     return !fits_capacity(cpu_util_cfs(cpu), capacity_of(cpu));
> > +     unsigned long rq_util_max = uclamp_rq_get(cpu_rq(cpu), UCLAMP_MAX);
> > +
> > +     return !(fits_capacity(cpu_util_cfs(cpu), capacity_of(cpu)) ||
> > +              rq_util_max <= capacity_orig_of(cpu));
> >  }
> >
> >  static inline void update_overutilized_status(struct rq *rq)
> > @@ -10164,24 +10166,23 @@ static struct sched_group *find_busiest_group(struct lb_env *env)
> >        */
> >       update_sd_lb_stats(env, &sds);
> >
> > -     if (sched_energy_enabled()) {
> > -             struct root_domain *rd = env->dst_rq->rd;
> > -
> > -             if (rcu_dereference(rd->pd) && !READ_ONCE(rd->overutilized))
> > -                     goto out_balanced;
> > -     }
> > -
> > -     local = &sds.local_stat;
> > -     busiest = &sds.busiest_stat;
> > -
> >       /* There is no busy sibling group to pull tasks from */
> >       if (!sds.busiest)
> >               goto out_balanced;
> >
> > +     busiest = &sds.busiest_stat;
> > +
> >       /* Misfit tasks should be dealt with regardless of the avg load */
> >       if (busiest->group_type == group_misfit_task)
> >               goto force_balance;
> >
> > +     if (sched_energy_enabled()) {
> > +             struct root_domain *rd = env->dst_rq->rd;
> > +
> > +             if (rcu_dereference(rd->pd) && !READ_ONCE(rd->overutilized))
> > +                     goto out_balanced;
> > +     }
> > +
> >       /* ASYM feature bypasses nice load balance check */
> >       if (busiest->group_type == group_asym_packing)
> >               goto force_balance;
> > @@ -10194,6 +10195,7 @@ static struct sched_group *find_busiest_group(struct lb_env *env)
> >       if (busiest->group_type == group_imbalanced)
> >               goto force_balance;
> >
> > +     local = &sds.local_stat;
> >       /*
> >        * If the local group is busier than the selected busiest group
> >        * don't try and pull any tasks.
> > --
> > 2.17.1
> >
> > There are probably some other changes to do here and here like check_misfit_status
> > but this enable another cpu with more capacity to pull a misfit task without
> > disabling EAS.
>
> I need time to digest this. But so far I see this is still irrelevant as the
> problem with the definition of what *fits* a CPU and what doesn't.
>
> On a system where:
>
>         LITTLE=160, MEDIUM=480, BIG=1024
>
> A task
>
>         p->util_avg = 200
>         p->util_min = 1024
>
> Should always be placed on a big core unless the big core is capacity inverted.
> That means most importantly in feec().
>
> How does the above fix that?

Not differently than if BIG is under thermal pressure and its capacity
goes below 480. In this case, MEDIUM is the best CPU and should be
selected. Note that the task still doesn't fit on any cpu but neither
BIG nor MEDIUM are over utilized and there is no need to disable EAS
and spread the tasks everywhere. feec() and select_idle_capacity()
should take care of this case and as a result of yours. I don't see
any difference in the way both cases should be handled whereas
capacity inversion makes a difference.

>
> This decision should be taken coherently in feec(), select_idle_capacity() and
> any place that wants to check if the task fits the cpu or not.
>
> I'm not sure why you're isolating this to the overutilized. It is just one of
> the call sites that needs to check for fitness when uclamp is being used.
>
> >
> > > >
> > > > >
> > > > > The problem is that thermal pressure on big cpu is not important from
> > > > > uclamp perspective until it is in inversion state. It is quite common to have
> > > > > a system where the medium capacity is in 500 range. If the big is under thermal
> > > > > pressure that it drops to 800, then it is still a fitting CPU from uclamp
> > > > > perspective. Keep in mind uclamp_min is useful for tasks whose utilization is
> > > > > small So we need to be selective when thermal pressure is actually helping out
> > > > > or just creating unnecessary problems.
> > > >
> > > > What about medium cores ?  There are often 3 capacity levels now so
> > > > the same can happen between medium and little.
> > >
> > > We do subtract thermal pressure from capacity for the mediums and littles all
> > > the time. So that case is handled, no?
> >
> > you don't need iversion detection for medium vs little ? Why it's acceptable here
> > and not between bg vs medium
>
> Because it's the highest level. You have no option to do better. uclamp_min is
> a hint; if the util_avg is small (ie: it still fits_capacity()); best effort is
> to keep giving the task the performance it needs. While on a big core; you
> can't upmigrate to any other level; so thermal pressure on big core is
> meaningless until it is in capacity inversion.

>
> If the user asks for something and finds that their task is placed randomly
> that's not good, no?

nobody says to place the task randomly.

>
> What you say makes sense against util_avg; the rule of which is still the same
> as before.
>
> >
> > >>
> > >
> > > >
> > > > Also we have more and more thermal capping happening ahead of
> > > > overheating like the power cap interface where we want to cap some
> > > > CPUs and others even before they reach their thermal limit in order to
> > > > get more power/thermal room for others. This implies that some CPUs
> > > > could be under thermal pressure whereas others not. This implies also
> > > > that a UC with big core capacity being below little and medium cores
> > > > is not impossible or medium being under little but big staying at high
> > > > capacity.
> > >
> > > I *think* I am catering for this already. The big is special because it's the
> > > highest level, so thermal pressure; from uclamp perspective, is not meaningful
> > > as it's the best you can ever get on this system; untill it becomes capacity
> > > inverted that is.
> > >
> >
> > That's another point that concerns me, you put some special condition on big
> > cores to be able to detect an possible inversion.
> > If a task deosn't fit a cpu because of thermal pressure, it should be tagged misfit
> > and let other cpu looks if they can do better. That's doesnt mean that we
> > will find one.
>
> This breaks the usefulness of the hint. What you say means a small task that
> wants to run as fast as possible will find itself placed randomly instead

Why randomly ? feec() and others should continue to select the best
cpu even if it may not fit util_min constraint, whatever the cpu BIG,
MEDIUM or LITTLE

> whenever there's thermal pressure. And userspace should just figure this out
> on their own somehow that thermal pressure affects them and they start to find
> a way to read the thermal pressure and set the right uclamp_min value??
>
> As I tried to highlight; this will be set dynamically based on perceived
> performance. Even for a static configuration; I don't think a hint of
> uclamp_min = 1024 should fail that easily because some cores can be very big
> and always have a residual 1 or 2 % thermal pressure.
>
> [...]
>
> > >
> > > I see.
> > >
> > > Just to make sure, this is only used in LB only, right?
> >
> > Yes, although I haven't check the IPC patchset
> >
> > >
> > > I do have a problem that might make this more complicated.
> > >
> > > I'm considering if we can enable packing in load_balance by using feec().
> > > Limiting the search space to only idle CPUs causes problems. And these problems
> > > relate to both performance and power.
> > >
> > > For example, If a small task is running on a big CPU, it will prevent big-ish
> > > tasks from migrating there on load balance if the only idle cpu is a little
> > > one.
> > >
> > > And if a small task moves to a big cpu on load balance because it's the only
> > > idle one, it could take the cluster out of deep sleep while it could have
> >
> > Maybe your root problem is that the small task migrates on a big cpu only
> > because it's the only idle one and not because of utilization (uclamp_min/max
> > included)
>
> Yes I think that's the reason too and that's why I'm suggesting maybe we need
> to consider packing for systems that care about power.
>
> >
> > > easily crammed on a little core.
> > >
> > > I can't say I've debugged these problems. But we do get lots of issues related
> > > to big cpus waking up unnecessarily (it could be per-cpu tasks too); and task
> > > not migrating fast enough.
> > >
> > > I think the load balance behavior of going with idle cpus first is
> > > contributing. I hope to dig more into this problem in the near future.
> >
> > the load balance is not going with idle cpu 1st, the load balance happens on
> > all cpus but the period of busy cpus is higher to not impact much the running
> > load whereas idle cpus don't have anything else to do except lokking for work
> > to pull and saving power
>
> Okay the impact is the same. We pick idle cpus first; and
> select_idle_capacity() which is what we should go through for HMP only search
> for CPUs that are idle.
>
> >
> > >
> > > Can we consider these problems along the way too?
> > >
> > > > They both try to find the cpu with highest capacity that will fit the
> > > > task requirement
> > >
> > > find the *idl* cpu with highest capacity, right? IIUC, we try to find idle cpu
> > > then use load if all is busy? Sorry I don't have enough of the load balance
> > > code in my head yet..
> > >
> > > >
> > > > >
> > > > > To be honest, I personally think EAS can be useful on SMP systems and it would
> > > > > be nice to enable it outside of sched_asym_cpucapacity.
> > > >
> > > > or even before that task_fits_cpu should probably be useful for some smp case
> > >
> > > I think that should we doable even with the current approach if inversion
> > > detection is not actually the problem and just the way we do it.
> > >
> > > I chose the current approach because it seemed the simpler to me. I can do
> > > something in the topology code to help make the inversion detection much easier
> > > and more generic. But I'll hold on a bit in case you have a thought on another
> > > way to tackle the problem.
> > >
> > > We do have actually a similar problem for RT that I need to tackle too. So
> > > maybe moving it to topology will help both CFS and RT.
> > >
> > > >
> > > > >
> > > > > I'm interested to hear more about this unification idea actually. If you feel
> > > > > a bit chatty to describe in more detail how do you see this being unified, that
> > > > > could be enlightening for some of us who work in this area :-)
> > > >
> > > > First, keep everything scalable and don't loop on all cpufreq policy
> > > > or anything else that can't scale so we don't have to take care of the
> > > > number of cpu of cpufreq policy in the system
> > > > Then, I think that a good starting point would be to merge the
> > >
> > > If your issue just with that, and not inversion detection in particular,
> >
> > Looping on all cpufreq policies is the main problem but i also think that capacity
> > inversion is specific to your system and can be replaced by a generic solution
> > that will not make any assumption on any CPUs big vs little or
> > shared vs per cpu dvfs
>
> It is not specific to 'my' system. It is a generic problem to any HMP based
> system. I can understand issues with the implementation. But I can't
> understand how you think taking thermal pressure unconditionally isn't
> a problem. This unconditional consideration of thermal pressure is my problem.
>
>
> Cheers
>
> --
> Qais Yousef
>
> >
> >
> > > I think I can find an alternative approach. Though for education purposes I'd
> > > like to make sure to understand how/when this scalability problem manifests.
> > >
> > > > behavior of SD_ASYM_CPUCAPACITY and SD_ASYM_PACKING instead of 2
> > > > parallel and similar behaviors
> > >
> > > To be clear, you mean load balance path right? If yes, then I'd like us to
> > > consider how we can cater for some of the potential issues I mentioned above.
> > >
> > > > The misfit task could also be unified to integrate other things than
> > > > EAS like the IPC that ricardo is working one. I haven't look in
> > > > details how this could be doable
> > >
> > > To make things more complicated, to increase the effectiveness of uclamp_max,
> > > we need a 'reverse misfit' behavior (terminology credit to Morten).
> > >
> > > If a busy long running task has its uclamp_max changed such that we can put it
> > > on a more energy efficient core, we want to extend misfit to handle down
> > > migrations too. We relied on tasks going to sleep and feec() automatically
> > > doing the right thing next wake up. With uclamp_max the next wake up might not
> > > happen for a while.
> > >
> > >
> > > Thanks!!
> > >
> > > --
> > > Qais Yousef
