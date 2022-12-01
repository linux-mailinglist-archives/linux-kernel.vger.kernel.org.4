Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 867AB63EAF9
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 09:25:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbiLAIZk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 03:25:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbiLAIZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 03:25:37 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E31E769315
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 00:25:34 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1p0esk-0003w4-D6; Thu, 01 Dec 2022 09:25:22 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1p0esg-001WHz-Uj; Thu, 01 Dec 2022 09:25:19 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1p0esh-001i9B-0r; Thu, 01 Dec 2022 09:25:19 +0100
Date:   Thu, 1 Dec 2022 09:25:18 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     ye.xingchen@zte.com.cn
Cc:     dmitry.torokhov@gmail.com, nick@shmanahar.org,
        giulio.benetti@benettiengineering.com,
        dario.binacchi@amarulasolutions.com, michael@amarulasolutions.com,
        oliver.graute@kococonnector.com, wsa+renesas@sang-engineering.com,
        jeff@labundy.com, johan@kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: touchscreen: use sysfs_emit() to instead of??
 scnprintf()
Message-ID: <20221201082518.xuarbpjk3ajvydqv@pengutronix.de>
References: <202212011553311204647@zte.com.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="m5r7msitbq3i675d"
Content-Disposition: inline
In-Reply-To: <202212011553311204647@zte.com.cn>
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


--m5r7msitbq3i675d
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 01, 2022 at 03:53:31PM +0800, ye.xingchen@zte.com.cn wrote:
> From: ye xingchen <ye.xingchen@zte.com.cn>
>=20
> Replace the open-code with sysfs_emit() to simplify the code.
>=20
> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>

The Subject contains two questionmarks that don't belong there.

The patch looks fine.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--m5r7msitbq3i675d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmOIZOwACgkQwfwUeK3K
7AnhCQgAj9c9leKiwLNhwKK5vdK3N8HDz/+D0hdEG0ONlYWO+9GfRXWB22TulIAj
p4mXHwFSI6LucuKpV0GyoVW7yl5gqETf0EIv4Py6ndqn/BsU0yqYCsqmJOX6d3uY
r90MnnbCYuAGDqKq3Ag3Q58DrHSBAFiAHuHh7Oke1MYKQxBW6pCpoH+WfDqMPNa4
ll8kAW3RKRsDTHyZII4sD8BPr3cRwdMWl+cg3SOHqrTb+FVdH0J3/peyn40h75+G
NCooPGlH3VkILeNEdOO7mucLNQjNbQ99meLd6PDmKfMcNWbRIzBccG5eDYhiCV/n
E/Qb6z1vtbvgXiRJ75rFSe+eUfufkg==
=+ztd
-----END PGP SIGNATURE-----

--m5r7msitbq3i675d--
