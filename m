Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37B8463D342
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 11:25:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233810AbiK3KZd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 05:25:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbiK3KZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 05:25:31 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 881F638A6
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 02:25:30 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1p0KHR-0001cI-0N; Wed, 30 Nov 2022 11:25:29 +0100
Received: from pengutronix.de (unknown [IPv6:2a0a:edc0:0:701:38ad:958d:3def:4382])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 5F71812DD23;
        Wed, 30 Nov 2022 10:25:28 +0000 (UTC)
Date:   Wed, 30 Nov 2022 11:25:27 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc:     linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] can: etas_es58x: sort the includes by alphabetic order
Message-ID: <20221130102527.xkzzebughtsoxzsu@pengutronix.de>
References: <20221126160525.87036-1-mailhol.vincent@wanadoo.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="opbkqunsaeulf6ra"
Content-Disposition: inline
In-Reply-To: <20221126160525.87036-1-mailhol.vincent@wanadoo.fr>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--opbkqunsaeulf6ra
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 27.11.2022 01:05:25, Vincent Mailhol wrote:
> Follow the best practices, reorder the includes.
>=20
> While doing so, bump up copyright year of each modified files.
>=20
> Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>

Applied to can-next.

Thanks,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--opbkqunsaeulf6ra
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmOHL5UACgkQrX5LkNig
0113lQgAkKiA3WjiZOVWnNVhvHiNS7Kl2v7WPYIGIouAzrEV7GQxteYheg8cP/5J
VJkdRdIvE+ULQposFpb1oNBJF1ySRYZIHyeKy+VL2B9rB2lqWybd1dVsicru6T6n
sWTwsDjrf298wW5x0vdvoQF6N/NHgh53ssj79L5mblG1evkELTv+qulDh6lAAmoK
4NQg+ms9PZ1fpLf4H+iJXbepIs01FactbJICFAgSm2/xbfGr6SsRv2kuiG4fglYF
s9DxqnUVKBTOUmID70u7iPMH4N9pMJH85+KitZllOMxHwqsCKEWnxiAMUNG6Nown
S1FFmi+wMXoYLRe2PnY0/GZvFwVSHw==
=2UYg
-----END PGP SIGNATURE-----

--opbkqunsaeulf6ra--
