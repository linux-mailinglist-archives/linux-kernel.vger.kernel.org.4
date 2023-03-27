Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 274336CA299
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 13:37:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbjC0Lh3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 07:37:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232401AbjC0Lh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 07:37:26 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 540904EC8
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 04:37:23 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id ek18so34798660edb.6
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 04:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1679917042;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3g4MhCvd7DYG7FC4+CGeHUO3aAKUBV+WHa6Y4KT1TNc=;
        b=dtcxk2/by2cklyOhIB/Qu5tHRBqEmhhptRCRX7eb1gdN9FHy9CqRXsJtimqS6bxifN
         sZsK84HzC5gf3CGAQUVlSr9vIp3qV/cxIdg7mgYHhrp+9fmw7GtJ+dfMId+l3x0NIA/j
         z9fihDLRZTx5g18JqavnjTJw/nn4FPXP9XRtvtOOmJ361TwUH8Bxpaz3YiXsTqFZ5qQZ
         2tusCsdD+hSNCpcoxcy0KEblOC/xh/nW8FoLIISeIt0xoMr7C7RZVv6f60JImenizI8t
         oFzZBywa5krvoxS7ZP+AgJsDQy/SufobGK+sHSi8v3ZItPNyyO4hlBJ5qIWkKHCsG2Mg
         JbjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679917042;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3g4MhCvd7DYG7FC4+CGeHUO3aAKUBV+WHa6Y4KT1TNc=;
        b=khWDVdH1yT+ZHnxOQP6XoTMUus1Khl931hXhZveKbiS2AdCowBKAz3kUta4UiO2SFL
         UQN/qZ5Bkfns01H8XO3DIlok9CutFmPlIV6tccdpnvF5HaTajMbaJooQsdV0hj2g/p/r
         J9rDadw+W83oABf2rx1QW8kJgjMOpPdPJWw8ESxY0jEl0jnx6eu1VioqKWjyVi80dMhM
         xv8lM4tAxhu4AXu0w8xtmXJ6c6YXrG57eISei4IO+bH6s8LspGznTRq9wptREtsjlrbN
         RomNihXpJ5JO1JiU8J0nMqEdit05UD2XKbhzomYnFhVnD2ulXQAwnL1OzoIxbFJ85xNA
         iScw==
X-Gm-Message-State: AAQBX9cuLof9jF5cg2v+CSriLFdOqQiWdA0AHjL86fh1LbTE7RHE5MLW
        J+nBKr30LyXd35AkqtMLL8hdLw==
X-Google-Smtp-Source: AKy350YwYps1I56deQ41q8T8GahH++fvjDNh8B7MI3rkr8WI9wg/W2vCZBY9ChA2lmGkZQqRmbzhNw==
X-Received: by 2002:a05:6402:514a:b0:4fa:4810:95f9 with SMTP id n10-20020a056402514a00b004fa481095f9mr10593578edd.34.1679917041746;
        Mon, 27 Mar 2023 04:37:21 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id i28-20020a50871c000000b004fd204d180dsm14511647edb.64.2023.03.27.04.37.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 04:37:21 -0700 (PDT)
Date:   Mon, 27 Mar 2023 13:37:20 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v9 3/3] riscv: Use PUD/P4D/PGD pages for the linear
 mapping
Message-ID: <20230327113720.anh3v5gk5oc7pkqt@orel>
References: <20230324155421.271544-1-alexghiti@rivosinc.com>
 <20230324155421.271544-4-alexghiti@rivosinc.com>
 <20230327093926.x5qyb5nou7naiyyv@orel>
 <CAHVXubg2BpoCqtXTW9BWQ21DmNOzR2ebvhUHA8NkZ3Hkk8-NkA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHVXubg2BpoCqtXTW9BWQ21DmNOzR2ebvhUHA8NkZ3Hkk8-NkA@mail.gmail.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 27, 2023 at 01:15:43PM +0200, Alexandre Ghiti wrote:
> Hi Andrew,
> 
> On Mon, Mar 27, 2023 at 11:39 AM Andrew Jones <ajones@ventanamicro.com> wrote:
> >
> > On Fri, Mar 24, 2023 at 04:54:21PM +0100, Alexandre Ghiti wrote:
> > > During the early page table creation, we used to set the mapping for
> > > PAGE_OFFSET to the kernel load address: but the kernel load address is
> > > always offseted by PMD_SIZE which makes it impossible to use PUD/P4D/PGD
> > > pages as this physical address is not aligned on PUD/P4D/PGD size (whereas
> > > PAGE_OFFSET is).
> > >
> > > But actually we don't have to establish this mapping (ie set va_pa_offset)
> > > that early in the boot process because:
> > >
> > > - first, setup_vm installs a temporary kernel mapping and among other
> > >   things, discovers the system memory,
> > > - then, setup_vm_final creates the final kernel mapping and takes
> > >   advantage of the discovered system memory to create the linear
> > >   mapping.
> > >
> > > During the first phase, we don't know the start of the system memory and
> > > then until the second phase is finished, we can't use the linear mapping at
> > > all and phys_to_virt/virt_to_phys translations must not be used because it
> > > would result in a different translation from the 'real' one once the final
> > > mapping is installed.
> > >
> > > So here we simply delay the initialization of va_pa_offset to after the
> > > system memory discovery. But to make sure noone uses the linear mapping
> > > before, we add some guard in the DEBUG_VIRTUAL config.
> > >
> > > Finally we can use PUD/P4D/PGD hugepages when possible, which will result
> > > in a better TLB utilization.
> > >
> > > Note that:
> > > - this does not apply to rv32 as the kernel mapping lies in the linear
> > >   mapping.
> > > - we rely on the firmware to protect itself using PMP.
> > >
> > > Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> > > Acked-by: Rob Herring <robh@kernel.org> # DT bits
> > > ---
> > >  arch/riscv/include/asm/page.h | 16 ++++++++++
> > >  arch/riscv/mm/init.c          | 58 +++++++++++++++++++++++++++++++----
> > >  arch/riscv/mm/physaddr.c      | 16 ++++++++++
> > >  drivers/of/fdt.c              | 11 ++++---
> > >  4 files changed, 90 insertions(+), 11 deletions(-)
> > >
> > > diff --git a/arch/riscv/include/asm/page.h b/arch/riscv/include/asm/page.h
> > > index 8dc686f549b6..ea1a0e237211 100644
> > > --- a/arch/riscv/include/asm/page.h
> > > +++ b/arch/riscv/include/asm/page.h
> > > @@ -90,6 +90,14 @@ typedef struct page *pgtable_t;
> > >  #define PTE_FMT "%08lx"
> > >  #endif
> > >
> > > +#ifdef CONFIG_64BIT
> > > +/*
> > > + * We override this value as its generic definition uses __pa too early in
> > > + * the boot process (before kernel_map.va_pa_offset is set).
> > > + */
> > > +#define MIN_MEMBLOCK_ADDR      0
> > > +#endif
> > > +
> > >  #ifdef CONFIG_MMU
> > >  #define ARCH_PFN_OFFSET              (PFN_DOWN((unsigned long)phys_ram_base))
> > >  #else
> > > @@ -121,7 +129,11 @@ extern phys_addr_t phys_ram_base;
> > >  #define is_linear_mapping(x) \
> > >       ((x) >= PAGE_OFFSET && (!IS_ENABLED(CONFIG_64BIT) || (x) < PAGE_OFFSET + KERN_VIRT_SIZE))
> > >
> > > +#ifndef CONFIG_DEBUG_VIRTUAL
> > >  #define linear_mapping_pa_to_va(x)   ((void *)((unsigned long)(x) + kernel_map.va_pa_offset))
> > > +#else
> > > +void *linear_mapping_pa_to_va(unsigned long x);
> > > +#endif
> > >  #define kernel_mapping_pa_to_va(y)   ({                                      \
> > >       unsigned long _y = (unsigned long)(y);                                  \
> > >       (IS_ENABLED(CONFIG_XIP_KERNEL) && _y < phys_ram_base) ?                 \
> > > @@ -130,7 +142,11 @@ extern phys_addr_t phys_ram_base;
> > >       })
> > >  #define __pa_to_va_nodebug(x)                linear_mapping_pa_to_va(x)
> > >
> > > +#ifndef CONFIG_DEBUG_VIRTUAL
> > >  #define linear_mapping_va_to_pa(x)   ((unsigned long)(x) - kernel_map.va_pa_offset)
> > > +#else
> > > +phys_addr_t linear_mapping_va_to_pa(unsigned long x);
> > > +#endif
> > >  #define kernel_mapping_va_to_pa(y) ({                                                \
> > >       unsigned long _y = (unsigned long)(y);                                  \
> > >       (IS_ENABLED(CONFIG_XIP_KERNEL) && _y < kernel_map.virt_addr + XIP_OFFSET) ? \
> > > diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> > > index 3b37d8606920..f803671d18b2 100644
> > > --- a/arch/riscv/mm/init.c
> > > +++ b/arch/riscv/mm/init.c
> > > @@ -213,6 +213,14 @@ static void __init setup_bootmem(void)
> > >       phys_ram_end = memblock_end_of_DRAM();
> > >       if (!IS_ENABLED(CONFIG_XIP_KERNEL))
> > >               phys_ram_base = memblock_start_of_DRAM();
> > > +
> > > +     /*
> > > +      * In 64-bit, any use of __va/__pa before this point is wrong as we
> > > +      * did not know the start of DRAM before.
> > > +      */
> > > +     if (IS_ENABLED(CONFIG_64BIT))
> > > +             kernel_map.va_pa_offset = PAGE_OFFSET - phys_ram_base;
> > > +
> > >       /*
> > >        * memblock allocator is not aware of the fact that last 4K bytes of
> > >        * the addressable memory can not be mapped because of IS_ERR_VALUE
> > > @@ -667,9 +675,16 @@ void __init create_pgd_mapping(pgd_t *pgdp,
> > >
> > >  static uintptr_t __init best_map_size(phys_addr_t base, phys_addr_t size)
> > >  {
> > > -     /* Upgrade to PMD_SIZE mappings whenever possible */
> > > -     base &= PMD_SIZE - 1;
> > > -     if (!base && size >= PMD_SIZE)
> > > +     if (!(base & (PGDIR_SIZE - 1)) && size >= PGDIR_SIZE)
> > > +             return PGDIR_SIZE;
> > > +
> > > +     if (!(base & (P4D_SIZE - 1)) && size >= P4D_SIZE)
> > > +             return P4D_SIZE;
> > > +
> > > +     if (!(base & (PUD_SIZE - 1)) && size >= PUD_SIZE)
> > > +             return PUD_SIZE;
> > > +
> > > +     if (!(base & (PMD_SIZE - 1)) && size >= PMD_SIZE)
> > >               return PMD_SIZE;
> > >
> > >       return PAGE_SIZE;
> > > @@ -978,11 +993,22 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
> > >       set_satp_mode();
> > >  #endif
> > >
> > > -     kernel_map.va_pa_offset = PAGE_OFFSET - kernel_map.phys_addr;
> > > +     /*
> > > +      * In 64-bit, we defer the setup of va_pa_offset to setup_bootmem,
> > > +      * where we have the system memory layout: this allows us to align
> > > +      * the physical and virtual mappings and then make use of PUD/P4D/PGD
> > > +      * for the linear mapping. This is only possible because the kernel
> > > +      * mapping lies outside the linear mapping.
> > > +      * In 32-bit however, as the kernel resides in the linear mapping,
> > > +      * setup_vm_final can not change the mapping established here,
> > > +      * otherwise the same kernel addresses would get mapped to different
> > > +      * physical addresses (if the start of dram is different from the
> > > +      * kernel physical address start).
> > > +      */
> > > +     kernel_map.va_pa_offset = IS_ENABLED(CONFIG_64BIT) ?
> > > +                             0UL : PAGE_OFFSET - kernel_map.phys_addr;
> > >       kernel_map.va_kernel_pa_offset = kernel_map.virt_addr - kernel_map.phys_addr;
> > >
> > > -     phys_ram_base = kernel_map.phys_addr;
> > > -
> > >       /*
> > >        * The default maximal physical memory size is KERN_VIRT_SIZE for 32-bit
> > >        * kernel, whereas for 64-bit kernel, the end of the virtual address
> > > @@ -1106,6 +1132,17 @@ static void __init create_linear_mapping_page_table(void)
> > >       phys_addr_t start, end;
> > >       u64 i;
> > >
> > > +#ifdef CONFIG_STRICT_KERNEL_RWX
> > > +     phys_addr_t ktext_start = __pa_symbol(_start);
> > > +     phys_addr_t ktext_size = __init_data_begin - _start;
> > > +     phys_addr_t krodata_start = __pa_symbol(__start_rodata);
> > > +     phys_addr_t krodata_size = _data - __start_rodata;
> > > +
> > > +     /* Isolate kernel text and rodata so they don't get mapped with a PUD */
> > > +     memblock_mark_nomap(ktext_start,  ktext_size);
> > > +     memblock_mark_nomap(krodata_start, krodata_size);
> > > +#endif
> > > +
> > >       /* Map all memory banks in the linear mapping */
> > >       for_each_mem_range(i, &start, &end) {
> > >               if (start >= end)
> > > @@ -1118,6 +1155,15 @@ static void __init create_linear_mapping_page_table(void)
> > >
> > >               create_linear_mapping_range(start, end);
> > >       }
> > > +
> > > +#ifdef CONFIG_STRICT_KERNEL_RWX
> > > +     create_linear_mapping_range(ktext_start, ktext_start + ktext_size);
> > > +     create_linear_mapping_range(krodata_start,
> > > +                                 krodata_start + krodata_size);
> >
> > Just for my own education, it looks to me like the rodata is left writable
> > until the end of start_kernel(), when mark_rodata_ro() is called. Is that
> > correct?
> 
> Yes, right before init is triggered, certainly that late because the
> rodata section embeds the "__ro_after_init" variables.

Ah, that indeed helps clarify why. Sounds good.

Thanks,
drew
