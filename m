Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26A6268111F
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 15:10:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237201AbjA3OK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 09:10:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237188AbjA3OKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 09:10:04 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AAA803B658;
        Mon, 30 Jan 2023 06:09:59 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6D11C1758;
        Mon, 30 Jan 2023 06:10:41 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.11.245])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4A9363F885;
        Mon, 30 Jan 2023 06:09:57 -0800 (PST)
Date:   Mon, 30 Jan 2023 14:09:54 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc:     Will Deacon <will.deacon@arm.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH] arm64: dts: renesas: r9a07g044: Add Cortex-A55 PMU node
Message-ID: <Y9fPsjffc7bE8ULm@FVFF77S0Q05N>
References: <20230127174014.251539-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <OS0PR01MB592258905AC3979803C473D786CC9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <CA+V-a8s+cZpuUXWRa573a373n7YPsHrdLnUVXHjez6O101oneQ@mail.gmail.com>
 <OS0PR01MB5922943C1E1D9329691DB02F86CC9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <CA+V-a8u=xmYghCtCcGg-fU02u0kcwGqeCKOs4iSfwkdUe1MbFg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+V-a8u=xmYghCtCcGg-fU02u0kcwGqeCKOs4iSfwkdUe1MbFg@mail.gmail.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 30, 2023 at 02:04:44PM +0000, Lad, Prabhakar wrote:
> Hi Mark and Will,
> 
> On Fri, Jan 27, 2023 at 9:48 PM Biju Das <biju.das.jz@bp.renesas.com> wrote:
> >
> > Hi Prabhakar,
> >
> >
> > > Subject: Re: [PATCH] arm64: dts: renesas: r9a07g044: Add Cortex-A55 PMU node
> > >
> > > Hi Biju,
> > >
> > > Thank you for the review.
> > >
> > > On Fri, Jan 27, 2023 at 6:38 PM Biju Das <biju.das.jz@bp.renesas.com> wrote:
> > > >
> > > > Hi Prabhakar,
> > > >
> > > > Thanks for the patch.
> > > >
> > > > > Subject: [PATCH] arm64: dts: renesas: r9a07g044: Add Cortex-A55 PMU
> > > > > node
> > > > >
> > > > > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > > >
> > > > > Enable the performance monitor unit for the Cortex-A55 cores on the
> > > > > RZ/G2L
> > > > > (r9a07g044) SoC.
> > > > >
> > > > > Signed-off-by: Lad Prabhakar
> > > > > <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > > > ---
> > > > >  arch/arm64/boot/dts/renesas/r9a07g044.dtsi | 5 +++++
> > > > >  1 file changed, 5 insertions(+)
> > > > >
> > > > > diff --git a/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
> > > > > b/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
> > > > > index 80b2332798d9..ff9bdc03a3ed 100644
> > > > > --- a/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
> > > > > +++ b/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
> > > > > @@ -161,6 +161,11 @@ opp-50000000 {
> > > > >               };
> > > > >       };
> > > > >
> > > > > +     pmu_a55 {
> > > > > +             compatible = "arm,cortex-a55-pmu";
> > > > > +             interrupts-extended = <&gic GIC_PPI 7
> > > > > + IRQ_TYPE_LEVEL_HIGH>;
> > > >
> > > > Just a question, Is it tested?
> > > Yes this was tested with perf test
> > >
> > > > timer node[1] defines irq type as LOW, here it is high.
> > > You are right looking at the RZG2L_InterruptMapping_rev01.xlsx this should
> > > be LOW. (I followed the SPI IRQS where all the LEVEL interrupts are HIGH)
> > >
> > > > Also do we need to define (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW) as
> > > it has 2 cores??
> > > >
> > > No this is not required for example here [0] where it has 6 cores.
> >
> > I may be wrong, That is the only example[1], where the A55 PMU per cpu interrupts and number of a55 cores in the DT
> > are not matching.
> >
> Some SoCs specify the GIC_CPU_MASK_SIMPLE(x) while describing the PPI
> interrupt for the PMU and some dont [1]. What should be the correct
> usage when specifying the PPI interrupts for the PMU with multiple CPU
> cores (we are using
> arm,cortex-a55-pmu)?
> 
>  [1] https://elixir.bootlin.com/linux/latest/B/ident/arm%2Ccortex-a55-pmu

This is a GICv3 system. the GICv3 interrupts binding *does not* have a cpumask,
and it's always wrong to use GIC_CPU_MASK_SIMPLE() (or any mask, for that
matter) for GICv3

The GICv2 binding has the mask, but even there it's arguably pointless.

Please do not add the mask here, since it would violate the GICv3 binding.

Thanks,
Mark.
