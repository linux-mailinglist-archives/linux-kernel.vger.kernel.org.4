Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34F6C6B5B29
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 12:29:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231183AbjCKL3e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 06:29:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230409AbjCKL3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 06:29:07 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51E17147246
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 03:25:20 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id q16so7328276wrw.2
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 03:25:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678533883;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4S3fpbxvlb7vecpt9Hto2orpDQNfSYRZ6kHelmpqnlk=;
        b=Hh4ZeOCUtyl4wTS63hDa0z7rk6opFTeKQ0XWB9QXmeRtfpo8vG4vVEB/Osxyxc4HdZ
         UwdAyZBXw0FaV6iC8GOFQDFBAZhd0D39ncujO96nLWYX38+PjHIijCFBCCbyEwtQO4TF
         Hr2WWJtvVg1w4DUaAw1dnF2yLLH1wyklIGLXj0PWSAH9CK1ojxmOpI/hbAdC1I1nYyLI
         c5bgG9a5xt4G5r6IPXb/Kl2IQU5Q2TE7+VxpvOYA79q2yod306oLDW9qj+xFeAtwXz0K
         B+EBMXyM2QU/+tdODJDb99wm828wIXdU36l7Zp0fxNxKm/6JH2JxItPNGp8tD2XOtD6C
         mRsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678533883;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4S3fpbxvlb7vecpt9Hto2orpDQNfSYRZ6kHelmpqnlk=;
        b=5qU1cYrIUtauFXZLSiMB0ldnhyfyMNMtG3nmQc7/C2UCkcgA5ngHXXrR+tOUCjGPsl
         iYPqoXH7QSrwkf1IaF8AH/SxiZO3SgRmE553FnQew/MbVovIwYWrPZDwxmhT1azSJ/7y
         Mw+C/fcnKi9cAewXcZ5o+tZvhbcmRucjWrxdbWl30Kj1FNt3pHzEdBz+iJHkuFplTAQP
         TeagDQYLG4gq6ZO/Sp87GbFRlY364EsBDY4uVn5H/5qGVs3PdD3degd6LnP7eBCldjqn
         Ivs/GPigKJJz59pyb/WQsCx0L/Wl4ukA9JmSQuHlfHt9lV2hp5NjmmG6xlTtMUo9egP9
         7UrA==
X-Gm-Message-State: AO0yUKXP5V2KPfLR7xtKym1yomFGiK0XAWsLG/yawJ7SE0ePd/89Vr7t
        Pg2KeyufeSJfo5LEffSbsLtH7Uyn1qzX85fiG14=
X-Google-Smtp-Source: AK7set/wOBkMS1eYPDTG/VWBTdTxpyOHdR3rjM4CnjpSbrDQikBiv0tlPS9rE6gmULGJ8xu75C09wQ==
X-Received: by 2002:adf:ef8b:0:b0:2ce:a7df:c115 with SMTP id d11-20020adfef8b000000b002cea7dfc115mr432579wro.41.1678533883352;
        Sat, 11 Mar 2023 03:24:43 -0800 (PST)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id u13-20020a5d434d000000b002c57384dfe0sm2145312wrr.113.2023.03.11.03.24.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Mar 2023 03:24:42 -0800 (PST)
Message-ID: <492bc15c-a59c-92f5-3d57-d6bfcf03c4ce@linaro.org>
Date:   Sat, 11 Mar 2023 11:24:41 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 6/9] ASoC: codecs: lpass-tx-macro: add support for SM8550
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
 <20230310132201.322148-7-krzysztof.kozlowski@linaro.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20230310132201.322148-7-krzysztof.kozlowski@linaro.org>
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



On 10/03/2023 13:21, Krzysztof Kozlowski wrote:
> Add support for the TX macro codec on Qualcomm SM8550.  SM8550 does not
> use NPL clock, thus add flags allowing to skip it.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>   sound/soc/codecs/lpass-tx-macro.c | 38 ++++++++++++++++++++++++-------
>   1 file changed, 30 insertions(+), 8 deletions(-)
> 
> diff --git a/sound/soc/codecs/lpass-tx-macro.c b/sound/soc/codecs/lpass-tx-macro.c
> index 473d3cd39554..23371b21505e 100644
> --- a/sound/soc/codecs/lpass-tx-macro.c
> +++ b/sound/soc/codecs/lpass-tx-macro.c
> @@ -205,6 +205,9 @@
>   #define TX_MACRO_AMIC_HPF_DELAY_MS	300
>   #define MCLK_FREQ		19200000
>   
> +/* NPL clock is expected */
> +#define TX_MACRO_FLAG_HAS_NPL_CLOCK		BIT(0)
> +

Same nit as 3/9

Once done,

Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

--srini

>   enum {
>   	TX_MACRO_AIF_INVALID = 0,
>   	TX_MACRO_AIF1_CAP,
> @@ -1915,7 +1918,10 @@ static int tx_macro_register_mclk_output(struct tx_macro *tx)
>   	struct clk_init_data init;
>   	int ret;
>   
> -	parent_clk_name = __clk_get_name(tx->npl);
> +	if (tx->npl)
> +		parent_clk_name = __clk_get_name(tx->npl);
> +	else
> +		parent_clk_name = __clk_get_name(tx->mclk);
>   
>   	init.name = clk_name;
>   	init.ops = &swclk_gate_ops;
> @@ -1946,10 +1952,13 @@ static int tx_macro_probe(struct platform_device *pdev)
>   {
>   	struct device *dev = &pdev->dev;
>   	struct device_node *np = dev->of_node;
> +	kernel_ulong_t flags;
>   	struct tx_macro *tx;
>   	void __iomem *base;
>   	int ret, reg;
>   
> +	flags = (kernel_ulong_t)device_get_match_data(dev);
> +
>   	tx = devm_kzalloc(dev, sizeof(*tx), GFP_KERNEL);
>   	if (!tx)
>   		return -ENOMEM;
> @@ -1966,9 +1975,11 @@ static int tx_macro_probe(struct platform_device *pdev)
>   	if (IS_ERR(tx->mclk))
>   		return PTR_ERR(tx->mclk);
>   
> -	tx->npl = devm_clk_get(dev, "npl");
> -	if (IS_ERR(tx->npl))
> -		return PTR_ERR(tx->npl);
> +	if (flags & TX_MACRO_FLAG_HAS_NPL_CLOCK) {
> +		tx->npl = devm_clk_get(dev, "npl");
> +		if (IS_ERR(tx->npl))
> +			return PTR_ERR(tx->npl);
> +	}
>   
>   	tx->fsgen = devm_clk_get(dev, "fsgen");
>   	if (IS_ERR(tx->fsgen))
> @@ -2145,10 +2156,21 @@ static const struct dev_pm_ops tx_macro_pm_ops = {
>   };
>   
>   static const struct of_device_id tx_macro_dt_match[] = {
> -	{ .compatible = "qcom,sc7280-lpass-tx-macro" },
> -	{ .compatible = "qcom,sm8250-lpass-tx-macro" },
> -	{ .compatible = "qcom,sm8450-lpass-tx-macro" },
> -	{ .compatible = "qcom,sc8280xp-lpass-tx-macro" },
> +	{
> +		.compatible = "qcom,sc7280-lpass-tx-macro",
> +		.data = (void *)TX_MACRO_FLAG_HAS_NPL_CLOCK,
> +	}, {
> +		.compatible = "qcom,sm8250-lpass-tx-macro",
> +		.data = (void *)TX_MACRO_FLAG_HAS_NPL_CLOCK,
> +	}, {
> +		.compatible = "qcom,sm8450-lpass-tx-macro",
> +		.data = (void *)TX_MACRO_FLAG_HAS_NPL_CLOCK,
> +	}, {
> +		.compatible = "qcom,sm8550-lpass-tx-macro",
> +	}, {
> +		.compatible = "qcom,sc8280xp-lpass-tx-macro",
> +		.data = (void *)TX_MACRO_FLAG_HAS_NPL_CLOCK,
> +	},
>   	{ }
>   };
>   MODULE_DEVICE_TABLE(of, tx_macro_dt_match);
