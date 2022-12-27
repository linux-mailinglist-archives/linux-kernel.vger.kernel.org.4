Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11153656A18
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 12:55:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231277AbiL0Lz0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 06:55:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbiL0LzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 06:55:15 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A9719FD7
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 03:55:10 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pA8Y0-0002mr-VL; Tue, 27 Dec 2022 12:55:09 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pA8Xy-0023lf-8G; Tue, 27 Dec 2022 12:55:06 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pA8Xx-008Hfk-Gq; Tue, 27 Dec 2022 12:55:05 +0100
Date:   Tue, 27 Dec 2022 12:54:31 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     Nicolas Palix <nicolas.palix@imag.fr>,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de, cocci@inria.fr
Subject: Re: coccinelle: How to remove a return at the end of a void function?
Message-ID: <20221227115431.rugxkddjfn3p7edw@pengutronix.de>
References: <20221224115657.kqyocti356cwm7hc@pengutronix.de>
 <alpine.DEB.2.22.394.2212241326310.2711@hadrien>
 <20221225212011.6il5egocxtx5zupa@pengutronix.de>
 <be39f7d-31ab-24c-61c5-6daabdef9267@inria.fr>
 <20221227095517.mzjmqse5wvaielev@pengutronix.de>
 <e39bbae4-7929-b1b0-ea42-11825d98e43e@inria.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6sndfywr47jhjoeu"
Content-Disposition: inline
In-Reply-To: <e39bbae4-7929-b1b0-ea42-11825d98e43e@inria.fr>
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


--6sndfywr47jhjoeu
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Julia,

On Tue, Dec 27, 2022 at 12:26:50PM +0100, Julia Lawall wrote:
> > @p2@
> > identifier pdev;
> > @@
> >  void rtsx_usb_sdmmc_drv_remove(struct platform_device *pdev) {
> >  ...
> > -Return();
> >  }
>=20
> You need when any on the ... to allow there to be Returns();s along the
> way.

\o/ that works fine, thanks

(i.e.

	... when any

instead of ...)

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--6sndfywr47jhjoeu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmOq3O8ACgkQwfwUeK3K
7AmZvgf/bnJvLM+V7hpUZUd/mPatguX/S3blr/i0Vjmyl9F4yBYr5+BiFAgV4f37
gn4VTf4uqjgnq0jNjtQ7SesGX5ErJyEfMpxDgSYkLanMMro7qRyyAjpDEsqxrcC1
j3N8B1W0YoMVbELgS6Vznl4mCQONU/y/BfUsFWX240zn41NVqZck6rugsPl0dM+a
K8ZUYKm9nZ2+9JvoO2PyZmpVw7WiaNIkH0+zfIXzFzNi95/0WkQkKSNnatn5CXFn
PBOTN8Nc2+WtchbP1PM6jf7c4+MXFjHrdcgRgFaWrFNjh0NMaKZacJM8AI+KmRl2
qMMk/rD+qZ/49QsU8crG5N9jkSFedA==
=UJAR
-----END PGP SIGNATURE-----

--6sndfywr47jhjoeu--
