Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22AE55E9BBD
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 10:14:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233240AbiIZIOV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 04:14:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiIZIOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 04:14:18 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDB9122B0A
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 01:14:14 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id t14so8912689wrx.8
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 01:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:reply-to:from
         :references:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=tNtJP8zipnj1ef+s9YICvjgBx1SjOdxJH6obm/r5bjE=;
        b=opxzaj2Q7LsAXGuaZckmOktf70B2CaAKv+pPLMoaHd9EriMSradiKPuQg8T99Qxrlz
         WHeOxPMQOtZ2ocgykV/3Z/IE8NI+qqe3bi/w4setrYYGg/PGmxRAh7fkEgnLYa4mJqxT
         UEaoA6tmsXoqrOHnSIothCjowgd72KJdvO34bsHJFfgpQmSw2R7c6W+u0xiqBSQQs9fs
         nYorJzMbX11UkIxvL5qoKtscq8nlu3MAwPms0KIKNERu/nZ0fz73BS598QKYUpwsqwGr
         KSy5PFw6WtZwIFasEk3ziT5sg2hzJIowBBzGUQYUmzEO6s9FKkR2T6kP3BxLRhs8ZKdq
         K5YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:reply-to:from
         :references:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=tNtJP8zipnj1ef+s9YICvjgBx1SjOdxJH6obm/r5bjE=;
        b=Px5GcFvHYQj1eXxC+Sxu7LDSTDOQmN2nA6s4IzCkwg/owrQal+F8u05eJGBACUcRAI
         nO8FnEaBf3P4L5l043a1vccBE6tfZf9nkl+9Y2gRACOYN9MTa3Ip82+SrGAgOWwuoC+V
         uimeZ8YjfvvfXnqpQAEQLevJ2Up74OcrayK0E5tn3vIix9susyRSKTTOLhrHIPeqoRSq
         icxrp61GTnt8rgHY5Z9n89OYWkz1bXkm52fEsnwDDgCMREjG2NXfMPjaOUV2CHV0KPc+
         AnG0GilzZV87JWXS263X5wGDkpENerGXJIAbqOeKkIz2mVBKuWkZ4f3pde9oKxVbVtnh
         /rag==
X-Gm-Message-State: ACrzQf0t7YSnjYWm3G7J3zwFpx8fOgWSRRw7563wjegaYK1FJx4+Fmrz
        oGF+CxzoH64o+NBCcyIecmA5/Q==
X-Google-Smtp-Source: AMsMyM7AYHOXQUan+wPwLzQpeFMcU4/07Am/60G6w50IaDa56z+9RnwI2lgUNgo8ScMAEoyFuRbiEg==
X-Received: by 2002:a05:6000:713:b0:22c:a1f0:5161 with SMTP id bs19-20020a056000071300b0022ca1f05161mr3205008wrb.104.1664180053422;
        Mon, 26 Sep 2022 01:14:13 -0700 (PDT)
Received: from [192.168.27.65] (home.beaume.starnux.net. [82.66.176.246])
        by smtp.gmail.com with ESMTPSA id w10-20020a05600c474a00b003b4ac05a8a4sm12775102wmo.27.2022.09.26.01.14.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Sep 2022 01:14:12 -0700 (PDT)
Message-ID: <effa3125-3690-b4ab-066b-d4e37326c148@linaro.org>
Date:   Mon, 26 Sep 2022 10:14:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] pinctrl: qcom: restrict drivers per ARM/ARM64
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220925091908.34836-1-krzysztof.kozlowski@linaro.org>
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Organization: Linaro Developer Services
In-Reply-To: <20220925091908.34836-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/09/2022 11:19, Krzysztof Kozlowski wrote:
> There is no point to allow selecting pin-controller drivers for Qualcomm
> ARMv7 SoCs when building ARM64 kernel, and vice versa.  This makes
> kernel configuration more difficult as many do not remember the Qualcomm
> SoCs.  There won't be a single image for ARMv7 and ARMv8/9 SoCs, so no
> features/options are lost.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>   drivers/pinctrl/qcom/Kconfig | 38 ++++++++++++++++++++++++++++++++++++
>   1 file changed, 38 insertions(+)
> 
> diff --git a/drivers/pinctrl/qcom/Kconfig b/drivers/pinctrl/qcom/Kconfig
> index 2961b5eb8e10..bb1b4dd440d0 100644
> --- a/drivers/pinctrl/qcom/Kconfig
> +++ b/drivers/pinctrl/qcom/Kconfig
> @@ -15,6 +15,7 @@ config PINCTRL_MSM
>   config PINCTRL_APQ8064
>   	tristate "Qualcomm APQ8064 pin controller driver"
>   	depends on OF
> +	depends on ARM || COMPILE_TEST
>   	depends on PINCTRL_MSM
>   	help
>   	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
> @@ -23,6 +24,7 @@ config PINCTRL_APQ8064
>   config PINCTRL_APQ8084
>   	tristate "Qualcomm APQ8084 pin controller driver"
>   	depends on OF
> +	depends on ARM || COMPILE_TEST
>   	depends on PINCTRL_MSM
>   	help
>   	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
> @@ -31,6 +33,7 @@ config PINCTRL_APQ8084
>   config PINCTRL_IPQ4019
>   	tristate "Qualcomm IPQ4019 pin controller driver"
>   	depends on OF
> +	depends on ARM || COMPILE_TEST
>   	depends on PINCTRL_MSM
>   	help
>   	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
> @@ -39,6 +42,7 @@ config PINCTRL_IPQ4019
>   config PINCTRL_IPQ8064
>   	tristate "Qualcomm IPQ8064 pin controller driver"
>   	depends on OF
> +	depends on ARM || COMPILE_TEST
>   	depends on PINCTRL_MSM
>   	help
>   	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
> @@ -47,6 +51,7 @@ config PINCTRL_IPQ8064
>   config PINCTRL_IPQ8074
>   	tristate "Qualcomm Technologies, Inc. IPQ8074 pin controller driver"
>   	depends on OF
> +	depends on ARM64 || COMPILE_TEST
>   	depends on PINCTRL_MSM
>   	help
>   	  This is the pinctrl, pinmux, pinconf and gpiolib driver for
> @@ -57,6 +62,7 @@ config PINCTRL_IPQ8074
>   config PINCTRL_IPQ6018
>   	tristate "Qualcomm Technologies, Inc. IPQ6018 pin controller driver"
>   	depends on OF
> +	depends on ARM64 || COMPILE_TEST
>   	depends on PINCTRL_MSM
>   	help
>   	  This is the pinctrl, pinmux, pinconf and gpiolib driver for
> @@ -67,6 +73,7 @@ config PINCTRL_IPQ6018
>   config PINCTRL_MSM8226
>   	tristate "Qualcomm 8226 pin controller driver"
>   	depends on OF
> +	depends on ARM || COMPILE_TEST
>   	depends on PINCTRL_MSM
>   	help
>   	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
> @@ -76,6 +83,7 @@ config PINCTRL_MSM8226
>   config PINCTRL_MSM8660
>   	tristate "Qualcomm 8660 pin controller driver"
>   	depends on OF
> +	depends on ARM || COMPILE_TEST
>   	depends on PINCTRL_MSM
>   	help
>   	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
> @@ -84,6 +92,7 @@ config PINCTRL_MSM8660
>   config PINCTRL_MSM8960
>   	tristate "Qualcomm 8960 pin controller driver"
>   	depends on OF
> +	depends on ARM || COMPILE_TEST
>   	depends on PINCTRL_MSM
>   	help
>   	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
> @@ -100,6 +109,7 @@ config PINCTRL_MDM9607
>   config PINCTRL_MDM9615
>   	tristate "Qualcomm 9615 pin controller driver"
>   	depends on OF
> +	depends on ARM || COMPILE_TEST
>   	depends on PINCTRL_MSM
>   	help
>   	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
> @@ -108,6 +118,7 @@ config PINCTRL_MDM9615
>   config PINCTRL_MSM8X74
>   	tristate "Qualcomm 8x74 pin controller driver"
>   	depends on OF
> +	depends on ARM || COMPILE_TEST
>   	depends on PINCTRL_MSM
>   	help
>   	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
> @@ -116,6 +127,7 @@ config PINCTRL_MSM8X74
>   config PINCTRL_MSM8909
>   	tristate "Qualcomm 8909 pin controller driver"
>   	depends on OF
> +	depends on ARM || COMPILE_TEST
>   	depends on PINCTRL_MSM
>   	help
>   	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
> @@ -132,6 +144,7 @@ config PINCTRL_MSM8916
>   config PINCTRL_MSM8953
>   	tristate "Qualcomm 8953 pin controller driver"
>   	depends on OF
> +	depends on ARM64 || COMPILE_TEST
>   	depends on PINCTRL_MSM
>   	help
>   	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
> @@ -152,6 +165,7 @@ config PINCTRL_MSM8976
>   config PINCTRL_MSM8994
>   	tristate "Qualcomm 8994 pin controller driver"
>   	depends on OF
> +	depends on ARM64 || COMPILE_TEST
>   	depends on PINCTRL_MSM
>   	help
>   	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
> @@ -161,6 +175,7 @@ config PINCTRL_MSM8994
>   config PINCTRL_MSM8996
>   	tristate "Qualcomm MSM8996 pin controller driver"
>   	depends on OF
> +	depends on ARM64 || COMPILE_TEST
>   	depends on PINCTRL_MSM
>   	help
>   	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
> @@ -169,6 +184,7 @@ config PINCTRL_MSM8996
>   config PINCTRL_MSM8998
>   	tristate "Qualcomm MSM8998 pin controller driver"
>   	depends on OF
> +	depends on ARM64 || COMPILE_TEST
>   	depends on PINCTRL_MSM
>   	help
>   	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
> @@ -177,6 +193,7 @@ config PINCTRL_MSM8998
>   config PINCTRL_QCM2290
>   	tristate "Qualcomm QCM2290 pin controller driver"
>   	depends on OF
> +	depends on ARM64 || COMPILE_TEST
>   	depends on PINCTRL_MSM
>   	help
>   	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
> @@ -185,6 +202,7 @@ config PINCTRL_QCM2290
>   config PINCTRL_QCS404
>   	tristate "Qualcomm QCS404 pin controller driver"
>   	depends on OF
> +	depends on ARM64 || COMPILE_TEST
>   	depends on PINCTRL_MSM
>   	help
>   	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
> @@ -232,6 +250,7 @@ config PINCTRL_QCOM_SSBI_PMIC
>   config PINCTRL_SC7180
>   	tristate "Qualcomm Technologies Inc SC7180 pin controller driver"
>   	depends on OF
> +	depends on ARM64 || COMPILE_TEST
>   	depends on PINCTRL_MSM
>   	help
>   	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
> @@ -241,6 +260,7 @@ config PINCTRL_SC7180
>   config PINCTRL_SC7280
>   	tristate "Qualcomm Technologies Inc SC7280 pin controller driver"
>   	depends on OF
> +	depends on ARM64 || COMPILE_TEST
>   	depends on PINCTRL_MSM
>   	help
>   	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
> @@ -250,6 +270,7 @@ config PINCTRL_SC7280
>   config PINCTRL_SC7280_LPASS_LPI
>   	tristate "Qualcomm Technologies Inc SC7280 LPASS LPI pin controller driver"
>   	depends on GPIOLIB
> +	depends on ARM64 || COMPILE_TEST
>   	depends on PINCTRL_LPASS_LPI
>   	help
>   	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
> @@ -259,6 +280,7 @@ config PINCTRL_SC7280_LPASS_LPI
>   config PINCTRL_SC8180X
>   	tristate "Qualcomm Technologies Inc SC8180x pin controller driver"
>   	depends on (OF || ACPI)
> +	depends on ARM64 || COMPILE_TEST
>   	depends on PINCTRL_MSM
>   	help
>   	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
> @@ -268,6 +290,7 @@ config PINCTRL_SC8180X
>   config PINCTRL_SC8280XP
>   	tristate "Qualcomm Technologies Inc SC8280xp pin controller driver"
>   	depends on OF
> +	depends on ARM64 || COMPILE_TEST
>   	depends on PINCTRL_MSM
>   	help
>   	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
> @@ -277,6 +300,7 @@ config PINCTRL_SC8280XP
>   config PINCTRL_SDM660
>   	tristate "Qualcomm Technologies Inc SDM660 pin controller driver"
>   	depends on OF
> +	depends on ARM64 || COMPILE_TEST
>   	depends on PINCTRL_MSM
>   	help
>   	 This is the pinctrl, pinmux, pinconf and gpiolib driver for the
> @@ -286,6 +310,7 @@ config PINCTRL_SDM660
>   config PINCTRL_SDM845
>   	tristate "Qualcomm Technologies Inc SDM845 pin controller driver"
>   	depends on (OF || ACPI)
> +	depends on ARM64 || COMPILE_TEST
>   	depends on PINCTRL_MSM
>   	help
>   	 This is the pinctrl, pinmux, pinconf and gpiolib driver for the
> @@ -295,6 +320,7 @@ config PINCTRL_SDM845
>   config PINCTRL_SDX55
>   	tristate "Qualcomm Technologies Inc SDX55 pin controller driver"
>   	depends on OF
> +	depends on ARM || COMPILE_TEST
>   	depends on PINCTRL_MSM
>   	help
>   	 This is the pinctrl, pinmux, pinconf and gpiolib driver for the
> @@ -304,6 +330,7 @@ config PINCTRL_SDX55
>   config PINCTRL_SM6115
>   	tristate "Qualcomm Technologies Inc SM6115,SM4250 pin controller driver"
>   	depends on GPIOLIB && OF
> +	depends on ARM64 || COMPILE_TEST
>   	depends on PINCTRL_MSM
>   	help
>   	 This is the pinctrl, pinmux, pinconf and gpiolib driver for the
> @@ -313,6 +340,7 @@ config PINCTRL_SM6115
>   config PINCTRL_SM6125
>   	tristate "Qualcomm Technologies Inc SM6125 pin controller driver"
>   	depends on OF
> +	depends on ARM64 || COMPILE_TEST
>   	depends on PINCTRL_MSM
>   	help
>   	 This is the pinctrl, pinmux, pinconf and gpiolib driver for the
> @@ -322,6 +350,7 @@ config PINCTRL_SM6125
>   config PINCTRL_SM6350
>   	tristate "Qualcomm Technologies Inc SM6350 pin controller driver"
>   	depends on GPIOLIB && OF
> +	depends on ARM64 || COMPILE_TEST
>   	depends on PINCTRL_MSM
>   	help
>   	 This is the pinctrl, pinmux, pinconf and gpiolib driver for the
> @@ -331,6 +360,7 @@ config PINCTRL_SM6350
>   config PINCTRL_SM6375
>   	tristate "Qualcomm Technologies Inc SM6375 pin controller driver"
>   	depends on GPIOLIB && OF
> +	depends on ARM64 || COMPILE_TEST
>   	depends on PINCTRL_MSM
>   	help
>   	 This is the pinctrl, pinmux, pinconf and gpiolib driver for the
> @@ -340,6 +370,7 @@ config PINCTRL_SM6375
>   config PINCTRL_SDX65
>   	tristate "Qualcomm Technologies Inc SDX65 pin controller driver"
>   	depends on GPIOLIB && OF
> +	depends on ARM || COMPILE_TEST
>   	depends on PINCTRL_MSM
>   	help
>   	 This is the pinctrl, pinmux, pinconf and gpiolib driver for the
> @@ -349,6 +380,7 @@ config PINCTRL_SDX65
>   config PINCTRL_SM8150
>   	tristate "Qualcomm Technologies Inc SM8150 pin controller driver"
>   	depends on OF
> +	depends on ARM64 || COMPILE_TEST
>   	depends on PINCTRL_MSM
>   	help
>   	 This is the pinctrl, pinmux, pinconf and gpiolib driver for the
> @@ -358,6 +390,7 @@ config PINCTRL_SM8150
>   config PINCTRL_SM8250
>   	tristate "Qualcomm Technologies Inc SM8250 pin controller driver"
>   	depends on OF
> +	depends on ARM64 || COMPILE_TEST
>   	depends on PINCTRL_MSM
>   	help
>   	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
> @@ -367,6 +400,7 @@ config PINCTRL_SM8250
>   config PINCTRL_SM8250_LPASS_LPI
>   	tristate "Qualcomm Technologies Inc SM8250 LPASS LPI pin controller driver"
>   	depends on GPIOLIB
> +	depends on ARM64 || COMPILE_TEST
>   	depends on PINCTRL_LPASS_LPI
>   	help
>   	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
> @@ -375,6 +409,7 @@ config PINCTRL_SM8250_LPASS_LPI
>   
>   config PINCTRL_SM8350
>   	tristate "Qualcomm Technologies Inc SM8350 pin controller driver"
> +	depends on ARM64 || COMPILE_TEST
>   	depends on PINCTRL_MSM
>   	help
>   	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
> @@ -384,6 +419,7 @@ config PINCTRL_SM8350
>   config PINCTRL_SM8450
>   	tristate "Qualcomm Technologies Inc SM8450 pin controller driver"
>   	depends on GPIOLIB && OF
> +	depends on ARM64 || COMPILE_TEST
>   	depends on PINCTRL_MSM
>   	help
>   	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
> @@ -393,6 +429,7 @@ config PINCTRL_SM8450
>   config PINCTRL_SM8450_LPASS_LPI
>   	tristate "Qualcomm Technologies Inc SM8450 LPASS LPI pin controller driver"
>   	depends on GPIOLIB
> +	depends on ARM64 || COMPILE_TEST
>   	depends on PINCTRL_LPASS_LPI
>   	help
>   	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
> @@ -402,6 +439,7 @@ config PINCTRL_SM8450_LPASS_LPI
>   config PINCTRL_SC8280XP_LPASS_LPI
>   	tristate "Qualcomm Technologies Inc SC8280XP LPASS LPI pin controller driver"
>   	depends on GPIOLIB
> +	depends on ARM64 || COMPILE_TEST
>   	depends on PINCTRL_LPASS_LPI
>   	help
>   	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
