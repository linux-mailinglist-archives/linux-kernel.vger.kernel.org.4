Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67BF3697A6A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 12:08:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbjBOLIL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 06:08:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjBOLIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 06:08:09 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C68CA1F5EB
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 03:08:07 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pSFdd-000773-ES; Wed, 15 Feb 2023 12:07:49 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pSFdY-0055yy-OJ; Wed, 15 Feb 2023 12:07:45 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pSFdZ-003j8R-9y; Wed, 15 Feb 2023 12:07:45 +0100
Date:   Wed, 15 Feb 2023 12:07:45 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Sasha Finkelstein <fnkl.kernel@gmail.com>
Cc:     thierry.reding@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, marcan@marcan.st,
        sven@svenpeter.dev, alyssa@rosenzweig.io, asahi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 2/5] pwm: Add Apple PWM controller
Message-ID: <20230215110745.2csbrbh2z7zz5fw7@pengutronix.de>
References: <20230114132508.96600-1-fnkl.kernel@gmail.com>
 <20230114132508.96600-3-fnkl.kernel@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cwuokv3rl32le6xt"
Content-Disposition: inline
In-Reply-To: <20230114132508.96600-3-fnkl.kernel@gmail.com>
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


--cwuokv3rl32le6xt
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Sat, Jan 14, 2023 at 04:25:05PM +0300, Sasha Finkelstein wrote:
> Adds the Apple PWM controller driver.
>=20
> Signed-off-by: Sasha Finkelstein <fnkl.kernel@gmail.com>
> Acked-by: Sven Peter <sven@svenpeter.dev>
> ---
>  drivers/pwm/Kconfig     |  12 +++
>  drivers/pwm/Makefile    |   1 +
>  drivers/pwm/pwm-apple.c | 159 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 172 insertions(+)
>  create mode 100644 drivers/pwm/pwm-apple.c
>=20
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index dae023d783a2..8df861b1f4a3 100644
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
> index 000000000000..551e07d49bf7
> --- /dev/null
> +++ b/drivers/pwm/pwm-apple.c
> @@ -0,0 +1,159 @@
> +// SPDX-License-Identifier: GPL-2.0 OR MIT
> +/*
> + * Driver for the Apple SoC PWM controller
> + *
> + * Copyright The Asahi Linux Contributors
> + *
> + * Limitations:
> + * - The writes to cycle registers are shadowed until a write to
> + *   the control register.
> + * - If both OFF_CYCLES and ON_CYCLES are set to 0, the output
> + *   is a constant off signal.
> + * - When APPLE_PWM_CTRL is set to 0, the output is constant low
> + */
> +
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/pwm.h>
> +#include <linux/io.h>
> +#include <linux/clk.h>
> +#include <linux/math64.h>
> +
> +#define APPLE_PWM_CTRL        0x00
> +#define APPLE_PWM_ON_CYCLES   0x1c
> +#define APPLE_PWM_OFF_CYCLES  0x18
> +
> +#define APPLE_PWM_CTRL_ENABLE        BIT(0)
> +#define APPLE_PWM_CTRL_MODE          BIT(2)
> +#define APPLE_PWM_CTRL_UPDATE        BIT(5)
> +#define APPLE_PWM_CTRL_TRIGGER       BIT(9)
> +#define APPLE_PWM_CTRL_INVERT        BIT(10)
> +#define APPLE_PWM_CTRL_OUTPUT_ENABLE BIT(14)
> +
> +struct apple_pwm {
> +	struct pwm_chip chip;
> +	void __iomem *base;
> +	u64 clkrate;
> +};
> +
> +static inline struct apple_pwm *to_apple_pwm(struct pwm_chip *chip)
> +{
> +	return container_of(chip, struct apple_pwm, chip);
> +}
> +
> +static int apple_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> +			   const struct pwm_state *state)
> +{
> +	struct apple_pwm *fpwm;
> +
> +	if (state->polarity =3D=3D PWM_POLARITY_INVERSED)
> +		return -EINVAL;
> +
> +	fpwm =3D to_apple_pwm(chip);
> +	if (state->enabled) {
> +		u64 on_cycles, off_cycles;
> +
> +		on_cycles =3D mul_u64_u64_div_u64(fpwm->clkrate,
> +						state->duty_cycle, NSEC_PER_SEC);
> +		if (on_cycles > 0xFFFFFFFF)
> +			return -ERANGE;
> +
> +		off_cycles =3D mul_u64_u64_div_u64(fpwm->clkrate,
> +						 state->period, NSEC_PER_SEC) - on_cycles;
> +		if (off_cycles > 0xFFFFFFFF)
> +			return -ERANGE;
> +
> +		writel(on_cycles, fpwm->base + APPLE_PWM_ON_CYCLES);
> +		writel(off_cycles, fpwm->base + APPLE_PWM_OFF_CYCLES);
> +		writel(APPLE_PWM_CTRL_ENABLE | APPLE_PWM_CTRL_OUTPUT_ENABLE | APPLE_PW=
M_CTRL_UPDATE,
> +		       fpwm->base + APPLE_PWM_CTRL);
> +	} else {
> +		writel(0, fpwm->base + APPLE_PWM_CTRL);
> +	}
> +	return 0;
> +}
> +
> +static int apple_pwm_get_state(struct pwm_chip *chip, struct pwm_device =
*pwm,
> +			   struct pwm_state *state)
> +{
> +	struct apple_pwm *fpwm;
> +	u32 on_cycles, off_cycles, ctrl;
> +
> +	fpwm =3D to_apple_pwm(chip);
> +
> +	ctrl =3D readl(fpwm->base + APPLE_PWM_CTRL);
> +	on_cycles =3D readl(fpwm->base + APPLE_PWM_ON_CYCLES);
> +	off_cycles =3D readl(fpwm->base + APPLE_PWM_OFF_CYCLES);
> +
> +	state->enabled =3D (ctrl & APPLE_PWM_CTRL_ENABLE) && (ctrl & APPLE_PWM_=
CTRL_OUTPUT_ENABLE);
> +	state->polarity =3D PWM_POLARITY_NORMAL;
> +	// on_cycles + off_cycles is 33 bits, NSEC_PER_SEC is 30, there is no o=
verflow
> +	state->duty_cycle =3D DIV64_U64_ROUND_UP((u64)on_cycles * NSEC_PER_SEC,=
 fpwm->clkrate);
> +	state->period =3D DIV64_U64_ROUND_UP(((u64)off_cycles + (u64)on_cycles)=
 *
> +					    NSEC_PER_SEC, fpwm->clkrate);
> +
> +	return 0;
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
> +	struct apple_pwm *fpwm;
> +	struct clk *clk;
> +	int ret;
> +
> +	fpwm =3D devm_kzalloc(&pdev->dev, sizeof(*fpwm), GFP_KERNEL);
> +	if (!fpwm)
> +		return -ENOMEM;
> +
> +	fpwm->base =3D devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(fpwm->base))
> +		return PTR_ERR(fpwm->base);
> +
> +	clk =3D devm_clk_get_enabled(&pdev->dev, NULL);
> +	if (IS_ERR(clk))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(clk), "unable to get the cloc=
k");
> +

I'd add a call to clk_rate_exclusive_get() here to justify that you
determine clkrate here and don't recheck later (and also to make sure
that your PWM output doesn't change for reasons out of your control).
(Even though the rate might be fixed on your platform, doing it right for
the benefit of people using your driver as a template is nice.)

But I intend to go over the PWM drivers and add such a call where
appropriate, so IMHO this doesn't need to delay application of this
driver.

> +	/*
> +	 * Uses the 24MHz system clock on all existing devices, can only
> +	 * happen if the device tree is broken
> +	 *
> +	 * This check is done to prevent an overflow in .apply
> +	 */
> +	fpwm->clkrate =3D clk_get_rate(clk);
> +	if (fpwm->clkrate > NSEC_PER_SEC)
> +		return dev_err_probe(&pdev->dev, -EINVAL, "pwm clock out of range");
> +
> +	fpwm->chip.dev =3D &pdev->dev;
> +	fpwm->chip.npwm =3D 1;
> +	fpwm->chip.ops =3D &apple_pwm_ops;
> +
> +	ret =3D devm_pwmchip_add(&pdev->dev, &fpwm->chip);
> +	if (ret < 0)
> +		return dev_err_probe(&pdev->dev, ret, "unable to add pwm chip");
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id apple_pwm_of_match[] =3D {
> +	{ .compatible =3D "apple,s5l-fpwm" },

Out of interest: What does the f in fpwm stand for?

Otherwise:

Reviewed-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

FTR: You resent v7, I'll discard that from patchwork in the expectation
that Thierry will pick up the original v7.)

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--cwuokv3rl32le6xt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmPsvP4ACgkQwfwUeK3K
7AlqJgf9GUq02UVLT14umt0XN+Y3Zsq9dCl2ixsxwtqWmIg83Ffy9yY04g27oaVa
l4PeDJu0gxmLTfbRn6TIeGPE4Wz17MeZlPgufVKsnSUbiDhtdkGAyvIhCuu9eNNs
yNlpKsRo+WjLS2YfUlEL/k9TyXRn01KJHCB7LaXVxIy2FY3goLlsi+GnSWeLH3UR
QaHmNS5Yz+vBHG8IrPIcIJUf3ud8oN8pF0HyN9cePXoVb1cCGDqXxzGoXq6jvtaL
7mMEIYjJ/e++QSqiV0DaZNdFS3NDQMe2upLtEHG8R11uY33TDPCkW3cFSYtAQvSd
PSAAizHBSzLy0gLlNSDd1F8jSQSYlA==
=YIF1
-----END PGP SIGNATURE-----

--cwuokv3rl32le6xt--
