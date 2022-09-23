Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 263D55E8114
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 19:48:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232421AbiIWRrz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 13:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232406AbiIWRrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 13:47:52 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A95514F8DC
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 10:47:51 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id r134so502128iod.8
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 10:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=kQyunMqWttlQfuq1o3a6QAGS0mma8ng0iXmvfNWUdbM=;
        b=O1fCLwmOPrFVAV7A4vxK17B6TSxcRx3+ULCWpSjnaZT+sM5Z6duC9u0meM/ruol4WO
         JlM2Tex5eAzwZub81EHbM1TVwAncYz72SHVTELVUzcQgDk/ZiKErJKM2norm5pTSezAH
         8gpeVRr/xUInpgidoYhvmlfIcD20iOaiFBdKg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=kQyunMqWttlQfuq1o3a6QAGS0mma8ng0iXmvfNWUdbM=;
        b=i5dJ3InmCtjWwe4hsAdBNtIa8jNFqraixqRUvDqGK0fWrGK4aRAnB9Kv2oejVu0o4j
         0V34KSLnJd/6Cuup0i+WoqvJFvFXMrlKEMMtB1Jqy9UzRDmVsDsRw3i5WJkt+YYeUbUM
         MppVytYdjBZWzI56XZRU3GRFMZXtFoRjGGQev9CsfmWY6ex2ob9aR6jsQ6vsbCv3H/MC
         0JvGbvoTjxsskOH9RbaUiMGNz+oeBwX4Q8s+UcscGBaJODOqRMZnIoHI7ZvbYkolaC2o
         ruQSpuwevBbTs7mHeZeIix9FBsNaIjNxuZQrI4tY6tM18URjMPiGSaWNnt9w5a1/YV9e
         F3kA==
X-Gm-Message-State: ACrzQf27KcBp3+JNmrevvqkRbyNd5dQ4r4Og85LhRTMT0ML2Mtw2RkTS
        0BaGu5BD5RzfwRTgBlj6PHe/dZh5vGCnLPeFwVCM2Q==
X-Google-Smtp-Source: AMsMyM6j/wl7qfT79jq1/WBQjRQUdS/GyQs0uTX1Zcxa2KCgjI4L4AxEPdyTptIFrf3Uin+vOCDS+xI31oiIMZJirvc=
X-Received: by 2002:a05:6602:15c6:b0:67a:33d1:6c73 with SMTP id
 f6-20020a05660215c600b0067a33d16c73mr4396069iow.156.1663955270615; Fri, 23
 Sep 2022 10:47:50 -0700 (PDT)
MIME-Version: 1.0
References: <YyLksEr05QTNo05Q@hirez.programming.kicks-ass.net>
 <20220915160600.GA246308@paulmck-ThinkPad-P17-Gen-1> <YyN0BKEoDbe4hcIl@hirez.programming.kicks-ass.net>
 <20220915191427.GC246308@paulmck-ThinkPad-P17-Gen-1> <YyOnilnwnLKA9ghN@hirez.programming.kicks-ass.net>
 <20220916075817.GE246308@paulmck-ThinkPad-P17-Gen-1> <YyQ/zn54D1uoaIc1@hirez.programming.kicks-ass.net>
 <20220917142508.GF246308@paulmck-ThinkPad-P17-Gen-1> <20220921213644.GA1609461@paulmck-ThinkPad-P17-Gen-1>
 <16b11b78-245e-9db6-1d0f-267832b954ca@joelfernandes.org> <20220923160112.GT4196@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20220923160112.GT4196@paulmck-ThinkPad-P17-Gen-1>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Fri, 23 Sep 2022 13:47:40 -0400
Message-ID: <CAEXW_YRrk=6hwoHXA76BkwMUS9+4HQQnWy1oTpzibG88FJz_Fw@mail.gmail.com>
Subject: Re: RCU vs NOHZ
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 23, 2022 at 12:01 PM Paul E. McKenney <paulmck@kernel.org> wrote:
[...]
> > > And here is an untested patch that in theory might allow much of the
> > > reduction in power with minimal complexity/overhead for kernels without
> > > rcu_nocbs CPUs.  On the off-chance you know of someone who would be
> > > willing to do a realistic evaluation of it.
> > >
> > >                                                     Thanx, Paul
> > >
> > > ------------------------------------------------------------------------
> > >
> > > commit 80fc02e80a2dfb6c7468217cff2d4494a1c4b58d
> > > Author: Paul E. McKenney <paulmck@kernel.org>
> > > Date:   Wed Sep 21 13:30:24 2022 -0700
> > >
> > >     rcu: Let non-offloaded idle CPUs with callbacks defer tick
> > >
> > >     When a CPU goes idle, rcu_needs_cpu() is invoked to determine whether or
> > >     not RCU needs the scheduler-clock tick to keep interrupting.  Right now,
> > >     RCU keeps the tick on for a given idle CPU if there are any non-offloaded
> > >     callbacks queued on that CPU.
> > >
> > >     But if all of these callbacks are waiting for a grace period to finish,
> > >     there is no point in scheduling a tick before that grace period has any
> > >     reasonable chance of completing.  This commit therefore delays the tick
> > >     in the case where all the callbacks are waiting for a specific grace
> > >     period to elapse.  In theory, this should result in a 50-70% reduction in
> > >     RCU-induced scheduling-clock ticks on mostly-idle CPUs.  In practice, TBD.
> > >
> > >     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > >     Cc: Peter Zijlstra <peterz@infradead.org>
> > >
> > > diff --git a/include/linux/rcutiny.h b/include/linux/rcutiny.h
> > > index 9bc025aa79a3..84e930c11065 100644
> > > --- a/include/linux/rcutiny.h
> > > +++ b/include/linux/rcutiny.h
> > > @@ -133,7 +133,7 @@ static inline void rcu_softirq_qs(void)
> > >             rcu_tasks_qs(current, (preempt)); \
> > >     } while (0)
> > >
> > > -static inline int rcu_needs_cpu(void)
> > > +static inline int rcu_needs_cpu(u64 basemono, u64 *nextevt)
> > >  {
> > >     return 0;
> > >  }
> > > diff --git a/include/linux/rcutree.h b/include/linux/rcutree.h
> > > index 70795386b9ff..3066e0975022 100644
> > > --- a/include/linux/rcutree.h
> > > +++ b/include/linux/rcutree.h
> > > @@ -19,7 +19,7 @@
> > >
> > >  void rcu_softirq_qs(void);
> > >  void rcu_note_context_switch(bool preempt);
> > > -int rcu_needs_cpu(void);
> > > +int rcu_needs_cpu(u64 basemono, u64 *nextevt);
> > >  void rcu_cpu_stall_reset(void);
> > >
> > >  /*
> > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > index 5ec97e3f7468..47cd3b0d2a07 100644
> > > --- a/kernel/rcu/tree.c
> > > +++ b/kernel/rcu/tree.c
> > > @@ -676,12 +676,33 @@ void __rcu_irq_enter_check_tick(void)
> > >   * scheduler-clock interrupt.
> > >   *
> > >   * Just check whether or not this CPU has non-offloaded RCU callbacks
> > > - * queued.
> > > + * queued that need immediate attention.
> > >   */
> > > -int rcu_needs_cpu(void)
> > > +int rcu_needs_cpu(u64 basemono, u64 *nextevt)
> > >  {
> > > -   return !rcu_segcblist_empty(&this_cpu_ptr(&rcu_data)->cblist) &&
> > > -           !rcu_rdp_is_offloaded(this_cpu_ptr(&rcu_data));
> > > +   struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
> > > +   struct rcu_segcblist *rsclp = &rdp->cblist;
> > > +
> > > +   // Disabled, empty, or offloaded means nothing to do.
> > > +   if (!rcu_segcblist_is_enabled(rsclp) ||
> > > +       rcu_segcblist_empty(rsclp) || rcu_rdp_is_offloaded(rdp)) {
> > > +           *nextevt = KTIME_MAX;
> > > +           return 0;
> > > +   }
> > > +
> > > +   // Callbacks ready to invoke or that have not already been
> > > +   // assigned a grace period need immediate attention.
> > > +   if (!rcu_segcblist_segempty(rsclp, RCU_DONE_TAIL) ||
> > > +       !rcu_segcblist_segempty(rsclp, RCU_NEXT_TAIL))
> > > +           return 1;> +
> > > +   // There are callbacks waiting for some later grace period.
> > > +   // Wait for about a grace period or two for the next tick, at which
> > > +   // point there is high probability that this CPU will need to do some
> > > +   // work for RCU.
> > > +   *nextevt = basemono + TICK_NSEC * (READ_ONCE(jiffies_till_first_fqs) > +                                           READ_ONCE(jiffies_till_next_fqs) + 1);
> >
> > Looks like nice idea. Could this race with the main GP thread on another CPU
> > completing the grace period, then on this CPU there is actually some work to do
> > but rcu_needs_cpu() returns 0.
> >
> > I think it is plausible but not common, in which case the extra delay is
> > probably Ok.
>
> Glad you like it!
>
> Yes, that race can happen, but it can also happen today.
> A scheduling-clock interrupt might arrive at a CPU just as a grace
> period finishes.  Yes, the delay is longer with this patch.  If this
> proves to be a problem, then the delay heuristic might expanded to
> include the age of the current grace period.
>
> But keeping it simple to start with.

Sure sounds good and yes I agree to the point of the existing issue
but the error is just 1 jiffie there as you pointed.

> > Also, if the RCU readers take a long time, then we'd still wake up the system
> > periodically although with the above change, much fewer times, which is a good
> > thing.
>
> And the delay heuristic could also be expanded to include a digitally
> filtered estimate of grace-period duration.  But again, keeping it simple
> to start with.  ;-)
>
> My guess is that offloading gets you more power savings, but I don't
> have a good way of testing this guess.

I could try to run turbostat on Monday on our Intel SoCs, and see how
it reacts, but I was thinking of tracing this first to see the
behavior. Another thing I was thinking of was updating (the future)
rcutop to see how many 'idle ticks' are RCU related, vs others; and
then see how this patch effects that.

thanks,

 - Joel


> > >     unsigned long basejiff;
> > >     unsigned int seq;
> > >
> > > @@ -807,7 +807,7 @@ static ktime_t tick_nohz_next_event(struct tick_sched *ts, int cpu)
> > >      * minimal delta which brings us back to this place
> > >      * immediately. Lather, rinse and repeat...
> > >      */
> > > -   if (rcu_needs_cpu() || arch_needs_cpu() ||
> > > +   if (rcu_needs_cpu(basemono, &next_rcu) || arch_needs_cpu() ||
> > >         irq_work_needs_cpu() || local_timer_softirq_pending()) {
> > >             next_tick = basemono + TICK_NSEC;
> > >     } else {
> > > @@ -818,8 +818,10 @@ static ktime_t tick_nohz_next_event(struct tick_sched *ts, int cpu)
> > >              * disabled this also looks at the next expiring
> > >              * hrtimer.
> > >              */
> > > -           next_tick = get_next_timer_interrupt(basejiff, basemono);
> > > -           ts->next_timer = next_tick;
> > > +           next_tmr = get_next_timer_interrupt(basejiff, basemono);
> > > +           ts->next_timer = next_tmr;
> > > +           /* Take the next rcu event into account */
> > > +           next_tick = next_rcu < next_tmr ? next_rcu : next_tmr;
> > >     }
> > >
> > >     /*
