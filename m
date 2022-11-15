Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B7CB629621
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 11:41:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238306AbiKOKlU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 05:41:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237577AbiKOKlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 05:41:15 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13A7823BC2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 02:41:02 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1outNC-0008RG-0W; Tue, 15 Nov 2022 11:40:58 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1outN9-004QDI-TC; Tue, 15 Nov 2022 11:40:56 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1outN9-00GlmM-PO; Tue, 15 Nov 2022 11:40:55 +0100
Date:   Tue, 15 Nov 2022 11:40:55 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Thierry Reding <thierry.reding@gmail.com>, od@opendingux.net,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org
Subject: Re: [PATCH 4/5] pwm: jz4740: Depend on MACH_INGENIC instead of MIPS
Message-ID: <20221115104055.3fd4eucczdyis35x@pengutronix.de>
References: <20221024205213.327001-1-paul@crapouillou.net>
 <20221024205213.327001-5-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="atoqpczjl5krckc7"
Content-Disposition: inline
In-Reply-To: <20221024205213.327001-5-paul@crapouillou.net>
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


--atoqpczjl5krckc7
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 24, 2022 at 09:52:12PM +0100, Paul Cercueil wrote:
> The MACH_INGENIC Kconfig option will be selected when building a kernel
> targeting Ingenic SoCs, but also when compiling a generic MIPS kernel
> that happens to support Ingenic SoCs.
>=20
> Therefore, if MACH_INGENIC is not set, we know that we're not even
> trying to build a generic kernel that supports these SoCs, and we can
> hide the options to compile the SoC-specific drivers.
>=20
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

(This patch even makes sense to apply independent of the other patches
in this series.)

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--atoqpczjl5krckc7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmNzbLQACgkQwfwUeK3K
7Alzogf+ILMdlQn3A08HYWQlRyMzbsMF0SqYrmQUinxxIUy8OYSIKdw0qjLPbRcx
sbDdBZrIVUo7GLxaYz6Eq5zwxdJOADFzAWvfXHt1gPhgIx6oQJst/jvgfxGM2PBd
yhdsjFntgYBUFiEGRJkviooq6J2C8YlmvLCAVgkH7gRAFlgBq84zcg42dc/35Xli
gsyeVPjaOTqeHxP3X7eRBf0MtjGRpb0jfhUys0HF+ZxKjOCaPn0F+JFBY+8CHuB9
fWB17dxA75H7C9ZCPUfo+RsI3RVds8Emjezy4XLNAxIQ0dHxQBMy2+Lct3ekmisw
MmsaccOJP6vqRG5InoCANNqQqtSQAQ==
=k2OR
-----END PGP SIGNATURE-----

--atoqpczjl5krckc7--
