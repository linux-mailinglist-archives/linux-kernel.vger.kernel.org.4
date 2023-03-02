Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E18E46A7C2F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 09:00:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbjCBIAl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 03:00:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjCBIAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 03:00:39 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 918852CFE7
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 00:00:38 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id m3-20020a17090ade0300b00229eec90a7fso3065642pjv.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 00:00:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Bj5jeIBQySglm8iH/PRsrrx+226h9Hbx2cQIENUHVIQ=;
        b=XxyK4SX2tntnJjD5uJ1AZorK7UX4/Dvfl4/5IB5fSAclhy3ktUXYYf5EDuxScTzFPe
         HEm/8URcs5WaUk+G1BtE3nniKTbuLt5w3PMhGiijYZmu81Kg+AQK9Ri5YyiHfCCUqqOG
         2oYFFxZ9byduvftmIpamuRMJmuMOo8FsiFceDGmq5CnVkFuxRBs3Uc+S8bl8roQ7hA6c
         WcgHrUw4om48E7ozZ+Gw+KqLs0hYVYzUOMVH2HOBuAxttsqcPB/KXi681/0EqHJj50un
         +Ubth1AswnLYRb/y8RbFvjGaYe9sLSBFOqDDdZO+m1Bl9wVHv9mLptoOm6RXEfrcGipx
         qeig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bj5jeIBQySglm8iH/PRsrrx+226h9Hbx2cQIENUHVIQ=;
        b=62p371v7c1+1RN3Mgae2ACwpbBr9M9K8EvavCfDl9yfD0wnIA75MLDUcck/8OjVCHa
         b47B3YcHKSa+/GyoGWfItlVP76R86Dr3bdoJIwvvzTIbks6PdYzvP4mredKn59uHixOB
         9xXXk2kiYGQdEL+E5AVkeggG0wpe3xP+WNhdBfzJ/FJjrXP/G0Y0+ASTQW9rfETSu5c4
         SIYW/NfpbotVF9psTjEZszR54OwhWHyZTHRYCaZZfOF7Tjv9AgqWahGdoR9W9tHdJH42
         WTD3D+7pj7p3m1C/eu0riEVd0ppriWGjJxgzB3rIVPXbM/SdqPNzArK1XJi6T9SZYXO1
         kvOg==
X-Gm-Message-State: AO0yUKVrRRvr2XnK/o53VtvVhoyNJxEshzTWs5hvFshLirpaS/goOnuE
        uGUWa/zAgVdGE/TORUBoyNiPsbszL1mwreAthVpGPA==
X-Google-Smtp-Source: AK7set/rTmv11vbJXLoDBX6h8G5mkK4oxcjWyehmVaMfP5hlenR4+OSHUGo+95iCDM4L/J6OJPBQGIEkTMIK/JbZD68=
X-Received: by 2002:a17:903:1303:b0:19a:afc4:2300 with SMTP id
 iy3-20020a170903130300b0019aafc42300mr3429544plb.6.1677744037968; Thu, 02 Mar
 2023 00:00:37 -0800 (PST)
MIME-Version: 1.0
References: <YzV9Gejo/+DL3UjK@e126311.manchester.arm.com> <YzV/yT6OYMgaq0kD@hirez.programming.kicks-ass.net>
 <YzWuq5ShtJC6KWqe@e126311.manchester.arm.com> <Y2kLA8x40IiBEPYg@hirez.programming.kicks-ass.net>
 <20221108194843.i4qckcu7zwqstyis@airbuntu> <Y2vMBWpPlIArwnI7@hirez.programming.kicks-ass.net>
 <424e2c81-987d-f10e-106d-8b4c611768bc@arm.com> <CAKfTPtD0ZOndFef3-JxBn3G9tcX=cZEObjHZ0iqiVTJz7+QrmQ@mail.gmail.com>
 <20230223153700.55zydy7jyfwidkis@airbuntu> <CAKfTPtDVGcvmR5BoJpyoOBE19PcWZP+6NjSD7MnJyBAc7VMnmg@mail.gmail.com>
 <20230301172458.intrgsirjauzqmo3@airbuntu>
In-Reply-To: <20230301172458.intrgsirjauzqmo3@airbuntu>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 2 Mar 2023 09:00:26 +0100
Message-ID: <CAKfTPtDwDdpiQnUqi_OtER5EE0EN4ykDMqtwzHi3d7AyBd_aQA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/1] sched/pelt: Change PELT halflife at runtime
To:     Qais Yousef <qyousef@layalina.io>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Kajetan Puchalski <kajetan.puchalski@arm.com>,
        Jian-Min Liu <jian-min.liu@mediatek.com>,
        Ingo Molnar <mingo@kernel.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Vincent Donnefort <vdonnefort@google.com>,
        Quentin Perret <qperret@google.com>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Abhijeet Dharmapurikar <adharmap@quicinc.com>,
        Qais Yousef <qais.yousef@arm.com>,
        linux-kernel@vger.kernel.org,
        Jonathan JMChen <jonathan.jmchen@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Mar 2023 at 18:25, Qais Yousef <qyousef@layalina.io> wrote:
>
> On 03/01/23 11:39, Vincent Guittot wrote:
> > On Thu, 23 Feb 2023 at 16:37, Qais Yousef <qyousef@layalina.io> wrote:
> > >
> > > On 02/09/23 17:16, Vincent Guittot wrote:
> > >
> > > > I don't see how util_est_faster can help this 1ms task here ? It's
> > > > most probably never be preempted during this 1ms. For such an Android
> > > > Graphics Pipeline short task, hasn't uclamp_min been designed for and
> > > > a better solution ?
> > >
> > > uclamp_min is being used in UI and helping there. But your mileage might vary
> > > with adoption still.
> > >
> > > The major motivation behind this is to help things like gaming as the original
> > > thread started. It can help UI and other use cases too. Android framework has
> > > a lot of context on the type of workload that can help it make a decision when
> > > this helps. And OEMs can have the chance to tune and apply based on the
> > > characteristics of their device.
> > >
> > > > IIUC how util_est_faster works, it removes the waiting time when
> > > > sharing cpu time with other tasks. So as long as there is no (runnable
> > > > but not running time), the result is the same as current util_est.
> > > > util_est_faster makes a difference only when the task alternates
> > > > between runnable and running slices.
> > > > Have you considered using runnable_avg metrics in the increase of cpu
> > > > freq ? This takes into the runnable slice and not only the running
> > > > time and increase faster than util_avg when tasks compete for the same
> > > > CPU
> > >
> > > Just to understand why we're heading into this direction now.
> > >
> > > AFAIU the desired outcome to have faster rampup time (and on HMP faster up
> > > migration) which both are tied to utilization signal.
> > >
> > > Wouldn't make the util response time faster help not just for rampup, but
> > > rampdown too?
> > >
> > > If we improve util response time, couldn't this mean we can remove util_est or
> > > am I missing something?
> >
> > not sure because you still have a ramping step whereas util_est
> > directly gives you the final tager
>
> I didn't get you. tager?

target

>
> >
> > >
> > > Currently we have util response which is tweaked by util_est and then that is
> > > tweaked further by schedutil with that 25% margin when maping util to
> > > frequency.
> >
> > the 25% is not related to the ramping time but to the fact that you
> > always need some margin to cover unexpected events and estimation
> > error
>
> At the moment we have
>
>         util_avg -> util_est -> (util_est_faster) -> util_map_freq -> schedutil filter ==> current frequency selection
>
> I think we have too many transformations before deciding the current
> frequencies. Which makes it hard to tweak the system response.

What is proposed here with runnable_avg is more to take a new input
when selecting a frequency: the level of contention on the cpu. But
this is not used to modify the utilization seen by the scheduler

>
> >
> > >
> > > I think if we can allow improving general util response time by tweaking PELT
> > > HALFLIFE we can potentially remove util_est and potentially that magic 25%
> > > margin too.
> > >
> > > Why the approach of further tweaking util_est is better?
> >
> > note that in this case it doesn't really tweak util_est but Dietmar
> > has taken into account runnable_avg to increase the freq in case of
> > contention
> >
> > Also IIUC Dietmar's results, the problem seems more linked to the
> > selection of a higher freq than increasing the utilization;
> > runnable_avg tests give similar perf results than shorter half life
> > and better power consumption.
>
> Does it ramp down faster too?

I don't think so.

To be honest, I'm not convinced that modifying the half time is the
right way to solve this. If it was only a matter of half life not
being suitable for a system, the halk life would be set once at boot
and people would not ask to modify it at run time.

>
>
> Thanks
>
> --
> Qais Yousef
>
> >
> > >
> > > Recently phoronix reported that schedutil behavior is suboptimal and I wonder
> > > if the response time is contributing to that
> > >
> > >         https://www.phoronix.com/review/schedutil-quirky-2023
> > >
> > >
> > > Cheers
> > >
> > > --
> > > Qais Yousef
