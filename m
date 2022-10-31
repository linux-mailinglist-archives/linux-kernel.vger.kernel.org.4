Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EC96612E93
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 02:12:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbiJaBMF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 21:12:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiJaBMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 21:12:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B60C233;
        Sun, 30 Oct 2022 18:11:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 167D760FA1;
        Mon, 31 Oct 2022 01:11:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7193DC433C1;
        Mon, 31 Oct 2022 01:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667178717;
        bh=xtgHnB5H7FEL8NvoLBnWlLaYF4pAr6sLR85QXAmTFBQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ig5oPFlS6P2mJDvXnVvb7qPZKkCC6juQFHkVcjTxAW0i+g4dScJKtM3R1G/Np1fd9
         gOCsShBsKo0AYehLM1AgC5euypdSkO9lQaXWxzpOx9WvL0f+uR07kjzeeJWnzKvDkq
         m6cj7lfb94Ob8xL1BU9KkZG6mNSoN3UyuEJcMlGihvOnDbkXNZNj2joLITUmtgHD1d
         FvMIGozPeodO9nIqWwmhI8DRvpXm+5URAtb6q/oPK9aRjCCsUSDsIK909XMz7dV1fH
         p0JfWVyhC9wKDQlkw0OgYr+fDOzMoFLhoMMetLmyeei5QKjrMrWwTtFDwoQlqfNzT1
         VM63N14v2HzrQ==
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-13ae8117023so12098423fac.9;
        Sun, 30 Oct 2022 18:11:57 -0700 (PDT)
X-Gm-Message-State: ACrzQf1MOVUbrC2uOpMHW2fUxM9tEYxOG1P498kpY9Cs2y0XM4hv9hOr
        LxqbGKWwT3Ys9JaVwl2DSWlCgIZesw0qKzFJG2c=
X-Google-Smtp-Source: AMsMyM5YffQDzr4FZcxz9urfVbuCFu/0rR++ppFsy2T3KvqpS2lZzj9GI8kgBPLqT+THZWLCIJ6fChiw2RfdmVEmRKk=
X-Received: by 2002:a05:6870:64a1:b0:13c:d09d:79f9 with SMTP id
 cz33-20020a05687064a100b0013cd09d79f9mr3510873oab.112.1667178714338; Sun, 30
 Oct 2022 18:11:54 -0700 (PDT)
MIME-Version: 1.0
References: <20221028165921.94487-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20221028165921.94487-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAJF2gTQPU0FGmeVt9jrNfOAQSA=04Vcm4U_wcC_dGMc5X2Bo7w@mail.gmail.com>
 <CA+V-a8vBkHhTtq6Veb2vn-6o4S5Ter==yN6TFhYQvxko_Bk2LQ@mail.gmail.com>
 <CAJF2gTSQH0q4PoucBgr3abWWA+XCdxm1tk1j8Sqydt_XyCq2RA@mail.gmail.com>
 <Y16/YQTOW3DuQvo9@spud> <CA+V-a8vCNx-bqjeOa13LewaEJOGW-0ypqJTvZo7om6XcM4T7UA@mail.gmail.com>
In-Reply-To: <CA+V-a8vCNx-bqjeOa13LewaEJOGW-0ypqJTvZo7om6XcM4T7UA@mail.gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Mon, 31 Oct 2022 09:11:42 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRrLOxZt0qhcpC9_fx4bFc1Rj9TDyQVBXdKbwboh-ZGyQ@mail.gmail.com>
Message-ID: <CAJF2gTRrLOxZt0qhcpC9_fx4bFc1Rj9TDyQVBXdKbwboh-ZGyQ@mail.gmail.com>
Subject: Re: [PATCH v5 4/7] riscv: dts: renesas: Add initial devicetree for
 Renesas RZ/Five SoC
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc:     Conor Dooley <conor@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Conor Dooley <conor.dooley@microchip.com>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@rivosinc.com>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 31, 2022 at 6:27 AM Lad, Prabhakar
<prabhakar.csengg@gmail.com> wrote:
>
> Hi Conor,
>
> On Sun, Oct 30, 2022 at 6:16 PM Conor Dooley <conor@kernel.org> wrote:
> >
> > On Sun, Oct 30, 2022 at 08:02:10AM +0800, Guo Ren wrote:
> > > On Sun, Oct 30, 2022 at 3:11 AM Lad, Prabhakar
> > > <prabhakar.csengg@gmail.com> wrote:
> > > >
> > > > Hi Guo,
> > > >
> > > > Thank you for the review.
> > > >
> > > > On Sat, Oct 29, 2022 at 5:25 AM Guo Ren <guoren@kernel.org> wrote:
> > > > >
> > > > > On Sat, Oct 29, 2022 at 12:59 AM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> > > > > >
> > > > > > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > > > >
> > > > > > Add initial device tree for Renesas RZ/Five RISC-V CPU Core (AX45MP
> > > > > > Single).
> > > > > >
> > > > > > RZ/Five SoC is almost identical to RZ/G2UL Type-1 SoC (ARM64) hence we
> > > > > > will be reusing r9a07g043.dtsi [0] as a base DTSI for both the SoC's.
> > > > > > r9a07g043f.dtsi includes RZ/Five SoC specific blocks.
> > > > > >
> > > > > > Below are the RZ/Five SoC specific blocks added in the initial DTSI which
> > > > > > can be used to boot via initramfs on RZ/Five SMARC EVK:
> > > > > > - AX45MP CPU
> > > > > > - PLIC
> > > > > >
> > > > > > [0] arch/arm64/boot/dts/renesas/r9a07g043.dtsi
> > > > > >
> > > > > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > > > > ---
> > > > > > v4 -> v5
> > > > > > * Fixed riscv,ndev value (should be 511)
> > > > > > * Reworked completely (sort of new patch)
> > > > > >
> > > > > > v3 -> v4
> > > > > > * No change
> > > > > >
> > > > > > v2 -> v3
> > > > > > * Fixed clock entry for CPU core
> > > > > > * Fixed timebase frequency to 12MHz
> > > > > > * Fixed sorting of the nodes
> > > > > > * Included RB tags
> > > > > >
> > > > > > v1 -> v2
> > > > > > * Dropped including makefile change
> > > > > > * Updated ndev count
> > > > > > ---
> > > > > >  arch/riscv/boot/dts/renesas/r9a07g043f.dtsi | 57 +++++++++++++++++++++
> > > > > >  1 file changed, 57 insertions(+)
> > > > > >  create mode 100644 arch/riscv/boot/dts/renesas/r9a07g043f.dtsi
> > > > > >
> > > > > > diff --git a/arch/riscv/boot/dts/renesas/r9a07g043f.dtsi b/arch/riscv/boot/dts/renesas/r9a07g043f.dtsi
> > > > > > new file mode 100644
> > > > > > index 000000000000..50134be548f5
> > > > > > --- /dev/null
> > > > > > +++ b/arch/riscv/boot/dts/renesas/r9a07g043f.dtsi
> > > > > > @@ -0,0 +1,57 @@
> > > > > > +// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > > > > +/*
> > > > > > + * Device Tree Source for the RZ/Five SoC
> > > > > > + *
> > > > > > + * Copyright (C) 2022 Renesas Electronics Corp.
> > > > > > + */
> > > > > > +
> > > > > > +#include <dt-bindings/interrupt-controller/irq.h>
> > > > > > +
> > > > > > +#define SOC_PERIPHERAL_IRQ(nr) (nr + 32)
> > > > > > +
> > > > > > +#include <arm64/renesas/r9a07g043.dtsi>
> > > > > The initial patch shouldn't be broken. Combine them together with the
> > > > > minimal components and add others late. Don't separate the DTS files.
> > > > >
> > > > r9a07g043.dtsi [0] already exists in the kernel. r9a07g043.dtsi is
> > > > shared with the RZ/G2UL SoC (ARM64) and the RZ/Five SoC. There are two
> > > > more patches [1] which are required and are currently queued up in the
> > > > Renesas tree for v6.2 (Ive mentioned the dependencies in the cover
> > > > letter).
> > >
> > > You could just move the below part to the second dtsi patch. Then
> > > compile won't be broken.
> > >
> > >             clocks = <&cpg CPG_MOD R9A07G043_NCEPLIC_ACLK>;
> > >             power-domains = <&cpg>;
> > >             resets = <&cpg R9A07G043_NCEPLIC_ARESETN>;
> >
> > The makefile for this directory is not added until the next patch right?
> > The compile shouldn't be broken here since it therefore cannot be
> > compiled?
> >
> These nodes are already present in the kernel [0]  so the makefile
> change in the next patch if made here still won't break the
> compilation alone of SoC DTSI (included in dts).
Oh... Sorry, I screwed up. The
arch/arm64/boot/dts/renesas/r9a07g043.dtsi is not belonged to the
patch series.

>
> [0] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/arch/arm64/boot/dts/renesas/r9a07g043.dtsi?h=next-20221028#n563
>
> Cheers,
> Prabhakar



-- 
Best Regards
 Guo Ren
