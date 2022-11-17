Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FE4562D631
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 10:13:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239777AbiKQJNw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 04:13:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239817AbiKQJNr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 04:13:47 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01049B7E6
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 01:13:45 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ovaxc-0005Sg-6M; Thu, 17 Nov 2022 10:13:28 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ovaxY-004p1e-EC; Thu, 17 Nov 2022 10:13:25 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ovaxY-00HF1m-OS; Thu, 17 Nov 2022 10:13:24 +0100
Date:   Thu, 17 Nov 2022 10:13:24 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Naresh Solanki <naresh.solanki@9elements.com>
Cc:     devicetree@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Marcello Sylvester Bauer <sylv@sylv.io>,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH v6 3/3] hwmon: (max6639) Change from pdata to dt
 configuration
Message-ID: <20221117091324.h7etwyzckzvpoa4p@pengutronix.de>
References: <20221116213615.1256297-1-Naresh.Solanki@9elements.com>
 <20221116213615.1256297-4-Naresh.Solanki@9elements.com>
 <20221117074510.qqtjc6h3bnh5rccx@pengutronix.de>
 <81cd642f-c5fb-77ec-a634-5655d5b6088c@9elements.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lbqlkkiplftnkolk"
Content-Disposition: inline
In-Reply-To: <81cd642f-c5fb-77ec-a634-5655d5b6088c@9elements.com>
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


--lbqlkkiplftnkolk
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 17, 2022 at 02:10:45PM +0530, Naresh Solanki wrote:
>=20
>=20
> On 17-11-2022 01:15 pm, Uwe Kleine-K=F6nig wrote:
> > Hello,
> >=20
> > On Wed, Nov 16, 2022 at 10:36:15PM +0100, Naresh Solanki wrote:
> > > max6639_platform_data is not used by any in-kernel driver and does not
> > > address the MAX6639 fans separately.
> > > Move to device tree configuration with explicit properties to configu=
re
> > > each fan.
> > >=20
> > > Non-DT platform can still use this module with its default
> > > configuration.
> > >=20
> > > Signed-off-by: Marcello Sylvester Bauer <sylv@sylv.io>
> > > Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
> >=20
> > What changed here since v5? Please either add a changelog below the
> > tripple-dash for a new revision, or make sure that all relevant people
> > get the cover letter.
> >=20
> > It seems you didn't address my comments for v5 :-\
> Not sure what I missed but did following changes:
> Removed unused header max6639.h
> Used dev_err_probe instead,
> Removed of_pwm_n_cells,
> if condition for freq_table
> removed pwm_get_state & instead use pwm->state
> division/multiplication optimizations,
> indentation of freq_table,

In the cover letter you just wrote:

| Changes in V6:
| - Remove unused header file
| - minor cleanup

which is too short in my eyes. If you wrote instead:

	Address review feedback by Uwe Kleine-K=F6nig in patch #3, patches #1 and
	#2 unchanged.

This would be much more helpful as people that were already happy with
v5 wouldn't need to look at the first two patches and I would know that
you addressed my feedback and would have looked in more detail.

What I miss is the most critical part of my feedback, i.e.:
| My overall impression is that this patch mixes too much things. IMHO it
| should be split in (at least)
|=20
|  - Add dt support
|  - Drop platform support
|  - Add PWM provider support
|  - Make use of the PWM API
|
| maybe also add the 2nd PWM in a separate step.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--lbqlkkiplftnkolk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmN1+zEACgkQwfwUeK3K
7AkGRwgAllZK66a+YhErW6Qlvi+M9Bd/nwKnyEiAsvmyQ2IadpKiThbMr6uw0y5/
qlrC3gMnhKzY8u0AFTFGnZlQOS+fCVeopgahPdA5ZJNW4GvNcPXB8qHDXwdzVQOf
yRQkbpYnu9Pt8Wtxew0QWnCeW+s/BVbJJSrWJYWZgonp+OX0dl19Su2yO+H6agHF
TDExZrPMv8ds4Nxj7TM5V7MJn8TZ9pxecfJjFcudvTEMTkgPZ5R+EY45+L8Jg29l
b1BRWtoDEwku4K1GTIb1BRMJ3JRS3pJVunj3R88/E128yY3vno9TownFtSSG5s/1
+RsohjtFf/cRwzqaoYdWALCulw4anQ==
=MgIF
-----END PGP SIGNATURE-----

--lbqlkkiplftnkolk--
