Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07403612D4F
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 23:27:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbiJ3W1r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 18:27:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiJ3W1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 18:27:46 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13671F3A;
        Sun, 30 Oct 2022 15:27:45 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id b2so25414342eja.6;
        Sun, 30 Oct 2022 15:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YjgCwoppK5K4nAEcrBSrmaQ1uKTp6E8RaEwIZih6jLM=;
        b=Jh394vPLEoW0E+X/YoMd5kBFuQoOkW2YgCG1HOxCUDscvWe5tICJlcY3q95HgMFBCO
         b0dMHamfqrs7LzVMUpzv+YuYiItJ9XFCoXp2EnsPlClzMjVqbgxT2zPhP4weXF59Ozsc
         bfOD2upPMuGvtjjHmmYz7Kis/shVYEuPz378q6AVA7LAwg9En9FxRsLTMdtNNGl1MoUx
         X5r8FLh67rigiYKQyNtwJWf+kUd74usf4V3l2VhMwePaJYOWP0WBihntzVYPNh4IKZq4
         C8hTSN19RlX5QDlcaK0c/idsqikmfh7HsBjNokACCDlKXmP5CDNxXd9HBf/hoh+vsm/s
         Lp+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YjgCwoppK5K4nAEcrBSrmaQ1uKTp6E8RaEwIZih6jLM=;
        b=VN43sTJ6GGwSK/HMPbG60508UzGtGPHdWrxh5tGOC+96WWwa95Xy74pPPYpQ5WwMfV
         oL9C7hEHVfsSybep7GUEUgpwJq3Z2h3tmbq5Y+WhjwjzsRq9oxR3nTzT1+hSA5R1chLy
         kOn5IEAWlowuMP7+gpqhHSPYv6zezwWPrH9OLP6h4I01AEgUCHmK/0NeYj/ZhefLxBvL
         XZ3FaH+JM3zsakTv5aPOdkmjUmSb4yw4ZLARymU/BvwYadRq1v0z2WcKFIHgm4RRZ/mv
         sh0/VN5yVCRaaDkcq56A7IE1nElzI/MVuvR6pBcyzwhzS/1CWv8/HWA/XrhknX22MFmW
         ICMA==
X-Gm-Message-State: ACrzQf13XVtaqe5rCKxzdPgBv9lTXEj6GOOILJTwS3biP0SIDUuInhZB
        cU8ljCAkBjYa2ON2oH+AIY9zujYOIZA5agEQoHA=
X-Google-Smtp-Source: AMsMyM54fK8eb6S54ouxM/QZy65Og+WDxH2XLbBwQAA9DctNt0hxRLrGS7O3oKWP5nJ9Z0b2Z4QijdIJm0rsTWc6dVY=
X-Received: by 2002:a17:906:c14f:b0:793:30e1:96be with SMTP id
 dp15-20020a170906c14f00b0079330e196bemr10118283ejc.447.1667168863525; Sun, 30
 Oct 2022 15:27:43 -0700 (PDT)
MIME-Version: 1.0
References: <20221028165921.94487-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20221028165921.94487-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAJF2gTQPU0FGmeVt9jrNfOAQSA=04Vcm4U_wcC_dGMc5X2Bo7w@mail.gmail.com>
 <CA+V-a8vBkHhTtq6Veb2vn-6o4S5Ter==yN6TFhYQvxko_Bk2LQ@mail.gmail.com>
 <CAJF2gTSQH0q4PoucBgr3abWWA+XCdxm1tk1j8Sqydt_XyCq2RA@mail.gmail.com> <Y16/YQTOW3DuQvo9@spud>
In-Reply-To: <Y16/YQTOW3DuQvo9@spud>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Sun, 30 Oct 2022 22:27:17 +0000
Message-ID: <CA+V-a8vCNx-bqjeOa13LewaEJOGW-0ypqJTvZo7om6XcM4T7UA@mail.gmail.com>
Subject: Re: [PATCH v5 4/7] riscv: dts: renesas: Add initial devicetree for
 Renesas RZ/Five SoC
To:     Conor Dooley <conor@kernel.org>
Cc:     Guo Ren <guoren@kernel.org>,
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Conor,

On Sun, Oct 30, 2022 at 6:16 PM Conor Dooley <conor@kernel.org> wrote:
>
> On Sun, Oct 30, 2022 at 08:02:10AM +0800, Guo Ren wrote:
> > On Sun, Oct 30, 2022 at 3:11 AM Lad, Prabhakar
> > <prabhakar.csengg@gmail.com> wrote:
> > >
> > > Hi Guo,
> > >
> > > Thank you for the review.
> > >
> > > On Sat, Oct 29, 2022 at 5:25 AM Guo Ren <guoren@kernel.org> wrote:
> > > >
> > > > On Sat, Oct 29, 2022 at 12:59 AM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> > > > >
> > > > > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > > >
> > > > > Add initial device tree for Renesas RZ/Five RISC-V CPU Core (AX45MP
> > > > > Single).
> > > > >
> > > > > RZ/Five SoC is almost identical to RZ/G2UL Type-1 SoC (ARM64) hence we
> > > > > will be reusing r9a07g043.dtsi [0] as a base DTSI for both the SoC's.
> > > > > r9a07g043f.dtsi includes RZ/Five SoC specific blocks.
> > > > >
> > > > > Below are the RZ/Five SoC specific blocks added in the initial DTSI which
> > > > > can be used to boot via initramfs on RZ/Five SMARC EVK:
> > > > > - AX45MP CPU
> > > > > - PLIC
> > > > >
> > > > > [0] arch/arm64/boot/dts/renesas/r9a07g043.dtsi
> > > > >
> > > > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > > > ---
> > > > > v4 -> v5
> > > > > * Fixed riscv,ndev value (should be 511)
> > > > > * Reworked completely (sort of new patch)
> > > > >
> > > > > v3 -> v4
> > > > > * No change
> > > > >
> > > > > v2 -> v3
> > > > > * Fixed clock entry for CPU core
> > > > > * Fixed timebase frequency to 12MHz
> > > > > * Fixed sorting of the nodes
> > > > > * Included RB tags
> > > > >
> > > > > v1 -> v2
> > > > > * Dropped including makefile change
> > > > > * Updated ndev count
> > > > > ---
> > > > >  arch/riscv/boot/dts/renesas/r9a07g043f.dtsi | 57 +++++++++++++++++++++
> > > > >  1 file changed, 57 insertions(+)
> > > > >  create mode 100644 arch/riscv/boot/dts/renesas/r9a07g043f.dtsi
> > > > >
> > > > > diff --git a/arch/riscv/boot/dts/renesas/r9a07g043f.dtsi b/arch/riscv/boot/dts/renesas/r9a07g043f.dtsi
> > > > > new file mode 100644
> > > > > index 000000000000..50134be548f5
> > > > > --- /dev/null
> > > > > +++ b/arch/riscv/boot/dts/renesas/r9a07g043f.dtsi
> > > > > @@ -0,0 +1,57 @@
> > > > > +// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > > > +/*
> > > > > + * Device Tree Source for the RZ/Five SoC
> > > > > + *
> > > > > + * Copyright (C) 2022 Renesas Electronics Corp.
> > > > > + */
> > > > > +
> > > > > +#include <dt-bindings/interrupt-controller/irq.h>
> > > > > +
> > > > > +#define SOC_PERIPHERAL_IRQ(nr) (nr + 32)
> > > > > +
> > > > > +#include <arm64/renesas/r9a07g043.dtsi>
> > > > The initial patch shouldn't be broken. Combine them together with the
> > > > minimal components and add others late. Don't separate the DTS files.
> > > >
> > > r9a07g043.dtsi [0] already exists in the kernel. r9a07g043.dtsi is
> > > shared with the RZ/G2UL SoC (ARM64) and the RZ/Five SoC. There are two
> > > more patches [1] which are required and are currently queued up in the
> > > Renesas tree for v6.2 (Ive mentioned the dependencies in the cover
> > > letter).
> >
> > You could just move the below part to the second dtsi patch. Then
> > compile won't be broken.
> >
> >             clocks = <&cpg CPG_MOD R9A07G043_NCEPLIC_ACLK>;
> >             power-domains = <&cpg>;
> >             resets = <&cpg R9A07G043_NCEPLIC_ARESETN>;
>
> The makefile for this directory is not added until the next patch right?
> The compile shouldn't be broken here since it therefore cannot be
> compiled?
>
These nodes are already present in the kernel [0]  so the makefile
change in the next patch if made here still won't break the
compilation alone of SoC DTSI (included in dts).

[0] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/arch/arm64/boot/dts/renesas/r9a07g043.dtsi?h=next-20221028#n563

Cheers,
Prabhakar
