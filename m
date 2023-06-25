Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E51E773CF0C
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 09:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231678AbjFYHwd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 03:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbjFYHwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 03:52:31 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EB5CDF
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 00:52:27 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qDKXm-0001ks-US; Sun, 25 Jun 2023 09:52:22 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qDKXk-009uRf-LQ; Sun, 25 Jun 2023 09:52:20 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qDKXj-00HC8v-KC; Sun, 25 Jun 2023 09:52:19 +0200
Date:   Sun, 25 Jun 2023 09:52:19 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Peng Fan <peng.fan@nxp.com>, Arnd Bergmann <arnd@arndb.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Linux Kernel Functional Testing <lkft@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        Abel Vesa <abelvesa@kernel.org>
Subject: Re: [PATCH] clk: imx: Drop inclusion of unused header
 <soc/imx/timer.h>
Message-ID: <20230625075219.diqv7x5xfybm4gdx@pengutronix.de>
References: <20230623071948.3254789-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jm3pyctboqwgb3qh"
Content-Disposition: inline
In-Reply-To: <20230623071948.3254789-1-arnd@kernel.org>
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


--jm3pyctboqwgb3qh
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 23, 2023 at 09:19:19AM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>=20
> After removing this header in the clocksource tree, the clk drivers no
> longer build:
>=20
> drivers/clk/imx/clk-imx1.c:13:10: fatal error: 'soc/imx/timer.h' file not=
 found
> drivers/clk/imx/clk-imx27.c:11:10: fatal error: 'soc/imx/timer.h' file no=
t found
>=20
> This patch was originally posted as part of a three-patch series, but only
> patches 1 and 3 got applied.
>=20
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> Fixes: 9e9d7570485d7 ("clocksource/drivers/imx-gpt: Fold <soc/imx/timer.h=
> into its only user")
> Link: https://lore.kernel.org/all/20230328100531.879485-2-u.kleine-koenig=
@pengutronix.de/
> Signed-off-by: "Uwe Kleine-K=F6nig" <u.kleine-koenig@pengutronix.de>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

A bit strange that this patch has author=3DArnd but still my S-o-b. Either
it's "my" patch (then I'd like to have author=3DUwe), or it's Arnd's then
I'm not in the submission path and my S-o-b is misleading.

The commit log of this patch is better as it mentions the fact that only
a part of my series was applied and that the 0day bot was in the loop.
So I suggest to make my Signed-off-by line a Co-developed-by one (and
drop the quotes around my name).

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--jm3pyctboqwgb3qh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmSX8jIACgkQj4D7WH0S
/k6dewf/cyT48mYpfnPadV+O7veMhjKxQG0hBvDHGhrN3bG9Jqzg9IQAhCNRyjAT
vPVpMrzejYb334Kx9dYwXW3qDirgUkbTZeQ/gPSjlFaUMkqYUvHVaBQhTOC6+uw6
2yL4RgWUrCdX2kRmeyhJrLusVRzbc8h4wFtk20pALZqi7TydL1Gpulu93ANWcyYH
j1FYeTbWZ9vU36LZ9Lz1Q2dSgPDxYYxTOdMVcQ8KfiCuw5rkpopPXITWqR5iR6vV
povyr5Bf907pQDPQNYDisxll5NQkt2dru0HJEKYw7Z6P11bsP+v2zBtVapKHjf+E
QzKmpNGZwo+PGdcGsrNi11dWnKbC9A==
=bqIj
-----END PGP SIGNATURE-----

--jm3pyctboqwgb3qh--
