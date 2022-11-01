Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85716614BEA
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 14:40:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbiKANkq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 09:40:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbiKANkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 09:40:41 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF1E911C2E
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 06:40:35 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-370547b8ca0so56687977b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Nov 2022 06:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FEemgqHSPdOVbuTMxjr2OtiUnu1+6y6CulFdnMK8sdY=;
        b=MBhNV2P9r0o+YdLFAewENwpwX9ItGvyV3HBuC+WvSrZNFuxBOHju5nNsoCJeMTqn84
         T7FE+IGWieiBDYNQ+b9wga8/gprF4isblVZHRZvKkUlo5HuPcNTuKqBsbwZmxRQIVoCX
         uNyeLY8Yn+bkvy86+QttVOoPYh/5Ph0m/jIjR0HJ7lO64NkNg4LYvmS5g3ZuoDHs8Vtx
         RAtUJa+HWavu5Ug/XiBrpk+g+RmKsSvjTg2Jp5vpmsyDO1NCmqFqakOBkHEto/vTawTJ
         hr12SLARYCMkvKaI07zeeJA1cBjOmMTeRFwFO+iiyh9dhpuqFL24ioUNNKP8BrJoWq+y
         E/Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FEemgqHSPdOVbuTMxjr2OtiUnu1+6y6CulFdnMK8sdY=;
        b=JX7Xn79ASiMGW2gQ8qP8gRc71zn17RdBbUmvIATcxWURMEgztSlxyDLEI1b5Omqhxt
         mq6coeZlSvaM0DEyR8q7QxPAqheaJrc4H0Ca9RdNFTqOZLU6MPDe0QcMA0px5KJ87Smn
         jp/yZokkRVC3aTseBvgTb+sv8wuZnjfPsQ3s0WYhTxtpzf6QMMJTm9qyExd1HoMutzkq
         uKU9NeBuoskr+gLDRDjO7sMoIhqJOSQf38eTwNYkFiJa9Nk5CEP1VNzNaCp9loJ4ADUV
         hEKa7hlVOKJ699JFo5Y6JRy39fgrkf/k9CSpRTLSIn1TJ2VInMZ8WBS9nOiwqUmKcFCa
         hQWA==
X-Gm-Message-State: ACrzQf0hz3JMJqnPcE04HEuhW3QaflWgEa0vg+0zD/CeGSaEIIX+2tNN
        02IRhFt44OOGVDscnxuBQTUWuZKUUfY0X6gg53w=
X-Google-Smtp-Source: AMsMyM4KivgWQh3ev2F6WoTadvLidt2YDR9fE1wcX2AL5SfKRPE1MaRfECQdxg0PqLoauqwYh5vzD4xvNbXOM/Ie6XI=
X-Received: by 2002:a0d:e441:0:b0:360:9535:bac6 with SMTP id
 n62-20020a0de441000000b003609535bac6mr17200558ywe.452.1667310035086; Tue, 01
 Nov 2022 06:40:35 -0700 (PDT)
MIME-Version: 1.0
References: <20221025151831.1097417-1-conor@kernel.org>
In-Reply-To: <20221025151831.1097417-1-conor@kernel.org>
From:   binglei wang <l3b2w1@gmail.com>
Date:   Tue, 1 Nov 2022 21:40:23 +0800
Message-ID: <CAJ3C4KygPPaxK55oZFcaXLpr0PaUvvY1qj_5i47TkV1Tm7G-uQ@mail.gmail.com>
Subject: Re: [PATCH RESEND v9] riscv: add riscv rethook implementation
To:     Conor Dooley <conor@kernel.org>
Cc:     aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com,
        anil.s.keshavamurthy@intel.com, davem@davemloft.net,
        linux-kernel@vger.kernel.org, mhiramat@kernel.org,
        naveen.n.rao@linux.ibm.com,
        Conor Dooley <conor.dooley@microchip.com>
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

Thanks for your resending.
What to do next is just to wait patently, right ?

Binglei Wang
Best wishes.


Conor Dooley <conor@kernel.org> =E4=BA=8E2022=E5=B9=B410=E6=9C=8825=E6=97=
=A5=E5=91=A8=E4=BA=8C 23:19=E5=86=99=E9=81=93=EF=BC=9A
>
> From: Binglei Wang <l3b2w1@gmail.com>
>
> Implement the kretprobes on riscv arch by using rethook machenism
> which abstracts general kretprobe info into a struct rethook_node
> to be embedded in the struct kretprobe_instance.
>
> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> Signed-off-by: Binglei Wang <l3b2w1@gmail.com>
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
> Binglei's patches do not seem to make it to the linux-riscv list, so
> blindly resending on their behalf, with Masami's ack from v8 added.
>
>  arch/riscv/Kconfig                            |  1 +
>  arch/riscv/include/asm/kprobes.h              |  2 --
>  arch/riscv/kernel/probes/Makefile             |  2 +-
>  arch/riscv/kernel/probes/kprobes.c            | 13 ---------
>  arch/riscv/kernel/probes/rethook.c            | 27 +++++++++++++++++++
>  arch/riscv/kernel/probes/rethook.h            |  8 ++++++
>  ...obes_trampoline.S =3D> rethook_trampoline.S} |  6 ++---
>  7 files changed, 40 insertions(+), 19 deletions(-)
>  create mode 100644 arch/riscv/kernel/probes/rethook.c
>  create mode 100644 arch/riscv/kernel/probes/rethook.h
>  rename arch/riscv/kernel/probes/{kprobes_trampoline.S =3D> rethook_tramp=
oline.S} (94%)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 6b48a3ae9843..413aeca71ca0 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -99,6 +99,7 @@ config RISCV
>         select HAVE_KPROBES if !XIP_KERNEL
>         select HAVE_KPROBES_ON_FTRACE if !XIP_KERNEL
>         select HAVE_KRETPROBES if !XIP_KERNEL
> +       select HAVE_RETHOOK if !XIP_KERNEL
>         select HAVE_MOVE_PMD
>         select HAVE_MOVE_PUD
>         select HAVE_PCI
> diff --git a/arch/riscv/include/asm/kprobes.h b/arch/riscv/include/asm/kp=
robes.h
> index 217ef89f22b9..e7882ccb0fd4 100644
> --- a/arch/riscv/include/asm/kprobes.h
> +++ b/arch/riscv/include/asm/kprobes.h
> @@ -40,8 +40,6 @@ void arch_remove_kprobe(struct kprobe *p);
>  int kprobe_fault_handler(struct pt_regs *regs, unsigned int trapnr);
>  bool kprobe_breakpoint_handler(struct pt_regs *regs);
>  bool kprobe_single_step_handler(struct pt_regs *regs);
> -void __kretprobe_trampoline(void);
> -void __kprobes *trampoline_probe_handler(struct pt_regs *regs);
>
>  #endif /* CONFIG_KPROBES */
>  #endif /* _ASM_RISCV_KPROBES_H */
> diff --git a/arch/riscv/kernel/probes/Makefile b/arch/riscv/kernel/probes=
/Makefile
> index 7f0840dcc31b..c40139e9ca47 100644
> --- a/arch/riscv/kernel/probes/Makefile
> +++ b/arch/riscv/kernel/probes/Makefile
> @@ -1,6 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0
>  obj-$(CONFIG_KPROBES)          +=3D kprobes.o decode-insn.o simulate-ins=
n.o
> -obj-$(CONFIG_KPROBES)          +=3D kprobes_trampoline.o
> +obj-$(CONFIG_RETHOOK)          +=3D rethook.o rethook_trampoline.o
>  obj-$(CONFIG_KPROBES_ON_FTRACE)        +=3D ftrace.o
>  obj-$(CONFIG_UPROBES)          +=3D uprobes.o decode-insn.o simulate-ins=
n.o
>  CFLAGS_REMOVE_simulate-insn.o =3D $(CC_FLAGS_FTRACE)
> diff --git a/arch/riscv/kernel/probes/kprobes.c b/arch/riscv/kernel/probe=
s/kprobes.c
> index e6e950b7cf32..f21592d20306 100644
> --- a/arch/riscv/kernel/probes/kprobes.c
> +++ b/arch/riscv/kernel/probes/kprobes.c
> @@ -345,19 +345,6 @@ int __init arch_populate_kprobe_blacklist(void)
>         return ret;
>  }
>
> -void __kprobes __used *trampoline_probe_handler(struct pt_regs *regs)
> -{
> -       return (void *)kretprobe_trampoline_handler(regs, NULL);
> -}
> -
> -void __kprobes arch_prepare_kretprobe(struct kretprobe_instance *ri,
> -                                     struct pt_regs *regs)
> -{
> -       ri->ret_addr =3D (kprobe_opcode_t *)regs->ra;
> -       ri->fp =3D NULL;
> -       regs->ra =3D (unsigned long) &__kretprobe_trampoline;
> -}
> -
>  int __kprobes arch_trampoline_kprobe(struct kprobe *p)
>  {
>         return 0;
> diff --git a/arch/riscv/kernel/probes/rethook.c b/arch/riscv/kernel/probe=
s/rethook.c
> new file mode 100644
> index 000000000000..5c27c1f50989
> --- /dev/null
> +++ b/arch/riscv/kernel/probes/rethook.c
> @@ -0,0 +1,27 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Generic return hook for riscv.
> + */
> +
> +#include <linux/kprobes.h>
> +#include <linux/rethook.h>
> +#include "rethook.h"
> +
> +/* This is called from arch_rethook_trampoline() */
> +unsigned long __used arch_rethook_trampoline_callback(struct pt_regs *re=
gs)
> +{
> +       return rethook_trampoline_handler(regs, regs->s0);
> +}
> +
> +NOKPROBE_SYMBOL(arch_rethook_trampoline_callback);
> +
> +void arch_rethook_prepare(struct rethook_node *rhn, struct pt_regs *regs=
, bool mcount)
> +{
> +       rhn->ret_addr =3D regs->ra;
> +       rhn->frame =3D regs->s0;
> +
> +       /* replace return addr with trampoline */
> +       regs->ra =3D (unsigned long)arch_rethook_trampoline;
> +}
> +
> +NOKPROBE_SYMBOL(arch_rethook_prepare);
> diff --git a/arch/riscv/kernel/probes/rethook.h b/arch/riscv/kernel/probe=
s/rethook.h
> new file mode 100644
> index 000000000000..4758f7e3ce88
> --- /dev/null
> +++ b/arch/riscv/kernel/probes/rethook.h
> @@ -0,0 +1,8 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +#ifndef __RISCV_RETHOOK_H
> +#define __RISCV_RETHOOK_H
> +
> +unsigned long arch_rethook_trampoline_callback(struct pt_regs *regs);
> +void arch_rethook_prepare(struct rethook_node *rhn, struct pt_regs *regs=
, bool mcount);
> +
> +#endif
> diff --git a/arch/riscv/kernel/probes/kprobes_trampoline.S b/arch/riscv/k=
ernel/probes/rethook_trampoline.S
> similarity index 94%
> rename from arch/riscv/kernel/probes/kprobes_trampoline.S
> rename to arch/riscv/kernel/probes/rethook_trampoline.S
> index 7bdb09ded39b..21bac92a170a 100644
> --- a/arch/riscv/kernel/probes/kprobes_trampoline.S
> +++ b/arch/riscv/kernel/probes/rethook_trampoline.S
> @@ -75,13 +75,13 @@
>         REG_L x31, PT_T6(sp)
>         .endm
>
> -ENTRY(__kretprobe_trampoline)
> +ENTRY(arch_rethook_trampoline)
>         addi sp, sp, -(PT_SIZE_ON_STACK)
>         save_all_base_regs
>
>         move a0, sp /* pt_regs */
>
> -       call trampoline_probe_handler
> +       call arch_rethook_trampoline_callback
>
>         /* use the result as the return-address */
>         move ra, a0
> @@ -90,4 +90,4 @@ ENTRY(__kretprobe_trampoline)
>         addi sp, sp, PT_SIZE_ON_STACK
>
>         ret
> -ENDPROC(__kretprobe_trampoline)
> +ENDPROC(arch_rethook_trampoline)
> --
> 2.38.0
>
