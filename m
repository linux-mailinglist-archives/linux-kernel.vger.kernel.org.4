Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF9BD6E1422
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 20:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbjDMS0r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 14:26:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjDMS0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 14:26:45 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F76D76B4;
        Thu, 13 Apr 2023 11:26:29 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id e9e14a558f8ab-3294d582947so4098605ab.1;
        Thu, 13 Apr 2023 11:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681410388; x=1684002388;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cYuEjEbEPDSMvvaHBlTko8UtitDT729rV6ITgl5m4LE=;
        b=sjh8zKjZxASu4FTHtLDRNrfYwizf3MZtospmSwbv5dB9mcCLUpCkFoF3XwykJNnXtF
         jDIhMTE14Pwqu3K6aUpWg7rFMr1Om6Ts2hSo0qX4Qncmv9JJLNZ0zWZtA5hall+FXGwz
         PYXt00AJsqv/WG/wAU568nfG26iqUPGSMTgNif3Ci683Id16HQyl9VdveqkoZADMWX67
         idZ20Dy5nVGJTX7qnHQA5V66rWq4JanEZMf4xl44hA8Ava8DaR1dbaABpbbHo+kp4KGM
         UvCXn8GBvN7Nn07dO3/ocg+UCib+/L0RQ7K1MgJCTOz6K/hqGvuyCMlVg1vjYqGLmazD
         pgmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681410388; x=1684002388;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cYuEjEbEPDSMvvaHBlTko8UtitDT729rV6ITgl5m4LE=;
        b=R47uVIFwz7PFn8LdNAPbmqSOcbsgfNvv4KoN5wfbVLl9/IE+SQB+Rg7UNXQEMn8b6B
         U+NIhCFotfxOQssRl+CIwgBVAvL9OiokgAyCs9xPsUywT3kIK2PsImhEb7tqzjaxu9VL
         ZpTStwNq/LlqQCPMHnMGbIc4XhFfvmkO8yJa9ZOsl++MvDwZb057BzrbT5DzKTefg26x
         HeIsh9g87l6T6gWHlbhqF0fF7EQbo1+yFLX8iaEkcrJixzuhLsjY3RhbnFVefvbLVQC2
         NzDxi3yYJPNvJCOv+0lAal/H6kP8paDCVjGWGrJ67IkLsatdxOLX2TrBggA8XFp+VfP2
         lPRw==
X-Gm-Message-State: AAQBX9d+uwTNUpVtSFqr9Q9b2gyHt9xsRpziw2/Iq+ZMBh9cMfPfq0wX
        wPOb/XABb61hx3JBmVZGTE9XEPup3iwQ1bR9yYY=
X-Google-Smtp-Source: AKy350YLYttw68A/sm+q6B1DJJ42F6HN6f5sbUEbrfaKZ2y+94kIXikYs9CQu6mD1KoW818hYhctLYeH+Fb4I5i3Fa8=
X-Received: by 2002:a92:4a03:0:b0:32a:9195:7374 with SMTP id
 m3-20020a924a03000000b0032a91957374mr354196ilf.1.1681410388569; Thu, 13 Apr
 2023 11:26:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230412110900.69738-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20230412110900.69738-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20230412-cheddar-prune-5ce03ccf5581@spud> <20230413-aorta-unheated-c9bb35411fb2@wendy>
In-Reply-To: <20230413-aorta-unheated-c9bb35411fb2@wendy>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Thu, 13 Apr 2023 19:26:02 +0100
Message-ID: <CA+V-a8uksWMihUadYc_dCoef7vaC5ncOicX0oGpSP9HRnHgScw@mail.gmail.com>
Subject: Re: [PATCH v8 5/7] cache: Add L2 cache management for Andes AX45MP
 RISC-V core
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     Conor Dooley <conor@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Heiko Stuebner <heiko@sntech.de>, Guo Ren <guoren@kernel.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Samuel Holland <samuel@sholland.org>,
        linux-riscv@lists.infradead.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
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

Hi Conor,

On Thu, Apr 13, 2023 at 8:06=E2=80=AFAM Conor Dooley <conor.dooley@microchi=
p.com> wrote:
>
> On Wed, Apr 12, 2023 at 09:25:34PM +0100, Conor Dooley wrote:
> > On Wed, Apr 12, 2023 at 12:08:58PM +0100, Prabhakar wrote:
> > > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > >
> > > I/O Coherence Port (IOCP) provides an AXI interface for connecting
> > > external non-caching masters, such as DMA controllers. The accesses
> > > from IOCP are coherent with D-Caches and L2 Cache.
> > >
> > > IOCP is a specification option and is disabled on the Renesas RZ/Five
> > > SoC due to this reason IP blocks using DMA will fail.
> > >
> > > The Andes AX45MP core has a Programmable Physical Memory Attributes (=
PMA)
> > > block that allows dynamic adjustment of memory attributes in the runt=
ime.
> > > It contains a configurable amount of PMA entries implemented as CSR
> > > registers to control the attributes of memory locations in interest.
> > > Below are the memory attributes supported:
> > > * Device, Non-bufferable
> > > * Device, bufferable
> > > * Memory, Non-cacheable, Non-bufferable
> > > * Memory, Non-cacheable, Bufferable
> > > * Memory, Write-back, No-allocate
> > > * Memory, Write-back, Read-allocate
> > > * Memory, Write-back, Write-allocate
> > > * Memory, Write-back, Read and Write-allocate
> > >
> > > More info about PMA (section 10.3):
> > > Link: http://www.andestech.com/wp-content/uploads/AX45MP-1C-Rev.-5.0.=
0-Datasheet.pdf
> > >
> > > As a workaround for SoCs with IOCP disabled CMO needs to be handled b=
y
> > > software. Firstly OpenSBI configures the memory region as
> > > "Memory, Non-cacheable, Bufferable" and passes this region as a globa=
l
> > > shared dma pool as a DT node. With DMA_GLOBAL_POOL enabled all DMA
> > > allocations happen from this region and synchronization callbacks are
> > > implemented to synchronize when doing DMA transactions.
> > >
> > > Example PMA region passes as a DT node from OpenSBI:
> > >     reserved-memory {
> > >         #address-cells =3D <2>;
> > >         #size-cells =3D <2>;
> > >         ranges;
> > >
> > >         pma_resv0@58000000 {
> > >             compatible =3D "shared-dma-pool";
> > >             reg =3D <0x0 0x58000000 0x0 0x08000000>;
> > >             no-map;
> > >             linux,dma-default;
> > >         };
> > >     };
> > >
> > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com=
>
> > > ---
> > > v7 -> v8
> > > * Dropped function pointer usage
> > > * Now exporting the functions for clean/inval/flush
> > > * Switched to using early_initcall instead of arch_initcall
> > > * Dropped entry for "include/cache" from MAINTAINERS
> > > * Dropped dependency of RISCV on AX45MP_L2_CACHE
> > > * Returning error in case of cache line mismatch
> >
> > > * Renamed clean/inval/flush functions
> >
> > I kinda screwed you with that request given Hellwig's NAK on the
> > function pointer based stuff. Ah well, I prefer matching the proposed
> > naming of the dma core to what RVI chose for the instructions.
> >
> > Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> >
> > I suppose this will need a resubmission once Arnd's stuff gets applied,
> > but I would like to see it have a run through the build bots etc.
>
> So apparently my build bot did actually run against this series?
> https://patchwork.kernel.org/project/linux-riscv/list/?series=3D739109
>
> To be quite honest, I am not sure at all how it managed to apply the
> series w/ Arnd's pre-reqs. Perhaps it has achieved some from of
> sentience. There's a build failure for 32-bit that appeared on the final
> patch, but is not really its fault:
> ../arch/riscv/mm/dma-noncoherent.c: Assembler messages:
> ../arch/riscv/mm/dma-noncoherent.c:104: Error: unrecognized opcode `sd s0=
,0(sp)'
> ../arch/riscv/mm/dma-noncoherent.c:105: Error: unrecognized opcode `sd ra=
,8(sp)'
> ../arch/riscv/mm/dma-noncoherent.c:110: Error: unrecognized opcode `ld ra=
,8(sp)'
> ../arch/riscv/mm/dma-noncoherent.c:111: Error: unrecognized opcode `ld s0=
,0(sp)'
> ../arch/riscv/mm/dma-noncoherent.c:111: Error: unrecognized opcode `sd s0=
,0(sp)'
> ../arch/riscv/mm/dma-noncoherent.c:112: Error: unrecognized opcode `sd ra=
,8(sp)'
> ../arch/riscv/mm/dma-noncoherent.c:117: Error: unrecognized opcode `ld ra=
,8(sp)'
> ../arch/riscv/mm/dma-noncoherent.c:118: Error: unrecognized opcode `ld s0=
,0(sp)'
> ../arch/riscv/mm/pmem.c: Assembler messages:
> ../arch/riscv/mm/pmem.c:98: Error: unrecognized opcode `sd s0,0(sp)'
> ../arch/riscv/mm/pmem.c:99: Error: unrecognized opcode `sd ra,8(sp)'
> ../arch/riscv/mm/pmem.c:104: Error: unrecognized opcode `ld ra,8(sp)'
> ../arch/riscv/mm/pmem.c:105: Error: unrecognized opcode `ld s0,0(sp)'
> ../arch/riscv/mm/dma-noncoherent.c:138: Error: unrecognized opcode `sd s0=
,0(sp)'
> ../arch/riscv/mm/dma-noncoherent.c:139: Error: unrecognized opcode `sd ra=
,8(sp)'
> ../arch/riscv/mm/dma-noncoherent.c:144: Error: unrecognized opcode `ld ra=
,8(sp)'
> ../arch/riscv/mm/dma-noncoherent.c:145: Error: unrecognized opcode `ld s0=
,0(sp)'
> ../arch/riscv/mm/pmem.c:104: Error: unrecognized opcode `sd s0,0(sp)'
> ../arch/riscv/mm/pmem.c:105: Error: unrecognized opcode `sd ra,8(sp)'
> ../arch/riscv/mm/pmem.c:110: Error: unrecognized opcode `ld ra,8(sp)'
> ../arch/riscv/mm/pmem.c:111: Error: unrecognized opcode `ld s0,0(sp)'
> ../arch/riscv/mm/pmem.c:110: Error: attempt to move .org backwards
> ../arch/riscv/mm/pmem.c:116: Error: attempt to move .org backwards
> ../arch/riscv/mm/dma-noncoherent.c:116: Error: attempt to move .org backw=
ards
> ../arch/riscv/mm/dma-noncoherent.c:123: Error: attempt to move .org backw=
ards
> ../arch/riscv/mm/dma-noncoherent.c:150: Error: attempt to move .org backw=
ards
> make[4]: *** [../scripts/Makefile.build:252: arch/riscv/mm/pmem.o] Error =
1
> make[4]: *** [../scripts/Makefile.build:252: arch/riscv/mm/dma-noncoheren=
t.o] Error 1
> make[4]: Target 'arch/riscv/mm/' not remade because of errors.
> make[3]: *** [../scripts/Makefile.build:494: arch/riscv/mm] Error 2
> make[3]: Target 'arch/riscv/' not remade because of errors.
> make[2]: *** [../scripts/Makefile.build:494: arch/riscv] Error 2
>
> The simplest solution may to just be making the erratum depend on 64BIT?
>
I dont think this will work, as pmem.c is compiled unconditionally. Is
dma-noncoherent.c also valid for RISCV-32? If not then we can make
pmem.c compile conditionally if DMA non-coherenet is enabled and we
make DMA non-coherent depend on 64bit.

Cheers,
Prabhakar
