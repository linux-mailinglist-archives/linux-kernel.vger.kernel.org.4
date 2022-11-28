Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3F2063ABEF
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 16:07:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbiK1PHW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 10:07:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230216AbiK1PGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 10:06:49 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6AB41BEA6
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 07:06:48 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ozfi7-0002aR-Kx; Mon, 28 Nov 2022 16:06:19 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ozfi3-000rv9-Uh; Mon, 28 Nov 2022 16:06:16 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ozfi3-000yxQ-Ti; Mon, 28 Nov 2022 16:06:15 +0100
Date:   Mon, 28 Nov 2022 16:06:15 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Sasha Finkelstein <fnkl.kernel@gmail.com>
Cc:     thierry.reding@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, marcan@marcan.st,
        sven@svenpeter.dev, alyssa@rosenzweig.io, asahi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v3 2/4] pwm: Add Apple PWM controller
Message-ID: <20221128150615.srq4t6cpl7za5mbb@pengutronix.de>
References: <20221121174228.93670-1-fnkl.kernel@gmail.com>
 <20221121174228.93670-3-fnkl.kernel@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="z3mzm3nxcf7dlyq6"
Content-Disposition: inline
In-Reply-To: <20221121174228.93670-3-fnkl.kernel@gmail.com>
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


--z3mzm3nxcf7dlyq6
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Mon, Nov 21, 2022 at 08:42:26PM +0300, Sasha Finkelstein wrote:
> Adds the Apple PWM controller driver.
>=20
> Signed-off-by: Sasha Finkelstein <fnkl.kernel@gmail.com>
> Acked-by: Sven Peter <sven@svenpeter.dev>
> ---
>  drivers/pwm/Kconfig     |  12 ++++
>  drivers/pwm/Makefile    |   1 +
>  drivers/pwm/pwm-apple.c | 127 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 140 insertions(+)
>  create mode 100644 drivers/pwm/pwm-apple.c
>=20
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index 60d13a949bc5..c3be11468414 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -51,6 +51,18 @@ config PWM_AB8500
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called pwm-ab8500.
> =20
> +config PWM_APPLE
> +	tristate "Apple SoC PWM support"
> +	depends on ARCH_APPLE || COMPILE_TEST
> +	help
> +	  Generic PWM framework driver for PWM controller present on
> +	  Apple SoCs
> +
> +	  Say Y here if you have an ARM Apple laptop, otherwise say N
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called pwm-apple.
> +
>  config PWM_ATMEL
>  	tristate "Atmel PWM support"
>  	depends on ARCH_AT91 || COMPILE_TEST
> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> index 7bf1a29f02b8..19899b912e00 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -2,6 +2,7 @@
>  obj-$(CONFIG_PWM)		+=3D core.o
>  obj-$(CONFIG_PWM_SYSFS)		+=3D sysfs.o
>  obj-$(CONFIG_PWM_AB8500)	+=3D pwm-ab8500.o
> +obj-$(CONFIG_PWM_APPLE)		+=3D pwm-apple.o
>  obj-$(CONFIG_PWM_ATMEL)		+=3D pwm-atmel.o
>  obj-$(CONFIG_PWM_ATMEL_HLCDC_PWM)	+=3D pwm-atmel-hlcdc.o
>  obj-$(CONFIG_PWM_ATMEL_TCB)	+=3D pwm-atmel-tcb.o
> diff --git a/drivers/pwm/pwm-apple.c b/drivers/pwm/pwm-apple.c
> new file mode 100644
> index 000000000000..b0c3f86fd578
> --- /dev/null
> +++ b/drivers/pwm/pwm-apple.c
> @@ -0,0 +1,127 @@
> +// SPDX-License-Identifier: GPL-2.0 OR MIT
> +/*
> + * Driver for the Apple SoC PWM controller
> + *
> + * Copyright The Asahi Linux Contributors
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/io.h>
> +#include <linux/math64.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/pwm.h>
> +
> +#define PWM_CONTROL     0x00
> +#define PWM_ON_CYCLES   0x1c
> +#define PWM_OFF_CYCLES  0x18
> +
> +#define CTRL_ENABLE        BIT(0)
> +#define CTRL_MODE          BIT(2)
> +#define CTRL_UPDATE        BIT(5)
> +#define CTRL_TRIGGER       BIT(9)
> +#define CTRL_INVERT        BIT(10)
> +#define CTRL_OUTPUT_ENABLE BIT(14)

Please use a driver specific prefix on these defines to make it obvious
that they are driver specific.

> +struct apple_pwm {
> +	struct pwm_chip chip;
> +	void __iomem *base;
> +	u64 clkrate;
> +};
> +
> +static int apple_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> +			   const struct pwm_state *state)
> +{
> +	struct apple_pwm *fpwm;
> +	u64 on_cycles, off_cycles;
> +
> +	fpwm =3D container_of(chip, struct apple_pwm, chip);

Please introduce a macro or static inline for that.

> +	if (state->enabled) {
> +		on_cycles =3D mul_u64_u64_div_u64(fpwm->clkrate,
> +						state->duty_cycle, NSEC_PER_SEC);

This might overflow for big values of clkrate and duty_cycle. The
usual approach is to check for clkrate <=3D NSEC_PER_SEC. See
pwm-lpc18xx-sct.c for an example.

> +		off_cycles =3D mul_u64_u64_div_u64(fpwm->clkrate,
> +						 state->period, NSEC_PER_SEC) - on_cycles;
> +		writel(on_cycles, fpwm->base + PWM_ON_CYCLES);

You're assuming on_cycles to fit into an u32 here. Please ensure that's
a valid claim.

> +		writel(off_cycles, fpwm->base + PWM_OFF_CYCLES);
> +		writel(CTRL_ENABLE | CTRL_OUTPUT_ENABLE | CTRL_UPDATE,
> +		       fpwm->base + PWM_CONTROL);

How does the hardware behave on updates? Are the register values
shadowed until PWM_CONTROL is written? Or until the next period starts?

Please document this at the top of the driver file, in the same format
as e.g. pwm-sl28cpld.c does. (The relevant section is called
"Limitations", actually "Hardware properties" would be a better name,
but please stick to the former for easier greppability.)

> +	} else {
> +		writel(0, fpwm->base + PWM_CONTROL);
> +	}
> +	return 0;
> +}
> +
> +static void apple_pwm_get_state(struct pwm_chip *chip, struct pwm_device=
 *pwm,
> +			   struct pwm_state *state)
> +{
> +	struct apple_pwm *fpwm;
> +	u32 on_cycles, off_cycles, ctrl;
> +
> +	fpwm =3D container_of(chip, struct apple_pwm, chip);
> +
> +	ctrl =3D readl(fpwm->base + PWM_CONTROL);
> +	on_cycles =3D readl(fpwm->base + PWM_ON_CYCLES);
> +	off_cycles =3D readl(fpwm->base + PWM_OFF_CYCLES);
> +
> +	state->enabled =3D (ctrl & CTRL_ENABLE) && (ctrl & CTRL_OUTPUT_ENABLE);
> +	state->polarity =3D PWM_POLARITY_NORMAL;
> +	state->duty_cycle =3D div_u64(on_cycles, fpwm->clkrate) * NSEC_PER_SEC;
> +	state->period =3D div_u64(off_cycles + on_cycles, fpwm->clkrate) * NSEC=
_PER_SEC;

You're loosing precision here, always do the division last. Also the
rounding is wrong. Enabling PWM_DEBUG + some non-trivial testing should
tell you that.

> +}
> +
> +static const struct pwm_ops apple_pwm_ops =3D {
> +	.apply =3D apple_pwm_apply,
> +	.get_state =3D apple_pwm_get_state,
> +	.owner =3D THIS_MODULE,
> +};
> +
> +static int apple_pwm_probe(struct platform_device *pdev)
> +{
> +	struct apple_pwm *pwm;

The name "pwm" is usually (only) used for struct pwm_device variables.

Please pick another name (something like ddata or pc are usual names),
above you picked "fpwm", which I could live with, too.

> +	struct clk *clk;
> +	int ret;
> +
> +	pwm =3D devm_kzalloc(&pdev->dev, sizeof(*pwm), GFP_KERNEL);
> +	if (!pwm)
> +		return -ENOMEM;
> +
> +	pwm->base =3D devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(pwm->base))
> +		return PTR_ERR(pwm->base);
> +
> +	platform_set_drvdata(pdev, pwm);

This is unused.

> +	clk =3D devm_clk_get_enabled(&pdev->dev, NULL);
> +	if (IS_ERR(clk))

Error message please, preferably using dev_err_probe.

> +		return PTR_ERR(clk);
> +
> +	pwm->clkrate =3D clk_get_rate(clk);
> +	pwm->chip.dev =3D &pdev->dev;
> +	pwm->chip.npwm =3D 1;
> +	pwm->chip.ops =3D &apple_pwm_ops;
> +
> +	ret =3D devm_pwmchip_add(&pdev->dev, &pwm->chip);

Ditto.

> +	return ret;
> +}
> +
> +static const struct of_device_id apple_pwm_of_match[] =3D {
> +	{ .compatible =3D "apple,s5l-fpwm" },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, apple_pwm_of_match);
> +
> +static struct platform_driver apple_pwm_driver =3D {
> +	.probe =3D apple_pwm_probe,
> +	.driver =3D {
> +		.name =3D "apple-pwm",
> +		.owner =3D THIS_MODULE,
> +		.of_match_table =3D apple_pwm_of_match,
> +	},
> +};
> +module_platform_driver(apple_pwm_driver);
> +
> +MODULE_DESCRIPTION("Apple SoC PWM driver");
> +MODULE_LICENSE("Dual MIT/GPL");

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--z3mzm3nxcf7dlyq6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmOEzmQACgkQwfwUeK3K
7AlxVgf/XfYhRYRy7vLK53rjGqJrzsh7mmjHVkq7Xl4pBjSXMMMuFgyg3BAv7wMM
MfwTdmu0e4EYlTKRsEmgyAPPVBI+/kqMU0GZSbsBtoQv+hPXOi5q1xAXqZ4V6OwE
1TeCuPv/H7BADexe3KQDoQFcW39GxUOCtWmk26UdsYOfnAddS5QHE+KUh17dNPr/
kt/Yx3mzzO1vHljWCEzhtXbk+CMci6h5NTPsElmA8/0ORlO7sXonT0n7InEtJUzC
cd/njxYBV/ntGhuFt6/m1SEBx7pvrEN8kBex4UIQmXek1dssI0sOWbQb803xRp75
mpkmvy0uO+vNawLIUjc8nB6M1KAFIQ==
=Lbn9
-----END PGP SIGNATURE-----

--z3mzm3nxcf7dlyq6--
