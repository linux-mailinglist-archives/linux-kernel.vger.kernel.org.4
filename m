Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7A006AB963
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 10:11:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbjCFJLH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 04:11:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjCFJLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 04:11:04 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A7DB21952
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 01:11:03 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pZ6rq-0006ze-0s; Mon, 06 Mar 2023 10:10:50 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pZ6rp-002D7z-Bj; Mon, 06 Mar 2023 10:10:49 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pZ6ro-002coi-G6; Mon, 06 Mar 2023 10:10:48 +0100
Date:   Mon, 6 Mar 2023 10:10:48 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] watchdog: s3c2410_wdt: Use Use
 devm_clk_get[_optional]_enabled() helpers
Message-ID: <20230306091048.mfrpexle24t6nwzy@pengutronix.de>
References: <20230304165653.2179835-1-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lyigbiflbyrg4s2c"
Content-Disposition: inline
In-Reply-To: <20230304165653.2179835-1-linux@roeck-us.net>
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


--lyigbiflbyrg4s2c
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Guenter,

On Sat, Mar 04, 2023 at 08:56:52AM -0800, Guenter Roeck wrote:
> The devm_clk_get[_optional]_enabled() helpers:
>     - call devm_clk_get[_optional]()
>     - call clk_prepare_enable() and register what is needed in order to
>       call clk_disable_unprepare() when needed, as a managed resource.
>=20
> This simplifies the code and avoids the calls to clk_disable_unprepare().
>=20
> While at it, use dev_err_probe consistently, and use its return value
> to return the error code.
>=20
> Cc: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Reviewed-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Thanks
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--lyigbiflbyrg4s2c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmQFrhUACgkQwfwUeK3K
7AkUWggAjZpfCLm/Ilby4fMjKhFxRFyEfZKwqDxpux4Fjuxw4O89hYcn8ctvQ60j
sUQCWUMhAbzpjZdjerfFGiwKE7vb5EPddy2Z+1dj+Sa1tPnSskhmVK5vw/psK+z+
+cgbMDTYLOF7z3rkLxqylUArFEpq864t7C+FvzTKzbvwpH+ko0dx1pQTMGRcFJiL
2IJCBrg13UnSZMWWmea4wyG+HQRfcG86wVU99lOq85r73EhPXxOvB3LC4rmTlfcw
4lIT/8HulhdVSRjWzQHc/uPz8KkkkL4u574T1tuLgpQo76YdrvZkdhIfQWR1zRk4
41nx3dkWnOX96TBi7Woi3RvBZZfNIg==
=h/7I
-----END PGP SIGNATURE-----

--lyigbiflbyrg4s2c--
