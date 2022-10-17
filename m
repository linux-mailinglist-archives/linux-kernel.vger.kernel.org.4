Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11E9D601D61
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 01:11:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231485AbiJQXLY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 19:11:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231467AbiJQXLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 19:11:04 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFF1F844EF
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 16:10:41 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-131dda37dddso15076887fac.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 16:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kali.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zKurE+7ZPRkKH2pmRQtJS49pcn0fF/LsDZ1JLr5UTLQ=;
        b=n9pg94uXZ/zALhZV3/TPRMGdk6gQSWH5c/QeA57KcZYN1gavEJCERTJkgHkYWbSA5e
         GsiSLWJOewBluKKpan/pasWVCcVWhovbaOi25gJChRvH6NCYY/QBbmNh+R04CSmsxOOM
         BiuvfEi8wfnQHiy02j8eGVEVQEMXSlMADiJo1UoRkOQRF68wdo5ikwtaf5veAEd4awkm
         bdjkz0nXoad5RvSdtbHoRzs01SifnZ05bPF6o30ZdVZU7CXUDYSn+wP+py0Mz/6hk8q0
         TCmyxbZ8jIPwqaoq+7vs0pK8eZJHlthOrumK7Si4TJjqazp09otJNCKnLxbXhUCT4puW
         Ea2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zKurE+7ZPRkKH2pmRQtJS49pcn0fF/LsDZ1JLr5UTLQ=;
        b=N4D0BB9o91T09qMPityZtsnewCX1GiCWdPKtvjYsun3C6xXP66aAKIMvBC8Mycq0Sz
         5JotxMrk4Ze0lN7/4uBP5Rlhxnh4Ma5xS/0V84VEXOpXVsIZCaCFUkPJyDM9veVBMe9I
         Wrl8DTXc8fNCIEpThzp/I3JIGDuOK29eGIb2S1p9VKFHi4N42Zthv/sgce6M6vQg+Zlg
         0gJBXLyyEnFQo8YH2OmVBp25TNzEb0a8lo2DZ5txxwPGMdrpzVq8hvw72NcQqe2eyfl7
         nwvdMxVXbWcxVPpSCelcKqcunPBiFhaRCJbp9m51xKxOyKGwX5+VveXaRvfQ4DNtENQb
         sW2A==
X-Gm-Message-State: ACrzQf3//QLaSON7ndGwIr4V+ITd0rx22a4PLKCdORyLbP73c+Yi/A45
        42YwirE5q1oVS+YI+EqOh2td2Q==
X-Google-Smtp-Source: AMsMyM73YSNypD/KzLcpzsSfIcWX1LxxhAG0iy6gkB1Twt0UJRYbECUp6gmlrejB1+dtFQ/k9Kwssw==
X-Received: by 2002:a05:6870:15d4:b0:12b:8d8d:1001 with SMTP id k20-20020a05687015d400b0012b8d8d1001mr44345oad.137.1666048193951;
        Mon, 17 Oct 2022 16:09:53 -0700 (PDT)
Received: from [192.168.11.16] (cpe-173-173-107-246.satx.res.rr.com. [173.173.107.246])
        by smtp.gmail.com with ESMTPSA id l20-20020a0568301d7400b00661a3f4113bsm5203561oti.64.2022.10.17.16.09.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Oct 2022 16:09:53 -0700 (PDT)
Message-ID: <a8bf3887-b4fb-1f60-14e4-998f71b84181@kali.org>
Date:   Mon, 17 Oct 2022 18:09:49 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.1
Subject: Re: [PATCH v2 2/2] clk: qcom: Add SC8280XP display clock controller
Content-Language: en-US
To:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220926203800.16771-1-quic_bjorande@quicinc.com>
 <20220926203800.16771-3-quic_bjorande@quicinc.com>
From:   Steev Klimaszewski <steev@kali.org>
In-Reply-To: <20220926203800.16771-3-quic_bjorande@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,

On 9/26/22 3:38 PM, Bjorn Andersson wrote:
> From: Bjorn Andersson <bjorn.andersson@linaro.org>
>
> The Qualcomm SC8280XP platform has two display clock controller
> instances, add support for these. Duplication between the two
> implementations is reduced by reusing any constant data between the two
> sets of clock data.
>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> ---
>
> Changes since v1:
> - Lowercased hex numbers
> - Changed "DISP CC 0" in error print, to work for second dispcc as well.
>
>   drivers/clk/qcom/Kconfig           |    9 +
>   drivers/clk/qcom/Makefile          |    1 +
>   drivers/clk/qcom/dispcc-sc8280xp.c | 3218 ++++++++++++++++++++++++++++
>   3 files changed, 3228 insertions(+)
>   create mode 100644 drivers/clk/qcom/dispcc-sc8280xp.c
>
> diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
> index 7dddbf7fa5cd..6f249ebf7db4 100644
> --- a/drivers/clk/qcom/Kconfig
> +++ b/drivers/clk/qcom/Kconfig
> @@ -401,6 +401,15 @@ config SC_DISPCC_7280
>   	  Say Y if you want to support display devices and functionality such as
>   	  splash screen.
>   
> +config SC_DISPCC_8280XP
> +	tristate "SC8280XP Display Clock Controller"
> +	select SC_GCC_8280XP
> +	help
> +	  Support for the two display clock controllers on Qualcomm
> +	  Technologies, Inc. SC8280XP devices.
> +	  Say Y if you want to support display devices and functionality such as
> +	  splash screen.
> +
>   config SC_GCC_7180
>   	tristate "SC7180 Global Clock Controller"
>   	select QCOM_GDSC
> diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
> index 70fda7e101fb..702f0b37f35c 100644
> --- a/drivers/clk/qcom/Makefile
> +++ b/drivers/clk/qcom/Makefile
> @@ -66,6 +66,7 @@ obj-$(CONFIG_SC_CAMCC_7180) += camcc-sc7180.o
>   obj-$(CONFIG_SC_CAMCC_7280) += camcc-sc7280.o
>   obj-$(CONFIG_SC_DISPCC_7180) += dispcc-sc7180.o
>   obj-$(CONFIG_SC_DISPCC_7280) += dispcc-sc7280.o
> +obj-$(CONFIG_SC_DISPCC_8280XP) += dispcc-sc8280xp.o
>   obj-$(CONFIG_SC_GCC_7180) += gcc-sc7180.o
>   obj-$(CONFIG_SC_GCC_7280) += gcc-sc7280.o
>   obj-$(CONFIG_SC_GCC_8180X) += gcc-sc8180x.o
> diff --git a/drivers/clk/qcom/dispcc-sc8280xp.c b/drivers/clk/qcom/dispcc-sc8280xp.c
> new file mode 100644
> index 000000000000..417e3f7800dd
> --- /dev/null
> +++ b/drivers/clk/qcom/dispcc-sc8280xp.c
> @@ -0,0 +1,3218 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2021, The Linux Foundation. All rights reserved.
> + * Copyright (c) 2022, Linaro Ltd.
> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/property.h>
> +#include <linux/pm_clock.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/regmap.h>
> +#include <linux/reset-controller.h>
> +
> +#include <dt-bindings/clock/qcom,dispcc-sc8280xp.h>
> +
> +#include "clk-alpha-pll.h"
> +#include "clk-branch.h"
> +#include "clk-rcg.h"
> +#include "clk-regmap-divider.h"
> +#include "common.h"
> +#include "gdsc.h"
> +#include "reset.h"
> +
> +/* Need to match the order of clocks in DT binding */
> +enum {
> +	DT_IFACE,
> +	DT_BI_TCXO,
> +	DT_SLEEP_CLK,
> +	DT_DP0_PHY_PLL_LINK_CLK,
> +	DT_DP0_PHY_PLL_VCO_DIV_CLK,
> +	DT_DP1_PHY_PLL_LINK_CLK,
> +	DT_DP1_PHY_PLL_VCO_DIV_CLK,
> +	DT_DP2_PHY_PLL_LINK_CLK,
> +	DT_DP2_PHY_PLL_VCO_DIV_CLK,
> +	DT_DP3_PHY_PLL_LINK_CLK,
> +	DT_DP3_PHY_PLL_VCO_DIV_CLK,
> +	DT_DSI0_PHY_PLL_OUT_BYTECLK,
> +	DT_DSI0_PHY_PLL_OUT_DSICLK,
> +	DT_DSI1_PHY_PLL_OUT_BYTECLK,
> +	DT_DSI1_PHY_PLL_OUT_DSICLK,
> +};
> +
> +enum {
> +	P_BI_TCXO,
> +	P_DP0_PHY_PLL_LINK_CLK,
> +	P_DP0_PHY_PLL_VCO_DIV_CLK,
> +	P_DP1_PHY_PLL_LINK_CLK,
> +	P_DP1_PHY_PLL_VCO_DIV_CLK,
> +	P_DP2_PHY_PLL_LINK_CLK,
> +	P_DP2_PHY_PLL_VCO_DIV_CLK,
> +	P_DP3_PHY_PLL_LINK_CLK,
> +	P_DP3_PHY_PLL_VCO_DIV_CLK,
> +	P_DSI0_PHY_PLL_OUT_BYTECLK,
> +	P_DSI0_PHY_PLL_OUT_DSICLK,
> +	P_DSI1_PHY_PLL_OUT_BYTECLK,
> +	P_DSI1_PHY_PLL_OUT_DSICLK,
> +	P_DISPn_CC_PLL0_OUT_MAIN,
> +	P_DISPn_CC_PLL1_OUT_EVEN,
> +	P_DISPn_CC_PLL1_OUT_MAIN,
> +	P_DISPn_CC_PLL2_OUT_MAIN,
> +	P_SLEEP_CLK,
> +};
> +
> +static const struct clk_parent_data parent_data_tcxo = { .index = DT_BI_TCXO };
> +
> +static const struct pll_vco lucid_5lpe_vco[] = {
> +	{ 249600000, 1800000000, 0 },
> +};
> +
> +static const struct alpha_pll_config disp_cc_pll0_config = {
> +	.l = 0x4E,
> +	.alpha = 0x2000,
> +	.config_ctl_val = 0x20485699,
> +	.config_ctl_hi_val = 0x00002261,
> +	.config_ctl_hi1_val = 0x2a9a699c,
> +	.test_ctl_val = 0x00000000,
> +	.test_ctl_hi_val = 0x00000000,
> +	.test_ctl_hi1_val = 0x01800000,
> +	.user_ctl_val = 0x00000000,
> +	.user_ctl_hi_val = 0x00000805,
> +	.user_ctl_hi1_val = 0x00000000,
> +};
> +
> +static struct clk_alpha_pll disp0_cc_pll0 = {
> +	.offset = 0x0,
> +	.vco_table = lucid_5lpe_vco,
> +	.num_vco = ARRAY_SIZE(lucid_5lpe_vco),
> +	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_LUCID],
> +	.clkr = {
> +		.hw.init = &(const struct clk_init_data) {
> +			.name = "disp0_cc_pll0",
> +			.parent_data = &parent_data_tcxo,
> +			.num_parents = 1,
> +			.ops = &clk_alpha_pll_lucid_5lpe_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_alpha_pll disp1_cc_pll0 = {
> +	.offset = 0x0,
> +	.vco_table = lucid_5lpe_vco,
> +	.num_vco = ARRAY_SIZE(lucid_5lpe_vco),
> +	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_LUCID],
> +	.clkr = {
> +		.hw.init = &(const struct clk_init_data) {
> +			.name = "disp1_cc_pll0",
> +			.parent_data = &parent_data_tcxo,
> +			.num_parents = 1,
> +			.ops = &clk_alpha_pll_lucid_5lpe_ops,
> +		},
> +	},
> +};
> +
> +static const struct alpha_pll_config disp_cc_pll1_config = {
> +	.l = 0x1F,
> +	.alpha = 0x4000,
> +	.config_ctl_val = 0x20485699,
> +	.config_ctl_hi_val = 0x00002261,
> +	.config_ctl_hi1_val = 0x2a9a699c,
> +	.test_ctl_val = 0x00000000,
> +	.test_ctl_hi_val = 0x00000000,
> +	.test_ctl_hi1_val = 0x01800000,
> +	.user_ctl_val = 0x00000100,
> +	.user_ctl_hi_val = 0x00000805,
> +	.user_ctl_hi1_val = 0x00000000,
> +};
> +
> +static struct clk_alpha_pll disp0_cc_pll1 = {
> +	.offset = 0x1000,
> +	.vco_table = lucid_5lpe_vco,
> +	.num_vco = ARRAY_SIZE(lucid_5lpe_vco),
> +	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_LUCID],
> +	.clkr = {
> +		.hw.init = &(const struct clk_init_data) {
> +			.name = "disp0_cc_pll1",
> +			.parent_data = &parent_data_tcxo,
> +			.num_parents = 1,
> +			.ops = &clk_alpha_pll_lucid_5lpe_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_alpha_pll disp1_cc_pll1 = {
> +	.offset = 0x1000,
> +	.vco_table = lucid_5lpe_vco,
> +	.num_vco = ARRAY_SIZE(lucid_5lpe_vco),
> +	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_LUCID],
> +	.clkr = {
> +		.hw.init = &(const struct clk_init_data) {
> +			.name = "disp1_cc_pll1",
> +			.parent_data = &parent_data_tcxo,
> +			.num_parents = 1,
> +			.ops = &clk_alpha_pll_lucid_5lpe_ops,
> +		},
> +	},
> +};
> +
> +static const struct clk_div_table post_div_table_disp_cc_pll1_out_even[] = {
> +	{ 0x1, 2 },
> +	{ }
> +};
> +
> +static struct clk_alpha_pll_postdiv disp0_cc_pll1_out_even = {
> +	.offset = 0x1000,
> +	.post_div_shift = 8,
> +	.post_div_table = post_div_table_disp_cc_pll1_out_even,
> +	.num_post_div = ARRAY_SIZE(post_div_table_disp_cc_pll1_out_even),
> +	.width = 4,
> +	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_LUCID],
> +	.clkr.hw.init = &(const struct clk_init_data) {
> +		.name = "disp0_cc_pll1_out_even",
> +		.parent_hws = (const struct clk_hw*[]){
> +			&disp0_cc_pll1.clkr.hw,
> +		},
> +		.num_parents = 1,
> +		.ops = &clk_alpha_pll_postdiv_lucid_5lpe_ops,
> +	},
> +};
> +
> +static struct clk_alpha_pll_postdiv disp1_cc_pll1_out_even = {
> +	.offset = 0x1000,
> +	.post_div_shift = 8,
> +	.post_div_table = post_div_table_disp_cc_pll1_out_even,
> +	.num_post_div = ARRAY_SIZE(post_div_table_disp_cc_pll1_out_even),
> +	.width = 4,
> +	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_LUCID],
> +	.clkr.hw.init = &(const struct clk_init_data) {
> +		.name = "disp1_cc_pll1_out_even",
> +		.parent_hws = (const struct clk_hw*[]){
> +			&disp1_cc_pll1.clkr.hw,
> +		},
> +		.num_parents = 1,
> +		.ops = &clk_alpha_pll_postdiv_lucid_5lpe_ops,
> +	},
> +};
> +
> +static const struct alpha_pll_config disp_cc_pll2_config = {
> +	.l = 0x46,
> +	.alpha = 0x5000,
> +	.config_ctl_val = 0x20485699,
> +	.config_ctl_hi_val = 0x00002261,
> +	.config_ctl_hi1_val = 0x2a9a699c,
> +	.test_ctl_val = 0x00000000,
> +	.test_ctl_hi_val = 0x00000000,
> +	.test_ctl_hi1_val = 0x01800000,
> +	.user_ctl_val = 0x00000000,
> +	.user_ctl_hi_val = 0x00000805,
> +	.user_ctl_hi1_val = 0x00000000,
> +};
> +
> +static struct clk_alpha_pll disp0_cc_pll2 = {
> +	.offset = 0x9000,
> +	.vco_table = lucid_5lpe_vco,
> +	.num_vco = ARRAY_SIZE(lucid_5lpe_vco),
> +	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_LUCID],
> +	.clkr = {
> +		.hw.init = &(const struct clk_init_data) {
> +			.name = "disp0_cc_pll2",
> +			.parent_data = &parent_data_tcxo,
> +			.num_parents = 1,
> +			.ops = &clk_alpha_pll_lucid_5lpe_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_alpha_pll disp1_cc_pll2 = {
> +	.offset = 0x9000,
> +	.vco_table = lucid_5lpe_vco,
> +	.num_vco = ARRAY_SIZE(lucid_5lpe_vco),
> +	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_LUCID],
> +	.clkr = {
> +		.hw.init = &(const struct clk_init_data) {
> +			.name = "disp1_cc_pll2",
> +			.parent_data = &parent_data_tcxo,
> +			.num_parents = 1,
> +			.ops = &clk_alpha_pll_lucid_5lpe_ops,
> +		},
> +	},
> +};
> +
> +static const struct parent_map disp_cc_parent_map_0[] = {
> +	{ P_BI_TCXO, 0 },
> +	{ P_DP0_PHY_PLL_LINK_CLK, 1 },
> +	{ P_DP1_PHY_PLL_LINK_CLK, 2 },
> +	{ P_DP2_PHY_PLL_LINK_CLK, 3 },
> +	{ P_DP3_PHY_PLL_LINK_CLK, 4 },
> +	{ P_DISPn_CC_PLL2_OUT_MAIN, 5 },
> +};
> +
> +static const struct clk_parent_data disp0_cc_parent_data_0[] = {
> +	{ .index = DT_BI_TCXO },
> +	{ .index = DT_DP0_PHY_PLL_LINK_CLK },
> +	{ .index = DT_DP1_PHY_PLL_LINK_CLK },
> +	{ .index = DT_DP2_PHY_PLL_LINK_CLK },
> +	{ .index = DT_DP3_PHY_PLL_LINK_CLK },
> +	{ .hw = &disp0_cc_pll2.clkr.hw },
> +};
> +
> +static const struct clk_parent_data disp1_cc_parent_data_0[] = {
> +	{ .index = DT_BI_TCXO },
> +	{ .index = DT_DP0_PHY_PLL_LINK_CLK },
> +	{ .index = DT_DP1_PHY_PLL_LINK_CLK },
> +	{ .index = DT_DP2_PHY_PLL_LINK_CLK },
> +	{ .index = DT_DP3_PHY_PLL_LINK_CLK },
> +	{ .hw = &disp1_cc_pll2.clkr.hw },
> +};
> +
> +static const struct parent_map disp_cc_parent_map_1[] = {
> +	{ P_BI_TCXO, 0 },
> +	{ P_DP0_PHY_PLL_LINK_CLK, 1 },
> +	{ P_DP0_PHY_PLL_VCO_DIV_CLK, 2 },
> +	{ P_DP3_PHY_PLL_VCO_DIV_CLK, 3 },
> +	{ P_DP1_PHY_PLL_VCO_DIV_CLK, 4 },
> +	{ P_DISPn_CC_PLL2_OUT_MAIN, 5 },
> +	{ P_DP2_PHY_PLL_VCO_DIV_CLK, 6 },
> +};
> +
> +static const struct clk_parent_data disp0_cc_parent_data_1[] = {
> +	{ .index = DT_BI_TCXO },
> +	{ .index = DT_DP0_PHY_PLL_LINK_CLK },
> +	{ .index = DT_DP0_PHY_PLL_VCO_DIV_CLK },
> +	{ .index = DT_DP3_PHY_PLL_VCO_DIV_CLK },
> +	{ .index = DT_DP1_PHY_PLL_VCO_DIV_CLK },
> +	{ .hw = &disp0_cc_pll2.clkr.hw },
> +	{ .index = DT_DP2_PHY_PLL_VCO_DIV_CLK },
> +};
> +
> +static const struct clk_parent_data disp1_cc_parent_data_1[] = {
> +	{ .index = DT_BI_TCXO },
> +	{ .index = DT_DP0_PHY_PLL_LINK_CLK },
> +	{ .index = DT_DP0_PHY_PLL_VCO_DIV_CLK },
> +	{ .index = DT_DP3_PHY_PLL_VCO_DIV_CLK },
> +	{ .index = DT_DP1_PHY_PLL_VCO_DIV_CLK },
> +	{ .hw = &disp1_cc_pll2.clkr.hw },
> +	{ .index = DT_DP2_PHY_PLL_VCO_DIV_CLK },
> +};
> +
> +static const struct parent_map disp_cc_parent_map_2[] = {
> +	{ P_BI_TCXO, 0 },
> +};
> +
> +static const struct clk_parent_data disp_cc_parent_data_2[] = {
> +	{ .index = DT_BI_TCXO },
> +};
> +
> +static const struct parent_map disp_cc_parent_map_3[] = {
> +	{ P_BI_TCXO, 0 },
> +	{ P_DSI0_PHY_PLL_OUT_DSICLK, 1 },
> +	{ P_DSI0_PHY_PLL_OUT_BYTECLK, 2 },
> +	{ P_DSI1_PHY_PLL_OUT_DSICLK, 3 },
> +	{ P_DSI1_PHY_PLL_OUT_BYTECLK, 4 },
> +};
> +
> +static const struct clk_parent_data disp_cc_parent_data_3[] = {
> +	{ .index = DT_BI_TCXO },
> +	{ .index = DT_DSI0_PHY_PLL_OUT_DSICLK },
> +	{ .index = DT_DSI0_PHY_PLL_OUT_BYTECLK },
> +	{ .index = DT_DSI1_PHY_PLL_OUT_DSICLK },
> +	{ .index = DT_DSI1_PHY_PLL_OUT_BYTECLK },
> +};
> +
> +static const struct parent_map disp_cc_parent_map_4[] = {
> +	{ P_BI_TCXO, 0 },
> +	{ P_DSI0_PHY_PLL_OUT_BYTECLK, 2 },
> +	{ P_DSI1_PHY_PLL_OUT_BYTECLK, 4 },
> +};
> +
> +static const struct clk_parent_data disp_cc_parent_data_4[] = {
> +	{ .index = DT_BI_TCXO },
> +	{ .index = DT_DSI0_PHY_PLL_OUT_BYTECLK },
> +	{ .index = DT_DSI1_PHY_PLL_OUT_BYTECLK },
> +};
> +
> +static const struct parent_map disp_cc_parent_map_5[] = {
> +	{ P_BI_TCXO, 0 },
> +	{ P_DISPn_CC_PLL0_OUT_MAIN, 1 },
> +	{ P_DISPn_CC_PLL1_OUT_MAIN, 4 },
> +	{ P_DISPn_CC_PLL2_OUT_MAIN, 5 },
> +	{ P_DISPn_CC_PLL1_OUT_EVEN, 6 },
> +};
> +
> +static const struct clk_parent_data disp0_cc_parent_data_5[] = {
> +	{ .index = DT_BI_TCXO },
> +	{ .hw = &disp0_cc_pll0.clkr.hw },
> +	{ .hw = &disp0_cc_pll1.clkr.hw },
> +	{ .hw = &disp0_cc_pll2.clkr.hw },
> +	{ .hw = &disp0_cc_pll1_out_even.clkr.hw },
> +};
> +
> +static const struct clk_parent_data disp1_cc_parent_data_5[] = {
> +	{ .index = DT_BI_TCXO },
> +	{ .hw = &disp1_cc_pll0.clkr.hw },
> +	{ .hw = &disp1_cc_pll1.clkr.hw },
> +	{ .hw = &disp1_cc_pll2.clkr.hw },
> +	{ .hw = &disp1_cc_pll1_out_even.clkr.hw },
> +};
> +
> +static const struct parent_map disp_cc_parent_map_6[] = {
> +	{ P_BI_TCXO, 0 },
> +	{ P_DISPn_CC_PLL1_OUT_MAIN, 4 },
> +	{ P_DISPn_CC_PLL1_OUT_EVEN, 6 },
> +};
> +
> +static const struct clk_parent_data disp0_cc_parent_data_6[] = {
> +	{ .index = DT_BI_TCXO },
> +	{ .hw = &disp0_cc_pll1.clkr.hw },
> +	{ .hw = &disp0_cc_pll1_out_even.clkr.hw },
> +};
> +
> +static const struct clk_parent_data disp1_cc_parent_data_6[] = {
> +	{ .index = DT_BI_TCXO },
> +	{ .hw = &disp1_cc_pll1.clkr.hw },
> +	{ .hw = &disp1_cc_pll1_out_even.clkr.hw },
> +};
> +
> +static const struct parent_map disp_cc_parent_map_7[] = {
> +	{ P_SLEEP_CLK, 0 },
> +};
> +
> +static const struct clk_parent_data disp_cc_parent_data_7[] = {
> +	{ .index = DT_SLEEP_CLK },
> +};
> +
> +static const struct freq_tbl ftbl_disp_cc_mdss_ahb_clk_src[] = {
> +	F(19200000, P_BI_TCXO, 1, 0, 0),
> +	F(37500000, P_DISPn_CC_PLL1_OUT_EVEN, 8, 0, 0),
> +	F(75000000, P_DISPn_CC_PLL1_OUT_MAIN, 8, 0, 0),
> +	{ }
> +};
> +
> +static struct clk_rcg2 disp0_cc_mdss_ahb_clk_src = {
> +	.cmd_rcgr = 0x2364,
> +	.mnd_width = 0,
> +	.hid_width = 5,
> +	.parent_map = disp_cc_parent_map_6,
> +	.freq_tbl = ftbl_disp_cc_mdss_ahb_clk_src,
> +	.clkr.hw.init = &(const struct clk_init_data) {
> +		.name = "disp0_cc_mdss_ahb_clk_src",
> +		.parent_data = disp0_cc_parent_data_6,
> +		.num_parents = ARRAY_SIZE(disp0_cc_parent_data_6),
> +		.ops = &clk_rcg2_shared_ops,
> +	},
> +};
> +
> +static struct clk_rcg2 disp1_cc_mdss_ahb_clk_src = {
> +	.cmd_rcgr = 0x2364,
> +	.mnd_width = 0,
> +	.hid_width = 5,
> +	.parent_map = disp_cc_parent_map_6,
> +	.freq_tbl = ftbl_disp_cc_mdss_ahb_clk_src,
> +	.clkr.hw.init = &(const struct clk_init_data) {
> +		.name = "disp1_cc_mdss_ahb_clk_src",
> +		.parent_data = disp1_cc_parent_data_6,
> +		.num_parents = ARRAY_SIZE(disp1_cc_parent_data_6),
> +		.ops = &clk_rcg2_shared_ops,
> +	},
> +};
> +
> +static const struct freq_tbl ftbl_disp_cc_mdss_byte0_clk_src[] = {
> +	F(19200000, P_BI_TCXO, 1, 0, 0),
> +	{ }
> +};
> +
> +static struct clk_rcg2 disp0_cc_mdss_byte0_clk_src = {
> +	.cmd_rcgr = 0x213c,
> +	.mnd_width = 0,
> +	.hid_width = 5,
> +	.parent_map = disp_cc_parent_map_3,
> +	.clkr.hw.init = &(const struct clk_init_data) {
> +		.name = "disp0_cc_mdss_byte0_clk_src",
> +		.parent_data = disp_cc_parent_data_3,
> +		.num_parents = ARRAY_SIZE(disp_cc_parent_data_3),
> +		.flags = CLK_SET_RATE_PARENT,
> +		.ops = &clk_byte2_ops,
> +	},
> +};
> +
> +static struct clk_rcg2 disp1_cc_mdss_byte0_clk_src = {
> +	.cmd_rcgr = 0x213c,
> +	.mnd_width = 0,
> +	.hid_width = 5,
> +	.parent_map = disp_cc_parent_map_3,
> +	.clkr.hw.init = &(const struct clk_init_data) {
> +		.name = "disp1_cc_mdss_byte0_clk_src",
> +		.parent_data = disp_cc_parent_data_3,
> +		.num_parents = ARRAY_SIZE(disp_cc_parent_data_3),
> +		.flags = CLK_SET_RATE_PARENT,
> +		.ops = &clk_byte2_ops,
> +	},
> +};
> +
> +static struct clk_rcg2 disp0_cc_mdss_byte1_clk_src = {
> +	.cmd_rcgr = 0x2158,
> +	.mnd_width = 0,
> +	.hid_width = 5,
> +	.parent_map = disp_cc_parent_map_3,
> +	.clkr.hw.init = &(const struct clk_init_data) {
> +		.name = "disp0_cc_mdss_byte1_clk_src",
> +		.parent_data = disp_cc_parent_data_3,
> +		.num_parents = ARRAY_SIZE(disp_cc_parent_data_3),
> +		.flags = CLK_SET_RATE_PARENT,
> +		.ops = &clk_byte2_ops,
> +	},
> +};
> +
> +static struct clk_rcg2 disp1_cc_mdss_byte1_clk_src = {
> +	.cmd_rcgr = 0x2158,
> +	.mnd_width = 0,
> +	.hid_width = 5,
> +	.parent_map = disp_cc_parent_map_3,
> +	.clkr.hw.init = &(const struct clk_init_data) {
> +		.name = "disp1_cc_mdss_byte1_clk_src",
> +		.parent_data = disp_cc_parent_data_3,
> +		.num_parents = ARRAY_SIZE(disp_cc_parent_data_3),
> +		.flags = CLK_SET_RATE_PARENT,
> +		.ops = &clk_byte2_ops,
> +	},
> +};
> +
> +static struct clk_rcg2 disp0_cc_mdss_dptx0_aux_clk_src = {
> +	.cmd_rcgr = 0x2238,
> +	.mnd_width = 0,
> +	.hid_width = 5,
> +	.parent_map = disp_cc_parent_map_2,
> +	.freq_tbl = ftbl_disp_cc_mdss_byte0_clk_src,
> +	.clkr.hw.init = &(const struct clk_init_data) {
> +		.name = "disp0_cc_mdss_dptx0_aux_clk_src",
> +		.parent_data = disp_cc_parent_data_2,
> +		.num_parents = ARRAY_SIZE(disp_cc_parent_data_2),
> +		.ops = &clk_rcg2_ops,
> +	},
> +};
> +
> +static struct clk_rcg2 disp1_cc_mdss_dptx0_aux_clk_src = {
> +	.cmd_rcgr = 0x2238,
> +	.mnd_width = 0,
> +	.hid_width = 5,
> +	.parent_map = disp_cc_parent_map_2,
> +	.freq_tbl = ftbl_disp_cc_mdss_byte0_clk_src,
> +	.clkr.hw.init = &(const struct clk_init_data) {
> +		.name = "disp1_cc_mdss_dptx0_aux_clk_src",
> +		.parent_data = disp_cc_parent_data_2,
> +		.num_parents = ARRAY_SIZE(disp_cc_parent_data_2),
> +		.ops = &clk_rcg2_ops,
> +	},
> +};
> +
> +static struct clk_rcg2 disp0_cc_mdss_dptx0_link_clk_src = {
> +	.cmd_rcgr = 0x21a4,
> +	.mnd_width = 0,
> +	.hid_width = 5,
> +	.parent_map = disp_cc_parent_map_0,
> +	.clkr.hw.init = &(const struct clk_init_data) {
> +		.name = "disp0_cc_mdss_dptx0_link_clk_src",
> +		.parent_data = disp0_cc_parent_data_0,
> +		.num_parents = ARRAY_SIZE(disp0_cc_parent_data_0),
> +		.flags = CLK_SET_RATE_PARENT,
> +		.ops = &clk_byte2_ops,
> +	},
> +};
> +
> +static struct clk_rcg2 disp1_cc_mdss_dptx0_link_clk_src = {
> +	.cmd_rcgr = 0x21a4,
> +	.mnd_width = 0,
> +	.hid_width = 5,
> +	.parent_map = disp_cc_parent_map_0,
> +	.clkr.hw.init = &(const struct clk_init_data) {
> +		.name = "disp1_cc_mdss_dptx0_link_clk_src",
> +		.parent_data = disp1_cc_parent_data_0,
> +		.num_parents = ARRAY_SIZE(disp1_cc_parent_data_0),
> +		.flags = CLK_SET_RATE_PARENT,
> +		.ops = &clk_byte2_ops,
> +	},
> +};
> +
> +static struct clk_rcg2 disp0_cc_mdss_dptx0_pixel0_clk_src = {
> +	.cmd_rcgr = 0x21d8,
> +	.mnd_width = 16,
> +	.hid_width = 5,
> +	.parent_map = disp_cc_parent_map_1,
> +	.clkr.hw.init = &(const struct clk_init_data) {
> +		.name = "disp0_cc_mdss_dptx0_pixel0_clk_src",
> +		.parent_data = disp0_cc_parent_data_1,
> +		.num_parents = ARRAY_SIZE(disp0_cc_parent_data_1),
> +		.flags = CLK_SET_RATE_PARENT,
> +		.ops = &clk_dp_ops,
> +	},
> +};
> +
> +static struct clk_rcg2 disp1_cc_mdss_dptx0_pixel0_clk_src = {
> +	.cmd_rcgr = 0x21d8,
> +	.mnd_width = 16,
> +	.hid_width = 5,
> +	.parent_map = disp_cc_parent_map_1,
> +	.clkr.hw.init = &(const struct clk_init_data) {
> +		.name = "disp1_cc_mdss_dptx0_pixel0_clk_src",
> +		.parent_data = disp1_cc_parent_data_1,
> +		.num_parents = ARRAY_SIZE(disp1_cc_parent_data_1),
> +		.flags = CLK_SET_RATE_PARENT,
> +		.ops = &clk_dp_ops,
> +	},
> +};
> +
> +static struct clk_rcg2 disp0_cc_mdss_dptx0_pixel1_clk_src = {
> +	.cmd_rcgr = 0x21f0,
> +	.mnd_width = 16,
> +	.hid_width = 5,
> +	.parent_map = disp_cc_parent_map_1,
> +	.clkr.hw.init = &(const struct clk_init_data) {
> +		.name = "disp0_cc_mdss_dptx0_pixel1_clk_src",
> +		.parent_data = disp0_cc_parent_data_1,
> +		.num_parents = ARRAY_SIZE(disp0_cc_parent_data_1),
> +		.flags = CLK_SET_RATE_PARENT,
> +		.ops = &clk_dp_ops,
> +	},
> +};
> +
> +static struct clk_rcg2 disp1_cc_mdss_dptx0_pixel1_clk_src = {
> +	.cmd_rcgr = 0x21f0,
> +	.mnd_width = 16,
> +	.hid_width = 5,
> +	.parent_map = disp_cc_parent_map_1,
> +	.clkr.hw.init = &(const struct clk_init_data) {
> +		.name = "disp1_cc_mdss_dptx0_pixel1_clk_src",
> +		.parent_data = disp1_cc_parent_data_1,
> +		.num_parents = ARRAY_SIZE(disp1_cc_parent_data_1),
> +		.flags = CLK_SET_RATE_PARENT,
> +		.ops = &clk_dp_ops,
> +	},
> +};
> +
> +static struct clk_rcg2 disp0_cc_mdss_dptx1_aux_clk_src = {
> +	.cmd_rcgr = 0x22d0,
> +	.mnd_width = 0,
> +	.hid_width = 5,
> +	.parent_map = disp_cc_parent_map_2,
> +	.freq_tbl = ftbl_disp_cc_mdss_byte0_clk_src,
> +	.clkr.hw.init = &(const struct clk_init_data) {
> +		.name = "disp0_cc_mdss_dptx1_aux_clk_src",
> +		.parent_data = disp_cc_parent_data_2,
> +		.num_parents = ARRAY_SIZE(disp_cc_parent_data_2),
> +		.ops = &clk_rcg2_ops,
> +	},
> +};
> +
> +static struct clk_rcg2 disp1_cc_mdss_dptx1_aux_clk_src = {
> +	.cmd_rcgr = 0x22d0,
> +	.mnd_width = 0,
> +	.hid_width = 5,
> +	.parent_map = disp_cc_parent_map_2,
> +	.freq_tbl = ftbl_disp_cc_mdss_byte0_clk_src,
> +	.clkr.hw.init = &(const struct clk_init_data) {
> +		.name = "disp1_cc_mdss_dptx1_aux_clk_src",
> +		.parent_data = disp_cc_parent_data_2,
> +		.num_parents = ARRAY_SIZE(disp_cc_parent_data_2),
> +		.ops = &clk_rcg2_ops,
> +	},
> +};
> +
> +static struct clk_rcg2 disp0_cc_mdss_dptx1_link_clk_src = {
> +	.cmd_rcgr = 0x2268,
> +	.mnd_width = 0,
> +	.hid_width = 5,
> +	.parent_map = disp_cc_parent_map_0,
> +	.clkr.hw.init = &(const struct clk_init_data) {
> +		.name = "disp0_cc_mdss_dptx1_link_clk_src",
> +		.parent_data = disp0_cc_parent_data_0,
> +		.num_parents = ARRAY_SIZE(disp0_cc_parent_data_0),
> +		.flags = CLK_SET_RATE_PARENT,
> +		.ops = &clk_byte2_ops,
> +	},
> +};
> +
> +static struct clk_rcg2 disp1_cc_mdss_dptx1_link_clk_src = {
> +	.cmd_rcgr = 0x2268,
> +	.mnd_width = 0,
> +	.hid_width = 5,
> +	.parent_map = disp_cc_parent_map_0,
> +	.clkr.hw.init = &(const struct clk_init_data) {
> +		.name = "disp1_cc_mdss_dptx1_link_clk_src",
> +		.parent_data = disp1_cc_parent_data_0,
> +		.num_parents = ARRAY_SIZE(disp1_cc_parent_data_0),
> +		.flags = CLK_SET_RATE_PARENT,
> +		.ops = &clk_byte2_ops,
> +	},
> +};
> +
> +static struct clk_rcg2 disp0_cc_mdss_dptx1_pixel0_clk_src = {
> +	.cmd_rcgr = 0x2250,
> +	.mnd_width = 16,
> +	.hid_width = 5,
> +	.parent_map = disp_cc_parent_map_1,
> +	.clkr.hw.init = &(const struct clk_init_data) {
> +		.name = "disp0_cc_mdss_dptx1_pixel0_clk_src",
> +		.parent_data = disp0_cc_parent_data_1,
> +		.num_parents = ARRAY_SIZE(disp0_cc_parent_data_1),
> +		.flags = CLK_SET_RATE_PARENT,
> +		.ops = &clk_dp_ops,
> +	},
> +};
> +
> +static struct clk_rcg2 disp1_cc_mdss_dptx1_pixel0_clk_src = {
> +	.cmd_rcgr = 0x2250,
> +	.mnd_width = 16,
> +	.hid_width = 5,
> +	.parent_map = disp_cc_parent_map_1,
> +	.clkr.hw.init = &(const struct clk_init_data) {
> +		.name = "disp1_cc_mdss_dptx1_pixel0_clk_src",
> +		.parent_data = disp1_cc_parent_data_1,
> +		.num_parents = ARRAY_SIZE(disp1_cc_parent_data_1),
> +		.flags = CLK_SET_RATE_PARENT,
> +		.ops = &clk_dp_ops,
> +	},
> +};
> +
> +static struct clk_rcg2 disp0_cc_mdss_dptx1_pixel1_clk_src = {
> +	.cmd_rcgr = 0x2370,
> +	.mnd_width = 16,
> +	.hid_width = 5,
> +	.parent_map = disp_cc_parent_map_1,
> +	.clkr.hw.init = &(const struct clk_init_data) {
> +		.name = "disp0_cc_mdss_dptx1_pixel1_clk_src",
> +		.parent_data = disp0_cc_parent_data_1,
> +		.num_parents = ARRAY_SIZE(disp0_cc_parent_data_1),
> +		.flags = CLK_SET_RATE_PARENT,
> +		.ops = &clk_dp_ops,
> +	},
> +};
> +
> +static struct clk_rcg2 disp1_cc_mdss_dptx1_pixel1_clk_src = {
> +	.cmd_rcgr = 0x2370,
> +	.mnd_width = 16,
> +	.hid_width = 5,
> +	.parent_map = disp_cc_parent_map_1,
> +	.clkr.hw.init = &(const struct clk_init_data) {
> +		.name = "disp1_cc_mdss_dptx1_pixel1_clk_src",
> +		.parent_data = disp1_cc_parent_data_1,
> +		.num_parents = ARRAY_SIZE(disp1_cc_parent_data_1),
> +		.flags = CLK_SET_RATE_PARENT,
> +		.ops = &clk_dp_ops,
> +	},
> +};
> +
> +static struct clk_rcg2 disp0_cc_mdss_dptx2_aux_clk_src = {
> +	.cmd_rcgr = 0x22e8,
> +	.mnd_width = 0,
> +	.hid_width = 5,
> +	.parent_map = disp_cc_parent_map_2,
> +	.freq_tbl = ftbl_disp_cc_mdss_byte0_clk_src,
> +	.clkr.hw.init = &(const struct clk_init_data) {
> +		.name = "disp0_cc_mdss_dptx2_aux_clk_src",
> +		.parent_data = disp_cc_parent_data_2,
> +		.num_parents = ARRAY_SIZE(disp_cc_parent_data_2),
> +		.ops = &clk_rcg2_ops,
> +	},
> +};
> +
> +static struct clk_rcg2 disp1_cc_mdss_dptx2_aux_clk_src = {
> +	.cmd_rcgr = 0x22e8,
> +	.mnd_width = 0,
> +	.hid_width = 5,
> +	.parent_map = disp_cc_parent_map_2,
> +	.freq_tbl = ftbl_disp_cc_mdss_byte0_clk_src,
> +	.clkr.hw.init = &(const struct clk_init_data) {
> +		.name = "disp1_cc_mdss_dptx2_aux_clk_src",
> +		.parent_data = disp_cc_parent_data_2,
> +		.num_parents = ARRAY_SIZE(disp_cc_parent_data_2),
> +		.ops = &clk_rcg2_ops,
> +	},
> +};
> +
> +static struct clk_rcg2 disp0_cc_mdss_dptx2_link_clk_src = {
> +	.cmd_rcgr = 0x2284,
> +	.mnd_width = 0,
> +	.hid_width = 5,
> +	.parent_map = disp_cc_parent_map_0,
> +	.clkr.hw.init = &(const struct clk_init_data) {
> +		.name = "disp0_cc_mdss_dptx2_link_clk_src",
> +		.parent_data = disp0_cc_parent_data_0,
> +		.num_parents = ARRAY_SIZE(disp0_cc_parent_data_0),
> +		.flags = CLK_SET_RATE_PARENT,
> +		.ops = &clk_byte2_ops,
> +	},
> +};
> +
> +static struct clk_rcg2 disp1_cc_mdss_dptx2_link_clk_src = {
> +	.cmd_rcgr = 0x2284,
> +	.mnd_width = 0,
> +	.hid_width = 5,
> +	.parent_map = disp_cc_parent_map_0,
> +	.clkr.hw.init = &(const struct clk_init_data) {
> +		.name = "disp1_cc_mdss_dptx2_link_clk_src",
> +		.parent_data = disp1_cc_parent_data_0,
> +		.num_parents = ARRAY_SIZE(disp1_cc_parent_data_0),
> +		.flags = CLK_SET_RATE_PARENT,
> +		.ops = &clk_byte2_ops,
> +	},
> +};
> +
> +static struct clk_rcg2 disp0_cc_mdss_dptx2_pixel0_clk_src = {
> +	.cmd_rcgr = 0x2208,
> +	.mnd_width = 16,
> +	.hid_width = 5,
> +	.parent_map = disp_cc_parent_map_1,
> +	.clkr.hw.init = &(const struct clk_init_data) {
> +		.name = "disp0_cc_mdss_dptx2_pixel0_clk_src",
> +		.parent_data = disp0_cc_parent_data_1,
> +		.num_parents = ARRAY_SIZE(disp0_cc_parent_data_1),
> +		.flags = CLK_SET_RATE_PARENT,
> +		.ops = &clk_dp_ops,
> +	},
> +};
> +
> +static struct clk_rcg2 disp1_cc_mdss_dptx2_pixel0_clk_src = {
> +	.cmd_rcgr = 0x2208,
> +	.mnd_width = 16,
> +	.hid_width = 5,
> +	.parent_map = disp_cc_parent_map_1,
> +	.clkr.hw.init = &(const struct clk_init_data) {
> +		.name = "disp1_cc_mdss_dptx2_pixel0_clk_src",
> +		.parent_data = disp1_cc_parent_data_1,
> +		.num_parents = ARRAY_SIZE(disp1_cc_parent_data_1),
> +		.flags = CLK_SET_RATE_PARENT,
> +		.ops = &clk_dp_ops,
> +	},
> +};
> +
> +static struct clk_rcg2 disp0_cc_mdss_dptx2_pixel1_clk_src = {
> +	.cmd_rcgr = 0x2220,
> +	.mnd_width = 16,
> +	.hid_width = 5,
> +	.parent_map = disp_cc_parent_map_1,
> +	.clkr.hw.init = &(const struct clk_init_data) {
> +		.name = "disp0_cc_mdss_dptx2_pixel1_clk_src",
> +		.parent_data = disp0_cc_parent_data_1,
> +		.num_parents = ARRAY_SIZE(disp0_cc_parent_data_1),
> +		.flags = CLK_SET_RATE_PARENT,
> +		.ops = &clk_dp_ops,
> +	},
> +};
> +
> +static struct clk_rcg2 disp1_cc_mdss_dptx2_pixel1_clk_src = {
> +	.cmd_rcgr = 0x2220,
> +	.mnd_width = 16,
> +	.hid_width = 5,
> +	.parent_map = disp_cc_parent_map_1,
> +	.clkr.hw.init = &(const struct clk_init_data) {
> +		.name = "disp1_cc_mdss_dptx2_pixel1_clk_src",
> +		.parent_data = disp1_cc_parent_data_1,
> +		.num_parents = ARRAY_SIZE(disp1_cc_parent_data_1),
> +		.flags = CLK_SET_RATE_PARENT,
> +		.ops = &clk_dp_ops,
> +	},
> +};
> +
> +static struct clk_rcg2 disp0_cc_mdss_dptx3_aux_clk_src = {
> +	.cmd_rcgr = 0x234c,
> +	.mnd_width = 0,
> +	.hid_width = 5,
> +	.parent_map = disp_cc_parent_map_2,
> +	.freq_tbl = ftbl_disp_cc_mdss_byte0_clk_src,
> +	.clkr.hw.init = &(const struct clk_init_data) {
> +		.name = "disp0_cc_mdss_dptx3_aux_clk_src",
> +		.parent_data = disp_cc_parent_data_2,
> +		.num_parents = ARRAY_SIZE(disp_cc_parent_data_2),
> +		.ops = &clk_rcg2_ops,
> +	},
> +};
> +
> +static struct clk_rcg2 disp1_cc_mdss_dptx3_aux_clk_src = {
> +	.cmd_rcgr = 0x234c,
> +	.mnd_width = 0,
> +	.hid_width = 5,
> +	.parent_map = disp_cc_parent_map_2,
> +	.freq_tbl = ftbl_disp_cc_mdss_byte0_clk_src,
> +	.clkr.hw.init = &(const struct clk_init_data) {
> +		.name = "disp1_cc_mdss_dptx3_aux_clk_src",
> +		.parent_data = disp_cc_parent_data_2,
> +		.num_parents = ARRAY_SIZE(disp_cc_parent_data_2),
> +		.ops = &clk_rcg2_ops,
> +	},
> +};
> +
> +static struct clk_rcg2 disp0_cc_mdss_dptx3_link_clk_src = {
> +	.cmd_rcgr = 0x2318,
> +	.mnd_width = 0,
> +	.hid_width = 5,
> +	.parent_map = disp_cc_parent_map_0,
> +	.clkr.hw.init = &(const struct clk_init_data) {
> +		.name = "disp0_cc_mdss_dptx3_link_clk_src",
> +		.parent_data = disp0_cc_parent_data_0,
> +		.num_parents = ARRAY_SIZE(disp0_cc_parent_data_0),
> +		.flags = CLK_SET_RATE_PARENT,
> +		.ops = &clk_byte2_ops,
> +	},
> +};
> +
> +static struct clk_rcg2 disp1_cc_mdss_dptx3_link_clk_src = {
> +	.cmd_rcgr = 0x2318,
> +	.mnd_width = 0,
> +	.hid_width = 5,
> +	.parent_map = disp_cc_parent_map_0,
> +	.clkr.hw.init = &(const struct clk_init_data) {
> +		.name = "disp1_cc_mdss_dptx3_link_clk_src",
> +		.parent_data = disp1_cc_parent_data_0,
> +		.num_parents = ARRAY_SIZE(disp1_cc_parent_data_0),
> +		.flags = CLK_SET_RATE_PARENT,
> +		.ops = &clk_byte2_ops,
> +	},
> +};
> +
> +static struct clk_rcg2 disp0_cc_mdss_dptx3_pixel0_clk_src = {
> +	.cmd_rcgr = 0x2300,
> +	.mnd_width = 16,
> +	.hid_width = 5,
> +	.parent_map = disp_cc_parent_map_1,
> +	.clkr.hw.init = &(const struct clk_init_data) {
> +		.name = "disp0_cc_mdss_dptx3_pixel0_clk_src",
> +		.parent_data = disp0_cc_parent_data_1,
> +		.num_parents = ARRAY_SIZE(disp0_cc_parent_data_1),
> +		.flags = CLK_SET_RATE_PARENT,
> +		.ops = &clk_dp_ops,
> +	},
> +};
> +
> +static struct clk_rcg2 disp1_cc_mdss_dptx3_pixel0_clk_src = {
> +	.cmd_rcgr = 0x2300,
> +	.mnd_width = 16,
> +	.hid_width = 5,
> +	.parent_map = disp_cc_parent_map_1,
> +	.clkr.hw.init = &(const struct clk_init_data) {
> +		.name = "disp1_cc_mdss_dptx3_pixel0_clk_src",
> +		.parent_data = disp1_cc_parent_data_1,
> +		.num_parents = ARRAY_SIZE(disp1_cc_parent_data_1),
> +		.flags = CLK_SET_RATE_PARENT,
> +		.ops = &clk_dp_ops,
> +	},
> +};
> +
> +static struct clk_rcg2 disp0_cc_mdss_esc0_clk_src = {
> +	.cmd_rcgr = 0x2174,
> +	.mnd_width = 0,
> +	.hid_width = 5,
> +	.parent_map = disp_cc_parent_map_4,
> +	.freq_tbl = ftbl_disp_cc_mdss_byte0_clk_src,
> +	.clkr.hw.init = &(const struct clk_init_data) {
> +		.name = "disp0_cc_mdss_esc0_clk_src",
> +		.parent_data = disp_cc_parent_data_4,
> +		.num_parents = ARRAY_SIZE(disp_cc_parent_data_4),
> +		.ops = &clk_rcg2_ops,
> +	},
> +};
> +
> +static struct clk_rcg2 disp1_cc_mdss_esc0_clk_src = {
> +	.cmd_rcgr = 0x2174,
> +	.mnd_width = 0,
> +	.hid_width = 5,
> +	.parent_map = disp_cc_parent_map_4,
> +	.freq_tbl = ftbl_disp_cc_mdss_byte0_clk_src,
> +	.clkr.hw.init = &(const struct clk_init_data) {
> +		.name = "disp1_cc_mdss_esc0_clk_src",
> +		.parent_data = disp_cc_parent_data_4,
> +		.num_parents = ARRAY_SIZE(disp_cc_parent_data_4),
> +		.ops = &clk_rcg2_ops,
> +	},
> +};
> +
> +static struct clk_rcg2 disp0_cc_mdss_esc1_clk_src = {
> +	.cmd_rcgr = 0x218c,
> +	.mnd_width = 0,
> +	.hid_width = 5,
> +	.parent_map = disp_cc_parent_map_4,
> +	.freq_tbl = ftbl_disp_cc_mdss_byte0_clk_src,
> +	.clkr.hw.init = &(const struct clk_init_data) {
> +		.name = "disp0_cc_mdss_esc1_clk_src",
> +		.parent_data = disp_cc_parent_data_4,
> +		.num_parents = ARRAY_SIZE(disp_cc_parent_data_4),
> +		.ops = &clk_rcg2_ops,
> +	},
> +};
> +
> +static struct clk_rcg2 disp1_cc_mdss_esc1_clk_src = {
> +	.cmd_rcgr = 0x218c,
> +	.mnd_width = 0,
> +	.hid_width = 5,
> +	.parent_map = disp_cc_parent_map_4,
> +	.freq_tbl = ftbl_disp_cc_mdss_byte0_clk_src,
> +	.clkr.hw.init = &(const struct clk_init_data) {
> +		.name = "disp1_cc_mdss_esc1_clk_src",
> +		.parent_data = disp_cc_parent_data_4,
> +		.num_parents = ARRAY_SIZE(disp_cc_parent_data_4),
> +		.ops = &clk_rcg2_ops,
> +	},
> +};
> +
> +static const struct freq_tbl ftbl_disp_cc_mdss_mdp_clk_src[] = {
> +	F(19200000, P_BI_TCXO, 1, 0, 0),
> +	F(85714286, P_DISPn_CC_PLL1_OUT_MAIN, 7, 0, 0),
> +	F(100000000, P_DISPn_CC_PLL1_OUT_MAIN, 6, 0, 0),
> +	F(150000000, P_DISPn_CC_PLL1_OUT_MAIN, 4, 0, 0),
> +	F(200000000, P_DISPn_CC_PLL1_OUT_MAIN, 3, 0, 0),
> +	F(300000000, P_DISPn_CC_PLL1_OUT_MAIN, 2, 0, 0),
> +	F(375000000, P_DISPn_CC_PLL0_OUT_MAIN, 4, 0, 0),
> +	F(500000000, P_DISPn_CC_PLL0_OUT_MAIN, 3, 0, 0),
> +	F(600000000, P_DISPn_CC_PLL1_OUT_MAIN, 1, 0, 0),
> +	{ }
> +};
> +
> +static struct clk_rcg2 disp0_cc_mdss_mdp_clk_src = {
> +	.cmd_rcgr = 0x20f4,
> +	.mnd_width = 0,
> +	.hid_width = 5,
> +	.parent_map = disp_cc_parent_map_5,
> +	.freq_tbl = ftbl_disp_cc_mdss_mdp_clk_src,
> +	.clkr.hw.init = &(const struct clk_init_data) {
> +		.name = "disp0_cc_mdss_mdp_clk_src",
> +		.parent_data = disp0_cc_parent_data_5,
> +		.num_parents = ARRAY_SIZE(disp0_cc_parent_data_5),
> +		.ops = &clk_rcg2_shared_ops,
> +	},
> +};
> +
> +static struct clk_rcg2 disp1_cc_mdss_mdp_clk_src = {
> +	.cmd_rcgr = 0x20f4,
> +	.mnd_width = 0,
> +	.hid_width = 5,
> +	.parent_map = disp_cc_parent_map_5,
> +	.freq_tbl = ftbl_disp_cc_mdss_mdp_clk_src,
> +	.clkr.hw.init = &(const struct clk_init_data) {
> +		.name = "disp1_cc_mdss_mdp_clk_src",
> +		.parent_data = disp1_cc_parent_data_5,
> +		.num_parents = ARRAY_SIZE(disp1_cc_parent_data_5),
> +		.ops = &clk_rcg2_shared_ops,
> +	},
> +};
> +
> +static struct clk_rcg2 disp0_cc_mdss_pclk0_clk_src = {
> +	.cmd_rcgr = 0x20c4,
> +	.mnd_width = 8,
> +	.hid_width = 5,
> +	.parent_map = disp_cc_parent_map_3,
> +	.clkr.hw.init = &(const struct clk_init_data) {
> +		.name = "disp0_cc_mdss_pclk0_clk_src",
> +		.parent_data = disp_cc_parent_data_3,
> +		.num_parents = ARRAY_SIZE(disp_cc_parent_data_3),
> +		.flags = CLK_SET_RATE_PARENT,
> +		.ops = &clk_pixel_ops,
> +	},
> +};
> +
> +static struct clk_rcg2 disp1_cc_mdss_pclk0_clk_src = {
> +	.cmd_rcgr = 0x20c4,
> +	.mnd_width = 8,
> +	.hid_width = 5,
> +	.parent_map = disp_cc_parent_map_3,
> +	.clkr.hw.init = &(const struct clk_init_data) {
> +		.name = "disp1_cc_mdss_pclk0_clk_src",
> +		.parent_data = disp_cc_parent_data_3,
> +		.num_parents = ARRAY_SIZE(disp_cc_parent_data_3),
> +		.flags = CLK_SET_RATE_PARENT,
> +		.ops = &clk_pixel_ops,
> +	},
> +};
> +
> +static struct clk_rcg2 disp0_cc_mdss_pclk1_clk_src = {
> +	.cmd_rcgr = 0x20dc,
> +	.mnd_width = 8,
> +	.hid_width = 5,
> +	.parent_map = disp_cc_parent_map_3,
> +	.clkr.hw.init = &(const struct clk_init_data) {
> +		.name = "disp0_cc_mdss_pclk1_clk_src",
> +		.parent_data = disp_cc_parent_data_3,
> +		.num_parents = ARRAY_SIZE(disp_cc_parent_data_3),
> +		.flags = CLK_SET_RATE_PARENT,
> +		.ops = &clk_pixel_ops,
> +	},
> +};
> +
> +static struct clk_rcg2 disp1_cc_mdss_pclk1_clk_src = {
> +	.cmd_rcgr = 0x20dc,
> +	.mnd_width = 8,
> +	.hid_width = 5,
> +	.parent_map = disp_cc_parent_map_3,
> +	.clkr.hw.init = &(const struct clk_init_data) {
> +		.name = "disp1_cc_mdss_pclk1_clk_src",
> +		.parent_data = disp_cc_parent_data_3,
> +		.num_parents = ARRAY_SIZE(disp_cc_parent_data_3),
> +		.flags = CLK_SET_RATE_PARENT,
> +		.ops = &clk_pixel_ops,
> +	},
> +};
> +
> +static const struct freq_tbl ftbl_disp_cc_mdss_rot_clk_src[] = {
> +	F(19200000, P_BI_TCXO, 1, 0, 0),
> +	F(200000000, P_DISPn_CC_PLL1_OUT_MAIN, 3, 0, 0),
> +	F(300000000, P_DISPn_CC_PLL1_OUT_MAIN, 2, 0, 0),
> +	F(375000000, P_DISPn_CC_PLL0_OUT_MAIN, 4, 0, 0),
> +	F(500000000, P_DISPn_CC_PLL0_OUT_MAIN, 3, 0, 0),
> +	F(600000000, P_DISPn_CC_PLL1_OUT_MAIN, 1, 0, 0),
> +	{ }
> +};
> +
> +static struct clk_rcg2 disp0_cc_mdss_rot_clk_src = {
> +	.cmd_rcgr = 0x210c,
> +	.mnd_width = 0,
> +	.hid_width = 5,
> +	.parent_map = disp_cc_parent_map_5,
> +	.freq_tbl = ftbl_disp_cc_mdss_rot_clk_src,
> +	.clkr.hw.init = &(const struct clk_init_data) {
> +		.name = "disp0_cc_mdss_rot_clk_src",
> +		.parent_data = disp0_cc_parent_data_5,
> +		.num_parents = ARRAY_SIZE(disp0_cc_parent_data_5),
> +		.ops = &clk_rcg2_shared_ops,
> +	},
> +};
> +
> +static struct clk_rcg2 disp1_cc_mdss_rot_clk_src = {
> +	.cmd_rcgr = 0x210c,
> +	.mnd_width = 0,
> +	.hid_width = 5,
> +	.parent_map = disp_cc_parent_map_5,
> +	.freq_tbl = ftbl_disp_cc_mdss_rot_clk_src,
> +	.clkr.hw.init = &(const struct clk_init_data) {
> +		.name = "disp1_cc_mdss_rot_clk_src",
> +		.parent_data = disp1_cc_parent_data_5,
> +		.num_parents = ARRAY_SIZE(disp1_cc_parent_data_5),
> +		.ops = &clk_rcg2_shared_ops,
> +	},
> +};
> +
> +static struct clk_rcg2 disp0_cc_mdss_vsync_clk_src = {
> +	.cmd_rcgr = 0x2124,
> +	.mnd_width = 0,
> +	.hid_width = 5,
> +	.parent_map = disp_cc_parent_map_2,
> +	.freq_tbl = ftbl_disp_cc_mdss_byte0_clk_src,
> +	.clkr.hw.init = &(const struct clk_init_data) {
> +		.name = "disp0_cc_mdss_vsync_clk_src",
> +		.parent_data = disp_cc_parent_data_2,
> +		.num_parents = ARRAY_SIZE(disp_cc_parent_data_2),
> +		.ops = &clk_rcg2_ops,
> +	},
> +};
> +
> +static struct clk_rcg2 disp1_cc_mdss_vsync_clk_src = {
> +	.cmd_rcgr = 0x2124,
> +	.mnd_width = 0,
> +	.hid_width = 5,
> +	.parent_map = disp_cc_parent_map_2,
> +	.freq_tbl = ftbl_disp_cc_mdss_byte0_clk_src,
> +	.clkr.hw.init = &(const struct clk_init_data) {
> +		.name = "disp1_cc_mdss_vsync_clk_src",
> +		.parent_data = disp_cc_parent_data_2,
> +		.num_parents = ARRAY_SIZE(disp_cc_parent_data_2),
> +		.ops = &clk_rcg2_ops,
> +	},
> +};
> +
> +static const struct freq_tbl ftbl_disp_cc_sleep_clk_src[] = {
> +	F(32000, P_SLEEP_CLK, 1, 0, 0),
> +	{ }
> +};
> +
> +static struct clk_rcg2 disp0_cc_sleep_clk_src = {
> +	.cmd_rcgr = 0x6060,
> +	.mnd_width = 0,
> +	.hid_width = 5,
> +	.parent_map = disp_cc_parent_map_7,
> +	.freq_tbl = ftbl_disp_cc_sleep_clk_src,
> +	.clkr.hw.init = &(const struct clk_init_data) {
> +		.name = "disp0_cc_sleep_clk_src",
> +		.parent_data = disp_cc_parent_data_7,
> +		.num_parents = ARRAY_SIZE(disp_cc_parent_data_7),
> +		.ops = &clk_rcg2_ops,
> +	},
> +};
> +
> +static struct clk_rcg2 disp1_cc_sleep_clk_src = {
> +	.cmd_rcgr = 0x6060,
> +	.mnd_width = 0,
> +	.hid_width = 5,
> +	.parent_map = disp_cc_parent_map_7,
> +	.freq_tbl = ftbl_disp_cc_sleep_clk_src,
> +	.clkr.hw.init = &(const struct clk_init_data) {
> +		.name = "disp1_cc_sleep_clk_src",
> +		.parent_data = disp_cc_parent_data_7,
> +		.num_parents = ARRAY_SIZE(disp_cc_parent_data_7),
> +		.ops = &clk_rcg2_ops,
> +	},
> +};
> +
> +static struct clk_regmap_div disp0_cc_mdss_byte0_div_clk_src = {
> +	.reg = 0x2154,
> +	.shift = 0,
> +	.width = 4,
> +	.clkr.hw.init = &(const struct clk_init_data) {
> +		.name = "disp0_cc_mdss_byte0_div_clk_src",
> +		.parent_hws = (const struct clk_hw*[]){
> +			&disp0_cc_mdss_byte0_clk_src.clkr.hw,
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +		.ops = &clk_regmap_div_ops,
> +	},
> +};
> +
> +static struct clk_regmap_div disp1_cc_mdss_byte0_div_clk_src = {
> +	.reg = 0x2154,
> +	.shift = 0,
> +	.width = 4,
> +	.clkr.hw.init = &(const struct clk_init_data) {
> +		.name = "disp1_cc_mdss_byte0_div_clk_src",
> +		.parent_hws = (const struct clk_hw*[]){
> +			&disp1_cc_mdss_byte0_clk_src.clkr.hw,
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +		.ops = &clk_regmap_div_ops,
> +	},
> +};
> +
> +static struct clk_regmap_div disp0_cc_mdss_byte1_div_clk_src = {
> +	.reg = 0x2170,
> +	.shift = 0,
> +	.width = 4,
> +	.clkr.hw.init = &(const struct clk_init_data) {
> +		.name = "disp0_cc_mdss_byte1_div_clk_src",
> +		.parent_hws = (const struct clk_hw*[]){
> +			&disp0_cc_mdss_byte1_clk_src.clkr.hw,
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +		.ops = &clk_regmap_div_ops,
> +	},
> +};
> +
> +static struct clk_regmap_div disp1_cc_mdss_byte1_div_clk_src = {
> +	.reg = 0x2170,
> +	.shift = 0,
> +	.width = 4,
> +	.clkr.hw.init = &(const struct clk_init_data) {
> +		.name = "disp1_cc_mdss_byte1_div_clk_src",
> +		.parent_hws = (const struct clk_hw*[]){
> +			&disp1_cc_mdss_byte1_clk_src.clkr.hw,
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +		.ops = &clk_regmap_div_ops,
> +	},
> +};
> +
> +static struct clk_regmap_div disp0_cc_mdss_dptx0_link_div_clk_src = {
> +	.reg = 0x21bc,
> +	.shift = 0,
> +	.width = 4,
> +	.clkr.hw.init = &(const struct clk_init_data) {
> +		.name = "disp0_cc_mdss_dptx0_link_div_clk_src",
> +		.parent_hws = (const struct clk_hw*[]){
> +			&disp0_cc_mdss_dptx0_link_clk_src.clkr.hw,
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +		.ops = &clk_regmap_div_ro_ops,
> +	},
> +};
> +
> +static struct clk_regmap_div disp1_cc_mdss_dptx0_link_div_clk_src = {
> +	.reg = 0x21bc,
> +	.shift = 0,
> +	.width = 4,
> +	.clkr.hw.init = &(const struct clk_init_data) {
> +		.name = "disp1_cc_mdss_dptx0_link_div_clk_src",
> +		.parent_hws = (const struct clk_hw*[]){
> +			&disp1_cc_mdss_dptx0_link_clk_src.clkr.hw,
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +		.ops = &clk_regmap_div_ro_ops,
> +	},
> +};
> +
> +static struct clk_regmap_div disp0_cc_mdss_dptx1_link_div_clk_src = {
> +	.reg = 0x2280,
> +	.shift = 0,
> +	.width = 4,
> +	.clkr.hw.init = &(const struct clk_init_data) {
> +		.name = "disp0_cc_mdss_dptx1_link_div_clk_src",
> +		.parent_hws = (const struct clk_hw*[]){
> +			&disp0_cc_mdss_dptx1_link_clk_src.clkr.hw,
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +		.ops = &clk_regmap_div_ro_ops,
> +	},
> +};
> +
> +static struct clk_regmap_div disp1_cc_mdss_dptx1_link_div_clk_src = {
> +	.reg = 0x2280,
> +	.shift = 0,
> +	.width = 4,
> +	.clkr.hw.init = &(const struct clk_init_data) {
> +		.name = "disp1_cc_mdss_dptx1_link_div_clk_src",
> +		.parent_hws = (const struct clk_hw*[]){
> +			&disp1_cc_mdss_dptx1_link_clk_src.clkr.hw,
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +		.ops = &clk_regmap_div_ro_ops,
> +	},
> +};
> +
> +static struct clk_regmap_div disp0_cc_mdss_dptx2_link_div_clk_src = {
> +	.reg = 0x229c,
> +	.shift = 0,
> +	.width = 4,
> +	.clkr.hw.init = &(const struct clk_init_data) {
> +		.name = "disp0_cc_mdss_dptx2_link_div_clk_src",
> +		.parent_hws = (const struct clk_hw*[]){
> +			&disp0_cc_mdss_dptx2_link_clk_src.clkr.hw,
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +		.ops = &clk_regmap_div_ro_ops,
> +	},
> +};
> +
> +static struct clk_regmap_div disp1_cc_mdss_dptx2_link_div_clk_src = {
> +	.reg = 0x229c,
> +	.shift = 0,
> +	.width = 4,
> +	.clkr.hw.init = &(const struct clk_init_data) {
> +		.name = "disp1_cc_mdss_dptx2_link_div_clk_src",
> +		.parent_hws = (const struct clk_hw*[]){
> +			&disp1_cc_mdss_dptx2_link_clk_src.clkr.hw,
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +		.ops = &clk_regmap_div_ro_ops,
> +	},
> +};
> +
> +static struct clk_regmap_div disp0_cc_mdss_dptx3_link_div_clk_src = {
> +	.reg = 0x2330,
> +	.shift = 0,
> +	.width = 4,
> +	.clkr.hw.init = &(const struct clk_init_data) {
> +		.name = "disp0_cc_mdss_dptx3_link_div_clk_src",
> +		.parent_hws = (const struct clk_hw*[]){
> +			&disp0_cc_mdss_dptx3_link_clk_src.clkr.hw,
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +		.ops = &clk_regmap_div_ro_ops,
> +	},
> +};
> +
> +static struct clk_regmap_div disp1_cc_mdss_dptx3_link_div_clk_src = {
> +	.reg = 0x2330,
> +	.shift = 0,
> +	.width = 4,
> +	.clkr.hw.init = &(const struct clk_init_data) {
> +		.name = "disp1_cc_mdss_dptx3_link_div_clk_src",
> +		.parent_hws = (const struct clk_hw*[]){
> +			&disp1_cc_mdss_dptx3_link_clk_src.clkr.hw,
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +		.ops = &clk_regmap_div_ro_ops,
> +	},
> +};
> +
> +static struct clk_branch disp0_cc_mdss_ahb1_clk = {
> +	.halt_reg = 0x20c0,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x20c0,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(const struct clk_init_data) {
> +			.name = "disp0_cc_mdss_ahb1_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&disp0_cc_mdss_ahb_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch disp1_cc_mdss_ahb1_clk = {
> +	.halt_reg = 0x20c0,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x20c0,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(const struct clk_init_data) {
> +			.name = "disp1_cc_mdss_ahb1_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&disp1_cc_mdss_ahb_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch disp0_cc_mdss_ahb_clk = {
> +	.halt_reg = 0x20bc,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x20bc,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(const struct clk_init_data) {
> +			.name = "disp0_cc_mdss_ahb_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&disp0_cc_mdss_ahb_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch disp1_cc_mdss_ahb_clk = {
> +	.halt_reg = 0x20bc,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x20bc,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(const struct clk_init_data) {
> +			.name = "disp1_cc_mdss_ahb_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&disp1_cc_mdss_ahb_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch disp0_cc_mdss_byte0_clk = {
> +	.halt_reg = 0x2044,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x2044,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(const struct clk_init_data) {
> +			.name = "disp0_cc_mdss_byte0_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&disp0_cc_mdss_byte0_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch disp1_cc_mdss_byte0_clk = {
> +	.halt_reg = 0x2044,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x2044,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(const struct clk_init_data) {
> +			.name = "disp1_cc_mdss_byte0_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&disp1_cc_mdss_byte0_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch disp0_cc_mdss_byte0_intf_clk = {
> +	.halt_reg = 0x2048,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x2048,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(const struct clk_init_data) {
> +			.name = "disp0_cc_mdss_byte0_intf_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&disp0_cc_mdss_byte0_div_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch disp1_cc_mdss_byte0_intf_clk = {
> +	.halt_reg = 0x2048,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x2048,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(const struct clk_init_data) {
> +			.name = "disp1_cc_mdss_byte0_intf_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&disp1_cc_mdss_byte0_div_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch disp0_cc_mdss_byte1_clk = {
> +	.halt_reg = 0x204c,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x204c,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(const struct clk_init_data) {
> +			.name = "disp0_cc_mdss_byte1_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&disp0_cc_mdss_byte1_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch disp1_cc_mdss_byte1_clk = {
> +	.halt_reg = 0x204c,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x204c,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(const struct clk_init_data) {
> +			.name = "disp1_cc_mdss_byte1_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&disp1_cc_mdss_byte1_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch disp0_cc_mdss_byte1_intf_clk = {
> +	.halt_reg = 0x2050,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x2050,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(const struct clk_init_data) {
> +			.name = "disp0_cc_mdss_byte1_intf_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&disp0_cc_mdss_byte1_div_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch disp1_cc_mdss_byte1_intf_clk = {
> +	.halt_reg = 0x2050,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x2050,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(const struct clk_init_data) {
> +			.name = "disp1_cc_mdss_byte1_intf_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&disp1_cc_mdss_byte1_div_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch disp0_cc_mdss_dptx0_aux_clk = {
> +	.halt_reg = 0x206c,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x206c,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(const struct clk_init_data) {
> +			.name = "disp0_cc_mdss_dptx0_aux_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&disp0_cc_mdss_dptx0_aux_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch disp1_cc_mdss_dptx0_aux_clk = {
> +	.halt_reg = 0x206c,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x206c,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(const struct clk_init_data) {
> +			.name = "disp1_cc_mdss_dptx0_aux_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&disp1_cc_mdss_dptx0_aux_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch disp0_cc_mdss_dptx0_link_clk = {
> +	.halt_reg = 0x205c,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x205c,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(const struct clk_init_data) {
> +			.name = "disp0_cc_mdss_dptx0_link_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&disp0_cc_mdss_dptx0_link_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch disp1_cc_mdss_dptx0_link_clk = {
> +	.halt_reg = 0x205c,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x205c,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(const struct clk_init_data) {
> +			.name = "disp1_cc_mdss_dptx0_link_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&disp1_cc_mdss_dptx0_link_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch disp0_cc_mdss_dptx0_link_intf_clk = {
> +	.halt_reg = 0x2060,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x2060,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(const struct clk_init_data) {
> +			.name = "disp0_cc_mdss_dptx0_link_intf_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&disp0_cc_mdss_dptx0_link_div_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch disp1_cc_mdss_dptx0_link_intf_clk = {
> +	.halt_reg = 0x2060,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x2060,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(const struct clk_init_data) {
> +			.name = "disp1_cc_mdss_dptx0_link_intf_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&disp1_cc_mdss_dptx0_link_div_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch disp0_cc_mdss_dptx0_pixel0_clk = {
> +	.halt_reg = 0x2070,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x2070,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(const struct clk_init_data) {
> +			.name = "disp0_cc_mdss_dptx0_pixel0_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&disp0_cc_mdss_dptx0_pixel0_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch disp1_cc_mdss_dptx0_pixel0_clk = {
> +	.halt_reg = 0x2070,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x2070,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(const struct clk_init_data) {
> +			.name = "disp1_cc_mdss_dptx0_pixel0_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&disp1_cc_mdss_dptx0_pixel0_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch disp0_cc_mdss_dptx0_pixel1_clk = {
> +	.halt_reg = 0x2074,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x2074,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(const struct clk_init_data) {
> +			.name = "disp0_cc_mdss_dptx0_pixel1_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&disp0_cc_mdss_dptx0_pixel1_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch disp1_cc_mdss_dptx0_pixel1_clk = {
> +	.halt_reg = 0x2074,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x2074,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(const struct clk_init_data) {
> +			.name = "disp1_cc_mdss_dptx0_pixel1_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&disp1_cc_mdss_dptx0_pixel1_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch disp0_cc_mdss_dptx0_usb_router_link_intf_clk = {
> +	.halt_reg = 0x2064,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x2064,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(const struct clk_init_data) {
> +			.name = "disp0_cc_mdss_dptx0_usb_router_link_intf_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&disp0_cc_mdss_dptx0_link_div_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch disp1_cc_mdss_dptx0_usb_router_link_intf_clk = {
> +	.halt_reg = 0x2064,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x2064,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(const struct clk_init_data) {
> +			.name = "disp1_cc_mdss_dptx0_usb_router_link_intf_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&disp1_cc_mdss_dptx0_link_div_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch disp0_cc_mdss_dptx1_aux_clk = {
> +	.halt_reg = 0x20a0,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x20a0,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(const struct clk_init_data) {
> +			.name = "disp0_cc_mdss_dptx1_aux_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&disp0_cc_mdss_dptx1_aux_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch disp1_cc_mdss_dptx1_aux_clk = {
> +	.halt_reg = 0x20a0,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x20a0,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(const struct clk_init_data) {
> +			.name = "disp1_cc_mdss_dptx1_aux_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&disp1_cc_mdss_dptx1_aux_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch disp0_cc_mdss_dptx1_link_clk = {
> +	.halt_reg = 0x2084,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x2084,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(const struct clk_init_data) {
> +			.name = "disp0_cc_mdss_dptx1_link_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&disp0_cc_mdss_dptx1_link_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch disp1_cc_mdss_dptx1_link_clk = {
> +	.halt_reg = 0x2084,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x2084,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(const struct clk_init_data) {
> +			.name = "disp1_cc_mdss_dptx1_link_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&disp1_cc_mdss_dptx1_link_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch disp0_cc_mdss_dptx1_link_intf_clk = {
> +	.halt_reg = 0x2088,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x2088,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(const struct clk_init_data) {
> +			.name = "disp0_cc_mdss_dptx1_link_intf_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&disp0_cc_mdss_dptx1_link_div_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch disp1_cc_mdss_dptx1_link_intf_clk = {
> +	.halt_reg = 0x2088,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x2088,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(const struct clk_init_data) {
> +			.name = "disp1_cc_mdss_dptx1_link_intf_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&disp1_cc_mdss_dptx1_link_div_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch disp0_cc_mdss_dptx1_pixel0_clk = {
> +	.halt_reg = 0x2078,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x2078,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(const struct clk_init_data) {
> +			.name = "disp0_cc_mdss_dptx1_pixel0_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&disp0_cc_mdss_dptx1_pixel0_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch disp1_cc_mdss_dptx1_pixel0_clk = {
> +	.halt_reg = 0x2078,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x2078,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(const struct clk_init_data) {
> +			.name = "disp1_cc_mdss_dptx1_pixel0_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&disp1_cc_mdss_dptx1_pixel0_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch disp0_cc_mdss_dptx1_pixel1_clk = {
> +	.halt_reg = 0x236c,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x236c,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(const struct clk_init_data) {
> +			.name = "disp0_cc_mdss_dptx1_pixel1_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&disp0_cc_mdss_dptx1_pixel1_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch disp1_cc_mdss_dptx1_pixel1_clk = {
> +	.halt_reg = 0x236c,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x236c,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(const struct clk_init_data) {
> +			.name = "disp1_cc_mdss_dptx1_pixel1_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&disp1_cc_mdss_dptx1_pixel1_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch disp0_cc_mdss_dptx1_usb_router_link_intf_clk = {
> +	.halt_reg = 0x208c,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x208c,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(const struct clk_init_data) {
> +			.name = "disp0_cc_mdss_dptx1_usb_router_link_intf_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&disp0_cc_mdss_dptx1_link_div_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch disp1_cc_mdss_dptx1_usb_router_link_intf_clk = {
> +	.halt_reg = 0x208c,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x208c,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(const struct clk_init_data) {
> +			.name = "disp1_cc_mdss_dptx1_usb_router_link_intf_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&disp1_cc_mdss_dptx1_link_div_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch disp0_cc_mdss_dptx2_aux_clk = {
> +	.halt_reg = 0x20a4,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x20a4,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(const struct clk_init_data) {
> +			.name = "disp0_cc_mdss_dptx2_aux_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&disp0_cc_mdss_dptx2_aux_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch disp1_cc_mdss_dptx2_aux_clk = {
> +	.halt_reg = 0x20a4,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x20a4,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(const struct clk_init_data) {
> +			.name = "disp1_cc_mdss_dptx2_aux_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&disp1_cc_mdss_dptx2_aux_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch disp0_cc_mdss_dptx2_link_clk = {
> +	.halt_reg = 0x2090,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x2090,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(const struct clk_init_data) {
> +			.name = "disp0_cc_mdss_dptx2_link_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&disp0_cc_mdss_dptx2_link_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch disp1_cc_mdss_dptx2_link_clk = {
> +	.halt_reg = 0x2090,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x2090,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(const struct clk_init_data) {
> +			.name = "disp1_cc_mdss_dptx2_link_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&disp1_cc_mdss_dptx2_link_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch disp0_cc_mdss_dptx2_link_intf_clk = {
> +	.halt_reg = 0x2094,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x2094,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(const struct clk_init_data) {
> +			.name = "disp0_cc_mdss_dptx2_link_intf_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&disp0_cc_mdss_dptx2_link_div_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch disp1_cc_mdss_dptx2_link_intf_clk = {
> +	.halt_reg = 0x2094,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x2094,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(const struct clk_init_data) {
> +			.name = "disp1_cc_mdss_dptx2_link_intf_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&disp1_cc_mdss_dptx2_link_div_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch disp0_cc_mdss_dptx2_pixel0_clk = {
> +	.halt_reg = 0x207c,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x207c,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(const struct clk_init_data) {
> +			.name = "disp0_cc_mdss_dptx2_pixel0_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&disp0_cc_mdss_dptx2_pixel0_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch disp1_cc_mdss_dptx2_pixel0_clk = {
> +	.halt_reg = 0x207c,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x207c,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(const struct clk_init_data) {
> +			.name = "disp1_cc_mdss_dptx2_pixel0_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&disp1_cc_mdss_dptx2_pixel0_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch disp0_cc_mdss_dptx2_pixel1_clk = {
> +	.halt_reg = 0x2080,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x2080,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(const struct clk_init_data) {
> +			.name = "disp0_cc_mdss_dptx2_pixel1_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&disp0_cc_mdss_dptx2_pixel1_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch disp1_cc_mdss_dptx2_pixel1_clk = {
> +	.halt_reg = 0x2080,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x2080,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(const struct clk_init_data) {
> +			.name = "disp1_cc_mdss_dptx2_pixel1_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&disp1_cc_mdss_dptx2_pixel1_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch disp0_cc_mdss_dptx3_aux_clk = {
> +	.halt_reg = 0x20b8,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x20b8,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(const struct clk_init_data) {
> +			.name = "disp0_cc_mdss_dptx3_aux_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&disp0_cc_mdss_dptx3_aux_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch disp1_cc_mdss_dptx3_aux_clk = {
> +	.halt_reg = 0x20b8,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x20b8,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(const struct clk_init_data) {
> +			.name = "disp1_cc_mdss_dptx3_aux_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&disp1_cc_mdss_dptx3_aux_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch disp0_cc_mdss_dptx3_link_clk = {
> +	.halt_reg = 0x20ac,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x20ac,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(const struct clk_init_data) {
> +			.name = "disp0_cc_mdss_dptx3_link_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&disp0_cc_mdss_dptx3_link_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch disp1_cc_mdss_dptx3_link_clk = {
> +	.halt_reg = 0x20ac,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x20ac,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(const struct clk_init_data) {
> +			.name = "disp1_cc_mdss_dptx3_link_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&disp1_cc_mdss_dptx3_link_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch disp0_cc_mdss_dptx3_link_intf_clk = {
> +	.halt_reg = 0x20b0,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x20b0,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(const struct clk_init_data) {
> +			.name = "disp0_cc_mdss_dptx3_link_intf_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&disp0_cc_mdss_dptx3_link_div_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch disp1_cc_mdss_dptx3_link_intf_clk = {
> +	.halt_reg = 0x20b0,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x20b0,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(const struct clk_init_data) {
> +			.name = "disp1_cc_mdss_dptx3_link_intf_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&disp1_cc_mdss_dptx3_link_div_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch disp0_cc_mdss_dptx3_pixel0_clk = {
> +	.halt_reg = 0x20a8,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x20a8,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(const struct clk_init_data) {
> +			.name = "disp0_cc_mdss_dptx3_pixel0_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&disp0_cc_mdss_dptx3_pixel0_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch disp1_cc_mdss_dptx3_pixel0_clk = {
> +	.halt_reg = 0x20a8,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x20a8,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(const struct clk_init_data) {
> +			.name = "disp1_cc_mdss_dptx3_pixel0_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&disp1_cc_mdss_dptx3_pixel0_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch disp0_cc_mdss_esc0_clk = {
> +	.halt_reg = 0x2054,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x2054,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(const struct clk_init_data) {
> +			.name = "disp0_cc_mdss_esc0_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&disp0_cc_mdss_esc0_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch disp1_cc_mdss_esc0_clk = {
> +	.halt_reg = 0x2054,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x2054,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(const struct clk_init_data) {
> +			.name = "disp1_cc_mdss_esc0_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&disp1_cc_mdss_esc0_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch disp0_cc_mdss_esc1_clk = {
> +	.halt_reg = 0x2058,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x2058,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(const struct clk_init_data) {
> +			.name = "disp0_cc_mdss_esc1_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&disp0_cc_mdss_esc1_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch disp1_cc_mdss_esc1_clk = {
> +	.halt_reg = 0x2058,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x2058,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(const struct clk_init_data) {
> +			.name = "disp1_cc_mdss_esc1_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&disp1_cc_mdss_esc1_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch disp0_cc_mdss_mdp1_clk = {
> +	.halt_reg = 0x2014,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x2014,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(const struct clk_init_data) {
> +			.name = "disp0_cc_mdss_mdp1_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&disp0_cc_mdss_mdp_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch disp1_cc_mdss_mdp1_clk = {
> +	.halt_reg = 0x2014,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x2014,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(const struct clk_init_data) {
> +			.name = "disp1_cc_mdss_mdp1_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&disp1_cc_mdss_mdp_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch disp0_cc_mdss_mdp_clk = {
> +	.halt_reg = 0x200c,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x200c,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(const struct clk_init_data) {
> +			.name = "disp0_cc_mdss_mdp_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&disp0_cc_mdss_mdp_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch disp1_cc_mdss_mdp_clk = {
> +	.halt_reg = 0x200c,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x200c,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(const struct clk_init_data) {
> +			.name = "disp1_cc_mdss_mdp_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&disp1_cc_mdss_mdp_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch disp0_cc_mdss_mdp_lut1_clk = {
> +	.halt_reg = 0x2034,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x2034,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(const struct clk_init_data) {
> +			.name = "disp0_cc_mdss_mdp_lut1_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&disp0_cc_mdss_mdp_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch disp1_cc_mdss_mdp_lut1_clk = {
> +	.halt_reg = 0x2034,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x2034,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(const struct clk_init_data) {
> +			.name = "disp1_cc_mdss_mdp_lut1_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&disp1_cc_mdss_mdp_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch disp0_cc_mdss_mdp_lut_clk = {
> +	.halt_reg = 0x202c,
> +	.halt_check = BRANCH_HALT_VOTED,
> +	.clkr = {
> +		.enable_reg = 0x202c,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(const struct clk_init_data) {
> +			.name = "disp0_cc_mdss_mdp_lut_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&disp0_cc_mdss_mdp_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch disp1_cc_mdss_mdp_lut_clk = {
> +	.halt_reg = 0x202c,
> +	.halt_check = BRANCH_HALT_VOTED,
> +	.clkr = {
> +		.enable_reg = 0x202c,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(const struct clk_init_data) {
> +			.name = "disp1_cc_mdss_mdp_lut_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&disp1_cc_mdss_mdp_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch disp0_cc_mdss_non_gdsc_ahb_clk = {
> +	.halt_reg = 0x4004,
> +	.halt_check = BRANCH_HALT_VOTED,
> +	.clkr = {
> +		.enable_reg = 0x4004,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(const struct clk_init_data) {
> +			.name = "disp0_cc_mdss_non_gdsc_ahb_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&disp0_cc_mdss_ahb_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch disp1_cc_mdss_non_gdsc_ahb_clk = {
> +	.halt_reg = 0x4004,
> +	.halt_check = BRANCH_HALT_VOTED,
> +	.clkr = {
> +		.enable_reg = 0x4004,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(const struct clk_init_data) {
> +			.name = "disp1_cc_mdss_non_gdsc_ahb_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&disp1_cc_mdss_ahb_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch disp0_cc_mdss_pclk0_clk = {
> +	.halt_reg = 0x2004,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x2004,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(const struct clk_init_data) {
> +			.name = "disp0_cc_mdss_pclk0_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&disp0_cc_mdss_pclk0_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch disp1_cc_mdss_pclk0_clk = {
> +	.halt_reg = 0x2004,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x2004,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(const struct clk_init_data) {
> +			.name = "disp1_cc_mdss_pclk0_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&disp1_cc_mdss_pclk0_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch disp0_cc_mdss_pclk1_clk = {
> +	.halt_reg = 0x2008,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x2008,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(const struct clk_init_data) {
> +			.name = "disp0_cc_mdss_pclk1_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&disp0_cc_mdss_pclk1_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch disp1_cc_mdss_pclk1_clk = {
> +	.halt_reg = 0x2008,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x2008,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(const struct clk_init_data) {
> +			.name = "disp1_cc_mdss_pclk1_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&disp1_cc_mdss_pclk1_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch disp0_cc_mdss_rot1_clk = {
> +	.halt_reg = 0x2024,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x2024,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(const struct clk_init_data) {
> +			.name = "disp0_cc_mdss_rot1_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&disp0_cc_mdss_rot_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch disp1_cc_mdss_rot1_clk = {
> +	.halt_reg = 0x2024,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x2024,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(const struct clk_init_data) {
> +			.name = "disp1_cc_mdss_rot1_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&disp1_cc_mdss_rot_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch disp0_cc_mdss_rot_clk = {
> +	.halt_reg = 0x201c,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x201c,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(const struct clk_init_data) {
> +			.name = "disp0_cc_mdss_rot_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&disp0_cc_mdss_rot_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch disp1_cc_mdss_rot_clk = {
> +	.halt_reg = 0x201c,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x201c,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(const struct clk_init_data) {
> +			.name = "disp1_cc_mdss_rot_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&disp1_cc_mdss_rot_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch disp0_cc_mdss_rscc_ahb_clk = {
> +	.halt_reg = 0x400c,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x400c,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(const struct clk_init_data) {
> +			.name = "disp0_cc_mdss_rscc_ahb_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&disp0_cc_mdss_ahb_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch disp1_cc_mdss_rscc_ahb_clk = {
> +	.halt_reg = 0x400c,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x400c,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(const struct clk_init_data) {
> +			.name = "disp1_cc_mdss_rscc_ahb_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&disp1_cc_mdss_ahb_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch disp0_cc_mdss_rscc_vsync_clk = {
> +	.halt_reg = 0x4008,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x4008,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(const struct clk_init_data) {
> +			.name = "disp0_cc_mdss_rscc_vsync_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&disp0_cc_mdss_vsync_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch disp1_cc_mdss_rscc_vsync_clk = {
> +	.halt_reg = 0x4008,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x4008,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(const struct clk_init_data) {
> +			.name = "disp1_cc_mdss_rscc_vsync_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&disp1_cc_mdss_vsync_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch disp0_cc_mdss_vsync1_clk = {
> +	.halt_reg = 0x2040,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x2040,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(const struct clk_init_data) {
> +			.name = "disp0_cc_mdss_vsync1_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&disp0_cc_mdss_vsync_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch disp1_cc_mdss_vsync1_clk = {
> +	.halt_reg = 0x2040,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x2040,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(const struct clk_init_data) {
> +			.name = "disp1_cc_mdss_vsync1_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&disp1_cc_mdss_vsync_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch disp0_cc_mdss_vsync_clk = {
> +	.halt_reg = 0x203c,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x203c,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(const struct clk_init_data) {
> +			.name = "disp0_cc_mdss_vsync_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&disp0_cc_mdss_vsync_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch disp1_cc_mdss_vsync_clk = {
> +	.halt_reg = 0x203c,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x203c,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(const struct clk_init_data) {
> +			.name = "disp1_cc_mdss_vsync_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&disp1_cc_mdss_vsync_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch disp0_cc_sleep_clk = {
> +	.halt_reg = 0x6078,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x6078,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(const struct clk_init_data) {
> +			.name = "disp0_cc_sleep_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&disp0_cc_sleep_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch disp1_cc_sleep_clk = {
> +	.halt_reg = 0x6078,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x6078,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(const struct clk_init_data) {
> +			.name = "disp1_cc_sleep_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&disp1_cc_sleep_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_regmap *disp0_cc_sc8280xp_clocks[] = {
> +	[DISP_CC_MDSS_AHB1_CLK] = &disp0_cc_mdss_ahb1_clk.clkr,
> +	[DISP_CC_MDSS_AHB_CLK] = &disp0_cc_mdss_ahb_clk.clkr,
> +	[DISP_CC_MDSS_AHB_CLK_SRC] = &disp0_cc_mdss_ahb_clk_src.clkr,
> +	[DISP_CC_MDSS_BYTE0_CLK] = &disp0_cc_mdss_byte0_clk.clkr,
> +	[DISP_CC_MDSS_BYTE0_CLK_SRC] = &disp0_cc_mdss_byte0_clk_src.clkr,
> +	[DISP_CC_MDSS_BYTE0_DIV_CLK_SRC] = &disp0_cc_mdss_byte0_div_clk_src.clkr,
> +	[DISP_CC_MDSS_BYTE0_INTF_CLK] = &disp0_cc_mdss_byte0_intf_clk.clkr,
> +	[DISP_CC_MDSS_BYTE1_CLK] = &disp0_cc_mdss_byte1_clk.clkr,
> +	[DISP_CC_MDSS_BYTE1_CLK_SRC] = &disp0_cc_mdss_byte1_clk_src.clkr,
> +	[DISP_CC_MDSS_BYTE1_DIV_CLK_SRC] = &disp0_cc_mdss_byte1_div_clk_src.clkr,
> +	[DISP_CC_MDSS_BYTE1_INTF_CLK] = &disp0_cc_mdss_byte1_intf_clk.clkr,
> +	[DISP_CC_MDSS_DPTX0_AUX_CLK] = &disp0_cc_mdss_dptx0_aux_clk.clkr,
> +	[DISP_CC_MDSS_DPTX0_AUX_CLK_SRC] = &disp0_cc_mdss_dptx0_aux_clk_src.clkr,
> +	[DISP_CC_MDSS_DPTX0_LINK_CLK] = &disp0_cc_mdss_dptx0_link_clk.clkr,
> +	[DISP_CC_MDSS_DPTX0_LINK_CLK_SRC] = &disp0_cc_mdss_dptx0_link_clk_src.clkr,
> +	[DISP_CC_MDSS_DPTX0_LINK_DIV_CLK_SRC] = &disp0_cc_mdss_dptx0_link_div_clk_src.clkr,
> +	[DISP_CC_MDSS_DPTX0_LINK_INTF_CLK] = &disp0_cc_mdss_dptx0_link_intf_clk.clkr,
> +	[DISP_CC_MDSS_DPTX0_PIXEL0_CLK] = &disp0_cc_mdss_dptx0_pixel0_clk.clkr,
> +	[DISP_CC_MDSS_DPTX0_PIXEL0_CLK_SRC] = &disp0_cc_mdss_dptx0_pixel0_clk_src.clkr,
> +	[DISP_CC_MDSS_DPTX0_PIXEL1_CLK] = &disp0_cc_mdss_dptx0_pixel1_clk.clkr,
> +	[DISP_CC_MDSS_DPTX0_PIXEL1_CLK_SRC] = &disp0_cc_mdss_dptx0_pixel1_clk_src.clkr,
> +	[DISP_CC_MDSS_DPTX0_USB_ROUTER_LINK_INTF_CLK] = &disp0_cc_mdss_dptx0_usb_router_link_intf_clk.clkr,
> +	[DISP_CC_MDSS_DPTX1_AUX_CLK] = &disp0_cc_mdss_dptx1_aux_clk.clkr,
> +	[DISP_CC_MDSS_DPTX1_AUX_CLK_SRC] = &disp0_cc_mdss_dptx1_aux_clk_src.clkr,
> +	[DISP_CC_MDSS_DPTX1_LINK_CLK] = &disp0_cc_mdss_dptx1_link_clk.clkr,
> +	[DISP_CC_MDSS_DPTX1_LINK_CLK_SRC] = &disp0_cc_mdss_dptx1_link_clk_src.clkr,
> +	[DISP_CC_MDSS_DPTX1_LINK_DIV_CLK_SRC] = &disp0_cc_mdss_dptx1_link_div_clk_src.clkr,
> +	[DISP_CC_MDSS_DPTX1_LINK_INTF_CLK] = &disp0_cc_mdss_dptx1_link_intf_clk.clkr,
> +	[DISP_CC_MDSS_DPTX1_PIXEL0_CLK] = &disp0_cc_mdss_dptx1_pixel0_clk.clkr,
> +	[DISP_CC_MDSS_DPTX1_PIXEL0_CLK_SRC] = &disp0_cc_mdss_dptx1_pixel0_clk_src.clkr,
> +	[DISP_CC_MDSS_DPTX1_PIXEL1_CLK] = &disp0_cc_mdss_dptx1_pixel1_clk.clkr,
> +	[DISP_CC_MDSS_DPTX1_PIXEL1_CLK_SRC] = &disp0_cc_mdss_dptx1_pixel1_clk_src.clkr,
> +	[DISP_CC_MDSS_DPTX1_USB_ROUTER_LINK_INTF_CLK] = &disp0_cc_mdss_dptx1_usb_router_link_intf_clk.clkr,
> +	[DISP_CC_MDSS_DPTX2_AUX_CLK] = &disp0_cc_mdss_dptx2_aux_clk.clkr,
> +	[DISP_CC_MDSS_DPTX2_AUX_CLK_SRC] = &disp0_cc_mdss_dptx2_aux_clk_src.clkr,
> +	[DISP_CC_MDSS_DPTX2_LINK_CLK] = &disp0_cc_mdss_dptx2_link_clk.clkr,
> +	[DISP_CC_MDSS_DPTX2_LINK_CLK_SRC] = &disp0_cc_mdss_dptx2_link_clk_src.clkr,
> +	[DISP_CC_MDSS_DPTX2_LINK_DIV_CLK_SRC] = &disp0_cc_mdss_dptx2_link_div_clk_src.clkr,
> +	[DISP_CC_MDSS_DPTX2_LINK_INTF_CLK] = &disp0_cc_mdss_dptx2_link_intf_clk.clkr,
> +	[DISP_CC_MDSS_DPTX2_PIXEL0_CLK] = &disp0_cc_mdss_dptx2_pixel0_clk.clkr,
> +	[DISP_CC_MDSS_DPTX2_PIXEL0_CLK_SRC] = &disp0_cc_mdss_dptx2_pixel0_clk_src.clkr,
> +	[DISP_CC_MDSS_DPTX2_PIXEL1_CLK] = &disp0_cc_mdss_dptx2_pixel1_clk.clkr,
> +	[DISP_CC_MDSS_DPTX2_PIXEL1_CLK_SRC] = &disp0_cc_mdss_dptx2_pixel1_clk_src.clkr,
> +	[DISP_CC_MDSS_DPTX3_AUX_CLK] = &disp0_cc_mdss_dptx3_aux_clk.clkr,
> +	[DISP_CC_MDSS_DPTX3_AUX_CLK_SRC] = &disp0_cc_mdss_dptx3_aux_clk_src.clkr,
> +	[DISP_CC_MDSS_DPTX3_LINK_CLK] = &disp0_cc_mdss_dptx3_link_clk.clkr,
> +	[DISP_CC_MDSS_DPTX3_LINK_CLK_SRC] = &disp0_cc_mdss_dptx3_link_clk_src.clkr,
> +	[DISP_CC_MDSS_DPTX3_LINK_DIV_CLK_SRC] = &disp0_cc_mdss_dptx3_link_div_clk_src.clkr,
> +	[DISP_CC_MDSS_DPTX3_LINK_INTF_CLK] = &disp0_cc_mdss_dptx3_link_intf_clk.clkr,
> +	[DISP_CC_MDSS_DPTX3_PIXEL0_CLK] = &disp0_cc_mdss_dptx3_pixel0_clk.clkr,
> +	[DISP_CC_MDSS_DPTX3_PIXEL0_CLK_SRC] = &disp0_cc_mdss_dptx3_pixel0_clk_src.clkr,
> +	[DISP_CC_MDSS_ESC0_CLK] = &disp0_cc_mdss_esc0_clk.clkr,
> +	[DISP_CC_MDSS_ESC0_CLK_SRC] = &disp0_cc_mdss_esc0_clk_src.clkr,
> +	[DISP_CC_MDSS_ESC1_CLK] = &disp0_cc_mdss_esc1_clk.clkr,
> +	[DISP_CC_MDSS_ESC1_CLK_SRC] = &disp0_cc_mdss_esc1_clk_src.clkr,
> +	[DISP_CC_MDSS_MDP1_CLK] = &disp0_cc_mdss_mdp1_clk.clkr,
> +	[DISP_CC_MDSS_MDP_CLK] = &disp0_cc_mdss_mdp_clk.clkr,
> +	[DISP_CC_MDSS_MDP_CLK_SRC] = &disp0_cc_mdss_mdp_clk_src.clkr,
> +	[DISP_CC_MDSS_MDP_LUT1_CLK] = &disp0_cc_mdss_mdp_lut1_clk.clkr,
> +	[DISP_CC_MDSS_MDP_LUT_CLK] = &disp0_cc_mdss_mdp_lut_clk.clkr,
> +	[DISP_CC_MDSS_NON_GDSC_AHB_CLK] = &disp0_cc_mdss_non_gdsc_ahb_clk.clkr,
> +	[DISP_CC_MDSS_PCLK0_CLK] = &disp0_cc_mdss_pclk0_clk.clkr,
> +	[DISP_CC_MDSS_PCLK0_CLK_SRC] = &disp0_cc_mdss_pclk0_clk_src.clkr,
> +	[DISP_CC_MDSS_PCLK1_CLK] = &disp0_cc_mdss_pclk1_clk.clkr,
> +	[DISP_CC_MDSS_PCLK1_CLK_SRC] = &disp0_cc_mdss_pclk1_clk_src.clkr,
> +	[DISP_CC_MDSS_ROT1_CLK] = &disp0_cc_mdss_rot1_clk.clkr,
> +	[DISP_CC_MDSS_ROT_CLK] = &disp0_cc_mdss_rot_clk.clkr,
> +	[DISP_CC_MDSS_ROT_CLK_SRC] = &disp0_cc_mdss_rot_clk_src.clkr,
> +	[DISP_CC_MDSS_RSCC_AHB_CLK] = &disp0_cc_mdss_rscc_ahb_clk.clkr,
> +	[DISP_CC_MDSS_RSCC_VSYNC_CLK] = &disp0_cc_mdss_rscc_vsync_clk.clkr,
> +	[DISP_CC_MDSS_VSYNC1_CLK] = &disp0_cc_mdss_vsync1_clk.clkr,
> +	[DISP_CC_MDSS_VSYNC_CLK] = &disp0_cc_mdss_vsync_clk.clkr,
> +	[DISP_CC_MDSS_VSYNC_CLK_SRC] = &disp0_cc_mdss_vsync_clk_src.clkr,
> +	[DISP_CC_PLL0] = &disp0_cc_pll0.clkr,
> +	[DISP_CC_PLL1] = &disp0_cc_pll1.clkr,
> +	[DISP_CC_PLL1_OUT_EVEN] = &disp0_cc_pll1_out_even.clkr,
> +	[DISP_CC_PLL2] = &disp0_cc_pll2.clkr,
> +	[DISP_CC_SLEEP_CLK] = &disp0_cc_sleep_clk.clkr,
> +	[DISP_CC_SLEEP_CLK_SRC] = &disp0_cc_sleep_clk_src.clkr,
> +};
> +
> +static struct clk_regmap *disp1_cc_sc8280xp_clocks[] = {
> +	[DISP_CC_MDSS_AHB1_CLK] = &disp1_cc_mdss_ahb1_clk.clkr,
> +	[DISP_CC_MDSS_AHB_CLK] = &disp1_cc_mdss_ahb_clk.clkr,
> +	[DISP_CC_MDSS_AHB_CLK_SRC] = &disp1_cc_mdss_ahb_clk_src.clkr,
> +	[DISP_CC_MDSS_BYTE0_CLK] = &disp1_cc_mdss_byte0_clk.clkr,
> +	[DISP_CC_MDSS_BYTE0_CLK_SRC] = &disp1_cc_mdss_byte0_clk_src.clkr,
> +	[DISP_CC_MDSS_BYTE0_DIV_CLK_SRC] = &disp1_cc_mdss_byte0_div_clk_src.clkr,
> +	[DISP_CC_MDSS_BYTE0_INTF_CLK] = &disp1_cc_mdss_byte0_intf_clk.clkr,
> +	[DISP_CC_MDSS_BYTE1_CLK] = &disp1_cc_mdss_byte1_clk.clkr,
> +	[DISP_CC_MDSS_BYTE1_CLK_SRC] = &disp1_cc_mdss_byte1_clk_src.clkr,
> +	[DISP_CC_MDSS_BYTE1_DIV_CLK_SRC] = &disp1_cc_mdss_byte1_div_clk_src.clkr,
> +	[DISP_CC_MDSS_BYTE1_INTF_CLK] = &disp1_cc_mdss_byte1_intf_clk.clkr,
> +	[DISP_CC_MDSS_DPTX0_AUX_CLK] = &disp1_cc_mdss_dptx0_aux_clk.clkr,
> +	[DISP_CC_MDSS_DPTX0_AUX_CLK_SRC] = &disp1_cc_mdss_dptx0_aux_clk_src.clkr,
> +	[DISP_CC_MDSS_DPTX0_LINK_CLK] = &disp1_cc_mdss_dptx0_link_clk.clkr,
> +	[DISP_CC_MDSS_DPTX0_LINK_CLK_SRC] = &disp1_cc_mdss_dptx0_link_clk_src.clkr,
> +	[DISP_CC_MDSS_DPTX0_LINK_DIV_CLK_SRC] = &disp1_cc_mdss_dptx0_link_div_clk_src.clkr,
> +	[DISP_CC_MDSS_DPTX0_LINK_INTF_CLK] = &disp1_cc_mdss_dptx0_link_intf_clk.clkr,
> +	[DISP_CC_MDSS_DPTX0_PIXEL0_CLK] = &disp1_cc_mdss_dptx0_pixel0_clk.clkr,
> +	[DISP_CC_MDSS_DPTX0_PIXEL0_CLK_SRC] = &disp1_cc_mdss_dptx0_pixel0_clk_src.clkr,
> +	[DISP_CC_MDSS_DPTX0_PIXEL1_CLK] = &disp1_cc_mdss_dptx0_pixel1_clk.clkr,
> +	[DISP_CC_MDSS_DPTX0_PIXEL1_CLK_SRC] = &disp1_cc_mdss_dptx0_pixel1_clk_src.clkr,
> +	[DISP_CC_MDSS_DPTX0_USB_ROUTER_LINK_INTF_CLK] = &disp1_cc_mdss_dptx0_usb_router_link_intf_clk.clkr,
> +	[DISP_CC_MDSS_DPTX1_AUX_CLK] = &disp1_cc_mdss_dptx1_aux_clk.clkr,
> +	[DISP_CC_MDSS_DPTX1_AUX_CLK_SRC] = &disp1_cc_mdss_dptx1_aux_clk_src.clkr,
> +	[DISP_CC_MDSS_DPTX1_LINK_CLK] = &disp1_cc_mdss_dptx1_link_clk.clkr,
> +	[DISP_CC_MDSS_DPTX1_LINK_CLK_SRC] = &disp1_cc_mdss_dptx1_link_clk_src.clkr,
> +	[DISP_CC_MDSS_DPTX1_LINK_DIV_CLK_SRC] = &disp1_cc_mdss_dptx1_link_div_clk_src.clkr,
> +	[DISP_CC_MDSS_DPTX1_LINK_INTF_CLK] = &disp1_cc_mdss_dptx1_link_intf_clk.clkr,
> +	[DISP_CC_MDSS_DPTX1_PIXEL0_CLK] = &disp1_cc_mdss_dptx1_pixel0_clk.clkr,
> +	[DISP_CC_MDSS_DPTX1_PIXEL0_CLK_SRC] = &disp1_cc_mdss_dptx1_pixel0_clk_src.clkr,
> +	[DISP_CC_MDSS_DPTX1_PIXEL1_CLK] = &disp1_cc_mdss_dptx1_pixel1_clk.clkr,
> +	[DISP_CC_MDSS_DPTX1_PIXEL1_CLK_SRC] = &disp1_cc_mdss_dptx1_pixel1_clk_src.clkr,
> +	[DISP_CC_MDSS_DPTX1_USB_ROUTER_LINK_INTF_CLK] = &disp1_cc_mdss_dptx1_usb_router_link_intf_clk.clkr,
> +	[DISP_CC_MDSS_DPTX2_AUX_CLK] = &disp1_cc_mdss_dptx2_aux_clk.clkr,
> +	[DISP_CC_MDSS_DPTX2_AUX_CLK_SRC] = &disp1_cc_mdss_dptx2_aux_clk_src.clkr,
> +	[DISP_CC_MDSS_DPTX2_LINK_CLK] = &disp1_cc_mdss_dptx2_link_clk.clkr,
> +	[DISP_CC_MDSS_DPTX2_LINK_CLK_SRC] = &disp1_cc_mdss_dptx2_link_clk_src.clkr,
> +	[DISP_CC_MDSS_DPTX2_LINK_DIV_CLK_SRC] = &disp1_cc_mdss_dptx2_link_div_clk_src.clkr,
> +	[DISP_CC_MDSS_DPTX2_LINK_INTF_CLK] = &disp1_cc_mdss_dptx2_link_intf_clk.clkr,
> +	[DISP_CC_MDSS_DPTX2_PIXEL0_CLK] = &disp1_cc_mdss_dptx2_pixel0_clk.clkr,
> +	[DISP_CC_MDSS_DPTX2_PIXEL0_CLK_SRC] = &disp1_cc_mdss_dptx2_pixel0_clk_src.clkr,
> +	[DISP_CC_MDSS_DPTX2_PIXEL1_CLK] = &disp1_cc_mdss_dptx2_pixel1_clk.clkr,
> +	[DISP_CC_MDSS_DPTX2_PIXEL1_CLK_SRC] = &disp1_cc_mdss_dptx2_pixel1_clk_src.clkr,
> +	[DISP_CC_MDSS_DPTX3_AUX_CLK] = &disp1_cc_mdss_dptx3_aux_clk.clkr,
> +	[DISP_CC_MDSS_DPTX3_AUX_CLK_SRC] = &disp1_cc_mdss_dptx3_aux_clk_src.clkr,
> +	[DISP_CC_MDSS_DPTX3_LINK_CLK] = &disp1_cc_mdss_dptx3_link_clk.clkr,
> +	[DISP_CC_MDSS_DPTX3_LINK_CLK_SRC] = &disp1_cc_mdss_dptx3_link_clk_src.clkr,
> +	[DISP_CC_MDSS_DPTX3_LINK_DIV_CLK_SRC] = &disp1_cc_mdss_dptx3_link_div_clk_src.clkr,
> +	[DISP_CC_MDSS_DPTX3_LINK_INTF_CLK] = &disp1_cc_mdss_dptx3_link_intf_clk.clkr,
> +	[DISP_CC_MDSS_DPTX3_PIXEL0_CLK] = &disp1_cc_mdss_dptx3_pixel0_clk.clkr,
> +	[DISP_CC_MDSS_DPTX3_PIXEL0_CLK_SRC] = &disp1_cc_mdss_dptx3_pixel0_clk_src.clkr,
> +	[DISP_CC_MDSS_ESC0_CLK] = &disp1_cc_mdss_esc0_clk.clkr,
> +	[DISP_CC_MDSS_ESC0_CLK_SRC] = &disp1_cc_mdss_esc0_clk_src.clkr,
> +	[DISP_CC_MDSS_ESC1_CLK] = &disp1_cc_mdss_esc1_clk.clkr,
> +	[DISP_CC_MDSS_ESC1_CLK_SRC] = &disp1_cc_mdss_esc1_clk_src.clkr,
> +	[DISP_CC_MDSS_MDP1_CLK] = &disp1_cc_mdss_mdp1_clk.clkr,
> +	[DISP_CC_MDSS_MDP_CLK] = &disp1_cc_mdss_mdp_clk.clkr,
> +	[DISP_CC_MDSS_MDP_CLK_SRC] = &disp1_cc_mdss_mdp_clk_src.clkr,
> +	[DISP_CC_MDSS_MDP_LUT1_CLK] = &disp1_cc_mdss_mdp_lut1_clk.clkr,
> +	[DISP_CC_MDSS_MDP_LUT_CLK] = &disp1_cc_mdss_mdp_lut_clk.clkr,
> +	[DISP_CC_MDSS_NON_GDSC_AHB_CLK] = &disp1_cc_mdss_non_gdsc_ahb_clk.clkr,
> +	[DISP_CC_MDSS_PCLK0_CLK] = &disp1_cc_mdss_pclk0_clk.clkr,
> +	[DISP_CC_MDSS_PCLK0_CLK_SRC] = &disp1_cc_mdss_pclk0_clk_src.clkr,
> +	[DISP_CC_MDSS_PCLK1_CLK] = &disp1_cc_mdss_pclk1_clk.clkr,
> +	[DISP_CC_MDSS_PCLK1_CLK_SRC] = &disp1_cc_mdss_pclk1_clk_src.clkr,
> +	[DISP_CC_MDSS_ROT1_CLK] = &disp1_cc_mdss_rot1_clk.clkr,
> +	[DISP_CC_MDSS_ROT_CLK] = &disp1_cc_mdss_rot_clk.clkr,
> +	[DISP_CC_MDSS_ROT_CLK_SRC] = &disp1_cc_mdss_rot_clk_src.clkr,
> +	[DISP_CC_MDSS_RSCC_AHB_CLK] = &disp1_cc_mdss_rscc_ahb_clk.clkr,
> +	[DISP_CC_MDSS_RSCC_VSYNC_CLK] = &disp1_cc_mdss_rscc_vsync_clk.clkr,
> +	[DISP_CC_MDSS_VSYNC1_CLK] = &disp1_cc_mdss_vsync1_clk.clkr,
> +	[DISP_CC_MDSS_VSYNC_CLK] = &disp1_cc_mdss_vsync_clk.clkr,
> +	[DISP_CC_MDSS_VSYNC_CLK_SRC] = &disp1_cc_mdss_vsync_clk_src.clkr,
> +	[DISP_CC_PLL0] = &disp1_cc_pll0.clkr,
> +	[DISP_CC_PLL1] = &disp1_cc_pll1.clkr,
> +	[DISP_CC_PLL1_OUT_EVEN] = &disp1_cc_pll1_out_even.clkr,
> +	[DISP_CC_PLL2] = &disp1_cc_pll2.clkr,
> +	[DISP_CC_SLEEP_CLK] = &disp1_cc_sleep_clk.clkr,
> +	[DISP_CC_SLEEP_CLK_SRC] = &disp1_cc_sleep_clk_src.clkr,
> +};
> +
> +static const struct qcom_reset_map disp_cc_sc8280xp_resets[] = {
> +	[DISP_CC_MDSS_CORE_BCR] = { 0x2000 },
> +	[DISP_CC_MDSS_RSCC_BCR] = { 0x4000 },
> +};
> +
> +static struct gdsc disp0_mdss_gdsc = {
> +	.gdscr = 0x3000,
> +	.en_rest_wait_val = 0x2,
> +	.en_few_wait_val = 0x2,
> +	.clk_dis_wait_val = 0xf,
> +	.pd = {
> +		.name = "disp0_mdss_gdsc",
> +	},
> +	.pwrsts = PWRSTS_OFF_ON,
> +	.flags = HW_CTRL,
> +};
> +
> +static struct gdsc disp1_mdss_gdsc = {
> +	.gdscr = 0x3000,
> +	.en_rest_wait_val = 0x2,
> +	.en_few_wait_val = 0x2,
> +	.clk_dis_wait_val = 0xf,
> +	.pd = {
> +		.name = "disp1_mdss_gdsc",
> +	},
> +	.pwrsts = PWRSTS_OFF_ON,
> +	.flags = HW_CTRL,
> +};
> +
> +static struct gdsc disp0_mdss_int2_gdsc = {
> +	.gdscr = 0xa000,
> +	.en_rest_wait_val = 0x2,
> +	.en_few_wait_val = 0x2,
> +	.clk_dis_wait_val = 0xf,
> +	.pd = {
> +		.name = "disp0_mdss_int2_gdsc",
> +	},
> +	.pwrsts = PWRSTS_OFF_ON,
> +	.flags = HW_CTRL,
> +};
> +
> +static struct gdsc disp1_mdss_int2_gdsc = {
> +	.gdscr = 0xa000,
> +	.en_rest_wait_val = 0x2,
> +	.en_few_wait_val = 0x2,
> +	.clk_dis_wait_val = 0xf,
> +	.pd = {
> +		.name = "disp1_mdss_int2_gdsc",
> +	},
> +	.pwrsts = PWRSTS_OFF_ON,
> +	.flags = HW_CTRL,
> +};
> +
> +static struct gdsc *disp0_cc_sc8280xp_gdscs[] = {
> +	[MDSS_GDSC] = &disp0_mdss_gdsc,
> +	[MDSS_INT2_GDSC] = &disp0_mdss_int2_gdsc,
> +};
> +
> +static struct gdsc *disp1_cc_sc8280xp_gdscs[] = {
> +	[MDSS_GDSC] = &disp1_mdss_gdsc,
> +	[MDSS_INT2_GDSC] = &disp1_mdss_int2_gdsc,
> +};
> +
> +static const struct regmap_config disp_cc_sc8280xp_regmap_config = {
> +	.reg_bits = 32,
> +	.reg_stride = 4,
> +	.val_bits = 32,
> +	.max_register = 0x10000,
> +	.fast_io = true,
> +};
> +
> +static struct qcom_cc_desc disp0_cc_sc8280xp_desc = {
> +	.config = &disp_cc_sc8280xp_regmap_config,
> +	.clks = disp0_cc_sc8280xp_clocks,
> +	.num_clks = ARRAY_SIZE(disp0_cc_sc8280xp_clocks),
> +	.resets = disp_cc_sc8280xp_resets,
> +	.num_resets = ARRAY_SIZE(disp_cc_sc8280xp_resets),
> +	.gdscs = disp0_cc_sc8280xp_gdscs,
> +	.num_gdscs = ARRAY_SIZE(disp0_cc_sc8280xp_gdscs),
> +};
> +
> +static struct qcom_cc_desc disp1_cc_sc8280xp_desc = {
> +	.config = &disp_cc_sc8280xp_regmap_config,
> +	.clks = disp1_cc_sc8280xp_clocks,
> +	.num_clks = ARRAY_SIZE(disp1_cc_sc8280xp_clocks),
> +	.resets = disp_cc_sc8280xp_resets,
> +	.num_resets = ARRAY_SIZE(disp_cc_sc8280xp_resets),
> +	.gdscs = disp1_cc_sc8280xp_gdscs,
> +	.num_gdscs = ARRAY_SIZE(disp1_cc_sc8280xp_gdscs),
> +};
> +
> +#define clkr_to_alpha_clk_pll(_clkr) container_of(_clkr, struct clk_alpha_pll, clkr)
> +
> +static int disp_cc_sc8280xp_probe(struct platform_device *pdev)
> +{
> +	const struct qcom_cc_desc *desc;
> +	struct regmap *regmap;
> +	int ret;
> +
> +	desc = device_get_match_data(&pdev->dev);
> +
> +	ret = devm_pm_runtime_enable(&pdev->dev);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_pm_clk_create(&pdev->dev);
> +	if (ret)
> +		return ret;
> +
> +	ret = pm_clk_add(&pdev->dev, NULL);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "failed to acquire ahb clock\n");
> +		return ret;
> +	}
> +
> +	ret = pm_runtime_resume_and_get(&pdev->dev);
> +	if (ret)
> +		return ret;
> +
> +	regmap = qcom_cc_map(pdev, desc);
> +	if (IS_ERR(regmap)) {
> +		ret = PTR_ERR(regmap);
> +		goto out_pm_runtime_put;
> +	}
> +
> +	clk_lucid_pll_configure(clkr_to_alpha_clk_pll(desc->clks[DISP_CC_PLL0]), regmap, &disp_cc_pll0_config);
> +	clk_lucid_pll_configure(clkr_to_alpha_clk_pll(desc->clks[DISP_CC_PLL1]), regmap, &disp_cc_pll1_config);
> +	clk_lucid_pll_configure(clkr_to_alpha_clk_pll(desc->clks[DISP_CC_PLL2]), regmap, &disp_cc_pll2_config);
> +
> +	ret = qcom_cc_really_probe(pdev, desc, regmap);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Failed to register display clock controller\n");
> +		goto out_pm_runtime_put;
> +	}
> +
> +	/* DISP_CC_XO_CLK always-on */
> +	regmap_update_bits(regmap, 0x605c, BIT(0), BIT(0));
> +
> +out_pm_runtime_put:
> +	pm_runtime_put_sync(&pdev->dev);
> +
> +	return ret;
> +}
> +
> +static const struct of_device_id disp_cc_sc8280xp_match_table[] = {
> +	{ .compatible = "qcom,sc8280xp-dispcc0", .data = &disp0_cc_sc8280xp_desc },
> +	{ .compatible = "qcom,sc8280xp-dispcc1", .data = &disp1_cc_sc8280xp_desc },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, disp_cc_sc8280xp_match_table);
> +
> +static struct platform_driver disp_cc_sc8280xp_driver = {
> +	.probe = disp_cc_sc8280xp_probe,
> +	.driver = {
> +		.name = "disp_cc-sc8280xp",
> +		.of_match_table = disp_cc_sc8280xp_match_table,
> +	},
> +};
> +
> +static int __init disp_cc_sc8280xp_init(void)
> +{
> +	return platform_driver_register(&disp_cc_sc8280xp_driver);
> +}
> +subsys_initcall(disp_cc_sc8280xp_init);
> +
> +static void __exit disp_cc_sc8280xp_exit(void)
> +{
> +	platform_driver_unregister(&disp_cc_sc8280xp_driver);
> +}
> +module_exit(disp_cc_sc8280xp_exit);
> +
> +MODULE_DESCRIPTION("Qualcomm SC8280XP dispcc driver");
> +MODULE_LICENSE("GPL");

Tested on Lenovo Thinkpad X13s
Tested-by: Steev Klimaszewski <steev@kali.org>

