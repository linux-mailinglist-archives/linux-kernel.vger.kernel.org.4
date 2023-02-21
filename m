Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71AFB69DCF0
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 10:30:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233312AbjBUJaD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 04:30:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233025AbjBUJaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 04:30:01 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79BF61EBE1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 01:29:59 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id z20-20020a17090a8b9400b002372d7f823eso222343pjn.4
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 01:29:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=n+VDDhJgqWazIKGY1lyOpshAi6OMtnuac6xCpn4PROE=;
        b=weD1dLs0yIKBvwKdxAUzbO0oR5oVLWYheD3D226rOjIpG95wpobv5Fw6nxw8Lt7p+p
         GnhK/CNbX8Ig9TK8tsJ8ahwWrHw5p5iAjUOLV7+6JWCNs9v0M2A/4M91orlNqEx+wG/M
         tPZxOE6jMe42brXATPjA3Rn67rakC6BWlC+GUOIU/O04aoG+/qK9xdMXtS69g26M6Hus
         MmvduGro1+CPnevvT/EdN3rf5I+PlTiDQLL5RyvYJK/sAPcxPM4csJE1nsclBpluIYTO
         a/CEtV0axC0rMAOE5/suwT0iPMFBcloVk1gSPb8Yg+hV2kcHWNzn9Z0xsRRiIqbxqlKd
         QGcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n+VDDhJgqWazIKGY1lyOpshAi6OMtnuac6xCpn4PROE=;
        b=eyAacPw6XQt615cAKIx+EOiKCr+7q8tXaE8bYB64QYhKixjzkw77p2ZKEq4DtYWglI
         Vr8m3XzUuYp6ElpvakA06As3A6htHUIAKO+8b+iEo48JU3trUNlqD/jmYhGTJiuRdZF+
         btQ8gNox7TUF+N4MogppGbLXoY5J44FJmSODwBKuutqNpDR9jzUCdHPAG3+HdcsS4Z6Q
         s+Nc5El5YtKZinqPEj8DLw84JVTvEBNs2sAcic7CusdmKELQ4X7M0fjvHueWHFHb+zvB
         DkwsR+qZL07VwsvaQSPFGChgnTQnkt6Z4qE4oLC11/k9O+GAdtDVwfAqg1A5U5AixuFq
         uGDw==
X-Gm-Message-State: AO0yUKU43rw0oepdmtpXz2iW2fk3Ef7miT96WgdQMJKPH7/WEsQAFnd/
        1p30S9BfETVekAM/jwFL+jqQIe+jSgaFSWuC/0aXuw==
X-Google-Smtp-Source: AK7set/EV+FNacloXdkpjs/SrGrtkPkaAR6VpO4lWNnbqK2Az119JuewCMs5LvCiniGjwP4tJoGH+ObN84Asj5kyeoo=
X-Received: by 2002:a17:90b:3946:b0:233:f98e:3a37 with SMTP id
 oe6-20020a17090b394600b00233f98e3a37mr949252pjb.15.1676971798841; Tue, 21 Feb
 2023 01:29:58 -0800 (PST)
MIME-Version: 1.0
References: <20220829055450.1703092-1-dietmar.eggemann@arm.com>
 <0f82011994be68502fd9833e499749866539c3df.camel@mediatek.com>
 <YzVpqweg21yIn30A@hirez.programming.kicks-ass.net> <YzV9Gejo/+DL3UjK@e126311.manchester.arm.com>
 <YzV/yT6OYMgaq0kD@hirez.programming.kicks-ass.net> <YzWuq5ShtJC6KWqe@e126311.manchester.arm.com>
 <Y2kLA8x40IiBEPYg@hirez.programming.kicks-ass.net> <20221108194843.i4qckcu7zwqstyis@airbuntu>
 <Y2vMBWpPlIArwnI7@hirez.programming.kicks-ass.net> <424e2c81-987d-f10e-106d-8b4c611768bc@arm.com>
 <CAKfTPtD0ZOndFef3-JxBn3G9tcX=cZEObjHZ0iqiVTJz7+QrmQ@mail.gmail.com>
 <249816c9-c2b5-8016-f9ce-dab7b7d384e4@arm.com> <CAKfTPtA4gSZAmi3FtU2Y57cuqCzC5LCR=+7Q8Xh=VtkbfaQP5Q@mail.gmail.com>
In-Reply-To: <CAKfTPtA4gSZAmi3FtU2Y57cuqCzC5LCR=+7Q8Xh=VtkbfaQP5Q@mail.gmail.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 21 Feb 2023 10:29:47 +0100
Message-ID: <CAKfTPtCdoAtQUJgSGgCZtCWhtv0_WgDrBpGSRTwHG=SV_Jf4ew@mail.gmail.com>
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

On Mon, 20 Feb 2023 at 14:54, Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> On Fri, 17 Feb 2023 at 14:54, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
> >
> > On 09/02/2023 17:16, Vincent Guittot wrote:
> > > On Tue, 7 Feb 2023 at 11:29, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
> > >>
> > >> On 09/11/2022 16:49, Peter Zijlstra wrote:
> > >>> On Tue, Nov 08, 2022 at 07:48:43PM +0000, Qais Yousef wrote:
> > >>>> On 11/07/22 14:41, Peter Zijlstra wrote:
> > >>>>> On Thu, Sep 29, 2022 at 03:41:47PM +0100, Kajetan Puchalski wrote:
> >
> > [...]
> >
> > >> (B) *** Where does util_est_faster help exactly? ***
> > >>
> > >> It turns out that the score improvement comes from the more aggressive
> > >> DVFS request ('_freq') (1) due to the CPU util boost in sugov_get_util()
> > >> -> effective_cpu_util(..., cpu_util_cfs(), ...).
> > >>
> > >> At the beginning of an episode (e.g. beginning of an image list view
> > >> fling) when the periodic tasks (~1/16ms (60Hz) at 'max uArch'/'max CPU
> > >> frequency') of the Android Graphics Pipeline (AGP) start to run, the
> > >> CPU Operating Performance Point (OPP) is often so low that those tasks
> > >> run more like 10/16ms which let the test application count a lot of
> > >> Jankframes at those moments.
> > >
> > > I don't see how util_est_faster can help this 1ms task here ? It's
> > > most probably never be preempted during this 1ms. For such an Android
> >
> > It's 1/16ms at max CPU frequency and on a big CPU. Could be a longer
> > runtime with min CPU frequency at little CPU. I see runtime up to 10ms
> > at the beginning of a test episode.
> >
> > Like I mentioned below, it could also be that the tasks have more work
> > to do at the beginning. It's easy to spot using Google's perfetto and
> > those moments also correlate with the occurrence of jankframes. I'm not
> > yet sure how much this has to do with the perfetto instrumentation though.
> >
> > But you're right, on top of that, there is preemption (e.g. of the UI
> > thread) by other threads (render thread, involved binder threads,
> > surfaceflinger, etc.) going on. So the UI thread could be
> > running+runnable for > 20ms, again marked as a jankframe.
> >
> > > Graphics Pipeline short task, hasn't uclamp_min been designed for and
> > > a better solution ?
> >
> > Yes, it has. I'm not sure how feasible this is to do for all tasks
> > involved. I'm thinking about the Binder threads here for instance.
>
> Yes, that can probably not  help for all threads but some system
> threads like surfaceflinger and graphic composer should probably
> benefit from min uclamp
>
> >
> > [...]
> >
> > >> Looks like that 'util_est_faster' can prevent Jankframes by boosting CPU
> > >> util when periodic tasks have a longer runtime compared to when they reach
> > >> steady-sate.
> > >>
> > >> The results is very similar to PELT halflife reduction. The advantage is
> > >> that 'util_est_faster' is only activated selectively when the runtime of
> > >> the current task in its current activation is long enough to create this
> > >> CPU util boost.
> > >
> > > IIUC how util_est_faster works, it removes the waiting time when
> > > sharing cpu time with other tasks. So as long as there is no (runnable
> > > but not running time), the result is the same as current util_est.
> > > util_est_faster makes a difference only when the task alternates
> > > between runnable and running slices.
> > > Have you considered using runnable_avg metrics in the increase of cpu
> > > freq ? This takes into the runnable slice and not only the running
> > > time and increase faster than util_avg when tasks compete for the same
> > > CPU
> >
> > Good idea! No, I haven't.
> >
> > I just glanced over the code, there shouldn't be an advantage in terms
> > of more recent update between `curr->sum_exec_runtime` and
> > update_load_avg(cfs_rq) even in the taskgroup case.
> >
> > Per-task view:
> >
> > https://nbviewer.org/github/deggeman/lisa/blob/ipynbs/ipynb/scratchpad/cpu_runnable_avg_boost.ipynb
> >
> >
> > All tests ran 10 iterations of all Jankbench sub-tests. (Reran the
> > `max_util_scaled_util_est_faster_rbl_freq` once with very similar
> > results. Just to make sure the results are somehow correct).
> >
> > Max_frame_duration:
> > +------------------------------------------+------------+
> > |             kernel                       |    value   |
> > +------------------------------------------+------------+
> > |            base-a30b17f016b0             | 147.571352 |
> > |                pelt-hl-m2                | 119.416351 |
> > |                pelt-hl-m4                | 96.473412  |
> > |       scaled_util_est_faster_freq        | 126.646506 |
> > | max_util_scaled_util_est_faster_rbl_freq | 157.974501 | <-- !!!
> > +------------------------------------------+------------+
> >
> > Mean_frame_duration:
> > +------------------------------------------+-------+-----------+
> > |                  kernel                  | value | perc_diff |
> > +------------------------------------------+-------+-----------+
> > |            base-a30b17f016b0             | 14.7  |   0.0%    |
> > |                pelt-hl-m2                | 13.6  |   -7.5%   |
> > |                pelt-hl-m4                | 13.0  |  -11.68%  |
> > |       scaled_util_est_faster_freq        | 13.7  |  -6.81%   |
> > | max_util_scaled_util_est_faster_rbl_freq | 12.1  |  -17.85%  |
> > +------------------------------------------+-------+-----------+
> >
> > Jank percentage (Jank deadline 16ms):
> > +------------------------------------------+-------+-----------+
> > |                  kernel                  | value | perc_diff |
> > +------------------------------------------+-------+-----------+
> > |            base-a30b17f016b0             |  1.8  |   0.0%    |
> > |                pelt-hl-m2                |  1.8  |  -4.91%   |
> > |                pelt-hl-m4                |  1.2  |  -36.61%  |
> > |       scaled_util_est_faster_freq        |  1.3  |  -27.63%  |
> > | max_util_scaled_util_est_faster_rbl_freq |  0.8  |  -54.86%  |
> > +------------------------------------------+-------+-----------+
> >
> > Power usage [mW] (total - all CPUs):
> > +------------------------------------------+-------+-----------+
> > |             kernel                       | value | perc_diff |
> > +------------------------------------------+-------+-----------+
> > |            base-a30b17f016b0             | 144.4 |   0.0%    |
> > |                pelt-hl-m2                | 141.6 |  -1.97%   |
> > |                pelt-hl-m4                | 163.2 |  12.99%   |
> > |       scaled_util_est_faster_freq        | 132.3 |  -8.41%   |
> > | max_util_scaled_util_est_faster_rbl_freq | 133.4 |  -7.67%   |
> > +------------------------------------------+-------+-----------+
> >
> > There is a regression in `Max_frame_duration` but `Mean_frame_duration`,
> > `Jank percentage` and `Power usage` are better.
>
> The max frame duration is interesting. Could it be the very 1st frame
> of the test ?
> It's interesting that it's even worse than baseline whereas it should
> take the max of baseline and runnable_avg
>
> >
> > So maybe DVFS boosting in preempt-scenarios is really the thing here to
> > further improve the Android Graphics Pipeline.
> >
> > I ran the same test (boosting only for DVFS requests) with:
> >
> > -->8--
> >
> > diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> > index dbc56e8b85f9..7a4bf38f2920 100644
> > --- a/kernel/sched/sched.h
> > +++ b/kernel/sched/sched.h
> > @@ -2946,6 +2946,8 @@ static inline unsigned long cpu_util_cfs(int cpu)
> >                              READ_ONCE(cfs_rq->avg.util_est.enqueued));
> >         }
> >
> > +       util = max(util, READ_ONCE(cfs_rq->avg.runnable_avg));
> > +

Another reason why it gives better results could be that
cpu_util_cfs() is not only used for DVFS selection but also to track
the cpu utilization in load balance and EAS so the cpu will be faster
seen as overloaded and tasks will be spread around when there are
contentions.

Could you try to take cfs_rq->avg.runnable_avg into account only when
selecting frequency ?

That being said I can see some place in load balance where
cfs_rq->avg.runnable_avg could give some benefits like in
find_busiest_queue() where it could be better to take into account the
contention when selecting the busiest queue

> >         return min(util, capacity_orig_of(cpu));
> >
> > Thanks!
> >
> > -- Dietmar
> >
> >
> >
> >
> >
> >
