Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC75C70B4FA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 08:23:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbjEVGXK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 02:23:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjEVGXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 02:23:08 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEBA7ED
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 23:23:06 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1q0ywb-0001Xd-Gv; Mon, 22 May 2023 08:22:57 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1q0ywY-001wVk-Sw; Mon, 22 May 2023 08:22:54 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1q0ywY-006nxT-7b; Mon, 22 May 2023 08:22:54 +0200
Date:   Mon, 22 May 2023 08:22:54 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Aurelien Jarno <aurelien@aurel32.net>
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, soc@kernel.org
Subject: Re: [PATCH 0/2] arm/arm64: dts: Enable device-tree overlay support
 for RPi devices
Message-ID: <20230522062254.6biyisl4qp7krm3h@pengutronix.de>
References: <20220410225940.135744-1-aurelien@aurel32.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="owu27q3xhaobzkom"
Content-Disposition: inline
In-Reply-To: <20220410225940.135744-1-aurelien@aurel32.net>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--owu27q3xhaobzkom
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Mon, Apr 11, 2022 at 12:59:38AM +0200, Aurelien Jarno wrote:
> This patchset changes the generation of the Raspberry Pi devices DTB
> files to improve the support for out-of-tree device-tree overlays, like
> it has recently been done for the Nvidia SoCs.
>=20
> I personally only need that for arm64, but I have added a similar patch
> to do the same on arm.
>=20
> Aurelien Jarno (2):
>   arm64: dts: broadcom: Enable device-tree overlay support for RPi
>     devices
>   arm: dts: Enable device-tree overlay support for RPi devices

I like these changes,

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Given there was no feedback for >1 year now, I wonder if there are good
reasons against this change, or it just fell through the cracks?!

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--owu27q3xhaobzkom
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmRrCj0ACgkQj4D7WH0S
/k7/bQf/Xf3slCx2ZMVVh1c6RAW7rjXO+Ue9JKEO4+afkalpGJNYhhbifc/NcB+8
naeNjgjhQc0g0vAP2MSK+17Tj7vysFC1wKruQ+AhC0rDeCsjGxZNTrZcMCBRyLJm
wYJU+BQxZshzkmUqZvdLQxfFnwt4r8H8cJXo3V0hgSzX9RXEyY+4X5j7n3Mg1HeH
GCY0EbiWds7uQKEMQWh6ITPS8OM8Cdacr5/bcaSM+Sb9wBOg/pejoM0fcnY2hH0w
p0zS7EQox7x4LHa5/SPO+aNrMXYi6iRlfKO/B/jWMWRBeNRnQksQFzWQ3iFCl0GY
lEJ2swJ2QggYRTK81XipLR2fa45pJw==
=T73M
-----END PGP SIGNATURE-----

--owu27q3xhaobzkom--
