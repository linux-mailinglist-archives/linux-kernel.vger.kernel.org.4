Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AC5A6A68D0
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 09:20:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbjCAIUj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 03:20:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjCAIUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 03:20:38 -0500
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF3892718
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 00:20:36 -0800 (PST)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-173435e0ec4so3431336fac.12
        for <linux-kernel@vger.kernel.org>; Wed, 01 Mar 2023 00:20:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677658835;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jEXMulDA6uXKXYqrdtXFkNi2DWjA6PBhpB+5Sr4vMX0=;
        b=Gs0jdJ5Uf6aNk2LsJoNIfMmt0sQuhNTbeixHcDAsSRrPYifSoUo1i++yBxvPeLbV9l
         H92eC2N879lkIHiRCzNi8l/mtmBrQ+JhtxhH/20aiDSBwenyHPTZ/9TjELpU820j33U0
         MZwtURRo5cIfCebgVDbq0Qodp6V+vTBYN4IyT1Fl4PLWgHkb7PqvtKidjNseW86NHniS
         BXaT67RQehysOIaNsr84WWSQlfhf6/cA6WKnOg65OVJeUdxjqUprRtpiZ3PSKeunCEnA
         NYBgjumuxBXA8/8ME5nfE5IBgbF5uTlXK1WROgEAkbyMXtXRxQ6B01IY6yoIc+Wbf+o4
         p6IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677658835;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jEXMulDA6uXKXYqrdtXFkNi2DWjA6PBhpB+5Sr4vMX0=;
        b=kNEQichtkyZzdPqcmC2FNyvbJM57S2zuPdaIF9dZwLtkZD+OimE59s10XouhPwPMrc
         Wru38m+wgk4dXI1UUsVExiBKGro5eFxVqmqCq/bVpKNB8LzEmGojBAFnNnUK9E3jQ+uw
         fYSV8mS6/NTTXv7eKHAV4WzSzgSsG/xH2kWlmZY/PmVmCX2TVbxXQoBrPVMIFPROID0X
         QxA18gq4YCJOkx2GOO/sHfc1lpX97+jCD5TtzisBfP6nHE11GivsTGJQZAG5NdKeugNW
         /agH3ux0/TaPSL93w+Ey4Kdflx2u8ZJUjxUJkTMHuCDiEWWdlOk42Hf5kMs9LWR6T1i0
         ineA==
X-Gm-Message-State: AO0yUKUJwboAeM4fBPpIbBJ2tAJKpSzkRPlYe2H9a/33zp5hQ47dnemp
        E+TK2kglkDaYVZ32bH0wwGpQSs1PuhKMV3avYgE=
X-Google-Smtp-Source: AK7set9fOC3B3I41qbHKICP9uTV0qWv1hRrR0tmKTimGwSk0icn6kvewbc9054sjkDL58oOEbYAFuqtCgvWnprC41u4=
X-Received: by 2002:a05:6870:1a82:b0:176:2299:dcd0 with SMTP id
 ef2-20020a0568701a8200b001762299dcd0mr443672oab.6.1677658834874; Wed, 01 Mar
 2023 00:20:34 -0800 (PST)
MIME-Version: 1.0
References: <20230222080314.2146-1-xuewen.yan@unisoc.com> <Y/zO8WZV2kvcU78b@hirez.programming.kicks-ass.net>
 <20230227220735.3kaytmtt53uoegq7@airbuntu> <CAB8ipk--trBk-Acsjz7YDb5szPLc93ejPXVXQBJdomZO4OrpGQ@mail.gmail.com>
 <CAKfTPtBdMO6_APib1OBxW+fdAORX8vXdT-W3fWTRffa5-8bGxQ@mail.gmail.com>
 <CAB8ipk96OXJcmp_H5EcagrMUigSFdW_gd4wwGjfjBpyP6hqaTg@mail.gmail.com>
 <CAKfTPtAvuz0SEDX3izcOhZkC+pFddqrSwY+iYO2p7U6N3Z2hRA@mail.gmail.com>
 <20230228133111.6i5tlhvthnfljvmf@airbuntu> <CAKfTPtAsxz7s6W2peoVj+EcNVQp6bpO6qhPPTXgfJxVtXHbaKQ@mail.gmail.com>
 <CAB8ipk83Ofywn0T19dHxjJNXfKcd9DD_EopQupeepjSk-XceRQ@mail.gmail.com> <CAKfTPtDfSHnd7=ZG2S-x46kxw0Cc0RSXq+_B8Oe46fa3Fa75BA@mail.gmail.com>
In-Reply-To: <CAKfTPtDfSHnd7=ZG2S-x46kxw0Cc0RSXq+_B8Oe46fa3Fa75BA@mail.gmail.com>
From:   Xuewen Yan <xuewen.yan94@gmail.com>
Date:   Wed, 1 Mar 2023 16:20:23 +0800
Message-ID: <CAB8ipk9uPMxwEUHkLWbKXQEO1UkwBPWbZb=NF7AE5JHnG8V6Dw@mail.gmail.com>
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

On Wed, Mar 1, 2023 at 4:09=E2=80=AFPM Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> On Wed, 1 Mar 2023 at 08:30, Xuewen Yan <xuewen.yan94@gmail.com> wrote:
> >
> > Hi Vincent
> >
> > I noticed the following patch:
> > https://lore.kernel.org/lkml/20230209193107.1432770-1-rkagan@amazon.de/
> > And I notice the V2 had merged to mainline:
> > https://lore.kernel.org/all/20230130122216.3555094-1-rkagan@amazon.de/T=
/#u
> >
> > The patch fixed the inversing of the vruntime comparison, and I see
> > that in my case, there also are some vruntime is inverted.
> > Do you think which patch will work for our scenario? I would be very
> > grateful if you could give us some advice.
> > I would try this patch in our tree.
>
> By default use the one that is merged; The difference is mainly a
> matter of time range. Also be aware that the case of newly migrated
> task is not fully covered by both patches.

Okay, Thank you very much!

>
> This patch fixes a problem with long sleeping entity in the presence
> of low weight and always running entities. This doesn't seem to be
> aligned with the description of your use case

Thanks for the clarification! We would try it first to see whether it
could resolve our problem.

Thanks!
BR
---
xuewen

>
> Vincent
> >
> > Thanks=EF=BC=81
> > BR
> >
> > On Tue, Feb 28, 2023 at 9:45=E2=80=AFPM Vincent Guittot
> > <vincent.guittot@linaro.org> wrote:
> > >
> > > On Tue, 28 Feb 2023 at 14:31, Qais Yousef <qyousef@layalina.io> wrote=
:
> > > >
> > > > On 02/28/23 10:07, Vincent Guittot wrote:
> > > > > On Tue, 28 Feb 2023 at 09:21, Xuewen Yan <xuewen.yan94@gmail.com>=
 wrote:
> > > > > >
> > > > > > Hi Vincent
> > > > > >
> > > > > > On Tue, Feb 28, 2023 at 3:53=E2=80=AFPM Vincent Guittot
> > > > > > <vincent.guittot@linaro.org> wrote:
> > > > > > >
> > > > > > > On Tue, 28 Feb 2023 at 08:42, Xuewen Yan <xuewen.yan94@gmail.=
com> wrote:
> > > > > > > >
> > > > > > > > Hi
> > > > > > > >
> > > > > > > > Thanks very much for comments!
> > > > > > > >
> > > > > > > > On Tue, Feb 28, 2023 at 6:33=E2=80=AFAM Qais Yousef <qyouse=
f@layalina.io> wrote:
> > > > > > > > >
> > > > > > > > > On 02/27/23 16:40, Peter Zijlstra wrote:
> > > > > > > > > > On Wed, Feb 22, 2023 at 04:03:14PM +0800, Xuewen Yan wr=
ote:
> > > > > > > > > > > When task call the sched_yield, cfs would set the cfs=
's skip buddy.
> > > > > > > > > > > If there is no other task call the sched_yield syscal=
l, the task would
> > > > > > > > > > > always be skiped when there are tasks in rq.
> > > > > > > > > >
> > > > > > > > > > So you have two tasks A) which does sched_yield() and b=
ecomes ->skip,
> > > > > > > > > > and B) which is while(1). And you're saying that once A=
 does it's thing,
> > > > > > > > > > B runs forever and starves A?
> > > > > > > > >
> > > > > > > > > I read it differently.
> > > > > > > > >
> > > > > > > > > I understood that there are multiple tasks.
> > > > > > > > >
> > > > > > > > > If Task A becomes ->skip; then it seems other tasks will =
continue to be picked
> > > > > > > > > instead. Until another task B calls sched_yield() and bec=
ome ->skip, then Task
> > > > > > > > > A is picked but with wrong vruntime causing it to run for=
 multiple ticks (my
> > > > > > > > > interpretation of 'always run' below).
> > > > > > > > >
> > > > > > > > > There are no while(1) task running IIUC.
> > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > > As a result, the task's
> > > > > > > > > > > vruntime would not be updated for long time, and the =
cfs's min_vruntime
> > > > > > > > > > > is almost not updated.
> > > > > > > > > >
> > > > > > > > > > But the condition in pick_next_entity() should ensure t=
hat we still pick
> > > > > > > > > > ->skip when it becomes too old. Specifically, when it g=
ets more than
> > > > > > > > > > wakeup_gran() behind.
> > > > > > > > >
> > > > > > > > > I am not sure I can see it either. Maybe __pick_first_ent=
ity() doesn't return
> > > > > > > > > the skipped one, or for some reason vdiff for second is a=
lmost always
> > > > > > > > > < wakeup_gran()?
> > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > > When this scenario happens, when the yield task had w=
ait for a long time,
> > > > > > > > > > > and other tasks run a long time, once there is other =
task call the sched_yield,
> > > > > > > > > > > the cfs's skip_buddy is covered, at this time, the fi=
rst task can run normally,
> > > > > > > > > > > but the task's vruntime is small, as a result, the ta=
sk would always run,
> > > > > > > > > > > because other task's vruntime is big. This would lead=
 to other tasks can not
> > > > > > > > > > > run for a long time.
> > > > > > > > >
> > > > > > > > > The error seems that when Task A finally runs - it consum=
es more than its fair
> > > > > > > > > bit of sched_slice() as it looks it was starved.
> > > > > > > > >
> > > > > > > > > I think the question is why it was starved? Can you shed =
some light Xuewen?
> > > > > > > > >
> > > > > > > > > My attempt to help to clarify :) I have read this just li=
ke you.
> > > > > > > >
> > > > > > > > Thanks for Qais's clarify. And that's exactly what I want t=
o say:)
> > > > > > > >
> > > > > > > > >
> > > > > > > > > FWIW I have seen a report of something similar, but I did=
n't managed to
> > > > > > > > > reproduce and debug (mostly due to ENOBANDWIDTH); and not=
 sure if the details
> > > > > > > > > are similar to what Xuewen is seeing. But there was a tas=
k starving for
> > > > > > > > > multiple ticks - RUNNABLE but never RUNNING in spite of o=
ther tasks getting
> > > > > > > > > scheduled in instead multiple times. ie: there was a task=
 RUNNING for most of
> > > > > > > > > the time, and I could see it preempted by other tasks mul=
tiple time, but not by
> > > > > > > > > the starving RUNNABLE task that is hung on the rq. It see=
ms to be vruntime
> > > > > > > > > related too but speculating here.
> > > > > > > >
> > > > > > > > Yes, now we met the similar scenario when running a monkey =
test on the
> > > > > > > > android phone.
> > > > > > > > There are multiple tasks on cpu, but the runnable task coul=
d not be
> > > > > > > > got scheduled for a long time,
> > > > > > > > there is task running and we could see the task preempted b=
y other
> > > > > > > > tasks multiple times.
> > > > > > > > Then we dump the tasks, and find the vruntime of each task =
varies
> > > > > > > > greatly, and the task which running call the sched_yield fr=
equently.
> > > > > > >
> > > > > > > If I'm not wrong you are using cgroups and as a result you ca=
n't
> > > > > > > compare the vruntime of tasks that belongs to different group=
, you
> > > > > > > must compare the vruntime of entities at the same level. We m=
ight have
> > > > > > > to look the side because I can't see why the task would not b=
e
> > > > > > > schedule if other tasks in the same group move forward their =
vruntime
> > > > > >
> > > > > > All the tasks belong to the same cgroup.
> > > >
> > > > Could they move between cpusets though?
> > >
> > > I have pinned them on same  CPU to force the contention
> > >
> > > >
> > > > >
> > > > > ok.
> > > > > I have tried to reproduce your problem but can't see it so far. I=
'm
> > > > > probably missing something.
> > > > >
> > > > > With rt-app, I start:
> > > > > - 3 tasks A, B, C which are always running
> > > > > - 1 task D which always runs but yields every 1ms for 1000 times =
and
> > > > > then stops yielding and always run
> > > > >
> > > > > All tasks are pinned on the same cpu in the same cgroup.
> > > > >
> > > > > I don't see anything wrong.
> > > > > task A, B, C runs their slices
> > > > > task D is preempted by others after 1ms for a couple of times whe=
n it
> > > > > calls yield. Then the yield doesn't have effect and task D runs a=
 few
> > > > > consecutive ms although the yield. Then task D restart to be pree=
mpted
> > > > > by others when it calls yield when its vruntime is close to other=
s
> > > > >
> > > > > Once task D stop calling yield, the 4 tasks runs normally
> > > >
> > > > Could vruntime be inflated if a task gets stuck on a little core fo=
r a while
> > > > (where it'll run slower) then compared to another task running on a=
 bigger core
> > > > the vruntime will appear smaller for the latter?
> > >
> > > vruntime is not scaled by cpu capacity and is "normalized" before the
> > > task migrates to another cpu so there is no reason to see an impact
> > > because on running on little or migrating
> > >
> > > >
> > > >
> > > > Cheers
> > > >
> > > > --
> > > > Qais Yousef
