Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 447C7648F1D
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Dec 2022 15:07:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbiLJOHd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Dec 2022 09:07:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbiLJOGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Dec 2022 09:06:38 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D46318E0A
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 06:03:03 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id 62so5338143pgb.13
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 06:03:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UaR6A5lOJuxq2TDA8bCpWrZebNLPRf+mo+8EFGWYDjI=;
        b=jVarftiIsUKe4oUm0+iOvIJrTMCBL5LtSeCvNPiBKivy8Y9EKQFEKDEvLbFaPpLyEl
         z5te5eqFluV7gWGI295Y/43mN2CV1RKYW1/0N18c8dQUA/Q/M5nM22L8PZcZG7V0Mgi2
         huautCDQlJbi3FVnnXy2i8umhUyPjcbhqQWCCE9fVzFzvml+A6fB3hHhrgZvPXw7uMcU
         xI6gRNVG1nwuN94fyBZ7HUwHvpkDnds+c+CZ2SDkVntqx2P5h61cL8Y3e1Evdhotie88
         GEp4Bk9eN7xFwA9OSPMJ9FS0mhjWnQ0urbYnDc+s1gBBsAIUQWVc4dteuicLVCLcP6FD
         7QUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UaR6A5lOJuxq2TDA8bCpWrZebNLPRf+mo+8EFGWYDjI=;
        b=z9dshTXYSfZKM+5QWj1GDrHwO6GIudXErmNSxr6PPUpyOlhHJYNPQQ0op2EmdrNlwu
         6nIhzm4E31rhFoOLAqE8TWZLBohyYlEMVSUXVGYv6gdAZ5wmgmUE4JNnx62ax4+4nise
         CEXjDxpG6dCC8PNc8CXpBzQVBf8YT7fICBLZd4tlZcefd/+a3IqnoosTGIrMte85giM0
         4jHQ0LV4qY50qoNFv5p9rvx/W3V9KslRlyFGpvnLJY+0SmwaHaSp8inBbl98ObpFLDCi
         zXY/o6w01m0MoPBT5G+wWzXxgayn9D+AzA5rPRnzipJ+k0mNs/t6g+e2OS49D2RTHYSX
         n2MQ==
X-Gm-Message-State: ANoB5pn0KiYKpQB3gRxLNL98iDtyj3UPPZJ9jcL4rZ66sLY6iPHax/Io
        3jadAzNZVBP338WpFw88SJkCFV5+/AWC7877NXbIzY60PMyXYQ==
X-Google-Smtp-Source: AA0mqf6b7ZTj017Mu7LQIgO/MQmzZ+I/rXNdKSwu8/8itg8SrOMP9Ol22Co6/iGAHYSlfZOn47uBgB966trTFmTHiqU=
X-Received: by 2002:a63:3153:0:b0:478:9503:f498 with SMTP id
 x80-20020a633153000000b004789503f498mr23993265pgx.96.1670680486804; Sat, 10
 Dec 2022 05:54:46 -0800 (PST)
MIME-Version: 1.0
References: <1670575981-14389-1-git-send-email-yangtiezhu@loongson.cn> <CAAhV-H6e2HzXs9PCcdnebPBvGZrx5vRXji1vGXfPwkEihBOiKA@mail.gmail.com>
In-Reply-To: <CAAhV-H6e2HzXs9PCcdnebPBvGZrx5vRXji1vGXfPwkEihBOiKA@mail.gmail.com>
From:   Jeff Xie <xiehuan09@gmail.com>
Date:   Sat, 10 Dec 2022 21:54:34 +0800
Message-ID: <CAEr6+EC2wPAtK8zb3=e1mUiya3gv0UhqF9J_ySYx9p_96pB+tg@mail.gmail.com>
Subject: Re: [PATCH v10 0/4] Add kprobe and kretprobe support for LoongArch
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     Tiezhu Yang <yangtiezhu@loongson.cn>,
        WANG Xuerui <kernel@xen0n.name>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
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

On Fri, Dec 9, 2022 at 6:01 PM Huacai Chen <chenhuacai@kernel.org> wrote:
>
> Hi, Masami,
>
> This series looks good to me now, but I'm not familiar with kprobes.
> So, if you have any comments, please let me know.
>
> And Jeff,
>
> As we all know, you are an expert in this domain, so could you please
> help me to test this series?
>
> If there are no objections, I plan to merge this series in a few days.
> But since the next merge window will be open soon, if there are any
> problems, I will revert the patches to wait for the next cycle.

I can't use the kprobe function normally now, tested the function from
the branch: https://github.com/loongson/linux/commits/loongarch-next

steps:
1. Try to probe __memset_fast()

[root@loongarch ]# cat /proc/kallsyms | grep __memset_fast
90000000012c75f0 T __memset_fast

./samples/kprobes/kprobe_example.c
static char symbol[KSYM_NAME_LEN] =3D "__memset_fast";

2. Loading the kprobe_example.ko
[root@loongarch mnt]# insmod ./kprobe_example.ko

*** The system will keep hanging ***

dmesg-messages:
gef=E2=9E=A4  lx-dmesg
[   12.348047] handler_pre: <__memset_fast> p->addr =3D
0x(____ptrval____), era =3D 0x90000000012c75f0, estat =3D 0xc0000
[   12.348512] handler_post: <__memset_fast> p->addr =3D
0x(____ptrval____), estat =3D 0xc0000
[   12.348525] handler_post: <__memset_fast> p->addr =3D
0x(____ptrval____), estat =3D 0xc0000
[   12.349248] handler_pre: <__memset_fast> p->addr =3D
0x(____ptrval____), era =3D 0x90000000012c75f0, estat =3D 0xc0000
[   12.349259] handler_post: <__memset_fast> p->addr =3D
0x(____ptrval____), estat =3D 0xc0000

call trace:
gef=E2=9E=A4  bt
#0  0x90000000012f45f8 in queued_spin_lock_slowpath
(lock=3D0x9000000001cc0018 <die_lock>, val=3D0x1) at
kernel/locking/qspinlock.c:383
#1  0x9000000000223b2c in die (str=3Dstr@entry=3D0x90000000017e3488 "Break
instruction in kernel code", regs=3Dregs@entry=3D0x900000010fd735f0) at
arch/loongarch/kernel/traps.c:240
#2  0x90000000012e3968 in die_if_kernel (regs=3D<optimized out>,
str=3D<optimized out>) at ./arch/loongarch/include/asm/ptrace.h:131
#3  do_bp (regs=3D0x900000010fd735f0) at arch/loongarch/kernel/traps.c:485
#4  0x9000000001cb1924 in exception_handlers ()
Backtrace stopped: frame did not save the PC



> Thanks,
> Huacai
>
> On Fri, Dec 9, 2022 at 4:53 PM Tiezhu Yang <yangtiezhu@loongson.cn> wrote=
:
> >
> > v10:
> >   -- Remove sign_extend() based on the latest code
> >   -- Rename insns_are_not_supported() to insns_not_supported()
> >   -- Rename insns_are_not_simulated() to insns_not_simulated()
> >   -- Set KPROBE_HIT_SSDONE if cur->post_handler is not NULL
> >   -- Enable preemption for KPROBE_REENTER in kprobe_fault_handler()
> >
> > v9:
> >   -- Rename sign_extended() to sign_extend()
> >   -- Modify kprobe_fault_handler() to handle all of kprobe_status
> >
> > v8:
> >   -- Put "regs->csr_prmd &=3D ~CSR_PRMD_PIE;" ahead to save one line
> >   -- Add code comment of preempt_disable()
> >   -- Put kprobe_page_fault() in __do_page_fault()
> >   -- Modify the check condition of break insn in kprobe_breakpoint_hand=
ler()
> >
> > v7:
> >   -- Remove stop_machine_cpuslocked() related code
> >
> > v6:
> >   -- Add a new patch to redefine larch_insn_patch_text() with
> >      stop_machine_cpuslocked()
> >   -- Modify kprobe_breakpoint_handler() to consider the original
> >      insn is break and return the correct value
> >   -- Modify do_bp() to refresh bcode when original insn is break
> >
> > v5:
> >   -- Rebase on the latest code
> >   -- Use stop_machine_cpuslocked() to modify insn to avoid CPU race
> >
> > v4:
> >   -- Remove kprobe_exceptions_notify() in kprobes.c
> >   -- Call kprobe_breakpoint_handler() and kprobe_singlestep_handler()
> >      in do_bp()
> >
> > v3:
> >   -- Rebase on the latest code
> >   -- Check the alignment of PC in simu_branch() and simu_pc()
> >   -- Add ibar in flush_insn_slot()
> >   -- Rename kprobe_{pre,post}_handler() to {post_}kprobe_handler
> >   -- Add preempt_disable() and preempt_enable_no_resched()
> >   -- Remove r0 save/restore and do some minor changes
> >      in kprobes_trampoline.S
> >   -- Do not enable CONFIG_KPROBES by default
> >
> > v2:
> >   -- Split simu_branch() and simu_pc() into a single patch
> >   -- Call kprobe_page_fault() in do_page_fault()
> >   -- Add kprobes_trampoline.S for kretprobe
> >
> > Tiezhu Yang (4):
> >   LoongArch: Simulate branch and PC instructions
> >   LoongArch: Add kprobe support
> >   LoongArch: Add kretprobe support
> >   samples/kprobes: Add LoongArch support
> >
> >  arch/loongarch/Kconfig                     |   2 +
> >  arch/loongarch/include/asm/inst.h          |  20 ++
> >  arch/loongarch/include/asm/kprobes.h       |  59 +++++
> >  arch/loongarch/include/asm/ptrace.h        |   1 +
> >  arch/loongarch/kernel/Makefile             |   2 +
> >  arch/loongarch/kernel/inst.c               | 123 ++++++++++
> >  arch/loongarch/kernel/kprobes.c            | 364 +++++++++++++++++++++=
++++++++
> >  arch/loongarch/kernel/kprobes_trampoline.S |  96 ++++++++
> >  arch/loongarch/kernel/traps.c              |  13 +-
> >  arch/loongarch/mm/fault.c                  |   3 +
> >  samples/kprobes/kprobe_example.c           |   8 +
> >  11 files changed, 687 insertions(+), 4 deletions(-)
> >  create mode 100644 arch/loongarch/include/asm/kprobes.h
> >  create mode 100644 arch/loongarch/kernel/kprobes.c
> >  create mode 100644 arch/loongarch/kernel/kprobes_trampoline.S
> >
> > --
> > 2.1.0
> >



--=20
Thanks,
JeffXie
