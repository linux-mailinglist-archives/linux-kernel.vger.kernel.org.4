Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44F105F34CB
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 19:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229441AbiJCRre (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 13:47:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiJCRr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 13:47:26 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F1AA175A9
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 10:47:25 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id a10so12688744ljq.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Oct 2022 10:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=Csjjd6NeemcjYwwEXwT5cMgxjV2gplYZsfCPOs8l7MY=;
        b=VoHHtuAXNgg+kRszehFHh5u1IweTcn2lPINwTjmSEQUuiMXYvCH4lqBhLcQRIlAKSc
         hqqVrMGPWlnNhmJs3JImW1lmtsgVt7VE4cUGmG0q+ToFu7aifyIiaYfuTW2ZEoqN3ByE
         Q+smuHHZL6VjToXFQ84RuOMYW7lQB3uUjV4LV/6AxLJIgDxmbDbj2nYphd5bjTWCfZ3r
         btbua7e2BbgLaUMOocs5xtr2FgV9KNWMlc1U2lc8RoMWtmUtusRIQvgR0gNB24xTzB8P
         eN3JpqPtKOUzNe4E4GyUep+dTs6PVcN8A9+lDXhekD4eM6WYLhPsNhe2F13TGu7NHST+
         MEJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=Csjjd6NeemcjYwwEXwT5cMgxjV2gplYZsfCPOs8l7MY=;
        b=ay7e3NrwQnRiiqmsrxgk2yosWSX9Np93LvA5eMS/DM1HIYzXn9rsoyCn8bLQWAJNPF
         ZyH9LUassSdTmR1H1hBAUx3rlIZfX0k8ZiP/si7jgRxwfQ+0558vyIh8k+Lmw67GQDGd
         CsiOpYVIj7NZcofUwsNily/yus2nNGV4TWxrBHax57LSYzxYYwM32LqeCR0Wx/h8FedM
         /KLUkND5i01ZYHnvUCRatYdAogYlLLwrljG9V/lFn5oDbED5xsbjZDiP+4/Inf1nz+Sw
         XddnXkNnH3hy7rpKluI6MIj0azh060dzFCERj0urRVc+MEvyFNSiFwimK0HcxQX4WyMb
         8XPg==
X-Gm-Message-State: ACrzQf1Bf0JekzY0kGQgIS+jsBFf00Ux9Y8R5a4UAw6pLKn90CqeoTc1
        yRSRqMl2KuhucSJJ7o4hLm4GhhFdNdwPBIYOeprgvhj4xW/t
X-Google-Smtp-Source: AMsMyM6BvdTws5cSjDkiYaMp586uLgx8+kfYgl6GbrcB58/89DRG/vycess23RTUDi1G+LCJVn1Re3aNOS8QSzH/IrI=
X-Received: by 2002:a05:651c:1546:b0:26d:9459:1a69 with SMTP id
 y6-20020a05651c154600b0026d94591a69mr7438184ljp.209.1664819243668; Mon, 03
 Oct 2022 10:47:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220921012550.3288570-1-jstultz@google.com> <20220921012550.3288570-3-jstultz@google.com>
 <20220928125517.ei64pxfucaem55cr@wubuntu> <CANDhNCpLp+St4U_fjs+W8HXT-2ff4gpkx0P6vDnrX0CcesiQfA@mail.gmail.com>
In-Reply-To: <CANDhNCpLp+St4U_fjs+W8HXT-2ff4gpkx0P6vDnrX0CcesiQfA@mail.gmail.com>
From:   John Stultz <jstultz@google.com>
Date:   Mon, 3 Oct 2022 10:47:11 -0700
Message-ID: <CANDhNCoLJ0YJUuQY=e0OfB05wbs7qvpwfnSVhQWt6Zkeo6sWrA@mail.gmail.com>
Subject: Re: [RFC PATCH v3 2/3] sched: Avoid placing RT threads on cores
 handling long softirqs
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Connor O'Brien" <connoro@google.com>,
        John Dias <joaodias@google.com>, Rick Yiu <rickyiu@google.com>,
        John Kacur <jkacur@redhat.com>,
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

On Mon, Oct 3, 2022 at 9:55 AM John Stultz <jstultz@google.com> wrote:
> On Wed, Sep 28, 2022 at 5:55 AM Qais Yousef <qais.yousef@arm.com> wrote:
> > On 09/21/22 01:25, John Stultz wrote:
> > > @@ -1641,9 +1683,10 @@ select_task_rq_rt(struct task_struct *p, int cpu, int flags)
> > >        * requirement of the task - which is only important on heterogeneous
> > >        * systems like big.LITTLE.
> > >        */
> > > -     test = curr &&
> > > -            unlikely(rt_task(curr)) &&
> > > -            (curr->nr_cpus_allowed < 2 || curr->prio <= p->prio);
> > > +     may_not_preempt = !task_may_preempt(curr, cpu);
> > > +     test = (curr && (may_not_preempt ||
> > > +                      (unlikely(rt_task(curr)) &&
> > > +                       (curr->nr_cpus_allowed < 2 || curr->prio <= p->prio))));
> >
> > I think this is unnecesary if you create new rt_task_fits_cpu() and ...
> >
> > >
> > >       if (test || !rt_task_fits_capacity(p, cpu)) {
> >
> > ... replace the call to rt_task_fits_capacity() with the new
> > rt_task_fits_cpu()?
>
>
> But is that really the same logic?  Above we're doing:
> if ((!task_may_preempt(curr, cpu)|| <other stuff >) ||
> !rt_task_fits_capacity(p, cpu))
>
> And you're suggestion switching it to
> if (<other stuff> || !rt_task_fits_cpu(p, cpu))
> which would expand to:
> if( <other stuff > || !(task_may_preempt(p, cpu) &&
> rt_task_fits_capacity(p, cpu)))
>
> I worry we would be skipping the part where we compare against curr.

Ignore this bit, I've not finished my coffee.

I was mixing up an earlier version of the patch where the task passed
in to task_may_preempt() was compared with the ksoftirqd (which didn't
seem right), and I've since switched it to comparing curr on the cpu
with the ksoftirqd, making the task passed in unused.

I'm reworking this to be less confusing (renaming this to
cpu_busy_with_softirqs()), and will try to take your larger suggestion
here.

thanks
-john
