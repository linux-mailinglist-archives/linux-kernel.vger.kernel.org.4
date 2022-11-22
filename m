Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E141633DE2
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 14:39:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233839AbiKVNjv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 08:39:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233767AbiKVNjp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 08:39:45 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 668782B608
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 05:39:41 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1oxTUt-00053x-17; Tue, 22 Nov 2022 14:39:35 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oxTUr-005rZi-0s; Tue, 22 Nov 2022 14:39:33 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oxTUr-000o66-6F; Tue, 22 Nov 2022 14:39:33 +0100
Date:   Tue, 22 Nov 2022 14:39:33 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-pwm@vger.kernel.org, Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v5 3/7] pwm: lpss: Include headers we are the direct user
 of
Message-ID: <20221122133933.iwo76w4h6wuvp3v4@pengutronix.de>
References: <20221117110806.65470-1-andriy.shevchenko@linux.intel.com>
 <20221117110806.65470-4-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="spgoam2ad4ovh5w3"
Content-Disposition: inline
In-Reply-To: <20221117110806.65470-4-andriy.shevchenko@linux.intel.com>
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


--spgoam2ad4ovh5w3
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 17, 2022 at 01:08:02PM +0200, Andy Shevchenko wrote:
> For the sake of integrity, include headers we are the direct
> user of.
>=20
> Replace the inclusion of device.h by a forward declaration
> of struct device plus a (cheaper) of types.h as device.h is
> an expensive include (measured in compiler effort).
>=20
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Acked-by: Thierry Reding <thierry.reding@gmail.com>
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--spgoam2ad4ovh5w3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmN80RIACgkQwfwUeK3K
7Anwlwf/X0mQrjZEBJBew2lvyjqHmjokQ9g/NMPI/ULfXPOSrYsXbAU9jsxS5T0D
ZaD3KiXILev/WQSyeHZGvGNwSwoDqXy3mZBcOApnODNoAGByn9uTeQ9ZvQNU/Q3O
VTIZfibXZ+cW5gGm2jwiXEso88q3bRL1AVGVl3jKc90EOGzL6JHIIJ3rKkS6sMB6
dlQxI4yJk+p1M6Bub0pqGUkX84lmr/cZmj/ux8csIs497NLddcGJP4vUk9X0I6gU
4T5J5jLfv1o0tBrlvL+gm0AX/Qh0VDxVoI2fmwuO7m8TmaIZvlAhNvCwYhQzR5Dt
OzcW+goKERG+JeHQ8ZbVGZHuxMCqrg==
=5n0N
-----END PGP SIGNATURE-----

--spgoam2ad4ovh5w3--
