Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C00C3740194
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 18:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbjF0QrL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 12:47:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjF0QrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 12:47:09 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A136797
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 09:47:07 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4f9fdb0ef35so4699238e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 09:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687884426; x=1690476426;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sIaN+Eh1obLQgjVcCLnKW2RT5tfo3VuklPHO6/b+zVs=;
        b=wWORlPzABH6T7cFaf2WB327lH252MRaHdJNidpc3TweAOCAvlMVwvL3t/hBwPlsnwX
         IDY2k2/1sAnOSBwH7lTn/fjb4BtSrH7dSuLyL2S/ttrxtk+S26PS1C3ShenNAUFNJwDa
         xPYFSIliFEZmi6OppHFEgvlXfu0mFOamGUPMvpoxCDm9u+AzMDEmV6bxjumckE/wegiU
         T0MhYxW3erglgCYTedJBmVQnYmpxtRxSHUMji6Bgxr2xfpBG1STR0xzy0Dt11mmr+ZXV
         ZVy1dPHk+9dJESmqejaDskwHNV3WXwM8NHZGLnaY7jrgRxIc0G6okhdyRTOsKIEYK69I
         labw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687884426; x=1690476426;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sIaN+Eh1obLQgjVcCLnKW2RT5tfo3VuklPHO6/b+zVs=;
        b=bX0PvblUq5Y3Jm8NRux5/Rtd4IWHab9SuBAkC61+GZpIun+Ldk04bUg9ewE3NkpJKu
         vyvnup2rs5bHrli7J8CayQirdh4rRWmYVxBSgtcft1P+eav00bcn46yVekmTYESoEzI4
         zvlVIU26DE6Kfynn1FSJRO8KlIf6A6asxksfIR22JN2L0dzsKKmxubFxLqhQ8NHonUlZ
         wnxKAz4SiwxLTzMqOey/VJlcWApxa6bV4IUHZEvRJuH2/w5dsCb669XacNmkOUmO6jsJ
         LP2nxPIscGys7aG/cwpWbnt1ZXm8VaYQUfn19Q+P/vV7Ze1XyQRa5r6TnH5Ma9FyuBLo
         7n3w==
X-Gm-Message-State: AC+VfDwNFlr6Pk9NtSgO4X4otZY1DvIEwivGPildTMc2XpufMSGXETzB
        Lek5gfV2cI6gb+GiBmxwM9xE5n9drKFVnKsTtX5s+Q==
X-Google-Smtp-Source: ACHHUZ4pJH4DLzevFSVtKzXWqSprbcTeIPro7MnE0EtlDuZMq8rDFgTjvXzlIqUASuNvjmMPFq3zVNGoWY3Fm8ipggQ=
X-Received: by 2002:a19:7715:0:b0:4f9:5a87:1028 with SMTP id
 s21-20020a197715000000b004f95a871028mr10313310lfc.30.1687884425732; Tue, 27
 Jun 2023 09:47:05 -0700 (PDT)
MIME-Version: 1.0
References: <8e785777-03aa-99e1-d20e-e956f5685be6@huawei.com>
 <87mt18it1y.ffs@tglx> <68baeac9-9fa7-5594-b5e7-4baf8ac86b77@huawei.com> <ba352e83-b8b1-d900-9c1f-56b8c8a8b8fb@huawei.com>
In-Reply-To: <ba352e83-b8b1-d900-9c1f-56b8c8a8b8fb@huawei.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 27 Jun 2023 18:46:54 +0200
Message-ID: <CAKfTPtBoe_jRn-EMsQxssQ4BcveT+Qcd+GmsRbQEXQDGfzFOMg@mail.gmail.com>
Subject: Re: [Question] report a race condition between CPU hotplug state
 machine and hrtimer 'sched_cfs_period_timer' for cfs bandwidth throttling
To:     Xiongfeng Wang <wangxiongfeng2@huawei.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, vschneid@redhat.com,
        Phil Auld <pauld@redhat.com>, vdonnefort@google.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Wei Li <liwei391@huawei.com>,
        "liaoyu (E)" <liaoyu15@huawei.com>, zhangqiao22@huawei.com,
        Peter Zijlstra <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Jun 2023 at 10:23, Xiongfeng Wang <wangxiongfeng2@huawei.com> wrote:
>
> Hi,
>
> Kindly ping~
> Could you please take a look at this issue and the below temporary fix ?
>
> Thanks,
> Xiongfeng
>
> On 2023/6/12 20:49, Xiongfeng Wang wrote:
> >
> >
> > On 2023/6/9 22:55, Thomas Gleixner wrote:
> >> On Fri, Jun 09 2023 at 19:24, Xiongfeng Wang wrote:
> >>
> >> Cc+ scheduler people, leave context intact
> >>
> >>> Hello,
> >>>  When I do some low power tests, the following hung task is printed.
> >>>
> >>>   Call trace:
> >>>    __switch_to+0xd4/0x160
> >>>    __schedule+0x38c/0x8c4
> >>>    __cond_resched+0x24/0x50
> >>>    unmap_kernel_range_noflush+0x210/0x240
> >>>    kretprobe_trampoline+0x0/0xc8
> >>>    __vunmap+0x70/0x31c
> >>>    __vfree+0x34/0x8c
> >>>    vfree+0x40/0x58
> >>>    free_vm_stack_cache+0x44/0x74
> >>>    cpuhp_invoke_callback+0xc4/0x71c
> >>>    _cpu_down+0x108/0x284
> >>>    kretprobe_trampoline+0x0/0xc8
> >>>    suspend_enter+0xd8/0x8ec
> >>>    suspend_devices_and_enter+0x1f0/0x360
> >>>    pm_suspend.part.1+0x428/0x53c
> >>>    pm_suspend+0x3c/0xa0
> >>>    devdrv_suspend_proc+0x148/0x248 [drv_devmng]
> >>>    devdrv_manager_set_power_state+0x140/0x680 [drv_devmng]
> >>>    devdrv_manager_ioctl+0xcc/0x210 [drv_devmng]
> >>>    drv_ascend_intf_ioctl+0x84/0x248 [drv_davinci_intf]
> >>>    __arm64_sys_ioctl+0xb4/0xf0
> >>>    el0_svc_common.constprop.0+0x140/0x374
> >>>    do_el0_svc+0x80/0xa0
> >>>    el0_svc+0x1c/0x28
> >>>    el0_sync_handler+0x90/0xf0
> >>>    el0_sync+0x168/0x180
> >>>
> >>> After some analysis, I found it is caused by the following race condition.
> >>>
> >>> 1. A task running on CPU1 is throttled for cfs bandwidth. CPU1 starts the
> >>> hrtimer cfs_bandwidth 'period_timer' and enqueue the hrtimer on CPU1's rbtree.
> >>> 2. Then the task is migrated to CPU2 and starts to offline CPU1. CPU1 starts
> >>> CPUHP AP steps, and then the hrtimer 'period_timer' expires and re-enqueued on CPU1.
> >>> 3. CPU1 runs to take_cpu_down() and disable irq. After CPU1 finished CPUHP AP
> >>> steps, CPU2 starts the rest CPUHP step.
> >>> 4. When CPU2 runs to free_vm_stack_cache(), it is sched out in __vunmap()
> >>> because it run out of CPU quota. start_cfs_bandwidth() does not restart the
> >>> hrtimer because 'cfs_b->period_active' is set.
> >>> 5. The task waits the hrtimer 'period_timer' to expire to wake itself up, but
> >>> CPU1 has disabled irq and the hrtimer won't expire until it is migrated to CPU2
> >>> in hrtimers_dead_cpu(). But the task is blocked and cannot proceed to
> >>> hrtimers_dead_cpu() step. So the task hungs.
> >>>
> >>>     CPU1                                                     CPU2
> >>> Task set cfs_quota
> >>> start hrtimer cfs_bandwidth 'period_timer'
> >>>                                             start to offline CPU1
> >>> CPU1 start CPUHP AP step
> >>> ...
> >>> 'period_timer' expired and re-enqueued on CPU1
> >>> ...
> >>> disable irq in take_cpu_down()
> >>> ...
> >>>                                             CPU2 start the rest CPUHP steps
> >>>                                             ...
> >>>                                           sched out in free_vm_stack_cache()
> >>>                                             wait for 'period_timer' expires
> >>>
> >>>
> >>> Appreciate it a lot if anyone can give some suggestion on how fix this problem !
> >>>
> >>> Thanks,
> >>> Xiongfeng
> >> .
> >>
> >
> > Test script:
> > taskset -cp 1 $$
> > mkdir /sys/fs/cgroup/cpu/test
> > echo $$ > /sys/fs/cgroup/cpu/test/tasks
> > echo 80000 > /sys/fs/cgroup/cpu/test/cpu.cfs_quota_us
> > echo 100000 > /sys/fs/cgroup/cpu/test/cpu.cfs_period_us
> > taskset -cp 2 $$
> > echo 0 > /sys/devices/system/cpu/cpu1/online
> >
> >
> > Tests show that the following modification can solve the problem of above test
> > scripts. But I am not sure if there exists some other issues.
> >
> > diff --cc kernel/sched/fair.c
> > index d9d6519fae01,bd6624353608..000000000000
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@@ -5411,10 -5411,16 +5411,15 @@@ void start_cfs_bandwidth(struct cfs_ban
> >   {
> >         lockdep_assert_held(&cfs_b->lock);
> >
> > -       if (cfs_b->period_active)
> > +       if (cfs_b->period_active) {
> > +               struct hrtimer_clock_base *clock_base = cfs_b->period_timer.base;
> > +               int cpu = clock_base->cpu_base->cpu;
> > +               if (!cpu_active(cpu) && cpu != smp_processor_id())
> > +                       hrtimer_start_expires(&cfs_b->period_timer,
> > HRTIMER_MODE_ABS_PINNED);
> >                 return;
> > +       }

I have been able to reproduce your problem and run your fix on top. I
still wonder if there is a
Could we have a helper from hrtimer to get the cpu of the clock_base ?


> >
> >         cfs_b->period_active = 1;
> >  -
> >         hrtimer_forward_now(&cfs_b->period_timer, cfs_b->period);
> >         hrtimer_start_expires(&cfs_b->period_timer, HRTIMER_MODE_ABS_PINNED);
> >   }
> >
> > Thanks,
> > Xiongfeng
> >
> > .
> >
