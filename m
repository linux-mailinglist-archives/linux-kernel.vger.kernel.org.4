Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBA0B72DD66
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 11:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241213AbjFMJOc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 05:14:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241827AbjFMJOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 05:14:02 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12ED618E
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 02:14:01 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-56d07c7cf03so30583597b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 02:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686647640; x=1689239640;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5XKwkcBm70r7VuBi7ciDsFX317CdhXauXlnVU/xMwL8=;
        b=GCrEDgw/6pgwgpD+QkP7LBBFGl4C92L8cuWq+viv5cLbq30yAvTZrGyPYhh3WOJPGi
         lnHZudnXnLBc5t26/SKeaoFSJcAfIT90/ollbbR9VFjmwR8frx3GbW3ybNhmkQFz1kdO
         qClEqIPwJMy66mxiWwZeaUvIMIWC8uXcaeo4I+rbgu1CK4/60aNDVfrTEgoRV+wNaq+D
         Zk4j5Sbaoc/KkgjK7e4iPZsoBQflHc+cMT8vd++/wJ5aeWFyqL7eoqhdQjkQtiu4TuHa
         87lA0FIYFrxFvlWx6fD00fp7sRkjuZpMt160rPTkoki6EWBRs2LVopWxPN85qp7YJI5U
         fu7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686647640; x=1689239640;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5XKwkcBm70r7VuBi7ciDsFX317CdhXauXlnVU/xMwL8=;
        b=LqosfWyxhMJhZgtzthEC1hdIlArb7ib8cvUuJV699Iixp3/g0xdGkelyNcwo+iRs1A
         gw/wx0umhvzbuNXbGaZNFvxCqZsQq4oha2cn4NAkK95sHDpjNmKiBTo4q3lqkO56Dh7F
         tOZIGc3POSdjMGH/Ll6/hjj6RW7PRtJ/0sohF4mmLvHBbawIQLK+qRgbjRaoy4JY784z
         kz2/FSsPLPSmU7WqEPx777+kbXEY85UE0Cgr3u+JQQUdYzDBZ7J4Nn9ry9st48z14dNZ
         7EUy3ixVOZRICVAM+tNkANHGqhXFou/eRBJuKnzPQdg5j9Vycy9a+60RlXlGbGHayEQ2
         YN7w==
X-Gm-Message-State: AC+VfDy5jJ0IyUTR2nkbPV4jB6vMKGjB59z3LjgHgbldlIxL8d0QLst2
        qGIfRI1xs3IhqmoftHmUR4p0gp4F7kXs5rnZLw62RmYOrf0Firvn
X-Google-Smtp-Source: ACHHUZ42lHgB5a69e3HoOiDYu2fsHJAYeWEGq8rW1sv9XVxsGk4WVwf4g70FnmK5Y+GVpTpybbHLoVTt+EZWXjLW2yo=
X-Received: by 2002:a81:93c7:0:b0:56d:2d59:dc30 with SMTP id
 k190-20020a8193c7000000b0056d2d59dc30mr1437202ywg.24.1686647640256; Tue, 13
 Jun 2023 02:14:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230613082012.49615-1-jiahao.os@bytedance.com>
 <20230613082012.49615-2-jiahao.os@bytedance.com> <c06dd33c-bc91-e0a9-096c-d135ce4fedcb@bytedance.com>
In-Reply-To: <c06dd33c-bc91-e0a9-096c-d135ce4fedcb@bytedance.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 13 Jun 2023 11:13:49 +0200
Message-ID: <CAKfTPtCDyD3SLR38uH07SFaqAeMyvwgD8pCG+DBG4CC1PeYSYg@mail.gmail.com>
Subject: Re: [PATCH v5 1/4] sched/core: Fixed missing rq clock update before
 calling set_rq_offline()
To:     Hao Jia <jiahao.os@bytedance.com>
Cc:     mingo@redhat.com, peterz@infradead.org, mingo@kernel.org,
        juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        mgorman@techsingularity.net, linux-kernel@vger.kernel.org
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

On Tue, 13 Jun 2023 at 10:31, Hao Jia <jiahao.os@bytedance.com> wrote:
>
>
>
> On 2023/6/13 Hao Jia wrote:
> > This is triggered during cpu offline when CONFIG_CPU_FREQ is enabled
> > and cpufreq is set to powersave:
> > ------------[ cut here ]------------
> > rq->clock_update_flags < RQCF_ACT_SKIP
> > WARNING: CPU: 24 PID: 754 at kernel/sched/sched.h:1496
> > enqueue_top_rt_rq+0x139/0x160
> > Call Trace:
> >   <TASK>
> >   ? intel_pstate_update_util+0x3b0/0x3b0
> >   rq_offline_rt+0x1b7/0x250
> >   set_rq_offline.part.120+0x28/0x60
> >   rq_attach_root+0xc4/0xd0
> >   cpu_attach_domain+0x3dc/0x7f0
> >   ? __schedule+0x65e/0x1310
> >   partition_sched_domains_locked+0x2a5/0x3c0
> >   rebuild_sched_domains_locked+0x477/0x830
> >   ? percpu_rwsem_wait+0x140/0x140
> >   rebuild_sched_domains+0x1b/0x30
> >   cpuset_hotplug_workfn+0x2ca/0xc90
> >   ? balance_push+0x56/0x120
> >   ? _raw_spin_unlock+0x15/0x30
> >   ? finish_task_switch+0x98/0x2f0
> >   ? __switch_to+0x116/0x410
> >   ? __schedule+0x65e/0x1310 ? internal_add_timer+0x42/0x60
> >   ? _raw_spin_unlock_irqrestore+0x23/0x40
> >   ? add_timer_on+0xd5/0x130
> >   process_one_work+0x1bc/0x3d0
> >   worker_thread+0x4c/0x380
> >   ? preempt_count_add+0x56/0xa0
> >   ? rescuer_thread+0x310/0x310
> >   kthread+0xe6/0x110
> >   ? kthread_complete_and_exit+0x20/0x20
> >   ret_from_fork+0x1f/0x30
> >
> > More detailed key function call graph:
> > rq_offline_rt()
> >    __disable_runtime()
> >      sched_rt_rq_enqueue()
> >        enqueue_top_rt_rq()
> >          cpufreq_update_util() <-- depends on CONFIG_CPU_FREQ
> >            data->func(data, *rq_clock(rq)*, flags)
> >              intel_pstate_update_util() <-- powersave policy callback function
> >
> > Before calling rq_offline_rt() we need to update the rq clock to avoid
> > using the old rq clock, So we add update_rq_clock() to set_rq_offline()
> > to update rq clock. And we use rq_lock_irqsave()/rq_unlock_irqrestore()
> > to replace raw_spin_rq_lock_irqsave()/raw_spin_rq_unlock_irqrestore()
> > in rq_attach_root() to ensure that rq->clock_update_flags are cleared
> > before updating the rq clock.
> >
> > Steps to reproduce:
> > 1. Enable CONFIG_SMP and CONFIG_CPU_FREQ when compiling the kernel
> > 2. echo 1 > /sys/kernel/debug/clear_warn_once
> > 3. cpupower -c all frequency-set -g powersave
> > 4. Run some rt tasks e.g. Create 5*n rt (100% running) tasks (on a
> >     system with n CPUs)
> > 5. Offline cpu one by one until the warninng is triggered
> >
> > Suggested-by: Ben Segall <bsegall@google.com>
> > Signed-off-by: Hao Jia <jiahao.os@bytedance.com>
>
> Hi Vincent,
>
>    Benjamin Segall suggested adding update_rq_clock() to set_rq_offline()
> instead of calling update_rq_clock() before set_rq_offline() runs.
> The code of patch1 has changed, so I removed your tag "Reviewed-by".
> Please review again.

v5 looks good to me

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

>
> Thanks,
> Hao
>
> > ---
> >   kernel/sched/core.c     | 2 +-
> >   kernel/sched/topology.c | 6 +++---
> >   2 files changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index a68d1276bab0..a8be5415daba 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -9548,6 +9548,7 @@ void set_rq_offline(struct rq *rq)
> >       if (rq->online) {
> >               const struct sched_class *class;
> >
> > +             update_rq_clock(rq);
> >               for_each_class(class) {
> >                       if (class->rq_offline)
> >                               class->rq_offline(rq);
> > @@ -9689,7 +9690,6 @@ int sched_cpu_deactivate(unsigned int cpu)
> >
> >       rq_lock_irqsave(rq, &rf);
> >       if (rq->rd) {
> > -             update_rq_clock(rq);
> >               BUG_ON(!cpumask_test_cpu(cpu, rq->rd->span));
> >               set_rq_offline(rq);
> >       }
> > diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> > index 6682535e37c8..52976eadfee9 100644
> > --- a/kernel/sched/topology.c
> > +++ b/kernel/sched/topology.c
> > @@ -487,9 +487,9 @@ static void free_rootdomain(struct rcu_head *rcu)
> >   void rq_attach_root(struct rq *rq, struct root_domain *rd)
> >   {
> >       struct root_domain *old_rd = NULL;
> > -     unsigned long flags;
> > +     struct rq_flags rf;
> >
> > -     raw_spin_rq_lock_irqsave(rq, flags);
> > +     rq_lock_irqsave(rq, &rf);
> >
> >       if (rq->rd) {
> >               old_rd = rq->rd;
> > @@ -515,7 +515,7 @@ void rq_attach_root(struct rq *rq, struct root_domain *rd)
> >       if (cpumask_test_cpu(rq->cpu, cpu_active_mask))
> >               set_rq_online(rq);
> >
> > -     raw_spin_rq_unlock_irqrestore(rq, flags);
> > +     rq_unlock_irqrestore(rq, &rf);
> >
> >       if (old_rd)
> >               call_rcu(&old_rd->rcu, free_rootdomain);
