Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 288A1615476
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 22:53:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbiKAVw6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 17:52:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiKAVw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 17:52:56 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1799B7C4
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 14:52:55 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1opzBc-0006mm-16; Tue, 01 Nov 2022 22:52:44 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1opzBa-001ka6-V6; Tue, 01 Nov 2022 22:52:42 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1opzBY-00Dm01-Tm; Tue, 01 Nov 2022 22:52:40 +0100
Date:   Tue, 1 Nov 2022 22:52:36 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Angel Iglesias <ang.iglesiasg@gmail.com>
Cc:     linux-iio@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/2] iio: pressure: bmp280: convert to i2c's
 .probe_new()
Message-ID: <20221101215236.ihoqkx2xckilom67@pengutronix.de>
References: <cover.1667151588.git.ang.iglesiasg@gmail.com>
 <af8ed10a85d48531c50823163e6c55b2a72371ef.1667151588.git.ang.iglesiasg@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7pjkg57m7im34odb"
Content-Disposition: inline
In-Reply-To: <af8ed10a85d48531c50823163e6c55b2a72371ef.1667151588.git.ang.iglesiasg@gmail.com>
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


--7pjkg57m7im34odb
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Sun, Oct 30, 2022 at 06:53:11PM +0100, Angel Iglesias wrote:
> Use i2c_client_get_device_id() to get the i2c_device_id* parameter in the
> .new_probe() callback.
>=20
> Signed-off-by: Angel Iglesias <ang.iglesiasg@gmail.com>
> ---
>  drivers/iio/pressure/bmp280-i2c.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/iio/pressure/bmp280-i2c.c b/drivers/iio/pressure/bmp=
280-i2c.c
> index 0c27211f3ea0..20073b09b3e3 100644
> --- a/drivers/iio/pressure/bmp280-i2c.c
> +++ b/drivers/iio/pressure/bmp280-i2c.c
> @@ -5,11 +5,11 @@
> =20
>  #include "bmp280.h"
> =20
> -static int bmp280_i2c_probe(struct i2c_client *client,
> -			    const struct i2c_device_id *id)
> +static int bmp280_i2c_probe(struct i2c_client *client)
>  {
> -	struct regmap *regmap;
> +	const struct i2c_device_id *id =3D i2c_client_get_device_id(client);
>  	const struct regmap_config *regmap_config;
> +	struct regmap *regmap;
> =20
>  	switch (id->driver_data) {
>  	case BMP180_CHIP_ID:

What is the motivation for moving regmap? I thought reverse christmas
tree is only a thing in network code? I would have left the regmap
declaration where it is.

> @@ -65,7 +65,7 @@ static struct i2c_driver bmp280_i2c_driver =3D {
>  		.of_match_table =3D bmp280_of_i2c_match,
>  		.pm =3D pm_ptr(&bmp280_dev_pm_ops),
>  	},
> -	.probe		=3D bmp280_i2c_probe,
> +	.probe_new	=3D bmp280_i2c_probe,
>  	.id_table	=3D bmp280_i2c_id,
>  };
>  module_i2c_driver(bmp280_i2c_driver);

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--7pjkg57m7im34odb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmNhlSEACgkQwfwUeK3K
7AmT1Qf/crN47+a7Fx3l82hw5q8rL/w8pRU6kiS3TE59qc8syW0rcWMQgkJM3war
fWXMV3f7AHRpEAqyLi3b90ZGAdRE6XbN0iOHl+/BHHYoafGA/MsJ7E9Dzf9bEUVp
NhegFgleuMS0S7CgZzVHFPummi3yKkK84/lhytfaNteHLfFpuTUoiAzh5/2OYfYn
zC1dVEet/pwoicDvayDqD9hBAQKZ6SDY3V34+Il1FqU8UAsV36EzCtSJfydctliy
8eZLpJ7/TmMSVnHRIwJ8l28e9PgqaN0ZO1jF6olr8WVZ82HrBErvHT36RFB+cVuu
O6byR1+2UmY5v4yFJMfNDejqbzS0Sg==
=2U3q
-----END PGP SIGNATURE-----

--7pjkg57m7im34odb--
