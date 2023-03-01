Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05EA16A6894
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 09:09:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbjCAIJb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 03:09:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjCAIJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 03:09:29 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB84B303DD
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 00:09:27 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id y2so12524403pjg.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Mar 2023 00:09:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ixUKRDMXPLC0XmJPRE2Y6Pas/EBufGmDONKr+dRahu8=;
        b=DCNgS5acnZzK4raODtyO3XGQFHmrrt9TWhC13OZ0NEn65Y/ZWqhmFLhFbmIwSKUvIk
         5buN40rvSyVGxKUKiDmNQNh1H5MEMEbo6q+0NpiTSob5GuQ5oJiNsT552VNFVGlqgO6W
         wNMZF4YkHbdYC+QwlDmv7SvboUdpdxn7WSpnBwAJYj/IZYki85l8mJeReGkir4faPZYg
         MHkOsoQJAoqT7IS6e83wPXTV50z4Z+xVFXhl+7r81xchfcFFeumv5SAx94hAa4ft2Z6P
         iZqI56dvjsBzSYkamR54rvORA43b4nm8djlCRj67dZy3+7xqwmdFOmlYgn6Th7ilU2Qp
         muAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ixUKRDMXPLC0XmJPRE2Y6Pas/EBufGmDONKr+dRahu8=;
        b=wsoc58Fp0NzrUwyvlkWX4zU81UKi19echW0DMqXfej+jokMEgk1Rt43n8lY0ia8fSN
         woP0n+36f2OY0StVKtWFHaIbbvt+jWYzHdX+Px1AsQA2JgeiWOzwMqIu1VHwwmfD7/Pb
         NXxyNVR+xfO43wvOjI9Ocg1nVRywhYkPA6qEGI6q9M6F8cO5sQWVkvmAh50s9WgPfLaE
         5e8aFL/LH8RJF2t//VcLhpSJIIw36wIj1351eR67i61VDMUuSr4hx1DgwP11NGuNirrt
         IqQkMGPJv9jYzoVKqnX43VKsWx6KG+5Kw1tqCYI4wmxKWaOl6gPM8ureA8UV4hPnc5Qd
         Ogxg==
X-Gm-Message-State: AO0yUKXI8e+2+T3rojwFWZAqYYotSp/LkDb7breRZxBcNYP6fpOf3a/h
        IlrRrlQyuukrNiSXh/jg/O0zDXyO1vmenSf+YETNgg==
X-Google-Smtp-Source: AK7set/LKiRboDDUBJfMQ98UJdc34dadCbypFDYzaFDLekwlx604hDCblzZpUh9ZAkckS013c1qnFgZVQrroeIBEjK4=
X-Received: by 2002:a17:90a:9482:b0:233:d64d:4c29 with SMTP id
 s2-20020a17090a948200b00233d64d4c29mr2251656pjo.4.1677658167315; Wed, 01 Mar
 2023 00:09:27 -0800 (PST)
MIME-Version: 1.0
References: <20230222080314.2146-1-xuewen.yan@unisoc.com> <Y/zO8WZV2kvcU78b@hirez.programming.kicks-ass.net>
 <20230227220735.3kaytmtt53uoegq7@airbuntu> <CAB8ipk--trBk-Acsjz7YDb5szPLc93ejPXVXQBJdomZO4OrpGQ@mail.gmail.com>
 <CAKfTPtBdMO6_APib1OBxW+fdAORX8vXdT-W3fWTRffa5-8bGxQ@mail.gmail.com>
 <CAB8ipk96OXJcmp_H5EcagrMUigSFdW_gd4wwGjfjBpyP6hqaTg@mail.gmail.com>
 <CAKfTPtAvuz0SEDX3izcOhZkC+pFddqrSwY+iYO2p7U6N3Z2hRA@mail.gmail.com>
 <20230228133111.6i5tlhvthnfljvmf@airbuntu> <CAKfTPtAsxz7s6W2peoVj+EcNVQp6bpO6qhPPTXgfJxVtXHbaKQ@mail.gmail.com>
 <CAB8ipk83Ofywn0T19dHxjJNXfKcd9DD_EopQupeepjSk-XceRQ@mail.gmail.com>
In-Reply-To: <CAB8ipk83Ofywn0T19dHxjJNXfKcd9DD_EopQupeepjSk-XceRQ@mail.gmail.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 1 Mar 2023 09:09:16 +0100
Message-ID: <CAKfTPtDfSHnd7=ZG2S-x46kxw0Cc0RSXq+_B8Oe46fa3Fa75BA@mail.gmail.com>
Subject: Re: [RFC PATCH] sched/fair: update the vruntime to be max vruntime
 when yield
To:     Xuewen Yan <xuewen.yan94@gmail.com>
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Mar 2023 at 08:30, Xuewen Yan <xuewen.yan94@gmail.com> wrote:
>
> Hi Vincent
>
> I noticed the following patch:
> https://lore.kernel.org/lkml/20230209193107.1432770-1-rkagan@amazon.de/
> And I notice the V2 had merged to mainline:
> https://lore.kernel.org/all/20230130122216.3555094-1-rkagan@amazon.de/T/#=
u
>
> The patch fixed the inversing of the vruntime comparison, and I see
> that in my case, there also are some vruntime is inverted.
> Do you think which patch will work for our scenario? I would be very
> grateful if you could give us some advice.
> I would try this patch in our tree.

By default use the one that is merged; The difference is mainly a
matter of time range. Also be aware that the case of newly migrated
task is not fully covered by both patches.

This patch fixes a problem with long sleeping entity in the presence
of low weight and always running entities. This doesn't seem to be
aligned with the description of your use case

Vincent
>
> Thanks=EF=BC=81
> BR
>
> On Tue, Feb 28, 2023 at 9:45=E2=80=AFPM Vincent Guittot
> <vincent.guittot@linaro.org> wrote:
> >
> > On Tue, 28 Feb 2023 at 14:31, Qais Yousef <qyousef@layalina.io> wrote:
> > >
> > > On 02/28/23 10:07, Vincent Guittot wrote:
> > > > On Tue, 28 Feb 2023 at 09:21, Xuewen Yan <xuewen.yan94@gmail.com> w=
rote:
> > > > >
> > > > > Hi Vincent
> > > > >
> > > > > On Tue, Feb 28, 2023 at 3:53=E2=80=AFPM Vincent Guittot
> > > > > <vincent.guittot@linaro.org> wrote:
> > > > > >
> > > > > > On Tue, 28 Feb 2023 at 08:42, Xuewen Yan <xuewen.yan94@gmail.co=
m> wrote:
> > > > > > >
> > > > > > > Hi
> > > > > > >
> > > > > > > Thanks very much for comments!
> > > > > > >
> > > > > > > On Tue, Feb 28, 2023 at 6:33=E2=80=AFAM Qais Yousef <qyousef@=
layalina.io> wrote:
> > > > > > > >
> > > > > > > > On 02/27/23 16:40, Peter Zijlstra wrote:
> > > > > > > > > On Wed, Feb 22, 2023 at 04:03:14PM +0800, Xuewen Yan wrot=
e:
> > > > > > > > > > When task call the sched_yield, cfs would set the cfs's=
 skip buddy.
> > > > > > > > > > If there is no other task call the sched_yield syscall,=
 the task would
> > > > > > > > > > always be skiped when there are tasks in rq.
> > > > > > > > >
> > > > > > > > > So you have two tasks A) which does sched_yield() and bec=
omes ->skip,
> > > > > > > > > and B) which is while(1). And you're saying that once A d=
oes it's thing,
> > > > > > > > > B runs forever and starves A?
> > > > > > > >
> > > > > > > > I read it differently.
> > > > > > > >
> > > > > > > > I understood that there are multiple tasks.
> > > > > > > >
> > > > > > > > If Task A becomes ->skip; then it seems other tasks will co=
ntinue to be picked
> > > > > > > > instead. Until another task B calls sched_yield() and becom=
e ->skip, then Task
> > > > > > > > A is picked but with wrong vruntime causing it to run for m=
ultiple ticks (my
> > > > > > > > interpretation of 'always run' below).
> > > > > > > >
> > > > > > > > There are no while(1) task running IIUC.
> > > > > > > >
> > > > > > > > >
> > > > > > > > > > As a result, the task's
> > > > > > > > > > vruntime would not be updated for long time, and the cf=
s's min_vruntime
> > > > > > > > > > is almost not updated.
> > > > > > > > >
> > > > > > > > > But the condition in pick_next_entity() should ensure tha=
t we still pick
> > > > > > > > > ->skip when it becomes too old. Specifically, when it get=
s more than
> > > > > > > > > wakeup_gran() behind.
> > > > > > > >
> > > > > > > > I am not sure I can see it either. Maybe __pick_first_entit=
y() doesn't return
> > > > > > > > the skipped one, or for some reason vdiff for second is alm=
ost always
> > > > > > > > < wakeup_gran()?
> > > > > > > >
> > > > > > > > >
> > > > > > > > > > When this scenario happens, when the yield task had wai=
t for a long time,
> > > > > > > > > > and other tasks run a long time, once there is other ta=
sk call the sched_yield,
> > > > > > > > > > the cfs's skip_buddy is covered, at this time, the firs=
t task can run normally,
> > > > > > > > > > but the task's vruntime is small, as a result, the task=
 would always run,
> > > > > > > > > > because other task's vruntime is big. This would lead t=
o other tasks can not
> > > > > > > > > > run for a long time.
> > > > > > > >
> > > > > > > > The error seems that when Task A finally runs - it consumes=
 more than its fair
> > > > > > > > bit of sched_slice() as it looks it was starved.
> > > > > > > >
> > > > > > > > I think the question is why it was starved? Can you shed so=
me light Xuewen?
> > > > > > > >
> > > > > > > > My attempt to help to clarify :) I have read this just like=
 you.
> > > > > > >
> > > > > > > Thanks for Qais's clarify. And that's exactly what I want to =
say:)
> > > > > > >
> > > > > > > >
> > > > > > > > FWIW I have seen a report of something similar, but I didn'=
t managed to
> > > > > > > > reproduce and debug (mostly due to ENOBANDWIDTH); and not s=
ure if the details
> > > > > > > > are similar to what Xuewen is seeing. But there was a task =
starving for
> > > > > > > > multiple ticks - RUNNABLE but never RUNNING in spite of oth=
er tasks getting
> > > > > > > > scheduled in instead multiple times. ie: there was a task R=
UNNING for most of
> > > > > > > > the time, and I could see it preempted by other tasks multi=
ple time, but not by
> > > > > > > > the starving RUNNABLE task that is hung on the rq. It seems=
 to be vruntime
> > > > > > > > related too but speculating here.
> > > > > > >
> > > > > > > Yes, now we met the similar scenario when running a monkey te=
st on the
> > > > > > > android phone.
> > > > > > > There are multiple tasks on cpu, but the runnable task could =
not be
> > > > > > > got scheduled for a long time,
> > > > > > > there is task running and we could see the task preempted by =
other
> > > > > > > tasks multiple times.
> > > > > > > Then we dump the tasks, and find the vruntime of each task va=
ries
> > > > > > > greatly, and the task which running call the sched_yield freq=
uently.
> > > > > >
> > > > > > If I'm not wrong you are using cgroups and as a result you can'=
t
> > > > > > compare the vruntime of tasks that belongs to different group, =
you
> > > > > > must compare the vruntime of entities at the same level. We mig=
ht have
> > > > > > to look the side because I can't see why the task would not be
> > > > > > schedule if other tasks in the same group move forward their vr=
untime
> > > > >
> > > > > All the tasks belong to the same cgroup.
> > >
> > > Could they move between cpusets though?
> >
> > I have pinned them on same  CPU to force the contention
> >
> > >
> > > >
> > > > ok.
> > > > I have tried to reproduce your problem but can't see it so far. I'm
> > > > probably missing something.
> > > >
> > > > With rt-app, I start:
> > > > - 3 tasks A, B, C which are always running
> > > > - 1 task D which always runs but yields every 1ms for 1000 times an=
d
> > > > then stops yielding and always run
> > > >
> > > > All tasks are pinned on the same cpu in the same cgroup.
> > > >
> > > > I don't see anything wrong.
> > > > task A, B, C runs their slices
> > > > task D is preempted by others after 1ms for a couple of times when =
it
> > > > calls yield. Then the yield doesn't have effect and task D runs a f=
ew
> > > > consecutive ms although the yield. Then task D restart to be preemp=
ted
> > > > by others when it calls yield when its vruntime is close to others
> > > >
> > > > Once task D stop calling yield, the 4 tasks runs normally
> > >
> > > Could vruntime be inflated if a task gets stuck on a little core for =
a while
> > > (where it'll run slower) then compared to another task running on a b=
igger core
> > > the vruntime will appear smaller for the latter?
> >
> > vruntime is not scaled by cpu capacity and is "normalized" before the
> > task migrates to another cpu so there is no reason to see an impact
> > because on running on little or migrating
> >
> > >
> > >
> > > Cheers
> > >
> > > --
> > > Qais Yousef
