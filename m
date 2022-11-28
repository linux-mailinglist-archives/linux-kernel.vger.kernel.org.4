Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14A6263ABC2
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 15:58:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231362AbiK1O6g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 09:58:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230399AbiK1O6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 09:58:33 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D111BE52
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 06:58:31 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id p8so17749493lfu.11
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 06:58:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ajNcLMY6QmAqgwHvTgxzL1USgmPi+/KLdoITf1G/CH4=;
        b=tqY2QmgNNWKIuP1WstZFTIldppn0/o3pVsMgn2N/EcXxdevmWKxoQYawyQqMoDUrUj
         lGXNuo2U2+dKA5WS/uSLRc3xAehkglIXDob89APQkw3zg4FcmOk6QkNS0XMOuzC7D2uO
         gDlKiuDlnL+VMIT/L7F3Y1azw8vP9wbINtSTgeMWxYwD0QTwWR9DhgEB3vjGc67sr2QG
         sz0nxySHhY5PEUjanSFA3tN1Jd44Opck5ZzIHJyciO6JWwkqVIHYSNiTtu5t9dSkbaAh
         gJPE/JcslvwliQe+swhij4knkMl6zUMoezk6LU/ltF2vwpXqTm5MYs+8MT24ixKZAJtS
         wwYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ajNcLMY6QmAqgwHvTgxzL1USgmPi+/KLdoITf1G/CH4=;
        b=dwPN6BaTwpUE6mKCJmNsc6qBxvxr8749e11PoW8ps8nDundtg28Hxwm411OjoPUpBp
         YWSeF3GufALgmiBG8Ea7O7Z7LDwqrOwGLBRnnDwZeoQqduTfK9doZxvpF6yCc8K+EMwq
         b6qfLPj8D3OlaV0UPYMf+JLhm7qn2uLAwL8RhTGa7g/Rp4+lR6MhH4pN4aWmJGi80Qip
         mVCEn+jAjRu/SCE6maA9U6J4M4wjq9Kq49cSNLBe4oEKKMaHgKVfg8BoWHtiQlw7ziR7
         wJQcuXAbussbKfiIsuYuVft/7eBlcPv4MOG3D8pOd3EWI9a4QemU3NKBFCf90I38KuRA
         TwMQ==
X-Gm-Message-State: ANoB5pnUeO8PaUSMocq6ZeXVD5IsLHkD3t+1qZrpAeX364vCQ2/Zn/Tv
        VbbLLGL4w+ltpHTGvDCT4KTrrA==
X-Google-Smtp-Source: AA0mqf6UI6FcpPI9uDfhvcmtur1U1zghV+aGkDbYf1gqWnNqpTKptXZ1bg39H7fkD1Or5r1DtWSNGg==
X-Received: by 2002:a05:6512:32d0:b0:4b4:b5ed:c71f with SMTP id f16-20020a05651232d000b004b4b5edc71fmr17042575lfg.227.1669647510166;
        Mon, 28 Nov 2022 06:58:30 -0800 (PST)
Received: from [192.168.1.101] (95.49.125.236.neoplus.adsl.tpnet.pl. [95.49.125.236])
        by smtp.gmail.com with ESMTPSA id p8-20020a2eba08000000b002776eb5b1ccsm1272424lja.4.2022.11.28.06.58.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Nov 2022 06:58:29 -0800 (PST)
Message-ID: <850051e5-73d4-6ab9-f924-8cd01dd2a3d6@linaro.org>
Date:   Mon, 28 Nov 2022 15:58:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 1/3] arm64: dts: qcom: msm8996-xiaomi-gemini: use
 preferred enable-gpios for LP5562 LED
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221127203240.54955-1-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221127203240.54955-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 27.11.2022 21:32, Krzysztof Kozlowski wrote:
> The preferred name suffix for properties with single and multiple GPIOs
> is "gpios".  Linux GPIO core code supports both.  Bindings are going to
> expect the "gpios" one:
> 
>   qcom/msm8996-xiaomi-gemini.dtb: lp5562@30: 'enable-gpio' does not match any of the regexes: '^led@[0-8]$', '^multi-led@[0-8]$', 'pinctrl-[0-9]+'
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
> 
> Changes since v1:
> 1. New patch
> ---
>  arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dts b/arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dts
> index d8734913482f..dbd5f7e2df65 100644
> --- a/arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dts
> +++ b/arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dts
> @@ -54,7 +54,7 @@ lp5562@30 {
>  		reg = <0x30>;
>  		#address-cells = <1>;
>  		#size-cells = <0>;
> -		enable-gpio = <&pm8994_gpios 7 1>;
> +		enable-gpios = <&pm8994_gpios 7 1>;
>  		clock-mode = /bits/8 <2>;
>  		label = "button-backlight";
>  
