Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66E09634802
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 21:22:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234182AbiKVUWI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 15:22:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232355AbiKVUWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 15:22:06 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46A33B4F2D
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 12:22:05 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1oxZmE-00074p-O1; Tue, 22 Nov 2022 21:21:54 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oxZmC-005v1n-Gq; Tue, 22 Nov 2022 21:21:53 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oxZmC-000s8U-Kc; Tue, 22 Nov 2022 21:21:52 +0100
Date:   Tue, 22 Nov 2022 21:21:48 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-pwm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v5 6/7] pwm: lpss: Add devm_pwm_lpss_probe() stub
Message-ID: <20221122202148.5bwmrblpmzzgndyt@pengutronix.de>
References: <20221117110806.65470-1-andriy.shevchenko@linux.intel.com>
 <20221117110806.65470-7-andriy.shevchenko@linux.intel.com>
 <20221122164703.e3z42rou7ivu3djv@pengutronix.de>
 <Y30IaslnbeKBkMhM@smile.fi.intel.com>
 <20221122181444.m74fa47ejp7nvgxj@pengutronix.de>
 <Y30V1aJcbyjC+Chu@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ytt66jt4j43s74gl"
Content-Disposition: inline
In-Reply-To: <Y30V1aJcbyjC+Chu@smile.fi.intel.com>
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


--ytt66jt4j43s74gl
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Andy,

On Tue, Nov 22, 2022 at 08:32:53PM +0200, Andy Shevchenko wrote:
> On Tue, Nov 22, 2022 at 07:14:44PM +0100, Uwe Kleine-K=F6nig wrote:
> > I just tested compiling your series without patch #6, x86_64 allmodconf=
ig + PWM=3Dn.
> >=20
> > nm doesn't report the need for devm_pwm_lpss_probe in
> > drivers/pinctrl/intel/pinctrl-intel.o.
>=20
> Sounds like you are right. I tried a brief test with m/m, y/m, m/y, and m=
/n
> variants between PINCTRL_INTEL and PWM_LPSS and all were built fine.
>=20
> That said, I will drop this patch and send a PR with the rest.

Sounds good.

> Thank you for thorough review!

Thank you for the interesting thread. I like our conversations.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--ytt66jt4j43s74gl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmN9L1kACgkQwfwUeK3K
7AlGOAgAiU/tVEdVGf0exlKW+U02g+oMusq248bduYJE3tm5/iDJE/hScnnSAex1
tYQOcuj8S/V2CPoXvY3HEaKehTsYsE/WGKmzKsj5PhWw3a5qRt9Ey2OR+839QO75
nAvd6qlwJPIPVdJYYMh1QN16jpOKdztJd4pg4B1Td+VMNJn++rMsObJxFISYgKOO
XvvaJUgv9FLiTMHGAgwcxHNOcwi8G3KRgT7BybmcQlGOIgmEu49XdC+SYya29y3d
5vGyifBhSrTBzJNAAY//ebTBY1p+B1llzZ+98Q3I8/Ex9zrFUcdWJhTlYpfzD+4a
qir8d18aFx9NPKGBOrfW6doeCo7qIw==
=EM4w
-----END PGP SIGNATURE-----

--ytt66jt4j43s74gl--
