Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D98F274D129
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 11:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231656AbjGJJOg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 05:14:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230361AbjGJJOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 05:14:35 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2981F92
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 02:14:33 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qImyI-0000IK-8t; Mon, 10 Jul 2023 11:14:18 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qImyE-00DNvB-FD; Mon, 10 Jul 2023 11:14:14 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qImyD-003lBB-8T; Mon, 10 Jul 2023 11:14:13 +0200
Date:   Mon, 10 Jul 2023 11:14:13 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Aleksandr Shubin <privatesub2@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v3 2/3] pwm: Add Allwinner's D1/T113-S3/R329 SoCs PWM
 support
Message-ID: <20230710091413.fdl7j6eb3ln7uj4g@pengutronix.de>
References: <20230627082334.1253020-1-privatesub2@gmail.com>
 <20230627082334.1253020-3-privatesub2@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hups2wxs3yv2f6pc"
Content-Disposition: inline
In-Reply-To: <20230627082334.1253020-3-privatesub2@gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hups2wxs3yv2f6pc
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Tue, Jun 27, 2023 at 11:23:25AM +0300, Aleksandr Shubin wrote:
> Allwinner's D1, T113-S3 and R329 SoCs have a quite different PWM
> controllers with ones supported by pwm-sun4i driver.
>=20
> This patch adds a PWM controller driver for Allwinner's D1,
> T113-S3 and R329 SoCs. The main difference between these SoCs
> is the number of channels defined by the DT property.
>=20
> Signed-off-by: Aleksandr Shubin <privatesub2@gmail.com>
> ---
>  drivers/pwm/Kconfig      |  10 ++
>  drivers/pwm/Makefile     |   1 +
>  drivers/pwm/pwm-sun20i.c | 322 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 333 insertions(+)
>  create mode 100644 drivers/pwm/pwm-sun20i.c
>=20
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index 8df861b1f4a3..05c48a36969e 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -594,6 +594,16 @@ config PWM_SUN4I
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called pwm-sun4i.
> =20
> +config PWM_SUN20I
> +	tristate "Allwinner D1/T113s/R329 PWM support"
> +	depends on ARCH_SUNXI || COMPILE_TEST
> +	depends on COMMON_CLK
> +	help
> +	  Generic PWM framework driver for Allwinner D1/T113s/R329 SoCs.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called pwm-sun20i.
> +
>  config PWM_SUNPLUS
>  	tristate "Sunplus PWM support"
>  	depends on ARCH_SUNPLUS || COMPILE_TEST
> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> index 19899b912e00..cea872e22c78 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -55,6 +55,7 @@ obj-$(CONFIG_PWM_STM32)		+=3D pwm-stm32.o
>  obj-$(CONFIG_PWM_STM32_LP)	+=3D pwm-stm32-lp.o
>  obj-$(CONFIG_PWM_STMPE)		+=3D pwm-stmpe.o
>  obj-$(CONFIG_PWM_SUN4I)		+=3D pwm-sun4i.o
> +obj-$(CONFIG_PWM_SUN20I)	+=3D pwm-sun20i.o
>  obj-$(CONFIG_PWM_SUNPLUS)	+=3D pwm-sunplus.o
>  obj-$(CONFIG_PWM_TEGRA)		+=3D pwm-tegra.o
>  obj-$(CONFIG_PWM_TIECAP)	+=3D pwm-tiecap.o
> diff --git a/drivers/pwm/pwm-sun20i.c b/drivers/pwm/pwm-sun20i.c
> new file mode 100644
> index 000000000000..63e9c64e0e18
> --- /dev/null
> +++ b/drivers/pwm/pwm-sun20i.c
> @@ -0,0 +1,322 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * PWM Controller Driver for sunxi platforms (D1, T113-S3 and R329)
> + *
> + * Limitations:
> + * - When the parameters change, current running period will not be comp=
leted
> + *   and run new settings immediately.
> + * - It output HIGH-Z state when PWM channel disabled.
> + *
> + * Copyright (c) 2023 Aleksandr Shubin <privatesub2@gmail.com>
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/clk.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/pwm.h>
> +#include <linux/reset.h>
> +
> +#define PWM_CLK_CFG_REG(chan)		(0x20 + (((chan) >> 1) * 0x4))
> +#define PWM_CLK_SRC			GENMASK(8, 7)
> +#define PWM_CLK_DIV_M			GENMASK(3, 0)
> +
> +#define PWM_CLK_GATE_REG		0x40
> +#define PWM_CLK_BYPASS(chan)		BIT((chan) - 16)
> +#define PWM_CLK_GATING(chan)		BIT(chan)
> +
> +#define PWM_ENABLE_REG			0x80
> +#define PWM_EN(chan)			BIT(chan)
> +
> +#define PWM_CTL_REG(chan)		(0x100 + (chan) * 0x20)
> +#define PWM_ACT_STA			BIT(8)
> +#define PWM_PRESCAL_K			GENMASK(7, 0)
> +
> +#define PWM_PERIOD_REG(chan)		(0x104 + (chan) * 0x20)
> +#define PWM_ENTIRE_CYCLE		GENMASK(31, 16)
> +#define PWM_ACT_CYCLE			GENMASK(15, 0)

Can you please adapt the register field names to include the register
name? I'd use:

#define PWM_CTL(chan)		(0x100 + (chan) * 0x20)
#define PWM_CTL_ACT_STA			BIT(8)
#define PWM_CTL_PRESCAL_K		GENMASK(7, 0)

then you get a chance to spot when PWM_CLK_BYPASS(x) is written to
PWM_CLK_CFG.


> +struct sun20i_pwm_chip {
> +	struct pwm_chip chip;
> +	struct clk *clk_bus, *clk_hosc;
> +	struct reset_control *rst;
> +	void __iomem *base;
> +	/* Mutex to protect pwm apply state */
> +	struct mutex mutex;
> +};
> +
> +static inline struct sun20i_pwm_chip *to_sun20i_pwm_chip(struct pwm_chip=
 *chip)
> +{
> +	return container_of(chip, struct sun20i_pwm_chip, chip);
> +}
> +
> +static inline u32 sun20i_pwm_readl(struct sun20i_pwm_chip *chip,
> +				   unsigned long offset)
> +{
> +	return readl(chip->base + offset);
> +}
> +
> +static inline void sun20i_pwm_writel(struct sun20i_pwm_chip *chip,
> +				     u32 val, unsigned long offset)
> +{
> +	writel(val, chip->base + offset);
> +}
> +
> +static int sun20i_pwm_get_state(struct pwm_chip *chip,
> +				struct pwm_device *pwm,
> +				struct pwm_state *state)
> +{
> +	struct sun20i_pwm_chip *sun20i_chip =3D to_sun20i_pwm_chip(chip);
> +	u64 clk_rate, tmp;
> +	u32 val;
> +	u16 ent_cycle, act_cycle;
> +	u8 prescal, div_id;
> +
> +	mutex_lock(&sun20i_chip->mutex);
> +
> +	val =3D sun20i_pwm_readl(sun20i_chip, PWM_CLK_CFG_REG(pwm->hwpwm));
> +	div_id =3D FIELD_GET(PWM_CLK_DIV_M, val);
> +	if (FIELD_GET(PWM_CLK_SRC, val) =3D=3D 0)
> +		clk_rate =3D clk_get_rate(sun20i_chip->clk_hosc);
> +	else
> +		clk_rate =3D clk_get_rate(sun20i_chip->clk_bus);
> +
> +	val =3D sun20i_pwm_readl(sun20i_chip, PWM_CTL_REG(pwm->hwpwm));
> +	state->polarity =3D (PWM_ACT_STA & val) ? PWM_POLARITY_NORMAL : PWM_POL=
ARITY_INVERSED;
> +
> +	prescal =3D FIELD_GET(PWM_PRESCAL_K, val) + 1;

If PWM_PRESCAL_K is 0xff, prescal ends up being 0. This isn't right, is
it?

> +	val =3D sun20i_pwm_readl(sun20i_chip, PWM_ENABLE_REG);
> +	state->enabled =3D (PWM_EN(pwm->hwpwm) & val) ? true : false;
> +
> +	val =3D sun20i_pwm_readl(sun20i_chip, PWM_PERIOD_REG(pwm->hwpwm));
> +	act_cycle =3D FIELD_GET(PWM_ACT_CYCLE, val);
> +	ent_cycle =3D FIELD_GET(PWM_ENTIRE_CYCLE, val);
> +	if (act_cycle > ent_cycle)
> +		act_cycle =3D ent_cycle;
> +

A comment that with the width of the used factors this cannot overflow
would be nice here.

> +	tmp =3D (u64)(act_cycle) * prescal * (1U << div_id) * NSEC_PER_SEC;

Can be simplified to:

	tmp =3D (u64)act_cycle * prescal << div_id * NSEC_PER_SEC;

> +	state->duty_cycle =3D DIV_ROUND_UP_ULL(tmp, clk_rate);
> +	tmp =3D (u64)(ent_cycle) * prescal * (1U << div_id) * NSEC_PER_SEC;
> +	state->period =3D DIV_ROUND_UP_ULL(tmp, clk_rate);
> +	mutex_unlock(&sun20i_chip->mutex);
> +
> +	return 0;
> +}
> +
> +static int sun20i_pwm_apply(struct pwm_chip *chip, struct pwm_device *pw=
m,
> +			    const struct pwm_state *state)
> +{
> +	int ret =3D 0;
> +	u32 clk_gate, clk_cfg, pwm_en, ctl, period;
> +	u64 bus_rate, hosc_rate, clk_div, val;
> +	u16 prescaler, div_m;
> +	bool use_bus_clk, calc_div_m;
> +	struct sun20i_pwm_chip *sun20i_chip =3D to_sun20i_pwm_chip(chip);
> +
> +	mutex_lock(&sun20i_chip->mutex);
> +
> +	pwm_en =3D sun20i_pwm_readl(sun20i_chip, PWM_ENABLE_REG);
> +
> +	if (state->enabled !=3D pwm->state.enabled)
> +		clk_gate =3D sun20i_pwm_readl(sun20i_chip, PWM_CLK_GATE_REG);
> +
> +	if (state->enabled !=3D pwm->state.enabled && !state->enabled) {
> +		clk_gate &=3D ~PWM_CLK_GATING(pwm->hwpwm);
> +		pwm_en &=3D ~PWM_EN(pwm->hwpwm);
> +		sun20i_pwm_writel(sun20i_chip, pwm_en, PWM_ENABLE_REG);
> +		sun20i_pwm_writel(sun20i_chip, clk_gate, PWM_CLK_GATE_REG);
> +	}
> +
> +	if (state->polarity !=3D pwm->state.polarity ||
> +	    state->duty_cycle !=3D pwm->state.duty_cycle ||
> +	    state->period !=3D pwm->state.period) {
> +		ctl =3D sun20i_pwm_readl(sun20i_chip, PWM_CTL_REG(pwm->hwpwm));
> +		clk_cfg =3D sun20i_pwm_readl(sun20i_chip, PWM_CLK_CFG_REG(pwm->hwpwm));
> +		hosc_rate =3D clk_get_rate(sun20i_chip->clk_hosc);
> +		bus_rate =3D clk_get_rate(sun20i_chip->clk_bus);
> +		if (pwm_en & PWM_EN(pwm->hwpwm ^ 1)) {
> +			/* if the neighbor channel is enable, check period only */
> +			use_bus_clk =3D FIELD_GET(PWM_CLK_SRC, clk_cfg) !=3D 0;
> +			if (use_bus_clk)
> +				val =3D state->period * bus_rate;
> +			else
> +				val =3D state->period * hosc_rate;
> +			do_div(val, NSEC_PER_SEC);
> +
> +			div_m =3D FIELD_GET(PWM_CLK_DIV_M, clk_cfg);
> +			calc_div_m =3D false;
> +		} else {
> +			/* check period and select clock source */
> +			use_bus_clk =3D false;
> +			val =3D state->period * hosc_rate;
> +			do_div(val, NSEC_PER_SEC);
> +			if (val <=3D 1) {
> +				use_bus_clk =3D true;
> +				val =3D state->period * bus_rate;
> +				do_div(val, NSEC_PER_SEC);
> +				if (val <=3D 1) {
> +					ret =3D -EINVAL;
> +					goto unlock_mutex;
> +				}
> +			}
> +			div_m =3D 0;
> +			calc_div_m =3D true;
> +
> +			/* set up the CLK_DIV_M and clock CLK_SRC */
> +			clk_cfg =3D FIELD_PREP(PWM_CLK_DIV_M, div_m);
> +			clk_cfg |=3D FIELD_PREP(PWM_CLK_SRC, use_bus_clk ? 1 : 0);
> +
> +			sun20i_pwm_writel(sun20i_chip, clk_cfg, PWM_CLK_CFG_REG(pwm->hwpwm));
> +		}
> +
> +		/* calculate prescaler, M factor, PWM entire cycle */
> +		clk_div =3D val;

This assignment is useless as it is overwritten in the loop below, isn't
it?

> +		for (prescaler =3D 0;; prescaler++) {
> +			if (prescaler >=3D 256) {
> +				if (calc_div_m) {
> +					prescaler =3D 0;
> +					div_m++;
> +					if (div_m >=3D 9) {
> +						ret =3D -EINVAL;
> +						goto unlock_mutex;
> +					}
> +				} else {
> +					ret =3D -EINVAL;
> +					goto unlock_mutex;
> +				}
> +			}
> +
> +			clk_div =3D val >> div_m;
> +			do_div(clk_div, prescaler + 1);
> +			if (clk_div <=3D 65534)
> +				break;

This can be calculated without a loop.

> +		}
> +
> +		period =3D FIELD_PREP(PWM_ENTIRE_CYCLE, clk_div);
> +
> +		/* set duty cycle */
> +		if (use_bus_clk)
> +			val =3D state->duty_cycle * bus_rate;
> +		else
> +			val =3D state->duty_cycle * hosc_rate;
> +		do_div(val, NSEC_PER_SEC);
> +		clk_div =3D val >> div_m;
> +		do_div(clk_div, prescaler + 1);
> +
> +		if (state->duty_cycle =3D=3D state->period)
> +			clk_div++;

I don't understand that one. Can you explain that in a comment please?

> +		period |=3D FIELD_PREP(PWM_ACT_CYCLE, clk_div);
> +		sun20i_pwm_writel(sun20i_chip, period, PWM_PERIOD_REG(pwm->hwpwm));
> +
> +		ctl =3D FIELD_PREP(PWM_PRESCAL_K, prescaler);
> +		if (state->polarity =3D=3D PWM_POLARITY_NORMAL)
> +			ctl |=3D PWM_ACT_STA;
> +
> +		sun20i_pwm_writel(sun20i_chip, ctl, PWM_CTL_REG(pwm->hwpwm));

Is this racy? I.e. does the write to PWM_PERIOD_REG(pwm->hwpwm) above
already has an effect before PWM_CTL_REG(pwm->hwpwm) is written?

> +	}
> +
> +	if (state->enabled !=3D pwm->state.enabled && state->enabled) {
> +		clk_gate &=3D ~PWM_CLK_BYPASS(pwm->hwpwm);
> +		clk_gate |=3D PWM_CLK_GATING(pwm->hwpwm);
> +		pwm_en |=3D PWM_EN(pwm->hwpwm);
> +		sun20i_pwm_writel(sun20i_chip, pwm_en, PWM_ENABLE_REG);
> +		sun20i_pwm_writel(sun20i_chip, clk_gate, PWM_CLK_GATE_REG);

This is (I guess) racy. If your PWM is running with

	.period =3D 10000
	.duty_cyle =3D 0
	.enabled =3D true

and you configure it to

	.period =3D 10000
	.duty_cyle =3D 10000
	.enabled =3D false

you get a short spike. For a enabled=3Dtrue -> enabled=3Dfalse transition
you should disable first before configuring duty+period (or skip the
latter completely).

> +	}
> +
> +unlock_mutex:
> +	mutex_unlock(&sun20i_chip->mutex);
> +
> +	return ret;
> +}

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--hups2wxs3yv2f6pc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmSry+QACgkQj4D7WH0S
/k4dcAgAtOMWoCExbx0n3YNRrLPWeYqAyeg/MrdSOBx8alRlLnRf7SlX/krog4rc
VhI15DHGogBK/KBeWxicgH6iSpQSkzleQXQa0DiXsM72ZUP2MfKae7KspvJiFCx2
/QfkeQlGHJZ9NgGQssTFk+jjGEnbGN2poWUtqGgNzGC+PHKoQDUaYjl5jdleTzuD
KzIdmOCyxUg1Q2t87Y9jEuNuU3D9A4KPvXFmAcnzA2g3hynqmaHZTdpdqPYQt8MC
F6KeEy+YVtb94KZG5CxMqClX/OXcjF6+/9yE6nYtcRyN1HWwSpWS6WE8st6umvoe
25c0hiXUWIkfrHjWmsn0IFZqHQYexQ==
=VLVp
-----END PGP SIGNATURE-----

--hups2wxs3yv2f6pc--
