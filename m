Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A32D67D02C
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 16:27:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232097AbjAZP1h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 10:27:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231613AbjAZP1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 10:27:34 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3E2A10251
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 07:27:14 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pL49h-0003w6-7I; Thu, 26 Jan 2023 16:27:13 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pL49h-000aXL-Gg; Thu, 26 Jan 2023 16:27:12 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pL49f-00G48f-SP; Thu, 26 Jan 2023 16:27:11 +0100
Date:   Thu, 26 Jan 2023 16:27:09 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Lee Jones <lee@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH 1/2] mfd: Make .disable() callback return void
Message-ID: <20230126152709.x6l7p3kcecsam3r6@pengutronix.de>
References: <20230113182427.257484-1-u.kleine-koenig@pengutronix.de>
 <20230113182427.257484-2-u.kleine-koenig@pengutronix.de>
 <Y9KBWKNJQo0yCw2I@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="54qicnf4rh3y5ixr"
Content-Disposition: inline
In-Reply-To: <Y9KBWKNJQo0yCw2I@google.com>
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


--54qicnf4rh3y5ixr
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Thu, Jan 26, 2023 at 01:34:16PM +0000, Lee Jones wrote:
> On Fri, 13 Jan 2023, Uwe Kleine-K=F6nig wrote:
>=20
> > All implementations return 0 unconditionally, so change the prototype to
> > return void. This allows to get rid of error handling in callers that
> > isn't actually used.
> >=20
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > ---
> >  drivers/mfd/asic3.c      | 17 +++++++++--------
> >  drivers/mfd/htc-pasic3.c |  3 +--
> >  drivers/mfd/mfd-core.c   |  4 +++-
> >  drivers/mfd/t7l66xb.c    |  4 +---
> >  drivers/mfd/tc6387xb.c   |  4 +---
> >  drivers/mfd/tc6393xb.c   | 16 ++++++++++------
> >  include/linux/mfd/core.h |  2 +-
> >  7 files changed, 26 insertions(+), 24 deletions(-)
>=20
> Doesn't apply to the MFD tree.
>=20
> Please rebase and I'll merge it.

Oh, all the drivers that still provided the .enable() and .disable()
callbacks are gone now. So my patch series is superseeded by

	http://lore.kernel.org/lkml/20230126152429.580539-1-u.kleine-koenig@pengut=
ronix.de

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--54qicnf4rh3y5ixr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmPSm8kACgkQwfwUeK3K
7AldPAf7Bch4hhcYiIFdVki+2nRrlgVo/3nQtVHvfXhp81vxSwXiBizcOqMm3An8
P493WxVtH8or3o6l6GkdrrRBE/emuyAcFf2L9YThmcUueAlO0o0UZAu423vwgqxx
TZX6B8+wYSFEzL6rT/wefsWmIt2rg6Mj2/Vxw5+brgits3u3KbOFv8acd/ok3cZ8
ZmvjlfuXIpIMXkzokYhKA4wPXh6uNcRY6hy8/W5EWMmrsGo1uFqN0XQUvLtduIcz
3SC35yuld5W+AtIOAlbrLkt6rhKdwht0UTn3OXowkGo25eXI+SacEAtiSkknXm0g
KhTlYcw7LehB1NE/mWl2C5WG+3muMw==
=hIvW
-----END PGP SIGNATURE-----

--54qicnf4rh3y5ixr--
