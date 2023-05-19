Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3990870A30D
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 01:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbjESXBZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 19:01:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjESXBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 19:01:22 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0E21E6
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 16:01:19 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2af1c884b08so17303511fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 16:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684537278; x=1687129278;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A5mH+LjLu05DaMVyXzEO7DlCgS0kkpoiZrRue7UqlJs=;
        b=jEvaEw07yirNRMsVr3wUlAIoriuY2+h3nFTxE265pzxmIpHusTGpA6oub+3WI+NNiS
         5lhjLzE79mLv8y4bms57InO+gfb15flVoQJWDLbGYyu0js3yPT1WbIDDTsOLjvvINRlD
         waqLb548UPnf7dt87ld8UKe7BcTzF50cPzt5oaTZpxX29Krwd1/9lU2p9zPaA+D+d21q
         lnXfbZziYCZyNWvr2UZbj1u+EmvAJBzGuL8xjmbflju8r8+VBThtnG2ygMwtv53BPwgN
         +k6VNWyRpRpiD+0kz+fQ3Gb0Ivh1ZdWFJKRSdQ2RVQOGQzj7eUQmCpVAOM7ocvI9RaeC
         k8Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684537278; x=1687129278;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A5mH+LjLu05DaMVyXzEO7DlCgS0kkpoiZrRue7UqlJs=;
        b=LxgvLJU0jqPInRG4rEjXcsWP5bdW92jiGc/fvfmvgxokIIQnZBy3uU2640uORqD2uj
         ULq1Kn1zqqjiFJMP7LYGWGFLL30B94dTABRhkFeuhaJPPSoPO6VSPE7zVNIKDXeZXgF3
         lcOyMuR4DdsqE6s6ZInjHUOAueRQ5nacv8rIlZ4F447U6mHZWqjdDvJDeXzizqCBQsqz
         iTJuaTUZFPFZ2uuXklu1pDJbFW/RZr9qJxMBmnuwjutUT0bEmxz/RJ8RvQQzRnOaOE9Z
         0LuRlfHrwUCR7RWpOyxY87hDi6kSCbcI5RFspMK4VfVd5ydYvmitokOvSvzs4alZqGk4
         5crQ==
X-Gm-Message-State: AC+VfDyZDElS0Y1UsWWsbIpxz0328zL17+93tuo1lW+vo3Pi/MBlB5Nq
        qwpow0a1Zz65C1L8NO25xmtUYw==
X-Google-Smtp-Source: ACHHUZ581GiwkEl1Cxj+euzkZScVMLH3+JGth1FzZXnLQeSutF3L3NN0FC18W2Rq7u1Rrs24tdYszA==
X-Received: by 2002:a05:651c:1693:b0:2af:2094:acdd with SMTP id bd19-20020a05651c169300b002af2094acddmr1190604ljb.14.1684537277603;
        Fri, 19 May 2023 16:01:17 -0700 (PDT)
Received: from [192.168.1.101] (abxi58.neoplus.adsl.tpnet.pl. [83.9.2.58])
        by smtp.gmail.com with ESMTPSA id s13-20020a2e98cd000000b002adb60e46d3sm32085ljj.81.2023.05.19.16.01.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 May 2023 16:01:12 -0700 (PDT)
Message-ID: <31b311d7-7150-fe4c-1851-a9372878603c@linaro.org>
Date:   Sat, 20 May 2023 01:01:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/3] clk: qcom: gpucc-sm8550: Add support for graphics
 clock controller
Content-Language: en-US
To:     Jagadeesh Kona <quic_jkona@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Satya Priya Kakitapalli <quic_skakitap@quicinc.com>,
        Taniya Das <quic_tdas@quicinc.com>
References: <20230519213656.26089-1-quic_jkona@quicinc.com>
 <20230519213656.26089-3-quic_jkona@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230519213656.26089-3-quic_jkona@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19.05.2023 23:36, Jagadeesh Kona wrote:
> Add support for gpucc driver on SM8550, which provides clocks for the
> graphics subsystem.
> 
> Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
> Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
> ---
Looks like we did some duplicate work..

Please diff it against my take on the driver and check any discrepancies.

https://github.com/SoMainline/linux/commit/74320ee22f200fb21a8dbfc65aa55cf454825158


I also reused 8450 GPUCC (which I sent recently and is likely to get in)
bindings, you may wish to do something similar.

https://github.com/SoMainline/linux/commit/aabc4357c975f288add8b9dfa7601c5aa36f2798

Konrad
>  drivers/clk/qcom/Kconfig        |   8 +
>  drivers/clk/qcom/Makefile       |   1 +
>  drivers/clk/qcom/gpucc-sm8550.c | 609 ++++++++++++++++++++++++++++++++
>  3 files changed, 618 insertions(+)
>  create mode 100644 drivers/clk/qcom/gpucc-sm8550.c
> 
> diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
> index 6bb9b4aff047..b730dd9ed6b1 100644
> --- a/drivers/clk/qcom/Kconfig
> +++ b/drivers/clk/qcom/Kconfig
> @@ -900,6 +900,14 @@ config SM_GPUCC_8350
>  	  Say Y if you want to support graphics controller devices and
>  	  functionality such as 3D graphics.
>  
> +config SM_GPUCC_8550
> +	tristate "SM8550 Graphics Clock Controller"
> +	select SM_GCC_8550
> +	help
> +	  Support for the graphics clock controller on SM8550 devices.
> +	  Say Y if you want to support graphics controller devices and
> +	  functionality such as 3D graphics.
> +
>  config SM_TCSRCC_8550
>  	tristate "SM8550 TCSR Clock Controller"
>  	select QCOM_GDSC
> diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
> index f0b95fc217aa..3090cc6e4bad 100644
> --- a/drivers/clk/qcom/Makefile
> +++ b/drivers/clk/qcom/Makefile
> @@ -124,6 +124,7 @@ obj-$(CONFIG_SM_GPUCC_6375) += gpucc-sm6375.o
>  obj-$(CONFIG_SM_GPUCC_8150) += gpucc-sm8150.o
>  obj-$(CONFIG_SM_GPUCC_8250) += gpucc-sm8250.o
>  obj-$(CONFIG_SM_GPUCC_8350) += gpucc-sm8350.o
> +obj-$(CONFIG_SM_GPUCC_8550) += gpucc-sm8550.o
>  obj-$(CONFIG_SM_TCSRCC_8550) += tcsrcc-sm8550.o
>  obj-$(CONFIG_SM_VIDEOCC_8150) += videocc-sm8150.o
>  obj-$(CONFIG_SM_VIDEOCC_8250) += videocc-sm8250.o
> diff --git a/drivers/clk/qcom/gpucc-sm8550.c b/drivers/clk/qcom/gpucc-sm8550.c
> new file mode 100644
> index 000000000000..d83d89dc3911
> --- /dev/null
> +++ b/drivers/clk/qcom/gpucc-sm8550.c
> @@ -0,0 +1,609 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/regmap.h>
> +
> +#include <dt-bindings/clock/qcom,sm8550-gpucc.h>
> +
> +#include "clk-alpha-pll.h"
> +#include "clk-branch.h"
> +#include "clk-rcg.h"
> +#include "clk-regmap.h"
> +#include "clk-regmap-divider.h"
> +#include "common.h"
> +#include "gdsc.h"
> +#include "reset.h"
> +
> +enum {
> +	DT_BI_TCXO,
> +	DT_GPLL0_OUT_MAIN,
> +	DT_GPLL0_OUT_MAIN_DIV,
> +};
> +
> +enum {
> +	P_BI_TCXO,
> +	P_GPLL0_OUT_MAIN,
> +	P_GPLL0_OUT_MAIN_DIV,
> +	P_GPU_CC_PLL0_OUT_MAIN,
> +	P_GPU_CC_PLL1_OUT_MAIN,
> +};
> +
> +static const struct pll_vco lucid_ole_vco[] = {
> +	{ 249600000, 2300000000, 0 },
> +};
> +
> +static const struct alpha_pll_config gpu_cc_pll0_config = {
> +	.l = 0x4400000d,
> +	.alpha = 0x0,
> +	.config_ctl_val = 0x20485699,
> +	.config_ctl_hi_val = 0x00182261,
> +	.config_ctl_hi1_val = 0x82aa299c,
> +	.test_ctl_val = 0x00000000,
> +	.test_ctl_hi_val = 0x00000003,
> +	.test_ctl_hi1_val = 0x00009000,
> +	.test_ctl_hi2_val = 0x00000034,
> +	.user_ctl_val = 0x00000000,
> +	.user_ctl_hi_val = 0x00000005,
> +};
> +
> +static struct clk_alpha_pll gpu_cc_pll0 = {
> +	.offset = 0x0,
> +	.vco_table = lucid_ole_vco,
> +	.num_vco = ARRAY_SIZE(lucid_ole_vco),
> +	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_LUCID_OLE],
> +	.clkr = {
> +		.hw.init = &(const struct clk_init_data) {
> +			.name = "gpu_cc_pll0",
> +			.parent_data = &(const struct clk_parent_data) {
> +				.index = DT_BI_TCXO,
> +			},
> +			.num_parents = 1,
> +			.ops = &clk_alpha_pll_lucid_ole_ops,
> +		},
> +	},
> +};
> +
> +static const struct alpha_pll_config gpu_cc_pll1_config = {
> +	.l = 0x44000016,
> +	.alpha = 0xeaaa,
> +	.config_ctl_val = 0x20485699,
> +	.config_ctl_hi_val = 0x00182261,
> +	.config_ctl_hi1_val = 0x82aa299c,
> +	.test_ctl_val = 0x00000000,
> +	.test_ctl_hi_val = 0x00000003,
> +	.test_ctl_hi1_val = 0x00009000,
> +	.test_ctl_hi2_val = 0x00000034,
> +	.user_ctl_val = 0x00000000,
> +	.user_ctl_hi_val = 0x00000005,
> +};
> +
> +static struct clk_alpha_pll gpu_cc_pll1 = {
> +	.offset = 0x1000,
> +	.vco_table = lucid_ole_vco,
> +	.num_vco = ARRAY_SIZE(lucid_ole_vco),
> +	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_LUCID_OLE],
> +	.clkr = {
> +		.hw.init = &(const struct clk_init_data) {
> +			.name = "gpu_cc_pll1",
> +			.parent_data = &(const struct clk_parent_data) {
> +				.index = DT_BI_TCXO,
> +			},
> +			.num_parents = 1,
> +			.ops = &clk_alpha_pll_lucid_ole_ops,
> +		},
> +	},
> +};
> +
> +static const struct parent_map gpu_cc_parent_map_0[] = {
> +	{ P_BI_TCXO, 0 },
> +	{ P_GPLL0_OUT_MAIN, 5 },
> +	{ P_GPLL0_OUT_MAIN_DIV, 6 },
> +};
> +
> +static const struct clk_parent_data gpu_cc_parent_data_0[] = {
> +	{ .index = DT_BI_TCXO },
> +	{ .index = DT_GPLL0_OUT_MAIN },
> +	{ .index = DT_GPLL0_OUT_MAIN_DIV },
> +};
> +
> +static const struct parent_map gpu_cc_parent_map_1[] = {
> +	{ P_BI_TCXO, 0 },
> +	{ P_GPU_CC_PLL0_OUT_MAIN, 1 },
> +	{ P_GPU_CC_PLL1_OUT_MAIN, 3 },
> +	{ P_GPLL0_OUT_MAIN, 5 },
> +	{ P_GPLL0_OUT_MAIN_DIV, 6 },
> +};
> +
> +static const struct clk_parent_data gpu_cc_parent_data_1[] = {
> +	{ .index = DT_BI_TCXO },
> +	{ .hw = &gpu_cc_pll0.clkr.hw },
> +	{ .hw = &gpu_cc_pll1.clkr.hw },
> +	{ .index = DT_GPLL0_OUT_MAIN },
> +	{ .index = DT_GPLL0_OUT_MAIN_DIV },
> +};
> +
> +static const struct parent_map gpu_cc_parent_map_2[] = {
> +	{ P_BI_TCXO, 0 },
> +	{ P_GPU_CC_PLL1_OUT_MAIN, 3 },
> +	{ P_GPLL0_OUT_MAIN, 5 },
> +	{ P_GPLL0_OUT_MAIN_DIV, 6 },
> +};
> +
> +static const struct clk_parent_data gpu_cc_parent_data_2[] = {
> +	{ .index = DT_BI_TCXO },
> +	{ .hw = &gpu_cc_pll1.clkr.hw },
> +	{ .index = DT_GPLL0_OUT_MAIN },
> +	{ .index = DT_GPLL0_OUT_MAIN_DIV },
> +};
> +
> +static const struct parent_map gpu_cc_parent_map_3[] = {
> +	{ P_BI_TCXO, 0 },
> +};
> +
> +static const struct clk_parent_data gpu_cc_parent_data_3[] = {
> +	{ .index = DT_BI_TCXO },
> +};
> +
> +static const struct freq_tbl ftbl_gpu_cc_ff_clk_src[] = {
> +	F(200000000, P_GPLL0_OUT_MAIN, 3, 0, 0),
> +	{ }
> +};
> +
> +static struct clk_rcg2 gpu_cc_ff_clk_src = {
> +	.cmd_rcgr = 0x9474,
> +	.mnd_width = 0,
> +	.hid_width = 5,
> +	.parent_map = gpu_cc_parent_map_0,
> +	.freq_tbl = ftbl_gpu_cc_ff_clk_src,
> +	.clkr.hw.init = &(const struct clk_init_data) {
> +		.name = "gpu_cc_ff_clk_src",
> +		.parent_data = gpu_cc_parent_data_0,
> +		.num_parents = ARRAY_SIZE(gpu_cc_parent_data_0),
> +		.flags = CLK_SET_RATE_PARENT,
> +		.ops = &clk_rcg2_shared_ops,
> +	},
> +};
> +
> +static const struct freq_tbl ftbl_gpu_cc_gmu_clk_src[] = {
> +	F(19200000, P_BI_TCXO, 1, 0, 0),
> +	F(220000000, P_GPU_CC_PLL1_OUT_MAIN, 2, 0, 0),
> +	F(550000000, P_GPU_CC_PLL1_OUT_MAIN, 2, 0, 0),
> +	{ }
> +};
> +
> +static struct clk_rcg2 gpu_cc_gmu_clk_src = {
> +	.cmd_rcgr = 0x9318,
> +	.mnd_width = 0,
> +	.hid_width = 5,
> +	.parent_map = gpu_cc_parent_map_1,
> +	.freq_tbl = ftbl_gpu_cc_gmu_clk_src,
> +	.clkr.hw.init = &(const struct clk_init_data) {
> +		.name = "gpu_cc_gmu_clk_src",
> +		.parent_data = gpu_cc_parent_data_1,
> +		.num_parents = ARRAY_SIZE(gpu_cc_parent_data_1),
> +		.flags = CLK_SET_RATE_PARENT,
> +		.ops = &clk_rcg2_shared_ops,
> +	},
> +};
> +
> +static const struct freq_tbl ftbl_gpu_cc_hub_clk_src[] = {
> +	F(200000000, P_GPLL0_OUT_MAIN, 3, 0, 0),
> +	F(300000000, P_GPLL0_OUT_MAIN, 2, 0, 0),
> +	F(400000000, P_GPLL0_OUT_MAIN, 1.5, 0, 0),
> +	{ }
> +};
> +
> +static struct clk_rcg2 gpu_cc_hub_clk_src = {
> +	.cmd_rcgr = 0x93ec,
> +	.mnd_width = 0,
> +	.hid_width = 5,
> +	.parent_map = gpu_cc_parent_map_2,
> +	.freq_tbl = ftbl_gpu_cc_hub_clk_src,
> +	.clkr.hw.init = &(const struct clk_init_data) {
> +		.name = "gpu_cc_hub_clk_src",
> +		.parent_data = gpu_cc_parent_data_2,
> +		.num_parents = ARRAY_SIZE(gpu_cc_parent_data_2),
> +		.flags = CLK_SET_RATE_PARENT,
> +		.ops = &clk_rcg2_shared_ops,
> +	},
> +};
> +
> +static const struct freq_tbl ftbl_gpu_cc_xo_clk_src[] = {
> +	F(19200000, P_BI_TCXO, 1, 0, 0),
> +	{ }
> +};
> +
> +static struct clk_rcg2 gpu_cc_xo_clk_src = {
> +	.cmd_rcgr = 0x9010,
> +	.mnd_width = 0,
> +	.hid_width = 5,
> +	.parent_map = gpu_cc_parent_map_3,
> +	.freq_tbl = ftbl_gpu_cc_xo_clk_src,
> +	.clkr.hw.init = &(const struct clk_init_data) {
> +		.name = "gpu_cc_xo_clk_src",
> +		.parent_data = gpu_cc_parent_data_3,
> +		.num_parents = ARRAY_SIZE(gpu_cc_parent_data_3),
> +		.flags = CLK_SET_RATE_PARENT,
> +		.ops = &clk_rcg2_shared_ops,
> +	},
> +};
> +
> +static struct clk_regmap_div gpu_cc_demet_div_clk_src = {
> +	.reg = 0x9054,
> +	.shift = 0,
> +	.width = 4,
> +	.clkr.hw.init = &(const struct clk_init_data) {
> +		.name = "gpu_cc_demet_div_clk_src",
> +		.parent_hws = (const struct clk_hw*[]) {
> +			&gpu_cc_xo_clk_src.clkr.hw,
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +		.ops = &clk_regmap_div_ro_ops,
> +	},
> +};
> +
> +static struct clk_regmap_div gpu_cc_xo_div_clk_src = {
> +	.reg = 0x9050,
> +	.shift = 0,
> +	.width = 4,
> +	.clkr.hw.init = &(const struct clk_init_data) {
> +		.name = "gpu_cc_xo_div_clk_src",
> +		.parent_hws = (const struct clk_hw*[]) {
> +			&gpu_cc_xo_clk_src.clkr.hw,
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +		.ops = &clk_regmap_div_ro_ops,
> +	},
> +};
> +
> +static struct clk_branch gpu_cc_ahb_clk = {
> +	.halt_reg = 0x911c,
> +	.halt_check = BRANCH_HALT_DELAY,
> +	.clkr = {
> +		.enable_reg = 0x911c,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(const struct clk_init_data) {
> +			.name = "gpu_cc_ahb_clk",
> +			.parent_hws = (const struct clk_hw*[]) {
> +				&gpu_cc_hub_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gpu_cc_crc_ahb_clk = {
> +	.halt_reg = 0x9120,
> +	.halt_check = BRANCH_HALT_VOTED,
> +	.clkr = {
> +		.enable_reg = 0x9120,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(const struct clk_init_data) {
> +			.name = "gpu_cc_crc_ahb_clk",
> +			.parent_hws = (const struct clk_hw*[]) {
> +				&gpu_cc_hub_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gpu_cc_cx_ff_clk = {
> +	.halt_reg = 0x914c,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x914c,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(const struct clk_init_data) {
> +			.name = "gpu_cc_cx_ff_clk",
> +			.parent_hws = (const struct clk_hw*[]) {
> +				&gpu_cc_ff_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gpu_cc_cx_gmu_clk = {
> +	.halt_reg = 0x913c,
> +	.halt_check = BRANCH_HALT_VOTED,
> +	.clkr = {
> +		.enable_reg = 0x913c,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(const struct clk_init_data) {
> +			.name = "gpu_cc_cx_gmu_clk",
> +			.parent_hws = (const struct clk_hw*[]) {
> +				&gpu_cc_gmu_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_aon_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gpu_cc_cxo_clk = {
> +	.halt_reg = 0x9144,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x9144,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(const struct clk_init_data) {
> +			.name = "gpu_cc_cxo_clk",
> +			.parent_hws = (const struct clk_hw*[]) {
> +				&gpu_cc_xo_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gpu_cc_freq_measure_clk = {
> +	.halt_reg = 0x9008,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x9008,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(const struct clk_init_data) {
> +			.name = "gpu_cc_freq_measure_clk",
> +			.parent_hws = (const struct clk_hw*[]) {
> +				&gpu_cc_xo_div_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gpu_cc_hlos1_vote_gpu_smmu_clk = {
> +	.halt_reg = 0x7000,
> +	.halt_check = BRANCH_HALT_VOTED,
> +	.clkr = {
> +		.enable_reg = 0x7000,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(const struct clk_init_data) {
> +			.name = "gpu_cc_hlos1_vote_gpu_smmu_clk",
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gpu_cc_hub_aon_clk = {
> +	.halt_reg = 0x93e8,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x93e8,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(const struct clk_init_data) {
> +			.name = "gpu_cc_hub_aon_clk",
> +			.parent_hws = (const struct clk_hw*[]) {
> +				&gpu_cc_hub_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_aon_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gpu_cc_hub_cx_int_clk = {
> +	.halt_reg = 0x9148,
> +	.halt_check = BRANCH_HALT_VOTED,
> +	.clkr = {
> +		.enable_reg = 0x9148,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(const struct clk_init_data) {
> +			.name = "gpu_cc_hub_cx_int_clk",
> +			.parent_hws = (const struct clk_hw*[]) {
> +				&gpu_cc_hub_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_aon_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gpu_cc_memnoc_gfx_clk = {
> +	.halt_reg = 0x9150,
> +	.halt_check = BRANCH_HALT_VOTED,
> +	.clkr = {
> +		.enable_reg = 0x9150,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(const struct clk_init_data) {
> +			.name = "gpu_cc_memnoc_gfx_clk",
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gpu_cc_mnd1x_0_gfx3d_clk = {
> +	.halt_reg = 0x9288,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x9288,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(const struct clk_init_data) {
> +			.name = "gpu_cc_mnd1x_0_gfx3d_clk",
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gpu_cc_mnd1x_1_gfx3d_clk = {
> +	.halt_reg = 0x928c,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x928c,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(const struct clk_init_data) {
> +			.name = "gpu_cc_mnd1x_1_gfx3d_clk",
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gpu_cc_sleep_clk = {
> +	.halt_reg = 0x9134,
> +	.halt_check = BRANCH_HALT_VOTED,
> +	.clkr = {
> +		.enable_reg = 0x9134,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(const struct clk_init_data) {
> +			.name = "gpu_cc_sleep_clk",
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct gdsc gpu_cc_cx_gdsc = {
> +	.gdscr = 0x9108,
> +	.gds_hw_ctrl = 0x953c,
> +	.en_rest_wait_val = 0x2,
> +	.en_few_wait_val = 0x2,
> +	.clk_dis_wait_val = 0xf,
> +	.pd = {
> +		.name = "gpu_cc_cx_gdsc",
> +	},
> +	.pwrsts = PWRSTS_OFF_ON,
> +	.flags = RETAIN_FF_ENABLE | VOTABLE,
> +};
> +
> +static struct gdsc gpu_cc_gx_gdsc = {
> +	.gdscr = 0x905c,
> +	.clamp_io_ctrl = 0x9504,
> +	.en_rest_wait_val = 0x2,
> +	.en_few_wait_val = 0x2,
> +	.clk_dis_wait_val = 0xf,
> +	.pd = {
> +		.name = "gpu_cc_gx_gdsc",
> +		.power_on = gdsc_gx_do_nothing_enable,
> +	},
> +	.pwrsts = PWRSTS_OFF_ON,
> +	.flags = CLAMP_IO | POLL_CFG_GDSCR | RETAIN_FF_ENABLE,
> +};
> +
> +static struct clk_regmap *gpu_cc_sm8550_clocks[] = {
> +	[GPU_CC_AHB_CLK] = &gpu_cc_ahb_clk.clkr,
> +	[GPU_CC_CRC_AHB_CLK] = &gpu_cc_crc_ahb_clk.clkr,
> +	[GPU_CC_CX_FF_CLK] = &gpu_cc_cx_ff_clk.clkr,
> +	[GPU_CC_CX_GMU_CLK] = &gpu_cc_cx_gmu_clk.clkr,
> +	[GPU_CC_CXO_CLK] = &gpu_cc_cxo_clk.clkr,
> +	[GPU_CC_DEMET_DIV_CLK_SRC] = &gpu_cc_demet_div_clk_src.clkr,
> +	[GPU_CC_FF_CLK_SRC] = &gpu_cc_ff_clk_src.clkr,
> +	[GPU_CC_FREQ_MEASURE_CLK] = &gpu_cc_freq_measure_clk.clkr,
> +	[GPU_CC_GMU_CLK_SRC] = &gpu_cc_gmu_clk_src.clkr,
> +	[GPU_CC_HLOS1_VOTE_GPU_SMMU_CLK] = &gpu_cc_hlos1_vote_gpu_smmu_clk.clkr,
> +	[GPU_CC_HUB_AON_CLK] = &gpu_cc_hub_aon_clk.clkr,
> +	[GPU_CC_HUB_CLK_SRC] = &gpu_cc_hub_clk_src.clkr,
> +	[GPU_CC_HUB_CX_INT_CLK] = &gpu_cc_hub_cx_int_clk.clkr,
> +	[GPU_CC_MEMNOC_GFX_CLK] = &gpu_cc_memnoc_gfx_clk.clkr,
> +	[GPU_CC_MND1X_0_GFX3D_CLK] = &gpu_cc_mnd1x_0_gfx3d_clk.clkr,
> +	[GPU_CC_MND1X_1_GFX3D_CLK] = &gpu_cc_mnd1x_1_gfx3d_clk.clkr,
> +	[GPU_CC_PLL0] = &gpu_cc_pll0.clkr,
> +	[GPU_CC_PLL1] = &gpu_cc_pll1.clkr,
> +	[GPU_CC_SLEEP_CLK] = &gpu_cc_sleep_clk.clkr,
> +	[GPU_CC_XO_CLK_SRC] = &gpu_cc_xo_clk_src.clkr,
> +	[GPU_CC_XO_DIV_CLK_SRC] = &gpu_cc_xo_div_clk_src.clkr,
> +};
> +
> +static struct gdsc *gpu_cc_sm8550_gdscs[] = {
> +	[GPU_CC_CX_GDSC] = &gpu_cc_cx_gdsc,
> +	[GPU_CC_GX_GDSC] = &gpu_cc_gx_gdsc,
> +};
> +
> +static const struct qcom_reset_map gpu_cc_sm8550_resets[] = {
> +	[GPUCC_GPU_CC_ACD_BCR] = { 0x9358 },
> +	[GPUCC_GPU_CC_CX_BCR] = { 0x9104 },
> +	[GPUCC_GPU_CC_FAST_HUB_BCR] = { 0x93e4 },
> +	[GPUCC_GPU_CC_FF_BCR] = { 0x9470 },
> +	[GPUCC_GPU_CC_GFX3D_AON_BCR] = { 0x9198 },
> +	[GPUCC_GPU_CC_GMU_BCR] = { 0x9314 },
> +	[GPUCC_GPU_CC_GX_BCR] = { 0x9058 },
> +	[GPUCC_GPU_CC_XO_BCR] = { 0x9000 },
> +};
> +
> +static const struct regmap_config gpu_cc_sm8550_regmap_config = {
> +	.reg_bits = 32,
> +	.reg_stride = 4,
> +	.val_bits = 32,
> +	.max_register = 0x9988,
> +	.fast_io = true,
> +};
> +
> +static const struct qcom_cc_desc gpu_cc_sm8550_desc = {
> +	.config = &gpu_cc_sm8550_regmap_config,
> +	.clks = gpu_cc_sm8550_clocks,
> +	.num_clks = ARRAY_SIZE(gpu_cc_sm8550_clocks),
> +	.resets = gpu_cc_sm8550_resets,
> +	.num_resets = ARRAY_SIZE(gpu_cc_sm8550_resets),
> +	.gdscs = gpu_cc_sm8550_gdscs,
> +	.num_gdscs = ARRAY_SIZE(gpu_cc_sm8550_gdscs),
> +};
> +
> +static const struct of_device_id gpu_cc_sm8550_match_table[] = {
> +	{ .compatible = "qcom,sm8550-gpucc" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, gpu_cc_sm8550_match_table);
> +
> +static int gpu_cc_sm8550_probe(struct platform_device *pdev)
> +{
> +	struct regmap *regmap;
> +
> +	regmap = qcom_cc_map(pdev, &gpu_cc_sm8550_desc);
> +	if (IS_ERR(regmap))
> +		return PTR_ERR(regmap);
> +
> +	clk_lucid_ole_pll_configure(&gpu_cc_pll0, regmap, &gpu_cc_pll0_config);
> +	clk_lucid_ole_pll_configure(&gpu_cc_pll1, regmap, &gpu_cc_pll1_config);
> +
> +	/*
> +	 * Keep clocks always enabled:
> +	 *	gpu_cc_cxo_aon_clk
> +	 *	gpu_cc_demet_clk
> +	 */
> +	regmap_update_bits(regmap, 0x9004, BIT(0), BIT(0));
> +	regmap_update_bits(regmap, 0x900c, BIT(0), BIT(0));
> +
> +	return qcom_cc_really_probe(pdev, &gpu_cc_sm8550_desc, regmap);
> +}
> +
> +static struct platform_driver gpu_cc_sm8550_driver = {
> +	.probe = gpu_cc_sm8550_probe,
> +	.driver = {
> +		.name = "gpu_cc-sm8550",
> +		.of_match_table = gpu_cc_sm8550_match_table,
> +	},
> +};
> +
> +static int __init gpu_cc_sm8550_init(void)
> +{
> +	return platform_driver_register(&gpu_cc_sm8550_driver);
> +}
> +subsys_initcall(gpu_cc_sm8550_init);
> +
> +static void __exit gpu_cc_sm8550_exit(void)
> +{
> +	platform_driver_unregister(&gpu_cc_sm8550_driver);
> +}
> +module_exit(gpu_cc_sm8550_exit);
> +
> +MODULE_DESCRIPTION("QTI GPU_CC SM8550 Driver");
> +MODULE_LICENSE("GPL");
