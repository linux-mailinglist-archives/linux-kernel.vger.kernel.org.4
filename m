Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C4516A681D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 08:30:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbjCAHav (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 02:30:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjCAHat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 02:30:49 -0500
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9540C31E26
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 23:30:47 -0800 (PST)
Received: by mail-ot1-x331.google.com with SMTP id o4-20020a9d6d04000000b00694127788f4so3164625otp.6
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 23:30:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677655847;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sUw2uYgvHbSiJ0ZW177+pyfUECNUto1D0K9gERazYrI=;
        b=n9Il4VAo4QL4gh1bdSDgP9OzmGdmxGkvnYzSboPBKx192aTtGfh9wHIxL2E9JTVyJQ
         Mh29sur6zZqfH6ycpYjOrw3nFw2bsnqIqpynv+cujPyCyn0k2/QlrwgRrecakxYYIX7j
         U8BNzDr31hpoF/DfjMC4qhKIoYIYmsjME90HbwbvamJpwLuAetEB9omVRUNtCngccbIT
         TetcptbULFsJzlm9sDysrdpLs+GkhYQBsPoivqwDmJtgsM3ck5BwnKuh3FOWxqenzTbF
         EmU08N0oChB81cO03lelflnFq2JC7b3DHSCXrtAXvtNE2wyx0JpPWlFbJp4ORe2pMBWU
         MUCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677655847;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sUw2uYgvHbSiJ0ZW177+pyfUECNUto1D0K9gERazYrI=;
        b=H9DgFf52AssUh0rwDukbW3Ktc1pWySjHD3uom2niMVouAF1SG/IL2NIj3jYhEPx2Ip
         kgnTr/bySs9jd7fdzepTnr6cE8V+/1eDUJ4C370xV5XGkOHzUGPKNSv7gnYYJFhvmBfJ
         VfanYktMefin188zyTn+COXibFmCtxHqc/wGmbA7QeD5jefulZ1KQrsM0/cn97wZ/0H2
         RH4J6PxRDiXCP02mviADtDpMJMVbWg1SyZozdYBp8+WjnApQeQEr0YIIrpFrcvEIigSu
         D0jiCPJfJtIHJkgwo+t7VAuupjzmNZ9RfLZni5e3yHdu6poWnmMVeHJyiUx0U9PSv+HU
         a+rA==
X-Gm-Message-State: AO0yUKW0AM6rnDRChypd+elLaUuRTyjDQwLb5yP/WG8WrbkewXR3AGS3
        NS/ClOra0BAf+lyT+4Ws880sVlx4n+9vf6Qy5qE=
X-Google-Smtp-Source: AK7set+Qll6Dh3MAz+FJt0KDDTxMwjX2lcdW06t9rRVB8bFUjVZZGtzAIho9vWD/QPFOab/4BKoSixtt5Itt8pKALPI=
X-Received: by 2002:a9d:454a:0:b0:68b:8067:b5d4 with SMTP id
 p10-20020a9d454a000000b0068b8067b5d4mr1937239oti.3.1677655846762; Tue, 28 Feb
 2023 23:30:46 -0800 (PST)
MIME-Version: 1.0
References: <20230222080314.2146-1-xuewen.yan@unisoc.com> <Y/zO8WZV2kvcU78b@hirez.programming.kicks-ass.net>
 <20230227220735.3kaytmtt53uoegq7@airbuntu> <CAB8ipk--trBk-Acsjz7YDb5szPLc93ejPXVXQBJdomZO4OrpGQ@mail.gmail.com>
 <CAKfTPtBdMO6_APib1OBxW+fdAORX8vXdT-W3fWTRffa5-8bGxQ@mail.gmail.com>
 <CAB8ipk96OXJcmp_H5EcagrMUigSFdW_gd4wwGjfjBpyP6hqaTg@mail.gmail.com>
 <CAKfTPtAvuz0SEDX3izcOhZkC+pFddqrSwY+iYO2p7U6N3Z2hRA@mail.gmail.com>
 <20230228133111.6i5tlhvthnfljvmf@airbuntu> <CAKfTPtAsxz7s6W2peoVj+EcNVQp6bpO6qhPPTXgfJxVtXHbaKQ@mail.gmail.com>
In-Reply-To: <CAKfTPtAsxz7s6W2peoVj+EcNVQp6bpO6qhPPTXgfJxVtXHbaKQ@mail.gmail.com>
From:   Xuewen Yan <xuewen.yan94@gmail.com>
Date:   Wed, 1 Mar 2023 15:30:35 +0800
Message-ID: <CAB8ipk83Ofywn0T19dHxjJNXfKcd9DD_EopQupeepjSk-XceRQ@mail.gmail.com>
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

I noticed the following patch:
https://lore.kernel.org/lkml/20230209193107.1432770-1-rkagan@amazon.de/
And I notice the V2 had merged to mainline:
https://lore.kernel.org/all/20230130122216.3555094-1-rkagan@amazon.de/T/#u

The patch fixed the inversing of the vruntime comparison, and I see
that in my case, there also are some vruntime is inverted.
Do you think which patch will work for our scenario? I would be very
grateful if you could give us some advice.
I would try this patch in our tree.

Thanks=EF=BC=81
BR

On Tue, Feb 28, 2023 at 9:45=E2=80=AFPM Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> On Tue, 28 Feb 2023 at 14:31, Qais Yousef <qyousef@layalina.io> wrote:
> >
> > On 02/28/23 10:07, Vincent Guittot wrote:
> > > On Tue, 28 Feb 2023 at 09:21, Xuewen Yan <xuewen.yan94@gmail.com> wro=
te:
> > > >
> > > > Hi Vincent
> > > >
> > > > On Tue, Feb 28, 2023 at 3:53=E2=80=AFPM Vincent Guittot
> > > > <vincent.guittot@linaro.org> wrote:
> > > > >
> > > > > On Tue, 28 Feb 2023 at 08:42, Xuewen Yan <xuewen.yan94@gmail.com>=
 wrote:
> > > > > >
> > > > > > Hi
> > > > > >
> > > > > > Thanks very much for comments!
> > > > > >
> > > > > > On Tue, Feb 28, 2023 at 6:33=E2=80=AFAM Qais Yousef <qyousef@la=
yalina.io> wrote:
> > > > > > >
> > > > > > > On 02/27/23 16:40, Peter Zijlstra wrote:
> > > > > > > > On Wed, Feb 22, 2023 at 04:03:14PM +0800, Xuewen Yan wrote:
> > > > > > > > > When task call the sched_yield, cfs would set the cfs's s=
kip buddy.
> > > > > > > > > If there is no other task call the sched_yield syscall, t=
he task would
> > > > > > > > > always be skiped when there are tasks in rq.
> > > > > > > >
> > > > > > > > So you have two tasks A) which does sched_yield() and becom=
es ->skip,
> > > > > > > > and B) which is while(1). And you're saying that once A doe=
s it's thing,
> > > > > > > > B runs forever and starves A?
> > > > > > >
> > > > > > > I read it differently.
> > > > > > >
> > > > > > > I understood that there are multiple tasks.
> > > > > > >
> > > > > > > If Task A becomes ->skip; then it seems other tasks will cont=
inue to be picked
> > > > > > > instead. Until another task B calls sched_yield() and become =
->skip, then Task
> > > > > > > A is picked but with wrong vruntime causing it to run for mul=
tiple ticks (my
> > > > > > > interpretation of 'always run' below).
> > > > > > >
> > > > > > > There are no while(1) task running IIUC.
> > > > > > >
> > > > > > > >
> > > > > > > > > As a result, the task's
> > > > > > > > > vruntime would not be updated for long time, and the cfs'=
s min_vruntime
> > > > > > > > > is almost not updated.
> > > > > > > >
> > > > > > > > But the condition in pick_next_entity() should ensure that =
we still pick
> > > > > > > > ->skip when it becomes too old. Specifically, when it gets =
more than
> > > > > > > > wakeup_gran() behind.
> > > > > > >
> > > > > > > I am not sure I can see it either. Maybe __pick_first_entity(=
) doesn't return
> > > > > > > the skipped one, or for some reason vdiff for second is almos=
t always
> > > > > > > < wakeup_gran()?
> > > > > > >
> > > > > > > >
> > > > > > > > > When this scenario happens, when the yield task had wait =
for a long time,
> > > > > > > > > and other tasks run a long time, once there is other task=
 call the sched_yield,
> > > > > > > > > the cfs's skip_buddy is covered, at this time, the first =
task can run normally,
> > > > > > > > > but the task's vruntime is small, as a result, the task w=
ould always run,
> > > > > > > > > because other task's vruntime is big. This would lead to =
other tasks can not
> > > > > > > > > run for a long time.
> > > > > > >
> > > > > > > The error seems that when Task A finally runs - it consumes m=
ore than its fair
> > > > > > > bit of sched_slice() as it looks it was starved.
> > > > > > >
> > > > > > > I think the question is why it was starved? Can you shed some=
 light Xuewen?
> > > > > > >
> > > > > > > My attempt to help to clarify :) I have read this just like y=
ou.
> > > > > >
> > > > > > Thanks for Qais's clarify. And that's exactly what I want to sa=
y:)
> > > > > >
> > > > > > >
> > > > > > > FWIW I have seen a report of something similar, but I didn't =
managed to
> > > > > > > reproduce and debug (mostly due to ENOBANDWIDTH); and not sur=
e if the details
> > > > > > > are similar to what Xuewen is seeing. But there was a task st=
arving for
> > > > > > > multiple ticks - RUNNABLE but never RUNNING in spite of other=
 tasks getting
> > > > > > > scheduled in instead multiple times. ie: there was a task RUN=
NING for most of
> > > > > > > the time, and I could see it preempted by other tasks multipl=
e time, but not by
> > > > > > > the starving RUNNABLE task that is hung on the rq. It seems t=
o be vruntime
> > > > > > > related too but speculating here.
> > > > > >
> > > > > > Yes, now we met the similar scenario when running a monkey test=
 on the
> > > > > > android phone.
> > > > > > There are multiple tasks on cpu, but the runnable task could no=
t be
> > > > > > got scheduled for a long time,
> > > > > > there is task running and we could see the task preempted by ot=
her
> > > > > > tasks multiple times.
> > > > > > Then we dump the tasks, and find the vruntime of each task vari=
es
> > > > > > greatly, and the task which running call the sched_yield freque=
ntly.
> > > > >
> > > > > If I'm not wrong you are using cgroups and as a result you can't
> > > > > compare the vruntime of tasks that belongs to different group, yo=
u
> > > > > must compare the vruntime of entities at the same level. We might=
 have
> > > > > to look the side because I can't see why the task would not be
> > > > > schedule if other tasks in the same group move forward their vrun=
time
> > > >
> > > > All the tasks belong to the same cgroup.
> >
> > Could they move between cpusets though?
>
> I have pinned them on same  CPU to force the contention
>
> >
> > >
> > > ok.
> > > I have tried to reproduce your problem but can't see it so far. I'm
> > > probably missing something.
> > >
> > > With rt-app, I start:
> > > - 3 tasks A, B, C which are always running
> > > - 1 task D which always runs but yields every 1ms for 1000 times and
> > > then stops yielding and always run
> > >
> > > All tasks are pinned on the same cpu in the same cgroup.
> > >
> > > I don't see anything wrong.
> > > task A, B, C runs their slices
> > > task D is preempted by others after 1ms for a couple of times when it
> > > calls yield. Then the yield doesn't have effect and task D runs a few
> > > consecutive ms although the yield. Then task D restart to be preempte=
d
> > > by others when it calls yield when its vruntime is close to others
> > >
> > > Once task D stop calling yield, the 4 tasks runs normally
> >
> > Could vruntime be inflated if a task gets stuck on a little core for a =
while
> > (where it'll run slower) then compared to another task running on a big=
ger core
> > the vruntime will appear smaller for the latter?
>
> vruntime is not scaled by cpu capacity and is "normalized" before the
> task migrates to another cpu so there is no reason to see an impact
> because on running on little or migrating
>
> >
> >
> > Cheers
> >
> > --
> > Qais Yousef
