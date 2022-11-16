Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37B6462BB71
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 12:22:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233287AbiKPLWQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 06:22:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239240AbiKPLVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 06:21:31 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B718275F3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 03:09:58 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id x2so26052376edd.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 03:09:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y3AIkUjbhZHQbERlIb8ACftzekEImLPfcuCrKs2S1Kg=;
        b=IO8dwIf8lF9DE4pn67EtsbfHPAr3P5KJShr5MQggNYXoMbC73zGaDqpDYp3RcfDYxR
         JcVx7Qcsl55FUP1Ya9Su+ug5Y58CLYbaG/phqWNftftxxswttN1JvhqnJAA8amfU9wUW
         ZJVvyeS9eLwfFpL8KwaQdfSNGwEFJEHSl6bO0iHzSUNI0tVlygTVfcC8W5oLxvP7Ty00
         XVCu13OWSp1ufY1BGQyU8yawg9juLiIMNzlykaUR9dg5QV6xQhbeNVETZzkPDeb10kVg
         /LsBkDqX7clOTksO0zccXyPNi25abVSvgh4ZFYB2FAn/+XhVKmn3Z7KPu0JJFhitr/8H
         n8Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=y3AIkUjbhZHQbERlIb8ACftzekEImLPfcuCrKs2S1Kg=;
        b=2MjUFjLXeulg68byrWXeLJVHFbvWrUl0AGgooiAsWYp6CPE76PEBDNutMAgu33YqnZ
         57x+zMbPAWirXX50a8+ac7jXMBQXBAGWXdyz4D/ayQEVNFgDai5458e8UdldtuQqI/uC
         eTY74letXt9U4ioGBe9/pBEp78dTsmF50TSS1eJzM9/5NVgLjrs+M8TY8oNIFWyBdOLu
         jwEGGfgln13aRtxHRuD++YH9Mj+WyRM4123qnEQGmd+gUtMWNzk2kDNeJQM0ZvV/aeBK
         b8xwHPV4lXNJVAiGE3UDYvObmcMHYA3+O1hAYmHDvP3ZT+yc9zOUSGtPefLnU3E+xDXk
         FJRw==
X-Gm-Message-State: ANoB5pm4yVTtPXfVmcolJuLp2F7XYpnK+xzok+0dKE5oYUzEfmLPHfo3
        3ccLAcMVy+1U4F7depHioDeGc2EIDVpkPQ0c
X-Google-Smtp-Source: AA0mqf5guLVMlcVpNFAHpH7LtcvjeQ/QMeVb5jNr3eoD8KwVXJv+AOcyC2FtBuPq1ccVEtNJ7KCVog==
X-Received: by 2002:aa7:c459:0:b0:461:a278:46e7 with SMTP id n25-20020aa7c459000000b00461a27846e7mr18622392edr.119.1668596996946;
        Wed, 16 Nov 2022 03:09:56 -0800 (PST)
Received: from [192.168.31.208] ([194.29.137.22])
        by smtp.gmail.com with ESMTPSA id j2-20020a17090623e200b00773f3cb67ffsm6710875ejg.28.2022.11.16.03.09.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Nov 2022 03:09:56 -0800 (PST)
Message-ID: <df9a0c7c-e91f-4c5e-e221-a46d24e88d3e@linaro.org>
Date:   Wed, 16 Nov 2022 12:09:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
Subject: Re: [PATCH 09/10] arm64: dts: qcom: Add PMR735d pmic dtsi
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
 <20221116103146.2556846-10-abel.vesa@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221116103146.2556846-10-abel.vesa@linaro.org>
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
> Add nodes for PMR735d in separate dtsi file.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>   arch/arm64/boot/dts/qcom/pmr735d.dtsi | 104 ++++++++++++++++++++++++++
>   1 file changed, 104 insertions(+)
>   create mode 100644 arch/arm64/boot/dts/qcom/pmr735d.dtsi
> 
> diff --git a/arch/arm64/boot/dts/qcom/pmr735d.dtsi b/arch/arm64/boot/dts/qcom/pmr735d.dtsi
> new file mode 100644
> index 000000000000..41fb664a10b3
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/pmr735d.dtsi
> @@ -0,0 +1,104 @@
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
> +		pmr735d-k-thermal {
> +			polling-delay-passive = <100>;
> +			polling-delay = <0>;
> +
> +			thermal-sensors = <&pmr735d_k_temp_alarm>;
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
> +		pmr735d-l-thermal {
> +			polling-delay-passive = <100>;
> +			polling-delay = <0>;
> +
> +			thermal-sensors = <&pmr735d_l_temp_alarm>;
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
> +	pmr735d_k: pmic@a {
> +		compatible = "qcom,pmr735d", "qcom,spmi-pmic";
> +		reg = <0xa SPMI_USID>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		pmr735d_k_temp_alarm: temp-alarm@a00 {
> +			compatible = "qcom,spmi-temp-alarm";
> +			reg = <0xa00>;
> +			interrupts = <0xa 0xa 0x0 IRQ_TYPE_EDGE_BOTH>;
> +			#thermal-sensor-cells = <0>;
> +		};
> +
> +		pmr735d_k_gpios: gpio@8800 {
> +			compatible = "qcom,pmr735d-gpio", "qcom,spmi-gpio";
> +			reg = <0x8800>;
> +			gpio-controller;
> +			gpio-ranges = <&pmr735d_k_gpios 0 0 2>;
> +			#gpio-cells = <2>;
> +			interrupt-controller;
> +			#interrupt-cells = <2>;
> +		};
> +	};
> +
> +	pmr735d_l: pmic@b {
> +		compatible = "qcom,pmr735d", "qcom,spmi-pmic";
> +		reg = <0xb SPMI_USID>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		pmr735d_l_temp_alarm: temp-alarm@a00 {
> +			compatible = "qcom,spmi-temp-alarm";
> +			reg = <0xa00>;
> +			interrupts = <0xb 0xa 0x0 IRQ_TYPE_EDGE_BOTH>;
> +			#thermal-sensor-cells = <0>;
> +		};
> +
> +		pmr735d_l_gpios: gpio@8800 {
> +			compatible = "qcom,pmr735d-gpio", "qcom,spmi-gpio";
> +			reg = <0x8800>;
> +			gpio-controller;
> +			gpio-ranges = <&pmr735d_l_gpios 0 0 2>;
> +			#gpio-cells = <2>;
> +			interrupt-controller;
> +			#interrupt-cells = <2>;
> +		};
> +	};
> +};
