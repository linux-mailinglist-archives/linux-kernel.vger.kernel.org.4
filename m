Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 873DC64F705
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Dec 2022 03:28:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbiLQC26 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 21:28:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbiLQC24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 21:28:56 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FB78B4A2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 18:28:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1A7BF62303
        for <linux-kernel@vger.kernel.org>; Sat, 17 Dec 2022 02:28:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D51FC433D2
        for <linux-kernel@vger.kernel.org>; Sat, 17 Dec 2022 02:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671244134;
        bh=VUCG53a4oSTambxnA8+oZoRvt/KCrHqzj/6JzMamBjE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=VT+Chgfespi5HOXvy6itfep9bRe9jovMb097pqj5dBtqfrYHq9hblchwHSgukkKSi
         NsOi0gS/u1uVY5yeGzGblJsywfmIMqIa4Vri5IHL35bjqQconKIRyBhAzAl0UmQtQ7
         xFNyrUjaRKvA1W+orFsnhqjP1QxonlVWviO9oRRKwIWQ063cMJoh1Vvcx/AlrnNaJU
         UdcALDyRyAA4aZ1Af0jClJd83JOVBvLzjybgXm4jXP+PIy6OvErm30G5iTG7tOY914
         hPZ6rMfnYKlvacX/O31ItYhZJUnYnBCMxEnDZCAjs1Rx/B2wsjJ1lNtD/JiDxEigc4
         PnJf1rcHYQIJg==
Received: by mail-ej1-f49.google.com with SMTP id m18so10178947eji.5
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 18:28:54 -0800 (PST)
X-Gm-Message-State: ANoB5pl7e1QmbiDYgFzL2aS04Ihl0F13zAC4vVVyB5KvvxTpwJIQySnL
        oCjrhIheFmQ5r3nR5mf0jlLh74Q2I6tIrR3DDAc=
X-Google-Smtp-Source: AA0mqf47+ply9VSRHBd31O/9oVUprEm9hsCBrufNSvw/MZ0x3HrBwvtNwRoQ04aUf+l6sk/cBdptSO1/Kq9+E8lsgGw=
X-Received: by 2002:a17:906:f116:b0:7c1:764:5e08 with SMTP id
 gv22-20020a170906f11600b007c107645e08mr12599889ejb.72.1671244132633; Fri, 16
 Dec 2022 18:28:52 -0800 (PST)
MIME-Version: 1.0
References: <1670575981-14389-1-git-send-email-yangtiezhu@loongson.cn>
 <CAAhV-H6e2HzXs9PCcdnebPBvGZrx5vRXji1vGXfPwkEihBOiKA@mail.gmail.com> <20221213121013.b09182c5842171f3f25a2e59@kernel.org>
In-Reply-To: <20221213121013.b09182c5842171f3f25a2e59@kernel.org>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Sat, 17 Dec 2022 10:28:44 +0800
X-Gmail-Original-Message-ID: <CAAhV-H45RvQB=ntmw8muqpxUhpt=hR+gCDs0BGXnhJHSquRU3g@mail.gmail.com>
Message-ID: <CAAhV-H45RvQB=ntmw8muqpxUhpt=hR+gCDs0BGXnhJHSquRU3g@mail.gmail.com>
Subject: Re: [PATCH v10 0/4] Add kprobe and kretprobe support for LoongArch
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Tiezhu Yang <yangtiezhu@loongson.cn>,
        Jeff Xie <xiehuan09@gmail.com>,
        WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Masami,

On Tue, Dec 13, 2022 at 11:10 AM Masami Hiramatsu <mhiramat@kernel.org> wrote:
>
> On Fri, 9 Dec 2022 18:01:44 +0800
> Huacai Chen <chenhuacai@kernel.org> wrote:
>
> > Hi, Masami,
> >
> > This series looks good to me now, but I'm not familiar with kprobes.
> > So, if you have any comments, please let me know.
>
> Sorry I missed this series. Let me add some comments.
> BTW, I don't have any board to run the loongarch, so I'll make
> comments just about style issues.
You needn't say sorry, and you can use qemu to run loongarch if needed.

Huacai
>
> Thanks,
>
> >
> > And Jeff,
> >
> > As we all know, you are an expert in this domain, so could you please
> > help me to test this series?
> >
> > If there are no objections, I plan to merge this series in a few days.
> > But since the next merge window will be open soon, if there are any
> > problems, I will revert the patches to wait for the next cycle.
> >
> > Thanks,
> > Huacai
> >
> > On Fri, Dec 9, 2022 at 4:53 PM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
> > >
> > > v10:
> > >   -- Remove sign_extend() based on the latest code
> > >   -- Rename insns_are_not_supported() to insns_not_supported()
> > >   -- Rename insns_are_not_simulated() to insns_not_simulated()
> > >   -- Set KPROBE_HIT_SSDONE if cur->post_handler is not NULL
> > >   -- Enable preemption for KPROBE_REENTER in kprobe_fault_handler()
> > >
> > > v9:
> > >   -- Rename sign_extended() to sign_extend()
> > >   -- Modify kprobe_fault_handler() to handle all of kprobe_status
> > >
> > > v8:
> > >   -- Put "regs->csr_prmd &= ~CSR_PRMD_PIE;" ahead to save one line
> > >   -- Add code comment of preempt_disable()
> > >   -- Put kprobe_page_fault() in __do_page_fault()
> > >   -- Modify the check condition of break insn in kprobe_breakpoint_handler()
> > >
> > > v7:
> > >   -- Remove stop_machine_cpuslocked() related code
> > >
> > > v6:
> > >   -- Add a new patch to redefine larch_insn_patch_text() with
> > >      stop_machine_cpuslocked()
> > >   -- Modify kprobe_breakpoint_handler() to consider the original
> > >      insn is break and return the correct value
> > >   -- Modify do_bp() to refresh bcode when original insn is break
> > >
> > > v5:
> > >   -- Rebase on the latest code
> > >   -- Use stop_machine_cpuslocked() to modify insn to avoid CPU race
> > >
> > > v4:
> > >   -- Remove kprobe_exceptions_notify() in kprobes.c
> > >   -- Call kprobe_breakpoint_handler() and kprobe_singlestep_handler()
> > >      in do_bp()
> > >
> > > v3:
> > >   -- Rebase on the latest code
> > >   -- Check the alignment of PC in simu_branch() and simu_pc()
> > >   -- Add ibar in flush_insn_slot()
> > >   -- Rename kprobe_{pre,post}_handler() to {post_}kprobe_handler
> > >   -- Add preempt_disable() and preempt_enable_no_resched()
> > >   -- Remove r0 save/restore and do some minor changes
> > >      in kprobes_trampoline.S
> > >   -- Do not enable CONFIG_KPROBES by default
> > >
> > > v2:
> > >   -- Split simu_branch() and simu_pc() into a single patch
> > >   -- Call kprobe_page_fault() in do_page_fault()
> > >   -- Add kprobes_trampoline.S for kretprobe
> > >
> > > Tiezhu Yang (4):
> > >   LoongArch: Simulate branch and PC instructions
> > >   LoongArch: Add kprobe support
> > >   LoongArch: Add kretprobe support
> > >   samples/kprobes: Add LoongArch support
> > >
> > >  arch/loongarch/Kconfig                     |   2 +
> > >  arch/loongarch/include/asm/inst.h          |  20 ++
> > >  arch/loongarch/include/asm/kprobes.h       |  59 +++++
> > >  arch/loongarch/include/asm/ptrace.h        |   1 +
> > >  arch/loongarch/kernel/Makefile             |   2 +
> > >  arch/loongarch/kernel/inst.c               | 123 ++++++++++
> > >  arch/loongarch/kernel/kprobes.c            | 364 +++++++++++++++++++++++++++++
> > >  arch/loongarch/kernel/kprobes_trampoline.S |  96 ++++++++
> > >  arch/loongarch/kernel/traps.c              |  13 +-
> > >  arch/loongarch/mm/fault.c                  |   3 +
> > >  samples/kprobes/kprobe_example.c           |   8 +
> > >  11 files changed, 687 insertions(+), 4 deletions(-)
> > >  create mode 100644 arch/loongarch/include/asm/kprobes.h
> > >  create mode 100644 arch/loongarch/kernel/kprobes.c
> > >  create mode 100644 arch/loongarch/kernel/kprobes_trampoline.S
> > >
> > > --
> > > 2.1.0
> > >
>
>
> --
> Masami Hiramatsu (Google) <mhiramat@kernel.org>
