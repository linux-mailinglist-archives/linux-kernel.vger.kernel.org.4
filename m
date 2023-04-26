Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBE8F6EF316
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 13:06:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231915AbjDZLGQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 07:06:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240625AbjDZLGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 07:06:03 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78FBB40F9;
        Wed, 26 Apr 2023 04:05:41 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id C3D235FD7A;
        Wed, 26 Apr 2023 14:05:39 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1682507139;
        bh=mk5alZKFSoxzLGhsqJ1BDxTrptWunt8lfVSZGARmYfI=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
        b=i7a8nPO9995Z/5uPXp78chLMg2rLFQ38AZIjzyB//P70pw20qOROtU8HYJ9DB5BA9
         OvwBnPffCIgd0QU9dju9R02Fdm15D8PyKEVsi6r9pAvwF+brTuKKpx6dFQgzkpHxpi
         ZP/9bhMPsfaQTfixH9vluA9J4ydQvj8qcOvqT6UIExLfHGsHXqbElwVsLhkaW58xQ4
         fxiqQCCNRdyjVsBX2MwFle/IlGN0FLFZvijR9DowjTvIaTrLK9QFJRpF4JakaZS1RW
         UYnJwqHS4T3SxeNgxTO/5cj6j4T5XytWvZRaSDQHCHAwSKsae91T6I4+r9e9PY48to
         PQunlBKlMGzsw==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Wed, 26 Apr 2023 14:05:39 +0300 (MSK)
Date:   Wed, 26 Apr 2023 14:05:38 +0300
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
Subject: Re: [PATCH V7 4/4] clk: meson: s4: add support for Amlogic S4 SoC
 peripheral clock controller
Message-ID: <20230426110538.y2d4qhv2qffc62vj@CAB-WSD-L081021>
References: <20230417065005.24967-1-yu.tu@amlogic.com>
 <20230417065005.24967-5-yu.tu@amlogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230417065005.24967-5-yu.tu@amlogic.com>
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

On Mon, Apr 17, 2023 at 02:50:05PM +0800, Yu Tu wrote:
> Add the peripherals clock controller driver in the s4 SoC family.
> 
> Signed-off-by: Yu Tu <yu.tu@amlogic.com>
> ---
>  drivers/clk/meson/Kconfig          |   12 +
>  drivers/clk/meson/Makefile         |    1 +
>  drivers/clk/meson/s4-peripherals.c | 3814 ++++++++++++++++++++++++++++
>  drivers/clk/meson/s4-peripherals.h |  217 ++
>  4 files changed, 4044 insertions(+)
>  create mode 100644 drivers/clk/meson/s4-peripherals.c
>  create mode 100644 drivers/clk/meson/s4-peripherals.h
> 
> diff --git a/drivers/clk/meson/Kconfig b/drivers/clk/meson/Kconfig
> index a663c90a3f3b..a6eb9fa15c74 100644
> --- a/drivers/clk/meson/Kconfig
> +++ b/drivers/clk/meson/Kconfig
> @@ -128,4 +128,16 @@ config COMMON_CLK_S4_PLL
>  	  aka s4. Amlogic S805X2 and S905Y4 devices include AQ222 and AQ229.
>  	  Say Y if you want the board to work, because plls are the parent of most
>  	  peripherals.
> +
> +config COMMON_CLK_S4
> +	tristate "S4 SoC Peripherals clock controllers support"
> +	depends on ARM64
> +	default y
> +	select COMMON_CLK_MESON_REGMAP
> +	select COMMON_CLK_MESON_DUALDIV
> +	select COMMON_CLK_MESON_VID_PLL_DIV
> +	help
> +	  Support for the Peripherals clock controller on Amlogic S805X2 and S905Y4
> +	  devices, aka s4. Amlogic S805X2 and S905Y4 devices include AQ222 and AQ229.
> +	  Say Y if you want peripherals to work.
>  endmenu
> diff --git a/drivers/clk/meson/Makefile b/drivers/clk/meson/Makefile
> index 376f49cc13f1..c9130afccb48 100644
> --- a/drivers/clk/meson/Makefile
> +++ b/drivers/clk/meson/Makefile
> @@ -20,3 +20,4 @@ obj-$(CONFIG_COMMON_CLK_GXBB) += gxbb.o gxbb-aoclk.o
>  obj-$(CONFIG_COMMON_CLK_G12A) += g12a.o g12a-aoclk.o
>  obj-$(CONFIG_COMMON_CLK_MESON8B) += meson8b.o meson8-ddr.o
>  obj-$(CONFIG_COMMON_CLK_S4_PLL) += s4-pll.o
> +obj-$(CONFIG_COMMON_CLK_S4) += s4-peripherals.o

[...]

> +static struct clk_regmap s4_ceca_32k_clkin = {
> +	.data = &(struct clk_regmap_gate_data){
> +		.offset = CLKCTRL_CECA_CTRL0,
> +		.bit_idx = 31,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "ceca_32k_clkin",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_data = (const struct clk_parent_data []) {
> +			{ .fw_name = "xtal", }
> +		},
> +		.num_parents = 1,
> +	},
> +};
> +
> +static struct clk_regmap s4_ceca_32k_div = {
> +	.data = &(struct meson_clk_dualdiv_data){
> +		.n1 = {
> +			.reg_off = CLKCTRL_CECA_CTRL0,
> +			.shift   = 0,
> +			.width   = 12,
> +		},
> +		.n2 = {
> +			.reg_off = CLKCTRL_CECA_CTRL0,
> +			.shift   = 12,
> +			.width   = 12,
> +		},
> +		.m1 = {
> +			.reg_off = CLKCTRL_CECA_CTRL1,
> +			.shift   = 0,
> +			.width   = 12,
> +		},
> +		.m2 = {
> +			.reg_off = CLKCTRL_CECA_CTRL1,
> +			.shift   = 12,
> +			.width   = 12,
> +		},
> +		.dual = {
> +			.reg_off = CLKCTRL_CECA_CTRL0,
> +			.shift   = 28,
> +			.width   = 1,
> +		},
> +		.table = s4_32k_div_table,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "ceca_32k_div",
> +		.ops = &meson_clk_dualdiv_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&s4_ceca_32k_clkin.hw
> +		},
> +		.num_parents = 1,
> +	},
> +};
> +
> +static struct clk_regmap s4_ceca_32k_sel_pre = {
> +	.data = &(struct clk_regmap_mux_data) {
> +		.offset = CLKCTRL_CECA_CTRL1,
> +		.mask = 0x1,
> +		.shift = 24,
> +		.flags = CLK_MUX_ROUND_CLOSEST,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "ceca_32k_sel_pre",
> +		.ops = &clk_regmap_mux_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&s4_ceca_32k_div.hw,
> +			&s4_ceca_32k_clkin.hw
> +		},
> +		.num_parents = 2,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap s4_ceca_32k_sel = {
> +	.data = &(struct clk_regmap_mux_data) {
> +		.offset = CLKCTRL_CECA_CTRL1,
> +		.mask = 0x1,
> +		.shift = 31,
> +		.flags = CLK_MUX_ROUND_CLOSEST,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "ceca_32k_sel",
> +		.ops = &clk_regmap_mux_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&s4_ceca_32k_sel_pre.hw,
> +			&s4_rtc_clk.hw
> +		},
> +		.num_parents = 2,
> +		.flags = CLK_SET_RATE_PARENT,

In my opinion, all clocks that can inherit from a more accurate RTC clock
should be marked with the CLK_SET_RATE_NO_REPARENT flag.
This is necessary because in certain situations, it may be required to
freeze their parent. The setup of these clocks' parent should be located
on the device tree's side.

[...]

> +
> +/*
> + * gen clk is designed for debug/monitor some internal clock quality. Some of the
> + * corresponding clock sources are not described in the clock tree and internal clock
> + * for debug, so they are skipped.
> + */
> +static u32 s4_gen_clk_mux_table[] = { 0, 4, 5, 7, 19, 21, 22,
> +				      23, 24, 25, 26, 27, 28 };
> +static const struct clk_parent_data s4_gen_clk_parent_data[] = {
> +	{ .fw_name = "xtal", },
> +	{ .hw = &s4_vid_pll.hw },
> +	{ .fw_name = "gp0_pll", },
> +	{ .fw_name = "hifi_pll", },
> +	{ .fw_name = "fclk_div2", },
> +	{ .fw_name = "fclk_div3", },
> +	{ .fw_name = "fclk_div4", },
> +	{ .fw_name = "fclk_div5", },
> +	{ .fw_name = "fclk_div7", },
> +	{ .fw_name = "mpll0", },
> +	{ .fw_name = "mpll1", },
> +	{ .fw_name = "mpll2", },
> +	{ .fw_name = "mpll3", },
> +};
> +
> +static struct clk_regmap s4_gen_clk_sel = {
> +	.data = &(struct clk_regmap_mux_data){
> +		.offset = CLKCTRL_GEN_CLK_CTRL,
> +		.mask = 0x1f,
> +		.shift = 12,
> +		.table = s4_gen_clk_mux_table,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "gen_clk_sel",
> +		.ops = &clk_regmap_mux_ops,
> +		.parent_data = s4_gen_clk_parent_data,
> +		.num_parents = ARRAY_SIZE(s4_gen_clk_parent_data),

I think, the gen_clk selector should be marked with the
CLK_SET_RATE_NO_REPARENT flag. This is because the GEN clock can be
connected to an external pad and may be set up directly from the
device tree.

> +	},
> +};
> +
> +static struct clk_regmap s4_gen_clk_div = {
> +	.data = &(struct clk_regmap_div_data){
> +		.offset = CLKCTRL_GEN_CLK_CTRL,
> +		.shift = 0,
> +		.width = 11,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "gen_clk_div",
> +		.ops = &clk_regmap_divider_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&s4_gen_clk_sel.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap s4_gen_clk = {
> +	.data = &(struct clk_regmap_gate_data){
> +		.offset = CLKCTRL_GEN_CLK_CTRL,
> +		.bit_idx = 11,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "gen_clk",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&s4_gen_clk_div.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT | CLK_GET_RATE_NOCACHE,
> +	},
> +};
> +

[...]

-- 
Thank you,
Dmitry
