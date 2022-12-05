Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CEB1642719
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 12:02:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231164AbiLELCI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 06:02:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230353AbiLELCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 06:02:05 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE700F034
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 03:02:03 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id y16so18006595wrm.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 03:02:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=50n9+I4ZxZRBd4Gzgxnr+F5t6glYKeTWrpBn2vhsZRE=;
        b=k6LIQd5Iev9CRSssx9gOdJxTMz6B/GodnspKI9plJT4mnElcDfYL/C6O2GzZSQG4uJ
         kZV8xkD0fGRN5PWuAqtrKW+FOq7Va24G6hgmtAmtVa9bzmEhHe2UqfjagkG7EC8jyNbN
         GPC+MaUgIo8FSovEfpkMbBit5cKQjAzi7v8EvH7Zk+5SG9xuMujJCzjSL3+vP6PDs+7x
         QC0DV55+7C6Nx5Fr7dFDrhGvgQw/4Xeqi6+MCNYCrGy1GrO9s5H6GRmHY6SiZmWd8jZ5
         +Ge5s0T1GJTM4K4+uC29OEvM09ycL7f9KdrUq0Kak+zWvtd4oI0edjm+6k5Ym9e3GyQH
         xrdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=50n9+I4ZxZRBd4Gzgxnr+F5t6glYKeTWrpBn2vhsZRE=;
        b=OmtkJCrPFmf8bUoPZKAaZj6KkFqrg3AwgCaIjHqnNZIt2qBCkAtfW4t04h9Uvt3r48
         QsmTVERAWjUescEAR2Ewyt9tcVwgYy4GfSEAR9qkVMm+kUcyiwgxoqrJsxDngRUYZ8qK
         IgWkmtBVNVrGvownIna2oZwt/oBNesJ+FxOqNPXRSiRDrSekZVw2w3nqMAmIX7sha9Qq
         UicNTbhLULcW+YSN2nEyo0xWvyEQjYYztaGI52Nr7k9+FFkGmly+fDktvZrsTFiaOYWx
         eGa1qa8bCskhKhzANV4OWmzAktP+nhCV8Py0MZjdGgGSR8jyhVe8tSCkFWq0KJvR9lpg
         kFSw==
X-Gm-Message-State: ANoB5plXC/6HL4bkhIGzQhhKRBPjTEN8PfnJAGkIRrdztXQ7Bpl9cuwp
        3BvTZYKgYup1B0bPbqgSn+I6vw==
X-Google-Smtp-Source: AA0mqf6GC/DR99Gk2V2xSkqMAURWxlcI35iVbq9UMoouyXgZDMFQIevH6e6v28xtjFDFcu4GhmK56Q==
X-Received: by 2002:adf:e305:0:b0:236:6089:cc5e with SMTP id b5-20020adfe305000000b002366089cc5emr40746437wrj.118.1670238122223;
        Mon, 05 Dec 2022 03:02:02 -0800 (PST)
Received: from airbuntu (host86-130-134-87.range86-130.btcentralplus.com. [86.130.134.87])
        by smtp.gmail.com with ESMTPSA id j11-20020a05600c190b00b003b47e75b401sm23742162wmq.37.2022.12.05.03.02.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 03:02:01 -0800 (PST)
Date:   Mon, 5 Dec 2022 11:01:59 +0000
From:   Qais Yousef <qyousef@layalina.io>
To:     Vincent Guittot <vincent.guittot@linaro.org>
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
Subject: Re: [RFC PATCH 3/3] sched/fair: Traverse cpufreq policies to detect
 capacity inversion
Message-ID: <20221205110159.nd5igwvsaj55jar7@airbuntu>
References: <20221127141742.1644023-1-qyousef@layalina.io>
 <20221127141742.1644023-4-qyousef@layalina.io>
 <CAKfTPtCawKvhMwJYVUskYcX7eR2K7SziWVzvjGh6JCVB+WT5tQ@mail.gmail.com>
 <20221203143323.w32boxa6asqvvdnp@airbuntu>
 <CAKfTPtCZYGEvDBe5X1v7TiNZag0atUozGKip6EAgvZDWyo8e-g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKfTPtCZYGEvDBe5X1v7TiNZag0atUozGKip6EAgvZDWyo8e-g@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/04/22 12:35, Vincent Guittot wrote:
> On Sat, 3 Dec 2022 at 15:33, Qais Yousef <qyousef@layalina.io> wrote:
> >
> > On 12/02/22 15:57, Vincent Guittot wrote:
> >
> > > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > > index 7c0dd57e562a..4bbbca85134b 100644
> > > > --- a/kernel/sched/fair.c
> > > > +++ b/kernel/sched/fair.c
> > > > @@ -8856,23 +8856,20 @@ static void update_cpu_capacity(struct sched_domain *sd, int cpu)
> > > >          *   * Thermal pressure will impact all cpus in this perf domain
> > > >          *     equally.
> > > >          */
> > > > -       if (sched_energy_enabled()) {
> > > > +       if (static_branch_unlikely(&sched_asym_cpucapacity)) {
> > > >                 unsigned long inv_cap = capacity_orig - thermal_load_avg(rq);
> > > > -               struct perf_domain *pd = rcu_dereference(rq->rd->pd);
> > > > +               struct cpufreq_policy *policy, __maybe_unused *policy_n;
> > > >
> > > >                 rq->cpu_capacity_inverted = 0;
> > > >
> > > > -               SCHED_WARN_ON(!rcu_read_lock_held());
> > > > -
> > > > -               for (; pd; pd = pd->next) {
> > > > -                       struct cpumask *pd_span = perf_domain_span(pd);
> > > > +               for_each_active_policy_safe(policy, policy_n) {
> > >
> > > So you are looping all cpufreq policy (and before the perf domain) in
> > > the period load balance. That' really not something we should or want
> > > to do
> >
> > Why is it not acceptable in the period load balance but acceptable in the hot
> > wake up path in feec()? What's the difference?
> 
> This patch loops on all cpufreq policy in sched softirq, how can this
> be sane ? and not only in eas mode but also in the default asymmetric

Hmm I'm still puzzled. Why it's not sane to do it here but it's okay to do it
in the wake up path in feec()?

AFAICT the number of cpufreq policies and perf domains have 1:1 mapping. In
feec() we not only loop perf domains, but we go through each cpu of each domain
to find max_spare_cap then compute_energy(). Which is more intensive.

In worst case scenario where there's a perf domain for each cpu, then we'll
loop through every CPU *and* compute energy its energy cost in the wake up
path.

Why it's deemed acceptable in wake up path which is more critical AFAIU but not
period load balance which is expected to do more work? What am I missing?

> performance  one.
> 
> This inverted detection doesn't look like the right way to fix your
> problem IMO. That being said, i agree that I haven't made any other
> proposal apart that I think that you should use a different rules for
> task and for overutilized and part of your problem comes from this.

We discussed this before; I need to revisit the thread but I can't see how
overutilized different than task will fix the issue. They should be unified by
design.

I'm all ears if there's a simpler way to address the problem :-)

The problem is that thermal pressure on big cpu is not important from
uclamp perspective until it is in inversion state. It is quite common to have
a system where the medium capacity is in 500 range. If the big is under thermal
pressure that it drops to 800, then it is still a fitting CPU from uclamp
perspective. Keep in mind uclamp_min is useful for tasks whose utilization is
small So we need to be selective when thermal pressure is actually helping out
or just creating unnecessary problems.

The only other option I had in mind was to do the detection when we update the
thermal_pressure in the topology code. But that didn't look better alternative
to me.

> 
> Then this make eas and util_fits_cpu even more Arm specific and I

What is the Arm specific part about it? Why it wouldn't work on non-Arm
systems?

> still hope to merge sched_asym_cpucapacity and asym_packing a some
> levels because they looks  more and more similar but each side is
> trying to add some SoC specific policy

Oh, it seems Intel relies on asym_packing for their hybrid support approach?
I think sched_asym_cpucapacity was designed to be generic. If I gathered
correctly lack of support for SMT and inability to provide energy model outside
of DT were some required extensions.

To be honest, I personally think EAS can be useful on SMP systems and it would
be nice to enable it outside of sched_asym_cpucapacity.

I'm interested to hear more about this unification idea actually. If you feel
a bit chatty to describe in more detail how do you see this being unified, that
could be enlightening for some of us who work in this area :-)


Thanks!

--
Qais Yousef
