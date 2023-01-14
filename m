Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8465566AD43
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 19:21:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbjANSVP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Jan 2023 13:21:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbjANSVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jan 2023 13:21:11 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DCB17EF3
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jan 2023 10:21:09 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id ay12-20020a05600c1e0c00b003d9ea12bafcso15442526wmb.3
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jan 2023 10:21:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JbYS1PC8JzhDRB4EPNw4J+rgsfQV281zmahxoSJ2CAw=;
        b=fbaB2R+4RroQNVP2o2YEQ6xm/aQ0SxAeMTTf+t1IQDZRul8EUvjD1rWvaeIwcjmyrn
         Z5uC1B1+XKpv2Mqz49XNaa9Pu1ppSKjXUJaVYMJplk2ci4j1/9D8Lm6dp96gpxP5kFtm
         UocxQQ8xotsRLg3y9FOS0LQEcU9okzuwyHV34OlMSZCbkrmQjWhzFsABnxxcRrtSWkQW
         kjabQzGZRyMQDkzttwJwpCd2hZccbjNCaafBQsa93ssN9Ug352ywwiXr13vPYepiRAIa
         QFASVKlnDkM5F1pSzWwfqNw2OuTQONJVn159+YowchAuCJ60Norstsol2k2r/8O4gCTG
         2ZLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JbYS1PC8JzhDRB4EPNw4J+rgsfQV281zmahxoSJ2CAw=;
        b=5hO3b+rPntw89MGGcz5U87KOdubDKmjA5zA3nWHvCdLXukkEBBaBdvtW0arfSCjMD1
         mzb8v4dB78TqYoX89TJwIHsdotmBN66gyO1o98s1QC3XrtYyuxtR/DG0nJqVtMjdLqOl
         1+1s1OUVD/tz8nNA+EXtDCBLpITxwowp4XSdlEnRJbh1jUwQkA4gh60dkSWym5LsOt43
         YGSNOk4hwtRr/lokVDaMvetc4gnPHyDW5vdLtY0DMrucJqXQcUtqAUUIf5Ewiu+rGulg
         Q/mcGMru6uZl236FSR4ZDi31qpddJOwv+lOXj/TA6UYHkiN/ORcTFQ06JvBJX+thXUC8
         lhFg==
X-Gm-Message-State: AFqh2kpUhoirqmWmCcc+Tl5wDTY8litFRBWcrW+GBQ6iCtQ8UJL1EaDe
        xxOakMLZD9HaMO+uYv8h12p4Nw==
X-Google-Smtp-Source: AMrXdXsJCKUE9UX8YHR/iWVC9ZsDthI0ZlR02ziH5qUwiVRG1Dzd1bve8koVMAHiPcBkHSZRP2DY0w==
X-Received: by 2002:a05:600c:19c7:b0:3d9:7096:262a with SMTP id u7-20020a05600c19c700b003d97096262amr56129779wmq.27.1673720467246;
        Sat, 14 Jan 2023 10:21:07 -0800 (PST)
Received: from airbuntu (host86-130-134-87.range86-130.btcentralplus.com. [86.130.134.87])
        by smtp.gmail.com with ESMTPSA id k30-20020a05600c1c9e00b003d9b89a39b2sm31905436wms.10.2023.01.14.10.21.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Jan 2023 10:21:06 -0800 (PST)
Date:   Sat, 14 Jan 2023 18:21:04 +0000
From:   Qais Yousef <qyousef@layalina.io>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     mingo@kernel.org, peterz@infradead.org, dietmar.eggemann@arm.com,
        rafael@kernel.org, viresh.kumar@linaro.org, vschneid@redhat.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        lukasz.luba@arm.com, wvw@google.com, xuewen.yan94@gmail.com,
        han.lin@mediatek.com, Jonathan.JMChen@mediatek.com
Subject: Re: [PATCH v2] sched/fair: unlink misfit task from cpu overutilized
Message-ID: <20230114182104.gyb7osljrvwpbn42@airbuntu>
References: <20221228165415.3436-1-vincent.guittot@linaro.org>
 <20230112142603.yj5dtleksi6sfrzp@airbuntu>
 <CAKfTPtCPedS22+0QHS65ixMELAvjRnn6XMCu0DzickEcpjkMFQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKfTPtCPedS22+0QHS65ixMELAvjRnn6XMCu0DzickEcpjkMFQ@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/13/23 09:53, Vincent Guittot wrote:
> On Thu, 12 Jan 2023 at 15:26, Qais Yousef <qyousef@layalina.io> wrote:
> >
> > Hi Vincent
> >
> > On 12/28/22 17:54, Vincent Guittot wrote:
> > > By taking into account uclamp_min, the 1:1 relation between task misfit
> > > and cpu overutilized is no more true as a task with a small util_avg of
> > > may not may not fit a high capacity cpu because of uclamp_min constraint.
> >
> > Wouldn't it be better to split this into two patches
> >
> >         * Unlink/Decouple misfit ...
> >         * Unlink/Decouple util_fits_cpu from HMP
> >
> > ?
> 
> I'm afraid that git bisect could then raise a false positive between
> the 2 commits

They should be independent, no? Anyway, I don't feel that strongly about it but
as a minor nit the commit subject could be better.

> 
> >
> > >
> > > Add a new state in util_fits_cpu() to reflect the case that task would fit
> > > a CPU except for the uclamp_min hint which is a performance requirement.
> > >
> > > Use -1 to reflect that a CPU doesn't fit only because of uclamp_min so we
> > > can use this new value to take additional action to select the best CPU
> > > that doesn't match uclamp_min hint.
> >
> > This part has nothing to do with the commit subject. I think it's better to
> > split the patches if it's not too much work for you.
> >
> > >
> > > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > > ---
> > >
> > > Change since v1:
> > > - fix some wrong conditions
> > > - take into account more cases
> > >
> > >  kernel/sched/fair.c | 99 +++++++++++++++++++++++++++++++++------------
> > >  1 file changed, 74 insertions(+), 25 deletions(-)
> > >
> > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > index 1649e7d71d24..57077f0a897e 100644
> > > --- a/kernel/sched/fair.c
> > > +++ b/kernel/sched/fair.c
> > > @@ -4582,8 +4582,7 @@ static inline int util_fits_cpu(unsigned long util,
> > >        *     2. The system is being saturated when we're operating near
> > >        *        max capacity, it doesn't make sense to block overutilized.
> > >        */
> > > -     uclamp_max_fits = (capacity_orig == SCHED_CAPACITY_SCALE) && (uclamp_max == SCHED_CAPACITY_SCALE);
> > > -     uclamp_max_fits = !uclamp_max_fits && (uclamp_max <= capacity_orig);
> > > +     uclamp_max_fits = (uclamp_max <= capacity_orig) || (capacity_orig == SCHED_CAPACITY_SCALE);
> > >       fits = fits || uclamp_max_fits;
> > >
> > >       /*
> > > @@ -4618,8 +4617,8 @@ static inline int util_fits_cpu(unsigned long util,
> > >        * handle the case uclamp_min > uclamp_max.
> > >        */
> > >       uclamp_min = min(uclamp_min, uclamp_max);
> > > -     if (util < uclamp_min && capacity_orig != SCHED_CAPACITY_SCALE)
> > > -             fits = fits && (uclamp_min <= capacity_orig_thermal);
> > > +     if (fits && (util < uclamp_min) && (uclamp_min > capacity_orig_thermal))
> > > +             return -1;
> > >
> > >       return fits;
> > >  }
> > > @@ -4629,7 +4628,7 @@ static inline int task_fits_cpu(struct task_struct *p, int cpu)
> > >       unsigned long uclamp_min = uclamp_eff_value(p, UCLAMP_MIN);
> > >       unsigned long uclamp_max = uclamp_eff_value(p, UCLAMP_MAX);
> > >       unsigned long util = task_util_est(p);
> > > -     return util_fits_cpu(util, uclamp_min, uclamp_max, cpu);
> > > +     return (util_fits_cpu(util, uclamp_min, uclamp_max, cpu) > 0);
> >
> > So the big difference between your approach and my approach is that
> > task_fits_cpu() and asym_fits_cpu() now are very strict in regards to thermal
> > pressure since with your approach we delegate the smartness to the caller.
> >
> > Should we add a comment for these 2 users to make it obvious we intentionally
> > ignore the '-1' value and why it is okay?
> 
> I can probably add something saying that a positive value (1 in this
> case) is the only one that says that a task fits to a cpu. Other
> returned values imply that either the utilization or the uclamp
> constraints are not meet

Sounds good to me. So at least whoever looks at this later and doesn't know
the history will at least try to dig more before using it as-is and assume
wonders.

> >
> > I'm not sure I can write a reasonable rationale myself. I'm actually worried
> > this might subtly break decisions made by select_idle_capacity() or feec() when
> > doing the LB.
> >
> > Have you considered this?
> 
> Yes, that why i have keep the changes in 1 patch

Okay I think I see what you're on about now.

[...]

> > > +                     /*
> > > +                      * Both fit for the task but best energy cpu has lower
> > > +                      * energy impact.
> > > +                      */
> > > +                     if ((max_fits > 0) &&
> >
> > Shouldn't this be
> >
> >                         if ((max_fits > 0) && (max_fits == best_fits) &&
> > ?
> 
> I will use the below which match better the comment and the fact that
> both fit for the task:
> 
> +                    if ((max_fits > 0) && (best_fits > 0) &&
> 

Fine by me.

> >
> > We should update best_delta unconditionally first time we hit max_fits = 1, no?
> >
> > I think it's worth extending the comment with something along the lines of
> >
> >                         * ... except for the first time max_fits becomes 1
> >                         * then we must update best_delta unconditionally
> 
> With the new condition above this is not needed anymore

+1

> 
> >
> > > +                         (cur_delta >= best_delta))
> > > +                             continue;
> > > +
> > > +                     best_delta = cur_delta;
> > > +                     best_energy_cpu = max_spare_cap_cpu;
> > > +                     best_fits = max_fits;
> > > +                     best_thermal_cap = cpu_thermal_cap;
> > >               }
> > >       }
> > >       rcu_read_unlock();
> > >
> > > -     if (best_delta < prev_delta)
> > > +     if ((best_fits > prev_fits) ||
> > > +         ((best_fits > 0) && (best_delta < prev_delta)) ||
> > > +         ((best_fits < 0) && (best_thermal_cap > prev_thermal_cap)))
> > >               target = best_energy_cpu;
> >
> > Overall I think the approach is sound. I tested it on my pinebook pro and
> > couldn't catch obvious breakage at least.
> >
> > I am still worried though about spilling the knowledge outside of
> > util_fits_cpu() is creating extra complexity in the callers and potentially
> > more fragility when these callers evolve overtime e.g:
> > task_fits_cpu()/asym_fits_cpu() gain a new user that must actually care about
> > the -1 return value.
> 
> ask_fits_cpu()/asym_fits_cpu() remain simple booleans that return true
> if the task fits the cpu in regards to all requirements. If a new user
> wants to make smarter decisions like select_idle_capacity() or feec(),
> it will have to use util_fits_cpu(). Both handle the case where
> uclamp_min is not met differently.

I think with that comment added we can hope this will promote new users to
think more.

> 
> >
> > I think we can still optimize the capacity inversion logic to use no loops
> > without having to spill the knowledge to the users/callers of util_fits_cpu(),
> > no?
> 
> TBH, I don't know how because we are not always comparing the same
> things depending of the reason it doesn't fit

Your patch will do a more comprehensive search, true. It will try harder to
find a best fit. I do have a bit of a bias that some severe thermal conditions
are indication of a bigger problem to try harder to honour uclamp_min (warrant
the additional complexity). But I thought more about it and I think it actually
might be worth while. Xuewen had a system where medium's capacity was 900 and
bigs could easily be inverted with some thermal pressure on mediums too. So
this harder search can help these systems to keep these tasks on mediums. e.g:
if uclamp_min was 900 and big is inverted and medium is under pressure my
approach would have returned false for all CPUs then; while yours will keep it
on medium cpus.

> 
> >
> > That said except for the few comments I had this LGTM anyway. Thanks for your
> > effort!
> 
> Thanks
> 
> I'm going to prepare  v2

Thanks!


--
Qais Yousef
