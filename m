Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90F895F2232
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Oct 2022 11:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbiJBJKu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Oct 2022 05:10:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiJBJKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 05:10:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B094C30F50
        for <linux-kernel@vger.kernel.org>; Sun,  2 Oct 2022 02:10:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A8B72B808BF
        for <linux-kernel@vger.kernel.org>; Sun,  2 Oct 2022 09:10:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52115C433C1;
        Sun,  2 Oct 2022 09:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664701840;
        bh=5X22PodWEVJnuCJzCc8iLgd8TlBW1oUTJJeQujPfeRo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=UYvU0V3Q2eYpxyImGQ2SpFuFlI+JTCaFmr+uAxnb7k3oAeiGRzgr8AIYvYJz3uQmc
         igZ6QKh+xah/9vtByKiw7neSp5raRvPv5sIgP2EEocNJ4cExvPaHgyEfZCUWvBuSwR
         TS1yHqcWhlwR89zb5loGpYsLYlWdKx2fCu+TnM7NILkKhV0e6/gfM/NNsZxIZ3c4yQ
         zW/gQC8sBbqbM7//HT5SxAuyliqVL3eA03Q0irp0V9QgVsHkdeZXzrqgzrBAq0Plcl
         nH6QP5h909wBjRPG5yY0hlIhTLyQgW8a7kfkmKBM8w6iWFIlH597WTKzvDNj8loePS
         AQTVA5pKmFupA==
Date:   Sun, 2 Oct 2022 18:10:35 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Binglei Wang <l3b2w1@gmail.com>
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, naveen.n.rao@linux.ibm.com,
        anil.s.keshavamurthy@intel.com, davem@davemloft.net,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8] rethook: add riscv rethook implementation
Message-Id: <20221002181035.490ad0155d741e39faa29716@kernel.org>
In-Reply-To: <20220930081357.651914-1-l3b2w1@gmail.com>
References: <20220930081357.651914-1-l3b2w1@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Sep 2022 16:13:57 +0800
Binglei Wang <l3b2w1@gmail.com> wrote:

> From: Binglei Wang <l3b2w1@gmail.com>
> 
> Implement the kretprobes on riscv arch by using rethook machenism
> which abstracts general kretprobe info into a struct rethook_node
> to be embedded in the struct kretprobe_instance.
> 
> Signed-off-by: Binglei Wang <l3b2w1@gmail.com>

This looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thank you,

> ---
> 
> Notes:
>     v8: Add the omitted rethook.h
>     v7: Add the changelog.
>     v6: Remove the kretprobes trampoline.
>     v5: Trt to fix robot compiling error and warnings.
>     v4: Add patch version number.
>     v3: Trt to fix robot compiling error and warnings.
>     v2: Add comit log to explain reasons behind changes.
>         Use my personal email instead of work email
>             to avoid the attachments of company informaton.
>         Make the kprobes_trampoline.S code to be shared.
>     v1: Add riscv rethook implementation.
> 
>  arch/riscv/Kconfig                            |  1 +
>  arch/riscv/include/asm/kprobes.h              |  2 --
>  arch/riscv/kernel/probes/Makefile             |  2 +-
>  arch/riscv/kernel/probes/kprobes.c            | 13 ---------
>  arch/riscv/kernel/probes/rethook.c            | 27 +++++++++++++++++++
>  arch/riscv/kernel/probes/rethook.h            |  8 ++++++
>  ...obes_trampoline.S => rethook_trampoline.S} |  6 ++---
>  7 files changed, 40 insertions(+), 19 deletions(-)
>  create mode 100644 arch/riscv/kernel/probes/rethook.c
>  create mode 100644 arch/riscv/kernel/probes/rethook.h
>  rename arch/riscv/kernel/probes/{kprobes_trampoline.S => rethook_trampoline.S} (94%)
> 
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 59d18881f..bfb66cdc5 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -97,6 +97,7 @@ config RISCV
>  	select HAVE_KPROBES if !XIP_KERNEL
>  	select HAVE_KPROBES_ON_FTRACE if !XIP_KERNEL
>  	select HAVE_KRETPROBES if !XIP_KERNEL
> +	select HAVE_RETHOOK if !XIP_KERNEL
>  	select HAVE_MOVE_PMD
>  	select HAVE_MOVE_PUD
>  	select HAVE_PCI
> diff --git a/arch/riscv/include/asm/kprobes.h b/arch/riscv/include/asm/kprobes.h
> index 217ef89f2..e7882ccb0 100644
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
> diff --git a/arch/riscv/kernel/probes/Makefile b/arch/riscv/kernel/probes/Makefile
> index 7f0840dcc..c40139e9c 100644
> --- a/arch/riscv/kernel/probes/Makefile
> +++ b/arch/riscv/kernel/probes/Makefile
> @@ -1,6 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0
>  obj-$(CONFIG_KPROBES)		+= kprobes.o decode-insn.o simulate-insn.o
> -obj-$(CONFIG_KPROBES)		+= kprobes_trampoline.o
> +obj-$(CONFIG_RETHOOK)		+= rethook.o rethook_trampoline.o
>  obj-$(CONFIG_KPROBES_ON_FTRACE)	+= ftrace.o
>  obj-$(CONFIG_UPROBES)		+= uprobes.o decode-insn.o simulate-insn.o
>  CFLAGS_REMOVE_simulate-insn.o = $(CC_FLAGS_FTRACE)
> diff --git a/arch/riscv/kernel/probes/kprobes.c b/arch/riscv/kernel/probes/kprobes.c
> index e6e950b7c..f21592d20 100644
> --- a/arch/riscv/kernel/probes/kprobes.c
> +++ b/arch/riscv/kernel/probes/kprobes.c
> @@ -345,19 +345,6 @@ int __init arch_populate_kprobe_blacklist(void)
>  	return ret;
>  }
>  
> -void __kprobes __used *trampoline_probe_handler(struct pt_regs *regs)
> -{
> -	return (void *)kretprobe_trampoline_handler(regs, NULL);
> -}
> -
> -void __kprobes arch_prepare_kretprobe(struct kretprobe_instance *ri,
> -				      struct pt_regs *regs)
> -{
> -	ri->ret_addr = (kprobe_opcode_t *)regs->ra;
> -	ri->fp = NULL;
> -	regs->ra = (unsigned long) &__kretprobe_trampoline;
> -}
> -
>  int __kprobes arch_trampoline_kprobe(struct kprobe *p)
>  {
>  	return 0;
> diff --git a/arch/riscv/kernel/probes/rethook.c b/arch/riscv/kernel/probes/rethook.c
> new file mode 100644
> index 000000000..cbd0da059
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
> +unsigned long __used arch_rethook_trampoline_callback(struct pt_regs *regs)
> +{
> +	return rethook_trampoline_handler(regs, regs->s0);
> +}
> +NOKPROBE_SYMBOL(arch_rethook_trampoline_callback);
> +
> +
> +void arch_rethook_prepare(struct rethook_node *rhn, struct pt_regs *regs, bool mcount)
> +{
> +	rhn->ret_addr = regs->ra;
> +	rhn->frame = regs->s0;
> +
> +	/* replace return addr with trampoline */
> +	regs->ra = (unsigned long)arch_rethook_trampoline;
> +}
> +NOKPROBE_SYMBOL(arch_rethook_prepare);
> +
> diff --git a/arch/riscv/kernel/probes/rethook.h b/arch/riscv/kernel/probes/rethook.h
> new file mode 100644
> index 000000000..cc573d701
> --- /dev/null
> +++ b/arch/riscv/kernel/probes/rethook.h
> @@ -0,0 +1,8 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +#ifndef __RISCV_RETHOOK_H
> +#define __RISCV_RETHOOK_H
> +
> +unsigned long arch_rethook_trampoline_callback(struct pt_regs *regs);
> +void arch_rethook_prepare(struct rethook_node *rhn, struct pt_regs *regs, bool mcount);
> +
> +#endif
> diff --git a/arch/riscv/kernel/probes/kprobes_trampoline.S b/arch/riscv/kernel/probes/rethook_trampoline.S
> similarity index 94%
> rename from arch/riscv/kernel/probes/kprobes_trampoline.S
> rename to arch/riscv/kernel/probes/rethook_trampoline.S
> index 7bdb09ded..21bac92a1 100644
> --- a/arch/riscv/kernel/probes/kprobes_trampoline.S
> +++ b/arch/riscv/kernel/probes/rethook_trampoline.S
> @@ -75,13 +75,13 @@
>  	REG_L x31, PT_T6(sp)
>  	.endm
>  
> -ENTRY(__kretprobe_trampoline)
> +ENTRY(arch_rethook_trampoline)
>  	addi sp, sp, -(PT_SIZE_ON_STACK)
>  	save_all_base_regs
>  
>  	move a0, sp /* pt_regs */
>  
> -	call trampoline_probe_handler
> +	call arch_rethook_trampoline_callback
>  
>  	/* use the result as the return-address */
>  	move ra, a0
> @@ -90,4 +90,4 @@ ENTRY(__kretprobe_trampoline)
>  	addi sp, sp, PT_SIZE_ON_STACK
>  
>  	ret
> -ENDPROC(__kretprobe_trampoline)
> +ENDPROC(arch_rethook_trampoline)
> -- 
> 2.27.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
