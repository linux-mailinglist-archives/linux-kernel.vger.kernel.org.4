Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A90EF697A88
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 12:17:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232815AbjBOLRM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 06:17:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232804AbjBOLRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 06:17:09 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E78C367E5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 03:17:08 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pSFmQ-0008OF-9D; Wed, 15 Feb 2023 12:16:54 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pSFmO-0055zx-Bq; Wed, 15 Feb 2023 12:16:53 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pSFmO-003jc6-LK; Wed, 15 Feb 2023 12:16:52 +0100
Date:   Wed, 15 Feb 2023 12:16:52 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Sasha Finkelstein <fnkl.kernel@gmail.com>
Cc:     thierry.reding@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, marcan@marcan.st,
        sven@svenpeter.dev, alyssa@rosenzweig.io, asahi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 3/5] arm64: dts: apple: t8103: Add PWM controller
Message-ID: <20230215111652.lyhebfntqlibtmex@pengutronix.de>
References: <20230114132508.96600-1-fnkl.kernel@gmail.com>
 <20230114132508.96600-4-fnkl.kernel@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6p3sxojse4xv3o5l"
Content-Disposition: inline
In-Reply-To: <20230114132508.96600-4-fnkl.kernel@gmail.com>
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


--6p3sxojse4xv3o5l
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 14, 2023 at 04:25:06PM +0300, Sasha Finkelstein wrote:
> Adds PWM controller and keyboard backlight bindings for M1 MacBooks
>=20
> Signed-off-by: Sasha Finkelstein <fnkl.kernel@gmail.com>
> Acked-by: Sven Peter <sven@svenpeter.dev>
> ---
>  arch/arm64/boot/dts/apple/t8103-j293.dts | 17 +++++++++++++++++
>  arch/arm64/boot/dts/apple/t8103-j313.dts | 17 +++++++++++++++++
>  arch/arm64/boot/dts/apple/t8103.dtsi     |  9 +++++++++
>  3 files changed, 43 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/apple/t8103-j293.dts b/arch/arm64/boot/d=
ts/apple/t8103-j293.dts
> index 151074109a11..7381dccc1613 100644
> --- a/arch/arm64/boot/dts/apple/t8103-j293.dts
> +++ b/arch/arm64/boot/dts/apple/t8103-j293.dts
> @@ -11,10 +11,23 @@
> =20
>  #include "t8103.dtsi"
>  #include "t8103-jxxx.dtsi"
> +#include <dt-bindings/leds/common.h>
> =20
>  / {
>  	compatible =3D "apple,j293", "apple,t8103", "apple,arm-platform";
>  	model =3D "Apple MacBook Pro (13-inch, M1, 2020)";
> +
> +	led-controller {
> +		compatible =3D "pwm-leds";
> +		led-0 {
> +			pwms =3D <&fpwm1 0 40000>;
> +			label =3D "kbd_backlight";
> +			function =3D LED_FUNCTION_KBD_BACKLIGHT;
> +			color =3D <LED_COLOR_ID_WHITE>;
> +			max-brightness =3D <255>;
> +			default-state =3D "keep";
> +		};
> +	};
>  };
> =20
>  &bluetooth0 {
> @@ -47,3 +60,7 @@ &i2c2 {
>  &i2c4 {
>  	status =3D "okay";
>  };
> +
> +&fpwm1 {
> +	status =3D "okay";
> +};
> \ No newline at end of file

This missing newline looks wrong.

Otherwise the patch looks fine to me.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--6p3sxojse4xv3o5l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmPsvyEACgkQwfwUeK3K
7AkOlwf/U3bq2lMyN/O90iDAvjsqHfCLHm3TVOgn4ERdvjgeJ2DxZT1OoblzvJSL
u+asOEpsEjWrC0+vObmNUdRrZhMzlsLNd64rQyaKVVa6coBE9Ku2LUymxZdEj54N
HJjfEvXWtKwWEWVOxyVFx3IlcI5tlMVQ+mR+cdP0rg7G7wnBNbv968QY9q3Y6o4w
PWI+KqYQkgcROrKlkn3Bh9q0WfeKVALU+gOauRW4A9l25zPNed86MqeUUQVNcbDW
PAmMOnmrpMpzbPJZUXgaGUGsbf/copkFDvg8F53gIBx/r3D5gfYKT4b6CMHRQiPR
VDTyV6oFsFGcIPBMZeejjj+juTXEjg==
=Wc+G
-----END PGP SIGNATURE-----

--6p3sxojse4xv3o5l--
