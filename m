Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B32B71FD24
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 11:09:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235015AbjFBJJM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 05:09:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234473AbjFBJIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 05:08:31 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67EE91701
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 02:07:12 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4f4c264f6c6so2477246e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 02:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685696830; x=1688288830;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IX+kmeXrNhJi6cZKuaL9gCIGolWcF8s8IuKBE9FFXgg=;
        b=XVCqYO1xKDfiJ/Uyd+9gQiXgnYTb2D2ywIq9BhxWN/ZJasQS+rGEVbBE+/59Jsp0Cl
         NdoKhsyMjmwFl8J5zx2fcwsdARnQ6CSEfnzU+j1vyRzj7b6MoMhSfj3LE54HvdVwiE9+
         t+LmcfFFwYu6tQPqO9a41rZcIZOuiJKBG+A5BLgjp1FFDi0FLUpVRi3gAoB/4gP96kUl
         KvCNzvFKdAUj+/wTUJDvJDYTWXGFJDEsnjbDldT/s0Y7pdZcUYiiRxU5QzX0V79FP0+/
         +oWV/vfED/x4Mmr/zRprc/2Y+9xFo9jYcSY7JxkeOEhOteMU96eV1E/L8WSUH4Ev+Fih
         jDPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685696830; x=1688288830;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IX+kmeXrNhJi6cZKuaL9gCIGolWcF8s8IuKBE9FFXgg=;
        b=Rll5SCQdUXFm+2JDFJgqGDlnNOzlfBHPk6SOIn+nt6QMdbOZWlL8TpQ7BpXaz1IThY
         6dIcsQZXEc4GxaNyUc0eWdDjJQaUHT04Akdv1DSDNEUZOGImEoA5dmzl9XH1307MdxIF
         t61GEQL/RQGfE3tHJZ9tCEWIjI/qCe2akveA20rtZwQFZ8jbYobxYY9rkWHtoi1VfIFJ
         +TfVJ2o0f+i1qArw6RZnUX/Kp+/wUcwJO+P+OYoGfJ4kh2LGKHE7mfqKe3ST+JVB1KSG
         FyM/RkjMtJ120XqRWHZDyjmsJ23qsx+GmR9xM/iT0Gz9ceEnuO2I9HUvj2LDehFtqWR/
         NdWw==
X-Gm-Message-State: AC+VfDwmCqj6eyo6a1+BDocRDpUJh0DmDmTq+ZHHQJDRfC9sXVdTydra
        bBTr5s3rWehFth7eahlWXe3SeA==
X-Google-Smtp-Source: ACHHUZ7MZ4rRkXmnNBzCy3kx/gti2EDC8Boap/W0DrnMizM0PgrD1hdd2oi7TdqStGrkzJQKEmLHVQ==
X-Received: by 2002:a2e:a176:0:b0:2aa:cb6c:d0dc with SMTP id u22-20020a2ea176000000b002aacb6cd0dcmr1070528ljl.29.1685696830031;
        Fri, 02 Jun 2023 02:07:10 -0700 (PDT)
Received: from [192.168.1.101] (abyj77.neoplus.adsl.tpnet.pl. [83.9.29.77])
        by smtp.gmail.com with ESMTPSA id s13-20020a2e81cd000000b002adf8d948dasm151963ljg.35.2023.06.02.02.07.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Jun 2023 02:07:09 -0700 (PDT)
Message-ID: <2d768b8c-9cd0-84dd-9e04-10c11c5b9809@linaro.org>
Date:   Fri, 2 Jun 2023 11:07:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 5/8] pinctrl: qcom: mark true OF dependency - common MSM
 pinctrl code
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20230601152026.1182648-1-krzysztof.kozlowski@linaro.org>
 <20230601152026.1182648-5-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230601152026.1182648-5-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1.06.2023 17:20, Krzysztof Kozlowski wrote:
> The common MSM pinctrl driver code (PINCTRL_MSM) uses
> pinconf_generic_dt_node_to_map_group() from GENERIC_PINCONF, which is
> not available for compile testing for !OF cases.  Drivers actually do
> not depend on OF.  Move the OF dependency to the entry actually
> depending on it and drop any "|| COMPILE_TEST", because OF is required
> also for compile testing (lack of OF was never visible in compile
> testing because none of the drivers could be compile tested due to
> Makefile).
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  drivers/pinctrl/qcom/Kconfig | 43 ++----------------------------------
>  1 file changed, 2 insertions(+), 41 deletions(-)
> 
> diff --git a/drivers/pinctrl/qcom/Kconfig b/drivers/pinctrl/qcom/Kconfig
> index 2236bdff7e60..18ac19f41873 100644
> --- a/drivers/pinctrl/qcom/Kconfig
> +++ b/drivers/pinctrl/qcom/Kconfig
> @@ -4,6 +4,8 @@ if (ARCH_QCOM || COMPILE_TEST)
>  config PINCTRL_MSM
>  	tristate "Qualcomm core pin controller driver"
>  	depends on GPIOLIB
> +	# OF for pinconf_generic_dt_node_to_map_group() from GENERIC_PINCONF
> +	depends on OF
>  	select QCOM_SCM
>  	select PINMUX
>  	select PINCONF
> @@ -14,7 +16,6 @@ config PINCTRL_MSM
>  
>  config PINCTRL_APQ8064
>  	tristate "Qualcomm APQ8064 pin controller driver"
> -	depends on OF
>  	depends on ARM || COMPILE_TEST
>  	depends on PINCTRL_MSM
>  	help
> @@ -23,7 +24,6 @@ config PINCTRL_APQ8064
>  
>  config PINCTRL_APQ8084
>  	tristate "Qualcomm APQ8084 pin controller driver"
> -	depends on OF
>  	depends on ARM || COMPILE_TEST
>  	depends on PINCTRL_MSM
>  	help
> @@ -32,7 +32,6 @@ config PINCTRL_APQ8084
>  
>  config PINCTRL_IPQ4019
>  	tristate "Qualcomm IPQ4019 pin controller driver"
> -	depends on OF
>  	depends on ARM || COMPILE_TEST
>  	depends on PINCTRL_MSM
>  	help
> @@ -41,7 +40,6 @@ config PINCTRL_IPQ4019
>  
>  config PINCTRL_IPQ8064
>  	tristate "Qualcomm IPQ8064 pin controller driver"
> -	depends on OF
>  	depends on ARM || COMPILE_TEST
>  	depends on PINCTRL_MSM
>  	help
> @@ -50,7 +48,6 @@ config PINCTRL_IPQ8064
>  
>  config PINCTRL_IPQ5332
>  	tristate "Qualcomm Technologies Inc IPQ5332 pin controller driver"
> -	depends on OF
>  	depends on ARM64 || COMPILE_TEST
>  	depends on PINCTRL_MSM
>  	help
> @@ -60,7 +57,6 @@ config PINCTRL_IPQ5332
>  
>  config PINCTRL_IPQ8074
>  	tristate "Qualcomm Technologies, Inc. IPQ8074 pin controller driver"
> -	depends on OF
>  	depends on ARM64 || COMPILE_TEST
>  	depends on PINCTRL_MSM
>  	help
> @@ -71,7 +67,6 @@ config PINCTRL_IPQ8074
>  
>  config PINCTRL_IPQ6018
>  	tristate "Qualcomm Technologies, Inc. IPQ6018 pin controller driver"
> -	depends on OF
>  	depends on ARM64 || COMPILE_TEST
>  	depends on PINCTRL_MSM
>  	help
> @@ -82,7 +77,6 @@ config PINCTRL_IPQ6018
>  
>  config PINCTRL_IPQ9574
>  	tristate "Qualcomm Technologies, Inc. IPQ9574 pin controller driver"
> -	depends on OF || COMPILE_TEST
>  	depends on ARM64 || COMPILE_TEST
>  	depends on PINCTRL_MSM
>  	help
> @@ -93,7 +87,6 @@ config PINCTRL_IPQ9574
>  
>  config PINCTRL_MSM8226
>  	tristate "Qualcomm 8226 pin controller driver"
> -	depends on OF
>  	depends on ARM || COMPILE_TEST
>  	depends on PINCTRL_MSM
>  	help
> @@ -103,7 +96,6 @@ config PINCTRL_MSM8226
>  
>  config PINCTRL_MSM8660
>  	tristate "Qualcomm 8660 pin controller driver"
> -	depends on OF
>  	depends on ARM || COMPILE_TEST
>  	depends on PINCTRL_MSM
>  	help
> @@ -112,7 +104,6 @@ config PINCTRL_MSM8660
>  
>  config PINCTRL_MSM8960
>  	tristate "Qualcomm 8960 pin controller driver"
> -	depends on OF
>  	depends on ARM || COMPILE_TEST
>  	depends on PINCTRL_MSM
>  	help
> @@ -121,7 +112,6 @@ config PINCTRL_MSM8960
>  
>  config PINCTRL_MDM9607
>  	tristate "Qualcomm 9607 pin controller driver"
> -	depends on OF
>  	depends on PINCTRL_MSM
>  	help
>  	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
> @@ -129,7 +119,6 @@ config PINCTRL_MDM9607
>  
>  config PINCTRL_MDM9615
>  	tristate "Qualcomm 9615 pin controller driver"
> -	depends on OF
>  	depends on ARM || COMPILE_TEST
>  	depends on PINCTRL_MSM
>  	help
> @@ -138,7 +127,6 @@ config PINCTRL_MDM9615
>  
>  config PINCTRL_MSM8X74
>  	tristate "Qualcomm 8x74 pin controller driver"
> -	depends on OF
>  	depends on ARM || COMPILE_TEST
>  	depends on PINCTRL_MSM
>  	help
> @@ -147,7 +135,6 @@ config PINCTRL_MSM8X74
>  
>  config PINCTRL_MSM8909
>  	tristate "Qualcomm 8909 pin controller driver"
> -	depends on OF
>  	depends on ARM || COMPILE_TEST
>  	depends on PINCTRL_MSM
>  	help
> @@ -156,7 +143,6 @@ config PINCTRL_MSM8909
>  
>  config PINCTRL_MSM8916
>  	tristate "Qualcomm 8916 pin controller driver"
> -	depends on OF
>  	depends on PINCTRL_MSM
>  	help
>  	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
> @@ -164,7 +150,6 @@ config PINCTRL_MSM8916
>  
>  config PINCTRL_MSM8953
>  	tristate "Qualcomm 8953 pin controller driver"
> -	depends on OF
>  	depends on ARM64 || COMPILE_TEST
>  	depends on PINCTRL_MSM
>  	help
> @@ -175,7 +160,6 @@ config PINCTRL_MSM8953
>  
>  config PINCTRL_MSM8976
>  	tristate "Qualcomm 8976 pin controller driver"
> -	depends on OF
>  	depends on ARM64 || COMPILE_TEST
>  	depends on PINCTRL_MSM
>  	help
> @@ -186,7 +170,6 @@ config PINCTRL_MSM8976
>  
>  config PINCTRL_MSM8994
>  	tristate "Qualcomm 8994 pin controller driver"
> -	depends on OF
>  	depends on ARM64 || COMPILE_TEST
>  	depends on PINCTRL_MSM
>  	help
> @@ -196,7 +179,6 @@ config PINCTRL_MSM8994
>  
>  config PINCTRL_MSM8996
>  	tristate "Qualcomm MSM8996 pin controller driver"
> -	depends on OF
>  	depends on ARM64 || COMPILE_TEST
>  	depends on PINCTRL_MSM
>  	help
> @@ -205,7 +187,6 @@ config PINCTRL_MSM8996
>  
>  config PINCTRL_MSM8998
>  	tristate "Qualcomm MSM8998 pin controller driver"
> -	depends on OF
>  	depends on ARM64 || COMPILE_TEST
>  	depends on PINCTRL_MSM
>  	help
> @@ -214,7 +195,6 @@ config PINCTRL_MSM8998
>  
>  config PINCTRL_QCM2290
>  	tristate "Qualcomm QCM2290 pin controller driver"
> -	depends on OF
>  	depends on ARM64 || COMPILE_TEST
>  	depends on PINCTRL_MSM
>  	help
> @@ -223,7 +203,6 @@ config PINCTRL_QCM2290
>  
>  config PINCTRL_QCS404
>  	tristate "Qualcomm QCS404 pin controller driver"
> -	depends on OF
>  	depends on ARM64 || COMPILE_TEST
>  	depends on PINCTRL_MSM
>  	help
> @@ -271,7 +250,6 @@ config PINCTRL_QCOM_SSBI_PMIC
>  
>  config PINCTRL_QDU1000
>  	tristate "Qualcomm Technologies Inc QDU1000/QRU1000 pin controller driver"
> -	depends on OF
>  	depends on ARM64 || COMPILE_TEST
>  	depends on PINCTRL_MSM
>  	help
> @@ -281,7 +259,6 @@ config PINCTRL_QDU1000
>  
>  config PINCTRL_SA8775P
>  	tristate "Qualcomm Technologies Inc SA8775P pin controller driver"
> -	depends on OF
>  	depends on ARM64 || COMPILE_TEST
>  	depends on PINCTRL_MSM
>  	help
> @@ -290,7 +267,6 @@ config PINCTRL_SA8775P
>  
>  config PINCTRL_SC7180
>  	tristate "Qualcomm Technologies Inc SC7180 pin controller driver"
> -	depends on OF
>  	depends on ARM64 || COMPILE_TEST
>  	depends on PINCTRL_MSM
>  	help
> @@ -300,7 +276,6 @@ config PINCTRL_SC7180
>  
>  config PINCTRL_SC7280
>  	tristate "Qualcomm Technologies Inc SC7280 pin controller driver"
> -	depends on OF
>  	depends on ARM64 || COMPILE_TEST
>  	depends on PINCTRL_MSM
>  	help
> @@ -329,7 +304,6 @@ config PINCTRL_SC8180X
>  
>  config PINCTRL_SC8280XP
>  	tristate "Qualcomm Technologies Inc SC8280xp pin controller driver"
> -	depends on OF
>  	depends on ARM64 || COMPILE_TEST
>  	depends on PINCTRL_MSM
>  	help
> @@ -339,7 +313,6 @@ config PINCTRL_SC8280XP
>  
>  config PINCTRL_SDM660
>  	tristate "Qualcomm Technologies Inc SDM660 pin controller driver"
> -	depends on OF
>  	depends on ARM64 || COMPILE_TEST
>  	depends on PINCTRL_MSM
>  	help
> @@ -349,7 +322,6 @@ config PINCTRL_SDM660
>  
>  config PINCTRL_SDM670
>  	tristate "Qualcomm Technologies Inc SDM670 pin controller driver"
> -	depends on OF
>  	depends on ARM64 || COMPILE_TEST
>  	depends on PINCTRL_MSM
>  	help
> @@ -369,7 +341,6 @@ config PINCTRL_SDM845
>  
>  config PINCTRL_SDX55
>  	tristate "Qualcomm Technologies Inc SDX55 pin controller driver"
> -	depends on OF
>  	depends on ARM || COMPILE_TEST
>  	depends on PINCTRL_MSM
>  	help
> @@ -379,7 +350,6 @@ config PINCTRL_SDX55
>  
>  config PINCTRL_SDX65
>          tristate "Qualcomm Technologies Inc SDX65 pin controller driver"
> -        depends on OF
>          depends on ARM || COMPILE_TEST
>          depends on PINCTRL_MSM
>          help
> @@ -389,7 +359,6 @@ config PINCTRL_SDX65
>  
>  config PINCTRL_SDX75
>          tristate "Qualcomm Technologies Inc SDX75 pin controller driver"
> -        depends on OF
>          depends on ARM64 || COMPILE_TEST
>          depends on PINCTRL_MSM
>          help
> @@ -399,7 +368,6 @@ config PINCTRL_SDX75
>  
>  config PINCTRL_SM6115
>  	tristate "Qualcomm Technologies Inc SM6115,SM4250 pin controller driver"
> -	depends on OF
>  	depends on ARM64 || COMPILE_TEST
>  	depends on PINCTRL_MSM
>  	help
> @@ -409,7 +377,6 @@ config PINCTRL_SM6115
>  
>  config PINCTRL_SM6125
>  	tristate "Qualcomm Technologies Inc SM6125 pin controller driver"
> -	depends on OF
>  	depends on ARM64 || COMPILE_TEST
>  	depends on PINCTRL_MSM
>  	help
> @@ -419,7 +386,6 @@ config PINCTRL_SM6125
>  
>  config PINCTRL_SM6350
>  	tristate "Qualcomm Technologies Inc SM6350 pin controller driver"
> -	depends on OF
>  	depends on ARM64 || COMPILE_TEST
>  	depends on PINCTRL_MSM
>  	help
> @@ -429,7 +395,6 @@ config PINCTRL_SM6350
>  
>  config PINCTRL_SM6375
>  	tristate "Qualcomm Technologies Inc SM6375 pin controller driver"
> -	depends on OF
>  	depends on ARM64 || COMPILE_TEST
>  	depends on PINCTRL_MSM
>  	help
> @@ -439,7 +404,6 @@ config PINCTRL_SM6375
>  
>  config PINCTRL_SM7150
>  	tristate "Qualcomm Technologies Inc SM7150 pin controller driver"
> -	depends on OF
>  	depends on ARM64 || COMPILE_TEST
>  	depends on PINCTRL_MSM
>  	help
> @@ -449,7 +413,6 @@ config PINCTRL_SM7150
>  
>  config PINCTRL_SM8150
>  	tristate "Qualcomm Technologies Inc SM8150 pin controller driver"
> -	depends on OF
>  	depends on ARM64 || COMPILE_TEST
>  	depends on PINCTRL_MSM
>  	help
> @@ -459,7 +422,6 @@ config PINCTRL_SM8150
>  
>  config PINCTRL_SM8250
>  	tristate "Qualcomm Technologies Inc SM8250 pin controller driver"
> -	depends on OF
>  	depends on ARM64 || COMPILE_TEST
>  	depends on PINCTRL_MSM
>  	help
> @@ -487,7 +449,6 @@ config PINCTRL_SM8350
>  
>  config PINCTRL_SM8450
>  	tristate "Qualcomm Technologies Inc SM8450 pin controller driver"
> -	depends on OF
>  	depends on ARM64 || COMPILE_TEST
>  	depends on PINCTRL_MSM
>  	help
