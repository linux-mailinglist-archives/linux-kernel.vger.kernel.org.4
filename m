Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFCEC617F7C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 15:27:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231476AbiKCO1s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 10:27:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbiKCO1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 10:27:38 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B565D14032
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 07:27:36 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id w14so3019866wru.8
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 07:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ejKIVllnVzoPYRW29Bdq8dzL3XB0ttVVTOobczUfmqw=;
        b=ckFVcUn1mgqJa9PTlNlWz62ELY2yhr9XXaabHjoqZMctPcAgDZ22hjPsTlM78Ao03c
         HZ8D/5Xg1dnrgsGPjWX6ibxsu+zkAZy3PJl5VkudTLV7X7ZoMMbFMx+QdWyLD9kZ53Su
         Y7/Hz5mOklgS05i+/udE/HxqA0VXjsX9axW4HJJyxWNd7GXPoNqinsniV4k1OXfcUj4A
         IAtW3nzOiLAVpWBSCYg7qfdaQjjc5V7gpFGFlZuAz50w4kyYUcC0w86MvjDJLFKqCe7D
         Ll4kgrJzncCrwI4ms9u+XuSevxofbXtDjun30yJkaVyXXLG9cphJZPD/NyqN8SHQrNN7
         HabQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ejKIVllnVzoPYRW29Bdq8dzL3XB0ttVVTOobczUfmqw=;
        b=3/5omSWWkba1pdUDgRkT5B0m4dIy9xfTq9scYOHrO6DzDXf45QKO/XUVORNQGDF0IW
         eOVRyc3kAi2MK+TX1yx4sa4J+b0FDZPMlpYfksQD6fwLnYT21chRPg7eIvlYHfmDqy0m
         3uvAdEdk6PJC6SZtAzJDJJcPdbxBUwi/YKikKYKAmwEazEyfxkau6y/WLWsFU7qly/fm
         MLF664qnK3Jtdq4wLp471YtO08lNd123WOGzXgpGRv+pdUiacbuLmfmXgIr1bVLBPUF6
         +WFN50VuC2eFUxgEJLmWwQxLk4tEv6BGDD2TdzXwTG22pFWggqbY5Zj/RV2fQGHy4bFz
         8Myg==
X-Gm-Message-State: ACrzQf148Khw7Y950+mtQ4rzd3tW0odBIfHN13QZV53Q3hHs6JA1wceE
        L+IZI1iRk3VxbLGLLtqjUZVNPQ==
X-Google-Smtp-Source: AMsMyM5QlaRUViySKtwKojkL1cljUicOeACOx1MuTpu/sZcBCYSmo3ZtILhQu0qdJogvedXdLYVjXw==
X-Received: by 2002:a05:6000:1e0b:b0:236:8a6e:8d with SMTP id bj11-20020a0560001e0b00b002368a6e008dmr18768236wrb.20.1667485655289;
        Thu, 03 Nov 2022 07:27:35 -0700 (PDT)
Received: from airbuntu ([104.132.45.104])
        by smtp.gmail.com with ESMTPSA id bj9-20020a0560001e0900b002365cd93d05sm1055712wrb.102.2022.11.03.07.27.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 07:27:34 -0700 (PDT)
Date:   Thu, 3 Nov 2022 14:27:32 +0000
From:   Qais Yousef <qyousef@layalina.io>
To:     Vincent Guittot <vincent.guittot@linaro.org>
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
Subject: Re: [PATCH v7 6/9] sched/fair: Add sched group latency support
Message-ID: <20221103142732.m5ibwkuymvhcdxkn@airbuntu>
References: <20221028093403.6673-1-vincent.guittot@linaro.org>
 <20221028093403.6673-7-vincent.guittot@linaro.org>
 <20221101192848.pjns3um7dnrwrk5p@airbuntu>
 <CAKfTPtA=vJQA_=6Un1CqwzMUaOxMeFGTKUZnj8qyqvqmSdYBAg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKfTPtA=vJQA_=6Un1CqwzMUaOxMeFGTKUZnj8qyqvqmSdYBAg@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/03/22 09:46, Vincent Guittot wrote:
> On Tue, 1 Nov 2022 at 20:28, Qais Yousef <qyousef@layalina.io> wrote:
> >
> > On 10/28/22 11:34, Vincent Guittot wrote:
> > > Task can set its latency priority with sched_setattr(), which is then used
> > > to set the latency offset of its sched_enity, but sched group entities
> > > still have the default latency offset value.
> > >
> > > Add a latency.nice field in cpu cgroup controller to set the latency
> > > priority of the group similarly to sched_setattr(). The latency priority
> > > is then used to set the offset of the sched_entities of the group.
> > >
> > > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > > ---
> > >  Documentation/admin-guide/cgroup-v2.rst |  8 ++++
> > >  kernel/sched/core.c                     | 52 +++++++++++++++++++++++++
> > >  kernel/sched/fair.c                     | 33 ++++++++++++++++
> > >  kernel/sched/sched.h                    |  4 ++
> > >  4 files changed, 97 insertions(+)
> > >
> > > diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
> > > index be4a77baf784..d8ae7e411f9c 100644
> > > --- a/Documentation/admin-guide/cgroup-v2.rst
> > > +++ b/Documentation/admin-guide/cgroup-v2.rst
> > > @@ -1095,6 +1095,14 @@ All time durations are in microseconds.
> > >          values similar to the sched_setattr(2). This maximum utilization
> > >          value is used to clamp the task specific maximum utilization clamp.
> > >
> > > +  cpu.latency.nice
> > > +     A read-write single value file which exists on non-root
> > > +     cgroups.  The default is "0".
> > > +
> > > +     The nice value is in the range [-20, 19].
> > > +
> > > +     This interface file allows reading and setting latency using the
> > > +     same values used by sched_setattr(2).
> >
> > I'm still not sure about this [1].
> 
> I'm still not sure about what you are trying to say here ...
> 
> This is about setting a latency nice prio to a group level.
> 
> >
> > In some scenarios we'd like to get the effective latency_nice of the task. How
> > will the task inherit the cgroup value or be impacted by it?
> >
> > For example if there are tasks that belong to a latency sensitive cgroup; and
> > I'd like to skip some searches in EAS to improve that latency sensitivity - how
> > would I extract this info in EAS path given these tasks are using default
> > latency_nice value? And if should happen if their latency_nice is set to
> > something else other than default?
> >
> > [1] https://lore.kernel.org/lkml/20221012160734.hrkb5jcjdq7r23pr@wubuntu/
> 
> Hmm so you are speaking about something that is not part of the patch.
> Let focus on the patchset for now

I am focusing on this patchset. Isn't this an essential part of the design?
Once the interface is out we can't change it. As it stands, I can't see how it
can be used to replace prefer_idle in cgroup as used in Android. I can't see
how this could happen if we don't define how the task will inherit the cgroup
value. If we can, mind elaborating how please?


Thanks

--
Qais Yousef
