Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2930C68EA1D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 09:43:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbjBHIna (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 03:43:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbjBHIn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 03:43:26 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65F801117D
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 00:43:25 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id lu11so49425587ejb.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 00:43:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0IXl6kD6FaSqH2TLIYbDp0fe2VT/K/RbppO/U3hRSAE=;
        b=vbPqInmmketAEEDc6qJG+cpnKPEXLOpqzX8/1cseRkaMVH0VqaK8EjGEylxXDL2reS
         GelKY59HOKqptFaKn1YNqX38khMhHs5cWUJijvfxcu9ISPXBkGGOHHLVkADFPt9DLz08
         oKNTsX4858hO4u/DMy1rVT5rDEHrgUOsjSnRObc2jWwDxv4+WDsKv7L0qpKGFOxF1Sz0
         W7JFvhrtr5SnNQwAJi+oW9AVSwBnj9UySLVJ0LMSS/MqDv31K5mi4pvzG1DiJ9wRgKte
         NWItTthl5ZzB8ifdre4vUCBixyc08ijxeCYcVZEoa8CAsX9xyqBUExGOjoKQJFp+fkWs
         Q3Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0IXl6kD6FaSqH2TLIYbDp0fe2VT/K/RbppO/U3hRSAE=;
        b=qHSopUmB+Q8qpG6bK1cDLgYKp5UX8RaH6uf/a2Z2gdsbgPMeIHbd0q3o5T8Nwlfuwd
         jJMZeGECE0hdiXGvsI8hxhrbatvTrLE3t39P2xQqfzGdGDjj0vMxDzSHOl6Rhm61DoHe
         dSlec6FNRe5FH7Al7B3PPBVIvWxhp7Hm7slIYOsAnBsgBU5Dg06IxZYLbeQGpc7UoraO
         IeKuCfWUkr2Ds43AuVboIJNGLH4s3M5gm4RT/wHTKoQXGcGibwQbMYBXWX5HtvqvYjMB
         q+hrJCr0xpXPk+asXCXTB/+EzW/BvMaRLlAZZdTN+awSAaSQ9UpLjxVUKKe0kmMfxDB4
         0/3A==
X-Gm-Message-State: AO0yUKVW1H8RtYxKlkSAHgtMDVK2VPaEE1G6gUQ6n3EjFuV0O3S3rVbg
        HMtymO9RTUy8euSTXcJnB3EgiQ==
X-Google-Smtp-Source: AK7set/CfBC7d2nLbiAvXN3S4Ektr0US70dZLyaaYOsQfWynVsWXZ791vEMH2IHef8VUQ2guv5BHyA==
X-Received: by 2002:a17:907:98cf:b0:88e:2ff5:85d2 with SMTP id kd15-20020a17090798cf00b0088e2ff585d2mr8488905ejc.25.1675845804000;
        Wed, 08 Feb 2023 00:43:24 -0800 (PST)
Received: from [192.168.1.101] (abxh117.neoplus.adsl.tpnet.pl. [83.9.1.117])
        by smtp.gmail.com with ESMTPSA id v4-20020a170906564400b0088ee56fb24dsm7990021ejr.103.2023.02.08.00.43.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Feb 2023 00:43:23 -0800 (PST)
Message-ID: <e4b9cfd0-4616-b2b1-5da6-63d811109d67@linaro.org>
Date:   Wed, 8 Feb 2023 09:43:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH V2 1/5] clk: qcom: apss-ipq-pll: refactor the driver to
 accommodate different PLL types
Content-Language: en-US
To:     Kathiravan T <quic_kathirav@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        jassisinghbrar@gmail.com, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     quic_varada@quicinc.com, quic_srichara@quicinc.com
References: <20230208042850.1687-1-quic_kathirav@quicinc.com>
 <20230208042850.1687-2-quic_kathirav@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230208042850.1687-2-quic_kathirav@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8.02.2023 05:28, Kathiravan T wrote:
> APSS PLL found on the IPQ8074 and IPQ6018 are of type Huayra PLL. But,
> IPQ5332 APSS PLL is of type Stromer Plus. To accommodate both these PLLs,
> refactor the driver to take the clk_alpha_pll, alpha_pll_config via driver
> data.
> 
> Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
> Changes in V2:
> 	- Added a comment to describe why different offsets are required
> 	  for PLL
> 
>  drivers/clk/qcom/apss-ipq-pll.c | 60 ++++++++++++++++++++++-----------
>  1 file changed, 41 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/clk/qcom/apss-ipq-pll.c b/drivers/clk/qcom/apss-ipq-pll.c
> index a5aea27eb867..4f2a147e9fb2 100644
> --- a/drivers/clk/qcom/apss-ipq-pll.c
> +++ b/drivers/clk/qcom/apss-ipq-pll.c
> @@ -8,20 +8,27 @@
>  
>  #include "clk-alpha-pll.h"
>  
> -static const u8 ipq_pll_offsets[] = {
> -	[PLL_OFF_L_VAL] = 0x08,
> -	[PLL_OFF_ALPHA_VAL] = 0x10,
> -	[PLL_OFF_USER_CTL] = 0x18,
> -	[PLL_OFF_CONFIG_CTL] = 0x20,
> -	[PLL_OFF_CONFIG_CTL_U] = 0x24,
> -	[PLL_OFF_STATUS] = 0x28,
> -	[PLL_OFF_TEST_CTL] = 0x30,
> -	[PLL_OFF_TEST_CTL_U] = 0x34,
> +/*
> + * Even though APSS PLL type is of existing one (like Huayra), its offsets
> + * are different from the one mentioned in the clk-alpha-pll.c, since the
> + * PLL is specific to APSS, so lets the define the same.
> + */
> +static const u8 ipq_pll_offsets[][PLL_OFF_MAX_REGS] = {
> +	[CLK_ALPHA_PLL_TYPE_HUAYRA] =  {
> +		[PLL_OFF_L_VAL] = 0x08,
> +		[PLL_OFF_ALPHA_VAL] = 0x10,
> +		[PLL_OFF_USER_CTL] = 0x18,
> +		[PLL_OFF_CONFIG_CTL] = 0x20,
> +		[PLL_OFF_CONFIG_CTL_U] = 0x24,
> +		[PLL_OFF_STATUS] = 0x28,
> +		[PLL_OFF_TEST_CTL] = 0x30,
> +		[PLL_OFF_TEST_CTL_U] = 0x34,
> +	},
>  };
>  
> -static struct clk_alpha_pll ipq_pll = {
> +static struct clk_alpha_pll ipq_pll_huayra = {
>  	.offset = 0x0,
> -	.regs = ipq_pll_offsets,
> +	.regs = ipq_pll_offsets[CLK_ALPHA_PLL_TYPE_HUAYRA],
>  	.flags = SUPPORTS_DYNAMIC_UPDATE,
>  	.clkr = {
>  		.enable_reg = 0x0,
> @@ -61,6 +68,21 @@ static const struct alpha_pll_config ipq8074_pll_config = {
>  	.test_ctl_hi_val = 0x4000,
>  };
>  
> +struct apss_pll_data {
> +	struct clk_alpha_pll *pll;
> +	const struct alpha_pll_config *pll_config;
> +};
> +
> +static struct apss_pll_data ipq8074_pll_data = {
> +	.pll = &ipq_pll_huayra,
> +	.pll_config = &ipq8074_pll_config,
> +};
> +
> +static struct apss_pll_data ipq6018_pll_data = {
> +	.pll = &ipq_pll_huayra,
> +	.pll_config = &ipq6018_pll_config,
> +};
> +
>  static const struct regmap_config ipq_pll_regmap_config = {
>  	.reg_bits		= 32,
>  	.reg_stride		= 4,
> @@ -71,7 +93,7 @@ static const struct regmap_config ipq_pll_regmap_config = {
>  
>  static int apss_ipq_pll_probe(struct platform_device *pdev)
>  {
> -	const struct alpha_pll_config *ipq_pll_config;
> +	const struct apss_pll_data *data;
>  	struct device *dev = &pdev->dev;
>  	struct regmap *regmap;
>  	void __iomem *base;
> @@ -85,23 +107,23 @@ static int apss_ipq_pll_probe(struct platform_device *pdev)
>  	if (IS_ERR(regmap))
>  		return PTR_ERR(regmap);
>  
> -	ipq_pll_config = of_device_get_match_data(&pdev->dev);
> -	if (!ipq_pll_config)
> +	data = of_device_get_match_data(&pdev->dev);
> +	if (!data)
>  		return -ENODEV;
>  
> -	clk_alpha_pll_configure(&ipq_pll, regmap, ipq_pll_config);
> +	clk_alpha_pll_configure(data->pll, regmap, data->pll_config);
>  
> -	ret = devm_clk_register_regmap(dev, &ipq_pll.clkr);
> +	ret = devm_clk_register_regmap(dev, &data->pll->clkr);
>  	if (ret)
>  		return ret;
>  
>  	return devm_of_clk_add_hw_provider(dev, of_clk_hw_simple_get,
> -					   &ipq_pll.clkr.hw);
> +					   &data->pll->clkr.hw);
>  }
>  
>  static const struct of_device_id apss_ipq_pll_match_table[] = {
> -	{ .compatible = "qcom,ipq6018-a53pll", .data = &ipq6018_pll_config },
> -	{ .compatible = "qcom,ipq8074-a53pll", .data = &ipq8074_pll_config },
> +	{ .compatible = "qcom,ipq6018-a53pll", .data = &ipq6018_pll_data },
> +	{ .compatible = "qcom,ipq8074-a53pll", .data = &ipq8074_pll_data },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(of, apss_ipq_pll_match_table);
