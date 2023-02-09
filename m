Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE652690AC6
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 14:45:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbjBINpR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 08:45:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbjBINpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 08:45:14 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AAF4EC6B
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 05:45:01 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id f16-20020a17090a9b1000b0023058bbd7b2so2430306pjp.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 05:45:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UcE9vHrHYZoMIh/Y+TcSdqIYgW5L75DStcjcziG+YYU=;
        b=xg0+Rt/9kWtVCUNRgFve1XGNWPvCk14aIWFnvgIFzng8gcORFHgjz49mlfXASYwhYs
         awoA52mZ/gRut/O2SKaNnr6Y7C3C65jiEkRJQZEUBDuPYBchSIb43oOE7p+zeFE+S13R
         b2xTpEuiDXGHo8fcn3n8oTy71qxoa08zZQwHTGZb/OsFBi7pbheWTgWXzYxgnHSM15LB
         xEAumoW+gNmEIS+8ESalBuyLlalB5ObviIp38Bvc5zsHR7bAY4zoxtkCszoWaWMQ4Wnp
         wRLuNdprWQI8fvjYnjBC7h9sFdOpu8If1ixd0p46b1dysH/MtsG4nQ+uCAlitD4M07Ks
         DOFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UcE9vHrHYZoMIh/Y+TcSdqIYgW5L75DStcjcziG+YYU=;
        b=LT188W6+hicSYzQRVfTenzp55H74Ih3lS32KVrENcY/ahGuO9liyYgEm0Lq+m05Ob/
         IrrVsRL0v5eo8CGYCa5beOs3vhjF+ECBioJYekofCo5xK+81R5iHqnJEt+qmSQLSURWT
         mOLKtCbn1MO4wwCFbmZeITxdPkVvCEbA3J1rd3WeQMAh+tdum1nsOa+rPKr9KpazsY3P
         WFUxQLZnxRISnC6SDADbMKG4E8znlCwTjN4VoE5qadT+WOdLrYjORVpcnwmzIelnSmWA
         cs++KH2PUH7B0RBw71WA6TgYEHn5smFpmyBmLAhElmeeid5ObCrmM/WCIk8+DFSUnDzc
         k+jw==
X-Gm-Message-State: AO0yUKX34SCnJEW+o2REANwDeRh5LvxCUGvXQs0ItebJG35Wq/CXpH5f
        hVL+nc/sbjCutY5q1jDwubZWkDicD3087NFRbHL2Pw==
X-Google-Smtp-Source: AK7set+QLTqT4Ty1LVMGx55Fgityz/YyMe5sUGbXQyDTb/ksjlUq+YGTY0GYh1Tf8CRhHxE+QZQTVT7wvDKTF4RGfRk=
X-Received: by 2002:a17:90a:b309:b0:233:4f0d:7 with SMTP id
 d9-20020a17090ab30900b002334f0d0007mr84774pjr.42.1675950300776; Thu, 09 Feb
 2023 05:45:00 -0800 (PST)
MIME-Version: 1.0
References: <Y9LG5vkf/4ufJb35@u40bc5e070a0153.ant.amazon.com>
 <Y9O5Fwfib2CVAMwl@hirez.programming.kicks-ass.net> <CAKfTPtBMSg2SDXq=sVt99TyM+tEXRFL74EQ57-t5uKYAXUUyLg@mail.gmail.com>
 <Y9iJLQxyXp9+x2aF@chenyu5-mobl1> <Y9jmm5c5vT8WXsl6@u40bc5e070a0153.ant.amazon.com>
 <CAKfTPtDUMph262w5OSiSQi-BVcNRf2gN=PdmxYCKEuk-8aYhgA@mail.gmail.com>
 <Y+Kob8kOUFa0FnJN@u40bc5e070a0153.ant.amazon.com> <CAKfTPtC8hQ9JysoRNF0egsp+B9+9r4YFC_1-KBnu0GpXts27kw@mail.gmail.com>
 <Y+PlTVfW9Jn1XvYZ@u40bc5e070a0153.ant.amazon.com> <CAKfTPtAmLWcaUUrcp8Q_F6FGo2KZrx34vcp+6mw06v9UFi=tMA@mail.gmail.com>
 <Y+T2FLrNtQkfg9bd@u40bc5e070a0153.ant.amazon.com>
In-Reply-To: <Y+T2FLrNtQkfg9bd@u40bc5e070a0153.ant.amazon.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 9 Feb 2023 14:44:49 +0100
Message-ID: <CAKfTPtC7kq0sX3i_Nba6b=yYWczugYb=t0O7U2F7bLJ6KP19nQ@mail.gmail.com>
Subject: Re: [bug-report] possible s64 overflow in max_vruntime()
To:     Roman Kagan <rkagan@amazon.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Chen Yu <yu.c.chen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Zhang Qiao <zhangqiao22@huawei.com>,
        Waiman Long <longman@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Feb 2023 at 14:33, Roman Kagan <rkagan@amazon.de> wrote:
>
> On Thu, Feb 09, 2023 at 12:26:12PM +0100, Vincent Guittot wrote:
> > On Wed, 8 Feb 2023 at 19:09, Roman Kagan <rkagan@amazon.de> wrote:
> > > On Wed, Feb 08, 2023 at 11:13:35AM +0100, Vincent Guittot wrote:
> > > > On Tue, 7 Feb 2023 at 20:37, Roman Kagan <rkagan@amazon.de> wrote:
> > > > >
> > > > > On Tue, Jan 31, 2023 at 12:10:29PM +0100, Vincent Guittot wrote:
> > > > > > On Tue, 31 Jan 2023 at 11:00, Roman Kagan <rkagan@amazon.de> wrote:
> > > > > > > On Tue, Jan 31, 2023 at 11:21:17AM +0800, Chen Yu wrote:
> > > > > > > > On 2023-01-27 at 17:18:56 +0100, Vincent Guittot wrote:
> > > > > > > > > On Fri, 27 Jan 2023 at 12:44, Peter Zijlstra <peterz@infradead.org> wrote:
> > > > > > > > > >
> > > > > > > > > > On Thu, Jan 26, 2023 at 07:31:02PM +0100, Roman Kagan wrote:
> > > > > > > > > >
> > > > > > > > > > > > All that only matters for small sleeps anyway.
> > > > > > > > > > > >
> > > > > > > > > > > > Something like:
> > > > > > > > > > > >
> > > > > > > > > > > >         sleep_time = U64_MAX;
> > > > > > > > > > > >         if (se->avg.last_update_time)
> > > > > > > > > > > >           sleep_time = cfs_rq_clock_pelt(cfs_rq) - se->avg.last_update_time;
> > > > > > > > > > >
> > > > > > > > > > > Interesting, why not rq_clock_task(rq_of(cfs_rq)) - se->exec_start, as
> > > > > > > > > > > others were suggesting?  It appears to better match the notion of sleep
> > > > > > > > > > > wall-time, no?
> > > > > > > > > >
> > > > > > > > > > Should also work I suppose. cfs_rq_clock takes throttling into account,
> > > > > > > > > > but that should hopefully also not be *that* long, so either should
> > > > > > > > > > work.
> > > > > > > > >
> > > > > > > > > yes rq_clock_task(rq_of(cfs_rq)) should be fine too
> > > > > > > > >
> > > > > > > > > Another thing to take into account is the sleeper credit that the
> > > > > > > > > waking task deserves so the detection should be done once it has been
> > > > > > > > > subtracted from vruntime.
> > > > > > > > >
> > > > > > > > > Last point, when a nice -20 task runs on a rq, it will take a bit more
> > > > > > > > > than 2 seconds for the vruntime to be increased by more than 24ms (the
> > > > > > > > > maximum credit that a waking task can get) so threshold must be
> > > > > > > > > significantly higher than 2 sec. On the opposite side, the lowest
> > > > > > > > > possible weight of a cfs rq is 2 which means that the problem appears
> > > > > > > > > for a sleep longer or equal to 2^54 = 2^63*2/1024. We should use this
> > > > > > > > > value instead of an arbitrary 200 days
> > > > > > > > Does it mean any threshold between 2 sec and 2^54 nsec should be fine? Because
> > > > > > > > 1. Any task sleeps longer than 2 sec will get at most 24 ms(sysctl_sched_latency)
> > > > > > > >    'vruntime bonus' when enqueued.
> > > > > >
> > > > > > This means that if a task nice -20 runs on cfs rq while your task is
> > > > > > sleeping 2seconds, the min vruntime of the cfs rq will increase by
> > > > > > 24ms. If there are 2 nice -20 tasks then the min vruntime will
> > > > > > increase by 24ms after 4 seconds and so on ...
> > > > > >
> > > > > > On the other side, a task nice 19 that runs 1ms will increase its
> > > > > > vruntime by around 68ms.
> > > > > >
> > > > > > So if there is 1 task nice 19 with 11 tasks nice -20 on the same cfs
> > > > > > rq, the nice -19 one should run 1ms every 65 seconds and this also
> > > > > > means that the vruntime of task nice -19 should still be above
> > > > > > min_vruntime after sleeping 60 seconds. Of course this is even worse
> > > > > > with a child cgroup with the lowest weight (weight of 2 instead of 15)
> > > > > >
> > > > > > Just to say that 60 seconds is not so far away and 2^54 should be better IMHO
> > > > >
> > > > > If we go this route, what would be the proper way to infer this value?
> > > > > Looks like
> > > > >
> > > > >   (1ull << 63) / NICE_0_LOAD * scale_load(MIN_SHARES)
> > > >
> > > > (1ull << 63) / NICE_0_LOAD * MIN_SHARES
> > >
> > > On 64bit platforms NICE_0_LOAD == 1L << 20 (i.e. it's also scaled) for
> > > better precision.  So this will yield 2^63 / 2^20 * 2 = 2^44.  Good
> > > enough probably but confusing.
> >
> > Something like the below should be enough to explain the value
> >
> > /*
> >  * min_vruntime can move forward much faster than real time. The worst case
> >  * happens when an entity with the min weight always runs on the cfs rq. In this
> >  * case, the max comparison between vruntime and min_vruntime can fail after a
> >  * sleep greater than :
> >  *     (1ull << 63) / NICE_0_LOAD) * MIN_SHARES
>
> Sorry if I'm being dense, but aren't NICE_0_LOAD and MIN_SHARES measured
> in different units: the former is scaled while the latter is not?

There are 2 usages of MIN_SHARES:
- one when setting cgroup weight in __sched_group_set_shares() which
uses  scale_load(MIN_SHARES)
- one when sharing this weight between the cfs of the group in
calc_group_shares() : clamp_t(long, shares, MIN_SHARES, tg_shares)

The 2nd one is the most important in our case that's why I use
MIN_SHARES and not scale_load(MIN_SHARES)

>
> >  * We can simplify this to :
> >  *     (1ull << 63) / NICE_0_LOAD)
> >  */
> > #define SLEEP_VRUNTIME_OVERFLOW  ((1ull << 63) / NICE_0_LOAD)
>
> Thanks,
> Roman.
>
>
>
> Amazon Development Center Germany GmbH
> Krausenstr. 38
> 10117 Berlin
> Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
> Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
> Sitz: Berlin
> Ust-ID: DE 289 237 879
>
>
>
