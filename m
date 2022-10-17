Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63B9F600B19
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 11:40:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231375AbiJQJka (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 05:40:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231167AbiJQJk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 05:40:27 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2938A2DAAC;
        Mon, 17 Oct 2022 02:40:10 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id b12so15186417edd.6;
        Mon, 17 Oct 2022 02:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=D9HhQ7pk1CiL4VTPPI0IOVIqN5ycd3jGOHfwvcwz8MI=;
        b=BILgPVkPxGxHQs3e1GlbA4L65k6WOqlkpf+xmofVUAPI4QGXJ4H8i+dmUW3LP6Gu+X
         c9qsMv09Ajjo8mtsYvCEjWl7MUKR8CxHmEX7BMBv1ddkQMt5JOBLkjSiL4mAGKcIyoKy
         GUljw3JlvKOA1XcThhNDJs7tZwFwAhzRl4JSxftL8bUXyLSOPA8lVIU7L6jQNWd7KhhI
         oITBDn1RIN/E5IghRrSHQr5fRQSckRjwlde/ijk8tV9dyg+Jkc4CD10ls/KBdTW9mh6M
         o57JiynnyY5Hqki3d4nIc89jN0dCK++oFb73wFD076UWQGV5BHlruHUtYs7HZccCmDiS
         2tiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D9HhQ7pk1CiL4VTPPI0IOVIqN5ycd3jGOHfwvcwz8MI=;
        b=Q1e7YuCNJvbQm4wGrOtrIfEEDLrOlExZh85aEdzVEEIzNK5DVJUk5i7qN6WssnAe4v
         TZlIxJPlfPXT5goVGtEwlFdBDCvvHMRY0yMykGk51deaNy9sFeydO1Ad4OJX55xx4x3W
         C0jXHUjdu0QKkAAL2IBpGuZZvcHdAMcN5e9jQTW074b0L6zLr9wA5JRnBPYNFbAJm79k
         bN4Cn/GnvlH9VqCVyIIT2O/aohoIJPePd1rt03f7DD0jiGx49eu45xu48vQzgB3Okqyo
         Kn1DNp9UnlQmB2CIm8dqqMQNgDMUyILNt9+8oBao2wOXTuPlHEjnkmsD3fC2YPoe4Svq
         PU/A==
X-Gm-Message-State: ACrzQf0oCPlWA5KXrow3e2BxDDnnMCNL2azWkMzZ0fyObRWX9ZRcfJhL
        nHqzSsyOMMUtkOsoQFfL3/OOlAdnsYAcMInPhTU=
X-Google-Smtp-Source: AMsMyM6ypfdjP7Luh70tcJQ0ZBKWiZDzJc2tizuFWNKFdUU1mi6axvOqzub6x8zQBgfblLLitzvFZjB7/ImSTs/EQ7o=
X-Received: by 2002:a05:6402:1393:b0:457:ea9e:ba20 with SMTP id
 b19-20020a056402139300b00457ea9eba20mr9604687edv.109.1665999608956; Mon, 17
 Oct 2022 02:40:08 -0700 (PDT)
MIME-Version: 1.0
References: <20221003223222.448551-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20221003223222.448551-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAJF2gTQuSX9idEyNmGRwpAsSP8V=+QKQ7UAp28T-seM8rbkwOA@mail.gmail.com>
 <CA+V-a8smkDmQbz76sTA5XfUm7bkY4Ee-L5xYW+-xRWkE1TYiAw@mail.gmail.com>
 <CAJF2gTQ4G-j3p_pHvVQ82R2DFQZq70xgE3ZhoRkxiSzrHnU2og@mail.gmail.com>
 <CA+V-a8tLYT0541FNo_o-sTsV7ywwnGTRtv6ropVu+0Wd-PsM6A@mail.gmail.com>
 <CAJF2gTQ9N5tyYB46eaMJ=Z0V7pm9TxFAXQ1qxLXLqj2C9zP2Ng@mail.gmail.com>
 <CA+V-a8sTQzbXC6j4+fNAYiM7_zciPaxb=uOzD9iWrvLwUBgDqA@mail.gmail.com> <CAJF2gTQnQSCwGAzXPENrCz2Uwf8WivYsRP57XGoCtywxE2_bZA@mail.gmail.com>
In-Reply-To: <CAJF2gTQnQSCwGAzXPENrCz2Uwf8WivYsRP57XGoCtywxE2_bZA@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Mon, 17 Oct 2022 10:39:41 +0100
Message-ID: <CA+V-a8u_e31uW9=ZutAkZbfF9yj7XzPcjwqjN2A=kMw91dKyhA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 2/2] soc: renesas: Add L2 cache management for
 RZ/Five SoC
To:     Guo Ren <guoren@kernel.org>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Conor Dooley <conor.dooley@microchip.com>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        Nathan Chancellor <nathan@kernel.org>,
        Atish Patra <atishp@rivosinc.com>,
        Anup Patel <apatel@ventanamicro.com>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
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

Hi Guo,

On Tue, Oct 11, 2022 at 2:10 PM Guo Ren <guoren@kernel.org> wrote:
>
> On Tue, Oct 11, 2022 at 5:39 PM Lad, Prabhakar
> <prabhakar.csengg@gmail.com> wrote:
> >
> > Hi Guo,
> >
> > On Thu, Oct 6, 2022 at 1:59 AM Guo Ren <guoren@kernel.org> wrote:
> > >
> > > On Wed, Oct 5, 2022 at 11:03 PM Lad, Prabhakar
> > > <prabhakar.csengg@gmail.com> wrote:
> > > >
> > > > Hi Guo,
> > > >
> > > > On Wed, Oct 5, 2022 at 3:23 PM Guo Ren <guoren@kernel.org> wrote:
> > > > >
> > > > > On Wed, Oct 5, 2022 at 8:54 PM Lad, Prabhakar
> > > > > <prabhakar.csengg@gmail.com> wrote:
> > > > > >
> > > > > > Hi Guo,
> > > > > >
> > > > > > On Wed, Oct 5, 2022 at 2:29 AM Guo Ren <guoren@kernel.org> wrote:
> > > > > > >
> > > > > > > On Tue, Oct 4, 2022 at 6:32 AM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> > > > > > > >
> > > > > > > > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > > > > > >
> > > > > > > > On the AX45MP core, cache coherency is a specification option so it may
> > > > > > > > not be supported. In this case DMA will fail. As a workaround, firstly we
> > > > > > > > allocate a global dma coherent pool from which DMA allocations are taken
> > > > > > > > and marked as non-cacheable + bufferable using the PMA region as specified
> > > > > > > > in the device tree. Synchronization callbacks are implemented to
> > > > > > > > synchronize when doing DMA transactions.
> > > > > > > >
> > > > > > > > The Andes AX45MP core has a Programmable Physical Memory Attributes (PMA)
> > > > > > > > block that allows dynamic adjustment of memory attributes in the runtime.
> > > > > > > > It contains a configurable amount of PMA entries implemented as CSR
> > > > > > > > registers to control the attributes of memory locations in interest.
> > > > > > > >
> > > > > > > > Below are the memory attributes supported:
> > > > > > > > * Device, Non-bufferable
> > > > > > > > * Device, bufferable
> > > > > > > > * Memory, Non-cacheable, Non-bufferable
> > > > > > > > * Memory, Non-cacheable, Bufferable
> > > > > > > > * Memory, Write-back, No-allocate
> > > > > > > > * Memory, Write-back, Read-allocate
> > > > > > > > * Memory, Write-back, Write-allocate
> > > > > > > > * Memory, Write-back, Read and Write-allocate
> > > > > > > Seems Svpbmt's PMA, IO, and NC wouldn't fit your requirements, could
> > > > > > > give a map list of the types of Svpbmt? And give out what you needed,
> > > > > > > but Svpbmt can't.
> > > > > > >
> > > > > > Sorry I didn't get what you meant here, could you please elaborate.
> > > > > I know there is no pbmt in AX45MP, I am just curious how many physical
> > > > > memory attributes you would use in linux? It seems only one type used
> > > > > in the series:
> > > > > cpu_nocache_area_set -> sbi_ecall(SBI_EXT_ANDES,
> > > > > SBI_EXT_ANDES_SET_PMA, offset, vaddr, size, entry_id, 0, 0);
> > > > >
> > > > Yes, currently we only use "Memory, Non-cacheable, Bufferable". I was
> > > > wondering if we could send these options as flags from DT something
> > > > like below so that it's not hard coded in the code.
> > > >
> > > > /* PMA config */
> > > > #define AX45MP_PMACFG_ETYP                GENMASK(1, 0)
> > > > /* OFF: PMA entry is disabled */
> > > > #define AX45MP_PMACFG_ETYP_DISABLED            0
> > > > /* Naturally aligned power of 2 region */
> > > > #define AX45MP_PMACFG_ETYP_NAPOT            3
> > > >
> > > > #define AX45MP_PMACFG_MTYP                GENMASK(5, 2)
> > > > /* Device, Non-bufferable */
> > > > #define AX45MP_PMACFG_MTYP_DEV_NON_BUF            (0 << 2)
> > > > /* Device, bufferable */
> > > > #define AX45MP_PMACFG_MTYP_DEV_BUF            (1 << 2)
> > > > /* Memory, Non-cacheable, Non-bufferable */
> > > > #define AX45MP_PMACFG_MTYP_MEM_NON_CACHE_NON_BUF    (2 << 2)
> > > > /* Memory, Non-cacheable, Bufferable */
> > > > #define AX45MP_PMACFG_MTYP_MEM_NON_CACHE_BUF        (3 << 2)
> > > > /* Memory, Write-back, No-allocate */
> > > > #define AX45MP_PMACFG_MTYP_MEM_WB_NA            (8 << 2)
> > > > /* Memory, Write-back, Read-allocate */
> > > > #define AX45MP_PMACFG_MTYP_MEM_WB_RA            (9 << 2)
> > > > /* Memory, Write-back, Write-allocate */
> > > > #define AX45MP_PMACFG_MTYP_MEM_WB_WA            (10 << 2)
> > > > /* Memory, Write-back, Read and Write-allocate */
> > > > #define AX45MP_PMACFG_MTYP_MEM_WB_R_WA            (11 << 2)
> > > >
> > > > /* AMO instructions are supported */
> > > > #define AX45MP_PMACFG_NAMO_AMO_SUPPORT            (0 << 6)
> > > > /* AMO instructions are not supported */
> > > > #define AX45MP_PMACFG_NAMO_AMO_NO_SUPPORT        (1 << 6)
> > > >
> > > >
> > > >                 pma-regions = <0x0 0x00000000 0x0 0x10000000 0x0
> > > > AX45MP_PMACFG_ETYP_NAPOT |  AX45MP_PMACFG_MTYP_MEM_NON_CACHE_BUF |
> > > > AX45MP_PMACFG_NAMO_AMO_SUPPORT>,
> > > >                               <0x0 0x10000000 0x0 0x04000000 0x0
> > > > AX45MP_PMACFG_ETYP_NAPOT |  AX45MP_PMACFG_MTYP_MEM_NON_CACHE_BUF |
> > > > AX45MP_PMACFG_NAMO_AMO_SUPPORT >,
> > > >                               <0x0 0x20000000 0x0 0x10000000 0x0
> > > > AX45MP_PMACFG_ETYP_NAPOT |  AX45MP_PMACFG_MTYP_MEM_NON_CACHE_BUF |
> > > > AX45MP_PMACFG_NAMO_AMO_SUPPORT>,
> > > >                               <0x0 0x58000000 0x0 0x08000000 0x0
> > > > AX45MP_PMACFG_ETYP_NAPOT |  AX45MP_PMACFG_MTYP_MEM_NON_CACHE_BUF |
> > > > AX45MP_PMACFG_NAMO_AMO_SUPPORT>;
> > > >
> > > > Does the above sound good?
> > > I've no idea. But for working around, I would give Acked-by.
> > >
> > > >
> > > > > I'm not sure how you make emmc/usb/gmac's dma ctrl desc work around
> > > > > without pbmt when they don't have cache coherency protocol. Do you
> > > > > need to inject dma_sync for desc synchronization? What's the effect of
> > > > > dynamic PMA in the patch series?
> > > > >
> > > > Currently we have setup the pma regions as below:
> > > >
> > > > l2cache: cache-controller@13400000 {
> > > >                 compatible = "andestech,ax45mp-cache", "cache";
> > > >                 cache-size = <0x40000>;
> > > >                 cache-line-size = <64>;
> > > >                 cache-sets = <1024>;
> > > >                 cache-unified;
> > > >                 reg = <0x0 0x13400000 0x0 0x100000>;
> > > >                 pma-regions = <0x0 0x00000000 0x0 0x10000000 0x0 0xf>,
> > > >                               <0x0 0x10000000 0x0 0x04000000 0x0 0xf>,
> > > >                               <0x0 0x20000000 0x0 0x10000000 0x0 0xf>,
> > > >                               <0x0 0x58000000 0x0 0x08000000 0x0 0xf>;
> > > >                 interrupts = <SOC_PERIPHERAL_IRQ(476, IRQ_TYPE_LEVEL_HIGH)>;
> > > >         };
> > > >
> > > > The last pma-regions entry 0x58000000 is a DDR location this memory
> > > > locations is marked as shared DMA pool with below in DT,
> > > >
> > > >     reserved-memory {
> > > >         #address-cells = <2>;
> > > >         #size-cells = <2>;
> > > >         ranges;
> > > >
> > > >         reserved: linux,cma@58000000 {
> > > >             compatible = "shared-dma-pool";
> > > >             no-map;
> > > >             linux,dma-default;
> > > >             reg = <0x0 0x58000000 0x0 0x08000000>;
> > > >         };
> > > >     };
> > > >
> > > > And for ARCH_R9A07G043 we automatically select DMA_GLOBAL_POOL, so the
> > > > IP blocks (emmc/usb/gmac's) requesting DMA'able memory will
> > > > automatically fall into this region which is non-cacheable but
> > > > bufferable (set in PMA) and rest everything is taken care by clean and
> > > > flush callbacks. We dont have  inject dma_sync for desc
> > > > synchronization for existing drivers (which are shared with Renesas
> > > > RZ/G2L family)
> > > Better than I thought :). The "non-cacheable but c" is "weak
> > > order," also raising the bufferable signal of AXI transactions. Right?
> > Yes, I have confirmed from the HW team it does raise bufferable signal
> > of AXI transactions. So far with the drivers (ETH/USB/DMAC) we haven't
> > seen issues so far.
> >
> > Do you foresee any issues?
> That depends on you interconnect design, most of the simple
> interconnects would ignore bufferable. Some NoC interconnects would
> buffer the transactions, which means data would be buffered in
> interconnects after CPU store instruction retired. If the CPU kicks
> the dma working with an IO reg write, hw may not guarantee the orders
> of the last data written and dma IO reg kick start. Then dma may lose
> the data.
>
I haven't see this issue, maybe to avoid this the controller register
space could be marked as non-cachebale + non-bufferable in the PMA by
this way we could ensure orders.

What do you think?

Cheers,
Prabhakar
