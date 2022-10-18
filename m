Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE488602DF2
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 16:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbiJROJa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 10:09:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230227AbiJROJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 10:09:09 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9FC47C1BA
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 07:09:07 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id 81so17106116ybf.7
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 07:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GxcW3snRKlPGexnRm5y5CkCZA+BZ2Ovxaajki4NKkPw=;
        b=or40Ms1ADDiSkY38ApgUQPsXy1qAeNK4yDuXh7pwzTFOe2s4lfjgpeze5yZPLMHNXs
         hCUbvmXYkblh0Eu3JhZviU4XjaMbhpuKBPXGqJVadNgMB1OzeVKeR7KWk/VR3cMCo0Nk
         nJaQdioeptHKBor7B33vS9Ts8TdPrE3O7TKMV7JTkxdSELJemMTxQqw5pJFgZ1Ilrqx4
         5RkTOiNF2VbYHv8rFzmpF4XKWMxsTvhnZmVGvUrSc48TTupSAhx5HEM+mJ1W/vUhx06v
         w0va5vINH0YfTCLbXN6edlCdFG9XbQ9xwyNprW7AI29dDl84o8IScxqqia2+liGUnfl0
         PtdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GxcW3snRKlPGexnRm5y5CkCZA+BZ2Ovxaajki4NKkPw=;
        b=weSJsg9Cn8YAL0leTRz6ic25ImZNHSXYRgsEsQCTAOZlDKvO7BcwoyfcTmc+agM5pc
         lqWfPz6h5svPLBkKpvV1MKd2+L9aFAXNj0Pkk2G1ULfIXVCLpd4sp4yjaz94Ibw5HN9E
         OD0qd8/0Z472hUOfgeSsRDyIy3k2fQIJoVqD+9hhWXgh2vRgZOLIFNHfNfQ9B0uTnqIc
         bxhW5AxU7wFuzVeC+taW556yJ+kGY6meYLb7B39sOURlie87bp0SPvEhDn923qg0SQ/+
         jCRXvuGclp4mEi38dM5bIEkY5mFGi18g9P91dsI45jLBR63/8sDp9A44T2BrHbwHnNjP
         g+Nw==
X-Gm-Message-State: ACrzQf3e8Umh8ohyJbEwZ0OX4LTQdJEwnUQuXm54gibreCc0d3uqI8sK
        gC/bIO838mGzquTk770mPoMisnoUSJzju9cdU3E=
X-Google-Smtp-Source: AMsMyM7+nhKUDi77TdPtszlaguZty9qUAqfIBZUXdM52dwk3QOfM6M3T2rD0XRNgKagQB7lp2+g1QKjIAuSwq9lVwbA=
X-Received: by 2002:a25:6ac2:0:b0:6c0:efe6:462 with SMTP id
 f185-20020a256ac2000000b006c0efe60462mr2589425ybc.9.1666102146890; Tue, 18
 Oct 2022 07:09:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220930081357.651914-1-l3b2w1@gmail.com> <Yzm+z+mv/VSA+5hg@spud>
 <CAJ3C4KzyAR7dKYFBKHzFEXr-dzr-JMGRFVx+dybMhRPy0uHUgA@mail.gmail.com> <Y01tdcRRFBdOmaYc@spud>
In-Reply-To: <Y01tdcRRFBdOmaYc@spud>
From:   binglei wang <l3b2w1@gmail.com>
Date:   Tue, 18 Oct 2022 22:08:55 +0800
Message-ID: <CAJ3C4Kwj0yYS5JCPw=g0X9qiQhw04iKy_cTjc0x8iWdy0ay7bg@mail.gmail.com>
Subject: Re: [PATCH v8] rethook: add riscv rethook implementation
To:     Conor Dooley <conor@kernel.org>
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, naveen.n.rao@linux.ibm.com,
        anil.s.keshavamurthy@intel.com, davem@davemloft.net,
        mhiramat@kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
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

Hi Conor:
Thank you for your help to check the merging process for this patch.

> Thread overview: 3+ messages (download: mbox.gz / follow: Atom feed)
> -- links below jump to the message on this page --
>      [not found] <20220930081357.651914-1-l3b2w1@gmail.com>
I have no idea what this means, I guess maybe the way i sended the
patch was not right.

I found the patch on the lore in this url, is this helpful ?
https://lore.kernel.org/lkml/20221002181035.490ad0155d741e39faa29716@kernel=
.org/

> I'm not really sure what's happened there.. I can only see your v1 and
> your v4 on lore/patchwork.
I find all my commits from v1 to v8 in this addr
https://lore.kernel.org/lkml/?q=3Dl3b2w1

Should I resend the patch as a last resort ?

Binglei Wang
Best wishes.

Conor Dooley <conor@kernel.org> =E4=BA=8E2022=E5=B9=B410=E6=9C=8817=E6=97=
=A5=E5=91=A8=E4=B8=80 22:58=E5=86=99=E9=81=93=EF=BC=9A
>
> On Mon, Oct 17, 2022 at 10:31:28PM +0800, binglei wang wrote:
> > Hi Conor,
> > could you please help me to push forward merging process of this patch
> > into the 6.1 ?  Thank you!
>
> Hey Binglei,
> Unfortunately it is too late for v6.1 (the merge window closed on
> Sunday, Palmer sent his second PR on Friday) but I don't see why this
> should not be picked for v6.2. I tried last week & again just now to
> check the status of this patch on patchwork but I cannot find it there.
> Similarly, the patch does not appear on lore:
> https://lore.kernel.org/linux-riscv/CAJ3C4KzyAR7dKYFBKHzFEXr-dzr-JMGRFVx+=
dybMhRPy0uHUgA@mail.gmail.com/T/#t
> Thread overview: 3+ messages (download: mbox.gz / follow: Atom feed)
> -- links below jump to the message on this page --
>      [not found] <20220930081357.651914-1-l3b2w1@gmail.com>
> 2022-10-02  9:10 ` [PATCH v8] rethook: add riscv rethook implementation M=
asami Hiramatsu
> 2022-10-02 16:39 ` Conor Dooley
> 2022-10-17 14:31   ` binglei wang
>
> I'm not really sure what's happened there.. I can only see your v1 and
> your v4 on lore/patchwork. Maybe take a look if you changed anything
> between versions & try resending as v9?
>
> HTH,
> Conor.
>
> >
> > Binglei Wang
> > Best wishes.
> >
> >
> > On 2022-10-03 00:39, Conor Dooley wrote:
> > > Hey Binglei,
> > > I am not qualified to give you an actual R-b on this patch, but I see
> > > you did get one from Masami who very much is!
> > >
> > > That said, the patch looks a lot better (and much simpler!) now. Than=
ks
> > > for sticking with it despite the initial issues with your email setup
> > > and the submission process.
> > >
> > > Thanks,
> > > Conor.
> > >
> > > On Fri, Sep 30, 2022 at 04:13:57PM +0800, Binglei Wang wrote:
> > >> From: Binglei Wang <l3b2w1@gmail.com>
> > >>
> > >> Implement the kretprobes on riscv arch by using rethook machenism
> > >> which abstracts general kretprobe info into a struct rethook_node
> > >> to be embedded in the struct kretprobe_instance.
> > >>
> > >> Signed-off-by: Binglei Wang <l3b2w1@gmail.com>
> > >> ---
> > >>
> > >> Notes:
> > >>      v8: Add the omitted rethook.h
> > >>      v7: Add the changelog.
> > >>      v6: Remove the kretprobes trampoline.
> > >>      v5: Trt to fix robot compiling error and warnings.
> > >>      v4: Add patch version number.
> > >>      v3: Trt to fix robot compiling error and warnings.
> > >>      v2: Add comit log to explain reasons behind changes.
> > >>          Use my personal email instead of work email
> > >>              to avoid the attachments of company informaton.
> > >>          Make the kprobes_trampoline.S code to be shared.
> > >>      v1: Add riscv rethook implementation.
> > >>
> > >>   arch/riscv/Kconfig                            |  1 +
> > >>   arch/riscv/include/asm/kprobes.h              |  2 --
> > >>   arch/riscv/kernel/probes/Makefile             |  2 +-
> > >>   arch/riscv/kernel/probes/kprobes.c            | 13 ---------
> > >>   arch/riscv/kernel/probes/rethook.c            | 27 +++++++++++++++=
++++
> > >>   arch/riscv/kernel/probes/rethook.h            |  8 ++++++
> > >>   ...obes_trampoline.S =3D> rethook_trampoline.S} |  6 ++---
> > >>   7 files changed, 40 insertions(+), 19 deletions(-)
> > >>   create mode 100644 arch/riscv/kernel/probes/rethook.c
> > >>   create mode 100644 arch/riscv/kernel/probes/rethook.h
> > >>   rename arch/riscv/kernel/probes/{kprobes_trampoline.S =3D> rethook=
_trampoline.S} (94%)
> > >>
> > >> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > >> index 59d18881f..bfb66cdc5 100644
> > >> --- a/arch/riscv/Kconfig
> > >> +++ b/arch/riscv/Kconfig
> > >> @@ -97,6 +97,7 @@ config RISCV
> > >>      select HAVE_KPROBES if !XIP_KERNEL
> > >>      select HAVE_KPROBES_ON_FTRACE if !XIP_KERNEL
> > >>      select HAVE_KRETPROBES if !XIP_KERNEL
> > >> +    select HAVE_RETHOOK if !XIP_KERNEL
> > >>      select HAVE_MOVE_PMD
> > >>      select HAVE_MOVE_PUD
> > >>      select HAVE_PCI
> > >> diff --git a/arch/riscv/include/asm/kprobes.h b/arch/riscv/include/a=
sm/kprobes.h
> > >> index 217ef89f2..e7882ccb0 100644
> > >> --- a/arch/riscv/include/asm/kprobes.h
> > >> +++ b/arch/riscv/include/asm/kprobes.h
> > >> @@ -40,8 +40,6 @@ void arch_remove_kprobe(struct kprobe *p);
> > >>   int kprobe_fault_handler(struct pt_regs *regs, unsigned int trapnr=
);
> > >>   bool kprobe_breakpoint_handler(struct pt_regs *regs);
> > >>   bool kprobe_single_step_handler(struct pt_regs *regs);
> > >> -void __kretprobe_trampoline(void);
> > >> -void __kprobes *trampoline_probe_handler(struct pt_regs *regs);
> > >>
> > >>   #endif /* CONFIG_KPROBES */
> > >>   #endif /* _ASM_RISCV_KPROBES_H */
> > >> diff --git a/arch/riscv/kernel/probes/Makefile b/arch/riscv/kernel/p=
robes/Makefile
> > >> index 7f0840dcc..c40139e9c 100644
> > >> --- a/arch/riscv/kernel/probes/Makefile
> > >> +++ b/arch/riscv/kernel/probes/Makefile
> > >> @@ -1,6 +1,6 @@
> > >>   # SPDX-License-Identifier: GPL-2.0
> > >>   obj-$(CONFIG_KPROBES)              +=3D kprobes.o decode-insn.o si=
mulate-insn.o
> > >> -obj-$(CONFIG_KPROBES)               +=3D kprobes_trampoline.o
> > >> +obj-$(CONFIG_RETHOOK)               +=3D rethook.o rethook_trampoli=
ne.o
> > >>   obj-$(CONFIG_KPROBES_ON_FTRACE)    +=3D ftrace.o
> > >>   obj-$(CONFIG_UPROBES)              +=3D uprobes.o decode-insn.o si=
mulate-insn.o
> > >>   CFLAGS_REMOVE_simulate-insn.o =3D $(CC_FLAGS_FTRACE)
> > >> diff --git a/arch/riscv/kernel/probes/kprobes.c b/arch/riscv/kernel/=
probes/kprobes.c
> > >> index e6e950b7c..f21592d20 100644
> > >> --- a/arch/riscv/kernel/probes/kprobes.c
> > >> +++ b/arch/riscv/kernel/probes/kprobes.c
> > >> @@ -345,19 +345,6 @@ int __init arch_populate_kprobe_blacklist(void)
> > >>      return ret;
> > >>   }
> > >>
> > >> -void __kprobes __used *trampoline_probe_handler(struct pt_regs *reg=
s)
> > >> -{
> > >> -    return (void *)kretprobe_trampoline_handler(regs, NULL);
> > >> -}
> > >> -
> > >> -void __kprobes arch_prepare_kretprobe(struct kretprobe_instance *ri=
,
> > >> -                                  struct pt_regs *regs)
> > >> -{
> > >> -    ri->ret_addr =3D (kprobe_opcode_t *)regs->ra;
> > >> -    ri->fp =3D NULL;
> > >> -    regs->ra =3D (unsigned long) &__kretprobe_trampoline;
> > >> -}
> > >> -
> > >>   int __kprobes arch_trampoline_kprobe(struct kprobe *p)
> > >>   {
> > >>      return 0;
> > >> diff --git a/arch/riscv/kernel/probes/rethook.c b/arch/riscv/kernel/=
probes/rethook.c
> > >> new file mode 100644
> > >> index 000000000..cbd0da059
> > >> --- /dev/null
> > >> +++ b/arch/riscv/kernel/probes/rethook.c
> > >> @@ -0,0 +1,27 @@
> > >> +// SPDX-License-Identifier: GPL-2.0-only
> > >> +/*
> > >> + * Generic return hook for riscv.
> > >> + */
> > >> +
> > >> +#include <linux/kprobes.h>
> > >> +#include <linux/rethook.h>
> > >> +#include "rethook.h"
> > >> +
> > >> +/* This is called from arch_rethook_trampoline() */
> > >> +unsigned long __used arch_rethook_trampoline_callback(struct pt_reg=
s *regs)
> > >> +{
> > >> +    return rethook_trampoline_handler(regs, regs->s0);
> > >> +}
> > >> +NOKPROBE_SYMBOL(arch_rethook_trampoline_callback);
> > >> +
> > >> +
> > >> +void arch_rethook_prepare(struct rethook_node *rhn, struct pt_regs =
*regs, bool mcount)
> > >> +{
> > >> +    rhn->ret_addr =3D regs->ra;
> > >> +    rhn->frame =3D regs->s0;
> > >> +
> > >> +    /* replace return addr with trampoline */
> > >> +    regs->ra =3D (unsigned long)arch_rethook_trampoline;
> > >> +}
> > >> +NOKPROBE_SYMBOL(arch_rethook_prepare);
> > >> +
> > >> diff --git a/arch/riscv/kernel/probes/rethook.h b/arch/riscv/kernel/=
probes/rethook.h
> > >> new file mode 100644
> > >> index 000000000..cc573d701
> > >> --- /dev/null
> > >> +++ b/arch/riscv/kernel/probes/rethook.h
> > >> @@ -0,0 +1,8 @@
> > >> +// SPDX-License-Identifier: GPL-2.0-only
> > >> +#ifndef __RISCV_RETHOOK_H
> > >> +#define __RISCV_RETHOOK_H
> > >> +
> > >> +unsigned long arch_rethook_trampoline_callback(struct pt_regs *regs=
);
> > >> +void arch_rethook_prepare(struct rethook_node *rhn, struct pt_regs =
*regs, bool mcount);
> > >> +
> > >> +#endif
> > >> diff --git a/arch/riscv/kernel/probes/kprobes_trampoline.S b/arch/ri=
scv/kernel/probes/rethook_trampoline.S
> > >> similarity index 94%
> > >> rename from arch/riscv/kernel/probes/kprobes_trampoline.S
> > >> rename to arch/riscv/kernel/probes/rethook_trampoline.S
> > >> index 7bdb09ded..21bac92a1 100644
> > >> --- a/arch/riscv/kernel/probes/kprobes_trampoline.S
> > >> +++ b/arch/riscv/kernel/probes/rethook_trampoline.S
> > >> @@ -75,13 +75,13 @@
> > >>      REG_L x31, PT_T6(sp)
> > >>      .endm
> > >>
> > >> -ENTRY(__kretprobe_trampoline)
> > >> +ENTRY(arch_rethook_trampoline)
> > >>      addi sp, sp, -(PT_SIZE_ON_STACK)
> > >>      save_all_base_regs
> > >>
> > >>      move a0, sp /* pt_regs */
> > >>
> > >> -    call trampoline_probe_handler
> > >> +    call arch_rethook_trampoline_callback
> > >>
> > >>      /* use the result as the return-address */
> > >>      move ra, a0
> > >> @@ -90,4 +90,4 @@ ENTRY(__kretprobe_trampoline)
> > >>      addi sp, sp, PT_SIZE_ON_STACK
> > >>
> > >>      ret
> > >> -ENDPROC(__kretprobe_trampoline)
> > >> +ENDPROC(arch_rethook_trampoline)
> > >> --
> > >> 2.27.0
> > >>
> >
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv
> >
