Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3950F63F177
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 14:21:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231402AbiLANVZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 08:21:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231453AbiLANVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 08:21:20 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 711E1A896B
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 05:21:17 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1p0jUu-0006Q5-VJ; Thu, 01 Dec 2022 14:21:05 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1p0jUn-001alT-Od; Thu, 01 Dec 2022 14:20:58 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1p0jUn-001ngX-O7; Thu, 01 Dec 2022 14:20:57 +0100
Date:   Thu, 1 Dec 2022 14:20:57 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     ye.xingchen@zte.com.cn
Cc:     dmitry.torokhov@gmail.com, nick@shmanahar.org,
        giulio.benetti@benettiengineering.com,
        dario.binacchi@amarulasolutions.com, michael@amarulasolutions.com,
        oliver.graute@kococonnector.com, wsa+renesas@sang-engineering.com,
        jeff@labundy.com, johan@kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Input: touchscreen: use sysfs_emit() =?utf-8?Q?to_?=
 =?utf-8?Q?instead_of=C2=A0scnprintf=28=29?=
Message-ID: <20221201132057.6icmgdfmmutnr54p@pengutronix.de>
References: <202212011904193038898@zte.com.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fkhee35fpd6af2bh"
Content-Disposition: inline
In-Reply-To: <202212011904193038898@zte.com.cn>
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


--fkhee35fpd6af2bh
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Thu, Dec 01, 2022 at 07:04:19PM +0800, ye.xingchen@zte.com.cn wrote:
> From: ye xingchen <ye.xingchen@zte.com.cn>
>=20
> Replace the open-code with sysfs_emit() to simplify the code.
>=20
> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--fkhee35fpd6af2bh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmOIqjYACgkQwfwUeK3K
7AkIlwf7BpnYFhWKu46qHt408hlc5ow+yJLQZeyA3FCdcSC2pOI6o+IWLuk48JKD
YWkcHuMZQrf8NTLBm2wqkKFh7lP5DHpIcagsNRCJw74yP//ddQ/eVP/wrC/j80e3
/Lo50d0nxouOSYUeNutZmKlf49zQctTwBygnuVn2OhpXkm2RG0p5kafy+NZsT0Uf
ORa68ocZHDe8o9yvpEX0dgwT52Eg3ofp3yYXUfdQJSxcbzpS9KQuyhzwa4+VOW3y
BwZV7AeDEP4oDdyLI9ch51GuTQlGsyYOQ9ZzRac3nulZUycJE0xemJkNO9+GFjSc
FxL02xrfqo2Drr0ZgDwiFuZNk9LBWQ==
=SH+J
-----END PGP SIGNATURE-----

--fkhee35fpd6af2bh--
