Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC6C4641713
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 14:40:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbiLCNkl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Dec 2022 08:40:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbiLCNkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Dec 2022 08:40:39 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B56AA1F9FE
        for <linux-kernel@vger.kernel.org>; Sat,  3 Dec 2022 05:40:37 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id n9-20020a05600c3b8900b003d0944dba41so1803087wms.4
        for <linux-kernel@vger.kernel.org>; Sat, 03 Dec 2022 05:40:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0F3GAlCvpelRw+9YZgUcAm7orMMHSYf9to/0X5/PXB8=;
        b=7zlPG354d18P0gr2bfX2Uff0Jr3QVvxQIDTSZRD5oaKQkgIgSNgNuy5HTG+SxALWka
         CyIKyJ7V22WWASvY19/I7fO5QEYKngHulgQxVehzAOfmM4MsknuzjBltfXnpewHk7kBT
         Wk9HPJ4R9ifeQWwBgpe855c6S13YNgTm+WJ9c1/4N/n/Ke7ZPMjs617NHXJjIYzXKMVw
         SHUJSm/ejuKaNIzvwskIpNgv4+U8pji1YRtV7jpH4FufYEV6OOQzzohqCzz5D1uRAuL2
         vdnWzUevqhYd7xEwidNV0KNkMMqkASF2kRFZ4q6v/WL0EtybG9QLoBx+wReJh0NjhBhO
         00xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0F3GAlCvpelRw+9YZgUcAm7orMMHSYf9to/0X5/PXB8=;
        b=pxY6WWb4/m8rKorHTLul+1ytSb1+++bqZa7QS+VzSZPYi5XSLsnTJEqUfT/3LqOxa5
         gUgF7pUYIoGQv+7wp3RpZbFSQOpRkk3BboWgXU87NW91KyNo4x2tYz4HFcLy/9SRD3Ws
         rVKCUUbNO2k/b03F/7e1R0zMg6sOF9DBAH3w9TOtxlX818qj+cjy0nboSf4idj4SEpNG
         Ivt3fF0djvRSxWFVudAsL4CHcrwC8IGzO32pxDqalT9UVqM2Fwp3DLI2PWaUZGWPPvQp
         4yTLklNFQeIwXKsrseifWv+nkyuvPhAvysicbUm2yyOZmWhxTy9b7lnl+GIlv9Gwpo5c
         ENPA==
X-Gm-Message-State: ANoB5plRV616galQVOf3Kaimro2bR3baGm2ZdVzG2M0KvaX3P5v1Sq7E
        m2VZVYbRKq0V+VGSSdoSEy0CMA==
X-Google-Smtp-Source: AA0mqf6i2Cr4cktlTPiZbCz9bzbl9jzWNIRGNMw89rYFa4zZza4gLhZj4r4YIVmJEt+qdKsbHkNT6A==
X-Received: by 2002:a05:600c:384d:b0:3cf:7217:d5fa with SMTP id s13-20020a05600c384d00b003cf7217d5famr44492403wmr.191.1670074836112;
        Sat, 03 Dec 2022 05:40:36 -0800 (PST)
Received: from airbuntu (host86-130-134-87.range86-130.btcentralplus.com. [86.130.134.87])
        by smtp.gmail.com with ESMTPSA id d10-20020adffbca000000b002366f9bd717sm11499462wrs.45.2022.12.03.05.40.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Dec 2022 05:40:35 -0800 (PST)
Date:   Sat, 3 Dec 2022 13:40:34 +0000
From:   Qais Yousef <qyousef@layalina.io>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Xuewen Yan <xuewen.yan94@gmail.com>, Wei Wang <wvw@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Jonathan JMChen <Jonathan.JMChen@mediatek.com>,
        Hank <han.lin@mediatek.com>, Paul Bone <pbone@mozilla.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH v2] Documentation: sched: Add a new sched-util-clamp.rst
Message-ID: <20221203134034.ufctoyx2w7mito6j@airbuntu>
References: <20221127142657.1649347-1-qyousef@layalina.io>
 <6beb978b-a881-e420-8baa-389473f4235a@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6beb978b-a881-e420-8baa-389473f4235a@arm.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lukasz

On 11/29/22 10:32, Lukasz Luba wrote:
> Hi Qais,
> 
> I have a few comments below. IMO this documentation
> is also for user-space developers who might be missing
> some specific 'know how'.

Thanks for having a look!

> 
> On 11/27/22 14:26, Qais Yousef wrote:
> > The new util clamp feature needs a document explaining what it is and
> > how to use it. The new document hopefully covers everything one needs to
> > know about uclamp.
> > 
> > Signed-off-by: Qais Yousef <qais.yousef@arm.com>
> > Signed-off-by: Qais Yousef (Google) <qyousef@layalina.io>
> > ---
> > 
> > Changes in v2:
> > 
> > 	* Address various style comments from Bagas
> > 
> >   Documentation/scheduler/index.rst            |   1 +
> >   Documentation/scheduler/sched-util-clamp.rst | 732 +++++++++++++++++++
> >   2 files changed, 733 insertions(+)
> >   create mode 100644 Documentation/scheduler/sched-util-clamp.rst
> > 
> > diff --git a/Documentation/scheduler/index.rst b/Documentation/scheduler/index.rst
> > index b430d856056a..f12d0d06de3a 100644
> > --- a/Documentation/scheduler/index.rst
> > +++ b/Documentation/scheduler/index.rst
> > @@ -15,6 +15,7 @@ Linux Scheduler
> >       sched-capacity
> >       sched-energy
> >       schedutil
> > +    sched-util-clamp
> >       sched-nice-design
> >       sched-rt-group
> >       sched-stats
> > diff --git a/Documentation/scheduler/sched-util-clamp.rst b/Documentation/scheduler/sched-util-clamp.rst
> > new file mode 100644
> > index 000000000000..da1881e293c3
> > --- /dev/null
> > +++ b/Documentation/scheduler/sched-util-clamp.rst
> > @@ -0,0 +1,732 @@
> > +====================
> > +Utilization Clamping
> > +====================
> > +
> > +1.  Introduction
> > +================
> > +
> > +Utilization clamping is a scheduler feature that allows user space to help in
> > +managing the performance requirement of tasks. It was introduced in v5.3
> > +release. The CGroup support was merged in v5.4.
> > +
> > +It is often referred to as util clamp and uclamp. You'll find all variations
> > +used interchangeably in this documentation and in the source code.
> > +
> > +Uclamp is a hinting mechanism that allows the scheduler to understand the
> > +performance requirements and restrictions of the tasks. Hence help it make
> > +a better placement decision. And when schedutil cpufreq governor is used, util
> > +clamp will influence the frequency selection as well.
> 
> s/the frequency/the CPU frequency/

Done.

> 
> [snip]
> 
> > +
> > +Another example is in Android where tasks are classified as background,
> > +foreground, top-app, etc. Util clamp can be used to constraint how much
> > +resources background tasks are consuming by capping the performance point they
> > +can run at. This constraint helps reserve resources for important tasks, like
> > +the ones belonging to the currently active app (top-app group). Beside this
> > +helps in limiting how much power they consume. This can be more obvious in
> > +heterogeneous systems; the constraint will help bias the background tasks to
> 
> I would add some explenation here, since you then reffer to the
> 'little cores' or 'big cores'.
> 
> s/heterogeneous systems/ heterogeneous systems (e.g. Arm big.LITTLE)/

Done.

> 
> > +stay on the little cores which will ensure that:
> 
> s/the little cores/the LITTLE cores (CPUs with capacity < 1024)/

From Bagas comments previousluy, I think I'll keep 'little' all small letters.

> 
> > +
> > +        1. The big cores are free to run top-app tasks immediately. top-app
> 
> s/the big cores/the big cores (CPUs with capacity = 1024)

I added this note to define little and big cores after the bullet points

.. note::
  little cores: CPUs with capacity < 1024
  big cores: CPUs with capacity = 1024

> 
> > +           tasks are the tasks the user is currently interacting with, hence
> > +           the most important tasks in the system.
> > +        2. They don't run on a power hungry core and drain battery even if they
> > +           are CPU intensive tasks.
> > +
> > +By making these uclamp performance requests, or rather hints, user space can
> > +ensure system resources are used optimally to deliver the best user experience
> > +the system is capable of.
> > +
> > +Another use case is to help with overcoming the ramp up latency inherit in how
> > +scheduler utilization signal is calculated.
> 
> I would emphasize this section somehow, since this is very important.
> Maybe a section header?
> 
> 'Overcoming the utilization ramp up latency'

Hmm. A new section seems misplaced here without having to restructure the doc.

How about if I make the statement starting from 'overcoming the ramp up..' all
in bold? That should make it stand out enough hopefully?

> 
> > +
> > +A busy task for instance that requires to run at maximum performance point will
> > +suffer a delay of ~200ms (PELT HALFIFE = 32ms) for the scheduler to realize
> > +that. This is known to affect workloads like gaming on mobile devices where
> > +frames will drop due to slow response time to select the higher frequency
> > +required for the tasks to finish their work in time.
> 
> This example is good. You can add that this issue should go away when
> uclamp_min is set for such thread just after it's created by the
> developer.

Okay. I added:

  Setting UCLAMP_MIN=1024 will ensure such tasks will always see the highest
  performance level when they start running.

> 
> I would add another example, with a latency sensitive task e.g.
> garbage collector thread. Such task tries to keep the memory in a
> healthy state. This kind of task might benefit from running
> on higher performance CPU even if its real utilization might be
> small (e.g. 50 util) and considered to fit on the LITTLE CPU.

Paul has actually raised an opposite use case for garbage collector. Paul
wanted to use UCLAMP_MAX to cap them.

I'm wary of mentioning latency_sensitive here since we have latency_nice and
other definitions of latency. Would be simpler to keep it as is? I do expand
more in the How to use uclamp section.

> 
> [snip]
> 
> > +Since the goal of util clamp is to allow requesting a minimum and maximum
> > +performance point for a task to run on, it must be able to influence the
> > +frequency selection as well as task placement to be most effective. Both of
> > +which have implications on the utilization value at rq level, which brings us
> > +to the main design challenge.
> 
> s/rq/CPU runqueue (rq)/

Done.

> 
> [snip]
> 
> > +3.1  Per task interface
> > +-----------------------
> > +
> > +sched_setattr() syscall was extended to accept two new fields:
> > +
> > +* sched_util_min: requests the minimum performance point the system should run
> > +                  at when this task is running. Or lower performance bound.
> > +* sched_util_max: requests the maximum performance point the system should run
> > +                  at when this task is running. Or upper performance bound.
> > +
> > +For example:
> > +
> > +.. code-block:: c
> > +
> > +        attr->sched_util_min = 40% * 1024;
> > +        attr->sched_util_max = 80% * 1024;
> > +
> > +Will tell the system that when task @p is running, it should try its best to
> > +ensure it starts at a performance point no less than 40% of maximum system's
> > +capability.
> 
> I would emphasize this, since this is very imporant IMO.
> The maximum system's capability is ment to be the fastest and most
> performant CPU in the SoC (aka the biggest CPU).

Making it bold is good enough emphasis?

> 
> [snip]
> 
> > +
> > +3.3.2  sched_util_clamp_max
> > +---------------------------
> > +
> > +System wide limit of allowed UCLAMP_MAX range. By default set to 1024, which
> > +means tasks are allowed to reach an effective UCLAMP_MAX value in the range of
> > +[0:1024].
> > +
> > +By changing it to 512 for example the effective allowed range reduces to
> > +[0:512]. The visible impact of this is that no task can run above 512, which in
> > +return means that all rqs are restricted too. IOW, the whole system is capped
> > +to half its performance capacity.
> > +
> > +This is useful to restrict the overall maximum performance point of the system.
> > +
> > +Can be handy to limit performance when running low on battery.
> 
> Or when the system knows that it can spent more time on computations
> because the user is not using the device but updates and re-compilations
> are done in background while the screen is idle.

I appended this:

  when the system wants to limit access to more energy hungry performance
  levels when it's in idle state or screen is off

Good enough?

> 
> 
> [snip]
> 
> > +
> > +On heterogeneous systems, it might be important for this task to run on
> > +a bigger CPU.
> > +
> > +Generally it is advised to perceive the input as performance level or point
> > +which will imply both task placement and frequency selection.
> 
> s/frequency/ CPU frequency/
> 
> BTW this sentence is really good. Maybe it could be somewhere in a
> header (1. Introduction)?

Made it bold, good enough?

I do say in the introduction that the right way to view util clamp as
a mechanism to make request or hint on performance constraints.

> 
> 
> [snip]
> 
> > +
> > +Combing with issue described in 5.2, this an lead to unwanted frequency spikes
> 
> s/an/can/

Done.

> 
> > +when severely capped tasks share the rq with a small non capped task.
> 
> s/capped/restricted ?

Is there something wrong with capping? I'd like to introduce this word as a way
to describe the behavior too.

> 
> > +
> > +As an example if task p
> > +
> > +.. code-block:: c
> > +
> > +        p0->util_avg = 300
> > +        p0->uclamp[UCLAMP_MAX] = 0
> > +
> > +wakes up on an idle CPU, then it will run at min frequency this CPU is capable
> > +of.
> 
> This example description assumes some 'know how' from the reader ;)

It is intended for kernel developers as we describe internal details here. If
a userspace reader reading this, I think what matters is that max aggregation
could mean they don't always get the power savings they expect.

> Let's try to elaborate a bit this (please correct me if I made a mistake
> somewhere here, since this is tricky).
> 
> 'wakes up on an idle CPU, then it will run at min frequency (Fmin) this
> CPU is capable of. The max CPU frequency (Fmax) matter here as well,
> since it designates the shortest computational time to finish the task's
> work. We are assuming the max capacity of the CPU is 1024.'

We are not assuming anything about the capacity of the CPU. This is true for
any CPU. The ratio of Fmax/Fmin will define how long its runtime will be
stretched by.

Incorporated your comments except for the assumption part. Please let me know
if I'm misunderstanding something you're inferring here :)

> 
> > +
> > +.. code-block:: c
> > +
> > +        rq->uclamp[UCLAMP_MAX] = 0
> > +
> > +If the ratio of Fmax/Fmin is 3, then
> > +
> > +.. code-block:: c
> > +
> > +        300 * (Fmax/Fmin) = 900
> > +
> > +Which indicates the CPU will still see idle time since 900 is < 1024. The
> > +_actual_ util_avg will NOT be 900 though. It will be higher than 300, but won't
> > +approach 900. As long as there's idle time, p->util_avg updates will be off by
> > +a some margin, but not proportional to Fmax/Fmin.
> > +
> > +.. code-block:: c
> > +
> > +        p0->util_avg = 300 + small_error
> > +
> > +Now if the ratio of Fmax/Fmin is 4, then
> > +
> > +.. code-block:: c
> > +
> > +        300 * (Fmax/Fmin) = 1200
> > +
> > +which is higher than 1024 and indicates that the CPU has no idle time. When
> > +this happens, then the _actual_ util_avg will become 1024.
> 
> Could we say this differently?

The target audience here is kernel developers. Do you think it's confusing for
them too? I tried to make it less wordy to help them understand the problem.

Happy to reword it for sure, but first I want to make sure you think existing
wording is not good enough for the intended target audience.

> Something with the CPU capacity levels, e.g.
> 
> If Fmax/Fmin is 3 and max CPU capacity is 1024, then
> min CPU capacity is 1024/3 = 341.
> 
> So a task 'p' w/ util=300 would fit and run OK on such
> Fmin CPU performance point (w/ capacity 341) (ignoring stollen CPU
> cycles due to IRQs, RT/DL classes or thermal).
> 
> Although, if the CPU's Fmax/Fmin is 4, then min CPU capacity
> is 1024/4 = 256
> 
> Thus, in this case the task 'p' w/ util 300 will not have
> enough cycles to finish it's periodic work. Therefore, it
> will continue the compuation and would be 'seen' as a 'busy loop'.
> It's utilization would grow to 1024 unfortunately on such
> low CPU's performance point.
> 
> 
> > +
> > +.. code-block:: c
> > +
> > +        p0->util_avg = 1024
> > +
> > +If task p1 wakes up on this CPU
> > +
> > +.. code-block:: c
> > +
> > +        p1->util_avg = 200
> > +        p1->uclamp[UCLAMP_MAX] = 1024
> > +
> > +then the effective UCLAMP_MAX for the CPU will be 1024 according to max
> > +aggregation rule. But since the capped p0 task was running and throttled
> > +severely, then the rq->util_avg will be 1024.
> > +
> > +.. code-block:: c
> > +
> > +        p0->util_avg = 1024
> > +        p1->util_avg = 200
> > +
> > +        rq->util_avg = 1024
> > +        rq->uclamp[UCLAMP_MAX] = 1024
> > +
> > +Hence lead to a frequency spike since if p0 wasn't throttled we should get
> > +
> > +.. code-block:: c
> > +
> > +        p0->util_avg = 300
> > +        p1->util_avg = 200
> > +
> > +        rq->util_avg = 500
> > +
> > +and run somewhere near mid performance point of that CPU, not the Fmax we get.
> 
> Yeah, this is a side effect that we would have to tackle...

Yep!

> 
> > +
> > +5.3  Schedutil response time issues
> > +-----------------------------------
> > +
> > +schedutil has three limitations:
> > +
> > +        1. Hardware takes non-zero time to respond to any frequency change
> > +           request. On some platforms can be in the order of few ms.
> > +        2. Non fast-switch systems require a worker deadline thread to wake up
> > +           and perform the frequency change, which adds measurable overhead.
> > +        3. schedutil rate_limit_us drops any requests during this rate_limit_us
> > +           window.
> > +
> > +If a relatively small task is doing critical job and requires a certain
> > +performance point when it wakes up and starts running, then all these
> > +limitations will prevent it from getting what it wants in the time scale it
> > +expects.
> > +
> > +This limitation is not only impactful when using uclamp, but will be more
> > +prevalent as we no longer gradually ramp up or down. We could easily be
> > +jumping between frequencies depending on the order tasks wake up, and their
> > +respective uclamp values.
> > +
> > +We regard that as a limitation of the capabilities of the underlying system
> > +itself.
> > +
> > +There is room to improve the behavior of schedutil rate_limit_us, but not much
> > +to be done for 1 or 2. They are considered hard limitations of the system.
> 
> Good job, this is a very useful doc. I hope user-space folks would
> benefit from it as well.

I hope so too!

Thanks a lot for having a look Lukasz! I should have incorporated most of your
suggestions. Asked for clarifications in few places only.


Cheers

--
Qais Yousef
