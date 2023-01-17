Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FE6B670C1B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 23:50:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbjAQWuF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 17:50:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbjAQWru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 17:47:50 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFED9B4E1A
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 13:49:07 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pHtog-0004mh-3v; Tue, 17 Jan 2023 22:48:26 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pHtoa-006lhq-DJ; Tue, 17 Jan 2023 22:48:20 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pHtoZ-00DhVz-MN; Tue, 17 Jan 2023 22:48:19 +0100
Date:   Tue, 17 Jan 2023 22:48:06 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Billy Tsai <billy_tsai@aspeedtech.com>
Cc:     jdelvare@suse.com, linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, joel@jms.id.au, andrew@aj.id.au,
        lee@kernel.org, thierry.reding@gmail.com, corbet@lwn.net,
        p.zabel@pengutronix.de, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [v4 0/5] Support pwm/tach driver for aspeed ast26xx
Message-ID: <20230117214806.ptnnhgxmlvyzjdzp@pengutronix.de>
References: <20221123061635.32025-1-billy_tsai@aspeedtech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="y5jqbiyht4hvalnt"
Content-Disposition: inline
In-Reply-To: <20221123061635.32025-1-billy_tsai@aspeedtech.com>
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


--y5jqbiyht4hvalnt
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Billy,

I wonder if you address the feedback you got for this series. I think
there are no big issues left, are there?

There is only one patch left open in the PWM patchwork (i.e. the patch
implementing the driver that already has my Reviewed-by tag). I'll
discard that one, too, as "changes requested" and hope you will send a
v5.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--y5jqbiyht4hvalnt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmPHF5MACgkQwfwUeK3K
7Am6Rgf/dyL2yHQajtxCDMIEYXoOPD0fs1U+AFUQZWILgnBky3GTsjqPb+iRF0Zr
w+4QERyKzgxAyfJE3EptEtnxjBOPWZ1JKx1tBpJDsEBem7ew5QmjSZ9vX28jfcaa
NR8HzbJdZKOdM/Brmd3jCKGNj63CYH8rD0CW4mUf07oVvw55j6g1ZULwVvHnOGse
DG9GpBgzzhaIPYapwlkhIdfeESU84fWfQLlOxdcNxR4/8OXDCO2lUbzXULBVbjUe
lzBlQzwJk2bQegMSAIXRIACskEMbmoMY6RBKJCJUEniyIcPyJ8//YGW1pHq8fnRO
xriqAmZs2kKuyqloDKo4g/GVvGVikQ==
=FqEI
-----END PGP SIGNATURE-----

--y5jqbiyht4hvalnt--
