Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B130713704
	for <lists+linux-kernel@lfdr.de>; Sun, 28 May 2023 00:31:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbjE0WbV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 May 2023 18:31:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjE0WbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 May 2023 18:31:19 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDAFCD9
        for <linux-kernel@vger.kernel.org>; Sat, 27 May 2023 15:31:17 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1q32RP-0008Lp-VI; Sun, 28 May 2023 00:31:16 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1q32RM-003HGI-6W; Sun, 28 May 2023 00:31:12 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1q32RL-008Zwc-ES; Sun, 28 May 2023 00:31:11 +0200
Date:   Sun, 28 May 2023 00:31:11 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Prathu Baronia <prathubaronia2011@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Khadija Kamran <kamrankhadijadj@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        dan.carpenter@linaro.org, error27@gmail.com, lkp@intel.com,
        oe-kbuild-all@lists.linux.dev, oe-kbuild@lists.linux.dev
Subject: Re: [PATCH v4 3/3] axis-fifo: cleanup space issues with fops struct
Message-ID: <20230527223111.jidik3ffcsxdkenb@pengutronix.de>
References: <ZHHE/H2p4Go/Igc/@redkillpc>
 <20230527115101.47569-1-prathubaronia2011@gmail.com>
 <20230527115101.47569-3-prathubaronia2011@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cdvvvrjjz27c3mvb"
Content-Disposition: inline
In-Reply-To: <20230527115101.47569-3-prathubaronia2011@gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cdvvvrjjz27c3mvb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Sat, May 27, 2023 at 05:21:00PM +0530, Prathu Baronia wrote:
> Add required spaces for proper formatting of fops members for better
> readability.
>=20
> Signed-off-by: Prathu Baronia <prathubaronia2011@gmail.com>
> ---
>  drivers/staging/axis-fifo/axis-fifo.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/staging/axis-fifo/axis-fifo.c b/drivers/staging/axis=
-fifo/axis-fifo.c
> index d71bdc6dd961..59e962467a3d 100644
> --- a/drivers/staging/axis-fifo/axis-fifo.c
> +++ b/drivers/staging/axis-fifo/axis-fifo.c
> @@ -716,11 +716,11 @@ static int axis_fifo_close(struct inode *inod, stru=
ct file *f)
>  }
> =20
>  static const struct file_operations fops =3D {
> -	.owner =3D THIS_MODULE,
> -	.open =3D axis_fifo_open,
> +	.owner   =3D THIS_MODULE,
> +	.open    =3D axis_fifo_open,
>  	.release =3D axis_fifo_close,
> -	.read =3D axis_fifo_read,
> -	.write =3D axis_fifo_write
> +	.read    =3D axis_fifo_read,
> +	.write   =3D axis_fifo_write

Note this is only subjectively better. IMHO with just a single space
this is perfectly readable. Aligning the =3D might look nice, but it's
also annoying at times. When you add another member (e.g.
=2Eiterate_shared) you either add a line that doesn't match all others, or
you have to touch all other lines of that struct which (objectively?)
hurts readability of that patch. Also for generated patches this kind of
alignment yields extra work. (See for example
https://lore.kernel.org/lkml/20230525205840.734432-1-u.kleine-koenig@pengut=
ronix.de/
which required semi-manual fixup to keep the alignment after coccinelle
generated the patch.)

If you still think this is a good idea, I'd ask you to stick to one
style for the whole file. e.g. axis_fifo_driver uses inconsistent
and different indention.

A thing that IMHO is more useful to change here, is the name fops; I'd
suggest something like axis_fifo_fops (and also use prefixes for some
other symbols like "get_dts_property"). In 6.4-rc1 my ctags file knows
about 64 different places that define something called "fops".

Just my 0.02=E2=82=AC,
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig         =
   |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--cdvvvrjjz27c3mvb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmRyhK4ACgkQj4D7WH0S
/k4GHQf/UqWfo79tCnSurnPKR+RHhrveNwWlX7kE0wdil5CyIe7xjiG/0TNrS86J
DBhUGdUczfaKmeuTG3sQKTJowMSmRQyuIxCM37lnJPvYWBAdkuhbsBgHaRNdR5fA
yIX9vrR9belBqHdMMl7sXdcLoIWdzsKUHL+8p2wiP5Qaz4X7WwyfPmkGLnk5Km49
k11VFJT2HAdq3zut/83XO4JNIeX0WL3Yzz4LQFVcmLaU6K19dvXXIV/bN0cQEXwR
hpUGiKWwWpEF9+JaFKIHfCsJ5luB9Nbb+HxU8ph84VOCgG8JFldIfylX1woz06R4
kQRnDIRnbbALLfda5tit7DxPVRV/OA==
=8i8o
-----END PGP SIGNATURE-----

--cdvvvrjjz27c3mvb--
