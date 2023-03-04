Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB1A66AA9AF
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 13:58:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbjCDM63 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Mar 2023 07:58:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjCDM6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Mar 2023 07:58:24 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58F0A10AA1
        for <linux-kernel@vger.kernel.org>; Sat,  4 Mar 2023 04:57:57 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id k14so6964993lfj.7
        for <linux-kernel@vger.kernel.org>; Sat, 04 Mar 2023 04:57:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677934675;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Jh8K8XRUlaXKnLK6LOkf496x0zXkPwv3l84nGkCkags=;
        b=JyNeYzYtlXaI5qT/1fM+HlkpLhdd0iKH6Bsdavz3oOPa+IV9FBLNAYEW+evRDHoNs4
         LNRaCqEH4ROq5xKAzi7WBCEAMfmVfXHrG95abR8Ze8Z5LYcGKqvzqoskaskIRegX8jaO
         bqC01JYqpZy4jvhH4gDfRC2w+NudvLCyic+LLiu4R9xEFeT7fhaw+/SjuWGnxadD4oZW
         twUIkesTcINcxYHoHTxNvJagNpU+wXIljrPbyVw0UPc67Dl4yPZ4PJvNWQrENVyc5OMy
         +2zYHVrmnHvFAp/1NA60pbJok2qHLkavkpwwIgqzSZuHnQu+CrSw0ztgJUfaT4B+mA99
         zRig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677934675;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jh8K8XRUlaXKnLK6LOkf496x0zXkPwv3l84nGkCkags=;
        b=4ipv73f4p4NjhgT3AIoR9nDuW1ZGOUtayWT1fY+6hMPnpZtGa2P6u02cJUB9Boq+m8
         Iz0MDi61/wD1T3EVYfZ3d3xl5cANGkMR3nTlWzcEzig7Llsdn/MhcI++xgyTR1VOqR4N
         hXeC6+mA9wCNrm1MiNd5PDk9SHwxuD8DK5kqR644p23t97A863y7jKQEoIUvXcoC1YVJ
         YVkXCSFnGvPYbei/sKRU48ii5iLinGUEf6J6eu5W7LlZQCSOWdlTwNQ4VVCVXNLVpOv9
         CPSQKyOjOIlE3Xtk4gtDyhzTwt/BVoQJk996rCLbYssSoWV5Zll5p25uwXGohMk3ANUZ
         ElSg==
X-Gm-Message-State: AO0yUKXipuGwyRx77HW/LSNN7FKNQtz9+kIq5zJ/cvb2YgbhnD95mA5q
        au3ozFTQjp4gdNaDtoeWDLrr9W+h+51gU8RXuiY=
X-Google-Smtp-Source: AK7set+3vPsCu1KXT6igbDn+jLPyFwKsPFTRayrz0wvGS8P5h6cEOU2UqADiiRgq2zqseaWaHVNEvA==
X-Received: by 2002:ac2:528b:0:b0:4cc:84da:44bd with SMTP id q11-20020ac2528b000000b004cc84da44bdmr1330911lfm.39.1677934675255;
        Sat, 04 Mar 2023 04:57:55 -0800 (PST)
Received: from [192.168.1.101] (abym99.neoplus.adsl.tpnet.pl. [83.9.32.99])
        by smtp.gmail.com with ESMTPSA id m16-20020ac24290000000b004e1b880ba20sm810960lfh.292.2023.03.04.04.57.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Mar 2023 04:57:54 -0800 (PST)
Message-ID: <a3c9cca5-39f3-98d0-4b70-ba91103f7ded@linaro.org>
Date:   Sat, 4 Mar 2023 13:57:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 7/8] arm64: dts: qcom: sm8250-sony-xperia: correct GPIO
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
 <20230304123358.34274-7-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230304123358.34274-7-krzysztof.kozlowski@linaro.org>
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
>   sm8250-sony-xperia-edo-pdx206.dtb: gpio-keys: key-vol-down: Unevaluated properties are not allowed ('gpio-key,wakeup' was unexpected)
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo-pdx206.dts | 2 +-
>  arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo.dtsi       | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo-pdx206.dts b/arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo-pdx206.dts
> index 5ecf7dafb2ec..01fe3974ee72 100644
> --- a/arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo-pdx206.dts
> +++ b/arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo-pdx206.dts
> @@ -26,7 +26,7 @@ g-assist-key {
>  		gpios = <&pm8150_gpios 6 GPIO_ACTIVE_LOW>;
>  		debounce-interval = <15>;
>  		linux,can-disable;
> -		gpio-key,wakeup;
> +		wakeup-source;
>  	};
>  };
>  
> diff --git a/arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo.dtsi b/arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo.dtsi
> index b9c982a059df..c96cc9c90a5f 100644
> --- a/arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo.dtsi
> @@ -63,7 +63,7 @@ key-vol-down {
>  			gpios = <&pm8150_gpios 1 GPIO_ACTIVE_LOW>;
>  			debounce-interval = <15>;
>  			linux,can-disable;
> -			gpio-key,wakeup;
> +			wakeup-source;
>  		};
>  	};
>  
