Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF6206B33FB
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 03:08:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbjCJCIR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 21:08:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbjCJCIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 21:08:14 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8D401DB95
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 18:08:12 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id j11so4742362lfg.13
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 18:08:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678414091;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+5SNm4lOHHU7wShff2ch965COCwpdhcw8gwXQ/+p/Ko=;
        b=C0Ji1rsS/E3jgtCk6insuFs5fYpP6b+hYbsAlz+SMRLtgPsiKjLFqrJp/uePbNYZ/4
         2qx9bm4AcB9MZRNkdPllO0/bJpRDRDAdlwF2V1p1aPTl30hXkzyWa8eTycUNWS3lq2Ul
         C0V6XfMkxSmcL/PgCpO1GzL4a/Ldx0Vq0imtRES8D0aQd2z7rhB+JYTWnJ5bt5eacChv
         qtrNasOoXSnZj68uLm0dkNLY0Oth+ENftWZuWikkYeyPFSFqmAMM0yr8HCybs+Bo+8aV
         cE8aE0A/buImW4nRRIRjMHA+K8Envqysp65/wWUzPj5Hj932fwi9HvNZcMWpSn7/Rz57
         C2Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678414091;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+5SNm4lOHHU7wShff2ch965COCwpdhcw8gwXQ/+p/Ko=;
        b=WULwf4eaIynzWFvYTDn93hkZA23YUQ6qaeneZb5y7RL/05T4UbK/yqLlP8TUEcOBfz
         oW6dMxgZmaHMtB3MWwWluBnAu1sLf+kcFsVRBFOvbniSR4rlmKIfQGLlQfpRMUcguSa2
         j/s6pcZQYWM40PbnplP/hoMvCS4j+NXFlgTt3LpyiHBdLWthg7kKXXTMCi64rHraFVIG
         Ca1alVLTZq/r+ZW5M6g3m0L+Yadq58O+TYRTARMHL3hRvSi61YBUKAZJe+lTSOdMiSQg
         nBb/w+jRb9c8V4ymqDbL4v/hLMiqZPU/Q/u+N3TIopNZ/EeXuFJZ6EeB5JOYqCsx5VnO
         iOOA==
X-Gm-Message-State: AO0yUKW3NvIzKV1+tL04m3raPTZpum03qdoMPNSvTx7L2vz+fKKDnF0s
        9sQLKrL22232JkkNY/ugBzKoWg==
X-Google-Smtp-Source: AK7set9yl2SsmuKBBFb/VWC7gdEdVqofHMmy7RFNyAoY3Mt9PXE5cIJWAyxNDDABR93PXHxwguNx9A==
X-Received: by 2002:ac2:4315:0:b0:4cf:e904:bba5 with SMTP id l21-20020ac24315000000b004cfe904bba5mr6131386lfh.29.1678414091049;
        Thu, 09 Mar 2023 18:08:11 -0800 (PST)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id d8-20020a05651221c800b004dc4e3f02aasm90331lft.53.2023.03.09.18.08.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Mar 2023 18:08:10 -0800 (PST)
Message-ID: <bd829dcb-0b06-9edb-65f9-35ad240c5f17@linaro.org>
Date:   Fri, 10 Mar 2023 03:08:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 1/4] pinctrl: qcom: lpass-lpi: set output value before
 enabling output
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org
References: <20230309154949.658380-1-krzysztof.kozlowski@linaro.org>
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230309154949.658380-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9.03.2023 16:49, Krzysztof Kozlowski wrote:
> As per Hardware Programming Guide, when configuring pin as output,
> set the pin value before setting output-enable (OE).  Similar approach
> is in main SoC TLMM pin controller.
> 
> Cc: <stable@vger.kernel.org>
> Fixes: 6e261d1090d6 ("pinctrl: qcom: Add sm8250 lpass lpi pinctrl driver")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  drivers/pinctrl/qcom/pinctrl-lpass-lpi.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pinctrl/qcom/pinctrl-lpass-lpi.c b/drivers/pinctrl/qcom/pinctrl-lpass-lpi.c
> index 87920257bb73..27fc8b671954 100644
> --- a/drivers/pinctrl/qcom/pinctrl-lpass-lpi.c
> +++ b/drivers/pinctrl/qcom/pinctrl-lpass-lpi.c
> @@ -221,6 +221,15 @@ static int lpi_config_set(struct pinctrl_dev *pctldev, unsigned int group,
>  		}
>  	}
>  
> +	/*
> +	 * As per Hardware Programming Guide, when configuring pin as output,
> +	 * set the pin value before setting output-enable (OE).
> +	 */
> +	if (output_enabled) {
> +		val = u32_encode_bits(value ? 1 : 0, LPI_GPIO_VALUE_OUT_MASK);
> +		lpi_gpio_write(pctrl, group, LPI_GPIO_VALUE_REG, val);
> +	}
> +
>  	val = lpi_gpio_read(pctrl, group, LPI_GPIO_CFG_REG);
>  
>  	u32p_replace_bits(&val, pullup, LPI_GPIO_PULL_MASK);
> @@ -230,11 +239,6 @@ static int lpi_config_set(struct pinctrl_dev *pctldev, unsigned int group,
>  
>  	lpi_gpio_write(pctrl, group, LPI_GPIO_CFG_REG, val);
>  
> -	if (output_enabled) {
> -		val = u32_encode_bits(value ? 1 : 0, LPI_GPIO_VALUE_OUT_MASK);
> -		lpi_gpio_write(pctrl, group, LPI_GPIO_VALUE_REG, val);
> -	}
> -
>  	return 0;
>  }
>  
