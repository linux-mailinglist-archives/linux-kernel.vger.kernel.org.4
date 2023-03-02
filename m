Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DE256A84B2
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 15:56:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbjCBO4b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 09:56:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbjCBO43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 09:56:29 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC521410AD
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 06:56:08 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id x20-20020a17090a8a9400b00233ba727724so3516988pjn.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 06:56:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rw0YuCQI0LwYqZstQmoIwYQVeuiEI/3y8j1+7zTbliw=;
        b=qFkiM2QAQnfuS/JiG2Ak8Q78JxbEXzkCwpYtofx3arKX+gFsqAslppnRokOJqXAIda
         QyDcmQaJudFBDu82QfBMt8VkB48KNeAUIYjXTP63H7TmlipJ6afpIRe1UW35s5LGDY7H
         xyjKKb9HfNNIjvJn4prSNpCiuPzc4Q3/OiAgpV8PimQQ58KSIRm2teGpKwzUpEKbUubJ
         ucLEmZhHUsQl/CL0vkgACPOfeb9whQDcX1LhXWJYxzjFHToi31gDdEK6hWvVkedGRyGs
         XYW9d67AofonmaxCTRy+Zkj0G5wIQy7vREPSRX8dj0QAFXx+++Hg9A7lldCncjlTDKNC
         10wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rw0YuCQI0LwYqZstQmoIwYQVeuiEI/3y8j1+7zTbliw=;
        b=4ttxGXVa2U+FqH0tFccYLsq9EMWD5bx0bEibEvRddYEbA/e1enBZOZUaM+jC1rUbLV
         Xko2Gz8sXZgHj7gBgdgJOWdEFcPZl1EDWv0FgjerTNRBjqThf6uqs8k6W96mkooIvWgk
         NAs6VMvBmuhY4C8C14ij3yqdLcKiKIQwqgNDjcyQnejC9kVFO2QpRowmcukozYcwNfXr
         O8qG6tjS9sXOvuJgGbm/0tfCRLOirQUDutbna5tASRhrADCHAxcbjPkEdDYHORJ7pDxj
         R5bBHvdrEhMlbEfoNGQAhRKKgGb/J61tHjX6/Fhy8KxoMCIpcgaE5qkhjh1EtfgVTQzr
         Rgkw==
X-Gm-Message-State: AO0yUKWQAnxVla1Mkb1IfwublAO644/yAH3QbTTS4rXr/n8NST1/AWsk
        8TIl/UuJU1mgg6sjgjkBV8lyQyJ2+yPHMqGwmdmV2n/omHRzbSsD
X-Google-Smtp-Source: AK7set9Wx7gnSqdRFcCmf8NCvbVe4vAKd5uCQqJIS2bSwpYwURPqhgGPc7EHkwLndcYRR2SlxRZkUxEITwafwyEsgnk=
X-Received: by 2002:a17:903:4291:b0:199:ab4:e140 with SMTP id
 ju17-20020a170903429100b001990ab4e140mr3775956plb.6.1677768965499; Thu, 02
 Mar 2023 06:56:05 -0800 (PST)
MIME-Version: 1.0
References: <20230209193107.1432770-1-rkagan@amazon.de> <CAKfTPtB7ZDyCh0MiNQtyimVhYJ6E3C+2bTptj9CX3+mepH8YAQ@mail.gmail.com>
 <Y/T36NvaCxSfS8Z/@u40bc5e070a0153.ant.amazon.com> <CAKfTPtCDxdVEmPQf=6g7n7Y+bkozXAJT1NG92wDc_quNaDiHMg@mail.gmail.com>
 <Y/xtDWYTKLutOqrM@u40bc5e070a0153.ant.amazon.com> <CAKfTPtAq3yBYBxpR=RO8zxrQduOymqkdAEhigjfCuGfsY1uHsg@mail.gmail.com>
 <1cd19d3f-18c4-92f9-257a-378cc18cfbc7@huawei.com> <CAKfTPtB9oYsKHLF--nVwNT5z-9tCR3bBWd8mPe4NWZ5S3y43Lg@mail.gmail.com>
 <aef87465-221b-3aff-3501-af1a516bbd98@huawei.com>
In-Reply-To: <aef87465-221b-3aff-3501-af1a516bbd98@huawei.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 2 Mar 2023 15:55:54 +0100
Message-ID: <CAKfTPtC=Y-ihdiO3ctrdsLmhMNraf6c-Ft2059T=z38kwzdJ=Q@mail.gmail.com>
Subject: Re: [PATCH v3] sched/fair: sanitize vruntime of entity being placed
To:     Zhang Qiao <zhangqiao22@huawei.com>
Cc:     Roman Kagan <rkagan@amazon.de>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org,
        Valentin Schneider <vschneid@redhat.com>,
        Ben Segall <bsegall@google.com>,
        Waiman Long <longman@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>
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

On Thu, 2 Mar 2023 at 15:29, Zhang Qiao <zhangqiao22@huawei.com> wrote:
>
>
>
> =E5=9C=A8 2023/3/2 21:34, Vincent Guittot =E5=86=99=E9=81=93:
> > On Thu, 2 Mar 2023 at 10:36, Zhang Qiao <zhangqiao22@huawei.com> wrote:
> >>
> >>
> >>
> >> =E5=9C=A8 2023/2/27 22:37, Vincent Guittot =E5=86=99=E9=81=93:
> >>> On Mon, 27 Feb 2023 at 09:43, Roman Kagan <rkagan@amazon.de> wrote:
> >>>>
> >>>> On Tue, Feb 21, 2023 at 06:26:11PM +0100, Vincent Guittot wrote:
> >>>>> On Tue, 21 Feb 2023 at 17:57, Roman Kagan <rkagan@amazon.de> wrote:
> >>>>>> What scares me, though, is that I've got a message from the test r=
obot
> >>>>>> that this commit drammatically affected hackbench results, see the=
 quote
> >>>>>> below.  I expected the commit not to affect any benchmarks.
> >>>>>>
> >>>>>> Any idea what could have caused this change?
> >>>>>
> >>>>> Hmm, It's most probably because se->exec_start is reset after a
> >>>>> migration and the condition becomes true for newly migrated task
> >>>>> whereas its vruntime should be after min_vruntime.
> >>>>>
> >>>>> We have missed this condition
> >>>>
> >>>> Makes sense to me.
> >>>>
> >>>> But what would then be the reliable way to detect a sched_entity whi=
ch
> >>>> has slept for long and risks overflowing in .vruntime comparison?
> >>>
> >>> For now I don't have a better idea than adding the same check in
> >>> migrate_task_rq_fair()
> >>
> >> Hi, Vincent=EF=BC=8C
> >> I fixed this condition as you said, and the test results are as follow=
s.
> >>
> >> testcase: hackbench -g 44 -f 20 --process --pipe -l 60000 -s 100
> >> version1: v6.2
> >> version2: v6.2 + commit 829c1651e9c4
> >> version3: v6.2 + commit 829c1651e9c4 + this patch
> >>
> >> -------------------------------------------------
> >>         version1        version2        version3
> >> test1   81.0            118.1           82.1
> >> test2   82.1            116.9           80.3
> >> test3   83.2            103.9           83.3
> >> avg(s)  82.1            113.0           81.9
> >>
> >> -------------------------------------------------
> >> After deal with the task migration case, the hackbench result has rest=
ored.
> >>
> >> The patch as follow, how does this look?
> >>
> >> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> >> index ff4dbbae3b10..3a88d20fd29e 100644
> >> --- a/kernel/sched/fair.c
> >> +++ b/kernel/sched/fair.c
> >> @@ -4648,6 +4648,26 @@ static void check_spread(struct cfs_rq *cfs_rq,=
 struct sched_entity *se)
> >>  #endif
> >>  }
> >>
> >> +static inline u64 sched_sleeper_credit(struct sched_entity *se)
> >> +{
> >> +
> >> +       unsigned long thresh;
> >> +
> >> +       if (se_is_idle(se))
> >> +               thresh =3D sysctl_sched_min_granularity;
> >> +       else
> >> +               thresh =3D sysctl_sched_latency;
> >> +
> >> +       /*
> >> +        * Halve their sleep time's effect, to allow
> >> +        * for a gentler effect of sleepers:
> >> +        */
> >> +       if (sched_feat(GENTLE_FAIR_SLEEPERS))
> >> +               thresh >>=3D 1;
> >> +
> >> +       return thresh;
> >> +}
> >> +
> >>  static void
> >>  place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int init=
ial)
> >>  {
> >> @@ -4664,23 +4684,8 @@ place_entity(struct cfs_rq *cfs_rq, struct sche=
d_entity *se, int initial)
> >>                 vruntime +=3D sched_vslice(cfs_rq, se);
> >>
> >>         /* sleeps up to a single latency don't count. */
> >> -       if (!initial) {
> >> -               unsigned long thresh;
> >> -
> >> -               if (se_is_idle(se))
> >> -                       thresh =3D sysctl_sched_min_granularity;
> >> -               else
> >> -                       thresh =3D sysctl_sched_latency;
> >> -
> >> -               /*
> >> -                * Halve their sleep time's effect, to allow
> >> -                * for a gentler effect of sleepers:
> >> -                */
> >> -               if (sched_feat(GENTLE_FAIR_SLEEPERS))
> >> -                       thresh >>=3D 1;
> >> -
> >> -               vruntime -=3D thresh;
> >> -       }
> >> +       if (!initial)
> >> +               vruntime -=3D sched_sleeper_credit(se);
> >>
> >>         /*
> >>          * Pull vruntime of the entity being placed to the base level =
of
> >> @@ -4690,7 +4695,7 @@ place_entity(struct cfs_rq *cfs_rq, struct sched=
_entity *se, int initial)
> >>          * inversed due to s64 overflow.
> >>          */
> >>         sleep_time =3D rq_clock_task(rq_of(cfs_rq)) - se->exec_start;
> >> -       if ((s64)sleep_time > 60LL * NSEC_PER_SEC)
> >> +       if (se->exec_start !=3D 0 && (s64)sleep_time > 60LL * NSEC_PER=
_SEC)
> >>                 se->vruntime =3D vruntime;
> >>         else
> >>                 se->vruntime =3D max_vruntime(se->vruntime, vruntime);
> >> @@ -7634,8 +7639,12 @@ static void migrate_task_rq_fair(struct task_st=
ruct *p, int new_cpu)
> >>          */
> >>         if (READ_ONCE(p->__state) =3D=3D TASK_WAKING) {
> >>                 struct cfs_rq *cfs_rq =3D cfs_rq_of(se);
> >> +               u64 sleep_time =3D rq_clock_task(rq_of(cfs_rq)) - se->=
exec_start;
> >>
> >> -               se->vruntime -=3D u64_u32_load(cfs_rq->min_vruntime);
> >> +               if ((s64)sleep_time > 60LL * NSEC_PER_SEC)
> >
> > You also need to test (se->exec_start !=3D0) here because the task migh=
t
>
> Hi,
>
> I don't understand when the another migration happend. Could you tell me =
in more detail?

se->exec_start is update when the task becomes current.

You can have the sequence:

task TA runs on CPU0
    TA's se->exec_start =3D xxxx
TA is put back into the rb tree waiting for next slice while another
task is running
CPU1 pulls TA which migrates on CPU1
    migrate_task_rq_fair() w/ TA's se->exec_start =3D=3D xxxx
        TA's se->exec_start =3D 0
TA is put into the rb tree of CPU1 waiting to run on CPU1
CPU2 pulls TA which migrates on CPU2
    migrate_task_rq_fair() w/ TA's se->exec_start =3D=3D 0
        TA's se->exec_start =3D 0

>
> I think the next migration will happend after the wakee task enqueued, bu=
t at this time
> the p->__state isn't TASK_WAKING, p->__state already be changed to TASK_R=
UNNING at ttwu_do_wakeup().
>
> If such a migration exists, Previous code "se->vruntime -=3D u64_u32_load=
(cfs_rq->min_vruntime);" maybe
> perform multiple times=EF=BC=8Cwouldn't it go wrong in this way?

the vruntime have been updated when enqueued but not exec_start

>
> > migrate another time before being scheduled. You should create a
> > helper function like below and use it in both place
>
> Ok, I will update at next version.
>
>
> Thanks,
> ZhangQiao.
>
> >
> > static inline bool entity_long_sleep(se)
> > {
> >         struct cfs_rq *cfs_rq;
> >         u64 sleep_time;
> >
> >         if (se->exec_start =3D=3D 0)
> >                 return false;
> >
> >         cfs_rq =3D cfs_rq_of(se);
> >         sleep_time =3D rq_clock_task(rq_of(cfs_rq)) - se->exec_start;
> >         if ((s64)sleep_time > 60LL * NSEC_PER_SEC)
> >                 return true;
> >
> >         return false;
> > }
> >
> >
> >> +                       se->vruntime =3D -sched_sleeper_credit(se);
> >> +               else
> >> +                       se->vruntime -=3D u64_u32_load(cfs_rq->min_vru=
ntime);
> >>         }
> >>
> >>         if (!task_on_rq_migrating(p)) {
> >>
> >>
> >>
> >> Thanks.
> >> Zhang Qiao.
> >>
> >>>
> >>>>
> >>>> Thanks,
> >>>> Roman.
> >>>>
> >>>>
> >>>>
> >>>> Amazon Development Center Germany GmbH
> >>>> Krausenstr. 38
> >>>> 10117 Berlin
> >>>> Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
> >>>> Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
> >>>> Sitz: Berlin
> >>>> Ust-ID: DE 289 237 879
> >>>>
> >>>>
> >>>>
> >>> .
> >>>
> > .
> >
