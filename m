Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F06F45E8924
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 09:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233476AbiIXHaK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 03:30:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232228AbiIXHaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 03:30:04 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBA4E4F673
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 00:30:01 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1obzbr-000100-Eo; Sat, 24 Sep 2022 09:29:59 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1obzbr-002bhc-NZ; Sat, 24 Sep 2022 09:29:58 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1obzbp-003Aos-CL; Sat, 24 Sep 2022 09:29:57 +0200
Date:   Sat, 24 Sep 2022 09:29:54 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v2 0/9] pwm: lpss: Clean up and convert to a pure library
Message-ID: <20220924072954.kl7drs3cfgsn2nrl@pengutronix.de>
References: <20220908135658.64463-1-andriy.shevchenko@linux.intel.com>
 <Yy3m63T6P00SM5mp@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3fz3cwyc2kqfkitt"
Content-Disposition: inline
In-Reply-To: <Yy3m63T6P00SM5mp@smile.fi.intel.com>
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


--3fz3cwyc2kqfkitt
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Fri, Sep 23, 2022 at 08:03:39PM +0300, Andy Shevchenko wrote:
> On Thu, Sep 08, 2022 at 04:56:49PM +0300, Andy Shevchenko wrote:
> > First of all, a set of cleanups and code deduplications (for better
> > maintenance) to the PWM LPSS driver.
> >=20
> > Second, we may (re-)use the core part as a library in the future in
> > the devices that combine the same PWM IP in their address space. So
> > convert the core file to be a pure library which doesn't require any
> > special resource handling or alike.
>=20
> What happened to the PWM subsystem maintenance again?
> For weeks there is no reaction from the maintainer(s)... :-(
> If there is a lag of maintaining, perhaps we should mark it
> as Orphaned?

I thought I already acked most of the patches, will take another look.

Up to now it's Thierry who has the last word on things and applies
patches. I'm open to take a more active role.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--3fz3cwyc2kqfkitt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmMuse8ACgkQwfwUeK3K
7Al+tAf+KnRWVBIbBHRZFObI9iPBGbaUaU4lwBawN1xyEMhZoIlAWliysghQU6i0
T3wI9StdfVe+pnUeULpRtTToDasJPqec4LgWbsORSNVJQmtG1XOWobqkrXehB17L
LiBJGikNk5cpfqJJWe8MF611BusJTsRYMENEYchez2Q5UWRxr3erTnTH/z+9UeKU
OxoZtJTlsaPWaokAfyXa1wX3NuUg65ab8r+hUQgWJXaXIzaiooMX6Iyy5vQaughL
ViS8ofyNnHs0gIBz7cfp8NkMeaxBMChcpX95w6jtF8TasotU8nFA1MU1ADRrF0hv
88ULCdmL4CV2FujYsfFZdWJt/w54Rg==
=Mt3w
-----END PGP SIGNATURE-----

--3fz3cwyc2kqfkitt--
