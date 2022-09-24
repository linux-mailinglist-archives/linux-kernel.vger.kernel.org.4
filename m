Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFAF65E8B48
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 12:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233642AbiIXKBe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 06:01:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233435AbiIXKBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 06:01:30 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAD0FEBD78
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 03:01:29 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1oc1yS-00006y-6f; Sat, 24 Sep 2022 12:01:28 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oc1yS-002cgf-SA; Sat, 24 Sep 2022 12:01:27 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oc1yQ-003Bwu-6V; Sat, 24 Sep 2022 12:01:26 +0200
Date:   Sat, 24 Sep 2022 12:01:23 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v2 3/9] pwm: lpss: Move resource mapping to the glue
 drivers
Message-ID: <20220924100123.ja2wwtuti3b5fgbe@pengutronix.de>
References: <20220908135658.64463-1-andriy.shevchenko@linux.intel.com>
 <20220908135658.64463-4-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kknc7kzyfav5hghd"
Content-Disposition: inline
In-Reply-To: <20220908135658.64463-4-andriy.shevchenko@linux.intel.com>
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


--kknc7kzyfav5hghd
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 08, 2022 at 04:56:52PM +0300, Andy Shevchenko wrote:
> Move resource mapping to the glue drivers which helps
> to transform pwm_lpss_probe() to pure library function
> that may be used by others without need of specific
> resource management.
>=20
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

LGTM,
Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Thanks
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--kknc7kzyfav5hghd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmMu1XAACgkQwfwUeK3K
7Am0uAf/QSAnlRq7HiG24o/XN3P8D9T5Y7fOWqbKtzHF63lxUw+/BEzM08N55etq
HhG6B3lC631/+OyWJCC5mhCpDhpjVk/8kLZk/E4drNx0pQm0zQCMveJoZd/sH+4w
yZvIHMqT/4M3VKdah6fdsV9C6pSWA4YAMSzfBJJ1MPDTupCGN7lt4O589Rx5OYA2
S1a7gGrkW+2QBtPuKhPDu7WnOaM3YMdOnU8jKPyBdNcnipklsWkpxa4igScTu/HL
l0BVnewKOqABPgY5tarn1nOBz4JfYxAPaxU9fHn2PDEeEMUeOaUhUS0WGw8zSHhI
uxEkhlkcnAuDeuzg9tQGPgsOlFnKZA==
=NDqh
-----END PGP SIGNATURE-----

--kknc7kzyfav5hghd--
