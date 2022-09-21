Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 481E35BF829
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 09:48:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbiIUHss (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 03:48:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230420AbiIUHsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 03:48:30 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 701C97C194
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 00:48:29 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id x27so7917082lfu.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 00:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=w09GhBg/CCesrs6hDU7BoXWExnhS9puhm5DQpvlGDw8=;
        b=vGr3F3PoxLieE6hkrowx4WToBzyumdDcUDDfWYOVX2Dt7k1POLlbF9lLQrN7WwBb+v
         B0zc1L2mvByJnRwd8Bp+5CYm+kN5HZINa8PAZPe7uase3FXmpBbbnw7iDqgRcw83VVIQ
         GWhQOGREobzn7uU+LpHtvUxEG2fZLoG2neoCNOBjpaQNhsyl4wfrwos6/mvLIqBCGzzT
         73jep8NkPMeamff/a5zQ1lQY0o3VbP72yGXfMaEqEWf0HQ9gw4dqXxsYZ/p35zMWcfO4
         pCDd9djnVAvI6USJnVQN4Z1tFTLtMH0jEITw4WbYrVIOxJlSr8+lsjpacCk8LghO7Ndu
         9JYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=w09GhBg/CCesrs6hDU7BoXWExnhS9puhm5DQpvlGDw8=;
        b=C2ItjxtaMHMn0k5ZhVVUASi/hNOZPHadSPk0LCX+js/UeoKK56rovGGVhK7dG1ogcs
         duJcuOMKO6XgryCzTEXshY7R7sEbUFhMaa+izUk8TVm07ZE5I7moHyuGlW/AcbaBy4Oc
         wZ0UAT62fyJsGGe00EvzWzuoSWIbTqj/mr+VO2zY+1dnT7tKMuexSRtBKZID54YjpVHQ
         6NmMevpWLK+Cv3eGfBDFiIeuwP3cWrDS8ye21QQFyl0BVg8/USML1FmrrzPd/Adxzpad
         Q+nsXZjj3X1/XFK2jsWShuBzqZdVjltP8DldrWmJ46t3rNx3D9dty9WaZqxWZFJCxbd8
         OC+Q==
X-Gm-Message-State: ACrzQf0ioszWnE2ev470KpxXCdJ5WWYOKTwrZSLJ2dBmk3B/wKhmMvJe
        eCk+hiI7UsOJDH8HQ8pZ9Jf3xYl+/zg991VQxkWG+Q==
X-Google-Smtp-Source: AMsMyM4hz2aZcbZJkruWuC6ymYf8F7xjFSLSyPb//e1t8IY2/kg6LEhQmfI+b3Vtj30Pp0zJw7Dyvmt4HdjW++CT/1I=
X-Received: by 2002:a05:6512:c20:b0:499:18:c967 with SMTP id
 z32-20020a0565120c2000b004990018c967mr9177178lfu.18.1663746507688; Wed, 21
 Sep 2022 00:48:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220916080305.29574-1-vincent.guittot@linaro.org>
 <20220916080305.29574-7-vincent.guittot@linaro.org> <000c2893-feb4-373d-2234-2ca74be94714@arm.com>
 <CAKfTPtASminP4ogVRhcvQ4R3-x-E+UUzuMaEu-xQU_MtLr9+Xg@mail.gmail.com> <07193d97-476a-498f-e738-e7920c2fdeea@arm.com>
In-Reply-To: <07193d97-476a-498f-e738-e7920c2fdeea@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 21 Sep 2022 09:48:16 +0200
Message-ID: <CAKfTPtD9Wb1_6Dk-_r9ysaXJpYPFn3ragXbp6botwWQQhXv8=w@mail.gmail.com>
Subject: Re: [PATCH v4 6/8] sched/fair: Add sched group latency support
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, parth@linux.ibm.com,
        qais.yousef@arm.com, chris.hyser@oracle.com,
        valentin.schneider@arm.com, patrick.bellasi@matbug.net,
        David.Laight@aculab.com, pjt@google.com, pavel@ucw.cz,
        tj@kernel.org, qperret@google.com, tim.c.chen@linux.intel.com,
        joshdon@google.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Sept 2022 at 20:17, Dietmar Eggemann
<dietmar.eggemann@arm.com> wrote:
>
> On 19/09/2022 17:49, Vincent Guittot wrote:
> > On Mon, 19 Sept 2022 at 13:55, Dietmar Eggemann
> > <dietmar.eggemann@arm.com> wrote:
> >>
> >> s/valentin.schneider@arm.com//
> >>
> >> On 16/09/2022 10:03, Vincent Guittot wrote:
> >>> Task can set its latency priority, which is then used to decide to preempt
> >>> the current running entity of the cfs, but sched group entities still have
> >>> the default latency offset.
> >>>
> >>> Add a latency field in task group to set the latency offset of the
> >>> sched_eneities of the group, which will be used against other entities in
> >>
> >> s/sched_eneities/sched_entity
> >>
> >>> the parent cfs when deciding which entity to schedule first.
> >>
> >> So latency for cgroups does not follow any (existing) Resource
> >> Distribution Model/Scheme (Documentation/admin-guide/cgroup-v2.rst)?
> >> Latency values are only used to compare sched entities at the same level.
> >
> > Just like share/cpu.weight value does for time sharing
>
> But for this we define it as following the `Weights` scheme. That's why
> I was asking,
>
> >> [...]
> >>
> >>> +static int cpu_latency_write_s64(struct cgroup_subsys_state *css,
> >>> +                             struct cftype *cft, s64 latency)
> >>> +{
> >>
> >> There is no [MIN, MAX] checking?
> >
> > This is done is sched_group_set_latency() which checks that
> > abs(latency) < sysctl_sched_latency
>
> I see. Nit-picking: Wouldn't this allow to specify a latency offset
> value for the non-existent `nice = 20`? Highest nice value 19 maps to
> `973/1024 * sysctl_sched_latency`.

yes, but the same applies for tg->shares and cpu.weight as we can set
a tg->shares of 104,857,600 whereas the max shares for nice -20 is
90,891,264. Furthermore, I don't see a real problem with the ability
to set a latency offset up to sysctl_sched_latency because it's about
being even more nice with other task and not the opposite

>
> >
> >>
> >> min_weight = sched_latency_to_weight[0]  = -1024
> >> max_weight = sched_latency_to_weight[39] =   973
> >>
> >> [MIN, MAX] = [sysctl_sched_latency * min_weight >> NICE_LATENCY_SHIFT,
> >>               sysctl_sched_latency * max_weight >> NICE_LATENCY_SHIFT]
> >>
> >>
> >> With the `cpu.latency` knob user would have to know for example that the
> >> value is -24,000,000ns to get the same behaviour as for a task latency
> >> nice = -20 (latency prio = 0) (w/ sysctl_sched_latency = 24ms)?
> >
> > Yes, Tejun raised some concerns about adding an interface like nice in
> > the task group in v2 so I have removed it.
> >
> >>
> >> For `nice` we have `cpu.weight.nice` next to `cpu.weight` in cgroup v2 ?
> >
> > If everybody is ok, I can add back the cpu.latency.nice interface in
> > the v5 in addition to the cpu.latency
>
> cpu.weight/cpu.weight.nice interface:
>
> echo X > cpu.weight        tg->shares
>
>     1                          10,240
>   100                       1,048,576
> 10000                     104,857,600

>
> echo X > cpu.weight.nice
>
>   -20                     90,891,264
>     0                      1,048,576
>    19                         15,360
>
> Wouldn't then a similar interface for cpu.latency [1..100..10000] and
> cpu.latency.nice [-20..0..19] make most sense?

We need at least a signed value for cpu.latency to make the difference
between a sensitivity to the latency or a not careness

>
> Raw latency_offset values at interface level are not portable.

I can use [-1000:1000] but I' not sure it's better than the raw value at the end

>
>
