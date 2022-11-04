Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D7B061A3E5
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 23:09:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbiKDWJG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 18:09:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiKDWJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 18:09:01 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CE7A24BFE
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 15:09:00 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id io19so6095619plb.8
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 15:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=napPnSIw0O4XTTZP4wyQ6oPOXAEKNUr4s9A73CKQSGY=;
        b=kD7U+cpuu24FxYIN5EAreZ+Lgq4/6Lmu0A/TMirFktAtEnJ6s/fxEjpZwCHASc/pe1
         TDiNdvj+dOcC8LhggBtnkE46ljAq3pW23UkgihaSE8gBgkPhhCzFSB9VY2ZgAkHJhSEb
         q4VCV/91gDwk1BtNNky6RFeYPBdHCUQQWAQadkKY438p0y4ZUxOJ8Zs4CnxDGpzuP7Ai
         tFhD75PCzHmjqL6Kz7HTIuSZchB+VO8M/lRg2cDW+s5llYuLD0W2UZx57IiOMRRjqxDO
         s+WhrkXWQzJM73VUKB+0azHenEKMKkoOzzmqLAsZ8WWi+1ieIxWFLGFNAGwTf0W/VuUU
         fCpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=napPnSIw0O4XTTZP4wyQ6oPOXAEKNUr4s9A73CKQSGY=;
        b=ugO3Un3vgeF0qeRbb6bfVI5yF9zPLG1u1DUCV+JVfl0Lv32M1lKoQqjU0K0N8bk7Ok
         rtpC1SIzmVPShTltVEaUEjCuyv+TDrUuBJ1Bj5unmVJ/yxxOu7DbnT6rS91yhAgGqr8v
         /cZvIeJu6Hps50trtfDEUVqp2wOqR6DGnsD8y1Jj48xJjKfULox0qarTEScRV+To039K
         rblSr6tbpFNVUp7TCt2ZnxUg+rjPAO6mTp4+u6gXg3XSyK7daozk7AgKmWfLJWaKk3Wb
         yX4jwTXd0b2/PLQYJ2Nu0mIoYrsAmjyKkGIypHE5Y93/+nMLYEvdmd/Jy2AnZfWjvOsZ
         li8A==
X-Gm-Message-State: ACrzQf06aOQrVK+I2o1NTkgjEqmwFSWALDg2oXUzxzhzJKjKHRB46Aly
        dUQDsVlhIaxShC/1WgMISmLHdA==
X-Google-Smtp-Source: AMsMyM6oA5ahyPe5S23IV6l2y4Cn84YgPaoYV2u7BrPePhrp2+b/+qkXCRldxNDh4Izp85AArod68g==
X-Received: by 2002:a17:902:d4c4:b0:186:acb0:e93c with SMTP id o4-20020a170902d4c400b00186acb0e93cmr380593plg.141.1667599739868;
        Fri, 04 Nov 2022 15:08:59 -0700 (PDT)
Received: from [192.168.50.116] (c-24-4-73-83.hsd1.ca.comcast.net. [24.4.73.83])
        by smtp.gmail.com with ESMTPSA id m21-20020a170902bb9500b00186e2123506sm200448pls.300.2022.11.04.15.08.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Nov 2022 15:08:59 -0700 (PDT)
Message-ID: <013150d0-c2cd-847a-6e6d-3292035b208d@rivosinc.com>
Date:   Fri, 4 Nov 2022 15:08:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v12 08/17] riscv: Add task switch support for vector
Content-Language: en-US
To:     Chris Stillson <stillson@rivosinc.com>
Cc:     Greentime Hu <greentime.hu@sifive.com>,
        Andrew Waterman <andrew@sifive.com>,
        Nick Knight <nick.knight@sifive.com>,
        Guo Ren <guoren@linux.alibaba.com>,
        Vincent Chen <vincent.chen@sifive.com>,
        Ruinland Tsai <ruinland.tsai@sifive.com>,
        kernel test robot <lkp@intel.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>,
        Oleg Nesterov <oleg@redhat.com>, Guo Ren <guoren@kernel.org>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Andy Chiu <andy.chiu@sifive.com>
References: <20220921214439.1491510-1-stillson@rivosinc.com>
 <20220921214439.1491510-8-stillson@rivosinc.com>
From:   Vineet Gupta <vineetg@rivosinc.com>
In-Reply-To: <20220921214439.1491510-8-stillson@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/21/22 14:43, Chris Stillson wrote:
> From: Greentime Hu <greentime.hu@sifive.com>
> 
> This patch adds task switch support for vector. It supports partial lazy
> save and restore mechanism. It also supports all lengths of vlen.
> 
> [guoren@linux.alibaba.com: First available porting to support vector
> context switching]
> [nick.knight@sifive.com: Rewrite vector.S to support dynamic vlen, xlen and
> code refine]
> [vincent.chen@sifive.com: Fix the might_sleep issue in vstate_save,
> vstate_restore]
> [andrew@sifive.com: Optimize task switch codes of vector]
> [ruinland.tsai@sifive.com: Fix the arch_release_task_struct free wrong
> datap issue]
> 
> Suggested-by: Andrew Waterman <andrew@sifive.com>
> Co-developed-by: Nick Knight <nick.knight@sifive.com>
> Signed-off-by: Nick Knight <nick.knight@sifive.com>
> Co-developed-by: Guo Ren <guoren@linux.alibaba.com>
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Co-developed-by: Vincent Chen <vincent.chen@sifive.com>
> Signed-off-by: Vincent Chen <vincent.chen@sifive.com>
> Co-developed-by: Ruinland Tsai <ruinland.tsai@sifive.com>
> Signed-off-by: Ruinland Tsai <ruinland.tsai@sifive.com>
> Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: kernel test robot <lkp@intel.com>
> ---
>   arch/riscv/include/asm/switch_to.h | 66 ++++++++++++++++++++++++++++++
>   arch/riscv/kernel/Makefile         |  1 +
>   arch/riscv/kernel/process.c        | 43 +++++++++++++++++++
>   3 files changed, 110 insertions(+)
> 
> diff --git a/arch/riscv/include/asm/switch_to.h b/arch/riscv/include/asm/switch_to.h
> index df1aa589b7fd..527951c033d4 100644
> --- a/arch/riscv/include/asm/switch_to.h
> +++ b/arch/riscv/include/asm/switch_to.h
> @@ -7,11 +7,13 @@
>   #define _ASM_RISCV_SWITCH_TO_H
>   
>   #include <linux/jump_label.h>
> +#include <linux/slab.h>
>   #include <linux/sched/task_stack.h>
>   #include <asm/hwcap.h>
>   #include <asm/processor.h>
>   #include <asm/ptrace.h>
>   #include <asm/csr.h>
> +#include <asm/asm-offsets.h>
>   
>   #ifdef CONFIG_FPU
>   extern void __fstate_save(struct task_struct *save_to);
> @@ -68,6 +70,68 @@ static __always_inline bool has_fpu(void) { return false; }
>   #define __switch_to_fpu(__prev, __next) do { } while (0)
>   #endif
>   
> +#ifdef CONFIG_VECTOR
> +extern struct static_key_false cpu_hwcap_vector;
> +static __always_inline bool has_vector(void)
> +{
> +	return static_branch_likely(&cpu_hwcap_vector);
> +}
> +extern unsigned long riscv_vsize;
> +extern void __vstate_save(struct __riscv_v_state *save_to, void *datap);
> +extern void __vstate_restore(struct __riscv_v_state *restore_from, void *datap);
> +
> +static inline void __vstate_clean(struct pt_regs *regs)
> +{
> +	regs->status = (regs->status & ~(SR_VS)) | SR_VS_CLEAN;
> +}
> +
> +static inline void vstate_off(struct task_struct *task,
> +			      struct pt_regs *regs)
> +{
> +	regs->status = (regs->status & ~SR_VS) | SR_VS_OFF;
> +}
> +
> +static inline void vstate_save(struct task_struct *task,
> +			       struct pt_regs *regs)
> +{
> +	if ((regs->status & SR_VS) == SR_VS_DIRTY) {
> +		struct __riscv_v_state *vstate = &(task->thread.vstate);
> +
> +		__vstate_save(vstate, vstate->datap);
> +		__vstate_clean(regs);
> +	}
> +}
> +
> +static inline void vstate_restore(struct task_struct *task,
> +				  struct pt_regs *regs)
> +{
> +	if ((regs->status & SR_VS) != SR_VS_OFF) {
> +		struct __riscv_v_state *vstate = &(task->thread.vstate);
> +
> +		__vstate_restore(vstate, vstate->datap);
> +		__vstate_clean(regs);
> +	}
> +}
> +
> +static inline void __switch_to_vector(struct task_struct *prev,
> +				   struct task_struct *next)
> +{
> +	struct pt_regs *regs;
> +
> +	regs = task_pt_regs(prev);
> +	if (unlikely(regs->status & SR_SD))
> +		vstate_save(prev, regs);
> +	vstate_restore(next, task_pt_regs(next));
> +}
> +
> +#else
> +static __always_inline bool has_vector(void) { return false; }
> +#define riscv_vsize (0)
> +#define vstate_save(task, regs) do { } while (0)
> +#define vstate_restore(task, regs) do { } while (0)
> +#define __switch_to_vector(__prev, __next) do { } while (0)
> +#endif

All of this needs to be moved into vector.h for better containment.
I would also wire in struct __riscv_v_state vstate in struct 
thread_struct in this patch.


> diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
> index 33bb60a354cd..35752fb6d145 100644
> --- a/arch/riscv/kernel/Makefile
> +++ b/arch/riscv/kernel/Makefile
> @@ -55,6 +55,7 @@ obj-$(CONFIG_MMU) += vdso.o vdso/
>   
>   obj-$(CONFIG_RISCV_M_MODE)	+= traps_misaligned.o
>   obj-$(CONFIG_FPU)		+= fpu.o
> +obj-$(CONFIG_VECTOR)		+= vector.o

This needs to go into last patch which adds Kconfig/Makefile enabling.

> +
> +	if (has_vector()) {

Would it make sense to add IS_ENABLED(CONFIG_VECTOR) inside this helper 
- would help compiler remove the codegen completely for !VECTOR but 
still having some build test coverage. Anyhow this is minor point and 
can be added later.

> +		struct __riscv_v_state *vstate = &(current->thread.vstate);
> +
> +		/* Enable vector and allocate memory for vector registers. */
> +		if (!vstate->datap) {
> +			vstate->datap = kzalloc(riscv_vsize, GFP_KERNEL);
> +			if (WARN_ON(!vstate->datap))
> +				return;
> +		}
> +		regs->status |= SR_VS_INITIAL;
> +
> +		/*
> +		 * Restore the initial value to the vector register
> +		 * before starting the user program.
> +		 */
> +		vstate_restore(current, regs);
> +	}
> +

...

> +#ifdef CONFIG_VECTOR
> +	/* Reset vector state */
> +	vstate_off(current, task_pt_regs(current));
> +	memset(&current->thread.vstate, 0, RISCV_V_STATE_DATAP);
> +#endif

This doesn't check has_vector() as we want to unconditionally clean 
memory for security reasons ?


>   }
>   
>   int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
>   {
>   	fstate_save(src, task_pt_regs(src));
>   	*dst = *src;
> +	dst->thread.vstate.datap = NULL;

has_vector() needed here ?

>   
> +void arch_release_task_struct(struct task_struct *tsk)
> +{
> +	/* Free the vector context of datap. */
> +	if (has_vector() && tsk->thread.vstate.datap)
> +		kfree(tsk->thread.vstate.datap);
> +}
> +
>   int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
>   {
>   	unsigned long clone_flags = args->flags;
> @@ -175,7 +208,17 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
>   		p->thread.ra = (unsigned long)ret_from_kernel_thread;
>   		p->thread.s[0] = (unsigned long)args->fn;
>   		p->thread.s[1] = (unsigned long)args->fn_arg;
> +		p->thread.vstate.datap = NULL;
>   	} else {
> +		/* Allocate the datap for the user process if datap is NULL */
> +		if (has_vector() && !p->thread.vstate.datap) {
> +			void *datap = kzalloc(riscv_vsize, GFP_KERNEL);
> +			/* Failed to allocate memory. */
> +			if (!datap)
> +				return -ENOMEM;
> +			p->thread.vstate.datap = datap;
> +			memset(&p->thread.vstate, 0, RISCV_V_STATE_DATAP);
> +		}
>   		*childregs = *(current_pt_regs());
>   		if (usp) /* User fork */
>   			childregs->sp = usp;

