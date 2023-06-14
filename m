Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3CB7730752
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 20:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233341AbjFNSZT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 14:25:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230321AbjFNSZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 14:25:15 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 922CB171F
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 11:25:13 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2b344476313so14704661fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 11:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1686767112; x=1689359112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rw4Mbru2d9tLetsrkBreIOHJxLP6wn37Spa7xykF6sM=;
        b=sph7ZaMEQppSYjz8c+cIOGPB+ZtzNaY+xoSqyzZzHY9z7ELJhjX3mOTGyROG/6u+Zp
         tpM3TxkD2wKb28bZSyTuT9FLbXFpGkhEGXBvJ9yPNmom0M6QS8NPhJNOxiyb+0smrErw
         KLlZM2SrtxpZGjG7BG6/2EG/9VUYoDdcvjll8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686767112; x=1689359112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rw4Mbru2d9tLetsrkBreIOHJxLP6wn37Spa7xykF6sM=;
        b=NFy+xRXm5qeUbitM57BBTf/RIMgagEhQqVfC+iU8DTL8e/7tSN3UIDmmKbXqt6H5Yc
         t5iK1jaMOh8Oe6yUHur2sXYj7g679TZgIEPPOiXxRUI4HLDAddjlLObqcu04CSigrhL1
         FmczpPtPwkaqD8rEZU2d3UMThkf8Istrdoi7UrmsCDtWc2rfXAhHe9FolLMzpFVauugp
         C+9dpWwPS82ofTgmUc7EWEmKKE/ROjp3ATOCbQp8zMWEwrYBBxXD1RKFG/oM88ElVcAH
         v/ieJTDNnlxGpT/6ahkFGDF1QUg306DOoJRb0enjTAVgan+evqUpaLqUkMiPT4wiYM21
         gLng==
X-Gm-Message-State: AC+VfDx4LjHR596/l/y0+A7VaedF9cJwkE+Rj+aMq0yd7emKz7J4yGdM
        0lMNUxtJ9nxQVoEOG2Z+/Cn1uFY89bVpFWPpD7+55Q==
X-Google-Smtp-Source: ACHHUZ41qUOu0k6GiC5aH5VsRSs7qcQrg0sUEXw5nlpan0hUbGggsVXSixFsCJt8ZPoMoRst3GVwSu3Pe2FKyqFPkK4=
X-Received: by 2002:a2e:360e:0:b0:2b1:a8bb:978f with SMTP id
 d14-20020a2e360e000000b002b1a8bb978fmr7467627lja.9.1686767111434; Wed, 14 Jun
 2023 11:25:11 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1686239016.git.bristot@kernel.org> <bd9977efff8cc3e002c4b2db02f611167905a99f.1686239016.git.bristot@kernel.org>
 <CAEXW_YT0DmvQo_gfCq5uzpZpf36HmfzXozo9+=sYJp-hZx4qTQ@mail.gmail.com>
 <b2cd0072-d226-4adb-ddf5-958d9635f881@kernel.org> <CAEXW_YR9Tfw5KyFU7TQtYE02k+DpaMXH=osx9Ws5w_j1YpHxhg@mail.gmail.com>
 <841849b5-1f9c-4f0e-2de8-1da278256888@kernel.org> <CAEXW_YQ7vEakRcJgva_PYEnsj4ZLafH-pXQiJ5STCkM7dQAttg@mail.gmail.com>
 <4849295d-9aef-836f-0e5f-063e2075380a@kernel.org>
In-Reply-To: <4849295d-9aef-836f-0e5f-063e2075380a@kernel.org>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Wed, 14 Jun 2023 14:24:59 -0400
Message-ID: <CAEXW_YQ8Sv+bU=ngsV35yapSHETOBt-N+jYCCdZ-fnsLYOyP7w@mail.gmail.com>
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

Before I reply, I just want to mention: I am OK with this patch 6/6 as
such and the ideas I mentioned earlier are just alternatives just for
patch 6/6 -- just for discussion sake. The devil is in the details as
Daniel and Juri pointed out.

With that said...

On Wed, Jun 14, 2023 at 9:45=E2=80=AFAM Daniel Bristot de Oliveira
<bristot@kernel.org> wrote:
>
> On 6/13/23 17:32, Joel Fernandes wrote:
> > On Tue, Jun 13, 2023 at 9:43=E2=80=AFAM Daniel Bristot de Oliveira
> > <bristot@kernel.org> wrote:
> > [...]
> >>> On Mon, Jun 12, 2023 at 1:21=E2=80=AFPM Daniel Bristot de Oliveira
> >>> <bristot@kernel.org> wrote:
> >>> [...]
> >>>>> On Thu, Jun 8, 2023 at 11:58=E2=80=AFAM Daniel Bristot de Oliveira
> >>>>> <bristot@kernel.org> wrote:
> >>>>>>
> >>>>>> From: Juri Lelli <juri.lelli@redhat.com>
> >>>>>>
> >>>>>> Starting deadline server for lower priority classes right away whe=
n
> >>>>>> first task is enqueued might break guarantees, as tasks belonging =
to
> >>>>>> intermediate priority classes could be uselessly preempted. E.g., =
a well
> >>>>>> behaving (non hog) FIFO task can be preempted by NORMAL tasks even=
 if
> >>>>>> there are still CPU cycles available for NORMAL tasks to run, as t=
hey'll
> >>>>>> be running inside the fair deadline server for some period of time=
.
> >>>>>>
> >>>>>> To prevent this issue, implement a starvation monitor mechanism th=
at
> >>>>>> starts the deadline server only if a (fair in this case) task hasn=
't
> >>>>>> been scheduled for some interval of time after it has been enqueue=
d.
> >>>>>> Use pick/put functions to manage starvation monitor status.
> >>>>>
> >>>>> Me and Vineeth were discussing that another way of resolving this
> >>>>> issue is to use a DL-server for RT as well, and then using a smalle=
r
> >>>>> deadline  for RT. That way the RT is more likely to be selected due=
 to
> >>>>> its earlier deadline/period.
> >>>>
> >>>> It would not be that different from what we have now.
> >>>>
> >>>> One of the problems of throttling nowadays is that it accounts for a=
 large window
> >>>> of time, and any "imprecision" can cause the mechanism not to work a=
s expected.
> >>>>
> >>>> For example, we work on a fully-isolated CPU scenario, where some ve=
ry sporadic
> >>>> workload can be placed on the isolated CPU because of per-cpu kernel=
 activities,
> >>>> e.g., kworkers... We need to let them run, but for a minimal amount =
of time, for
> >>>> instance, 20 us, to bound the interference.
> >>>>
> >>>> The current mechanism does not give this precision because the IRQ a=
ccounting
> >>>> does not account for runtime for the rt throttling (which makes sens=
e).
> >>>
> >>> I lost you here, "Runtime for the rt throttling" does not make much
> >>> sense to me as a statement.
> >>
> >> Both update_curr_rt() and update_curr_dl() use rq_clock_task() as cloc=
k. update_rq_clock_task()
> >> reduces the irq_delta from task's clock (inside #ifdef CONFIG_IRQ_TIME=
_ACCOUNTING), and this
> >> clock is used to throttling.
> >
> > That was a much better description. You're basically saying that since
> > the running time of the RT class is not accounted for in the clock, it
> > affects the throttling and unthrottling times. I actually ran into a
> > similar issue on Android I recall, where the RT time was showing up as
> > CFS load if I recall.
> >
> > For RT throttling though, in our testing the time scales are large
> > enough (for our usecase) that such time stealing wasn't an issue. I am
> > going for something that is practical and that works, does not have to
> > be perfect since it has been several years now with these problems and
> > leaving RT throttling broken is probably not a good thing.
>
> By postponing the enqueue/replanishment of the DL server here, we are fix=
ing the
> problem in a practical way, that works without breaking existing useful p=
roperties &
> use-cases.

Ok, that sounds good to me.

> [...]
> >>> not seeing how that is related to creation of a DL-server for the RT
> >>> class. Maybe describe your point a bit more clearly?
> >>
> >> This patch is targeting a better way to avoid SCHED_OTHER starvation.
> >> Having a DL server for RT class does not help on that. We need to boos=
t
> >> SCHED_OTHER.
> >
> > Oh, actually the problem of boosting SCHED_OTHER is a bit orthogonal
> > to what I said. I was not saying not to boost SCHED_OTHER, I was
> > talking more about this particular patch and using an DL-based RT
> > server to mitigate that issue. The boosting is already handled in
> > previous patches with the DL-server.
>
> The boosting of the previous patch is breaking FIFO priority. This patch =
fixes that
> single point without touching and or breaking SCHED_DEADLINE/EDF properti=
es. With
> these things in place we do not mitigate, we fix the problem.

Sure, that's fine with me.

[..]
> > could you just push it out to run in the next period if it has the
> > flag.
>
> The improvements on top of this patch is to postpone the enqueue/replenis=
h to the 0-laxity
> time. By doing so, the task receives a new period (and so deadline) a per=
iod ahead.

Yes, I understand. I was hoping for us to do that from within the DL
class itself as a DL task property, but perhaps that's my wishful
thinking...

> >
> > Here is the definition of 0-laxity as I understand it. Please correct
> > me as I have not done a phD in these things like you ;-)
> >
> > Laxity, also known as slack time,
>
> laxity =3D absolute deadline - activation time - runtime.

Correct.

> is the amount of time that a task
> > can be delayed without causing a missed deadline.
>
> If you look at the task alone! e.g, if it does not face preemption!
> A 0-laxity task is
> > one that has no more time to spare and must be executed immediately
>
> and not be preempted!
>
> to
> > avoid missing its deadline.
>
> Again, you are looking at the task alone.

Sure, that's why I mentioned running it before 0-laxity itself to
account for that and not just preemption but also other issues as well
like I/O, locking, sleeping etc. I don't have a formula right now and
I need to think more about it, but that was the idea at a high-level.
Again it is all rainbows and ponies and the devil is in the details so
just consider it as an idea/suggestion and not something we must
urgently do. I may find time later to go over the papers such as those
related to the laxity-based scheduling.

> > And here's where I need your input: If we take all admitted DL tasks
> > and run it at their respective 0-laxity times or slightly earlier,
> > then in-theory, they should all meet their deadlines correctly?
> For all tasksets, no!
>
> There might be a taskset here o there that creates such timeline under ED=
F,
> but it is not always true that a task under EDF will wait until the 0-lax=
ity
> time for them to run. EDF is working conserving.
>
> For a working conserving scheduler to build such a timeline, it needs to
> have no idle time. Then, lets get the classical single core assumptions
> (these servers are per-cpu).
>
> - Assuming single-core/partitioned scheduler.
> - Assuming periodic tasks with deadline =3D period
> - Assuming a task set with the sum of each task utilization =3D 1
> - Assuming all tasks are dispatched at the same time (critical instant)
> - Assuming all tasks will run for their entire runtime, without blocking
>
> (so... the thing that EDF is optimum... fully loaded...)
>
> Even so you will not have EDF always creating such timeline because the
> task with the earliest deadline will run first, still deadlines will be m=
et.
>
> For example:
>
> t1 =3D 5/10
> t2 =3D 5/10
>
> Each task you pick first will run 5 unities of time before the "0-laxity =
time".
>
> If there is a scheduler that always build a timeline like you want, it wi=
ll not
> schedule the taskset I mentioned... thus.. it will schedule less than EDF=
.

Yes, I think you are kind of saying the same thing that I mentioned,
which is to run it before the 0-laxity time (perhaps depending on the
runtime of the existing admitted tasks).

> > Perhaps you mean the algorithm needs to push the new period/deadline
> > to a later time at the 0-laxity.
>
> This is the idea behind this patch ^^^^ This is the different between run=
ning
> and replenishing I mention on previous emails.
>
> That's also fine with me. But some
> > variation of the idea is possible AFAICS (again could be missing
> > something that mathematically makes this impossible).
>
> you are looking for a fragment of the information... "0-laxity time," wit=
h
> a single task in mind - not in the context of a scheduler.

I should have probably not used the word 0-laxity, because I did
mention running *before* 0-laxity arrives to account for delays,
that's what I was saying. So like run it before you get to 0 laxity to
account for delays, like that. But hey it is just an idea and sorry if
it sounded like noise. It goes back to the premise I mentioned which
is, DL task do not need to run immediately and preempt RT, it can run
later and still meet the deadline. When to run it is a different
question but if there was a crystal ball, DL task can still meet its
deadline by running at a later time.

> >> In the cover, I mentioned improving this patch, so maybe watchdog is n=
ot
> >> the appropriate name. 0-laxity server is not a good name either becaus=
e
> >> it might induce people to think that the server will RUN at 0-laxity
> >> while it will actually be replenished at 0-laxity. Maybe a deferred se=
rver
> >> might be a better name.
> >
> > Yeah maybe a deferred server could be a better name.
> >
> >>>> In a paper, the scheduler alone is the solution. In real life, the s=
olution
> >>>> for problems like locking is as fundamental as the scheduler. We nee=
d to keep
> >>>> things simple to expand on these other topics as well.
> >>>>
> >>>> So, I do not think we need all the drawbacks of a mixed solution to =
just fix
> >>>> the throttling problem, and EDF is more capable and explored for the
> >>>> general case.
> >>>
> >>> Again, I was saying making it opt-in seems like a reasonable approach
> >>> and just enabling such property for the DL server.
> >>
> >> Can we have a "deferred DL server?" is that your question?
> >>
> >> If so, I think so. But we have other points to look first. DL servers =
are per-cpu,
> >> so they break global. We need to think about an interface... and there=
 are
> >> other points that we need to understand before trying some other more
> >> optimized cases.
> >
> > You mean an interface for the DL server params? Those can be similar
> > to other sched knobs. And then boot with a CONFIG option and boost CFS
> > things by default if RT is active. Would that work or did you mean
> > something else by interface?

About the interface, perhaps you are referring to using this mechanism
to replace the stalld daemon? That's what I remember from our
conversations in OSPM. In general, I think it is a great idea to
automatically detect "important" starving CFS tasks and boost them
(whether they are starving because of RT, or some other reason).

> >> Generalizing it requires time, but it will happen... and you know that=
 Juri and I
> >> care about Chromeos' use case, as I have been discussing this with you=
 all and
> >> even participating in Google/chrome focused meetings about sched...
> >> at 6 pm our time ;-).
> >
> > I totally appreciate that, please don't get offended, we go a long way
> > back as friends ;-)
>
> I did not get offended, and nothing changes on our friendship :-). I am j=
ust
> clarifying you things we know - even before this rebase... We are aware o=
f
> Chrome needs, as well as general RT Linux needs.
>
> The basic idea behind this patch works for all cases and is unlocking thi=
s
> situation. The code will be improved in the next version.

Thanks for the discussions! I am looking forward to helping in any way
I can on the series, I am going to be testing it for ChromeOS.

 - Joel
