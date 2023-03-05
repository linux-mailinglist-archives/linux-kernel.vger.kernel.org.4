Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FA986AAF3E
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Mar 2023 12:15:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbjCELPg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 06:15:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjCELPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 06:15:32 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14A57CC25
        for <linux-kernel@vger.kernel.org>; Sun,  5 Mar 2023 03:15:30 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pYmKZ-0003D8-Kf; Sun, 05 Mar 2023 12:15:07 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pYmKW-0020GQ-1J; Sun, 05 Mar 2023 12:15:04 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pYmKV-002Lrq-5F; Sun, 05 Mar 2023 12:15:03 +0100
Date:   Sun, 5 Mar 2023 12:15:00 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] watchdog: s3c2410_wdt: Use Use
 devm_clk_get[_optional]_enabled() helpers
Message-ID: <20230305111500.jvass6ymkity4nnd@pengutronix.de>
References: <20230304165653.2179835-1-linux@roeck-us.net>
 <93d115a2-702d-7d68-cd88-98f1c9f03f95@wanadoo.fr>
 <431a8ae1-54a7-e71a-484d-cab618a2a1c4@roeck-us.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nruzjk4jdmtrdkil"
Content-Disposition: inline
In-Reply-To: <431a8ae1-54a7-e71a-484d-cab618a2a1c4@roeck-us.net>
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


--nruzjk4jdmtrdkil
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Guenter,

On Sat, Mar 04, 2023 at 02:10:47PM -0800, Guenter Roeck wrote:
> On 3/4/23 13:46, Christophe JAILLET wrote:
> > Le 04/03/2023 =C3=A0 17:56, Guenter Roeck a =C3=A9crit=C2=A0:
> > > The devm_clk_get[_optional]_enabled() helpers:
> > > =C2=A0=C2=A0=C2=A0=C2=A0 - call devm_clk_get[_optional]()
> > > =C2=A0=C2=A0=C2=A0=C2=A0 - call clk_prepare_enable() and register wha=
t is needed in order to
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 call clk_disable_unprepare() whe=
n needed, as a managed resource.
> > >=20
> > > This simplifies the code and avoids the calls to clk_disable_unprepar=
e().
> > >=20
> > > While at it, use dev_err_probe consistently, and use its return value
> > > to return the error code.
> > >=20
> > > Cc: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> > > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > > ---
> > > =C2=A0 drivers/watchdog/s3c2410_wdt.c | 45 +++++++-------------------=
--------
> > > =C2=A0 1 file changed, 9 insertions(+), 36 deletions(-)
> > >=20
> > > diff --git a/drivers/watchdog/s3c2410_wdt.c b/drivers/watchdog/s3c241=
0_wdt.c
> > > index 200ba236a72e..a1fcb79b0b7c 100644
> > > --- a/drivers/watchdog/s3c2410_wdt.c
> > > +++ b/drivers/watchdog/s3c2410_wdt.c
> > > @@ -661,35 +661,17 @@ static int s3c2410wdt_probe(struct platform_dev=
ice *pdev)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (IS_ERR(wdt->reg_base))
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return PTR_ERR=
(wdt->reg_base);
> > > -=C2=A0=C2=A0=C2=A0 wdt->bus_clk =3D devm_clk_get(dev, "watchdog");
> > > -=C2=A0=C2=A0=C2=A0 if (IS_ERR(wdt->bus_clk)) {
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_err(dev, "failed to f=
ind bus clock\n");
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return PTR_ERR(wdt->bus_c=
lk);
> > > -=C2=A0=C2=A0=C2=A0 }
> > > -
> > > -=C2=A0=C2=A0=C2=A0 ret =3D clk_prepare_enable(wdt->bus_clk);
> > > -=C2=A0=C2=A0=C2=A0 if (ret < 0) {
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_err(dev, "failed to e=
nable bus clock\n");
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
> > > -=C2=A0=C2=A0=C2=A0 }
> > > +=C2=A0=C2=A0=C2=A0 wdt->bus_clk =3D devm_clk_get_enabled(dev, "watch=
dog");
> > > +=C2=A0=C2=A0=C2=A0 if (IS_ERR(wdt->bus_clk))
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return dev_err_probe(dev,=
 PTR_ERR(wdt->bus_clk), "failed to get bus clock\n");
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * "watchdog_src" clock is option=
al; if it's not present -- just skip it
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * and use "watchdog" clock as bo=
th bus and source clock.
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > > -=C2=A0=C2=A0=C2=A0 wdt->src_clk =3D devm_clk_get_optional(dev, "watc=
hdog_src");
> > > -=C2=A0=C2=A0=C2=A0 if (IS_ERR(wdt->src_clk)) {
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_err_probe(dev, PTR_ER=
R(wdt->src_clk),
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "failed to get source clock\n");
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D PTR_ERR(wdt->src_=
clk);
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto err_bus_clk;
> > > -=C2=A0=C2=A0=C2=A0 }
> > > -
> > > -=C2=A0=C2=A0=C2=A0 ret =3D clk_prepare_enable(wdt->src_clk);
> > > -=C2=A0=C2=A0=C2=A0 if (ret) {
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_err(dev, "failed to e=
nable source clock\n");
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto err_bus_clk;
> > > -=C2=A0=C2=A0=C2=A0 }
> > > +=C2=A0=C2=A0=C2=A0 wdt->src_clk =3D devm_clk_get_optional_enabled(de=
v, "watchdog_src");
> > > +=C2=A0=C2=A0=C2=A0 if (IS_ERR(wdt->src_clk))
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return dev_err_probe(dev,=
 PTR_ERR(wdt->src_clk), "failed to get source clock\n");
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 wdt->wdt_device.min_timeout =3D 1;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 wdt->wdt_device.max_timeout =3D s3c241=
0wdt_max_timeout(wdt);
> > > @@ -710,7 +692,7 @@ static int s3c2410wdt_probe(struct platform_devic=
e *pdev)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 S3C2410_WATCHDOG_DEFAULT_TIME);
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 dev_err(dev, "failed to use default timeout\n");
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g=
oto err_src_clk;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r=
eturn ret;
> >=20
> > Hi,
> >=20
> > Nit: this also could be "return dev_err_probe()"
> >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > @@ -718,7 +700,7 @@ static int s3c2410wdt_probe(struct platform_devic=
e *pdev)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pdev->name, pdev);
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret !=3D 0) {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_err(dev, "=
failed to install irq (%d)\n", ret);
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto err_src_clk;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
> >=20
> > Nit: this also could be "return dev_err_probe()"
> >=20
>=20
> The primary reason to call dev_err_probe() is that the error may be
> -EPROBE_DEFER, in which case the error message is suppressed.
> That is not the case for those two functions; they never return
> -EPROBE_DEFER. Calling dev_err_probe() would give the false impression
> that the functions _might_ return -EPROBE_DEFER.

That is subjective. In my book dev_err_probe() handling -EPROBE_DEFER is
only one aspect. Another is that using it allows to have return and error
message in a single line and also that if already other exit paths use
it to get a consistent style for the emitted messages. Having said that
*I* wouldn't assume that the previous call might return -EPROBE_DEFER
just because dev_err_probe() is used.

Having said that, I also don't think there is much harm if someone
thinks that a given function (here devm_request_irq()) might return
-EPROBE_DEFER.

Just my 0.02=E2=82=AC
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig         =
   |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--nruzjk4jdmtrdkil
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmQEebIACgkQwfwUeK3K
7AntMwf/TR62IQpOah4LTqIhx2YnUdabfjDbrKQGxR7wKs7CaHiXru9IknHZnW4q
IdBX1UDWv8mEufi8WKqkw26Qk0s4T5m5obaxSSllmTJLB1PPuvB3NJ12QH1+gB+8
A/lnAQ664fbhKYYj6YG9j6EFc5BX061WyRamxYEggU8lLwOS4ndz4pmiyGh3AhQ2
wjgFRmSQ9YBByQ4ZMC1KO72qeTuHD0fF5C4AxoufBc2bIkRevtvfbX4PCcswHbTr
v9HiJ1Cw+oNnZ4QtZ1PnFzBUKzdJYgdHc6FNZm3lbtNeWalX/AmVIUKhYmRlC/pW
bp4JJpFFcLaxTt2Vo4+PS7pqaM3ltA==
=2lus
-----END PGP SIGNATURE-----

--nruzjk4jdmtrdkil--
