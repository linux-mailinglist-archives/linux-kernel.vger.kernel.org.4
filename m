Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 169FD68EC7A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 11:13:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbjBHKNv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 05:13:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjBHKNs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 05:13:48 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B2FD1E5CA
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 02:13:47 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id u9so14434560plf.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 02:13:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ajz+v5GmnsPCHa5otaVKjt3qtpfl0zcXYl9C/R/GQJs=;
        b=HLjO2xZJQNT2iI4m7nCVGI/wJfQJVUD90ifPxXn2FQQSEMcOdnTQnwUuUiOQsAOnt/
         trJ3uD7Fzwg6k7EAFeKxOG1UV6D/X3DhJkx98mJF5cT5D3U5xbMCtgFGp63c2n+5Qn3u
         ppvPT4L6U0eAD4R8C7kg3bara1vAtbgVcEdTPELvINUWCKi3r1qEyj2JfjEpv4oSzTr0
         h6fok+37GEtz31Y7N9rsuX94a5t+5wpOPfQBswJQdRJT80Q2tPDCUzvIykH9dK0XXEdD
         RcYpvT+KElOnRrTBEdYL5uuOCK2Gyw0co2YqMHMvy9tQfI340YDhEjO8Y+EXqt7hQYlZ
         HRhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ajz+v5GmnsPCHa5otaVKjt3qtpfl0zcXYl9C/R/GQJs=;
        b=hFNUiAo6sAhXABA5Jt4Cd57ZNE6bWR86P2r3GSXfQV0gB04M3QMna5euLT9igiaLWi
         vGEeNb686bvh2dz8nRpSaG/+6VbaHbc8lcQooB0XbOinW8sXNN905mKV4lAbtmno099R
         VrQqAeC9LaceYCf6BqLnfH5f5icAHS3jfnHsfH8SwBpKeNu0NM0bWxlTZFIAiPRQTBew
         jYaah/y9xCKUpLvSgn/gFXBbEd8OObCfCWColqhQlbIDAFXM/uaTqz/Wdfqbr5k6vnhZ
         W5CBlgPrtJ8JgSRYMntZQn4rgxfPgl+ZqTswDjaxJZMysj5qRGU8x8czrZM4Y4gUiFHW
         RUwQ==
X-Gm-Message-State: AO0yUKWXyMzHUfLz4+yTsO3Htdo1KNcg/0U4+2Ej8UtjLGs80HBQ0JB/
        KvNjQrWJEUIdsfNqNzeZ9eJxqjTjpN6Y/PLdILKkcA==
X-Google-Smtp-Source: AK7set+wVb8AfqRiZi5GhvSicAJtAGdQsISIQi9R8FQK+948XD+A90Hif1HCCjeQxHUX+BMqWkj4qwcIHBGHhuSqi+I=
X-Received: by 2002:a17:90a:6844:b0:230:a5d7:a479 with SMTP id
 e4-20020a17090a684400b00230a5d7a479mr631342pjm.62.1675851226533; Wed, 08 Feb
 2023 02:13:46 -0800 (PST)
MIME-Version: 1.0
References: <73e639d5-702b-0d03-16d9-a965b1963ef6@huawei.com>
 <Y6RRfF5yRew7rdCp@hirez.programming.kicks-ass.net> <Y9GG3N5ivVvyETa2@u40bc5e070a0153.ant.amazon.com>
 <Y9J25xMrItpeHIxD@hirez.programming.kicks-ass.net> <Y9LG5vkf/4ufJb35@u40bc5e070a0153.ant.amazon.com>
 <Y9O5Fwfib2CVAMwl@hirez.programming.kicks-ass.net> <CAKfTPtBMSg2SDXq=sVt99TyM+tEXRFL74EQ57-t5uKYAXUUyLg@mail.gmail.com>
 <Y9iJLQxyXp9+x2aF@chenyu5-mobl1> <Y9jmm5c5vT8WXsl6@u40bc5e070a0153.ant.amazon.com>
 <CAKfTPtDUMph262w5OSiSQi-BVcNRf2gN=PdmxYCKEuk-8aYhgA@mail.gmail.com> <Y+Kob8kOUFa0FnJN@u40bc5e070a0153.ant.amazon.com>
In-Reply-To: <Y+Kob8kOUFa0FnJN@u40bc5e070a0153.ant.amazon.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 8 Feb 2023 11:13:35 +0100
Message-ID: <CAKfTPtC8hQ9JysoRNF0egsp+B9+9r4YFC_1-KBnu0GpXts27kw@mail.gmail.com>
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

On Tue, 7 Feb 2023 at 20:37, Roman Kagan <rkagan@amazon.de> wrote:
>
> On Tue, Jan 31, 2023 at 12:10:29PM +0100, Vincent Guittot wrote:
> > On Tue, 31 Jan 2023 at 11:00, Roman Kagan <rkagan@amazon.de> wrote:
> > > On Tue, Jan 31, 2023 at 11:21:17AM +0800, Chen Yu wrote:
> > > > On 2023-01-27 at 17:18:56 +0100, Vincent Guittot wrote:
> > > > > On Fri, 27 Jan 2023 at 12:44, Peter Zijlstra <peterz@infradead.org> wrote:
> > > > > >
> > > > > > On Thu, Jan 26, 2023 at 07:31:02PM +0100, Roman Kagan wrote:
> > > > > >
> > > > > > > > All that only matters for small sleeps anyway.
> > > > > > > >
> > > > > > > > Something like:
> > > > > > > >
> > > > > > > >         sleep_time = U64_MAX;
> > > > > > > >         if (se->avg.last_update_time)
> > > > > > > >           sleep_time = cfs_rq_clock_pelt(cfs_rq) - se->avg.last_update_time;
> > > > > > >
> > > > > > > Interesting, why not rq_clock_task(rq_of(cfs_rq)) - se->exec_start, as
> > > > > > > others were suggesting?  It appears to better match the notion of sleep
> > > > > > > wall-time, no?
> > > > > >
> > > > > > Should also work I suppose. cfs_rq_clock takes throttling into account,
> > > > > > but that should hopefully also not be *that* long, so either should
> > > > > > work.
> > > > >
> > > > > yes rq_clock_task(rq_of(cfs_rq)) should be fine too
> > > > >
> > > > > Another thing to take into account is the sleeper credit that the
> > > > > waking task deserves so the detection should be done once it has been
> > > > > subtracted from vruntime.
> > > > >
> > > > > Last point, when a nice -20 task runs on a rq, it will take a bit more
> > > > > than 2 seconds for the vruntime to be increased by more than 24ms (the
> > > > > maximum credit that a waking task can get) so threshold must be
> > > > > significantly higher than 2 sec. On the opposite side, the lowest
> > > > > possible weight of a cfs rq is 2 which means that the problem appears
> > > > > for a sleep longer or equal to 2^54 = 2^63*2/1024. We should use this
> > > > > value instead of an arbitrary 200 days
> > > > Does it mean any threshold between 2 sec and 2^54 nsec should be fine? Because
> > > > 1. Any task sleeps longer than 2 sec will get at most 24 ms(sysctl_sched_latency)
> > > >    'vruntime bonus' when enqueued.
> >
> > This means that if a task nice -20 runs on cfs rq while your task is
> > sleeping 2seconds, the min vruntime of the cfs rq will increase by
> > 24ms. If there are 2 nice -20 tasks then the min vruntime will
> > increase by 24ms after 4 seconds and so on ...
> >
> > On the other side, a task nice 19 that runs 1ms will increase its
> > vruntime by around 68ms.
> >
> > So if there is 1 task nice 19 with 11 tasks nice -20 on the same cfs
> > rq, the nice -19 one should run 1ms every 65 seconds and this also
> > means that the vruntime of task nice -19 should still be above
> > min_vruntime after sleeping 60 seconds. Of course this is even worse
> > with a child cgroup with the lowest weight (weight of 2 instead of 15)
> >
> > Just to say that 60 seconds is not so far away and 2^54 should be better IMHO
>
> If we go this route, what would be the proper way to infer this value?
> Looks like
>
>   (1ull << 63) / NICE_0_LOAD * scale_load(MIN_SHARES)

(1ull << 63) / NICE_0_LOAD * MIN_SHARES

>
> Is there any other definition that stipulates the lowest weight to be 2?

no, at task level the min weight is 3 for sched idle task.

> Besides, MIN_SHARES is under #ifdef CONFIG_FAIR_GROUP_SCHED, so the
> above expression would require more #ifdef-s.

(1ull << 63) / NICE_0_LOAD
could be a reasonable shortcut I think

>
> (That said, I'm still not convinced being math-precise here is
> practical, and slightly violating fairness in such a skewed setup is
> really something to be afraid of.)

We regularly have people complaining that sched_idle tasks (with a
weight of 3) wake up too often and steal time. The 60 seconds may just
make the situation happen more frequently

Vincent
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
