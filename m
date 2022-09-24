Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8905C5E8B4A
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 12:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233716AbiIXKFE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 06:05:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbiIXKFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 06:05:01 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6D3F36870
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 03:04:59 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1oc21p-0000kO-SB; Sat, 24 Sep 2022 12:04:57 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oc21q-002ch7-KQ; Sat, 24 Sep 2022 12:04:57 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oc21o-003Bxd-C9; Sat, 24 Sep 2022 12:04:56 +0200
Date:   Sat, 24 Sep 2022 12:04:53 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v2 4/9] pwm: lpss: Include headers we are direct user of
Message-ID: <20220924100453.hupbeotwqrehc4yq@pengutronix.de>
References: <20220908135658.64463-1-andriy.shevchenko@linux.intel.com>
 <20220908135658.64463-5-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="47jfuq66hwnevjmr"
Content-Disposition: inline
In-Reply-To: <20220908135658.64463-5-andriy.shevchenko@linux.intel.com>
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


--47jfuq66hwnevjmr
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 08, 2022 at 04:56:53PM +0300, Andy Shevchenko wrote:
> For the sake of integrity, include headers we are direct user of.
>=20
> While at it, replace device.h with a forward declaration and add
> missed struct pwm_lpss_boardinfo one.
>=20
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/pwm/pwm-lpss.h | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/pwm/pwm-lpss.h b/drivers/pwm/pwm-lpss.h
> index c344921b2cab..839622964b2a 100644
> --- a/drivers/pwm/pwm-lpss.h
> +++ b/drivers/pwm/pwm-lpss.h
> @@ -10,11 +10,15 @@
>  #ifndef __PWM_LPSS_H
>  #define __PWM_LPSS_H
> =20
> -#include <linux/device.h>
>  #include <linux/pwm.h>
> +#include <linux/types.h>
> =20
>  #define MAX_PWMS			4
> =20
> +struct device;

It's not clear to me how this is an improvment. Isn't it saner to
include <linux/device.h>?

> +struct pwm_lpss_boardinfo;

Why is this necessary? The struct is defined a few lines below the
context of this patch and I see no user that would benefit.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--47jfuq66hwnevjmr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmMu1kIACgkQwfwUeK3K
7AlamAf/da0g9V09MPj9pr+Fcj7wdKmqtsIvWW9rz3g6glVS6HNpATjwsxoTkaIk
14hu1Q9C9zO7YAnXz+ou50XL93JcyAOGTzyWlAznfulQ3XaYy3O3UpLrwSvirOYb
Jk82fsNn9gysglXm2cXGMzgfGcU/6+FJq4oz77nsnLTEWYx4ZAPM5Pofr0szOJ3A
D6E+vVM3Z5FYEjSGARZEQKoX9ERpzjfZosuk8Pllb95lJEJH2ifPZSDes4cLoi0o
ZyVz8tNohs5yquWTOcekWbAY58mz5tjLQmgxE6W20qm5GhwegVrAMmaH610KIxni
zU2jXJB175e32ZxxTPtFvZXBlmpQpw==
=tZGf
-----END PGP SIGNATURE-----

--47jfuq66hwnevjmr--
