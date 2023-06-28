Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 107F6741145
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 14:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbjF1MgT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 08:36:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231214AbjF1MgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 08:36:05 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08BA730E6
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 05:36:03 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-51d9124e1baso5153199a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 05:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687955761; x=1690547761;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GmuFganyxYV9oTk/s8YFRwqFcz+cn6L4jtzUfYMJZfY=;
        b=HFoww3PY8H+PN1nGnfWDLVOYQs0OS9HmgPffbN7DsNnVsz/q+/QWgnM7dfndpE9592
         H4Ohm4GbtuncosDi+CEZRMZKnnC63W8q+3S8F6W14WR0FHgtExqVzmqg+b0Re4PTnH8F
         oe42jT2cv9MfubVMh9KYWFPaU7BTt5gaKUo0ycumz2biccHIvQOglMETo3s4VCzrynhq
         QF08CoIue2oL9x6g8nhGGNqWv9F0cn/Q5qMpAh4shCAQ1LsjhLhSXa9RcxeOwKHVXVH+
         01b1I7W0jMad8SRLVJHB0YvcbM4r2C79YbdpLl9hLMum9Pxi6Tlx2bZEz7UzvqSZynzu
         oJlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687955761; x=1690547761;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GmuFganyxYV9oTk/s8YFRwqFcz+cn6L4jtzUfYMJZfY=;
        b=ciS7qpOw/nptrIXgtKEc54jRrZVZW/j/0s68io77VULxKCPBbqcYddm9MqVgKbIymj
         b1rW/XVu5kWOpPE1i7DwgpBVdii5vP2j8SaTs+fhyNl7kV2g0HPZM/mlSybDihpvokcq
         TWMXkKG+AaR/YpQf3V+zFKO4STYy/CB4jcIpzar8iQjMFPYF5zbPtT2XOUhLKL+TGdgX
         CcEcTpSp7FopJ0IifxcnfBbDFhiYl2TIN8FtRmpCdy9ZYJUDnOfEurBo3ieTEEeqgGQA
         g5InL/wqxg/zF0uTAo67MR1k4siDseZy+nsAzKAyt5pGsl0KktJSqb8P541o19+08ky9
         TpAA==
X-Gm-Message-State: AC+VfDyaFJwBK32lVDkb94upvgF+D7EEK9vJP92KExjoTHz3ewrf5heW
        h2V4lOudpboT0nBPi+QC/zpwcXK06AFYpDWwBacQWA==
X-Google-Smtp-Source: ACHHUZ6D5ytOq1YfewFvAI1UJcz0ckd29b9U37Gp9+k5NYwHiOF0WE7/VKoEvgA9157hRVp3LxMy0w6dT0lJOIyGd1o=
X-Received: by 2002:a05:6402:10c4:b0:514:9e91:f54 with SMTP id
 p4-20020a05640210c400b005149e910f54mr23990257edu.26.1687955761447; Wed, 28
 Jun 2023 05:36:01 -0700 (PDT)
MIME-Version: 1.0
References: <8e785777-03aa-99e1-d20e-e956f5685be6@huawei.com>
 <87mt18it1y.ffs@tglx> <68baeac9-9fa7-5594-b5e7-4baf8ac86b77@huawei.com>
 <ba352e83-b8b1-d900-9c1f-56b8c8a8b8fb@huawei.com> <CAKfTPtBoe_jRn-EMsQxssQ4BcveT+Qcd+GmsRbQEXQDGfzFOMg@mail.gmail.com>
 <875y774wvp.ffs@tglx>
In-Reply-To: <875y774wvp.ffs@tglx>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 28 Jun 2023 14:35:50 +0200
Message-ID: <CAKfTPtAzTy4KPrBNRA4cMeTonxn5EKLEAg0b9iH5ecJkAMEStw@mail.gmail.com>
Subject: Re: [Question] report a race condition between CPU hotplug state
 machine and hrtimer 'sched_cfs_period_timer' for cfs bandwidth throttling
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Xiongfeng Wang <wangxiongfeng2@huawei.com>, vschneid@redhat.com,
        Phil Auld <pauld@redhat.com>, vdonnefort@google.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Wei Li <liwei391@huawei.com>,
        "liaoyu (E)" <liaoyu15@huawei.com>, zhangqiao22@huawei.com,
        Peter Zijlstra <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Jun 2023 at 14:03, Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Tue, Jun 27 2023 at 18:46, Vincent Guittot wrote:
> > On Mon, 26 Jun 2023 at 10:23, Xiongfeng Wang <wangxiongfeng2@huawei.com> wrote:
> >> > diff --cc kernel/sched/fair.c
> >> > index d9d6519fae01,bd6624353608..000000000000
> >> > --- a/kernel/sched/fair.c
> >> > +++ b/kernel/sched/fair.c
> >> > @@@ -5411,10 -5411,16 +5411,15 @@@ void start_cfs_bandwidth(struct cfs_ban
> >> >   {
> >> >         lockdep_assert_held(&cfs_b->lock);
> >> >
> >> > -       if (cfs_b->period_active)
> >> > +       if (cfs_b->period_active) {
> >> > +               struct hrtimer_clock_base *clock_base = cfs_b->period_timer.base;
> >> > +               int cpu = clock_base->cpu_base->cpu;
> >> > +               if (!cpu_active(cpu) && cpu != smp_processor_id())
> >> > +                       hrtimer_start_expires(&cfs_b->period_timer,
> >> > HRTIMER_MODE_ABS_PINNED);
> >> >                 return;
> >> > +       }
> >
> > I have been able to reproduce your problem and run your fix on top. I
> > still wonder if there is a
> > Could we have a helper from hrtimer to get the cpu of the clock_base ?
>
> No, because this is fundamentally wrong.
>
> If the CPU is on the way out, then the scheduler hotplug machinery
> has to handle the period timer so that the problem Xiongfeng analyzed
> does not happen in the first place.

But the hrtimer was enqueued before it starts to offline the cpu
Then, hrtimers_dead_cpu should take care of migrating the hrtimer out
of the outgoing cpu but :
- it must run on another target cpu to migrate the hrtimer.
- it runs in the context of the caller which can be throttled.

>
> sched_cpu_wait_empty() would be the obvious place to cleanup armed CFS
> timers, but let me look into whether we can migrate hrtimers early in
> general.

but for that we must check if the timer is enqueued on the outgoing
cpu and we then need to choose a target cpu

>
> Aside of that the above is wrong by itself.
>
>         if (cfs_b->period_active)
>                 hrtimer_start_expires(&cfs_b->period_timer, HRTIMER_MODE_ABS_PINNED);
>
> This only ends up on the outgoing CPU if either:
>
>    1) The code runs on the outgoing CPU
>
> or
>
>    2) The hrtimer is concurrently executing the hrtimer callback on the
>       outgoing CPU.
>
> So this:
>
>         if (cfs_b->period_active) {
>                 struct hrtimer_clock_base *clock_base = cfs_b->period_timer.base;
>                 int cpu = clock_base->cpu_base->cpu;
>
>                 if (!cpu_active(cpu) && cpu != smp_processor_id())
>                         hrtimer_start_expires(&cfs_b->period_timer, HRTIMER_MODE_ABS_PINNED);
>               return;
>       }
>
> only works, if
>
>   1) The code runs _not_ on the outgoing CPU
>
> and
>
>   2) The hrtimer is _not_ concurrently executing the hrtimer callback on
>      the outgoing CPU.
>
>      If the callback is executing (it spins on cfs_b->lock), then the
>      timer is requeued on the outgoing CPU. Not what you want, right?
>
> Plus accessing hrtimer->clock_base->cpu_base->cpu lockless is fragile at
> best.
>
> Thanks,
>
>         tglx
