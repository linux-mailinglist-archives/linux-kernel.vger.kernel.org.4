Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 788B773CACB
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 14:20:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233068AbjFXMUB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 08:20:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233001AbjFXMT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 08:19:59 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 524ED211E
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jun 2023 05:19:57 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4f95bf5c493so1961219e87.3
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jun 2023 05:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687609195; x=1690201195;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yo5jLs27Bb3Y0WpD2kVSihPKuWv56q6pEJ3J3nRrfl4=;
        b=bBA/dwwRFeuVHWRBrZv+q8+Pz/9XENm7myWD6lrUK38qFvsTgd+LL2ckdTuwOWv5Jw
         +Wbr2fZs+6I8Uv8g90G/cjf9cgY2oxcC4RH3ikk8EPdg2kxIk2iZMNYz4JXBQIIk9PZG
         hYoV9SvqACjbi2ZvXjlGjjVIOc5rgVWFlOYOqHPSgy5eU7yBAm5wKMh3mS7yEncHGIMu
         jjJs7LRTVHq/H22YlZNQRnm+WRegbbeJ+HtboyujQlMCypkN39RlP2ZV6RCLOcHWXNxh
         mokidukQ7q1vmWDRBqKGt0LCJzaJoQragkRbNFyL0IUn3sTic+2EFMIBuPMEWX0BTZKG
         Ka6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687609195; x=1690201195;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yo5jLs27Bb3Y0WpD2kVSihPKuWv56q6pEJ3J3nRrfl4=;
        b=l7sHasr8epLIVidNKv3cC9IedDSe4pMUMQF8/pkCiR5uzn7rzftuhKtZ/BIUkCYvDj
         pLWgDbUZj+os1Y4cJ/UOCP/vr7ti4PaByqew0/kYlwXh8sYYcu+tywdQ2AO2PMUFDRZy
         s2h4dGFzXLOIWDxSxAVC0VfrXyPDiui1snsm7nxFoyP7RDpkKWo20W/cXJp7wl3nRelI
         DujNcLQm1Bd+EqAafjPtCGPeQyEf+kgI5ITPIjtUt+xEjy0t/ahu9VqZr7xy3VJXRUG5
         wmZDh4lpZhG7ngJKRehuTcfwoDctgEElMvY+YkF+lBqIskAWuDJl5iXrDvXW4K64UBox
         6i7g==
X-Gm-Message-State: AC+VfDynOf2DK8ZlO2OxryVRT1nCrBDNoYWqA/qoHoGiUl69TEduDgat
        1PkVu5rveD0b+0jFLXjl4sjf2A==
X-Google-Smtp-Source: ACHHUZ62rcxA1M3Lq/7vsziq8B2mV6GSeLlw3qy08Pm0fUwdUI9zmmBh2QsLTq2EItwXtwkP7npHHg==
X-Received: by 2002:a19:5e0b:0:b0:4f8:72fd:ed95 with SMTP id s11-20020a195e0b000000b004f872fded95mr9695553lfb.22.1687609195477;
        Sat, 24 Jun 2023 05:19:55 -0700 (PDT)
Received: from [192.168.1.101] (abyk197.neoplus.adsl.tpnet.pl. [83.9.30.197])
        by smtp.gmail.com with ESMTPSA id a6-20020a19f806000000b004f8653b60e3sm259929lff.97.2023.06.24.05.19.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Jun 2023 05:19:55 -0700 (PDT)
Message-ID: <11b3058c-2261-95a4-2347-b0a33fdeb1e3@linaro.org>
Date:   Sat, 24 Jun 2023 14:19:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH V5 4/5] clk: qcom: camcc-sm8550: Add support for qdss,
 sleep and xo clocks
Content-Language: en-US
To:     Jagadeesh Kona <quic_jkona@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Taniya Das <quic_tdas@quicinc.com>,
        Satya Priya Kakitapalli <quic_skakitap@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        Ajit Pandey <quic_ajipan@quicinc.com>
References: <20230623164619.11464-1-quic_jkona@quicinc.com>
 <20230623164619.11464-5-quic_jkona@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230623164619.11464-5-quic_jkona@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.06.2023 18:46, Jagadeesh Kona wrote:
> Add support for camera qdss, sleep and xo clocks.
> 
> Co-developed-by: Taniya Das <quic_tdas@quicinc.com>
> Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
> Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
> ---
> Changes since v4:
>  - No changes.
> Changes since v3:
>  - No changes.
> Changes since v2:
>  - No changes.
> Changes since v1:
>  - Newly added.
> 
>  drivers/clk/qcom/camcc-sm8550.c | 180 ++++++++++++++++++++++++++++++++
>  1 file changed, 180 insertions(+)
> 
> diff --git a/drivers/clk/qcom/camcc-sm8550.c b/drivers/clk/qcom/camcc-sm8550.c
> index 075bea32087c..7b4882444d58 100644
> --- a/drivers/clk/qcom/camcc-sm8550.c
> +++ b/drivers/clk/qcom/camcc-sm8550.c
> @@ -22,6 +22,8 @@
>  enum {
>  	DT_IFACE,
>  	DT_BI_TCXO,
> +	DT_BI_TCXO_AO,
> +	DT_SLEEP_CLK,
>  };
>  
>  enum {
> @@ -43,6 +45,7 @@ enum {
>  	P_CAM_CC_PLL10_OUT_EVEN,
>  	P_CAM_CC_PLL11_OUT_EVEN,
>  	P_CAM_CC_PLL12_OUT_EVEN,
> +	P_SLEEP_CLK,
>  };
>  
>  static const struct pll_vco lucid_ole_vco[] = {
> @@ -881,6 +884,22 @@ static const struct clk_parent_data cam_cc_parent_data_11[] = {
>  	{ .hw = &cam_cc_pll7_out_even.clkr.hw },
>  };
>  
> +static const struct parent_map cam_cc_parent_map_12[] = {
> +	{ P_SLEEP_CLK, 0 },
> +};
> +
> +static const struct clk_parent_data cam_cc_parent_data_12[] = {
> +	{ .index = DT_SLEEP_CLK },
> +};
> +
> +static const struct parent_map cam_cc_parent_map_13[] = {
> +	{ P_BI_TCXO, 0 },
> +};
> +
> +static const struct clk_parent_data cam_cc_parent_data_13_ao[] = {
> +	{ .index = DT_BI_TCXO_AO },
> +};
> +
>  static const struct freq_tbl ftbl_cam_cc_bps_clk_src[] = {
>  	F(19200000, P_BI_TCXO, 1, 0, 0),
>  	F(200000000, P_CAM_CC_PLL8_OUT_EVEN, 1, 0, 0),
> @@ -1565,6 +1584,29 @@ static struct clk_rcg2 cam_cc_mclk7_clk_src = {
>  	},
>  };
>  
> +static const struct freq_tbl ftbl_cam_cc_qdss_debug_clk_src[] = {
> +	F(19200000, P_BI_TCXO, 1, 0, 0),
> +	F(75000000, P_CAM_CC_PLL0_OUT_EVEN, 8, 0, 0),
> +	F(150000000, P_CAM_CC_PLL0_OUT_EVEN, 4, 0, 0),
> +	F(300000000, P_CAM_CC_PLL0_OUT_MAIN, 4, 0, 0),
> +	{ }
> +};
> +
> +static struct clk_rcg2 cam_cc_qdss_debug_clk_src = {
> +	.cmd_rcgr = 0x13f24,
> +	.mnd_width = 0,
> +	.hid_width = 5,
> +	.parent_map = cam_cc_parent_map_0,
> +	.freq_tbl = ftbl_cam_cc_qdss_debug_clk_src,
> +	.clkr.hw.init = &(const struct clk_init_data) {
> +		.name = "cam_cc_qdss_debug_clk_src",
> +		.parent_data = cam_cc_parent_data_0,
> +		.num_parents = ARRAY_SIZE(cam_cc_parent_data_0),
> +		.flags = CLK_SET_RATE_PARENT,
> +		.ops = &clk_rcg2_shared_ops,
> +	},
> +};
> +
>  static const struct freq_tbl ftbl_cam_cc_sfe_0_clk_src[] = {
>  	F(466000000, P_CAM_CC_PLL6_OUT_EVEN, 1, 0, 0),
>  	F(594000000, P_CAM_CC_PLL6_OUT_EVEN, 1, 0, 0),
> @@ -1611,6 +1653,26 @@ static struct clk_rcg2 cam_cc_sfe_1_clk_src = {
>  	},
>  };
>  
> +static const struct freq_tbl ftbl_cam_cc_sleep_clk_src[] = {
> +	F(32000, P_SLEEP_CLK, 1, 0, 0),
> +	{ }
> +};
> +
> +static struct clk_rcg2 cam_cc_sleep_clk_src = {
> +	.cmd_rcgr = 0x141a0,
> +	.mnd_width = 0,
> +	.hid_width = 5,
> +	.parent_map = cam_cc_parent_map_12,
> +	.freq_tbl = ftbl_cam_cc_sleep_clk_src,
> +	.clkr.hw.init = &(const struct clk_init_data) {
> +		.name = "cam_cc_sleep_clk_src",
> +		.parent_data = cam_cc_parent_data_12,
> +		.num_parents = ARRAY_SIZE(cam_cc_parent_data_12),
> +		.flags = CLK_SET_RATE_PARENT,
> +		.ops = &clk_rcg2_shared_ops,
> +	},
> +};
> +
>  static const struct freq_tbl ftbl_cam_cc_slow_ahb_clk_src[] = {
>  	F(19200000, P_BI_TCXO, 1, 0, 0),
>  	F(80000000, P_CAM_CC_PLL0_OUT_EVEN, 7.5, 0, 0),
> @@ -1632,6 +1694,26 @@ static struct clk_rcg2 cam_cc_slow_ahb_clk_src = {
>  	},
>  };
>  
> +static const struct freq_tbl ftbl_cam_cc_xo_clk_src[] = {
> +	F(19200000, P_BI_TCXO, 1, 0, 0),
You're overloading P_BI_TCXO with a different parent clock (XO_A).

The rest lgtm

Konrad
> +	{ }
> +};
> +
> +static struct clk_rcg2 cam_cc_xo_clk_src = {
> +	.cmd_rcgr = 0x14070,
> +	.mnd_width = 0,
> +	.hid_width = 5,
> +	.parent_map = cam_cc_parent_map_13,
> +	.freq_tbl = ftbl_cam_cc_xo_clk_src,
> +	.clkr.hw.init = &(const struct clk_init_data) {
> +		.name = "cam_cc_xo_clk_src",
> +		.parent_data = cam_cc_parent_data_13_ao,
> +		.num_parents = ARRAY_SIZE(cam_cc_parent_data_13_ao),
> +		.flags = CLK_SET_RATE_PARENT,
> +		.ops = &clk_rcg2_shared_ops,
> +	},
> +};
> +
>  static struct clk_branch cam_cc_bps_ahb_clk = {
>  	.halt_reg = 0x10274,
>  	.halt_check = BRANCH_HALT,
> @@ -1704,6 +1786,42 @@ static struct clk_branch cam_cc_camnoc_axi_clk = {
>  	},
>  };
>  
> +static struct clk_branch cam_cc_camnoc_dcd_xo_clk = {
> +	.halt_reg = 0x13f18,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x13f18,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(const struct clk_init_data) {
> +			.name = "cam_cc_camnoc_dcd_xo_clk",
> +			.parent_hws = (const struct clk_hw*[]) {
> +				&cam_cc_xo_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch cam_cc_camnoc_xo_clk = {
> +	.halt_reg = 0x13f1c,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x13f1c,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(const struct clk_init_data) {
> +			.name = "cam_cc_camnoc_xo_clk",
> +			.parent_hws = (const struct clk_hw*[]) {
> +				&cam_cc_xo_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
>  static struct clk_branch cam_cc_cci_0_clk = {
>  	.halt_reg = 0x13a2c,
>  	.halt_check = BRANCH_HALT,
> @@ -2370,6 +2488,24 @@ static struct clk_branch cam_cc_drv_ahb_clk = {
>  	},
>  };
>  
> +static struct clk_branch cam_cc_drv_xo_clk = {
> +	.halt_reg = 0x142d4,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x142d4,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(const struct clk_init_data) {
> +			.name = "cam_cc_drv_xo_clk",
> +			.parent_hws = (const struct clk_hw*[]) {
> +				&cam_cc_xo_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
>  static struct clk_branch cam_cc_icp_ahb_clk = {
>  	.halt_reg = 0x138fc,
>  	.halt_check = BRANCH_HALT,
> @@ -2910,6 +3046,42 @@ static struct clk_branch cam_cc_mclk7_clk = {
>  	},
>  };
>  
> +static struct clk_branch cam_cc_qdss_debug_clk = {
> +	.halt_reg = 0x14050,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x14050,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(const struct clk_init_data) {
> +			.name = "cam_cc_qdss_debug_clk",
> +			.parent_hws = (const struct clk_hw*[]) {
> +				&cam_cc_qdss_debug_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch cam_cc_qdss_debug_xo_clk = {
> +	.halt_reg = 0x14054,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x14054,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(const struct clk_init_data) {
> +			.name = "cam_cc_qdss_debug_xo_clk",
> +			.parent_hws = (const struct clk_hw*[]) {
> +				&cam_cc_xo_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
>  static struct clk_branch cam_cc_sbi_clk = {
>  	.halt_reg = 0x10540,
>  	.halt_check = BRANCH_HALT,
> @@ -3133,6 +3305,8 @@ static struct clk_regmap *cam_cc_sm8550_clocks[] = {
>  	[CAM_CC_BPS_FAST_AHB_CLK] = &cam_cc_bps_fast_ahb_clk.clkr,
>  	[CAM_CC_CAMNOC_AXI_CLK] = &cam_cc_camnoc_axi_clk.clkr,
>  	[CAM_CC_CAMNOC_AXI_CLK_SRC] = &cam_cc_camnoc_axi_clk_src.clkr,
> +	[CAM_CC_CAMNOC_DCD_XO_CLK] = &cam_cc_camnoc_dcd_xo_clk.clkr,
> +	[CAM_CC_CAMNOC_XO_CLK] = &cam_cc_camnoc_xo_clk.clkr,
>  	[CAM_CC_CCI_0_CLK] = &cam_cc_cci_0_clk.clkr,
>  	[CAM_CC_CCI_0_CLK_SRC] = &cam_cc_cci_0_clk_src.clkr,
>  	[CAM_CC_CCI_1_CLK] = &cam_cc_cci_1_clk.clkr,
> @@ -3184,6 +3358,7 @@ static struct clk_regmap *cam_cc_sm8550_clocks[] = {
>  	[CAM_CC_CSIPHY6_CLK] = &cam_cc_csiphy6_clk.clkr,
>  	[CAM_CC_CSIPHY7_CLK] = &cam_cc_csiphy7_clk.clkr,
>  	[CAM_CC_DRV_AHB_CLK] = &cam_cc_drv_ahb_clk.clkr,
> +	[CAM_CC_DRV_XO_CLK] = &cam_cc_drv_xo_clk.clkr,
>  	[CAM_CC_FAST_AHB_CLK_SRC] = &cam_cc_fast_ahb_clk_src.clkr,
>  	[CAM_CC_ICP_AHB_CLK] = &cam_cc_icp_ahb_clk.clkr,
>  	[CAM_CC_ICP_CLK] = &cam_cc_icp_clk.clkr,
> @@ -3260,6 +3435,9 @@ static struct clk_regmap *cam_cc_sm8550_clocks[] = {
>  	[CAM_CC_PLL11_OUT_EVEN] = &cam_cc_pll11_out_even.clkr,
>  	[CAM_CC_PLL12] = &cam_cc_pll12.clkr,
>  	[CAM_CC_PLL12_OUT_EVEN] = &cam_cc_pll12_out_even.clkr,
> +	[CAM_CC_QDSS_DEBUG_CLK] = &cam_cc_qdss_debug_clk.clkr,
> +	[CAM_CC_QDSS_DEBUG_CLK_SRC] = &cam_cc_qdss_debug_clk_src.clkr,
> +	[CAM_CC_QDSS_DEBUG_XO_CLK] = &cam_cc_qdss_debug_xo_clk.clkr,
>  	[CAM_CC_SBI_CLK] = &cam_cc_sbi_clk.clkr,
>  	[CAM_CC_SBI_FAST_AHB_CLK] = &cam_cc_sbi_fast_ahb_clk.clkr,
>  	[CAM_CC_SFE_0_CLK] = &cam_cc_sfe_0_clk.clkr,
> @@ -3268,7 +3446,9 @@ static struct clk_regmap *cam_cc_sm8550_clocks[] = {
>  	[CAM_CC_SFE_1_CLK] = &cam_cc_sfe_1_clk.clkr,
>  	[CAM_CC_SFE_1_CLK_SRC] = &cam_cc_sfe_1_clk_src.clkr,
>  	[CAM_CC_SFE_1_FAST_AHB_CLK] = &cam_cc_sfe_1_fast_ahb_clk.clkr,
> +	[CAM_CC_SLEEP_CLK_SRC] = &cam_cc_sleep_clk_src.clkr,
>  	[CAM_CC_SLOW_AHB_CLK_SRC] = &cam_cc_slow_ahb_clk_src.clkr,
> +	[CAM_CC_XO_CLK_SRC] = &cam_cc_xo_clk_src.clkr,
>  };
>  
>  static struct gdsc *cam_cc_sm8550_gdscs[] = {
