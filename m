Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9EB6615005
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 18:08:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbiKARIL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 13:08:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbiKARIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 13:08:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F399D8B
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 10:08:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 25EC261656
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 17:08:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54410C433D6;
        Tue,  1 Nov 2022 17:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667322481;
        bh=2Y4FXSKTEjF1qcYmzzsY+q+7a2NVRoQEVXrR1FcCVUw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tA0ddphq6ZwqaV0xWZCkp4pEcY+OkbDE5oOQ20B1NJIg0FozRlhFhoyURR1kcsuxF
         UEDIX59usJVYSRW10N+LTLu7FEP2dnpLIdBBv6r/wUpIxp3eThbdqrsCGZk5e0JxTV
         KDhO5w3b2LhVhBaVCyPfwc+N1LpT6Z8T4Xui5tvJAllXrfXW0YdW9lpVfHZ0xCnh14
         u2JKSYVFyoMnXyPGWJxU9VqYUaUkqfBsnedrUtAYXZAr5LwqM5VsS/yOUNw0h7pM5g
         5Ce//sdIikux7UK1eMgr1xDJhxg0I0iG5isX4uFKJMFNBX63Gp5erpr+Gc9umYqxo2
         pq1za7wo5ObLA==
Date:   Tue, 1 Nov 2022 17:07:56 +0000
From:   Conor Dooley <conor@kernel.org>
To:     binglei wang <l3b2w1@gmail.com>
Cc:     aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com,
        anil.s.keshavamurthy@intel.com, davem@davemloft.net,
        linux-kernel@vger.kernel.org, mhiramat@kernel.org,
        naveen.n.rao@linux.ibm.com,
        Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH RESEND v9] riscv: add riscv rethook implementation
Message-ID: <Y2FSbEaOhkYeqkEb@spud>
References: <20221025151831.1097417-1-conor@kernel.org>
 <CAJ3C4KygPPaxK55oZFcaXLpr0PaUvvY1qj_5i47TkV1Tm7G-uQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ3C4KygPPaxK55oZFcaXLpr0PaUvvY1qj_5i47TkV1Tm7G-uQ@mail.gmail.com>
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 01, 2022 at 09:40:23PM +0800, binglei wang wrote:
> Hi Conor,
> 
> Thanks for your resending.
> What to do next is just to wait patently, right ?

Yup.. You'll get at least one email when it gets applied.
It's in patchwork [0] so it should not get forgotten about.

0 - https://patchwork.kernel.org/project/linux-riscv/patch/20221025151831.1097417-1-conor@kernel.org/

> 
> Binglei Wang
> Best wishes.
> 
> 
> Conor Dooley <conor@kernel.org> 于2022年10月25日周二 23:19写道：
> >
> > From: Binglei Wang <l3b2w1@gmail.com>
> >
> > Implement the kretprobes on riscv arch by using rethook machenism
> > which abstracts general kretprobe info into a struct rethook_node
> > to be embedded in the struct kretprobe_instance.
> >
> > Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > Signed-off-by: Binglei Wang <l3b2w1@gmail.com>
> > Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> > ---
> > Binglei's patches do not seem to make it to the linux-riscv list, so
> > blindly resending on their behalf, with Masami's ack from v8 added.
> >
> >  arch/riscv/Kconfig                            |  1 +
> >  arch/riscv/include/asm/kprobes.h              |  2 --
> >  arch/riscv/kernel/probes/Makefile             |  2 +-
> >  arch/riscv/kernel/probes/kprobes.c            | 13 ---------
> >  arch/riscv/kernel/probes/rethook.c            | 27 +++++++++++++++++++
> >  arch/riscv/kernel/probes/rethook.h            |  8 ++++++
> >  ...obes_trampoline.S => rethook_trampoline.S} |  6 ++---
> >  7 files changed, 40 insertions(+), 19 deletions(-)
> >  create mode 100644 arch/riscv/kernel/probes/rethook.c
> >  create mode 100644 arch/riscv/kernel/probes/rethook.h
> >  rename arch/riscv/kernel/probes/{kprobes_trampoline.S => rethook_trampoline.S} (94%)
> >
> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > index 6b48a3ae9843..413aeca71ca0 100644
> > --- a/arch/riscv/Kconfig
> > +++ b/arch/riscv/Kconfig
> > @@ -99,6 +99,7 @@ config RISCV
> >         select HAVE_KPROBES if !XIP_KERNEL
> >         select HAVE_KPROBES_ON_FTRACE if !XIP_KERNEL
> >         select HAVE_KRETPROBES if !XIP_KERNEL
> > +       select HAVE_RETHOOK if !XIP_KERNEL
> >         select HAVE_MOVE_PMD
> >         select HAVE_MOVE_PUD
> >         select HAVE_PCI
> > diff --git a/arch/riscv/include/asm/kprobes.h b/arch/riscv/include/asm/kprobes.h
> > index 217ef89f22b9..e7882ccb0fd4 100644
> > --- a/arch/riscv/include/asm/kprobes.h
> > +++ b/arch/riscv/include/asm/kprobes.h
> > @@ -40,8 +40,6 @@ void arch_remove_kprobe(struct kprobe *p);
> >  int kprobe_fault_handler(struct pt_regs *regs, unsigned int trapnr);
> >  bool kprobe_breakpoint_handler(struct pt_regs *regs);
> >  bool kprobe_single_step_handler(struct pt_regs *regs);
> > -void __kretprobe_trampoline(void);
> > -void __kprobes *trampoline_probe_handler(struct pt_regs *regs);
> >
> >  #endif /* CONFIG_KPROBES */
> >  #endif /* _ASM_RISCV_KPROBES_H */
> > diff --git a/arch/riscv/kernel/probes/Makefile b/arch/riscv/kernel/probes/Makefile
> > index 7f0840dcc31b..c40139e9ca47 100644
> > --- a/arch/riscv/kernel/probes/Makefile
> > +++ b/arch/riscv/kernel/probes/Makefile
> > @@ -1,6 +1,6 @@
> >  # SPDX-License-Identifier: GPL-2.0
> >  obj-$(CONFIG_KPROBES)          += kprobes.o decode-insn.o simulate-insn.o
> > -obj-$(CONFIG_KPROBES)          += kprobes_trampoline.o
> > +obj-$(CONFIG_RETHOOK)          += rethook.o rethook_trampoline.o
> >  obj-$(CONFIG_KPROBES_ON_FTRACE)        += ftrace.o
> >  obj-$(CONFIG_UPROBES)          += uprobes.o decode-insn.o simulate-insn.o
> >  CFLAGS_REMOVE_simulate-insn.o = $(CC_FLAGS_FTRACE)
> > diff --git a/arch/riscv/kernel/probes/kprobes.c b/arch/riscv/kernel/probes/kprobes.c
> > index e6e950b7cf32..f21592d20306 100644
> > --- a/arch/riscv/kernel/probes/kprobes.c
> > +++ b/arch/riscv/kernel/probes/kprobes.c
> > @@ -345,19 +345,6 @@ int __init arch_populate_kprobe_blacklist(void)
> >         return ret;
> >  }
> >
> > -void __kprobes __used *trampoline_probe_handler(struct pt_regs *regs)
> > -{
> > -       return (void *)kretprobe_trampoline_handler(regs, NULL);
> > -}
> > -
> > -void __kprobes arch_prepare_kretprobe(struct kretprobe_instance *ri,
> > -                                     struct pt_regs *regs)
> > -{
> > -       ri->ret_addr = (kprobe_opcode_t *)regs->ra;
> > -       ri->fp = NULL;
> > -       regs->ra = (unsigned long) &__kretprobe_trampoline;
> > -}
> > -
> >  int __kprobes arch_trampoline_kprobe(struct kprobe *p)
> >  {
> >         return 0;
> > diff --git a/arch/riscv/kernel/probes/rethook.c b/arch/riscv/kernel/probes/rethook.c
> > new file mode 100644
> > index 000000000000..5c27c1f50989
> > --- /dev/null
> > +++ b/arch/riscv/kernel/probes/rethook.c
> > @@ -0,0 +1,27 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Generic return hook for riscv.
> > + */
> > +
> > +#include <linux/kprobes.h>
> > +#include <linux/rethook.h>
> > +#include "rethook.h"
> > +
> > +/* This is called from arch_rethook_trampoline() */
> > +unsigned long __used arch_rethook_trampoline_callback(struct pt_regs *regs)
> > +{
> > +       return rethook_trampoline_handler(regs, regs->s0);
> > +}
> > +
> > +NOKPROBE_SYMBOL(arch_rethook_trampoline_callback);
> > +
> > +void arch_rethook_prepare(struct rethook_node *rhn, struct pt_regs *regs, bool mcount)
> > +{
> > +       rhn->ret_addr = regs->ra;
> > +       rhn->frame = regs->s0;
> > +
> > +       /* replace return addr with trampoline */
> > +       regs->ra = (unsigned long)arch_rethook_trampoline;
> > +}
> > +
> > +NOKPROBE_SYMBOL(arch_rethook_prepare);
> > diff --git a/arch/riscv/kernel/probes/rethook.h b/arch/riscv/kernel/probes/rethook.h
> > new file mode 100644
> > index 000000000000..4758f7e3ce88
> > --- /dev/null
> > +++ b/arch/riscv/kernel/probes/rethook.h
> > @@ -0,0 +1,8 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +#ifndef __RISCV_RETHOOK_H
> > +#define __RISCV_RETHOOK_H
> > +
> > +unsigned long arch_rethook_trampoline_callback(struct pt_regs *regs);
> > +void arch_rethook_prepare(struct rethook_node *rhn, struct pt_regs *regs, bool mcount);
> > +
> > +#endif
> > diff --git a/arch/riscv/kernel/probes/kprobes_trampoline.S b/arch/riscv/kernel/probes/rethook_trampoline.S
> > similarity index 94%
> > rename from arch/riscv/kernel/probes/kprobes_trampoline.S
> > rename to arch/riscv/kernel/probes/rethook_trampoline.S
> > index 7bdb09ded39b..21bac92a170a 100644
> > --- a/arch/riscv/kernel/probes/kprobes_trampoline.S
> > +++ b/arch/riscv/kernel/probes/rethook_trampoline.S
> > @@ -75,13 +75,13 @@
> >         REG_L x31, PT_T6(sp)
> >         .endm
> >
> > -ENTRY(__kretprobe_trampoline)
> > +ENTRY(arch_rethook_trampoline)
> >         addi sp, sp, -(PT_SIZE_ON_STACK)
> >         save_all_base_regs
> >
> >         move a0, sp /* pt_regs */
> >
> > -       call trampoline_probe_handler
> > +       call arch_rethook_trampoline_callback
> >
> >         /* use the result as the return-address */
> >         move ra, a0
> > @@ -90,4 +90,4 @@ ENTRY(__kretprobe_trampoline)
> >         addi sp, sp, PT_SIZE_ON_STACK
> >
> >         ret
> > -ENDPROC(__kretprobe_trampoline)
> > +ENDPROC(arch_rethook_trampoline)
> > --
> > 2.38.0
> >
