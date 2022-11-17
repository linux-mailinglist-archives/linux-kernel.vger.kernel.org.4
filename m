Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0688162D57A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 09:50:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234678AbiKQIur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 03:50:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238951AbiKQIuk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 03:50:40 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C34DC4E
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 00:50:37 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ovabN-0001L9-Oh; Thu, 17 Nov 2022 09:50:29 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ovabL-004oaw-Cp; Thu, 17 Nov 2022 09:50:28 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ovabL-00HEUt-Ge; Thu, 17 Nov 2022 09:50:27 +0100
Date:   Thu, 17 Nov 2022 09:50:27 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-pwm@vger.kernel.org, Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v4 3/7] pwm: lpss: Include headers we are the direct user
 of
Message-ID: <20221117085027.f5qy5rsauo7vhvw2@pengutronix.de>
References: <20221114165545.56088-1-andriy.shevchenko@linux.intel.com>
 <20221114165545.56088-4-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dyjvyb6dwuevgtjt"
Content-Disposition: inline
In-Reply-To: <20221114165545.56088-4-andriy.shevchenko@linux.intel.com>
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


--dyjvyb6dwuevgtjt
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 14, 2022 at 06:55:41PM +0200, Andy Shevchenko wrote:
> For the sake of integrity, include headers we are the direct
> user of.
>=20
> Replace the inclusion of device.h by a forward declaration
> of struct device plus a (cheaper) of types.h as device.h is
> an expensive include (measured in compiler effort).
>=20
> While at it, move the struct pwm_lpss_chip to be after
> the struct pwm_lpss_boardinfo as the former uses pointer
> to the latter.

I stand by my feedback that this change is irrelevant in the end. If you
drop it here, the patch gets a bit nicer and in the end the difference
is just:

diff --git a/drivers/pwm/pwm-lpss.h b/drivers/pwm/pwm-lpss.h
index b721532c6c3c..bf841250385f 100644
--- a/drivers/pwm/pwm-lpss.h
+++ b/drivers/pwm/pwm-lpss.h
@@ -17,15 +17,15 @@
=20
 #define LPSS_MAX_PWMS			4
=20
-extern const struct pwm_lpss_boardinfo pwm_lpss_byt_info;
-extern const struct pwm_lpss_boardinfo pwm_lpss_bsw_info;
-extern const struct pwm_lpss_boardinfo pwm_lpss_bxt_info;
-extern const struct pwm_lpss_boardinfo pwm_lpss_tng_info;
-
 struct pwm_lpss_chip {
 	struct pwm_chip chip;
 	void __iomem *regs;
 	const struct pwm_lpss_boardinfo *info;
 };
=20
+extern const struct pwm_lpss_boardinfo pwm_lpss_byt_info;
+extern const struct pwm_lpss_boardinfo pwm_lpss_bsw_info;
+extern const struct pwm_lpss_boardinfo pwm_lpss_bxt_info;
+extern const struct pwm_lpss_boardinfo pwm_lpss_tng_info;
+
 #endif	/* __PWM_LPSS_H */

which is quite ok to leave as is.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--dyjvyb6dwuevgtjt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmN19dAACgkQwfwUeK3K
7AkwAAf8CRGF9PyJT9avbrmFmPw1LkilPdzVQ2dvkv9mh7X6tHmHhVp5l9CAe73U
nyEMq85EFWYSM9Hu7plFZyeU76Ap94ZSXAvCIshWonoImLNGjAdMK4Jb2y0iaufo
ZYfCF7mle5/rwHM5gk5NxG8FqoPV4vuLy7cTYNwpX92Mwe+oDyYk/EdoW1YFUV0k
3R77XoyNPKA7X+fyiMpRQBJK7OiYc+JWp2cOFJOennNHyjZyDDT243imDkW38YtA
xTaZyDvpFqcojGwuxDk+ARy2OM1kExRzKzMvG5uNNgsvfS3a2PfW+8CK6wzWxgVk
weqavsGPLx80MGwso+Dsq/M2PC/Qbg==
=Nl26
-----END PGP SIGNATURE-----

--dyjvyb6dwuevgtjt--
