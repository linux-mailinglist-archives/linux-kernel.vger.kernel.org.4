Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEAEA62BC39
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 12:41:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232869AbiKPLlf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 06:41:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232075AbiKPLlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 06:41:00 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E827948745
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 03:27:24 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id f7so26085818edc.6
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 03:27:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kBEe6J/PNu7It6u01bJ/j5wrzz9A2Et9pPRKKdqF238=;
        b=wKRqf5aMNm9bNCbdu6eaIgZgIoh1yCNvlLEhQH230lh5vVDTcpKmcZCOKjEecVjtn2
         khlY8Rs5d9ss4PsaaGgvMX/Yq2bBtEBuKN+fN6eEgrDSMj4Fwsjs7mHaxlRNZHtTo7PY
         gfJrFY+oc8Tu8m8wfiR5ZUZ4hMYup7jAZ6PKBlr569E4C+jZmcDMPPOSovnioAJ4Cmmm
         6o6uUg1dVF+XETc4hnC7fXWyztMAleTleTj0iEZjCNisH3AZCNF7yBbUIWlFq5UgZQyO
         SLN3HeEM34EESrM7//Q0YbRiVdTnJBeGmUNTqL1bUq+2SZnX6qG47Tq2J0sJiOEOcVkB
         yekQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kBEe6J/PNu7It6u01bJ/j5wrzz9A2Et9pPRKKdqF238=;
        b=ZcgTYAs8fWcs0zUssrxSuAoJzq9ArbiwAwAU+5aakZh8OExVZBARdsqYlhmPNhqymu
         j24ei9ejfuS5+Rp5liaIgLCTfIANcxbgxBf6PCyIx1kH59VUxZfOo71scej33ijazCEM
         A2+Q7yuuZQkgtLahKQRwMMj4Ov9OsfupQFqWIW667HvRs1jTzlpJIpuUqufp9+vjGCGX
         tWIJUpztqHmYzQWG3eeRJZmSJS4itYDIPYjM6ifUl54PYyoUGCvrwPpAc4qdYVcEVMfV
         Vk98i9eQ/tVzorqIFpNN+89K1iI3+uhJgWLXbaKymnMXuTbUDtubtybE8B5xQLalLH8Z
         3XmQ==
X-Gm-Message-State: ANoB5pmS1SgpmCIe7qTH6xp4FzXfKGN9kuDGjcVunSGuzKHC0vF4Nsf1
        ggAtgoQQEG0g1oxzg0XDddOU9g==
X-Google-Smtp-Source: AA0mqf6HxpF68fsaUTd4I97V3xidhV6ZuecVnv28Mbb39lbNCcDmXflPXkGeCQzMqVNNDO261WBWxQ==
X-Received: by 2002:a05:6402:4501:b0:461:ca0f:affc with SMTP id ez1-20020a056402450100b00461ca0faffcmr18234521edb.169.1668598043519;
        Wed, 16 Nov 2022 03:27:23 -0800 (PST)
Received: from [192.168.31.208] ([194.29.137.22])
        by smtp.gmail.com with ESMTPSA id y22-20020a056402171600b0046776f98d0csm6130593edu.79.2022.11.16.03.27.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Nov 2022 03:27:22 -0800 (PST)
Message-ID: <010238f2-f520-41b8-c2cf-d65e9c12160d@linaro.org>
Date:   Wed, 16 Nov 2022 12:27:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
Subject: Re: [PATCH 7/9] clk: qcom: rpmh: Add support for SM8550 rpmh clocks
To:     Abel Vesa <abel.vesa@linaro.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org
References: <20221116104716.2583320-1-abel.vesa@linaro.org>
 <20221116104716.2583320-8-abel.vesa@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221116104716.2583320-8-abel.vesa@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 16/11/2022 11:47, Abel Vesa wrote:
> Adds the RPMH clocks present in SM8550 SoC.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>   drivers/clk/qcom/clk-rpmh.c | 110 +++++++++++++++++++++++++++++-------
>   1 file changed, 90 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/clk/qcom/clk-rpmh.c b/drivers/clk/qcom/clk-rpmh.c
> index 1da45a6e2f29..63975490ab54 100644
> --- a/drivers/clk/qcom/clk-rpmh.c
> +++ b/drivers/clk/qcom/clk-rpmh.c
> @@ -579,6 +579,73 @@ static const struct clk_rpmh_desc clk_rpmh_sm8450 = {
>   	.num_clks = ARRAY_SIZE(sm8450_rpmh_clocks),
>   };
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
No need to introduce .name if we do DT properly from the get-go, I think


Konrad
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
>   static struct clk_hw *sc7280_rpmh_clocks[] = {
>   	[RPMH_CXO_CLK]      = &sc7280_bi_tcxo.hw,
>   	[RPMH_CXO_CLK_A]    = &sc7280_bi_tcxo_ao.hw,
> @@ -694,29 +761,31 @@ static int clk_rpmh_probe(struct platform_device *pdev)
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
> @@ -752,6 +821,7 @@ static const struct of_device_id clk_rpmh_match_table[] = {
>   	{ .compatible = "qcom,sm8250-rpmh-clk", .data = &clk_rpmh_sm8250},
>   	{ .compatible = "qcom,sm8350-rpmh-clk", .data = &clk_rpmh_sm8350},
>   	{ .compatible = "qcom,sm8450-rpmh-clk", .data = &clk_rpmh_sm8450},
> +	{ .compatible = "qcom,sm8550-rpmh-clk", .data = &clk_rpmh_sm8550},
>   	{ .compatible = "qcom,sc7280-rpmh-clk", .data = &clk_rpmh_sc7280},
>   	{ }
>   };
