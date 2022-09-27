Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05F265EC996
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 18:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231387AbiI0Qdy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 12:33:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232077AbiI0Qdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 12:33:38 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D89515E460
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 09:33:36 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1odDWJ-0004VL-Q0; Tue, 27 Sep 2022 18:33:19 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1odDWJ-003G6X-Rp; Tue, 27 Sep 2022 18:33:18 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1odDWH-003wDY-DR; Tue, 27 Sep 2022 18:33:17 +0200
Date:   Tue, 27 Sep 2022 18:33:14 +0200
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
Message-ID: <20220927163314.rzfld7sqchsdfvfg@pengutronix.de>
References: <20220907131241.31941-1-romain.perier@gmail.com>
 <20220907131241.31941-3-romain.perier@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="slfidd2ljhwi2xu6"
Content-Disposition: inline
In-Reply-To: <20220907131241.31941-3-romain.perier@gmail.com>
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


--slfidd2ljhwi2xu6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Romain, hello Daniel,

adding Mark Brown to Cc: for the regmap stuff.

On Wed, Sep 07, 2022 at 03:12:38PM +0200, Romain Perier wrote:
> From: Daniel Palmer <daniel@0x0f.com>
>=20
> This adds support for the PWM block on the Mstar MSC313e SoCs and newer.
>=20
> Signed-off-by: Daniel Palmer <daniel@0x0f.com>
> Co-developed-by: Romain Perier <romain.perier@gmail.com>
> Signed-off-by: Romain Perier <romain.perier@gmail.com>
> ---
>  MAINTAINERS               |   1 +
>  drivers/pwm/Kconfig       |   9 ++
>  drivers/pwm/Makefile      |   1 +
>  drivers/pwm/pwm-msc313e.c | 269 ++++++++++++++++++++++++++++++++++++++
>  4 files changed, 280 insertions(+)
>  create mode 100644 drivers/pwm/pwm-msc313e.c
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9d7f64dc0efe..c3b39b09097c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2439,6 +2439,7 @@ F:	arch/arm/mach-mstar/
>  F:	drivers/clk/mstar/
>  F:	drivers/clocksource/timer-msc313e.c
>  F:	drivers/gpio/gpio-msc313.c
> +F:	drivers/pwm/pwm-msc313e.c
>  F:	drivers/rtc/rtc-msc313.c
>  F:	drivers/watchdog/msc313e_wdt.c
>  F:	include/dt-bindings/clock/mstar-*
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index 60d13a949bc5..8049fd03a821 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -372,6 +372,15 @@ config PWM_MESON
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called pwm-meson.
> =20
> +config PWM_MSC313E
> +	tristate "MStar MSC313e PWM support"
> +	depends on ARCH_MSTARV7 || COMPILE_TEST
> +	help
> +	  Generic PWM framework driver for MSTAR MSC313e.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called pwm-msc313e.
> +
>  config PWM_MTK_DISP
>  	tristate "MediaTek display PWM driver"
>  	depends on ARCH_MEDIATEK || COMPILE_TEST
> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> index 7bf1a29f02b8..bc285c054f2a 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -62,4 +62,5 @@ obj-$(CONFIG_PWM_TWL)		+=3D pwm-twl.o
>  obj-$(CONFIG_PWM_TWL_LED)	+=3D pwm-twl-led.o
>  obj-$(CONFIG_PWM_VISCONTI)	+=3D pwm-visconti.o
>  obj-$(CONFIG_PWM_VT8500)	+=3D pwm-vt8500.o
> +obj-$(CONFIG_PWM_MSC313E)	+=3D pwm-msc313e.o
>  obj-$(CONFIG_PWM_XILINX)	+=3D pwm-xilinx.o
> diff --git a/drivers/pwm/pwm-msc313e.c b/drivers/pwm/pwm-msc313e.c
> new file mode 100644
> index 000000000000..a71f39ba66c3
> --- /dev/null
> +++ b/drivers/pwm/pwm-msc313e.c
> @@ -0,0 +1,269 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2021 Daniel Palmer <daniel@thingy.jp>
> + * Copyright (C) 2022 Romain Perier <romain.perier@gmail.com>
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/of_device.h>
> +#include <linux/pwm.h>
> +#include <linux/regmap.h>
> +
> +#define DRIVER_NAME "msc313e-pwm"
> +
> +#define CHANNEL_OFFSET	0x80
> +#define REG_DUTY	0x8
> +#define REG_PERIOD	0x10
> +#define REG_DIV		0x18
> +#define REG_CTRL	0x1c
> +#define REG_SWRST	0x1fc
> +
> +struct msc313e_pwm_channel {
> +	struct regmap_field *clkdiv;
> +	struct regmap_field *polarity;
> +	struct regmap_field *dutyl;
> +	struct regmap_field *dutyh;
> +	struct regmap_field *periodl;
> +	struct regmap_field *periodh;
> +	struct regmap_field *swrst;
> +};
> +
> +struct msc313e_pwm {
> +	struct regmap *regmap;
> +	struct pwm_chip pwmchip;
> +	struct clk *clk;
> +	struct msc313e_pwm_channel channels[];
> +};
> +
> +struct msc313e_pwm_info {
> +	unsigned int channels;
> +};
> +
> +#define to_msc313e_pwm(ptr) container_of(ptr, struct msc313e_pwm, pwmchi=
p)
> +
> +static const struct regmap_config msc313e_pwm_regmap_config =3D {
> +	.reg_bits =3D 16,
> +	.val_bits =3D 16,
> +	.reg_stride =3D 4,
> +};
> +
> +static const struct msc313e_pwm_info msc313e_data =3D {
> +	.channels =3D 8,
> +};
> +
> +static const struct msc313e_pwm_info ssd20xd_data =3D {
> +	.channels =3D 4,
> +};
> +
> +static void msc313e_pwm_writecounter(struct regmap_field *low, struct re=
gmap_field *high, u32 value)
> +{
> +	/* The bus that connects the CPU to the peripheral registers splits 32 =
bit registers into

Please fix the comment style to use /* on a line for itself. Also for
comments staying below 80 chars per line is appreciated.

> +	 * two 16bit registers placed 4 bytes apart. It's the hardware design t=
hey used. The counter
> +	 * we are about to write has this contrainst.

s/contrainst/contraint/

I wonder if that could be abstracted by regmap?!

> +	 */
> +	regmap_field_write(low, value & 0xffff);
> +	regmap_field_write(high, value >> 16);
> +}
> +
> +static void msc313e_pwm_readcounter(struct regmap_field *low, struct reg=
map_field *high, u32 *value)
> +{
> +	unsigned int val =3D 0;
> +
> +	regmap_field_read(low, &val);
> +	*value =3D val;
> +	regmap_field_read(high, &val);
> +	*value =3D (val << 16) | *value;
> +}
> +
> +static int msc313e_pwm_config(struct pwm_chip *chip, struct pwm_device *=
device,
> +			      int duty_ns, int period_ns)
> +{
> +	struct msc313e_pwm *pwm =3D to_msc313e_pwm(chip);
> +	unsigned long long nspertick =3D DIV_ROUND_DOWN_ULL(NSEC_PER_SEC, clk_g=
et_rate(pwm->clk));
> +	struct msc313e_pwm_channel *channel =3D &pwm->channels[device->hwpwm];
> +	unsigned long long div =3D 1;
> +
> +	/* Fit the period into the period register by prescaling the clk */
> +	while (DIV_ROUND_DOWN_ULL(period_ns, nspertick) > 0x3ffff) {

dividing by the result of a division looses precision. Also rounding
down both divisions looks wrong.

> +		div++;
> +		if (div > (0xffff + 1)) {
> +			/* Force clk div to the maximum allowed value */
> +			div =3D 0xffff;
> +			break;
> +		}
> +		nspertick =3D DIV_ROUND_DOWN_ULL(nspertick, div);
> +	}
> +
> +	regmap_field_write(channel->clkdiv, div - 1);
> +	msc313e_pwm_writecounter(channel->dutyl, channel->dutyh,
> +				 DIV_ROUND_DOWN_ULL(duty_ns, nspertick));
> +	msc313e_pwm_writecounter(channel->periodl, channel->periodh,
> +				 DIV_ROUND_DOWN_ULL(period_ns, nspertick));
> +	return 0;
> +};
> +
> +static int msc313e_pwm_set_polarity(struct pwm_chip *chip, struct pwm_de=
vice *device,
> +				    enum pwm_polarity polarity)
> +{
> +	struct msc313e_pwm *pwm =3D to_msc313e_pwm(chip);
> +	struct msc313e_pwm_channel *channel =3D &pwm->channels[device->hwpwm];
> +	unsigned int pol =3D 0;
> +
> +	if (polarity =3D=3D PWM_POLARITY_INVERSED)
> +		pol =3D 1;
> +	regmap_field_update_bits(channel->polarity, 1, pol);
> +
> +	return 0;
> +}
> +
> +static int msc313e_pwm_enable(struct pwm_chip *chip, struct pwm_device *=
device)
> +{
> +	struct msc313e_pwm *pwm =3D to_msc313e_pwm(chip);
> +	struct msc313e_pwm_channel *channel =3D &pwm->channels[device->hwpwm];
> +	int ret;
> +
> +	ret =3D clk_prepare_enable(pwm->clk);
> +	if (ret)
> +		return ret;
> +	return regmap_field_write(channel->swrst, 0);
> +}
> +
> +static int msc313e_pwm_disable(struct pwm_chip *chip, struct pwm_device =
*device)
> +{
> +	struct msc313e_pwm *pwm =3D to_msc313e_pwm(chip);
> +	struct msc313e_pwm_channel *channel =3D &pwm->channels[device->hwpwm];
> +	int ret;
> +
> +	ret =3D regmap_field_write(channel->swrst, 1);
> +	clk_disable_unprepare(pwm->clk);
> +	return ret;
> +}
> +
> +static int msc313e_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> +			 const struct pwm_state *state)
> +{
> +	int ret;
> +
> +	if (state->enabled) {
> +		if (!pwm->state.enabled) {
> +			ret =3D msc313e_pwm_enable(chip, pwm);
> +			if (ret)
> +				return ret;
> +		}
> +		msc313e_pwm_set_polarity(chip, pwm, state->polarity);
> +		msc313e_pwm_config(chip, pwm, state->duty_cycle, state->period);

Does the output emit a previous setting after msc313e_pwm_enable()? If
so, please do the enable at the end.

Does calling msc313e_pwm_set_polarity() and msc313e_pwm_config() have an
immediate effect? Or is the currently running period completed?

> +	} else if (pwm->state.enabled) {
> +		ret =3D msc313e_pwm_disable(chip, pwm);

How does the output behave on disable? Typical options are:

 - freezes where ever it currently is
 - goes to the inactive level

Does it complete the currently running period? Please answer these in a
"Limitations:" section similar to e.g. pwm-sl28cpld.c and pwm-iqs620a.

> +	}
> +	return 0;
> +}
> +
> +static void msc313e_get_state(struct pwm_chip *chip, struct pwm_device *=
device,

Please s/device/pwm/ to match the naming used in other drivers.

> +			      struct pwm_state *state)
> +{
> +	struct msc313e_pwm *pwm =3D to_msc313e_pwm(chip);
> +	struct msc313e_pwm_channel *channel =3D &pwm->channels[device->hwpwm];
> +	unsigned long long nspertick =3D DIV_ROUND_DOWN_ULL(NSEC_PER_SEC, clk_g=
et_rate(pwm->clk));
> +	unsigned int val =3D 0;
> +
> +	regmap_field_read(channel->polarity, &val);
> +	state->polarity =3D val ? PWM_POLARITY_INVERSED : PWM_POLARITY_NORMAL;
> +
> +	regmap_field_read(channel->swrst, &val);
> +	state->enabled =3D val =3D=3D 0 ? true : false;
> +
> +	msc313e_pwm_readcounter(channel->dutyl, channel->dutyh, &val);
> +	state->duty_cycle =3D val * nspertick;

Please do the division at the end. Consider val =3D 333335 and
clk_get_rate() returning 666666667.

Then the exact duty cycle would be 500002.49974999874 but you would
calculate nspertick =3D 1 and so duty_cycle =3D 333335.

Also you need to round up. Did you test your driver with PWM_DEBUG
enabled? The idea is that .get_state should return 500003 here to have
apply =E2=88=98 get_state idempotent. As apply is supposed to round down to=
 the
next available setting, get_state has to round up.

> +	msc313e_pwm_readcounter(channel->periodl, channel->periodh, &val);
> +	state->period =3D val * nspertick;
> +}
> +
> +static const struct pwm_ops msc313e_pwm_ops =3D {
> +	.apply =3D msc313e_apply,
> +	.get_state =3D msc313e_get_state,
> +	.owner =3D THIS_MODULE
> +};
> +
> +static int msc313e_pwm_probe(struct platform_device *pdev)
> +{
> +	const struct msc313e_pwm_info *match_data;
> +	struct device *dev =3D &pdev->dev;
> +	struct msc313e_pwm *pwm;
> +	__iomem void *base;
> +	int i;
> +
> +	match_data =3D of_device_get_match_data(dev);
> +	if (!match_data)
> +		return -EINVAL;
> +
> +	base =3D devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(base))
> +		return PTR_ERR(base);
> +
> +	pwm =3D devm_kzalloc(dev, struct_size(pwm, channels, match_data->channe=
ls), GFP_KERNEL);

Please don't use "pwm" as a name for your driver data variable. That
name is reserved for struct pwm_device pointers. Something like "ddata"
would be fine, but there is a wide variety in pwm driver land to choose
=66rom.

> +	if (!pwm)
> +		return -ENOMEM;
> +
> +	pwm->clk =3D devm_clk_get(dev, NULL);
> +	if (IS_ERR(pwm->clk))
> +		return dev_err_probe(dev, PTR_ERR(pwm->clk), "Cannot get clk\n");
> +
> +	pwm->regmap =3D devm_regmap_init_mmio(dev, base, &msc313e_pwm_regmap_co=
nfig);
> +	if (IS_ERR(pwm->regmap))
> +		return dev_err_probe(dev, PTR_ERR(pwm->regmap), "Cannot get regmap\n");
> +
> +	for (i =3D 0; i < match_data->channels; i++) {
> +		unsigned int offset =3D CHANNEL_OFFSET * i;
> +		struct reg_field div_clkdiv_field =3D REG_FIELD(offset + REG_DIV, 0, 7=
);
> +		struct reg_field ctrl_polarity_field =3D REG_FIELD(offset + REG_CTRL, =
4, 4);
> +		struct reg_field dutyl_field =3D REG_FIELD(offset + REG_DUTY, 0, 15);
> +		struct reg_field dutyh_field =3D REG_FIELD(offset + REG_DUTY + 4, 0, 2=
);
> +		struct reg_field periodl_field =3D REG_FIELD(offset + REG_PERIOD, 0, 1=
5);
> +		struct reg_field periodh_field =3D REG_FIELD(offset + REG_PERIOD + 4, =
0, 2);
> +		struct reg_field swrst_field =3D REG_FIELD(REG_SWRST, i, i);
> +
> +		pwm->channels[i].clkdiv =3D devm_regmap_field_alloc(dev, pwm->regmap,
> +								  div_clkdiv_field);
> +		pwm->channels[i].polarity =3D devm_regmap_field_alloc(dev, pwm->regmap,
> +								    ctrl_polarity_field);
> +		pwm->channels[i].dutyl =3D devm_regmap_field_alloc(dev, pwm->regmap, d=
utyl_field);
> +		pwm->channels[i].dutyh =3D devm_regmap_field_alloc(dev, pwm->regmap, d=
utyh_field);
> +		pwm->channels[i].periodl =3D devm_regmap_field_alloc(dev, pwm->regmap,=
 periodl_field);
> +		pwm->channels[i].periodh =3D devm_regmap_field_alloc(dev, pwm->regmap,=
 periodh_field);
> +		pwm->channels[i].swrst =3D devm_regmap_field_alloc(dev, pwm->regmap, s=
wrst_field);
> +
> +		/* Channels are enabled on boot, disable it until the pwm subsystem re=
-enable it
> +		 * explicitly

You're supposed to keep the PWM running. (Consider a bootloader setting
up a splash screen. You're probably killing the backlight here.) Note
you need improved clk handling to do that right.

> +		 */
> +		regmap_field_write(pwm->channels[i].swrst, 1);
> +	}
> +
> +	pwm->pwmchip.dev =3D dev;
> +	pwm->pwmchip.ops =3D &msc313e_pwm_ops;
> +	pwm->pwmchip.npwm =3D match_data->channels;
> +
> +	platform_set_drvdata(pdev, pwm);

This is unused, please drop.

> +	return devm_pwmchip_add(dev, &pwm->pwmchip);
> +}
> +
> +static const struct of_device_id msc313e_pwm_dt_ids[] =3D {
> +	{ .compatible =3D "mstar,msc313e-pwm", .data =3D &msc313e_data },
> +	{ .compatible =3D "mstar,ssd20xd-pwm", .data =3D &ssd20xd_data },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, msc313e_pwm_dt_ids);
> +
> +static struct platform_driver msc313e_pwm_driver =3D {
> +	.probe =3D msc313e_pwm_probe,
> +	.driver =3D {
> +		.name =3D DRIVER_NAME,
> +		.of_match_table =3D msc313e_pwm_dt_ids,
> +	},
> +};
> +module_platform_driver(msc313e_pwm_driver);
> +
> +MODULE_LICENSE("GPL v2");
> +MODULE_DESCRIPTION("Mstar MSC313e PWM driver");
> +MODULE_AUTHOR("Daniel Palmer <daniel@thingy.jp>");

That address doesn't match the author of this patch. Is this on purpose?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig         =
   |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--slfidd2ljhwi2xu6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmMzJccACgkQwfwUeK3K
7AmEGwgAj03nSvIsif/T247wf6RVudM9w6EBjSx6UKDu8QRfS6s5uoRI0DTHLIe0
0aMw4DdPR1JSNu6ls59igDCDo69jPUaHex4DuE2P3HAmKYTQsKwUZYbULz7taCKF
woaop8DoyQHPniW4hM6xvoLG3LMBM4HQ6T3a9QcjmiXQlJP4YGMjoe9XxpM9OoPh
GXrGb+S7Cf2c/v7sIhZ927hpIEXzFpC1i+98bZaoc48hCkVLCWHA3cwNKRE3Yl+T
d3cGypRnZpTKwGVfwIwRAWv06sd4uMEUqGf7kSBihJC5aNHwT6zjIJuwPJp6vNXm
wdOiaI7u0XFGZ443HkbSyaftF3aa2A==
=47Tt
-----END PGP SIGNATURE-----

--slfidd2ljhwi2xu6--
