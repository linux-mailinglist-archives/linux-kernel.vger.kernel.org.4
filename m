Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 685896828B9
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 10:25:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232515AbjAaJZK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 04:25:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232500AbjAaJZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 04:25:07 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D2CE2D50
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 01:25:05 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id m2so39260573ejb.8
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 01:25:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1K2AmG/1xX3o9jCz/cl3faZV0axMHqEfr6qkYyw8x1E=;
        b=xmHbt15Y4ncVikPF/chHw9oChq8DXTeP13OhwTyPj3XaNakiYAoXuYo/HBQ2NbVwDm
         6TWtHSnFAHsVpOOm0Jo1SXWeRjyXU+W6wINfFalCPAZms6ygia9CxlriC1eQukeP6QwV
         heGiBNjXiJLGW5rIfjQ3cwpFAFxxfP89bqAZTbmvsTrQ/hYYhLAvFzSPKN0bgdPWZUAK
         Oa4JuWNcFLmtZSkSmYkh1O6Gko7ZnO3Ogdbc8evf+7VCaGbHGiweoOciny4CfAzs0jIR
         1F4l1d0g1ubjcy6qilbuG3M4wFA4GTWxXHslN9/PDp0GTljFfwwLvYR2fa01qaGfxlvG
         6FrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1K2AmG/1xX3o9jCz/cl3faZV0axMHqEfr6qkYyw8x1E=;
        b=DM0oPc3/twlunay1O6YFnWT6dIXljT7tq4AFZVtw/zJnmlYkXpmstikC9DhyWwTZI3
         X5GqTNiqRjMy92pdjKL+llmiDEznFdRRAT6jQ+Qkp55pN0DgNZMMYo/4ObwVQw4KXavx
         XLXMPmuvPIx26i1Y++/sWr1ejTWIGV6mh95OUuz2/vCqscRrbvJLog9EiBvAwzw5ylSh
         GbR0r8+Vidg1Pg70KFR4vDXd8UoH1LnJvgFDpfHaV/y/sYoFYlyv3nKwRCh6MB7gZnQD
         XWPcyYZ9YvUn5OWS5ie055Ys2Dtpsf2T2NS5dB7+CKRYi8QBGdRyGk/7SMIEtIrea4no
         uPlw==
X-Gm-Message-State: AO0yUKWIAUnPrnDQcxk4fH2cM9O9VlI+Xc9h2rT34h9pml+oIaBuxvia
        sccsgUYtMNYQGJdvpAn8lue8eA==
X-Google-Smtp-Source: AK7set94dNTag513N+HVbc8H2Eto182JDIc4bF2a/NxnmxZekm32ph4O+BBPLXKQxiOSTqtC5VeMhQ==
X-Received: by 2002:a17:907:a80d:b0:879:ab3:93d1 with SMTP id vo13-20020a170907a80d00b008790ab393d1mr20204678ejc.4.1675157104240;
        Tue, 31 Jan 2023 01:25:04 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id hq15-20020a1709073f0f00b00770812e2394sm8132758ejc.160.2023.01.31.01.25.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Jan 2023 01:25:03 -0800 (PST)
Message-ID: <550dd5e8-6238-0e48-bac7-7c9b6e67cb00@linaro.org>
Date:   Tue, 31 Jan 2023 11:25:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v4 8/8] clk: qcom: Add GPU clock controller driver for
 SM6115
Content-Language: en-GB
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
References: <20230130235926.2419776-1-konrad.dybcio@linaro.org>
 <20230130235926.2419776-9-konrad.dybcio@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230130235926.2419776-9-konrad.dybcio@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 31/01/2023 01:59, Konrad Dybcio wrote:
> Add support for the GPU clock controller found on SM6115.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>   drivers/clk/qcom/Kconfig        |   9 +
>   drivers/clk/qcom/Makefile       |   1 +
>   drivers/clk/qcom/gpucc-sm6115.c | 512 ++++++++++++++++++++++++++++++++
>   3 files changed, 522 insertions(+)
>   create mode 100644 drivers/clk/qcom/gpucc-sm6115.c

[skipped]

> +static int gpu_cc_sm6115_probe(struct platform_device *pdev)
> +{
> +	struct regmap *regmap;
> +	unsigned int value, mask;
> +
> +	regmap = qcom_cc_map(pdev, &gpu_cc_sm6115_desc);
> +	if (IS_ERR(regmap))
> +		return PTR_ERR(regmap);
> +
> +	clk_alpha_pll_configure(&gpu_cc_pll0, regmap, &gpu_cc_pll0_config);
> +	clk_alpha_pll_configure(&gpu_cc_pll1, regmap, &gpu_cc_pll1_config);
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

But you have your new helpers to set these values, don't you?

> +
> +	return qcom_cc_really_probe(pdev, &gpu_cc_sm6115_desc, regmap);
> +}
> +
> +static struct platform_driver gpu_cc_sm6115_driver = {
> +	.probe = gpu_cc_sm6115_probe,
> +	.driver = {
> +		.name = "sm6115-gpucc",
> +		.of_match_table = gpu_cc_sm6115_match_table,
> +	},
> +};
> +module_platform_driver(gpu_cc_sm6115_driver);
> +
> +MODULE_DESCRIPTION("QTI GPU_CC SM6115 Driver");
> +MODULE_LICENSE("GPL");

-- 
With best wishes
Dmitry

