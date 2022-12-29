Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67A5B658FD8
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 18:31:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233917AbiL2Raz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 12:30:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234060AbiL2RaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 12:30:10 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A40314024
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 09:28:59 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pAwhx-0005QI-Re; Thu, 29 Dec 2022 18:28:45 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pAwhr-002Xc3-9T; Thu, 29 Dec 2022 18:28:39 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pAwhq-008no3-LN; Thu, 29 Dec 2022 18:28:38 +0100
Date:   Thu, 29 Dec 2022 18:28:35 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Anatolij Gustschin <agust@denx.de>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH] powerpc/mpc52xx_lpbfifo: Drop unused functions
Message-ID: <20221229172835.ldbpjwl4aelx7p3h@pengutronix.de>
References: <20221228145129.31700-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rti4uiobizeudh3c"
Content-Disposition: inline
In-Reply-To: <20221228145129.31700-1-u.kleine-koenig@pengutronix.de>
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


--rti4uiobizeudh3c
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 28, 2022 at 03:51:29PM +0100, Uwe Kleine-K=F6nig wrote:
> The four exported functions mpc52xx_lpbfifo_submit(),
> mpc52xx_lpbfifo_abort(), mpc52xx_lpbfifo_poll(), and
> mpc52xx_lpbfifo_start_xfer() are not used. So they can be dropped and the
> definitions needed to call them can be moved into the driver file.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> ---

I forgot to note here that maybe without these four exported functions
the driver is useless and can be removed completely.

I didn't look in detail, but maybe one of the recipents might know.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--rti4uiobizeudh3c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmOtzj0ACgkQwfwUeK3K
7Alzngf/Xx+HJYH/vMXNuHjNRyrafXDMgBhet+5A1v5j/4Nm97YyRa41lN30vS86
HRKzP3fevg5wxaJ6pTwVjHJxSk2iSuxsuqZ0VGp9angN3YrY0C6/hE+gNz626CJs
jdRRbU0B5MJOf4yd3xADCfxKOxsHCOVIJj2NnyvHpQ0kgk+KKCxvM8yYRZaRdg8x
Zbuffu2ss9qc3mS09yOLv/pdqvMn/YD+vYAOAt1mZaRF0E6j0clpPO7+OkZ6wXWz
TB1KDjM/ZCYAN4g56r79vXYm0Shuo2Ljtty28g4tjHI3FDvdUjQ9hdLJsV8CR7eK
Gm528AR6uba9S5iQJHeGlQlB1CzMLA==
=VL+9
-----END PGP SIGNATURE-----

--rti4uiobizeudh3c--
