Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 969656A5A00
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 14:31:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbjB1NbT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 08:31:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjB1NbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 08:31:17 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E81B1A652
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 05:31:15 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id k37so6448868wms.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 05:31:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=w5pWc3i7OPauASDxawP2MUAYnKLzOrAWTWv95Eo1ry0=;
        b=rL58Ganwg5tul3r7Nv1rFgyq2Hqcs08+Fca/SKeQlwthet5ptoFPrjlK06ZmG0tJKq
         WC9N1etLH7SA0xQakhN0V2xtqlx0Zi0shQEFINXs5Q3U+TiDvL1YqF4rAAdIseoIJkf0
         4fMKqdH7mGT3nXBlT1tgshT+s3Q7o7AEmf6uoq2kOvIRm+HlS4M9GZomqvDVQxPNnaBw
         NpTb+NISnXAqqd6qOQbf6zCMLTVZg2gw7X7WcFG5es5UJUQ8k2ZwqlFnUxqUID5aJeuS
         TUHDHCHKunTxWFGOZ9LeMlgfHWKJLx0evVoYFVXT2FDvdtNyuylsbxb8xdHUFSjvU5bE
         FYlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w5pWc3i7OPauASDxawP2MUAYnKLzOrAWTWv95Eo1ry0=;
        b=UPzSE7JL9V301nlu9sJ48tmO+tRB915VUnRGNf8bHB2eD8M0nWvmvcXDmiJaFGAh/9
         R+G2MJ1J8Y2ltwBswkN8732fHZcvnxtJfTff91tRmluqDbIM9u0VaNdty0tPyKuOW4DV
         E6rWxiSXEUw/EsYIvw4mJgnW4IejpkVLn76gXPvrbUGqcWwXSjW23GayAZQJi0RUyXHx
         L/34APQlNmI4lXY+l+s+ATekRkmvYyUPOhdKYFytRhOpfpBLuvkcGfsPAA/W1s0ioF1o
         pIWW8NrakeDbXws85azVTkcuZjjQYs46buDZYOLsYorM6zTzdJyw67OKI0Tw+eATKknR
         DlIA==
X-Gm-Message-State: AO0yUKWJNfwiVG8wlbRgj6RwWt84rjpPdHBLtWSe3eyiKMWYcfIPetAJ
        V8eVJbflTwi4MKJZIV59zz0NNg==
X-Google-Smtp-Source: AK7set/JKNAxnx+6ISVpZOPoLKeFSITLu4ROZNW+NFSnrMtG8ULTDafxLv2ZKZew3PyXDc57iVubcw==
X-Received: by 2002:a05:600c:1d1d:b0:3df:db20:b0ae with SMTP id l29-20020a05600c1d1d00b003dfdb20b0aemr2372690wms.17.1677591074091;
        Tue, 28 Feb 2023 05:31:14 -0800 (PST)
Received: from airbuntu ([104.132.45.107])
        by smtp.gmail.com with ESMTPSA id j8-20020a056000124800b002c71d206329sm9761709wrx.55.2023.02.28.05.31.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 05:31:12 -0800 (PST)
Date:   Tue, 28 Feb 2023 13:31:11 +0000
From:   Qais Yousef <qyousef@layalina.io>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Xuewen Yan <xuewen.yan94@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Xuewen Yan <xuewen.yan@unisoc.com>, mingo@redhat.com,
        juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, ke.wang@unisoc.com,
        zhaoyang.huang@unisoc.com
Subject: Re: [RFC PATCH] sched/fair: update the vruntime to be max vruntime
 when yield
Message-ID: <20230228133111.6i5tlhvthnfljvmf@airbuntu>
References: <20230222080314.2146-1-xuewen.yan@unisoc.com>
 <Y/zO8WZV2kvcU78b@hirez.programming.kicks-ass.net>
 <20230227220735.3kaytmtt53uoegq7@airbuntu>
 <CAB8ipk--trBk-Acsjz7YDb5szPLc93ejPXVXQBJdomZO4OrpGQ@mail.gmail.com>
 <CAKfTPtBdMO6_APib1OBxW+fdAORX8vXdT-W3fWTRffa5-8bGxQ@mail.gmail.com>
 <CAB8ipk96OXJcmp_H5EcagrMUigSFdW_gd4wwGjfjBpyP6hqaTg@mail.gmail.com>
 <CAKfTPtAvuz0SEDX3izcOhZkC+pFddqrSwY+iYO2p7U6N3Z2hRA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKfTPtAvuz0SEDX3izcOhZkC+pFddqrSwY+iYO2p7U6N3Z2hRA@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/28/23 10:07, Vincent Guittot wrote:
> On Tue, 28 Feb 2023 at 09:21, Xuewen Yan <xuewen.yan94@gmail.com> wrote:
> >
> > Hi Vincent
> >
> > On Tue, Feb 28, 2023 at 3:53 PM Vincent Guittot
> > <vincent.guittot@linaro.org> wrote:
> > >
> > > On Tue, 28 Feb 2023 at 08:42, Xuewen Yan <xuewen.yan94@gmail.com> wrote:
> > > >
> > > > Hi
> > > >
> > > > Thanks very much for comments!
> > > >
> > > > On Tue, Feb 28, 2023 at 6:33 AM Qais Yousef <qyousef@layalina.io> wrote:
> > > > >
> > > > > On 02/27/23 16:40, Peter Zijlstra wrote:
> > > > > > On Wed, Feb 22, 2023 at 04:03:14PM +0800, Xuewen Yan wrote:
> > > > > > > When task call the sched_yield, cfs would set the cfs's skip buddy.
> > > > > > > If there is no other task call the sched_yield syscall, the task would
> > > > > > > always be skiped when there are tasks in rq.
> > > > > >
> > > > > > So you have two tasks A) which does sched_yield() and becomes ->skip,
> > > > > > and B) which is while(1). And you're saying that once A does it's thing,
> > > > > > B runs forever and starves A?
> > > > >
> > > > > I read it differently.
> > > > >
> > > > > I understood that there are multiple tasks.
> > > > >
> > > > > If Task A becomes ->skip; then it seems other tasks will continue to be picked
> > > > > instead. Until another task B calls sched_yield() and become ->skip, then Task
> > > > > A is picked but with wrong vruntime causing it to run for multiple ticks (my
> > > > > interpretation of 'always run' below).
> > > > >
> > > > > There are no while(1) task running IIUC.
> > > > >
> > > > > >
> > > > > > > As a result, the task's
> > > > > > > vruntime would not be updated for long time, and the cfs's min_vruntime
> > > > > > > is almost not updated.
> > > > > >
> > > > > > But the condition in pick_next_entity() should ensure that we still pick
> > > > > > ->skip when it becomes too old. Specifically, when it gets more than
> > > > > > wakeup_gran() behind.
> > > > >
> > > > > I am not sure I can see it either. Maybe __pick_first_entity() doesn't return
> > > > > the skipped one, or for some reason vdiff for second is almost always
> > > > > < wakeup_gran()?
> > > > >
> > > > > >
> > > > > > > When this scenario happens, when the yield task had wait for a long time,
> > > > > > > and other tasks run a long time, once there is other task call the sched_yield,
> > > > > > > the cfs's skip_buddy is covered, at this time, the first task can run normally,
> > > > > > > but the task's vruntime is small, as a result, the task would always run,
> > > > > > > because other task's vruntime is big. This would lead to other tasks can not
> > > > > > > run for a long time.
> > > > >
> > > > > The error seems that when Task A finally runs - it consumes more than its fair
> > > > > bit of sched_slice() as it looks it was starved.
> > > > >
> > > > > I think the question is why it was starved? Can you shed some light Xuewen?
> > > > >
> > > > > My attempt to help to clarify :) I have read this just like you.
> > > >
> > > > Thanks for Qais's clarify. And that's exactly what I want to say:)
> > > >
> > > > >
> > > > > FWIW I have seen a report of something similar, but I didn't managed to
> > > > > reproduce and debug (mostly due to ENOBANDWIDTH); and not sure if the details
> > > > > are similar to what Xuewen is seeing. But there was a task starving for
> > > > > multiple ticks - RUNNABLE but never RUNNING in spite of other tasks getting
> > > > > scheduled in instead multiple times. ie: there was a task RUNNING for most of
> > > > > the time, and I could see it preempted by other tasks multiple time, but not by
> > > > > the starving RUNNABLE task that is hung on the rq. It seems to be vruntime
> > > > > related too but speculating here.
> > > >
> > > > Yes, now we met the similar scenario when running a monkey test on the
> > > > android phone.
> > > > There are multiple tasks on cpu, but the runnable task could not be
> > > > got scheduled for a long time,
> > > > there is task running and we could see the task preempted by other
> > > > tasks multiple times.
> > > > Then we dump the tasks, and find the vruntime of each task varies
> > > > greatly, and the task which running call the sched_yield frequently.
> > >
> > > If I'm not wrong you are using cgroups and as a result you can't
> > > compare the vruntime of tasks that belongs to different group, you
> > > must compare the vruntime of entities at the same level. We might have
> > > to look the side because I can't see why the task would not be
> > > schedule if other tasks in the same group move forward their vruntime
> >
> > All the tasks belong to the same cgroup.

Could they move between cpusets though?

> 
> ok.
> I have tried to reproduce your problem but can't see it so far. I'm
> probably missing something.
> 
> With rt-app, I start:
> - 3 tasks A, B, C which are always running
> - 1 task D which always runs but yields every 1ms for 1000 times and
> then stops yielding and always run
> 
> All tasks are pinned on the same cpu in the same cgroup.
> 
> I don't see anything wrong.
> task A, B, C runs their slices
> task D is preempted by others after 1ms for a couple of times when it
> calls yield. Then the yield doesn't have effect and task D runs a few
> consecutive ms although the yield. Then task D restart to be preempted
> by others when it calls yield when its vruntime is close to others
> 
> Once task D stop calling yield, the 4 tasks runs normally

Could vruntime be inflated if a task gets stuck on a little core for a while
(where it'll run slower) then compared to another task running on a bigger core
the vruntime will appear smaller for the latter?


Cheers

--
Qais Yousef
