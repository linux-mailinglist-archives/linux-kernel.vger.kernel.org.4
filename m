Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 095F8619AE2
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 16:03:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231954AbiKDPDe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 11:03:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232142AbiKDPDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 11:03:24 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09FF9B85
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 08:03:23 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id z3so3990658iof.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 08:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Bhy1p7cjJLmCBbkM2KUZiCbNe1efIaNUdtv5OuqAyt8=;
        b=vOOkkLcf0CE8wjxlUK2jBe6isfuYZsk0QvWFw79ElBAul6JH/Juud/tbq0evSDBCuu
         C8/15EMlrO2yHjhb2zNw3WabolJZAuzfOeSVU4+SmnFbSCoQCQGSgXmykniUaiF/nr7R
         QAdKAmsIGyxyL7zAaF01vncCPmeJm4C/6BVDCFKNHVeSPPEkbh8fHDkevpM1yt9gukSN
         dqkPmcC+Vizr5qFNrfaSd9lfYOIVXDv9CDfl9T4HbosysXMQTcXp08o5pCsdVhQQeGrN
         Gp0Q99vhCLpeN9znlmiI0YY47IP7rnplAvcpnEQJayjD7HCQzMmdrlQHHt4yolB6BbOc
         CLGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bhy1p7cjJLmCBbkM2KUZiCbNe1efIaNUdtv5OuqAyt8=;
        b=8OpvUOiHn927+oelsudJvcvVkhZXXveLZayhv0o/RQ2JUdQwSb/rmk6x3eLtlnOmwN
         GsSkggiG0wR5fMsbXWn/mb+QkiZ4dP0/IaUi4LPWZnEKAiC1ywA2QAUfuY7Sy1CZU1oO
         weRjnLF/eDi+NMDEqUkWYNbrzNXOpy5hstfYciD5YQbq9KClLXb14LV2jnF6N98Qpv4i
         Y6fgPVlXbjy/FZqAgU5jbK8mwjpGwILgKTl8ijoB2QsWECjGDiwM0KyjTD8OpKRtSyxL
         DAI2NmOQyFEUUO73UfelX5FFnO1HAGtnnS4FSs8QhwZv9zsXTGZzcz1FG7r5t5LEqVHG
         lgWg==
X-Gm-Message-State: ACrzQf0Lzv4A+H8d6SNK7fdsS+k+fQM6kKzLiEa3EszrwMkCgSvF+HZ6
        zldApNkWtPgvSD2DP0Qh0uAZaTkK1HHqdyBP5WQtgQ==
X-Google-Smtp-Source: AMsMyM62BItu1dOC+26Ik2K6FWP4OzDeo+wGrFltsSvpReyXJ+5HMFvjAA3V5sgdOMMSTzEnfO+/SpE2Q18yQKjdGI4=
X-Received: by 2002:a02:9a07:0:b0:375:4db5:2a4e with SMTP id
 b7-20020a029a07000000b003754db52a4emr19040603jal.71.1667574202312; Fri, 04
 Nov 2022 08:03:22 -0700 (PDT)
MIME-Version: 1.0
References: <20221028093403.6673-1-vincent.guittot@linaro.org>
 <20221028093403.6673-7-vincent.guittot@linaro.org> <20221101192848.pjns3um7dnrwrk5p@airbuntu>
 <CAKfTPtA=vJQA_=6Un1CqwzMUaOxMeFGTKUZnj8qyqvqmSdYBAg@mail.gmail.com>
 <20221103142732.m5ibwkuymvhcdxkn@airbuntu> <CAKfTPtDu=c-psGnHkoWSPRWoh1Z0VBBfsN++g+krv4B1SJmFjg@mail.gmail.com>
 <20221104112138.hlnwjmw2ls4gswuo@airbuntu> <CAKfTPtAuJvV117iwnpVpajC6nWPzagtTMk+8NPnGVyukygiFMg@mail.gmail.com>
 <Y2UoR9LqxWInJ90t@google.com>
In-Reply-To: <Y2UoR9LqxWInJ90t@google.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 4 Nov 2022 16:03:10 +0100
Message-ID: <CAKfTPtD+hhb0L+8o0b82WY1knMwsgBEvjG2tpQBfco5DkC6hoA@mail.gmail.com>
Subject: Re: [PATCH v7 6/9] sched/fair: Add sched group latency support
To:     Joel Fernandes <joel@joelfernandes.org>
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Nov 2022 at 15:57, Joel Fernandes <joel@joelfernandes.org> wrote:
>
> On Fri, Nov 04, 2022 at 03:24:23PM +0100, Vincent Guittot wrote:
> > On Fri, 4 Nov 2022 at 12:21, Qais Yousef <qyousef@layalina.io> wrote:
> > >
> > > On 11/03/22 18:02, Vincent Guittot wrote:
> > > > On Thu, 3 Nov 2022 at 15:27, Qais Yousef <qyousef@layalina.io> wrote:
> > > > >
> > > > > On 11/03/22 09:46, Vincent Guittot wrote:
> > > > > > On Tue, 1 Nov 2022 at 20:28, Qais Yousef <qyousef@layalina.io> wrote:
> > > > > > >
> > > > > > > On 10/28/22 11:34, Vincent Guittot wrote:
> > > > > > > > Task can set its latency priority with sched_setattr(), which is then used
> > > > > > > > to set the latency offset of its sched_enity, but sched group entities
> > > > > > > > still have the default latency offset value.
> > > > > > > >
> > > > > > > > Add a latency.nice field in cpu cgroup controller to set the latency
> > > > > > > > priority of the group similarly to sched_setattr(). The latency priority
> > > > > > > > is then used to set the offset of the sched_entities of the group.
> > > > > > > >
> > > > > > > > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > > > > > > > ---
> > > > > > > >  Documentation/admin-guide/cgroup-v2.rst |  8 ++++
> > > > > > > >  kernel/sched/core.c                     | 52 +++++++++++++++++++++++++
> > > > > > > >  kernel/sched/fair.c                     | 33 ++++++++++++++++
> > > > > > > >  kernel/sched/sched.h                    |  4 ++
> > > > > > > >  4 files changed, 97 insertions(+)
> > > > > > > >
> > > > > > > > diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
> > > > > > > > index be4a77baf784..d8ae7e411f9c 100644
> > > > > > > > --- a/Documentation/admin-guide/cgroup-v2.rst
> > > > > > > > +++ b/Documentation/admin-guide/cgroup-v2.rst
> > > > > > > > @@ -1095,6 +1095,14 @@ All time durations are in microseconds.
> > > > > > > >          values similar to the sched_setattr(2). This maximum utilization
> > > > > > > >          value is used to clamp the task specific maximum utilization clamp.
> > > > > > > >
> > > > > > > > +  cpu.latency.nice
> > > > > > > > +     A read-write single value file which exists on non-root
> > > > > > > > +     cgroups.  The default is "0".
> > > > > > > > +
> > > > > > > > +     The nice value is in the range [-20, 19].
> > > > > > > > +
> > > > > > > > +     This interface file allows reading and setting latency using the
> > > > > > > > +     same values used by sched_setattr(2).
> > > > > > >
> > > > > > > I'm still not sure about this [1].
> > > > > >
> > > > > > I'm still not sure about what you are trying to say here ...
> > > > > >
> > > > > > This is about setting a latency nice prio to a group level.
> > > > > >
> > > > > > >
> > > > > > > In some scenarios we'd like to get the effective latency_nice of the task. How
> > > > > > > will the task inherit the cgroup value or be impacted by it?
> > > > > > >
> > > > > > > For example if there are tasks that belong to a latency sensitive cgroup; and
> > > > > > > I'd like to skip some searches in EAS to improve that latency sensitivity - how
> > > > > > > would I extract this info in EAS path given these tasks are using default
> > > > > > > latency_nice value? And if should happen if their latency_nice is set to
> > > > > > > something else other than default?
> > > > > > >
> > > > > > > [1] https://lore.kernel.org/lkml/20221012160734.hrkb5jcjdq7r23pr@wubuntu/
> > > > > >
> > > > > > Hmm so you are speaking about something that is not part of the patch.
> > > > > > Let focus on the patchset for now
> > > > >
> > > > > I am focusing on this patchset. Isn't this an essential part of the design?
> > > > > Once the interface is out we can't change it. As it stands, I can't see how it
> > > >
> > > > So, are you speaking about the interface i.e. setting a value between [-20:19]
> > >
> > > About how the cgroup and per task interface interact.
> > >
> > > How to get the effective value of latency_nice for a task that belongs to
> > > a hierarchy?
> >
> > At the common parents level of the 2 entities that you want to compare
> > and root level if there no other entity to compare with
> >
> > >
> > > If I have a task that has p->latency_nice = 20 but it belongs to a cgroup that
> > > has tg->cpu.latency.nice = -19
> >
> > according to what i said above, latency_nice = 20 inside the group and
> > -19 when comparing at the parent level
> >
> > >
> > > And I want to use this interface in EAS; how should I interpret these values?
> > > How should I walk up the hierarchy and decide the _effective_ latency_nice
> > > value?
> >
> > The current use of latency_nice doesn't need to walk the hierarchy
> > because it applies at each scheduling level so the childs
> > automatically follow parents' latency.
>
> Not really, I don't see how that will work that way in the wake up path. The
> wake up path (EAS in particular) does not walk through CPU controller group
> hierarchy from top level, it only cares about cpuset/affinities and the
> "effective" values of tasks.

I was explaining the current use of latency_ni i.e. in this patchset,
I'm not speaking about what should be done for other case like EAS

In fact, it's exactly what I explained few lines above :
"> > At the common parents level of the 2 entities that you want to compare
> > and root level if there no other entity to compare with"

>
> So when you wake up a task, how will you retrieve the attribute for 'prefer
> idle' in the wakeup path using this patchset? The only way is to aggregate
> the CGroup hierarchy information to get a per-task effective value; say using
> a min function.
>
> If you see uclamp_rq_util_with(), that also is using doing uclamp
> aggregation similarly.
>
> So I think Qais is asking about the aggregation function in the EAS wakeup
> path.
>
> Thanks.
