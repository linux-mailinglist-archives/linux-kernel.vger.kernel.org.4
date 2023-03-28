Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E15376CBA17
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 11:06:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232657AbjC1JGT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 05:06:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjC1JGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 05:06:13 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0965D618A
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 02:05:48 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id h25so14861722lfv.6
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 02:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679994346;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=actq2WeTvZHRPO+xuu69UpBHWTSZaC33gGdS9BhQnbU=;
        b=IE6s1bjdunUtEyXnwUhhDsPmmO976NnrXA1824eDJOu01pEbuVlUxL0p5EZVtp18UM
         hHcVOpAoC2UfnipTPBNvxtWFeX8Q1gXIRPQGIZ2I0hgQ2s2PhbncBWkHFEFxeOlnL7Un
         eCGLx1GX1NaCTfHXsSrsroI0zzk93ZlxtoXFJimEJeKSzAZCBkcwAvsWbjO+NIiCkSL5
         ntV7Doj5wdZnZa83XHyCEm/9oMd79t4LOQAAOsOsMKypwKIP426Hxs2Jr7Cb7AmWd2FZ
         Z9tN8chUlkUcm3rt5y0MmZ+STHru1JVlxlX4lFM5CCBmaksvYRrk96TltF7HADXH1Che
         /gwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679994346;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=actq2WeTvZHRPO+xuu69UpBHWTSZaC33gGdS9BhQnbU=;
        b=LsmloTB0DAOGnL5vgMEcpky2Tfry91vBNdJPDiHnb/QrwC0wcmfBdAqh/HEw//3V/k
         12WHPbmTXFIsDob8JQt1oIXnK7LjNDhiaxfAppBSX+6hT43dHP0f9uzglLwkW0cegocF
         gOkLrIPDTfWoHm13wmJDWit+xY1rggPJxvYYZYq1JysAl2gi5Fj4Z8kytCjYZCzyGsSQ
         UsydHuHiLvJz7pEQOAp9Ri4iWBeNU/BFhRUx+3UX9tTD9A57bfEaxDhE+zkpiAsiMUS5
         t9poa0qU3Dp7aj51uReJTsDig940IIcFJ/UmgzO1hFpKiCEfBOxKGKr0N2NoggYwPrbg
         MixA==
X-Gm-Message-State: AAQBX9dEv9vabiuUgBtFUcMH1gDo6BEKwn23a6c8dyvHEQU2cxGOFt5b
        +0XKLwf4nJAkrzVu9b8Dhry8Kg==
X-Google-Smtp-Source: AKy350b3lX7iuODJWlwdYjclhCEAQY5YFrfRRug1ArMpanScrGKDHLzRrDsWL8N5e78e1ygGsd/egg==
X-Received: by 2002:ac2:568f:0:b0:4cc:73ff:579a with SMTP id 15-20020ac2568f000000b004cc73ff579amr4127778lfr.38.1679994346157;
        Tue, 28 Mar 2023 02:05:46 -0700 (PDT)
Received: from [192.168.1.101] (abxj225.neoplus.adsl.tpnet.pl. [83.9.3.225])
        by smtp.gmail.com with ESMTPSA id b28-20020a056512025c00b004cb0dd2367fsm4976465lfo.308.2023.03.28.02.05.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Mar 2023 02:05:45 -0700 (PDT)
Message-ID: <dac2de51-285d-ecb7-f56f-84d139d0a787@linaro.org>
Date:   Tue, 28 Mar 2023 11:05:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 11/18] arm64: dts: qcom: sa8775p: pmic: add thermal
 zones
Content-Language: en-US
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20230327125316.210812-1-brgl@bgdev.pl>
 <20230327125316.210812-12-brgl@bgdev.pl>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230327125316.210812-12-brgl@bgdev.pl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 27.03.2023 14:53, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Add the thermal zones and associated alarm nodes for the PMICs that have
> them hooked up on sa8775p-ride.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/sa8775p-pmics.dtsi | 112 ++++++++++++++++++++
>  1 file changed, 112 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sa8775p-pmics.dtsi b/arch/arm64/boot/dts/qcom/sa8775p-pmics.dtsi
> index 8616ead3daf5..be12997a080c 100644
> --- a/arch/arm64/boot/dts/qcom/sa8775p-pmics.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sa8775p-pmics.dtsi
> @@ -6,6 +6,90 @@
>  #include <dt-bindings/input/input.h>
>  #include <dt-bindings/spmi/spmi.h>
>  
> +/ {
> +	thermal-zones {
> +		pmm8654au_0_thermal: pm8775-0-thermal {
> +			polling-delay-passive = <100>;
> +			polling-delay = <0>;
> +			thermal-sensors = <&pmm8654au_0_temp_alarm>;
> +
> +			trips {
> +				trip0 {
> +					temperature = <105000>;
> +					hysteresis = <0>;
> +					type = "passive";
> +				};
> +
> +				trip1 {
> +					temperature = <125000>;
> +					hysteresis = <0>;
> +					type = "critical";
> +				};
> +			};
> +		};
> +
> +		pmm8654au_1_thermal: pm8775-1-thermal {
> +			polling-delay-passive = <100>;
> +			polling-delay = <0>;
> +			thermal-sensors = <&pmm8654au_1_temp_alarm>;
> +
> +			trips {
> +				trip0 {
> +					temperature = <105000>;
> +					hysteresis = <0>;
> +					type = "passive";
> +				};
> +
> +				trip1 {
> +					temperature = <125000>;
> +					hysteresis = <0>;
> +					type = "critical";
> +				};
> +			};
> +		};
> +
> +		pmm8654au_2_thermal: pm8775-2-thermal {
> +			polling-delay-passive = <100>;
> +			polling-delay = <0>;
> +			thermal-sensors = <&pmm8654au_2_temp_alarm>;
> +
> +			trips {
> +				trip0 {
> +					temperature = <105000>;
> +					hysteresis = <0>;
> +					type = "passive";
> +				};
> +
> +				trip1 {
> +					temperature = <125000>;
> +					hysteresis = <0>;
> +					type = "critical";
> +				};
> +			};
> +		};
> +
> +		pmm8654au_3_thermal: pm8775-3-thermal {
> +			polling-delay-passive = <100>;
> +			polling-delay = <0>;
> +			thermal-sensors = <&pmm8654au_3_temp_alarm>;
> +
> +			trips {
> +				trip0 {
> +					temperature = <105000>;
> +					hysteresis = <0>;
> +					type = "passive";
> +				};
> +
> +				trip1 {
> +					temperature = <125000>;
> +					hysteresis = <0>;
> +					type = "critical";
> +				};
> +			};
> +		};
> +	};
> +};
> +
>  &spmi_bus {
>  	pmm8654au_0: pmic@0 {
>  		compatible = "qcom,pmm8654au", "qcom,spmi-pmic";
> @@ -13,6 +97,13 @@ pmm8654au_0: pmic@0 {
>  		#address-cells = <1>;
>  		#size-cells = <0>;
>  
> +		pmm8654au_0_temp_alarm: temp-alarm@a00 {
> +			compatible = "qcom,spmi-temp-alarm";
> +			reg = <0xa00>;
> +			interrupts-extended = <&spmi_bus 0x0 0xa 0x0 IRQ_TYPE_EDGE_BOTH>;
> +			#thermal-sensor-cells = <0>;
> +		};
> +
>  		pmm8654au_0_pon: pon@1200 {
>  			compatible = "qcom,pmk8350-pon";
>  			reg = <0x1200>, <0x800>;
> @@ -41,6 +132,13 @@ pmm8654au_1: pmic@2 {
>  		reg = <0x2 SPMI_USID>;
>  		#address-cells = <1>;
>  		#size-cells = <0>;
> +
> +		pmm8654au_1_temp_alarm: temp-alarm@a00 {
> +			compatible = "qcom,spmi-temp-alarm";
> +			reg = <0xa00>;
> +			interrupts-extended = <&spmi_bus 0x2 0xa 0x0 IRQ_TYPE_EDGE_BOTH>;
> +			#thermal-sensor-cells = <0>;
> +		};
>  	};
>  
>  	pmm8654au_2: pmic@4 {
> @@ -48,6 +146,13 @@ pmm8654au_2: pmic@4 {
>  		reg = <0x4 SPMI_USID>;
>  		#address-cells = <1>;
>  		#size-cells = <0>;
> +
> +		pmm8654au_2_temp_alarm: temp-alarm@a00 {
> +			compatible = "qcom,spmi-temp-alarm";
> +			reg = <0xa00>;
> +			interrupts-extended = <&spmi_bus 0x4 0xa 0x0 IRQ_TYPE_EDGE_BOTH>;
> +			#thermal-sensor-cells = <0>;
> +		};
>  	};
>  
>  	pmm8654au_3: pmic@6 {
> @@ -55,5 +160,12 @@ pmm8654au_3: pmic@6 {
>  		reg = <0x6 SPMI_USID>;
>  		#address-cells = <1>;
>  		#size-cells = <0>;
> +
> +		pmm8654au_3_temp_alarm: temp-alarm@a00 {
> +			compatible = "qcom,spmi-temp-alarm";
> +			reg = <0xa00>;
> +			interrupts-extended = <&spmi_bus 0x6 0xa 0x0 IRQ_TYPE_EDGE_BOTH>;
> +			#thermal-sensor-cells = <0>;
> +		};
>  	};
>  };
