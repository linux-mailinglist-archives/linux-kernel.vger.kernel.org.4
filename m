Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 660FE6A411B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 12:44:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbjB0Loo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 06:44:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjB0Lom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 06:44:42 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 912A35FF1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 03:44:38 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id j2so5861375wrh.9
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 03:44:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ieR0lkkYccPU/wlWq0ah5B7fldQ1kQR/ZotQsJjiHYs=;
        b=IgNlpPt3P4wxMo+R8yHwi10iuvs6vg9hmxyr70cTNq6jHFqowxSE07GOAco0b9sVYR
         T9iaGIdwoSYyJo8UL56FxUHFGbAHDhpuIpsdMGRFeaBkdLjXm5Je4DdG64NjkVp7CZna
         eHJo60OcfN0nLroWae4goDzSCjqe1Wa64X/ltjKciOekNXuo4ee3g1x/xEyw6MSSWNct
         Ft5c/TruYbFVrODfRoAEuHfE5trkD2YXKgs5w+RW7vqnMM3uIVmXV/Hi3xd+TQMp9soa
         qMM2n/X8WiMAlJLAqWa4iLQj0aZYFunTSRAQn9eDnIVt9DDr826lE2Smu0DPSicwgnY1
         G86A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ieR0lkkYccPU/wlWq0ah5B7fldQ1kQR/ZotQsJjiHYs=;
        b=TBXd3yzLEzx9O99LS3Gg7+E1RHpROrTv+Nn5u9j4zgWsl0LRIbN0D/VF23CKEHYRys
         Ip0dNF5v3tdy6MRkvoTk+gTX/qckpqlvp1k0juTsy6IjwB/LIO5ldBNV8R6c4hp9L4Fl
         FWbgDJCYZxai59cmYjccnHMFbG1kDf1gq1BeVcfeZ48gNTvjfrZACbg7eBWrHAPY2hOI
         gZ25tDcPUe8CCrY8SGFNYnGO24VWwmF6n4wxZoqA3SFXH0423dKlMnUB4MnYCqH7I79H
         Xpw4K5CSjB/emUz7ff9Cf1e2K2hd7PVjT7nMojCXFnkmvobkOnod5wM35j5TDSGKGdiD
         a5pA==
X-Gm-Message-State: AO0yUKVnTXa1kTNrsLoDz0jIy2wzvwws0Fl8iUD2Y5rN7LFbmo/YTYTG
        HjGvZZwa9mHB6BIbpeUaNJHZu4Cra/u2df2Z
X-Google-Smtp-Source: AK7set9v5eIm/ClQV0OFAEiOR62kwfB7w3HA7RIuEnKnsN56nRZQRADGmkcFM6qlHD+dNgj46SS6yQ==
X-Received: by 2002:adf:efc2:0:b0:2c7:60f5:e1b with SMTP id i2-20020adfefc2000000b002c760f50e1bmr6918229wrp.22.1677498276972;
        Mon, 27 Feb 2023 03:44:36 -0800 (PST)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id v16-20020a5d4a50000000b002c5526234d2sm6984834wrs.8.2023.02.27.03.44.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 03:44:36 -0800 (PST)
Date:   Mon, 27 Feb 2023 12:44:35 +0100
From:   Andrew Jones <ajones@ventanamicro.com>
To:     JeeHeng Sia <jeeheng.sia@starfivetech.com>
Cc:     "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Leyfoon Tan <leyfoon.tan@starfivetech.com>,
        Mason Huo <mason.huo@starfivetech.com>
Subject: Re: [PATCH v4 4/4] RISC-V: Add arch functions to support
 hibernation/suspend-to-disk
Message-ID: <20230227114435.eow57ax5zhysz3kv@orel>
References: <20230223180720.55fgbxzlx6xvzgms@orel>
 <b26264a20b5f4bc5abfc6dd87aa4e38f@EXMBX066.cuchost.com>
 <20230224090010.nmy6latszfkdqcft@orel>
 <9cfd485d1e0d46cdb1323bb6ea330f6e@EXMBX066.cuchost.com>
 <20230224095526.ctctpzw3p3csf6qj@orel>
 <24a6dbe6aa2043c7812bf7e258786e13@EXMBX066.cuchost.com>
 <20230224120715.wgqnqmkadsbqusus@orel>
 <180fda36f9974809b436c52e4b3eda58@EXMBX066.cuchost.com>
 <20230227075942.rgl4hqnwttwvoroe@orel>
 <178ca008701147828d2e62402ff4f78a@EXMBX066.cuchost.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178ca008701147828d2e62402ff4f78a@EXMBX066.cuchost.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 27, 2023 at 10:52:32AM +0000, JeeHeng Sia wrote:
> 
> 
> > -----Original Message-----
> > From: Andrew Jones <ajones@ventanamicro.com>
> > Sent: Monday, 27 February, 2023 4:00 PM
> > To: JeeHeng Sia <jeeheng.sia@starfivetech.com>
> > Cc: paul.walmsley@sifive.com; palmer@dabbelt.com; aou@eecs.berkeley.edu; linux-riscv@lists.infradead.org; linux-
> > kernel@vger.kernel.org; Leyfoon Tan <leyfoon.tan@starfivetech.com>; Mason Huo <mason.huo@starfivetech.com>
> > Subject: Re: [PATCH v4 4/4] RISC-V: Add arch functions to support hibernation/suspend-to-disk
> > 
> > On Mon, Feb 27, 2023 at 02:14:27AM +0000, JeeHeng Sia wrote:
> > >
> > >
> > > > -----Original Message-----
> > > > From: Andrew Jones <ajones@ventanamicro.com>
> > > > Sent: Friday, 24 February, 2023 8:07 PM
> > > > To: JeeHeng Sia <jeeheng.sia@starfivetech.com>
> > > > Cc: paul.walmsley@sifive.com; palmer@dabbelt.com; aou@eecs.berkeley.edu; linux-riscv@lists.infradead.org; linux-
> > > > kernel@vger.kernel.org; Leyfoon Tan <leyfoon.tan@starfivetech.com>; Mason Huo <mason.huo@starfivetech.com>
> > > > Subject: Re: [PATCH v4 4/4] RISC-V: Add arch functions to support hibernation/suspend-to-disk
> > > >
> > > > On Fri, Feb 24, 2023 at 10:30:19AM +0000, JeeHeng Sia wrote:
> > > > >
> > > > >
> > > > > > -----Original Message-----
> > > > > > From: Andrew Jones <ajones@ventanamicro.com>
> > > > > > Sent: Friday, 24 February, 2023 5:55 PM
> > > > > > To: JeeHeng Sia <jeeheng.sia@starfivetech.com>
> > > > > > Cc: paul.walmsley@sifive.com; palmer@dabbelt.com; aou@eecs.berkeley.edu; linux-riscv@lists.infradead.org; linux-
> > > > > > kernel@vger.kernel.org; Leyfoon Tan <leyfoon.tan@starfivetech.com>; Mason Huo <mason.huo@starfivetech.com>
> > > > > > Subject: Re: [PATCH v4 4/4] RISC-V: Add arch functions to support hibernation/suspend-to-disk
> > > > > >
> > > > > > On Fri, Feb 24, 2023 at 09:33:31AM +0000, JeeHeng Sia wrote:
> > > > > > >
> > > > > > >
> > > > > > > > -----Original Message-----
> > > > > > > > From: Andrew Jones <ajones@ventanamicro.com>
> > > > > > > > Sent: Friday, 24 February, 2023 5:00 PM
> > > > > > > > To: JeeHeng Sia <jeeheng.sia@starfivetech.com>
> > > > > > > > Cc: paul.walmsley@sifive.com; palmer@dabbelt.com; aou@eecs.berkeley.edu; linux-riscv@lists.infradead.org; linux-
> > > > > > > > kernel@vger.kernel.org; Leyfoon Tan <leyfoon.tan@starfivetech.com>; Mason Huo <mason.huo@starfivetech.com>
> > > > > > > > Subject: Re: [PATCH v4 4/4] RISC-V: Add arch functions to support hibernation/suspend-to-disk
> > > > > > > >
> > > > > > > > On Fri, Feb 24, 2023 at 02:05:43AM +0000, JeeHeng Sia wrote:
> > > > > > > > >
> > > > > > > > >
> > > > > > > > > > -----Original Message-----
> > > > > > > > > > From: Andrew Jones <ajones@ventanamicro.com>
> > > > > > > > > > Sent: Friday, 24 February, 2023 2:07 AM
> > > > > > > > > > To: JeeHeng Sia <jeeheng.sia@starfivetech.com>
> > > > > > > > > > Cc: paul.walmsley@sifive.com; palmer@dabbelt.com; aou@eecs.berkeley.edu; linux-riscv@lists.infradead.org; linux-
> > > > > > > > > > kernel@vger.kernel.org; Leyfoon Tan <leyfoon.tan@starfivetech.com>; Mason Huo <mason.huo@starfivetech.com>
> > > > > > > > > > Subject: Re: [PATCH v4 4/4] RISC-V: Add arch functions to support hibernation/suspend-to-disk
> > > > > > > > > >
> > > > > > > > > > On Tue, Feb 21, 2023 at 10:35:23AM +0800, Sia Jee Heng wrote:
> > > > > > > > > > > Low level Arch functions were created to support hibernation.
> > > > > > > > > > > swsusp_arch_suspend() relies code from __cpu_suspend_enter() to write
> > > > > > > > > > > cpu state onto the stack, then calling swsusp_save() to save the memory
> > > > > > > > > > > image.
> > > > > > > > > > >
> > > > > > > > > > > Arch specific hibernation header is implemented and is utilized by the
> > > > > > > > > > > arch_hibernation_header_restore() and arch_hibernation_header_save()
> > > > > > > > > > > functions. The arch specific hibernation header consists of satp, hartid,
> > > > > > > > > > > and the cpu_resume address. The kernel built version is also need to be
> > > > > > > > > > > saved into the hibernation image header to making sure only the same
> > > > > > > > > > > kernel is restore when resume.
> > > > > > > > > > >
> > > > > > > > > > > swsusp_arch_resume() creates a temporary page table that covering only
> > > > > > > > > > > the linear map. It copies the restore code to a 'safe' page, then start
> > > > > > > > > > > to restore the memory image. Once completed, it restores the original
> > > > > > > > > > > kernel's page table. It then calls into __hibernate_cpu_resume()
> > > > > > > > > > > to restore the CPU context. Finally, it follows the normal hibernation
> > > > > > > > > > > path back to the hibernation core.
> > > > > > > > > > >
> > > > > > > > > > > To enable hibernation/suspend to disk into RISCV, the below config
> > > > > > > > > > > need to be enabled:
> > > > > > > > > > > - CONFIG_ARCH_HIBERNATION_HEADER
> > > > > > > > > > > - CONFIG_ARCH_HIBERNATION_POSSIBLE
> > > > > > > > > > >
> > > > > > > > > > > Signed-off-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>
> > > > > > > > > > > Reviewed-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>
> > > > > > > > > > > Reviewed-by: Mason Huo <mason.huo@starfivetech.com>
> > > > > > > > > > > ---
> > > > > > > > > > >  arch/riscv/Kconfig                 |   7 +
> > > > > > > > > > >  arch/riscv/include/asm/assembler.h |  20 ++
> > > > > > > > > > >  arch/riscv/include/asm/suspend.h   |  19 ++
> > > > > > > > > > >  arch/riscv/kernel/Makefile         |   1 +
> > > > > > > > > > >  arch/riscv/kernel/asm-offsets.c    |   5 +
> > > > > > > > > > >  arch/riscv/kernel/hibernate-asm.S  |  77 +++++
> > > > > > > > > > >  arch/riscv/kernel/hibernate.c      | 447 +++++++++++++++++++++++++++++
> > > > > > > > > > >  7 files changed, 576 insertions(+)
> > > > > > > > > > >  create mode 100644 arch/riscv/kernel/hibernate-asm.S
> > > > > > > > > > >  create mode 100644 arch/riscv/kernel/hibernate.c
> > > > > > > > > > >
> > > > > > > > > > > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > > > > > > > > > > index e2b656043abf..4555848a817f 100644
> > > > > > > > > > > --- a/arch/riscv/Kconfig
> > > > > > > > > > > +++ b/arch/riscv/Kconfig
> > > > > > > > > > > @@ -690,6 +690,13 @@ menu "Power management options"
> > > > > > > > > > >
> > > > > > > > > > >  source "kernel/power/Kconfig"
> > > > > > > > > > >
> > > > > > > > > > > +config ARCH_HIBERNATION_POSSIBLE
> > > > > > > > > > > +	def_bool y
> > > > > > > > > > > +
> > > > > > > > > > > +config ARCH_HIBERNATION_HEADER
> > > > > > > > > > > +	def_bool y
> > > > > > > > > > > +	depends on HIBERNATION
> > > > > > > > > >
> > > > > > > > > > nit: I think this can be simplified as def_bool HIBERNATION
> > > > > > > > > good suggestion. will change it.
> > > > > > > > > >
> > > > > > > > > > > +
> > > > > > > > > > >  endmenu # "Power management options"
> > > > > > > > > > >
> > > > > > > > > > >  menu "CPU Power Management"
> > > > > > > > > > > diff --git a/arch/riscv/include/asm/assembler.h b/arch/riscv/include/asm/assembler.h
> > > > > > > > > > > index 727a97735493..68c46c0e0ea8 100644
> > > > > > > > > > > --- a/arch/riscv/include/asm/assembler.h
> > > > > > > > > > > +++ b/arch/riscv/include/asm/assembler.h
> > > > > > > > > > > @@ -59,4 +59,24 @@
> > > > > > > > > > >  		REG_L	s11, (SUSPEND_CONTEXT_REGS + PT_S11)(a0)
> > > > > > > > > > >  	.endm
> > > > > > > > > > >
> > > > > > > > > > > +/*
> > > > > > > > > > > + * copy_page - copy 1 page (4KB) of data from source to destination
> > > > > > > > > > > + * @a0 - destination
> > > > > > > > > > > + * @a1 - source
> > > > > > > > > > > + */
> > > > > > > > > > > +	.macro	copy_page a0, a1
> > > > > > > > > > > +		lui	a2, 0x1
> > > > > > > > > > > +		add	a2, a2, a0
> > > > > > > > > > > +1 :
> > > > > > > > > >     ^ please remove this space
> > > > > > > > > can't remove it otherwise checkpatch will throws ERROR: spaces required around that ':'
> > > > > > > >
> > > > > > > > Oh, right, labels in macros have this requirement.
> > > > > > > >
> > > > > > > > > >
> > > > > > > > > > > +		REG_L	t0, 0(a1)
> > > > > > > > > > > +		REG_L	t1, SZREG(a1)
> > > > > > > > > > > +
> > > > > > > > > > > +		REG_S	t0, 0(a0)
> > > > > > > > > > > +		REG_S	t1, SZREG(a0)
> > > > > > > > > > > +
> > > > > > > > > > > +		addi	a0, a0, 2 * SZREG
> > > > > > > > > > > +		addi	a1, a1, 2 * SZREG
> > > > > > > > > > > +		bne	a2, a0, 1b
> > > > > > > > > > > +	.endm
> > > > > > > > > > > +
> > > > > > > > > > >  #endif	/* __ASM_ASSEMBLER_H */
> > > > > > > > > > > diff --git a/arch/riscv/include/asm/suspend.h b/arch/riscv/include/asm/suspend.h
> > > > > > > > > > > index 75419c5ca272..3362da56a9d8 100644
> > > > > > > > > > > --- a/arch/riscv/include/asm/suspend.h
> > > > > > > > > > > +++ b/arch/riscv/include/asm/suspend.h
> > > > > > > > > > > @@ -21,6 +21,11 @@ struct suspend_context {
> > > > > > > > > > >  #endif
> > > > > > > > > > >  };
> > > > > > > > > > >
> > > > > > > > > > > +/*
> > > > > > > > > > > + * Used by hibernation core and cleared during resume sequence
> > > > > > > > > > > + */
> > > > > > > > > > > +extern int in_suspend;
> > > > > > > > > > > +
> > > > > > > > > > >  /* Low-level CPU suspend entry function */
> > > > > > > > > > >  int __cpu_suspend_enter(struct suspend_context *context);
> > > > > > > > > > >
> > > > > > > > > > > @@ -36,4 +41,18 @@ int __cpu_resume_enter(unsigned long hartid, unsigned long context);
> > > > > > > > > > >  /* Used to save and restore the csr */
> > > > > > > > > > >  void suspend_save_csrs(struct suspend_context *context);
> > > > > > > > > > >  void suspend_restore_csrs(struct suspend_context *context);
> > > > > > > > > > > +
> > > > > > > > > > > +/* Low-level API to support hibernation */
> > > > > > > > > > > +int swsusp_arch_suspend(void);
> > > > > > > > > > > +int swsusp_arch_resume(void);
> > > > > > > > > > > +int arch_hibernation_header_save(void *addr, unsigned int max_size);
> > > > > > > > > > > +int arch_hibernation_header_restore(void *addr);
> > > > > > > > > > > +int __hibernate_cpu_resume(void);
> > > > > > > > > > > +
> > > > > > > > > > > +/* Used to resume on the CPU we hibernated on */
> > > > > > > > > > > +int hibernate_resume_nonboot_cpu_disable(void);
> > > > > > > > > > > +
> > > > > > > > > > > +asmlinkage void hibernate_restore_image(unsigned long resume_satp, unsigned long satp_temp,
> > > > > > > > > > > +					unsigned long cpu_resume);
> > > > > > > > > > > +asmlinkage int hibernate_core_restore_code(void);
> > > > > > > > > > >  #endif
> > > > > > > > > > > diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
> > > > > > > > > > > index 4cf303a779ab..daab341d55e4 100644
> > > > > > > > > > > --- a/arch/riscv/kernel/Makefile
> > > > > > > > > > > +++ b/arch/riscv/kernel/Makefile
> > > > > > > > > > > @@ -64,6 +64,7 @@ obj-$(CONFIG_MODULES)		+= module.o
> > > > > > > > > > >  obj-$(CONFIG_MODULE_SECTIONS)	+= module-sections.o
> > > > > > > > > > >
> > > > > > > > > > >  obj-$(CONFIG_CPU_PM)		+= suspend_entry.o suspend.o
> > > > > > > > > > > +obj-$(CONFIG_HIBERNATION)	+= hibernate.o hibernate-asm.o
> > > > > > > > > > >
> > > > > > > > > > >  obj-$(CONFIG_FUNCTION_TRACER)	+= mcount.o ftrace.o
> > > > > > > > > > >  obj-$(CONFIG_DYNAMIC_FTRACE)	+= mcount-dyn.o
> > > > > > > > > > > diff --git a/arch/riscv/kernel/asm-offsets.c b/arch/riscv/kernel/asm-offsets.c
> > > > > > > > > > > index df9444397908..d6a75aac1d27 100644
> > > > > > > > > > > --- a/arch/riscv/kernel/asm-offsets.c
> > > > > > > > > > > +++ b/arch/riscv/kernel/asm-offsets.c
> > > > > > > > > > > @@ -9,6 +9,7 @@
> > > > > > > > > > >  #include <linux/kbuild.h>
> > > > > > > > > > >  #include <linux/mm.h>
> > > > > > > > > > >  #include <linux/sched.h>
> > > > > > > > > > > +#include <linux/suspend.h>
> > > > > > > > > > >  #include <asm/kvm_host.h>
> > > > > > > > > > >  #include <asm/thread_info.h>
> > > > > > > > > > >  #include <asm/ptrace.h>
> > > > > > > > > > > @@ -116,6 +117,10 @@ void asm_offsets(void)
> > > > > > > > > > >
> > > > > > > > > > >  	OFFSET(SUSPEND_CONTEXT_REGS, suspend_context, regs);
> > > > > > > > > > >
> > > > > > > > > > > +	OFFSET(HIBERN_PBE_ADDR, pbe, address);
> > > > > > > > > > > +	OFFSET(HIBERN_PBE_ORIG, pbe, orig_address);
> > > > > > > > > > > +	OFFSET(HIBERN_PBE_NEXT, pbe, next);
> > > > > > > > > > > +
> > > > > > > > > > >  	OFFSET(KVM_ARCH_GUEST_ZERO, kvm_vcpu_arch, guest_context.zero);
> > > > > > > > > > >  	OFFSET(KVM_ARCH_GUEST_RA, kvm_vcpu_arch, guest_context.ra);
> > > > > > > > > > >  	OFFSET(KVM_ARCH_GUEST_SP, kvm_vcpu_arch, guest_context.sp);
> > > > > > > > > > > diff --git a/arch/riscv/kernel/hibernate-asm.S b/arch/riscv/kernel/hibernate-asm.S
> > > > > > > > > > > new file mode 100644
> > > > > > > > > > > index 000000000000..846affe4dced
> > > > > > > > > > > --- /dev/null
> > > > > > > > > > > +++ b/arch/riscv/kernel/hibernate-asm.S
> > > > > > > > > > > @@ -0,0 +1,77 @@
> > > > > > > > > > > +/* SPDX-License-Identifier: GPL-2.0-only */
> > > > > > > > > > > +/*
> > > > > > > > > > > + * Hibernation low level support for RISCV.
> > > > > > > > > > > + *
> > > > > > > > > > > + * Copyright (C) 2023 StarFive Technology Co., Ltd.
> > > > > > > > > > > + *
> > > > > > > > > > > + * Author: Jee Heng Sia <jeeheng.sia@starfivetech.com>
> > > > > > > > > > > + */
> > > > > > > > > > > +
> > > > > > > > > > > +#include <asm/asm.h>
> > > > > > > > > > > +#include <asm/asm-offsets.h>
> > > > > > > > > > > +#include <asm/assembler.h>
> > > > > > > > > > > +#include <asm/csr.h>
> > > > > > > > > > > +
> > > > > > > > > > > +#include <linux/linkage.h>
> > > > > > > > > > > +
> > > > > > > > > > > +/*
> > > > > > > > > > > + * int __hibernate_cpu_resume(void)
> > > > > > > > > > > + * Switch back to the hibernated image's page table prior to restoring the CPU
> > > > > > > > > > > + * context.
> > > > > > > > > > > + *
> > > > > > > > > > > + * Always returns 0
> > > > > > > > > > > + */
> > > > > > > > > > > +ENTRY(__hibernate_cpu_resume)
> > > > > > > > > > > +	/* switch to hibernated image's page table. */
> > > > > > > > > > > +	csrw CSR_SATP, s0
> > > > > > > > > > > +	sfence.vma
> > > > > > > > > > > +
> > > > > > > > > > > +	REG_L	a0, hibernate_cpu_context
> > > > > > > > > > > +
> > > > > > > > > > > +	restore_csr
> > > > > > > > > > > +	restore_reg
> > > > > > > > > > > +
> > > > > > > > > > > +	/* Return zero value. */
> > > > > > > > > > > +	add	a0, zero, zero
> > > > > > > > > >
> > > > > > > > > > nit: mv a0, zero
> > > > > > > > > sure
> > > > > > > > > >
> > > > > > > > > > > +
> > > > > > > > > > > +	ret
> > > > > > > > > > > +END(__hibernate_cpu_resume)
> > > > > > > > > > > +
> > > > > > > > > > > +/*
> > > > > > > > > > > + * Prepare to restore the image.
> > > > > > > > > > > + * a0: satp of saved page tables.
> > > > > > > > > > > + * a1: satp of temporary page tables.
> > > > > > > > > > > + * a2: cpu_resume.
> > > > > > > > > > > + */
> > > > > > > > > > > +ENTRY(hibernate_restore_image)
> > > > > > > > > > > +	mv	s0, a0
> > > > > > > > > > > +	mv	s1, a1
> > > > > > > > > > > +	mv	s2, a2
> > > > > > > > > > > +	REG_L	s4, restore_pblist
> > > > > > > > > > > +	REG_L	a1, relocated_restore_code
> > > > > > > > > > > +
> > > > > > > > > > > +	jalr	a1
> > > > > > > > > > > +END(hibernate_restore_image)
> > > > > > > > > > > +
> > > > > > > > > > > +/*
> > > > > > > > > > > + * The below code will be executed from a 'safe' page.
> > > > > > > > > > > + * It first switches to the temporary page table, then starts to copy the pages
> > > > > > > > > > > + * back to the original memory location. Finally, it jumps to __hibernate_cpu_resume()
> > > > > > > > > > > + * to restore the CPU context.
> > > > > > > > > > > + */
> > > > > > > > > > > +ENTRY(hibernate_core_restore_code)
> > > > > > > > > > > +	/* switch to temp page table. */
> > > > > > > > > > > +	csrw satp, s1
> > > > > > > > > > > +	sfence.vma
> > > > > > > > > > > +.Lcopy:
> > > > > > > > > > > +	/* The below code will restore the hibernated image. */
> > > > > > > > > > > +	REG_L	a1, HIBERN_PBE_ADDR(s4)
> > > > > > > > > > > +	REG_L	a0, HIBERN_PBE_ORIG(s4)
> > > > > > > > > >
> > > > > > > > > > Are we sure restore_pblist will never be NULL?
> > > > > > > > > restore_pblist is a link-list, it will be null during initialization or during page clean up by hibernation core. During the initial
> > > > > > resume
> > > > > > > > process, the hibernation core will check the header and load the pages. If everything works correctly, the page will be linked
> > to
> > > > the
> > > > > > > > restore_pblist and then invoke swsusp_arch_resume() else hibernation core will throws error and failed to resume from
> > the
> > > > > > > > hibernated image.
> > > > > > > >
> > > > > > > > I know restore_pblist is a linked-list and this doesn't answer the
> > > > > > > > question. The comment above restore_pblist says
> > > > > > > >
> > > > > > > > /*
> > > > > > > >  * List of PBEs needed for restoring the pages that were allocated before
> > > > > > > >  * the suspend and included in the suspend image, but have also been
> > > > > > > >  * allocated by the "resume" kernel, so their contents cannot be written
> > > > > > > >  * directly to their "original" page frames.
> > > > > > > >  */
> > > > > > > >
> > > > > > > > which implies the pages that end up on this list are "special". My
> > > > > > > > question is whether or not we're guaranteed to have at least one
> > > > > > > > of these special pages. If not, we shouldn't assume s4 is non-null.
> > > > > > > > If so, then a comment stating why that's guaranteed would be nice.
> > > > > > > The restore_pblist will not be null otherwise swsusp_arch_resume wouldn't get invoked. you can find how the link-list are
> > link
> > > > and
> > > > > > how it checks against validity at https://elixir.bootlin.com/linux/v6.2-rc8/source/kernel/power/snapshot.c . " A comment
> > stating
> > > > why
> > > > > > that's guaranteed would be nice" ? Hmm, perhaps this is out of my scope but I do believe in the page validity checking in the
> > link I
> > > > > > shared.
> > > > > >
> > > > > > Sorry, but pointing to an entire source file (one that I've obviously
> > > > > > already looked at, since I quoted a comment from it...) is not helpful.
> > > > > > I don't see where restore_pblist is being checked before
> > > > > > swsusp_arch_resume() is issued (from its callsite in hibernate.c).
> > > > > Sure, below shows the hibernation flow for your reference. The link-list creation and checking found at:
> > > > https://elixir.bootlin.com/linux/v6.2/source/kernel/power/snapshot.c#L2576
> > > > > software_resume()
> > > > > 	load_image_and_restore()
> > > > > 		swsusp_read()
> > > > > 			load_image()
> > > > >  				snapshot_write_next()
> > > > > 					get_buffer() <-- This is the function checks and links the pages to the restore_pblist
> > > >
> > > > Yup, I've read this path, including get_buffer(), where I saw that
> > > > get_buffer() can return an address without allocating a PBE. Where is the
> > > > check that restore_pblist isn't NULL, i.e. we see that at least one PBE
> > > > has been allocated by get_buffer(), before we call swsusp_arch_resume()?
> > > >
> > > > Or, is known that at least one or more pages match the criteria pointed
> > > > out in the comment below (copied from get_buffer())?
> > > >
> > > >         /*
> > > >          * The "original" page frame has not been allocated and we have to
> > > >          * use a "safe" page frame to store the loaded page.
> > > >          */
> > > >
> > > > If so, then which ones? And where does it state that?
> > > Let's look at the below pseudocode and hope it clear your doubt. restore_pblist depends on safe_page_list and pbe and both
> > pointers are checked. I couldn't find from where the restore_pblist will be null..
> > > 	//Pseudocode to illustrate the image loading
> > > 	initialize restore_pblist to null;
> > > 	initialize safe_pages_list to null;
> > > 	Allocate safe page list, return error if failed;
> > > 	load image;
> > > loop:	Create pbe chain, return error if failed;
> > 
> > This loop pseudocode is incomplete. It's
> > 
> > loop:
> >         if (swsusp_page_is_forbidden(page) && swsusp_page_is_free(page))
> > 	   return page_address(page);
> > 	Create pbe chain, return error if failed;
> > 	...
> > 
> > which I pointed out explicitly in my last reply. Also, as I asked in my
> > last reply (and have been asking four times now, albeit less explicitly
> > the first two times), how do we know at least one PBE will be linked?
> 1 PBE correspond to 1 page, you shouldn't expect only 1 page is saved.

I know PBEs correspond to pages. *Why* should I not expect only one page
is saved? Or, more importantly, why should I expect more than zero pages
are saved?

Convincing answers might be because we *always* put the restore code in
pages which get added to the PBE list or that the original page tables
*always* get put in pages which get added to the PBE list. It's not very
convincing to simply *assume* that at least one random page will always
meet the PBE list criteria.

> Hibernation core will do the calculation. If the PBEs (restore_pblist) linked successfully, the hibernated image will be restore else normal boot will take place.
> > Or, even more specifically this time, where is the proof that for each
> > hibernation resume, there exists some page such that
> > !swsusp_page_is_forbidden(page) or !swsusp_page_is_free(page) is true?
> forbidden_pages and free_pages are not contributed to the restore_pblist (as you already aware from the code). Infact, the forbidden_pages and free_pages are not save into the disk.

Exactly, so those pages are *not* going to contribute to the greater than
zero pages. What I've been asking for, from the beginning, is to know
which page(s) are known to *always* contribute to the list. Or, IOW, how
do you know the PBE list isn't empty, a.k.a restore_pblist isn't NULL?

Thanks,
drew

> > 
> > Thanks,
> > drew
> > 
> > > 	assign orig_addr and safe_page to pbe;
> > > 	link pbe to restore_pblist;
> > > 	return pbe to handle->buffer;
> > > 	check handle->buffer;
> > > 	goto loop if no error else return with error;
> > > >
> > > > Thanks,
> > > > drew
> > > >
> > > >
> > > > > 		hibernation_restore()
> > > > > 			resume_target_kernel()
> > > > > 				swsusp_arch_resume()
> > > > > >
> > > > > > Thanks,
> > > > > > drew
