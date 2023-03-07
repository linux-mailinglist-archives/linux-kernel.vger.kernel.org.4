Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A3206AE05F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 14:24:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbjCGNX4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 08:23:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbjCGNXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 08:23:51 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 494FC4C0C
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 05:22:54 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id z11so8002277pfh.4
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 05:22:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678195363;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AGGOUMnN2E9cQ1gZc/MbTd7aK5oqvNuswTCA4xHREgY=;
        b=F6+BrApn7SdboeJfd8nYm7oaBDoO+4oBoxhakw4+PpiF3xru0V/+royN5fJ2DiaUAU
         207S3vF2AKt4/1pgZ54YigtFPZFoSlmCFR8a7n2HAsPUCOQkT4/KZJA9oftgh06C9wqn
         dSLuvoD9lkPMPa3UtLz4HPuDadg64tg/rWb+gzuJMIl/ceh8hNnoRr1iC/HNzJ5AXcIf
         Mqzwf2QHK0wGFdXhBoms7HzG3faJLTQZRimYNgVHyVUUJ5SZsBQWSapY1m/RoJi5aoy8
         rPwB5Keen9Pf6Tgcmq6TmSIFqzvfWG7Fs6hFD3EO1faQVDJjQBJYkWcjelEIUZ/+qmTi
         oF6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678195363;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AGGOUMnN2E9cQ1gZc/MbTd7aK5oqvNuswTCA4xHREgY=;
        b=V6a5NFjBVYFBLK8d6XR4HERlwl533Nr6C1KxKfF0qcrz5ZGfE+qHANLXMfHUGgDBeT
         NPSTE+LJvGyrnxfMyYzi2K9xkzHhjoyX885cw89lxB7dKo15v5iICY+he4bMKuOAi9v1
         RcGBz8E3F/qSoVL/5/gXUaQ1uelb+LWS6eODVf6vGs1/+A1JNlsnpZzVuzVRlX8Cws5o
         d0YtP+uGl5pHg4BHxkKLKJOM3knumK15t6Omw2E+/fyxMNxHogmHaLqYj8hQ87b0y4OM
         HkmISQwEhTlZrDsb+wOFZBCjnNMS5WhYG9wAcltajEmuleqKUL5uJDorjhZs8oLk0ZNs
         MTIQ==
X-Gm-Message-State: AO0yUKWiIfyL1sAk6kaErk7L+GVW8GEKhp3kIi0pskAL/7v2SXZKdkER
        tGcWeTsYee9XfdScLAduqqadyyuIDkqq3A5JLQMYjg==
X-Google-Smtp-Source: AK7set+yhzjY6mM1wg3LbzG25GzzH8iGm9djTuwX8hASjytOu7mVxGG8DxNTOWynNrFTx1ZsYLpqtJMeNZ63x0OTLIo=
X-Received: by 2002:a05:6a00:2254:b0:5de:ece4:2674 with SMTP id
 i20-20020a056a00225400b005deece42674mr6137413pfu.3.1678195362876; Tue, 07 Mar
 2023 05:22:42 -0800 (PST)
MIME-Version: 1.0
References: <YzWuq5ShtJC6KWqe@e126311.manchester.arm.com> <Y2kLA8x40IiBEPYg@hirez.programming.kicks-ass.net>
 <20221108194843.i4qckcu7zwqstyis@airbuntu> <Y2vMBWpPlIArwnI7@hirez.programming.kicks-ass.net>
 <424e2c81-987d-f10e-106d-8b4c611768bc@arm.com> <CAKfTPtD0ZOndFef3-JxBn3G9tcX=cZEObjHZ0iqiVTJz7+QrmQ@mail.gmail.com>
 <20230223153700.55zydy7jyfwidkis@airbuntu> <CAKfTPtDVGcvmR5BoJpyoOBE19PcWZP+6NjSD7MnJyBAc7VMnmg@mail.gmail.com>
 <20230301172458.intrgsirjauzqmo3@airbuntu> <CAKfTPtDwDdpiQnUqi_OtER5EE0EN4ykDMqtwzHi3d7AyBd_aQA@mail.gmail.com>
 <20230306191109.bfgnbqr4a5ovze3w@airbuntu>
In-Reply-To: <20230306191109.bfgnbqr4a5ovze3w@airbuntu>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 7 Mar 2023 14:22:31 +0100
Message-ID: <CAKfTPtBVjAe4U5ec-VZXUfecdQ2A4BEHGX1ZLYspdRsUvd3=8g@mail.gmail.com>
Subject: Re: [RFC PATCH 0/1] sched/pelt: Change PELT halflife at runtime
To:     Qais Yousef <qyousef@layalina.io>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
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
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Mar 2023 at 20:11, Qais Yousef <qyousef@layalina.io> wrote:
>
> On 03/02/23 09:00, Vincent Guittot wrote:
> > On Wed, 1 Mar 2023 at 18:25, Qais Yousef <qyousef@layalina.io> wrote:
> > >
> > > On 03/01/23 11:39, Vincent Guittot wrote:
> > > > On Thu, 23 Feb 2023 at 16:37, Qais Yousef <qyousef@layalina.io> wrote:
> > > > >
> > > > > On 02/09/23 17:16, Vincent Guittot wrote:
> > > > >
> > > > > > I don't see how util_est_faster can help this 1ms task here ? It's
> > > > > > most probably never be preempted during this 1ms. For such an Android
> > > > > > Graphics Pipeline short task, hasn't uclamp_min been designed for and
> > > > > > a better solution ?
> > > > >
> > > > > uclamp_min is being used in UI and helping there. But your mileage might vary
> > > > > with adoption still.
> > > > >
> > > > > The major motivation behind this is to help things like gaming as the original
> > > > > thread started. It can help UI and other use cases too. Android framework has
> > > > > a lot of context on the type of workload that can help it make a decision when
> > > > > this helps. And OEMs can have the chance to tune and apply based on the
> > > > > characteristics of their device.
> > > > >
> > > > > > IIUC how util_est_faster works, it removes the waiting time when
> > > > > > sharing cpu time with other tasks. So as long as there is no (runnable
> > > > > > but not running time), the result is the same as current util_est.
> > > > > > util_est_faster makes a difference only when the task alternates
> > > > > > between runnable and running slices.
> > > > > > Have you considered using runnable_avg metrics in the increase of cpu
> > > > > > freq ? This takes into the runnable slice and not only the running
> > > > > > time and increase faster than util_avg when tasks compete for the same
> > > > > > CPU
> > > > >
> > > > > Just to understand why we're heading into this direction now.
> > > > >
> > > > > AFAIU the desired outcome to have faster rampup time (and on HMP faster up
> > > > > migration) which both are tied to utilization signal.
> > > > >
> > > > > Wouldn't make the util response time faster help not just for rampup, but
> > > > > rampdown too?
> > > > >
> > > > > If we improve util response time, couldn't this mean we can remove util_est or
> > > > > am I missing something?
> > > >
> > > > not sure because you still have a ramping step whereas util_est
> > > > directly gives you the final tager
> > >
> > > I didn't get you. tager?
> >
> > target
>
> It seems you're referring to the holding function of util_est? ie: keep the
> util high to avoid 'spurious' decays?

I mean whatever the half life, you will have to wait the utilization
to increase.

>
> Isn't this a duplication of the schedutil's filter which is also a holding
> function to prevent rapid frequency changes?

util_est is used by scheduler to estimate the final utilization of the cfs

>
> FWIW, that schedutil filter does get tweaked a lot in android world. Many add
> an additional down_filter to prevent this premature drop in freq (AFAICT).
> Which tells me util_est is not delivering completely on that front in practice.
>
> >
> > >
> > > >
> > > > >
> > > > > Currently we have util response which is tweaked by util_est and then that is
> > > > > tweaked further by schedutil with that 25% margin when maping util to
> > > > > frequency.
> > > >
> > > > the 25% is not related to the ramping time but to the fact that you
> > > > always need some margin to cover unexpected events and estimation
> > > > error
> > >
> > > At the moment we have
> > >
> > >         util_avg -> util_est -> (util_est_faster) -> util_map_freq -> schedutil filter ==> current frequency selection
> > >
> > > I think we have too many transformations before deciding the current
> > > frequencies. Which makes it hard to tweak the system response.
> >
> > What is proposed here with runnable_avg is more to take a new input
> > when selecting a frequency: the level of contention on the cpu. But
>
> What if there's no contention on the CPU and it's just a single task running
> there that suddenly becomes always running for a number of frames?
>
> > this is not used to modify the utilization seen by the scheduler
> >
> > >
> > > >
> > > > >
> > > > > I think if we can allow improving general util response time by tweaking PELT
> > > > > HALFLIFE we can potentially remove util_est and potentially that magic 25%
> > > > > margin too.
> > > > >
> > > > > Why the approach of further tweaking util_est is better?
> > > >
> > > > note that in this case it doesn't really tweak util_est but Dietmar
> > > > has taken into account runnable_avg to increase the freq in case of
> > > > contention
> > > >
> > > > Also IIUC Dietmar's results, the problem seems more linked to the
> > > > selection of a higher freq than increasing the utilization;
> > > > runnable_avg tests give similar perf results than shorter half life
> > > > and better power consumption.
> > >
> > > Does it ramp down faster too?
> >
> > I don't think so.
> >
> > To be honest, I'm not convinced that modifying the half time is the
> > right way to solve this. If it was only a matter of half life not
> > being suitable for a system, the halk life would be set once at boot
> > and people would not ask to modify it at run time.
>
> I'd like to understand more the reason behind these concerns. What is the
> problem with modifying the halflife?

I can somehow understand that some systems would like a different half
life than the current one because of the number of cpus, the pace of
the system... But this should be fixed at boot. The fact that people
needs to dynamically change the half life means for me that even after
changing it then they still don't get the correct  utilization. And I
think that the problem is not really related (or at least not only) to
the correctness of utilization tracking but a lack of taking into
account other input when selecting a frequency. And the contention
(runnable_avg) is a good input to take into account when selecting a
frequency because it reflects that some tasks are waiting to run on
the cpu

>
> The way I see it it is an important metric of how responsive the system to how
> loaded it is. Which drives a lot of important decisions.
>
> 32ms means the system needs approximately 200ms to detect an always running
> task (from idle).
>
> 16ms halves it to 100ms. And 8ms halves it further to 50ms.
>
> Or you can phrase it the opposite way, it takes 200ms to detect the system is
> now idle from always busy state. etc.
>
> Why is it bad for a sys admin to have the ability to adjust this response time
> as they see fit?

because it will use it to bias the response of the system and abuse it
at runtime instead of identifying the root cause.

>
> What goes wrong?
>
> AFAICS the two natural places to control the response time of the system is
> pelt halflife for overall system responsiveness, and the mapping function in
> schedutil for more fine grained frequency response.
>
> There are issues with current filtering mechanism in schedutil too:
>
>         1. It drops any requests during the filtering window. At CFS enqueue we
>            could end up with multiple calls to cpufreq_update_util(); or if we
>            do multiple consecutive enqueues. In a shared domain, there's a race
>            which cpu issues the updated freq request first. Which might not be
>            the best for the domain during this window.
>         2. Maybe it needs asymmetric values for up and down.
>
> I could be naive, but I see util_est as something we should strive to remove to
> be honest. I think there are too many moving cogs.
>
>
> Thanks!
>
> --
> Qais Yousef
