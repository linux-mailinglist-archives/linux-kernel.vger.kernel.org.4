Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84E59732972
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 10:04:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243699AbjFPIEQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 04:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245042AbjFPIEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 04:04:10 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 825BD2D68
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 01:03:54 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qA4Qh-0004eP-9N; Fri, 16 Jun 2023 10:03:35 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qA4Qc-007m4w-5h; Fri, 16 Jun 2023 10:03:30 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qA4Qb-00Eget-5c; Fri, 16 Jun 2023 10:03:29 +0200
Date:   Fri, 16 Jun 2023 10:03:26 +0200
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
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Maxime Ripard <mripard@kernel.org>, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v1 2/3] pwm: Add Allwinner's D1/T113-S3/R329 SoCs PWM
 support
Message-ID: <20230616080326.2vtkfeyzwx542hk7@pengutronix.de>
References: <20230615144423.828698-1-privatesub2@gmail.com>
 <20230615144423.828698-3-privatesub2@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="omtys6jenmiw526p"
Content-Disposition: inline
In-Reply-To: <20230615144423.828698-3-privatesub2@gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--omtys6jenmiw526p
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

this isn't a complete review, just a first quick look. Up to you if you
follow up with a v2 fixing the things here. If you don't I will take a
deeper look at a later time.

On Thu, Jun 15, 2023 at 05:43:57PM +0300, Aleksandr Shubin wrote:
> Allwinner's D1, T113-S3 and R329 SoCs have a quite different PWM
> controllers with ones supported by pwm-sun4i driver.
>=20
> This patch adds a PWM controller driver for Allwinner's D1,
> T113-S3 and R329 SoCs. The main difference between these SoCs
> is the number of channels defined by the DT property.
>=20
> Signed-off-by: Aleksandr Shubin <privatesub2@gmail.com>
> ---
>  drivers/pwm/Kconfig      |  12 ++
>  drivers/pwm/Makefile     |   1 +
>  drivers/pwm/pwm-sun20i.c | 364 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 377 insertions(+)
>  create mode 100644 drivers/pwm/pwm-sun20i.c
>=20
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index 8df861b1f4a3..b435e50fbd3e 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -594,6 +594,18 @@ config PWM_SUN4I
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called pwm-sun4i.
> =20
> +config PWM_SUN20I
> +	tristate "Allwinner D1/T113s/R329 PWM support"
> +	depends on ARCH_SUNXI || COMPILE_TEST
> +	depends on COMMON_CLK
> +	help
> +	  Generic PWM framework driver for Allwinner D1/T113s/R329 SoCs.
> +	  The main difference between these SoCs is the number of
> +	  channels defined by the DT property.

That is a detail that better fits into a code comment in the driver. The
user choosing if they should enable PWM_SUN20I or not, don't need to
know that.

> +	  To compile this driver as a module, choose M here: the module
> +	  will be called pwm-sun20i.
> +
>  config PWM_SUNPLUS
>  	tristate "Sunplus PWM support"
>  	depends on ARCH_SUNPLUS || COMPILE_TEST
> [...]
> diff --git a/drivers/pwm/pwm-sun20i.c b/drivers/pwm/pwm-sun20i.c
> new file mode 100644
> index 000000000000..100b0f3bcec0
> --- /dev/null
> +++ b/drivers/pwm/pwm-sun20i.c
> @@ -0,0 +1,364 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * PWM Controller Driver for sunxi platforms (D1, T113-S3 and R329)
> + *
> + * Copyright (c) 2023 Aleksandr Shubin <privatesub2@gmail.com>
> + */

Please add a "Limitations" section here answering the following
questions:

 - Is a currently running period completed when a new pwm_state is
   applied that has .enabled =3D true? What about .enabled =3D false?
 - How does the PWM behave when disabled? Typical behaviours are: drives
   to inactive level, just freezes or goes HIGH-Z.

Stick to the format that is used in other drivers to make this easily
grepable.

> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/pwm.h>
> +#include <linux/clk.h>
> +#include <linux/reset.h>

alphabetic ordering please

> +#define PWM_CLK_CFG_REG(chan)		(0x20 + (((chan) >> 1) * 0x4))
> +#define PWM_CLK_SRC			7
> +#define PWM_CLK_SRC_MASK		GENMASK(8, PWM_CLK_SRC)
> +#define PWM_CLK_DIV_M			0
> +#define PWM_CLK_DIV_M_MASK		GENMASK(3, PWM_CLK_DIV_M)
> +
> +#define PWM_CLK_GATE_REG		0x40
> +#define PWM_CLK_GATING(chan)		BIT(chan)
> +
> +#define PWM_ENABLE_REG			0x80
> +#define PWM_EN(chan)			BIT(chan)
> +
> +#define PWM_CTL_REG(chan)		(0x100 + (chan) * 0x20)
> +#define PWM_ACT_STA			BIT(8)
> +#define PWM_PRESCAL_K			0
> +#define PWM_PRESCAL_K_MASK		GENMASK(7, PWM_PRESCAL_K)
> +
> +#define PWM_PERIOD_REG(chan)		(0x104 + (chan) * 0x20)
> +#define PWM_ENTIRE_CYCLE		16
> +#define PWM_ENTIRE_CYCLE_MASK		GENMASK(31, PWM_ENTIRE_CYCLE)
> +#define PWM_ACT_CYCLE			0
> +#define PWM_ACT_CYCLE_MASK		GENMASK(15, PWM_ACT_CYCLE)
> +
> +#define SET_VALUE(reg_val, val, name) \
> +		 (reg_val =3D (((reg_val) & ~name##_MASK) | ((val) << (name))))
> +#define GET_VALUE(reg_val, name) \
> +		 (((reg_val) & ~name##_MASK) >> (name))

Please use FIELD_GET here instead. This works nice with dropping
PWM_PRESCAL_K and renaming PWM_PRESCAL_K_MASK to PWM_PRESCAL_K.

> [...]
> +static int sun20i_pwm_get_state(struct pwm_chip *chip,
> +				struct pwm_device *pwm,
> +				struct pwm_state *state)
> +{
> +	struct sun20i_pwm_chip *sun20i_chip =3D to_sun20i_pwm_chip(chip);
> +	u64 clk_rate, tmp;
> +	u32 val;
> +	u16 clk_div, act_cycle;
> +	u8 prescal, div_id;
> +	u8 chn =3D pwm->hwpwm;
> +
> +	mutex_lock(&sun20i_chip->mutex);
> +
> +	val =3D sun20i_pwm_readl(sun20i_chip, PWM_CLK_CFG_REG(pwm->hwpwm));
> +	div_id =3D GET_VALUE(val, PWM_CLK_DIV_M);
> +	if (GET_VALUE(val, PWM_CLK_SRC) =3D=3D 0)
> +		clk_rate =3D clk_get_rate(sun20i_chip->clk_hosc);
> +	else
> +		clk_rate =3D clk_get_rate(sun20i_chip->clk_bus);
> +
> +	val =3D sun20i_pwm_readl(sun20i_chip, PWM_CTL_REG(pwm->hwpwm));
> +	if (PWM_ACT_STA & val)
> +		state->polarity =3D PWM_POLARITY_NORMAL;
> +	else
> +		state->polarity =3D PWM_POLARITY_INVERSED;
> +
> +	prescal =3D PWM_PRESCAL_K & val;
> +
> +	val =3D sun20i_pwm_readl(sun20i_chip, PWM_ENABLE_REG);
> +	if (PWM_EN(chn) & val)
> +		state->enabled =3D true;
> +	else
> +		state->enabled =3D false;
> +
> +	val =3D sun20i_pwm_readl(sun20i_chip, PWM_PERIOD_REG(pwm->hwpwm));
> +	act_cycle =3D GET_VALUE(val, PWM_ACT_CYCLE);
> +	clk_div =3D GET_VALUE(val, PWM_ENTIRE_CYCLE);
> +
> +	tmp =3D act_cycle * prescal * (1U << div_id) * NSEC_PER_SEC;
> +	state->duty_cycle =3D DIV_ROUND_CLOSEST_ULL(tmp, clk_rate);
> +	tmp =3D clk_div * prescal * (1U << div_id) * NSEC_PER_SEC;
> +	state->period =3D DIV_ROUND_CLOSEST_ULL(tmp, clk_rate);

You have to use ROUND_UP here to make

	.get_state(mypwm, &state);
	.apply(mypwm, &state);

idempotent. Test your driver with PWM_DEBUG enabled. With an appropriate
test sequence this should tell you such things. Test with something
like:

	for i in some_range:
		pwm_apply_state(mypwm, { .enabled =3D true, .period =3D i, .duty_cycle =
=3D 0 })
	for i in reversed(some_range):
		pwm_apply_state(mypwm, { .enabled =3D true, .period =3D i, .duty_cycle =
=3D 0 })

	for i in [0, someperiod]:
		pwm_apply_state(mypwm, { .enabled =3D true, .period =3D someperiod, .duty=
_cycle =3D i })
	for i in reversed([0, someperiod]):
		pwm_apply_state(mypwm, { .enabled =3D true, .period =3D someperiod, .duty=
_cycle =3D i })

> +	mutex_unlock(&sun20i_chip->mutex);
> +
> +	return 0;
> +}
> +
> +static int sun20i_pwm_apply(struct pwm_chip *chip, struct pwm_device *pw=
m,
> +			    const struct pwm_state *state)
> +{
> +	struct pwm_state curstate;
> +	int ret =3D 0;
> +	u32 clk_gate, clk_cfg, pwm_en, ctl, period;
> +	u64 bus_rate, hosc_rate, clk_div, val, clk_rate;
> +	u16 prescaler, div_m;
> +	bool use_bus_clk;
> +	struct sun20i_pwm_chip *sun20i_chip =3D to_sun20i_pwm_chip(chip);
> +
> +	mutex_lock(&sun20i_chip->mutex);
> +	pwm_get_state(pwm, &curstate);

Don't call pwm API functions in lowlevel driver. Even less while holding
a lock. If you need the previous state, using pwm->state is fine.

> +	pwm_en =3D sun20i_pwm_readl(sun20i_chip, PWM_ENABLE_REG);
> +	if (state->polarity !=3D curstate.polarity ||
> +	    state->duty_cycle !=3D curstate.duty_cycle ||
> +	    state->period !=3D curstate.period) {
> +		ctl =3D sun20i_pwm_readl(sun20i_chip, PWM_CTL_REG(pwm->hwpwm));
> +		clk_cfg =3D sun20i_pwm_readl(sun20i_chip, PWM_CLK_CFG_REG(pwm->hwpwm));
> +		hosc_rate =3D clk_get_rate(sun20i_chip->clk_hosc);
> +		bus_rate =3D clk_get_rate(sun20i_chip->clk_bus);
> +
> +		if (pwm_en & PWM_EN(pwm->hwpwm ^ 1)) {
> +			/* check period only */
> +			if (GET_VALUE(clk_cfg, PWM_CLK_SRC) =3D=3D 0)
> +				clk_rate =3D hosc_rate;
> +			else
> +				clk_rate =3D bus_rate;
> +
> +			val =3D state->period * clk_rate;

This might overflow.

> +			do_div(val, NSEC_PER_SEC);
> +
> +			div_m =3D GET_VALUE(clk_cfg, PWM_CLK_DIV_M);
> +
> +			/* calculate and set prescaler, PWM entire cycle */
> +			clk_div =3D val;
> +			for (prescaler =3D 0; clk_div > 65535; prescaler++) {
> +				if (prescaler >=3D 256) {
> +					dev_err(sun20i_chip->chip.dev, "Period is too long\n");

dev_err in .apply() isn't a good idea. Please fail silently.

Also you should configure the biggest period the hardware can support
that isn't bigger than state->period. So the requested period cannot be
too long.

> +					ret =3D -EINVAL;
> +					goto unlock_mutex;
> +				}
> +
> +				clk_div =3D val;
> +				do_div(clk_div, 1U << div_m);

This can be simplified to clk_div >> div_m.

> +				do_div(clk_div, prescaler + 1);
> +			}

I wonder if prescaler can be calculated without a loop.

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
> +					dev_err(sun20i_chip->chip.dev, "Period is too small\n");
> +					ret =3D -EINVAL;
> +					goto unlock_mutex;
> +				}
> +			}
> +
> +			if (use_bus_clk)
> +				SET_VALUE(clk_cfg, 1, PWM_CLK_SRC);
> +			else
> +				SET_VALUE(clk_cfg, 0, PWM_CLK_SRC);
> +
> +			/* calculate and set prescaler, M factor, PWM entire cycle */
> +			clk_div =3D val;
> +			for (prescaler =3D div_m =3D 0; clk_div > 65535; prescaler++) {
> +				if (prescaler >=3D 256) {
> +					prescaler =3D 0;
> +					div_m++;
> +					if (div_m >=3D 9) {
> +						dev_err(sun20i_chip->chip.dev, "Period is too long\n");
> +						ret =3D -EINVAL;
> +						goto unlock_mutex;
> +					}
> +				}
> +
> +				clk_div =3D val;
> +				do_div(clk_div, 1U << div_m);
> +				do_div(clk_div, prescaler + 1);
> +			}
> +
> +			/* set up the M factor */
> +			SET_VALUE(clk_cfg, div_m, PWM_CLK_DIV_M);
> +
> +			sun20i_pwm_writel(sun20i_chip, clk_cfg, PWM_CLK_CFG_REG(pwm->hwpwm));
> +		}
> +
> +		period =3D sun20i_pwm_readl(sun20i_chip, PWM_PERIOD_REG(pwm->hwpwm));
> +
> +		SET_VALUE(period, clk_div, PWM_ENTIRE_CYCLE);
> +		SET_VALUE(ctl, prescaler, PWM_PRESCAL_K);

Are there any fields in PWM_PERIOD_REG(pwm->hwpwm) you're not
recalculating? If not, you can skip reading the register and use
FIELD_PREP instead of SET_VALUE.

> +
> +		/* set duty cycle */
> +		val =3D state->period;
> +		do_div(val, clk_div);
> +		clk_div =3D state->duty_cycle;
> +		do_div(clk_div, val);
> +		if (clk_div > 65535)
> +			clk_div =3D 65535;
> +
> +		SET_VALUE(period, clk_div, PWM_ACT_CYCLE);
> +		sun20i_pwm_writel(sun20i_chip, period, PWM_PERIOD_REG(pwm->hwpwm));
> +
> +		if (state->polarity =3D=3D PWM_POLARITY_NORMAL)
> +			ctl |=3D PWM_ACT_STA;
> +		else
> +			ctl &=3D ~PWM_ACT_STA;
> +
> +		sun20i_pwm_writel(sun20i_chip, ctl, PWM_CTL_REG(pwm->hwpwm));
> +	}
> +
> +	if (state->enabled !=3D curstate.enabled) {
> +		clk_gate =3D sun20i_pwm_readl(sun20i_chip, PWM_CLK_GATE_REG);
> +
> +		if (state->enabled) {
> +			clk_gate |=3D PWM_CLK_GATING(pwm->hwpwm);
> +			pwm_en |=3D PWM_EN(pwm->hwpwm);
> +		} else {
> +			clk_gate &=3D ~PWM_CLK_GATING(pwm->hwpwm);
> +			pwm_en &=3D ~PWM_EN(pwm->hwpwm);
> +		}

Disabling (probably) needs to be handled earlier. Consider your PWM is
enabled with say .period =3D 5000 and .duty_cycle =3D 0. If now

	pwm_apply_state(&mypwm, &(struct pwm_state){ .period =3D 5000, .duty_cycle=
 =3D 5000, .enabled =3D false })

is called, the output might become active before gating becomes
effective. It's not always possible to prevent such spikes, but if it
is, please do.

> +		sun20i_pwm_writel(sun20i_chip, pwm_en, PWM_ENABLE_REG);
> +		sun20i_pwm_writel(sun20i_chip, clk_gate, PWM_CLK_GATE_REG);
> +	}
> +
> +unlock_mutex:
> +	mutex_unlock(&sun20i_chip->mutex);
> +
> +	return ret;
> +}
> [...]
> +static int sun20i_pwm_probe(struct platform_device *pdev)
> +{
> +	struct sun20i_pwm_chip *sun20i_chip;
> +	int ret;
> +
> +	sun20i_chip =3D devm_kzalloc(&pdev->dev, sizeof(*sun20i_chip), GFP_KERN=
EL);
> +	if (!sun20i_chip)
> +		return -ENOMEM;
> +
> +	sun20i_chip->base =3D devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(sun20i_chip->base))
> +		return PTR_ERR(sun20i_chip->base);
> +
> +	sun20i_chip->clk_bus =3D devm_clk_get(&pdev->dev, "bus");

consider using devm_clk_get_enabled()

> +	if (IS_ERR(sun20i_chip->clk_bus)) {
> +		dev_err(&pdev->dev, "Failed to get bus clock\n");
> +		return PTR_ERR(sun20i_chip->clk_bus);

Please make this:

	return dev_err_probe(&pdev->dev, PTR_ERR(sun20i_chip->clk_bus),
			     "Failed to get bus clock\n");

ditto for the other error paths.

> +	}
> +
> +	sun20i_chip->clk_hosc =3D devm_clk_get(&pdev->dev, "hosc");
> +	if (IS_ERR(sun20i_chip->clk_hosc)) {
> +		dev_err(&pdev->dev, "Failed to get hosc clock\n");
> +		return PTR_ERR(sun20i_chip->clk_hosc);
> +	}
> +
> +	sun20i_chip->rst =3D devm_reset_control_get(&pdev->dev, NULL);
> +	if (IS_ERR(sun20i_chip->rst)) {
> +		dev_err(&pdev->dev, "Failed to get bus reset\n");
> +		return PTR_ERR(sun20i_chip->rst);
> +	}
> +
> +	/* Deassert reset */
> +	ret =3D reset_control_deassert(sun20i_chip->rst);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Failed to deassert reset\n");
> +		return ret;
> +	}
> +
> +	ret =3D clk_prepare_enable(sun20i_chip->clk_bus);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Failed to ungate bus clock\n");
> +		goto err_bus;
> +	}
> +
> +	ret =3D of_property_read_u32(pdev->dev.of_node,
> +				   "allwinner,pwm-channels",
> +				   &sun20i_chip->chip.npwm);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Can't get pwm-channels\n");
> +		goto err_pwm_add;
> +	}
> +
> +	sun20i_chip->chip.dev =3D &pdev->dev;
> +	sun20i_chip->chip.ops =3D &sun20i_pwm_ops;
> +
> +	mutex_init(&sun20i_chip->mutex);

If the hardware is enabled, please make sure that the needed clocks are
not disabled.

> +	ret =3D pwmchip_add(&sun20i_chip->chip);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "Failed to add PWM chip: %d\n", ret);
> +		goto err_pwm_add;
> +	}
> +
> +	platform_set_drvdata(pdev, sun20i_chip);
> +
> +	return 0;
> +
> +err_pwm_add:
> +	clk_disable_unprepare(sun20i_chip->clk_bus);
> +err_bus:
> +	reset_control_assert(sun20i_chip->rst);
> +	return ret;
> +}

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--omtys6jenmiw526p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmSMF00ACgkQj4D7WH0S
/k7sEQgAspa88ofdGgi7mlHIUrSkqDb6X5/7Ym54FYjTv3Wyt8CfohvpsJWpXJIl
5vmZXy1DNM41IQSd7wfDOHb+BNhZQJS1PwSAL1bnon0/KaU6PlYB8OLY0FKtPMee
GYQ8DSkeFbmdSWQJtHLHQFdKvhCnVkQ0799cifI8sFqm1bqQr9BU4Ix88V1G6aV5
HERtfPLsemBbDvTpVXp+bUn2rOuWtJSWx816HeeV2kqkKiJPuUS23cvhnrVo16i/
wUiMGcg0JXxvXW7AfOWOSSY3Wf2b0n3yW1r5EyxVDQlbw2axp/Ld4DiXjiRy44cp
0u1IHdt/q/k0WmAdiEPkZQkykxbhbg==
=p5z5
-----END PGP SIGNATURE-----

--omtys6jenmiw526p--
