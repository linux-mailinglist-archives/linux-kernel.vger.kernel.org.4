Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1D656CBC89
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 12:30:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232390AbjC1KaZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 06:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjC1KaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 06:30:23 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDF7D6E89
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 03:30:17 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ph6ag-0001LE-Tt; Tue, 28 Mar 2023 12:30:10 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ph6af-007Hg3-Rv; Tue, 28 Mar 2023 12:30:09 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ph6ae-008f04-WC; Tue, 28 Mar 2023 12:30:09 +0200
Date:   Tue, 28 Mar 2023 12:30:08 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] clk: imx: Drop inclustion of unused header
 <soc/imx/timer.h>
Message-ID: <20230328103008.xmbqfbaw4tk5tb5a@pengutronix.de>
References: <20230328100531.879485-1-u.kleine-koenig@pengutronix.de>
 <20230328100531.879485-2-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="c2c6saqyzfoergft"
Content-Disposition: inline
In-Reply-To: <20230328100531.879485-2-u.kleine-koenig@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--c2c6saqyzfoergft
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

when reading my own patch in my MUA I noticed a typo in the subject:

$Subject ~=3D s/inclustion/inclusion/

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--c2c6saqyzfoergft
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmQiwa4ACgkQj4D7WH0S
/k5XPQf/a5YwHegQmLBiAZK9K+xYl3FUEfqoLwA4642fZPUiPJZY+ZQZJkJPEPkk
fV/CFU0Bja4xQwFkY76V7ReXIjLcx+27o1H50tm7wlrz1hSvHmEFRnLZiHxrgaK5
FDggwA+sBhF2cVAOyAF2DUdhBJ3IZ2fZBbMhZi6mJIIksJNJ17VGp1XRFPdwfXDT
EcKVv+dwWgqKC4LAqJuG7o58IVA7s4VBYy1qaRZooDQtK2ZloBenkNOjvw+Yc1/R
CbfGK+lTOozMij6kvo7kE8k9b/PlujqglT4DIpTvmwfo6lCautKatZnPAhwaJBFn
rTf1tUNMiCOx4uSwZH0+7/XQBC2d2w==
=Pyug
-----END PGP SIGNATURE-----

--c2c6saqyzfoergft--
