Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD09564D9FF
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 12:04:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbiLOLEI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 06:04:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiLOLEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 06:04:01 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC3A5C70;
        Thu, 15 Dec 2022 03:03:59 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id gh17so51421790ejb.6;
        Thu, 15 Dec 2022 03:03:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IrHHMckS5tYSu8+AYoyLYCoKhDvhyi54tbjA5XBjEkI=;
        b=ddAZks5HRV3j0wghseWDDkPC9o4HW3gGQwRs0UOlLsH16MGhuYKctbCVMSCcUcGjYd
         NwPTHwE/QwquaVzShXj20DBQdTYj4hivZ4ti2C5imDdo7NhSMiiuISlQWDpPxsL7WxlK
         EFQnHH9Ggpvzgx9M0LfEkOL46oEwzwEBFr7hoPys91JB/OoJ1iqfZJVZJQnhmfobBAkW
         T+nOo3W3YhI+0Xshb0rmCRpsCqTGpveif8Qtd5buxJ73dM1gYyr8MdGDpHwsFP+MMZAM
         cUFeFj27NOcmdaDUSVTwOaMUS1K0f3oxdexDJghpM59zpPJ+7wPFDwy19HEUDJmJynkW
         74TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IrHHMckS5tYSu8+AYoyLYCoKhDvhyi54tbjA5XBjEkI=;
        b=QEYnAfsutZ+vY5ZVqmRQs0rbsxlzHosY1wKDWlqRFNCLkXDgVov9YBkrdY1IpGF30L
         X4mfUCaXwzr/Rxwfxb7M/UPFdgZX2IB1SZVf+8MSyJ4YuRtw0RIrMv8qCArTJheqRdQj
         G7/yqEzJqmUVMj0Hh0ISNifT3+P2DOU+bSTlSVOTi4AIWCEh5bGxXt95xmAf7UqfM7u3
         /x1+/Ptq8d+RQePn4JLLVkO+gE+J/8FjGCYV6lWUi8sdKNRf5qaBppa5GF0gjOxn18Gj
         4iXB+1z2B8uXSoO0M28gBTLYi6V6Wf3wQt1ia8/mS1NgJKLB3n9U5Th40fgXsockYgEF
         SwIQ==
X-Gm-Message-State: ANoB5pl3ezsSBtCEuyyrcWzW6xi4RYHgEuATNVoszA2p3lXNjvMHwilH
        7PgG+s1KMN7JNbqBZUYTTfdEGA/YtB6PYZ0czCqT6R5yYWAozg==
X-Google-Smtp-Source: AA0mqf5rbUHMbEGzwbNAF3YodbSPH4k28G07lOZ4WJGgA2x70kivbP15GrFnRvST9t+UI1pfDn1dRDGCFhFu+qB7lcI=
X-Received: by 2002:a17:906:3e41:b0:78d:bc9f:33da with SMTP id
 t1-20020a1709063e4100b0078dbc9f33damr79654658eji.80.1671102238154; Thu, 15
 Dec 2022 03:03:58 -0800 (PST)
MIME-Version: 1.0
References: <20221212115505.36770-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20221212115505.36770-7-prabhakar.mahadev-lad.rj@bp.renesas.com> <CAMuHMdUCkCyLOXbQEJyc7S2F08=ftNtPcEztRN3JWJv_FPmAVw@mail.gmail.com>
In-Reply-To: <CAMuHMdUCkCyLOXbQEJyc7S2F08=ftNtPcEztRN3JWJv_FPmAVw@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Thu, 15 Dec 2022 11:03:31 +0000
Message-ID: <CA+V-a8vD=SOb6gPOwdPUE=kHeqa+oo2L-rbaW8zGjvw7YyQsqg@mail.gmail.com>
Subject: Re: [PATCH v5 6/6] soc: renesas: Add L2 cache management for RZ/Five SoC
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
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

On Thu, Dec 15, 2022 at 10:36 AM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
>
> Hi Prabhakar,
>
> On Mon, Dec 12, 2022 at 12:58 PM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > I/O Coherence Port (IOCP) provides an AXI interface for connecting
> > external non-caching masters, such as DMA controllers. The accesses
> > from IOCP are coherent with D-Caches and L2 Cache.
> >
> > IOCP is a specification option and is disabled on the Renesas RZ/Five
> > SoC due to this reason IP blocks using DMA will fail.
> >
> > The Andes AX45MP core has a Programmable Physical Memory Attributes (PMA)
> > block that allows dynamic adjustment of memory attributes in the runtime.
> > It contains a configurable amount of PMA entries implemented as CSR
> > registers to control the attributes of memory locations in interest.
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
> > More info about PMA (section 10.3):
> > Link: http://www.andestech.com/wp-content/uploads/AX45MP-1C-Rev.-5.0.0-Datasheet.pdf
> >
> > As a workaround for SoCs with IOCP disabled CMO needs to be handled by
> > software. Firstly OpenSBI configures the memory region as
> > "Memory, Non-cacheable, Bufferable" and passes this region as a global
> > shared dma pool as a DT node. With DMA_GLOBAL_POOL enabled all DMA
> > allocations happen from this region and synchronization callbacks are
> > implemented to synchronize when doing DMA transactions.
> >
> > Example PMA region passes as a DT node from OpenSBI:
> >     reserved-memory {
> >         #address-cells = <2>;
> >         #size-cells = <2>;
> >         ranges;
> >
> >         pma_resv0@58000000 {
> >             compatible = "shared-dma-pool";
> >             reg = <0x0 0x58000000 0x0 0x08000000>;
> >             no-map;
> >             linux,dma-default;
> >         };
> >     };
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Thanks for your patch!
>
> >  arch/riscv/include/asm/cacheflush.h       |   8 +
> >  arch/riscv/include/asm/errata_list.h      |  28 ++-
> >  drivers/soc/renesas/Kconfig               |   6 +
> >  drivers/soc/renesas/Makefile              |   2 +
> >  drivers/soc/renesas/rzfive/Kconfig        |   6 +
> >  drivers/soc/renesas/rzfive/Makefile       |   3 +
> >  drivers/soc/renesas/rzfive/ax45mp_cache.c | 256 ++++++++++++++++++++++
>
> Given this touches arch/riscv/include/asm/, I don't think the
> code belongs under drivers/soc/renesas/.
>
Ok. Do you have any suggestions on where you want me to put this code?

Cheers,
Prabhakar
