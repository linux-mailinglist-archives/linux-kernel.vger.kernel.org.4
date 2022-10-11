Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 931965FB8F9
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 19:10:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbiJKRKn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 13:10:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbiJKRKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 13:10:37 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 424AF43AD3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 10:10:35 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id b1so17110904lfs.7
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 10:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aUZA431KT/j2hV+gZNIt4UxiEOBM1cd7l6LDaY33KJI=;
        b=R+wOwikJPg2V/RCLwjYc/kansbIIUe9WkxBY1njNYHMvy6nmAVz8xu+Ap1ZnQ3sG+Q
         BX8wElKZf2Cc94urIIAabBSAkRroNEENLpGBEYgqsxG2jbbV/kUnIgck+sNTggnVWZ5F
         hFhfqWtBosJhJ8qgpGgtof/9T5SDSnKAJRRJUF301BjGMrp8KemjgccGNANfzPG6cFA8
         GY3x8tOljinQOWnu6E9tDCWi9ioff01VNpBC1Y7RwhDF2lO5BoctIWk+8l+NBnf0WgrQ
         XmkSYWO+ZoFhkYFnXBZ5um5sP6lggktKXPkdhJYLHmjIuELrbrGxW/TBmD59tWm0FULj
         La8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aUZA431KT/j2hV+gZNIt4UxiEOBM1cd7l6LDaY33KJI=;
        b=i3wz6w8bNf9ry/HW6nfnwB5ThgOdA9qhyUGo1uHuQ6avY7BMfnSEoE6i2oVEjRV6/e
         Iax2YtNBOdkxoX6mIvMIxDfUNllKKGP4o6hdnL4kILzl4AcDbr8zcclLOkM+rT/B9VsP
         oKSDV42jzON81E91MLSH0xgvvwC8pQJzNDkS1pbrtogAPsPryzIMC3YCA7QrN4mr4cNH
         o5iFQUVZnXoZmLvLzdJKzw5k8OoWsioNJL9W8C3EHjvwmxA6q2cuVpjnx1mCd/6VCpPQ
         t24kHz8vwQf22f2pgq/FwQBdLSkYV04+Hkr8xi1vRnz2W+uzRtti9ixLSHLU4v+FcszD
         /jYA==
X-Gm-Message-State: ACrzQf2MrwgOsQLHnPA4d4elTuO7cEF84w64nJ+HNhvjsL+KaYF/Ia+c
        mAWGVTPtTZem5SFKViKe52JLqo/XgMqp/Va9Bw2Ang==
X-Google-Smtp-Source: AMsMyM7zpZMh6obe/bxMMMSbzxBiqe8jTCs/HDQQUdm5CX8FZpJs3efz+AayQrgm0NpJ1bDWf19NjwB62FpEMnu/ldM=
X-Received: by 2002:ac2:5b9b:0:b0:4a2:3c73:b5ec with SMTP id
 o27-20020ac25b9b000000b004a23c73b5ecmr8538287lfn.18.1665508233280; Tue, 11
 Oct 2022 10:10:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220925143908.10846-1-vincent.guittot@linaro.org>
 <20220925143908.10846-8-vincent.guittot@linaro.org> <CA+q576OoP6Ebax8aGM234JRf+WOJFEwChs25qB9M_rt7+r1wuA@mail.gmail.com>
In-Reply-To: <CA+q576OoP6Ebax8aGM234JRf+WOJFEwChs25qB9M_rt7+r1wuA@mail.gmail.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 11 Oct 2022 19:10:21 +0200
Message-ID: <CAKfTPtAh30v=XoJPvAeFxu274CDW0uf2UY4Z8ySJz123ko5xgw@mail.gmail.com>
Subject: Re: [PATCH v5 7/7] sched/fair: Add latency list
To:     Youssef Esmat <youssefesmat@chromium.org>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, parth@linux.ibm.com,
        qais.yousef@arm.com, chris.hyser@oracle.com,
        valentin.schneider@arm.com, patrick.bellasi@matbug.net,
        David.Laight@aculab.com, pjt@google.com, pavel@ucw.cz,
        tj@kernel.org, qperret@google.com, tim.c.chen@linux.intel.com,
        joshdon@google.com, timj@gnu.org, joel@joelfernandes.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Youssef,

On Sat, 8 Oct 2022 at 03:05, Youssef Esmat <youssefesmat@chromium.org> wrote:
>
> Hi Vincent,
>
>
> On Sun, Sep 25, 2022 at 9:39 AM Vincent Guittot
> <vincent.guittot@linaro.org> wrote:
> >
> > Add a rb tree for latency sensitive entities so we can schedule the most
> > sensitive one first even when it failed to preempt current at wakeup or
> > when it got quickly preempted by another entity of higher priority.
> >
> > In order to keep fairness, the latency is used once at wakeup to get a
> > minimum slice and not during the following scheduling slice to prevent
> > long running entity to got more running time than allocated to his nice
> > priority.
> >
> > The rb tree nebales to cover the last corner case where latency
> > sensitive entity can't got schedule quickly after the wakeup.
> >
> > hackbench -l 10000 -g $group &
> > cyclictest --policy other -D 5 -q -n
> >         latency 0           latency -20
> > group   min  avg    max     min  avg    max
> > 0       17    19     29      17   18     30
> > 1       65   306   7149      64   83    208
> > 4       50   395  15731      56   80    271
> > 8       56   781  41548      54   80    301
> > 16      60  1392  87237      59   86    490
> >
> > group = 0 means that hackbench is not running.
> >
> > Both avg and max are significantly improved with nice latency -20. If we
> > add the histogram parameters to get details of latency, we have :
> >
> > hackbench -l 10000 -g 16 &
> > cyclictest --policy other -D 5 -q -n  -H 20000 --histfile data.txt
> >               latency 0    latency -20
> > Min Latencies:    60           61
> > Avg Latencies:  1077           86
> > Max Latencies: 87311          444
> > 50% latencies:    92           85
> > 75% latencies:   554           90
> > 85% latencies:  1019           93
> > 90% latencies:  1346           96
> > 95% latencies:  5400          100
> > 99% latencies: 19044          110
> >
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > ---
>
> The ability to boost the latency sensitivity of a task seems very
> interesting. I have been playing around with these changes and have
> some observations.
>
> I tried 2 bursty tasks affinitized to the same CPU. The tasks sleep
> for 1ms and run for 10ms in a loop. I first tried it without adjusting
> the latency_nice value and took perf sched traces:

The CPU is overloaded almost all the time as it can't run the 2 tasks
(2*10ms every 11ms)

>
> latency_test:7040     |   2447.137 ms |        8 | avg:   6.546 ms |
> max:  10.674 ms | max start:   353.809487 s | max end:   353.820161 s
> latency_test:7028     |   2454.777 ms |        7 | avg:   4.494 ms |
> max:  10.609 ms | max start:   354.804386 s | max end:   354.814995 s
>
> Everything looked as expected, for a 5s run they had similar runtime
> and latency.
>
> I then adjusted one task to have a latency_nice of -20 (pid 8614
> below) and took another set of traces:
>
> latency_test:8618     |   1845.534 ms |      131 | avg:   9.764 ms |
> max:  10.686 ms | max start:  1405.737905 s | max end:  1405.748592 s
> latency_test:8614     |   3033.635 ms |       16 | avg:   3.559 ms |
> max:  10.467 ms | max start:  1407.594751 s | max end:  1407.605218 s
>
> The task with -20 latency_nice had significantly more runtime. The
> average latency was improved but the max roughly stayed the same. As
> expected the one with latency_nice value of 0 experienced more
> switches, but so did the one with latency_nice of -20.

Your results look unexpected because the vruntime of the tasks is not
modified. So I can imagine that the thread with the low latency runs
first up to the offset at the beg of the test but then they should
switch regularly. I have tried a similar test with a modified rt-app
and the result seems ok. I have a small difference but not the
difference that you see.

Could you share more details about your setup ? I'm going to try to
reproduce your sequence

>
> Also tried running the same test but instead of using latency nice I
> adjusted the nice value as a comparison. In that case one task had a
> nice of -5 and the other was 0.
>
> nice_test:25219       |   1216.839 ms |      242 | avg:  10.295 ms |
> max:  11.927 ms | max start:  5877.881279 s | max end:  5877.893206 s
> nice_test:25235       |   3711.788 ms |        6 | avg:   1.026 ms |
> max:   6.143 ms | max start:  5875.603741 s | max end:  5875.609883 s
>
> As expected the one with a nice value of -5 had more runtime but also
> had better latency numbers than in the previous case of using
> latency_nice.
>
> I also tried a similar test with 3 bursty tasks instead of two. In
> this case all tasks had a latency_nice of 0:
>
> latency_test:11467    |   1641.131 ms |      161 | avg:  17.489 ms |
> max:  21.011 ms | max start:  1542.656275 s | max end:  1542.677286 s
> latency_test:11463    |   1644.809 ms |      161 | avg:  11.994 ms |
> max:  25.012 ms | max start:  1545.657776 s | max end:  1545.682788 s
> latency_test:11478    |   1643.211 ms |      160 | avg:  11.465 ms |
> max:  21.012 ms | max start:  1546.159026 s | max end:  1546.180038 s
>
> Next I tried two tasks with a latency_nice of 0 and a third one had a
> latency_nice of -20 (pid 11763 below):
>
> latency_test:11763    |   1645.482 ms |      159 | avg:  19.634 ms |
> max:  31.016 ms | max start:  1623.834862 s | max end:  1623.865877 s
> latency_test:11750    |   1644.276 ms |      259 | avg:   9.985 ms |
> max:  21.012 ms | max start:  1623.953921 s | max end:  1623.974933 s
> latency_test:11747    |   1642.745 ms |      262 | avg:   9.079 ms |
> max:  25.013 ms | max start:  1620.980435 s | max end:  1621.005447 s
>
> In this case it seemed like the runtime was not affected by the
> latency_nice value, but strangely the task with the latency nice of
> -20 had a worse average and max latency than the other two. The
> context switch times are also increased from the previous case.
>
> Have we considered an approach where the task that is marked as
> latency sensitive gets a boosted nice value when it sleeps and is
> either scaled down exponentially as it runs, or immediately reset to
> its default when it runs for one tick?
>
> Thanks,
> Youssef
>
>
> >  include/linux/sched.h |  2 +
> >  kernel/sched/fair.c   | 96 +++++++++++++++++++++++++++++++++++++++++--
> >  kernel/sched/sched.h  |  1 +
> >  3 files changed, 96 insertions(+), 3 deletions(-)
> >
> > diff --git a/include/linux/sched.h b/include/linux/sched.h
> > index a74cad08e91e..0b92674e3664 100644
> > --- a/include/linux/sched.h
> > +++ b/include/linux/sched.h
> > @@ -547,6 +547,8 @@ struct sched_entity {
> >         /* For load-balancing: */
> >         struct load_weight              load;
> >         struct rb_node                  run_node;
> > +       struct rb_node                  latency_node;
> > +       unsigned int                    on_latency;
> >         struct list_head                group_node;
> >         unsigned int                    on_rq;
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index e524e892d118..1a72f34136d8 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -664,7 +664,77 @@ struct sched_entity *__pick_last_entity(struct cfs_rq *cfs_rq)
> >
> >         return __node_2_se(last);
> >  }
> > +#endif
> >
> > +/**************************************************************
> > + * Scheduling class tree data structure manipulation methods:
> > + * for latency
> > + */
> > +
> > +static inline bool latency_before(struct sched_entity *a,
> > +                               struct sched_entity *b)
> > +{
> > +       return (s64)(a->vruntime + a->latency_offset - b->vruntime - b->latency_offset) < 0;
> > +}
> > +
> > +#define __latency_node_2_se(node) \
> > +       rb_entry((node), struct sched_entity, latency_node)
> > +
> > +static inline bool __latency_less(struct rb_node *a, const struct rb_node *b)
> > +{
> > +       return latency_before(__latency_node_2_se(a), __latency_node_2_se(b));
> > +}
> > +
> > +/*
> > + * Enqueue an entity into the latency rb-tree:
> > + */
> > +static void __enqueue_latency(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
> > +{
> > +
> > +       /* Only latency sensitive entity can be added to the list */
> > +       if (se->latency_offset >= 0)
> > +               return;
> > +
> > +       if (se->on_latency)
> > +               return;
> > +
> > +       /*
> > +        * An execution time less than sysctl_sched_min_granularity means that
> > +        * the entity has been preempted by a higher sched class or an entity
> > +        * with higher latency constraint.
> > +        * Put it back in the list so it gets a chance to run 1st during the
> > +        * next slice.
> > +        */
> > +       if (!(flags & ENQUEUE_WAKEUP)) {
> > +               u64 delta_exec = se->sum_exec_runtime - se->prev_sum_exec_runtime;
> > +
> > +               if (delta_exec >= sysctl_sched_min_granularity)
> > +                       return;
> > +       }
> > +
> > +       rb_add_cached(&se->latency_node, &cfs_rq->latency_timeline, __latency_less);
> > +       se->on_latency = 1;
> > +}
> > +
> > +static void __dequeue_latency(struct cfs_rq *cfs_rq, struct sched_entity *se)
> > +{
> > +       if (se->on_latency) {
> > +               rb_erase_cached(&se->latency_node, &cfs_rq->latency_timeline);
> > +               se->on_latency = 0;
> > +       }
> > +}
> > +
> > +static struct sched_entity *__pick_first_latency(struct cfs_rq *cfs_rq)
> > +{
> > +       struct rb_node *left = rb_first_cached(&cfs_rq->latency_timeline);
> > +
> > +       if (!left)
> > +               return NULL;
> > +
> > +       return __latency_node_2_se(left);
> > +}
> > +
> > +#ifdef CONFIG_SCHED_DEBUG
> >  /**************************************************************
> >   * Scheduling class statistics methods:
> >   */
> > @@ -4455,8 +4525,10 @@ enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
> >         check_schedstat_required();
> >         update_stats_enqueue_fair(cfs_rq, se, flags);
> >         check_spread(cfs_rq, se);
> > -       if (!curr)
> > +       if (!curr) {
> >                 __enqueue_entity(cfs_rq, se);
> > +               __enqueue_latency(cfs_rq, se, flags);
> > +       }
> >         se->on_rq = 1;
> >
> >         if (cfs_rq->nr_running == 1) {
> > @@ -4542,8 +4614,10 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
> >
> >         clear_buddies(cfs_rq, se);
> >
> > -       if (se != cfs_rq->curr)
> > +       if (se != cfs_rq->curr) {
> >                 __dequeue_entity(cfs_rq, se);
> > +               __dequeue_latency(cfs_rq, se);
> > +       }
> >         se->on_rq = 0;
> >         account_entity_dequeue(cfs_rq, se);
> >
> > @@ -4631,6 +4705,7 @@ set_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *se)
> >                  */
> >                 update_stats_wait_end_fair(cfs_rq, se);
> >                 __dequeue_entity(cfs_rq, se);
> > +               __dequeue_latency(cfs_rq, se);
> >                 update_load_avg(cfs_rq, se, UPDATE_TG);
> >         }
> >
> > @@ -4669,7 +4744,7 @@ static struct sched_entity *
> >  pick_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *curr)
> >  {
> >         struct sched_entity *left = __pick_first_entity(cfs_rq);
> > -       struct sched_entity *se;
> > +       struct sched_entity *latency, *se;
> >
> >         /*
> >          * If curr is set we have to see if its left of the leftmost entity
> > @@ -4711,6 +4786,12 @@ pick_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *curr)
> >                 se = cfs_rq->last;
> >         }
> >
> > +       /* Check for latency sensitive entity waiting for running */
> > +       latency = __pick_first_latency(cfs_rq);
> > +       if (latency && (latency != se) &&
> > +           wakeup_preempt_entity(latency, se) < 1)
> > +               se = latency;
> > +
> >         return se;
> >  }
> >
> > @@ -4734,6 +4815,7 @@ static void put_prev_entity(struct cfs_rq *cfs_rq, struct sched_entity *prev)
> >                 update_stats_wait_start_fair(cfs_rq, prev);
> >                 /* Put 'current' back into the tree. */
> >                 __enqueue_entity(cfs_rq, prev);
> > +               __enqueue_latency(cfs_rq, prev, 0);
> >                 /* in !on_rq case, update occurred at dequeue */
> >                 update_load_avg(cfs_rq, prev, 0);
> >         }
> > @@ -11717,6 +11799,7 @@ static void set_next_task_fair(struct rq *rq, struct task_struct *p, bool first)
> >  void init_cfs_rq(struct cfs_rq *cfs_rq)
> >  {
> >         cfs_rq->tasks_timeline = RB_ROOT_CACHED;
> > +       cfs_rq->latency_timeline = RB_ROOT_CACHED;
> >         u64_u32_store(cfs_rq->min_vruntime, (u64)(-(1LL << 20)));
> >  #ifdef CONFIG_SMP
> >         raw_spin_lock_init(&cfs_rq->removed.lock);
> > @@ -12025,8 +12108,15 @@ int sched_group_set_latency(struct task_group *tg, s64 latency)
> >
> >         for_each_possible_cpu(i) {
> >                 struct sched_entity *se = tg->se[i];
> > +               struct rq *rq = cpu_rq(i);
> > +               struct rq_flags rf;
> > +
> > +               rq_lock_irqsave(rq, &rf);
> >
> > +               __dequeue_latency(se->cfs_rq, se);
> >                 WRITE_ONCE(se->latency_offset, latency);
> > +
> > +               rq_unlock_irqrestore(rq, &rf);
> >         }
> >
> >         mutex_unlock(&shares_mutex);
> > diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> > index a15fb955092c..76bca172585c 100644
> > --- a/kernel/sched/sched.h
> > +++ b/kernel/sched/sched.h
> > @@ -599,6 +599,7 @@ struct cfs_rq {
> >  #endif
> >
> >         struct rb_root_cached   tasks_timeline;
> > +       struct rb_root_cached   latency_timeline;
> >
> >         /*
> >          * 'curr' points to currently running entity on this cfs_rq.
> > --
> > 2.17.1
> >
> >
> >
