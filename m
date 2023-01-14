Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E9FE66ADAD
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 21:33:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230402AbjANUdm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Jan 2023 15:33:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbjANUda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jan 2023 15:33:30 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DA9EBBBB
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jan 2023 12:33:24 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id bp15so37665565lfb.13
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jan 2023 12:33:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nXkS2If6qTef+vO7gMGdMC2qAZHc0aG1VWSDm/FYonk=;
        b=HoQV83KgOGb/i5lSpQPTSRYFfNBQzJYOJNN/2DbIEjFKfpI41ae7f95bIVGIThdmSX
         O/DOpE5iVjdyChjwbfg4qp8kAzNGDCk5gR0B8qxSXtuy3oj30vwfrU+YWldMKNPxb4Bc
         fjQ+oY6hcVQSakoIHebwEyvLscPTJb6j/E6/quODpN3QkwlMnDmmAdW+u5zc+1RyTKyh
         vXCqa/6DDDQFA0WWVMN3GVZhpoQ6+8pft8vCxklRfxd+Laa1vWVVtDtZBJaEO7A2HbFp
         X+6dfH7zOXLmhs7HO3c+8tXmid7RT90pVaICfwyI2KKjqRaRwgcQtr0YFYBfNkxRVRuv
         y8DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nXkS2If6qTef+vO7gMGdMC2qAZHc0aG1VWSDm/FYonk=;
        b=weCqz5YDfcnomrnhoX2MG9GaI6fi4hpdq7y9wXqGjTtrTJOV4G4r3umpJC79/XmevN
         eicW1zznh2pOVQ2QgMOcd87VvZNvDrkGPGrrInEeenlmU2ZSeHbX4xoV5LlMA2G6CN7a
         iacRF+YBrsJ/EY6EJgb8grxWND3XI0cZX3jnCIFF6UsMZG73jsk9K2ExSqc1BUu31xMG
         h8e6LQVE9XBL5+WDhNxCLnLw7n7sTTCHJMvZkcNpaJC2Mk2Doe1mbruIstOkXY2bru75
         LYWPV/W2Tv15pFjvIvYPS7dB1AimTpG5KH69ccDpj6IREeCT5T6n055GwtHTmOFcdTDl
         eVzA==
X-Gm-Message-State: AFqh2ko3SGGEHgNoBBKHNTP8lv+VGVxQf/TaJ2nlwfaAdxxec+0LdHjJ
        MBWMg3TfBszohQrEMi24xzQKHw==
X-Google-Smtp-Source: AMrXdXtpU/V4tryPhFR1oR7YZImSzHwOovLbDe+uYk6VN7sY3mboyWUnuXKPtJVOiWpVQiw8zRl+mA==
X-Received: by 2002:a19:6a14:0:b0:4bc:af5:b8d9 with SMTP id u20-20020a196a14000000b004bc0af5b8d9mr1399122lfu.6.1673728402799;
        Sat, 14 Jan 2023 12:33:22 -0800 (PST)
Received: from [192.168.1.101] (abym53.neoplus.adsl.tpnet.pl. [83.9.32.53])
        by smtp.gmail.com with ESMTPSA id br35-20020a056512402300b004b5478d8222sm4406924lfb.184.2023.01.14.12.33.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Jan 2023 12:33:22 -0800 (PST)
Message-ID: <e3c367ba-b752-d116-0b84-fd2437e565b8@linaro.org>
Date:   Sat, 14 Jan 2023 21:33:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 2/6] arm64: dts: qcom: sdm845: move WCD9340 codec to
 separate file
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230113162245.117324-1-krzysztof.kozlowski@linaro.org>
 <20230113162245.117324-2-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230113162245.117324-2-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 13.01.2023 17:22, Krzysztof Kozlowski wrote:
> WCD9340 codec node is not a property of the SoC, but board.  Move it to
> separate file and include it in the specific boards.  On all others,
> keep the Slimbus node disabled as it is empty.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
Generally this should be SoC-independent, for example some newer
MSM8998 devices shipped with the 9340 codec that most 845 devices
used, but earlier ones used the WCD9335 found on MSM8996

Konrad
>  .../boot/dts/qcom/sdm845-audio-wcd9340.dtsi   | 69 +++++++++++++++++++
>  arch/arm64/boot/dts/qcom/sdm845-db845c.dts    |  1 +
>  .../qcom/sdm845-xiaomi-beryllium-common.dtsi  |  1 +
>  .../boot/dts/qcom/sdm845-xiaomi-polaris.dts   |  1 +
>  arch/arm64/boot/dts/qcom/sdm845.dtsi          | 60 +---------------
>  .../boot/dts/qcom/sdm850-lenovo-yoga-c630.dts |  1 +
>  .../boot/dts/qcom/sdm850-samsung-w737.dts     |  1 +
>  7 files changed, 75 insertions(+), 59 deletions(-)
>  create mode 100644 arch/arm64/boot/dts/qcom/sdm845-audio-wcd9340.dtsi
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-audio-wcd9340.dtsi b/arch/arm64/boot/dts/qcom/sdm845-audio-wcd9340.dtsi
> new file mode 100644
> index 000000000000..5bcce7d0d709
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sdm845-audio-wcd9340.dtsi
> @@ -0,0 +1,69 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * SDM845 SoC device tree source
> + *
> + * Copyright (c) 2018, The Linux Foundation. All rights reserved.
> + */
> +
> +&slim {
> +	status = "okay";
> +
> +	slim@1 {
> +		reg = <1>;
> +		#address-cells = <2>;
> +		#size-cells = <0>;
> +
> +		wcd9340_ifd: ifd@0,0 {
> +			compatible = "slim217,250";
> +			reg = <0 0>;
> +		};
> +
> +		wcd9340: codec@1,0 {
> +			compatible = "slim217,250";
> +			reg = <1 0>;
> +			slim-ifc-dev = <&wcd9340_ifd>;
> +
> +			#sound-dai-cells = <1>;
> +
> +			interrupts-extended = <&tlmm 54 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-controller;
> +			#interrupt-cells = <1>;
> +
> +			#clock-cells = <0>;
> +			clock-frequency = <9600000>;
> +			clock-output-names = "mclk";
> +			qcom,micbias1-microvolt = <1800000>;
> +			qcom,micbias2-microvolt = <1800000>;
> +			qcom,micbias3-microvolt = <1800000>;
> +			qcom,micbias4-microvolt = <1800000>;
> +
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +
> +			wcdgpio: gpio-controller@42 {
> +				compatible = "qcom,wcd9340-gpio";
> +				gpio-controller;
> +				#gpio-cells = <2>;
> +				reg = <0x42 0x2>;
> +			};
> +
> +			swm: swm@c85 {
> +				compatible = "qcom,soundwire-v1.3.0";
> +				reg = <0xc85 0x40>;
> +				interrupts-extended = <&wcd9340 20>;
> +
> +				qcom,dout-ports = <6>;
> +				qcom,din-ports = <2>;
> +				qcom,ports-sinterval-low = /bits/ 8  <0x07 0x1f 0x3f 0x7 0x1f 0x3f 0x0f 0x0f>;
> +				qcom,ports-offset1 = /bits/ 8 <0x01 0x02 0x0c 0x6 0x12 0x0d 0x07 0x0a>;
> +				qcom,ports-offset2 = /bits/ 8 <0x00 0x00 0x1f 0x00 0x00 0x1f 0x00 0x00>;
> +
> +				#sound-dai-cells = <1>;
> +				clocks = <&wcd9340>;
> +				clock-names = "iface";
> +				#address-cells = <2>;
> +				#size-cells = <0>;
> +			};
> +		};
> +	};
> +};
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
> index 6b355589edb3..3726465acbde 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
> +++ b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
> @@ -11,6 +11,7 @@
>  #include <dt-bindings/sound/qcom,q6afe.h>
>  #include <dt-bindings/sound/qcom,q6asm.h>
>  #include "sdm845.dtsi"
> +#include "sdm845-audio-wcd9340.dtsi"
>  #include "pm8998.dtsi"
>  #include "pmi8998.dtsi"
>  
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi
> index 64de4ed9b0c8..e530a676b250 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi
> @@ -7,6 +7,7 @@
>  #include <dt-bindings/sound/qcom,q6afe.h>
>  #include <dt-bindings/sound/qcom,q6asm.h>
>  #include "sdm845.dtsi"
> +#include "sdm845-audio-wcd9340.dtsi"
>  #include "pm8998.dtsi"
>  #include "pmi8998.dtsi"
>  
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts
> index a80c3dd9a2da..f81619c8a3ba 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts
> +++ b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts
> @@ -13,6 +13,7 @@
>  #include <dt-bindings/sound/qcom,q6afe.h>
>  #include <dt-bindings/sound/qcom,q6asm.h>
>  #include "sdm845.dtsi"
> +#include "sdm845-audio-wcd9340.dtsi"
>  #include "pm8998.dtsi"
>  #include "pmi8998.dtsi"
>  #include "pm8005.dtsi"
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index 4c256431280a..f9b1d7a60fd6 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -3831,65 +3831,7 @@ slim: slim-ngd@171c0000 {
>  			iommus = <&apps_smmu 0x1806 0x0>;
>  			#address-cells = <1>;
>  			#size-cells = <0>;
> -
> -			slim@1 {
> -				reg = <1>;
> -				#address-cells = <2>;
> -				#size-cells = <0>;
> -
> -				wcd9340_ifd: ifd@0,0 {
> -					compatible = "slim217,250";
> -					reg = <0 0>;
> -				};
> -
> -				wcd9340: codec@1,0 {
> -					compatible = "slim217,250";
> -					reg = <1 0>;
> -					slim-ifc-dev = <&wcd9340_ifd>;
> -
> -					#sound-dai-cells = <1>;
> -
> -					interrupts-extended = <&tlmm 54 IRQ_TYPE_LEVEL_HIGH>;
> -					interrupt-controller;
> -					#interrupt-cells = <1>;
> -
> -					#clock-cells = <0>;
> -					clock-frequency = <9600000>;
> -					clock-output-names = "mclk";
> -					qcom,micbias1-microvolt = <1800000>;
> -					qcom,micbias2-microvolt = <1800000>;
> -					qcom,micbias3-microvolt = <1800000>;
> -					qcom,micbias4-microvolt = <1800000>;
> -
> -					#address-cells = <1>;
> -					#size-cells = <1>;
> -
> -					wcdgpio: gpio-controller@42 {
> -						compatible = "qcom,wcd9340-gpio";
> -						gpio-controller;
> -						#gpio-cells = <2>;
> -						reg = <0x42 0x2>;
> -					};
> -
> -					swm: swm@c85 {
> -						compatible = "qcom,soundwire-v1.3.0";
> -						reg = <0xc85 0x40>;
> -						interrupts-extended = <&wcd9340 20>;
> -
> -						qcom,dout-ports = <6>;
> -						qcom,din-ports = <2>;
> -						qcom,ports-sinterval-low = /bits/ 8  <0x07 0x1f 0x3f 0x7 0x1f 0x3f 0x0f 0x0f>;
> -						qcom,ports-offset1 = /bits/ 8 <0x01 0x02 0x0c 0x6 0x12 0x0d 0x07 0x0a>;
> -						qcom,ports-offset2 = /bits/ 8 <0x00 0x00 0x1f 0x00 0x00 0x1f 0x00 0x00>;
> -
> -						#sound-dai-cells = <1>;
> -						clocks = <&wcd9340>;
> -						clock-names = "iface";
> -						#address-cells = <2>;
> -						#size-cells = <0>;
> -					};
> -				};
> -			};
> +			status = "disabled";
>  		};
>  
>  		lmh_cluster1: lmh@17d70800 {
> diff --git a/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts b/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
> index d9581f4440b3..5586c95aa1ff 100644
> --- a/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
> +++ b/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
> @@ -13,6 +13,7 @@
>  #include <dt-bindings/sound/qcom,q6afe.h>
>  #include <dt-bindings/sound/qcom,q6asm.h>
>  #include "sdm850.dtsi"
> +#include "sdm845-audio-wcd9340.dtsi"
>  #include "pm8998.dtsi"
>  
>  /*
> diff --git a/arch/arm64/boot/dts/qcom/sdm850-samsung-w737.dts b/arch/arm64/boot/dts/qcom/sdm850-samsung-w737.dts
> index 6730804f4e3e..40223704a2c7 100644
> --- a/arch/arm64/boot/dts/qcom/sdm850-samsung-w737.dts
> +++ b/arch/arm64/boot/dts/qcom/sdm850-samsung-w737.dts
> @@ -14,6 +14,7 @@
>  #include <dt-bindings/sound/qcom,q6afe.h>
>  #include <dt-bindings/sound/qcom,q6asm.h>
>  #include "sdm850.dtsi"
> +#include "sdm845-audio-wcd9340.dtsi"
>  #include "pm8998.dtsi"
>  
>  /*
