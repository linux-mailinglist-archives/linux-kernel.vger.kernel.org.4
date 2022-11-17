Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40B3662DD54
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 14:54:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240223AbiKQNy1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 08:54:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239965AbiKQNyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 08:54:23 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B317419B8
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 05:54:22 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ovfLO-0000cp-Cg; Thu, 17 Nov 2022 14:54:18 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ovfLM-004rbz-Pb; Thu, 17 Nov 2022 14:54:17 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ovfLN-00HIB5-2y; Thu, 17 Nov 2022 14:54:17 +0100
Date:   Thu, 17 Nov 2022 14:54:16 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v2 1/2] pwm: core: Refactor pwmchip_add() to avoid extra
 checks
Message-ID: <20221117135416.jxpqxnouei66e245@pengutronix.de>
References: <20221114170006.61751-1-andriy.shevchenko@linux.intel.com>
 <20221115202412.77d52oafpplzu5bw@pengutronix.de>
 <Y3Sd4BYkkjLUv5ka@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="l63j6wcvafrc4sog"
Content-Disposition: inline
In-Reply-To: <Y3Sd4BYkkjLUv5ka@smile.fi.intel.com>
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


--l63j6wcvafrc4sog
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 16, 2022 at 10:22:56AM +0200, Andy Shevchenko wrote:
> On Tue, Nov 15, 2022 at 09:24:12PM +0100, Uwe Kleine-K=F6nig wrote:
> > On Mon, Nov 14, 2022 at 07:00:04PM +0200, Andy Shevchenko wrote:
> > > When we already know that everything is fine there is no need
> > > to use ret variable. Refactor code accordingly.
> > >=20
> > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> >=20
> > The patch is correct (i.e. doesn't change the semantic of the function).
> >=20
> > But I think there is some more potential to clean up than it used here.
> > I will send out a series that I like better than this patch.
>=20
> Fine, can you attach the second patch of this series to yours v2, please?

These are independant cleanups. I suggest that Thierry just picks up the
other patch in this series (assuming of course he is OK with it).

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--l63j6wcvafrc4sog
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmN2PQUACgkQwfwUeK3K
7AlB3QgAiGxto5CYRNNZjNwyu+v3C4veJub8XywrOtYA2xelo/KX/oNbX+BSaygg
t+W950GvjiXU2XQk3xKvUOGN0cI21VEhy+QQ6U3A+j7SRZqPBTmhJ0ho39ZBCdoF
VXqyMTd1eZRXUEAH8vWxVYta8PX9xYChiAypBI2MT5YBfPzNPKKli1PSTSOnvuv5
6CX5VGTS+wBm0xd2713F/I13mn6lJbDOjtPFOfNm00R0bUhFBKD4+GfZ/xxK38yP
knuvZZsmH516IlO34lnQuImp8/m/VLTK3jD6DdwKd9XLAAt+iX/iooLZQOZp2t8e
Xf3dk55w6A0oFafSc4l5e+9SgUY49g==
=nmLb
-----END PGP SIGNATURE-----

--l63j6wcvafrc4sog--
