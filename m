Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 184F671FD37
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 11:11:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234253AbjFBJL1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 05:11:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235056AbjFBJKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 05:10:55 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4751E44
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 02:09:19 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4f3bb61f860so2426236e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 02:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685696958; x=1688288958;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7joLVyMYmiNA/fmJ/XpIudDM3IycJIbB6ZcHoryx/qs=;
        b=D4GwtLFO340lHIPcW/zBSbJqhubpwzhyNiHal2v/+Y3UaGsd/y1BMrL/GGNwcnfI4k
         klinJ/tJ/7MpgEL2epvDne3u5DrbDUiqmHKdTOJo4hzPY7Nb5YWU+nHX+Utht3MaKBRo
         TMqF1tQ+fu8OJeN6SzbG8Qvct3OjAkjwex0ter+Myfrrn8rJQc43dlAwgcRxyWHqCXYS
         0CCPVBG4FtTLvhhmZWVPqq5NSyI65buCFQjPJttbV/+kpCfMi7NIAeOWPHGHRkwVKxyr
         xPfUUin58ffrLUV6v6b5Duoff5LbhWjGFbRENXX7WWb1CNMyW6RlT2RZ//1th97nwbHw
         8RrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685696958; x=1688288958;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7joLVyMYmiNA/fmJ/XpIudDM3IycJIbB6ZcHoryx/qs=;
        b=EnDLgeJArsJ7PVznW02LU0FyW0FdhjVNkN0tKBEf0s8i0FYcJVrqdarLG8hX/GplDe
         TbHnkcOUd/+Xgkf+XqsMwkXdKaP3e5IveQwkOq87EIDWYwJcKlXNw68DllCGakmwhDxl
         VEBk3OKW5betiViSsezC7DNbpWwN3jFzxwEvO1jq/Ylv19iv/gs3F3EAykhp5PRDr2Rl
         cVM+v1n652eSNjfhm3JyeI2wUeWgrCI4/LTrv3L8VdF7zZj3Hr30SJmIncq5jBrJioSI
         4rFxgKwyFQcINSWvbkSDhNPNtwo6+gc3AuX80/WpGGdXNYgw8qjipMOAiUnA4gKsbQx7
         NDVQ==
X-Gm-Message-State: AC+VfDyb5aylx+bSKfh/GnVRJv/5m2PZ6VPC8fQ5p/RQ2HZfgkEZUR7q
        L6bfBEb6ta53HaM/0ge+PBh1FQ==
X-Google-Smtp-Source: ACHHUZ64R9g2BrEcHzUj7DUntkUV7QSx8uxbI7rbS9OzPkPPfURPQ6fflolAGh4vqhRXN0ro85+NXg==
X-Received: by 2002:a19:ee13:0:b0:4f2:455d:18bd with SMTP id g19-20020a19ee13000000b004f2455d18bdmr1505717lfb.16.1685696957468;
        Fri, 02 Jun 2023 02:09:17 -0700 (PDT)
Received: from [192.168.1.101] (abyj77.neoplus.adsl.tpnet.pl. [83.9.29.77])
        by smtp.gmail.com with ESMTPSA id v7-20020a197407000000b004f25c1e2cf5sm97669lfe.173.2023.06.02.02.09.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Jun 2023 02:09:17 -0700 (PDT)
Message-ID: <d87f8b96-b575-ffed-49a8-71255e551051@linaro.org>
Date:   Fri, 2 Jun 2023 11:09:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 7/8] pinctrl: qcom: organize main SoC drivers in new
 Kconfig.msm
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20230601152026.1182648-1-krzysztof.kozlowski@linaro.org>
 <20230601152026.1182648-7-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230601152026.1182648-7-krzysztof.kozlowski@linaro.org>
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
> In menuconfig, some entries depending on PINCTRL_MSM are indented and
> expressed as dependening but some not, because of other Kconfig entries
> in between,
> 
> Move all main Qualcomm SoC pin controller driver entries into new
> Kconfig.msm file so they will be nicely ordered in Kconfig file (by
> CONFIG_ name) and properly indented as PINCTRL_MSM dependency in
> menuconfig.
> 
> Functionally this is the same, but since entire file is guarded with "if
> PINCTRL_MSM" drop this dependency from individual entries.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
Wow.. nice!

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  drivers/pinctrl/qcom/Kconfig     | 402 +------------------------------
>  drivers/pinctrl/qcom/Kconfig.msm | 360 +++++++++++++++++++++++++++
>  2 files changed, 361 insertions(+), 401 deletions(-)
>  create mode 100644 drivers/pinctrl/qcom/Kconfig.msm
> 
> diff --git a/drivers/pinctrl/qcom/Kconfig b/drivers/pinctrl/qcom/Kconfig
> index 18ac19f41873..f1c23a641fe1 100644
> --- a/drivers/pinctrl/qcom/Kconfig
> +++ b/drivers/pinctrl/qcom/Kconfig
> @@ -14,208 +14,7 @@ config PINCTRL_MSM
>  	select IRQ_DOMAIN_HIERARCHY
>  	select IRQ_FASTEOI_HIERARCHY_HANDLERS
>  
> -config PINCTRL_APQ8064
> -	tristate "Qualcomm APQ8064 pin controller driver"
> -	depends on ARM || COMPILE_TEST
> -	depends on PINCTRL_MSM
> -	help
> -	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
> -	  Qualcomm TLMM block found in the Qualcomm APQ8064 platform.
> -
> -config PINCTRL_APQ8084
> -	tristate "Qualcomm APQ8084 pin controller driver"
> -	depends on ARM || COMPILE_TEST
> -	depends on PINCTRL_MSM
> -	help
> -	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
> -	  Qualcomm TLMM block found in the Qualcomm APQ8084 platform.
> -
> -config PINCTRL_IPQ4019
> -	tristate "Qualcomm IPQ4019 pin controller driver"
> -	depends on ARM || COMPILE_TEST
> -	depends on PINCTRL_MSM
> -	help
> -	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
> -	  Qualcomm TLMM block found in the Qualcomm IPQ4019 platform.
> -
> -config PINCTRL_IPQ8064
> -	tristate "Qualcomm IPQ8064 pin controller driver"
> -	depends on ARM || COMPILE_TEST
> -	depends on PINCTRL_MSM
> -	help
> -	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
> -	  Qualcomm TLMM block found in the Qualcomm IPQ8064 platform.
> -
> -config PINCTRL_IPQ5332
> -	tristate "Qualcomm Technologies Inc IPQ5332 pin controller driver"
> -	depends on ARM64 || COMPILE_TEST
> -	depends on PINCTRL_MSM
> -	help
> -	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
> -	  Qualcomm Technologies Inc TLMM block found on the Qualcomm
> -	  Technologies Inc IPQ5332 platform.
> -
> -config PINCTRL_IPQ8074
> -	tristate "Qualcomm Technologies, Inc. IPQ8074 pin controller driver"
> -	depends on ARM64 || COMPILE_TEST
> -	depends on PINCTRL_MSM
> -	help
> -	  This is the pinctrl, pinmux, pinconf and gpiolib driver for
> -	  the Qualcomm Technologies Inc. TLMM block found on the
> -	  Qualcomm Technologies Inc. IPQ8074 platform. Select this for
> -	  IPQ8074.
> -
> -config PINCTRL_IPQ6018
> -	tristate "Qualcomm Technologies, Inc. IPQ6018 pin controller driver"
> -	depends on ARM64 || COMPILE_TEST
> -	depends on PINCTRL_MSM
> -	help
> -	  This is the pinctrl, pinmux, pinconf and gpiolib driver for
> -	  the Qualcomm Technologies Inc. TLMM block found on the
> -	  Qualcomm Technologies Inc. IPQ6018 platform. Select this for
> -	  IPQ6018.
> -
> -config PINCTRL_IPQ9574
> -	tristate "Qualcomm Technologies, Inc. IPQ9574 pin controller driver"
> -	depends on ARM64 || COMPILE_TEST
> -	depends on PINCTRL_MSM
> -	help
> -	  This is the pinctrl, pinmux, pinconf and gpiolib driver for
> -          the Qualcomm Technologies Inc. TLMM block found on the
> -          Qualcomm Technologies Inc. IPQ9574 platform. Select this for
> -          IPQ9574.
> -
> -config PINCTRL_MSM8226
> -	tristate "Qualcomm 8226 pin controller driver"
> -	depends on ARM || COMPILE_TEST
> -	depends on PINCTRL_MSM
> -	help
> -	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
> -	  Qualcomm Technologies Inc TLMM block found on the Qualcomm
> -	  Technologies Inc MSM8226 platform.
> -
> -config PINCTRL_MSM8660
> -	tristate "Qualcomm 8660 pin controller driver"
> -	depends on ARM || COMPILE_TEST
> -	depends on PINCTRL_MSM
> -	help
> -	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
> -	  Qualcomm TLMM block found in the Qualcomm 8660 platform.
> -
> -config PINCTRL_MSM8960
> -	tristate "Qualcomm 8960 pin controller driver"
> -	depends on ARM || COMPILE_TEST
> -	depends on PINCTRL_MSM
> -	help
> -	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
> -	  Qualcomm TLMM block found in the Qualcomm 8960 platform.
> -
> -config PINCTRL_MDM9607
> -	tristate "Qualcomm 9607 pin controller driver"
> -	depends on PINCTRL_MSM
> -	help
> -	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
> -	  Qualcomm TLMM block found in the Qualcomm 9607 platform.
> -
> -config PINCTRL_MDM9615
> -	tristate "Qualcomm 9615 pin controller driver"
> -	depends on ARM || COMPILE_TEST
> -	depends on PINCTRL_MSM
> -	help
> -	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
> -	  Qualcomm TLMM block found in the Qualcomm 9615 platform.
> -
> -config PINCTRL_MSM8X74
> -	tristate "Qualcomm 8x74 pin controller driver"
> -	depends on ARM || COMPILE_TEST
> -	depends on PINCTRL_MSM
> -	help
> -	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
> -	  Qualcomm TLMM block found in the Qualcomm 8974 platform.
> -
> -config PINCTRL_MSM8909
> -	tristate "Qualcomm 8909 pin controller driver"
> -	depends on ARM || COMPILE_TEST
> -	depends on PINCTRL_MSM
> -	help
> -	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
> -	  Qualcomm TLMM block found on the Qualcomm MSM8909 platform.
> -
> -config PINCTRL_MSM8916
> -	tristate "Qualcomm 8916 pin controller driver"
> -	depends on PINCTRL_MSM
> -	help
> -	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
> -	  Qualcomm TLMM block found on the Qualcomm 8916 platform.
> -
> -config PINCTRL_MSM8953
> -	tristate "Qualcomm 8953 pin controller driver"
> -	depends on ARM64 || COMPILE_TEST
> -	depends on PINCTRL_MSM
> -	help
> -	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
> -	  Qualcomm TLMM block found on the Qualcomm MSM8953 platform.
> -	  The Qualcomm APQ8053, SDM450, SDM632 platforms are also
> -	  supported by this driver.
> -
> -config PINCTRL_MSM8976
> -	tristate "Qualcomm 8976 pin controller driver"
> -	depends on ARM64 || COMPILE_TEST
> -	depends on PINCTRL_MSM
> -	help
> -	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
> -	  Qualcomm TLMM block found on the Qualcomm MSM8976 platform.
> -	  The Qualcomm MSM8956, APQ8056, APQ8076 platforms are also
> -	  supported by this driver.
> -
> -config PINCTRL_MSM8994
> -	tristate "Qualcomm 8994 pin controller driver"
> -	depends on ARM64 || COMPILE_TEST
> -	depends on PINCTRL_MSM
> -	help
> -	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
> -	  Qualcomm TLMM block found in the Qualcomm 8994 platform. The
> -	  Qualcomm 8992 platform is also supported by this driver.
> -
> -config PINCTRL_MSM8996
> -	tristate "Qualcomm MSM8996 pin controller driver"
> -	depends on ARM64 || COMPILE_TEST
> -	depends on PINCTRL_MSM
> -	help
> -	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
> -	  Qualcomm TLMM block found in the Qualcomm MSM8996 platform.
> -
> -config PINCTRL_MSM8998
> -	tristate "Qualcomm MSM8998 pin controller driver"
> -	depends on ARM64 || COMPILE_TEST
> -	depends on PINCTRL_MSM
> -	help
> -	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
> -	  Qualcomm TLMM block found in the Qualcomm MSM8998 platform.
> -
> -config PINCTRL_QCM2290
> -	tristate "Qualcomm QCM2290 pin controller driver"
> -	depends on ARM64 || COMPILE_TEST
> -	depends on PINCTRL_MSM
> -	help
> -	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
> -	  TLMM block found in the Qualcomm QCM2290 platform.
> -
> -config PINCTRL_QCS404
> -	tristate "Qualcomm QCS404 pin controller driver"
> -	depends on ARM64 || COMPILE_TEST
> -	depends on PINCTRL_MSM
> -	help
> -	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
> -	  TLMM block found in the Qualcomm QCS404 platform.
> -
> -config PINCTRL_QDF2XXX
> -	tristate "Qualcomm Technologies QDF2xxx pin controller driver"
> -	depends on ACPI
> -	depends on PINCTRL_MSM
> -	help
> -	  This is the GPIO driver for the TLMM block found on the
> -	  Qualcomm Technologies QDF2xxx SOCs.
> +source "drivers/pinctrl/qcom/Kconfig.msm"
>  
>  config PINCTRL_QCOM_SPMI_PMIC
>  	tristate "Qualcomm SPMI PMIC pin controller driver"
> @@ -248,41 +47,6 @@ config PINCTRL_QCOM_SSBI_PMIC
>  	 which are using SSBI for communication with SoC. Example PMIC's
>  	 devices are pm8058 and pm8921.
>  
> -config PINCTRL_QDU1000
> -	tristate "Qualcomm Technologies Inc QDU1000/QRU1000 pin controller driver"
> -	depends on ARM64 || COMPILE_TEST
> -	depends on PINCTRL_MSM
> -	help
> -	  This is the pinctrl, pinmux, pinconf, and gpiolib driver for the
> -	  Qualcomm Technologies Inc TLMM block found on the Qualcomm
> -	  Technologies Inc QDU1000 and QRU1000 platforms.
> -
> -config PINCTRL_SA8775P
> -	tristate "Qualcomm Technologies Inc SA8775P pin controller driver"
> -	depends on ARM64 || COMPILE_TEST
> -	depends on PINCTRL_MSM
> -	help
> -	  This is the pinctrl, pinmux and pinconf driver for the Qualcomm
> -	  TLMM block found on the Qualcomm SA8775P platforms.
> -
> -config PINCTRL_SC7180
> -	tristate "Qualcomm Technologies Inc SC7180 pin controller driver"
> -	depends on ARM64 || COMPILE_TEST
> -	depends on PINCTRL_MSM
> -	help
> -	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
> -	  Qualcomm Technologies Inc TLMM block found on the Qualcomm
> -	  Technologies Inc SC7180 platform.
> -
> -config PINCTRL_SC7280
> -	tristate "Qualcomm Technologies Inc SC7280 pin controller driver"
> -	depends on ARM64 || COMPILE_TEST
> -	depends on PINCTRL_MSM
> -	help
> -	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
> -	  Qualcomm Technologies Inc TLMM block found on the Qualcomm
> -	  Technologies Inc SC7280 platform.
> -
>  config PINCTRL_SC7280_LPASS_LPI
>  	tristate "Qualcomm Technologies Inc SC7280 LPASS LPI pin controller driver"
>  	depends on ARM64 || COMPILE_TEST
> @@ -292,143 +56,6 @@ config PINCTRL_SC7280_LPASS_LPI
>  	  Qualcomm Technologies Inc LPASS (Low Power Audio SubSystem) LPI
>  	  (Low Power Island) found on the Qualcomm Technologies Inc SC7280 platform.
>  
> -config PINCTRL_SC8180X
> -	tristate "Qualcomm Technologies Inc SC8180x pin controller driver"
> -	depends on (OF || ACPI)
> -	depends on ARM64 || COMPILE_TEST
> -	depends on PINCTRL_MSM
> -	help
> -	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
> -	  Qualcomm Technologies Inc TLMM block found on the Qualcomm
> -	  Technologies Inc SC8180x platform.
> -
> -config PINCTRL_SC8280XP
> -	tristate "Qualcomm Technologies Inc SC8280xp pin controller driver"
> -	depends on ARM64 || COMPILE_TEST
> -	depends on PINCTRL_MSM
> -	help
> -	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
> -	  Qualcomm Technologies Inc TLMM block found on the Qualcomm
> -	  Technologies Inc SC8280xp platform.
> -
> -config PINCTRL_SDM660
> -	tristate "Qualcomm Technologies Inc SDM660 pin controller driver"
> -	depends on ARM64 || COMPILE_TEST
> -	depends on PINCTRL_MSM
> -	help
> -	 This is the pinctrl, pinmux, pinconf and gpiolib driver for the
> -	 Qualcomm Technologies Inc TLMM block found on the Qualcomm
> -	 Technologies Inc SDM660 platform.
> -
> -config PINCTRL_SDM670
> -	tristate "Qualcomm Technologies Inc SDM670 pin controller driver"
> -	depends on ARM64 || COMPILE_TEST
> -	depends on PINCTRL_MSM
> -	help
> -	 This is the pinctrl, pinmux, pinconf and gpiolib driver for the
> -	 Qualcomm Technologies Inc TLMM block found on the Qualcomm
> -	 Technologies Inc SDM670 platform.
> -
> -config PINCTRL_SDM845
> -	tristate "Qualcomm Technologies Inc SDM845 pin controller driver"
> -	depends on (OF || ACPI)
> -	depends on ARM64 || COMPILE_TEST
> -	depends on PINCTRL_MSM
> -	help
> -	 This is the pinctrl, pinmux, pinconf and gpiolib driver for the
> -	 Qualcomm Technologies Inc TLMM block found on the Qualcomm
> -	 Technologies Inc SDM845 platform.
> -
> -config PINCTRL_SDX55
> -	tristate "Qualcomm Technologies Inc SDX55 pin controller driver"
> -	depends on ARM || COMPILE_TEST
> -	depends on PINCTRL_MSM
> -	help
> -	 This is the pinctrl, pinmux, pinconf and gpiolib driver for the
> -	 Qualcomm Technologies Inc TLMM block found on the Qualcomm
> -	 Technologies Inc SDX55 platform.
> -
> -config PINCTRL_SDX65
> -        tristate "Qualcomm Technologies Inc SDX65 pin controller driver"
> -        depends on ARM || COMPILE_TEST
> -        depends on PINCTRL_MSM
> -        help
> -         This is the pinctrl, pinmux, pinconf and gpiolib driver for the
> -         Qualcomm Technologies Inc TLMM block found on the Qualcomm
> -         Technologies Inc SDX65 platform.
> -
> -config PINCTRL_SDX75
> -        tristate "Qualcomm Technologies Inc SDX75 pin controller driver"
> -        depends on ARM64 || COMPILE_TEST
> -        depends on PINCTRL_MSM
> -        help
> -         This is the pinctrl, pinmux, pinconf and gpiolib driver for the
> -         Qualcomm Technologies Inc TLMM block found on the Qualcomm
> -         Technologies Inc SDX75 platform.
> -
> -config PINCTRL_SM6115
> -	tristate "Qualcomm Technologies Inc SM6115,SM4250 pin controller driver"
> -	depends on ARM64 || COMPILE_TEST
> -	depends on PINCTRL_MSM
> -	help
> -	 This is the pinctrl, pinmux, pinconf and gpiolib driver for the
> -	 Qualcomm Technologies Inc TLMM block found on the Qualcomm
> -	 Technologies Inc SM6115 and SM4250 platforms.
> -
> -config PINCTRL_SM6125
> -	tristate "Qualcomm Technologies Inc SM6125 pin controller driver"
> -	depends on ARM64 || COMPILE_TEST
> -	depends on PINCTRL_MSM
> -	help
> -	 This is the pinctrl, pinmux, pinconf and gpiolib driver for the
> -	 Qualcomm Technologies Inc TLMM block found on the Qualcomm
> -	 Technologies Inc SM6125 platform.
> -
> -config PINCTRL_SM6350
> -	tristate "Qualcomm Technologies Inc SM6350 pin controller driver"
> -	depends on ARM64 || COMPILE_TEST
> -	depends on PINCTRL_MSM
> -	help
> -	 This is the pinctrl, pinmux, pinconf and gpiolib driver for the
> -	 Qualcomm Technologies Inc TLMM block found on the Qualcomm
> -	 Technologies Inc SM6350 platform.
> -
> -config PINCTRL_SM6375
> -	tristate "Qualcomm Technologies Inc SM6375 pin controller driver"
> -	depends on ARM64 || COMPILE_TEST
> -	depends on PINCTRL_MSM
> -	help
> -	 This is the pinctrl, pinmux, pinconf and gpiolib driver for the
> -	 Qualcomm Technologies Inc TLMM block found on the Qualcomm
> -	 Technologies Inc SM6375 platform.
> -
> -config PINCTRL_SM7150
> -	tristate "Qualcomm Technologies Inc SM7150 pin controller driver"
> -	depends on ARM64 || COMPILE_TEST
> -	depends on PINCTRL_MSM
> -	help
> -	 This is the pinctrl, pinmux, pinconf and gpiolib driver for the
> -	 Qualcomm Technologies Inc TLMM block found on the Qualcomm
> -	 Technologies Inc SM7150 platform.
> -
> -config PINCTRL_SM8150
> -	tristate "Qualcomm Technologies Inc SM8150 pin controller driver"
> -	depends on ARM64 || COMPILE_TEST
> -	depends on PINCTRL_MSM
> -	help
> -	 This is the pinctrl, pinmux, pinconf and gpiolib driver for the
> -	 Qualcomm Technologies Inc TLMM block found on the Qualcomm
> -	 Technologies Inc SM8150 platform.
> -
> -config PINCTRL_SM8250
> -	tristate "Qualcomm Technologies Inc SM8250 pin controller driver"
> -	depends on ARM64 || COMPILE_TEST
> -	depends on PINCTRL_MSM
> -	help
> -	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
> -	  Qualcomm Technologies Inc TLMM block found on the Qualcomm
> -	  Technologies Inc SM8250 platform.
> -
>  config PINCTRL_SM8250_LPASS_LPI
>  	tristate "Qualcomm Technologies Inc SM8250 LPASS LPI pin controller driver"
>  	depends on ARM64 || COMPILE_TEST
> @@ -438,24 +65,6 @@ config PINCTRL_SM8250_LPASS_LPI
>  	  Qualcomm Technologies Inc LPASS (Low Power Audio SubSystem) LPI
>  	  (Low Power Island) found on the Qualcomm Technologies Inc SM8250 platform.
>  
> -config PINCTRL_SM8350
> -	tristate "Qualcomm Technologies Inc SM8350 pin controller driver"
> -	depends on ARM64 || COMPILE_TEST
> -	depends on PINCTRL_MSM
> -	help
> -	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
> -	  Qualcomm Technologies Inc TLMM block found on the Qualcomm
> -	  Technologies Inc SM8350 platform.
> -
> -config PINCTRL_SM8450
> -	tristate "Qualcomm Technologies Inc SM8450 pin controller driver"
> -	depends on ARM64 || COMPILE_TEST
> -	depends on PINCTRL_MSM
> -	help
> -	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
> -	  Qualcomm Technologies Inc TLMM block found on the Qualcomm
> -	  Technologies Inc SM8450 platform.
> -
>  config PINCTRL_SM8450_LPASS_LPI
>  	tristate "Qualcomm Technologies Inc SM8450 LPASS LPI pin controller driver"
>  	depends on ARM64 || COMPILE_TEST
> @@ -474,15 +83,6 @@ config PINCTRL_SC8280XP_LPASS_LPI
>  	  Qualcomm Technologies Inc LPASS (Low Power Audio SubSystem) LPI
>  	  (Low Power Island) found on the Qualcomm Technologies Inc SC8280XP platform.
>  
> -config PINCTRL_SM8550
> -	tristate "Qualcomm Technologies Inc SM8550 pin controller driver"
> -	depends on ARM64 || COMPILE_TEST
> -	depends on PINCTRL_MSM
> -	help
> -	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
> -	  Qualcomm Technologies Inc TLMM block found on the Qualcomm
> -	  Technologies Inc SM8550 platform.
> -
>  config PINCTRL_SM8550_LPASS_LPI
>  	tristate "Qualcomm Technologies Inc SM8550 LPASS LPI pin controller driver"
>  	depends on ARM64 || COMPILE_TEST
> diff --git a/drivers/pinctrl/qcom/Kconfig.msm b/drivers/pinctrl/qcom/Kconfig.msm
> new file mode 100644
> index 000000000000..e03042e80a0d
> --- /dev/null
> +++ b/drivers/pinctrl/qcom/Kconfig.msm
> @@ -0,0 +1,360 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +if PINCTRL_MSM
> +
> +config PINCTRL_APQ8064
> +	tristate "Qualcomm APQ8064 pin controller driver"
> +	depends on ARM || COMPILE_TEST
> +	help
> +	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
> +	  Qualcomm TLMM block found in the Qualcomm APQ8064 platform.
> +
> +config PINCTRL_APQ8084
> +	tristate "Qualcomm APQ8084 pin controller driver"
> +	depends on ARM || COMPILE_TEST
> +	help
> +	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
> +	  Qualcomm TLMM block found in the Qualcomm APQ8084 platform.
> +
> +config PINCTRL_IPQ4019
> +	tristate "Qualcomm IPQ4019 pin controller driver"
> +	depends on ARM || COMPILE_TEST
> +	help
> +	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
> +	  Qualcomm TLMM block found in the Qualcomm IPQ4019 platform.
> +
> +config PINCTRL_IPQ8064
> +	tristate "Qualcomm IPQ8064 pin controller driver"
> +	depends on ARM || COMPILE_TEST
> +	help
> +	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
> +	  Qualcomm TLMM block found in the Qualcomm IPQ8064 platform.
> +
> +config PINCTRL_IPQ5332
> +	tristate "Qualcomm Technologies Inc IPQ5332 pin controller driver"
> +	depends on ARM64 || COMPILE_TEST
> +	help
> +	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
> +	  Qualcomm Technologies Inc TLMM block found on the Qualcomm
> +	  Technologies Inc IPQ5332 platform.
> +
> +config PINCTRL_IPQ8074
> +	tristate "Qualcomm Technologies, Inc. IPQ8074 pin controller driver"
> +	depends on ARM64 || COMPILE_TEST
> +	help
> +	  This is the pinctrl, pinmux, pinconf and gpiolib driver for
> +	  the Qualcomm Technologies Inc. TLMM block found on the
> +	  Qualcomm Technologies Inc. IPQ8074 platform. Select this for
> +	  IPQ8074.
> +
> +config PINCTRL_IPQ6018
> +	tristate "Qualcomm Technologies, Inc. IPQ6018 pin controller driver"
> +	depends on ARM64 || COMPILE_TEST
> +	help
> +	  This is the pinctrl, pinmux, pinconf and gpiolib driver for
> +	  the Qualcomm Technologies Inc. TLMM block found on the
> +	  Qualcomm Technologies Inc. IPQ6018 platform. Select this for
> +	  IPQ6018.
> +
> +config PINCTRL_IPQ9574
> +	tristate "Qualcomm Technologies, Inc. IPQ9574 pin controller driver"
> +	depends on ARM64 || COMPILE_TEST
> +	help
> +	  This is the pinctrl, pinmux, pinconf and gpiolib driver for
> +          the Qualcomm Technologies Inc. TLMM block found on the
> +          Qualcomm Technologies Inc. IPQ9574 platform. Select this for
> +          IPQ9574.
> +
> +config PINCTRL_MSM8226
> +	tristate "Qualcomm 8226 pin controller driver"
> +	depends on ARM || COMPILE_TEST
> +	help
> +	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
> +	  Qualcomm Technologies Inc TLMM block found on the Qualcomm
> +	  Technologies Inc MSM8226 platform.
> +
> +config PINCTRL_MSM8660
> +	tristate "Qualcomm 8660 pin controller driver"
> +	depends on ARM || COMPILE_TEST
> +	help
> +	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
> +	  Qualcomm TLMM block found in the Qualcomm 8660 platform.
> +
> +config PINCTRL_MSM8960
> +	tristate "Qualcomm 8960 pin controller driver"
> +	depends on ARM || COMPILE_TEST
> +	help
> +	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
> +	  Qualcomm TLMM block found in the Qualcomm 8960 platform.
> +
> +config PINCTRL_MDM9607
> +	tristate "Qualcomm 9607 pin controller driver"
> +	help
> +	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
> +	  Qualcomm TLMM block found in the Qualcomm 9607 platform.
> +
> +config PINCTRL_MDM9615
> +	tristate "Qualcomm 9615 pin controller driver"
> +	depends on ARM || COMPILE_TEST
> +	help
> +	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
> +	  Qualcomm TLMM block found in the Qualcomm 9615 platform.
> +
> +config PINCTRL_MSM8X74
> +	tristate "Qualcomm 8x74 pin controller driver"
> +	depends on ARM || COMPILE_TEST
> +	help
> +	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
> +	  Qualcomm TLMM block found in the Qualcomm 8974 platform.
> +
> +config PINCTRL_MSM8909
> +	tristate "Qualcomm 8909 pin controller driver"
> +	depends on ARM || COMPILE_TEST
> +	help
> +	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
> +	  Qualcomm TLMM block found on the Qualcomm MSM8909 platform.
> +
> +config PINCTRL_MSM8916
> +	tristate "Qualcomm 8916 pin controller driver"
> +	help
> +	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
> +	  Qualcomm TLMM block found on the Qualcomm 8916 platform.
> +
> +config PINCTRL_MSM8953
> +	tristate "Qualcomm 8953 pin controller driver"
> +	depends on ARM64 || COMPILE_TEST
> +	help
> +	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
> +	  Qualcomm TLMM block found on the Qualcomm MSM8953 platform.
> +	  The Qualcomm APQ8053, SDM450, SDM632 platforms are also
> +	  supported by this driver.
> +
> +config PINCTRL_MSM8976
> +	tristate "Qualcomm 8976 pin controller driver"
> +	depends on ARM64 || COMPILE_TEST
> +	help
> +	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
> +	  Qualcomm TLMM block found on the Qualcomm MSM8976 platform.
> +	  The Qualcomm MSM8956, APQ8056, APQ8076 platforms are also
> +	  supported by this driver.
> +
> +config PINCTRL_MSM8994
> +	tristate "Qualcomm 8994 pin controller driver"
> +	depends on ARM64 || COMPILE_TEST
> +	help
> +	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
> +	  Qualcomm TLMM block found in the Qualcomm 8994 platform. The
> +	  Qualcomm 8992 platform is also supported by this driver.
> +
> +config PINCTRL_MSM8996
> +	tristate "Qualcomm MSM8996 pin controller driver"
> +	depends on ARM64 || COMPILE_TEST
> +	help
> +	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
> +	  Qualcomm TLMM block found in the Qualcomm MSM8996 platform.
> +
> +config PINCTRL_MSM8998
> +	tristate "Qualcomm MSM8998 pin controller driver"
> +	depends on ARM64 || COMPILE_TEST
> +	help
> +	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
> +	  Qualcomm TLMM block found in the Qualcomm MSM8998 platform.
> +
> +config PINCTRL_QCM2290
> +	tristate "Qualcomm QCM2290 pin controller driver"
> +	depends on ARM64 || COMPILE_TEST
> +	help
> +	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
> +	  TLMM block found in the Qualcomm QCM2290 platform.
> +
> +config PINCTRL_QCS404
> +	tristate "Qualcomm QCS404 pin controller driver"
> +	depends on ARM64 || COMPILE_TEST
> +	help
> +	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
> +	  TLMM block found in the Qualcomm QCS404 platform.
> +
> +config PINCTRL_QDF2XXX
> +	tristate "Qualcomm Technologies QDF2xxx pin controller driver"
> +	depends on ACPI
> +	help
> +	  This is the GPIO driver for the TLMM block found on the
> +	  Qualcomm Technologies QDF2xxx SOCs.
> +
> +config PINCTRL_QDU1000
> +	tristate "Qualcomm Technologies Inc QDU1000/QRU1000 pin controller driver"
> +	depends on ARM64 || COMPILE_TEST
> +	help
> +	  This is the pinctrl, pinmux, pinconf, and gpiolib driver for the
> +	  Qualcomm Technologies Inc TLMM block found on the Qualcomm
> +	  Technologies Inc QDU1000 and QRU1000 platforms.
> +
> +config PINCTRL_SA8775P
> +	tristate "Qualcomm Technologies Inc SA8775P pin controller driver"
> +	depends on ARM64 || COMPILE_TEST
> +	help
> +	  This is the pinctrl, pinmux and pinconf driver for the Qualcomm
> +	  TLMM block found on the Qualcomm SA8775P platforms.
> +
> +config PINCTRL_SC7180
> +	tristate "Qualcomm Technologies Inc SC7180 pin controller driver"
> +	depends on ARM64 || COMPILE_TEST
> +	help
> +	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
> +	  Qualcomm Technologies Inc TLMM block found on the Qualcomm
> +	  Technologies Inc SC7180 platform.
> +
> +config PINCTRL_SC7280
> +	tristate "Qualcomm Technologies Inc SC7280 pin controller driver"
> +	depends on ARM64 || COMPILE_TEST
> +	help
> +	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
> +	  Qualcomm Technologies Inc TLMM block found on the Qualcomm
> +	  Technologies Inc SC7280 platform.
> +
> +config PINCTRL_SC8180X
> +	tristate "Qualcomm Technologies Inc SC8180x pin controller driver"
> +	depends on (OF || ACPI)
> +	depends on ARM64 || COMPILE_TEST
> +	help
> +	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
> +	  Qualcomm Technologies Inc TLMM block found on the Qualcomm
> +	  Technologies Inc SC8180x platform.
> +
> +config PINCTRL_SC8280XP
> +	tristate "Qualcomm Technologies Inc SC8280xp pin controller driver"
> +	depends on ARM64 || COMPILE_TEST
> +	help
> +	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
> +	  Qualcomm Technologies Inc TLMM block found on the Qualcomm
> +	  Technologies Inc SC8280xp platform.
> +
> +config PINCTRL_SDM660
> +	tristate "Qualcomm Technologies Inc SDM660 pin controller driver"
> +	depends on ARM64 || COMPILE_TEST
> +	help
> +	 This is the pinctrl, pinmux, pinconf and gpiolib driver for the
> +	 Qualcomm Technologies Inc TLMM block found on the Qualcomm
> +	 Technologies Inc SDM660 platform.
> +
> +config PINCTRL_SDM670
> +	tristate "Qualcomm Technologies Inc SDM670 pin controller driver"
> +	depends on ARM64 || COMPILE_TEST
> +	help
> +	 This is the pinctrl, pinmux, pinconf and gpiolib driver for the
> +	 Qualcomm Technologies Inc TLMM block found on the Qualcomm
> +	 Technologies Inc SDM670 platform.
> +
> +config PINCTRL_SDM845
> +	tristate "Qualcomm Technologies Inc SDM845 pin controller driver"
> +	depends on (OF || ACPI)
> +	depends on ARM64 || COMPILE_TEST
> +	help
> +	 This is the pinctrl, pinmux, pinconf and gpiolib driver for the
> +	 Qualcomm Technologies Inc TLMM block found on the Qualcomm
> +	 Technologies Inc SDM845 platform.
> +
> +config PINCTRL_SDX55
> +	tristate "Qualcomm Technologies Inc SDX55 pin controller driver"
> +	depends on ARM || COMPILE_TEST
> +	help
> +	 This is the pinctrl, pinmux, pinconf and gpiolib driver for the
> +	 Qualcomm Technologies Inc TLMM block found on the Qualcomm
> +	 Technologies Inc SDX55 platform.
> +
> +config PINCTRL_SDX65
> +        tristate "Qualcomm Technologies Inc SDX65 pin controller driver"
> +        depends on ARM || COMPILE_TEST
> +        help
> +         This is the pinctrl, pinmux, pinconf and gpiolib driver for the
> +         Qualcomm Technologies Inc TLMM block found on the Qualcomm
> +         Technologies Inc SDX65 platform.
> +
> +config PINCTRL_SDX75
> +        tristate "Qualcomm Technologies Inc SDX75 pin controller driver"
> +        depends on ARM64 || COMPILE_TEST
> +        help
> +         This is the pinctrl, pinmux, pinconf and gpiolib driver for the
> +         Qualcomm Technologies Inc TLMM block found on the Qualcomm
> +         Technologies Inc SDX75 platform.
> +
> +config PINCTRL_SM6115
> +	tristate "Qualcomm Technologies Inc SM6115,SM4250 pin controller driver"
> +	depends on ARM64 || COMPILE_TEST
> +	help
> +	 This is the pinctrl, pinmux, pinconf and gpiolib driver for the
> +	 Qualcomm Technologies Inc TLMM block found on the Qualcomm
> +	 Technologies Inc SM6115 and SM4250 platforms.
> +
> +config PINCTRL_SM6125
> +	tristate "Qualcomm Technologies Inc SM6125 pin controller driver"
> +	depends on ARM64 || COMPILE_TEST
> +	help
> +	 This is the pinctrl, pinmux, pinconf and gpiolib driver for the
> +	 Qualcomm Technologies Inc TLMM block found on the Qualcomm
> +	 Technologies Inc SM6125 platform.
> +
> +config PINCTRL_SM6350
> +	tristate "Qualcomm Technologies Inc SM6350 pin controller driver"
> +	depends on ARM64 || COMPILE_TEST
> +	help
> +	 This is the pinctrl, pinmux, pinconf and gpiolib driver for the
> +	 Qualcomm Technologies Inc TLMM block found on the Qualcomm
> +	 Technologies Inc SM6350 platform.
> +
> +config PINCTRL_SM6375
> +	tristate "Qualcomm Technologies Inc SM6375 pin controller driver"
> +	depends on ARM64 || COMPILE_TEST
> +	help
> +	 This is the pinctrl, pinmux, pinconf and gpiolib driver for the
> +	 Qualcomm Technologies Inc TLMM block found on the Qualcomm
> +	 Technologies Inc SM6375 platform.
> +
> +config PINCTRL_SM7150
> +	tristate "Qualcomm Technologies Inc SM7150 pin controller driver"
> +	depends on ARM64 || COMPILE_TEST
> +	help
> +	 This is the pinctrl, pinmux, pinconf and gpiolib driver for the
> +	 Qualcomm Technologies Inc TLMM block found on the Qualcomm
> +	 Technologies Inc SM7150 platform.
> +
> +config PINCTRL_SM8150
> +	tristate "Qualcomm Technologies Inc SM8150 pin controller driver"
> +	depends on ARM64 || COMPILE_TEST
> +	help
> +	 This is the pinctrl, pinmux, pinconf and gpiolib driver for the
> +	 Qualcomm Technologies Inc TLMM block found on the Qualcomm
> +	 Technologies Inc SM8150 platform.
> +
> +config PINCTRL_SM8250
> +	tristate "Qualcomm Technologies Inc SM8250 pin controller driver"
> +	depends on ARM64 || COMPILE_TEST
> +	help
> +	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
> +	  Qualcomm Technologies Inc TLMM block found on the Qualcomm
> +	  Technologies Inc SM8250 platform.
> +
> +config PINCTRL_SM8350
> +	tristate "Qualcomm Technologies Inc SM8350 pin controller driver"
> +	depends on ARM64 || COMPILE_TEST
> +	help
> +	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
> +	  Qualcomm Technologies Inc TLMM block found on the Qualcomm
> +	  Technologies Inc SM8350 platform.
> +
> +config PINCTRL_SM8450
> +	tristate "Qualcomm Technologies Inc SM8450 pin controller driver"
> +	depends on ARM64 || COMPILE_TEST
> +	help
> +	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
> +	  Qualcomm Technologies Inc TLMM block found on the Qualcomm
> +	  Technologies Inc SM8450 platform.
> +
> +config PINCTRL_SM8550
> +	tristate "Qualcomm Technologies Inc SM8550 pin controller driver"
> +	depends on ARM64 || COMPILE_TEST
> +	help
> +	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
> +	  Qualcomm Technologies Inc TLMM block found on the Qualcomm
> +	  Technologies Inc SM8550 platform.
> +
> +endif
