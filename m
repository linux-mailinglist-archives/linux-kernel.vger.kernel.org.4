Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56ACA682801
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 10:04:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbjAaJEQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 04:04:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231926AbjAaJDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 04:03:46 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3685C4B1AD
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 01:00:24 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id ud5so39573798ejc.4
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 01:00:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IzmwuFbv/Dt96spaoMIhvTJetC1bhODDZNOO16lq0VM=;
        b=EekWvz/q9Shw2x9yuwW/YEXz2VvrWfnH+gPJjuLwPBDNLl519sii9B8dNban0Zn32H
         7+rUob3kABTgp64c2TqYChbM2Io+ii03rVQPRSszXWbaZPFcSBWd1lZoJVnnVx0hVed5
         R89uJeRIJJY3Hmv7TLraYb2vd2obM+YRrytpFN5tNpN+gVzZJj9uXaoqRk3PpujSFN7a
         +uvoCDUJpaAEs197AI07vAkIkmOcelZJbR0qu3Z7XC7EsC7XV8a13BdDgy5h04+fT4gO
         LROpxZxEOA8062Epwm1G1wUo6qvkmoAs+33nSzIG7nlwfpNe5294oA5RcvyMfal8EJQR
         6NqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IzmwuFbv/Dt96spaoMIhvTJetC1bhODDZNOO16lq0VM=;
        b=O4iMfAyUTY9L/YWScvdBiXOSIMQeQ1yqp691EPVallqB3eRSKkOHgAF+wUPoJFMcfY
         XAYiugKdHl86g61lfgxayoZkKq8hUNq0SkW6N5KG08EbQJfwUhcnxnGE94odMJHkyeF3
         1OqiLRbI4qD+kRt10SbYW+ziY23pZODIHqZd0cU9jGpn3+C48ZhMF4FVaZfF7Ti82y7X
         vwJYQ+rgcovz3BgqFhXXQCzAWNimsotobSkLegRRNOti3R17PtyOYWHfnXfMJXeMtEi5
         AhSU8pMBpmwqtnuvZ2/zhhx5Qq0HNQeUI2a37tK6bQcVxpQs7JIBulnStgWz2sB+h7XM
         vNKw==
X-Gm-Message-State: AO0yUKXde1unnbWKBlinzye8bPgCT78NT04Px3aIS2JsHQXIhrIPG+NF
        id6XirLY1Up8tEuUSAVZwcRK2A==
X-Google-Smtp-Source: AK7set+WwIv3DbUIM7Zr3WioVHo8XYM8EQYgMtpLroNfEE8ydt046yKtAaoc9L6Ae4lsA4OnhLKjiQ==
X-Received: by 2002:a17:906:2ad4:b0:884:4806:c39 with SMTP id m20-20020a1709062ad400b0088448060c39mr10301626eje.11.1675155619707;
        Tue, 31 Jan 2023 01:00:19 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id b14-20020a1709062b4e00b00880d9530761sm5499532ejg.209.2023.01.31.01.00.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Jan 2023 01:00:19 -0800 (PST)
Message-ID: <ac2d458c-3cb9-9117-82ca-b025b92073df@linaro.org>
Date:   Tue, 31 Jan 2023 11:00:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v4 4/8] clk: qcom: Add GPU clock controller driver for
 SM6125
Content-Language: en-GB
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
References: <20230130235926.2419776-1-konrad.dybcio@linaro.org>
 <20230130235926.2419776-5-konrad.dybcio@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230130235926.2419776-5-konrad.dybcio@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/01/2023 01:59, Konrad Dybcio wrote:
> Add support for the GPU clock controller found on SM6125.
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>   drivers/clk/qcom/Kconfig        |   9 +
>   drivers/clk/qcom/Makefile       |   1 +
>   drivers/clk/qcom/gpucc-sm6125.c | 424 ++++++++++++++++++++++++++++++++
>   3 files changed, 434 insertions(+)
>   create mode 100644 drivers/clk/qcom/gpucc-sm6125.c
> 
> diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
> index ca6c7d2ada6c..4ee1bf151ee2 100644
> --- a/drivers/clk/qcom/Kconfig
> +++ b/drivers/clk/qcom/Kconfig
> @@ -798,6 +798,15 @@ config SM_GCC_8550
>   	  Say Y if you want to use peripheral devices such as UART,
>   	  SPI, I2C, USB, SD/UFS, PCIe etc.
>   
> +config SM_GPUCC_6125
> +	tristate "SM6125 Graphics Clock Controller"
> +	select SM_GCC_6125
> +	depends on ARM64 || COMPILE_TEST
> +	help
> +	  Support for the graphics clock controller on SM6125 devices.
> +	  Say Y if you want to support graphics controller devices and
> +	  functionality such as 3D graphics.
> +
>   config SM_GPUCC_6350
>   	tristate "SM6350 Graphics Clock Controller"
>   	select SM_GCC_6350
> diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
> index e41ea0efe8c4..14405ccf1992 100644
> --- a/drivers/clk/qcom/Makefile
> +++ b/drivers/clk/qcom/Makefile
> @@ -112,6 +112,7 @@ obj-$(CONFIG_SM_GCC_8250) += gcc-sm8250.o
>   obj-$(CONFIG_SM_GCC_8350) += gcc-sm8350.o
>   obj-$(CONFIG_SM_GCC_8450) += gcc-sm8450.o
>   obj-$(CONFIG_SM_GCC_8550) += gcc-sm8550.o
> +obj-$(CONFIG_SM_GPUCC_6125) += gpucc-sm6125.o
>   obj-$(CONFIG_SM_GPUCC_6350) += gpucc-sm6350.o
>   obj-$(CONFIG_SM_GPUCC_8150) += gpucc-sm8150.o
>   obj-$(CONFIG_SM_GPUCC_8250) += gpucc-sm8250.o
> diff --git a/drivers/clk/qcom/gpucc-sm6125.c b/drivers/clk/qcom/gpucc-sm6125.c
> new file mode 100644
> index 000000000000..5ddaf45b6e0b
> --- /dev/null
> +++ b/drivers/clk/qcom/gpucc-sm6125.c
> @@ -0,0 +1,424 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2019, The Linux Foundation. All rights reserved.
> + * Copyright (c) 2023, Linaro Limited
> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/regmap.h>
> +
> +#include <dt-bindings/clock/qcom,sm6125-gpucc.h>
> +
> +#include "clk-alpha-pll.h"
> +#include "clk-branch.h"
> +#include "clk-rcg.h"
> +#include "clk-regmap.h"
> +#include "clk-regmap-divider.h"
> +#include "clk-regmap-mux.h"
> +#include "clk-regmap-phy-mux.h"
> +#include "gdsc.h"
> +#include "reset.h"
> +
> +enum {
> +	DT_BI_TCXO,
> +	DT_GCC_GPU_GPLL0_CLK_SRC,
> +};
> +
> +enum {
> +	P_BI_TCXO,
> +	P_GPLL0_OUT_MAIN,
> +	P_GPU_CC_PLL0_2X_CLK,
> +	P_GPU_CC_PLL0_OUT_AUX2,
> +	P_GPU_CC_PLL1_OUT_AUX,
> +	P_GPU_CC_PLL1_OUT_AUX2,
> +};
> +
> +static struct pll_vco gpu_cc_pll_vco[] = {
> +	{ 1000000000, 2000000000, 0 },
> +	{ 500000000,  1000000000, 2 },
> +};
> +
> +/* 1020MHz configuration */
> +static const struct alpha_pll_config gpu_pll0_config = {
> +	.l = 0x35,
> +	.config_ctl_val = 0x4001055b,
> +	.alpha_hi = 0x20,
> +	.alpha = 0x00,
> +	.alpha_en_mask = BIT(24),
> +	.vco_val = 0x0 << 20,
> +	.vco_mask = 0x3 << 20,
> +	.aux2_output_mask = BIT(2),
> +};
> +
> +/* 930MHz configuration */
> +static const struct alpha_pll_config gpu_pll1_config = {
> +	.l = 0x30,
> +	.config_ctl_val = 0x4001055b,
> +	.alpha_hi = 0x70,
> +	.alpha = 0x00,
> +	.alpha_en_mask = BIT(24),
> +	.vco_val = 0x2 << 20,
> +	.vco_mask = 0x3 << 20,
> +	.aux2_output_mask = BIT(2),
> +};
> +
> +static struct clk_alpha_pll gpu_cc_pll0_out_aux2 = {
> +	.offset = 0x0,
> +	.vco_table = gpu_cc_pll_vco,
> +	.num_vco = ARRAY_SIZE(gpu_cc_pll_vco),
> +	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_DEFAULT],
> +	.flags = SUPPORTS_DYNAMIC_UPDATE,
> +	.clkr = {
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gpu_cc_pll0_out_aux2",
> +			.parent_data = &(const struct clk_parent_data) {
> +				.index = DT_BI_TCXO,
> +			},
> +			.num_parents = 1,
> +			.ops = &clk_alpha_pll_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_alpha_pll gpu_cc_pll1_out_aux2 = {
> +	.offset = 0x100,
> +	.vco_table = gpu_cc_pll_vco,
> +	.num_vco = ARRAY_SIZE(gpu_cc_pll_vco),
> +	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_DEFAULT],
> +	.flags = SUPPORTS_DYNAMIC_UPDATE,
> +	.clkr = {
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gpu_cc_pll1_out_aux2",
> +			.parent_data = &(const struct clk_parent_data) {
> +				.index = DT_BI_TCXO,
> +			},
> +			.num_parents = 1,
> +			.ops = &clk_alpha_pll_ops,
> +		},
> +	},
> +};
> +
> +static const struct parent_map gpu_cc_parent_map_0[] = {
> +	{ P_BI_TCXO, 0 },
> +	{ P_GPLL0_OUT_MAIN, 5 },
> +};
> +
> +static const struct clk_parent_data gpu_cc_parent_data_0[] = {
> +	{ .index = DT_BI_TCXO },
> +	{ .index = DT_GCC_GPU_GPLL0_CLK_SRC },
> +};
> +
> +static const struct parent_map gpu_cc_parent_map_1[] = {
> +	{ P_BI_TCXO, 0 },
> +	{ P_GPU_CC_PLL0_OUT_AUX2, 2 },
> +	{ P_GPU_CC_PLL1_OUT_AUX2, 4 },
> +};
> +
> +static const struct clk_parent_data gpu_cc_parent_data_1[] = {
> +	{ .index = DT_BI_TCXO },
> +	{ .hw = &gpu_cc_pll0_out_aux2.clkr.hw },
> +	{ .hw = &gpu_cc_pll1_out_aux2.clkr.hw },
> +};
> +
> +static const struct freq_tbl ftbl_gpu_cc_gmu_clk_src[] = {
> +	F(200000000, P_GPLL0_OUT_MAIN, 3, 0, 0),
> +	{ }
> +};
> +
> +static struct clk_rcg2 gpu_cc_gmu_clk_src = {
> +	.cmd_rcgr = 0x1120,
> +	.mnd_width = 0,
> +	.hid_width = 5,
> +	.parent_map = gpu_cc_parent_map_0,
> +	.freq_tbl = ftbl_gpu_cc_gmu_clk_src,
> +	.clkr.hw.init = &(struct clk_init_data){
> +		.name = "gpu_cc_gmu_clk_src",
> +		.parent_data = gpu_cc_parent_data_0,
> +		.num_parents = ARRAY_SIZE(gpu_cc_parent_data_0),
> +		.ops = &clk_rcg2_shared_ops,
> +	},
> +};
> +
> +static const struct freq_tbl ftbl_gpu_cc_gx_gfx3d_clk_src[] = {
> +	F(320000000, P_GPU_CC_PLL1_OUT_AUX2, 2, 0, 0),
> +	F(465000000, P_GPU_CC_PLL1_OUT_AUX2, 2, 0, 0),
> +	F(600000000, P_GPU_CC_PLL0_OUT_AUX2, 2, 0, 0),
> +	F(745000000, P_GPU_CC_PLL0_OUT_AUX2, 2, 0, 0),
> +	F(820000000, P_GPU_CC_PLL0_OUT_AUX2, 2, 0, 0),
> +	F(900000000, P_GPU_CC_PLL0_OUT_AUX2, 2, 0, 0),
> +	F(950000000, P_GPU_CC_PLL0_OUT_AUX2, 2, 0, 0),
> +	{ }
> +};
> +
> +static struct clk_rcg2 gpu_cc_gx_gfx3d_clk_src = {
> +	.cmd_rcgr = 0x101c,
> +	.mnd_width = 0,
> +	.hid_width = 5,
> +	.parent_map = gpu_cc_parent_map_1,
> +	.freq_tbl = ftbl_gpu_cc_gx_gfx3d_clk_src,
> +	.clkr.hw.init = &(struct clk_init_data){
> +		.name = "gpu_cc_gx_gfx3d_clk_src",
> +		.parent_data = gpu_cc_parent_data_1,
> +		.num_parents = ARRAY_SIZE(gpu_cc_parent_data_1),
> +		.flags = CLK_SET_RATE_PARENT | CLK_OPS_PARENT_ENABLE,
> +		.ops = &clk_rcg2_ops,
> +	},
> +};
> +
> +static struct clk_branch gpu_cc_crc_ahb_clk = {
> +	.halt_reg = 0x107c,
> +	.halt_check = BRANCH_HALT_DELAY,
> +	.clkr = {
> +		.enable_reg = 0x107c,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gpu_cc_crc_ahb_clk",
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gpu_cc_cx_apb_clk = {
> +	.halt_reg = 0x1088,
> +	.halt_check = BRANCH_HALT_DELAY,
> +	.clkr = {
> +		.enable_reg = 0x1088,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gpu_cc_cx_apb_clk",
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gpu_cc_gx_gfx3d_clk = {
> +	.halt_reg = 0x1054,
> +	.halt_check = BRANCH_HALT_SKIP,
> +	.clkr = {
> +		.enable_reg = 0x1054,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gpu_cc_gx_gfx3d_clk",
> +			.parent_hws = (const struct clk_hw*[]) {
> +				&gpu_cc_gx_gfx3d_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gpu_cc_cx_gfx3d_clk = {
> +	.halt_reg = 0x10a4,
> +	.halt_check = BRANCH_HALT_DELAY,
> +	.clkr = {
> +		.enable_reg = 0x10a4,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gpu_cc_cx_gfx3d_clk",
> +			.parent_hws = (const struct clk_hw*[]) {
> +				&gpu_cc_gx_gfx3d_clk.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gpu_cc_cx_gmu_clk = {
> +	.halt_reg = 0x1098,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x1098,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gpu_cc_cx_gmu_clk",
> +			.parent_hws = (const struct clk_hw*[]) {
> +				&gpu_cc_gmu_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gpu_cc_cx_snoc_dvm_clk = {
> +	.halt_reg = 0x108c,
> +	.halt_check = BRANCH_HALT_DELAY,
> +	.clkr = {
> +		.enable_reg = 0x108c,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gpu_cc_cx_snoc_dvm_clk",
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gpu_cc_cxo_aon_clk = {
> +	.halt_reg = 0x1004,
> +	.halt_check = BRANCH_HALT_DELAY,
> +	.clkr = {
> +		.enable_reg = 0x1004,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gpu_cc_cxo_aon_clk",
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gpu_cc_cxo_clk = {
> +	.halt_reg = 0x109c,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x109c,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gpu_cc_cxo_clk",
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gpu_cc_sleep_clk = {
> +	.halt_reg = 0x1090,
> +	.halt_check = BRANCH_HALT_DELAY,
> +	.clkr = {
> +		.enable_reg = 0x1090,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gpu_cc_sleep_clk",
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gpu_cc_ahb_clk = {
> +	.halt_reg = 0x1078,
> +	.halt_check = BRANCH_HALT_DELAY,
> +	.clkr = {
> +		.enable_reg = 0x1078,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gpu_cc_ahb_clk",
> +			.flags = CLK_IS_CRITICAL,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gpu_cc_hlos1_vote_gpu_smmu_clk = {
> +	.halt_reg = 0x5000,
> +	.halt_check = BRANCH_VOTED,
> +	.clkr = {
> +		.enable_reg = 0x5000,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gpu_cc_hlos1_vote_gpu_smmu_clk",
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct gdsc gpu_cx_gdsc = {
> +	.gdscr = 0x106c,
> +	.gds_hw_ctrl = 0x1540,
> +	.pd = {
> +		.name = "gpu_cx_gdsc",
> +	},
> +	.pwrsts = PWRSTS_OFF_ON,
> +	.flags = VOTABLE,
> +};
> +
> +static struct gdsc gpu_gx_gdsc = {
> +	.gdscr = 0x100c,
> +	.pd = {
> +		.name = "gpu_gx_gdsc",
> +	},
> +	.pwrsts = PWRSTS_OFF_ON,
> +	.flags = VOTABLE,
> +};
> +
> +static struct clk_regmap *gpu_cc_sm6125_clocks[] = {
> +	[GPU_CC_CRC_AHB_CLK] = &gpu_cc_crc_ahb_clk.clkr,
> +	[GPU_CC_CX_APB_CLK] = &gpu_cc_cx_apb_clk.clkr,
> +	[GPU_CC_CX_GFX3D_CLK] = &gpu_cc_cx_gfx3d_clk.clkr,
> +	[GPU_CC_CX_GMU_CLK] = &gpu_cc_cx_gmu_clk.clkr,
> +	[GPU_CC_CX_SNOC_DVM_CLK] = &gpu_cc_cx_snoc_dvm_clk.clkr,
> +	[GPU_CC_CXO_AON_CLK] = &gpu_cc_cxo_aon_clk.clkr,
> +	[GPU_CC_CXO_CLK] = &gpu_cc_cxo_clk.clkr,
> +	[GPU_CC_GMU_CLK_SRC] = &gpu_cc_gmu_clk_src.clkr,
> +	[GPU_CC_PLL0_OUT_AUX2] = &gpu_cc_pll0_out_aux2.clkr,
> +	[GPU_CC_PLL1_OUT_AUX2] = &gpu_cc_pll1_out_aux2.clkr,
> +	[GPU_CC_SLEEP_CLK] = &gpu_cc_sleep_clk.clkr,
> +	[GPU_CC_GX_GFX3D_CLK] = &gpu_cc_gx_gfx3d_clk.clkr,
> +	[GPU_CC_GX_GFX3D_CLK_SRC] = &gpu_cc_gx_gfx3d_clk_src.clkr,
> +	[GPU_CC_AHB_CLK] = &gpu_cc_ahb_clk.clkr,
> +	[GPU_CC_HLOS1_VOTE_GPU_SMMU_CLK] = &gpu_cc_hlos1_vote_gpu_smmu_clk.clkr,
> +};
> +
> +static struct gdsc *gpucc_sm6125_gdscs[] = {
> +	[GPU_CX_GDSC] = &gpu_cx_gdsc,
> +	[GPU_GX_GDSC] = &gpu_gx_gdsc,
> +};
> +
> +static const struct regmap_config gpu_cc_sm6125_regmap_config = {
> +	.reg_bits = 32,
> +	.reg_stride = 4,
> +	.val_bits = 32,
> +	.max_register = 0x9000,
> +	.fast_io = true,
> +};
> +
> +static const struct qcom_cc_desc gpu_cc_sm6125_desc = {
> +	.config = &gpu_cc_sm6125_regmap_config,
> +	.clks = gpu_cc_sm6125_clocks,
> +	.num_clks = ARRAY_SIZE(gpu_cc_sm6125_clocks),
> +	.gdscs = gpucc_sm6125_gdscs,
> +	.num_gdscs = ARRAY_SIZE(gpucc_sm6125_gdscs),
> +};
> +
> +static const struct of_device_id gpu_cc_sm6125_match_table[] = {
> +	{ .compatible = "qcom,sm6125-gpucc" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, gpu_cc_sm6125_match_table);
> +
> +static int gpu_cc_sm6125_probe(struct platform_device *pdev)
> +{
> +	struct regmap *regmap;
> +
> +	regmap = qcom_cc_map(pdev, &gpu_cc_sm6125_desc);
> +	if (IS_ERR(regmap))
> +		return PTR_ERR(regmap);
> +
> +	clk_alpha_pll_configure(&gpu_cc_pll0_out_aux2, regmap, &gpu_pll0_config);
> +	clk_alpha_pll_configure(&gpu_cc_pll1_out_aux2, regmap, &gpu_pll1_config);
> +
> +	/* Set recommended WAKEUP/SLEEP settings for the gpu_cc_cx_gmu_clk */
> +	regmap_update_bits(regmap, gpu_cc_cx_gmu_clk.clkr.enable_reg, CBCR_WAKEUP, 0xf);
> +	regmap_update_bits(regmap, gpu_cc_cx_gmu_clk.clkr.enable_reg, CBCR_SLEEP, 0xf);

I think you have to use FIELD_PREP here. regmap_update_bits doesn't 
shift the value according to the mask, does it?

> +
> +	qcom_branch_set_force_mem_core(regmap, gpu_cc_gx_gfx3d_clk.halt_reg, true);
> +	qcom_branch_set_force_periph_on(regmap, gpu_cc_gx_gfx3d_clk.halt_reg, true);
> +
> +	return qcom_cc_really_probe(pdev, &gpu_cc_sm6125_desc, regmap);
> +}
> +
> +static struct platform_driver gpu_cc_sm6125_driver = {
> +	.probe = gpu_cc_sm6125_probe,
> +	.driver = {
> +		.name = "gpucc-sm6125",
> +		.of_match_table = gpu_cc_sm6125_match_table,
> +	},
> +};
> +module_platform_driver(gpu_cc_sm6125_driver);
> +
> +MODULE_DESCRIPTION("QTI GPUCC SM6125 Driver");
> +MODULE_LICENSE("GPL");

-- 
With best wishes
Dmitry

