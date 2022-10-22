Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CF74608EC2
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 19:14:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbiJVROV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 13:14:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiJVROT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 13:14:19 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3845C183DBE
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 10:14:17 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id l145so6796369ybl.0
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 10:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :references:in-reply-to:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=94s+R95nYIPIONlKgmESuB+m6zoBvg1UsVWkI0BelN0=;
        b=lMIySbGbAQnXhFoudkaNWx496bIQNGjs7K7S4q8VHln2fLY+LxfuWsKltv7MKLt0AF
         VoIE6Y24tynRzr6ajPQGjth5vCIlFWMY5ael6TRv7u3MWu89UhDG7+6mdLYweO60kikX
         g/DGCBFcNDCHggS8oj3EWdcUP7bzc2wllsdQj23JPAX3KHsPxlox2xRufWurfenmiemk
         s6UUEQ290Ez5LqlBiJfPugVmHgnl9miGZC1Lt2wmogCf3lTvv2q7BUQ9Y7S2E3TvGS3J
         ZqcUicYFKA8u8s4qAcWmJWKBbN2aGV+WGYbRKfx2BZ/dZkIPe2yXkw5cxBzsOgO9QqcU
         puew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :references:in-reply-to:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=94s+R95nYIPIONlKgmESuB+m6zoBvg1UsVWkI0BelN0=;
        b=AOzxFFMU9D5wVNH2gkOltr0e1G20EIMpVYsojXu3YzC9dFtk6799pDc3IoHbwxVdZi
         2SZd0BeFLn6LmVhE+pM4xedER3m3Gc7s0NwFz5SAmPXFjlJEruuxuLi69E+HQwG7V6ta
         rujfkrzmNtj/XXcTmyFldrTQUFjKx1mOcx1Mxe9hldHcZCRV1xgLYybxZEvIue4Ateo7
         YANUyJQlpbSJaZnv4j/Y1/nDllmzGaY7Bue+PRvUCJ+iy70jjH7EDcZJb8hUsQB/kiH8
         KmDqsYS81pq0gM1SM+RW9i1KakbohRiToxE6TzWxMRL6WnhiqzPmzDd4CUwJxdC/WJca
         xLuA==
X-Gm-Message-State: ACrzQf0jV0EBmfxmaVTO7GwOwkzgYa7ABUhEM9isRepIjVu5L2Ng5ZHV
        yW4QDPY1C8yAlMJHHIFtuE8OS4L77X9AC/367ww=
X-Google-Smtp-Source: AMsMyM59nnVyYqtlRuBs3Eo4aviqgReDq9AdKpLZc0xJ5g/C7C5fL7v5WgckodyhFFzEeu6yVYmaqXdJwiCCUqHg9/A=
X-Received: by 2002:a25:3cc4:0:b0:6af:c67e:909e with SMTP id
 j187-20020a253cc4000000b006afc67e909emr21079135yba.266.1666458856304; Sat, 22
 Oct 2022 10:14:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7000:1749:b0:3c5:eda0:96be with HTTP; Sat, 22 Oct 2022
 10:14:15 -0700 (PDT)
In-Reply-To: <Y062jiPZbWEAVjpO@wendy>
References: <20220930081357.651914-1-l3b2w1@gmail.com> <Yzm+z+mv/VSA+5hg@spud>
 <CAJ3C4KzyAR7dKYFBKHzFEXr-dzr-JMGRFVx+dybMhRPy0uHUgA@mail.gmail.com>
 <Y01tdcRRFBdOmaYc@spud> <CAJ3C4Kwj0yYS5JCPw=g0X9qiQhw04iKy_cTjc0x8iWdy0ay7bg@mail.gmail.com>
 <Y062jiPZbWEAVjpO@wendy>
From:   binglei wang <l3b2w1@gmail.com>
Date:   Sun, 23 Oct 2022 01:14:15 +0800
Message-ID: <CAJ3C4Kzzd4ZamaUNFLx6dBUwKgMin6O+nGgWf+pJbziLRx1vvA@mail.gmail.com>
Subject: Re: [PATCH v8] rethook: add riscv rethook implementation
To:     Conor Dooley <conor.dooley@microchip.com>
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

Hi Conor,
I would appreciate if you can send the patch for me this time !
As keen as mustard i am to see the patch applied and merged if there
is no something unsuitable.

Binglei Wang
Best wishes.



2022-10-18 22:22 GMT+08:00, Conor Dooley <conor.dooley@microchip.com>:
> On Tue, Oct 18, 2022 at 10:08:55PM +0800, binglei wang wrote:
>> Hi Conor:
>> Thank you for your help to check the merging process for this patch.
>>
>> > Thread overview: 3+ messages (download: mbox.gz / follow: Atom feed)
>> > -- links below jump to the message on this page --
>> >      [not found] <20220930081357.651914-1-l3b2w1@gmail.com>
>> I have no idea what this means, I guess maybe the way i sended the
>> patch was not right.
>>
>> I found the patch on the lore in this url, is this helpful ?
>> https://lore.kernel.org/lkml/20221002181035.490ad0155d741e39faa29716@ker=
nel.org/
>
> Hmm, looks like your patch made it to lkml itself but got rejected by
> linux-riscv which is hosted by infradead. It's missing here:
> https://lore.kernel.org/linux-riscv/CAJ3C4Kwj0yYS5JCPw=3Dg0X9qiQhw04iKy_c=
Tjc0x8iWdy0ay7bg@mail.gmail.com/T/#t
>
>>
>> > I'm not really sure what's happened there.. I can only see your v1 and
>> > your v4 on lore/patchwork.
>> I find all my commits from v1 to v8 in this addr
>> https://lore.kernel.org/lkml/?q=3Dl3b2w1
>>
>> Should I resend the patch as a last resort ?
>
> Eh, I guess you could try (and CC patches@lists.linux.dev). I'm not sure
> if that'll help at all though.. At worst, if that doesn't work I could
> possibly send the patches for you. Or if you think you may end up doing
> more upstream work you could always apply for an @linux.dev account?
> See https://korg.docs.kernel.org/linuxdev.html for more information on
> that.
>
>>
>> Binglei Wang
>> Best wishes.
>>
>> Conor Dooley <conor@kernel.org> =E4=BA=8E2022=E5=B9=B410=E6=9C=8817=E6=
=97=A5=E5=91=A8=E4=B8=80 22:58=E5=86=99=E9=81=93=EF=BC=9A
>> >
>> > On Mon, Oct 17, 2022 at 10:31:28PM +0800, binglei wang wrote:
>> > > Hi Conor,
>> > > could you please help me to push forward merging process of this
>> > > patch
>> > > into the 6.1 ?  Thank you!
>> >
>> > Hey Binglei,
>> > Unfortunately it is too late for v6.1 (the merge window closed on
>> > Sunday, Palmer sent his second PR on Friday) but I don't see why this
>> > should not be picked for v6.2. I tried last week & again just now to
>> > check the status of this patch on patchwork but I cannot find it there=
.
>> > Similarly, the patch does not appear on lore:
>> > https://lore.kernel.org/linux-riscv/CAJ3C4KzyAR7dKYFBKHzFEXr-dzr-JMGRF=
Vx+dybMhRPy0uHUgA@mail.gmail.com/T/#t
>> > Thread overview: 3+ messages (download: mbox.gz / follow: Atom feed)
>> > -- links below jump to the message on this page --
>> >      [not found] <20220930081357.651914-1-l3b2w1@gmail.com>
>> > 2022-10-02  9:10 ` [PATCH v8] rethook: add riscv rethook implementatio=
n
>> > Masami Hiramatsu
>> > 2022-10-02 16:39 ` Conor Dooley
>> > 2022-10-17 14:31   ` binglei wang
>> >
>> > I'm not really sure what's happened there.. I can only see your v1 and
>> > your v4 on lore/patchwork. Maybe take a look if you changed anything
>> > between versions & try resending as v9?
>> >
>> > HTH,
>> > Conor.
>> >
>> > >
>> > > Binglei Wang
>> > > Best wishes.
>> > >
>> > >
>> > > On 2022-10-03 00:39, Conor Dooley wrote:
>> > > > Hey Binglei,
>> > > > I am not qualified to give you an actual R-b on this patch, but I
>> > > > see
>> > > > you did get one from Masami who very much is!
>> > > >
>> > > > That said, the patch looks a lot better (and much simpler!) now.
>> > > > Thanks
>> > > > for sticking with it despite the initial issues with your email
>> > > > setup
>> > > > and the submission process.
>> > > >
>> > > > Thanks,
>> > > > Conor.
>> > > >
>> > > > On Fri, Sep 30, 2022 at 04:13:57PM +0800, Binglei Wang wrote:
>> > > >> From: Binglei Wang <l3b2w1@gmail.com>
>> > > >>
>> > > >> Implement the kretprobes on riscv arch by using rethook machenism
>> > > >> which abstracts general kretprobe info into a struct rethook_node
>> > > >> to be embedded in the struct kretprobe_instance.
>> > > >>
>> > > >> Signed-off-by: Binglei Wang <l3b2w1@gmail.com>
>> > > >> ---
>> > > >>
>> > > >> Notes:
>> > > >>      v8: Add the omitted rethook.h
>> > > >>      v7: Add the changelog.
>> > > >>      v6: Remove the kretprobes trampoline.
>> > > >>      v5: Trt to fix robot compiling error and warnings.
>> > > >>      v4: Add patch version number.
>> > > >>      v3: Trt to fix robot compiling error and warnings.
>> > > >>      v2: Add comit log to explain reasons behind changes.
>> > > >>          Use my personal email instead of work email
>> > > >>              to avoid the attachments of company informaton.
>> > > >>          Make the kprobes_trampoline.S code to be shared.
>> > > >>      v1: Add riscv rethook implementation.
>> > > >>
>> > > >>   arch/riscv/Kconfig                            |  1 +
>> > > >>   arch/riscv/include/asm/kprobes.h              |  2 --
>> > > >>   arch/riscv/kernel/probes/Makefile             |  2 +-
>> > > >>   arch/riscv/kernel/probes/kprobes.c            | 13 ---------
>> > > >>   arch/riscv/kernel/probes/rethook.c            | 27
>> > > >> +++++++++++++++++++
>> > > >>   arch/riscv/kernel/probes/rethook.h            |  8 ++++++
>> > > >>   ...obes_trampoline.S =3D> rethook_trampoline.S} |  6 ++---
>> > > >>   7 files changed, 40 insertions(+), 19 deletions(-)
>> > > >>   create mode 100644 arch/riscv/kernel/probes/rethook.c
>> > > >>   create mode 100644 arch/riscv/kernel/probes/rethook.h
>> > > >>   rename arch/riscv/kernel/probes/{kprobes_trampoline.S =3D>
>> > > >> rethook_trampoline.S} (94%)
>> > > >>
>> > > >> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
>> > > >> index 59d18881f..bfb66cdc5 100644
>> > > >> --- a/arch/riscv/Kconfig
>> > > >> +++ b/arch/riscv/Kconfig
>> > > >> @@ -97,6 +97,7 @@ config RISCV
>> > > >>      select HAVE_KPROBES if !XIP_KERNEL
>> > > >>      select HAVE_KPROBES_ON_FTRACE if !XIP_KERNEL
>> > > >>      select HAVE_KRETPROBES if !XIP_KERNEL
>> > > >> +    select HAVE_RETHOOK if !XIP_KERNEL
>> > > >>      select HAVE_MOVE_PMD
>> > > >>      select HAVE_MOVE_PUD
>> > > >>      select HAVE_PCI
>> > > >> diff --git a/arch/riscv/include/asm/kprobes.h
>> > > >> b/arch/riscv/include/asm/kprobes.h
>> > > >> index 217ef89f2..e7882ccb0 100644
>> > > >> --- a/arch/riscv/include/asm/kprobes.h
>> > > >> +++ b/arch/riscv/include/asm/kprobes.h
>> > > >> @@ -40,8 +40,6 @@ void arch_remove_kprobe(struct kprobe *p);
>> > > >>   int kprobe_fault_handler(struct pt_regs *regs, unsigned int
>> > > >> trapnr);
>> > > >>   bool kprobe_breakpoint_handler(struct pt_regs *regs);
>> > > >>   bool kprobe_single_step_handler(struct pt_regs *regs);
>> > > >> -void __kretprobe_trampoline(void);
>> > > >> -void __kprobes *trampoline_probe_handler(struct pt_regs *regs);
>> > > >>
>> > > >>   #endif /* CONFIG_KPROBES */
>> > > >>   #endif /* _ASM_RISCV_KPROBES_H */
>> > > >> diff --git a/arch/riscv/kernel/probes/Makefile
>> > > >> b/arch/riscv/kernel/probes/Makefile
>> > > >> index 7f0840dcc..c40139e9c 100644
>> > > >> --- a/arch/riscv/kernel/probes/Makefile
>> > > >> +++ b/arch/riscv/kernel/probes/Makefile
>> > > >> @@ -1,6 +1,6 @@
>> > > >>   # SPDX-License-Identifier: GPL-2.0
>> > > >>   obj-$(CONFIG_KPROBES)              +=3D kprobes.o decode-insn.o
>> > > >> simulate-insn.o
>> > > >> -obj-$(CONFIG_KPROBES)               +=3D kprobes_trampoline.o
>> > > >> +obj-$(CONFIG_RETHOOK)               +=3D rethook.o
>> > > >> rethook_trampoline.o
>> > > >>   obj-$(CONFIG_KPROBES_ON_FTRACE)    +=3D ftrace.o
>> > > >>   obj-$(CONFIG_UPROBES)              +=3D uprobes.o decode-insn.o
>> > > >> simulate-insn.o
>> > > >>   CFLAGS_REMOVE_simulate-insn.o =3D $(CC_FLAGS_FTRACE)
>> > > >> diff --git a/arch/riscv/kernel/probes/kprobes.c
>> > > >> b/arch/riscv/kernel/probes/kprobes.c
>> > > >> index e6e950b7c..f21592d20 100644
>> > > >> --- a/arch/riscv/kernel/probes/kprobes.c
>> > > >> +++ b/arch/riscv/kernel/probes/kprobes.c
>> > > >> @@ -345,19 +345,6 @@ int __init
>> > > >> arch_populate_kprobe_blacklist(void)
>> > > >>      return ret;
>> > > >>   }
>> > > >>
>> > > >> -void __kprobes __used *trampoline_probe_handler(struct pt_regs
>> > > >> *regs)
>> > > >> -{
>> > > >> -    return (void *)kretprobe_trampoline_handler(regs, NULL);
>> > > >> -}
>> > > >> -
>> > > >> -void __kprobes arch_prepare_kretprobe(struct kretprobe_instance
>> > > >> *ri,
>> > > >> -                                  struct pt_regs *regs)
>> > > >> -{
>> > > >> -    ri->ret_addr =3D (kprobe_opcode_t *)regs->ra;
>> > > >> -    ri->fp =3D NULL;
>> > > >> -    regs->ra =3D (unsigned long) &__kretprobe_trampoline;
>> > > >> -}
>> > > >> -
>> > > >>   int __kprobes arch_trampoline_kprobe(struct kprobe *p)
>> > > >>   {
>> > > >>      return 0;
>> > > >> diff --git a/arch/riscv/kernel/probes/rethook.c
>> > > >> b/arch/riscv/kernel/probes/rethook.c
>> > > >> new file mode 100644
>> > > >> index 000000000..cbd0da059
>> > > >> --- /dev/null
>> > > >> +++ b/arch/riscv/kernel/probes/rethook.c
>> > > >> @@ -0,0 +1,27 @@
>> > > >> +// SPDX-License-Identifier: GPL-2.0-only
>> > > >> +/*
>> > > >> + * Generic return hook for riscv.
>> > > >> + */
>> > > >> +
>> > > >> +#include <linux/kprobes.h>
>> > > >> +#include <linux/rethook.h>
>> > > >> +#include "rethook.h"
>> > > >> +
>> > > >> +/* This is called from arch_rethook_trampoline() */
>> > > >> +unsigned long __used arch_rethook_trampoline_callback(struct
>> > > >> pt_regs *regs)
>> > > >> +{
>> > > >> +    return rethook_trampoline_handler(regs, regs->s0);
>> > > >> +}
>> > > >> +NOKPROBE_SYMBOL(arch_rethook_trampoline_callback);
>> > > >> +
>> > > >> +
>> > > >> +void arch_rethook_prepare(struct rethook_node *rhn, struct pt_re=
gs
>> > > >> *regs, bool mcount)
>> > > >> +{
>> > > >> +    rhn->ret_addr =3D regs->ra;
>> > > >> +    rhn->frame =3D regs->s0;
>> > > >> +
>> > > >> +    /* replace return addr with trampoline */
>> > > >> +    regs->ra =3D (unsigned long)arch_rethook_trampoline;
>> > > >> +}
>> > > >> +NOKPROBE_SYMBOL(arch_rethook_prepare);
>> > > >> +
>> > > >> diff --git a/arch/riscv/kernel/probes/rethook.h
>> > > >> b/arch/riscv/kernel/probes/rethook.h
>> > > >> new file mode 100644
>> > > >> index 000000000..cc573d701
>> > > >> --- /dev/null
>> > > >> +++ b/arch/riscv/kernel/probes/rethook.h
>> > > >> @@ -0,0 +1,8 @@
>> > > >> +// SPDX-License-Identifier: GPL-2.0-only
>> > > >> +#ifndef __RISCV_RETHOOK_H
>> > > >> +#define __RISCV_RETHOOK_H
>> > > >> +
>> > > >> +unsigned long arch_rethook_trampoline_callback(struct pt_regs
>> > > >> *regs);
>> > > >> +void arch_rethook_prepare(struct rethook_node *rhn, struct pt_re=
gs
>> > > >> *regs, bool mcount);
>> > > >> +
>> > > >> +#endif
>> > > >> diff --git a/arch/riscv/kernel/probes/kprobes_trampoline.S
>> > > >> b/arch/riscv/kernel/probes/rethook_trampoline.S
>> > > >> similarity index 94%
>> > > >> rename from arch/riscv/kernel/probes/kprobes_trampoline.S
>> > > >> rename to arch/riscv/kernel/probes/rethook_trampoline.S
>> > > >> index 7bdb09ded..21bac92a1 100644
>> > > >> --- a/arch/riscv/kernel/probes/kprobes_trampoline.S
>> > > >> +++ b/arch/riscv/kernel/probes/rethook_trampoline.S
>> > > >> @@ -75,13 +75,13 @@
>> > > >>      REG_L x31, PT_T6(sp)
>> > > >>      .endm
>> > > >>
>> > > >> -ENTRY(__kretprobe_trampoline)
>> > > >> +ENTRY(arch_rethook_trampoline)
>> > > >>      addi sp, sp, -(PT_SIZE_ON_STACK)
>> > > >>      save_all_base_regs
>> > > >>
>> > > >>      move a0, sp /* pt_regs */
>> > > >>
>> > > >> -    call trampoline_probe_handler
>> > > >> +    call arch_rethook_trampoline_callback
>> > > >>
>> > > >>      /* use the result as the return-address */
>> > > >>      move ra, a0
>> > > >> @@ -90,4 +90,4 @@ ENTRY(__kretprobe_trampoline)
>> > > >>      addi sp, sp, PT_SIZE_ON_STACK
>> > > >>
>> > > >>      ret
>> > > >> -ENDPROC(__kretprobe_trampoline)
>> > > >> +ENDPROC(arch_rethook_trampoline)
>> > > >> --
>> > > >> 2.27.0
>> > > >>
>> > >
>> > > _______________________________________________
>> > > linux-riscv mailing list
>> > > linux-riscv@lists.infradead.org
>> > > http://lists.infradead.org/mailman/listinfo/linux-riscv
>> > >
>
