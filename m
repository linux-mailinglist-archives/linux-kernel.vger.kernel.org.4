Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51FF0657020
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 22:55:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbiL0VzE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 16:55:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiL0VzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 16:55:02 -0500
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0997A9FED;
        Tue, 27 Dec 2022 13:55:00 -0800 (PST)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 147171C1118; Tue, 27 Dec 2022 22:54:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1672178099;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qX17hHcUB+jYPd8iDIqiM4kouAbGECKQfOhlF6n0DUQ=;
        b=TabVZH/+3/rZaw+CUZeGLt1EN5BCbKc5vqGAhCo/JjkwM4MuoL9FBqFX7ZK3rKMmFAbxrU
        Tpmzu+jtyTws57qpW7cQEL8SGCoOhdIu5xQZ9IV54r4Q21rJyMnuism98WaSUuB2g5411A
        3eUsoG6ZbC8Eh7bkB3PpgbLALWJlEuY=
Date:   Tue, 27 Dec 2022 22:54:58 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH] arm64: dts: imx8mm-evk: update leds node
Message-ID: <Y6tpsmziu7V2T0fq@duo.ucw.cz>
References: <20221223030227.16784-1-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="1873fZsFTo+NUenC"
Content-Disposition: inline
In-Reply-To: <20221223030227.16784-1-peng.fan@oss.nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--1873fZsFTo+NUenC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2022-12-23 11:02:27, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
>=20
> Drop deprecated label property, update node name as leds-gpio.yaml
>=20
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi b/arch/arm64/b=
oot/dts/freescale/imx8mm-evk.dtsi
> index e0b604ac0da4..0f87991dcb57 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
> @@ -24,8 +24,7 @@ leds {
>  		pinctrl-names =3D "default";
>  		pinctrl-0 =3D <&pinctrl_gpio_led>;
> =20
> -		status {
> -			label =3D "status";
> +		led-0 {
>  			gpios =3D <&gpio3 16 GPIO_ACTIVE_HIGH>;
>  			default-state =3D "on";
>  		};

Please cc led lists on led changes.

And don't do this, this will change userland interface.
								Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--1873fZsFTo+NUenC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCY6tpsgAKCRAw5/Bqldv6
8s3fAKCiX2rkFGFNHgV91j2Ybwz5pGRsUwCeODnMzOp1tgTs9l47WnbvsJ3y5u4=
=DaBO
-----END PGP SIGNATURE-----

--1873fZsFTo+NUenC--
