Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBB016156DA
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 02:02:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbiKBBCf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 21:02:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiKBBCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 21:02:33 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 178B31F61D;
        Tue,  1 Nov 2022 18:02:32 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id kt23so41375284ejc.7;
        Tue, 01 Nov 2022 18:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1NL65ctDu7Unb6G0NzPXkABlskH655QCWon4X0fuchI=;
        b=hGawBFzd27Ll/+ulBi0YThZo+OCE5WQppu6U/JIsgVX9F19ZlS0csCHGEXm0OgpvMb
         wpYrl+6aUFV00YDV+ZM14r6Vi1whkq7+IAblyUccWIXB7RouuehTaVLg/caaSzrgsxs5
         zUetBOVuUl1O3Uh6fz0NprxI1JBc6ArkdhCC8skOvJMQqBStALqoeKSSUCLr1VnqSvpL
         OzE5sWKTb8zxNC0/bUuy30pbNRr7J1Ry4ykBUCezoybx7125w1dwjSN/49CUF38idloA
         SPuuSJOUUC2k8xQHm0A5eJ/C80NcViOSrRgHjQ+NbOBjTQDO0NlB46bvWWSXrjm2YRsx
         w/tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1NL65ctDu7Unb6G0NzPXkABlskH655QCWon4X0fuchI=;
        b=Gs/inZsBzVTYE3OkT98bTjVGEcltopBPu9dHr6Q+AZJz2TSYWNpxfNcWLshgyWDcA8
         7fKBtK7Jij1thZNMPHvBp9kKkw7RgPEvXHZezaaESNutuZVPpqWUeJ38LCX0f7yruqar
         vX4UQsNVicI6l8v8IetkJdB3jvFmMtSBuCPR6VyME7rVInpL8kvCnwkT8x0+mKzLPTO5
         GgSXkJmlUTVOOTKGVt7shqpPziYz9c/Sba9R18APxuI62XGaRWNNkedk/JBGBv28aH/g
         pt+lJ5LTSXXOzR4MTewDGcGa2+r9eoZOXsYNwySwblVcsj76kQPbk/qS0B7Ta5/EYXJr
         znpg==
X-Gm-Message-State: ACrzQf3KTMnsThgVsQrtqRjSDDsly4dCTbpC5pGrDLz7foeaSDDaSGHE
        tsp0aY7tTSxqz408eahkJvbn600KqZKXca7pUG4=
X-Google-Smtp-Source: AMsMyM6sS5NbLcirE7cuNJF2ENVum0rp7FXZA+0mfV0A+E4UsSVJu+1ylaOAVgpzZgqxdwewr0jHMytjSwRGzUq5nGM=
X-Received: by 2002:a17:906:371a:b0:7ad:c01c:6fa0 with SMTP id
 d26-20020a170906371a00b007adc01c6fa0mr16456257ejc.267.1667350950657; Tue, 01
 Nov 2022 18:02:30 -0700 (PDT)
MIME-Version: 1.0
References: <20221019220242.4746-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20221019220242.4746-3-prabhakar.mahadev-lad.rj@bp.renesas.com> <CAMuHMdXqh=wQaTYTuQ8vq__=2jvqRx1i9fpQsVPKpBJrBOy1Hw@mail.gmail.com>
In-Reply-To: <CAMuHMdXqh=wQaTYTuQ8vq__=2jvqRx1i9fpQsVPKpBJrBOy1Hw@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Wed, 2 Nov 2022 01:02:04 +0000
Message-ID: <CA+V-a8uDo83ZvCwQdDtxEzLUDvs42AP3Kqd36tuB3+vYuG8WUw@mail.gmail.com>
Subject: Re: [RFC PATCH v3 2/2] soc: renesas: Add L2 cache management for
 RZ/Five SoC
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.co>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
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

Hi Geert,

On Tue, Nov 1, 2022 at 12:43 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Prabhakar,
>
> On Thu, Oct 20, 2022 at 12:02 AM Prabhakar <prabhakar.csengg@gmail.com> wrote:
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
> >
> > More info about PMA (section 10.3):
> > http://www.andestech.com/wp-content/uploads/AX45MP-1C-Rev.-5.0.0-Datasheet.pdf
> >
> > This feature is based on the work posted [0] by Vincent Chen
> > <vincentc@andestech.com> for the Andes AndeStart RISC-V CPU.
> >
> > [0] https://lore.kernel.org/lkml/1540982130-28248-1-git-send-email-vincentc@andestech.com/
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Thanks for your patch!
>
> > --- a/arch/riscv/mm/dma-noncoherent.c
> > +++ b/arch/riscv/mm/dma-noncoherent.c
> > @@ -24,13 +24,25 @@ void arch_sync_dma_for_device(phys_addr_t paddr, size_t size,
> >
> >         switch (dir) {
> >         case DMA_TO_DEVICE:
> > +#ifdef CONFIG_ERRATA_THEAD_CMO
> >                 ALT_CMO_OP(clean, vaddr, size, riscv_cbom_block_size);
> > +#elif CONFIG_AX45MP_L2_CACHE
>
> "#elif defined(CONFIG_AX45MP_L2_CACHE)" (everywhere)
>
> Else it may fail with:
>
>     error: "CONFIG_AX45MP_L2_CACHE" is not defined, evaluates to 0
> [-Werror=undef]
>
Agreed, thanks for pointing this out. Said that I plan to get rid of
these checks in the next version (only after getting around the
ALTERNATIVE() macro).

Cheers,
Prabhakar
