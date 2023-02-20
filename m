Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D288C69D1D0
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 18:02:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231502AbjBTRCV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 12:02:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232083AbjBTRCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 12:02:15 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 705D01D911
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 09:02:14 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id l15so3340966pls.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 09:02:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=w2PfPWdgOow5nJjUCj6hrrT5/2jwVDQfDZCwKnY/et4=;
        b=r+E3u1ezXgysYf+LQJtXHw5NOgQ/mlInewo6pX5TL6BfWhtRmL2l36feq76dV9BVSl
         5bScuHJAmKj+Wu1OstVPFeVoCwQ8Vf+BL8PRIB1gixDlQqVWYcHbJSNFlfyLv0hBzoHQ
         bJTUYWDt7uRnigLeqfywQ5NmRb/i7C8cNraI4NSCPBCyjc5E05MvQ74EMZ9MTtxOB0CG
         w8rA2kmX/6VJwzGbhvBeAPfELLepk7LxOznNMZ+v11vrGaaTIHArzix4fzrHxSwF6l5h
         rfYrnosQOZNPE6qzHUPheOKfZggqeg+PZuy/GJNr7VZd0BftsU/HfJ5Njpb9D0Ld8Jbe
         HNyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w2PfPWdgOow5nJjUCj6hrrT5/2jwVDQfDZCwKnY/et4=;
        b=mILUlbNOQCeGIThZapWSmfbjyEIVnTeAcfmZspbYOPJo4gXeBBnSRWEL80MaV6OUb2
         0OQSvaM/9QLtAD2fTsYgGlhecFXK8IhqmVtAAN4G/TuNl/LdCqw0NfZJhAiuzp9V1Ndj
         DYy34AFY7Mhxngr3SfcIddSXP6h7/tTi9lLBy+/VyIYG1hoWHNc2hJ4Czd/I8EohoIEq
         Rvw8Sz2wKo07N91sbQJu3SY6xvhwFi1qKp32H5eQ82JZqIzQkgFcT1Gc6ezIXA609oL5
         KwuIHflvssB9CY9n6FVdDjudaOA4MYDxJeLOaG6i/Dtjf1xgeFSdzdSVrsLN8XflAEWv
         b/vg==
X-Gm-Message-State: AO0yUKU8RSn534WI37XG7xWY0fT8tAIK+mUcvDgZBNOIw20Fd7HVJo6j
        oXxTaLMXIAl4KVwN6mMPgpmwjaGZc8zlB+BVJslI9w==
X-Google-Smtp-Source: AK7set+j8gvhz8HyRat7BzlpNAzEG9Y+0SqbsgVoy65qDZeYHi32R2+uuzQ2RPniuiy6EuGGE1ZYjXM/KwdAM10DtHw=
X-Received: by 2002:a17:90b:4a06:b0:233:4f0d:7 with SMTP id
 kk6-20020a17090b4a0600b002334f0d0007mr937980pjb.42.1676912533774; Mon, 20 Feb
 2023 09:02:13 -0800 (PST)
MIME-Version: 1.0
References: <20230205224318.2035646-1-qyousef@layalina.io> <20230205224318.2035646-2-qyousef@layalina.io>
 <CAKfTPtA9yOncmGuLfo-XaXDZ5F7+9iL-hdyGeaOQi1qrDa_RqQ@mail.gmail.com> <20230211172829.f2igueizqpwijjjz@airbuntu>
In-Reply-To: <20230211172829.f2igueizqpwijjjz@airbuntu>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 20 Feb 2023 18:02:02 +0100
Message-ID: <CAKfTPtCGjRR3k_m9OAra6XZP83dBxbiDPnGr7B52M_o=D=Oqng@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] sched/uclamp: Set max_spare_cap_cpu even if
 max_spare_cap is 0
To:     Qais Yousef <qyousef@layalina.io>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linux-kernel@vger.kernel.org, Lukasz Luba <lukasz.luba@arm.com>,
        Wei Wang <wvw@google.com>, Xuewen Yan <xuewen.yan94@gmail.com>,
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

On Sat, 11 Feb 2023 at 18:28, Qais Yousef <qyousef@layalina.io> wrote:
>
> On 02/07/23 10:45, Vincent Guittot wrote:
> > On Sun, 5 Feb 2023 at 23:43, Qais Yousef <qyousef@layalina.io> wrote:
> > >
> > > When uclamp_max is being used, the util of the task could be higher than
> > > the spare capacity of the CPU, but due to uclamp_max value we force fit
> > > it there.
> > >
> > > The way the condition for checking for max_spare_cap in
> > > find_energy_efficient_cpu() was constructed; it ignored any CPU that has
> > > its spare_cap less than or _equal_ to max_spare_cap. Since we initialize
> > > max_spare_cap to 0; this lead to never setting max_spare_cap_cpu and
> > > hence ending up never performing compute_energy() for this cluster and
> > > missing an opportunity for a better energy efficient placement to honour
> > > uclamp_max setting.
> > >
> > >         max_spare_cap = 0;
> > >         cpu_cap = capacity_of(cpu) - task_util(p);  // 0 if task_util(p) is high
> > >
> > >         ...
> > >
> > >         util_fits_cpu(...);             // will return true if uclamp_max forces it to fit
> > >
> > >         ...
> > >
> > >         // this logic will fail to update max_spare_cap_cpu if cpu_cap is 0
> > >         if (cpu_cap > max_spare_cap) {
> > >                 max_spare_cap = cpu_cap;
> > >                 max_spare_cap_cpu = cpu;
> > >         }
> > >
> > > prev_spare_cap suffers from a similar problem.
> > >
> > > Fix the logic by converting the variables into long and treating -1
> > > value as 'not populated' instead of 0 which is a viable and correct
> > > spare capacity value.
> > >
> > > Fixes: 1d42509e475c ("sched/fair: Make EAS wakeup placement consider uclamp restrictions")
> > > Signed-off-by: Qais Yousef (Google) <qyousef@layalina.io>
> > > ---
> > >  kernel/sched/fair.c | 9 ++++-----
> > >  1 file changed, 4 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > index c6c8e7f52935..7a21ee74139f 100644
> > > --- a/kernel/sched/fair.c
> > > +++ b/kernel/sched/fair.c
> > > @@ -7382,11 +7382,10 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
> > >         for (; pd; pd = pd->next) {
> > >                 unsigned long util_min = p_util_min, util_max = p_util_max;
> > >                 unsigned long cpu_cap, cpu_thermal_cap, util;
> > > -               unsigned long cur_delta, max_spare_cap = 0;
> > > +               long prev_spare_cap = -1, max_spare_cap = -1;
> > >                 unsigned long rq_util_min, rq_util_max;
> > > -               unsigned long prev_spare_cap = 0;
> > > +               unsigned long cur_delta, base_energy;
> > >                 int max_spare_cap_cpu = -1;
> > > -               unsigned long base_energy;
> > >                 int fits, max_fits = -1;
> > >
> > >                 cpumask_and(cpus, perf_domain_span(pd), cpu_online_mask);
> > > @@ -7461,7 +7460,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
> > >                         }
> > >                 }
> > >
> > > -               if (max_spare_cap_cpu < 0 && prev_spare_cap == 0)
> > > +               if (max_spare_cap_cpu < 0 && prev_spare_cap < 0)
> > >                         continue;
> > >
> > >                 eenv_pd_busy_time(&eenv, cpus, p);
> > > @@ -7469,7 +7468,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
> > >                 base_energy = compute_energy(&eenv, pd, cpus, p, -1);
> > >
> > >                 /* Evaluate the energy impact of using prev_cpu. */
> > > -               if (prev_spare_cap > 0) {
> > > +               if (prev_spare_cap > -1) {
> > >                         prev_delta = compute_energy(&eenv, pd, cpus, p,
> > >                                                     prev_cpu);
> > >                         /* CPU utilization has changed */
> >
> > I think that you also need the change below to make sure that the
> > signed comparison will be used. I have quickly checked the assembly
> > code for aarch64 and your patch keeps using unsigned comparison (b.ls)
> >    ((fits == max_fits) && (cpu_cap > max_spare_cap))) {
> > ffff8000080e4c94: f94067e0 ldr x0, [sp, #200]
> > ffff8000080e4c98: eb00003f cmp x1, x0
> > ffff8000080e4c9c: 54ff98a9 b.ls ffff8000080e3fb0
> > <select_task_rq_fair+0x570>  // b.plast
> >
> > Whereas the change below make it to use the signed version (b.le)
> >    ((fits == max_fits) && ((long)cpu_cap > max_spare_cap))) {
> > ffff8000080e4c94: f94067e0 ldr x0, [sp, #200]
> > ffff8000080e4c98: eb00003f cmp x1, x0
> > ffff8000080e4c9c: 54ff98ad b.le ffff8000080e3fb0 <select_task_rq_fair+0x570>
> >
> > -- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -7522,7 +7522,7 @@ static int find_energy_efficient_cpu(struct
> > task_struct *p, int prev_cpu)
> >                                 prev_spare_cap = cpu_cap;
> >                                 prev_fits = fits;
> >                         } else if ((fits > max_fits) ||
> > -                                  ((fits == max_fits) && (cpu_cap >
> > max_spare_cap))) {
> > +                                  ((fits == max_fits) &&
> > ((long)cpu_cap > max_spare_cap))) {
> >                                 /*
> >                                  * Find the CPU with the maximum spare capacity
> >                                  * among the remaining CPUs in the performance
>
> Isn't it better to go back to v1 form then? The inconsistent type paired with
> the cast isn't getting too ugly for me :(

the cast into a long of the cpu capacity in the condition was a good
way to fix this unsigned/signed comparison and make is consistent with
the use of -1 as default value IMO
    ((long)cpu_cap > max_spare_cap)
>
> I don't think we can convert cpu_cap to long without having to do more work as
> it is used with 'util'.
>
>
> Cheers
>
> --
> Qais Yousef
