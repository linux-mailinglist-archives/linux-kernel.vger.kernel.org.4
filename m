Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 574B75F0D06
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 16:05:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231433AbiI3OFw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 10:05:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbiI3OFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 10:05:40 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4DE8120858
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 07:05:38 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1oeGdz-0000gv-73; Fri, 30 Sep 2022 16:05:35 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oeGdy-003oRr-Uk; Fri, 30 Sep 2022 16:05:33 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oeGdw-004gaK-3l; Fri, 30 Sep 2022 16:05:32 +0200
Date:   Fri, 30 Sep 2022 16:05:31 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        kernel@pengutronix.de
Subject: Re: [PATCH] printf: Emit "SUCCESS" if NULL is passed for %pe
Message-ID: <20220930140531.r6txx6ujvvbrr7hh@pengutronix.de>
References: <20220930111050.1296018-1-u.kleine-koenig@pengutronix.de>
 <YzbyBA9uJUL/a32P@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4ypx4rksfgnluf6e"
Content-Disposition: inline
In-Reply-To: <YzbyBA9uJUL/a32P@smile.fi.intel.com>
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


--4ypx4rksfgnluf6e
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 30, 2022 at 04:41:24PM +0300, Andy Shevchenko wrote:
> On Fri, Sep 30, 2022 at 01:10:50PM +0200, Uwe Kleine-K=F6nig wrote:
> > For code that emits a string representing a usual return value it's
> > convenient to have a 0 result in a string representation of success
> > instead of "00000000".
>=20
> This is a controversial change. For APIs that comes to my mind it means
> "OPTIONAL resource NOT FOUND, while no error happened". Doe it mean succe=
ss?
> I don't think so.

OK, agreed. Would you feed such a value unchecked to %pe today (i.e.
without my patch)?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--4ypx4rksfgnluf6e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmM296kACgkQwfwUeK3K
7AnR2QgAg9FaWUXNc7BxXtK31qFoB3NgxoL8wifYIK/ImQlVVhJ8Nfn3WvJd/YNQ
1UoDiIdArC5w3Kq6UimcUu4nbRBd/CDB42LFRrDwEaBHUfBI3d9q68Rew229fjMk
IeCl0UcczFHyjYyHGbi+rVGQCNvfyLqA5kSc1n78yArMdaz1La9xkVVoKQn188I+
3gp9b5f+dnruYVD17XMVNAB8ufnUx0K8mwl3unnMKeB2xErEluZaXJhLkxsAbVqa
QcCHqsgrjNZTzcEej5NHPY7zLcWSEiMlSHXHvOT+EdJ/MEuQyJHi9wzmY9pbJVLp
KQSqV95ugIC5PjjnqTOQeVZQJdIIIw==
=ThnC
-----END PGP SIGNATURE-----

--4ypx4rksfgnluf6e--
