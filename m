Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31AD964DF65
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 18:11:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbiLORLh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 12:11:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231179AbiLORLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 12:11:13 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB8A5442DB
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 09:10:33 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1p5rkL-0008Tv-VP; Thu, 15 Dec 2022 18:10:14 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1p5rkH-004k6l-RP; Thu, 15 Dec 2022 18:10:10 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1p5rkH-005Kxd-Ua; Thu, 15 Dec 2022 18:10:09 +0100
Date:   Thu, 15 Dec 2022 18:10:09 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Mark Brown <broonie@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Claudius Heine <ch@denx.de>, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Colin Ian King <colin.i.king@gmail.com>
Subject: Re: [PATCH] mtd: dataflash: remove duplicate SPI ID table
Message-ID: <20221215171009.see4b3cvxdqhb5bu@pengutronix.de>
References: <20221215164736.1315815-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ys7z75btzoijufmr"
Content-Disposition: inline
In-Reply-To: <20221215164736.1315815-1-arnd@kernel.org>
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


--ys7z75btzoijufmr
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 15, 2022 at 05:47:30PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>=20
> Building with -Werror=3Doverride-init revealds that two patches added

s/revealds/reveals/

> the same device ID table to this driver:
>=20
> drivers/mtd/devices/mtd_dataflash.c:946:27: error: initialized field over=
written [-Werror=3Doverride-init]
>   946 |         .id_table       =3D dataflash_spi_ids,
>       |                           ^~~~~~~~~~~~~~~~~
> drivers/mtd/devices/mtd_dataflash.c:946:27: note: (near initialization fo=
r 'dataflash_driver.id_table')
>=20
> Remove one of the copies.
>=20
> Fixes: 27a030e87292 ("mtd: dataflash: Add device-tree SPI IDs")
> Fixes: ac4f83482afb ("mtd: dataflash: Add SPI ID table")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

I seem to recall this was addressed already before. I found
https://lore.kernel.org/r/20221004211412.182940-1-colin.i.king@gmail.com
but it seems Colin (added to Cc:) never followed up on the build
problems reported by the build bots.

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--ys7z75btzoijufmr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmObVO4ACgkQwfwUeK3K
7Anc7Af+NPk1sfcbBoOameluenmscqWrwQwbBn10e54+THdTz/bEWzTOF1vE3Bb8
tlYZdB1oqcSQ2znrh7zoBBgJtj4M905SkeBr9G91NADozsHTmeZxYykhjWxhiYnW
ppNNQRWmqKeJ9LgodvcLe13jLLgj7ls2kzpzUQlc7of76NzhJRxBqMhCfh1XgtnC
kUWdEijo6HjDJrqb5mRlNuJSPxaBlSlTQvqs0Od7OrdCPGkPgfOjfwZqJsQfYEg1
+SvTHBxmYa4O8Xpi/2ggbcf/T7ZIYqUqPLVh8O9bShwX/6aQNdj1WhpLdlW3Xr6D
Ln9PSAQZj+ffrYMhuVqSixp7IOPx7w==
=MApv
-----END PGP SIGNATURE-----

--ys7z75btzoijufmr--
