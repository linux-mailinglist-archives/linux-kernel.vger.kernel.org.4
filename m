Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A20D62D582
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 09:52:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239465AbiKQIwN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 03:52:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233958AbiKQIvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 03:51:49 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16211BC6
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 00:51:49 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ovaca-0001jI-Aw; Thu, 17 Nov 2022 09:51:44 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ovacY-004ob9-LJ; Thu, 17 Nov 2022 09:51:43 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ovacY-00HEV1-H2; Thu, 17 Nov 2022 09:51:42 +0100
Date:   Thu, 17 Nov 2022 09:51:42 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-pwm@vger.kernel.org, Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v4 4/7] pwm: lpss: Allow other drivers to enable PWM LPSS
Message-ID: <20221117085142.rqfyb7a22yazke3s@pengutronix.de>
References: <20221114165545.56088-1-andriy.shevchenko@linux.intel.com>
 <20221114165545.56088-5-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jgkkmbilt7qln6zv"
Content-Disposition: inline
In-Reply-To: <20221114165545.56088-5-andriy.shevchenko@linux.intel.com>
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


--jgkkmbilt7qln6zv
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 14, 2022 at 06:55:42PM +0200, Andy Shevchenko wrote:
> The PWM LPSS device can be embedded in another device.
> In order to enable it, allow that drivers to probe
> a corresponding device.
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

--jgkkmbilt7qln6zv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmN19hsACgkQwfwUeK3K
7AnNowf+M0s1ypRrxYYgVIWYGjMPjqp7xOYDuEl9+yr67cm5+oH7RtnTLq//yLTZ
l8HYXOMNknnsxjkExunebWwa9tQiLIzF1TAIfB5iaiB81240Vu2G056TnYmlYVck
yVVC2jGGk48M46nJQl6wIlRaqtUJdKRuKXrP/yRfP17Mj28dDxcMfYo9MtYFOMIB
glt8exRvTy5gwrymzLpotJXBbgMFAJvbrmmtCtbpHD4OUhNrpo3LwMa93/P/EO3j
fpuUDg/0lDn4ViyOqKNaWWcTHR4wQrjc544RMWt6+wTZgsR8PsoZZH6oF0EFg+3c
qOlSVWaHLabWpMPBKQJmCFFoZwFo9Q==
=tnWs
-----END PGP SIGNATURE-----

--jgkkmbilt7qln6zv--
