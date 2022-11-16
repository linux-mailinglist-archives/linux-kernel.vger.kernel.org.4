Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43C9962C06C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 15:06:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233715AbiKPOEe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 09:04:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233806AbiKPOCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 09:02:22 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A1784B999
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 05:59:26 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ovIwk-0004K4-7V; Wed, 16 Nov 2022 14:59:22 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ovIwi-004fJK-HB; Wed, 16 Nov 2022 14:59:21 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ovIwi-00H3xp-Ln; Wed, 16 Nov 2022 14:59:20 +0100
Date:   Wed, 16 Nov 2022 14:59:15 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH 3/4] pwm: Mark free pwm IDs as used in alloc_pwms()
Message-ID: <20221116135915.hvhbx6ik2g7bxeox@pengutronix.de>
References: <20221115211515.3750209-1-u.kleine-koenig@pengutronix.de>
 <20221115211515.3750209-4-u.kleine-koenig@pengutronix.de>
 <Y3SchHhvLZoRO0w6@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lbiobgeu5h4xc5gf"
Content-Disposition: inline
In-Reply-To: <Y3SchHhvLZoRO0w6@smile.fi.intel.com>
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


--lbiobgeu5h4xc5gf
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 16, 2022 at 10:17:08AM +0200, Andy Shevchenko wrote:
> On Tue, Nov 15, 2022 at 10:15:14PM +0100, Uwe Kleine-K=F6nig wrote:
> > alloc_pwms() only identified a free range of IDs and this range was mar=
ked
> > as used only later by pwmchip_add(). Instead let alloc_pwms() already do
> > the marking (which makes the function actually allocating the range and=
 so
> > justifies the function name). This way access to the allocated_pwms
> > bitfield is limited to two functions only.
>=20
> This change is a bit fragile in a long term. Currently we know that we ha=
ve
> no points of error after alloc_pwms() in ->probe(), but if somebody misses
> this in the future, we became to the case where bitmap might be exhausted
> (kinda resource leakage).

That is always the case for a function allocating resources. If you add
an error path after the (previously) last allocation, you have to care
for that.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--lbiobgeu5h4xc5gf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmN07LAACgkQwfwUeK3K
7AlPYAf/c/GG/3uEAL8cxnMqb/aioLdcAoJY1d5vpr89tziR3n+lvkaQwANMfduJ
2oX5XTDpZrAhEW4BJJmKE6tomJMCldkWtPg3etPgyE/Rk/RSu3/7k5DRmxEdaAHO
2ZbZr/2jVJI7z7G6IGCdvim7IIMXJOsNY5q4sOAcOGy9OLH1sQWtb3blBJoRpKZp
TqXszR/n0O+YylRNXMAYE5cYjQvDagGxioLUGYFtTUTDB/iigy3JD5mzcC8+SvE9
NGITHNILVZ5TnfZ/4lQlMuxC1LoaDtjsVqSpmpB1WcHxM5CurQqiBi74dyNXowHz
EAN16DbWqX4qI2SNbNVBd+253oXvTA==
=i+OA
-----END PGP SIGNATURE-----

--lbiobgeu5h4xc5gf--
