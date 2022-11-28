Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F38063A808
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 13:17:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231583AbiK1MR4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 07:17:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231598AbiK1MR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 07:17:28 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B0C51EC46;
        Mon, 28 Nov 2022 04:08:42 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id ud5so25243083ejc.4;
        Mon, 28 Nov 2022 04:08:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=R+LQlj7xgpzysitHuN8QQ6CAzeMP7xdAT3qKXB4PYg8=;
        b=T557FQNjTVqcQOajSa+tqlb3v2VcbLQdUR5oEF8sRgBv4KpD9q5lv66/LsoQxTI1QD
         VRL80QCcumabZVPr0ajn4eqPVxQ+3Bb4C3v1N3O5ygkpzQE+mY6PvGDW9aKgP5UWn3L6
         hquZ8rbMqEolm01p0qR4Vczv8Jn/+kO4TIvvokceNwyKgL0XJHLv66Jko7IhhHMXc5vE
         wXTXbRE6lYKXItc5AEkJN0zvvaWn2Fk89PYzenMeMeEKxNqDvgi791M7KkoH8y0rl0BK
         sNK4rNpG3Xqx2BxRO4ATvP0gnhU9DT1gHcb1qdUrXyQwKcSYQiskXAb2ckfdDPuHLpKx
         oFLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R+LQlj7xgpzysitHuN8QQ6CAzeMP7xdAT3qKXB4PYg8=;
        b=zleUURx/XXHgdamHv4/KbXmNqDOtpVlpSXYxY2KNy9Mo4MUKcWP33Y/T84oxsVwb4L
         45kvOogfGQJC9olLn7GylK+/+CCAEp8z5M9ABGdMRLxMwlIvISoJpDIcbvRfcfacDD47
         43V5edrblW/sbI1CNn0q8K3RmbJlGSZu936myYjpkf57f2M3j6YOqDX0g9ULmBsZJQvU
         c3DTHkcqFt46m4N+3sCRFOCNyh2KsMvbENlGjciXUkXeeJ5dfgkHLZCxKFEKTit6gcNM
         7MeTkStBF/EU6GNFD05pBbp0byhOui2kgrQLm9NGQ8BfjRjS1ef33FyzhMBi26Dnz8tZ
         WCfw==
X-Gm-Message-State: ANoB5pluVMaTOuJMbiRexbmDyYL67ZBBPt3QmMCh3Ka1ZWHAvpZy3Z87
        4d27tX3uZVlnTFTSyiCnQPtHzyb2p/dh8gIrNGw=
X-Google-Smtp-Source: AA0mqf42kWuFtJ0CyH8eGK/mbhy1LFxCynd+E1aiulOuYYYtVUh6FL5P8SGKbop++R7wLRWgwYnPbYmShNX57VojT+E=
X-Received: by 2002:a17:907:9895:b0:7c0:7db3:82e3 with SMTP id
 ja21-20020a170907989500b007c07db382e3mr1223559ejc.480.1669637320781; Mon, 28
 Nov 2022 04:08:40 -0800 (PST)
MIME-Version: 1.0
References: <20221124172207.153718-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20221124172207.153718-8-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <bf8e33fd-a752-d5d5-859e-14302d069f2d@sholland.org> <CA+V-a8sz4i_wenTyA5tVTVB8dQWLmuXCf3CGYOPC+C07GJ8WTw@mail.gmail.com>
 <CAMuHMdWQO_usrJwmVYDx6o-CpzmotVZLt176eKbqLzY-GXiDng@mail.gmail.com>
In-Reply-To: <CAMuHMdWQO_usrJwmVYDx6o-CpzmotVZLt176eKbqLzY-GXiDng@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Mon, 28 Nov 2022 12:08:14 +0000
Message-ID: <CA+V-a8s5mZoLMhjjpo_89taaBx+M_EwXMZUu-TUpZc8Q3bw4ug@mail.gmail.com>
Subject: Re: [PATCH v4 7/7] soc: renesas: Add L2 cache management for RZ/Five SoC
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Samuel Holland <samuel@sholland.org>, opensbi@lists.infradead.org,
        Anup Patel <apatel@ventanamicro.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Guo Ren <guoren@kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Atish Patra <atishp@rivosinc.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
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

On Sun, Nov 27, 2022 at 9:55 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Prabhakar,
>
> On Sat, Nov 26, 2022 at 10:10 PM Lad, Prabhakar
> <prabhakar.csengg@gmail.com> wrote:
> > On Fri, Nov 25, 2022 at 7:43 PM Samuel Holland <samuel@sholland.org> wrote:
> > > On 11/24/22 11:22, Prabhakar wrote:
> > > > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > >
> > > > On the AX45MP core, cache coherency is a specification option so it may
> > > > not be supported. In this case DMA will fail. As a workaround, firstly we
> > > > allocate a global dma coherent pool from which DMA allocations are taken
> > > > and marked as non-cacheable + bufferable using the PMA region as specified
> > > > in the device tree. Synchronization callbacks are implemented to
> > > > synchronize when doing DMA transactions.
> > > >
> > > > The Andes AX45MP core has a Programmable Physical Memory Attributes (PMA)
> > > > block that allows dynamic adjustment of memory attributes in the runtime.
> > > > It contains a configurable amount of PMA entries implemented as CSR
> > > > registers to control the attributes of memory locations in interest.
> > > >
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
> > > > This patch adds support to configure the memory attributes of the memory
> > > > regions as passed from the l2 cache node and exposes the cache management
> > > > ops.
> > >
> > > Forgive my ignorance, but why do you need both a DMA pool and explicit
> > > cache maintenance? Wouldn't the purpose of marking a memory region as
> > > permanently non-cacheable be to avoid cache maintenance? And likewise,
> > > if you are doing cache maintenance anyway, why does it matter if/how the
> > > memory is cacheable?
> > >
> > "Memory, Non-cacheable, Bufferable" raises an AXI signal for
> > transactions hence needing SW implementation for cache maintenance.
> >
> > > > More info about PMA (section 10.3):
> > > > Link: http://www.andestech.com/wp-content/uploads/AX45MP-1C-Rev.-5.0.0-Datasheet.pdf
> > > >
> > > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> > > > +static int ax45mp_configure_pma_regions(struct device_node *np)
> > > > +{
> > > > +     const char *propname = "andestech,pma-regions";
> > > > +     u32 start, size, flags;
> > > > +     unsigned int entry_id;
> > > > +     unsigned int i;
> > > > +     int count;
> > > > +     int ret;
> > > > +
> > > > +     count = of_property_count_elems_of_size(np, propname, sizeof(u32) * 3);
> > > > +     if (count < 0)
> > > > +             return count;
> > > > +
> > > > +     if (count > AX45MP_MAX_PMA_REGIONS)
> > > > +             return -EINVAL;
> > > > +
> > > > +     for (i = 0, entry_id = 0 ; entry_id < count ; i += 3, entry_id++) {
> > > > +             of_property_read_u32_index(np, propname, i, &start);
> > > > +             of_property_read_u32_index(np, propname, i + 1, &size);
> > > > +             of_property_read_u32_index(np, propname, i + 2, &flags);
> > > > +             ret = ax45mp_sbi_set_pma(start, size, flags, entry_id);
> > > > +             if (!ret)
> > > > +                     pr_err("Failed to setup PMA region 0x%x - 0x%x flags: 0x%x",
> > > > +                            start, start + size, flags);
> > > > +     }
> > > > +
> > > > +     return 0;
> > > > +}
> > >
> > > If firmware support is required to set up these PMA regions, why is
> > > Linux doing this at all? The firmware has access to the devicetree as
> > > well. It can set this up before entering S-mode, and then you don't need
> > > to expose this capability via an SBI extension. In fact, firmware could
> > > generate the reserved-memory node based on these regions at runtime (or
> > > vice versa).
> > >
> > That's a good point. I'll do some research on this and get back.
> >
> > Btw are there any existing examples where the firmware adds DT nodes?
>
> /memory, reserved-memory, optee on ARM, RPC status on R-Car Gen3/4, ...
>
On the TF-A we pass the FDT blob to u-boot and this does the magic.

On the RISC-V what would be the correct approach?
- We setup the PMA regions in OpenSBI
- We provide a vendor specific EXT to check if the PMA is setup
- In u-boot ft_board_setup() callback add the reserved-memory node

Does the above approach sound good or is there a better approach I'm missing?

Cheers,
Prabhakar
