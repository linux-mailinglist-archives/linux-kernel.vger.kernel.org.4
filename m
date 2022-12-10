Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61C44648EB2
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Dec 2022 13:33:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbiLJMdm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Dec 2022 07:33:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbiLJMdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Dec 2022 07:33:40 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80FE01403E
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 04:33:38 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id c1so11147536lfi.7
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 04:33:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j54S5Em5+8fuXtAhZt+VBjnKSV0CzJD1XR4mN9x18UM=;
        b=u0c26ti67BTJLnOKzoiTFRBdFQ70JeRXVorvxrjfQL0/JT91RIxF7ge9BKWwf+jKZh
         /PRGuba3uldElOiRWMNaGjLHFiNeM57AR0EE+INZUOyhrocLl6bfYotaxx2Grg3polYG
         XRgeLQwKr3lUa3pQA8lb5JHbA+qq/yQHrHSzuBnceI0f9HGCXaGXqM3ifgG33Tj5KGz8
         ZxRigeAZSkhboqUgKwcGklGaflHn7j3UtcQfOZf8KT9FFn9cu8fLrnxJS5zt19efClSJ
         iYnDt4tpPlepejmc8av5INjjxgdSoAwULAP6NCysrjaycpumb1rvgQmEwsHSVCH6sjuQ
         pKtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j54S5Em5+8fuXtAhZt+VBjnKSV0CzJD1XR4mN9x18UM=;
        b=61AAjPnRmVeZVhQcQ8acjGgX11mowKBuzscaaH9zqfbppyJz7/jflIWqw9g0TcKE9T
         Z7QqzzXIkxshlkbcG8GYQM7NzyAu1tlQfCq/hFD34uZGu9EDD17DKN7Q21Tt6muY4zad
         4bscrJSjBbYVcV99yhZQNeRoAbB1PcHYZabUyeRdE+r+8HiD9PyTdNJwC0si8UAetffB
         tf38DJ2q5II3tsJxRJExNdFryNfRyUpal+2mITUtuu+RzddoWTS3yFktRJJfPf24P+/8
         qEx41fWy9eh/N/+oGaA6/WVcbC2RB33mwzDoyoOwA/yw6BBW8Bp9ACEM1VK1FNSWKNeS
         eFTw==
X-Gm-Message-State: ANoB5pnMeQSkPFgCrg0QdDgx/V0zpDDnoyp7IzcBJvVCvA4F1XIU7l4x
        nKRSbO/MWiaRr3jvf6kGMaDU5Q==
X-Google-Smtp-Source: AA0mqf5sTbXNIj4peDSXi1jFPi5ColXFTS69QqfLw5bBrS1dWKTI+x0SjojBJPRrOC0eTZuccH4PKQ==
X-Received: by 2002:a05:6512:2007:b0:4b5:650b:ba3f with SMTP id a7-20020a056512200700b004b5650bba3fmr2516614lfb.12.1670675616841;
        Sat, 10 Dec 2022 04:33:36 -0800 (PST)
Received: from [192.168.1.101] (abxh44.neoplus.adsl.tpnet.pl. [83.9.1.44])
        by smtp.gmail.com with ESMTPSA id c6-20020a056512324600b00492e3a8366esm708109lfr.9.2022.12.10.04.33.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Dec 2022 04:33:36 -0800 (PST)
Message-ID: <68796aa4-2dc5-d4a3-a104-1587b8589a81@linaro.org>
Date:   Sat, 10 Dec 2022 13:33:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 3/3] arm64: dts: qcom: sm7225-fairphone-fp4: configure
 flash LED
Content-Language: en-US
To:     Luca Weiss <luca.weiss@fairphone.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Fenglin Wu <quic_fenglinw@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221209-fp4-pm6150l-flash-v1-0-531521eb2a72@fairphone.com>
 <20221209-fp4-pm6150l-flash-v1-3-531521eb2a72@fairphone.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221209-fp4-pm6150l-flash-v1-3-531521eb2a72@fairphone.com>
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



On 9.12.2022 14:54, Luca Weiss wrote:
> Configure the pm6150l flash node for the dual flash LEDs found on FP4.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts b/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts
> index c456e9594ea5..fef7d1d02925 100644
> --- a/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts
> +++ b/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts
> @@ -7,6 +7,7 @@
>  
>  #include <dt-bindings/gpio/gpio.h>
>  #include <dt-bindings/input/input.h>
> +#include <dt-bindings/leds/common.h>
>  #include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
>  #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
>  #include "sm7225.dtsi"
> @@ -367,6 +368,28 @@ &mpss {
>  	firmware-name = "qcom/sm7225/fairphone4/modem.mdt";
>  };
>  
> +&pm6150l_flash {
> +	status = "okay";
> +
> +	led-0 {
> +		function = LED_FUNCTION_FLASH;
> +		color = <LED_COLOR_ID_YELLOW>;
> +		led-sources = <1>;
> +		led-max-microamp = <180000>;
> +		flash-max-microamp = <1000000>;
> +		flash-max-timeout-us = <1280000>;
> +	};
> +
> +	led-1 {
> +		function = LED_FUNCTION_FLASH;
> +		color = <LED_COLOR_ID_WHITE>;
> +		led-sources = <2>;
> +		led-max-microamp = <180000>;
> +		flash-max-microamp = <1000000>;
> +		flash-max-timeout-us = <1280000>;
> +	};
> +};
> +
>  &pm6150l_wled {
>  	status = "okay";
>  
> 
