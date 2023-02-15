Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC33A6982E6
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 19:04:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbjBOSEj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 13:04:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbjBOSEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 13:04:35 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ED073CE16
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 10:04:34 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pSM8f-0002SN-Cg; Wed, 15 Feb 2023 19:04:17 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pSM8a-005AGu-Sc; Wed, 15 Feb 2023 19:04:14 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pSM8b-003oDD-CX; Wed, 15 Feb 2023 19:04:13 +0100
Date:   Wed, 15 Feb 2023 19:04:10 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Sasha Finkelstein <fnkl.kernel@gmail.com>
Cc:     thierry.reding@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, marcan@marcan.st,
        sven@svenpeter.dev, alyssa@rosenzweig.io, asahi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 3/5] arm64: dts: apple: t8103: Add PWM controller
Message-ID: <20230215180410.jhontngsrb5vvv55@pengutronix.de>
References: <20230114132508.96600-1-fnkl.kernel@gmail.com>
 <20230114132508.96600-4-fnkl.kernel@gmail.com>
 <20230215111652.lyhebfntqlibtmex@pengutronix.de>
 <CAMT+MTRydNiYnhBJYVCoS5iXnhr7MywCV0t7FanHWwbwv2TrbQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yilcpz6dzlbuyk6k"
Content-Disposition: inline
In-Reply-To: <CAMT+MTRydNiYnhBJYVCoS5iXnhr7MywCV0t7FanHWwbwv2TrbQ@mail.gmail.com>
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


--yilcpz6dzlbuyk6k
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Sasha,

On Wed, Feb 15, 2023 at 05:47:07PM +0100, Sasha Finkelstein wrote:
> On Wed, 15 Feb 2023 at 12:16, Uwe Kleine-K=F6nig
> <u.kleine-koenig@pengutronix.de> wrote:
> >
> > This missing newline looks wrong.
> >
> > Otherwise the patch looks fine to me.
>
> Do you want a respin, or can this be fixed when applying the patch?

I'm not the one who will apply this patch, so I cannot say. Having said
that, I wonder who will apply. Will this go via the arm tree, or via
pwm?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--yilcpz6dzlbuyk6k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmPtHpcACgkQwfwUeK3K
7AnIUwf6A8IV/CXEap01qlTZISJ8wYlKprzqbrcfuItftWrFrVoOTL8ocSEW4fu8
sYqEZHd/xW1SkHLXn6aCg/1ujkFmMZDT9facvPhBTDzAE61zGbOL7NsDGY1hrhja
ngit5Zl77keHvabKpqNYKR9LmZtLTiqKpVKDcwhayfxGd1BRcMcA2sfm6HGjsNwi
+rIXUdzIJDC0t2rzDZAcFJWFbnScMeudnnV2A0OX/ljvDBKZLkQGDp5hHOxc6qmo
oToABe+8nrF6EtQit0ChbjudhiCrFKKezElks34G4E1Ch3cmj952/rTNHkDA5DVS
7nGERtYC2i9H2l/3kpgKsUSxI85jAw==
=ODpw
-----END PGP SIGNATURE-----

--yilcpz6dzlbuyk6k--
