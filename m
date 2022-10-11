Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A5325FB2ED
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 15:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbiJKNKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 09:10:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbiJKNKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 09:10:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE1FA326F6;
        Tue, 11 Oct 2022 06:10:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 558976118D;
        Tue, 11 Oct 2022 13:10:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABA14C43148;
        Tue, 11 Oct 2022 13:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665493842;
        bh=FeeS5EmcSnirDNaEXQHIxqw6ToxVNKUSEQ9QmZOetp8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Zl0YK+lavpok6KpJ6AZ5H1Ntr6tqnh9vophsm4NXnoyk16NUSj9ejXxQ+cGltntOH
         SdsXg5P3R6pQi9GKMrDFORfgduVdBrc7Nb53L9055Tj0I5/s+M6aWmDWIk0ho2cuDp
         n6fYkvWQGNnM/cZNV3gLqXSvrYe1Lugy1QJLQpeEy1RVSXKU9L4pRsFockhiOKTyQE
         D1AqHth0x2+CQTUSvsvqDjzCkTuwBYIFXnhnGTO4n5fDbhckIj66A/Tf2uyed7u2EK
         cOp0B6slo/NOyBV4SLOWNjVP4JE09PTAunTnVkciqMh1MG2yqU2IRUsaXWTPq062Li
         TYwuSNe3OdxAw==
Received: by mail-oi1-f174.google.com with SMTP id w74so7581346oie.0;
        Tue, 11 Oct 2022 06:10:42 -0700 (PDT)
X-Gm-Message-State: ACrzQf0hm7ZtkIMVVUnhhyPcY/ng3xmocLhO8ruiVgn6/bDGV2ioioDj
        MKIRTEFqoLMMG/RydY79eJbknQUvMiX6d2vWxjw=
X-Google-Smtp-Source: AMsMyM7FRbQ6bU+Wav0+f/J17LrqgCaUu1CFhJxUHLRXZEVWWBYQkfgBLqeNgE5A9zcxmm6ZtsPLdlvjZeopL0trqBU=
X-Received: by 2002:a05:6808:151f:b0:350:1b5e:2380 with SMTP id
 u31-20020a056808151f00b003501b5e2380mr17110621oiw.112.1665493841651; Tue, 11
 Oct 2022 06:10:41 -0700 (PDT)
MIME-Version: 1.0
References: <20221003223222.448551-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20221003223222.448551-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAJF2gTQuSX9idEyNmGRwpAsSP8V=+QKQ7UAp28T-seM8rbkwOA@mail.gmail.com>
 <CA+V-a8smkDmQbz76sTA5XfUm7bkY4Ee-L5xYW+-xRWkE1TYiAw@mail.gmail.com>
 <CAJF2gTQ4G-j3p_pHvVQ82R2DFQZq70xgE3ZhoRkxiSzrHnU2og@mail.gmail.com>
 <CA+V-a8tLYT0541FNo_o-sTsV7ywwnGTRtv6ropVu+0Wd-PsM6A@mail.gmail.com>
 <CAJF2gTQ9N5tyYB46eaMJ=Z0V7pm9TxFAXQ1qxLXLqj2C9zP2Ng@mail.gmail.com> <CA+V-a8sTQzbXC6j4+fNAYiM7_zciPaxb=uOzD9iWrvLwUBgDqA@mail.gmail.com>
In-Reply-To: <CA+V-a8sTQzbXC6j4+fNAYiM7_zciPaxb=uOzD9iWrvLwUBgDqA@mail.gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Tue, 11 Oct 2022 21:10:29 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQnQSCwGAzXPENrCz2Uwf8WivYsRP57XGoCtywxE2_bZA@mail.gmail.com>
Message-ID: <CAJF2gTQnQSCwGAzXPENrCz2Uwf8WivYsRP57XGoCtywxE2_bZA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 2/2] soc: renesas: Add L2 cache management for
 RZ/Five SoC
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
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
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 11, 2022 at 5:39 PM Lad, Prabhakar
<prabhakar.csengg@gmail.com> wrote:
>
> Hi Guo,
>
> On Thu, Oct 6, 2022 at 1:59 AM Guo Ren <guoren@kernel.org> wrote:
> >
> > On Wed, Oct 5, 2022 at 11:03 PM Lad, Prabhakar
> > <prabhakar.csengg@gmail.com> wrote:
> > >
> > > Hi Guo,
> > >
> > > On Wed, Oct 5, 2022 at 3:23 PM Guo Ren <guoren@kernel.org> wrote:
> > > >
> > > > On Wed, Oct 5, 2022 at 8:54 PM Lad, Prabhakar
> > > > <prabhakar.csengg@gmail.com> wrote:
> > > > >
> > > > > Hi Guo,
> > > > >
> > > > > On Wed, Oct 5, 2022 at 2:29 AM Guo Ren <guoren@kernel.org> wrote:
> > > > > >
> > > > > > On Tue, Oct 4, 2022 at 6:32 AM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> > > > > > >
> > > > > > > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > > > > >
> > > > > > > On the AX45MP core, cache coherency is a specification option so it may
> > > > > > > not be supported. In this case DMA will fail. As a workaround, firstly we
> > > > > > > allocate a global dma coherent pool from which DMA allocations are taken
> > > > > > > and marked as non-cacheable + bufferable using the PMA region as specified
> > > > > > > in the device tree. Synchronization callbacks are implemented to
> > > > > > > synchronize when doing DMA transactions.
> > > > > > >
> > > > > > > The Andes AX45MP core has a Programmable Physical Memory Attributes (PMA)
> > > > > > > block that allows dynamic adjustment of memory attributes in the runtime.
> > > > > > > It contains a configurable amount of PMA entries implemented as CSR
> > > > > > > registers to control the attributes of memory locations in interest.
> > > > > > >
> > > > > > > Below are the memory attributes supported:
> > > > > > > * Device, Non-bufferable
> > > > > > > * Device, bufferable
> > > > > > > * Memory, Non-cacheable, Non-bufferable
> > > > > > > * Memory, Non-cacheable, Bufferable
> > > > > > > * Memory, Write-back, No-allocate
> > > > > > > * Memory, Write-back, Read-allocate
> > > > > > > * Memory, Write-back, Write-allocate
> > > > > > > * Memory, Write-back, Read and Write-allocate
> > > > > > Seems Svpbmt's PMA, IO, and NC wouldn't fit your requirements, could
> > > > > > give a map list of the types of Svpbmt? And give out what you needed,
> > > > > > but Svpbmt can't.
> > > > > >
> > > > > Sorry I didn't get what you meant here, could you please elaborate.
> > > > I know there is no pbmt in AX45MP, I am just curious how many physical
> > > > memory attributes you would use in linux? It seems only one type used
> > > > in the series:
> > > > cpu_nocache_area_set -> sbi_ecall(SBI_EXT_ANDES,
> > > > SBI_EXT_ANDES_SET_PMA, offset, vaddr, size, entry_id, 0, 0);
> > > >
> > > Yes, currently we only use "Memory, Non-cacheable, Bufferable". I was
> > > wondering if we could send these options as flags from DT something
> > > like below so that it's not hard coded in the code.
> > >
> > > /* PMA config */
> > > #define AX45MP_PMACFG_ETYP                GENMASK(1, 0)
> > > /* OFF: PMA entry is disabled */
> > > #define AX45MP_PMACFG_ETYP_DISABLED            0
> > > /* Naturally aligned power of 2 region */
> > > #define AX45MP_PMACFG_ETYP_NAPOT            3
> > >
> > > #define AX45MP_PMACFG_MTYP                GENMASK(5, 2)
> > > /* Device, Non-bufferable */
> > > #define AX45MP_PMACFG_MTYP_DEV_NON_BUF            (0 << 2)
> > > /* Device, bufferable */
> > > #define AX45MP_PMACFG_MTYP_DEV_BUF            (1 << 2)
> > > /* Memory, Non-cacheable, Non-bufferable */
> > > #define AX45MP_PMACFG_MTYP_MEM_NON_CACHE_NON_BUF    (2 << 2)
> > > /* Memory, Non-cacheable, Bufferable */
> > > #define AX45MP_PMACFG_MTYP_MEM_NON_CACHE_BUF        (3 << 2)
> > > /* Memory, Write-back, No-allocate */
> > > #define AX45MP_PMACFG_MTYP_MEM_WB_NA            (8 << 2)
> > > /* Memory, Write-back, Read-allocate */
> > > #define AX45MP_PMACFG_MTYP_MEM_WB_RA            (9 << 2)
> > > /* Memory, Write-back, Write-allocate */
> > > #define AX45MP_PMACFG_MTYP_MEM_WB_WA            (10 << 2)
> > > /* Memory, Write-back, Read and Write-allocate */
> > > #define AX45MP_PMACFG_MTYP_MEM_WB_R_WA            (11 << 2)
> > >
> > > /* AMO instructions are supported */
> > > #define AX45MP_PMACFG_NAMO_AMO_SUPPORT            (0 << 6)
> > > /* AMO instructions are not supported */
> > > #define AX45MP_PMACFG_NAMO_AMO_NO_SUPPORT        (1 << 6)
> > >
> > >
> > >                 pma-regions = <0x0 0x00000000 0x0 0x10000000 0x0
> > > AX45MP_PMACFG_ETYP_NAPOT |  AX45MP_PMACFG_MTYP_MEM_NON_CACHE_BUF |
> > > AX45MP_PMACFG_NAMO_AMO_SUPPORT>,
> > >                               <0x0 0x10000000 0x0 0x04000000 0x0
> > > AX45MP_PMACFG_ETYP_NAPOT |  AX45MP_PMACFG_MTYP_MEM_NON_CACHE_BUF |
> > > AX45MP_PMACFG_NAMO_AMO_SUPPORT >,
> > >                               <0x0 0x20000000 0x0 0x10000000 0x0
> > > AX45MP_PMACFG_ETYP_NAPOT |  AX45MP_PMACFG_MTYP_MEM_NON_CACHE_BUF |
> > > AX45MP_PMACFG_NAMO_AMO_SUPPORT>,
> > >                               <0x0 0x58000000 0x0 0x08000000 0x0
> > > AX45MP_PMACFG_ETYP_NAPOT |  AX45MP_PMACFG_MTYP_MEM_NON_CACHE_BUF |
> > > AX45MP_PMACFG_NAMO_AMO_SUPPORT>;
> > >
> > > Does the above sound good?
> > I've no idea. But for working around, I would give Acked-by.
> >
> > >
> > > > I'm not sure how you make emmc/usb/gmac's dma ctrl desc work around
> > > > without pbmt when they don't have cache coherency protocol. Do you
> > > > need to inject dma_sync for desc synchronization? What's the effect of
> > > > dynamic PMA in the patch series?
> > > >
> > > Currently we have setup the pma regions as below:
> > >
> > > l2cache: cache-controller@13400000 {
> > >                 compatible = "andestech,ax45mp-cache", "cache";
> > >                 cache-size = <0x40000>;
> > >                 cache-line-size = <64>;
> > >                 cache-sets = <1024>;
> > >                 cache-unified;
> > >                 reg = <0x0 0x13400000 0x0 0x100000>;
> > >                 pma-regions = <0x0 0x00000000 0x0 0x10000000 0x0 0xf>,
> > >                               <0x0 0x10000000 0x0 0x04000000 0x0 0xf>,
> > >                               <0x0 0x20000000 0x0 0x10000000 0x0 0xf>,
> > >                               <0x0 0x58000000 0x0 0x08000000 0x0 0xf>;
> > >                 interrupts = <SOC_PERIPHERAL_IRQ(476, IRQ_TYPE_LEVEL_HIGH)>;
> > >         };
> > >
> > > The last pma-regions entry 0x58000000 is a DDR location this memory
> > > locations is marked as shared DMA pool with below in DT,
> > >
> > >     reserved-memory {
> > >         #address-cells = <2>;
> > >         #size-cells = <2>;
> > >         ranges;
> > >
> > >         reserved: linux,cma@58000000 {
> > >             compatible = "shared-dma-pool";
> > >             no-map;
> > >             linux,dma-default;
> > >             reg = <0x0 0x58000000 0x0 0x08000000>;
> > >         };
> > >     };
> > >
> > > And for ARCH_R9A07G043 we automatically select DMA_GLOBAL_POOL, so the
> > > IP blocks (emmc/usb/gmac's) requesting DMA'able memory will
> > > automatically fall into this region which is non-cacheable but
> > > bufferable (set in PMA) and rest everything is taken care by clean and
> > > flush callbacks. We dont have  inject dma_sync for desc
> > > synchronization for existing drivers (which are shared with Renesas
> > > RZ/G2L family)
> > Better than I thought :). The "non-cacheable but c" is "weak
> > order," also raising the bufferable signal of AXI transactions. Right?
> Yes, I have confirmed from the HW team it does raise bufferable signal
> of AXI transactions. So far with the drivers (ETH/USB/DMAC) we haven't
> seen issues so far.
>
> Do you foresee any issues?
That depends on you interconnect design, most of the simple
interconnects would ignore bufferable. Some NoC interconnects would
buffer the transactions, which means data would be buffered in
interconnects after CPU store instruction retired. If the CPU kicks
the dma working with an IO reg write, hw may not guarantee the orders
of the last data written and dma IO reg kick start. Then dma may lose
the data.

Not only for the interconnect, but also "noncacheable + weak order"
would cause data to stay in the CPU store buffer after the store
instruction retired.

>
> Cheers,
> Prabhakar



-- 
Best Regards
 Guo Ren
