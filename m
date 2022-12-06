Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DFE1644AED
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 19:12:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbiLFSMw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 13:12:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbiLFSMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 13:12:49 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B083D12614
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 10:12:47 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id q190so5131129iod.10
        for <linux-kernel@vger.kernel.org>; Tue, 06 Dec 2022 10:12:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=98tt9zgOlFb7SQ0Z6rVtxHltsA1u3b0WdxaBjtzQmU8=;
        b=w9pq60dH+lWo961EuckXEbkEmFNZKDMezFLvD4VFB/ytxxc3JddPxP4N1yVQGrYI+I
         /ZidYOLfigLAjllWnPRrbIjFw4oK7npFgyIUQrevk37OKXPuBVe4Q7Bnbfh8Jt/ITSTd
         X8T5DYVGAUPExPGSpTQtqvYaO3hcyEtO6v4Uuwuyh4R2n+sLEFubF9bPKTyl5O2Phr+Y
         rFSaCrXQDpYjQuIeqZ+3idRAxyqIDlgB3RiG8GLcrwVE0b29tZVkDX59qpvhNojuFmKC
         7UGL+Mbo8FmnSltb1TG6VrXQyQ4PBLLVWTegfYHxTypJIiKbFSAmLx8OWArLoCvBIXxf
         e7cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=98tt9zgOlFb7SQ0Z6rVtxHltsA1u3b0WdxaBjtzQmU8=;
        b=ycM5Dqag0UqP3J2S6WZHdouKsuASGPTGMbb3p+M6SZXPnpZPfr3sfc+XV9rMh5ApAQ
         mCrWVqfvYeNLXy74WvOW/nHtfg4uhM7VGtYR9LOWjlsjf4ghMnJgeEOD/Is8ZRy4iMUb
         GkaVK6wGOxGvpf7du5xJRZOWdb1CMn9xQfZSI1A2ROXoFTRQf0ukGNnkDvzei3kLoLBx
         yNpw525/nZeAsAGJ4msaMYpaLNDNHSMR/py11hVdel4XSycyxxpW9SPII4OF7RplifKs
         YOrr/4MHzxhiLJtAteueoYt0ogNmC4ujjjvS7UlxK1z54mVEou8DpdomgXej9HEWi+dt
         ELUQ==
X-Gm-Message-State: ANoB5plUm/a/OUwS4b3k6q/oHdevUwnVOtCSBrSiGccllN9w2JTUdnd7
        OhMI8YYQPWUp5F4Hes/QV4+yqSq2O8HWEbW/Fk4p9w==
X-Google-Smtp-Source: AA0mqf4jYHD50S/v+wuhHs7xaizH8fQ+kmhRXqHgw+cfrXFwmOmZZ+kKBeOP+eo67dIz7FWIDJmLh3IQKleUTRzBd0Q=
X-Received: by 2002:a05:6638:328a:b0:386:eaa7:85dd with SMTP id
 f10-20020a056638328a00b00386eaa785ddmr29777384jav.120.1670350366943; Tue, 06
 Dec 2022 10:12:46 -0800 (PST)
MIME-Version: 1.0
References: <20221127141742.1644023-1-qyousef@layalina.io> <20221127141742.1644023-4-qyousef@layalina.io>
 <CAKfTPtCawKvhMwJYVUskYcX7eR2K7SziWVzvjGh6JCVB+WT5tQ@mail.gmail.com>
 <20221203143323.w32boxa6asqvvdnp@airbuntu> <CAKfTPtCZYGEvDBe5X1v7TiNZag0atUozGKip6EAgvZDWyo8e-g@mail.gmail.com>
 <20221205110159.nd5igwvsaj55jar7@airbuntu>
In-Reply-To: <20221205110159.nd5igwvsaj55jar7@airbuntu>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 6 Dec 2022 19:12:35 +0100
Message-ID: <CAKfTPtAOhQyfyH_qRArC2SZ1sQOBnRZ4CXARiWu2fvb+KPGsXw@mail.gmail.com>
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

On Mon, 5 Dec 2022 at 12:02, Qais Yousef <qyousef@layalina.io> wrote:
>
> On 12/04/22 12:35, Vincent Guittot wrote:
> > On Sat, 3 Dec 2022 at 15:33, Qais Yousef <qyousef@layalina.io> wrote:
> > >
> > > On 12/02/22 15:57, Vincent Guittot wrote:
> > >
> > > > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > > > index 7c0dd57e562a..4bbbca85134b 100644
> > > > > --- a/kernel/sched/fair.c
> > > > > +++ b/kernel/sched/fair.c
> > > > > @@ -8856,23 +8856,20 @@ static void update_cpu_capacity(struct sched_domain *sd, int cpu)
> > > > >          *   * Thermal pressure will impact all cpus in this perf domain
> > > > >          *     equally.
> > > > >          */
> > > > > -       if (sched_energy_enabled()) {
> > > > > +       if (static_branch_unlikely(&sched_asym_cpucapacity)) {
> > > > >                 unsigned long inv_cap = capacity_orig - thermal_load_avg(rq);
> > > > > -               struct perf_domain *pd = rcu_dereference(rq->rd->pd);
> > > > > +               struct cpufreq_policy *policy, __maybe_unused *policy_n;
> > > > >
> > > > >                 rq->cpu_capacity_inverted = 0;
> > > > >
> > > > > -               SCHED_WARN_ON(!rcu_read_lock_held());
> > > > > -
> > > > > -               for (; pd; pd = pd->next) {
> > > > > -                       struct cpumask *pd_span = perf_domain_span(pd);
> > > > > +               for_each_active_policy_safe(policy, policy_n) {
> > > >
> > > > So you are looping all cpufreq policy (and before the perf domain) in
> > > > the period load balance. That' really not something we should or want
> > > > to do
> > >
> > > Why is it not acceptable in the period load balance but acceptable in the hot
> > > wake up path in feec()? What's the difference?
> >
> > This patch loops on all cpufreq policy in sched softirq, how can this
> > be sane ? and not only in eas mode but also in the default asymmetric
>
> Hmm I'm still puzzled. Why it's not sane to do it here but it's okay to do it
> in the wake up path in feec()?

feec() should be considered as an exception not as the default rule.
Thing like above which loops for_each on external subsystem should be
prevented and the fact that feec loops all PDs doesn't means that we
can put that everywhere else

>
> AFAICT the number of cpufreq policies and perf domains have 1:1 mapping. In
> feec() we not only loop perf domains, but we go through each cpu of each domain
> to find max_spare_cap then compute_energy(). Which is more intensive.
>
> In worst case scenario where there's a perf domain for each cpu, then we'll
> loop through every CPU *and* compute energy its energy cost in the wake up
> path.
>
> Why it's deemed acceptable in wake up path which is more critical AFAIU but not
> period load balance which is expected to do more work? What am I missing?

Things like util_fits_cpu is not an EAS only feature although it's the
only user for now and this must remain usable by another part of the
scheduler that wants to check if a workload can fit on a cpu if
needed. But adding not scalable behavior makes it not usable by
default for anything else than Android big.LITTLE with 8 CPUs and 2/3
PDs.

As a summary the rule is to be scalable and don't assume that a
for_each loop on another framework can be reasonable thus the above is
not.

The fact that feec is not scalable and assumes that a system will not
have more than 8 cores and 2/3 PDs is a problem IMO because it
prevents other systems from even considering using it.

Also as mentioned before, the above will be called as soon as
sched_asym_cpucapacity is enabled even if eas and feec() is not used
so you extend the problem outside feec().

>
> > performance  one.
> >
> > This inverted detection doesn't look like the right way to fix your
> > problem IMO. That being said, i agree that I haven't made any other
> > proposal apart that I think that you should use a different rules for
> > task and for overutilized and part of your problem comes from this.
>
> We discussed this before; I need to revisit the thread but I can't see how
> overutilized different than task will fix the issue. They should be unified by
> design.

A unified design doesn't mean one function especially if that includes
to loop for_each_active_policy_safe() in sched softirq

uclamp_min should not be used to set an over utilized cpu  because it
doesn means that the cpu is overutilized and uclamp_max should be used
for not setting overutilized a cpu with a clamped max value

>
> I'm all ears if there's a simpler way to address the problem :-)

let me try to prepare a something to show what I mean

>
> The problem is that thermal pressure on big cpu is not important from
> uclamp perspective until it is in inversion state. It is quite common to have
> a system where the medium capacity is in 500 range. If the big is under thermal
> pressure that it drops to 800, then it is still a fitting CPU from uclamp
> perspective. Keep in mind uclamp_min is useful for tasks whose utilization is
> small So we need to be selective when thermal pressure is actually helping out
> or just creating unnecessary problems.

What about medium cores ?  There are often 3 capacity levels now so
the same can happen between medium and little.

Also we have more and more thermal capping happening ahead of
overheating like the power cap interface where we want to cap some
CPUs and others even before they reach their thermal limit in order to
get more power/thermal room for others. This implies that some CPUs
could be under thermal pressure whereas others not. This implies also
that a UC with big core capacity being below little and medium cores
is not impossible or medium being under little but big staying at high
capacity.

>
> The only other option I had in mind was to do the detection when we update the
> thermal_pressure in the topology code. But that didn't look better alternative
> to me.
>
> >
> > Then this make eas and util_fits_cpu even more Arm specific and I
>
> What is the Arm specific part about it? Why it wouldn't work on non-Arm
> systems?

Because it assume that for_each_cpufreq loop in not a problem mostly
because there will be no more than 3 CPUs and 2/3 PDs (ie Arm based
Android smartphone) and as a result, it's acceptable to loop
everything everytime

>
> > still hope to merge sched_asym_cpucapacity and asym_packing a some
> > levels because they looks  more and more similar but each side is
> > trying to add some SoC specific policy
>
> Oh, it seems Intel relies on asym_packing for their hybrid support approach?
> I think sched_asym_cpucapacity was designed to be generic. If I gathered
> correctly lack of support for SMT and inability to provide energy model outside
> of DT were some required extensions.

At least merging asym_packing and sched_asym_cpucapacity would be a
good starting point even if we don't consider using feec() in the 1st
step.

When we have things like below in the code in find_busiest_queue(), it
probably means that we have duplicated behavior :

if (env->sd->flags & SD_ASYM_CPUCAPACITY &&
    !capacity_greater(capacity_of(env->dst_cpu), capacity) &&
    nr_running == 1)
continue;

/* Make sure we only pull tasks from a CPU of lower priority */
if ((env->sd->flags & SD_ASYM_PACKING) &&
    sched_asym_prefer(i, env->dst_cpu) &&
    nr_running == 1)
continue;


They both try to find the cpu with highest capacity that will fit the
task requirement

>
> To be honest, I personally think EAS can be useful on SMP systems and it would
> be nice to enable it outside of sched_asym_cpucapacity.

or even before that task_fits_cpu should probably be useful for some smp case

>
> I'm interested to hear more about this unification idea actually. If you feel
> a bit chatty to describe in more detail how do you see this being unified, that
> could be enlightening for some of us who work in this area :-)

First, keep everything scalable and don't loop on all cpufreq policy
or anything else that can't scale so we don't have to take care of the
number of cpu of cpufreq policy in the system
Then, I think that a good starting point would be to merge the
behavior of SD_ASYM_CPUCAPACITY and SD_ASYM_PACKING instead of 2
parallel and similar behaviors
The misfit task could also be unified to integrate other things than
EAS like the IPC that ricardo is working one. I haven't look in
details how this could be doable


>
>
> Thanks!

>
> --
> Qais Yousef
