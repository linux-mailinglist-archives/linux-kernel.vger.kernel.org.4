Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B85BD5E9E6E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 11:56:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234725AbiIZJ4H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 05:56:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234712AbiIZJz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 05:55:58 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 279AB20350
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 02:55:55 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ockq9-0000xP-Vj; Mon, 26 Sep 2022 11:55:54 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ockqA-0030M6-N4; Mon, 26 Sep 2022 11:55:53 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ockq8-003dB7-68; Mon, 26 Sep 2022 11:55:52 +0200
Date:   Mon, 26 Sep 2022 11:55:47 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v2 2/9] pwm: lpss: Move exported symbols to PWM_LPSS
 namespace
Message-ID: <20220926095547.be5bbtyqqlm4ytgy@pengutronix.de>
References: <20220908135658.64463-1-andriy.shevchenko@linux.intel.com>
 <20220908135658.64463-3-andriy.shevchenko@linux.intel.com>
 <20220924095945.pzyhc24jhjwlfdin@pengutronix.de>
 <YzF0U7q5Fl0UaogR@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hfdadlkz3bl7lpkl"
Content-Disposition: inline
In-Reply-To: <YzF0U7q5Fl0UaogR@smile.fi.intel.com>
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


--hfdadlkz3bl7lpkl
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 26, 2022 at 12:43:47PM +0300, Andy Shevchenko wrote:
> On Sat, Sep 24, 2022 at 11:59:45AM +0200, Uwe Kleine-K=F6nig wrote:
> > Hello,
> >=20
> > On Thu, Sep 08, 2022 at 04:56:51PM +0300, Andy Shevchenko wrote:
> > > Avoid unnecessary pollution of the global symbol namespace by
> > > moving library functions in to a specific namespace and import
> > > that into the drivers that make use of the functions.
> > >=20
> > > For more info: https://lwn.net/Articles/760045/
> > >=20
> > > Suggested-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > ---
> > >  drivers/pwm/pwm-lpss-pci.c      | 1 +
> > >  drivers/pwm/pwm-lpss-platform.c | 1 +
> > >  drivers/pwm/pwm-lpss.c          | 2 ++
> > >  3 files changed, 4 insertions(+)
> > >=20
> > > diff --git a/drivers/pwm/pwm-lpss-pci.c b/drivers/pwm/pwm-lpss-pci.c
> > > index 75b778e839b3..9f2c666b95ec 100644
> > > --- a/drivers/pwm/pwm-lpss-pci.c
> > > +++ b/drivers/pwm/pwm-lpss-pci.c
> > > @@ -92,3 +92,4 @@ module_pci_driver(pwm_lpss_driver_pci);
> > > =20
> > >  MODULE_DESCRIPTION("PWM PCI driver for Intel LPSS");
> > >  MODULE_LICENSE("GPL v2");
> > > +MODULE_IMPORT_NS(PWM_LPSS);
> >=20
> > Each user of the lpss.h header needs that, right? Then the
> > MODULE_IMPORT_NS statement can go into the header, too.
>=20
> With the same answer as for v1: any user that might include the header for
> the sake of data types will get the NS inclusion even if they don't need
> that (yes, I don't think it's practical, but slightly better to make sure

I'm not sure I understand you correctly here. For some headers you
cannot assume that a file including the header also needs the namespace
macro, but for pwm-lpss.h that should be a safe assumption.

> that if one uses an API, one adds necessary NS inclusions; also note that
> in case of stale header inclusion this again might bring unnecessary NS,
> while the header should be removed -- with that being said, I think we
> might need some kind of extended includecheck to see if the APIs and data
> structures are actually used when a certain header is included).

+1 for a check about unused headers.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--hfdadlkz3bl7lpkl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmMxdyAACgkQwfwUeK3K
7AmNVggAk1GEZzKksLpjEm+h7HIHh/JThWp30glOmmKTCU7NsNkq1QZ8Yzak2oOj
oBppa/VVzvKnihoLHYVNG1cypEnuH4UuI27hFiGPpWO6JS/L5MrEKLShUyE/Sy04
dOzM4w+FC8vFtWXLaaBwF1tzJM+fKC+JP2ev2RxlLFe1EKJ8ARcrfIVYPuEygoD+
BgXHhR7WYsPrg88NPFCA4mSAC1aoE/S5d0O4Mx/YXA3mq/wccapMdOIQSdPsaj8M
UkRAmTv0G5fZYsdMTTjjfKhVdou2FZdSxfaxtzZLGxXgMnwjOt41n/NOnSnDTtHX
Zs0/c52v5gX6ERaPVWBT0TheEn+aGw==
=IBMc
-----END PGP SIGNATURE-----

--hfdadlkz3bl7lpkl--
