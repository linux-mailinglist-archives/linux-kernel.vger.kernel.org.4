Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E7D174E7FC
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 09:30:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231177AbjGKHaz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 03:30:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjGKHax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 03:30:53 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C10EA195
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 00:30:49 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qJ7pT-0001zl-FH; Tue, 11 Jul 2023 09:30:35 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qJ7pQ-00DbCI-RQ; Tue, 11 Jul 2023 09:30:33 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qJ7pP-003zNl-Gi; Tue, 11 Jul 2023 09:30:31 +0200
Date:   Tue, 11 Jul 2023 09:30:31 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Guiting Shen <aarongt.shen@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        claudiu.beznea@microchip.com, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com,
        linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pwm: atmel: enable clk when pwm already enabled in
 bootloader
Message-ID: <20230711073031.6jpcd6z7x2oeyg5r@pengutronix.de>
References: <20230710144214.63343-1-aarongt.shen@gmail.com>
 <ZKwdHUWzXujfVk0R@orome>
 <20230710191550.7y6wukf7w44us4pd@pengutronix.de>
 <177ff5f0-3f99-646a-69b0-72c51fd1db25@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="epggeyzg3s2dweif"
Content-Disposition: inline
In-Reply-To: <177ff5f0-3f99-646a-69b0-72c51fd1db25@gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--epggeyzg3s2dweif
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 11, 2023 at 10:37:56AM +0800, Guiting Shen wrote:
> On Tue, Jul 11, 2023 at 03:15:50AM GMT+8, Uwe Kleine-K=F6nig wrote:
> > Hello,
> >=20
> > On Mon, Jul 10, 2023 at 05:00:45PM +0200, Thierry Reding wrote:
> >> On Mon, Jul 10, 2023 at 10:42:14PM +0800, Guiting Shen wrote:
> >>> +		err =3D clk_enable(atmel_pwm->clk);
> >>> +		if (err) {
> >>> +			dev_err(atmel_pwm->chip.dev, "enable clock error\n");
> >>
> >> Might be worth to include the error code in the error message to make =
it
> >> easier to diagnose where the issue is. Something like:
> >>
> >> 	dev_err(atmel_pwm->chip.dev, "failed to enable clock: %d\n", err);
> >=20
> > Or (IMHO) still better:
> >=20
> >  	dev_err(atmel_pwm->chip.dev, "failed to enable clock: %pe\n", ERR_PTR=
(err));
> >=20
>=20
> Ok, I will add it in v2 patch.
>=20
> I also found that the clk_enable() of atmel_pwm_apply() do not include
> the error code in the error message. Do I also add this in v2 patch or
> in separate patch?

Sounds to me like a separate patch.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--epggeyzg3s2dweif
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmStBRYACgkQj4D7WH0S
/k5H2gf/fC3yZQMKXIll9FtHFGPEF5QA2XVgHtLartT158adRjpeXOydD/26DSiB
DFICYSSN7PkZ7fTa0yvpCqXzIaxI17fbHXs0CAecHiC4W3Xl7PlKfULlparssXl0
sinX2A7k4ZVv9rfy1/QVXIUWYvd3TzETNvxZ++FIdSgAjMrd9hGImGj1k3oQ9XEd
fODSPsqAIYDjTeqGwaENo7c9zinbfjqc5/DfO8RG1jhoIwJtsTlcdC+z3kxA+fYU
QY1loQ94k0Jkx+uCY+JCs1yKlFH9nHvKbWhQDa6FJu/MigUs/MTrImiYhcg42byE
xnQxqebCBsDViIKctw6Ur0g0wgc0rA==
=iQZ/
-----END PGP SIGNATURE-----

--epggeyzg3s2dweif--
