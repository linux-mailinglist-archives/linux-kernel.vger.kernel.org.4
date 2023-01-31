Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 118BA6831AD
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 16:38:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233395AbjAaPi4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 10:38:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233390AbjAaPiw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 10:38:52 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F7B1125A0
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 07:38:48 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id h9so6856802plf.9
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 07:38:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1xoRfk5EGOvDnAe/HrfaROykdLosNOtohp4ucTCbgnM=;
        b=sPAO/IA7CdCYzntANH3TWTmfSrQC+VYdAEy/RUF7FzIkeZreVPJPOoP1z8w70wmwvG
         Y+MHsM+IpQMhk7H5gG+1weOrDMTdiXUAqMUtHtTtzKNB6hcdCioU1fQBG5E0slgu8Wd5
         Vp/F36P9JcWygq6Q86JfhdR2bp7I+LOacUnq08xGG05NUj2MDwqTOWlny73D8b0qIRaP
         jlCq+sYbyPoQEzBhYPPdsVE9XnoUxEfNmzxEOEqnI8U6cSY0fF1dEnyno0w7iv0zsSeQ
         b38wV/fMAUAzXdvtB9WUJy0tcNaHX194EGctLPq6C9B9nlKiVw7nwW0dijYFmAI4jzNR
         ttag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1xoRfk5EGOvDnAe/HrfaROykdLosNOtohp4ucTCbgnM=;
        b=HKc4hyzVyoE/sh2fi8f84bmxxvktHIJYw/7mOBili7Bd93OY4nwQ2O+ahX6TpinPlJ
         faZf0ke3KiLxPjETt9lKmWhDjlzp1Qni0n5ldTsKpzHLx+/R0ByGtxvX4OpQc39NdaKK
         M4f4U5HAcekVyNuBGjdWQMQpY/AVMeduPD9oBbcEips/PQIaCZo3IlCeYBlurSXR47CT
         Al/Q+DdoOcjh3lO4HLj/YZu/DaNQYa91jxWnPnqiPiyKCV5q7VDnt+SVX1K2tEMubxcJ
         blglxxN8JJq837DlPGhcP8o0kqIsdn4mdW/V9Li3uX1MNNDXVkKGfRtXWkXepfPubCom
         PLCg==
X-Gm-Message-State: AO0yUKXD3sHrkwwpOTbXHHizLa/foImW4H48Zs5x7hNlRJ0NueFGHFCT
        K6oqaCMObhyfYuJozuxMQOCnK6j4J5H9K7IrH6m+Ig==
X-Google-Smtp-Source: AK7set+Mypt56AuphOYnAv7NVd72FH1ApL2c5kSqP3GRq+Tbvxfg1uZt8l1oCaSNhxGazupQI8oJS18D6j3qa1uV76k=
X-Received: by 2002:a17:90a:c204:b0:22c:1613:164f with SMTP id
 e4-20020a17090ac20400b0022c1613164fmr3048138pjt.103.1675179527329; Tue, 31
 Jan 2023 07:38:47 -0800 (PST)
MIME-Version: 1.0
References: <20230119174244.2059628-1-vincent.guittot@linaro.org>
 <20230129163538.mxkr5ib2glqu36ww@airbuntu> <CAKfTPtADvhtXGn71P_1LoHDm=soUZu3Qi9ziAGfQE9Ob-cs-CA@mail.gmail.com>
 <20230130193028.pkzq5wwxb5ivfwnn@airbuntu>
In-Reply-To: <20230130193028.pkzq5wwxb5ivfwnn@airbuntu>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 31 Jan 2023 16:38:35 +0100
Message-ID: <CAKfTPtAy2SvZPqv9g7c2XoEpg2CFyiFkAKGEro1QKOZcW=QvVQ@mail.gmail.com>
Subject: Re: [PATCH v4] sched/fair: unlink misfit task from cpu overutilized
To:     Qais Yousef <qyousef@layalina.io>
Cc:     mingo@kernel.org, peterz@infradead.org, dietmar.eggemann@arm.com,
        rafael@kernel.org, viresh.kumar@linaro.org, vschneid@redhat.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        lukasz.luba@arm.com, wvw@google.com, xuewen.yan94@gmail.com,
        han.lin@mediatek.com, Jonathan.JMChen@mediatek.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Jan 2023 at 20:30, Qais Yousef <qyousef@layalina.io> wrote:
>
> On 01/30/23 15:13, Vincent Guittot wrote:
> > On Sun, 29 Jan 2023 at 17:35, Qais Yousef <qyousef@layalina.io> wrote:
> > >
> > > On 01/19/23 18:42, Vincent Guittot wrote:
> > > > By taking into account uclamp_min, the 1:1 relation between task misfit
> > > > and cpu overutilized is no more true as a task with a small util_avg may
> > > > not fit a high capacity cpu because of uclamp_min constraint.
> > > >
> > > > Add a new state in util_fits_cpu() to reflect the case that task would fit
> > > > a CPU except for the uclamp_min hint which is a performance requirement.
> > > >
> > > > Use -1 to reflect that a CPU doesn't fit only because of uclamp_min so we
> > > > can use this new value to take additional action to select the best CPU
> > > > that doesn't match uclamp_min hint.
> > > >
> > > > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > > > ---
> > >
> > > I did improve my unit test so that I look at overutilized and misfit condition.
> > >
> > > Of course I had to hack the kernel to expose something to manipulate the
> > > thermal pressure signal. I also made sure to use the sched_energy_aware knob to
> > > switch between using EAS/CAS so that both feec() and sic() are exercised.
> > >
> > > My test system is pinebook pro which has a simple 2 level capacities - but
> > > I couldn't catch anything wrong. Only one unrelated failure - see below.
> > >
> > > I'd be happy to give this my Reviewed-and-tested-by. What's the plan for the
> > > removal the capacity_inversion logic?
> >
> > Thanks for the  Reviewed-and-tested-by.
> >
> > Regarding the removal of capacity_inversion logic , I don't know how
> > Peter prefers to handle this in one step with this patch then the
> > reverts or revert capacity_inversion logic in a 2nd step
>
> Or just fold the removal into this patch?
>
> I think your patch should at least include this part
>
>         diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>         index dcbcb496b879..27cc5a029c22 100644
>         --- a/kernel/sched/fair.c
>         +++ b/kernel/sched/fair.c
>         @@ -4476,17 +4476,9 @@ static inline int util_fits_cpu(unsigned long util,
>                  *
>                  * For uclamp_max, we can tolerate a drop in performance level as the
>                  * goal is to cap the task. So it's okay if it's getting less.
>         -        *
>         -        * In case of capacity inversion we should honour the inverted capacity
>         -        * for both uclamp_min and uclamp_max all the time.
>                  */
>         -       capacity_orig = cpu_in_capacity_inversion(cpu);
>         -       if (capacity_orig) {
>         -               capacity_orig_thermal = capacity_orig;
>         -       } else {
>         -               capacity_orig = capacity_orig_of(cpu);
>         -               capacity_orig_thermal = capacity_orig - arch_scale_thermal_pressure(cpu);
>         -       }
>         +       capacity_orig = capacity_orig_of(cpu);
>         +       capacity_orig_thermal = capacity_orig - arch_scale_thermal_pressure(cpu);
>
>                 /*
>                  * We want to force a task to fit a cpu as implied by uclamp_max.
>
> but the rest is not a lot of code to remove luckily, so doing it all in one go
> might be easier.

I think it's worth having separate patches for removing
capacity_inversion logic. This will ease the history tracking and the
manipulation of commits. I can create a patchset with this one and the
removal.

Cheers
Vincent
>
>
> Cheers
>
> --
> Qais Yousef
>
> >
> > >
> > > And nit: subject line could still be improved :) This is a lot more than
> > > unlinking misfit from OU.
> > >
> > > >
> > > > Change since v3:
> > > > - Keep current condition for uclamp_max_fits in util_fits_cpu()
> > > > - Update some comments
> > > >
> > > >  kernel/sched/fair.c | 105 ++++++++++++++++++++++++++++++++++----------
> > > >  1 file changed, 82 insertions(+), 23 deletions(-)
> > > >
> > > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > > index d4db72f8f84e..54e14da53274 100644
> > > > --- a/kernel/sched/fair.c
> > > > +++ b/kernel/sched/fair.c
> > > > @@ -4561,8 +4561,8 @@ static inline int util_fits_cpu(unsigned long util,
> > > >        * handle the case uclamp_min > uclamp_max.
> > > >        */
> > > >       uclamp_min = min(uclamp_min, uclamp_max);
> > > > -     if (util < uclamp_min && capacity_orig != SCHED_CAPACITY_SCALE)
> > > > -             fits = fits && (uclamp_min <= capacity_orig_thermal);
> > > > +     if (fits && (util < uclamp_min) && (uclamp_min > capacity_orig_thermal))
> > > > +             return -1;
> > > >
> > > >       return fits;
> > > >  }
> > > > @@ -4572,7 +4572,11 @@ static inline int task_fits_cpu(struct task_struct *p, int cpu)
> > > >       unsigned long uclamp_min = uclamp_eff_value(p, UCLAMP_MIN);
> > > >       unsigned long uclamp_max = uclamp_eff_value(p, UCLAMP_MAX);
> > > >       unsigned long util = task_util_est(p);
> > > > -     return util_fits_cpu(util, uclamp_min, uclamp_max, cpu);
> > > > +     /*
> > > > +      * Return true only if the cpu fully fits the task requirements, which
> > > > +      * include the utilization but also the performance hints.
> > > > +      */
> > > > +     return (util_fits_cpu(util, uclamp_min, uclamp_max, cpu) > 0);
> > > >  }
> > > >
> > > >  static inline void update_misfit_status(struct task_struct *p, struct rq *rq)
> > > > @@ -6138,6 +6142,7 @@ static inline bool cpu_overutilized(int cpu)
> > > >       unsigned long rq_util_min = uclamp_rq_get(cpu_rq(cpu), UCLAMP_MIN);
> > > >       unsigned long rq_util_max = uclamp_rq_get(cpu_rq(cpu), UCLAMP_MAX);
> > > >
> > > > +     /* Return true only if the utilization doesn't fits CPU's capacity */
> > > >       return !util_fits_cpu(cpu_util_cfs(cpu), rq_util_min, rq_util_max, cpu);
> > > >  }
> > > >
> > > > @@ -6931,6 +6936,7 @@ static int
> > > >  select_idle_capacity(struct task_struct *p, struct sched_domain *sd, int target)
> > > >  {
> > > >       unsigned long task_util, util_min, util_max, best_cap = 0;
> > > > +     int fits, best_fits = 0;
> > > >       int cpu, best_cpu = -1;
> > > >       struct cpumask *cpus;
> > > >
> > > > @@ -6946,12 +6952,28 @@ select_idle_capacity(struct task_struct *p, struct sched_domain *sd, int target)
> > > >
> > > >               if (!available_idle_cpu(cpu) && !sched_idle_cpu(cpu))
> > > >                       continue;
> > > > -             if (util_fits_cpu(task_util, util_min, util_max, cpu))
> > > > +
> > > > +             fits = util_fits_cpu(task_util, util_min, util_max, cpu);
> > > > +
> > > > +             /* This CPU fits with all requirements */
> > > > +             if (fits > 0)
> > > >                       return cpu;
> > > > +             /*
> > > > +              * Only the min performance hint (i.e. uclamp_min) doesn't fit.
> > > > +              * Look for the CPU with best capacity.
> > > > +              */
> > > > +             else if (fits < 0)
> > > > +                     cpu_cap = capacity_orig_of(cpu) - thermal_load_avg(cpu_rq(cpu));
> > > >
> > > > -             if (cpu_cap > best_cap) {
> > > > +             /*
> > > > +              * First, select CPU which fits better (-1 being better than 0).
> > > > +              * Then, select the one with best capacity at same level.
> > > > +              */
> > > > +             if ((fits < best_fits) ||
> > > > +                 ((fits == best_fits) && (cpu_cap > best_cap))) {
> > > >                       best_cap = cpu_cap;
> > > >                       best_cpu = cpu;
> > > > +                     best_fits = fits;
> > > >               }
> > > >       }
> > >
> > > Not something you introduced, but I had a 'failure' case when I ran a task with
> > > (uclamp_min, uclamp_max) = (1024, 1024) followed by (0, 0) in CAS.
> > >
> > > The task was basically stuck on big core and I check if the task can run on the
> > > smallest possible capacity in my test.
> > >
> > > This is a separate problem that we should address out of this patch. One can
> > > argue CAS is not energy aware, so any fitting cpu is okay. But one of the goals
> > > of uclamp_max is to help keep some busy tasks away from bigger cores when
> > > possible - not only for power reasons, but also for perf reasons as they can
> > > 'steal' resources from other tasks. So the lack of a more comprehensive search
> > > is a weakness and something we can improve on.
> > >
> > > feec() behaves fine - but after applying some fixes that I've been sleeping on
> > > for a bit. Should see them in your inbox now.
> > >
> > > Thanks for the patch! I am still wary of the complexity, but the fallback
> > > search could lead to better placement results now.
> > >
> > >
> > > Cheers
> > >
> > > --
> > > Qais Yousef
> > >
> > > >
> > > > @@ -6964,7 +6986,11 @@ static inline bool asym_fits_cpu(unsigned long util,
> > > >                                int cpu)
> > > >  {
> > > >       if (sched_asym_cpucap_active())
> > > > -             return util_fits_cpu(util, util_min, util_max, cpu);
> > > > +             /*
> > > > +              * Return true only if the cpu fully fits the task requirements
> > > > +              * which include the utilization and the performance hints.
> > > > +              */
> > > > +             return (util_fits_cpu(util, util_min, util_max, cpu) > 0);
> > > >
> > > >       return true;
> > > >  }
> > > > @@ -7331,6 +7357,9 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
> > > >       unsigned long p_util_max = uclamp_is_used() ? uclamp_eff_value(p, UCLAMP_MAX) : 1024;
> > > >       struct root_domain *rd = this_rq()->rd;
> > > >       int cpu, best_energy_cpu, target = -1;
> > > > +     int prev_fits = -1, best_fits = -1;
> > > > +     unsigned long best_thermal_cap = 0;
> > > > +     unsigned long prev_thermal_cap = 0;
> > > >       struct sched_domain *sd;
> > > >       struct perf_domain *pd;
> > > >       struct energy_env eenv;
> > > > @@ -7366,6 +7395,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
> > > >               unsigned long prev_spare_cap = 0;
> > > >               int max_spare_cap_cpu = -1;
> > > >               unsigned long base_energy;
> > > > +             int fits, max_fits = -1;
> > > >
> > > >               cpumask_and(cpus, perf_domain_span(pd), cpu_online_mask);
> > > >
> > > > @@ -7418,7 +7448,9 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
> > > >                                       util_max = max(rq_util_max, p_util_max);
> > > >                               }
> > > >                       }
> > > > -                     if (!util_fits_cpu(util, util_min, util_max, cpu))
> > > > +
> > > > +                     fits = util_fits_cpu(util, util_min, util_max, cpu);
> > > > +                     if (!fits)
> > > >                               continue;
> > > >
> > > >                       lsub_positive(&cpu_cap, util);
> > > > @@ -7426,7 +7458,9 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
> > > >                       if (cpu == prev_cpu) {
> > > >                               /* Always use prev_cpu as a candidate. */
> > > >                               prev_spare_cap = cpu_cap;
> > > > -                     } else if (cpu_cap > max_spare_cap) {
> > > > +                             prev_fits = fits;
> > > > +                     } else if ((fits > max_fits) ||
> > > > +                                ((fits == max_fits) && (cpu_cap > max_spare_cap))) {
> > > >                               /*
> > > >                                * Find the CPU with the maximum spare capacity
> > > >                                * among the remaining CPUs in the performance
> > > > @@ -7434,6 +7468,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
> > > >                                */
> > > >                               max_spare_cap = cpu_cap;
> > > >                               max_spare_cap_cpu = cpu;
> > > > +                             max_fits = fits;
> > > >                       }
> > > >               }
> > > >
> > > > @@ -7452,26 +7487,50 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
> > > >                       if (prev_delta < base_energy)
> > > >                               goto unlock;
> > > >                       prev_delta -= base_energy;
> > > > +                     prev_thermal_cap = cpu_thermal_cap;
> > > >                       best_delta = min(best_delta, prev_delta);
> > > >               }
> > > >
> > > >               /* Evaluate the energy impact of using max_spare_cap_cpu. */
> > > >               if (max_spare_cap_cpu >= 0 && max_spare_cap > prev_spare_cap) {
> > > > +                     /* Current best energy cpu fits better */
> > > > +                     if (max_fits < best_fits)
> > > > +                             continue;
> > > > +
> > > > +                     /*
> > > > +                      * Both don't fit performance hint (i.e. uclamp_min)
> > > > +                      * but best energy cpu has better capacity.
> > > > +                      */
> > > > +                     if ((max_fits < 0) &&
> > > > +                         (cpu_thermal_cap <= best_thermal_cap))
> > > > +                             continue;
> > > > +
> > > >                       cur_delta = compute_energy(&eenv, pd, cpus, p,
> > > >                                                  max_spare_cap_cpu);
> > > >                       /* CPU utilization has changed */
> > > >                       if (cur_delta < base_energy)
> > > >                               goto unlock;
> > > >                       cur_delta -= base_energy;
> > > > -                     if (cur_delta < best_delta) {
> > > > -                             best_delta = cur_delta;
> > > > -                             best_energy_cpu = max_spare_cap_cpu;
> > > > -                     }
> > > > +
> > > > +                     /*
> > > > +                      * Both fit for the task but best energy cpu has lower
> > > > +                      * energy impact.
> > > > +                      */
> > > > +                     if ((max_fits > 0) && (best_fits > 0) &&
> > > > +                         (cur_delta >= best_delta))
> > > > +                             continue;
> > > > +
> > > > +                     best_delta = cur_delta;
> > > > +                     best_energy_cpu = max_spare_cap_cpu;
> > > > +                     best_fits = max_fits;
> > > > +                     best_thermal_cap = cpu_thermal_cap;
> > > >               }
> > > >       }
> > > >       rcu_read_unlock();
> > > >
> > > > -     if (best_delta < prev_delta)
> > > > +     if ((best_fits > prev_fits) ||
> > > > +         ((best_fits > 0) && (best_delta < prev_delta)) ||
> > > > +         ((best_fits < 0) && (best_thermal_cap > prev_thermal_cap)))
> > > >               target = best_energy_cpu;
> > > >
> > > >       return target;
> > > > @@ -10265,24 +10324,23 @@ static struct sched_group *find_busiest_group(struct lb_env *env)
> > > >        */
> > > >       update_sd_lb_stats(env, &sds);
> > > >
> > > > -     if (sched_energy_enabled()) {
> > > > -             struct root_domain *rd = env->dst_rq->rd;
> > > > -
> > > > -             if (rcu_dereference(rd->pd) && !READ_ONCE(rd->overutilized))
> > > > -                     goto out_balanced;
> > > > -     }
> > > > -
> > > > -     local = &sds.local_stat;
> > > > -     busiest = &sds.busiest_stat;
> > > > -
> > > >       /* There is no busy sibling group to pull tasks from */
> > > >       if (!sds.busiest)
> > > >               goto out_balanced;
> > > >
> > > > +     busiest = &sds.busiest_stat;
> > > > +
> > > >       /* Misfit tasks should be dealt with regardless of the avg load */
> > > >       if (busiest->group_type == group_misfit_task)
> > > >               goto force_balance;
> > > >
> > > > +     if (sched_energy_enabled()) {
> > > > +             struct root_domain *rd = env->dst_rq->rd;
> > > > +
> > > > +             if (rcu_dereference(rd->pd) && !READ_ONCE(rd->overutilized))
> > > > +                     goto out_balanced;
> > > > +     }
> > > > +
> > > >       /* ASYM feature bypasses nice load balance check */
> > > >       if (busiest->group_type == group_asym_packing)
> > > >               goto force_balance;
> > > > @@ -10295,6 +10353,7 @@ static struct sched_group *find_busiest_group(struct lb_env *env)
> > > >       if (busiest->group_type == group_imbalanced)
> > > >               goto force_balance;
> > > >
> > > > +     local = &sds.local_stat;
> > > >       /*
> > > >        * If the local group is busier than the selected busiest group
> > > >        * don't try and pull any tasks.
> > > > --
> > > > 2.34.1
> > > >
