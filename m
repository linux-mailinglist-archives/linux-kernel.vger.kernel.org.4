Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E464060AB16
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 15:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234075AbiJXNpQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 09:45:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236991AbiJXNlv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 09:41:51 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E540E4A;
        Mon, 24 Oct 2022 05:39:24 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id a5so17592015edb.11;
        Mon, 24 Oct 2022 05:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=enjnXrgGXbcMA3WfYBZgSaGKWy2h+iyPV27PBQ4hdWc=;
        b=KC2YHNNGgHbDpcjCTc8b/64NkOLCT6enxbKTggnBuyGYKjX1r4Lb89UIovAfcq8szT
         SXzuNrbsg6hy/S/XhQ0lBBSsoPnz8ehoqV/ekPn6zzar44GirdS2BzmO9nVzUR8DaoH2
         43/PkmzYZ/l5XdBIXMoGd/iMWYbeKpGHAtz+Lkqc8ISNEOC4jzurU4AWFHI3gW58e+N0
         mJ+GY9gxsWwqLzyQr05gdZx/Rs/FOYEV1F82wbRLILoy/9FbqwB5wrzCEk7qb1ZjdyyR
         Y0hdtroTV7qzACzaZrly2EJYLXJWRsxJVgRZFNLw09e+0ikv6KyGk5vhLbf/BsDLLdkN
         9VeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=enjnXrgGXbcMA3WfYBZgSaGKWy2h+iyPV27PBQ4hdWc=;
        b=eindhv+zn8EfWw/yPphiJ7EPWREd0AkY6VZqSqeemrIeXUUd1K2zLWF6bNLjvjBq97
         6mbEtC4+CCTI7RPRM9YJJiXKhgyc1k0cfJVd3g2uAL7B/gZumMSgSt85ZhRTavyP9btS
         /vJI34RyFfUvy2i7lubULR90xTdW+ENq+82O9QLPDJOP30dF8GoXEf0Bz0eze9gndaJg
         j+G2bHxWIGhipvhLMdlR84jzB6m7HS8ED4ZhvEpkkJAAAmijI+50n72PC+fSVQaG+t9U
         bdvsBU7KXKC32z8h2lB0C3BrGkRVccNCP2DFkhUMEXjGzAzvV6nEtdnKdTud+ZLuiLFT
         utiQ==
X-Gm-Message-State: ACrzQf2jj6jp3JgMJMqtS0soCUxfesiBLUgdOMPmhjPf03FZF3cdtzlU
        7iFSbJTB+iNcyc4U+yOKEkjw5ayieMynvxYj8uPTdo1PrWFAkw==
X-Google-Smtp-Source: AMsMyM7deTXtRwpYvDqPrr3fK/XqqrwUfarVHeEYLqcrae05P5E0XMCvdSJokNKD1li9Edwp+DOc+pEq3RSuDoh5jgk=
X-Received: by 2002:a05:6402:3217:b0:461:d6d7:7f19 with SMTP id
 g23-20020a056402321700b00461d6d77f19mr2926691eda.109.1666612527159; Mon, 24
 Oct 2022 04:55:27 -0700 (PDT)
MIME-Version: 1.0
References: <20221019220242.4746-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20221019220242.4746-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20221021020500.GA2157489-robh@kernel.org> <CA+V-a8v0jEFj+XKAtyAaTBFmX3bObBZgGd6n1LB3OnTU_W002w@mail.gmail.com>
 <Y1Md4bMYJHI34HuJ@spud>
In-Reply-To: <Y1Md4bMYJHI34HuJ@spud>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Mon, 24 Oct 2022 12:55:00 +0100
Message-ID: <CA+V-a8vA_ZbV+SEy8Ch8ZuYAb+U37CtC8Ys=svMv7fjy79mR=A@mail.gmail.com>
Subject: Re: [RFC PATCH v3 2/2] soc: renesas: Add L2 cache management for
 RZ/Five SoC
To:     Conor Dooley <conor@kernel.org>
Cc:     Rob Herring <robh@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Conor Dooley <conor.dooley@microchip.com>,
        Guo Ren <guoren@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Atish Patra <atishp@rivosinc.com>,
        Anup Patel <anup@brainfault.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-renesas-soc@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Conor,

On Fri, Oct 21, 2022 at 11:32 PM Conor Dooley <conor@kernel.org> wrote:
>
> On Fri, Oct 21, 2022 at 11:05:40PM +0100, Lad, Prabhakar wrote:
> > Hi Rob,
> >
> > Thank you for the review.
> >
> > On Fri, Oct 21, 2022 at 3:05 AM Rob Herring <robh@kernel.org> wrote:
> > >
> > > On Wed, Oct 19, 2022 at 11:02:42PM +0100, Prabhakar wrote:
> > > > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > >
> > > > On the AX45MP core, cache coherency is a specification option so it may
> > > > not be supported. In this case DMA will fail. As a workaround, firstly we
> > > > allocate a global dma coherent pool from which DMA allocations are taken
> > > > and marked as non-cacheable + bufferable using the PMA region as specified
> > > > in the device tree. Synchronization callbacks are implemented to
> > > > synchronize when doing DMA transactions.
> > > >
> > > > The Andes AX45MP core has a Programmable Physical Memory Attributes (PMA)
> > > > block that allows dynamic adjustment of memory attributes in the runtime.
> > > > It contains a configurable amount of PMA entries implemented as CSR
> > > > registers to control the attributes of memory locations in interest.
> > > >
> > > > Below are the memory attributes supported:
> > > > * Device, Non-bufferable
> > > > * Device, bufferable
> > > > * Memory, Non-cacheable, Non-bufferable
> > > > * Memory, Non-cacheable, Bufferable
> > > > * Memory, Write-back, No-allocate
> > > > * Memory, Write-back, Read-allocate
> > > > * Memory, Write-back, Write-allocate
> > > > * Memory, Write-back, Read and Write-allocate
> > > >
> > > > This patch adds support to configure the memory attributes of the memory
> > > > regions as passed from the l2 cache node and exposes the cache management
> > > > ops.
> > > >
> > > > More info about PMA (section 10.3):
> > > > http://www.andestech.com/wp-content/uploads/AX45MP-1C-Rev.-5.0.0-Datasheet.pdf
> > > >
> > > > This feature is based on the work posted [0] by Vincent Chen
> > > > <vincentc@andestech.com> for the Andes AndeStart RISC-V CPU.
> > > >
> > > > [0] https://lore.kernel.org/lkml/1540982130-28248-1-git-send-email-vincentc@andestech.com/
> > > >
> > > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > > ---
> > > >  arch/riscv/include/asm/cacheflush.h    |   8 +
> > > >  arch/riscv/include/asm/errata_list.h   |   2 +
> > > >  arch/riscv/mm/dma-noncoherent.c        |  20 ++
> > > >  drivers/soc/renesas/Kconfig            |   5 +
> > > >  drivers/soc/renesas/Makefile           |   4 +
> > > >  drivers/soc/renesas/rzf/Kconfig        |   6 +
> > > >  drivers/soc/renesas/rzf/Makefile       |   3 +
> > > >  drivers/soc/renesas/rzf/ax45mp_cache.c | 431 +++++++++++++++++++++++++
> > >
> > > How many cache drivers do we have around now? I've seen a few bindings
> > > go by. I'm guessing it is time to stop putting the drivers in the
> > > drivers/soc/ dumping ground.
> > >
> > The main reason this driver is not in arch/riscv is that it has vendor
> > specific extensions. Due to this reason it was agreed during the LPC
> > that vendor specific extension should be maintained by SoC vendors and
> > was agreed that this can go into drivers/soc/renesas folder instead.
>
> Does not in drivers/soc mean they need to go into arch/riscv?
I was under the impression Rob wanted them arch/riscv, sorry for the confusion.

> The outcome of the chat at the LPC BoF was more that the cache drivers
> themselves should not be be routed via the arch maintainers, no?
>
Indeed.

> >
> > > >  drivers/soc/renesas/rzf/ax45mp_sbi.h   |  29 ++
> > > >  9 files changed, 508 insertions(+)
> > > >  create mode 100644 drivers/soc/renesas/rzf/Kconfig
> > > >  create mode 100644 drivers/soc/renesas/rzf/Makefile
> > > >  create mode 100644 drivers/soc/renesas/rzf/ax45mp_cache.c
> > > >  create mode 100644 drivers/soc/renesas/rzf/ax45mp_sbi.h
> > > >
> > > > diff --git a/arch/riscv/include/asm/cacheflush.h b/arch/riscv/include/asm/cacheflush.h
> > > > index 8a5c246b0a21..40aa790be9a3 100644
> > > > --- a/arch/riscv/include/asm/cacheflush.h
> > > > +++ b/arch/riscv/include/asm/cacheflush.h
> > > > @@ -65,6 +65,14 @@ static inline void riscv_noncoherent_supported(void) {}
> > > >  #define SYS_RISCV_FLUSH_ICACHE_LOCAL 1UL
> > > >  #define SYS_RISCV_FLUSH_ICACHE_ALL   (SYS_RISCV_FLUSH_ICACHE_LOCAL)
> > > >
> > > > +#ifdef CONFIG_AX45MP_L2_CACHE
> > > > +void ax45mp_cpu_dma_inval_range(void *vaddr, size_t end);
> > > > +void ax45mp_cpu_dma_wb_range(void *vaddr, size_t end);
> > > > +
> > > > +#define ALT_CMO_OP(_op, _start, _size, _cachesize)   \
> > > > +                _op(_start, _size)
> > > > +#endif
> > > > +
> > > >  #include <asm-generic/cacheflush.h>
> > > >
> > > >  #endif /* _ASM_RISCV_CACHEFLUSH_H */
> > > > diff --git a/arch/riscv/include/asm/errata_list.h b/arch/riscv/include/asm/errata_list.h
> > > > index 19a771085781..d9cbf60c3b65 100644
> > > > --- a/arch/riscv/include/asm/errata_list.h
> > > > +++ b/arch/riscv/include/asm/errata_list.h
> > > > @@ -89,6 +89,7 @@ asm volatile(ALTERNATIVE(                                           \
> > > >  #define ALT_THEAD_PMA(_val)
> > > >  #endif
> > > >
> > > > +#ifdef CONFIG_ERRATA_THEAD_CMO
> > > >  /*
> > > >   * dcache.ipa rs1 (invalidate, physical address)
> > > >   * | 31 - 25 | 24 - 20 | 19 - 15 | 14 - 12 | 11 - 7 | 6 - 0 |
> > > > @@ -143,5 +144,6 @@ asm volatile(ALTERNATIVE_2(                                               \
> > > >       : "a0")
> > > >
> > > >  #endif /* __ASSEMBLY__ */
> > > > +#endif
> > > >
> > > >  #endif
> > > > diff --git a/arch/riscv/mm/dma-noncoherent.c b/arch/riscv/mm/dma-noncoherent.c
> > > > index b0add983530a..5270acca6766 100644
> > > > --- a/arch/riscv/mm/dma-noncoherent.c
> > > > +++ b/arch/riscv/mm/dma-noncoherent.c
> > > > @@ -24,13 +24,25 @@ void arch_sync_dma_for_device(phys_addr_t paddr, size_t size,
> > > >
> > > >       switch (dir) {
> > > >       case DMA_TO_DEVICE:
> > > > +#ifdef CONFIG_ERRATA_THEAD_CMO
> > > >               ALT_CMO_OP(clean, vaddr, size, riscv_cbom_block_size);
> > > > +#elif CONFIG_AX45MP_L2_CACHE
> > > > +             ALT_CMO_OP(ax45mp_cpu_dma_wb_range, vaddr, size, 0x0);
> > > > +#endif
> > >
> > > How do you support more than one platform in a build?
> > >
> > Yes, that's one concern which I have mentioned in the cover letter too
> > (At that moment it's just a single platform). Suggestions welcome!
>
> I think I said it on one of the earlier version, but it needs to be
> implemented w/ runtime patching via alternatives just like the thead
> stuff patches in their functions.
>
I'm a bit stumped with alternatives() usage.

Currently I am just replacing the ALT_CMO_OP() macro if
CONFIG_AX45MP_L2_CACHE is enabled. For AX45MP currently we have two
exported functions ax45mp_cpu_dma_inval_range/ax45mp_cpu_dma_wb_range.
If I switch to
ALTERNATIVE() macro usage then I'll have to use the assembly version
of the above two mentioned functions?

Cheers,
Prabhakar
