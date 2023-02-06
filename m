Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FCFB68BD3A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 13:48:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbjBFMsQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 07:48:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbjBFMsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 07:48:14 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4278740C2
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 04:48:13 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id 78so8087855pgb.8
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 04:48:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3Cqlt+bBCB29xtU/qGyRiJDI9J/W3dNrzS0FVfL52HY=;
        b=jIxZNqvQHcXCHWKQNO/P8nn5dZAZ6S7gX7bnS8rosdirxP/h2w9xT6BOKcxb/ge6uV
         qDlw3eKQsK6uhKiN/AaclKpoj5cWy3rfeR6ktJOKzno/w5r/s8uJJIKHcT8U0uMK6D1y
         8kwFGVHEBuLlM0S0h7hu6b4XMMO+dTr4kk6vYpk5MVCAZiQHQ1yLytRNde+qYI0TQ9a9
         KmArsuESduShdXn6Jn2PtqQroYSn1mo6cznQA2A3vxqIVd+E23ow6qocfjEWCfFKpE7J
         HTf681Ax3e3pEellln4U6B2tUE7eMi2n6YAkgmqabyu3/SouHawiOhYxLFSvp/qVFnPR
         VNhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3Cqlt+bBCB29xtU/qGyRiJDI9J/W3dNrzS0FVfL52HY=;
        b=ArQvxf1UXWhmzlO+UB1p16EAROjUZM8GrFHskC/MxeCBH68TDaD4adENmyw+dj0IQc
         mumo8M2DQRc2IGcsknjqinPVBiUVH9I3Hj5XtQ61FDMg31xiiW0mXVQ/AOLhsMmX4jCG
         /jEHeO5xvn5KYKI5uiabF3DKyE9QIYjncK8L8FWoinGqe0gbbqXexwhvMciRpc6phEe+
         PvxsdHRr/lyfvx6WX4eYuf+QVfUs9HfNlFpZ54XyWp21eG5rKMEhswRfVO6PTdXS9AS/
         N7zL5ZG4zjy8n0e1bsvgmWTe9HX3hY6god6DniDI3flmqmxKZR7z/4W8tYQajMDB+RGD
         ZAuw==
X-Gm-Message-State: AO0yUKUCg31WyFtLDgBUUJ18X3wlsACbubhKAr/ty7h0LIpd407CAPSy
        gIeXTiYX5mviz/LbtdyLE4gmWSWyoUlUultYLAnqzn2lrx0=
X-Google-Smtp-Source: AK7set/NC+Zssu0gqVqf3bab5jZaIM5uvJEFBOfb6mOAOmkFh3OgTaN9B/x4Wmm6/iJoPneHt3hy5lYesV1rqWcrzWg=
X-Received: by 2002:a05:6a00:c88:b0:593:d035:5d31 with SMTP id
 a8-20020a056a000c8800b00593d0355d31mr4451435pfv.47.1675687692665; Mon, 06 Feb
 2023 04:48:12 -0800 (PST)
MIME-Version: 1.0
References: <1674007261-9198-1-git-send-email-yangtiezhu@loongson.cn>
 <CAAhV-H4aTd6_cSy45KKjv-KrLTiwT4iG6+fkb84KfCrL3Y+hpg@mail.gmail.com>
 <CAAhV-H5WN5E=0Z9wpbXDc6VO7Nc+j7PGvnyAAGOmCRMJkdwSYw@mail.gmail.com>
 <CAEr6+ECO-=jfhzHrcdKGx0MsjMBMiN6wsBPCfv7CaXo_amAWWg@mail.gmail.com>
 <02806f85-bc09-d316-f058-3947353cb190@loongson.cn> <CAEr6+EBYF2xqZWEuZaz5un5FF3Jb-rSAQp3s3uojsovm9RcUYA@mail.gmail.com>
 <CAAhV-H5dJGrL3kEwzC-XwMqJTCsYHq-YVDTDRntGcYg9RMz02w@mail.gmail.com>
In-Reply-To: <CAAhV-H5dJGrL3kEwzC-XwMqJTCsYHq-YVDTDRntGcYg9RMz02w@mail.gmail.com>
From:   Jeff Xie <xiehuan09@gmail.com>
Date:   Mon, 6 Feb 2023 20:48:00 +0800
Message-ID: <CAEr6+EDvaqpfvyJhe9TpDbhzrgu9aPPtePi2Vp=vAB5xgMNhXQ@mail.gmail.com>
Subject: Re: [PATCH v12 0/5] Add kprobe and kretprobe support for LoongArch
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     Tiezhu Yang <yangtiezhu@loongson.cn>,
        WANG Xuerui <kernel@xen0n.name>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,LOTS_OF_MONEY,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 6, 2023 at 8:13 PM Huacai Chen <chenhuacai@kernel.org> wrote:
>
> Hi, Jeff,
>
> Now I add kprobes on ftrace support in
> https://github.com/loongson/linux/commits/loongarch-next, please test
> again. Thank you.
>

When using the kprobe example module kprobe_example.ko, I haven't seen
any errors.

But when using the ftrace to probe the symbol + offset, the kernel will panic:
e.g. probe the scheduler_tick+4 is fine, but when probe the
scheduler_tick+5, the kernel will panic.

root@loongarch tracing]# echo 'p scheduler_tick+4' > ./kprobe_events
[root@loongarch tracing]# echo 1 > ./events/kprobes/p_scheduler_tick_4/enable
[root@loongarch tracing]# cat /sys/kernel/debug/kprobes/list
900000000027b5f4  k  scheduler_tick+0x4

[root@loongarch tracing]# echo 0 > ./events/kprobes/p_scheduler_tick_4/enable
[root@loongarch tracing]# > ./kprobe_events
[root@loongarch tracing]# echo 'p scheduler_tick+5' > ./kprobe_events
[root@loongarch tracing]# echo 1 > ./events/kprobes/p_scheduler_tick_5/enable

[The kernel will panic]

dmesg:

[   69.138541] CPU 0 Unable to handle kernel paging request at virtual
address 00000000ffff1e8c, era == 900000000027b5f4, ra ==
90000000002ed69c
[   69.139325] Oops[#1]:
[   69.139399] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W
   6.2.0-rc7+ #28
[   69.139422] Hardware name: QEMU QEMU Virtual Machine, BIOS 0.0.0 02/06/2015
[   69.139446] $ 0   : 0000000000000000 90000000002ed69c
90000000019ec000 900000010020bd90
[   69.139533] $ 4   : 9000000006025600 900000000182bd48
0000000000000000 9000000001d493c8
[   69.139601] $ 8   : 0000000000000040 9000000001412900
0000000000000000 0000000000000049
[   69.139667] $12   : 90000000002ed69c 0000000000000000
0000000000000001 00000000000f0000
[   69.139733] $16   : 00000000ffff1e8a 00000000ffff1e89
ffffffffffffeb7f 00000000ffff330b
[   69.139797] $20   : 0000000000000000 00000000000000b0
9000000006003600 90000000060010c0
[   69.139862] $24   : 0000000000000000 90000000019efc80
9000000006003620 9000000006003ae8
[   69.139927] $28   : 9000000001c7fe80 9000000001c7fec0
9000000001c7fe40 0000000000000001
[   69.139993] era   : 900000000027b5f4 scheduler_tick+0x4/0x124
[   69.140025] ra    : 90000000002ed69c update_process_times+0xac/0xc0
[   69.140047] CSR crmd: 000000b0
[   69.140058] CSR prmd: 00000000
[   69.140069] CSR euen: 00000000
[   69.140080] CSR ecfg: 00071c1c
[   69.140090] CSR estat: 00010000
[   69.140112] ExcCode : 1 (SubCode 0)
[   69.140139] BadVA : 00000000ffff1e8c
[   69.140153] PrId  : 0014c010 (Loongson-64bit)
[   69.140174] Modules linked in:
[   69.140216] Process swapper/0 (pid: 0, threadinfo=(____ptrval____),
task=(____ptrval____))
[   69.140499] Stack : 0000000000000000 0000000000000000
90000000019efc80 00000010185c7aa6
[   69.140570]         9000000006003ae8 90000000002ff070
90000000060035c0 90000000002ff014
[   69.140636]         90000000060035c0 90000000002ee7ec
00000000000000b0 00000000000000b0
[   69.140701]         0000000000000000 00000010185c4c98
00000010185c4c98 7d6a3ef38af5219f
[   69.140766]         9000000001ddaa60 90000000060036b8
9000000006003678 90000000060035cc
[   69.140830]         0000000000000001 00000010185c4c98
0000000000000003 00000010185c4c98
[   69.140894]         00000000000000b0 90000000060035c0
90000000060036f8 90000000002ef404
[   69.140958]         9000000001b05880 9000000001a0c5e8
0000000000012400 9000000001c7ea40
[   69.141023]         9000000001c7ea00 0000000000010000
0000000000000002 0000000000000012
[   69.141087]         900000010017ec00 0000000000000000
900000010015cf80 90000000002265a4
[   69.141151]         ...
[   69.141192] Call Trace:
[   69.141278] [<900000000027b5f4>] scheduler_tick+0x4/0x124
[   69.141339] [<90000000002ed69c>] update_process_times+0xac/0xc0
[   69.141361] [<90000000002ff070>] tick_sched_timer+0x5c/0xe8
[   69.141381] [<90000000002ee7ec>] __hrtimer_run_queues+0x1f0/0x3d0
[   69.141400] [<90000000002ef404>] hrtimer_interrupt+0x108/0x28c
[   69.141420] [<90000000002265a4>] constant_timer_interrupt+0x38/0x48
[   69.141439] [<90000000002b358c>] __handle_irq_event_percpu+0xbc/0x290
[   69.141458] [<90000000002b3780>] handle_irq_event_percpu+0x20/0x78
[   69.141477] [<90000000002b9cac>] handle_percpu_irq+0x5c/0x90
[   69.141497] [<90000000002b2740>] generic_handle_domain_irq+0x30/0x48
[   69.141516] [<9000000000af906c>] handle_cpu_irq+0x70/0xac
[   69.141538] [<90000000012bf8b8>] handle_loongarch_irq+0x34/0x4c
[   69.141560] [<90000000012bf950>] do_vint+0x80/0xb4
[   69.141672] [<9000000000222120>] __arch_cpu_idle+0x20/0x24
[   69.141694] [<90000000012cf934>] default_idle_call+0x70/0x168
[   69.141713] [<9000000000291df4>] do_idle+0xc8/0x144
[   69.141732] [<9000000000292078>] cpu_startup_entry+0x28/0x2c
[   69.141750] [<90000000012c20e4>] kernel_init+0x0/0x120
[   69.142210] [<90000000012f09e8>] arch_post_acpi_subsys_init+0x0/0xc
[   69.142268] Code: 53ffbbff  54442c41  0015002c <2a000a00> 02ff4000
29c08077  29c06078  29c04079  29c0207a
[   69.142624] ---[ end trace 0000000000000000 ]---
[   69.143284] Kernel panic - not syncing: Fatal exception in interrupt
[   69.143469] ------------[ cut here ]------------
[   69.143498] WARNING: CPU: 0 PID: 0 at kernel/smp.c:912
smp_call_function_many_cond+0x3dc/0x3fc
[   69.143523] Modules linked in:
[   69.143546] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G      D W
   6.2.0-rc7+ #28
[   69.143565] Hardware name: QEMU QEMU Virtual Machine, BIOS 0.0.0 02/06/2015
[   69.143577] $ 0   : 0000000000000000 9000000000305f50
90000000019ec000 900000010020ba40
[   69.143644] $ 4   : 9000000001a02fc8 900000000022c534
0000000000000000 0000000000000000
[   69.143709] $ 8   : 0000000000000000 900000010020bad8
900000010020b8f0 9000000001a02788
[   69.143775] $12   : 0000000000010000 0000000000000000
0000000000000000 0000000000000000
[   69.143839] $16   : 0000000000f00000 0000000000000000
0000000000000000 0000000000000000
[   69.143904] $20   : 0000000000000001 9000000001a222c8
9000000006003600 9000000001a02fc8
[   69.143968] $24   : 0000000000000000 0000000000000000
0000000000000000 0000000000000000
[   69.144032] $28   : 0000000000000000 0000000000000000
9000000001c7fe40 0000000000000001
[   69.144096] era   : 9000000000305cb4 smp_call_function_many_cond+0x3dc/0x3fc
[   69.144115] ra    : 9000000000305f50 smp_call_function+0x4c/0x9c
[   69.144133] CSR crmd: 000000b0
[   69.144144] CSR prmd: 00000000
[   69.144155] CSR euen: 00000000
[   69.144166] CSR ecfg: 00071c1c
[   69.144177] CSR estat: 000c0000
[   69.144198] ExcCode : c (SubCode 0)
[   69.144210] PrId  : 0014c010 (Loongson-64bit)
[   69.144254] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G      D W
   6.2.0-rc7+ #28
[   69.144274] Hardware name: QEMU QEMU Virtual Machine, BIOS 0.0.0 02/06/2015
[   69.144287] Stack : 00000000000002cb 0000000000000000
9000000000223a08 90000000019ec000
[   69.144354]         900000010020b6a0 900000010020b6a8
0000000000000000 0000000000000000
[   69.144419]         900000010020b6a8 0000000000000040
900000010020b778 900000010020b510
[   69.144483]         9000000001a02788 900000010020b6a8
7d6a3ef38af5219f 9000000100330000
[   69.144548]         0000000000000003 0000000000010005
0000000000000000 0000000000000000
[   69.144612]         0000000000000000 900000000181da00
0000000004c1c000 9000000006003600
[   69.144676]         0000000000000000 0000000000000000
900000000189cbc0 9000000001a02788
[   69.144741]         0000000000000000 0000000000000390
0000000000000000 9000000001c7fe40
[   69.144806]         0000000000000001 0000000000000000
9000000000223a20 9000000000305cb4
[   69.144870]         00000000000000b0 0000000000000000
0000000000000000 0000000000071c1c
[   69.144935]         ...
[   69.144963] Call Trace:
[   69.144974] [<9000000000223a20>] show_stack+0x68/0x18c
[   69.144996] [<90000000012bea54>] dump_stack_lvl+0x80/0xb8
[   69.145016] [<900000000023c264>] __warn+0x8c/0x180
[   69.145035] [<900000000127769c>] report_bug+0xac/0x178
[   69.145056] [<90000000012bf140>] do_bp+0x350/0x3a4
[   69.145075] [<9000000001cf1924>] exception_handlers+0x1924/0x10000
[   69.145098] [<9000000000305cb4>] smp_call_function_many_cond+0x3dc/0x3fc
[   69.145116] [<9000000000305f50>] smp_call_function+0x4c/0x9c
[   69.145135] [<90000000012a3da8>] panic+0x17c/0x37c
[   69.145155] [<9000000000223cb8>] die+0x138/0x144
[   69.145173] [<90000000012d0ed8>] do_sigsegv+0x0/0x190
[   69.145193] [<90000000012d1310>] do_page_fault+0x2a8/0x4a8
[   69.145212] [<90000000002312c0>] tlb_do_page_fault_0+0x128/0x1c4
[   69.145231] [<90000000002ed69c>] update_process_times+0xac/0xc0
[   69.145250] [<90000000002ff070>] tick_sched_timer+0x5c/0xe8
[   69.145270] [<90000000002ee7ec>] __hrtimer_run_queues+0x1f0/0x3d0
[   69.145289] [<90000000002ef404>] hrtimer_interrupt+0x108/0x28c
[   69.145307] [<90000000002265a4>] constant_timer_interrupt+0x38/0x48
[   69.145326] [<90000000002b358c>] __handle_irq_event_percpu+0xbc/0x290
[   69.145345] [<90000000002b3780>] handle_irq_event_percpu+0x20/0x78
[   69.145364] [<90000000002b9cac>] handle_percpu_irq+0x5c/0x90
[   69.145383] [<90000000002b2740>] generic_handle_domain_irq+0x30/0x48
[   69.145402] [<9000000000af906c>] handle_cpu_irq+0x70/0xac
[   69.145419] [<90000000012bf8b8>] handle_loongarch_irq+0x34/0x4c
[   69.145439] [<90000000012bf950>] do_vint+0x80/0xb4
[   69.145458] [<9000000000222120>] __arch_cpu_idle+0x20/0x24
[   69.145476] [<90000000012cf934>] default_idle_call+0x70/0x168
[   69.145495] [<9000000000291df4>] do_idle+0xc8/0x144
[   69.145513] [<9000000000292078>] cpu_startup_entry+0x28/0x2c
[   69.145532] [<90000000012c20e4>] kernel_init+0x0/0x120
[   69.145554] [<90000000012f09e8>] arch_post_acpi_subsys_init+0x0/0xc
[   69.145587] ---[ end trace 0000000000000000 ]---
[   69.146277] ---[ end Kernel panic - not syncing: Fatal exception in
interrupt ]---



> Huacai
>
> On Thu, Feb 2, 2023 at 11:33 AM Jeff Xie <xiehuan09@gmail.com> wrote:
> >
> > On Thu, Feb 2, 2023 at 10:23 AM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
> > >
> > >
> > >
> > > On 02/01/2023 05:40 PM, Jeff Xie wrote:
> > > > On Wed, Feb 1, 2023 at 12:56 PM Huacai Chen <chenhuacai@kernel.org> wrote:
> > > >>
> > > >> Hi, Jeff,
> > > >>
> > > >> Could you please pay some time to test this series? Thank you.
> > > >
> > > > Thanks for notifying me about the test.
> > > >
> > > > I have tested the patchset(based on the
> > > > https://github.com/loongson/linux/tree/loongarch-next),
> > > > I found that some functions can't  be probed e.g. scheduler_tick() or
> > > > uart_write_wakeup()
> > > > the two functions have the same point,  they are all run in the hardirq context.
> > > >
> > > > I don't know if it's related to the hardirq context, I haven't had
> > > > time to study this patchset carefully.
> > > > and they can be probed in the x86_64 arch.
> > > >
> > > > root@loongarch modules]# insmod ./kprobe_example.ko symbol=scheduler_tick
> > > > insmod: can't insert './kprobe_example.ko': invalid parameter
> > > >
> > > > dmesg:
> > > > [   39.806435] kprobe_init: register_kprobe failed, returned -22
> > > >
> > >
> > > Thanks for your test.
> > >
> > > On my test environment, I can not reproduce the above issue,
> > > here are the test results, it seems no problem.
> > >
> > > [root@linux loongson]# dmesg -c
> > > [root@linux loongson]# uname -m
> > > loongarch64
> > > [root@linux loongson]# modprobe kprobe_example symbol=scheduler_tick
> > > [root@linux loongson]# rmmod kprobe_example
> > > [root@linux loongson]# dmesg | tail -2
> > > [ 3317.138086] handler_post: <scheduler_tick> p->addr =
> > > 0x0000000065d12f66, estat = 0xc0000
> > > [ 3317.154086] kprobe_exit: kprobe at 0000000065d12f66 unregistered
> > >
> > > [root@linux loongson]# dmesg -c
> > > [root@linux loongson]# uname -m
> > > loongarch64
> > > [root@linux loongson]# modprobe kprobe_example symbol=uart_write_wakeup
> > > [root@linux loongson]# rmmod kprobe_example
> > > [root@linux loongson]# dmesg | tail -2
> > > [ 3433.502092] handler_post: <uart_write_wakeup> p->addr =
> > > 0x0000000019718061, estat = 0xc0000
> > > [ 3433.762085] kprobe_exit: kprobe at 0000000019718061 unregistered
> > >
> > > Additionally, "register_kprobe failed, returned -22" means the symbol
> > > can not be probed, here is the related code:
> > >
> > > register_kprobe()
> > >    check_kprobe_address_safe()
> > >
> > > static int check_kprobe_address_safe(struct kprobe *p,
> > >                                      struct module **probed_mod)
> > > {
> > >         int ret;
> > >
> > >         ret = check_ftrace_location(p);
> > >         if (ret)
> > >                 return ret;
> > >         jump_label_lock();
> > >         preempt_disable();
> > >
> > >         /* Ensure it is not in reserved area nor out of text */
> > >         if (!(core_kernel_text((unsigned long) p->addr) ||
> > >             is_module_text_address((unsigned long) p->addr)) ||
> > >             in_gate_area_no_mm((unsigned long) p->addr) ||
> > >             within_kprobe_blacklist((unsigned long) p->addr) ||
> > >             jump_label_text_reserved(p->addr, p->addr) ||
> > >             static_call_text_reserved(p->addr, p->addr) ||
> > >             find_bug((unsigned long)p->addr)) {
> > >                 ret = -EINVAL;
> > >                 goto out;
> > >         }
> > > ...
> > > }
> >
> > Today I looked at the code, this has nothing to do with hardirq :-)
> > because I enabled this kernel option CONFIG_DYNAMIC_FTRACE, the
> > loongarch should not support the option yet.
> >
> > #ifdef CONFIG_DYNAMIC_FTRACE
> > unsigned long ftrace_location(unsigned long ip);
> >
> > #else /* CONFIG_DYNAMIC_FTRACE */
> >
> > static inline unsigned long ftrace_location(unsigned long ip)
> > {
> >         return 0;
> > }
> >
> > #endif
> >
> >
> > static int check_ftrace_location(struct kprobe *p)
> > {
> >         unsigned long addr = (unsigned long)p->addr;
> >
> >         if (ftrace_location(addr) == addr) {
> > #ifdef CONFIG_KPROBES_ON_FTRACE
> >                 p->flags |= KPROBE_FLAG_FTRACE;
> > #else   /* !CONFIG_KPROBES_ON_FTRACE */
> >                 return -EINVAL;  // get error from here
> > #endif
> >         }
> >         return 0;
> > }
> >
> > static int check_kprobe_address_safe(struct kprobe *p,
> >                                      struct module **probed_mod)
> > {
> >         int ret;
> >
> >         ret = check_ftrace_location(p);
> >         if (ret)
> >                 return ret; //  return -EINVAL
> > }
> >
> >
> > >
> > > Thanks,
> > > Tiezhu
> > >
> >
> >
> > --
> > Thanks,
> > JeffXie



-- 
Thanks,
JeffXie
