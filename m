Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE8C86B5B35
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 12:31:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbjCKLbE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 06:31:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230432AbjCKLak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 06:30:40 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 194AC1F5F1
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 03:28:24 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id t15so7318290wrz.7
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 03:28:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678534102;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XDMAzPVGWaW2YqhCLxx5Xr14Zn9rwUVyczdQ2OeXd7I=;
        b=y6fhnsSrEgQsstfpWqjDwJogogEcQNx8m4O3ID0vcK44x859+0PjMTdKh7GhBrg8Rv
         oRQmEEetEaW2ijNqSK64ioCBSw4WijTWGxsn8e2gdm5aJcrCMJuHmCwBA0gZ36/4CoID
         vKtVp41kS4+Oj8M1Xuhsnbds1ZFv8noivoMeGD0AdFEUJYJ5ZhA0e8Lpp4PViWvNbKem
         TnlJGCg1e70AxFxViWiG4bHFLWzQdfCHdjLmTj3wjf7Kf8I784AUhkarQ/05BoGqs7If
         nd8HYMeT+eLsnk1gK01/EfSQ3Yvk3NVp7X/nSJ7CmC/Ho4G//iq8lT/NXC2ylOxWZrPL
         Fnug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678534102;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XDMAzPVGWaW2YqhCLxx5Xr14Zn9rwUVyczdQ2OeXd7I=;
        b=Mo3QXCysMK0ICzebN4cLUb10nuuojVXB3hfnmmDrPteu5m68F2SJt8QXZj6VAej4nw
         PkMhr+1OgWiG18371+FoJh3LI5LKTkiPAijbjcp2mteNo/vpz+eIxVIUtglEcZQyVVW6
         /khuOUeBmJyzXgA9MyOoZRMAp7+tkPeUNMQ4xRoOvWk9n2MrSIrurHoLGolhupH58pPG
         lOW5gdzkr+2sWOqfgnOi8gXuogJJrOeTO8e8KpVcdXBPi627hZnDRSbf68Crdlht0+rf
         DSFAuDKsGBBECvf68TXB87l77cKK78TTBkJH9sI9K2BR9FvcZhCDPrr8A/cqZTWGFj5D
         ve/g==
X-Gm-Message-State: AO0yUKVPHgedKAAYJAKp9LYeenyN0SF/kbw31Pc+ctFCPM40tNjxHwqA
        wD0Xklq0LRWld61Dwvt7cyhtyw==
X-Google-Smtp-Source: AK7set+ILtHB+iI50WOHx6Ly0RIbpaYq3bu/QFN6T1Ki2GT7UvOs3HlFmGpSOYj9IWfqP+TZyP5aog==
X-Received: by 2002:adf:e452:0:b0:2ce:a8a2:37d7 with SMTP id t18-20020adfe452000000b002cea8a237d7mr87809wrm.27.1678534102573;
        Sat, 11 Mar 2023 03:28:22 -0800 (PST)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id h16-20020adffd50000000b002c56af32e8csm2214201wrs.35.2023.03.11.03.28.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Mar 2023 03:28:21 -0800 (PST)
Message-ID: <e99b2c89-c9c4-8d79-d14e-221ff106798f@linaro.org>
Date:   Sat, 11 Mar 2023 11:28:20 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 9/9] ASoC: codecs: lpass-wsa-macro: add support for SM8550
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230310132201.322148-1-krzysztof.kozlowski@linaro.org>
 <20230310132201.322148-10-krzysztof.kozlowski@linaro.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20230310132201.322148-10-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/03/2023 13:22, Krzysztof Kozlowski wrote:
> Add support for the WSA macro codec on Qualcomm SM8550.  SM8550 does not
> use NPL clock, thus add flags allowing to skip it.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>   sound/soc/codecs/lpass-wsa-macro.c | 38 +++++++++++++++++++++++-------
>   1 file changed, 30 insertions(+), 8 deletions(-)
> 
> diff --git a/sound/soc/codecs/lpass-wsa-macro.c b/sound/soc/codecs/lpass-wsa-macro.c
> index ba7480f3831e..5155362de111 100644
> --- a/sound/soc/codecs/lpass-wsa-macro.c
> +++ b/sound/soc/codecs/lpass-wsa-macro.c
> @@ -246,6 +246,9 @@
>   #define WSA_MACRO_EC_MIX_TX1_MASK 0x18
>   #define WSA_MACRO_MAX_DMA_CH_PER_PORT 0x2
>   
> +/* NPL clock is expected */
> +#define WSA_MACRO_FLAG_HAS_NPL_CLOCK		BIT(0)
> +


Same nit as 3/9

Once done,

Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

--srini

>   enum {
>   	WSA_MACRO_GAIN_OFFSET_M1P5_DB,
>   	WSA_MACRO_GAIN_OFFSET_0_DB,
> @@ -2346,7 +2349,10 @@ static int wsa_macro_register_mclk_output(struct wsa_macro *wsa)
>   	struct clk_init_data init;
>   	int ret;
>   
> -	parent_clk_name = __clk_get_name(wsa->npl);
> +	if (wsa->npl)
> +		parent_clk_name = __clk_get_name(wsa->npl);
> +	else
> +		parent_clk_name = __clk_get_name(wsa->mclk);
>   
>   	init.name = "mclk";
>   	of_property_read_string(dev_of_node(dev), "clock-output-names",
> @@ -2379,9 +2385,12 @@ static int wsa_macro_probe(struct platform_device *pdev)
>   {
>   	struct device *dev = &pdev->dev;
>   	struct wsa_macro *wsa;
> +	kernel_ulong_t flags;
>   	void __iomem *base;
>   	int ret;
>   
> +	flags = (kernel_ulong_t)device_get_match_data(dev);
> +
>   	wsa = devm_kzalloc(dev, sizeof(*wsa), GFP_KERNEL);
>   	if (!wsa)
>   		return -ENOMEM;
> @@ -2398,9 +2407,11 @@ static int wsa_macro_probe(struct platform_device *pdev)
>   	if (IS_ERR(wsa->mclk))
>   		return PTR_ERR(wsa->mclk);
>   
> -	wsa->npl = devm_clk_get(dev, "npl");
> -	if (IS_ERR(wsa->npl))
> -		return PTR_ERR(wsa->npl);
> +	if (flags & WSA_MACRO_FLAG_HAS_NPL_CLOCK) {
> +		wsa->npl = devm_clk_get(dev, "npl");
> +		if (IS_ERR(wsa->npl))
> +			return PTR_ERR(wsa->npl);
> +	}
>   
>   	wsa->fsgen = devm_clk_get(dev, "fsgen");
>   	if (IS_ERR(wsa->fsgen))
> @@ -2553,10 +2564,21 @@ static const struct dev_pm_ops wsa_macro_pm_ops = {
>   };
>   
>   static const struct of_device_id wsa_macro_dt_match[] = {
> -	{.compatible = "qcom,sc7280-lpass-wsa-macro"},
> -	{.compatible = "qcom,sm8250-lpass-wsa-macro"},
> -	{.compatible = "qcom,sm8450-lpass-wsa-macro"},
> -	{.compatible = "qcom,sc8280xp-lpass-wsa-macro" },
> +	{
> +		.compatible = "qcom,sc7280-lpass-wsa-macro",
> +		.data = (void *)WSA_MACRO_FLAG_HAS_NPL_CLOCK,
> +	}, {
> +		.compatible = "qcom,sm8250-lpass-wsa-macro",
> +		.data = (void *)WSA_MACRO_FLAG_HAS_NPL_CLOCK,
> +	}, {
> +		.compatible = "qcom,sm8450-lpass-wsa-macro",
> +		.data = (void *)WSA_MACRO_FLAG_HAS_NPL_CLOCK,
> +	}, {
> +		.compatible = "qcom,sm8550-lpass-wsa-macro",
> +	}, {
> +		.compatible = "qcom,sc8280xp-lpass-wsa-macro",
> +		.data = (void *)WSA_MACRO_FLAG_HAS_NPL_CLOCK,
> +	},
>   	{}
>   };
>   MODULE_DEVICE_TABLE(of, wsa_macro_dt_match);
