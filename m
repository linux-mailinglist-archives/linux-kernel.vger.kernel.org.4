Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E87965C15E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 15:01:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237566AbjACOBS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 09:01:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232910AbjACOBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 09:01:13 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B84A101DE
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 06:01:09 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id b3so45776691lfv.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 06:01:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=roWEShMGNvxMoqQcWkrnngyCQB79pbaISia0DxqdaX8=;
        b=eC6c/BWxec3JuiU5RvHwOAkM0f9qhxbDuzT2Sy+U+Td9W4wzvcWvYdO5C3CdSvHtoR
         aFq54HXrPxaFo79cJdrhctJ8uVXmBCXo+lFsLDkGe+vctohvjaqHsyjZmxSLhOUMD4im
         VdoUnj2ymKmn4jWGVH5SdpCz+b8UouaxSnYpGSs37EKxwrHgUuES+Hfc3l2prr2KBwkU
         Zryf8K6IMkEmmy2/zENGNfZsm4aAPjEkhMjvFBn0K4NHBsaqeyZcMDTFnYr3p9RkWGDB
         Z8aZKSesgUfC4as9LoiiHHilCcVTk+4eiSTEcCCYKw9dwnlLH8NSFdX7mnS0162Zp1OB
         +/qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=roWEShMGNvxMoqQcWkrnngyCQB79pbaISia0DxqdaX8=;
        b=gYfypMAVqE66mDsFL+HHVOT7g0IkxVieRjXUnzfQjUKfwGHhMdfZFkANcfDEJVw+K+
         l8i1X4zqZX8SGtyW4eVc5lYkDsF6NtbvvZ06s91i4OrVNxogQ78zy+EOlhvqneM9ynkS
         MHlWOXUw+7+yVN7VpiX7Vl0lWnh+pudvnxFz7Yp91Xf3nmoEAj6XuwYtnCN4xL/Fx1CT
         C+mxCK0SwfzlYg+Jc2/cIfEfuhMXG5YAT4yj09HXqIsb5PG54/HrMHlvd5e7d7/bi9QK
         tapqQLT8sWG46XfRKlq+L09YR1edQ0HuWSZOUXTXYOCrNHScjzlaH4NRtFEUf+SZOhvp
         hUtw==
X-Gm-Message-State: AFqh2krMHlL/O5aVLx6nT55bTA6281pwY5v5roCBGG1oFjDZU1ABh75P
        vOfT6DuwaLF1I+5C2ZTWyKA7sw==
X-Google-Smtp-Source: AMrXdXtkECGcXhrtCvFyfa0zI5Csep4Z9xHNxhb13GVq4nIR6tobSkmw8pSf4ACzR1QNnkcJVT1HUA==
X-Received: by 2002:a05:6512:2004:b0:4b5:64b7:24f0 with SMTP id a4-20020a056512200400b004b564b724f0mr15545992lfb.29.1672754467412;
        Tue, 03 Jan 2023 06:01:07 -0800 (PST)
Received: from [192.168.1.101] (abxi45.neoplus.adsl.tpnet.pl. [83.9.2.45])
        by smtp.gmail.com with ESMTPSA id v24-20020a05651203b800b004b4e6dab30esm4838050lfp.222.2023.01.03.06.01.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jan 2023 06:01:06 -0800 (PST)
Message-ID: <538ed930-af72-ec17-df45-5954d170cbd1@linaro.org>
Date:   Tue, 3 Jan 2023 15:01:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 3/3] clk: qcom: add SM8550 DISPCC driver
Content-Language: en-US
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230103-topic-sm8550-upstream-dispcc-v1-0-81bfcc26b2dc@linaro.org>
 <20230103-topic-sm8550-upstream-dispcc-v1-3-81bfcc26b2dc@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230103-topic-sm8550-upstream-dispcc-v1-3-81bfcc26b2dc@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3.01.2023 14:54, Neil Armstrong wrote:
> Add support for the display clock controller found in SM8550
> based devices.
> 
> This clock controller feeds the Multimedia Display SubSystem (MDSS).
> This driver is based on the SM8450 support.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
I can't see any obvious issues, very nice!

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  drivers/clk/qcom/Kconfig         |    9 +
>  drivers/clk/qcom/Makefile        |    1 +
>  drivers/clk/qcom/dispcc-sm8550.c | 1814 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 1824 insertions(+)
> 
> diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
> index 70d43f0a8919..40f201a516de 100644
> --- a/drivers/clk/qcom/Kconfig
> +++ b/drivers/clk/qcom/Kconfig
> @@ -695,6 +695,15 @@ config SM_DISPCC_8450
>  	  Say Y if you want to support display devices and functionality such as
>  	  splash screen.
>  
> +config SM_DISPCC_8550
> +	tristate "SM8550 Display Clock Controller"
> +	depends on SM_GCC_8550
> +	help
> +	  Support for the display clock controller on Qualcomm Technologies, Inc
> +	  SM8550 devices.
> +	  Say Y if you want to support display devices and functionality such as
> +	  splash screen.
> +
>  config SM_GCC_6115
>  	tristate "SM6115 and SM4250 Global Clock Controller"
>  	select QCOM_GDSC
> diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
> index f18c446a97ea..b830d429d00d 100644
> --- a/drivers/clk/qcom/Makefile
> +++ b/drivers/clk/qcom/Makefile
> @@ -99,6 +99,7 @@ obj-$(CONFIG_SM_DISPCC_6350) += dispcc-sm6350.o
>  obj-$(CONFIG_SM_DISPCC_6375) += dispcc-sm6375.o
>  obj-$(CONFIG_SM_DISPCC_8250) += dispcc-sm8250.o
>  obj-$(CONFIG_SM_DISPCC_8450) += dispcc-sm8450.o
> +obj-$(CONFIG_SM_DISPCC_8550) += dispcc-sm8550.o
>  obj-$(CONFIG_SM_GCC_6115) += gcc-sm6115.o
>  obj-$(CONFIG_SM_GCC_6125) += gcc-sm6125.o
>  obj-$(CONFIG_SM_GCC_6350) += gcc-sm6350.o
> diff --git a/drivers/clk/qcom/dispcc-sm8550.c b/drivers/clk/qcom/dispcc-sm8550.c
> new file mode 100644
> index 000000000000..4d371c07d147
> --- /dev/null
> +++ b/drivers/clk/qcom/dispcc-sm8550.c
> @@ -0,0 +1,1814 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2021-2022, The Linux Foundation. All rights reserved.
> + * Copyright (c) 2023, Linaro Ltd.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/clk-provider.h>
> +#include <linux/err.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/of.h>
> +#include <linux/regmap.h>
> +#include <linux/pm_runtime.h>
> +
> +#include <dt-bindings/clock/qcom,sm8550-dispcc.h>
> +
> +#include "common.h"
> +#include "clk-alpha-pll.h"
> +#include "clk-branch.h"
> +#include "clk-pll.h"
> +#include "clk-rcg.h"
> +#include "clk-regmap.h"
> +#include "clk-regmap-divider.h"
> +#include "clk-regmap-mux.h"
> +#include "reset.h"
> +#include "gdsc.h"
> +
> +/* Need to match the order of clocks in DT binding */
> +enum {
> +	DT_BI_TCXO,
> +	DT_BI_TCXO_AO,
> +	DT_AHB_CLK,
> +	DT_SLEEP_CLK,
> +
> +	DT_DSI0_PHY_PLL_OUT_BYTECLK,
> +	DT_DSI0_PHY_PLL_OUT_DSICLK,
> +	DT_DSI1_PHY_PLL_OUT_BYTECLK,
> +	DT_DSI1_PHY_PLL_OUT_DSICLK,
> +
> +	DT_DP0_PHY_PLL_LINK_CLK,
> +	DT_DP0_PHY_PLL_VCO_DIV_CLK,
> +	DT_DP1_PHY_PLL_LINK_CLK,
> +	DT_DP1_PHY_PLL_VCO_DIV_CLK,
> +	DT_DP2_PHY_PLL_LINK_CLK,
> +	DT_DP2_PHY_PLL_VCO_DIV_CLK,
> +	DT_DP3_PHY_PLL_LINK_CLK,
> +	DT_DP3_PHY_PLL_VCO_DIV_CLK,
> +};
> +
> +#define DISP_CC_MISC_CMD	0xF000
> +
> +enum {
> +	P_BI_TCXO,
> +	P_DISP_CC_PLL0_OUT_MAIN,
> +	P_DISP_CC_PLL1_OUT_EVEN,
> +	P_DISP_CC_PLL1_OUT_MAIN,
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
> +	P_SLEEP_CLK,
> +};
> +
> +static struct pll_vco lucid_ole_vco[] = {
> +	{ 249600000, 2000000000, 0 },
> +};
> +
> +static const struct alpha_pll_config disp_cc_pll0_config = {
> +	.l = 0xd,
> +	.alpha = 0x6492,
> +	.config_ctl_val = 0x20485699,
> +	.config_ctl_hi_val = 0x00182261,
> +	.config_ctl_hi1_val = 0x82aa299c,
> +	.user_ctl_val = 0x00000000,
> +	.user_ctl_hi_val = 0x00000005,
> +};
> +
> +static struct clk_alpha_pll disp_cc_pll0 = {
> +	.offset = 0x0,
> +	.vco_table = lucid_ole_vco,
> +	.num_vco = ARRAY_SIZE(lucid_ole_vco),
> +	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_LUCID_OLE],
> +	.clkr = {
> +		.hw.init = &(struct clk_init_data) {
> +			.name = "disp_cc_pll0",
> +			.parent_data = &(const struct clk_parent_data) {
> +				.index = DT_BI_TCXO,
> +			},
> +			.num_parents = 1,
> +			.ops = &clk_alpha_pll_reset_lucid_ole_ops,
> +		},
> +	},
> +};
> +
> +static const struct alpha_pll_config disp_cc_pll1_config = {
> +	.l = 0x1f,
> +	.alpha = 0x4000,
> +	.config_ctl_val = 0x20485699,
> +	.config_ctl_hi_val = 0x00182261,
> +	.config_ctl_hi1_val = 0x82aa299c,
> +	.user_ctl_val = 0x00000000,
> +	.user_ctl_hi_val = 0x00000005,
> +};
> +
> +static struct clk_alpha_pll disp_cc_pll1 = {
> +	.offset = 0x1000,
> +	.vco_table = lucid_ole_vco,
> +	.num_vco = ARRAY_SIZE(lucid_ole_vco),
> +	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_LUCID_OLE],
> +	.clkr = {
> +		.hw.init = &(struct clk_init_data) {
> +			.name = "disp_cc_pll1",
> +			.parent_data = &(const struct clk_parent_data) {
> +				.index = DT_BI_TCXO,
> +			},
> +			.num_parents = 1,
> +			.ops = &clk_alpha_pll_reset_lucid_ole_ops,
> +		},
> +	},
> +};
> +
> +static const struct parent_map disp_cc_parent_map_0[] = {
> +	{ P_BI_TCXO, 0 },
> +};
> +
> +static const struct clk_parent_data disp_cc_parent_data_0[] = {
> +	{ .index = DT_BI_TCXO },
> +};
> +
> +static const struct clk_parent_data disp_cc_parent_data_0_ao[] = {
> +	{ .index = DT_BI_TCXO_AO },
> +};
> +
> +static const struct parent_map disp_cc_parent_map_1[] = {
> +	{ P_BI_TCXO, 0 },
> +	{ P_DP3_PHY_PLL_VCO_DIV_CLK, 3 },
> +	{ P_DP1_PHY_PLL_VCO_DIV_CLK, 4 },
> +	{ P_DP2_PHY_PLL_VCO_DIV_CLK, 6 },
> +};
> +
> +static const struct clk_parent_data disp_cc_parent_data_1[] = {
> +	{ .index = DT_BI_TCXO },
> +	{ .index = DT_DP3_PHY_PLL_VCO_DIV_CLK },
> +	{ .index = DT_DP1_PHY_PLL_VCO_DIV_CLK },
> +	{ .index = DT_DP2_PHY_PLL_VCO_DIV_CLK },
> +};
> +
> +static const struct parent_map disp_cc_parent_map_2[] = {
> +	{ P_BI_TCXO, 0 },
> +	{ P_DSI0_PHY_PLL_OUT_DSICLK, 1 },
> +	{ P_DSI0_PHY_PLL_OUT_BYTECLK, 2 },
> +	{ P_DSI1_PHY_PLL_OUT_DSICLK, 3 },
> +	{ P_DSI1_PHY_PLL_OUT_BYTECLK, 4 },
> +};
> +
> +static const struct clk_parent_data disp_cc_parent_data_2[] = {
> +	{ .index = DT_BI_TCXO },
> +	{ .index = DT_DSI0_PHY_PLL_OUT_DSICLK },
> +	{ .index = DT_DSI0_PHY_PLL_OUT_BYTECLK },
> +	{ .index = DT_DSI1_PHY_PLL_OUT_DSICLK },
> +	{ .index = DT_DSI1_PHY_PLL_OUT_BYTECLK },
> +};
> +
> +static const struct parent_map disp_cc_parent_map_3[] = {
> +	{ P_BI_TCXO, 0 },
> +	{ P_DP1_PHY_PLL_LINK_CLK, 2 },
> +	{ P_DP2_PHY_PLL_LINK_CLK, 3 },
> +	{ P_DP3_PHY_PLL_LINK_CLK, 4 },
> +};
> +
> +static const struct clk_parent_data disp_cc_parent_data_3[] = {
> +	{ .index = DT_BI_TCXO },
> +	{ .index = DT_DP1_PHY_PLL_LINK_CLK },
> +	{ .index = DT_DP2_PHY_PLL_LINK_CLK },
> +	{ .index = DT_DP3_PHY_PLL_LINK_CLK },
> +};
> +
> +static const struct parent_map disp_cc_parent_map_4[] = {
> +	{ P_BI_TCXO, 0 },
> +	{ P_DP0_PHY_PLL_LINK_CLK, 1 },
> +	{ P_DP1_PHY_PLL_VCO_DIV_CLK, 2 },
> +	{ P_DP3_PHY_PLL_VCO_DIV_CLK, 3 },
> +	{ P_DP1_PHY_PLL_VCO_DIV_CLK, 4 },
> +	{ P_DP2_PHY_PLL_VCO_DIV_CLK, 6 },
> +};
> +
> +static const struct clk_parent_data disp_cc_parent_data_4[] = {
> +	{ .index = DT_BI_TCXO },
> +	{ .index = DT_DP0_PHY_PLL_LINK_CLK },
> +	{ .index = DT_DP0_PHY_PLL_VCO_DIV_CLK },
> +	{ .index = DT_DP3_PHY_PLL_VCO_DIV_CLK },
> +	{ .index = DT_DP1_PHY_PLL_VCO_DIV_CLK },
> +	{ .index = DT_DP2_PHY_PLL_VCO_DIV_CLK },
> +};
> +
> +static const struct parent_map disp_cc_parent_map_5[] = {
> +	{ P_BI_TCXO, 0 },
> +	{ P_DSI0_PHY_PLL_OUT_BYTECLK, 4 },
> +	{ P_DSI1_PHY_PLL_OUT_BYTECLK, 4 },
> +};
> +
> +static const struct clk_parent_data disp_cc_parent_data_5[] = {
> +	{ .index = DT_BI_TCXO },
> +	{ .index = DT_DSI0_PHY_PLL_OUT_BYTECLK },
> +	{ .index = DT_DSI1_PHY_PLL_OUT_BYTECLK },
> +};
> +
> +static const struct parent_map disp_cc_parent_map_6[] = {
> +	{ P_BI_TCXO, 0 },
> +	{ P_DISP_CC_PLL1_OUT_MAIN, 4 },
> +	{ P_DISP_CC_PLL1_OUT_EVEN, 6 },
> +};
> +
> +static const struct clk_parent_data disp_cc_parent_data_6[] = {
> +	{ .index = DT_BI_TCXO },
> +	{ .hw = &disp_cc_pll1.clkr.hw },
> +	{ .hw = &disp_cc_pll1.clkr.hw },
> +};
> +
> +static const struct parent_map disp_cc_parent_map_7[] = {
> +	{ P_BI_TCXO, 0 },
> +	{ P_DP0_PHY_PLL_LINK_CLK, 1 },
> +	{ P_DP1_PHY_PLL_LINK_CLK, 2 },
> +	{ P_DP2_PHY_PLL_LINK_CLK, 3 },
> +	{ P_DP3_PHY_PLL_LINK_CLK, 4 },
> +};
> +
> +static const struct clk_parent_data disp_cc_parent_data_7[] = {
> +	{ .index = DT_BI_TCXO },
> +	{ .index = DT_DP0_PHY_PLL_LINK_CLK },
> +	{ .index = DT_DP1_PHY_PLL_LINK_CLK },
> +	{ .index = DT_DP2_PHY_PLL_LINK_CLK },
> +	{ .index = DT_DP3_PHY_PLL_LINK_CLK },
> +};
> +
> +static const struct parent_map disp_cc_parent_map_8[] = {
> +	{ P_BI_TCXO, 0 },
> +	{ P_DISP_CC_PLL0_OUT_MAIN, 1 },
> +	{ P_DISP_CC_PLL1_OUT_MAIN, 4 },
> +	{ P_DISP_CC_PLL1_OUT_EVEN, 6 },
> +};
> +
> +static const struct clk_parent_data disp_cc_parent_data_8[] = {
> +	{ .index = DT_BI_TCXO },
> +	{ .hw = &disp_cc_pll0.clkr.hw },
> +	{ .hw = &disp_cc_pll1.clkr.hw },
> +	{ .hw = &disp_cc_pll1.clkr.hw },
> +};
> +
> +static const struct parent_map disp_cc_parent_map_9[] = {
> +	{ P_SLEEP_CLK, 0 },
> +};
> +
> +static const struct clk_parent_data disp_cc_parent_data_9[] = {
> +	{ .index = DT_SLEEP_CLK },
> +};
> +
> +static const struct freq_tbl ftbl_disp_cc_mdss_ahb_clk_src[] = {
> +	F(19200000, P_BI_TCXO, 1, 0, 0),
> +	F(37500000, P_DISP_CC_PLL1_OUT_MAIN, 16, 0, 0),
> +	F(75000000, P_DISP_CC_PLL1_OUT_MAIN, 8, 0, 0),
> +	{ }
> +};
> +
> +static struct clk_rcg2 disp_cc_mdss_ahb_clk_src = {
> +	.cmd_rcgr = 0x82e8,
> +	.mnd_width = 0,
> +	.hid_width = 5,
> +	.parent_map = disp_cc_parent_map_6,
> +	.freq_tbl = ftbl_disp_cc_mdss_ahb_clk_src,
> +	.clkr.hw.init = &(struct clk_init_data) {
> +		.name = "disp_cc_mdss_ahb_clk_src",
> +		.parent_data = disp_cc_parent_data_6,
> +		.num_parents = ARRAY_SIZE(disp_cc_parent_data_6),
> +		.flags = CLK_SET_RATE_PARENT,
> +		.ops = &clk_rcg2_shared_ops,
> +	},
> +};
> +
> +static const struct freq_tbl ftbl_disp_cc_mdss_byte0_clk_src[] = {
> +	F(19200000, P_BI_TCXO, 1, 0, 0),
> +	{ }
> +};
> +
> +static struct clk_rcg2 disp_cc_mdss_byte0_clk_src = {
> +	.cmd_rcgr = 0x8108,
> +	.mnd_width = 0,
> +	.hid_width = 5,
> +	.parent_map = disp_cc_parent_map_2,
> +	.freq_tbl = ftbl_disp_cc_mdss_byte0_clk_src,
> +	.clkr.hw.init = &(struct clk_init_data) {
> +		.name = "disp_cc_mdss_byte0_clk_src",
> +		.parent_data = disp_cc_parent_data_2,
> +		.num_parents = ARRAY_SIZE(disp_cc_parent_data_2),
> +		.flags = CLK_SET_RATE_PARENT,
> +		.ops = &clk_byte2_ops,
> +	},
> +};
> +
> +static struct clk_rcg2 disp_cc_mdss_byte1_clk_src = {
> +	.cmd_rcgr = 0x8124,
> +	.mnd_width = 0,
> +	.hid_width = 5,
> +	.parent_map = disp_cc_parent_map_2,
> +	.freq_tbl = ftbl_disp_cc_mdss_byte0_clk_src,
> +	.clkr.hw.init = &(struct clk_init_data) {
> +		.name = "disp_cc_mdss_byte1_clk_src",
> +		.parent_data = disp_cc_parent_data_2,
> +		.num_parents = ARRAY_SIZE(disp_cc_parent_data_2),
> +		.flags = CLK_SET_RATE_PARENT,
> +		.ops = &clk_byte2_ops,
> +	},
> +};
> +
> +static struct clk_rcg2 disp_cc_mdss_dptx0_aux_clk_src = {
> +	.cmd_rcgr = 0x81bc,
> +	.mnd_width = 0,
> +	.hid_width = 5,
> +	.parent_map = disp_cc_parent_map_0,
> +	.freq_tbl = ftbl_disp_cc_mdss_byte0_clk_src,
> +	.clkr.hw.init = &(struct clk_init_data) {
> +		.name = "disp_cc_mdss_dptx0_aux_clk_src",
> +		.parent_data = disp_cc_parent_data_0,
> +		.num_parents = ARRAY_SIZE(disp_cc_parent_data_0),
> +		.flags = CLK_SET_RATE_PARENT,
> +		.ops = &clk_rcg2_ops,
> +	},
> +};
> +
> +static const struct freq_tbl ftbl_disp_cc_mdss_dptx0_link_clk_src[] = {
> +	F(162000, P_DP0_PHY_PLL_LINK_CLK, 1, 0, 0),
> +	F(270000, P_DP0_PHY_PLL_LINK_CLK, 1, 0, 0),
> +	F(540000, P_DP0_PHY_PLL_LINK_CLK, 1, 0, 0),
> +	F(810000, P_DP0_PHY_PLL_LINK_CLK, 1, 0, 0),
> +	{ }
> +};
> +
> +static struct clk_rcg2 disp_cc_mdss_dptx0_link_clk_src = {
> +	.cmd_rcgr = 0x8170,
> +	.mnd_width = 0,
> +	.hid_width = 5,
> +	.parent_map = disp_cc_parent_map_7,
> +	.freq_tbl = ftbl_disp_cc_mdss_dptx0_link_clk_src,
> +	.clkr.hw.init = &(struct clk_init_data) {
> +		.name = "disp_cc_mdss_dptx0_link_clk_src",
> +		.parent_data = disp_cc_parent_data_7,
> +		.num_parents = ARRAY_SIZE(disp_cc_parent_data_7),
> +		.flags = CLK_SET_RATE_PARENT,
> +		.ops = &clk_rcg2_ops,
> +	},
> +};
> +
> +static struct clk_rcg2 disp_cc_mdss_dptx0_pixel0_clk_src = {
> +	.cmd_rcgr = 0x818c,
> +	.mnd_width = 16,
> +	.hid_width = 5,
> +	.parent_map = disp_cc_parent_map_4,
> +	.freq_tbl = ftbl_disp_cc_mdss_byte0_clk_src,
> +	.clkr.hw.init = &(struct clk_init_data) {
> +		.name = "disp_cc_mdss_dptx0_pixel0_clk_src",
> +		.parent_data = disp_cc_parent_data_4,
> +		.num_parents = ARRAY_SIZE(disp_cc_parent_data_4),
> +		.flags = CLK_SET_RATE_PARENT,
> +		.ops = &clk_dp_ops,
> +	},
> +};
> +
> +static struct clk_rcg2 disp_cc_mdss_dptx0_pixel1_clk_src = {
> +	.cmd_rcgr = 0x81a4,
> +	.mnd_width = 16,
> +	.hid_width = 5,
> +	.parent_map = disp_cc_parent_map_4,
> +	.freq_tbl = ftbl_disp_cc_mdss_byte0_clk_src,
> +	.clkr.hw.init = &(struct clk_init_data) {
> +		.name = "disp_cc_mdss_dptx0_pixel1_clk_src",
> +		.parent_data = disp_cc_parent_data_4,
> +		.num_parents = ARRAY_SIZE(disp_cc_parent_data_4),
> +		.flags = CLK_SET_RATE_PARENT,
> +		.ops = &clk_dp_ops,
> +	},
> +};
> +
> +static struct clk_rcg2 disp_cc_mdss_dptx1_aux_clk_src = {
> +	.cmd_rcgr = 0x8220,
> +	.mnd_width = 0,
> +	.hid_width = 5,
> +	.parent_map = disp_cc_parent_map_0,
> +	.freq_tbl = ftbl_disp_cc_mdss_byte0_clk_src,
> +	.clkr.hw.init = &(struct clk_init_data) {
> +		.name = "disp_cc_mdss_dptx1_aux_clk_src",
> +		.parent_data = disp_cc_parent_data_0,
> +		.num_parents = ARRAY_SIZE(disp_cc_parent_data_0),
> +		.flags = CLK_SET_RATE_PARENT,
> +		.ops = &clk_dp_ops,
> +	},
> +};
> +
> +static struct clk_rcg2 disp_cc_mdss_dptx1_link_clk_src = {
> +	.cmd_rcgr = 0x8204,
> +	.mnd_width = 0,
> +	.hid_width = 5,
> +	.parent_map = disp_cc_parent_map_3,
> +	.freq_tbl = ftbl_disp_cc_mdss_dptx0_link_clk_src,
> +	.clkr.hw.init = &(struct clk_init_data) {
> +		.name = "disp_cc_mdss_dptx1_link_clk_src",
> +		.parent_data = disp_cc_parent_data_3,
> +		.num_parents = ARRAY_SIZE(disp_cc_parent_data_3),
> +		.flags = CLK_SET_RATE_PARENT,
> +		.ops = &clk_rcg2_ops,
> +	},
> +};
> +
> +static struct clk_rcg2 disp_cc_mdss_dptx1_pixel0_clk_src = {
> +	.cmd_rcgr = 0x81d4,
> +	.mnd_width = 16,
> +	.hid_width = 5,
> +	.parent_map = disp_cc_parent_map_1,
> +	.freq_tbl = ftbl_disp_cc_mdss_byte0_clk_src,
> +	.clkr.hw.init = &(struct clk_init_data) {
> +		.name = "disp_cc_mdss_dptx1_pixel0_clk_src",
> +		.parent_data = disp_cc_parent_data_1,
> +		.num_parents = ARRAY_SIZE(disp_cc_parent_data_1),
> +		.flags = CLK_SET_RATE_PARENT,
> +		.ops = &clk_dp_ops,
> +	},
> +};
> +
> +static struct clk_rcg2 disp_cc_mdss_dptx1_pixel1_clk_src = {
> +	.cmd_rcgr = 0x81ec,
> +	.mnd_width = 16,
> +	.hid_width = 5,
> +	.parent_map = disp_cc_parent_map_1,
> +	.freq_tbl = ftbl_disp_cc_mdss_byte0_clk_src,
> +	.clkr.hw.init = &(struct clk_init_data) {
> +		.name = "disp_cc_mdss_dptx1_pixel1_clk_src",
> +		.parent_data = disp_cc_parent_data_1,
> +		.num_parents = ARRAY_SIZE(disp_cc_parent_data_1),
> +		.flags = CLK_SET_RATE_PARENT,
> +		.ops = &clk_dp_ops,
> +	},
> +};
> +
> +static struct clk_rcg2 disp_cc_mdss_dptx2_aux_clk_src = {
> +	.cmd_rcgr = 0x8284,
> +	.mnd_width = 0,
> +	.hid_width = 5,
> +	.parent_map = disp_cc_parent_map_0,
> +	.freq_tbl = ftbl_disp_cc_mdss_byte0_clk_src,
> +	.clkr.hw.init = &(struct clk_init_data) {
> +		.name = "disp_cc_mdss_dptx2_aux_clk_src",
> +		.parent_data = disp_cc_parent_data_0,
> +		.num_parents = ARRAY_SIZE(disp_cc_parent_data_0),
> +		.flags = CLK_SET_RATE_PARENT,
> +		.ops = &clk_rcg2_ops,
> +	},
> +};
> +
> +static struct clk_rcg2 disp_cc_mdss_dptx2_link_clk_src = {
> +	.cmd_rcgr = 0x8238,
> +	.mnd_width = 0,
> +	.hid_width = 5,
> +	.parent_map = disp_cc_parent_map_3,
> +	.freq_tbl = ftbl_disp_cc_mdss_dptx0_link_clk_src,
> +	.clkr.hw.init = &(struct clk_init_data) {
> +		.name = "disp_cc_mdss_dptx2_link_clk_src",
> +		.parent_data = disp_cc_parent_data_3,
> +		.num_parents = ARRAY_SIZE(disp_cc_parent_data_3),
> +		.flags = CLK_SET_RATE_PARENT,
> +		.ops = &clk_rcg2_ops,
> +	},
> +};
> +
> +static struct clk_rcg2 disp_cc_mdss_dptx2_pixel0_clk_src = {
> +	.cmd_rcgr = 0x8254,
> +	.mnd_width = 16,
> +	.hid_width = 5,
> +	.parent_map = disp_cc_parent_map_1,
> +	.freq_tbl = ftbl_disp_cc_mdss_byte0_clk_src,
> +	.clkr.hw.init = &(struct clk_init_data) {
> +		.name = "disp_cc_mdss_dptx2_pixel0_clk_src",
> +		.parent_data = disp_cc_parent_data_1,
> +		.num_parents = ARRAY_SIZE(disp_cc_parent_data_1),
> +		.flags = CLK_SET_RATE_PARENT,
> +		.ops = &clk_dp_ops,
> +	},
> +};
> +
> +static struct clk_rcg2 disp_cc_mdss_dptx2_pixel1_clk_src = {
> +	.cmd_rcgr = 0x826c,
> +	.mnd_width = 16,
> +	.hid_width = 5,
> +	.parent_map = disp_cc_parent_map_1,
> +	.freq_tbl = ftbl_disp_cc_mdss_byte0_clk_src,
> +	.clkr.hw.init = &(struct clk_init_data) {
> +		.name = "disp_cc_mdss_dptx2_pixel1_clk_src",
> +		.parent_data = disp_cc_parent_data_1,
> +		.num_parents = ARRAY_SIZE(disp_cc_parent_data_1),
> +		.flags = CLK_SET_RATE_PARENT,
> +		.ops = &clk_dp_ops,
> +	},
> +};
> +
> +static struct clk_rcg2 disp_cc_mdss_dptx3_aux_clk_src = {
> +	.cmd_rcgr = 0x82d0,
> +	.mnd_width = 0,
> +	.hid_width = 5,
> +	.parent_map = disp_cc_parent_map_0,
> +	.freq_tbl = ftbl_disp_cc_mdss_byte0_clk_src,
> +	.clkr.hw.init = &(struct clk_init_data) {
> +		.name = "disp_cc_mdss_dptx3_aux_clk_src",
> +		.parent_data = disp_cc_parent_data_0,
> +		.num_parents = ARRAY_SIZE(disp_cc_parent_data_0),
> +		.flags = CLK_SET_RATE_PARENT,
> +		.ops = &clk_rcg2_ops,
> +	},
> +};
> +
> +static struct clk_rcg2 disp_cc_mdss_dptx3_link_clk_src = {
> +	.cmd_rcgr = 0x82b4,
> +	.mnd_width = 0,
> +	.hid_width = 5,
> +	.parent_map = disp_cc_parent_map_3,
> +	.freq_tbl = ftbl_disp_cc_mdss_dptx0_link_clk_src,
> +	.clkr.hw.init = &(struct clk_init_data) {
> +		.name = "disp_cc_mdss_dptx3_link_clk_src",
> +		.parent_data = disp_cc_parent_data_3,
> +		.num_parents = ARRAY_SIZE(disp_cc_parent_data_3),
> +		.flags = CLK_SET_RATE_PARENT,
> +		.ops = &clk_rcg2_ops,
> +	},
> +};
> +
> +static struct clk_rcg2 disp_cc_mdss_dptx3_pixel0_clk_src = {
> +	.cmd_rcgr = 0x829c,
> +	.mnd_width = 16,
> +	.hid_width = 5,
> +	.parent_map = disp_cc_parent_map_1,
> +	.freq_tbl = ftbl_disp_cc_mdss_byte0_clk_src,
> +	.clkr.hw.init = &(struct clk_init_data) {
> +		.name = "disp_cc_mdss_dptx3_pixel0_clk_src",
> +		.parent_data = disp_cc_parent_data_1,
> +		.num_parents = ARRAY_SIZE(disp_cc_parent_data_1),
> +		.flags = CLK_SET_RATE_PARENT,
> +		.ops = &clk_dp_ops,
> +	},
> +};
> +
> +static struct clk_rcg2 disp_cc_mdss_esc0_clk_src = {
> +	.cmd_rcgr = 0x8140,
> +	.mnd_width = 0,
> +	.hid_width = 5,
> +	.parent_map = disp_cc_parent_map_5,
> +	.freq_tbl = ftbl_disp_cc_mdss_byte0_clk_src,
> +	.clkr.hw.init = &(struct clk_init_data) {
> +		.name = "disp_cc_mdss_esc0_clk_src",
> +		.parent_data = disp_cc_parent_data_5,
> +		.num_parents = ARRAY_SIZE(disp_cc_parent_data_5),
> +		.flags = CLK_SET_RATE_PARENT,
> +		.ops = &clk_rcg2_ops,
> +	},
> +};
> +
> +static struct clk_rcg2 disp_cc_mdss_esc1_clk_src = {
> +	.cmd_rcgr = 0x8158,
> +	.mnd_width = 0,
> +	.hid_width = 5,
> +	.parent_map = disp_cc_parent_map_5,
> +	.freq_tbl = ftbl_disp_cc_mdss_byte0_clk_src,
> +	.clkr.hw.init = &(struct clk_init_data) {
> +		.name = "disp_cc_mdss_esc1_clk_src",
> +		.parent_data = disp_cc_parent_data_5,
> +		.num_parents = ARRAY_SIZE(disp_cc_parent_data_5),
> +		.flags = CLK_SET_RATE_PARENT,
> +		.ops = &clk_rcg2_ops,
> +	},
> +};
> +
> +static const struct freq_tbl ftbl_disp_cc_mdss_mdp_clk_src[] = {
> +	F(19200000, P_BI_TCXO, 1, 0, 0),
> +	F(85714286, P_DISP_CC_PLL0_OUT_MAIN, 3, 0, 0),
> +	F(100000000, P_DISP_CC_PLL0_OUT_MAIN, 3, 0, 0),
> +	F(150000000, P_DISP_CC_PLL0_OUT_MAIN, 3, 0, 0),
> +	F(172000000, P_DISP_CC_PLL0_OUT_MAIN, 3, 0, 0),
> +	F(200000000, P_DISP_CC_PLL0_OUT_MAIN, 3, 0, 0),
> +	F(325000000, P_DISP_CC_PLL0_OUT_MAIN, 3, 0, 0),
> +	F(375000000, P_DISP_CC_PLL0_OUT_MAIN, 3, 0, 0),
> +	F(514000000, P_DISP_CC_PLL0_OUT_MAIN, 3, 0, 0),
> +	{ }
> +};
> +
> +static struct clk_rcg2 disp_cc_mdss_mdp_clk_src = {
> +	.cmd_rcgr = 0x80d8,
> +	.mnd_width = 0,
> +	.hid_width = 5,
> +	.parent_map = disp_cc_parent_map_8,
> +	.freq_tbl = ftbl_disp_cc_mdss_mdp_clk_src,
> +	.clkr.hw.init = &(struct clk_init_data) {
> +		.name = "disp_cc_mdss_mdp_clk_src",
> +		.parent_data = disp_cc_parent_data_8,
> +		.num_parents = ARRAY_SIZE(disp_cc_parent_data_8),
> +		.flags = CLK_SET_RATE_PARENT,
> +		.ops = &clk_rcg2_shared_ops,
> +	},
> +};
> +
> +static struct clk_rcg2 disp_cc_mdss_pclk0_clk_src = {
> +	.cmd_rcgr = 0x80a8,
> +	.mnd_width = 8,
> +	.hid_width = 5,
> +	.parent_map = disp_cc_parent_map_2,
> +	.freq_tbl = ftbl_disp_cc_mdss_byte0_clk_src,
> +	.clkr.hw.init = &(struct clk_init_data) {
> +		.name = "disp_cc_mdss_pclk0_clk_src",
> +		.parent_data = disp_cc_parent_data_2,
> +		.num_parents = ARRAY_SIZE(disp_cc_parent_data_2),
> +		.flags = CLK_SET_RATE_PARENT,
> +		.ops = &clk_pixel_ops,
> +	},
> +};
> +
> +static struct clk_rcg2 disp_cc_mdss_pclk1_clk_src = {
> +	.cmd_rcgr = 0x80c0,
> +	.mnd_width = 8,
> +	.hid_width = 5,
> +	.parent_map = disp_cc_parent_map_2,
> +	.freq_tbl = ftbl_disp_cc_mdss_byte0_clk_src,
> +	.clkr.hw.init = &(struct clk_init_data) {
> +		.name = "disp_cc_mdss_pclk1_clk_src",
> +		.parent_data = disp_cc_parent_data_2,
> +		.num_parents = ARRAY_SIZE(disp_cc_parent_data_2),
> +		.flags = CLK_SET_RATE_PARENT,
> +		.ops = &clk_pixel_ops,
> +	},
> +};
> +
> +static struct clk_rcg2 disp_cc_mdss_vsync_clk_src = {
> +	.cmd_rcgr = 0x80f0,
> +	.mnd_width = 0,
> +	.hid_width = 5,
> +	.parent_map = disp_cc_parent_map_0,
> +	.freq_tbl = ftbl_disp_cc_mdss_byte0_clk_src,
> +	.clkr.hw.init = &(struct clk_init_data) {
> +		.name = "disp_cc_mdss_vsync_clk_src",
> +		.parent_data = disp_cc_parent_data_0,
> +		.num_parents = ARRAY_SIZE(disp_cc_parent_data_0),
> +		.flags = CLK_SET_RATE_PARENT,
> +		.ops = &clk_rcg2_ops,
> +	},
> +};
> +
> +static const struct freq_tbl ftbl_disp_cc_sleep_clk_src[] = {
> +	F(32000, P_SLEEP_CLK, 1, 0, 0),
> +	{ }
> +};
> +
> +static struct clk_rcg2 disp_cc_sleep_clk_src = {
> +	.cmd_rcgr = 0xe05c,
> +	.mnd_width = 0,
> +	.hid_width = 5,
> +	.parent_map = disp_cc_parent_map_9,
> +	.freq_tbl = ftbl_disp_cc_sleep_clk_src,
> +	.clkr.hw.init = &(struct clk_init_data) {
> +		.name = "disp_cc_sleep_clk_src",
> +		.parent_data = disp_cc_parent_data_9,
> +		.num_parents = ARRAY_SIZE(disp_cc_parent_data_9),
> +		.flags = CLK_SET_RATE_PARENT,
> +		.ops = &clk_rcg2_ops,
> +	},
> +};
> +
> +static struct clk_rcg2 disp_cc_xo_clk_src = {
> +	.cmd_rcgr = 0xe03c,
> +	.mnd_width = 0,
> +	.hid_width = 5,
> +	.parent_map = disp_cc_parent_map_0,
> +	.freq_tbl = ftbl_disp_cc_mdss_byte0_clk_src,
> +	.clkr.hw.init = &(struct clk_init_data) {
> +		.name = "disp_cc_xo_clk_src",
> +		.parent_data = disp_cc_parent_data_0_ao,
> +		.num_parents = ARRAY_SIZE(disp_cc_parent_data_0_ao),
> +		.flags = CLK_SET_RATE_PARENT,
> +		.ops = &clk_rcg2_ops,
> +	},
> +};
> +
> +static struct clk_regmap_div disp_cc_mdss_byte0_div_clk_src = {
> +	.reg = 0x8120,
> +	.shift = 0,
> +	.width = 4,
> +	.clkr.hw.init = &(struct clk_init_data) {
> +		.name = "disp_cc_mdss_byte0_div_clk_src",
> +		.parent_data = &(const struct clk_parent_data) {
> +			.hw = &disp_cc_mdss_byte0_clk_src.clkr.hw,
> +		},
> +		.num_parents = 1,
> +		.ops = &clk_regmap_div_ops,
> +	},
> +};
> +
> +static struct clk_regmap_div disp_cc_mdss_byte1_div_clk_src = {
> +	.reg = 0x813c,
> +	.shift = 0,
> +	.width = 4,
> +	.clkr.hw.init = &(struct clk_init_data) {
> +		.name = "disp_cc_mdss_byte1_div_clk_src",
> +		.parent_data = &(const struct clk_parent_data) {
> +			.hw = &disp_cc_mdss_byte1_clk_src.clkr.hw,
> +		},
> +		.num_parents = 1,
> +		.ops = &clk_regmap_div_ops,
> +	},
> +};
> +
> +static struct clk_regmap_div disp_cc_mdss_dptx0_link_div_clk_src = {
> +	.reg = 0x8188,
> +	.shift = 0,
> +	.width = 4,
> +	.clkr.hw.init = &(struct clk_init_data) {
> +		.name = "disp_cc_mdss_dptx0_link_div_clk_src",
> +		.parent_data = &(const struct clk_parent_data) {
> +			.hw = &disp_cc_mdss_dptx0_link_clk_src.clkr.hw,
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +		.ops = &clk_regmap_div_ro_ops,
> +	},
> +};
> +
> +static struct clk_regmap_div disp_cc_mdss_dptx1_link_div_clk_src = {
> +	.reg = 0x821c,
> +	.shift = 0,
> +	.width = 4,
> +	.clkr.hw.init = &(struct clk_init_data) {
> +		.name = "disp_cc_mdss_dptx1_link_div_clk_src",
> +		.parent_data = &(const struct clk_parent_data) {
> +			.hw = &disp_cc_mdss_dptx1_link_clk_src.clkr.hw,
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +		.ops = &clk_regmap_div_ro_ops,
> +	},
> +};
> +
> +static struct clk_regmap_div disp_cc_mdss_dptx2_link_div_clk_src = {
> +	.reg = 0x8250,
> +	.shift = 0,
> +	.width = 4,
> +	.clkr.hw.init = &(struct clk_init_data) {
> +		.name = "disp_cc_mdss_dptx2_link_div_clk_src",
> +		.parent_data = &(const struct clk_parent_data) {
> +			.hw = &disp_cc_mdss_dptx2_link_clk_src.clkr.hw,
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +		.ops = &clk_regmap_div_ro_ops,
> +	},
> +};
> +
> +static struct clk_regmap_div disp_cc_mdss_dptx3_link_div_clk_src = {
> +	.reg = 0x82cc,
> +	.shift = 0,
> +	.width = 4,
> +	.clkr.hw.init = &(struct clk_init_data) {
> +		.name = "disp_cc_mdss_dptx3_link_div_clk_src",
> +		.parent_data = &(const struct clk_parent_data) {
> +			.hw = &disp_cc_mdss_dptx3_link_clk_src.clkr.hw,
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +		.ops = &clk_regmap_div_ro_ops,
> +	},
> +};
> +
> +static struct clk_branch disp_cc_mdss_accu_clk = {
> +	.halt_reg = 0xe058,
> +	.halt_check = BRANCH_HALT_VOTED,
> +	.clkr = {
> +		.enable_reg = 0xe058,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "disp_cc_mdss_accu_clk",
> +			.parent_data = &(const struct clk_parent_data){
> +				.hw = &disp_cc_xo_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch disp_cc_mdss_ahb1_clk = {
> +	.halt_reg = 0xa020,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0xa020,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data) {
> +			.name = "disp_cc_mdss_ahb1_clk",
> +			.parent_data = &(const struct clk_parent_data) {
> +				.hw = &disp_cc_mdss_ahb_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch disp_cc_mdss_ahb_clk = {
> +	.halt_reg = 0x80a4,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x80a4,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data) {
> +			.name = "disp_cc_mdss_ahb_clk",
> +			.parent_data = &(const struct clk_parent_data) {
> +				.hw = &disp_cc_mdss_ahb_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch disp_cc_mdss_byte0_clk = {
> +	.halt_reg = 0x8028,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x8028,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data) {
> +			.name = "disp_cc_mdss_byte0_clk",
> +			.parent_data = &(const struct clk_parent_data) {
> +				.hw = &disp_cc_mdss_byte0_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch disp_cc_mdss_byte0_intf_clk = {
> +	.halt_reg = 0x802c,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x802c,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data) {
> +			.name = "disp_cc_mdss_byte0_intf_clk",
> +			.parent_data = &(const struct clk_parent_data) {
> +				.hw = &disp_cc_mdss_byte0_div_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch disp_cc_mdss_byte1_clk = {
> +	.halt_reg = 0x8030,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x8030,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data) {
> +			.name = "disp_cc_mdss_byte1_clk",
> +			.parent_data = &(const struct clk_parent_data) {
> +				.hw = &disp_cc_mdss_byte1_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch disp_cc_mdss_byte1_intf_clk = {
> +	.halt_reg = 0x8034,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x8034,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data) {
> +			.name = "disp_cc_mdss_byte1_intf_clk",
> +			.parent_data = &(const struct clk_parent_data) {
> +				.hw = &disp_cc_mdss_byte1_div_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch disp_cc_mdss_dptx0_aux_clk = {
> +	.halt_reg = 0x8058,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x8058,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data) {
> +			.name = "disp_cc_mdss_dptx0_aux_clk",
> +			.parent_data = &(const struct clk_parent_data) {
> +				.hw = &disp_cc_mdss_dptx0_aux_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch disp_cc_mdss_dptx0_crypto_clk = {
> +	.halt_reg = 0x804c,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x804c,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data) {
> +			.name = "disp_cc_mdss_dptx0_crypto_clk",
> +			.parent_data = &(const struct clk_parent_data) {
> +				.hw = &disp_cc_mdss_dptx0_link_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch disp_cc_mdss_dptx0_link_clk = {
> +	.halt_reg = 0x8040,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x8040,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data) {
> +			.name = "disp_cc_mdss_dptx0_link_clk",
> +			.parent_data = &(const struct clk_parent_data) {
> +				.hw = &disp_cc_mdss_dptx0_link_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch disp_cc_mdss_dptx0_link_intf_clk = {
> +	.halt_reg = 0x8048,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x8048,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data) {
> +			.name = "disp_cc_mdss_dptx0_link_intf_clk",
> +			.parent_data = &(const struct clk_parent_data) {
> +				.hw = &disp_cc_mdss_dptx0_link_div_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch disp_cc_mdss_dptx0_pixel0_clk = {
> +	.halt_reg = 0x8050,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x8050,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data) {
> +			.name = "disp_cc_mdss_dptx0_pixel0_clk",
> +			.parent_data = &(const struct clk_parent_data) {
> +				.hw = &disp_cc_mdss_dptx0_pixel0_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch disp_cc_mdss_dptx0_pixel1_clk = {
> +	.halt_reg = 0x8054,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x8054,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data) {
> +			.name = "disp_cc_mdss_dptx0_pixel1_clk",
> +			.parent_data = &(const struct clk_parent_data) {
> +				.hw = &disp_cc_mdss_dptx0_pixel1_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch disp_cc_mdss_dptx0_usb_router_link_intf_clk = {
> +	.halt_reg = 0x8044,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x8044,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data) {
> +			.name = "disp_cc_mdss_dptx0_usb_router_link_intf_clk",
> +			.parent_data = &(const struct clk_parent_data) {
> +				.hw = &disp_cc_mdss_dptx0_link_div_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch disp_cc_mdss_dptx1_aux_clk = {
> +	.halt_reg = 0x8074,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x8074,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data) {
> +			.name = "disp_cc_mdss_dptx1_aux_clk",
> +			.parent_data = &(const struct clk_parent_data) {
> +				.hw = &disp_cc_mdss_dptx1_aux_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch disp_cc_mdss_dptx1_crypto_clk = {
> +	.halt_reg = 0x8070,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x8070,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data) {
> +			.name = "disp_cc_mdss_dptx1_crypto_clk",
> +			.parent_data = &(const struct clk_parent_data) {
> +				.hw = &disp_cc_mdss_dptx1_link_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch disp_cc_mdss_dptx1_link_clk = {
> +	.halt_reg = 0x8064,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x8064,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data) {
> +			.name = "disp_cc_mdss_dptx1_link_clk",
> +			.parent_data = &(const struct clk_parent_data) {
> +				.hw = &disp_cc_mdss_dptx1_link_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch disp_cc_mdss_dptx1_link_intf_clk = {
> +	.halt_reg = 0x806c,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x806c,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data) {
> +			.name = "disp_cc_mdss_dptx1_link_intf_clk",
> +			.parent_data = &(const struct clk_parent_data) {
> +				.hw = &disp_cc_mdss_dptx1_link_div_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch disp_cc_mdss_dptx1_pixel0_clk = {
> +	.halt_reg = 0x805c,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x805c,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data) {
> +			.name = "disp_cc_mdss_dptx1_pixel0_clk",
> +			.parent_data = &(const struct clk_parent_data) {
> +				.hw = &disp_cc_mdss_dptx1_pixel0_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch disp_cc_mdss_dptx1_pixel1_clk = {
> +	.halt_reg = 0x8060,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x8060,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data) {
> +			.name = "disp_cc_mdss_dptx1_pixel1_clk",
> +			.parent_data = &(const struct clk_parent_data) {
> +				.hw = &disp_cc_mdss_dptx1_pixel1_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch disp_cc_mdss_dptx1_usb_router_link_intf_clk = {
> +	.halt_reg = 0x8068,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x8068,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data) {
> +			.name = "disp_cc_mdss_dptx1_usb_router_link_intf_clk",
> +			.parent_data = &(const struct clk_parent_data) {
> +				.hw = &disp_cc_mdss_dptx0_link_div_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch disp_cc_mdss_dptx2_aux_clk = {
> +	.halt_reg = 0x808c,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x808c,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data) {
> +			.name = "disp_cc_mdss_dptx2_aux_clk",
> +			.parent_data = &(const struct clk_parent_data) {
> +				.hw = &disp_cc_mdss_dptx2_aux_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch disp_cc_mdss_dptx2_crypto_clk = {
> +	.halt_reg = 0x8088,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x8088,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data) {
> +			.name = "disp_cc_mdss_dptx2_crypto_clk",
> +			.parent_data = &(const struct clk_parent_data) {
> +				.hw = &disp_cc_mdss_dptx2_link_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch disp_cc_mdss_dptx2_link_clk = {
> +	.halt_reg = 0x8080,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x8080,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data) {
> +			.name = "disp_cc_mdss_dptx2_link_clk",
> +			.parent_data = &(const struct clk_parent_data) {
> +				.hw = &disp_cc_mdss_dptx2_link_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch disp_cc_mdss_dptx2_link_intf_clk = {
> +	.halt_reg = 0x8084,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x8084,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data) {
> +			.name = "disp_cc_mdss_dptx2_link_intf_clk",
> +			.parent_data = &(const struct clk_parent_data) {
> +				.hw = &disp_cc_mdss_dptx2_link_div_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch disp_cc_mdss_dptx2_pixel0_clk = {
> +	.halt_reg = 0x8078,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x8078,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data) {
> +			.name = "disp_cc_mdss_dptx2_pixel0_clk",
> +			.parent_data = &(const struct clk_parent_data) {
> +				.hw = &disp_cc_mdss_dptx2_pixel0_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch disp_cc_mdss_dptx2_pixel1_clk = {
> +	.halt_reg = 0x807c,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x807c,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data) {
> +			.name = "disp_cc_mdss_dptx2_pixel1_clk",
> +			.parent_data = &(const struct clk_parent_data) {
> +				.hw = &disp_cc_mdss_dptx2_pixel1_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch disp_cc_mdss_dptx3_aux_clk = {
> +	.halt_reg = 0x809c,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x809c,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data) {
> +			.name = "disp_cc_mdss_dptx3_aux_clk",
> +			.parent_data = &(const struct clk_parent_data) {
> +				.hw = &disp_cc_mdss_dptx3_aux_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch disp_cc_mdss_dptx3_crypto_clk = {
> +	.halt_reg = 0x80a0,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x80a0,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data) {
> +			.name = "disp_cc_mdss_dptx3_crypto_clk",
> +			.parent_data = &(const struct clk_parent_data) {
> +				.hw = &disp_cc_mdss_dptx3_link_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch disp_cc_mdss_dptx3_link_clk = {
> +	.halt_reg = 0x8094,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x8094,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data) {
> +			.name = "disp_cc_mdss_dptx3_link_clk",
> +			.parent_data = &(const struct clk_parent_data) {
> +				.hw = &disp_cc_mdss_dptx3_link_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch disp_cc_mdss_dptx3_link_intf_clk = {
> +	.halt_reg = 0x8098,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x8098,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data) {
> +			.name = "disp_cc_mdss_dptx3_link_intf_clk",
> +			.parent_data = &(const struct clk_parent_data) {
> +				.hw = &disp_cc_mdss_dptx3_link_div_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch disp_cc_mdss_dptx3_pixel0_clk = {
> +	.halt_reg = 0x8090,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x8090,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data) {
> +			.name = "disp_cc_mdss_dptx3_pixel0_clk",
> +			.parent_data = &(const struct clk_parent_data) {
> +				.hw = &disp_cc_mdss_dptx3_pixel0_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch disp_cc_mdss_esc0_clk = {
> +	.halt_reg = 0x8038,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x8038,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data) {
> +			.name = "disp_cc_mdss_esc0_clk",
> +			.parent_data = &(const struct clk_parent_data) {
> +				.hw = &disp_cc_mdss_esc0_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch disp_cc_mdss_esc1_clk = {
> +	.halt_reg = 0x803c,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x803c,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data) {
> +			.name = "disp_cc_mdss_esc1_clk",
> +			.parent_data = &(const struct clk_parent_data) {
> +				.hw = &disp_cc_mdss_esc1_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch disp_cc_mdss_mdp1_clk = {
> +	.halt_reg = 0xa004,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0xa004,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data) {
> +			.name = "disp_cc_mdss_mdp1_clk",
> +			.parent_data = &(const struct clk_parent_data) {
> +				.hw = &disp_cc_mdss_mdp_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch disp_cc_mdss_mdp_clk = {
> +	.halt_reg = 0x800c,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x800c,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data) {
> +			.name = "disp_cc_mdss_mdp_clk",
> +			.parent_data = &(const struct clk_parent_data) {
> +				.hw = &disp_cc_mdss_mdp_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch disp_cc_mdss_mdp_lut1_clk = {
> +	.halt_reg = 0xa010,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0xa010,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data) {
> +			.name = "disp_cc_mdss_mdp_lut1_clk",
> +			.parent_data = &(const struct clk_parent_data) {
> +				.hw = &disp_cc_mdss_mdp_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch disp_cc_mdss_mdp_lut_clk = {
> +	.halt_reg = 0x8018,
> +	.halt_check = BRANCH_HALT_VOTED,
> +	.clkr = {
> +		.enable_reg = 0x8018,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data) {
> +			.name = "disp_cc_mdss_mdp_lut_clk",
> +			.parent_data = &(const struct clk_parent_data) {
> +				.hw = &disp_cc_mdss_mdp_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch disp_cc_mdss_non_gdsc_ahb_clk = {
> +	.halt_reg = 0xc004,
> +	.halt_check = BRANCH_HALT_VOTED,
> +	.clkr = {
> +		.enable_reg = 0xc004,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data) {
> +			.name = "disp_cc_mdss_non_gdsc_ahb_clk",
> +			.parent_data = &(const struct clk_parent_data) {
> +				.hw = &disp_cc_mdss_ahb_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch disp_cc_mdss_pclk0_clk = {
> +	.halt_reg = 0x8004,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x8004,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data) {
> +			.name = "disp_cc_mdss_pclk0_clk",
> +			.parent_data = &(const struct clk_parent_data) {
> +				.hw = &disp_cc_mdss_pclk0_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch disp_cc_mdss_pclk1_clk = {
> +	.halt_reg = 0x8008,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x8008,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data) {
> +			.name = "disp_cc_mdss_pclk1_clk",
> +			.parent_data = &(const struct clk_parent_data) {
> +				.hw = &disp_cc_mdss_pclk1_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch disp_cc_mdss_rscc_ahb_clk = {
> +	.halt_reg = 0xc00c,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0xc00c,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data) {
> +			.name = "disp_cc_mdss_rscc_ahb_clk",
> +			.parent_data = &(const struct clk_parent_data) {
> +				.hw = &disp_cc_mdss_ahb_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch disp_cc_mdss_rscc_vsync_clk = {
> +	.halt_reg = 0xc008,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0xc008,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data) {
> +			.name = "disp_cc_mdss_rscc_vsync_clk",
> +			.parent_data = &(const struct clk_parent_data) {
> +				.hw = &disp_cc_mdss_vsync_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch disp_cc_mdss_vsync1_clk = {
> +	.halt_reg = 0xa01c,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0xa01c,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data) {
> +			.name = "disp_cc_mdss_vsync1_clk",
> +			.parent_data = &(const struct clk_parent_data) {
> +				.hw = &disp_cc_mdss_vsync_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch disp_cc_mdss_vsync_clk = {
> +	.halt_reg = 0x8024,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x8024,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data) {
> +			.name = "disp_cc_mdss_vsync_clk",
> +			.parent_data = &(const struct clk_parent_data) {
> +				.hw = &disp_cc_mdss_vsync_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch disp_cc_sleep_clk = {
> +	.halt_reg = 0xe074,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0xe074,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data) {
> +			.name = "disp_cc_sleep_clk",
> +			.parent_data = &(const struct clk_parent_data) {
> +				.hw = &disp_cc_sleep_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct gdsc mdss_gdsc = {
> +	.gdscr = 0x9000,
> +	.pd = {
> +		.name = "mdss_gdsc",
> +	},
> +	.pwrsts = PWRSTS_OFF_ON,
> +	.flags = HW_CTRL | RETAIN_FF_ENABLE,
> +};
> +
> +static struct gdsc mdss_int2_gdsc = {
> +	.gdscr = 0xb000,
> +	.pd = {
> +		.name = "mdss_int2_gdsc",
> +	},
> +	.pwrsts = PWRSTS_OFF_ON,
> +	.flags = HW_CTRL | RETAIN_FF_ENABLE,
> +};
> +
> +static struct clk_regmap *disp_cc_sm8550_clocks[] = {
> +	[DISP_CC_MDSS_ACCU_CLK] = &disp_cc_mdss_accu_clk.clkr,
> +	[DISP_CC_MDSS_AHB1_CLK] = &disp_cc_mdss_ahb1_clk.clkr,
> +	[DISP_CC_MDSS_AHB_CLK] = &disp_cc_mdss_ahb_clk.clkr,
> +	[DISP_CC_MDSS_AHB_CLK_SRC] = &disp_cc_mdss_ahb_clk_src.clkr,
> +	[DISP_CC_MDSS_BYTE0_CLK] = &disp_cc_mdss_byte0_clk.clkr,
> +	[DISP_CC_MDSS_BYTE0_CLK_SRC] = &disp_cc_mdss_byte0_clk_src.clkr,
> +	[DISP_CC_MDSS_BYTE0_DIV_CLK_SRC] = &disp_cc_mdss_byte0_div_clk_src.clkr,
> +	[DISP_CC_MDSS_BYTE0_INTF_CLK] = &disp_cc_mdss_byte0_intf_clk.clkr,
> +	[DISP_CC_MDSS_BYTE1_CLK] = &disp_cc_mdss_byte1_clk.clkr,
> +	[DISP_CC_MDSS_BYTE1_CLK_SRC] = &disp_cc_mdss_byte1_clk_src.clkr,
> +	[DISP_CC_MDSS_BYTE1_DIV_CLK_SRC] = &disp_cc_mdss_byte1_div_clk_src.clkr,
> +	[DISP_CC_MDSS_BYTE1_INTF_CLK] = &disp_cc_mdss_byte1_intf_clk.clkr,
> +	[DISP_CC_MDSS_DPTX0_AUX_CLK] = &disp_cc_mdss_dptx0_aux_clk.clkr,
> +	[DISP_CC_MDSS_DPTX0_AUX_CLK_SRC] = &disp_cc_mdss_dptx0_aux_clk_src.clkr,
> +	[DISP_CC_MDSS_DPTX0_CRYPTO_CLK] = &disp_cc_mdss_dptx0_crypto_clk.clkr,
> +	[DISP_CC_MDSS_DPTX0_LINK_CLK] = &disp_cc_mdss_dptx0_link_clk.clkr,
> +	[DISP_CC_MDSS_DPTX0_LINK_CLK_SRC] = &disp_cc_mdss_dptx0_link_clk_src.clkr,
> +	[DISP_CC_MDSS_DPTX0_LINK_DIV_CLK_SRC] = &disp_cc_mdss_dptx0_link_div_clk_src.clkr,
> +	[DISP_CC_MDSS_DPTX0_LINK_INTF_CLK] = &disp_cc_mdss_dptx0_link_intf_clk.clkr,
> +	[DISP_CC_MDSS_DPTX0_PIXEL0_CLK] = &disp_cc_mdss_dptx0_pixel0_clk.clkr,
> +	[DISP_CC_MDSS_DPTX0_PIXEL0_CLK_SRC] = &disp_cc_mdss_dptx0_pixel0_clk_src.clkr,
> +	[DISP_CC_MDSS_DPTX0_PIXEL1_CLK] = &disp_cc_mdss_dptx0_pixel1_clk.clkr,
> +	[DISP_CC_MDSS_DPTX0_PIXEL1_CLK_SRC] = &disp_cc_mdss_dptx0_pixel1_clk_src.clkr,
> +	[DISP_CC_MDSS_DPTX0_USB_ROUTER_LINK_INTF_CLK] =
> +		&disp_cc_mdss_dptx0_usb_router_link_intf_clk.clkr,
> +	[DISP_CC_MDSS_DPTX1_AUX_CLK] = &disp_cc_mdss_dptx1_aux_clk.clkr,
> +	[DISP_CC_MDSS_DPTX1_AUX_CLK_SRC] = &disp_cc_mdss_dptx1_aux_clk_src.clkr,
> +	[DISP_CC_MDSS_DPTX1_CRYPTO_CLK] = &disp_cc_mdss_dptx1_crypto_clk.clkr,
> +	[DISP_CC_MDSS_DPTX1_LINK_CLK] = &disp_cc_mdss_dptx1_link_clk.clkr,
> +	[DISP_CC_MDSS_DPTX1_LINK_CLK_SRC] = &disp_cc_mdss_dptx1_link_clk_src.clkr,
> +	[DISP_CC_MDSS_DPTX1_LINK_DIV_CLK_SRC] = &disp_cc_mdss_dptx1_link_div_clk_src.clkr,
> +	[DISP_CC_MDSS_DPTX1_LINK_INTF_CLK] = &disp_cc_mdss_dptx1_link_intf_clk.clkr,
> +	[DISP_CC_MDSS_DPTX1_PIXEL0_CLK] = &disp_cc_mdss_dptx1_pixel0_clk.clkr,
> +	[DISP_CC_MDSS_DPTX1_PIXEL0_CLK_SRC] = &disp_cc_mdss_dptx1_pixel0_clk_src.clkr,
> +	[DISP_CC_MDSS_DPTX1_PIXEL1_CLK] = &disp_cc_mdss_dptx1_pixel1_clk.clkr,
> +	[DISP_CC_MDSS_DPTX1_PIXEL1_CLK_SRC] = &disp_cc_mdss_dptx1_pixel1_clk_src.clkr,
> +	[DISP_CC_MDSS_DPTX1_USB_ROUTER_LINK_INTF_CLK] =
> +		&disp_cc_mdss_dptx1_usb_router_link_intf_clk.clkr,
> +	[DISP_CC_MDSS_DPTX2_AUX_CLK] = &disp_cc_mdss_dptx2_aux_clk.clkr,
> +	[DISP_CC_MDSS_DPTX2_AUX_CLK_SRC] = &disp_cc_mdss_dptx2_aux_clk_src.clkr,
> +	[DISP_CC_MDSS_DPTX2_CRYPTO_CLK] = &disp_cc_mdss_dptx2_crypto_clk.clkr,
> +	[DISP_CC_MDSS_DPTX2_LINK_CLK] = &disp_cc_mdss_dptx2_link_clk.clkr,
> +	[DISP_CC_MDSS_DPTX2_LINK_CLK_SRC] = &disp_cc_mdss_dptx2_link_clk_src.clkr,
> +	[DISP_CC_MDSS_DPTX2_LINK_DIV_CLK_SRC] = &disp_cc_mdss_dptx2_link_div_clk_src.clkr,
> +	[DISP_CC_MDSS_DPTX2_LINK_INTF_CLK] = &disp_cc_mdss_dptx2_link_intf_clk.clkr,
> +	[DISP_CC_MDSS_DPTX2_PIXEL0_CLK] = &disp_cc_mdss_dptx2_pixel0_clk.clkr,
> +	[DISP_CC_MDSS_DPTX2_PIXEL0_CLK_SRC] = &disp_cc_mdss_dptx2_pixel0_clk_src.clkr,
> +	[DISP_CC_MDSS_DPTX2_PIXEL1_CLK] = &disp_cc_mdss_dptx2_pixel1_clk.clkr,
> +	[DISP_CC_MDSS_DPTX2_PIXEL1_CLK_SRC] = &disp_cc_mdss_dptx2_pixel1_clk_src.clkr,
> +	[DISP_CC_MDSS_DPTX3_AUX_CLK] = &disp_cc_mdss_dptx3_aux_clk.clkr,
> +	[DISP_CC_MDSS_DPTX3_AUX_CLK_SRC] = &disp_cc_mdss_dptx3_aux_clk_src.clkr,
> +	[DISP_CC_MDSS_DPTX3_CRYPTO_CLK] = &disp_cc_mdss_dptx3_crypto_clk.clkr,
> +	[DISP_CC_MDSS_DPTX3_LINK_CLK] = &disp_cc_mdss_dptx3_link_clk.clkr,
> +	[DISP_CC_MDSS_DPTX3_LINK_CLK_SRC] = &disp_cc_mdss_dptx3_link_clk_src.clkr,
> +	[DISP_CC_MDSS_DPTX3_LINK_DIV_CLK_SRC] = &disp_cc_mdss_dptx3_link_div_clk_src.clkr,
> +	[DISP_CC_MDSS_DPTX3_LINK_INTF_CLK] = &disp_cc_mdss_dptx3_link_intf_clk.clkr,
> +	[DISP_CC_MDSS_DPTX3_PIXEL0_CLK] = &disp_cc_mdss_dptx3_pixel0_clk.clkr,
> +	[DISP_CC_MDSS_DPTX3_PIXEL0_CLK_SRC] = &disp_cc_mdss_dptx3_pixel0_clk_src.clkr,
> +	[DISP_CC_MDSS_ESC0_CLK] = &disp_cc_mdss_esc0_clk.clkr,
> +	[DISP_CC_MDSS_ESC0_CLK_SRC] = &disp_cc_mdss_esc0_clk_src.clkr,
> +	[DISP_CC_MDSS_ESC1_CLK] = &disp_cc_mdss_esc1_clk.clkr,
> +	[DISP_CC_MDSS_ESC1_CLK_SRC] = &disp_cc_mdss_esc1_clk_src.clkr,
> +	[DISP_CC_MDSS_MDP1_CLK] = &disp_cc_mdss_mdp1_clk.clkr,
> +	[DISP_CC_MDSS_MDP_CLK] = &disp_cc_mdss_mdp_clk.clkr,
> +	[DISP_CC_MDSS_MDP_CLK_SRC] = &disp_cc_mdss_mdp_clk_src.clkr,
> +	[DISP_CC_MDSS_MDP_LUT1_CLK] = &disp_cc_mdss_mdp_lut1_clk.clkr,
> +	[DISP_CC_MDSS_MDP_LUT_CLK] = &disp_cc_mdss_mdp_lut_clk.clkr,
> +	[DISP_CC_MDSS_NON_GDSC_AHB_CLK] = &disp_cc_mdss_non_gdsc_ahb_clk.clkr,
> +	[DISP_CC_MDSS_PCLK0_CLK] = &disp_cc_mdss_pclk0_clk.clkr,
> +	[DISP_CC_MDSS_PCLK0_CLK_SRC] = &disp_cc_mdss_pclk0_clk_src.clkr,
> +	[DISP_CC_MDSS_PCLK1_CLK] = &disp_cc_mdss_pclk1_clk.clkr,
> +	[DISP_CC_MDSS_PCLK1_CLK_SRC] = &disp_cc_mdss_pclk1_clk_src.clkr,
> +	[DISP_CC_MDSS_RSCC_AHB_CLK] = &disp_cc_mdss_rscc_ahb_clk.clkr,
> +	[DISP_CC_MDSS_RSCC_VSYNC_CLK] = &disp_cc_mdss_rscc_vsync_clk.clkr,
> +	[DISP_CC_MDSS_VSYNC1_CLK] = &disp_cc_mdss_vsync1_clk.clkr,
> +	[DISP_CC_MDSS_VSYNC_CLK] = &disp_cc_mdss_vsync_clk.clkr,
> +	[DISP_CC_MDSS_VSYNC_CLK_SRC] = &disp_cc_mdss_vsync_clk_src.clkr,
> +	[DISP_CC_PLL0] = &disp_cc_pll0.clkr,
> +	[DISP_CC_PLL1] = &disp_cc_pll1.clkr,
> +	[DISP_CC_SLEEP_CLK] = &disp_cc_sleep_clk.clkr,
> +	[DISP_CC_SLEEP_CLK_SRC] = &disp_cc_sleep_clk_src.clkr,
> +	[DISP_CC_XO_CLK_SRC] = &disp_cc_xo_clk_src.clkr,
> +};
> +
> +static const struct qcom_reset_map disp_cc_sm8550_resets[] = {
> +	[DISP_CC_MDSS_CORE_BCR] = { 0x8000 },
> +	[DISP_CC_MDSS_CORE_INT2_BCR] = { 0xa000 },
> +	[DISP_CC_MDSS_RSCC_BCR] = { 0xc000 },
> +};
> +
> +static struct gdsc *disp_cc_sm8550_gdscs[] = {
> +	[MDSS_GDSC] = &mdss_gdsc,
> +	[MDSS_INT2_GDSC] = &mdss_int2_gdsc,
> +};
> +
> +static const struct regmap_config disp_cc_sm8550_regmap_config = {
> +	.reg_bits = 32,
> +	.reg_stride = 4,
> +	.val_bits = 32,
> +	.max_register = 0x11008,
> +	.fast_io = true,
> +};
> +
> +static struct qcom_cc_desc disp_cc_sm8550_desc = {
> +	.config = &disp_cc_sm8550_regmap_config,
> +	.clks = disp_cc_sm8550_clocks,
> +	.num_clks = ARRAY_SIZE(disp_cc_sm8550_clocks),
> +	.resets = disp_cc_sm8550_resets,
> +	.num_resets = ARRAY_SIZE(disp_cc_sm8550_resets),
> +	.gdscs = disp_cc_sm8550_gdscs,
> +	.num_gdscs = ARRAY_SIZE(disp_cc_sm8550_gdscs),
> +};
> +
> +static const struct of_device_id disp_cc_sm8550_match_table[] = {
> +	{ .compatible = "qcom,sm8550-dispcc" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, disp_cc_sm8550_match_table);
> +
> +static void disp_cc_sm8550_pm_runtime_disable(void *data)
> +{
> +	pm_runtime_disable(data);
> +}
> +
> +static int disp_cc_sm8550_probe(struct platform_device *pdev)
> +{
> +	struct regmap *regmap;
> +	int ret;
> +
> +	pm_runtime_enable(&pdev->dev);
> +
> +	ret = devm_add_action_or_reset(&pdev->dev, disp_cc_sm8550_pm_runtime_disable, &pdev->dev);
> +	if (ret)
> +		return ret;
> +
> +	ret = pm_runtime_resume_and_get(&pdev->dev);
> +	if (ret)
> +		return ret;
> +
> +	regmap = qcom_cc_map(pdev, &disp_cc_sm8550_desc);
> +	if (IS_ERR(regmap))
> +		return PTR_ERR(regmap);
> +
> +	clk_lucid_evo_pll_configure(&disp_cc_pll0, regmap, &disp_cc_pll0_config);
> +	clk_lucid_evo_pll_configure(&disp_cc_pll1, regmap, &disp_cc_pll1_config);
> +
> +	/* Enable clock gating for MDP clocks */
> +	regmap_update_bits(regmap, DISP_CC_MISC_CMD, 0x10, 0x10);
> +
> +	/*
> +	 * Keep clocks always enabled:
> +	 *	disp_cc_xo_clk
> +	 */
> +	regmap_update_bits(regmap, 0xe054, BIT(0), BIT(0));
> +
> +	ret = qcom_cc_really_probe(pdev, &disp_cc_sm8550_desc, regmap);
> +
> +	pm_runtime_put(&pdev->dev);
> +
> +	return ret;
> +}
> +
> +static struct platform_driver disp_cc_sm8550_driver = {
> +	.probe = disp_cc_sm8550_probe,
> +	.driver = {
> +		.name = "disp_cc-sm8550",
> +		.of_match_table = disp_cc_sm8550_match_table,
> +	},
> +};
> +
> +static int __init disp_cc_sm8550_init(void)
> +{
> +	return platform_driver_register(&disp_cc_sm8550_driver);
> +}
> +subsys_initcall(disp_cc_sm8550_init);
> +
> +static void __exit disp_cc_sm8550_exit(void)
> +{
> +	platform_driver_unregister(&disp_cc_sm8550_driver);
> +}
> +module_exit(disp_cc_sm8550_exit);
> +
> +MODULE_DESCRIPTION("QTI DISPCC SM8550 Driver");
> +MODULE_LICENSE("GPL");
> 
