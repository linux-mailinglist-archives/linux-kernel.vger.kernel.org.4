Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E498064EEAD
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 17:11:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231364AbiLPQLn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 11:11:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231370AbiLPQKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 11:10:48 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B6A42EF2B;
        Fri, 16 Dec 2022 08:10:23 -0800 (PST)
Received: from mercury (dyndsl-095-033-168-084.ewe-ip-backbone.de [95.33.168.84])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 219466602C8B;
        Fri, 16 Dec 2022 16:10:22 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1671207022;
        bh=o4asnBNMNldi0GAOXTX9gpzPOFWRzzLDqEYDqvmLRnE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LY3IQ2HVNIM9vdRzIu9dDdiibe0qTBCHpstWGj6ZToHtkNa5u1Ts8CBAZMschlOR7
         Y8GGcx+hSa49b9aSqMte+UVc02vt717giWMnuFHiSBnCAxP5qg9zn0wWFZoz0gCgRa
         SxwxIiqpeGkoKBGUSbonL+w976yS8yi0zNZbjJKTjyDEOLIfYrqCM6PQb7Y941Jwq6
         FIuRVXa/v38BvpI1qd9zBAS1QYfXQJAxkzGE2Okni8CZq5js68scOZWbVYPdXp2A5u
         +8clcsSGbOkDAOQ9feAU8mtBP2+A4i4UWfBu+Qwm9RlPMBNSN+ynm2ykPbrhAoEpwL
         taNbY8nBPoblQ==
Received: by mercury (Postfix, from userid 1000)
        id 29B391060F45; Fri, 16 Dec 2022 17:10:20 +0100 (CET)
Date:   Fri, 16 Dec 2022 17:10:20 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Nicolas Dufresne <nicolas.dufresne@collabora.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marc Zyngier <maz@kernel.org>, Jagan Teki <jagan@edgeble.ai>,
        Linus Walleij <linus.walleij@linaro.org>,
        Christopher Obbard <chris.obbard@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        Michael Riesch <michael.riesch@wolfvision.net>
Subject: Re: [PATCHv7 7/7] arm64: dts: rockchip: Add rock-5b board
Message-ID: <20221216161020.pih47wezxwpinnoo@mercury.elektranox.org>
References: <20221215183002.211081-1-sebastian.reichel@collabora.com>
 <20221215183002.211081-8-sebastian.reichel@collabora.com>
 <e3c73d1c20e12ab351a74ef1abc949810fc1ba77.camel@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uizst23pjx7zvr6t"
Content-Disposition: inline
In-Reply-To: <e3c73d1c20e12ab351a74ef1abc949810fc1ba77.camel@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--uizst23pjx7zvr6t
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Nicolas,

On Fri, Dec 16, 2022 at 10:47:44AM -0500, Nicolas Dufresne wrote:
> Hi Sebastian and Christopher,
>=20
> Le jeudi 15 d=E9cembre 2022 =E0 19:30 +0100, Sebastian Reichel a =E9crit=
=A0:
> > From: Christopher Obbard <chris.obbard@collabora.com>
> >=20
> > Add board file for the RK3588 Rock 5B board. This is a basic
> > implementation which just brings up the eMMC and UART which is
> > enough to successfully boot Linux.
> >=20
> > The ethernet controller is connected via PCIe so support will
> > come in a follow-up patch.
> >=20
> > Signed-off-by: Christopher Obbard <chris.obbard@collabora.com>
> > Reviewed-by: Michael Riesch <michael.riesch@wolfvision.net>
> > Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> > ---
> >  arch/arm64/boot/dts/rockchip/Makefile         |  1 +
> >  .../boot/dts/rockchip/rk3588-rock-5b.dts      | 44 +++++++++++++++++++
> >  2 files changed, 45 insertions(+)
> >  create mode 100644 arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
> >=20
> > diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dt=
s/rockchip/Makefile
> > index 87a853435142..c5bdd0176ce0 100644
> > --- a/arch/arm64/boot/dts/rockchip/Makefile
> > +++ b/arch/arm64/boot/dts/rockchip/Makefile
> > @@ -83,4 +83,5 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3568-evb1-v10.dtb
> >  dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3568-odroid-m1.dtb
> >  dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3568-rock-3a.dtb
> >  dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3588-evb1-v10.dtb
> > +dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3588-rock-5b.dtb
> >  dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3588s-rock-5a.dtb
> > diff --git a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts b/arch/arm=
64/boot/dts/rockchip/rk3588-rock-5b.dts
> > new file mode 100644
> > index 000000000000..baf46bd30b38
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
> > @@ -0,0 +1,44 @@
> > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > +
> > +/dts-v1/;
> > +
> > +#include "rk3588.dtsi"
> > +
> > +/ {
> > +	model =3D "Radxa Rock 5B Board";
> > +	compatible =3D "radxa,rock-5b", "rockchip,rk3588";
> > +
> > +	aliases {
> > +		mmc1 =3D &sdhci;
>=20
> I have no useful knowledge, but it seems the mmc alias don't match the ve=
ndor.
> When I run your branch on Rock5B, the EMMC endup on /dev/mmcblk1 (aka mmc=
1 alias
> I think) while when I boot the vendor kernel, it is always mmcblk0 (aka m=
mc0
> alias?). Perhaps the vendor didn't add aliases ?
>
> There could also be mainline rules to number based on the boot order. In =
this
> case, the difference would be acceptable, since SPL boot order is (usb?) =
> SD
> Card > EMMC > SPI NOR. Though, the SPL is picked from the opposite order =
(spi,
> emmc, sd card). Anyway, I'm just trying to express that I noticed a diffe=
rence,
> and its not guarantied to be a bug.

The public vendor tree specifies the same alias, so I expected the
vendor kernel to have the eMMC at /dev/mmcblk1:

https://github.com/radxa/kernel/blob/stable-5.10-rock5/arch/arm64/boot/dts/=
rockchip/rk3588-rock-5b.dts#L31

checking the vendor tree again, it also has a rk3588-rock-5b-v11.dts,
which does not have any aliases configured. Are you using that?

-- Sebastian

>=20
> > +		serial2 =3D &uart2;
> > +	};
> > +
> > +	chosen {
> > +		stdout-path =3D "serial2:1500000n8";
> > +	};
> > +
> > +	vcc5v0_sys: vcc5v0-sys-regulator {
> > +		compatible =3D "regulator-fixed";
> > +		regulator-name =3D "vcc5v0_sys";
> > +		regulator-always-on;
> > +		regulator-boot-on;
> > +		regulator-min-microvolt =3D <5000000>;
> > +		regulator-max-microvolt =3D <5000000>;
> > +	};
> > +};
> > +
> > +&sdhci {
> > +	bus-width =3D <8>;
> > +	no-sdio;
> > +	no-sd;
> > +	non-removable;
> > +	max-frequency =3D <200000000>;
> > +	mmc-hs400-1_8v;
> > +	mmc-hs400-enhanced-strobe;
> > +	status =3D "okay";
> > +};
> > +
> > +&uart2 {
> > +	pinctrl-0 =3D <&uart2m0_xfer>;
> > +	status =3D "okay";
> > +};
> > --=20
> > 2.39.0
> >=20
> >=20
>=20

--uizst23pjx7zvr6t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmOcmGIACgkQ2O7X88g7
+poKFBAAk/ViyvA3js9BdWAsSxBXZ/aqK/eZascewUf/suIrDZt0eARO7R8vwZo6
N32KNA6SAGcrpTu31QbqKs+98P54ICmZvZyyrXXlfkWGcdJj+f0VYwumbdtNulxj
pYL2YfZKzsHImLZDGNjkGHKC6QuPLPxNmANRYSFSWxe4lFCnwgA10kYCNCtPGv6R
Uiy6M6Ntv++0E8LPaLOPKlcykOTVYmA37oaCEQsnBODk3nf1UQzjrNQTdq4SceJ1
RKQtajtOz9q3R7O+eZfCVfy3gaLwsi/DEA8gt8OsqeQGxeBg0YtQytFGlV/gpULR
4UyDa5EAj7TOt7p0LktB0ti7iQYw2lniZjQftK2zeAK3874grSabWW/zcN+UgCm1
pzSTvX3VUIF87CVRwsjsJghvnfg/y6lxg/wwBs10kuFT1gA5O4v+VuneMuuqthB+
KxnZ/wWxZYEcWsIIuBAjvOc/DiNHK4nLvrfWaG+HfT/tNzUe0ITN90VQvQaIFFis
GrPIQJmWaVe9lBbRvcrMc+UeQ9bWK/MYaybWCZYgG5LsT88R8WSOo26QCQHbAa/6
DPD7iccK/34ROy++KfquxhKYMbDLxLVL+NM+62gdEZdHGf9FQsrsAk54iBsJeJlK
8Qw7AkNOz+I1CEu+/vXSRrH8wF01fd2v8BjJJa/mKsoYYcAogJo=
=2pu7
-----END PGP SIGNATURE-----

--uizst23pjx7zvr6t--
