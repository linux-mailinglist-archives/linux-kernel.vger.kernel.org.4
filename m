Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E19068D14B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 09:08:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231149AbjBGIIT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 03:08:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231150AbjBGIIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 03:08:17 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A10B360B5
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 00:08:15 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id m2so14869280plg.4
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 00:08:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=G70bULgPL9fdQXocwdHUVMjh7UQgpbvkeMtoCs+OI0I=;
        b=TOyYLpdVawYR4HdBcjCCPNpTFBEpls0R+TrxZB7xE+huJkdw+VwifkhD9Z4fsR0Oav
         dp5tKSLuWpHN26vcw7mV7eXXIjoZgvv3KKKOfg5Q28IoJV85lmeKf6nD4Z4zDj7jW5k1
         l9krn3IaXM9t/SmhZW2Jzqb+DJF0d3i7g7dlrKSBHpWrg+AfaUm88Vg3IZD/3q6P0Fmk
         AFFenxZFBy04g9kbE0Muw72Ky521Rzn/YFnjEF8yFd/l4AJHDykxieR6CQTTFYzN6Vju
         2FyRfZ3IKkT62oJJiQhkIem4wH+SSPhKjjhJypj2NwDZqyzjo+AITkoljca9DeLg7+/z
         4RGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G70bULgPL9fdQXocwdHUVMjh7UQgpbvkeMtoCs+OI0I=;
        b=KsxLPZiIRnBH78Llw0RQfKWHlYWgC26qUQVIgDdxSA5bgx8ijCrrmAsHitKEhjLvLc
         uYzFafmUZpQH9P9sv6bYeXscHIlwME6gI4W7g+ALNHH9iHuZOMZINAA1KPrSCZdASuEH
         6NoDleabMkUOUCPMa6s+cCkqkeHNkStU0xqvTw6zuNd/k2kN236hIUn7c2oUSBI9FFiF
         n5VXYRiqOS4D9b8zAVUIxvSa8kK2WLkdfQDoxrEIQZnHo76VGtD8aolLjpHMlW8hF5g6
         YW4SNXt9qsSsC59fz6lBdkFEpL835p6XwR9yrg5GIbyCEExGLGFEw8T8e8RUD/eX/zvq
         Kb3A==
X-Gm-Message-State: AO0yUKUikLJkWaZkbhgnv18SIYTsabTLALfKhrhrEtjGUq/gVQNX93n1
        EwEENzdIU2j4fhuPGV/nmbKO0YZT77dxBW5jWSpH5g==
X-Google-Smtp-Source: AK7set+J4pCn9gEWx12PtHky4Kw/WJEyWdvRgJGl/otq1WQHndZxo6sr3w0dIrC46jFXx4KI/ZFEFUeyUOH86b1iuwk=
X-Received: by 2002:a17:90a:c7cf:b0:230:a5d7:a479 with SMTP id
 gf15-20020a17090ac7cf00b00230a5d7a479mr1842392pjb.62.1675757294874; Tue, 07
 Feb 2023 00:08:14 -0800 (PST)
MIME-Version: 1.0
References: <20230201012032.2874481-1-xii@google.com> <Y9zZDcIua63WOdG7@hirez.programming.kicks-ass.net>
 <CAOBoifgz0pRCBUqo7+X2BKgSuHmQLB6X0LZ9D2eYvboO5yzybg@mail.gmail.com>
 <CAKfTPtCpfrCbi+ZRtBFV0NfQfv9r1oe30BZM4D3_70PQGkxCdw@mail.gmail.com> <CAOBoifh_=fJe6Qk7=Qi+R1fXyjmpVHpHsceUwKrX2e9oVAd5AQ@mail.gmail.com>
In-Reply-To: <CAOBoifh_=fJe6Qk7=Qi+R1fXyjmpVHpHsceUwKrX2e9oVAd5AQ@mail.gmail.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 7 Feb 2023 09:08:03 +0100
Message-ID: <CAKfTPtAydN_GR_e1PKo9b9C3rqixyQo=kxE7nLOZdOhf-Z1Bhw@mail.gmail.com>
Subject: Re: [PATCH] sched: Consider capacity for certain load balancing decisions
To:     Xi Wang <xii@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Ben Segall <bsegall@google.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Feb 2023 at 02:03, Xi Wang <xii@google.com> wrote:
>
> On Mon, Feb 6, 2023 at 1:28 AM Vincent Guittot
> <vincent.guittot@linaro.org> wrote:
> >
> > On Fri, 3 Feb 2023 at 19:47, Xi Wang <xii@google.com> wrote:
> > >
> > > On Fri, Feb 3, 2023 at 1:51 AM Peter Zijlstra <peterz@infradead.org> wrote:
> > > >
> > > > On Tue, Jan 31, 2023 at 05:20:32PM -0800, Xi Wang wrote:
> > > > > After load balancing was split into different scenarios, CPU capacity
> > > > > is ignored for the "migrate_task" case, which means a thread can stay
> > > > > on a softirq heavy cpu for an extended amount of time.
> > > > >
> > > > > By comparing nr_running/capacity instead of just nr_running we can add
> > > > > CPU capacity back into "migrate_task" decisions. This benefits
> > > > > workloads running on machines with heavy network traffic. The change
> > > > > is unlikely to cause serious problems for other workloads but maybe
> > > > > some corner cases still need to be considered.
> > > > >
> > > > > Signed-off-by: Xi Wang <xii@google.com>
> > > > > ---
> > > > >  kernel/sched/fair.c | 3 ++-
> > > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > > > index 0f8736991427..aad14bc04544 100644
> > > > > --- a/kernel/sched/fair.c
> > > > > +++ b/kernel/sched/fair.c
> > > > > @@ -10368,8 +10368,9 @@ static struct rq *find_busiest_queue(struct lb_env *env,
> > > > >                       break;
> > > > >
> > > > >               case migrate_task:
> > > > > -                     if (busiest_nr < nr_running) {
> > > > > +                     if (busiest_nr * capacity < nr_running * busiest_capacity) {
> > > > >                               busiest_nr = nr_running;
> > > > > +                             busiest_capacity = capacity;
> > > > >                               busiest = rq;
> > > > >                       }
> > > > >                       break;
> > > >
> > > > I don't think this is correct. The migrate_task case is work-conserving,
> > > > and your change can severely break that I think.
> > > >
> > >
> > > I think you meant this kind of scenario:
> > > cpu 0: idle
> > > cpu 1: 2 tasks
> > > cpu 2: 1 task but only has 30% of capacity
> > > Pulling from cpu 2 is good for the task but lowers the overall cpu
> > > throughput.
> > >
> > > The problem we have is:
> > > cpu 0: idle
> > > cpu 1: 1 task
> > > cpu 2: 1 task but only has 60% of capacity due to net softirq
> > > The task on cpu 2 stays there and runs slower. (This can also be
> > > considered non work-conserving if we account softirq like a task.)
> >
> > When load_balance runs for this 2 cpus, cpu2 should be tagged as
> > misfit_task because of reduce_capacity and should be selected in
> > priority by cpu0 to pull the task. Do you have more details on your
> > topology ?
>
> The topology is 64 core AMD with 2 hyperthreads.
>
> I am not familiar with the related code but I think there are cases
> where a task fits cpu capacity but it can still run faster elsewhere,
> e.g.: Bursty workloads. Thread pool threads with variable utilization
> because it would process more or less requests based on cpu
> availability (pick the next request from a shared queue when the
> previous one is done). A thread having enough cpu cycles but runs
> slower due to softirqs can also directly affect application
> performance.

misfit_task is also used to detect CPUs with reduced capacity. We can
have a look at update_sg_lb_stats(). Your use case above should fall
in this case

>
> > >
> > > Maybe the logic can be merged like this: Use capacity but pick from
> > > nr_running > 1 cpus first, then nr_running == 1 cpus if not found.
