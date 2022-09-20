Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEF335BE9EE
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 17:18:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231384AbiITPSI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 11:18:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbiITPSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 11:18:03 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4F715F11B
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 08:18:02 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id w8so4287826lft.12
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 08:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=5se1nLah5wB7N2z+/BXJGVEJry5l8HVmuf5730Cxm1c=;
        b=t/GsXU0TSldX02gXKmfWhpOaf9w10U4rMd7iYYtyHToeJwoAZbn1VARtKPcjIrzJax
         vGhTZMfwXH44f/9DBonR/qhyrV320zwtnmLK2WTYEWn+q1tCsYt1asWA6V3ZWRWICvT9
         n/55/9QYwqCkn3T/l0/VJQoPch7nuxBwgX4gZZEWn57lme27FqZqX8ZiwEnTB8wVP7kV
         P1kzzHbAzmAAOFqb7wei+kL0Lx8fu+zQsUYlzMuEsZE1L6SJPfl7nVuZZe0OxGSB8fnR
         yfPlsNep6MPbUZ4WnPa2IaZwXwbuzYybnF4/Dw20vnXTjoJwrM7Q+fBfUdASo6Xx3kz2
         9LYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=5se1nLah5wB7N2z+/BXJGVEJry5l8HVmuf5730Cxm1c=;
        b=ba9QuD7yIf/y/DYs7MOztcrZVdV5+b2OMmehMYZ6G12cgo7/STX3KudnnwLujiynt5
         Q+TzFyg5COF/1udHtVryI6gDNR9b9H/freLzxMrG4StIO8FMD1Ud+7lUxO3Hb36ePkYf
         ZYXvthAwro+xXypudhCG//ArjQuBkoR5zDMe95TaMTbYUdpe5A7yGiWv/sR/KjLr90O/
         qZpGMD8OtAlbYPaaeFTgQJ/cBx2d4OD/P1h25EyJe7ArWOVfkWxx0ppnYRk+BR6Up+zm
         PkvXJFY7udmIh05f1kj9ZXaW8IZI5OXrdkezOcXa8vyBkzEsahA+pgQNFchv1gkR+Rbk
         v2hw==
X-Gm-Message-State: ACrzQf0dqQ/upDL8uI49DD4j/ttAJjDcy1iFAgHwWjnU54UYKHruf0tU
        i4+CRLWrNFgwJdJ3o5L6HN+PggF+kE5riiw5SERoBw==
X-Google-Smtp-Source: AMsMyM7g2GB6gWS/U1QhMJ4bhZeEHRjSTibIwVDLMHasj5Gw1dMEzmBKIGssqwSpPOnFUDfFvoU6IVNBam3WpyHqSMY=
X-Received: by 2002:a05:6512:2286:b0:49e:eb:ea19 with SMTP id
 f6-20020a056512228600b0049e00ebea19mr8571266lfu.645.1663687080917; Tue, 20
 Sep 2022 08:18:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220916080305.29574-6-vincent.guittot@linaro.org>
 <20220916120245.2951-1-hdanton@sina.com> <CAKfTPtDV+ACXtQGH38sXwFVJfq+EzyKO1mCMZ68Q+GC5kw7-ww@mail.gmail.com>
 <20220917225819.817-1-hdanton@sina.com> <CAKfTPtCFCYi3uM2B7wf4A3d4bfVHb=-_PA+6tWMQQCA9K9Hi5A@mail.gmail.com>
 <20220920113238.1176-1-hdanton@sina.com>
In-Reply-To: <20220920113238.1176-1-hdanton@sina.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 20 Sep 2022 17:17:49 +0200
Message-ID: <CAKfTPtBU4N-Y0zptdaVAUA8FgG2jHrBfyB1vEpNQnjJ1g_G8pQ@mail.gmail.com>
Subject: Re: [PATCH v4 5/8] sched/fair: Take into account latency priority at wakeup
To:     Hillf Danton <hdanton@sina.com>
Cc:     peterz@infradead.org, mgorman@suse.de, valentin.schneider@arm.com,
        parth@linux.ibm.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Sept 2022 at 13:32, Hillf Danton <hdanton@sina.com> wrote:
>
> On 18 Sep 2022 12:46:00 +0200 Vincent Guittot <vincent.guittot@linaro.org> wrote:
> > On Sun, 18 Sept 2022 at 00:58, Hillf Danton <hdanton@sina.com> wrote:
> > >
> > > On 16 Sep 2022 15:36:53 +0200 Vincent Guittot <vincent.guittot@linaro.org> wrote:
> > > >
> > > > Hi Hillf,
> > > >
> > > > On Fri, 16 Sept 2022 at 14:03, Hillf Danton <hdanton@sina.com> wrote:
> > > > >
> > > > > Hello Vincent
> > > > >
> > > > > On 16 Sep 2022 10:03:02 +0200 Vincent Guittot <vincent.guittot@linaro.org> wrote:
> > > > > >
> > > > > > @@ -4606,6 +4608,7 @@ check_preempt_tick(struct cfs_rq *cfs_rq, struct sched_entity *curr)
> > > > > >
> > > > > >       se = __pick_first_entity(cfs_rq);
> > > > > >       delta = curr->vruntime - se->vruntime;
> > > > > > +     delta -= wakeup_latency_gran(curr, se);
> > > > > >
> > > > > >       if (delta < 0)
> > > > > >               return;
> > > > >
> > > > > What is derived from the latency nice you added is the runtime granulaity
> > > > > which has a role in preempting the current task.
> > > > >
> > > > > Given the same defination of latency nice as the nice, the runtime granularity
> > > > > can be computed without introducing the latency nice.
> > > > >
> > > > > Only for thoughts now.
> > > > >
> > > > > Hillf
> > > > >
> > > > > +++ b/kernel/sched/fair.c
> > > > > @@ -4569,7 +4569,7 @@ dequeue_entity(struct cfs_rq *cfs_rq, st
> > > > >  static void
> > > > >  check_preempt_tick(struct cfs_rq *cfs_rq, struct sched_entity *curr)
> > > > >  {
> > > > > -       unsigned long ideal_runtime, delta_exec;
> > > > > +       unsigned long ideal_runtime, delta_exec, granu;
> > > > >         struct sched_entity *se;
> > > > >         s64 delta;
> > > > >
> > > > > @@ -4594,6 +4594,14 @@ check_preempt_tick(struct cfs_rq *cfs_rq
> > > > >                 return;
> > > > >
> > > > >         se = __pick_first_entity(cfs_rq);
> > > > > +
> > > > > +       granu = sysctl_sched_min_granularity +
> > > > > +               (ideal_runtime - sysctl_sched_min_granularity) *
> > > > > +               (se->latency_nice + 20) / LATENCY_NICE_WIDTH;
> > > >
> > > > There is no latency_nice field in se but a latency_offset instead
> > > >
> > > > Also at this step, we are sure that curr has run at least
> > > > sysctl_sched_min_granularity and we want now to compare curr vruntime
> > > > with first se's one. We take the latency offset into account to make
> > > > sure we will not preempt curr too early
> > > >
> > > > > +
> > > > > +       if (delta_exec < granu)
> > > > > +               return;
> > > > > +
> > > > >         delta = curr->vruntime - se->vruntime;
> > > > >
> > > > >         if (delta < 0)
> > >                 return;
> > >
> > >             if (delta > ideal_runtime)
> > >                 resched_curr(rq_of(cfs_rq));
> > >
> > > After another look, curr is not preempted without the gap in vruntime
> > > between curr and the first entity growing more than ideal runtime, while
> >
> > Curr can be preempted as it has run more than the ideal time (1st
> > test). This one is to make sure that the diff does not become too
> > large. Here we reuse the same comparison as wakeup to make sure that a
> > newly curr will get a chance to run its ideal time after  having
> > preempted at wakeup the previous current
>
> IIUC it would take two checks to preempt correctly - diff in vruntime
> is checked first to avoid preempting too early, then it is checked again
> with latency_offset taken into account to avoid preempting too late.

The 1st test in check_preempt_tick() : if (delta_exec > ideal_runtime)
ensures that a resched happens after the current run is slice

The 2nd test : if (delta_exec < sysctl_sched_min_granularity)
ensures that current will run at least 3ms

The 3rd one :  if (delta > ideal_runtime)
is there to make sure that there is not too much diff between the
vruntime. But we are comparing virtual runtime with execution time and
as Peter mentioned in another thread that's weird. [1] will fix it in
addition to ensure max runtime.
Then, current might have preempted first_entity few ms before thanks
to its latency_offset. If the tick happens quickly after the
preemption, delta might be above ideal_runtime whereas current has run
its ideal time yet

[1] https://lore.kernel.org/all/20220916131538.24706-1-vincent.guittot@linaro.org/

>
> +++ b/kernel/sched/fair.c
> @@ -4571,7 +4571,7 @@ check_preempt_tick(struct cfs_rq *cfs_rq
>  {
>         unsigned long ideal_runtime, delta_exec;
>         struct sched_entity *se;
> -       s64 delta;
> +       s64 delta, d2;
>
>         ideal_runtime = sched_slice(cfs_rq, curr);
>         delta_exec = curr->sum_exec_runtime - curr->prev_sum_exec_runtime;
> @@ -4595,11 +4595,9 @@ check_preempt_tick(struct cfs_rq *cfs_rq
>
>         se = __pick_first_entity(cfs_rq);
>         delta = curr->vruntime - se->vruntime;
> +       d2 = delta - wakeup_latency_gran(curr, se);
>
> -       if (delta < 0)
> -               return;
> -
> -       if (delta > ideal_runtime)
> +       if (delta > ideal_runtime || d2 > ideal_runtime)
>                 resched_curr(rq_of(cfs_rq));
>  }
>
