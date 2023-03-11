Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06D2A6B5E2C
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 17:55:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbjCKQz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 11:55:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjCKQzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 11:55:25 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E8E160428
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 08:55:22 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id f11so7740625wrv.8
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 08:55:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20210112.gappssmtp.com; s=20210112; t=1678553720;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EPWopmrfVhguOzGMPP3tftlAKbC9wyhBQ+UkCCM0q+Y=;
        b=yLJdGGRdM5q1Q0WUdr4tsq+ObhXti7SoH1o2+dlHpsdAh9tlrZga2KCrB4m/EJu83I
         aQ9PQoKePr2MTZPufVpcR9Yg56leJ6OlIfV5oLzQSwTJP8H5iVSF98qlJYxz2U2QCEgI
         UK1CSkkKtj+3bM6aVQwSS5nUfaOZtyD76ql2KBSCygN8eoTGtIC5l4E+/rzVsijI7boI
         lcy3wsrj2bQmiU/8SohFg4IdlCa/DzGPeKPR9WedMMLmiLhRuNTP13NasFIZ6G5/IMCA
         o1ClL22pUzH7o816kbz2NdFWjIG4iUzL1sXJodsAjDl8acm2LeJVOG+RawdfQUFrKpqY
         yvZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678553720;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EPWopmrfVhguOzGMPP3tftlAKbC9wyhBQ+UkCCM0q+Y=;
        b=sTfwIDfbA+MkF20aYvUxAIxz4GjvX2Mu2L9xk1iiOom6Mk3L8hVBIwcH7n0lJsXARE
         DG8zm44/MxjZIQ48kI6JH8Im4M0TyqlrgsLnfAv96salAgeBzIrorw+KSwTMy6RlFlBw
         BteSFdG66PGs6NFN1hbPcGH+O/uePKyfj7kP2ebHKh1r+sPSmSXIIb5ny3FnS2P0qeVD
         MD9yuYufpvW3Hkgq2hhw5QgKpqrRgQdP8P/s9a6M9GPgw41FrEjuMKg7lTwFObDg2XQk
         FBcaLf3E4aiBgcMt3JKTm6AMfG38kWlVfHjcxlEJr5ipmxS+bdBKfdbRWlYiZJqtVsOu
         +wrQ==
X-Gm-Message-State: AO0yUKXViu+I1n2TBI+wZ+2F9EBsPRIC1SqMm5ZUETwK2yLgDnD4Qf00
        K62CGbx/zJ74WaUJ8Oi57M5NlA==
X-Google-Smtp-Source: AK7set/V0Nbs8aD/SC20ECZH5DNT0ia5PCP8kCA7jQw/JdnZrn6RgQXSon55bRbGigOBqhz0QMFCMg==
X-Received: by 2002:a5d:4e85:0:b0:2c7:1aaa:2b49 with SMTP id e5-20020a5d4e85000000b002c71aaa2b49mr21015669wru.23.1678553720414;
        Sat, 11 Mar 2023 08:55:20 -0800 (PST)
Received: from airbuntu (host86-168-251-3.range86-168.btcentralplus.com. [86.168.251.3])
        by smtp.gmail.com with ESMTPSA id z17-20020a5d4c91000000b002c5a1bd5280sm2871996wrs.95.2023.03.11.08.55.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Mar 2023 08:55:19 -0800 (PST)
Date:   Sat, 11 Mar 2023 16:55:17 +0000
From:   Qais Yousef <qyousef@layalina.io>
To:     Vincent Guittot <vincent.guittot@linaro.org>
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
Subject: Re: [RFC PATCH 0/1] sched/pelt: Change PELT halflife at runtime
Message-ID: <20230311165517.vqgccdzu7zyxko56@airbuntu>
References: <20221108194843.i4qckcu7zwqstyis@airbuntu>
 <Y2vMBWpPlIArwnI7@hirez.programming.kicks-ass.net>
 <424e2c81-987d-f10e-106d-8b4c611768bc@arm.com>
 <CAKfTPtD0ZOndFef3-JxBn3G9tcX=cZEObjHZ0iqiVTJz7+QrmQ@mail.gmail.com>
 <20230223153700.55zydy7jyfwidkis@airbuntu>
 <CAKfTPtDVGcvmR5BoJpyoOBE19PcWZP+6NjSD7MnJyBAc7VMnmg@mail.gmail.com>
 <20230301172458.intrgsirjauzqmo3@airbuntu>
 <CAKfTPtDwDdpiQnUqi_OtER5EE0EN4ykDMqtwzHi3d7AyBd_aQA@mail.gmail.com>
 <20230306191109.bfgnbqr4a5ovze3w@airbuntu>
 <CAKfTPtBVjAe4U5ec-VZXUfecdQ2A4BEHGX1ZLYspdRsUvd3=8g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKfTPtBVjAe4U5ec-VZXUfecdQ2A4BEHGX1ZLYspdRsUvd3=8g@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/07/23 14:22, Vincent Guittot wrote:
> On Mon, 6 Mar 2023 at 20:11, Qais Yousef <qyousef@layalina.io> wrote:
> >
> > On 03/02/23 09:00, Vincent Guittot wrote:
> > > On Wed, 1 Mar 2023 at 18:25, Qais Yousef <qyousef@layalina.io> wrote:
> > > >
> > > > On 03/01/23 11:39, Vincent Guittot wrote:
> > > > > On Thu, 23 Feb 2023 at 16:37, Qais Yousef <qyousef@layalina.io> wrote:
> > > > > >
> > > > > > On 02/09/23 17:16, Vincent Guittot wrote:
> > > > > >
> > > > > > > I don't see how util_est_faster can help this 1ms task here ? It's
> > > > > > > most probably never be preempted during this 1ms. For such an Android
> > > > > > > Graphics Pipeline short task, hasn't uclamp_min been designed for and
> > > > > > > a better solution ?
> > > > > >
> > > > > > uclamp_min is being used in UI and helping there. But your mileage might vary
> > > > > > with adoption still.
> > > > > >
> > > > > > The major motivation behind this is to help things like gaming as the original
> > > > > > thread started. It can help UI and other use cases too. Android framework has
> > > > > > a lot of context on the type of workload that can help it make a decision when
> > > > > > this helps. And OEMs can have the chance to tune and apply based on the
> > > > > > characteristics of their device.
> > > > > >
> > > > > > > IIUC how util_est_faster works, it removes the waiting time when
> > > > > > > sharing cpu time with other tasks. So as long as there is no (runnable
> > > > > > > but not running time), the result is the same as current util_est.
> > > > > > > util_est_faster makes a difference only when the task alternates
> > > > > > > between runnable and running slices.
> > > > > > > Have you considered using runnable_avg metrics in the increase of cpu
> > > > > > > freq ? This takes into the runnable slice and not only the running
> > > > > > > time and increase faster than util_avg when tasks compete for the same
> > > > > > > CPU
> > > > > >
> > > > > > Just to understand why we're heading into this direction now.
> > > > > >
> > > > > > AFAIU the desired outcome to have faster rampup time (and on HMP faster up
> > > > > > migration) which both are tied to utilization signal.
> > > > > >
> > > > > > Wouldn't make the util response time faster help not just for rampup, but
> > > > > > rampdown too?
> > > > > >
> > > > > > If we improve util response time, couldn't this mean we can remove util_est or
> > > > > > am I missing something?
> > > > >
> > > > > not sure because you still have a ramping step whereas util_est
> > > > > directly gives you the final tager
> > > >
> > > > I didn't get you. tager?
> > >
> > > target
> >
> > It seems you're referring to the holding function of util_est? ie: keep the
> > util high to avoid 'spurious' decays?
> 
> I mean whatever the half life, you will have to wait the utilization
> to increase.

Yes - which is what ramp up delay that is unacceptable in some cases and seem
to have been raised several times over the years

> 
> >
> > Isn't this a duplication of the schedutil's filter which is also a holding
> > function to prevent rapid frequency changes?
> 
> util_est is used by scheduler to estimate the final utilization of the cfs

IIR the commit message that introduced it correctly it is talking about ramp up
delays - and issues with premature decaying for periodic tasks.

So it is a mechanism to speed up util_avg response time. The same issue we're
trying to address again now.

> 
> >
> > FWIW, that schedutil filter does get tweaked a lot in android world. Many add
> > an additional down_filter to prevent this premature drop in freq (AFAICT).
> > Which tells me util_est is not delivering completely on that front in practice.
> >
> > >
> > > >
> > > > >
> > > > > >
> > > > > > Currently we have util response which is tweaked by util_est and then that is
> > > > > > tweaked further by schedutil with that 25% margin when maping util to
> > > > > > frequency.
> > > > >
> > > > > the 25% is not related to the ramping time but to the fact that you
> > > > > always need some margin to cover unexpected events and estimation
> > > > > error
> > > >
> > > > At the moment we have
> > > >
> > > >         util_avg -> util_est -> (util_est_faster) -> util_map_freq -> schedutil filter ==> current frequency selection
> > > >
> > > > I think we have too many transformations before deciding the current
> > > > frequencies. Which makes it hard to tweak the system response.
> > >
> > > What is proposed here with runnable_avg is more to take a new input
> > > when selecting a frequency: the level of contention on the cpu. But
> >
> > What if there's no contention on the CPU and it's just a single task running
> > there that suddenly becomes always running for a number of frames?
> >
> > > this is not used to modify the utilization seen by the scheduler
> > >
> > > >
> > > > >
> > > > > >
> > > > > > I think if we can allow improving general util response time by tweaking PELT
> > > > > > HALFLIFE we can potentially remove util_est and potentially that magic 25%
> > > > > > margin too.
> > > > > >
> > > > > > Why the approach of further tweaking util_est is better?
> > > > >
> > > > > note that in this case it doesn't really tweak util_est but Dietmar
> > > > > has taken into account runnable_avg to increase the freq in case of
> > > > > contention
> > > > >
> > > > > Also IIUC Dietmar's results, the problem seems more linked to the
> > > > > selection of a higher freq than increasing the utilization;
> > > > > runnable_avg tests give similar perf results than shorter half life
> > > > > and better power consumption.
> > > >
> > > > Does it ramp down faster too?
> > >
> > > I don't think so.
> > >
> > > To be honest, I'm not convinced that modifying the half time is the
> > > right way to solve this. If it was only a matter of half life not
> > > being suitable for a system, the halk life would be set once at boot
> > > and people would not ask to modify it at run time.
> >
> > I'd like to understand more the reason behind these concerns. What is the
> > problem with modifying the halflife?
> 
> I can somehow understand that some systems would like a different half
> life than the current one because of the number of cpus, the pace of
> the system... But this should be fixed at boot. The fact that people

The boot time might be the only thing required. I think some systems only need
this already. The difficulty in practice is that on some systems this might
result in worse power over a day of use. So it'll all depend, hence the desire
to have it as a runtime. Why invent more crystal balls that might or not might
not be the best thing depends on who you ask?

> needs to dynamically change the half life means for me that even after
> changing it then they still don't get the correct  utilization. And I

What is the correct utilization? It is just a signal in attempt to crystal ball
the future. It can't be correct in general IMHO. It's best effort that we know
fails occasionally already.

As I said above - there's a trade-off in perf/power and that will highly depend
on the system.

The proposed high contention detection doesn't address this trade-off; rather
biases the system further towards perf-first. Which is not always the right
trade-off. It could be a useful addition - but it needs to be a tunable too.

> think that the problem is not really related (or at least not only) to
> the correctness of utilization tracking but a lack of taking into

It's not correctness issue. It's response time issue. It's a simple
task of improving the reactiveness of the system. Which has a power cost that
some users don't want to incur when not necessary.

> account other input when selecting a frequency. And the contention
> (runnable_avg) is a good input to take into account when selecting a
> frequency because it reflects that some tasks are waiting to run on
> the cpu

You did not answer my question above. What if there's no contention and
a single task on a cpu suddenly moves from mostly idle to always running for
a number of frames? There's no contention in there. How will this be improved?

> 
> >
> > The way I see it it is an important metric of how responsive the system to how
> > loaded it is. Which drives a lot of important decisions.
> >
> > 32ms means the system needs approximately 200ms to detect an always running
> > task (from idle).
> >
> > 16ms halves it to 100ms. And 8ms halves it further to 50ms.
> >
> > Or you can phrase it the opposite way, it takes 200ms to detect the system is
> > now idle from always busy state. etc.
> >
> > Why is it bad for a sys admin to have the ability to adjust this response time
> > as they see fit?
> 
> because it will use it to bias the response of the system and abuse it
> at runtime instead of identifying the root cause.

No one wants to abuse anything. But the one size fits all approach is not
always right too. And sys admins and end users have the right to tune their
systems the way they see fit.  There are too many variations out there to hard
code the system response. I view this like the right to repair - it's their
system, why do they have to hack the kernel to tune it?

The root cause is that the system reactiveness is controlled by this value.
And there's a trade-off between perf/power that is highly dependent on the
system characteristic. On some areas a boot time is all that one needs. In
others, it might be desired to improve specific use cases like gaming only as
the speed up at boot time only can hurt overall battery life in normal use
cases.

I think the story is simple :)

In my view util_est is borderline a hack. We just need to enable control pelt
ramp-up/down response times + improve schedutil. I highlight a few shortcomings
that are already known in the practice below. And that phoronix article about
schedutil not being better than ondemand demonstrates that this is an issue
outside of mobile too.

schedutil - as the name says it - depends on util signal. Which also depends on
pelt halflife. I really think this is the most natural and predictable way to
tune the system. I can't see the drawbacks.

I think we need to distinguish between picking sensible default behavior; and
enforcing policies or restricting user's choice. AFAICS the discussion is going
towards the latter.

On the topic of defaults - I do think 16ms is a more sensible default for
modern day hardware and use cases.

/me runs and hides :)


Cheers

--
Qais Yousef

> 
> >
> > What goes wrong?
> >
> > AFAICS the two natural places to control the response time of the system is
> > pelt halflife for overall system responsiveness, and the mapping function in
> > schedutil for more fine grained frequency response.
> >
> > There are issues with current filtering mechanism in schedutil too:
> >
> >         1. It drops any requests during the filtering window. At CFS enqueue we
> >            could end up with multiple calls to cpufreq_update_util(); or if we
> >            do multiple consecutive enqueues. In a shared domain, there's a race
> >            which cpu issues the updated freq request first. Which might not be
> >            the best for the domain during this window.
> >         2. Maybe it needs asymmetric values for up and down.
> >
> > I could be naive, but I see util_est as something we should strive to remove to
> > be honest. I think there are too many moving cogs.
> >
> >
> > Thanks!
> >
> > --
> > Qais Yousef
