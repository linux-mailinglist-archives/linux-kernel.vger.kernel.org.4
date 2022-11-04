Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6704619481
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 11:37:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231724AbiKDKhU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 06:37:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230074AbiKDKhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 06:37:16 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0815264B9
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 03:37:15 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id x16so2388609ilm.5
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 03:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OG1ttL9ewGmsGATx0jj/rue5KngBOTueLt43dOoL/uQ=;
        b=kadj1+RpkpN3OMqgTy6SkFPGUnDo5lbPAW26e8ZG/Wru6PyS5yzWbkYKm7rKWvJAcj
         8yfFz5T1SrrdC8LweKJqia21PXMqZJz43jjexsFNIS7qG6olNGNTwe+sUJ+/qbC2H9h2
         UPSvGFtAhDYv1AFAUCWQdSEuHo7z6pmIsTrpddErdkz1A84cUzTaFMERy3NVnjlynpDS
         ARtP2ZqjKVng555jT2pEqRtTfvvunhD+In41uHjJICjDKEZa2MU6Qlr6qzycGqgr7ojI
         zvrCJzDPpg3t8pyXqb2MRI/L4qgkMdLr68Zqp2x060iLnUX+9Za0bvrISdVz+0700d45
         ekaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OG1ttL9ewGmsGATx0jj/rue5KngBOTueLt43dOoL/uQ=;
        b=ONL+v7/gqpAd0gTs6CUtxMYPIkG7ZqZpA2u2OH/4S38wmkYpDEiIYnMi1MXQj4KY6M
         M0m0+X85sHbWwe3PU86rAYhNBG0TIPa93SbhxP9vJlUkjkc41imGvsopvsmdecwaiXJB
         mvH326U3LjU608IlTWgJm5WbQwiu7Mmu5OAAyZF3KpcNxiPwnDQk8761ThUnaORGBMDa
         UPbGEzph16VB4valc8Dft6dotezBhHLz2B7Ap2a4/ERCSQ86t4pdcVFqTFxUzBbvazN2
         QstkX/z8NRRzzfZLzyqgRa3dvHuJR7YzPO6lLmP9RIK+kq6qjlXiGq8hrDNLQ32AreUC
         v9HQ==
X-Gm-Message-State: ACrzQf2IV9KAiNeMgXqKTY3dBDHdLLW2M5q6Jl1Uvu+6rT+O5qgC31NC
        EJTP/AfcTDbUYV2WEXWEwTr3dOk5Ui3W3apeAPnhjQ==
X-Google-Smtp-Source: AMsMyM5bdxxX/B3p+dGzMVa9PvhoxBYILQz8c3lJUlNFYN1MuKw3YxaYc+MFlvxZD/fUrBq9xvhomYOgrimsfscLWfk=
X-Received: by 2002:a92:4449:0:b0:2de:95f1:8b80 with SMTP id
 a9-20020a924449000000b002de95f18b80mr20015373ilm.232.1667558234932; Fri, 04
 Nov 2022 03:37:14 -0700 (PDT)
MIME-Version: 1.0
References: <20221028093403.6673-1-vincent.guittot@linaro.org>
 <20221028093403.6673-7-vincent.guittot@linaro.org> <20221101192848.pjns3um7dnrwrk5p@airbuntu>
 <CAKfTPtA=vJQA_=6Un1CqwzMUaOxMeFGTKUZnj8qyqvqmSdYBAg@mail.gmail.com>
 <20221103142732.m5ibwkuymvhcdxkn@airbuntu> <CAKfTPtDu=c-psGnHkoWSPRWoh1Z0VBBfsN++g+krv4B1SJmFjg@mail.gmail.com>
 <CAEXW_YQd2y9=RHw3Sge7ghnhBz0AyR+B-U4zG10LXuSbg5bGSA@mail.gmail.com>
In-Reply-To: <CAEXW_YQd2y9=RHw3Sge7ghnhBz0AyR+B-U4zG10LXuSbg5bGSA@mail.gmail.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 4 Nov 2022 11:37:03 +0100
Message-ID: <CAKfTPtBJQOY7UUkm1=wvG18UWgLLiTW0dr3bTGUJY=siM_LLxQ@mail.gmail.com>
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
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Nov 2022 at 11:15, Joel Fernandes <joel@joelfernandes.org> wrote:
>
> On Thu, Nov 3, 2022 at 5:03 PM Vincent Guittot
> <vincent.guittot@linaro.org> wrote:
> >
> > On Thu, 3 Nov 2022 at 15:27, Qais Yousef <qyousef@layalina.io> wrote:
> > >
> > > On 11/03/22 09:46, Vincent Guittot wrote:
> > > > On Tue, 1 Nov 2022 at 20:28, Qais Yousef <qyousef@layalina.io> wrot=
e:
> > > > >
> > > > > On 10/28/22 11:34, Vincent Guittot wrote:
> > > > > > Task can set its latency priority with sched_setattr(), which i=
s then used
> > > > > > to set the latency offset of its sched_enity, but sched group e=
ntities
> > > > > > still have the default latency offset value.
> > > > > >
> > > > > > Add a latency.nice field in cpu cgroup controller to set the la=
tency
> > > > > > priority of the group similarly to sched_setattr(). The latency=
 priority
> > > > > > is then used to set the offset of the sched_entities of the gro=
up.
> > > > > >
> > > > > > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > > > > > ---
> > > > > >  Documentation/admin-guide/cgroup-v2.rst |  8 ++++
> > > > > >  kernel/sched/core.c                     | 52 +++++++++++++++++=
++++++++
> > > > > >  kernel/sched/fair.c                     | 33 ++++++++++++++++
> > > > > >  kernel/sched/sched.h                    |  4 ++
> > > > > >  4 files changed, 97 insertions(+)
> > > > > >
> > > > > > diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Document=
ation/admin-guide/cgroup-v2.rst
> > > > > > index be4a77baf784..d8ae7e411f9c 100644
> > > > > > --- a/Documentation/admin-guide/cgroup-v2.rst
> > > > > > +++ b/Documentation/admin-guide/cgroup-v2.rst
> > > > > > @@ -1095,6 +1095,14 @@ All time durations are in microseconds.
> > > > > >          values similar to the sched_setattr(2). This maximum u=
tilization
> > > > > >          value is used to clamp the task specific maximum utili=
zation clamp.
> > > > > >
> > > > > > +  cpu.latency.nice
> > > > > > +     A read-write single value file which exists on non-root
> > > > > > +     cgroups.  The default is "0".
> > > > > > +
> > > > > > +     The nice value is in the range [-20, 19].
> > > > > > +
> > > > > > +     This interface file allows reading and setting latency us=
ing the
> > > > > > +     same values used by sched_setattr(2).
> > > > >
> > > > > I'm still not sure about this [1].
> > > >
> > > > I'm still not sure about what you are trying to say here ...
> > > >
> > > > This is about setting a latency nice prio to a group level.
> > > >
> > > > >
> > > > > In some scenarios we'd like to get the effective latency_nice of =
the task. How
> > > > > will the task inherit the cgroup value or be impacted by it?
> > > > >
> > > > > For example if there are tasks that belong to a latency sensitive=
 cgroup; and
> > > > > I'd like to skip some searches in EAS to improve that latency sen=
sitivity - how
> > > > > would I extract this info in EAS path given these tasks are using=
 default
> > > > > latency_nice value? And if should happen if their latency_nice is=
 set to
> > > > > something else other than default?
> > > > >
> > > > > [1] https://lore.kernel.org/lkml/20221012160734.hrkb5jcjdq7r23pr@=
wubuntu/
> > > >
> > > > Hmm so you are speaking about something that is not part of the pat=
ch.
> > > > Let focus on the patchset for now
> > >
> > > I am focusing on this patchset. Isn't this an essential part of the d=
esign?
> > > Once the interface is out we can't change it. As it stands, I can't s=
ee how it
> >
> > So, are you speaking about the interface i.e. setting a value between [=
-20:19]
> >
> > > can be used to replace prefer_idle in cgroup as used in Android. I ca=
n't see
> > > how this could happen if we don't define how the task will inherit th=
e cgroup
> > > value. If we can, mind elaborating how please?
> >
> > Or how to take into account the value set for a cgroup ?
> >
> > Regarding the behavior, the rule remains the same that a sched_entity
> > attached to a cgroup will not get more (latency in this case) than
> > what has been set for the group entity.
>
> I think the interface solves a different problem which is latency of
> task or cgroup wrt other group. Vincent, you are setting this for a
> =E2=80=9Ctop app=E2=80=9D group in android in your tests, and seeing impr=
ovement
> correct? AFAICS, this improvement comes because of lower latency

Yes Top app and display group

> during *same CPU* competition between different groups by juggling
> around the wakeup-preemption window -- which maybe is good for
> Android.
>
> OTOH, the =E2=80=9Cprefer idle=E2=80=9D flag in android that Qais is refe=
rring to,
> will need a completely different method as I cannot see how a nice
> value can communicate that (that can complement Vincent's changes
> here). And it will need to have a per-task interface as well. We have

Why a negative latency_nice value condition can't be used ? or latency -20 =
 ?

> something in ChromeOS as well, which is a proc knob and also
> out-of-tree patch for that [1]. Without [1] we fail Android CTS
> testing on a recent ARM64 ChromeOS device.
> [1] https://chromium-review.googlesource.com/c/chromiumos/third_party/ker=
nel/+/3884575
> The changelog in [1] also has a detailed description of the ChromeOS usec=
ase.
>
> Qais, any other reason you can see why Vincent's change will not be a
> good thing for Android? Since you 1 CGroup for the whole user-facing
> app (top app), you can just set that to a low "latency_nice" and get
> better wake-up latency for that.
>
> (Side rant about latency and CFS -- IMHO a better long term solution
> for lower latency is to use RT but don't throttle -- rather demote. Or
> break CFS into multiple tiers, and apply demotion. This is in a way
> what Vincent is doing, as the task becomes more CPU bound'ish, he's
> taking away the latency boost. Vincent/Qais, somebody was working on
> the RT demotion vs throttling a while back, any idea on the latest on
> that?).
>
> thanks,
>
>  - Joel
>
>
> >
> > >
> > >
> > > Thanks
> > >
> > > --
> > > Qais Yousef
