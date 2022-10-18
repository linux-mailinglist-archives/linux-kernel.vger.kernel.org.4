Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16D4B6022D9
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 05:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231493AbiJRDpP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 23:45:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231296AbiJRDo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 23:44:27 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2566F8284C
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 20:43:07 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id b2so20584211lfp.6
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 20:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UR/Co+yCCBgu92uSBJ+PhfxQY/n8XrZW+M588pG6vIE=;
        b=DvUuAYiwVM1KEXisWbtO5p0KlStqMvF3IgizauDzO2bRTTX3D6asO6PaqdA9bfJfKF
         R3tF9gVVreJ0tMhr34ncYcCq3nfk5uhI4MwXZeUY9WbBnPmfen4SY7Q5LmqjVKEwgCY4
         fJ6cFIotdJGH0Wpo46f4JMpkiN4KVWYMMah78imPPXOxheGZ0hek+8YcLXJWtb7QKKoT
         RNNxZ5GAXS7AQLbig8ISMh+ccWqPWgxxX2jqGaMD63oEAYNGEDE08vjiVLqwOMjmBPvL
         dtuhPJrf1K3709CFx+JxdTMSF7kM76d5+M76ealyx0Dw0hx8rZGWoXyhNGiv+F1tGlE6
         YeBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UR/Co+yCCBgu92uSBJ+PhfxQY/n8XrZW+M588pG6vIE=;
        b=7hQk0j7NU9tqXIXpoNeQp9KPoqHv6oPBEiaq19CAklZqADgMBLALFPqLEOKdxPI0Wh
         ox/fOcBKOvlbUOgA+Ktwr4eB2PpEqoXHxXB5vFSa6Kv+yYryxE9L+4EES4Ii6DSz6vPy
         RNISoQjs6plgSuvxLDjWQbKhA4v2A3X8eOck1sVSAOmWy+15pxkH3XIkxyUjq0vbVMmp
         wGFBk1bBWcYvSyHQHDcQ2uzShMHtBAvLV8V60CEuZUQwTs6cKcUlfx5lkD0YrWuVZHJA
         UfQJ9S1YtyP426xQ5ACU0yF5patQYjLxjL3YJhu+rKzEPt9XvenK58Rbqpf5PtXoQ7fV
         zVig==
X-Gm-Message-State: ACrzQf3BVk2m/SescqTgGSicdsUDhQ9aXxdbnLOp9mRlm063Sfsl3kVb
        5a9Dv89vNS3YBJ9pQ5HBSijPOULXtpwlI8TgeLu6
X-Google-Smtp-Source: AMsMyM5R/lmGgMTH+viZ6pd2h8i/PeibCPbUI0nodGcp/7nwuVYxqkMn24/5RmqHxOJ8aKSTR4vIipfKA6yVYtZTzjg=
X-Received: by 2002:ac2:4c47:0:b0:4a2:c07b:4b62 with SMTP id
 o7-20020ac24c47000000b004a2c07b4b62mr260190lfk.426.1666064585904; Mon, 17 Oct
 2022 20:43:05 -0700 (PDT)
MIME-Version: 1.0
References: <20221003232033.3404802-1-jstultz@google.com> <20221003232033.3404802-3-jstultz@google.com>
 <Y01NPB4sa8Z98ntK@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
In-Reply-To: <Y01NPB4sa8Z98ntK@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
From:   John Stultz <jstultz@google.com>
Date:   Mon, 17 Oct 2022 20:42:53 -0700
Message-ID: <CANDhNCoTGNANDnOQ6touhreG_UEn1-N4T4BktWFxpLPSWVfrdA@mail.gmail.com>
Subject: Re: [PATCH RFC v4 2/3] sched: Avoid placing RT threads on cores
 handling long softirqs
To:     Alexander Gordeev <agordeev@linux.ibm.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Connor O'Brien" <connoro@google.com>,
        John Dias <joaodias@google.com>, Rick Yiu <rickyiu@google.com>,
        John Kacur <jkacur@redhat.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Chris Redpath <chris.redpath@arm.com>,
        Abhijeet Dharmapurikar <adharmap@quicinc.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>, kernel-team@android.com,
        "J . Avila" <elavila@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 On Mon, Oct 17, 2022 at 5:40 AM Alexander Gordeev
<agordeev@linux.ibm.com> wrote:
>
> On Mon, Oct 03, 2022 at 11:20:32PM +0000, John Stultz wrote:
> > From: Connor O'Brien <connoro@google.com>
> > diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> > index 55f39c8f4203..3c628db807c8 100644
> > --- a/kernel/sched/rt.c
> > +++ b/kernel/sched/rt.c
> > @@ -1599,6 +1599,44 @@ static void yield_task_rt(struct rq *rq)
> >  #ifdef CONFIG_SMP
> >  static int find_lowest_rq(struct task_struct *task);
> >
> > +#ifdef CONFIG_RT_SOFTIRQ_OPTIMIZATION
> > +#define __use_softirq_opt 1
> > +/*
> > + * Return whether the given cpu is currently non-preemptible
> > + * while handling a potentially long softirq, or if the current
> > + * task is likely to block preemptions soon because it is a
> > + * ksoftirq thread that is handling slow softirq.
>
> What is slow softirqs in this context compared to long?

So the long softirqs are any of the softirqs in the LONG_SOFTIRQ_MASK
(net, block, irqpoll).
The "slow softirq" just refers to softirq processing that has already
been pushed out to ksoftirqd on the target cpu.

By default ksoftirqd's priority is likely not high enough priority to
prevent the rt task from running, however, it does disable preemption
while it's running the softirqs, so it effectively could block the rt
task from running for a while.


> > + */
> > +static bool cpu_busy_with_softirqs(int cpu)
> > +{
> > +     u32 softirqs = per_cpu(active_softirqs, cpu) |
> > +                    __cpu_softirq_pending(cpu);
> > +     struct task_struct *cpu_ksoftirqd = per_cpu(ksoftirqd, cpu);
> > +     struct task_struct *curr;
> > +     struct rq *rq = cpu_rq(cpu);
> > +     int ret;
> > +
> > +     rcu_read_lock();
> > +     curr = READ_ONCE(rq->curr); /* unlocked access */
>
> select_task_rq_rt() takes the lock and reads curr already,
> before calling this funciton. I think there is a way to
> decompose it in a better way.

Hrm. Suggestions? As select_task_rq_rt() is only one of the callers.
Trying to pass curr into cpu_busy_with_softirqs() would mean
cpupri_find_fitness() would need to read the cpu_rq(cpu)->curr for the
specified cpu and pass that in.

The original patch actually was


> > +     ret = (softirqs & LONG_SOFTIRQ_MASK) &&
> > +              (curr == cpu_ksoftirqd ||
>
> EOL is extra.

Removed - thanks!

>
> > +               preempt_count() & SOFTIRQ_MASK);
>
> Could you please clarify this whole check in more detail?
>
> What is the point in checking if a remote CPU is handling
> a "long" softirq while the local one is handling any softirq?

Good question! This looks like an error from my rework of the earlier
version of the patch.
In v1 it was:
   task_thread_info(curr)->preempt_count & SOFTIRQ_MASK));
And it looks like I erroneously condensed that to preempt_count() &
SOFTIRQ_MASK  treating curr (from the target cpu rq) as if it were
current. :P

I'll fix this. Thank you for catching it!

Just to expand what it should be in detail:
1:  (softirqs & LONG_SOFTIRQ_MASK) &&
2:  (curr == cpu_ksoftirqd ||
3:  task_thread_info(curr)->preempt_count & SOFTIRQ_MASK)

Where we're checking
1) that  the active_softirqs and __cpu_softirq_pending() values on the
target cpu are running a long softirq.
AND (
2) The current task on the target cpu is ksoftirqd
OR
3) The preempt_count of the current task on the target cpu has SOFTIRQ entries
)

> > +     rcu_read_unlock();
>
> Why ret needs to be calculated under the lock?

I believe it is the rq->curr == cpu_ksoftirqd (and the erroneously
removed task_thread_info(curr)) check?
Part of me wonders if it should have the rcu_dereference(rq->curr) as well?

> > +     return ret;
> > +}
> > +#else
> > +#define __use_softirq_opt 0
> > +static bool cpu_busy_with_softirqs(int cpu)
> > +{
> > +     return false;
> > +}
> > +#endif /* CONFIG_RT_SOFTIRQ_OPTIMIZATION */
> > +
> > +static bool rt_task_fits_cpu(struct task_struct *p, int cpu)
>
> To me, the new name is unfortunate, since it strips a notion
> of the reason. Instead, "CPU un/fits, because of capacity" it
> reads as "CPU un/fits, because of ..." what?

As with all complicated questions: "It depends" :) On the kernel
config specifically.

The earlier version of the patch had:
rt_task_fits_capacity_and_may_preempt() but Qais suggested it be
switched to the generic "fits_cpu" as it would depend on the kernel
config as to which aspect of "fit" was being considered.

I guess it could be  rt_task_fits_capacity_and_softirq_free() ?

> > +{
> > +     return !cpu_busy_with_softirqs(cpu) && rt_task_fits_capacity(p, cpu);
>
> I guess the order needs to be swapped, as rt_task_fits_capacity()
> is rather "quick" while cpu_busy_with_softirqs() is rather "slow".

Fair point. I've gone ahead and tweaked that. Thanks!

> > @@ -1894,14 +1934,17 @@ static int find_lowest_rq(struct task_struct *task)
> >               return -1; /* No other targets possible */
> >
> >       /*
> > -      * If we're on asym system ensure we consider the different capacities
> > -      * of the CPUs when searching for the lowest_mask.
> > +      * If we're using the softirq optimization or if we are
> > +      * on asym system, ensure we consider the softirq processing
> > +      * or different capacities of the CPUs when searching for the
> > +      * lowest_mask.
> >        */
> > -     if (static_branch_unlikely(&sched_asym_cpucapacity)) {
> > +     if (__use_softirq_opt ||
>
> Why use __use_softirq_opt and not IS_ENABLED(CONFIG_RT_SOFTIRQ_OPTIMIZATION)?

Because IS_ENABLED(CONFIG_RT_SOFTIRQ_OPTIMIZATION) seemed a bit long
and less easy to read?
I'm ambivalent if folks would rather have the CONFIG switch be
explicit here, but to me it seemed nicer to read the flag variable.

> > @@ -60,6 +60,13 @@ static struct softirq_action softirq_vec[NR_SOFTIRQS] __cacheline_aligned_in_smp
> >
> >  DEFINE_PER_CPU(struct task_struct *, ksoftirqd);
> >
> > +/*
> > + * active_softirqs -- per cpu, a mask of softirqs that are being handled,
> > + * with the expectation that approximate answers are acceptable and therefore
> > + * no synchronization.
> > + */
> > +DEFINE_PER_CPU(u32, active_softirqs);
>
> I guess all active_softirqs uses need to be coupled with
> IS_ENABLED(CONFIG_RT_SOFTIRQ_OPTIMIZATION) check.

I guess it could be wrapped. I didn't see the per-cpu accounting as
troublesome enough to conditionalize, but the extra per-cpu data isn't
great if no one uses it. So I'll do that.

Thanks so much for the review and feedback! I really appreciate it.
-john
