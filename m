Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B03F56713E6
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 07:24:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbjARGYa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 01:24:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjARGVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 01:21:50 -0500
Received: from mail-vk1-xa2e.google.com (mail-vk1-xa2e.google.com [IPv6:2607:f8b0:4864:20::a2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60F8A31E30
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 22:10:49 -0800 (PST)
Received: by mail-vk1-xa2e.google.com with SMTP id w72so15926527vkw.7
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 22:10:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=11vO0Lv9o8nLVnGmajYi3cQZqeTyG0dHG5Fh0cL5wtM=;
        b=TFvt7vGR4A1CdmelwWbaxKi+ULuEwSWP6ozlAcVoVJYu+k6qo/qf5ZH7Nmx4HW05w1
         CwSbqzCmndI4eH0i30fCN2BtDF4vDVCQv7nEdPyb4ONfecXMXeEf9bwmfFAmw6UPYgFJ
         RpTs2xL6fpPhf48Uy8hZ/aMTuEw5RurftkQfoBaHOGIfQmPBFaJE9UOUKdMPjybpTxaV
         riNFfmChAAFd8Ig/A/yepxecxRINdNuA81su04EbDixys44VL6jDQ1RH/UYAVhDKSVNH
         HVekTsIfRg+JWjSkconBXlnErJAW8bCsoWqjnlkGPO8Vl6JF11oj0nQ+pxB78Ivk+WTD
         l6xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=11vO0Lv9o8nLVnGmajYi3cQZqeTyG0dHG5Fh0cL5wtM=;
        b=tmj1IvNNXwstQ/63kNrDVQcnu2dBWVqlOanxzj87jJD+aT2f8GtveJgn1cKVbKshwN
         2HaFCAgo4J/0AB4yeYx7H3oWi9whAjS6M2sOvQtdF7flEHN9bdvFFb/V2vzQgZFQBzrD
         JQzOLoZT5VTURstD3mFwtC/T/0eG+/sTGb68Mo9rIofgWaqcGVBtor1KN+wAmAxj3V3f
         ugPe0+9KfJ6zXkdLatRtVx3+y9qCPNUjdC3awYRMLk9lnUhbmqzi82hWpbHJaKOa/WtK
         9E+zS2mA6ocC2HJtf711cTCtiYmATQnkb09T6pykCHAvOgCk0a+dKuSGPhLyfIt+ghig
         zzpA==
X-Gm-Message-State: AFqh2krzd4oAimcS59gKTLRHxe1q7uSYJfPm/1ecXp7kXs3PIDw+6AT5
        X53e6tmRb/xxnGorzjqBAYS3jBmh/rh9v0rEx5ebm6dZm4s=
X-Google-Smtp-Source: AMrXdXu3yItewvN21DncdY9WCmLw6qmY1lHBOLt+RD0wh8FpCzxyXdzVJOySUmvTxeDrnNwSsIiyWUDzAUesMSNAgGY=
X-Received: by 2002:a05:6122:c61:b0:3da:6118:f9cd with SMTP id
 i33-20020a0561220c6100b003da6118f9cdmr820018vkr.32.1674022248203; Tue, 17 Jan
 2023 22:10:48 -0800 (PST)
MIME-Version: 1.0
References: <20230110213010.2683185-1-avagin@google.com> <20230110213010.2683185-3-avagin@google.com>
 <Y7+4S9umCo5I+Ty7@chenyu5-mobl1> <CANaxB-wcpKS64q6_0+r+OwoZupRN-A-PQvPRiVsMmEgB1TRSrw@mail.gmail.com>
 <Y8LRa/HJtZ/L2Shy@chenyu5-mobl1>
In-Reply-To: <Y8LRa/HJtZ/L2Shy@chenyu5-mobl1>
From:   Andrei Vagin <avagin@gmail.com>
Date:   Tue, 17 Jan 2023 22:10:36 -0800
Message-ID: <CANaxB-yWkKzhhPMGXCQbtjntJbqZ40FL2qtM2hk7LLWE-ZpbAg@mail.gmail.com>
Subject: Re: [PATCH 2/5] sched: add WF_CURRENT_CPU and externise ttwu
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     Andrei Vagin <avagin@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Christian Brauner <brauner@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Oskolkov <posk@google.com>,
        Tycho Andersen <tycho@tycho.pizza>,
        Will Drewry <wad@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 14, 2023 at 8:00 AM Chen Yu <yu.c.chen@intel.com> wrote:
>
> On 2023-01-13 at 13:39:46 -0800, Andrei Vagin wrote:
> > On Wed, Jan 11, 2023 at 11:36 PM Chen Yu <yu.c.chen@intel.com> wrote:
> > >
> > > On 2023-01-10 at 13:30:07 -0800, Andrei Vagin wrote:
> > > > From: Peter Oskolkov <posk@google.com>
> > > >
> > > > Add WF_CURRENT_CPU wake flag that advices the scheduler to
> > > > move the wakee to the current CPU. This is useful for fast on-CPU
> > > > context switching use cases.
> > > >
> > > > In addition, make ttwu external rather than static so that
> > > > the flag could be passed to it from outside of sched/core.c.
> > > >
> > > > Signed-off-by: Peter Oskolkov <posk@google.com>
> > > > Signed-off-by: Andrei Vagin <avagin@gmail.com>
> > > > @@ -7380,6 +7380,10 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int wake_flags)
> > > >       if (wake_flags & WF_TTWU) {
> > > >               record_wakee(p);
> > > >
> > > > +             if ((wake_flags & WF_CURRENT_CPU) &&
> > > > +                 cpumask_test_cpu(cpu, p->cpus_ptr))
> > > > +                     return cpu;
> > > I agree that cross-CPU wake up brings pain to fast context switching
> > > use cases,  especially on high core count system. We suffered from this
> > > issue as well, so previously we presented this issue as well. The difference
> > > is that we used some dynamic "WF_CURRENT_CPU" mechanism[1] to deal with it.
> > > That is, if the waker/wakee are both short duration tasks, let the waker wakes up
> > > the wakee on current CPU. So not only seccomp but also other components/workloads
> > > could benefit from this without having to set the WF_CURRENT_CPU flag.
> > >
> > > Link [1]:
> > > https://lore.kernel.org/lkml/cover.1671158588.git.yu.c.chen@intel.com/
> >
> > Thanks for the link. I like the idea, but this change has no impact on the
> > seccom notify case.  I used the benchmark from the fifth patch. It is
> > a ping-pong
> > benchmark in which one process triggers system calls, and another process
> > handles them. It measures the number of system calls that can be processed
> > within a specified time slice.
> >
> Thanks for this information.
> > $ cd tools/testing/selftests/seccomp/
> > $ make
> > $ ./seccomp_bpf  2>&1| grep user_notification_sync
> > #  RUN           global.user_notification_sync ...
> > # seccomp_bpf.c:4281:user_notification_sync:basic: 8489 nsec/syscall
> > # seccomp_bpf.c:4281:user_notification_sync:sync: 3078 nsec/syscall
> > #            OK  global.user_notification_sync
> > ok 51 global.user_notification_sync
> >
> > The results are the same with and without your change. I expected that
> > your change improves
> > the basic case so that it reaches the sync one.
> >
> The reason why the patch did not bring benefit might be that, that patch
> aims to wake task on current CPU only there is no idle cores. The seccomp
> notify would launch 2 processes which makes it hard to saturate the system
> if I understand correctly?

Yes, you understand it right. Our workloads do not always scale on all CPU-s,
and it is critical to work with maximum performance even when there are some
idle cores. I feel I need to say a few words about our use-case. I am working on
gVisor, it is a sandbox solution. In a few words, we intercept guest system
calls and handle them in our user-mode kernel. All these mean that we are
limited by a user application that is running inside a sandbox and how well it
scales on multiple cpu-s. The current benchmark emulates a uni-thread
process running in a sandbox.

> I built a kernel based on your repo, and launched
> above test, it seems that the average load is quit low on my system. Is this
> expected? Besides, is 100 ms long enough to test(USER_NOTIF_BENCH_TIMEOUT)?

The accuracy within the 20% range is good enough for this test. But if
we want to
have a real benchmark, we need to implement it in a separate binary or we can
add it to the perf benchmark suite.

> > I did some experiments and found that we can achieve the desirable
> > outcome if we move the "short-task" checks prior to considering waking
> > up on prev_cpu.
> >
> > For example, with this patch:
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 2f89e44e237d..af20b58e3972 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -6384,6 +6384,11 @@ static int wake_wide(struct task_struct *p)
> >  static int
> >  wake_affine_idle(int this_cpu, int prev_cpu, int sync)
> >  {
> > +       /* The only running task is a short duration one. */
> > +       if (cpu_rq(this_cpu)->nr_running == 1 &&
> > +           is_short_task(cpu_curr(this_cpu)))
> > +               return this_cpu;
> > +
> In v1 we put above code before checking the prev_cpu, but is was reported
> to bring regression on some systems[2]. The result suggested that, we should
> try to pick idle CPU first, no matter it is current CPU, or previous CPU,
> if it failed, we can lower the bar and pick the current CPU.

Maybe the criteria of a short task should be lower for idle cpu-s. It should be
close to the cost of waking up an idle cpu.

>
> [2] https://lore.kernel.org/lkml/6c626e8d-4133-00ba-a765-bafe08034517@amd.com/
> >         /*
> >          * If this_cpu is idle, it implies the wakeup is from interrupt
> >          * context. Only allow the move if cache is shared. Otherwise an
> > @@ -6405,11 +6410,6 @@ wake_affine_idle(int this_cpu, int prev_cpu, int sync)
> >         if (available_idle_cpu(prev_cpu))
> >                 return prev_cpu;
> >
> > -       /* The only running task is a short duration one. */
> > -       if (cpu_rq(this_cpu)->nr_running == 1 &&
> > -           is_short_task(cpu_curr(this_cpu)))
> > -               return this_cpu;
> > -
> >         return nr_cpumask_bits;
> >  }
> >
> > @@ -6897,6 +6897,10 @@ static int select_idle_sibling(struct
> > task_struct *p, int prev, int target)
> >             asym_fits_cpu(task_util, util_min, util_max, target))
> >                 return target;
> >
> > +       if (!has_idle_core && cpu_rq(target)->nr_running == 1 &&
> > +           is_short_task(cpu_curr(target)) && is_short_task(p))
> > +               return target;
> > +
> >         /*
> >          * If the previous CPU is cache affine and idle, don't be stupid:
> >          */
> >
> >
> > the basic test case shows almost the same results as the sync one:
> >
> > $ ./seccomp_bpf  2>&1| grep user_notification_sync
> > #  RUN           global.user_notification_sync ...
> > # seccomp_bpf.c:4281:user_notification_sync:basic: 3082 nsec/syscall
> > # seccomp_bpf.c:4281:user_notification_sync:sync: 2690 nsec/syscall
> > #            OK  global.user_notification_sync
> > ok 51 global.user_notification_sync
> >
> > If you want to do any experiments, you can find my tree here:
> > [1] https://github.com/avagin/linux-task-diag/tree/wip/seccom-notify-sync-and-shed-short-task
> >
> I'm happy to further test on this. One thing I'm curious about is, where does the
> benefit of waking up seccom task on current CPU come from? Is it due to hot L1 cache?

I don't think that it is due to cpu caches. It should be due to the
overhead of queuing a task to
a non-current queue, sending ipt, waking from the idle loop.

Thanks,
Andrei
