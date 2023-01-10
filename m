Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A95A3663681
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 02:00:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbjAJBAH convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 9 Jan 2023 20:00:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbjAJBAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 20:00:05 -0500
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7102B3D1D1;
        Mon,  9 Jan 2023 17:00:01 -0800 (PST)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 98EBA24E10F;
        Tue, 10 Jan 2023 08:59:58 +0800 (CST)
Received: from EXMBX168.cuchost.com (172.16.6.78) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 10 Jan
 2023 08:59:58 +0800
Received: from EXMBX168.cuchost.com ([fe80::3c2d:dee5:4938:3fc4]) by
 EXMBX168.cuchost.com ([fe80::3c2d:dee5:4938:3fc4%16]) with mapi id
 15.00.1497.044; Tue, 10 Jan 2023 08:59:58 +0800
From:   JiaJie Ho <jiajie.ho@starfivetech.com>
To:     Conor Dooley <conor@kernel.org>
CC:     Olivia Mackall <olivia@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Conor Dooley <conor.dooley@microchip.com>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
Subject: RE: [PATCH v3 3/3] riscv: dts: starfive: Add TRNG node for VisionFive
 2
Thread-Topic: [PATCH v3 3/3] riscv: dts: starfive: Add TRNG node for
 VisionFive 2
Thread-Index: AQHZJEs2/69byV6q60qz9odnDfnRWq6V2l8AgAD5KdA=
Date:   Tue, 10 Jan 2023 00:59:58 +0000
Message-ID: <31f6c05b2836450d86560c3efda4abf2@EXMBX168.cuchost.com>
References: <20230109165249.110279-1-jiajie.ho@starfivetech.com>
 <20230109165249.110279-4-jiajie.ho@starfivetech.com> <Y7xWtFZO/Y7GaYRQ@spud>
In-Reply-To: <Y7xWtFZO/Y7GaYRQ@spud>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [202.190.108.220]
x-yovoleruleagent: yovoleflag
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Conor Dooley <conor@kernel.org>
> Sent: 10 January, 2023 2:02 AM
> To: JiaJie Ho <jiajie.ho@starfivetech.com>
> Cc: Olivia Mackall <olivia@selenic.com>; Herbert Xu
> <herbert@gondor.apana.org.au>; Rob Herring <robh+dt@kernel.org>;
> Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>; Emil Renner
> Berthing <kernel@esmil.dk>; Conor Dooley <conor.dooley@microchip.com>;
> linux-crypto@vger.kernel.org; devicetree@vger.kernel.org; linux-
> kernel@vger.kernel.org; linux-riscv@lists.infradead.org
> Subject: Re: [PATCH v3 3/3] riscv: dts: starfive: Add TRNG node for VisionFive
> 2
> 
> Hey folks,
> 
> On Tue, Jan 10, 2023 at 12:52:49AM +0800, Jia Jie Ho wrote:
> > Adding StarFive TRNG controller node to VisionFive 2 SoC.
> >
> > Co-developed-by: Jenny Zhang <jenny.zhang@starfivetech.com>
> > Signed-off-by: Jenny Zhang <jenny.zhang@starfivetech.com>
> > Signed-off-by: Jia Jie Ho <jiajie.ho@starfivetech.com>
> > ---
> >  arch/riscv/boot/dts/starfive/jh7110.dtsi | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/arch/riscv/boot/dts/starfive/jh7110.dtsi
> > b/arch/riscv/boot/dts/starfive/jh7110.dtsi
> > index 4ac159d79d66..3c29e0bc6246 100644
> > --- a/arch/riscv/boot/dts/starfive/jh7110.dtsi
> > +++ b/arch/riscv/boot/dts/starfive/jh7110.dtsi
> > @@ -455,5 +455,15 @@ uart5: serial@12020000 {
> >  			reg-shift = <2>;
> >  			status = "disabled";
> >  		};
> > +
> > +		rng: rng@1600c000 {
> > +			compatible = "starfive,jh7110-trng";
> > +			reg = <0x0 0x1600C000 0x0 0x4000>;
> > +			clocks = <&stgcrg JH7110_STGCLK_SEC_HCLK>,
> > +				 <&stgcrg JH7110_STGCLK_SEC_MISCAHB>;
> 
> Which clock source is this? I see syscrg and aoncrg in the v3
> devicetree:
> https://lore.kernel.org/linux-riscv/20221220011247.35560-7-
> hal.feng@starfivetech.com/
> 
> Have a missed a patchset which adds support for this particular clock
> controller? At the very least, I don't think one has reached the linux-riscv
> mailing list.
> The clock driver patchset only has aoncrg & syscrg:
> https://lore.kernel.org/linux-riscv/20221220005054.34518-1-
> hal.feng@starfivetech.com/
> 

Hi Conor,

Thanks for reviewing the patches.
Yes, the patch for stg domain hasn't been submitted yet.
In this case should I drop this patch from the series until the related patches reach the mailing list?

Thanks
,Jia Jie
