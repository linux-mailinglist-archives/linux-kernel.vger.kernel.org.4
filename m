Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91AF26D8B1F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 01:36:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233331AbjDEXgV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 19:36:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230237AbjDEXgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 19:36:19 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 719241BEA
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 16:36:17 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id t4so32536672wra.7
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 16:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680737776;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7g+nJD83KGO/5Q3M9wqXtM4GjJe+j3fJfw4W1uFI0Ko=;
        b=A603qC3B8eGcR0RRofg0DOqi9m9uXLjjHi5SZN8MT0JPaxdGKRrCwKuoGDeebTNhpe
         ezkv4XyzqykqFuK//Mg7d2nmdXTb/CL7AoYB85sXU75WQTEV2dLqQTFI/AX5bRU0nohR
         NRwmoIX6aMKGiClyAD7LdtY8T0JcHgYergLpmS+RPWRp8jN/SQJF+Uq532LPRcpxPHpI
         bTZ6F1IoKMzt/sDTJ1pC3yG0lXbLWDng34uYOkqN7Nhc+ClkllqN1G5NNlIIeoN76b5m
         YAdOt/rA9A3rJtBx/zeMLeGmiUMVLwCEjlwzyWg+LsHkg6krxTbdkLxCreYGMCC2HrA6
         Mvug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680737776;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7g+nJD83KGO/5Q3M9wqXtM4GjJe+j3fJfw4W1uFI0Ko=;
        b=hpsm2vfeUrxBLTPNRcENL2WTGDLVP5n0UJmL/eQaIYmsx89SkUihq0yNkxdyCQuPy1
         nO09yimCPnHw4sk4okBpUC9ZYB7YsONvh8m6QLLCGzasc++qca3Gr+c83x4RfijsHq0J
         uTdCSdWY3YwocLyFE7Mhyu7BfusWsJwBGOS5IftH2s4dPl+Q4UOPc3AZAueLW7Cu9dST
         YEeTENx2FwOWe6z9MAYTnb6yHY4hQpuirtJFrJsh9DypZ7qWAwAc03aNeiMfqolB0EfZ
         eSAeaa9btrE/fbHxheNM18vAaClLv7ROb6bEursItXCAPLFhvFXL5RSAimgd+KQpiuE1
         qB4Q==
X-Gm-Message-State: AAQBX9ebLPHf5D00h78/STNB727y42bNXp1Uhsf5C8hCPOEyB3QNH0sR
        zM6kovqTiSbbHV5r3087uztzyiBVVAutSjKxDLc3yQ==
X-Google-Smtp-Source: AKy350a0C0q1q4LpobeEhPSekaGzWzfKFKGMY2W7At4vqtXYsoiZNeyRZDugJjdwgnkexFbe0JsranaDSwf7caiBUMA=
X-Received: by 2002:a05:6000:1f89:b0:2ee:e45d:71cf with SMTP id
 bw9-20020a0560001f8900b002eee45d71cfmr27465wrb.6.1680737775781; Wed, 05 Apr
 2023 16:36:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230330224348.1006691-1-davidai@google.com> <20230330224348.1006691-2-davidai@google.com>
 <e3aa7e66-27d0-034b-7bdf-f4fab1c2df25@arm.com> <CABN1KC+E5tdCBTDu8x_mNzk6L0=Yu8DfpyV-9rMddiRigOFrCQ@mail.gmail.com>
 <0da58608-2958-fc6c-effb-2f73013c609f@arm.com> <CAGETcx_3h9_+y91EfhDMk-gPdRLA3mhdiX2AksN6xHZha7U_mw@mail.gmail.com>
In-Reply-To: <CAGETcx_3h9_+y91EfhDMk-gPdRLA3mhdiX2AksN6xHZha7U_mw@mail.gmail.com>
From:   David Dai <davidai@google.com>
Date:   Wed, 5 Apr 2023 16:36:04 -0700
Message-ID: <CABN1KC+BwYM1uYexL+RDcWzhSo-0n0yZHB_thpRdv4FiQNJr-g@mail.gmail.com>
Subject: Re: [RFC PATCH 1/6] sched/fair: Add util_guest for tasks
To:     Saravana Kannan <saravanak@google.com>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        kernel-team@android.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 5, 2023 at 2:43=E2=80=AFPM Saravana Kannan <saravanak@google.co=
m> wrote:
>
> On Wed, Apr 5, 2023 at 3:50=E2=80=AFAM Dietmar Eggemann
> <dietmar.eggemann@arm.com> wrote:
> >
> > On 04/04/2023 03:11, David Dai wrote:
> > > On Mon, Apr 3, 2023 at 4:40=E2=80=AFAM Dietmar Eggemann
> > > <dietmar.eggemann@arm.com> wrote:
> > >>
> > >> Hi David,
> > > Hi Dietmar, thanks for your comments.
> > >>
> > >> On 31/03/2023 00:43, David Dai wrote:
> >
> > [...]
> >
> > >>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > >>> index 6986ea31c984..998649554344 100644
> > >>> --- a/kernel/sched/fair.c
> > >>> +++ b/kernel/sched/fair.c
> > >>> @@ -4276,14 +4276,16 @@ static int newidle_balance(struct rq *this_=
rq, struct rq_flags *rf);
> > >>>
> > >>>  static inline unsigned long task_util(struct task_struct *p)
> > >>>  {
> > >>> -     return READ_ONCE(p->se.avg.util_avg);
> > >>> +     return max(READ_ONCE(p->se.avg.util_avg),
> > >>> +                     READ_ONCE(p->se.avg.util_guest));
> > >>>  }
> > >>>
> > >>>  static inline unsigned long _task_util_est(struct task_struct *p)
> > >>>  {
> > >>>       struct util_est ue =3D READ_ONCE(p->se.avg.util_est);
> > >>>
> > >>> -     return max(ue.ewma, (ue.enqueued & ~UTIL_AVG_UNCHANGED));
> > >>> +     return max_t(unsigned long, READ_ONCE(p->se.avg.util_guest),
> > >>> +                     max(ue.ewma, (ue.enqueued & ~UTIL_AVG_UNCHANG=
ED)));
> > >>>  }
> > >>
> > >> I can't see why the existing p->uclamp_req[UCLAMP_MIN].value can't b=
e
> > >> used here instead p->se.avg.util_guest.
> > > Using p->uclamp_req[UCLAMP_MIN].value would result in folding in
> > > uclamp values into task_util and task_util_est for all tasks that hav=
e
> > > uclamp values set. The intent of these patches isn=E2=80=99t to modif=
y
> > > existing uclamp behaviour. Users would also override util values from
> > > the guest when they set uclamp values.
> > >>
> > >> I do understand the issue of inheriting uclamp values at fork but do=
n't
> > >> get the not being `additive` thing. We are at task level here.
> >
> > > Uclamp values are max aggregated with other tasks at the runqueue
> > > level when deciding CPU frequency. For example, a vCPU runqueue may
> > > have an util of 512 that results in setting 512 to uclamp_min on the
> > > vCPU task. This is insufficient to drive a frequency response if it
> > > shares the runqueue with another host task running with util of 512 a=
s
> > > it would result in a clamped util value of 512 at the runqueue(Ex. If
> > > a guest thread had just migrated onto this vCPU).
> >
> > OK, see your point now. You want an accurate per-task boost for this
> > vCPU task on the host run-queue.
> > And a scenario in which a vCPU can ask for 100% in these moments is not
> > sufficient I guess? In this case uclamp_min could work.
>
> Right. vCPU can have whatever utilization and there can be random host
> threads completely unrelated to the VM. And we need to aggregate both
> of their util when deciding CPU freq.
>
> >
> > >> The fact that you have to max util_avg and util_est directly in
> > >> task_util() and _task_util_est() tells me that there are places wher=
e
> > >> this helps and uclamp_task_util() is not called there.
> > > Can you clarify on this point a bit more?
> >
> > Sorry, I meant s/util_est/util_guest/.
> >
> > The effect of the change in _task_util_est() you see via:
> >
> > enqueue_task_fair()
> >   util_est_enqueue()
> >     cfs_rq->avg.util_est.enqueued +=3D _task_util_est(p)
> >
> > so that `sugov_get_util() -> cpu_util_cfs() ->
> > cfs_rq->avg.util_est.enqueued` can see the effect of util_guest?

That sequence looks correct to me.

> >
> > Not sure about the change in task_util() yet.

task_util() provides some signaling in addition to task_util_est() via:

find_energy_effcient_cpu()
  cpu_util_next()
    lsub_positive(&util, task_util(p));
    ...
    util +=3D task_util(p);
    //Can provide a better signal than util_est.

dequeue_task_fair()
  util_est_update()
    ue.enqueued =3D task_util(p);
    //Updates ue.ewma

Thanks,
David

> >
> > >> When you say in the cover letter that you tried uclamp_min, how exac=
tly
> > >> did you use it? Did you run the existing mainline or did you use
> > >> uclamp_min as a replacement for util_guest in this patch here?
> >
> > > I called sched_setattr_nocheck() with .sched_flags =3D
> > > SCHED_FLAG_UTIL_CLAMP when updating uclamp_min and clamp_max is left
> > > at 1024. Uclamp_min was not aggregated with task_util and
> > > task_util_est during my testing. The only caveat there is that I adde=
d
> > > a change to only reset uclamp on fork when testing(I realize there is
> > > specifically a SCHED_FLAG_RESET_ON_FORK, but I didn=E2=80=99t want to=
 reset
> > > other sched attributes).
> >
> > OK, understood. It's essentially a util_est v2 for vCPU tasks on host.
>
> Yup. We initially looked into just overwriting util_est, but didn't
> think that'll land well with the community :) as it was a bit messier
> because we needed to make sure the current util_est update paths don't
> run for vCPU tasks on host (because those values would be wrong).
>
> > >>>  static inline unsigned long task_util_est(struct task_struct *p)
> > >>> @@ -6242,6 +6244,15 @@ enqueue_task_fair(struct rq *rq, struct task=
_struct *p, int flags)
> > >>>        */
> > >>>       util_est_enqueue(&rq->cfs, p);
> > >>>
> > >>> +     /*
> > >>> +      * The normal code path for host thread enqueue doesn't take =
into
> > >>> +      * account guest task migrations when updating cpufreq util.
> > >>> +      * So, always update the cpufreq when a vCPU thread has a
> > >>> +      * non-zero util_guest value.
> > >>> +      */
> > >>> +     if (READ_ONCE(p->se.avg.util_guest))
> > >>> +             cpufreq_update_util(rq, 0);
> > >>
> > >>
> > >> This is because enqueue_entity() -> update_load_avg() ->
> > >> attach_entity_load_avg() -> cfs_rq_util_change() requires root run-q=
ueue
> > >> (&rq->cfs =3D=3D cfs_rq) to call cpufreq_update_util()?
> > > The enqueue_entity() would not call into update_load_avg() due to the
> > > check for !se->avg.last_update_time. se->avg.last_update_time is
> > > non-zero because the vCPU task did not migrate before this enqueue.
> > > This enqueue path is reached when util_guest is updated for the vCPU
> > > task through the sched_setattr_nocheck call where we want to ensure a
> > > frequency update occurs.
> >
> > OK, vCPU tasks are pinned so always !WF_MIGRATED wakeup I guess?
>
> Even if say little-vCPU threads are allowed to migrate within little
> CPUs, this will still be an issue. While a vCPU thread is continuously
> running on a single CPU, a guest thread can migrate into that vCPU and
> cause a huge increase in util_guest. But that won't trigger an cpufreq
> update on the host side because the host doesn't see a task migration.
> That's what David is trying to address.
>
> -Saravana
