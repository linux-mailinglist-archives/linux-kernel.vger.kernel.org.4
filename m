Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8B4163AB54
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 15:42:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232604AbiK1OmI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 09:42:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232606AbiK1Olp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 09:41:45 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0D741D321
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 06:41:43 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ozfKF-0006du-3k; Mon, 28 Nov 2022 15:41:39 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ozfKD-000qTJ-LY; Mon, 28 Nov 2022 15:41:38 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ozfKD-000xkl-Bb; Mon, 28 Nov 2022 15:41:37 +0100
Date:   Mon, 28 Nov 2022 15:41:37 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Thierry Reding <thierry.reding@gmail.com>, od@opendingux.net,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org
Subject: Re: [PATCH 3/5] pwm: jz4740: Force dependency on Device Tree
Message-ID: <20221128144137.aavwwb3oxz5hw4ae@pengutronix.de>
References: <20221024205213.327001-1-paul@crapouillou.net>
 <20221024205213.327001-4-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mgihohoq2ffxir4a"
Content-Disposition: inline
In-Reply-To: <20221024205213.327001-4-paul@crapouillou.net>
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


--mgihohoq2ffxir4a
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 24, 2022 at 09:52:11PM +0100, Paul Cercueil wrote:
> Ingenic SoCs all require CONFIG_OF, so there is no case where we want to
> use this driver without CONFIG_OF.
>=20
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>

> ---
>  drivers/pwm/Kconfig      |  2 +-
>  drivers/pwm/pwm-jz4740.c | 10 ++++------
>  2 files changed, 5 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index 60d13a949bc5..1fe420a45f91 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -283,7 +283,7 @@ config PWM_IQS620A
>  config PWM_JZ4740
>  	tristate "Ingenic JZ47xx PWM support"
>  	depends on MIPS || COMPILE_TEST
> -	depends on COMMON_CLK
> +	depends on COMMON_CLK && OF

I think you don't even need to enforce OF here. For the compile-test
case having OF=3Dn should work fine.

Anyhow:

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--mgihohoq2ffxir4a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmOEyJ4ACgkQwfwUeK3K
7AlxPwf9Gz4JXf2XTZRSbBnXuGgyQt+OyfBEMbRTI/dWN6wERc/buzwXNno15Ue+
wxpdN6FcKgZaAyxJHVm+lLQkzGiVoU79BgZKiwtUjl9k4iPNqzhnd55k3e65JEy9
NMDRIzIEjmfJ1A9mTYRcnRMT5EnQvg/UCIAqBRENb6tskL5Bk8YdC2jQld1B7Se4
DZ1hBSK5Jg5ij7vjDH2Z8mCuMfejS98pTfr9yfMwQKrezKx1JONK/D727v+wBNWW
fdYFdHyOShfcVQNiBiDyGoYDP0aAZmTBlMMwDZEsgH8ELX39QIqdjNONBTJ6Sv+H
lt/skHCvuJW8lZnqYW9wLtjkt1id8w==
=j7d3
-----END PGP SIGNATURE-----

--mgihohoq2ffxir4a--
