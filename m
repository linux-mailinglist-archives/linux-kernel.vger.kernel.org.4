Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB0BC69CDF8
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 14:54:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232535AbjBTNyn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 08:54:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232531AbjBTNyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 08:54:40 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D603B18B39
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 05:54:38 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id pt11so2042910pjb.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 05:54:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1676901278;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LfmieH10uvfkDMduLvl87yGY+s7U5r5nYAKE9dRffQE=;
        b=JfGpAXmX+5nIWrobI4CuunUQ/Qrdvt8Svk1pVFYxDvuztz+d/nC7gFTjEA/0ubRo+L
         ZqJL1LYkrNuZm6dAyZwNi+3cnvvfcQqAXhl5bwnctZIG+P8goZBZMwaeKy7zr6+GOEAR
         vpukQE/a70N+/LOvnk9+Qb4T/ZVj5uoxPWuZBOAyA5YikWGJ1qtSEI7WCzr0eej9s9A7
         cuHsgw2/UId1gWTqcM2+L6AVbWvSWYm1cGK2UjYx5FCtf2mP65T3kzSFTWERQO8bcGbE
         CE0bDw/Ut0K5a8L5PwN2yS9pQVxPqQ5BInkppkafv+zoxT5RA5XOw8FcasNspgq7YAag
         ESBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676901278;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LfmieH10uvfkDMduLvl87yGY+s7U5r5nYAKE9dRffQE=;
        b=LsYtCQsF7cagxAdVQEuwVVHksLlk1syh2v1twQGrA2EVwqOmvV+qTDY5CFeBCzLQ7Y
         MU7nBfMCCxeMpC1kxG3knI4h36o79YAfwHD1q7Dpv17R+oar5sBr8I3EiJKxDkViVjEH
         HLaqJP1F/31S2yjKxHfbcjUO42BucXwbJi0zMXqRXVT4MjtJqpOVVREb310SumEuIW2t
         Bk/ViAu/CDHDFo22QBvIasNao1v3OTq61dLg0kWlm5iFwrGFCFJ56sG3CsvEejV3gb7d
         93Kgdz1LHUEDdK8fv6GBfywxWs8V/invL28aUz6QmHCzxbDXup0lHyjjS7PEvNaeTcXY
         PwUw==
X-Gm-Message-State: AO0yUKVPDwdHCX1N/PonlAdcFBmqMmxmY3L4XT+jTUSiBfi48JL1HzR8
        rgbE9ltFOaIlOGDJW8VNuln0/eFLk54AxXUDalWeJQ==
X-Google-Smtp-Source: AK7set+VKG5FaLBtzPo8qPgnUYjbJFjqu/MFrqCaJkJrUaYHun1MIuv3lpEBGYcCffnKMoUrwDHeupnDmGzRH0kk02I=
X-Received: by 2002:a17:902:848c:b0:199:1f95:9ad5 with SMTP id
 c12-20020a170902848c00b001991f959ad5mr33707plo.28.1676901278159; Mon, 20 Feb
 2023 05:54:38 -0800 (PST)
MIME-Version: 1.0
References: <20220829055450.1703092-1-dietmar.eggemann@arm.com>
 <0f82011994be68502fd9833e499749866539c3df.camel@mediatek.com>
 <YzVpqweg21yIn30A@hirez.programming.kicks-ass.net> <YzV9Gejo/+DL3UjK@e126311.manchester.arm.com>
 <YzV/yT6OYMgaq0kD@hirez.programming.kicks-ass.net> <YzWuq5ShtJC6KWqe@e126311.manchester.arm.com>
 <Y2kLA8x40IiBEPYg@hirez.programming.kicks-ass.net> <20221108194843.i4qckcu7zwqstyis@airbuntu>
 <Y2vMBWpPlIArwnI7@hirez.programming.kicks-ass.net> <424e2c81-987d-f10e-106d-8b4c611768bc@arm.com>
 <CAKfTPtD0ZOndFef3-JxBn3G9tcX=cZEObjHZ0iqiVTJz7+QrmQ@mail.gmail.com> <249816c9-c2b5-8016-f9ce-dab7b7d384e4@arm.com>
In-Reply-To: <249816c9-c2b5-8016-f9ce-dab7b7d384e4@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 20 Feb 2023 14:54:26 +0100
Message-ID: <CAKfTPtA4gSZAmi3FtU2Y57cuqCzC5LCR=+7Q8Xh=VtkbfaQP5Q@mail.gmail.com>
Subject: Re: [RFC PATCH 0/1] sched/pelt: Change PELT halflife at runtime
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Qais Yousef <qyousef@layalina.io>,
        Kajetan Puchalski <kajetan.puchalski@arm.com>,
        Jian-Min Liu <jian-min.liu@mediatek.com>,
        Ingo Molnar <mingo@kernel.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Vincent Donnefort <vdonnefort@google.com>,
        Quentin Perret <qperret@google.com>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Abhijeet Dharmapurikar <adharmap@quicinc.com>,
        Qais Yousef <qais.yousef@arm.com>,
        linux-kernel@vger.kernel.org,
        Jonathan JMChen <jonathan.jmchen@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Feb 2023 at 14:54, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>
> On 09/02/2023 17:16, Vincent Guittot wrote:
> > On Tue, 7 Feb 2023 at 11:29, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
> >>
> >> On 09/11/2022 16:49, Peter Zijlstra wrote:
> >>> On Tue, Nov 08, 2022 at 07:48:43PM +0000, Qais Yousef wrote:
> >>>> On 11/07/22 14:41, Peter Zijlstra wrote:
> >>>>> On Thu, Sep 29, 2022 at 03:41:47PM +0100, Kajetan Puchalski wrote:
>
> [...]
>
> >> (B) *** Where does util_est_faster help exactly? ***
> >>
> >> It turns out that the score improvement comes from the more aggressive
> >> DVFS request ('_freq') (1) due to the CPU util boost in sugov_get_util()
> >> -> effective_cpu_util(..., cpu_util_cfs(), ...).
> >>
> >> At the beginning of an episode (e.g. beginning of an image list view
> >> fling) when the periodic tasks (~1/16ms (60Hz) at 'max uArch'/'max CPU
> >> frequency') of the Android Graphics Pipeline (AGP) start to run, the
> >> CPU Operating Performance Point (OPP) is often so low that those tasks
> >> run more like 10/16ms which let the test application count a lot of
> >> Jankframes at those moments.
> >
> > I don't see how util_est_faster can help this 1ms task here ? It's
> > most probably never be preempted during this 1ms. For such an Android
>
> It's 1/16ms at max CPU frequency and on a big CPU. Could be a longer
> runtime with min CPU frequency at little CPU. I see runtime up to 10ms
> at the beginning of a test episode.
>
> Like I mentioned below, it could also be that the tasks have more work
> to do at the beginning. It's easy to spot using Google's perfetto and
> those moments also correlate with the occurrence of jankframes. I'm not
> yet sure how much this has to do with the perfetto instrumentation though.
>
> But you're right, on top of that, there is preemption (e.g. of the UI
> thread) by other threads (render thread, involved binder threads,
> surfaceflinger, etc.) going on. So the UI thread could be
> running+runnable for > 20ms, again marked as a jankframe.
>
> > Graphics Pipeline short task, hasn't uclamp_min been designed for and
> > a better solution ?
>
> Yes, it has. I'm not sure how feasible this is to do for all tasks
> involved. I'm thinking about the Binder threads here for instance.

Yes, that can probably not  help for all threads but some system
threads like surfaceflinger and graphic composer should probably
benefit from min uclamp

>
> [...]
>
> >> Looks like that 'util_est_faster' can prevent Jankframes by boosting CPU
> >> util when periodic tasks have a longer runtime compared to when they reach
> >> steady-sate.
> >>
> >> The results is very similar to PELT halflife reduction. The advantage is
> >> that 'util_est_faster' is only activated selectively when the runtime of
> >> the current task in its current activation is long enough to create this
> >> CPU util boost.
> >
> > IIUC how util_est_faster works, it removes the waiting time when
> > sharing cpu time with other tasks. So as long as there is no (runnable
> > but not running time), the result is the same as current util_est.
> > util_est_faster makes a difference only when the task alternates
> > between runnable and running slices.
> > Have you considered using runnable_avg metrics in the increase of cpu
> > freq ? This takes into the runnable slice and not only the running
> > time and increase faster than util_avg when tasks compete for the same
> > CPU
>
> Good idea! No, I haven't.
>
> I just glanced over the code, there shouldn't be an advantage in terms
> of more recent update between `curr->sum_exec_runtime` and
> update_load_avg(cfs_rq) even in the taskgroup case.
>
> Per-task view:
>
> https://nbviewer.org/github/deggeman/lisa/blob/ipynbs/ipynb/scratchpad/cpu_runnable_avg_boost.ipynb
>
>
> All tests ran 10 iterations of all Jankbench sub-tests. (Reran the
> `max_util_scaled_util_est_faster_rbl_freq` once with very similar
> results. Just to make sure the results are somehow correct).
>
> Max_frame_duration:
> +------------------------------------------+------------+
> |             kernel                       |    value   |
> +------------------------------------------+------------+
> |            base-a30b17f016b0             | 147.571352 |
> |                pelt-hl-m2                | 119.416351 |
> |                pelt-hl-m4                | 96.473412  |
> |       scaled_util_est_faster_freq        | 126.646506 |
> | max_util_scaled_util_est_faster_rbl_freq | 157.974501 | <-- !!!
> +------------------------------------------+------------+
>
> Mean_frame_duration:
> +------------------------------------------+-------+-----------+
> |                  kernel                  | value | perc_diff |
> +------------------------------------------+-------+-----------+
> |            base-a30b17f016b0             | 14.7  |   0.0%    |
> |                pelt-hl-m2                | 13.6  |   -7.5%   |
> |                pelt-hl-m4                | 13.0  |  -11.68%  |
> |       scaled_util_est_faster_freq        | 13.7  |  -6.81%   |
> | max_util_scaled_util_est_faster_rbl_freq | 12.1  |  -17.85%  |
> +------------------------------------------+-------+-----------+
>
> Jank percentage (Jank deadline 16ms):
> +------------------------------------------+-------+-----------+
> |                  kernel                  | value | perc_diff |
> +------------------------------------------+-------+-----------+
> |            base-a30b17f016b0             |  1.8  |   0.0%    |
> |                pelt-hl-m2                |  1.8  |  -4.91%   |
> |                pelt-hl-m4                |  1.2  |  -36.61%  |
> |       scaled_util_est_faster_freq        |  1.3  |  -27.63%  |
> | max_util_scaled_util_est_faster_rbl_freq |  0.8  |  -54.86%  |
> +------------------------------------------+-------+-----------+
>
> Power usage [mW] (total - all CPUs):
> +------------------------------------------+-------+-----------+
> |             kernel                       | value | perc_diff |
> +------------------------------------------+-------+-----------+
> |            base-a30b17f016b0             | 144.4 |   0.0%    |
> |                pelt-hl-m2                | 141.6 |  -1.97%   |
> |                pelt-hl-m4                | 163.2 |  12.99%   |
> |       scaled_util_est_faster_freq        | 132.3 |  -8.41%   |
> | max_util_scaled_util_est_faster_rbl_freq | 133.4 |  -7.67%   |
> +------------------------------------------+-------+-----------+
>
> There is a regression in `Max_frame_duration` but `Mean_frame_duration`,
> `Jank percentage` and `Power usage` are better.

The max frame duration is interesting. Could it be the very 1st frame
of the test ?
It's interesting that it's even worse than baseline whereas it should
take the max of baseline and runnable_avg

>
> So maybe DVFS boosting in preempt-scenarios is really the thing here to
> further improve the Android Graphics Pipeline.
>
> I ran the same test (boosting only for DVFS requests) with:
>
> -->8--
>
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index dbc56e8b85f9..7a4bf38f2920 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -2946,6 +2946,8 @@ static inline unsigned long cpu_util_cfs(int cpu)
>                              READ_ONCE(cfs_rq->avg.util_est.enqueued));
>         }
>
> +       util = max(util, READ_ONCE(cfs_rq->avg.runnable_avg));
> +
>         return min(util, capacity_orig_of(cpu));
>
> Thanks!
>
> -- Dietmar
>
>
>
>
>
>
