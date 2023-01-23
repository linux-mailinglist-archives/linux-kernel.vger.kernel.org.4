Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9016B677AF7
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 13:32:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbjAWMb6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 07:31:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230354AbjAWMbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 07:31:52 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EC1FCC34
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 04:31:49 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id tz11so30131898ejc.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 04:31:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JJ1/pJcCxB8jbsuhUneUtAwDk8DVvkVecST68quKwrk=;
        b=e2sdoB0UylfadEo4aEDHXtc7XPfYZBnjy0v4K9vji1vy6APxgKaMNT8zEKBUmJEKcE
         WENdfJ9n1GEkLosGZmW/ckz8f+llJLZdRQ+N5vhIAOz8NpTjq/qJADaznoliGIgwFiMp
         LN+Wovzo1YsWGSTWrbXGwSs0J+qilo1b7YFtIvWMDeUTEf7K7jbsmxKJQ/X+e7Gxj3HK
         YLYOS15KqqRJ0Zj937DvfLwyBigd7Q4WAUXC/ayDrE15g/Nqot75FOyvrMbDKrdRfD6G
         3cmP+6Fu+aZ6/I9WTJCZQUgUWImSU6eshThsZLfNCDj3V9yft0ayQjAAYAPrkOVWYmuc
         BfTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JJ1/pJcCxB8jbsuhUneUtAwDk8DVvkVecST68quKwrk=;
        b=b5azWlHVWLhrbWCEXTzx5u7D/DfvyvC7wBTerzrQnwreFer3o1SzjHUSjJhZi0wEeQ
         WM9lJDlIFv23hO0bgnXIrBxILmUYy5R+R9HxpfS689+SlaS+UI7Z16MNY3lQ3j9AjbDg
         bbyHl4DkSU0/HMW8chH20unZbYNRtPOCQHenp24nZS+6KoWd1Isyn4TP2/KhUprP3aiG
         rzvcFD3hYBDe3vngyi6e4OZ6PMTJP4p5XW0tTfHww6SQE6oLhQWmxNCuNpLXAS4maMZ5
         E63l3eY8zXTWVyIUPzyvKrE6k6zJNDmTyfrk2TsQ6MBcC3iJv3oVCUyK/d2BIFeE166m
         TIbw==
X-Gm-Message-State: AFqh2kqc8fIzD1WI487+m4u80yGC4VniA8vsl+8buSZFRhwfhjsi+WES
        /wadt+z4UusZ0T9bbcVIG9utsQ==
X-Google-Smtp-Source: AMrXdXuBJ/ACgEBv7F7i/mRontNtSa3ypvx6/wLCnVFLxQ5lfhqFxrIzZRUpGzGKUf3HOA27Pj1u7w==
X-Received: by 2002:a17:906:6601:b0:877:a9d2:e5e9 with SMTP id b1-20020a170906660100b00877a9d2e5e9mr8568511ejp.42.1674477107600;
        Mon, 23 Jan 2023 04:31:47 -0800 (PST)
Received: from [192.168.1.101] (abxi24.neoplus.adsl.tpnet.pl. [83.9.2.24])
        by smtp.gmail.com with ESMTPSA id 11-20020a170906300b00b008675df83251sm15092887ejz.34.2023.01.23.04.31.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jan 2023 04:31:47 -0800 (PST)
Message-ID: <9cbbb9c3-f645-0066-a505-35cc7ae087bc@linaro.org>
Date:   Mon, 23 Jan 2023 13:31:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH 2/2] clk: qcom: restrict drivers per ARM/ARM64
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230123094925.54824-1-krzysztof.kozlowski@linaro.org>
 <20230123094925.54824-2-krzysztof.kozlowski@linaro.org>
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230123094925.54824-2-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23.01.2023 10:49, Krzysztof Kozlowski wrote:
> There is no point to allow selecting pin-controller drivers for Qualcomm
> ARMv7 SoCs when building ARM64 kernel, and vice versa.  This makes
> kernel configuration more difficult as many do not remember the Qualcomm
> SoCs model names/numbers.  There won't be a single image for ARMv7 and
> ARMv8/9 SoCs, so no features/options are lost.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
Not sure about the newest of the newest SoCs with Cortex-X etc,
but older ones, particularly including 8916 (as some vendors
in their infinite wisdom decided that shipping a 32 bit tz is
a good idea) having ARM || ARM64 would make sense.

Konrad
>  drivers/clk/qcom/Kconfig | 88 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 88 insertions(+)
> 
> diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
> index 1c360eed72d7..3112ca762f4d 100644
> --- a/drivers/clk/qcom/Kconfig
> +++ b/drivers/clk/qcom/Kconfig
> @@ -57,6 +57,7 @@ config QCOM_CLK_APCC_MSM8996
>  config QCOM_CLK_APCS_SDX55
>  	tristate "SDX55 and SDX65 APCS Clock Controller"
>  	depends on QCOM_APCS_IPC || COMPILE_TEST
> +	depends on ARM || COMPILE_TEST
>  	help
>  	  Support for the APCS Clock Controller on SDX55, SDX65 platforms. The
>  	  APCS is managing the mux and divider which feeds the CPUs.
> @@ -100,6 +101,7 @@ config QCOM_CLK_RPMH
>  
>  config APQ_GCC_8084
>  	tristate "APQ8084 Global Clock Controller"
> +	depends on ARM || COMPILE_TEST
>  	select QCOM_GDSC
>  	help
>  	  Support for the global clock controller on apq8084 devices.
> @@ -108,6 +110,7 @@ config APQ_GCC_8084
>  
>  config APQ_MMCC_8084
>  	tristate "APQ8084 Multimedia Clock Controller"
> +	depends on ARM || COMPILE_TEST
>  	select APQ_GCC_8084
>  	select QCOM_GDSC
>  	help
> @@ -116,6 +119,7 @@ config APQ_MMCC_8084
>  	  graphics, video encode/decode, camera, etc.
>  
>  config IPQ_APSS_PLL
> +	depends on ARM64 || COMPILE_TEST
>  	tristate "IPQ APSS PLL"
>  	help
>  	  Support for APSS PLL on ipq devices. The APSS PLL is the main
> @@ -127,6 +131,7 @@ config IPQ_APSS_6018
>  	tristate "IPQ APSS Clock Controller"
>  	select IPQ_APSS_PLL
>  	depends on QCOM_APCS_IPC || COMPILE_TEST
> +	depends on ARM64 || COMPILE_TEST
>  	help
>  	  Support for APSS clock controller on IPQ platforms. The
>  	  APSS clock controller manages the Mux and enable block that feeds the
> @@ -143,6 +148,7 @@ config IPQ_GCC_4019
>  
>  config IPQ_GCC_6018
>  	tristate "IPQ6018 Global Clock Controller"
> +	depends on ARM64 || COMPILE_TEST
>  	help
>  	  Support for global clock controller on ipq6018 devices.
>  	  Say Y if you want to use peripheral devices such as UART, SPI,
> @@ -151,6 +157,7 @@ config IPQ_GCC_6018
>  
>  config IPQ_GCC_806X
>  	tristate "IPQ806x Global Clock Controller"
> +	depends on ARM || COMPILE_TEST
>  	help
>  	  Support for the global clock controller on ipq806x devices.
>  	  Say Y if you want to use peripheral devices such as UART, SPI,
> @@ -158,6 +165,7 @@ config IPQ_GCC_806X
>  
>  config IPQ_LCC_806X
>  	tristate "IPQ806x LPASS Clock Controller"
> +	depends on ARM || COMPILE_TEST
>  	select IPQ_GCC_806X
>  	help
>  	  Support for the LPASS clock controller on ipq806x devices.
> @@ -166,6 +174,7 @@ config IPQ_LCC_806X
>  
>  config IPQ_GCC_8074
>  	tristate "IPQ8074 Global Clock Controller"
> +	depends on ARM64 || COMPILE_TEST
>  	select QCOM_GDSC
>  	help
>  	  Support for global clock controller on ipq8074 devices.
> @@ -175,6 +184,7 @@ config IPQ_GCC_8074
>  
>  config MSM_GCC_8660
>  	tristate "MSM8660 Global Clock Controller"
> +	depends on ARM || COMPILE_TEST
>  	help
>  	  Support for the global clock controller on msm8660 devices.
>  	  Say Y if you want to use peripheral devices such as UART, SPI,
> @@ -182,6 +192,7 @@ config MSM_GCC_8660
>  
>  config MSM_GCC_8909
>  	tristate "MSM8909 Global Clock Controller"
> +	depends on ARM || COMPILE_TEST
>  	select QCOM_GDSC
>  	help
>  	  Support for the global clock controller on msm8909 devices.
> @@ -206,6 +217,7 @@ config MSM_GCC_8939
>  
>  config MSM_GCC_8960
>  	tristate "APQ8064/MSM8960 Global Clock Controller"
> +	depends on ARM || COMPILE_TEST
>  	help
>  	  Support for the global clock controller on apq8064/msm8960 devices.
>  	  Say Y if you want to use peripheral devices such as UART, SPI,
> @@ -213,6 +225,7 @@ config MSM_GCC_8960
>  
>  config MSM_LCC_8960
>  	tristate "APQ8064/MSM8960 LPASS Clock Controller"
> +	depends on ARM || COMPILE_TEST
>  	select MSM_GCC_8960
>  	help
>  	  Support for the LPASS clock controller on apq8064/msm8960 devices.
> @@ -221,6 +234,7 @@ config MSM_LCC_8960
>  
>  config MDM_GCC_9607
>  	tristate "MDM9607 Global Clock Controller"
> +	depends on ARM || COMPILE_TEST
>  	help
>  	  Support for the global clock controller on mdm9607 devices.
>  	  Say Y if you want to use peripheral devices such as UART, SPI,
> @@ -228,6 +242,7 @@ config MDM_GCC_9607
>  
>  config MDM_GCC_9615
>  	tristate "MDM9615 Global Clock Controller"
> +	depends on ARM || COMPILE_TEST
>  	help
>  	  Support for the global clock controller on mdm9615 devices.
>  	  Say Y if you want to use peripheral devices such as UART, SPI,
> @@ -235,6 +250,7 @@ config MDM_GCC_9615
>  
>  config MDM_LCC_9615
>  	tristate "MDM9615 LPASS Clock Controller"
> +	depends on ARM || COMPILE_TEST
>  	select MDM_GCC_9615
>  	help
>  	  Support for the LPASS clock controller on mdm9615 devices.
> @@ -243,6 +259,7 @@ config MDM_LCC_9615
>  
>  config MSM_MMCC_8960
>  	tristate "MSM8960 Multimedia Clock Controller"
> +	depends on ARM || COMPILE_TEST
>  	select MSM_GCC_8960
>  	help
>  	  Support for the multimedia clock controller on msm8960 devices.
> @@ -251,6 +268,7 @@ config MSM_MMCC_8960
>  
>  config MSM_GCC_8953
>  	tristate "MSM8953 Global Clock Controller"
> +	depends on ARM64 || COMPILE_TEST
>  	select QCOM_GDSC
>  	help
>  	  Support for the global clock controller on msm8953 devices.
> @@ -259,6 +277,7 @@ config MSM_GCC_8953
>  
>  config MSM_GCC_8974
>  	tristate "MSM8974 Global Clock Controller"
> +	depends on ARM || COMPILE_TEST
>  	select QCOM_GDSC
>  	help
>  	  Support for the global clock controller on msm8974 devices.
> @@ -267,6 +286,7 @@ config MSM_GCC_8974
>  
>  config MSM_MMCC_8974
>  	tristate "MSM8974 Multimedia Clock Controller"
> +	depends on ARM || COMPILE_TEST
>  	select MSM_GCC_8974
>  	select QCOM_GDSC
>  	help
> @@ -276,6 +296,7 @@ config MSM_MMCC_8974
>  
>  config MSM_GCC_8976
>  	tristate "MSM8956/76 Global Clock Controller"
> +	depends on ARM64 || COMPILE_TEST
>  	select QCOM_GDSC
>  	help
>  	  Support for the global clock controller on msm8956/76 devices.
> @@ -284,6 +305,7 @@ config MSM_GCC_8976
>  
>  config MSM_MMCC_8994
>  	tristate "MSM8994 Multimedia Clock Controller"
> +	depends on ARM64 || COMPILE_TEST
>  	select MSM_GCC_8994
>  	select QCOM_GDSC
>  	help
> @@ -293,6 +315,7 @@ config MSM_MMCC_8994
>  
>  config MSM_GCC_8994
>  	tristate "MSM8994 Global Clock Controller"
> +	depends on ARM64 || COMPILE_TEST
>  	help
>  	  Support for the global clock controller on msm8994 devices.
>  	  Say Y if you want to use peripheral devices such as UART, SPI,
> @@ -300,6 +323,7 @@ config MSM_GCC_8994
>  
>  config MSM_GCC_8996
>  	tristate "MSM8996 Global Clock Controller"
> +	depends on ARM64 || COMPILE_TEST
>  	select QCOM_GDSC
>  	help
>  	  Support for the global clock controller on msm8996 devices.
> @@ -308,6 +332,7 @@ config MSM_GCC_8996
>  
>  config MSM_MMCC_8996
>  	tristate "MSM8996 Multimedia Clock Controller"
> +	depends on ARM64 || COMPILE_TEST
>  	select MSM_GCC_8996
>  	select QCOM_GDSC
>  	help
> @@ -317,6 +342,7 @@ config MSM_MMCC_8996
>  
>  config MSM_GCC_8998
>  	tristate "MSM8998 Global Clock Controller"
> +	depends on ARM64 || COMPILE_TEST
>  	select QCOM_GDSC
>  	help
>  	  Support for the global clock controller on msm8998 devices.
> @@ -325,6 +351,7 @@ config MSM_GCC_8998
>  
>  config MSM_GPUCC_8998
>  	tristate "MSM8998 Graphics Clock Controller"
> +	depends on ARM64 || COMPILE_TEST
>  	select MSM_GCC_8998
>  	select QCOM_GDSC
>  	help
> @@ -334,6 +361,7 @@ config MSM_GPUCC_8998
>  
>  config MSM_MMCC_8998
>  	tristate "MSM8998 Multimedia Clock Controller"
> +	depends on ARM64 || COMPILE_TEST
>  	select MSM_GCC_8998
>  	select QCOM_GDSC
>  	help
> @@ -351,6 +379,7 @@ config QCM_GCC_2290
>  
>  config QCM_DISPCC_2290
>  	tristate "QCM2290 Display Clock Controller"
> +	depends on ARM64 || COMPILE_TEST
>  	select QCM_GCC_2290
>  	help
>  	  Support for the display clock controller on Qualcomm Technologies, Inc
> @@ -360,6 +389,7 @@ config QCM_DISPCC_2290
>  
>  config QCS_GCC_404
>  	tristate "QCS404 Global Clock Controller"
> +	depends on ARM64 || COMPILE_TEST
>  	help
>  	  Support for the global clock controller on QCS404 devices.
>  	  Say Y if you want to use multimedia devices or peripheral
> @@ -367,6 +397,7 @@ config QCS_GCC_404
>  
>  config SC_CAMCC_7180
>  	tristate "SC7180 Camera Clock Controller"
> +	depends on ARM64 || COMPILE_TEST
>  	select SC_GCC_7180
>  	help
>  	  Support for the camera clock controller on Qualcomm Technologies, Inc
> @@ -376,6 +407,7 @@ config SC_CAMCC_7180
>  
>  config SC_CAMCC_7280
>  	tristate "SC7280 Camera Clock Controller"
> +	depends on ARM64 || COMPILE_TEST
>  	select SC_GCC_7280
>  	help
>  	  Support for the camera clock controller on Qualcomm Technologies, Inc
> @@ -385,6 +417,7 @@ config SC_CAMCC_7280
>  
>  config SC_DISPCC_7180
>  	tristate "SC7180 Display Clock Controller"
> +	depends on ARM64 || COMPILE_TEST
>  	select SC_GCC_7180
>  	help
>  	  Support for the display clock controller on Qualcomm Technologies, Inc
> @@ -394,6 +427,7 @@ config SC_DISPCC_7180
>  
>  config SC_DISPCC_7280
>  	tristate "SC7280 Display Clock Controller"
> +	depends on ARM64 || COMPILE_TEST
>  	select SC_GCC_7280
>  	help
>  	  Support for the display clock controller on Qualcomm Technologies, Inc.
> @@ -403,6 +437,7 @@ config SC_DISPCC_7280
>  
>  config SC_DISPCC_8280XP
>  	tristate "SC8280XP Display Clock Controller"
> +	depends on ARM64 || COMPILE_TEST
>  	select SC_GCC_8280XP
>  	help
>  	  Support for the two display clock controllers on Qualcomm
> @@ -414,6 +449,7 @@ config SC_GCC_7180
>  	tristate "SC7180 Global Clock Controller"
>  	select QCOM_GDSC
>  	depends on COMMON_CLK_QCOM
> +	depends on ARM64 || COMPILE_TEST
>  	help
>  	  Support for the global clock controller on SC7180 devices.
>  	  Say Y if you want to use peripheral devices such as UART, SPI,
> @@ -423,6 +459,7 @@ config SC_GCC_7280
>  	tristate "SC7280 Global Clock Controller"
>  	select QCOM_GDSC
>  	depends on COMMON_CLK_QCOM
> +	depends on ARM64 || COMPILE_TEST
>  	help
>  	  Support for the global clock controller on SC7280 devices.
>  	  Say Y if you want to use peripheral devices such as UART, SPI,
> @@ -432,6 +469,7 @@ config SC_GCC_8180X
>  	tristate "SC8180X Global Clock Controller"
>  	select QCOM_GDSC
>  	depends on COMMON_CLK_QCOM
> +	depends on ARM64 || COMPILE_TEST
>  	help
>  	  Support for the global clock controller on SC8180X devices.
>  	  Say Y if you want to use peripheral devices such as UART, SPI,
> @@ -441,6 +479,7 @@ config SC_GCC_8280XP
>  	tristate "SC8280XP Global Clock Controller"
>  	select QCOM_GDSC
>  	depends on COMMON_CLK_QCOM
> +	depends on ARM64 || COMPILE_TEST
>  	help
>  	  Support for the global clock controller on SC8280XP devices.
>  	  Say Y if you want to use peripheral devices such as UART, SPI,
> @@ -448,6 +487,7 @@ config SC_GCC_8280XP
>  
>  config SC_GPUCC_7180
>  	tristate "SC7180 Graphics Clock Controller"
> +	depends on ARM64 || COMPILE_TEST
>  	select SC_GCC_7180
>  	help
>  	  Support for the graphics clock controller on SC7180 devices.
> @@ -456,6 +496,7 @@ config SC_GPUCC_7180
>  
>  config SC_GPUCC_7280
>  	tristate "SC7280 Graphics Clock Controller"
> +	depends on ARM64 || COMPILE_TEST
>  	select SC_GCC_7280
>  	help
>  	  Support for the graphics clock controller on SC7280 devices.
> @@ -464,6 +505,7 @@ config SC_GPUCC_7280
>  
>  config SC_GPUCC_8280XP
>  	tristate "SC8280XP Graphics Clock Controller"
> +	depends on ARM64 || COMPILE_TEST
>  	select SC_GCC_8280XP
>  	help
>  	  Support for the graphics clock controller on SC8280XP devices.
> @@ -472,6 +514,7 @@ config SC_GPUCC_8280XP
>  
>  config SC_LPASSCC_7280
>  	tristate "SC7280 Low Power Audio Subsystem (LPASS) Clock Controller"
> +	depends on ARM64 || COMPILE_TEST
>  	select SC_GCC_7280
>  	help
>  	  Support for the LPASS clock controller on SC7280 devices.
> @@ -480,6 +523,7 @@ config SC_LPASSCC_7280
>  
>  config SC_LPASS_CORECC_7180
>  	tristate "SC7180 LPASS Core Clock Controller"
> +	depends on ARM64 || COMPILE_TEST
>  	select SC_GCC_7180
>  	help
>  	  Support for the LPASS(Low Power Audio Subsystem) core clock controller
> @@ -489,6 +533,7 @@ config SC_LPASS_CORECC_7180
>  
>  config SC_LPASS_CORECC_7280
>  	tristate "SC7280 LPASS Core & Audio Clock Controller"
> +	depends on ARM64 || COMPILE_TEST
>  	select SC_GCC_7280
>  	select QCOM_GDSC
>  	help
> @@ -499,6 +544,7 @@ config SC_LPASS_CORECC_7280
>  
>  config SC_MSS_7180
>  	tristate "SC7180 Modem Clock Controller"
> +	depends on ARM64 || COMPILE_TEST
>  	select SC_GCC_7180
>  	help
>  	  Support for the Modem Subsystem clock controller on Qualcomm
> @@ -508,6 +554,7 @@ config SC_MSS_7180
>  
>  config SC_VIDEOCC_7180
>  	tristate "SC7180 Video Clock Controller"
> +	depends on ARM64 || COMPILE_TEST
>  	select SC_GCC_7180
>  	help
>  	  Support for the video clock controller on SC7180 devices.
> @@ -516,6 +563,7 @@ config SC_VIDEOCC_7180
>  
>  config SC_VIDEOCC_7280
>  	tristate "SC7280 Video Clock Controller"
> +	depends on ARM64 || COMPILE_TEST
>  	select SC_GCC_7280
>  	help
>  	  Support for the video clock controller on SC7280 devices.
> @@ -524,6 +572,7 @@ config SC_VIDEOCC_7280
>  
>  config SDM_CAMCC_845
>  	tristate "SDM845 Camera Clock Controller"
> +	depends on ARM64 || COMPILE_TEST
>  	select SDM_GCC_845
>  	help
>  	  Support for the camera clock controller on SDM845 devices.
> @@ -531,6 +580,7 @@ config SDM_CAMCC_845
>  
>  config SDM_GCC_660
>  	tristate "SDM660 Global Clock Controller"
> +	depends on ARM64 || COMPILE_TEST
>  	select QCOM_GDSC
>  	help
>  	  Support for the global clock controller on SDM660 devices.
> @@ -539,6 +589,7 @@ config SDM_GCC_660
>  
>  config SDM_MMCC_660
>  	tristate "SDM660 Multimedia Clock Controller"
> +	depends on ARM64 || COMPILE_TEST
>  	select SDM_GCC_660
>  	select QCOM_GDSC
>  	help
> @@ -548,6 +599,7 @@ config SDM_MMCC_660
>  
>  config SDM_GPUCC_660
>  	tristate "SDM660 Graphics Clock Controller"
> +	depends on ARM64 || COMPILE_TEST
>  	select SDM_GCC_660
>  	select QCOM_GDSC
>  	help
> @@ -557,12 +609,14 @@ config SDM_GPUCC_660
>  
>  config QCS_TURING_404
>  	tristate "QCS404 Turing Clock Controller"
> +	depends on ARM64 || COMPILE_TEST
>  	help
>  	  Support for the Turing Clock Controller on QCS404, provides clocks
>  	  and resets for the Turing subsystem.
>  
>  config QCS_Q6SSTOP_404
>  	tristate "QCS404 Q6SSTOP Clock Controller"
> +	depends on ARM64 || COMPILE_TEST
>  	select QCS_GCC_404
>  	help
>  	  Support for the Q6SSTOP clock controller on QCS404 devices.
> @@ -571,6 +625,7 @@ config QCS_Q6SSTOP_404
>  
>  config SDM_GCC_845
>  	tristate "SDM845/SDM670 Global Clock Controller"
> +	depends on ARM64 || COMPILE_TEST
>  	select QCOM_GDSC
>  	help
>  	  Support for the global clock controller on SDM845 and SDM670 devices.
> @@ -579,6 +634,7 @@ config SDM_GCC_845
>  
>  config SDM_GPUCC_845
>  	tristate "SDM845 Graphics Clock Controller"
> +	depends on ARM64 || COMPILE_TEST
>  	select SDM_GCC_845
>  	help
>  	  Support for the graphics clock controller on SDM845 devices.
> @@ -587,6 +643,7 @@ config SDM_GPUCC_845
>  
>  config SDM_VIDEOCC_845
>  	tristate "SDM845 Video Clock Controller"
> +	depends on ARM64 || COMPILE_TEST
>  	select SDM_GCC_845
>  	select QCOM_GDSC
>  	help
> @@ -596,6 +653,7 @@ config SDM_VIDEOCC_845
>  
>  config SDM_DISPCC_845
>  	tristate "SDM845 Display Clock Controller"
> +	depends on ARM64 || COMPILE_TEST
>  	select SDM_GCC_845
>  	help
>  	  Support for the display clock controller on Qualcomm Technologies, Inc
> @@ -605,6 +663,7 @@ config SDM_DISPCC_845
>  
>  config SDM_LPASSCC_845
>  	tristate "SDM845 Low Power Audio Subsystem (LPAAS) Clock Controller"
> +	depends on ARM64 || COMPILE_TEST
>  	select SDM_GCC_845
>  	help
>  	  Support for the LPASS clock controller on SDM845 devices.
> @@ -613,6 +672,7 @@ config SDM_LPASSCC_845
>  
>  config SDX_GCC_55
>  	tristate "SDX55 Global Clock Controller"
> +	depends on ARM || COMPILE_TEST
>  	select QCOM_GDSC
>  	help
>  	  Support for the global clock controller on SDX55 devices.
> @@ -621,6 +681,7 @@ config SDX_GCC_55
>  
>  config SDX_GCC_65
>  	tristate "SDX65 Global Clock Controller"
> +	depends on ARM || COMPILE_TEST
>  	select QCOM_GDSC
>  	help
>  	  Support for the global clock controller on SDX65 devices.
> @@ -629,6 +690,7 @@ config SDX_GCC_65
>  
>  config SM_CAMCC_6350
>  	tristate "SM6350 Camera Clock Controller"
> +	depends on ARM64 || COMPILE_TEST
>  	select SM_GCC_6350
>  	help
>  	  Support for the camera clock controller on SM6350 devices.
> @@ -636,6 +698,7 @@ config SM_CAMCC_6350
>  
>  config SM_CAMCC_8250
>  	tristate "SM8250 Camera Clock Controller"
> +	depends on ARM64 || COMPILE_TEST
>  	select SM_GCC_8250
>  	help
>  	  Support for the camera clock controller on SM8250 devices.
> @@ -643,6 +706,7 @@ config SM_CAMCC_8250
>  
>  config SM_CAMCC_8450
>  	tristate "SM8450 Camera Clock Controller"
> +	depends on ARM64 || COMPILE_TEST
>  	select SM_GCC_8450
>  	help
>  	  Support for the camera clock controller on SM8450 devices.
> @@ -650,6 +714,7 @@ config SM_CAMCC_8450
>  
>  config SM_DISPCC_6115
>  	tristate "SM6115 Display Clock Controller"
> +	depends on ARM64 || COMPILE_TEST
>  	depends on SM_GCC_6115
>  	help
>  	  Support for the display clock controller on Qualcomm Technologies, Inc
> @@ -659,6 +724,7 @@ config SM_DISPCC_6115
>  
>  config SM_DISPCC_6125
>  	tristate "SM6125 Display Clock Controller"
> +	depends on ARM64 || COMPILE_TEST
>  	depends on SM_GCC_6125
>  	help
>  	  Support for the display clock controller on Qualcomm Technologies, Inc
> @@ -668,6 +734,7 @@ config SM_DISPCC_6125
>  
>  config SM_DISPCC_8250
>  	tristate "SM8150/SM8250/SM8350 Display Clock Controller"
> +	depends on ARM64 || COMPILE_TEST
>  	depends on SM_GCC_8150 || SM_GCC_8250 || SM_GCC_8350
>  	help
>  	  Support for the display clock controller on Qualcomm Technologies, Inc
> @@ -677,6 +744,7 @@ config SM_DISPCC_8250
>  
>  config SM_DISPCC_6350
>  	tristate "SM6350 Display Clock Controller"
> +	depends on ARM64 || COMPILE_TEST
>  	depends on SM_GCC_6350
>  	help
>  	  Support for the display clock controller on Qualcomm Technologies, Inc
> @@ -686,6 +754,7 @@ config SM_DISPCC_6350
>  
>  config SM_DISPCC_6375
>  	tristate "SM6375 Display Clock Controller"
> +	depends on ARM64 || COMPILE_TEST
>  	depends on SM_GCC_6375
>  	help
>  	  Support for the display clock controller on Qualcomm Technologies, Inc
> @@ -695,6 +764,7 @@ config SM_DISPCC_6375
>  
>  config SM_DISPCC_8450
>  	tristate "SM8450 Display Clock Controller"
> +	depends on ARM64 || COMPILE_TEST
>  	depends on SM_GCC_8450
>  	help
>  	  Support for the display clock controller on Qualcomm Technologies, Inc
> @@ -704,6 +774,7 @@ config SM_DISPCC_8450
>  
>  config SM_DISPCC_8550
>  	tristate "SM8550 Display Clock Controller"
> +	depends on ARM64 || COMPILE_TEST
>  	depends on SM_GCC_8550
>  	help
>  	  Support for the display clock controller on Qualcomm Technologies, Inc
> @@ -713,6 +784,7 @@ config SM_DISPCC_8550
>  
>  config SM_GCC_6115
>  	tristate "SM6115 and SM4250 Global Clock Controller"
> +	depends on ARM64 || COMPILE_TEST
>  	select QCOM_GDSC
>  	help
>  	  Support for the global clock controller on SM6115 and SM4250 devices.
> @@ -721,6 +793,7 @@ config SM_GCC_6115
>  
>  config SM_GCC_6125
>  	tristate "SM6125 Global Clock Controller"
> +	depends on ARM64 || COMPILE_TEST
>  	help
>  	  Support for the global clock controller on SM6125 devices.
>  	  Say Y if you want to use peripheral devices such as UART,
> @@ -728,6 +801,7 @@ config SM_GCC_6125
>  
>  config SM_GCC_6350
>  	tristate "SM6350 Global Clock Controller"
> +	depends on ARM64 || COMPILE_TEST
>  	select QCOM_GDSC
>  	help
>  	  Support for the global clock controller on SM6350 devices.
> @@ -736,6 +810,7 @@ config SM_GCC_6350
>  
>  config SM_GCC_6375
>  	tristate "SM6375 Global Clock Controller"
> +	depends on ARM64 || COMPILE_TEST
>  	select QCOM_GDSC
>  	help
>  	  Support for the global clock controller on SM6375 devices.
> @@ -744,6 +819,7 @@ config SM_GCC_6375
>  
>  config SM_GCC_8150
>  	tristate "SM8150 Global Clock Controller"
> +	depends on ARM64 || COMPILE_TEST
>  	help
>  	  Support for the global clock controller on SM8150 devices.
>  	  Say Y if you want to use peripheral devices such as UART,
> @@ -751,6 +827,7 @@ config SM_GCC_8150
>  
>  config SM_GCC_8250
>  	tristate "SM8250 Global Clock Controller"
> +	depends on ARM64 || COMPILE_TEST
>  	select QCOM_GDSC
>  	help
>  	  Support for the global clock controller on SM8250 devices.
> @@ -759,6 +836,7 @@ config SM_GCC_8250
>  
>  config SM_GCC_8350
>  	tristate "SM8350 Global Clock Controller"
> +	depends on ARM64 || COMPILE_TEST
>  	select QCOM_GDSC
>  	help
>  	  Support for the global clock controller on SM8350 devices.
> @@ -767,6 +845,7 @@ config SM_GCC_8350
>  
>  config SM_GCC_8450
>  	tristate "SM8450 Global Clock Controller"
> +	depends on ARM64 || COMPILE_TEST
>  	select QCOM_GDSC
>  	help
>  	  Support for the global clock controller on SM8450 devices.
> @@ -775,6 +854,7 @@ config SM_GCC_8450
>  
>  config SM_GCC_8550
>  	tristate "SM8550 Global Clock Controller"
> +	depends on ARM64 || COMPILE_TEST
>  	select QCOM_GDSC
>  	help
>  	  Support for the global clock controller on SM8550 devices.
> @@ -783,6 +863,7 @@ config SM_GCC_8550
>  
>  config SM_GPUCC_6350
>  	tristate "SM6350 Graphics Clock Controller"
> +	depends on ARM64 || COMPILE_TEST
>  	select SM_GCC_6350
>  	help
>  	  Support for the graphics clock controller on SM6350 devices.
> @@ -791,6 +872,7 @@ config SM_GPUCC_6350
>  
>  config SM_GPUCC_8150
>  	tristate "SM8150 Graphics Clock Controller"
> +	depends on ARM64 || COMPILE_TEST
>  	select SM_GCC_8150
>  	help
>  	  Support for the graphics clock controller on SM8150 devices.
> @@ -799,6 +881,7 @@ config SM_GPUCC_8150
>  
>  config SM_GPUCC_8250
>  	tristate "SM8250 Graphics Clock Controller"
> +	depends on ARM64 || COMPILE_TEST
>  	select SM_GCC_8250
>  	help
>  	  Support for the graphics clock controller on SM8250 devices.
> @@ -807,6 +890,7 @@ config SM_GPUCC_8250
>  
>  config SM_GPUCC_8350
>  	tristate "SM8350 Graphics Clock Controller"
> +	depends on ARM64 || COMPILE_TEST
>  	select SM_GCC_8350
>  	help
>  	  Support for the graphics clock controller on SM8350 devices.
> @@ -815,6 +899,7 @@ config SM_GPUCC_8350
>  
>  config SM_TCSRCC_8550
>  	tristate "SM8550 TCSR Clock Controller"
> +	depends on ARM64 || COMPILE_TEST
>  	select QCOM_GDSC
>  	help
>  	  Support for the TCSR clock controller on SM8550 devices.
> @@ -822,6 +907,7 @@ config SM_TCSRCC_8550
>  
>  config SM_VIDEOCC_8150
>  	tristate "SM8150 Video Clock Controller"
> +	depends on ARM64 || COMPILE_TEST
>  	select SM_GCC_8150
>  	select QCOM_GDSC
>  	help
> @@ -831,6 +917,7 @@ config SM_VIDEOCC_8150
>  
>  config SM_VIDEOCC_8250
>  	tristate "SM8250 Video Clock Controller"
> +	depends on ARM64 || COMPILE_TEST
>  	select SM_GCC_8250
>  	select QCOM_GDSC
>  	help
> @@ -871,6 +958,7 @@ config KRAITCC
>  
>  config CLK_GFM_LPASS_SM8250
>  	tristate "SM8250 GFM LPASS Clocks"
> +	depends on ARM64 || COMPILE_TEST
>  	help
>  	  Support for the Glitch Free Mux (GFM) Low power audio
>            subsystem (LPASS) clocks found on SM8250 SoCs.
