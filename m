Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D95562D587
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 09:52:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239454AbiKQIwk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 03:52:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234833AbiKQIwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 03:52:32 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3A8411159
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 00:52:30 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ovadF-0001mh-Ml; Thu, 17 Nov 2022 09:52:25 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ovadE-004obE-3p; Thu, 17 Nov 2022 09:52:25 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ovadE-00HEV8-13; Thu, 17 Nov 2022 09:52:24 +0100
Date:   Thu, 17 Nov 2022 09:52:23 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-pwm@vger.kernel.org, Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v4 5/7] pwm: lpss: Rename pwm_lpss_probe() -->
 devm_pwm_lpss_probe()
Message-ID: <20221117085223.ywm6nezg77dp5j73@pengutronix.de>
References: <20221114165545.56088-1-andriy.shevchenko@linux.intel.com>
 <20221114165545.56088-6-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wblbqrwyuidijwb6"
Content-Disposition: inline
In-Reply-To: <20221114165545.56088-6-andriy.shevchenko@linux.intel.com>
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


--wblbqrwyuidijwb6
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 14, 2022 at 06:55:43PM +0200, Andy Shevchenko wrote:
> The pwm_lpss_probe() uses managed resources. Show this to
> the users explicitly by adding devm prefix to its name.
>=20
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--wblbqrwyuidijwb6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmN19kQACgkQwfwUeK3K
7AnrRwf5AQJPG56y93WTIFRwjrx3bhaqfkAx8Tax12aRsUVuIXTQOCW7vRkxgFCy
RRaR8HKoqYNLyKcCgfN7JdBhKSk6VUcqmWPUT03PP2Xf97YpYGcWHzMNsU7QVprn
b417UBiu7tXUbWLXxpUwUKy+GvA2KwdMfMDbNkX7W/n/Wy3TA+bkz9z02IjiTfhJ
9kkFnwKz/2D1rXft1lOl23n3gY4PNkT05L9X6lYUK08kF3aFq1weVLzOlYXa9Bpt
8orutQ/udzRJ6q1wvLk9QPTTh6PyMxjqfyjWjlzVUUVzTgenzgqojA/J43jvVTfB
g5er4S03FngL4vToPSBfY4u3L07J+A==
=KiN3
-----END PGP SIGNATURE-----

--wblbqrwyuidijwb6--
