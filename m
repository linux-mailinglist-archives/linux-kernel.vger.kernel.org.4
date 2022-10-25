Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2F2760D7D1
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 01:21:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbiJYXVi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 19:21:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbiJYXVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 19:21:34 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FCEDEE89F;
        Tue, 25 Oct 2022 16:21:32 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id f27so6251611eje.1;
        Tue, 25 Oct 2022 16:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N8qLZCJs207FRKbAMza0jOSxatCdVnL0yZ2nFjMmBRs=;
        b=nRHmehKKLQKqqE2OJLSL9LcIJ7qMj4IMYQHIe1+PRF8XmuE0R3LBYI9UGaLAFjUa26
         mSV2zOAzVJkwiE6Yzx464TrGShA7cL8ivrcSrq+2gvKNbxi1CrV2S6Arx0A5OI+L9YnU
         s/pXZqfPF3SsC1zMwoIVGnuEcfSoIgkXB0fIo582fjoDFRS6dwV/zJHmevqkzdTFYV0w
         UALtCTdU9Zc8DzdJY+grL4KpTTmHB13ZG2vHOsUwQeKaDT/YORsXzrnrs+CTuuD+dSHi
         azoHs+0of0w7MRJn7G3/UTiDXk2X+ElaWWyYUwFdqI+ooIuDgGrllpdMs9QiRCPljKYG
         bBkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N8qLZCJs207FRKbAMza0jOSxatCdVnL0yZ2nFjMmBRs=;
        b=wR/+2wYD7viXVA1gZ6xI5JwBIFbfqCZd2ctj94SDwPT3pyRy1NemsAHbqalVLa/yDa
         16eF+dER12f6sxGQO4zx0+fFOZNpRut+LlALelD+zEPFcXZ+wTDER+b0Z702zBtZhBNd
         fn1askxmF5joOqCFedOu8KiTe5gkhuB/PYcUiuCIJM5JJs0JWb/U5mVJWOeHJIwb2AXX
         Rp+7AnZlYD2mD2G2jofWidIv/kaq88FKZp3bfJOs+RkiyYAhqWAUEScMPezHGTtUEYJw
         JwDsNJ6b1UdpVWKKYYIILimLfMpA9xNDwSOqHly4kVwA7pjAec5iqoMvk9pg4rG5s/jy
         mNNA==
X-Gm-Message-State: ACrzQf215H3gUrGEcEP1UzZvzgBHPFtmyXCDSXsZmOMP0Hmxkz0Vah3P
        u2me5VfHlWjSHDb2Xb51SuhzPErrN0p8F7MWe4c=
X-Google-Smtp-Source: AMsMyM5WmyKM4wQE0RDi321OwHcIA55CrRYQmki0UsYtUkfbd1ZkH60lW4ALYlDdJCmP4CAlm9tsjmO2YN6T2Y+4Wic=
X-Received: by 2002:a17:907:847:b0:77f:f489:cc25 with SMTP id
 ww7-20020a170907084700b0077ff489cc25mr34389161ejb.80.1666740090766; Tue, 25
 Oct 2022 16:21:30 -0700 (PDT)
MIME-Version: 1.0
References: <20221019220242.4746-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <Y1Md4bMYJHI34HuJ@spud> <CA+V-a8vA_ZbV+SEy8Ch8ZuYAb+U37CtC8Ys=svMv7fjy79mR=A@mail.gmail.com>
 <4750602.GXAFRqVoOG@diego>
In-Reply-To: <4750602.GXAFRqVoOG@diego>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Wed, 26 Oct 2022 00:21:03 +0100
Message-ID: <CA+V-a8tduYF0tCad4CmODzSqhabQpzsKKWMXC3GTGj3zL38GAg@mail.gmail.com>
Subject: Re: [RFC PATCH v3 2/2] soc: renesas: Add L2 cache management for
 RZ/Five SoC
To:     =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc:     Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
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
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heiko,

On Mon, Oct 24, 2022 at 1:04 PM Heiko St=C3=BCbner <heiko@sntech.de> wrote:
>
> Hi Prabhakar,
>
> Am Montag, 24. Oktober 2022, 13:55:00 CEST schrieb Lad, Prabhakar:
> > Hi Conor,
> >
> > On Fri, Oct 21, 2022 at 11:32 PM Conor Dooley <conor@kernel.org> wrote:
> > >
> > > On Fri, Oct 21, 2022 at 11:05:40PM +0100, Lad, Prabhakar wrote:
> > > > Hi Rob,
> > > >
> > > > Thank you for the review.
> > > >
> > > > On Fri, Oct 21, 2022 at 3:05 AM Rob Herring <robh@kernel.org> wrote=
:
> > > > >
> > > > > On Wed, Oct 19, 2022 at 11:02:42PM +0100, Prabhakar wrote:
> > > > > > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > > > >
> > > > > > On the AX45MP core, cache coherency is a specification option s=
o it may
> > > > > > not be supported. In this case DMA will fail. As a workaround, =
firstly we
> > > > > > allocate a global dma coherent pool from which DMA allocations =
are taken
> > > > > > and marked as non-cacheable + bufferable using the PMA region a=
s specified
> > > > > > in the device tree. Synchronization callbacks are implemented t=
o
> > > > > > synchronize when doing DMA transactions.
> > > > > >
> > > > > > The Andes AX45MP core has a Programmable Physical Memory Attrib=
utes (PMA)
> > > > > > block that allows dynamic adjustment of memory attributes in th=
e runtime.
> > > > > > It contains a configurable amount of PMA entries implemented as=
 CSR
> > > > > > registers to control the attributes of memory locations in inte=
rest.
> > > > > >
> > > > > > Below are the memory attributes supported:
> > > > > > * Device, Non-bufferable
> > > > > > * Device, bufferable
> > > > > > * Memory, Non-cacheable, Non-bufferable
> > > > > > * Memory, Non-cacheable, Bufferable
> > > > > > * Memory, Write-back, No-allocate
> > > > > > * Memory, Write-back, Read-allocate
> > > > > > * Memory, Write-back, Write-allocate
> > > > > > * Memory, Write-back, Read and Write-allocate
> > > > > >
> > > > > > This patch adds support to configure the memory attributes of t=
he memory
> > > > > > regions as passed from the l2 cache node and exposes the cache =
management
> > > > > > ops.
> > > > > >
> > > > > > More info about PMA (section 10.3):
> > > > > > http://www.andestech.com/wp-content/uploads/AX45MP-1C-Rev.-5.0.=
0-Datasheet.pdf
> > > > > >
> > > > > > This feature is based on the work posted [0] by Vincent Chen
> > > > > > <vincentc@andestech.com> for the Andes AndeStart RISC-V CPU.
> > > > > >
> > > > > > [0] https://lore.kernel.org/lkml/1540982130-28248-1-git-send-em=
ail-vincentc@andestech.com/
> > > > > >
> > > > > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renes=
as.com>
> > > > > > ---
> > > > > >  arch/riscv/include/asm/cacheflush.h    |   8 +
> > > > > >  arch/riscv/include/asm/errata_list.h   |   2 +
> > > > > >  arch/riscv/mm/dma-noncoherent.c        |  20 ++
> > > > > >  drivers/soc/renesas/Kconfig            |   5 +
> > > > > >  drivers/soc/renesas/Makefile           |   4 +
> > > > > >  drivers/soc/renesas/rzf/Kconfig        |   6 +
> > > > > >  drivers/soc/renesas/rzf/Makefile       |   3 +
> > > > > >  drivers/soc/renesas/rzf/ax45mp_cache.c | 431 +++++++++++++++++=
++++++++
> > > > >
> > > > > How many cache drivers do we have around now? I've seen a few bin=
dings
> > > > > go by. I'm guessing it is time to stop putting the drivers in the
> > > > > drivers/soc/ dumping ground.
> > > > >
> > > > The main reason this driver is not in arch/riscv is that it has ven=
dor
> > > > specific extensions. Due to this reason it was agreed during the LP=
C
> > > > that vendor specific extension should be maintained by SoC vendors =
and
> > > > was agreed that this can go into drivers/soc/renesas folder instead=
.
> > >
> > > Does not in drivers/soc mean they need to go into arch/riscv?
> > I was under the impression Rob wanted them arch/riscv, sorry for the co=
nfusion.
> >
> > > The outcome of the chat at the LPC BoF was more that the cache driver=
s
> > > themselves should not be be routed via the arch maintainers, no?
> > >
> > Indeed.
> >
> > > >
> > > > > >  drivers/soc/renesas/rzf/ax45mp_sbi.h   |  29 ++
> > > > > >  9 files changed, 508 insertions(+)
> > > > > >  create mode 100644 drivers/soc/renesas/rzf/Kconfig
> > > > > >  create mode 100644 drivers/soc/renesas/rzf/Makefile
> > > > > >  create mode 100644 drivers/soc/renesas/rzf/ax45mp_cache.c
> > > > > >  create mode 100644 drivers/soc/renesas/rzf/ax45mp_sbi.h
> > > > > >
> > > > > > diff --git a/arch/riscv/include/asm/cacheflush.h b/arch/riscv/i=
nclude/asm/cacheflush.h
> > > > > > index 8a5c246b0a21..40aa790be9a3 100644
> > > > > > --- a/arch/riscv/include/asm/cacheflush.h
> > > > > > +++ b/arch/riscv/include/asm/cacheflush.h
> > > > > > @@ -65,6 +65,14 @@ static inline void riscv_noncoherent_support=
ed(void) {}
> > > > > >  #define SYS_RISCV_FLUSH_ICACHE_LOCAL 1UL
> > > > > >  #define SYS_RISCV_FLUSH_ICACHE_ALL   (SYS_RISCV_FLUSH_ICACHE_L=
OCAL)
> > > > > >
> > > > > > +#ifdef CONFIG_AX45MP_L2_CACHE
> > > > > > +void ax45mp_cpu_dma_inval_range(void *vaddr, size_t end);
> > > > > > +void ax45mp_cpu_dma_wb_range(void *vaddr, size_t end);
> > > > > > +
> > > > > > +#define ALT_CMO_OP(_op, _start, _size, _cachesize)   \
> > > > > > +                _op(_start, _size)
> > > > > > +#endif
> > > > > > +
> > > > > >  #include <asm-generic/cacheflush.h>
> > > > > >
> > > > > >  #endif /* _ASM_RISCV_CACHEFLUSH_H */
> > > > > > diff --git a/arch/riscv/include/asm/errata_list.h b/arch/riscv/=
include/asm/errata_list.h
> > > > > > index 19a771085781..d9cbf60c3b65 100644
> > > > > > --- a/arch/riscv/include/asm/errata_list.h
> > > > > > +++ b/arch/riscv/include/asm/errata_list.h
> > > > > > @@ -89,6 +89,7 @@ asm volatile(ALTERNATIVE(                    =
                       \
> > > > > >  #define ALT_THEAD_PMA(_val)
> > > > > >  #endif
> > > > > >
> > > > > > +#ifdef CONFIG_ERRATA_THEAD_CMO
> > > > > >  /*
> > > > > >   * dcache.ipa rs1 (invalidate, physical address)
> > > > > >   * | 31 - 25 | 24 - 20 | 19 - 15 | 14 - 12 | 11 - 7 | 6 - 0 |
> > > > > > @@ -143,5 +144,6 @@ asm volatile(ALTERNATIVE_2(                =
                               \
> > > > > >       : "a0")
> > > > > >
> > > > > >  #endif /* __ASSEMBLY__ */
> > > > > > +#endif
> > > > > >
> > > > > >  #endif
> > > > > > diff --git a/arch/riscv/mm/dma-noncoherent.c b/arch/riscv/mm/dm=
a-noncoherent.c
> > > > > > index b0add983530a..5270acca6766 100644
> > > > > > --- a/arch/riscv/mm/dma-noncoherent.c
> > > > > > +++ b/arch/riscv/mm/dma-noncoherent.c
> > > > > > @@ -24,13 +24,25 @@ void arch_sync_dma_for_device(phys_addr_t p=
addr, size_t size,
> > > > > >
> > > > > >       switch (dir) {
> > > > > >       case DMA_TO_DEVICE:
> > > > > > +#ifdef CONFIG_ERRATA_THEAD_CMO
> > > > > >               ALT_CMO_OP(clean, vaddr, size, riscv_cbom_block_s=
ize);
> > > > > > +#elif CONFIG_AX45MP_L2_CACHE
> > > > > > +             ALT_CMO_OP(ax45mp_cpu_dma_wb_range, vaddr, size, =
0x0);
> > > > > > +#endif
> > > > >
> > > > > How do you support more than one platform in a build?
> > > > >
> > > > Yes, that's one concern which I have mentioned in the cover letter =
too
> > > > (At that moment it's just a single platform). Suggestions welcome!
> > >
> > > I think I said it on one of the earlier version, but it needs to be
> > > implemented w/ runtime patching via alternatives just like the thead
> > > stuff patches in their functions.
> > >
> > I'm a bit stumped with alternatives() usage.
> >
> > Currently I am just replacing the ALT_CMO_OP() macro if
> > CONFIG_AX45MP_L2_CACHE is enabled. For AX45MP currently we have two
> > exported functions ax45mp_cpu_dma_inval_range/ax45mp_cpu_dma_wb_range.
> > If I switch to
> > ALTERNATIVE() macro usage then I'll have to use the assembly version
> > of the above two mentioned functions?
>
> The overarching goal should always be the unified-kernel-image.
> So hardware-specific compile-time #ifeefs are normally a no-no :-) .
>
> So yes, it most likely should be assembly-based, and you'll "just" need
> to introduce an ALTERNATIVE_3 macro, similar to what ALTERNAITVE_2 does.
>
> That is actually the really nice part of alternatives, that you can have =
as
> many variants as you like.
>
Thank you for the pointer. I'm still going through the ALTERNATIVE()
macro implementation, do you think "call  <c_function>" would be an
acceptable approach (I haven't implemented/nor tested)? Or is it that
my understanding is completely invalid?

Cheers,
Prabhakar
