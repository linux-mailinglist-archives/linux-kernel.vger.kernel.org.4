Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E3C967D83A
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 23:12:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232075AbjAZWMQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 17:12:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbjAZWMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 17:12:15 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E7D438659
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 14:12:13 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id i17so1386432ila.9
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 14:12:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PH5bYda4UNvBQbrP3sSsZzNGvFBGhD2UePSzdVYPBSE=;
        b=Jxu2paTDCzqX2ZdByp8uGp/ZUXkFphjS2x6wEZrihFtVNb51FJ//0/eqlZLztRC2rl
         1IcOpw5f+Pg7VG04V8iNuzPu7pKFHTz9zgGAULZzd0n+WH4zrHpPgEV972X2MrOO2jsM
         WKzkr7x2eke75d5s0PJ9LLCS+9+PEmJGjCi5IVtBaBAxiHiwMX6pYP43F/m9iB/dbCDq
         jToofTJoxw9Ywbe4EFLryYd0wf71LvHlmBVNDiTZElPSo4XpPrVuc96RSFKgAp8WrCqy
         tud4YX/IDe9uGbavcxFWiu1Tila+knQBQByZT3FX0cBEusmwKZN0/jYadS6Ikkeig0RI
         ywuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PH5bYda4UNvBQbrP3sSsZzNGvFBGhD2UePSzdVYPBSE=;
        b=0hKztVkke9YB5HCUuG2G8Kut3wx3ZSxW9hYddtBs27NgM0frDI9OaPDkQZOX/ZEr3x
         t+tR0Dk9dhdbnFgTNGmdvIC1mcTKhtrBBsEuzfvqROLi6J0kerHG/rsH+GVflzmv+G5X
         l396aGeadqBJOfMZd8HnMY0uU6dTvLSDu5C25+toG0SVDRYStbS70/oy/BherAKsBBqL
         d2LW05WsS0nQ0VBcAuf90tZtYTBt8hiGJpDAzDHgrd95Y6JA7L2oZWPQP0aB64WIwicX
         dg3wT8KIjTPV+rU/bgzQ6t959iUlmJsex98yrUq4mmA+LXDUzwD7BNELYLUwMWpGAFdZ
         y6kw==
X-Gm-Message-State: AO0yUKWQ3IEBnRyhBQDSEE12sScO0wXVSfOTaKKM8eLQME7DxAACxuKB
        Ymi/iufJ0br90hVc3NT5BhkxAQ==
X-Google-Smtp-Source: AK7set/EJ1dXjthCHXs/J2OOXy51vDxyFCKtXch5kSdtM5JcNkzDVoRI5CduvPkI76BJGfPLePa5Iw==
X-Received: by 2002:a05:6e02:1a85:b0:310:a34b:b1c0 with SMTP id k5-20020a056e021a8500b00310a34bb1c0mr5852660ilv.10.1674771132595;
        Thu, 26 Jan 2023 14:12:12 -0800 (PST)
Received: from [192.168.2.31] ([194.204.33.9])
        by smtp.gmail.com with ESMTPSA id h31-20020a022b1f000000b00363f8e0ab41sm808132jaa.152.2023.01.26.14.12.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jan 2023 14:12:12 -0800 (PST)
Message-ID: <acbb8d20-2e7e-e38c-9edb-8f8fa203a094@linaro.org>
Date:   Fri, 27 Jan 2023 00:12:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2 2/6] clk: qcom: Add GPU clock controller driver for
 SM6125
Content-Language: en-GB
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
References: <20230126181335.12970-1-konrad.dybcio@linaro.org>
 <20230126181335.12970-3-konrad.dybcio@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230126181335.12970-3-konrad.dybcio@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/01/2023 20:13, Konrad Dybcio wrote:
> Add support for the GPU clock controller found on SM6125.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
> v1 -> v2:
> 
> - Add "depends on" (Krzysztof)

With three nits fixed,

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> 
>   drivers/clk/qcom/Kconfig        |   9 +
>   drivers/clk/qcom/Makefile       |   1 +
>   drivers/clk/qcom/gpucc-sm6125.c | 444 ++++++++++++++++++++++++++++++++
>   3 files changed, 454 insertions(+)
>   create mode 100644 drivers/clk/qcom/gpucc-sm6125.c
> 

[skipped]

> +static struct clk_branch gpu_cc_gx_gfx3d_clk = {
> +	.halt_reg = 0x1054,
> +	.halt_check = BRANCH_HALT_SKIP,
> +	.clkr = {
> +		.enable_reg = 0x1054,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gpu_cc_gx_gfx3d_clk",
> +			.parent_data = &(const struct clk_parent_data) {
> +				.hw = &gpu_cc_gx_gfx3d_clk_src.clkr.hw,
> +			},

parent_hws

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
> +			.parent_data = &(const struct clk_parent_data) {
> +				.hw = &gpu_cc_gx_gfx3d_clk.clkr.hw,
> +			},

parent_hws

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
> +			.parent_data = &(const struct clk_parent_data) {

parent_hws

> +				.hw = &gpu_cc_gmu_clk_src.clkr.hw,
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
> +	unsigned int value, mask;
> +
> +	regmap = qcom_cc_map(pdev, &gpu_cc_sm6125_desc);
> +	if (IS_ERR(regmap))
> +		return PTR_ERR(regmap);
> +
> +	clk_alpha_pll_configure(&gpu_cc_pll0_out_aux2, regmap, &gpu_pll0_config);
> +	clk_alpha_pll_configure(&gpu_cc_pll1_out_aux2, regmap, &gpu_pll1_config);
> +
> +	/* Recommended WAKEUP/SLEEP settings for the gpu_cc_cx_gmu_clk */
> +	mask = CX_GMU_CBCR_WAKE_MASK << CX_GMU_CBCR_WAKE_SHIFT;
> +	mask |= CX_GMU_CBCR_SLEEP_MASK << CX_GMU_CBCR_SLEEP_SHIFT;
> +	value = 0xf << CX_GMU_CBCR_WAKE_SHIFT | 0xf << CX_GMU_CBCR_SLEEP_SHIFT;
> +	regmap_update_bits(regmap, gpu_cc_cx_gmu_clk.clkr.enable_reg, mask, value);
> +
> +	/* Set up PERIPH/MEM retain on the GPU core clock */
> +	regmap_update_bits(regmap, gpu_cc_gx_gfx3d_clk.halt_reg,
> +			   (BIT(14) | BIT(13)), (BIT(14) | BIT(13)));
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
> +
> +static int __init gpu_cc_sm6125_init(void)
> +{
> +	return platform_driver_register(&gpu_cc_sm6125_driver);
> +}
> +subsys_initcall(gpu_cc_sm6125_init);
> +
> +static void __exit gpu_cc_sm6125_exit(void)
> +{
> +	platform_driver_unregister(&gpu_cc_sm6125_driver);
> +}
> +module_exit(gpu_cc_sm6125_exit);
> +
> +MODULE_DESCRIPTION("QTI GPUCC SM6125 Driver");
> +MODULE_LICENSE("GPL");

-- 
With best wishes
Dmitry

