Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6B4362BB65
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 12:20:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238872AbiKPLUz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 06:20:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239117AbiKPLUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 06:20:36 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 387FF4D5FD
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 03:08:19 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id k2so43226326ejr.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 03:08:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iBGufo3GojFgptHzZEL/TvAeqP6hU5y8xdMNU6zLmCY=;
        b=FneoKNm/siqLtwszSDHNQvetsqZleJWBRFrhe6Xoib2M+JnCeH30iANGfPHavWS3S7
         8okGnGq3VUjUibb5+iXAGCVIsjKIexmhSre1G3uCcrH3DCzjq6gAOQJq/a3tqmra1tGd
         KkLnqEF50N00EBHcvLdcrMuuxn6jMULQ64KTOIN6T5PVYvJqymX9xDizmQus7Xw/GnnC
         DJZXQVCMc08ItegMrKY8Uqz75EaVE35VmjPVBv3a1Bo7zXmT4FS6ZW0jQmJ1Spfmb7nd
         7FdTOw0xkhj42AFUlr47QcqNM1FIHjEVtyj7r2sB/1VM2cL0pQsx4nhs7BPRzoUhuRXZ
         WfRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iBGufo3GojFgptHzZEL/TvAeqP6hU5y8xdMNU6zLmCY=;
        b=2kmbC/0C3P0vogVe5cQ/M/LkWU8M6vcR+bUpMoGXqvlPRTNIlU5AzTeC1za1GE4v+l
         dk2UlLElje0OPkEs7n9palNjoK1JFMUjA7Ahja7rAC2jNKnkSgGo0yoqvErNJnzfEmhF
         Xhp4rqaHZrn8Ta2xgZWCnl/tApDGQMFwovtSMiNUEBveCdNe+uI4jQYWSqBad8W2CNCW
         1QBl0DkPO0+iavnXc08TVzstxaNotfCLwarm5zTMUssAYaUyPy7JG0kgDCZCfkz61Ljv
         B3Nvm9iIL56Sb4mPFL2kDlvG+8x9FFJU6U2wDXnZaDB2iE0CGhUBc+qnpgTtyPsjqNUM
         FNOQ==
X-Gm-Message-State: ANoB5plzkoRGrHr8DlvuGVyrzv35EsoAHj3hXfuupmdSKMPPO7hlbE53
        tx5899NUMc6+wghuXc0tL0f8jA==
X-Google-Smtp-Source: AA0mqf4VVEUBFQhASsEHkYH3tibLdw7XM7uHUsZHSdsn5qlGb2zzO6Km60vWUtSiWLnIMMCTodXDKw==
X-Received: by 2002:a17:907:9d03:b0:7ae:87ef:d9a6 with SMTP id kt3-20020a1709079d0300b007ae87efd9a6mr17310928ejc.397.1668596897736;
        Wed, 16 Nov 2022 03:08:17 -0800 (PST)
Received: from [192.168.31.208] ([194.29.137.22])
        by smtp.gmail.com with ESMTPSA id bc22-20020a056402205600b0045bccd8ab83sm7428684edb.1.2022.11.16.03.08.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Nov 2022 03:08:17 -0800 (PST)
Message-ID: <5d5baf82-7fce-27d9-c8af-22246ed98913@linaro.org>
Date:   Wed, 16 Nov 2022 12:08:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
Subject: Re: [PATCH 07/10] arm64: dts: qcom: Add PM8550vs pmic dtsi
To:     Abel Vesa <abel.vesa@linaro.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
References: <20221116103146.2556846-1-abel.vesa@linaro.org>
 <20221116103146.2556846-8-abel.vesa@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221116103146.2556846-8-abel.vesa@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 16/11/2022 11:31, Abel Vesa wrote:
> From: Neil Armstrong <neil.armstrong@linaro.org>
> 
> Add nodes for PM8550vs in separate dtsi file.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
That's a lot of GPIOs!

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>   arch/arm64/boot/dts/qcom/pm8550vs.dtsi | 194 +++++++++++++++++++++++++
>   1 file changed, 194 insertions(+)
>   create mode 100644 arch/arm64/boot/dts/qcom/pm8550vs.dtsi
> 
> diff --git a/arch/arm64/boot/dts/qcom/pm8550vs.dtsi b/arch/arm64/boot/dts/qcom/pm8550vs.dtsi
> new file mode 100644
> index 000000000000..97b1c18aa7d8
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/pm8550vs.dtsi
> @@ -0,0 +1,194 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Copyright (c) 2022, Linaro Limited
> + */
> +
> +#include <dt-bindings/interrupt-controller/irq.h>
> +#include <dt-bindings/spmi/spmi.h>
> +
> +/ {
> +	thermal-zones {
> +		pm8550vs-c-thermal {
> +			polling-delay-passive = <100>;
> +			polling-delay = <0>;
> +
> +			thermal-sensors = <&pm8550vs_c_temp_alarm>;
> +
> +			trips {
> +				trip0 {
> +					temperature = <95000>;
> +					hysteresis = <0>;
> +					type = "passive";
> +				};
> +
> +				trip1 {
> +					temperature = <115000>;
> +					hysteresis = <0>;
> +					type = "hot";
> +				};
> +			};
> +		};
> +
> +		pm8550vs-d-thermal {
> +			polling-delay-passive = <100>;
> +			polling-delay = <0>;
> +
> +			thermal-sensors = <&pm8550vs_d_temp_alarm>;
> +
> +			trips {
> +				trip0 {
> +					temperature = <95000>;
> +					hysteresis = <0>;
> +					type = "passive";
> +				};
> +
> +				trip1 {
> +					temperature = <115000>;
> +					hysteresis = <0>;
> +					type = "hot";
> +				};
> +			};
> +		};
> +
> +		pm8550vs-e-thermal {
> +			polling-delay-passive = <100>;
> +			polling-delay = <0>;
> +
> +			thermal-sensors = <&pm8550vs_e_temp_alarm>;
> +
> +			trips {
> +				trip0 {
> +					temperature = <95000>;
> +					hysteresis = <0>;
> +					type = "passive";
> +				};
> +
> +				trip1 {
> +					temperature = <115000>;
> +					hysteresis = <0>;
> +					type = "hot";
> +				};
> +			};
> +		};
> +
> +		pm8550vs-g-thermal {
> +			polling-delay-passive = <100>;
> +			polling-delay = <0>;
> +
> +			thermal-sensors = <&pm8550vs_g_temp_alarm>;
> +
> +			trips {
> +				trip0 {
> +					temperature = <95000>;
> +					hysteresis = <0>;
> +					type = "passive";
> +				};
> +
> +				trip1 {
> +					temperature = <115000>;
> +					hysteresis = <0>;
> +					type = "hot";
> +				};
> +			};
> +		};
> +	};
> +};
> +
> +
> +&spmi_bus {
> +	pm8550vs_c: pmic@2 {
> +		compatible = "qcom,pm8550", "qcom,spmi-pmic";
> +		reg = <0x2 SPMI_USID>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		pm8550vs_c_temp_alarm: temp-alarm@a00 {
> +			compatible = "qcom,spmi-temp-alarm";
> +			reg = <0xa00>;
> +			interrupts = <0x2 0xa 0x0 IRQ_TYPE_EDGE_BOTH>;
> +			#thermal-sensor-cells = <0>;
> +		};
> +
> +		pm8550vs_c_gpios: gpio@8800 {
> +			compatible = "qcom,pm8550vs-gpio", "qcom,spmi-gpio";
> +			reg = <0x8800>;
> +			gpio-controller;
> +			gpio-ranges = <&pm8550vs_c_gpios 0 0 6>;
> +			#gpio-cells = <2>;
> +			interrupt-controller;
> +			#interrupt-cells = <2>;
> +		};
> +	};
> +
> +	pm8550vs_d: pmic@3 {
> +		compatible = "qcom,pm8550", "qcom,spmi-pmic";
> +		reg = <0x3 SPMI_USID>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		pm8550vs_d_temp_alarm: temp-alarm@a00 {
> +			compatible = "qcom,spmi-temp-alarm";
> +			reg = <0xa00>;
> +			interrupts = <0x3 0xa 0x0 IRQ_TYPE_EDGE_BOTH>;
> +			#thermal-sensor-cells = <0>;
> +		};
> +
> +		pm8550vs_d_gpios: gpio@8800 {
> +			compatible = "qcom,pm8550vs-gpio", "qcom,spmi-gpio";
> +			reg = <0x8800>;
> +			gpio-controller;
> +			gpio-ranges = <&pm8550vs_d_gpios 0 0 6>;
> +			#gpio-cells = <2>;
> +			interrupt-controller;
> +			#interrupt-cells = <2>;
> +		};
> +	};
> +
> +	pm8550vs_e: pmic@4 {
> +		compatible = "qcom,pm8550", "qcom,spmi-pmic";
> +		reg = <0x4 SPMI_USID>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		pm8550vs_e_temp_alarm: temp-alarm@a00 {
> +			compatible = "qcom,spmi-temp-alarm";
> +			reg = <0xa00>;
> +			interrupts = <0x4 0xa 0x0 IRQ_TYPE_EDGE_BOTH>;
> +			#thermal-sensor-cells = <0>;
> +		};
> +
> +		pm8550vs_e_gpios: gpio@8800 {
> +			compatible = "qcom,pm8550vs-gpio", "qcom,spmi-gpio";
> +			reg = <0x8800>;
> +			gpio-controller;
> +			gpio-ranges = <&pm8550vs_e_gpios 0 0 6>;
> +			#gpio-cells = <2>;
> +			interrupt-controller;
> +			#interrupt-cells = <2>;
> +		};
> +	};
> +
> +	pm8550vs_g: pmic@6 {
> +		compatible = "qcom,pm8550", "qcom,spmi-pmic";
> +		reg = <0x6 SPMI_USID>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		pm8550vs_g_temp_alarm: temp-alarm@a00 {
> +			compatible = "qcom,spmi-temp-alarm";
> +			reg = <0xa00>;
> +			interrupts = <0x6 0xa 0x0 IRQ_TYPE_EDGE_BOTH>;
> +			#thermal-sensor-cells = <0>;
> +		};
> +
> +		pm8550vs_g_gpios: gpio@8800 {
> +			compatible = "qcom,pm8550vs-gpio", "qcom,spmi-gpio";
> +			reg = <0x8800>;
> +			gpio-controller;
> +			gpio-ranges = <&pm8550vs_g_gpios 0 0 6>;
> +			#gpio-cells = <2>;
> +			interrupt-controller;
> +			#interrupt-cells = <2>;
> +		};
> +	};
> +};
