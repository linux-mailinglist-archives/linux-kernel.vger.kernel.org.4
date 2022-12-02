Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D017640CD7
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 19:09:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234256AbiLBSJt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 13:09:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233664AbiLBSJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 13:09:48 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68FDDE61C1
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 10:09:47 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1p1ATh-0004rb-T6; Fri, 02 Dec 2022 19:09:37 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1p1ATc-001rI5-EU; Fri, 02 Dec 2022 19:09:33 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1p1ATc-0026R0-EL; Fri, 02 Dec 2022 19:09:32 +0100
Date:   Fri, 2 Dec 2022 19:09:32 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     krzysztof.kozlowski+dt@linaro.org, thierry.reding@gmail.com,
        robh+dt@kernel.org, matthias.bgg@gmail.com, john@phrozen.org,
        sean.wang@mediatek.com, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v1 1/2] arm64: dts: mediatek: mt7622: Add missing
 pwm-cells to pwm node
Message-ID: <20221202180932.5k3vymrwds5ssivq@pengutronix.de>
References: <20221128112028.58021-1-angelogioacchino.delregno@collabora.com>
 <20221128112028.58021-2-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dbscrtoucbjx3ah7"
Content-Disposition: inline
In-Reply-To: <20221128112028.58021-2-angelogioacchino.delregno@collabora.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dbscrtoucbjx3ah7
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 28, 2022 at 12:20:27PM +0100, AngeloGioacchino Del Regno wrote:
> Specify #pwm-cells on pwm@11006000 to make it actually usable.
>=20
> Fixes: ae457b7679c4 ("arm64: dts: mt7622: add SoC and peripheral related =
device nodes")
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>
> ---
>  arch/arm64/boot/dts/mediatek/mt7622.dtsi | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/arch/arm64/boot/dts/mediatek/mt7622.dtsi b/arch/arm64/boot/d=
ts/mediatek/mt7622.dtsi
> index 146e18b5b1f4..f321c6d0fd7c 100644
> --- a/arch/arm64/boot/dts/mediatek/mt7622.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
> @@ -435,6 +435,7 @@ uart3: serial@11005000 {
>  	pwm: pwm@11006000 {
>  		compatible =3D "mediatek,mt7622-pwm";
>  		reg =3D <0 0x11006000 0 0x1000>;
> +		#pwm-cells =3D <2>;

3 should be possible, too. The driver does only support one
polarity, so it's not really needed, but would be nice for consistency?

Thierry, what's your take here?

Other than that: Who would pick this up, I assume it to go via an ARM
tree together with the 2nd patch in this series?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--dbscrtoucbjx3ah7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmOKP1kACgkQwfwUeK3K
7AkdtQf9F9zcjUhzj6zMAal2E7Hya0b+VW7ihKDYEKL2u3cIZb0g7U42fx2UlRf0
wuHtFvUTIm1GOTBc/abeiuXLGzxXBm/J59aMlpaEIpJgbuvQTQ0yd9aGEP2EI116
2Ed9QFpv0TNTdm1vhIdPC56P4ZSE3Z574Vv5diLTJVHMHc+Y0pjxU4XniOM9ToKy
3P8UVB9OatIYfjN4PwYDMBDBojK680Y1X7OaWXCYRe0pBSL23UmQ5ZVXrcmRZiib
6nDkZJiTZRIZxnYMp8dwBei1PWgWvMuAT4vBiKGCzTGXEeqT6btQ5QyXWjwDkZ5c
KDN4UAdH/Q1+DOb+mzTaLGoigs/Mgw==
=CI4Q
-----END PGP SIGNATURE-----

--dbscrtoucbjx3ah7--
