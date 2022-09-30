Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C98DF5F1164
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 20:13:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232389AbiI3SNH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 14:13:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232041AbiI3SMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 14:12:23 -0400
Received: from mail-vk1-xa29.google.com (mail-vk1-xa29.google.com [IPv6:2607:f8b0:4864:20::a29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78C7F1EDF4C
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 11:10:51 -0700 (PDT)
Received: by mail-vk1-xa29.google.com with SMTP id g85so2656063vkf.10
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 11:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=am0qLLz5mahQyn2M5POYASxGac1FO6Qvly2HgiAgw5U=;
        b=gfss1lD6a+JVr2EVboaKt+g609xa/YjMaR9KXI9lt4GzucDxIfYo1a5siHZz5G2m2V
         ztY1KiGzD63eIAgn4QPT9w8HB9i0Y4iBvBNXbJwFHRRAc72GEA0pEI4a61qV1HTdXzp0
         Tq8BHaM8gxSjJmwNSB7ADKuhwshjC4oh6CtlSOziAjEoKGCja/kHo+3t9aBK1/osaqG0
         zkJ2ErXkcSrV1cb2COAQ07JzxGX0xbodw7JqqglMaGRY+MQKzAbwHwQZjjJzPbXoyT5D
         j6WuXk69hxCPUQIloh00oJQOZ2jN4YP6q2GphM/BvBwNraB/gez6sW1RAhxbpJpa8NyO
         IeJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=am0qLLz5mahQyn2M5POYASxGac1FO6Qvly2HgiAgw5U=;
        b=fPhSBMW8KjJGDsGBEnKDb7p9d+A8ceM/adoZObhgUue2g5lEWSbX9H9G01siET/4yp
         8fbsRuh4oflbDnAkBif0U9RBLmYQFjCZvFOIIhC3VxK0DVuLrFYP47TbslOMsZr3iRcu
         gogn1Qy3j8J2pvMDhvNNCQeDmlaBVi6YYE7Lv7cyqgCWz8j0WEm36zPekunHz0FIu3Zv
         e31CuI90i9UAEtokMSArjFdLHOmEMnQW0CX1C4VTxI2frVGTuEQ1M6W/LItaudjtKlMf
         2nT0U1I/+sAxBPBuBGCkZdWQA/Qh0vZ7xCGdY/6SLA5Nuj5acje8C5kJcfvJ080o/yR9
         N3vA==
X-Gm-Message-State: ACrzQf1eeJtJ7u4YqnXTkW9+RT0BkgTOmhiTIR5sKAjLhmatP2wul0ka
        BzxlGl1pgrqmv1QOxYHHoKm5dAV4CdLNgkw0OEngsA==
X-Google-Smtp-Source: AMsMyM4MWUUlc9uWo61HrZ1hxNzKcfIm0nBA9FAWW6F4wlO7Y2zlSEYm5raNAuVK3Z/zJASyuSY32Nm2GV2HrxvJ2z0=
X-Received: by 2002:a1f:1e11:0:b0:3a3:a803:ef77 with SMTP id
 e17-20020a1f1e11000000b003a3a803ef77mr4989378vke.7.1664561450321; Fri, 30 Sep
 2022 11:10:50 -0700 (PDT)
MIME-Version: 1.0
References: <cb6c406e-1431-fcfd-ef82-87259760ead9@joelfernandes.org>
 <20220930134931.mpopdvri4xuponw2@wubuntu> <CALUeGD0yEimCRS2TQfZTUD2kwamyTZwM9Y9D7C=Xsd9t9mWsaw@mail.gmail.com>
 <a4a7a4de-c58d-d667-a4b3-0f7bfb2b09f1@joelfernandes.org>
In-Reply-To: <a4a7a4de-c58d-d667-a4b3-0f7bfb2b09f1@joelfernandes.org>
From:   Youssef Esmat <youssefesmat@google.com>
Date:   Fri, 30 Sep 2022 13:10:39 -0500
Message-ID: <CALUeGD21QY+-6oLUztdecg5C8AX9xToxpGpxx5M5D9VnhSkVMg@mail.gmail.com>
Subject: Re: Sum of weights idea for CFS PI
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Qais Yousef <qais.yousef@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>, juri.lelli@redhat.com,
        vincent.guittot@linaro.org,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>, bristot@redhat.com,
        clark.williams@gmail.com, bigeasy@linutronix.de,
        "Paul E. McKenney" <paulmck@kernel.org>
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

On Fri, Sep 30, 2022 at 12:42 PM Joel Fernandes <joel@joelfernandes.org> wrote:
>
> On 9/30/2022 11:44 AM, Youssef Esmat wrote:
> > Hi Everyone!
>
> Hi Youssef,
>
> (Youssef is new to LKML though in no way new to OS or software development. I
> gave him the usual 'dont-top-post' chat already - fyi).
>
> > I am not sure we should care about A's sleeping pattern. The case we
> > care about is when A is running or wants to run but can't because it
> > is blocked on C. In that case C should get the weight of A as if A was
> > running.
>
> Just to clarify - Youssef did mean sum of weights of different things in the
> chain, and not just weights (he confirmed on chat that that's what he meant).
>

Yeah thanks for clarifying, I meant that C should get the sum of
weights as if A was running (3/5 in your example) since in this
segment of time A would have been running if it was not blocked on the
lock. I think it's safe to ignore the average and just use the sum of
weights.

So it would look like this:

Time ->
A: Slp, 2/5, Blk, 2/5, Slp
B: 1/3, 1/5, 1/5, 1/5, 1/3
C: 1/3, 1/5, 3/5, 1/5, 1/3
D: 1/3, 1/5, 1/5, 1/5, 1/3

* Slp means sleeping
* Blk means blocked on the lock owned by C.

> > Ideally this is also a temporary boost since critical sections should
> > be relatively small, so erring on the side of giving C slightly more
> > runtime would be safe I think.
>
> True. But I would not hold my breath too much on user space not holding a lock
> for very long periods of time. But I agree that generally should be true.
>
> thanks,
>
>  - Joel
>
>
> >
> > Thanks,
> > Youssef
> >
> > On Fri, Sep 30, 2022 at 8:49 AM Qais Yousef <qais.yousef@arm.com> wrote:
> >>
> >> Hi Joel
> >>
> >> I'm interested in the topic, if I can be CCed in any future discussions I'd
> >> appreciate it :)
> >>
> >> On 09/29/22 16:38, Joel Fernandes wrote:
> >>> Hi Peter, all,
> >>>
> >>> Just following-up about the idea Peter suggested at LPC22 about sum of weights
> >>> to solve the CFS priority inversion issues using priority inheritance. I am not
> >>> sure if a straight forward summation of the weights of dependencies in the
> >>> chain, is sufficient (or may cause too much unfairness).
> >>>
> >>> I think it will work if all the tasks on CPU are 100% in utilization:
> >>>
> >>> Say if you have 4 tasks (A, B, C, D) running and each one has equal
> >>> weight (W) except for A which has twice the weight (2W).
> >>> So the CPU bandwidth distribution is (assuming all are running):
> >>> A:   2 / 5
> >>> B, C. D:  1 / 5
> >>>
> >>> Say out of the 4 tasks, 3 of them are a part of a classical priority
> >>> inversion scenario (A, B and C).
> >>>
> >>> Say now A blocks on a lock and that lock's owner C is running, however now
> >>> because A has blocked, B gets 1/3 bandwidth, where as it should have been
> >>> limited to 1/5. To remedy this, say you give C a weight of 2W. B gets 1/4
> >>> bandwidth - still not fair since B is eating away CPU bandwidth causing the
> >>> priority inversion we want to remedy.
> >>>
> >>> The correct bandwidth distribution should be (B and D should be unchanged):
> >>> B = 1/5
> >>> D = 1/5
> >>>
> >>> C = 3/5
> >>>
> >>> This means that C's weight should be 3W , and B and D should be W each
> >>> as before. So indeed, C's new weight is its original weight PLUS the
> >>> weight of the A - that's needed to keep the CPU usage of the other
> >>> tasks (B, D) in check so that C makes forward progress on behalf of A and the
> >>> other tasks don't eat into the CPU utilization.
> >>>
> >>> However, I think this will kinda fall apart if A is asleep 50% of the time
> >>> (assume the sleep is because of I/O and unrelated to the PI chain).
> >>>
> >>> Because now if all were running (and assume no PI dependencies), with A being
> >>> 50%, the bandwidth of B, C and D each would be divided into 2 components:
> >>>
> >>> a.  when A is running, it would be as above.
> >>> b.  but if A was sleeping, B, C, and D would get 1/3.
> >>>
> >>> So on average, B, C and D get:  (1/3 + 1/5) / 2 = 8/30. This gives A about 6/30
> >>> or 1/5 bandwidth.
> >>
> >> The average metric is interesting one. It can be confusing to reason about too.
> >>
> >> I think we have 3 events to take into account here, not 2:
> >>
> >> a. when A is running and NOT blocked on C.
> >> b. when A is running and BLOCKED on C.
> >> c. A is sleeping.
> >>
> >> This means A, B, C and D's shares will be:
> >>
> >>     A ,  B ,  C ,  D
> >> a. 2/5, 1/5, 1/5, 1/5
> >> b. -  , 3/5, 1/5, 1/5
> >> c. -  , 1/3, 1/3, 1/3
> >>
> >> Since A is sleeping for 50%, I don't think we can assume equal distribution for
> >> the 3 events (can't just divide by 3).
> >>
> >> I believe we can assume that
> >>
> >> a. occurs 25% of the time
> >> b. occurs 25% of the time
> >> c. occurs 50% of the time
> >>
> >> I *think* this should provide something more representative.
> >>
> >>>
> >>> But now say A happen to block on a lock that C is holding. You would boost C to
> >>> weight 3W which gives it 3/5 (or 18/30) as we saw above, which is more than what
> >>> C should actually get.
> >>>
> >>> C should get (8/30 + 6/30 = 14/30) AFAICS.
> >>>
> >>> Hopefully one can see that a straight summation of weights is not enough. It
> >>> needs to be something like:
> >>>
> >>> C's new weight = C's original weight + (A's weight) * (A's utilization)
> >>>
> >>> Or something, otherwise the inherited weight may be too much to properly solve it.
> >>>
> >>> Any thoughts on this? You mentioned you had some notes on this and/or proxy
> >>> execution, could you share it?
> >>
> >> I assume we'll be using rt-mutex inheritance property to handle this? If this
> >> was discussed during a talk, I'd appreciate a link to that.
> >>
> >> In the past in OSPM conference we brought up an issue with performance
> >> inversion where a task running on a smaller (slower to be more generic) CPU is
> >> holding the lock and causing massive delays for waiters. This is an artefact of
> >> DVFS. For HMP, there's an additional cause due to the unequal capacities of the
> >> CPUs.
> >>
> >> Proxy execution seems to be the nice solution to all of these problems, but
> >> it's a long way away. I'm interested to learn how this inheritance will be
> >> implemented. And whether there are any userspace conversion issues. i.e: do
> >> we need to convert all locks to rt-mutex locks?
> >>
> >>
> >> Thanks
> >>
> >> --
> >> Qais Yousef
