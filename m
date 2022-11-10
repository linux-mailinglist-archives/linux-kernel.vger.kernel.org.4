Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF908623CB9
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 08:35:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232870AbiKJHf1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 02:35:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232865AbiKJHfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 02:35:24 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ED31F5B1
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 23:35:23 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ot25l-0001I1-6w; Thu, 10 Nov 2022 08:35:17 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ot25j-003PEQ-9x; Thu, 10 Nov 2022 08:35:16 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ot25j-00FaNh-I6; Thu, 10 Nov 2022 08:35:15 +0100
Date:   Thu, 10 Nov 2022 08:35:15 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-pwm@vger.kernel.org, Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2 4/6] pwm: lpss: Allow other drivers to enable PWM LPSS
Message-ID: <20221110073515.tzz6p62j42pfyv7q@pengutronix.de>
References: <20221108142226.63161-1-andriy.shevchenko@linux.intel.com>
 <20221108142226.63161-5-andriy.shevchenko@linux.intel.com>
 <20221110072810.meu3cxh5repuglk3@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ngysc4ikxicedi55"
Content-Disposition: inline
In-Reply-To: <20221110072810.meu3cxh5repuglk3@pengutronix.de>
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


--ngysc4ikxicedi55
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 10, 2022 at 08:28:10AM +0100, Uwe Kleine-K=F6nig wrote:
> On Tue, Nov 08, 2022 at 04:22:24PM +0200, Andy Shevchenko wrote:
> > The PWM LPSS device can be embedded in another device.
> > In order to enable it, allow that drivers to probe
> > a corresponding device.
>=20
> "probe" isn't the right term here. The other driver only creates the
> device.

Ah, I didn't look carefully enough for this judgement. My (wrong)
expectation was, that the containing device creates a platform-device
with .parent=3D$self and then drivers/pwm/pwm-lpss-platform.c does all the
necessary stuff automatically.

Hmm, I can live with that, so I drop this concern.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--ngysc4ikxicedi55
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmNsqbAACgkQwfwUeK3K
7AnaJwf/bRaG3QH+m3T2qw3Ve4RUG9PXMXElowe/RAv9cWxM3J1NEuTEZ5KryTsi
BPf2SL+VAyjgCQkHk86KlBz6MWdIxV+pBEboMduHVKSpm+Os52qbvKdTkkih5xJQ
YyiRelT4rK5b4TW7q94U6rbF/LV/UnxUF1t6zkYdcxIPZ78NhmjQ7kwQQw7A1L5n
CGkK85G7h7RNVChWzj3xZ8yRXz+jhv8fzuUBl5lBUmTW6ekzaDSHDbKDh85Qjrl2
afQnDCAWCC+iXyV4g7U1tcLGiHp2Ji2QR9TlLo950FzwG9WjHs5ICGH9XSG+W6lr
vHA0+0i8j277qp2JM/fZ+DzsVPy2qg==
=vSN1
-----END PGP SIGNATURE-----

--ngysc4ikxicedi55--
