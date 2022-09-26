Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C8BC5E9BFC
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 10:27:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234230AbiIZI1b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 04:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233925AbiIZI1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 04:27:23 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1134357D0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 01:27:21 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id z6so9018120wrq.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 01:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:references
         :reply-to:to:from:content-language:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date;
        bh=1FzC/KNdrXxWp0VFBF8PMU+TDBa3nqCtrnMOBp5/HlM=;
        b=LCKAcmmonOCcIEaBkLY8BA33UXtQ5mXXL7SQtw7nYG8Wu15EEusUT8F4tXZMcNZDIH
         elmT+oTY2Mbf7z9JgRvG+V3+3rtmOPySYrjxrwfkxKr/UJBMIPPj8uGUAynMuNRT8+mj
         ubXUNU/NC0RjB64a6vEG9UhL+p8pBWc+huciQ/qSY+Cz/vBpVrw410/s7ZD6rlQvbnEx
         lwAklGj7LoFiTMcKCCp1jYF8bIUSkfErxB13U2l8+JfsS7yHWQaLCh64DMrb+vcNZCtY
         oo+pqouZWqfDL8RxIYxMfsrehtRCMIMWthhFb7dNskLnpJPK5aC4TdrHjsdju8I7cfU3
         xuww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:references
         :reply-to:to:from:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=1FzC/KNdrXxWp0VFBF8PMU+TDBa3nqCtrnMOBp5/HlM=;
        b=PE+8YfIrDekhNcfv0abs/zpziBd6B+aQzSrZS9oJbfBm6PqQwJVkx0kcWpshs4CQmv
         HJ3lnYXPeMdfd8TUMUEArHnBEwfsB6HaG05Ahc5ED5+ATLKySYbu+Phl6z1ZqifWSvtL
         f6DlXH3vhm7Rh3I35qhXjN8Du7eeU3BkN3wUA3T47GMTCajBDlsdHH7YrQFZver7lggI
         X4jWzlvfyTbDGQNjmDO8YnO6AJJ6h/4EeKKOIjqfBtVKVGnTNvWotLbl+xRFwjL4oWcL
         5gT0kH8AQzRBdaXy5zGt6dnQ61kpNR4q6YW2zkeMuOERNy0Hh1EOFdlAnCn4gZiD5why
         HeBA==
X-Gm-Message-State: ACrzQf2f6w+BsSG9M0dl2Hf3KZkHsHU2k4WXOiq2dSDvYDUo+0vFSP8Y
        cFjCIyisHf42qj2nnM1zQ8ZC6Q==
X-Google-Smtp-Source: AMsMyM5btoUAC3X7QY4PGxtiolfV5SnAnM1lDZzcPB7Gs7jeB7ywXY5fq4Ejo5g/h197opsp2fZwqg==
X-Received: by 2002:a05:6000:154a:b0:22a:b8eb:ba53 with SMTP id 10-20020a056000154a00b0022ab8ebba53mr12513255wry.594.1664180840326;
        Mon, 26 Sep 2022 01:27:20 -0700 (PDT)
Received: from [192.168.27.65] (home.beaume.starnux.net. [82.66.176.246])
        by smtp.gmail.com with ESMTPSA id k18-20020a05600c1c9200b003b47ff307e1sm10791533wms.31.2022.09.26.01.27.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Sep 2022 01:27:19 -0700 (PDT)
Message-ID: <0e33106d-0def-4145-99e8-fe38f1618959@linaro.org>
Date:   Mon, 26 Sep 2022 10:27:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] pinctrl: qcom: restrict drivers per ARM/ARM64
Content-Language: en-US
From:   Neil Armstrong <neil.armstrong@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Reply-To: neil.armstrong@linaro.org, neil.armstrong@linaro.org
References: <20220925091908.34836-1-krzysztof.kozlowski@linaro.org>
 <effa3125-3690-b4ab-066b-d4e37326c148@linaro.org>
Organization: Linaro Developer Services
In-Reply-To: <effa3125-3690-b4ab-066b-d4e37326c148@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/09/2022 10:14, Neil Armstrong wrote:
> On 25/09/2022 11:19, Krzysztof Kozlowski wrote:
>> There is no point to allow selecting pin-controller drivers for Qualcomm
>> ARMv7 SoCs when building ARM64 kernel, and vice versa.  This makes
>> kernel configuration more difficult as many do not remember the Qualcomm
>> SoCs.  There won't be a single image for ARMv7 and ARMv8/9 SoCs, so no
>> features/options are lost.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
>>   drivers/pinctrl/qcom/Kconfig | 38 ++++++++++++++++++++++++++++++++++++
>>   1 file changed, 38 insertions(+)
>>
>> diff --git a/drivers/pinctrl/qcom/Kconfig b/drivers/pinctrl/qcom/Kconfig
>> index 2961b5eb8e10..bb1b4dd440d0 100644
>> --- a/drivers/pinctrl/qcom/Kconfig
>> +++ b/drivers/pinctrl/qcom/Kconfig
>> @@ -15,6 +15,7 @@ config PINCTRL_MSM
>>   config PINCTRL_APQ8064
>>       tristate "Qualcomm APQ8064 pin controller driver"
>>       depends on OF
>> +    depends on ARM || COMPILE_TEST
>>       depends on PINCTRL_MSM
>>       help
>>         This is the pinctrl, pinmux, pinconf and gpiolib driver for the
>> @@ -23,6 +24,7 @@ config PINCTRL_APQ8064
>>   config PINCTRL_APQ8084
>>       tristate "Qualcomm APQ8084 pin controller driver"
>>       depends on OF
>> +    depends on ARM || COMPILE_TEST
>>       depends on PINCTRL_MSM
>>       help
>>         This is the pinctrl, pinmux, pinconf and gpiolib driver for the
>> @@ -31,6 +33,7 @@ config PINCTRL_APQ8084
>>   config PINCTRL_IPQ4019
>>       tristate "Qualcomm IPQ4019 pin controller driver"
>>       depends on OF
>> +    depends on ARM || COMPILE_TEST
>>       depends on PINCTRL_MSM
>>       help
>>         This is the pinctrl, pinmux, pinconf and gpiolib driver for the
>> @@ -39,6 +42,7 @@ config PINCTRL_IPQ4019
>>   config PINCTRL_IPQ8064
>>       tristate "Qualcomm IPQ8064 pin controller driver"
>>       depends on OF
>> +    depends on ARM || COMPILE_TEST
>>       depends on PINCTRL_MSM
>>       help
>>         This is the pinctrl, pinmux, pinconf and gpiolib driver for the
>> @@ -47,6 +51,7 @@ config PINCTRL_IPQ8064
>>   config PINCTRL_IPQ8074
>>       tristate "Qualcomm Technologies, Inc. IPQ8074 pin controller driver"
>>       depends on OF
>> +    depends on ARM64 || COMPILE_TEST
>>       depends on PINCTRL_MSM
>>       help
>>         This is the pinctrl, pinmux, pinconf and gpiolib driver for
>> @@ -57,6 +62,7 @@ config PINCTRL_IPQ8074
>>   config PINCTRL_IPQ6018
>>       tristate "Qualcomm Technologies, Inc. IPQ6018 pin controller driver"
>>       depends on OF
>> +    depends on ARM64 || COMPILE_TEST
>>       depends on PINCTRL_MSM
>>       help
>>         This is the pinctrl, pinmux, pinconf and gpiolib driver for
>> @@ -67,6 +73,7 @@ config PINCTRL_IPQ6018
>>   config PINCTRL_MSM8226
>>       tristate "Qualcomm 8226 pin controller driver"
>>       depends on OF
>> +    depends on ARM || COMPILE_TEST
>>       depends on PINCTRL_MSM
>>       help
>>         This is the pinctrl, pinmux, pinconf and gpiolib driver for the
>> @@ -76,6 +83,7 @@ config PINCTRL_MSM8226
>>   config PINCTRL_MSM8660
>>       tristate "Qualcomm 8660 pin controller driver"
>>       depends on OF
>> +    depends on ARM || COMPILE_TEST
>>       depends on PINCTRL_MSM
>>       help
>>         This is the pinctrl, pinmux, pinconf and gpiolib driver for the
>> @@ -84,6 +92,7 @@ config PINCTRL_MSM8660
>>   config PINCTRL_MSM8960
>>       tristate "Qualcomm 8960 pin controller driver"
>>       depends on OF
>> +    depends on ARM || COMPILE_TEST
>>       depends on PINCTRL_MSM
>>       help
>>         This is the pinctrl, pinmux, pinconf and gpiolib driver for the
>> @@ -100,6 +109,7 @@ config PINCTRL_MDM9607
>>   config PINCTRL_MDM9615
>>       tristate "Qualcomm 9615 pin controller driver"
>>       depends on OF
>> +    depends on ARM || COMPILE_TEST
>>       depends on PINCTRL_MSM
>>       help
>>         This is the pinctrl, pinmux, pinconf and gpiolib driver for the
>> @@ -108,6 +118,7 @@ config PINCTRL_MDM9615
>>   config PINCTRL_MSM8X74
>>       tristate "Qualcomm 8x74 pin controller driver"
>>       depends on OF
>> +    depends on ARM || COMPILE_TEST
>>       depends on PINCTRL_MSM
>>       help
>>         This is the pinctrl, pinmux, pinconf and gpiolib driver for the
>> @@ -116,6 +127,7 @@ config PINCTRL_MSM8X74
>>   config PINCTRL_MSM8909
>>       tristate "Qualcomm 8909 pin controller driver"
>>       depends on OF
>> +    depends on ARM || COMPILE_TEST
>>       depends on PINCTRL_MSM
>>       help
>>         This is the pinctrl, pinmux, pinconf and gpiolib driver for the
>> @@ -132,6 +144,7 @@ config PINCTRL_MSM8916
>>   config PINCTRL_MSM8953
>>       tristate "Qualcomm 8953 pin controller driver"
>>       depends on OF
>> +    depends on ARM64 || COMPILE_TEST
>>       depends on PINCTRL_MSM
>>       help
>>         This is the pinctrl, pinmux, pinconf and gpiolib driver for the
>> @@ -152,6 +165,7 @@ config PINCTRL_MSM8976
>>   config PINCTRL_MSM8994
>>       tristate "Qualcomm 8994 pin controller driver"
>>       depends on OF
>> +    depends on ARM64 || COMPILE_TEST
>>       depends on PINCTRL_MSM
>>       help
>>         This is the pinctrl, pinmux, pinconf and gpiolib driver for the
>> @@ -161,6 +175,7 @@ config PINCTRL_MSM8994
>>   config PINCTRL_MSM8996
>>       tristate "Qualcomm MSM8996 pin controller driver"
>>       depends on OF
>> +    depends on ARM64 || COMPILE_TEST
>>       depends on PINCTRL_MSM
>>       help
>>         This is the pinctrl, pinmux, pinconf and gpiolib driver for the
>> @@ -169,6 +184,7 @@ config PINCTRL_MSM8996
>>   config PINCTRL_MSM8998
>>       tristate "Qualcomm MSM8998 pin controller driver"
>>       depends on OF
>> +    depends on ARM64 || COMPILE_TEST
>>       depends on PINCTRL_MSM
>>       help
>>         This is the pinctrl, pinmux, pinconf and gpiolib driver for the
>> @@ -177,6 +193,7 @@ config PINCTRL_MSM8998
>>   config PINCTRL_QCM2290
>>       tristate "Qualcomm QCM2290 pin controller driver"
>>       depends on OF
>> +    depends on ARM64 || COMPILE_TEST
>>       depends on PINCTRL_MSM
>>       help
>>         This is the pinctrl, pinmux, pinconf and gpiolib driver for the
>> @@ -185,6 +202,7 @@ config PINCTRL_QCM2290
>>   config PINCTRL_QCS404
>>       tristate "Qualcomm QCS404 pin controller driver"
>>       depends on OF
>> +    depends on ARM64 || COMPILE_TEST
>>       depends on PINCTRL_MSM
>>       help
>>         This is the pinctrl, pinmux, pinconf and gpiolib driver for the
>> @@ -232,6 +250,7 @@ config PINCTRL_QCOM_SSBI_PMIC
>>   config PINCTRL_SC7180
>>       tristate "Qualcomm Technologies Inc SC7180 pin controller driver"
>>       depends on OF
>> +    depends on ARM64 || COMPILE_TEST
>>       depends on PINCTRL_MSM
>>       help
>>         This is the pinctrl, pinmux, pinconf and gpiolib driver for the
>> @@ -241,6 +260,7 @@ config PINCTRL_SC7180
>>   config PINCTRL_SC7280
>>       tristate "Qualcomm Technologies Inc SC7280 pin controller driver"
>>       depends on OF
>> +    depends on ARM64 || COMPILE_TEST
>>       depends on PINCTRL_MSM
>>       help
>>         This is the pinctrl, pinmux, pinconf and gpiolib driver for the
>> @@ -250,6 +270,7 @@ config PINCTRL_SC7280
>>   config PINCTRL_SC7280_LPASS_LPI
>>       tristate "Qualcomm Technologies Inc SC7280 LPASS LPI pin controller driver"
>>       depends on GPIOLIB
>> +    depends on ARM64 || COMPILE_TEST
>>       depends on PINCTRL_LPASS_LPI
>>       help
>>         This is the pinctrl, pinmux, pinconf and gpiolib driver for the
>> @@ -259,6 +280,7 @@ config PINCTRL_SC7280_LPASS_LPI
>>   config PINCTRL_SC8180X
>>       tristate "Qualcomm Technologies Inc SC8180x pin controller driver"
>>       depends on (OF || ACPI)
>> +    depends on ARM64 || COMPILE_TEST
>>       depends on PINCTRL_MSM
>>       help
>>         This is the pinctrl, pinmux, pinconf and gpiolib driver for the
>> @@ -268,6 +290,7 @@ config PINCTRL_SC8180X
>>   config PINCTRL_SC8280XP
>>       tristate "Qualcomm Technologies Inc SC8280xp pin controller driver"
>>       depends on OF
>> +    depends on ARM64 || COMPILE_TEST
>>       depends on PINCTRL_MSM
>>       help
>>         This is the pinctrl, pinmux, pinconf and gpiolib driver for the
>> @@ -277,6 +300,7 @@ config PINCTRL_SC8280XP
>>   config PINCTRL_SDM660
>>       tristate "Qualcomm Technologies Inc SDM660 pin controller driver"
>>       depends on OF
>> +    depends on ARM64 || COMPILE_TEST
>>       depends on PINCTRL_MSM
>>       help
>>        This is the pinctrl, pinmux, pinconf and gpiolib driver for the
>> @@ -286,6 +310,7 @@ config PINCTRL_SDM660
>>   config PINCTRL_SDM845
>>       tristate "Qualcomm Technologies Inc SDM845 pin controller driver"
>>       depends on (OF || ACPI)
>> +    depends on ARM64 || COMPILE_TEST
>>       depends on PINCTRL_MSM
>>       help
>>        This is the pinctrl, pinmux, pinconf and gpiolib driver for the
>> @@ -295,6 +320,7 @@ config PINCTRL_SDM845
>>   config PINCTRL_SDX55
>>       tristate "Qualcomm Technologies Inc SDX55 pin controller driver"
>>       depends on OF
>> +    depends on ARM || COMPILE_TEST
>>       depends on PINCTRL_MSM
>>       help
>>        This is the pinctrl, pinmux, pinconf and gpiolib driver for the
>> @@ -304,6 +330,7 @@ config PINCTRL_SDX55
>>   config PINCTRL_SM6115
>>       tristate "Qualcomm Technologies Inc SM6115,SM4250 pin controller driver"
>>       depends on GPIOLIB && OF
>> +    depends on ARM64 || COMPILE_TEST
>>       depends on PINCTRL_MSM
>>       help
>>        This is the pinctrl, pinmux, pinconf and gpiolib driver for the
>> @@ -313,6 +340,7 @@ config PINCTRL_SM6115
>>   config PINCTRL_SM6125
>>       tristate "Qualcomm Technologies Inc SM6125 pin controller driver"
>>       depends on OF
>> +    depends on ARM64 || COMPILE_TEST
>>       depends on PINCTRL_MSM
>>       help
>>        This is the pinctrl, pinmux, pinconf and gpiolib driver for the
>> @@ -322,6 +350,7 @@ config PINCTRL_SM6125
>>   config PINCTRL_SM6350
>>       tristate "Qualcomm Technologies Inc SM6350 pin controller driver"
>>       depends on GPIOLIB && OF
>> +    depends on ARM64 || COMPILE_TEST
>>       depends on PINCTRL_MSM
>>       help
>>        This is the pinctrl, pinmux, pinconf and gpiolib driver for the
>> @@ -331,6 +360,7 @@ config PINCTRL_SM6350
>>   config PINCTRL_SM6375
>>       tristate "Qualcomm Technologies Inc SM6375 pin controller driver"
>>       depends on GPIOLIB && OF
>> +    depends on ARM64 || COMPILE_TEST
>>       depends on PINCTRL_MSM
>>       help
>>        This is the pinctrl, pinmux, pinconf and gpiolib driver for the
>> @@ -340,6 +370,7 @@ config PINCTRL_SM6375
>>   config PINCTRL_SDX65
>>       tristate "Qualcomm Technologies Inc SDX65 pin controller driver"
>>       depends on GPIOLIB && OF
>> +    depends on ARM || COMPILE_TEST
>>       depends on PINCTRL_MSM
>>       help
>>        This is the pinctrl, pinmux, pinconf and gpiolib driver for the
>> @@ -349,6 +380,7 @@ config PINCTRL_SDX65
>>   config PINCTRL_SM8150
>>       tristate "Qualcomm Technologies Inc SM8150 pin controller driver"
>>       depends on OF
>> +    depends on ARM64 || COMPILE_TEST
>>       depends on PINCTRL_MSM
>>       help
>>        This is the pinctrl, pinmux, pinconf and gpiolib driver for the
>> @@ -358,6 +390,7 @@ config PINCTRL_SM8150
>>   config PINCTRL_SM8250
>>       tristate "Qualcomm Technologies Inc SM8250 pin controller driver"
>>       depends on OF
>> +    depends on ARM64 || COMPILE_TEST
>>       depends on PINCTRL_MSM
>>       help
>>         This is the pinctrl, pinmux, pinconf and gpiolib driver for the
>> @@ -367,6 +400,7 @@ config PINCTRL_SM8250
>>   config PINCTRL_SM8250_LPASS_LPI
>>       tristate "Qualcomm Technologies Inc SM8250 LPASS LPI pin controller driver"
>>       depends on GPIOLIB
>> +    depends on ARM64 || COMPILE_TEST
>>       depends on PINCTRL_LPASS_LPI
>>       help
>>         This is the pinctrl, pinmux, pinconf and gpiolib driver for the
>> @@ -375,6 +409,7 @@ config PINCTRL_SM8250_LPASS_LPI
>>   config PINCTRL_SM8350
>>       tristate "Qualcomm Technologies Inc SM8350 pin controller driver"
>> +    depends on ARM64 || COMPILE_TEST
>>       depends on PINCTRL_MSM
>>       help
>>         This is the pinctrl, pinmux, pinconf and gpiolib driver for the
>> @@ -384,6 +419,7 @@ config PINCTRL_SM8350
>>   config PINCTRL_SM8450
>>       tristate "Qualcomm Technologies Inc SM8450 pin controller driver"
>>       depends on GPIOLIB && OF
>> +    depends on ARM64 || COMPILE_TEST
>>       depends on PINCTRL_MSM
>>       help
>>         This is the pinctrl, pinmux, pinconf and gpiolib driver for the
>> @@ -393,6 +429,7 @@ config PINCTRL_SM8450
>>   config PINCTRL_SM8450_LPASS_LPI
>>       tristate "Qualcomm Technologies Inc SM8450 LPASS LPI pin controller driver"
>>       depends on GPIOLIB
>> +    depends on ARM64 || COMPILE_TEST
>>       depends on PINCTRL_LPASS_LPI
>>       help
>>         This is the pinctrl, pinmux, pinconf and gpiolib driver for the
>> @@ -402,6 +439,7 @@ config PINCTRL_SM8450_LPASS_LPI
>>   config PINCTRL_SC8280XP_LPASS_LPI
>>       tristate "Qualcomm Technologies Inc SC8280XP LPASS LPI pin controller driver"
>>       depends on GPIOLIB
>> +    depends on ARM64 || COMPILE_TEST
>>       depends on PINCTRL_LPASS_LPI
>>       help
>>         This is the pinctrl, pinmux, pinconf and gpiolib driver for the
> 
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Forget, didn't see the v2..

Neil
