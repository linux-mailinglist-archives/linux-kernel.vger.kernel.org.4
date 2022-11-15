Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30A87629A2C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 14:28:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238211AbiKON2Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 08:28:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232435AbiKON2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 08:28:03 -0500
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D75EA13E3F;
        Tue, 15 Nov 2022 05:27:59 -0800 (PST)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 54F07240009;
        Tue, 15 Nov 2022 13:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1668518878;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gX3uUI4yRv7S26wyE0a/h6eL5PlN9No1T6Sm4lRgxT4=;
        b=a2gGxnhURXutAjcZSaIEJ+6B6ocRP7jvvHklxB92MhUHBprpZnk99duO1TLAbOuZdegB2H
        BObc6a74lgAvLr5f4BXakbhTuPvnqbLuxKYH7CmFEYwRN7sFIuzj50G7sFXvXfR3hS9cv8
        vpI9e9/qcnQXrkQvvcshngMB2I2i/zcpWV2KAs2LZ07UTeIzvZv8riSxsX7YUegOjRlHst
        7w6DDV2ZU7nND6qWsFmE0gjPRi97307M2xX4foarhxZ7Nl0csbT0kiR9wDyL4J3Tv+1nWh
        uqlxWFNJz9GJtuaOwmKvD/sIiOpuTiQMerdrSzzIy4E2PHQ/zOYFk5IVY6/v1Q==
Date:   Tue, 15 Nov 2022 14:27:54 +0100
From:   Herve Codina <herve.codina@bootlin.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Gareth Williams <gareth.williams.jx@renesas.com>,
        linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH v2 6/7] ARM: dts: r9a06g032: Add the USBF controller
 node
Message-ID: <20221115142754.6253881b@bootlin.com>
In-Reply-To: <51d42fc2-0492-9077-302d-5c3be4b45cd1@linaro.org>
References: <20221114111513.1436165-1-herve.codina@bootlin.com>
        <20221114111513.1436165-7-herve.codina@bootlin.com>
        <51d42fc2-0492-9077-302d-5c3be4b45cd1@linaro.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Tue, 15 Nov 2022 14:16:27 +0100
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> On 14/11/2022 12:15, Herve Codina wrote:
> > Add the USBF controller available in the r9a06g032 SoC.
> >=20
> > Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> > ---
> >  arch/arm/boot/dts/r9a06g032.dtsi | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> >=20
> > diff --git a/arch/arm/boot/dts/r9a06g032.dtsi b/arch/arm/boot/dts/r9a06=
g032.dtsi
> > index 563024c9a4ae..a4bb069457a3 100644
> > --- a/arch/arm/boot/dts/r9a06g032.dtsi
> > +++ b/arch/arm/boot/dts/r9a06g032.dtsi
> > @@ -117,6 +117,18 @@ dmamux: dma-router@a0 {
> >  			};
> >  		};
> > =20
> > +		udc: usb@4001e000 {
> > +			compatible =3D "renesas,r9a06g032-usbf", "renesas,rzn1-usbf";
> > +			reg =3D <0x4001e000 0x2000>;
> > +			interrupts =3D <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>,
> > +				     <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>;
> > +			clocks =3D <&sysctrl R9A06G032_HCLK_USBF>,
> > +				 <&sysctrl R9A06G032_HCLK_USBPM>;
> > +			clock-names =3D "hclkf", "hclkpm";
> > +			power-domains =3D <&sysctrl>;
> > +			status =3D "disabled"; =20
>=20
> If you provided all resources (clocks, power domains etc), why disabling =
it?

Because I forgot to remove the 'status' property ...
'status' will be simply removed in v3.
Sorry for this mistake.

Thanks for the review,
Herv=C3=A9


--=20
Herv=C3=A9 Codina, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
