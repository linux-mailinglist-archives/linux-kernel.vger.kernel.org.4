Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F14362A2C5
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 21:24:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231915AbiKOUYg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 15:24:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231232AbiKOUYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 15:24:21 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2874D29377
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 12:24:20 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ov2Tf-0006xt-6l; Tue, 15 Nov 2022 21:24:15 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ov2Td-004W8A-9W; Tue, 15 Nov 2022 21:24:14 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ov2Td-00Gtno-95; Tue, 15 Nov 2022 21:24:13 +0100
Date:   Tue, 15 Nov 2022 21:24:12 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v2 1/2] pwm: core: Refactor pwmchip_add() to avoid extra
 checks
Message-ID: <20221115202412.77d52oafpplzu5bw@pengutronix.de>
References: <20221114170006.61751-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zujq53fsvxh36kom"
Content-Disposition: inline
In-Reply-To: <20221114170006.61751-1-andriy.shevchenko@linux.intel.com>
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


--zujq53fsvxh36kom
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Mon, Nov 14, 2022 at 07:00:04PM +0200, Andy Shevchenko wrote:
> When we already know that everything is fine there is no need
> to use ret variable. Refactor code accordingly.
>=20
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

The patch is correct (i.e. doesn't change the semantic of the function).

But I think there is some more potential to clean up than it used here.
I will send out a series that I like better than this patch.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--zujq53fsvxh36kom
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmNz9WkACgkQwfwUeK3K
7AmVNgf/aJgPwaOzyLR1KT+wef5KlL5do/YxyTfnc10KYgRFei/OxDsdP3XYa51v
hxZF5Q2VAJQVoql7sqjOaX8q8JVlvSAFDW+uUofXrzNv2QSSl1DQThSITz46zacB
m4IJYTWCY0IgBR96Slx15ox1nnbiqf/+J/p2ZUEE3DUM1wPh1B0uJc95k2l+L18S
bdVaA3gPqb9QzjIUs++sPPJXMOoyRZMf1J+oA19Ov/2roXFh3dJAwGJ744Z+KDp2
wMFDYyB+tdgiUO9h6T3j34DnpnkOMn84OKQiosONxiU4u6R6R6C0/OhimemEJs3q
t1vmKkFp7Kc5ElXuG7P7wCjXErf9EQ==
=cCFV
-----END PGP SIGNATURE-----

--zujq53fsvxh36kom--
