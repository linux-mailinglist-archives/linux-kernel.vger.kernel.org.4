Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E4E75E80AE
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 19:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231506AbiIWR0t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 13:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231285AbiIWR0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 13:26:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE7DF14F28F
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 10:26:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6E69462946
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 17:26:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE93CC433D6;
        Fri, 23 Sep 2022 17:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663954000;
        bh=ODCjxTzT6V3bEUbRpV1MKpDP+b83Jok/oox8PGujGiY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qKyMP4wlwmWY62qTQnQJVpuRT9HxR1GMppItCoi8ql/yW+8WXqJLkL70vHtsxTrjY
         GEAsoHvcEmOxPY6IDBg1OaMPV6QiKLK5RTrlEfFk565mm8LELe05+ywr8XDSr2cHyY
         bHeC3fGFiqkHHMV0Se1i3zLCWRq2QTB7cK8y6JmRXWTZH9iZjNvGCgbTAjlnenPFH7
         hvecFl6Ps6kH7eYmd/NC6Zw3Y3SL9wuwCs869Ycg5PFmeTzxJVjKJeR+QYeQqH1AiR
         6fkFtMbZULW4sXq+NdliwYf5+AVyo1mCtfotaLxj3ibpUkELMCx91exyrYs2SLJoLa
         DThJoiaXjzMew==
Date:   Fri, 23 Sep 2022 18:26:35 +0100
From:   Conor Dooley <conor@kernel.org>
To:     l3b2w1@gmail.com
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, naveen.n.rao@linux.ibm.com,
        anil.s.keshavamurthy@intel.com, davem@davemloft.net,
        mhiramat@kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] rethook: add riscv rethook implementation.
Message-ID: <Yy3sSzPK20IvaIVP@spud>
References: <YyxG6wC0mjCUUGDB@wendy>
 <20220922134428.19203-1-l3b2w1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220922134428.19203-1-l3b2w1@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hey Binglei Wang,

I don't know anything about rethooks, so just more minor comments from
me. Don't respin until someone more knowledgable comes back with a
review of the patch itself.

Please send new versions of the patch as a new mail thread & not as
a reply to the existing one.

On Thu, Sep 22, 2022 at 09:44:28PM +0800, l3b2w1@gmail.com wrote:
> From: Binglei Wang <l3b2w1@gmail.com>
> 
> Implement the kretprobes function on riscv arch by
> using rethook machenism which abstracts general kretprobe info
                ^mechanism
> into the struct rethook_node
> to be embedded in the struct kretprobe_instance

Whenever you resend, please fix the line wrapping here too.

> Signed-off-by: Binglei Wang <l3b2w1@gmail.com>

Again, your first version of the patch used your work email as the
commit author/signer. The sending email does not need to match your
authorship/signature email so is there a reason not to have your h3c
email here?
Thanks,
Conor.

> ---
>  arch/riscv/Kconfig                            |  1 +
>  arch/riscv/kernel/probes/Makefile             |  1 +
>  arch/riscv/kernel/probes/kprobes.c            |  8 --
>  arch/riscv/kernel/probes/kprobes_trampoline.S | 73 +----------------
>  arch/riscv/kernel/probes/kprobes_trampoline.h | 79 +++++++++++++++++++
>  arch/riscv/kernel/probes/rethook.c            | 24 ++++++
>  arch/riscv/kernel/probes/rethook_trampoline.S | 22 ++++++
>  include/linux/kprobes.h                       |  6 ++
>  8 files changed, 134 insertions(+), 80 deletions(-)
>  create mode 100644 arch/riscv/kernel/probes/kprobes_trampoline.h
>  create mode 100644 arch/riscv/kernel/probes/rethook.c
>  create mode 100644 arch/riscv/kernel/probes/rethook_trampoline.S
> 
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index ed66c31e4..c5cae0825 100644
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
> diff --git a/arch/riscv/kernel/probes/Makefile b/arch/riscv/kernel/probes/Makefile
> index 7f0840dcc..ee345e7e9 100644
> --- a/arch/riscv/kernel/probes/Makefile
> +++ b/arch/riscv/kernel/probes/Makefile
> @@ -3,4 +3,5 @@ obj-$(CONFIG_KPROBES)		+= kprobes.o decode-insn.o simulate-insn.o
>  obj-$(CONFIG_KPROBES)		+= kprobes_trampoline.o
>  obj-$(CONFIG_KPROBES_ON_FTRACE)	+= ftrace.o
>  obj-$(CONFIG_UPROBES)		+= uprobes.o decode-insn.o simulate-insn.o
> +obj-$(CONFIG_RETHOOK) 		+= rethook.o rethook_trampoline.o
>  CFLAGS_REMOVE_simulate-insn.o = $(CC_FLAGS_FTRACE)
> diff --git a/arch/riscv/kernel/probes/kprobes.c b/arch/riscv/kernel/probes/kprobes.c
> index e6e950b7c..04911cc42 100644
> --- a/arch/riscv/kernel/probes/kprobes.c
> +++ b/arch/riscv/kernel/probes/kprobes.c
> @@ -350,14 +350,6 @@ void __kprobes __used *trampoline_probe_handler(struct pt_regs *regs)
>  	return (void *)kretprobe_trampoline_handler(regs, NULL);
>  }
>  
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
> diff --git a/arch/riscv/kernel/probes/kprobes_trampoline.S b/arch/riscv/kernel/probes/kprobes_trampoline.S
> index 7bdb09ded..54937f342 100644
> --- a/arch/riscv/kernel/probes/kprobes_trampoline.S
> +++ b/arch/riscv/kernel/probes/kprobes_trampoline.S
> @@ -2,78 +2,7 @@
>  /*
>   * Author: Patrick Stählin <me@packi.ch>
>   */
> -#include <linux/linkage.h>
> -
> -#include <asm/asm.h>
> -#include <asm/asm-offsets.h>
> -
> -	.text
> -	.altmacro
> -
> -	.macro save_all_base_regs
> -	REG_S x1,  PT_RA(sp)
> -	REG_S x3,  PT_GP(sp)
> -	REG_S x4,  PT_TP(sp)
> -	REG_S x5,  PT_T0(sp)
> -	REG_S x6,  PT_T1(sp)
> -	REG_S x7,  PT_T2(sp)
> -	REG_S x8,  PT_S0(sp)
> -	REG_S x9,  PT_S1(sp)
> -	REG_S x10, PT_A0(sp)
> -	REG_S x11, PT_A1(sp)
> -	REG_S x12, PT_A2(sp)
> -	REG_S x13, PT_A3(sp)
> -	REG_S x14, PT_A4(sp)
> -	REG_S x15, PT_A5(sp)
> -	REG_S x16, PT_A6(sp)
> -	REG_S x17, PT_A7(sp)
> -	REG_S x18, PT_S2(sp)
> -	REG_S x19, PT_S3(sp)
> -	REG_S x20, PT_S4(sp)
> -	REG_S x21, PT_S5(sp)
> -	REG_S x22, PT_S6(sp)
> -	REG_S x23, PT_S7(sp)
> -	REG_S x24, PT_S8(sp)
> -	REG_S x25, PT_S9(sp)
> -	REG_S x26, PT_S10(sp)
> -	REG_S x27, PT_S11(sp)
> -	REG_S x28, PT_T3(sp)
> -	REG_S x29, PT_T4(sp)
> -	REG_S x30, PT_T5(sp)
> -	REG_S x31, PT_T6(sp)
> -	.endm
> -
> -	.macro restore_all_base_regs
> -	REG_L x3,  PT_GP(sp)
> -	REG_L x4,  PT_TP(sp)
> -	REG_L x5,  PT_T0(sp)
> -	REG_L x6,  PT_T1(sp)
> -	REG_L x7,  PT_T2(sp)
> -	REG_L x8,  PT_S0(sp)
> -	REG_L x9,  PT_S1(sp)
> -	REG_L x10, PT_A0(sp)
> -	REG_L x11, PT_A1(sp)
> -	REG_L x12, PT_A2(sp)
> -	REG_L x13, PT_A3(sp)
> -	REG_L x14, PT_A4(sp)
> -	REG_L x15, PT_A5(sp)
> -	REG_L x16, PT_A6(sp)
> -	REG_L x17, PT_A7(sp)
> -	REG_L x18, PT_S2(sp)
> -	REG_L x19, PT_S3(sp)
> -	REG_L x20, PT_S4(sp)
> -	REG_L x21, PT_S5(sp)
> -	REG_L x22, PT_S6(sp)
> -	REG_L x23, PT_S7(sp)
> -	REG_L x24, PT_S8(sp)
> -	REG_L x25, PT_S9(sp)
> -	REG_L x26, PT_S10(sp)
> -	REG_L x27, PT_S11(sp)
> -	REG_L x28, PT_T3(sp)
> -	REG_L x29, PT_T4(sp)
> -	REG_L x30, PT_T5(sp)
> -	REG_L x31, PT_T6(sp)
> -	.endm
> +#include "kprobes_trampoline.h"
>  
>  ENTRY(__kretprobe_trampoline)
>  	addi sp, sp, -(PT_SIZE_ON_STACK)
> diff --git a/arch/riscv/kernel/probes/kprobes_trampoline.h b/arch/riscv/kernel/probes/kprobes_trampoline.h
> new file mode 100644
> index 000000000..48895a5e3
> --- /dev/null
> +++ b/arch/riscv/kernel/probes/kprobes_trampoline.h
> @@ -0,0 +1,79 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +#ifndef _KPROBES_TRAMPOLINE_H
> +#define _KPROBES_TRAMPOLINE_H
> +/*
> + * Author: Patrick Stählin <me@packi.ch>
> + */
> +#include <linux/linkage.h>
> +
> +#include <asm/asm.h>
> +#include <asm/asm-offsets.h>
> +
> +	.text
> +	.altmacro
> +
> +	.macro save_all_base_regs
> +	REG_S x1,  PT_RA(sp)
> +	REG_S x3,  PT_GP(sp)
> +	REG_S x4,  PT_TP(sp)
> +	REG_S x5,  PT_T0(sp)
> +	REG_S x6,  PT_T1(sp)
> +	REG_S x7,  PT_T2(sp)
> +	REG_S x8,  PT_S0(sp)
> +	REG_S x9,  PT_S1(sp)
> +	REG_S x10, PT_A0(sp)
> +	REG_S x11, PT_A1(sp)
> +	REG_S x12, PT_A2(sp)
> +	REG_S x13, PT_A3(sp)
> +	REG_S x14, PT_A4(sp)
> +	REG_S x15, PT_A5(sp)
> +	REG_S x16, PT_A6(sp)
> +	REG_S x17, PT_A7(sp)
> +	REG_S x18, PT_S2(sp)
> +	REG_S x19, PT_S3(sp)
> +	REG_S x20, PT_S4(sp)
> +	REG_S x21, PT_S5(sp)
> +	REG_S x22, PT_S6(sp)
> +	REG_S x23, PT_S7(sp)
> +	REG_S x24, PT_S8(sp)
> +	REG_S x25, PT_S9(sp)
> +	REG_S x26, PT_S10(sp)
> +	REG_S x27, PT_S11(sp)
> +	REG_S x28, PT_T3(sp)
> +	REG_S x29, PT_T4(sp)
> +	REG_S x30, PT_T5(sp)
> +	REG_S x31, PT_T6(sp)
> +	.endm
> +
> +	.macro restore_all_base_regs
> +	REG_L x3,  PT_GP(sp)
> +	REG_L x4,  PT_TP(sp)
> +	REG_L x5,  PT_T0(sp)
> +	REG_L x6,  PT_T1(sp)
> +	REG_L x7,  PT_T2(sp)
> +	REG_L x8,  PT_S0(sp)
> +	REG_L x9,  PT_S1(sp)
> +	REG_L x10, PT_A0(sp)
> +	REG_L x11, PT_A1(sp)
> +	REG_L x12, PT_A2(sp)
> +	REG_L x13, PT_A3(sp)
> +	REG_L x14, PT_A4(sp)
> +	REG_L x15, PT_A5(sp)
> +	REG_L x16, PT_A6(sp)
> +	REG_L x17, PT_A7(sp)
> +	REG_L x18, PT_S2(sp)
> +	REG_L x19, PT_S3(sp)
> +	REG_L x20, PT_S4(sp)
> +	REG_L x21, PT_S5(sp)
> +	REG_L x22, PT_S6(sp)
> +	REG_L x23, PT_S7(sp)
> +	REG_L x24, PT_S8(sp)
> +	REG_L x25, PT_S9(sp)
> +	REG_L x26, PT_S10(sp)
> +	REG_L x27, PT_S11(sp)
> +	REG_L x28, PT_T3(sp)
> +	REG_L x29, PT_T4(sp)
> +	REG_L x30, PT_T5(sp)
> +	REG_L x31, PT_T6(sp)
> +	.endm
> +#endif
> diff --git a/arch/riscv/kernel/probes/rethook.c b/arch/riscv/kernel/probes/rethook.c
> new file mode 100644
> index 000000000..47853bc36
> --- /dev/null
> +++ b/arch/riscv/kernel/probes/rethook.c
> @@ -0,0 +1,24 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Generic return hook for riscv.
> + */
> +
> +#include <linux/kprobes.h>
> +#include <linux/rethook.h>
> +
> +/* This is called from arch_rethook_trampoline() */
> +unsigned long __used arch_rethook_trampoline_callback(struct pt_regs *regs)
> +{
> +	return rethook_trampoline_handler(regs, regs->s0);
> +}
> +NOKPROBE_SYMBOL(arch_rethook_trampoline_callback);
> +
> +void arch_rethook_prepare(struct rethook_node *rhn, struct pt_regs *regs, bool mcount)
> +{
> +	rhn->ret_addr = regs->ra;
> +	rhn->frame = regs->s0;
> +
> +	/* replace return addr with trampoline */
> +	regs->ra = (u64)arch_rethook_trampoline;
> +}
> +NOKPROBE_SYMBOL(arch_rethook_prepare);
> diff --git a/arch/riscv/kernel/probes/rethook_trampoline.S b/arch/riscv/kernel/probes/rethook_trampoline.S
> new file mode 100644
> index 000000000..e81c3d4e0
> --- /dev/null
> +++ b/arch/riscv/kernel/probes/rethook_trampoline.S
> @@ -0,0 +1,22 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Author: Patrick Stählin <me@packi.ch>
> + */
> +#include "kprobes_trampoline.h"
> +
> +ENTRY(arch_rethook_trampoline)
> +	addi sp, sp, -(PT_SIZE_ON_STACK)
> +	save_all_base_regs
> +
> +	move a0, sp /* pt_regs */
> +
> +	call arch_rethook_trampoline_callback
> +
> +	/* use the result as the return-address */
> +	move ra, a0
> +
> +	restore_all_base_regs
> +	addi sp, sp, PT_SIZE_ON_STACK
> +
> +	ret
> +ENDPROC(arch_rethook_trampoline)
> diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
> index 55041d2f8..a3805b5b2 100644
> --- a/include/linux/kprobes.h
> +++ b/include/linux/kprobes.h
> @@ -210,6 +210,12 @@ static nokprobe_inline unsigned long get_kretprobe_retaddr(struct kretprobe_inst
>  {
>  	return ri->node.ret_addr;
>  }
> +static nokprobe_inline
> +unsigned long kretprobe_trampoline_handler(struct pt_regs *regs,
> +					   void *frame_pointer)
> +{
> +	return 0;
> +}
>  #else
>  extern void arch_prepare_kretprobe(struct kretprobe_instance *ri,
>  				   struct pt_regs *regs);
> 
> base-commit: f30480cdeafc79d1f017d41335a96d8e3b973c91
> -- 
> 2.25.1
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
