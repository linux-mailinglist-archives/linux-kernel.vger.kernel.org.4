Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F146F6EF329
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 13:14:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240522AbjDZLOG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 07:14:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbjDZLOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 07:14:04 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 047E14C03;
        Wed, 26 Apr 2023 04:14:01 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id 68BC35FD7A;
        Wed, 26 Apr 2023 14:13:59 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1682507639;
        bh=bxarISjH+5O5k8nzJPCF3kIvLpvulxZMsMBUu0VLO/o=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
        b=aQrtis8nr+yRZmbZYZv4Al+C06FH3uPPzPox8SaobUEBGVwuppbfk8jlb/pG5wCwB
         aG+vjg4DCKU1MnUjAH5aNQDL3wgb1QzDKSGkDLRf2olhwpFLqEeRUziDAVokC+aaPT
         OH4r3LBooLNcNtjr6hyntyY4IfZjtpkEDRFoxB7UzmtRIFDNRn7fIQPF4bKCvkVs0+
         Ebo/4Yu0tCQ0E7pTKMFdoGIrWnA9wqcOS/hCquJOoOTkDdaf3wOizt2S0JLqBOjZhw
         Fjor7/rgmWWd7h73NTBNrQtfzWHqJ0absT6/V94E6a+F2bHsqRDP1DIvhwJMi7goWj
         9IrmQoIg03cHA==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Wed, 26 Apr 2023 14:13:59 +0300 (MSK)
Date:   Wed, 26 Apr 2023 14:13:58 +0300
From:   Dmitry Rokosov <ddrokosov@sberdevices.ru>
To:     Yu Tu <yu.tu@amlogic.com>
CC:     <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        <kelvin.zhang@amlogic.com>, <qi.duan@amlogic.com>
Subject: Re: [PATCH V7 3/4] clk: meson: S4: add support for Amlogic S4 SoC
 PLL clock driver
Message-ID: <20230426111358.xh3gbhlvxj46ggi5@CAB-WSD-L081021>
References: <20230417065005.24967-1-yu.tu@amlogic.com>
 <20230417065005.24967-4-yu.tu@amlogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230417065005.24967-4-yu.tu@amlogic.com>
User-Agent: NeoMutt/20220415
X-Originating-IP: [172.16.1.6]
X-ClientProxiedBy: S-MS-EXCH01.sberdevices.ru (172.16.1.4) To
 S-MS-EXCH01.sberdevices.ru (172.16.1.4)
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/04/26 04:45:00 #21166225
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 17, 2023 at 02:50:04PM +0800, Yu Tu wrote:
> Add the S4 PLL clock controller driver in the s4 SoC family.
> 
> Signed-off-by: Yu Tu <yu.tu@amlogic.com>
> ---
>  drivers/clk/meson/Kconfig  |  13 +
>  drivers/clk/meson/Makefile |   1 +
>  drivers/clk/meson/s4-pll.c | 902 +++++++++++++++++++++++++++++++++++++
>  drivers/clk/meson/s4-pll.h |  87 ++++
>  4 files changed, 1003 insertions(+)
>  create mode 100644 drivers/clk/meson/s4-pll.c
>  create mode 100644 drivers/clk/meson/s4-pll.h
> 
> diff --git a/drivers/clk/meson/Kconfig b/drivers/clk/meson/Kconfig
> index fc002c155bc3..a663c90a3f3b 100644
> --- a/drivers/clk/meson/Kconfig
> +++ b/drivers/clk/meson/Kconfig
> @@ -115,4 +115,17 @@ config COMMON_CLK_G12A
>  	help
>  	  Support for the clock controller on Amlogic S905D2, S905X2 and S905Y2
>  	  devices, aka g12a. Say Y if you want peripherals to work.
> +
> +config COMMON_CLK_S4_PLL
> +	tristate "S4 SoC PLL clock controllers support"
> +	depends on ARM64
> +	default y
> +	select COMMON_CLK_MESON_MPLL
> +	select COMMON_CLK_MESON_PLL
> +	select COMMON_CLK_MESON_REGMAP
> +	help
> +	  Support for the pll clock controller on Amlogic S805X2 and S905Y4 devices,
> +	  aka s4. Amlogic S805X2 and S905Y4 devices include AQ222 and AQ229.
> +	  Say Y if you want the board to work, because plls are the parent of most
> +	  peripherals.
>  endmenu
> diff --git a/drivers/clk/meson/Makefile b/drivers/clk/meson/Makefile
> index 6eca2a406ee3..376f49cc13f1 100644
> --- a/drivers/clk/meson/Makefile
> +++ b/drivers/clk/meson/Makefile
> @@ -19,3 +19,4 @@ obj-$(CONFIG_COMMON_CLK_AXG_AUDIO) += axg-audio.o
>  obj-$(CONFIG_COMMON_CLK_GXBB) += gxbb.o gxbb-aoclk.o
>  obj-$(CONFIG_COMMON_CLK_G12A) += g12a.o g12a-aoclk.o
>  obj-$(CONFIG_COMMON_CLK_MESON8B) += meson8b.o meson8-ddr.o
> +obj-$(CONFIG_COMMON_CLK_S4_PLL) += s4-pll.o
> diff --git a/drivers/clk/meson/s4-pll.c b/drivers/clk/meson/s4-pll.c
> new file mode 100644
> index 000000000000..5a34d304adf7
> --- /dev/null
> +++ b/drivers/clk/meson/s4-pll.c
> @@ -0,0 +1,902 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Amlogic Meson-S4 PLL Clock Controller Driver
> + *
> + * Copyright (c) 2021 Amlogic, inc.
> + * Author: Yu Tu <yu.tu@amlogic.com>
> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +
> +#include "clk-mpll.h"
> +#include "clk-pll.h"
> +#include "clk-regmap.h"
> +#include "s4-pll.h"
> +
> +static DEFINE_SPINLOCK(meson_clk_lock);
> +
> +static struct clk_regmap s4_fixed_pll_dco = {
> +	.data = &(struct meson_clk_pll_data){
> +		.en = {
> +			.reg_off = ANACTRL_FIXPLL_CTRL0,
> +			.shift   = 28,
> +			.width   = 1,
> +		},
> +		.m = {
> +			.reg_off = ANACTRL_FIXPLL_CTRL0,
> +			.shift   = 0,
> +			.width   = 8,
> +		},
> +		.n = {
> +			.reg_off = ANACTRL_FIXPLL_CTRL0,
> +			.shift   = 10,
> +			.width   = 5,
> +		},
> +		.frac = {
> +			.reg_off = ANACTRL_FIXPLL_CTRL1,
> +			.shift   = 0,
> +			.width   = 17,
> +		},
> +		.l = {
> +			.reg_off = ANACTRL_FIXPLL_CTRL0,
> +			.shift   = 31,
> +			.width   = 1,
> +		},
> +		.rst = {
> +			.reg_off = ANACTRL_FIXPLL_CTRL0,
> +			.shift   = 29,
> +			.width   = 1,
> +		},
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "fixed_pll_dco",
> +		/*
> +		 * This clock is a fixed value (4GHz) that is initialized by ROMcode.
> +		 * This clock won't ever change at runtime.
> +		 * The chip design determines that this clock cannot be changed after
> +		 * initialization. To prevent system crash caused by changing
> +		 * fixed related register in kernel phase. This register is not
> +		 * writable in the kernel phase.
> +		 * So we use ro_ops.
> +		 */
> +		.ops = &meson_clk_pll_ro_ops,
> +		.parent_data = (const struct clk_parent_data []) {
> +			{ .fw_name = "xtal", }
> +		},
> +		.num_parents = 1,
> +	},
> +};
> +
> +static struct clk_regmap s4_fixed_pll = {
> +	.data = &(struct clk_regmap_div_data){
> +		.offset = ANACTRL_FIXPLL_CTRL0,
> +		.shift = 16,
> +		.width = 2,
> +		.flags = CLK_DIVIDER_POWER_OF_TWO,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "fixed_pll",
> +		/*
> +		 * This clock is a fixed value (2GHz) that is initialized by ROMcode.
> +		 * This clock won't ever change at runtime.
> +		 * The chip design determines that this clock cannot be changed after
> +		 * initialization. To prevent system crash caused by changing
> +		 * fixed related register in kernel phase. This register is not
> +		 * writable in the kernel phase.
> +		 * So we use ro_ops.
> +		 */
> +		.ops = &clk_regmap_divider_ro_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&s4_fixed_pll_dco.hw
> +		},
> +		.num_parents = 1,
> +		/*
> +		 * This clock won't ever change at runtime so
> +		 * CLK_SET_RATE_PARENT is not required
> +		 */
> +	},
> +};
> +
> +static struct clk_fixed_factor s4_fclk_div2_div = {
> +	.mult = 1,
> +	.div = 2,
> +	.hw.init = &(struct clk_init_data){
> +		.name = "fclk_div2_div",
> +		.ops = &clk_fixed_factor_ops,
> +		.parent_hws = (const struct clk_hw *[]) { &s4_fixed_pll.hw },
> +		.num_parents = 1,
> +	},
> +};
> +
> +static struct clk_regmap s4_fclk_div2 = {
> +	.data = &(struct clk_regmap_gate_data){
> +		.offset = ANACTRL_FIXPLL_CTRL1,
> +		.bit_idx = 24,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "fclk_div2",
> +		/*
> +		 * This clock is a fixed value (1GHz) that is initialized by ROMcode.
> +		 * This clock won't ever ungate at runtime.
> +		 * The chip design determines that this clock cannot be changed after
> +		 * initialization. To prevent system crash caused by changing
> +		 * fixed related register in kernel phase. This register is not
> +		 * writable in the kernel phase.
> +		 * So we use ro_ops.
> +		 */

The above comment has been copied and pasted many times.
Please collapse it and refer to it from specific locations.

> +		.ops = &clk_regmap_gate_ro_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&s4_fclk_div2_div.hw
> +		},
> +		.num_parents = 1,
> +	},
> +};
> +
> +static struct clk_fixed_factor s4_fclk_div3_div = {
> +	.mult = 1,
> +	.div = 3,
> +	.hw.init = &(struct clk_init_data){
> +		.name = "fclk_div3_div",
> +		.ops = &clk_fixed_factor_ops,
> +		.parent_hws = (const struct clk_hw *[]) { &s4_fixed_pll.hw },
> +		.num_parents = 1,
> +	},
> +};
> +
> +static struct clk_regmap s4_fclk_div3 = {
> +	.data = &(struct clk_regmap_gate_data){
> +		.offset = ANACTRL_FIXPLL_CTRL1,
> +		.bit_idx = 20,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "fclk_div3",
> +		.ops = &clk_regmap_gate_ro_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&s4_fclk_div3_div.hw
> +		},
> +		.num_parents = 1,
> +	},
> +};
> +
> +static struct clk_fixed_factor s4_fclk_div4_div = {
> +	.mult = 1,
> +	.div = 4,
> +	.hw.init = &(struct clk_init_data){
> +		.name = "fclk_div4_div",
> +		.ops = &clk_fixed_factor_ops,
> +		.parent_hws = (const struct clk_hw *[]) { &s4_fixed_pll.hw },
> +		.num_parents = 1,
> +	},
> +};
> +
> +static struct clk_regmap s4_fclk_div4 = {
> +	.data = &(struct clk_regmap_gate_data){
> +		.offset = ANACTRL_FIXPLL_CTRL1,
> +		.bit_idx = 21,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "fclk_div4",
> +		.ops = &clk_regmap_gate_ro_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&s4_fclk_div4_div.hw
> +		},
> +		.num_parents = 1,
> +	},
> +};
> +
> +static struct clk_fixed_factor s4_fclk_div5_div = {
> +	.mult = 1,
> +	.div = 5,
> +	.hw.init = &(struct clk_init_data){
> +		.name = "fclk_div5_div",
> +		.ops = &clk_fixed_factor_ops,
> +		.parent_hws = (const struct clk_hw *[]) { &s4_fixed_pll.hw },
> +		.num_parents = 1,
> +	},
> +};
> +
> +static struct clk_regmap s4_fclk_div5 = {
> +	.data = &(struct clk_regmap_gate_data){
> +		.offset = ANACTRL_FIXPLL_CTRL1,
> +		.bit_idx = 22,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "fclk_div5",
> +		.ops = &clk_regmap_gate_ro_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&s4_fclk_div5_div.hw
> +		},
> +		.num_parents = 1,
> +	},
> +};
> +
> +static struct clk_fixed_factor s4_fclk_div7_div = {
> +	.mult = 1,
> +	.div = 7,
> +	.hw.init = &(struct clk_init_data){
> +		.name = "fclk_div7_div",
> +		.ops = &clk_fixed_factor_ops,
> +		.parent_hws = (const struct clk_hw *[]) { &s4_fixed_pll.hw },
> +		.num_parents = 1,
> +	},
> +};
> +
> +static struct clk_regmap s4_fclk_div7 = {
> +	.data = &(struct clk_regmap_gate_data){
> +		.offset = ANACTRL_FIXPLL_CTRL1,
> +		.bit_idx = 23,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "fclk_div7",
> +		.ops = &clk_regmap_gate_ro_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&s4_fclk_div7_div.hw
> +		},
> +		.num_parents = 1,
> +	},
> +};
> +
> +static struct clk_fixed_factor s4_fclk_div2p5_div = {
> +	.mult = 2,
> +	.div = 5,
> +	.hw.init = &(struct clk_init_data){
> +		.name = "fclk_div2p5_div",
> +		.ops = &clk_fixed_factor_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&s4_fixed_pll.hw
> +		},
> +		.num_parents = 1,
> +	},
> +};
> +
> +static struct clk_regmap s4_fclk_div2p5 = {
> +	.data = &(struct clk_regmap_gate_data){
> +		.offset = ANACTRL_FIXPLL_CTRL1,
> +		.bit_idx = 25,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "fclk_div2p5",
> +		.ops = &clk_regmap_gate_ro_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&s4_fclk_div2p5_div.hw
> +		},
> +		.num_parents = 1,
> +	},
> +};
> +
> +static const struct pll_mult_range s4_gp0_pll_mult_range = {
> +	.min = 125,
> +	.max = 250,
> +};
> +
> +/*
> + * Internal gp0 pll emulation configuration parameters
> + */
> +static const struct reg_sequence s4_gp0_init_regs[] = {
> +	{ .reg = ANACTRL_GP0PLL_CTRL1,	.def = 0x00000000 },
> +	{ .reg = ANACTRL_GP0PLL_CTRL2,	.def = 0x00000000 },
> +	{ .reg = ANACTRL_GP0PLL_CTRL3,	.def = 0x48681c00 },
> +	{ .reg = ANACTRL_GP0PLL_CTRL4,	.def = 0x88770290 },
> +	{ .reg = ANACTRL_GP0PLL_CTRL5,	.def = 0x39272000 },
> +	{ .reg = ANACTRL_GP0PLL_CTRL6,	.def = 0x56540000 }

Please ensure that the initialization sequence values do not overlap
with the below pll_data bits that are managed during runtime.

> +};
> +
> +static struct clk_regmap s4_gp0_pll_dco = {
> +	.data = &(struct meson_clk_pll_data){
> +		.en = {
> +			.reg_off = ANACTRL_GP0PLL_CTRL0,
> +			.shift   = 28,
> +			.width   = 1,
> +		},
> +		.m = {
> +			.reg_off = ANACTRL_GP0PLL_CTRL0,
> +			.shift   = 0,
> +			.width   = 8,
> +		},
> +		.n = {
> +			.reg_off = ANACTRL_GP0PLL_CTRL0,
> +			.shift   = 10,
> +			.width   = 5,
> +		},
> +		.frac = {
> +			.reg_off = ANACTRL_GP0PLL_CTRL1,
> +			.shift   = 0,
> +			.width   = 17,
> +		},
> +		.l = {
> +			.reg_off = ANACTRL_GP0PLL_CTRL0,
> +			.shift   = 31,
> +			.width   = 1,
> +		},
> +		.rst = {
> +			.reg_off = ANACTRL_GP0PLL_CTRL0,
> +			.shift   = 29,
> +			.width   = 1,
> +		},
> +		.range = &s4_gp0_pll_mult_range,
> +		.init_regs = s4_gp0_init_regs,
> +		.init_count = ARRAY_SIZE(s4_gp0_init_regs),
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "gp0_pll_dco",
> +		.ops = &meson_clk_pll_ops,
> +		.parent_data = (const struct clk_parent_data []) {
> +			{ .fw_name = "xtal", }
> +		},
> +		.num_parents = 1,
> +	},
> +};
> +
> +static struct clk_regmap s4_gp0_pll = {
> +	.data = &(struct clk_regmap_div_data){
> +		.offset = ANACTRL_GP0PLL_CTRL0,
> +		.shift = 16,
> +		.width = 3,
> +		.flags = (CLK_DIVIDER_POWER_OF_TWO |
> +			  CLK_DIVIDER_ROUND_CLOSEST),
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "gp0_pll",
> +		.ops = &clk_regmap_divider_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&s4_gp0_pll_dco.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +/*
> + * Internal hifi pll emulation configuration parameters
> + */
> +static const struct reg_sequence s4_hifi_init_regs[] = {
> +	{ .reg = ANACTRL_HIFIPLL_CTRL1,	.def = 0x00010e56 },
> +	{ .reg = ANACTRL_HIFIPLL_CTRL2,	.def = 0x00000000 },
> +	{ .reg = ANACTRL_HIFIPLL_CTRL3,	.def = 0x6a285c00 },
> +	{ .reg = ANACTRL_HIFIPLL_CTRL4,	.def = 0x65771290 },
> +	{ .reg = ANACTRL_HIFIPLL_CTRL5,	.def = 0x39272000 },
> +	{ .reg = ANACTRL_HIFIPLL_CTRL6,	.def = 0x56540000 }
> +};

Please ensure that the initialization sequence values do not overlap
with the below pll_data bits that are managed during runtime.

> +
> +static struct clk_regmap s4_hifi_pll_dco = {
> +	.data = &(struct meson_clk_pll_data){
> +		.en = {
> +			.reg_off = ANACTRL_HIFIPLL_CTRL0,
> +			.shift   = 28,
> +			.width   = 1,
> +		},
> +		.m = {
> +			.reg_off = ANACTRL_HIFIPLL_CTRL0,
> +			.shift   = 0,
> +			.width   = 8,
> +		},
> +		.n = {
> +			.reg_off = ANACTRL_HIFIPLL_CTRL0,
> +			.shift   = 10,
> +			.width   = 5,
> +		},
> +		.frac = {
> +			.reg_off = ANACTRL_HIFIPLL_CTRL1,
> +			.shift   = 0,
> +			.width   = 17,
> +		},
> +		.l = {
> +			.reg_off = ANACTRL_HIFIPLL_CTRL0,
> +			.shift   = 31,
> +			.width   = 1,
> +		},
> +		.rst = {
> +			.reg_off = ANACTRL_HIFIPLL_CTRL0,
> +			.shift   = 29,
> +			.width   = 1,
> +		},
> +		.range = &s4_gp0_pll_mult_range,
> +		.init_regs = s4_hifi_init_regs,
> +		.init_count = ARRAY_SIZE(s4_hifi_init_regs),
> +		.flags = CLK_MESON_PLL_ROUND_CLOSEST,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "hifi_pll_dco",
> +		.ops = &meson_clk_pll_ops,
> +		.parent_data = (const struct clk_parent_data []) {
> +			{ .fw_name = "xtal", }
> +		},
> +		.num_parents = 1,
> +	},
> +};
> +
> +static struct clk_regmap s4_hifi_pll = {
> +	.data = &(struct clk_regmap_div_data){
> +		.offset = ANACTRL_HIFIPLL_CTRL0,
> +		.shift = 16,
> +		.width = 2,
> +		.flags = (CLK_DIVIDER_POWER_OF_TWO |
> +			  CLK_DIVIDER_ROUND_CLOSEST),
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "hifi_pll",
> +		.ops = &clk_regmap_divider_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&s4_hifi_pll_dco.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +

[...]

> +static int meson_s4_pll_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct regmap *regmap;
> +	void __iomem *base;
> +	int ret, i;
> +
> +	base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(base))
> +		return PTR_ERR(base);
> +
> +	regmap = devm_regmap_init_mmio(dev, base, &clkc_regmap_config);
> +	if (IS_ERR(regmap))
> +		return PTR_ERR(regmap);
> +
> +	ret = regmap_multi_reg_write(regmap, s4_init_regs, ARRAY_SIZE(s4_init_regs));
> +	if (ret) {
> +		dev_err(dev, "Failed to init registers\n");

dev_err_probe()

> +		return ret;
> +	}
> +
> +	/* Populate regmap for the regmap backed clocks */
> +	for (i = 0; i < ARRAY_SIZE(s4_pll_clk_regmaps); i++)
> +		s4_pll_clk_regmaps[i]->map = regmap;
> +
> +	for (i = 0; i < s4_pll_hw_onecell_data.num; i++) {
> +		/* array might be sparse */
> +		if (!s4_pll_hw_onecell_data.hws[i])
> +			continue;
> +
> +		ret = devm_clk_hw_register(dev, s4_pll_hw_onecell_data.hws[i]);
> +		if (ret) {
> +			dev_err(dev, "Clock registration failed\n");

dev_err_probe()

> +			return ret;
> +		}
> +	}
> +
> +	return devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get,
> +					   &s4_pll_hw_onecell_data);
> +}
> +
> +static const struct of_device_id clkc_match_table[] = {
> +	{
> +		.compatible = "amlogic,s4-pll-clkc",
> +	},
> +	{}
> +};
> +
> +static struct platform_driver s4_driver = {
> +	.probe		= meson_s4_pll_probe,
> +	.driver		= {
> +		.name	= "s4-pll-clkc",
> +		.of_match_table = clkc_match_table,
> +	},
> +};
> +
> +module_platform_driver(s4_driver);
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/clk/meson/s4-pll.h b/drivers/clk/meson/s4-pll.h
> new file mode 100644
> index 000000000000..1fb5bececf5f
> --- /dev/null
> +++ b/drivers/clk/meson/s4-pll.h
> @@ -0,0 +1,87 @@
> +/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
> +/*
> + * Copyright (c) 2021 Amlogic, inc.
> + * Author: Yu Tu <yu.tu@amlogic.com>
> + */
> +
> +#ifndef __MESON_S4_PLL_H__
> +#define __MESON_S4_PLL_H__
> +
> +/* ANA_CTRL - Registers */
> +
> +#define ANACTRL_FIXPLL_CTRL0                       0x040
> +#define ANACTRL_FIXPLL_CTRL1                       0x044
> +#define ANACTRL_FIXPLL_CTRL2                       0x048
> +#define ANACTRL_FIXPLL_CTRL3                       0x04c
> +#define ANACTRL_FIXPLL_CTRL4                       0x050
> +#define ANACTRL_FIXPLL_CTRL5                       0x054
> +#define ANACTRL_FIXPLL_CTRL6                       0x058
> +#define ANACTRL_FIXPLL_STS                         0x05c
> +#define ANACTRL_GP0PLL_CTRL0                       0x080
> +#define ANACTRL_GP0PLL_CTRL1                       0x084
> +#define ANACTRL_GP0PLL_CTRL2                       0x088
> +#define ANACTRL_GP0PLL_CTRL3                       0x08c
> +#define ANACTRL_GP0PLL_CTRL4                       0x090
> +#define ANACTRL_GP0PLL_CTRL5                       0x094
> +#define ANACTRL_GP0PLL_CTRL6                       0x098
> +#define ANACTRL_GP0PLL_STS                         0x09c
> +#define ANACTRL_HIFIPLL_CTRL0                      0x100
> +#define ANACTRL_HIFIPLL_CTRL1                      0x104
> +#define ANACTRL_HIFIPLL_CTRL2                      0x108
> +#define ANACTRL_HIFIPLL_CTRL3                      0x10c
> +#define ANACTRL_HIFIPLL_CTRL4                      0x110
> +#define ANACTRL_HIFIPLL_CTRL5                      0x114
> +#define ANACTRL_HIFIPLL_CTRL6                      0x118
> +#define ANACTRL_HIFIPLL_STS                        0x11c
> +#define ANACTRL_MPLL_CTRL0                         0x180
> +#define ANACTRL_MPLL_CTRL1                         0x184
> +#define ANACTRL_MPLL_CTRL2                         0x188
> +#define ANACTRL_MPLL_CTRL3                         0x18c
> +#define ANACTRL_MPLL_CTRL4                         0x190
> +#define ANACTRL_MPLL_CTRL5                         0x194
> +#define ANACTRL_MPLL_CTRL6                         0x198
> +#define ANACTRL_MPLL_CTRL7                         0x19c
> +#define ANACTRL_MPLL_CTRL8                         0x1a0
> +#define ANACTRL_MPLL_STS                           0x1a4
> +#define ANACTRL_HDMIPLL_CTRL0                      0x1c0
> +#define ANACTRL_HDMIPLL_CTRL1                      0x1c4
> +#define ANACTRL_HDMIPLL_CTRL2                      0x1c8
> +#define ANACTRL_HDMIPLL_CTRL3                      0x1cc
> +#define ANACTRL_HDMIPLL_CTRL4                      0x1d0
> +#define ANACTRL_HDMIPLL_CTRL5                      0x1d4
> +#define ANACTRL_HDMIPLL_CTRL6                      0x1d8
> +#define ANACTRL_HDMIPLL_STS                        0x1dc
> +#define ANACTRL_HDMIPLL_VLOCK                      0x1e4
> +
> +/*
> + * CLKID index values
> + *
> + * These indices are entirely contrived and do not map onto the hardware.
> + * It has now been decided to expose everything by default in the DT header:
> + * include/dt-bindings/clock/axg-clkc.h. Only the clocks ids we don't want

axg-clkc.h?

> + * to expose, such as the internal muxes and dividers of composite clocks,
> + * will remain defined here.
> + */
> +#define CLKID_FIXED_PLL_DCO		0
> +#define CLKID_FCLK_DIV2_DIV		2
> +#define CLKID_FCLK_DIV3_DIV		4
> +#define CLKID_FCLK_DIV4_DIV		6
> +#define CLKID_FCLK_DIV5_DIV		8
> +#define CLKID_FCLK_DIV7_DIV		10
> +#define CLKID_FCLK_DIV2P5_DIV		12
> +#define CLKID_GP0_PLL_DCO		14
> +#define CLKID_HIFI_PLL_DCO		16
> +#define CLKID_HDMI_PLL_DCO		18
> +#define CLKID_HDMI_PLL_OD		19
> +#define CLKID_MPLL_50M_DIV		21
> +#define CLKID_MPLL_PREDIV		23
> +#define CLKID_MPLL0_DIV			24
> +#define CLKID_MPLL1_DIV			26
> +#define CLKID_MPLL2_DIV			28
> +#define CLKID_MPLL3_DIV			30
> +
> +#define NR_PLL_CLKS			32
> +/* include the CLKIDs that have been made part of the DT binding */
> +#include <dt-bindings/clock/amlogic,s4-pll-clkc.h>
> +
> +#endif /* __MESON_S4_PLL_H__ */
> -- 
> 2.33.1
> 
> 
> _______________________________________________
> linux-amlogic mailing list
> linux-amlogic@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-amlogic

-- 
Thank you,
Dmitry
