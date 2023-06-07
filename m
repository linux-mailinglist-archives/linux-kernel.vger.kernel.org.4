Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91A957256D4
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 10:05:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239208AbjFGIFY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 04:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238932AbjFGIFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 04:05:12 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82AB1172B
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 01:05:10 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1q6oAC-0007vh-Fs; Wed, 07 Jun 2023 10:05:04 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1q6oAA-005hQ1-F7; Wed, 07 Jun 2023 10:05:02 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1q6oA9-00Bwjr-Ls; Wed, 07 Jun 2023 10:05:01 +0200
Date:   Wed, 7 Jun 2023 10:05:01 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Nikita Shubin <nikita.shubin@maquefel.me>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Michael Peters <mpeters@embeddedTS.com>,
        Kris Bahnsen <kris@embeddedTS.com>, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 37/43] pwm: ep93xx: drop legacy pinctrl
Message-ID: <20230607080501.3y3t7tswfoyhqep2@pengutronix.de>
References: <20230424123522.18302-1-nikita.shubin@maquefel.me>
 <20230601054549.10843-19-nikita.shubin@maquefel.me>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kvq3zup3qbya4ukn"
Content-Disposition: inline
In-Reply-To: <20230601054549.10843-19-nikita.shubin@maquefel.me>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kvq3zup3qbya4ukn
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Thu, Jun 01, 2023 at 08:45:42AM +0300, Nikita Shubin wrote:
> Drop legacy gpio request/free since we are using
> pinctrl for this now.
>=20
> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
> Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

I'm not aware of other changes to drivers/pwm/pwm-ep93xx.c so for me
it's fine to merge this via arm-soc. But note that Thierry's Ack
for that would be good.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--kvq3zup3qbya4ukn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmSAOiwACgkQj4D7WH0S
/k50VQf/Z0Z146yb8ZnA/hfzt8wtm2qPxk1WClIqQzrapySHezELFowBUNZa42g6
1/xrOydBkQC5cRqAcbx/C8TOB3wwpdakVv6KQeN0WoR8PR5DBL4s/P5bQzPb+tMU
AFirsmM/HX9t8DiTLprU+TSukLOhdsfvUU23U/48QNKJUWcXaSePH0aApRv+UNJE
MO6ZPW7NpIdq31fJ7k5fEfDUUhW4kM/9LweT3xBQUFCAh5mLUaXuLFoA7zSkuLpC
W9+Rtv4ehZW6gvIpf1CeOl/3N+S9b/lRQ2rIn3kbJU0qeXnsJc3J4a6/bmtRA4Go
II19T1hCwJbHhl3GBp0pEDVf982SXw==
=8rvR
-----END PGP SIGNATURE-----

--kvq3zup3qbya4ukn--
