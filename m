Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A99E697A3B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 11:52:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234209AbjBOKwT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 05:52:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230500AbjBOKwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 05:52:16 -0500
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 194E520D13;
        Wed, 15 Feb 2023 02:52:14 -0800 (PST)
Received: (Authenticated sender: clement.leger@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id D048F1BF205;
        Wed, 15 Feb 2023 10:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1676458333;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hb2se20acyhll/dfbhOm4RHwsJa673hBX+v8MxUBBL4=;
        b=iu5pUOqFNCvo1BTqFUMPc2RT9O408/qSQnskYDM9y6IEHt3h81EhIpAhPS/7YxvnskVDid
        RS15A2zYW7dD+wxTvneV7v6SSy5ZFb0/4NKFzFuXGyP9Nx7y3q3so3lhRKQMYazWzFORca
        WrnSYpGEhLiEvS6MgQBh8djTef4UqxDqKCf+bSGL/s+H0yeV3Wh7iRtFO3djceMQbXxXKf
        SwLo1HRDCVdrZvu1/Vn34dQgIBZHp3szmnXT78sMTvjDyVE88eTAiVvrzto+gnJYZKogzb
        cZabCi2KUq3vIVv5Lw2keOoHGPE8FBO/nfA7X49PaiJRQIxDz4NaySeeo+DWKQ==
Date:   Wed, 15 Feb 2023 11:54:41 +0100
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
Message-ID: <20230215115441.361aed53@fixe.home>
In-Reply-To: <20230215092933.2f71ece0@fixe.home>
References: <20230209133507.150571-1-clement.leger@bootlin.com>
        <20230209133507.150571-3-clement.leger@bootlin.com>
        <CAMuHMdWUorkDYXZvsd-9rjwEkeJYC_FMfexZHaGYHDry=9Yjdg@mail.gmail.com>
        <20230215092933.2f71ece0@fixe.home>
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

Le Wed, 15 Feb 2023 09:29:33 +0100,
Cl=C3=A9ment L=C3=A9ger <clement.leger@bootlin.com> a =C3=A9crit :

> Le Tue, 14 Feb 2023 17:25:14 +0100,
> Geert Uytterhoeven <geert@linux-m68k.org> a =C3=A9crit :
>=20
> > Hi Cl=C3=A9ment,
> >=20
> > CC Gareth
> >=20
> > On Thu, Feb 9, 2023 at 2:32 PM Cl=C3=A9ment L=C3=A9ger <clement.leger@b=
ootlin.com> wrote: =20
> > > The EB board (Expansion board) supports both RZ/N1D and RZ-N1S. Since=
 this
> > > configuration targets only the RZ/N1D, it is named r9a06g032-rzn1d400=
-eb.
> > > It adds support for the 2 additional switch ports (port C and D) that=
 are
> > > available on that board.
> > >
> > > Signed-off-by: Cl=C3=A9ment L=C3=A9ger <clement.leger@bootlin.com>   =
=20
> >=20
> > Thanks for your patch!
> >  =20
> > > --- /dev/null
> > > +++ b/arch/arm/boot/dts/r9a06g032-rzn1d400-eb.dts
> > > @@ -0,0 +1,94 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * Device Tree Source for the RZN1D-EB Board
> > > + *
> > > + * Copyright (C) 2023 Schneider-Electric
> > > + *
> > > + */
> > > +
> > > +#include "r9a06g032-rzn1d400-db.dts"
> > > +
> > > +/ {
> > > +       model =3D "RZN1D-EB Board";
> > > +       compatible =3D "renesas,rzn1d400-eb", "renesas,rzn1d400-db",
> > > +                    "renesas,r9a06g032";
> > > +};
> > > +
> > > +&mii_conv2 {
> > > +       renesas,miic-input =3D <MIIC_SWITCH_PORTD>;
> > > +       status =3D "okay";
> > > +};
> > > +
> > > +&mii_conv3 {
> > > +       renesas,miic-input =3D <MIIC_SWITCH_PORTC>;
> > > +       status =3D "okay";
> > > +};
> > > +
> > > +&pinctrl{
> > > +       pins_eth1: pins-eth1 {
> > > +               pinmux =3D <RZN1_PINMUX(12, RZN1_FUNC_CLK_ETH_MII_RGM=
II_RMII)>,
> > > +                        <RZN1_PINMUX(13, RZN1_FUNC_CLK_ETH_MII_RGMII=
_RMII)>,
> > > +                        <RZN1_PINMUX(14, RZN1_FUNC_CLK_ETH_MII_RGMII=
_RMII)>,
> > > +                        <RZN1_PINMUX(15, RZN1_FUNC_CLK_ETH_MII_RGMII=
_RMII)>,
> > > +                        <RZN1_PINMUX(16, RZN1_FUNC_CLK_ETH_MII_RGMII=
_RMII)>,
> > > +                        <RZN1_PINMUX(17, RZN1_FUNC_CLK_ETH_MII_RGMII=
_RMII)>,
> > > +                        <RZN1_PINMUX(18, RZN1_FUNC_CLK_ETH_MII_RGMII=
_RMII)>,
> > > +                        <RZN1_PINMUX(19, RZN1_FUNC_CLK_ETH_MII_RGMII=
_RMII)>,
> > > +                        <RZN1_PINMUX(20, RZN1_FUNC_CLK_ETH_MII_RGMII=
_RMII)>,
> > > +                        <RZN1_PINMUX(21, RZN1_FUNC_CLK_ETH_MII_RGMII=
_RMII)>,
> > > +                        <RZN1_PINMUX(22, RZN1_FUNC_CLK_ETH_MII_RGMII=
_RMII)>,
> > > +                        <RZN1_PINMUX(23, RZN1_FUNC_CLK_ETH_MII_RGMII=
_RMII)>;
> > > +               drive-strength =3D <6>;
> > > +               bias-disable;
> > > +       };
> > > +
> > > +       pins_eth2: pins-eth2 {
> > > +               pinmux =3D <RZN1_PINMUX(24, RZN1_FUNC_CLK_ETH_MII_RGM=
II_RMII)>,
> > > +                        <RZN1_PINMUX(25, RZN1_FUNC_CLK_ETH_MII_RGMII=
_RMII)>,
> > > +                        <RZN1_PINMUX(26, RZN1_FUNC_CLK_ETH_MII_RGMII=
_RMII)>,
> > > +                        <RZN1_PINMUX(27, RZN1_FUNC_CLK_ETH_MII_RGMII=
_RMII)>,
> > > +                        <RZN1_PINMUX(28, RZN1_FUNC_CLK_ETH_MII_RGMII=
_RMII)>,
> > > +                        <RZN1_PINMUX(29, RZN1_FUNC_CLK_ETH_MII_RGMII=
_RMII)>,
> > > +                        <RZN1_PINMUX(30, RZN1_FUNC_CLK_ETH_MII_RGMII=
_RMII)>,
> > > +                        <RZN1_PINMUX(31, RZN1_FUNC_CLK_ETH_MII_RGMII=
_RMII)>,
> > > +                        <RZN1_PINMUX(32, RZN1_FUNC_CLK_ETH_MII_RGMII=
_RMII)>,
> > > +                        <RZN1_PINMUX(33, RZN1_FUNC_CLK_ETH_MII_RGMII=
_RMII)>,
> > > +                        <RZN1_PINMUX(34, RZN1_FUNC_CLK_ETH_MII_RGMII=
_RMII)>,
> > > +                        <RZN1_PINMUX(35, RZN1_FUNC_CLK_ETH_MII_RGMII=
_RMII)>;
> > > +               drive-strength =3D <6>;
> > > +               bias-disable;
> > > +       };
> > > +};
> > > +
> > > +&switch {
> > > +       pinctrl-names =3D "default";   =20
> >=20
> > No need to specify pinctrl-names, as it is inherited from
> > r9a06g032-rzn1d400-db.dts. =20
>=20
> Acked.
>=20
> >  =20
> > > +       pinctrl-0 =3D <&pins_eth1>, <&pins_eth2>, <&pins_eth3>, <&pin=
s_eth4>,
> > > +                   <&pins_mdio1>;
> > > +
> > > +       mdio {
> > > +               /* CN15 and CN16 switches must be configured in MDIO2=
 mode */
> > > +               switch0phy1: ethernet-phy@1 {
> > > +                       reg =3D <1>;
> > > +                       marvell,reg-init =3D <3 16 0 0x1010>;   =20
> >=20
> > marvell,reg-init is not documented in any DT bindings document? =20
>=20
> Indeed, this is not somethiong that should be made available here. It's
> only inverting the LED polarity but supported by some internal patch.
> I'll remove that.
>=20

Hi Geert,

I actually was confused by a property I added in another device-tree but
marvell,reg-init exists, is handled by the marvell phy driver and used
in a few device-trees. Strangely, it is not documented anywhere. So I
can either remove that (and the LED won't work properly) or let it live
depending on what you prefer.

--=20
Cl=C3=A9ment L=C3=A9ger,
Embedded Linux and Kernel engineer at Bootlin
https://bootlin.com
