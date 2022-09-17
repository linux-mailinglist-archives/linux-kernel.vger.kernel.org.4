Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 365795BBACA
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Sep 2022 00:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbiIQWEk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Sep 2022 18:04:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbiIQWEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Sep 2022 18:04:32 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D29E5FC1
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 15:04:31 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1oZfvK-0005o5-7Z; Sun, 18 Sep 2022 00:04:30 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oZfvK-001LkU-OQ; Sun, 18 Sep 2022 00:04:29 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oZfvI-001ayT-Lh; Sun, 18 Sep 2022 00:04:28 +0200
Date:   Sun, 18 Sep 2022 00:04:25 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Dominik Brodowski <linux@dominikbrodowski.net>, g@pengutronix.de
Cc:     linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH] pcmcia: sa1100: Make sa11x0_drv_pcmcia_legacy_remove()
 return void
Message-ID: <20220917220425.yb2damz43q7fghz6@pengutronix.de>
References: <20220714214534.63517-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jakt3vbz2qf65knj"
Content-Disposition: inline
In-Reply-To: <20220714214534.63517-1-u.kleine-koenig@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jakt3vbz2qf65knj
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Dominik,

On Thu, Jul 14, 2022 at 11:45:34PM +0200, Uwe Kleine-K=F6nig wrote:
> sa11x0_drv_pcmcia_legacy_remove() returns zero unconditionally. Letting it
> return void instead makes it easier to see in the caller that there is no
> error to handle.
>=20
> This is a preparation for making platform remove callbacks return void.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

This patch still applies on top of v6.0-rc1. I didn't get any feedback
about it yet. Is there someone else I should send this patch to?

Best regards
Uwe

> ---
>  drivers/pcmcia/sa1100_generic.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/pcmcia/sa1100_generic.c b/drivers/pcmcia/sa1100_gene=
ric.c
> index 47b060c57418..c2b6e828c2c6 100644
> --- a/drivers/pcmcia/sa1100_generic.c
> +++ b/drivers/pcmcia/sa1100_generic.c
> @@ -125,7 +125,7 @@ static int sa11x0_drv_pcmcia_legacy_probe(struct plat=
form_device *dev)
>  	return ret;
>  }
> =20
> -static int sa11x0_drv_pcmcia_legacy_remove(struct platform_device *dev)
> +static void sa11x0_drv_pcmcia_legacy_remove(struct platform_device *dev)
>  {
>  	struct skt_dev_info *sinfo =3D platform_get_drvdata(dev);
>  	int i;
> @@ -134,8 +134,6 @@ static int sa11x0_drv_pcmcia_legacy_remove(struct pla=
tform_device *dev)
> =20
>  	for (i =3D 0; i < sinfo->nskt; i++)
>  		soc_pcmcia_remove_one(&sinfo->skt[i]);
> -
> -	return 0;
>  }
> =20
>  static int sa11x0_drv_pcmcia_probe(struct platform_device *pdev)
> @@ -167,8 +165,10 @@ static int sa11x0_drv_pcmcia_remove(struct platform_=
device *dev)
>  {
>  	struct soc_pcmcia_socket *skt;
> =20
> -	if (dev->id =3D=3D -1)
> -		return sa11x0_drv_pcmcia_legacy_remove(dev);
> +	if (dev->id =3D=3D -1) {
> +		sa11x0_drv_pcmcia_legacy_remove(dev);
> +		return 0;
> +	}
> =20
>  	skt =3D platform_get_drvdata(dev);
> =20
>=20
> base-commit: f2906aa863381afb0015a9eb7fefad885d4e5a56

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--jakt3vbz2qf65knj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmMmRGcACgkQwfwUeK3K
7AlTWggAhFblRRwxmbE0w4eEpOd5atCR6Xd0/LR4JDOK1c6A8MIXyGsaYGAESO3T
4Utehf5VqOg5bzs5B1T8XZ2X6IcaEihVvHaa60g1/IwHR+RtDu318EdjAUhSX2fw
uawT7qPxFZqxjAqNAdf8NwapwDS04B+hhVmYRy+A8krTL4vEM3evL8Wbjk+IitJL
otdAZCaAFHa4l/w9hxoXtS/DNi/JcsV82jU2DQOYx34UkxrnLonS1YEWxuCP7NY5
WBZiXq3l2fL6oz+YkY7NAg1decEj/gsh3s3x5GhUpwfFOzS5p6U8tiWbhNNQK37w
b69wkRx13h6pEM+JqTExiqhLwDDOHw==
=hnfH
-----END PGP SIGNATURE-----

--jakt3vbz2qf65knj--
