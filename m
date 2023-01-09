Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 174C8663088
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 20:36:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237542AbjAITgi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 14:36:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237580AbjAITge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 14:36:34 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBA6B68CBD
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 11:36:27 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id o15so7051212wmr.4
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 11:36:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pSQlmry6UNdMQxGJQAckQUvJ0bGU2jDGpj+KZAihebs=;
        b=c3HwC8VMWkP7bfgYY9keIJZaxYD+GVMRkGqgV5uXsYSnZhYqHEcM8KNjXvpVeM6JJb
         Jj1+gzWpmdwbBdC+HA4w2h0IGtGCvu3w5VhVzsYG7H2wyTgnJH6YbFs6hz4hIQmi1oFP
         FA+V7or1Rz+mHoZyc3hwwpyioZ9ZSHCCgh+IyXgwC////a67coWMfw0k2dOlFNqpou0v
         Un4cCcRMDuf1FtsiXYbih7HZ7pZsAeVm+c+icNWdcfUAobcK/nLwF5UYi65JdMpvovdH
         6yZgnquuEIl04G2g0zSHYEk5PoSFzNI0vs4q7SYr5DE2YwpGdJtV6Bch0RjzwbWDmfQw
         hRyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pSQlmry6UNdMQxGJQAckQUvJ0bGU2jDGpj+KZAihebs=;
        b=k6o3lHdfCTDDNOplQtsqQ1vEGnF9w+iI67L7u9dZvlbfYFQqGbyXnCmm9EuOzNQnZ4
         f98+ub/VHCDjjO+oy9hRZAsoKKCaiExAyHPOpXUyumrq4XmIsbe5HmuRK8C5dLA7i0FW
         5w1C1D0eVtpS8m1hOfnSdFrovUOaMt4sFHLo9ruBHZJeiFjOiJaDSpxnS6CiPDFlshDK
         gnez6cvTDk0hMrx06lEswMu3Ji3Tut+lyUVee0hgSKkCgzZ42kDJxvjZGWo1B771FGvI
         OazJZRBzUg/QJCcz0IgBeEW+gP4FDZPNx4QnmSPIh5pM1hznP9U+FCUWUzbvC1pJIGOs
         TQdQ==
X-Gm-Message-State: AFqh2kobkqcSCasrx+1HyFxZWsCt+HEvX0p43FA7GpeN3kE+1jXpbQhD
        YhiBqovINxD1ZGoAK/LOU3rjLg==
X-Google-Smtp-Source: AMrXdXsgbv/NS+FuIoskl7vnUxa3OiRnzRYW6NQGEZUKTfLPBHgYRTk5lvcV9/71SsmgPCBGqu61JA==
X-Received: by 2002:a05:600c:4920:b0:3d3:39a9:e659 with SMTP id f32-20020a05600c492000b003d339a9e659mr50181172wmp.21.1673292986283;
        Mon, 09 Jan 2023 11:36:26 -0800 (PST)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id u24-20020adfa198000000b002bc84c55758sm629953wru.63.2023.01.09.11.36.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 11:36:25 -0800 (PST)
Date:   Mon, 9 Jan 2023 20:36:24 +0100
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Sia Jee Heng <jeeheng.sia@starfivetech.com>
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, leyfoon.tan@starfivetech.com,
        mason.huo@starfivetech.com
Subject: Re: [PATCH v2 3/3] RISC-V: Add arch functions to support
 hibernation/suspend-to-disk
Message-ID: <20230109193624.iiuguwgimpn7zbyw@orel>
References: <20230109062407.3235-1-jeeheng.sia@starfivetech.com>
 <20230109062407.3235-4-jeeheng.sia@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230109062407.3235-4-jeeheng.sia@starfivetech.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 09, 2023 at 02:24:07PM +0800, Sia Jee Heng wrote:
> Low level Arch functions were created to support hibernation.
> swsusp_arch_suspend() relies code from __cpu_suspend_enter() to write
> cpu state onto the stack, then calling swsusp_save() to save the memory
> image.
> 
> arch_hibernation_header_restore() and arch_hibernation_header_save()
> functions are implemented to prevent kernel crash when resume,
> the kernel built version is saved into the hibernation image header
> to making sure only the same kernel is restore when resume.

Why does it crash with the generic version check?

> 
> swsusp_arch_resume() creates a temporary page table that covering only
> the linear map, copies the restore code to a 'safe' page, then start to
> restore the memory image. Once completed, it restores the original
> kernel's page table. It then calls into __hibernate_cpu_resume()
> to restore the CPU context. Finally, it follows the normal hibernation
> path back to the hibernation core.
> 
> To enable hibernation/suspend to disk into RISCV, the below config
> need to be enabled:
> - CONFIG_ARCH_HIBERNATION_HEADER
> - CONFIG_ARCH_HIBERNATION_POSSIBLE
> - CONFIG_ARCH_RV64I
> - CONFIG_64BIT

What's blocking this for being for both 32-bit and 64-bit?

> 
> Signed-off-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>
> Reviewed-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>
> Reviewed-by: Mason Huo <mason.huo@starfivetech.com>
> ---
>  arch/riscv/Kconfig                |   8 +
>  arch/riscv/include/asm/suspend.h  |  20 ++
>  arch/riscv/kernel/Makefile        |   2 +-
>  arch/riscv/kernel/asm-offsets.c   |   5 +
>  arch/riscv/kernel/hibernate-asm.S | 123 +++++++++++
>  arch/riscv/kernel/hibernate.c     | 353 ++++++++++++++++++++++++++++++
>  6 files changed, 510 insertions(+), 1 deletion(-)
>  create mode 100644 arch/riscv/kernel/hibernate-asm.S
>  create mode 100644 arch/riscv/kernel/hibernate.c
> 
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index e2b656043abf..3c2607b6bda7 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -690,6 +690,14 @@ menu "Power management options"
>  
>  source "kernel/power/Kconfig"
>  
> +config ARCH_HIBERNATION_POSSIBLE
> +	def_bool y
> +	depends on 64BIT
> +
> +config ARCH_HIBERNATION_HEADER
> +	def_bool y
> +	depends on HIBERNATION && 64BIT
> +
>  endmenu # "Power management options"
>  
>  menu "CPU Power Management"
> diff --git a/arch/riscv/include/asm/suspend.h b/arch/riscv/include/asm/suspend.h
> index 75419c5ca272..ebaf103aec40 100644
> --- a/arch/riscv/include/asm/suspend.h
> +++ b/arch/riscv/include/asm/suspend.h
> @@ -21,6 +21,11 @@ struct suspend_context {
>  #endif
>  };
>  
> +/* This parameter will be assigned to 0 during resume and will be used by
> + * hibernation core for the subsequent resume sequence
> + */

Need /* on its own line

> +extern int in_suspend;

This declaration could be in arch/riscv/kernel/hibernate.c

> +
>  /* Low-level CPU suspend entry function */
>  int __cpu_suspend_enter(struct suspend_context *context);
>  
> @@ -36,4 +41,19 @@ int __cpu_resume_enter(unsigned long hartid, unsigned long context);
>  /* Used to save and restore the csr */
>  void suspend_save_csrs(struct suspend_context *context);
>  void suspend_restore_csrs(struct suspend_context *context);
> +
> +/* Low-level API to support hibernation */
> +int swsusp_arch_suspend(void);
> +int swsusp_arch_resume(void);
> +int arch_hibernation_header_save(void *addr, unsigned int max_size);
> +int arch_hibernation_header_restore(void *addr);
> +int __hibernate_cpu_resume(void);
> +
> +/* Used to resume on the CPU we hibernated on */
> +int hibernate_resume_nonboot_cpu_disable(void);
> +
> +/* Used to restore the hibernated image */
> +asmlinkage void restore_image(unsigned long resume_satp, unsigned long satp_temp,
> +				unsigned long cpu_resume);
> +asmlinkage int core_restore_code(void);
>  #endif
> diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
> index 4cf303a779ab..df83b8cea631 100644
> --- a/arch/riscv/kernel/Makefile
> +++ b/arch/riscv/kernel/Makefile
> @@ -64,7 +64,7 @@ obj-$(CONFIG_MODULES)		+= module.o
>  obj-$(CONFIG_MODULE_SECTIONS)	+= module-sections.o
>  
>  obj-$(CONFIG_CPU_PM)		+= suspend_entry.o suspend.o
> -
> +obj-$(CONFIG_HIBERNATION)	+= hibernate.o hibernate-asm.o

Need blank line here

>  obj-$(CONFIG_FUNCTION_TRACER)	+= mcount.o ftrace.o
>  obj-$(CONFIG_DYNAMIC_FTRACE)	+= mcount-dyn.o
>  
> diff --git a/arch/riscv/kernel/asm-offsets.c b/arch/riscv/kernel/asm-offsets.c
> index df9444397908..d6a75aac1d27 100644
> --- a/arch/riscv/kernel/asm-offsets.c
> +++ b/arch/riscv/kernel/asm-offsets.c
> @@ -9,6 +9,7 @@
>  #include <linux/kbuild.h>
>  #include <linux/mm.h>
>  #include <linux/sched.h>
> +#include <linux/suspend.h>
>  #include <asm/kvm_host.h>
>  #include <asm/thread_info.h>
>  #include <asm/ptrace.h>
> @@ -116,6 +117,10 @@ void asm_offsets(void)
>  
>  	OFFSET(SUSPEND_CONTEXT_REGS, suspend_context, regs);
>  
> +	OFFSET(HIBERN_PBE_ADDR, pbe, address);
> +	OFFSET(HIBERN_PBE_ORIG, pbe, orig_address);
> +	OFFSET(HIBERN_PBE_NEXT, pbe, next);
> +
>  	OFFSET(KVM_ARCH_GUEST_ZERO, kvm_vcpu_arch, guest_context.zero);
>  	OFFSET(KVM_ARCH_GUEST_RA, kvm_vcpu_arch, guest_context.ra);
>  	OFFSET(KVM_ARCH_GUEST_SP, kvm_vcpu_arch, guest_context.sp);
> diff --git a/arch/riscv/kernel/hibernate-asm.S b/arch/riscv/kernel/hibernate-asm.S
> new file mode 100644
> index 000000000000..81d9dc98d0ad
> --- /dev/null
> +++ b/arch/riscv/kernel/hibernate-asm.S
> @@ -0,0 +1,123 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Hibernation support specific for RISCV
> + *
> + * Copyright (C) 2023 StarFive Technology Co., Ltd.
> + *
> + * Author: Jee Heng Sia <jeeheng.sia@starfivetech.com>
> + */
> +
> +#include <asm/asm.h>
> +#include <asm/asm-offsets.h>
> +#include <asm/csr.h>
> +#include <linux/linkage.h>
> +
> +/*
> + * These code are to be executed when resume from the hibernation.

This code is executed when resuming from hibernation.

> + *
> + * It begins with loads the temporary page table then restores the memory image.

loading

> + * Finally branches to __hibernate_cpu_resume() to restore the state saved by
> + * swsusp_arch_suspend().
> + */
> +
> +/*
> + * int __hibernate_cpu_resume(void)
> + * Switch back to the hibernated image's page table prior to restore the CPU
> + * context.
> + *
> + * Always returns 0 to the C code.
> + */
> +ENTRY(__hibernate_cpu_resume)
> +        /* switch to hibernated image's page table */
> +        csrw CSR_SATP, s0
> +        sfence.vma
> +
> +	ld	a0, hibernate_cpu_context
> +

From here down it's the same as what's in __cpu_resume_enter, so we could
factor it out of __cpu_resume_enter into a macro rather than duplicate it.

> +	/* Restore CSRs */
> +	REG_L   t0, (SUSPEND_CONTEXT_REGS + PT_EPC)(a0)
> +	csrw    CSR_EPC, t0
> +	REG_L   t0, (SUSPEND_CONTEXT_REGS + PT_STATUS)(a0)
> +	csrw    CSR_STATUS, t0
> +	REG_L   t0, (SUSPEND_CONTEXT_REGS + PT_BADADDR)(a0)
> +	csrw    CSR_TVAL, t0
> +	REG_L   t0, (SUSPEND_CONTEXT_REGS + PT_CAUSE)(a0)
> +	csrw    CSR_CAUSE, t0
> +
> +	/* Restore registers (except A0 and T0-T6) */
> +	REG_L   ra, (SUSPEND_CONTEXT_REGS + PT_RA)(a0)
> +	REG_L   sp, (SUSPEND_CONTEXT_REGS + PT_SP)(a0)
> +	REG_L   gp, (SUSPEND_CONTEXT_REGS + PT_GP)(a0)
> +	REG_L   tp, (SUSPEND_CONTEXT_REGS + PT_TP)(a0)
> +
> +	REG_L   s0, (SUSPEND_CONTEXT_REGS + PT_S0)(a0)
> +	REG_L   s1, (SUSPEND_CONTEXT_REGS + PT_S1)(a0)
> +	REG_L   a1, (SUSPEND_CONTEXT_REGS + PT_A1)(a0)
> +	REG_L   a2, (SUSPEND_CONTEXT_REGS + PT_A2)(a0)
> +	REG_L   a3, (SUSPEND_CONTEXT_REGS + PT_A3)(a0)
> +	REG_L   a4, (SUSPEND_CONTEXT_REGS + PT_A4)(a0)
> +	REG_L   a5, (SUSPEND_CONTEXT_REGS + PT_A5)(a0)
> +	REG_L   a6, (SUSPEND_CONTEXT_REGS + PT_A6)(a0)
> +	REG_L   a7, (SUSPEND_CONTEXT_REGS + PT_A7)(a0)
> +	REG_L   s2, (SUSPEND_CONTEXT_REGS + PT_S2)(a0)
> +	REG_L   s3, (SUSPEND_CONTEXT_REGS + PT_S3)(a0)
> +	REG_L   s4, (SUSPEND_CONTEXT_REGS + PT_S4)(a0)
> +	REG_L   s5, (SUSPEND_CONTEXT_REGS + PT_S5)(a0)
> +	REG_L   s6, (SUSPEND_CONTEXT_REGS + PT_S6)(a0)
> +	REG_L   s7, (SUSPEND_CONTEXT_REGS + PT_S7)(a0)
> +	REG_L   s8, (SUSPEND_CONTEXT_REGS + PT_S8)(a0)
> +	REG_L   s9, (SUSPEND_CONTEXT_REGS + PT_S9)(a0)
> +	REG_L   s10, (SUSPEND_CONTEXT_REGS + PT_S10)(a0)
> +	REG_L   s11, (SUSPEND_CONTEXT_REGS + PT_S11)(a0)
> +
> +	/* Return zero value */
> +	add     a0, zero, zero
> +
> +	ret
> +END(__hibernate_cpu_resume)
> +
> +/*
> + * Prepare to restore the image.
> + * a0: satp of saved page tables
> + * a1: satp of temporary page tables
> + * a2: cpu_resume
> + */
> +ENTRY(restore_image)
> +	mv	s0, a0
> +	mv	s1, a1
> +	mv	s2, a2
> +	ld      s4, restore_pblist
> +	ld	a1, relocated_restore_code
> +
> +	jalr	a1
> +END(restore_image)
> +
> +/*
> + * The below code will be executed from a 'safe' page.
> + * It first switches to the temporary page table, then start to copy the pages
> + * back to the original memory location. Finally, it jumps to the __hibernate_cpu_resume()
> + * to restore the CPU context.
> + */
> +ENTRY(core_restore_code)
> +	/* switch to temp page table */
> +	csrw satp, s1
> +	sfence.vma
> +	beqz	s4, done
> +loop:
> +	/* The below code will restore the hibernated image. */
> +	ld	a1, HIBERN_PBE_ADDR(s4)
> +	ld	a0, HIBERN_PBE_ORIG(s4)
> +
> +	lui     a4, 0x1
> +	add     a4, a4, a0
> +copy:	ld      a5, 0(a1)

copy label should get its own line and how about changing it,
loop, and done to local symbol names, e.g. .Lcopy?

> +	addi    a0, a0, 8
> +	addi    a1, a1, 8
> +	sd      a5, -8(a0)
> +	bne     a4, a0, copy
> +
> +	ld	s4, HIBERN_PBE_NEXT(s4)
> +	bnez	s4, loop
> +done:
> +	jalr	s2
> +END(core_restore_code)
> diff --git a/arch/riscv/kernel/hibernate.c b/arch/riscv/kernel/hibernate.c
> new file mode 100644
> index 000000000000..bd77c35958a8
> --- /dev/null
> +++ b/arch/riscv/kernel/hibernate.c
> @@ -0,0 +1,353 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Hibernation support specific for RISCV
> + *
> + * Copyright (C) 2023 StarFive Technology Co., Ltd.
> + *
> + * Author: Jee Heng Sia <jeeheng.sia@starfivetech.com>
> + */
> +
> +#include <asm/barrier.h>
> +#include <asm/cacheflush.h>
> +#include <asm/mmu_context.h>
> +#include <asm/page.h>
> +#include <asm/pgtable.h>
> +#include <asm/sections.h>
> +#include <asm/set_memory.h>
> +#include <asm/smp.h>
> +#include <asm/suspend.h>
> +
> +#include <linux/cpu.h>
> +#include <linux/memblock.h>
> +#include <linux/pm.h>
> +#include <linux/sched.h>
> +#include <linux/suspend.h>
> +#include <linux/utsname.h>
> +
> +/*
> + * The logical cpu number we should resume on, initialised to a non-cpu
> + * number.
> + */
> +static int sleep_cpu = -EINVAL;
> +
> +/* CPU context to be saved */
> +struct suspend_context *hibernate_cpu_context;
> +
> +unsigned long relocated_restore_code;
> +
> +/* Pointer to the temporary resume page tables */
> +pgd_t *resume_pg_dir;
> +
> +/*
> + * Save the build number and date so that the we are not resume with a different kernel
> + */
> +struct arch_hibernate_hdr_invariants {
> +	char		uts_version[__NEW_UTS_LEN + 1];
> +};
> +
> +/* Helper parameters that help us to restore the image.

Separate line for /*

> + * @hartid: To make sure same boot_cpu executing the hibernate/restore code.
> + * @saved_satp: Original page table used by the hibernated image.
> + * @restore_cpu_addr: The kernel's image address to restore the CPU context.
> + */
> +static struct arch_hibernate_hdr {
> +	struct arch_hibernate_hdr_invariants invariants;
> +	unsigned long	hartid;
> +	unsigned long	saved_satp;
> +	unsigned long	restore_cpu_addr;
> +} resume_hdr;
> +
> +static inline void arch_hdr_invariants(struct arch_hibernate_hdr_invariants *i)
> +{
> +	memset(i, 0, sizeof(*i));
> +	memcpy(i->uts_version, init_utsname()->version, sizeof(i->uts_version));
> +}
> +
> +/*
> + * Check if the given pfn is in the 'nosave' section.
> + */
> +int pfn_is_nosave(unsigned long pfn)
> +{
> +	unsigned long nosave_begin_pfn = sym_to_pfn(&__nosave_begin);
> +	unsigned long nosave_end_pfn = sym_to_pfn(&__nosave_end - 1);
> +
> +	return ((pfn >= nosave_begin_pfn) && (pfn <= nosave_end_pfn));
> +}
> +
> +void notrace save_processor_state(void)
> +{
> +	WARN_ON(num_online_cpus() != 1);
> +}
> +
> +void notrace restore_processor_state(void)
> +{
> +}
> +
> +/*
> + * Helper parameters need to be saved to the hibernation image header.
> + */
> +int arch_hibernation_header_save(void *addr, unsigned int max_size)
> +{
> +	struct arch_hibernate_hdr *hdr = addr;
> +
> +	if (max_size < sizeof(*hdr))
> +		return -EOVERFLOW;
> +
> +	arch_hdr_invariants(&hdr->invariants);
> +
> +	hdr->hartid = cpuid_to_hartid_map(sleep_cpu);
> +	hdr->saved_satp = csr_read(CSR_SATP);
> +	hdr->restore_cpu_addr = (unsigned long) __hibernate_cpu_resume;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(arch_hibernation_header_save);
> +
> +/*
> + * Retrieve the helper parameters from the hibernation image header
> + */
> +int arch_hibernation_header_restore(void *addr)
> +{
> +	struct arch_hibernate_hdr_invariants invariants;
> +	struct arch_hibernate_hdr *hdr = addr;
> +	int ret = 0;
> +
> +	arch_hdr_invariants(&invariants);
> +
> +	if (memcmp(&hdr->invariants, &invariants, sizeof(invariants))) {
> +		pr_crit("Hibernate image not generated by this kernel!\n");
> +		return -EINVAL;
> +	}
> +
> +	sleep_cpu = riscv_hartid_to_cpuid(hdr->hartid);
> +	if (sleep_cpu < 0) {
> +		pr_crit("Hibernated on a CPU not known to this kernel!\n");
> +		sleep_cpu = -EINVAL;
> +		return -EINVAL;
> +	}
> +
> +#ifdef CONFIG_SMP

The #ifdef shouldn't be necessary.

> +	ret = bringup_hibernate_cpu(sleep_cpu);
> +	if (ret) {
> +		sleep_cpu = -EINVAL;
> +		return ret;
> +	}
> +#endif
> +	resume_hdr = *hdr;
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL(arch_hibernation_header_restore);
> +
> +int swsusp_arch_suspend(void)
> +{
> +	int ret = 0;
> +
> +	if (__cpu_suspend_enter(hibernate_cpu_context)) {
> +		sleep_cpu = smp_processor_id();
> +		suspend_save_csrs(hibernate_cpu_context);
> +		ret = swsusp_save();
> +	} else {
> +		suspend_restore_csrs(hibernate_cpu_context);
> +		flush_tlb_all();
> +
> +		/* Invalidated Icache */
> +		flush_icache_all();
> +
> +		/*
> +		 * Tell the hibernation core that we've just restored
> +		 * the memory
> +		 */
> +		in_suspend = 0;
> +		sleep_cpu = -EINVAL;
> +	}
> +
> +	return ret;
> +}
> +
> +#define temp_pgtable_map_pgd_next(pgdp, vaddr, prot)			\
> +		(pgtable_l5_enabled ?					\
> +		temp_pgtable_map_p4d(pgdp, vaddr, prot) :		\
> +		(pgtable_l4_enabled ?					\
> +		temp_pgtable_map_pud((pud_t *)pgdp, vaddr, prot) :	\
> +		temp_pgtable_map_pmd((pmd_t *)pgdp, vaddr, prot)))
> +
> +static unsigned long temp_pgtable_map_pte(pte_t *ptep, unsigned long vaddr, pgprot_t prot)
> +{
> +	uintptr_t pte_idx = pte_index(vaddr);
> +
> +	ptep[pte_idx] = pfn_pte(PFN_DOWN(__pa(vaddr)), prot);
> +
> +	return 0;
> +}
> +
> +static unsigned long temp_pgtable_map_pmd(pmd_t *pmdp, unsigned long vaddr, pgprot_t prot)
> +{
> +	uintptr_t pmd_idx = pmd_index(vaddr);
> +	pte_t *ptep;
> +
> +	if (pmd_none(pmdp[pmd_idx])) {
> +		ptep = (pte_t *) get_safe_page(GFP_ATOMIC);

No space between cast and function. Same comment for following functions.
I thought checkpatch complained about that.

> +		if (!ptep)
> +			return -ENOMEM;
> +
> +		memset(ptep, 0, PAGE_SIZE);
> +		pmdp[pmd_idx] = pfn_pmd(PFN_DOWN(__pa(ptep)), PAGE_TABLE);
> +	} else {
> +		ptep = (pte_t *) __va(PFN_PHYS(_pmd_pfn(pmdp[pmd_idx])));
> +	}
> +
> +	return temp_pgtable_map_pte(ptep, vaddr, prot);
> +}
> +
> +static unsigned long temp_pgtable_map_pud(pud_t *pudp, unsigned long vaddr, pgprot_t prot)
> +{
> +
> +	uintptr_t pud_index = pud_index(vaddr);
> +	pmd_t *pmdp;
> +
> +	if (pud_val(pudp[pud_index]) == 0) {
> +		pmdp = (pmd_t *) get_safe_page(GFP_ATOMIC);
> +		if (!pmdp)
> +			return -ENOMEM;
> +
> +		memset(pmdp, 0, PAGE_SIZE);
> +		pudp[pud_index] = pfn_pud(PFN_DOWN(__pa(pmdp)), PAGE_TABLE);
> +	} else {
> +		pmdp = (pmd_t *) __va(PFN_PHYS(_pud_pfn(pudp[pud_index])));
> +	}
> +
> +	return temp_pgtable_map_pmd(pmdp, vaddr, prot);
> +}
> +
> +static unsigned long temp_pgtable_map_p4d(p4d_t *p4dp, unsigned long vaddr, pgprot_t prot)
> +{
> +	uintptr_t p4d_index = p4d_index(vaddr);
> +	pud_t *pudp;
> +
> +	if (p4d_val(p4dp[p4d_index]) == 0) {
> +		pudp = (pud_t *) get_safe_page(GFP_ATOMIC);
> +		if (!pudp)
> +			return -ENOMEM;
> +
> +		memset(pudp, 0, PAGE_SIZE);
> +		p4dp[p4d_index] = pfn_p4d(PFN_DOWN(__pa(pudp)), PAGE_TABLE);
> +	} else {
> +		pudp = (pud_t *) __va(PFN_PHYS(_p4d_pfn(p4dp[p4d_index])));
> +	}
> +
> +	return temp_pgtable_map_pud(pudp, vaddr, prot);
> +}
> +
> +static unsigned long temp_pgtable_map_pgd(pgd_t *pgdp, unsigned long vaddr, pgprot_t prot)
> +{
> +	uintptr_t pgd_idx = pgd_index(vaddr);
> +	void *nextp;
> +
> +	if (pgd_val(pgdp[pgd_idx]) == 0) {
> +		nextp = (void *) get_safe_page(GFP_ATOMIC);
> +		if (!nextp)
> +			return -ENOMEM;
> +
> +		memset(nextp, 0, PAGE_SIZE);
> +		pgdp[pgd_idx] = pfn_pgd(PFN_DOWN(__pa(nextp)), PAGE_TABLE);
> +	} else {
> +		nextp = (void *) __va(PFN_PHYS(_pgd_pfn(pgdp[pgd_idx])));
> +	}
> +
> +	return temp_pgtable_map_pgd_next(nextp, vaddr, prot);
> +}
> +
> +static unsigned long temp_pgtable_mapping(pgd_t *pgdp, unsigned long vaddr, pgprot_t prot)
> +{
> +	return temp_pgtable_map_pgd(pgdp, vaddr, prot);
> +}
> +
> +static unsigned long relocate_restore_code(void)
> +{
> +	unsigned long ret;
> +	void *page = (void *)get_safe_page(GFP_ATOMIC);
> +
> +	if (!page)
> +		return -ENOMEM;
> +
> +	copy_page(page, core_restore_code);
> +
> +	/* Make the page containing the relocated code executable */
> +	set_memory_x((unsigned long)page, 1);
> +
> +	ret = temp_pgtable_mapping(resume_pg_dir, (unsigned long)page, PAGE_KERNEL_READ_EXEC);
> +	if (ret)
> +		return ret;
> +
> +	return (unsigned long)page;
> +}
> +
> +int swsusp_arch_resume(void)
> +{
> +	unsigned long addr = PAGE_OFFSET;
> +	unsigned long ret;
> +
> +	/*
> +	 * Memory allocated by get_safe_page() will be dealt with by the hibernation core,
> +	 * we don't need to free it here.
> +	 */
> +	resume_pg_dir = (pgd_t *)get_safe_page(GFP_ATOMIC);
> +	if (!resume_pg_dir)
> +		return -ENOMEM;
> +
> +	/*
> +	 * The pages need to be wrote-able when restoring the image.

writable

> +	 * Create a second copy of page table just for the linear map, and use this when
> +	 * restoring.
> +	 */
> +	for (; addr <= (unsigned long)pfn_to_virt(max_low_pfn); addr += PAGE_SIZE) {
> +		ret = temp_pgtable_mapping(resume_pg_dir, addr, PAGE_KERNEL);
> +		if (ret)
> +			return (int) ret;
> +	}
> +
> +	/* Move the restore code to a new page so that it doesn't get overwritten by itself */
> +	relocated_restore_code = relocate_restore_code();
> +	if (relocated_restore_code == -ENOMEM)
> +		return -ENOMEM;
> +
> +	/* Map the __hibernate_cpu_resume() address to the temporary page table so that the
> +	 * restore code can jump to it after finished restore the image. The next execution
> +	 * code doesn't find itself in a different address space after switching over to the
> +	 * original page table used by the hibernated image.
> +	 */
> +	ret = temp_pgtable_mapping(resume_pg_dir, (unsigned long)resume_hdr.restore_cpu_addr,
> +				PAGE_KERNEL_READ_EXEC);
> +	if (ret)
> +		return ret;
> +
> +	restore_image(resume_hdr.saved_satp, (PFN_DOWN(__pa(resume_pg_dir)) | satp_mode),
> +			resume_hdr.restore_cpu_addr);
> +
> +	return 0;
> +}
> +
> +#ifdef CONFIG_SMP

Shouldn't this be CONFIG_PM_SLEEP_SMP ?

> +int hibernate_resume_nonboot_cpu_disable(void)
> +{
> +	if (sleep_cpu < 0) {
> +		pr_err("Failing to resume from hibernate on an unknown CPU.\n");
> +		return -ENODEV;
> +	}
> +
> +	return freeze_secondary_cpus(sleep_cpu);
> +}
> +#endif
> +
> +static int __init riscv_hibernate__init(void)

It's more typical to only have a single underscore.

> +{
> +	hibernate_cpu_context = kcalloc(1, sizeof(struct suspend_context), GFP_KERNEL);
> +
> +	if (WARN_ON(!hibernate_cpu_context))
> +		return -ENOMEM;
> +
> +	return 0;
> +}
> +
> +early_initcall(riscv_hibernate__init);
> -- 
> 2.34.1
> 
>

Besides some nits and a couple questions, this looks to me. I'll try to
find some time to experiment with it as well.

Thanks,
drew
