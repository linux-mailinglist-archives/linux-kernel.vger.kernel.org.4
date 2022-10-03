Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62C305F285F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 08:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbiJCGLZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 02:11:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiJCGLX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 02:11:23 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79267357C8
        for <linux-kernel@vger.kernel.org>; Sun,  2 Oct 2022 23:11:22 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id f189so11854092yba.12
        for <linux-kernel@vger.kernel.org>; Sun, 02 Oct 2022 23:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=Om7RJ5LwZx7rVjxMsdUizkW/M3Rohq2NtD7ku67zqOA=;
        b=OeZhiRQKwykWxuPN2AlXfehocdq6sTrwWpCwA1LJ4rsKw4xqpcLP6KBeMfo7MYp+wp
         /slLF9Rcl2WFmJkRBTpLaRWR9NVyOBgUDeoghSpUczU+hskxOQkldoyX51gcyBx1G99q
         8gn9eFuTrqtmo+HzBrYBnklk22RydM5A6+mNnFVq0P57EfHOmvSn8GQR1ynvtlD3LyGc
         u5rlz7JI84nTaL1+xmo/Ua3IceSPVePf1ZbMuy2OCoJDjsDM7ykqZFKdKAb/9QdJUhdf
         ia3oq/WU3XTK+FFqhdWQZ2BS7hXEzZ0YtFjk5OXGZNsb9P53WJ0x3DVPmlovx2QC0CxK
         yNYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=Om7RJ5LwZx7rVjxMsdUizkW/M3Rohq2NtD7ku67zqOA=;
        b=gXS0O4q8po0kV4zqNBCdCtTjK8YmEVtTV3RJhEAx6oyqfKVF9xvuDe9PEqOmhpPf2n
         THD98zYhryCcXqMcdsaI+9/kBN8+pWKDohf7E0he4+6/PQu9/uTcfH+F1eeLW9x5vds1
         9WedBOxiHMDp3RO+m88Zx5F8KX5cpGhSlfUNuFGi9Ov/aMLp9N2tgGxU+KiMRIPc6pGa
         UUH7pb0Bkg1IbUtWWeyeDOT5akIfQzsC5rPqelEMmwvyknuBXAHd8hh1t0Q1R+1iSMd+
         1UEDUO5P9nRi3IKmzveF+Z0l/aR2b47tkoElYiA7vDDVwCsH62iqIZ/3/MaaV5rbV1k7
         pTjQ==
X-Gm-Message-State: ACrzQf0yYPE2Tz2IJsprpYbKycC6Vz54ctfXvoORkkU36+mexsjDKVNG
        zB7faMlkMpHg4yBWaFKUr4Nvn1p5k3etDag8knI7e/DHZni6bw==
X-Google-Smtp-Source: AMsMyM46Xx3R+XMssQXCXr7Xe/P/g2PyWQVYt4nzLPWFU97omUFnFfWXsdmsYqxiHFHo9xy6EaK/A9ieZTnX47MdKl4=
X-Received: by 2002:a05:6902:2d0:b0:694:d257:4c4b with SMTP id
 w16-20020a05690202d000b00694d2574c4bmr18560528ybh.316.1664777481431; Sun, 02
 Oct 2022 23:11:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220913140817.GA9091@hu-pkondeti-hyd.qualcomm.com>
 <20220915062027.GA14713@hu-pkondeti-hyd.qualcomm.com> <CAJuCfpE_nM2uqixnds0d6wbsz4=OQ3KPoJ5HOqDhQXaxFGxwXQ@mail.gmail.com>
In-Reply-To: <CAJuCfpE_nM2uqixnds0d6wbsz4=OQ3KPoJ5HOqDhQXaxFGxwXQ@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Sun, 2 Oct 2022 23:11:10 -0700
Message-ID: <CAJuCfpEeNzDQ-CvMN3fP5LejOzpnfgUgvkzpPj1CLF-8NqNoww@mail.gmail.com>
Subject: Re: PSI idle-shutoff
To:     Pavan Kondeti <quic_pkondeti@quicinc.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Charan Teja Kalla <quic_charante@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 16, 2022 at 10:45 PM Suren Baghdasaryan <surenb@google.com> wrote:
>
> On Wed, Sep 14, 2022 at 11:20 PM Pavan Kondeti
> <quic_pkondeti@quicinc.com> wrote:
> >
> > On Tue, Sep 13, 2022 at 07:38:17PM +0530, Pavan Kondeti wrote:
> > > Hi
> > >
> > > The fact that psi_avgs_work()->collect_percpu_times()->get_recent_times()
> > > run from a kworker thread, PSI_NONIDLE condition would be observed as
> > > there is a RUNNING task. So we would always end up re-arming the work.
> > >
> > > If the work is re-armed from the psi_avgs_work() it self, the backing off
> > > logic in psi_task_change() (will be moved to psi_task_switch soon) can't
> > > help. The work is already scheduled. so we don't do anything there.
>
> Hi Pavan,
> Thanks for reporting the issue. IIRC [1] was meant to fix exactly this
> issue. At the time it was written I tested it and it seemed to work.
> Maybe I missed something or some other change introduced afterwards
> affected the shutoff logic. I'll take a closer look next week when I'm
> back at my computer and will consult with Johannes.

Sorry for the delay. I had some time to look into this and test psi
shutoff on my device and I think you are right. The patch I mentioned
prevents new psi_avgs_work from being scheduled when the only non-idle
task is psi_avgs_work itself, however the regular 2sec averaging work
will still go on. I think we could record the fact that the only
active task is psi_avgs_work in record_times() using a new
psi_group_cpu.state_mask flag and then prevent psi_avgs_work() from
rescheduling itself if that flag is set for all non-idle cpus. I'll
test this approach and will post a patch for review if that works.
Thanks,
Suren.

> Thanks,
> Suren.
>
> [1] 1b69ac6b40eb "psi: fix aggregation idle shut-off"
>
> > >
> > > Probably I am missing some thing here. Can you please clarify how we
> > > shut off re-arming the psi avg work?
> > >
> >
> > I have collected traces on an idle system (running android12-5.10 with minimal
> > user space). This is a older kernel, however the issue remain on latest kernel
> > as per code inspection.
> >
> > I have eliminated noise created by other work items. For example, vmstat_work.
> > This is a deferrable work but gets executed since this is queued on the same
> > CPU on which PSI work timer is queued. So I have increased
> > sysctl_stat_interval to 60 * HZ to supress this work.
> >
> > As we can see from the traces, CPU#7 comes out of idle only to execute PSI
> > work for every 2 seconds. The work is always re-armed from the psi_avgs_work()
> > as it finds PSI_NONIDLE condition. The non-idle time is essentially
> >
> > non_idle_time = (work_start_now - wakeup_now) + (sleep_prev - work_end_prev)
> >
> > The first term accounts the non-idle time since the task woken up (queued) to
> > the execution of the work item. It is around ~4 usec (54.119420 - 54.119416)
> >
> > The second term account for the previous update. ~2 usec (52.135424 -
> > 52.135422).
> >
> > PSI work needs to be run when there is some activity after the last update is done
> > i.e last time the work is run. Since we use non-deferrable timer, the other
> > deferrable timers gets woken up and they might queue work or wakeup other threads
> > and creates activity which inturn makes PSI work to be scheduled.
> >
> > PSI work can't just be made deferrable work. Because, it is a system level
> > work and if the CPU on which it is queued is idle for longer duration but the
> > other CPUs are active, we miss PSI updates. What we probably need is a global
> > deferrable timers [1] i.e this timer should not be bound to any CPU but
> > run when any of the CPU comes out of idle. As long as one CPU is busy, we keep
> > running the PSI but if the whole system is idle, we never wakeup.
> >
> >           <idle>-0     [007]    52.135402: cpu_idle:             state=4294967295 cpu_id=7
> >           <idle>-0     [007]    52.135415: workqueue_activate_work: work struct 0xffffffc011bd5010
> >           <idle>-0     [007]    52.135417: sched_wakeup:         comm=kworker/7:3 pid=196 prio=120 target_cpu=007
> >           <idle>-0     [007]    52.135421: sched_switch:         prev_comm=swapper/7 prev_pid=0 prev_prio=120 prev_state=R ==> next_comm=kworker/7:3 next_pid=196 next_prio=120
> >      kworker/7:3-196   [007]    52.135421: workqueue_execute_start: work struct 0xffffffc011bd5010: function psi_avgs_work
> >      kworker/7:3-196   [007]    52.135422: timer_start:          timer=0xffffffc011bd5040 function=delayed_work_timer_fn expires=4294905814 [timeout=494] cpu=7 idx=123 flags=D|P|I
> >      kworker/7:3-196   [007]    52.135422: workqueue_execute_end: work struct 0xffffffc011bd5010: function psi_avgs_work
> >      kworker/7:3-196   [007]    52.135424: sched_switch:         prev_comm=kworker/7:3 prev_pid=196 prev_prio=120 prev_state=I ==> next_comm=swapper/7 next_pid=0 next_prio=120
> >           <idle>-0     [007]    52.135428: cpu_idle:             state=0 cpu_id=7
> >
> >           <system is idle and gets woken up after 2 seconds due to PSI work>
> >
> >           <idle>-0     [007]    54.119402: cpu_idle:             state=4294967295 cpu_id=7
> >           <idle>-0     [007]    54.119414: workqueue_activate_work: work struct 0xffffffc011bd5010
> >           <idle>-0     [007]    54.119416: sched_wakeup:         comm=kworker/7:3 pid=196 prio=120 target_cpu=007
> >           <idle>-0     [007]    54.119420: sched_switch:         prev_comm=swapper/7 prev_pid=0 prev_prio=120 prev_state=R ==> next_comm=kworker/7:3 next_pid=196 next_prio=120
> >      kworker/7:3-196   [007]    54.119420: workqueue_execute_start: work struct 0xffffffc011bd5010: function psi_avgs_work
> >      kworker/7:3-196   [007]    54.119421: timer_start:          timer=0xffffffc011bd5040 function=delayed_work_timer_fn expires=4294906315 [timeout=499] cpu=7 idx=122 flags=D|P|I
> >      kworker/7:3-196   [007]    54.119422: workqueue_execute_end: work struct 0xffffffc011bd5010: function psi_avgs_work
> >
> > [1]
> > https://lore.kernel.org/lkml/1430188744-24737-1-git-send-email-joonwoop@codeaurora.org/
> >
> > Thanks,
> > Pavan
