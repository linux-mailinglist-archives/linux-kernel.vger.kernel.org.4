Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D437A652896
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 22:54:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234028AbiLTVyh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 16:54:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiLTVyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 16:54:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40A791EEDB;
        Tue, 20 Dec 2022 13:54:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BE68561530;
        Tue, 20 Dec 2022 21:54:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75B31C433EF;
        Tue, 20 Dec 2022 21:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671573272;
        bh=Rt7ZzAkxlRlAh37qRlLQ7nNRGV7hFRN7sCcbGoEwoaI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jr9X/Lbe16gTLlNs7N7EqMR1lzve8t98LSK/E9Y2mvOpSS0IbZNK3bqpqxja7M1rZ
         P+p7y6nw1WDiEMLTzz/ZKnExALlsGO1RNeLXbIFpFB/c+UhKbvL8aWTh1aHplezV5W
         mQAUNJ09AszXG8UIoWtGxQiY0tGQpxkntiFwZjIpJDQ1PSgmWkXn1PlbgyfOP7J+S2
         tBOeqPZ3AhejflC/vk4tVEZGCZb7CgJIediffcAWlfwwsN12NwGIO5ZIjU/Fu45G21
         YD2c0GfqIgQfWoFxlSVbulhoy+0rfbcN0R7rgiWGyJPe1mvq+v0Q1ghn+wR7qC2hzu
         0TtrzSCNf3jBw==
Date:   Tue, 20 Dec 2022 21:54:26 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Hal Feng <hal.feng@starfivetech.com>
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, Palmer Dabbelt <palmer@dabbelt.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 01/11] clk: starfive: Factor out common JH7100 and
 JH7110 code
Message-ID: <Y6IvEnm1Wm9KM5KO@spud>
References: <20221220005054.34518-1-hal.feng@starfivetech.com>
 <20221220005054.34518-2-hal.feng@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="q1JFCHtmxY2Y5pMV"
Content-Disposition: inline
In-Reply-To: <20221220005054.34518-2-hal.feng@starfivetech.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--q1JFCHtmxY2Y5pMV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 20, 2022 at 08:50:44AM +0800, Hal Feng wrote:
> From: Emil Renner Berthing <kernel@esmil.dk>
>=20
> The clock control registers on the StarFive JH7100 and JH7110 work
> identically, so factor out the code then drivers for the two SoCs
> can share it without depending on each other. No functional change.
>=20
> Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>

The movement does in fact appear to be just a movement..
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Thanks,
Conor.

> ---
>  MAINTAINERS                                |   4 +-
>  drivers/clk/starfive/Kconfig               |   5 +
>  drivers/clk/starfive/Makefile              |   3 +-
>  drivers/clk/starfive/clk-starfive-jh7100.c | 325 --------------------
>  drivers/clk/starfive/clk-starfive-jh7100.h |   2 +
>  drivers/clk/starfive/clk-starfive-jh71x0.c | 333 +++++++++++++++++++++
>  6 files changed, 344 insertions(+), 328 deletions(-)
>  create mode 100644 drivers/clk/starfive/clk-starfive-jh71x0.c
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 886d3f69ee64..fd90403c33bd 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -19632,11 +19632,11 @@ M:	Emil Renner Berthing <kernel@esmil.dk>
>  S:	Maintained
>  F:	arch/riscv/boot/dts/starfive/
> =20
> -STARFIVE JH7100 CLOCK DRIVERS
> +STARFIVE JH71X0 CLOCK DRIVERS
>  M:	Emil Renner Berthing <kernel@esmil.dk>
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/clock/starfive,jh7100-*.yaml
> -F:	drivers/clk/starfive/clk-starfive-jh7100*
> +F:	drivers/clk/starfive/clk-starfive-jh71*
>  F:	include/dt-bindings/clock/starfive-jh7100*.h
> =20
>  STARFIVE JH7100 PINCTRL DRIVER
> diff --git a/drivers/clk/starfive/Kconfig b/drivers/clk/starfive/Kconfig
> index 003bd2d56ce7..594d516dcb38 100644
> --- a/drivers/clk/starfive/Kconfig
> +++ b/drivers/clk/starfive/Kconfig
> @@ -1,8 +1,12 @@
>  # SPDX-License-Identifier: GPL-2.0
> =20
> +config CLK_STARFIVE_JH71X0
> +	bool
> +
>  config CLK_STARFIVE_JH7100
>  	bool "StarFive JH7100 clock support"
>  	depends on SOC_STARFIVE || COMPILE_TEST
> +	select CLK_STARFIVE_JH71X0
>  	default SOC_STARFIVE
>  	help
>  	  Say yes here to support the clock controller on the StarFive JH7100
> @@ -11,6 +15,7 @@ config CLK_STARFIVE_JH7100
>  config CLK_STARFIVE_JH7100_AUDIO
>  	tristate "StarFive JH7100 audio clock support"
>  	depends on CLK_STARFIVE_JH7100
> +	select CLK_STARFIVE_JH71X0
>  	default m if SOC_STARFIVE
>  	help
>  	  Say Y or M here to support the audio clocks on the StarFive JH7100
> diff --git a/drivers/clk/starfive/Makefile b/drivers/clk/starfive/Makefile
> index 0fa8ecb9ec1c..82edfa9f9cb8 100644
> --- a/drivers/clk/starfive/Makefile
> +++ b/drivers/clk/starfive/Makefile
> @@ -1,4 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0
> -# StarFive Clock
> +obj-$(CONFIG_CLK_STARFIVE_JH71X0)	+=3D clk-starfive-jh71x0.o
> +
>  obj-$(CONFIG_CLK_STARFIVE_JH7100)	+=3D clk-starfive-jh7100.o
>  obj-$(CONFIG_CLK_STARFIVE_JH7100_AUDIO)	+=3D clk-starfive-jh7100-audio.o
> diff --git a/drivers/clk/starfive/clk-starfive-jh7100.c b/drivers/clk/sta=
rfive/clk-starfive-jh7100.c
> index 691aeebc7092..eea52f16af0d 100644
> --- a/drivers/clk/starfive/clk-starfive-jh7100.c
> +++ b/drivers/clk/starfive/clk-starfive-jh7100.c
> @@ -7,15 +7,10 @@
>   * Copyright (C) 2021 Emil Renner Berthing <kernel@esmil.dk>
>   */
> =20
> -#include <linux/bits.h>
>  #include <linux/clk-provider.h>
> -#include <linux/debugfs.h>
>  #include <linux/device.h>
>  #include <linux/init.h>
> -#include <linux/io.h>
> -#include <linux/kernel.h>
>  #include <linux/mod_devicetable.h>
> -#include <linux/module.h>
>  #include <linux/platform_device.h>
> =20
>  #include <dt-bindings/clock/starfive-jh7100.h>
> @@ -269,326 +264,6 @@ static const struct jh7100_clk_data jh7100_clk_data=
[] __initconst =3D {
>  	JH7100_GATE(JH7100_CLK_SYSERR_APB, "syserr_apb", 0, JH7100_CLK_APB2_BUS=
),
>  };
> =20
> -static struct jh7100_clk *jh7100_clk_from(struct clk_hw *hw)
> -{
> -	return container_of(hw, struct jh7100_clk, hw);
> -}
> -
> -static struct jh7100_clk_priv *jh7100_priv_from(struct jh7100_clk *clk)
> -{
> -	return container_of(clk, struct jh7100_clk_priv, reg[clk->idx]);
> -}
> -
> -static u32 jh7100_clk_reg_get(struct jh7100_clk *clk)
> -{
> -	struct jh7100_clk_priv *priv =3D jh7100_priv_from(clk);
> -	void __iomem *reg =3D priv->base + 4 * clk->idx;
> -
> -	return readl_relaxed(reg);
> -}
> -
> -static void jh7100_clk_reg_rmw(struct jh7100_clk *clk, u32 mask, u32 val=
ue)
> -{
> -	struct jh7100_clk_priv *priv =3D jh7100_priv_from(clk);
> -	void __iomem *reg =3D priv->base + 4 * clk->idx;
> -	unsigned long flags;
> -
> -	spin_lock_irqsave(&priv->rmw_lock, flags);
> -	value |=3D readl_relaxed(reg) & ~mask;
> -	writel_relaxed(value, reg);
> -	spin_unlock_irqrestore(&priv->rmw_lock, flags);
> -}
> -
> -static int jh7100_clk_enable(struct clk_hw *hw)
> -{
> -	struct jh7100_clk *clk =3D jh7100_clk_from(hw);
> -
> -	jh7100_clk_reg_rmw(clk, JH7100_CLK_ENABLE, JH7100_CLK_ENABLE);
> -	return 0;
> -}
> -
> -static void jh7100_clk_disable(struct clk_hw *hw)
> -{
> -	struct jh7100_clk *clk =3D jh7100_clk_from(hw);
> -
> -	jh7100_clk_reg_rmw(clk, JH7100_CLK_ENABLE, 0);
> -}
> -
> -static int jh7100_clk_is_enabled(struct clk_hw *hw)
> -{
> -	struct jh7100_clk *clk =3D jh7100_clk_from(hw);
> -
> -	return !!(jh7100_clk_reg_get(clk) & JH7100_CLK_ENABLE);
> -}
> -
> -static unsigned long jh7100_clk_recalc_rate(struct clk_hw *hw,
> -					    unsigned long parent_rate)
> -{
> -	struct jh7100_clk *clk =3D jh7100_clk_from(hw);
> -	u32 div =3D jh7100_clk_reg_get(clk) & JH7100_CLK_DIV_MASK;
> -
> -	return div ? parent_rate / div : 0;
> -}
> -
> -static int jh7100_clk_determine_rate(struct clk_hw *hw,
> -				     struct clk_rate_request *req)
> -{
> -	struct jh7100_clk *clk =3D jh7100_clk_from(hw);
> -	unsigned long parent =3D req->best_parent_rate;
> -	unsigned long rate =3D clamp(req->rate, req->min_rate, req->max_rate);
> -	unsigned long div =3D min_t(unsigned long, DIV_ROUND_UP(parent, rate), =
clk->max_div);
> -	unsigned long result =3D parent / div;
> -
> -	/*
> -	 * we want the result clamped by min_rate and max_rate if possible:
> -	 * case 1: div hits the max divider value, which means it's less than
> -	 * parent / rate, so the result is greater than rate and min_rate in
> -	 * particular. we can't do anything about result > max_rate because the
> -	 * divider doesn't go any further.
> -	 * case 2: div =3D DIV_ROUND_UP(parent, rate) which means the result is
> -	 * always lower or equal to rate and max_rate. however the result may
> -	 * turn out lower than min_rate, but then the next higher rate is fine:
> -	 *   div - 1 =3D ceil(parent / rate) - 1 < parent / rate
> -	 * and thus
> -	 *   min_rate <=3D rate < parent / (div - 1)
> -	 */
> -	if (result < req->min_rate && div > 1)
> -		result =3D parent / (div - 1);
> -
> -	req->rate =3D result;
> -	return 0;
> -}
> -
> -static int jh7100_clk_set_rate(struct clk_hw *hw,
> -			       unsigned long rate,
> -			       unsigned long parent_rate)
> -{
> -	struct jh7100_clk *clk =3D jh7100_clk_from(hw);
> -	unsigned long div =3D clamp(DIV_ROUND_CLOSEST(parent_rate, rate),
> -				  1UL, (unsigned long)clk->max_div);
> -
> -	jh7100_clk_reg_rmw(clk, JH7100_CLK_DIV_MASK, div);
> -	return 0;
> -}
> -
> -static unsigned long jh7100_clk_frac_recalc_rate(struct clk_hw *hw,
> -						 unsigned long parent_rate)
> -{
> -	struct jh7100_clk *clk =3D jh7100_clk_from(hw);
> -	u32 reg =3D jh7100_clk_reg_get(clk);
> -	unsigned long div100 =3D 100 * (reg & JH7100_CLK_INT_MASK) +
> -			       ((reg & JH7100_CLK_FRAC_MASK) >> JH7100_CLK_FRAC_SHIFT);
> -
> -	return (div100 >=3D JH7100_CLK_FRAC_MIN) ? 100 * parent_rate / div100 :=
 0;
> -}
> -
> -static int jh7100_clk_frac_determine_rate(struct clk_hw *hw,
> -					  struct clk_rate_request *req)
> -{
> -	unsigned long parent100 =3D 100 * req->best_parent_rate;
> -	unsigned long rate =3D clamp(req->rate, req->min_rate, req->max_rate);
> -	unsigned long div100 =3D clamp(DIV_ROUND_CLOSEST(parent100, rate),
> -				     JH7100_CLK_FRAC_MIN, JH7100_CLK_FRAC_MAX);
> -	unsigned long result =3D parent100 / div100;
> -
> -	/* clamp the result as in jh7100_clk_determine_rate() above */
> -	if (result > req->max_rate && div100 < JH7100_CLK_FRAC_MAX)
> -		result =3D parent100 / (div100 + 1);
> -	if (result < req->min_rate && div100 > JH7100_CLK_FRAC_MIN)
> -		result =3D parent100 / (div100 - 1);
> -
> -	req->rate =3D result;
> -	return 0;
> -}
> -
> -static int jh7100_clk_frac_set_rate(struct clk_hw *hw,
> -				    unsigned long rate,
> -				    unsigned long parent_rate)
> -{
> -	struct jh7100_clk *clk =3D jh7100_clk_from(hw);
> -	unsigned long div100 =3D clamp(DIV_ROUND_CLOSEST(100 * parent_rate, rat=
e),
> -				     JH7100_CLK_FRAC_MIN, JH7100_CLK_FRAC_MAX);
> -	u32 value =3D ((div100 % 100) << JH7100_CLK_FRAC_SHIFT) | (div100 / 100=
);
> -
> -	jh7100_clk_reg_rmw(clk, JH7100_CLK_DIV_MASK, value);
> -	return 0;
> -}
> -
> -static u8 jh7100_clk_get_parent(struct clk_hw *hw)
> -{
> -	struct jh7100_clk *clk =3D jh7100_clk_from(hw);
> -	u32 value =3D jh7100_clk_reg_get(clk);
> -
> -	return (value & JH7100_CLK_MUX_MASK) >> JH7100_CLK_MUX_SHIFT;
> -}
> -
> -static int jh7100_clk_set_parent(struct clk_hw *hw, u8 index)
> -{
> -	struct jh7100_clk *clk =3D jh7100_clk_from(hw);
> -	u32 value =3D (u32)index << JH7100_CLK_MUX_SHIFT;
> -
> -	jh7100_clk_reg_rmw(clk, JH7100_CLK_MUX_MASK, value);
> -	return 0;
> -}
> -
> -static int jh7100_clk_mux_determine_rate(struct clk_hw *hw,
> -					 struct clk_rate_request *req)
> -{
> -	return clk_mux_determine_rate_flags(hw, req, 0);
> -}
> -
> -static int jh7100_clk_get_phase(struct clk_hw *hw)
> -{
> -	struct jh7100_clk *clk =3D jh7100_clk_from(hw);
> -	u32 value =3D jh7100_clk_reg_get(clk);
> -
> -	return (value & JH7100_CLK_INVERT) ? 180 : 0;
> -}
> -
> -static int jh7100_clk_set_phase(struct clk_hw *hw, int degrees)
> -{
> -	struct jh7100_clk *clk =3D jh7100_clk_from(hw);
> -	u32 value;
> -
> -	if (degrees =3D=3D 0)
> -		value =3D 0;
> -	else if (degrees =3D=3D 180)
> -		value =3D JH7100_CLK_INVERT;
> -	else
> -		return -EINVAL;
> -
> -	jh7100_clk_reg_rmw(clk, JH7100_CLK_INVERT, value);
> -	return 0;
> -}
> -
> -#ifdef CONFIG_DEBUG_FS
> -static void jh7100_clk_debug_init(struct clk_hw *hw, struct dentry *dent=
ry)
> -{
> -	static const struct debugfs_reg32 jh7100_clk_reg =3D {
> -		.name =3D "CTRL",
> -		.offset =3D 0,
> -	};
> -	struct jh7100_clk *clk =3D jh7100_clk_from(hw);
> -	struct jh7100_clk_priv *priv =3D jh7100_priv_from(clk);
> -	struct debugfs_regset32 *regset;
> -
> -	regset =3D devm_kzalloc(priv->dev, sizeof(*regset), GFP_KERNEL);
> -	if (!regset)
> -		return;
> -
> -	regset->regs =3D &jh7100_clk_reg;
> -	regset->nregs =3D 1;
> -	regset->base =3D priv->base + 4 * clk->idx;
> -
> -	debugfs_create_regset32("registers", 0400, dentry, regset);
> -}
> -#else
> -#define jh7100_clk_debug_init NULL
> -#endif
> -
> -static const struct clk_ops jh7100_clk_gate_ops =3D {
> -	.enable =3D jh7100_clk_enable,
> -	.disable =3D jh7100_clk_disable,
> -	.is_enabled =3D jh7100_clk_is_enabled,
> -	.debug_init =3D jh7100_clk_debug_init,
> -};
> -
> -static const struct clk_ops jh7100_clk_div_ops =3D {
> -	.recalc_rate =3D jh7100_clk_recalc_rate,
> -	.determine_rate =3D jh7100_clk_determine_rate,
> -	.set_rate =3D jh7100_clk_set_rate,
> -	.debug_init =3D jh7100_clk_debug_init,
> -};
> -
> -static const struct clk_ops jh7100_clk_fdiv_ops =3D {
> -	.recalc_rate =3D jh7100_clk_frac_recalc_rate,
> -	.determine_rate =3D jh7100_clk_frac_determine_rate,
> -	.set_rate =3D jh7100_clk_frac_set_rate,
> -	.debug_init =3D jh7100_clk_debug_init,
> -};
> -
> -static const struct clk_ops jh7100_clk_gdiv_ops =3D {
> -	.enable =3D jh7100_clk_enable,
> -	.disable =3D jh7100_clk_disable,
> -	.is_enabled =3D jh7100_clk_is_enabled,
> -	.recalc_rate =3D jh7100_clk_recalc_rate,
> -	.determine_rate =3D jh7100_clk_determine_rate,
> -	.set_rate =3D jh7100_clk_set_rate,
> -	.debug_init =3D jh7100_clk_debug_init,
> -};
> -
> -static const struct clk_ops jh7100_clk_mux_ops =3D {
> -	.determine_rate =3D jh7100_clk_mux_determine_rate,
> -	.set_parent =3D jh7100_clk_set_parent,
> -	.get_parent =3D jh7100_clk_get_parent,
> -	.debug_init =3D jh7100_clk_debug_init,
> -};
> -
> -static const struct clk_ops jh7100_clk_gmux_ops =3D {
> -	.enable =3D jh7100_clk_enable,
> -	.disable =3D jh7100_clk_disable,
> -	.is_enabled =3D jh7100_clk_is_enabled,
> -	.determine_rate =3D jh7100_clk_mux_determine_rate,
> -	.set_parent =3D jh7100_clk_set_parent,
> -	.get_parent =3D jh7100_clk_get_parent,
> -	.debug_init =3D jh7100_clk_debug_init,
> -};
> -
> -static const struct clk_ops jh7100_clk_mdiv_ops =3D {
> -	.recalc_rate =3D jh7100_clk_recalc_rate,
> -	.determine_rate =3D jh7100_clk_determine_rate,
> -	.get_parent =3D jh7100_clk_get_parent,
> -	.set_parent =3D jh7100_clk_set_parent,
> -	.set_rate =3D jh7100_clk_set_rate,
> -	.debug_init =3D jh7100_clk_debug_init,
> -};
> -
> -static const struct clk_ops jh7100_clk_gmd_ops =3D {
> -	.enable =3D jh7100_clk_enable,
> -	.disable =3D jh7100_clk_disable,
> -	.is_enabled =3D jh7100_clk_is_enabled,
> -	.recalc_rate =3D jh7100_clk_recalc_rate,
> -	.determine_rate =3D jh7100_clk_determine_rate,
> -	.get_parent =3D jh7100_clk_get_parent,
> -	.set_parent =3D jh7100_clk_set_parent,
> -	.set_rate =3D jh7100_clk_set_rate,
> -	.debug_init =3D jh7100_clk_debug_init,
> -};
> -
> -static const struct clk_ops jh7100_clk_inv_ops =3D {
> -	.get_phase =3D jh7100_clk_get_phase,
> -	.set_phase =3D jh7100_clk_set_phase,
> -	.debug_init =3D jh7100_clk_debug_init,
> -};
> -
> -const struct clk_ops *starfive_jh7100_clk_ops(u32 max)
> -{
> -	if (max & JH7100_CLK_DIV_MASK) {
> -		if (max & JH7100_CLK_MUX_MASK) {
> -			if (max & JH7100_CLK_ENABLE)
> -				return &jh7100_clk_gmd_ops;
> -			return &jh7100_clk_mdiv_ops;
> -		}
> -		if (max & JH7100_CLK_ENABLE)
> -			return &jh7100_clk_gdiv_ops;
> -		if (max =3D=3D JH7100_CLK_FRAC_MAX)
> -			return &jh7100_clk_fdiv_ops;
> -		return &jh7100_clk_div_ops;
> -	}
> -
> -	if (max & JH7100_CLK_MUX_MASK) {
> -		if (max & JH7100_CLK_ENABLE)
> -			return &jh7100_clk_gmux_ops;
> -		return &jh7100_clk_mux_ops;
> -	}
> -
> -	if (max & JH7100_CLK_ENABLE)
> -		return &jh7100_clk_gate_ops;
> -
> -	return &jh7100_clk_inv_ops;
> -}
> -EXPORT_SYMBOL_GPL(starfive_jh7100_clk_ops);
> -
>  static struct clk_hw *jh7100_clk_get(struct of_phandle_args *clkspec, vo=
id *data)
>  {
>  	struct jh7100_clk_priv *priv =3D data;
> diff --git a/drivers/clk/starfive/clk-starfive-jh7100.h b/drivers/clk/sta=
rfive/clk-starfive-jh7100.h
> index f116be5740a5..a8ba6e25b5ce 100644
> --- a/drivers/clk/starfive/clk-starfive-jh7100.h
> +++ b/drivers/clk/starfive/clk-starfive-jh7100.h
> @@ -4,6 +4,8 @@
> =20
>  #include <linux/bits.h>
>  #include <linux/clk-provider.h>
> +#include <linux/device.h>
> +#include <linux/spinlock.h>
> =20
>  /* register fields */
>  #define JH7100_CLK_ENABLE	BIT(31)
> diff --git a/drivers/clk/starfive/clk-starfive-jh71x0.c b/drivers/clk/sta=
rfive/clk-starfive-jh71x0.c
> new file mode 100644
> index 000000000000..6c07b61b4a32
> --- /dev/null
> +++ b/drivers/clk/starfive/clk-starfive-jh71x0.c
> @@ -0,0 +1,333 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * StarFive JH7100 Clock Generator Driver
> + *
> + * Copyright (C) 2021-2022 Emil Renner Berthing <kernel@esmil.dk>
> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/debugfs.h>
> +#include <linux/device.h>
> +#include <linux/io.h>
> +
> +#include "clk-starfive-jh7100.h"
> +
> +static struct jh7100_clk *jh7100_clk_from(struct clk_hw *hw)
> +{
> +	return container_of(hw, struct jh7100_clk, hw);
> +}
> +
> +static struct jh7100_clk_priv *jh7100_priv_from(struct jh7100_clk *clk)
> +{
> +	return container_of(clk, struct jh7100_clk_priv, reg[clk->idx]);
> +}
> +
> +static u32 jh7100_clk_reg_get(struct jh7100_clk *clk)
> +{
> +	struct jh7100_clk_priv *priv =3D jh7100_priv_from(clk);
> +	void __iomem *reg =3D priv->base + 4 * clk->idx;
> +
> +	return readl_relaxed(reg);
> +}
> +
> +static void jh7100_clk_reg_rmw(struct jh7100_clk *clk, u32 mask, u32 val=
ue)
> +{
> +	struct jh7100_clk_priv *priv =3D jh7100_priv_from(clk);
> +	void __iomem *reg =3D priv->base + 4 * clk->idx;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&priv->rmw_lock, flags);
> +	value |=3D readl_relaxed(reg) & ~mask;
> +	writel_relaxed(value, reg);
> +	spin_unlock_irqrestore(&priv->rmw_lock, flags);
> +}
> +
> +static int jh7100_clk_enable(struct clk_hw *hw)
> +{
> +	struct jh7100_clk *clk =3D jh7100_clk_from(hw);
> +
> +	jh7100_clk_reg_rmw(clk, JH7100_CLK_ENABLE, JH7100_CLK_ENABLE);
> +	return 0;
> +}
> +
> +static void jh7100_clk_disable(struct clk_hw *hw)
> +{
> +	struct jh7100_clk *clk =3D jh7100_clk_from(hw);
> +
> +	jh7100_clk_reg_rmw(clk, JH7100_CLK_ENABLE, 0);
> +}
> +
> +static int jh7100_clk_is_enabled(struct clk_hw *hw)
> +{
> +	struct jh7100_clk *clk =3D jh7100_clk_from(hw);
> +
> +	return !!(jh7100_clk_reg_get(clk) & JH7100_CLK_ENABLE);
> +}
> +
> +static unsigned long jh7100_clk_recalc_rate(struct clk_hw *hw,
> +					    unsigned long parent_rate)
> +{
> +	struct jh7100_clk *clk =3D jh7100_clk_from(hw);
> +	u32 div =3D jh7100_clk_reg_get(clk) & JH7100_CLK_DIV_MASK;
> +
> +	return div ? parent_rate / div : 0;
> +}
> +
> +static int jh7100_clk_determine_rate(struct clk_hw *hw,
> +				     struct clk_rate_request *req)
> +{
> +	struct jh7100_clk *clk =3D jh7100_clk_from(hw);
> +	unsigned long parent =3D req->best_parent_rate;
> +	unsigned long rate =3D clamp(req->rate, req->min_rate, req->max_rate);
> +	unsigned long div =3D min_t(unsigned long, DIV_ROUND_UP(parent, rate), =
clk->max_div);
> +	unsigned long result =3D parent / div;
> +
> +	/*
> +	 * we want the result clamped by min_rate and max_rate if possible:
> +	 * case 1: div hits the max divider value, which means it's less than
> +	 * parent / rate, so the result is greater than rate and min_rate in
> +	 * particular. we can't do anything about result > max_rate because the
> +	 * divider doesn't go any further.
> +	 * case 2: div =3D DIV_ROUND_UP(parent, rate) which means the result is
> +	 * always lower or equal to rate and max_rate. however the result may
> +	 * turn out lower than min_rate, but then the next higher rate is fine:
> +	 *   div - 1 =3D ceil(parent / rate) - 1 < parent / rate
> +	 * and thus
> +	 *   min_rate <=3D rate < parent / (div - 1)
> +	 */
> +	if (result < req->min_rate && div > 1)
> +		result =3D parent / (div - 1);
> +
> +	req->rate =3D result;
> +	return 0;
> +}
> +
> +static int jh7100_clk_set_rate(struct clk_hw *hw,
> +			       unsigned long rate,
> +			       unsigned long parent_rate)
> +{
> +	struct jh7100_clk *clk =3D jh7100_clk_from(hw);
> +	unsigned long div =3D clamp(DIV_ROUND_CLOSEST(parent_rate, rate),
> +				  1UL, (unsigned long)clk->max_div);
> +
> +	jh7100_clk_reg_rmw(clk, JH7100_CLK_DIV_MASK, div);
> +	return 0;
> +}
> +
> +static unsigned long jh7100_clk_frac_recalc_rate(struct clk_hw *hw,
> +						 unsigned long parent_rate)
> +{
> +	struct jh7100_clk *clk =3D jh7100_clk_from(hw);
> +	u32 reg =3D jh7100_clk_reg_get(clk);
> +	unsigned long div100 =3D 100 * (reg & JH7100_CLK_INT_MASK) +
> +			       ((reg & JH7100_CLK_FRAC_MASK) >> JH7100_CLK_FRAC_SHIFT);
> +
> +	return (div100 >=3D JH7100_CLK_FRAC_MIN) ? 100 * parent_rate / div100 :=
 0;
> +}
> +
> +static int jh7100_clk_frac_determine_rate(struct clk_hw *hw,
> +					  struct clk_rate_request *req)
> +{
> +	unsigned long parent100 =3D 100 * req->best_parent_rate;
> +	unsigned long rate =3D clamp(req->rate, req->min_rate, req->max_rate);
> +	unsigned long div100 =3D clamp(DIV_ROUND_CLOSEST(parent100, rate),
> +				     JH7100_CLK_FRAC_MIN, JH7100_CLK_FRAC_MAX);
> +	unsigned long result =3D parent100 / div100;
> +
> +	/* clamp the result as in jh7100_clk_determine_rate() above */
> +	if (result > req->max_rate && div100 < JH7100_CLK_FRAC_MAX)
> +		result =3D parent100 / (div100 + 1);
> +	if (result < req->min_rate && div100 > JH7100_CLK_FRAC_MIN)
> +		result =3D parent100 / (div100 - 1);
> +
> +	req->rate =3D result;
> +	return 0;
> +}
> +
> +static int jh7100_clk_frac_set_rate(struct clk_hw *hw,
> +				    unsigned long rate,
> +				    unsigned long parent_rate)
> +{
> +	struct jh7100_clk *clk =3D jh7100_clk_from(hw);
> +	unsigned long div100 =3D clamp(DIV_ROUND_CLOSEST(100 * parent_rate, rat=
e),
> +				     JH7100_CLK_FRAC_MIN, JH7100_CLK_FRAC_MAX);
> +	u32 value =3D ((div100 % 100) << JH7100_CLK_FRAC_SHIFT) | (div100 / 100=
);
> +
> +	jh7100_clk_reg_rmw(clk, JH7100_CLK_DIV_MASK, value);
> +	return 0;
> +}
> +
> +static u8 jh7100_clk_get_parent(struct clk_hw *hw)
> +{
> +	struct jh7100_clk *clk =3D jh7100_clk_from(hw);
> +	u32 value =3D jh7100_clk_reg_get(clk);
> +
> +	return (value & JH7100_CLK_MUX_MASK) >> JH7100_CLK_MUX_SHIFT;
> +}
> +
> +static int jh7100_clk_set_parent(struct clk_hw *hw, u8 index)
> +{
> +	struct jh7100_clk *clk =3D jh7100_clk_from(hw);
> +	u32 value =3D (u32)index << JH7100_CLK_MUX_SHIFT;
> +
> +	jh7100_clk_reg_rmw(clk, JH7100_CLK_MUX_MASK, value);
> +	return 0;
> +}
> +
> +static int jh7100_clk_mux_determine_rate(struct clk_hw *hw,
> +					 struct clk_rate_request *req)
> +{
> +	return clk_mux_determine_rate_flags(hw, req, 0);
> +}
> +
> +static int jh7100_clk_get_phase(struct clk_hw *hw)
> +{
> +	struct jh7100_clk *clk =3D jh7100_clk_from(hw);
> +	u32 value =3D jh7100_clk_reg_get(clk);
> +
> +	return (value & JH7100_CLK_INVERT) ? 180 : 0;
> +}
> +
> +static int jh7100_clk_set_phase(struct clk_hw *hw, int degrees)
> +{
> +	struct jh7100_clk *clk =3D jh7100_clk_from(hw);
> +	u32 value;
> +
> +	if (degrees =3D=3D 0)
> +		value =3D 0;
> +	else if (degrees =3D=3D 180)
> +		value =3D JH7100_CLK_INVERT;
> +	else
> +		return -EINVAL;
> +
> +	jh7100_clk_reg_rmw(clk, JH7100_CLK_INVERT, value);
> +	return 0;
> +}
> +
> +#ifdef CONFIG_DEBUG_FS
> +static void jh7100_clk_debug_init(struct clk_hw *hw, struct dentry *dent=
ry)
> +{
> +	static const struct debugfs_reg32 jh7100_clk_reg =3D {
> +		.name =3D "CTRL",
> +		.offset =3D 0,
> +	};
> +	struct jh7100_clk *clk =3D jh7100_clk_from(hw);
> +	struct jh7100_clk_priv *priv =3D jh7100_priv_from(clk);
> +	struct debugfs_regset32 *regset;
> +
> +	regset =3D devm_kzalloc(priv->dev, sizeof(*regset), GFP_KERNEL);
> +	if (!regset)
> +		return;
> +
> +	regset->regs =3D &jh7100_clk_reg;
> +	regset->nregs =3D 1;
> +	regset->base =3D priv->base + 4 * clk->idx;
> +
> +	debugfs_create_regset32("registers", 0400, dentry, regset);
> +}
> +#else
> +#define jh7100_clk_debug_init NULL
> +#endif
> +
> +static const struct clk_ops jh7100_clk_gate_ops =3D {
> +	.enable =3D jh7100_clk_enable,
> +	.disable =3D jh7100_clk_disable,
> +	.is_enabled =3D jh7100_clk_is_enabled,
> +	.debug_init =3D jh7100_clk_debug_init,
> +};
> +
> +static const struct clk_ops jh7100_clk_div_ops =3D {
> +	.recalc_rate =3D jh7100_clk_recalc_rate,
> +	.determine_rate =3D jh7100_clk_determine_rate,
> +	.set_rate =3D jh7100_clk_set_rate,
> +	.debug_init =3D jh7100_clk_debug_init,
> +};
> +
> +static const struct clk_ops jh7100_clk_fdiv_ops =3D {
> +	.recalc_rate =3D jh7100_clk_frac_recalc_rate,
> +	.determine_rate =3D jh7100_clk_frac_determine_rate,
> +	.set_rate =3D jh7100_clk_frac_set_rate,
> +	.debug_init =3D jh7100_clk_debug_init,
> +};
> +
> +static const struct clk_ops jh7100_clk_gdiv_ops =3D {
> +	.enable =3D jh7100_clk_enable,
> +	.disable =3D jh7100_clk_disable,
> +	.is_enabled =3D jh7100_clk_is_enabled,
> +	.recalc_rate =3D jh7100_clk_recalc_rate,
> +	.determine_rate =3D jh7100_clk_determine_rate,
> +	.set_rate =3D jh7100_clk_set_rate,
> +	.debug_init =3D jh7100_clk_debug_init,
> +};
> +
> +static const struct clk_ops jh7100_clk_mux_ops =3D {
> +	.determine_rate =3D jh7100_clk_mux_determine_rate,
> +	.set_parent =3D jh7100_clk_set_parent,
> +	.get_parent =3D jh7100_clk_get_parent,
> +	.debug_init =3D jh7100_clk_debug_init,
> +};
> +
> +static const struct clk_ops jh7100_clk_gmux_ops =3D {
> +	.enable =3D jh7100_clk_enable,
> +	.disable =3D jh7100_clk_disable,
> +	.is_enabled =3D jh7100_clk_is_enabled,
> +	.determine_rate =3D jh7100_clk_mux_determine_rate,
> +	.set_parent =3D jh7100_clk_set_parent,
> +	.get_parent =3D jh7100_clk_get_parent,
> +	.debug_init =3D jh7100_clk_debug_init,
> +};
> +
> +static const struct clk_ops jh7100_clk_mdiv_ops =3D {
> +	.recalc_rate =3D jh7100_clk_recalc_rate,
> +	.determine_rate =3D jh7100_clk_determine_rate,
> +	.get_parent =3D jh7100_clk_get_parent,
> +	.set_parent =3D jh7100_clk_set_parent,
> +	.set_rate =3D jh7100_clk_set_rate,
> +	.debug_init =3D jh7100_clk_debug_init,
> +};
> +
> +static const struct clk_ops jh7100_clk_gmd_ops =3D {
> +	.enable =3D jh7100_clk_enable,
> +	.disable =3D jh7100_clk_disable,
> +	.is_enabled =3D jh7100_clk_is_enabled,
> +	.recalc_rate =3D jh7100_clk_recalc_rate,
> +	.determine_rate =3D jh7100_clk_determine_rate,
> +	.get_parent =3D jh7100_clk_get_parent,
> +	.set_parent =3D jh7100_clk_set_parent,
> +	.set_rate =3D jh7100_clk_set_rate,
> +	.debug_init =3D jh7100_clk_debug_init,
> +};
> +
> +static const struct clk_ops jh7100_clk_inv_ops =3D {
> +	.get_phase =3D jh7100_clk_get_phase,
> +	.set_phase =3D jh7100_clk_set_phase,
> +	.debug_init =3D jh7100_clk_debug_init,
> +};
> +
> +const struct clk_ops *starfive_jh7100_clk_ops(u32 max)
> +{
> +	if (max & JH7100_CLK_DIV_MASK) {
> +		if (max & JH7100_CLK_MUX_MASK) {
> +			if (max & JH7100_CLK_ENABLE)
> +				return &jh7100_clk_gmd_ops;
> +			return &jh7100_clk_mdiv_ops;
> +		}
> +		if (max & JH7100_CLK_ENABLE)
> +			return &jh7100_clk_gdiv_ops;
> +		if (max =3D=3D JH7100_CLK_FRAC_MAX)
> +			return &jh7100_clk_fdiv_ops;
> +		return &jh7100_clk_div_ops;
> +	}
> +
> +	if (max & JH7100_CLK_MUX_MASK) {
> +		if (max & JH7100_CLK_ENABLE)
> +			return &jh7100_clk_gmux_ops;
> +		return &jh7100_clk_mux_ops;
> +	}
> +
> +	if (max & JH7100_CLK_ENABLE)
> +		return &jh7100_clk_gate_ops;
> +
> +	return &jh7100_clk_inv_ops;
> +}
> +EXPORT_SYMBOL_GPL(starfive_jh7100_clk_ops);
> --=20
> 2.38.1
>=20
>=20

--q1JFCHtmxY2Y5pMV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY6IvEgAKCRB4tDGHoIJi
0qHpAQDSz/9mhBfuZeblm6OsJoXqpggOuHfUD4w8OI473jYiLQD+I6rNAwB8Aa3Z
RXdVLKYjCGLLrk+dwozWa4ybEsJ+uwk=
=gubu
-----END PGP SIGNATURE-----

--q1JFCHtmxY2Y5pMV--
