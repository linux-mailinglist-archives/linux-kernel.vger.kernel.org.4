Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF50464E35D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 22:40:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbiLOVki (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 16:40:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiLOVkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 16:40:36 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27F1A5C0CA
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 13:40:31 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id w23so324189ply.12
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 13:40:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6UhQMoGzyPQoO6coVT0IwbZp+PXxQ7bh8ldQshrXNrk=;
        b=nd6useCy5mDi1KHbA55vHEOJhr8iFu/8qita2tBOeSNjQjOpoh4/MhEQwviPyefNV9
         AoM5k+Qd2OHhBKM8/hfxqyDcpN4coUzO1cAugUeg96yeY6T0aUfm1YB/41Ja6ohk9pm0
         vQ1xJt7kLNMRZVaYZatkh14ui8sBry5Uhfamnhts+rG1b39opgFI6iaOXMzdO9WKlMH3
         w/EwVoaaV5g4c4aZ8ZeE2+pzQy3D61l9pAuyN3dd368yYlq8WkD60l28/Lk8R4IQ0XpR
         ILzFn6+dDOHXUOrbR/cWXQkJ6lJpXvl0IhkTeHZC1gNmexkLi0+WO+GvC4KChLTpr10G
         0m9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6UhQMoGzyPQoO6coVT0IwbZp+PXxQ7bh8ldQshrXNrk=;
        b=nqzjVpT8FST/xp9+Uev30O1JGeIfJHipbxuE28g8CSgb0hb3+Oi6C6dnv1HbX/8hNd
         JyJoj5bXSvmLQre3IsgB86sTFRFH4tcDAEwf+5p6UC4Sx1wrU7jD7LnAGiuoKoZJob2G
         oifVgtyNsQO6ObRIXLPcLQAJjHJ00ZJExai40HhFlHdbBu9uUJMsTpuqiTH/tpy7Ob15
         Eqy8biFq1TP8OexyXW4c9GgaevTOBIqLdjUEA6JJQCCcd7VyuDYx1IMb6H1kFXEVVR7S
         DVC92kSG6szb9eaTjN8R65liPMvt2s/bSxrcwkCOqk5rdkb/WjJe2uGX2UKf0svd4MQY
         FAEA==
X-Gm-Message-State: ANoB5pkL0ng9dsWd2pWlSXWOYPyAyAmsLN/iT0xlTUzp3JXJ283/MXRk
        tx7BqF1j1Zch1C8CC0VCaeevjw==
X-Google-Smtp-Source: AA0mqf5MBUVcNkahTznoohWrAxg1q+3XZ47h2BCnANLg0HowcpfjH7uuG719LdG576kqb0KUKSlDyQ==
X-Received: by 2002:a17:90a:cf16:b0:219:861a:ac10 with SMTP id h22-20020a17090acf1600b00219861aac10mr30270560pju.6.1671140430425;
        Thu, 15 Dec 2022 13:40:30 -0800 (PST)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id y1-20020a17090a474100b00218ae9916c4sm3542617pjg.35.2022.12.15.13.40.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Dec 2022 13:40:30 -0800 (PST)
Date:   Thu, 15 Dec 2022 13:40:30 -0800 (PST)
X-Google-Original-Date: Thu, 15 Dec 2022 13:40:09 PST (-0800)
Subject:     Re: [PATCH v5 6/6] soc: renesas: Add L2 cache management for RZ/Five SoC
In-Reply-To: <CAMuHMdUO7iFvh73u+m=EXYyxyePXHahJ=OVwQHdt0ap4vWDG4A@mail.gmail.com>
CC:     Conor Dooley <conor@kernel.org>, prabhakar.csengg@gmail.com,
        Arnd Bergmann <arnd@arndb.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, magnus.damm@gmail.com, heiko@sntech.de,
        Conor Dooley <conor.dooley@microchip.com>, samuel@sholland.org,
        guoren@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, jszhang@kernel.org,
        Atish Patra <atishp@rivosinc.com>, apatel@ventanamicro.com,
        ajones@ventanamicro.com, nathan@kernel.org,
        philipp.tomsich@vrull.eu, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org, biju.das.jz@bp.renesas.com,
        prabhakar.mahadev-lad.rj@bp.renesas.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     geert@linux-m68k.org, Christoph Hellwig <hch@infradead.org>,
        soc@kernel.org
Message-ID: <mhng-6160c058-408a-4ff5-8a7d-4fb2886d3d95@palmer-ri-x1c9a>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Dec 2022 12:17:38 PST (-0800), geert@linux-m68k.org wrote:
> Hi Conor,
>
> On Thu, Dec 15, 2022 at 8:54 PM Conor Dooley <conor@kernel.org> wrote:
>> On Thu, Dec 15, 2022 at 05:46:42PM +0000, Lad, Prabhakar wrote:
>> > On Thu, Dec 15, 2022 at 11:10 AM Geert Uytterhoeven
>> > <geert@linux-m68k.org> wrote:
>> > > On Thu, Dec 15, 2022 at 12:06 PM Lad, Prabhakar
>> > > <prabhakar.csengg@gmail.com> wrote:
>> > > > On Thu, Dec 15, 2022 at 10:36 AM Geert Uytterhoeven
>> > > > <geert@linux-m68k.org> wrote:
>> > > > > On Mon, Dec 12, 2022 at 12:58 PM Prabhakar <prabhakar.csengg@gmail.com> wrote:
>> > > > > > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>> > > > > >
>> > > > > > I/O Coherence Port (IOCP) provides an AXI interface for connecting
>> > > > > > external non-caching masters, such as DMA controllers. The accesses
>> > > > > > from IOCP are coherent with D-Caches and L2 Cache.
>> > > > > >
>> > > > > > IOCP is a specification option and is disabled on the Renesas RZ/Five
>> > > > > > SoC due to this reason IP blocks using DMA will fail.
>> > > > > >
>> > > > > > The Andes AX45MP core has a Programmable Physical Memory Attributes (PMA)
>> > > > > > block that allows dynamic adjustment of memory attributes in the runtime.
>> > > > > > It contains a configurable amount of PMA entries implemented as CSR
>> > > > > > registers to control the attributes of memory locations in interest.
>> > > > > > Below are the memory attributes supported:
>> > > > > > * Device, Non-bufferable
>> > > > > > * Device, bufferable
>> > > > > > * Memory, Non-cacheable, Non-bufferable
>> > > > > > * Memory, Non-cacheable, Bufferable
>> > > > > > * Memory, Write-back, No-allocate
>> > > > > > * Memory, Write-back, Read-allocate
>> > > > > > * Memory, Write-back, Write-allocate
>> > > > > > * Memory, Write-back, Read and Write-allocate
>> > > > > >
>> > > > > > More info about PMA (section 10.3):
>> > > > > > Link: http://www.andestech.com/wp-content/uploads/AX45MP-1C-Rev.-5.0.0-Datasheet.pdf
>> > > > > >
>> > > > > > As a workaround for SoCs with IOCP disabled CMO needs to be handled by
>> > > > > > software. Firstly OpenSBI configures the memory region as
>> > > > > > "Memory, Non-cacheable, Bufferable" and passes this region as a global
>> > > > > > shared dma pool as a DT node. With DMA_GLOBAL_POOL enabled all DMA
>> > > > > > allocations happen from this region and synchronization callbacks are
>> > > > > > implemented to synchronize when doing DMA transactions.
>> > > > > >
>> > > > > > Example PMA region passes as a DT node from OpenSBI:
>> > > > > >     reserved-memory {
>> > > > > >         #address-cells = <2>;
>> > > > > >         #size-cells = <2>;
>> > > > > >         ranges;
>> > > > > >
>> > > > > >         pma_resv0@58000000 {
>> > > > > >             compatible = "shared-dma-pool";
>> > > > > >             reg = <0x0 0x58000000 0x0 0x08000000>;
>> > > > > >             no-map;
>> > > > > >             linux,dma-default;
>> > > > > >         };
>> > > > > >     };
>> > > > > >
>> > > > > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>> > > > >
>> > > > > Thanks for your patch!
>> > > > >
>> > > > > >  arch/riscv/include/asm/cacheflush.h       |   8 +
>> > > > > >  arch/riscv/include/asm/errata_list.h      |  28 ++-
>> > > > > >  drivers/soc/renesas/Kconfig               |   6 +
>> > > > > >  drivers/soc/renesas/Makefile              |   2 +
>> > > > > >  drivers/soc/renesas/rzfive/Kconfig        |   6 +
>> > > > > >  drivers/soc/renesas/rzfive/Makefile       |   3 +
>> > > > > >  drivers/soc/renesas/rzfive/ax45mp_cache.c | 256 ++++++++++++++++++++++
>> > > > >
>> > > > > Given this touches arch/riscv/include/asm/, I don't think the
>> > > > > code belongs under drivers/soc/renesas/.
>> > > > >
>> > > > Ok. Do you have any suggestions on where you want me to put this code?
>> > >
>> > > As it plugs into core riscv functionality, I think it should be under
>> > > arch/riscv/.
>> > > if the RISC-V maintainers object to that, another option is
>> > > drivers/soc/andestech/ or (new) drivers/cache/
>> > >
>> > RISC-V maintainers had already made it clear to not to include vendor
>> > specific stuff in the arch/riscv folder, so I'll consider putting this

We have vendor-specific behavior in arch/riscv now, and it's even in the 
policies (the behavior has been there for a while, the policy is new).  
There's probably a bunch of posts saying otherwise because we used to 
not take vendor-specific behavior, but that's not the case any more.

>> > into drivers/cache/ folder to sync with the bindings.
>> >
>> > Conor/Palmer - do you have any objections/suggestions?
>>
>> I'm not its maintainer so sorta moot what I say, but having drivers in
>> arch/riscv makes little sense to me..

Some drivers are pretty tightly coupled to an ISA, I'm thinking of 
things like interrupts/timers where we're writing CSRs.  I could see how 
cache controllers would fall into that category, doubly so as they get 
integrated to the memory model.  That leaves us in sort of a grey area 
and there's certainly ports that have way more drivers in arch so it's 
not an uncommon way to do things.

I generally lean pretty heavily towards keeping things that could at all 
be considered out of arch/riscv and instead have them in some sort of 
driver folder.  That probably results in more total work to do, as we've 
got to have arch/riscv interfaces with one use case and sync up between 
multiple trees sometimes to get stuff merged.  I think it also results 
in better code: being closer to the other drivers makes us more likely 
to get reviewed by folks who understand the space, and it's generally 
easier to share code in the subsystems.

>> Putting stuff in drivers/cache does sound like a good idea since the
>> binding is going there too.
>>
>> The SiFive ccache driver is in drivers/soc and it was suggested to me
>> this week that there's likely going to be a second SiFive cache driver
>> at some point in the near future. Plus Microchip are going to have to
>> add cache management stuff to the existing SiFive ccache driver.
>> Having them be their own thing makes sense in my mind - especially since
>> they're not tied to SoCs sold by Andes or SiFive.
>>
>> I had a quick, and I mean *quick* look through other soc drivers to see
>> if there were any other cache controller drivers but nothing stood out
>> to me. Maybe someone else has more of a clue there. Ditto for misc, had
>> a look but nothing seemed obvious.
>
> Usually they're under arch/:
> $ git ls-files -- "arch/*cache*" | wc -l
> 148
> $ git ls-files -- "drivers/*cache*" | wc -l
> 63
>
> E.g. arch/arm/mm/cache-l2x0.c.

Above all I like to do things as normally as possible, so if most cache 
drivers are in arch then I'm OK with.  Looks like we originally had it 
arch/riscv, though, until 9209fb51896f ("riscv: move sifive_l2_cache.c 
to drivers/soc") moved it out.

I don't really remember this history/rationale here, at the time the 
SiFive cache driver wasn't really doing anything all that exciting: it 
was just way enable and some statistics, we hadn't really planned on 
using it for the non-coherent stuff that folks are now trying to 
retrofit it to handle.  That sort of thing makes it a lot more coupled 
to the ISA.

Given that we already moved the SiFive one out it seems sane to just 
start with the rest in drivers/soc/$VENDOR.  Looks like it was 
Christoph's idea to do the move, so I'm adding him in case he's got an 
opinion (and also the SOC alias, as that seems generally relevant).

> Gr{oetje,eeting}s,
>
>                         Geert
