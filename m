Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2B5C6723FA
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 17:48:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbjARQs1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 11:48:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjARQsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 11:48:25 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3045E303FB
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 08:48:24 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id v13so16343438eda.11
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 08:48:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5eigK6NhPZ1BzYqG/rSKwU17B7Pa951B39IAGV/KhXA=;
        b=HizGboq0OC8XKjblNCtaASyrgCAdADxGBXfBRPO0jB68wVvbLXM4u0qhGOWDDTpuvR
         vWCLZtvyaQuS/2Tvgp8bOpAfEckgpLrxcy5zLW0IgBJnZ/2FBnHftxND5Orp/JQO2+QN
         w0lV1rBbetb161VYgvAGjqfouX4oSB/Mze3U7GkG5LwSwZvNRm6LaogH7pTGimcdqgdS
         rekFnb9L2Xqd3vw4vLdKMB9fFMwTcafX4NR/HTDErB122lvv40HlRUY72iycyj7FNkYF
         10neXwmBGMjE+j8Zi9yw0lYAUimir2PwovgeaQOFOAI62f7SFiQbsdQvsv1hq1HynPJe
         g95Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5eigK6NhPZ1BzYqG/rSKwU17B7Pa951B39IAGV/KhXA=;
        b=KF10i6st1O1XHEDEMEXnqEGEwyfrils71GXDauRU9qj6snx/J7XNX51WabW2O05ssH
         QABJ5wtNynPfXWkUKRkcUm0eTvQ4S0vE7sabEGmzW5CFvNRJgcrHjomyZafn0dtXe8+m
         XCd4yUOFq/5QZZkkQRyzyY/9hEHQ+SJBsSSChXj2KuZljKCYCw5KC17fZuUtCGH64Hbl
         rjczt4I6i5LZqc3qBUYFSGnw7On49zLBpSfCzjFhwQ+NjCtJmqyP2qw78gX6GXiHBIyn
         fyG/ZRQlWZyYUWIa3qDUdDI+afezYun4a5kWNUathH0xtl6QlP8ug8JesEg9wurMMetJ
         goLQ==
X-Gm-Message-State: AFqh2kr5gH86e8f7dyYprwf6ae1MuSLEvXZ9/a9pscRO7vhRf3J9t48N
        U6GhBQqI2KYLKXrdtT9HietQrA==
X-Google-Smtp-Source: AMrXdXstpqo7orPGoSroBhoJGiliGWm2gYQm8T8Kt7XTBTrW3BxHgSVYkNk8R0Vxu7qfafQKn9xGwA==
X-Received: by 2002:a05:6402:2989:b0:461:1998:217f with SMTP id eq9-20020a056402298900b004611998217fmr7661275edb.4.1674060502714;
        Wed, 18 Jan 2023 08:48:22 -0800 (PST)
Received: from airbuntu (host86-130-134-87.range86-130.btcentralplus.com. [86.130.134.87])
        by smtp.gmail.com with ESMTPSA id k22-20020a1709063fd600b00862497eafb2sm8867294ejj.103.2023.01.18.08.48.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 08:48:22 -0800 (PST)
Date:   Wed, 18 Jan 2023 16:48:20 +0000
From:   Qais Yousef <qyousef@layalina.io>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>, mingo@kernel.org,
        peterz@infradead.org, rafael@kernel.org, viresh.kumar@linaro.org,
        vschneid@redhat.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, lukasz.luba@arm.com, wvw@google.com,
        xuewen.yan94@gmail.com, han.lin@mediatek.com,
        Jonathan.JMChen@mediatek.com
Subject: Re: [PATCH v3] sched/fair: unlink misfit task from cpu overutilized
Message-ID: <20230118164820.r37yfigmwwdske4r@airbuntu>
References: <20230113134056.257691-1-vincent.guittot@linaro.org>
 <78bf2d91-0076-f748-7c6a-530dad466787@arm.com>
 <CAKfTPtCAAOvFak2FqkKv2AwnoBZ3cwbMwfnAAGqDx+Wq4Ng+zw@mail.gmail.com>
 <7a6182dd-89f5-69c5-4331-2f102dc0418d@arm.com>
 <CAKfTPtCfbVgwPGYgw4vuO3UgEFM9GbMzyrzkgCoeL7onZXQXBg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKfTPtCfbVgwPGYgw4vuO3UgEFM9GbMzyrzkgCoeL7onZXQXBg@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/18/23 09:15, Vincent Guittot wrote:
> On Mon, 16 Jan 2023 at 15:56, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
> >
> > On 16/01/2023 12:23, Vincent Guittot wrote:
> > > On Mon, 16 Jan 2023 at 10:07, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
> > >>
> > >> On 13/01/2023 14:40, Vincent Guittot wrote:
> >
> > [...]
> >
> > >>> @@ -6132,6 +6135,7 @@ static inline bool cpu_overutilized(int cpu)
> > >>>       unsigned long rq_util_min = uclamp_rq_get(cpu_rq(cpu), UCLAMP_MIN);
> > >>>       unsigned long rq_util_max = uclamp_rq_get(cpu_rq(cpu), UCLAMP_MAX);
> > >>>
> > >>> +     /* Return true only if the utlization doesn't fit its capacity */
> > >>
> > >> s/utlization/utilization
> > >> s/its/CPU ?
> > >>
> > >>>       return !util_fits_cpu(cpu_util_cfs(cpu), rq_util_min, rq_util_max, cpu);
> > >>>  }
> > >>
> > >> cpu_overutilized() is the only place where we now only test for
> > >> !util_fits_cpu(). The new comment says we only care about utilization
> > >> not fitting CPU capacity.
> > >>
> > >> Does this mean the rq uclamp values are not important here and we could
> > >> go back to use fits_capacity()?
> > >>
> > >> Not sure since util_fits_cpu() is still coded differently:
> > >
> > > uclamp_min is not important but uclamp_max still cap the utilization
> >
> > OK, makes sense.
> >
> > I.e. we could pass in `rq_util_min = 0` to avoid fetching it
> > unnecessary? In case `fits == 1` before the uclamp_min condition in
> > util_fits_cpu() it doesn't matter if we switch to return `-1` when
> > called from cpu_overutilized(). Detail though ...
> 
> One comment from Qais was to minimize knowledge outside
> util_fits_cpu() that's why I pass both uclamp_min and uclamp_max.
> 
> >
> > [...]
> >
> > >>> @@ -6940,12 +6945,28 @@ select_idle_capacity(struct task_struct *p, struct sched_domain *sd, int target)
> > >>>
> > >>>               if (!available_idle_cpu(cpu) && !sched_idle_cpu(cpu))
> > >>>                       continue;
> > >>> -             if (util_fits_cpu(task_util, util_min, util_max, cpu))
> > >>> +
> > >>> +             fits = util_fits_cpu(task_util, util_min, util_max, cpu);
> > >>> +
> > >>> +             /* This CPU fits with all capacity and performance requirements */
> > >>
> > >> In task_fits_cpu() `utilization and performance (better uclamp)
> > >> requirements` term was used. I assume it's the same thing here?
> > >>
> > >>> +             if (fits > 0)
> > >>>                       return cpu;
> > >>> +             /*
> > >>> +              * Only the min performance (i.e. uclamp_min) doesn't fit. Look
> > >>> +              * for the CPU with highest performance capacity.
> > >>                                             ^^^^^^^^^^^^^^^^^^^^
> > >>
> > >> Do we use a new CPU capacity value `performance capacity (1)` here?
> > >>
> > >> Which I guess is `capacity_orig_of(cpu) - thermal_load_avg(cpu_rq(cpu)`.
> > >>
> > >> I'm asking since util_fits_cpu() still uses: `capacity_orig_thermal (2)
> > >> = capacity_orig - arch_scale_thermal_pressure()` when checking whether
> > >> to return -1. Shouldn't (1) and (2) be the same?
> > >
> > > I'm all in favor of both being capacity_orig_of(cpu) -
> > > thermal_load_avg(cpu_rq(cpu) like the capacity inversion detection
> >
> > I think we need a handy name for this new capacity value, which seems to
> > be `capacity_orig - capacity reduced by thermal`. And we should either
> > use `thermal_load_avg` or `thermal pressure` for the latter part. And
> > then we should use this consistently in all these places:
> > util_fits_cpu(), feec(), sic().
> 
> Ok, let me change this everywhere

I'm not keen on this :-/

Changing this everywhere could have implications beyond our simple capabilities
of testing now :(

Current choice (in util_fits_cpu()) was based on a direct feedback from Xuewen.
I think we should discuss how we can improve the situation instead rather than
worry about consistency. I don't think we can be consistent without doing some
improvements on thermal pressure response time.

A separate proposal patch to invoke some testing and discussion is fine by me.

Better keep it a separate work item please?


Cheers

--
Qais Yousef
