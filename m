Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5EDE74DE07
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 21:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbjGJTQI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 15:16:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjGJTQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 15:16:07 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BBE795
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 12:16:06 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qIwMT-0005g9-NA; Mon, 10 Jul 2023 21:15:53 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qIwMS-00DUHa-Gm; Mon, 10 Jul 2023 21:15:52 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qIwMR-003roZ-Ja; Mon, 10 Jul 2023 21:15:51 +0200
Date:   Mon, 10 Jul 2023 21:15:50 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Guiting Shen <aarongt.shen@gmail.com>,
        claudiu.beznea@microchip.com, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com,
        linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pwm: atmel: enable clk when pwm already enabled in
 bootloader
Message-ID: <20230710191550.7y6wukf7w44us4pd@pengutronix.de>
References: <20230710144214.63343-1-aarongt.shen@gmail.com>
 <ZKwdHUWzXujfVk0R@orome>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sl2u4nnvvfnxkuqp"
Content-Disposition: inline
In-Reply-To: <ZKwdHUWzXujfVk0R@orome>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--sl2u4nnvvfnxkuqp
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Mon, Jul 10, 2023 at 05:00:45PM +0200, Thierry Reding wrote:
> On Mon, Jul 10, 2023 at 10:42:14PM +0800, Guiting Shen wrote:
> > +		err =3D clk_enable(atmel_pwm->clk);
> > +		if (err) {
> > +			dev_err(atmel_pwm->chip.dev, "enable clock error\n");
>=20
> Might be worth to include the error code in the error message to make it
> easier to diagnose where the issue is. Something like:
>=20
> 	dev_err(atmel_pwm->chip.dev, "failed to enable clock: %d\n", err);

Or (IMHO) still better:

 	dev_err(atmel_pwm->chip.dev, "failed to enable clock: %pe\n", ERR_PTR(err=
));

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--sl2u4nnvvfnxkuqp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmSsWOUACgkQj4D7WH0S
/k6CrQf/ZPh7B0v/lMQB6XWIpLZAQoq8phbmh3ZJXFi4z0v5GilJwz3fkO6G5/qo
A4x4I1ZLOJcUDd+6n7MPPpKSI6n63GzOnHAJCeE7GcVMdGU/r/ZYyq7ygcZG5tJA
36EBJKhfLOuMEKcP2t3B9PsYfL1U1vX+id8ktFbx7KtqzOEAP2RcyO1gbxpMg0eW
MQ/L0vJaypD9BjS19iz9L29CVzEqeHelkEhm1CdahU+Gl3Uqc+DFzlwg1Cz/LyTT
gsHK5BB0OmmZcEaKYmpml/v6puUG8O2V+mq1dfff5mHTkWKtEW2IvbNS93hHclz3
E3cqFES0oP8mpOKfBEeFMhW+V2h6Iw==
=PsHM
-----END PGP SIGNATURE-----

--sl2u4nnvvfnxkuqp--
