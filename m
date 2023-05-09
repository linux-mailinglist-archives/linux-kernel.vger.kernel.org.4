Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6B786FC199
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 10:22:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234834AbjEIIWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 04:22:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234721AbjEIIWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 04:22:15 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29563B4
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 01:22:12 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pwIbe-0005j4-4k; Tue, 09 May 2023 10:21:58 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pwIba-002BuQ-Oe; Tue, 09 May 2023 10:21:54 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pwIba-002iPP-3L; Tue, 09 May 2023 10:21:54 +0200
Date:   Tue, 9 May 2023 10:21:53 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Anatolij Gustschin <agust@denx.de>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc: Drop MPC5200 LocalPlus bus FIFO driver
Message-ID: <20230509082153.jcy2qpvyd44bjaee@pengutronix.de>
References: <20221228145129.31700-1-u.kleine-koenig@pengutronix.de>
 <20230412150524.ojsvukh47hing6db@pengutronix.de>
 <87zg7cabf6.fsf@mpe.ellerman.id.au>
 <20230413061642.kqkor4wkt7lp2mhp@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jz6b5qpi3ldmi55y"
Content-Disposition: inline
In-Reply-To: <20230413061642.kqkor4wkt7lp2mhp@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jz6b5qpi3ldmi55y
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Thu, Apr 13, 2023 at 08:16:42AM +0200, Uwe Kleine-K=F6nig wrote:
> While mpc5200b.dtsi contains a device that this driver can bind to, the
> only purpose of a bound device is to be used by the four exported functio=
ns
> mpc52xx_lpbfifo_submit(), mpc52xx_lpbfifo_abort(), mpc52xx_lpbfifo_poll()
> and mpc52xx_lpbfifo_start_xfer(). However there are no callers to this
> function and so the driver is effectively superfluous and can be deleted.
> Also drop some defines and a struct from <asm/mpc52xx.h> that are unused
> now together with the declarations of the four mentioned functions.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> ---
> Hello Michael,
>=20
> On Thu, Apr 13, 2023 at 10:11:25AM +1000, Michael Ellerman wrote:
> > Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de> writes:
> > > On Wed, Dec 28, 2022 at 03:51:29PM +0100, Uwe Kleine-K=F6nig wrote:
> > >> The four exported functions mpc52xx_lpbfifo_submit(),
> > >> mpc52xx_lpbfifo_abort(), mpc52xx_lpbfifo_poll(), and
> > >> mpc52xx_lpbfifo_start_xfer() are not used. So they can be dropped an=
d the
> > >> definitions needed to call them can be moved into the driver file.
> > >>=20
> > >> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > >
> > > I never got feedback about this driver and it has not appeared in next
> > > up to now. Did it fell through the cracks?
> >=20
> > Yeah. I was hoping someone would explain what's going on with the
> > driver.
> >=20
> > Presumably there are some out-of-tree drivers that use the routines
> > provided by this driver?
>=20
> I googled for the function names but the only related hits were
> references to this thread :-)
>=20
> > I think rather than merging this patch, which keeps the code but makes
> > it completely useless, do you mind sending a patch to remove the whole
> > driver? Maybe that will get someone's attention.
>=20
> fair enough, here it is.

What is your thought about this patch? If you (also) think getting it
into next soon after a merge window closed, around now would be a good
opportunity to do so ..

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--jz6b5qpi3ldmi55y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmRaAqEACgkQj4D7WH0S
/k785Qf/ZliZLWmy9GKR+VccrZYE0nfkRJGLWHhQZhFn0In1A9R+uO+Gszh5rRZX
mH8vWixRKyYIW694+5Bcyg7SjXZzxDZQZzkDLi213lKZ60sbrxLKIgdhfjthEUoP
mKk4/I4WTPXn2RKcNGLHS828fi2cSk32bU9+WTQtWO4uKJxrv6ctW9pCWwHXQ/mj
8cGalx5YDNy38mSCtJ9se5pKES4NOSYcvPdD/xLIju5ZKyz4HIC5FZiNyNPDzh+f
F6U6VaSAME8hznCuZAEva2zZMdcEyc1WGGG38JmSKbXRFv+DiKrglvqcryzW4RsK
kRaqpzZJxx7GccK2FIsvaEJhi7SHXg==
=mgE1
-----END PGP SIGNATURE-----

--jz6b5qpi3ldmi55y--
