Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3141B636580
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 17:12:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239017AbiKWQMi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 11:12:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239005AbiKWQMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 11:12:34 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2F3BF0E
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 08:12:27 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id r12so28888850lfp.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 08:12:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TtHcJd8BFDObQdDtblgbEBO+6P5tMrTuGpRtmyRE6Wk=;
        b=n/c4r3USYSLRZJkp4JvI5PMts2/NDqfq+kLZ7qyrvS7i8sVrgdj8wOjoRYotUZfIfc
         Ze6x6xgdhxCGYWxRZQSIlidb/Po6Wz7wGYslxWWAtbaS7EGdtTYG6t8rXOZvwVaeaEN7
         ZiMF/h7xXBoeFF+X+D1y0rRszRO0VSjznWYEYddEiWm8XDRFEvJIwreNhACw5kOyvofA
         AGBuO2izlnmJppwLFP/obYrm/P8It5bp94a4Y88kdjKbWUm9Qn0G4E2tc6f/eWAzTwhg
         FDh8UFfx2Yr8JGCiSKVMnest/HzYmKO8TMstLzKNHZ2NNDIUHubNn0JJ9Qj7WjwxjuXr
         1O6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TtHcJd8BFDObQdDtblgbEBO+6P5tMrTuGpRtmyRE6Wk=;
        b=QIkv3q+525yMlz0n5XuvQW9Za7nZmhRLqpvBAPiInIz3J7zU1a9S56vf6/fJuWTLQI
         xekIvPySzxswCTK6qgCTLS0PNy3bgf1v2/8Rft9hACITQpa8J/vFmCNe5vRvNyXQGw4X
         Jtsu/7OSTTDTPClAN+Sz2ChZkR1jp0C37R8wb0K9vy6RN//ddSdfFDtw5sIW64IZmtVE
         DrIl3kioU/9DsAW1meGo2WS7Lp1Dgrkb+zfVDiMRq0BUBlDIcz9S6bbGSQP+am7XuOyP
         KGPeBFe6TYtQHBWw8oRXcghiNaquSQrBRMM4v97k8UagfpfnsabOoZfqNIzTo7L7WXy/
         kaWQ==
X-Gm-Message-State: ANoB5pnxfiTKh2zp6pZQSEP2cNEl2A7WCH+fSEL4xXUjQIbdp+gWJMgf
        UiMU1J3dUjTj4p3zQ33vDdkInQ==
X-Google-Smtp-Source: AA0mqf6C7DmqvswpMzMro5oN6iDjEGz5uMBvVejvdFIJVXO135263hjmIJl8A75d37cxxwwoT2UksA==
X-Received: by 2002:ac2:5e7a:0:b0:4a2:6238:e7f9 with SMTP id a26-20020ac25e7a000000b004a26238e7f9mr9463350lfr.294.1669219945658;
        Wed, 23 Nov 2022 08:12:25 -0800 (PST)
Received: from [192.168.1.101] (95.49.32.48.neoplus.adsl.tpnet.pl. [95.49.32.48])
        by smtp.gmail.com with ESMTPSA id z8-20020ac25de8000000b004946bb30469sm2955303lfq.82.2022.11.23.08.12.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Nov 2022 08:12:25 -0800 (PST)
Message-ID: <848da740-37ee-ebb8-b754-3b9dfa9944a6@linaro.org>
Date:   Wed, 23 Nov 2022 17:12:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 8/9] clk: qcom: rpmh: Add support for SM8550 rpmh
 clocks
Content-Language: en-US
To:     Abel Vesa <abel.vesa@linaro.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org
References: <20221123142009.594781-1-abel.vesa@linaro.org>
 <20221123142009.594781-9-abel.vesa@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221123142009.594781-9-abel.vesa@linaro.org>
Content-Type: text/plain; charset=UTF-8
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



On 23.11.2022 15:20, Abel Vesa wrote:
> Adds the RPMH clocks present in SM8550 SoC.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
> 
> Changes since v1:
>  * moved DEFINE_CLK_RPMH_FIXED define upwards
> 
>  drivers/clk/qcom/clk-rpmh.c | 110 +++++++++++++++++++++++++++++-------
>  1 file changed, 90 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/clk/qcom/clk-rpmh.c b/drivers/clk/qcom/clk-rpmh.c
> index 0471bab82464..3204df3fda86 100644
> --- a/drivers/clk/qcom/clk-rpmh.c
> +++ b/drivers/clk/qcom/clk-rpmh.c
> @@ -132,6 +132,36 @@ static DEFINE_MUTEX(rpmh_clk_lock);
>  		},							\
>  	}
>  
> +#define DEFINE_CLK_RPMH_FIXED(_platform, _name, _name_active,	\
> +				  _parent_name, _name_active_parent,	\
> +				  _div)					\
> +	static struct clk_fixed_factor _platform##_##_name = {		\
> +		.mult = 1,						\
> +		.div = _div,						\
> +		.hw.init = &(struct clk_init_data){			\
> +			.ops = &clk_fixed_factor_ops,			\
> +			.name = #_name,					\
> +			.parent_data =  &(const struct clk_parent_data){ \
> +					.fw_name = #_parent_name,	\
> +					.name = #_parent_name,		\
> +			},						\
> +			.num_parents = 1,				\
> +		},							\
> +	};								\
> +	static struct clk_fixed_factor _platform##_##_name_active = {	\
> +		.mult = 1,						\
> +		.div = _div,						\
> +		.hw.init = &(struct clk_init_data){			\
> +			.ops = &clk_fixed_factor_ops,			\
> +			.name = #_name_active,				\
> +			.parent_data =  &(const struct clk_parent_data){ \
> +					.fw_name = #_name_active_parent,\
> +					.name = #_name_active_parent,	\
> +			},						\
> +			.num_parents = 1,				\
> +		},							\
> +	}
> +
>  static inline struct clk_rpmh *to_clk_rpmh(struct clk_hw *_hw)
>  {
>  	return container_of(_hw, struct clk_rpmh, hw);
> @@ -579,6 +609,43 @@ static const struct clk_rpmh_desc clk_rpmh_sm8450 = {
>  	.num_clks = ARRAY_SIZE(sm8450_rpmh_clocks),
>  };
>  
> +DEFINE_CLK_RPMH_ARC(sm8550, xo_pad, xo_pad_ao, "xo.lvl", 0x03, 2);
> +DEFINE_CLK_RPMH_FIXED(sm8550, bi_tcxo, bi_tcxo_ao, xo_pad, xo_pad_ao, 2);
> +DEFINE_CLK_RPMH_VRM(sm8550, rf_clk1, rf_clk1_ao, "clka1", 1);
> +DEFINE_CLK_RPMH_VRM(sm8550, rf_clk2, rf_clk2_ao, "clka2", 1);
> +DEFINE_CLK_RPMH_VRM(sm8550, rf_clk3, rf_clk3_ao, "clka3", 1);
> +DEFINE_CLK_RPMH_VRM(sm8550, rf_clk4, rf_clk4_ao, "clka4", 1);
> +DEFINE_CLK_RPMH_VRM(sm8550, ln_bb_clk1, ln_bb_clk1_ao, "clka6", 2);
> +DEFINE_CLK_RPMH_VRM(sm8550, ln_bb_clk2, ln_bb_clk2_ao, "clka7", 2);
> +DEFINE_CLK_RPMH_VRM(sm8550, ln_bb_clk3, ln_bb_clk3_ao, "clka8", 2);
> +
> +static struct clk_hw *sm8550_rpmh_clocks[] = {
> +	[RPMH_CXO_PAD_CLK]      = &sm8550_xo_pad.hw,
> +	[RPMH_CXO_PAD_CLK_A]    = &sm8550_xo_pad_ao.hw,
> +	[RPMH_CXO_CLK]		= &sm8550_bi_tcxo.hw,
> +	[RPMH_CXO_CLK_A]	= &sm8550_bi_tcxo_ao.hw,
> +	[RPMH_LN_BB_CLK1]	= &sm8550_ln_bb_clk1.hw,
> +	[RPMH_LN_BB_CLK1_A]	= &sm8550_ln_bb_clk1_ao.hw,
> +	[RPMH_LN_BB_CLK2]	= &sm8550_ln_bb_clk2.hw,
> +	[RPMH_LN_BB_CLK2_A]	= &sm8550_ln_bb_clk2_ao.hw,
> +	[RPMH_LN_BB_CLK3]	= &sm8550_ln_bb_clk3.hw,
> +	[RPMH_LN_BB_CLK3_A]	= &sm8550_ln_bb_clk3_ao.hw,
> +	[RPMH_RF_CLK1]		= &sm8550_rf_clk1.hw,
> +	[RPMH_RF_CLK1_A]	= &sm8550_rf_clk1_ao.hw,
> +	[RPMH_RF_CLK2]		= &sm8550_rf_clk2.hw,
> +	[RPMH_RF_CLK2_A]	= &sm8550_rf_clk2_ao.hw,
> +	[RPMH_RF_CLK3]		= &sm8550_rf_clk3.hw,
> +	[RPMH_RF_CLK3_A]	= &sm8550_rf_clk3_ao.hw,
> +	[RPMH_RF_CLK4]		= &sm8550_rf_clk4.hw,
> +	[RPMH_RF_CLK4_A]	= &sm8550_rf_clk4_ao.hw,
> +	[RPMH_IPA_CLK]		= &sdm845_ipa.hw,
> +};
> +
> +static const struct clk_rpmh_desc clk_rpmh_sm8550 = {
> +	.clks = sm8550_rpmh_clocks,
> +	.num_clks = ARRAY_SIZE(sm8550_rpmh_clocks),
> +};
> +
>  static struct clk_hw *sc7280_rpmh_clocks[] = {
>  	[RPMH_CXO_CLK]      = &sc7280_bi_tcxo.hw,
>  	[RPMH_CXO_CLK_A]    = &sc7280_bi_tcxo_ao.hw,
> @@ -682,29 +749,31 @@ static int clk_rpmh_probe(struct platform_device *pdev)
>  
>  		name = hw_clks[i]->init->name;
>  
> -		rpmh_clk = to_clk_rpmh(hw_clks[i]);
> -		res_addr = cmd_db_read_addr(rpmh_clk->res_name);
> -		if (!res_addr) {
> -			dev_err(&pdev->dev, "missing RPMh resource address for %s\n",
> -				rpmh_clk->res_name);
> -			return -ENODEV;
> -		}
> +		if (hw_clks[i]->init->ops != &clk_fixed_factor_ops) {
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
>  		ret = devm_clk_hw_register(&pdev->dev, hw_clks[i]);
>  		if (ret) {
> @@ -739,6 +808,7 @@ static const struct of_device_id clk_rpmh_match_table[] = {
>  	{ .compatible = "qcom,sm8250-rpmh-clk", .data = &clk_rpmh_sm8250},
>  	{ .compatible = "qcom,sm8350-rpmh-clk", .data = &clk_rpmh_sm8350},
>  	{ .compatible = "qcom,sm8450-rpmh-clk", .data = &clk_rpmh_sm8450},
> +	{ .compatible = "qcom,sm8550-rpmh-clk", .data = &clk_rpmh_sm8550},
>  	{ .compatible = "qcom,sc7280-rpmh-clk", .data = &clk_rpmh_sc7280},
>  	{ }
>  };
