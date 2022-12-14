Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8C0C64CDF2
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 17:25:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238547AbiLNQZI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 11:25:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238969AbiLNQZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 11:25:05 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D06926AB4
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 08:25:04 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id g14so7090565ljh.10
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 08:25:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X9dLBk+UvJ4GGITPeSeolCfzI5QUbeeelXxES7ST1nA=;
        b=T5G2vJ4vOoMXdUA/9S7c2+Yae3QPm+f2bdcTXQF3fD2C4OqCHUNBGVQEY+WhP4I2W4
         SW9F56rFJO0LVa5NMoT1DpLLftG5sJuyTaKevL6dPhS5Yj4ZziJRJYRLn9qPuhLRP3Bp
         tbhTjFeaOubm2gvffyOuQBstCaZokYT+w081Gepp9IW53Lk+mcnxVKsIIVmqkHFsDR3w
         d65jU073a0JqbDuc3awKzQeondMQqTXWOOjVkYFauGjAcagCCuOQrVRCfocDSK2ezYCe
         OH6vyqQZuc+0YE6KVz7QMtAVo3a94aFJj08CeXVbxyxUDCRBzQQ4tS2mmZfr9bZ/Mc6S
         KcfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X9dLBk+UvJ4GGITPeSeolCfzI5QUbeeelXxES7ST1nA=;
        b=nwHH5W2jdC/HCtBagsjFSoTPalrxFVb3RniAbnbzjTC6TVhOwaNJ2x6ijDOu5qj9AO
         gbCrBkadh9WKXLTwUZsVWQrLZwoaS5G8BSBxI9EJUoDSdpYvbn6IQkDznBCSnQpa2rkF
         t/UDRwVdS7mxskuibDFZoZD2jcUgg9EG+Dt/vsh7BZ0PBHuyVQIXQOtOGxr6grS0385K
         EAN8WBnktq42/L/FwOBsUzE3LjhsPkT5Wl9oacecHCnLhCIuN7Ujf1FSVngQUALhwMva
         I6TMUu+6EpQANG3fcAR3A28XvJ3yIzYLSCOj35nyRu+exBXAlM0lVMWyutbmOjLdpEBJ
         R+Lg==
X-Gm-Message-State: ANoB5plYk0h+lS0JlUqfI6Rz6DrL2Paze4+zakl47znEow8VuEFX3wAg
        sFEF/v3qoVx+U/u4kvI6WBX3jw==
X-Google-Smtp-Source: AA0mqf7duV2/358tTC/pnwCBvsLRoFvgwzJqOeoEBv6o3iLr9aNv/23ln7Vx+bKA6lr+wk4/+y97Bg==
X-Received: by 2002:a05:651c:158d:b0:26f:db35:1d5a with SMTP id h13-20020a05651c158d00b0026fdb351d5amr6588903ljq.4.1671035102622;
        Wed, 14 Dec 2022 08:25:02 -0800 (PST)
Received: from [10.10.15.130] ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id b12-20020a05651c032c00b0027b52a73b47sm654314ljp.18.2022.12.14.08.25.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Dec 2022 08:25:02 -0800 (PST)
Message-ID: <6fc64fae-e616-2038-0424-34ce0cb7e16d@linaro.org>
Date:   Wed, 14 Dec 2022 18:25:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v6 4/5] clk: qcom: rpmh: Add support for SM8550 rpmh
 clocks
Content-Language: en-GB
To:     Abel Vesa <abel.vesa@linaro.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org
References: <20221206224515.1495457-1-abel.vesa@linaro.org>
 <20221206224515.1495457-5-abel.vesa@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20221206224515.1495457-5-abel.vesa@linaro.org>
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

On 07/12/2022 00:45, Abel Vesa wrote:
> Adds the RPMH clocks present in SM8550 SoC.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>   drivers/clk/qcom/clk-rpmh.c | 110 +++++++++++++++++++++++++++++-------
>   1 file changed, 90 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/clk/qcom/clk-rpmh.c b/drivers/clk/qcom/clk-rpmh.c
> index 2c2ef4b6d130..ce81c76ed0fd 100644
> --- a/drivers/clk/qcom/clk-rpmh.c
> +++ b/drivers/clk/qcom/clk-rpmh.c
> @@ -130,6 +130,34 @@ static DEFINE_MUTEX(rpmh_clk_lock);
>   		},							\
>   	}
>   
> +#define DEFINE_CLK_FIXED_FACTOR(_name, _parent_name, _div)		\
> +	static struct clk_fixed_factor clk_fixed_factor##_##_name = {	\
> +		.mult = 1,						\
> +		.div = _div,						\
> +		.hw.init = &(struct clk_init_data){			\
> +			.ops = &clk_fixed_factor_ops,			\
> +			.name = #_name,					\
> +			.parent_data =  &(const struct clk_parent_data){ \
> +				.fw_name = #_parent_name,		\
> +				.name = #_parent_name,			\
> +			},						\
> +			.num_parents = 1,				\
> +		},							\
> +	};								\
> +	static struct clk_fixed_factor clk_fixed_factor##_##_name##_ao = { \
> +		.mult = 1,						\
> +		.div = _div,						\
> +		.hw.init = &(struct clk_init_data){			\
> +			.ops = &clk_fixed_factor_ops,			\
> +			.name = #_name "_ao",				\
> +			.parent_data =  &(const struct clk_parent_data){ \
> +				.fw_name = #_parent_name "_ao",		\
> +				.name = #_parent_name "_ao",		\
> +			},						\
> +			.num_parents = 1,				\
> +		},							\
> +	}
> +
>   static inline struct clk_rpmh *to_clk_rpmh(struct clk_hw *_hw)
>   {
>   	return container_of(_hw, struct clk_rpmh, hw);
> @@ -345,6 +373,8 @@ DEFINE_CLK_RPMH_ARC(bi_tcxo, "xo.lvl", 0x3, 2);
>   DEFINE_CLK_RPMH_ARC(bi_tcxo, "xo.lvl", 0x3, 4);
>   DEFINE_CLK_RPMH_ARC(qlink, "qphy.lvl", 0x1, 4);
>   
> +DEFINE_CLK_FIXED_FACTOR(bi_tcxo_div2, bi_tcxo, 2);
> +
>   DEFINE_CLK_RPMH_VRM(ln_bb_clk1, _a2, "lnbclka1", 2);
>   DEFINE_CLK_RPMH_VRM(ln_bb_clk2, _a2, "lnbclka2", 2);
>   DEFINE_CLK_RPMH_VRM(ln_bb_clk3, _a2, "lnbclka3", 2);
> @@ -366,6 +396,16 @@ DEFINE_CLK_RPMH_VRM(rf_clk2, _d, "rfclkd2", 1);
>   DEFINE_CLK_RPMH_VRM(rf_clk3, _d, "rfclkd3", 1);
>   DEFINE_CLK_RPMH_VRM(rf_clk4, _d, "rfclkd4", 1);
>   
> +DEFINE_CLK_RPMH_VRM(clk1, _a1, "clka1", 1);
> +DEFINE_CLK_RPMH_VRM(clk2, _a1, "clka2", 1);
> +DEFINE_CLK_RPMH_VRM(clk3, _a1, "clka3", 1);
> +DEFINE_CLK_RPMH_VRM(clk4, _a1, "clka4", 1);
> +DEFINE_CLK_RPMH_VRM(clk5, _a1, "clka5", 1);
> +
> +DEFINE_CLK_RPMH_VRM(clk6, _a2, "clka6", 2);
> +DEFINE_CLK_RPMH_VRM(clk7, _a2, "clka7", 2);
> +DEFINE_CLK_RPMH_VRM(clk8, _a2, "clka8", 2);
> +
>   DEFINE_CLK_RPMH_VRM(div_clk1, _div2, "divclka1", 2);
>   
>   DEFINE_CLK_RPMH_BCM(ce, "CE0");
> @@ -576,6 +616,33 @@ static const struct clk_rpmh_desc clk_rpmh_sm8450 = {
>   	.num_clks = ARRAY_SIZE(sm8450_rpmh_clocks),
>   };
>   
> +static struct clk_hw *sm8550_rpmh_clocks[] = {
> +	[RPMH_CXO_PAD_CLK]      = &clk_rpmh_bi_tcxo_div2.hw,
> +	[RPMH_CXO_PAD_CLK_A]    = &clk_rpmh_bi_tcxo_div2_ao.hw,
> +	[RPMH_CXO_CLK]		= &clk_fixed_factor_bi_tcxo_div2.hw,
> +	[RPMH_CXO_CLK_A]	= &clk_fixed_factor_bi_tcxo_div2_ao.hw,
> +	[RPMH_LN_BB_CLK1]	= &clk_rpmh_clk6_a2.hw,
> +	[RPMH_LN_BB_CLK1_A]	= &clk_rpmh_clk6_a2_ao.hw,
> +	[RPMH_LN_BB_CLK2]	= &clk_rpmh_clk7_a2.hw,
> +	[RPMH_LN_BB_CLK2_A]	= &clk_rpmh_clk7_a2_ao.hw,
> +	[RPMH_LN_BB_CLK3]	= &clk_rpmh_clk8_a2.hw,
> +	[RPMH_LN_BB_CLK3_A]	= &clk_rpmh_clk8_a2_ao.hw,
> +	[RPMH_RF_CLK1]		= &clk_rpmh_clk1_a1.hw,
> +	[RPMH_RF_CLK1_A]	= &clk_rpmh_clk1_a1_ao.hw,
> +	[RPMH_RF_CLK2]		= &clk_rpmh_clk2_a1.hw,
> +	[RPMH_RF_CLK2_A]	= &clk_rpmh_clk2_a1_ao.hw,
> +	[RPMH_RF_CLK3]		= &clk_rpmh_clk3_a1.hw,
> +	[RPMH_RF_CLK3_A]	= &clk_rpmh_clk3_a1_ao.hw,
> +	[RPMH_RF_CLK4]		= &clk_rpmh_clk4_a1.hw,
> +	[RPMH_RF_CLK4_A]	= &clk_rpmh_clk4_a1_ao.hw,
> +	[RPMH_IPA_CLK]		= &clk_rpmh_ipa.hw,
> +};
> +
> +static const struct clk_rpmh_desc clk_rpmh_sm8550 = {
> +	.clks = sm8550_rpmh_clocks,
> +	.num_clks = ARRAY_SIZE(sm8550_rpmh_clocks),
> +};
> +
>   static struct clk_hw *sc7280_rpmh_clocks[] = {
>   	[RPMH_CXO_CLK]      = &clk_rpmh_bi_tcxo_div4.hw,
>   	[RPMH_CXO_CLK_A]    = &clk_rpmh_bi_tcxo_div4_ao.hw,
> @@ -683,29 +750,31 @@ static int clk_rpmh_probe(struct platform_device *pdev)
>   
>   		name = hw_clks[i]->init->name;
>   
> -		rpmh_clk = to_clk_rpmh(hw_clks[i]);
> -		res_addr = cmd_db_read_addr(rpmh_clk->res_name);
> -		if (!res_addr) {
> -			dev_err(&pdev->dev, "missing RPMh resource address for %s\n",
> -				rpmh_clk->res_name);
> -			return -ENODEV;
> -		}
> +		if (hw_clks[i]->init->ops != &clk_fixed_factor_ops) {

We discussed this separately, the fixed factor clocks will be moved to 
the child nodes, leaving rpmhcc with only cmd-db based clocks.

> +			rpmh_clk = to_clk_rpmh(hw_clks[i]);
> +			res_addr = cmd_db_read_addr(rpmh_clk->res_name);
> +			if (!res_addr) {
> +				dev_err(&pdev->dev, "missing RPMh resource address for %s\n",
> +					rpmh_clk->res_name);
> +				return -ENODEV;
> +			}
>   
> -		data = cmd_db_read_aux_data(rpmh_clk->res_name, &aux_data_len);
> -		if (IS_ERR(data)) {
> -			ret = PTR_ERR(data);
> -			dev_err(&pdev->dev,
> -				"error reading RPMh aux data for %s (%d)\n",
> -				rpmh_clk->res_name, ret);
> -			return ret;
> -		}
> +			data = cmd_db_read_aux_data(rpmh_clk->res_name, &aux_data_len);
> +			if (IS_ERR(data)) {
> +				ret = PTR_ERR(data);
> +				dev_err(&pdev->dev,
> +					"error reading RPMh aux data for %s (%d)\n",
> +					rpmh_clk->res_name, ret);
> +				return ret;
> +			}
>   
> -		/* Convert unit from Khz to Hz */
> -		if (aux_data_len == sizeof(*data))
> -			rpmh_clk->unit = le32_to_cpu(data->unit) * 1000ULL;
> +			/* Convert unit from Khz to Hz */
> +			if (aux_data_len == sizeof(*data))
> +				rpmh_clk->unit = le32_to_cpu(data->unit) * 1000ULL;
>   
> -		rpmh_clk->res_addr += res_addr;
> -		rpmh_clk->dev = &pdev->dev;
> +			rpmh_clk->res_addr += res_addr;
> +			rpmh_clk->dev = &pdev->dev;
> +		}
>   
>   		ret = devm_clk_hw_register(&pdev->dev, hw_clks[i]);
>   		if (ret) {
> @@ -741,6 +810,7 @@ static const struct of_device_id clk_rpmh_match_table[] = {
>   	{ .compatible = "qcom,sm8250-rpmh-clk", .data = &clk_rpmh_sm8250},
>   	{ .compatible = "qcom,sm8350-rpmh-clk", .data = &clk_rpmh_sm8350},
>   	{ .compatible = "qcom,sm8450-rpmh-clk", .data = &clk_rpmh_sm8450},
> +	{ .compatible = "qcom,sm8550-rpmh-clk", .data = &clk_rpmh_sm8550},
>   	{ .compatible = "qcom,sc7280-rpmh-clk", .data = &clk_rpmh_sc7280},
>   	{ }
>   };

-- 
With best wishes
Dmitry

