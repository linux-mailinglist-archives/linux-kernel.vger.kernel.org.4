Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67C105E8B50
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 12:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233752AbiIXKH3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 06:07:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233751AbiIXKHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 06:07:24 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2A14115F4F
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 03:07:20 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1oc247-00013d-3t; Sat, 24 Sep 2022 12:07:19 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oc247-002chN-SQ; Sat, 24 Sep 2022 12:07:18 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oc245-003ByS-OZ; Sat, 24 Sep 2022 12:07:17 +0200
Date:   Sat, 24 Sep 2022 12:07:14 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v2 6/9] pwm: lpss: Use DEFINE_RUNTIME_DEV_PM_OPS() and
 pm_ptr() macros
Message-ID: <20220924100714.mn6o5iggv5dtucyd@pengutronix.de>
References: <20220908135658.64463-1-andriy.shevchenko@linux.intel.com>
 <20220908135658.64463-7-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zped36vm6vpe4lbp"
Content-Disposition: inline
In-Reply-To: <20220908135658.64463-7-andriy.shevchenko@linux.intel.com>
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


--zped36vm6vpe4lbp
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 08, 2022 at 04:56:55PM +0300, Andy Shevchenko wrote:
> Using these new macros allows the compiler to remove the unused dev_pm_ops
> structure and related functions if !CONFIG_PM without the need to mark
> the functions __maybe_unused.
>=20
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

that was one of the patches I thought I already acked. I didn't check if
I'm confused or if you missed to add my Ack. Doesn't really matter to
me. So:

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--zped36vm6vpe4lbp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmMu1s8ACgkQwfwUeK3K
7Am5FAf+OQYapJ/jCk41zbhZqLUzG0ridUxhAmPYcRqywdI2Q6zDm6NgJrK9YUYM
4N55j0WotPxCz8CCUyRUUYx6BisTTQMVArViyDH3URrofg9J6mQx7r6Ts8xFmOzT
Fdrvb8GLuJlM8u2M19yjALK3++J/kyPKnRC2RmEkCk72v+fb0uOMsBcbmcP4NfNu
QrGCac5GrkHEHpk9rqj7PKkube9AvxT8YQocnIzPpNx/wQX67CsJPKXNz1pzAt7V
EYa+wF/150mebW6E+DoCfzhP8FlTroudFBTNBJKKEgViAtWSy3MyosWYnvAqs0bT
31GuUUMDSvsQ/0EWF7Mt07FBUHTh7g==
=cBP5
-----END PGP SIGNATURE-----

--zped36vm6vpe4lbp--
