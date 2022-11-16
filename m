Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF15A62B586
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 09:50:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbiKPIt6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 03:49:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiKPIty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 03:49:54 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 937D5A1B9
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 00:49:52 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id c1so28424958lfi.7
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 00:49:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4G8MNam0RDkJZp1SsqYh94GW5nadnz0BpIGQaq1Mrn8=;
        b=HAThLiW9nWNXpcOMYPQFEvFUAiIlwSuLx9AkE4FOtWhwZiHI9gBXgl94xWKqqDczGM
         ag5Uh/8RlIx084AoTnh5uSzWl8upx8fh36fnQyNXUQK8QgLwI1qMjbloRgKSLhg79cgl
         uo6X04SfHPsbkptSWb4HdOmUpq0/j3xkj106vh0/hU4vSCXYo0GzN+Kyn6ZGxzs1yxh/
         BPCmolUoixYRkOS7UdZZEnPSqOmRFIrFDgHchdDQeUQKXdp2neeKZRIvlc2CUAqxbxsN
         JhU05vhBtdKY8x2knd/LHFqmPvkZ+8WqR1kBXXJwlEi+SJLKRHYkZY3KwaNsAjJUKZTn
         cDBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4G8MNam0RDkJZp1SsqYh94GW5nadnz0BpIGQaq1Mrn8=;
        b=M1GL+gkFH1xE48OabCfhLfck2xFdZhkwvSBDu214jnesVdg6Fx+N5muIMwTvhQEP5/
         h5B7o6aTZ1TJysXqiVjXiCQrDXWBS1NvR352l6mVbYQcsz3Lm3GuOKiLqoXt1uE+gY6r
         MwXDez/5lPyKY6m63Ujh5z9XYY2VQJom6+TTb+0YuL4PhBaVYqg7X32QUVwdrF4nJwqB
         hjSij7thLv1+brQNIfSexz5/Z9SKnn+cCiSbpJvGjwyLwvnbRKsjDLWhhgpH7nuuw3o7
         XNFsgGp35IEI/hT6cQBcSq7fOYlW2Q7KO9gOS41AliVCCM6rqE0jANJ5xADNvpzAt3hk
         qgcA==
X-Gm-Message-State: ANoB5pnjqYrOYJUXc/CPaaiaoeevoGf55PjcKBXRF2AqONvWr7g53ahc
        QOU/IMBgqIvXFll1eBX9ZU/H+g==
X-Google-Smtp-Source: AA0mqf594U5cRRdUwoSeVXD12jP7TMdN+VgCogHjXvwOfnzwQfodHBqSnjcWagquZXN1NVG+Cg68kw==
X-Received: by 2002:a05:6512:1055:b0:4b4:8d47:7057 with SMTP id c21-20020a056512105500b004b48d477057mr7662381lfb.376.1668588590862;
        Wed, 16 Nov 2022 00:49:50 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id p11-20020a2ea4cb000000b002770473d813sm2813392ljm.140.2022.11.16.00.49.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Nov 2022 00:49:50 -0800 (PST)
Message-ID: <faa3052e-0948-d43d-5359-36885b07ce10@linaro.org>
Date:   Wed, 16 Nov 2022 09:49:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v3 2/2] clk: Add support for Renesas ProXO oscillator
Content-Language: en-US
To:     Alex Helms <alexander.helms.jy@renesas.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        sboyd@kernel.org, mturquette@baylibre.com, geert+renesas@glider.be
References: <20221115233749.10161-1-alexander.helms.jy@renesas.com>
 <20221115233749.10161-3-alexander.helms.jy@renesas.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221115233749.10161-3-alexander.helms.jy@renesas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/11/2022 00:37, Alex Helms wrote:
> ProXO is a programmable ultra-low phase noise quartz-based
> oscillator with a single output. This driver supports changing
> the frequency of the ProXP XP variant.
> 
> Signed-off-by: Alex Helms <alexander.helms.jy@renesas.com>
> ---
>  MAINTAINERS             |   1 +
>  drivers/clk/Kconfig     |   7 +
>  drivers/clk/Makefile    |   1 +
>  drivers/clk/clk-proxo.c | 410 ++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 419 insertions(+)
>  create mode 100644 drivers/clk/clk-proxo.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d52a8a5d2..c7f5c0655 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -16084,6 +16084,7 @@ RENESAS PROXO CLOCK DRIVER
>  M:	Alex Helms <alexander.helms.jy@renesas.com>
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/clock/renesas,proxo.yaml
> +F:	drivers/clk/clk-proxo.c
>  
>  RESET CONTROLLER FRAMEWORK
>  M:	Philipp Zabel <p.zabel@pengutronix.de>
> diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
> index 8f905df60..31f684d69 100644
> --- a/drivers/clk/Kconfig
> +++ b/drivers/clk/Kconfig
> @@ -396,6 +396,13 @@ config COMMON_CLK_K210
>  	help
>  	  Support for the Canaan Kendryte K210 RISC-V SoC clocks.
>  
> +config COMMON_CLK_PROXO
> +	bool "Clock driver for Renesas ProXO"
> +	depends on I2C && OF
> +	select REGMAP_I2C
> +	help
> +	  Support for the Renesas ProXO oscillator clock.
> +
>  source "drivers/clk/actions/Kconfig"
>  source "drivers/clk/analogbits/Kconfig"
>  source "drivers/clk/baikal-t1/Kconfig"
> diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
> index 99941b4a3..be6e28cc4 100644
> --- a/drivers/clk/Makefile
> +++ b/drivers/clk/Makefile
> @@ -52,6 +52,7 @@ obj-$(CONFIG_ARCH_NSPIRE)		+= clk-nspire.o
>  obj-$(CONFIG_COMMON_CLK_OXNAS)		+= clk-oxnas.o
>  obj-$(CONFIG_COMMON_CLK_PALMAS)		+= clk-palmas.o
>  obj-$(CONFIG_CLK_LS1028A_PLLDIG)	+= clk-plldig.o
> +obj-$(CONFIG_COMMON_CLK_PROXO)		+= clk-proxo.o
>  obj-$(CONFIG_COMMON_CLK_PWM)		+= clk-pwm.o
>  obj-$(CONFIG_CLK_QORIQ)			+= clk-qoriq.o
>  obj-$(CONFIG_COMMON_CLK_RK808)		+= clk-rk808.o
> diff --git a/drivers/clk/clk-proxo.c b/drivers/clk/clk-proxo.c
> new file mode 100644
> index 000000000..7d4268687
> --- /dev/null
> +++ b/drivers/clk/clk-proxo.c
> @@ -0,0 +1,410 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Common clock framework driver for the ProXO family of quartz-based oscillators.
> + *
> + * Copyright (c) 2022 Renesas Electronics Corporation
> + */
> +
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
> +#include <linux/bitfield.h>
> +#include <linux/clk.h>
> +#include <linux/clk-provider.h>
> +#include <linux/i2c.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_platform.h>
> +#include <linux/regmap.h>
> +#include <linux/swab.h>
> +
> +/* Most ProXO products have a 50MHz xtal, can be overridden in device tree */
> +#define PROXO_DEFAULT_XTAL	50000000
> +
> +/* VCO range is 6.86 GHz to 8.65 GHz */
> +#define PROXO_FVCO_MIN		6860000000ULL
> +#define PROXO_FVCO_MAX		8650000000ULL
> +
> +/* Output range is 15MHz to 2.1GHz */
> +#define PROXO_FOUT_MIN		15000000UL
> +#define PROXO_FOUT_MAX		2100000000UL
> +
> +#define PROXO_FRAC_BITS		24
> +#define PROXO_FRAC_DIVISOR	BIT(PROXO_FRAC_BITS)
> +
> +/* Disable the doubler if the crystal is > 80MHz */
> +#define PROXO_FDBL_MAX		80000000U
> +
> +#define PROXO_OUTDIV_MIN	4
> +#define PROXO_OUTDIV_MAX	511
> +#define PROXO_FB_MIN		41
> +
> +#define PROXO_REG_FREQ0		0x10
> +#define PROXO_REG_XO		0x51
> +#define PROXO_REG_TRIG		0x62
> +
> +#define OUTDIV_8_MASK		0x80
> +#define FBDIV_INT_8_7_MASK	0x30
> +#define FBDIV_INT_6_0_MASK	0x7f
> +#define DOUBLE_DIS_MASK		0x80
> +#define CP_MASK			0x0e
> +#define PLL_MODE_MASK		0x01
> +
> +enum proxo_model {
> +	PROXO_XP,
> +};
> +
> +enum proxo_pll_mode {
> +	PLL_MODE_FRAC,
> +	PLL_MODE_INT,
> +};
> +
> +struct clk_proxo {
> +	struct clk_hw hw;
> +	struct regmap *regmap;
> +	struct i2c_client *i2c_client;
> +	enum proxo_model model;
> +	u32 fxtal;
> +	u64 fvco;
> +	u32 fout;
> +	u8 double_dis;
> +	u16 fb_int;
> +	u32 fb_frac;
> +	u16 out_div;
> +};
> +
> +#define to_clk_proxo(_hw)	container_of(_hw, struct clk_proxo, hw)
> +
> +static u8 proxo_get_cp_value(u64 fvco)
> +{
> +	if (fvco < 7000000000ULL)
> +		return 5;
> +	else if (fvco >= 7000000000ULL && fvco < 7400000000ULL)
> +		return 4;
> +	else if (fvco >= 7400000000ULL && fvco < 7800000000ULL)
> +		return 3;
> +	else
> +		return 2;
> +}
> +
> +static u64 proxo_calc_fvco(u32 fxtal, u8 double_dis, u16 fb_int, u32 fb_frac)
> +{
> +	u64 fref, fvco;
> +	u8 doubler;
> +
> +	doubler = double_dis ? 1 : 2;
> +	fref = (u64)fxtal * doubler;
> +	fvco = (fref * fb_int) + div_u64(fref * fb_frac, PROXO_FRAC_DIVISOR);
> +
> +	return fvco;
> +}
> +
> +static int proxo_get_divs(struct clk_proxo *proxo, u16 *out_div, u16 *fb_int, u32 *fb_frac,
> +			  u8 *double_dis)
> +{
> +	int ret;
> +	u8 reg[6];
> +	unsigned int xo;
> +
> +	ret = regmap_bulk_read(proxo->regmap, PROXO_REG_FREQ0, reg, ARRAY_SIZE(reg));
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_read(proxo->regmap, PROXO_REG_XO, &xo);
> +	if (ret)
> +		return ret;
> +
> +	*out_div = (u16_get_bits(reg[1], OUTDIV_8_MASK) << 8) + reg[0];
> +	*fb_int = (u16_get_bits(reg[2], FBDIV_INT_8_7_MASK) << 7) + (reg[1] & FBDIV_INT_6_0_MASK);
> +	*fb_frac = ((u32)reg[5] << 16) + ((u32)reg[4] << 8) + reg[3];
> +	*double_dis = !!(xo & DOUBLE_DIS_MASK);
> +
> +	if (*fb_frac > (PROXO_FRAC_DIVISOR >> 1))
> +		(*fb_int)--;
> +
> +	pr_debug("%s - out_div: %u, fb_int: %u, fb_frac: %u, doubler_dis: %u\n",
> +		 __func__, *out_div, *fb_int, *fb_frac, *double_dis);

Use dev_dbg.

> +
> +	return ret;
> +}
> +
> +static int proxo_get_defaults(struct clk_proxo *proxo)
> +{
> +	int ret;
> +
> +	ret = proxo_get_divs(proxo, &proxo->out_div, &proxo->fb_int, &proxo->fb_frac,
> +			     &proxo->double_dis);
> +	if (ret)
> +		return ret;
> +
> +	proxo->fvco = proxo_calc_fvco(proxo->fxtal, proxo->double_dis, proxo->fb_int,
> +				      proxo->fb_frac);
> +	proxo->fout = div_u64(proxo->fvco, proxo->out_div);
> +
> +	pr_debug("%s - out_div: %u, fb_int: %u, fb_frac: %u, doubler_dis: %u, fvco: %llu, fout: %u\n",
> +		 __func__, proxo->out_div, proxo->fb_int, proxo->fb_frac, proxo->double_dis,
> +		 proxo->fvco, proxo->fout);

Use dev_dbg.

> +
> +	return ret;
> +}
> +
> +static int proxo_calc_divs(unsigned long frequency, struct clk_proxo *proxo, u32 *fout,
> +			   u16 *out_div, u16 *fb_int, u32 *fb_frac, u8 *double_dis)
> +{
> +	int i;
> +	u8 doubler;
> +	u16 out_div_start;
> +	u32 fref;
> +	u64 fvco;
> +	bool found = false, allow_frac = false;
> +
> +	out_div_start = 1 + div64_u64(PROXO_FVCO_MIN, frequency);
> +	doubler = proxo->fxtal <= PROXO_FDBL_MAX ? 2 : 1;
> +	fref = proxo->fxtal * doubler;
> +	*fout = (u32)max(PROXO_FOUT_MIN, min(PROXO_FOUT_MAX, (unsigned long)*fout));
> +	*out_div = PROXO_OUTDIV_MIN;
> +	*fb_int = PROXO_FB_MIN;
> +	*fb_frac = 0;
> +	*double_dis = doubler == 1 ? 1 : 0;
> +
> +retry:
> +	for (i = out_div_start; i <= PROXO_OUTDIV_MAX; ++i) {
> +		*out_div = i;
> +		fvco = frequency * *out_div;
> +		if (fvco > PROXO_FVCO_MAX) {
> +			allow_frac = true;
> +			goto retry;
> +		}
> +		*fb_int = div_u64_rem(fvco, fref, fb_frac);
> +		if (*fb_frac == 0) {
> +			found = true;
> +			break;
> +		}
> +		if (allow_frac) {
> +			*fb_frac = 1 + (u32)div_u64((u64)*fb_frac << PROXO_FRAC_BITS, fref);
> +			found = true;
> +			break;
> +		}
> +	}
> +
> +	if (!found)
> +		return -EINVAL;
> +
> +	if (fvco < PROXO_FVCO_MIN || fvco > PROXO_FVCO_MAX)
> +		return -EINVAL;
> +
> +	fvco = ((u64)fref * *fb_int) + div_u64((u64)fref * *fb_frac, PROXO_FRAC_DIVISOR);
> +	*fout = div_u64(fvco, *out_div);
> +
> +	return 0;
> +}
> +
> +static int proxo_update_frequency(struct clk_proxo *proxo)
> +{
> +	enum proxo_pll_mode pll_mode;
> +	u8 cp_value;
> +	u16 fb_int;
> +	u8 reg[6];
> +
> +	cp_value = proxo_get_cp_value(proxo->fvco);
> +	pll_mode = proxo->fb_frac == 0 ? PLL_MODE_INT : PLL_MODE_FRAC;
> +	fb_int = proxo->fb_frac > (PROXO_FRAC_DIVISOR >> 1) ? proxo->fb_int + 1 : proxo->fb_int;
> +
> +	reg[0] = proxo->out_div & 0xff;
> +	reg[1] = ((proxo->out_div >> 1) & OUTDIV_8_MASK) + (fb_int & FBDIV_INT_6_0_MASK);
> +	reg[2] = (fb_int >> 3) & FBDIV_INT_8_7_MASK;
> +	reg[2] = u8_replace_bits(reg[2], cp_value, CP_MASK);
> +	reg[2] = u8_replace_bits(reg[2], pll_mode, PLL_MODE_MASK);
> +	reg[3] = proxo->fb_frac & 0xff;
> +	reg[4] = (proxo->fb_frac >> 8) & 0xff;
> +	reg[5] = (proxo->fb_frac >> 16) & 0xff;
> +
> +	return regmap_bulk_write(proxo->regmap, PROXO_REG_FREQ0, reg, ARRAY_SIZE(reg));
> +}
> +
> +static int proxo_set_frequency(struct clk_proxo *proxo, unsigned long frequency)
> +{
> +	int ret;
> +
> +	ret = proxo_calc_divs(frequency, proxo, &proxo->fout, &proxo->out_div, &proxo->fb_int,
> +			      &proxo->fb_frac, &proxo->double_dis);
> +	if (ret)
> +		return ret;
> +
> +	proxo->fvco = proxo_calc_fvco(proxo->fxtal, proxo->double_dis, proxo->fb_int,
> +				      proxo->fb_frac);
> +	proxo->fout = div_u64(proxo->fvco, proxo->out_div);
> +
> +	pr_debug("%s - out_div: %u, fb_int: %u, fb_frac: %u, doubler_dis: %u, fvco: %llu, fout: %u\n",
> +		 __func__, proxo->out_div, proxo->fb_int, proxo->fb_frac,
> +	proxo->double_dis, proxo->fvco, proxo->fout);

Wrong indent.

Use dev_dbg.

> +
> +	proxo_update_frequency(proxo);
> +
> +	/* trigger frequency change */
> +	regmap_write(proxo->regmap, PROXO_REG_TRIG, 0x00);
> +	regmap_write(proxo->regmap, PROXO_REG_TRIG, 0x01);
> +	regmap_write(proxo->regmap, PROXO_REG_TRIG, 0x00);
> +
> +	return ret;
> +}
> +
> +static unsigned long proxo_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
> +{
> +	struct clk_proxo *proxo = to_clk_proxo(hw);
> +	int ret;
> +	u8 double_dis;
> +	u16 out_div, fb_int;
> +	u32 fout, fb_frac;
> +	u64 fvco;
> +
> +	ret = proxo_get_divs(proxo, &out_div, &fb_int, &fb_frac, &double_dis);
> +	if (ret) {
> +		dev_err(&proxo->i2c_client->dev, "unable to recalc rate\n");
> +		return 0;
> +	}
> +
> +	fvco = proxo_calc_fvco(proxo->fxtal, double_dis, fb_int, fb_frac);
> +	fout = div_u64(fvco, out_div);
> +
> +	return fout;
> +}
> +
> +static long proxo_round_rate(struct clk_hw *hw, unsigned long rate, unsigned long *parent_rate)
> +{
> +	struct clk_proxo *proxo = to_clk_proxo(hw);
> +	int ret;
> +	u8 double_dis;
> +	u16 out_div, fb_int;
> +	u32 fout, fb_frac;
> +
> +	if (!rate)
> +		return 0;
> +
> +	ret = proxo_calc_divs(rate, proxo, &fout, &out_div, &fb_int, &fb_frac, &double_dis);
> +	if (ret) {
> +		dev_err(&proxo->i2c_client->dev, "unable to round rate\n");
> +		return 0;
> +	}
> +
> +	return fout;
> +}
> +
> +static int proxo_set_rate(struct clk_hw *hw, unsigned long rate, unsigned long parent_rate)
> +{
> +	struct clk_proxo *proxo = to_clk_proxo(hw);
> +
> +	if (rate < PROXO_FOUT_MIN || rate > PROXO_FOUT_MAX) {
> +		dev_err(&proxo->i2c_client->dev, "requested frequency %lu Hz is out of range\n",
> +			rate);
> +		return -EINVAL;
> +	}
> +
> +	return proxo_set_frequency(proxo, rate);
> +}
> +
> +static const struct clk_ops proxo_clk_ops = {
> +	.recalc_rate = proxo_recalc_rate,
> +	.round_rate = proxo_round_rate,
> +	.set_rate = proxo_set_rate,
> +};
> +
> +static const struct i2c_device_id proxo_i2c_id[] = {
> +	{ "proxo-xp", PROXO_XP },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(i2c, proxo_i2c_id);
> +
> +static const struct regmap_config proxo_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +	.max_register = 0x63,
> +	.cache_type = REGCACHE_RBTREE,
> +	.use_single_write = true,
> +	.use_single_read = true,
> +};
> +
> +static int proxo_probe(struct i2c_client *client)
> +{
> +	struct clk_proxo *proxo;
> +	struct clk_init_data init;
> +	const struct i2c_device_id *id = i2c_match_id(proxo_i2c_id, client);
> +	int ret;
> +
> +	proxo = devm_kzalloc(&client->dev, sizeof(*proxo), GFP_KERNEL);
> +	if (!proxo)
> +		return -ENOMEM;
> +
> +	init.ops = &proxo_clk_ops;
> +	init.flags = 0;
> +	init.num_parents = 0;
> +	proxo->hw.init = &init;
> +	proxo->i2c_client = client;
> +	proxo->model = id->driver_data;
> +
> +	if (of_property_read_string(client->dev.of_node, "clock-output-names", &init.name))
> +		init.name = client->dev.of_node->name;
> +
> +	if (of_property_read_u32(client->dev.of_node, "renesas,crystal-frequency-hz", &proxo->fxtal))
> +		proxo->fxtal = PROXO_DEFAULT_XTAL;
> +
> +	proxo->regmap = devm_regmap_init_i2c(client, &proxo_regmap_config);
> +	if (IS_ERR(proxo->regmap))
> +		return PTR_ERR(proxo->regmap);
> +
> +	i2c_set_clientdata(client, proxo);
> +
> +	ret = proxo_get_defaults(proxo);
> +	if (ret) {
> +		dev_err(&client->dev, "getting defaults failed\n");

dev_err_probe

> +		return ret;
> +	}
> +
> +	ret = devm_clk_hw_register(&client->dev, &proxo->hw);
> +	if (ret) {
> +		dev_err(&client->dev, "clock registration failed\n");

dev_err_probe

> +		return ret;
> +	}
> +
> +	ret = of_clk_add_hw_provider(client->dev.of_node, of_clk_hw_simple_get, &proxo->hw);
> +	if (ret) {
> +		dev_err(&client->dev, "unable to add clk provider\n");

dev_err_probe

> +		return ret;
> +	}
> +
> +	ret = clk_set_rate_range(proxo->hw.clk, PROXO_FOUT_MIN, PROXO_FOUT_MAX);
> +	if (ret) {
> +		dev_err(&client->dev, "clk_set_rate_range failed\n");
> +		return ret;
> +	}
> +
> +	dev_info(&client->dev, "registered, current frequency %u Hz\n", proxo->fout);

No silly probe confirmations.


Best regards,
Krzysztof

