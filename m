Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09714639840
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 22:10:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbiKZVKM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Nov 2022 16:10:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiKZVKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Nov 2022 16:10:10 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7887A18358;
        Sat, 26 Nov 2022 13:10:08 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id n20so17449124ejh.0;
        Sat, 26 Nov 2022 13:10:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fDBUpPZVAOqRZvEOXS3zc0opjIEwKAzF/btYHwslDho=;
        b=aZhej2g9fgP7k5pY7TfMjPgxbR4O6TQ3LbYZrJ2KYdsDXKCElORgQC+ouMXmGl220K
         KDTxCDp6Kxr+cM9HqwzuCrjYcqEPGCX7oc1XinwPTSPVL4XY/VkLhygGXollXBEfuqlj
         kKuuv56e2+p2x3Om3SveYPyLLKaT1THNrBwyJCuegzmaqTL8tZns8CyUEkTeODf+74gJ
         HfZgpE+Rz8wPh8xC8stsiN8oTfzhSkOqgHvBBAwBNpJtMjlN4czUHRrMfkFveJec6asR
         4dAeUfQx9YV1hMLCljmZmfIzXl7U7gz9DOdKrIcNznBmjfE9GAGg8FYavjQh6Po0zThU
         s84Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fDBUpPZVAOqRZvEOXS3zc0opjIEwKAzF/btYHwslDho=;
        b=4KJlfFy3IbbtiYAI/iam+bMAbY1Re/qrNrKUfqZ2hIh2/PuPOIG+fS8yXPjsG2R5j7
         2Tb8bxUgIN4cq5cFCbG+c34qjaEr5BX7+fRfK/Q7BT0nw5gB8EoIdz/KhLR1upiUDoOH
         9AxRFF0zAsHmJ4vc9Cmrr6N2hdhS3mJudlDgjGmBrY1Vhh+CORQUJbXw48IBKY+jskR3
         fw2C/xK8iAT2qQ33rVLKumwbXZl9D2V/5vWOIOOl27Yjtwv7m1s0hneN70mnZOf49m5+
         OgGRrpTd+VrtfkTfISjDza6JwvdosVLJtGXXiaWrGVEBSIAOytU4TcDZWlSrIAbGpLps
         QK/w==
X-Gm-Message-State: ANoB5pno75ECa65UqVgZWqqZRr5mLgZlOEnMvKAOaV3/ZFlwuAs6+Efx
        PSRTeL2FJjfKHAWwBQViSNUbxyaBFIrjFl/CfYw=
X-Google-Smtp-Source: AA0mqf6IIbUTLP8Yv0BHZ+/L/Shy3mV3GtEmrdNKqjrbjMqv8MeDOCdrxKEj/7RFuKpPBw7KxHF1Hlq2bwYxOxhMTG4=
X-Received: by 2002:a17:906:ccd0:b0:7ad:db82:d073 with SMTP id
 ot16-20020a170906ccd000b007addb82d073mr26040836ejb.480.1669497006463; Sat, 26
 Nov 2022 13:10:06 -0800 (PST)
MIME-Version: 1.0
References: <20221124172207.153718-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20221124172207.153718-8-prabhakar.mahadev-lad.rj@bp.renesas.com> <bf8e33fd-a752-d5d5-859e-14302d069f2d@sholland.org>
In-Reply-To: <bf8e33fd-a752-d5d5-859e-14302d069f2d@sholland.org>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Sat, 26 Nov 2022 21:09:39 +0000
Message-ID: <CA+V-a8sz4i_wenTyA5tVTVB8dQWLmuXCf3CGYOPC+C07GJ8WTw@mail.gmail.com>
Subject: Re: [PATCH v4 7/7] soc: renesas: Add L2 cache management for RZ/Five SoC
To:     Samuel Holland <samuel@sholland.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Guo Ren <guoren@kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Atish Patra <atishp@rivosinc.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
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

Hi Samuel,

Thank you for the review.

On Fri, Nov 25, 2022 at 7:43 PM Samuel Holland <samuel@sholland.org> wrote:
>
> Hi Prabhakar,
>
> On 11/24/22 11:22, Prabhakar wrote:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > On the AX45MP core, cache coherency is a specification option so it may
> > not be supported. In this case DMA will fail. As a workaround, firstly we
> > allocate a global dma coherent pool from which DMA allocations are taken
> > and marked as non-cacheable + bufferable using the PMA region as specified
> > in the device tree. Synchronization callbacks are implemented to
> > synchronize when doing DMA transactions.
> >
> > The Andes AX45MP core has a Programmable Physical Memory Attributes (PMA)
> > block that allows dynamic adjustment of memory attributes in the runtime.
> > It contains a configurable amount of PMA entries implemented as CSR
> > registers to control the attributes of memory locations in interest.
> >
> > Below are the memory attributes supported:
> > * Device, Non-bufferable
> > * Device, bufferable
> > * Memory, Non-cacheable, Non-bufferable
> > * Memory, Non-cacheable, Bufferable
> > * Memory, Write-back, No-allocate
> > * Memory, Write-back, Read-allocate
> > * Memory, Write-back, Write-allocate
> > * Memory, Write-back, Read and Write-allocate
> >
> > This patch adds support to configure the memory attributes of the memory
> > regions as passed from the l2 cache node and exposes the cache management
> > ops.
>
> Forgive my ignorance, but why do you need both a DMA pool and explicit
> cache maintenance? Wouldn't the purpose of marking a memory region as
> permanently non-cacheable be to avoid cache maintenance? And likewise,
> if you are doing cache maintenance anyway, why does it matter if/how the
> memory is cacheable?
>
"Memory, Non-cacheable, Bufferable" raises an AXI signal for
transactions hence needing SW implementation for cache maintenance.

> > More info about PMA (section 10.3):
> > Link: http://www.andestech.com/wp-content/uploads/AX45MP-1C-Rev.-5.0.0-Datasheet.pdf
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> > RFC v3 -> v4
> > * Made use of runtime patching instead of compile time
> > * Now just exposing single function ax45mp_no_iocp_cmo() for CMO handling
> > * Added a check to make sure cache line size is always 64 bytes
> > * Renamed folder rzf -> rzfive
> > * Improved Kconfig description
> > * Dropped L2 cache configuration
> > * Dropped unnecessary casts
> > * Fixed comments pointed by Geert, apart from use of PTR_ALIGN_XYZ() macros.
> > ---
> >  arch/riscv/include/asm/cacheflush.h       |   8 +
> >  arch/riscv/include/asm/errata_list.h      |  32 +-
> >  drivers/soc/renesas/Kconfig               |   7 +
> >  drivers/soc/renesas/Makefile              |   2 +
> >  drivers/soc/renesas/rzfive/Kconfig        |   6 +
> >  drivers/soc/renesas/rzfive/Makefile       |   3 +
> >  drivers/soc/renesas/rzfive/ax45mp_cache.c | 415 ++++++++++++++++++++++
> >  drivers/soc/renesas/rzfive/ax45mp_sbi.h   |  29 ++
> >  8 files changed, 496 insertions(+), 6 deletions(-)
> >  create mode 100644 drivers/soc/renesas/rzfive/Kconfig
> >  create mode 100644 drivers/soc/renesas/rzfive/Makefile
> >  create mode 100644 drivers/soc/renesas/rzfive/ax45mp_cache.c
> >  create mode 100644 drivers/soc/renesas/rzfive/ax45mp_sbi.h
> >
> > diff --git a/arch/riscv/include/asm/cacheflush.h b/arch/riscv/include/asm/cacheflush.h
> > index 4a04d1be7c67..3226f3aceafe 100644
> > --- a/arch/riscv/include/asm/cacheflush.h
> > +++ b/arch/riscv/include/asm/cacheflush.h
> > @@ -61,6 +61,14 @@ static inline void riscv_noncoherent_supported(void) {}
> >  #define SYS_RISCV_FLUSH_ICACHE_LOCAL 1UL
> >  #define SYS_RISCV_FLUSH_ICACHE_ALL   (SYS_RISCV_FLUSH_ICACHE_LOCAL)
> >
> > +#ifdef CONFIG_AX45MP_L2_CACHE
> > +extern asmlinkage void ax45mp_no_iocp_cmo(unsigned int cache_size, void *vaddr,
> > +                                       size_t size, int dir, int ops);
> > +#else
> > +inline void ax45mp_no_iocp_cmo(unsigned int cache_size, void *vaddr,
> > +                            size_t size, int dir, int ops) {}
> > +#endif
> > +
> >  #include <asm-generic/cacheflush.h>
> >
> >  #endif /* _ASM_RISCV_CACHEFLUSH_H */
> > diff --git a/arch/riscv/include/asm/errata_list.h b/arch/riscv/include/asm/errata_list.h
> > index 48e899a8e7a9..300fed3bfd80 100644
> > --- a/arch/riscv/include/asm/errata_list.h
> > +++ b/arch/riscv/include/asm/errata_list.h
> > @@ -125,8 +125,8 @@ asm volatile(ALTERNATIVE(                                         \
> >  #define THEAD_SYNC_S ".long 0x0190000b"
> >
> >  #define ALT_CMO_OP(_op, _start, _size, _cachesize, _dir, _ops)               \
> > -asm volatile(ALTERNATIVE_2(                                          \
> > -     __nops(6),                                                      \
> > +asm volatile(ALTERNATIVE_3(                                          \
> > +     __nops(14),                                                     \
> >       "mv a0, %1\n\t"                                                 \
> >       "j 2f\n\t"                                                      \
> >       "3:\n\t"                                                        \
> > @@ -134,7 +134,7 @@ asm volatile(ALTERNATIVE_2(                                               \
> >       "add a0, a0, %0\n\t"                                            \
> >       "2:\n\t"                                                        \
> >       "bltu a0, %2, 3b\n\t"                                           \
> > -     "nop", 0, CPUFEATURE_ZICBOM, CONFIG_RISCV_ISA_ZICBOM,           \
> > +     __nops(8), 0, CPUFEATURE_ZICBOM, CONFIG_RISCV_ISA_ZICBOM,       \
> >       "mv a0, %1\n\t"                                                 \
> >       "j 2f\n\t"                                                      \
> >       "3:\n\t"                                                        \
> > @@ -142,8 +142,28 @@ asm volatile(ALTERNATIVE_2(                                              \
> >       "add a0, a0, %0\n\t"                                            \
> >       "2:\n\t"                                                        \
> >       "bltu a0, %2, 3b\n\t"                                           \
> > -     THEAD_SYNC_S, THEAD_VENDOR_ID,                                  \
> > -                     ERRATA_THEAD_CMO, CONFIG_ERRATA_THEAD_CMO)      \
> > +     THEAD_SYNC_S "\n\t"                                             \
> > +     __nops(8), THEAD_VENDOR_ID,                                     \
> > +                     ERRATA_THEAD_CMO, CONFIG_ERRATA_THEAD_CMO,      \
> > +     ".option push\n\t\n\t"                                          \
> > +     ".option norvc\n\t"                                             \
> > +     ".option norelax\n\t"                                           \
> > +     "addi sp,sp,-16\n\t"                                            \
> > +     "sd s0,0(sp)\n\t"                                               \
> > +     "sd ra,8(sp)\n\t"                                               \
> > +     "addi s0,sp,16\n\t"                                             \
> > +     "mv a4,%6\n\t"                                                  \
> > +     "mv a3,%5\n\t"                                                  \
> > +     "mv a2,%4\n\t"                                                  \
> > +     "mv a1,%3\n\t"                                                  \
> > +     "mv a0,%0\n\t"                                                  \
> > +     "call ax45mp_no_iocp_cmo\n\t"                                   \
> > +     "ld ra,8(sp)\n\t"                                               \
> > +     "ld s0,0(sp)\n\t"                                               \
> > +     "addi sp,sp,16\n\t"                                             \
> > +     ".option pop\n\t",                                              \
> > +     ANDESTECH_VENDOR_ID, ERRATA_ANDESTECH_NO_IOCP,                  \
> > +     CONFIG_ERRATA_ANDES_CMO)                                        \
> >       : : "r"(_cachesize),                                            \
> >           "r"((unsigned long)(_start) & ~((_cachesize) - 1UL)),       \
> >           "r"((unsigned long)(_start) + (_size)),                     \
> > @@ -151,7 +171,7 @@ asm volatile(ALTERNATIVE_2(                                               \
> >           "r"((unsigned long)(_size)),                                \
> >           "r"((unsigned long)(_dir)),                                 \
> >           "r"((unsigned long)(_ops))                                  \
> > -     : "a0")
> > +     : "a0", "a1", "a2", "a3", "a4", "memory")
> >
> >  #define THEAD_C9XX_RV_IRQ_PMU                        17
> >  #define THEAD_C9XX_CSR_SCOUNTEROF            0x5c5
> > diff --git a/drivers/soc/renesas/Kconfig b/drivers/soc/renesas/Kconfig
> > index 660498252ec5..e7810256c60d 100644
> > --- a/drivers/soc/renesas/Kconfig
> > +++ b/drivers/soc/renesas/Kconfig
> > @@ -340,9 +340,16 @@ if RISCV
> >  config ARCH_R9A07G043
> >       bool "RISC-V Platform support for RZ/Five"
> >       select ARCH_RZG2L
> > +     select AX45MP_L2_CACHE
> > +     select DMA_GLOBAL_POOL
> > +     select ERRATA_ANDES
> > +     select ERRATA_ANDES_CMO
> > +     select RISCV_DMA_NONCOHERENT
> >       help
> >         This enables support for the Renesas RZ/Five SoC.
> >
> > +source "drivers/soc/renesas/rzfive/Kconfig"
> > +
> >  endif # RISCV
> >
> >  config RST_RCAR
> > diff --git a/drivers/soc/renesas/Makefile b/drivers/soc/renesas/Makefile
> > index 535868c9c7e4..9df9f759a039 100644
> > --- a/drivers/soc/renesas/Makefile
> > +++ b/drivers/soc/renesas/Makefile
> > @@ -31,6 +31,8 @@ ifdef CONFIG_SMP
> >  obj-$(CONFIG_ARCH_R9A06G032) += r9a06g032-smp.o
> >  endif
> >
> > +obj-$(CONFIG_RISCV) += rzfive/
> > +
> >  # Family
> >  obj-$(CONFIG_RST_RCAR)               += rcar-rst.o
> >  obj-$(CONFIG_SYSC_RCAR)              += rcar-sysc.o
> > diff --git a/drivers/soc/renesas/rzfive/Kconfig b/drivers/soc/renesas/rzfive/Kconfig
> > new file mode 100644
> > index 000000000000..b6bc00337d99
> > --- /dev/null
> > +++ b/drivers/soc/renesas/rzfive/Kconfig
> > @@ -0,0 +1,6 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +
> > +config AX45MP_L2_CACHE
> > +     bool "Andes Technology AX45MP L2 Cache controller"
> > +     help
> > +       Support for the L2 cache controller on Andes Technology AX45MP platforms.
> > diff --git a/drivers/soc/renesas/rzfive/Makefile b/drivers/soc/renesas/rzfive/Makefile
> > new file mode 100644
> > index 000000000000..2012e7fb978d
> > --- /dev/null
> > +++ b/drivers/soc/renesas/rzfive/Makefile
> > @@ -0,0 +1,3 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +
> > +obj-$(CONFIG_AX45MP_L2_CACHE) += ax45mp_cache.o
> > diff --git a/drivers/soc/renesas/rzfive/ax45mp_cache.c b/drivers/soc/renesas/rzfive/ax45mp_cache.c
> > new file mode 100644
> > index 000000000000..4e0d0545d3af
> > --- /dev/null
> > +++ b/drivers/soc/renesas/rzfive/ax45mp_cache.c
> > @@ -0,0 +1,415 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * PMA setup and non-coherent cache functions for Andes AX45MP
> > + *
> > + * Copyright (C) 2022 Renesas Electronics Corp.
> > + */
> > +
> > +#include <linux/cacheflush.h>
> > +#include <linux/cacheinfo.h>
> > +#include <linux/dma-direction.h>
> > +#include <linux/of_address.h>
> > +#include <linux/of_platform.h>
> > +
> > +#include <asm/cacheflush.h>
> > +#include <asm/sbi.h>
> > +
> > +#include "ax45mp_sbi.h"
> > +
> > +/* L2 cache registers */
> > +#define AX45MP_L2C_REG_CTL_OFFSET            0x8
> > +
> > +#define AX45MP_L2C_REG_C0_CMD_OFFSET         0x40
> > +#define AX45MP_L2C_REG_C0_ACC_OFFSET         0x48
> > +#define AX45MP_L2C_REG_STATUS_OFFSET         0x80
> > +
> > +/* D-cache operation */
> > +#define AX45MP_CCTL_L1D_VA_INVAL             0
> > +#define AX45MP_CCTL_L1D_VA_WB                        1
> > +
> > +/* L2 cache */
> > +#define AX45MP_L2_CACHE_CTL_CEN_MASK         1
> > +
> > +/* L2 CCTL status */
> > +#define AX45MP_CCTL_L2_STATUS_IDLE           0
> > +
> > +/* L2 CCTL status cores mask */
> > +#define AX45MP_CCTL_L2_STATUS_C0_MASK                0xf
> > +
> > +/* L2 cache operation */
> > +#define AX45MP_CCTL_L2_PA_INVAL                      0x8
> > +#define AX45MP_CCTL_L2_PA_WB                 0x9
> > +
> > +#define AX45MP_L2C_HPM_PER_CORE_OFFSET               0x8
> > +#define AX45MP_L2C_REG_PER_CORE_OFFSET               0x10
> > +#define AX45MP_CCTL_L2_STATUS_PER_CORE_OFFSET        4
> > +
> > +#define AX45MP_L2C_REG_CN_CMD_OFFSET(n)      \
> > +     (AX45MP_L2C_REG_C0_CMD_OFFSET + ((n) * AX45MP_L2C_REG_PER_CORE_OFFSET))
> > +#define AX45MP_L2C_REG_CN_ACC_OFFSET(n)      \
> > +     (AX45MP_L2C_REG_C0_ACC_OFFSET + ((n) * AX45MP_L2C_REG_PER_CORE_OFFSET))
> > +#define AX45MP_CCTL_L2_STATUS_CN_MASK(n)     \
> > +     (AX45MP_CCTL_L2_STATUS_C0_MASK << ((n) * AX45MP_CCTL_L2_STATUS_PER_CORE_OFFSET))
> > +
> > +#define AX45MP_MICM_CFG_ISZ_OFFSET           6
> > +#define AX45MP_MICM_CFG_ISZ_MASK             (0x7  << AX45MP_MICM_CFG_ISZ_OFFSET)
> > +
> > +#define AX45MP_MDCM_CFG_DSZ_OFFSET           6
> > +#define AX45MP_MDCM_CFG_DSZ_MASK             (0x7  << AX45MP_MDCM_CFG_DSZ_OFFSET)
> > +
> > +#define AX45MP_CCTL_REG_UCCTLBEGINADDR_NUM   0x80b
> > +#define AX45MP_CCTL_REG_UCCTLCOMMAND_NUM     0x80c
> > +
> > +#define AX45MP_MCACHE_CTL_CCTL_SUEN_OFFSET   8
> > +#define AX45MP_MMSC_CFG_CCTLCSR_OFFSET               16
> > +#define AX45MP_MISA_20_OFFSET                        20
> > +
> > +#define AX45MP_MCACHE_CTL_CCTL_SUEN_MASK     (0x1 << AX45MP_MCACHE_CTL_CCTL_SUEN_OFFSET)
> > +#define AX45MP_MMSC_CFG_CCTLCSR_MASK         (0x1 << AX45MP_MMSC_CFG_CCTLCSR_OFFSET)
> > +#define AX45MP_MISA_20_MASK                  (0x1 << AX45MP_MISA_20_OFFSET)
> > +
> > +#define AX45MP_MAX_CACHE_LINE_SIZE           256
> > +
> > +#define AX45MP_MAX_PMA_REGIONS                       16
> > +
> > +struct ax45mp_priv {
> > +     void __iomem *l2c_base;
> > +     u32 ax45mp_cache_line_size;
> > +     bool l2cache_enabled;
> > +     bool ucctl_ok;
> > +};
> > +
> > +static struct ax45mp_priv *ax45mp_priv;
> > +static DEFINE_STATIC_KEY_FALSE(ax45mp_l2c_configured);
> > +
> > +/* PMA setup */
> > +static long ax45mp_sbi_set_pma(unsigned long start,
> > +                            unsigned long size,
> > +                            unsigned long flags,
> > +                            unsigned int entry_id)
> > +{
> > +     struct sbiret ret;
> > +
> > +     ret = sbi_ecall(SBI_EXT_ANDES, AX45MP_SBI_EXT_SET_PMA,
> > +                     start, size, entry_id, flags, 0, 0);
> > +
> > +     return ret.value;
> > +}
> > +
> > +static int ax45mp_configure_pma_regions(struct device_node *np)
> > +{
> > +     const char *propname = "andestech,pma-regions";
> > +     u32 start, size, flags;
> > +     unsigned int entry_id;
> > +     unsigned int i;
> > +     int count;
> > +     int ret;
> > +
> > +     count = of_property_count_elems_of_size(np, propname, sizeof(u32) * 3);
> > +     if (count < 0)
> > +             return count;
> > +
> > +     if (count > AX45MP_MAX_PMA_REGIONS)
> > +             return -EINVAL;
> > +
> > +     for (i = 0, entry_id = 0 ; entry_id < count ; i += 3, entry_id++) {
> > +             of_property_read_u32_index(np, propname, i, &start);
> > +             of_property_read_u32_index(np, propname, i + 1, &size);
> > +             of_property_read_u32_index(np, propname, i + 2, &flags);
> > +             ret = ax45mp_sbi_set_pma(start, size, flags, entry_id);
> > +             if (!ret)
> > +                     pr_err("Failed to setup PMA region 0x%x - 0x%x flags: 0x%x",
> > +                            start, start + size, flags);
> > +     }
> > +
> > +     return 0;
> > +}
>
> If firmware support is required to set up these PMA regions, why is
> Linux doing this at all? The firmware has access to the devicetree as
> well. It can set this up before entering S-mode, and then you don't need
> to expose this capability via an SBI extension. In fact, firmware could
> generate the reserved-memory node based on these regions at runtime (or
> vice versa).
>
That's a good point. I'll do some research on this and get back.

Btw are there any existing examples where the firmware adds DT nodes?

> > +
> > +/* L2 Cache operations */
> > +static uint32_t ax45mp_cpu_get_mcache_ctl_status(void)
> > +{
> > +     struct sbiret ret;
> > +
> > +     ret = sbi_ecall(SBI_EXT_ANDES, AX45MP_SBI_EXT_GET_MCACHE_CTL_STATUS,
> > +                     0, 0, 0, 0, 0, 0);
> > +     return ret.value;
> > +}
> > +
> > +static uint32_t ax45mp_cpu_get_micm_cfg_status(void)
> > +{
> > +     struct sbiret ret;
> > +
> > +     ret = sbi_ecall(SBI_EXT_ANDES, AX45MP_SBI_EXT_GET_MICM_CTL_STATUS,
> > +                     0, 0, 0, 0, 0, 0);
> > +     return ret.value;
> > +}
> > +
> > +static uint32_t ax45mp_cpu_get_mdcm_cfg_status(void)
> > +{
> > +     struct sbiret ret;
> > +
> > +     ret = sbi_ecall(SBI_EXT_ANDES, AX45MP_SBI_EXT_GET_MDCM_CTL_STATUS,
> > +                     0, 0, 0, 0, 0, 0);
> > +     return ret.value;
> > +}
> > +
> > +static uint32_t ax45mp_cpu_get_mmsc_cfg_status(void)
> > +{
> > +     struct sbiret ret;
> > +
> > +     ret = sbi_ecall(SBI_EXT_ANDES, AX45MP_SBI_EXT_GET_MMSC_CTL_STATUS,
> > +                     0, 0, 0, 0, 0, 0);
> > +     return ret.value;
> > +}
> > +
> > +static uint32_t ax45mp_cpu_get_misa_cfg_status(void)
> > +{
> > +     struct sbiret ret;
> > +
> > +     ret = sbi_ecall(SBI_EXT_ANDES, AX45MP_SBI_EXT_GET_MISA_CTL_STATUS,
> > +                     0, 0, 0, 0, 0, 0);
> > +     return ret.value;
> > +}
> > +
> > +static inline uint32_t ax45mp_cpu_l2c_get_cctl_status(void)
> > +{
> > +     return readl(ax45mp_priv->l2c_base + AX45MP_L2C_REG_STATUS_OFFSET);
> > +}
> > +
> > +static inline uint32_t ax45mp_cpu_l2c_ctl_status(void)
> > +{
> > +     return readl(ax45mp_priv->l2c_base + AX45MP_L2C_REG_CTL_OFFSET);
> > +}
> > +
> > +static bool ax45mp_cpu_cache_controlable(void)
> > +{
> > +     return (((ax45mp_cpu_get_micm_cfg_status() & AX45MP_MICM_CFG_ISZ_MASK) ||
> > +              (ax45mp_cpu_get_mdcm_cfg_status() & AX45MP_MDCM_CFG_DSZ_MASK)) &&
> > +             (ax45mp_cpu_get_misa_cfg_status() & AX45MP_MISA_20_MASK) &&
> > +             (ax45mp_cpu_get_mmsc_cfg_status() & AX45MP_MMSC_CFG_CCTLCSR_MASK) &&
> > +             (ax45mp_cpu_get_mcache_ctl_status() & AX45MP_MCACHE_CTL_CCTL_SUEN_MASK));
> > +}
> > +
> > +static void ax45mp_cpu_dcache_wb_range(void *start, void *end, int line_size)
> > +{
> > +     void __iomem *base = ax45mp_priv->l2c_base;
> > +     unsigned long pa;
> > +     int mhartid = 0;
> > +#ifdef CONFIG_SMP
> > +     mhartid = smp_processor_id();
> > +#endif
>
> This doesn't need an #ifdef. smp_processor_id() already returns zero
> when SMP is disabled.
>
Ok, I'll get rid of this check.

> > +
> > +     while (end > start) {
> > +             if (ax45mp_priv->ucctl_ok) {
> > +                     csr_write(AX45MP_CCTL_REG_UCCTLBEGINADDR_NUM, start);
> > +                     csr_write(AX45MP_CCTL_REG_UCCTLCOMMAND_NUM, AX45MP_CCTL_L1D_VA_WB);
> > +             }
> > +
> > +             if (ax45mp_priv->l2cache_enabled) {
> > +                     pa = virt_to_phys(start);
> > +                     writel(pa, base + AX45MP_L2C_REG_CN_ACC_OFFSET(mhartid));
> > +                     writel(AX45MP_CCTL_L2_PA_WB,
> > +                            base + AX45MP_L2C_REG_CN_CMD_OFFSET(mhartid));
> > +                     while ((ax45mp_cpu_l2c_get_cctl_status() &
> > +                             AX45MP_CCTL_L2_STATUS_CN_MASK(mhartid)) !=
> > +                             AX45MP_CCTL_L2_STATUS_IDLE)
> > +                             ;
> > +             }
> > +
> > +             start += line_size;
> > +     }
> > +}
> > +
> > +static void ax45mp_cpu_dcache_inval_range(void *start, void *end, int line_size)
> > +{
> > +     void __iomem *base = ax45mp_priv->l2c_base;
> > +     unsigned long pa;
> > +     int mhartid = 0;
> > +#ifdef CONFIG_SMP
> > +     mhartid = smp_processor_id();
> > +#endif
> > +
> > +     while (end > start) {
> > +             if (ax45mp_priv->ucctl_ok) {
> > +                     csr_write(AX45MP_CCTL_REG_UCCTLBEGINADDR_NUM, start);
> > +                     csr_write(AX45MP_CCTL_REG_UCCTLCOMMAND_NUM, AX45MP_CCTL_L1D_VA_INVAL);
> > +             }
> > +
> > +             if (ax45mp_priv->l2cache_enabled) {
> > +                     pa = virt_to_phys(start);
> > +                     writel(pa, base + AX45MP_L2C_REG_CN_ACC_OFFSET(mhartid));
> > +                     writel(AX45MP_CCTL_L2_PA_INVAL,
> > +                            base + AX45MP_L2C_REG_CN_CMD_OFFSET(mhartid));
> > +                     while ((ax45mp_cpu_l2c_get_cctl_status() &
> > +                             AX45MP_CCTL_L2_STATUS_CN_MASK(mhartid)) !=
> > +                             AX45MP_CCTL_L2_STATUS_IDLE)
> > +                             ;
> > +             }
> > +
> > +             start += line_size;
> > +     }
> > +}
> > +
> > +static void ax45mp_cpu_dma_inval_range(void *vaddr, size_t size)
> > +{
> > +     char cache_buf[2][AX45MP_MAX_CACHE_LINE_SIZE];
> > +     unsigned long start = (unsigned long)vaddr;
> > +     unsigned long end = start + size;
> > +     unsigned long old_start = start;
> > +     unsigned long old_end = end;
> > +     unsigned long line_size;
> > +     unsigned long flags;
> > +
> > +     if (static_branch_unlikely(&ax45mp_l2c_configured) && !ax45mp_priv)
> > +             return;
> > +
> > +     if (unlikely(start == end))
> > +             return;
> > +
> > +     line_size = ax45mp_priv->ax45mp_cache_line_size;
> > +
> > +     memset(&cache_buf, 0x0, sizeof(cache_buf));
> > +     start = start & (~(line_size - 1));
> > +     end = ((end + line_size - 1) & (~(line_size - 1)));
> > +
> > +     local_irq_save(flags);
> > +     if (unlikely(start != old_start))
> > +             memcpy(&cache_buf[0][0], (void *)start, line_size);
> > +
> > +     if (unlikely(end != old_end))
> > +             memcpy(&cache_buf[1][0], (void *)(old_end & (~(line_size - 1))), line_size);
>
> The memcpy dance is only required if ax45mp_cache_line_size is larger
> than ARCH_DMA_MINALIGN. Is that actually the case in practice? If not,
> you could verify this in the probe function, and remove this logic.
>
OK...
> > +
> > +     ax45mp_cpu_dcache_inval_range(vaddr, (void *)end, line_size);
> > +
> > +     if (unlikely(start != old_start))
> > +             memcpy((void *)start, &cache_buf[0][0], (old_start & (line_size - 1)));
> > +
> > +     if (unlikely(end != old_end))
> > +             memcpy((void *)(old_end + 1),
> > +                    &cache_buf[1][(old_end & (line_size - 1)) + 1],
> > +                    end - old_end - 1);
> > +
> > +     local_irq_restore(flags);
> > +}
> > +
> > +static void ax45mp_cpu_dma_wb_range(void *vaddr, size_t size)
> > +{
> > +     unsigned long start = (unsigned long)vaddr;
> > +     unsigned long end = start + size;
> > +     unsigned long line_size;
> > +     unsigned long flags;
> > +
> > +     if (static_branch_unlikely(&ax45mp_l2c_configured) && !ax45mp_priv)
> > +             return;
> > +
> > +     line_size = ax45mp_priv->ax45mp_cache_line_size;
> > +     local_irq_save(flags);
> > +     start = start & (~(line_size - 1));
> > +     ax45mp_cpu_dcache_wb_range(vaddr, (void *)end, line_size);
> > +     local_irq_restore(flags);
> > +}
> > +
> > +void ax45mp_no_iocp_cmo(unsigned int cache_size, void *vaddr, size_t size, int dir, int ops)
> > +{
> > +     if (ops == NON_COHERENT_DMA_PREP)
> > +             return;
> > +
> > +     if (ops == NON_COHERENT_SYNC_DMA_FOR_DEVICE) {
> > +             switch (dir) {
> > +             case DMA_FROM_DEVICE:
> > +                     ax45mp_cpu_dma_inval_range(vaddr, size);
> > +                     break;
> > +             case DMA_TO_DEVICE:
> > +             case DMA_BIDIRECTIONAL:
> > +                     ax45mp_cpu_dma_wb_range(vaddr, size);
> > +                     break;
> > +             default:
> > +                     break;
> > +             }
> > +             return;
> > +     }
> > +
> > +     /* op == NON_COHERENT_SYNC_DMA_FOR_CPU */
> > +     if (dir == DMA_BIDIRECTIONAL || dir == DMA_FROM_DEVICE)
> > +             ax45mp_cpu_dma_inval_range(vaddr, size);
> > +}
> > +EXPORT_SYMBOL(ax45mp_no_iocp_cmo);
> > +
> > +static int ax45mp_configure_l2_cache(struct device_node *np)
> > +{
> > +     int ret;
> > +
> > +     ret = of_property_read_u32(np, "cache-line-size", &ax45mp_priv->ax45mp_cache_line_size);
> > +     if (ret) {
> > +             pr_err("Failed to get cache-line-size defaulting to 64 bytes\n");
> > +             ax45mp_priv->ax45mp_cache_line_size = SZ_64;
> > +     }
> > +
> > +     if (ax45mp_priv->ax45mp_cache_line_size != SZ_64) {
> > +             pr_err("Expected cache-line-size to 64 bytes (found:%u). Defaulting to 64 bytes\n",
> > +                    ax45mp_priv->ax45mp_cache_line_size);
> > +             ax45mp_priv->ax45mp_cache_line_size = SZ_64;
> > +     }
>
> Ah, so you already do this. And SZ_64 == ARCH_DMA_MINALIGN. So you do
> not need the memcpy logic.
>
... I did some initial testing and all seems to be OK. I'll get rid of
that check.

> > +
> > +     ax45mp_priv->ucctl_ok = ax45mp_cpu_cache_controlable();
> > +     ax45mp_priv->l2cache_enabled = ax45mp_cpu_l2c_ctl_status() & AX45MP_L2_CACHE_CTL_CEN_MASK;
> > +
> > +     return 0;
> > +}
> > +
> > +static int ax45mp_l2c_probe(struct platform_device *pdev)
> > +{
> > +     struct device_node *np = pdev->dev.of_node;
> > +     int ret;
> > +
> > +     ax45mp_priv = devm_kzalloc(&pdev->dev, sizeof(*ax45mp_priv), GFP_KERNEL);
> > +     if (!ax45mp_priv)
> > +             return -ENOMEM;
> > +
> > +     ax45mp_priv->l2c_base = devm_of_iomap(&pdev->dev, pdev->dev.of_node, 0, NULL);
>
> devm_platform_ioremap_resource()
>
OK.

> > +     if (!ax45mp_priv->l2c_base) {
> > +             ret = -ENOMEM;
> > +             goto l2c_err;
> > +     }
> > +
> > +     ret = ax45mp_configure_l2_cache(np);
> > +     if (ret)
> > +             goto l2c_err;
> > +
> > +     ret = ax45mp_configure_pma_regions(np);
> > +     if (ret)
> > +             goto l2c_err;
> > +
> > +     static_branch_disable(&ax45mp_l2c_configured);
>
> Instead of enabling this before the probe function, and disabling it
> afterward, just enable it once here, in the success case. Then you can
> drop the !ax45mp_priv check in the functions above.
>
I think I had tried it but static_branch_unlikely() was always returning true.

> And none of the functions would get called anyway if the alternative is
> not applied. I suppose it's not possible to do some of this probe logic
> in the alternative check function?
>
you mean to check in the vendor errata patch function to see if this
driver has probed?

> > +
> > +     return 0;
> > +
> > +l2c_err:
> > +     devm_kfree(&pdev->dev, ax45mp_priv);
> > +     ax45mp_priv = NULL;
>
> None of this cleanup is necessary.
>
Agreed, I'll drop it.

Cheers,
Prabhakar
