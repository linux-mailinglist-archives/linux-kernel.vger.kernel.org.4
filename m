Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A63C62451B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 16:07:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbiKJPHh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 10:07:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbiKJPHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 10:07:34 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 646641E3EC
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 07:07:33 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ot99P-0007vO-NI; Thu, 10 Nov 2022 16:07:31 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ot99N-003TlX-9E; Thu, 10 Nov 2022 16:07:30 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ot99N-00Ff53-BG; Thu, 10 Nov 2022 16:07:29 +0100
Date:   Thu, 10 Nov 2022 16:07:29 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     Nicolas Palix <nicolas.palix@imag.fr>,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de, cocci@inria.fr
Subject: Re: [PATCH v2] coccinelle: api: Don't use
 devm_platform_get_and_ioremap_resource with res==NULL
Message-ID: <20221110150729.afctso5mtl3y5lf4@pengutronix.de>
References: <20221107114702.15706-1-u.kleine-koenig@pengutronix.de>
 <28e17fb9-cec1-4a89-1492-cd3ece7a9487@inria.fr>
 <20221107181135.tm2wmwiulepsyrmk@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="apoiwhxzieqvvybw"
Content-Disposition: inline
In-Reply-To: <20221107181135.tm2wmwiulepsyrmk@pengutronix.de>
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


--apoiwhxzieqvvybw
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Mon, Nov 07, 2022 at 07:11:35PM +0100, Uwe Kleine-K=F6nig wrote:
> devm_platform_get_and_ioremap_resource(pdev, index, NULL) is equivalent to
> the shorter devm_platform_ioremap_resource(pdev, index).
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> ---
> On Mon, Nov 07, 2022 at 08:45:38PM +0800, Julia Lawall wrote:
> > On Mon, 7 Nov 2022, Uwe Kleine-K=F6nig wrote:
> >=20
> > > devm_platform_get_and_ioremap_resource(pdev, index, NULL) is equivale=
nt to
> > > the shorter devm_platform_ioremap_resource(pdev, index).
> > >
> > > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > > ---
> > > Hello,
> > >
> > > a potential improvement is to check for invocations of
> > > devm_platform_get_and_ioremap_resource() where the res parameter isn't
> > > used afterwards, but my coccinelle foo isn't strong enough for that.
> >=20
> > ... when !=3D res
> >=20
> > I'm not sure where you wanted to put it though.
>=20
> I tinkered a bit further and even succeeded to remove the declaration if
> it's otherwise unused.
>=20
> I failed to test the report mode, my spatch tells me some error about
> python2?!

For the record, that is a problem with Debian's coccinelle, bugreport=20
at https://bugs.debian.org/1023653

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--apoiwhxzieqvvybw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmNtE64ACgkQwfwUeK3K
7AnvVgf9GKKPPyISBHKDpcKOzc1KNYOlBfxOfqfr4+tZTm1r3//Q8dvjheB0c2Ke
a+tjXHqDCmfS0a5zj/iLGVoTJ5xZM78fuvmS+CfnvZexrrrYp/OZM7xHXwmRNItA
9y99JjQ3veo+G31AUYEzron7qslnWUCbqiQoNI7bc6wm3z+rjzKhEJSYD/jsgp5L
ycstaNQKo7zqRfNmIJ8wpkHn2qs+0H15S/VjMz6AeV3INdsl0tebAx9C6brrBqVt
wGhGQ0cV/dlfHSsvKM8xZzgIrO5rBPLmWwx0qRtFmZri9LGuCgvOOwQAovRo7U0U
+omTn7ykFlSRADOxtZSmp894lJZ+Pw==
=vJuU
-----END PGP SIGNATURE-----

--apoiwhxzieqvvybw--
