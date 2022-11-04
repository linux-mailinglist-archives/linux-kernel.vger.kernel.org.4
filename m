Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E85D1619B6C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 16:23:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232558AbiKDPXl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 11:23:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232527AbiKDPXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 11:23:34 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D3D6F11
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 08:23:33 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id z9so2743227ilu.10
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 08:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cQFrXe6XJGt4M/+KB7rNRylyk09Q6qqzki750qYzSz4=;
        b=dsdK4/ega+5qBTxetoo4z/YpnroJQloHFaVqUZoq1JLfbyuAuAuB4nzzZtgdC+hMNo
         /DWBoaHNn9gk5gmbGAMFMQ0F9qmji1X/+GMm/b5tQq3A9aVUPJgW/28+Xuo+3JycAG/C
         GK+9ZGuaAfpp1z4JYKdMDBA1ILHtmFXz+C8wOom7gxZIO1SHOkEfjm2b+j03NPj8lgd2
         ojON4Euxk7XiyTmFlLYy/i5ABtoqwpSZhjJyf9oy+maGv5e6r1O8JizHktppsE2F3YoN
         NZQa+sCLG83jNa1NYdOGeZ6gGbUohNticohBPl53Vinuitr6M1TPcUdDbCGk01vpPJw4
         a6aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cQFrXe6XJGt4M/+KB7rNRylyk09Q6qqzki750qYzSz4=;
        b=MDUG5/DPkMK5+AvN5mjulaqk6LIICnNdaRh68MXWxsRX3GdCffbN44dHh6LjIDwFjU
         /nRmDgeIVJVp24AbHPgrGmKPiUKKAci9R4yqdoblQuHmbuTeTqbMZug7hcGYGXs9HMxo
         ei2FE1Zn3zcWqzAStXpoyfzPzRroiL3ifavm+Una6c7QgQyzrcOR5Gq8CVFNcNeV+9fC
         UbjmZGIpZr6v1ZfOEoEQrDsOWQyf9Kg1G5Fwf6QqwRd1gT9cIEHKIA4h6foami3z2ckH
         EIA5Yne4tqNktf6kalqCLv9Nhjn9jRwwTRSl3hjoPRe8cgKHzUNMuSEjl1hTxV2VYqpx
         cJ/A==
X-Gm-Message-State: ACrzQf0Ns0GppnisxAyzkRgDjjwfwQkLzvd0N8vEIOMklEaXQn6C69ki
        V1i77x3tNndlQd4+sXcxpi9d4hDVYcEq/jIWu19obQ==
X-Google-Smtp-Source: AMsMyM6XgI3nrKcbdLvw1eylWC28leU/lyIkFGFvL/DOmjIhyEJYB/pcmiaqxJh8LIsEkr2h+DlYIpHDQZFamwl9Gq0=
X-Received: by 2002:a92:4449:0:b0:2de:95f1:8b80 with SMTP id
 a9-20020a924449000000b002de95f18b80mr20638638ilm.232.1667575412742; Fri, 04
 Nov 2022 08:23:32 -0700 (PDT)
MIME-Version: 1.0
References: <20221028093403.6673-1-vincent.guittot@linaro.org>
 <20221028093403.6673-7-vincent.guittot@linaro.org> <20221101192848.pjns3um7dnrwrk5p@airbuntu>
 <CAKfTPtA=vJQA_=6Un1CqwzMUaOxMeFGTKUZnj8qyqvqmSdYBAg@mail.gmail.com>
 <20221103142732.m5ibwkuymvhcdxkn@airbuntu> <CAKfTPtDu=c-psGnHkoWSPRWoh1Z0VBBfsN++g+krv4B1SJmFjg@mail.gmail.com>
 <20221104112138.hlnwjmw2ls4gswuo@airbuntu> <CAKfTPtAuJvV117iwnpVpajC6nWPzagtTMk+8NPnGVyukygiFMg@mail.gmail.com>
 <Y2UoR9LqxWInJ90t@google.com> <CAKfTPtD+hhb0L+8o0b82WY1knMwsgBEvjG2tpQBfco5DkC6hoA@mail.gmail.com>
 <CAEXW_YSHC0ahXKdj8-U5DZ9=dAuoomfMSs7m687zBZrdNq-uxg@mail.gmail.com>
In-Reply-To: <CAEXW_YSHC0ahXKdj8-U5DZ9=dAuoomfMSs7m687zBZrdNq-uxg@mail.gmail.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 4 Nov 2022 16:23:20 +0100
Message-ID: <CAKfTPtBGoE=_zXhGecjLH7biZsbMKEgRQq4qDE+K0ps6YhCjcg@mail.gmail.com>
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

On Fri, 4 Nov 2022 at 16:12, Joel Fernandes <joel@joelfernandes.org> wrote:
>
> On Fri, Nov 4, 2022 at 3:03 PM Vincent Guittot
> <vincent.guittot@linaro.org> wrote:
> [...]
> > > > > > > On 11/03/22 09:46, Vincent Guittot wrote:
> > > > > > > > On Tue, 1 Nov 2022 at 20:28, Qais Yousef <qyousef@layalina.io> wrote:
> > > > > > > > >
> > > > > > > > > On 10/28/22 11:34, Vincent Guittot wrote:
> > > > > > > > > > Task can set its latency priority with sched_setattr(), which is then used
> > > > > > > > > > to set the latency offset of its sched_enity, but sched group entities
> > > > > > > > > > still have the default latency offset value.
> > > > > > > > > >
> > > > > > > > > > Add a latency.nice field in cpu cgroup controller to set the latency
> > > > > > > > > > priority of the group similarly to sched_setattr(). The latency priority
> > > > > > > > > > is then used to set the offset of the sched_entities of the group.
> > > > > > > > > >
> > > > > > > > > > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > > > > > > > > > ---
> > > > > > > > > >  Documentation/admin-guide/cgroup-v2.rst |  8 ++++
> > > > > > > > > >  kernel/sched/core.c                     | 52 +++++++++++++++++++++++++
> > > > > > > > > >  kernel/sched/fair.c                     | 33 ++++++++++++++++
> > > > > > > > > >  kernel/sched/sched.h                    |  4 ++
> > > > > > > > > >  4 files changed, 97 insertions(+)
> > > > > > > > > >
> > > > > > > > > > diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
> > > > > > > > > > index be4a77baf784..d8ae7e411f9c 100644
> > > > > > > > > > --- a/Documentation/admin-guide/cgroup-v2.rst
> > > > > > > > > > +++ b/Documentation/admin-guide/cgroup-v2.rst
> > > > > > > > > > @@ -1095,6 +1095,14 @@ All time durations are in microseconds.
> > > > > > > > > >          values similar to the sched_setattr(2). This maximum utilization
> > > > > > > > > >          value is used to clamp the task specific maximum utilization clamp.
> > > > > > > > > >
> > > > > > > > > > +  cpu.latency.nice
> [...]
> > > > > > > >
> > > > > > > > Hmm so you are speaking about something that is not part of the patch.
> > > > > > > > Let focus on the patchset for now
> > > > > > >
> > > > > > > I am focusing on this patchset. Isn't this an essential part of the design?
> > > > > > > Once the interface is out we can't change it. As it stands, I can't see how it
> > > > > >
> > > > > > So, are you speaking about the interface i.e. setting a value between [-20:19]
> > > > >
> > > > > About how the cgroup and per task interface interact.
> > > > >
> > > > > How to get the effective value of latency_nice for a task that belongs to
> > > > > a hierarchy?
> > > >
> > > > At the common parents level of the 2 entities that you want to compare
> > > > and root level if there no other entity to compare with
> > > >
> > > > >
> > > > > If I have a task that has p->latency_nice = 20 but it belongs to a cgroup that
> > > > > has tg->cpu.latency.nice = -19
> > > >
> > > > according to what i said above, latency_nice = 20 inside the group and
> > > > -19 when comparing at the parent level
> > > >
> > > > >
> > > > > And I want to use this interface in EAS; how should I interpret these values?
> > > > > How should I walk up the hierarchy and decide the _effective_ latency_nice
> > > > > value?
> > > >
> > > > The current use of latency_nice doesn't need to walk the hierarchy
> > > > because it applies at each scheduling level so the childs
> > > > automatically follow parents' latency.
> > >
> > > Not really, I don't see how that will work that way in the wake up path. The
> > > wake up path (EAS in particular) does not walk through CPU controller group
> > > hierarchy from top level, it only cares about cpuset/affinities and the
> > > "effective" values of tasks.
> >
> > I was explaining the current use of latency_ni i.e. in this patchset,
> > I'm not speaking about what should be done for other case like EAS
>
> That's fine, but you did mention the negative value of latency_nice
> used to mark that a task prefers idle CPU so we should finish that
> discussion :-D.  Since that will be one of the potential users of this
> patchset.

We should finish reviewing this patchset 1st. Then, we can discuss if
we should use -19, <0 or something else. This doesn't add any value to
this patchset IMO

>
> > In fact, it's exactly what I explained few lines above :
> > "> > At the common parents level of the 2 entities that you want to compare
> > > > and root level if there no other entity to compare with"
>
> Yes this is a different usecase, but having more real world use cases
> will add more purpose to the patchset.

As long as the policy is defined and I think it is defined, we are
fine and it's not the purpose of discussing implementation details of
potential other use. Once this patchset is merged, I will be more than
happy to prepare another one to make use of latency_nice in EAS and we
can discuss further based on it.


>
> I also want to add -- for ChromeOS, Youssef tried it and the temporary
> boost that latency_nice gives is not enough for latency-sensitive
> workloads (like the main thread of a ChromeOS web page which is both
> CPU bound and handles latency-sensitive user input). So we are also
> exploring other ways. However, I have no issue with the patchset if it
> helps Android and would love to review further.
>
> Thanks.
