Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98227620CB5
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 10:54:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233671AbiKHJyg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 04:54:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233629AbiKHJye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 04:54:34 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BAAF13E11
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 01:54:32 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1osLJM-0002jj-PL; Tue, 08 Nov 2022 10:54:28 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1osLJK-0031l1-1Z; Tue, 08 Nov 2022 10:54:26 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1osLJK-00F9gI-40; Tue, 08 Nov 2022 10:54:26 +0100
Date:   Tue, 8 Nov 2022 10:54:25 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Nicolas Palix <nicolas.palix@univ-grenoble-alpes.fr>
Cc:     Julia Lawall <julia.lawall@inria.fr>,
        nicolas palix <nicolas.palix@imag.fr>,
        kernel-janitors <kernel-janitors@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Markus Elfring <Markus.Elfring@web.de>, kernel@pengutronix.de,
        cocci@inria.fr
Subject: Re: [cocci] [PATCH] coccinelle: api: Don't use
 devm_platform_get_and_ioremap_resource with res==NULL
Message-ID: <20221108095425.6x6hkyzzm3yuofi6@pengutronix.de>
References: <20221107114702.15706-1-u.kleine-koenig@pengutronix.de>
 <bd13da2d-6d18-4f33-0987-a193e3c9b761@web.de>
 <20221107200815.u7hcwejileeabnct@pengutronix.de>
 <257596884.6156222.1667886713273.JavaMail.zimbra@inria.fr>
 <2fcd7fdb-7984-a2b7-7995-d164754c5eb2@univ-grenoble-alpes.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cdhqfdpr3heexpnd"
Content-Disposition: inline
In-Reply-To: <2fcd7fdb-7984-a2b7-7995-d164754c5eb2@univ-grenoble-alpes.fr>
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


--cdhqfdpr3heexpnd
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Tue, Nov 08, 2022 at 08:55:04AM +0100, Nicolas Palix wrote:
> On 08/11/2022 06:51, Julia Lawall wrote:
> >=20
> > > After uninstalling python2 this ends in:
> > >=20
> > > 	Cannot find Python library
> > > 	coccicheck failed
> > > 	make: *** [Makefile:2076: coccicheck] Error 255
> > >=20
> > > Didn't try to debug that any further. Is that worth a bug report agai=
nst
> > > coccinelle (which is shipped by my distribution)?
> > >=20
> > > I tried to adapt the org and report modes from other patches in the s=
ame
> > > directory. So a critical glimpse by someone more knowledgable than me=
 is
> > > recommended. However I don't know how to react to "I doubt ... is
> > > appropriate", I'd need a more constructive feedback to act on.
> >=20
> > I'm not a python expert, so I'm not sure what to do about this python2 =
vs python3 problem.  Is there some strategy for printing that works in both=
 of them?
>=20
> It sounds like a missing dependency in the package system of the
> distribution. Coccinelle has been build with Python support, but
> some libraries are missing.
>=20
> Which distribution is it ?
> Can you install some packages that provide the two missing shared librair=
ies
> ?

After installing python-is-python3 (which provides a symlink
/usr/bin/python -> python3) it works. This is on Debian testing.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--cdhqfdpr3heexpnd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmNqJ0UACgkQwfwUeK3K
7AmXgQgAmcFJy9aUUaIHGku6gDZHfpePz+YMl0P0TPx1x32DxEa2gFjL3i2Nore7
UR03MaxJhZ979jgWfOdleSA8knnVHVNud+qy2hs74WCw4fn62fr6LaWkPbL5Hh0g
WD2FoSetO5UG+LPv5YjL8LcrVlMLTMwbNAZQvmIxMNusc1EkGvAAGou4T4r5yzl5
BUHBfBdXPXfhENAUgQuvx9z+TO0RReJ0OP/YywnrcVF9owFrtR4P7amYuNbrN3at
G4YcU+7DeuTPlJ/ahkRxuFA4ghlQOeiRRDYmwkCDxg9/XYDbsDvo41CgNtHbEgNF
YSZeSf+GxaaT6jPh8Mn39t2teV8Zlg==
=0w7O
-----END PGP SIGNATURE-----

--cdhqfdpr3heexpnd--
