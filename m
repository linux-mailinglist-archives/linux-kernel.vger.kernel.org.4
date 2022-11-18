Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D37362EEE5
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 09:07:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241324AbiKRIH3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 03:07:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232532AbiKRIH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 03:07:26 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D68C10B71
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 00:07:25 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ovwPA-0004TK-Sl; Fri, 18 Nov 2022 09:07:20 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ovwP8-0050qW-UD; Fri, 18 Nov 2022 09:07:19 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ovwP9-00HSNy-7o; Fri, 18 Nov 2022 09:07:19 +0100
Date:   Fri, 18 Nov 2022 09:07:19 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v3 1/1] pwm: core: Remove S_IFREG from
 debugfs_create_file()
Message-ID: <20221118080719.x2r7qbr6f7ijbo5i@pengutronix.de>
References: <20221117165812.27757-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="um3pfpcxcxoyxslf"
Content-Disposition: inline
In-Reply-To: <20221117165812.27757-1-andriy.shevchenko@linux.intel.com>
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


--um3pfpcxcxoyxslf
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Thu, Nov 17, 2022 at 06:58:12PM +0200, Andy Shevchenko wrote:
> The debugfs_create_file() already has a check and adds S_IFREG
> automatically. Remove unneeded flag.
>=20
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> v3: resent as a standalone patch (Uwe)

My idea was that Thierry picks v2 from the initial series, my intention
wasn't to make you resend it alone. Anyhow:

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--um3pfpcxcxoyxslf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmN3PTQACgkQwfwUeK3K
7AniOQf/bumMVsV6WFjdbu17fipvjCKpYh6vwPC9mInzKA4XVbcn/iLcaXR3sY8u
ZY9iUlgBARvsga4g2zU8p0uur+2mMfzoljU7NeObWQNt0S8O+SY99gaBcge1txFy
U81R2/vzVGwjjLuhhdvVPXC/HWKaIJqCBVD3hUGFRl3Bt1WLdfABhh0a7NbMI6g+
NzKKhMTvq1tGVW2eLIEPGBfM/G1eXk0FSqsuW4LiofeymEKrVXx0p54O2fRil46B
eYVLbJZEU0eURgKBDAAt1/EJ9Las1mMrW9gI4xaZb78szFuZv61jnJJm5urITVoQ
2m2QUI2nRqVIx8Leddm7DMdsoPHujw==
=t6DK
-----END PGP SIGNATURE-----

--um3pfpcxcxoyxslf--
