Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 023D46AA9AC
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 13:58:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbjCDM6Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Mar 2023 07:58:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbjCDM6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Mar 2023 07:58:17 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C9FE468C
        for <linux-kernel@vger.kernel.org>; Sat,  4 Mar 2023 04:57:53 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id i28so7045838lfv.0
        for <linux-kernel@vger.kernel.org>; Sat, 04 Mar 2023 04:57:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677934666;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HItay+PL2v1GbV7mEtNl/Zx/781VO+kx6PorfBarEts=;
        b=fGMyhkE8TUXu3ksMKFf9OWegAbIavnVQ8msuAK/1+1kUfqXb7UyHSRMM6K5anOxxyZ
         Af8u2SRLxmMznXu3beRe0AnG7DrRtfIWyaX2GQfKom4ZiJj68sqHNBg3VeL2wbNVkIQj
         komjbyZgFWlRHmAwrYJAVj5wCr3AU1GxcN9J+I90HYaUFAtUJ3MVXpw00pH/90pO37yg
         qgy5Y6YJFPUq/oFdVUUALPUlRDE5Aoi2OTMv8QFRx0zHg4lys5/yawPJUucdMYnhdYlJ
         B7RvjL+GunZQPt2nk+YBnawE+gkSRd4nAuhxSG5WioHVupNJhMI94StISCjGl7ADlBdR
         gTTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677934666;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HItay+PL2v1GbV7mEtNl/Zx/781VO+kx6PorfBarEts=;
        b=VWZlm1Q0tV3z5qgdFaDTSVBJEuFnRbJWi88m7HwAONw52BI2ThT8IjiIWCpRMfiVxX
         uXMoolmB05lQWZGM1qOYyjqzkHtiwAgNowYLOOcYRLYsoyiy4mWIqaCNuiNt0vgzUlRl
         sCWbFQTh2YhP45FuX5+UaNGgO1AkMJ4t9ayX1yPOFluuixtOXluAJxuMceVJmofSw2Qx
         6j+JNYP9NolyVhZd1rUJDvozgT8srD6YbesfHTMToMY3gmz3+ia5lq+3nARVLlM0eR/R
         9tlCUM89DlKRA/3Op1Bq66+MZiArj/kVOUC9iMfWizUJ19lmDEnCVN/HHIrIWca7Ll6q
         YB8A==
X-Gm-Message-State: AO0yUKUB1yJyUV5PXy+9JgVxzEwnORsvi/ozd2rgC903ouq9cEooxWY8
        KD9d+H1bvdil8qzLybelcg8Few==
X-Google-Smtp-Source: AK7set/2ECzyRzihXfRjdZIX2HDDQQq/RmqC8yQ7qFJv4u6lWF98CzmEfHcxSLhesLOTB6LSnwF3vg==
X-Received: by 2002:a05:6512:76:b0:4dd:a788:7783 with SMTP id i22-20020a056512007600b004dda7887783mr1387482lfo.61.1677934666258;
        Sat, 04 Mar 2023 04:57:46 -0800 (PST)
Received: from [192.168.1.101] (abym99.neoplus.adsl.tpnet.pl. [83.9.32.99])
        by smtp.gmail.com with ESMTPSA id b16-20020ac24110000000b004d862e9b453sm815813lfi.196.2023.03.04.04.57.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Mar 2023 04:57:45 -0800 (PST)
Message-ID: <9fc18ef2-87ea-33df-864c-916aaef7d3bf@linaro.org>
Date:   Sat, 4 Mar 2023 13:57:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 6/8] arm64: dts: qcom: sm6115p-lenovo-j606f: correct GPIO
 keys wakeup
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230304123358.34274-1-krzysztof.kozlowski@linaro.org>
 <20230304123358.34274-6-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230304123358.34274-6-krzysztof.kozlowski@linaro.org>
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



On 4.03.2023 13:33, Krzysztof Kozlowski wrote:
> gpio-keys,wakeup is a deprecated property:
> 
>   sm6115p-lenovo-j606f.dtb: gpio-keys: key-volume-up: Unevaluated properties are not allowed ('gpio-key,wakeup' was unexpected)
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/sm6115p-lenovo-j606f.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm6115p-lenovo-j606f.dts b/arch/arm64/boot/dts/qcom/sm6115p-lenovo-j606f.dts
> index 4ce2d905d70e..00b153aa1b7d 100644
> --- a/arch/arm64/boot/dts/qcom/sm6115p-lenovo-j606f.dts
> +++ b/arch/arm64/boot/dts/qcom/sm6115p-lenovo-j606f.dts
> @@ -49,7 +49,7 @@ key-volume-up {
>  			gpios = <&pm6125_gpios 5 GPIO_ACTIVE_LOW>;
>  			debounce-interval = <15>;
>  			linux,can-disable;
> -			gpio-key,wakeup;
> +			wakeup-source;
>  		};
>  	};
>  };
