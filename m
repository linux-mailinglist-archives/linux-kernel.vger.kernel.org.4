Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 777C36499D5
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 08:59:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231326AbiLLH7R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 02:59:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbiLLH7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 02:59:14 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 849F3DEB0
        for <linux-kernel@vger.kernel.org>; Sun, 11 Dec 2022 23:59:12 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1p4diQ-0004yz-2t; Mon, 12 Dec 2022 08:59:10 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1p4diO-003yFt-8I; Mon, 12 Dec 2022 08:59:09 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1p4diO-004QD2-3K; Mon, 12 Dec 2022 08:59:08 +0100
Date:   Mon, 12 Dec 2022 08:59:07 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Jean Delvare <jdelvare@suse.de>
Cc:     Sean Young <sean@mess.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH] media: rc: Drop obsolete dependencies on COMPILE_TEST
Message-ID: <20221212075907.4iwjsib5nrk7eqr2@pengutronix.de>
References: <20221121170911.7cd72bfc@endymion.delvare>
 <20221211205648.hdv5haufqwfoxzu2@pengutronix.de>
 <20221211231435.43c4f361@endymion.delvare>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cv6bebqzuvvfminx"
Content-Disposition: inline
In-Reply-To: <20221211231435.43c4f361@endymion.delvare>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cv6bebqzuvvfminx
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

[expanded Cc: for the acpi topic]

On Sun, Dec 11, 2022 at 11:14:35PM +0100, Jean Delvare wrote:
> Hallo Uwe,
>=20
> On Sun, 11 Dec 2022 21:56:48 +0100, Uwe Kleine-K=F6nig wrote:
> > On Mon, Nov 21, 2022 at 05:09:11PM +0100, Jean Delvare wrote:
> > > --- linux-6.0.orig/drivers/media/rc/pwm-ir-tx.c
> > > +++ linux-6.0/drivers/media/rc/pwm-ir-tx.c
> > > @@ -120,7 +120,7 @@ static struct platform_driver pwm_ir_dri
> > >  	.probe =3D pwm_ir_probe,
> > >  	.driver =3D {
> > >  		.name	=3D DRIVER_NAME,
> > > -		.of_match_table =3D of_match_ptr(pwm_ir_of_match),
> > > +		.of_match_table =3D pwm_ir_of_match,
> > >  	},
> > >  };
> > >  module_platform_driver(pwm_ir_driver); =20
> >=20
> > That hunk makes sense even without the Kconfig change. ACPI makes use of
> > .of_match_table, so
> >=20
> > 	.of_match_table =3D of_match_ptr(pwm_ir_of_match),
> >=20
> > is (almost?) always wrong.
>=20
> Should we just get rid of this macro altogether then?
>=20
> (Somehow I have a strange feeling that we already had this
> discussion...)

Might be. But for me this is only second hand knowledge, too. Maybe
someone of the new recipents in this thread feels competent to comment
here?!

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--cv6bebqzuvvfminx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmOW30gACgkQwfwUeK3K
7Al+PQf/VXKiZSEbz9veUhPADc4e7eTXsGKpPppWsW/wvDtQFEGUk6yB8rJ0hy81
N2X4icO4obevvDgB0GTUVHVP1SU355xozl+ckEnkIlvsdeP/+oua1pbBJLZsUEYx
AbNCkghiikvvNIqdomlc04xpkwVXBVPLg6Uy52TkUJ5ybCPqQO/FqhZ2Ylm+yPZM
YJPLol/Cjo/BPiZCFvSHvKPWLxs1aUnCyNvbs013TxKYcqvOpvSbHySibe/KRQMt
bnCTn+aBYnxauC/7xgj3bEs/88LE+uEqCdNfylqLQ3bQrozkKw9hqt/z3z7Rdecq
gHr8YSi94xPieZnq0O9z3mpGCLLJzw==
=2vY1
-----END PGP SIGNATURE-----

--cv6bebqzuvvfminx--
