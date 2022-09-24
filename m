Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ECE95E8B55
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 12:10:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231390AbiIXKKA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 06:10:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbiIXKJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 06:09:57 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2230721E34
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 03:09:54 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1oc26a-0001Dj-Ht; Sat, 24 Sep 2022 12:09:52 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oc26a-002che-Rp; Sat, 24 Sep 2022 12:09:51 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oc26Y-003Bz8-GK; Sat, 24 Sep 2022 12:09:50 +0200
Date:   Sat, 24 Sep 2022 12:09:47 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v2 8/9] pwm: lpss: Add a comment to the bypass field
Message-ID: <20220924100947.jogxxhcl4cudjs4o@pengutronix.de>
References: <20220908135658.64463-1-andriy.shevchenko@linux.intel.com>
 <20220908135658.64463-9-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3y6kkrc3c7quwozr"
Content-Disposition: inline
In-Reply-To: <20220908135658.64463-9-andriy.shevchenko@linux.intel.com>
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


--3y6kkrc3c7quwozr
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 08, 2022 at 04:56:57PM +0300, Andy Shevchenko wrote:
> Add a comment to the bypass field based on the commit b997e3edca4f
> ("pwm: lpss: Set enable-bit before waiting for update-bit
> to go low").
>=20
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Looks good, added Hans (i.e. the author of b997e3edca4f) to Cc.

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

thanks
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--3y6kkrc3c7quwozr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmMu12gACgkQwfwUeK3K
7AluPAgAiEGytYa5X0P7nhaL18oXbooe44qRPWKQPOnYCaXiIU8Xb6Wx6VRq5s/w
mZ/oKIwEBvxgovDzbIWH9ZEqZZBKVM289SQO4dupes6JwDFcEadc608PYDAzVW6H
ZFxhR2IQeYoLIow/d3erBcSBBvwjzQm5QbLi4IBdJ70JjWDwfxC63+SAQgRkRs80
WagGnS1tEokkrACfE1iQ56Q4D1Zl1ZFlda/dlQQwVmn+pxtOCgNjGO1uluOHIDpE
h8rnSEq4WtQJWG5fKVO36MeOdbGQPbP9emlPwW7ZofktMrwNOrj8MibDa36uDFEn
OfcWliKa4DbO591bqyEmdrb5VnfdyA==
=Zsui
-----END PGP SIGNATURE-----

--3y6kkrc3c7quwozr--
