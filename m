Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82A9963ABF6
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 16:09:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231400AbiK1PI4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 10:08:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231863AbiK1PIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 10:08:49 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB3EE140C4
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 07:08:48 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ozfkE-0002f4-Ee; Mon, 28 Nov 2022 16:08:30 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ozfkD-000rvc-06; Mon, 28 Nov 2022 16:08:29 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ozfkD-000yxu-0Q; Mon, 28 Nov 2022 16:08:29 +0100
Date:   Mon, 28 Nov 2022 16:08:28 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Sasha Finkelstein <fnkl.kernel@gmail.com>
Cc:     thierry.reding@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, marcan@marcan.st,
        sven@svenpeter.dev, alyssa@rosenzweig.io, asahi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH RESEND v3 1/4] dt-bindings: pwm: Add Apple PWM controller
Message-ID: <20221128150828.xnzmwbfguorn22pf@pengutronix.de>
References: <20221121174228.93670-1-fnkl.kernel@gmail.com>
 <20221121174228.93670-2-fnkl.kernel@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="crknip2xs333o5v7"
Content-Disposition: inline
In-Reply-To: <20221121174228.93670-2-fnkl.kernel@gmail.com>
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


--crknip2xs333o5v7
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Sasha,

On Mon, Nov 21, 2022 at 08:42:25PM +0300, Sasha Finkelstein wrote:
> Apple SoCs such as the M1 contain a PWM controller used
> among other things to control the keyboard backlight.
>=20
> Signed-off-by: Sasha Finkelstein <fnkl.kernel@gmail.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Acked-by: Sven Peter <sven@svenpeter.dev>

With the requested changes in the other patches of this series, I'm
marking this and the addition to MAINTAINERS as changes-requested, too,
in the assumption that when (and if) you address the feedback you will
care for these two, too.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--crknip2xs333o5v7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmOEzukACgkQwfwUeK3K
7AnaqAf/Vbpl3GuTD3Vdaks/soACfcqBTAt7X9kYPRexcZ0zm0/qzw0wWQ+x087n
V9RovWR3PXCwwXe5yK9t7gJUQrKBBaGGuFEw56VypHIvXfH9GTKRB5HhIu3Fhk8G
+X3wYjSmeTPsk7eAAJSkFnSY3fwYA5bwzmaaScV8ukpFsHeZFHnbXYg5whwjS1o5
EpuUY7TUTNgWRTyzrQQfjjLk7hyeV/E84BJF6lFvWr1QQaqih37wFgDIyq6W4HCB
rWbg/v55lK9s1ZEDT5/HUPyYK8hse8rsSxiep6NRCBn/otwiagpAUco50MlkC1gN
24dNsL5HNoSsb+7Wi/iGG7Z34a4FIw==
=YL/H
-----END PGP SIGNATURE-----

--crknip2xs333o5v7--
