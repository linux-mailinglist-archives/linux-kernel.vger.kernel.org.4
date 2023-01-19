Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AEC267351C
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 11:08:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbjASKI3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 05:08:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjASKIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 05:08:19 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D371E768A
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 02:08:17 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id o13so1906765pjg.2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 02:08:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jF5OEB39TnI22JBi4pkGKLll7/+mk1qfajpVoGAprpE=;
        b=BTYRZnDtnfjH6MvIcaBWQYkP8zlh2vVBitmtIQoiM63j1JaXvmkCfmGDfaj+OJxXqV
         NY01dIjZj4fN3zblf2g5cidPRkhGhJkkJZ40U8xVw0sLX7PXtA+J40OXjcRX9Kv9cGWU
         R0m7SN+NFTePRtHr5QGHkSW77njWKJzXMx0u0aoOrqFOZRI/ucZEex/0vkfk7s+eaPHI
         Rzav5WMRgs6PYhpfzR8QsGFYDXcffrJO8yDuj681nNpqY7xzgi/+NgI5dfCLhTzZ4aq4
         L0mWqa00ru64fyxLK8TNN0XmD2FJvoxmm67/MiMonJvLE09uyrefgQDwUQoSe2oXA8De
         BJVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jF5OEB39TnI22JBi4pkGKLll7/+mk1qfajpVoGAprpE=;
        b=VN80Vyb5aymkHXFcV0gwRybb/Z8D/ZdTs+HJ31RNbS7sKsm4ynn4j5sJPLMOEbjZbw
         K2g5ntoCSW3WpSce4cqU/ZxAwh38Z/uorCPj5SCZ6gjVYsKS2ol5BC2pb3MZHUX8Q5TI
         ZEWqgMVQ0Pa4NxNnZzQRU4ccP0V2f1XuLU3smvM0LVz5IjDeJG+Pd3gCe6htYWcumWL7
         YAndBnVwBpPAdRO0V5doAiPMJF/trRcdll2woKlrTpOpQZ1G2cpF5N+Vg6pP1zEm3CHz
         VIT67fCR34r/1hPCioz24dAM9R95EMU0r2L60EQBB++Xjd1fto9nZAWY7Rm/Sh0lZd/c
         JYQg==
X-Gm-Message-State: AFqh2kojTJRFOqrKDRTVRGQ/ymo2EsM+bnWuagNAx2zG0CslQ3JHvw2s
        N8RGD8DOIv40kzGiTeuScVuTdhBAC+ZZToMx6mVoCg==
X-Google-Smtp-Source: AMrXdXu92pTAZ58CEH3HEELdXHl0CYb4HMOjx6JEoEeX9bRBNs4Z5GVdFUh0oB9V9vtEnv26qbk/y32v4bo5e2oCp2k=
X-Received: by 2002:a17:902:c10d:b0:189:97e9:c8e with SMTP id
 13-20020a170902c10d00b0018997e90c8emr924770pli.63.1674122897253; Thu, 19 Jan
 2023 02:08:17 -0800 (PST)
MIME-Version: 1.0
References: <20230113134056.257691-1-vincent.guittot@linaro.org>
 <78bf2d91-0076-f748-7c6a-530dad466787@arm.com> <CAKfTPtCAAOvFak2FqkKv2AwnoBZ3cwbMwfnAAGqDx+Wq4Ng+zw@mail.gmail.com>
 <7a6182dd-89f5-69c5-4331-2f102dc0418d@arm.com> <CAKfTPtCfbVgwPGYgw4vuO3UgEFM9GbMzyrzkgCoeL7onZXQXBg@mail.gmail.com>
 <20230118164820.r37yfigmwwdske4r@airbuntu>
In-Reply-To: <20230118164820.r37yfigmwwdske4r@airbuntu>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 19 Jan 2023 11:08:06 +0100
Message-ID: <CAKfTPtBX=tA2mDdbMP+R5fOZkH-P3AORgTk=ozXLRrP2Hz7kVg@mail.gmail.com>
Subject: Re: [PATCH v3] sched/fair: unlink misfit task from cpu overutilized
To:     Qais Yousef <qyousef@layalina.io>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>, mingo@kernel.org,
        peterz@infradead.org, rafael@kernel.org, viresh.kumar@linaro.org,
        vschneid@redhat.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, lukasz.luba@arm.com, wvw@google.com,
        xuewen.yan94@gmail.com, han.lin@mediatek.com,
        Jonathan.JMChen@mediatek.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Jan 2023 at 17:48, Qais Yousef <qyousef@layalina.io> wrote:
>
> On 01/18/23 09:15, Vincent Guittot wrote:
> > On Mon, 16 Jan 2023 at 15:56, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
> > >
> > > On 16/01/2023 12:23, Vincent Guittot wrote:
> > > > On Mon, 16 Jan 2023 at 10:07, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
> > > >>
> > > >> On 13/01/2023 14:40, Vincent Guittot wrote:
> > >
> > > [...]
> > >
> > > >>> @@ -6132,6 +6135,7 @@ static inline bool cpu_overutilized(int cpu)
> > > >>>       unsigned long rq_util_min = uclamp_rq_get(cpu_rq(cpu), UCLAMP_MIN);
> > > >>>       unsigned long rq_util_max = uclamp_rq_get(cpu_rq(cpu), UCLAMP_MAX);
> > > >>>
> > > >>> +     /* Return true only if the utlization doesn't fit its capacity */
> > > >>
> > > >> s/utlization/utilization
> > > >> s/its/CPU ?
> > > >>
> > > >>>       return !util_fits_cpu(cpu_util_cfs(cpu), rq_util_min, rq_util_max, cpu);
> > > >>>  }
> > > >>
> > > >> cpu_overutilized() is the only place where we now only test for
> > > >> !util_fits_cpu(). The new comment says we only care about utilization
> > > >> not fitting CPU capacity.
> > > >>
> > > >> Does this mean the rq uclamp values are not important here and we could
> > > >> go back to use fits_capacity()?
> > > >>
> > > >> Not sure since util_fits_cpu() is still coded differently:
> > > >
> > > > uclamp_min is not important but uclamp_max still cap the utilization
> > >
> > > OK, makes sense.
> > >
> > > I.e. we could pass in `rq_util_min = 0` to avoid fetching it
> > > unnecessary? In case `fits == 1` before the uclamp_min condition in
> > > util_fits_cpu() it doesn't matter if we switch to return `-1` when
> > > called from cpu_overutilized(). Detail though ...
> >
> > One comment from Qais was to minimize knowledge outside
> > util_fits_cpu() that's why I pass both uclamp_min and uclamp_max.
> >
> > >
> > > [...]
> > >
> > > >>> @@ -6940,12 +6945,28 @@ select_idle_capacity(struct task_struct *p, struct sched_domain *sd, int target)
> > > >>>
> > > >>>               if (!available_idle_cpu(cpu) && !sched_idle_cpu(cpu))
> > > >>>                       continue;
> > > >>> -             if (util_fits_cpu(task_util, util_min, util_max, cpu))
> > > >>> +
> > > >>> +             fits = util_fits_cpu(task_util, util_min, util_max, cpu);
> > > >>> +
> > > >>> +             /* This CPU fits with all capacity and performance requirements */
> > > >>
> > > >> In task_fits_cpu() `utilization and performance (better uclamp)
> > > >> requirements` term was used. I assume it's the same thing here?
> > > >>
> > > >>> +             if (fits > 0)
> > > >>>                       return cpu;
> > > >>> +             /*
> > > >>> +              * Only the min performance (i.e. uclamp_min) doesn't fit. Look
> > > >>> +              * for the CPU with highest performance capacity.
> > > >>                                             ^^^^^^^^^^^^^^^^^^^^
> > > >>
> > > >> Do we use a new CPU capacity value `performance capacity (1)` here?
> > > >>
> > > >> Which I guess is `capacity_orig_of(cpu) - thermal_load_avg(cpu_rq(cpu)`.
> > > >>
> > > >> I'm asking since util_fits_cpu() still uses: `capacity_orig_thermal (2)
> > > >> = capacity_orig - arch_scale_thermal_pressure()` when checking whether
> > > >> to return -1. Shouldn't (1) and (2) be the same?
> > > >
> > > > I'm all in favor of both being capacity_orig_of(cpu) -
> > > > thermal_load_avg(cpu_rq(cpu) like the capacity inversion detection
> > >
> > > I think we need a handy name for this new capacity value, which seems to
> > > be `capacity_orig - capacity reduced by thermal`. And we should either
> > > use `thermal_load_avg` or `thermal pressure` for the latter part. And
> > > then we should use this consistently in all these places:
> > > util_fits_cpu(), feec(), sic().
> >
> > Ok, let me change this everywhere
>
> I'm not keen on this :-/
>
> Changing this everywhere could have implications beyond our simple capabilities
> of testing now :(
>
> Current choice (in util_fits_cpu()) was based on a direct feedback from Xuewen.
> I think we should discuss how we can improve the situation instead rather than
> worry about consistency. I don't think we can be consistent without doing some
> improvements on thermal pressure response time.
>
> A separate proposal patch to invoke some testing and discussion is fine by me.
>
> Better keep it a separate work item please?

Ok, I'm going to keep the current use of arch_scale_thermal_pressure
and thermal_load_avg for this patch

Thanks


>
>
> Cheers
>
> --
> Qais Yousef
