Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA92764DFF0
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 18:47:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbiLORrJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 12:47:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiLORrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 12:47:05 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FDB027DFC
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 09:47:04 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id h16so157734qtu.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 09:47:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YjU7ImCpLwzgxnIjTkSP2vnM+kGb305Prb8ZQca/OQc=;
        b=nVdbY/JojNARdY0L4fMkzzX2A+r/JfvkIHyHARIPErxTQ/wA52SjERZ7Wp4+S+95/2
         GcUKPom1ciHB6LDqF4DYhDhSgbKnkIlfFWMUrLCy7xSfbBW7aKRF7EHuUA1RHDp4vNOc
         n7ohCeDAnBXOBczzETt+EjTh3LNBtbLt/QBCYC9Y1843Z3oEmY9J4T73gBbMTMCFNynw
         gktyxmcDq3WgRPsVZrEd3MAS24g9QGmNOMXP/TT1bcG9Kh3vxSwVFAZCa20I3gEjzvkr
         GEfxguFihXTNq26QrAMfyTjoZqsua7khM9ANrzStjixpL1f/lJG/8dXekNILXya6xD0Y
         If7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YjU7ImCpLwzgxnIjTkSP2vnM+kGb305Prb8ZQca/OQc=;
        b=7LapiOcBiXhGmTELEhqCXae0X2jOdwdjTIKDIK3nlO8cc9oW4pD1UQeLGSCMx/a75s
         m9yJTY4g7Ts+sveSy8ViNdVmO8sgUBRbVyYv/WRinhQXCvL/q5nSAuORaURJMIfGDaBB
         QhP0R9VKO2kO3P7Rvt8evG8rPvmdF82jq+imaL5QzKk+xZ0WwCz5+ELJhN75ryXx/BA+
         Hvi/WLh1NkXaIxKsCrMCqRMrGtUShR+/RbA9yD+eaqUBCF7+2ZL55DozUg4PT1uMLWDB
         iAW5hL07XG9kFuW0iiQINGtf5u6p9cxxFSht//aCaOnH6iox4D/gJbsSt3w+IOyfa9a5
         15Hw==
X-Gm-Message-State: ANoB5pkTr8DmhFqtaOyjgbVi4BexJ5AoRhePLtHVdEzhUnxFZ2DDAe1G
        lQy1H/OHukidLCRs3YQfX25c6C5CyBg+BCQ0P4Vj/g==
X-Google-Smtp-Source: AA0mqf6R7byYIJqwTJi4yv5JPbZo4kyNI7rdQCKrFMO/ig3ZYTlfqp1GT/x1JMgGj8RCRrMbjfFr96G5gctWp9hY+38=
X-Received: by 2002:ac8:46da:0:b0:3a7:fee2:7ce2 with SMTP id
 h26-20020ac846da000000b003a7fee27ce2mr2000118qto.549.1671126423043; Thu, 15
 Dec 2022 09:47:03 -0800 (PST)
MIME-Version: 1.0
References: <20221127141742.1644023-1-qyousef@layalina.io> <20221127141742.1644023-4-qyousef@layalina.io>
 <CAKfTPtCawKvhMwJYVUskYcX7eR2K7SziWVzvjGh6JCVB+WT5tQ@mail.gmail.com>
 <20221203143323.w32boxa6asqvvdnp@airbuntu> <CAKfTPtCZYGEvDBe5X1v7TiNZag0atUozGKip6EAgvZDWyo8e-g@mail.gmail.com>
 <20221205110159.nd5igwvsaj55jar7@airbuntu> <CAKfTPtAOhQyfyH_qRArC2SZ1sQOBnRZ4CXARiWu2fvb+KPGsXw@mail.gmail.com>
 <20221208140526.vvmjxlz6akgqyoma@airbuntu> <20221209164739.GA24368@vingu-book>
 <20221212184317.sntxy3h6k44oz4mo@airbuntu> <1c3c1245-2576-df2e-246b-fc30657fcb56@arm.com>
In-Reply-To: <1c3c1245-2576-df2e-246b-fc30657fcb56@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 15 Dec 2022 18:46:51 +0100
Message-ID: <CAKfTPtBNnfT_P3z+J4RDLiSaDD293jVpm54HjaOe0uqeWH2moQ@mail.gmail.com>
Subject: Re: [RFC PATCH 3/3] sched/fair: Traverse cpufreq policies to detect
 capacity inversion
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Qais Yousef <qyousef@layalina.io>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
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

On Tue, 13 Dec 2022 at 18:38, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>
> On 12/12/2022 19:43, Qais Yousef wrote:
> > On 12/09/22 17:47, Vincent Guittot wrote:
>
> [...]
>
> > HMP systems for 1k servers just don't make any sense. A desktop with 128 or
> > even 256 HMP cores is a big stretch; and if that exist I don't think there's an
> > overhead to worry about here; and I *did* consider this. I measured the impact
> > if we have 128 and it was mere 1 or 2 us extra.  And that's on under powered
> > pine book pro. If such a system exist it'd probably be more performant.
> >
> >> uclamp_min must not set a CPU overutilized because the CPU is not overutilized
> >> in this case. It's only the task that is misfit. You mostly try to bias some
> >> behavior to fit your use case.
> >
> > Maybe we are talking about different things over here. As long as we agree it's
> > a misfit task then we are aligned.
>
> IMHO, utilization is about the running task and uclamp is maintained
> taking the runnable tasks into consideration as well. Maybe that's the
> source of the different views here?
>
> > As far as I know misfit required overutilized to re-enable load balance. But
> > maybe there's a detail that's creating this confusion.
>
> I think that Vincent is suggesting to let MF load balance happening even
> in !OverUtilized (OU). We gather the necessary load-balance statistics
> already today in !OU so it is easily to do.
>
> >>>> doesn means that the cpu is overutilized and uclamp_max should be used
> >>>
> >>> It is a misfit task; which requires overutilized to be set to re-enable load
> >>> balance for uclamp_min to upgrate it. For uclamp max we should not set
> >>> overutilized, agreed and that's what we should be doing.
> >>
> >> That's probably the root of your problem here. The load balance is still
> >> periodically called even when EAS is enabled but the latter prevents task
> >> migration unless overutilized in order to not break the energy aware task
> >
> > Okay. For me this means load_balance is disabled since it's effectively doing
> > nothing. So maybe it's a terminology problem of what I meant with load balance
> > is disabled.
> >
> >> placement. But if a task is misplaced and a cpu finds it can help,
> >> we should let it pull the task without disabling EAS. This will not enable the
> >> performance spread behavior and we can expect the other small tasks to be
> >> packed by EAS on the best cpu at next wakeup.
> >>
> >> So intead of trying to detect a very specific capacity inversion use case
> >> during this periodic this load balance, it's better to let a CPU that can
> >> fix the misfit situation to pull the task.
> >
> > I can't see the relation here.
>
> To me it looks like that there are 2 stories here:
>
> (A) Why do we need `CPU capacity inversion` (CapInv)? What do we gain
>     by changing `cap = capacity_orig - arch_scale_thermal_pressure()`
>     (i) to `cap = capacity_orig - thermal_load_avg()` (ii)? Do we want
>     to avoid a CPU as a possible target in cases where pressure is
>     already back to 0 and we still have a thermal PELT signal > 0
>     because of it's historic information? But this is then only
>     considering the decaying side of the thermal PELT signal.
>
>     Vincent replaces (i) by (ii) so no need to switch to (ii) for
>     CapInv.
>
> (B) Don't use util_fits_cpu() in cpu_overutilized() and replace this by
>     MF load balance in !OU.
>
> [...]
>
> >> I have reverted patches:
> >> Revert "sched/fair: Detect capacity inversion"
> >> Revert "sched/fair: Consider capacity inversion in util_fits_cpu()"
> >> Revert "sched/uclamp: Make cpu_overutilized() use util_fits_cpu()"
> >>
> >> ---
> >>  kernel/sched/fair.c | 32 +++++++++++++++++---------------
> >>  1 file changed, 17 insertions(+), 15 deletions(-)
> >>
> >> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> >> index 4423681baf15..6e54afc0a6ec 100644
> >> --- a/kernel/sched/fair.c
> >> +++ b/kernel/sched/fair.c
> >> @@ -4539,7 +4539,7 @@ static inline int util_fits_cpu(unsigned long util,
> >>       * the time.
> >>       */
> >>      capacity_orig = capacity_orig_of(cpu);
> >> -    capacity_orig_thermal = capacity_orig - arch_scale_thermal_pressure(cpu);
> >> +    capacity_orig_thermal = capacity_orig - thermal_load_avg(cpu_rq(cpu));
> >>
> >>      /*
> >>       * We want to force a task to fit a cpu as implied by uclamp_max.
> >> @@ -4578,8 +4578,7 @@ static inline int util_fits_cpu(unsigned long util,
> >>       *     2. The system is being saturated when we're operating near
> >>       *        max capacity, it doesn't make sense to block overutilized.
> >>       */
> >> -    uclamp_max_fits = (capacity_orig == SCHED_CAPACITY_SCALE) && (uclamp_max == SCHED_CAPACITY_SCALE);
> >> -    uclamp_max_fits = !uclamp_max_fits && (uclamp_max <= capacity_orig);
> >> +    uclamp_max_fits = (uclamp_max <= capacity_orig) || (capacity_orig == SCHED_CAPACITY_SCALE);
> >>      fits = fits || uclamp_max_fits;
> >>
> >>      /*
> >> @@ -4614,7 +4613,7 @@ static inline int util_fits_cpu(unsigned long util,
> >>       * handle the case uclamp_min > uclamp_max.
> >>       */
> >>      uclamp_min = min(uclamp_min, uclamp_max);
> >> -    if (util < uclamp_min && capacity_orig != SCHED_CAPACITY_SCALE)
> >> +    if (util < uclamp_min)
> >>              fits = fits && (uclamp_min <= capacity_orig_thermal);
> >>
> >>      return fits;
> >> @@ -6064,7 +6063,10 @@ static inline void hrtick_update(struct rq *rq)
> >>  #ifdef CONFIG_SMP
> >>  static inline bool cpu_overutilized(int cpu)
> >>  {
> >> -    return !fits_capacity(cpu_util_cfs(cpu), capacity_of(cpu));
> >> +    unsigned long rq_util_max = uclamp_rq_get(cpu_rq(cpu), UCLAMP_MAX);
> >> +
> >> +    return !(fits_capacity(cpu_util_cfs(cpu), capacity_of(cpu)) ||
> >> +             rq_util_max <= capacity_orig_of(cpu));
> >>  }
> >>
> >>  static inline void update_overutilized_status(struct rq *rq)
> >> @@ -10164,24 +10166,23 @@ static struct sched_group *find_busiest_group(struct lb_env *env)
> >>       */
> >>      update_sd_lb_stats(env, &sds);
> >>
> >> -    if (sched_energy_enabled()) {
> >> -            struct root_domain *rd = env->dst_rq->rd;
> >> -
> >> -            if (rcu_dereference(rd->pd) && !READ_ONCE(rd->overutilized))
> >> -                    goto out_balanced;
> >> -    }
> >> -
> >> -    local = &sds.local_stat;
> >> -    busiest = &sds.busiest_stat;
> >> -
> >>      /* There is no busy sibling group to pull tasks from */
> >>      if (!sds.busiest)
> >>              goto out_balanced;
> >>
> >> +    busiest = &sds.busiest_stat;
> >> +
> >>      /* Misfit tasks should be dealt with regardless of the avg load */
> >>      if (busiest->group_type == group_misfit_task)
> >>              goto force_balance;
> >>
> >> +    if (sched_energy_enabled()) {
> >> +            struct root_domain *rd = env->dst_rq->rd;
> >> +
> >> +            if (rcu_dereference(rd->pd) && !READ_ONCE(rd->overutilized))
> >> +                    goto out_balanced;
> >> +    }
> >> +
> >>      /* ASYM feature bypasses nice load balance check */
> >>      if (busiest->group_type == group_asym_packing)
> >>              goto force_balance;
> >> @@ -10194,6 +10195,7 @@ static struct sched_group *find_busiest_group(struct lb_env *env)
> >>      if (busiest->group_type == group_imbalanced)
> >>              goto force_balance;
> >>
> >> +    local = &sds.local_stat;
> >>      /*
> >>       * If the local group is busier than the selected busiest group
> >>       * don't try and pull any tasks.
> >> --
> >> 2.17.1
>
> Specific questions regarding this patch proposal so I can fully
> understand the intention:
>
> I see 4 major changes here:
>
> (1) Remove `CPU capacity inversion` (CapInv)
>
> (2) Don't use util_fits_cpu() in cpu_overutilized()
>
> (3) Use `capacity = capacity_orig - thermal_load_avg() (ii)` (and not `-
>     arch_scale_thermal_pressure() (i)` in util_fits_cpu(), i.e. in
>     sis(), feec(), MF handling (update + load balance (lb))
>
> (4) Allow MF lb in !OverUtilized (OU)
>
> (1) CapInv wouldn't be needed in case only (ii) is used (so we don't
> have to switch from (i) to (ii) (because of 3)?
>
> (2) is there since we don't have to raise OU anymore when `rq_util_min >
> capacity_orig_thermal`. This is replaced by MF handling in !OU lb (4)?

yes and also because a task can misfit on a cpu because of uclamp_min
but the cpu is not overloaded

>
> [...]
