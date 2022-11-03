Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BA396185AF
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 18:04:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232081AbiKCREE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 13:04:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232059AbiKCRDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 13:03:41 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 217F31D664
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 10:03:08 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id bp12so61371ilb.9
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 10:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6G6uk//W3kXTkUAvm3lBfohI4sT49rsYhKVBHFlijQo=;
        b=Jb5FYJz0WwK+EUyZGfu4xWGMK/maXMFH12xWZQI9F4z4fFpJGSB8mA+O/tT/RmHvW1
         pFFfZx7JSaGYBu6GAhkOvHHuY6EI4TRSRSmP5Bjv3kli4+BMkBMhB9cEpxCNmnWQzyRV
         wxN67C9KcLiADXzZuc/L/OB81DKodBcE77phPEnd+D68SXeQq++PHs+5w64NbiC951zG
         oha6I3FS+M4tIASmadGiS7IrWZ543DzPWHsJTS5mWf1cY48tBuMhacNiLdi5Ic6/d/Ip
         GAfx8ErNQIL+lE53H1Cn80kfZJRHqCm8fMK8B4lteUkXUFmE7EwuKgamCAJMzDwPmSF+
         u0eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6G6uk//W3kXTkUAvm3lBfohI4sT49rsYhKVBHFlijQo=;
        b=nsp8eyVj1OIpSekH/3Uz/CA5r38I2eJYEtcDTufMHp9CpoAIi4TdNZ1iJbb60CtO6N
         Tgu8jpi/F9+ZJPWLWkIkZ1no7PPy+tnt8Y3p3c7qNYK6F0fAPkkpW0KzxPLv88aW/M0F
         MBpMpEEmWO4HfcO08kyNWnajgOHUf1lqGTS1AOxXd6Sy1aPmklI9NCnlq1Jdjq0CBBai
         GM/iSC/6TXnhYdtWHx47gRj3xvNvBqFsbO53MUemrFtB3UVm7N3Ba4MfPrkfYxSpbC9H
         GnAyvvGd1qKcWamBZSO7QWXwaRFBdIUPBYHxzJhZ0ajAAViGtzqTTtucsy7ywYGU9Ga4
         JxFg==
X-Gm-Message-State: ACrzQf3TozuxHYaKrOlAlyAn4npAao7jHQ6n9lkdvqWfFQnOW6i3dJz2
        LcL8Q/yh++zCBkK6ReFoQKP5NbWaM+CC2SbnBb2Y3g==
X-Google-Smtp-Source: AMsMyM4Gt8qEQxm02/g5stUM1k77IWWbGntuLJJkUIVA39kTTdWW12Umm8UK3m4ToT1ZOSMS87JkJ9x9Ugx84Kx42Ns=
X-Received: by 2002:a92:4449:0:b0:2de:95f1:8b80 with SMTP id
 a9-20020a924449000000b002de95f18b80mr17988426ilm.232.1667494988194; Thu, 03
 Nov 2022 10:03:08 -0700 (PDT)
MIME-Version: 1.0
References: <20221028093403.6673-1-vincent.guittot@linaro.org>
 <20221028093403.6673-7-vincent.guittot@linaro.org> <20221101192848.pjns3um7dnrwrk5p@airbuntu>
 <CAKfTPtA=vJQA_=6Un1CqwzMUaOxMeFGTKUZnj8qyqvqmSdYBAg@mail.gmail.com> <20221103142732.m5ibwkuymvhcdxkn@airbuntu>
In-Reply-To: <20221103142732.m5ibwkuymvhcdxkn@airbuntu>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 3 Nov 2022 18:02:56 +0100
Message-ID: <CAKfTPtDu=c-psGnHkoWSPRWoh1Z0VBBfsN++g+krv4B1SJmFjg@mail.gmail.com>
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

On Thu, 3 Nov 2022 at 15:27, Qais Yousef <qyousef@layalina.io> wrote:
>
> On 11/03/22 09:46, Vincent Guittot wrote:
> > On Tue, 1 Nov 2022 at 20:28, Qais Yousef <qyousef@layalina.io> wrote:
> > >
> > > On 10/28/22 11:34, Vincent Guittot wrote:
> > > > Task can set its latency priority with sched_setattr(), which is then used
> > > > to set the latency offset of its sched_enity, but sched group entities
> > > > still have the default latency offset value.
> > > >
> > > > Add a latency.nice field in cpu cgroup controller to set the latency
> > > > priority of the group similarly to sched_setattr(). The latency priority
> > > > is then used to set the offset of the sched_entities of the group.
> > > >
> > > > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > > > ---
> > > >  Documentation/admin-guide/cgroup-v2.rst |  8 ++++
> > > >  kernel/sched/core.c                     | 52 +++++++++++++++++++++++++
> > > >  kernel/sched/fair.c                     | 33 ++++++++++++++++
> > > >  kernel/sched/sched.h                    |  4 ++
> > > >  4 files changed, 97 insertions(+)
> > > >
> > > > diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
> > > > index be4a77baf784..d8ae7e411f9c 100644
> > > > --- a/Documentation/admin-guide/cgroup-v2.rst
> > > > +++ b/Documentation/admin-guide/cgroup-v2.rst
> > > > @@ -1095,6 +1095,14 @@ All time durations are in microseconds.
> > > >          values similar to the sched_setattr(2). This maximum utilization
> > > >          value is used to clamp the task specific maximum utilization clamp.
> > > >
> > > > +  cpu.latency.nice
> > > > +     A read-write single value file which exists on non-root
> > > > +     cgroups.  The default is "0".
> > > > +
> > > > +     The nice value is in the range [-20, 19].
> > > > +
> > > > +     This interface file allows reading and setting latency using the
> > > > +     same values used by sched_setattr(2).
> > >
> > > I'm still not sure about this [1].
> >
> > I'm still not sure about what you are trying to say here ...
> >
> > This is about setting a latency nice prio to a group level.
> >
> > >
> > > In some scenarios we'd like to get the effective latency_nice of the task. How
> > > will the task inherit the cgroup value or be impacted by it?
> > >
> > > For example if there are tasks that belong to a latency sensitive cgroup; and
> > > I'd like to skip some searches in EAS to improve that latency sensitivity - how
> > > would I extract this info in EAS path given these tasks are using default
> > > latency_nice value? And if should happen if their latency_nice is set to
> > > something else other than default?
> > >
> > > [1] https://lore.kernel.org/lkml/20221012160734.hrkb5jcjdq7r23pr@wubuntu/
> >
> > Hmm so you are speaking about something that is not part of the patch.
> > Let focus on the patchset for now
>
> I am focusing on this patchset. Isn't this an essential part of the design?
> Once the interface is out we can't change it. As it stands, I can't see how it

So, are you speaking about the interface i.e. setting a value between [-20:19]

> can be used to replace prefer_idle in cgroup as used in Android. I can't see
> how this could happen if we don't define how the task will inherit the cgroup
> value. If we can, mind elaborating how please?

Or how to take into account the value set for a cgroup ?

Regarding the behavior, the rule remains the same that a sched_entity
attached to a cgroup will not get more (latency in this case) than
what has been set for the group entity.

>
>
> Thanks
>
> --
> Qais Yousef
