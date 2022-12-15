Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 882D664DA25
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 12:17:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbiLOLRp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 06:17:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbiLOLRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 06:17:41 -0500
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94ECF9FD1;
        Thu, 15 Dec 2022 03:17:40 -0800 (PST)
Received: by mail-ot1-f53.google.com with SMTP id i26-20020a9d68da000000b00672301a1664so2638432oto.6;
        Thu, 15 Dec 2022 03:17:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Si7SDKWic3Uv1+g6HsphPYpn2S25iGUgPbeTE6s5eQM=;
        b=H2FbJBbxljz6aoCrgTON7mU/ReP5WB6JcDj89uGYVmAXQ9RPvXYNXLhue1ZrIjjqjq
         R9dYtEeSQ/qIqLGCGhRbBMgphHfLpgsPbZY2G/NvwGbQ+g7wnT4QzCNvyxFfQGl5IcT6
         GHTYfuA6ecCPBNPL92SK4INbh3cZjhnKv6nSjKZ7+d6S37dkkIybAM5XKwYi3cuDGsH1
         8du1D1N9/xJIZQ1q9386ClupyTZeb49mZYIC+wyo5Rgb+98HYczx0W6V+voCWK7L8hjF
         3szTTr3qRcuOlwhBXsG4oGh+hOYBOyWlEgtgqNf7Na/UrSHbSL/70DyRaOV6WA7ImLFw
         lyrA==
X-Gm-Message-State: ANoB5pmhYGqU6ES2Jb3ttDLg2804Fq51PpzTM8Z9754u6gJk8It/N1u/
        ZR4nRjt6TjQCleWd9MssbUT76HOqnxIg4Q==
X-Google-Smtp-Source: AA0mqf6tZZodQYcvnzPRX8GqwUwNK83yiyk+q7u8LSaUjOmcBMzU/l4lF7sqXDoMzsI0gmbGcN//JA==
X-Received: by 2002:a05:6830:2701:b0:671:70ce:4199 with SMTP id j1-20020a056830270100b0067170ce4199mr6615926otu.2.1671103059673;
        Thu, 15 Dec 2022 03:17:39 -0800 (PST)
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com. [209.85.210.41])
        by smtp.gmail.com with ESMTPSA id v18-20020a9d5a12000000b0066f7e1188f0sm3307043oth.68.2022.12.15.03.17.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Dec 2022 03:17:39 -0800 (PST)
Received: by mail-ot1-f41.google.com with SMTP id db10-20020a0568306b0a00b0066d43e80118so3394210otb.1;
        Thu, 15 Dec 2022 03:17:39 -0800 (PST)
X-Received: by 2002:a0d:cb4c:0:b0:38e:e541:d8ca with SMTP id
 n73-20020a0dcb4c000000b0038ee541d8camr23940870ywd.283.1671102643962; Thu, 15
 Dec 2022 03:10:43 -0800 (PST)
MIME-Version: 1.0
References: <20221212115505.36770-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20221212115505.36770-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAMuHMdUCkCyLOXbQEJyc7S2F08=ftNtPcEztRN3JWJv_FPmAVw@mail.gmail.com> <CA+V-a8vD=SOb6gPOwdPUE=kHeqa+oo2L-rbaW8zGjvw7YyQsqg@mail.gmail.com>
In-Reply-To: <CA+V-a8vD=SOb6gPOwdPUE=kHeqa+oo2L-rbaW8zGjvw7YyQsqg@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 15 Dec 2022 12:10:32 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWX4Yd52=Jv8kABtn+1B1V=dC2iXVZ81gNZBWNu4hb_3w@mail.gmail.com>
Message-ID: <CAMuHMdWX4Yd52=Jv8kABtn+1B1V=dC2iXVZ81gNZBWNu4hb_3w@mail.gmail.com>
Subject: Re: [PATCH v5 6/6] soc: renesas: Add L2 cache management for RZ/Five SoC
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
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
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prabhakar,

On Thu, Dec 15, 2022 at 12:06 PM Lad, Prabhakar
<prabhakar.csengg@gmail.com> wrote:
> On Thu, Dec 15, 2022 at 10:36 AM Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
> > On Mon, Dec 12, 2022 at 12:58 PM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> > > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > >
> > > I/O Coherence Port (IOCP) provides an AXI interface for connecting
> > > external non-caching masters, such as DMA controllers. The accesses
> > > from IOCP are coherent with D-Caches and L2 Cache.
> > >
> > > IOCP is a specification option and is disabled on the Renesas RZ/Five
> > > SoC due to this reason IP blocks using DMA will fail.
> > >
> > > The Andes AX45MP core has a Programmable Physical Memory Attributes (PMA)
> > > block that allows dynamic adjustment of memory attributes in the runtime.
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
> > > Link: http://www.andestech.com/wp-content/uploads/AX45MP-1C-Rev.-5.0.0-Datasheet.pdf
> > >
> > > As a workaround for SoCs with IOCP disabled CMO needs to be handled by
> > > software. Firstly OpenSBI configures the memory region as
> > > "Memory, Non-cacheable, Bufferable" and passes this region as a global
> > > shared dma pool as a DT node. With DMA_GLOBAL_POOL enabled all DMA
> > > allocations happen from this region and synchronization callbacks are
> > > implemented to synchronize when doing DMA transactions.
> > >
> > > Example PMA region passes as a DT node from OpenSBI:
> > >     reserved-memory {
> > >         #address-cells = <2>;
> > >         #size-cells = <2>;
> > >         ranges;
> > >
> > >         pma_resv0@58000000 {
> > >             compatible = "shared-dma-pool";
> > >             reg = <0x0 0x58000000 0x0 0x08000000>;
> > >             no-map;
> > >             linux,dma-default;
> > >         };
> > >     };
> > >
> > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > Thanks for your patch!
> >
> > >  arch/riscv/include/asm/cacheflush.h       |   8 +
> > >  arch/riscv/include/asm/errata_list.h      |  28 ++-
> > >  drivers/soc/renesas/Kconfig               |   6 +
> > >  drivers/soc/renesas/Makefile              |   2 +
> > >  drivers/soc/renesas/rzfive/Kconfig        |   6 +
> > >  drivers/soc/renesas/rzfive/Makefile       |   3 +
> > >  drivers/soc/renesas/rzfive/ax45mp_cache.c | 256 ++++++++++++++++++++++
> >
> > Given this touches arch/riscv/include/asm/, I don't think the
> > code belongs under drivers/soc/renesas/.
> >
> Ok. Do you have any suggestions on where you want me to put this code?

As it plugs into core riscv functionality, I think it should be under
arch/riscv/.

if the RISC-V maintainers object to that, another option is
drivers/soc/andestech/ or (new) drivers/cache/

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
