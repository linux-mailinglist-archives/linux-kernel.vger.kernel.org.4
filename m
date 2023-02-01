Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6A346862F7
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 10:40:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231717AbjBAJky (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 04:40:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbjBAJku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 04:40:50 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E408E5B584
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 01:40:48 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id e6so9658152plg.12
        for <linux-kernel@vger.kernel.org>; Wed, 01 Feb 2023 01:40:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SVuKRnPNvFjhzFwddZE2JiwECmbB5uSTQamVzWtgKyM=;
        b=M4znWT4pB0bTC5+RDVLLsP5OidE4lOZHR9IwVoepPCh6Cj3SIApx8Y5036lT188moF
         QGjucQH3/0TjsEtNkdh4J/jRhizrmHBLZvIOoPC6H1w1A87/WwTS3Pa5WgIs+IPobIZV
         4QNGZUMQIqXwGb0j5kCb3D2ARxTzidAqKy8BbfJB6bPl7nSHsYCPnMmYk/PXAgkyb1ph
         t/8EhOFQMHuMAeDWJGzDrOwqK2MLYo7NahRaPGXzEilNIjOSnKLLkU+PyeGyxPLrKa0E
         fPTETUB1BNmCizARrC+bQkfCPqoLfa0MFMMGsqzU57yhT3bUbW5vSThEn0nncGZl9ugW
         Tmdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SVuKRnPNvFjhzFwddZE2JiwECmbB5uSTQamVzWtgKyM=;
        b=Tn1OE556dDJ2Z2nI08WqSRCpJp+4eAFW+EVl7PMgYVn6baLH2o8kKPzGDP9rV1AP4J
         bVLxkpzE20YEOzbnu9X6FG+KeeuO2/RWJm8y0FuqpK4kdFRMNRr88yS3Ugs8TdnjjNDU
         aPvYaEANZwCpAy2lFYR04ynVARbYziyBbEtsulnQ6s9M32GjJ6JqRZBhQxBlUOo5ZxI6
         cIDgn4pltFC0DSqPLdxTOE8mI39dJYeKkv29GONaqHRDDb7U2vLtTSu/NmofofPAaZ46
         SVcSiST0VlomC+uhkihjjoJApzy81jEGawu+QHdxM3O8N/uRF/z3aJEDC+/NoWFUQ+EO
         YPEg==
X-Gm-Message-State: AO0yUKVutum5q8xYso8Tu3JfaLpOonsqa4nunhKECdFvM2D7G4NJ12Mn
        WvV48S5U3m4+dElEUShblW2+sAd/stHc4RlVl9s=
X-Google-Smtp-Source: AK7set9GuLsBgmgrccvhtmjOoyqG2yzJ9CrgB87F4+PToaU40CR/KDqCr/fZbRzdzjhIl+yiWt4Ao5MVnNImqlYEtFk=
X-Received: by 2002:a17:90a:aa87:b0:22c:890b:c5f7 with SMTP id
 l7-20020a17090aaa8700b0022c890bc5f7mr281858pjq.23.1675244448122; Wed, 01 Feb
 2023 01:40:48 -0800 (PST)
MIME-Version: 1.0
References: <1674007261-9198-1-git-send-email-yangtiezhu@loongson.cn>
 <CAAhV-H4aTd6_cSy45KKjv-KrLTiwT4iG6+fkb84KfCrL3Y+hpg@mail.gmail.com> <CAAhV-H5WN5E=0Z9wpbXDc6VO7Nc+j7PGvnyAAGOmCRMJkdwSYw@mail.gmail.com>
In-Reply-To: <CAAhV-H5WN5E=0Z9wpbXDc6VO7Nc+j7PGvnyAAGOmCRMJkdwSYw@mail.gmail.com>
From:   Jeff Xie <xiehuan09@gmail.com>
Date:   Wed, 1 Feb 2023 17:40:36 +0800
Message-ID: <CAEr6+ECO-=jfhzHrcdKGx0MsjMBMiN6wsBPCfv7CaXo_amAWWg@mail.gmail.com>
Subject: Re: [PATCH v12 0/5] Add kprobe and kretprobe support for LoongArch
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     Tiezhu Yang <yangtiezhu@loongson.cn>,
        WANG Xuerui <kernel@xen0n.name>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 1, 2023 at 12:56 PM Huacai Chen <chenhuacai@kernel.org> wrote:
>
> Hi, Jeff,
>
> Could you please pay some time to test this series? Thank you.

Thanks for notifying me about the test.

I have tested the patchset(based on the
https://github.com/loongson/linux/tree/loongarch-next),
I found that some functions can't  be probed e.g. scheduler_tick() or
uart_write_wakeup()
the two functions have the same point,  they are all run in the hardirq context.

I don't know if it's related to the hardirq context, I haven't had
time to study this patchset carefully.
and they can be probed in the x86_64 arch.

root@loongarch modules]# insmod ./kprobe_example.ko symbol=scheduler_tick
insmod: can't insert './kprobe_example.ko': invalid parameter

dmesg:
[   39.806435] kprobe_init: register_kprobe failed, returned -22


>
> Huacai
>
> On Wed, Jan 18, 2023 at 11:30 AM Huacai Chen <chenhuacai@kernel.org> wrote:
> >
> > Hi, Masami,
> >
> > Could you please pay some time to review this series? Thank you.
> >
> > Huacai
> >
> > On Wed, Jan 18, 2023 at 10:01 AM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
> > >
> > > v12:
> > >   -- Rebase on the latest code
> > >   -- Fix -Wmissing-prototypes warning when make W=1
> > >   -- Drop patch #6 "Use common function sign_extend64()"
> > >      since it has been applied yet
> > >
> > > v11:
> > >   -- Rebase on the latest code
> > >   -- Address all the review comments, thank you all
> > >   -- Modify arch_prepare_kprobe() and setup_singlestep()
> > >      to make the probe logic more clear
> > >   -- Mark some assembler symbols as non-kprobe-able
> > >   -- Use common function sign_extend64()
> > >   -- Test 20 times about 36 hours for all the 71 assembler
> > >      functions annotated with SYM_CODE_START and SYM_FUNC_START
> > >      under arch/loongarch, especially test memset alone for 10
> > >      hours, no hang problems
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
> > > Tiezhu Yang (5):
> > >   LoongArch: Simulate branch and PC* instructions
> > >   LoongArch: Add kprobe support
> > >   LoongArch: Add kretprobe support
> > >   LoongArch: Mark some assembler symbols as non-kprobe-able
> > >   samples/kprobes: Add LoongArch support
> > >
> > >  arch/loongarch/Kconfig                     |   2 +
> > >  arch/loongarch/include/asm/asm.h           |  10 +
> > >  arch/loongarch/include/asm/inst.h          |  20 ++
> > >  arch/loongarch/include/asm/kprobes.h       |  61 +++++
> > >  arch/loongarch/include/asm/ptrace.h        |   1 +
> > >  arch/loongarch/kernel/Makefile             |   2 +
> > >  arch/loongarch/kernel/entry.S              |   1 +
> > >  arch/loongarch/kernel/inst.c               | 123 +++++++++
> > >  arch/loongarch/kernel/kprobes.c            | 405 +++++++++++++++++++++++++++++
> > >  arch/loongarch/kernel/kprobes_trampoline.S |  96 +++++++
> > >  arch/loongarch/kernel/traps.c              |  11 +-
> > >  arch/loongarch/lib/memcpy.S                |   3 +
> > >  arch/loongarch/mm/fault.c                  |   3 +
> > >  samples/kprobes/kprobe_example.c           |   8 +
> > >  14 files changed, 741 insertions(+), 5 deletions(-)
> > >  create mode 100644 arch/loongarch/include/asm/kprobes.h
> > >  create mode 100644 arch/loongarch/kernel/kprobes.c
> > >  create mode 100644 arch/loongarch/kernel/kprobes_trampoline.S
> > >
> > > --
> > > 2.1.0
> > >
> > >



-- 
Thanks,
JeffXie
