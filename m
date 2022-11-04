Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAFCD6199C3
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 15:27:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232013AbiKDO1j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 10:27:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232235AbiKDO07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 10:26:59 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41163317C0
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 07:24:36 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id 7so2649298ilg.11
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 07:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=p/KbMw9aZWW0FlYuejzdnW3v3lTQdra4kohw5utGBVI=;
        b=n7tR0VtXnmEr1WWmrivlmZ5dJcOYNiJQXUNVlJxbTTQNA2RfCHZwn5cXToebV2uBkL
         1ev8iEgXxD/wukh9Pkt2fjSGFvm0VTyg1PQM6pii0lkW3M3qjGWJwy0UG0ZsXXUhBgCN
         EAVVKikiWJWE3X8BMEQKOsSQSs9S17V+H4tpkRZzacWvAHLrmgsyuKgTC9oV9DE/YxoL
         +XOaKQS7ZHsr7izb8KKBYyRT7XR41DjYnVVQXqy0k8Qtwsxk5hLXdmeOOS6upcafrD4O
         effNzQP0a/RnTumhw0mWNOSxnfYH+jUk6xIDtaRDHURSI92mZmkfc+TN9ODbJhPj2/Na
         mb5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p/KbMw9aZWW0FlYuejzdnW3v3lTQdra4kohw5utGBVI=;
        b=QqRSZ5UfY5lZk1D2ZVN0QpXJuP5DWvxerVBrgwEGbgw9BeXxFHcgKG4whVLeqnBQIu
         Ibd3F6PbvFQE/vWbfwueiou5kDIrbCIBVYD45tOum6qM4iKTpHq+n+88l31Tx6giU4Yt
         kBloifHw3JuKdFiG99YBdUxf7WK0c7WCSfdgB2h/AkT9uCDKFot/bQmPUbyTNMOFVbdr
         lNxagq2aL/nfClaS2mfOYmA+mnIbTCALnElkFYmF5okjB0ugq1TEbaVd8vOyk+dPUzKz
         409d4Sy73bgA9gCFMBss52aBP4y8LhwBIZds8JRnYwgT5EgkRwBpUM+vhV8m7PBuZrkW
         +Rrg==
X-Gm-Message-State: ACrzQf1mMC6+0mootenV8DoeUts1+n79cOREBbWZiZcchcy9Kt45yDRg
        KwhEHkmhBQPOFnuKcEqkUVl+FGFOz13EJP7xqvDOEQ==
X-Google-Smtp-Source: AMsMyM7Bgmq9pc+YhEil90m8CX7NZXBS8Yuhuv6xyhNY8/cFiR3dXrEKgADsOGR62Lg9eBwTdnoE2uuwQoDqKl9m4Ys=
X-Received: by 2002:a92:4449:0:b0:2de:95f1:8b80 with SMTP id
 a9-20020a924449000000b002de95f18b80mr20501007ilm.232.1667571876123; Fri, 04
 Nov 2022 07:24:36 -0700 (PDT)
MIME-Version: 1.0
References: <20221028093403.6673-1-vincent.guittot@linaro.org>
 <20221028093403.6673-7-vincent.guittot@linaro.org> <20221101192848.pjns3um7dnrwrk5p@airbuntu>
 <CAKfTPtA=vJQA_=6Un1CqwzMUaOxMeFGTKUZnj8qyqvqmSdYBAg@mail.gmail.com>
 <20221103142732.m5ibwkuymvhcdxkn@airbuntu> <CAKfTPtDu=c-psGnHkoWSPRWoh1Z0VBBfsN++g+krv4B1SJmFjg@mail.gmail.com>
 <20221104112138.hlnwjmw2ls4gswuo@airbuntu>
In-Reply-To: <20221104112138.hlnwjmw2ls4gswuo@airbuntu>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 4 Nov 2022 15:24:23 +0100
Message-ID: <CAKfTPtAuJvV117iwnpVpajC6nWPzagtTMk+8NPnGVyukygiFMg@mail.gmail.com>
Subject: Re: [PATCH v7 6/9] sched/fair: Add sched group latency support
To:     Qais Yousef <qyousef@layalina.io>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, parth@linux.ibm.com,
        qais.yousef@arm.com, chris.hyser@oracle.com,
        patrick.bellasi@matbug.net, David.Laight@aculab.com,
        pjt@google.com, pavel@ucw.cz, tj@kernel.org, qperret@google.com,
        tim.c.chen@linux.intel.com, joshdon@google.com, timj@gnu.org,
        kprateek.nayak@amd.com, yu.c.chen@intel.com,
        youssefesmat@chromium.org, joel@joelfernandes.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Nov 2022 at 12:21, Qais Yousef <qyousef@layalina.io> wrote:
>
> On 11/03/22 18:02, Vincent Guittot wrote:
> > On Thu, 3 Nov 2022 at 15:27, Qais Yousef <qyousef@layalina.io> wrote:
> > >
> > > On 11/03/22 09:46, Vincent Guittot wrote:
> > > > On Tue, 1 Nov 2022 at 20:28, Qais Yousef <qyousef@layalina.io> wrote:
> > > > >
> > > > > On 10/28/22 11:34, Vincent Guittot wrote:
> > > > > > Task can set its latency priority with sched_setattr(), which is then used
> > > > > > to set the latency offset of its sched_enity, but sched group entities
> > > > > > still have the default latency offset value.
> > > > > >
> > > > > > Add a latency.nice field in cpu cgroup controller to set the latency
> > > > > > priority of the group similarly to sched_setattr(). The latency priority
> > > > > > is then used to set the offset of the sched_entities of the group.
> > > > > >
> > > > > > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > > > > > ---
> > > > > >  Documentation/admin-guide/cgroup-v2.rst |  8 ++++
> > > > > >  kernel/sched/core.c                     | 52 +++++++++++++++++++++++++
> > > > > >  kernel/sched/fair.c                     | 33 ++++++++++++++++
> > > > > >  kernel/sched/sched.h                    |  4 ++
> > > > > >  4 files changed, 97 insertions(+)
> > > > > >
> > > > > > diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
> > > > > > index be4a77baf784..d8ae7e411f9c 100644
> > > > > > --- a/Documentation/admin-guide/cgroup-v2.rst
> > > > > > +++ b/Documentation/admin-guide/cgroup-v2.rst
> > > > > > @@ -1095,6 +1095,14 @@ All time durations are in microseconds.
> > > > > >          values similar to the sched_setattr(2). This maximum utilization
> > > > > >          value is used to clamp the task specific maximum utilization clamp.
> > > > > >
> > > > > > +  cpu.latency.nice
> > > > > > +     A read-write single value file which exists on non-root
> > > > > > +     cgroups.  The default is "0".
> > > > > > +
> > > > > > +     The nice value is in the range [-20, 19].
> > > > > > +
> > > > > > +     This interface file allows reading and setting latency using the
> > > > > > +     same values used by sched_setattr(2).
> > > > >
> > > > > I'm still not sure about this [1].
> > > >
> > > > I'm still not sure about what you are trying to say here ...
> > > >
> > > > This is about setting a latency nice prio to a group level.
> > > >
> > > > >
> > > > > In some scenarios we'd like to get the effective latency_nice of the task. How
> > > > > will the task inherit the cgroup value or be impacted by it?
> > > > >
> > > > > For example if there are tasks that belong to a latency sensitive cgroup; and
> > > > > I'd like to skip some searches in EAS to improve that latency sensitivity - how
> > > > > would I extract this info in EAS path given these tasks are using default
> > > > > latency_nice value? And if should happen if their latency_nice is set to
> > > > > something else other than default?
> > > > >
> > > > > [1] https://lore.kernel.org/lkml/20221012160734.hrkb5jcjdq7r23pr@wubuntu/
> > > >
> > > > Hmm so you are speaking about something that is not part of the patch.
> > > > Let focus on the patchset for now
> > >
> > > I am focusing on this patchset. Isn't this an essential part of the design?
> > > Once the interface is out we can't change it. As it stands, I can't see how it
> >
> > So, are you speaking about the interface i.e. setting a value between [-20:19]
>
> About how the cgroup and per task interface interact.
>
> How to get the effective value of latency_nice for a task that belongs to
> a hierarchy?

At the common parents level of the 2 entities that you want to compare
and root level if there no other entity to compare with

>
> If I have a task that has p->latency_nice = 20 but it belongs to a cgroup that
> has tg->cpu.latency.nice = -19

according to what i said above, latency_nice = 20 inside the group and
-19 when comparing at the parent level

>
> And I want to use this interface in EAS; how should I interpret these values?
> How should I walk up the hierarchy and decide the _effective_ latency_nice
> value?

The current use of latency_nice doesn't need to walk the hierarchy
because it applies at each scheduling level so the childs
automatically follow parents' latency.

>
> >
> > > can be used to replace prefer_idle in cgroup as used in Android. I can't see
> > > how this could happen if we don't define how the task will inherit the cgroup
> > > value. If we can, mind elaborating how please?
> >
> > Or how to take into account the value set for a cgroup ?
>
> Yes that. How to calculate effective value in a hierarchy taking parents,
> children and task latency_nice values into account.
>
> >
> > Regarding the behavior, the rule remains the same that a sched_entity
> > attached to a cgroup will not get more (latency in this case) than
> > what has been set for the group entity.
>
> So it behaves like a limit as described in cgroup-v2.rst? Is this enforced in
> the series?

It's like a limit and this is enforced in this serie as we are
applying the latency at each level before moving to the next one

>
>
> Thanks
>
> --
> Qais Yousef
>
> >
> > >
> > >
> > > Thanks
> > >
> > > --
> > > Qais Yousef
