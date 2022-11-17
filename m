Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D30162D974
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 12:34:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239585AbiKQLe0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 06:34:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234857AbiKQLeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 06:34:24 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E899E528B9
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 03:34:23 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ovd9v-00039Z-Bx; Thu, 17 Nov 2022 12:34:19 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ovd9t-004q7j-2f; Thu, 17 Nov 2022 12:34:18 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ovd9t-00HGYn-9G; Thu, 17 Nov 2022 12:34:17 +0100
Date:   Thu, 17 Nov 2022 12:34:17 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pwm: Add missing dummy for devm_pwmchip_add()
Message-ID: <20221117113417.rymtblijhnez3e3f@pengutronix.de>
References: <12f2142991690d2b1d6890821f6e7779a4d4bdc0.1666706435.git.geert+renesas@glider.be>
 <20221026001713.kuu5mj6kogosvqnk@pengutronix.de>
 <CAMuHMdW=h922855yyiiR2Bo+P2Dg7S7r1pVBF56S+Z0ytng3fA@mail.gmail.com>
 <20221117112758.nsxfwh4ck23uln5a@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xtrlobpfx3ir76qy"
Content-Disposition: inline
In-Reply-To: <20221117112758.nsxfwh4ck23uln5a@pengutronix.de>
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


--xtrlobpfx3ir76qy
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Thu, Nov 17, 2022 at 12:27:58PM +0100, Uwe Kleine-K=F6nig wrote:
> So the dummy isn't even needed. (Unless for the corner case GPIO_MVEBU=3Dy
> + PWM=3Dm which is probably a bug worth fixing. Maybe a similar issue
> exists for ti-sn65dsi86.)

FTR: That is not a problem, PWM is bool and so cannot be =3Dm.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--xtrlobpfx3ir76qy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmN2HDUACgkQwfwUeK3K
7AmsDwf/Z7V01fZBUwUulP5t01w5taZrXs4mNK+x4New+cdVe+9w3WvsrMrZMvn+
zczyWyo1YaWZcDXZ7P5u5AiT3uYq0LF7pf4Kpd1YqLKrPgcATpx7N7BFSYLrJD7P
E28T9+pBR+8McRkL6PcAqJ0fZgZU0hrD9Ycv22mjbuwAVBG83g7At0R5/cHMSAWb
jbvbUaUG2kHQCluJ4+SsamY1jzBIVONl6nxgGkEPsBrjowLZXmMjOvsIoKWJKUrD
yg8/nUQDFPdUeEJ5gp4PPf/rVa/Aih/eHoCauj/X1fpA8OcGtpvdj/X4tsUoG6tm
7GbdlrhfBWLkbwEK3d2k/JO3DD6HMg==
=yWoZ
-----END PGP SIGNATURE-----

--xtrlobpfx3ir76qy--
