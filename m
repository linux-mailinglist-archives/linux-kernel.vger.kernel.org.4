Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97BB168B191
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Feb 2023 21:24:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbjBEUYh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 15:24:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjBEUYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 15:24:35 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F4F6EFA3
        for <linux-kernel@vger.kernel.org>; Sun,  5 Feb 2023 12:24:33 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id bg13-20020a05600c3c8d00b003d9712b29d2so9455327wmb.2
        for <linux-kernel@vger.kernel.org>; Sun, 05 Feb 2023 12:24:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fPPGc52/qweAR4qOwMEm1FzbAp5khhYNOJIG5EkHPuU=;
        b=F9/ZRC1cZQCGE9QpvSoYxdHAZ+UNj8RsE1Y4y25ZKtlXo3iyeRqDoI/oaHn7Y7SKs7
         T1N8Pz4VqYajk4FBzbykEl5s1KvUe5R578IpbaCLmBQ81VD8lJyjnVund5SGc2N4jLsl
         uG+CGJE7aYaGla4jnM8TS2qlYeaMLeDmQH0x691PDMH1If+oqvn+P6g6FMeCfYyRUoPu
         oyI6iSQGdmCl4+zqOrX5Y0waD3JWEVQ+LcmjnsDtX5oIX6hkKsX9YFFpFT7bOJWR+giW
         ecfxFPmQhKQ7w2vpBeGCz7kyNMQTHEE8FqOOLDjqa0jgvy3E3oKwTRq8cenotcaBDVVr
         GrHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fPPGc52/qweAR4qOwMEm1FzbAp5khhYNOJIG5EkHPuU=;
        b=snfn+WjB8+6RG4Ty31X9ZkvbpvzHVysO8l8JwuZ4Q/PfJq0qaa9PdUDluoHLxnDxoG
         iKSTaNoCeVRSIYUu1PEuMumr0w7QBeECZIekDJTDLKPzKTiBcEQ1/W8ojIrXP35XaumP
         mtI1+tZCqCOIOGUipqGwBt3wEyU7MPlx0wdbgJ9FKswgmmCrVfFLKSn7cbAiOpD5t7pa
         Qc1N3Nye/xtnhwR8qbBKyr5M/63t+bkE1XlX9hoaSPu/gu4BPfZvNyaorpHkPDdMIpMF
         TXNlZYK37HJAA9mWiSW9lZh2zPdcLKBtIzU3AC19SWz8k0n/EEAUoheqkByXhfQzFlHS
         RaBA==
X-Gm-Message-State: AO0yUKV/C0W5du6RAYTblj7FY/jAWNo++KHjaTVZJGofLi8k50rKyM93
        CNAvoy0lQJ7KKp9YAslyEHUjYQ==
X-Google-Smtp-Source: AK7set9EGNPegv6eYvlujN072lJVFkT313sY3wujkiZmhV5bcg5ijXvjAWahaRv04peSUxZb7QIFlQ==
X-Received: by 2002:a05:600c:1e24:b0:3da:f665:5b66 with SMTP id ay36-20020a05600c1e2400b003daf6655b66mr21166952wmb.6.1675628671537;
        Sun, 05 Feb 2023 12:24:31 -0800 (PST)
Received: from airbuntu (host86-163-35-10.range86-163.btcentralplus.com. [86.163.35.10])
        by smtp.gmail.com with ESMTPSA id s22-20020a1cf216000000b003dffe312925sm2134609wmc.15.2023.02.05.12.24.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Feb 2023 12:24:30 -0800 (PST)
Date:   Sun, 5 Feb 2023 20:24:29 +0000
From:   Qais Yousef <qyousef@layalina.io>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     mingo@kernel.org, peterz@infradead.org, dietmar.eggemann@arm.com,
        rafael@kernel.org, viresh.kumar@linaro.org, vschneid@redhat.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kajetan.puchalski@arm.com, lukasz.luba@arm.com, wvw@google.com,
        xuewen.yan94@gmail.com, han.lin@mediatek.com,
        Jonathan.JMChen@mediatek.com
Subject: Re: [PATCH 2/2 v5] sched/fair: Remove capacity inversion detection
Message-ID: <20230205202429.dbwr5qz45qgp53gs@airbuntu>
References: <20230201143628.270912-1-vincent.guittot@linaro.org>
 <20230201143628.270912-3-vincent.guittot@linaro.org>
 <20230204184231.zx6oo52r5q2nvij7@airbuntu>
 <CAKfTPtAGRY8duSnvafntYJ20H1JGPeuhyLCvVRk0MEUsoTY_Tg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKfTPtAGRY8duSnvafntYJ20H1JGPeuhyLCvVRk0MEUsoTY_Tg@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/05/23 18:29, Vincent Guittot wrote:
> On Sat, 4 Feb 2023 at 19:42, Qais Yousef <qyousef@layalina.io> wrote:
> >
> > On 02/01/23 15:36, Vincent Guittot wrote:
> > > Remove the capacity inversion detection which is now handled by
> > > util_fits_cpu() returning -1 when we need to continue to look for a
> > > potential CPU with better performance.
> > >
> > > This ends up almost reverting patches below except for some comments:
> >
> > nit: I think this comment must be removed/reworeded though
> 
> This comment has already been removed. That's why I said almost revert
> except for some comments in the commit message

Oh, my diff cmd had the wrong order then, sorry.

> 
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 691a2f9c4efa..c6c8e7f52935 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -4476,10 +4476,6 @@ static inline int util_fits_cpu(unsigned long util,
> >          *
> >          * For uclamp_max, we can tolerate a drop in performance level as the
> >          * goal is to cap the task. So it's okay if it's getting less.
> > -        *
> > -        * In case of capacity inversion, which is not handled yet, we should
> > -        * honour the inverted capacity for both uclamp_min and uclamp_max all
> > -        * the time.
> >          */
> >         capacity_orig = capacity_orig_of(cpu);
> >         capacity_orig_thermal = capacity_orig - arch_scale_thermal_pressure(cpu);
> >
> > > commit da07d2f9c153 ("sched/fair: Fixes for capacity inversion detection")
> > > commit aa69c36f31aa ("sched/fair: Consider capacity inversion in util_fits_cpu()")
> > > commit 44c7b80bffc3 ("sched/fair: Detect capacity inversion")
> > >
> > > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> >
> > Apart from that, LGTM.
> >
> > Reviewed-by: Qais Yousef <qyousef@layalina.io>
> 
> Thanks
> 
> >
> >
> > Thanks!
> >
> > --
> > Qais Yousef
> >
> > > ---
> > >  kernel/sched/fair.c  | 84 +++-----------------------------------------
> > >  kernel/sched/sched.h | 19 ----------
> > >  2 files changed, 5 insertions(+), 98 deletions(-)
> > >
> > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > index 074742f107c0..c6c8e7f52935 100644
> > > --- a/kernel/sched/fair.c
> > > +++ b/kernel/sched/fair.c
> > > @@ -4476,17 +4476,9 @@ static inline int util_fits_cpu(unsigned long util,
> > >        *
> > >        * For uclamp_max, we can tolerate a drop in performance level as the
> > >        * goal is to cap the task. So it's okay if it's getting less.
> > > -      *
> > > -      * In case of capacity inversion we should honour the inverted capacity
> > > -      * for both uclamp_min and uclamp_max all the time.
> > >        */
> > > -     capacity_orig = cpu_in_capacity_inversion(cpu);
> > > -     if (capacity_orig) {
> > > -             capacity_orig_thermal = capacity_orig;
> > > -     } else {
> > > -             capacity_orig = capacity_orig_of(cpu);
> > > -             capacity_orig_thermal = capacity_orig - arch_scale_thermal_pressure(cpu);
> > > -     }
> > > +     capacity_orig = capacity_orig_of(cpu);
> > > +     capacity_orig_thermal = capacity_orig - arch_scale_thermal_pressure(cpu);
> > >
> > >       /*
> > >        * We want to force a task to fit a cpu as implied by uclamp_max.
> > > @@ -9027,82 +9019,16 @@ static unsigned long scale_rt_capacity(int cpu)
> > >
> > >  static void update_cpu_capacity(struct sched_domain *sd, int cpu)
> > >  {
> > > -     unsigned long capacity_orig = arch_scale_cpu_capacity(cpu);
> > >       unsigned long capacity = scale_rt_capacity(cpu);
> > >       struct sched_group *sdg = sd->groups;
> > > -     struct rq *rq = cpu_rq(cpu);
> > >
> > > -     rq->cpu_capacity_orig = capacity_orig;
> > > +     cpu_rq(cpu)->cpu_capacity_orig = arch_scale_cpu_capacity(cpu);
> > >
> > >       if (!capacity)
> > >               capacity = 1;
> > >
> > > -     rq->cpu_capacity = capacity;
> > > -
> > > -     /*
> > > -      * Detect if the performance domain is in capacity inversion state.
> > > -      *
> > > -      * Capacity inversion happens when another perf domain with equal or
> > > -      * lower capacity_orig_of() ends up having higher capacity than this
> > > -      * domain after subtracting thermal pressure.
> > > -      *
> > > -      * We only take into account thermal pressure in this detection as it's
> > > -      * the only metric that actually results in *real* reduction of
> > > -      * capacity due to performance points (OPPs) being dropped/become
> > > -      * unreachable due to thermal throttling.
> > > -      *
> > > -      * We assume:
> > > -      *   * That all cpus in a perf domain have the same capacity_orig
> > > -      *     (same uArch).
> > > -      *   * Thermal pressure will impact all cpus in this perf domain
> > > -      *     equally.
> > > -      */
> > > -     if (sched_energy_enabled()) {
> > > -             unsigned long inv_cap = capacity_orig - thermal_load_avg(rq);
> > > -             struct perf_domain *pd;
> > > -
> > > -             rcu_read_lock();
> > > -
> > > -             pd = rcu_dereference(rq->rd->pd);
> > > -             rq->cpu_capacity_inverted = 0;
> > > -
> > > -             for (; pd; pd = pd->next) {
> > > -                     struct cpumask *pd_span = perf_domain_span(pd);
> > > -                     unsigned long pd_cap_orig, pd_cap;
> > > -
> > > -                     /* We can't be inverted against our own pd */
> > > -                     if (cpumask_test_cpu(cpu_of(rq), pd_span))
> > > -                             continue;
> > > -
> > > -                     cpu = cpumask_any(pd_span);
> > > -                     pd_cap_orig = arch_scale_cpu_capacity(cpu);
> > > -
> > > -                     if (capacity_orig < pd_cap_orig)
> > > -                             continue;
> > > -
> > > -                     /*
> > > -                      * handle the case of multiple perf domains have the
> > > -                      * same capacity_orig but one of them is under higher
> > > -                      * thermal pressure. We record it as capacity
> > > -                      * inversion.
> > > -                      */
> > > -                     if (capacity_orig == pd_cap_orig) {
> > > -                             pd_cap = pd_cap_orig - thermal_load_avg(cpu_rq(cpu));
> > > -
> > > -                             if (pd_cap > inv_cap) {
> > > -                                     rq->cpu_capacity_inverted = inv_cap;
> > > -                                     break;
> > > -                             }
> > > -                     } else if (pd_cap_orig > inv_cap) {
> > > -                             rq->cpu_capacity_inverted = inv_cap;
> > > -                             break;
> > > -                     }
> > > -             }
> > > -
> > > -             rcu_read_unlock();
> > > -     }
> > > -
> > > -     trace_sched_cpu_capacity_tp(rq);
> > > +     cpu_rq(cpu)->cpu_capacity = capacity;
> > > +     trace_sched_cpu_capacity_tp(cpu_rq(cpu));
> > >
> > >       sdg->sgc->capacity = capacity;
> > >       sdg->sgc->min_capacity = capacity;
> > > diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> > > index 1072502976df..3e8df6d31c1e 100644
> > > --- a/kernel/sched/sched.h
> > > +++ b/kernel/sched/sched.h
> > > @@ -1044,7 +1044,6 @@ struct rq {
> > >
> > >       unsigned long           cpu_capacity;
> > >       unsigned long           cpu_capacity_orig;
> > > -     unsigned long           cpu_capacity_inverted;
> > >
> > >       struct balance_callback *balance_callback;
> > >
> > > @@ -2899,24 +2898,6 @@ static inline unsigned long capacity_orig_of(int cpu)
> > >       return cpu_rq(cpu)->cpu_capacity_orig;
> > >  }
> > >
> > > -/*
> > > - * Returns inverted capacity if the CPU is in capacity inversion state.
> > > - * 0 otherwise.
> > > - *
> > > - * Capacity inversion detection only considers thermal impact where actual
> > > - * performance points (OPPs) gets dropped.
> > > - *
> > > - * Capacity inversion state happens when another performance domain that has
> > > - * equal or lower capacity_orig_of() becomes effectively larger than the perf
> > > - * domain this CPU belongs to due to thermal pressure throttling it hard.
> > > - *
> > > - * See comment in update_cpu_capacity().
> > > - */
> > > -static inline unsigned long cpu_in_capacity_inversion(int cpu)
> > > -{
> > > -     return cpu_rq(cpu)->cpu_capacity_inverted;
> > > -}
> > > -
> > >  /**
> > >   * enum cpu_util_type - CPU utilization type
> > >   * @FREQUENCY_UTIL:  Utilization used to select frequency
> > > --
> > > 2.34.1
> > >
