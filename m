Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0B756D60DE
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 14:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234772AbjDDMh3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 08:37:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234645AbjDDMhV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 08:37:21 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C655135A1
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 05:36:48 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pjft5-00085U-4q; Tue, 04 Apr 2023 14:35:47 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pjft3-008v3a-DB; Tue, 04 Apr 2023 14:35:45 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pjft2-00AVgL-In; Tue, 04 Apr 2023 14:35:44 +0200
Date:   Tue, 4 Apr 2023 14:35:44 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Brian Masney <bmasney@redhat.com>
Cc:     kernel test robot <lkp@intel.com>, jic23@kernel.org,
        llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        andriy.shevchenko@linux.intel.com, trix@redhat.com,
        lars@metafoo.de, nathan@kernel.org, ndesaulniers@google.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        hslester96@gmail.com
Subject: Re: [PATCH] iio: light: tsl2772: fix reading proximity-diodes from
 device tree
Message-ID: <20230404123544.6m5juesxwf4tklkm@pengutronix.de>
References: <20230404011455.339454-1-bmasney@redhat.com>
 <202304041451.gj8oasQp-lkp@intel.com>
 <ZCwGP6rBLgbDGvkv@x1>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="czfim3jbpqegyq4m"
Content-Disposition: inline
In-Reply-To: <ZCwGP6rBLgbDGvkv@x1>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--czfim3jbpqegyq4m
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Brian,

On Tue, Apr 04, 2023 at 07:13:03AM -0400, Brian Masney wrote:
> This doesn't contain the code that's in iio/togreg [1], and that's why
> the build failed. I originally developed / built this against
> next-20230330. I just checked linus/master, next-20230404, iio/testing,
> and all have the expected code that defines prox_diode_mask.
>=20
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/tree/dr=
ivers/iio/light/tsl2772.c?h=3Dtogreg#n593

You might want to make use of the --base parameter to git format-patch
for you next submission. With that the auto builders have a chance to
test on the right tree.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--czfim3jbpqegyq4m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmQsGZ8ACgkQj4D7WH0S
/k61mwf/ThD/ELYPWS+2DGG+2K5E/kOiiSJCCu985Ejv52/bRiUU9GH9VVFOoPU5
BmHaG2iqF8nbShTHifTEdA0bTCa6A+ipCx12P4ztQEI4AIgY9zoiqZ2sWbUiAM4r
hEdEPRy2fF6b5FUarVBNN3ySxgmika/6O3+VMG+T0SGwg8tqgCRpB0jGsOLvCjKa
V4xCW7UvkgSWz2MyIdlfI5aoea18sSMZpREWsNFjevyB9b+jZ9WC46PQS37TidUA
4Y59J5acABYXE1Ou/8BJGWT3Qbc1cgYiKnZbjOXVRNZNFM3gSb3qlH9hKXYAgSqa
ff4wQKOyGv1nIGJgI8WqfxqdCuflJg==
=E1z2
-----END PGP SIGNATURE-----

--czfim3jbpqegyq4m--
