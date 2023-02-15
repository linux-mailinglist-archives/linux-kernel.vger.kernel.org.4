Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA8A5697821
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 09:27:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233919AbjBOI10 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 03:27:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233909AbjBOI1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 03:27:24 -0500
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [IPv6:2001:4b98:dc4:8::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 432A2367E8;
        Wed, 15 Feb 2023 00:27:11 -0800 (PST)
Received: (Authenticated sender: clement.leger@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id E1034240007;
        Wed, 15 Feb 2023 08:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1676449629;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2TjOYJpQY/rMAj42OkOWvcZQditWdAM0UKPzvzdp8/g=;
        b=Y01a+/BUoIPDLZROoJ7+KPPD6XkOyDZLGDR3flpg+BpXQWygnkZpyTdT1BH4hh8AanUnlq
        ymmVw+hv4tKpdXzZEw7WmFndG217Y6ErYdyoteAN6gFucuRv6mN60PrYYUogBrSc1++hqa
        WhtELk56Y6eLjuiuZOkjZq9N2L6mjLSqOJonvXr4s9DAS9i+EDK29Eq1jTsFEhH7wKmEOt
        b62akRnwg3VyAz7LOlr3+m+xhmJwFJlp8F89IlhUn4NnTExHi2TC5PtVq++fWeFBMI2ykE
        qCumpnzlF0lJ39hEoAvt9zbqiiIzD0b/OI0UYXdgvK20fsnZAFTN0clnpu2YXg==
Date:   Wed, 15 Feb 2023 09:29:33 +0100
From:   =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Herve Codina <herve.codina@bootlin.com>,
        =?UTF-8?B?TWlxdcOobA==?= Raynal <miquel.raynal@bootlin.com>,
        Milan Stevanovic <milan.stevanovic@se.com>,
        Jimmy Lalande <jimmy.lalande@se.com>,
        Pascal Eberhard <pascal.eberhard@se.com>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Gareth Williams <gareth.williams.jx@renesas.com>
Subject: Re: [PATCH v2 2/2] ARM: dts: r9a06g032: add r9a06g032-rzn1d400-eb
 board device-tree
Message-ID: <20230215092933.2f71ece0@fixe.home>
In-Reply-To: <CAMuHMdWUorkDYXZvsd-9rjwEkeJYC_FMfexZHaGYHDry=9Yjdg@mail.gmail.com>
References: <20230209133507.150571-1-clement.leger@bootlin.com>
        <20230209133507.150571-3-clement.leger@bootlin.com>
        <CAMuHMdWUorkDYXZvsd-9rjwEkeJYC_FMfexZHaGYHDry=9Yjdg@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.36; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Tue, 14 Feb 2023 17:25:14 +0100,
Geert Uytterhoeven <geert@linux-m68k.org> a =C3=A9crit :

> Hi Cl=C3=A9ment,
>=20
> CC Gareth
>=20
> On Thu, Feb 9, 2023 at 2:32 PM Cl=C3=A9ment L=C3=A9ger <clement.leger@boo=
tlin.com> wrote:
> > The EB board (Expansion board) supports both RZ/N1D and RZ-N1S. Since t=
his
> > configuration targets only the RZ/N1D, it is named r9a06g032-rzn1d400-e=
b.
> > It adds support for the 2 additional switch ports (port C and D) that a=
re
> > available on that board.
> >
> > Signed-off-by: Cl=C3=A9ment L=C3=A9ger <clement.leger@bootlin.com> =20
>=20
> Thanks for your patch!
>=20
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/r9a06g032-rzn1d400-eb.dts
> > @@ -0,0 +1,94 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Device Tree Source for the RZN1D-EB Board
> > + *
> > + * Copyright (C) 2023 Schneider-Electric
> > + *
> > + */
> > +
> > +#include "r9a06g032-rzn1d400-db.dts"
> > +
> > +/ {
> > +       model =3D "RZN1D-EB Board";
> > +       compatible =3D "renesas,rzn1d400-eb", "renesas,rzn1d400-db",
> > +                    "renesas,r9a06g032";
> > +};
> > +
> > +&mii_conv2 {
> > +       renesas,miic-input =3D <MIIC_SWITCH_PORTD>;
> > +       status =3D "okay";
> > +};
> > +
> > +&mii_conv3 {
> > +       renesas,miic-input =3D <MIIC_SWITCH_PORTC>;
> > +       status =3D "okay";
> > +};
> > +
> > +&pinctrl{
> > +       pins_eth1: pins-eth1 {
> > +               pinmux =3D <RZN1_PINMUX(12, RZN1_FUNC_CLK_ETH_MII_RGMII=
_RMII)>,
> > +                        <RZN1_PINMUX(13, RZN1_FUNC_CLK_ETH_MII_RGMII_R=
MII)>,
> > +                        <RZN1_PINMUX(14, RZN1_FUNC_CLK_ETH_MII_RGMII_R=
MII)>,
> > +                        <RZN1_PINMUX(15, RZN1_FUNC_CLK_ETH_MII_RGMII_R=
MII)>,
> > +                        <RZN1_PINMUX(16, RZN1_FUNC_CLK_ETH_MII_RGMII_R=
MII)>,
> > +                        <RZN1_PINMUX(17, RZN1_FUNC_CLK_ETH_MII_RGMII_R=
MII)>,
> > +                        <RZN1_PINMUX(18, RZN1_FUNC_CLK_ETH_MII_RGMII_R=
MII)>,
> > +                        <RZN1_PINMUX(19, RZN1_FUNC_CLK_ETH_MII_RGMII_R=
MII)>,
> > +                        <RZN1_PINMUX(20, RZN1_FUNC_CLK_ETH_MII_RGMII_R=
MII)>,
> > +                        <RZN1_PINMUX(21, RZN1_FUNC_CLK_ETH_MII_RGMII_R=
MII)>,
> > +                        <RZN1_PINMUX(22, RZN1_FUNC_CLK_ETH_MII_RGMII_R=
MII)>,
> > +                        <RZN1_PINMUX(23, RZN1_FUNC_CLK_ETH_MII_RGMII_R=
MII)>;
> > +               drive-strength =3D <6>;
> > +               bias-disable;
> > +       };
> > +
> > +       pins_eth2: pins-eth2 {
> > +               pinmux =3D <RZN1_PINMUX(24, RZN1_FUNC_CLK_ETH_MII_RGMII=
_RMII)>,
> > +                        <RZN1_PINMUX(25, RZN1_FUNC_CLK_ETH_MII_RGMII_R=
MII)>,
> > +                        <RZN1_PINMUX(26, RZN1_FUNC_CLK_ETH_MII_RGMII_R=
MII)>,
> > +                        <RZN1_PINMUX(27, RZN1_FUNC_CLK_ETH_MII_RGMII_R=
MII)>,
> > +                        <RZN1_PINMUX(28, RZN1_FUNC_CLK_ETH_MII_RGMII_R=
MII)>,
> > +                        <RZN1_PINMUX(29, RZN1_FUNC_CLK_ETH_MII_RGMII_R=
MII)>,
> > +                        <RZN1_PINMUX(30, RZN1_FUNC_CLK_ETH_MII_RGMII_R=
MII)>,
> > +                        <RZN1_PINMUX(31, RZN1_FUNC_CLK_ETH_MII_RGMII_R=
MII)>,
> > +                        <RZN1_PINMUX(32, RZN1_FUNC_CLK_ETH_MII_RGMII_R=
MII)>,
> > +                        <RZN1_PINMUX(33, RZN1_FUNC_CLK_ETH_MII_RGMII_R=
MII)>,
> > +                        <RZN1_PINMUX(34, RZN1_FUNC_CLK_ETH_MII_RGMII_R=
MII)>,
> > +                        <RZN1_PINMUX(35, RZN1_FUNC_CLK_ETH_MII_RGMII_R=
MII)>;
> > +               drive-strength =3D <6>;
> > +               bias-disable;
> > +       };
> > +};
> > +
> > +&switch {
> > +       pinctrl-names =3D "default"; =20
>=20
> No need to specify pinctrl-names, as it is inherited from
> r9a06g032-rzn1d400-db.dts.

Acked.

>=20
> > +       pinctrl-0 =3D <&pins_eth1>, <&pins_eth2>, <&pins_eth3>, <&pins_=
eth4>,
> > +                   <&pins_mdio1>;
> > +
> > +       mdio {
> > +               /* CN15 and CN16 switches must be configured in MDIO2 m=
ode */
> > +               switch0phy1: ethernet-phy@1 {
> > +                       reg =3D <1>;
> > +                       marvell,reg-init =3D <3 16 0 0x1010>; =20
>=20
> marvell,reg-init is not documented in any DT bindings document?

Indeed, this is not somethiong that should be made available here. It's
only inverting the LED polarity but supported by some internal patch.
I'll remove that.


--=20
Cl=C3=A9ment L=C3=A9ger,
Embedded Linux and Kernel engineer at Bootlin
https://bootlin.com
