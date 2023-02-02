Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5229C68799C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 10:57:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231520AbjBBJ5r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 04:57:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbjBBJ5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 04:57:44 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 174109020
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 01:57:44 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pNWLZ-0003iF-0v; Thu, 02 Feb 2023 10:57:37 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pNWLV-0028n0-Kn; Thu, 02 Feb 2023 10:57:34 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pNWLW-000FIW-35; Thu, 02 Feb 2023 10:57:34 +0100
Date:   Thu, 2 Feb 2023 10:57:33 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Daniel Golle <daniel@makrotopia.org>
Cc:     devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH] dt-bindings: pwm: mediatek: add mediatek,mt7986
 compatible
Message-ID: <20230202095733.kxh6jd5hbshhif44@pengutronix.de>
References: <70fe0b606d988958b87f89828b8728e2f68eaace.1675278958.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3poqg5miyhldfntw"
Content-Disposition: inline
In-Reply-To: <70fe0b606d988958b87f89828b8728e2f68eaace.1675278958.git.daniel@makrotopia.org>
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


--3poqg5miyhldfntw
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Wed, Feb 01, 2023 at 07:25:57PM +0000, Daniel Golle wrote:
> Since commit 241eab76657f ("pwm: mediatek: Add support for MT7986")
> support for the 2 PWM channels implemented in MediaTek MT7986 SoCs has
> been added. Also add the compatible string to dt-bindings now that
> they have been converted to YAML.
>=20
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
> This patch has previously been submitted, but we decided to deferr it unt=
il
> after the conversion to YAML which has now been done via commit
> 3e98855ca0cf ("dt-bindings: pwm: mediatek: Convert pwm-mediatek to DT sch=
ema")
> See
> https://patchwork.ozlabs.org/project/devicetree-bindings/patch/Y39PjU1BqB=
B8tZ98@makrotopia.org/

This commit is currently in next via the pwm tree. The easy options are
to take this commit via pwm, too, or wait till after tne next merge
window. I'm fine with the former.

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--3poqg5miyhldfntw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmPbiQsACgkQwfwUeK3K
7AlZ/gf/XACbTC/ZQ+pLRP3fBdP2VMUoE1IWhrk00585yb1RqQMiq8Kp8jfUmkFc
8l5dcZiy2aEjptXOwByAO4T5KM9C7H9ZP5NbnYw/3mHVfVqOr3U3MhuJJmvrLCjP
bSctRudAHd10YGnkRA+55M9NSn5m8+6+444BteN9X/uXCmHI9hEjexHkMdN3Kq1n
FaGvY8/j8mNSsgnWjbFL+eXnKO19LRd1ELyWkQRpDmip34dMrwgnqiPezT3Q/LMl
yVZYYn+kkEXWqN/ygUj4qappZlcDj8B7WN3Ra15PgVBa2Rw9yfm+EObxCz0Fv78F
ykzP/+WqqBkq8Vg8uIMdOk2Jw6EC4w==
=O5cl
-----END PGP SIGNATURE-----

--3poqg5miyhldfntw--
