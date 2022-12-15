Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 688E364DC92
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 14:57:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbiLON5R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 08:57:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbiLON5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 08:57:03 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B64B2EF01;
        Thu, 15 Dec 2022 05:57:00 -0800 (PST)
Received: from mercury (dyndsl-095-033-168-084.ewe-ip-backbone.de [95.33.168.84])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 91BD56602C62;
        Thu, 15 Dec 2022 13:56:58 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1671112618;
        bh=mdJcX9ohpfURm3zLoo8qqwZEUEZs5x+hskpxfmea/yo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SC6f7YjaHlSh4nq+zNhpE9lrPycjodkqZZkHffrXkSSSnQerET9Y2BncCaZPi/gld
         ED5ks6MnCLB1z1d7/o0W/1l6Jw+UqMz9cKm2bwO13cLebomGUgAAQeIXkJyE/BL3h+
         IBRODJh1faQBEPRV53IO8pO4lEfB7Mr5T2ov9qjvv1ZAvTQ7KHZPNHVE4WtW8+fQd5
         VYI3x3KNXZlV3URDo2c5w3iQSVKioGECKR6/ewTOwtyL45BAF7U2XRjbdTC63Zul9+
         LZ+fjrtjkLHak302/5aLSrGNA4p/MjANAv1OzwbXjl+EayoTCVMlIJ3uWvpDyjFMXL
         g9IEMKLfeBlDA==
Received: by mercury (Postfix, from userid 1000)
        id 17D961060F45; Thu, 15 Dec 2022 14:56:56 +0100 (CET)
Date:   Thu, 15 Dec 2022 14:56:56 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Jagan Teki <jagan@edgeble.ai>
Cc:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Christopher Obbard <chris.obbard@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kever Yang <kever.yang@rock-chips.com>, kernel@collabora.com,
        Michael Riesch <michael.riesch@wolfvision.net>
Subject: Re: [PATCHv6 5/7] arm64: dts: rockchip: Add rk3588-evb1 board
Message-ID: <20221215135656.nqngwqwaprlzf2f7@mercury.elektranox.org>
References: <20221214182247.79824-1-sebastian.reichel@collabora.com>
 <20221214182247.79824-6-sebastian.reichel@collabora.com>
 <CA+VMnFwT+Gi1nFBG2NDyMYx8wv+FrwzR8tb_8RrFh6QMGK8Q6g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="voeg7cbvslfv7tvk"
Content-Disposition: inline
In-Reply-To: <CA+VMnFwT+Gi1nFBG2NDyMYx8wv+FrwzR8tb_8RrFh6QMGK8Q6g@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--voeg7cbvslfv7tvk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jagan,

On Thu, Dec 15, 2022 at 06:37:10PM +0530, Jagan Teki wrote:
> On Wed, 14 Dec 2022 at 23:53, Sebastian Reichel
> <sebastian.reichel@collabora.com> wrote:
> > From: Kever Yang <kever.yang@rock-chips.com>
> >
> > Add board file for the RK3588 evaluation board. While the hardware
> > offers plenty of peripherals and connectivity this basic implementation
> > just handles things required to successfully boot Linux from eMMC,
> > connect via UART or Ethernet.
> >
> > Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
> > [rebase, update commit message, use EVB1 for SoC bringup]
> > Reviewed-by: Michael Riesch <michael.riesch@wolfvision.net>
> > Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> > ---
> >  arch/arm64/boot/dts/rockchip/Makefile         |   1 +
> >  .../boot/dts/rockchip/rk3588-evb1-v10.dts     | 165 ++++++++++++++++++
> >  2 files changed, 166 insertions(+)
> >  create mode 100644 arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dts
> >
> > diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dt=
s/rockchip/Makefile
> > index 8c15593c0ca4..12ed53de11eb 100644
> > --- a/arch/arm64/boot/dts/rockchip/Makefile
> > +++ b/arch/arm64/boot/dts/rockchip/Makefile
> > @@ -72,3 +72,4 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3566-soquartz-cm4.=
dtb
> >  dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3568-bpi-r2-pro.dtb
> >  dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3568-evb1-v10.dtb
> >  dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3568-rock-3a.dtb
> > +dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3588-evb1-v10.dtb
> > diff --git a/arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dts b/arch/ar=
m64/boot/dts/rockchip/rk3588-evb1-v10.dts
> > new file mode 100644
> > index 000000000000..46ea2daf5d6e
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dts
> > @@ -0,0 +1,165 @@
> > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > +/*
> > + * Copyright (c) 2021 Rockchip Electronics Co., Ltd.
> > + *
> > + */
> > +
> > +/dts-v1/;
> > +
> > +#include <dt-bindings/gpio/gpio.h>
> > +#include <dt-bindings/pinctrl/rockchip.h>
> > +#include "rk3588.dtsi"
> > +
> > +/ {
> > +       model =3D "Rockchip RK3588 EVB1 V10 Board";
> > +       compatible =3D "rockchip,rk3588-evb1-v10", "rockchip,rk3588";
> > +
> > +       aliases {
> > +               mmc0 =3D &sdhci;
> > +               serial2 =3D &uart2;
> > +       };
> > +
> > +       chosen {
> > +               stdout-path =3D "serial2:1500000n8";
> > +       };
> > +
> > +       backlight: backlight {
> > +               compatible =3D "pwm-backlight";
> > +               brightness-levels =3D <
> > +                         0  20  20  21  21  22  22  23
> > +                        23  24  24  25  25  26  26  27
> > +                        27  28  28  29  29  30  30  31
> > +                        31  32  32  33  33  34  34  35
> > +                        35  36  36  37  37  38  38  39
> > +                        40  41  42  43  44  45  46  47
> > +                        48  49  50  51  52  53  54  55
> > +                        56  57  58  59  60  61  62  63
> > +                        64  65  66  67  68  69  70  71
> > +                        72  73  74  75  76  77  78  79
> > +                        80  81  82  83  84  85  86  87
> > +                        88  89  90  91  92  93  94  95
> > +                        96  97  98  99 100 101 102 103
> > +                       104 105 106 107 108 109 110 111
> > +                       112 113 114 115 116 117 118 119
> > +                       120 121 122 123 124 125 126 127
> > +                       128 129 130 131 132 133 134 135
> > +                       136 137 138 139 140 141 142 143
> > +                       144 145 146 147 148 149 150 151
> > +                       152 153 154 155 156 157 158 159
> > +                       160 161 162 163 164 165 166 167
> > +                       168 169 170 171 172 173 174 175
> > +                       176 177 178 179 180 181 182 183
> > +                       184 185 186 187 188 189 190 191
> > +                       192 193 194 195 196 197 198 199
> > +                       200 201 202 203 204 205 206 207
> > +                       208 209 210 211 212 213 214 215
> > +                       216 217 218 219 220 221 222 223
> > +                       224 225 226 227 228 229 230 231
> > +                       232 233 234 235 236 237 238 239
> > +                       240 241 242 243 244 245 246 247
> > +                       248 249 250 251 252 253 254 255
> > +               >;
> > +               default-brightness-level =3D <200>;
> > +
> > +               pwms =3D <&pwm2 0 25000 0>;
> > +               power-supply =3D <&vcc12v_dcin>;
> > +       };
>=20
> Do we really need this now? and brightness-levels need not be required
> to mention all.

It's my PWM test case, but removing brightness-levels and
default-brightness-level sounds fine to me. This can be
added once there is display support.

-- Sebastian

--voeg7cbvslfv7tvk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmObJ5oACgkQ2O7X88g7
+poFsQ//dxEdirNYDPmZMuVM+0mLL9jxNcUGejSGkS0CM7wZ52MA7QdqOGX3/os1
j9VLVl8MZRaqThguWYREI7FHfziCFjtBkJFv7NTkEGwhQJZrFRc0vnBXEH5hzzz4
D4STov6YVKHM/tHDfUMdjoKNk5UkVtbPw9uZocPGjtzLECK7BX+Y56UaIH3J5EYg
z8Sm0/zszX2Mn939Dqa/k1D6gqme7lwuMxT5TWU7nj80x/JG3NcBNom4ospF3G6q
JW0PwSNK3bVPRed6ajsTXFQuHUpqTMYndhG6kOtkiXxdo0WcCL+b9W4A/CNRNbjI
PsziGgYoHZsQ3lkl5mJO9MiyuRJiwARL0Qtv/EaaQrZI8ENF1+ts9vbnhNZ3adKA
XWXaoYawGHpyULC9wRNZqP/QGbucGULh3kyn23lMe9X92QrNIMkMHwyC+rOQHvxK
pqlvvChO8xCDdhJqUzsJWHPGbXWPBYJUVmgGaqB4wXlZF+tOO06CfAhr9ATS8/au
oImlMwl/3xGcgmPtbnRqlrs5iwGuwYpzkVPi+b/4qbT6mNQBLLBE2TQnNYoTc2wF
gUm6QsXRKhX+VIUgEHo5ILo+uQF+2oimTLGYPXT3ytqJ9ZqgL9/svWBUnkIlzqET
NIr7ZRJEs7hYxULo/OFHfTHFUl8EoJEZ20Tuc8zd/5vOA8BTXLs=
=rThP
-----END PGP SIGNATURE-----

--voeg7cbvslfv7tvk--
