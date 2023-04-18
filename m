Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 150BD6E59F0
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 08:57:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231154AbjDRG45 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 02:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231148AbjDRG4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 02:56:55 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE57C65A1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 23:56:42 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pofG4-0007Yu-8t; Tue, 18 Apr 2023 08:56:08 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pofG0-00C2xk-ET; Tue, 18 Apr 2023 08:56:04 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pofFz-00E7r2-TO; Tue, 18 Apr 2023 08:56:03 +0200
Date:   Tue, 18 Apr 2023 08:56:03 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] watchdog: s3c2410_wdt: Use Use
 devm_clk_get[_optional]_enabled() helpers
Message-ID: <20230418065603.rzpiazzw4upitynt@pengutronix.de>
References: <20230304165653.2179835-1-linux@roeck-us.net>
 <20230306091048.mfrpexle24t6nwzy@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pq2sbtajlj7vfmbt"
Content-Disposition: inline
In-Reply-To: <20230306091048.mfrpexle24t6nwzy@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pq2sbtajlj7vfmbt
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Mon, Mar 06, 2023 at 10:10:48AM +0100, Uwe Kleine-K=F6nig wrote:
> On Sat, Mar 04, 2023 at 08:56:52AM -0800, Guenter Roeck wrote:
> > The devm_clk_get[_optional]_enabled() helpers:
> >     - call devm_clk_get[_optional]()
> >     - call clk_prepare_enable() and register what is needed in order to
> >       call clk_disable_unprepare() when needed, as a managed resource.
> >=20
> > This simplifies the code and avoids the calls to clk_disable_unprepare(=
).
> >=20
> > While at it, use dev_err_probe consistently, and use its return value
> > to return the error code.
> >=20
> > Cc: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>=20
> Reviewed-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

This patch is in next now as b05a2e58c16c47f3d752b7db1714ef077e5b82d9.
My name occurs twice in the tag area, once it is mangled as

	Uwe Kleine-K=3DF6nig

I would welcome fixing that (i.e. s/=3DF6/=F6/). When this commit is
touched, you can also do s/Use Use/Use/ in the Subject.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--pq2sbtajlj7vfmbt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmQ+PwIACgkQj4D7WH0S
/k5cbQf9HOO57ZgnafrxiOin35DQRKYj9Lg1Ht/m5G723CPmOxWfvTOB/HbfZ7Ka
eIGmjJvm8owFB3ZMxlvxCp8e/b8kCi5JzFZ/htcZdMWAmCiIjNx0SYj1xmGBG3xy
6vFeKnBGh02rbnALaTb7pY2TQSlNHyR3sWOpukGryOusXoe2xvKUdGKoq+GG1aD2
jzxT+ehNxDK6mnfye5uPtCuPL2ub3o922lIyU85rtSRgcSgqvIqZ8o4Dc58zVj79
IWd38kaoxHod+k/a+4iD1XSM63qn9egI+SClxk3aIRgzR48wSqRTP7h1fuppoyOy
2I6m1bXkYI1Dtx8UcsnEZsdiqOIZAA==
=aLSU
-----END PGP SIGNATURE-----

--pq2sbtajlj7vfmbt--
