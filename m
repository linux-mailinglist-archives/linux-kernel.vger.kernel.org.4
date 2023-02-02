Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08658688190
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 16:19:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232789AbjBBPTL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 10:19:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232667AbjBBPS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 10:18:59 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E02CF70D7F
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 07:18:32 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id mf7so6884889ejc.6
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 07:18:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Qso+/v0jjViUogFJotdIoyTWkD5ZvdgsxWyF9DZddKY=;
        b=Y5JCHiE0BLlQLU6It/RY5ICxSiK25fhmCBvSMJr+r9CKEnM+S3VKNSmK5dyAKnN/4S
         b5jXFlVGQt0r3c+66xAvM0LlyhwI7SAapK2hJbvmU3g23U3Yt/p4pk+G7omxwf090xr1
         nlaM0kBb7uhXUc5DIU9EUYc4h07v9oIqnsX8/HLzEmVmbvfUHcPAZHUnX0UwtipHwdx4
         /Ti3uBby2G+rl7AUlv249sQVg7PhFg7kCd//h1UpdWi38DY51nISdb0q1A3x/xYTrze5
         bDI7NvBwBh+vtdcUqctc6XF28Tbx/hsgy9+3W0Ec6hms+BhoVxNZk5wbCHF+kq/6811I
         vAHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qso+/v0jjViUogFJotdIoyTWkD5ZvdgsxWyF9DZddKY=;
        b=K7yFz9odUz1s4I6vbSzf2cT3AMpQGOso8feEVNJdRIfyNKyhJQx9vgmvU77h2I1uKl
         Hu/HBgjZ7y9F+K/O8a5RgwP1RK9V8B4/cZCqLX68iImZtTuvf+mHBdQDpVfCqyAHI1JT
         OYvYDlPRaK0UV8OmUQ7wHW81+58R4fqyaXH5oixWVo95j6IUJ3oVh59BNoy2Xvl09uy2
         61AgjRdAN4afMkvJMnplZbjvQI301Fcevk/oRImbPmmUq/fq7QEhL7DG9R5JOpMSgSmm
         4rxi6B/mBfSBaq+6bKZ25ojZEf/7DCMeAXsVq1E75v60lXpNB+1gH5e7eGacw70DB2LC
         b38Q==
X-Gm-Message-State: AO0yUKU3mgg8ZDRa37ilv0mIy3qIoeL4dbvBhPWHiE+JguduhWwIyaZ3
        FCZKrbsa2+vfMMoV1o2fzYFf8w==
X-Google-Smtp-Source: AK7set+qv0MK4YNSCw7pypa8ByystHnREluX9vZSDsLAiowBcdtkXMGgVygMdPmFEjGsjIWYMg3d/A==
X-Received: by 2002:a17:906:2ad4:b0:871:dd2:4af0 with SMTP id m20-20020a1709062ad400b008710dd24af0mr6847922eje.26.1675351109364;
        Thu, 02 Feb 2023 07:18:29 -0800 (PST)
Received: from [192.168.1.101] (abyl20.neoplus.adsl.tpnet.pl. [83.9.31.20])
        by smtp.gmail.com with ESMTPSA id kw5-20020a170907770500b0088519b9206bsm7931641ejc.130.2023.02.02.07.18.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Feb 2023 07:18:28 -0800 (PST)
Message-ID: <f60678a4-4dc7-9744-a8a2-e7af8a9594d1@linaro.org>
Date:   Thu, 2 Feb 2023 16:18:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH 3/6] clk: qcom: apss-ipq-pll: add support for IPQ5332
Content-Language: en-US
To:     Kathiravan T <quic_kathirav@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        jassisinghbrar@gmail.com, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230202145208.2328032-1-quic_kathirav@quicinc.com>
 <20230202145208.2328032-4-quic_kathirav@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230202145208.2328032-4-quic_kathirav@quicinc.com>
Content-Type: text/plain; charset=UTF-8
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



On 2.02.2023 15:52, Kathiravan T wrote:
> IPQ5332 APSS PLL is of type Stromer Plus. Add support for the same.
> 
> To configure the stromer plus PLL separate API
> (clock_stromer_pll_configure) to be used. To achieve this, introduce the
> new member pll_type in device data structure and call the appropriate
> function based on this.
> 
> Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>
> ---
>  drivers/clk/qcom/apss-ipq-pll.c | 58 ++++++++++++++++++++++++++++++++-
>  1 file changed, 57 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/qcom/apss-ipq-pll.c b/drivers/clk/qcom/apss-ipq-pll.c
> index 6e815e8b7fe4..023a854f2c21 100644
> --- a/drivers/clk/qcom/apss-ipq-pll.c
> +++ b/drivers/clk/qcom/apss-ipq-pll.c
> @@ -19,6 +19,17 @@ static const u8 ipq_pll_offsets[][PLL_OFF_MAX_REGS] = {
>  		[PLL_OFF_TEST_CTL] = 0x30,
>  		[PLL_OFF_TEST_CTL_U] = 0x34,
>  	},
> +	[CLK_ALPHA_PLL_TYPE_STROMER_PLUS] = {
> +		[PLL_OFF_L_VAL] = 0x08,
> +		[PLL_OFF_ALPHA_VAL] = 0x10,
> +		[PLL_OFF_ALPHA_VAL_U] = 0x14,
> +		[PLL_OFF_USER_CTL] = 0x18,
> +		[PLL_OFF_USER_CTL_U] = 0x1c,
> +		[PLL_OFF_CONFIG_CTL] = 0x20,
> +		[PLL_OFF_STATUS] = 0x28,
> +		[PLL_OFF_TEST_CTL] = 0x30,
> +		[PLL_OFF_TEST_CTL_U] = 0x34,
> +	},
Any reason this couldn't use clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_STROMER_PLUS]
exported from clk-alpha-pll.c?

Konrad
>  };
>  
>  static struct clk_alpha_pll ipq_pll_huayra = {
> @@ -39,6 +50,38 @@ static struct clk_alpha_pll ipq_pll_huayra = {
>  	},
>  };
>  
> +static struct clk_alpha_pll ipq_pll_stromer_plus = {
> +	.offset = 0x0,
> +	.regs = ipq_pll_offsets[CLK_ALPHA_PLL_TYPE_STROMER_PLUS],
> +	.flags = SUPPORTS_DYNAMIC_UPDATE,
> +	.clkr = {
> +		.enable_reg = 0x0,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "a53pll",
> +			.parent_data = &(const struct clk_parent_data) {
> +				.fw_name = "xo",
> +			},
> +			.num_parents = 1,
> +			.ops = &clk_alpha_pll_stromer_ops,
> +		},
> +	},
> +};
> +
> +static const struct alpha_pll_config ipq5332_pll_config = {
> +	.l = 0x3e,
> +	.config_ctl_val = 0x4001075b,
> +	.config_ctl_hi_val = 0x304,
> +	.main_output_mask = BIT(0),
> +	.aux_output_mask = BIT(1),
> +	.early_output_mask = BIT(3),
> +	.alpha_en_mask = BIT(24),
> +	.status_val = 0x3,
> +	.status_mask = GENMASK(10, 8),
> +	.lock_det = BIT(2),
> +	.test_ctl_hi_val = 0x00400003,
> +};
> +
>  static const struct alpha_pll_config ipq6018_pll_config = {
>  	.l = 0x37,
>  	.config_ctl_val = 0x240d4828,
> @@ -64,16 +107,25 @@ static const struct alpha_pll_config ipq8074_pll_config = {
>  };
>  
>  struct apss_pll_data {
> +	int pll_type;
>  	struct clk_alpha_pll *pll;
>  	const struct alpha_pll_config *pll_config;
>  };
>  
> +static struct apss_pll_data ipq5332_pll_data = {
> +	.pll_type = CLK_ALPHA_PLL_TYPE_STROMER_PLUS,
> +	.pll = &ipq_pll_stromer_plus,
> +	.pll_config = &ipq5332_pll_config,
> +};
> +
>  static struct apss_pll_data ipq8074_pll_data = {
> +	.pll_type = CLK_ALPHA_PLL_TYPE_HUAYRA,
>  	.pll = &ipq_pll_huayra,
>  	.pll_config = &ipq8074_pll_config,
>  };
>  
>  static struct apss_pll_data ipq6018_pll_data = {
> +	.pll_type = CLK_ALPHA_PLL_TYPE_HUAYRA,
>  	.pll = &ipq_pll_huayra,
>  	.pll_config = &ipq6018_pll_config,
>  };
> @@ -106,7 +158,10 @@ static int apss_ipq_pll_probe(struct platform_device *pdev)
>  	if (!data)
>  		return -ENODEV;
>  
> -	clk_alpha_pll_configure(data->pll, regmap, data->pll_config);
> +	if (data->pll_type == CLK_ALPHA_PLL_TYPE_HUAYRA)
> +		clk_alpha_pll_configure(data->pll, regmap, data->pll_config);
> +	else if (data->pll_type == CLK_ALPHA_PLL_TYPE_STROMER_PLUS)
> +		clk_stromer_pll_configure(data->pll, regmap, data->pll_config);
>  
>  	ret = devm_clk_register_regmap(dev, &data->pll->clkr);
>  	if (ret)
> @@ -117,6 +172,7 @@ static int apss_ipq_pll_probe(struct platform_device *pdev)
>  }
>  
>  static const struct of_device_id apss_ipq_pll_match_table[] = {
> +	{ .compatible = "qcom,ipq5332-a53pll", .data = &ipq5332_pll_data },
>  	{ .compatible = "qcom,ipq6018-a53pll", .data = &ipq6018_pll_data },
>  	{ .compatible = "qcom,ipq8074-a53pll", .data = &ipq8074_pll_data },
>  	{ }
