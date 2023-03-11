Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F06B6B5B25
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 12:29:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231182AbjCKL3K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 06:29:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbjCKL2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 06:28:52 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D943146F1A
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 03:24:53 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id fm20-20020a05600c0c1400b003ead37e6588so7810080wmb.5
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 03:24:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678533840;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fUXxaux9yqlz38AdAUEuSrAiUAVJudPf4uFgO7xhgN0=;
        b=VFxOCDUEPsVhcKbejxB5Hdccmi9J9mAKwHdCrlRmSr4pN7APScxcgSSzvuopJG4PmF
         b+7Zs1XixjMPewVrcBNzMF06CswwzU07ZE+uw7/LRMmwYoxPqSsHtqm13mks+zDSQ0CS
         1MKsrewqPYFQwl5PQQfOb6a+INSMEduaVLYT/1R0JBHTvYsfmlFL29tOVgvZxFXiP+e7
         ld1/YSuFYTop3PppJm0JKUMvTppyqtsxxI7bu7PTVL9Gd+GfHDpXQgkION4S7VxGBDT3
         jdj7pwgtOxMybyAsafUx5od7EsPfT6+KLhmPsdNiopdCXY1nK/fjvlB1NtZXQ9bx95c/
         Q9/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678533840;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fUXxaux9yqlz38AdAUEuSrAiUAVJudPf4uFgO7xhgN0=;
        b=rCwwO/nQv944PP4olgEHx+u0FgdTkTZ6SCo0L0OBBh9Bk+pbWXaPtPww7edILtRP3b
         FCNGCRDy6Vy4MCL4SIBPFKMtnjkp1WlGR7FktjWrxiPVIyYSSVN2jhlWNXoK8PqFeV/9
         ByzSKu1vlnpRbbSYhtlaYThzEsotVYd3lyrOqKsD3WXtJyk5cCL6fik86Pu0UvHJ2D5E
         i+Hxy5QCHZTNaAsjxmlh/SGNfIcdN83n6yQeNo/CRSDLQZxdNb1622G3RBNtJCFxQWcr
         hCVVHz2BfEACi6+FMeNU485q/sniRDNvuIhVKNtyJY1aSy+qnGKWtuJ21r9Pe8HT6FoD
         /xGg==
X-Gm-Message-State: AO0yUKW754FeQGlEfH3uY3wgYyMq0hLXKFKdSelOAgfl1zRcT6j++Av6
        Mb22Rqus6MiCU3HhANb3Z3F5ig==
X-Google-Smtp-Source: AK7set/EmTYd9x054L4GupMVTe7ZI985v29V9FseD061Au4O+zVdI+5BoXKCRxE7slErtgIXb0uiwg==
X-Received: by 2002:a05:600c:1c28:b0:3de:1d31:1042 with SMTP id j40-20020a05600c1c2800b003de1d311042mr5353193wms.23.1678533840247;
        Sat, 11 Mar 2023 03:24:00 -0800 (PST)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id 10-20020a05600c22ca00b003eb3933ef10sm2453856wmg.46.2023.03.11.03.23.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Mar 2023 03:23:58 -0800 (PST)
Message-ID: <5b923d49-c151-0ed7-3db1-a7caf85109f3@linaro.org>
Date:   Sat, 11 Mar 2023 11:23:57 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 3/9] ASoC: codecs: lpass-rx-macro: add support for SM8550
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
 <20230310132201.322148-4-krzysztof.kozlowski@linaro.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20230310132201.322148-4-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Krzysztof for adding this support.
Few minor nits,

On 10/03/2023 13:21, Krzysztof Kozlowski wrote:
> Add support for the RX macro codec on Qualcomm SM8550.  SM8550 does not
> use NPL clock, thus add flags allowing to skip it.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>   sound/soc/codecs/lpass-rx-macro.c | 39 ++++++++++++++++++++++++-------
>   1 file changed, 31 insertions(+), 8 deletions(-)
> 
> diff --git a/sound/soc/codecs/lpass-rx-macro.c b/sound/soc/codecs/lpass-rx-macro.c
> index a73a7d7a1c0a..e322d918db36 100644
> --- a/sound/soc/codecs/lpass-rx-macro.c
> +++ b/sound/soc/codecs/lpass-rx-macro.c
> @@ -395,6 +395,9 @@
>   #define COMP_MAX_COEFF 25
>   #define RX_NUM_CLKS_MAX	5
>   
> +/* NPL clock is expected */
> +#define RX_MACRO_FLAG_HAS_NPL_CLOCK		BIT(0)

We could probably rename it and move it to 
sound/soc/codecs/lpass-macro-common.h as this equally applies to all the 
codec macros.


Once done,

Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

> +
>   struct comp_coeff_val {
>   	u8 lsb;
>   	u8 msb;
> @@ -3491,7 +3494,10 @@ static int rx_macro_register_mclk_output(struct rx_macro *rx)
>   	struct clk_init_data init;
>   	int ret;
>   
> -	parent_clk_name = __clk_get_name(rx->npl);
> +	if (rx->npl)
> +		parent_clk_name = __clk_get_name(rx->npl);
> +	else
> +		parent_clk_name = __clk_get_name(rx->mclk);
>   
>   	init.name = clk_name;
>   	init.ops = &swclk_gate_ops;
> @@ -3521,10 +3527,13 @@ static const struct snd_soc_component_driver rx_macro_component_drv = {
>   static int rx_macro_probe(struct platform_device *pdev)
>   {
>   	struct device *dev = &pdev->dev;
> +	kernel_ulong_t flags;
>   	struct rx_macro *rx;
>   	void __iomem *base;
>   	int ret;
>   
> +	flags = (kernel_ulong_t)device_get_match_data(dev);
> +
>   	rx = devm_kzalloc(dev, sizeof(*rx), GFP_KERNEL);
>   	if (!rx)
>   		return -ENOMEM;
> @@ -3541,9 +3550,11 @@ static int rx_macro_probe(struct platform_device *pdev)
>   	if (IS_ERR(rx->mclk))
>   		return PTR_ERR(rx->mclk);
>   
> -	rx->npl = devm_clk_get(dev, "npl");
> -	if (IS_ERR(rx->npl))
> -		return PTR_ERR(rx->npl);
> +	if (flags & RX_MACRO_FLAG_HAS_NPL_CLOCK) {
> +		rx->npl = devm_clk_get(dev, "npl");
> +		if (IS_ERR(rx->npl))
> +			return PTR_ERR(rx->npl);
> +	}
>   
>   	rx->fsgen = devm_clk_get(dev, "fsgen");
>   	if (IS_ERR(rx->fsgen))
> @@ -3655,10 +3666,22 @@ static int rx_macro_remove(struct platform_device *pdev)
>   }
>   
>   static const struct of_device_id rx_macro_dt_match[] = {
> -	{ .compatible = "qcom,sc7280-lpass-rx-macro" },
> -	{ .compatible = "qcom,sm8250-lpass-rx-macro" },
> -	{ .compatible = "qcom,sm8450-lpass-rx-macro" },
> -	{ .compatible = "qcom,sc8280xp-lpass-rx-macro" },
> +	{
> +		.compatible = "qcom,sc7280-lpass-rx-macro",
> +		.data = (void *)RX_MACRO_FLAG_HAS_NPL_CLOCK,
> +
> +	}, {
> +		.compatible = "qcom,sm8250-lpass-rx-macro",
> +		.data = (void *)RX_MACRO_FLAG_HAS_NPL_CLOCK,
> +	}, {
> +		.compatible = "qcom,sm8450-lpass-rx-macro",
> +		.data = (void *)RX_MACRO_FLAG_HAS_NPL_CLOCK,
> +	}, {
> +		.compatible = "qcom,sm8550-lpass-rx-macro",
> +	}, {
> +		.compatible = "qcom,sc8280xp-lpass-rx-macro",
> +		.data = (void *)RX_MACRO_FLAG_HAS_NPL_CLOCK,
> +	},
>   	{ }
>   };
>   MODULE_DEVICE_TABLE(of, rx_macro_dt_match);
