Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1389160D866
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 02:17:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232060AbiJZARc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 20:17:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231847AbiJZAR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 20:17:29 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFD17DCAF8
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 17:17:28 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1onU6l-0008WL-PG; Wed, 26 Oct 2022 02:17:23 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1onU6k-000PIO-Uj; Wed, 26 Oct 2022 02:17:22 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1onU6j-00Afdr-4i; Wed, 26 Oct 2022 02:17:21 +0200
Date:   Wed, 26 Oct 2022 02:17:13 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pwm: Add missing dummy for devm_pwmchip_add()
Message-ID: <20221026001713.kuu5mj6kogosvqnk@pengutronix.de>
References: <12f2142991690d2b1d6890821f6e7779a4d4bdc0.1666706435.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zqa4narnp7crhw3w"
Content-Disposition: inline
In-Reply-To: <12f2142991690d2b1d6890821f6e7779a4d4bdc0.1666706435.git.geert+renesas@glider.be>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zqa4narnp7crhw3w
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Geert,

On Tue, Oct 25, 2022 at 04:03:42PM +0200, Geert Uytterhoeven wrote:
> The PWM subsystem supports compile-testing if CONFIG_PWM is disabled.
> However, no dummy is provided for devm_pwmchip_add(), which may lead to
> build failures.
>=20
> Fixes: bcda91bf86c1ff76 ("pwm: Add a device-managed function to add PWM c=
hips")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Is this a problem that today yields a failure to compile? As of v6.1-rc1
and also in next all callers are below drivers/pwm/ which isn't included
in the build without PWM=3Dy.

Am I missing something or is this just preparing that one of the drivers
that doesn't live in drivers/pwm might call devm_pwmchip_add in the
future? In that case I wouldn't add that Fixes: line (and also oppose to
backporting that commit to stable).

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--zqa4narnp7crhw3w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmNYfIYACgkQwfwUeK3K
7AlyLgf/YkGLez5MHyWUIejRu61RzZY1NzxVQGROeC0xwLP7sM+/JycpjB5g9gfO
fwa+xZ2AlcgpQeGViWCocuphqDfkY41oZyM8vV1amtWFH95SNMLmWaQmaj2Jyju+
4C6fx3HvaEbHeqjGbfWo5vprt4zvM176qbQk3ow4nibPEh5ptm559vUJVe2gvAIq
EzMZcLlUPJCwn1qPtkYAheqvgmkjmZDR3t+PTLzsEvvtNNapMDH191r1cZkklURh
95VFrZdeVgEkN9lD1SD2yEVuSkT0FFe3YZ6VC2HxEfR2xFN7JYOS/MyVP8SJjBU6
Mar58HBgXjfvM8tuXwI4236r5awdsg==
=9s9V
-----END PGP SIGNATURE-----

--zqa4narnp7crhw3w--
