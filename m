Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3039B64DFF4
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 18:47:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbiLORrR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 12:47:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230247AbiLORrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 12:47:11 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42C522980F;
        Thu, 15 Dec 2022 09:47:10 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id ud5so371374ejc.4;
        Thu, 15 Dec 2022 09:47:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JGmgZEJwFGxq+tUJYcXII0yBmtBtW32bwyy/70MdbiY=;
        b=YOKNh+N1K5reV2/yMC6/eEnoXA9e6b9OgVDEXlpOrSbPbyepO1oL6L/45xFN+iNcOQ
         TTi0gzamLrcbQqkbJnrNUXD+kRoEtCiJKIu8ggiMfz9J2dNjSTBjtSDuB6hPUpng/CEZ
         F7xAld01tAikhNvW3MuNYhf9DrVEOOoJpGQ61tvqryod7tg3DDYEOni2a+EajvIAqTx/
         Pwx5kE6SOP3s3VZ1f2EMBUhx5BU3EbfaCxnPUhsh/ofoG1eQK4hiSCk9nbQV2YbspWNX
         DBSRTagf8xzNGNC3IuaKbncnc35lIjcUrwmVFz8qFA0ok2ius5Jv36EHAIOk8zIwfnMw
         jeRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JGmgZEJwFGxq+tUJYcXII0yBmtBtW32bwyy/70MdbiY=;
        b=sqjsB/y140wJrZs4Nrks+Po+BLXe9Ez9rHs4z/Wvu7ZxIMjgWWx4onj3WRXLYPRIJ0
         vSbIYcSH6yw51VCJ2EK7uUp+nV0NXy4CtowVyL50IX6SO8oycd2DCzQkY0Vkzkv76SbH
         ioEzfV1Wau0QD6XNTTDb5P2tHUTD8lKbbLxs56SfIC3ZHKlitjRZRcEhnJ/t3S8OR0Ud
         8saQOhyslIChg6YYXdRNogdAfperg/+xC/Fh7d1S1/wdid/zlfYqmpe5Hl45gXwmO7Av
         sPWi1DBXaj/1Vxu2VQ8YefcoGUeyvAEJLWUFY+hYYohTXGanFRNtZ3UPHjiNgq1lsWDN
         0x3A==
X-Gm-Message-State: ANoB5pn0YsG8si4yPMt2M8d+N8qGO5vgUqqvaV/eLcNLHP6u3mdmxVMO
        rI38jOi6kG2AFwZ/CdhbFEAJpCJRTuk7i0D2oVQ=
X-Google-Smtp-Source: AA0mqf7zOOrpIm6ljuWR+UTfR7djRoUjzyIcU1ELgsZnq2JH4S9ddusWL3TvOqNxvdRw1SO4g2Txe60hnnWLZ30C1jg=
X-Received: by 2002:a17:906:9615:b0:7c0:f459:a0e4 with SMTP id
 s21-20020a170906961500b007c0f459a0e4mr15336359ejx.155.1671126428687; Thu, 15
 Dec 2022 09:47:08 -0800 (PST)
MIME-Version: 1.0
References: <20221212115505.36770-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20221212115505.36770-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAMuHMdUCkCyLOXbQEJyc7S2F08=ftNtPcEztRN3JWJv_FPmAVw@mail.gmail.com>
 <CA+V-a8vD=SOb6gPOwdPUE=kHeqa+oo2L-rbaW8zGjvw7YyQsqg@mail.gmail.com> <CAMuHMdWX4Yd52=Jv8kABtn+1B1V=dC2iXVZ81gNZBWNu4hb_3w@mail.gmail.com>
In-Reply-To: <CAMuHMdWX4Yd52=Jv8kABtn+1B1V=dC2iXVZ81gNZBWNu4hb_3w@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Thu, 15 Dec 2022 17:46:42 +0000
Message-ID: <CA+V-a8t3+zzQ4yPftsAa51rkMGHr45NhMO4_2WmZ9BGg0wuQvw@mail.gmail.com>
Subject: Re: [PATCH v5 6/6] soc: renesas: Add L2 cache management for RZ/Five SoC
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Magnus Damm <magnus.damm@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Conor Dooley <conor.dooley@microchip.com>,
        Samuel Holland <samuel@sholland.org>,
        Guo Ren <guoren@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Atish Patra <atishp@rivosinc.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
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

On Thu, Dec 15, 2022 at 11:10 AM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
>
> Hi Prabhakar,
>
> On Thu, Dec 15, 2022 at 12:06 PM Lad, Prabhakar
> <prabhakar.csengg@gmail.com> wrote:
> > On Thu, Dec 15, 2022 at 10:36 AM Geert Uytterhoeven
> > <geert@linux-m68k.org> wrote:
> > > On Mon, Dec 12, 2022 at 12:58 PM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> > > > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > >
> > > > I/O Coherence Port (IOCP) provides an AXI interface for connecting
> > > > external non-caching masters, such as DMA controllers. The accesses
> > > > from IOCP are coherent with D-Caches and L2 Cache.
> > > >
> > > > IOCP is a specification option and is disabled on the Renesas RZ/Five
> > > > SoC due to this reason IP blocks using DMA will fail.
> > > >
> > > > The Andes AX45MP core has a Programmable Physical Memory Attributes (PMA)
> > > > block that allows dynamic adjustment of memory attributes in the runtime.
> > > > It contains a configurable amount of PMA entries implemented as CSR
> > > > registers to control the attributes of memory locations in interest.
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
> > > > More info about PMA (section 10.3):
> > > > Link: http://www.andestech.com/wp-content/uploads/AX45MP-1C-Rev.-5.0.0-Datasheet.pdf
> > > >
> > > > As a workaround for SoCs with IOCP disabled CMO needs to be handled by
> > > > software. Firstly OpenSBI configures the memory region as
> > > > "Memory, Non-cacheable, Bufferable" and passes this region as a global
> > > > shared dma pool as a DT node. With DMA_GLOBAL_POOL enabled all DMA
> > > > allocations happen from this region and synchronization callbacks are
> > > > implemented to synchronize when doing DMA transactions.
> > > >
> > > > Example PMA region passes as a DT node from OpenSBI:
> > > >     reserved-memory {
> > > >         #address-cells = <2>;
> > > >         #size-cells = <2>;
> > > >         ranges;
> > > >
> > > >         pma_resv0@58000000 {
> > > >             compatible = "shared-dma-pool";
> > > >             reg = <0x0 0x58000000 0x0 0x08000000>;
> > > >             no-map;
> > > >             linux,dma-default;
> > > >         };
> > > >     };
> > > >
> > > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > >
> > > Thanks for your patch!
> > >
> > > >  arch/riscv/include/asm/cacheflush.h       |   8 +
> > > >  arch/riscv/include/asm/errata_list.h      |  28 ++-
> > > >  drivers/soc/renesas/Kconfig               |   6 +
> > > >  drivers/soc/renesas/Makefile              |   2 +
> > > >  drivers/soc/renesas/rzfive/Kconfig        |   6 +
> > > >  drivers/soc/renesas/rzfive/Makefile       |   3 +
> > > >  drivers/soc/renesas/rzfive/ax45mp_cache.c | 256 ++++++++++++++++++++++
> > >
> > > Given this touches arch/riscv/include/asm/, I don't think the
> > > code belongs under drivers/soc/renesas/.
> > >
> > Ok. Do you have any suggestions on where you want me to put this code?
>
> As it plugs into core riscv functionality, I think it should be under
> arch/riscv/.
> if the RISC-V maintainers object to that, another option is
> drivers/soc/andestech/ or (new) drivers/cache/
>
RISC-V maintainers had already made it clear to not to include vendor
specific stuff in the arch/riscv folder, so I'll consider putting this
into drivers/cache/ folder to sync with the bindings.

Conor/Palmer - do you have any objections/suggestions?

Cheers,
Prabhakar
