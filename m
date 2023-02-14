Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 745B369606B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 11:12:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231777AbjBNKLq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 05:11:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232390AbjBNKLc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 05:11:32 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6EA0115
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 02:11:30 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pRsHS-00080X-6S; Tue, 14 Feb 2023 11:11:22 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pRsHP-004rHM-Bo; Tue, 14 Feb 2023 11:11:20 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pRsHP-003SGm-TY; Tue, 14 Feb 2023 11:11:19 +0100
Date:   Tue, 14 Feb 2023 11:11:19 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Florian Eckert <fe@dev.tdt.de>
Cc:     gregkh@linuxfoundation.org, jirislaby@kernel.org, pavel@ucw.cz,
        lee@kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org, Eckert.Florian@googlemail.com
Subject: Re: [PATCH 2/2] leds: trigger: ledtrig-tty: add additional modes
Message-ID: <20230214101119.em547qt57swzylae@pengutronix.de>
References: <20230213140638.620206-1-fe@dev.tdt.de>
 <20230213140638.620206-3-fe@dev.tdt.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="66c7xgq6xsabpl3k"
Content-Disposition: inline
In-Reply-To: <20230213140638.620206-3-fe@dev.tdt.de>
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


--66c7xgq6xsabpl3k
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 13, 2023 at 03:06:38PM +0100, Florian Eckert wrote:
> Add additional modes to trigger the selected LED.
> The following modes are supported:
>=20
> TD/RD:	Flash LED on data transmission (default)
> CTS:	DCE Ready to accept data from the DTE.
> DSR:	DCE is ready to receive and send data.
> CAR:	DCE is receiving a carrier from a remote DTE.
> RNG:	DCE has detected an incoming ring signal.
>=20
> The mode can be changed for example with the following command:
> echo "CTS" /sys/class/leds/<led>/mode

I wonder if the abstraction is better be done such that you can also
configure the mode to trigger on (for example) TD and RNG. Then you'd
need one property per signal and then something like the following would
be possible:

	p=3D/sys/class/leds/<led>
	echo 1 > $p/tx
	echo 0 > $p/rx
	echo 1 > $p/rng

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--66c7xgq6xsabpl3k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmPrXkQACgkQwfwUeK3K
7AmbsQf7Bh8u/aFnPft1yeQNGkl4BGGjQ7V23sUHl4LQX7WaON5+Uey7gqCVfjJR
6WUJh4bRG5wGS6hDllRL2wLkd8ZtJuc2ynPqRgVSS+ZKEfa0PrGDTPM30uA1Mq8N
73DhGXySQpDYOBJXonULgrwLfDmWmJfeC/xvBxyjvAqgEzszdeICMSEKTh1ME0er
lTG+ssrzsHgHxBVIlH3XnCgvEmRI+Mda5DcLAai25+I5UciUXrG5m3xN9YVH4HaH
z9GFWw1FI9PcfTmOHBkFOYyHxCdlVEgzI2BIKvp3El6grOrVKqyaYH+Ug2u1lT2A
YxNjblgyiBqcjYAmR5VFMtHuXGMnJA==
=OPK+
-----END PGP SIGNATURE-----

--66c7xgq6xsabpl3k--
