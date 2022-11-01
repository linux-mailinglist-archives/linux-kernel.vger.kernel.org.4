Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00C7D614210
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 01:04:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbiKAAEI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 20:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbiKAAEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 20:04:06 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17DF312ADA;
        Mon, 31 Oct 2022 17:04:05 -0700 (PDT)
Received: from mercury (unknown [185.209.196.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id DD80066015AC;
        Tue,  1 Nov 2022 00:04:03 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1667261044;
        bh=c8luehn3JNw/okBNCPU4pxouXywmL0C2G4fDqzprF7o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hIqudi6LOEcq8cMbE7st8E8jQ/UVvo2L0iO4UM6FKauTEqe9Ir58W9ayUYRkeO8xo
         5Jjm0Ed1lEPDR9zG5TrbqTMYOwvEER5PEl7uwM9mCr3efgqIA3KIc0Ksp+vr3PE7/K
         Ap8dMLFlzGoZwDuEJccCplfZ4EZ14NjLjdo5d4iPC7x4Dz2z5EWOKJArYZ2e1dg+z+
         b9cIHGX616mKlEjFOfpJLBd9Y11KxRzT4T1nKKH78NoDhiTHmWbbOnIHxQb3prGAsV
         A8QxixAkgYMCsWsM6+cXpZ5bcdjeBKS8CjEv6jfuXRFZ3LiJLGlZFuCHUd861VBWdc
         y1e9Lyvarj76A==
Received: by mercury (Postfix, from userid 1000)
        id 1CF8C1061C6F; Tue,  1 Nov 2022 01:04:01 +0100 (CET)
Date:   Tue, 1 Nov 2022 01:04:01 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] power: supply: bd99954: Use LINEAR_RANGE()
Message-ID: <20221101000401.kkfkbeh5vp3id4hj@mercury.elektranox.org>
References: <Y1969f7YRxBodeHf@dc75zzyyyyyyyyyyyyyby-3.rev.dnainternet.fi>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ppgnnw5oqsrss3jn"
Content-Disposition: inline
In-Reply-To: <Y1969f7YRxBodeHf@dc75zzyyyyyyyyyyyyyby-3.rev.dnainternet.fi>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ppgnnw5oqsrss3jn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Oct 31, 2022 at 09:36:21AM +0200, Matti Vaittinen wrote:
> Do minor clean-up by using newly inroduced LINEAR_RANGE() initialization
> macro.
>=20
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/supply/bd99954-charger.c | 84 ++++----------------------
>  1 file changed, 13 insertions(+), 71 deletions(-)
>=20
> diff --git a/drivers/power/supply/bd99954-charger.c b/drivers/power/suppl=
y/bd99954-charger.c
> index 96e93e1b8094..250362e15c98 100644
> --- a/drivers/power/supply/bd99954-charger.c
> +++ b/drivers/power/supply/bd99954-charger.c
> @@ -768,27 +768,13 @@ static const struct power_supply_desc bd9995x_power=
_supply_desc =3D {
>   * Describe the setting in linear_range table.
>   */
>  static const struct linear_range input_current_limit_ranges[] =3D {
> -	{
> -		.min =3D 0,
> -		.step =3D 32000,
> -		.min_sel =3D 0x0,
> -		.max_sel =3D 0x1ff,
> -	},
> +	LINEAR_RANGE(0, 0x0, 0x1ff, 32000),
>  };
> =20
>  /* Possible trickle, pre-charging and termination current values */
>  static const struct linear_range charging_current_ranges[] =3D {
> -	{
> -		.min =3D 0,
> -		.step =3D 64000,
> -		.min_sel =3D 0x0,
> -		.max_sel =3D 0x10,
> -	}, {
> -		.min =3D 1024000,
> -		.step =3D 0,
> -		.min_sel =3D 0x11,
> -		.max_sel =3D 0x1f,
> -	},
> +	LINEAR_RANGE(0, 0x0, 0x10, 64000),
> +	LINEAR_RANGE(1024000, 0x11, 0x1f, 0),
>  };
> =20
>  /*
> @@ -796,72 +782,28 @@ static const struct linear_range charging_current_r=
anges[] =3D {
>   * and battery over voltage protection have same possible values
>   */
>  static const struct linear_range charge_voltage_regulation_ranges[] =3D {
> -	{
> -		.min =3D 2560000,
> -		.step =3D 0,
> -		.min_sel =3D 0,
> -		.max_sel =3D 0xA0,
> -	}, {
> -		.min =3D 2560000,
> -		.step =3D 16000,
> -		.min_sel =3D 0xA0,
> -		.max_sel =3D 0x4B0,
> -	}, {
> -		.min =3D 19200000,
> -		.step =3D 0,
> -		.min_sel =3D 0x4B0,
> -		.max_sel =3D 0x7FF,
> -	},
> +	LINEAR_RANGE(2560000, 0, 0xA0, 0),
> +	LINEAR_RANGE(2560000, 0xA0, 0x4B0, 16000),
> +	LINEAR_RANGE(19200000, 0x4B0, 0x7FF, 0),
>  };
> =20
>  /* Possible VSYS voltage regulation values */
>  static const struct linear_range vsys_voltage_regulation_ranges[] =3D {
> -	{
> -		.min =3D 2560000,
> -		.step =3D 0,
> -		.min_sel =3D 0,
> -		.max_sel =3D 0x28,
> -	}, {
> -		.min =3D 2560000,
> -		.step =3D 64000,
> -		.min_sel =3D 0x28,
> -		.max_sel =3D 0x12C,
> -	}, {
> -		.min =3D 19200000,
> -		.step =3D 0,
> -		.min_sel =3D 0x12C,
> -		.max_sel =3D 0x1FF,
> -	},
> +	LINEAR_RANGE(2560000, 0, 0x28, 0),
> +	LINEAR_RANGE(2560000, 0x28, 0x12C, 64000),
> +	LINEAR_RANGE(19200000, 0x12C, 0x1FF, 0),
>  };
> =20
>  /* Possible settings for switching from trickle to pre-charging limits */
>  static const struct linear_range trickle_to_pre_threshold_ranges[] =3D {
> -	{
> -		.min =3D 2048000,
> -		.step =3D 0,
> -		.min_sel =3D 0,
> -		.max_sel =3D 0x20,
> -	}, {
> -		.min =3D 2048000,
> -		.step =3D 64000,
> -		.min_sel =3D 0x20,
> -		.max_sel =3D 0x12C,
> -	}, {
> -		.min =3D 19200000,
> -		.step =3D 0,
> -		.min_sel =3D 0x12C,
> -		.max_sel =3D 0x1FF
> -	}
> +	LINEAR_RANGE(2048000, 0, 0x20, 0),
> +	LINEAR_RANGE(2048000, 0x20, 0x12C, 64000),
> +	LINEAR_RANGE(19200000, 0x12C, 0x1FF, 0),
>  };
> =20
>  /* Possible current values for fast-charging constant current phase */
>  static const struct linear_range fast_charge_current_ranges[] =3D {
> -	{
> -		.min =3D 0,
> -		.step =3D 64000,
> -		.min_sel =3D 0,
> -		.max_sel =3D 0xFF,
> -	}
> +	LINEAR_RANGE(0, 0, 0xFF, 64000),
>  };
> =20
>  struct battery_init {
> --=20
> 2.37.3
>=20
>=20
> --=20
> Matti Vaittinen, Linux device drivers
> ROHM Semiconductors, Finland SWDC
> Kiviharjunlenkki 1E
> 90220 OULU
> FINLAND
>=20
> ~~~ "I don't think so," said Rene Descartes. Just then he vanished ~~~
> Simon says - in Latin please.
> ~~~ "non cogito me" dixit Rene Descarte, deinde evanescavit ~~~
> Thanks to Simon Glass for the translation =3D]=20



--ppgnnw5oqsrss3jn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmNgYnAACgkQ2O7X88g7
+pqmzhAAnanCGO+omTSFHps9PofdT1JMAnsmjnq1bYbknfjKiK5yRsZVAsErE86w
oJSmVuAw/8gB8zI3M/Csdiw0Uu2ETiWL0NTW9LX1uvBQ2Ia9Nujm2VZDc7nti/NA
rnkz/FV13EnO7auEZUBaythMPNisK2UTaKSsF7A/5z7mBf0XJjHC3hjCBfTcUYaq
9IzGYnJFSr/6nJp098Xn8DeUZhbdOc7Bpqr0rMDZwGqIAbfU1LDvX6kXHx88uy0E
ikM0Ha2EanQk8Gh9FSk3YkpJMgxf07K/s3HcupE0S45q/N2vO6IfR8cZwWrcKaWu
7JRnb/Kb+ydu0WQJjRrwMt17mW2QP9NcuZ7r89LhD7D+08CV69yezluhTPyJJmtY
h2Ll9ZBdQYneIMch7w/Zl41VxL1DLIIV4Cjdv5adxEPqHgIaxxqYZZtX1gwWfU3o
DbPyUuQZu5Dh7Z5WUpe2KAGeftOTxQkbn20GUzqLLuGOnuQCZTJGE3UFoN9oAh2P
eJD07pxwAb3KUzxjGWmOkGM8jk1nyVsXBKZc218UvvIC6/WgpCxTDMSDrxfOlddE
UO7InVAop1uV8WVbVo0WlsXxDQYy2yHpcaEFJ6n4bcKK/u2xEthB9zNnud7dkY/3
9iMwO6KfOxzzjbz5YfO8bC4isjksgnUCvOAmZSD3HD1bYn28Vzs=
=VoRt
-----END PGP SIGNATURE-----

--ppgnnw5oqsrss3jn--
