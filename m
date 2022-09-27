Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E52AB5EC8C0
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 17:56:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231532AbiI0P4U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 11:56:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232313AbiI0Pzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 11:55:42 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40A45696D1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 08:55:32 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1odCve-0007tO-6Z; Tue, 27 Sep 2022 17:55:26 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1odCve-003Ff6-UJ; Tue, 27 Sep 2022 17:55:25 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1odCvc-003vkM-JT; Tue, 27 Sep 2022 17:55:24 +0200
Date:   Tue, 27 Sep 2022 17:55:21 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v3 4/8] pwm: lpss: Include headers we are direct user of
Message-ID: <20220927155521.t4hanojroe247lqr@pengutronix.de>
References: <20220927144723.9655-1-andriy.shevchenko@linux.intel.com>
 <20220927144723.9655-5-andriy.shevchenko@linux.intel.com>
 <20220927151053.7eh63stoganpgawr@pengutronix.de>
 <YzMWJFmeMAvn0e1c@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rxnw7fwrtmqvlaez"
Content-Disposition: inline
In-Reply-To: <YzMWJFmeMAvn0e1c@smile.fi.intel.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rxnw7fwrtmqvlaez
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 27, 2022 at 06:26:28PM +0300, Andy Shevchenko wrote:
> On Tue, Sep 27, 2022 at 05:10:53PM +0200, Uwe Kleine-K=F6nig wrote:
> > On Tue, Sep 27, 2022 at 05:47:19PM +0300, Andy Shevchenko wrote:
> > > For the sake of integrity, include headers we are direct user of.
> > >=20
> > > While at it, add missed struct pwm_lpss_boardinfo one and replace
> > > device.h with a forward declaration. The latter improves compile
> > > time due to reducing overhead of device.h parsing with entire train
> > > of dependencies.
> >=20
> > Hm, I copied the cmdline for the compiler from a V=3D1 build and only r=
un
> > the compiler on drivers/pwm/pwm-lpss-pci.c.
> >=20
> > With #include <device.h> I got:
> >=20
> > 	real	0m0.421s
> > 	user	0m0.354s
> > 	sys	0m0.066s
> >=20
> > With struct device; I got:
> >=20
> > 	real	0m0.431s
> > 	user	0m0.378s
> > 	sys	0m0.052s
> >=20
> > Are the numbers for you considerably different?
>=20
> Why Ingo created thousands of patches to do something similar? Because for
> a single user you won't see a big difference, but when amount of small pi=
eces
> are gathered together, you definitely will.

My doubt is that for me the effect of using struct device over #include
<device.h> is even negative (looking at real and user). Is it sys which
counts in the end?

> > > +struct device;
>=20
> ...
>=20
> > > +struct pwm_lpss_boardinfo;
> >=20
> > Hmm, I wonder why there is no compiler warning without that declaration.
> > At least in my builds. Do you see a warning? IMHO it's better to fix
> > that be swapping the order of struct pwm_lpss_chip and struct
> > pwm_lpss_boardinfo.
>=20
> Have I told about warning?

No, it's just me who expected there would be a warning if a pointer to
struct pwm_lpss_boardinfo is used before struct pwm_lpss_boardinfo is
defined (or declared).

Anyhow, I stand by my opinion that swapping the order of struct
pwm_lpss_chip and struct pwm_lpss_boardinfo is a saner fix.

> It's a proper C programming style.
> You don't have a warning because all pointers are considered to be the sa=
me,
> but it is better style to explicitly point that out.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--rxnw7fwrtmqvlaez
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmMzHOYACgkQwfwUeK3K
7AmavAf/U+jkVW0ouecO59BG5w3pv7o8Fu4dLdQr5+Cg/FsqJFKw3Nk6MFWubaJ/
LnDciWFBOSPfdQJb8fauFaBAdaIJ9WDPrvgka2lb+xlcOXCShsElepeffvEEfubq
XWuBN6mpbuLaz75HH2RK2XMABitQwXC2Pq5FrhQ+SZ5I7ZUV3PVzw/dQaHr8Ha2g
QFE9oPs6FX3YHV5SPkJ+o550ZVLGU5lmn4LtNulQaG7BzE8GOS7DziZblmIIF0sw
Wpg9TBeqo0ilEO7XEWD76tGY7RayHSbYNiENc3R6obGFyawX5DqDSCHbaGi9Kdyx
m9OeLINHOhZ4EuyO264CvzRD8z4ETw==
=bQXS
-----END PGP SIGNATURE-----

--rxnw7fwrtmqvlaez--
