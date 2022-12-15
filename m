Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1A2864E24C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 21:25:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbiLOUZQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 15:25:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbiLOUZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 15:25:13 -0500
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1ED927DF8;
        Thu, 15 Dec 2022 12:25:11 -0800 (PST)
Received: by mail-vs1-f42.google.com with SMTP id m2so265928vsv.9;
        Thu, 15 Dec 2022 12:25:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xFcVrVAqulMBWI2FmRENAbk4zXBaJf2e4v4n13B3Zg0=;
        b=hAYfkqKZ+LeMkvrInW0TbHL6CpXluCBfIQcAZQdCMgi9QZe4BIOGlOkMGdR77GeX/s
         YxsfMdsVcgOYf8jKNNS4rA9KNztl6GhlLJBfSGqQDlN8YOLe0D4yI5LqCThDsprBTYcn
         TXZJ7tdzRbiMN6OwkxvCRjkW+NbbvkBFJzmm4V6CLLT+4APZj5hcVkks6vxi+A7ieX5v
         /XGxjZt2FZyEGXDvE7uLlLFDvgPuLN75sr9CPu+4ocIadZTRdaSStVJ5n1gpng4LjyZ4
         njj1CPKM2G4LTKiNk9ObgigD44GHM96IXDiJcqF3/W6OwyElBTZUHbiHZFWR0WKF0SJv
         nSvw==
X-Gm-Message-State: ANoB5pkAN/vDZvxQzq0t75wokZAwOBVUh5Xk3CLDsJND99FedEgJ6QlN
        vGUZQz+x1v8kmz0lPKhS9fR3fsKjd0n+Gg==
X-Google-Smtp-Source: AA0mqf4Z+ReVzvYAq0I7wXqKn6x4b7+yzcLoa3uAk5pDa/sIBUrxwoB5nSlUi4ZQYmuWMV1/A9qnCw==
X-Received: by 2002:a67:fdd2:0:b0:3b0:6ab0:647 with SMTP id l18-20020a67fdd2000000b003b06ab00647mr17676017vsq.16.1671135910628;
        Thu, 15 Dec 2022 12:25:10 -0800 (PST)
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com. [209.85.219.178])
        by smtp.gmail.com with ESMTPSA id i22-20020a05620a075600b006bb82221013sm12466605qki.0.2022.12.15.12.25.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Dec 2022 12:25:10 -0800 (PST)
Received: by mail-yb1-f178.google.com with SMTP id i186so93794ybc.9;
        Thu, 15 Dec 2022 12:25:10 -0800 (PST)
X-Received: by 2002:a81:4e09:0:b0:370:202b:f085 with SMTP id
 c9-20020a814e09000000b00370202bf085mr27077203ywb.502.1671135469671; Thu, 15
 Dec 2022 12:17:49 -0800 (PST)
MIME-Version: 1.0
References: <20221212115505.36770-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20221212115505.36770-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAMuHMdUCkCyLOXbQEJyc7S2F08=ftNtPcEztRN3JWJv_FPmAVw@mail.gmail.com>
 <CA+V-a8vD=SOb6gPOwdPUE=kHeqa+oo2L-rbaW8zGjvw7YyQsqg@mail.gmail.com>
 <CAMuHMdWX4Yd52=Jv8kABtn+1B1V=dC2iXVZ81gNZBWNu4hb_3w@mail.gmail.com>
 <CA+V-a8t3+zzQ4yPftsAa51rkMGHr45NhMO4_2WmZ9BGg0wuQvw@mail.gmail.com> <Y5t7a2oZ64McjSSn@dizzy>
In-Reply-To: <Y5t7a2oZ64McjSSn@dizzy>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 15 Dec 2022 21:17:38 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUO7iFvh73u+m=EXYyxyePXHahJ=OVwQHdt0ap4vWDG4A@mail.gmail.com>
Message-ID: <CAMuHMdUO7iFvh73u+m=EXYyxyePXHahJ=OVwQHdt0ap4vWDG4A@mail.gmail.com>
Subject: Re: [PATCH v5 6/6] soc: renesas: Add L2 cache management for RZ/Five SoC
To:     Conor Dooley <conor@kernel.org>
Cc:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>, palmer@dabbelt.com,
        Arnd Bergmann <arnd@arndb.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
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
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Conor,

On Thu, Dec 15, 2022 at 8:54 PM Conor Dooley <conor@kernel.org> wrote:
> On Thu, Dec 15, 2022 at 05:46:42PM +0000, Lad, Prabhakar wrote:
> > On Thu, Dec 15, 2022 at 11:10 AM Geert Uytterhoeven
> > <geert@linux-m68k.org> wrote:
> > > On Thu, Dec 15, 2022 at 12:06 PM Lad, Prabhakar
> > > <prabhakar.csengg@gmail.com> wrote:
> > > > On Thu, Dec 15, 2022 at 10:36 AM Geert Uytterhoeven
> > > > <geert@linux-m68k.org> wrote:
> > > > > On Mon, Dec 12, 2022 at 12:58 PM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> > > > > > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > > > >
> > > > > > I/O Coherence Port (IOCP) provides an AXI interface for connecting
> > > > > > external non-caching masters, such as DMA controllers. The accesses
> > > > > > from IOCP are coherent with D-Caches and L2 Cache.
> > > > > >
> > > > > > IOCP is a specification option and is disabled on the Renesas RZ/Five
> > > > > > SoC due to this reason IP blocks using DMA will fail.
> > > > > >
> > > > > > The Andes AX45MP core has a Programmable Physical Memory Attributes (PMA)
> > > > > > block that allows dynamic adjustment of memory attributes in the runtime.
> > > > > > It contains a configurable amount of PMA entries implemented as CSR
> > > > > > registers to control the attributes of memory locations in interest.
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
> > > > > > More info about PMA (section 10.3):
> > > > > > Link: http://www.andestech.com/wp-content/uploads/AX45MP-1C-Rev.-5.0.0-Datasheet.pdf
> > > > > >
> > > > > > As a workaround for SoCs with IOCP disabled CMO needs to be handled by
> > > > > > software. Firstly OpenSBI configures the memory region as
> > > > > > "Memory, Non-cacheable, Bufferable" and passes this region as a global
> > > > > > shared dma pool as a DT node. With DMA_GLOBAL_POOL enabled all DMA
> > > > > > allocations happen from this region and synchronization callbacks are
> > > > > > implemented to synchronize when doing DMA transactions.
> > > > > >
> > > > > > Example PMA region passes as a DT node from OpenSBI:
> > > > > >     reserved-memory {
> > > > > >         #address-cells = <2>;
> > > > > >         #size-cells = <2>;
> > > > > >         ranges;
> > > > > >
> > > > > >         pma_resv0@58000000 {
> > > > > >             compatible = "shared-dma-pool";
> > > > > >             reg = <0x0 0x58000000 0x0 0x08000000>;
> > > > > >             no-map;
> > > > > >             linux,dma-default;
> > > > > >         };
> > > > > >     };
> > > > > >
> > > > > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > > >
> > > > > Thanks for your patch!
> > > > >
> > > > > >  arch/riscv/include/asm/cacheflush.h       |   8 +
> > > > > >  arch/riscv/include/asm/errata_list.h      |  28 ++-
> > > > > >  drivers/soc/renesas/Kconfig               |   6 +
> > > > > >  drivers/soc/renesas/Makefile              |   2 +
> > > > > >  drivers/soc/renesas/rzfive/Kconfig        |   6 +
> > > > > >  drivers/soc/renesas/rzfive/Makefile       |   3 +
> > > > > >  drivers/soc/renesas/rzfive/ax45mp_cache.c | 256 ++++++++++++++++++++++
> > > > >
> > > > > Given this touches arch/riscv/include/asm/, I don't think the
> > > > > code belongs under drivers/soc/renesas/.
> > > > >
> > > > Ok. Do you have any suggestions on where you want me to put this code?
> > >
> > > As it plugs into core riscv functionality, I think it should be under
> > > arch/riscv/.
> > > if the RISC-V maintainers object to that, another option is
> > > drivers/soc/andestech/ or (new) drivers/cache/
> > >
> > RISC-V maintainers had already made it clear to not to include vendor
> > specific stuff in the arch/riscv folder, so I'll consider putting this
> > into drivers/cache/ folder to sync with the bindings.
> >
> > Conor/Palmer - do you have any objections/suggestions?
>
> I'm not its maintainer so sorta moot what I say, but having drivers in
> arch/riscv makes little sense to me..
> Putting stuff in drivers/cache does sound like a good idea since the
> binding is going there too.
>
> The SiFive ccache driver is in drivers/soc and it was suggested to me
> this week that there's likely going to be a second SiFive cache driver
> at some point in the near future. Plus Microchip are going to have to
> add cache management stuff to the existing SiFive ccache driver.
> Having them be their own thing makes sense in my mind - especially since
> they're not tied to SoCs sold by Andes or SiFive.
>
> I had a quick, and I mean *quick* look through other soc drivers to see
> if there were any other cache controller drivers but nothing stood out
> to me. Maybe someone else has more of a clue there. Ditto for misc, had
> a look but nothing seemed obvious.

Usually they're under arch/:
$ git ls-files -- "arch/*cache*" | wc -l
148
$ git ls-files -- "drivers/*cache*" | wc -l
63

E.g. arch/arm/mm/cache-l2x0.c.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
