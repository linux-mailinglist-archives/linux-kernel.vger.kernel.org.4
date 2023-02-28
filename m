Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7FFC6A5451
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 09:21:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbjB1IVP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 03:21:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbjB1IVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 03:21:13 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 854392A16A
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 00:21:11 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id bm20so7322992oib.7
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 00:21:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rp4eDBel7YPQ04cT6iyNOuZXbbZjaaS9pM3AX1yRbGc=;
        b=Iq+dqkwBSAMrY2T8e7JTMvJE3EFfp7pZCBpzDvWflozrlPYoNMc6a+Du0L3wXtvNry
         7q6O/Se5WJBxZOSv9Pe0+66r6HXBF43TwpVaXIbJj8A3ZAsmMWNZzr/J3Xn23zm+9FPv
         u+81dn78wBFIyaVDOWe+i2cnge5Gqpwu7KIJdInFKkX3SYx43/YmHYWUeq6O4rs/wik7
         JT9zaCR4fnOfimnVHRmWbVk0d48UW74yxhRILTytMq2wPtm3Yqc9+cVZ++VKlLkxnex7
         jvY3atEcivrOxRVOCPjAEiJEBVZPJUV9TeLdioM7V7Ni7y4cCf4h8yeOhdoXM6T+MDZf
         XGRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rp4eDBel7YPQ04cT6iyNOuZXbbZjaaS9pM3AX1yRbGc=;
        b=bpvlcC6HkkDR5twdrC5DPhUf1niKu0AfG3AIZh22yBbV80+W72Kq26zX1SOI3LYsPh
         CdsF6wUZ0yjIFJ18YM0D6x2MrLYYES3QeHeFEy4YioCVeP+bOSpjl1P8cjRPhran7a29
         uYojZdlEaKlFqi57xoXTPk5qzeP7hjlnKYXYBoR320FECAq+Xe23wb0AFekw2iKXSAgz
         v42CtmIFXqXI8NL9m6ed5PaI175tBZnW5rCYP8b2/cyI0CnHy2H4mIvuYrLeFqSgXOKt
         vBv2AVUclodGo5EDxCfL0iUow9eiWiaYADeBD1ise2jpJ35mB6ri1/VD/IXiRoQAlPEp
         8+Dg==
X-Gm-Message-State: AO0yUKWhLAuBrGiVG86nwIObvmXn9dJBE9CZyk9isRgki7nXwuc1Diyr
        55jY5fNtghJf2iyohfBkOoDbBf6s3NvSvivwabA=
X-Google-Smtp-Source: AK7set/Mhzf0iB16i+a38L1GKgDdj6qlMLjNAKEIESVDmKcNk5mpuOwKwXQXT8YWNfV1dMdMPAYaXAqANyff0Hiq7xk=
X-Received: by 2002:a05:6808:2a0b:b0:384:21e7:9792 with SMTP id
 ez11-20020a0568082a0b00b0038421e79792mr685892oib.6.1677572470821; Tue, 28 Feb
 2023 00:21:10 -0800 (PST)
MIME-Version: 1.0
References: <20230222080314.2146-1-xuewen.yan@unisoc.com> <Y/zO8WZV2kvcU78b@hirez.programming.kicks-ass.net>
 <20230227220735.3kaytmtt53uoegq7@airbuntu> <CAB8ipk--trBk-Acsjz7YDb5szPLc93ejPXVXQBJdomZO4OrpGQ@mail.gmail.com>
 <CAKfTPtBdMO6_APib1OBxW+fdAORX8vXdT-W3fWTRffa5-8bGxQ@mail.gmail.com>
In-Reply-To: <CAKfTPtBdMO6_APib1OBxW+fdAORX8vXdT-W3fWTRffa5-8bGxQ@mail.gmail.com>
From:   Xuewen Yan <xuewen.yan94@gmail.com>
Date:   Tue, 28 Feb 2023 16:20:59 +0800
Message-ID: <CAB8ipk96OXJcmp_H5EcagrMUigSFdW_gd4wwGjfjBpyP6hqaTg@mail.gmail.com>
Subject: Re: [RFC PATCH] sched/fair: update the vruntime to be max vruntime
 when yield
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Qais Yousef <qyousef@layalina.io>,
        Peter Zijlstra <peterz@infradead.org>,
        Xuewen Yan <xuewen.yan@unisoc.com>, mingo@redhat.com,
        juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, ke.wang@unisoc.com,
        zhaoyang.huang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vincent

On Tue, Feb 28, 2023 at 3:53=E2=80=AFPM Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> On Tue, 28 Feb 2023 at 08:42, Xuewen Yan <xuewen.yan94@gmail.com> wrote:
> >
> > Hi
> >
> > Thanks very much for comments!
> >
> > On Tue, Feb 28, 2023 at 6:33=E2=80=AFAM Qais Yousef <qyousef@layalina.i=
o> wrote:
> > >
> > > On 02/27/23 16:40, Peter Zijlstra wrote:
> > > > On Wed, Feb 22, 2023 at 04:03:14PM +0800, Xuewen Yan wrote:
> > > > > When task call the sched_yield, cfs would set the cfs's skip budd=
y.
> > > > > If there is no other task call the sched_yield syscall, the task =
would
> > > > > always be skiped when there are tasks in rq.
> > > >
> > > > So you have two tasks A) which does sched_yield() and becomes ->ski=
p,
> > > > and B) which is while(1). And you're saying that once A does it's t=
hing,
> > > > B runs forever and starves A?
> > >
> > > I read it differently.
> > >
> > > I understood that there are multiple tasks.
> > >
> > > If Task A becomes ->skip; then it seems other tasks will continue to =
be picked
> > > instead. Until another task B calls sched_yield() and become ->skip, =
then Task
> > > A is picked but with wrong vruntime causing it to run for multiple ti=
cks (my
> > > interpretation of 'always run' below).
> > >
> > > There are no while(1) task running IIUC.
> > >
> > > >
> > > > > As a result, the task's
> > > > > vruntime would not be updated for long time, and the cfs's min_vr=
untime
> > > > > is almost not updated.
> > > >
> > > > But the condition in pick_next_entity() should ensure that we still=
 pick
> > > > ->skip when it becomes too old. Specifically, when it gets more tha=
n
> > > > wakeup_gran() behind.
> > >
> > > I am not sure I can see it either. Maybe __pick_first_entity() doesn'=
t return
> > > the skipped one, or for some reason vdiff for second is almost always
> > > < wakeup_gran()?
> > >
> > > >
> > > > > When this scenario happens, when the yield task had wait for a lo=
ng time,
> > > > > and other tasks run a long time, once there is other task call th=
e sched_yield,
> > > > > the cfs's skip_buddy is covered, at this time, the first task can=
 run normally,
> > > > > but the task's vruntime is small, as a result, the task would alw=
ays run,
> > > > > because other task's vruntime is big. This would lead to other ta=
sks can not
> > > > > run for a long time.
> > >
> > > The error seems that when Task A finally runs - it consumes more than=
 its fair
> > > bit of sched_slice() as it looks it was starved.
> > >
> > > I think the question is why it was starved? Can you shed some light X=
uewen?
> > >
> > > My attempt to help to clarify :) I have read this just like you.
> >
> > Thanks for Qais's clarify. And that's exactly what I want to say:)
> >
> > >
> > > FWIW I have seen a report of something similar, but I didn't managed =
to
> > > reproduce and debug (mostly due to ENOBANDWIDTH); and not sure if the=
 details
> > > are similar to what Xuewen is seeing. But there was a task starving f=
or
> > > multiple ticks - RUNNABLE but never RUNNING in spite of other tasks g=
etting
> > > scheduled in instead multiple times. ie: there was a task RUNNING for=
 most of
> > > the time, and I could see it preempted by other tasks multiple time, =
but not by
> > > the starving RUNNABLE task that is hung on the rq. It seems to be vru=
ntime
> > > related too but speculating here.
> >
> > Yes, now we met the similar scenario when running a monkey test on the
> > android phone.
> > There are multiple tasks on cpu, but the runnable task could not be
> > got scheduled for a long time,
> > there is task running and we could see the task preempted by other
> > tasks multiple times.
> > Then we dump the tasks, and find the vruntime of each task varies
> > greatly, and the task which running call the sched_yield frequently.
>
> If I'm not wrong you are using cgroups and as a result you can't
> compare the vruntime of tasks that belongs to different group, you
> must compare the vruntime of entities at the same level. We might have
> to look the side because I can't see why the task would not be
> schedule if other tasks in the same group move forward their vruntime

All the tasks belong to the same cgroup.

Thanks=EF=BC=81

>
> > So we suspect that sched_yield affects the task's vruntime, as
> > previously described=EF=BC=8Cthe yield's task's vruntime is too small.
> >
> > There are some tasks's vruntime as follow:
> >
> > [status: curr] pid: 25501 prio: 116 vrun: 16426426403395799812
> > [status: skip] pid: 25496 prio: 116 vrun: 16426426403395800756
> > exec_start: 326203047009312 sum_ex: 29110005599
> > [status: pend] pid: 25497 prio: 116 vrun: 16426426403395800705
> > exec_start: 326203047002235 sum_ex: 29110508751
> > [status: pend] pid: 25496 prio: 116 vrun: 16426426403395800756
> > exec_start: 326203047009312 sum_ex: 29110005599
> > [status: pend] pid: 25498 prio: 116 vrun: 16426426403395803053
> > exec_start: 326203046944427 sum_ex: 28759519211
> > [status: pend] pid: 25321 prio: 130 vrun: 16668783152248554223
> > exec_start: 0 sum_ex: 16198728
> > [status: pend] pid: 25798 prio: 112 vrun: 17467381818375696015
> > exec_start: 0 sum_ex: 9574265
> > [status: pend] pid: 24650 prio: 120 vrun: 17811488667922679996
> > exec_start: 0 sum_ex: 4069384
> > [status: pend] pid: 26082 prio: 120 vrun: 17876565509001103803
> > exec_start: 0 sum_ex: 1184039
> > [status: pend] pid: 22282 prio: 120 vrun: 18010356387391134435
> > exec_start: 0 sum_ex: 53192
> > [status: pend] pid: 16714 prio: 120 vrun: 18136518279692783235
> > exec_start: 0 sum_ex: 53844952
> > [status: pend] pid: 26188 prio: 120 vrun: 18230794395956633597
> > exec_start: 0 sum_ex: 13248612
> > [status: pend] pid: 17645 prio: 120 vrun: 18348420256270370795
> > exec_start: 0 sum_ex: 4774925
> > [status: pend] pid: 24259 prio: 120 vrun: 359915144918430571
> > exec_start: 0 sum_ex: 20508197
> > [status: pend] pid: 25988 prio: 120 vrun: 558552749871164416
> > exec_start: 0 sum_ex: 2099153
> > [status: pend] pid: 21857 prio: 124 vrun: 596088822758688878
> > exec_start: 0 sum_ex: 246057024
> > [status: pend] pid: 26614 prio: 130 vrun: 688210016831095807
> > exec_start: 0 sum_ex: 968307
> > [status: pend] pid: 14229 prio: 120 vrun: 816756964596474655
> > exec_start: 0 sum_ex: 793001
> > [status: pend] pid: 23866 prio: 120 vrun: 1313723379399791578
> > exec_start: 0 sum_ex: 1507038
> > [status: pend] pid: 23389 prio: 120 vrun: 1351598627096913799
> > exec_start: 0 sum_ex: 1648576
> > [status: pend] pid: 25118 prio: 124 vrun: 2516103258334576715
> > exec_start: 0 sum_ex: 270423
> > [status: pend] pid: 26412 prio: 120 vrun: 2674093729417543719
> > exec_start: 0 sum_ex: 1851229
> > [status: pend] pid: 26271 prio: 112 vrun: 2728945479807426354
> > exec_start: 0 sum_ex: 3347695
> > [status: pend] pid: 24236 prio: 120 vrun: 2919301292085993527
> > exec_start: 0 sum_ex: 5425846
> > [status: pend] pid: 22077 prio: 120 vrun: 3262582494560783155
> > exec_start: 325875071065811 sum_ex: 177555259
> > [status: pend] pid: 18951 prio: 120 vrun: 3532786464053787829
> > exec_start: 0 sum_ex: 2634964
> > [status: pend] pid: 18957 prio: 120 vrun: 3532786464053920593
> > exec_start: 0 sum_ex: 95538
> > [status: pend] pid: 18914 prio: 131 vrun: 3532786465880282335
> > exec_start: 0 sum_ex: 6374535
> > [status: pend] pid: 17595 prio: 120 vrun: 4839728055620845452
> > exec_start: 0 sum_ex: 29559732
> > [status: pend] pid: 32520 prio: 120 vrun: 5701873672841711178
> > exec_start: 0 sum_ex: 21486313
> > [status: pend] pid: 24287 prio: 120 vrun: 5701873673743456663
> > exec_start: 0 sum_ex: 757778741
> > [status: pend] pid: 25544 prio: 120 vrun: 6050206507780284054
> > exec_start: 0 sum_ex: 13624309
> > [status: pend] pid: 26049 prio: 130 vrun: 6144859778903604771
> > exec_start: 0 sum_ex: 20931577
> > [status: pend] pid: 26848 prio: 130 vrun: 6144859796032488859
> > exec_start: 0 sum_ex: 2541963
> > [status: pend] pid: 21450 prio: 120 vrun: 6451880484497196814
> > exec_start: 0 sum_ex: 83490289
> > [status: pend] pid: 15765 prio: 120 vrun: 6479239764142283860
> > exec_start: 0 sum_ex: 1481737271
> > [status: pend] pid: 16366 prio: 120 vrun: 6479239764269019562
> > exec_start: 0 sum_ex: 952608921
> > [status: pend] pid: 16086 prio: 120 vrun: 6479239764301244958
> > exec_start: 0 sum_ex: 37393777
> > [status: pend] pid: 25970 prio: 120 vrun: 6830180148220001175
> > exec_start: 0 sum_ex: 2531884
> > [status: pend] pid: 25965 prio: 120 vrun: 6830180150700833203
> > exec_start: 0 sum_ex: 8031809
> > [status: pend] pid: 14098 prio: 120 vrun: 7018832854764682872
> > exec_start: 0 sum_ex: 32975920
> > [status: pend] pid: 26860 prio: 116 vrun: 7086059821707649029
> > exec_start: 0 sum_ex: 246173830
> >
> >
> > Thanks=EF=BC=81
> > BR
> > >
> > >
> > > Cheers
> > >
> > > --
> > > Qais Yousef
> > >
> > > >
> > > > I'm not seeing how this could happen, it should never get behind th=
at
> > > > far.
> > > >
> > > > Additionally, check_preempt_tick() will explicitly clear the buddie=
s
> > > > when it finds the current task has consumed it's ideal slice.
> > > >
> > > > I really cannot see how your scenario can happen.
> > > >
> > > > > In order to mitigate this, update the yield_task's vruntime to be=
 cfs's max vruntime.
> > > > > This way, the cfs's min vruntime can be updated as the process ru=
nning.
> > > >
> > > > This is a bad solution, SCHED_IDLE tasks have very low weight and c=
an be
> > > > shot really far to the right, leading to other trouble.
> > > >
