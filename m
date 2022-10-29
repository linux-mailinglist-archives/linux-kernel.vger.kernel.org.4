Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E28F612507
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 21:11:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbiJ2TL2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 15:11:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiJ2TL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 15:11:26 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 627AA58083;
        Sat, 29 Oct 2022 12:11:25 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 21so12299200edv.3;
        Sat, 29 Oct 2022 12:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PRcfJjVWjUUCXuQLSgCtokoLV52Uo/1p54GmWdUxlxE=;
        b=AqSzAKPt/WgwH/l+UhyyMFHbN//vXUHpriUQNAChkKr/jFm88XDrVo5VyBpK6qw4pa
         ghqAlC07wuGwI0RJSP4HqUmwvtnVe2jdogWf8hGk1MXNO1+KqrXYeWRyaZexkzIvr1RS
         2JH11l+KfNMnTiJwDKsdVdSXKr82kSTzgT6pbXltpu7kRcfzP80bbXhCQ60bJOtdPBB0
         R2cn82cWpBsvRssXDravsaEwWQSOVm0G3c/vU2SxCZvEzK0mJrPkeFTNpkZ0O1djg5pF
         yoMC2S4ga9qhSOXrBduzVzHbon3HIbt9Gk9cqD26bRrKQoQSUxUF/o8+aphULW5DsHH7
         oNXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PRcfJjVWjUUCXuQLSgCtokoLV52Uo/1p54GmWdUxlxE=;
        b=ONr+bQ430mrQsfU3zDajfkYT4RDIhoXm7JWtnSO0Llwn7FPPCrsbwxaC3Xzf5izVHI
         w/r/bJv1/XMvoFqnqdq6KxFxM39zaJdt2XJ7aJLiLLdbC0bNVQ2Siv3B5aub0iSq8zkG
         Nyc9E3Ollxciu+gi1TDwCcO4t+T3lSNk3+/MQkoRVFaoi1tCciZ+w9ffQAB447Z/OHzN
         o1bCetX/VbDEh4QbigMuESGw7wlWlSTEltQVwqhQOtJYj1iI5veuWA32fCtofmZX5wJ9
         GvMRUvTcYl6RKSXfaH29BB9fMNJP9PigC96DY/5bpNWkGCWjlMT7T8LL64DSqNX+MnR4
         mTDw==
X-Gm-Message-State: ACrzQf0DDmTfYvU+bODFmLrYBA1LMh6B3Ht6F26JK7RndtBhX5nvV7gv
        7Ya5LA/uHMDhNbzJ0l0suPv+AZXHj+XE22UXv7s=
X-Google-Smtp-Source: AMsMyM6a7g81JSx2zMQbQzMFHs2TLJQDp3aKLZtgcj3D1f9JQ9/PyvQnuCicyExcHIaMv5IiPqJKUX7cpyCiuf8BRhw=
X-Received: by 2002:a05:6402:3217:b0:461:d6d7:7f19 with SMTP id
 g23-20020a056402321700b00461d6d77f19mr5591355eda.109.1667070683837; Sat, 29
 Oct 2022 12:11:23 -0700 (PDT)
MIME-Version: 1.0
References: <20221028165921.94487-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20221028165921.94487-5-prabhakar.mahadev-lad.rj@bp.renesas.com> <CAJF2gTQPU0FGmeVt9jrNfOAQSA=04Vcm4U_wcC_dGMc5X2Bo7w@mail.gmail.com>
In-Reply-To: <CAJF2gTQPU0FGmeVt9jrNfOAQSA=04Vcm4U_wcC_dGMc5X2Bo7w@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Sat, 29 Oct 2022 20:10:56 +0100
Message-ID: <CA+V-a8vBkHhTtq6Veb2vn-6o4S5Ter==yN6TFhYQvxko_Bk2LQ@mail.gmail.com>
Subject: Re: [PATCH v5 4/7] riscv: dts: renesas: Add initial devicetree for
 Renesas RZ/Five SoC
To:     Guo Ren <guoren@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
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

Hi Guo,

Thank you for the review.

On Sat, Oct 29, 2022 at 5:25 AM Guo Ren <guoren@kernel.org> wrote:
>
> On Sat, Oct 29, 2022 at 12:59 AM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> >
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > Add initial device tree for Renesas RZ/Five RISC-V CPU Core (AX45MP
> > Single).
> >
> > RZ/Five SoC is almost identical to RZ/G2UL Type-1 SoC (ARM64) hence we
> > will be reusing r9a07g043.dtsi [0] as a base DTSI for both the SoC's.
> > r9a07g043f.dtsi includes RZ/Five SoC specific blocks.
> >
> > Below are the RZ/Five SoC specific blocks added in the initial DTSI which
> > can be used to boot via initramfs on RZ/Five SMARC EVK:
> > - AX45MP CPU
> > - PLIC
> >
> > [0] arch/arm64/boot/dts/renesas/r9a07g043.dtsi
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> > v4 -> v5
> > * Fixed riscv,ndev value (should be 511)
> > * Reworked completely (sort of new patch)
> >
> > v3 -> v4
> > * No change
> >
> > v2 -> v3
> > * Fixed clock entry for CPU core
> > * Fixed timebase frequency to 12MHz
> > * Fixed sorting of the nodes
> > * Included RB tags
> >
> > v1 -> v2
> > * Dropped including makefile change
> > * Updated ndev count
> > ---
> >  arch/riscv/boot/dts/renesas/r9a07g043f.dtsi | 57 +++++++++++++++++++++
> >  1 file changed, 57 insertions(+)
> >  create mode 100644 arch/riscv/boot/dts/renesas/r9a07g043f.dtsi
> >
> > diff --git a/arch/riscv/boot/dts/renesas/r9a07g043f.dtsi b/arch/riscv/boot/dts/renesas/r9a07g043f.dtsi
> > new file mode 100644
> > index 000000000000..50134be548f5
> > --- /dev/null
> > +++ b/arch/riscv/boot/dts/renesas/r9a07g043f.dtsi
> > @@ -0,0 +1,57 @@
> > +// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +/*
> > + * Device Tree Source for the RZ/Five SoC
> > + *
> > + * Copyright (C) 2022 Renesas Electronics Corp.
> > + */
> > +
> > +#include <dt-bindings/interrupt-controller/irq.h>
> > +
> > +#define SOC_PERIPHERAL_IRQ(nr) (nr + 32)
> > +
> > +#include <arm64/renesas/r9a07g043.dtsi>
> The initial patch shouldn't be broken. Combine them together with the
> minimal components and add others late. Don't separate the DTS files.
>
r9a07g043.dtsi [0] already exists in the kernel. r9a07g043.dtsi is
shared with the RZ/G2UL SoC (ARM64) and the RZ/Five SoC. There are two
more patches [1] which are required and are currently queued up in the
Renesas tree for v6.2 (Ive mentioned the dependencies in the cover
letter).

[0] arch/arm64/boot/dts/renesas/r9a07g043.dtsi
[1] https://patchwork.kernel.org/project/linux-renesas-soc/cover/20221025220629.79321-1-prabhakar.mahadev-lad.rj@bp.renesas.com/

> > +
> > +/ {
> > +       cpus {
> > +               #address-cells = <1>;
> > +               #size-cells = <0>;
> > +               timebase-frequency = <12000000>;
> > +
> > +               cpu0: cpu@0 {
> > +                       compatible = "andestech,ax45mp", "riscv";
> > +                       device_type = "cpu";
> > +                       reg = <0x0>;
> > +                       status = "okay";
> > +                       riscv,isa = "rv64imafdc";
> > +                       mmu-type = "riscv,sv39";
> > +                       i-cache-size = <0x8000>;
> > +                       i-cache-line-size = <0x40>;
> > +                       d-cache-size = <0x8000>;
> > +                       d-cache-line-size = <0x40>;
> > +                       clocks = <&cpg CPG_CORE R9A07G043_CLK_I>;
> > +
> > +                       cpu0_intc: interrupt-controller {
> > +                               #interrupt-cells = <1>;
> > +                               compatible = "riscv,cpu-intc";
> > +                               interrupt-controller;
> > +                       };
> > +               };
> > +       };
> > +};
> > +
> > +&soc {
> > +       interrupt-parent = <&plic>;
> > +
> > +       plic: interrupt-controller@12c00000 {
> > +               compatible = "renesas,r9a07g043-plic", "andestech,nceplic100";
> > +               #interrupt-cells = <2>;
> > +               #address-cells = <0>;
> > +               riscv,ndev = <511>;
> > +               interrupt-controller;
> > +               reg = <0x0 0x12c00000 0 0x400000>;
> > +               clocks = <&cpg CPG_MOD R9A07G043_NCEPLIC_ACLK>;
> > +               power-domains = <&cpg>;
> > +               resets = <&cpg R9A07G043_NCEPLIC_ARESETN>;
> Ditto, Where is cpg? in r9a07g043.dtsi?
>
Yes CPG node is in r9a07g043.dtsi.

Cheers,
Prabhakar
