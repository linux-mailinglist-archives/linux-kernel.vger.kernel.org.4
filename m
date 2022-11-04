Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDBBE619B24
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 16:13:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232458AbiKDPNR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 11:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232437AbiKDPMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 11:12:50 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3B8022B1A
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 08:12:48 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id v17so8046345edc.8
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 08:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0peaMMhH3Kz5bxOaFPApJ3ONhZPN1hYDHsvKTtK+uO4=;
        b=GUEEq4j+r6dtPt9jc7LK144eW3HjpIpWvKWELJ0vSDRnknQOQogTxhjo3XB5/84Rl/
         63BmpvoyMqELO8XIgcGA3P3VdrVe7n4X5ly+BZ7LMwvUVVt1rgo80hVeGe+r/DoicBJy
         soz54RJS/bMGryWOh2t8DwaKQQHg2l8SRGb/k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0peaMMhH3Kz5bxOaFPApJ3ONhZPN1hYDHsvKTtK+uO4=;
        b=J2xtIhxXWg51KYkbNAXeo6rhptkGARwqTyAgYwyOTnWnz5IKxlJKQ5W+2i6LYc+/0R
         y6dHCSLQ3yntCQrBqat4PVbqhkW/XpaVOGq3jHNGKiRBQzcQxAdNAiwXwGWwq6Rf6fT4
         9Y6k/PQ1JRGglF3Opc/Ko7uzb5DlPpnsgNCL46nbIMvoxuApTnR9pEiGYbww2aT7RJA8
         Jsmt0K+6s4JTZfgT+G+8BQ2eexT1o2Sb49uyr0lT6DHaN977nzrM76JewqDSM4pzUyF1
         Mlcw3PeLxjeel1pTaV5ZrjIl5Ezb1VCqIwsghchjD+WQjKIUY+Lb1UO5IVBeIs1TbZMg
         +kag==
X-Gm-Message-State: ACrzQf3FPl/58FxFBQtitwEoW94b2dAi5+g6X7B3+5oSdGS651YX0sFT
        AFTsrnatg/y+sQaam+ht3jCOj6lZQnL9YKpv1EKRdg==
X-Google-Smtp-Source: AMsMyM4uUYqitth4+ST+BNc5KJKkPeXD8Uj7en/xQ/jJ0ju7YOoUK0C7U2PSuuT1sqwUDH9pGHHzNF6Qk6lcMVP70YM=
X-Received: by 2002:a05:6402:174f:b0:463:12ed:3f8f with SMTP id
 v15-20020a056402174f00b0046312ed3f8fmr34297377edx.67.1667574767462; Fri, 04
 Nov 2022 08:12:47 -0700 (PDT)
MIME-Version: 1.0
References: <20221028093403.6673-1-vincent.guittot@linaro.org>
 <20221028093403.6673-7-vincent.guittot@linaro.org> <20221101192848.pjns3um7dnrwrk5p@airbuntu>
 <CAKfTPtA=vJQA_=6Un1CqwzMUaOxMeFGTKUZnj8qyqvqmSdYBAg@mail.gmail.com>
 <20221103142732.m5ibwkuymvhcdxkn@airbuntu> <CAKfTPtDu=c-psGnHkoWSPRWoh1Z0VBBfsN++g+krv4B1SJmFjg@mail.gmail.com>
 <20221104112138.hlnwjmw2ls4gswuo@airbuntu> <CAKfTPtAuJvV117iwnpVpajC6nWPzagtTMk+8NPnGVyukygiFMg@mail.gmail.com>
 <Y2UoR9LqxWInJ90t@google.com> <CAKfTPtD+hhb0L+8o0b82WY1knMwsgBEvjG2tpQBfco5DkC6hoA@mail.gmail.com>
In-Reply-To: <CAKfTPtD+hhb0L+8o0b82WY1knMwsgBEvjG2tpQBfco5DkC6hoA@mail.gmail.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Fri, 4 Nov 2022 15:12:36 +0000
Message-ID: <CAEXW_YSHC0ahXKdj8-U5DZ9=dAuoomfMSs7m687zBZrdNq-uxg@mail.gmail.com>
Subject: Re: [PATCH v7 6/9] sched/fair: Add sched group latency support
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Qais Yousef <qyousef@layalina.io>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, parth@linux.ibm.com,
        qais.yousef@arm.com, chris.hyser@oracle.com,
        patrick.bellasi@matbug.net, David.Laight@aculab.com,
        pjt@google.com, pavel@ucw.cz, tj@kernel.org, qperret@google.com,
        tim.c.chen@linux.intel.com, joshdon@google.com, timj@gnu.org,
        kprateek.nayak@amd.com, yu.c.chen@intel.com,
        youssefesmat@chromium.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLACK autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 4, 2022 at 3:03 PM Vincent Guittot
<vincent.guittot@linaro.org> wrote:
[...]
> > > > > > On 11/03/22 09:46, Vincent Guittot wrote:
> > > > > > > On Tue, 1 Nov 2022 at 20:28, Qais Yousef <qyousef@layalina.io> wrote:
> > > > > > > >
> > > > > > > > On 10/28/22 11:34, Vincent Guittot wrote:
> > > > > > > > > Task can set its latency priority with sched_setattr(), which is then used
> > > > > > > > > to set the latency offset of its sched_enity, but sched group entities
> > > > > > > > > still have the default latency offset value.
> > > > > > > > >
> > > > > > > > > Add a latency.nice field in cpu cgroup controller to set the latency
> > > > > > > > > priority of the group similarly to sched_setattr(). The latency priority
> > > > > > > > > is then used to set the offset of the sched_entities of the group.
> > > > > > > > >
> > > > > > > > > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > > > > > > > > ---
> > > > > > > > >  Documentation/admin-guide/cgroup-v2.rst |  8 ++++
> > > > > > > > >  kernel/sched/core.c                     | 52 +++++++++++++++++++++++++
> > > > > > > > >  kernel/sched/fair.c                     | 33 ++++++++++++++++
> > > > > > > > >  kernel/sched/sched.h                    |  4 ++
> > > > > > > > >  4 files changed, 97 insertions(+)
> > > > > > > > >
> > > > > > > > > diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
> > > > > > > > > index be4a77baf784..d8ae7e411f9c 100644
> > > > > > > > > --- a/Documentation/admin-guide/cgroup-v2.rst
> > > > > > > > > +++ b/Documentation/admin-guide/cgroup-v2.rst
> > > > > > > > > @@ -1095,6 +1095,14 @@ All time durations are in microseconds.
> > > > > > > > >          values similar to the sched_setattr(2). This maximum utilization
> > > > > > > > >          value is used to clamp the task specific maximum utilization clamp.
> > > > > > > > >
> > > > > > > > > +  cpu.latency.nice
[...]
> > > > > > >
> > > > > > > Hmm so you are speaking about something that is not part of the patch.
> > > > > > > Let focus on the patchset for now
> > > > > >
> > > > > > I am focusing on this patchset. Isn't this an essential part of the design?
> > > > > > Once the interface is out we can't change it. As it stands, I can't see how it
> > > > >
> > > > > So, are you speaking about the interface i.e. setting a value between [-20:19]
> > > >
> > > > About how the cgroup and per task interface interact.
> > > >
> > > > How to get the effective value of latency_nice for a task that belongs to
> > > > a hierarchy?
> > >
> > > At the common parents level of the 2 entities that you want to compare
> > > and root level if there no other entity to compare with
> > >
> > > >
> > > > If I have a task that has p->latency_nice = 20 but it belongs to a cgroup that
> > > > has tg->cpu.latency.nice = -19
> > >
> > > according to what i said above, latency_nice = 20 inside the group and
> > > -19 when comparing at the parent level
> > >
> > > >
> > > > And I want to use this interface in EAS; how should I interpret these values?
> > > > How should I walk up the hierarchy and decide the _effective_ latency_nice
> > > > value?
> > >
> > > The current use of latency_nice doesn't need to walk the hierarchy
> > > because it applies at each scheduling level so the childs
> > > automatically follow parents' latency.
> >
> > Not really, I don't see how that will work that way in the wake up path. The
> > wake up path (EAS in particular) does not walk through CPU controller group
> > hierarchy from top level, it only cares about cpuset/affinities and the
> > "effective" values of tasks.
>
> I was explaining the current use of latency_ni i.e. in this patchset,
> I'm not speaking about what should be done for other case like EAS

That's fine, but you did mention the negative value of latency_nice
used to mark that a task prefers idle CPU so we should finish that
discussion :-D.  Since that will be one of the potential users of this
patchset.

> In fact, it's exactly what I explained few lines above :
> "> > At the common parents level of the 2 entities that you want to compare
> > > and root level if there no other entity to compare with"

Yes this is a different usecase, but having more real world use cases
will add more purpose to the patchset.

I also want to add -- for ChromeOS, Youssef tried it and the temporary
boost that latency_nice gives is not enough for latency-sensitive
workloads (like the main thread of a ChromeOS web page which is both
CPU bound and handles latency-sensitive user input). So we are also
exploring other ways. However, I have no issue with the patchset if it
helps Android and would love to review further.

Thanks.
