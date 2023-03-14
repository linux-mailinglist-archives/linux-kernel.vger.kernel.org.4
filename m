Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 777096B962B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 14:28:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230469AbjCNN1z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 09:27:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230138AbjCNN1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 09:27:25 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FDB6E195
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 06:24:50 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id a2so16584189plm.4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 06:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678800289;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MKSRtx6Azl23x98EzA2TzDFs5vK6J7ubW9rzkz5dqq8=;
        b=PbDgZRkRJzj81hjj+mNLTtgzQNd0vn7Pe/jMFsAkq6P1WvSdXXMJSNdvQuxTlxOZng
         U+h53vb0WFRQYP9pimijvCZgf9lwfZVZ9SUXjP44Ck/S2YxLUOl75JnGdhOZl1N/3QYj
         LxUt5+7i2LZhgBqcRyV17KqbF02qikkZuPyO/WcSiZSAzLHhqP+n9YIntI1+Hd+jwbOS
         oA629Y59EpthdZfCRccg7UuZxmiuHitsryV7p7Pj1q2g7pUaISj9m8eBT2PanNux2GNt
         uSh3dl5sURCY/oW/lUWtraoq9LeSkWn8siezyEU1Ah1g1/X+BzgRXbIuEce6VlukSX/4
         c9rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678800289;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MKSRtx6Azl23x98EzA2TzDFs5vK6J7ubW9rzkz5dqq8=;
        b=KCPtp/bnMjaONrwyJgsOQqlWJuorCThSbNKEcZ3jaEPIxUhKxloNOt6oHBmFoAm+51
         kr0fw7cMRWl4H3Ab19x4fClfad69QOwku2y/N8yG7Iz8ydSBNHF3UT/9MWjs5aCgEEM/
         zZJ8IFjGYdpPidx13cdD9xpXhBa8IfIfpPksk2Rnn0k8e4NXOXXkTyGX1iVhngWyXUad
         88UcwLM+GOg+9HTjMY57ABPStXrhqXCaVZGgRJvR//4ObnRh6BJqc3+2t0lyBuljcBAk
         X0VuDuO+/IN5Rige5hE+AEA7dirPjBlXhptYTtsJe/mbMetveN6e+bvtN+zTkogtt+g4
         t19Q==
X-Gm-Message-State: AO0yUKUUjUeW9aJEHWaA1/G4gCGUq7ef/af61RXDRk+CZ++MgZAu2OJt
        Zh5c0CcrdebZBuTzIJ4XQaJAUAg704Kg29Xn3ogx3A==
X-Google-Smtp-Source: AK7set82uTlhLzZTf45hjhRCs4Ou9nAAAQcqsxxMCfR0ShIBchrWHncsXLG+fwW7qaxFmsUlMOeDipb7+9IiAjdTag8=
X-Received: by 2002:a17:903:449:b0:19a:87dd:9206 with SMTP id
 iw9-20020a170903044900b0019a87dd9206mr14438163plb.0.1678800289344; Tue, 14
 Mar 2023 06:24:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230306132418.50389-1-zhangqiao22@huawei.com>
 <20230309130524.GA273121@hirez.programming.kicks-ass.net> <CAKfTPtAf5RrzZRSHtfK+r3QvnFQ-oM3+rJ-z5SB8T4+nUv1aQw@mail.gmail.com>
 <20230309142825.GB273121@hirez.programming.kicks-ass.net> <ZAnvCGdlOrWbIC/o@hirez.programming.kicks-ass.net>
 <CAKfTPtADUas2QHZCQyu0ad-JTKRQ=PcsB=o7+PuJNVxHwAzkCQ@mail.gmail.com>
 <ZAs+zV0o9ShO7nLT@vingu-book> <02a08042-e7c4-464d-bc20-9ec4ccdab1ff@arm.com>
 <8c093661-7431-00d8-d703-b8f7a7c8e747@arm.com> <CAKfTPtBw9SJxVBcN1qff7jRzE81kXSjbc-rXD6goEBFiXEwbyg@mail.gmail.com>
 <20230314120726.GG1845660@hirez.programming.kicks-ass.net>
In-Reply-To: <20230314120726.GG1845660@hirez.programming.kicks-ass.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 14 Mar 2023 14:24:37 +0100
Message-ID: <CAKfTPtBHocw4N-YMHeqfMj78Ro=aF8sJPanxVCN=tM70hr6r8g@mail.gmail.com>
Subject: Re: [PATCH v2] sched/fair: sanitize vruntime of entity being migrated
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Zhang Qiao <zhangqiao22@huawei.com>,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        juri.lelli@redhat.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        rkagan@amazon.de
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Mar 2023 at 13:07, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Mar 14, 2023 at 08:41:30AM +0100, Vincent Guittot wrote:
>
> > I'm going to use something a bit different from your proposal below by
> > merging initial and flag
> > static void place_entity(struct cfs_rq *cfs_rq, struct sched_entity
> > *se, int flags)
> >
> > with flags:
> > 0 for initial placement
> > ENQUEUE_WAKEUP for wakeup
> > ENQUEUE_MIGRATED for migrated task
>
> So when a task is not running for a long time (our case at hand), then
> there's two cases:
>
>  - it wakes up locally and place_entity() gets to reset vruntime;
>  - it wakes up remotely and migrate_task_rq_fair() can reset vruntime.
>
> So if we can rely on ENQUEUE_MIGRATED to differentiate between these
> cases, when wouldn't something like this work?
>
> ---
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 7a1b1f855b96..a0d00b6a8bc6 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -4648,11 +4648,31 @@ static void check_spread(struct cfs_rq *cfs_rq, struct sched_entity *se)
>  #endif
>  }
>
> +static bool reset_vruntime(struct cfs_rq *cfs_rq, struct sched_entity *se)
> +{
> +       const s64 limit = 60LL * NSEC_PER_SEC;
> +       s64 sleep_time;
> +
> +       /*
> +        * Pull vruntime of the entity being placed to the base level of
> +        * cfs_rq, to prevent boosting it if placed backwards.  If the entity
> +        * slept for a long time, don't even try to compare its vruntime with
> +        * the base as it may be too far off and the comparison may get
> +        * inversed due to s64 overflow.
> +        */
> +       sleep_time = rq_clock_task(rq_of(cfs_rq)) - se->exec_start;
> +       if (unlikely(sleep_time > limit)) {
> +               se->vruntime = cfs_rq->min_vruntime - calc_delta_fair(limit, se);
> +               return true;
> +       }
> +
> +       return false;
> +}
> +
>  static void
>  place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int initial)
>  {
>         u64 vruntime = cfs_rq->min_vruntime;
> -       u64 sleep_time;
>
>         /*
>          * The 'current' period is already promised to the current tasks,
> @@ -4682,18 +4702,8 @@ place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int initial)
>                 vruntime -= thresh;
>         }
>
> -       /*
> -        * Pull vruntime of the entity being placed to the base level of
> -        * cfs_rq, to prevent boosting it if placed backwards.  If the entity
> -        * slept for a long time, don't even try to compare its vruntime with
> -        * the base as it may be too far off and the comparison may get
> -        * inversed due to s64 overflow.
> -        */
> -       sleep_time = rq_clock_task(rq_of(cfs_rq)) - se->exec_start;
> -       if ((s64)sleep_time > 60LL * NSEC_PER_SEC)
> -               se->vruntime = vruntime;
> -       else
> -               se->vruntime = max_vruntime(se->vruntime, vruntime);
> +       /* ensure we don't gain time by being placed backwards */
> +       se->vruntime = max_vruntime(se->vruntime, vruntime);
>  }
>
>  static void check_enqueue_throttle(struct cfs_rq *cfs_rq);
> @@ -4768,8 +4778,11 @@ enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
>         update_cfs_group(se);
>         account_entity_enqueue(cfs_rq, se);
>
> -       if (flags & ENQUEUE_WAKEUP)
> +       if (flags & ENQUEUE_WAKEUP) {
> +               if (!(flags & ENQUEUE_MIGRATED))
> +                       reset_vruntime(cfs_rq, se);
>                 place_entity(cfs_rq, se, 0);
> +       }
>
>         check_schedstat_required();
>         update_stats_enqueue_fair(cfs_rq, se, flags);
> @@ -7625,6 +7638,7 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int wake_flags)
>  static void migrate_task_rq_fair(struct task_struct *p, int new_cpu)
>  {
>         struct sched_entity *se = &p->se;
> +       struct cfs_rq *cfs_rq = cfs_rq_of(se);
>
>         /*
>          * As blocked tasks retain absolute vruntime the migration needs to
> @@ -7632,11 +7646,8 @@ static void migrate_task_rq_fair(struct task_struct *p, int new_cpu)
>          * min_vruntime -- the latter is done by enqueue_entity() when placing
>          * the task on the new runqueue.
>          */
> -       if (READ_ONCE(p->__state) == TASK_WAKING) {
> -               struct cfs_rq *cfs_rq = cfs_rq_of(se);
> -
> +       if (READ_ONCE(p->__state) == TASK_WAKING || reset_vruntime(cfs_rq, se))

That's somehow what was proposed in one of the previous proposals but
we can't call rq_clock_task(rq_of(cfs_rq)) because rq lock might not
be hold and rq task clock has not been updated before being used

>                 se->vruntime -= u64_u32_load(cfs_rq->min_vruntime);
> -       }
>
>         if (!task_on_rq_migrating(p)) {
>                 remove_entity_load_avg(se);
