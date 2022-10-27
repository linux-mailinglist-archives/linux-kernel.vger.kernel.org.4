Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0646F60F396
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 11:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234571AbiJ0JWr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 05:22:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235002AbiJ0JWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 05:22:43 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35C774B999
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 02:22:42 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1onz5p-0007LF-Or; Thu, 27 Oct 2022 11:22:29 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1onz5p-000fr5-4o; Thu, 27 Oct 2022 11:22:28 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1onz5n-00B4Xo-IF; Thu, 27 Oct 2022 11:22:27 +0200
Date:   Thu, 27 Oct 2022 11:22:27 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Romain Perier <romain.perier@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Palmer <daniel@0x0f.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/5] pwm: Add support for the MSTAR MSC313 PWM
Message-ID: <20221027092227.wkxjsw6mep3o3auc@pengutronix.de>
References: <20220907131241.31941-1-romain.perier@gmail.com>
 <20220907131241.31941-3-romain.perier@gmail.com>
 <20220927163314.rzfld7sqchsdfvfg@pengutronix.de>
 <CABgxDoJmVRbZEP02QoEhHKXiu127073oK2NE2VgFHBADCBbdog@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gok45hmzf5nviwgp"
Content-Disposition: inline
In-Reply-To: <CABgxDoJmVRbZEP02QoEhHKXiu127073oK2NE2VgFHBADCBbdog@mail.gmail.com>
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


--gok45hmzf5nviwgp
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Romain,

On Thu, Oct 27, 2022 at 10:36:10AM +0200, Romain Perier wrote:
> Le mar. 27 sept. 2022 =E0 18:33, Uwe Kleine-K=F6nig
> <u.kleine-koenig@pengutronix.de> a =E9crit :
> >
> > Hello Romain, hello Daniel,
> >
> > adding Mark Brown to Cc: for the regmap stuff.
> >
> > On Wed, Sep 07, 2022 at 03:12:38PM +0200, Romain Perier wrote:
> > > From: Daniel Palmer <daniel@0x0f.com>
> > >
> > > This adds support for the PWM block on the Mstar MSC313e SoCs and new=
er.
> > >
> > > Signed-off-by: Daniel Palmer <daniel@0x0f.com>
> > > Co-developed-by: Romain Perier <romain.perier@gmail.com>
> > > Signed-off-by: Romain Perier <romain.perier@gmail.com>
> > > ---
> > >  MAINTAINERS               |   1 +
> > >  drivers/pwm/Kconfig       |   9 ++
> > >  drivers/pwm/Makefile      |   1 +
> > >  drivers/pwm/pwm-msc313e.c | 269 ++++++++++++++++++++++++++++++++++++=
++
> > >  4 files changed, 280 insertions(+)
> > >  create mode 100644 drivers/pwm/pwm-msc313e.c
> > >
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index 9d7f64dc0efe..c3b39b09097c 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -2439,6 +2439,7 @@ F:      arch/arm/mach-mstar/
> > >  F:   drivers/clk/mstar/
> > >  F:   drivers/clocksource/timer-msc313e.c
> > >  F:   drivers/gpio/gpio-msc313.c
> > > +F:   drivers/pwm/pwm-msc313e.c
> > >  F:   drivers/rtc/rtc-msc313.c
> > >  F:   drivers/watchdog/msc313e_wdt.c
> > >  F:   include/dt-bindings/clock/mstar-*
> > > diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> > > index 60d13a949bc5..8049fd03a821 100644
> > > --- a/drivers/pwm/Kconfig
> > > +++ b/drivers/pwm/Kconfig
> > > @@ -372,6 +372,15 @@ config PWM_MESON
> > >         To compile this driver as a module, choose M here: the module
> > >         will be called pwm-meson.
> > >
> > > +config PWM_MSC313E
> > > +     tristate "MStar MSC313e PWM support"
> > > +     depends on ARCH_MSTARV7 || COMPILE_TEST
> > > +     help
> > > +       Generic PWM framework driver for MSTAR MSC313e.
> > > +
> > > +       To compile this driver as a module, choose M here: the module
> > > +       will be called pwm-msc313e.
> > > +
> > >  config PWM_MTK_DISP
> > >       tristate "MediaTek display PWM driver"
> > >       depends on ARCH_MEDIATEK || COMPILE_TEST
> > > diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> > > index 7bf1a29f02b8..bc285c054f2a 100644
> > > --- a/drivers/pwm/Makefile
> > > +++ b/drivers/pwm/Makefile
> > > @@ -62,4 +62,5 @@ obj-$(CONFIG_PWM_TWL)               +=3D pwm-twl.o
> > >  obj-$(CONFIG_PWM_TWL_LED)    +=3D pwm-twl-led.o
> > >  obj-$(CONFIG_PWM_VISCONTI)   +=3D pwm-visconti.o
> > >  obj-$(CONFIG_PWM_VT8500)     +=3D pwm-vt8500.o
> > > +obj-$(CONFIG_PWM_MSC313E)    +=3D pwm-msc313e.o
> > >  obj-$(CONFIG_PWM_XILINX)     +=3D pwm-xilinx.o
> > > diff --git a/drivers/pwm/pwm-msc313e.c b/drivers/pwm/pwm-msc313e.c
> > > new file mode 100644
> > > index 000000000000..a71f39ba66c3
> > > --- /dev/null
> > > +++ b/drivers/pwm/pwm-msc313e.c
> > > @@ -0,0 +1,269 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * Copyright (C) 2021 Daniel Palmer <daniel@thingy.jp>
> > > + * Copyright (C) 2022 Romain Perier <romain.perier@gmail.com>
> > > + */
> > > +
> > > +#include <linux/clk.h>
> > > +#include <linux/of_device.h>
> > > +#include <linux/pwm.h>
> > > +#include <linux/regmap.h>
> > > +
> > > +#define DRIVER_NAME "msc313e-pwm"
> > > +
> > > +#define CHANNEL_OFFSET       0x80
> > > +#define REG_DUTY     0x8
> > > +#define REG_PERIOD   0x10
> > > +#define REG_DIV              0x18
> > > +#define REG_CTRL     0x1c
> > > +#define REG_SWRST    0x1fc
> > > +
> > > +struct msc313e_pwm_channel {
> > > +     struct regmap_field *clkdiv;
> > > +     struct regmap_field *polarity;
> > > +     struct regmap_field *dutyl;
> > > +     struct regmap_field *dutyh;
> > > +     struct regmap_field *periodl;
> > > +     struct regmap_field *periodh;
> > > +     struct regmap_field *swrst;
> > > +};
> > > +
> > > +struct msc313e_pwm {
> > > +     struct regmap *regmap;
> > > +     struct pwm_chip pwmchip;
> > > +     struct clk *clk;
> > > +     struct msc313e_pwm_channel channels[];
> > > +};
> > > +
> > > +struct msc313e_pwm_info {
> > > +     unsigned int channels;
> > > +};
> > > +
> > > +#define to_msc313e_pwm(ptr) container_of(ptr, struct msc313e_pwm, pw=
mchip)
> > > +
> > > +static const struct regmap_config msc313e_pwm_regmap_config =3D {
> > > +     .reg_bits =3D 16,
> > > +     .val_bits =3D 16,
> > > +     .reg_stride =3D 4,
> > > +};
> > > +
> > > +static const struct msc313e_pwm_info msc313e_data =3D {
> > > +     .channels =3D 8,
> > > +};
> > > +
> > > +static const struct msc313e_pwm_info ssd20xd_data =3D {
> > > +     .channels =3D 4,
> > > +};
> > > +
> > > +static void msc313e_pwm_writecounter(struct regmap_field *low, struc=
t regmap_field *high, u32 value)
> > > +{
> > > +     /* The bus that connects the CPU to the peripheral registers sp=
lits 32 bit registers into
> >
> > Please fix the comment style to use /* on a line for itself. Also for
> > comments staying below 80 chars per line is appreciated.
>=20
> even if check-patch.pl --strict passed ? ^^

I also already wondered about check-patch not demanding this. *shrug*

> > > +      * two 16bit registers placed 4 bytes apart. It's the hardware =
design they used. The counter
> > > +      * we are about to write has this contrainst.
> >
> > s/contrainst/contraint/
> >
> > I wonder if that could be abstracted by regmap?!
>=20
> I had the same thought, not from what I have read/found, but perhaps
> the regmap maintainer has an opinion.
>=20
> >
> > > +      */
> > > +     regmap_field_write(low, value & 0xffff);
> > > +     regmap_field_write(high, value >> 16);
> > > +}
> > > +
> > > +static void msc313e_pwm_readcounter(struct regmap_field *low, struct=
 regmap_field *high, u32 *value)
> > > +{
> > > +     unsigned int val =3D 0;
> > > +
> > > +     regmap_field_read(low, &val);
> > > +     *value =3D val;
> > > +     regmap_field_read(high, &val);
> > > +     *value =3D (val << 16) | *value;
> > > +}
> > > +
> > > +static int msc313e_pwm_config(struct pwm_chip *chip, struct pwm_devi=
ce *device,
> > > +                           int duty_ns, int period_ns)
> > > +{
> > > +     struct msc313e_pwm *pwm =3D to_msc313e_pwm(chip);
> > > +     unsigned long long nspertick =3D DIV_ROUND_DOWN_ULL(NSEC_PER_SE=
C, clk_get_rate(pwm->clk));
> > > +     struct msc313e_pwm_channel *channel =3D &pwm->channels[device->=
hwpwm];
> > > +     unsigned long long div =3D 1;
> > > +
> > > +     /* Fit the period into the period register by prescaling the cl=
k */
> > > +     while (DIV_ROUND_DOWN_ULL(period_ns, nspertick) > 0x3ffff) {
> >
> > dividing by the result of a division looses precision. Also rounding
> > down both divisions looks wrong.
>=20
> Such cases are not supposed to be covered by PWM_DEBUG ? (because
> everything passed with PWM_DEBUG)

Note that PWM_DEBUG being silent isn't an indicator that everything is
fine. It cannot catch everything and so doesn't replace human review.

If you tell me what clk_get_rate() returns for you, I might be able to
tell you a procedure that makes PWM_DEBUG unhappy.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--gok45hmzf5nviwgp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmNaTdAACgkQwfwUeK3K
7AnMqgf8DzFsEd9BI2kFodRUCfC6mjEpPasgkBKB6PUykVv8BpgpneGcod1ZuGaf
mFa8bCcs+2m/KIBKGaO6EXjWd5/8v1jwfTUMi6tArh2KXYcODvyWBDkAFenw5jqX
3K+dpScgpoD+tBam1wzgkCsDBqH7aS7tk0yTEJZEQd1U0kTiKUTFLHarnmlqQcAZ
ZaTQdSuA4DXfKVEIsXo+PxMF6VUuW96tvnktN15Q1qe1baW7hymbe5w3sGOLYI3c
AxQI5QeEshwegQ+CmJNYFE+s96MuMG2tA+Y9C7Jyzb2iooqkIPB65sS3DnJaa4Gh
NT22oQSFzN+YTPBRGIjPos0kq84n2A==
=Umol
-----END PGP SIGNATURE-----

--gok45hmzf5nviwgp--
