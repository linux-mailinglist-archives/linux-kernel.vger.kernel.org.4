Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA0756AB971
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 10:15:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbjCFJPW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 04:15:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbjCFJPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 04:15:20 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0948A1633E
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 01:15:19 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pZ6vx-0007rn-3O; Mon, 06 Mar 2023 10:15:05 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pZ6vv-002D8q-Cn; Mon, 06 Mar 2023 10:15:03 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pZ6vu-002cpx-C9; Mon, 06 Mar 2023 10:15:02 +0100
Date:   Mon, 6 Mar 2023 10:15:02 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] watchdog: s3c2410_wdt: Use
 devm_add_action_or_reset() to disable watchdog
Message-ID: <20230306091502.3zlodw6vkqqwgozj@pengutronix.de>
References: <20230304165653.2179835-1-linux@roeck-us.net>
 <20230304165653.2179835-2-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mfc65ih3brexj23r"
Content-Disposition: inline
In-Reply-To: <20230304165653.2179835-2-linux@roeck-us.net>
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


--mfc65ih3brexj23r
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 04, 2023 at 08:56:53AM -0800, Guenter Roeck wrote:
> Use devm_add_action_or_reset() to disable the watchdog when the driver
> is removed to simplify the code. With this in place, we can use
> devm_watchdog_register_device() to register the watchdog, and the removal
> function is no longer necessary.

While the cleanup in this driver is good (
Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
) I wonder if disabling the watchdog at .remove() is right.

At least there is an inconsistency among watchdog drivers if the
hardware is supposed to stop or not.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--mfc65ih3brexj23r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmQFrxMACgkQwfwUeK3K
7AmSNQgAjGAtvM1eh0nKDC870DA5F533NBiieDzs8Xd3+JEAmkPdFXu0MLd8EjKy
sSMxPj3wiqRY+amhAgphGVZnonT+mjnaB1KWVoBSE1PBQcpkkHrBht5tZB+IMxb/
t8OpkA1M1mHlW5kWTYZ/EOB9LxCheEsWhU4fZ6KXq6lufAu7V9xNbOaLYbBGnLYU
/097Drvf2CRIE5ZkEW7RXa1NnVl8CCcnJqArvXcViOnwQYp0dJXO3lUgHd7dD7ab
lEcYm3MfBhicgdaudrKvIffBxbMZkeiGCIUqVDwFcSaDirjUR1R3BMI98UoL1J9U
HumzWTJD12ZkTqK0I8xGsjzrp4FiIw==
=VJRh
-----END PGP SIGNATURE-----

--mfc65ih3brexj23r--
