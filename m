Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E804C72E742
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 17:33:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241448AbjFMPdL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 11:33:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239886AbjFMPdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 11:33:09 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B2D3122
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 08:33:07 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id 3f1490d57ef6-bd5f59fb71dso412246276.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 08:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1686670386; x=1689262386;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RwPB2yv31/OTXSK4kBU8MDAo6vvPqr0X4gu8W8e2EAs=;
        b=Dz2joBUtQbqCwbTeRQ4v7DiCDtYpO8ChroBAlDW1okTymPy6MrLc755ToYw9uQm68s
         PogamiPb4pmtU2PYRVTOtW0vAKbnvQw7nyBUNJc1TPLSHiHJ3X2Ch7D3AuhjHlehU7sE
         V/pY3BcPh5WOdKHsv/5h6TgNvMRtC0rC+WKgY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686670386; x=1689262386;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RwPB2yv31/OTXSK4kBU8MDAo6vvPqr0X4gu8W8e2EAs=;
        b=TmJDHHI48nsvJxzGXHEWW4EZ4INpuHO+2MPSddgxmbAuBC5gjvRvASb6Hnm/WO8Okp
         0kGXrQknAHG9exdWSNp14t3cFlZbq42RCHNOFKrYf0MgaJ2R3o7ahkOaMQc60HqSXmh8
         36Hhvx850IsSkmopXpuoQ98+3cjxhFPE8OA2J/lHNrM9zn7C6hAXl/U7//upH9GpoG/t
         6xvvSeX64sC/gA3maCR85KWcssWl/aBiaqcleAm6fHHCzXJepV/YYdQe6c7AiM5epVLM
         t91IAp8q85KRXLzkN2xMwqwKdsCc4RXHz1DM8dIgHQIRvdPtH9ee6wDHvz2gtDfEKsLz
         mwJw==
X-Gm-Message-State: AC+VfDxJCw2bJ5FRo6Fe7cZHjU2QTBb+7USgJ2i+2rEq9FEVHUNDjvCb
        rVOQy4dDTHBvu7Aq5voZstGihwGPzsXsVPoT66KomA==
X-Google-Smtp-Source: ACHHUZ6u+6NaWR2JVKx7DBTOw59JCx4HK64Bq6eauCdav13XarTYDhNWK+DsA0Dnx4i1V0adx69keVSwPJ1AXf2x/Ps=
X-Received: by 2002:a25:1d4:0:b0:bac:fdd2:18ac with SMTP id
 203-20020a2501d4000000b00bacfdd218acmr1530717ybb.58.1686670386144; Tue, 13
 Jun 2023 08:33:06 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1686239016.git.bristot@kernel.org> <bd9977efff8cc3e002c4b2db02f611167905a99f.1686239016.git.bristot@kernel.org>
 <CAEXW_YT0DmvQo_gfCq5uzpZpf36HmfzXozo9+=sYJp-hZx4qTQ@mail.gmail.com>
 <b2cd0072-d226-4adb-ddf5-958d9635f881@kernel.org> <CAEXW_YR9Tfw5KyFU7TQtYE02k+DpaMXH=osx9Ws5w_j1YpHxhg@mail.gmail.com>
 <841849b5-1f9c-4f0e-2de8-1da278256888@kernel.org>
In-Reply-To: <841849b5-1f9c-4f0e-2de8-1da278256888@kernel.org>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Tue, 13 Jun 2023 11:32:55 -0400
Message-ID: <CAEXW_YQ7vEakRcJgva_PYEnsj4ZLafH-pXQiJ5STCkM7dQAttg@mail.gmail.com>
Subject: Re: [RFC PATCH V3 6/6] sched/fair: Implement starvation monitor
To:     Daniel Bristot de Oliveira <bristot@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org,
        Luca Abeni <luca.abeni@santannapisa.it>,
        Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vineeth Pillai <vineeth@bitbyteword.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 13, 2023 at 9:43=E2=80=AFAM Daniel Bristot de Oliveira
<bristot@kernel.org> wrote:
[...]
> > On Mon, Jun 12, 2023 at 1:21=E2=80=AFPM Daniel Bristot de Oliveira
> > <bristot@kernel.org> wrote:
> > [...]
> >>> On Thu, Jun 8, 2023 at 11:58=E2=80=AFAM Daniel Bristot de Oliveira
> >>> <bristot@kernel.org> wrote:
> >>>>
> >>>> From: Juri Lelli <juri.lelli@redhat.com>
> >>>>
> >>>> Starting deadline server for lower priority classes right away when
> >>>> first task is enqueued might break guarantees, as tasks belonging to
> >>>> intermediate priority classes could be uselessly preempted. E.g., a =
well
> >>>> behaving (non hog) FIFO task can be preempted by NORMAL tasks even i=
f
> >>>> there are still CPU cycles available for NORMAL tasks to run, as the=
y'll
> >>>> be running inside the fair deadline server for some period of time.
> >>>>
> >>>> To prevent this issue, implement a starvation monitor mechanism that
> >>>> starts the deadline server only if a (fair in this case) task hasn't
> >>>> been scheduled for some interval of time after it has been enqueued.
> >>>> Use pick/put functions to manage starvation monitor status.
> >>>
> >>> Me and Vineeth were discussing that another way of resolving this
> >>> issue is to use a DL-server for RT as well, and then using a smaller
> >>> deadline  for RT. That way the RT is more likely to be selected due t=
o
> >>> its earlier deadline/period.
> >>
> >> It would not be that different from what we have now.
> >>
> >> One of the problems of throttling nowadays is that it accounts for a l=
arge window
> >> of time, and any "imprecision" can cause the mechanism not to work as =
expected.
> >>
> >> For example, we work on a fully-isolated CPU scenario, where some very=
 sporadic
> >> workload can be placed on the isolated CPU because of per-cpu kernel a=
ctivities,
> >> e.g., kworkers... We need to let them run, but for a minimal amount of=
 time, for
> >> instance, 20 us, to bound the interference.
> >>
> >> The current mechanism does not give this precision because the IRQ acc=
ounting
> >> does not account for runtime for the rt throttling (which makes sense)=
.
> >
> > I lost you here, "Runtime for the rt throttling" does not make much
> > sense to me as a statement.
>
> Both update_curr_rt() and update_curr_dl() use rq_clock_task() as clock. =
update_rq_clock_task()
> reduces the irq_delta from task's clock (inside #ifdef CONFIG_IRQ_TIME_AC=
COUNTING), and this
> clock is used to throttling.

That was a much better description. You're basically saying that since
the running time of the RT class is not accounted for in the clock, it
affects the throttling and unthrottling times. I actually ran into a
similar issue on Android I recall, where the RT time was showing up as
CFS load if I recall.

For RT throttling though, in our testing the time scales are large
enough (for our usecase) that such time stealing wasn't an issue. I am
going for something that is practical and that works, does not have to
be perfect since it has been several years now with these problems and
leaving RT throttling broken is probably not a good thing.

> >> So the
> >> RT throttling has the 20 us stolen from IRQs and keeps running. The sa=
me will
> >> happen if we swap the current mechanism with a DL server for the RT.
> >
> > I read this about 10 times to learn that *maybe* you mean that IRQs
> > stole time from the "Well behaved running time" of the RT class.
>
> I also read emails many times :-)

Not a problem, ;-) Hopefully my emails are not too painful to read too
many times, but I appreciate that ;-). I was just mentioning that if
you're (or I am) not precise then it's hard to follow what you mean
that's all. Really the person writing the best emails I've seen is
Paul McKenney and that's kind of what I strive for. YMMV.

> > not seeing how that is related to creation of a DL-server for the RT
> > class. Maybe describe your point a bit more clearly?
>
> This patch is targeting a better way to avoid SCHED_OTHER starvation.
> Having a DL server for RT class does not help on that. We need to boost
> SCHED_OTHER.

Oh, actually the problem of boosting SCHED_OTHER is a bit orthogonal
to what I said. I was not saying not to boost SCHED_OTHER, I was
talking more about this particular patch and using an DL-based RT
server to mitigate that issue. The boosting is already handled in
previous patches with the DL-server.

> >> Also, thinking about short deadlines to fake a fixed priority is... no=
t starting
> >> well. A fixed-priority higher instance is not a property of a deadline=
-based
> >> scheduler, and Linux has a fixed-priority hierarchy: STOP -> DL -> RT =
-> CFS...
> >> It is simple, and that is good.
> >>
> >> That is why it is better to boost CFS instead of throttling RT. By boo=
sting
> >> CFS, you do not need a server for RT, and we account for anything on t=
op of CFS
> >> for free (IRQ/DL/FIFO...).
> >
> > I did mention in my last email that it is not ideal. I just brought it
> > up as an option. It might reduce the problem being seen and is better
> > than not having it.
>
> We have thought about it, but boosting SCHED_OTHER is the way to go.

As mentioned above, there is no argument from my side on boosting CFS.
That I agree is the goal.

> >>> Another approach could be to implement the 0-laxity scheduling as a
> >>> general SCHED_DEADLINE feature, perhaps through a flag. And allow DL
> >>> tasks to opt-in to 0-laxity scheduling unless there are idle cycles.
> >>> And then opt-in the feature for the CFS deadline server task.
> >>
> >> A 0-laxity scheduler is not as simple as it sounds, as the priority al=
so depends
> >> on the "C" (runtime, generally WCET), which is hard to find and embeds
> >> pessimism. Also, having such a feature would make other mechanisms har=
der, as
> >> well as debugging things. For example, proxy-execution or a more preci=
se
> >> schedulability test...
> >
> > I think you did not read my email properly, I was saying make the
> > 0-laxity default-off and the opt-in for certain DL tasks. That may
> > work perfectly well for a system like ChromeOS where likely we will
> > use the DL server as the sole deadline task and opt-in for the
> > 0-laxity. Then we don't need watchdog hacks at all and it all cleanly
> > works within the DL class itself. There are the drawbacks of the
> > pessimism/locking  etc (I already knew that by the way as the obvious
> > drawbacks of 0-laxity) but I am not immediately seeing how this
> > CFS-watchdog with 0-laxity is any different from the DL-server itself
> > having such a property. If you really have a concrete point on why
> > that won't work, and if you could clarify that more clearly why a
> > watchdog is better than it, that would be great.
>
>
> I think you are overloading a term and a goal, and this makes your
> thoughts ambiguous.

Well the term was mentioned in this series cover letter as well. ;-)

> 0-laxity is a point in time. What do you want to do at 0-laxity? Do you
> want to run or start/replenish?

You could do either. It could be run a bit earlier than 0-laxity. Or
could you just push it out to run in the next period if it has the
flag.

Here is the definition of 0-laxity as I understand it. Please correct
me as I have not done a phD in these things like you ;-)

Laxity, also known as slack time, is the amount of time that a task
can be delayed without causing a missed deadline. A 0-laxity task is
one that has no more time to spare and must be executed immediately to
avoid missing its deadline.

And here's where I need your input: If we take all admitted DL tasks
and run it at their respective 0-laxity times or slightly earlier,
then in-theory, they should all meet their deadlines correctly?

Now, I don't really mean to run it exactly at 0-laxity. It could be
run a bit earlier to factor in sleep times, locking time, preemptions
etc. I mean with SCHED_DEADLINE, you really can't control those things
anyway -- so even if  you run the DL task as soon as possible, you
might still miss your deadline. Or at 0-laxity, push its deadline out
to the next period and consider it "activated". I am just thinking out
loud.

That could break EDF the way it is now. However, it could be an
interesting idea that could be developed into a better idea.  A DL
task does not have to run immediately to meet its deadline (it could
be run later as well) and that I know for a fact -- so why not add
this flexibility within SCHED_DEADLINE itself rather than inventing a
hack (and by hack I mean only this patch, not the other patches from
Peter or the idea of CFS boosting).

My impression is the other (DL tasks without flag) should still have
their promised bandwidth so it is not mixing 2 schedulers.  If this
series gets stalled for some reason, I would probably explore such an
idea in my own time later.

> In the previous discussions, we mentioned using a scheduler that uses
> it as a way to prioritize the task (to run). That is an overkill, as
> it would be another scheduler. That is the first interpretation for
> 0-laxity in this thread, mainly associated with the word "scheduling"
> (not only I read that way).
>
> In this patch, Juri's PoC shows that if we defer the DL server start
> (replenish) for a point in the future, we can keep the fixed-priority
> order of the schedulers, boosting SCHED_OTHER if it starves,
> without breaking EDF.
>
> If you see the cover, I mentioned using the 0-laxity point in time to
> activate the DL server under EDF. In that way, at the 0-laxity point,
> the DL server is replenished with runtime and deadline as
> "now" + period. With that implemented...
>
> In the base case:
>   it is never activated.
>
> In the Busy-loop FIFO case:
>  Busy-loop FIFO task run starving OTHER for (period - runtime):
>    SCHED_OTHER server will be started at 0-laxity and get the
>    processor for its runtime immediately because there are no DL
>    tasks.
>
> In the presence of DL & RT tasks:
>  DL and RT Starving OTHER for (period - runtime):
>    SCHED_OTHER server will be started & scheduled under EDF, before or
>    after the other DL tasks, following EDF. Anyways, before
>    returning to the SCHED_RT.
>
> So, in this way, the OTHER will be boosted over SCHED_RT without breaking
> SCHED_DEADLINE tasks.
>
> In an 0-laxity scheduler, the server would run at 0-laxity, jumping in
> front of DL tasks... that would break EDF. It would be mixing two
> schedulers in one. It is not required and likely not a good idea either.

I am still missing why some tasks cannot be run at close to 0-laxity
time, and as opt-in. And if the DL-server is the sole task running,
then there's nothing else to break.

In fact, I am not immediately seeing how this can break SCHED_DEADLINE
if you allow at most 1-task to run at close to 0-laxity. The others
should still have their promised bandwidth so it is not mixing 2
schedulers, you just delay the DL-server till it's close to the
0-laxity. What am I missing?

Perhaps you mean the algorithm needs to push the new period/deadline
to a later time at the 0-laxity. That's also fine with me. But some
variation of the idea is possible AFAICS (again could be missing
something that mathematically makes this impossible).

> In the cover, I mentioned improving this patch, so maybe watchdog is not
> the appropriate name. 0-laxity server is not a good name either because
> it might induce people to think that the server will RUN at 0-laxity
> while it will actually be replenished at 0-laxity. Maybe a deferred serve=
r
> might be a better name.

Yeah maybe a deferred server could be a better name.

> >> In a paper, the scheduler alone is the solution. In real life, the sol=
ution
> >> for problems like locking is as fundamental as the scheduler. We need =
to keep
> >> things simple to expand on these other topics as well.
> >>
> >> So, I do not think we need all the drawbacks of a mixed solution to ju=
st fix
> >> the throttling problem, and EDF is more capable and explored for the
> >> general case.
> >
> > Again, I was saying making it opt-in seems like a reasonable approach
> > and just enabling such property for the DL server.
>
> Can we have a "deferred DL server?" is that your question?
>
> If so, I think so. But we have other points to look first. DL servers are=
 per-cpu,
> so they break global. We need to think about an interface... and there ar=
e
> other points that we need to understand before trying some other more
> optimized cases.

You mean an interface for the DL server params? Those can be similar
to other sched knobs. And then boot with a CONFIG option and boost CFS
things by default if RT is active. Would that work or did you mean
something else by interface?

> >>> Lastly, if the goal is to remove RT throttling code eventually, are
> >>> you also planning to remove RT group scheduling as well? Are there
> >>> users of RT group scheduling that might be impacted? On the other
> >>> hand, RT throttling / group scheduling code can be left as it is
> >>> (perhaps documenting it as deprecated) and the server stuff can be
> >>> implemented via a CONFIG option.
> >>
> >> I think that the idea is to have the DL servers eventually replace the=
 group
> >> schedule. But I also believe that it is better to start by solving the
> >> throttling and then moving to other constructions on top of the mechan=
ism.
> >
> > Hmm. For throttling at the root level yes, but  I am not seeing how
> > you can replace the group scheduling code for existing users of RT
> > Cgroups with this. The throttling in the RT group scheduling code is
> > not exactly only about "not starving CFS", it is more related to
> > letting RT groups run with certain bandwidth. So you cannot really
> > delete it if there are real users of that code -- you'll have to
> > migrate those users away first (to an alternate implementation like
> > DL).  If there are no users of RT group scheduling, that's lovely
> > though. We don't use it in ChromeOS fwiw.
>
> The idea behind the base patchset from Peter is solid and is the best way=
 we
> can start, and starting with avoiding OTHER starvation is an easy startin=
g point.
> Many people will benefit from it - like all the people that ping me
> because of the RT_RUNTIME_GREED (including Google in the past)... which i=
s
> the starting point of all this work.

Right, you know I am on the same page about that. I presented exactly
the same stuff at 2 conferences in 2 countries this year.

>
> Generalizing it requires time, but it will happen... and you know that Ju=
ri and I
> care about Chromeos' use case, as I have been discussing this with you al=
l and
> even participating in Google/chrome focused meetings about sched...
> at 6 pm our time ;-).

I totally appreciate that, please don't get offended, we go a long way
back as friends ;-) And I really want to help, I am not trying to
prove I am an expert compared to you. I just want to get it *done* and
not have to wait for more years. You can see my 2 presentations this
year on this topic alone -- I travelled to 2 countries leaving my
family behind to discuss these.

Many thanks,

 - Joel
