Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05E086C237A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 22:19:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbjCTVTX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 17:19:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjCTVTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 17:19:21 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC3C43A85
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 14:19:18 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-536af432ee5so247998857b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 14:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679347158;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WCoaYUQcNplMRcDY0UjQkSKaWLWJWOP1JhSpWW6QoUA=;
        b=RjKXGQgf6PJL+aD/egnvBFYIBbnrTVqH8Szj3cA6SG7Od5hQiaCfg0GKV88T31i9ZP
         KpR4Aj71id8jDeu+dEL15yYsnEK3F7qXIfbKXElo141EfNiaixFOMBUA6t6AsMka3eus
         OrAWiiyWjTXfd57D9SCZEYYehv1O+o2sZhcTRVzcCf+WIJ9nqvBIjqwzCyOnX6mySKA5
         7T392L6eB/EZzstRll6zeqz6SZv1wf16R2rtAxIELUKIBaQzfUdh9bjsw2cQnW6Gds4n
         r2It7ukDbYznMGEnkFSqGyknf3Y/iMRyl0DMixqRkB5pZyaxkn1ZAQdeMbtw73F4mKhZ
         5+6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679347158;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WCoaYUQcNplMRcDY0UjQkSKaWLWJWOP1JhSpWW6QoUA=;
        b=S8I+AlNhi1yr0oAFdx8M1St4vXQL7c9wcQNSWSTJDPoPy6G3QH3YWCOa0GffVHNsl+
         aqySbHYQjpbn/do6E97w77xhCAemo7ns/DwH0wF1wAaqBnvw0mt5/X/kSFbJduMgzyPf
         vWciNUQ4RD05NWo16V2ve8bowQz7LjfTUlKBRT6L7gzuQ9ATepRrbanj1310ltcQFPGv
         XzMX8HR4ebfXwA1Fv764EtWMkbbw7rB/R4q1Pszk/+VU+CYPALU5z8AxXO73ew0SGWyu
         3MPp97hUtr6WNweZD6vS2W3B5AXQjJxZwp7Pk4e5HV+0Db5l/RnpB0zg49SDwScaJ5Fs
         xRqw==
X-Gm-Message-State: AO0yUKW2h2iEMETCgeFjCxeHwpDF3ajBIhBm4FIMOVPwXGxyV1oBARqf
        1OR1VCxdl11cYdnUidacK/70vSSH3bVmWmYBavRN5A==
X-Google-Smtp-Source: AK7set/dPnRujp0zufYVBqciL+KAFajHXxRFCz1EBzVulRs7Osp+VwAo16/CjUMdLoQRsJs5Qi0YImBXQb15/mEVKH8=
X-Received: by 2002:a05:690c:70c:b0:541:b3dd:96a5 with SMTP id
 bs12-20020a05690c070c00b00541b3dd96a5mr10225694ywb.1.1679347157649; Mon, 20
 Mar 2023 14:19:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230309170756.52927-1-cerasuolodomenico@gmail.com> <20230309170756.52927-3-cerasuolodomenico@gmail.com>
In-Reply-To: <20230309170756.52927-3-cerasuolodomenico@gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Mon, 20 Mar 2023 14:19:06 -0700
Message-ID: <CAJuCfpH4=pWmzODT4Mk=1aFX4vPMpy23QveM-GjnksSnxzzkcQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] sched/psi: rename existing poll members in preparation
To:     Domenico Cerasuolo <cerasuolodomenico@gmail.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        brauner@kernel.org, chris@chrisdown.name, hannes@cmpxchg.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Thu, Mar 9, 2023 at 9:08=E2=80=AFAM Domenico Cerasuolo
<cerasuolodomenico@gmail.com> wrote:
>
> Renaming in PSI implementation to make a clear distinction between
> privileged and unprivileged triggers code to be implemented in the
> next patch.

This looks like a lot of churn which could be avoided if the new
unprivileged triggers were called something else, like
unpriv_triggers/unpriv_nr_triggers. But maybe even a better way would
be to have smth like this:

struct trigger_info {
       struct list_head triggers;
       u32 nr_triggers[NR_PSI_STATES - 1];
};

struct psi_group {
       ...
       struct trigger_info trig_info[NR_PSI_AGGREGATORS];
};

I think this would also simplify the update_triggers() code in the
last patch of this patchset.

>
> Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> Signed-off-by: Domenico Cerasuolo <cerasuolodomenico@gmail.com>
> ---
>  include/linux/psi_types.h |  36 ++++-----
>  kernel/sched/psi.c        | 163 +++++++++++++++++++-------------------
>  2 files changed, 100 insertions(+), 99 deletions(-)
>
> diff --git a/include/linux/psi_types.h b/include/linux/psi_types.h
> index 1e0a0d7ace3a..1819afa8b198 100644
> --- a/include/linux/psi_types.h
> +++ b/include/linux/psi_types.h
> @@ -175,26 +175,26 @@ struct psi_group {
>         u64 total[NR_PSI_AGGREGATORS][NR_PSI_STATES - 1];
>         unsigned long avg[NR_PSI_STATES - 1][3];
>
> -       /* Monitor work control */
> -       struct task_struct __rcu *poll_task;
> -       struct timer_list poll_timer;
> -       wait_queue_head_t poll_wait;
> -       atomic_t poll_wakeup;
> -       atomic_t poll_scheduled;
> +       /* Monitor RT polling work control */
> +       struct task_struct __rcu *rtpoll_task;
> +       struct timer_list rtpoll_timer;
> +       wait_queue_head_t rtpoll_wait;
> +       atomic_t rtpoll_wakeup;
> +       atomic_t rtpoll_scheduled;
>
>         /* Protects data used by the monitor */
> -       struct mutex trigger_lock;
> -
> -       /* Configured polling triggers */
> -       struct list_head triggers;
> -       u32 nr_triggers[NR_PSI_STATES - 1];
> -       u32 poll_states;
> -       u64 poll_min_period;
> -
> -       /* Total stall times at the start of monitor activation */
> -       u64 polling_total[NR_PSI_STATES - 1];
> -       u64 polling_next_update;
> -       u64 polling_until;
> +       struct mutex rtpoll_trigger_lock;
> +
> +       /* Configured RT polling triggers */
> +       struct list_head rtpoll_triggers;
> +       u32 rtpoll_nr_triggers[NR_PSI_STATES - 1];
> +       u32 rtpoll_states;
> +       u64 rtpoll_min_period;
> +
> +       /* Total stall times at the start of RT polling monitor activatio=
n */
> +       u64 rtpoll_total[NR_PSI_STATES - 1];
> +       u64 rtpoll_next_update;
> +       u64 rtpoll_until;
>  };
>
>  #else /* CONFIG_PSI */
> diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
> index fe9269f1d2a4..a3d0b5cf797a 100644
> --- a/kernel/sched/psi.c
> +++ b/kernel/sched/psi.c
> @@ -189,14 +189,14 @@ static void group_init(struct psi_group *group)
>         INIT_DELAYED_WORK(&group->avgs_work, psi_avgs_work);
>         mutex_init(&group->avgs_lock);
>         /* Init trigger-related members */
> -       atomic_set(&group->poll_scheduled, 0);
> -       mutex_init(&group->trigger_lock);
> -       INIT_LIST_HEAD(&group->triggers);
> -       group->poll_min_period =3D U32_MAX;
> -       group->polling_next_update =3D ULLONG_MAX;
> -       init_waitqueue_head(&group->poll_wait);
> -       timer_setup(&group->poll_timer, poll_timer_fn, 0);
> -       rcu_assign_pointer(group->poll_task, NULL);
> +       atomic_set(&group->rtpoll_scheduled, 0);
> +       mutex_init(&group->rtpoll_trigger_lock);
> +       INIT_LIST_HEAD(&group->rtpoll_triggers);
> +       group->rtpoll_min_period =3D U32_MAX;
> +       group->rtpoll_next_update =3D ULLONG_MAX;
> +       init_waitqueue_head(&group->rtpoll_wait);
> +       timer_setup(&group->rtpoll_timer, poll_timer_fn, 0);
> +       rcu_assign_pointer(group->rtpoll_task, NULL);
>  }
>
>  void __init psi_init(void)
> @@ -440,11 +440,11 @@ static u64 update_triggers(struct psi_group *group,=
 u64 now)
>          * On subsequent updates, calculate growth deltas and let
>          * watchers know when their specified thresholds are exceeded.
>          */
> -       list_for_each_entry(t, &group->triggers, node) {
> +       list_for_each_entry(t, &group->rtpoll_triggers, node) {
>                 u64 growth;
>                 bool new_stall;
>
> -               new_stall =3D group->polling_total[t->state] !=3D total[t=
->state];
> +               new_stall =3D group->rtpoll_total[t->state] !=3D total[t-=
>state];
>
>                 /* Check for stall activity or a previous threshold breac=
h */
>                 if (!new_stall && !t->pending_event)
> @@ -486,10 +486,10 @@ static u64 update_triggers(struct psi_group *group,=
 u64 now)
>         }
>
>         if (update_total)
> -               memcpy(group->polling_total, total,
> -                               sizeof(group->polling_total));
> +               memcpy(group->rtpoll_total, total,
> +                               sizeof(group->rtpoll_total));
>
> -       return now + group->poll_min_period;
> +       return now + group->rtpoll_min_period;
>  }
>
>  static u64 update_averages(struct psi_group *group, u64 now)
> @@ -582,53 +582,53 @@ static void init_triggers(struct psi_group *group, =
u64 now)
>  {
>         struct psi_trigger *t;
>
> -       list_for_each_entry(t, &group->triggers, node)
> +       list_for_each_entry(t, &group->rtpoll_triggers, node)
>                 window_reset(&t->win, now,
>                                 group->total[PSI_POLL][t->state], 0);
> -       memcpy(group->polling_total, group->total[PSI_POLL],
> -                  sizeof(group->polling_total));
> -       group->polling_next_update =3D now + group->poll_min_period;
> +       memcpy(group->rtpoll_total, group->total[PSI_POLL],
> +                  sizeof(group->rtpoll_total));
> +       group->rtpoll_next_update =3D now + group->rtpoll_min_period;
>  }
>
>  /* Schedule polling if it's not already scheduled or forced. */
> -static void psi_schedule_poll_work(struct psi_group *group, unsigned lon=
g delay,
> +static void psi_schedule_rtpoll_work(struct psi_group *group, unsigned l=
ong delay,
>                                    bool force)
>  {
>         struct task_struct *task;
>
>         /*
>          * atomic_xchg should be called even when !force to provide a
> -        * full memory barrier (see the comment inside psi_poll_work).
> +        * full memory barrier (see the comment inside psi_rtpoll_work).
>          */
> -       if (atomic_xchg(&group->poll_scheduled, 1) && !force)
> +       if (atomic_xchg(&group->rtpoll_scheduled, 1) && !force)
>                 return;
>
>         rcu_read_lock();
>
> -       task =3D rcu_dereference(group->poll_task);
> +       task =3D rcu_dereference(group->rtpoll_task);
>         /*
>          * kworker might be NULL in case psi_trigger_destroy races with
>          * psi_task_change (hotpath) which can't use locks
>          */
>         if (likely(task))
> -               mod_timer(&group->poll_timer, jiffies + delay);
> +               mod_timer(&group->rtpoll_timer, jiffies + delay);
>         else
> -               atomic_set(&group->poll_scheduled, 0);
> +               atomic_set(&group->rtpoll_scheduled, 0);
>
>         rcu_read_unlock();
>  }
>
> -static void psi_poll_work(struct psi_group *group)
> +static void psi_rtpoll_work(struct psi_group *group)
>  {
>         bool force_reschedule =3D false;
>         u32 changed_states;
>         u64 now;
>
> -       mutex_lock(&group->trigger_lock);
> +       mutex_lock(&group->rtpoll_trigger_lock);
>
>         now =3D sched_clock();
>
> -       if (now > group->polling_until) {
> +       if (now > group->rtpoll_until) {
>                 /*
>                  * We are either about to start or might stop polling if =
no
>                  * state change was recorded. Resetting poll_scheduled le=
aves
> @@ -638,7 +638,7 @@ static void psi_poll_work(struct psi_group *group)
>                  * should be negligible and polling_next_update still kee=
ps
>                  * updates correctly on schedule.
>                  */
> -               atomic_set(&group->poll_scheduled, 0);
> +               atomic_set(&group->rtpoll_scheduled, 0);
>                 /*
>                  * A task change can race with the poll worker that is su=
pposed to
>                  * report on it. To avoid missing events, ensure ordering=
 between
> @@ -667,9 +667,9 @@ static void psi_poll_work(struct psi_group *group)
>
>         collect_percpu_times(group, PSI_POLL, &changed_states);
>
> -       if (changed_states & group->poll_states) {
> +       if (changed_states & group->rtpoll_states) {
>                 /* Initialize trigger windows when entering polling mode =
*/
> -               if (now > group->polling_until)
> +               if (now > group->rtpoll_until)
>                         init_triggers(group, now);
>
>                 /*
> @@ -677,50 +677,50 @@ static void psi_poll_work(struct psi_group *group)
>                  * minimum tracking window as long as monitor states are
>                  * changing.
>                  */
> -               group->polling_until =3D now +
> -                       group->poll_min_period * UPDATES_PER_WINDOW;
> +               group->rtpoll_until =3D now +
> +                       group->rtpoll_min_period * UPDATES_PER_WINDOW;
>         }
>
> -       if (now > group->polling_until) {
> -               group->polling_next_update =3D ULLONG_MAX;
> +       if (now > group->rtpoll_until) {
> +               group->rtpoll_next_update =3D ULLONG_MAX;
>                 goto out;
>         }
>
> -       if (now >=3D group->polling_next_update)
> -               group->polling_next_update =3D update_triggers(group, now=
);
> +       if (now >=3D group->rtpoll_next_update)
> +               group->rtpoll_next_update =3D update_triggers(group, now)=
;
>
> -       psi_schedule_poll_work(group,
> -               nsecs_to_jiffies(group->polling_next_update - now) + 1,
> +       psi_schedule_rtpoll_work(group,
> +               nsecs_to_jiffies(group->rtpoll_next_update - now) + 1,
>                 force_reschedule);
>
>  out:
> -       mutex_unlock(&group->trigger_lock);
> +       mutex_unlock(&group->rtpoll_trigger_lock);
>  }
>
> -static int psi_poll_worker(void *data)
> +static int psi_rtpoll_worker(void *data)
>  {
>         struct psi_group *group =3D (struct psi_group *)data;
>
>         sched_set_fifo_low(current);
>
>         while (true) {
> -               wait_event_interruptible(group->poll_wait,
> -                               atomic_cmpxchg(&group->poll_wakeup, 1, 0)=
 ||
> +               wait_event_interruptible(group->rtpoll_wait,
> +                               atomic_cmpxchg(&group->rtpoll_wakeup, 1, =
0) ||
>                                 kthread_should_stop());
>                 if (kthread_should_stop())
>                         break;
>
> -               psi_poll_work(group);
> +               psi_rtpoll_work(group);
>         }
>         return 0;
>  }
>
>  static void poll_timer_fn(struct timer_list *t)
>  {
> -       struct psi_group *group =3D from_timer(group, t, poll_timer);
> +       struct psi_group *group =3D from_timer(group, t, rtpoll_timer);
>
> -       atomic_set(&group->poll_wakeup, 1);
> -       wake_up_interruptible(&group->poll_wait);
> +       atomic_set(&group->rtpoll_wakeup, 1);
> +       wake_up_interruptible(&group->rtpoll_wait);
>  }
>
>  static void record_times(struct psi_group_cpu *groupc, u64 now)
> @@ -851,8 +851,8 @@ static void psi_group_change(struct psi_group *group,=
 int cpu,
>
>         write_seqcount_end(&groupc->seq);
>
> -       if (state_mask & group->poll_states)
> -               psi_schedule_poll_work(group, 1, false);
> +       if (state_mask & group->rtpoll_states)
> +               psi_schedule_rtpoll_work(group, 1, false);
>
>         if (wake_clock && !delayed_work_pending(&group->avgs_work))
>                 schedule_delayed_work(&group->avgs_work, PSI_FREQ);
> @@ -1005,8 +1005,8 @@ void psi_account_irqtime(struct task_struct *task, =
u32 delta)
>
>                 write_seqcount_end(&groupc->seq);
>
> -               if (group->poll_states & (1 << PSI_IRQ_FULL))
> -                       psi_schedule_poll_work(group, 1, false);
> +               if (group->rtpoll_states & (1 << PSI_IRQ_FULL))
> +                       psi_schedule_rtpoll_work(group, 1, false);
>         } while ((group =3D group->parent));
>  }
>  #endif
> @@ -1101,7 +1101,7 @@ void psi_cgroup_free(struct cgroup *cgroup)
>         cancel_delayed_work_sync(&cgroup->psi->avgs_work);
>         free_percpu(cgroup->psi->pcpu);
>         /* All triggers must be removed by now */
> -       WARN_ONCE(cgroup->psi->poll_states, "psi: trigger leak\n");
> +       WARN_ONCE(cgroup->psi->rtpoll_states, "psi: trigger leak\n");
>         kfree(cgroup->psi);
>  }
>
> @@ -1302,29 +1302,29 @@ struct psi_trigger *psi_trigger_create(struct psi=
_group *group,
>         init_waitqueue_head(&t->event_wait);
>         t->pending_event =3D false;
>
> -       mutex_lock(&group->trigger_lock);
> +       mutex_lock(&group->rtpoll_trigger_lock);
>
> -       if (!rcu_access_pointer(group->poll_task)) {
> +       if (!rcu_access_pointer(group->rtpoll_task)) {
>                 struct task_struct *task;
>
> -               task =3D kthread_create(psi_poll_worker, group, "psimon")=
;
> +               task =3D kthread_create(psi_rtpoll_worker, group, "psimon=
");
>                 if (IS_ERR(task)) {
>                         kfree(t);
> -                       mutex_unlock(&group->trigger_lock);
> +                       mutex_unlock(&group->rtpoll_trigger_lock);
>                         return ERR_CAST(task);
>                 }
> -               atomic_set(&group->poll_wakeup, 0);
> +               atomic_set(&group->rtpoll_wakeup, 0);
>                 wake_up_process(task);
> -               rcu_assign_pointer(group->poll_task, task);
> +               rcu_assign_pointer(group->rtpoll_task, task);
>         }
>
> -       list_add(&t->node, &group->triggers);
> -       group->poll_min_period =3D min(group->poll_min_period,
> +       list_add(&t->node, &group->rtpoll_triggers);
> +       group->rtpoll_min_period =3D min(group->rtpoll_min_period,
>                 div_u64(t->win.size, UPDATES_PER_WINDOW));
> -       group->nr_triggers[t->state]++;
> -       group->poll_states |=3D (1 << t->state);
> +       group->rtpoll_nr_triggers[t->state]++;
> +       group->rtpoll_states |=3D (1 << t->state);
>
> -       mutex_unlock(&group->trigger_lock);
> +       mutex_unlock(&group->rtpoll_trigger_lock);
>
>         return t;
>  }
> @@ -1349,51 +1349,52 @@ void psi_trigger_destroy(struct psi_trigger *t)
>          */
>         wake_up_pollfree(&t->event_wait);
>
> -       mutex_lock(&group->trigger_lock);
> +       mutex_lock(&group->rtpoll_trigger_lock);
>
>         if (!list_empty(&t->node)) {
>                 struct psi_trigger *tmp;
>                 u64 period =3D ULLONG_MAX;
>
>                 list_del(&t->node);
> -               group->nr_triggers[t->state]--;
> -               if (!group->nr_triggers[t->state])
> -                       group->poll_states &=3D ~(1 << t->state);
> +               group->rtpoll_nr_triggers[t->state]--;
> +               if (!group->rtpoll_nr_triggers[t->state])
> +                       group->rtpoll_states &=3D ~(1 << t->state);
>                 /* reset min update period for the remaining triggers */
> -               list_for_each_entry(tmp, &group->triggers, node)
> +               list_for_each_entry(tmp, &group->rtpoll_triggers, node)
>                         period =3D min(period, div_u64(tmp->win.size,
>                                         UPDATES_PER_WINDOW));
> -               group->poll_min_period =3D period;
> -               /* Destroy poll_task when the last trigger is destroyed *=
/
> -               if (group->poll_states =3D=3D 0) {
> -                       group->polling_until =3D 0;
> +               group->rtpoll_min_period =3D period;
> +               /* Destroy rtpoll_task when the last trigger is destroyed=
 */
> +               if (group->rtpoll_states =3D=3D 0) {
> +                       group->rtpoll_until =3D 0;
>                         task_to_destroy =3D rcu_dereference_protected(
> -                                       group->poll_task,
> -                                       lockdep_is_held(&group->trigger_l=
ock));
> -                       rcu_assign_pointer(group->poll_task, NULL);
> -                       del_timer(&group->poll_timer);
> +                                       group->rtpoll_task,
> +                                       lockdep_is_held(&group->rtpoll_tr=
igger_lock));
> +                       rcu_assign_pointer(group->rtpoll_task, NULL);
> +                       del_timer(&group->rtpoll_timer);
>                 }
>         }
>
> -       mutex_unlock(&group->trigger_lock);
> +       mutex_unlock(&group->rtpoll_trigger_lock);
>
>         /*
> -        * Wait for psi_schedule_poll_work RCU to complete its read-side
> +        * Wait for psi_schedule_rtpoll_work RCU to complete its read-sid=
e
>          * critical section before destroying the trigger and optionally =
the
> -        * poll_task.
> +        * rtpoll_task.
>          */
>         synchronize_rcu();
>         /*
> -        * Stop kthread 'psimon' after releasing trigger_lock to prevent =
a
> -        * deadlock while waiting for psi_poll_work to acquire trigger_lo=
ck
> +        * Stop kthread 'psimon' after releasing rtpoll_trigger_lock to p=
revent
> +        * a deadlock while waiting for psi_rtpoll_work to acquire
> +        * rtpoll_trigger_lock
>          */
>         if (task_to_destroy) {
>                 /*
>                  * After the RCU grace period has expired, the worker
> -                * can no longer be found through group->poll_task.
> +                * can no longer be found through group->rtpoll_task.
>                  */
>                 kthread_stop(task_to_destroy);
> -               atomic_set(&group->poll_scheduled, 0);
> +               atomic_set(&group->rtpoll_scheduled, 0);
>         }
>         kfree(t);
>  }
> --
> 2.34.1
>
